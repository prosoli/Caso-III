from sqlalchemy import Column, Integer, String, DateTime, Boolean, ForeignKey, Text,Numeric,NVARCHAR
from ..base import Base  # Se importa el Base del otro archivo
from datetime import datetime

class VpvTargetPopulations(Base):
    __tablename__ = 'vpv_TargetPopulations'

    idTargetPopulation = Column(Integer, primary_key=True, autoincrement=True)
    name = Column(String(50), nullable=False)
    description = Column(String(500), nullable=False)
    creationDate = Column(DateTime, nullable=False, default=datetime.utcnow)
    enable = Column(Boolean, nullable=False, default=True)
    checksum = Column(NVARCHAR(255), nullable=True)