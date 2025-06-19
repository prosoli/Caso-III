from sqlalchemy import Column, Integer, String, DateTime, Boolean, ForeignKey, Text,LargeBinary,NVARCHAR
from ..base import Base  # Se importa el Base del otro archivo
from datetime import datetime


class AllowedVoter(Base):
    __tablename__ = 'vpv_AllowedVoters'

    idAllowerVoter = Column(Integer, primary_key=True, autoincrement=True)
    idBlindToken = Column(Integer, nullable=False)
    idVotingConfig = Column(Integer, ForeignKey("vpv_votingConfigurations.idVotingConfig"), nullable=False)
    creationDate = Column(DateTime, nullable=False, default=datetime.now)
    enable = Column(Boolean, nullable=False, default=True)
    checksum = Column(NVARCHAR(255), nullable=True)