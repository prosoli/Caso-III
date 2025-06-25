
INSERT INTO [dbo].[vpv_PermissionResource] (
    id_permissionResource,
    name,
    creationDate,
    updatedAt,
    enabled,
    deleted
)
SELECT
    ROW_NUMBER() OVER (ORDER BY t.name) + ISNULL((
        SELECT MAX(id_permissionResource) FROM [dbo].[vpv_PermissionResource]
    ), 0) AS id_permissionResource,
    t.name AS name,
    GETDATE() AS creationDate,
    GETDATE() AS updatedAt,
    1 AS enabled,   -- Habilitado por defecto
    0 AS deleted    -- No eliminado por defecto
FROM sys.tables t;



INSERT INTO [dbo].[vpv_PermissionAction] (
    id_permissionAction,
    name,
    descripcion
)
VALUES
    (1, 'SELECT', 'Permite consultar datos de una tabla'),
    (2, 'INSERT', 'Permite insertar nuevos registros en una tabla'),
    (3, 'UPDATE', 'Permite modificar registros existentes en una tabla'),
    (4, 'DELETE', 'Permite eliminar registros de una tabla');



-- Insertar combinaciones de cada resource con cada acción
INSERT INTO [dbo].[vpv_Permissions] (
    id_permission,
    id_permisionResource,
    id_permissionAction,
    descripcion,
    creationDate,
    updatedAt,
    enabled,
    deleted,
    checksum
)
SELECT
    ROW_NUMBER() OVER (ORDER BY r.id_permissionResource, a.id_permissionAction) +
        ISNULL((SELECT MAX(id_permission) FROM [dbo].[vpv_Permissions]), 0) AS id_permission,
    r.id_permissionResource,
    a.id_permissionAction,
    CONCAT('Permiso para ', a.name, ' en ', r.name) AS descripcion,
    GETDATE() AS creationDate,
    GETDATE() AS updatedAt,
    1 AS enabled,
    0 AS deleted,
    -- Ejemplo básico de checksum: puedes usar una función HASH real como HASHBYTES si lo deseas
    CONCAT(r.id_permissionResource, '-', a.id_permissionAction) AS checksum
FROM [dbo].[vpv_PermissionResource] r
CROSS JOIN [dbo].[vpv_PermissionAction] a;





-- Insertar roles en la tabla vpv_Roles con checksum SHA2_256
DECLARE @now DATETIME = GETDATE();
INSERT INTO dbo.vpv_Roles
  ([id_role], [name], [descripcion], [creationDate], [updateAt], [enabled], [deleted], [checksum])
