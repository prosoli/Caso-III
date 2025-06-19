from sqlalchemy import Column, Integer, String, DateTime, Boolean, ForeignKey, Text
from ..base import Base  # Se importa el Base del otro archivo

class ReminderType(Base):
    __tablename__ = 'vpv_reminderTypes'

    idReminderType = Column(Integer, primary_key=True)
    name = Column(String(50), nullable=False)
    enable = Column(Boolean, default=False)