import os
import json
import logging

import azure.functions as func
import pyodbc




def crearActualizarPropuesta(req: func.HttpRequest) -> func.HttpResponse:

    logging.info('Invocando crearActualizarPropuesta con JSON completo.')

    try:
        payload = req.get_json()
    except ValueError:
        return func.HttpResponse("JSON inválido.", status_code=400)

    # Leer la cadena de conexión desde Application Settings
    conn_str = os.getenv('SQL_CONNECTION_STRING')
    if not conn_str:
        logging.error("SqlConnection no configurada.")
        return func.HttpResponse("Error de configuración del servidor.", status_code=500)

    try:
        # Conectarse a SQL Server
        cnxn = pyodbc.connect(conn_str)
        cur = cnxn.cursor()

        # Preparamos un batch para invocar el SP con parámetros OUTPUT
        tsql = """
        DECLARE
            @newConfigId   INT,
            @outProposalId INT,
            @outVersionId  INT;

        EXEC dbo.vpvSP_CrearActualizarPropuesta
            @jsonAll          = ?,
            @newConfigId      = @newConfigId OUTPUT,
            @outProposalId    = @outProposalId OUTPUT,
            @outVersionId     = @outVersionId OUTPUT;

        SELECT
            @newConfigId   AS votingConfigId,
            @outProposalId AS proposalId,
            @outVersionId  AS versionId;
        """

        # Ejecutar pasando el JSON serializado
        cur.execute(tsql, json.dumps(payload))

        # Leer los resultados
        row = cur.fetchone()
        cnxn.commit()
        cur.close()
        cnxn.close()

        if not row:
            raise Exception("El SP no devolvió ningún resultado.")

        result = {
            "status": "ok",
            "votingConfigId": row.votingConfigId,
            "proposalId":     row.proposalId,
            "versionId":      row.versionId
        }
        return func.HttpResponse(
            json.dumps(result),
            status_code=200,
            mimetype="application/json"
        )

    except Exception as e:
        logging.error(f"Error ejecutando SP: {e}")
        return func.HttpResponse(
            f"Error interno: {str(e)}",
            status_code=500
        )