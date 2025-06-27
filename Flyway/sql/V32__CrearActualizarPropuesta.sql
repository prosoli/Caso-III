-----------------------------------------------------------
-- Autor: Daniel Sequeira
-- Fecha: 04/25/2025
-- Descripcion: Crea o actualiza una propuesta y su versión.
-- Si la propuesta es nueva, se inserta en ambas tablas.
-- Si ya existe, actualiza la propuesta y crea una nueva versión,
-- deshabilitando las anteriores.
-- Recibe un JSON con la información de la propuesta.
-- Devuelve los ID de propuesta y versión por OUTPUT.
-----------------------------------------------------------
CREATE OR ALTER PROCEDURE [dbo].[vpvSP_UpsertProposalWithVersion]
    @jsonProposal    NVARCHAR(MAX),
    @idUser          INT,
    @outProposalId   INT OUTPUT,
    @outVersionId    INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

	DECLARE @tienePermiso BIT;
	DECLARE @permissionResource VARCHAR(100);
	DECLARE @permissionAction VARCHAR(100);
	
	SET @permissionResource = 'vpv_proposals';
	SET @permissionAction = 'INSERT';
	EXEC dbo.vpvSP_UsuarioPuede
  		@idUser       = @idUser,
  		@resourceName = @permissionResource,
  		@actionName   = @permissionAction,
  		@Puede        = @tienePermiso OUTPUT;

    IF @tienePermiso = 0
    BEGIN
        RAISERROR(50241,16,1,@permissionResource,@permissionAction);
        RETURN;
    END;

	SET @permissionResource = 'vpv_proposals';
	SET @permissionAction = 'SELECT';
	EXEC dbo.vpvSP_UsuarioPuede
  		@idUser       = @idUser,
  		@resourceName = @permissionResource,
  		@actionName   = @permissionAction,
  		@Puede        = @tienePermiso OUTPUT;

    IF @tienePermiso = 0
    BEGIN
        RAISERROR(50241,16,1,@permissionResource,@permissionAction);
        RETURN;
    END;

	SET @permissionResource = 'vpv_proposals';
	SET @permissionAction = 'UPDATE';
	EXEC dbo.vpvSP_UsuarioPuede
  		@idUser       = @idUser,
  		@resourceName = @permissionResource,
  		@actionName   = @permissionAction,
  		@Puede        = @tienePermiso OUTPUT;

    IF @tienePermiso = 0 
	BEGIN
        RAISERROR(50241,16,1,@permissionResource,@permissionAction);
        RETURN;
    END;

	SET @permissionResource = 'vpv_schedules';
	SET @permissionAction = 'SELECT';
	EXEC dbo.vpvSP_UsuarioPuede
  		@idUser       = @idUser,
  		@resourceName = @permissionResource,
  		@actionName   = @permissionAction,
  		@Puede        = @tienePermiso OUTPUT;

    IF @tienePermiso = 0
    BEGIN
        RAISERROR(50241,16,1,@permissionResource,@permissionAction);
        RETURN;
    END;

	SET @permissionResource = 'vpv_processStatus';
	SET @permissionAction = 'SELECT';
	EXEC dbo.vpvSP_UsuarioPuede
  		@idUser       = @idUser,
  		@resourceName = @permissionResource,
  		@actionName   = @permissionAction,
  		@Puede        = @tienePermiso OUTPUT;

    IF @tienePermiso = 0
    BEGIN
        RAISERROR(50241,16,1,@permissionResource,@permissionAction);
        RETURN;
    END;

	SET @permissionResource = 'vpv_proposalTypes';
	SET @permissionAction = 'SELECT';
	EXEC dbo.vpvSP_UsuarioPuede
  		@idUser       = @idUser,
  		@resourceName = @permissionResource,
  		@actionName   = @permissionAction,
  		@Puede        = @tienePermiso OUTPUT;

    IF @tienePermiso = 0
    BEGIN
        RAISERROR(50241,16,1,@permissionResource,@permissionAction);
        RETURN;
    END;

	SET @permissionResource = 'vpv_proposalVersions';
	SET @permissionAction = 'INSERT';
	EXEC dbo.vpvSP_UsuarioPuede
  		@idUser       = @idUser,
  		@resourceName = @permissionResource,
  		@actionName   = @permissionAction,
  		@Puede        = @tienePermiso OUTPUT;

    IF @tienePermiso = 0
    BEGIN
        RAISERROR(50241,16,1,@permissionResource,@permissionAction);
        RETURN;
    END;

	SET @permissionResource = 'vpv_proposalVersions';
	SET @permissionAction = 'UPDATE';
	EXEC dbo.vpvSP_UsuarioPuede
  		@idUser       = @idUser,
  		@resourceName = @permissionResource,
  		@actionName   = @permissionAction,
  		@Puede        = @tienePermiso OUTPUT;

    IF @tienePermiso = 0
    BEGIN
        RAISERROR(50241,16,1,@permissionResource,@permissionAction);
        RETURN;
    END;	

    DECLARE 
        @ErrorNumber       INT,
        @ErrorSeverity     INT,
        @ErrorState        INT,
        @CustomError       INT = 50221,  -- Código para errores internos
        @Message           VARCHAR(200),
        @InicieTransaccion BIT,
        @tittle                    NVARCHAR(100)   = JSON_VALUE(@jsonProposal, '$.tittle'),
        @description               NVARCHAR(500)   = JSON_VALUE(@jsonProposal, '$.description'),
        @versionContent            NVARCHAR(500)   = JSON_VALUE(@jsonProposal, '$.content'),
        @entitydid                 INT             = JSON_VALUE(@jsonProposal, '$.entitydid'),
        @schedule                  NVARCHAR(200)   = JSON_VALUE(@jsonProposal, '$.schedule'),
        @status                    NVARCHAR(100)   = JSON_VALUE(@jsonProposal, '$.status'),
        @budget                    DECIMAL(10,8)   = TRY_CAST(JSON_VALUE(@jsonProposal, '$.budget') AS DECIMAL(10,8)),
        @idTargetPopulation        INT             = JSON_VALUE(@jsonProposal, '$.idTargetPopulation'),
        @proposalType              NVARCHAR(100)   = JSON_VALUE(@jsonProposal, '$.proposalType'),
        @proposalTypeId_semantica  NVARCHAR(50)    = JSON_VALUE(@jsonProposal, '$.proposalTypeId_semantica'),
        @relacion                  NVARCHAR(500)   = JSON_VALUE(@jsonProposal, '$.relacion'),
        @startingDate              DATETIME        = TRY_CAST(JSON_VALUE(@jsonProposal, '$.startingDate') AS DATETIME),
        @now                       DATETIME        = GETDATE(),
        @proposalId                INT,
        @versionId                 INT,
        @checksum                  VARBINARY(255);

    -- Obtener FKs intermedias
    DECLARE @scheduleId INT;
    SELECT TOP 1 @scheduleId = s.scheduleId
      FROM dbo.vpv_schedules AS s
     WHERE s.name = @schedule;
    IF @scheduleId IS NULL
    BEGIN
        RAISERROR(50273, 16, 1, @schedule);
        RETURN;
    END;

    DECLARE @statusId INT;
    SELECT TOP 1 @statusId = ps.statusId
      FROM dbo.vpv_processStatus AS ps
     WHERE ps.name = @status;
    IF @statusId IS NULL
    BEGIN
        RAISERROR(50274, 16, 1, @status);
        RETURN;
    END;     

    DECLARE @proposalTypeId INT;
    SELECT TOP 1 @proposalTypeId = pt.proposalTypeId
      FROM dbo.vpv_proposalTypes AS pt
     WHERE pt.name = @proposalType;
    IF @proposalTypeId IS NULL
    BEGIN
        RAISERROR(50275, 16, 1, @proposalType);
        RETURN;
    END;

    -- Calcular checksum
    SET @checksum = HASHBYTES('SHA2_256', 
        CONCAT(@tittle, '|', CONVERT(VARCHAR(30),@now,126))
    );

    -- Iniciar transacción
    SET @InicieTransaccion = 0;
    IF @@TRANCOUNT = 0
    BEGIN
        SET @InicieTransaccion = 1;
        SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
        BEGIN TRANSACTION;
    END

    BEGIN TRY
        -- 1) Verificar existencia
        SELECT @proposalId = proposalId
          FROM dbo.vpv_proposals
         WHERE tittle = @tittle
           AND idUser = @idUser
           AND deleted = 0;

        IF @proposalId IS NULL
        BEGIN
            -- Inserción de nueva propuesta
            INSERT INTO dbo.vpv_proposals
            (
                idUser, entitydid, tittle, description, creationDate,
                scheduleId, enable, deleted, ckecksum, statusId,
                budget, idTargetPopulation, proposalTypeId, lastUpdate,
                startingDate, proposalTypeId_semantica, relacion
            )
            VALUES
            (
                @idUser, @entitydid, @tittle, @description, @now,
                @scheduleId, 1, 0, @checksum, @statusId,
                @budget, 1, @proposalTypeId, @now,
                @startingDate, @proposalTypeId_semantica, @relacion
            );
            SET @proposalId = SCOPE_IDENTITY();
            INSERT INTO dbo.vpv_logs (description, computer, username, trace, referenceId1, referenceId2, value1, value2, chechsum, logSeverityId, logSourceId, logTypeId) VALUES
            ('Nueva propuesta creada', @@SERVERNAME, HOST_NAME(),
            'vpvSP_UpsertProposalWithVersion',
            CAST(@description AS VARCHAR(10)), CAST(@outVersionId AS VARCHAR(10)),
            NULL, NULL, 0x0,
            (SELECT logSeverityId FROM dbo.vpv_logSeverity WHERE [name]='Informational'),
            (SELECT logSourceId   FROM dbo.vpv_logsSources WHERE [name]='Database'),
            (SELECT logTypeId     FROM dbo.vpv_logTypes   WHERE [name]='Audit'));

        END
        ELSE
        BEGIN
            -- Actualización de propuesta existente
            UPDATE dbo.vpv_proposals
               SET description                = @description,
                   lastUpdate                 = @now,
                   scheduleId                 = @scheduleId,
                   statusId                   = @statusId,
                   budget                     = @budget,
                   idTargetPopulation         = 1,
                   proposalTypeId             = @proposalTypeId,
                   startingDate               = @startingDate,
                   proposalTypeId_semantica   = @proposalTypeId_semantica,
                   relacion                   = @relacion,
                   ckecksum                   = @checksum
             WHERE proposalId = @proposalId;
            INSERT INTO dbo.vpv_logs (description, computer, username, trace, referenceId1, referenceId2, value1, value2, chechsum, logSeverityId, logSourceId, logTypeId) VALUES
                ('Propuesta actualizada', @@SERVERNAME, HOST_NAME(),
                'vpvSP_UpsertProposalWithVersion',
                CAST(@description AS VARCHAR(10)), CAST(@outVersionId AS VARCHAR(10)),
                NULL, NULL, 0x0,
                (SELECT logSeverityId FROM dbo.vpv_logSeverity WHERE [name]='Informational'),
                (SELECT logSourceId   FROM dbo.vpv_logsSources WHERE [name]='Database'),
                (SELECT logTypeId     FROM dbo.vpv_logTypes   WHERE [name]='Audit'));

        END

        -- 2) Deshabilitar versiones previas
        UPDATE dbo.vpv_proposalVersions
           SET enable      = 0,
               lastVersion = 0
         WHERE proposalId = @proposalId;

        -- 3) Insertar nueva versión
        INSERT INTO dbo.vpv_proposalVersions (
            tittle, content, creationDate, startingDate, scheduleId,
            enable, deleted, checksum, statusid, budget,
            lastUpdate, idUser, proposalId, lastVersion
        )
        VALUES (
            @tittle, @versionContent, @now, @startingDate, @scheduleId,
            1, 0, @checksum, @statusId, @budget,
            @now, @idUser, @proposalId, 1
        );
        SET @versionId = SCOPE_IDENTITY();
        INSERT INTO dbo.vpv_logs (description, computer, username, trace, referenceId1, referenceId2, value1, value2, chechsum, logSeverityId, logSourceId, logTypeId) VALUES
            ('Version de Propuesta creada', @@SERVERNAME, HOST_NAME(),
            'vpvSP_UpsertProposalWithVersion',
            CAST(@tittle AS VARCHAR(10)), CAST(@outVersionId AS VARCHAR(10)),
            NULL, NULL, 0x0,
            (SELECT logSeverityId FROM dbo.vpv_logSeverity WHERE [name]='Informational'),
            (SELECT logSourceId   FROM dbo.vpv_logsSources WHERE [name]='Database'),
            (SELECT logTypeId     FROM dbo.vpv_logTypes   WHERE [name]='Audit'));

        -- Salidas
        SET @outProposalId = @proposalId;
        SET @outVersionId  = @versionId;

        IF @InicieTransaccion = 1
            COMMIT;

        -- Mensaje de éxito
        -- RAISERROR(50220, 10, 1, @outProposalId, @outVersionId) WITH NOWAIT;
    END TRY
    BEGIN CATCH
        -- Capturar datos de error
        SET @ErrorNumber   = ERROR_NUMBER();
        SET @ErrorSeverity = ERROR_SEVERITY();
        SET @ErrorState    = ERROR_STATE();
        SET @Message       = ERROR_MESSAGE();

        IF @InicieTransaccion = 1
            ROLLBACK;

        -- Mensaje de fallo
        RAISERROR(50221, 16, 1, @Message, @CustomError);
        RETURN;
    END CATCH
