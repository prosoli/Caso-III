-- Mensajes de error para vpvSP_CrearActualizarPropuesta

-- 50200: Usuario no registrado
IF EXISTS (SELECT 1 FROM sys.messages WHERE message_id = 50200 AND language_id = 1033)
    EXEC sp_dropmessage 50200, 'us_english';

EXEC sp_addmessage 50200, 16, N'Usuario no registrado.', 'us_english';

-- 50201: El usuario %d no tiene el rol requerido: Proponente
IF EXISTS (SELECT 1 FROM sys.messages WHERE message_id = 50201 AND language_id = 1033)
    EXEC sp_dropmessage 50201, 'us_english';

EXEC sp_addmessage 50201, 16, N'El usuario %d no tiene el rol requerido: Proponente', 'us_english';

-- 50202: Error general del SP con texto y número
IF EXISTS (SELECT 1 FROM sys.messages WHERE message_id = 50202 AND language_id = 1033)
    EXEC sp_dropmessage 50202, 'us_english';

EXEC sp_addmessage 50202, 16, N'vpvSP_CrearActualizarPropuesta falló: %s (Número %d)', 'us_english';


--Upsert propuesta

-- 50220: Éxito al hacer UPSERT de propuesta
IF EXISTS (SELECT 1 FROM sys.messages WHERE message_id = 50220 AND language_id = 1033)
    EXEC sp_dropmessage 50220, 'us_english';

EXEC sp_addmessage 
    @msgnum   = 50220, 
    @severity = 10, 
    @msgtext  = N'UpsertProposalWithVersion OK: proposalId=%d, versionId=%d',
    @lang     = 'us_english';

-- 50221: Error en UPSERT de propuesta
IF EXISTS (SELECT 1 FROM sys.messages WHERE message_id = 50221 AND language_id = 1033)
    EXEC sp_dropmessage 50221, 'us_english';

EXEC sp_addmessage 
    @msgnum   = 50221, 
    @severity = 16, 
    @msgtext  = N'UpsertProposalWithVersion ERROR: %s (CustomError=%d)',
    @lang     = 'us_english';
GO



-- 50240: Success message
IF EXISTS (SELECT 1 FROM sys.messages WHERE message_id = 50240 AND language_id = 1033)
    EXEC sp_dropmessage 50240, 'us_english';

EXEC sp_addmessage 
    @msgnum   = 50240, 
    @severity = 10, 
    @msgtext  = N'InsertVotingConfig completed successfully. Generated ID: %d.',
    @lang     = 'us_english';

-- 50241: Permission error
IF EXISTS (SELECT 1 FROM sys.messages WHERE message_id = 50241 AND language_id = 1033)
    EXEC sp_dropmessage 50241, 'us_english';

EXEC sp_addmessage 
    @msgnum   = 50241, 
    @severity = 16, 
    @msgtext  = N'Permission denied: missing required permission "%s" in context "%s".',
    @lang     = 'us_english';

-- 50242: Insert error
IF EXISTS (SELECT 1 FROM sys.messages WHERE message_id = 50242 AND language_id = 1033)
    EXEC sp_dropmessage 50242, 'us_english';

EXEC sp_addmessage 
    @msgnum   = 50242, 
    @severity = 16, 
    @msgtext  = N'Error in InsertVotingConfig: %s (Internal Code: %d).',
    @lang     = 'us_english';


-- 50240: Mensaje de éxito
IF EXISTS (SELECT 1 FROM sys.messages WHERE message_id = 50240 AND language_id = 3082)
    EXEC sp_dropmessage 50240, 'Spanish';

EXEC sp_addmessage 
    @msgnum   = 50240, 
    @severity = 10, 
    @msgtext  = N'InsertVotingConfig completado exitosamente. ID generado: %d.',
    @lang     = 'Spanish';

-- 50241: Error de permiso
IF EXISTS (SELECT 1 FROM sys.messages WHERE message_id = 50241 AND language_id = 3082)
    EXEC sp_dropmessage 50241, 'Spanish';

