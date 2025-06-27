from sqlalchemy import Column, Integer, String, DateTime, Boolean, ForeignKey
from ..base import Base  # Se importa el Base del otro archivo

class VpvOptionsQuestion(Base):
    __tablename__ = 'vpv_optionsQuestion'

    idOptionQuestion = Column(Integer, primary_key=True, autoincrement=True)
    idOptionType     = Column(Integer, ForeignKey('vpv_optionType.idOptionType'), nullable=False)
    idQuestions      = Column(Integer, ForeignKey('vpv_questions.idQuestions'), nullable=False)
    value            = Column(String(500), nullable=False)
    description      = Column(String(500), nullable=False)
    checksum         = Column(String(510), nullable=False)
    creationDate     = Column(DateTime, nullable=False)
    enable           = Column(Boolean, nullable=False, default=True)
    orderby          = Column(Integer, nullable=False)

    def __repr__(self):
        return f"<VpvOptionsQuestion(idOptionQuestion={self.idOptionQuestion}, value={self.value!r})>"
