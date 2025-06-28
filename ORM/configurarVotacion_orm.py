import azure.functions as func
import logging
import json
from database import SessionLocal
from sqlalchemy import text #utilizada para enviar texto a la sesion
import os #utilizado para variables de entorno
from dotenv import load_dotenv


# Carga las variables del .env
load_dotenv()
#variables de entorno
clave = os.getenv("CLAVECEDULA")

#Importacion de las tablas involucradas en el proceso
from Models.users import VpvUser
from Models.Configuracion_Votacion.allowedVoters import AllowedVoter
from Models.Configuracion_Votacion.clousureType import VpvClosureTypes
from Models.Configuracion_Votacion.executionPlan import VpvExecutionPlans
from Models.Configuracion_Votacion.governmentConditions import VpvGovernmentConditions
from Models.Configuracion_Votacion.impactZonesPerVoting import ImpactZonesPerVoting
from Models.Configuracion_Votacion.metricPlan import VpvMetricPerPlan
from Models.Configuracion_Votacion.projectReport import VpvProjectReports
from Models.Configuracion_Votacion.proposalVersion import VpvProposalVersions
from Models.Configuracion_Votacion.reminderType import ReminderType
from Models.Configuracion_Votacion.sponsor import SponsorAgreement
from Models.Configuracion_Votacion.statusVoting import StatusVoting
from Models.Configuracion_Votacion.targetPopulations import TargetPopulationsVoting
from Models.Configuracion_Votacion.votingConfing import VotingConfiguration
from Models.Configuracion_Votacion.votingQuestions import VpvVotingQuestions
from Models.Configuracion_Votacion.votingReasons import VpvVotingReasons
from Models.Configuracion_Votacion.votingRestrictions import VotingPerRestriction
from Models.Configuracion_Votacion.votingRules import VotingRule
from Models.Configuracion_Votacion.votingType import VotingType
from Models.Configuracion_Votacion.targetPopulationsVpv import VpvTargetPopulations
from Models.Configuracion_Votacion.impactZones import ImpactZones
from Models.Configuracion_Votacion.questions import VpvQuestions
from Models.Configuracion_Votacion.rules import Rule
from Models.Configuracion_Votacion.restrictions import VotingRestriction
from Endpoints_ORM.encrypt_checksum import encrypt_checksum
from Endpoints_ORM.validarPermisos import validar_permiso

'''
    Configurar votacion: Se encarga de configurar los parametros de una votacion para una propuesta especifica.
    En terminos de este sistema se configura hacia una version de la poblacion
    Parámetros del cuerpo de la solicitud (req_body) de formato JSON:
    - proposalVersion: Nombre de la propuesta a votar(El formato obligatorio es 2025-06-16T12:00:00Z).
    - openDate: Fecha y hora de apertura de la votación.
    - closeDate: Fecha y hora de cierre de la votación.
    - creationDate: Fecha en que se crea la configuración de votación.
    - VotingType: Tipo de votación (por ejemplo, "Unica").
    - description: Descripción general de la votación.
    - weight: Indica si la votación tendrá ponderación (0 o 1)Boleano.
    - ReminderType: Tipo de recordatorio a utilizar (ej. Email, Notificación).
    - ClosureTypes: Define cómo se cierra la votación (ej. "hasta que los votantes terminen").
    - VotingReasons: Justificación o motivo de la votación.

    Listas asociadas:
    - targetPopulations:
        - name: Nombre del grupo poblacional.
        - weight: Valor de ponderación asignado.
    - impactZones:
        - name: Nombre de la zona.
    - questions:
        - name: Texto de la pregunta.
        - orderBy: Orden de aparición en la boleta.
    - rules:
        - name: Nombre o título de la regla.
    - restrictions:
        - name: Descripción de la restricción.
'''

