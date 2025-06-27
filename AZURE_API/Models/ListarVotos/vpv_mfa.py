from sqlalchemy import Column, Integer, LargeBinary, DateTime, Boolean, ForeignKey
from ..base import Base  

class VpvMfa(Base):
    __tablename__ = 'vpv_mfa'

    mfaid = Column(Integer, primary_key=True, autoincrement=True)
    mfamethodid = Column(Integer, ForeignKey('vpv_mfamethod.mfamethodid'), nullable=False)
    userid = Column(Integer, ForeignKey('vpv_Users.idUser'), nullable=False)
    configdata = Column(LargeBinary, nullable=False)
    creationdate = Column(DateTime, nullable=False)
    lastupdate = Column(DateTime, nullable=False)
    enable = Column(Boolean, nullable=False, default=True)
    deleted = Column(Boolean, nullable=False, default=False)

    def __repr__(self):
        return f"<VpvMfa(mfaid={self.mfaid}, userid={self.userid})>"
