from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
import urllib
import os

# Cadena de conexión desde variable de entorno
conn_str = os.getenv("SQL_CONNECTION_STRING")

# Formatea para el SQLAlchemy
params = urllib.parse.quote_plus(conn_str)
engine = create_engine(f"mssql+pyodbc:///?odbc_connect={params}", echo=True)

SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)