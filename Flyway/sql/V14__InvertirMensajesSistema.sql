-- Insert English (us_english) messages first

EXEC sp_addmessage 
    @msgnum = 50001, 
    @severity = 16, 
    @msgtext = N'The proposal to invest in has not been approved', 
    @lang = 'us_english';

EXEC sp_addmessage 
    @msgnum = 50002, 
    @severity = 16, 
    @msgtext = N'The proposal is not part of the crowdfunding program', 
    @lang = 'us_english';

EXEC sp_addmessage 
    @msgnum = 50003, 
    @severity = 16, 
    @msgtext = N'The exchange rate is incorrect', 
    @lang = 'us_english';

EXEC sp_addmessage 
    @msgnum = 50004, 
    @severity = 16, 
    @msgtext = N'The user does not have the necessary permissions', 
    @lang = 'us_english';

EXEC sp_addmessage 
    @msgnum = 50005, 
    @severity = 16, 
    @msgtext = N'The investment agreement type with the user is not valid', 
    @lang = 'us_english';

EXEC sp_addmessage 
    @msgnum = 50006, 
    @severity = 16, 
    @msgtext = N'The agreement type does not belong to a crowdfunding investment', 
    @lang = 'us_english';

EXEC sp_addmessage 
    @msgnum = 50007, 
    @severity = 16, 
    @msgtext = N'No payment has been registered in relation to the user''s investment', 
    @lang = 'us_english';

EXEC sp_addmessage 
    @msgnum = 50008, 
    @severity = 16, 
    @msgtext = N'The investment amount exceeds the project budget. Please contact IT', 
    @lang = 'us_english';
EXEC sp_addmessage 
    @msgnum = 50009, 
    @severity = 16, 
    @msgtext = N'The specified term does not exist', 
    @lang = 'us_english';

EXEC sp_addmessage 
    @msgnum = 50010, 
    @severity = 16, 
    @msgtext = N'The user does not have permissions', 
    @lang = 'us_english';

-- Insercion de errores en espanol
EXEC sp_addmessage 
    @msgnum = 50001, 
    @severity = 16, 
    @msgtext = N'La propuesta a invertir no ha sido aprobada', 
    @lang = 'Spanish'; 
EXEC sp_addmessage 
    @msgnum = 50002, 
    @severity = 16, 
    @msgtext = N'La propuesta no forma parte del crowfounding', 
    @lang = 'Spanish'; 
EXEC sp_addmessage 
    @msgnum = 50003, 
    @severity = 16, 
    @msgtext = N'El tipo de cambio no es correcto', 
    @lang = 'Spanish'; 
EXEC sp_addmessage 
    @msgnum = 50004, 
    @severity = 16, 
    @msgtext = N'El usuario no tiene permisos', 
    @lang = 'Spanish'; 
EXEC sp_addmessage 
    @msgnum = 50005, 
    @severity = 16, 
    @msgtext = N'El tipo acuerdo de inversion con el usuario no es correcto', 
    @lang = 'Spanish'; 
EXEC sp_addmessage 
    @msgnum = 50006, 
    @severity = 16, 
    @msgtext = N'El tipo de acuerdo no pertenece a una inversión de crowdfunding', 
    @lang = 'Spanish'; 
EXEC sp_addmessage 
    @msgnum = 50007, 
    @severity = 16, 
    @msgtext = N'No se ha registrado un pago en relacion a la inversion del usuario', 
    @lang = 'Spanish'; 
EXEC sp_addmessage 
    @msgnum = 50008, 
    @severity = 16, 
    @msgtext = N'El monto a invertir sobrepasa el plan del proyecto. Comuniquese con TI', 
    @lang = 'Spanish'; 
EXEC sp_addmessage 
    @msgnum = 50009, 
    @severity = 16, 
    @msgtext = N'El plazo indicado no existe', 
    @lang = 'Spanish'; 

EXEC sp_addmessage 
    @msgnum = 50010, 
    @severity = 16, 
    @msgtext = N'El usuario no tiene permisos', 
    @lang = 'Spanish'; 

