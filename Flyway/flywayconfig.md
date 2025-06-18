### Paso 1
Descargue el command-line de flyway en: https://documentation.red-gate.com/fd/command-line-277579359.html

### Paso 2
Despues de descomprimir el archivo, puede ingresarlo desde visual studio code. Ejecute 'mkdir sql' para asi crear la carpeta en la que se van a guardar todos los scripts de versiones de la bd

### Paso 3

#### Manejo de archivos

Para poder almacenar los archivos dentro de la carpeta sql deben nombrarse con el numero de version + nombre + .sql esto porque al hacer el migrado, flyway reconoce unicamente las versiones que no se han ejecutado, si usted desea hacer una corrección que estuvo en la V1, debe hacer una nueva versión y ponerla en la carpeta para que el la reconozca como nueva y pueda ejecutarla.
Formato: 
- 'V1__scriptCreacion.sql'
- 'V2__llenado.sql'
- 'V3__###'
- 'V4__###'
    .
    .
    .


### Paso 4
En la carpeta conf ya hay un archivo que trae ejemplo para hacer la conexion a la base de datos, lo que debe hacer es hacer una copia de ese archivo ahí mismo y renombrarla como 'flyway.conf' en el cual vamos a añadir la conexion a la base de datos. 
Cada uno debe adaptar su conexion pero es algo asi 

``
flyway.url=jdbc:sqlserver://PRISCILLAROMERO;databaseName=puravidabd;integratedSecurity=true;trustServerCertificate=true
flyway.schemas=puravidabd
flyway.locations=filesystem:sql
flyway.detectEncoding=true
``

despues debe correr '.\flyway.cmd baseline' para hacer la conexion con la bd y debe verificar que le aparezca una nueva tabla en la bd llamada puravidabd.flyway_schema_history 

NOTA> se utiliza baseline para indicar el punto de inicio del Flyway, le dice desde que punto de referencia va a empezar a trabajar (en nuestro caso que ya tenemos tablas creadas)

Despues debe poner el archivo de creacion 'V1__scriptCreacion.sql' en la carpeta y ejecutar '.\flyway.cmd migrate' y lo que se va a realizar es una comparacion con lo que ya esta en la bd, en este caso no se ejecuta el script porque se detetcta que la bd ya tiene eso

### Paso 5

Hay 2 maneras de guardar los scripts:

1. Puede hacer el script y no ejecutarlo en la bd manualmente sino que ponerlo en la carpeta sql como y que flyway lo haga por usted y ahí se hace como fetch con la bd.

2. Puede ejecutar el script en la bd manualmente y despues ponerlo como V# en la carpeta sql, al hacer migrate se detecta que eso ya existe entonces no lo vuelve a ejecutar pero queda marcada la versión.

