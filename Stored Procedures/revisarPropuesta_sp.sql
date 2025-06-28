CREATE OR ALTER PROCEDURE dbo.revisarPropuesta
    @proposalId INT -- ID de la propuesta a revisar
AS
BEGIN
    -- Evita mostrar en consola la cantidad de filas afectadas por cada instrucci�n
    SET NOCOUNT ON;
	 
    -- Inicia una transacci�n para asegurar que todos los cambios se realicen o ninguno
    BEGIN TRANSACTION;

    -- Declaraci�n de variables auxiliares
    DECLARE
        @idpropuesta    INT,             -- ID del tipo de propuesta (proposalTypeId)
        @TipoPropuesta  NVARCHAR(50),    -- Nombre del tipo de propuesta
        @ProcessId      INT,             -- ID del proceso asociado a la propuesta
        @Cnt            INT,             -- Contador usado para validaciones
        @ErrorMsg       NVARCHAR(MAX) = N''; -- Mensaje de error en caso de fallos

    -------------------------------------------------------------------------
    -- PASO 1: Obtener el tipo y nombre de la propuesta desde su ID
    -------------------------------------------------------------------------

	-- TABLAS INVOLUCRADAS:
	-- vpv_proposals: Tabla que contiene las propuestas, de esta manera conseguimos llegar
	-- al tipo de la propuesta para encontrar su proceso asignado.
	-- vpv_proposalTypes: Aqu� se encuentra los tipos de propuestas, cada tipo
	-- de propuesta tiene un proceso asignado, por eso tenemos que sacar el tipo
    SELECT 
        @idpropuesta   = p.proposalTypeId,
        @TipoPropuesta = pt.name
    FROM dbo.vpv_proposals AS p
    JOIN dbo.vpv_proposalTypes AS pt
      ON p.proposalTypeId = pt.proposalTypeId
    WHERE p.proposalId = @proposalId;

    -- Si no se encuentra la propuesta, se genera un error y se sale
    IF @idpropuesta IS NULL
    BEGIN
        SET @ErrorMsg = N'Propuesta no encontrada (ID=' 
                      + CAST(@proposalId AS NVARCHAR(10)) + N')';
        GOTO ErrorHandler;
    END

    -------------------------------------------------------------------------
    -- PASO 2: Buscar el proceso relacionado con el tipo de propuesta
    -------------------------------------------------------------------------

	-- TABLAS INVOLUCRADAS:
	-- vpv_process: Tabla que guarda la informaci�n acerca de como va a ser el proceso (workflow) 
	-- para ya sea un doc, propuesta o informaci�n que necesite una l�nea de proceso.
	-- Aqu� lo que hacemos es que a partir del tipo de la propuesta llegamos al proceso que
	-- le toca
    SELECT TOP 1 
        @ProcessId = pr.processid
    FROM dbo.vpv_process AS pr
    WHERE pr.referencevalue = @idpropuesta
      AND pr.referenceid    = N'proposalTypeId'
    ORDER BY pr.[order]; -- Se asume que el proceso con menor orden es el principal

    -- Si no hay proceso asociado, se lanza un error
    IF @ProcessId IS NULL
    BEGIN
        SET @ErrorMsg = N'Proceso no encontrado para proposalTypeId=' 
                      + CAST(@idpropuesta AS NVARCHAR(10));
        GOTO ErrorHandler;
    END

    -------------------------------------------------------------------------
    -- PASO 3A: Validaci�n en tabla vpv_workresults (resultados del proceso)
    -- Se verifica que:
    --   - No existan errores diferentes de 0
    --   - El mensaje de error sea exactamente 'Nulo'
    --   - El resultado haya sido realizado por IA Azure
    -------------------------------------------------------------------------

	-- TABLAS INVOLUCRADAS:
	-- vpv_workresults: Tabla que guarda los resultados de las operaciones en un workflow, en este
	-- caso la usamos para asegurarnos que en todo el proceso no hubo fallos ni intervenciones
    SELECT @Cnt = COUNT(*)
    FROM dbo.vpv_workresults AS wr
    WHERE wr.processid      = @ProcessId
      AND (
           wr.error        <> 0
        OR wr.errorMessage <> N'Nulo'
        OR wr.performedby  <> N'IA Azure'
      );

    -- Si se encuentra al menos un registro con fallos, se lanza error
    IF @Cnt > 0
    BEGIN
        SET @ErrorMsg = N'Validaci�n fallida en vpv_workresults';
        GOTO ErrorHandler;
    END

    -------------------------------------------------------------------------
    -- PASO 3B: Validaci�n en tabla vpv_extractedinfos (informaci�n extra�da)
    -- Se valida que no haya errores en los datos procesados vinculados al proceso
    -------------------------------------------------------------------------

	-- TABLAS INVOLUCRADAS:
	-- vpv_extractedinfos: Tabla que guarda la informaci�n extra�da de cada proceso, un workresult
	-- indica si estuvo correcto pero esta tabla dice que sacamos de ese proceso y si est� bien.
	-- En este caso la usamos para asegurarnos que la informaci�n extra�da este correcta.
    SELECT @Cnt = COUNT(*)
    FROM dbo.vpv_extractedinfos AS ei
    JOIN dbo.vpv_workresults AS wr2
      ON ei.workresultid = wr2.workresultid
    WHERE wr2.processid = @ProcessId
      AND ei.error     <> 0;

    -- Si se encuentra alg�n error en los datos extra�dos, se detiene el proceso
    IF @Cnt > 0
    BEGIN
        SET @ErrorMsg = N'Validaci�n fallida en vpv_extractedinfos';
        GOTO ErrorHandler;
    END

    -------------------------------------------------------------------------
    -- PASO 4: Actualizaci�n del estado de la propuesta y trazabilidad
    -------------------------------------------------------------------------

	-- TABLAS INVOLUCRADAS:
	-- vpv_proposals: Se actualiza la propuesta 
	-- vpv_workresults: Se registra el �ltimo flujo de trabajo donde se deja qui�n
	-- realiz� la revisi�n de la propueta.
    -- Se marca la propuesta como "Publicada" y se registra la fecha actual
    UPDATE dbo.vpv_proposals
    SET 
        startingDate = GETDATE(), -- De actualiza la fecha
        statusId     = 12         -- Estado "Publicada"
    WHERE proposalId = @proposalId;

    -- Se deja un rastro en los resultados del proceso, indicando qui�n la revis�
    UPDATE dbo.vpv_workresults
    SET 
        performedby = SUSER_SNAME(), -- Nombre del usuario que ejecut� la revisi�n
        details     = N'Trazabilidad de an�lisis t�cnico completado; fuente de aprobaci�n: IA Azure.'
    WHERE processid = @ProcessId;

    -- Finaliza exitosamente la transacci�n
    COMMIT TRANSACTION;

    -- Mensaje de confirmaci�n en consola
    PRINT N'Propuesta revisada exitosamente.';
    RETURN 0; -- �xito

    -------------------------------------------------------------------------
    -- MANEJO DE ERRORES: En caso de cualquier falla
    -------------------------------------------------------------------------
ErrorHandler:
    -- Revierte cualquier cambio hecho en la base
    ROLLBACK TRANSACTION;
    -- Lanza el mensaje de error personalizado
    RAISERROR(@ErrorMsg, 16, 1);
    RETURN -1; -- C�digo de error
END;
GO