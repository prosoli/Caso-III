# 🎓 Caso #3 - 35%

### 🛠️ Temas Abordado:
El objetivo del proyecto es crear una plataforma de voto electrónico que sea accesible, segura y multifuncional. Esta herramienta permitirá a ciudadanos y organizaciones registrar propuestas de diversa índole, desde decisiones administrativas hasta proyectos municipales o reformas legales, y someterlas a votación de públicos específicos. Las votaciones serán parametrizables, con reglas claras y mecanismos de validación, alcanzando poblaciones segmentadas según diversos criterios como edad, ubicación, afiliación o profesión. Este sistema busca promover un entorno donde la voz ciudadana pueda incidir de manera ágil y directa en múltiples esferas.

El módulo de crowdfunding del sistema de voto electrónico tiene como objetivo impulsar la innovación y el emprendimiento en Costa Rica mediante un proceso participativo, transparente y digitalmente gobernado. Este módulo permite que ciudadanos y organizaciones presenten propuestas de proyectos con potencial empresarial, los cuales podrán ser evaluados y validados por entidades especializadas como aceleradoras, incubadoras o grupos de inversión. 

El Micitt debe presentar un prototipo de Voto Pura Vida a los poderes de la república enfocado en el caso de uso del crowdfunding para obtener el visto bueno con el que el proyecto irá avanzando.

---

## 👨‍🏫 Curso: Bases de Datos I  
**Ciclo:** I Semestre, 2025  
**Profesor:** Rodrigo Núñez  

---

## 👥 Estudiantes

| Nombre                     | Carné       |
|---------------------------|-------------|
|  Priscilla Romero Barquero | `2023332718` |
|  Carol Araya Conejo       | `2024089174` |
|  Daniel Sequeira Requenes | `2023282470` |
|  Carlos Abarca Mora       | `2024138701` |

---

## 📖 Indice

