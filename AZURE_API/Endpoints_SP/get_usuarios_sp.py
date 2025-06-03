#FUNCION SP DE EJEMPLO

import azure.functions as func
import datetime
import json
import logging
import os #Esto para poder obtener la variable de entorno que posee la conexion
import pyodbc

# Obteniene la cadena de conexión desde la variable de entorno
conn_str = os.environ.get("SQL_CONNECTION_STRING")

#Plantilla para Implementacion con SP y parametros

def get_usuarios_sp(req: func.HttpRequest) -> func.HttpResponse:
    logging.info("Procesando solicitud HTTP para ejecutar SP con parámetros.")

    try:
        # Agarro los parametros que me enviaron desde el body
        username = req.params.get('username')
        only_active = req.params.get('only_active')

        if not username:
            try:
                req_body = req.get_json()
                username = req_body.get('username')
                only_active = req_body.get('only_active')
            except ValueError:
                pass

        if not username:
            return func.HttpResponse("Falta el parámetro 'username'.", status_code=400)

        # Convertir only_active a entero (bit)
        only_active = int(only_active) if only_active is not None else 0

        # Conexión a SQL Server y ejecución del SP mandandole los parametros
        with pyodbc.connect(conn_str) as conn:
            cursor = conn.cursor()
            cursor.execute("EXEC dbo.sp_get_users_by_name ?, ?", (username, only_active))
            rows = cursor.fetchall()

            columns = [column[0] for column in cursor.description]
            usuarios = [dict(zip(columns, row)) for row in rows]

            return func.HttpResponse(
                json.dumps(usuarios, default=str),
                status_code=200,
                mimetype="application/json"
            )
    except Exception as e:
        logging.error(f"Error ejecutando SP: {e}")
        return func.HttpResponse(f"Error interno: {str(e)}", status_code=500)