from sqlalchemy import func, case, DECIMAL, literal_column
import hashlib
from database import SessionLocal
from Models.votar.models import Vote, VoteValue, OptionQuestion, VotingQuestion, ResultsPerOption

def summarizeResults(voting_config_id: int):
    """
    Recorre todas las preguntas de una configuración de votación y
    genera/actualiza los resultados en vpv_ResultsPerOption.
    """
    with SessionLocal() as session:
        # 1) Subconsulta para totales por pregunta
        total_subq = (
            session.query(
                Vote.idVotingQuestion.label('qid'),
                func.count(Vote.idVote).label('total')
            )
            .group_by(Vote.idVotingQuestion)
            .subquery()
        )

        # 2) Agregaciones por opción (sin avg sobre value1)
        stmt = (
            session.query(
                OptionQuestion.idOptionQuestion,
                OptionQuestion.idQuestions,
                func.count(Vote.idVote).label('cnt'),
                (func.count(Vote.idVote) * 100.0
                    / func.nullif(total_subq.c.total, 0)
                ).label('pct'),
                case(
                    (func.count(Vote.idVote)
                        == func.max(func.count(Vote.idVote))
                               .over(partition_by=OptionQuestion.idQuestions),
                     True),
                    else_=False
                ).label('is_winner'),
                # avg_val siempre Null por ahora
                literal_column("NULL").label('avg_val')
            )
            .join(Vote,      Vote.idOptionQuestion == OptionQuestion.idOptionQuestion)
            .join(VoteValue, VoteValue.idVote       == Vote.idVote)
            .join(total_subq, total_subq.c.qid      == OptionQuestion.idQuestions)
            .join(VotingQuestion,
                  VotingQuestion.idQuestion == OptionQuestion.idQuestions)
            .filter(OptionQuestion.enable == True)
            .filter(VotingQuestion.idVotingConfig == voting_config_id)
            .group_by(
                OptionQuestion.idOptionQuestion,
                OptionQuestion.idQuestions,
                total_subq.c.total
            )
        )

        # 3) Upsert en ResultsPerOption
        for opt_id, q_id, cnt, pct, is_win, avg_val in session.execute(stmt):
            source = f"{voting_config_id}|{q_id}|{opt_id}|{cnt}|{pct:.2f}|{int(is_win)}|"
            chks = hashlib.sha256(source.encode("utf-8")).digest()

            existing = session.query(ResultsPerOption).filter_by(
                idVotingConfig    = voting_config_id,
                idVotingQuestions = q_id,
                idOptionQuestion  = opt_id
            ).one_or_none()

            if existing:
                existing.votesCount      = cnt
                existing.votesPercentage = round(pct or 0, 2)
                existing.winner          = is_win
                existing.average         = None
                existing.checksum        = chks
            else:
                new_row = ResultsPerOption(
                    idVotingConfig    = voting_config_id,
                    idVotingQuestions = q_id,
                    idOptionQuestion  = opt_id,
                    votesCount        = cnt,
                    votesPercentage   = round(pct or 0, 2),
                    winner            = is_win,
                    average           = None,
                    checksum          = chks,
                    enable            = True,
                    creationDate      = func.now()
                )
                session.add(new_row)

        session.commit()









