import azure.functions as func
import logging
import json
from database import SessionLocal
import uuid #para generar numeros unicos
import random   #para generar simulacion de workflow
from datetime import datetime, timedelta
import json #Para hacer un insert de Nvarchar(MAX)
import os #utilizado para variables de entorno
from dotenv import load_dotenv
from sqlalchemy import text

# Carga las variables del .env
load_dotenv()
#variables de entorno
clave = os.getenv("CLAVECEDULA")

#Importacion de todas las tablas utilizadas para crear el proceso
from Models.users import VpvUser
from Models.Configuracion_Votacion.proposalVersion import VpvProposalVersions
#tablas de docs y coments
from Models.comentar.docs import VpvDoc
from Models.comentar.docstates import VpvDocState
from Models.comentar.docstypes import VpvDocTypes
from Models.comentar.formats import VpvFormat
from Models.comentar.identitydocs import VpvIdentityDoc
from Models.comentar.proposalComments import VpvProposalComments
from Models.comentar.processStatus import VpvProcessStatus
#tablas para workflows
from Models.comentar.extractedInfos import VpvExtractedInfos
from Models.comentar.parameters import VpvParameters
from Models.comentar.process import VpvProcess
from Models.comentar.processTypes import VpvProcessTypes
from Models.comentar.stepTypes import VpvStepTypes
from Models.comentar.workflowSteps import VpvWorkflowSteps
from Models.comentar.workResults import VpvWorkResults
from Models.comentar.api import VpvApi

#tablas de logs
from Models.comentar.logs import VpvLogs
from Models.comentar.logsSeverity import VpvLogSeverity
from Models.comentar.logsSources import VpvLogsSource
from Models.comentar.logTypes import VpvLogType

from Endpoints_ORM.encrypt_checksum import encrypt_checksum #Generacion del schecksum
from Endpoints_ORM.validarPermisos import validar_permiso


