-----------------------------------------------------------
-- Autor: Daniel Sequeira
-- Fecha: 06/07/2025
-- Descripcion: Verifica si un usuario tiene permiso para ejecutar
--              una acción sobre un recurso (tabla/vista)
-- Parámetros:
--   @idUser        INT               Identificador del usuario
--   @resourceName  NVARCHAR(200)     Nombre del recurso (tabla/vista)
--   @actionName    NVARCHAR(20)      Nombre de la acción (SELECT, INSERT, etc.)
--   @Puede         BIT OUTPUT        1 = tiene permiso, 0 = no lo tiene
-----------------------------------------------------------
CREATE OR ALTER PROCEDURE [dbo].[vpvSP_UsuarioPuede]
    @idUser        INT,
    @resourceName  NVARCHAR(200),
    @actionName    NVARCHAR(20),
    @Puede         BIT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE
        @existsUser   BIT,
        @resourceId   INT,
        @actionId     INT;

    --------------------------------------------
    -- 1. Validaciones básicas (no requieren transacción)
    --------------------------------------------
    -- Verificar que el usuario exista y esté activo
    SELECT @existsUser = CASE WHEN COUNT(1) > 0 THEN 1 ELSE 0 END
      FROM dbo.vpv_Users
     WHERE idUser = @idUser
       AND [enable] = 1
       AND [deleted] = 0;
    IF @existsUser = 0
    BEGIN
        SET @Puede = 0;
        RETURN;
    END

    -- Obtener ID del recurso
    SELECT @resourceId = id_permissionResource
      FROM dbo.vpv_PermissionResource
     WHERE name    = @resourceName
       AND enabled = 1
       AND deleted = 0;
    IF @resourceId IS NULL
    BEGIN
        SET @Puede = 0;
        RETURN;
    END

    -- Obtener ID de la acción
    SELECT @actionId = id_permissionAction
      FROM dbo.vpv_PermissionAction
     WHERE name = @actionName;
    IF @actionId IS NULL
    BEGIN
        SET @Puede = 0;
        RETURN;
    END

    --------------------------------------------
    -- 2. Verificación de permiso
    --------------------------------------------
    -- Revisar si existe al menos una cadena:
    -- Usuario -> UserRole -> RolePermission -> Permissions -> Resource+Action
    IF EXISTS (
        SELECT 1
          FROM dbo.vpv_UserRole      ur
          JOIN dbo.vpv_RolePermission rp ON rp.id_role       = ur.id_role
          JOIN dbo.vpv_Permissions    p  ON p.id_permission   = rp.id_permission
         WHERE ur.idUser = @idUser
           AND p.id_permisionResource = @resourceId
           AND p.id_permissionAction   = @actionId
           AND ur.enabled = 1
           AND ur.deleted = 0
           AND p.enabled = 1
           AND p.deleted = 0
    )
    BEGIN
        SET @Puede = 1;
    END
    ELSE
    BEGIN
        SET @Puede = 0;
    END
END;
GO

-- DECLARE @tienePermiso BIT;
-- EXEC dbo.vpvSP_UsuarioPuede
--   @idUser       = 1,
--   @resourceName = 'vpv_proposals',
--   @actionName   = 'INSERT',
--   @Puede        = @tienePermiso OUTPUT;
-- SELECT @tienePermiso AS Usuario_Puede_Insertar_Propuestas;