VALUES
  (1,  'Ciudadano',
       'Usuario registrado que puede votar y consultar propuestas.',
       @now, @now, 1, 0,
       HASHBYTES(
         'SHA2_256',
         CONCAT(
           '1','Ciudadano','Usuario registrado que puede votar y consultar propuestas.',
           CONVERT(VARCHAR(126), @now, 126),
           CONVERT(VARCHAR(126), @now, 126),
           '1','0'
         )
       )
  ),
  (2,  'RepresentanteOrg',
       'Usuario que representa a una organización y presenta propuestas.',
       @now, @now, 1, 0,
       HASHBYTES(
         'SHA2_256',
         CONCAT(
           '2','RepresentanteOrg','Usuario que representa a una organización y presenta propuestas.',
           CONVERT(VARCHAR(126), @now, 126),
           CONVERT(VARCHAR(126), @now, 126),
           '1','0'
         )
       )
  ),
  (3,  'Proponente',
       'Usuario que crea y gestiona propuestas de votación.',
       @now, @now, 1, 0,
       HASHBYTES(
         'SHA2_256',
         CONCAT(
           '3','Proponente','Usuario que crea y gestiona propuestas de votación.',
           CONVERT(VARCHAR(126), @now, 126),
           CONVERT(VARCHAR(126), @now, 126),
           '1','0'
         )
       )
  ),
  (4,  'ValidadorHumano',
       'Revisor que valida propuestas con firmas privadas.',
       @now, @now, 1, 0,
       HASHBYTES(
         'SHA2_256',
         CONCAT(
           '4','ValidadorHumano','Revisor que valida propuestas con firmas privadas.',
           CONVERT(VARCHAR(126), @now, 126),
           CONVERT(VARCHAR(126), @now, 126),
           '1','0'
         )
       )
  ),
  (5,  'AceleradoraInversor',
       'Entidad que avala y financia propuestas de crowdfunding.',
       @now, @now, 1, 0,
       HASHBYTES(
         'SHA2_256',
         CONCAT(
           '5','AceleradoraInversor','Entidad que avala y financia propuestas de crowdfunding.',
           CONVERT(VARCHAR(126), @now, 126),
           CONVERT(VARCHAR(126), @now, 126),
           '1','0'
         )
       )
  ),
  (6,  'FuncionarioGubernamental',
       'Representante del Gobierno que aprueba políticas y beneficios.',
       @now, @now, 1, 0,
       HASHBYTES(
         'SHA2_256',
         CONCAT(
           '6','FuncionarioGubernamental','Representante del Gobierno que aprueba políticas y beneficios.',
           CONVERT(VARCHAR(126), @now, 126),
           CONVERT(VARCHAR(126), @now, 126),
           '1','0'
         )
       )
  ),
  (7,  'Auditor',
       'Accede a logs.',
       @now, @now, 1, 0,
       HASHBYTES(
         'SHA2_256',
         CONCAT(
           '8','Auditor','Accede a logs.',
           CONVERT(VARCHAR(126), @now, 126),
           CONVERT(VARCHAR(126), @now, 126),
           '1','0'
         )
       )
  ),
  (8,  'SuperAuditor',
       'Accede a la informacion de log, propuestas, crowdfunding y votaciones.',
       @now, @now, 1, 0,
       HASHBYTES(
         'SHA2_256',
         CONCAT(
           '8','SuperAuditor','Accede a la informacion de log, propuestas, crowdfunding y votaciones.',
           CONVERT(VARCHAR(126), @now, 126),
           CONVERT(VARCHAR(126), @now, 126),
           '1','0'
         )
       )
  );
GO



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




-----------------------------------------------------------
-- Autor: Daniel Sequeira
-- Fecha: 06/07/2025
-- Descripcion: Elimina un permiso (recurso + acción) de un rol
-- Parámetros:
--   @roleName      NVARCHAR(100)  Nombre del rol
--   @resourceName  NVARCHAR(200)  Nombre del recurso (tabla/vista)
--   @actionName    NVARCHAR(20)   Nombre de la acción (SELECT, INSERT, etc.)
-----------------------------------------------------------
CREATE OR ALTER PROCEDURE [dbo].[vpvSP_EliminarPermisoRol]
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
        @Message           VARCHAR(200),
        @InicieTransaccion BIT,
        @roleId            INT,
        @resourceId        INT,
        @actionId          INT,
        @permId            INT;

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
    -- 2. Iniciar transacción solo para el DELETE
    --------------------------------------------
    SET @InicieTransaccion = 0;
    IF @@TRANCOUNT = 0
    BEGIN
        SET @InicieTransaccion = 1;
        SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
        BEGIN TRANSACTION;
    END

    BEGIN TRY
        -- Verificar que la asignación exista
        IF NOT EXISTS (
            SELECT 1 
              FROM dbo.vpv_RolePermission
             WHERE id_role       = @roleId
               AND id_permission = @permId
        )
        BEGIN
            THROW 51001, 'No existe asignación de permiso para este rol.', 1;
        END

        -- Eliminar la asignación
        DELETE FROM dbo.vpv_RolePermission
         WHERE id_role       = @roleId
           AND id_permission = @permId;

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




-----------------------------------------------------------
-- Autor: Daniel Sequeira
-- Fecha: 06/07/2025
-- Descripcion: Asigna un rol a un usuario dado su ID
-- Parámetros:
--   @idUser     INT             Identificador del usuario
--   @roleName   NVARCHAR(100)   Nombre del rol a asignar
-----------------------------------------------------------
CREATE OR ALTER PROCEDURE [dbo].[vpvSP_AsignaRolUsuario]
    @idUser     INT,
    @roleName   NVARCHAR(100)
