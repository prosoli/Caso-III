--Más seeding para poder visualizar datos en el dashboard especificamete
--sobre el monto invertido por inversions ciudadana y el monto ejecutado hasta el momento

---------------
-- BALANCES
---------------

CREATE OR ALTER PROCEDURE dbo.vpvSP_LlenarBalances
AS
BEGIN
    DECLARE @i INT = 1;
    DECLARE @balance DECIMAL(10,2);
    DECLARE @lastbalance DECIMAL(10,2);
    DECLARE @lastUpdate DATETIME;
    DECLARE @checksum VARBINARY(255);
    DECLARE @foundId INT = 1;

    WHILE @i <= 20
    BEGIN
        SET @balance = ROUND(RAND() * (300000 - 150000) + 150000, 2);  -- entre 150000.00 y 300000-00
        SET @lastbalance = ROUND(@balance - (RAND() * 5000), 2);
        SET @lastUpdate = DATEADD(DAY, -@i, GETDATE());
        SET @checksum = HASHBYTES('SHA2_256', CONVERT(NVARCHAR(36), NEWID()));

        INSERT INTO [dbo].[vpv_balances] (
            [balance],
            [lastbalance],
            [lastUpdate],
            [checksum],
            [foundId],
            [freezeAmount]
        )
        VALUES (
            @balance,
            @lastbalance,
            @lastUpdate,
            @checksum,
            @foundId,
            NULL
        );

        SET @i += 1;
    END
END;
GO

GO
EXEC dbo.vpvSP_LlenarBalances;

SELECT * FROM vpv_balances




-------------------------------------------------------
-- TRANSACCIONES DEL SISTEMA POR INVERSION DE USUARIO
-------------------------------------------------------
GO
CREATE OR ALTER PROCEDURE dbo.vpvSP_LlenarTransaccionesInversionPlan
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @i INT = 1;
    DECLARE @amount DECIMAL(10,2);
    DECLARE @description VARCHAR(100);
    DECLARE @date DATETIME;
    DECLARE @postTime DATETIME;
    DECLARE @refNumber VARCHAR(150);
    DECLARE @checksum VARBINARY(256);
    DECLARE @transactionSubTypeId INT;
    DECLARE @transTypeId INT = 2;
    DECLARE @currencyId INT = 1;
    DECLARE @exchangeRateId INT = 1;
	DECLARE @guid NVARCHAR(36);

    -- Obtener el ID del sub-tipo "Inversión de Usuario"
    SELECT @transactionSubTypeId = transactionSubTypeId
    FROM dbo.vpv_transSubTypes 
    WHERE name = 'Inversión de Usuario';

    WHILE @i <= 20
    BEGIN
        SET @amount = ROUND(RAND() * (300000 - 150000) + 150000, 2);  -- entre 150000.00 y 300000-00
        SET @description = 'Inversión del usuario #' + CAST(@i AS VARCHAR);
        SET @date = DATEADD(DAY, -@i, GETDATE());
        SET @postTime = DATEADD(MINUTE, @i * 10, @date);
        SET @refNumber = 'TX-274868';
        SET @guid = CONVERT(NVARCHAR(36), NEWID());
		SET @checksum = HASHBYTES('SHA2_256', @guid);


        INSERT INTO [dbo].[vpv_transactions] (
            [amount],
            [description],
            [date],
            [postTime],
            [refNumber],
            [checksum],
            [convertedAmount],
            [paymentId],
            [transactionSubTypeId],
            [transTypeId],
            [currencyId],
            [exchangeRateId],
            [balanceId],
            [idUser]
        )
        VALUES (
            @amount,
            @description,
            @date,
            @postTime,
            @refNumber,
            @checksum,
            @amount,
            NULL,
            @transactionSubTypeId,
            @transTypeId,
            @currencyId,
            @exchangeRateId,
            1,
            NULL
        );

        SET @i += 1;
    END
END;
GO

EXEC dbo.vpvSP_LlenarTransaccionesInversionPlan;
GO


-------------------------------------------------------
-- TRANSACCIONES DEL SISTEMA POR INVERSION A UN PLAN
-------------------------------------------------------

