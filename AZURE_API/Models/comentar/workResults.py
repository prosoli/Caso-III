from sqlalchemy import Column, Integer, String, DateTime, Boolean, ForeignKey, Text
from ..base import Base  # Se importa el Base del archivo de configuración de SQLAlchemy
from datetime import datetime

class VpvWorkResults(Base):
    __tablename__ = 'vpv_workresults'

    workresultid = Column(Integer, primary_key=True, autoincrement=True)
    processid = Column(Integer, ForeignKey('vpv_process.processid'), nullable=False)
    referencevalue = Column(Integer, nullable=False)
    referenceid = Column(Integer, nullable=False)
    timestamp = Column(DateTime, nullable=False, default=datetime.utcnow)
    error = Column(Boolean, nullable=False, default=False)
    errorMessage = Column(String(250), nullable=False)
    details = Column(Text, nullable=False)
    performedby = Column(String(50), nullable=False)

    def __repr__(self):
        return f"<VpvWorkResults(workresultid={self.workresultid}, processid={self.processid}, performedby={self.performedby})>"