AS 
BEGIN
    SET NOCOUNT ON;
    
    DECLARE 
        @ErrorNumber       INT,
        @ErrorSeverity     INT,
        @ErrorState        INT,
        @Message           VARCHAR(200),
        @InicieTransaccion BIT,
        @roleId            INT,
        @nextUrId          INT;

    --------------------------------------------
    -- 1. Pre-carga y validación antes de la transacción
    --------------------------------------------
    -- Verificar que el usuario exista y esté activo
    IF NOT EXISTS (
        SELECT 1
          FROM dbo.vpv_Users
         WHERE idUser  = @idUser
           AND [enable] = 1
           AND [deleted] = 0
    )
    BEGIN
        RAISERROR('Usuario no encontrado o no habilitado: %d',16,1,@idUser);
        RETURN;
    END

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

    -- Verificar duplicado antes de iniciar transacción
    IF EXISTS (
        SELECT 1
          FROM dbo.vpv_UserRole
         WHERE idUser  = @idUser
           AND id_role = @roleId
    )
    BEGIN
        RAISERROR('El usuario ya tiene asignado este rol',16,1);
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
        -- Calcular siguiente PK
        SELECT @nextUrId = ISNULL(MAX(id_user_role), 0) + 1
          FROM dbo.vpv_UserRole;

        -- Insertar asignación
        INSERT INTO dbo.vpv_UserRole
            (id_user_role, idUser, id_role, creationDate, updateAt, enabled, deleted, checksum)
        VALUES
            (
              @nextUrId,
              @idUser,
              @roleId,
              GETDATE(),
              GETDATE(),
              1,
              0,
              HASHBYTES(
                'SHA2_256',
                CONCAT(
                  @nextUrId,
                  @idUser,
                  @roleId,
                  CONVERT(VARCHAR(126), GETDATE(), 126),
                  CONVERT(VARCHAR(126), GETDATE(), 126),
                  '1','0'
                )
              )
            );

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






-----------------------------------------------------------
-- Autor: Daniel
-- Fecha: 06/07/2025
-- Descripcion: Remueve un rol de un usuario dado su ID
-- Parámetros:
--   @idUser     INT             Identificador del usuario
--   @roleName   NVARCHAR(100)   Nombre del rol a eliminar
-----------------------------------------------------------
CREATE OR ALTER PROCEDURE [dbo].[vpvSP_RemueveRolUsuario]
    @idUser     INT,
    @roleName   NVARCHAR(100)
AS 
BEGIN
    SET NOCOUNT ON;
    
    DECLARE 
        @ErrorNumber       INT,
        @ErrorSeverity     INT,
        @ErrorState        INT,
        @Message           VARCHAR(200),
        @InicieTransaccion BIT,
        @roleId            INT;

    --------------------------------------------
    -- 1. Pre-carga y validación antes de la transacción
    --------------------------------------------
    -- Verificar que el usuario exista y esté activo
    IF NOT EXISTS (
        SELECT 1
          FROM dbo.vpv_Users
         WHERE idUser  = @idUser
           AND [enable] = 1
           AND [deleted] = 0
    )
    BEGIN
        RAISERROR('Usuario no encontrado o no habilitado: %d',16,1,@idUser);
        RETURN;
    END

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

    -- Verificar existencia de asignación antes de iniciar transacción
    IF NOT EXISTS (
        SELECT 1
          FROM dbo.vpv_UserRole
         WHERE idUser  = @idUser
           AND id_role = @roleId
    )
    BEGIN
        RAISERROR('No existe asignación de este rol para el usuario',16,1);
        RETURN;
    END

    --------------------------------------------
    -- 2. Iniciar transacción solo para el DELETE
    --------------------------------------------
    SET @InicieTransaccion = 0;
    IF @@TRANCOUNT = 0
    BEGIN
        SET @InicieTransaccion = 1;
        SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
        BEGIN TRANSACTION;
    END

    BEGIN TRY
        -- Eliminar asignación
        DELETE FROM dbo.vpv_UserRole
         WHERE idUser  = @idUser
           AND id_role = @roleId;

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








