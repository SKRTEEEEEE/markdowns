-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 03-04-2024 a las 12:30:33
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `tienda-moviles`
--
CREATE DATABASE IF NOT EXISTS `tienda-moviles` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `tienda-moviles`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clientes`
--

CREATE TABLE `clientes` (
  `id_clientes` int(5) NOT NULL,
  `nombre_cliente` varchar(30) NOT NULL,
  `apellido_cliente` varchar(30) NOT NULL,
  `cif_cliente` varchar(10) NOT NULL,
  `id_poblacion` int(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `clientes`
--

INSERT INTO `clientes` (`id_clientes`, `nombre_cliente`, `apellido_cliente`, `cif_cliente`, `id_poblacion`) VALUES
(1, 'Paco', 'Gomez', '78291356y', 2),
(2, 'Juan', 'Martin', '32167867t', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `facturas`
--

CREATE TABLE `facturas` (
  `id_factura` int(8) NOT NULL,
  `id_cliente` int(5) NOT NULL,
  `id_producto` int(5) NOT NULL,
  `cantidad_producto` int(11) NOT NULL,
  `total_factura` decimal(7,2) NOT NULL,
  `fecha_factura` date NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `facturas`
--

INSERT INTO `facturas` (`id_factura`, `id_cliente`, `id_producto`, `cantidad_producto`, `total_factura`, `fecha_factura`) VALUES
(0, 2, 1, 1, 170.00, '2024-04-03'),
(0, 1, 2, 1, 560.00, '2024-04-03');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `familias`
--

CREATE TABLE `familias` (
  `id_familia` int(5) NOT NULL,
  `nombre_familia` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `familias`
--

INSERT INTO `familias` (`id_familia`, `nombre_familia`) VALUES
(1, 'Xiaomi'),
(2, 'Samsung');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `poblaciones`
--

CREATE TABLE `poblaciones` (
  `id_poblacion` int(5) NOT NULL,
  `nombre_poblacion` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `poblaciones`
--

INSERT INTO `poblaciones` (`id_poblacion`, `nombre_poblacion`) VALUES
(1, 'Santa Coloma de Gramanet'),
(2, 'Barcelona');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos`
--

CREATE TABLE `productos` (
  `id_producto` int(5) NOT NULL,
  `nombre_producto` varchar(30) NOT NULL,
  `id_familia` int(5) NOT NULL,
  `precio_producto` decimal(6,2) NOT NULL,
  `iva_producto` decimal(3,2) NOT NULL,
  `id_proveedor` int(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `productos`
--

INSERT INTO `productos` (`id_producto`, `nombre_producto`, `id_familia`, `precio_producto`, `iva_producto`, `id_proveedor`) VALUES
(1, 'Redmi Note ', 1, 170.00, 9.99, 2),
(2, 'Galaxy S', 2, 560.00, 9.99, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proveedores`
--

CREATE TABLE `proveedores` (
  `id_proveedor` int(5) NOT NULL,
  `nombre_proveedor` varchar(30) NOT NULL,
  `id_problacion` int(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `proveedores`
--

INSERT INTO `proveedores` (`id_proveedor`, `nombre_proveedor`, `id_problacion`) VALUES
(1, 'Media Markt', 2),
(2, 'PacosDistribution', 2);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `clientes`
--
ALTER TABLE `clientes`
  ADD PRIMARY KEY (`id_clientes`),
  ADD KEY `id_poblacion_cliente` (`id_poblacion`);

--
-- Indices de la tabla `facturas`
--
ALTER TABLE `facturas`
  ADD KEY `id_cliente_factura` (`id_cliente`),
  ADD KEY `id_producto_factura` (`id_producto`);

--
-- Indices de la tabla `familias`
--
ALTER TABLE `familias`
  ADD PRIMARY KEY (`id_familia`);

--
-- Indices de la tabla `poblaciones`
--
ALTER TABLE `poblaciones`
  ADD PRIMARY KEY (`id_poblacion`);

--
-- Indices de la tabla `productos`
--
ALTER TABLE `productos`
  ADD PRIMARY KEY (`id_producto`),
  ADD KEY `id_familia_producto` (`id_familia`),
  ADD KEY `id_proveedor_producto` (`id_proveedor`);

--
-- Indices de la tabla `proveedores`
--
ALTER TABLE `proveedores`
  ADD PRIMARY KEY (`id_proveedor`),
  ADD KEY `id_poblacion_proveedor` (`id_problacion`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `clientes`
--
ALTER TABLE `clientes`
  MODIFY `id_clientes` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `familias`
--
ALTER TABLE `familias`
  MODIFY `id_familia` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `poblaciones`
--
ALTER TABLE `poblaciones`
  MODIFY `id_poblacion` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `productos`
--
ALTER TABLE `productos`
  MODIFY `id_producto` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `proveedores`
--
ALTER TABLE `proveedores`
  MODIFY `id_proveedor` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `clientes`
--
ALTER TABLE `clientes`
  ADD CONSTRAINT `id_poblacion_cliente` FOREIGN KEY (`id_poblacion`) REFERENCES `poblaciones` (`id_poblacion`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `facturas`
--
ALTER TABLE `facturas`
  ADD CONSTRAINT `id_cliente_factura` FOREIGN KEY (`id_cliente`) REFERENCES `clientes` (`id_clientes`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `id_producto_factura` FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id_producto`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `productos`
--
ALTER TABLE `productos`
  ADD CONSTRAINT `id_familia_producto` FOREIGN KEY (`id_familia`) REFERENCES `familias` (`id_familia`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `id_proveedor_producto` FOREIGN KEY (`id_proveedor`) REFERENCES `proveedores` (`id_proveedor`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `proveedores`
--
ALTER TABLE `proveedores`
  ADD CONSTRAINT `id_poblacion_proveedor` FOREIGN KEY (`id_problacion`) REFERENCES `poblaciones` (`id_poblacion`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
