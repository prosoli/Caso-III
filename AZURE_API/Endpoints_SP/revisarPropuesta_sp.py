import azure.functions as func
from datetime import datetime
import json
import logging
import os
import pyodbc

conn_str = os.environ.get("SQL_CONNECTION_STRING")

def main(req: func.HttpRequest) -> func.HttpResponse:
    logging.info('Endpoint revisarPropuesta invocado.')

    # Solo permitimos POST
    if req.method != "POST":
        return func.HttpResponse(
            "Método no permitido. Usa POST.",
            status_code=405
        )

    # Parseo del body JSON
    try:
        req_body = req.get_json()
    except ValueError:
        return func.HttpResponse(
            "Body no es JSON válido.",
            status_code=400
        )

    # Validación del parámetro proposalId
    proposal_id = req_body.get('proposalId')
    if proposal_id is None:
        return func.HttpResponse(
            "El campo 'proposalId' es requerido.",
            status_code=400
        )
    try:
        proposal_id = int(proposal_id)
    except:
        return func.HttpResponse(
            "El campo 'proposalId' debe ser un entero.",
            status_code=400
        )

    # Ejecución del SP
    try:
        with pyodbc.connect(conn_str, autocommit=False) as conn:
            cursor = conn.cursor()
            # Llamada al SP; si el SP falla con RAISERROR levantará excepción
            cursor.execute("EXEC dbo.revisarPropuesta ?", proposal_id)
            conn.commit()

            # Devolvemos un JSON con éxito.
            return func.HttpResponse(
                json.dumps({"message": "Propuesta revisada exitosamente."}),
                status_code=200,
                mimetype="application/json"
            )

    except pyodbc.Error as e:
        # Cualquier error en SQL cae aquí
        error_text = str(e)
        logging.error(f"Error al ejecutar revisarPropuesta: {error_text}")
        return func.HttpResponse(
            json.dumps({"error": error_text}),
            status_code=400,
            mimetype="application/json"
        )
