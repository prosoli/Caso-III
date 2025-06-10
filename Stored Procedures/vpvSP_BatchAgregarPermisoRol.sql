

-----------------------------------------------------------
-- Autor: Daniel Sequeira
-- Fecha: 06/10/2025
-- Descripción: Otorga en bloque un permiso a múltiples recursos
--              reutilizando el SP existente dbo.vpvSP_AgregarPermisoRol.
--              Si un recurso ya tiene permiso, se omite el error y continúa.
-- Parámetros:
--   @roleName       NVARCHAR(100)  Nombre del rol (debe existir)
--   @actionName     NVARCHAR(20)   Acción ('SELECT','INSERT','UPDATE','DELETE')
--   @resourceList   NVARCHAR(MAX)  Lista de recursos separados por comas
-----------------------------------------------------------
CREATE OR ALTER PROCEDURE [dbo].[vpvSP_BatchAgregarPermisoRol]
    @roleName     NVARCHAR(100),
    @actionName   NVARCHAR(20),
    @resourceList NVARCHAR(MAX)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @InTrans BIT = 0;
    IF @@TRANCOUNT = 0
    BEGIN
        SET @InTrans = 1;
        SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
        BEGIN TRANSACTION;
    END

    DECLARE 
        @resource NVARCHAR(200),
        @errorMsg NVARCHAR(1000);

    DECLARE resource_cursor CURSOR LOCAL FAST_FORWARD FOR
        SELECT LTRIM(RTRIM(value))
          FROM STRING_SPLIT(@resourceList, ',')
        WHERE LTRIM(RTRIM(value)) <> '';

    OPEN resource_cursor;
    FETCH NEXT FROM resource_cursor INTO @resource;
    WHILE @@FETCH_STATUS = 0
    BEGIN
        BEGIN TRY
            EXEC dbo.vpvSP_AgregarPermisoRol
                @roleName     = @roleName,
                @resourceName = @resource,
                @actionName   = @actionName;
        END TRY
        BEGIN CATCH
            SET @errorMsg = FORMATMESSAGE(
                'Error asignando permiso [%s] al recurso [%s]: %s',
                @actionName, @resource, ERROR_MESSAGE()
            );
            PRINT @errorMsg;
            -- También podrías loguearlo en una tabla si se desea
        END CATCH;

        FETCH NEXT FROM resource_cursor INTO @resource;
    END

    CLOSE resource_cursor;
    DEALLOCATE resource_cursor;

    IF @InTrans = 1
        COMMIT;
END;
GO


