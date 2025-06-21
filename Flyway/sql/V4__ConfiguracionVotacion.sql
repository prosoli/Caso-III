------------------------------------------------------
--    Inserciones de Configuracion de la votacion   --
------------------------------------------------------
-- Target Populations---------------------------------------------------------------
-- Inserciones para la tabla vpv_TargetPopulations
INSERT INTO [dbo].[vpv_TargetPopulations]
           ([name], [description], [creationDate], [enable], [checksum])
VALUES
-- Población joven adulta
('Jóvenes Adultos',
 'Personas entre 18 y 35 años, consideradas jóvenes adultos para fines de segmentación demográfica y programas sociales.',
 GETDATE(), 1, 'chk_pop_001'),

-- Población adulta mayor
('Adultos Mayores',
 'Ciudadanos mayores de 65 años que forman parte de programas de apoyo y bienestar.',
 GETDATE(), 1, 'chk_pop_002'),

-- Población con discapacidad
('Personas con Discapacidad',
 'Individuos con alguna condición de discapacidad reconocida, física, sensorial o cognitiva.',
 GETDATE(), 1, 'chk_pop_003'),

-- Estudiantes universitarios
('Estudiantes Universitarios',
 'Personas activas en instituciones de educación superior a nivel universitario.',
 GETDATE(), 1, 'chk_pop_004'),

-- Población migrante
('Población Migrante',
 'Personas con estatus de residencia temporal o permanente, incluyendo refugiados.',
 GETDATE(), 1, 'chk_pop_005');


-- FilterTypes para cada tipo de demografía--------------------------------------------------

INSERT INTO [dbo].[vpv_FilterTypes]
           ([name], [enable], [datatype], [referenceId], [reference], [demotypeid], [demosubtypeid], [checksum])
VALUES
-- Sexo
('Sexo', 1, 'string', NULL, 0, 1, NULL, 'abc123'),

-- Nacionalidad
('Nacionalidad', 1, 'string', NULL, 0, 2, NULL, 'def456'),

-- Provincia
('Provincia', 1, 'string', NULL, 0, 3, NULL, 'ghi789'),

-- Condición migratoria
('Condición migratoria', 1, 'string', NULL, 0, 4, NULL, 'jkl012'),

-- Nivel educativo
('Nivel educativo', 1, 'string', NULL, 0, 5, NULL, 'mno345'),

-- Área profesional
('Área profesional', 1, 'string', NULL, 0, 6, NULL, 'pqr678'),

-- Sector laboral
('Sector laboral', 1, 'string', NULL, 0, 7, NULL, 'stu901'),

-- Situación económica
('Situación económica', 1, 'string', NULL, 0, 8, NULL, 'vwx234'),

-- Idioma principal
('Idioma principal', 1, 'string', NULL, 0, 9, NULL, 'yz0123'),

-- Grupo étnico
('Grupo étnico', 1, 'string', NULL, 0, 10, NULL, 'abc456'),

-- Zona geográfica
('Zona geográfica', 1, 'string', NULL, 0, 11, NULL, 'def789'),

-- Discapacidad
('Discapacidad', 1, 'string', NULL, 0, 12, NULL, 'ghi012'),

-- Religión
('Religión', 1, 'string', NULL, 0, 13, NULL, 'jkl345');


-- vpv_PopulationFilters-------------------------------------------------------------------

-- Filtros para Jóvenes Adultos (edad entre 18 y 35)
INSERT INTO [dbo].[vpv_PopulationFilters]
           ([description], [idFilterType], [valueMin], [valueMax], [referenceValue], [validation], [enable], [creationDate], [checksum], [idTargetPopulation])
VALUES 
           ('Edad 18-35', 2, 18.00, 35.00, NULL, 1, 1, GETDATE(), 'chk_fil_001', 1);

-- Filtros para Adultos Mayores (edad > 65)
INSERT INTO [dbo].[vpv_PopulationFilters]
           ([description], [idFilterType], [valueMin], [valueMax], [referenceValue], [validation], [enable], [creationDate], [checksum], [idTargetPopulation])
