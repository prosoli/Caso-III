from sqlalchemy import Column, Integer, String, Boolean, ForeignKey
from sqlalchemy.dialects.mysql import LONGTEXT
from ..base import Base  # Se importa el Base del archivo de configuración de SQLAlchemy

class VpvParameters(Base):
    __tablename__ = 'vpv_parameters'

    parameterid = Column(Integer, primary_key=True, autoincrement=True)  
    idApi = Column(Integer, ForeignKey('vpv_api.idApi'), nullable=True)  
    name = Column(String(50), nullable=False)  
    configuration = Column(LONGTEXT, nullable=False)  
    enable = Column(Boolean, nullable=False, default=True)  
    
    def __repr__(self):
        return f"<VpvParameters(parameterid={self.parameterid}, name={self.name}, enable={self.enable})>"
