

---------------------
-- PROPUESTAS 
---------------------

INSERT INTO [dbo].[vpv_proposals]
([idUser], [entitydid], [tittle], [description], [creationDate], [scheduleId], [enable], [deleted], [ckecksum], [statusId], [budget], idTargetPopulation, [proposalTypeId],
 [lastUpdate], [startingDate], [proposalTypeId_semantica], [relacion])
VALUES
--Propuestas en estado "En proceso"
(1, NULL, 'Proyecto de reciclaje en comunidades rurales', 'Implementar un sistema integral de reciclaje con participaci�n comunitaria.',
 GETDATE(), 1, 1, 0, HASHBYTES('SHA2_256', CONVERT(NVARCHAR(MAX), NEWID())), 3, 5000000.00, 1, 3, GETDATE(), DATEADD(DAY, 30, GETDATE()), 'Ambiental', NULL),

(2, NULL, 'Plataforma digital de salud p�blica', 'Desarrollar una aplicaci�n m�vil para seguimiento m�dico en zonas rurales.',
 GETDATE(), 2, 1, 0, HASHBYTES('SHA2_256', CONVERT(NVARCHAR(MAX), NEWID())), 3, 15000000.00, 1, 5, GETDATE(), DATEADD(DAY, 45, GETDATE()), 'Salud p�blica', NULL),

(5, NULL, 'Iluminaci�n y vigilancia comunitaria inteligente', 'Instalaci�n de c�maras conectadas a sensores de movimiento y luminarias LED en barrios con alta incidencia delictiva.', 
 GETDATE(), 1, 1, 0, HASHBYTES('SHA2_256', CONVERT(NVARCHAR(MAX), NEWID())), 3, 11000000.00, 1, 11, GETDATE(), DATEADD(DAY, 40, GETDATE()), 'Seguridad', NULL),

 --Propuestas en estado "Pendiente de revisi�n"
(3, NULL, 'Sistema inteligente de riego agr�cola', 'Desarrollo e implementaci�n de sensores IoT para monitorear humedad y automatizar el riego en zonas rurales.', 
 GETDATE(), 1, 1, 0, HASHBYTES('SHA2_256', CONVERT(NVARCHAR(MAX), NEWID())), 6, 7500000.00, 1, 2, GETDATE(), DATEADD(DAY, 60, GETDATE()), 'Tecnol�gica', NULL),

(4, NULL, 'Rescate de tradiciones culturales ind�genas', 'Financiar talleres de danza, gastronom�a y lengua ind�gena para ni�os y j�venes en territorios originarios.', 
 GETDATE(), 2, 1, 0, HASHBYTES('SHA2_256', CONVERT(NVARCHAR(MAX), NEWID())), 6, 3000000.00, 1, 8, GETDATE(), DATEADD(DAY, 30, GETDATE()), 'Cultural', NULL);



 ----------------------
 --PROPOSAL VERSIONS 
 ----------------------

INSERT INTO [dbo].[vpv_proposalVersions]
([tittle], [content], [creationDate], [startingDate], [scheduleId], [enable], [deleted], [checksum], [statusid], [budget], 
[lastUpdate], [idUser], [proposalId], [lastVersion])
VALUES

-- PROPUESTA 1: Proyecto de reciclaje en comunidades rurales
('Proyecto de reciclaje - Versi�n inicial', 'Propuesta base para implementar estaciones de reciclaje en zonas rurales con participaci�n de juntas comunales.',
 GETDATE(), DATEADD(DAY, 30, GETDATE()), 1, 0, 0, HASHBYTES('SHA2_256', CONVERT(NVARCHAR(MAX), NEWID())), 2, 5000000.00, GETDATE(), 1, 1, 0),

('Proyecto de reciclaje - Expansi�n regional','Se propone extender el modelo a m�s comunidades e incluir incentivos econ�micos por reciclaje entregado.',
 GETDATE(), DATEADD(DAY, 45, GETDATE()), 1, 1, 0, HASHBYTES('SHA2_256', CONVERT(NVARCHAR(MAX), NEWID())), 6, 6000000.00, GETDATE(), 1, 1, 1),