def comentar(req: func.HttpRequest) -> func.HttpResponse:
    logging.info('Insertando el comentario')

    #Se valida que unicamente se use el metodo POST
    if req.method != "POST":
        return func.HttpResponse(
            "Metodo no permitido",
            status_code=405
        )
    
    #Se obtienen los datos del Json
    try:
        session = SessionLocal()
        req_body = req.get_json()

        idcard = req_body.get("idCard")
        #Validacion del usuario, en este caso puede ser un ciudadno cualquiera
        try:
            validar_permiso(session, idcard, 'Ciudadano')
        except PermissionError as e:
            return func.HttpResponse(
                json.dumps({"error": str(e)}),
                status_code=403,
                mimetype="application/json"
            )

        #Se llama Verificar sesion para saber si el usuario del ID card está enable
        Sesion = VerificarSesionActiva(req_body, session)
        if not Sesion:
            return func.HttpResponse("El usuario no tiene sesión activa", status_code=403)
        

        #Insercion del documento que se adjunta por parte del usuario
        documento = InsertDocument(req_body, session)
        if not documento:
            return func.HttpResponse("No se pudo insertar el documento", status_code=500)
        

        #Validación del json para verificar que hayan una seccion de comment
        comments = req_body.get("Comment")
        if not comments or not isinstance(comments, list):#validacion de la existencia de datos
            return func.HttpResponse("Comentarios inválidos o inexistentes", status_code=400)
                
        
        #Realizar la inserción principal del comentario con estado "Pendiente de Revision"
        comentario = InsertarComentario (req_body, session)
        if not comentario:
            return func.HttpResponse("El comentario no se pudo insertar", status_code=500)

        
        #---------------------------- WORKFLOW COMMENT ---------------------------
        # Insertar parámetros del comentario
        parametro_coment = InsertarParametros(req_body, session, "comentario")
        if not parametro_coment:
            return func.HttpResponse("No se pudo insertar los parámetros del comentario", status_code=500)

        # Crear proceso para el comentario
        proceso_coment = CrearProceso(comentario, parametro_coment, session, "comentario")
        if not proceso_coment:
            return func.HttpResponse("No se pudo crear el proceso para el comentario", status_code=500)

        # Ejecutar análisis para el comentario
        resultado_coment = InsertarSimulacion(req_body, proceso_coment, session, tipo="comentario")
        if not resultado_coment:
            return func.HttpResponse("No se pudo ejecutar el análisis del comentario", status_code=500)

        #--------------------------- WORKFLOW DOCS ----------------------------------

        # Insertar parametros que serán analizados con IA
        #Se pasa el tipo "documento" para saber que ese será el objeto analizado
        parametro_doc = InsertarParametros(req_body, session, "documento")
        if not parametro_doc:
            return func.HttpResponse("No se pudo insertar los parámetros del documento", status_code=500)


        # Se crea el proceso especifico para el documento insertado anteriormente y el proceso
        #que se acaba de insertar
        proceso_doc = CrearProceso(documento, parametro_doc, session, "documento")
        if not proceso_doc:
            return func.HttpResponse("No se pudo crear el proceso para el documento", status_code=500)


        # Se crea una simulacion de resultados al analizar el proceso especifico de tipo "documento"
        resultado_doc = InsertarSimulacion(req_body, proceso_doc, session, tipo="documento")
        if not resultado_doc:
            return func.HttpResponse("No se pudo ejecutar el análisis del documento", status_code=500)


        #Insertar comentario final basado en los erores que genere la simulacion de resultados
        # Si hay elemento en el campo error de doc o comentario el documento se inserta con nuevo estado RECHAZADO
        # de lo contrario será APROBADO
        estado_final = "Rechazado" if resultado_coment.error or resultado_doc.error else "Aprobado"
        comentario_final = InsertarComentario(req_body, session, estado_override=estado_final)
        if not comentario_final:
            return func.HttpResponse("No se pudo insertar el comentario final", status_code=500)

        session.commit() #Se validan todas las restricciones para cumplir con atomicidad

        return func.HttpResponse("Comentario Insertado correctamente", status_code=201)
    
    
    except ValueError as e:
        session.rollback()  #Rollback de la sesión principal en caso de errores
        return func.HttpResponse(
            str(e),
            status_code=200
        )



'''
Desencripta la cédula (id_card) usando una clave simétrica.
Consulta vpv_Users para verificar si hay un usuario activo con esa cédula.

Entradas: "idCard" (cédula) por medio del body, session: conexión activa a la base de datos.
Salidas:True si el usuario está activo.

'''
def VerificarSesionActiva(req_body, session):
    id_card = req_body.get("idCard")    #Se toma el campo idCard del JSON

    if not id_card: #Verifica existencia del dato en el JSON
        raise ValueError("Se requiere el campo 'idCard' para verificar la sesión.")

    # Abrir la llave de desencriptación
    session.execute(text(f"OPEN SYMMETRIC KEY llavecedula DECRYPTION BY PASSWORD = '{clave}'"))

    # Buscar el idUser con la cédula desencriptada
    result = session.execute(text("""
        SELECT idUser
        FROM vpv_Users
        WHERE enable = 1 AND deleted = 0
        AND CONVERT(nvarchar(50), DECRYPTBYKEY(id_card)) = :idCard
    """), {'idCard': id_card})

    row = result.fetchone() #Guarda el resultado que arroja la consulta de la base de datos en row

    # Cerrar la llave
    session.execute(text("CLOSE SYMMETRIC KEY llavecedula"))

    if not row: #No encontro nada en la variable row? devuelve erorr
        return {"error": f"No se encontró un usuario activo con la cédula {id_card}"}, 400

    # Encontró algo, devuleve true
    return True

