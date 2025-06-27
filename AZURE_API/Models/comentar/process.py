from sqlalchemy import Column, Integer, String, DateTime, Boolean, ForeignKey, Numeric
from ..base import Base  # Se importa el Base del otro archivo
from datetime import datetime

class VpvProcess(Base):
    __tablename__ = 'vpv_process'

    processid = Column(Integer, primary_key=True, autoincrement=True)
    processtypeid = Column(Integer, ForeignKey('vpv_processtypes.processtypeid'), nullable=False)
    referencevalue = Column(Integer, nullable=False)
    referenceid = Column(String(25), nullable=False)
    parameterid = Column(Integer, ForeignKey('vpv_parameters.parameterid'), nullable=False)
    processmethodid = Column(Integer, nullable=False)  # Necesita ver si hay una tabla relacionada
    name = Column(String(100), nullable=False)
    description = Column(String(100), nullable=False)
    enable = Column(Boolean, nullable=False, default=True)
    fecha = Column(DateTime, nullable=True)
    order = Column(Integer, nullable=True)

    def __repr__(self):
        return f"<VpvProcess(processid={self.processid}, name={self.name}, description={self.description})>"