-- PROPUESTA 2: Plataforma digital de salud p�blica
('App salud rural - Versi�n inicial', 'Desarrollo de aplicaci�n m�vil para seguimiento de pacientes en �reas rurales sin conectividad constante.',
 GETDATE(), DATEADD(DAY, 45, GETDATE()), 2, 0, 0, HASHBYTES('SHA2_256', CONVERT(NVARCHAR(MAX), NEWID())), 2, 15000000.00, GETDATE(), 2, 2, 0),

('App salud rural - Integraci�n con expediente digital', 'La nueva versi�n incluye integraci�n con expediente digital, acceso para personal m�dico y an�lisis estad�sticos.',
 GETDATE(), DATEADD(DAY, 60, GETDATE()), 2, 1, 0, HASHBYTES('SHA2_256', CONVERT(NVARCHAR(MAX), NEWID())), 6, 18000000.00, GETDATE(), 2, 2, 1),

-- PROPUESTA 3: Iluminaci�n y vigilancia comunitaria inteligente
('Vigilancia comunitaria - Versi�n inicial', 'Instalaci�n de c�maras de videovigilancia alimentadas con energ�a solar en zonas con alta criminalidad.',
 GETDATE(), DATEADD(DAY, 40, GETDATE()), 1, 0, 0, HASHBYTES('SHA2_256', CONVERT(NVARCHAR(MAX), NEWID())), 2, 11000000.00, GETDATE(), 5, 3, 0),

('Vigilancia comunitaria - Conectividad en tiempo real', 'Actualizaci�n del sistema para conexi�n en tiempo real con estaciones policiales y aplicaci�n ciudadana.',
 GETDATE(), DATEADD(DAY, 55, GETDATE()), 1, 1, 0, HASHBYTES('SHA2_256', CONVERT(NVARCHAR(MAX), NEWID())), 6, 12500000.00, GETDATE(), 5, 3, 1);


---------------------------
--CROWDFOUNDING PROPOSALS
---------------------------
INSERT INTO [dbo].[vpv_crowdfoundingProposals]
([statusId], [proposalId], [deleted], [enable], [creationDate], [checksum])
VALUES
(3, 1, 0, 1, GETDATE(), HASHBYTES('SHA2_256', CONVERT(NVARCHAR(MAX), NEWID()))),
(3, 2, 0, 1, GETDATE(), HASHBYTES('SHA2_256', CONVERT(NVARCHAR(MAX), NEWID()))),
(3, 3, 0, 1, GETDATE(), HASHBYTES('SHA2_256', CONVERT(NVARCHAR(MAX), NEWID())));



-----------------
--PAYMENT PLAN 
-----------------

INSERT INTO [dbo].[vpv_paymentPlans]
([paymentDate], [totalAmount], [scheduleId], [enable], [deleted], [checksum], [statusId], [idUser], [requiredCapital])
VALUES

( GETDATE(), 100000.00, 1, 1, 0, HASHBYTES('SHA2_256', CONVERT(NVARCHAR(MAX), NEWID())), 3, 1, 100000.00), -- Para Plan de Ejecucion 1
( GETDATE(), 200000.00, 2, 1, 0, HASHBYTES('SHA2_256', CONVERT(NVARCHAR(MAX), NEWID())), 3, 1, 200000.00), -- Para Plan de Ejecucion 2
( GETDATE(), 85000.00, 1, 1, 0, HASHBYTES('SHA2_256', CONVERT(NVARCHAR(MAX), NEWID())), 3, 2, 85000.00), -- Para Plan de Ejecucion 3
( GETDATE(), 150000.00, 2, 1, 0, HASHBYTES('SHA2_256', CONVERT(NVARCHAR(MAX), NEWID())), 3, 2, 150000.00), -- Para Plan de Ejecucion 4
( GETDATE(), 100000.00, 1, 1, 0, HASHBYTES('SHA2_256', CONVERT(NVARCHAR(MAX), NEWID())), 3, 5, 100000.00), -- Para Plan de Ejecucion 5
( GETDATE(), 800000.00, 2, 1, 0, HASHBYTES('SHA2_256', CONVERT(NVARCHAR(MAX), NEWID())), 3, 5, 800000.00); -- Para Plan de Ejecucion 6



