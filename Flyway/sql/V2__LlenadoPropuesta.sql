
-- Tipo de vistas 
INSERT INTO [dbo].[vpv_proposalViewTypes] ([name], [enable])
VALUES
    ('Gráfica de barras', 1),
    ('Gráfica de líneas', 1),
    ('Comparativa anual', 1),
    ('Indicadores KPI', 1),
    ('Resumen ejecutivo', 1),
    ('Mapa de calor', 1),
    ('Tabla dinámica', 1)


--Tipos de propuesta 

INSERT INTO [dbo].[vpv_proposalTypes] ([name], [description], [enable])
VALUES
    ('Proyecto de ley', 'Propuesta para crear, modificar o derogar una ley vigente a través del proceso legislativo.', 1),
    ('Propuesta tecnológica', 'Iniciativa para implementar soluciones digitales o herramientas tecnológicas en instituciones o comunidades.', 1),
    ('Propuesta ambiental', 'Iniciativas enfocadas en la protección del medio ambiente, sostenibilidad o mitigación del cambio climático.', 1),
    ('Propuesta educativa', 'Proyectos dirigidos a mejorar el acceso, calidad o cobertura de la educación.', 1),
    ('Propuesta de salud pública', 'Acciones para fortalecer el sistema de salud, campañas preventivas o mejora de servicios médicos.', 1),
    ('Propuesta de infraestructura', 'Obras públicas como carreteras, puentes, edificios comunitarios o redes eléctricas.', 1),
    ('Propuesta social', 'Propuestas orientadas a mejorar la inclusión, equidad, y condiciones sociales de poblaciones vulnerables.', 1),
    ('Propuesta cultural', 'Proyectos para preservar, difundir o desarrollar el patrimonio y actividades culturales.', 1),
    ('Propuesta económica', 'Acciones dirigidas a estimular la economía local, emprendimientos o generación de empleo.', 1),
    ('Propuesta deportiva', 'Fomento de la actividad física, apoyo a ligas deportivas o construcción de instalaciones.', 1),
    ('Propuesta de seguridad', 'Medidas para prevenir el delito, mejorar la vigilancia o implementar tecnologías de seguridad.', 1),
    ('Propuesta participativa', 'Mecanismos que promuevan la participación ciudadana o procesos de gobernanza abierta.', 1),
    ('Propuesta piloto', 'Prueba controlada de nuevas ideas antes de su implementación general.', 1),
    ('Propuesta experimental', 'Iniciativas que exploran enfoques no convencionales o innovadores.', 1)

-- Estados de procesos de propuestas, archivos, comentarios
INSERT INTO [dbo].[vpv_processStatus] ([name])
VALUES
    ('Activo'),
    ('Inactivo'),
    ('En proceso'),
    ('Rechazado'),
    ('Aprobado'),
    ('Pendiente de revisión'),
    ('En validación'),
    ('Observado'),
    ('Completado'),
    ('Cancelado'),
    ('Archivado'),
    ('Publicado')


-- Condiciones del gobierno 

INSERT INTO [dbo].[vpv_governmentEntities] ([name], [acronym], [enable]) 
VALUES
    ('Caja Costarricense de Seguro Social', 'CCSS', 1),
    ('Ministerio de Educación Pública', 'MEP', 1),
    ('Ministerio de Hacienda', 'MH', 1),
    ('Instituto Costarricense de Electricidad', 'ICE', 1),
    ('Ministerio de Obras Públicas y Transportes', 'MOPT', 1),
    ('Ministerio de Salud', 'MS', 1),
    ('Instituto Nacional de Seguros', 'INS', 1),
    ('Instituto Costarricense de Turismo', 'ICT', 1),
    ('Tribunal Supremo de Elecciones', 'TSE', 1),
    ('Asamblea Legislativa', 'AL', 1),
    ('Universidad de Costa Rica', 'UCR', 1),
    ('Universidad Nacional', 'UNA', 1),
    ('Instituto Nacional de Aprendizaje', 'INA', 1),
    ('Ministerio de Justicia y Paz', 'MJP', 1),
    ('Ministerio de Ciencia, Innovación, Tecnología y Telecomunicaciones', 'MICITT', 1)