-----------------------------------------------------------
-- Autor: Daniel Sequeira
-- Fecha: 06/14/2025
-- Descripcion: Verifica si un usuario tiene asignado un rol específico
-- Parámetros:
--   @idUser     INT               Identificador del usuario
--   @roleName   NVARCHAR(100)     Nombre del rol a comprobar
--   @HasRole    BIT OUTPUT        1 = tiene el rol, 0 = no lo tiene
-----------------------------------------------------------
CREATE OR ALTER PROCEDURE [dbo].[vpvSP_UserHasRole]
    @idUser   INT,
    @roleName NVARCHAR(100),
    @HasRole  BIT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE
        @existsUser   BIT,
        @roleId       INT;

    --------------------------------------------
    -- 1. Validaciones básicas (no requieren transacción)
    --------------------------------------------
    -- Verificar que el usuario exista y esté activo
    SELECT @existsUser = CASE WHEN COUNT(1) > 0 THEN 1 ELSE 0 END
      FROM dbo.vpv_Users
     WHERE idUser  = @idUser
       AND [enable] = 1
       AND [deleted] = 0;

    IF @existsUser = 0
    BEGIN
        SET @HasRole = 0;
        RETURN;
    END

    -- Obtener ID del rol por nombre
    SELECT @roleId = id_role
      FROM dbo.vpv_Roles
     WHERE [name]   = @roleName
       AND enabled  = 1
       AND deleted  = 0;

    IF @roleId IS NULL
    BEGIN
        SET @HasRole = 0;
        RETURN;
    END

    --------------------------------------------
    -- 2. Verificación de asignación de rol
    --------------------------------------------
    IF EXISTS (
        SELECT 1
          FROM dbo.vpv_UserRole ur
         WHERE ur.idUser   = @idUser
           AND ur.id_role  = @roleId
           AND ur.enabled  = 1
           AND ur.deleted  = 0
    )
    BEGIN
        SET @HasRole = 1;
    END
    ELSE
    BEGIN
        SET @HasRole = 0;
    END
END;
GO






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






EXEC dbo.vpvSP_BatchAgregarPermisoRol
    @roleName     = 'Ciudadano',
    @actionName   = 'SELECT',
    @resourceList = 'vpv_balances,vpv_currencies,vpv_exchangeRates,vpv_founds,vpv_investmentPayment,
    vpv_investorsPerProject,vpv_investorsReturns,vpv_paymentMethods,vpv_payments,vpv_planBalance,
    vpv_transactionPerPlan,vpv_transactionPerUser,vpv_transactions,vpv_userBalance';

EXEC dbo.vpvSP_BatchAgregarPermisoRol
    @roleName     = 'Ciudadano',
    @actionName   = 'INSERT',
    @resourceList = 'vpv_balances,vpv_currencies,vpv_exchangeRates,vpv_founds,vpv_investmentPayment,
    vpv_investorsPerProject,vpv_investorsReturns,vpv_paymentMethods,vpv_payments,vpv_planBalance,
    vpv_transactionPerPlan,vpv_transactionPerUser,vpv_transactions,vpv_userBalance';

EXEC dbo.vpvSP_BatchAgregarPermisoRol
    @roleName     = 'Ciudadano',
    @actionName   = 'UPDATE',
    @resourceList = 'vpv_balances,vpv_founds,vpv_paymentMethods,vpv_userBalance';



EXEC dbo.vpvSP_BatchAgregarPermisoRol
    @roleName     = 'Ciudadano',
    @actionName   = 'SELECT',
    @resourceList = 'vpv_AllowedVoters,vpv_EndOfVoting,vpv_OptionsQuestion,vpv_PlansVotes,
    vpv_statusVoting,vpv_TargetPopulations,vpv_TargetPopulationsVoting,vpv_VoteComment,
    vpv_Voter,vpv_VoterDemographics,vpv_VoterResidence,vpv_Votes,vpv_VotesTaken,vpv_voteValues,
    vpv_votingConfigurations,vpv_votingQuestions,vpv_votingReasons,vpv_votingRestrictions,
    vpv_votingRestrictionTypes,vpv_VotingRules,vpv_VotingRuleSubType,vpv_VotingRuleTypes,vpv_votingTypes';

