use puravidabd

-- ======================================
-- INSERCIONES
-- ======================================

-- Inserciones vpv_nationality
INSERT INTO vpv_nationality (name)
VALUES	('Costarricense'),
		('Francés'),
		('Estadounidense'),
		('Mexicano'),
		('Guatemalteco'),
		('Peruano'),
		('Ecuatoriano'),
		('Chileno');

-- Inserciones para demografías 

-- Inserciones en vpv_demotypes

INSERT INTO vpv_demotype (name, description)
VALUES  ('Sexo', 'Identidad de género declarada por el ciudadano'),
		('Nacionalidad', 'País de ciudadanía o pertenencia del individuo'),
		('Provincia', 'Provincia de residencia en Costa Rica'),
		('Condición migratoria', 'Estado legal del ciudadano en el país'),
		('Nivel educativo', 'Nivel máximo de formación académica alcanzado'),
		('Área profesional', 'Campo principal de trabajo o estudio'),
		('Sector laboral', 'Tipo de actividad laboral o condición de empleo'),
		('Situación económica', 'Clasificación aproximada del ingreso o nivel socioeconómico'),
		('Idioma principal', 'Lengua hablada o comprendida principalmente'),
		('Grupo étnico', 'Autoidentificación cultural o étnica del ciudadano'),
		('Zona geográfica', 'Ubicación urbana o rural de residencia'),
		('Discapacidad', 'Condición de discapacidad física, sensorial o psicosocial'),
		('Religión', 'Sistema de creencias religiosas del ciudadano');

-- Inserciones en vpv_demosubtype

-- Subtipos para la demografía "Sexo"
INSERT INTO vpv_demosubtype (name)
VALUES 
('Masculino'),
('Femenino'),
('No binario'),
('Otro'),
('Prefiere no decir');

-- Subtipos para la demografía "Nacionalidad"
INSERT INTO vpv_demosubtype (name)
VALUES 
('Costarricense'),
('Nicaragüense'),
('Estadounidense'),
('Colombiano'),
('Otro');

-- Subtipos para la demografía "Provincia"
INSERT INTO vpv_demosubtype (name)
VALUES 
('San José'),
('Alajuela'),
('Cartago'),
('Heredia'),
('Guanacaste'),
('Puntarenas'),
('Limón');

-- Subtipos para la demografía "Condición migratoria"
INSERT INTO vpv_demosubtype (name)
VALUES 
('Nacional'),
('Residente permanente'),
('Residente temporal'),
('Refugiado'),
('Apátrida');

-- Subtipos para la demografía "Nivel educativo"
INSERT INTO vpv_demosubtype (name)
VALUES 
('Primaria incompleta'),
('Primaria completa'),
('Secundaria'),
('Técnico'),
('Universitario'),
('Posgrado'),
('Sin estudios');

-- Subtipos para la demografía "Área profesional"
INSERT INTO vpv_demosubtype (name)
VALUES 
('Salud'),
('Educación'),
('Tecnología'),
('Derecho'),
('Ingeniería'),
('Artes'),
('Administración'),
('Otro');

-- Subtipos para la demografía "Sector laboral"
INSERT INTO vpv_demosubtype (name)
VALUES 
('Público'),
('Privado'),
('Autónomo'),
('Desempleado'),
('Jubilado'),
('Estudiante');

-- Subtipos para la demografía "Situación económica"
INSERT INTO vpv_demosubtype (name)
VALUES 
('Bajo ingreso'),
('Ingreso medio'),
('Alto ingreso');

-- Subtipos para la demografía "Idioma principal"
INSERT INTO vpv_demosubtype (name)
VALUES 
('Español'),
('Inglés'),
('Chino'),
('Lengua indígena'),
('Otro');

-- Subtipos para la demografía "Grupo étnico"
INSERT INTO vpv_demosubtype (name)
VALUES 
('Mestizo'),
('Indígena'),
('Afrodescendiente'),
('Asiático'),
('Blanco'),
('Otro');

-- Subtipos para la demografía "Zona geográfica"
INSERT INTO vpv_demosubtype (name)
VALUES 
('Urbana'),
('Rural'),
('Mixta');

