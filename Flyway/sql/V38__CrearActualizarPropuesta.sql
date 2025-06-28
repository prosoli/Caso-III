-----------------------------------------------------------
-- Autor: Daniel Sequeira
-- Fecha: 04/25/2025
-- Descripcion: Crea o actualiza una propuesta y su versión.
-- Si la propuesta es nueva, se inserta en ambas tablas.
-- Si ya existe, crea una nueva versión,
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
	
    -- Verificamos que el usuario tiene permisos sobre la
    -- tabla, ingresame el nombre de la tabla y la accion que se va a realizar
    -- en el sp UsuarioPuede, este devuelve 1, si tiene permiso, o 0, si no.
    -- Si no tiene permisos se lanza el error 50241 y se retorna
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

    -- Verificamos que el usuario tiene permisos sobre la
    -- tabla, ingresame el nombre de la tabla y la accion que se va a realizar
    -- en el sp UsuarioPuede, este devuelve 1, si tiene permiso, o 0, si no.
    -- Si no tiene permisos se lanza el error 50241 y se retorna
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

    -- Verificamos que el usuario tiene permisos sobre la
    -- tabla, ingresame el nombre de la tabla y la accion que se va a realizar
    -- en el sp UsuarioPuede, este devuelve 1, si tiene permiso, o 0, si no.
    -- Si no tiene permisos se lanza el error 50241 y se retorna
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

    -- Verificamos que el usuario tiene permisos sobre la
    -- tabla, ingresame el nombre de la tabla y la accion que se va a realizar
    -- en el sp UsuarioPuede, este devuelve 1, si tiene permiso, o 0, si no.
    -- Si no tiene permisos se lanza el error 50241 y se retorna
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

    -- Verificamos que el usuario tiene permisos sobre la
    -- tabla, ingresame el nombre de la tabla y la accion que se va a realizar
    -- en el sp UsuarioPuede, este devuelve 1, si tiene permiso, o 0, si no.
    -- Si no tiene permisos se lanza el error 50241 y se retorna
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

    -- Verificamos que el usuario tiene permisos sobre la
    -- tabla, ingresame el nombre de la tabla y la accion que se va a realizar
    -- en el sp UsuarioPuede, este devuelve 1, si tiene permiso, o 0, si no.
    -- Si no tiene permisos se lanza el error 50241 y se retorna
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

    -- Verificamos que el usuario tiene permisos sobre la
    -- tabla, ingresame el nombre de la tabla y la accion que se va a realizar
    -- en el sp UsuarioPuede, este devuelve 1, si tiene permiso, o 0, si no.
    -- Si no tiene permisos se lanza el error 50241 y se retorna
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

    -- Verificamos que el usuario tiene permisos sobre la
    -- tabla, ingresame el nombre de la tabla y la accion que se va a realizar
    -- en el sp UsuarioPuede, este devuelve 1, si tiene permiso, o 0, si no.
    -- Si no tiene permisos se lanza el error 50241 y se retorna
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

    -- Aqui extraemos los valores requeridos del json y convertimos valores
    -- de budget a decimal y starting date a datetime
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
    -- Dado el nombre de horario en el JSON (@schedule), buscamos su scheduleId.
    -- Si no existe, lanzamos error 50273 y salimos.
    DECLARE @scheduleId INT;
    SELECT TOP 1 @scheduleId = s.scheduleId
      FROM dbo.vpv_schedules AS s
     WHERE s.name = @schedule;
    IF @scheduleId IS NULL
    BEGIN
        RAISERROR(50273, 16, 1, @schedule);
        RETURN;
    END;

    -- Dado el nombre del estado de la propuesta en el JSON (@status), buscamos su statusId.
    -- Si no existe, lanzamos error 50273 y salimos.
    DECLARE @statusId INT;
    SELECT TOP 1 @statusId = ps.statusId
      FROM dbo.vpv_processStatus AS ps
     WHERE ps.name = @status;
    IF @statusId IS NULL
    BEGIN
        RAISERROR(50274, 16, 1, @status);
        RETURN;
    END;     

    -- Dado el nombre del tipo de propuesta en el JSON (@proposalType), buscamos su proposalTypeId.
    -- Si no existe, lanzamos error 50273 y salimos.
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
    -- Creamos un hash que represente de forma unica los datos clave de la propuesta
    -- Este valor se guarda para detectar cambios o integridad.
    SET @checksum = HASHBYTES('SHA2_256', 
        CONCAT(@tittle, '|', @description, '|', CONVERT(VARCHAR(30),@budget,126))
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
        -- ¿Existe ya la propuesta?
        -- Buscamos una propuesta que en proposals que haga match con el titulo proveido en el json
        -- y el idUser que obtuvimos antes, tambien evitamos las propuestas que hayan sido eliminadas
        SELECT @proposalId = proposalId
          FROM dbo.vpv_proposals
         WHERE tittle = @tittle
           AND idUser = @idUser
           AND deleted = 0;

        -- Si resulto que la propuesta no existe entonces la creamos
        IF @proposalId IS NULL
        BEGIN
            -- Inserción de nueva propuesta
            -- Realizamos en insert de la nueva propuesta con todos sus datos
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
            -- Y aqui guardamos el id de la nueva propuesta para usarlo en la creacion de la verison,
            -- tambien lo devolvemos como respuesta en el endpoint, para verificar
            SET @proposalId = SCOPE_IDENTITY();
            -- Realizamos un insert en logs para dejar registro de la creacion de la nueva propuesta
            INSERT INTO dbo.vpv_logs (description, computer, username, trace, referenceId1, referenceId2, value1, value2, chechsum, logSeverityId, logSourceId, logTypeId) VALUES
            ('Nueva propuesta creada', @@SERVERNAME, HOST_NAME(),
            'vpvSP_UpsertProposalWithVersion',
            CAST(@description AS VARCHAR(10)), CAST(@proposalId AS VARCHAR(10)),
            NULL, NULL, 0x0,
            (SELECT logSeverityId FROM dbo.vpv_logSeverity WHERE [name]='Informational'),
            (SELECT logSourceId   FROM dbo.vpv_logsSources WHERE [name]='Database'),
            (SELECT logTypeId     FROM dbo.vpv_logTypes   WHERE [name]='Audit'));

        END
        ELSE
        BEGIN
            -- Si la propuesta ya existe, solo realizamos un log.
            INSERT INTO dbo.vpv_logs (description, computer, username, trace, referenceId1, referenceId2, value1, value2, chechsum, logSeverityId, logSourceId, logTypeId) VALUES
                ('Propuesta ya existe', @@SERVERNAME, HOST_NAME(),
                'vpvSP_UpsertProposalWithVersion',
                CAST(@description AS VARCHAR(10)), CAST(@proposalId AS VARCHAR(10)),
                NULL, NULL, 0x0,
                (SELECT logSeverityId FROM dbo.vpv_logSeverity WHERE [name]='Informational'),
                (SELECT logSourceId   FROM dbo.vpv_logsSources WHERE [name]='Database'),
                (SELECT logTypeId     FROM dbo.vpv_logTypes   WHERE [name]='Audit'));

        END

        -- 2) Deshabilitar versiones previas
        -- Como para cada actualizacion de la propuesta, se debe desactivar y quitar el lastVersion
        -- a la versiones de la propuesta, para crear una nueva con los nuevos datos,
        -- asi que buscamos en proposalVersions los registro que hagan match con el proposal id que obtuvimos antes
        UPDATE dbo.vpv_proposalVersions
           SET enable      = 0,
               lastVersion = 0
         WHERE proposalId = @proposalId;

        -- 3) Insertar nueva versión
        -- Y tal como lo disenamos, la propuesta principal se queda intacta y los cambios se hacen crean nuevas versiones
        -- aqui ingresamos los mismos datos que llevaria la propuesta y la colocamos como lastVersion
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
        -- Aqui tambien salvamos el id de la nueva version para utilizarlo mas tarde y tambien para retornarla como respuesta
        -- para verificar lso datos
        SET @versionId = SCOPE_IDENTITY();
        -- Tambien realizamos un insert en logs para dejar registro de la nueva version
        INSERT INTO dbo.vpv_logs (description, computer, username, trace, referenceId1, referenceId2, value1, value2, chechsum, logSeverityId, logSourceId, logTypeId) VALUES
            ('Version de Propuesta creada', @@SERVERNAME, HOST_NAME(),
            'vpvSP_UpsertProposalWithVersion',
            CAST(@tittle AS VARCHAR(10)), CAST(@versionId AS VARCHAR(10)),
            NULL, NULL, 0x0,
            (SELECT logSeverityId FROM dbo.vpv_logSeverity WHERE [name]='Informational'),
            (SELECT logSourceId   FROM dbo.vpv_logsSources WHERE [name]='Database'),
            (SELECT logTypeId     FROM dbo.vpv_logTypes   WHERE [name]='Audit'));

        -- Salidas
        -- Aqui colocamos los id para las salidas del sp
        -- los vamos a usar despues
        SET @outProposalId = @proposalId;
        SET @outVersionId  = @versionId;

        IF @InicieTransaccion = 1
            COMMIT;
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
    @idProposalVersion INT, -- aqui se recie el id de proposal version que habiamos dicho que ocupariaos despues
    @newConfigId  INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

	DECLARE @tienePermiso BIT;
	DECLARE @permissionResource VARCHAR(100);
	DECLARE @permissionAction VARCHAR(100);    

    -- Verificamos que el usuario tiene permisos sobre la
    -- tabla, ingresame el nombre de la tabla y la accion que se va a realizar
    -- en el sp UsuarioPuede, este devuelve 1, si tiene permiso, o 0, si no.
    -- Si no tiene permisos se lanza el error 50241 y se retorna
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

    -- Verificamos que el usuario tiene permisos sobre la
    -- tabla, ingresame el nombre de la tabla y la accion que se va a realizar
    -- en el sp UsuarioPuede, este devuelve 1, si tiene permiso, o 0, si no.
    -- Si no tiene permisos se lanza el error 50241 y se retorna
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

    -- Verificamos que el usuario tiene permisos sobre la
    -- tabla, ingresame el nombre de la tabla y la accion que se va a realizar
    -- en el sp UsuarioPuede, este devuelve 1, si tiene permiso, o 0, si no.
    -- Si no tiene permisos se lanza el error 50241 y se retorna
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

    -- Verificamos que el usuario tiene permisos sobre la
    -- tabla, ingresame el nombre de la tabla y la accion que se va a realizar
    -- en el sp UsuarioPuede, este devuelve 1, si tiene permiso, o 0, si no.
    -- Si no tiene permisos se lanza el error 50241 y se retorna
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

    -- Verificamos que el usuario tiene permisos sobre la
    -- tabla, ingresame el nombre de la tabla y la accion que se va a realizar
    -- en el sp UsuarioPuede, este devuelve 1, si tiene permiso, o 0, si no.
    -- Si no tiene permisos se lanza el error 50241 y se retorna
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

    -- Verificamos que el usuario tiene permisos sobre la
    -- tabla, ingresame el nombre de la tabla y la accion que se va a realizar
    -- en el sp UsuarioPuede, este devuelve 1, si tiene permiso, o 0, si no.
    -- Si no tiene permisos se lanza el error 50241 y se retorna
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

    -- Verificamos que el usuario tiene permisos sobre la
    -- tabla, ingresame el nombre de la tabla y la accion que se va a realizar
    -- en el sp UsuarioPuede, este devuelve 1, si tiene permiso, o 0, si no.
    -- Si no tiene permisos se lanza el error 50241 y se retorna
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

    -- Verificamos que el usuario tiene permisos sobre la
    -- tabla, ingresame el nombre de la tabla y la accion que se va a realizar
    -- en el sp UsuarioPuede, este devuelve 1, si tiene permiso, o 0, si no.
    -- Si no tiene permisos se lanza el error 50241 y se retorna
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

    -- Verificamos que el usuario tiene permisos sobre la
    -- tabla, ingresame el nombre de la tabla y la accion que se va a realizar
    -- en el sp UsuarioPuede, este devuelve 1, si tiene permiso, o 0, si no.
    -- Si no tiene permisos se lanza el error 50241 y se retorna
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


    -- Aqui extraemos los valores requeridos del json
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

    -- Emepezamos a buscar los id de los tipos, estados, etc.
    -- Dado el nombre del estado de la votacion en el JSON (@statusVoting), buscamos su idStatusVoting en vpv_statusVoting
    -- Si no existe, lanzamos error 50268 y salimos.
    DECLARE @statusVotingId INT;
    SELECT TOP 1 @statusVotingId = sv.idStatusVoting FROM dbo.vpv_statusVoting AS sv WHERE sv.name  = @statusVoting;
    IF @statusVotingId IS NULL
    BEGIN
        RAISERROR(50268, 16, 1, @statusVoting);
        RETURN;
    END;    

    -- Dado el nombre del tipo de votacion en el JSON (@votingType), buscamos su idVotingType en vpv_votingTypes
    -- Si no existe, lanzamos error 50269 y salimos.
    DECLARE @votingTypeId INT;
    SELECT TOP 1 @votingTypeId = vt.idVotingType FROM dbo.vpv_votingTypes AS vt WHERE vt.name  = @votingType;
    IF @votingTypeId IS NULL
    BEGIN
        RAISERROR(50269, 16, 1, @votingType);
        RETURN;
    END;    

    -- Dado el nombre del tipo de recordatorio en el JSON (@reminderType), buscamos su idReminderType en vpv_reminderTypes
    -- Si no existe, lanzamos error 50270 y salimos.
    DECLARE @reminderTypeId INT;
    SELECT TOP 1 @reminderTypeId = rt.idReminderType FROM dbo.vpv_reminderTypes AS rt WHERE rt.name  = @reminderType;
    IF @reminderTypeId IS NULL
    BEGIN
        RAISERROR(50270, 16, 1, @reminderType);
        RETURN;
    END;    

    -- Dado el nombre del tipo de cierre de la votacion en el JSON (@closureType), buscamos su idClosureTypes en vpv_ClosureTypes
    -- Si no existe, lanzamos error 50270 y salimos.
    DECLARE @closureTypeId INT;
    SELECT TOP 1 @closureTypeId = ct.idClosureTypes FROM dbo.vpv_ClosureTypes AS ct WHERE ct.name  = @closureType;
    IF @closureTypeId IS NULL
    BEGIN
        RAISERROR(50271, 16, 1, @closureType);
        RETURN;
    END;    

    -- Dado el nombre de las razones de votacion en el JSON (@votingReasons), buscamos su idvotingReasons en vpv_votingReasons
    -- Si no existe, lanzamos error 50271 y salimos.
    DECLARE @votingReasonsId INT;
    SELECT TOP 1 @votingReasonsId = vr.idvotingReasons FROM dbo.vpv_votingReasons AS vr WHERE vr.name  = @votingReasons;
    IF @votingReasonsId IS NULL
    BEGIN
        RAISERROR(50272, 16, 1, @votingReasons);
        RETURN;
    END;    

    -- Buscamos el id del excution plan dado el nombre proveido en el json
    DECLARE @executionPlanId INT;
    SELECT TOP 1 @executionPlanId = ep.executionPlanId FROM dbo.vpv_executionPlans AS ep WHERE ep.tittle  = @executionPlan;

    -- Buscamos el id del metric plan dado el nombre proveido en el json
    DECLARE @metricPlanId  INT;
    SELECT TOP 1 @metricPlanId  = mp.metricPlanId FROM dbo.vpv_MetricPerPlan AS mp WHERE mp.name  = @metricPlan;

    -- Buscamos el id del reporte del proyecto dado el nombre proveido en el json
    DECLARE @projectReportId  INT;
    SELECT TOP 1 @projectReportId  = pr.projectReportId FROM dbo.vpv_projectReports AS pr WHERE pr.tittle  = @projectReport;



    -- Calcular checksum
    -- Concatenamos todas las piezas clave de la configuración en una cadena
    -- Este valor se almacena en la tabla para verificar integridad o detectar cambio
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
        -- Con todos los id requeridos y los otros valores podemos hacer el insert de la configucacion de votacion
        -- y tambien se inserta el id de la verison de propuesta actual
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
        -- Guardamos el id de la votacion de configuracion para usarlo en el llenado de
        -- la poblacion meta
        SET @newConfigId = SCOPE_IDENTITY();
        -- Y tambien dejamos registro de la nueva configuracion de votacion en el logs
        INSERT INTO dbo.vpv_logs (description, computer, username, trace, referenceId1, referenceId2, value1, value2, chechsum, logSeverityId, logSourceId, logTypeId) VALUES
          ('Nueva configuracion de votacion', @@SERVERNAME, HOST_NAME(),
           'idVotingConfig', CAST(@newConfigId AS VARCHAR(10)), NULL,
           NULL, NULL, 0x0,
           (SELECT logSeverityId FROM dbo.vpv_logSeverity WHERE [name]='Informational'), -- aqui buscamos los id de lso tipos de logs
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
-----------------------------------------------------------
-- Autor: Daniel Sequeira
-- Fecha: 06/08/2025
-- Descripcion: Inserta registros en vpv_TargetPopulationsVoting usando un idVotingConfig fijo (1)
--              a partir de un arreglo de poblaciones con name y weight.
-- Parámetros:
--   @jsonTPV     NVARCHAR(MAX) JSON con campos:
--                   targetPopulations: arreglo de objetos { name, weight }
--   @lastId      INT OUTPUT    ID de la última fila insertada en vpv_TargetPopulationsVoting
-----------------------------------------------------------
CREATE OR ALTER PROCEDURE [dbo].[vpvSP_InsertTargetPopulationsVoting]
  @idUser          INT,
  @jsonTPV         NVARCHAR(MAX),
  @idVotingConfig  INT -- aqui se hace uso del idVotingConfig que guardamos antes
AS
BEGIN
    SET NOCOUNT ON;
    -- estas variables no son para los inserts, son de errores y de verificacion
    DECLARE 
        @tienePermiso      BIT,
        @permissionResource VARCHAR(100), -- la tabla
        @permissionAction   VARCHAR(100), -- la accion sobre la tabla
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
    -- Verificamos que el usuario tiene permisos sobre la
    -- tabla, ingresame el nombre de la tabla y la accion que se va a realizar
    -- en el sp UsuarioPuede, este devuelve 1, si tiene permiso, o 0, si no.
    -- Si no tiene permisos se lanza el error 50241 y se retorna
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
    -- Verificamos que el usuario tiene permisos sobre la
    -- tabla, ingresame el nombre de la tabla y la accion que se va a realizar
    -- en el sp UsuarioPuede, este devuelve 1, si tiene permiso, o 0, si no.
    -- Si no tiene permisos se lanza el error 50241 y se retorna
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
        -- como el json que recibe viene en la forma de una arreglo,
        -- usamos un cursor para recorrerlo
        DECLARE tp_cursor CURSOR FAST_FORWARD FOR -- y aqui le decimos al cursor sobre que va a se usado, que debe recorrer
            SELECT value 
              FROM OPENJSON(@jsonTPV, '$.targetPopulations');

        OPEN tp_cursor;
        FETCH NEXT FROM tp_cursor INTO @tp;

        WHILE @@FETCH_STATUS = 0
        BEGIN
            -- el nombre de la poblacion meta y el peso de importante que le damos
            SET @popName   = JSON_VALUE(@tp, '$.name');
            SET @popWeight = TRY_CAST(JSON_VALUE(@tp, '$.weight') AS DECIMAL(5,2));

            -- Buscar idTargetPopulation
            -- una ves tenes el nombre, buscamos el primer id en la tabla TargetPopulations que haga match con 
            -- el nombre que tenemos y chequeamos que esta habilitado
            SELECT TOP 1 @popId = idTargetPopulation
              FROM dbo.vpv_TargetPopulations
             WHERE [name]  = @popName
               AND enable  = 1;

            -- si no encontro el id de la poblacion meta, entonces lanza el error 50262 y retorna
            IF @popId IS NULL
            BEGIN
                -- 50262: población no encontrada
                RAISERROR(50262, 16, 1, @popName);
                IF @InTrans = 1 ROLLBACK; -- hace rollback a la transaccion
                CLOSE tp_cursor; DEALLOCATE tp_cursor; -- y libera al cursor
                RETURN;
            END

            -- Calcular checksum
            -- Concatenamos todas las piezas clave de la configuración en una cadena
            -- Este valor se almacena en la tabla para verificar integridad o detectar cambio
            SET @checksum = HASHBYTES('SHA2_256',
                CONCAT(
                    @idVotingConfig,
                    @popId,
                    @popWeight
                )
            );

            -- con los id obtenidos y el idVoting config de antes, realizamos el insert
            INSERT INTO dbo.vpv_TargetPopulationsVoting
                (idVotingConfig, idTargetPopulation, checksum, enable, weight)
            VALUES
                (@idVotingConfig, @popId, @checksum, 1, ISNULL(@popWeight,1));
            -- Guardamos el id del nuevo insert para hacer un registro en logs
            DECLARE @newTPV INT = SCOPE_IDENTITY();
            
            -- aqui dejamos registro del nuevo targetPopulationVoting
            INSERT INTO dbo.vpv_logs (description, computer, username, trace, referenceId1, referenceId2, value1, value2, chechsum, logSeverityId, logSourceId, logTypeId) VALUES
                ('Nuevo target population voting completado ' + @popName, @@SERVERNAME, HOST_NAME(),
                'vpv_TargetPopulationsVoting', CAST(@newTPV AS VARCHAR(10)), NULL,
                NULL, NULL, 0x0,
                (SELECT logSeverityId FROM dbo.vpv_logSeverity WHERE [name]='Informational'), -- buscamos los id de los tipos de logs
                (SELECT logSourceId   FROM dbo.vpv_logsSources WHERE [name]='Database'),
                (SELECT logTypeId     FROM dbo.vpv_logTypes   WHERE [name]='Audit'));

            FETCH NEXT FROM tp_cursor INTO @tp;
        END

        CLOSE tp_cursor; -- cerramos el cursor
        DEALLOCATE tp_cursor; -- y los liberamos

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
-- Descripcion: Inserta identitydocs, vpv_docs y vpv_FilesPerProposal y process
--              a partir de un JSON con una lista anidada de documentos.
-- Recibe:
--   @jsonInput         NVARCHAR(MAX) JSON con un array de objetos
--     [
--       {

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
	
    -- Verificamos que el usuario tiene permisos sobre la
    -- tabla, ingresamos el nombre de la tabla y la accion que se va a realizar
    -- en el sp UsuarioPuede, este devuelve 1, si tiene permiso, o 0, si no.
    -- Si no tiene permisos se lanza el error 50241 y se retorna
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

    -- Verificamos que el usuario tiene permisos sobre la
    -- tabla, ingresame el nombre de la tabla y la accion que se va a realizar
    -- en el sp UsuarioPuede, este devuelve 1, si tiene permiso, o 0, si no.
    -- Si no tiene permisos se lanza el error 50241 y se retorna
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

    -- Verificamos que el usuario tiene permisos sobre la
    -- tabla, ingresame el nombre de la tabla y la accion que se va a realizar
    -- en el sp UsuarioPuede, este devuelve 1, si tiene permiso, o 0, si no.
    -- Si no tiene permisos se lanza el error 50241 y se retorna
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

    -- Verificamos que el usuario tiene permisos sobre la
    -- tabla, ingresame el nombre de la tabla y la accion que se va a realizar
    -- en el sp UsuarioPuede, este devuelve 1, si tiene permiso, o 0, si no.
    -- Si no tiene permisos se lanza el error 50241 y se retorna
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

    -- Verificamos que el usuario tiene permisos sobre la
    -- tabla, ingresame el nombre de la tabla y la accion que se va a realizar
    -- en el sp UsuarioPuede, este devuelve 1, si tiene permiso, o 0, si no.
    -- Si no tiene permisos se lanza el error 50241 y se retorna
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

    -- Verificamos que el usuario tiene permisos sobre la
    -- tabla, ingresame el nombre de la tabla y la accion que se va a realizar
    -- en el sp UsuarioPuede, este devuelve 1, si tiene permiso, o 0, si no.
    -- Si no tiene permisos se lanza el error 50241 y se retorna
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

    -- Verificamos que el usuario tiene permisos sobre la
    -- tabla, ingresame el nombre de la tabla y la accion que se va a realizar
    -- en el sp UsuarioPuede, este devuelve 1, si tiene permiso, o 0, si no.
    -- Si no tiene permisos se lanza el error 50241 y se retorna
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

    -- Verificamos que el usuario tiene permisos sobre la
    -- tabla, ingresame el nombre de la tabla y la accion que se va a realizar
    -- en el sp UsuarioPuede, este devuelve 1, si tiene permiso, o 0, si no.
    -- Si no tiene permisos se lanza el error 50241 y se retorna
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
        -- creamos un cursos para recorrer el arreglo de documentos
        DECLARE doc_cursor CURSOR LOCAL FAST_FORWARD FOR
            SELECT value
                FROM OPENJSON(@jsonInput);
        OPEN doc_cursor; -- iniciamos el cursor
        FETCH NEXT FROM doc_cursor INTO @item;
        WHILE @@FETCH_STATUS = 0
        BEGIN
        -- 1) IdentityDocs
        -- extraemos los datos del json
        SET @identitytype    = JSON_VALUE(@item,'$.identitytype');
        SET @identitystate   = JSON_VALUE(@item,'$.identitystate');
        SET @idName          = JSON_VALUE(@item,'$.name');
        SET @field1          = JSON_VALUE(@item,'$.field1');
        SET @field2          = JSON_VALUE(@item,'$.field2');
        SET @temporary       = ISNULL(TRY_CAST(JSON_VALUE(@item,'$.temporary') AS BIT),1); -- lo convertimos
        SET @expirationdate  = TRY_CAST(JSON_VALUE(@item,'$.expirationdate') AS DATETIME); -- lo convertimos
        SET @referenceVal    = JSON_VALUE(@item,'$.referenceVal');
        SET @referenceId     = JSON_VALUE(@item,'$.referenceId');

        -- una ves con los valores vamos a buscar los id
        -- aqui intentamos obtener el id de identityType en la tabla vpv_identitytype
        -- si no los encontramos lanzamos el error 50263 y retornamos
        DECLARE @identitytypeid INT;
        SELECT TOP 1 @identitytypeid = it.identitytypeid FROM dbo.vpv_identitytype AS it WHERE it.name  = @identitytype;
        IF @identitytypeid IS NULL
        BEGIN
            -- 50262: tipo de identidad inválido
            RAISERROR(50263, 16, 1, @identitytype);
            RETURN;  -- sale al CATCH
        END

        -- aqui intentamos obtener el id de @identitystate en la tabla vpv_identitystates
        -- si no los encontramos lanzamos el error 50264 y retornamos
        DECLARE @identitystateid INT;
        SELECT TOP 1 @identitystateid = ids.identitystateid FROM dbo.vpv_identitystates AS ids WHERE ids.name  = @identitystate;
        IF @identitystateid IS NULL
        BEGIN
            -- 50263: estado de identidad inválido
            RAISERROR(50264, 16, 1, @identitystate);
            RETURN;
        END


        -- hacemos el insert a identity docs para identificar los documentos, necesario para insert en docs
        -- tambien insertamos una referencia a la version de la propuesta actual, para que se sepa que a pertenen los documentos
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
                @proposalVersionId, 'proposalVersionId'
            );

        -- guardamos el id del identitydoc insertado
        SET @identitydocsid = SCOPE_IDENTITY();
        -- log de exito
        -- dejamos registro del la insercion del identitydoc
        INSERT INTO dbo.vpv_logs (description, computer, username, trace, referenceId1, referenceId2, value1, value2, chechsum, logSeverityId, logSourceId, logTypeId) VALUES
          ('Nuevo identity docs completado' + @idName, @@SERVERNAME, HOST_NAME(),
           'identitydocsid', CAST(@identitydocsid AS VARCHAR(10)), NULL,
           NULL, NULL, 0x0,
           (SELECT logSeverityId FROM dbo.vpv_logSeverity WHERE [name]='Informational'), -- buscamos los id de los tipos de logs
           (SELECT logSourceId   FROM dbo.vpv_logsSources WHERE [name]='Database'),
           (SELECT logTypeId     FROM dbo.vpv_logTypes   WHERE [name]='Audit'));

        -- 2) Docs
        -- los valores para la tabla de docs
        SET @format        = JSON_VALUE(@item,'$.format');
        SET @docstype      = JSON_VALUE(@item,'$.docstype');
        SET @docstate      = JSON_VALUE(@item,'$.docstate');
        SET @archiveBase64 = JSON_VALUE(@item,'$.archive');

        -- aqui intentamos obtener el id de @format en la tabla vpv_formats
        -- si no los encontramos lanzamos el error 50265 y retornamos
        DECLARE @formatid INT;
        SELECT TOP 1 @formatid = f.formatid FROM dbo.vpv_formats AS f WHERE f.name  = @format;
        IF @formatid IS NULL
        BEGIN
            RAISERROR(50265, 16, 1, @format);
            RETURN;
        END

        -- aqui intentamos obtener el id de @docstype en la tabla vpv_docstypes
        -- si no los encontramos lanzamos el error 50266 y retornamos
        DECLARE @docstypeid INT;
        SELECT TOP 1 @docstypeid = dt.docstypeid FROM dbo.vpv_docstypes AS dt WHERE dt.name  = @docstype;
        IF @docstypeid IS NULL
        BEGIN
            RAISERROR(50266, 16, 1, @docstype);
            RETURN;
        END

        -- aqui intentamos obtener el id de @docstate en la tabla vpv_docstates
        -- si no los encontramos lanzamos el error 50267 y retornamos
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
        -- por diseno el @archive debe insertarse como un varbinary por deberia ser un documento recibido como base64
        BEGIN TRY
        SET @archive = CAST(@archiveBase64 AS VARBINARY(MAX));
        END TRY
        BEGIN CATCH
            RAISERROR('El valor de archive no es una cadena base64 válida.', 16, 1);
            RETURN;
        END CATCH

        -- obtenes mas valores del json para insertar en docs
        SET @filename          = JSON_VALUE(@item,'$.filename');
        SET @docDate           = TRY_CAST(JSON_VALUE(@item,'$.date') AS DATETIME);
        SET @startdate         = TRY_CAST(JSON_VALUE(@item,'$.startdate') AS DATETIME);
        SET @nextcheckdate     = TRY_CAST(JSON_VALUE(@item,'$.nextcheckdate') AS DATETIME);
        SET @semantic_category = JSON_VALUE(@item,'$.semantic_category');
        SET @docEnable         = ISNULL(TRY_CAST(JSON_VALUE(@item,'$.docEnable') AS BIT),1);
        SET @docChecksum       = HASHBYTES('SHA2_256', @filename + CONVERT(VARCHAR(30),@docDate,126));

        -- aqui se suben los documentos de la propuesta
        -- con los datos del json hacemos el insert
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

        -- guardamos el id del doc para hacer logs, insertar en file per proposal y para crear el proceso
        SET @docid = SCOPE_IDENTITY();

        -- registramos la creacion de los docs en logs
        INSERT INTO dbo.vpv_logs (description, computer, username, trace, referenceId1, referenceId2, value1, value2, chechsum, logSeverityId, logSourceId, logTypeId) VALUES
          ('InsertProposalDocuments completado' + @filename, @@SERVERNAME, HOST_NAME(),
           'docid', CAST(@docid AS VARCHAR(10)), NULL,
           NULL, NULL, 0x0,
           (SELECT logSeverityId FROM dbo.vpv_logSeverity WHERE [name]='Informational'), -- buscamos los id de los tipos de logs
           (SELECT logSourceId   FROM dbo.vpv_logsSources WHERE [name]='Database'),
           (SELECT logTypeId     FROM dbo.vpv_logTypes   WHERE [name]='Audit'));

        -- 3) FilesPerProposal
        -- obtenemos datos del json para insertar en files per proposal y creamos el checksum
        SET @fileEnable   = ISNULL(TRY_CAST(JSON_VALUE(@item,'$.fileEnable') AS BIT),1);
        SET @relacion     = JSON_VALUE(@item,'$.relacion');
        SET @fileChecksum = HASHBYTES('SHA2_256', CONCAT(@proposalId,@proposalVersionId,@docid,@relacion));

        -- y aqui, vpv_FilesPerProposal, se relacionan los docs y la propuesta
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

        -- guardamos el id de file per proposal para hacer el log
        DECLARE @fpid INT = SCOPE_IDENTITY();

        -- dejamos registro de la insercion en logs
        INSERT INTO dbo.vpv_logs (description, computer, username, trace, referenceId1, referenceId2, value1, value2, chechsum, logSeverityId, logSourceId, logTypeId) VALUES
          ('Insert de file per proposal completado', @@SERVERNAME, HOST_NAME(),
           'fileProposalId', CAST(@fpid AS VARCHAR(10)), NULL,
           NULL, NULL, 0x0,
           (SELECT logSeverityId FROM dbo.vpv_logSeverity WHERE [name]='Informational'), -- buscamos los id de los tipos de logs
           (SELECT logSourceId   FROM dbo.vpv_logsSources WHERE [name]='Database'),
           (SELECT logTypeId     FROM dbo.vpv_logTypes   WHERE [name]='Audit'));

        DECLARE
            @procName     NVARCHAR(100),
            @procDesc     NVARCHAR(100),
            @TypeId   INT,
            @ParamId  INT,
            @randMethodId INT = 1;  -- asumido

        -- obtener el tipo y el parametro
        SELECT TOP 1 @TypeId  = processtypeid FROM dbo.vpv_processtypes;
        SELECT TOP 1 @ParamId = parameterid   FROM dbo.vpv_parameters WHERE enable = 1;

        -- le ponemos nombre al proceso, que seria el procesos para el doc_n
        SET @procName = 'Doc_' + CAST(@docid AS NVARCHAR(10));
        SET @procDesc = 'AutoProceso doc ' + CAST(@docid AS NVARCHAR(10));

        -- se intenta realizar el insert en process, esto para que la ia lo procese despues, se inserta una refencia del id del documentos
        -- en process se insertan cosas que la IA o un proceso automatico o manual van validar
        -- esto para validar los documentos de la propuesta
        -- dejamos una referencia a docs

        INSERT INTO dbo.vpv_process
            (processtypeid, referencevalue, referenceid, parameterid,
                processmethodid, [name], [description], enable, fecha, [order])
        VALUES
            (@TypeId,
                @docid,
                'docid',
                @ParamId,
                @randMethodId,
                @procName,
                @procDesc,
                1,
                GETDATE(),
                0);
        
        -- guardamos el id del procesos para hacer un log
        DECLARE @proId INT = SCOPE_IDENTITY();

        -- registramos la creacion del proceso
        INSERT INTO dbo.vpv_logs (description, computer, username, trace, referenceId1, referenceId2, value1, value2, chechsum, logSeverityId, logSourceId, logTypeId) VALUES
          ('Creacion de proceso completado', @@SERVERNAME, HOST_NAME(),
           'processId', CAST(@proId AS VARCHAR(10)), NULL,
           NULL, NULL, 0x0,
           (SELECT logSeverityId FROM dbo.vpv_logSeverity WHERE [name]='Informational'), -- buscamos los id de los tipos de logs
           (SELECT logSourceId   FROM dbo.vpv_logsSources WHERE [name]='Database'),
           (SELECT logTypeId     FROM dbo.vpv_logTypes   WHERE [name]='Audit'));



        FETCH NEXT FROM doc_cursor INTO @item; -- pasamos al siguiente documentos si existe
    END
        CLOSE doc_cursor; -- cerramos el curso
        DEALLOCATE doc_cursor; -- y lo liberamos

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
    @jsonAll           NVARCHAR(MAX), -- el json con todas la partes para los sp auxiliares
    @newConfigId       INT           OUTPUT, -- el votingconfigid para verificar
    @outProposalId     INT           OUTPUT, -- el proposalid para verificar
    @outVersionId      INT           OUTPUT -- el versionid para verificar
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE 
        @idUser       INT, -- lo obtenemos despues de descifrar la cedula
        @hasIt        BIT, -- para el permiso
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

    -- recorremos los usuario y vamos desencriptando la cedula y comparandola con la que el usuario proveyo
    SELECT @idUser = u.idUser
    FROM dbo.vpv_Users AS u
    WHERE CONVERT(NVARCHAR(50),
          DecryptByKey(CAST(u.id_card AS VARBINARY(MAX)))
    ) = JSON_VALUE(@jsonAll, '$.user');

    CLOSE SYMMETRIC KEY llavecedula;

    -- si no se encontro un usuario, lo registramos en el log y lanzamos un error 50200
    IF @idUser IS NULL
    BEGIN
        INSERT INTO dbo.vpv_logs (description, computer, username, trace, referenceId1, referenceId2, value1, value2, chechsum, logSeverityId, logSourceId, logTypeId)
          VALUES ('Usuario no encontrado en vpv_Users', @@SERVERNAME, HOST_NAME(),
                  'vpvSP_CrearActualizarPropuesta', JSON_VALUE(@jsonAll,'$.user'),
                  NULL, NULL, NULL, 0x0,
                  (SELECT logSeverityId FROM dbo.vpv_logSeverity WHERE [name]='High'), -- buscamos los id de los tipos de logs
                  (SELECT logSourceId   FROM dbo.vpv_logsSources WHERE [name]='API'),
                  (SELECT logTypeId     FROM dbo.vpv_logTypes   WHERE [name]='Error'));
        -- Mensaje 50200
        RAISERROR(50200, 16, 1);
        RETURN;
    END

    -----------------------------------------------------------------
    -- 1) Verificar rol "Proponente"
    -----------------------------------------------------------------
    -- revisamos que el usuario tiene el rol proponente para poder crear propuestas
    EXEC dbo.vpvSP_UserHasRole
        @idUser   = @idUser,
        @roleName = 'Proponente',
        @HasRole  = @hasIt OUTPUT;

    -- si el usuario no tiene el rol, lo registramos en log y lanzamos un error 50201
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
        -- tomamos la parte de proposal del json y la pasamos a vpvSP_UpsertProposalWithVersion
        -- esta recibe el iduser y retorna el id de la propuesta y de la version
        DECLARE @jp NVARCHAR(MAX) = JSON_QUERY(@jsonAll, '$.proposal');
        EXEC dbo.vpvSP_UpsertProposalWithVersion
            @jsonProposal = @jp,
            @idUser       = @idUser,
            @outProposalId= @outProposalId OUTPUT,
            @outVersionId = @outVersionId OUTPUT;

        -- registramos el exito del sp
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
        -- pasamos la parte de votingconfig del json al sp vpvSP_InsertVotingConfig
        -- este tambien recibe el iduser y el version id y retorna el id de la votingconfig
        DECLARE @jc NVARCHAR(MAX) = JSON_QUERY(@jsonAll, '$.votingConfig');
        EXEC dbo.vpvSP_InsertVotingConfig
            @jsonConfig        = @jc,
            @idUser            = @idUser,
            @idProposalVersion = @outVersionId,
            @newConfigId       = @newConfigId OUTPUT;

        -- registramos el exito del sp al crear la votingConfig
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
        -- pasamos la parte de targetPopulations al sp vpvSP_InsertTargetPopulationsVoting
        -- este recibe el iduser y el id de votingconfig
        DECLARE @jtp NVARCHAR(MAX) = JSON_QUERY(@jsonAll, '$.targetPopulations');
        EXEC dbo.vpvSP_InsertTargetPopulationsVoting
            @jsonTPV        = @jtp,
            @idUser         = @idUser,
            @idVotingConfig = @newConfigId;

        -- registramos el exito del sp al crear los target population voting
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
        -- pasamos la parte de documentos de la propuesta del json al sp vpvSP_InsertProposalDocuments
        -- este recibe tambien el iduser, el proposalid y el version id
        -- aqui tambien se crea el proceso
        DECLARE @jd NVARCHAR(MAX) = JSON_QUERY(@jsonAll, '$.documents');
        EXEC dbo.vpvSP_InsertProposalDocuments
            @jsonInput         = @jd,
            @idUser            = @idUser,
            @proposalId        = @outProposalId,
            @proposalVersionId = @outVersionId;

        -- registramos el exito del sp
        INSERT INTO dbo.vpv_logs (description, computer, username, trace, referenceId1, referenceId2, value1, value2, chechsum, logSeverityId, logSourceId, logTypeId) VALUES
          ('InsertProposalDocuments completado', @@SERVERNAME, HOST_NAME(),
           'vpvSP_InsertProposalDocuments', CAST(@outVersionId AS VARCHAR(10)), NULL,
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

