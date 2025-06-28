


--######################### SP 1 ##########################
-----------------------------------------------------------
-- Autor: Priscilla Romero Barquero
-- Fecha: 06/10/2025
-- Descripcion: Registra todo el flujo de entrada/salida de dinero para el usuario y propuesta 
--				en especifico (transacciones y balances)
-- @userId: Usuario al cual recibirá una transacción por dividendos (genera transacción y modifica balance)
-- @crowdfoundingProposalId:  Propuesta de la cual salen los montos de los dividendos (genera transacción y modifica balance)
-- @amount:  Monto total del dividendo
-----------------------------------------------------------
CREATE OR ALTER PROCEDURE[dbo].[vpvSP_RealizarTransacciones]
	--Parametros externos
	@userId int,
	@crowdfoundingProposalId int,
	@amount decimal (10,2),
	@currency varchar(30)
AS 
BEGIN
	
	SET NOCOUNT ON

	DECLARE @ErrorNumber INT, @ErrorSeverity INT, @ErrorState INT, @CustomError INT
	DECLARE @Message VARCHAR(200)
	DECLARE @InicieTransaccion BIT

	-- declaracion de otras variables locales para hacer los insert
	DECLARE @date datetime = getdate();
	DECLARE @checksum varbinary(256);
	DECLARE @subtype int, @transType int;
	DECLARE @exchage int;
	DECLARE @balanceProp BIGINT, @balanceUser BIGINT, @found int;
	DECLARE @transactionProp BIGINT, @transactionUser BIGINT;
	DECLARE @lastbalance decimal (10,2);
	DECLARE @random int = FLOOR(RAND() * 5000) + 1;

	--Asigno valores a ciertas variables 
	SELECT @subtype = transactionSubTypeId FROM vpv_transSubTypes WHERE name = 'Pago de propuesta';
	SELECT @transType = transTypeId FROM vpv_transTypes WHERE name = 'Transfer'; -- Indica el transactionType si se hace de parte de la propuesta sería una transferencia, en este caso de dividendos
	SELECT @currency = currencyId FROM vpv_currencies WHERE acronym = @currency;	
	SELECT @exchage =  echangeRateId FROM vpv_exchangeRates WHERE currencyId = @currency AND currentExchange = '1';
	SELECT @found = foundId FROM vpv_founds WHERE name = 'Dinero';
	

	SET @checkSum = HASHBYTES('SHA2_256', 
       CONCAT(
           CAST(@userId AS VARCHAR),
           CAST(@crowdfoundingProposalId AS VARCHAR),
           CAST(@amount AS VARCHAR),
           CAST(@subtype AS VARCHAR),
           CAST(@transType AS VARCHAR),
           CAST(@currency AS VARCHAR),
           CAST(@exchage AS VARCHAR),
		   CAST(@random AS VARCHAR),
		   CAST(@random AS VARCHAR),
           CONVERT(VARCHAR, GETDATE(), 121)));

	
	SET @InicieTransaccion = 0
	IF @@TRANCOUNT = 0 BEGIN
		SET @InicieTransaccion = 1
		SET TRANSACTION ISOLATION LEVEL READ COMMITTED
		BEGIN TRANSACTION		
	END
	
	BEGIN TRY
		SET @CustomError = 2001

		--Se crea un balance negativo en el balance de la propuesta, simulando una salida de dinero
		INSERT INTO [dbo].[vpv_balances]
           ([balance],[lastbalance],[lastUpdate],[checksum],[foundId],[freezeAmount])
		VALUES
           (-@amount, @amount, @date, @checksum,@found, NULL);
		SET @balanceProp = SCOPE_IDENTITY();	--Asignamos el ultimo id generado en el balance 

		-- Se insertan las relaciones del balance y la propuesta
		INSERT INTO [dbo].[vpv_proposalBalance]
           ([BalanceId],[crowdfoundingProposalId],[executionDate],[checksum])
		VALUES
           (@balanceProp,@crowdfoundingProposalId, @date, @checksum);

		--Se realiza la transacción en sí, igaul simulando dinero de salida
		INSERT INTO [dbo].[vpv_transactions]
           ([amount],[description],[date],[postTime],[refNumber],[checksum],[convertedAmount],[paymentId],[transactionSubTypeId],
           [transTypeId],[currencyId],[exchangeRateId],[balanceId],[idUser])
		VALUES
           (-@amount, CONCAT('Pago de dividendos al usuario', @userId),@date, @date, CONCAT('VPV-',@random),
				@checksum, @amount, NULL, @subtype, @transType, @currency, @exchage, @balanceProp, NULL);
		SET @transactionProp = SCOPE_IDENTITY();
		
		-- Se insertan las relaciones de la transaccion y la propuesta
		INSERT INTO [dbo].[vpv_transactionPerPlan]
			([crowdfoundingProposalId],[executionPlanId],[transactionId],[executionDate],[checksum])
		VALUES
			(@crowdfoundingProposalId, NULL, @transactionProp, @date, @checksum);

		--Se inserta la simulación de ingreso de dinero hacia el usuario
		INSERT INTO [dbo].[vpv_balances]
           ([balance],[lastbalance],[lastUpdate],[checksum],[foundId],[freezeAmount])
		VALUES
           (@amount, @amount, @date, @checksum,@found, NULL);
		SET @balanceUser = SCOPE_IDENTITY();	--Asignamos el ultimo id generado en el balance

		--Se relaciona el balance con el user al que le pertenece 
		INSERT INTO [dbo].[vpv_userBalance]
           ([idUser],[balanceId],[checksum],[executionDate])
		VALUES
           (@userId,@balanceUser, @checksum,@date);

		--Generamos la transaccion de ingreso de al usuario +
		INSERT INTO [dbo].[vpv_transactions]
           ([amount],[description],[date],[postTime],[refNumber],[checksum],[convertedAmount],[paymentId],[transactionSubTypeId],
           [transTypeId],[currencyId],[exchangeRateId],[balanceId],[idUser])
		VALUES
           (@amount, CONCAT('Ingreso por dividendos de la prop', @crowdfoundingProposalId),@date, @date, 
		   CONCAT('VPV-',@random),@checksum, @amount, NULL, @subtype, @transType, @currency,
		   @exchage, @balanceUser, NULL);
		SET @transactionUser = SCOPE_IDENTITY();

		--Asociamos transaccion con el user
		INSERT INTO [dbo].[vpv_transactionPerUser]
           ([idUser],[sponsorGroupId],[entitydid],[transactionId],[executionDate],[checksum])
		VALUES
           (@userId, NULL,NULL, @transactionUser,@date,@checksum);


		--Guardamos en logs el ciclo de dividendos
		INSERT INTO [dbo].[vpv_logs]
           ([description],[computer],[username],[trace],[referenceId1],[referenceId2],[value1],[value2]
           ,[chechsum],[logSeverityId],[logSourceId],[logTypeId])
		VALUES(
		   CONCAT('Pago de dividendos de la propuesta ', @crowdfoundingProposalId,' al usuario ', @userId, ' Por un monto de ',
		   @amount,' Realizado el ', @date, ' por la transacción numero ', @transactionUser), CONCAT('Computer ', @random),
		   CONCAT('User', @userId), 'T1', CONCAT('Propuesta ', @crowdfoundingProposalId), CONCAT('User ',@userId),
		   CONCAT('Monto ', @amount),CONCAT('fecha ', @date), @checksum,
		   (SELECT logSeverityId FROM vpv_logSeverity WHERE name = 'High'),
           (SELECT logSourceId FROM vpv_logsSources WHERE name = 'Payment Gateway'),
           (SELECT logTypeId FROM vpv_logTypes WHERE name = 'Transaction'));

					
		IF @InicieTransaccion=1 BEGIN
			COMMIT
		END
	END TRY
	BEGIN CATCH
		-- en esencia, lo que hay  que hacer es registrar el error real, y enviar para arriba un error custom 
		SET @ErrorNumber = ERROR_NUMBER()
		SET @ErrorSeverity = ERROR_SEVERITY()
		SET @ErrorState = ERROR_STATE()
		SET @Message = ERROR_MESSAGE()
		
		IF @InicieTransaccion=1 BEGIN
			ROLLBACK
		END
		-- Se retorna el error a la capa superior
		RAISERROR('%s - Error Number: %i', 
			@ErrorSeverity, @ErrorState, @Message, @CustomError) -- hay que sustituir el @message por un error personalizado bonito, lo ideal es sacarlo de sys.messages 
		-- en la tabla de sys.messages se pueden insertar mensajes personalizados de error, los cuales se les hace match con el numero en @CustomError
	END CATCH	
