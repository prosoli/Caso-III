from sqlalchemy import Column, Integer, String, DateTime, Boolean, ForeignKey, Text,VARCHAR,NVARCHAR
from ..base import Base  # Se importa el Base del otro archivo
from datetime import datetime
from sqlalchemy.sql import func


class VpvVotingQuestions(Base):
    __tablename__ = 'vpv_votingQuestions'

    idVotingQuestions = Column(Integer, primary_key=True, autoincrement=True)
    idQuestion = Column(Integer, ForeignKey("vpv_questions.idQuestion"), nullable=False)
    idVotingConfig = Column(Integer, ForeignKey("vpv_votingConfigurations.idVotingConfig"), nullable=False)
    enable = Column(Boolean, nullable=False, default=True)
    creationDate = Column(DateTime, nullable=False, server_default=func.getdate())
    checksum = Column(NVARCHAR(100), nullable=True)
    orderBy = Column(Integer, nullable=False, default=0)