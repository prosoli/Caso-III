from sqlalchemy import Column, Integer, String, DateTime, Boolean, ForeignKey
from ..base import Base  # Se importa el Base del otro archivo

class VpvEncryptionKey(Base):
    __tablename__ = 'vpv_encryptionkeys'

    keyid        = Column(Integer, primary_key=True, autoincrement=True)
    userid       = Column(Integer, ForeignKey('vpv_Users.idUser'), nullable=False)
    key          = Column(String(510), nullable=False)
    creationdate = Column(DateTime, nullable=False)
    enable       = Column(Boolean, nullable=False, default=True)
    checksum     = Column(String(510), nullable=False)

    def __repr__(self):
        return f"<VpvEncryptionKey(keyid={self.keyid}, userid={self.userid})>"