🌎 [Ir al Diseño de Base de Datos](#diseño-sql)

🌎 [Ir a Catálogo Base del sistema](#catalogo-base-del-sistema)

🌎 [Ir al Implementación del API](#implementación-del-api)

🌎 [Endpoints implementados por Stored Procedures](#endpoints-implementados-por-Stored-Procedures)

🌎 [Endpoints implementados por ORM](#endpoints-implementados-por-ORM)

🌎 [Ir al DashBoard de consulta](#dashboard-de-consulta)

---
## 📌 Diseño SQL
<details>
  <summary>Desplegar información</summary>

A continuación, se presenta el diseño físico de la base de datos, el cual ha sido implementado utilizando el motor de base de datos SQL Server, con el objetivo de garantizar la integridad, consistencia y seguridad de los datos. Esta elección permite conservar la información de forma estructurada y protegida, lo cual resulta fundamental dada la relevancia y sensibilidad de los datos gestionados en este sistema.

 📈[Diseño de la base de datos en SQL](./Diseño%20de%20la%20base%20de%20datos/Diagrama.pdf)

Por otro lado, se presenta el script de creación de la base de datos, con el cual se podrá generar la estructura completa del sistema, incluyendo tablas, relaciones, claves primarias y foráneas, así como restricciones necesarias para garantizar la integridad referencial y la organización lógica de los datos. Este script facilita la implementación del modelo en entornos de desarrollo, pruebas o producción.

🗄️[Script de creacion de la base de datos](./Diseño%20de%20la%20base%20de%20datos/scriptcreacion.sql)

  <details>
  <summary>Ver llenado de la base de datos</summary>

```sql
    
      colocarlo al final
```
</details>
</details>

---

## Catalogo Base del sistema
Este catálogo incluye, entre otros, datos sobre nacionalidades, provincias, niveles educativos, áreas profesionales, tipos de filtro, unidades de medida, zonas de impacto, estados de votación, y otros elementos que forman parte del modelo de datos general.

🔋[Ver llenado de la base de datos]()
 
### Configuración de propuestas
---

<details>
 <summary><b>vpv_proposalViewTypes</b></summary>
  
```sql
INSERT INTO [dbo].[vpv_proposalViewTypes] ([name], [enable])
VALUES
    ('Gráfica de barras', 1),
    ('Gráfica de líneas', 1),
    ('Comparativa anual', 1),
    ('Indicadores KPI', 1),
    ('Resumen ejecutivo', 1),
    ('Mapa de calor', 1),
    ('Tabla dinámica', 1)
```
</details>


  
<details>
 <summary><b>vpv_proposalTypes</b></summary>
  
```sql
INSERT INTO [dbo].[vpv_proposalTypes] ([name], [description], [enable])
VALUES
    ('Proyecto de ley', 'Propuesta para crear, modificar o derogar una ley vigente a través del proceso legislativo.', 1),
    ('Propuesta tecnológica', 'Iniciativa para implementar soluciones digitales o herramientas tecnológicas en instituciones o comunidades.', 1),
    ('Propuesta ambiental', 'Iniciativas enfocadas en la protección del medio ambiente, sostenibilidad o mitigación del cambio climático.', 1),
    ('Propuesta educativa', 'Proyectos dirigidos a mejorar el acceso, calidad o cobertura de la educación.', 1),
    ('Propuesta de salud pública', 'Acciones para fortalecer el sistema de salud, campañas preventivas o mejora de servicios médicos.', 1),
    ('Propuesta de infraestructura', 'Obras públicas como carreteras, puentes, edificios comunitarios o redes eléctricas.', 1),
    ('Propuesta social', 'Propuestas orientadas a mejorar la inclusión, equidad, y condiciones sociales de poblaciones vulnerables.', 1),
    ('Propuesta cultural', 'Proyectos para preservar, difundir o desarrollar el patrimonio y actividades culturales.', 1),
    ('Propuesta económica', 'Acciones dirigidas a estimular la economía local, emprendimientos o generación de empleo.', 1),
    ('Propuesta deportiva', 'Fomento de la actividad física, apoyo a ligas deportivas o construcción de instalaciones.', 1),
    ('Propuesta de seguridad', 'Medidas para prevenir el delito, mejorar la vigilancia o implementar tecnologías de seguridad.', 1),
    ('Propuesta participativa', 'Mecanismos que promuevan la participación ciudadana o procesos de gobernanza abierta.', 1),
    ('Propuesta piloto', 'Prueba controlada de nuevas ideas antes de su implementación general.', 1),
    ('Propuesta experimental', 'Iniciativas que exploran enfoques no convencionales o innovadores.', 1)INSERT INTO [dbo].[vpv_proposalTypes] ([name], [description], [enable])
VALUES
    ('Proyecto de ley', 'Propuesta para crear, modificar o derogar una ley vigente a través del proceso legislativo.', 1),
    ('Propuesta tecnológica', 'Iniciativa para implementar soluciones digitales o herramientas tecnológicas en instituciones o comunidades.', 1),
    ('Propuesta ambiental', 'Iniciativas enfocadas en la protección del medio ambiente, sostenibilidad o mitigación del cambio climático.', 1),
    ('Propuesta educativa', 'Proyectos dirigidos a mejorar el acceso, calidad o cobertura de la educación.', 1),
    ('Propuesta de salud pública', 'Acciones para fortalecer el sistema de salud, campañas preventivas o mejora de servicios médicos.', 1),
    ('Propuesta de infraestructura', 'Obras públicas como carreteras, puentes, edificios comunitarios o redes eléctricas.', 1),
    ('Propuesta social', 'Propuestas orientadas a mejorar la inclusión, equidad, y condiciones sociales de poblaciones vulnerables.', 1),
    ('Propuesta cultural', 'Proyectos para preservar, difundir o desarrollar el patrimonio y actividades culturales.', 1),
    ('Propuesta económica', 'Acciones dirigidas a estimular la economía local, emprendimientos o generación de empleo.', 1),
    ('Propuesta deportiva', 'Fomento de la actividad física, apoyo a ligas deportivas o construcción de instalaciones.', 1),
    ('Propuesta de seguridad', 'Medidas para prevenir el delito, mejorar la vigilancia o implementar tecnologías de seguridad.', 1),
    ('Propuesta participativa', 'Mecanismos que promuevan la participación ciudadana o procesos de gobernanza abierta.', 1),
    ('Propuesta piloto', 'Prueba controlada de nuevas ideas antes de su implementación general.', 1),
    ('Propuesta experimental', 'Iniciativas que exploran enfoques no convencionales o innovadores.', 1)
```
</details>

  


<details>
 <summary><b>vpv_processStatus</b></summary>
  
```sql
INSERT INTO [dbo].[vpv_processStatus] ([name])
VALUES
    ('Activo'),
    ('Inactivo'),
    ('En proceso'),
    ('Rechazado'),
    ('Aprobado'),
    ('Pendiente de revisión'),
    ('En validación'),
    ('Observado'),
    ('Completado'),
    ('Cancelado'),
    ('Archivado'),
    ('Publicado')
```
</details>

  
<details>
 <summary><b>vpv_governmentEntities</b></summary>
  
```sql
INSERT INTO [dbo].[vpv_governmentEntities] ([name], [acronym], [enable]) 
VALUES
    ('Caja Costarricense de Seguro Social', 'CCSS', 1),
    ('Ministerio de Educación Pública', 'MEP', 1),
    ('Ministerio de Hacienda', 'MH', 1),
    ('Instituto Costarricense de Electricidad', 'ICE', 1),
    ('Ministerio de Obras Públicas y Transportes', 'MOPT', 1),
    ('Ministerio de Salud', 'MS', 1),
    ('Instituto Nacional de Seguros', 'INS', 1),
    ('Instituto Costarricense de Turismo', 'ICT', 1),
    ('Tribunal Supremo de Elecciones', 'TSE', 1),
    ('Asamblea Legislativa', 'AL', 1),
    ('Universidad de Costa Rica', 'UCR', 1),
    ('Universidad Nacional', 'UNA', 1),
    ('Instituto Nacional de Aprendizaje', 'INA', 1),
    ('Ministerio de Justicia y Paz', 'MJP', 1),
    ('Ministerio de Ciencia, Innovación, Tecnología y Telecomunicaciones', 'MICITT', 1)

```
</details>


<details>
 <summary><b>vpv_governmentBenefits</b></summary>
  
```sql
INSERT INTO [dbo].[vpv_governmentBenefits] ([benefit], [enable], [dataType])
VALUES
    ('Incentivo económico de la CCSS', 1, 'decimal'),
    ('Subsidio mensual de vivienda', 1, 'decimal'),
    ('Tener al menos 10 empleados en el proyecto', 1, 'integer'),
    ('Número de adultos mayores beneficiados', 1, 'integer'),
    ('Acceso gratuito a servicios de salud primaria', 1, 'bit'),
    ('Participación en capacitaciones del INA', 1, 'bit'),
    ('Descuento en servicios eléctricos del ICE', 1, 'decimal'),
    ('Cantidad de estudiantes beneficiados por beca', 1, 'integer'),
    ('Disponibilidad de servicio de transporte', 1, 'bit'),
    ('Monto asignado por el MEP para materiales', 1, 'decimal'),
    ('Alquiler subsidiado por el IMAS', 1, 'decimal'),
    ('Participación en programa de salud preventiva', 1, 'bit'),
    ('Cantidad de computadoras entregadas', 1, 'integer'),
    ('Cobertura de seguro por el INS', 1, 'bit'),
    ('Reducción de tarifas municipales', 1, 'decimal')

```
</details>


<details>
 <summary><b>vpv_sponsornGroupTypes</b></summary>
  
```sql
INSERT INTO [dbo].[vpv_sponsornGroupTypes] ([name], [enable])
VALUES
    ('Incubadora de empresas', 1),
    ('Aceleradora de negocios', 1),
    ('Grupo de inversión', 1),
    ('Organización sin fines de lucro', 1),
    ('Agencia de desarrollo regional', 1),
    ('Banco de desarrollo', 1),
    ('Cámara empresarial', 1),
    ('Cooperativa de apoyo', 1),
    ('Organismo internacional', 1),
    ('Red de mentores', 1)
```
</details>


<details>
 <summary><b>vpv_sponsorGroups</b></summary>
  
```sql
INSERT INTO [dbo].[vpv_sponsorGroups] 
([name], [description], [enable], [deleted], [sponsorGroupTypeId])
VALUES
('ParqueTec', 'SponsorGroup', 1, 0, 1),        
('AUGE UCR', 'SponsorGroup', 1, 0, 2),         
('Carao Ventures', 'SponsorGroup', 1, 0, 3),   
('Parque La Libertad', 'SponsorGroup', 1, 0, 4),
('PROCOMER', 'SponsorGroup', 1, 0, 5),         
('GNPlus', 'SponsorGroup', 1, 0, 6),           
('Fundación CRUSA', 'SponsorGroup', 1, 0, 7),  
('InnovaAP', 'SponsorGroup', 1, 0, 8),         
('Impact Hub SJ', 'SponsorGroup', 1, 0, 9),    
('CONICIT', 'SponsorGroup', 1, 0, 10)
```
</details>



<details>
 <summary><b>vpv_sponsorAgrementsType</b></summary>
  
```sql
INSERT INTO [dbo].[vpv_sponsorAgrementsType] ([name], [description], [dataType])
VALUES
('Crowdfunding de donación', 'Aportes voluntarios sin retorno económico directo', 'bit'),
('Crowdfunding de recompensa', 'Aportes a cambio de un beneficio simbólico o material', 'bit'),
('Crowdfunding de préstamo', 'Financiamiento con obligación de reembolso con o sin intereses', 'decimal'),
('Crowdfunding de inversión', 'Participación a cambio de una parte del capital o utilidades', 'integer'),
('Apoyo con producto o servicio', 'El patrocinador entrega bienes o servicios en lugar de dinero', 'bit')
```
</details>

### Configuración General 
---

<details>
 <summary><b>vpv_schedules</b></summary>
  
```sql
CREATE OR ALTER PROCEDURE dbo.vpvSP_LlenarSchedules
AS
BEGIN
    DECLARE @horarios TABLE (
        name NVARCHAR(50),
        recurrencyType NVARCHAR(50),
        repetition INT
    );


    INSERT INTO @horarios (name, recurrencyType, repetition)
    VALUES 
        ('Cada semana', 'semanal', 1),
        ('Cada mes', 'mensual', 1),
        ('Cada 15 días', 'semanal', 2);

    DECLARE @i INT = 1;
    DECLARE @mes INT;
    DECLARE @dia INT;
    DECLARE @endDate DATETIME;


    WHILE @i <= 13
    BEGIN
        SET @mes = FLOOR(RAND(CHECKSUM(NEWID())) * 8) + 5;  
        SET @dia = FLOOR(RAND(CHECKSUM(NEWID())) * 30) + 1; 
        SET @endDate = DATEFROMPARTS(2025, @mes, @dia);

        INSERT INTO [dbo].[vpv_schedules] ([name], [recurrencyType], [repetition], [endType], [endDate])
        SELECT name, recurrencyType, repetition, 'NA', @endDate
        FROM @horarios;

        SET @i += 1;
    END
END;
GO


EXEC dbo.vpvSP_LlenarSchedules;
```
</details>



<details>
 <summary><b>vpv_transTypes</b></summary>
  
```sql
INSERT INTO [dbo].[vpv_transTypes] 
([name], [deleted], [transTypeId])
VALUES
    ( 'Credit', 0,1),            
    ( 'Debit', 0,2),              
    ( 'Refund', 0,3),           
    ( 'Manual Adjustment', 0, 4),  
    ( 'Chargeback', 0,5),            
    ( 'Deposit', 0,6),               
    ( 'Withdrawal', 0,7),            
    ( 'Transfer', 0,8)
```
</details>



<details>
 <summary><b>vpv_transSubTypes</b></summary>
  
```sql
INSERT INTO [dbo].[vpv_transSubTypes] ([name], [deleted])
VALUES
    ('Aporte voluntario', 0),
    ('Compra de recompensa', 0),
    ('Reembolso propuesta cancelada', 0),
    ('Aprobación de financiamiento', 0),
    ('Pago de propuesta', 0),
    ('Activación de beneficio', 0),
    ('Crédito institucional', 0),
    ('Cancelación de participación', 0),
    ('Inversión de Usuario', 0),
	('Inversión de Entidad', 0),
	('Inversión de Sponsor', 0),
	('Inversion a un plan',0)
```
</details>



<details>
 <summary><b>vpv_logSeverity</b></summary>
  
```sql
INSERT INTO [dbo].vpv_logSeverity([name])
VALUES
	('Low'),
	('Medium'),
	('High'),
	('Critical'),
	('Informational');
```
</details>



<details>
 <summary><b>vpv_logsSources</b></summary>
  
```sql
INSERT INTO [dbo].vpv_logsSources([name])
VALUES
	('System'),
	('Application'),
	('Database'),
	('Security'),
	('User Activity'),
	('Network'),
	('API'),
	('Payment Gateway'),
	('Error Handler'),
	('Authentication'),
	('File System');

```
</details>



<details>
 <summary><b>vpv_logTypes</b></summary>
  
```sql
INSERT INTO [dbo].vpv_logTypes([name])
VALUES
	('Error'),
	('Warning'),
	('Info'),
	('Debug'),
	('Critical'),
	('Audit'),
	('Security'),
	('Transaction'),
	('Performance'),
	('Access');

```
</details>



<details>
 <summary><b>vpv_currencies</b></summary>
  
```sql
INSERT INTO dbo.vpv_currencies(currencyId, name, acronym, symbol)--
VALUES (1, 'Colón Costa Rica', 'CRC', '¢'),(2, 'Dólar Estados Unidos', 'USD', '$');

```
</details>



<details>
 <summary><b>vpv_exchangeRates</b></summary>
  
```sql
INSERT INTO dbo.vpv_exchangeRates
	(startDate,    endDate,      exchangeRate, enable, currentExchange, currencyId)
VALUES
	  ('2025-06-14','2025-06-14', 0.00195,       1,      0,                   1),
	  ('2025-06-15','2025-06-15', 0.0019493,     1,      0,                   1),
	  ('2025-06-16','2025-06-16', 0.0019896,     1,      0,                   1),
	  ('2025-06-17','2025-06-17', 0.00199,       1,      0,                   1),
	  ('2025-06-18','2025-06-18', 0.00199,       1,      1,                   1);

```
</details>




<details>
 <summary><b>vpv_paymentMethods</b></summary>
  
```sql
INSERT INTO [dbo].[vpv_paymentMethods] ([name], [apiURL], [secretKey], [key], [enable])
VALUES
	('PayPal', 'https://api.paypal.com/v1/', 0x5A3D4C6F2A7B9C5F1234567890ABCDE1234567890ABCDEF0123456789ABCDEF, 0x7F5A9B6C5D7E1F23334567890ABCDE1234567890ABCDEF0123456789ABCDE, 1),
	('Stripe', 'https://api.stripe.com/v1/', 0x8F3A7B9C1D2E3F9A1234567890ABCDE1234567890ABCDEF0123456789ABCDE, 0x9B3D6C2F1D8E7A234567890ABCDE1234567890ABCDEF0123456789ABCDE, 1),
	('MercadoPago', 'https://api.mercadopago.com/v1/', 0x2D3A5F9B1C7E9D3A567890ABCDE1234567890ABCDEF0123456789ABCDE, 0x4F2A8D6E3B9F0A234567890ABCDE1234567890ABCDEF0123456789ABCDE, 1),
	('RappiPay', 'https://api.rappipay.com/v1/', 0x1A3D4E5F2B8C9D3A567890ABCDE1234567890ABCDEF0123456789ABCDE, 0x5E7A9D2B6C3F4A1234567890ABCDE1234567890ABCDEF0123456789ABCDE, 1),
	('Apple Pay', 'https://api.apple.com/v1/', 0x0B5D6F3A2C8E9D234567890ABCDE1234567890ABCDEF0123456789ABCDE, 0x9C7F2A3D8B5E1F9A234567890ABCDE1234567890ABCDEF0123456789ABCDE, 1);

```
</details>



<details>
 <summary><b>vpv_availablePaymentMethods</b></summary>
  
```sql
CREATE OR ALTER PROCEDURE dbo.vpvSP_InsertarPaymentMethods
AS
BEGIN
    DECLARE @i INT = 1;
    DECLARE @name VARCHAR(55);
    DECLARE @methodId INT;
    DECLARE @token VARCHAR(256);
    DECLARE @expTokenDate DATETIME;
    DECLARE @maskAccount NVARCHAR(MAX);
    DECLARE @callbackURL NVARCHAR(200);
    DECLARE @configurationDetails NVARCHAR(MAX);
    DECLARE @refreshToken VARBINARY(256);

	-- Cursor para recorrer los métodos de pago existentes, recibiendo loda daros de la consulta select de la tabla que contiene los metodos de pago
    DECLARE method_cursor CURSOR FOR
        SELECT [name], [methodId]
        FROM [dbo].[vpv_paymentMethods]; 

    OPEN method_cursor;
    FETCH NEXT FROM method_cursor INTO @name, @methodId;

    WHILE @i <= 15
    BEGIN
        SET @token = CONVERT(VARCHAR(256), NEWID());
        SET @expTokenDate = DATEADD(DAY, @i * 30, GETDATE());
        SET @maskAccount = CONCAT('****', RIGHT('000' + CAST((1000 + @i * 7) AS NVARCHAR), 4));
        SET @callbackURL = CONCAT('https://vpv.example.com/callback/method', @i);
        SET @configurationDetails = CONCAT('{"currency":"USD", "method":"', @name, '"}');
        SET @refreshToken = CAST(HASHBYTES('SHA2_256', @token) AS VARBINARY(256));

        INSERT INTO [dbo].[vpv_availablePaymentMethods]
           ([name], [token], [expTokenDate], [maskAccount], [callbackURL], [configurationDetails], [refreshToken], [methodId])
        VALUES
           (@name, @token, @expTokenDate, @maskAccount, @callbackURL, @configurationDetails, @refreshToken, @methodId);

        SET @i += 1;

        FETCH NEXT FROM method_cursor INTO @name, @methodId;

        IF @@FETCH_STATUS <> 0
        BEGIN
            CLOSE method_cursor;
            OPEN method_cursor;
            FETCH NEXT FROM method_cursor INTO @name, @methodId;
        END
    END

	-- Cerrar y liberar el cursor
    CLOSE method_cursor;
    DEALLOCATE method_cursor;
END;
GO


EXEC dbo.vpvSP_InsertarPaymentMethods;

```
</details>



<details>
 <summary><b>vpv_founds</b></summary>
  
```sql
INSERT INTO [dbo].[vpv_founds]
    ([name])
VALUES ('Dinero');
```
</details>


### Configuracion de Roles y Permisos



<details>
<summary><b>vpv_PermissionResource</b></summary>

```sql
INSERT INTO [dbo].[vpv_PermissionResource] (
    id_permissionResource,
    name,
    creationDate,
    updatedAt,
    enabled,
    deleted
)
SELECT
    ROW_NUMBER() OVER (ORDER BY t.name) + ISNULL((
        SELECT MAX(id_permissionResource) FROM [dbo].[vpv_PermissionResource]
    ), 0) AS id_permissionResource,
    t.name AS name,
    GETDATE() AS creationDate,
    GETDATE() AS updatedAt,
    1 AS enabled,   -- Habilitado por defecto
    0 AS deleted    -- No eliminado por defecto
FROM sys.tables t;
``` 
</details>


<details>
<summary><b>vpv_PermissionAction</b></summary>

```sql
INSERT INTO [dbo].[vpv_PermissionAction] (
    id_permissionAction,
    name,
    descripcion
)
VALUES
    (1, 'SELECT', 'Permite consultar datos de una tabla'),
    (2, 'INSERT', 'Permite insertar nuevos registros en una tabla'),
    (3, 'UPDATE', 'Permite modificar registros existentes en una tabla'),
    (4, 'DELETE', 'Permite eliminar registros de una tabla');
``` 
</details>


<details>
<summary><b>vpv_Permissions</b></summary>

```sql
INSERT INTO [dbo].[vpv_Permissions] (
    id_permission,
    id_permisionResource,
    id_permissionAction,
    descripcion,
    creationDate,
    updatedAt,
    enabled,
    deleted,
    checksum
)
SELECT
    ROW_NUMBER() OVER (ORDER BY r.id_permissionResource, a.id_permissionAction) +
        ISNULL((SELECT MAX(id_permission) FROM [dbo].[vpv_Permissions]), 0) AS id_permission,
    r.id_permissionResource,
    a.id_permissionAction,
    CONCAT('Permiso para ', a.name, ' en ', r.name) AS descripcion,
    GETDATE() AS creationDate,
    GETDATE() AS updatedAt,
    1 AS enabled,
    0 AS deleted,
    -- Ejemplo básico de checksum: puedes usar una función HASH real como HASHBYTES si lo deseas
    CONCAT(r.id_permissionResource, '-', a.id_permissionAction) AS checksum
FROM [dbo].[vpv_PermissionResource] r
CROSS JOIN [dbo].[vpv_PermissionAction] a;

``` 
</details>


<details>
<summary><b>vpv_Roles</b></summary>

```sql
DECLARE @now DATETIME = GETDATE();
INSERT INTO dbo.vpv_Roles
  ([id_role], [name], [descripcion], [creationDate], [updateAt], [enabled], [deleted], [checksum])
VALUES
  (1,  'Ciudadano',
       'Usuario registrado que puede votar y consultar propuestas.',
       @now, @now, 1, 0,
       HASHBYTES(
         'SHA2_256',
         CONCAT(
           '1','Ciudadano','Usuario registrado que puede votar y consultar propuestas.',
           CONVERT(VARCHAR(126), @now, 126),
           CONVERT(VARCHAR(126), @now, 126),
           '1','0'
         )
       )
  ),
  (2,  'RepresentanteOrg',
       'Usuario que representa a una organización y presenta propuestas.',
       @now, @now, 1, 0,
       HASHBYTES(
         'SHA2_256',
         CONCAT(
           '2','RepresentanteOrg','Usuario que representa a una organización y presenta propuestas.',
           CONVERT(VARCHAR(126), @now, 126),
           CONVERT(VARCHAR(126), @now, 126),
           '1','0'
         )
       )
  ),
  (3,  'Proponente',
       'Usuario que crea y gestiona propuestas de votación.',
       @now, @now, 1, 0,
       HASHBYTES(
         'SHA2_256',
         CONCAT(
           '3','Proponente','Usuario que crea y gestiona propuestas de votación.',
           CONVERT(VARCHAR(126), @now, 126),
           CONVERT(VARCHAR(126), @now, 126),
           '1','0'
         )
       )
  ),
  (4,  'ValidadorHumano',
       'Revisor que valida propuestas con firmas privadas.',
       @now, @now, 1, 0,
       HASHBYTES(
         'SHA2_256',
         CONCAT(
           '4','ValidadorHumano','Revisor que valida propuestas con firmas privadas.',
           CONVERT(VARCHAR(126), @now, 126),
           CONVERT(VARCHAR(126), @now, 126),
           '1','0'
         )
       )
  ),
  (5,  'AceleradoraInversor',
       'Entidad que avala y financia propuestas de crowdfunding.',
       @now, @now, 1, 0,
       HASHBYTES(
         'SHA2_256',
         CONCAT(
           '5','AceleradoraInversor','Entidad que avala y financia propuestas de crowdfunding.',
           CONVERT(VARCHAR(126), @now, 126),
           CONVERT(VARCHAR(126), @now, 126),
           '1','0'
         )
       )
  ),
  (6,  'FuncionarioGubernamental',
       'Representante del Gobierno que aprueba políticas y beneficios.',
       @now, @now, 1, 0,
       HASHBYTES(
         'SHA2_256',
         CONCAT(
           '6','FuncionarioGubernamental','Representante del Gobierno que aprueba políticas y beneficios.',
           CONVERT(VARCHAR(126), @now, 126),
           CONVERT(VARCHAR(126), @now, 126),
           '1','0'
         )
       )
  ),
  (7,  'Auditor',
       'Accede a logs.',
       @now, @now, 1, 0,
       HASHBYTES(
         'SHA2_256',
         CONCAT(
           '8','Auditor','Accede a logs.',
           CONVERT(VARCHAR(126), @now, 126),
           CONVERT(VARCHAR(126), @now, 126),
           '1','0'
         )
       )
  ),
  (8,  'SuperAuditor',
       'Accede a la informacion de log, propuestas, crowdfunding y votaciones.',
       @now, @now, 1, 0,
       HASHBYTES(
         'SHA2_256',
         CONCAT(
           '8','SuperAuditor','Accede a la informacion de log, propuestas, crowdfunding y votaciones.',
           CONVERT(VARCHAR(126), @now, 126),
           CONVERT(VARCHAR(126), @now, 126),
           '1','0'
         )
       )
  );
GO
``` 
</details>

<details>
<summary><b>Rol de Ciudadano</b></summary>

```sql
EXEC dbo.vpvSP_BatchAgregarPermisoRol
    @roleName     = 'Ciudadano',
    @actionName   = 'SELECT',
    @resourceList = 'vpv_balances,vpv_currencies,vpv_exchangeRates,vpv_founds,vpv_investmentPayment,vpv_investorsPerProject,vpv_investorsReturns,vpv_paymentMethods,vpv_payments,vpv_planBalance,vpv_transactionPerPlan,vpv_transactionPerUser,vpv_transactions,vpv_userBalance';

EXEC dbo.vpvSP_BatchAgregarPermisoRol
    @roleName     = 'Ciudadano',
    @actionName   = 'INSERT',
    @resourceList = 'vpv_balances,vpv_currencies,vpv_exchangeRates,vpv_founds,vpv_investmentPayment,vpv_investorsPerProject,vpv_investorsReturns,vpv_paymentMethods,vpv_payments,vpv_planBalance,vpv_transactionPerPlan,vpv_transactionPerUser,vpv_transactions,vpv_userBalance';

EXEC dbo.vpvSP_BatchAgregarPermisoRol
    @roleName     = 'Ciudadano',
    @actionName   = 'UPDATE',
    @resourceList = 'vpv_balances,vpv_founds,vpv_paymentMethods,vpv_userBalance';



EXEC dbo.vpvSP_BatchAgregarPermisoRol
    @roleName     = 'Ciudadano',
    @actionName   = 'SELECT',
    @resourceList = 'vpv_AllowedVoters,vpv_EndOfVoting,vpv_OptionsQuestion,vpv_PlansVotes,vpv_statusVoting,vpv_TargetPopulations,vpv_TargetPopulationsVoting,vpv_VoteComment,vpv_Voter,vpv_VoterDemographics,vpv_VoterResidence,vpv_Votes,vpv_VotesTaken,vpv_voteValues,vpv_votingConfigurations,vpv_votingQuestions,vpv_votingReasons,vpv_votingRestrictions,vpv_votingRestrictionTypes,vpv_VotingRules,vpv_VotingRuleSubType,vpv_VotingRuleTypes,vpv_votingTypes';

EXEC dbo.vpvSP_BatchAgregarPermisoRol
    @roleName     = 'Ciudadano',
    @actionName   = 'INSERT',
    @resourceList = 'vpv_GeneralResultsPerQuestion,vpv_ResultsPerFilter,vpv_ResultsPerOption,vpv_VoteComment,vpv_Voter,vpv_VoterDemographics,vpv_VoterResidence,vpv_Votes,vpv_VotesTaken,vpv_voteValues,vpv_VotingResultsSummary';

EXEC dbo.vpvSP_BatchAgregarPermisoRol
    @roleName     = 'Ciudadano',
    @actionName   = 'UPDATE',
    @resourceList = 'vpv_GeneralResultsPerQuestion,vpv_ResultsPerFilter,vpv_ResultsPerOption,vpv_VoteComment,vpv_Voter,vpv_VoterDemographics,vpv_VoterResidence,vpv_Votes,vpv_VotesTaken,vpv_voteValues,vpv_VotingResultsSummary';


EXEC dbo.vpvSP_BatchAgregarPermisoRol
    @roleName     = 'Ciudadano',
    @actionName   = 'UPDATE',
    @resourceList = 'vpv_authmethods,vpv_availablePaymentMethods,vpv_availablePaymentMethodsPerUser,vpv_biometricauths,vpv_biorequests,vpv_bioresponses,vpv_biostatus,vpv_biotypes,vpv_devices,vpv_devicetypes,vpv_docs,vpv_docincidents,vpv_docinfos,vpv_docstates,vpv_docstypes,vpv_identitydocs,vpv_identitystates,vpv_identitytype,vpv_languages,vpv_mfa,vpv_mfachallenges,vpv_mfamethods,vpv_mfaselect,vpv_mfasettings,vpv_nationality,vpv_notificationMethods,vpv_requests,vpv_requeststates,vpv_RequestStatus,vpv_requestvalidators,vpv_useroptions,vpv_userperrole,vpv_userResidence,vpv_UserRole,vpv_Users,vpv_validations,vpv_validationstatus,vpv_ips,vpv_keyowners,vpv_SearchingTags';


EXEC dbo.vpvSP_BatchAgregarPermisoRol
    @roleName     = 'Ciudadano',
    @actionName   = 'INSERT',
    @resourceList = 'vpv_logs,vpv_logSeverity,vpv_logsSources,vpv_logTypes';
``` 
</details>

<details>
<summary><b>Rol de FuncionarioGubernamental</b></summary>

```sql
EXEC dbo.vpvSP_BatchAgregarPermisoRol
    @roleName     = 'FuncionarioGubernamental',
    @actionName   = 'SELECT',
    @resourceList = 'vpv_governmentBenefits,vpv_governmentConditions,vpv_governmentEntities,vpv_PermissionAction,vpv_PermissionResource,vpv_Permissions,vpv_RolePermission,vpv_Roles,vpv_whitelistips,vpv_whitelists';

EXEC dbo.vpvSP_BatchAgregarPermisoRol
    @roleName     = 'FuncionarioGubernamental',
    @actionName   = 'INSERT',
    @resourceList = 'vpv_governmentBenefits,vpv_governmentConditions,vpv_governmentEntities,vpv_whitelistips,vpv_whitelists';

EXEC dbo.vpvSP_BatchAgregarPermisoRol
    @roleName     = 'FuncionarioGubernamental',
    @actionName   = 'UPDATE',
    @resourceList = 'vpv_governmentBenefits,vpv_governmentConditions,vpv_governmentEntities,vpv_whitelistips,vpv_whitelists';

``` 
</details>

<details>
<summary><b>Rol de Proponente</b></summary>

```sql
EXEC dbo.vpvSP_BatchAgregarPermisoRol
    @roleName     = 'Proponente',
    @actionName   = 'SELECT',
    @resourceList = 'vpv_crowdfoundingProposals,vpv_FilesPerProposal,vpv_proposalBalance,vpv_proposalComments,vpv_proposalNormalViews,vpv_proposalRequirements,vpv_proposals,vpv_proposalTypes,vpv_proposalVersions,vpv_proposalViews,vpv_proposalViewTypes,vpv_projectReports,vpv_AllowedVoters,vpv_EndOfVoting,vpv_GeneralResultsPerQuestion,vpv_OptionsQuestion,vpv_PlansVotes,vpv_ResultsPerFilter,vpv_ResultsPerOption,vpv_ResultTypes,vpv_statusVoting,vpv_TargetPopulations,vpv_TargetPopulationsVoting,vpv_VoteComment,vpv_votingConfigurations,vpv_votingQuestions,vpv_votingReasons,vpv_votingRestrictions,vpv_votingRestrictionTypes,vpv_VotingResultsSummary,vpv_VotingResultStatus,vpv_VotingRules,vpv_VotingRuleSubType,vpv_VotingRuleTypes,vpv_votingTypes';

EXEC dbo.vpvSP_BatchAgregarPermisoRol
    @roleName     = 'Proponente',
    @actionName   = 'INSERT',
    @resourceList = 'vpv_crowdfoundingProposals,vpv_FilesPerProposal,vpv_proposalBalance,vpv_proposalComments,vpv_proposalNormalViews,vpv_proposalRequirements,vpv_proposals,vpv_proposalTypes,vpv_proposalVersions,vpv_proposalViews,vpv_proposalViewTypes,vpv_projectReports,vpv_AllowedVoters,vpv_EndOfVoting,vpv_GeneralResultsPerQuestion,vpv_OptionsQuestion,vpv_PlansVotes,vpv_ResultsPerFilter,vpv_ResultsPerOption,vpv_ResultTypes,vpv_statusVoting,vpv_TargetPopulations,vpv_TargetPopulationsVoting,vpv_VoteComment,vpv_votingConfigurations,vpv_votingQuestions,vpv_votingReasons,vpv_votingRestrictions,vpv_votingRestrictionTypes,vpv_VotingResultsSummary,vpv_VotingResultStatus,vpv_VotingRules,vpv_VotingRuleSubType,vpv_VotingRuleTypes,vpv_votingTypes';

EXEC dbo.vpvSP_BatchAgregarPermisoRol
    @roleName     = 'Proponente',
    @actionName   = 'UPDATE',
    @resourceList = 'vpv_crowdfoundingProposals,vpv_FilesPerProposal,vpv_proposalBalance,vpv_proposalComments,vpv_proposalNormalViews,vpv_proposalRequirements,vpv_proposals,vpv_proposalTypes,vpv_proposalVersions,vpv_proposalViews,vpv_proposalViewTypes,vpv_projectReports,vpv_AllowedVoters,vpv_EndOfVoting,vpv_GeneralResultsPerQuestion,vpv_OptionsQuestion,vpv_PlansVotes,vpv_ResultsPerFilter,vpv_ResultsPerOption,vpv_ResultTypes,vpv_statusVoting,vpv_TargetPopulations,vpv_TargetPopulationsVoting,vpv_VoteComment,vpv_votingConfigurations,vpv_votingQuestions,vpv_votingReasons,vpv_votingRestrictions,vpv_votingRestrictionTypes,vpv_VotingResultsSummary,vpv_VotingResultStatus,vpv_VotingRules,vpv_VotingRuleSubType,vpv_VotingRuleTypes,vpv_votingTypes';

``` 
</details>

<details>
<summary><b>Rol de RepresentanteOrg</b></summary>

```sql
EXEC dbo.vpvSP_BatchAgregarPermisoRol
    @roleName     = 'RepresentanteOrg',
    @actionName   = 'SELECT',
    @resourceList = 'vpv_entities,vpv_entitiestatus,vpv_entityBalance,vpv_entitydescription,vpv_entitykey,vpv_entityroles,vpv_entityroletypes,vpv_entitysubtypes,vpv_entitytypes,vpv_availablePaymentMethodPerEntity';

EXEC dbo.vpvSP_BatchAgregarPermisoRol
    @roleName     = 'RepresentanteOrg',
    @actionName   = 'INSERT',
    @resourceList = 'vpv_entities,vpv_entitiestatus,vpv_entityBalance,vpv_entitydescription,vpv_entitykey,vpv_entityroles,vpv_entityroletypes,vpv_entitysubtypes,vpv_entitytypes,vpv_availablePaymentMethodPerEntity';

EXEC dbo.vpvSP_BatchAgregarPermisoRol
    @roleName     = 'RepresentanteOrg',
    @actionName   = 'UPDATE',
    @resourceList = 'vpv_entities,vpv_entitiestatus,vpv_entityBalance,vpv_entitydescription,vpv_entitykey,vpv_entityroles,vpv_entityroletypes,vpv_entitysubtypes,vpv_entitytypes,vpv_availablePaymentMethodPerEntity';

``` 
</details>

<details>
<summary><b>Rol de Auditor</b></summary>

```sql
EXEC dbo.vpvSP_BatchAgregarPermisoRol
    @roleName     = 'Auditor',
    @actionName   = 'SELECT',
    @resourceList = 'vpv_logs,vpv_logSeverity,vpv_logsSources,vpv_logTypes';

``` 
</details>


### Configuracion de la votacion

---
<details>
<summary><b>vpv_TargetPopulations</b></summary>

```sql
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
```
</details>

<details>
<summary><b>vpv_FilterTypes</b></summary>

```sql
-- FilterTypes para cada tipo de demografía
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
```
</details>

<details>
<summary><b>vpv_PopulationFilters</b></summary>

```sql
-- vpv_PopulationFilters

-- Filtros para Jóvenes Adultos (edad entre 18 y 35)
INSERT INTO [dbo].[vpv_PopulationFilters]
           ([description], [idFilterType], [valueMin], [valueMax], [referenceValue], [validation], [enable], [creationDate], [checksum], [idTargetPopulation])
VALUES 
           ('Edad 18-35', 1, 18.00, 35.00, NULL, 1, 1, GETDATE(), 'chk_fil_001', 1);

-- Filtros para Adultos Mayores (edad > 65)
INSERT INTO [dbo].[vpv_PopulationFilters]
           ([description], [idFilterType], [valueMin], [valueMax], [referenceValue], [validation], [enable], [creationDate], [checksum], [idTargetPopulation])
VALUES 
           ('Edad 65+', 1, 65.00, 120.00, NULL, 1, 1, GETDATE(), 'chk_fil_002', 2);

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
```
</details>

<details>
<summary><b>vpv_SearchingTags</b></summary>

```sql
-- Searching Tags

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
```
</details>

<details>
<summary><b>vpv_UnitMeasure</b></summary>

```sql
-- Unit Measure
INSERT INTO [dbo].[vpv_UnitMeasure]([name],[datatype],[enable])
     VALUES
           ('Litros','decimal(5,2)',1),
           ('Semanas','decimal(5,2)',1),
           ('Provincia','int',1),
           ('Personas','int',1),
           ('Votaciones','int',1),
           ('Cantidad','int',1),
           ('Porcentaje','decimal(5,2)',1);
```
</details>

<details>
<summary><b>vpv_ImpactZoneTypes</b></summary>

```sql
-- Impact Zone Types
INSERT INTO [dbo].[vpv_ImpactZoneTypes] ([name], [idUnitMeasure], [enable], [checksum])
VALUES
    ('Uso de agua potable', 1, 1, N'abc123    '),  -- idUnitMeasure = Litros
    ('Duración de proyecto', 2, 1, N'def456    '), -- idUnitMeasure = Semanas
    ('Cobertura territorial', 3, 1, N'ghi789    '),-- idUnitMeasure = Provincia
    ('Personas beneficiadas', 4, 1, N'xyz321    ');-- idUnitMeasure = Personas
```
</details>

<details>
<summary><b>vpv_ClosureTypes</b></summary>

```sql
-- Closure Types
INSERT INTO [dbo].[vpv_ClosureTypes]
           ([name],[enable])
     VALUES
           ('Cierre hasta que los votantes terminen',1),
           ('Cierre hasta la fecha',1);
```
</details>

<details>
<summary><b>vpv_VotingRuleSubType</b></summary>

```sql
-- Voting Rule Sub Type
INSERT INTO [dbo].[vpv_VotingRuleSubType]
           ([name],[idUnitMeasure],[enable])
     VALUES
           ('Minimo de votacion', 5,1),
           ('Porcentaje de votacion', 6,1),
           ('Organizaciones', 7,1),
           ('Personas', 7,1);
```
</details>

<details>
<summary><b>vpv_VotingRuleTypes</b></summary>

```sql
-- vpv_VotingRuleTypes
INSERT INTO [dbo].[vpv_VotingRuleTypes]
           ([name],[enable])
     VALUES
           ('Visibilidad',1),
           ('Aceptacion',1),
           ('Rechazo',1),
           ('Calificacion',1);
```
</details>

<details>
<summary><b>vpv_statusVoting</b></summary>

```sql
-- vpv_statusVoting
INSERT INTO [dbo].[vpv_statusVoting]
           ([name], [enable], [checksum])
     VALUES
           ('Abierta', 1, N'8efb9d10c2'),
           ('En curso', 1, N'2a6370a34e'),
           ('Finalizada', 1, N'bb27a94cfc');
```
</details>


## 📊 Dashboard de Consulta

Puede acceder al dashboard principal en Power BI mediante el siguiente enlace embebido:

[Dashboard de Votaciones - Power BI](https://app.powerbi.com/reportEmbed?reportId=56d22684-d572-4fec-a32f-35f3be5be30e&autoAuth=true&ctid=bfcf1d9d-93ea-43b1-b902-1daa68a64248)


<details>
  <summary>Desplegar información completa del Dashboard</summary>

## Flujo para el acceso al dashboard

### 1. Inicio de sesión (Login)

- El usuario debe autenticarse con sus credenciales válidas (usuario y contraseña).
- El sistema valida la identidad y los permisos del usuario.
- En caso de credenciales incorrectas, se mostrará un mensaje de error y no se permitirá el acceso.

### 2. Validación de privilegios

- Tras un inicio de sesión exitoso, el sistema verifica el nivel de privilegios del usuario.
  
### 3. Visualización del dashboard principal

- Si el usuario tiene los privilegios requeridos, se carga y muestra el dashboard principal.
- El dashboard presenta:
  - Resumen de votaciones recientes (top 5).
  - Resultados agregados y segmentados.
  - Información financiera para propuestas de crowdfunding.
  - Segmentación demográfica de votos.
  - Detalles por pregunta y opción de respuesta.

### 4. Navegación y uso

- La información es presentada de manera segura, sin opción para descarga o exportación.
- Los datos se actualizan en tiempo real.

---

## Consideraciones de seguridad

- La validación estricta de privilegios asegura que solo usuarios autorizados accedan a información sensible.
- La interfaz protege los datos y evita su descarga o exporatcion de los datos para mantener la confidencialidad.

---

Este flujo garantiza un acceso controlado y seguro al dashboard, promoviendo la transparencia y eficiencia en el seguimiento de los procesos de votación electrónica.


### Inicio de Sesión
  <details>
  <summary>Desplegar información</summary>
Para la implemenatcion de Inicio de sesión se hace de dos formas pero ambas por RLS (Row Level Security).
La primera de ella se hace por medio de dos tablas donde se guardan los usuarios que pueden tener accesso al dashboard a la hora de ingresas cuando el enlace es compartido con el usuario.  Se utiliza También un rol que recibe el nombre de usuario que viene desde el RLS para que pueda ser verificado con los usuarios que ya cuentan con acceso segun las tablas registradas.  Esta configuracion se utiliza para que el usuario puede ver o no ver por completo el dashboard

Despues la segunda configuración consiste en hacer roles como más individuales segun la informacion que se quiee que el usuario vea.  En este caso se utiliza los roles y se filtran ciertos elementos del dashboard en sí como que no pueda ver ciertas propuestas o ciertas ciudades, etc. Este tambien está incorporado al RLS porque de esta manera al crear un rol se puede agregar personas que puedan o no puedan acceder a este rol 

  </details>

## Dashboard principal

El dashboard del sistema de voto electrónico está desarrollado utilizando **Power BI**, una herramienta de visualización de datos que permite integrar de forma eficiente los resultados del sistema con la arquitectura de datos utilizada en el diseno de bases de datos.

### Consideraciones técnicas:

- Power BI se conecta directamente a la base de datos **puravidadb**.


<details>
  <summary>Desplegar información</summary>


A continuación, se muestran las posibles versiones del dashboard, cada una de las cuales presenta información clave sobre la votación de propuestas clasificadas como **crowdfunding o no crowdfunding**.

Cada versión del dashboard incluye:

- La **cantidad de votos ejecutados**.
- El **nombre de la versión de propuesta** a la que corresponden los resultados.
- Segmentación detallada de los resultados con base en datos demográficos relevantes.
- Los resultados agregados por opción de respuesta, este caso al presionar cada pregunta se muestran las opciones pertenecientes. 

## Segmentación Demográfica

Los datos están organizados según los siguientes criterios:

### 1. Sexo

Representa el número de votantes según su género:

- **Masculino**
- **Femenino**

### 2. Ubicación Geográfica

Segmentación basada en la **provincia de Costa Rica** desde donde se emitió el voto. Las provincias consideradas son:

- San José
- Alajuela
- Cartago
- Heredia
- Guanacaste
- Puntarenas
- Limón

### 3. Nacionalidad

Indica la distribución de votantes según su nacionalidad:

- **Costarricenses**
- **Otras nacionalidades** (personas extranjeras que participaron en la votación)



---

#### Votación de propuesta de tipo crowdfunding

Esta vista muestra un resumen visual y analítico del estado de votación asociado a una propuesta clasificada como crowdfunding. Su objetivo es permitir a los usuarios monitorear en tiempo real la participación, los resultados y las métricas clave relacionadas con el proceso de votación.

- En propuestas de tipo **emprendimiento o crowdfunding**, se incluye información adicional:
  - **Monto total solicitado** por el proyecto.
  - **Monto recibido** a través de inversión ciudadana.
  - **Monto ejecutado** a la fecha, según el plan de desembolsos.

![image](https://github.com/user-attachments/assets/7b24c8c1-a290-4cf2-a176-7595cb8af2ee)

---

#### Votación de propuesta de tipo regular

Esta vista muestra un resumen visual y analítico del estado de votación asociado a una propuesta clasificada como votación regular. En este caso, se muestra cómo no es una propuesta que posea inversión ni solicitud de la misma. Su objetivo es permitir a los usuarios monitorear en tiempo real la participación, los resultados y las métricas clave relacionadas con el proceso de votación sin tomar en cuenta valores monetarios.

![alt text](assets/dashboardNoCrowfounding.png)

#### Vistas utilizadas para almacenar y mostrar los datos necesarios

La elaboración y recolección de datos se realiza a través de la creación de **vistas** en la base de datos. Estas vistas agrupan información importante y permiten obtener fácilmente las **5 votaciones más recientes** junto con sus datos asociados.

---
 
#####  Ventajas de usar vistas (views)

1. **Facilitan el trabajo**  
   Las vistas ayudan a simplificar consultas complicadas. Se puede reutilizar una misma vista en varios lugares sin volver a escribir el mismo código.

2. **Fáciles de mantener y de actualizacion de datos**  
   Si algo cambia en la estructura de los datos, solo se actualiza la vista y no todas las consultas que la usan.

3. **Mayor seguridad**  
   Es posible mostrar solo ciertos datos a los usuarios, ocultando la información sensible sin modificar las tablas originales.

4. **Conexión directa con Power BI**  
   Power BI puede conectarse fácilmente a las vistas, lo que hace más fácil mostrar los datos en gráficos y reportes.

5. **Resultados consistentes**  
   Al usar una misma vista para todos los reportes, se asegura que todos vean los mismos datos, sin diferencias.

##### Vista: `vw_RecentVotingConfigs`

Esta vista fue creada para mostrar las **5 votaciones más recientes** configuradas en el sistema. Se utiliza principalmente como fuente de datos principal para el dashboard de votaciones en Power BI.

---

#### Query SQL

```sql
CREATE OR ALTER VIEW [dbo].[vw_RecentVotingConfigs] AS
SELECT TOP 5
    idVotingConfig,
    description,
    creationDate,
    proposalVersionId,
    ROW_NUMBER() OVER (ORDER BY creationDate DESC) AS RowNum
FROM vpv_VotingConfigurations
ORDER BY creationDate DESC;
GO
```

#### Vista: `vw_ProposalInvestments`

La vista `vw_ProposalInvestments` fue diseñada para mostrar información financiera clave de las **propuestas de tipo crowdfunding** que están dentro de las 5 votaciones más recientes del sistema. Esta vista recopila datos importantes como el presupuesto solicitado, el dinero invertido por la ciudadanía y el monto ya ejecutado según los planes de inversión.

Se utiliza especialmente en **Power BI**, como parte del dashboard del sistema de voto electrónico, para brindar transparencia y control sobre el uso de fondos públicos o ciudadanos.

---

#### Query SQL

```sql
CREATE VIEW [dbo].[vw_ProposalInvestments] AS
SELECT 
    rpv.RowNum,
    p.tittle AS Propuesta,
    p.budget AS Monto_Solicitado,

    -- Inversión ciudadana
    (SELECT SUM(t1.amount)
     FROM vpv_transactionPerPlan tc
     INNER JOIN vpv_transactions t1 ON t1.transactionId = tc.transactionId
     INNER JOIN vpv_transSubTypes st1 ON st1.transactionSubTypeId = t1.transactionSubTypeId
     WHERE tc.crowdfoundingProposalId = cp.crowdfoundingProposalId
       AND st1.name = 'Inversión de Usuario') AS Inversion_Ciudadana,

    -- Inversión por plan
    (SELECT SUM(t2.amount)
     FROM vpv_executionPlans ep
     INNER JOIN vpv_transactionPerPlan tp ON tp.executionPlanId = ep.executionPlanId
     INNER JOIN vpv_transactions t2 ON t2.transactionId = tp.transactionId
     INNER JOIN vpv_transSubTypes st2 ON st2.transactionSubTypeId = t2.transactionSubTypeId
     WHERE ep.crowdfoundingProposalId = cp.crowdfoundingProposalId
       AND st2.name = 'Inversion a un Plan') AS Monto_Ejecutado

FROM vw_RecentVotingConfigs rpv
INNER JOIN vpv_proposalVersions pv ON rpv.proposalVersionId = pv.proposalversionId
INNER JOIN vpv_proposals p ON p.proposalId = pv.proposalId
INNER JOIN vpv_crowdfoundingProposals cp ON cp.proposalId = p.proposalId;
GO
```
#### Vista: `vw_ResultPerFilter_Segmentation`

Esta vista se creó para mostrar la **segmentación de resultados de votaciones** basada en filtros demográficos, como sexo, nacionalidad y provincia. Su objetivo es facilitar el análisis detallado de cómo se distribuyen los votos según diferentes características sociales, manteniendo el enfoque en las votaciones más recientes.

---

####  Query SQL

```sql
CREATE VIEW [dbo].[vw_ResultPerFilter_Segmentation] AS
SELECT 
    rvc.RowNum,
    rvc.idVotingConfig,
    rvc.description AS votingDescription,
    rvc.creationDate,
    ft.name AS filterName,
    ds.name AS subFilterName,       -- Nombre descriptivo del subtipo
    rf.referenceId1,
    rf.votesCount,
    rf.votesPercentage
FROM vw_RecentVotingConfigs rvc
JOIN vpv_ResultsPerFilter rf ON rvc.idVotingConfig = rf.idVotingConfig
JOIN vpv_FilterTypes ft ON rf.idFilterType = ft.idFilterType
JOIN vpv_demosubtype ds ON rf.referenceId1 = ds.demosubtypeid
WHERE ft.name IN ('Sexo', 'Nacionalidad', 'Provincia')
  AND rf.enable = 1;
GO
```
#### Vista: `vw_ResultPerOption_ByQuestion`

Esta vista muestra los resultados de votación **desglosados por opción para cada pregunta** dentro de las votaciones más recientes. Permite analizar cómo se distribuyeron los votos entre las diferentes opciones de cada pregunta en una configuración de votación.

---

#### Query SQL

```sql
CREATE OR ALTER VIEW [dbo].[vw_ResultPerOption_ByQuestion] AS
SELECT
    vc.RowNum,
    vc.idVotingConfig,
    vc.description AS VotingConfigName,
    q.idVotingQuestions,
    qs.description AS QuestionDescription,
    o.idOptionQuestion,
    o.value AS OptionValue,
    o.description AS OptionDescription,
    rpo.votesCount,
    rpo.votesPercentage,
    rpo.winner
FROM vw_RecentVotingConfigs vc
JOIN vpv_votingQuestions q ON q.idVotingConfig = vc.idVotingConfig
INNER JOIN vpv_questions qs ON q.idQuestion = qs.idQuestion
JOIN vpv_OptionsQuestion o ON q.idQuestion = o.idQuestions
LEFT JOIN vpv_ResultsPerOption rpo ON rpo.idOptionQuestion = o.idOptionQuestion;
GO
```
#### Vista: `vw_Top5VotingResultsSummary`

Esta vista proporciona un resumen de los resultados de las votaciones que están entre las 5 más recientes, basándose en la vista `vw_RecentVotingConfigs`. Sirve para mostrar datos agregados y métricas clave sobre el desempeño de cada votación.

---

####  Query SQL

```sql
CREATE OR ALTER VIEW [dbo].[vw_Top5VotingResultsSummary] AS
SELECT
    rs.idVotingResultsSummary,
    rs.idVotingConfig,
    rs.idEndOfVoting,
    rs.description,
    rs.idVotingResultStatus,
    rs.votesCount,
    rs.ValidVotesPercentage,
    rs.checkSum,
    rs.creationDate,
    rs.enable,
    rs.average,
    rvc.RowNum
FROM dbo.vpv_VotingResultsSummary rs
INNER JOIN dbo.vw_RecentVotingConfigs rvc
    ON rs.idVotingConfig = rvc.idVotingConfig;
GO
```

Estas vistas son esenciales para alimentar el dashboard y asegurar que se muestre la información correcta de forma rápida y clara.

</details>

</details>


## 📄 Implementación del API
<details>
  <summary>Desplegar información</summary>

### Endpoints

| Endpoint                 | URL                                            | Método | Descripción                                                        |
|--------------------------|------------------------------------------------|--------|------------------------------------------------------------------|
| comentar                 | http://localhost:7071/api/comentar              | POST   | Endpoint para enviar o gestionar comentarios.                    |
| configurarVotacionORM    | http://localhost:7071/api/configurarVotacionORM | POST   | Configura la votación usando ORM.                                |
| crearActualizarPropuesta | http://localhost:7071/api/crearActualizarPropuesta | POST   | Crea o actualiza una propuesta.                                  |
| invertir                 | http://localhost:7071/api/invertir              | POST   | Realiza una operación de inversión o inversión lógica.          |
| ListarVotos              | http://localhost:7071/api/listarVotos           | POST   | Devuelve una lista de votos registrados.                         |
| revisarPropuesta_sp      | http://localhost:7071/api/revisarPropuesta_sp   | POST   | Revisa una propuesta                                              |
| votar                    | http://localhost:7071/api/votar                  | POST   | Permite registrar un voto.                                       |

  Implementación del API Serverless para el Sistema de Voto Electrónico y Crowdfunding

Introducción

Para la implementación del API del sistema de voto electrónico y crowdfunding, se ha decidido utilizar un service serverless que se desarrollará en Python, aprovechando la integración con Azure Functions. Aunque el modelo serverless es típicamente para la nube, en este caso el despliegue será completamente local para garantizar que todos los miembros del equipo trabajen con la misma implementación y tengan acceso uniforme a la base de datos local.

Esta estrategia aporta varias ventajas importantes:

- Consistencia: Todos los desarrolladores usan el mismo entorno local, evitando diferencias entre máquinas.
- Colaboración distribuida: Facilita el trabajo en equipo sin necesidad de conexión constante a la nube.
- Portabilidad: Se puede trasladar fácilmente el entorno a cualquier computadora sin cambios en la configuración.
- Preparación para despliegue en la nube: La arquitectura serverless mantiene la compatibilidad para futuras migraciones a Azure esto por medio de la herramienta de tipo extension que VSCODE brinda para que sea sencillo el despliegue.

Arquitectura y tecnología elegida

Azure Functions

- Se usa Azure Functions Core Tools para correr el servicio localmente, simulando un entorno serverless.
- Las funciones serán el punto de entrada para las solicitudes API.
- El runtime maneja automáticamente la asignación y liberación de recursos, así como el escalado si fuera necesario.
- Se prueban y desarrollan las funciones en Visual Studio Code con la extensión de Azure Functions, permitiendo depuración y pruebas sencillas.

Lenguaje de programación: Python

- Python es ampliamente usado y soportado en Azure Functions.
- Permite integración sencilla con bases de datos usando bibliotecas estándar.
- Facilita la integración con posibles servicios de inteligencia artificial o análisis avanzado.

Implementación del acceso a base de datos

El API se divide en dos categorías para interactuar con la base de datos, ambas con enfoque en eficiencia, mantenibilidad y buenas prácticas de desarrollo:

1. Procedimientos almacenados (Stored Procedures - SP)

- Los procedimientos almacenados son bloques de código SQL predefinido que se ejecutan dentro del motor de base de datos.
- Permiten encapsular lógica compleja, validaciones, y transacciones dentro de la base de datos.
- En la implementación serverless, las funciones Azure invocarán estos procedimientos a través de la biblioteca pyodbc, que ofrece conexión y ejecución de consultas SQL en bases de datos Microsoft SQL Server.
- Ventajas:
  - Mejor rendimiento por ejecución directa en la base de datos.
  - Centralización de la lógica de negocio en la base de datos.
  - Mejor manejo transaccional y control de errores dentro del motor.
- Desventajas:
  - Menos flexible para cambios frecuentes en lógica de negocio.
  - Más dependiente del motor de base de datos específico.

2. ORM (Object-Relational Mapping) con SQLAlchemy

- SQLAlchemy es una biblioteca ORM que permite mapear tablas y relaciones SQL a clases y objetos en Python.
- Facilita la creación y manipulación de datos mediante objetos, haciendo el código más legible y mantenible.
- Con SQLAlchemy se pueden definir modelos (clases) que representan las tablas, y luego realizar consultas y operaciones sobre esos modelos sin escribir SQL explícito.
- Ventajas:
  - Mayor flexibilidad y rapidez para cambios en la lógica de negocio.
  - Independencia relativa del motor de base de datos (se puede cambiar fácilmente).
  - Mejor integración con código Python y uso de patrones de diseño.
- Desventajas:
  - Puede tener un ligero impacto en rendimiento respecto a SP.
  - Requiere aprendizaje y definición adecuada de los modelos.

Flujo general para los endpoints API

Cada endpoint en el API serverless seguirá los siguientes pasos clave:

1. Recepción de la petición: la función Azure recibe la solicitud HTTP con los parámetros necesarios.
2. Validaciones iniciales: se verifican credenciales, formato de datos y autorizaciones.
3. Ejecución de la lógica:
   - Si es un endpoint basado en SP, se conecta a la base de datos y ejecuta el procedimiento almacenado correspondiente con los parámetros recibidos.
   - Si es un endpoint basado en ORM, se utiliza SQLAlchemy para manipular los modelos y realizar las consultas o actualizaciones necesarias.
4. Control transaccional: se asegura que las operaciones críticas (como registro de votos) sean atómicas y consistentes.
5. Respuesta: se formatea y envía la respuesta al cliente, con la información solicitada o confirmación de la operación.

Instalación y configuración

Para trabajar con este sistema localmente, se deben instalar las siguientes herramientas y librerías:

- Azure Functions Core Tools: para correr y probar localmente las funciones serverless.

npm install -g azure-functions-core-tools@4

- Extensión Azure Functions en Visual Studio Code: facilita desarrollo y pruebas.

- Python y librerías necesarias: en el entorno virtual o global de Python instalar:

pip install azure-functions pyodbc sqlalchemy

- Herramientas para probar API: como Postman o Thunder Client (extensión VS Code).

</details>

### Estructura del Proyecto Azure API

<details>
  <summary>Desplegar información</summary>

Este proyecto implementa un API serverless con Azure Functions en Python para el sistema de voto electrónico y crowdfunding. A continuación se describe la estructura de carpetas y archivos principales que lo conforman.

---

## Archivos principales

- **host.json**  
  Archivo de configuración global para Azure Functions. Define el comportamiento del runtime de las funciones, como tiempos de espera, logging, entre otros.

- **function_app.py**  
  Archivo principal donde se definen las funciones de Azure (endpoints) que responderán a las peticiones HTTP. Aquí se conecta la lógica de negocio con el runtime serverless.

- **database.py**  
  Módulo que contiene la configuración de conexión a la base de datos, ya sea a través de pyodbc para procedimientos almacenados o SQLAlchemy para ORM. También puede incluir funciones de acceso común.

- **local.settings.json**  
  Archivo para configuración local del entorno, incluyendo variables de ambiente como cadenas de conexión a bases de datos y claves secretas. No debe subirse a repositorios públicos.

- **.env**  
  Archivo de variables de entorno (opcional), utilizado para gestionar configuraciones sensibles en desarrollo local.

---

## Carpetas principales

- **Models/**  
  Contiene las definiciones de modelos de datos y clases ORM que representan las tablas y relaciones en la base de datos. Facilita la manipulación y consulta de datos en código Python.

- **JSON_Examples/**  
  Contiene ejemplos de archivos JSON utilizados para pruebas, payloads de solicitudes o respuestas, y documentación de formatos de entrada/salida del API.

- **Endpoints_SP/**  
  Carpeta dedicada a la implementación de endpoints que consumen **Procedimientos Almacenados (Stored Procedures)** a través de pyodbc. Aquí se define la lógica para ejecutar los SP y procesar sus resultados.

- **Endpoints_ORM/**  
  Carpeta dedicada a la implementación de endpoints que utilizan el **ORM SQLAlchemy** para el acceso y manipulación de datos. Aquí se define la lógica basada en modelos y consultas ORM.

Esta estructura permite mantener el código organizado, separando claramente las responsabilidades:

- Configuración y runtime (host.json, local.settings.json, .env)
- Lógica principal de funciones (function_app.py)
- Acceso a base de datos (database.py, Models/)
- Diferentes estilos de implementación (Endpoints_SP para SP y Endpoints_ORM para ORM)
- Recursos y ejemplos para pruebas (JSON_Examples)

---

</details>

---

  ## ⚪ Endpoints implementados por Stored Procedures

Los endpoints de esta sección utilizan procedimientos almacenados (Stored Procedures) en SQL Server para ejecutar la lógica del sistema directamente desde la base de datos. Esta estrategia permite manejar operaciones complejas de forma eficiente, segura y con control transaccional.

Herramientas utilizadas

- Azure Functions Core Tools y Visual Studio Code: para ejecutar funciones serverless localmente.

- Python con pyodbc: para conectar y enviar datos a SQL Server desde los endpoints.

- SQL Server: donde se almacenan y ejecutan los procedimientos.

- Thunder Client o Postman: para probar los endpoints HTTP de forma local.

  ---

<details>
<summary>Ver endpoints</summary>

#### Revisar Propuesta

<details>
  <summary>Desplegar información</summary>

Esta función permite a un usuario autorizado marcar una propuesta como "revisada", siempre y cuando haya superado las validaciones técnicas automáticas. Este endpoint invoca un procedimiento almacenado que verifica el tipo de propuesta, su proceso asociado y que los resultados de análisis no contengan errores antes de actualizar el estado de la propuesta.

La secuencia de pasos es la siguiente:

- Se recibe una solicitud HTTP **POST** con el campo `"proposalId"` en el body.
- Se valida que el campo exista y sea un entero.
- Se ejecuta el stored procedure `revisarPropuesta` enviando ese `proposalId`.
- El procedimiento valida internamente:
- Que la propuesta exista y tenga tipo definido.
- Que tenga un proceso asociado (`vpv_process`) válido.
- Que no existan errores en los resultados (`vpv_workresults`).
- Que no existan errores en la extracción de información (`vpv_extractedinfos`).
- Si todo es correcto, se marca la propuesta como "Publicada" (`statusId = 12`) y se registra el usuario que completó el análisis.

<details>
  <summary>Ver código del lado de API</summary>

```
python
import azure.functions as func
from datetime import datetime
import json
import logging
import os
import pyodbc

conn_str = os.environ.get("SQL_CONNECTION_STRING")

def revisarPropuesta_sp(req: func.HttpRequest) -> func.HttpResponse:
    logging.info('Endpoint revisarPropuesta invocado.')

    if req.method != "POST":
        return func.HttpResponse(
            "Método no permitido. Usa POST.",
            status_code=405
        )

    try:
        req_body = req.get_json()
    except ValueError:
        return func.HttpResponse(
            "Body no es JSON válido.",
            status_code=400
        )

    proposal_id = req_body.get('proposalId')
    if proposal_id is None:
        return func.HttpResponse(
            "El campo 'proposalId' es requerido.",
            status_code=400
        )
    try:
        proposal_id = int(proposal_id)
    except:
        return func.HttpResponse(
            "El campo 'proposalId' debe ser un entero.",
            status_code=400
        )

    try:
        with pyodbc.connect(conn_str, autocommit=False) as conn:
            cursor = conn.cursor()
            cursor.execute("EXEC dbo.revisarPropuesta ?", proposal_id)
            conn.commit()

            return func.HttpResponse(
                json.dumps({"message": "Propuesta revisada exitosamente."}),
                status_code=200,
                mimetype="application/json"
            )

    except pyodbc.Error as e:
        error_text = str(e)
        logging.error(f"Error al ejecutar revisarPropuesta: {error_text}")
        return func.HttpResponse(
            json.dumps({"error": error_text}),
            status_code=400,
            mimetype="application/json"
        )
```

</details> 

<details>

<summary>Ver código del lado de SQL Server</summary>

```sql
CREATE OR ALTER PROCEDURE dbo.revisarPropuesta
    @proposalId INT -- ID de la propuesta a revisar
AS
BEGIN
    -- Evita mostrar en consola la cantidad de filas afectadas por cada instrucción
    SET NOCOUNT ON;
	 
    -- Inicia una transacción para asegurar que todos los cambios se realicen o ninguno
    BEGIN TRANSACTION;

    -- Declaración de variables auxiliares
    DECLARE
        @idpropuesta    INT,             -- ID del tipo de propuesta (proposalTypeId)
        @TipoPropuesta  NVARCHAR(50),    -- Nombre del tipo de propuesta
        @ProcessId      INT,             -- ID del proceso asociado a la propuesta
        @Cnt            INT,             -- Contador usado para validaciones
        @ErrorMsg       NVARCHAR(MAX) = N''; -- Mensaje de error en caso de fallos

    -------------------------------------------------------------------------
    -- PASO 1: Obtener el tipo y nombre de la propuesta desde su ID
    -------------------------------------------------------------------------

	-- TABLAS INVOLUCRADAS:
	-- vpv_proposals: Tabla que contiene las propuestas, de esta manera conseguimos llegar
	-- al tipo de la propuesta para encontrar su proceso asignado.
	-- vpv_proposalTypes: Aquí se encuentra los tipos de propuestas, cada tipo
	-- de propuesta tiene un proceso asignado, por eso tenemos que sacar el tipo
    SELECT 
        @idpropuesta   = p.proposalTypeId,
        @TipoPropuesta = pt.name
    FROM dbo.vpv_proposals AS p
    JOIN dbo.vpv_proposalTypes AS pt
      ON p.proposalTypeId = pt.proposalTypeId
    WHERE p.proposalId = @proposalId;

    -- Si no se encuentra la propuesta, se genera un error y se sale
    IF @idpropuesta IS NULL
    BEGIN
        SET @ErrorMsg = N'Propuesta no encontrada (ID=' 
                      + CAST(@proposalId AS NVARCHAR(10)) + N')';
        GOTO ErrorHandler;
    END

    -------------------------------------------------------------------------
    -- PASO 2: Buscar el proceso relacionado con el tipo de propuesta
    -------------------------------------------------------------------------

	-- TABLAS INVOLUCRADAS:
	-- vpv_process: Tabla que guarda la información acerca de como va a ser el proceso (workflow) 
	-- para ya sea un doc, propuesta o información que necesite una línea de proceso.
	-- Aquí lo que hacemos es que a partir del tipo de la propuesta llegamos al proceso que
	-- le toca
    SELECT TOP 1 
        @ProcessId = pr.processid
    FROM dbo.vpv_process AS pr
    WHERE pr.referencevalue = @idpropuesta
      AND pr.referenceid    = N'proposalTypeId'
    ORDER BY pr.[order]; -- Se asume que el proceso con menor orden es el principal

    -- Si no hay proceso asociado, se lanza un error
    IF @ProcessId IS NULL
    BEGIN
        SET @ErrorMsg = N'Proceso no encontrado para proposalTypeId=' 
                      + CAST(@idpropuesta AS NVARCHAR(10));
        GOTO ErrorHandler;
    END

    -------------------------------------------------------------------------
    -- PASO 3A: Validación en tabla vpv_workresults (resultados del proceso)
    -- Se verifica que:
    --   - No existan errores diferentes de 0
    --   - El mensaje de error sea exactamente 'Nulo'
    --   - El resultado haya sido realizado por IA Azure
    -------------------------------------------------------------------------

	-- TABLAS INVOLUCRADAS:
	-- vpv_workresults: Tabla que guarda los resultados de las operaciones en un workflow, en este
	-- caso la usamos para asegurarnos que en todo el proceso no hubo fallos ni intervenciones
    SELECT @Cnt = COUNT(*)
    FROM dbo.vpv_workresults AS wr
    WHERE wr.processid      = @ProcessId
      AND (
           wr.error        <> 0
        OR wr.errorMessage <> N'Nulo'
        OR wr.performedby  <> N'IA Azure'
      );

    -- Si se encuentra al menos un registro con fallos, se lanza error
    IF @Cnt > 0
    BEGIN
        SET @ErrorMsg = N'Validación fallida en vpv_workresults';
        GOTO ErrorHandler;
    END

    -------------------------------------------------------------------------
    -- PASO 3B: Validación en tabla vpv_extractedinfos (información extraída)
    -- Se valida que no haya errores en los datos procesados vinculados al proceso
    -------------------------------------------------------------------------

	-- TABLAS INVOLUCRADAS:
	-- vpv_extractedinfos: Tabla que guarda la información extraída de cada proceso, un workresult
	-- indica si estuvo correcto pero esta tabla dice que sacamos de ese proceso y si está bien.
	-- En este caso la usamos para asegurarnos que la información extraída este correcta.
    SELECT @Cnt = COUNT(*)
    FROM dbo.vpv_extractedinfos AS ei
    JOIN dbo.vpv_workresults AS wr2
      ON ei.workresultid = wr2.workresultid
    WHERE wr2.processid = @ProcessId
      AND ei.error     <> 0;

    -- Si se encuentra algún error en los datos extraídos, se detiene el proceso
    IF @Cnt > 0
    BEGIN
        SET @ErrorMsg = N'Validación fallida en vpv_extractedinfos';
        GOTO ErrorHandler;
    END

    -------------------------------------------------------------------------
    -- PASO 4: Actualización del estado de la propuesta y trazabilidad
    -------------------------------------------------------------------------

	-- TABLAS INVOLUCRADAS:
	-- vpv_proposals: Se actualiza la propuesta 
	-- vpv_workresults: Se registra el último flujo de trabajo donde se deja quién
	-- realizó la revisión de la propueta.
    -- Se marca la propuesta como "Publicada" y se registra la fecha actual
    UPDATE dbo.vpv_proposals
    SET 
        startingDate = GETDATE(), -- De actualiza la fecha
        statusId     = 12         -- Estado "Publicada"
    WHERE proposalId = @proposalId;

    -- Se deja un rastro en los resultados del proceso, indicando quién la revisó
    UPDATE dbo.vpv_workresults
    SET 
        performedby = SUSER_SNAME(), -- Nombre del usuario que ejecutó la revisión
        details     = N'Trazabilidad de análisis técnico completado; fuente de aprobación: IA Azure.'
    WHERE processid = @ProcessId;

    -- Finaliza exitosamente la transacción
    COMMIT TRANSACTION;

    -- Mensaje de confirmación en consola
    PRINT N'Propuesta revisada exitosamente.';
    RETURN 0; -- Éxito

    -------------------------------------------------------------------------
    -- MANEJO DE ERRORES: En caso de cualquier falla
    -------------------------------------------------------------------------
ErrorHandler:
    -- Revierte cualquier cambio hecho en la base
    ROLLBACK TRANSACTION;
    -- Lanza el mensaje de error personalizado
    RAISERROR(@ErrorMsg, 16, 1);
    RETURN -1; -- Código de error
END;
GO
```

</details> 

<details>

<summary>JSON</summary>

```json
{
  "proposalId": 3
}
```

</details> 

</details>

#### Crear Actualizar Propuesta

<details>
	<summary>Desplegar informacion</summary>

Esta funcion le permite a un usuario crear el boceto de una propuesta, sus versiones, los documenos y su poblacion meta.

La secuancia de pasos es la siguinte:

- Primero en el lado del endpoint, se recibe un json y sin procesarlo se le pasa a al Store procedure
- Dentro del sp se obtiene la cedula del usuario y con esta buscamos el idUser
- Verificamos que el usuario tiene el rol 'Proponente'
- Si es asi entonces pasamos a un sp auxiliar para crear o actualizar los datos basicos de la  propuesta y su version
- Dentro de este sp, verificamos que el usuario tiene los permisos para modificar las tablas de propuesta  y version
- Si la propuesta ya existe, actualizamos los valores requeridos
- Si no existe la creamos
- De igual manera, creamos una version nueva con los datos que vengan en el json y desactivamos la version anterior
- Luego volvemos al sp principal
- Y procedemos a insertar la configuracion de votacion
- Despues insertamos la poblacion meta y la asociamos a la configuracion de votacion
- De ultimos procedemos con los archivos, los guardamos en docs para que sean procesados para su verificacion

<details>
	  <summary>Ver codigo del lado de API</summary>

```python
import os
import json
import logging

import azure.functions as func
import pyodbc




def crearActualizarPropuesta(req: func.HttpRequest) -> func.HttpResponse:

    logging.info('Invocando crearActualizarPropuesta con JSON completo.')

    try:
        payload = req.get_json()
    except ValueError:
        return func.HttpResponse("JSON inválido.", status_code=400)

    # Leer la cadena de conexión desde Application Settings
    conn_str = os.getenv('SQL_CONNECTION_STRING')
    if not conn_str:
        logging.error("SqlConnection no configurada.")
        return func.HttpResponse("Error de configuración del servidor.", status_code=500)

    try:
        # Conectarse a SQL Server
        cnxn = pyodbc.connect(conn_str)
        cur = cnxn.cursor()

        # Preparamos un batch para invocar el SP con parámetros OUTPUT
        tsql = """
        DECLARE
            @newConfigId   INT,
            @outProposalId INT,
            @outVersionId  INT;

        EXEC dbo.vpvSP_CrearActualizarPropuesta
            @jsonAll          = ?,
            @newConfigId      = @newConfigId OUTPUT,
            @outProposalId    = @outProposalId OUTPUT,
            @outVersionId     = @outVersionId OUTPUT;

        SELECT
            @newConfigId   AS votingConfigId,
            @outProposalId AS proposalId,
            @outVersionId  AS versionId;
        """

        # Ejecutar pasando el JSON serializado
        cur.execute(tsql, json.dumps(payload))

        # Leer los resultados
        row = cur.fetchone()
        cnxn.commit()
        cur.close()
        cnxn.close()

        if not row:
            raise Exception("El SP no devolvió ningún resultado.")

        result = {
            "status": "ok",
            "votingConfigId": row.votingConfigId,
            "proposalId":     row.proposalId,
            "versionId":      row.versionId
        }
        return func.HttpResponse(
            json.dumps(result),
            status_code=200,
            mimetype="application/json"
        )

    except Exception as e:
        logging.error(f"Error ejecutando SP: {e}")
        return func.HttpResponse(
            f"Error interno: {str(e)}",
            status_code=500
        )
```
  </details>


 <details>
	 <summary>Ver vpvSP_CrearActualizarPropuesta</summary>

  ```sql
-----------------------------------------------------------
-- Autor: Daniel Sequeira
-- Fecha: 06/09/2025
-- Descripción: Orquesta todo el flujo de creación de una propuesta
--              a partir de un único JSON que agrupa:
--                - votingConfig
--                - targetPopulations
--                - proposal
--                - documents
-- Recibe:
--   @jsonAll           NVARCHAR(MAX) JSON con la siguiente estructura:
--   {
--     "user": " ... ",
--     "proposal": { … },
--     "votingConfig": { … },
--     "targetPopulations": { "targetPopulations": [ … ] },
--     "documents": [ … ]
--   }
-- Devuelve por OUTPUT:
--   @newConfigId       INT   – idVotingConfig
--   @outProposalId     INT   – proposalId
--   @outVersionId      INT   – proposalVersionId
-----------------------------------------------------------
CREATE OR ALTER PROCEDURE dbo.vpvSP_CrearActualizarPropuesta
    @jsonAll           NVARCHAR(MAX),
    @newConfigId       INT           OUTPUT,
    @outProposalId     INT           OUTPUT,
    @outVersionId      INT           OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE 
        @idUser       INT,
        @hasIt        BIT,
        @inTrans      BIT = 0,
        @eNum         INT,
        @eSev         INT,
        @eSta         INT,
        @eMsg         NVARCHAR(4000);

    -----------------------------------------------------------------
    -- 0) Desencriptar y extraer usuario
    -----------------------------------------------------------------
    OPEN SYMMETRIC KEY llavecedula
      DECRYPTION BY PASSWORD = 'ClaveCedula@1';

    SELECT @idUser = u.idUser
    FROM dbo.vpv_Users AS u
    WHERE CONVERT(NVARCHAR(50),
          DecryptByKey(CAST(u.id_card AS VARBINARY(MAX)))
    ) = JSON_VALUE(@jsonAll, '$.user');

    CLOSE SYMMETRIC KEY llavecedula;

    IF @idUser IS NULL
    BEGIN
        INSERT INTO dbo.vpv_logs (description, computer, username, trace, referenceId1, referenceId2, value1, value2, chechsum, logSeverityId, logSourceId, logTypeId)
          VALUES ('Usuario no encontrado en vpv_Users', @@SERVERNAME, HOST_NAME(),
                  'vpvSP_CrearActualizarPropuesta', JSON_VALUE(@jsonAll,'$.user'),
                  NULL, NULL, NULL, 0x0,
                  (SELECT logSeverityId FROM dbo.vpv_logSeverity WHERE [name]='High'),
                  (SELECT logSourceId   FROM dbo.vpv_logsSources WHERE [name]='API'),
                  (SELECT logTypeId     FROM dbo.vpv_logTypes   WHERE [name]='Error'));
        -- Mensaje 50200
        RAISERROR(50200, 16, 1);
        RETURN;
    END

    -----------------------------------------------------------------
    -- 1) Verificar rol "Proponente"
    -----------------------------------------------------------------
    EXEC dbo.vpvSP_UserHasRole
        @idUser   = @idUser,
        @roleName = 'Proponente',
        @HasRole  = @hasIt OUTPUT;

    IF @hasIt = 0
    BEGIN
        INSERT INTO dbo.vpv_logs (description, computer, username, trace, referenceId1, referenceId2, value1, value2, chechsum, logSeverityId, logSourceId, logTypeId)
          VALUES ('Usuario sin rol Proponente', @@SERVERNAME, HOST_NAME(),
                  'vpvSP_UserHasRole', CAST(@idUser AS VARCHAR(10)), NULL,
                  NULL, NULL, 0x0,
                  (SELECT logSeverityId FROM dbo.vpv_logSeverity WHERE [name]='Medium'),
                  (SELECT logSourceId   FROM dbo.vpv_logsSources WHERE [name]='Security'),
                  (SELECT logTypeId     FROM dbo.vpv_logTypes   WHERE [name]='Warning'));
        -- Mensaje 50201 con parámetro @idUser
        RAISERROR(50201, 16, 1, @idUser);
        RETURN;
    END

    -----------------------------------------------------------------
    -- 2) Iniciar transacción
    -----------------------------------------------------------------
    IF @@TRANCOUNT = 0
    BEGIN
        SET @inTrans = 1;
        SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
        BEGIN TRANSACTION;
    END

    BEGIN TRY
        -----------------------------------------------------------------
        -- A) Upsert Proposal + Version
        -----------------------------------------------------------------
        DECLARE @jp NVARCHAR(MAX) = JSON_QUERY(@jsonAll, '$.proposal');
        EXEC dbo.vpvSP_UpsertProposalWithVersion
            @jsonProposal = @jp,
            @idUser       = @idUser,
            @outProposalId= @outProposalId OUTPUT,
            @outVersionId = @outVersionId OUTPUT;

        INSERT INTO dbo.vpv_logs (description, computer, username, trace, referenceId1, referenceId2, value1, value2, chechsum, logSeverityId, logSourceId, logTypeId) VALUES
          ('UpsertProposalWithVersion completado', @@SERVERNAME, HOST_NAME(),
           'vpvSP_UpsertProposalWithVersion',
           CAST(@outProposalId AS VARCHAR(10)), CAST(@outVersionId AS VARCHAR(10)),
           NULL, NULL, 0x0,
           (SELECT logSeverityId FROM dbo.vpv_logSeverity WHERE [name]='Informational'),
           (SELECT logSourceId   FROM dbo.vpv_logsSources WHERE [name]='Database'),
           (SELECT logTypeId     FROM dbo.vpv_logTypes   WHERE [name]='Audit'));

        -----------------------------------------------------------------
        -- B) Insert VotingConfig
        -----------------------------------------------------------------
        DECLARE @jc NVARCHAR(MAX) = JSON_QUERY(@jsonAll, '$.votingConfig');
        EXEC dbo.vpvSP_InsertVotingConfig
            @jsonConfig        = @jc,
            @idUser            = @idUser,
            @idProposalVersion = @outVersionId,
            @newConfigId       = @newConfigId OUTPUT;

        INSERT INTO dbo.vpv_logs (description, computer, username, trace, referenceId1, referenceId2, value1, value2, chechsum, logSeverityId, logSourceId, logTypeId) VALUES
          ('InsertVotingConfig completado', @@SERVERNAME, HOST_NAME(),
           'vpvSP_InsertVotingConfig', CAST(@newConfigId AS VARCHAR(10)), NULL,
           NULL, NULL, 0x0,
           (SELECT logSeverityId FROM dbo.vpv_logSeverity WHERE [name]='Informational'),
           (SELECT logSourceId   FROM dbo.vpv_logsSources WHERE [name]='Database'),
           (SELECT logTypeId     FROM dbo.vpv_logTypes   WHERE [name]='Audit'));

        -----------------------------------------------------------------
        -- C) Insert Target Populations
        -----------------------------------------------------------------
        DECLARE @jtp NVARCHAR(MAX) = JSON_QUERY(@jsonAll, '$.targetPopulations');
        EXEC dbo.vpvSP_InsertTargetPopulationsVoting
            @jsonTPV        = @jtp,
            @idUser         = @idUser,
            @idVotingConfig = @newConfigId;

        INSERT INTO dbo.vpv_logs (description, computer, username, trace, referenceId1, referenceId2, value1, value2, chechsum, logSeverityId, logSourceId, logTypeId) VALUES
          ('InsertTargetPopulationsVoting completado', @@SERVERNAME, HOST_NAME(),
           'vpvSP_InsertTargetPopulationsVoting', CAST(@newConfigId AS VARCHAR(10)), NULL,
           NULL, NULL, 0x0,
           (SELECT logSeverityId FROM dbo.vpv_logSeverity WHERE [name]='Informational'),
           (SELECT logSourceId   FROM dbo.vpv_logsSources WHERE [name]='Database'),
           (SELECT logTypeId     FROM dbo.vpv_logTypes   WHERE [name]='Audit'));

        -----------------------------------------------------------------
        -- D) Insert Documents
        -----------------------------------------------------------------
        DECLARE @jd NVARCHAR(MAX) = JSON_QUERY(@jsonAll, '$.documents');
        EXEC dbo.vpvSP_InsertProposalDocuments
            @jsonInput         = @jd,
            @idUser            = @idUser,
            @proposalId        = @outProposalId,
            @proposalVersionId = @outVersionId;

        INSERT INTO dbo.vpv_logs (description, computer, username, trace, referenceId1, referenceId2, value1, value2, chechsum, logSeverityId, logSourceId, logTypeId) VALUES
          ('InsertProposalDocuments completado', @@SERVERNAME, HOST_NAME(),
           'vpvSP_InsertProposalDocuments', CAST(@outProposalId AS VARCHAR(10)), NULL,
           NULL, NULL, 0x0,
           (SELECT logSeverityId FROM dbo.vpv_logSeverity WHERE [name]='Informational'),
           (SELECT logSourceId   FROM dbo.vpv_logsSources WHERE [name]='Database'),
           (SELECT logTypeId     FROM dbo.vpv_logTypes   WHERE [name]='Audit'));

        -----------------------------------------------------------------
        -- Commit final
        -----------------------------------------------------------------
        IF @inTrans = 1
            COMMIT;
    END TRY

    BEGIN CATCH
        IF @inTrans = 1
            ROLLBACK;

        SET @eNum = ERROR_NUMBER();
        SET @eSev = ERROR_SEVERITY();
        SET @eSta = ERROR_STATE();
        SET @eMsg = ERROR_MESSAGE();

        -- Mensaje 50202 con detalle
        RAISERROR(50202, @eSev, @eSta, @eMsg, @eNum);
    END CATCH
END;
GO
```
		 
 </details>

 <details>
	 <summary>Ver vpvSP_UpsertProposalWithVersion</summary>

  ```sql
-----------------------------------------------------------
-- Autor: Daniel Sequeira
-- Fecha: 04/25/2025
-- Descripcion: Crea o actualiza una propuesta y su versión.
-- Si la propuesta es nueva, se inserta en ambas tablas.
-- Si ya existe, actualiza la propuesta y crea una nueva versión,
-- deshabilitando las anteriores.
-- Recibe un JSON con la información de la propuesta.
-- Devuelve los ID de propuesta y versión por OUTPUT.
-----------------------------------------------------------
CREATE OR ALTER PROCEDURE [dbo].[vpvSP_UpsertProposalWithVersion]
    @jsonProposal    NVARCHAR(MAX),
    @idUser          INT,
    @outProposalId   INT OUTPUT,
    @outVersionId    INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

	DECLARE @tienePermiso BIT;
	DECLARE @permissionResource VARCHAR(100);
	DECLARE @permissionAction VARCHAR(100);
	
	SET @permissionResource = 'vpv_proposals';
	SET @permissionAction = 'INSERT';
	EXEC dbo.vpvSP_UsuarioPuede
  		@idUser       = @idUser,
  		@resourceName = @permissionResource,
  		@actionName   = @permissionAction,
  		@Puede        = @tienePermiso OUTPUT;

    IF @tienePermiso = 0
    BEGIN
        RAISERROR(50241,16,1,@permissionResource,@permissionAction);
        RETURN;
    END;

	SET @permissionResource = 'vpv_proposals';
	SET @permissionAction = 'SELECT';
	EXEC dbo.vpvSP_UsuarioPuede
  		@idUser       = @idUser,
  		@resourceName = @permissionResource,
  		@actionName   = @permissionAction,
  		@Puede        = @tienePermiso OUTPUT;

    IF @tienePermiso = 0
    BEGIN
        RAISERROR(50241,16,1,@permissionResource,@permissionAction);
        RETURN;
    END;

	SET @permissionResource = 'vpv_proposals';
	SET @permissionAction = 'UPDATE';
	EXEC dbo.vpvSP_UsuarioPuede
  		@idUser       = @idUser,
  		@resourceName = @permissionResource,
  		@actionName   = @permissionAction,
  		@Puede        = @tienePermiso OUTPUT;

    IF @tienePermiso = 0 
	BEGIN
        RAISERROR(50241,16,1,@permissionResource,@permissionAction);
        RETURN;
    END;

	SET @permissionResource = 'vpv_schedules';
	SET @permissionAction = 'SELECT';
	EXEC dbo.vpvSP_UsuarioPuede
  		@idUser       = @idUser,
  		@resourceName = @permissionResource,
  		@actionName   = @permissionAction,
  		@Puede        = @tienePermiso OUTPUT;

    IF @tienePermiso = 0
    BEGIN
        RAISERROR(50241,16,1,@permissionResource,@permissionAction);
        RETURN;
    END;

	SET @permissionResource = 'vpv_processStatus';
	SET @permissionAction = 'SELECT';
	EXEC dbo.vpvSP_UsuarioPuede
  		@idUser       = @idUser,
  		@resourceName = @permissionResource,
  		@actionName   = @permissionAction,
  		@Puede        = @tienePermiso OUTPUT;

    IF @tienePermiso = 0
    BEGIN
        RAISERROR(50241,16,1,@permissionResource,@permissionAction);
        RETURN;
    END;

	SET @permissionResource = 'vpv_proposalTypes';
	SET @permissionAction = 'SELECT';
	EXEC dbo.vpvSP_UsuarioPuede
  		@idUser       = @idUser,
  		@resourceName = @permissionResource,
  		@actionName   = @permissionAction,
  		@Puede        = @tienePermiso OUTPUT;

    IF @tienePermiso = 0
    BEGIN
        RAISERROR(50241,16,1,@permissionResource,@permissionAction);
        RETURN;
    END;

	SET @permissionResource = 'vpv_proposalVersions';
	SET @permissionAction = 'INSERT';
	EXEC dbo.vpvSP_UsuarioPuede
  		@idUser       = @idUser,
  		@resourceName = @permissionResource,
  		@actionName   = @permissionAction,
  		@Puede        = @tienePermiso OUTPUT;

    IF @tienePermiso = 0
    BEGIN
        RAISERROR(50241,16,1,@permissionResource,@permissionAction);
        RETURN;
    END;

	SET @permissionResource = 'vpv_proposalVersions';
	SET @permissionAction = 'UPDATE';
	EXEC dbo.vpvSP_UsuarioPuede
  		@idUser       = @idUser,
  		@resourceName = @permissionResource,
  		@actionName   = @permissionAction,
  		@Puede        = @tienePermiso OUTPUT;

    IF @tienePermiso = 0
    BEGIN
        RAISERROR(50241,16,1,@permissionResource,@permissionAction);
        RETURN;
    END;	

    DECLARE 
        @ErrorNumber       INT,
        @ErrorSeverity     INT,
        @ErrorState        INT,
        @CustomError       INT = 50221,  -- Código para errores internos
        @Message           VARCHAR(200),
        @InicieTransaccion BIT,
        @tittle                    NVARCHAR(100)   = JSON_VALUE(@jsonProposal, '$.tittle'),
        @description               NVARCHAR(500)   = JSON_VALUE(@jsonProposal, '$.description'),
        @versionContent            NVARCHAR(500)   = JSON_VALUE(@jsonProposal, '$.content'),
        @entitydid                 INT             = JSON_VALUE(@jsonProposal, '$.entitydid'),
        @schedule                  NVARCHAR(200)   = JSON_VALUE(@jsonProposal, '$.schedule'),
        @status                    NVARCHAR(100)   = JSON_VALUE(@jsonProposal, '$.status'),
        @budget                    DECIMAL(10,8)   = TRY_CAST(JSON_VALUE(@jsonProposal, '$.budget') AS DECIMAL(10,8)),
        @idTargetPopulation        INT             = JSON_VALUE(@jsonProposal, '$.idTargetPopulation'),
        @proposalType              NVARCHAR(100)   = JSON_VALUE(@jsonProposal, '$.proposalType'),
        @proposalTypeId_semantica  NVARCHAR(50)    = JSON_VALUE(@jsonProposal, '$.proposalTypeId_semantica'),
        @relacion                  NVARCHAR(500)   = JSON_VALUE(@jsonProposal, '$.relacion'),
        @startingDate              DATETIME        = TRY_CAST(JSON_VALUE(@jsonProposal, '$.startingDate') AS DATETIME),
        @now                       DATETIME        = GETDATE(),
        @proposalId                INT,
        @versionId                 INT,
        @checksum                  VARBINARY(255);

    -- Obtener FKs intermedias
    DECLARE @scheduleId INT;
    SELECT TOP 1 @scheduleId = s.scheduleId
      FROM dbo.vpv_schedules AS s
     WHERE s.name = @schedule;
    IF @scheduleId IS NULL
    BEGIN
        RAISERROR(50273, 16, 1, @schedule);
        RETURN;
    END;

    DECLARE @statusId INT;
    SELECT TOP 1 @statusId = ps.statusId
      FROM dbo.vpv_processStatus AS ps
     WHERE ps.name = @status;
    IF @statusId IS NULL
    BEGIN
        RAISERROR(50274, 16, 1, @status);
        RETURN;
    END;     

    DECLARE @proposalTypeId INT;
    SELECT TOP 1 @proposalTypeId = pt.proposalTypeId
      FROM dbo.vpv_proposalTypes AS pt
     WHERE pt.name = @proposalType;
    IF @proposalTypeId IS NULL
    BEGIN
        RAISERROR(50275, 16, 1, @proposalType);
        RETURN;
    END;

    -- Calcular checksum
    SET @checksum = HASHBYTES('SHA2_256', 
        CONCAT(@tittle, '|', CONVERT(VARCHAR(30),@now,126))
    );

    -- Iniciar transacción
    SET @InicieTransaccion = 0;
    IF @@TRANCOUNT = 0
    BEGIN
        SET @InicieTransaccion = 1;
        SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
        BEGIN TRANSACTION;
    END

    BEGIN TRY
        -- 1) Verificar existencia
        SELECT @proposalId = proposalId
          FROM dbo.vpv_proposals
         WHERE tittle = @tittle
           AND idUser = @idUser
           AND deleted = 0;

        IF @proposalId IS NULL
        BEGIN
            -- Inserción de nueva propuesta
            INSERT INTO dbo.vpv_proposals
            (
                idUser, entitydid, tittle, description, creationDate,
                scheduleId, enable, deleted, ckecksum, statusId,
                budget, idTargetPopulation, proposalTypeId, lastUpdate,
                startingDate, proposalTypeId_semantica, relacion
            )
            VALUES
            (
                @idUser, @entitydid, @tittle, @description, @now,
                @scheduleId, 1, 0, @checksum, @statusId,
                @budget, 1, @proposalTypeId, @now,
                @startingDate, @proposalTypeId_semantica, @relacion
            );
            SET @proposalId = SCOPE_IDENTITY();
            INSERT INTO dbo.vpv_logs (description, computer, username, trace, referenceId1, referenceId2, value1, value2, chechsum, logSeverityId, logSourceId, logTypeId) VALUES
            ('Nueva propuesta creada', @@SERVERNAME, HOST_NAME(),
            'vpvSP_UpsertProposalWithVersion',
            CAST(@description AS VARCHAR(10)), CAST(@outVersionId AS VARCHAR(10)),
            NULL, NULL, 0x0,
            (SELECT logSeverityId FROM dbo.vpv_logSeverity WHERE [name]='Informational'),
            (SELECT logSourceId   FROM dbo.vpv_logsSources WHERE [name]='Database'),
            (SELECT logTypeId     FROM dbo.vpv_logTypes   WHERE [name]='Audit'));

        END
        ELSE
        BEGIN
            -- Actualización de propuesta existente
            UPDATE dbo.vpv_proposals
               SET description                = @description,
                   lastUpdate                 = @now,
                   scheduleId                 = @scheduleId,
                   statusId                   = @statusId,
                   budget                     = @budget,
                   idTargetPopulation         = 1,
                   proposalTypeId             = @proposalTypeId,
                   startingDate               = @startingDate,
                   proposalTypeId_semantica   = @proposalTypeId_semantica,
                   relacion                   = @relacion,
                   ckecksum                   = @checksum
             WHERE proposalId = @proposalId;
            INSERT INTO dbo.vpv_logs (description, computer, username, trace, referenceId1, referenceId2, value1, value2, chechsum, logSeverityId, logSourceId, logTypeId) VALUES
                ('Propuesta actualizada', @@SERVERNAME, HOST_NAME(),
                'vpvSP_UpsertProposalWithVersion',
                CAST(@description AS VARCHAR(10)), CAST(@outVersionId AS VARCHAR(10)),
                NULL, NULL, 0x0,
                (SELECT logSeverityId FROM dbo.vpv_logSeverity WHERE [name]='Informational'),
                (SELECT logSourceId   FROM dbo.vpv_logsSources WHERE [name]='Database'),
                (SELECT logTypeId     FROM dbo.vpv_logTypes   WHERE [name]='Audit'));

        END

        -- 2) Deshabilitar versiones previas
        UPDATE dbo.vpv_proposalVersions
           SET enable      = 0,
               lastVersion = 0
         WHERE proposalId = @proposalId;

        -- 3) Insertar nueva versión
        INSERT INTO dbo.vpv_proposalVersions (
            tittle, content, creationDate, startingDate, scheduleId,
            enable, deleted, checksum, statusid, budget,
            lastUpdate, idUser, proposalId, lastVersion
        )
        VALUES (
            @tittle, @versionContent, @now, @startingDate, @scheduleId,
            1, 0, @checksum, @statusId, @budget,
            @now, @idUser, @proposalId, 1
        );
        SET @versionId = SCOPE_IDENTITY();
        INSERT INTO dbo.vpv_logs (description, computer, username, trace, referenceId1, referenceId2, value1, value2, chechsum, logSeverityId, logSourceId, logTypeId) VALUES
            ('Version de Propuesta creada', @@SERVERNAME, HOST_NAME(),
            'vpvSP_UpsertProposalWithVersion',
            CAST(@tittle AS VARCHAR(10)), CAST(@outVersionId AS VARCHAR(10)),
            NULL, NULL, 0x0,
            (SELECT logSeverityId FROM dbo.vpv_logSeverity WHERE [name]='Informational'),
            (SELECT logSourceId   FROM dbo.vpv_logsSources WHERE [name]='Database'),
            (SELECT logTypeId     FROM dbo.vpv_logTypes   WHERE [name]='Audit'));

        -- Salidas
        SET @outProposalId = @proposalId;
        SET @outVersionId  = @versionId;

        IF @InicieTransaccion = 1
            COMMIT;

        -- Mensaje de éxito
        -- RAISERROR(50220, 10, 1, @outProposalId, @outVersionId) WITH NOWAIT;
    END TRY
    BEGIN CATCH
        -- Capturar datos de error
        SET @ErrorNumber   = ERROR_NUMBER();
        SET @ErrorSeverity = ERROR_SEVERITY();
        SET @ErrorState    = ERROR_STATE();
        SET @Message       = ERROR_MESSAGE();

        IF @InicieTransaccion = 1
            ROLLBACK;

        -- Mensaje de fallo
        RAISERROR(50221, 16, 1, @Message, @CustomError);
        RETURN;
    END CATCH
END;
GO
```
 </details>

<details>
	<summary>Ver vpvSP_InsertVotingConfig</summary>

 ```sql
-- Stored Procedure para configurar votación desde JSON y retornar el ID insertado en parámetro OUTPUT
-----------------------------------------------------------
-- Autor: Daniel Sequeira
-- Fecha: 06/07/2025
-- Descripcion: Inserta una configuración de votación a partir de JSON
--              y retorna el id generado mediante un parámetro OUTPUT.
-- Parámetros:
--   @jsonConfig   NVARCHAR(MAX) JSON con campos:
--     proposalVersionId, openDate, closeDate, idStatusVoting,
--     idVotingType, description, weight (0/1), idReminderType,
--     idClosureTypes, idVotingReasons, executionPlanId,
--     metricPlanId, projectReportId, sponsorAgreementId
--   @newConfigId  INT OUTPUT     ID de la configuración creada
-----------------------------------------------------------
CREATE OR ALTER PROCEDURE [dbo].[vpvSP_InsertVotingConfig]
    @idUser INT,
    @jsonConfig   NVARCHAR(MAX),
    @idProposalVersion INT,
    @newConfigId  INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

	DECLARE @tienePermiso BIT;
	DECLARE @permissionResource VARCHAR(100);
	DECLARE @permissionAction VARCHAR(100);    

	SET @permissionResource = 'vpv_statusVoting';
	SET @permissionAction = 'SELECT';
	EXEC dbo.vpvSP_UsuarioPuede
  		@idUser       = @idUser,
  		@resourceName = @permissionResource,
  		@actionName   = @permissionAction,
  		@Puede        = @tienePermiso OUTPUT;

    IF @tienePermiso = 0
    BEGIN
        RAISERROR(50241,16,1,@permissionResource,@permissionAction);
        RETURN;
    END;

	SET @permissionResource = 'vpv_votingTypes';
	SET @permissionAction = 'SELECT';
	EXEC dbo.vpvSP_UsuarioPuede
  		@idUser       = @idUser,
  		@resourceName = @permissionResource,
  		@actionName   = @permissionAction,
  		@Puede        = @tienePermiso OUTPUT;

    IF @tienePermiso = 0
    BEGIN
        RAISERROR(50241,16,1,@permissionResource,@permissionAction);
        RETURN;
    END;

	SET @permissionResource = 'vpv_reminderTypes';
	SET @permissionAction = 'SELECT';
	EXEC dbo.vpvSP_UsuarioPuede
  		@idUser       = @idUser,
  		@resourceName = @permissionResource,
  		@actionName   = @permissionAction,
  		@Puede        = @tienePermiso OUTPUT;

    IF @tienePermiso = 0
    BEGIN
        RAISERROR(50241,16,1,@permissionResource,@permissionAction);
        RETURN;
    END;

	SET @permissionResource = 'vpv_ClosureTypes';
	SET @permissionAction = 'SELECT';
	EXEC dbo.vpvSP_UsuarioPuede
  		@idUser       = @idUser,
  		@resourceName = @permissionResource,
  		@actionName   = @permissionAction,
  		@Puede        = @tienePermiso OUTPUT;

    IF @tienePermiso = 0
    BEGIN
        RAISERROR(50241,16,1,@permissionResource,@permissionAction);
        RETURN;
    END;

	SET @permissionResource = 'vpv_votingReasons';
	SET @permissionAction = 'SELECT';
	EXEC dbo.vpvSP_UsuarioPuede
  		@idUser       = @idUser,
  		@resourceName = @permissionResource,
  		@actionName   = @permissionAction,
  		@Puede        = @tienePermiso OUTPUT;

    IF @tienePermiso = 0
    BEGIN
        RAISERROR(50241,16,1,@permissionResource,@permissionAction);
        RETURN;
    END;    

	SET @permissionResource = 'vpv_executionPlans';
	SET @permissionAction = 'SELECT';
	EXEC dbo.vpvSP_UsuarioPuede
  		@idUser       = @idUser,
  		@resourceName = @permissionResource,
  		@actionName   = @permissionAction,
  		@Puede        = @tienePermiso OUTPUT;

    IF @tienePermiso = 0
    BEGIN
        RAISERROR(50241,16,1,@permissionResource,@permissionAction);
        RETURN;
    END;  

	SET @permissionResource = 'vpv_MetricPerPlan';
	SET @permissionAction = 'SELECT';
	EXEC dbo.vpvSP_UsuarioPuede
  		@idUser       = @idUser,
  		@resourceName = @permissionResource,
  		@actionName   = @permissionAction,
  		@Puede        = @tienePermiso OUTPUT;

    IF @tienePermiso = 0
    BEGIN
        RAISERROR(50241,16,1,@permissionResource,@permissionAction);
        RETURN;
    END;  

	SET @permissionResource = 'vpv_projectReports';
	SET @permissionAction = 'SELECT';
	EXEC dbo.vpvSP_UsuarioPuede
  		@idUser       = @idUser,
  		@resourceName = @permissionResource,
  		@actionName   = @permissionAction,
  		@Puede        = @tienePermiso OUTPUT;

    IF @tienePermiso = 0
    BEGIN
        RAISERROR(50241,16,1,@permissionResource,@permissionAction);
        RETURN;
    END;  

	SET @permissionResource = 'vpv_votingConfigurations';
	SET @permissionAction = 'INSERT';
	EXEC dbo.vpvSP_UsuarioPuede
  		@idUser       = @idUser,
  		@resourceName = @permissionResource,
  		@actionName   = @permissionAction,
  		@Puede        = @tienePermiso OUTPUT;

    IF @tienePermiso = 0
    BEGIN
        RAISERROR(50241,16,1,@permissionResource,@permissionAction);
        RETURN;
    END;  

    DECLARE
        @openDate             DATETIME  = TRY_CONVERT(DATETIME, JSON_VALUE(@jsonConfig,'$.openDate')),
        @closeDate            DATETIME  = TRY_CONVERT(DATETIME, JSON_VALUE(@jsonConfig,'$.closeDate')),
        @creationDate         DATETIME  = GETDATE(),
        @statusVoting         VARCHAR(100)  = JSON_VALUE(@jsonConfig,'$.StatusVoting'),
        @votingType           VARCHAR(100)  = JSON_VALUE(@jsonConfig,'$.VotingType'),
        @description          VARCHAR(1000) = JSON_VALUE(@jsonConfig,'$.description'),
        @weight               BIT       = ISNULL(TRY_CAST(JSON_VALUE(@jsonConfig,'$.weight') AS BIT),0),
        @reminderType         VARCHAR(100)  = JSON_VALUE(@jsonConfig,'$.ReminderType'),
        @closureType          VARCHAR(200)  = JSON_VALUE(@jsonConfig,'$.ClosureTypes'),
        @votingReasons        VARCHAR(100)  = JSON_VALUE(@jsonConfig,'$.VotingReasons'),
        @executionPlan        VARCHAR(200)  = NULLIF(JSON_VALUE(@jsonConfig,'$.executionPlan'),''),
        @metricPlan           VARCHAR(200)  = NULLIF(JSON_VALUE(@jsonConfig,'$.metricPlan'),''),
        @projectReport        VARCHAR(200)  = NULLIF(JSON_VALUE(@jsonConfig,'$.projectReport'),''),
        @sponsorAgreementId   INT       = NULLIF(JSON_VALUE(@jsonConfig,'$.sponsorAgreementId'),''),
        @checksum             VARBINARY(255),
        @InTrans              BIT,
        @ErrorNum          INT,
        @ErrorSev          INT,
        @ErrorSta          INT,
        @ErrorMsg          NVARCHAR(4000),
        @CustomError       INT  = 50240;

    DECLARE @statusVotingId INT;
    SELECT TOP 1 @statusVotingId = sv.idStatusVoting FROM dbo.vpv_statusVoting AS sv WHERE sv.name  = @statusVoting;
    IF @statusVotingId IS NULL
    BEGIN
        RAISERROR(50268, 16, 1, @statusVoting);
        RETURN;
    END;    

    DECLARE @votingTypeId INT;
    SELECT TOP 1 @votingTypeId = vt.idVotingType FROM dbo.vpv_votingTypes AS vt WHERE vt.name  = @votingType;
    IF @votingTypeId IS NULL
    BEGIN
        RAISERROR(50269, 16, 1, @votingType);
        RETURN;
    END;    

    DECLARE @reminderTypeId INT;
    SELECT TOP 1 @reminderTypeId = rt.idReminderType FROM dbo.vpv_reminderTypes AS rt WHERE rt.name  = @reminderType;
    IF @reminderTypeId IS NULL
    BEGIN
        RAISERROR(50270, 16, 1, @reminderType);
        RETURN;
    END;    

    DECLARE @closureTypeId INT;
    SELECT TOP 1 @closureTypeId = ct.idClosureTypes FROM dbo.vpv_ClosureTypes AS ct WHERE ct.name  = @closureType;
    IF @closureTypeId IS NULL
    BEGIN
        RAISERROR(50271, 16, 1, @closureType);
        RETURN;
    END;    

    DECLARE @votingReasonsId INT;
    SELECT TOP 1 @votingReasonsId = vr.idvotingReasons FROM dbo.vpv_votingReasons AS vr WHERE vr.name  = @votingReasons;
    IF @votingReasonsId IS NULL
    BEGIN
        RAISERROR(50272, 16, 1, @votingReasons);
        RETURN;
    END;    

    DECLARE @executionPlanId INT;
    SELECT TOP 1 @executionPlanId = ep.executionPlanId FROM dbo.vpv_executionPlans AS ep WHERE ep.tittle  = @executionPlan;


    DECLARE @metricPlanId  INT;
    SELECT TOP 1 @metricPlanId  = mp.metricPlanId FROM dbo.vpv_MetricPerPlan AS mp WHERE mp.name  = @metricPlan;

    DECLARE @projectReportId  INT;
    SELECT TOP 1 @projectReportId  = pr.projectReportId FROM dbo.vpv_projectReports AS pr WHERE pr.tittle  = @projectReport;



    -- Calcular checksum
    SET @checksum = HASHBYTES('SHA2_256',
        CONCAT(
            @idProposalVersion,
            CONVERT(VARCHAR(126),@openDate,126),
            CONVERT(VARCHAR(126),@closeDate,126),
            @statusVotingId,
            @votingTypeId,
            @description,
            @weight,
            @reminderTypeId,
            @closureTypeId,
            @votingReasonsId,
            COALESCE(CONVERT(VARCHAR(10),@executionPlanId),''),
            COALESCE(CONVERT(VARCHAR(10),@metricPlanId),''),
            COALESCE(CONVERT(VARCHAR(10),@projectReportId),''),
            COALESCE(CONVERT(VARCHAR(10),@sponsorAgreementId),''),
            CONVERT(VARCHAR(126),@creationDate,126)
        )
    );

    -- Iniciar transacción
    SET @InTrans=0;
    IF @@TRANCOUNT=0
    BEGIN
        SET @InTrans=1; 
        SET TRANSACTION ISOLATION LEVEL READ COMMITTED; 
        BEGIN TRANSACTION; 
    END

    BEGIN TRY
        INSERT INTO dbo.vpv_votingConfigurations
        (
          proposalVersionId, openDate, closeDate, creationDate,
          idStatusVoting, idVotingType, description, weight,
          checksum, idReminderType, idClosureTypes, idvotingReasons,
          executionPlanId, metricPlanId, projectReportId, sponsorAgreementId
        )
        VALUES
        (
          @idProposalVersion, @openDate, @closeDate, @creationDate,
          @statusVotingId, @votingTypeId, @description, @weight,
          @checksum, @reminderTypeId, @closureTypeId, @votingReasonsId,
          @executionPlanId, @metricPlanId, @projectReportId, @sponsorAgreementId
        );

        -- Capturar el ID generado
        SET @newConfigId = SCOPE_IDENTITY();

        INSERT INTO dbo.vpv_logs (description, computer, username, trace, referenceId1, referenceId2, value1, value2, chechsum, logSeverityId, logSourceId, logTypeId) VALUES
          ('Nueva configuracion de votacion', @@SERVERNAME, HOST_NAME(),
           'vpvSP_InsertVotingConfig', CAST(@newConfigId AS VARCHAR(10)), NULL,
           NULL, NULL, 0x0,
           (SELECT logSeverityId FROM dbo.vpv_logSeverity WHERE [name]='Informational'),
           (SELECT logSourceId   FROM dbo.vpv_logsSources WHERE [name]='Database'),
           (SELECT logTypeId     FROM dbo.vpv_logTypes   WHERE [name]='Audit'));

        IF @InTrans=1 COMMIT;
    END TRY
    BEGIN CATCH
        IF @InTrans=1 ROLLBACK;
        THROW;

        SET @ErrorNum = ERROR_NUMBER();
        SET @ErrorSev = ERROR_SEVERITY();
        SET @ErrorSta = ERROR_STATE();
        SET @ErrorMsg = ERROR_MESSAGE();

        -- usa un número de mensaje personalizado
        RAISERROR(50242,16,1,@ErrorMsg,@CustomError);
    END CATCH;
END;
GO
```
</details>


<details>
	<summary>Ver vpvSP_InsertTargetPopulationsVoting</summary>

 ```sql
-- Stored Procedure para poblar vpv_TargetPopulationsVoting usando JSON y un idVotingConfig fijo,
-- y retornar el último id insertado como parámetro OUTPUT
-----------------------------------------------------------
-- Autor: Daniel Sequeira
-- Fecha: 06/08/2025
-- Descripcion: Inserta registros en vpv_TargetPopulationsVoting usando un idVotingConfig fijo (1)
--              a partir de un arreglo de poblaciones con name y weight, y devuelve en @lastId
--              el idTargetPopulationsVoting de la última inserción.
-- Parámetros:
--   @jsonTPV     NVARCHAR(MAX) JSON con campos:
--                   targetPopulations: arreglo de objetos { name, weight }
--   @lastId      INT OUTPUT    ID de la última fila insertada en vpv_TargetPopulationsVoting
-----------------------------------------------------------
CREATE OR ALTER PROCEDURE [dbo].[vpvSP_InsertTargetPopulationsVoting]
  @idUser          INT,
  @jsonTPV         NVARCHAR(MAX),
  @idVotingConfig  INT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE 
        @tienePermiso      BIT,
        @permissionResource VARCHAR(100),
        @permissionAction   VARCHAR(100),
        @InTrans            BIT = 0,
        @ErrNum             INT,
        @ErrSev             INT,
        @ErrSta             INT,
        @ErrMsg             NVARCHAR(4000),
        @tp                 NVARCHAR(MAX),
        @popName            NVARCHAR(50),
        @popWeight          DECIMAL(5,2),
        @popId              INT,
        @checksum           NVARCHAR(255);

    -- Permisos SELECT sobre TargetPopulations
    SET @permissionResource = 'vpv_TargetPopulations';
    SET @permissionAction   = 'SELECT';
    EXEC dbo.vpvSP_UsuarioPuede
         @idUser       = @idUser,
         @resourceName = @permissionResource,
         @actionName   = @permissionAction,
         @Puede        = @tienePermiso OUTPUT;
    IF @tienePermiso = 0
    BEGIN
        RAISERROR(50241, 16, 1, @permissionResource, @permissionAction);
        RETURN;
    END

    -- Permisos INSERT sobre TargetPopulationsVoting
    SET @permissionResource = 'vpv_TargetPopulationsVoting';
    SET @permissionAction   = 'INSERT';
    EXEC dbo.vpvSP_UsuarioPuede
         @idUser       = @idUser,
         @resourceName = @permissionResource,
         @actionName   = @permissionAction,
         @Puede        = @tienePermiso OUTPUT;
    IF @tienePermiso = 0
    BEGIN
        RAISERROR(50241, 16, 1, @permissionResource, @permissionAction);
        RETURN;
    END

    -- Iniciar transacción si no hay ninguna activa
    IF @@TRANCOUNT = 0
    BEGIN
        SET @InTrans = 1;
        SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
        BEGIN TRANSACTION;
    END

    BEGIN TRY
        -- Recorrer arreglo targetPopulations
        DECLARE tp_cursor CURSOR FAST_FORWARD FOR
            SELECT value 
              FROM OPENJSON(@jsonTPV, '$.targetPopulations');

        OPEN tp_cursor;
        FETCH NEXT FROM tp_cursor INTO @tp;

        WHILE @@FETCH_STATUS = 0
        BEGIN
            SET @popName   = JSON_VALUE(@tp, '$.name');
            SET @popWeight = TRY_CAST(JSON_VALUE(@tp, '$.weight') AS DECIMAL(5,2));

            -- Buscar idTargetPopulation
            SELECT TOP 1 @popId = idTargetPopulation
              FROM dbo.vpv_TargetPopulations
             WHERE [name]  = @popName
               AND enable  = 1;

            IF @popId IS NULL
            BEGIN
                -- 50262: población no encontrada
                RAISERROR(50262, 16, 1, @popName);
                IF @InTrans = 1 ROLLBACK;
                CLOSE tp_cursor; DEALLOCATE tp_cursor;
                RETURN;
            END

            SET @checksum = 'TPV_' + CAST(@idVotingConfig AS VARCHAR(10)) + '_' + @popName;

            INSERT INTO dbo.vpv_TargetPopulationsVoting
                (idVotingConfig, idTargetPopulation, checksum, enable, weight)
            VALUES
                (@idVotingConfig, @popId, @checksum, 1, ISNULL(@popWeight,1));

            INSERT INTO dbo.vpv_logs (description, computer, username, trace, referenceId1, referenceId2, value1, value2, chechsum, logSeverityId, logSourceId, logTypeId) VALUES
                ('Nuevo target population voting completado ' + @popName, @@SERVERNAME, HOST_NAME(),
                'vpvSP_InsertTargetPopulationsVoting', CAST(@idVotingConfig AS VARCHAR(10)), NULL,
                NULL, NULL, 0x0,
                (SELECT logSeverityId FROM dbo.vpv_logSeverity WHERE [name]='Informational'),
                (SELECT logSourceId   FROM dbo.vpv_logsSources WHERE [name]='Database'),
                (SELECT logTypeId     FROM dbo.vpv_logTypes   WHERE [name]='Audit'));

            FETCH NEXT FROM tp_cursor INTO @tp;
        END

        CLOSE tp_cursor;
        DEALLOCATE tp_cursor;

        IF @InTrans = 1
            COMMIT;
    END TRY
    BEGIN CATCH
        SET @ErrNum = ERROR_NUMBER();
        SET @ErrSev = ERROR_SEVERITY();
        SET @ErrSta = ERROR_STATE();
        SET @ErrMsg = ERROR_MESSAGE();

        IF @InTrans = 1
            ROLLBACK;

        RAISERROR(
            'vpvSP_InsertTargetPopulationsVoting falló: %s (Código %d)',
            @ErrSev, @ErrSta, @ErrMsg, @ErrNum
        );
    END CATCH
END
GO
```
</details>


<details>
	<summary>Ver vpvSP_InsertProposalDocuments</summary>

 ```sql
-----------------------------------------------------------
-- Autor: Daniel Sequeira
-- Fecha: 06/09/2025
-- Descripcion: Inserta identitydocs, vpv_docs y vpv_FilesPerProposal
--              a partir de un JSON con una lista anidada de documentos.
-- Recibe:
--   @jsonInput         NVARCHAR(MAX) JSON con un array de objetos:
--     [
--       {
--         "identitytypeid": …,
--         "identitystateid": …,
--         "name": "…",
--         "field1": "…",
--         "field2": "…",
--         "temporary": 0|1,
--         "expirationdate": "YYYY-MM-DDThh:mm:ss",
--         "referenceVal": …,
--         "referenceId": "…",
--         "formatid": …,
--         "docstypeid": …,
--         "docstateid": …,
--         "archive": "BASE64…",
--         "filename": "…",
--         "date": "YYYY-MM-DDThh:mm:ss",
--         "startdate": "…",
--         "nextcheckdate": "…",
--         "semantic_category": "…",
--         "docEnable": 0|1,
--         "fileEnable": 0|1,
--         "relacion": "…"
--       },
--       { … }
--     ]
--   @proposalId        INT  ID de la propuesta padre
--   @proposalVersionId INT  ID de la versión de la propuesta
-----------------------------------------------------------
CREATE OR ALTER PROCEDURE [dbo].[vpvSP_InsertProposalDocuments]
    @jsonInput         NVARCHAR(MAX),
    @idUser INT,
    @proposalId        INT,
    @proposalVersionId INT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE
        @InicieTransaccion BIT = 0,
        @item              NVARCHAR(MAX),
        @identitydocsid    INT,
        @docid             INT;

	DECLARE @tienePermiso BIT;
	DECLARE @permissionResource VARCHAR(100);
	DECLARE @permissionAction VARCHAR(100);
	
	SET @permissionResource = 'vpv_identitytype';
	SET @permissionAction = 'SELECT';
	EXEC dbo.vpvSP_UsuarioPuede
  		@idUser       = @idUser,
  		@resourceName = @permissionResource,
  		@actionName   = @permissionAction,
  		@Puede        = @tienePermiso OUTPUT;

    IF @tienePermiso = 0
    BEGIN
        RAISERROR(50241, 16, 1, @permissionResource, @permissionAction);
        RETURN;
    END;

	SET @permissionResource = 'vpv_identitystates';
	SET @permissionAction = 'SELECT';
	EXEC dbo.vpvSP_UsuarioPuede
  		@idUser       = @idUser,
  		@resourceName = @permissionResource,
  		@actionName   = @permissionAction,
  		@Puede        = @tienePermiso OUTPUT;

    IF @tienePermiso = 0
    BEGIN
        RAISERROR(50241, 16, 1, @permissionResource, @permissionAction);
        RETURN;
    END;

	SET @permissionResource = 'vpv_formats';
	SET @permissionAction = 'SELECT';
	EXEC dbo.vpvSP_UsuarioPuede
  		@idUser       = @idUser,
  		@resourceName = @permissionResource,
  		@actionName   = @permissionAction,
  		@Puede        = @tienePermiso OUTPUT;

    IF @tienePermiso = 0
    BEGIN
        RAISERROR(50241, 16, 1, @permissionResource, @permissionAction);
        RETURN;
    END;

	SET @permissionResource = 'vpv_docstypes';
	SET @permissionAction = 'SELECT';
	EXEC dbo.vpvSP_UsuarioPuede
  		@idUser       = @idUser,
  		@resourceName = @permissionResource,
  		@actionName   = @permissionAction,
  		@Puede        = @tienePermiso OUTPUT;

    IF @tienePermiso = 0
    BEGIN
        RAISERROR(50241, 16, 1, @permissionResource, @permissionAction);
        RETURN;
    END;

	SET @permissionResource = 'vpv_docstates';
	SET @permissionAction = 'SELECT';
	EXEC dbo.vpvSP_UsuarioPuede
  		@idUser       = @idUser,
  		@resourceName = @permissionResource,
  		@actionName   = @permissionAction,
  		@Puede        = @tienePermiso OUTPUT;

    IF @tienePermiso = 0
    BEGIN
        RAISERROR(50241, 16, 1, @permissionResource, @permissionAction);
        RETURN;
    END;

	SET @permissionResource = 'vpv_identitydocs';
	SET @permissionAction = 'INSERT';
	EXEC dbo.vpvSP_UsuarioPuede
  		@idUser       = @idUser,
  		@resourceName = @permissionResource,
  		@actionName   = @permissionAction,
  		@Puede        = @tienePermiso OUTPUT;

    IF @tienePermiso = 0
    BEGIN
        RAISERROR(50241, 16, 1, @permissionResource, @permissionAction);
        RETURN;
    END;

	SET @permissionResource = 'vpv_docs';
	SET @permissionAction = 'INSERT';
	EXEC dbo.vpvSP_UsuarioPuede
  		@idUser       = @idUser,
  		@resourceName = @permissionResource,
  		@actionName   = @permissionAction,
  		@Puede        = @tienePermiso OUTPUT;

    IF @tienePermiso = 0
    BEGIN
        RAISERROR(50241, 16, 1, @permissionResource, @permissionAction);
        RETURN;
    END;

	SET @permissionResource = 'vpv_FilesPerProposal';
	SET @permissionAction = 'INSERT';
	EXEC dbo.vpvSP_UsuarioPuede
  		@idUser       = @idUser,
  		@resourceName = @permissionResource,
  		@actionName   = @permissionAction,
  		@Puede        = @tienePermiso OUTPUT;

    IF @tienePermiso = 0
    BEGIN
        RAISERROR(50241, 16, 1, @permissionResource, @permissionAction);
        RETURN;
    END;


    -- Campos temporales para cada documento
    DECLARE
        @identitytype      VARCHAR(200),
        @identitystate     VARCHAR(100),
        @idName            NVARCHAR(150),
        @field1            NVARCHAR(250),
        @field2            NVARCHAR(250),
        @temporary         BIT,
        @expirationdate    DATETIME,
        @referenceVal      INT,
        @referenceId       NVARCHAR(25),
        @format            VARCHAR(100),
        @docstype          VARCHAR(100),
        @docstate          VARCHAR(100),
        @archiveBase64     NVARCHAR(MAX),
        @archive           VARBINARY(MAX),
        @filename          NVARCHAR(100),
        @docDate           DATETIME,
        @startdate         DATETIME,
        @nextcheckdate     DATETIME,
        @semantic_category NVARCHAR(250),
        @docEnable         BIT,
        @docChecksum       VARBINARY(255),
        @fileEnable        BIT,
        @relacion          NVARCHAR(500),
        @fileChecksum      VARBINARY(255);

    -- Iniciar transacción
    IF @@TRANCOUNT = 0
    BEGIN
        SET @InicieTransaccion = 1;
        SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
        BEGIN TRANSACTION;
    END

    BEGIN TRY
        -- Recorrer array de documentos
        DECLARE doc_cursor CURSOR LOCAL FAST_FORWARD FOR
            SELECT value
    FROM OPENJSON(@jsonInput);
        OPEN doc_cursor;
        FETCH NEXT FROM doc_cursor INTO @item;
        WHILE @@FETCH_STATUS = 0
        BEGIN
        -- 1) IdentityDocs
        SET @identitytype    = JSON_VALUE(@item,'$.identitytype');
        SET @identitystate   = JSON_VALUE(@item,'$.identitystate');
        SET @idName          = JSON_VALUE(@item,'$.name');
        SET @field1          = JSON_VALUE(@item,'$.field1');
        SET @field2          = JSON_VALUE(@item,'$.field2');
        SET @temporary       = ISNULL(TRY_CAST(JSON_VALUE(@item,'$.temporary') AS BIT),1);
        SET @expirationdate  = TRY_CAST(JSON_VALUE(@item,'$.expirationdate') AS DATETIME);
        SET @referenceVal    = JSON_VALUE(@item,'$.referenceVal');
        SET @referenceId     = JSON_VALUE(@item,'$.referenceId');

        DECLARE @identitytypeid INT;
        SELECT TOP 1 @identitytypeid = it.identitytypeid FROM dbo.vpv_identitytype AS it WHERE it.name  = @identitytype;
        IF @identitytypeid IS NULL
        BEGIN
            -- 50262: tipo de identidad inválido
            RAISERROR(50263, 16, 1, @identitytype);
            RETURN;  -- sale al CATCH
        END

        DECLARE @identitystateid INT;
        SELECT TOP 1 @identitystateid = ids.identitystateid FROM dbo.vpv_identitystates AS ids WHERE ids.name  = @identitystate;
        IF @identitystateid IS NULL
        BEGIN
            -- 50263: estado de identidad inválido
            RAISERROR(50264, 16, 1, @identitystate);
            RETURN;
        END


        -- hacemos el insert a identity docs para identificar los documentos, necesario para insert en docs
        INSERT INTO dbo.vpv_identitydocs
            (
            identitytypeid, identitystateid, [name], field1, field2,
            temporary, creationdate, enable, expirationdate,
            referencevalue, referenceid
            )
        VALUES
            (
                @identitytypeid, @identitystateid, @idName, @field1, @field2,
                @temporary, GETDATE(), 1, @expirationdate,
                @referenceVal, @referenceId
            );
        SET @identitydocsid = SCOPE_IDENTITY();
        -- log de exito
        INSERT INTO dbo.vpv_logs (description, computer, username, trace, referenceId1, referenceId2, value1, value2, chechsum, logSeverityId, logSourceId, logTypeId) VALUES
          ('Nuevo identity docs completado' + @idName, @@SERVERNAME, HOST_NAME(),
           'vpvSP_InsertProposalDocuments', CAST(@idName AS VARCHAR(10)), NULL,
           NULL, NULL, 0x0,
           (SELECT logSeverityId FROM dbo.vpv_logSeverity WHERE [name]='Informational'),
           (SELECT logSourceId   FROM dbo.vpv_logsSources WHERE [name]='Database'),
           (SELECT logTypeId     FROM dbo.vpv_logTypes   WHERE [name]='Audit'));

        -- 2) Docs
        SET @format        = JSON_VALUE(@item,'$.format');
        SET @docstype      = JSON_VALUE(@item,'$.docstype');
        SET @docstate      = JSON_VALUE(@item,'$.docstate');
        SET @archiveBase64 = JSON_VALUE(@item,'$.archive');

        DECLARE @formatid INT;
        SELECT TOP 1 @formatid = f.formatid FROM dbo.vpv_formats AS f WHERE f.name  = @format;
        IF @formatid IS NULL
        BEGIN
            RAISERROR(50265, 16, 1, @format);
            RETURN;
        END

        DECLARE @docstypeid INT;
        SELECT TOP 1 @docstypeid = dt.docstypeid FROM dbo.vpv_docstypes AS dt WHERE dt.name  = @docstype;
        IF @docstypeid IS NULL
        BEGIN
            RAISERROR(50266, 16, 1, @docstype);
            RETURN;
        END

        DECLARE @docstateid INT;
        SELECT TOP 1 @docstateid = ds.docstateid FROM dbo.vpv_docstates AS ds WHERE ds.name  = @docstate;
        IF @docstateid IS NULL
        BEGIN
            RAISERROR(50267, 16, 1, @docstate);
            RETURN;
        END

        -- Validar que el valor no sea NULL
        IF @archiveBase64 IS NULL
        BEGIN
            RAISERROR('El campo "archive" es obligatorio.', 16, 1);
            RETURN;
        END

        -- Convertir base64 a varbinary
        BEGIN TRY
        SET @archive = CAST(@archiveBase64 AS VARBINARY(MAX));
        END TRY
        BEGIN CATCH
            RAISERROR('El valor de archive no es una cadena base64 válida.', 16, 1);
            RETURN;
        END CATCH

        SET @filename          = JSON_VALUE(@item,'$.filename');
        SET @docDate           = TRY_CAST(JSON_VALUE(@item,'$.date') AS DATETIME);
        SET @startdate         = TRY_CAST(JSON_VALUE(@item,'$.startdate') AS DATETIME);
        SET @nextcheckdate     = TRY_CAST(JSON_VALUE(@item,'$.nextcheckdate') AS DATETIME);
        SET @semantic_category = JSON_VALUE(@item,'$.semantic_category');
        SET @docEnable         = ISNULL(TRY_CAST(JSON_VALUE(@item,'$.docEnable') AS BIT),1);
        SET @docChecksum       = HASHBYTES('SHA2_256', @filename + CONVERT(VARCHAR(30),@docDate,126));

        -- aqui se suben los documentos de la propuesta
        INSERT INTO dbo.vpv_docs
            (
            identitydocsid, formatid, docstypeid, docstateid,
            archive, filename, [date], [enable],
            startdate, nextcheckdate, semantic_category, checksum
            )
        VALUES
            (
                @identitydocsid, @formatid, @docstypeid, @docstateid,
                @archive, @filename, @docDate, @docEnable,
                @startdate, @nextcheckdate, @semantic_category, @docChecksum
            );
        SET @docid = SCOPE_IDENTITY();
        INSERT INTO dbo.vpv_logs (description, computer, username, trace, referenceId1, referenceId2, value1, value2, chechsum, logSeverityId, logSourceId, logTypeId) VALUES
          ('InsertProposalDocuments completado' + @filename, @@SERVERNAME, HOST_NAME(),
           'vpvSP_InsertProposalDocuments', CAST(@filename AS VARCHAR(10)), NULL,
           NULL, NULL, 0x0,
           (SELECT logSeverityId FROM dbo.vpv_logSeverity WHERE [name]='Informational'),
           (SELECT logSourceId   FROM dbo.vpv_logsSources WHERE [name]='Database'),
           (SELECT logTypeId     FROM dbo.vpv_logTypes   WHERE [name]='Audit'));

        -- 3) FilesPerProposal
        SET @fileEnable   = ISNULL(TRY_CAST(JSON_VALUE(@item,'$.fileEnable') AS BIT),1);
        SET @relacion     = JSON_VALUE(@item,'$.relacion');
        SET @fileChecksum = HASHBYTES('SHA2_256', CONCAT(@proposalId,'_',@docid));

        -- y aqui se relacionan los documenos y la propuesta
        INSERT INTO dbo.vpv_FilesPerProposal
            (
            proposalId, docid, [enable], deleted,
            checksum, proposalVersionId, relacion
            )
        VALUES
            (
                @proposalId, @docid, @fileEnable, 0,
                @fileChecksum, @proposalVersionId, @relacion
            );
        INSERT INTO dbo.vpv_logs (description, computer, username, trace, referenceId1, referenceId2, value1, value2, chechsum, logSeverityId, logSourceId, logTypeId) VALUES
          ('InsertProposalDocuments completado', @@SERVERNAME, HOST_NAME(),
           'vpvSP_InsertProposalDocuments', CAST(@proposalId AS VARCHAR(10)), NULL,
           NULL, NULL, 0x0,
           (SELECT logSeverityId FROM dbo.vpv_logSeverity WHERE [name]='Informational'),
           (SELECT logSourceId   FROM dbo.vpv_logsSources WHERE [name]='Database'),
           (SELECT logTypeId     FROM dbo.vpv_logTypes   WHERE [name]='Audit'));

            DECLARE
                @procName     NVARCHAR(100),
                @procDesc     NVARCHAR(100),
                @randTypeId   INT,
                @randParamId  INT,
                @randMethodId INT = 1;  -- asumido

            SELECT TOP 1 @randTypeId  = processtypeid FROM dbo.vpv_processtypes;
            SELECT TOP 1 @randParamId = parameterid   FROM dbo.vpv_parameters WHERE enable = 1;

            SET @procName = 'Doc_' + CAST(@docid AS NVARCHAR(10));
            SET @procDesc = 'AutoProceso doc ' + CAST(@docid AS NVARCHAR(10));

            -- se intenta realizar el insert en process, esto para que la ia lo procese despues, se inserta una refencia del id del documentos
            BEGIN TRY
                INSERT INTO dbo.vpv_process
                    (processtypeid, referencevalue, referenceid, parameterid,
                     processmethodid, [name], [description], enable, fecha, [order])
                VALUES
                    (@randTypeId,
                     @docid,
                     'docid',
                     @randParamId,
                     @randMethodId,
                     @procName,
                     @procDesc,
                     1,
                     GETDATE(),
                     0);
            END TRY
            BEGIN CATCH
                -- Sólo loguear, no abortar
                DECLARE
                    @E_Num  INT  = ERROR_NUMBER(),
                    @E_Sev  INT  = ERROR_SEVERITY(),
                    @E_Sta  INT  = ERROR_STATE(),
                    @E_Msg  NVARCHAR(4000)= ERROR_MESSAGE();

                -- si falla se hace un insert a logs
                INSERT INTO dbo.vpv_logs
                    (description, computer, username, trace, referenceId1, referenceId2,
                     value1, value2, chechsum, logSeverityId, logSourceId, logTypeId)
                VALUES
                    (
                      'Fallo al crear proceso: ' + @E_Msg,
                      @@SERVERNAME,
                      HOST_NAME(),
                      'vpvSP_InsertProposalDocuments:vpv_process',
                      CAST(@docid AS NVARCHAR(10)), NULL,
                      NULL, NULL, 0x0,
                      (SELECT logSeverityId FROM dbo.vpv_logSeverity WHERE [name]='Warning'),
                      (SELECT logSourceId   FROM dbo.vpv_logsSources WHERE [name]='Application'),
                      (SELECT logTypeId     FROM dbo.vpv_logTypes   WHERE [name]='Warning')
                    );
                -- continuar con siguiente documento
            END CATCH;


        FETCH NEXT FROM doc_cursor INTO @item;
    END
        CLOSE doc_cursor;
        DEALLOCATE doc_cursor;

        IF @InicieTransaccion = 1
            COMMIT;
        END TRY
    BEGIN CATCH
        IF @InicieTransaccion = 1
            ROLLBACK;

        DECLARE
            @ErrNum INT    = ERROR_NUMBER(),
            @ErrSev INT    = ERROR_SEVERITY(),
            @ErrSta INT    = ERROR_STATE(),
            @ErrMsg NVARCHAR(4000) = ERROR_MESSAGE();
        RAISERROR('%s - Error Number: %i',
            @ErrSev, @ErrSta, @ErrMsg, @ErrNum);
    END CATCH
END;
GO

```
</details>

<details>
	<summary>Ver JSONs de ejemplo</summary>

 ```json

{
  "user": "326102758",
  "proposal": {
    "tittle": "Programa Conecta Saber",
    "description": "Impulsar el acceso equitativo a herramientas tecnológicas en zonas rurales",
    "content": "Borrador técnico preliminar",
    "schedule": "Cada semana",
    "status": "Pendiente de revisión",
    "budget": 5000.75,
    "proposalType": "Propuesta educativa",
    "relacion": "Contribuye al ODS 4",
    "startingDate": "2025-07-01"
  },
  "votingConfig": {
    "openDate": "2025-06-15T08:00:00",
    "closeDate": "2025-06-20T18:00:00",
    "StatusVoting": "Preparado",
    "VotingType": "Multiple",
    "description": "Simulación de parámetros de votación",
    "weight": 1,
    "ReminderType": "Email",
    "ClosureTypes": "Cierre hasta la fecha",
    "VotingReasons": "Aval de propuesta"
  },
  "targetPopulations": {
    "targetPopulations": [
      { "name": "Jóvenes Adultos", "weight": 1.00 },
      { "name": "Adultos Mayores", "weight": 1.50 },
      { "name": "Personas con Discapacidad", "weight": 0.75 }
    ]
  },  
  "documents": [
    {
      "identitytype": "Poder Generalísimo",
      "identitystate": "En espera",
      "name": "Documento Identidad Digital",
      "field1": "ZX908765",
      "field2": "N/A",
      "temporary": 0,
      "expirationdate": "2030-12-31T00:00:00",
      "referenceVal": 500,
      "referenceId": "PPT-500",
      "format": "PDF",
      "docstype": "Legal",
      "docstate": "Pendiente",
      "archive": "UEsDBBQACAgI...==",
      "filename": "poder-generalisimo.pdf",
      "date": "2025-06-08T09:00:00",
      "startdate": "2025-06-01T00:00:00",
      "nextcheckdate": "2026-06-01T00:00:00",
      "semantic_category": "docuemnto que otorga algun poder, es legal",
      "docEnable": 1,
      "fileEnable": 1,
      "relacion": "Documento oficial"
    },
    {
      "identitytype": "Cert. de Propiedad",
      "identitystate": "En espera",
      "name": "Certificado de propiedad sobre xx",
      "field1": "DP-457",
      "field2": "N/A",
      "temporary": 0,
      "expirationdate": "2030-12-31T00:00:00",
      "referenceVal": 501,
      "referenceId": "PPT-501",
      "format": "PDF",
      "docstype": "Propiedad",
      "docstate": "Pendiente",
      "archive": "UEsDdsfhgsadfghjgBBQACAgI...==",
      "filename": "titulo de propiedad.pdf",
      "date": "2025-06-08T10:00:00",
      "startdate": "2025-06-02T00:00:00",
      "nextcheckdate": "2026-06-02T00:00:00",
      "semantic_category": "documento que demuestra pocesion",
      "docEnable": 1,
      "fileEnable": 1,
      "relacion": "Documento oficial 3"
    }
  ]
}

{
  "user": "326102758",
  "proposal": {
    "tittle": "Propuesta Educativa",
    "description": "Ampliar cobertura de educación digital",
    "content": "Primera versión detallada",
    "schedule": "Cada semana",
    "status": "Pendiente de revisión",
    "budget": 5000.75,
    "proposalType": "Propuesta educativa",
    "relacion": "Contribuye al ODS 4",
    "startingDate": "2025-07-01"
  },
  "votingConfig": {
    "openDate": "2025-06-15T08:00:00",
    "closeDate": "2025-06-20T18:00:00",
    "StatusVoting": "Preparado",
    "VotingType": "Multiple",
    "description": "Prueba SP VotingConfig",
    "weight": 1,
    "ReminderType": "Email",
    "ClosureTypes": "Cierre hasta la fecha",
    "VotingReasons": "Aval de propuesta"
  },
  "targetPopulations": {
    "targetPopulations": [
      { "name": "Jóvenes Adultos", "weight": 1.00 },
      { "name": "Adultos Mayores", "weight": 1.50 },
      { "name": "Personas con Discapacidad", "weight": 0.75 }
    ]
  },  
  "documents": [
    {
      "identitytype": "Poder Generalísimo",
      "identitystate": "En espera",
      "name": "Documento de poder Generalísimo",
      "field1": "DP-432334",
      "field2": "N/A",
      "temporary": 0,
      "expirationdate": "2030-12-31T00:00:00",
      "referenceVal": 500,
      "referenceId": "PPT-500",
      "format": "PDF",
      "docstype": "Legal",
      "docstate": "Pendiente",
      "archive": "UEsDBBQACAgI...==",
      "filename": "poder-generalisimo.pdf",
      "date": "2025-06-08T09:00:00",
      "startdate": "2025-06-01T00:00:00",
      "nextcheckdate": "2026-06-01T00:00:00",
      "semantic_category": "docuemnto que otorga algun poder, es legal",
      "docEnable": 1,
      "fileEnable": 1,
      "relacion": "Documento oficial"
    },
    {
      "identitytype": "Cert. de Propiedad",
      "identitystate": "En espera",
      "name": "Certificado de propiedad sobre xx",
      "field1": "DP-457",
      "field2": "N/A",
      "temporary": 0,
      "expirationdate": "2030-12-31T00:00:00",
      "referenceVal": 501,
      "referenceId": "PPT-501",
      "format": "PDF",
      "docstype": "Propiedad",
      "docstate": "Pendiente",
      "archive": "UEsDdsfhgsadfghjgBBQACAgI...==",
      "filename": "titulo de propiedad.pdf",
      "date": "2025-06-08T10:00:00",
      "startdate": "2025-06-02T00:00:00",
      "nextcheckdate": "2026-06-02T00:00:00",
      "semantic_category": "documento que demuestra pocesion",
      "docEnable": 1,
      "fileEnable": 1,
      "relacion": "Documento oficial 3"
    }
  ]
}

```

</details>

##### Errores personalizados

<details>
	<summary>Ver errores personalizados</summary>

| Error                              | Código | Descripción                                                          | Motivo                                                                         |
| ---------------------------------- | -----: | -------------------------------------------------------------------- | ------------------------------------------------------------------------------ |
| Usuario no registrado              |  50200 | Usuario no registrado.                                               | Se intentó operar con un usuario que no existe en la base de datos.            |
| Rol no requerido                   |  50201 | El usuario %d no tiene el rol requerido: Proponente.                 | El usuario autenticado no cuenta con el rol ‘Proponente’ necesario.            |
| Error general del SP               |  50202 | vpvSP\_CrearActualizarPropuesta falló: %s (Número %d).               | Fallo interno en el procedimiento al crear o actualizar la propuesta.          |
| Éxito al hacer UPSERT de propuesta |  50220 | UpsertProposalWithVersion OK: proposalId=%d, versionId=%d.           | Se completó correctamente la inserción o actualización de la propuesta.        |
| Error en UPSERT de propuesta       |  50221 | UpsertProposalWithVersion ERROR: %s (CustomError=%d).                | Ocurrió un error al insertar o actualizar la propuesta con versión.            |
| Success al insertar configuración  |  50240 | InsertVotingConfig completed successfully. Generated ID: %d.         | La configuración de votación se guardó correctamente y se generó un nuevo ID.  |
| Error de permisos                  |  50241 | Permission denied: missing required permission "%s" in context "%s". | El usuario carece del permiso requerido en el contexto especificado.           |
| Error en insert de configuración   |  50242 | Error in InsertVotingConfig: %s (Internal Code: %d).                 | Se produjo un fallo interno al intentar guardar la configuración de votación.  |
| Población objetivo inválida        |  50262 | Target population "%s" is not enabled or does not exist.             | La población objetivo indicada no está registrada o no está habilitada.        |
| Tipo de identidad inválido         |  50263 | Invalid identity type: %s                                            | Se proporcionó un tipo de documento de identidad no reconocido.                |
| Estado de identidad inválido       |  50264 | Invalid identity status: %s                                          | Se suministró un estado de identidad que no cumple con los valores permitidos. |
| Formato inválido                   |  50265 | Invalid format: %s.                                                  | El formato de uno de los datos ingresados no coincide con el esperado.         |
| Tipo de documento inválido         |  50266 | Invalid document type: %s.                                           | El tipo de documento especificado no forma parte de los tipos válidos.         |
| Estado de documento inválido       |  50267 | Invalid document status: %s.                                         | El estado asignado al documento no corresponde a los estados definidos.        |
| Estado de votación no registrado   |  50268 | The voting status "%s" is not registered in vpv\_statusVoting.       | No existe ningún estado de votación con el nombre proporcionado.               |
| Tipo de votación no registrado     |  50269 | The voting type "%s" is not registered in vpv\_votingTypes.          | El tipo de votación indicado no está definido en el catálogo correspondiente.  |
| Tipo de recordatorio no registrado |  50270 | The reminder type "%s" is not registered in vpv\_reminderTypes.      | El tipo de aviso o recordatorio no está registrado en el sistema.              |
| Tipo de cierre no registrado       |  50271 | The closure type "%s" is not registered in vpv\_ClosureTypes.        | No se encontró el tipo de cierre con la clave indicada.                        |
| Razón de votación no registrada    |  50272 | The voting reason "%s" is not registered in vpv\_votingReasons.      | La motivación o razón de votación indicada no existe en el catálogo.           |
| Agenda no registrada               |  50273 | The schedule "%s" is not registered in vpv\_schedules.               | No hay ninguna agenda con ese identificador en la tabla de horarios.           |
| Estado de proceso no registrado    |  50274 | The process status "%s" is not registered in vpv\_processStatus.     | Se utilizó un estado de proceso no definido en el sistema.                     |
| Tipo de propuesta no registrado    |  50275 | The proposal type "%s" is not registered in vpv\_proposalTypes.      | El tipo de propuesta proporcionado no figura en el catálogo de tipos.          |

 
</details>

 
</details>


	
#### Invertir
  
<details>
<summary>Desplegar información</summary>
	
Esta funcionalidad permite a un ciudadano realizar inversiones en propuestas que se encuentren abiertas y aprobadas para tal fin dentro del sistema. Para asegurar la integridad y el correcto manejo de las inversiones, se implementan una serie de validaciones y procesos automáticos.

El flujo principal incluye los siguientes pasos:

- Validar que la propuesta esté en estado aprobado y disponible para recibir inversiones.

- Confirmar la identidad del inversionista y verificar que esté registrado en el sistema.

- Validar el pago recibido y confirmar que el monto transferido por el inversionista es correcto.

- Calcular el porcentaje de participación accionaria que corresponde al inversionista según el monto invertido y el valor total del proyecto.

- Asegurar que la inversión total no supere el límite permitido para evitar sobreinversión.

- Registrar formalmente la inversión, estableciendo las relaciones necesarias con la propuesta y el plan de entrega de fondos.

- Generar un calendario con fechas clave para la revisión y fiscalización del avance del proyecto.

- Preparar un plan detallado de desembolsos en tramos mensuales para la correcta administración de los fondos.

- Ejecutar todos estos pasos dentro de una única transacción para garantizar la consistencia y atomicidad del proceso.

Esta implementación garantiza transparencia, seguridad y control en la gestión de inversiones ciudadanas dentro de la plataforma de crowdfunding.

<details>
  <summary>Ver codigo del lado de API</summary>

Esta función implementa un endpoint HTTP POST para registrar inversiones ciudadanas en propuestas activas dentro del sistema de crowdfunding y voto electrónico.

La funcionalidad principal de esta API consiste en recibir una solicitud con datos en formato JSON que incluyen información sobre la propuesta, la identidad del inversor, el tipo de acuerdo, el monto a invertir, referencias de pago, fechas relevantes, moneda, recurrencia y plazos de pago. La función realiza validaciones exhaustivas para asegurar que todos los campos requeridos estén presentes y tengan el formato adecuado. Luego, se conecta a una base de datos SQL Server mediante la biblioteca pyodbc, utilizando una cadena de conexión almacenada en una variable de entorno. 
Ejecuta un procedimiento almacenado llamado vpvSP_InvertirProyecto, que se encarga de registrar la inversión y manejar todas las operaciones relacionadas a nivel de base de datos. Finalmente, devuelve un mensaje en formato JSON con el resultado de la operación, ya sea una confirmación de éxito o información detallada sobre cualquier error ocurrido, y controla adecuadamente las excepciones para mantener la estabilidad y proporcionar respuestas claras a los consumidores del API.

``` sql
import azure.functions as func
from datetime import datetime
import json
import logging
import os #Esto para poder obtener la variable de entorno que posee la conexion
import pyodbc

# Obteniene la cadena de conexión desde la variable de entorno
conn_str = os.environ.get("SQL_CONNECTION_STRING")

"""
    Ejecuta el procedimiento almacenado 'vpvSP_InvertirProyecto' para registrar una inversión en una propuesta activa por parte de un ciudadano.

    Parámetros del cuerpo de la solicitud (req_body) de formato JSON:
    - propuesta: Nombre de la propuesta en la que se desea invertir.
    - idCard: Número de identificación del inversor en este caso un ciudadano.
    - agreementType: Tipo de acuerdo (ej. "Crowdfunding de donación").
    - monto: Monto de dinero que se desea invertir.
    - transactionrefNumber: Número de referencia de la transacción.
    - finalDate: Fecha de finalización del acuerdo (formato 'YYYY-MM-DD').
    - paymentDate: Fecha del primer pago (formato 'YYYY-MM-DD').
    - currency: Tipo de moneda utilizada, el acronimo de la moneda.
    - recurrencia: Frecuencia de pag0 debe ser un numero entero y positivoo.
    - plazosPago: Número de pagos o plazos para cubrir el monto total.

    Retorna:
    - HttpResponse con mensaje de éxito o error según el resultado del procedimiento. Es decir, el mensaje que retorne el sp
    """
def invertir(req: func.HttpRequest) -> func.HttpResponse:
    logging.info('Comenzando a invertir...')

     #VALIDO QUE EL METODO SEA POST DE LO CONTRARIO, ESTE REQUEST NO SERA PROCESADO
    if req.method != "POST":
        return func.HttpResponse(
            "Metodo no permitido. Utilice otro metodo",
            status_code=405
        )

    #Obtengo el json que se encuentra en el body
    try:
        req_body = req.get_json()
        # Agarro los parametros que me enviaron desde el body
        propuesta = req_body.get('propuesta')
        idCard = req_body.get('idCard')
        agreementType = req_body.get('agreementType')
        monto = req_body.get('monto')
        transactionrefNumber = req_body.get('transactionrefNumber')
        finalDate = req_body.get('finalDate')
        paymentDate = req_body.get('paymentDate')
        currency = req_body.get('currency')
        recurrencia = req_body.get('recurrencia')
        plazosPago = req_body.get('plazosPago')

        #Validaciones de los datos entrantes, con la finalidad de que el sp no reciba valores nulos

        if not propuesta:
            return func.HttpResponse("El campo 'propuesta' es requerido.",status_code=400)

        if not idCard or not idCard.isdigit():
            return func.HttpResponse("El campo 'idCard' es requerido y debe ser numérico.",status_code=400)

        if not agreementType:
            return func.HttpResponse("El campo 'agreementType' es requerido.",status_code=400)

        try: #valida si el monto es menor o negativo
            monto = float(monto)
            if monto <= 0:
                raise ValueError()
        except:
            return func.HttpResponse("El campo 'monto' debe ser un número decimal positivo.",status_code=400)

        if not transactionrefNumber:
            return func.HttpResponse("El campo 'transactionrefNumber' es requerido.",status_code=400)

        # Validar fechas para que se sepa si tienen el formato adecuado para ser enviado
        try:
            finalDate = datetime.strptime(finalDate, "%Y-%m-%d")
        except:
            return func.HttpResponse("El campo 'finalDate' debe tener formato YYYY-MM-DD.",status_code=400)

        try:
            paymentDate = datetime.strptime(paymentDate, "%Y-%m-%d")
        except:
            return func.HttpResponse("El campo 'paymentDate' debe tener formato YYYY-MM-DD.",status_code=400)

        if not currency:
            return func.HttpResponse("El campo 'currency' es requerido.",status_code=400)

        if not recurrencia:
            return func.HttpResponse("El campo 'recurrencia' es requerido.",status_code=400)

        try: #validacion de los plazos con la finalidad de validar que no sea negativos o decimales
            plazosPago = int(plazosPago)
            if plazosPago <= 0:
                raise ValueError()
        except:
            return func.HttpResponse("El campo 'plazosPago' debe ser un entero positivo.",status_code=400)
        
        #ejecucion del SP junto al envio de parametros
        # Conexión a SQL Server y ejecución del SP mandandole los parametros
        
        try:
            with pyodbc.connect(conn_str) as conn:
                cursor = conn.cursor()
                cursor.execute("""
                    EXEC dbo.vpvSP_InvertirProyecto ?, ?, ?, ?, ?, ?, ?, ?, ?, ?;
                """, ( propuesta,idCard,agreementType,monto,transactionrefNumber,finalDate,paymentDate,currency, recurrencia,plazosPago))

                #en caso de no lanzar una excepcion enviara un mensaje de exiito, de lo contrario el try se encarga de manejar la excepcion
                if cursor.description:  # Verifica si hay resultados es decir si hubo un select por ej pero en este caso solamente fue un return
                    columns = [col[0] for col in cursor.description]
                    rows = cursor.fetchall()
                    result = [dict(zip(columns, row)) for row in rows]
                    return func.HttpResponse(json.dumps(result), status_code=200, mimetype="application/json")
                else:
                    return func.HttpResponse(
                        json.dumps({"mensaje": "Inversion Exitosa"}),
                        status_code=200,
                        mimetype="application/json"
                    )

        except pyodbc.Error as e:
            error_msg = str(e)
            return func.HttpResponse(
                json.dumps({"error": error_msg}),
                status_code=400,
                mimetype="application/json"
            )
                
    #control de excepciones extras asi como rollback en la transaccion principal
    except ValueError as e:
        return func.HttpResponse(
            str(e),
            status_code=200
        )

```
</details>

---

<details>
  <summary>Ver codigo del lado del SQL SERVER</summary>

Este procedimiento almacenado implementa el flujo completo de inversión de un ciudadano en una propuesta previamente aprobada y habilitada para financiamiento colectivo (crowdfunding). Fue diseñado para ejecutarse como parte de una transacción controlada y segura, garantizando integridad de datos y validaciones exhaustivas antes de registrar la inversión.

El procedimiento comienza validando que la propuesta exista, esté en estado aprobado y forme parte activa del módulo de crowdfunding. Luego, verifica la identidad del ciudadano mediante desencriptación de su cédula y valida que posea el rol correspondiente (Ciudadano). A continuación, confirma que la transacción de pago sea válida y esté registrada con el monto exacto, referencia y usuario correspondiente.

Con estas validaciones superadas, el procedimiento procede a calcular si la inversión es permitida sin exceder el presupuesto total del proyecto. Si la inversión permite participación accionaria, se calcula el porcentaje accionario que le corresponde al ciudadano inversor.

Una vez validado y calculado lo anterior, el procedimiento registra:

- El schedule de pagos,

- El sponsor agreement correspondiente a la inversión,

- La relación de la inversión con el proyecto,

- Un plan de pagos dividido en tramos mensuales según el número de plazos acordados,

- Un plan de revisión del proyecto con fechas calendarizadas periódicamente (mensual o semanal),

- El tracking del proyecto, relacionando la inversión con su plan de fiscalización.

Todo este flujo se ejecuta dentro de una única transacción con manejo robusto de errores. En caso de fallo, se realiza un rollback para evitar inconsistencias. Si la ejecución es exitosa, se garantiza un registro completo de la inversión y su seguimiento, conforme a los principios de transparencia y control de un sistema de votación y financiamiento colectivo

```sql

-----------------------------------------------------------
-- Autor: Carol Araya Conejo
-- Fecha: 04/06/2025
-- Descripcion: Proceso de inversion sobre una propuesta abierta y aprobada
-- propuesta: Nombre de la propuesta a invertir
-- idcard: id card unico que identifique al usuario que realiza la inversion
-- monto: monto a invertir
-- transactionrefNumber : numero de referencia de la transaccion
-- finalDate: Fecha de finalizacion de la propuesta
-- currency: moneda en la que se realiza la inversion

-----------------------------------------------------------
CREATE OR ALTER   PROCEDURE [dbo].[vpvSP_InvertirProyecto]
	@propuesta VARCHAR(255),
	@idCard VARCHAR(255),
	@agreementType VARCHAR(255),
	@monto DECIMAL(20,5),
	@transactionrefNumber VARCHAR(150),
	@finalDate DATETIME,
	@paymentDate DATETIME,
	@currency VARCHAR(150),
	@recurrencia VARCHAR(150),
	@plazosPago INT
AS 
BEGIN
	
	SET NOCOUNT ON
	
	DECLARE @ErrorNumber INT, @ErrorSeverity INT, @ErrorState INT, @CustomError INT
	DECLARE @Message VARCHAR(200)
	DECLARE @InicieTransaccion BIT

	-- declaracion de variables que representan los id encontrados
	DECLARE @idUsuario INT
	DECLARE @idEntidad INT = NULL
	DECLARE @idPropuesta INT
	DECLARE @idSponsorAgreement INT
	DECLARE @transactionId INT
	DECLARE @investmentTypeId INT
	DECLARE @budget DECIMAL(20,5) 
	DECLARE @crowfoundingId INT
	DECLARE @currencyId INT
	DECLARE @agreementId INT
	DECLARE @idSchedule INT
	DECLARE @repetition INT;
	DECLARE @statusId INT;
	DECLARE @idProjectTracking INT; --Plan de revision
	DECLARE @inversionPlan INT;
	DECLARE @docid INT;
	DECLARE @tittle VARCHAR(100);--Representa titulos y descripciones de los planes insertados
	

	--declaracion de variables de calculo de montos y porcentajes
	DECLARE @i INT = 0; --Utilizado para ciclos dentro de la insercion
	DECLARE @porcentajeTotal DECIMAL(3,2) --Porcentaje total invertido
	DECLARE @montoTotal DECIMAL(3,2) --Monto total invertido
	DECLARE @porcentajeInversion DECIMAL(3,2) =0;--Porcentaje asignado a la inversion
	DECLARE @poseePorcentaje BIT -- Indica si el usuario tiene porcentaje de acciones (En caso de ser donacion no tiene)
	DECLARE @share BIT --Indica que si al ser una donacion no posee acciones
	DECLARE @stringConcat NVARCHAR(200);
	DECLARE @checksum VARBINARY(32);
	DECLARE @paymetAmount DECIMAL(18,2);--Permite tener los montos a pagar en relacion a los plazos

	--decalracion de variables utilizadas para la generacion de planes
	DECLARE @currentDate DATETIME;
    DECLARE @nextDate DATETIME;

	-- operaciones de select que permiten obtener los id a partir de las entradas incluyendo sus validaciones------------------------------------

	--Obtencion de status del pago
	SELECT TOP 1 @statusId = statusId
	FROM vpv_processStatus 
	WHERE name = 'Pendiente de revisión'

	-- Validar que el proyecto esté en estado aprobado para inversión
	SELECT TOP 1 @idPropuesta = p.proposalId, @budget = p.budget
	FROM vpv_proposals p
	INNER JOIN vpv_processStatus ps on ps.statusId = p.statusId
	WHERE p.tittle = @propuesta and ps.name = 'Aprobado'
	
	IF @idPropuesta IS NULL
	BEGIN
		RAISERROR(50001, 16, 1);
		RETURN;
	END

	-- Validar que el proyecto sea parte del crowfounding
	SELECT TOP 1 @crowfoundingId = p.proposalId
	FROM vpv_crowdfoundingProposals p
	WHERE p.proposalId = @idPropuesta and p.enable=1

	IF @crowfoundingId IS NULL
	BEGIN
		RAISERROR(50002, 16, 1);
		RETURN;
	END

	-- Validar que el currency en el que se realiza la inversion sea correcto
	SELECT TOP 1 @currencyId = p.currencyId
	FROM vpv_currencies p
	WHERE p.acronym = @currency

	IF @currencyId IS NULL
	BEGIN
		RAISERROR(50003, 16, 1);
		RETURN;
	END

	--Verificar identidad del usuario y confirmar su registro en el sistema por medio de la desencriptacion de la cedula de usuarios------------------
	OPEN SYMMETRIC KEY llavecedula DECRYPTION BY PASSWORD = 'clavecedula';

	SELECT TOP 1 @idUsuario = idUser 
	FROM vpv_Users 
	WHERE CONVERT(nvarchar(50), DECRYPTBYKEY(id_card)) = @idCard AND enable = 1;

	CLOSE SYMMETRIC KEY llavecedula;

	IF @idUsuario IS NULL
	BEGIN
		RAISERROR(50004, 16, 1);
		RETURN;
	END

	--Validacion de permisos con ello se busca si el usuario tiene el rol con el permiso asignado
	DECLARE @hasRole BIT;

	EXEC dbo.vpvSP_UserHasRole
		@idUser = @idUsuario,
		@roleName = N'Ciudadano',
		@HasRole = @hasRole OUTPUT;
	--Si retorna 0, en valido como null por lo tanto no hay permisos de inversion
	IF @hasRole IS NULL
	BEGIN
		RAISERROR(50004, 16, 1);
		RETURN;
	END


	-- Identificacion del tipo de agreement del usuario con la propuesta---------------------------------------------------------
	SELECT TOP 1 @investmentTypeId = sponsorAgreementTypeId
	FROM vpv_sponsorAgrementsType 
	WHERE name=@agreementType

	IF @investmentTypeId IS NULL
	BEGIN
		RAISERROR(50005, 16, 1);
		RETURN;
	END
	
	-- Revision del tipo de acuerdo al ser de donacion este no recibe porcentaje de acciones solo aporta al budget
	IF @agreementType = 'Crowdfunding de donación'
	BEGIN
		SET @poseePorcentaje = 0;
		SET @share = 0;
	END
	ELSE IF @agreementType = 'Crowdfunding de inversión'
	BEGIN
		SET @poseePorcentaje = 1;
		SET @share = 1;
	END
	ELSE 
	BEGIN
		RAISERROR(50006, 16, 1);
		RETURN; -- Va a detener el flujo del SP
	END


	--Comienzo de validacion de la transaccion a validar
	--Valida si el numero de referencia es real y coincide con el usuario asi como el monto y estado de la transaccion
	SELECT TOP 1 @transactionId = t.transactionId
	FROM vpv_transactions t
	INNER JOIN vpv_transSubTypes st on st.transactionSubTypeId = t.transactionSubTypeId
	WHERE t.refNumber = @transactionrefNumber and t.idUser= @idUsuario and t.amount = @monto
		and (st.name = 'Inversión de Usuario' OR st.name = 'Inversión de Entidad' OR st.name = 'Inversión de Sponsor' 
		OR st.name = 'Inversion a un plan')

	IF @transactionId IS NULL
	BEGIN
		RAISERROR(50007, 16, 1);
		RETURN;
	END

	--Calculo de checksum de agreement
	SET @stringConcat = CONCAT( @propuesta, '|',@monto, '|',@agreementType, '|', @crowfoundingId, '|', @currencyId);

	-- Genera el has del checksum en agreement
	SET @checksum = HASHBYTES('SHA2_256', CONVERT(VARBINARY(MAX), @stringConcat));

	SET @InicieTransaccion = 0
	IF @@TRANCOUNT=0 BEGIN
		SET @InicieTransaccion = 1
		SET TRANSACTION ISOLATION LEVEL READ COMMITTED
		BEGIN TRANSACTION		
	END
	
	BEGIN TRY
		SET @CustomError = 2001
		
		--Valido el monto en relacion al porcentaje de inversiones insertadas, a tiempo real por lo que se leen datos que han llegado a commit
		--obtengo el monto total de inversion y porcentaje para validar que no haya overflow
		SELECT @montoTotal= COALESCE(SUM(sp.inversion),0), @porcentajeTotal = COALESCE(SUM(sp.percentage),0)
		FROM vpv_investorsPerProject p
		INNER JOIN vpv_sponsorAgreements sp on sp.sponsorAgreementId = p.sponsorAgreementId
		where p.enable = 1 AND sp.enable = 1 AND p.crowdfoundingProposalId=2;
		PRINT 'dddd ' + CAST(@budget AS VARCHAR);
		PRINT 'dddd ' + CAST(@porcentajeTotal AS VARCHAR);
		PRINT 'dddd ' + CAST(@monto AS VARCHAR);

		--Valido si en relacion al budget no se genera overflow
		IF @monto <= (@budget - @montoTotal)
		BEGIN
			

			IF @poseePorcentaje = 1
			BEGIN
				IF @porcentajeTotal < 100
				BEGIN
					SET @porcentajeInversion = @monto * 100.00 / @budget; 
					-- Calculo el porcentaje en relación al monto invertido y el budget
				END
				ELSE
				BEGIN
					SET @porcentajeInversion = 0;
				END
			END
		END
		ELSE
		BEGIN
			RAISERROR(50008, 16, 1);
			RETURN;
		END

		--INICIO DE INSERCIONES --------------------------------------------------------------------------
		
		--INSERCION DEL SCHEDULE A UTILIZAR
		INSERT INTO dbo.vpv_schedules (name, recurrencyType, repetition, endType, endDate)
		VALUES (@recurrencia, @recurrencia, @repetition, @finalDate, @paymentDate);

		SET @idSchedule = SCOPE_IDENTITY();
		

		--INSERCION DE EL AGREEMENT COMO REGISTRO DE INVERSION
		INSERT INTO [dbo].[vpv_sponsorAgreements]
           ([enable],[checksum],[startDate] ,[finalDate] ,[signedDate],[deleted]
		   ,[currencyId],[percentage] ,[amount] ,[shares],[sponsorAgreementTypeId]
           ,[crowdfoundingProposalId],[name],[noReward],[scheduleId],[inversion])
		VALUES
           (1,@checksum,GETDATE(), @finalDate, GETDATE(),0,@currencyId,@porcentajeInversion,@monto,@share,
		   @investmentTypeId,@crowfoundingId,@propuesta,@share,@idSchedule,@monto);

		SET @agreementId = @@IDENTITY;

		--INSERCION DE lA INVERSION EN RELACION CON LA PROPUESTA
		INSERT INTO [dbo].[vpv_investorsPerProject]
           ([idUser] ,[crowdfoundingProposalId],[enable],[sponsorAgreementId])
		VALUES
			   (@idUsuario,@crowfoundingId,1,@agreementId);

		SET @inversionPlan = @@IDENTITY;
		--INCERSION DEL PAYMENT PLAN
		

		--CALCULA EL MONTO DQUE SERA PAGADO POR PLAZO
		SET @paymetAmount = @monto / @plazosPago;
		DEClARE @paymentSchedule DATETIME = @paymentDate;
		WHILE @i < @plazosPago
		BEGIN
			SET @checksum = HASHBYTES(
				'SHA2_256', 
				CONCAT(
					CONVERT(VARCHAR, @paymentSchedule, 126), '|',CONVERT(VARCHAR, @paymetAmount), '|',CONVERT(VARCHAR, @idSchedule), '|',CONVERT(VARCHAR, @statusId), '|', CONVERT(VARCHAR, @idUsuario)
				)
			);
			-- Calculo la fecha del pago para generarla por medio de tramos mensuales
			SET @paymentSchedule = DATEADD(month, 1 * @i, GETDATE());

			-- Insercion del pago
			INSERT INTO dbo.vpv_paymentPlans 
				(paymentDate, totalAmount, scheduleId, enable, deleted, checksum, statusId, idUser, requiredCapital)
			VALUES
				(@paymentSchedule, @paymetAmount, @idSchedule, 1, 0, @checksum, @statusId, @idUsuario, @budget);

			SET @i = @i + 1;
		END

		--INCIO DEL PLAN DE REVISION
		--INSERCION DEL SCHEDULE GENERAL
		INSERT INTO vpv_schedules (name,recurrencyType,repetition,endType,endDate)
		VALUES (@propuesta, @recurrencia, @repetition, 'NA', @finalDate);

		-- Obtiene el ID generado despues de la insercion
		SET @idSchedule = SCOPE_IDENTITY();

		--GENERACION DE LAS FECHAS DE REVISION
		SET @currentDate = @paymentDate;

		WHILE @currentDate <= @finalDate
		BEGIN
			-- Calcula siguiente fecha para el detalle
			IF @recurrencia = 'semanal'
				SET @nextDate = DATEADD(WEEK, 1, @currentDate);
			ELSE IF @recurrencia = 'mensual'
				SET @nextDate = DATEADD(MONTH, 1, @currentDate);
			ELSE
			BEGIN
				RAISERROR(50009, 16, 1);
				RETURN;
			END

			-- Insertar detalle de revisión
			INSERT INTO vpv_scheduleDetails (
				baseDate, datepart, lastExecute, nextExecute, scheduleId)
			VALUES (@paymentDate,@recurrencia,	@currentDate,@nextDate,@idSchedule);

			SET @currentDate = @nextDate;
		END
		SET @tittle = CONCAT('User:', '_Proposal:', @idPropuesta, '_Investment:', @inversionPlan);

		--Inserto el registro que permite tener un tracking al proyecto el plan se realiza por medio los detalles planificados
		INSERT INTO vpv_ProposalTracking
			(userId,proposalId,creationDate,enable,deleted,statusId,docid,tittle,scheduleId,description)
		VALUES(@idUsuario,@idPropuesta,GETDATE(),1,0,@statusId,1,@tittle,@idSchedule,'Plan de revison de la propuesta' + @tittle);


		--FIN DE INSERCIONES -----------------------------------------------------------------------------
					
		IF @InicieTransaccion=1 BEGIN
			COMMIT
		END
	END TRY
	BEGIN CATCH
		SET @ErrorNumber = ERROR_NUMBER()
		SET @ErrorSeverity = ERROR_SEVERITY()
		SET @ErrorState = ERROR_STATE()
		SET @Message = ERROR_MESSAGE()
		
		IF @InicieTransaccion=1 BEGIN
			ROLLBACK
		END
		RAISERROR('%s - Error Number: %i', 
			@ErrorSeverity, @ErrorState, @Message, @CustomError)
	END CATCH	
END
RETURN 0

```
 
  </details>

<details>
<summary>Ver JSON de prueba principal</summary>

```json

{
  "propuesta": "Iluminaci?n y vigilancia comunitaria inteligente",
  "idCard": "769616758",
  "agreementType": "Crowdfunding de donación",
  "monto": 204233.31,
  "transactionrefNumber": "TX-274868",
  "finalDate": "2025-12-31",
  "paymentDate": "2025-07-01",
  "currency": "CRC",
  "recurrencia": "mensual",
  "plazosPago": 6
}


```
</details>



#### Errores Personalizados
  <details>
  <summary>Ver errores personalizados</summary>

Los siguientes códigos de error (50001 – 50010) se registran en SQL Server mediante sp_addmessage y son utilizados por el procedimiento almacenado vpvSP_InvertirProyecto para informar condiciones que impiden completar una inversión. Todos se definen con severidad 16 (errores que debe corregir el usuario o la llamada) y en idioma Spanish.  

| Código    | Mensaje (Spanish)                                                        | Cuándo se lanza                                                                                        | Acción recomendada                                                                         |
| --------- | ------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------ |
| **50001** | *La propuesta a invertir no ha sido aprobada*                            | La propuesta existe pero su estado no es **Aprobado**.                                                 | Validar el flujo de aprobación de la propuesta antes de permitir inversiones.              |
| **50002** | *La propuesta no forma parte del crowfounding*                           | La propuesta no está registrada como **crowdfunding** o está deshabilitada.                            | Revisar que la propuesta esté en `vpv_crowdfoundingProposals` y marcada como `enable = 1`. |
| **50003** | *El tipo de cambio no es correcto*                                       | El acrónimo de moneda recibido no coincide con ninguno en `vpv_currencies`.                            | Verificar que la moneda enviada exista y esté habilitada.                                  |
| **50004** | *El usuario no tiene permisos*                                           | El ID de usuario no es válido, no está habilitado o no posee el rol **Ciudadano**.                     | Confirmar la identidad, habilitación y rol correcto del usuario.                           |
| **50005** | *El tipo acuerdo de inversión con el usuario no es correcto*             | El tipo de acuerdo (`@agreementType`) no existe en `vpv_sponsorAgrementsType`.                         | Corregir el tipo de acuerdo enviado o crear el registro faltante en la tabla.              |
| **50006** | *El tipo de acuerdo no pertenece a una inversión de crowdfunding*        | Se envió un `@agreementType` distinto de **Crowdfunding de donación** o **Crowdfunding de inversión**. | Ajustar el tipo de acuerdo a uno de los aceptados.                                         |
| **50007** | *No se ha registrado un pago en relación a la inversión del usuario*     | No existe transacción que coincida con el número de referencia, usuario y monto.                       | Confirmar el registro de la transacción de pago antes de invertir.                         |
| **50008** | *El monto a invertir sobrepasa el plan del proyecto. Comuníquese con TI* | La suma de inversiones excedería el presupuesto (`budget`) de la propuesta.                            | Reducir el monto o ajustar el presupuesto aprobado.                                        |
| **50009** | *El plazo indicado no existe*                                            | El valor de `@recurrencia` no es `semanal` ni `mensual`.                                               | Corregir la periodicidad enviada o ampliar la lógica para admitir más opciones.            |
| **50010** | *El usuario no tiene permisos*                                           | Mensaje genérico utilizado cuando otras verificaciones de autorización fallan.                         | Revisar credenciales y roles del usuario solicitante.                                      |


  </details>  
     
</details>


#### Repartir dividendos
  
<details>
<summary>Desplegar información</summary>
	
Esta funcionalidad permite a un ciudadano poder repartir los dividendos de una propuesta.  El flujo de este proceso sigue el siguiente esquema:
	- Valida que la propuesta exista y este habilitada
 	- Valida que las propuesta este en proceso para asi saber que puede haber posibilidad de hacer reparticion de 		dividendos
  	- Valida que la propuesta tenga fiscalizaciones aprobadas 
   	- Verifica que exista un reporte financiero y este tenga fondos disponibles para distribuir y en caso de que esto 	si se cumpla llama a un segundo Stored Procedure en el cual se verifican los inversionistas por proyecto y sus 		acuerdos pactados anteriormente para la inversion
    	- Verifica que existan inversionistas relacionados a la propuesta con la que se quiere hacer la reparticion
     	- Si se cumple con esa verificacion se realiza la suma total de la inversion relacionada a esa propuesta para poder 	determinar una parte del monto a repartir
      	- Despues de esto se abre un cursor en el cual se recorren todos lo sinversionistas que corresponden a la propuesta 	establecida almacenando el user y el sponsor y por cada usuario se verifica si tiene metodos de pago disponibles, 	solo si esto sucede entonces llama al tercer SP para realizar todo el flujo de transacciones
       -En el flujo de tranasacciones se realiza la simulacion del ingreso de dinero a la cuenat del usuario generando 		cambios en su balance y haciendo una ttransaccion, as[i mismo se realiza una simulacion de salida de dinero del 	balance de la propuesta y su debida transaccion.
       - Por ultimo se deja registro del pago en los logs de la empresa
<details>
  <summary>Ver codigo del lado de API</summary>

Esta función implementa un endpoint HTTP POST para registrar la reparticion de dividendos de una propuesta 

``` sql
import azure.functions as func
import logging
import json
from database import SessionLocal
import os #Esto para poder obtener la variable de entorno que posee la conexion
import pyodbc

# Obteniene la cadena de conexión desde la variable de entorno
conn_str = os.environ.get("SQL_CONNECTION_STRING")

def repartir_dividendos(req: func.HttpRequest) -> func.HttpResponse:
    logging.info('Procesando solicitud HTPP para ejecutar SP de Repartir Dividendos')

    try:
        #Verificar proposal name
        Proposalname = req.params.get('Proposalname')

        if not Proposalname:
            try:
                req_body = req.get_json()
                Proposalname = req_body.get('Proposalname')
            except ValueError:
                pass

        if not Proposalname:
            return func.HttpResponse("Incluya el parametro 'Proposalname'", status_code = 400)
        

        #Verificar Id Card
        id_card = req.params.get('idCard')

        if not id_card:
            try:
                req_body = req.get_json()
                id_card = req_body.get('idCard')
            except ValueError:
                pass

        if not id_card:
            return func.HttpResponse("Incluya el parametro 'idcard'", status_code = 400)
        
        #Verificacion de currency
        currency = req.params.get('Currency')
        
        if not currency:
            try:
                req_body = req.get_json()
                currency = req_body.get('Currency')
            except ValueError:
                pass

        if not currency:
            return func.HttpResponse("Incluya el parametro 'Currency'", status_code = 400)
        
        
        
        # Conexión a SQL Server y ejecución del SP mandandole los parametros
        with pyodbc.connect(conn_str) as conn:
            cursor = conn.cursor()
            try:
                cursor.execute("EXEC dbo.vpvSP_RepartirDividendos ?, ?, ?", (Proposalname, id_card, currency))
                conn.commit()
                return func.HttpResponse("Dividendos repartidos correctamente.", status_code=200)
            except pyodbc.Error as db_err:
                logging.error(f"Error de base de datos: {db_err}")
                # Extraer mensaje de error desde SQL Server
                sql_msg = str(db_err)
                return func.HttpResponse(f"Error al repartir dividendos: {sql_msg}", status_code=400)


    except Exception as e:
        logging.error(f"Error ejecutando el SP Repartir Dividendos: {e}")
        return func.HttpResponse(f"Error interno: {str(e)}", status_code=500)


```
</details>


---

<details>
  <summary>Ver codigo del lado del SQL SERVER</summary>


```sql


--######################### SP 1 ##########################
-----------------------------------------------------------
-- Autor: Priscilla Romero Barquero
-- Fecha: 06/10/2025
-- Descripcion: Registra todo el flujo de entrada/salida de dinero para el usuario y propuesta 
--				en especifico (transacciones y balances)
-- @userId: Usuario al cual recibirá una transacción por dividendos (genera transacción y modifica balance)
-- @crowdfoundingProposalId:  Propuesta de la cual salen los montos de los dividendos (genera transacción y modifica balance)
-- @amount:  Monto total del dividendo
-----------------------------------------------------------
CREATE OR ALTER PROCEDURE[dbo].[vpvSP_RealizarTransacciones]
	--Parametros externos
	@userId int,
	@crowdfoundingProposalId int,
	@amount decimal (10,2),
	@currency varchar(30)
AS 
BEGIN
	
	SET NOCOUNT ON

	DECLARE @ErrorNumber INT, @ErrorSeverity INT, @ErrorState INT, @CustomError INT
	DECLARE @Message VARCHAR(200)
	DECLARE @InicieTransaccion BIT

	-- declaracion de otras variables locales para hacer los insert
	DECLARE @date datetime = getdate();
	DECLARE @checksum varbinary(256);
	DECLARE @subtype int, @transType int;
	DECLARE @exchage int;
	DECLARE @balanceProp BIGINT, @balanceUser BIGINT, @found int;
	DECLARE @transactionProp BIGINT, @transactionUser BIGINT;
	DECLARE @lastbalance decimal (10,2);
	DECLARE @random int = FLOOR(RAND() * 5000) + 1;

	--Asigno valores a ciertas variables 
	SELECT @subtype = transactionSubTypeId FROM vpv_transSubTypes WHERE name = 'Pago de propuesta';
	SELECT @transType = transTypeId FROM vpv_transTypes WHERE name = 'Transfer'; -- Indica el transactionType si se hace de parte de la propuesta sería una transferencia, en este caso de dividendos
	SELECT @currency = currencyId FROM vpv_currencies WHERE acronym = @currency;	
	SELECT @exchage =  echangeRateId FROM vpv_exchangeRates WHERE currencyId = @currency AND currentExchange = '1';
	SELECT @found = foundId FROM vpv_founds WHERE name = 'Dinero';
	

	SET @checkSum = HASHBYTES('SHA2_256', 
       CONCAT(
           CAST(@userId AS VARCHAR),
           CAST(@crowdfoundingProposalId AS VARCHAR),
           CAST(@amount AS VARCHAR),
           CAST(@subtype AS VARCHAR),
           CAST(@transType AS VARCHAR),
           CAST(@currency AS VARCHAR),
           CAST(@exchage AS VARCHAR),
		   CAST(@random AS VARCHAR),
		   CAST(@random AS VARCHAR),
           CONVERT(VARCHAR, GETDATE(), 121)));

	
	SET @InicieTransaccion = 0
	IF @@TRANCOUNT = 0 BEGIN
		SET @InicieTransaccion = 1
		SET TRANSACTION ISOLATION LEVEL READ COMMITTED
		BEGIN TRANSACTION		
	END
	
	BEGIN TRY
		SET @CustomError = 2001

		--Se crea un balance negativo en el balance de la propuesta, simulando una salida de dinero
		INSERT INTO [dbo].[vpv_balances]
           ([balance],[lastbalance],[lastUpdate],[checksum],[foundId],[freezeAmount])
		VALUES
           (-@amount, @amount, @date, @checksum,@found, NULL);
		SET @balanceProp = SCOPE_IDENTITY();	--Asignamos el ultimo id generado en el balance 

		-- Se insertan las relaciones del balance y la propuesta
		INSERT INTO [dbo].[vpv_proposalBalance]
           ([BalanceId],[crowdfoundingProposalId],[executionDate],[checksum])
		VALUES
           (@balanceProp,@crowdfoundingProposalId, @date, @checksum);

		--Se realiza la transacción en sí, igaul simulando dinero de salida
		INSERT INTO [dbo].[vpv_transactions]
           ([amount],[description],[date],[postTime],[refNumber],[checksum],[convertedAmount],[paymentId],[transactionSubTypeId],
           [transTypeId],[currencyId],[exchangeRateId],[balanceId],[idUser])
		VALUES
           (-@amount, CONCAT('Pago de dividendos al usuario', @userId),@date, @date, CONCAT('VPV-',@random),
				@checksum, @amount, NULL, @subtype, @transType, @currency, @exchage, @balanceProp, NULL);
		SET @transactionProp = SCOPE_IDENTITY();
		
		-- Se insertan las relaciones de la transaccion y la propuesta
		INSERT INTO [dbo].[vpv_transactionPerPlan]
			([crowdfoundingProposalId],[executionPlanId],[transactionId],[executionDate],[checksum])
		VALUES
			(@crowdfoundingProposalId, NULL, @transactionProp, @date, @checksum);

		--Se inserta la simulación de ingreso de dinero hacia el usuario
		INSERT INTO [dbo].[vpv_balances]
           ([balance],[lastbalance],[lastUpdate],[checksum],[foundId],[freezeAmount])
		VALUES
           (@amount, @amount, @date, @checksum,@found, NULL);
		SET @balanceUser = SCOPE_IDENTITY();	--Asignamos el ultimo id generado en el balance

		--Se relaciona el balance con el user al que le pertenece 
		INSERT INTO [dbo].[vpv_userBalance]
           ([idUser],[balanceId],[checksum],[executionDate])
		VALUES
           (@userId,@balanceUser, @checksum,@date);

		--Generamos la transaccion de ingreso de al usuario +
		INSERT INTO [dbo].[vpv_transactions]
           ([amount],[description],[date],[postTime],[refNumber],[checksum],[convertedAmount],[paymentId],[transactionSubTypeId],
           [transTypeId],[currencyId],[exchangeRateId],[balanceId],[idUser])
		VALUES
           (@amount, CONCAT('Ingreso por dividendos de la prop', @crowdfoundingProposalId),@date, @date, 
		   CONCAT('VPV-',@random),@checksum, @amount, NULL, @subtype, @transType, @currency,
		   @exchage, @balanceUser, NULL);
		SET @transactionUser = SCOPE_IDENTITY();

		--Asociamos transaccion con el user
		INSERT INTO [dbo].[vpv_transactionPerUser]
           ([idUser],[sponsorGroupId],[entitydid],[transactionId],[executionDate],[checksum])
		VALUES
           (@userId, NULL,NULL, @transactionUser,@date,@checksum);


		--Guardamos en logs el ciclo de dividendos
		INSERT INTO [dbo].[vpv_logs]
           ([description],[computer],[username],[trace],[referenceId1],[referenceId2],[value1],[value2]
           ,[chechsum],[logSeverityId],[logSourceId],[logTypeId])
		VALUES(
		   CONCAT('Pago de dividendos de la propuesta ', @crowdfoundingProposalId,' al usuario ', @userId, ' Por un monto de ',
		   @amount,' Realizado el ', @date, ' por la transacción numero ', @transactionUser), CONCAT('Computer ', @random),
		   CONCAT('User', @userId), 'T1', CONCAT('Propuesta ', @crowdfoundingProposalId), CONCAT('User ',@userId),
		   CONCAT('Monto ', @amount),CONCAT('fecha ', @date), @checksum,
		   (SELECT logSeverityId FROM vpv_logSeverity WHERE name = 'High'),
           (SELECT logSourceId FROM vpv_logsSources WHERE name = 'Payment Gateway'),
           (SELECT logTypeId FROM vpv_logTypes WHERE name = 'Transaction'));

					
		IF @InicieTransaccion=1 BEGIN
			COMMIT
		END
	END TRY
	BEGIN CATCH
		-- en esencia, lo que hay  que hacer es registrar el error real, y enviar para arriba un error custom 
		SET @ErrorNumber = ERROR_NUMBER()
		SET @ErrorSeverity = ERROR_SEVERITY()
		SET @ErrorState = ERROR_STATE()
		SET @Message = ERROR_MESSAGE()
		
		IF @InicieTransaccion=1 BEGIN
			ROLLBACK
		END
		-- Se retorna el error a la capa superior
		RAISERROR('%s - Error Number: %i', 
			@ErrorSeverity, @ErrorState, @Message, @CustomError) -- hay que sustituir el @message por un error personalizado bonito, lo ideal es sacarlo de sys.messages 
		-- en la tabla de sys.messages se pueden insertar mensajes personalizados de error, los cuales se les hace match con el numero en @CustomError
	END CATCH	
END
RETURN 0
GO


--######################### SP 2 ##########################
-----------------------------------------------------------
-- Autor: Priscilla Romero Barquero
-- Fecha: 06/10/2025
-- Descripcion: Verifica los inversionistas de cada propuesta, monto invertido
--				y establece el monto a repartir segun inversion y utilidades disponibles
-- @crowdfoundingProposalId: Identificador de la propuesta para revisar sus inversionistas
-- @dividendos: Monto de utilidades disponibles segun la propuesta específica
-----------------------------------------------------------
CREATE OR ALTER PROCEDURE[dbo].[vpvSP_VerificarAgreements]
	--Parametros externos
	@crowdfoundingProposalId INT,
	@dividendos decimal(10,2),
	@currency varchar(30)

AS 
BEGIN
	
	SET NOCOUNT ON

	DECLARE @ErrorNumber INT, @ErrorSeverity INT, @ErrorState INT, @CustomError INT
	DECLARE @Message VARCHAR(200)
	DECLARE @InicieTransaccion BIT

	--Variables locales para verificaciones
	DECLARE @userId int, @inversion decimal(10,2), @totalInversiones decimal (10,2);
	DECLARE @paymentMethodId INT, @sponsorAgreementId int, @amount decimal(10,2);


	--Verificar que existen inversionistas asociados a la propuestas
	IF NOT EXISTS (SELECT 1 FROM vpv_investorsPerProject WHERE crowdfoundingProposalId = @crowdfoundingProposalId and enable = 1)
    BEGIN
        RAISERROR('No existen inversionistas activos para esta propuesta.', 16, 1);
        RETURN;
    END
		
	-- Hacer la suma del monto total invertido en una propuesta para poder establecer el monto a repartir a los inversionistas
	SELECT @totalInversiones = SUM(sa.inversion)
	FROM vpv_sponsorAgreements sa
	INNER JOIN vpv_investorsPerProject ip ON sa.sponsorAgreementId = ip.sponsorAgreementId
	WHERE ip.crowdfoundingProposalId = @crowdfoundingProposalId
    AND ip.enable = 1 -- Solo los inversionistas habilitados
    AND sa.enable = 1; -- Solo sponsors habilitados

	
	SET @InicieTransaccion = 0
	IF @@TRANCOUNT = 0 BEGIN
		SET @InicieTransaccion = 1
		SET TRANSACTION ISOLATION LEVEL READ COMMITTED
		BEGIN TRANSACTION		
	END
	
	BEGIN TRY
		SET @CustomError = 2001

		DECLARE Invest_Cursor CURSOR FOR
		SELECT idUser, sponsorAgreementId FROM vpv_investorsPerProject
		WHERE crowdfoundingProposalId = @crowdfoundingProposalId and enable = 1;

		-- Abre el cursor y se lleva al primer registro de la consulta anterior
		OPEN Invest_Cursor;
		FETCH NEXT FROM Invest_Cursor INTO @userId, @sponsorAgreementId; 

		WHILE @@FETCH_STATUS = 0	--Mientras que el cursor no llegue al final de los registros
		BEGIN
			--Se obtiene el monto invertido inicialmente
			SELECT @inversion = inversion
			FROM vpv_sponsorAgreements
			WHERE sponsorAgreementId = @sponsorAgreementId;

			--Se verefica que exista un registro en paymentmethod para ese usuario recorrido
			IF EXISTS (SELECT 1 FROM vpv_availablePaymentMethodsPerUser WHERE idUser = @userId AND enable = 1)
			BEGIN
				
				-- Monto a repartir para dividendo
				SET @amount = (@inversion/ @totalInversiones)*@dividendos;	--Monto a repartir

				EXEC [dbo].[vpvSP_RealizarTransacciones] 
                @userId = @userId,
                @crowdfoundingProposalId = @crowdfoundingProposalId,
                @amount = @amount,
				@currency = @currency;
			END

			FETCH NEXT FROM Invest_Cursor INTO @userId, @sponsorAgreementId;	--Continua al siguiente registro 
		
		END

		CLOSE Invest_Cursor;
		DEALLOCATE Invest_Cursor;	
			
		IF @InicieTransaccion=1 BEGIN
			COMMIT
		END
	END TRY
	BEGIN CATCH
		-- en esencia, lo que hay  que hacer es registrar el error real, y enviar para arriba un error custom 
		SET @ErrorNumber = ERROR_NUMBER()
		SET @ErrorSeverity = ERROR_SEVERITY()
		SET @ErrorState = ERROR_STATE()
		SET @Message = ERROR_MESSAGE()
		
		IF @InicieTransaccion=1 BEGIN
			ROLLBACK
		END


		-- Se retorna el error a la capa superior
		RAISERROR('%s - Error Number: %i', 
			@ErrorSeverity, @ErrorState, @Message, @CustomError) -- hay que sustituir el @message por un error personalizado bonito, lo ideal es sacarlo de sys.messages 
		-- en la tabla de sys.messages se pueden insertar mensajes personalizados de error, los cuales se les hace match con el numero en @CustomError
	END CATCH	
END
RETURN 0
GO




--######################### SP 3 ##########################
-----------------------------------------------------------
-- Autor: Priscilla Romero Barquero
-- Fecha: 06/10/2025
-- Descripcion: Verifica que la propuesta está en ejecución, con fiscalizaciones aprobadas 
--				y que existen fondos disponibles para repartir utilidades
-- @Proposalname: Nombre de la propuesta de la cual se quiere repartir los dividendos
-----------------------------------------------------------
CREATE OR ALTER PROCEDURE[dbo].[vpvSP_RepartirDividendos]
	--Parametros externos
	@Proposalname nvarchar(100),
	@idCard VARCHAR(255),
	@currency varchar (30)
AS 
BEGIN
	
	SET NOCOUNT ON

	DECLARE @ErrorNumber INT, @ErrorSeverity INT, @ErrorState INT, @CustomError INT
	DECLARE @Message VARCHAR(200)
	DECLARE @InicieTransaccion BIT

	--Variables locales para verificaciones
	DECLARE @idUsuarioEjecuta INT
	DECLARE @crowdfoundingProposalId int, @proposalId int, @propstatusId int, @repstatusId int;
	DECLARE @dividendos decimal (10,2);

	--Asignar valores a ciertas variables
	SELECT @propstatusId = statusId from vpv_processStatus WHERE name = 'En proceso';
	SELECT @repstatusId = statusId from vpv_processStatus WHERE name = 'Aprobado'

	SELECT @proposalId = proposalId FROM vpv_proposals WHERE tittle = @Proposalname and enable = 1;
    IF @proposalId IS NULL
    BEGIN
        RAISERROR('No se encontró una propuesta habilitada con ese nombre.', 16, 1);
        RETURN;
    END

	--Se asocia la propuesta con la crowdfounding proposal
	SELECT @crowdfoundingProposalId = cp.crowdfoundingProposalId 
	FROM vpv_crowdfoundingProposals cp
	INNER JOIN vpv_proposals p ON p.proposalId = cp.proposalId
	WHERE p.proposalId = @proposalId AND cp.statusId = @propstatusId;

    IF @crowdfoundingProposalId IS NULL
    BEGIN
        RAISERROR('La propuesta no se encuentra en estado "En proceso".', 16, 1);
        RETURN;
    END

	--Asociar dividendos
	SELECT @dividendos = availablePayment FROM vpv_projectReports 
	WHERE crowdfoundingProposalId = @crowdfoundingProposalId and statusId = @repstatusId;

    IF @dividendos IS NULL
    BEGIN
        RAISERROR('No se encontró un reporte aprobado con dividendos disponibles para esta propuesta.', 16, 1);
        RETURN;
    END

	--Verificar identidad del usuario y confirmar su registro en el sistema por medio de la desencriptacion de la cedula de usuarios------------------
	OPEN SYMMETRIC KEY llavecedula DECRYPTION BY PASSWORD = 'clavecedula';

	SELECT TOP 1 @idUsuarioEjecuta = idUser 
	FROM vpv_Users 
	WHERE CONVERT(nvarchar(50), DECRYPTBYKEY(id_card)) = @idCard AND enable = 1;

	CLOSE SYMMETRIC KEY llavecedula;

	IF @idUsuarioEjecuta IS NULL
	BEGIN
		RAISERROR('El usuario no está registrado o no está habilitado.', 16, 1);
		RETURN;
	END

	--Validacion de permisos con ello se busca si el usuario tiene el rol con el permiso asignado
	DECLARE @hasRole BIT;

	EXEC dbo.vpvSP_UserHasRole
		@idUser = @idUsuarioEjecuta,
		@roleName = N'Ciudadano',
		@HasRole = @hasRole OUTPUT;
	--Si retorna 0, en valido como null por lo tanto no hay permisos de inversion
	IF @hasRole IS NULL
	BEGIN
		RAISERROR('El usuario no posee el rol necesario para realizar esta acción.', 16, 1);
		RETURN;
	END


	--Verificar que la propuesta está ejecutandose
	IF NOT EXISTS (SELECT 1 FROM vpv_proposals WHERE proposalId = @proposalId AND statusId = @propstatusId)	
    BEGIN
        RAISERROR('La propuesta no está en estado "En proceso".', 16, 1);
        RETURN;
    END

	--Verificar que las propuesta tenga fiscalizaciones aprobadas
	IF NOT EXISTS (SELECT 1 FROM vpv_ProposalTracking WHERE proposalId = @proposalId AND statusId = @repstatusId)	
    BEGIN
        RAISERROR('La propuesta no tiene fiscalizaciones aprobadas.', 16, 1);
        RETURN;
    END
	
	--Verificar dividendos disponibles
    IF @dividendos <= 0
    BEGIN
        RETURN 7; -- No hay dividendos disponibles
    END
	
	SET @InicieTransaccion = 0
	IF @@TRANCOUNT = 0 BEGIN
		SET @InicieTransaccion = 1
		SET TRANSACTION ISOLATION LEVEL READ COMMITTED
		BEGIN TRANSACTION		
	END
	
	BEGIN TRY
		SET @CustomError = 2001

		IF EXISTS (SELECT 1 FROM vpv_projectReports where crowdfoundingProposalId = @crowdfoundingProposalId
		AND statusId = @repstatusId)
		BEGIN
			EXEC [dbo].[vpvSP_VerificarAgreements]
                @crowdfoundingProposalId = @crowdfoundingProposalId,
				@dividendos = @dividendos,
				@currency = @currency;
		END 	
			
		IF @InicieTransaccion=1 BEGIN
			COMMIT
		END
	END TRY
	BEGIN CATCH
		-- en esencia, lo que hay  que hacer es registrar el error real, y enviar para arriba un error custom 
		SET @ErrorNumber = ERROR_NUMBER()
		SET @ErrorSeverity = ERROR_SEVERITY()
		SET @ErrorState = ERROR_STATE()
		SET @Message = ERROR_MESSAGE()
		
		IF @InicieTransaccion=1 BEGIN
			ROLLBACK
		END


		-- Se retorna el error a la capa superior
		RAISERROR('%s - Error Number: %i', 
			@ErrorSeverity, @ErrorState, @Message, @CustomError) -- hay que sustituir el @message por un error personalizado bonito, lo ideal es sacarlo de sys.messages 
		-- en la tabla de sys.messages se pueden insertar mensajes personalizados de error, los cuales se les hace match con el numero en @CustomError
	END CATCH	
END
RETURN 0
GO

/*
-- Parámetros de prueba
DECLARE @Proposalname nvarchar(100) = 'Plataforma digital de salud pública';  
DECLARE @idCard nvarchar(100) = '258503207';  
DECLARE @currency nvarchar(100) = 'CRC'; 

-- Ejecutar el procedimiento
EXEC [dbo].[vpvSP_RepartirDividendos] 
    @Proposalname = @Proposalname,
	@idCard = @idCard,
	@currency = @currency;
*/



```
 
  </details>

<details>
<summary>Ver JSON de prueba principal</summary>

```json

{
    "idCard":"258503207",
    "Proposalname": "Plataforma digital de salud pública",
    "Currency":"CRC"
}

```
</details>

    
  </details>

  </details>

## 🟣 Endpoints implementados por ORM

Los endpoints implementados mediante **ORM (Object-Relational Mapping)** permiten interactuar con la base de datos de forma más abstracta y orientada a objetos. En lugar de escribir directamente consultas SQL, se trabajan con clases y objetos que representan las tablas y registros de la base de datos. Esto facilita el desarrollo, mantenimiento y escalabilidad del código.

### ⚗️ SQLAlchemy: La herramienta principal

Para esta implementación se utiliza **SQLAlchemy**, una biblioteca popular en Python para el manejo de bases de datos relacionales. SQLAlchemy proporciona:

- **Modelos declarativos**: cada tabla de la base de datos se representa como una clase Python con atributos que corresponden a las columnas de la tabla.
- **Sesiones de trabajo**: permiten realizar operaciones transaccionales (insertar, actualizar, borrar) de forma segura, con control sobre commits y rollbacks.
- **Consultas expresivas**: ofrece una API para construir consultas complejas sin necesidad de escribir SQL manualmente, lo que reduce errores y mejora la legibilidad.
- **Compatibilidad con múltiples motores de bases de datos**, aunque en este proyecto se conecta a un servidor SQL Server.

### Ventajas de usar ORM en los endpoints

- **Abstracción del acceso a datos**: el desarrollador trabaja con objetos y métodos, no con sentencias SQL.
- **Control de transacciones**: las sesiones permiten garantizar la atomicidad y consistencia mediante commits y rollbacks automáticos o manuales.
- **Facilidad para validar y manipular datos**: es posible integrar validaciones y lógica directamente en los modelos o en los controladores de la aplicación.
- **Mejor mantenimiento y escalabilidad**: el código es más limpio y modular, facilitando la incorporación de nuevas funcionalidades.

### Otras herramientas usadas en conjunto

- **Azure Functions**: plataforma serverless que permite desplegar funciones HTTP como endpoints del API, manejando la lógica de negocio de forma distribuida y escalable.
- **dotenv**: biblioteca para cargar variables de entorno desde archivos `.env`, facilitando la configuración y seguridad (por ejemplo, para claves o cadenas de conexión).
- **Python estándar**: para el manejo de JSON, logging y procesamiento de las solicitudes HTTP.

### Flujo general en los endpoints ORM

1. **Recepción de la solicitud HTTP** con datos en formato JSON.
2. **Validación de permisos y datos de entrada** para garantizar que el usuario pueda realizar la acción y que los datos sean correctos.
3. **Inicio de una sesión de SQLAlchemy** para manipular los datos.
4. **Operaciones con los modelos**: creación, actualización o consulta de registros en la base de datos usando métodos de la sesión.
5. **Confirmación de los cambios mediante commit** o reversión ante errores con rollback.
6. **Respuesta HTTP con el resultado de la operación** (éxito o error).

Este enfoque permite un desarrollo robusto, seguro y eficiente de la API, favoreciendo la colaboración entre desarrolladores y la evolución del sistema.


  
  ---
  
  <details>
  <summary>Ver Endpoints</summary>

### Votar

  <details>
	  <summary>Ver informacion</summary>
   Este endpoint permite al usuario realizar una votacion a una propuesta.

   #### Funcionalidad principal

   Primero se inicia validando los credenciales del usuario, al usar la contrasena proveida y obtener el idUser, entonces se valida el usuario, luego se verifica que el usuario este activo.
   Despues se verifican los permisos del usuario sobre las tablas que va a utilizar.
   Luego se verifica que la propuesta a votar existe, la version a la cual se esta votando y de esa version se verifica la configuracion de votacion actual.
   Tras eso verificamos que el usuario es parte de la poblacion objetivo de la votacion, revisando si las demografias de la votacion son las mismas que las del usuario.

   Ahora buscamos los id de las preguntas y los id de las opciones de votacion, relacionadas a la configuracion de votacion, estos id los necesitamos para la insercion de los votos.
   Y ahora que tenemos el id de la votacion, revisamos que se encuentra en el rango de fecha disponible.
   Luego obtenemos el idVoter.
   Generamos un nuevo token.
   Y procedemos a la insercion de votos: primero obtenemos el key name del usuario para la llave simetrica.
   Registramos los votos a tomar para que el usuario no puede votar multiples veces.
   Luego registramos el voto con los id que obtuvimos antes. Entonces encriptamos los valores del voto y los insertamos en la tabla de valores de votos.
   Como los votos son encriptados, aumentamos el conteo de votos y sumarizamos los votos en la tabla de resultados por opcion.
   Al final marcamos el token como usado.



   <details>
	   <summary>Ver Funcion ORM</summary>

```python

import json
import logging
from datetime import datetime

import azure.functions as func
from database import SessionLocal
from Models.votar.models import User, Voter

from helpers.votar.insertLogs import insertLog
from helpers.votar.obtenerIdUser import obtenerIdUser
from helpers.votar.user_can import user_can
from helpers.votar.obtener_preguntas_por_nombre import obtener_preguntas_por_nombre
from helpers.votar.is_date_within_voting_window import is_date_within_voting_window
from helpers.votar.get_votes_id import get_next_vote_id, get_next_votes_taken_id, get_next_vote_value_id
from helpers.votar.insert_votes import insert_votes
from helpers.votar.mark_token_used import mark_token_used
from helpers.votar.generate_blind_token import generate_blind_token


def votar(req: func.HttpRequest) -> func.HttpResponse:
    logging.info('Procesando solicitud de permiso (votar).')

    ################################
    ## 1) Parsear JSON de entrada ##
    ################################
    try:
        body = req.get_json()
    except ValueError:
        return func.HttpResponse("JSON inválido.", status_code=400)

    # user_id  = body.get("auth", {}).get("idUser")
    id_card  = body.get("auth", {}).get("cedula")
    password = body.get("auth", {}).get("password")
    token = body.get("auth", {}).get("mfa", {}).get("code")
    proposal_name   = body.get("proposalName")
    version_name    = body.get("proposalVersionName")
    votos_list      = body.get("votos", [])
    date_str        = body.get("date")


    #############################
    ## 2) Validaciones básicas ##
    #############################
    if not all([id_card, password, proposal_name, version_name, date_str]):
        return func.HttpResponse(
            "Faltan campos obligatorios en el JSON.",
            status_code=400
        )
        
    #######################
    ## Obtener el idUser ##
    #######################
    try:
        user_id = obtenerIdUser(id_card)
    except Exception:
        return func.HttpResponse(
            json.dumps({"error": "No se pudo obtener el idUser."}, ensure_ascii=False), 
            status_code=400, 
            mimetype="application/json"
        )

    # convertir fecha
    try:
        date_to_check = datetime.fromisoformat(date_str)
    except Exception:
        return func.HttpResponse(
            json.dumps({"error": "Formato de fecha inválido."}, ensure_ascii=False), 
            status_code=400, 
            mimetype="application/json"
        )


    ################################################
    ## 3) Verificar existencia activa del usuario ##
    ################################################
    try:
        with SessionLocal() as session:
            user = session.get(User, user_id)
            if not user or not user.enable or user.deleted:
                return func.HttpResponse(
                    json.dumps({"error": "Usuario no activo"}, ensure_ascii=False),
                    status_code=200,
                    mimetype="application/json"
                )
    except Exception as e:
        logging.error(f"Error al verificar usuario: {e}")
        return func.HttpResponse(f"Error interno: {e}", status_code=500)


    ###############################################
    ## 4) Verificar permisos CRUD sobre la tabla ##
    ###############################################
    try:            
        # 1) Verificar SELECT sobre vpv_votingConfigurations
        if not user_can(user_id, "vpv_votingConfigurations", "SELECT"):
            return func.HttpResponse(
                json.dumps({"error": "Sin permiso sobre el recurso", "recurso": "vpv_votingConfigurations", "accion": "SELECT"}, ensure_ascii=False),
                status_code=200,
                mimetype="application/json"
            )

        # 2) Verificar SELECT sobre vpv_encryptionkeys
        if not user_can(user_id, "vpv_encryptionkeys", "SELECT"):
            return func.HttpResponse(
                json.dumps({"error": "Sin permiso sobre el recurso", "recurso": "vpv_encryptionkeys", "accion": "SELECT"}, ensure_ascii=False),
                status_code=200,
                mimetype="application/json"
            )

        # 3) Verificar SELECT sobre vpv_proposals
        if not user_can(user_id, "vpv_proposals", "SELECT"):
            return func.HttpResponse(
                json.dumps({"error": "Sin permiso sobre el recurso", "recurso": "vpv_proposals", "accion": "SELECT"}, ensure_ascii=False),
                status_code=200,
                mimetype="application/json"
            )

        # 4) Verificar SELECT sobre vpv_proposalVersions
        if not user_can(user_id, "vpv_proposalVersions", "SELECT"):
            return func.HttpResponse(
                json.dumps({"error": "Sin permiso sobre el recurso", "recurso": "vpv_proposalVersions", "accion": "SELECT"}, ensure_ascii=False),
                status_code=200,
                mimetype="application/json"
            )

        # 5) Verificar SELECT sobre vpv_PopulationFilters
        if not user_can(user_id, "vpv_PopulationFilters", "SELECT"):
            return func.HttpResponse(
                json.dumps({"error": "Sin permiso sobre el recurso", "recurso": "vpv_PopulationFilters", "accion": "SELECT"}, ensure_ascii=False),
                status_code=200,
                mimetype="application/json"
            )

        # 6) Verificar SELECT sobre vpv_TargetPopulations
        if not user_can(user_id, "vpv_TargetPopulations", "SELECT"):
            return func.HttpResponse(
                json.dumps({"error": "Sin permiso sobre el recurso", "recurso": "vpv_TargetPopulations", "accion": "SELECT"}, ensure_ascii=False),
                status_code=200,
                mimetype="application/json"
            )

        # 7) Verificar SELECT sobre vpv_TargetPopulationsVoting
        if not user_can(user_id, "vpv_TargetPopulationsVoting", "SELECT"):
            return func.HttpResponse(
                json.dumps({"error": "Sin permiso sobre el recurso", "recurso": "vpv_TargetPopulationsVoting", "accion": "SELECT"}, ensure_ascii=False),
                status_code=200,
                mimetype="application/json"
            )

        # 8) Verificar SELECT sobre vpv_FilterTypes
        if not user_can(user_id, "vpv_FilterTypes", "SELECT"):
            return func.HttpResponse(
                json.dumps({"error": "Sin permiso sobre el recurso", "recurso": "vpv_FilterTypes", "accion": "SELECT"}, ensure_ascii=False),
                status_code=200,
                mimetype="application/json"
            )

        # 9) Verificar SELECT sobre vpv_demographics
        if not user_can(user_id, "vpv_demographics", "SELECT"):
            return func.HttpResponse(
                json.dumps({"error": "Sin permiso sobre el recurso", "recurso": "vpv_demographics", "accion": "SELECT"}, ensure_ascii=False),
                status_code=200,
                mimetype="application/json"
            )

        # 10) Verificar SELECT sobre vpv_votingQuestions
        if not user_can(user_id, "vpv_votingQuestions", "SELECT"):
            return func.HttpResponse(
                json.dumps({"error": "Sin permiso sobre el recurso", "recurso": "vpv_votingQuestions", "accion": "SELECT"}, ensure_ascii=False),
                status_code=200,
                mimetype="application/json"
            )

        # 11) Verificar SELECT sobre vpv_optionsQuestion
        if not user_can(user_id, "vpv_optionsQuestion", "SELECT"):
            return func.HttpResponse(
                json.dumps({"error": "Sin permiso sobre el recurso", "recurso": "vpv_optionsQuestion", "accion": "SELECT"}, ensure_ascii=False),
                status_code=200,
                mimetype="application/json"
            )

        # 12) Verificar INSERT sobre vpv_BlindTokens
        if not user_can(user_id, "vpv_BlindTokens", "INSERT"):
            return func.HttpResponse(
                json.dumps({"error": "Sin permiso sobre el recurso", "recurso": "vpv_BlindTokens", "accion": "INSERT"}, ensure_ascii=False),
                status_code=200,
                mimetype="application/json"
            )


        # 13) Verificar SELECT sobre vpv_VotesTaken
        if not user_can(user_id, "vpv_VotesTaken", "SELECT"):
            return func.HttpResponse(
                json.dumps({"error": "Sin permiso sobre el recurso", "recurso": "vpv_VotesTaken", "accion": "SELECT"}, ensure_ascii=False),
                status_code=200,
                mimetype="application/json"
            )

        # 14) Verificar INSERT sobre vpv_VotesTaken
        if not user_can(user_id, "vpv_VotesTaken", "INSERT"):
            return func.HttpResponse(
                json.dumps({"error": "Sin permiso sobre el recurso", "recurso": "vpv_VotesTaken", "accion": "INSERT"}, ensure_ascii=False),
                status_code=200,
                mimetype="application/json"
            )

        # 15) Verificar INSERT sobre vpv_Votes
        if not user_can(user_id, "vpv_Votes", "INSERT"):
            return func.HttpResponse(
                json.dumps({"error": "Sin permiso sobre el recurso", "recurso": "vpv_Votes", "accion": "INSERT"}, ensure_ascii=False),
                status_code=200,
                mimetype="application/json"
            )

        # 16) Verificar INSERT sobre vpv_voteValues
        if not user_can(user_id, "vpv_voteValues", "INSERT"):
            return func.HttpResponse(
                json.dumps({"error": "Sin permiso sobre el recurso", "recurso": "vpv_voteValues", "accion": "INSERT"}, ensure_ascii=False),
                status_code=200,
                mimetype="application/json"
            )
    except Exception as e:
        logging.error(f"Error al verificar permiso: {e}")
        return func.HttpResponse(f"Error interno: {e}", status_code=500)



    ###############################################
    ## 5) Obtener preguntas y opciones filtradas ##
    ###############################################
    try:
        resultado = obtener_preguntas_por_nombre(
            user_id=user_id,
            proposal_name=proposal_name,
            version_name=version_name,
            votos_list=votos_list
        )
        proposalId = resultado["proposalId"]
        proposalVersionId = resultado["proposalVersionId"]
        votos = resultado["votos"]
    except Exception as e:
        logging.error(f"Error al obtener preguntas: {e}")
        return func.HttpResponse(f"Error interno: {e}", status_code=500)


    ######################################
    ## 6) Verificar ventana de votación ##
    ######################################
    try:
        if not is_date_within_voting_window(proposalVersionId, date_to_check):
            return func.HttpResponse(
                json.dumps({"puede": "No", "error": "Fuera de rango de votación"}, ensure_ascii=False),
                status_code=200,
                mimetype="application/json"
            )
    except Exception as e:
        logging.error(f"Error al verificar ventana: {e}")
        return func.HttpResponse(f"Error interno: {e}", status_code=500)


    ######################################################################
    ## 7) Obtener el idVoter (primer registro) desde la tabla vpv_Voter ##
    ######################################################################
    try:
        with SessionLocal() as session:
            voter = (
                session.query(Voter)
                       .filter(Voter.idUser == user_id)
                       .order_by(Voter.idVoter)
                       .first()
            )
            if not voter:
                return func.HttpResponse(
                    json.dumps({"error": f"No se encontró voter para user_id {user_id}"}),
                    status_code=400,
                    mimetype="application/json"
                )
            id_voter = voter.idVoter
    except Exception as e:
        logging.error(f"Error al buscar voter: {e}")
        return func.HttpResponse(f"Error interno: {e}", status_code=500)


    ###############################
    ## 8) Generar un nuevo token ##
    ###############################
    new_token = generate_blind_token()


    ###########################################################
    ## 9) Llamar a la función auxiliar que inserta los votos ##
    ###########################################################
    try:
        insert_votes(
            user_id=user_id,
            id_token=new_token,
            id_voter=id_voter,
            votos=votos,
            password=password
        )
    except Exception as e:
        logging.error(f"Error al insertar votos: {e}")
        return func.HttpResponse(
            json.dumps({"error": str(e)}, ensure_ascii=False),
            status_code=500,
            mimetype="application/json"
        )

    mark_token_used(new_token)
    
    return func.HttpResponse(
        json.dumps({"status": "ok", "inserted": len(votos)}),
        status_code=200,
        mimetype="application/json"
    )

```
</details>

#### Funciones auxiliares


<details>
	<summary>Ver obtenerIdUser</summary>

 ```python
import os
from sqlalchemy import select, text
from database import SessionLocal
from dotenv import load_dotenv


# Carga las variables del .env
load_dotenv()
#variables de entorno
clave = os.getenv("CLAVECEDULA")

def obtenerIdUser(cedula_clara):
    with SessionLocal() as session:
        try:
            # Abrir la clave
            session.execute(text(f"""
                OPEN SYMMETRIC KEY llavecedula
                DECRYPTION BY PASSWORD = '{clave}';
            """))

            # Ejecutar SELECT directamente, evitando mapeo extraño de parámetros
            sql = f"""
                SELECT u.idUser
                FROM dbo.vpv_Users AS u
                WHERE CONVERT(NVARCHAR(50), DecryptByKey(CAST(u.id_card AS VARBINARY(MAX)))) = '{cedula_clara}';
            """

            result = session.execute(text(sql))
            row = result.fetchone()

            return row.idUser if row else None

        finally:
            # Siempre cerrar la clave aunque haya error
            session.execute(text("CLOSE SYMMETRIC KEY llavecedula;"))
```
</details>

<details>
	<summary>Ver user_can</summary>

```python
from sqlalchemy import select
from database import SessionLocal
from Models.votar.models import (
    User, PermissionResource, PermissionAction, Permission, 
    UserRole, RolePermission
)

def user_can(id_user: int, resource_name: str, action_name: str) -> bool:
    with SessionLocal() as session:
        # 1) Usuario activo
        user = session.get(User, id_user)
        if not user or not user.enable or user.deleted:
            return False

        # 2) Resource & Action
        resource = session.scalar(
            select(PermissionResource)
            .where(
                PermissionResource.name == resource_name,
                PermissionResource.enabled == True,
                PermissionResource.deleted == False
            )
        )
        action = session.scalar(
            select(PermissionAction)
            .where(PermissionAction.name == action_name)
        )
        if not resource or not action:
            return False

        # 3) Permiso
        stmt = (
            select(Permission)
            .join(RolePermission, RolePermission.id_permission == Permission.id_permission)
            .join(UserRole, UserRole.id_role == RolePermission.id_role)
            .where(
                UserRole.idUser == id_user,
                UserRole.enabled == True,
                UserRole.deleted == False,
                Permission.id_permisionResource == resource.id_permissionResource,
                Permission.id_permissionAction == action.id_permissionAction,
                Permission.enabled == True,
                Permission.deleted == False
            )
        )
        return session.scalar(stmt) is not None
```
</details>

<details>
	<summary>Ver obtener_preguntas_por_nombre</summary>

 ```python
from sqlalchemy import select, and_
from database import SessionLocal
from Models.votar.models import (
    Proposal, ProposalVersion, VotingConfiguration,
    PopulationFilter, TargetPopulation, TargetPopulationsVoting,
    FilterType, Demographic,
    VotingQuestion, Question, OptionQuestion
)

 
def obtener_preguntas_por_nombre(user_id: int,
                                 proposal_name: str,
                                 version_name: str,
                                 votos_list: list[dict]):
    with SessionLocal() as session:
        # 1) Propuesta
        prop = session.query(Proposal).filter(
            Proposal.tittle == proposal_name
        ).first()
        if not prop:
            raise Exception(f'Propuesta "{proposal_name}" no encontrada.')

        # 2) Versión
        pv = session.query(ProposalVersion).filter(
            ProposalVersion.proposalId == prop.proposalId,
            ProposalVersion.tittle    == version_name
        ).first()
        if not pv:
            raise Exception(f'Versión "{version_name}" no encontrada.')

        # 3) Configuración de votación
        vc = session.query(VotingConfiguration).filter(
            VotingConfiguration.proposalVersionId == pv.proposalVersionId
        ).first()
        if not vc:
            raise Exception(f'No hay configuración de votación para la versión "{version_name}".')

        # 4) Filtros demográficos (sin usar relaciones)
        filtros = (
            session.query(PopulationFilter)
                   .join(TargetPopulation,
                         PopulationFilter.idTargetPopulation == TargetPopulation.idTargetPopulation)
                   .join(TargetPopulationsVoting,
                         TargetPopulation.idTargetPopulation == TargetPopulationsVoting.idTargetPopulation)
                   .filter(TargetPopulationsVoting.idVotingConfig == vc.idVotingConfig)
                   .all()
        )
        for pf in filtros:
            ft = session.query(FilterType).filter(
                FilterType.idFilterType == pf.idFilterType
            ).first()
            match = session.query(Demographic).filter(
                and_(
                    Demographic.userid     == user_id,
                    Demographic.demotypeid == ft.demotypeid
                )
            ).first()
            if not match:
                raise Exception(f"Usuario {user_id} no cumple filtro demográfico {pf.idPopulationFilter}-{ft.name}.")

        # 5) Cargar preguntas uniendo explícitamente con la tabla vpv_questions
        preguntas = session.query(
            VotingQuestion.idVotingQuestions,
            VotingQuestion.idQuestion,
            VotingQuestion.idVotingConfig,
            Question.description.label("question_text")
        ).join(
            Question,
            VotingQuestion.idQuestion == Question.idQuestion
        ).filter(
            VotingQuestion.idVotingConfig == vc.idVotingConfig,
            VotingQuestion.enable == True
        ).order_by(VotingQuestion.orderBy).all()

        # 6) Indexar preguntas por texto
        mapa = { q.question_text: q for q in preguntas }

        resultados = {
            "proposalId":          prop.proposalId,
            "proposalVersionId":   pv.proposalVersionId,
            "proposalName":        prop.tittle,
            "proposalVersionName": pv.tittle,
            "votos": []
        }

        for voto in votos_list:
            q_text = voto["question"]
            o_text = voto["voto"]
            q = mapa.get(q_text)
            if not q:
                raise Exception(f'Pregunta "{q_text}" no encontrada.')

            # 7) Cargar opciones de esta pregunta (sin relaciones)
            opciones = session.query(
                OptionQuestion.idOptionQuestion,
                OptionQuestion.description.label("opt_text")
            ).filter(
                OptionQuestion.idQuestions == q.idQuestion,
                OptionQuestion.enable == True
            ).all()

            # 8) Buscar match por descripción
            opt = next((o for o in opciones if o.opt_text == o_text), None)
            if not opt:
                raise Exception(f'Opción "{o_text}" "{opt}" no válida para la pregunta "{q_text}".')

            resultados["votos"].append({
                "questionId":     q.idVotingQuestions,
                "votingConfigId": q.idVotingConfig,
                "optionId":       opt.idOptionQuestion,
                "voto":           o_text
            })

        return resultados
 
```
</details>

<details>
	<summary>Ver is_date_within_voting_window</summary>

 ```python
from datetime import datetime
from sqlalchemy import select
from database import SessionLocal
from Models.votar.models import VotingConfiguration



def is_date_within_voting_window(proposal_version_id: int, date_to_check: datetime) -> bool:
    """
    Devuelve True si `date_to_check` cae entre openDate y closeDate
    para la configuración que coincide con `proposal_version_id`.
    """
    with SessionLocal() as session:
        stmt = (
            select(VotingConfiguration.openDate, VotingConfiguration.closeDate)
            .where(VotingConfiguration.proposalVersionId == proposal_version_id)
        )
        row = session.execute(stmt).first()
        if not row:
            # No existe configuración para esa versión
            return False

        open_dt, close_dt = row.openDate, row.closeDate
        return open_dt <= date_to_check <= close_dt
    
```
</details>

<details>
	<summary>Ver insert_votes</summary>

 ```python
import uuid
import hashlib
import socket
from datetime import datetime
from sqlalchemy import select
from database import SessionLocal
from Models.votar.models import (
    Vote, VoteValue, VotesTaken, VotingConfiguration, VotingQuestion, OptionQuestion,
    User
)
from helpers.votar.hasUserVoted import hasUserVoted
from helpers.votar.insertLogs import insertLog
from helpers.votar.updateVoteCount import updateVoteCount
from helpers.votar.sumarizeResults import summarizeResults
from helpers.votar.get_key_name import get_key_name
from helpers.votar.get_votes_id import get_next_vote_id, get_next_votes_taken_id, get_next_vote_value_id
from helpers.votar.encrypt_with_user_key import encrypt_with_user_key




def insert_votes(user_id: int, id_token: uuid.UUID, id_voter: int, votos: list, password: str):
    """
    Inserta los votos en la base de datos. 
    Encripta los valores de voto usando encrypt_with_user_key.
    Además loggea cada paso crítico.
    """
    key_name = get_key_name(user_id)
    if not key_name:
        insertLog(
            description=f"No se encontró llave habilitada para user_id {user_id}",
            computer=socket.gethostname(),
            username=str(user_id),
            trace="insert_votes:key_lookup",
            severity_name="High",
            source_name="VotingService",
            type_name="Error",
        )
        raise Exception(f"No se encontró llave habilitada para user_id {user_id}")

    with SessionLocal() as session:
        try:
            # 1) Marcar cada pregunta como votada
            for v in votos:
                qid     = v["questionId"]
                qName   = v.get("questionName", str(qid))
                if hasUserVoted(user_id, qid):
                    insertLog(
                        description=f"Intento múltiple de voto para pregunta {qName}",
                        computer=socket.gethostname(),
                        username=str(user_id),
                        trace="insert_votes:duplicate_check",
                        reference1=str(qid),
                        severity_name="Warning",
                        source_name="VotingService",
                        type_name="Audit",
                    )
                    raise Exception(f"El usuario ya voto a esta pregunta: {qName}")

                taken = VotesTaken(
                    idUser=user_id,
                    idVotingQuestions=qid,
                    checksum=hashlib.sha256(f"{user_id}_{qid}".encode()).digest()
                )
                session.add(taken)

            session.flush()

            insertLog(
                description="Se marcaron preguntas como tomadas",
                computer=socket.gethostname(),
                username=str(user_id),
                trace="insert_votes:mark_taken",
                reference1=str([v["questionId"] for v in votos]),
                severity_name="Informational",
                source_name="VotingService",
                type_name="Audit",
            )

            # 2) Insertar cada voto y su valor cifrado
            for v in votos:
                qid = v["questionId"]
                votingConfigId = v["votingConfigId"]
                oid = v["optionId"]
                rv  = v["voto"]

                vote = Vote(
                    idVotingQuestion=qid,
                    idVotingConfig=votingConfigId,
                    idToken=id_token,
                    idVoter=id_voter,
                    idOptionQuestion=oid,
                    checksum=hashlib.sha256(f"{id_token}{id_voter}".encode()).digest()
                )
                session.add(vote)
                session.flush()  # para obtener vote.idVote

                encrypted = encrypt_with_user_key(
                    user_id=user_id,
                    key_name=key_name,
                    password=password,
                    texto_a_encriptar=rv
                )
                vv = VoteValue(
                    idVote=vote.idVote,
                    value1=encrypted,
                    value2=b"",
                    checksum=hashlib.sha256(encrypted).digest()
                )
                session.add(vv)
                
                updateVoteCount(
                    voting_config_id = votingConfigId,
                    question_id      = qid,
                    option_id        = oid
                )

                insertLog(
                    description=f"Registro de voto para pregunta {qid}, opción {oid}",
                    computer=socket.gethostname(),
                    username=str(user_id),
                    trace="insert_votes:vote_insert",
                    reference1=str(vote.idVote),
                    reference2=str(oid),
                    value1=rv,
                    severity_name="Informational",
                    source_name="VotingService",
                    type_name="Audit",
                )

            session.commit()
            
            summarizeResults(votingConfigId)

            insertLog(
                description="Todos los votos insertados correctamente",
                computer=socket.gethostname(),
                username=str(user_id),
                trace="insert_votes:complete",
                reference1=str(id_token),
                severity_name="Informational",
                source_name="VotingService",
                type_name="Audit",
            )
        except Exception as e:
            session.rollback()
            insertLog(
                description="Error al insertar votos",
                computer=socket.gethostname(),
                username=str(user_id),
                trace="insert_votes:exception",
                value1=str(e),
                severity_name="Critical",
                source_name="VotingService",
                type_name="Error",
            )
            # relanzamos para que lo capture la capa superior
            raise        
      
```
</details>

<details>
	<summary>Ver summarizeResults</summary>
	
```python
from sqlalchemy import func, case, DECIMAL, literal_column
import hashlib
from database import SessionLocal
from Models.votar.models import Vote, VoteValue, OptionQuestion, VotingQuestion, ResultsPerOption

def summarizeResults(voting_config_id: int):
    """
    Recorre todas las preguntas de una configuración de votación y
    genera/actualiza los resultados en vpv_ResultsPerOption.
    """
    with SessionLocal() as session:
        # 1) Subconsulta para totales por pregunta
        total_subq = (
            session.query(
                Vote.idVotingQuestion.label('qid'),
                func.count(Vote.idVote).label('total')
            )
            .group_by(Vote.idVotingQuestion)
            .subquery()
        )

        # 2) Agregaciones por opción (sin avg sobre value1)
        stmt = (
            session.query(
                OptionQuestion.idOptionQuestion,
                OptionQuestion.idQuestions,
                func.count(Vote.idVote).label('cnt'),
                (func.count(Vote.idVote) * 100.0
                    / func.nullif(total_subq.c.total, 0)
                ).label('pct'),
                case(
                    (func.count(Vote.idVote)
                        == func.max(func.count(Vote.idVote))
                               .over(partition_by=OptionQuestion.idQuestions),
                     True),
                    else_=False
                ).label('is_winner'),
                # avg_val siempre Null por ahora
                literal_column("NULL").label('avg_val')
            )
            .join(Vote,      Vote.idOptionQuestion == OptionQuestion.idOptionQuestion)
            .join(VoteValue, VoteValue.idVote       == Vote.idVote)
            .join(total_subq, total_subq.c.qid      == OptionQuestion.idQuestions)
            .join(VotingQuestion,
                  VotingQuestion.idQuestion == OptionQuestion.idQuestions)
            .filter(OptionQuestion.enable == True)
            .filter(VotingQuestion.idVotingConfig == voting_config_id)
            .group_by(
                OptionQuestion.idOptionQuestion,
                OptionQuestion.idQuestions,
                total_subq.c.total
            )
        )

        # 3) Upsert en ResultsPerOption
        for opt_id, q_id, cnt, pct, is_win, avg_val in session.execute(stmt):
            source = f"{voting_config_id}|{q_id}|{opt_id}|{cnt}|{pct:.2f}|{int(is_win)}|"
            chks = hashlib.sha256(source.encode("utf-8")).digest()

            existing = session.query(ResultsPerOption).filter_by(
                idVotingConfig    = voting_config_id,
                idVotingQuestions = q_id,
                idOptionQuestion  = opt_id
            ).one_or_none()

            if existing:
                existing.votesCount      = cnt
                existing.votesPercentage = round(pct or 0, 2)
                existing.winner          = is_win
                existing.average         = None
                existing.checksum        = chks
            else:
                new_row = ResultsPerOption(
                    idVotingConfig    = voting_config_id,
                    idVotingQuestions = q_id,
                    idOptionQuestion  = opt_id,
                    votesCount        = cnt,
                    votesPercentage   = round(pct or 0, 2),
                    winner            = is_win,
                    average           = None,
                    checksum          = chks,
                    enable            = True,
                    creationDate      = func.now()
                )
                session.add(new_row)

        session.commit()
	
```
 
</details>

<details>
	<summary>Ver updateVoteCount</summary>

```python
from sqlalchemy import func
from Models.votar.models import ResultsPerOption, Vote
from database import SessionLocal

def updateVoteCount(voting_config_id: int, question_id: int, option_id: int):
    """
    Al llegar un nuevo voto para (voting_config_id, question_id, option_id):
    1) Incrementa en 1 el votesCount del registro de ResultsPerOption correspondiente.
       Si no existe, lo crea con votesCount=1.
    2) Recalcula votos totales para esa pregunta/config, porcentaje y marca al ganador.
    """
    with SessionLocal() as session:
        # 1) UPD or INS: incrementar votesCount
        rpo = (
            session.query(ResultsPerOption)
                   .filter_by(
                       idVotingConfig=voting_config_id,
                       idVotingQuestions=question_id,
                       idOptionQuestion=option_id
                   )
                   .with_for_update()
                   .first()
        )
        if rpo:
            rpo.votesCount += 1
        else:
            # crear nuevo registro
            rpo = ResultsPerOption(
                idVotingConfig     = voting_config_id,
                idVotingQuestions  = question_id,
                idOptionQuestion   = option_id,
                votesCount         = 1,
                votesPercentage    = 0,    # rellenamos más abajo
                winner             = False,
                enable             = True,
                creationDate       = func.getdate(),
                checksum           = b"",  # o calcula uno
                average            = None
            )
            session.add(rpo)
        session.flush()

        # 2) Recalcular totales para esa pregunta/config
        total_votes = (
            session.query(func.sum(ResultsPerOption.votesCount))
                   .filter_by(
                       idVotingConfig    = voting_config_id,
                       idVotingQuestions = question_id
                   )
                   .scalar()
        ) or 0

        # 3) Actualizar porcentaje y marcar ganador
        #    Asumimos único ganador: la opción con max(votesCount)
        max_votes = (
            session.query(func.max(ResultsPerOption.votesCount))
                   .filter_by(
                       idVotingConfig    = voting_config_id,
                       idVotingQuestions = question_id
                   )
                   .scalar()
        ) or 0

        # Primero, desmarca todos
        session.query(ResultsPerOption) \
               .filter_by(
                   idVotingConfig    = voting_config_id,
                   idVotingQuestions = question_id
               ).update({ResultsPerOption.winner: False})

        # Ahora recorre cada opción y fija porcentaje y ganador verdadero
        options = session.query(ResultsPerOption) \
                         .filter_by(
                             idVotingConfig    = voting_config_id,
                             idVotingQuestions = question_id
                         ).all()

        for opt in options:
            opt.votesPercentage = round((opt.votesCount / total_votes * 100) if total_votes else 0, 2)
            if opt.votesCount == max_votes and max_votes > 0:
                opt.winner = True

        session.commit()
```
</details>

<details>
	<summary>Ver get_key_name</summary>

 ```python
from database import SessionLocal
from Models.votar.models import EncryptionKey


    
def get_key_name(user_id: int) -> str | None:
    with SessionLocal() as session:
        key_entry = (
            session.query(EncryptionKey)
                   .filter(
                       EncryptionKey.userid == user_id,
                       EncryptionKey.enable == True
                   )
                   .order_by(EncryptionKey.creationDate.desc())
                   .first()
        )
    if key_entry:
        return key_entry.key
    return None
```
</details>

<details>
	<summary>Ver encrypt_with_user_key</summary>

 ```python

from sqlalchemy import text
from database import SessionLocal




def encrypt_with_user_key(user_id: int, key_name: str, password: str, texto_a_encriptar: str) -> bytes:
    with SessionLocal() as session:
        # key_name = get_key_name_for_user_orm(session, user_id)
        if not key_name:
            raise Exception(f"No se encontró llave activa para user_id {user_id}")
        try:
            # 1) Abrir la llave con la contraseña *inline*
            sql_open = f"OPEN SYMMETRIC KEY [{key_name}] DECRYPTION BY PASSWORD = '{password}'"
            session.execute(text(sql_open))
        except:
            raise Exception(f"No se logro abrir la llave con la contraseña {password}")


        # 2) Encriptar
        row = session.execute(
            text(f"SELECT ENCRYPTBYKEY(KEY_GUID('{key_name}'), :texto) AS Encrypted"),
            {"texto": texto_a_encriptar}
        ).fetchone()
        encrypted_bytes = row.Encrypted

        # 3) Cerrar llave
        session.execute(text(f"CLOSE SYMMETRIC KEY [{key_name}]"))

        return encrypted_bytes
```
</details>

<details>
	<summary>Ver JSONs de ejemplo</summary>

```json

{
    "auth": {
        "cedula": 326102758, // 1: 326102758 2: 541101101 3: 282869978 4: 205332829 5: 367692370
        "password": "Superclave@1", // 1: Superclave@1 2: Superclave@2 3: Superclave@3 4: Superclave@4 5: Superclave@5
        "mfa": {
            "method": "totp",
            "code": "482915"
        }
    },
    "proposalName": "Plan nacional de conectividad digital para zonas indígenas",
    "proposalVersionName": "Versión piloto conectividad 2025 - V2",
    "date": "2025-07-05 22:35:32.000",
    "votos": [
        {
            "question": "¿Está de acuerdo con la implementación del proyecto?",
            "voto": "No"
        },

        {
            "question": "¿Qué beneficios espera del acceso a internet?",
            "voto": "Telemedicina"
        },

        {
            "question": "Califique la importancia del proyecto (1-5)",
            "voto": "Moderado"
        },

        {
            "question": "¿Considera que es una prioridad para su comunidad?",
            "voto": "Sí"
        },

        {
            "question": "¿Qué grupos deberían ser capacitados primero?",
            "voto": "Líderes comunales"
        }
    ]
}




{
    "auth": {
        "cedula": 326102758, // 1: 326102758 2: 541101101 3: 282869978 4: 205332829 5: 367692370
        "password": "Superclave@1", // 1: Superclave@1 2: Superclave@2 3: Superclave@3 4: Superclave@4 5: Superclave@5
        "mfa": {
            "method": "totp",
            "code": "482915"
        }
    },
    "proposalName": "Programa estratégico de gestión de residuos en zonas rurales",
    "proposalVersionName": "Gestión Comunitaria de Residuos - Versión 2",
    "date": "2025-06-11 22:35:32.000",
    "votos": [
        {
            "question": "¿Esta de acuerdo con la implementacion?",
            "voto": "Si"
        },

        {
            "question": "¿Que elementos deberian incluirse?",
            "voto": "A"
        },

        {
            "question": "Califique la viabilidad del proyecto (1-5)",
            "voto": "1"
        },

        {
            "question": "¿Cree que se necesita mas analisis?",
            "voto": "Si"
        },

        {
            "question": "¿Que actores deben involucrarse?",
            "voto": "Gobierno"
        }
    ]
}

```
</details>

</details>
	
### Listar Votos

<details>

  <summary>Desplegar información</summary>

Este endpoint permite obtener los **últimos 5 votos** emitidos por un usuario, a partir de su número de identificación (cédula, pasaporte o licencia). La función garantiza la seguridad mediante **desencriptado simétrico**, validación de identidad y verificación de múltiples condiciones antes de recuperar los datos.

Flujo general de la función:

1. Se recibe el número de identificación `id_card` en el cuerpo del POST.
2. Se abre la llave simétrica `llavecedula` para desencriptar datos sensibles.
3. Se valida que el usuario:
   - Exista y esté habilitado (`vpv_users`).
   - Tenga habilitada la autenticación MFA (`vpv_mfa`).
   - Tenga un documento de identidad verificado (`vpv_identitydocs`).
   - Esté registrado como votante (`vpv_voter`).
4. Se consultan los últimos 5 votos de ese usuario (`vpv_votes`) y se desencripta el contenido de la opción seleccionada (`vpv_optionsQuestion`).
5. Finalmente, se retorna una lista con el título de la propuesta, la fecha y la decisión tomada.

<details>
  <summary>Ver código del lado de API</summary>

```python
# Este script implementa un endpoint HTTP en Azure Functions llamado `ListarVotos`.
# Su objetivo es autenticar al usuario mediante su cédula, validar su MFA y documentos,
# y luego retornar sus 5 votos más recientes, incluyendo la propuesta votada, la fecha y la opción elegida.

# ————————————————————————————————
# 1. IMPORTACIÓN DE DEPENDENCIAS
# ————————————————————————————————

# Funciones HTTP de Azure
import azure.functions as func
# Manejo de JSON para entrada/salida de datos
import json
# Registro de logs para depuración
import logging
# Funciones SQL textuales para ejecución directa
from sqlalchemy import text
# Objeto de sesión para conectar con la base de datos
from database import SessionLocal
# Variables de entorno (clave de desencriptación)
import os

# Modelos ORM que representan las tablas de la base de datos
from Models.users import VpvUser
from Models.ListarVotos.vpv_mfa import VpvMfa
from Models.ListarVotos.vpv_identitydocs import VpvIdentityDoc
from Models.ListarVotos.vpv_Voter import VpvVoter
from Models.ListarVotos.vpv_Votes import VpvVotes
from Models.ListarVotos.vpv_optionsQuestion import VpvOptionsQuestion
from Models.Configuracion_Votacion.votingConfing import VotingConfiguration
from Models.Configuracion_Votacion.proposalVersion import VpvProposalVersions

# Se extrae del entorno la clave que permite abrir la llave simétrica para desencriptar la cédula
clave = os.getenv("CLAVECEDULA")


# —————————————————————————————————————————
# 2. FUNCIÓN PRINCIPAL - ListarVotos
# —————————————————————————————————————————
def ListarVotos(req: func.HttpRequest) -> func.HttpResponse:
    # Log inicial para depuración
    logging.info("ListarVotos iniciado...")

    # Verifica que el método HTTP sea POST (único permitido)
    if req.method != "POST":
        return func.HttpResponse("Método no permitido. Use POST.", status_code=405)

    # Se inicia la sesión de base de datos (equivalente a una conexión)
    session = SessionLocal()
    try:
        #vSe intenta obtener el cuerpo de la solicitud (esperado en JSON)
        body = req.get_json()
        id_card = body.get("id_card")

        # Validación obligatoria: debe incluirse la cédula
        if not id_card:
            return func.HttpResponse("Falta id_card en el cuerpo de la petición.", status_code=400)

        # ——————————————————————————————————————————————
        # 3. DESENCRIPTAR LA CÉDULA Y BUSCAR AL USUARIO
        # ——————————————————————————————————————————————

        # TABLAS INVOLUCRADAS:
        # vpv_Users: Tabla de los usuarios, aquí en este caso para encontrar el usuario utilizamos la cédula
        # esta cédula está encriptada, la desencriptamos con "llavecedula" cuya clave es "clavecedula"

        # Abrir la llave simétrica con la contraseña proporcionada en entorno
        sql = f"OPEN SYMMETRIC KEY llavecedula DECRYPTION BY PASSWORD = '{clave}'"
        session.execute(text(sql))

        # Ejecutar consulta para buscar usuario activo cuya cédula (encriptada) coincida con la proporcionada
        result = session.execute(text("""
            SELECT idUser
            FROM vpv_Users
            WHERE enable = 1
              AND CONVERT(nvarchar(50), DECRYPTBYKEY(id_card)) = :idCard
        """), {"idCard": id_card})
        row = result.fetchone()

        # Cierra inmediatamente la llave tras su uso (buena práctica de seguridad)
        session.execute(text("CLOSE SYMMETRIC KEY llavecedula;"))

        # Si no se encontró el usuario, se notifica al cliente
        if not row:
            return func.HttpResponse(
                f"No existe usuario activo con cédula {id_card}.", status_code=404
            )
        # Se guarda el ID del usuario identificado
        idUsuario = row[0]

        # ——————————————————————————————————————————————
        # 4. VERIFICAR QUE EL USUARIO TENGA MFA HABILITADO
        # ——————————————————————————————————————————————

        # TABLAS INVOLUCRADAS:
        # vpv_mfa: Son datos biómetricos o formas de autenticación, en este caso para validar la identidad
        # del usuario verificamos que tenga al menos un MFA activado

        mfa = session.query(VpvMfa).filter_by(userid=idUsuario).first()
        if not mfa or not mfa.enable:
            return func.HttpResponse("MFA no habilitado para este usuario.", status_code=403)

        # ——————————————————————————————————————————————————————
        # 5. VERIFICAR QUE TENGA UN DOCUMENTO DE IDENTIDAD VÁLIDO
        # ——————————————————————————————————————————————————————

        # TABLAS INVOLUCRADAS:
        # vpv_identitydocs: Tabla que guarda identificaciones, NO ARCHIVOS, sino categorías, en este caso busca que
        # el usuario tenga al menos una cédula, pasaporte o licencia que verifique su identidad y esté habilitada.
        # vpv_identitystates: Tabla que indica el estado de una licencia, cédula o pasaporte, 1 = Aprobado

        doc = (
            session.query(VpvIdentityDoc)
            .filter_by(
                referenceid="idUser",
                referencevalue=idUsuario,
                enable=True,
                identitystateid=1  # Solo documentos verificados
            )
            .filter(VpvIdentityDoc.name.in_([
                "Cédula de identidad", "Pasaporte", "Licencia de conducir"
            ]))
            .first()
        )

        # Si no tiene documento verificado, se rechaza el acceso
        if not doc:
            return func.HttpResponse(
                "Usuario no tiene documento verificado (cédula/pasaporte/licencia).",
                status_code=403
            )

        # ——————————————————————————————————————————————
        # 6. BUSCAR EL REGISTRO DE VOTANTE ASOCIADO AL USUARIO
        # ——————————————————————————————————————————————

        # TABLAS INVOLUCRADAS:
        # vpv_voter: Tablar que relacionado los votos con el usuario, la utilizamos para llegar de vpv_Users a vpv_Votes.
        # En este caso guardamos en idVotador el id que nos sirve para relacionar vpv_Votes

        voter = session.query(VpvVoter).filter_by(idUser=idUsuario).first()
        if not voter:
            return func.HttpResponse("Usuario no registrado como votante.", status_code=404)

        # Guardar el ID del votante para futuras consultas
        idVotador = voter.idVoter

        # ——————————————————————————————————————————————————
        # 7. CONSULTAR LOS ÚLTIMOS 5 VOTOS DEL USUARIO
        # ——————————————————————————————————————————————————

        # TABLAS INVOLUCRADAS:
        # vpv_Votes: Esta tabla guarda la información respecto a las votaciones de un usuario, la utilizamos para 
        # llegar a vpv_votingConfigurations y a vpv_OptinosQuestions

        votos = (
            session.query(VpvVotes)
            .filter_by(idVoter=idVotador)
            .order_by(VpvVotes.creationDate.desc())  # Orden más reciente primero
            .limit(5)
            .all()
        )

        resultado = []  # Lista que almacenará los votos a devolver

        # ——————————————————————————————————————————————————————
        # 8. RECORRER CADA VOTO Y OBTENER INFORMACIÓN DETALLADA
        # ——————————————————————————————————————————————————————

        # TABLAS INVOLUCRADAS:
        # vpv_VotingConfiguration: Guarda la configuración de la votación y permite llega a vpv_ProposalVersions
        # vpv_ProposalVersions: Esta tabla guarda versiones de la propuesta, en este caso la utilizamos para
        # saber a que propuesta voto el usuario.
        # vpv_OptionsQuestions: Guarda las respuestas de las votaciones, la utilizamos para ver lo que voto el usuario.

        for v in votos:
            # Traer configuración de votación para ese voto
            config = session.query(VotingConfiguration).get(v.idVotingConfig)
            # Traer la propuesta asociada a esa configuración
            propuesta = session.query(VpvProposalVersions).get(config.proposalVersionId)
            # Traer la opción que el usuario eligió en esa votación
            opcion = session.query(VpvOptionsQuestion.value).filter_by(idOptionQuestion=v.idOptionQuestion).first()

            # Agregar datos al resultado final (nombre de propuesta, fecha, decisión)
            resultado.append({
                "propuesta": propuesta.tittle if propuesta else None,
                "fecha": v.creationDate.isoformat() if v.creationDate else None,
                "decision": opcion[0] if opcion else None
            })

        # Devolver la lista de votos en formato JSON al cliente
        return func.HttpResponse(
            json.dumps(resultado),
            status_code=200,
            headers={"Content-Type": "application/json"}
        )

    # ————————————————————————————————
    # 9. MANEJO DE ERRORES INTERNOS
    # ————————————————————————————————
    except Exception as e:
        # Registrar el error en el log y deshacer cualquier cambio en la base de datos
        logging.exception("Error interno")
        session.rollback()
        return func.HttpResponse("Error interno del servidor.", status_code=500)

    # ————————————————————————————————
    # 10. CIERRE DE SESIÓN DE BASE DE DATOS
    # ————————————————————————————————
    finally:
        session.close()  # Cierra la conexión con la base de datos
```

</details>

</details> 

<details>

<summary>JSON</summary>

```json
{
  "id_card": "239675389"
}
```
</details> 

### Configurar Votacion
<details>
  <summary>Ver Informacion</summary>
Este endpoint permite configurar todos los parámetros necesarios para realizar una votación sobre una propuesta específica. Su implementación se realiza utilizando el ORM **SQLAlchemy**, facilitando la manipulación de entidades y relaciones en la base de datos mediante clases Python.

#### Funcionalidad principal

El proceso inicia validando los permisos del usuario que desea realizar la configuración. Posteriormente, se definen filtros que delimitan la población meta, incluyendo criterios como edad, género, nacionalidad, ubicación geográfica, y pertenencia institucional. Se configura también la zona de impacto de la propuesta (nacional, regional, municipal), y se especifican las fechas de inicio y cierre del proceso de votación.

Se permite establecer la lista de votantes, ya sea de forma directa o mediante segmentación automática. Además, pueden definirse restricciones adicionales como rangos de IP, horarios específicos o turnos.

El tipo de votación (por ejemplo, única, múltiple, calificación) también es configurable, junto con las preguntas y respuestas asociadas a la propuesta. Toda esta configuración se guarda en estado “preparado”, y solo podrá ser modificada antes del inicio oficial del periodo de votación.

#### Herramientas utilizadas

- **Python** con **SQLAlchemy** como ORM.
- **Azure Functions** para ejecutar localmente bajo el enfoque serverless.
- **SQL Server** como base de datos.
- **Thunder Client** o **Postman** para pruebas de los endpoints.
<details>
  <summary>Ver Funcion ORM</summary>
	
```sql

import azure.functions as func
import logging
import json
from database import SessionLocal
from sqlalchemy import text #utilizada para enviar texto a la sesion
import os #utilizado para variables de entorno
from dotenv import load_dotenv


# Carga las variables del .env
load_dotenv()
#variables de entorno
clave = os.getenv("CLAVECEDULA")

#Importacion de las tablas involucradas en el proceso
from Models.users import VpvUser
from Models.Configuracion_Votacion.allowedVoters import AllowedVoter
from Models.Configuracion_Votacion.clousureType import VpvClosureTypes
from Models.Configuracion_Votacion.executionPlan import VpvExecutionPlans
from Models.Configuracion_Votacion.governmentConditions import VpvGovernmentConditions
from Models.Configuracion_Votacion.impactZonesPerVoting import ImpactZonesPerVoting
from Models.Configuracion_Votacion.metricPlan import VpvMetricPerPlan
from Models.Configuracion_Votacion.projectReport import VpvProjectReports
from Models.Configuracion_Votacion.proposalVersion import VpvProposalVersions
from Models.Configuracion_Votacion.reminderType import ReminderType
from Models.Configuracion_Votacion.sponsor import SponsorAgreement
from Models.Configuracion_Votacion.statusVoting import StatusVoting
from Models.Configuracion_Votacion.targetPopulations import TargetPopulationsVoting
from Models.Configuracion_Votacion.votingConfing import VotingConfiguration
from Models.Configuracion_Votacion.votingQuestions import VpvVotingQuestions
from Models.Configuracion_Votacion.votingReasons import VpvVotingReasons
from Models.Configuracion_Votacion.votingRestrictions import VotingPerRestriction
from Models.Configuracion_Votacion.votingRules import VotingRule
from Models.Configuracion_Votacion.votingType import VotingType
from Models.Configuracion_Votacion.targetPopulationsVpv import VpvTargetPopulations
from Models.Configuracion_Votacion.impactZones import ImpactZones
from Models.Configuracion_Votacion.questions import VpvQuestions
from Models.Configuracion_Votacion.rules import Rule
from Models.Configuracion_Votacion.restrictions import VotingRestriction
from Endpoints_ORM.encrypt_checksum import encrypt_checksum
from Endpoints_ORM.validarPermisos import validar_permiso

'''
    Configurar votacion: Se encarga de configurar los parametros de una votacion para una propuesta especifica.
    En terminos de este sistema se configura hacia una version de la poblacion
    Parámetros del cuerpo de la solicitud (req_body) de formato JSON:
    - proposalVersion: Nombre de la propuesta a votar(El formato obligatorio es 2025-06-16T12:00:00Z).
    - openDate: Fecha y hora de apertura de la votación.
    - closeDate: Fecha y hora de cierre de la votación.
    - creationDate: Fecha en que se crea la configuración de votación.
    - VotingType: Tipo de votación (por ejemplo, "Unica").
    - description: Descripción general de la votación.
    - weight: Indica si la votación tendrá ponderación (0 o 1)Boleano.
    - ReminderType: Tipo de recordatorio a utilizar (ej. Email, Notificación).
    - ClosureTypes: Define cómo se cierra la votación (ej. "hasta que los votantes terminen").
    - VotingReasons: Justificación o motivo de la votación.

    Listas asociadas:
    - targetPopulations:
        - name: Nombre del grupo poblacional.
        - weight: Valor de ponderación asignado.
    - impactZones:
        - name: Nombre de la zona.
    - questions:
        - name: Texto de la pregunta.
        - orderBy: Orden de aparición en la boleta.
    - rules:
        - name: Nombre o título de la regla.
    - restrictions:
        - name: Descripción de la restricción.
'''

def configurarVotacionORM(req: func.HttpRequest) -> func.HttpResponse:
    logging.info('Procesando la configuracion de la votacion...')

    #VALIDO QUE EL METODO SEA POST DE LO CONTRARIO, ESTE REQUEST NO SERA PROCESADO
    if req.method != "POST":
        return func.HttpResponse(
            "Metodo no permitido. Utilice otro metodo",
            status_code=405
        )

    #Obtengo el json que se encuentra en el body
    try:
        session = SessionLocal()
        req_body = req.get_json()
        idcard = req_body.get("idCard")
        #Validacion del usuario, en este caso debe ser un proponente encargado de la configuracion y creacion de propuestas
        try:
            validar_permiso(session, idcard, 'Proponente')
        except PermissionError as e:
            return func.HttpResponse(
                json.dumps({"error": str(e)}),
                status_code=403,
                mimetype="application/json"
            )

        #Realiza la insercio de los datos que corresponden a la configuracion general de la votacion, sin contar las listas recibidas
        objInsertado = InsertVotingConfing(req_body, session)
        #Se obtiene el objeto insertado esto con la finalidad de obtener el id asi como datos importantes del mismo

        #Valida si la configuracion fue exitosa
        if not objInsertado:
            return func.HttpResponse("No se insertó la configuración de forma exitosa", status_code=500)

        #------------------Comienzo de insercion de las listas recibidas----------------------------

        #obtencion de la coleccion de segmentos de la poblacion
        target_populations = req_body.get("targetPopulations")
        if not target_populations or not isinstance(target_populations, list):#validacion de la existencia de datos
            return func.HttpResponse("Segmentos poblacionales inválidos o faltantes", status_code=400)
        #Valida la insercion exitosa
        if not InsertTargetPopulations(target_populations, objInsertado.idVotingConfig,session,objInsertado.weight):#Insercion de los segmentos de poblacion
            return func.HttpResponse("No se insertaron de forma correcta los segmentos poblacionales", status_code=500)
        
        #obtencion de la coleccion de las zonas de impacto
        impact_zones = req_body.get("impactZones")
        if not impact_zones or not isinstance(impact_zones, list):#validacion de la existencia de datos
            return func.HttpResponse("Zonas de impactos inválidas o faltantes", status_code=400)

        if not InsertImpactZones(impact_zones, objInsertado.idVotingConfig,session):
            return func.HttpResponse("No se insertaron de forma correcta las zonas de impacto", status_code=500)#Insercion de las zonas de impacto
        
        #obtencion de la coleccion de preguntas correspondientes a la configuracion
        questions = req_body.get("questions")
        if not questions or not isinstance(questions, list):
            return func.HttpResponse("Preguntas inválidas o faltantes", status_code=400)

        if not InsertQuestions(questions, objInsertado.idVotingConfig,session): #realiza y valida el resultado de la insercion a la base de datos
            return func.HttpResponse("No se insertaron de forma correcta las preguntas", status_code=500)
        
        #Obtencion de la coleccion de reglas definidas en la configuracion
        rules = req_body.get("rules")
        if not rules or not isinstance(rules, list): #validaciond e la existencia de datos
            return func.HttpResponse("Reglas inválidas o faltantes", status_code=400)

        #Intento de insercion y evaluacion del mismo en la base, se envia la lista!
        if not InsertRules(rules, objInsertado.idVotingConfig,session):
            return func.HttpResponse("No se insertaron de forma correcta las reglas", status_code=500)
        
        #Obtencion de la coleccion de restricciones definidas en la configuracion
        restrictions = req_body.get("restrictions")
        if not restrictions or not isinstance(restrictions, list):
            return func.HttpResponse("restricciones inválidas o faltantes", status_code=400)

        if not InsertRestrictions(restrictions, objInsertado.idVotingConfig,session):
            return func.HttpResponse("No se insertaron de forma correcta las restricciones", status_code=500)
        
        #Obtencion de la coleccion de votantes directos definidas en la configuracion
        votantes = req_body.get("allowedVoters")
        if not votantes or not isinstance(votantes, list):
            return func.HttpResponse("Votantes inválidas o faltantes", status_code=400)

        if not InsertAllowedVoters(votantes, objInsertado.idVotingConfig,session):
            return func.HttpResponse("No se insertaron de forma correcta los votantens directos", status_code=500)

        #Con la finalidad de hacer transacciones atomicas, se realiza el commit de la session creada hasta el final de la operacion es decir que haya pasado todas las validaciones
        session.commit()
        return func.HttpResponse("Configuración de votación insertada correctamente", status_code=201)
    #control de excepciones extras asi como rollback en la transaccion principal
    except ValueError as e:
        session.rollback()
        return func.HttpResponse(
            str(e),
            status_code=200
        )

"""
Insercion de los segmentos poblacionales, lee los nombres recibidos y identifica el id de los mismos para relacionarlo con la configuracion creadas
Entradas:   Lista de los segmentos poblacionales
            Id de la votacion insertada
            Validacion si la votacion es pesada de no ser asi no se coloca un peso
            session creada para la transaccion
"""
def InsertTargetPopulations(targetPopulations, idVotingConfig,session,weightBoolean):
    #recorro los target brindados por el usuario para ir encontrando su id y por ultimo insertarlos
    for target in targetPopulations:
        #validaciones inciales de los target ingresados
        name = target.get("name")

        #Valido si la votacion esta medida por pesos
        if weightBoolean:
            weight = target.get("weight")
        else:
            weight = None;
        
        #Valido los campos recibidos
        if not name:
            return func.HttpResponse("Cada segmento poblacional debe tener un nombre", status_code=400)
        
        if weight is not None and not isinstance(weight, (float, int)):
            return func.HttpResponse("Weight debe ser numérico o null", status_code=400)
        
        #busqueda del valor del id relacionado al name recibido
        #Target Population--------------------------------
        
        # Obtengo el objeto identificado
        targetId = session.query(VpvTargetPopulations.idTargetPopulation).filter_by(name=name, enable=True).first()

        if not targetId:
            raise ValueError(f"No se encontró el estado del target ingresado: {name}")
        
        
        #Insert el target en la tabla
        targetPopulation=TargetPopulationsVoting(
            idVotingConfig=idVotingConfig,
            idTargetPopulation=targetId[0],
            enable=True,
            weight = weight
        )

        #Calculo del checksum, envio en forma de lista los datos que quiero que sean encriptados
        datos_a_checksum = (targetPopulation.idTargetPopulation, targetPopulation.idVotingConfig, targetPopulation.weight)
        #genero el checksum por medio de la llamada del metodo
        checksum = encrypt_checksum(*datos_a_checksum)
        #Actualiza el checksum del registro a insertar
        targetPopulation.checksum = checksum;
        #realizo la insercion a la base de datos, pero no realizo commit por que no es la transaccion principal
        session.add(targetPopulation)
        

    return True

"""
Insercion de los zonas de impacto, lee los nombres recibidos y identifica el id de los mismos para relacionarlo con la configuracion creadas
Entradas:   Lista de las zonas de impacto
            Id de la votacion insertada
            session creada para la transaccion
"""
def InsertImpactZones(impactZones, idVotingConfig,session):
    #recorro las zonas brindados por el usuario para ir encontrando su id y por ultimo insertarlos
    for zone in impactZones:
        #validaciones inciales del nombre de la zona
        name = zone.get("name")

        #Valido los campos recibidos
        if not name:
            return func.HttpResponse("Cada zona de impacto debe tener un nombre", status_code=400)
        
        
        #busqueda del valor del id relacionado al name recibido
        #Impact Zone--------------------------------
        
        # Obtengo el objeto identificado
        zoneId = session.query(ImpactZones.idImpactZone).filter_by(name=name, enable=True).first()

        if not zoneId:
            raise ValueError(f"No se encontró el nombre de la zona ingresado: {name}")
        print(f"idVotingConfig = {idVotingConfig!r}")
        #Insert de la zona de impacto en la tabla
        impactZonesObj=ImpactZonesPerVoting(
            idVotingConfig=idVotingConfig,
            idImpactZones=zoneId[0],
            enable=True
        )

        #Calculo del checksum
        datos_a_checksum = (impactZonesObj.idImpactZones, impactZonesObj.idVotingConfig)
        #genero el checksum por medio de la llamada del metod
        checksum = encrypt_checksum(*datos_a_checksum)

        impactZonesObj.checksum = checksum;
        #realizo la insercion a la base de datos, pero no realizo commit por que no es la transaccion principal
        session.add(impactZonesObj)
        

    return True

"""
Insercion de las preguntas, lee los nombres recibidos y identifica el id de los mismos para relacionarlo con la configuracion creadas
Entradas:   Lista de las preguntas
            Id de la votacion insertada
            session creada para la transaccion
"""
def InsertQuestions(questions, idVotingConfig,session):
    #recorro las zonas brindados por el usuario para ir encontrando su id y por ultimo insertarlos
    for question in questions:
        #validaciones inciales del nombre de la zona
        name = question.get("name")
        orderBy = question.get("orderBy")

        #Valido los campos recibidos
        if not name:
            return func.HttpResponse("Cada pregunta debe tener nombre", status_code=400)
        if not orderBy:
            return func.HttpResponse("Cada pregunta debe tener un orden", status_code=400)
        
        #busqueda del valor del id relacionado al name recibido
        #Questions--------------------------------
        
        # Obtengo el objeto identificado
        questionId = session.query(VpvQuestions.idQuestion).filter_by(description=name).first()

        if not questionId:
            raise ValueError(f"No se encontró una pregunta con la descripcion: {name}")
        
        #Insert de la pregunta
        preguntaObj=VpvVotingQuestions(
            idQuestion=questionId[0],
            idVotingConfig=idVotingConfig,
            enable=True,
            orderBy=orderBy
        )
       
        #Calculo del checksum
        datos_a_checksum = (preguntaObj.idQuestion, preguntaObj.idVotingConfig,preguntaObj.creationDate,preguntaObj.orderBy)

        checksum = encrypt_checksum(*datos_a_checksum)

        preguntaObj.checksum = checksum;

        session.add(preguntaObj)
        
    return True

"""
Insercion de las reglas, lee los nombres recibidos y identifica el id de los mismos para relacionarlo con la configuracion creadas
Entradas:   Lista de las reglas
            Id de la votacion insertada
            session creada para la transaccion
"""
def InsertRules(rules, idVotingConfig,session):
    #recorro las zonas brindados por el usuario para ir encontrando su id y por ultimo insertarlos
    for rule in rules:
        #validaciones inciales del nombre de la zona
        name = rule.get("name")

        #Valido los campos recibidos
        if not name:
            return func.HttpResponse("Cada regla debe tener un nombre", status_code=400)
        
        
        #busqueda del valor del id relacionado al name recibido
        #Rules--------------------------------
        
        # Obtengo el objeto identificado
        ruleId = session.query(Rule.idRule).filter_by(name=name, enable=True).first()

        if not ruleId:
            raise ValueError(f"No se encontró el nombre de la regla ingresado: {name}")
        
        #Insert de la zona de impacto en la tabla
        ruleObj=VotingRule(
            idVotingConfig=idVotingConfig,
            idRule=ruleId[0]
        )

        #Calculo del checksum
        datos_a_checksum = (ruleObj.idRule, ruleObj.idVotingConfig)

        checksum = encrypt_checksum(*datos_a_checksum)

        ruleObj.checksum = checksum;
       
        session.add(ruleObj)
        

    return True


"""
Insercion de las restricciones, lee los nombres recibidos y identifica el id de los mismos para relacionarlo con la configuracion creadas
Entradas:   Lista de las restricciones
            Id de la votacion insertada
            session creada para la transaccion
"""
def InsertRestrictions(restrictions, idVotingConfig,session):
    #recorro las zonas brindados por el usuario para ir encontrando su id y por ultimo insertarlos
    for restriction in restrictions:
        #validaciones inciales del nombre de la zona
        name = restriction.get("name")

        #Valido los campos recibidos
        if not name:
            return func.HttpResponse("Cada restriction debe tener un nombre", status_code=400)
        
        
        #busqueda del valor del id relacionado al name recibido
        #restrictions--------------------------------
        
        # Obtengo el objeto identificado
        restrictionId = session.query(VotingRestriction.idRestrictions).filter_by(description=name, enable=True).first()

        if not restrictionId:
            raise ValueError(f"No se encontró el nombre de la restriccion ingresado: {name}")
        
        #Insert de la zona de impacto en la tabla
        resObj=VotingPerRestriction(
            idVotingConfig=idVotingConfig,
            idRestrictions=restrictionId[0],
            enable=True
        )

        #Calculo del checksum
        datos_a_checksum = (resObj.idVotingConfig, resObj.idRestrictions, resObj.enable)

        checksum = encrypt_checksum(*datos_a_checksum)

        resObj.checksum = checksum;
       
        session.add(resObj)
        

    return True

"""
EN CONSTRUCCION
Insercion de los votantes directos, lee los nombres recibidos y identifica el id de los mismos para relacionarlo con la configuracion creadas
Entradas:   Lista de lOS votantes directo
            Id de la votacion insertada
            session creada para la transaccion
"""
def InsertAllowedVoters(voters, idVotingConfig,session):
    #abro la llave para desencriptar las cedulas
    sql = f"OPEN SYMMETRIC KEY llavecedula DECRYPTION BY PASSWORD = '{clave}'"
    session.execute(text(sql))

    for voter in voters:
        #validaciones inciales del nombre de la zona
        idCard = voter.get("idCard")

        #Valido los campos recibidos
        if not idCard:
            return func.HttpResponse("Cada votante debe tener un idcard", status_code=400)
        
        
        #busqueda del valor del id relacionado al name recibido
        #votantes--------------------------------
        
        # Obtengo el objeto identificado
        result = session.execute(text("""
            SELECT idUser
            FROM vpv_Users
            WHERE enable = 1
            AND CONVERT(nvarchar(50), DECRYPTBYKEY(id_card)) = :idCard
        """), {'idCard': idCard})

        # Obtener el primer resultado
        row = result.fetchone()
        userId = row[0] if row else None

        
        if not userId:
            raise ValueError(f"No se encontró el usuarios ingresado: {idCard}, o el mismo no esta activo")
        
        #Obtencion del blind token

        #Insert de los usuarios en la tabla
        userObj=AllowedVoter(
            idVotingConfig=idVotingConfig,
            idBlindToken=userId,
            enable=True
        )

        #Calculo del checksum
        datos_a_checksum = (userObj.idVotingConfig, userObj.idBlindToken, userObj.enable,userObj.creationDate)

        checksum = encrypt_checksum(*datos_a_checksum)

        userObj.checksum = checksum;
       
        session.add(userObj)
    # Cerrar la llave
    session.execute(text("CLOSE SYMMETRIC KEY llavecedula;"))    
        

    return True


"""
Insercion de los datos generales de la votacion de la configuracion, obtiene los datos necesarios que fueron recibidos por el json, ademas, al recibir el nombre debe encontrar el id de las FK's que forman parte del registro
Entradas:   entrada tipo json con los datos recidos para obtener los necesarios
            session creada para la transaccion
"""
def InsertVotingConfing(req_body, session):

    #Obtengo los ID de las llaves foraneas utilizadas
    #Proposal Version------------------------------
    proposalName = req_body.get("proposalVersion")

    # Obtengo el objeto identificado
    proposalId = session.query(VpvProposalVersions.proposalVersionId).filter_by(tittle=proposalName, enable=True).first()

    if not proposalId:
        raise ValueError(f"No se encontró la version de propuesta con nombre: {proposalName}")
    
    #Status de votacion--------------------------------
    statusName = "Preparado"

    # Obtengo el objeto identificado
    statusId = session.query(StatusVoting.idStatusVoting).filter_by(name=statusName, enable=True).first()

    if not statusId:
        raise ValueError(f"No se encontró el estado de la propuesta con nombre: {statusName}")

    #Tipo de votacion-------------------------------
    voting_type_name = req_body.get("VotingType")

    # Obtengo el objeto identificado
    voting_type_id = session.query(VotingType.idVotingType).filter_by(name=voting_type_name, enable=True).first()

    if not voting_type_id:
        raise ValueError(f"No se encontró el tipo de votación con nombre: {voting_type_name}")
    
    #Reminder Type------------------------------
    reminderName = req_body.get("ReminderType")

    # Obtengo el objeto identificado
    reminderId = session.query(ReminderType.idReminderType).filter_by(name=reminderName, enable=True).first()

    if not reminderId:
        raise ValueError(f"No se encontró el tipo de recordatorio con nombre: {reminderName}")
    
    #Reminder Type------------------------------
    ClosureName = req_body.get("ClosureTypes")

    # Obtengo el objeto identificado
    closureId = session.query(VpvClosureTypes.idClosureTypes).filter_by(name=ClosureName, enable=True).first()

    if not closureId:
        raise ValueError(f"No se encontró el tipo de cierre con nombre: {ClosureName}")
    
    #Voting Reasons------------------------------
    reasonName = req_body.get("VotingReasons")

    # Obtengo el objeto identificado
    reasonId = session.query(VpvVotingReasons.idvotingReasons).filter_by(name=reasonName, enable=True).first()

    if not reasonId:
        raise ValueError(f"No se encontró el tipo de razon con nombre: {reasonName}")
    

    #Campos opcionales dentro dentro del tipo de razon segun la propuesta------------------------------------------
    #crea las variables y las inicializa como none para que a la hora de insertar en caso de no recibir un datos de ellos no haya problema al momento de buscar el id
    execution_plan_id = None
    if req_body.get("executionPlan"): #en caso de haber una entrada, se busca el id que corresponda al nombre en la tabla especifica y se alamcena en la variable previamente inicializada
        execution_plan_id = session.query(VpvExecutionPlans.executionPlanId).filter_by(tittle=req_body["executionPlan"]).first()
        #en caso de no haber un resultado correspondiente esto se indica
        if not execution_plan_id:
            raise ValueError(f"No se encontró el plan de ejecucion")

    metric_plan_id = None
    if req_body.get("metricPlan"):
        objId = session.query(VpvMetricPerPlan.metricPlanId).filter_by(name=req_body["metricPlan"]).first()
        if not objId:
            raise ValueError(f"No se encontró la metrica de plan")

    project_report_id = None
    if req_body.get("projectReport"):
        objId = session.query(VpvProjectReports.projectReportId).filter_by(tittle=req_body["projectReport"]).first()
        if not objId:
            raise ValueError(f"No se encontró el reporte")

    sponsor_id = None
    if req_body.get("sponsor"):
        objId = session.query(SponsorAgreement.sponsorAgreementId).filter_by(name=req_body["sponsor"]).first()
        if not objId:
            raise ValueError(f"No se encontró el sponsor")

    government_conditions_id = None
    if req_body.get("governmentConditions"):
        objId = session.query(VpvGovernmentConditions.governmentConditionId).filter_by(name=req_body["governmentConditions"]).first()
        if not objId:
            raise ValueError(f"No se encontró el sponsor")
    #Fin de los casos opcionales ---------------------------------------------------------------------------------------------------------


    #crea el objeto de la nueva configuracion de los datos de votacion asignando las variables
    nueva_config = VotingConfiguration(
        proposalVersionId=proposalId[0], #al ser una consulta se indica el comando first, no obstante me devuelve una lista es por ello que se debe indicar el elemento 0
        openDate=req_body.get("openDate"),
        closeDate=req_body.get("closeDate"),
        idStatusVoting=statusId[0],
        idVotingType=voting_type_id[0],
        description=req_body.get("description", "Sin descripción"),
        weight=req_body.get("weight", False),
        checksum=req_body.get("checksum"),
        idReminderType=reminderId[0],
        idClosureTypes=closureId[0],
        idvotingReasons=reasonId[0],
        executionPlanId = execution_plan_id[0] if execution_plan_id else None, #Validacion de la existencia de las variables opcionales
        metricPlanId = metric_plan_id[0] if metric_plan_id else None,
        projectReportId = project_report_id[0] if project_report_id else None,
        sponsorAgreementId = sponsor_id[0] if sponsor_id else None,
        governmentConditionId = government_conditions_id[0] if government_conditions_id else None
    )

    #calculo del checksum
    datos_a_checksum = (
        nueva_config.proposalVersionId,
        nueva_config.openDate,
        nueva_config.closeDate,
        nueva_config.idStatusVoting,
        nueva_config.idVotingType,
        nueva_config.description,
        nueva_config.weight,
        nueva_config.idReminderType,
        nueva_config.idClosureTypes,
        nueva_config.idvotingReasons,
        nueva_config.executionPlanId if nueva_config.executionPlanId is not None else "",
        nueva_config.metricPlanId if nueva_config.metricPlanId is not None else "",
        nueva_config.projectReportId if nueva_config.projectReportId is not None else "",
        nueva_config.sponsorAgreementId if nueva_config.sponsorAgreementId is not None else "",
        nueva_config.governmentConditionId if nueva_config.governmentConditionId is not None else ""
    )

    checksum = encrypt_checksum(*datos_a_checksum)
    #insercion del checksum a la nueva configuracion
    nueva_config.checksum = checksum


    #retorno el id de la configuracion insertada
    session.add(nueva_config)
    session.flush()#permite actualizar el objeto tipo tabla que fue insertado esto con la finalidad de obtener el id que fue generado al momento de la insercion.

    return nueva_config; #retorno el objeto actualizado junto a su ID asignado para futuras relaciones como FK en otras tablas

	
```	
</details>

<details>
<summary>Ver JSON de prueba principal</summary>

```json

{
	"idCard":"239675389",
    "proposalVersion":"Vigilancia comunitaria - Version inicial",
    "openDate": "2025-06-16T12:00:00Z",
    "closeDate": "2025-07-16T12:00:00Z",
    "creationDate": "2025-06-10T08:00:00Z",
    "VotingType": "Unica",
    "description": "Vigilancia comunitaria - Version inicial",
    "weight": 0,
    "ReminderType": "Email",
    "ClosureTypes": "Cierre hasta que los votantes terminen",
    "VotingReasons": "Aval de propuesta",
	"targetPopulations":[
	
		{
			"name":"Jóvenes Adultos",
			"weight":9.8
		}
	],
	"impactZones":[
	
		{
			"name":"Reducción de consumo hídrico"
		},
		{
			"name":"Extensión temporal del proyecto"
		}
	],
	"questions":[
	
		{
			"name":"¿Cuál es su fuente principal de agua potable?",
			"orderBy":1
		}
	],
	"rules":[
	
		{
			"name":"Regla A"
		},
		{
			"name":"Regla B"
		},
		{
			"name":"Regla C"
		}
	],
	"restrictions":[
	
		{
			"name":"Solo pueden votar mayores de 18 años"
		},
		{
			"name":"Votación exclusiva para San José"
		},
		{
			"name":"Correo debe contener dominio @tec.ac.cr"
		}
	],
    "allowedVoters":[
	
		{
			"idCard":"769616758"
		},
		{
			"idCard":"239675389"
		},
		{
			"idCard":"233644610"
		}
	]
}

```
</details> 

#### Errores Personalizados
  <details>
  <summary>Ver errores personalizados</summary>

Durante el proceso de inserción de la configuración y sus listas asociadas, se validan los datos y se controla la correcta ejecución de cada paso. Los errores que pueden ocurrir se describen a continuación:

| Error                                         | Código HTTP | Descripción                                                      | Motivo                                                                                    |
| --------------------------------------------- | ----------- | ---------------------------------------------------------------- | ----------------------------------------------------------------------------------------- |
| Configuración no insertada                    | 500         | "No se insertó la configuración de forma exitosa"                | No se pudo crear el registro principal de configuración en la base de datos.              |
| Segmentos poblacionales inválidos o faltantes | 400         | "Segmentos poblacionales inválidos o faltantes"                  | El campo `targetPopulations` está ausente o no es una lista válida en el JSON recibido.   |
| Error al insertar segmentos poblacionales     | 500         | "No se insertaron de forma correcta los segmentos poblacionales" | Fallo durante la inserción de los segmentos de población relacionados a la configuración. |
| Zonas de impacto inválidas o faltantes        | 400         | "Zonas de impactos inválidas o faltantes"                        | El campo `impactZones` está ausente o no es una lista válida.                             |
| Error al insertar zonas de impacto            | 500         | "No se insertaron de forma correcta las zonas de impacto"        | Fallo durante la inserción de las zonas de impacto asociadas.                             |
| Preguntas inválidas o faltantes               | 400         | "Preguntas inválidas o faltantes"                                | El campo `questions` está ausente o no es una lista válida.                               |
| Error al insertar preguntas                   | 500         | "No se insertaron de forma correcta las preguntas"               | Fallo en la inserción de las preguntas relacionadas con la votación.                      |
| Reglas inválidas o faltantes                  | 400         | "Reglas inválidas o faltantes"                                   | El campo `rules` está ausente o no es una lista válida.                                   |
| Error al insertar reglas                      | 500         | "No se insertaron de forma correcta las reglas"                  | Fallo durante la inserción de las reglas definidas para la votación.                      |
| Restricciones inválidas o faltantes           | 400         | "restricciones inválidas o faltantes"                            | El campo `restrictions` está ausente o no es una lista válida.                            |
| Error al insertar restricciones               | 500         | "No se insertaron de forma correcta las restricciones"           | Fallo en la inserción de restricciones de la configuración.                               |
| Votantes directos inválidos o faltantes       | 400         | "Votantes inválidas o faltantes"                                 | El campo `allowedVoters` está ausente o no es una lista válida.                           |
| Error al insertar votantes directos           | 500         | "No se insertaron de forma correcta los votantens directos"      | Fallo al insertar los votantes autorizados para la votación.                              |


</details>  


  </details>

### Comentar
<details>
  <summary>Ver Informacion</summary>
Este endpoint permite configurar todos los parámetros necesarios para realizar un comentario sobre una version de propuesta especifica. Su implementación se realiza utilizando el ORM **SQLAlchemy**, facilitando la manipulación de entidades y relaciones en la base de datos mediante clases Python.

#### Funcionalidad principal

El proceso inicia validando los permisos del usuario que desea realizar la configuración. Posteriormente, se hace la insercion del comenatrio inicial con estado "Pendiente de revision" el cual pasa por medio de work flow para as[i poder verificar su contenido.  Asi tambien al hacer la insercion de comenatrio principla se inserta un documento que tambien se analisa por medio de un worfkflow. 
Para hacer el Analisis de estos dos componentes de utiliza una siimulaciond e exito y error en el cual se genera valores random y segun su resultado se le asignan exitos o fallos a los requerimientos que esta validando. 
Cuando este comentario y documento son analizados se vuelven a insertar en las tablas pero con un estado de "aprobado o rechazado segun corresponda".  Si el comentario es aprobado se inserta con metadatos del usuario, en caso de ser rechazado se registra el intento en la tabla de LOGS

#### Herramientas utilizadas

- **Python** con **SQLAlchemy** como ORM.
- **Azure Functions** para ejecutar localmente bajo el enfoque serverless.
- **SQL Server** como base de datos.
- **Thunder Client** o **Postman** para pruebas de los endpoints.
<details>
  <summary>Ver Funcion ORM</summary>
	
```sql

import azure.functions as func
import logging
import json
from database import SessionLocal
import uuid #para generar numeros unicos
import random   #para generar simulacion de workflow
from datetime import datetime, timedelta
import json #Para hacer un insert de Nvarchar(MAX)
import os #utilizado para variables de entorno
from dotenv import load_dotenv
from sqlalchemy import text

# Carga las variables del .env
load_dotenv()
#variables de entorno
clave = os.getenv("CLAVECEDULA")

#Importacion de todas las tablas utilizadas para crear el proceso
from Models.users import VpvUser
from Models.Configuracion_Votacion.proposalVersion import VpvProposalVersions
#tablas de docs y coments
from Models.comentar.docs import VpvDoc
from Models.comentar.docstates import VpvDocState
from Models.comentar.docstypes import VpvDocTypes
from Models.comentar.formats import VpvFormat
from Models.comentar.identitydocs import VpvIdentityDoc
from Models.comentar.proposalComments import VpvProposalComments
from Models.comentar.processStatus import VpvProcessStatus
#tablas para workflows
from Models.comentar.extractedInfos import VpvExtractedInfos
from Models.comentar.parameters import VpvParameters
from Models.comentar.process import VpvProcess
from Models.comentar.processTypes import VpvProcessTypes
from Models.comentar.stepTypes import VpvStepTypes
from Models.comentar.workflowSteps import VpvWorkflowSteps
from Models.comentar.workResults import VpvWorkResults
from Models.comentar.api import VpvApi

#tablas de logs
from Models.comentar.logs import VpvLogs
from Models.comentar.logsSeverity import VpvLogSeverity
from Models.comentar.logsSources import VpvLogsSource
from Models.comentar.logTypes import VpvLogType

from Endpoints_ORM.encrypt_checksum import encrypt_checksum #Generacion del schecksum
from Endpoints_ORM.validarPermisos import validar_permiso


def comentar(req: func.HttpRequest) -> func.HttpResponse:
    logging.info('Insertando el comentario')

    if req.method != "POST":
        return func.HttpResponse(
            "Metodo no permitido",
            status_code=405
        )
    
    #Se obtienen los datos del Json
    try:
        session = SessionLocal()
        req_body = req.get_json()

        idcard = req_body.get("idCard")
        #Validacion del usuario, en este caso debe ser un proponente encargado de la configuracion y creacion de propuestas
        try:
            validar_permiso(session, idcard, 'Ciudadano')
        except PermissionError as e:
            return func.HttpResponse(
                json.dumps({"error": str(e)}),
                status_code=403,
                mimetype="application/json"
            )

        #Sesion Activa
        Sesion = VerificarSesionActiva(req_body, session)
        if not Sesion:
            return func.HttpResponse("El usuario no tiene sesión activa", status_code=403)
        
        #Realizar la inserción principal del comentario con estado "Pendiente de Revision"
        comentario = InsertarComentario (req_body, session)
        if not comentario:
            return func.HttpResponse("El comentario no se pudo insertar", status_code=500)

        #Validación del json e insercion de las demás componentes
        comments = req_body.get("Comment")
        if not comments or not isinstance(comments, list):#validacion de la existencia de datos
            return func.HttpResponse("Comentarios inválidos o inexistentes", status_code=400)

        #Insercion del doc
        documento = InsertDocument(req_body, session)
        if not documento:
            return func.HttpResponse("No se pudo insertar el documento", status_code=500)
        # Log de verificación
        logging.info(f"Documento insertado con fecha: {documento.date}")
        

        
        #---------------------------- WORKFLOW COMMENT ---------------------------
        # Insertar comentario (Pendiente de Revisión)
        comentario = InsertarComentario(req_body, session)
        if not comentario:
            return func.HttpResponse("No se pudo insertar el comentario inicial", status_code=500)

        # Insertar parámetros del comentario
        parametro_coment = InsertarParametros(req_body, session, "comentario")
        if not parametro_coment:
            return func.HttpResponse("No se pudo insertar los parámetros del comentario", status_code=500)

        # Crear proceso para el comentario
        proceso_coment = CrearProceso(comentario, parametro_coment, session, "comentario")
        if not proceso_coment:
            return func.HttpResponse("No se pudo crear el proceso para el comentario", status_code=500)

        # Ejecutar análisis para el comentario
        resultado_coment = InsertarSimulacion(req_body, proceso_coment, session, tipo="comentario")
        if not resultado_coment:
            return func.HttpResponse("No se pudo ejecutar el análisis del comentario", status_code=500)

        #--------------------------- WORKFLOW DOCS ----------------------------------

        # Insertar parámetros del documento
        parametro_doc = InsertarParametros(req_body, session, "documento")
        if not parametro_doc:
            return func.HttpResponse("No se pudo insertar los parámetros del documento", status_code=500)

        # Crear proceso para el documento
        proceso_doc = CrearProceso(documento, parametro_doc, session, "documento")
        if not proceso_doc:
            return func.HttpResponse("No se pudo crear el proceso para el documento", status_code=500)

        # Ejecutar análisis para el documento
        resultado_doc = InsertarSimulacion(req_body, proceso_doc, session, tipo="documento")
        if not resultado_doc:
            return func.HttpResponse("No se pudo ejecutar el análisis del documento", status_code=500)

        #Insertar comentario final con nuevo estado que depende de ambos análisis tanto el reult de comment como el del doc
        estado_final = "Rechazado" if resultado_coment.error or resultado_doc.error else "Aprobado"
        comentario_final = InsertarComentario(req_body, session, estado_override=estado_final)
        if not comentario_final:
            return func.HttpResponse("No se pudo insertar el comentario final", status_code=500)

        session.commit() #Se validan todas las restricciones para cumplir con atomicidad

        return func.HttpResponse("Comentario Insertado correctamente", status_code=201)
    
    
    except ValueError as e:
        session.rollback()  #Rollback de la sesión principal en caso de errores
        return func.HttpResponse(
            str(e),
            status_code=200
        )



'''
Desencripta la cédula (id_card) usando una clave simétrica.
Consulta vpv_Users para verificar si hay un usuario activo con esa cédula.

Entradas: "idCard" (cédula) por medio del body, session: conexión activa a la base de datos.
Salidas:True si el usuario está activo.

'''
def VerificarSesionActiva(req_body, session):
    id_card = req_body.get("idCard")

    if not id_card:
        raise ValueError("Se requiere el campo 'idCard' para verificar la sesión.")

    # Abrir la llave de desencriptación
    session.execute(text(f"OPEN SYMMETRIC KEY llavecedula DECRYPTION BY PASSWORD = '{clave}'"))

    # Buscar el idUser con la cédula desencriptada
    result = session.execute(text("""
        SELECT idUser
        FROM vpv_Users
        WHERE enable = 1 AND deleted = 0
        AND CONVERT(nvarchar(50), DECRYPTBYKEY(id_card)) = :idCard
    """), {'idCard': id_card})

    row = result.fetchone()

    # Cerrar la llave
    session.execute(text("CLOSE SYMMETRIC KEY llavecedula"))

    if not row:
        return {"error": f"No se encontró un usuario activo con la cédula {id_card}"}, 400

    # Usuario está activo
    return True

'''
Funcion que valida existencia de IDS externos para hacer insercion en docs
Entradas: JSON con la sección "Document" (filename, docstype, docstate, format, identitydoc).}
Salidas: Objeto insertado o sea la tabla docs
'''
def InsertDocument(req_body, session):
    #Verifica la existencia de datos
    document_data = req_body.get("Document", [])
    
    if not document_data or not isinstance(document_data, list):
        raise ValueError("Debe adjuntar un documento")

    document_info = document_data[0]

    #Validar el hecho de que haya un documento
    filename = document_info.get("filename")
    if not filename:
        raise ValueError("Debe adjuntar un documento")

    #Obtener el Id del identity doc
    identitydoc = document_info.get("identitydoc")
    doc_identity_id = session.query(VpvIdentityDoc.identitydocsid).filter_by(referenceid=identitydoc).first()
    if not doc_identity_id:
        raise ValueError(f"No se encontró el identity de documento {identitydoc}")
    
    # Obtener el ID del tipo de documento
    doc_type = document_info.get("docstype")
    doc_type_id = session.query(VpvDocTypes.docstypeid).filter_by(name=doc_type).first()
    if not doc_type_id:
        raise ValueError(f"No se encontró el tipo de documento {doc_type}")
    
    # Obtener el ID del estado del documento 
    doc_state = document_info.get("docstate")
    doc_state_id = session.query(VpvDocState.docstateid).filter_by(name=doc_state).first()
    if not doc_state_id:
        raise ValueError(f"No se encontró el estado del documento {doc_state}")
    
    # oBTENER el ID del formato del documento
    doc_format = document_info.get("format")
    format_id = session.query(VpvFormat.formatid).filter_by(name=doc_format).first()
    if not format_id:
        raise ValueError(f"No se encontró el formato {doc_format}")
    

    #Cifrar el filename
    filename_encrypted = encrypt_checksum(filename)
    #Para generar fecha actual 
    now = datetime.utcnow()    
    # Crea el objeto para el documento
    document = VpvDoc(
        identitydocsid=doc_identity_id[0],
        formatid=format_id[0],
        docstypeid=doc_type_id[0],
        docstateid=doc_state_id[0],
        filename=filename_encrypted,
        date=now,
        enable=True,
        startdate=now,
        nextcheckdate=now + timedelta(days=30),
        semantic_category=req_body.get("semantic_category")
    )



    datos_a_checksum = (document.identitydocsid, 
                        document.formatid, 
                        document.docstypeid, 
                        document.docstateid, 
                        document.filename,
                        document.date,
                        document.startdate,
                        document.nextcheckdate,
                        document.semantic_category)
    checksum = encrypt_checksum(*datos_a_checksum)



    binary_checksum = bytes(checksum, 'utf-8')


    #Se inserta el checksum y archive del doc
    document.checksum = binary_checksum 
    document.archive = binary_checksum
    
    # Inserta el documento en la base de datos
    session.add(document)

    return document

'''
Funcion que valida existencia de info wn el body externos para hacer insercion en comentario
Además de hacer insercion de comentario dependiendo del estado de work result con metadatos 
Entradas: req_body: JSON con "ProposalVersion" y sección "Comment" (incluye "comment" y "status")
Salidas: Objeto insertado o sea la tabla proposal comments
'''
def InsertarComentario(req_body, session, estado_override=None ):

    # obtener datos del json
    proposal_version = req_body.get("ProposalVersion")
    proposal_version = session.query(VpvProposalVersions).filter_by(tittle=proposal_version).first() 

    # Verificar que la propuesta exista
    if not proposal_version:
        raise ValueError(f"No se encontró la propuesta con el título: {proposal_version}")

    # Verificar si los comentarios están permitidos a esa propuesta especifica 
    if not proposal_version.commentsAllowed:
        raise ValueError("Los comentarios no están permitidos para esta propuesta.")

    # Obtener el ID del documento insertado previamente
    doc_identity_id = req_body.get("Document")[0]["filename"]
    doc_id = session.query(VpvDoc.docid).filter_by(filename=doc_identity_id).first()
    if not doc_id:
        return func.HttpResponse(f"No se encontró el documento {doc_identity_id}", status_code=400)
    
    # Obtener el id del status que se le asigna al comment "Pendiente de revisión"
    status_name = req_body["Comment"][0]["status"]

    #Se inserta el estado nuevo del comentario en caso de error o no 
    if estado_override:
        status_name = estado_override

    #Si no hay error entonces inserta el estado original del JSON
    status_id = session.query(VpvProcessStatus.statusId).filter_by(name=status_name).first()
    if not status_id:
        raise ValueError(f"No se encontró el estado con el nombre: {status_name}")


    # Crear el comentario
    comment_data = req_body.get("Comment")[0]   #Se accede al atributos de comment y sus subcampos

    #Comentario cifrado
    comentario = comment_data.get("comment")
    comentario_cifrado = encrypt_checksum(comentario) 

    #Insertar metadatos solo si tiene estado aprobado
    id_card = req_body.get("idCard")
    metadatos = None
    if status_name.strip().lower() == "aprobado":
        #usuario = comment_data.get("madeBy", "Usuario desconocido")
        metadatos = f"Comentario Aprobado de la propuesta '{proposal_version.tittle}' por el usercard {id_card} "


    new_comment = VpvProposalComments(
        comment=comentario_cifrado,
        madeBy=1,
        docid=doc_id[0],  #el doc obtenido de la consulta
        proposalVersionId=proposal_version.proposalVersionId, #la prop id obtenido de la consulta
        creationDate=comment_data.get("creationDate"),
        statusId=status_id[0],
        relacion=metadatos
    )

    datos_a_checksum = (new_comment.comment,
                        new_comment.madeBy,
                        new_comment.docid,
                        new_comment.proposalVersionId,
                        new_comment.creationDate,
                        new_comment.statusId,
                        new_comment.relacion)
    
    checksum = encrypt_checksum(*datos_a_checksum)

    binary_checksum = bytes(checksum, 'utf-8')

    #Asignar valor del checksum
    new_comment.checksum = binary_checksum

    # Insertar el comentario en la base de datos
    session.add(new_comment)

    return new_comment


#-------------------PROCESO DE WORKFLOWS ---------------------

'''
Prepara los parametros para el proceso de workflow tomando datos importantes a analizar desde el body 
y recibe el tipo ya sea comentario o doc segun lo que se vaya a a analizar 
Entradas 
    req_body: JSON completo de entrada (con "Comment" o "Document").
    tipo: "comentario" o "documento". 
Salidas:
    Objeto insertado o sea la tabla de parameters
'''
def InsertarParametros(req_body, session,tipo):
    
    if tipo == "comentario":
        config = {
            "comentario": req_body.get("Comment")[0]["comment"]}

    elif tipo == "documento":
        doc = req_body.get("Document")[0]
        config = {
            "documento": doc.get("filename"),
            "tipo_doc": doc.get("docstype"),}

    else:
        raise ValueError(f"Tipo de entrada no existente")
    
    nuevo_param = VpvParameters(
        idApi = 1,
        name=f"param-{uuid.uuid4().hex[:6]}", #Crea un identificador unico para cada parametro que se pase por el workflow en caso que se manden el mismo json varias veces
        configuration=json.dumps(config),
        enable=True
    )
    session.add(nuevo_param)
    session.flush()  #permite actualizar el objeto tipo tabla que fue insertado esto con la finalidad de obtener el id que fue generado al momento de la insercion.


    return nuevo_param

'''
Inserta el proceso en vpv_Process con información base y relación al parámetro que sea doc o commnet
Entradas
    objeto: objeto VpvProposalComments o VpvDoc (comentario o documento).
    parametro_obj: objeto VpvParameters.
    tipo: "comentario" o "documento".
Salidas:
    Objeto insertado es decir la tabla proceso
'''
def CrearProceso(objeto, parametro_obj, session, tipo):

    # Obtener el tipo de proceso con nombre 'IA' 
    processtype = session.query(VpvProcessTypes).filter_by(name='IA').first()
    if not processtype:
        raise ValueError("No se encontró el tipo de proceso 'IA' en la tabla processtypes")

    if tipo == "comentario":
        referenceid = "commentId"
        referencevalue = objeto.commentId
        nombre = "Proceso IA de validación estructural"
        descripcion = "Proceso automático para validar estructura del comentario"

    elif tipo == "documento":
        referenceid = "docId"
        referencevalue = objeto.docid
        nombre = "Proceso IA de validación documental"
        descripcion = "Proceso automático para validar requisitos del documento"

    else:
        raise ValueError(f"Tipo de proceso no existente: {tipo}")

    proceso = VpvProcess(
        processtypeid=processtype.processtypeid,  
        referencevalue=referencevalue,   #Insercion del id del comentario
        referenceid=referenceid,     #Insercion de 'Commentid' para saber a qué hace refernecia el id de arriba
        parameterid=parametro_obj.parameterid,
        processmethodid=0,
        name="Proceso IA de validación estructural",
        description="Proceso automático para validar estructura del comentario",
        enable=True
    )
    session.add(proceso)
    session.flush()  # para obtener el processid
    return proceso

'''
Verifica los workflow steps que se deben seguir segun el tipo para analizar.
Genera un numero random para hacer simulacion de IA y obtener erorres o exitos en el proceso 
Genera un Json que será insertado en logs para dejar registro
Entradas
    objeto: El proceso creado 
    tipo: "comentario" o "documento".
Salidas:
    Objeto insertado es decir la tabla workresultas
'''
def InsertarSimulacion(req_body, process, session, tipo):

    if tipo == "comentario":
        tipo_validacion = "Validacion de Comentario"
    elif tipo == "documento":
        tipo_validacion = "Validación de documento"
    else:
        raise ValueError(f"Tipo de proceso no soportado: {tipo}")

    #Realiza una consulta para saber los steps que lleva validar ese comentario
    #SELECT * FROM vpv_workflowsteps 
    #WHERE processtypeid = 'Validacion de comentario' o 'Validacion de documento' AND enable = 1 
    #ORDER BY steporder;
    pasos = (
        session.query(VpvWorkflowSteps)
        .join(VpvStepTypes, VpvWorkflowSteps.steptypeid == VpvStepTypes.steptypeid)
        .filter(
            VpvWorkflowSteps.processtypeid == process.processtypeid,
            VpvWorkflowSteps.enable == True,
            VpvStepTypes.type == tipo_validacion)
        .order_by(VpvWorkflowSteps.steporder)
        .all())

    # Simulación de cada paso
    resumen_pasos = [] #Se crea una cadena para guardar los resultados de cada paso
    hubo_error = False

    for paso in pasos:
        aprobado = random.random() > 0.2  # 80% chance de tener exito el resultado 
        resultado = {
            "paso": paso.name,
            "resultado": "Aprobado" if aprobado else "Falló"
        }
        resumen_pasos.append(resultado) #Agrega el resultado del paso a la lista
        if not aprobado:
            hubo_error = True

    #Detalles del Json
    details = json.dumps({
        "total_pasos": len(pasos),
        "errores": sum(1 for r in resumen_pasos if r["resultado"] == "Falló"),
        "resumen": resumen_pasos
    })

    # Crear y guardar el resultado del workflow
    workresult = VpvWorkResults(
        processid=process.processid,
        referencevalue=process.referencevalue,  #Id del proceso
        referenceid=process.referencevalue,    #Qué proceso (para dar contexto)
        timestamp=datetime.utcnow(),
        error=hubo_error,
        errorMessage=(
            f"Errores en pasos del análisis del {tipo}" if hubo_error 
            else f"{tipo.capitalize()} exitoso"
        ),
        details=details,
        performedby="IA Azure"
    )

    session.add(workresult)
    session.flush()

    if hubo_error:
        insertarLog(req_body, session, workresult.details)

    return workresult


'''
Funcion para dejar registro del comentario rechazado
Entradas: 
    user
    mensje de eror de work results
Salidas: Objeto insertado o sea la tabla de logs
'''
def insertarLog(req_body, session, error_msg):

    # Obtener IDs de logs
    logSeverity = session.query(VpvLogSeverity).filter_by(name='Informational').first()
    logSource = session.query(VpvLogsSource).filter_by(name='User Activity').first()
    logType = session.query(VpvLogType).filter_by(name='Info').first()

    if not logSeverity or not logSource or not logType:
        raise ValueError("No se encontraron los IDs requeridos para logSeverity, logSource o logType.")

    # Crear descripción del log y user que realiza el intento de comentar
    id_card = req_body.get("idCard")
    descripcion = f"Error: {error_msg}"
    username = f"Comentario realizado por el usercard: {id_card}"
    fecha = f"Intento de comentario: {datetime.utcnow().strftime('%Y-%m-%d %H:%M:%S')}"



    log = VpvLogs(
        description=descripcion,
        computer='computer PV',
        username=username,
        trace=None,
        referenceId1=fecha,
        referenceId2=None,
        value1=None,
        value2=None,
        logSeverityId=logSeverity.logSeverityId,
        logSourceId=logSource.logSourceId,
        logTypeId=logType.logTypeId
    )

    #calculo del checksum
    datos_a_checksum = (log.description,
                        log.computer,
                        log.username,
                        log.logSeverityId,
                        log.logSourceId,
                        log.logTypeId)
    checksum = encrypt_checksum(*datos_a_checksum)

    binary_checksum = bytes(checksum, 'utf-8')

    #Se inserta el checksum
    log.chechsum = binary_checksum

    session.add(log)
    session.flush()
	
```	
</details>

<details>
<summary>Ver JSON de prueba principal</summary>

```json

{
    "idCard":"258503207",
    "ProposalVersion": "Proyecto de reciclaje - Expansión regional", 
    "Comment": [
        {
            "comment": "Haciendo la revision para la propuesta nos hemos dado cuenta que se tiene que adjuntar una certificaion de salud establecida por el consejo, por esto adjuntamos la plantilla que debe seguir para entregarla.  De no entregarla en 1 mes su propuesta queda archivada por el consejo ", 
            "status": "Pendiente de revisión",
            "creationDate": "2025-06-25T08:00:00Z"
        }
    ],
    "Document": [
    
        {
            "identitydoc": "CSS-008",  
            "format": "PDF",  
            "docstype": "Salud",  
            "docstate": "En Revisión",  
            "filename": "Certificación de Salud.pdf",  
            "date": "2025-07-16T12:00:00Z",  
            "startdate": "2025-07-16T12:00:00Z",  
            "nextcheckdate": "2025-07-16T12:00:00Z",  
            "semantic_category": "Certificación de Salud en PDF"  
        }
    ]
}
```
</details> 




</details>
   
  </details>



</details>          