EXEC sp_addmessage 
    @msgnum   = 50241, 
    @severity = 16, 
    @msgtext  = N'Permiso denegado: falta el permiso requerido "%s" en el contexto "%s".',
    @lang     = 'Spanish';

-- 50242: Error de inserción
IF EXISTS (SELECT 1 FROM sys.messages WHERE message_id = 50242 AND language_id = 3082)
    EXEC sp_dropmessage 50242, 'Spanish';

EXEC sp_addmessage 
    @msgnum   = 50242, 
    @severity = 16, 
    @msgtext  = N'Error en InsertVotingConfig: %s (Código interno: %d).',
    @lang     = 'Spanish';


IF EXISTS (SELECT 1 FROM sys.messages WHERE message_id = 50262 AND language_id = 1033)
    EXEC sp_dropmessage 50262, 'us_english';

EXEC sp_addmessage 
   @msgnum   = 50262,
   @severity = 16,
   @msgtext  = N'Target population "%s" is not enabled or does not exist.',
   @lang     = 'us_english';

IF EXISTS (SELECT 1 FROM sys.messages WHERE message_id = 50262 AND language_id = 3082)
    EXEC sp_dropmessage 50262, 'Spanish';

EXEC sp_addmessage 
   @msgnum   = 50262,
   @severity = 16,
   @msgtext  = N'No existe población objetivo habilitada con nombre "%s".',
   @lang     = 'Spanish';







-- Invalid identity type
IF EXISTS (SELECT 1 FROM sys.messages WHERE message_id = 50263 AND language_id = 1033)
    EXEC sp_dropmessage 50263, 'us_english';

EXEC sp_addmessage  
    @msgnum   = 50263, 
    @severity = 16, 
    @msgtext  = N'Invalid identity type: %s', 
    @lang     = 'us_english';

-- Invalid identity status
IF EXISTS (SELECT 1 FROM sys.messages WHERE message_id = 50264 AND language_id = 1033)
    EXEC sp_dropmessage 50264, 'us_english';

EXEC sp_addmessage  
    @msgnum   = 50264, 
    @severity = 16, 
    @msgtext  = N'Invalid identity status: %s', 
    @lang     = 'us_english';



-- Mensaje: Tipo de identidad inválido
IF EXISTS (SELECT 1 FROM sys.messages WHERE message_id = 50263 AND language_id = 3082)
    EXEC sp_dropmessage 50263, 'Spanish';

EXEC sp_addmessage  
    @msgnum   = 50263, 
    @severity = 16, 
    @msgtext  = N'Tipo de identidad inválido: %s', 
    @lang     = 'Spanish';

-- Mensaje: Estado de identidad inválido
IF EXISTS (SELECT 1 FROM sys.messages WHERE message_id = 50264 AND language_id = 3082)
    EXEC sp_dropmessage 50264, 'Spanish';

EXEC sp_addmessage  
    @msgnum   = 50264, 
    @severity = 16, 
    @msgtext  = N'Estado de identidad inválido: %s', 
    @lang     = 'Spanish';

-- Invalid format
IF EXISTS (SELECT 1 FROM sys.messages WHERE message_id = 50265 AND language_id = 1033)
    EXEC sp_dropmessage 50265, 'us_english';
EXEC sp_addmessage  
    @msgnum   = 50265, 
    @severity = 16, 
    @msgtext  = N'Invalid format: %s.', 
    @lang     = 'us_english';

-- Invalid document type
IF EXISTS (SELECT 1 FROM sys.messages WHERE message_id = 50266 AND language_id = 1033)
    EXEC sp_dropmessage 50266, 'us_english';
EXEC sp_addmessage  
    @msgnum   = 50266, 
    @severity = 16, 
    @msgtext  = N'Invalid document type: %s.', 
    @lang     = 'us_english';

-- Invalid document status
IF EXISTS (SELECT 1 FROM sys.messages WHERE message_id = 50267 AND language_id = 1033)
    EXEC sp_dropmessage 50267, 'us_english';
EXEC sp_addmessage  
    @msgnum   = 50267, 
    @severity = 16, 
    @msgtext  = N'Invalid document status: %s.', 
    @lang     = 'us_english';


