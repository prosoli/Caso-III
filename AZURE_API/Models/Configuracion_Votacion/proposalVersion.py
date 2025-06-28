from sqlalchemy import Column, Integer, String, DateTime, Boolean, ForeignKey, Text,Numeric,LargeBinary
from ..base import Base  # Se importa el Base del otro archivo
from datetime import datetime

class VpvProposalVersions(Base):
    __tablename__ = 'vpv_proposalVersions'
    
    proposalVersionId = Column(Integer, primary_key=True, autoincrement=True)
    tittle = Column(String(100), nullable=False)
    content = Column(String(500), nullable=False)
    creationDate = Column(DateTime, nullable=False, default=datetime.utcnow)
    startingDate = Column(DateTime, nullable=False, default=datetime.utcnow)
    scheduleId = Column(Integer, ForeignKey('vpv_schedules.scheduleId'), nullable=False)
    enable = Column(Boolean, nullable=False, default=True)
    deleted = Column(Boolean, nullable=False, default=False)
    checksum = Column(LargeBinary(255), nullable=False)
    statusid = Column(Integer, ForeignKey('vpv_processStatus.statusId'), nullable=False)
    budget = Column(Numeric(10, 8), nullable=True)
    lastUpdate = Column(DateTime, nullable=False, default=datetime.utcnow)
    idUser = Column(Integer, nullable=False)  # Asumo que no hay FK para usuarios
    proposalId = Column(Integer, ForeignKey('vpv_proposals.proposalId'), nullable=False)
    lastVersion = Column(Boolean, nullable=False, default=True)
    commentsAllowed = Column(Boolean, nullable=False, default=True)
