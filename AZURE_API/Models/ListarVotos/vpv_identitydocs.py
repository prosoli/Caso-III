from sqlalchemy import Column, Integer, String, DateTime, Boolean, ForeignKey
from ..base import Base  

class VpvIdentityDoc(Base):
    __tablename__ = 'vpv_identitydocs'

    identitydocsid   = Column(Integer, primary_key=True, autoincrement=True)
    referencevalue   = Column(Integer, ForeignKey('vpv_reference.referencevalue'), nullable=False)   # Ajustar FK según tabla de referencia real
    referenceid      = Column(String(25), nullable=False)
    identitytypeid   = Column(Integer, ForeignKey('vpv_identitytype.identitytypeid'), nullable=False)
    identitystateid  = Column(Integer, ForeignKey('vpv_identitystate.identitystateid'), nullable=False)
    name             = Column(String(300), nullable=False)
    field1           = Column(String(500), nullable=False)
    field2           = Column(String(500), nullable=False)
    temporary        = Column(Boolean, nullable=False, default=False)
    creationdate     = Column(DateTime, nullable=False)
    enable           = Column(Boolean, nullable=False, default=True)
    expirationdate   = Column(DateTime, nullable=False)

    def __repr__(self):
        return f"<VpvIdentityDoc(id={self.identitydocsid}, referenceid={self.referenceid})>"
