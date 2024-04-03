# SQL

Bases de datos relacionales, basada en tablas. 

- Cuentas de ususarios, podemos asignar nuevos usuarios y darle roles o modificar-los.
- Exportar, podemos compartir información en varios tipos de formatos.
- Importar, podemos importar bases de datos

Podemos crear una base de datos, la cual dentro va a tener tablas.

**Es case sensitive para los valores no para las instrucciones**

## Tipos de datos

Explicacion de los principales tipos de datos en SQL:

### 1. VARCHAR(n):

- Almacena cadenas de caracteres de longitud variable.
- Se especifica una longitud máxima n que puede variar de 1 a 65,535 caracteres.
- Utilizado para almacenar texto de longitud variable, como nombres, direcciones, descripciones, etc.

### 2. INT:

- Almacena números enteros.
- Puede ser de diferentes tamaños, como INT (4 bytes) o BIGINT (8 bytes), dependiendo del rango de valores que necesites almacenar.
- Utilizado para almacenar números enteros, como identificadores, cantidades, índices, etc.

### 3. DECIMAL(p, s):

- Almacena números decimales de precisión fija.
- Se especifican dos parámetros: p que representa la precisión total y s que representa la escala (número de dígitos después del punto decimal).
- Utilizado para almacenar valores monetarios u otros valores que requieren precisión decimal exacta.

### 4. DATE:

- Almacena fechas en formato 'YYYY-MM-DD'.
- Utilizado para almacenar fechas sin información sobre la hora.

### 5. TIME:

- Almacena horas en formato 'HH:MM:SS'.
- Utilizado para almacenar horas del día.

### 6. DATETIME o TIMESTAMP:

- Almacena fechas y horas en formato 'YYYY-MM-DD HH:MM:SS'.
- TIMESTAMP a menudo se usa para almacenar la fecha y hora de la creación o modificación de un registro automáticamente.

### 7. BOOLEAN o BOOL:

- Almacena valores de verdad, que pueden ser TRUE, FALSE o NULL.
- Utilizado para representar valores lógicos, como verdadero o falso.

### 8. BLOB y TEXT:

- Almacena datos binarios grandes (BLOB) o cadenas de texto largas (TEXT).
- BLOB se usa para datos binarios como imágenes o archivos, mientras que TEXT se usa para texto largo como documentos o descripciones extensas.

## CRUD

### Insert (Create)

Esto es una sentencia basica para insertar datos. 

```sql
INSERT INTO `productos`(`id_productos`, `nombre`, `descripcion`, `fecha`) VALUES ('[value-1]','[value-2]','[value-3]','[value-4]')
```

Podemos prescindir de id_productos ya se que se autoincrementa
La fecha tambien podemos prescindir ya que se pone automaticamente, si pusieramos algo se sobreescribiria.

```sql
INSERT INTO `productos`( `nombre`, `descripcion`) 
VALUES ('peras','peras ecologicas de temporada muy ricas')
```

### Select (Read)

Esto es una sentencia basica para leer datos:
```sql
SELECT * FROM productos WHERE nombre = "manzanas"
```

### Update 

Podemos sobreescribir la informacion desde phpMyAdmin (como si fuera una tabla, clicando encima) o con el siguiente comando SQL:

```sql
UPDATE `productos` SET `description` = 'Manzanas ecológicas de temporada, muy frescas' WHERE `productos`.`id_productos` = 1
```

### Delete

Podemos eliminar la informacion desde phpMyAdmin (como si fuera una tabla, clicando encima) o con el siguiente comando SQL:

```sql
DELETE FROM productos WHERE `productos`.`id_productos` = 1
```

## MariaDB

### Ejecucción

