from sqlalchemy import Column, Integer, String, VARBINARY, ForeignKey, func, select
from sqlalchemy.dialects.mssql import TIMESTAMP
from sqlalchemy.orm import relationship, declarative_base, Session

Base = declarative_base()

class LogSeverity(Base):
    __tablename__ = 'vpv_logSeverity'
    logSeverityId = Column(Integer, primary_key=True, autoincrement=True)
    name          = Column(String(50), nullable=False, unique=True)

class LogSource(Base):
    __tablename__ = 'vpv_logsSources'
    logSourceId = Column(Integer, primary_key=True, autoincrement=True)
    name        = Column(String(50), nullable=False, unique=True)

class LogType(Base):
    __tablename__ = 'vpv_logTypes'
    logTypeId = Column(Integer, primary_key=True, autoincrement=True)
    name      = Column(String(50), nullable=False, unique=True)

class Log(Base):
    __tablename__ = 'vpv_logs'
    logId         = Column(Integer, primary_key=True, autoincrement=True)
    description   = Column(String(80))
    # postime       = Column(TIMESTAMP, nullable=False, insertable=False)
    computer      = Column(String(100))
    username      = Column(String(70), nullable=False)
    trace         = Column(String(300))
    referenceId1  = Column(String(300))
    referenceId2  = Column(String(300))
    value1        = Column(String(300))
    value2        = Column(String(300))
    chechsum      = Column(VARBINARY(256), nullable=False)
    logSeverityId = Column(Integer, ForeignKey('vpv_logSeverity.logSeverityId'), nullable=False)
    logSourceId   = Column(Integer, ForeignKey('vpv_logsSources.logSourceId'), nullable=False)
    logTypeId     = Column(Integer, ForeignKey('vpv_logTypes.logTypeId'), nullable=False)

    severity = relationship('LogSeverity')
    source   = relationship('LogSource')
    type     = relationship('LogType')