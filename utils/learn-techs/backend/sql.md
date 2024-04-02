# SQL

Bases de datos relacionales, basada en tablas. 
_Las bases de datos que lleva de por si, son bases de datos para el correcto funcionamiento de MySQL._

- Cuentas de ususarios, podemos asignar nuevos usuarios y darle roles o modificar-los.
- Exportar, podemos compartir información en varios tipos de formatos.
- Importar, podemos importar bases de datos

Podemos crear una base de datos, la cual dentro va a tener tablas.

**Es case sensitive para los valores no para las instrucciones**

## Tipos

Varchar vs char -> _Le limitamos el numero de bytes que va a agarrar*_

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

En `C:\xampp\mysql\bin>dir mysql.exe` tenemos el ejecutable.
Para ejecutarlo `mysql -u root -h localhost -p`, y entramos en MariaDB.
_Saltamos a [tutorial](#tutorial)_
_Hemos de ir con cuidado al reasignar un id_alumno porque en este caso es la `PRIMARY KEY` y no podra aver dos identicos?_

### Delete
`DELETE FROM alumnos` -> Limpiamos o vaciamos tabla alumnos
` DROP TABLE alumnos` -> Borramos tabla alumnos
`DROP DATABASE escuela;` -> Borrar base de datos escuela

### Acceso

Con `use tienda;` accedemos a la base de datos 'tienda'
Con `show tienda` mostramos las tablas dentro de 'tienda'

### Tutorial 

En MariaDB ponemos `show databases;` nos muestra las bases de datos. 
`create database escuela;` para crear una nueva base de datos llamada escuela.
`use escuela` para entrar dentro de la tabla.
Para crear una nueva tabla:
```sql
create table `alumnos` (`id_alumno` INT(2) NOT NULL AUTO_INCREMENT, `nombre` VARCHAR(20), PRIMARY KEY(id_alumno) );
```
Con `INSERT INTO alumnos (nombre) VALUES ('Maria');` insertamos un alumno llamado Maria
Con `INSERT INTO alumnos (nombre) VALUES ('Marta'), ('Pepe'), ('Juan');` insertamos un grupo de alumnos(varios values)
Con `DELETE FROM alumnos WHERE id_alumno = 3;` eliminamos el alumno con el id 3
Con `show tables;` mostramos las tablas
Con `DELETE FROM alumnos WHERE nombre = 'Marta';` eliminamos los alumnos con ese nombre
Con `SELECT nombre FROM alumnos WHERE nombre LIKE 'J%';` seleccionamos los alumnos que empiezan con J
Con `SELECT nombre FROM alumnos WHERE nombre LIKE '_a%';` seleccionamos los alumnos que tengas `a` como segunda letra
Con `UPDATE alumnos SET nombre = "Bill" WHERE id_alumno = 7;` modificamos el alumno 7 por Bill.
Asi `INSERT INTO alumnos (id_alumno, nombre) VALUES (3, "Sofia");` introducimos varios datos a la vez.


## Tips

En `C:\xampp` tenemos un archivo llamado `mysql_start` para iniciar el servidor, `mysql_stop` para pararlo. Incluso hay `killprocess`.


