import azure.functions as func
import logging
import json
from Models import users
from database import SessionLocal

#En este caso no se define si es GET o POST por lo tanto acepta cualquier metodo
def get_usuarios_orm(req: func.HttpRequest) -> func.HttpResponse:
    logging.info('Python HTTP trigger function processed a request.')

    session = SessionLocal()
    try:
        users = session.query(users.username).filter_by(active=True).limit(5).all()#obtengo el username de los primero 5 activos
        print(users)
        result = [
            {
                "username": user.username
            }
            for user in users
        ]

        return func.HttpResponse(
            json.dumps(result, default=str),
            status_code=200,
            mimetype="application/json"
        )

    except Exception as e:
        logging.error(f"Error al obtener usuarios: {e}")
        return func.HttpResponse(
            f"Error interno del servidor: {str(e)}",
            status_code=500
        )
    finally:
        session.close()
