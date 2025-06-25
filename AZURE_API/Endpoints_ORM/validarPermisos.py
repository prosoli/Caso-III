from sqlalchemy import text
from sqlalchemy.exc import SQLAlchemyError
import os #utilizado para variables de entorno
from dotenv import load_dotenv


# Carga las variables del .env
load_dotenv()
#variables de entorno
clave = os.getenv("CLAVECEDULA")

"""
    Valida si un usuario tiene un rol específico consultando el procedimiento almacenado 'vpvSP_UserHasRole'.

    Parámetros:
    - session: objeto de sesión de SQLAlchemy para ejecutar consultas en la base de datos.
    - idUsuario: ID del usuario a validar.
    - roleName: Nombre del rol que se desea verificar.

    Funcionamiento:
    Ejecuta el procedimiento almacenado que retorna un valor BIT (0 o 1) en el parámetro OUTPUT @HasRole.
    Si el valor es NULL o 0, se lanza una excepción PermissionError indicando que el usuario no tiene el rol necesario.
    Cualquier error de base de datos se propaga como excepción para ser manejado externamente.
    """

def validar_permiso(session, idCard, roleName):
    try: 
        #id usuario que fue encontrado para validar el permiso
        idUsuario = None;

        #abro la llave para desencriptar las cedulas
        sql = f"OPEN SYMMETRIC KEY llavecedula DECRYPTION BY PASSWORD = '{clave}'"
        session.execute(text(sql))

        # Obtengo el objeto identificado
        result = session.execute(text("""
            SELECT idUser
            FROM vpv_Users
            WHERE enable = 1
            AND CONVERT(nvarchar(50), DECRYPTBYKEY(id_card)) = :idCard
        """), {'idCard': idCard})

        # Obtener el primer resultado
        row = result.fetchone()
        idUsuario = row[0] if row else None

        
        if not idUsuario:
            raise ValueError(f"No se encontró el usuario a realizar la configuracion: {idCard}, o el mismo no esta activo")

        #creo que query que va a ser ejecutado, esto por medio de sqlalchemy
        sql = text("""
            DECLARE @hasRole BIT;
            EXEC dbo.vpvSP_UserHasRole
                @idUser = :idUsuario,
                @roleName = :roleName,
                @HasRole = @hasRole OUTPUT;
            SELECT @hasRole AS hasRole;
        """)
        #ejecucion del query utilizando la sesion enviada y creada
        result = session.execute(sql, {"idUsuario": idUsuario, "roleName": roleName})
        has_role_row = result.fetchone()
        has_role = has_role_row[0] if has_role_row else None


        if has_role is None or has_role == 0:
            raise PermissionError(f"El usuario no tiene el rol necesario: {roleName}")

    except SQLAlchemyError as e:
        # Maneja errores de BD si quieres
        raise e
