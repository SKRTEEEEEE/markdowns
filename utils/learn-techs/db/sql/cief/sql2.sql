-- mostrar todas las bdd
show databases;
-- usar una bdd
use tienda_moviles;
-- mostrar toda la información de la tabla
SELECT * FROM productos;
-- mostrar sólo los valores de algunos campos (columnas)
SELECT nombre_producto, precio_producto from productos;
-- cambiar la cabecera de la salida por pantalla
SELECT nombre_producto as nombre, precio_producto as precio from productos;
-- Funciones de agregación
-- promedio
select avg(precio_producto) from productos;
-- max - min
SELECT MAX(precio_producto) FROM productos;
-- esta consulta devuelve mal la información
SELECT nombre_producto, max(precio_producto) from productos;
-- contar la cantidad de items
SELECT COUNT(*) FROM productos;
-- insertar un elemento
INSERT INTO productos (nombre_producto, id_familia_producto, precio_producto, id_proveedor) VALUES ('Oppo A52', 2, 500, 11);
-- ver los productos diferentes (DISTINCT)
SELECT DISTINCT nombre_producto FROM productos;
-- contar los productos diferentes
SELECT COUNT(distinct nombre_producto) FROM productos;
-- sumar los precios de todos los productos
SELECT SUM(precio_producto) FROM productos;
-- seleccionar la lista clientes
SELECT * FROM clientes;
-- ordenar la lista clientes segun criterio
-- en este caso solo ordena por apellido
SELECT apellido_cliente, nombre_cliente
FROM clientes
ORDER BY apellido_cliente ASC;
-- para ordenar por apellido y nombre
SELECT apellido_cliente, nombre_cliente
FROM clientes
ORDER BY apellido_cliente ASC, nombre_cliente ASC;
-- limitar las filas de la lista de datos
SELECT apellido_cliente, nombre_cliente
FROM clientes
ORDER BY apellido_cliente ASC, nombre_cliente ASC
LIMIT 3;
-- poner condiciones a las listas (LIKE)
-- "A" al principio, de
SELECT nombre_cliente
FROM clientes
WHERE nombre_cliente LIKE "A%";
-- "a" en cualquier punto, de
SELECT nombre_cliente
FROM clientes
WHERE nombre_cliente LIKE "%a%";
-- "a" en el segundo espacio, de
SELECT nombre_cliente
FROM clientes
WHERE nombre_cliente LIKE "_a%";
-- "a" en el tercer espacio, de
SELECT nombre_cliente
FROM clientes
WHERE nombre_cliente LIKE "__a%";
-- "an" en el tercer espacio, de
SELECT nombre_cliente
FROM clientes
WHERE nombre_cliente LIKE "__an%";
-- "a" en el primer espacio o "j" en el primer espacio (OR), de
SELECT nombre_cliente
FROM clientes
WHERE nombre_cliente LIKE 'A%' OR nombre_cliente LIKE 'J%';
-- filtramos segun ciertos criterio (IN)
SELECT *
FROM productos 
WHERE id_familia_producto IN (1, 3, 5);
-- filtramos segun los que NO tengan cierto criterio
SELECT *
FROM productos 
WHERE id_familia_producto NOT IN (1, 3, 5);
-- selección por rango (BETWEEN) de precio
SELECT nombre_producto, precio_producto
FROM productos
WHERE precio_producto BETWEEN 800 AND 1500;
-- selección segun rango mayor (<, >)
SELECT nombre_producto, precio_producto
FROM productos
WHERE precio_producto > 1200;
-- top cinco mas caros, nombre y precio
SELECT nombre_producto, precio_producto
FROM productos
order by precio_producto DESC
LIMIT 5;
-- top cinco precios mas caros, nombre y precio(GROUP BY)
SELECT nombre_producto, precio_producto
FROM productos
group by precio_producto
order by precio_producto DESC
LIMIT 5;
-- lista de productos por categorias
SELECT id_familia_producto, count(id_familia_producto)
FROM productos
group by id_familia_producto
order by id_familia_producto ASC;