END;
GO



-- Stored Procedure para configurar votación desde JSON y retornar el ID insertado en parámetro OUTPUT
-----------------------------------------------------------
-- Autor: Daniel Sequeira
-- Fecha: 06/07/2025
-- Descripcion: Inserta una configuración de votación a partir de JSON
--              y retorna el id generado mediante un parámetro OUTPUT.
-- Parámetros:
--   @jsonConfig   NVARCHAR(MAX) JSON con campos:
--     proposalVersionId, openDate, closeDate, idStatusVoting,
--     idVotingType, description, weight (0/1), idReminderType,
--     idClosureTypes, idVotingReasons, executionPlanId,
--     metricPlanId, projectReportId, sponsorAgreementId
--   @newConfigId  INT OUTPUT     ID de la configuración creada
-----------------------------------------------------------
CREATE OR ALTER PROCEDURE [dbo].[vpvSP_InsertVotingConfig]
    @idUser INT,
    @jsonConfig   NVARCHAR(MAX),
    @idProposalVersion INT,
    @newConfigId  INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

	DECLARE @tienePermiso BIT;
	DECLARE @permissionResource VARCHAR(100);
	DECLARE @permissionAction VARCHAR(100);    

	SET @permissionResource = 'vpv_statusVoting';
	SET @permissionAction = 'SELECT';
	EXEC dbo.vpvSP_UsuarioPuede
  		@idUser       = @idUser,
  		@resourceName = @permissionResource,
  		@actionName   = @permissionAction,
  		@Puede        = @tienePermiso OUTPUT;

    IF @tienePermiso = 0
    BEGIN
        RAISERROR(50241,16,1,@permissionResource,@permissionAction);
        RETURN;
    END;

	SET @permissionResource = 'vpv_votingTypes';
	SET @permissionAction = 'SELECT';
	EXEC dbo.vpvSP_UsuarioPuede
  		@idUser       = @idUser,
  		@resourceName = @permissionResource,
  		@actionName   = @permissionAction,
  		@Puede        = @tienePermiso OUTPUT;

    IF @tienePermiso = 0
    BEGIN
        RAISERROR(50241,16,1,@permissionResource,@permissionAction);
        RETURN;
    END;

	SET @permissionResource = 'vpv_reminderTypes';
	SET @permissionAction = 'SELECT';
	EXEC dbo.vpvSP_UsuarioPuede
  		@idUser       = @idUser,
  		@resourceName = @permissionResource,
  		@actionName   = @permissionAction,
  		@Puede        = @tienePermiso OUTPUT;

    IF @tienePermiso = 0
    BEGIN
        RAISERROR(50241,16,1,@permissionResource,@permissionAction);
        RETURN;
    END;

	SET @permissionResource = 'vpv_ClosureTypes';
	SET @permissionAction = 'SELECT';
	EXEC dbo.vpvSP_UsuarioPuede
  		@idUser       = @idUser,
  		@resourceName = @permissionResource,
  		@actionName   = @permissionAction,
  		@Puede        = @tienePermiso OUTPUT;

    IF @tienePermiso = 0
    BEGIN
        RAISERROR(50241,16,1,@permissionResource,@permissionAction);
        RETURN;
    END;

	SET @permissionResource = 'vpv_votingReasons';
	SET @permissionAction = 'SELECT';
	EXEC dbo.vpvSP_UsuarioPuede
  		@idUser       = @idUser,
  		@resourceName = @permissionResource,
  		@actionName   = @permissionAction,
  		@Puede        = @tienePermiso OUTPUT;

    IF @tienePermiso = 0
    BEGIN
        RAISERROR(50241,16,1,@permissionResource,@permissionAction);
        RETURN;
    END;    

	SET @permissionResource = 'vpv_executionPlans';
	SET @permissionAction = 'SELECT';
	EXEC dbo.vpvSP_UsuarioPuede
  		@idUser       = @idUser,
  		@resourceName = @permissionResource,
  		@actionName   = @permissionAction,
  		@Puede        = @tienePermiso OUTPUT;

    IF @tienePermiso = 0
    BEGIN
        RAISERROR(50241,16,1,@permissionResource,@permissionAction);
        RETURN;
    END;  

	SET @permissionResource = 'vpv_MetricPerPlan';
	SET @permissionAction = 'SELECT';
	EXEC dbo.vpvSP_UsuarioPuede
  		@idUser       = @idUser,
  		@resourceName = @permissionResource,
  		@actionName   = @permissionAction,
  		@Puede        = @tienePermiso OUTPUT;

    IF @tienePermiso = 0
    BEGIN
        RAISERROR(50241,16,1,@permissionResource,@permissionAction);
        RETURN;
    END;  

	SET @permissionResource = 'vpv_projectReports';
	SET @permissionAction = 'SELECT';
	EXEC dbo.vpvSP_UsuarioPuede
  		@idUser       = @idUser,
  		@resourceName = @permissionResource,
  		@actionName   = @permissionAction,
  		@Puede        = @tienePermiso OUTPUT;

    IF @tienePermiso = 0
    BEGIN
        RAISERROR(50241,16,1,@permissionResource,@permissionAction);
        RETURN;
    END;  

	SET @permissionResource = 'vpv_votingConfigurations';
	SET @permissionAction = 'INSERT';
	EXEC dbo.vpvSP_UsuarioPuede
  		@idUser       = @idUser,
  		@resourceName = @permissionResource,
  		@actionName   = @permissionAction,
  		@Puede        = @tienePermiso OUTPUT;

    IF @tienePermiso = 0
    BEGIN
        RAISERROR(50241,16,1,@permissionResource,@permissionAction);
        RETURN;
    END;  

    DECLARE
        @openDate             DATETIME  = TRY_CONVERT(DATETIME, JSON_VALUE(@jsonConfig,'$.openDate')),
        @closeDate            DATETIME  = TRY_CONVERT(DATETIME, JSON_VALUE(@jsonConfig,'$.closeDate')),
        @creationDate         DATETIME  = GETDATE(),
        @statusVoting         VARCHAR(100)  = JSON_VALUE(@jsonConfig,'$.StatusVoting'),
        @votingType           VARCHAR(100)  = JSON_VALUE(@jsonConfig,'$.VotingType'),
        @description          VARCHAR(1000) = JSON_VALUE(@jsonConfig,'$.description'),
        @weight               BIT       = ISNULL(TRY_CAST(JSON_VALUE(@jsonConfig,'$.weight') AS BIT),0),
        @reminderType         VARCHAR(100)  = JSON_VALUE(@jsonConfig,'$.ReminderType'),
        @closureType          VARCHAR(200)  = JSON_VALUE(@jsonConfig,'$.ClosureTypes'),
        @votingReasons        VARCHAR(100)  = JSON_VALUE(@jsonConfig,'$.VotingReasons'),
        @executionPlan        VARCHAR(200)  = NULLIF(JSON_VALUE(@jsonConfig,'$.executionPlan'),''),
        @metricPlan           VARCHAR(200)  = NULLIF(JSON_VALUE(@jsonConfig,'$.metricPlan'),''),
        @projectReport        VARCHAR(200)  = NULLIF(JSON_VALUE(@jsonConfig,'$.projectReport'),''),
        @sponsorAgreementId   INT       = NULLIF(JSON_VALUE(@jsonConfig,'$.sponsorAgreementId'),''),
        @checksum             VARBINARY(255),
        @InTrans              BIT,
        @ErrorNum          INT,
        @ErrorSev          INT,
        @ErrorSta          INT,
        @ErrorMsg          NVARCHAR(4000),
        @CustomError       INT  = 50240;

    DECLARE @statusVotingId INT;
    SELECT TOP 1 @statusVotingId = sv.idStatusVoting FROM dbo.vpv_statusVoting AS sv WHERE sv.name  = @statusVoting;
    IF @statusVotingId IS NULL
    BEGIN
        RAISERROR(50268, 16, 1, @statusVoting);
        RETURN;
    END;    

    DECLARE @votingTypeId INT;
    SELECT TOP 1 @votingTypeId = vt.idVotingType FROM dbo.vpv_votingTypes AS vt WHERE vt.name  = @votingType;
    IF @votingTypeId IS NULL
    BEGIN
        RAISERROR(50269, 16, 1, @votingType);
        RETURN;
    END;    

    DECLARE @reminderTypeId INT;
    SELECT TOP 1 @reminderTypeId = rt.idReminderType FROM dbo.vpv_reminderTypes AS rt WHERE rt.name  = @reminderType;
    IF @reminderTypeId IS NULL
    BEGIN
        RAISERROR(50270, 16, 1, @reminderType);
        RETURN;
    END;    

    DECLARE @closureTypeId INT;
    SELECT TOP 1 @closureTypeId = ct.idClosureTypes FROM dbo.vpv_ClosureTypes AS ct WHERE ct.name  = @closureType;
    IF @closureTypeId IS NULL
    BEGIN
        RAISERROR(50271, 16, 1, @closureType);
        RETURN;
    END;    

    DECLARE @votingReasonsId INT;
    SELECT TOP 1 @votingReasonsId = vr.idvotingReasons FROM dbo.vpv_votingReasons AS vr WHERE vr.name  = @votingReasons;
    IF @votingReasonsId IS NULL
    BEGIN
        RAISERROR(50272, 16, 1, @votingReasons);
        RETURN;
    END;    

    DECLARE @executionPlanId INT;
    SELECT TOP 1 @executionPlanId = ep.executionPlanId FROM dbo.vpv_executionPlans AS ep WHERE ep.tittle  = @executionPlan;


    DECLARE @metricPlanId  INT;
    SELECT TOP 1 @metricPlanId  = mp.metricPlanId FROM dbo.vpv_MetricPerPlan AS mp WHERE mp.name  = @metricPlan;

    DECLARE @projectReportId  INT;
    SELECT TOP 1 @projectReportId  = pr.projectReportId FROM dbo.vpv_projectReports AS pr WHERE pr.tittle  = @projectReport;



    -- Calcular checksum
    SET @checksum = HASHBYTES('SHA2_256',
        CONCAT(
            @idProposalVersion,
            CONVERT(VARCHAR(126),@openDate,126),
            CONVERT(VARCHAR(126),@closeDate,126),
            @statusVotingId,
            @votingTypeId,
            @description,
            @weight,
            @reminderTypeId,
            @closureTypeId,
            @votingReasonsId,
            COALESCE(CONVERT(VARCHAR(10),@executionPlanId),''),
            COALESCE(CONVERT(VARCHAR(10),@metricPlanId),''),
            COALESCE(CONVERT(VARCHAR(10),@projectReportId),''),
            COALESCE(CONVERT(VARCHAR(10),@sponsorAgreementId),''),
            CONVERT(VARCHAR(126),@creationDate,126)
        )
    );

    -- Iniciar transacción
    SET @InTrans=0;
    IF @@TRANCOUNT=0
    BEGIN
        SET @InTrans=1; 
        SET TRANSACTION ISOLATION LEVEL READ COMMITTED; 
        BEGIN TRANSACTION; 
    END

    BEGIN TRY
        INSERT INTO dbo.vpv_votingConfigurations
        (
          proposalVersionId, openDate, closeDate, creationDate,
          idStatusVoting, idVotingType, description, weight,
          checksum, idReminderType, idClosureTypes, idvotingReasons,
          executionPlanId, metricPlanId, projectReportId, sponsorAgreementId
        )
        VALUES
        (
          @idProposalVersion, @openDate, @closeDate, @creationDate,
          @statusVotingId, @votingTypeId, @description, @weight,
          @checksum, @reminderTypeId, @closureTypeId, @votingReasonsId,
          @executionPlanId, @metricPlanId, @projectReportId, @sponsorAgreementId
        );

        -- Capturar el ID generado
        SET @newConfigId = SCOPE_IDENTITY();

        INSERT INTO dbo.vpv_logs (description, computer, username, trace, referenceId1, referenceId2, value1, value2, chechsum, logSeverityId, logSourceId, logTypeId) VALUES
          ('Nueva configuracion de votacion', @@SERVERNAME, HOST_NAME(),
           'vpvSP_InsertVotingConfig', CAST(@newConfigId AS VARCHAR(10)), NULL,
           NULL, NULL, 0x0,
           (SELECT logSeverityId FROM dbo.vpv_logSeverity WHERE [name]='Informational'),
           (SELECT logSourceId   FROM dbo.vpv_logsSources WHERE [name]='Database'),
           (SELECT logTypeId     FROM dbo.vpv_logTypes   WHERE [name]='Audit'));

        IF @InTrans=1 COMMIT;
    END TRY
    BEGIN CATCH
        IF @InTrans=1 ROLLBACK;
        THROW;

        SET @ErrorNum = ERROR_NUMBER();
        SET @ErrorSev = ERROR_SEVERITY();
        SET @ErrorSta = ERROR_STATE();
        SET @ErrorMsg = ERROR_MESSAGE();

        -- usa un número de mensaje personalizado
        RAISERROR(50242,16,1,@ErrorMsg,@CustomError);
    END CATCH;