-- Formato inválido
IF EXISTS (SELECT 1 FROM sys.messages WHERE message_id = 50265 AND language_id = 3082)
    EXEC sp_dropmessage 50265, 'Spanish';
EXEC sp_addmessage  
    @msgnum   = 50265, 
    @severity = 16, 
    @msgtext  = N'El formato ingresado es inválido: %s.', 
    @lang     = 'Spanish';

-- Tipo de documento inválido
IF EXISTS (SELECT 1 FROM sys.messages WHERE message_id = 50266 AND language_id = 3082)
    EXEC sp_dropmessage 50266, 'Spanish';
EXEC sp_addmessage  
    @msgnum   = 50266, 
    @severity = 16, 
    @msgtext  = N'Tipo de documento inválido: %s.', 
    @lang     = 'Spanish';

-- Estado de documento inválido
IF EXISTS (SELECT 1 FROM sys.messages WHERE message_id = 50267 AND language_id = 3082)
    EXEC sp_dropmessage 50267, 'Spanish';
EXEC sp_addmessage  
    @msgnum   = 50267, 
    @severity = 16, 
    @msgtext  = N'Estado de documento inválido: %s.', 
    @lang     = 'Spanish';








-- 50268: statusVoting no existe
IF EXISTS (SELECT 1 FROM sys.messages WHERE message_id = 50268 AND language_id = 1033)
    EXEC sp_dropmessage 50268, 'us_english';
EXEC sp_addmessage 
    @msgnum   = 50268,
    @severity = 16,
    @msgtext  = N'The voting status "%s" is not registered in vpv_statusVoting.',
    @lang     = 'us_english';

-- 50269: votingType no existe
IF EXISTS (SELECT 1 FROM sys.messages WHERE message_id = 50269 AND language_id = 1033)
    EXEC sp_dropmessage 50269, 'us_english';
EXEC sp_addmessage 
    @msgnum   = 50269,
    @severity = 16,
    @msgtext  = N'The voting type "%s" is not registered in vpv_votingTypes.',
    @lang     = 'us_english';

-- 50270: reminderType no existe
IF EXISTS (SELECT 1 FROM sys.messages WHERE message_id = 50270 AND language_id = 1033)
    EXEC sp_dropmessage 50270, 'us_english';
EXEC sp_addmessage 
    @msgnum   = 50270,
    @severity = 16,
    @msgtext  = N'The reminder type "%s" is not registered in vpv_reminderTypes.',
    @lang     = 'us_english';

-- 50271: closureType no existe
IF EXISTS (SELECT 1 FROM sys.messages WHERE message_id = 50271 AND language_id = 1033)
    EXEC sp_dropmessage 50271, 'us_english';
EXEC sp_addmessage 
    @msgnum   = 50271,
    @severity = 16,
    @msgtext  = N'The closure type "%s" is not registered in vpv_ClosureTypes.',
    @lang     = 'us_english';

-- 50272: votingReasons no existe
IF EXISTS (SELECT 1 FROM sys.messages WHERE message_id = 50272 AND language_id = 1033)
    EXEC sp_dropmessage 50272, 'us_english';
EXEC sp_addmessage 
    @msgnum   = 50272,
    @severity = 16,
    @msgtext  = N'The voting reason "%s" is not registered in vpv_votingReasons.',
    @lang     = 'us_english';

-- 50268: statusVoting no existe
IF EXISTS (SELECT 1 FROM sys.messages WHERE message_id = 50268 AND language_id = 3082)
    EXEC sp_dropmessage 50268, 'Spanish';
EXEC sp_addmessage 
    @msgnum   = 50268,
    @severity = 16,
    @msgtext  = N'El estado de votación "%s" no está registrado en vpv_statusVoting.',
    @lang     = 'Spanish';

-- 50269: votingType no existe
IF EXISTS (SELECT 1 FROM sys.messages WHERE message_id = 50269 AND language_id = 3082)
    EXEC sp_dropmessage 50269, 'Spanish';
