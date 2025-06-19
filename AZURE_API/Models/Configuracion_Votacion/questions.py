from sqlalchemy import Column, Integer, String, DateTime, Boolean, ForeignKey, Text,NVARCHAR
from ..base import Base  # Se importa el Base del otro archivo


class VpvQuestions(Base):
    __tablename__ = 'vpv_questions'

    idQuestion = Column(Integer, primary_key=True, autoincrement=True)
    idQuestionType = Column(Integer, ForeignKey("vpv_questionTypes.idQuestionType"), nullable=False)
    description = Column(String(1000), nullable=False)
    creationDate = Column(DateTime, nullable=False)
    checksum = Column(NVARCHAR(550), nullable=True)