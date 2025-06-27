from sqlalchemy import Column, Integer, String
from ..base import Base  # Se importa el Base desde otro archivo

class VpvDocTypes(Base):
    __tablename__ = 'vpv_docstypes'

    docstypeid = Column(Integer, primary_key=True, autoincrement=True)
    name = Column(String(50), nullable=True)

    def __repr__(self):
        return f"<VpvDocTypes(docstypeid={self.docstypeid}, name={self.name})>"
