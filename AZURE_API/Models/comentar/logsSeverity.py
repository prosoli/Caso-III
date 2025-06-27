from sqlalchemy import Column, Integer, String
from ..base import Base  # Asegúrate de que Base viene de declarative_base()

class VpvLogSeverity(Base):
    __tablename__ = 'vpv_logSeverity'

    logSeverityId = Column(Integer, primary_key=True, autoincrement=True)
    name = Column(String(50), nullable=False)

    def __repr__(self):
        return f"<VpvLogSeverity(logSeverityId={self.logSeverityId}, name='{self.name}')>"
