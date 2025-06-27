import azure.functions as func
import json
import logging
from sqlalchemy import text
from database import SessionLocal
import os #utilizado para variables de entorno
from Models.users import VpvUser
from Models.ListarVotos.vpv_mfa import VpvMfa
from Models.ListarVotos.vpv_identitydocs import VpvIdentityDoc
from Models.ListarVotos.vpv_Voter import VpvVoter
from Models.ListarVotos.vpv_Votes import VpvVotes
from Models.ListarVotos.vpv_optionsQuestion import VpvOptionsQuestion

from Models.Configuracion_Votacion.votingConfing import VotingConfiguration
from Models.Configuracion_Votacion.proposalVersion import VpvProposalVersions


# Clave para desencriptar (asegúrate de cargarla con dotenv como en tu ejemplo)
clave = os.getenv("CLAVECEDULA")

def ListarVotos(req: func.HttpRequest) -> func.HttpResponse:
    logging.info("ListarVotos iniciado...")
    if req.method != "POST":
        return func.HttpResponse("Método no permitido. Use POST.", status_code=405)

    session = SessionLocal()
    try:
        body = req.get_json()
        id_card = body.get("id_card")
        if not id_card:
            return func.HttpResponse("Falta id_card en el cuerpo de la petición.", status_code=400)

        # —————————————————————————————
        # 1) Abrir llave y desencriptar para buscar idUsuario
        # —————————————————————————————
        sql = f"OPEN SYMMETRIC KEY llavecedula DECRYPTION BY PASSWORD = '{clave}'"
        session.execute(text(sql))

        result = session.execute(text("""
            SELECT idUser
            FROM vpv_Users
            WHERE enable = 1
              AND CONVERT(nvarchar(50), DECRYPTBYKEY(id_card)) = :idCard
        """), {"idCard": id_card})
        row = result.fetchone()

        # Cerrar llave inmediatamente tras la consulta
        session.execute(text("CLOSE SYMMETRIC KEY llavecedula;"))

        if not row:
            return func.HttpResponse(
                f"No existe usuario activo con cédula {id_card}.", status_code=404
            )
        idUsuario = row[0]

        # 2) Validar MFA habilitado
        mfa = session.query(VpvMfa).filter_by(userid=idUsuario).first()
        if not mfa or not mfa.enable:
            return func.HttpResponse("MFA no habilitado para este usuario.", status_code=403)

        # 3) Validar documento de identidad válido
        doc = (
            session.query(VpvIdentityDoc)
            .filter_by(
                referenceid="idUser",
                referencevalue=idUsuario,
                enable=True,
                identitystateid=1
            )
            .filter(VpvIdentityDoc.name.in_(["Cédula de identidad", "Pasaporte", "Licencia de conducir"]))
            .first()
        )
        if not doc:
            return func.HttpResponse(
                "Usuario no tiene documento verificado (cédula/pasaporte/licencia).",
                status_code=403
            )

        # 4) Obtener el idVotador
        voter = session.query(VpvVoter).filter_by(idUser=idUsuario).first()
        if not voter:
            return func.HttpResponse("Usuario no registrado como votante.", status_code=404)
        idVotador = voter.idVoter

        # 5) Traer los últimos 5 votos
        votos = (
            session.query(VpvVotes)
            .filter_by(idVoter=idVotador)
            .order_by(VpvVotes.creationDate.desc())
            .limit(5)
            .all()
        )
        resultado = []
        for v in votos:
            config = session.query(VotingConfiguration).get(v.idVotingConfig)
            propuesta = session.query(VpvProposalVersions).get(config.proposalVersionId)
            opcion = session.query(VpvOptionsQuestion).get(v.idOptionQuestion)

            resultado.append({
                "propuesta": propuesta.tittle,
                "fecha": v.creationDate.isoformat(),
                "decision": opcion.value
            })

        return func.HttpResponse(
            json.dumps(resultado),
            status_code=200,
            mimetype="application/json"
        )

    except Exception as e:
        logging.exception("Error interno")
        session.rollback()
        return func.HttpResponse("Error interno del servidor.", status_code=500)
    finally:
        session.close()
