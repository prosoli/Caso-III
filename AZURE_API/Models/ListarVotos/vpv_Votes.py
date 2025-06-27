from sqlalchemy import Column, Integer, String, DateTime, LargeBinary, ForeignKey
from ..base import Base  # Se importa el Base del otro archivo

class VpvVotes(Base):
    __tablename__ = 'vpv_Votes'

    idVote             = Column(Integer, primary_key=True, autoincrement=True)
    idVotingQuestion   = Column(Integer, ForeignKey('vpv_VotingQuestion.idVotingQuestion'), nullable=False)  # Ajusta FK según tu tabla de preguntas
    creationDate       = Column(DateTime, nullable=False)
    idToken            = Column(String(36), nullable=False)  # uniqueidentifier mapeado a String(36)
    idVoter            = Column(Integer, ForeignKey('vpv_Voter.idVoter'), nullable=False)
    idOptionQuestion   = Column(Integer, ForeignKey('vpv_OptionQuestion.idOptionQuestion'), nullable=False)
    checksum           = Column(LargeBinary, nullable=False)
    idVotingConfig     = Column(Integer, ForeignKey('vpv_VotingConfig.idVotingConfig'), nullable=True)

    def __repr__(self):
        return f"<VpvVotes(idVote={self.idVote}, idVoter={self.idVoter})>"
