from database import SessionLocal
from Models.votar.models import EncryptionKey


    
def get_key_name(user_id: int) -> str | None:
    with SessionLocal() as session:
        key_entry = (
            session.query(EncryptionKey)
                   .filter(
                       EncryptionKey.userid == user_id,
                       EncryptionKey.enable == True
                   )
                   .order_by(EncryptionKey.creationDate.desc())
                   .first()
        )
    if key_entry:
        return key_entry.key
    return None
