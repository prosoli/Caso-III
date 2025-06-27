SET NOCOUNT ON;
GO

-----------------------
-- 1. INSERT STEP TYPES
-----------------------

DECLARE @stepTypeId1 INT, @stepTypeId2 INT;

-- Insertar primer step type
INSERT INTO [dbo].[vpv_steptypes] ([type])
VALUES ('Validacion de Comentario');
SET @stepTypeId1 = SCOPE_IDENTITY();

-- Insertar segundo step type
INSERT INTO [dbo].[vpv_steptypes] ([type])
VALUES ('Validación de documento');
SET @stepTypeId2 = SCOPE_IDENTITY();

----------------------------
-- 2. INSERT PROCESS TYPES
----------------------------

DECLARE @processTypeId INT;

INSERT INTO [dbo].[vpv_processtypes] ([name])
VALUES ('IA');
SET @processTypeId = SCOPE_IDENTITY();

---------------------------
-- 3. INSERT WORKFLOW STEPS
---------------------------

INSERT INTO [dbo].[vpv_workflowsteps] (
     [processtypeid],
     [steptypeid],
     [steporder],
     [name],
     [manual],
     [enable])
VALUES 
    (@processTypeId, @stepTypeId1, 1, 'Verificar estructura del comentario', 0, 1),
    (@processTypeId, @stepTypeId1, 2, 'Verificar presencia de encabezado', 0, 1),
    (@processTypeId, @stepTypeId1, 3, 'Verificar firma o pie de autor', 0, 1),
    (@processTypeId, @stepTypeId2, 1, 'Verificar que el documento cumple con el formato requerido', 0, 1),
    (@processTypeId, @stepTypeId2, 2, 'Verificar que el documento no esté vencido', 0, 1),
    (@processTypeId, @stepTypeId2, 3, 'Verificar que el documento tenga firma digital válida', 0, 1);



INSERT INTO [dbo].[vpv_api]
       ([name],
        [descripcion],
        [base_url],
        [creacionDate],
        [updateDate])
VALUES
       ('api-workflow-ia',
        'API encargada de simular la validación automática de estructura y documentación de comentarios mediante flujos de trabajo (workflows) configurables.',
        'https://api.puravidabd.local/workflow/validate',
        GETDATE(),
        GETDATE());



-- Cambiar el nombre de columna de proposals
EXEC sp_rename 
    'dbo.vpv_proposalComments.extraInformation', 
    'relacion', 
    'COLUMN';
GO


--Hacer mas campo en logs
ALTER TABLE dbo.vpv_logs
ALTER COLUMN description VARCHAR(500);




-- Cambio para que el comentar fucione el error 
UPDATE vpv_proposalVersions SET commentsAllowed = 0 WHERE tittle = 'App salud rural - Integración con expediente digital'


