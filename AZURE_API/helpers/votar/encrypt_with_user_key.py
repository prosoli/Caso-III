from sqlalchemy import text
from database import SessionLocal




def encrypt_with_user_key(user_id: int, key_name: str, password: str, texto_a_encriptar: str) -> bytes:
    with SessionLocal() as session:
        # key_name = get_key_name_for_user_orm(session, user_id)
        if not key_name:
            raise Exception(f"No se encontró llave activa para user_id {user_id}")
        try:
            # 1) Abrir la llave con la contraseña *inline*
            sql_open = f"OPEN SYMMETRIC KEY [{key_name}] DECRYPTION BY PASSWORD = '{password}'"
            session.execute(text(sql_open))
        except:
            raise Exception(f"No se logro abrir la llave con la contraseña {password}")


        # 2) Encriptar
        row = session.execute(
            text(f"SELECT ENCRYPTBYKEY(KEY_GUID('{key_name}'), :texto) AS Encrypted"),
            {"texto": texto_a_encriptar}
        ).fetchone()
        encrypted_bytes = row.Encrypted

        # 3) Cerrar llave
        session.execute(text(f"CLOSE SYMMETRIC KEY [{key_name}]"))

        return encrypted_bytes
