import azure.functions as func
import logging
import json
from database import SessionLocal
import os #Esto para poder obtener la variable de entorno que posee la conexion
import pyodbc

# Obteniene la cadena de conexión desde la variable de entorno
conn_str = os.environ.get("SQL_CONNECTION_STRING")

def repartir_dividendos(req: func.HttpRequest) -> func.HttpResponse:
    logging.info('Procesando solicitud HTPP para ejecutar SP de Repartir Dividendos')

    try:
        #Verificar proposal name
        Proposalname = req.params.get('Proposalname')

        if not Proposalname:
            try:
                req_body = req.get_json()
                Proposalname = req_body.get('Proposalname')
            except ValueError:
                pass

        if not Proposalname:
            return func.HttpResponse("Incluya el parametro 'Proposalname'", status_code = 400)
        

        #Verificar Id Card
        id_card = req.params.get('idCard')

        if not id_card:
            try:
                req_body = req.get_json()
                id_card = req_body.get('idCard')
            except ValueError:
                pass

        if not id_card:
            return func.HttpResponse("Incluya el parametro 'idcard'", status_code = 400)
        
        #Verificacion de currency
        currency = req.params.get('Currency')
        
        if not currency:
            try:
                req_body = req.get_json()
                currency = req_body.get('Currency')
            except ValueError:
                pass

        if not currency:
            return func.HttpResponse("Incluya el parametro 'Currency'", status_code = 400)
        
        
        
        # Conexión a SQL Server y ejecución del SP mandandole los parametros
        with pyodbc.connect(conn_str) as conn:
            cursor = conn.cursor()
            try:
                cursor.execute("EXEC dbo.vpvSP_RepartirDividendos ?, ?, ?", (Proposalname, id_card, currency))
                conn.commit()
                return func.HttpResponse("Dividendos repartidos correctamente.", status_code=200)
            except pyodbc.Error as db_err:
                logging.error(f"Error de base de datos: {db_err}")
                # Extraer mensaje de error desde SQL Server
                sql_msg = str(db_err)
                return func.HttpResponse(f"Error al repartir dividendos: {sql_msg}", status_code=400)


    except Exception as e:
        logging.error(f"Error ejecutando el SP Repartir Dividendos: {e}")
        return func.HttpResponse(f"Error interno: {str(e)}", status_code=500)
