from database import SessionLocal  
from Models.votar.models import VotesTaken

def hasUserVoted(user_id: int, question_id: int) -> bool:
    """
    Retorna True si el usuario `user_id` ya tiene un registro en vpv_VotesTaken
    para la pregunta `question_id`, o False en caso contrario.
    """
    # abre un contexto de sesion con la base de datos
    with SessionLocal() as session:
        # ejecuta una consulta sobre la tabla VotesTaken:
        # filtra por el campo idUser igual a user_id
        # y por el campo idVotingQuestions igual a question_id
        exists = session.query(VotesTaken).filter(
            VotesTaken.idUser == user_id,
            VotesTaken.idVotingQuestions == question_id
        ).first()  # obtiene el primer registro que coincida, o None si no hay ninguno
        
        # Si `exists` no es None, significa que ya existe un voto registrado,
        # por lo que retorna True; de lo contrario, retorna False.
        return exists is not None