---------------------
-- EXECUTION PLANS
---------------------

INSERT INTO [dbo].[vpv_executionPlans]
([executionPlanId], [tittle], [description], [startDate], [finalDate], [checksum], [idUser], [statusId], 
[scheduleId], [crowdfoundingProposalId], [paymentPlanId], [idTargetPopulation], [idMeasureUnit], [duracion])
VALUES

-- Ejecuci�n para propuesta "Proyecto de reciclaje en comunidades rurales"
(1, 'Instalaci�n de estaciones de reciclaje', 'Instalaci�n de estaciones de reciclaje en comunidades rurales, con participaci�n activa de los residentes.',
 GETDATE(), NULL, HASHBYTES('SHA2_256', CONVERT(NVARCHAR(MAX), NEWID())), 1, 3, 1, 1,1, 1, 2, 1),

(2, 'Recolecci�n selectiva de residuos', 'Organizar y educar a las comunidades rurales para implementar un sistema de recolecci�n selectiva de residuos s�lidos.',
 GETDATE(), NULL, HASHBYTES('SHA2_256', CONVERT(NVARCHAR(MAX), NEWID())), 1, 3, 1, 1,2, 1, 2, 2),

-- Ejecuci�n para propuesta "Plataforma digital de salud p�blica"
(3, 'Desarrollo de la plataforma de salud', 'Desarrollo y dise�o de la interfaz para la plataforma digital de salud p�blica para su uso en zonas rurales.',
 GETDATE(), NULL, HASHBYTES('SHA2_256', CONVERT(NVARCHAR(MAX), NEWID())), 2, 3, 2, 2,3, 1, 2, 3),

(4, 'Integraci�n de base de datos para monitoreo m�dico', 'Desarrollar una base de datos que integre los registros de salud para cada paciente en la plataforma.',
 GETDATE(), NULL, HASHBYTES('SHA2_256', CONVERT(NVARCHAR(MAX), NEWID())), 2, 3, 2, 2,4, 1, 2, 1),

-- Ejecuci�n para propuesta "Iluminaci�n y vigilancia comunitaria inteligente" 
(5, 'Instalaci�n de c�maras de vigilancia', 'Instalar c�maras de seguridad con sensores de movimiento en puntos estrat�gicos de las zonas con mayor incidencia delictiva.',
 GETDATE(), NULL, HASHBYTES('SHA2_256', CONVERT(NVARCHAR(MAX), NEWID())), 5, 3, 1, 3,5, 1, 2, 2),

(6, 'Implementaci�n de luminarias LED inteligentes', 'Instalar luminarias LED con sensores de movimiento que se activan solo cuando se detecta movimiento en la zona.',
 GETDATE(), NULL, HASHBYTES('SHA2_256', CONVERT(NVARCHAR(MAX), NEWID())), 5, 3, 1, 3,6, 1, 2, 3);



------------------------
-- SPONSOR AGREMENTS
------------------------

INSERT INTO [dbo].[vpv_sponsorAgreements]
([enable], [checksum], [startDate], [finalDate], [signedDate], [deleted],
 [currencyId], [scheduleId], [noReward], [percentage], [product], [amount],
 [shares], [baseSalary], [sponsorAgreementTypeId], [sponsorGroupId], [crowdfoundingProposalId], [inversion],[name])
