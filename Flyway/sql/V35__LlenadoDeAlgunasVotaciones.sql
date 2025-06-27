INSERT INTO vpv_mfamethods (mfamethodid, name, description)
VALUES (1, 'huella digital', 'Tecnología de huella digital para autenticación MFA')
GO

INSERT INTO vpv_mfa (
    mfamethodid,
    userid,
    configdata,
    creationdate,
    lastupdate,
    enable,
    deleted
) VALUES
-- Usuario 1
(1, 1, CAST('config_data_user1' AS varbinary(max)), GETDATE(), GETDATE(), 1, 0),
-- Usuario 2
(1, 2, CAST('config_data_user2' AS varbinary(max)), GETDATE(), GETDATE(), 1, 0),
-- Usuario 3
(1, 3, CAST('config_data_user3' AS varbinary(max)), GETDATE(), GETDATE(), 1, 0),
-- Usuario 4
(1, 4, CAST('config_data_user4' AS varbinary(max)), GETDATE(), GETDATE(), 1, 0),
-- Usuario 5
(1, 5, CAST('config_data_user5' AS varbinary(max)), GETDATE(), GETDATE(), 1, 0);
GO

INSERT INTO vpv_identitydocs (
    referencevalue,
    referenceid,
    identitytypeid,
    identitystateid,
    name,
    field1,
    field2,
    temporary,
    creationdate,
    enable,
    expirationdate
) VALUES
-- Usuario 1: Cédula de identidad (tipo 1 = cédula jurídica)
(1, 'Userid', 1, 1, 'Cédula de identidad',    '1234567890',                'Lugar de emisión: San José',    0, GETDATE(), 1, DATEADD(YEAR,1,GETDATE())),
-- Usuario 2: Pasaporte (tipo 5)
(2, 'Userid', 5, 1, 'Pasaporte',              'P1234567',                  'País de emisión: Costa Rica',    0, GETDATE(), 1, DATEADD(YEAR,5,GETDATE())),
-- Usuario 3: Licencia de conducir (tipo 4)
(3, 'Userid', 4, 1, 'Licencia de conducir',   'LCR987654',                 'Categoría: A',                   0, GETDATE(), 1, DATEADD(YEAR,3,GETDATE())),
-- Usuario 4: Cédula de identidad (tipo 1)
(4, 'Userid', 1, 1, 'Cédula de identidad',    '0987654321',                'Lugar de emisión: Alajuela',     0, GETDATE(), 1, DATEADD(YEAR,1,GETDATE())),
-- Usuario 5: Pasaporte (tipo 5)
(5, 'Userid', 5, 1, 'Pasaporte',              'P7654321',                  'País de emisión: Costa Rica',    0, GETDATE(), 1, DATEADD(YEAR,5,GETDATE()));
GO

INSERT INTO vpv_identitydocs (
    referencevalue,
    referenceid,
    identitytypeid,
    identitystateid,
    name,
    field1,
    field2,
    temporary,
    creationdate,
    enable,
    expirationdate
) VALUES
-- Usuario 1: Cédula de identidad (tipo 1 = cédula jurídica)
(1, 'idUser', 1, 1, 'Cédula de identidad',    '1234567890',                'Lugar de emisión: San José',    0, GETDATE(), 1, DATEADD(YEAR,1,GETDATE())),
-- Usuario 2: Pasaporte (tipo 5)
(2, 'idUser', 5, 1, 'Pasaporte',              'P1234567',                  'País de emisión: Costa Rica',    0, GETDATE(), 1, DATEADD(YEAR,5,GETDATE())),
-- Usuario 3: Licencia de conducir (tipo 4)
(3, 'idUser', 4, 1, 'Licencia de conducir',   'LCR987654',                 'Categoría: A',                   0, GETDATE(), 1, DATEADD(YEAR,3,GETDATE())),
-- Usuario 4: Cédula de identidad (tipo 1)
(4, 'idUser', 1, 1, 'Cédula de identidad',    '0987654321',                'Lugar de emisión: Alajuela',     0, GETDATE(), 1, DATEADD(YEAR,1,GETDATE())),
-- Usuario 5: Pasaporte (tipo 5)
(5, 'idUser', 5, 1, 'Pasaporte',              'P7654321',                  'País de emisión: Costa Rica',    0, GETDATE(), 1, DATEADD(YEAR,5,GETDATE()));
GO

