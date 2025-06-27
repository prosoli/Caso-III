from sqlalchemy import Column, Integer, String, DateTime, ForeignKey, LargeBinary
from sqlalchemy.orm import relationship
from ..base import Base  # Se importa el Base del archivo de configuración de SQLAlchemy
from datetime import datetime

class VpvLogs(Base):
    __tablename__ = 'vpv_logs'

    logId = Column(Integer, primary_key=True, autoincrement=True) 
    description = Column(String(300), nullable=True)
    computer = Column(String(100), nullable=True)  
    username = Column(String(70), nullable=False)  
    trace = Column(String(300), nullable=True)  
    referenceId1 = Column(String(300), nullable=True)  
    referenceId2 = Column(String(300), nullable=True)  
    value1 = Column(String(300), nullable=True)  
    value2 = Column(String(300), nullable=True)  
    chechsum = Column(LargeBinary(256), nullable=False)  
    logSeverityId = Column(Integer, ForeignKey('vpv_logSeverity.logSeverityId'), nullable=False)  
    logSourceId = Column(Integer, ForeignKey('vpv_logsSources.logSourceId'), nullable=False)  
    logTypeId = Column(Integer, ForeignKey('vpv_logTypes.logTypeId'), nullable=False)  

    def __repr__(self):
        return f"<VpvLogs(logId={self.logId}, username={self.username}, description={self.description})>"
