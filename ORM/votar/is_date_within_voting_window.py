from datetime import datetime
from sqlalchemy import select
from database import SessionLocal
from Models.votar.models import VotingConfiguration



def is_date_within_voting_window(proposal_version_id: int, date_to_check: datetime) -> bool:
    """
    Devuelve True si `date_to_check` cae entre openDate y closeDate
    para la configuración que coincide con `proposal_version_id`.
    """
    with SessionLocal() as session:
        stmt = (
            select(VotingConfiguration.openDate, VotingConfiguration.closeDate)  # toma las fechas de apertura y de cierre
            .where(VotingConfiguration.proposalVersionId == proposal_version_id) # donde voting config tenga el mismo version id
        )
        row = session.execute(stmt).first()
        if not row:
            # No existe configuración para esa versión
            return False

        open_dt, close_dt = row.openDate, row.closeDate
        return open_dt <= date_to_check <= close_dt # checa que la fecha en que se vota este en el medio
    