INSERT INTO [dbo].[vpv_governmentBenefits] ([benefit], [enable], [dataType])
VALUES
    ('Incentivo económico de la CCSS', 1, 'decimal'),
    ('Subsidio mensual de vivienda', 1, 'decimal'),
    ('Tener al menos 10 empleados en el proyecto', 1, 'integer'),
    ('Número de adultos mayores beneficiados', 1, 'integer'),
    ('Acceso gratuito a servicios de salud primaria', 1, 'bit'),
    ('Participación en capacitaciones del INA', 1, 'bit'),
    ('Descuento en servicios eléctricos del ICE', 1, 'decimal'),
    ('Cantidad de estudiantes beneficiados por beca', 1, 'integer'),
    ('Disponibilidad de servicio de transporte', 1, 'bit'),
    ('Monto asignado por el MEP para materiales', 1, 'decimal'),
    ('Alquiler subsidiado por el IMAS', 1, 'decimal'),
    ('Participación en programa de salud preventiva', 1, 'bit'),
    ('Cantidad de computadoras entregadas', 1, 'integer'),
    ('Cobertura de seguro por el INS', 1, 'bit'),
    ('Reducción de tarifas municipales', 1, 'decimal')


-- Condiciones de avales externos (No gobierno)

INSERT INTO [dbo].[vpv_sponsornGroupTypes] ([name], [enable])
VALUES
    ('Incubadora de empresas', 1),
    ('Aceleradora de negocios', 1),
    ('Grupo de inversión', 1),
    ('Organización sin fines de lucro', 1),
    ('Agencia de desarrollo regional', 1),
    ('Banco de desarrollo', 1),
    ('Cámara empresarial', 1),
    ('Cooperativa de apoyo', 1),
    ('Organismo internacional', 1),
    ('Red de mentores', 1)




INSERT INTO [dbo].[vpv_sponsorGroups] 
([name], [description], [enable], [deleted], [sponsorGroupTypeId])
VALUES
('ParqueTec', 'SponsorGroup', 1, 0, 1),        
('AUGE UCR', 'SponsorGroup', 1, 0, 2),         
('Carao Ventures', 'SponsorGroup', 1, 0, 3),   
('Parque La Libertad', 'SponsorGroup', 1, 0, 4),
('PROCOMER', 'SponsorGroup', 1, 0, 5),         
('GNPlus', 'SponsorGroup', 1, 0, 6),           
('Fundación CRUSA', 'SponsorGroup', 1, 0, 7),  
('InnovaAP', 'SponsorGroup', 1, 0, 8),         
('Impact Hub SJ', 'SponsorGroup', 1, 0, 9),    
('CONICIT', 'SponsorGroup', 1, 0, 10) 



INSERT INTO [dbo].[vpv_sponsorAgrementsType] ([name], [description], [dataType])
VALUES
('Crowdfunding de donación', 'Aportes voluntarios sin retorno económico directo', 'bit'),
('Crowdfunding de recompensa', 'Aportes a cambio de un beneficio simbólico o material', 'bit'),
('Crowdfunding de préstamo', 'Financiamiento con obligación de reembolso con o sin intereses', 'decimal'),
('Crowdfunding de inversión', 'Participación a cambio de una parte del capital o utilidades', 'integer'),
('Apoyo con producto o servicio', 'El patrocinador entrega bienes o servicios en lugar de dinero', 'bit')


-- SCHEDULES 

