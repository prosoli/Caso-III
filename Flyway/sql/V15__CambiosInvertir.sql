-- ASIGNACION DE ROLES A LOS USUARIOS DE INVERSION Y CONFIGURACION DE VOTACIONES
--INVERSION - ROL CIUDADANO
EXEC dbo.vpvSP_AsignaRolUsuario
    @idUser = 1,
    @roleName = N'Ciudadano';

--INVERSION - ROL CIUDADANO
EXEC dbo.vpvSP_AsignaRolUsuario
    @idUser = 2,
    @roleName = N'Proponente';