VALUES 
           ('Edad 65+', 2, 65.00, 120.00, NULL, 1, 1, GETDATE(), 'chk_fil_002', 2);

-- Filtros para Personas con Discapacidad (subtipo "Discapacidad" distinto de "Ninguna")
INSERT INTO [dbo].[vpv_PopulationFilters]
           ([description], [idFilterType], [valueMin], [valueMax], [referenceValue], [validation], [enable], [creationDate], [checksum], [idTargetPopulation])
VALUES 
           ('Tiene discapacidad', 13, NULL, NULL, 2, 1, 1, GETDATE(), 'chk_fil_003', 3);  -- Ej: referencia al id de "Física" en demosubtype

-- Filtros para Estudiantes Universitarios (nivel educativo = "Universitario")
INSERT INTO [dbo].[vpv_PopulationFilters]
           ([description], [idFilterType], [valueMin], [valueMax], [referenceValue], [validation], [enable], [creationDate], [checksum], [idTargetPopulation])
VALUES 
           ('Nivel universitario', 5, NULL, NULL, 5, 1, 1, GETDATE(), 'chk_fil_004', 4);  -- referencia al id del subtipo "Universitario"

-- Filtros para Población Migrante (condición migratoria ≠ "Nacional")
INSERT INTO [dbo].[vpv_PopulationFilters]
           ([description], [idFilterType], [valueMin], [valueMax], [referenceValue], [validation], [enable], [creationDate], [checksum], [idTargetPopulation])
VALUES 
           ('Es migrante', 4, NULL, NULL, 2, 1, 1, GETDATE(), 'chk_fil_005', 5);  -- Ej: referencia a "Residente permanente"

-- Searching Tags------------------------------------------------------------------------------

-- Tag para Jóvenes Adultos
INSERT INTO [dbo].[vpv_SearchingTags]
           ([name], [idTargetPopulations], [enable])
VALUES     (N'JOVEN', 1, 1);

-- Tag para Adultos Mayores
INSERT INTO [dbo].[vpv_SearchingTags]
           ([name], [idTargetPopulations], [enable])
VALUES     (N'MAYOR', 2, 1);

-- Tag para Personas con Discapacidad
INSERT INTO [dbo].[vpv_SearchingTags]
           ([name], [idTargetPopulations], [enable])
VALUES     (N'DISCAP', 3, 1);

-- Tag para Estudiantes Universitarios
INSERT INTO [dbo].[vpv_SearchingTags]
           ([name], [idTargetPopulations], [enable])
VALUES     (N'UNIV', 4, 1);

-- Tag para Población Migrante
INSERT INTO [dbo].[vpv_SearchingTags]
           ([name], [idTargetPopulations], [enable])
VALUES     (N'MIGRANT', 5, 1);

-- Unit Measure -------------------------------------------------------------------------------

INSERT INTO [dbo].[vpv_UnitMeasure]([name],[datatype],[enable])
     VALUES
           ('Litros','decimal(5,2)',1),
		   ('Semanas','decimal(5,2)',1),
		   ('Provincia','int',1),
		   ('Personas','int',1),
		   ('Votaciones','int',1),
		   ('Cantidad','int',1),
		   ('Porcentaje','decimal(5,2)',1);


-- Impact Zone Types --------------------------------------------------------------------------

INSERT INTO [dbo].[vpv_ImpactZoneTypes] ([name], [idUnitMeasure], [enable], [checksum])
VALUES
    ('Uso de agua potable', 1, 1, N'abc123    '),  -- idUnitMeasure = Litros
    ('Duración de proyecto', 2, 1, N'def456    '), -- idUnitMeasure = Semanas
    ('Cobertura territorial', 3, 1, N'ghi789    '),-- idUnitMeasure = Provincia
    ('Personas beneficiadas', 4, 1, N'xyz321    ');-- idUnitMeasure = Personas

