
from sqlalchemy import Column, Integer, String, DateTime, Boolean, ForeignKey
from .base import Base  # Se importa el Base del otro archivo

class VpvUser(Base):
    __tablename__ = 'vpv_Users'

    idUser = Column(Integer, primary_key=True, autoincrement=True)
    nationalityid = Column(Integer, ForeignKey('vpv_nationality.nationalityid'), nullable=False)
    sexid = Column(Integer, nullable=False)
    id_card = Column(String(50), nullable=False)
    name = Column(String(50), nullable=False)
    lastname = Column(String(50), nullable=False)
    birth = Column(DateTime, nullable=False)
    registration_date = Column(DateTime, nullable=False)
    is_verified = Column(Boolean, nullable=True, default=True)
    enable = Column(Boolean, nullable=True, default=True)
    deleted = Column(Boolean, nullable=True, default=False)

    def __repr__(self):
        return f"<VpvUser(idUser={self.idUser}, name={self.name}, lastname={self.lastname})>"