VALUES
--Inversiones de Crowdfounding Prop 1
(1, HASHBYTES('SHA2_256', CONVERT(NVARCHAR(MAX), NEWID())), GETDATE(), DATEADD(MONTH, 3, GETDATE()), GETDATE(), 0, 1, 1, 0, 0.15, NULL, NULL, NULL, 100000.00, 4, NULL, 1,800000.00,'name'),
(1, HASHBYTES('SHA2_256', CONVERT(NVARCHAR(MAX), NEWID())), GETDATE(), DATEADD(MONTH, 3, GETDATE()), GETDATE(), 0, 1, 1, 0, 0.25, NULL, NULL, NULL, 150000.00, 4, NULL, 1,700000.00,'name'),
(1, HASHBYTES('SHA2_256', CONVERT(NVARCHAR(MAX), NEWID())), GETDATE(), DATEADD(MONTH, 3, GETDATE()), GETDATE(), 0, 1, 1, 0, 0.32, NULL, NULL, NULL, 160000.00, 4, NULL, 1,500000.00,'name'),
(1, HASHBYTES('SHA2_256', CONVERT(NVARCHAR(MAX), NEWID())), GETDATE(), DATEADD(MONTH, 3, GETDATE()), GETDATE(), 0, 1, 1, 0, 0.27, NULL, NULL, NULL, 170000.00, 4, NULL, 1,300000.00,'name'),

 --Inversiones de Crowdfounding Prop 2
(1, HASHBYTES('SHA2_256', CONVERT(NVARCHAR(MAX), NEWID())), GETDATE(), DATEADD(MONTH, 3, GETDATE()), GETDATE(), 0, 1, 1, 0, 0.19, NULL, NULL, NULL, 150000.00, 4, NULL, 2,800000.00,'name'),
(1, HASHBYTES('SHA2_256', CONVERT(NVARCHAR(MAX), NEWID())), GETDATE(), DATEADD(MONTH, 3, GETDATE()), GETDATE(), 0, 1, 1, 0, 0.40, NULL, NULL, NULL, 160000.00, 4, NULL, 2,600000.00,'name'),
(1, HASHBYTES('SHA2_256', CONVERT(NVARCHAR(MAX), NEWID())), GETDATE(), DATEADD(MONTH, 3, GETDATE()), GETDATE(), 0, 1, 1, 0, 0.45, NULL, NULL, NULL, 170000.00, 4, NULL, 2,700000.00,'name'),
(1, HASHBYTES('SHA2_256', CONVERT(NVARCHAR(MAX), NEWID())), GETDATE(), DATEADD(MONTH, 3, GETDATE()), GETDATE(), 0, 1, 1, 0, 0.32, NULL, NULL, NULL, 170000.00, 4, NULL, 2,550000.00,'name'),
(1, HASHBYTES('SHA2_256', CONVERT(NVARCHAR(MAX), NEWID())), GETDATE(), DATEADD(MONTH, 3, GETDATE()), GETDATE(), 0, 1, 1, 0, 0.39, NULL, NULL, NULL, 140000.00, 4, NULL, 2,700000.00,'name'),

 --Inversiones de Crowdfounding Prop 3
(1, HASHBYTES('SHA2_256', CONVERT(NVARCHAR(MAX), NEWID())), GETDATE(), DATEADD(MONTH, 3, GETDATE()), GETDATE(), 0, 1, 1, 0, 0.19, NULL, NULL, NULL, 110000.00, 4, NULL, 3,800000.00,'name'),
(1, HASHBYTES('SHA2_256', CONVERT(NVARCHAR(MAX), NEWID())), GETDATE(), DATEADD(MONTH, 3, GETDATE()), GETDATE(), 0, 1, 1, 0, 0.32, NULL, NULL, NULL, 120000.00, 4, NULL, 3,340000.00,'name'),
(1, HASHBYTES('SHA2_256', CONVERT(NVARCHAR(MAX), NEWID())), GETDATE(), DATEADD(MONTH, 3, GETDATE()), GETDATE(), 0, 1, 1, 0, 0.13, NULL, NULL, NULL, 150000.00, 4, NULL, 3,860000.00,'name'),
(1, HASHBYTES('SHA2_256', CONVERT(NVARCHAR(MAX), NEWID())), GETDATE(), DATEADD(MONTH, 3, GETDATE()), GETDATE(), 0, 1, 1, 0, 0.17, NULL, NULL, NULL, 130000.00, 4, NULL, 3,820000.00,'name');


