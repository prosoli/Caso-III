/****** Object:  View [dbo].[vw_ResultPerOption_ByQuestion]    Script Date: 25/6/2025 11:46:27 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER   VIEW [dbo].[vw_ResultPerOption_ByQuestion] AS
SELECT
    vc.RowNum,
    vc.idVotingConfig,
    vc.description AS VotingConfigName,
    q.idVotingQuestions,
    qs.description AS QuestionDescription,
    o.idOptionQuestion,
    o.value AS OptionValue,
    o.description AS OptionDescription,
    rpo.votesCount,
    rpo.votesPercentage,
    rpo.winner
FROM vw_RecentVotingConfigs vc
JOIN vpv_votingQuestions q ON q.idVotingConfig = vc.idVotingConfig
INNER JOIN vpv_questions qs ON q.idQuestion = qs.idQuestion
JOIN vpv_OptionsQuestion o ON q.idQuestion = o.idQuestions
LEFT JOIN vpv_ResultsPerOption rpo ON rpo.idOptionQuestion = o.idOptionQuestion;
GO
