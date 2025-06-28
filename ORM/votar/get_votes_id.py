from sqlalchemy import func
from database import SessionLocal
from Models.votar.models import Vote, VotesTaken, VoteValue

def get_next_vote_id() -> int:
    """Devuelve el siguiente idVote para vpv_Votes (max(idVote) + 1 o 1 si no hay registros)."""
    with SessionLocal() as session:
        max_id = session.query(func.max(Vote.idVote)).scalar()
        return (max_id or 0) + 1

def get_next_votes_taken_id() -> int:
    """Devuelve el siguiente idVoteTaken para vpv_VotesTaken."""
    with SessionLocal() as session:
        max_id = session.query(func.max(VotesTaken.idVoteTaken)).scalar()
        return (max_id or 0) + 1

def get_next_vote_value_id() -> int:
    """Devuelve el siguiente idVoteValue para vpv_voteValues."""
    with SessionLocal() as session:
        max_id = session.query(func.max(VoteValue.idVoteValue)).scalar()
        return (max_id or 0) + 1