-----------------------
--DOCS PARA REPORTES
-----------------------

INSERT INTO [dbo].[vpv_docs]
           ([identitydocsid],[formatid],[docstypeid],[docstateid],[archive],[filename],[date],[enable]
           ,[startdate],[nextcheckdate],[semantic_category],[checksum])
     VALUES
		(1, 1, 3, 3, 0x25504446, 'reporte financiero 1.pdf', GETDATE(), 1, GETDATE(), '2025-12-20', 'reporte financiero de la Crowdf propuesta 1 ', CHECKSUM('Dato de prueba')),
		(2, 1, 3, 3, 0x25504446, 'reporte financiero 2.pdf', GETDATE(), 1, GETDATE(), '2025-12-20', 'reporte financiero de la Crowdf propuesta 1', CHECKSUM('Dato de prueba')),
		(3, 1, 3, 3, 0xFFD8FFE0, 'reporte financiero 3.jpg', GETDATE(), 1, GETDATE(), '2025-12-20', 'reporte financiero de la Crowdf propuesta 1', CHECKSUM('Dato de prueba'));


--------------
-- REPORTS
--------------

INSERT INTO [dbo].[vpv_projectReports]
([creationDate], [enable], [deleted], [checksum], [lastUpdated], [idUser], [totalProfit], [expectedProfit], [totalLoss], [totalExpenses],
 [tittle], [description], [docid], [scheduleId], [crowdfoundingProposalId], [idTargetPopulation], [relacion], [availablePayment], [statusId])
VALUES
-- Reporte Proyecto de reciclaje en comunidades rurales
(GETDATE(), 1, 0, CHECKSUM('Dato de prueba'), GETDATE(), 1, 2000000.00, 2500000.00, 500000.00, 300000.00,
 'Reporte de reciclaje', 'Reporte del impacto del proyecto de reciclaje en comunidades rurales.', 1, 1, 1, 1, 'Reporte fianciero de la propuesta de Impacto ambiental', 1800000.00, 5),

-- Reporte  Plataforma digital de salud p�blica
(GETDATE(), 1, 0, CHECKSUM('Dato de prueba'), GETDATE(), 2, 3000000.00, 3500000.00, 700000.00, 400000.00,
 'Reporte salud p�blica', 'An�lisis de la plataforma digital de salud p�blica para zonas rurales.', 2, 2, 2, 1, 'Reporte fianciero de la propuesta de Tecnolog�a para la salud', 1500000.00, 5),

-- Reporte  Iluminaci�n y vigilancia comunitaria inteligente
(GETDATE(), 1, 0, CHECKSUM('Dato de prueba'), GETDATE(), 5, 1000000.00, 1500000.00, 200000.00, 100000.00,
 'Reporte iluminaci�n', 'Seguimiento de la implementaci�n de c�maras de vigilancia y luminarias en barrios de alta incidencia delictiva.', 3, 1, 3, 1, 'Reporte fianciero de la propuesta de Seguridad p�blica', 2000000.00, 5);

INSERT INTO vpv_parameters (name, configuration, enable)
VALUES ('IA Azure', 'IA AZURE, return 1, checksum 1, rollback 1, logs 1', 1)
GO

INSERT INTO vpv_processtypes (name)
VALUES ('Propuestas ambientales')
GO

