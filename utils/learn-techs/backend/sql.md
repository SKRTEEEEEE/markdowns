# SQL
Bases de datos relacionales, basada en tablas. 
_Podemos crear una base de datos, la cual dentro va a tener tablas._
- Cuentas de ususarios, podemos asignar nuevos usuarios y darle roles o modificar-los.
- Exportar, podemos compartir información en varios tipos de formatos.
- Importar, podemos importar bases de datos

**Es case sensitive para los valores no para las instrucciones**

_En SQL, la distinción entre mayúsculas y minúsculas se aplica a los valores almacenados en las tablas de la base de datos, lo que significa que "Juan" y "juan" se consideran diferentes. Sin embargo, para las instrucciones SQL, como SELECT o INSERT, la distinción entre mayúsculas y minúsculas no importa; por lo tanto, las instrucciones como SELECT, select o SeLeCt son equivalentes y funcionan de la misma manera._

## Datos
### Valores:
Los valores en SQL son los datos reales que se almacenan en las tablas o se utilizan en las consultas. Pueden ser constantes, literales o el resultado de una expresión. Aquí hay algunos ejemplos de valores en SQL:

#### Números: 
`1`, `2`, `3.5`, etc.
#### Cadenas de texto: 
`'hola'`, `'nombre de usuario'`, etc.
#### Fechas:
`'2022-01-01'`, `'2022-12-31'`, etc.
#### Valores especiales:
`NULL`, `TRUE`, `FALSE`, etc

### Tipos de datos
Los tipos de datos en SQL son los diferentes tipos de valores que pueden ser almacenados en las columnas de una tabla. Determinan qué tipo de datos puede almacenar una columna y cómo se almacenan y manipulan esos datos. Algunos de los tipos de datos comunes en SQL incluyen:

#### 1. VARCHAR(n):
- Almacena cadenas de caracteres de longitud variable.
- Se especifica una longitud máxima n que puede variar de 1 a 65,535 caracteres.
- Utilizado para almacenar texto de longitud variable, como nombres, direcciones, descripciones, etc.

#### 2. INT:
- Almacena números enteros.
- Puede ser de diferentes tamaños, como INT (4 bytes) o BIGINT (8 bytes), dependiendo del rango de valores que necesites almacenar.
- Utilizado para almacenar números enteros, como identificadores, cantidades, índices, etc.

#### 3. DECIMAL(p, s):
- Almacena números decimales de precisión fija.
- Se especifican dos parámetros: p que representa la precisión total y s que representa la escala (número de dígitos después del punto decimal).
- Utilizado para almacenar valores monetarios u otros valores que requieren precisión decimal exacta.

#### 4. DATE:
- Almacena fechas en formato 'YYYY-MM-DD'.
- Utilizado para almacenar fechas sin información sobre la hora.

#### 5. TIME:
- Almacena horas en formato 'HH:MM:SS'.
- Utilizado para almacenar horas del día.

#### 6. DATETIME o TIMESTAMP:
- Almacena fechas y horas en formato 'YYYY-MM-DD HH:MM:SS'.
- TIMESTAMP a menudo se usa para almacenar la fecha y hora de la creación o modificación de un registro automáticamente.

#### 7. BOOLEAN o BOOL:
- Almacena valores de verdad, que pueden ser TRUE, FALSE o NULL.
- Utilizado para representar valores lógicos, como verdadero o falso.

#### 8. BLOB y TEXT:
- Almacena datos binarios grandes (BLOB) o cadenas de texto largas (TEXT).
- BLOB se usa para datos binarios como imágenes o archivos, mientras que TEXT se usa para texto largo como documentos o descripciones extensas.

## Instrucciones
Las instrucciones son comandos que se utilizan para realizar operaciones en la base de datos, como SELECT, INSERT, UPDATE, DELETE, CREATE, ALTER, DROP, etc. Cada instrucción tiene su propia sintaxis y se utiliza para realizar una tarea específica en la base de datos.