GO
CREATE OR ALTER PROCEDURE dbo.vpvSP_LlenarSchedules
AS
BEGIN
    DECLARE @horarios TABLE (
        name NVARCHAR(50),
        recurrencyType NVARCHAR(50),
        repetition INT
    );


    INSERT INTO @horarios (name, recurrencyType, repetition)
    VALUES 
        ('Cada semana', 'semanal', 1),
        ('Cada mes', 'mensual', 1),
        ('Cada 15 días', 'semanal', 2);

    DECLARE @i INT = 1;
    DECLARE @mes INT;
    DECLARE @dia INT;
    DECLARE @endDate DATETIME;


    WHILE @i <= 13
    BEGIN
        SET @mes = FLOOR(RAND(CHECKSUM(NEWID())) * 8) + 5;  
        SET @dia = FLOOR(RAND(CHECKSUM(NEWID())) * 30) + 1; 
        SET @endDate = DATEFROMPARTS(2025, @mes, @dia);

        INSERT INTO [dbo].[vpv_schedules] ([name], [recurrencyType], [repetition], [endType], [endDate])
        SELECT name, recurrencyType, repetition, 'NA', @endDate
        FROM @horarios;

        SET @i += 1;
    END
END;
GO

EXEC vpvSP_LlenarSchedules
GO




--Transactions 


INSERT INTO [dbo].[vpv_transTypes] 
([name], [deleted], [transTypeId])
VALUES
    ( 'Credit', 0,1),            
    ( 'Debit', 0,2),              
    ( 'Refund', 0,3),           
    ( 'Manual Adjustment', 0, 4),  
    ( 'Chargeback', 0,5),            
    ( 'Deposit', 0,6),               
    ( 'Withdrawal', 0,7),            
    ( 'Transfer', 0,8)





INSERT INTO [dbo].[vpv_transSubTypes] ([name], [deleted])--CORREGIR
VALUES
    ('Aporte voluntario', 0),
    ('Compra de recompensa', 0),
    ('Reembolso propuesta cancelada', 0),
    ('Aprobación de financiamiento', 0),
    ('Pago de propuesta', 0),
    ('Activación de beneficio', 0),
    ('Crédito institucional', 0),
    ('Cancelación de participación', 0),
    ('Inversión de Usuario', 0),
	('Inversión de Entidad', 0),
	('Inversión de Sponsor', 0),
	('Inversion a un plan',0)



--LOGS

-- Log severity
INSERT INTO [dbo].vpv_logSeverity([name])
VALUES
	('Low'),
	('Medium'),
	('High'),
	('Critical'),
	('Informational');

	--Log Sources
INSERT INTO [dbo].vpv_logsSources([name])
VALUES
	('System'),
	('Application'),
	('Database'),
	('Security'),
	('User Activity'),
	('Network'),
	('API'),
	('Payment Gateway'),
	('Error Handler'),
	('Authentication'),
	('File System');


	--Log Types
INSERT INTO [dbo].vpv_logTypes([name])
VALUES
	('Error'),
	('Warning'),
	('Info'),
	('Debug'),
	('Critical'),
	('Audit'),
	('Security'),
	('Transaction'),
	('Performance'),
	('Access');

--PAGOS

INSERT INTO dbo.vpv_currencies(currencyId, name, acronym, symbol)--
VALUES (1, 'Colón Costa Rica', 'CRC', '¢'),(2, 'Dólar Estados Unidos', 'USD', '$');

	-- inserciones CRC ? USD (currencyId = 1)
INSERT INTO dbo.vpv_exchangeRates--F
	(startDate,    endDate,      exchangeRate, enable, currentExchange, currencyId)
VALUES
	  ('2025-06-14','2025-06-14', 0.00195,       1,      0,                   1),
	  ('2025-06-15','2025-06-15', 0.0019493,     1,      0,                   1),
	  ('2025-06-16','2025-06-16', 0.0019896,     1,      0,                   1),
	  ('2025-06-17','2025-06-17', 0.00199,       1,      0,                   1),
	  ('2025-06-18','2025-06-18', 0.00199,       1,      1,                   1);