END;
GO




-- Stored Procedure para poblar vpv_TargetPopulationsVoting usando JSON y un idVotingConfig fijo,
-- y retornar el último id insertado como parámetro OUTPUT
-----------------------------------------------------------
-- Autor: Daniel Sequeira
-- Fecha: 06/08/2025
-- Descripcion: Inserta registros en vpv_TargetPopulationsVoting usando un idVotingConfig fijo (1)
--              a partir de un arreglo de poblaciones con name y weight, y devuelve en @lastId
--              el idTargetPopulationsVoting de la última inserción.
-- Parámetros:
--   @jsonTPV     NVARCHAR(MAX) JSON con campos:
--                   targetPopulations: arreglo de objetos { name, weight }
--   @lastId      INT OUTPUT    ID de la última fila insertada en vpv_TargetPopulationsVoting
-----------------------------------------------------------
CREATE OR ALTER PROCEDURE [dbo].[vpvSP_InsertTargetPopulationsVoting]
  @idUser          INT,
  @jsonTPV         NVARCHAR(MAX),
  @idVotingConfig  INT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE 
        @tienePermiso      BIT,
        @permissionResource VARCHAR(100),
        @permissionAction   VARCHAR(100),
        @InTrans            BIT = 0,
        @ErrNum             INT,
        @ErrSev             INT,
        @ErrSta             INT,
        @ErrMsg             NVARCHAR(4000),
        @tp                 NVARCHAR(MAX),
        @popName            NVARCHAR(50),
        @popWeight          DECIMAL(5,2),
        @popId              INT,
        @checksum           NVARCHAR(255);

    -- Permisos SELECT sobre TargetPopulations
    SET @permissionResource = 'vpv_TargetPopulations';
    SET @permissionAction   = 'SELECT';
    EXEC dbo.vpvSP_UsuarioPuede
         @idUser       = @idUser,
         @resourceName = @permissionResource,
         @actionName   = @permissionAction,
         @Puede        = @tienePermiso OUTPUT;
    IF @tienePermiso = 0
    BEGIN
        RAISERROR(50241, 16, 1, @permissionResource, @permissionAction);
        RETURN;
    END

    -- Permisos INSERT sobre TargetPopulationsVoting
    SET @permissionResource = 'vpv_TargetPopulationsVoting';
    SET @permissionAction   = 'INSERT';
    EXEC dbo.vpvSP_UsuarioPuede
         @idUser       = @idUser,
         @resourceName = @permissionResource,
         @actionName   = @permissionAction,
         @Puede        = @tienePermiso OUTPUT;
    IF @tienePermiso = 0
    BEGIN
        RAISERROR(50241, 16, 1, @permissionResource, @permissionAction);
        RETURN;
    END

    -- Iniciar transacción si no hay ninguna activa
    IF @@TRANCOUNT = 0
    BEGIN
        SET @InTrans = 1;
        SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
        BEGIN TRANSACTION;
    END

    BEGIN TRY
        -- Recorrer arreglo targetPopulations
        DECLARE tp_cursor CURSOR FAST_FORWARD FOR
            SELECT value 
              FROM OPENJSON(@jsonTPV, '$.targetPopulations');

        OPEN tp_cursor;
        FETCH NEXT FROM tp_cursor INTO @tp;

        WHILE @@FETCH_STATUS = 0
        BEGIN
            SET @popName   = JSON_VALUE(@tp, '$.name');
            SET @popWeight = TRY_CAST(JSON_VALUE(@tp, '$.weight') AS DECIMAL(5,2));

            -- Buscar idTargetPopulation
            SELECT TOP 1 @popId = idTargetPopulation
              FROM dbo.vpv_TargetPopulations
             WHERE [name]  = @popName
               AND enable  = 1;

            IF @popId IS NULL
            BEGIN
                -- 50262: población no encontrada
                RAISERROR(50262, 16, 1, @popName);
                IF @InTrans = 1 ROLLBACK;
                CLOSE tp_cursor; DEALLOCATE tp_cursor;
                RETURN;
            END

            SET @checksum = 'TPV_' + CAST(@idVotingConfig AS VARCHAR(10)) + '_' + @popName;

            INSERT INTO dbo.vpv_TargetPopulationsVoting
                (idVotingConfig, idTargetPopulation, checksum, enable, weight)
            VALUES
                (@idVotingConfig, @popId, @checksum, 1, ISNULL(@popWeight,1));

            INSERT INTO dbo.vpv_logs (description, computer, username, trace, referenceId1, referenceId2, value1, value2, chechsum, logSeverityId, logSourceId, logTypeId) VALUES
                ('Nuevo target population voting completado ' + @popName, @@SERVERNAME, HOST_NAME(),
                'vpvSP_InsertTargetPopulationsVoting', CAST(@idVotingConfig AS VARCHAR(10)), NULL,
                NULL, NULL, 0x0,
                (SELECT logSeverityId FROM dbo.vpv_logSeverity WHERE [name]='Informational'),
                (SELECT logSourceId   FROM dbo.vpv_logsSources WHERE [name]='Database'),
                (SELECT logTypeId     FROM dbo.vpv_logTypes   WHERE [name]='Audit'));

            FETCH NEXT FROM tp_cursor INTO @tp;
        END

        CLOSE tp_cursor;
        DEALLOCATE tp_cursor;

        IF @InTrans = 1
            COMMIT;
    END TRY
    BEGIN CATCH
        SET @ErrNum = ERROR_NUMBER();
        SET @ErrSev = ERROR_SEVERITY();
        SET @ErrSta = ERROR_STATE();
        SET @ErrMsg = ERROR_MESSAGE();

        IF @InTrans = 1
            ROLLBACK;

        RAISERROR(
            'vpvSP_InsertTargetPopulationsVoting falló: %s (Código %d)',
            @ErrSev, @ErrSta, @ErrMsg, @ErrNum
        );
    END CATCH