### SQL DML (Data Manipulation Language):
Se utiliza para manipular datos en una base de datos. Los principales son los siguientes:

_Tambien conocidos como **CRUD**._

#### Insert (Create)
Esto es una sentencia basica para insertar datos. 
```sql
INSERT INTO `productos`(`id_productos`, `nombre`, `descripcion`, `fecha`) VALUES ('[value-1]','[value-2]','[value-3]','[value-4]')
```
- Podemos prescindir de id_productos ya se que se autoincrementa
- La fecha tambien podemos prescindir ya que se pone automaticamente, si pusieramos algo se sobreescribiria.
```sql
INSERT INTO `productos`( `nombre`, `descripcion`) 
VALUES ('peras','peras ecologicas de temporada muy ricas')
```

#### Select (Read)
Esto es una sentencia basica para leer datos:
```sql
SELECT * FROM productos WHERE nombre = "manzanas"
```

#### Update 
Podemos sobreescribir la informacion desde phpMyAdmin (como si fuera una tabla, clicando encima) o con el siguiente comando SQL:
```sql
UPDATE `productos` SET `description` = 'Manzanas ecológicas de temporada, muy frescas' WHERE `productos`.`id_productos` = 1
```

#### Delete
Podemos eliminar la informacion desde phpMyAdmin (como si fuera una tabla, clicando encima) o con el siguiente comando SQL:
```sql
DELETE FROM productos WHERE `productos`.`id_productos` = 1
```
- `DELETE FROM alumnos` -> Limpiamos o vaciamos tabla alumnos
- `DROP TABLE alumnos` -> Borramos tabla alumnos
- `DROP DATABASE escuela;` -> Borrar base de datos escuela

Aunque podemos encontrar muchas otras y las podemos clasificar segun sus **principales funciones**.

#### Manipulación de Datos
1. **Insertar, Actualizar y Eliminar Datos**

- Insertar registros en una tabla (`INSERT INTO`).
- Actualizar registros en una tabla (`UPDATE`).
- Eliminar registros de una tabla (`DELETE FROM`).

2. **Operadores y Funciones de Agregado**
- Operadores de comparación y lógicos.
    Operadores
	`UPDATE productos SET IVA="0.10" WHERE fecha!="2024-03-30";`, diferente a `!=`
        `UPDATE productos SET IVA="0.10" WHERE fecha > "2024-03-31"` mayor que `>` o menor que `<`

- Funciones de agregado (`SUM()`, `AVG()`, `MAX()`, `MIN()`, etc.).
      Funciones matematicas
          `SELECT precio FROM productos ORDER BY precio DESC LIMIT 1;` "o" -> `SELECT MAX(precio) FROM productos;`, nos mostrara el maximo de un valor(en este caso precio)
          `SELECT AVG(precio) FROM productos;` nos mostrara el promedio "average" de un valor(en este caso precio)


3. **Funciones de Texto y Caracteres**
- Funciones para manipular cadenas de texto (`CONCAT()`, `UPPER()`, `LOWER()`, etc.).

4. **Funciones de Fecha y Hora**
- Funciones para trabajar con valores de fecha y hora (`DATE()`, `MONTH()`, `YEAR()`, etc.).

#### Consultas y Filtrado
5. **Consultas Básicas y Avanzadas**
- Consultas básicas (`SELECT`).
- Consultas avanzadas con funciones y operadores.
      Contar _Podemos usar el count para saber la cantidad de algo dentro de la tabla_
              ```sql
            SELECT COUNT(*) FROM productos;
    	-- Por ejemplo aqui contariamos cuantos productos distintos hay
            SELECT COUNT(DISTINCT*) FROM productos;
        ```
  
6. **Agrupamiento y Ordenamiento**
- Agrupamiento de resultados (`GROUP BY`).
- Ordenamiento de resultados (`ORDER BY`).

