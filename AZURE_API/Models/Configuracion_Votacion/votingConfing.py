from sqlalchemy import Column, Integer, String, DateTime, Boolean, ForeignKey, Text,VARCHAR,NVARCHAR
from ..base import Base  # Se importa el Base del otro archivo
from datetime import datetime


class VotingConfiguration(Base):
    __tablename__ = 'vpv_votingConfigurations'

    idVotingConfig = Column(Integer, primary_key=True, autoincrement=True)
    proposalVersionId = Column(Integer, ForeignKey("vpv_proposalVersions.proposalVersionId"), nullable=True)
    openDate = Column(DateTime, nullable=False)
    closeDate = Column(DateTime, nullable=False)
    creationDate = Column(DateTime, nullable=False, default=datetime.now)
    idStatusVoting = Column(Integer, ForeignKey("vpv_statusVoting.idStatusVoting"), nullable=False)
    idVotingType = Column(Integer, ForeignKey("vpv_votingTypes.idVotingType"), nullable=False)
    description = Column(VARCHAR(1000), nullable=False, default='No hay descripcion')
    weight = Column(Boolean, nullable=False, default=False)
    checksum = Column(NVARCHAR(255), nullable=True)
    idReminderType = Column(Integer, ForeignKey("vpv_reminderTypes.idReminderType"), nullable=False)
    idClosureTypes = Column(Integer, ForeignKey("vpv_ClosureTypes.idClosureTypes"), nullable=False)
    idvotingReasons = Column(Integer, ForeignKey("vpv_votingReasons.idvotingReasons"), nullable=False)
    executionPlanId = Column(Integer, ForeignKey("vpv_executionPlans.executionPlanId"), nullable=True)
    metricPlanId = Column(Integer, ForeignKey("vpv_MetricPerPlan.metricPlanId"), nullable=True)
    projectReportId = Column(Integer, nullable=True)
    sponsorAgreementId = Column(Integer, ForeignKey("vpv_sponsorAgreements.sponsorAgreementId"), nullable=True)
    governmentConditionId = Column(Integer, ForeignKey("vpv_governmentConditions.governmentConditionId"), nullable=True)