'''
Funcion que valida existencia de IDS externos para hacer insercion en docs
Entradas: JSON con la sección "Document" (filename, docstype, docstate, format, identitydoc).}
Salidas: Objeto insertado o sea la tabla docs
'''
def InsertDocument(req_body, session):

    #Busca la etiqueta "Documment" en el JSON, sino encuentra nada usa una lista vacía por defecto
    document_data = req_body.get("Document", [])
    
    #Verifica exisencia de datos 
    if not document_data or not isinstance(document_data, list):
        raise ValueError("Debe adjuntar un documento")

    #Busca el primer docuemnto que se guardo en document data
    document_info = document_data[0]

    #Empieza a validar que existan datos del document data
    filename = document_info.get("filename")
    if not filename:
        raise ValueError("Debe adjuntar un documento")

    #Obtiene el campo de identitydoc y hace una consulta en la tabla de IdentityDocs para saber
    #cuál es el el id que corresponde a ese nombre usando la columna referenceid (es un codigo)
    identitydoc = document_info.get("identitydoc")
    doc_identity_id = session.query(VpvIdentityDoc.identitydocsid).filter_by(referenceid=identitydoc).first()
    if not doc_identity_id:
        raise ValueError(f"No se encontró el identity de documento {identitydoc}")
    
    #Obtiene el campo de doctype y hace una consulta en la tabla de DocTypes para saber
    #cuál es el el id que corresponde a ese nombre usando la columna name
    doc_type = document_info.get("docstype")
    doc_type_id = session.query(VpvDocTypes.docstypeid).filter_by(name=doc_type).first()
    if not doc_type_id:
        raise ValueError(f"No se encontró el tipo de documento {doc_type}")
    
    #Obtiene el campo de doctype y hace una consulta en la tabla de docstates para saber
    #cuál es el el id que corresponde a ese nombre usando la columna name
    doc_state = document_info.get("docstate")
    doc_state_id = session.query(VpvDocState.docstateid).filter_by(name=doc_state).first()
    if not doc_state_id:
        raise ValueError(f"No se encontró el estado del documento {doc_state}")
    
    #Obtiene el campo de doctype y hace una consulta en la tabla de format para saber
    #cuál es el el id que corresponde a ese nombre usando la columna name
    doc_format = document_info.get("format")
    format_id = session.query(VpvFormat.formatid).filter_by(name=doc_format).first()
    if not format_id:
        raise ValueError(f"No se encontró el formato {doc_format}")
    

    #Cifrar el filename en caso de datos sensibles 
    filename_encrypted = encrypt_checksum(filename)
    now = datetime.utcnow()    #Para generar fecha actual

    # Crea el objeto para el documento o sea una tabla e inserta los valores mapeados antes
    document = VpvDoc(
        identitydocsid=doc_identity_id[0],
        formatid=format_id[0],
        docstypeid=doc_type_id[0],
        docstateid=doc_state_id[0],
        filename=filename_encrypted,
        date=now,
        enable=True,
        startdate=now,
        nextcheckdate=now + timedelta(days=30),
        semantic_category=req_body.get("semantic_category")
    )

    #Generacion del checksum
    datos_a_checksum = (document.identitydocsid, 
                        document.formatid, 
                        document.docstypeid, 
                        document.docstateid, 
                        document.filename,
                        document.date,
                        document.startdate,
                        document.nextcheckdate,
                        document.semantic_category)
    checksum = encrypt_checksum(*datos_a_checksum)

    binary_checksum = bytes(checksum, 'utf-8')


    #Se inserta el checksum y archive del doc que tambien debe ir encriptado por su tipo de dato
    document.checksum = binary_checksum 
    document.archive = binary_checksum
    
    # Inserta el documento en la bd pero hasta que se haga commit
    session.add(document)

    return document #Devuelve el objeto 