7. **Filtrado y Selección de Datos**
- Filtrado de resultados (`WHERE`).
- Selección condicional de datos (`CASE`).

8. **Funciones de Conjunto de Resultados**
- Funciones para manipular resultados de consultas (`ROW_NUMBER()`, `RANK()`, etc.).

#### Transacciones y Control de Datos
9. **Transacciones y Bloqueo**
- Instrucciones para gestionar transacciones (`BEGIN`, `COMMIT`, `ROLLBACK`).
- Instrucciones para bloquear filas (`LOCK TABLES`).

10. **Control de Flujo y Excepciones**
- Funciones para controlar el flujo de ejecución (`IF`, `CASE`, etc.).
- Manejo de excepciones (`TRY-CATCH`, `RAISE_ERROR`, etc.).

### Otros
11. **Variables y Funciones Personalizadas**
- Declaración y uso de variables.
- Creación y uso de funciones personalizadas.

12. **Optimización y Gestión de Usuarios**
- Técnicas de optimización de consultas.
- Gestión de usuarios y permisos.

13. **Manipulación Avanzada de Datos**
- Operaciones avanzadas con conjuntos de datos (`UNION`, `INTERSECT`, etc.).
- Manipulación de imágenes y multimedia.

### SQL DDL (Data Definition Language)
Se utiliza para definir y modificar la estructura de la base de datos y sus objetos. Incluye comandos como:
#### `CREATE` 
Se utiliza para crear nuevos objetos de base de datos, como tablas, índices y vistas.
#### `ALTER` 
Se usa para modificar la estructura de los objetos existentes, como agregar, modificar o eliminar columnas de una tabla.
```sql
ALTER TABLE 'productos' ADD 'precio' DECIMAL(5,2)NOT NULL AFTER 'fecha', ADD 'IVA' DECIMAL(3,2) NOT NULL DEFAULT '0.03' AFTER 'precio';
```
#### `DROP` 
Se utiliza para eliminar objetos de la base de datos, como tablas o índices.

### SQL DCL (Data Control Language)
Se utiliza para controlar los permisos y la seguridad de los datos en la base de datos. Incluye comandos como: 
- `GRANT` se utiliza para otorgar privilegios a usuarios sobre objetos de la base de datos.
- `REVOKE` se usa para revocar privilegios previamente otorgados.

### SQL TCL(Transaction Control Language)
Se utiliza para controlar las transacciones en la base de datos. Incluye comandos como:
- `COMMIT` se utiliza para confirmar los cambios realizados en una transacción.
- `ROLLBACK` se usa para deshacer los cambios realizados en una transacción.
- `SAVEPOINT` se utiliza para establecer puntos de guardado dentro de una transacción.

## Relaciones
En SQL, las relaciones se refieren a cómo las tablas dentro de una base de datos relacional están conectadas entre sí. Estas relaciones permiten representar y organizar datos de manera significativa y coherente, lo que facilita la manipulación y el acceso a la información. 

> Cuando haya información que se repita mucho, podemos usar relaciones.

### Key (llave)
En SQL, una clave es un concepto fundamental que se utiliza para garantizar la integridad de los datos y establecer relaciones entre tablas en una base de datos relacional. Hay dos tipos principales de claves:

#### Primary key
- Una clave primaria es un campo o un conjunto de campos en una tabla de una base de datos relacional que identifica de forma única cada fila en esa tabla.
- La clave primaria garantiza la integridad de los datos al evitar la inserción de registros duplicados.
- Por lo general, la clave primaria se utiliza para establecer relaciones entre tablas. Cada tabla debe tener una y solo una clave primaria.
- En la mayoría de los sistemas de gestión de bases de datos (DBMS), las claves primarias son automáticamente únicas y no nulas.

