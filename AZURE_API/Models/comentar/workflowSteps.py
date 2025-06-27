from sqlalchemy import Column, Integer, String, Boolean, ForeignKey
from sqlalchemy.orm import relationship
from ..base import Base  # Se importa el Base del otro archivo

class VpvWorkflowSteps(Base):
    __tablename__ = 'vpv_workflowsteps'

    workflowid = Column(Integer, primary_key=True, autoincrement=True)
    processtypeid = Column(Integer, ForeignKey('vpv_processtypes.processtypeid'), nullable=False)
    steptypeid = Column(Integer, ForeignKey('vpv_steptypes.steptypeid'), nullable=False)
    steporder = Column(Integer, nullable=False)
    name = Column(String(85), nullable=False)
    manual = Column(Boolean, nullable=False, default=True)
    enable = Column(Boolean, nullable=False, default=True)

    def __repr__(self):
        return f"<VpvWorkflowSteps(workflowid={self.workflowid}, name={self.name})>"