def configurarVotacionORM(req: func.HttpRequest) -> func.HttpResponse:
    logging.info('Procesando la configuracion de la votacion...')

    #VALIDO QUE EL METODO SEA POST DE LO CONTRARIO, ESTE REQUEST NO SERA PROCESADO
    if req.method != "POST":
        return func.HttpResponse(
            "Metodo no permitido. Utilice otro metodo",
            status_code=405
        )

    #Obtengo el json que se encuentra en el body
    try:
        session = SessionLocal()
        req_body = req.get_json()
        idcard = req_body.get("idCard")
        #Validacion del usuario, en este caso debe ser un proponente encargado de la configuracion y creacion de propuestas
        try:
            validar_permiso(session, idcard, 'Proponente')
        except PermissionError as e:
            return func.HttpResponse(
                json.dumps({"error": str(e)}),
                status_code=403,
                mimetype="application/json"
            )

        #Realiza la insercio de los datos que corresponden a la configuracion general de la votacion, sin contar las listas recibidas
        objInsertado = InsertVotingConfing(req_body, session)
        #Se obtiene el objeto insertado esto con la finalidad de obtener el id asi como datos importantes del mismo

        #Valida si la configuracion fue exitosa
        if not objInsertado:
            return func.HttpResponse("No se insertó la configuración de forma exitosa", status_code=500)

        #------------------Comienzo de insercion de las listas recibidas----------------------------

        #obtencion de la coleccion de segmentos de la poblacion
        target_populations = req_body.get("targetPopulations")
        if not target_populations or not isinstance(target_populations, list):#validacion de la existencia de datos
            return func.HttpResponse("Segmentos poblacionales inválidos o faltantes", status_code=400)
        #Valida la insercion exitosa
        if not InsertTargetPopulations(target_populations, objInsertado.idVotingConfig,session,objInsertado.weight):#Insercion de los segmentos de poblacion
            return func.HttpResponse("No se insertaron de forma correcta los segmentos poblacionales", status_code=500)
        
        #obtencion de la coleccion de las zonas de impacto
        impact_zones = req_body.get("impactZones")
        if not impact_zones or not isinstance(impact_zones, list):#validacion de la existencia de datos
            return func.HttpResponse("Zonas de impactos inválidas o faltantes", status_code=400)

        if not InsertImpactZones(impact_zones, objInsertado.idVotingConfig,session):
            return func.HttpResponse("No se insertaron de forma correcta las zonas de impacto", status_code=500)#Insercion de las zonas de impacto
        
        #obtencion de la coleccion de preguntas correspondientes a la configuracion
        questions = req_body.get("questions")
        if not questions or not isinstance(questions, list):
            return func.HttpResponse("Preguntas inválidas o faltantes", status_code=400)

        if not InsertQuestions(questions, objInsertado.idVotingConfig,session): #realiza y valida el resultado de la insercion a la base de datos
            return func.HttpResponse("No se insertaron de forma correcta las preguntas", status_code=500)
        
        #Obtencion de la coleccion de reglas definidas en la configuracion
        rules = req_body.get("rules")
        if not rules or not isinstance(rules, list): #validaciond e la existencia de datos
            return func.HttpResponse("Reglas inválidas o faltantes", status_code=400)

        #Intento de insercion y evaluacion del mismo en la base, se envia la lista!
        if not InsertRules(rules, objInsertado.idVotingConfig,session):
            return func.HttpResponse("No se insertaron de forma correcta las reglas", status_code=500)
        
        #Obtencion de la coleccion de restricciones definidas en la configuracion
        restrictions = req_body.get("restrictions")
        if not restrictions or not isinstance(restrictions, list):
            return func.HttpResponse("restricciones inválidas o faltantes", status_code=400)

        if not InsertRestrictions(restrictions, objInsertado.idVotingConfig,session):
            return func.HttpResponse("No se insertaron de forma correcta las restricciones", status_code=500)
        
        #Obtencion de la coleccion de votantes directos definidas en la configuracion
        votantes = req_body.get("allowedVoters")
        if not votantes or not isinstance(votantes, list):
            return func.HttpResponse("Votantes inválidas o faltantes", status_code=400)

        if not InsertAllowedVoters(votantes, objInsertado.idVotingConfig,session):
            return func.HttpResponse("No se insertaron de forma correcta los votantens directos", status_code=500)

        #Con la finalidad de hacer transacciones atomicas, se realiza el commit de la session creada hasta el final de la operacion es decir que haya pasado todas las validaciones
        session.commit()
        return func.HttpResponse("Configuración de votación insertada correctamente", status_code=201)
    #control de excepciones extras asi como rollback en la transaccion principal
    except ValueError as e:
        session.rollback()
        return func.HttpResponse(
            str(e),
            status_code=200
        )

