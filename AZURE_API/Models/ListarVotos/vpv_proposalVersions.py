from sqlalchemy import Column, Integer, String, DateTime, Boolean, ForeignKey, LargeBinary, Numeric
from ..base import Base  # Se importa el Base del otro archivo

class VpvProposalVersion(Base):
    __tablename__ = 'vpv_proposalVersions'

    proposalVersionId = Column(Integer, primary_key=True, autoincrement=True)
    title             = Column(String(200), nullable=False)
    content           = Column(String(1000), nullable=False)
    creationDate      = Column(DateTime, nullable=False)
    startingDate      = Column(DateTime, nullable=False)
    scheduleId        = Column(Integer, ForeignKey('vpv_Schedule.scheduleId'), nullable=False)    # Ajusta FK si tu tabla de schedule tiene otro nombre
    enable            = Column(Boolean, nullable=False, default=True)
    deleted           = Column(Boolean, nullable=False, default=False)
    checksum          = Column(LargeBinary(255), nullable=False)
    statusId          = Column(Integer, ForeignKey('vpv_Status.statusId'), nullable=False)        # Ajusta FK según tu tabla de status
    budget            = Column(Numeric(18, 2), nullable=True)
    lastUpdate        = Column(DateTime, nullable=False)
    idUser            = Column(Integer, ForeignKey('vpv_Users.idUser'), nullable=False)
    proposalId        = Column(Integer, ForeignKey('vpv_Proposal.proposalId'), nullable=False)    # Ajusta FK según tu tabla de proposal
    lastVersion       = Column(Boolean, nullable=False, default=False)

    def __repr__(self):
        return f"<VpvProposalVersion(id={self.proposalVersionId}, title={self.title!r})>"
