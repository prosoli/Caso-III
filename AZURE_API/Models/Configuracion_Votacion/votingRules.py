from sqlalchemy import Column, Integer, String, DateTime, Boolean, ForeignKey, Text,NVARCHAR
from ..base import Base  # Se importa el Base del otro archivo
from datetime import datetime

class VotingRule(Base):
    __tablename__ = 'vpv_VotingRules'

    idVotingRule = Column(Integer, primary_key=True, autoincrement=True)
    idVotingConfig = Column(Integer, ForeignKey("vpv_votingConfigurations.idVotingConfig"), nullable=False)
    idRule = Column(Integer, ForeignKey("vpv_Rules.idRule"), nullable=False)
    checksum = Column(NVARCHAR(255), nullable=True)
    creationDate = Column(DateTime, nullable=False, default=datetime.now)