from sqlalchemy import Column, Integer, String, DateTime, Boolean, ForeignKey, Text,LargeBinary,Numeric
from ..base import Base  # Se importa el Base del otro archivo
from datetime import datetime

class VpvProjectReports(Base):
    __tablename__ = 'vpv_projectReports'

    projectReportId = Column(Integer, primary_key=True, autoincrement=True)
    creationDate = Column(DateTime, nullable=False, default=datetime.utcnow)
    enable = Column(Boolean, nullable=False, default=True)
    deleted = Column(Boolean, nullable=False, default=False)
    checksum = Column(LargeBinary(255), nullable=False)
    lastUpdated = Column(DateTime, nullable=False, default=datetime.utcnow)
    idUser = Column(Integer, ForeignKey('vpv_Users.idUser'), nullable=False)
    totalProfit = Column(Numeric(10, 2), nullable=False)
    expectedProfit = Column(Numeric(10, 2), nullable=False)
    totalLoss = Column(Numeric(10, 2), nullable=False)
    totalExpenses = Column(Numeric(10, 2), nullable=False)
    tittle = Column(String(50), nullable=False)
    description = Column(String(500), nullable=True)
    docid = Column(Integer, ForeignKey('vpv_docs.docid'), nullable=False)
    scheduleId = Column(Integer, ForeignKey('vpv_schedules.scheduleId'), nullable=False)
    crowdfoundingProposalId = Column(Integer, ForeignKey('vpv_crowdfoundingProposals.crowdfoundingProposalId'), nullable=False)
    idTargetPopulation = Column(Integer, ForeignKey('vpv_TargetPopulations.idTargetPopulation'), nullable=False)
    relacion = Column(String(500), nullable=True)
    availablePayment = Column(Numeric(18, 2), nullable=False)