"""
Insercion de los segmentos poblacionales, lee los nombres recibidos y identifica el id de los mismos para relacionarlo con la configuracion creadas
Entradas:   Lista de los segmentos poblacionales
            Id de la votacion insertada
            Validacion si la votacion es pesada de no ser asi no se coloca un peso
            session creada para la transaccion
"""
def InsertTargetPopulations(targetPopulations, idVotingConfig,session,weightBoolean):
    #recorro los target brindados por el usuario para ir encontrando su id y por ultimo insertarlos
    for target in targetPopulations:
        #validaciones inciales de los target ingresados
        name = target.get("name")

        #Valido si la votacion esta medida por pesos
        if weightBoolean:
            weight = target.get("weight")
        else:
            weight = None;
        
        #Valido los campos recibidos
        if not name:
            return func.HttpResponse("Cada segmento poblacional debe tener un nombre", status_code=400)
        
        if weight is not None and not isinstance(weight, (float, int)):
            return func.HttpResponse("Weight debe ser numérico o null", status_code=400)
        
        #busqueda del valor del id relacionado al name recibido
        #Target Population--------------------------------
        
        # Obtengo el objeto identificado
        targetId = session.query(VpvTargetPopulations.idTargetPopulation).filter_by(name=name, enable=True).first()

        if not targetId:
            raise ValueError(f"No se encontró el estado del target ingresado: {name}")
        
        
        #Insert el target en la tabla
        targetPopulation=TargetPopulationsVoting(
            idVotingConfig=idVotingConfig,
            idTargetPopulation=targetId[0],
            enable=True,
            weight = weight
        )

        #Calculo del checksum, envio en forma de lista los datos que quiero que sean encriptados
        datos_a_checksum = (targetPopulation.idTargetPopulation, targetPopulation.idVotingConfig, targetPopulation.weight)
        #genero el checksum por medio de la llamada del metodo
        checksum = encrypt_checksum(*datos_a_checksum)
        #Actualiza el checksum del registro a insertar
        targetPopulation.checksum = checksum;
        #realizo la insercion a la base de datos, pero no realizo commit por que no es la transaccion principal
        session.add(targetPopulation)
        

    return True

"""
Insercion de los zonas de impacto, lee los nombres recibidos y identifica el id de los mismos para relacionarlo con la configuracion creadas
Entradas:   Lista de las zonas de impacto
            Id de la votacion insertada
            session creada para la transaccion
"""
def InsertImpactZones(impactZones, idVotingConfig,session):
    #recorro las zonas brindados por el usuario para ir encontrando su id y por ultimo insertarlos
    for zone in impactZones:
        #validaciones inciales del nombre de la zona
        name = zone.get("name")

        #Valido los campos recibidos
        if not name:
            return func.HttpResponse("Cada zona de impacto debe tener un nombre", status_code=400)
        
        
        #busqueda del valor del id relacionado al name recibido
        #Impact Zone--------------------------------
        
        # Obtengo el objeto identificado
        zoneId = session.query(ImpactZones.idImpactZone).filter_by(name=name, enable=True).first()

        if not zoneId:
            raise ValueError(f"No se encontró el nombre de la zona ingresado: {name}")
        print(f"idVotingConfig = {idVotingConfig!r}")
        #Insert de la zona de impacto en la tabla
        impactZonesObj=ImpactZonesPerVoting(
            idVotingConfig=idVotingConfig,
            idImpactZones=zoneId[0],
            enable=True
        )

        #Calculo del checksum
        datos_a_checksum = (impactZonesObj.idImpactZones, impactZonesObj.idVotingConfig)
        #genero el checksum por medio de la llamada del metod
        checksum = encrypt_checksum(*datos_a_checksum)

        impactZonesObj.checksum = checksum;
        #realizo la insercion a la base de datos, pero no realizo commit por que no es la transaccion principal
        session.add(impactZonesObj)
        

    return True

