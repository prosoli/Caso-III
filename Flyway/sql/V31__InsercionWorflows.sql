-- INSERCION DE WORKFLOWS

---------------
--STEP TYPES
--------------

INSERT INTO [dbo].[vpv_steptypes] ([type])
VALUES 
    ('Validacion de Comentario'),
    ('Validación de documento');


-----------------
--PROCESSTYPES
-----------------
INSERT INTO [dbo].[vpv_processtypes]
           ([name])
     VALUES
           ('IA')



------------------
--WORKFLOW STEPS
------------------

INSERT INTO [dbo].[vpv_workflowsteps]
    (
     [processtypeid],
     [steptypeid],
     [steporder],
     [name],
     [manual],
     [enable])
VALUES 
    (1, 1, 1, 'Verificar estructura del comentario', 0, 1),
    (1, 1, 2, 'Verificar presencia de encabezado', 0, 1),
    (1, 1, 3, 'Verificar firma o pie de autor', 0, 1),
	(1, 2, 1, 'Verificar que el documento cumple con el formato requerido', 0, 1),
    (1, 2, 2, 'Verificar que el documento no esté vencido', 0, 1),
    (1, 2, 3, 'Verificar que el documento tenga firma digital válida', 0, 1);

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



-- Cambiar nombre de la columna 'extraInformation' a 'relation'
EXEC sp_rename 
    @objname = 'dbo.vpv_proposalComments.extraInformation', 
    @newname = 'relacion', 
    @objtype = 'COLUMN';
GO

-- Cambio para que el comentar fucione el error 
UPDATE vpv_proposalVersions SET commentsAllowed = 0 WHERE tittle = 'App salud rural - Integración con expediente digital'


