# Este script implementa un endpoint HTTP en Azure Functions llamado `ListarVotos`.
# Su objetivo es autenticar al usuario mediante su cédula, validar su MFA y documentos,
# y luego retornar sus 5 votos más recientes, incluyendo la propuesta votada, la fecha y la opción elegida.

# ————————————————————————————————
# 1. IMPORTACIÓN DE DEPENDENCIAS
# ————————————————————————————————

# Funciones HTTP de Azure
import azure.functions as func
# Manejo de JSON para entrada/salida de datos
import json
# Registro de logs para depuración
import logging
# Funciones SQL textuales para ejecución directa
from sqlalchemy import text
# Objeto de sesión para conectar con la base de datos
from database import SessionLocal
# Variables de entorno (clave de desencriptación)
import os

# Modelos ORM que representan las tablas de la base de datos
from Models.users import VpvUser
from Models.ListarVotos.vpv_mfa import VpvMfa
from Models.ListarVotos.vpv_identitydocs import VpvIdentityDoc
from Models.ListarVotos.vpv_Voter import VpvVoter
from Models.ListarVotos.vpv_Votes import VpvVotes
from Models.ListarVotos.vpv_optionsQuestion import VpvOptionsQuestion
from Models.Configuracion_Votacion.votingConfing import VotingConfiguration
from Models.Configuracion_Votacion.proposalVersion import VpvProposalVersions

# Se extrae del entorno la clave que permite abrir la llave simétrica para desencriptar la cédula
clave = os.getenv("CLAVECEDULA")