'''
Funcion que valida existencia de info wn el body externos para hacer insercion en comentario
Además de hacer insercion de comentario dependiendo del estado de work result con metadatos 
Entradas: req_body: JSON con "ProposalVersion" y sección "Comment" (incluye "comment" y "status")
Salidas: Objeto insertado o sea la tabla proposal comments
'''
def InsertarComentario(req_body, session, estado_override=None ):

    #Obtiene el campo de propversion y hace una consulta en la tabla de de verions para saber
    #cuál si existe un tittle con ese nombre
    proposal_version = req_body.get("ProposalVersion")
    proposal_version = session.query(VpvProposalVersions).filter_by(tittle=proposal_version).first() 

    # Verificar que la propuesta exista
    if not proposal_version:
        raise ValueError(f"No se encontró la propuesta con el título: {proposal_version}")

    # Verificar si los comentarios están permitidos a esa propuesta especifica 
    if not proposal_version.commentsAllowed:
        raise ValueError("Los comentarios no están permitidos para esta propuesta.")

    #Obtiene el campo de filename y hace una consulta en la tabla de de docs para saber
    #cuál es el id con ese nombre
    doc_identity_id = req_body.get("Document")[0]["filename"]
    doc_id = session.query(VpvDoc.docid).filter_by(filename=doc_identity_id).first()
    if not doc_id:
        return func.HttpResponse(f"No se encontró el documento {doc_identity_id}", status_code=400)
    
    # Otiene el nombre de estado en la etiqueta del JSON
    status_name = req_body["Comment"][0]["status"]

    #Cuando se inserta el comentario por segunda vez, viene con un Status override que debe ser ahora el 
    #nuevo status_name (Nuevo estado despues de hacer el proceso de workflow)
    if estado_override:
        status_name = estado_override

    #Consulta el id del estado segun la columna name
    status_id = session.query(VpvProcessStatus.statusId).filter_by(name=status_name).first()
    if not status_id:
        raise ValueError(f"No se encontró el estado con el nombre: {status_name}")

    #Busca el primer Commet de la lista dentro del JSON
    comment_data = req_body.get("Comment")[0]

    #Comentario cifrado por datos sensibles
    comentario = comment_data.get("comment")
    comentario_cifrado = encrypt_checksum(comentario) 

    #Insertar metadatos solo si tiene estado aprobado el comentario
    id_card = req_body.get("idCard")
    metadatos = None
    if status_name.strip().lower() == "aprobado":
        metadatos = f"Comentario Aprobado de la propuesta '{proposal_version.tittle}' por el usercard {id_card} "

    #crea la isnatncia del objeto y asigna valores mapeados
    new_comment = VpvProposalComments(
        comment=comentario_cifrado,
        madeBy=1,
        docid=doc_id[0], 
        proposalVersionId=proposal_version.proposalVersionId,
        creationDate=comment_data.get("creationDate"),
        statusId=status_id[0],
        relacion=metadatos
    )
    #Prepara checksum
    datos_a_checksum = (new_comment.comment,
                        new_comment.madeBy,
                        new_comment.docid,
                        new_comment.proposalVersionId,
                        new_comment.creationDate,
                        new_comment.statusId,
                        new_comment.relacion)
    
    checksum = encrypt_checksum(*datos_a_checksum)
    binary_checksum = bytes(checksum, 'utf-8')

    #Asignar valor del checksum
    new_comment.checksum = binary_checksum

    # Insertar el comentario en la base de datos pero no hace commit
    session.add(new_comment)
    

    return new_comment #devuelve objeto 


#-------------------PROCESO DE WORKFLOWS ---------------------

