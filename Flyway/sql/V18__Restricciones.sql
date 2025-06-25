INSERT INTO [dbo].[vpv_votingRestrictionTypes] ([name], [description], [datatype], [enable])
VALUES
('Edad m�nima', 'El votante debe tener al menos una edad espec�fica.', 'int', 1),
('Regi�n permitida', 'El votante debe estar en una regi�n permitida.', 'varchar', 1),
('Correo institucional', 'El correo debe ser de dominio institucional.', 'varchar', 1),
('Solo estudiantes activos', 'Verifica si el votante es estudiante activo.', 'bit', 1),
('Hora de acceso', 'Define un rango horario v�lido para votar.', 'datetime', 1);

INSERT INTO [dbo].[vpv_votingRestrictions] (
    [idVotingRestrictionTypes],
    [idVotingConfig],
    [description],
    [value],
    [validation],
    [creationDate],
    [enable],
    [startTime],
    [endTime],
    [checksum]
)
VALUES
-- Edad m�nima
(1, NULL, 'Solo pueden votar mayores de 18 a�os', '18', 1, GETDATE(), 1, NULL, NULL, N'chk1'),

-- Regi�n permitida
(2, NULL, 'Votaci�n exclusiva para San Jos�', 'San Jos�', 1, GETDATE(), 1, NULL, NULL, N'chk2'),

-- Correo institucional
(3, NULL, 'Correo debe contener dominio @tec.ac.cr', '@tec.ac.cr', 1, GETDATE(), 1, NULL, NULL, N'chk3'),

-- Solo estudiantes activos
(4, NULL, 'Verificaci�n de estudiante activo mediante sistema acad�mico', NULL, 1, GETDATE(), 1, NULL, NULL, N'chk4'),

-- Hora de acceso
(5, NULL, 'Solo se permite votar entre 8 AM y 5 PM', NULL, 1, GETDATE(), 1, '2025-06-17T08:00:00', '2025-06-17T17:00:00', N'chk5');

-- ZONAS DE IMPACTO
INSERT INTO [dbo].[vpv_ImpactZones] (
    [name],
    [description],
    [creationDate],
    [enable],
    [value],
    [idImpactZoneTypes],
    [checksum]
)
VALUES
-- 1
('Reducci�n de consumo h�drico',
 'Acciones que promueven el uso eficiente del agua potable.',
 GETDATE(),
 1,
 '15% reducci�n esperada',
 1,
 'chk001'),

-- 2
('Extensi�n temporal del proyecto',
 'Duraci�n estimada del proyecto seg�n la fase de implementaci�n.',
 GETDATE(),
 1,
 '24 meses',
 2,
 'chk002'),

-- 3
('Cobertura nacional',
 'El proyecto impactar� al menos 5 provincias del pa�s.',
 GETDATE(),
 1,
 '5 provincias',
 3,
 'chk003'),

-- 4
('Mejora en calidad de vida',
 'Se beneficiar�n directamente m�s de 2000 personas.',
 GETDATE(),
 1,
 '2000 personas beneficiadas',
 4,
 'chk004');