INSERT INTO vpv_Voter (age, idUser, checksum) VALUES
-- Voter para Usuario 1
(28, 1, CAST('checksum_user1' AS varbinary(max))),
-- Voter para Usuario 2
(34, 2, CAST('checksum_user2' AS varbinary(max))),
-- Voter para Usuario 3
(22, 3, CAST('checksum_user3' AS varbinary(max))),
-- Voter para Usuario 4
(30, 4, CAST('checksum_user4' AS varbinary(max))),
-- Voter para Usuario 5
(26, 5, CAST('checksum_user5' AS varbinary(max)));
GO

INSERT INTO vpv_BlindTokens (idToken, used, creacionDate, usedDate, checksum) VALUES
('A1111111-1111-1111-1111-111111111111', 1, GETDATE(), GETDATE(), CAST('checksum_vote1' AS varbinary(max))),
('B2222222-2222-2222-2222-222222222222', 1, GETDATE(), GETDATE(), CAST('checksum_vote2' AS varbinary(max))),
('C3333333-3333-3333-3333-333333333333', 1, GETDATE(), GETDATE(), CAST('checksum_vote3' AS varbinary(max))),
('D4444444-4444-4444-4444-444444444444', 1, GETDATE(), GETDATE(), CAST('checksum_vote4' AS varbinary(max))),
('E5555555-5555-5555-5555-555555555555', 1, GETDATE(), GETDATE(), CAST('checksum_vote5' AS varbinary(max)));
GO


INSERT INTO vpv_votingConfigurations (
    proposalVersionId,
    openDate,
    closeDate,
    creationDate,
    idStatusVoting,
    idVotingType,
    description,
    weight,
    checksum,
    idReminderType,
    idClosureTypes,
    idVotingReasons,
    executionPlanId,
    metricPlanId,
    projectReportId,
    sponsorAgreementId,
    governmentConditionId
) VALUES
-- Configuración para proposalVersionId = 1
(1,
 GETDATE(),
 DATEADD(DAY, 7, GETDATE()),
 GETDATE(),
 1,  -- idStatusVoting
 1,  -- idVotingType
 'Votación: Proyecto de reciclaje - Versión inicial',
 1,  -- weight
 CAST('cfg_checksum_1' AS varbinary(max)),
 1,  -- idReminderType
 1,  -- idClosureTypes
 1,  -- idVotingReasons
 NULL, NULL, NULL, NULL, NULL
),
-- Configuración para proposalVersionId = 2
(2,
 GETDATE(),
 DATEADD(DAY, 7, GETDATE()),
 GETDATE(),
 1,
 1,
 'Votación: Proyecto de reciclaje - Expansión regional',
 1,
 CAST('cfg_checksum_2' AS varbinary(max)),
 1,1,1,
 NULL, NULL, NULL, NULL, NULL
),
-- Configuración para proposalVersionId = 3
(3,
 GETDATE(),
 DATEADD(DAY, 7, GETDATE()),
 GETDATE(),
 1,
 1,
 'Votación: App salud rural - Versión inicial',
 1,
 CAST('cfg_checksum_3' AS varbinary(max)),
 1,1,1,
 NULL, NULL, NULL, NULL, NULL
),
-- Configuración para proposalVersionId = 4
(4,
 GETDATE(),
 DATEADD(DAY, 7, GETDATE()),
 GETDATE(),
 1,
 1,
 'Votación: App salud rural - Integración digital',
 1,
 CAST('cfg_checksum_4' AS varbinary(max)),
 1,1,1,
 NULL, NULL, NULL, NULL, NULL
),
-- Configuración para proposalVersionId = 5
(5,
 GETDATE(),
 DATEADD(DAY, 7, GETDATE()),
 GETDATE(),
 1,
 1,
 'Votación: Vigilancia comunitaria - Versión inicial',
 1,
 CAST('cfg_checksum_5' AS varbinary(max)),
 1,1,1,
 NULL, NULL, NULL, NULL, NULL
),
-- Configuración para proposalVersionId = 6
(6,
 GETDATE(),
 DATEADD(DAY, 7, GETDATE()),
 GETDATE(),
 1,
 1,
 'Votación: Vigilancia comunitaria - Conectividad en tiempo real',
 1,
 CAST('cfg_checksum_6' AS varbinary(max)),
 1,1,1,
 NULL, NULL, NULL, NULL, NULL
);
GO

