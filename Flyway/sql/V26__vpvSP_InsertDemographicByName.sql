-----------------------------------------------------------
-- Autor: Daniel Sequeira
-- Fecha: 06/15/2025
-- Descripción:
--   Inserta un registro en vpv_demographics a partir de nombres
--   de demotype y demosubtype, tomando el primer match de cada uno.
-- Parámetros:
--   @demotypeName     VARCHAR(25)  Nombre de demotype (ej. 'Edad')
--   @demosubtypeName  VARCHAR(25)  Nombre de demosubtype (ej. '18-25')
--   @userId           INT          ID del usuario
--   @personName       VARCHAR(50)  Nombre libre para este dato demográfico
-----------------------------------------------------------
CREATE OR ALTER PROCEDURE dbo.vpvSP_InsertDemographicByName
    @demotypeName    VARCHAR(25),
    @demosubtypeName VARCHAR(25),
    @userId          INT,
    @personName      VARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE 
        @demotypeId     INT,
        @demosubtypeId  INT,
        @checksum       NVARCHAR(255);

    -- 1) Obtener demotypeid
    SELECT TOP(1)
        @demotypeId = demotypeid
      FROM dbo.vpv_demotype
     WHERE [name] = @demotypeName;

    IF @demotypeId IS NULL
    BEGIN
        RAISERROR('demotype "%s" no encontrado.', 16, 1, @demotypeName);
        RETURN;
    END

    -- 2) Obtener demosubtypeid
    SELECT TOP(1)
        @demosubtypeId = demosubtypeid
      FROM dbo.vpv_demosubtype
     WHERE [name] = @demosubtypeName;

    IF @demosubtypeId IS NULL
    BEGIN
        RAISERROR('demosubtype "%s" no encontrado.', 16, 1, @demosubtypeName);
        RETURN;
    END

    -- 3) Calcular checksum
    SET @checksum = CONVERT(
        NVARCHAR(255),
        HASHBYTES('SHA2_256',
            CONCAT(
                @demotypeId, '|',
                @demosubtypeId, '|',
                @userId, '|',
                @personName
            )
        ),
        2  -- formato hexadecimal
    );

    -- 4) Insertar
    INSERT INTO dbo.vpv_demographics
    (
        demotypeid,
        demosubtypeid,
        userid,
        [name],
        checksum
    )
    VALUES
    (
        @demotypeId,
        @demosubtypeId,
        @userId,
        @personName,
        @checksum
    );
END
GO