"""
Insercion de las preguntas, lee los nombres recibidos y identifica el id de los mismos para relacionarlo con la configuracion creadas
Entradas:   Lista de las preguntas
            Id de la votacion insertada
            session creada para la transaccion
"""
def InsertQuestions(questions, idVotingConfig,session):
    #recorro las zonas brindados por el usuario para ir encontrando su id y por ultimo insertarlos
    for question in questions:
        #validaciones inciales del nombre de la zona
        name = question.get("name")
        orderBy = question.get("orderBy")

        #Valido los campos recibidos
        if not name:
            return func.HttpResponse("Cada pregunta debe tener nombre", status_code=400)
        if not orderBy:
            return func.HttpResponse("Cada pregunta debe tener un orden", status_code=400)
        
        #busqueda del valor del id relacionado al name recibido
        #Questions--------------------------------
        
        # Obtengo el objeto identificado
        questionId = session.query(VpvQuestions.idQuestion).filter_by(description=name).first()

        if not questionId:
            raise ValueError(f"No se encontró una pregunta con la descripcion: {name}")
        
        #Insert de la pregunta
        preguntaObj=VpvVotingQuestions(
            idQuestion=questionId[0],
            idVotingConfig=idVotingConfig,
            enable=True,
            orderBy=orderBy
        )
       
        #Calculo del checksum
        datos_a_checksum = (preguntaObj.idQuestion, preguntaObj.idVotingConfig,preguntaObj.creationDate,preguntaObj.orderBy)

        checksum = encrypt_checksum(*datos_a_checksum)

        preguntaObj.checksum = checksum;

        session.add(preguntaObj)
        
    return True

"""
Insercion de las reglas, lee los nombres recibidos y identifica el id de los mismos para relacionarlo con la configuracion creadas
Entradas:   Lista de las reglas
            Id de la votacion insertada
            session creada para la transaccion
"""
def InsertRules(rules, idVotingConfig,session):
    #recorro las zonas brindados por el usuario para ir encontrando su id y por ultimo insertarlos
    for rule in rules:
        #validaciones inciales del nombre de la zona
        name = rule.get("name")

        #Valido los campos recibidos
        if not name:
            return func.HttpResponse("Cada regla debe tener un nombre", status_code=400)
        
        
        #busqueda del valor del id relacionado al name recibido
        #Rules--------------------------------
        
        # Obtengo el objeto identificado
        ruleId = session.query(Rule.idRule).filter_by(name=name, enable=True).first()

        if not ruleId:
            raise ValueError(f"No se encontró el nombre de la regla ingresado: {name}")
        
        #Insert de la zona de impacto en la tabla
        ruleObj=VotingRule(
            idVotingConfig=idVotingConfig,
            idRule=ruleId[0]
        )

        #Calculo del checksum
        datos_a_checksum = (ruleObj.idRule, ruleObj.idVotingConfig)

        checksum = encrypt_checksum(*datos_a_checksum)

        ruleObj.checksum = checksum;
       
        session.add(ruleObj)
        

    return True


"""
Insercion de las restricciones, lee los nombres recibidos y identifica el id de los mismos para relacionarlo con la configuracion creadas
Entradas:   Lista de las restricciones
            Id de la votacion insertada
            session creada para la transaccion
"""
def InsertRestrictions(restrictions, idVotingConfig,session):
    #recorro las zonas brindados por el usuario para ir encontrando su id y por ultimo insertarlos
    for restriction in restrictions:
        #validaciones inciales del nombre de la zona
        name = restriction.get("name")

        #Valido los campos recibidos
        if not name:
            return func.HttpResponse("Cada restriction debe tener un nombre", status_code=400)
        
        
        #busqueda del valor del id relacionado al name recibido
        #restrictions--------------------------------
        
        # Obtengo el objeto identificado
        restrictionId = session.query(VotingRestriction.idRestrictions).filter_by(description=name, enable=True).first()

        if not restrictionId:
            raise ValueError(f"No se encontró el nombre de la restriccion ingresado: {name}")
        
        #Insert de la zona de impacto en la tabla
        resObj=VotingPerRestriction(
            idVotingConfig=idVotingConfig,
            idRestrictions=restrictionId[0],
            enable=True
        )

        #Calculo del checksum
        datos_a_checksum = (resObj.idVotingConfig, resObj.idRestrictions, resObj.enable)

        checksum = encrypt_checksum(*datos_a_checksum)

        resObj.checksum = checksum;
       
        session.add(resObj)
        

    return True