INSERT INTO vpv_questions (
    idQuestionType,
    description,
    creationDate,
    checksum
) VALUES
-- Tipo 1: Única
(1, '¿Cuál es su fuente principal de agua potable?', GETDATE(), NULL),
-- Tipo 2: Múltiple
(2, '¿Qué medios utiliza para informarse diariamente? (Puede elegir varios)', GETDATE(), NULL),
-- Tipo 3: Booleana
(3, '¿Está de acuerdo con la implementación del sistema?', GETDATE(), NULL),
-- Tipo 4: Calificación
(4, 'Califique de 1 a 5 la calidad del servicio recibido.', GETDATE(), NULL),
-- Tipo 1: Única (nueva)
(1, '¿Cuál es su medio de transporte más frecuente?', GETDATE(), NULL);


-- 2)
OPEN SYMMETRIC KEY llavecedula
DECRYPTION BY PASSWORD = 'clavecedula';  -- Ajusta tu password real
GO

-- Pregunta 1: ¿Cuál es su fuente principal de agua potable?
INSERT INTO vpv_optionsQuestion (
    idOptionType, idQuestions, value, description, checksum, creationDate, enable, orderby
) VALUES
(1, 1,
 EncryptByKey(Key_GUID('llavecedula'), CAST('Acueducto municipal' AS varbinary(max))),
 EncryptByKey(Key_GUID('llavecedula'), CAST(CONVERT(varchar(23), GETDATE(), 121) AS varbinary(max))),
 EncryptByKey(Key_GUID('llavecedula'), CAST(CONVERT(varchar(23), GETDATE(), 121) + '|Acueducto municipal' AS varbinary(max))),
 GETDATE(), 1, 1),	
(1, 1,
 EncryptByKey(Key_GUID('llavecedula'), CAST('Pozo propio' AS varbinary(max))),
 EncryptByKey(Key_GUID('llavecedula'), CAST(CONVERT(varchar(23), GETDATE(), 121) AS varbinary(max))),
 EncryptByKey(Key_GUID('llavecedula'), CAST(CONVERT(varchar(23), GETDATE(), 121) + '|Pozo propio' AS varbinary(max))),
 GETDATE(), 1, 2),
(1, 1,
 EncryptByKey(Key_GUID('llavecedula'), CAST('Compra de agua' AS varbinary(max))),
 EncryptByKey(Key_GUID('llavecedula'), CAST(CONVERT(varchar(23), GETDATE(), 121) AS varbinary(max))),
 EncryptByKey(Key_GUID('llavecedula'), CAST(CONVERT(varchar(23), GETDATE(), 121) + '|Compra de agua' AS varbinary(max))),
 GETDATE(), 1, 3);

-- Pregunta 2: ¿Qué medios utiliza para informarse diariamente?
INSERT INTO vpv_optionsQuestion VALUES
(1, 2,
 EncryptByKey(Key_GUID('llavecedula'), CAST('Televisión' AS varbinary(max))),
 EncryptByKey(Key_GUID('llavecedula'), CAST(CONVERT(varchar(23), GETDATE(), 121) AS varbinary(max))),
 EncryptByKey(Key_GUID('llavecedula'), CAST(CONVERT(varchar(23), GETDATE(), 121) + '|Televisión' AS varbinary(max))),
 GETDATE(), 1, 1),
(1, 2,
 EncryptByKey(Key_GUID('llavecedula'), CAST('Radio' AS varbinary(max))),
 EncryptByKey(Key_GUID('llavecedula'), CAST(CONVERT(varchar(23), GETDATE(), 121) AS varbinary(max))),
 EncryptByKey(Key_GUID('llavecedula'), CAST(CONVERT(varchar(23), GETDATE(), 121) + '|Radio' AS varbinary(max))),
 GETDATE(), 1, 2),