-- Closure Types -----------------------------------------------------------------------------

INSERT INTO [dbo].[vpv_ClosureTypes]
           ([name],[enable])
     VALUES
           ('Cierre hasta que los votantes terminen',1),
		   ('Cierre hasta la fecha',1);

-- Voting Rule Sub Type ----------------------------------------------------------------------


INSERT INTO [dbo].[vpv_VotingRuleSubType]
           ([name],[idUnitMeasure],[enable])
     VALUES
		   ('Minimo de votacion', 5,1),
		   ('Porcentaje de votacion', 6,1),
		   ('Organizaciones', 7,1),
		   ('Personas', 7,1);


-- vpv_VotingRuleTypes ------------------------------------------------------------------------


INSERT INTO [dbo].[vpv_VotingRuleTypes]
           ([name],[enable])
     VALUES
           ('Visibilidad',1),
		   ('Aceptacion',1),
		   ('Rechazo',1),
		   ('Calificacion',1);

-- vpv_statusVoting 
select * from [vpv_statusVoting]---------------------------------------------------------------------------
INSERT INTO [dbo].[vpv_statusVoting]
           ([name], [enable], [checksum])
     VALUES
           ('Preparado', 1, N'8efb9d10c2'),
           ('En curso', 1, N'2a6370a34e'),
           ('Finalizada', 1, N'bb27a94cfc');

-- vpv_reminderTypes

INSERT INTO [dbo].[vpv_reminderTypes]
           ([name] ,[enable])
     VALUES
           ('Email',1),
		   ('SMS',1),
		   ('POPUP',1);


-- vpv_ResultTypes -------------------------------------------------------------------------

INSERT INTO [dbo].[vpv_ResultTypes]
           ([name] ,[enable],[referenceDescription])
     VALUES
			('Opcion',1,'Resultado de una opcion'),
			('Pregunta',1,'Resultado de una pregunta'),
			('General',1,'Resultado de un filtro');

-- vpv_VotingResultsStatus------------------------------------------------------------------

INSERT INTO [dbo].[vpv_VotingResultStatus]
           ([name],[enable])
     VALUES
           ('Aceptada',1),
		   ('Rechazada',1),
		   ('Variable',1);

-- vpv_votingRestrictionTypes -----------------------------------------------------------------

INSERT INTO [dbo].[vpv_votingRestrictionTypes]
           ([name] ,[description] ,[datatype] ,[enable])
     VALUES
			('Acceso','Acceso a la visualzacion de votacion', 'bit', 1),
			('Horario','Horario de votaciones- Schedule', 'int', 1),
			('Turnos','Turnos de votacion', 'varchar(50)', 1);

-- vpv_votingReasons -------------------------------------------------------------------------

INSERT INTO [dbo].[vpv_votingReasons]
           ([name],[description] ,[enable])
     VALUES
           ('Aval de propuesta','sin descripcion',1),
		   ('Hito de propuesta','sin descripcion',1),
		   ('Aval de propuesta','sin descripcion',1);

-- vpv_votingTypes ---------------------------------------------------------------------------

INSERT INTO [dbo].[vpv_votingTypes]
           ([name],[enable])
     VALUES
           ('Unica',1),
		   ('Multiple',1),
		   ('Calificacion',1);

-- vpv_questionTypes ---------------------------------------------------------------------------

INSERT INTO [dbo].[vpv_questionTypes]
           ([name],[enable])
     VALUES
           ('Unica',1),
		   ('Multiple',1),
		   ('Booleana',1),
		   ('Calificacion',1);

-- vpv_optionTypes ---------------------------------------------------------------------------

INSERT INTO [dbo].[vpv_optionTypes]
           ([name],[datatype],[enable])
     VALUES
           ('Unica','int',1),
		   ('Multiple','int',1),
		   ('Booleana','bit',1),
		   ('Calificacion','decimal(5,2)',1);