GO
CREATE OR ALTER PROCEDURE dbo.vpvSP_LlenarTransaccionesInversionPlan
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @i INT = 1;
    DECLARE @amount DECIMAL(10,2);
    DECLARE @description VARCHAR(100);
    DECLARE @date DATETIME;
    DECLARE @postTime DATETIME;
    DECLARE @refNumber VARCHAR(150);
    DECLARE @checksum VARBINARY(256);
    DECLARE @transactionSubTypeId INT;
    DECLARE @transTypeId INT = 2;
    DECLARE @currencyId INT = 1;
    DECLARE @exchangeRateId INT = 1;
	DECLARE @guid NVARCHAR(36);

    -- Obtener el ID del sub-tipo "Inversión de a un plan"
    SELECT @transactionSubTypeId = transactionSubTypeId
    FROM dbo.vpv_transSubTypes 
    WHERE name = 'Inversion a un plan';

    WHILE @i <= 20
    BEGIN
        SET @amount = ROUND(RAND() * (300000 - 150000) + 150000, 2);  -- entre 150000.00 y 300000-00
        SET @description = 'Inversión del usuario #' + CAST(@i AS VARCHAR);
        SET @date = DATEADD(DAY, -@i, GETDATE());
        SET @postTime = DATEADD(MINUTE, @i * 10, @date);
        SET @refNumber = 'TX-274868';
        SET @guid = CONVERT(NVARCHAR(36), NEWID());
		SET @checksum = HASHBYTES('SHA2_256', @guid);

        INSERT INTO [dbo].[vpv_transactions] (
            [amount],
            [description],
            [date],
            [postTime],
            [refNumber],
            [checksum],
            [convertedAmount],
            [paymentId],
            [transactionSubTypeId],
            [transTypeId],
            [currencyId],
            [exchangeRateId],
            [balanceId],
            [idUser]
        )
        VALUES (
            @amount,
            @description,
            @date,
            @postTime,
            @refNumber,
            @checksum,
            @amount,
			NULL,
            @transactionSubTypeId,
            @transTypeId,
            @currencyId,
            @exchangeRateId,
            1,
            NULL
        );

        SET @i += 1;
    END
END;
GO

GO
EXEC dbo.vpvSP_LlenarTransaccionesInversionPlan;


--Permitir que Crowd Founding prop acepte nulos
ALTER TABLE [dbo].[vpv_transactionPerPlan]
ALTER COLUMN [crowdfoundingProposalId] INT NULL;

--------------------------------------------
--TRANSACCIONES GENERADAS A UNA PROPUESTA
--------------------------------------------
INSERT INTO [dbo].[vpv_transactionPerPlan] (
    [crowdfoundingProposalId],[executionPlanId],[transactionId],[executionDate],[checksum]
)
VALUES --Transacciones 1 al 15 Inversionde Usuario
(1, NULL, 1, GETDATE(), CHECKSUM('Dato de prueba')),
(2, NULL, 2, GETDATE(), CHECKSUM('Dato de prueba')),
(3, NULL, 3, GETDATE(), CHECKSUM('Dato de prueba')),
(1, NULL, 4, GETDATE(), CHECKSUM('Dato de prueba')),
(2, NULL, 5, GETDATE(), CHECKSUM('Dato de prueba')),
(3, NULL, 6, GETDATE(), CHECKSUM('Dato de prueba')),
(1, NULL, 7, GETDATE(), CHECKSUM('Dato de prueba')),
(2, NULL, 8, GETDATE(), CHECKSUM('Dato de prueba')),
(3, NULL, 9, GETDATE(), CHECKSUM('Dato de prueba')),
(1, NULL, 10, GETDATE(), CHECKSUM('Dato de prueba')),
(2, NULL, 11, GETDATE(), CHECKSUM('Dato de prueba')),
(3, NULL, 12, GETDATE(), CHECKSUM('Dato de prueba')),
(1, NULL, 13, GETDATE(), CHECKSUM('Dato de prueba')),
(2, NULL, 14, GETDATE(), CHECKSUM('Dato de prueba')),
(3, NULL, 15, GETDATE(), CHECKSUM('Dato de prueba'));


-------------------------------------
--TRANSACCIONES GENERADAS A UN PLAN
-------------------------------------
INSERT INTO [dbo].[vpv_transactionPerPlan] (
    [crowdfoundingProposalId], [executionPlanId], [transactionId], [executionDate], [checksum]
)
VALUES --Trnasacciones del 20 en adelante Inversion a un plan
(NULL, 1, 20, GETDATE(), CHECKSUM('Dato de prueba')),
(NULL, 2, 21, GETDATE(), CHECKSUM('Dato de prueba')),
(NULL, 3, 22, GETDATE(), CHECKSUM('Dato de prueba')),
(NULL, 4, 23, GETDATE(), CHECKSUM('Dato de prueba')),
(NULL, 5, 24, GETDATE(), CHECKSUM('Dato de prueba')),
(NULL, 6, 25, GETDATE(), CHECKSUM('Dato de prueba')),
(NULL, 1, 26, GETDATE(), CHECKSUM('Dato de prueba')),
(NULL, 2, 27, GETDATE(), CHECKSUM('Dato de prueba')),
(NULL, 3, 28, GETDATE(), CHECKSUM('Dato de prueba')),
(NULL, 4, 29, GETDATE(), CHECKSUM('Dato de prueba'));

