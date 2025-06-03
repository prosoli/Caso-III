from sqlalchemy import Column, Integer, String, Date, DateTime, Boolean
from sqlalchemy.ext.declarative import declarative_base

Base = declarative_base()

class CaipiUser(Base):
    __tablename__ = 'caipi_users'

    userid = Column(Integer, primary_key=True, autoincrement=True)
    username = Column(String(50), nullable=False, unique=True)
    name = Column(String(50), nullable=False)
    lastname = Column(String(50), nullable=False)
    birth = Column(Date, nullable=False)
    password = Column(String(256))
    deleted = Column(Boolean, nullable=False)
    active = Column(Boolean, nullable=False)
    last_update = Column(DateTime, nullable=False)
    registerdate = Column(Date, nullable=False)
    profile_url = Column(String(200), nullable=False)
    img_profile_url = Column(String(200), nullable=False)
    migrado = Column(Boolean, nullable=False, default=False)

    def __repr__(self):
        return f"<CaipiUser(username={self.username}, name={self.name})>"
