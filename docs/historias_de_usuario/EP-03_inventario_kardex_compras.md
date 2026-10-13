# Épica 03: Inventario, Control de Stock, Kardex y Compras

> **Módulo:** Inventario y Almacén  
> **Requisitos Trazables:** `RF-06`, `RF-07`, `RF-08`, `RNF-04`  
> **Paquete EDT Relacionado:** `1.3.3.3 Módulo Inventario, Control de Stock, Kardex y Compras`  

---

## Historia de Usuario: HU-06
### Título: Control de Stock por Almacén y Alertas de Quiebre

| Atributo | Detalle |
|---|---|
| **Identificador** | `HU-06` |
| **Rol Principal** | Administrador / Vendedor |
| **Prioridad MoSCoW** | **MUST HAVE** |
| **Estimación** | 5 Story Points |
| **Sprint Sugerido** | Sprint 2 |
| **Dependencias** | HU-04 |

### 1. Narrativa
```text
Como Administrador o Vendedor,
Quiero consultar la disponibilidad de stock en tiempo real de cada variante de prenda y recibir alertas automáticas cuando el inventario esté por debajo del mínimo,
Para evitar quiebres de stock y orientar oportunamente la reposición de prendas agotadas.
```

### 2. Criterios de Aceptación (Gherkin)

#### Escenario 1: Visualización de disponibilidad en tiempo real
* **Dado** que un vendedor consulta la prenda "Polo Oversize Negro Talla M",
* **Cuando** abre la ficha o busca en la vista de inventario,
* **Entonces** el sistema muestra el stock físico actual disponible,
* **Y** desglosa la ubicación o tienda correspondiente.

#### Escenario 2: Alerta visual de stock crítico / quiebre
* **Dado** que una variante de prenda tiene configurado un stock mínimo de 5 unidades,
* **Cuando** el stock actual disminuye a 4 o menos unidades debido a una venta,
* **Entonces** el sistema marca la fila con un indicador visual de alerta (color amarillo para stock bajo, rojo para stock cero),
* **Y** coloca la prenda en la sección de *"Artículos por Reponer"*.

#### Escenario 3: Bloqueo de stock negativo
* **Dado** que una variante tiene un stock disponible de 2 unidades,
* **Cuando** se intenta procesar una salida o venta por 3 unidades,
* **Entonces** el sistema bloquea la operación y notifica *"Stock insuficiente para procesar la transacción (Disponible: 2 unidades)"*.

### 3. Consideraciones Técnicas (Clean Architecture + CQRS)
* **Dominio:** Entidad `Inventario` (Id, VarianteId, StockActual, StockMinimo). Invariante de negocio: `StockActual >= 0`.
* **Aplicación:** Query `GetStockInventarioQuery(FiltrosStockDto Filtros)`, `GetAlertasQuiebreStockQuery()`.
* **Infraestructura:** Control de concurrencia pesimista/optimista en la fila de `inventario` para evitar condiciones de carrera.
* **Presentación:** Tabla interactiva con chips de estado (Verde: Óptimo, Amarillo: Bajo, Rojo: Agotado).

---

## Historia de Usuario: HU-07
### Título: Movimientos de Kardex y Ajustes de Inventario Físico

| Atributo | Detalle |
|---|---|
| **Identificador** | `HU-07` |
| **Rol Principal** | Administrador |
| **Prioridad MoSCoW** | **MUST HAVE** |
| **Estimación** | 8 Story Points |
| **Sprint Sugerido** | Sprint 2 |
| **Dependencias** | HU-06 |

### 1. Narrativa
```text
Como Administrador,
Quiero registrar movimientos detallados de entrada, salida y ajustes de inventario físico (mermas, prendas falladas, sobrantes),
Para mantener la trazabilidad histórica inmutable del Kardex y auditar el origen de cualquier discrepancia de stock.
```

### 2. Criterios de Aceptación (Gherkin)

