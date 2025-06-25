-----------------------------------------------------------
-- Autor: Carol Araya Conejo
-- Fecha: 04/06/2025
-- Descripcion: Proceso de inversion sobre una propuesta abierta y aprobada
-- propuesta: Nombre de la propuesta a invertir
-- idcard: id card unico que identifique al usuario que realiza la inversion
-- monto: monto a invertir
-- transactionrefNumber : numero de referencia de la transaccion
-- finalDate: Fecha de finalizacion de la propuesta
-- currency: moneda en la que se realiza la inversion

-----------------------------------------------------------
CREATE OR ALTER PROCEDURE [dbo].[vpvSP_InvertirProyecto]
	@propuesta VARCHAR(255),
	@idCard VARCHAR(255),
	@agreementType VARCHAR(255),
	@monto DECIMAL(20,5),
	@transactionrefNumber VARCHAR(150),
	@finalDate DATETIME,
	@paymentDate DATETIME,
	@currency VARCHAR(150),
	@recurrencia VARCHAR(150),
	@plazosPago INT
AS 
BEGIN
	
	SET NOCOUNT ON
	
	DECLARE @ErrorNumber INT, @ErrorSeverity INT, @ErrorState INT, @CustomError INT
	DECLARE @Message VARCHAR(200)
	DECLARE @InicieTransaccion BIT

	-- declaracion de variables que representan los id encontrados
	DECLARE @idUsuario INT
	DECLARE @idEntidad INT = NULL
	DECLARE @idPropuesta INT
	DECLARE @idSponsorAgreement INT
	DECLARE @transactionId INT
	DECLARE @investmentTypeId INT
	DECLARE @budget DECIMAL(20,5) 
	DECLARE @crowfoundingId INT
	DECLARE @currencyId INT
	DECLARE @agreementId INT
	DECLARE @idSchedule INT
	DECLARE @repetition INT;
	DECLARE @statusId INT;
	DECLARE @idProjectTracking INT; --Plan de revision
	DECLARE @inversionPlan INT;
	DECLARE @docid INT;
	DECLARE @tittle VARCHAR(100);--Representa titulos y descripciones de los planes insertados
	

	--declaracion de variables de calculo de montos y porcentajes
	DECLARE @i INT = 0; --Utilizado para ciclos dentro de la insercion
	DECLARE @porcentajeTotal DECIMAL(3,2) --Porcentaje total invertido
	DECLARE @montoTotal DECIMAL(3,2) --Monto total invertido
	DECLARE @porcentajeInversion DECIMAL(3,2) =0;--Porcentaje asignado a la inversion
	DECLARE @poseePorcentaje BIT -- Indica si el usuario tiene porcentaje de acciones (En caso de ser donacion no tiene)
	DECLARE @share BIT --Indica que si al ser una donacion no posee acciones
	DECLARE @stringConcat NVARCHAR(200);
	DECLARE @checksum VARBINARY(32);
	DECLARE @paymetAmount DECIMAL(18,2);--Permite tener los montos a pagar en relacion a los plazos

	--decalracion de variables utilizadas para la generacion de planes
	DECLARE @currentDate DATETIME;
    DECLARE @nextDate DATETIME;

	-- operaciones de select que permiten obtener los id a partir de las entradas incluyendo sus validaciones------------------------------------

	--Obtencion de status del pago
	SELECT TOP 1 @statusId = statusId
	FROM vpv_processStatus 
	WHERE name = 'Pendiente de revisión'

	-- Validar que el proyecto esté en estado aprobado para inversión
	SELECT TOP 1 @idPropuesta = p.proposalId, @budget = p.budget
	FROM vpv_proposals p
	INNER JOIN vpv_processStatus ps on ps.statusId = p.statusId
	WHERE p.tittle = @propuesta and ps.name = 'Aprobado'
	
	IF @idPropuesta IS NULL
	BEGIN
		RAISERROR(50001, 16, 1);
		RETURN;
	END

	-- Validar que el proyecto sea parte del crowfounding
	SELECT TOP 1 @crowfoundingId = p.proposalId
	FROM vpv_crowdfoundingProposals p
	WHERE p.proposalId = @idPropuesta and p.enable=1

	IF @crowfoundingId IS NULL
	BEGIN
		RAISERROR(50002, 16, 1);
		RETURN;
	END

	-- Validar que el currency en el que se realiza la inversion sea correcto
	SELECT TOP 1 @currencyId = p.currencyId
	FROM vpv_currencies p
	WHERE p.acronym = @currency

	IF @currencyId IS NULL
	BEGIN
		RAISERROR(50003, 16, 1);
		RETURN;
	END

	--Verificar identidad del usuario y confirmar su registro en el sistema por medio de la desencriptacion de la cedula de usuarios------------------
	OPEN SYMMETRIC KEY llavecedula DECRYPTION BY PASSWORD = 'clavecedula';

	SELECT TOP 1 @idUsuario = idUser 
	FROM vpv_Users 
	WHERE CONVERT(nvarchar(50), DECRYPTBYKEY(id_card)) = @idCard AND enable = 1;

	CLOSE SYMMETRIC KEY llavecedula;

	IF @idUsuario IS NULL
	BEGIN
		RAISERROR(50004, 16, 1);
		RETURN;
	END

	--Validacion de permisos con ello se busca si el usuario tiene el rol con el permiso asignado
	DECLARE @hasRole BIT;

	EXEC dbo.vpvSP_UserHasRole
		@idUser = @idUsuario,
		@roleName = N'Ciudadano',
		@HasRole = @hasRole OUTPUT;
	--Si retorna 0, en valido como null por lo tanto no hay permisos de inversion
	IF @hasRole IS NULL
	BEGIN
		RAISERROR(50004, 16, 1);
		RETURN;
	END


	-- Identificacion del tipo de agreement del usuario con la propuesta---------------------------------------------------------
	SELECT TOP 1 @investmentTypeId = sponsorAgreementTypeId
	FROM vpv_sponsorAgrementsType 
	WHERE name=@agreementType

	IF @investmentTypeId IS NULL
	BEGIN
		RAISERROR(50005, 16, 1);
		RETURN;
	END
	
	-- Revision del tipo de acuerdo al ser de donacion este no recibe porcentaje de acciones solo aporta al budget
	IF @agreementType = 'Crowdfunding de donación'
	BEGIN
		SET @poseePorcentaje = 0;
		SET @share = 0;
	END
	ELSE IF @agreementType = 'Crowdfunding de inversión'
	BEGIN
		SET @poseePorcentaje = 1;
		SET @share = 1;
	END
	ELSE 
	BEGIN
		RAISERROR(50006, 16, 1);
		RETURN; -- Va a detener el flujo del SP
	END


	--Comienzo de validacion de la transaccion a validar
	--Valida si el numero de referencia es real y coincide con el usuario asi como el monto y estado de la transaccion
	SELECT TOP 1 @transactionId = t.transactionId
	FROM vpv_transactions t
	INNER JOIN vpv_transSubTypes st on st.transactionSubTypeId = t.transactionSubTypeId
	WHERE t.refNumber = @transactionrefNumber and t.idUser= @idUsuario and t.amount = @monto
		and (st.name = 'Inversión de Usuario' OR st.name = 'Inversión de Entidad' OR st.name = 'Inversión de Sponsor' 
		OR st.name = 'Inversion a un plan')

	IF @transactionId IS NULL
	BEGIN
		RAISERROR(50007, 16, 1);
		RETURN;
	END

	--Calculo de checksum de agreement
	SET @stringConcat = CONCAT( @propuesta, '|',@monto, '|',@agreementType, '|', @crowfoundingId, '|', @currencyId);

	-- Genera el has del checksum en agreement
	SET @checksum = HASHBYTES('SHA2_256', CONVERT(VARBINARY(MAX), @stringConcat));

	SET @InicieTransaccion = 0
	IF @@TRANCOUNT=0 BEGIN
		SET @InicieTransaccion = 1
		SET TRANSACTION ISOLATION LEVEL READ COMMITTED
		BEGIN TRANSACTION		
	END
	
	BEGIN TRY
		SET @CustomError = 2001
		
		--Valido el monto en relacion al porcentaje de inversiones insertadas, a tiempo real por lo que se leen datos que han llegado a commit
		--obtengo el monto total de inversion y porcentaje para validar que no haya overflow
		SELECT @montoTotal= COALESCE(SUM(sp.inversion),0), @porcentajeTotal = COALESCE(SUM(sp.percentage),0)
		FROM vpv_investorsPerProject p
		INNER JOIN vpv_sponsorAgreements sp on sp.sponsorAgreementId = p.sponsorAgreementId
		where p.enable = 1 AND sp.enable = 1 AND p.crowdfoundingProposalId=2;
		PRINT 'dddd ' + CAST(@budget AS VARCHAR);
		PRINT 'dddd ' + CAST(@porcentajeTotal AS VARCHAR);
		PRINT 'dddd ' + CAST(@monto AS VARCHAR);

		--Valido si en relacion al budget no se genera overflow
		IF @monto <= (@budget - @montoTotal)
		BEGIN
			

			IF @poseePorcentaje = 1
			BEGIN
				IF @porcentajeTotal < 100
				BEGIN
					SET @porcentajeInversion = @monto * 100.00 / @budget; 
					-- Calculo el porcentaje en relación al monto invertido y el budget
				END
				ELSE
				BEGIN
					SET @porcentajeInversion = 0;
				END
			END
		END
		ELSE
		BEGIN
			RAISERROR(50008, 16, 1);
			RETURN;
		END

		--INICIO DE INSERCIONES --------------------------------------------------------------------------
		
		--INSERCION DEL SCHEDULE A UTILIZAR
		INSERT INTO dbo.vpv_schedules (name, recurrencyType, repetition, endType, endDate)
		VALUES (@recurrencia, @recurrencia, @repetition, @finalDate, @paymentDate);

		SET @idSchedule = SCOPE_IDENTITY();
		

		--INSERCION DE EL AGREEMENT COMO REGISTRO DE INVERSION
		INSERT INTO [dbo].[vpv_sponsorAgreements]
           ([enable],[checksum],[startDate] ,[finalDate] ,[signedDate],[deleted]
		   ,[currencyId],[percentage] ,[amount] ,[shares],[sponsorAgreementTypeId]
           ,[crowdfoundingProposalId],[name],[noReward],[scheduleId],[inversion])
		VALUES
           (1,@checksum,GETDATE(), @finalDate, GETDATE(),0,@currencyId,@porcentajeInversion,@monto,@share,
		   @investmentTypeId,@crowfoundingId,@propuesta,@share,@idSchedule,@monto);

		SET @agreementId = @@IDENTITY;

		--INSERCION DE lA INVERSION EN RELACION CON LA PROPUESTA
		INSERT INTO [dbo].[vpv_investorsPerProject]
           ([idUser] ,[crowdfoundingProposalId],[enable],[sponsorAgreementId])
		VALUES
			   (@idUsuario,@crowfoundingId,1,@agreementId);

		SET @inversionPlan = @@IDENTITY;
		--INCERSION DEL PAYMENT PLAN
		

		--CALCULA EL MONTO DQUE SERA PAGADO POR PLAZO
		SET @paymetAmount = @monto / @plazosPago;
		DEClARE @paymentSchedule DATETIME = @paymentDate;
		WHILE @i < @plazosPago
		BEGIN
			SET @checksum = HASHBYTES(
				'SHA2_256', 
				CONCAT(
					CONVERT(VARCHAR, @paymentSchedule, 126), '|',CONVERT(VARCHAR, @paymetAmount), '|',CONVERT(VARCHAR, @idSchedule), '|',CONVERT(VARCHAR, @statusId), '|', CONVERT(VARCHAR, @idUsuario)
				)
			);
			-- Calculo la fecha del pago para generarla por medio de tramos mensuales
			SET @paymentSchedule = DATEADD(month, 1 * @i, GETDATE());

			-- Insercion del pago
			INSERT INTO dbo.vpv_paymentPlans 
				(paymentDate, totalAmount, scheduleId, enable, deleted, checksum, statusId, idUser, requiredCapital)
			VALUES
				(@paymentSchedule, @paymetAmount, @idSchedule, 1, 0, @checksum, @statusId, @idUsuario, @budget);

			SET @i = @i + 1;
		END

		--INCIO DEL PLAN DE REVISION
		--INSERCION DEL SCHEDULE GENERAL
		INSERT INTO vpv_schedules (name,recurrencyType,repetition,endType,endDate)
		VALUES (@propuesta, @recurrencia, @repetition, 'NA', @finalDate);

		-- Obtiene el ID generado despues de la insercion
		SET @idSchedule = SCOPE_IDENTITY();

		--GENERACION DE LAS FECHAS DE REVISION
		SET @currentDate = @paymentDate;

		WHILE @currentDate <= @finalDate
		BEGIN
			-- Calcula siguiente fecha para el detalle
			IF @recurrencia = 'semanal'
				SET @nextDate = DATEADD(WEEK, 1, @currentDate);
			ELSE IF @recurrencia = 'mensual'
				SET @nextDate = DATEADD(MONTH, 1, @currentDate);
			ELSE
			BEGIN
				RAISERROR(50009, 16, 1);
				RETURN;
			END

			-- Insertar detalle de revisión
			INSERT INTO vpv_scheduleDetails (
				baseDate, datepart, lastExecute, nextExecute, scheduleId)
			VALUES (@paymentDate,@recurrencia,	@currentDate,@nextDate,@idSchedule);

			SET @currentDate = @nextDate;
		END
		SET @tittle = CONCAT('User:', '_Proposal:', @idPropuesta, '_Investment:', @inversionPlan);

		--Inserto el registro que permite tener un tracking al proyecto el plan se realiza por medio los detalles planificados
		INSERT INTO vpv_ProposalTracking
			(userId,proposalId,creationDate,enable,deleted,statusId,docid,tittle,scheduleId,description)
		VALUES(@idUsuario,@idPropuesta,GETDATE(),1,0,@statusId,1,@tittle,@idSchedule,'Plan de revison de la propuesta' + @tittle);


		--FIN DE INSERCIONES -----------------------------------------------------------------------------
					
		IF @InicieTransaccion=1 BEGIN
			COMMIT
		END
	END TRY
	BEGIN CATCH
		SET @ErrorNumber = ERROR_NUMBER()
		SET @ErrorSeverity = ERROR_SEVERITY()
		SET @ErrorState = ERROR_STATE()
		SET @Message = ERROR_MESSAGE()
		
		IF @InicieTransaccion=1 BEGIN
			ROLLBACK
		END
		RAISERROR('%s - Error Number: %i', 
			@ErrorSeverity, @ErrorState, @Message, @CustomError)
	END CATCH	
END
RETURN 0
GO