-- de cada familia de productos cual es el precio mas alto
SELECT id_familia_producto, MAX(precio_producto)
FROM productos
-- el GROUP BY junta todos los que tienen el mismo id_familia
group by id_familia_producto
order by id_familia_producto ASC;

-- HAVING
SELECT nombre_producto, precio_producto
FROM productos
GROUP BY precio_producto
HAVING precio_producto > (SELECT AVG(precio_producto) FROM productos);

-- INNER JOIN
select fa.nombre_familia, pr.nombre_producto
from productos pr
inner join familia_producto fa
on pr.id_familia_producto = fa.id_familia_producto
order by fa.nombre_familia ASC;

-- de facturas, obtener, cantidad nombre precio
select fa.id_factura, pr.nombre_producto, fa.cantidad, pr.precio_producto,
(pr.precio_producto * fa.cantidad * (1 + pr.iva_producto)) as total
from facturas fa
inner join productos pr
on fa.id_producto = pr.id_producto
order by fa.id_factura ASC;
 
-- en la factura añadir quien es el dueño
select fa.id_factura, pr.nombre_producto, fa.cantidad, pr.precio_producto,
(pr.precio_producto * fa.cantidad * (1 + pr.iva_producto)) as total,
cl.nombre_cliente, cl.apellido_cliente
from facturas fa
inner join productos pr
on fa.id_producto = pr.id_producto
inner join clientes cl
on fa.id_cliente = cl.id_cliente
order by fa.id_factura ASC;

-- ver el total que ha comprado cada cliente
select concat(cl.nombre_cliente," ", cl.apellido_cliente),
SUM(pr.precio_producto * fa.cantidad * (1 + pr.iva_producto)) AS total_comprado
from facturas fa
inner join productos pr
on fa.id_producto = pr.id_producto
inner join clientes cl
on fa.id_cliente = cl.id_cliente
group by  cl.id_cliente
order by fa.id_factura ASC;

-- clientes que no han comprado nada (LEFT JOIN)
select concat(cl.nombre_cliente," ", cl.apellido_cliente), cl.id_cliente
from clientes cl
left join facturas fa
on cl.id_cliente = fa.id_cliente
where fa.id_cliente IS NULL; -- verifica que en el lado derecho este id es nulo, porque no existe, no ha comprado nada

-- ver el total que ha vendido cada proveedor, i el top
select prv.nombre_proveedor,
SUM(prd.precio_producto * fa.cantidad * (1 + prd.iva_producto)) AS total_comprado
from productos prd
inner join facturas fa
on prd.id_producto = fa.id_producto
inner join proveedores prv
on prd.id_proveedor = prv.id_proveedor
group by  prv.nombre_proveedor;

-- en que sitios se vende mas
select pb.nombre_poblacion,
SUM(pr.precio_producto * fa.cantidad ) AS total_comprado
from facturas fa
inner join productos pr
on fa.id_producto = pr.id_producto
inner join clientes cl
on fa.id_cliente = cl.id_cliente
inner join poblaciones pb
on cl.id_poblaciones = pb.id_poblaciones
group by  pb.id_poblaciones
order by total_comprado DESC;

-- en que sitios no se vende nada

-- información de la fidelidad de los clientes

SELECT cl.nombre_cliente, 
       COUNT(fa.id_factura) as compras,
       CASE
           WHEN COUNT(fa.id_factura) > 10 THEN "Compra mucho"
           WHEN COUNT(fa.id_factura) < 10 THEN "Compra poco"
           ELSE "Compra muy poco"
       END as fidelidad
FROM clientes cl
LEFT JOIN facturas fa ON fa.id_cliente = cl.id_cliente
GROUP BY cl.nombre_cliente
ORDER BY cl.nombre_cliente ASC;


