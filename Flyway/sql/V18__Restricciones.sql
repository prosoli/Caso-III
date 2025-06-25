INSERT INTO [dbo].[vpv_votingRestrictionTypes] ([name], [description], [datatype], [enable])
VALUES
('Edad mínima', 'El votante debe tener al menos una edad específica.', 'int', 1),
('Región permitida', 'El votante debe estar en una región permitida.', 'varchar', 1),
('Correo institucional', 'El correo debe ser de dominio institucional.', 'varchar', 1),
('Solo estudiantes activos', 'Verifica si el votante es estudiante activo.', 'bit', 1),
('Hora de acceso', 'Define un rango horario válido para votar.', 'datetime', 1);

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
-- Edad mínima
(1, NULL, 'Solo pueden votar mayores de 18 años', '18', 1, GETDATE(), 1, NULL, NULL, N'chk1'),

-- Región permitida
(2, NULL, 'Votación exclusiva para San José', 'San José', 1, GETDATE(), 1, NULL, NULL, N'chk2'),

-- Correo institucional
(3, NULL, 'Correo debe contener dominio @tec.ac.cr', '@tec.ac.cr', 1, GETDATE(), 1, NULL, NULL, N'chk3'),

-- Solo estudiantes activos
(4, NULL, 'Verificación de estudiante activo mediante sistema académico', NULL, 1, GETDATE(), 1, NULL, NULL, N'chk4'),

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
('Reducción de consumo hídrico',
 'Acciones que promueven el uso eficiente del agua potable.',
 GETDATE(),
 1,
 '15% reducción esperada',
 1,
 'chk001'),

-- 2
('Extensión temporal del proyecto',
 'Duración estimada del proyecto según la fase de implementación.',
 GETDATE(),
 1,
 '24 meses',
 2,
 'chk002'),

-- 3
('Cobertura nacional',
 'El proyecto impactará al menos 5 provincias del país.',
 GETDATE(),
 1,
 '5 provincias',
 3,
 'chk003'),

-- 4
('Mejora en calidad de vida',
 'Se beneficiarán directamente más de 2000 personas.',
 GETDATE(),
 1,
 '2000 personas beneficiadas',
 4,
 'chk004');