# —————————————————————————————————————————
# 2. FUNCIÓN PRINCIPAL - ListarVotos
# —————————————————————————————————————————
def ListarVotos(req: func.HttpRequest) -> func.HttpResponse:
    # Log inicial para depuración
    logging.info("ListarVotos iniciado...")

    # Verifica que el método HTTP sea POST (único permitido)
    if req.method != "POST":
        return func.HttpResponse("Método no permitido. Use POST.", status_code=405)

    # Se inicia la sesión de base de datos (equivalente a una conexión)
    session = SessionLocal()
    try:
        #vSe intenta obtener el cuerpo de la solicitud (esperado en JSON)
        body = req.get_json()
        id_card = body.get("id_card")

        # Validación obligatoria: debe incluirse la cédula
        if not id_card:
            return func.HttpResponse("Falta id_card en el cuerpo de la petición.", status_code=400)

        # ——————————————————————————————————————————————
        # 3. DESENCRIPTAR LA CÉDULA Y BUSCAR AL USUARIO
        # ——————————————————————————————————————————————

        # TABLAS INVOLUCRADAS:
        # vpv_Users: Tabla de los usuarios, aquí en este caso para encontrar el usuario utilizamos la cédula
        # esta cédula está encriptada, la desencriptamos con "llavecedula" cuya clave es "clavecedula"

        # Abrir la llave simétrica con la contraseña proporcionada en entorno
        sql = f"OPEN SYMMETRIC KEY llavecedula DECRYPTION BY PASSWORD = '{clave}'"
        session.execute(text(sql))

        # Ejecutar consulta para buscar usuario activo cuya cédula (encriptada) coincida con la proporcionada
        result = session.execute(text("""
            SELECT idUser
            FROM vpv_Users
            WHERE enable = 1
              AND CONVERT(nvarchar(50), DECRYPTBYKEY(id_card)) = :idCard
        """), {"idCard": id_card})
        row = result.fetchone()

        # Cierra inmediatamente la llave tras su uso (buena práctica de seguridad)
        session.execute(text("CLOSE SYMMETRIC KEY llavecedula;"))

        # Si no se encontró el usuario, se notifica al cliente
        if not row:
            return func.HttpResponse(
                f"No existe usuario activo con cédula {id_card}.", status_code=404
            )
        # Se guarda el ID del usuario identificado
        idUsuario = row[0]

        # ——————————————————————————————————————————————
        # 4. VERIFICAR QUE EL USUARIO TENGA MFA HABILITADO
        # ——————————————————————————————————————————————

        # TABLAS INVOLUCRADAS:
        # vpv_mfa: Son datos biómetricos o formas de autenticación, en este caso para validar la identidad
        # del usuario verificamos que tenga al menos un MFA activado

        mfa = session.query(VpvMfa).filter_by(userid=idUsuario).first()
        if not mfa or not mfa.enable:
            return func.HttpResponse("MFA no habilitado para este usuario.", status_code=403)

        # ——————————————————————————————————————————————————————
        # 5. VERIFICAR QUE TENGA UN DOCUMENTO DE IDENTIDAD VÁLIDO
        # ——————————————————————————————————————————————————————

        # TABLAS INVOLUCRADAS:
        # vpv_identitydocs: Tabla que guarda identificaciones, NO ARCHIVOS, sino categorías, en este caso busca que
        # el usuario tenga al menos una cédula, pasaporte o licencia que verifique su identidad y esté habilitada.
        # vpv_identitystates: Tabla que indica el estado de una licencia, cédula o pasaporte, 1 = Aprobado

        doc = (
            session.query(VpvIdentityDoc)
            .filter_by(
                referenceid="idUser",
                referencevalue=idUsuario,
                enable=True,
                identitystateid=1  # Solo documentos verificados
            )
            .filter(VpvIdentityDoc.name.in_([
                "Cédula de identidad", "Pasaporte", "Licencia de conducir"
            ]))
            .first()
        )

        # Si no tiene documento verificado, se rechaza el acceso
        if not doc:
            return func.HttpResponse(
                "Usuario no tiene documento verificado (cédula/pasaporte/licencia).",
                status_code=403
            )

        # ——————————————————————————————————————————————
        # 6. BUSCAR EL REGISTRO DE VOTANTE ASOCIADO AL USUARIO
        # ——————————————————————————————————————————————

        # TABLAS INVOLUCRADAS:
        # vpv_voter: Tablar que relacionado los votos con el usuario, la utilizamos para llegar de vpv_Users a vpv_Votes.
        # En este caso guardamos en idVotador el id que nos sirve para relacionar vpv_Votes

        voter = session.query(VpvVoter).filter_by(idUser=idUsuario).first()
        if not voter:
            return func.HttpResponse("Usuario no registrado como votante.", status_code=404)

        # Guardar el ID del votante para futuras consultas
        idVotador = voter.idVoter

        # ——————————————————————————————————————————————————
        # 7. CONSULTAR LOS ÚLTIMOS 5 VOTOS DEL USUARIO
        # ——————————————————————————————————————————————————

        # TABLAS INVOLUCRADAS:
        # vpv_Votes: Esta tabla guarda la información respecto a las votaciones de un usuario, la utilizamos para 
        # llegar a vpv_votingConfigurations y a vpv_OptinosQuestions

        votos = (
            session.query(VpvVotes)
            .filter_by(idVoter=idVotador)
            .order_by(VpvVotes.creationDate.desc())  # Orden más reciente primero
            .limit(5)
            .all()
        )

        resultado = []  # Lista que almacenará los votos a devolver

        # ——————————————————————————————————————————————————————
        # 8. RECORRER CADA VOTO Y OBTENER INFORMACIÓN DETALLADA
        # ——————————————————————————————————————————————————————

        # TABLAS INVOLUCRADAS:
        # vpv_VotingConfiguration: Guarda la configuración de la votación y permite llega a vpv_ProposalVersions
        # vpv_ProposalVersions: Esta tabla guarda versiones de la propuesta, en este caso la utilizamos para
        # saber a que propuesta voto el usuario.
        # vpv_OptionsQuestions: Guarda las respuestas de las votaciones, la utilizamos para ver lo que voto el usuario.

        for v in votos:
            # Traer configuración de votación para ese voto
            config = session.query(VotingConfiguration).get(v.idVotingConfig)
            # Traer la propuesta asociada a esa configuración
            propuesta = session.query(VpvProposalVersions).get(config.proposalVersionId)
            # Traer la opción que el usuario eligió en esa votación
            opcion = session.query(VpvOptionsQuestion.value).filter_by(idOptionQuestion=v.idOptionQuestion).first()

            # Agregar datos al resultado final (nombre de propuesta, fecha, decisión)
            resultado.append({
                "propuesta": propuesta.tittle if propuesta else None,
                "fecha": v.creationDate.isoformat() if v.creationDate else None,
                "decision": opcion[0] if opcion else None
            })

        # Devolver la lista de votos en formato JSON al cliente
        return func.HttpResponse(
            json.dumps(resultado),
            status_code=200,
            headers={"Content-Type": "application/json"}
        )

    # ————————————————————————————————
    # 9. MANEJO DE ERRORES INTERNOS
    # ————————————————————————————————
    except Exception as e:
        # Registrar el error en el log y deshacer cualquier cambio en la base de datos
        logging.exception("Error interno")
        session.rollback()
        return func.HttpResponse("Error interno del servidor.", status_code=500)

    # ————————————————————————————————
    # 10. CIERRE DE SESIÓN DE BASE DE DATOS
    # ————————————————————————————————
    finally:
        session.close()  # Cierra la conexión con la base de datos
