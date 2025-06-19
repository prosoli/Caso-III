from sqlalchemy import Column, Integer, String, DateTime, Boolean, ForeignKey, Text,Numeric,NVARCHAR
from ..base import Base  # Se importa el Base del otro archivo

class TargetPopulationsVoting(Base):
    __tablename__ = 'vpv_TargetPopulationsVoting'

    idVotingConfig = Column(Integer, ForeignKey("vpv_votingConfigurations.idVotingConfig"), primary_key=True)
    idTargetPopulation = Column(Integer, ForeignKey("vpv_TargetPopulations.idTargetPopulation"), primary_key=True)
    checksum = Column(NVARCHAR(255), nullable=True)
    enable = Column(Boolean, nullable=False)
    weight = Column(Numeric(5, 2), nullable=True)