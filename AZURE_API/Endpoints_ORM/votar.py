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


def votar(req: func.HttpRequest) -> func.HttpResponse:
    logging.info('Procesando solicitud de permiso (votar).')

    ################################
    ## 1) Parsear JSON de entrada ##
    ################################
    try:
        body = req.get_json()
    except ValueError:
        return func.HttpResponse("JSON inválido.", status_code=400)

    # user_id  = body.get("auth", {}).get("idUser")
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
    if not all([id_card, password, proposal_name, version_name, date_str]):
        return func.HttpResponse(
            "Faltan campos obligatorios en el JSON.",
            status_code=400
        )
        
    #######################
    ## Obtener el idUser ##
    #######################
    try:
        user_id = obtenerIdUser(id_card)
    except Exception:
        return func.HttpResponse(
            json.dumps({"error": "No se pudo obtener el idUser."}, ensure_ascii=False), 
            status_code=400, 
            mimetype="application/json"
        )

    # convertir fecha
    try:
        date_to_check = datetime.fromisoformat(date_str)
    except Exception:
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


    ###############################################
    ## 4) Verificar permisos CRUD sobre la tabla ##
    ###############################################
    try:            
        # 1) Verificar SELECT sobre vpv_votingConfigurations
        if not user_can(user_id, "vpv_votingConfigurations", "SELECT"):
            return func.HttpResponse(
                json.dumps({"error": "Sin permiso sobre el recurso", "recurso": "vpv_votingConfigurations", "accion": "SELECT"}, ensure_ascii=False),
                status_code=200,
                mimetype="application/json"
            )

        # 2) Verificar SELECT sobre vpv_encryptionkeys
        if not user_can(user_id, "vpv_encryptionkeys", "SELECT"):
            return func.HttpResponse(
                json.dumps({"error": "Sin permiso sobre el recurso", "recurso": "vpv_encryptionkeys", "accion": "SELECT"}, ensure_ascii=False),
                status_code=200,
                mimetype="application/json"
            )

        # 3) Verificar SELECT sobre vpv_proposals
        if not user_can(user_id, "vpv_proposals", "SELECT"):
            return func.HttpResponse(
                json.dumps({"error": "Sin permiso sobre el recurso", "recurso": "vpv_proposals", "accion": "SELECT"}, ensure_ascii=False),
                status_code=200,
                mimetype="application/json"
            )

        # 4) Verificar SELECT sobre vpv_proposalVersions
        if not user_can(user_id, "vpv_proposalVersions", "SELECT"):
            return func.HttpResponse(
                json.dumps({"error": "Sin permiso sobre el recurso", "recurso": "vpv_proposalVersions", "accion": "SELECT"}, ensure_ascii=False),
                status_code=200,
                mimetype="application/json"
            )

        # 5) Verificar SELECT sobre vpv_PopulationFilters
        if not user_can(user_id, "vpv_PopulationFilters", "SELECT"):
            return func.HttpResponse(
                json.dumps({"error": "Sin permiso sobre el recurso", "recurso": "vpv_PopulationFilters", "accion": "SELECT"}, ensure_ascii=False),
                status_code=200,
                mimetype="application/json"
            )

        # 6) Verificar SELECT sobre vpv_TargetPopulations
        if not user_can(user_id, "vpv_TargetPopulations", "SELECT"):
            return func.HttpResponse(
                json.dumps({"error": "Sin permiso sobre el recurso", "recurso": "vpv_TargetPopulations", "accion": "SELECT"}, ensure_ascii=False),
                status_code=200,
                mimetype="application/json"
            )

        # 7) Verificar SELECT sobre vpv_TargetPopulationsVoting
        if not user_can(user_id, "vpv_TargetPopulationsVoting", "SELECT"):
            return func.HttpResponse(
                json.dumps({"error": "Sin permiso sobre el recurso", "recurso": "vpv_TargetPopulationsVoting", "accion": "SELECT"}, ensure_ascii=False),
                status_code=200,
                mimetype="application/json"
            )

        # 8) Verificar SELECT sobre vpv_FilterTypes
        if not user_can(user_id, "vpv_FilterTypes", "SELECT"):
            return func.HttpResponse(
                json.dumps({"error": "Sin permiso sobre el recurso", "recurso": "vpv_FilterTypes", "accion": "SELECT"}, ensure_ascii=False),
                status_code=200,
                mimetype="application/json"
            )

        # 9) Verificar SELECT sobre vpv_demographics
        if not user_can(user_id, "vpv_demographics", "SELECT"):
            return func.HttpResponse(
                json.dumps({"error": "Sin permiso sobre el recurso", "recurso": "vpv_demographics", "accion": "SELECT"}, ensure_ascii=False),
                status_code=200,
                mimetype="application/json"
            )

        # 10) Verificar SELECT sobre vpv_votingQuestions
        if not user_can(user_id, "vpv_votingQuestions", "SELECT"):
            return func.HttpResponse(
                json.dumps({"error": "Sin permiso sobre el recurso", "recurso": "vpv_votingQuestions", "accion": "SELECT"}, ensure_ascii=False),
                status_code=200,
                mimetype="application/json"
            )

        # 11) Verificar SELECT sobre vpv_optionsQuestion
        if not user_can(user_id, "vpv_optionsQuestion", "SELECT"):
            return func.HttpResponse(
                json.dumps({"error": "Sin permiso sobre el recurso", "recurso": "vpv_optionsQuestion", "accion": "SELECT"}, ensure_ascii=False),
                status_code=200,
                mimetype="application/json"
            )

        # 12) Verificar INSERT sobre vpv_BlindTokens
        if not user_can(user_id, "vpv_BlindTokens", "INSERT"):
            return func.HttpResponse(
                json.dumps({"error": "Sin permiso sobre el recurso", "recurso": "vpv_BlindTokens", "accion": "INSERT"}, ensure_ascii=False),
                status_code=200,
                mimetype="application/json"
            )


        # 13) Verificar SELECT sobre vpv_VotesTaken
        if not user_can(user_id, "vpv_VotesTaken", "SELECT"):
            return func.HttpResponse(
                json.dumps({"error": "Sin permiso sobre el recurso", "recurso": "vpv_VotesTaken", "accion": "SELECT"}, ensure_ascii=False),
                status_code=200,
                mimetype="application/json"
            )

        # 14) Verificar INSERT sobre vpv_VotesTaken
        if not user_can(user_id, "vpv_VotesTaken", "INSERT"):
            return func.HttpResponse(
                json.dumps({"error": "Sin permiso sobre el recurso", "recurso": "vpv_VotesTaken", "accion": "INSERT"}, ensure_ascii=False),
                status_code=200,
                mimetype="application/json"
            )

        # 15) Verificar INSERT sobre vpv_Votes
        if not user_can(user_id, "vpv_Votes", "INSERT"):
            return func.HttpResponse(
                json.dumps({"error": "Sin permiso sobre el recurso", "recurso": "vpv_Votes", "accion": "INSERT"}, ensure_ascii=False),
                status_code=200,
                mimetype="application/json"
            )

        # 16) Verificar INSERT sobre vpv_voteValues
        if not user_can(user_id, "vpv_voteValues", "INSERT"):
            return func.HttpResponse(
                json.dumps({"error": "Sin permiso sobre el recurso", "recurso": "vpv_voteValues", "accion": "INSERT"}, ensure_ascii=False),
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
        resultado = obtener_preguntas_por_nombre(
            user_id=user_id,
            proposal_name=proposal_name,
            version_name=version_name,
            votos_list=votos_list
        )
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
            voter = (
                session.query(Voter)
                       .filter(Voter.idUser == user_id)
                       .order_by(Voter.idVoter)
                       .first()
            )
            if not voter:
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
    new_token = generate_blind_token()


    ###########################################################
    ## 9) Llamar a la función auxiliar que inserta los votos ##
    ###########################################################
    try:
        insert_votes(
            user_id=user_id,
            id_token=new_token,
            id_voter=id_voter,
            votos=votos,
            password=password
        )
    except Exception as e:
        logging.error(f"Error al insertar votos: {e}")
        return func.HttpResponse(
            json.dumps({"error": str(e)}, ensure_ascii=False),
            status_code=500,
            mimetype="application/json"
        )

    mark_token_used(new_token)
    
    return func.HttpResponse(
        json.dumps({"status": "ok", "inserted": len(votos)}),
        status_code=200,
        mimetype="application/json"
    )