"""
EN CONSTRUCCION
Insercion de los votantes directos, lee los nombres recibidos y identifica el id de los mismos para relacionarlo con la configuracion creadas
Entradas:   Lista de lOS votantes directo
            Id de la votacion insertada
            session creada para la transaccion
"""
def InsertAllowedVoters(voters, idVotingConfig,session):
    #abro la llave para desencriptar las cedulas
    sql = f"OPEN SYMMETRIC KEY llavecedula DECRYPTION BY PASSWORD = '{clave}'"
    session.execute(text(sql))

    for voter in voters:
        #validaciones inciales del nombre de la zona
        idCard = voter.get("idCard")

        #Valido los campos recibidos
        if not idCard:
            return func.HttpResponse("Cada votante debe tener un idcard", status_code=400)
        
        
        #busqueda del valor del id relacionado al name recibido
        #votantes--------------------------------
        
        # Obtengo el objeto identificado
        result = session.execute(text("""
            SELECT idUser
            FROM vpv_Users
            WHERE enable = 1
            AND CONVERT(nvarchar(50), DECRYPTBYKEY(id_card)) = :idCard
        """), {'idCard': idCard})

        # Obtener el primer resultado
        row = result.fetchone()
        userId = row[0] if row else None

        
        if not userId:
            raise ValueError(f"No se encontró el usuarios ingresado: {idCard}, o el mismo no esta activo")
        
        

        #Insert de los usuarios en la tabla
        userObj=AllowedVoter(
            idVotingConfig=idVotingConfig,
            idBlindToken=userId,
            enable=True
        )

        #Calculo del checksum
        datos_a_checksum = (userObj.idVotingConfig, userObj.idBlindToken, userObj.enable,userObj.creationDate)

        checksum = encrypt_checksum(*datos_a_checksum)

        userObj.checksum = checksum;
       
        session.add(userObj)
    # Cerrar la llave
    session.execute(text("CLOSE SYMMETRIC KEY llavecedula;"))    
        

    return True


