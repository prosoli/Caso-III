from sqlalchemy import Column, Integer, String
from ..base import Base  # Se importa el Base del archivo de configuración de SQLAlchemy

class VpvStepTypes(Base):
    __tablename__ = 'vpv_steptypes'

    steptypeid = Column(Integer, primary_key=True, autoincrement=True)  # Identificador único y autoincremental
    type = Column(String(50), nullable=False)  # Tipo de paso, obligatorio, con un máximo de 50 caracteres

    def __repr__(self):
        return f"<VpvStepTypes(steptypeid={self.steptypeid}, type={self.type})>"