INSERT INTO dbo.vpv_process
(
  processtypeid,
  referencevalue,
  referenceid,
  parameterid,
  processmethodid,
  [name],
  description,
  enable,
  fecha,
  [order]
)
VALUES
(
  1,
  3,
  'proposalTypeId',  
  1,
  1,
  N'Evaluación de Impacto Ambiental',
  N'Proyecto de reciclaje en comunidades rurales que incluye la instalación de puntos de acopio.',
  1,
  GETDATE(),
  1
);
GO

ALTER TABLE dbo.vpv_workresults
ALTER COLUMN referenceid NVARCHAR(50)
GO
	
INSERT INTO dbo.vpv_workresults
(
  processid,        -- FK al registro en vpv_process
  referencevalue,   -- valor de la llave
  referenceid,      -- tipo de referencia: literal "proposalId"
  timestamp,        -- fecha y hora de ejecución
  error,            -- 0 = sin error
  errorMessage,     -- texto indicando “Nulo”
  details,          -- detalles (no admite NULL)
  performedby       -- quién ejecutó el proceso
)
VALUES
(
  1,                          -- processid (reemplaza por el ID real)
  1,                          -- referencevalue
  N'proposalTypeId',              -- referenceid
  GETDATE(),                  -- timestamp
  0,                          -- error = false
  N'Nulo',                    -- errorMessage
  N'Ejecución exitosa sin observaciones',  -- detalles
  N'IA Azure'                 -- performedby
);

-- Inserciones de información extraída (todas exitosas, workresultid = 1)
INSERT INTO dbo.vpv_extractedinfos  
  (workresultid, field_value, comments, error)  
VALUES  
  (1, N'5 puntos de acopio instalados',  
      N'Extracción automática correcta', 0);

INSERT INTO dbo.vpv_extractedinfos  
  (workresultid, field_value, comments, error)  
VALUES  
  (1, N'200 kg de residuos reciclados',  
      N'Extracción automática correcta', 0);

INSERT INTO dbo.vpv_extractedinfos  
  (workresultid, field_value, comments, error)  
VALUES  
  (1, N'30 participantes en talleres',  
      N'Extracción automática correcta', 0);

INSERT INTO dbo.vpv_extractedinfos  
  (workresultid, field_value, comments, error)  
VALUES  
  (1, N'Duración del proyecto: 6 meses',  
      N'Extracción automática correcta', 0);

/***********************************
  Ejemplo para PROPOSAL_ID = 2
  Título: Plataforma digital de salud pública
  Tipo     : proposalTypeId = 5
***********************************/

-- 1) Inserto el proceso
INSERT INTO dbo.vpv_process
  (processtypeid, referencevalue, referenceid,
   parameterid, processmethodid,
   [name], description, enable, fecha, [order])
VALUES
  (1, 5, N'proposalTypeId',
   1, 1,
   N'Desarrollo de plataforma de salud pública',
   N'Creación de portal web y móvil para seguimiento de pacientes.',
   1, GETDATE(), 1);
GO

-- 2) Inserto el resultado del proceso
--    (asumo que processid = 2 en identity)
INSERT INTO dbo.vpv_workresults
  (processid, referencevalue, referenceid,
   timestamp, error, errorMessage, details, performedby)
VALUES
  (2, 5, N'proposalTypeId',
   GETDATE(), 0, N'Nulo',
   N'Ejecución exitosa sin observaciones', N'IA Azure');
GO

-- 3) Inserto la info extraída
--    (asumo que workresultid = 2)
INSERT INTO dbo.vpv_extractedinfos (workresultid, field_value, comments, error)
VALUES
  (2, N'Registro de 1 000 pacientes completado', N'OK', 0),
  (2, N'API integrada con sistema nacional de salud', N'OK', 0),
  (2, N'Módulo de notificaciones en producción', N'OK', 0),
  (2, N'TIempo de respuesta < 200 ms en pruebas', N'OK', 0);
GO


/***********************************
  Ejemplo para PROPOSAL_ID = 3
  Título: Iluminación y vigilancia comunitaria inteligente
  Tipo     : proposalTypeId = 11
***********************************/

