from sqlalchemy import Column, Integer, String, Boolean, ForeignKey, Numeric, Unicode
from sqlalchemy.orm import relationship
from sqlalchemy.ext.declarative import declarative_base
from ..base import Base  # Se importa el Base del otro archivo

class Rule(Base):
    __tablename__ = 'vpv_Rules'

    idRule = Column(Integer, primary_key=True, autoincrement=True)
    name = Column(String(30), nullable=False)
    enable = Column(Boolean, default=True)
    idVotingRuleTypes = Column(Integer, ForeignKey('vpv_VotingRuleTypes.idVotingRuleTypes'), nullable=False)
    checksum = Column(Unicode(255), nullable=True)
    validation = Column(Boolean, nullable=True)
    amount_percentage = Column(Numeric(5, 2), nullable=True)
    quantity = Column(Integer, nullable=True)
    idVotingRuleSubType = Column(Integer, ForeignKey('vpv_VotingRuleSubType.idVotingRuleSubType'), nullable=False)