EXEC dbo.vpvSP_AgregarPermisoRol
     @roleName     = 'Ciudadano',
     @resourceName = 'vpv_votingConfigurations',
     @actionName   = 'SELECT';
EXEC dbo.vpvSP_AgregarPermisoRol
     @roleName     = 'Ciudadano',
     @resourceName = 'vpv_statusVoting',
     @actionName   = 'SELECT';
EXEC dbo.vpvSP_AgregarPermisoRol
     @roleName     = 'Ciudadano',
     @resourceName = 'vpv_Voter',
     @actionName   = 'SELECT';
EXEC dbo.vpvSP_AgregarPermisoRol
     @roleName     = 'Ciudadano',
     @resourceName = 'vpv_votingRestrictionTypes',
     @actionName   = 'SELECT';
EXEC dbo.vpvSP_AgregarPermisoRol
     @roleName     = 'Ciudadano',
     @resourceName = 'vpv_PopulationFilters',
     @actionName   = 'SELECT';
EXEC dbo.vpvSP_AgregarPermisoRol
     @roleName     = 'Ciudadano',
     @resourceName = 'vpv_FilterTypes',
     @actionName   = 'SELECT';
EXEC dbo.vpvSP_AgregarPermisoRol
     @roleName     = 'Ciudadano',
     @resourceName = 'vpv_FilterTypes',
     @actionName   = 'SELECT';







EXEC dbo.vpvSP_BatchAgregarPermisoRol
    @roleName     = 'Ciudadano',
    @actionName   = 'INSERT',
    @resourceList = 'vpv_GeneralResultsPerQuestion,vpv_ResultsPerFilter,vpv_ResultsPerOption,
    vpv_VoteComment,vpv_Voter,vpv_VoterDemographics,vpv_VoterResidence,vpv_Votes,vpv_VotesTaken,
    vpv_voteValues,vpv_VotingResultsSummary';

EXEC dbo.vpvSP_AgregarPermisoRol
     @roleName     = 'Ciudadano',
     @resourceName = 'vpv_VoteComment',
     @actionName   = 'INSERT';
EXEC dbo.vpvSP_AgregarPermisoRol
     @roleName     = 'Ciudadano',
     @resourceName = 'vpv_voteValues',
     @actionName   = 'INSERT';

EXEC dbo.vpvSP_BatchAgregarPermisoRol
    @roleName     = 'Ciudadano',
    @actionName   = 'UPDATE',
    @resourceList = 'vpv_GeneralResultsPerQuestion,vpv_ResultsPerFilter,vpv_ResultsPerOption,
    vpv_VoteComment,vpv_Voter,vpv_VoterDemographics,vpv_VoterResidence,vpv_Votes,vpv_VotesTaken,
    vpv_voteValues,vpv_VotingResultsSummary';

EXEC dbo.vpvSP_AgregarPermisoRol
     @roleName     = 'Ciudadano',
     @resourceName = 'vpv_VoteComment',
     @actionName   = 'UPDATE';
EXEC dbo.vpvSP_AgregarPermisoRol
     @roleName     = 'Ciudadano',
     @resourceName = 'vpv_voteValues',
     @actionName   = 'UPDATE';     

EXEC dbo.vpvSP_BatchAgregarPermisoRol
    @roleName     = 'Ciudadano',
    @actionName   = 'UPDATE',
    @resourceList = 'vpv_authmethods,vpv_availablePaymentMethods,vpv_availablePaymentMethodsPerUser,
    vpv_biometricauths,vpv_biorequests,vpv_bioresponses,vpv_biostatus,vpv_biotypes,vpv_devices,
    vpv_devicetypes,vpv_docs,vpv_docincidents,vpv_docinfos,vpv_docstates,vpv_docstypes,vpv_identitydocs,
    vpv_identitystates,vpv_identitytype,vpv_languages,vpv_mfa,vpv_mfachallenges,vpv_mfamethods,
    vpv_mfaselect,vpv_mfasettings,vpv_nationality,vpv_notificationMethods,vpv_requests,vpv_requeststates,
    vpv_RequestStatus,vpv_requestvalidators,vpv_useroptions,vpv_userperrole,vpv_userResidence,
    vpv_UserRole,vpv_Users,vpv_validations,vpv_validationstatus,vpv_ips,vpv_keyowners,vpv_SearchingTags';

