from sqlalchemy import func
from Models.votar.models import ResultsPerOption, Vote
from database import SessionLocal

def updateVoteCount(voting_config_id: int, question_id: int, option_id: int):
    """
    Al llegar un nuevo voto para (voting_config_id, question_id, option_id):
    1) Incrementa en 1 el votesCount del registro de ResultsPerOption correspondiente.
       Si no existe, lo crea con votesCount=1.
    2) Recalcula votos totales para esa pregunta/config, porcentaje y marca al ganador.
    """
    with SessionLocal() as session:
        # 1) UPD or INS: incrementar votesCount
        rpo = (
            session.query(ResultsPerOption)
                   .filter_by(
                       idVotingConfig=voting_config_id,
                       idVotingQuestions=question_id,
                       idOptionQuestion=option_id
                   )
                   .with_for_update()
                   .first()
        )
        if rpo:
            rpo.votesCount += 1
        else:
            # crear nuevo registro
            rpo = ResultsPerOption(
                idVotingConfig     = voting_config_id,
                idVotingQuestions  = question_id,
                idOptionQuestion   = option_id,
                votesCount         = 1,
                votesPercentage    = 0,    # rellenamos más abajo
                winner             = False,
                enable             = True,
                creationDate       = func.getdate(),
                checksum           = b"",  # o calcula uno
                average            = None
            )
            session.add(rpo)
        session.flush()

        # 2) Recalcular totales para esa pregunta/config
        total_votes = (
            session.query(func.sum(ResultsPerOption.votesCount))
                   .filter_by(
                       idVotingConfig    = voting_config_id,
                       idVotingQuestions = question_id
                   )
                   .scalar()
        ) or 0

        # 3) Actualizar porcentaje y marcar ganador
        #    Asumimos único ganador: la opción con max(votesCount)
        max_votes = (
            session.query(func.max(ResultsPerOption.votesCount))
                   .filter_by(
                       idVotingConfig    = voting_config_id,
                       idVotingQuestions = question_id
                   )
                   .scalar()
        ) or 0

        # Primero, desmarca todos
        session.query(ResultsPerOption) \
               .filter_by(
                   idVotingConfig    = voting_config_id,
                   idVotingQuestions = question_id
               ).update({ResultsPerOption.winner: False})

        # Ahora recorre cada opción y fija porcentaje y ganador verdadero
        options = session.query(ResultsPerOption) \
                         .filter_by(
                             idVotingConfig    = voting_config_id,
                             idVotingQuestions = question_id
                         ).all()

        for opt in options:
            opt.votesPercentage = round((opt.votesCount / total_votes * 100) if total_votes else 0, 2)
            if opt.votesCount == max_votes and max_votes > 0:
                opt.winner = True

        session.commit()