INSERT INTO dbo.vpv_process
  (processtypeid, referencevalue, referenceid,
   parameterid, processmethodid,
   [name], description, enable, fecha, [order])
VALUES
  (1, 11, N'proposalTypeId',
   1, 1,
   N'Instalación de sensores de seguridad',
   N'Colocación de cámaras IoT y luminarias inteligentes.',
   1, GETDATE(), 1);
GO

-- asumo processid = 3
INSERT INTO dbo.vpv_workresults
  (processid, referencevalue, referenceid,
   timestamp, error, errorMessage, details, performedby)
VALUES
  (3, 11, N'proposalTypeId',
   GETDATE(), 0, N'Nulo',
   N'Ejecución exitosa sin observaciones', N'IA Azure');
GO

-- asumo workresultid = 3
INSERT INTO dbo.vpv_extractedinfos (workresultid, field_value, comments, error)
VALUES
  (3, N'10 cámaras instaladas y en línea', N'OK', 0),
  (3, N'Red de iluminación activa en 5 calles', N'OK', 0),
  (3, N'Alarma activada correctamente en simulacro', N'OK', 0),
  (3, N'Portal de monitoreo accesible 24/7', N'OK', 0);
GO


/***********************************
  Ejemplo para PROPOSAL_ID = 4
  Título: Sistema inteligente de riego agrícola
  Tipo     : proposalTypeId = 6
***********************************/

INSERT INTO dbo.vpv_process
  (processtypeid, referencevalue, referenceid,
   parameterid, processmethodid,
   [name], description, enable, fecha, [order])
VALUES
  (1, 6, N'proposalTypeId',
   1, 1,
   N'Implementación de estaciones de riego',
   N'Despliegue de sensores de humedad y válvulas automáticas.',
   1, GETDATE(), 1);
GO

-- asumo processid = 4
INSERT INTO dbo.vpv_workresults
  (processid, referencevalue, referenceid,
   timestamp, error, errorMessage, details, performedby)
VALUES
  (4, 6, N'proposalTypeId',
   GETDATE(), 0, N'Nulo',
   N'Ejecución exitosa sin observaciones', N'IA Azure');
GO

-- asumo workresultid = 4
INSERT INTO dbo.vpv_extractedinfos (workresultid, field_value, comments, error)
VALUES
  (4, N'25 estaciones instaladas', N'OK', 0),
  (4, N'Humedad promedio controlada al 40 %', N'OK', 0),
  (4, N'Ahorro estimado de agua 30 %', N'OK', 0),
  (4, N'Interfaz de control móvil operativa', N'OK', 0);
GO


/***********************************
  Ejemplo para PROPOSAL_ID = 5
  Título: Rescate de tradiciones culturales indígenas
  Tipo     : proposalTypeId = 8
***********************************/

INSERT INTO dbo.vpv_process
  (processtypeid, referencevalue, referenceid,
   parameterid, processmethodid,
   [name], description, enable, fecha, [order])
VALUES
  (1, 8, N'proposalTypeId',
   1, 1,
   N'Registro de tradiciones orales',
   N'Digitización y archivo de cantos y relatos comunitarios.',
   1, GETDATE(), 1);
GO

-- asumo processid = 5
INSERT INTO dbo.vpv_workresults
  (processid, referencevalue, referenceid,
   timestamp, error, errorMessage, details, performedby)
VALUES
  (5, 8, N'proposalTypeId',
   GETDATE(), 0, N'Nulo',
   N'Ejecución exitosa sin observaciones', N'IA Azure');
GO

-- asumo workresultid = 5
INSERT INTO dbo.vpv_extractedinfos (workresultid, field_value, comments, error)
VALUES
  (5, N'100 canciones grabadas', N'OK', 0),
  (5, N'Entrevistas a 20 ancianos', N'OK', 0),
  (5, N'Material subido a repositorio cultural', N'OK', 0),
  (5, N'Portal web con acceso público', N'OK', 0);
GO