#### Escenario 1: Registro de ajuste manual justificado
* **Dado** que el Administrador realiza un conteo físico y detecta 1 prenda dañada que debe ser dada de baja,
* **Cuando** selecciona la variante, define Tipo: "Salida por Ajuste", Cantidad: 1 y motivo: "Prenda con costura rota",
* **Entonces** el sistema reduce el stock actual en 1 unidad,
* **Y** crea una fila inmutable en la tabla `kardex` guardando el saldo resultante, el motivo y el usuario que autorizó.

#### Escenario 2: Inmutabilidad del registro de Kardex
* **Dado** que un movimiento de Kardex ha sido registrado en el sistema,
* **Cuando** cualquier usuario intenta modificar o borrar directamente dicha fila,
* **Entonces** el sistema no expone endpoints ni métodos de actualización/borrado, garantizando que el historial es de solo lectura y append-only.

#### Escenario 3: Consulta cronológica del Kardex por variante
* **Dado** que se audita una variante específica,
* **Cuando** el Administrador solicita su historial de Kardex en un rango de fechas,
* **Entonces** el sistema presenta cronológicamente todas las entradas y salidas con sus saldos parciales correlativos.

### 3. Consideraciones Técnicas (Clean Architecture + CQRS)
* **Dominio:** Entidad `KardexMovimiento` (Id, VarianteId, TipoMovimiento [ENTRADA, SALIDA, AJUSTE], Cantidad, StockAnterior, StockResultante, Motivo, Fecha, UsuarioId).
* **Aplicación:**
  - Command: `RegistrarAjusteStockCommand(int VarianteId, int CantidadAjuste, string Motivo)`.
  - Query: `GetKardexPorVarianteQuery(int VarianteId, DateTime Desde, DateTime Hasta)`.
* **Infraestructura:** Inserción transaccional protegida contra inconsistencias de saldo.
* **Presentación:** Visor de Kardex estilo extracto bancario con filtros de fecha y exportador de datos.

---

## Historia de Usuario: HU-08
### Título: Órdenes de Compra y Recepción de Mercadería

| Atributo | Detalle |
|---|---|
| **Identificador** | `HU-08` |
| **Rol Principal** | Administrador |
| **Prioridad MoSCoW** | **SHOULD HAVE** |
| **Estimación** | 5 Story Points |
| **Sprint Sugerido** | Sprint 2 |
| **Dependencias** | HU-06, HU-07 |

### 1. Narrativa
```text
Como Administrador,
Quiero registrar órdenes de compra a proveedores y recepcionar los lotes de prendas ingresados,
Para incrementar automáticamente el stock de las variantes en inventario y dejar constancia formal del costo de adquisición.
```

### 2. Criterios de Aceptación (Gherkin)

#### Escenario 1: Emisión de orden de compra
* **Dado** que el Administrador necesita abastecer stock,
* **Cuando** crea una orden de compra seleccionando el Proveedor y agregando las variantes con sus cantidades y costo unitario pactado,
* **Entonces** el sistema genera la orden con estado "Pendiente de Recepción" sin alterar todavía el stock físico de la tienda.

#### Escenario 2: Recepción física de mercadería y aumento de stock
* **Dado** que llega el pedido físico enviado por el proveedor,
* **Cuando** el Administrador confirma la recepción del pedido en el sistema,
* **Entonces** el estado de la orden cambia a "Recepcionado",
* **Y** el sistema incrementa atómicamente el stock de cada variante en la tabla `inventario`,
* **Y** registra las correspondientes entradas en el `kardex` con referencia al número de orden de compra.

### 3. Consideraciones Técnicas (Clean Architecture + CQRS)
* **Dominio:** Agregado `OrdenCompra` y entidad `DetalleOrdenCompra`. Estados: PENDIENTE, RECEPCIONADO, ANULADO.
* **Aplicación:**
  - Command: `RegistrarOrdenCompraCommand`, `RecepcionarOrdenCompraCommand`.
  - Query: `GetOrdenesCompraQuery`.
* **Infraestructura:** Mapeo de cabecera/detalle y ejecución atómica de recepción de stock.
* **Presentación:** Formulario de compras con buscador de proveedores y calculadora de costo total.
