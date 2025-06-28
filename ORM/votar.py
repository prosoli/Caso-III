import json
import logging
from datetime import datetime

import azure.functions as func
from database import SessionLocal
from Models.votar.models import User, Voter


from helpers.votar.insertLogs import insertLog
from helpers.votar.obtenerIdUser import obtenerIdUser
from helpers.votar.user_can import user_can
from helpers.votar.obtener_preguntas_por_nombre import obtener_preguntas_por_nombre
from helpers.votar.is_date_within_voting_window import is_date_within_voting_window
from helpers.votar.get_votes_id import get_next_vote_id, get_next_votes_taken_id, get_next_vote_value_id
from helpers.votar.insert_votes import insert_votes
from helpers.votar.mark_token_used import mark_token_used
from helpers.votar.generate_blind_token import generate_blind_token

from Endpoints_ORM.validarPermisos import validar_permiso


def votar(req: func.HttpRequest) -> func.HttpResponse:
    logging.info('Procesando solicitud de permiso (votar).')

    ################################
    ## 1) Parsear JSON de entrada ##
    ################################
    try:
        # Intentamos leer el cuerpo de la petición como JSON
        body = req.get_json()
    except ValueError:
        # Si falla, devolvemos 400 Bad Request
        return func.HttpResponse("JSON inválido.", status_code=400)

    # Extraemos los campos dentro del json
    id_card  = body.get("auth", {}).get("cedula")
    password = body.get("auth", {}).get("password")
    token = body.get("auth", {}).get("mfa", {}).get("code")
    proposal_name   = body.get("proposalName")
    version_name    = body.get("proposalVersionName")
    votos_list      = body.get("votos", [])
    date_str        = body.get("date")


    #############################
    ## 2) Validaciones básicas ##
    #############################
    # Verificamos que ninguno de los campos críticos sea None o cadena vacía
    if not all([id_card, password, proposal_name, version_name, date_str]):
        return func.HttpResponse(
            "Faltan campos obligatorios en el JSON.",
            status_code=400
        )
        
    #######################
    ## Obtener el idUser ##
    #######################
    try:
         # Convertimos la cedula en un idUser llamando a helper
        user_id = obtenerIdUser(id_card)
    except Exception:
        # Si falla, devolvemos error personalizado
        return func.HttpResponse(
            json.dumps({"error": "No se pudo obtener el idUser."}, ensure_ascii=False), 
            status_code=400, 
            mimetype="application/json"
        )

    # convertir fecha
    try:
        date_to_check = datetime.fromisoformat(date_str)
    except Exception:
        # Fecha con formato invalido
        return func.HttpResponse(
            json.dumps({"error": "Formato de fecha inválido."}, ensure_ascii=False), 
            status_code=400, 
            mimetype="application/json"
        )


    ################################################
    ## 3) Verificar existencia activa del usuario ##
    ################################################
    try:
        with SessionLocal() as session:
            # Buscamos el usuario en la BD y comprobamos flags enable/deleted
            user = session.get(User, user_id)
            if not user or not user.enable or user.deleted:
                return func.HttpResponse(
                    json.dumps({"error": "Usuario no activo"}, ensure_ascii=False),
                    status_code=200,
                    mimetype="application/json"
                )
    except Exception as e:
        logging.error(f"Error al verificar usuario: {e}")
        return func.HttpResponse(f"Error interno: {e}", status_code=500)


    ################################################
    ## 4) Verificar permisos CRUD sobre las tabla ##
    ################################################  
    try:
        with SessionLocal() as session:
            # Validacion de rol "Ciudadano"
            validar_permiso(session, id_card, 'Ciudadano')
    except PermissionError as e:
        # Si no pasa validacion de rol, devolvemos 403
        return func.HttpResponse(
            json.dumps({"error": str(e)}),
            status_code=403,
            mimetype="application/json"
        )    
    
    try:
        # Define aquí todas las verificaciones que quieras hacer:
        # Lista de (tabla, acción) a verificar
        permisos = [
            ("vpv_votingConfigurations", "SELECT"),
            ("vpv_encryptionkeys",       "SELECT"),
            ("vpv_proposals",            "SELECT"),
            ("vpv_proposalVersions",     "SELECT"),
            ("vpv_PopulationFilters",    "SELECT"),
            ("vpv_TargetPopulations",    "SELECT"),
            ("vpv_TargetPopulationsVoting","SELECT"),
            ("vpv_FilterTypes",          "SELECT"),
            ("vpv_demographics",         "SELECT"),
            ("vpv_votingQuestions",      "SELECT"),
            ("vpv_optionsQuestion",      "SELECT"),
            ("vpv_BlindTokens",          "INSERT"),
            ("vpv_VotesTaken",           "SELECT"),
            ("vpv_VotesTaken",           "INSERT"),
            ("vpv_Votes",                "INSERT"),
            ("vpv_voteValues",           "INSERT"),
        ]

        for recurso, accion in permisos:
            # Iteramos y verificamos cada permiso con user_can()
            if not user_can(user_id, recurso, accion):
                body = {
                    "error":  "Sin permiso sobre el recurso",
                    "recurso": recurso,
                    "accion":  accion
                }
                return func.HttpResponse(
                    json.dumps(body, ensure_ascii=False),
                    status_code=200,
                    mimetype="application/json"
                )
    except Exception as e:
        logging.error(f"Error al verificar permiso: {e}")
        return func.HttpResponse(f"Error interno: {e}", status_code=500)


    ###############################################
    ## 5) Obtener preguntas y opciones filtradas ##
    ###############################################
    try:
        # Llamamos al helper que lee preguntas desde JSON y tablas
        resultado = obtener_preguntas_por_nombre(
            user_id=user_id,
            proposal_name=proposal_name,
            version_name=version_name,
            votos_list=votos_list
        )
        # Extraemos IDs y lista de votos ya validados y mapeados que necesitamos para otras funciones
        proposalId = resultado["proposalId"]
        proposalVersionId = resultado["proposalVersionId"]
        votos = resultado["votos"]
    except Exception as e:
        logging.error(f"Error al obtener preguntas: {e}")
        return func.HttpResponse(f"Error interno: {e}", status_code=500)


    ######################################
    ## 6) Verificar ventana de votación ##
    ######################################
    try:
        # Comprobamos que la fecha esté dentro del rango definido en la configuracion de votacion
        if not is_date_within_voting_window(proposalVersionId, date_to_check):
            return func.HttpResponse(
                json.dumps({"puede": "No", "error": "Fuera de rango de votación"}, ensure_ascii=False),
                status_code=200,
                mimetype="application/json"
            )
    except Exception as e:
        logging.error(f"Error al verificar ventana: {e}")
        return func.HttpResponse(f"Error interno: {e}", status_code=500)


    ######################################################################
    ## 7) Obtener el idVoter (primer registro) desde la tabla vpv_Voter ##
    ######################################################################
    try:
        with SessionLocal() as session:
            # Buscamos el primer Voter asociado al usuario
            voter = (
                session.query(Voter)
                       .filter(Voter.idUser == user_id) # buscamos el que haga match con user_id
                       .order_by(Voter.idVoter)
                       .first() # y tomamos el primero
            )
            if not voter:
                # si no se encuentra un voter
                return func.HttpResponse(
                    json.dumps({"error": f"No se encontró voter para user_id {user_id}"}),
                    status_code=400,
                    mimetype="application/json"
                )
            id_voter = voter.idVoter
    except Exception as e:
        logging.error(f"Error al buscar voter: {e}")
        return func.HttpResponse(f"Error interno: {e}", status_code=500)


    ###############################
    ## 8) Generar un nuevo token ##
    ###############################
    # Generamos un blind token único para esta sesión de votación
    new_token = generate_blind_token()


    ###########################################################
    ## 9) Llamar a la función auxiliar que inserta los votos ##
    ###########################################################
    # con los datos obtenidos en obtener_preguntas_por_nombre procedemos a insertar los votos
    try:
        insert_votes(
            user_id=user_id,
            id_token=new_token,
            id_voter=id_voter,
            votos=votos, # la lista de ids y votos
            password=password
        )
    except Exception as e: # en caso de que falle lanzamos un error
        logging.error(f"Error al insertar votos: {e}")
        # Devolvemos el mensaje de error capturado
        return func.HttpResponse(
            json.dumps({"error": str(e)}, ensure_ascii=False),
            status_code=500,
            mimetype="application/json"
        )
    # Marcamos el blind token como ya usado
    mark_token_used(new_token)
    
    return func.HttpResponse(
        json.dumps({"status": "ok", "inserted": len(votos)}),
        status_code=200,
        mimetype="application/json"
    )