EXEC dbo.vpvSP_AgregarPermisoRol
     @roleName     = 'Ciudadano',
     @resourceName = 'vpv_biometricauths',
     @actionName   = 'UPDATE'; 
EXEC dbo.vpvSP_AgregarPermisoRol
     @roleName     = 'Ciudadano',
     @resourceName = 'vpv_devicetypes',
     @actionName   = 'UPDATE'; 
EXEC dbo.vpvSP_AgregarPermisoRol
     @roleName     = 'Ciudadano',
     @resourceName = 'vpv_identitystates',
     @actionName   = 'UPDATE'; 
EXEC dbo.vpvSP_AgregarPermisoRol
     @roleName     = 'Ciudadano',
     @resourceName = 'vpv_mfaselect',
     @actionName   = 'UPDATE'; 
EXEC dbo.vpvSP_AgregarPermisoRol
     @roleName     = 'Ciudadano',
     @resourceName = 'vpv_RequestStatus',
     @actionName   = 'UPDATE'; 
EXEC dbo.vpvSP_AgregarPermisoRol
     @roleName     = 'Ciudadano',
     @resourceName = 'vpv_UserRole',
     @actionName   = 'UPDATE'; 


EXEC dbo.vpvSP_BatchAgregarPermisoRol
    @roleName     = 'Ciudadano',
    @actionName   = 'INSERT',
    @resourceList = 'vpv_logs,vpv_logSeverity,vpv_logsSources,vpv_logTypes';
EXEC dbo.vpvSP_AgregarPermisoRol
     @roleName     = 'Ciudadano',
     @resourceName = 'vpv_encryptionkeys',
     @actionName   = 'SELECT';
EXEC dbo.vpvSP_AgregarPermisoRol
     @roleName     = 'Ciudadano',
     @resourceName = 'vpv_demographics',
     @actionName   = 'SELECT';
EXEC dbo.vpvSP_AgregarPermisoRol
     @roleName     = 'Ciudadano',
     @resourceName = 'vpv_BlindTokens',
     @actionName   = 'INSERT';
EXEC dbo.vpvSP_AgregarPermisoRol
     @roleName     = 'Ciudadano',
     @resourceName = 'vpv_BlindTokens',
     @actionName   = 'UPDATE';





EXEC dbo.vpvSP_BatchAgregarPermisoRol
    @roleName     = 'Proponente',
    @actionName   = 'SELECT',
    @resourceList = 'vpv_crowdfoundingProposals,vpv_FilesPerProposal,vpv_proposalBalance,vpv_proposalComments,
    vpv_proposalNormalViews,vpv_proposalRequirements,vpv_proposals,vpv_proposalTypes,vpv_proposalVersions,
    vpv_proposalViews,vpv_proposalViewTypes,vpv_projectReports,vpv_AllowedVoters,vpv_EndOfVoting,vpv_GeneralResultsPerQuestion,
    vpv_OptionsQuestion,vpv_PlansVotes,vpv_ResultsPerFilter,vpv_ResultsPerOption,vpv_ResultTypes,vpv_statusVoting,
    vpv_TargetPopulations,vpv_TargetPopulationsVoting,vpv_VoteComment,vpv_votingConfigurations,vpv_votingQuestions,
    vpv_votingReasons,vpv_votingRestrictions,vpv_votingRestrictionTypes,vpv_VotingResultsSummary,vpv_VotingResultStatus,
    vpv_VotingRules,vpv_VotingRuleSubType,vpv_VotingRuleTypes,vpv_votingTypes';

EXEC dbo.vpvSP_AgregarPermisoRol
     @roleName     = 'Proponente',
     @resourceName = 'vpv_proposalNormalViews',
     @actionName   = 'SELECT';
