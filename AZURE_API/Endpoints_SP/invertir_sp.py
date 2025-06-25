#FUNCION SP DE EJEMPLO

import azure.functions as func
from datetime import datetime
import json
import logging
import os #Esto para poder obtener la variable de entorno que posee la conexion
import pyodbc

# Obteniene la cadena de conexión desde la variable de entorno
conn_str = os.environ.get("SQL_CONNECTION_STRING")

"""
    Ejecuta el procedimiento almacenado 'vpvSP_InvertirProyecto' para registrar una inversión en una propuesta activa por parte de un ciudadano.

    Parámetros del cuerpo de la solicitud (req_body) de formato JSON:
    - propuesta (str): Nombre de la propuesta en la que se desea invertir.
    - idCard (str): Número de identificación del inversor en este caso un ciudadano.
    - agreementType (str): Tipo de acuerdo (ej. "Crowdfunding de donación").
    - monto (float): Monto de dinero que se desea invertir.
    - transactionrefNumber (str): Número de referencia de la transacción.
    - finalDate (str): Fecha de finalización del acuerdo (formato 'YYYY-MM-DD').
    - paymentDate (str): Fecha del primer pago (formato 'YYYY-MM-DD').
    - currency (str): Tipo de moneda utilizada, el acronimo de la moneda.
    - recurrencia (str): Frecuencia de pag0 debe ser un numero entero y positivoo.
    - plazosPago (int): Número de pagos o plazos para cubrir el monto total.

    Retorna:
    - HttpResponse con mensaje de éxito o error según el resultado del procedimiento. Es decir, el mensaje que retorne el sp
    """
def invertir(req: func.HttpRequest) -> func.HttpResponse:
    logging.info('Comenzando a invertir...')

     #VALIDO QUE EL METODO SEA POST DE LO CONTRARIO, ESTE REQUEST NO SERA PROCESADO
    if req.method != "POST":
        return func.HttpResponse(
            "Metodo no permitido. Utilice otro metodo",
            status_code=405
        )

    #Obtengo el json que se encuentra en el body
    try:
        req_body = req.get_json()
        # Agarro los parametros que me enviaron desde el body
        propuesta = req_body.get('propuesta')
        idCard = req_body.get('idCard')
        agreementType = req_body.get('agreementType')
        monto = req_body.get('monto')
        transactionrefNumber = req_body.get('transactionrefNumber')
        finalDate = req_body.get('finalDate')
        paymentDate = req_body.get('paymentDate')
        currency = req_body.get('currency')
        recurrencia = req_body.get('recurrencia')
        plazosPago = req_body.get('plazosPago')

        #Validaciones de los datos entrantes, con la finalidad de que el sp no reciba valores nulos

        if not propuesta:
            return func.HttpResponse("El campo 'propuesta' es requerido.",status_code=400)

        if not idCard or not idCard.isdigit():
            return func.HttpResponse("El campo 'idCard' es requerido y debe ser numérico.",status_code=400)

        if not agreementType:
            return func.HttpResponse("El campo 'agreementType' es requerido.",status_code=400)

        try: #valida si el monto es menor o negativo
            monto = float(monto)
            if monto <= 0:
                raise ValueError()
        except:
            return func.HttpResponse("El campo 'monto' debe ser un número decimal positivo.",status_code=400)

        if not transactionrefNumber:
            return func.HttpResponse("El campo 'transactionrefNumber' es requerido.",status_code=400)

        # Validar fechas para que se sepa si tienen el formato adecuado para ser enviado
        try:
            finalDate = datetime.strptime(finalDate, "%Y-%m-%d")
        except:
            return func.HttpResponse("El campo 'finalDate' debe tener formato YYYY-MM-DD.",status_code=400)

        try:
            paymentDate = datetime.strptime(paymentDate, "%Y-%m-%d")
        except:
            return func.HttpResponse("El campo 'paymentDate' debe tener formato YYYY-MM-DD.",status_code=400)

        if not currency:
            return func.HttpResponse("El campo 'currency' es requerido.",status_code=400)

        if not recurrencia:
            return func.HttpResponse("El campo 'recurrencia' es requerido.",status_code=400)

        try: #validacion de los plazos con la finalidad de validar que no sea negativos o decimales
            plazosPago = int(plazosPago)
            if plazosPago <= 0:
                raise ValueError()
        except:
            return func.HttpResponse("El campo 'plazosPago' debe ser un entero positivo.",status_code=400)
        
        #ejecucion del SP junto al envio de parametros
        # Conexión a SQL Server y ejecución del SP mandandole los parametros
        
        try:
            with pyodbc.connect(conn_str) as conn:
                cursor = conn.cursor()
                cursor.execute("""
                    EXEC dbo.vpvSP_InvertirProyecto ?, ?, ?, ?, ?, ?, ?, ?, ?, ?;
                """, ( propuesta,idCard,agreementType,monto,transactionrefNumber,finalDate,paymentDate,currency, recurrencia,plazosPago))

                #en caso de no lanzar una excepcion enviara un mensaje de exiito, de lo contrario el try se encarga de manejar la excepcion
                if cursor.description:  # Verifica si hay resultados es decir si hubo un select por ej pero en este caso solamente fue un return
                    columns = [col[0] for col in cursor.description]
                    rows = cursor.fetchall()
                    result = [dict(zip(columns, row)) for row in rows]
                    return func.HttpResponse(json.dumps(result), status_code=200, mimetype="application/json")
                else:
                    return func.HttpResponse(
                        json.dumps({"mensaje": "Inversion Exitosa"}),
                        status_code=200,
                        mimetype="application/json"
                    )

        except pyodbc.Error as e:
            error_msg = str(e)
            return func.HttpResponse(
                json.dumps({"error": error_msg}),
                status_code=400,
                mimetype="application/json"
            )
                
    #control de excepciones extras asi como rollback en la transaccion principal
    except ValueError as e:
        return func.HttpResponse(
            str(e),
            status_code=200
        )
