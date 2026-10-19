-- =============================================================================
-- ESQUEMA DE BASE DE DATOS RELACIONAL — SYSELL Web v2.0
-- Proyecto: Sistema de Gestión Comercial — Tienda de Ropa para Varón (Machi's)
-- Motor: MySQL 8.0 (InnoDB) | Codificación: utf8mb4_unicode_ci
-- Total de Tablas: 17 Tablas en Tercera Forma Normal (3FN)
-- =============================================================================

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- -----------------------------------------------------------------------------
-- 1. Tabla: locales (Tiendas Físicas)
-- -----------------------------------------------------------------------------
DROP TABLE IF EXISTS `locales`;
CREATE TABLE `locales` (
    `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `nombre` VARCHAR(100) NOT NULL UNIQUE,
    `direccion` VARCHAR(255) NOT NULL,
    `telefono` VARCHAR(20) NULL,
    `latitud` DECIMAL(10, 8) NULL,
    `longitud` DECIMAL(11, 8) NULL,
    `activo` TINYINT(1) NOT NULL DEFAULT 1,
    `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX `idx_locales_activo` (`activo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -----------------------------------------------------------------------------
-- 2. Tabla: usuarios (Cuentas, Roles y Control de Seguridad)
-- -----------------------------------------------------------------------------
DROP TABLE IF EXISTS `usuarios`;
CREATE TABLE `usuarios` (
    `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `local_id` BIGINT UNSIGNED NULL,
    `nombre_completo` VARCHAR(150) NOT NULL,
    `username` VARCHAR(50) NOT NULL UNIQUE,
    `password_hash` VARCHAR(255) NOT NULL,
    `rol` ENUM('ADMINISTRADOR', 'VENDEDOR') NOT NULL,
    `intentos_fallidos` TINYINT UNSIGNED NOT NULL DEFAULT 0,
    `bloqueado` TINYINT(1) NOT NULL DEFAULT 0,
    `activo` TINYINT(1) NOT NULL DEFAULT 1,
    `ultimo_acceso` TIMESTAMP NULL,
    `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT `fk_usuarios_local` FOREIGN KEY (`local_id`) 
        REFERENCES `locales` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
    INDEX `idx_usuarios_username` (`username`),
    INDEX `idx_usuarios_rol` (`rol`),
    INDEX `idx_usuarios_activo` (`activo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -----------------------------------------------------------------------------
-- 3. Tabla: categorias (Catálogo Maestro Cerrado - RF-74)
-- -----------------------------------------------------------------------------
DROP TABLE IF EXISTS `categorias`;
CREATE TABLE `categorias` (
    `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `nombre` VARCHAR(80) NOT NULL UNIQUE,
    `descripcion` VARCHAR(255) NULL,
    `activo` TINYINT(1) NOT NULL DEFAULT 1,
    `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX `idx_categorias_activo` (`activo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -----------------------------------------------------------------------------
-- 4. Tabla: marcas (Catálogo Maestro Cerrado - RF-74)
-- -----------------------------------------------------------------------------
DROP TABLE IF EXISTS `marcas`;
CREATE TABLE `marcas` (
    `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `nombre` VARCHAR(80) NOT NULL UNIQUE,
    `activo` TINYINT(1) NOT NULL DEFAULT 1,
    `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX `idx_marcas_activo` (`activo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -----------------------------------------------------------------------------
-- 5. Tabla: tallas (Catálogo Maestro Cerrado - RF-74)
-- -----------------------------------------------------------------------------
DROP TABLE IF EXISTS `tallas`;
CREATE TABLE `tallas` (
    `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `nombre` VARCHAR(20) NOT NULL UNIQUE,
    `activo` TINYINT(1) NOT NULL DEFAULT 1,
    `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX `idx_tallas_activo` (`activo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -----------------------------------------------------------------------------
-- 6. Tabla: colores (Catálogo Maestro Cerrado - RF-74)
-- -----------------------------------------------------------------------------
DROP TABLE IF EXISTS `colores`;
CREATE TABLE `colores` (
    `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `nombre` VARCHAR(50) NOT NULL UNIQUE,
    `codigo_hex` VARCHAR(7) NULL,
    `activo` TINYINT(1) NOT NULL DEFAULT 1,
    `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX `idx_colores_activo` (`activo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -----------------------------------------------------------------------------
-- 7. Tabla: metodos_pago (Catálogo Maestro de Cobro)
-- -----------------------------------------------------------------------------
DROP TABLE IF EXISTS `metodos_pago`;
CREATE TABLE `metodos_pago` (
    `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `nombre` VARCHAR(50) NOT NULL UNIQUE,
    `activo` TINYINT(1) NOT NULL DEFAULT 1,
    `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX `idx_metodos_pago_activo` (`activo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -----------------------------------------------------------------------------
-- 8. Tabla: productos (Prenda Base Masculina)
-- -----------------------------------------------------------------------------
DROP TABLE IF EXISTS `productos`;
CREATE TABLE `productos` (
    `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `categoria_id` BIGINT UNSIGNED NOT NULL,
    `marca_id` BIGINT UNSIGNED NOT NULL,
    `codigo_modelo` VARCHAR(50) NOT NULL UNIQUE,
    `nombre` VARCHAR(150) NOT NULL,
    `descripcion` TEXT NULL,
    `precio_compra` DECIMAL(10, 2) NOT NULL,
    `precio_venta` DECIMAL(10, 2) NOT NULL,
    `imagen_url` VARCHAR(255) NULL,
    `activo` TINYINT(1) NOT NULL DEFAULT 1,
    `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT `fk_productos_categoria` FOREIGN KEY (`categoria_id`) 
        REFERENCES `categorias` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT `fk_productos_marca` FOREIGN KEY (`marca_id`) 
        REFERENCES `marcas` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
    INDEX `idx_productos_modelo` (`codigo_modelo`),
    INDEX `idx_productos_nombre` (`nombre`),
    INDEX `idx_productos_activo` (`activo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -----------------------------------------------------------------------------
-- 9. Tabla: imagenes_producto (Galería HD de Prendas - RF-69)
-- -----------------------------------------------------------------------------
DROP TABLE IF EXISTS `imagenes_producto`;
CREATE TABLE `imagenes_producto` (
    `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `producto_id` BIGINT UNSIGNED NOT NULL,
    `url` VARCHAR(512) NOT NULL,
    `orden` TINYINT UNSIGNED NOT NULL DEFAULT 0,
    `activo` TINYINT(1) NOT NULL DEFAULT 1,
    `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT `fk_imagenes_producto` FOREIGN KEY (`producto_id`) 
        REFERENCES `productos` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    INDEX `idx_imagenes_producto` (`producto_id`, `orden`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -----------------------------------------------------------------------------
-- 10. Tabla: variantes_producto (Combinación Talla, Color, SKU y Código de Barras)
-- -----------------------------------------------------------------------------
DROP TABLE IF EXISTS `variantes_producto`;
CREATE TABLE `variantes_producto` (
    `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `producto_id` BIGINT UNSIGNED NOT NULL,
    `talla_id` BIGINT UNSIGNED NOT NULL,
    `color_id` BIGINT UNSIGNED NOT NULL,
    `sku` VARCHAR(60) NOT NULL UNIQUE,
    `codigo_barras` VARCHAR(60) NULL UNIQUE,
    `activo` TINYINT(1) NOT NULL DEFAULT 1,
    `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT `fk_variantes_producto` FOREIGN KEY (`producto_id`) 
        REFERENCES `productos` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `fk_variantes_talla` FOREIGN KEY (`talla_id`) 
        REFERENCES `tallas` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT `fk_variantes_color` FOREIGN KEY (`color_id`) 
        REFERENCES `colores` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
    UNIQUE KEY `uk_producto_talla_color` (`producto_id`, `talla_id`, `color_id`),
    INDEX `idx_variantes_sku` (`sku`),
    INDEX `idx_variantes_barras` (`codigo_barras`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -----------------------------------------------------------------------------
-- 11. Tabla: inventario (Existencias Físicas Multilocal - RF-19, RF-22)
-- -----------------------------------------------------------------------------
DROP TABLE IF EXISTS `inventario`;
CREATE TABLE `inventario` (
    `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `local_id` BIGINT UNSIGNED NOT NULL,
    `variante_id` BIGINT UNSIGNED NOT NULL,
    `stock_actual` INT NOT NULL DEFAULT 0,
    `stock_minimo` INT NOT NULL DEFAULT 5,
    `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT `fk_inventario_local` FOREIGN KEY (`local_id`) 
        REFERENCES `locales` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `fk_inventario_variante` FOREIGN KEY (`variante_id`) 
        REFERENCES `variantes_producto` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    UNIQUE KEY `uk_local_variante` (`local_id`, `variante_id`),
    INDEX `idx_inventario_stock` (`stock_actual`),
    INDEX `idx_inventario_minimo` (`stock_minimo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -----------------------------------------------------------------------------
-- 12. Tabla: ventas (Transacción de Venta en Mostrador - RF-47, RF-48, RF-76)
-- -----------------------------------------------------------------------------
DROP TABLE IF EXISTS `ventas`;
CREATE TABLE `ventas` (
    `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `numero_ticket` VARCHAR(30) NOT NULL UNIQUE,
    `local_id` BIGINT UNSIGNED NOT NULL,
    `usuario_id` BIGINT UNSIGNED NOT NULL,
    `subtotal` DECIMAL(10, 2) NOT NULL,
    `total` DECIMAL(10, 2) NOT NULL,
    `fecha_venta` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `sincronizado_nube` TINYINT(1) NOT NULL DEFAULT 1,
    `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT `fk_ventas_local` FOREIGN KEY (`local_id`) 
        REFERENCES `locales` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT `fk_ventas_usuario` FOREIGN KEY (`usuario_id`) 
        REFERENCES `usuarios` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
    INDEX `idx_ventas_ticket` (`numero_ticket`),
    INDEX `idx_ventas_fecha` (`fecha_venta`),
    INDEX `idx_ventas_local_fecha` (`local_id`, `fecha_venta`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -----------------------------------------------------------------------------
-- 13. Tabla: detalle_ventas (Líneas de Prendas Vendidas)
-- -----------------------------------------------------------------------------
DROP TABLE IF EXISTS `detalle_ventas`;
CREATE TABLE `detalle_ventas` (
    `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `venta_id` BIGINT UNSIGNED NOT NULL,
    `variante_id` BIGINT UNSIGNED NOT NULL,
    `cantidad` INT UNSIGNED NOT NULL,
    `precio_unitario` DECIMAL(10, 2) NOT NULL,
    `costo_unitario` DECIMAL(10, 2) NOT NULL,
    `subtotal` DECIMAL(10, 2) NOT NULL,
    CONSTRAINT `fk_detalle_venta` FOREIGN KEY (`venta_id`) 
        REFERENCES `ventas` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `fk_detalle_variante` FOREIGN KEY (`variante_id`) 
        REFERENCES `variantes_producto` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
    INDEX `idx_detalle_venta` (`venta_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -----------------------------------------------------------------------------
-- 14. Tabla: pagos_venta (Liquidación Multitendencia - RF-45, RF-46)
-- -----------------------------------------------------------------------------
DROP TABLE IF EXISTS `pagos_venta`;
CREATE TABLE `pagos_venta` (
    `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `venta_id` BIGINT UNSIGNED NOT NULL,
    `metodo_pago_id` BIGINT UNSIGNED NOT NULL,
    `monto` DECIMAL(10, 2) NOT NULL,
    `referencia` VARCHAR(100) NULL,
    CONSTRAINT `fk_pagos_venta` FOREIGN KEY (`venta_id`) 
        REFERENCES `ventas` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `fk_pagos_metodo` FOREIGN KEY (`metodo_pago_id`) 
        REFERENCES `metodos_pago` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
    INDEX `idx_pagos_venta` (`venta_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -----------------------------------------------------------------------------
-- 15. Tabla: ajustes_inventario (Kardex y Variaciones de Stock - RF-20)
-- -----------------------------------------------------------------------------
DROP TABLE IF EXISTS `ajustes_inventario`;
CREATE TABLE `ajustes_inventario` (
    `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `local_id` BIGINT UNSIGNED NOT NULL,
    `variante_id` BIGINT UNSIGNED NOT NULL,
    `usuario_id` BIGINT UNSIGNED NOT NULL,
    `tipo_ajuste` ENUM('INGRESO', 'SALIDA_MERMA', 'CORRECCION') NOT NULL,
    `cantidad` INT NOT NULL,
    `motivo` VARCHAR(255) NOT NULL,
    `fecha_ajuste` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT `fk_ajustes_local` FOREIGN KEY (`local_id`) 
        REFERENCES `locales` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT `fk_ajustes_variante` FOREIGN KEY (`variante_id`) 
        REFERENCES `variantes_producto` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT `fk_ajustes_usuario` FOREIGN KEY (`usuario_id`) 
        REFERENCES `usuarios` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
    INDEX `idx_ajustes_fecha` (`fecha_ajuste`),
    INDEX `idx_ajustes_tipo` (`tipo_ajuste`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -----------------------------------------------------------------------------
-- 16. Tabla: reportes_configuracion (Filtros y Programaciones Guardadas)
-- -----------------------------------------------------------------------------
DROP TABLE IF EXISTS `reportes_configuracion`;
CREATE TABLE `reportes_configuracion` (
    `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `usuario_id` BIGINT UNSIGNED NOT NULL,
    `nombre_reporte` VARCHAR(100) NOT NULL,
    `filtros_json` JSON NOT NULL,
    `frecuencia` ENUM('MANUAL', 'SEMANAL', 'MENSUAL') NOT NULL DEFAULT 'MANUAL',
    `correo_destino` VARCHAR(120) NULL,
    `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT `fk_reportes_usuario` FOREIGN KEY (`usuario_id`) 
        REFERENCES `usuarios` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -----------------------------------------------------------------------------
-- 17. Tabla: auditoria (Bitácora de Operaciones Críticas - RNF-04, HU-18)
-- -----------------------------------------------------------------------------
DROP TABLE IF EXISTS `auditoria`;
CREATE TABLE `auditoria` (
    `id` BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `usuario_id` BIGINT UNSIGNED NOT NULL,
    `accion` VARCHAR(60) NOT NULL,
    `entidad` VARCHAR(60) NOT NULL,
    `entidad_id` BIGINT UNSIGNED NULL,
    `detalle_json` JSON NULL,
    `ip_origen` VARCHAR(45) NULL,
    `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT `fk_auditoria_usuario` FOREIGN KEY (`usuario_id`) 
        REFERENCES `usuarios` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
    INDEX `idx_auditoria_accion` (`accion`),
    INDEX `idx_auditoria_entidad` (`entidad`),
    INDEX `idx_auditoria_fecha` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

SET FOREIGN_KEY_CHECKS = 1;
