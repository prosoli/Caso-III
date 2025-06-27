from sqlalchemy import Column, Integer, String
from ..base import Base  # Se importa el Base del otro archivo

class VpvFormat(Base):
    __tablename__ = 'vpv_formats'

    formatid = Column(Integer, primary_key=True, autoincrement=True)
    name = Column(String(50), nullable=True)

    def __repr__(self):
        return f"<VpvFormat(formatid={self.formatid}, name={self.name})>"
