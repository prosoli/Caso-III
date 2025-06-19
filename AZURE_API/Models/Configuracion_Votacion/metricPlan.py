from sqlalchemy import Column, Integer, String, DateTime, Boolean, ForeignKey, Text
from ..base import Base  # Se importa el Base del otro archivo

class VpvMetricPerPlan(Base):
    __tablename__ = 'vpv_MetricPerPlan'

    metricPlanId = Column(Integer, primary_key=True, autoincrement=True)
    name = Column(String(100), nullable=False)
    idTargetPopulation = Column(Integer, ForeignKey('vpv_TargetPopulations.idTargetPopulation'), nullable=False)
    sponsorGroupId = Column(Integer, ForeignKey('vpv_sponsorGroups.sponsorGroupId'), nullable=True)
    enable = Column(Boolean, nullable=False, default=True)
    description = Column(String(100), nullable=True)
    statusId = Column(Integer, ForeignKey('vpv_processStatus.statusId'), nullable=False)
    executionPlanId = Column(Integer, ForeignKey('vpv_executionPlans.executionPlanId'), nullable=False)