EXEC dbo.vpvSP_AgregarPermisoRol
     @roleName     = 'Proponente',
     @resourceName = 'vpv_proposalViews',
     @actionName   = 'SELECT';
EXEC dbo.vpvSP_AgregarPermisoRol
     @roleName     = 'Proponente',
     @resourceName = 'vpv_OptionsQuestion',
     @actionName   = 'SELECT';
EXEC dbo.vpvSP_AgregarPermisoRol
     @roleName     = 'Proponente',
     @resourceName = 'vpv_TargetPopulations',
     @actionName   = 'SELECT';
EXEC dbo.vpvSP_AgregarPermisoRol
     @roleName     = 'Proponente',
     @resourceName = 'vpv_votingReasons',
     @actionName   = 'SELECT';
EXEC dbo.vpvSP_AgregarPermisoRol
     @roleName     = 'Proponente',
     @resourceName = 'vpv_VotingRules',
     @actionName   = 'SELECT';


EXEC dbo.vpvSP_BatchAgregarPermisoRol
    @roleName     = 'Proponente',
    @actionName   = 'INSERT',
    @resourceList = 'vpv_crowdfoundingProposals,vpv_FilesPerProposal,vpv_proposalBalance,vpv_proposalComments,
    vpv_proposalNormalViews,vpv_proposalRequirements,vpv_proposals,vpv_proposalTypes,vpv_proposalVersions,
    vpv_proposalViews,vpv_proposalViewTypes,vpv_projectReports,vpv_AllowedVoters,vpv_EndOfVoting,vpv_GeneralResultsPerQuestion,
    vpv_OptionsQuestion,vpv_PlansVotes,vpv_ResultsPerFilter,vpv_ResultsPerOption,vpv_ResultTypes,vpv_statusVoting,
    vpv_TargetPopulations,vpv_TargetPopulationsVoting,vpv_VoteComment,vpv_votingConfigurations,vpv_votingQuestions,
    vpv_votingReasons,vpv_votingRestrictions,vpv_votingRestrictionTypes,vpv_VotingResultsSummary,vpv_VotingResultStatus,
    vpv_VotingRules,vpv_VotingRuleSubType,vpv_VotingRuleTypes,vpv_votingTypes';

EXEC dbo.vpvSP_AgregarPermisoRol
     @roleName     = 'Proponente',
     @resourceName = 'vpv_proposalNormalViews',
     @actionName   = 'INSERT';
EXEC dbo.vpvSP_AgregarPermisoRol
     @roleName     = 'Proponente',
     @resourceName = 'vpv_proposalViews',
     @actionName   = 'INSERT';
EXEC dbo.vpvSP_AgregarPermisoRol
     @roleName     = 'Proponente',
     @resourceName = 'vpv_OptionsQuestion',
     @actionName   = 'INSERT';
EXEC dbo.vpvSP_AgregarPermisoRol
     @roleName     = 'Proponente',
     @resourceName = 'vpv_TargetPopulations',
     @actionName   = 'INSERT';
EXEC dbo.vpvSP_AgregarPermisoRol
     @roleName     = 'Proponente',
     @resourceName = 'vpv_votingReasons',
     @actionName   = 'INSERT';
EXEC dbo.vpvSP_AgregarPermisoRol
     @roleName     = 'Proponente',
     @resourceName = 'vpv_VotingRules',
     @actionName   = 'INSERT';

EXEC dbo.vpvSP_BatchAgregarPermisoRol
    @roleName     = 'Proponente',
    @actionName   = 'UPDATE',
    @resourceList = 'vpv_crowdfoundingProposals,vpv_FilesPerProposal,vpv_proposalBalance,vpv_proposalComments,
    vpv_proposalNormalViews,vpv_proposalRequirements,vpv_proposals,vpv_proposalTypes,vpv_proposalVersions,
    vpv_proposalViews,vpv_proposalViewTypes,vpv_projectReports,vpv_AllowedVoters,vpv_EndOfVoting,vpv_GeneralResultsPerQuestion,
    vpv_OptionsQuestion,vpv_PlansVotes,vpv_ResultsPerFilter,vpv_ResultsPerOption,vpv_ResultTypes,vpv_statusVoting,
    vpv_TargetPopulations,vpv_TargetPopulationsVoting,vpv_VoteComment,vpv_votingConfigurations,vpv_votingQuestions,
    vpv_votingReasons,vpv_votingRestrictions,vpv_votingRestrictionTypes,vpv_VotingResultsSummary,vpv_VotingResultStatus,
    vpv_VotingRules,vpv_VotingRuleSubType,vpv_VotingRuleTypes,vpv_votingTypes';

