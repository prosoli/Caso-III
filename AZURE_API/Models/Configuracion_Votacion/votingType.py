from sqlalchemy import Column, Integer, String, DateTime, Boolean, ForeignKey, Text
from ..base import Base  # Se importa el Base del otro archivo

class VotingType(Base):
    __tablename__ = "vpv_votingTypes"

    idVotingType = Column(Integer, primary_key=True, index=True)
    name = Column(String(30), nullable=False)
    enable = Column(Boolean, default=True)