#### Foreign key
- Una clave foránea es un campo en una tabla que hace referencia a la clave primaria de otra tabla. Establece una relación entre dos tablas.
- La clave foránea asegura la integridad referencial, lo que significa que los valores en la columna de la clave foránea deben coincidir con los valores en la columna de la clave primaria de la tabla referenciada.
- Las claves foráneas se utilizan para establecer relaciones entre tablas, permitiendo consultas y operaciones que involucran datos de varias tablas.
- Puede haber múltiples claves foráneas en una tabla, y estas pueden hacer referencia a la misma tabla o a diferentes tablas.

### Principales tipos de relaciones que puedes encontrar en bases de datos relacionales. 
Cada uno tiene sus propias características y se utiliza en diferentes contextos según los requerimientos específicos del sistema

#### 1. Relación Uno a Uno (1:1):
- En esta relación, una fila en una tabla está relacionada con exactamente una fila en otra tabla, y viceversa.
- Es menos común que otras relaciones, pero se utiliza en situaciones donde la relación es única y exclusiva.

#### 2. Relación Uno a Varios (1:N):
- En esta relación, una fila en una tabla puede estar relacionada con una o varias filas en otra tabla, pero una fila en la segunda tabla solo puede estar relacionada con una fila en la primera tabla.
- Es la relación más común en bases de datos relacionales y se utiliza en muchas situaciones, como clientes y pedidos, donde un cliente puede realizar varios pedidos.

#### 3. Relación Varios a Uno (N:1):
- Esta relación es el opuesto de la relación uno a varios.
- En esta relación, varias filas en una tabla pueden estar relacionadas con una sola fila en otra tabla, pero una fila en la segunda tabla solo puede estar relacionada con una fila en la primera tabla.
- Por ejemplo, en una tabla de pedidos, varias filas de pedidos pueden pertenecer a un solo cliente.

#### 4. Relación Varios a Varios (N:M):
- En esta relación, varias filas en una tabla pueden estar relacionadas con varias filas en otra tabla.
- Para implementar esta relación en una base de datos relacional, se requiere una tabla intermedia, también conocida como tabla de unión o tabla de asociación, que relaciona las dos tablas.
- Es común en situaciones donde los elementos de ambas tablas pueden tener múltiples asociaciones entre sí. Por ejemplo, en una base de datos de estudiantes y clases, donde un estudiante puede estar inscrito en múltiples clases y una clase puede tener múltiples estudiantes inscritos.

## Herramientas y Plataformas
### MariaDB
- MariaDB es un sistema de gestión de bases de datos relacional (RDBMS) que es una bifurcación de MySQL.
- Ofrece un servidor de base de datos que almacena, recupera y maneja datos para aplicaciones y usuarios.
- MariaDB proporciona características adicionales y mejoras de rendimiento sobre MySQL.
- Se utiliza para crear, modificar y consultar bases de datos, y es el servidor real donde se almacenan los datos.

Algunas características importantes de MariaDB incluyen:
- **Compatibilidad con MySQL:** MariaDB está diseñada para ser compatible con MySQL, lo que significa que muchas aplicaciones y herramientas que funcionan con MySQL también pueden trabajar con MariaDB sin necesidad de modificaciones significativas.
- **Licencia de código abierto:** MariaDB se distribuye bajo los términos de la Licencia Pública General de GNU (GPL), lo que permite su uso, modificación y distribución libremente.
- **Rendimiento mejorado:** MariaDB incluye mejoras de rendimiento en comparación con MySQL, incluyendo optimizaciones de consultas y nuevas características de almacenamiento.
- **Almacenamiento y motores de almacenamiento:** MariaDB admite una variedad de motores de almacenamiento, incluidos XtraDB (una versión mejorada de InnoDB), Aria, TokuDB, y otros. Esto proporciona flexibilidad para adaptarse a diferentes tipos de aplicaciones y cargas de trabajo.
- **Características adicionales:** MariaDB incluye características adicionales que no están presentes en MySQL, como la compatibilidad con ciertos tipos de datos, funciones y almacenamiento de alto rendimiento.