-- Subtipos para la demografía "Discapacidad"
INSERT INTO vpv_demosubtype (name)
VALUES 
('Ninguna'),
('Física'),
('Visual'),
('Auditiva'),
('Cognitiva'),
('Psicosocial');

-- Subtipos para la demografía "Religión"
INSERT INTO vpv_demosubtype (name)
VALUES 
('Católico'),
('Evangélico'),
('Musulmán'),
('Judío'),
('Agnóstico'),
('Ateo'),
('Otro');

-- STORE PROCEDURE para la inserción de 100 usuarios
-- Este script solo se debe ejecutar si ya se ejecutó primero el "InsercionesRegistros" sino, va a generar errores.

-- El script crea y guarda un store_procedure que se encarga de crear usuarios y claves para cada uno de forma que el usuario que tenga
-- id = 1 tenga una llave que sea "llave1" y con contraseña "clave1" de forma que se mantenga consistente y facilite las pruebas.
GO
CREATE OR ALTER PROCEDURE vpv_seed_encrypted_users
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    DECLARE @Names TABLE (
        RowNum    INT IDENTITY(1,1) PRIMARY KEY,
        FirstName NVARCHAR(50),
        LastName  NVARCHAR(50)
    );

    -- Insertar los 100 nombres
    INSERT INTO @Names (FirstName, LastName) VALUES 
    ('Luis',       'González'),
    ('Ana',        'Castillo'),
    ('Carlos',     'Rodríguez'),
    ('María',      'Fernández'),
    ('José',       'Hernández'),
    ('Carmen',     'Ramírez'),
    ('Jorge',      'López'),
    ('Sofía',      'Martínez'),
    ('Juan',       'Pérez'),
    ('Daniela',    'Sánchez'),
    ('Miguel',     'Vargas'),
    ('Valeria',    'Mora'),
    ('Diego',      'Quesada'),
    ('Gabriela',   'Castro'),
    ('Andrés',     'Villalobos'),
    ('Paula',      'Solano'),
    ('Ricardo',    'Salas'),
    ('Camila',     'Rojas'),
    ('Rafael',     'Aguilar'),
    ('Natalia',    'Herrera'),
    ('Víctor',     'Navarro'),
    ('Laura',      'Delgado'),
    ('Alejandro',  'Vega'),
    ('Carla',      'Cordero'),
    ('Fernando',   'Álvarez'),
    ('Juliana',    'Pacheco'),
    ('Jorge',      'Brenes'),
    ('Lucía',      'Espinoza'),
    ('Manuel',     'Acosta'),
    ('Elena',      'Gutiérrez'),
    ('Pablo',      'Silva'),
    ('Adriana',    'Calderón'),
    ('Javier',     'Jiménez'),
    ('Patricia',   'León'),
    ('Antonio',    'Morales'),
    ('Isabel',     'Torres'),
    ('Roberto',    'Ortiz'),
    ('Claudia',    'Duarte'),
    ('Enrique',    'Salazar'),
    ('Sebastián',  'Campos'),
    ('Marcela',    'Miranda'),
    ('Eduardo',    'Monge'),
    ('Verónica',   'Villalba'),
    ('Mario',      'Herrera'),
    ('Luisina',    'Brenes'),
    ('Emilio',     'Fonseca'),
    ('Diana',      'Guzmán'),
    ('Sergio',     'Castillo'),
    ('Luciana',    'Muñoz'),
    ('Tomás',      'Peralta'),
    ('Paola',      'Alfaro'),
    ('Silvia',     'Sandí'),
    ('Cristian',   'Porras'),
    ('Alejandra',  'Salas'),
    ('Fernando',   'Gómez'),
    ('Cecilia',    'Campos'),
    ('Omar',       'Chavarría'),
    ('Jessica',    'Blanco'),
    ('Ricardo',    'Castro'),
    ('Adrián',     'Mora'),
    ('Estefanía',  'Vargas'),
    ('Julio',      'Herrera'),
    ('Verónica',   'Rojas'),
    ('Mauricio',   'Vega'),
    ('Karla',      'Sánchez'),
    ('Álvaro',     'Ramírez'),
    ('Melody',     'Gómez'),
    ('Iván',       'Serrano'),
    ('Andrea',     'Bravo'),
    ('Nicolás',    'Rosales'),
    ('Valentina',  'Ruiz'),
    ('Félix',      'Araya'),
    ('Sonia',      'Carrillo'),
    ('Cristian',   'Ureña'),
    ('Rosa',       'Aguilar'),
    ('Gonzalo',    'Mora'),
    ('Lissette',   'Campos'),
    ('Damián',     'Espinoza'),
    ('Yessenia',   'Villalobos'),
    ('Leonel',     'Soto'),
    ('Priscila',   'Montero'),
    ('Brandon',    'Castro'),
    ('Fabiola',    'Calderón'),
    ('Jonathan',   'Sánchez'),
    ('Melissa',    'Jiménez'),
    ('Allan',      'Rodríguez'),
    ('Francisca',  'Vargas'),
    ('Katherine',  'Ortiz'),
    ('David',      'Noguerón'),
    ('Elizabeth',  'Álvarez'),
    ('Johan',      'Blanco'),
    ('Beatriz',    'Vargas');

    DECLARE @Total    INT = (SELECT COUNT(*) FROM @Names);
    DECLARE @i        INT = 1;
    DECLARE @llave    NVARCHAR(100);
    DECLARE @clave    NVARCHAR(100);
    DECLARE @nombre   NVARCHAR(50);
    DECLARE @apellido NVARCHAR(50);
    DECLARE @id_card  NVARCHAR(50);
    DECLARE @birth    DATETIME;
    DECLARE @sql      NVARCHAR(MAX);
	DECLARE @checkSum VARBINARY(255);
	DECLARE @numeroAleatorio BIGINT;
	DECLARE @numeroAleatorioTexto NVARCHAR(20);

	-- Crear la llave simétrica para 'card_id' con la contraseña 'clavecedula' solo una vez
    IF NOT EXISTS (SELECT 1 FROM sys.symmetric_keys WHERE name = 'llavecedula')
    BEGIN
        SET @sql = N'CREATE SYMMETRIC KEY llavecedula WITH ALGORITHM = AES_256 ENCRYPTION BY PASSWORD = ''clavecedula'';';
        EXEC sp_executesql @sql;
    END

    -- Abrir la llave 'llavecedula' al principio
    SET @sql = N'OPEN SYMMETRIC KEY llavecedula DECRYPTION BY PASSWORD = ''clavecedula'';';
    EXEC sp_executesql @sql;

    WHILE @i <= @Total
    BEGIN
        BEGIN TRY
            SELECT 
                @nombre   = FirstName,
                @apellido = LastName
            FROM @Names
            WHERE RowNum = @i;

            -- Generación de un número aleatorio de 9 dígitos
			SET @numeroAleatorio = ABS(CHECKSUM(NEWID())) % 900000000 + 100000000;
			SET @id_card = CONVERT(NVARCHAR(100), @numeroAleatorio);
            SET @birth = DATEADD(YEAR, - (20 + ABS(CHECKSUM(NEWID())) % 41), GETDATE());
            SET @llave = 'llave' + CAST(@i AS NVARCHAR);
            SET @clave = 'clave' + CAST(@i AS NVARCHAR);

            -- Eliminar clave si existe
            IF EXISTS (SELECT 1 FROM sys.symmetric_keys WHERE name = @llave)
            BEGIN
                SET @sql = N'DROP SYMMETRIC KEY ' + QUOTENAME(@llave);
                EXEC sp_executesql @sql;
            END

            -- Crear nueva clave
            SET @sql = N'CREATE SYMMETRIC KEY ' + QUOTENAME(@llave) + 
                       N' WITH ALGORITHM = AES_256 ' +
                       N' ENCRYPTION BY PASSWORD = ' + QUOTENAME(@clave, '''') + N';';
            EXEC sp_executesql @sql;

            -- Abrir clave
            SET @sql = N'OPEN SYMMETRIC KEY ' + QUOTENAME(@llave) + 
                       N' DECRYPTION BY PASSWORD = ' + QUOTENAME(@clave, '''') + N';';
            EXEC sp_executesql @sql;

            -- Encriptar datos
            DECLARE @enc_nombre   VARBINARY(MAX),
                    @enc_apellido VARBINARY(MAX),
                    @enc_id_card  VARBINARY(MAX);
            
            SET @enc_nombre   = EncryptByKey(Key_GUID(@llave), @nombre);
            SET @enc_apellido = EncryptByKey(Key_GUID(@llave), @apellido);
            SET @enc_id_card  = EncryptByKey(Key_GUID('llavecedula'), @id_card);

			SET @checkSum = HASHBYTES('SHA2_512', CONCAT(@enc_id_card, @enc_nombre, 'fbsdinaldkna3193'));

            -- Insertar usuario
            INSERT INTO vpv_Users (
                nationalityid, sexid, id_card, name, lastname,
                birth, registration_date, is_verified, enable, deleted
            ) VALUES (
                1, 1,  @enc_id_card, @enc_nombre, @enc_apellido,
                @birth, GETDATE(), 1, 1, 0
            );

            -- Registrar clave
            INSERT INTO vpv_encryptionkeys ([key], userid, creationDate, enable,  checksum)
            VALUES (@llave, SCOPE_IDENTITY(), GETDATE(), 1, @checkSum);

            -- Cerrar clave
            SET @sql = N'CLOSE SYMMETRIC KEY ' + QUOTENAME(@llave) + N';';
            EXEC sp_executesql @sql;
        END TRY
        BEGIN CATCH
            PRINT 'Error en registro ' + CAST(@i AS VARCHAR) + ': ' + ERROR_MESSAGE();
            
            -- Cerrar clave si está abierta
            IF EXISTS (
                SELECT 1 
                FROM sys.openkeys 
                WHERE key_guid = Key_GUID(@llave)
            )
            BEGIN
                SET @sql = N'CLOSE SYMMETRIC KEY ' + QUOTENAME(@llave) + N';';
                EXEC sp_executesql @sql;
            END
        END CATCH

        SET @i += 1;
    END

	SET @sql = N'CLOSE SYMMETRIC KEY llavecedula;';
    EXEC sp_executesql @sql

END;
GO

exec vpv_seed_encrypted_users
GO

-- Inserciones para los documentos, estas inserciones permiten que puedan trabajar con documentos
-- Se enfoca en los tipos, estados y demás
-- En la última sección, hay unas inserciones a documentos de identidad por si ocuparan para pruebas

-- IMPORTANTE
-- Como se cambió la tabla de vpv_identitydocs, si están usando base de datos antigua, ejecuten el siguiente comando, ahí está como comentario
-- para que no interfiera en caso que estén usando la nueva, pero en cualquier caso quitan los comentarios y la tabla estaría actualizada.
ALTER TABLE vpv_identitydocs DROP CONSTRAINT FK_vpv_identitydocs_vpv_Users;
GO
ALTER TABLE vpv_identitydocs DROP COLUMN IF EXISTS userid;
GO
ALTER TABLE vpv_identitydocs DROP COLUMN IF EXISTS entitiyid;
GO
ALTER TABLE vpv_identitydocs ADD referencevalue INT NULL;
GO
ALTER TABLE vpv_identitydocs ADD referenceid VARCHAR(25) NULL;
GO

-- Inserciones para vpv_identitystates (Estados de los documentos)
INSERT INTO vpv_identitystates (name, description)
VALUES	('Aprobado', 'El documento ha pasado la revisión correctamente y es valido en la plataforma'),
		('Rechazado', 'Los documentos no han pasado la revisión por falta de veracidad'),
		('En espera', 'El documento está siendo aún procesado');

-- Inserciones para vpv_identitytpe (Tipos de documentos en el sentido de lo que representan)
INSERT INTO vpv_identitytype (name, description, required, enable) 
VALUES	('Cédula Física', 'ID oficial personal CR.', 1, 1),
		('Cédula Jurídica', 'ID oficial empresas CR.', 1, 1),
		('DIMEX', 'ID Migratoria Extranjeros CR.', 1, 1),
		('Licencia de Conducir', 'Permiso legal para conducir.', 0, 1),
		('Pasaporte', 'ID internacional para viajes.', 0, 1),
		('Cert. Personería Jurídica', 'Acredita existencia y representantes de entidad.', 0, 1),
		('Poder Generalísimo', 'Máxima autoridad legal a persona.', 0, 1),
		('Contrato de Compraventa', 'Acuerdo legal transferencia bienes/servicios.', 0, 1),
		('Declaración de Impuestos', 'Reporte ingresos y cálculos fiscales.', 0, 1),
		('Estado de Cuenta Bancario', 'Registro de movimientos de cuenta bancaria.', 0, 1),
		('Cert. de Propiedad', 'Acredita titularidad de bien inmueble.', 0, 1),
		('Plano Catastrado', 'Representación gráfica de terreno.', 0, 1),
		('Contrato de Trabajo', 'Acuerdo legal entre empleador y empleado.', 0, 1),
		('Currículum Vitae (CV)', 'Resumen formación y experiencia laboral.', 0, 1),
		('Cert. Antecedentes Penales', 'Indica condenas judiciales previas.', 0, 1),
		('Título Académico', 'Certifica grado universitario o técnico.', 0, 1),
		('Póliza de Seguros', 'Contrato con cobertura y condiciones de seguro.', 0, 1),
		('Resolución Judicial', 'Fallo o decisión de un tribunal.', 0, 1),
		('Dictamen Legal', 'Opinión o análisis jurídico.', 0, 1),
		('Carné de Seguro Social', 'Afiliación a seguridad social.', 0, 1),
		('Factura Comercial', 'Comprobante de compraventa/servicios.', 0, 1),
		('Recibo de Pago', 'Comprobante de recepción de pago.', 0, 1),
		('Comprobante de Ingresos', 'Verifica fuente y monto de ingresos.', 0, 1),
		('Permiso de Construcción', 'Autorización para obra de construcción.', 0, 1),
		('Cert. de Nacimiento', 'Acredita el nacimiento de una persona.', 0, 1);

-- Inserción para vpv_docstate (Estado del documento en el sentido del archivo)
INSERT INTO vpv_docstates (name, description) 
VALUES	('Pendiente', 'Documento subido y en espera de revisión.'),
		('En Revisión', 'Documento siendo actualmente revisado por un agente.'),
		('Aprobado', 'Documento validado y aceptado.'),
		('Rechazado', 'Documento no cumple los requisitos y ha sido rechazado.'),
		('Vencido', 'Documento que ha superado su fecha de validez.');

-- Inserción para vpv_docstypes (Tipos de documentos en el sentido de la categoría)
INSERT INTO vpv_docstypes (name) 
VALUES	('Identificación'),
		('Legal'),
		('Financiero'),
		('Propiedad'),
		('Laboral'),
		('Académico'),
		('Certificación'),
		('Salud'),
		('Contrato'),
		('Regulatorio'),
		('Administrativo');

-- Inserción para vpv_formats (Formato de los documentos)
INSERT INTO vpv_formats (name) 
VALUES	('PDF'),
		('JPG'),
		('PNG'),
		('DOCX'),
		('XLSX'),
		('PPTX'),
		('TXT'),
		('CSV'),
		('XML'),
		('HTML'),
		('ZIP'); 

-- ==================================================
-- A partir de aquí se insertan algunos datos aleatorios para se puedan realizar pruebas, no es necesario ejecutarlos, pero en caso
-- de ejecutar, son 10 inserciones de pruebas para que cuenten los id's desde 1 al 10
-- ==================================================

INSERT INTO vpv_identitydocs (referencevalue, referenceid, identitytypeid, identitystateid, name, field1, field2, temporary, creationdate, enable, expirationdate)
VALUES	(1, 'USR-001', 1, 1, 'Cédula Física', 'Identificación personal', 'Carlos Abarca Mora', 0, GETDATE(), 1, '2030-01-15'),
		(2, 'EMP-002', 2, 1, 'Cédula Jurídica', 'Empresa registrada', 'TechSolutions S.A.', 0, GETDATE(), 1, '2026-12-31'),
		(3, 'MIG-003', 3, 3, 'DIMEX', 'Residente temporal', 'María González', 1, GETDATE(), 1, '2027-05-20'),
		(4, 'LIC-004', 4, 2, 'Licencia', 'Categoría B1', 'Juan Pérez', 0, GETDATE(), 1, '2028-11-30'),
		(5, 'PAS-005', 5, 1, 'Pasaporte', 'Válido 5 años', 'Ana Méndez', 0, GETDATE(), 1, '2030-06-15'),
		(6, 'POD-006', 7, 1, 'Poder', 'Representación legal', 'Fernando Gutiérrez', 0, GETDATE(), 1, '2029-03-10'),
		(7, 'FAC-007', 21, 1, 'Factura', 'Compra equipo', 'ElectroCorp', 0, GETDATE(), 1, '2026-02-28'),
		(8, 'CSS-008', 20, 1, 'Seguro Social', 'Afiliación CCSS', 'Roberto Cordero', 0, GETDATE(), 1, '2035-08-18'),
		(9, 'NAC-009', 25, 1, 'Cert. Nacimiento', 'Registro Civil', 'Sofía Rodríguez', 0, GETDATE(), 1, '2099-12-31'),
		(10, 'ANT-010', 15, 3, 'Antecedentes', 'Penales', 'Carlos Ramírez', 1, GETDATE(), 1, '2025-12-01');


INSERT INTO vpv_docs (identitydocsid, formatid, docstypeid, docstateid, archive, filename, date, enable, startdate, nextcheckdate, semantic_category, checksum)
VALUES	(1, 1, 1, 3, 0x25504446, 'cedula_carlos.pdf', GETDATE(), 1, GETDATE(), '2027-10-05', 'Cédula de Carlos Abarca Mora ID 1190668', CHECKSUM('Dato de prueba')),
		(2, 1, 1, 1, 0x25504446, 'empresa_tech.pdf', GETDATE(), 1, GETDATE(), '2026-05-20', 'Cédula jurídica TechSolutions CR S.A.', CHECKSUM('Dato de prueba')),
		(3, 2, 1, 3, 0xFFD8FFE0, 'dimex_maria.jpg', GETDATE(), 1, GETDATE(), '2025-12-31', 'DIMEX de María González Pérez', CHECKSUM('Dato de prueba')),
		(4, 3, 1, 2, 0x89504E47, 'licencia_juan.png', GETDATE(), 0, GETDATE(), '2028-03-15', 'Licencia B1 Juan Pérez', CHECKSUM('Dato de prueba')),
		(5, 1, 1, 1, 0x25504446, 'pasaporte_ana.pdf', GETDATE(), 1, GETDATE(), '2029-11-22', 'Pasaporte Ana Méndez', CHECKSUM('Dato de prueba')),
		(6, 4, 2, 1, 0x504B0304, 'poder_fernando.docx', GETDATE(), 1, GETDATE(), '2030-01-10', 'Poder notarial Fernando Gutiérrez', CHECKSUM('Dato de prueba')),
		(7, 1, 3, 3, 0x25504446, 'factura_electro.pdf', GETDATE(), 1, GETDATE(), '2024-12-31', 'Factura #001-2024 ElectroCorp', CHECKSUM('Dato de prueba')),
		(8, 1, 8, 1, 0x25504446, 'seguro_roberto.pdf', GETDATE(), 1, GETDATE(), '2035-08-18', 'CCSS Roberto Cordero', CHECKSUM('Dato de prueba')),
		(9, 2, 6, 1, 0xFFD8FFE0, 'nacimiento_sofia.jpg', GETDATE(), 1, GETDATE(), '2035-08-18', 'Cert. nacimiento Sofía Rodríguez', CHECKSUM('Dato de prueba')),
		(10, 1, 7, 2, 0x25504446, 'antecedentes_carlos.pdf', GETDATE(), 0, GETDATE(), '2025-06-30', 'Cert. antecedentes Carlos Ramírez', CHECKSUM('Dato de prueba'));
