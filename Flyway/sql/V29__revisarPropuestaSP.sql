USE puravidabd;
GO

CREATE OR ALTER PROCEDURE dbo.revisarPropuesta
    @proposalId INT
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRANSACTION;

    DECLARE
        @idpropuesta    INT,
        @TipoPropuesta  NVARCHAR(50),
        @ProcessId      INT,
        @Cnt            INT,
        @ErrorMsg       NVARCHAR(MAX) = N'';

    ----------------------------------------
    -- 1) Obtener tipo y nombre
    ----------------------------------------
    SELECT 
        @idpropuesta   = p.proposalTypeId,
        @TipoPropuesta = pt.name
    FROM dbo.vpv_proposals AS p
    JOIN dbo.vpv_proposalTypes AS pt
      ON p.proposalTypeId = pt.proposalTypeId
    WHERE p.proposalId = @proposalId;

    IF @idpropuesta IS NULL
    BEGIN
        SET @ErrorMsg = N'Propuesta no encontrada (ID=' 
                      + CAST(@proposalId AS NVARCHAR(10)) + N')';
        GOTO ErrorHandler;
    END

    ---------------------------------------------------------
    -- 2) Localizar proceso
    ---------------------------------------------------------
    SELECT TOP 1 
        @ProcessId = pr.processid
    FROM dbo.vpv_process AS pr
    WHERE pr.referencevalue = @idpropuesta
      AND pr.referenceid    = N'proposalTypeId'
    ORDER BY pr.[order];

    IF @ProcessId IS NULL
    BEGIN
        SET @ErrorMsg = N'Proceso no encontrado para proposalTypeId=' 
                      + CAST(@idpropuesta AS NVARCHAR(10));
        GOTO ErrorHandler;
    END

    --------------------------------------------------
    -- 3a) Validar vpv_workresults
    --------------------------------------------------
    SELECT @Cnt = COUNT(*)
    FROM dbo.vpv_workresults AS wr
    WHERE wr.processid      = @ProcessId
      AND (
           wr.error        <> 0
        OR wr.errorMessage <> N'Nulo'
        OR wr.performedby  <> N'IA Azure'
      );

    IF @Cnt > 0
    BEGIN
        SET @ErrorMsg = N'Validación fallida en vpv_workresults';
        GOTO ErrorHandler;
    END

    ---------------------------------------------------------
    -- 3b) Validar vpv_extractedinfos
    ---------------------------------------------------------
    SELECT @Cnt = COUNT(*)
    FROM dbo.vpv_extractedinfos AS ei
    JOIN dbo.vpv_workresults AS wr2
      ON ei.workresultid = wr2.workresultid
    WHERE wr2.processid = @ProcessId
      AND ei.error     <> 0;

    IF @Cnt > 0
    BEGIN
        SET @ErrorMsg = N'Validación fallida en vpv_extractedinfos';
        GOTO ErrorHandler;
    END

    -------------------------------------------------
    -- 4) Actualizar propuesta y resultados
    -------------------------------------------------
    UPDATE dbo.vpv_proposals
    SET 
        startingDate = GETDATE(),
        statusId     = 12
    WHERE proposalId = @proposalId;

    UPDATE dbo.vpv_workresults
    SET 
        performedby = SUSER_SNAME(),
        details     = N'Trazabilidad de análisis técnico completado; fuente de aprobación: IA Azure.'
    WHERE processid = @ProcessId;

    COMMIT TRANSACTION;

    -- Mensaje de éxito
    PRINT N'Propuesta revisada exitosamente.';

    RETURN 0;

ErrorHandler:
    ROLLBACK TRANSACTION;
    RAISERROR(@ErrorMsg, 16, 1);
    RETURN -1;
END;
GO