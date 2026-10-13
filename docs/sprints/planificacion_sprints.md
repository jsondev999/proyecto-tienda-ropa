# Planificación Maestra de Sprints — SYSELL (4 Sprints)

> **Proyecto:** SYSELL — Sistema Web de Gestión de Inventario y Ventas  
> **Metodología:** Híbrida RUP + Scrum  
> **Horizonte Temporal:** 28 días calendario  
> **Equipo Ejecutor:** Pollitos Design  
> **Fecha de Elaboración:** Octubre 2026  

---

## 1. Calendario General y Sincronización RUP + Scrum

```
Días 1–3       Días 4–10               Días 11–17              Días 18–24              Días 25–28
[Sprint 0] -> [ SPRINT 1 ] ---------> [ SPRINT 2 ] ---------> [ SPRINT 3 ] ---------> [ SPRINT 4 ]
 INICIO       ELABORACIÓN             CONSTRUCCIÓN I          CONSTRUCCIÓN II         TRANSICIÓN
 Preparación   Arquitectura & Catálogo  Caja & Inventario/Kardex POS & Ventas Mixtas    Analítica & Despliegue
```

---

## 2. Sprint 1: Arquitectura Base, Seguridad RBAC y Catálogo Maestro de Ropa
* **Duración:** Días 4 al 10 (7 días calendario)  
* **Fase RUP:** Elaboración  
* **Capacidad:** 24 Story Points  
* **Historias Asignadas:** `HU-01` (5 SP), `HU-02` (5 SP), `HU-03` (3 SP), `HU-04` (8 SP), `HU-05` (3 SP)  

### 2.1. Sprint Goal (Objetivo del Sprint)
> *"Establecer el núcleo de Clean Architecture y la seguridad de la aplicación con autenticación JWT y roles, permitiendo al Administrador gestionar las categorías, marcas y el catálogo de prendas con variantes físicas de talla, color y precio de venta."*

### 2.2. Desglose de Tareas Técnicas por Historia

#### Tareas HU-01 y HU-02: Autenticación Segura y RBAC (10 SP)
* `TSK-1.1.1` *(Domain)*: Modelar entidades `Usuario`, `Rol`, `Permiso` y Value Objects `EmailAddress`, `PasswordHash`.
* `TSK-1.1.2` *(Infrastructure)*: Implementar servicio de cifrado con BCrypt y proveedor de tokens JWT con claims de rol y expiración.
* `TSK-1.1.3` *(Application)*: Crear handler para `LoginCommand` y query `GetPerfilUsuarioQuery`.
* `TSK-1.1.4` *(Infrastructure)*: Configurar middleware de autenticación y autorización por roles (`[Authorize(Roles = "Administrador")]`).
* `TSK-1.1.5` *(Presentation)*: Desarrollar interfaz de Login reactiva con validación cliente de campos y alertas de error.
* `TSK-1.1.6` *(QA)*: Pruebas unitarias de emisión de tokens y pruebas de integración de bloqueo a rutas no autorizadas (HTTP 401/403).

#### Tareas HU-03: Categorías y Marcas Maestras (3 SP)
* `TSK-1.2.1` *(Domain)*: Entidades `Categoria` y `Marca` con validación de no duplicidad de nombres.
* `TSK-1.2.2` *(Application)*: Implementar Commands de creación/edición y Queries de listado activo con paginación.
* `TSK-1.2.3` *(Infrastructure)*: Repositorios en capa de acceso a datos con mapeo relacional a MySQL.
* `TSK-1.2.4` *(Presentation)*: Vista de mantenimiento con modales rápidos y filtros instantáneos.

#### Tareas HU-04 y HU-05: Catálogo de Prendas con Variantes y Precios (11 SP)
* `TSK-1.3.1` *(Domain)*: Agregado `Producto` con entidad hija `VarianteProducto` (Talla, Color, SKU, Código de Barras, PrecioVenta).
* `TSK-1.3.2` *(Domain)*: Reglas de validación: SKU único obligatorio, precio de venta estrictamente mayor a 0.00.
* `TSK-1.3.3` *(Application)*: Command `RegistrarProductoConVariantesCommand` y Command `ActualizarPrecioVarianteCommand`.
* `TSK-1.3.4` *(Application)*: Query `BuscarPrendasCatalogoQuery` con soporte de filtros combinados.
* `TSK-1.3.5` *(Presentation)*: Formulario interactivo que genera dinámicamente la grilla de variantes a partir de tallas y colores seleccionados.
* `TSK-1.3.6` *(QA)*: Pruebas automatizadas de prevención de SKUs duplicados y validación de precios negativos.

### 2.3. Entregable Funcional (Incremento Demostrable)
* Módulo de Login operativo con roles (Administrador vs Vendedor).
* Catálogo maestro poblado donde el Administrador crea prendas reales con múltiples tallas y colores.

---

