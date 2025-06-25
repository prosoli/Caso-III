EXEC dbo.vpvSP_InsertDemographicByName
    @demotypeName    = 'Nacionalidad',
    @demosubtypeName = 'Costarricense',
    @userId          = 1,
    @personName      = 'Costarricense';

EXEC dbo.vpvSP_InsertDemographicByName
    @demotypeName    = 'Nacionalidad',
    @demosubtypeName = 'Costarricense',
    @userId          = 2,
    @personName      = 'Costarricense';

EXEC dbo.vpvSP_InsertDemographicByName
    @demotypeName    = 'Nacionalidad',
    @demosubtypeName = 'Costarricense',
    @userId          = 3,
    @personName      = 'Costarricense';

EXEC dbo.vpvSP_InsertDemographicByName
    @demotypeName    = 'Nacionalidad',
    @demosubtypeName = 'Costarricense',
    @userId          = 4,
    @personName      = 'Costarricense';

EXEC dbo.vpvSP_InsertDemographicByName
    @demotypeName    = 'Nacionalidad',
    @demosubtypeName = 'Costarricense',
    @userId          = 5,
    @personName      = 'Costarricense';




BEGIN TRY
EXEC dbo.vpvSP_AsignaRolUsuario
     @idUser       = 1,
     @roleName     = 'Ciudadano';
END TRY
BEGIN CATCH
    PRINT ERROR_MESSAGE();
END CATCH;

BEGIN TRY
EXEC dbo.vpvSP_AsignaRolUsuario
     @idUser       = 2,
     @roleName     = 'Ciudadano';
END TRY
BEGIN CATCH
    PRINT ERROR_MESSAGE();
END CATCH;

BEGIN TRY
EXEC dbo.vpvSP_AsignaRolUsuario
     @idUser       = 3,
     @roleName     = 'Ciudadano';
END TRY
BEGIN CATCH
    PRINT ERROR_MESSAGE();
END CATCH;

BEGIN TRY
EXEC dbo.vpvSP_AsignaRolUsuario
     @idUser       = 4,
     @roleName     = 'Ciudadano';
END TRY
BEGIN CATCH
    PRINT ERROR_MESSAGE();
END CATCH;

BEGIN TRY
EXEC dbo.vpvSP_AsignaRolUsuario
     @idUser       = 5,
     @roleName     = 'Ciudadano';
END TRY
BEGIN CATCH
    PRINT ERROR_MESSAGE();
END CATCH;

BEGIN TRY
EXEC dbo.vpvSP_AsignaRolUsuario
     @idUser       = 6,
     @roleName     = 'Ciudadano';
END TRY
BEGIN CATCH
    PRINT ERROR_MESSAGE();
END CATCH;





BEGIN TRY
INSERT INTO [dbo].[vpv_Voter] ([age], [idUser], [checksum])
VALUES 
(25, 1, CONVERT(varbinary(max), 'abc123')),
(26, 2, CONVERT(varbinary(max), 'def456')),
(27, 3, CONVERT(varbinary(max), 'ghi789')),
(25, 4, CONVERT(varbinary(max), 'abc123')),
(26, 5, CONVERT(varbinary(max), 'def456')),
(27, 6, CONVERT(varbinary(max), 'ghi789')),
(25, 7, CONVERT(varbinary(max), 'abc123')),
(26, 8, CONVERT(varbinary(max), 'def456')),
(27, 9, CONVERT(varbinary(max), 'ghi789')),
(25, 10, CONVERT(varbinary(max), 'abc123'));
END TRY
BEGIN CATCH
    PRINT ERROR_MESSAGE();
END CATCH;