END
GO



-----------------------------------------------------------
-- Autor: Daniel Sequeira
-- Fecha: 06/09/2025
-- Descripcion: Inserta identitydocs, vpv_docs y vpv_FilesPerProposal
--              a partir de un JSON con una lista anidada de documentos.
-- Recibe:
--   @jsonInput         NVARCHAR(MAX) JSON con un array de objetos:
--     [
--       {
--         "identitytypeid": …,
--         "identitystateid": …,
--         "name": "…",
--         "field1": "…",
--         "field2": "…",
--         "temporary": 0|1,
--         "expirationdate": "YYYY-MM-DDThh:mm:ss",
--         "referenceVal": …,
--         "referenceId": "…",
--         "formatid": …,
--         "docstypeid": …,
--         "docstateid": …,
--         "archive": "BASE64…",
--         "filename": "…",
--         "date": "YYYY-MM-DDThh:mm:ss",
--         "startdate": "…",
--         "nextcheckdate": "…",
--         "semantic_category": "…",
--         "docEnable": 0|1,
--         "fileEnable": 0|1,
--         "relacion": "…"
--       },
--       { … }
--     ]
--   @proposalId        INT  ID de la propuesta padre
--   @proposalVersionId INT  ID de la versión de la propuesta
-----------------------------------------------------------
CREATE OR ALTER PROCEDURE [dbo].[vpvSP_InsertProposalDocuments]
    @jsonInput         NVARCHAR(MAX),
    @idUser INT,
    @proposalId        INT,
    @proposalVersionId INT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE
        @InicieTransaccion BIT = 0,
        @item              NVARCHAR(MAX),
        @identitydocsid    INT,
        @docid             INT;

	DECLARE @tienePermiso BIT;
	DECLARE @permissionResource VARCHAR(100);
	DECLARE @permissionAction VARCHAR(100);
	
	SET @permissionResource = 'vpv_identitytype';
	SET @permissionAction = 'SELECT';
	EXEC dbo.vpvSP_UsuarioPuede
  		@idUser       = @idUser,
  		@resourceName = @permissionResource,
  		@actionName   = @permissionAction,
  		@Puede        = @tienePermiso OUTPUT;

    IF @tienePermiso = 0
    BEGIN
        RAISERROR(50241, 16, 1, @permissionResource, @permissionAction);
        RETURN;
    END;

	SET @permissionResource = 'vpv_identitystates';
	SET @permissionAction = 'SELECT';
	EXEC dbo.vpvSP_UsuarioPuede
  		@idUser       = @idUser,
  		@resourceName = @permissionResource,
  		@actionName   = @permissionAction,
  		@Puede        = @tienePermiso OUTPUT;

    IF @tienePermiso = 0
    BEGIN
        RAISERROR(50241, 16, 1, @permissionResource, @permissionAction);
        RETURN;
    END;

	SET @permissionResource = 'vpv_formats';
	SET @permissionAction = 'SELECT';
	EXEC dbo.vpvSP_UsuarioPuede
  		@idUser       = @idUser,
  		@resourceName = @permissionResource,
  		@actionName   = @permissionAction,
  		@Puede        = @tienePermiso OUTPUT;

    IF @tienePermiso = 0
    BEGIN
        RAISERROR(50241, 16, 1, @permissionResource, @permissionAction);
        RETURN;
    END;

	SET @permissionResource = 'vpv_docstypes';
	SET @permissionAction = 'SELECT';
	EXEC dbo.vpvSP_UsuarioPuede
  		@idUser       = @idUser,
  		@resourceName = @permissionResource,
  		@actionName   = @permissionAction,
  		@Puede        = @tienePermiso OUTPUT;

    IF @tienePermiso = 0
    BEGIN
        RAISERROR(50241, 16, 1, @permissionResource, @permissionAction);
        RETURN;
    END;

	SET @permissionResource = 'vpv_docstates';
	SET @permissionAction = 'SELECT';
	EXEC dbo.vpvSP_UsuarioPuede
  		@idUser       = @idUser,
  		@resourceName = @permissionResource,
  		@actionName   = @permissionAction,
  		@Puede        = @tienePermiso OUTPUT;

    IF @tienePermiso = 0
    BEGIN
        RAISERROR(50241, 16, 1, @permissionResource, @permissionAction);
        RETURN;
    END;

	SET @permissionResource = 'vpv_identitydocs';
	SET @permissionAction = 'INSERT';
	EXEC dbo.vpvSP_UsuarioPuede
  		@idUser       = @idUser,
  		@resourceName = @permissionResource,
  		@actionName   = @permissionAction,
  		@Puede        = @tienePermiso OUTPUT;

    IF @tienePermiso = 0
    BEGIN
        RAISERROR(50241, 16, 1, @permissionResource, @permissionAction);
        RETURN;
    END;

	SET @permissionResource = 'vpv_docs';
	SET @permissionAction = 'INSERT';
	EXEC dbo.vpvSP_UsuarioPuede
  		@idUser       = @idUser,
  		@resourceName = @permissionResource,
  		@actionName   = @permissionAction,
  		@Puede        = @tienePermiso OUTPUT;

    IF @tienePermiso = 0
    BEGIN
        RAISERROR(50241, 16, 1, @permissionResource, @permissionAction);
        RETURN;
    END;

	SET @permissionResource = 'vpv_FilesPerProposal';
	SET @permissionAction = 'INSERT';
	EXEC dbo.vpvSP_UsuarioPuede
  		@idUser       = @idUser,
  		@resourceName = @permissionResource,
  		@actionName   = @permissionAction,
  		@Puede        = @tienePermiso OUTPUT;

    IF @tienePermiso = 0
    BEGIN
        RAISERROR(50241, 16, 1, @permissionResource, @permissionAction);
        RETURN;
    END;


    -- Campos temporales para cada documento
    DECLARE
        @identitytype      VARCHAR(200),
        @identitystate     VARCHAR(100),
        @idName            NVARCHAR(150),
        @field1            NVARCHAR(250),
        @field2            NVARCHAR(250),
        @temporary         BIT,
        @expirationdate    DATETIME,
        @referenceVal      INT,
        @referenceId       NVARCHAR(25),
        @format            VARCHAR(100),
        @docstype          VARCHAR(100),
        @docstate          VARCHAR(100),
        @archiveBase64     NVARCHAR(MAX),
        @archive           VARBINARY(MAX),
        @filename          NVARCHAR(100),
        @docDate           DATETIME,
        @startdate         DATETIME,
        @nextcheckdate     DATETIME,
        @semantic_category NVARCHAR(250),
        @docEnable         BIT,
        @docChecksum       VARBINARY(255),
        @fileEnable        BIT,
        @relacion          NVARCHAR(500),
        @fileChecksum      VARBINARY(255);

    -- Iniciar transacción
    IF @@TRANCOUNT = 0
    BEGIN
        SET @InicieTransaccion = 1;
        SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
        BEGIN TRANSACTION;
    END

    BEGIN TRY
        -- Recorrer array de documentos
        DECLARE doc_cursor CURSOR LOCAL FAST_FORWARD FOR
            SELECT value
    FROM OPENJSON(@jsonInput);
        OPEN doc_cursor;
        FETCH NEXT FROM doc_cursor INTO @item;
        WHILE @@FETCH_STATUS = 0
        BEGIN
        -- 1) IdentityDocs
        SET @identitytype    = JSON_VALUE(@item,'$.identitytype');
        SET @identitystate   = JSON_VALUE(@item,'$.identitystate');
        SET @idName          = JSON_VALUE(@item,'$.name');
        SET @field1          = JSON_VALUE(@item,'$.field1');
        SET @field2          = JSON_VALUE(@item,'$.field2');
        SET @temporary       = ISNULL(TRY_CAST(JSON_VALUE(@item,'$.temporary') AS BIT),1);
        SET @expirationdate  = TRY_CAST(JSON_VALUE(@item,'$.expirationdate') AS DATETIME);
        SET @referenceVal    = JSON_VALUE(@item,'$.referenceVal');
        SET @referenceId     = JSON_VALUE(@item,'$.referenceId');

        DECLARE @identitytypeid INT;
        SELECT TOP 1 @identitytypeid = it.identitytypeid FROM dbo.vpv_identitytype AS it WHERE it.name  = @identitytype;
        IF @identitytypeid IS NULL
        BEGIN
            -- 50262: tipo de identidad inválido
            RAISERROR(50263, 16, 1, @identitytype);
            RETURN;  -- sale al CATCH
        END

        DECLARE @identitystateid INT;
        SELECT TOP 1 @identitystateid = ids.identitystateid FROM dbo.vpv_identitystates AS ids WHERE ids.name  = @identitystate;
        IF @identitystateid IS NULL
        BEGIN
            -- 50263: estado de identidad inválido
            RAISERROR(50264, 16, 1, @identitystate);
            RETURN;
        END



        INSERT INTO dbo.vpv_identitydocs
            (
            identitytypeid, identitystateid, [name], field1, field2,
            temporary, creationdate, enable, expirationdate,
            referencevalue, referenceid
            )
        VALUES
            (
                @identitytypeid, @identitystateid, @idName, @field1, @field2,
                @temporary, GETDATE(), 1, @expirationdate,
                @referenceVal, @referenceId
            );
        SET @identitydocsid = SCOPE_IDENTITY();

        -- 2) Docs
        SET @format        = JSON_VALUE(@item,'$.format');
        SET @docstype      = JSON_VALUE(@item,'$.docstype');
        SET @docstate      = JSON_VALUE(@item,'$.docstate');
        SET @archiveBase64 = JSON_VALUE(@item,'$.archive');

        DECLARE @formatid INT;
        SELECT TOP 1 @formatid = f.formatid FROM dbo.vpv_formats AS f WHERE f.name  = @format;
        IF @formatid IS NULL
        BEGIN
            RAISERROR(50265, 16, 1, @format);
            RETURN;
        END

        DECLARE @docstypeid INT;
        SELECT TOP 1 @docstypeid = dt.docstypeid FROM dbo.vpv_docstypes AS dt WHERE dt.name  = @docstype;
        IF @docstypeid IS NULL
        BEGIN
            RAISERROR(50266, 16, 1, @docstype);
            RETURN;
        END

        DECLARE @docstateid INT;
        SELECT TOP 1 @docstateid = ds.docstateid FROM dbo.vpv_docstates AS ds WHERE ds.name  = @docstate;
        IF @docstateid IS NULL
        BEGIN
            RAISERROR(50267, 16, 1, @docstate);
            RETURN;
        END

        -- Validar que el valor no sea NULL
        IF @archiveBase64 IS NULL
        BEGIN
            RAISERROR('El campo "archive" es obligatorio.', 16, 1);
            RETURN;
        END

        -- Convertir base64 a varbinary
        BEGIN TRY
        SET @archive = CAST(@archiveBase64 AS VARBINARY(MAX));
        END TRY
        BEGIN CATCH
            RAISERROR('El valor de archive no es una cadena base64 válida.', 16, 1);
            RETURN;
        END CATCH

        SET @filename          = JSON_VALUE(@item,'$.filename');
        SET @docDate           = TRY_CAST(JSON_VALUE(@item,'$.date') AS DATETIME);
        SET @startdate         = TRY_CAST(JSON_VALUE(@item,'$.startdate') AS DATETIME);
        SET @nextcheckdate     = TRY_CAST(JSON_VALUE(@item,'$.nextcheckdate') AS DATETIME);
        SET @semantic_category = JSON_VALUE(@item,'$.semantic_category');
        SET @docEnable         = ISNULL(TRY_CAST(JSON_VALUE(@item,'$.docEnable') AS BIT),1);
        SET @docChecksum       = HASHBYTES('SHA2_256', @filename + CONVERT(VARCHAR(30),@docDate,126));

        INSERT INTO dbo.vpv_docs
            (
            identitydocsid, formatid, docstypeid, docstateid,
            archive, filename, [date], [enable],
            startdate, nextcheckdate, semantic_category, checksum
            )
        VALUES
            (
                @identitydocsid, @formatid, @docstypeid, @docstateid,
                @archive, @filename, @docDate, @docEnable,
                @startdate, @nextcheckdate, @semantic_category, @docChecksum
            );
        SET @docid = SCOPE_IDENTITY();

        -- 3) FilesPerProposal
        SET @fileEnable   = ISNULL(TRY_CAST(JSON_VALUE(@item,'$.fileEnable') AS BIT),1);
        SET @relacion     = JSON_VALUE(@item,'$.relacion');
        SET @fileChecksum = HASHBYTES('SHA2_256', CONCAT(@proposalId,'_',@docid));

        INSERT INTO dbo.vpv_FilesPerProposal
            (
            proposalId, docid, [enable], deleted,
            checksum, proposalVersionId, relacion
            )
        VALUES
            (
                @proposalId, @docid, @fileEnable, 0,
                @fileChecksum, @proposalVersionId, @relacion
            );

        FETCH NEXT FROM doc_cursor INTO @item;
    END
        CLOSE doc_cursor;
        DEALLOCATE doc_cursor;

        IF @InicieTransaccion = 1
            COMMIT;
        END TRY
    BEGIN CATCH
        IF @InicieTransaccion = 1
            ROLLBACK;

        DECLARE
            @ErrNum INT    = ERROR_NUMBER(),
            @ErrSev INT    = ERROR_SEVERITY(),
            @ErrSta INT    = ERROR_STATE(),
            @ErrMsg NVARCHAR(4000) = ERROR_MESSAGE();
        RAISERROR('%s - Error Number: %i',
            @ErrSev, @ErrSta, @ErrMsg, @ErrNum);
    END CATCH
