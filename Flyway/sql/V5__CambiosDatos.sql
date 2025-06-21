-- Cambio en datos de decimales
--Proposal Versions
ALTER TABLE dbo.vpv_proposalVersions
ALTER COLUMN budget DECIMAL(18, 2);

--Sponsor agreements
ALTER TABLE dbo.vpv_sponsorAgreements
ALTER COLUMN amount DECIMAL(18, 2);

ALTER TABLE dbo.vpv_sponsorAgreements
ALTER COLUMN baseSalary DECIMAL(18, 2);


ALTER TABLE dbo.vpv_sponsorAgreements
ALTER COLUMN inversion DECIMAL(18, 2);

