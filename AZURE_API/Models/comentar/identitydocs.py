from sqlalchemy import Column, Integer, String, DateTime, Boolean, ForeignKey
from ..base import Base  # Se importa el Base del archivo de configuración de SQLAlchemy

class VpvIdentityDoc(Base):
    __tablename__ = 'vpv_identitydocs'

    identitydocsid = Column(Integer, primary_key=True, autoincrement=True) 
    referencevalue = Column(Integer, nullable=False)  
    referenceid = Column(String(25), nullable=False) 
    identitytypeid = Column(Integer, ForeignKey('vpv_identitytype.identitytypeid'), nullable=False) 
    identitystateid = Column(Integer, ForeignKey('vpv_identitystates.identitystateid'), nullable=False)  
    name = Column(String(150), nullable=False) 
    field1 = Column(String(250), nullable=False) 
    field2 = Column(String(250), nullable=False) 
    temporary = Column(Boolean, default=True, nullable=False)  
    creationdate = Column(DateTime, nullable=False) 
    enable = Column(Boolean, default=True, nullable=False)  
    expirationdate = Column(DateTime, nullable=False)  

    def __repr__(self):
        return f"<VpvIdentityDoc(identitydocsid={self.identitydocsid}, referenceid={self.referenceid}, name={self.name})>"
