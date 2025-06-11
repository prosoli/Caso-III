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

-- EXEC dbo.vpvSP_AsignaRolUsuario
--      @idUser       = 1,
--      @roleName     = 'Proponente';