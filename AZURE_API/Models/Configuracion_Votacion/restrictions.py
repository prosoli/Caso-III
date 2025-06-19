from sqlalchemy import Column, Integer, String, DateTime, Boolean, ForeignKey, Text,NVARCHAR, Unicode
from ..base import Base  # Se importa el Base del otro archivo
from datetime import datetime
from sqlalchemy.orm import relationship

class VotingRestriction(Base):
    __tablename__ = 'vpv_votingRestrictions'

    idRestrictions = Column(Integer, primary_key=True, autoincrement=True)
    idVotingRestrictionTypes = Column(Integer, ForeignKey('vpv_votingRestrictionTypes.idVotingRestrictionTypes'), nullable=False)
    idVotingConfig = Column(Integer, nullable=False)
    description = Column(String(280), nullable=False)
    value = Column(String(280), nullable=True)
    validation = Column(Boolean, nullable=True)
    creationDate = Column(DateTime, default=datetime.utcnow, nullable=False)
    enable = Column(Boolean, default=True, nullable=False)
    startTime = Column(DateTime, nullable=True)
    endTime = Column(DateTime, nullable=True)
    checksum = Column(Unicode(250), nullable=False)
