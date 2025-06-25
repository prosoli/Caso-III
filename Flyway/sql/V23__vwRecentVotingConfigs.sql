/****** Object:  View [dbo].[vw_RecentVotingConfigs]    Script Date: 25/6/2025 11:47:55 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER   VIEW [dbo].[vw_RecentVotingConfigs] AS
SELECT TOP 5
    idVotingConfig,
    description,
    creationDate,
    proposalVersionId,
    ROW_NUMBER() OVER (ORDER BY creationDate DESC) AS RowNum
FROM vpv_VotingConfigurations
ORDER BY creationDate DESC;
GO


