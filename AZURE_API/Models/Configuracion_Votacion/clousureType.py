from sqlalchemy import Column, Integer, String, DateTime, Boolean, ForeignKey, Text
from ..base import Base  # Se importa el Base del otro archivo


class VpvClosureTypes(Base):
    __tablename__ = 'vpv_ClosureTypes'

    idClosureTypes = Column(Integer, primary_key=True, autoincrement=True)
    name = Column(String(50), nullable=False)
    enable = Column(Boolean, nullable=False, default=True)