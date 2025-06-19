from sqlalchemy import Column, Integer, String, DateTime, Boolean, ForeignKey, Text,NVARCHAR
from ..base import Base  # Se importa el Base del otro archivo

class ImpactZonesPerVoting(Base):
    __tablename__ = 'vpv_ImpactZonesPerVoting'

    idImpactZonesPerVoting = Column(Integer, primary_key=True, autoincrement=True)
    idVotingConfig = Column(Integer, ForeignKey("vpv_votingConfigurations.idVotingConfig"), nullable=False)
    idImpactZones = Column(Integer, ForeignKey("vpv_ImpactZones.idImpactZone"), nullable=False)
    checksum = Column(NVARCHAR(550), nullable=True)
    enable = Column(Boolean, nullable=False)