#### Ejecucción MariaDB
- En `C:\xampp\mysql\bin>dir mysql.exe` tenemos el ejecutable.
- Para ejecutarlo `mysql -u root -h localhost -p`, y entramos en MariaDB.
- _Saltamos al [tutorial](#tutorial-mariadb)_

## Administración y acceso
1. `USE <nombre_base_de_datos>;`: Cambiar a una base de datos específica.
- Con `use tienda;` accedemos a la base de datos 'tienda'
  
2. `SHOW TABLES;`: Mostrar las tablas dentro de la base de datos actual.
- Con `show tienda` mostramos las tablas dentro de 'tienda'

### PHPMyAdmin

- phpMyAdmin es una herramienta de administración basada en web para bases de datos MySQL o MariaDB.
- Proporciona una interfaz gráfica de usuario para administrar y manipular bases de datos, tablas, consultas, usuarios y privilegios.
- phpMyAdmin no es un servidor de base de datos por sí mismo, sino una aplicación web que se ejecuta en un servidor web.
- Facilita tareas como la creación de bases de datos y tablas, la ejecución de consultas SQL, la importación y exportación de datos, entre otras.
- **Es una herramienta que ayuda mucho al aprendizaje**, bastante intuitiva y facil de usar, aunque un poco anticuado su UX.

#### Acceso

- 1. **Inicia XAMPP:**

  Si estás utilizando XAMPP, primero asegúrate de que el servidor web Apache y el servidor de bases de datos MySQL o MariaDB estén en funcionamiento. Puedes iniciar XAMPP yendo a la carpeta de instalación de XAMPP y ejecutando el programa `xampp-control.exe` (en Windows) o utilizando los comandos apropiados en tu sistema operativo.

- 2. **Accede a phpMyAdmin:**

  Una vez que XAMPP esté en funcionamiento, abre tu navegador web y dirígete a la dirección [http://localhost/phpmyadmin/](http://localhost/phpmyadmin/). Esto te llevará a la página de inicio de sesión de phpMyAdmin.

- 3. **Otros:**
- Inicia sesión, **si requiere**:
En la página de inicio de sesión de phpMyAdmin, deberías ver un formulario de inicio de sesión. Por lo general, el nombre de usuario por defecto es "root" y la contraseña es en blanco. Sin embargo, si has configurado una contraseña diferente para el usuario "root" de MySQL o MariaDB, deberás ingresar esa contraseña.
- **Explora y administra tus bases de datos**

### MySQL
#### Iniciar MySQL

Para iniciar MySQL tenemos que tener parado XAMPP, ejecutar la aplicación `MySQL Workbench`. Y darle a conectar. 
_Si aparece un error, en el `administrador de tareas`, en `Servicios`, buscar `MySQL80`, y este **NO debe estar en `Detenido`**, si lo esta, cambiar a `en ejecucion`, con el boton derecho._

#### Uso de MySQL WorkBench
- En `file`, con `Open SQL script` podemos abrir archivos SQL.
- Una vez abierto el archivo, podemos ejecutarlo entero usando el boton de rayo.
- Si seleccionamos un Script o parte del codigo SQL y le damos al rayo, solo se ejecuta dicha parte.

## Tips

- En `C:\xampp` tenemos un archivo llamado `mysql_start` para iniciar el servidor, `mysql_stop` para pararlo. Incluso hay `killprocess`.
- A la hora de exportar, es importante marcar, para que automaticamente exporte la base de datos.
  _Sino abra que tener una base de datos con el mismo nombre?_
  ```opciones
     Agregar sentencia `CREATE DATABASE / USE` 
  ```
     [Esto nos dara como resultado este archivo](sql1.sql)
  
- Las bases de datos que lleva de por si, son bases de datos para el correcto funcionamiento de MySQL.

