from sqlalchemy import Column, Integer, String, DateTime, Boolean, ForeignKey, Text
from ..base import Base  # Se importa el Base del otro archivo

class VpvVotingReasons(Base):
    __tablename__ = 'vpv_votingReasons'

    idvotingReasons = Column(Integer, primary_key=True, autoincrement=True)
    name = Column(String(30), nullable=False)
    description = Column(String(300), nullable=False)
    enable = Column(Boolean, nullable=False, default=True)