--Payment Methods
INSERT INTO [dbo].[vpv_paymentMethods] ([name], [apiURL], [secretKey], [key], [enable])
VALUES
	('PayPal', 'https://api.paypal.com/v1/', 0x5A3D4C6F2A7B9C5F1234567890ABCDE1234567890ABCDEF0123456789ABCDEF, 0x7F5A9B6C5D7E1F23334567890ABCDE1234567890ABCDEF0123456789ABCDE, 1),
	('Stripe', 'https://api.stripe.com/v1/', 0x8F3A7B9C1D2E3F9A1234567890ABCDE1234567890ABCDEF0123456789ABCDE, 0x9B3D6C2F1D8E7A234567890ABCDE1234567890ABCDEF0123456789ABCDE, 1),
	('MercadoPago', 'https://api.mercadopago.com/v1/', 0x2D3A5F9B1C7E9D3A567890ABCDE1234567890ABCDEF0123456789ABCDE, 0x4F2A8D6E3B9F0A234567890ABCDE1234567890ABCDEF0123456789ABCDE, 1),
	('RappiPay', 'https://api.rappipay.com/v1/', 0x1A3D4E5F2B8C9D3A567890ABCDE1234567890ABCDEF0123456789ABCDE, 0x5E7A9D2B6C3F4A1234567890ABCDE1234567890ABCDEF0123456789ABCDE, 1),
	('Apple Pay', 'https://api.apple.com/v1/', 0x0B5D6F3A2C8E9D234567890ABCDE1234567890ABCDEF0123456789ABCDE, 0x9C7F2A3D8B5E1F9A234567890ABCDE1234567890ABCDEF0123456789ABCDE, 1);



GO
CREATE OR ALTER PROCEDURE dbo.vpvSP_InsertarPaymentMethods
AS
BEGIN
    DECLARE @i INT = 1;
    DECLARE @name VARCHAR(55);
    DECLARE @methodId INT;
    DECLARE @token VARCHAR(256);
    DECLARE @expTokenDate DATETIME;
    DECLARE @maskAccount NVARCHAR(MAX);
    DECLARE @callbackURL NVARCHAR(200);
    DECLARE @configurationDetails NVARCHAR(MAX);
    DECLARE @refreshToken VARBINARY(256);

	-- Cursor para recorrer los métodos de pago existentes, recibiendo loda daros de la consulta select de la tabla que contiene los metodos de pago
    DECLARE method_cursor CURSOR FOR
        SELECT [name], [methodId]
        FROM [dbo].[vpv_paymentMethods]; 

    OPEN method_cursor;
    FETCH NEXT FROM method_cursor INTO @name, @methodId;

    WHILE @i <= 15
    BEGIN
        SET @token = CONVERT(VARCHAR(256), NEWID());
        SET @expTokenDate = DATEADD(DAY, @i * 30, GETDATE());
        SET @maskAccount = CONCAT('****', RIGHT('000' + CAST((1000 + @i * 7) AS NVARCHAR), 4));
        SET @callbackURL = CONCAT('https://vpv.example.com/callback/method', @i);
        SET @configurationDetails = CONCAT('{"currency":"USD", "method":"', @name, '"}');
        SET @refreshToken = CAST(HASHBYTES('SHA2_256', @token) AS VARBINARY(256));

        INSERT INTO [dbo].[vpv_availablePaymentMethods]
           ([name], [token], [expTokenDate], [maskAccount], [callbackURL], [configurationDetails], [refreshToken], [methodId])
        VALUES
           (@name, @token, @expTokenDate, @maskAccount, @callbackURL, @configurationDetails, @refreshToken, @methodId);

        SET @i += 1;

        FETCH NEXT FROM method_cursor INTO @name, @methodId;

        IF @@FETCH_STATUS <> 0
        BEGIN
            CLOSE method_cursor;
            OPEN method_cursor;
            FETCH NEXT FROM method_cursor INTO @name, @methodId;
        END
    END

	-- Cerrar y liberar el cursor
    CLOSE method_cursor;
    DEALLOCATE method_cursor;
END;
GO




INSERT INTO [dbo].[vpv_founds]
    ([name])
VALUES ('Dinero');


