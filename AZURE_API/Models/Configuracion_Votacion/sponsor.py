from sqlalchemy import Column, Integer, String, DateTime, Boolean, ForeignKey, Text,Numeric,LargeBinary
from ..base import Base  # Se importa el Base del otro archivo
from datetime import datetime

class SponsorAgreement(Base):
    __tablename__ = 'vpv_sponsorAgreements'

    sponsorAgreementId = Column(Integer, primary_key=True)
    enable = Column(Boolean, default=True)
    checksum = Column(LargeBinary(255), nullable=False)
    startDate = Column(DateTime, default=datetime.utcnow)
    finalDate = Column(DateTime, default=datetime.utcnow)
    signedDate = Column(DateTime, default=datetime.utcnow)
    deleted = Column(Boolean, default=False)
    currencyId = Column(Integer, ForeignKey('vpv_currencies.currencyId'), nullable=False)
    scheduleId = Column(Integer, ForeignKey('vpv_schedules.scheduleId'), nullable=False)
    noReward = Column(Boolean)
    percentage = Column(Numeric(10, 8))
    product = Column(Boolean)
    amount = Column(Numeric(10, 8))
    shares = Column(Integer)
    baseSalary = Column(Numeric(10, 8))
    sponsorAgreementTypeId = Column(Integer, ForeignKey('vpv_sponsorAgrementsType.sponsorAgreementTypeId'), nullable=False)
    sponsorGroupId = Column(Integer, ForeignKey('vpv_sponsorGroups.sponsorGroupId'))
    crowdfoundingProposalId = Column(Integer, ForeignKey('vpv_crowdfoundingProposals.crowdfoundingProposalId'), nullable=False)
    inversion = Column(Numeric(10, 8), nullable=False)
    name = Column(String(250), nullable=False)