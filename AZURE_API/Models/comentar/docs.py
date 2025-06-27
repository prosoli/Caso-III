from sqlalchemy import Column, Integer, String, DateTime, Boolean, ForeignKey, LargeBinary
from ..base import Base  # Importa el Base del archivo de configuración de SQLAlchemy

class VpvDoc(Base):
    __tablename__ = 'vpv_docs'

    docid = Column(Integer, primary_key=True, autoincrement=True)  
    identitydocsid = Column(Integer, ForeignKey('vpv_identitydocs.identitydocsid'), nullable=False)  
    formatid = Column(Integer, ForeignKey('vpv_formats.formatid'), nullable=False)  
    docstypeid = Column(Integer, ForeignKey('vpv_docstypes.docstypeid'), nullable=False)  
    docstateid = Column(Integer, ForeignKey('vpv_docstates.docstateid'), nullable=False)  
    archive = Column(LargeBinary, nullable=False) 
    filename = Column(String(100), nullable=False) 
    date = Column(DateTime, nullable=False) 
    enable = Column(Boolean, nullable=False, default=True)  
    startdate = Column(DateTime, nullable=False) 
    nextcheckdate = Column(DateTime, nullable=False)  
    semantic_category = Column(String(250), nullable=True)
    checksum = Column(LargeBinary, nullable=False) 

    def __repr__(self):
        return f"<VpvDoc(docid={self.docid}, filename={self.filename})>"
