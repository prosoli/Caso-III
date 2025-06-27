BEGIN TRY
    BEGIN TRANSACTION;

    SET NOCOUNT ON;

    DECLARE @proposalId INT,
            @versionId  INT,
            @configId   INT,
            @questionId INT,
            @q1         INT,
            @q2         INT,
            @q3         INT,
            @q4         INT,
            @q5         INT;

    -----------------------------------------
    -- 1) Insertar Propuesta
    -----------------------------------------
    INSERT INTO dbo.vpv_proposals
        (idUser, entitydid, tittle, description, creationDate,
         scheduleId, enable, deleted, ckecksum, statusId,
         budget, idTargetPopulation, proposalTypeId,
         lastUpdate, startingDate, proposalTypeId_semantica, relacion)
    VALUES
        (1, NULL,
         'Programa estratégico de gestión de residuos en zonas rurales',
         'Desarrollo e implementación de un modelo sostenible de reciclaje basado en la participación activa de las comunidades locales.',
         GETDATE(),
         1, 1, 0,
         HASHBYTES('SHA2_256', CONVERT(NVARCHAR(MAX), NEWID())),
         1, 99.99, 1, 1,
         GETDATE(), DATEADD(DAY,30,GETDATE()), 'Ambiental', NULL);

    SET @proposalId = SCOPE_IDENTITY();

    -----------------------------------------
    -- 2) Insertar Versión
    -----------------------------------------
    INSERT INTO dbo.vpv_proposalVersions
        (tittle, content, creationDate, startingDate, scheduleId,
         enable, deleted, checksum, statusid, budget,
         lastUpdate, idUser, proposalId, lastVersion)
    VALUES
        ('Gestión Comunitaria de Residuos - Versión 2',
         'Primera iteración del modelo con énfasis en entornos educativos rurales como núcleos de sensibilización y acción ambiental.',
         GETDATE(), DATEADD(DAY,15,GETDATE()), 1,
         1, 0,
         HASHBYTES('SHA2_256', CONVERT(NVARCHAR(MAX), NEWID())),
         1, 95.00,
         GETDATE(), 1, @proposalId, 1);

    SET @versionId = SCOPE_IDENTITY();

    -----------------------------------------
    -- 3) Insertar Configuración de Votación
    -----------------------------------------
    INSERT INTO dbo.vpv_votingConfigurations
        (proposalVersionId, openDate, closeDate, creationDate,
         idStatusVoting, idVotingType, description, weight, checksum,
         idReminderType, idClosureTypes, idvotingReasons)
    VALUES
        (@versionId,
         '2025-06-09 22:35:32', '2025-06-16 22:35:32', GETDATE(),
         3, 2,
         'Prueba' + CAST(@versionId AS VARCHAR(10)),
         1,
         HASHBYTES('SHA2_256', CONVERT(NVARCHAR(MAX), NEWID())),
         1, 1, 1);

    SET @configId = SCOPE_IDENTITY();

    -----------------------------------------
    -- 4) Insertar Preguntas maestras
    -----------------------------------------
    DECLARE @questions TABLE (idQuestion INT);
    INSERT INTO dbo.vpv_questions (idQuestionType, [description], creationDate, checksum)
    OUTPUT inserted.idQuestion INTO @questions(idQuestion)
    VALUES
        (1, '¿Esta de acuerdo con la implementacion?', GETDATE(),
             HASHBYTES('SHA2_256', '¿Está de acuerdo con la implementación?')),
        (2, '¿Que elementos deberian incluirse?', GETDATE(),
             HASHBYTES('SHA2_256', '¿Que elementos deberian incluirse?')),
        (4, 'Califique la viabilidad del proyecto (1-5)', GETDATE(),
             HASHBYTES('SHA2_256', 'Califique la viabilidad del proyecto (1-5)')),
        (3, '¿Cree que se necesita mas analisis?', GETDATE(),
             HASHBYTES('SHA2_256', '¿Cree que se necesita más análisis?')),
        (2, '¿Que actores deben involucrarse?', GETDATE(),
             HASHBYTES('SHA2_256', '¿Qué actores deben involucrarse?'));

    -- Asignar IDs
    ;WITH numbered AS (
        SELECT idQuestion,
               ROW_NUMBER() OVER (ORDER BY (SELECT 1)) AS rn
        FROM @questions
    )
    SELECT
        @q1 = MAX(CASE WHEN rn = 1 THEN idQuestion END),
        @q2 = MAX(CASE WHEN rn = 2 THEN idQuestion END),
        @q3 = MAX(CASE WHEN rn = 3 THEN idQuestion END),
        @q4 = MAX(CASE WHEN rn = 4 THEN idQuestion END),
        @q5 = MAX(CASE WHEN rn = 5 THEN idQuestion END)
    FROM numbered;

    -----------------------------------------
    -- 5) Insertar vpv_votingQuestions
    -----------------------------------------
    INSERT INTO [dbo].[vpv_votingQuestions] (idQuestion, [idVotingConfig], [enable], [creationDate], [checksum], [orderBy])
    VALUES 
    (@q1, @configId, 1, GETDATE(), HASHBYTES('SHA2_256', '¿Está de acuerdo con la implementación?'), 0),
    (@q2, @configId, 1, GETDATE(), HASHBYTES('SHA2_256', '¿Qué elementos deberían incluirse?'), 0),
    (@q3, @configId, 1, GETDATE(), HASHBYTES('SHA2_256', 'Califique la viabilidad del proyecto (1-5)'), 0),
    (@q4, @configId, 1, GETDATE(), HASHBYTES('SHA2_256', '¿Cree que se necesita más análisis?'), 0),
    (@q5, @configId, 1, GETDATE(), HASHBYTES('SHA2_256', '¿Qué actores deben involucrarse?'), 0);

    -----------------------------------------
    -- 6) Insertar Opciones
    -----------------------------------------

    -- q1
    INSERT INTO dbo.vpv_optionsQuestion
        (idOptionType, idQuestions, [value], [description], checksum, creationDate, enable, orderby)
    VALUES
        (1, @q1, '1', 'Si', HASHBYTES('SHA2_256', 'Sí'), GETDATE(), 1, 0),
        (1, @q1, '2', 'No', HASHBYTES('SHA2_256', 'No'), GETDATE(), 1, 1);

    -- q2
    INSERT INTO dbo.vpv_optionsQuestion
        (idOptionType, idQuestions, [value], [description], checksum, creationDate, enable, orderby)
    VALUES
        (2, @q2, 'A', 'A', HASHBYTES('SHA2_256', 'A'), GETDATE(), 1, 0),
        (2, @q2, 'B', 'B', HASHBYTES('SHA2_256', 'B'), GETDATE(), 1, 1),
        (2, @q2, 'C', 'C', HASHBYTES('SHA2_256', 'C'), GETDATE(), 1, 2);

    -- q3
    INSERT INTO dbo.vpv_optionsQuestion
        (idOptionType, idQuestions, [value], [description], checksum, creationDate, enable, orderby)
    VALUES
        (4, @q3, '1', '1', HASHBYTES('SHA2_256', '1'), GETDATE(), 1, 0),
        (4, @q3, '2', '2', HASHBYTES('SHA2_256', '2'), GETDATE(), 1, 1),
        (4, @q3, '3', '3', HASHBYTES('SHA2_256', '3'), GETDATE(), 1, 2),
        (4, @q3, '4', '4', HASHBYTES('SHA2_256', '4'), GETDATE(), 1, 3),
        (4, @q3, '5', '5', HASHBYTES('SHA2_256', '5'), GETDATE(), 1, 4);

    -- q4
    INSERT INTO dbo.vpv_optionsQuestion
        (idOptionType, idQuestions, [value], [description], checksum, creationDate, enable, orderby)
    VALUES
        (3, @q4, '1', 'Si', HASHBYTES('SHA2_256', 'Sí'), GETDATE(), 1, 0),
        (3, @q4, '0', 'No', HASHBYTES('SHA2_256', 'No'), GETDATE(), 1, 1);

    -- q5
    INSERT INTO dbo.vpv_optionsQuestion
        (idOptionType, idQuestions, [value], [description], checksum, creationDate, enable, orderby)
    VALUES
        (2, @q5, 'Gobierno',   'Gobierno',   HASHBYTES('SHA2_256', 'Gobierno'),   GETDATE(), 1, 0),
        (2, @q5, 'ONGs',       'ONGs',       HASHBYTES('SHA2_256', 'ONGs'),       GETDATE(), 1, 1),
        (2, @q5, 'Ciudadanos', 'Ciudadanos', HASHBYTES('SHA2_256', 'Ciudadanos'), GETDATE(), 1, 2);

    -----------------------------------------
    -- 7) Insertar TargetPopulationsVoting
    -----------------------------------------
    INSERT INTO dbo.vpv_TargetPopulationsVoting
        (idVotingConfig, idTargetPopulation, checksum, enable, weight)
    VALUES
        (@configId, 1,
         HASHBYTES('SHA2_256', CONVERT(NVARCHAR(MAX), NEWID())),
         1, 1.0);

    COMMIT TRANSACTION;
    PRINT 'Transacción completada exitosamente.';