'''
Prepara los parametros para el proceso de workflow tomando datos importantes a analizar desde el body 
y recibe el tipo ya sea comentario o doc segun lo que se vaya a a analizar 
Entradas 
    req_body: JSON completo de entrada (con "Comment" o "Document").
    tipo: "comentario" o "documento". 
Salidas:
    Objeto insertado o sea la tabla de parameters
'''
def InsertarParametros(req_body, session,tipo):
    
    #Dependiendo el tipo que se reciba como parametro guarda la informacion de la etiqueta doc o comment
    #y realiza un json que representa los parametros que revisará la IA
    if tipo == "comentario":
        config = {
            "comentario": req_body.get("Comment")[0]["comment"]}

    elif tipo == "documento":
        doc = req_body.get("Document")[0]
        config = {
            "documento": doc.get("filename"),
            "tipo_doc": doc.get("docstype"),}

    else:
        raise ValueError(f"Tipo de entrada no existente")

    #Consulta el id que se utiliza para el api de IA
    api = session.query(VpvApi).filter_by(name="api-workflow-ia").first()
    if not api:
        raise ValueError("No se encontró una API con el nombre 'api-workflow-ia'.")


    nuevo_param = VpvParameters(
        idApi = api.idApi,
        name=f"param-{uuid.uuid4().hex[:6]}", #Crea un identificador unico para cada parametro que se pase por el workflow en caso que se manden el mismo json varias veces
        configuration=json.dumps(config),
        enable=True
    )

    session.add(nuevo_param)
    session.flush()  #permite actualizar el objeto tipo tabla que fue insertado esto con la finalidad de obtener el id que fue generado al momento de la insercion.

    return nuevo_param

'''
Inserta el proceso en vpv_Process con información base y relación al parámetro que sea doc o commnet
Entradas
    objeto: objeto VpvProposalComments o VpvDoc (comentario o documento).
    parametro_obj: objeto VpvParameters.
    tipo: "comentario" o "documento".
Salidas:
    Objeto insertado es decir la tabla proceso
'''
def CrearProceso(objeto, parametro_obj, session, tipo):

    # Obtener el el ID tipo de proceso con nombre 'IA' en la tabla Process Types con nombre IA
    processtype = session.query(VpvProcessTypes).filter_by(name='IA').first()
    if not processtype:
        raise ValueError("No se encontró el tipo de proceso 'IA' en la tabla processtypes")

    #Valiad el proceso que se debe llevar segun el tipo que se vaya a analizar
    if tipo == "comentario":
        referenceid = "commentId"
        referencevalue = objeto.commentId
        nombre = "Proceso IA de validación estructural"
        descripcion = "Proceso automático para validar estructura del comentario"

    elif tipo == "documento":
        referenceid = "docId"
        referencevalue = objeto.docid
        nombre = "Proceso IA de validación documental"
        descripcion = "Proceso automático para validar requisitos del documento"

    else:
        raise ValueError(f"Tipo de proceso no existente: {tipo}")

    proceso = VpvProcess(
        processtypeid=processtype.processtypeid,  
        referencevalue=referencevalue,   #Insercion del id del comentario
        referenceid=referenceid,     #Insercion de 'Commentid' para saber a qué hace refernecia el id de arriba
        parameterid=parametro_obj.parameterid,
        processmethodid=0,
        name=nombre,
        description=descripcion,
        enable=True
    )
    session.add(proceso)
    session.flush()  # para obtener el processid
    return proceso

