from sqlalchemy import Column, Integer, String, DateTime, Boolean, ForeignKey
from ..base import Base  # Se importa el Base del otro archivo

class VpvVotingConfigurations(Base):
    __tablename__ = 'vpv_votingConfigurations'

    idVotingConfig      = Column(Integer, primary_key=True, autoincrement=True)
    proposalVersionId   = Column(Integer, ForeignKey('vpv_ProposalVersion.proposalVersionId'), nullable=True)
    openDate            = Column(DateTime, nullable=False)
    closeDate           = Column(DateTime, nullable=False)
    creationDate        = Column(DateTime, nullable=False)
    idStatusVoting      = Column(Integer, ForeignKey('vpv_StatusVoting.idStatusVoting'), nullable=False)
    idVotingType        = Column(Integer, ForeignKey('vpv_VotingType.idVotingType'), nullable=False)
    description         = Column(String(1000), nullable=False)
    weight              = Column(Boolean, nullable=False)
    checksum            = Column(String(510), nullable=True)
    idReminderType      = Column(Integer, ForeignKey('vpv_ReminderType.idReminderType'), nullable=False)
    idClosureTypes      = Column(Integer, ForeignKey('vpv_ClosureTypes.idClosureTypes'), nullable=False)
    idVotingReasons     = Column(Integer, ForeignKey('vpv_VotingReasons.idVotingReasons'), nullable=False)
    executionPlanId     = Column(Integer, ForeignKey('vpv_ExecutionPlan.executionPlanId'), nullable=True)
    metricPlanId        = Column(Integer, ForeignKey('vpv_MetricPlan.metricPlanId'), nullable=True)
    projectReportId     = Column(Integer, ForeignKey('vpv_ProjectReport.projectReportId'), nullable=True)
    sponsorAgreementId  = Column(Integer, ForeignKey('vpv_SponsorAgreement.sponsorAgreementId'), nullable=True)
    governmentContractId= Column(Integer, ForeignKey('vpv_GovernmentContract.governmentContractId'), nullable=True)

    def __repr__(self):
        return f"<VpvVotingConfigurations(idVotingConfig={self.idVotingConfig})>"