END;
GO




-----------------------------------------------------------
-- Autor: Daniel Sequeira
-- Fecha: 06/09/2025
-- Descripción: Orquesta todo el flujo de creación de una propuesta
--              a partir de un único JSON que agrupa:
--                - votingConfig
--                - targetPopulations
--                - proposal
--                - documents
-- Recibe:
--   @jsonAll           NVARCHAR(MAX) JSON con la siguiente estructura:
--   {
--     "user": " ... ",
--     "proposal": { … },
--     "votingConfig": { … },
--     "targetPopulations": { "targetPopulations": [ … ] },
--     "documents": [ … ]
--   }
-- Devuelve por OUTPUT:
--   @newConfigId       INT   – idVotingConfig
--   @outProposalId     INT   – proposalId
--   @outVersionId      INT   – proposalVersionId
-----------------------------------------------------------
CREATE OR ALTER PROCEDURE dbo.vpvSP_CrearActualizarPropuesta
    @jsonAll           NVARCHAR(MAX),
    @newConfigId       INT           OUTPUT,
    @outProposalId     INT           OUTPUT,
    @outVersionId      INT           OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE 
        @idUser       INT,
        @hasIt        BIT,
        @inTrans      BIT = 0,
        @eNum         INT,
        @eSev         INT,
        @eSta         INT,
        @eMsg         NVARCHAR(4000);

    -----------------------------------------------------------------
    -- 0) Desencriptar y extraer usuario
    -----------------------------------------------------------------
    OPEN SYMMETRIC KEY llavecedula
      DECRYPTION BY PASSWORD = 'clavecedula';

    SELECT @idUser = u.idUser
    FROM dbo.vpv_Users AS u
    WHERE CONVERT(NVARCHAR(50),
          DecryptByKey(CAST(u.id_card AS VARBINARY(MAX)))
    ) = JSON_VALUE(@jsonAll, '$.user');

    CLOSE SYMMETRIC KEY llavecedula;

    IF @idUser IS NULL
    BEGIN
        INSERT INTO dbo.vpv_logs (description, computer, username, trace, referenceId1, referenceId2, value1, value2, chechsum, logSeverityId, logSourceId, logTypeId)
          VALUES ('Usuario no encontrado en vpv_Users', @@SERVERNAME, HOST_NAME(),
                  'vpvSP_CrearActualizarPropuesta', JSON_VALUE(@jsonAll,'$.user'),
                  NULL, NULL, NULL, 0x0,
                  (SELECT logSeverityId FROM dbo.vpv_logSeverity WHERE [name]='High'),
                  (SELECT logSourceId   FROM dbo.vpv_logsSources WHERE [name]='API'),
                  (SELECT logTypeId     FROM dbo.vpv_logTypes   WHERE [name]='Error'));
        -- Mensaje 50200
        RAISERROR(50200, 16, 1);
        RETURN;
    END

    -----------------------------------------------------------------
    -- 1) Verificar rol "Proponente"
    -----------------------------------------------------------------
    EXEC dbo.vpvSP_UserHasRole
        @idUser   = @idUser,
        @roleName = 'Proponente',
        @HasRole  = @hasIt OUTPUT;

    IF @hasIt = 0
    BEGIN
        INSERT INTO dbo.vpv_logs (description, computer, username, trace, referenceId1, referenceId2, value1, value2, chechsum, logSeverityId, logSourceId, logTypeId)
          VALUES ('Usuario sin rol Proponente', @@SERVERNAME, HOST_NAME(),
                  'vpvSP_UserHasRole', CAST(@idUser AS VARCHAR(10)), NULL,
                  NULL, NULL, 0x0,
                  (SELECT logSeverityId FROM dbo.vpv_logSeverity WHERE [name]='Medium'),
                  (SELECT logSourceId   FROM dbo.vpv_logsSources WHERE [name]='Security'),
                  (SELECT logTypeId     FROM dbo.vpv_logTypes   WHERE [name]='Warning'));
        -- Mensaje 50201 con parámetro @idUser
        RAISERROR(50201, 16, 1, @idUser);
        RETURN;
    END

    -----------------------------------------------------------------
    -- 2) Iniciar transacción
    -----------------------------------------------------------------
    IF @@TRANCOUNT = 0
    BEGIN
        SET @inTrans = 1;
        SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
        BEGIN TRANSACTION;
    END

    BEGIN TRY
        -----------------------------------------------------------------
        -- A) Upsert Proposal + Version
        -----------------------------------------------------------------
        DECLARE @jp NVARCHAR(MAX) = JSON_QUERY(@jsonAll, '$.proposal');
        EXEC dbo.vpvSP_UpsertProposalWithVersion
            @jsonProposal = @jp,
            @idUser       = @idUser,
            @outProposalId= @outProposalId OUTPUT,
            @outVersionId = @outVersionId OUTPUT;

        INSERT INTO dbo.vpv_logs (description, computer, username, trace, referenceId1, referenceId2, value1, value2, chechsum, logSeverityId, logSourceId, logTypeId) VALUES
          ('UpsertProposalWithVersion completado', @@SERVERNAME, HOST_NAME(),
           'vpvSP_UpsertProposalWithVersion',
           CAST(@outProposalId AS VARCHAR(10)), CAST(@outVersionId AS VARCHAR(10)),
           NULL, NULL, 0x0,
           (SELECT logSeverityId FROM dbo.vpv_logSeverity WHERE [name]='Informational'),
           (SELECT logSourceId   FROM dbo.vpv_logsSources WHERE [name]='Database'),
           (SELECT logTypeId     FROM dbo.vpv_logTypes   WHERE [name]='Audit'));

        -----------------------------------------------------------------
        -- B) Insert VotingConfig
        -----------------------------------------------------------------
        DECLARE @jc NVARCHAR(MAX) = JSON_QUERY(@jsonAll, '$.votingConfig');
        EXEC dbo.vpvSP_InsertVotingConfig
            @jsonConfig        = @jc,
            @idUser            = @idUser,
            @idProposalVersion = @outVersionId,
            @newConfigId       = @newConfigId OUTPUT;

        INSERT INTO dbo.vpv_logs (description, computer, username, trace, referenceId1, referenceId2, value1, value2, chechsum, logSeverityId, logSourceId, logTypeId) VALUES
          ('InsertVotingConfig completado', @@SERVERNAME, HOST_NAME(),
           'vpvSP_InsertVotingConfig', CAST(@newConfigId AS VARCHAR(10)), NULL,
           NULL, NULL, 0x0,
           (SELECT logSeverityId FROM dbo.vpv_logSeverity WHERE [name]='Informational'),
           (SELECT logSourceId   FROM dbo.vpv_logsSources WHERE [name]='Database'),
           (SELECT logTypeId     FROM dbo.vpv_logTypes   WHERE [name]='Audit'));

        -----------------------------------------------------------------
        -- C) Insert Target Populations
        -----------------------------------------------------------------
        DECLARE @jtp NVARCHAR(MAX) = JSON_QUERY(@jsonAll, '$.targetPopulations');
        EXEC dbo.vpvSP_InsertTargetPopulationsVoting
            @jsonTPV        = @jtp,
            @idUser         = @idUser,
            @idVotingConfig = @newConfigId;

        INSERT INTO dbo.vpv_logs (description, computer, username, trace, referenceId1, referenceId2, value1, value2, chechsum, logSeverityId, logSourceId, logTypeId) VALUES
          ('InsertTargetPopulationsVoting completado', @@SERVERNAME, HOST_NAME(),
           'vpvSP_InsertTargetPopulationsVoting', CAST(@newConfigId AS VARCHAR(10)), NULL,
           NULL, NULL, 0x0,
           (SELECT logSeverityId FROM dbo.vpv_logSeverity WHERE [name]='Informational'),
           (SELECT logSourceId   FROM dbo.vpv_logsSources WHERE [name]='Database'),
           (SELECT logTypeId     FROM dbo.vpv_logTypes   WHERE [name]='Audit'));

        -----------------------------------------------------------------
        -- D) Insert Documents
        -----------------------------------------------------------------
        DECLARE @jd NVARCHAR(MAX) = JSON_QUERY(@jsonAll, '$.documents');
        EXEC dbo.vpvSP_InsertProposalDocuments
            @jsonInput         = @jd,
            @idUser            = @idUser,
            @proposalId        = @outProposalId,
            @proposalVersionId = @outVersionId;

        INSERT INTO dbo.vpv_logs (description, computer, username, trace, referenceId1, referenceId2, value1, value2, chechsum, logSeverityId, logSourceId, logTypeId) VALUES
          ('InsertProposalDocuments completado', @@SERVERNAME, HOST_NAME(),
           'vpvSP_InsertProposalDocuments', CAST(@outProposalId AS VARCHAR(10)), NULL,
           NULL, NULL, 0x0,
           (SELECT logSeverityId FROM dbo.vpv_logSeverity WHERE [name]='Informational'),
           (SELECT logSourceId   FROM dbo.vpv_logsSources WHERE [name]='Database'),
           (SELECT logTypeId     FROM dbo.vpv_logTypes   WHERE [name]='Audit'));

        -----------------------------------------------------------------
        -- Commit final
        -----------------------------------------------------------------
        IF @inTrans = 1
            COMMIT;
    END TRY

    BEGIN CATCH
        IF @inTrans = 1
            ROLLBACK;

        SET @eNum = ERROR_NUMBER();
        SET @eSev = ERROR_SEVERITY();
        SET @eSta = ERROR_STATE();
        SET @eMsg = ERROR_MESSAGE();

        -- Mensaje 50202 con detalle
        RAISERROR(50202, @eSev, @eSta, @eMsg, @eNum);
    END CATCH
END;
GO