(1, 2,
 EncryptByKey(Key_GUID('llavecedula'), CAST('Redes sociales' AS varbinary(max))),
 EncryptByKey(Key_GUID('llavecedula'), CAST(CONVERT(varchar(23), GETDATE(), 121) AS varbinary(max))),
 EncryptByKey(Key_GUID('llavecedula'), CAST(CONVERT(varchar(23), GETDATE(), 121) + '|Redes sociales' AS varbinary(max))),
 GETDATE(), 1, 3),
(1, 2,
 EncryptByKey(Key_GUID('llavecedula'), CAST('Prensa escrita' AS varbinary(max))),
 EncryptByKey(Key_GUID('llavecedula'), CAST(CONVERT(varchar(23), GETDATE(), 121) AS varbinary(max))),
 EncryptByKey(Key_GUID('llavecedula'), CAST(CONVERT(varchar(23), GETDATE(), 121) + '|Prensa escrita' AS varbinary(max))),
 GETDATE(), 1, 4);


OPEN SYMMETRIC KEY llavecedula
DECRYPTION BY PASSWORD = 'clavecedula';
GO
-- Pregunta 3: ¿Está de acuerdo con la implementación del sistema?
INSERT INTO vpv_optionsQuestion VALUES
(1, 3,
 EncryptByKey(Key_GUID('llavecedula'), CAST('Sí' AS varbinary(max))),
 EncryptByKey(Key_GUID('llavecedula'), CAST(CONVERT(varchar(23), GETDATE(), 121) AS varbinary(max))),
 EncryptByKey(Key_GUID('llavecedula'), CAST(CONVERT(varchar(23), GETDATE(), 121) + '|Sí' AS varbinary(max))),
 GETDATE(), 1, 1),
(1, 3,
 EncryptByKey(Key_GUID('llavecedula'), CAST('No' AS varbinary(max))),
 EncryptByKey(Key_GUID('llavecedula'), CAST(CONVERT(varchar(23), GETDATE(), 121) AS varbinary(max))),
 EncryptByKey(Key_GUID('llavecedula'), CAST(CONVERT(varchar(23), GETDATE(), 121) + '|No' AS varbinary(max))),
 GETDATE(), 1, 2);

-- Pregunta 4: Califique de 1 a 5 la calidad del servicio recibido
INSERT INTO vpv_optionsQuestion VALUES
(1, 4,
 EncryptByKey(Key_GUID('llavecedula'), CAST('1' AS varbinary(max))),
 EncryptByKey(Key_GUID('llavecedula'), CAST(CONVERT(varchar(23), GETDATE(), 121) AS varbinary(max))),
 EncryptByKey(Key_GUID('llavecedula'), CAST(CONVERT(varchar(23), GETDATE(), 121) + '|1' AS varbinary(max))),
 GETDATE(), 1, 1),
(1, 4,
 EncryptByKey(Key_GUID('llavecedula'), CAST('2' AS varbinary(max))),
 EncryptByKey(Key_GUID('llavecedula'), CAST(CONVERT(varchar(23), GETDATE(), 121) AS varbinary(max))),
 EncryptByKey(Key_GUID('llavecedula'), CAST(CONVERT(varchar(23), GETDATE(), 121) + '|2' AS varbinary(max))),
 GETDATE(), 1, 2),
(1, 4,
 EncryptByKey(Key_GUID('llavecedula'), CAST('3' AS varbinary(max))),
 EncryptByKey(Key_GUID('llavecedula'), CAST(CONVERT(varchar(23), GETDATE(), 121) AS varbinary(max))),
 EncryptByKey(Key_GUID('llavecedula'), CAST(CONVERT(varchar(23), GETDATE(), 121) + '|3' AS varbinary(max))),
 GETDATE(), 1, 3),
(1, 4,
 EncryptByKey(Key_GUID('llavecedula'), CAST('4' AS varbinary(max))),
 EncryptByKey(Key_GUID('llavecedula'), CAST(CONVERT(varchar(23), GETDATE(), 121) AS varbinary(max))),
 EncryptByKey(Key_GUID('llavecedula'), CAST(CONVERT(varchar(23), GETDATE(), 121) + '|4' AS varbinary(max))),
 GETDATE(), 1, 4),
