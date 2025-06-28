from datetime import datetime
from sqlalchemy import select
from database import SessionLocal
from Models.votar.logs import Log, LogType, LogSource, LogSeverity
import hashlib


def insertLog(description: str,
               computer: str,
               username: str,
               trace: str,
               reference1: str = None,
               reference2: str = None,
               value1: str = None,
               value2: str = None,
               severity_name: str = 'Informational',
               source_name: str = 'Application',
               type_name: str = 'Info') -> Log:
    """
    Inserta un registro en vpv_logs. Busca o crea severidad, fuente y tipo.
    Retorna la instancia Log creada.
    """
    
    MAX_LEN = 300
    # Recorta los strings largos
    reference1 = reference1[:MAX_LEN] if reference1 else None
    reference2 = reference2[:MAX_LEN] if reference2 else None
    # aquí el recorte crucial:
    value1 = value1[:MAX_LEN] if value1 else None
    value2 = value2[:MAX_LEN] if value2 else None
    
    # abre un contexto de sesión para operar en la BDD
    with SessionLocal() as session:
        # 1) buscar  LogSeverity
        sev = session.execute(
            select(LogSeverity).where(LogSeverity.name == severity_name)
        ).scalars().first()                # obtiene la fila si existe
        if not sev:                        # si no existe, la crea
            sev = LogSeverity(name=severity_name)
            session.add(sev)
            session.flush()               

        # 2) Buscar  LogSource
        src = session.execute(
            select(LogSource).where(LogSource.name == source_name)
        ).scalars().first()
        if not src:
            src = LogSource(name=source_name)
            session.add(src)
            session.flush()              

        # 3) Buscar  LogType
        typ = session.execute(
            select(LogType).where(LogType.name == type_name)
        ).scalars().first()
        if not typ:
            typ = LogType(name=type_name)
            session.add(typ)
            session.flush()                

        # 4) Calcular checksum SHA-256 de la concatenación de los campos relevantes
        data = '|'.join(filter(None, [
                        description, computer, username, trace,
                        reference1, reference2, value1, value2]))
        checksum = hashlib.sha256(data.encode('utf-8')).digest()

        # 5) Construir la nueva instancia Log

        log = Log(
            description=description,
            computer=computer,
            username=username,
            trace=trace,
            referenceId1=reference1,
            referenceId2=reference2,
            value1=value1,
            value2=value2,
            chechsum=checksum,
            logSeverityId=sev.logSeverityId,
            logSourceId=src.logSourceId,
            logTypeId=typ.logTypeId
        )
        session.add(log)
        session.flush()
        return log