- En `C:\xampp\mysql\bin>dir mysql.exe` tenemos el ejecutable.
- Para ejecutarlo `mysql -u root -h localhost -p`, y entramos en MariaDB.
_Saltamos a [tutorial](#tutorial)_
_Hemos de ir con cuidado al reasignar un id_alumno porque en este caso es la `PRIMARY KEY` y no podra aver dos identicos?_

### Delete
- `DELETE FROM alumnos` -> Limpiamos o vaciamos tabla alumnos
- ` DROP TABLE alumnos` -> Borramos tabla alumnos
- `DROP DATABASE escuela;` -> Borrar base de datos escuela

### Acceso

- Con `use tienda;` accedemos a la base de datos 'tienda'
- Con `show tienda` mostramos las tablas dentro de 'tienda'

### Contar

Podemos usar el count para saber la cantidad de algo dentro de la tabla

```sql
SELECT COUNT(*) FROM productos;
```

Por ejemplo aqui contariamos cuantos productos distintos hay

```sql
SELECT COUNT(DISTINCT*) FROM productos;
```

### Alterar
Alterar una tabla ya existente:

```sql
ALTER TABLE 'productos' ADD 'precio' DECIMAL(5,2)NOT NULL AFTER 'fecha', ADD 'IVA' DECIMAL(3,2) NOT NULL DEFAULT '0.03' AFTER 'precio';
```

### Operadores

- `UPDATE productos SET IVA="0.10" WHERE fecha!="2024-03-30";`, diferente a `!=`
- `UPDATE productos SET IVA="0.10" WHERE fecha > "2024-03-31"` mayor que `>` o menor que `<`

### Funciones matematicas

- `SELECT precio FROM productos ORDER BY precio DESC LIMIT 1;` -> `SELECT MAX(precio) FROM productos;`, nos mostrara el maximo de un valor(en este caso precio)
- `SELECT AVG(precio) FROM productos;` nos mostrara el promedio "average" de un valor(en este caso precio)

## Relaciones

Cuando haya información que se repita mucho, podemos usar relaciones.

#### Foreign key

- Una clave primaria es un campo o un conjunto de campos en una tabla de una base de datos relacional que identifica de forma única cada fila en esa tabla.
- La clave primaria garantiza la integridad de los datos al evitar la inserción de registros duplicados.
- Por lo general, la clave primaria se utiliza para establecer relaciones entre tablas. Cada tabla debe tener una y solo una clave primaria.
- En la mayoría de los sistemas de gestión de bases de datos (DBMS), las claves primarias son automáticamente únicas y no nulas.

#### Primary key

- Una clave foránea es un campo en una tabla que hace referencia a la clave primaria de otra tabla. Establece una relación entre dos tablas.
- La clave foránea asegura la integridad referencial, lo que significa que los valores en la columna de la clave foránea deben coincidir con los valores en la columna de la clave primaria de la tabla referenciada.
- Las claves foráneas se utilizan para establecer relaciones entre tablas, permitiendo consultas y operaciones que involucran datos de varias tablas.
- Puede haber múltiples claves foráneas en una tabla, y estas pueden hacer referencia a la misma tabla o a diferentes tablas.

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

### Tutorial MariaDB

- En MariaDB ponemos `show databases;` nos muestra las bases de datos.
- `create database escuela;` para crear una nueva base de datos llamada escuela.
- `use escuela` para entrar dentro de la tabla.
- Para crear una nueva tabla:
```sql
create table `alumnos` (`id_alumno` INT(2) NOT NULL AUTO_INCREMENT, `nombre` VARCHAR(20), PRIMARY KEY(id_alumno) );
```
- `INSERT INTO alumnos (nombre) VALUES ('Maria');` insertamos un alumno llamado Maria
- `INSERT INTO alumnos (nombre) VALUES ('Marta'), ('Pepe'), ('Juan');` insertamos un grupo de alumnos(varios values)
- `DELETE FROM alumnos WHERE id_alumno = 3;` eliminamos el alumno con el id 3
- `show tables;` mostramos las tablas
- `DELETE FROM alumnos WHERE nombre = 'Marta';` eliminamos los alumnos con ese nombre
- `SELECT nombre FROM alumnos WHERE nombre LIKE 'J%';` seleccionamos los alumnos que empiezan con J
- `SELECT nombre FROM alumnos WHERE nombre LIKE '_a%';` seleccionamos los alumnos que tengas `a` como segunda letra
- `UPDATE alumnos SET nombre = "Bill" WHERE id_alumno = 7;` modificamos el alumno 7 por Bill.
- `INSERT INTO alumnos (id_alumno, nombre) VALUES (3, "Sofia");` introducimos varios datos a la vez.
- `SELECT nombre, fecha FROM productos ORDER BY fecha DESC, nombre ASC;` nos muestra todos los productos ordenador por fecha, de forma descendente, cuando haya empate, que los ordene por nombre y ascendente.
- `SELECT nombre, fecha FROM productos ORDER BY fecha DESC, nombre ASC LIMIT 2;` lo mismo que lo anterior pero limitandolo a los dos primeros resualtados.
- Con el siguiente query creamos una tabla relacional:
    ```sql
    CREATE TABLE `tienda-test`.`facturas` (
        `id_factura` INT NOT NULL AUTO_INCREMENT,
        `id_cliente` INT NOT NULL,
        `id_producto` INT NOT NULL,
        `unidades` INT NOT NULL,
        `total` INT NOT NULL,
        `IVA` INT NOT NULL,
        `fecha_venta` DATE NOT NULL DEFAULT CURRENT_TIMESTAMP,
        PRIMARY KEY (`id_factura`),
        FOREIGN KEY (`id_producto`) REFERENCES `productos`(`id_producto`),
        FOREIGN KEY (`id_cliente`) REFERENCES `clientes`(`id_cliente`)
    ) ENGINE = InnoDB;
    ```
- Con el siguiente query relacionamos los id entre las tablas:
  ```sql
  -- Añadir la columna precio\producto a la tabla de facturas 
      ALTER TABLE `facturas` ADD `precio_producto` INT NOT NULL AFTER `fecha_venta`; 
  -- Actualizar el precio\producto con el precio del producto correspondiente 
      UPDATE `facturas` AS f 
      INNER JOIN `productos` AS p ON f.`id_producto` = p.`id_producto` SET f.`precio_producto` = p.`precio`;
  ```
_Primero agregamos la columna `precio_producto` a la tabla de facturas. Luego, utilizamos una consulta `UPDATE` para asignar el precio del producto correspondiente al `id_producto` en la tabla de productos a la columna `precio_producto` en la tabla de facturas. Utilizamos un `INNER JOIN` para combinar las filas de ambas tablas en función del `id_producto`._

Ejemplo tablas relacionadas entre si:

![sql1.png](../../../img/tutos/sql1.png)
"Export/querys" de dichas tablas:
[sql1.sql](sql1.sql)

## Tips

- En `C:\xampp` tenemos un archivo llamado `mysql_start` para iniciar el servidor, `mysql_stop` para pararlo. Incluso hay `killprocess`.
- A la hora de exportar, es importante marcar, para que automaticamente exporte la base de datos.
  
  _Sino abra que tener una base de datos con el mismo nombre?_
  
  [Esto nos dara como resultado este archivo](sql1.sql)
  
    ```opciones
     Agregar sentencia `CREATE DATABASE / USE` 
     ```

- Las bases de datos que lleva de por si, son bases de datos para el correcto funcionamiento de MySQL.

_Las personas de barcelona que han comprado y mostrar que han comprado, mostrar la factura_