END
RETURN 0
GO


--######################### SP 2 ##########################
-----------------------------------------------------------
-- Autor: Priscilla Romero Barquero
-- Fecha: 06/10/2025
-- Descripcion: Verifica los inversionistas de cada propuesta, monto invertido
--				y establece el monto a repartir segun inversion y utilidades disponibles
-- @crowdfoundingProposalId: Identificador de la propuesta para revisar sus inversionistas
-- @dividendos: Monto de utilidades disponibles segun la propuesta específica
-----------------------------------------------------------
CREATE OR ALTER PROCEDURE[dbo].[vpvSP_VerificarAgreements]
	--Parametros externos
	@crowdfoundingProposalId INT,
	@dividendos decimal(10,2),
	@currency varchar(30)

AS 
BEGIN
	
	SET NOCOUNT ON

	DECLARE @ErrorNumber INT, @ErrorSeverity INT, @ErrorState INT, @CustomError INT
	DECLARE @Message VARCHAR(200)
	DECLARE @InicieTransaccion BIT

	--Variables locales para verificaciones
	DECLARE @userId int, @inversion decimal(10,2), @totalInversiones decimal (10,2);
	DECLARE @paymentMethodId INT, @sponsorAgreementId int, @amount decimal(10,2);


	--Verificar que existen inversionistas asociados a la propuestas
	IF NOT EXISTS (SELECT 1 FROM vpv_investorsPerProject WHERE crowdfoundingProposalId = @crowdfoundingProposalId and enable = 1)
    BEGIN
        RAISERROR('No existen inversionistas activos para esta propuesta.', 16, 1);
        RETURN;
    END
		
	-- Hacer la suma del monto total invertido en una propuesta para poder establecer el monto a repartir a los inversionistas
	SELECT @totalInversiones = SUM(sa.inversion)
	FROM vpv_sponsorAgreements sa
	INNER JOIN vpv_investorsPerProject ip ON sa.sponsorAgreementId = ip.sponsorAgreementId
	WHERE ip.crowdfoundingProposalId = @crowdfoundingProposalId
    AND ip.enable = 1 -- Solo los inversionistas habilitados
    AND sa.enable = 1; -- Solo sponsors habilitados

	
	SET @InicieTransaccion = 0
	IF @@TRANCOUNT = 0 BEGIN
		SET @InicieTransaccion = 1
		SET TRANSACTION ISOLATION LEVEL READ COMMITTED
		BEGIN TRANSACTION		
	END
	
	BEGIN TRY
		SET @CustomError = 2001

		DECLARE Invest_Cursor CURSOR FOR
		SELECT idUser, sponsorAgreementId FROM vpv_investorsPerProject
		WHERE crowdfoundingProposalId = @crowdfoundingProposalId and enable = 1;

		-- Abre el cursor y se lleva al primer registro de la consulta anterior
		OPEN Invest_Cursor;
		FETCH NEXT FROM Invest_Cursor INTO @userId, @sponsorAgreementId; 

		WHILE @@FETCH_STATUS = 0	--Mientras que el cursor no llegue al final de los registros
		BEGIN
			--Se obtiene el monto invertido inicialmente
			SELECT @inversion = inversion
			FROM vpv_sponsorAgreements
			WHERE sponsorAgreementId = @sponsorAgreementId;

			--Se verefica que exista un registro en paymentmethod para ese usuario recorrido
			IF EXISTS (SELECT 1 FROM vpv_availablePaymentMethodsPerUser WHERE idUser = @userId AND enable = 1)
			BEGIN
				
				-- Monto a repartir para dividendo
				SET @amount = (@inversion/ @totalInversiones)*@dividendos;	--Monto a repartir

				EXEC [dbo].[vpvSP_RealizarTransacciones] 
                @userId = @userId,
                @crowdfoundingProposalId = @crowdfoundingProposalId,
                @amount = @amount,
				@currency = @currency;
			END

			FETCH NEXT FROM Invest_Cursor INTO @userId, @sponsorAgreementId;	--Continua al siguiente registro 
		
		END

		CLOSE Invest_Cursor;
		DEALLOCATE Invest_Cursor;	
			
		IF @InicieTransaccion=1 BEGIN
			COMMIT
		END
	END TRY
	BEGIN CATCH
		-- en esencia, lo que hay  que hacer es registrar el error real, y enviar para arriba un error custom 
		SET @ErrorNumber = ERROR_NUMBER()
		SET @ErrorSeverity = ERROR_SEVERITY()
		SET @ErrorState = ERROR_STATE()
		SET @Message = ERROR_MESSAGE()
		
		IF @InicieTransaccion=1 BEGIN
			ROLLBACK
		END


		-- Se retorna el error a la capa superior
		RAISERROR('%s - Error Number: %i', 
			@ErrorSeverity, @ErrorState, @Message, @CustomError) -- hay que sustituir el @message por un error personalizado bonito, lo ideal es sacarlo de sys.messages 
		-- en la tabla de sys.messages se pueden insertar mensajes personalizados de error, los cuales se les hace match con el numero en @CustomError
	END CATCH	