EXEC dbo.vpvSP_AgregarPermisoRol
     @roleName     = 'Proponente',
     @resourceName = 'vpv_proposalNormalViews',
     @actionName   = 'UPDATE';
EXEC dbo.vpvSP_AgregarPermisoRol
     @roleName     = 'Proponente',
     @resourceName = 'vpv_proposalViews',
     @actionName   = 'UPDATE';
EXEC dbo.vpvSP_AgregarPermisoRol
     @roleName     = 'Proponente',
     @resourceName = 'vpv_OptionsQuestion',
     @actionName   = 'UPDATE';
EXEC dbo.vpvSP_AgregarPermisoRol
     @roleName     = 'Proponente',
     @resourceName = 'vpv_TargetPopulations',
     @actionName   = 'UPDATE';
EXEC dbo.vpvSP_AgregarPermisoRol
     @roleName     = 'Proponente',
     @resourceName = 'vpv_votingReasons',
     @actionName   = 'UPDATE';
EXEC dbo.vpvSP_AgregarPermisoRol
     @roleName     = 'Proponente',
     @resourceName = 'vpv_VotingRules',
     @actionName   = 'UPDATE';
EXEC dbo.vpvSP_AgregarPermisoRol
     @roleName     = 'Proponente',
     @resourceName = 'vpv_schedules',
     @actionName   = 'SELECT';
EXEC dbo.vpvSP_AgregarPermisoRol
     @roleName     = 'Proponente',
     @resourceName = 'vpv_processStatus',
     @actionName   = 'SELECT';
EXEC dbo.vpvSP_AgregarPermisoRol
     @roleName     = 'Proponente',
     @resourceName = 'vpv_reminderTypes',
     @actionName   = 'SELECT';
EXEC dbo.vpvSP_AgregarPermisoRol
    @roleName     = 'Proponente',
    @resourceName = 'vpv_ClosureTypes',
    @actionName   = 'SELECT';
EXEC dbo.vpvSP_AgregarPermisoRol
    @roleName     = 'Proponente',
    @resourceName = 'vpv_executionPlans',
    @actionName   = 'SELECT';
EXEC dbo.vpvSP_AgregarPermisoRol
    @roleName     = 'Proponente',
    @resourceName = 'vpv_MetricPerPlan',
    @actionName   = 'SELECT';
EXEC dbo.vpvSP_AgregarPermisoRol
    @roleName     = 'Proponente',
    @resourceName = 'vpv_identitytype',
    @actionName   = 'SELECT';
EXEC dbo.vpvSP_AgregarPermisoRol
    @roleName     = 'Proponente',
    @resourceName = 'vpv_identitystates',
    @actionName   = 'SELECT';
EXEC dbo.vpvSP_AgregarPermisoRol
    @roleName     = 'Proponente',
    @resourceName = 'vpv_formats',
    @actionName   = 'SELECT';
EXEC dbo.vpvSP_AgregarPermisoRol
    @roleName     = 'Proponente',
    @resourceName = 'vpv_docstypes',
    @actionName   = 'SELECT';
EXEC dbo.vpvSP_AgregarPermisoRol
    @roleName     = 'Proponente',
    @resourceName = 'vpv_docstates',
    @actionName   = 'SELECT';

EXEC dbo.vpvSP_AgregarPermisoRol
    @roleName     = 'Proponente',
    @resourceName = 'vpv_identitydocs',
    @actionName   = 'INSERT';
EXEC dbo.vpvSP_AgregarPermisoRol
    @roleName     = 'Proponente',
    @resourceName = 'vpv_docs',
    @actionName   = 'INSERT';
