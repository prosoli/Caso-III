from sqlalchemy import Column, Integer, String, DateTime
from ..base import Base  # Se importa el Base del archivo de configuración de SQLAlchemy
from datetime import datetime

class VpvApi(Base):
    __tablename__ = 'vpv_api'

    idApi = Column(Integer, primary_key=True, autoincrement=True)  # Identificador único y autoincremental
    name = Column(String(50), nullable=False)  # Nombre del API, obligatorio con un máximo de 50 caracteres
    descripcion = Column(String, nullable=False)  # Descripción del API, obligatorio (se usa String para el tipo TEXT)
    base_url = Column(String(200), nullable=False)  # URL base del API, obligatorio con un máximo de 200 caracteres
    creacionDate = Column(DateTime, nullable=False, default=datetime.utcnow)  # Fecha de creación, con valor por defecto de la fecha actual
    updateDate = Column(DateTime, nullable=False, default=datetime.utcnow)  # Fecha de última actualización, con valor por defecto de la fecha actual

    def __repr__(self):
        return f"<VpvApi(idApi={self.idApi}, name={self.name}, base_url={self.base_url})>"
