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
🌎 [Uso de los motores de base de datos](#uso-de-los-motores-de-base-de-datos)

🌎 Diseño SQL

🌎 [Implementación del API](#implementación-del-api)

🌎 Endpoints implementados por Stored Procedures

🌎 Endpoints implementados por ORM

🌎 DashBoard de consulta

---
## Uso de los motores de base de datos
<details>
  <summary>Desplegar información</summary>

  En construcción

</details>

---

### Catalogo Base del sistema

<details>
 <summary>Desplegar información</summary>
 
#### Tipos de vista

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

 <summary>Desplegar información</summary>
#### Tipos de propuesta
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
    ('Propuesta experimental', 'Iniciativas que exploran enfoques no convencionales o innovadores.', 1)
```
</details>

 <summary>Desplegar información</summary>
#### Estados de procesos
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

 <summary>Desplegar información</summary>
#### Entidades de gobierno
```sql
INSERT INTO [dbo].[vpv_governmentEntities] ([name], [acronym], [enable]) --FALTAAA!!
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

 <summary>Desplegar información</summary>
#### Beneficios de gobierno
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