"""
Insercion de los datos generales de la votacion de la configuracion, obtiene los datos necesarios que fueron recibidos por el json, ademas, al recibir el nombre debe encontrar el id de las FK's que forman parte del registro
Entradas:   entrada tipo json con los datos recidos para obtener los necesarios
            session creada para la transaccion
"""
def InsertVotingConfing(req_body, session):

    #Obtengo los ID de las llaves foraneas utilizadas
    #Proposal Version------------------------------
    proposalName = req_body.get("proposalVersion")

    # Obtengo el objeto identificado
    proposalId = session.query(VpvProposalVersions.proposalVersionId).filter_by(tittle=proposalName, enable=True).first()

    if not proposalId:
        raise ValueError(f"No se encontró la version de propuesta con nombre: {proposalName}")
    
    #Status de votacion--------------------------------
    statusName = "Preparado"

    # Obtengo el objeto identificado
    statusId = session.query(StatusVoting.idStatusVoting).filter_by(name=statusName, enable=True).first()

    if not statusId:
        raise ValueError(f"No se encontró el estado de la propuesta con nombre: {statusName}")

    #Tipo de votacion-------------------------------
    voting_type_name = req_body.get("VotingType")

    # Obtengo el objeto identificado
    voting_type_id = session.query(VotingType.idVotingType).filter_by(name=voting_type_name, enable=True).first()

    if not voting_type_id:
        raise ValueError(f"No se encontró el tipo de votación con nombre: {voting_type_name}")
    
    #Reminder Type------------------------------
    reminderName = req_body.get("ReminderType")

    # Obtengo el objeto identificado
    reminderId = session.query(ReminderType.idReminderType).filter_by(name=reminderName, enable=True).first()

    if not reminderId:
        raise ValueError(f"No se encontró el tipo de recordatorio con nombre: {reminderName}")
    
    #Reminder Type------------------------------
    ClosureName = req_body.get("ClosureTypes")

    # Obtengo el objeto identificado
    closureId = session.query(VpvClosureTypes.idClosureTypes).filter_by(name=ClosureName, enable=True).first()

    if not closureId:
        raise ValueError(f"No se encontró el tipo de cierre con nombre: {ClosureName}")
    
    #Voting Reasons------------------------------
    reasonName = req_body.get("VotingReasons")

    # Obtengo el objeto identificado
    reasonId = session.query(VpvVotingReasons.idvotingReasons).filter_by(name=reasonName, enable=True).first()

    if not reasonId:
        raise ValueError(f"No se encontró el tipo de razon con nombre: {reasonName}")
    

    #Campos opcionales dentro dentro del tipo de razon segun la propuesta------------------------------------------
    #crea las variables y las inicializa como none para que a la hora de insertar en caso de no recibir un datos de ellos no haya problema al momento de buscar el id
    execution_plan_id = None
    if req_body.get("executionPlan"): #en caso de haber una entrada, se busca el id que corresponda al nombre en la tabla especifica y se alamcena en la variable previamente inicializada
        execution_plan_id = session.query(VpvExecutionPlans.executionPlanId).filter_by(tittle=req_body["executionPlan"]).first()
        #en caso de no haber un resultado correspondiente esto se indica
        if not execution_plan_id:
            raise ValueError(f"No se encontró el plan de ejecucion")

    metric_plan_id = None
    if req_body.get("metricPlan"):
        objId = session.query(VpvMetricPerPlan.metricPlanId).filter_by(name=req_body["metricPlan"]).first()
        if not objId:
            raise ValueError(f"No se encontró la metrica de plan")

    project_report_id = None
    if req_body.get("projectReport"):
        objId = session.query(VpvProjectReports.projectReportId).filter_by(tittle=req_body["projectReport"]).first()
        if not objId:
            raise ValueError(f"No se encontró el reporte")

    sponsor_id = None
    if req_body.get("sponsor"):
        objId = session.query(SponsorAgreement.sponsorAgreementId).filter_by(name=req_body["sponsor"]).first()
        if not objId:
            raise ValueError(f"No se encontró el sponsor")

    government_conditions_id = None
    if req_body.get("governmentConditions"):
        objId = session.query(VpvGovernmentConditions.governmentConditionId).filter_by(name=req_body["governmentConditions"]).first()
        if not objId:
            raise ValueError(f"No se encontró el sponsor")
    #Fin de los casos opcionales ---------------------------------------------------------------------------------------------------------


    #crea el objeto de la nueva configuracion de los datos de votacion asignando las variables
    nueva_config = VotingConfiguration(
        proposalVersionId=proposalId[0], #al ser una consulta se indica el comando first, no obstante me devuelve una lista es por ello que se debe indicar el elemento 0
        openDate=req_body.get("openDate"),
        closeDate=req_body.get("closeDate"),
        idStatusVoting=statusId[0],
        idVotingType=voting_type_id[0],
        description=req_body.get("description", "Sin descripción"),
        weight=req_body.get("weight", False),
        checksum=req_body.get("checksum"),
        idReminderType=reminderId[0],
        idClosureTypes=closureId[0],
        idvotingReasons=reasonId[0],
        executionPlanId = execution_plan_id[0] if execution_plan_id else None, #Validacion de la existencia de las variables opcionales
        metricPlanId = metric_plan_id[0] if metric_plan_id else None,
        projectReportId = project_report_id[0] if project_report_id else None,
        sponsorAgreementId = sponsor_id[0] if sponsor_id else None,
        governmentConditionId = government_conditions_id[0] if government_conditions_id else None
    )

    #calculo del checksum
    datos_a_checksum = (
        nueva_config.proposalVersionId,
        nueva_config.openDate,
        nueva_config.closeDate,
        nueva_config.idStatusVoting,
        nueva_config.idVotingType,
        nueva_config.description,
        nueva_config.weight,
        nueva_config.idReminderType,
        nueva_config.idClosureTypes,
        nueva_config.idvotingReasons,
        nueva_config.executionPlanId if nueva_config.executionPlanId is not None else "",
        nueva_config.metricPlanId if nueva_config.metricPlanId is not None else "",
        nueva_config.projectReportId if nueva_config.projectReportId is not None else "",
        nueva_config.sponsorAgreementId if nueva_config.sponsorAgreementId is not None else "",
        nueva_config.governmentConditionId if nueva_config.governmentConditionId is not None else ""
    )

    checksum = encrypt_checksum(*datos_a_checksum)
    #insercion del checksum a la nueva configuracion
    nueva_config.checksum = checksum


    #retorno el id de la configuracion insertada
    session.add(nueva_config)
    session.flush()#permite actualizar el objeto tipo tabla que fue insertado esto con la finalidad de obtener el id que fue generado al momento de la insercion.

    return nueva_config; #retorno el objeto actualizado junto a su ID asignado para futuras relaciones como FK en otras tablas


