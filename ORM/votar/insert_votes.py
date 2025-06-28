import uuid
import hashlib
import socket
from datetime import datetime
from sqlalchemy import select
from database import SessionLocal
from Models.votar.models import (
    Vote, VoteValue, VotesTaken, VotingConfiguration, VotingQuestion, OptionQuestion,
    User
)
from helpers.votar.hasUserVoted import hasUserVoted
from helpers.votar.insertLogs import insertLog
from helpers.votar.updateVoteCount import updateVoteCount
from helpers.votar.get_key_name import get_key_name
from helpers.votar.encrypt_with_user_key import encrypt_with_user_key



def insert_votes(user_id: int, id_token: uuid.UUID, id_voter: int, votos: list, password: str):
    """
    Inserta los votos en la base de datos. 
    Encripta los valores de voto usando encrypt_with_user_key.
    Además loggea cada paso crítico.
    """
    # Obtener el nombre de la llave asociada al usuario
    key_name = get_key_name(user_id)
    # Si no existe llave, registrar error y abortar
    if not key_name:
        insertLog(
            description=f"No se encontró llave habilitada para user_id {user_id}",
            computer=socket.gethostname(),
            username=str(user_id),
            trace="insert_votes:key_lookup",
            severity_name="High",
            source_name="VotingService",
            type_name="Error",
        )
        raise Exception(f"No se encontró llave habilitada para user_id {user_id}")

    with SessionLocal() as session:
        try:
            # 1) Marcar cada pregunta como votada
            for v in votos:
                qid     = v["questionId"] # ID de la pregunta
                qName   = v.get("questionName", str(qid)) # Nombre de la pregunta 
                if hasUserVoted(user_id, qid): # Verificar si el usuario ya votó esta pregunta
                    insertLog(
                        description=f"Intento múltiple de voto para pregunta {qName}",
                        computer=socket.gethostname(),
                        username=str(user_id),
                        trace="insert_votes:duplicate_check",
                        reference1=str(qid),
                        severity_name="Warning",
                        source_name="VotingService",
                        type_name="Audit",
                    )
                    raise Exception(f"El usuario ya voto a esta pregunta: {qName}")

                # Crear registro de VotesTaken para bloquear la pregunta, asi el usuario no podra volver a votar por la misma pregunta
                taken = VotesTaken(
                    idUser=user_id,
                    idVotingQuestions=qid,
                    checksum=hashlib.sha256(f"{user_id}_{qid}".encode()).digest()
                )
                session.add(taken) 

            session.flush() # Enviar los INSERT de VotesTaken antes de continuar

            # Loguear que se marcaron las preguntas como tomadas
            insertLog(
                description="Se marcaron preguntas como tomadas",
                computer=socket.gethostname(),
                username=str(user_id),
                trace="insert_votes:mark_taken",
                reference1=str([v["questionId"] for v in votos]),
                severity_name="Informational",
                source_name="VotingService",
                type_name="Audit",
            )

            # 2) Insertar cada voto y su valor cifrado
            for v in votos:
                qid = v["questionId"] # ID de la pregunta
                votingConfigId = v["votingConfigId"] # ID de la configuración de votación
                oid = v["optionId"] # ID de la opción elegida
                rv  = v["voto"] # Valor crudo del voto

                # Crear objeto Vote (metadatos del voto)
                vote = Vote(
                    idVotingQuestion=qid,
                    idVotingConfig=votingConfigId,
                    idToken=id_token,
                    idVoter=id_voter,
                    idOptionQuestion=oid,
                    checksum=hashlib.sha256(f"{id_token}{id_voter}".encode()).digest()
                )
                session.add(vote)
                session.flush()  # para obtener vote.idVote

                # Cifrar el valor del voto
                encrypted = encrypt_with_user_key(
                    user_id=user_id,
                    key_name=key_name,
                    password=password,
                    texto_a_encriptar=rv
                )
                # Crear objeto VoteValue con el valor cifrado
                vv = VoteValue(
                    idVote=vote.idVote,
                    value1=encrypted,
                    value2=b"", # Reservado para una segunda parte si se necesitara
                    checksum=hashlib.sha256(encrypted).digest()
                )
                session.add(vv)
                
                # Actualizar el conteo agregado en la tabla de resultados
                updateVoteCount(
                    voting_config_id = votingConfigId,
                    question_id      = qid,
                    option_id        = oid
                )
 
                # Loguear la inserción de cada voto
                insertLog(
                    description=f"Registro de voto para pregunta {qid}, opción {oid}",
                    computer=socket.gethostname(),
                    username=str(user_id),
                    trace="insert_votes:vote_insert",
                    reference1=str(vote.idVote),
                    reference2=str(oid),
                    value1=rv,
                    severity_name="Informational",
                    source_name="VotingService",
                    type_name="Audit",
                )

            session.commit() # Confirmar todos los cambios en BD
            
            # Log final de confirmación de todos los votos
            insertLog(
                description="Todos los votos insertados correctamente",
                computer=socket.gethostname(),
                username=str(user_id),
                trace="insert_votes:complete",
                reference1=str(id_token),
                severity_name="Informational",
                source_name="VotingService",
                type_name="Audit",
            )
        except Exception as e:
            session.rollback() # Deshacer en caso de error
            insertLog(
                description="Error al insertar votos",
                computer=socket.gethostname(),
                username=str(user_id),
                trace="insert_votes:exception",
                value1=str(e),
                severity_name="Critical",
                source_name="VotingService",
                type_name="Error",
            )
            # relanzamos para que lo capture la capa superior
            raise        
      