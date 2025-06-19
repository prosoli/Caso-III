from sqlalchemy import Column, Integer, String, DateTime, Boolean, ForeignKey, Text,NVARCHAR
from ..base import Base  # Se importa el Base del otro archivo
from datetime import datetime


class VotingPerRestriction(Base):
    __tablename__ = 'vpv_VotingPerRestrictions'

    idVotingRestrictions = Column(Integer, primary_key=True, autoincrement=True)
    idVotingConfig = Column(Integer, ForeignKey("vpv_votingConfigurations.idVotingConfig"), nullable=False)
    idRestrictions = Column(Integer, ForeignKey("vpv_votingRestrictions.idRestrictions"), nullable=False)
    creationDate = Column(DateTime, nullable=False, default=datetime.now)
    enable = Column(Boolean, nullable=False)
    checksum = Column(NVARCHAR(250), nullable=True)