from sqlalchemy import Column, Integer, String
from ..base import Base  # Importa el Base del archivo de configuración de SQLAlchemy

class VpvDocState(Base):
    __tablename__ = 'vpv_docstates'

    docstateid = Column(Integer, primary_key=True, autoincrement=True)  
    name = Column(String(50), nullable=True)  
    description = Column(String(100), nullable=True)

    def __repr__(self):
        return f"<VpvDocState(docstateid={self.docstateid}, name={self.name}, description={self.description})>"