## 3. Sprint 2: Control de Turnos de Caja, Inventario en Tiempo Real, Kardex y Abastecimiento
* **Duración:** Días 11 al 17 (7 días calendario)  
* **Fase RUP:** Construcción (Iteración 1)  
* **Capacidad:** 29 Story Points  
* **Historias Asignadas:** `HU-13` (8 SP), `HU-14` (3 SP), `HU-06` (5 SP), `HU-07` (8 SP), `HU-08` (5 SP)  

### 3.1. Sprint Goal
> *"Construir el control financiero de caja física (apertura, egresos y cierre con arqueo ciego) y el control cuantitativo del almacén con registro inmutable en Kardex y órdenes de compra con proveedores."*

### 3.2. Desglose de Tareas Técnicas por Historia

#### Tareas HU-13 y HU-14: Apertura/Cierre de Caja y Movimientos Menores (11 SP)
* `TSK-2.1.1` *(Domain)*: Entidades `CajaTurno` y `MovimientoCaja`. Reglas de una sola caja abierta por usuario.
* `TSK-2.1.2` *(Application)*: `AbrirCajaCommand`, `CerrarCajaCommand` con cálculo de diferencia (sobrante/faltante) y `RegistrarMovimientoCajaCommand`.
* `TSK-2.1.3` *(Infrastructure)*: Validación en base de datos para impedir que un usuario venda sin caja abierta activa.
* `TSK-2.1.4` *(Presentation)*: Modal de apertura de caja y pantalla de arqueo ciego con calculadora de denominaciones de efectivo.
* `TSK-2.1.5` *(QA)*: Pruebas de cálculo de descuadre de caja con diferentes combinaciones monetarias.

#### Tareas HU-06 y HU-07: Control de Stock, Alertas y Kardex Inmutable (13 SP)
* `TSK-2.2.1` *(Domain)*: Entidades `Inventario` y `KardexMovimiento` (saldo anterior, cantidad, saldo resultante, motivo, usuario).
* `TSK-2.2.2` *(Domain)*: Invariante: Bloqueo absoluto de stock negativo.
* `TSK-2.2.3` *(Application)*: `RegistrarAjusteStockCommand` (mermas, fallas de fábrica, sobrantes físicos).
* `TSK-2.2.4` *(Application)*: Query `GetKardexPorVarianteQuery` y `GetAlertasQuiebreStockQuery`.
* `TSK-2.2.5` *(Presentation)*: Vista de Kardex cronológico estilo extracto bancario con chips de colores para stock crítico.
* `TSK-2.2.6` *(QA)*: Pruebas de concurrencia y verificación de inmutabilidad de filas de Kardex.

#### Tareas HU-08: Órdenes de Compra y Recepción de Mercadería (5 SP)
* `TSK-2.3.1` *(Domain)*: Agregado `OrdenCompra` y `DetalleOrdenCompra` (estados: PENDIENTE, RECEPCIONADO, CANCELADO).
* `TSK-2.3.2` *(Application)*: `CrearOrdenCompraCommand` y `RecepcionarOrdenCompraCommand`.
* `TSK-2.3.3` *(Infrastructure)*: Transacción atómica que al recepcionar: actualiza estado, suma stock en `inventario` y genera entrada en `kardex`.
* `TSK-2.3.4` *(Presentation)*: Formulario de abastecimiento y modal de confirmación de recepción física.

### 3.3. Entregable Funcional (Incremento Demostrable)
* Turno de caja operativo: apertura con saldo inicial y cierre con reporte de sobrante/faltante.
* Visor de Kardex completo con entradas de compra y ajustes manuales auditados.

---

## 4. Sprint 3: Punto de Venta (POS), Liquidación Multitendencia, Comprobantes y Clientes
* **Duración:** Días 18 al 24 (7 días calendario)  
* **Fase RUP:** Construcción (Iteración 2)  
* **Capacidad:** 32 Story Points  
* **Historias Asignadas:** `HU-09` (8 SP), `HU-10` (8 SP), `HU-11` (5 SP), `HU-12` (5 SP), `HU-15` (3 SP), `HU-16` (3 SP)  

### 4.1. Sprint Goal
> *"Implementar la experiencia de venta rápida en mostrador (POS) con lectura de código de barras, soporte de pagos combinados (Efectivo, Yape, Plin, Tarjeta), emisión de tickets, directorio de clientes y anulación controlada de ventas."*

### 4.2. Desglose de Tareas Técnicas por Historia

#### Tareas HU-15 y HU-16: Directorio Comercial (6 SP)
* `TSK-3.1.1` *(Domain & App)*: Entidades `Cliente` y `Proveedor` con validación de DNI (8 dígitos) y RUC (11 dígitos).
* `TSK-3.1.2` *(Application)*: Query de búsqueda predictiva ultrarrápida por documento o apellido para el POS.
* `TSK-3.1.3` *(Presentation)*: Modal de registro rápido de cliente integrado directamente en el POS sin perder el carrito.

