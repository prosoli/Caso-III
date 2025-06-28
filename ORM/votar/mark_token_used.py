from datetime import datetime
from sqlalchemy import update
from database import SessionLocal
from Models.votar.models import BlindToken

def mark_token_used(token: str):
    with SessionLocal() as session:
        stmt = (
            update(BlindToken)
            .where(BlindToken.idToken == token)
            .values(used=True, usedDate=datetime.utcnow())
        )
        session.execute(stmt)
        session.commit()
