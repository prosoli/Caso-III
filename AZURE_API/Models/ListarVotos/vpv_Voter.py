from sqlalchemy import Column, Integer, LargeBinary, ForeignKey
from ..base import Base  # Se importa el Base del otro archivo

class VpvVoter(Base):
    __tablename__ = 'vpv_Voter'

    idVoter  = Column(Integer, primary_key=True, autoincrement=True)
    age      = Column(Integer, nullable=False)
    idUser   = Column(Integer, ForeignKey('vpv_Users.idUser'), nullable=True)
    checksum = Column(LargeBinary, nullable=False)

    def __repr__(self):
        return f"<VpvVoter(idVoter={self.idVoter}, age={self.age})>"
