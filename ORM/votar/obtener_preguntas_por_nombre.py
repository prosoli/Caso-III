from sqlalchemy import select, and_
from database import SessionLocal
from Models.votar.models import (
    Proposal, ProposalVersion, VotingConfiguration,
    PopulationFilter, TargetPopulation, TargetPopulationsVoting,
    FilterType, Demographic,
    VotingQuestion, Question, OptionQuestion
)

 
def obtener_preguntas_por_nombre(user_id: int, proposal_name: str, version_name: str, votos_list: list[dict]):
    with SessionLocal() as session:
        # 1) buscar Propuesta
        #    Hacemos un SELECT en la tabla de propuestas filtrando por titulo.
        prop = session.query(Proposal).filter(
            Proposal.tittle == proposal_name
        ).first()
        if not prop:
            # Si no existe ninguna propuesta con ese nombre, detenemos todo aqui.
            raise Exception(f'Propuesta "{proposal_name}" no encontrada.')

        # 2) buscar Version
        #    Con el ID de propuesta, buscamos su version específica por título.
        pv = session.query(ProposalVersion).filter(
            ProposalVersion.proposalId == prop.proposalId,
            ProposalVersion.tittle    == version_name
        ).first()
        if not pv:
            # De nuevo, si no existe, lanzamos excepcion.
            raise Exception(f'Versión "{version_name}" no encontrada.')

        # 3) obtener Configuración de votación
        #    Cada version puede tener una configuracion de votacion asociada.
        vc = session.query(VotingConfiguration).filter(
            VotingConfiguration.proposalVersionId == pv.proposalVersionId
        ).first()
        if not vc:
            raise Exception(f'No hay configuración de votación para la versión "{version_name}".')

        # 4) aplicar filtros demograficos
        #    - Primero obtenemos todos los PopulationFilter vinculados a esta config.
        #    - Luego, para cada filtro, validamos que el usuario cumpla el requisito en vpv_demographics.
        filtros = (
            session.query(PopulationFilter)
                   .join(TargetPopulation,
                         PopulationFilter.idTargetPopulation == TargetPopulation.idTargetPopulation)
                   .join(TargetPopulationsVoting,
                         TargetPopulation.idTargetPopulation == TargetPopulationsVoting.idTargetPopulation)
                   .filter(TargetPopulationsVoting.idVotingConfig == vc.idVotingConfig)
                   .all()
        ) # aqui validamos que el usuario cumple los filtros
        for pf in filtros:
            ft = session.query(FilterType).filter(
                FilterType.idFilterType == pf.idFilterType # comparamos el el idfiltertype de filtertype y de populationfilter
            ).first()
            match = session.query(Demographic).filter(
                and_(
                    Demographic.userid     == user_id, # obtenemos la demografias del usuario
                    Demographic.demotypeid == ft.demotypeid # y comparamos los demotype del usuario y de filtertype
                )
            ).first()
            if not match:
                raise Exception(f"Usuario {user_id} no cumple filtro demográfico {pf.idPopulationFilter}-{ft.name}.")

        # 5) Cargar preguntas uniendo explícitamente con la tabla vpv_questions
        #    Unimos VotingQuestion con Question para traer también la descripción textual.
        preguntas = session.query(
            VotingQuestion.idVotingQuestions, # obtenemos el idvotingquestion
            VotingQuestion.idQuestion, # el idquestion
            VotingQuestion.idVotingConfig, # el idvotingconfig
            Question.description.label("question_text") # y la pregunta textual
        ).join(
            Question,
            VotingQuestion.idQuestion == Question.idQuestion # unimos question y votingquestion en idquestion
        ).filter(
            VotingQuestion.idVotingConfig == vc.idVotingConfig, # donde votingquestion tengo el mismo id que el votingconfig
            VotingQuestion.enable == True
        ).order_by(VotingQuestion.orderBy).all()

        # 6) Indexar preguntas por texto
        #    Clave: texto de la pregunta → Valor: objeto con sus IDs.
        mapa = { q.question_text: q for q in preguntas }

        # Estructura inicial de resultado
        resultados = {
            "proposalId":          prop.proposalId,
            "proposalVersionId":   pv.proposalVersionId,
            "proposalName":        prop.tittle,
            "proposalVersionName": pv.tittle,
            "votos": []
        }
        
        # 7) POR CADA VOTO ENTRANTE:
        for voto in votos_list:
            q_text = voto["question"] # texto de pregunta que vino en el JSON
            o_text = voto["voto"] # texto de opción que vino en el JSON
            q = mapa.get(q_text) # buscamos el objeto pregunta por ese texto
            if not q:
                raise Exception(f'Pregunta "{q_text}" no encontrada.')

            # 7) Cargar opciones de esta pregunta (sin relaciones)
            opciones = session.query(
                OptionQuestion.idOptionQuestion, # toma el id de option question
                OptionQuestion.description.label("opt_text") # toma el description de optioinquestion y lo llame opt_text
            ).filter(
                OptionQuestion.idQuestions == q.idQuestion, # donde optionquestion y question tiene igual idquestion
                OptionQuestion.enable == True
            ).all()

            # 8) Buscar match por descripción
            opt = next((o for o in opciones if o.opt_text == o_text), None) # elige el optionquestion cuya descripcion es igual al valor del voto del usuario
            if not opt:
                raise Exception(f'Opción "{o_text}" "{opt}" no válida para la pregunta "{q_text}".')

            resultados["votos"].append({
                "questionId":     q.idVotingQuestions, # adjunta a 'votos' los siguientes ids y valor de voto
                "votingConfigId": q.idVotingConfig,
                "optionId":       opt.idOptionQuestion,
                "voto":           o_text
            })

        return resultados # retorna el diccionario con los id de proposal, version, sus titulo, y un arreglo de los ids anteriores.
 
 