from sqlalchemy import select, and_
from database import SessionLocal
from Models.votar.models import (
    Proposal, ProposalVersion, VotingConfiguration,
    PopulationFilter, TargetPopulation, TargetPopulationsVoting,
    FilterType, Demographic,
    VotingQuestion, Question, OptionQuestion
)

 
def obtener_preguntas_por_nombre(user_id: int,
                                 proposal_name: str,
                                 version_name: str,
                                 votos_list: list[dict]):
    with SessionLocal() as session:
        # 1) Propuesta
        prop = session.query(Proposal).filter(
            Proposal.tittle == proposal_name
        ).first()
        if not prop:
            raise Exception(f'Propuesta "{proposal_name}" no encontrada.')

        # 2) Versión
        pv = session.query(ProposalVersion).filter(
            ProposalVersion.proposalId == prop.proposalId,
            ProposalVersion.tittle    == version_name
        ).first()
        if not pv:
            raise Exception(f'Versión "{version_name}" no encontrada.')

        # 3) Configuración de votación
        vc = session.query(VotingConfiguration).filter(
            VotingConfiguration.proposalVersionId == pv.proposalVersionId
        ).first()
        if not vc:
            raise Exception(f'No hay configuración de votación para la versión "{version_name}".')

        # 4) Filtros demográficos (sin usar relaciones)
        filtros = (
            session.query(PopulationFilter)
                   .join(TargetPopulation,
                         PopulationFilter.idTargetPopulation == TargetPopulation.idTargetPopulation)
                   .join(TargetPopulationsVoting,
                         TargetPopulation.idTargetPopulation == TargetPopulationsVoting.idTargetPopulation)
                   .filter(TargetPopulationsVoting.idVotingConfig == vc.idVotingConfig)
                   .all()
        )
        for pf in filtros:
            ft = session.query(FilterType).filter(
                FilterType.idFilterType == pf.idFilterType
            ).first()
            match = session.query(Demographic).filter(
                and_(
                    Demographic.userid     == user_id,
                    Demographic.demotypeid == ft.demotypeid
                )
            ).first()
            if not match:
                raise Exception(f"Usuario {user_id} no cumple filtro demográfico {pf.idPopulationFilter}-{ft.name}.")

        # 5) Cargar preguntas uniendo explícitamente con la tabla vpv_questions
        preguntas = session.query(
            VotingQuestion.idVotingQuestions,
            VotingQuestion.idQuestion,
            VotingQuestion.idVotingConfig,
            Question.description.label("question_text")
        ).join(
            Question,
            VotingQuestion.idQuestion == Question.idQuestion
        ).filter(
            VotingQuestion.idVotingConfig == vc.idVotingConfig,
            VotingQuestion.enable == True
        ).order_by(VotingQuestion.orderBy).all()

        # 6) Indexar preguntas por texto
        mapa = { q.question_text: q for q in preguntas }

        resultados = {
            "proposalId":          prop.proposalId,
            "proposalVersionId":   pv.proposalVersionId,
            "proposalName":        prop.tittle,
            "proposalVersionName": pv.tittle,
            "votos": []
        }

        for voto in votos_list:
            q_text = voto["question"]
            o_text = voto["voto"]
            q = mapa.get(q_text)
            if not q:
                raise Exception(f'Pregunta "{q_text}" no encontrada.')

            # 7) Cargar opciones de esta pregunta (sin relaciones)
            opciones = session.query(
                OptionQuestion.idOptionQuestion,
                OptionQuestion.description.label("opt_text")
            ).filter(
                OptionQuestion.idQuestions == q.idQuestion,
                OptionQuestion.enable == True
            ).all()

            # 8) Buscar match por descripción
            opt = next((o for o in opciones if o.opt_text == o_text), None)
            if not opt:
                raise Exception(f'Opción "{o_text}" "{opt}" no válida para la pregunta "{q_text}".')

            resultados["votos"].append({
                "questionId":     q.idVotingQuestions,
                "votingConfigId": q.idVotingConfig,
                "optionId":       opt.idOptionQuestion,
                "voto":           o_text
            })

        return resultados
 
 