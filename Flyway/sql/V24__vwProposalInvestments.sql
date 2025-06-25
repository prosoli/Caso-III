/****** Object:  View [dbo].[vw_ProposalInvestments]    Script Date: 25/6/2025 11:48:27 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER   VIEW [dbo].[vw_ProposalInvestments] AS
SELECT 
    rpv.RowNum,
    p.tittle AS Propuesta,
    p.budget AS Monto_Solicitado,

    -- Inversión ciudadana
    (SELECT SUM(t1.amount)
     FROM vpv_transactionPerPlan tc
     INNER JOIN vpv_transactions t1 ON t1.transactionId = tc.transactionId
     INNER JOIN vpv_transSubTypes st1 ON st1.transactionSubTypeId = t1.transactionSubTypeId
     WHERE tc.crowdfoundingProposalId = cp.crowdfoundingProposalId
       AND st1.name = 'Inversión de Usuario') AS Inversion_Ciudadana,

    -- Inversión por plan
    (SELECT SUM(t2.amount)
     FROM vpv_executionPlans ep
     INNER JOIN vpv_transactionPerPlan tp ON tp.executionPlanId = ep.executionPlanId
     INNER JOIN vpv_transactions t2 ON t2.transactionId = tp.transactionId
     INNER JOIN vpv_transSubTypes st2 ON st2.transactionSubTypeId = t2.transactionSubTypeId
     WHERE ep.crowdfoundingProposalId = cp.crowdfoundingProposalId
       AND st2.name = 'Inversion a un Plan') AS Monto_Ejecutado

FROM vw_RecentVotingConfigs rpv
INNER JOIN vpv_proposalVersions pv ON rpv.proposalVersionId = pv.proposalversionId
INNER JOIN vpv_proposals p ON p.proposalId = pv.proposalId
INNER JOIN vpv_crowdfoundingProposals cp ON cp.proposalId = p.proposalId;
GO


