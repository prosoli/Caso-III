from sqlalchemy import Column, Integer, String
from ..base import Base  # Asegúrate de que Base esté correctamente importado

class VpvLogsSource(Base):
    __tablename__ = 'vpv_logsSources'

    logSourceId = Column(Integer, primary_key=True, autoincrement=True)
    name = Column(String(50), nullable=False)

    def __repr__(self):
        return f"<VpvLogsSource(logSourceId={self.logSourceId}, name='{self.name}')>"