END
RETURN 0
GO




--######################### SP 3 ##########################
-----------------------------------------------------------
-- Autor: Priscilla Romero Barquero
-- Fecha: 06/10/2025
-- Descripcion: Verifica que la propuesta está en ejecución, con fiscalizaciones aprobadas 
--				y que existen fondos disponibles para repartir utilidades
-- @Proposalname: Nombre de la propuesta de la cual se quiere repartir los dividendos
-----------------------------------------------------------
CREATE OR ALTER PROCEDURE[dbo].[vpvSP_RepartirDividendos]
	--Parametros externos
	@Proposalname nvarchar(100),
	@idCard VARCHAR(255),
	@currency varchar (30)
AS 
BEGIN
	
	SET NOCOUNT ON

	DECLARE @ErrorNumber INT, @ErrorSeverity INT, @ErrorState INT, @CustomError INT
	DECLARE @Message VARCHAR(200)
	DECLARE @InicieTransaccion BIT

	--Variables locales para verificaciones
	DECLARE @idUsuarioEjecuta INT
	DECLARE @crowdfoundingProposalId int, @proposalId int, @propstatusId int, @repstatusId int;
	DECLARE @dividendos decimal (10,2);

	--Asignar valores a ciertas variables
	SELECT @propstatusId = statusId from vpv_processStatus WHERE name = 'En proceso';
	SELECT @repstatusId = statusId from vpv_processStatus WHERE name = 'Aprobado'

	SELECT @proposalId = proposalId FROM vpv_proposals WHERE tittle = @Proposalname and enable = 1;
    IF @proposalId IS NULL
    BEGIN
        RAISERROR('No se encontró una propuesta habilitada con ese nombre.', 16, 1);
        RETURN;
    END

	--Se asocia la propuesta con la crowdfounding proposal
	SELECT @crowdfoundingProposalId = cp.crowdfoundingProposalId 
	FROM vpv_crowdfoundingProposals cp
	INNER JOIN vpv_proposals p ON p.proposalId = cp.proposalId
	WHERE p.proposalId = @proposalId AND cp.statusId = @propstatusId;

    IF @crowdfoundingProposalId IS NULL
    BEGIN
        RAISERROR('La propuesta no se encuentra en estado "En proceso".', 16, 1);
        RETURN;
    END

	--Asociar dividendos
	SELECT @dividendos = availablePayment FROM vpv_projectReports 
	WHERE crowdfoundingProposalId = @crowdfoundingProposalId and statusId = @repstatusId;

    IF @dividendos IS NULL
    BEGIN
        RAISERROR('No se encontró un reporte aprobado con dividendos disponibles para esta propuesta.', 16, 1);
        RETURN;
    END

	--Verificar identidad del usuario y confirmar su registro en el sistema por medio de la desencriptacion de la cedula de usuarios------------------
	OPEN SYMMETRIC KEY llavecedula DECRYPTION BY PASSWORD = 'clavecedula';

	SELECT TOP 1 @idUsuarioEjecuta = idUser 
	FROM vpv_Users 
	WHERE CONVERT(nvarchar(50), DECRYPTBYKEY(id_card)) = @idCard AND enable = 1;

	CLOSE SYMMETRIC KEY llavecedula;

	IF @idUsuarioEjecuta IS NULL
	BEGIN
		RAISERROR('El usuario no está registrado o no está habilitado.', 16, 1);
		RETURN;
	END

	--Validacion de permisos con ello se busca si el usuario tiene el rol con el permiso asignado
	DECLARE @hasRole BIT;

	EXEC dbo.vpvSP_UserHasRole
		@idUser = @idUsuarioEjecuta,
		@roleName = N'Ciudadano',
		@HasRole = @hasRole OUTPUT;
	--Si retorna 0, en valido como null por lo tanto no hay permisos de inversion
	IF @hasRole IS NULL
	BEGIN
		RAISERROR('El usuario no posee el rol necesario para realizar esta acción.', 16, 1);
		RETURN;
	END


	--Verificar que la propuesta está ejecutandose
	IF NOT EXISTS (SELECT 1 FROM vpv_proposals WHERE proposalId = @proposalId AND statusId = @propstatusId)	
    BEGIN
        RAISERROR('La propuesta no está en estado "En proceso".', 16, 1);
        RETURN;
    END

	--Verificar que las propuesta tenga fiscalizaciones aprobadas
	IF NOT EXISTS (SELECT 1 FROM vpv_ProposalTracking WHERE proposalId = @proposalId AND statusId = @repstatusId)	
    BEGIN
        RAISERROR('La propuesta no tiene fiscalizaciones aprobadas.', 16, 1);
        RETURN;
    END
	
	--Verificar dividendos disponibles
    IF @dividendos <= 0
    BEGIN
        RETURN 7; -- No hay dividendos disponibles
    END
	
	SET @InicieTransaccion = 0
	IF @@TRANCOUNT = 0 BEGIN
		SET @InicieTransaccion = 1
		SET TRANSACTION ISOLATION LEVEL READ COMMITTED
		BEGIN TRANSACTION		
	END
	
	BEGIN TRY
		SET @CustomError = 2001

		IF EXISTS (SELECT 1 FROM vpv_projectReports where crowdfoundingProposalId = @crowdfoundingProposalId
		AND statusId = @repstatusId)
		BEGIN
			EXEC [dbo].[vpvSP_VerificarAgreements]
                @crowdfoundingProposalId = @crowdfoundingProposalId,
				@dividendos = @dividendos,
				@currency = @currency;
		END 	
			
		IF @InicieTransaccion=1 BEGIN
			COMMIT
		END
	END TRY
	BEGIN CATCH
		-- en esencia, lo que hay  que hacer es registrar el error real, y enviar para arriba un error custom 
		SET @ErrorNumber = ERROR_NUMBER()
		SET @ErrorSeverity = ERROR_SEVERITY()
		SET @ErrorState = ERROR_STATE()
		SET @Message = ERROR_MESSAGE()
		
		IF @InicieTransaccion=1 BEGIN
			ROLLBACK
		END


		-- Se retorna el error a la capa superior
		RAISERROR('%s - Error Number: %i', 
			@ErrorSeverity, @ErrorState, @Message, @CustomError) -- hay que sustituir el @message por un error personalizado bonito, lo ideal es sacarlo de sys.messages 
		-- en la tabla de sys.messages se pueden insertar mensajes personalizados de error, los cuales se les hace match con el numero en @CustomError
	END CATCH	
END
RETURN 0
GO

/*
-- Parámetros de prueba
DECLARE @Proposalname nvarchar(100) = 'Plataforma digital de salud pública';  
DECLARE @idCard nvarchar(100) = '258503207';  
DECLARE @currency nvarchar(100) = 'CRC'; 

-- Ejecutar el procedimiento
EXEC [dbo].[vpvSP_RepartirDividendos] 
    @Proposalname = @Proposalname,
	@idCard = @idCard,
	@currency = @currency;
*/

