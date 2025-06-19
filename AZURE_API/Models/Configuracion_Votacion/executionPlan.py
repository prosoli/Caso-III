from sqlalchemy import Column, Integer, String, DateTime, Boolean, ForeignKey, Text,LargeBinary
from datetime import datetime
from ..base import Base  # Se importa el Base del otro archivo


class VpvExecutionPlans(Base):
    __tablename__ = 'vpv_executionPlans'

    executionPlanId = Column(Integer, primary_key=True)
    tittle = Column(String(50), nullable=False)
    description = Column(String(200), nullable=True)
    startDate = Column(DateTime, nullable=True, default=datetime.utcnow)
    finalDate = Column(DateTime, nullable=True, default=datetime.utcnow)
    checksum = Column(LargeBinary(255), nullable=False)
    idUser = Column(Integer, ForeignKey('vpv_Users.idUser'), nullable=False)
    statusId = Column(Integer, ForeignKey('vpv_processStatus.statusId'), nullable=False)
    scheduleId = Column(Integer, ForeignKey('vpv_schedules.scheduleId'), nullable=False)
    crowdfoundingProposalId = Column(Integer, ForeignKey('vpv_crowdfoundingProposals.crowdfoundingProposalId'), nullable=False)
    paymentPlanId = Column(Integer, ForeignKey('vpv_paymentPlans.paymentPlanId'), nullable=False)
    idTargetPopulation = Column(Integer, ForeignKey('vpv_TargetPopulations.idTargetPopulation'), nullable=False)
    idMeasureUnit = Column(Integer, ForeignKey('vpv_UnitMeasure.idUnitMeasure'), nullable=False)
    duracion = Column(Integer, nullable=False)