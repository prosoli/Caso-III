from sqlalchemy import Column, Integer, String
from ..base import Base  # Asegúrate de importar Base correctamente

class VpvLogType(Base):
    __tablename__ = 'vpv_logTypes'

    logTypeId = Column(Integer, primary_key=True, autoincrement=True)
    name = Column(String(50), nullable=False)

    def __repr__(self):
        return f"<VpvLogType(logTypeId={self.logTypeId}, name='{self.name}')>"
