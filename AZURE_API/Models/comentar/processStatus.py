from sqlalchemy import Column, Integer, String
from ..base import Base  # Se importa el Base del archivo de configuración de SQLAlchemy

class VpvProcessStatus(Base):
    __tablename__ = 'vpv_processStatus'

    statusId = Column(Integer, primary_key=True, autoincrement=True)
    name = Column(String(50), nullable=False)

    def __repr__(self):
        return f"<VpvProcessStatus(statusId={self.statusId}, name={self.name})>"