EXEC sp_addmessage 
    @msgnum   = 50269,
    @severity = 16,
    @msgtext  = N'El tipo de votación "%s" no está registrado en vpv_votingTypes.',
    @lang     = 'Spanish';

-- 50270: reminderType no existe
IF EXISTS (SELECT 1 FROM sys.messages WHERE message_id = 50270 AND language_id = 3082)
    EXEC sp_dropmessage 50270, 'Spanish';
EXEC sp_addmessage 
    @msgnum   = 50270,
    @severity = 16,
    @msgtext  = N'El tipo de recordatorio "%s" no está registrado en vpv_reminderTypes.',
    @lang     = 'Spanish';

-- 50271: closureType no existe
IF EXISTS (SELECT 1 FROM sys.messages WHERE message_id = 50271 AND language_id = 3082)
    EXEC sp_dropmessage 50271, 'Spanish';
EXEC sp_addmessage 
    @msgnum   = 50271,
    @severity = 16,
    @msgtext  = N'El tipo de cierre "%s" no está registrado en vpv_ClosureTypes.',
    @lang     = 'Spanish';

-- 50272: votingReasons no existe
IF EXISTS (SELECT 1 FROM sys.messages WHERE message_id = 50272 AND language_id = 3082)
    EXEC sp_dropmessage 50272, 'Spanish';
EXEC sp_addmessage 
    @msgnum   = 50272,
    @severity = 16,
    @msgtext  = N'La razón de votación "%s" no está registrada en vpv_votingReasons.',
    @lang     = 'Spanish';



-- 50273: schedule no existe
IF EXISTS (SELECT 1 FROM sys.messages WHERE message_id = 50273 AND language_id = 1033)
    EXEC sp_dropmessage 50273, 'us_english';
EXEC sp_addmessage 
    @msgnum   = 50273,
    @severity = 16,
    @msgtext  = N'The schedule "%s" is not registered in vpv_schedules.',
    @lang     = 'us_english';

-- 50274: processStatus no existe
IF EXISTS (SELECT 1 FROM sys.messages WHERE message_id = 50274 AND language_id = 1033)
    EXEC sp_dropmessage 50274, 'us_english';
EXEC sp_addmessage 
    @msgnum   = 50274,
    @severity = 16,
    @msgtext  = N'The process status "%s" is not registered in vpv_processStatus.',
    @lang     = 'us_english';

-- 50275: proposalType no existe
IF EXISTS (SELECT 1 FROM sys.messages WHERE message_id = 50275 AND language_id = 1033)
    EXEC sp_dropmessage 50275, 'us_english';
EXEC sp_addmessage 
    @msgnum   = 50275,
    @severity = 16,
    @msgtext  = N'The proposal type "%s" is not registered in vpv_proposalTypes.',
    @lang     = 'us_english';

-- 50273: schedule no existe (Español)
IF EXISTS (SELECT 1 FROM sys.messages WHERE message_id = 50273 AND language_id = 3082)
    EXEC sp_dropmessage 50273, 'Spanish';
EXEC sp_addmessage 
    @msgnum   = 50273,
    @severity = 16,
    @msgtext  = N'La agenda "%s" no está registrada en vpv_schedules.',
    @lang     = 'Spanish';

-- 50274: processStatus no existe (Español)
IF EXISTS (SELECT 1 FROM sys.messages WHERE message_id = 50274 AND language_id = 3082)
    EXEC sp_dropmessage 50274, 'Spanish';
EXEC sp_addmessage 
    @msgnum   = 50274,
    @severity = 16,
    @msgtext  = N'El estado de proceso "%s" no está registrado en vpv_processStatus.',
    @lang     = 'Spanish';

-- 50275: proposalType no existe (Español)
IF EXISTS (SELECT 1 FROM sys.messages WHERE message_id = 50275 AND language_id = 3082)
    EXEC sp_dropmessage 50275, 'Spanish';
EXEC sp_addmessage 
    @msgnum   = 50275,
    @severity = 16,
    @msgtext  = N'El tipo de propuesta "%s" no está registrado en vpv_proposalTypes.',
    @lang     = 'Spanish';
