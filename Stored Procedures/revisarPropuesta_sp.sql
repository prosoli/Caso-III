CREATE OR ALTER PROCEDURE dbo.revisarPropuesta
    @proposalId INT -- ID de la propuesta a revisar
AS
BEGIN
    -- Evita mostrar en consola la cantidad de filas afectadas por cada instrucción
    SET NOCOUNT ON;
	 
    -- Inicia una transacción para asegurar que todos los cambios se realicen o ninguno
    BEGIN TRANSACTION;

    -- Declaración de variables auxiliares
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
	-- vpv_proposalTypes: Aquí se encuentra los tipos de propuestas, cada tipo
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
	-- vpv_process: Tabla que guarda la información acerca de como va a ser el proceso (workflow) 
	-- para ya sea un doc, propuesta o información que necesite una línea de proceso.
	-- Aquí lo que hacemos es que a partir del tipo de la propuesta llegamos al proceso que
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
    -- PASO 3A: Validación en tabla vpv_workresults (resultados del proceso)
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
        SET @ErrorMsg = N'Validación fallida en vpv_workresults';
        GOTO ErrorHandler;
    END

    -------------------------------------------------------------------------
    -- PASO 3B: Validación en tabla vpv_extractedinfos (información extraída)
    -- Se valida que no haya errores en los datos procesados vinculados al proceso
    -------------------------------------------------------------------------

	-- TABLAS INVOLUCRADAS:
	-- vpv_extractedinfos: Tabla que guarda la información extraída de cada proceso, un workresult
	-- indica si estuvo correcto pero esta tabla dice que sacamos de ese proceso y si está bien.
	-- En este caso la usamos para asegurarnos que la información extraída este correcta.
    SELECT @Cnt = COUNT(*)
    FROM dbo.vpv_extractedinfos AS ei
    JOIN dbo.vpv_workresults AS wr2
      ON ei.workresultid = wr2.workresultid
    WHERE wr2.processid = @ProcessId
      AND ei.error     <> 0;

    -- Si se encuentra algún error en los datos extraídos, se detiene el proceso
    IF @Cnt > 0
    BEGIN
        SET @ErrorMsg = N'Validación fallida en vpv_extractedinfos';
        GOTO ErrorHandler;
    END

    -------------------------------------------------------------------------
    -- PASO 4: Actualización del estado de la propuesta y trazabilidad
    -------------------------------------------------------------------------

	-- TABLAS INVOLUCRADAS:
	-- vpv_proposals: Se actualiza la propuesta 
	-- vpv_workresults: Se registra el último flujo de trabajo donde se deja quién
	-- realizó la revisión de la propueta.
    -- Se marca la propuesta como "Publicada" y se registra la fecha actual
    UPDATE dbo.vpv_proposals
    SET 
        startingDate = GETDATE(), -- De actualiza la fecha
        statusId     = 12         -- Estado "Publicada"
    WHERE proposalId = @proposalId;

    -- Se deja un rastro en los resultados del proceso, indicando quién la revisó
    UPDATE dbo.vpv_workresults
    SET 
        performedby = SUSER_SNAME(), -- Nombre del usuario que ejecutó la revisión
        details     = N'Trazabilidad de análisis técnico completado; fuente de aprobación: IA Azure.'
    WHERE processid = @ProcessId;

    -- Finaliza exitosamente la transacción
    COMMIT TRANSACTION;

    -- Mensaje de confirmación en consola
    PRINT N'Propuesta revisada exitosamente.';
    RETURN 0; -- Éxito

    -------------------------------------------------------------------------
    -- MANEJO DE ERRORES: En caso de cualquier falla
    -------------------------------------------------------------------------
ErrorHandler:
    -- Revierte cualquier cambio hecho en la base
    ROLLBACK TRANSACTION;
    -- Lanza el mensaje de error personalizado
    RAISERROR(@ErrorMsg, 16, 1);
    RETURN -1; -- Código de error
END;
GO