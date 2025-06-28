from database import SessionLocal
from Models.votar.models import EncryptionKey

def get_key_name(user_id: int) -> str | None:
    """
    Recupera el nombre de la llave simetrica activa mas reciente para el usuario dado.
    Retorna el campo `key` si existe, o None en caso contrario.
    """
    # abrir contexto de sesión con la base de datos
    with SessionLocal() as session:
        # query: buscar en la tabla EncryptionKey el registro mas reciente habilitado para el user_id
        key_entry = (
            session.query(EncryptionKey)
                   .filter(
                       EncryptionKey.userid == user_id,  # coincidir con el id de usuario
                       EncryptionKey.enable == True      # solo llaves marcadas como enable=True
                   )
                   .order_by(EncryptionKey.creationDate.desc())  # ordenar por fecha de creacin descendente
                   .first()  # tomar únicamente el primer resultado (la llave mas reciente)
        )
    # si encontramos un registro, devolvemos su nombre de llave
    if key_entry:
        return key_entry.key
    # si no hay ninguna llave habilitada, retornamos None
    return None
