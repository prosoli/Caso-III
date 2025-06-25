USE [puravidap]
GO

/****** Object:  View [dbo].[vw_Top5VotingResultsSummary]    Script Date: 25/6/2025 11:44:06 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER   VIEW [dbo].[vw_Top5VotingResultsSummary] AS
SELECT
    rs.idVotingResultsSummary,
    rs.idVotingConfig,
    rs.idEndOfVoting,
    rs.description,
    rs.idVotingResultStatus,
    rs.votesCount,
    rs.ValidVotesPercentage,
    rs.checkSum,
    rs.creationDate,
    rs.enable,
    rs.average,
	rvc.RowNum
FROM dbo.vpv_VotingResultsSummary rs
INNER JOIN dbo.vw_RecentVotingConfigs rvc
    ON rs.idVotingConfig = rvc.idVotingConfig;
GO


