/****** Object:  View [dbo].[vw_ResultPerFilter_Segmentation]    Script Date: 25/6/2025 11:47:05 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER   VIEW [dbo].[vw_ResultPerFilter_Segmentation] AS
SELECT 
    rvc.RowNum,
    rvc.idVotingConfig,
    rvc.description AS votingDescription,
    rvc.creationDate,
    ft.name AS filterName,
    ds.name AS subFilterName,       -- Nombre descriptivo del subtipo
    rf.referenceId1,
    rf.votesCount,
    rf.votesPercentage
FROM vw_RecentVotingConfigs rvc
JOIN vpv_ResultsPerFilter rf ON rvc.idVotingConfig = rf.idVotingConfig
JOIN vpv_FilterTypes ft ON rf.idFilterType = ft.idFilterType
JOIN vpv_demosubtype ds ON rf.referenceId1 = ds.demosubtypeid   -- JOIN para obtener el nombre del subtipo
WHERE ft.name IN ('Sexo', 'Nacionalidad', 'Provincia')
  AND rf.enable = 1;
GO


