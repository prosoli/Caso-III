INSERT INTO dbo.vpv_VotingRuleTypes (name, enable)
VALUES
('Mayor�a simple', 1),
('Mayor�a calificada', 1),
('Unanimidad', 1);


INSERT INTO dbo.vpv_VotingRuleSubType (name, idUnitMeasure, enable)
VALUES
('Porcentaje', 1, 1),
('Cantidad', 2, 1);


INSERT INTO dbo.vpv_Rules (
    name, enable, idVotingRuleTypes, checksum, validation, amount_percentage, quantity, idVotingRuleSubType
)
VALUES
('Regla A', 1, 1, N'chkA', 1, 50.00, NULL, 1), -- Porcentaje
('Regla B', 1, 2, N'chkB', 1, NULL, 10, 2),     -- Cantidad
('Regla C', 1, 3, N'chkC', 0, 100.00, NULL, 1);

--PREGUNTAS Y OPCIONES
INSERT INTO [dbo].[vpv_questions] (
    [idQuestionType],
    [description],
    [creationDate],
    [checksum]
)
VALUES
-- Pregunta tipo �nica
(1, '�Cu�l es su fuente principal de agua potable?', GETDATE(), 'qchk001'),

-- Pregunta tipo M�ltiple
(2, '�Qu� beneficios considera que aporta este proyecto? (Seleccione todas las que apliquen)', GETDATE(), 'qchk002'),

-- Pregunta tipo Booleana
(3, '�Est� de acuerdo con implementar el proyecto en su comunidad?', GETDATE(), 'qchk003'),

-- Pregunta tipo Calificaci�n
(4, '�C�mo calificar�a el impacto social de este proyecto? (1 a 5)', GETDATE(), 'qchk004');

---- Opciones para la pregunta 1: �Cu�l es su fuente principal de agua potable?
INSERT INTO [dbo].[vpv_optionsQuestion] (
    [idOptionType], [idQuestions], [value], [description], [checksum], [creationDate], [enable], [orderby]
)
VALUES
(1, 1, '1', 'Acueducto municipal', 'optchk001', GETDATE(), 1, 1),
(1, 1, '2', 'Pozo propio', 'optchk002', GETDATE(), 1, 2),
(1, 1, '3', 'Cami�n cisterna', 'optchk003', GETDATE(), 1, 3),
(1, 1, '4', 'Otro', 'optchk004', GETDATE(), 1, 4);

-- Opciones para la pregunta 2: �Qu� beneficios considera que aporta este proyecto?
INSERT INTO [dbo].[vpv_optionsQuestion] (
    [idOptionType], [idQuestions], [value], [description], [checksum], [creationDate], [enable], [orderby]
)
VALUES
(1, 2, '1', 'Mejora en seguridad', 'optchk005', GETDATE(), 1, 1),
(1, 2, '2', 'Mayor cohesi�n social', 'optchk006', GETDATE(), 1, 2),
(1, 2, '3', 'Desarrollo econ�mico', 'optchk007', GETDATE(), 1, 3),
(1, 2, '4', 'Protecci�n ambiental', 'optchk008', GETDATE(), 1, 4);
