-- =============================================================================
-- DATOS SEMILLA (SEEDS) — SYSELL Web v2.0
-- Proyecto: Sistema de Gestión Comercial — Tienda de Ropa para Varón (Machi's)
-- =============================================================================

SET NAMES utf8mb4;

-- 1. Locales Comerciales Físicos
INSERT INTO `locales` (`id`, `nombre`, `direccion`, `telefono`, `latitud`, `longitud`, `activo`) VALUES
(1, 'Local Principal - Av. San Martín', 'Av. San Martín N° 450, Tacna, Perú', '052-412345', -18.01345600, -70.25123400, 1),
(2, 'Sucursal Mall - Av. Bolognesi', 'Av. Bolognesi N° 820, Tacna, Perú', '052-429876', -18.01678900, -70.24890100, 1)
ON DUPLICATE KEY UPDATE `nombre` = VALUES(`nombre`);

-- 2. Usuario Administrador Inicial (password: Admin1234! cifrada con Bcrypt)
INSERT INTO `usuarios` (`id`, `local_id`, `nombre_completo`, `username`, `password_hash`, `rol`, `intentos_fallidos`, `bloqueado`, `activo`) VALUES
(1, NULL, 'Administrador General', 'admin', '$2y$12$e6mZ7yVd7m78U1k1KzUfjeY6a6D8k1QdG7h1wP0q3T4y6w7x8z9A.', 'ADMINISTRADOR', 0, 0, 1),
(2, 1, 'Vendedor Tienda Principal', 'vendedor1', '$2y$12$e6mZ7yVd7m78U1k1KzUfjeY6a6D8k1QdG7h1wP0q3T4y6w7x8z9A.', 'VENDEDOR', 0, 0, 1),
(3, 2, 'Vendedor Sucursal Mall', 'vendedor2', '$2y$12$e6mZ7yVd7m78U1k1KzUfjeY6a6D8k1QdG7h1wP0q3T4y6w7x8z9A.', 'VENDEDOR', 0, 0, 1)
ON DUPLICATE KEY UPDATE `username` = VALUES(`username`);

-- 3. Catálogo Maestro: Categorías de Ropa Masculina
INSERT INTO `categorias` (`id`, `nombre`, `descripcion`, `activo`) VALUES
(1, 'Camisas', 'Camisas formales, casuales y de manga corta', 1),
(2, 'Pantalones', 'Pantalones de vestir, jeans y joggers', 1),
(3, 'Polos', 'Polos de algodón pima, cuello camisero y cuello redondo', 1),
(4, 'Casacas y Chompas', 'Casacas de cuero, impermeables y chompas de lana', 1),
(5, 'Bermudas y Shorts', 'Bermudas casuales y shorts de verano', 1),
(6, 'Ternos y Sacos', 'Sacos formales, blazers y ternos completos', 1)
ON DUPLICATE KEY UPDATE `nombre` = VALUES(`nombre`);

-- 4. Catálogo Maestro: Marcas Comerciales
INSERT INTO `marcas` (`id`, `nombre`, `activo`) VALUES
(1, 'Machi\'s Collection', 1),
(2, 'Dockers', 1),
(3, 'Levi\'s', 1),
(4, 'Polo Ralph Lauren', 1),
(5, 'Tommy Hilfiger', 1),
(6, 'Zara Man', 1),
(7, 'Boston', 1)
ON DUPLICATE KEY UPDATE `nombre` = VALUES(`nombre`);

-- 5. Catálogo Maestro: Tallas Estandarizadas
INSERT INTO `tallas` (`id`, `nombre`, `activo`) VALUES
(1, 'S', 1),
(2, 'M', 1),
(3, 'L', 1),
(4, 'XL', 1),
(5, 'XXL', 1),
(6, '28', 1),
(7, '30', 1),
(8, '32', 1),
(9, '34', 1),
(10, '36', 1)
ON DUPLICATE KEY UPDATE `nombre` = VALUES(`nombre`);

-- 6. Catálogo Maestro: Colores con Código Hexadecimal Web
INSERT INTO `colores` (`id`, `nombre`, `codigo_hex`, `activo`) VALUES
(1, 'Negro', '#000000', 1),
(2, 'Blanco', '#FFFFFF', 1),
(3, 'Azul Marino', '#000080', 1),
(4, 'Gris Plomo', '#4A4A4A', 1),
(5, 'Azul Celeste', '#87CEEB', 1),
(6, 'Vino / Borgoña', '#5E1914', 1),
(7, 'Verde Militar', '#4B5320', 1),
(8, 'Beige', '#F5F5DC', 1)
ON DUPLICATE KEY UPDATE `nombre` = VALUES(`nombre`);

-- 7. Métodos de Pago Habilitados
INSERT INTO `metodos_pago` (`id`, `nombre`, `activo`) VALUES
(1, 'Efectivo', 1),
(2, 'Yape', 1),
(3, 'Plin', 1),
(4, 'Tarjeta de Débito', 1),
(5, 'Tarjeta de Crédito', 1)
ON DUPLICATE KEY UPDATE `nombre` = VALUES(`nombre`);