END TRY
BEGIN CATCH
    ROLLBACK TRANSACTION;
    PRINT 'Error detectado: ' + ERROR_MESSAGE();
END CATCH;
GO

















BEGIN TRY
    BEGIN TRANSACTION;

    SET NOCOUNT ON;

    DECLARE @proposalId INT,
            @versionId  INT,
            @configId   INT,
            @q1         INT,
            @q2         INT,
            @q3         INT,
            @q4         INT,
            @q5         INT;

    -----------------------------------------
    -- 1) Insertar Propuesta
    -----------------------------------------
    INSERT INTO dbo.vpv_proposals
        (idUser, entitydid, tittle, description, creationDate,
         scheduleId, enable, deleted, ckecksum, statusId,
         budget, idTargetPopulation, proposalTypeId,
         lastUpdate, startingDate, proposalTypeId_semantica, relacion)
    VALUES
        (1, NULL,
         'Plan nacional de conectividad digital para zonas indígenas',
         'Mejora de la infraestructura tecnológica en territorios indígenas, enfocada en acceso equitativo a internet y herramientas digitales.',
         GETDATE(),
         1, 1, 0,
         HASHBYTES('SHA2_256', CONVERT(NVARCHAR(MAX), NEWID())),
         1, 150.00, 1, 2,
         GETDATE(), DATEADD(DAY, 45, GETDATE()), 'Tecnología', NULL);

    SET @proposalId = SCOPE_IDENTITY();

    -----------------------------------------
    -- 2) Insertar Versión
    -----------------------------------------
    INSERT INTO dbo.vpv_proposalVersions
        (tittle, content, creationDate, startingDate, scheduleId,
         enable, deleted, checksum, statusid, budget,
         lastUpdate, idUser, proposalId, lastVersion)
    VALUES
        ('Versión piloto conectividad 2025 - V2',
         'Proyecto piloto con instalación de torres de internet satelital y capacitación a líderes comunales en herramientas digitales.',
         GETDATE(), DATEADD(DAY, 20, GETDATE()), 1,
         1, 0,
         HASHBYTES('SHA2_256', CONVERT(NVARCHAR(MAX), NEWID())),
         1, 120.00,
         GETDATE(), 1, @proposalId, 1);

    SET @versionId = SCOPE_IDENTITY();

    -----------------------------------------
    -- 3) Insertar Configuración de Votación
    -----------------------------------------
    INSERT INTO dbo.vpv_votingConfigurations
        (proposalVersionId, openDate, closeDate, creationDate,
         idStatusVoting, idVotingType, description, weight, checksum,
         idReminderType, idClosureTypes, idvotingReasons)
    VALUES
        (@versionId,
         '2025-07-01 08:00:00', '2025-07-10 17:00:00', GETDATE(),
         3, 2,
         'Consulta digital territorios indígenas',
         1,
         HASHBYTES('SHA2_256', CONVERT(NVARCHAR(MAX), NEWID())),
         1, 1, 1);

    SET @configId = SCOPE_IDENTITY();

    -----------------------------------------
    -- 4) Insertar Preguntas maestras
    -----------------------------------------
    DECLARE @questions TABLE (idQuestion INT);
    INSERT INTO dbo.vpv_questions (idQuestionType, [description], creationDate, checksum)
    OUTPUT inserted.idQuestion INTO @questions(idQuestion)
    VALUES
        (1, '¿Está de acuerdo con la implementación del proyecto?', GETDATE(), HASHBYTES('SHA2_256', '¿Está de acuerdo con la implementación del proyecto?')),
        (2, '¿Qué beneficios espera del acceso a internet?', GETDATE(), HASHBYTES('SHA2_256', '¿Qué beneficios espera del acceso a internet?')),
        (4, 'Califique la importancia del proyecto (1-5)', GETDATE(), HASHBYTES('SHA2_256', 'Califique la importancia del proyecto (1-5)')),
        (3, '¿Considera que es una prioridad para su comunidad?', GETDATE(), HASHBYTES('SHA2_256', '¿Considera que es una prioridad para su comunidad?')),
        (2, '¿Qué grupos deberían ser capacitados primero?', GETDATE(), HASHBYTES('SHA2_256', '¿Qué grupos deberían ser capacitados primero?'));
    
    SET ANSI_WARNINGS OFF;
    ;WITH numbered AS (
        SELECT idQuestion, ROW_NUMBER() OVER (ORDER BY (SELECT 1)) AS rn FROM @questions
    )
    SELECT
        @q1 = MAX(CASE WHEN rn = 1 THEN idQuestion END),
        @q2 = MAX(CASE WHEN rn = 2 THEN idQuestion END),
        @q3 = MAX(CASE WHEN rn = 3 THEN idQuestion END),
        @q4 = MAX(CASE WHEN rn = 4 THEN idQuestion END),
        @q5 = MAX(CASE WHEN rn = 5 THEN idQuestion END)
    FROM numbered;

    -----------------------------------------
    -- 5) Insertar en vpv_votingQuestions
    -----------------------------------------
    INSERT INTO dbo.vpv_votingQuestions (idQuestion, idVotingConfig, enable, creationDate, checksum, orderBy)
    VALUES
        (@q1, @configId, 1, GETDATE(), HASHBYTES('SHA2_256', '¿Está de acuerdo con la implementación del proyecto?'), 0),
        (@q2, @configId, 1, GETDATE(), HASHBYTES('SHA2_256', '¿Qué beneficios espera del acceso a internet?'), 1),
        (@q3, @configId, 1, GETDATE(), HASHBYTES('SHA2_256', 'Califique la importancia del proyecto (1-5)'), 2),
        (@q4, @configId, 1, GETDATE(), HASHBYTES('SHA2_256', '¿Considera que es una prioridad para su comunidad?'), 3),
        (@q5, @configId, 1, GETDATE(), HASHBYTES('SHA2_256', '¿Qué grupos deberían ser capacitados primero?'), 4);

    -----------------------------------------
    -- 6) Insertar Opciones para cada pregunta
    -----------------------------------------

    -- Pregunta 1 (única)
    INSERT INTO dbo.vpv_optionsQuestion (idOptionType, idQuestions, value, description, checksum, creationDate, enable, orderby)
    VALUES
        (1, @q1, '1', 'Sí', HASHBYTES('SHA2_256', 'Sí'), GETDATE(), 1, 0),
        (1, @q1, '2', 'No', HASHBYTES('SHA2_256', 'No'), GETDATE(), 1, 1);

    -- Pregunta 2 (múltiple)
    INSERT INTO dbo.vpv_optionsQuestion
    VALUES
        (2, @q2, '1', 'Educación virtual', HASHBYTES('SHA2_256', 'Educación virtual'), GETDATE(), 1, 0),
        (2, @q2, '2', 'Telemedicina', HASHBYTES('SHA2_256', 'Telemedicina'), GETDATE(), 1, 1),
        (2, @q2, '3', 'Comercio digital', HASHBYTES('SHA2_256', 'Comercio digital'), GETDATE(), 1, 2);

    -- Pregunta 3 (escala)
    INSERT INTO dbo.vpv_optionsQuestion
    VALUES
        (4, @q3, '1', 'Nada importante', HASHBYTES('SHA2_256', '1'), GETDATE(), 1, 0),
        (4, @q3, '2', 'Poco importante', HASHBYTES('SHA2_256', '2'), GETDATE(), 1, 1),
        (4, @q3, '3', 'Moderado', HASHBYTES('SHA2_256', '3'), GETDATE(), 1, 2),
        (4, @q3, '4', 'Importante', HASHBYTES('SHA2_256', '4'), GETDATE(), 1, 3),
        (4, @q3, '5', 'Muy importante', HASHBYTES('SHA2_256', '5'), GETDATE(), 1, 4);

    -- Pregunta 4 (booleana)
    INSERT INTO dbo.vpv_optionsQuestion
    VALUES
        (3, @q4, '1', 'Sí', HASHBYTES('SHA2_256', 'Sí'), GETDATE(), 1, 0),
        (3, @q4, '0', 'No', HASHBYTES('SHA2_256', 'No'), GETDATE(), 1, 1);

    -- Pregunta 5 (múltiple)
    INSERT INTO dbo.vpv_optionsQuestion
    VALUES
        (2, @q5, '1', 'Estudiantes', HASHBYTES('SHA2_256', 'Estudiantes'), GETDATE(), 1, 0),
        (2, @q5, '2', 'Líderes comunales', HASHBYTES('SHA2_256', 'Líderes comunales'), GETDATE(), 1, 1),
        (2, @q5, '3', 'Docentes', HASHBYTES('SHA2_256', 'Docentes'), GETDATE(), 1, 2);

    -----------------------------------------
    -- 7) Insertar TargetPopulationsVoting
    -----------------------------------------
    INSERT INTO dbo.vpv_TargetPopulationsVoting
        (idVotingConfig, idTargetPopulation, checksum, enable, weight)
    VALUES
        (@configId, 1,
         HASHBYTES('SHA2_256', CONVERT(NVARCHAR(MAX), NEWID())),
         1, 1.0);

    COMMIT TRANSACTION;
    PRINT 'Transacción completada exitosamente.';

END TRY
BEGIN CATCH
    ROLLBACK TRANSACTION;
    PRINT 'Error detectado: ' + ERROR_MESSAGE();
END CATCH;
GO





















