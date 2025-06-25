--Agregar la columna de Comments allowed para verificar que una propuesta permite comentarios

ALTER TABLE [dbo].[vpv_proposalVersions]
ADD [commentsAllowed] BIT NOT NULL CONSTRAINT DF_vpv_proposalVersions_commentsAllowed DEFAULT 1;


--Agregar extra information para especificar razon de rechazada y aprobada etc
ALTER TABLE [dbo].[vpv_proposalComments]
ADD [extraInformation] NVARCHAR(200) NULL;
