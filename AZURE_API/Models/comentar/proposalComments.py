from sqlalchemy import Column, Integer, String, DateTime, Boolean, ForeignKey, LargeBinary
from ..base import Base  # Se importa el Base del archivo de configuración de SQLAlchemy
from datetime import datetime

class VpvProposalComments(Base):
    __tablename__ = 'vpv_proposalComments'

    commentId = Column(Integer, primary_key=True, autoincrement=True)
    comment = Column(String(500), nullable=False)
    madeBy = Column(Integer, ForeignKey('vpv_Users.idUser'), nullable=False)  
    enable = Column(Boolean, nullable=False, default=True)
    deleted = Column(Boolean, nullable=False, default=False)
    docid = Column(Integer, ForeignKey('vpv_docs.docid'), nullable=False)  
    proposalVersionId = Column(Integer, ForeignKey('vpv_proposalVersions.proposalVersionId'), nullable=False)  # Relación con tabla vpv_proposalVersions
    creationDate = Column(DateTime, nullable=False, default=datetime.utcnow)
    statusId = Column(Integer, ForeignKey('vpv_processStatus.statusId'), nullable=False)  
    checksum = Column(LargeBinary(255), nullable=False)
    relacion = Column(String(200), nullable=True)  

    def __repr__(self):
        return f"<VpvProposalComments(commentId={self.commentId}, comment={self.comment}, madeBy={self.madeBy})>"