(1, 4,
 EncryptByKey(Key_GUID('llavecedula'), CAST('5' AS varbinary(max))),
 EncryptByKey(Key_GUID('llavecedula'), CAST(CONVERT(varchar(23), GETDATE(), 121) AS varbinary(max))),
 EncryptByKey(Key_GUID('llavecedula'), CAST(CONVERT(varchar(23), GETDATE(), 121) + '|5' AS varbinary(max))),
 GETDATE(), 1, 5);

-- Pregunta 5: ¿Cuál es su medio de transporte más frecuente?
INSERT INTO vpv_optionsQuestion VALUES
(1, 5,
 EncryptByKey(Key_GUID('llavecedula'), CAST('Transporte público' AS varbinary(max))),
 EncryptByKey(Key_GUID('llavecedula'), CAST(CONVERT(varchar(23), GETDATE(), 121) AS varbinary(max))),
 EncryptByKey(Key_GUID('llavecedula'), CAST(CONVERT(varchar(23), GETDATE(), 121) + '|Transporte público' AS varbinary(max))),
 GETDATE(), 1, 1),
(1, 5,
 EncryptByKey(Key_GUID('llavecedula'), CAST('Vehículo propio' AS varbinary(max))),
 EncryptByKey(Key_GUID('llavecedula'), CAST(CONVERT(varchar(23), GETDATE(), 121) AS varbinary(max))),
 EncryptByKey(Key_GUID('llavecedula'), CAST(CONVERT(varchar(23), GETDATE(), 121) + '|Vehículo propio' AS varbinary(max))),
 GETDATE(), 1, 2),
(1, 5,
 EncryptByKey(Key_GUID('llavecedula'), CAST('Bicicleta o a pie' AS varbinary(max))),
 EncryptByKey(Key_GUID('llavecedula'), CAST(CONVERT(varchar(23), GETDATE(), 121) AS varbinary(max))),
 EncryptByKey(Key_GUID('llavecedula'), CAST(CONVERT(varchar(23), GETDATE(), 121) + '|Bicicleta o a pie' AS varbinary(max))),
 GETDATE(), 1, 3);
GO

INSERT INTO vpv_Voter (idVoter, age, idUser, checksum) VALUES
-- Voter 1
(1, 28, 1, CAST('checksum_voter1' AS varbinary(max))),
-- Voter 2
(2 ,35, 2, CAST('checksum_voter2' AS varbinary(max))),
-- Voter 3
(3 ,21, 3, CAST('checksum_voter3' AS varbinary(max))),
-- Voter 4
(4 ,42, 4, CAST('checksum_voter4' AS varbinary(max))),
-- Voter 5
(5 ,30, 5, CAST('checksum_voter5' AS varbinary(max)));
GO

INSERT INTO vpv_votingQuestions (
    idQuestion,
    idVotingConfig,
    enable,
    creationDate,
    checksum,
    orderBy
) VALUES
(1, 1, 1, GETDATE(), N'voting_q_1_checksum', 1),
(2, 2, 1, GETDATE(), N'voting_q_2_checksum', 2),
(3, 3, 1, GETDATE(), N'voting_q_3_checksum', 3),
(4, 4, 1, GETDATE(), N'voting_q_4_checksum', 4),
(5, 5, 1, GETDATE(), N'voting_q_5_checksum', 5);
GO

INSERT INTO vpv_Votes (
    idVote,
    idVotingQuestion,
    creationDate,
    idToken,
    idVoter,
    idOptionQuestion,
    checksum,
    idVotingConfig
) VALUES
(1, 1, GETDATE(), 'A1111111-1111-1111-1111-111111111111', 1, 9, CAST('vote1_checksum' AS varbinary(max)), 1),
(2, 1, GETDATE(), 'B2222222-2222-2222-2222-222222222222', 2, 10, CAST('vote2_checksum' AS varbinary(max)), 2),
(3, 2, GETDATE(), 'C3333333-3333-3333-3333-333333333333', 3, 11, CAST('vote3_checksum' AS varbinary(max)), 3),
(4, 2, GETDATE(), 'D4444444-4444-4444-4444-444444444444', 4, 12, CAST('vote4_checksum' AS varbinary(max)), 4),
(5, 3, GETDATE(), 'E5555555-5555-5555-5555-555555555555', 5, 13, CAST('vote5_checksum' AS varbinary(max)), 5);
GO