#### Tareas HU-09 y HU-10: Terminal POS y Liquidación Multitendencia Mixta (16 SP)
* `TSK-3.2.1` *(Domain)*: Agregado `Venta`, `DetalleVenta` y `PagoVenta`. Regla: `Sum(Pagos.Monto) == Venta.Total`.
* `TSK-3.2.2` *(Application)*: Command `RegistrarVentaTransaccionCommand`.
* `TSK-3.2.3` *(Infrastructure)*: Transacción ACID integral:
  1. Inserta `ventas` y `detalle_ventas`.
  2. Inserta desglose de medios de pago en `pagos_venta`.
  3. Descuenta stock físico de `inventario`.
  4. Inserta movimiento de salida en `kardex`.
  5. Suma el efectivo cobrado a la caja del turno activo.
* `TSK-3.2.4` *(Presentation)*: Pantalla POS optimizada con atajos de teclado, cálculo dinámico de vuelto y selector de medios de pago múltiples.
* `TSK-3.2.5` *(QA)*: Pruebas transaccionales de venta con pagos mixtos (50% Efectivo + 50% Yape) y validación de stock descontado.

#### Tareas HU-11 y HU-12: Emisión de Comprobantes y Anulaciones (10 SP)
* `TSK-3.3.1` *(Domain & Infra)*: Generador de numeración correlativa por serie de ticket/boleta.
* `TSK-3.3.2` *(Presentation)*: Vista de impresión térmica (80mm) con desglose de ítems, medios de pago y total con IGV.
* `TSK-3.3.3` *(Application)*: Command `AnularVentaCommand` con autorización obligatoria de Administrador.
* `TSK-3.3.4` *(Infrastructure)*: Reversión atómica de stock, inserción de contra-asiento en Kardex y ajuste en caja.
* `TSK-3.3.5` *(QA)*: Verificación de que la anulación restituya con exactitud cada prenda en el inventario.

### 4.3. Entregable Funcional (Incremento Demostrable)
* Flujo de venta completo de mostrador: escaneo de prendas, cobro mixto (Efectivo con vuelto + Yape), impresión de ticket y actualización simultánea de Kardex y Caja.

---

## 5. Sprint 4: Analítica Estratégica, Auditoría del Sistema, Hardening y Despliegue en VPS
* **Duración:** Días 25 al 28 (4 días calendario)  
* **Fase RUP:** Transición  
* **Capacidad:** 10 SP de historias funcionales + 15 SP equivalentes en QA/Hardening y DevOps  
* **Historias Asignadas:** `HU-17` (5 SP), `HU-18` (5 SP) + Paquete EDT `1.3.3.8 Pruebas y Despliegue`  

### 5.1. Sprint Goal
> *"Consolidar la plataforma con dashboards de reportería gerencial y pista de auditoría forense, ejecutando pruebas de carga, hardening de seguridad y el despliegue final en producción en el VPS institucional."*

### 5.2. Desglose de Tareas Técnicas por Historia

#### Tareas HU-17: Dashboard Analítico y Reportes de Ventas (5 SP)
* `TSK-4.1.1` *(Application)*: Queries CQRS agregadas de alta eficiencia para ventas por fecha, recaudación por medio de pago y Top 10 prendas más vendidas.
* `TSK-4.1.2` *(Presentation)*: Dashboard con gráficos interactivos y tarjetas de indicadores clave (KPIs: Ventas totales, Ticket promedio, Margen estimado).
* `TSK-4.1.3` *(Presentation)*: Módulo de exportación de reportes tabulares a Excel y PDF.

#### Tareas HU-18: Registro de Auditoría y Trazabilidad (5 SP)
* `TSK-4.2.1` *(Domain & Infra)*: Entidad inmutable `LogAuditoria` y Middleware que intercepta Commands sensibles (anulación, cambio de precio, ajustes de stock).
* `TSK-4.2.2` *(Presentation)*: Visor de auditoría para el Administrador con filtro por usuario, fecha y tabla afectada.

#### Tareas Transversales: QA Integral, Hardening y Despliegue en VPS
* `TSK-4.3.1` *(QA)*: Ejecución de la suite completa de pruebas de regresión y verificación de los 18 criterios DoD.
* `TSK-4.3.2` *(QA / UAT)*: Sesión formal de Pruebas de Aceptación de Usuario con los roles de Administrador y Vendedor.
* `TSK-4.3.3` *(DevOps)*: Configuración del VPS institucional (Linux, Nginx como proxy inverso, motor de base de datos MySQL 8.0 optimizado con backups automáticos y certificado SSL Let's Encrypt).
* `TSK-4.3.4` *(DevOps)*: Despliegue continuo de la aplicación web y verificación de accesibilidad HTTPS.
* `TSK-4.3.5` *(Cierre)*: Redacción del Manual de Usuario, entrega del repositorio etiquetado con tag `v1.0.0-release` y firma del Acta de Conformidad final.

### 5.3. Entregable Funcional (Incremento Demostrable)
* Sistema SYSELL desplegado en producción en el VPS institucional, 100% funcional, documentado y listo para operación comercial real.
