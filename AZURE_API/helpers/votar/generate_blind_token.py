import uuid
import hashlib

from database import SessionLocal
from Models.votar.models import BlindToken



def generate_blind_token() -> str:
    """
    Crea un nuevo registro en vpv_BlindTokens y devuelve el UUID generado (como cadena).
    """
    # 1) Generar el UUID de cliente
    new_uuid = uuid.uuid4()

    # 2) Calcular checksum (por ejemplo SHA‑256 del UUID + timestamp)
    checksum_input = f"{new_uuid}{uuid.uuid1().time}".encode("utf-8")
    checksum = hashlib.sha256(checksum_input).digest()

    # 3) Insertar en la base de datos
    with SessionLocal() as session:  # asume que SessionLocal está definido en db.py
        token = BlindToken(
            idToken=new_uuid,
            used=False,
            checksum=checksum
        )
        session.add(token)
        session.commit()

    # 4) Devolver el UUID como string
    return str(new_uuid)
