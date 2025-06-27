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


        -- hacemos el insert a identity docs para identificar los documentos, necesario para insert en docs
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
        -- log de exito
        INSERT INTO dbo.vpv_logs (description, computer, username, trace, referenceId1, referenceId2, value1, value2, chechsum, logSeverityId, logSourceId, logTypeId) VALUES
          ('Nuevo identity docs completado' + @idName, @@SERVERNAME, HOST_NAME(),
           'vpvSP_InsertProposalDocuments', CAST(@idName AS VARCHAR(10)), NULL,
           NULL, NULL, 0x0,
           (SELECT logSeverityId FROM dbo.vpv_logSeverity WHERE [name]='Informational'),
           (SELECT logSourceId   FROM dbo.vpv_logsSources WHERE [name]='Database'),
           (SELECT logTypeId     FROM dbo.vpv_logTypes   WHERE [name]='Audit'));

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

        -- aqui se suben los documentos de la propuesta
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
        INSERT INTO dbo.vpv_logs (description, computer, username, trace, referenceId1, referenceId2, value1, value2, chechsum, logSeverityId, logSourceId, logTypeId) VALUES
          ('InsertProposalDocuments completado' + @filename, @@SERVERNAME, HOST_NAME(),
           'vpvSP_InsertProposalDocuments', CAST(@filename AS VARCHAR(10)), NULL,
           NULL, NULL, 0x0,
           (SELECT logSeverityId FROM dbo.vpv_logSeverity WHERE [name]='Informational'),
           (SELECT logSourceId   FROM dbo.vpv_logsSources WHERE [name]='Database'),
           (SELECT logTypeId     FROM dbo.vpv_logTypes   WHERE [name]='Audit'));

        -- 3) FilesPerProposal
        SET @fileEnable   = ISNULL(TRY_CAST(JSON_VALUE(@item,'$.fileEnable') AS BIT),1);
        SET @relacion     = JSON_VALUE(@item,'$.relacion');
        SET @fileChecksum = HASHBYTES('SHA2_256', CONCAT(@proposalId,'_',@docid));

        -- y aqui se relacionan los documenos y la propuesta
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
        INSERT INTO dbo.vpv_logs (description, computer, username, trace, referenceId1, referenceId2, value1, value2, chechsum, logSeverityId, logSourceId, logTypeId) VALUES
          ('InsertProposalDocuments completado', @@SERVERNAME, HOST_NAME(),
           'vpvSP_InsertProposalDocuments', CAST(@proposalId AS VARCHAR(10)), NULL,
           NULL, NULL, 0x0,
           (SELECT logSeverityId FROM dbo.vpv_logSeverity WHERE [name]='Informational'),
           (SELECT logSourceId   FROM dbo.vpv_logsSources WHERE [name]='Database'),
           (SELECT logTypeId     FROM dbo.vpv_logTypes   WHERE [name]='Audit'));

            DECLARE
                @procName     NVARCHAR(100),
                @procDesc     NVARCHAR(100),
                @randTypeId   INT,
                @randParamId  INT,
                @randMethodId INT = 1;  -- asumido

            SELECT TOP 1 @randTypeId  = processtypeid FROM dbo.vpv_processtypes;
            SELECT TOP 1 @randParamId = parameterid   FROM dbo.vpv_parameters WHERE enable = 1;

            SET @procName = 'Doc_' + CAST(@docid AS NVARCHAR(10));
            SET @procDesc = 'AutoProceso doc ' + CAST(@docid AS NVARCHAR(10));

            -- se intenta realizar el insert en process, esto para que la ia lo procese despues, se inserta una refencia del id del documentos
            BEGIN TRY
                INSERT INTO dbo.vpv_process
                    (processtypeid, referencevalue, referenceid, parameterid,
                     processmethodid, [name], [description], enable, fecha, [order])
                VALUES
                    (@randTypeId,
                     @docid,
                     'docid',
                     @randParamId,
                     @randMethodId,
                     @procName,
                     @procDesc,
                     1,
                     GETDATE(),
                     0);
            END TRY
            BEGIN CATCH
                -- Sólo loguear, no abortar
                DECLARE
                    @E_Num  INT  = ERROR_NUMBER(),
                    @E_Sev  INT  = ERROR_SEVERITY(),
                    @E_Sta  INT  = ERROR_STATE(),
                    @E_Msg  NVARCHAR(4000)= ERROR_MESSAGE();

                -- si falla se hace un insert a logs
                INSERT INTO dbo.vpv_logs
                    (description, computer, username, trace, referenceId1, referenceId2,
                     value1, value2, chechsum, logSeverityId, logSourceId, logTypeId)
                VALUES
                    (
                      'Fallo al crear proceso: ' + @E_Msg,
                      @@SERVERNAME,
                      HOST_NAME(),
                      'vpvSP_InsertProposalDocuments:vpv_process',
                      CAST(@docid AS NVARCHAR(10)), NULL,
                      NULL, NULL, 0x0,
                      (SELECT logSeverityId FROM dbo.vpv_logSeverity WHERE [name]='Warning'),
                      (SELECT logSourceId   FROM dbo.vpv_logsSources WHERE [name]='Application'),
                      (SELECT logTypeId     FROM dbo.vpv_logTypes   WHERE [name]='Warning')
                    );
                -- continuar con siguiente documento
            END CATCH;


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