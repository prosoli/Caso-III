from sqlalchemy import Column, Integer, Boolean, DateTime, DECIMAL, LargeBinary, ForeignKey,String
from ..base import Base  # Se importa el Base del otro archivo
from datetime import datetime

class VpvGovernmentConditions(Base):
    __tablename__ = 'vpv_governmentConditions'

    governmentConditionId = Column(Integer, primary_key=True, autoincrement=True)
    enable = Column(Boolean, nullable=False, default=True)
    deleted = Column(Boolean, nullable=False, default=False)
    amount = Column(DECIMAL(10, 8), nullable=True)
    quantity = Column(Integer, nullable=True)
    checksum = Column(LargeBinary(255), nullable=False)
    govermentEntityId = Column(Integer, ForeignKey('vpv_governmentEntities.govermentEntityId'), nullable=True)
    governmentBenefitId = Column(Integer, ForeignKey('vpv_governmentBenefits.governmentBenefitId'), nullable=False)
    startDate = Column(DateTime, nullable=False, default=datetime.utcnow)
    finalDate = Column(DateTime, nullable=False, default=datetime.utcnow)
    signedDate = Column(DateTime, nullable=False, default=datetime.utcnow)
    demotypeid = Column(Integer, ForeignKey('vpv_demotype.demotypeid'), nullable=True)
    demosubtypeid = Column(Integer, ForeignKey('vpv_demosubtype.demosubtypeid'), nullable=True)
    crowdfoundingProposalId = Column(Integer, ForeignKey('vpv_crowdfoundingProposals.crowdfoundingProposalId'), nullable=False)
    access = Column(Boolean, nullable=True)
    name = Column(String(100), nullable=False)