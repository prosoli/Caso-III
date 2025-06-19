# 🎓 Caso #3 - 35%

### 🛠️ Temas Abordados:
- 

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
## Diseño SQL
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

## Implementación del API
<details>
  <summary>Desplegar información</summary>

  ### Endpoints implementados por Stored Procedures
  ---
  <details>
  <summary>Desplegar información</summary>
    En construccion
  </details>

  ### Endpoints implementados por ORM
  ---
  <details>
  <summary>Desplegar información</summary>
    En construccion
  </details>

</details>


## Dashboard de Consulta

### Inicio de Sesión
  <details>
  <summary>Desplegar información</summary>
    en construccion
  </details>

### Dashboard principal
  <details>
  <summary>Desplegar información</summary>
    
  </details>

</details>

![alt text](assets/dashboardNoCrowfounding.png)

