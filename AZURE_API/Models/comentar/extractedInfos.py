from sqlalchemy import Column, Integer, String, Boolean, ForeignKey
from ..base import Base  # Se importa el Base del archivo de configuración de SQLAlchemy
from sqlalchemy.orm import relationship

class VpvExtractedInfos(Base):
    __tablename__ = 'vpv_extractedinfos'

    extractinfoid = Column(Integer, primary_key=True, autoincrement=True)  # Utilizamos un Integer ya que SQL Server maneja 'bigint' como 'Integer'
    workresultid = Column(Integer, ForeignKey('vpv_workresults.workresultid'), nullable=False)  # Relación con la tabla vpv_workresults
    field_value = Column(String(100), nullable=False)  # Campo obligatorio con valor de tipo texto
    comments = Column(String(100), nullable=False)  # Campo obligatorio para los comentarios
    error = Column(Boolean, nullable=False, default=False)  # Campo booleano que indica si hay error (default: False)

    def __repr__(self):
        return f"<VpvExtractedInfos(extractinfoid={self.extractinfoid}, workresultid={self.workresultid}, comments={self.comments})>"
