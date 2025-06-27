import os
from sqlalchemy import select, text
from database import SessionLocal
from dotenv import load_dotenv


# Carga las variables del .env
load_dotenv()
#variables de entorno
clave = os.getenv("CLAVECEDULA")

def obtenerIdUser(cedula_clara):
    with SessionLocal() as session:
        try:
            # Abrir la clave
            session.execute(text(f"""
                OPEN SYMMETRIC KEY llavecedula
                DECRYPTION BY PASSWORD = '{clave}';
            """))

            # Ejecutar SELECT directamente, evitando mapeo extraño de parámetros
            sql = f"""
                SELECT u.idUser
                FROM dbo.vpv_Users AS u
                WHERE CONVERT(NVARCHAR(50), DecryptByKey(CAST(u.id_card AS VARBINARY(MAX)))) = '{cedula_clara}';
            """

            result = session.execute(text(sql))
            row = result.fetchone()

            return row.idUser if row else None

        finally:
            # Siempre cerrar la clave aunque haya error
            session.execute(text("CLOSE SYMMETRIC KEY llavecedula;"))
    
