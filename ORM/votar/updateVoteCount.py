from sqlalchemy import func
from Models.votar.models import ResultsPerOption, Vote
from database import SessionLocal

def updateVoteCount(voting_config_id: int, question_id: int, option_id: int):
    """
    al llegar un nuevo voto para (voting_config_id, question_id, option_id):
    1) incrementa en 1 el votesCount del registro de ResultsPerOption correspondiente.
       si no existe, lo crea con votesCount=1.
    2) recalcula votos totales para esa pregunta/config, porcentaje y marca al ganador.
    """
    with SessionLocal() as session:
        # intento de bloqueo de fila para update o insert
        rpo = (
            session.query(ResultsPerOption)
                   .filter_by(
                       idVotingConfig=voting_config_id,
                       idVotingQuestions=question_id,
                       idOptionQuestion=option_id
                   )
                   .with_for_update()  # bloquea fila para evitar race conditions
                   .first()
        )
        if rpo:
            # si ya existe el registro, se incrementa el contador de votos
            rpo.votesCount += 1
        else:
            # si no existe, se crea uno nuevo con votesCount = 1
            rpo = ResultsPerOption(
                idVotingConfig     = voting_config_id,
                idVotingQuestions  = question_id,
                idOptionQuestion   = option_id,
                votesCount         = 1,
                votesPercentage    = 0,    # se rellenara despues
                winner             = False,
                enable             = True,
                creationDate       = func.getdate(),  # fecha de creacion actual
                checksum           = b"",  # se podria calcular un checksum real
                average            = None   # sin promedio aun
            )
            session.add(rpo)
        session.flush()  # aplica los cambios para que existan en la sesion

        # calcular el total de votos para esta pregunta y config
        total_votes = (
            session.query(func.sum(ResultsPerOption.votesCount))
                   .filter_by(
                       idVotingConfig    = voting_config_id,
                       idVotingQuestions = question_id
                   )
                   .scalar()
        ) or 0  # si es None, usar 0

        # obtener el maximo de votesCount entre opciones para definir ganador
        max_votes = (
            session.query(func.max(ResultsPerOption.votesCount))
                   .filter_by(
                       idVotingConfig    = voting_config_id,
                       idVotingQuestions = question_id
                   )
                   .scalar()
        ) or 0

        # primero, desmarcar todos como no ganadores
        session.query(ResultsPerOption) \
               .filter_by(
                   idVotingConfig    = voting_config_id,
                   idVotingQuestions = question_id
               ).update({ResultsPerOption.winner: False})

        # luego, recorrer cada opcion para actualizar porcentaje y ganador
        options = session.query(ResultsPerOption) \
                         .filter_by(
                             idVotingConfig    = voting_config_id,
                             idVotingQuestions = question_id
                         ).all()

        for opt in options:
            # calcular porcentaje redondeado a dos decimales
            opt.votesPercentage = round((opt.votesCount / total_votes * 100) if total_votes else 0, 2)
            # marcar ganador si coincide con max_votes y hay al menos un voto
            if opt.votesCount == max_votes and max_votes > 0:
                opt.winner = True

        session.commit()  # guarda todos los cambios en la base de datos
