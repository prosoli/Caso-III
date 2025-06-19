from sqlalchemy import Column, Integer, String, DateTime, Boolean, ForeignKey, Text,Numeric,NVARCHAR
from ..base import Base  # Se importa el Base del otro archivo
from datetime import datetime

class ImpactZones(Base):
    __tablename__ = 'vpv_ImpactZones'

    idImpactZone = Column(Integer, primary_key=True, autoincrement=True)  # Asumiendo que hay una PK autoincremental
    name = Column(String(50), nullable=False)
    description = Column(String(500), nullable=False)
    creationDate = Column(DateTime, nullable=False, default=datetime.utcnow)
    enable = Column(Boolean, nullable=False, default=True)
    value = Column(String(500), nullable=False)
    idImpactZoneTypes = Column(Integer, ForeignKey("vpv_ImpactZoneTypes.idImpactZoneTypes"), nullable=False)
    checksum = Column(NVARCHAR(255), nullable=True)