-----------------------------------------------------------
-- Autor: Daniel Sequeira
-- Fecha: 06/07/2025
-- Descripcion: Asigna un permiso (recurso + acción) a un rol
-- Parámetros:
--   @roleName      NVARCHAR(100)  Nombre del rol
--   @resourceName  NVARCHAR(200)  Nombre del recurso (tabla/vista)
--   @actionName    NVARCHAR(20)   Nombre de la acción (SELECT, INSERT, etc.)
-----------------------------------------------------------
CREATE OR ALTER PROCEDURE [dbo].[vpvSP_AgregarPermisoRol]
    @roleName      NVARCHAR(100),
    @resourceName  NVARCHAR(200),
    @actionName    NVARCHAR(20)
AS 
BEGIN
    SET NOCOUNT ON;
    
    DECLARE 
        @ErrorNumber       INT,
        @ErrorSeverity     INT,
        @ErrorState        INT,
        @CustomError       INT,
        @Message           VARCHAR(200),
        @InicieTransaccion BIT,
        @roleId            INT,
        @resourceId        INT,
        @actionId          INT,
        @permId            INT,
        @nextRpId          INT;

    --------------------------------------------
    -- 1. Pre-carga y validación antes de la transacción
    --------------------------------------------
    -- Buscar ID de rol
    SELECT @roleId = id_role
      FROM dbo.vpv_Roles
     WHERE name    = @roleName
       AND enabled = 1
       AND deleted = 0;
    IF @roleId IS NULL
    BEGIN
        RAISERROR('Rol no encontrado o no habilitado: %s',16,1,@roleName);
        RETURN;
    END

    -- Buscar ID de recurso
    SELECT @resourceId = id_permissionResource
      FROM dbo.vpv_PermissionResource
     WHERE name    = @resourceName
       AND enabled = 1
       AND deleted = 0;
    IF @resourceId IS NULL
    BEGIN
        RAISERROR('Recurso no encontrado o no habilitado: %s',16,1,@resourceName);
        RETURN;
    END

    -- Buscar ID de acción
    SELECT @actionId = id_permissionAction
      FROM dbo.vpv_PermissionAction
     WHERE name = @actionName;
    IF @actionId IS NULL
    BEGIN
        RAISERROR('Acción no encontrada: %s',16,1,@actionName);
        RETURN;
    END

    -- Buscar permiso existente
    SELECT @permId = id_permission
      FROM dbo.vpv_Permissions
     WHERE id_permisionResource = @resourceId
       AND id_permissionAction   = @actionId
       AND enabled = 1
       AND deleted = 0;
    IF @permId IS NULL
    BEGIN
        RAISERROR('Permiso no existe para el recurso/acción indicados',16,1);
        RETURN;
    END

    --------------------------------------------
    -- 2. Iniciar transacción solo para el INSERT
    --------------------------------------------
    SET @InicieTransaccion = 0;
    IF @@TRANCOUNT = 0
    BEGIN
        SET @InicieTransaccion = 1;
        SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
        BEGIN TRANSACTION;
    END

    BEGIN TRY
        SET @CustomError = 50000;

        -- Evitar duplicados
        IF EXISTS (
            SELECT 1 
              FROM dbo.vpv_RolePermission
             WHERE id_role       = @roleId
               AND id_permission = @permId
        )
        BEGIN
            THROW 50005, 'El rol ya tiene asignado este permiso', 1;
        END

        -- Calcular siguiente PK
        SELECT @nextRpId = ISNULL(MAX(id_role_permission), 0) + 1
          FROM dbo.vpv_RolePermission;

        -- Insertar nueva asignación
        INSERT INTO dbo.vpv_RolePermission
            (id_role_permission, id_role, id_permission)
        VALUES
            (@nextRpId, @roleId, @permId);

        IF @InicieTransaccion = 1
            COMMIT;
    END TRY
    BEGIN CATCH
        SET @ErrorNumber   = ERROR_NUMBER();
        SET @ErrorSeverity = ERROR_SEVERITY();
        SET @ErrorState    = ERROR_STATE();
        SET @Message       = ERROR_MESSAGE();

        IF @InicieTransaccion = 1
            ROLLBACK;

        RAISERROR('%s (Error %d)', 
                  @ErrorSeverity, 
                  @ErrorState, 
                  @Message, 
                  @ErrorNumber);
    END CATCH

    RETURN 0;
END;
GO

-- EXEC dbo.vpvSP_AgregarPermisoRol
--      @roleName     = 'Proponente',
--      @resourceName = 'vpv_proposals',
--      @actionName   = 'INSERT';