'''
Verifica los workflow steps que se deben seguir segun el tipo para analizar.
Genera un numero random para hacer simulacion de IA y obtener erorres o exitos en el proceso 
Genera un Json que será insertado en logs para dejar registro
Entradas
    objeto: El proceso creado 
    tipo: "comentario" o "documento".
Salidas:
    Objeto insertado es decir la tabla workresultas
'''
def InsertarSimulacion(req_body, process, session, tipo):

    #Valida el tipo de validacion que se vaya a hacer y asigna un nombre con el cual buscaremos
    #los steps que debe llevar ese proceso en especifico 
    if tipo == "comentario":
        tipo_validacion = "Validacion de Comentario"
    elif tipo == "documento":
        tipo_validacion = "Validación de documento"
    else:
        raise ValueError(f"Tipo de proceso no soportado: {tipo}")

    #Realiza una consulta para saber los steps que lleva validar ese proceso ya sea comnment o doc
    #SELECT * FROM vpv_workflowsteps 
    #WHERE processtypeid = 'Validacion de comentario' o 'Validacion de documento' AND enable = 1 
    #ORDER BY steporder;   
    pasos = (
        session.query(VpvWorkflowSteps)
        .join(VpvStepTypes, VpvWorkflowSteps.steptypeid == VpvStepTypes.steptypeid)
        .filter(
            VpvWorkflowSteps.processtypeid == process.processtypeid,
            VpvWorkflowSteps.enable == True,
            VpvStepTypes.type == tipo_validacion)   #Aqui se utiliza la variable anterior
        .order_by(VpvWorkflowSteps.steporder)
        .all())

    # Simulación de cada paso
    resumen_pasos = [] #Se crea una cadena para guardar los resultados de cada paso
    hubo_error = False  

    #Recorre cada uno de los pasos que se guardaron en pasos y por cada uno hace una simulacion de aprobacion
    #usando random y dependiendo de esa condicion se guarda cada paso como un json con su resultado: APROBADO o RECHAZADO
    for paso in pasos:
        aprobado = random.random() > 0.2  # 80% chance de tener exito el resultado 
        resultado = {
            "paso": paso.name,
            "resultado": "Aprobado" if aprobado else "Falló"
        }
        resumen_pasos.append(resultado) #Agrega el resultado del obtenido en cada paso a la lista
        if not aprobado:
            hubo_error = True

    #Detalles del Json que se insertan en la tabla de WORK RESULTS
    details = json.dumps({
        "total_pasos": len(pasos),  #Conteo de los pasos 
        "errores": sum(1 for r in resumen_pasos if r["resultado"] == "Falló"),  #Suma de los errors
        "resumen": resumen_pasos    #Pasos y su debido resultado
    })

    # Crear y guardar el resultado del workflow
    workresult = VpvWorkResults(
        processid=process.processid,
        referencevalue=process.referencevalue,  #Id del proceso
        referenceid=process.referencevalue,    #Qué proceso (para dar contexto)
        timestamp=datetime.utcnow(),
        error=hubo_error,
        errorMessage=(
            f"Errores en pasos del análisis del {tipo}" if hubo_error 
            else f"{tipo.capitalize()} exitoso"
        ),
        details=details,
        performedby="IA Azure"
    )

    session.add(workresult)
    session.flush()

    #Si hubo error = TRUE llama a la funcion insertarLog para dejar registro sobre el intento del comentario
    if hubo_error:
        insertarLog(req_body, session, workresult.details)

    return workresult


'''
Funcion para dejar registro del comentario rechazado
Entradas: 
    user
    mensje de eror de work results
Salidas: Objeto insertado o sea la tabla de logs
'''
def insertarLog(req_body, session, error_msg):

    # Obtener IDs de logs
    logSeverity = session.query(VpvLogSeverity).filter_by(name='Informational').first()
    logSource = session.query(VpvLogsSource).filter_by(name='User Activity').first()
    logType = session.query(VpvLogType).filter_by(name='Info').first()

    if not logSeverity or not logSource or not logType:
        raise ValueError("No se encontraron los IDs requeridos para logSeverity, logSource o logType.")

    # Crear descripción del log y user que realiza el intento de comentar
    id_card = req_body.get("idCard")
    descripcion = f"Error: {error_msg}" #Recibe los details generados en la simulacion para saber qué falló y que no
    username = f"Comentario realizado por el usercard: {id_card}"
    fecha = f"Intento de comentario: {datetime.utcnow().strftime('%Y-%m-%d %H:%M:%S')}"


    #Crea el objeto 
    log = VpvLogs(
        description=descripcion,
        computer='computer PV',
        username=username,
        trace=None,
        referenceId1=fecha,
        referenceId2=None,
        value1=None,
        value2=None,
        logSeverityId=logSeverity.logSeverityId,
        logSourceId=logSource.logSourceId,
        logTypeId=logType.logTypeId
    )

    #calculo del checksum
    datos_a_checksum = (log.description,
                        log.computer,
                        log.username,
                        log.logSeverityId,
                        log.logSourceId,
                        log.logTypeId)
    checksum = encrypt_checksum(*datos_a_checksum)

    binary_checksum = bytes(checksum, 'utf-8')

    #Se inserta el checksum
    log.chechsum = binary_checksum

    session.add(log)
    session.flush()


