from sqlalchemy import Column, Integer, String
from ..base import Base  # Se importa el Base del archivo de configuración de SQLAlchemy

class VpvProcessTypes(Base):
    __tablename__ = 'vpv_processtypes'

    processtypeid = Column(Integer, primary_key=True, autoincrement=True)  # Identificador único y autoincremental
    name = Column(String(100), nullable=False)  # Nombre del tipo de proceso, obligatorio con un máximo de 100 caracteres

    def __repr__(self):
        return f"<VpvProcessTypes(processtypeid={self.processtypeid}, name={self.name})>"
