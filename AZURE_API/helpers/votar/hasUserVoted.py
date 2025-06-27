from database import SessionLocal
from Models.votar.models import VotesTaken



def hasUserVoted(user_id: int, question_id: int) -> bool:
    """
    Retorna True si el usuario `user_id` ya tiene un registro en vpv_VotesTaken
    para la pregunta `question_id`, o False en caso contrario.
    """
    with SessionLocal() as session:
        exists = session.query(VotesTaken).filter(
            VotesTaken.idUser == user_id,
            VotesTaken.idVotingQuestions == question_id
        ).first()
        return exists is not None


