# Épica 04: Punto de Venta (POS), Transacciones y Medios de Pago

> **Módulo:** Ventas y Facturación  
> **Requisitos Trazables:** `RF-09`, `RF-10`, `RF-11`, `RF-12`, `RNF-03`  
> **Paquete EDT Relacionado:** `1.3.3.4 Módulo Punto de Venta (POS), Transacciones y Medios de Pago`  

---

## Historia de Usuario: HU-09
### Título: Terminal de Venta Rápida (POS) y Carrito Transaccional

| Atributo | Detalle |
|---|---|
| **Identificador** | `HU-09` |
| **Rol Principal** | Vendedor / Administrador |
| **Prioridad MoSCoW** | **MUST HAVE** |
| **Estimación** | 8 Story Points |
| **Sprint Sugerido** | Sprint 3 |
| **Dependencias** | HU-04, HU-06, HU-13 (Caja Abierta) |

### 1. Narrativa
```text
Como Vendedor en caja,
Quiero escanear prendas mediante lector de código de barras o buscarlas por nombre/talla en una interfaz táctil rápida,
Para agregar artículos al carrito de venta, calcular subtotal e impuestos y atender al cliente en menos de 1 minuto.
```

### 2. Criterios de Aceptación (Gherkin)

#### Escenario 1: Agregado ágil de prenda mediante código de barras
* **Dado** que el cajero se encuentra en la pantalla del POS con turno de caja abierto,
* **Cuando** escanea o digita el código de barras `775123456789`,
* **Entonces** el sistema identifica la variante de prenda correspondiente,
* **Y** agrega 1 unidad al carrito de venta actualizando automáticamente el subtotal, IGV (18%) y total a pagar en tiempo real.

#### Escenario 2: Restricción de venta sin turno de caja activo
* **Dado** que un usuario ingresa al módulo de POS sin haber realizado la apertura de caja de su turno,
* **Cuando** intenta iniciar una nueva venta,
* **Entonces** el sistema bloquea la acción y muestra un modal obligatorio *"Debe realizar la Apertura de Caja antes de procesar ventas"*.

#### Escenario 3: Validación de disponibilidad de stock al agregar al carrito
* **Dado** que una variante solo cuenta con 3 unidades en stock físico,
* **Cuando** el cajero intenta incrementar la cantidad en el carrito a 4 unidades,
* **Entonces** el sistema restringe el incremento informando *"Stock máximo disponible alcanzado (3 unidades)"*.

### 3. Consideraciones Técnicas (Clean Architecture + CQRS)
* **Dominio:** Agregado `Venta` con entidades `DetalleVenta`. Reglas: Verificación de caja abierta, no permitir cantidades negativas o en cero.
* **Aplicación:** Query `BuscarPrendaParaPosQuery(string TerminoOBarrras)`, Command `PrepararVentaCommand`.
* **Infraestructura:** Consulta rápida optimizada para escaners de código de barras (índice en `codigo_barras`).
* **Presentación:** Interfaz reactiva tipo POS de alta velocidad con soporte de teclado numérico y atajos rápidos.

---

## Historia de Usuario: HU-10
### Título: Liquidación Multitendencia de Medios de Pago Mixtos

| Atributo | Detalle |
|---|---|
| **Identificador** | `HU-10` |
| **Rol Principal** | Vendedor / Administrador |
| **Prioridad MoSCoW** | **MUST HAVE** |
| **Estimación** | 8 Story Points |
| **Sprint Sugerido** | Sprint 3 |
| **Dependencias** | HU-09 |

### 1. Narrativa
```text
Como Vendedor,
Quiero cobrar la venta combinando múltiples medios de pago (Efectivo con cálculo de vuelto, billeteras digitales Yape/Plin con código de referencia, y Tarjeta de crédito/débito),
Para brindar flexibilidad al cliente y cuadrar con exactitud los ingresos en caja.
```

### 2. Criterios de Aceptación (Gherkin)

#### Escenario 1: Pago combinado mixto (Efectivo + Billetera digital)
* **Dado** que el total de la venta es de S/. 120.00,
* **Cuando** el cajero registra S/. 50.00 en Efectivo y S/. 70.00 mediante Yape indicando el número de operación `482910`,
* **Entonces** el sistema valida que la suma de pagos iguale exactamente el total de S/. 120.00,
* **Y** permite confirmar la transacción registrando el desglose en la tabla `pagos_venta`.

#### Escenario 2: Pago en efectivo con cálculo de vuelto
* **Dado** que la venta asciende a S/. 65.00 y el cliente entrega un billete de S/. 100.00 en efectivo,
* **Cuando** el cajero ingresa el monto recibido de S/. 100.00,
* **Entonces** el sistema calcula y exhibe en pantalla de manera destacada un vuelto de S/. 35.00,
* **Y** registra el pago monetario neto de S/. 65.00 en el turno de caja.

#### Escenario 3: Bloqueo por pago incompleto
* **Dado** que una venta totaliza S/. 80.00,
* **Cuando** los montos ingresados en los distintos medios suman solo S/. 70.00 y se intenta finalizar,
* **Entonces** el sistema bloquea la emisión alertando *"Monto pendiente por liquidar: S/. 10.00"*.

### 3. Consideraciones Técnicas (Clean Architecture + CQRS)
* **Dominio:** Entidad `PagoVenta` (Id, VentaId, MetodoPago [EFECTIVO, YAPE, PLIN, TARJETA], Monto, ReferenciaOperacion). Regla de Invariante: `Sum(Pagos.Monto) == Venta.Total`.
* **Aplicación:** Command `RegistrarVentaTransaccionCommand(VentaRequestDto VentaDto, List<PagoDto> Pagos)`.
* **Infraestructura:** Transacción atómica ACID en MySQL que inserta `ventas`, `detalle_ventas`, `pagos_venta`, descuenta `inventario` y genera fila en `kardex`.
* **Presentación:** Modal de cobro rápido con botones de acceso directo a medios de pago y teclado de denominaciones de billetes.

---

## Historia de Usuario: HU-11
### Título: Emisión y Generación de Comprobantes de Venta

| Atributo | Detalle |
|---|---|
| **Identificador** | `HU-11` |
| **Rol Principal** | Vendedor |
| **Prioridad MoSCoW** | **MUST HAVE** |
| **Estimación** | 5 Story Points |
| **Sprint Sugerido** | Sprint 3 |
| **Dependencias** | HU-10 |

### 1. Narrativa
```text
Como Vendedor,
Quiero emitir el comprobante de venta correspondiente (Boleta, Factura o Ticket de Venta) con numeración correlativa automática,
Para entregar al cliente su comprobante físico o digital cumpliendo con la formalidad comercial.
```

### 2. Criterios de Aceptación (Gherkin)

#### Escenario 1: Generación de ticket/boleta con numeración correlativa
* **Dado** que una venta acaba de ser procesada exitosamente,
* **Cuando** se confirma la transacción,
* **Entonces** el sistema asigna el siguiente número correlativo de serie (ej. `B001-0000452`),
* **Y** genera la vista del ticket con encabezado del negocio, desglose de prendas (talla, color, precio), desglose de medios de pago, cálculo de IGV y fecha/hora exacta.

#### Escenario 2: Soporte para impresión en formato térmico
* **Dado** que la venta está confirmada,
* **Cuando** el usuario presiona el comando de impresión,
* **Entonces** el sistema despliega el diálogo de impresión configurado para impresoras térmicas de 80mm o descarga el comprobante en formato PDF ligero.

### 3. Consideraciones Técnicas (Clean Architecture + CQRS)
* **Dominio:** Generador de correlativos por tipo de comprobante.
* **Aplicación:** Query `GetComprobanteVentaPdfQuery(int VentaId)`.
* **Infraestructura:** Renderizado de plantilla HTML/CSS a PDF optimizado para impresión rápida.
* **Presentación:** Vista previa limpia y trigger de impresión nativo del navegador sin recarga de página.

---

## Historia de Usuario: HU-12
### Título: Anulación Controlada de Venta y Restitución de Stock

| Atributo | Detalle |
|---|---|
| **Identificador** | `HU-12` |
| **Rol Principal** | Administrador |
| **Prioridad MoSCoW** | **SHOULD HAVE** |
| **Estimación** | 5 Story Points |
| **Sprint Sugerido** | Sprint 3 |
| **Dependencias** | HU-10, HU-11 |

### 1. Narrativa
```text
Como Administrador,
Quiero anular una venta registrada erróneamente ingresando una justificación obligatoria,
Para reintegrar automáticamente las prendas al stock de inventario y ajustar los totales de la caja del turno.
```

### 2. Criterios de Aceptación (Gherkin)

#### Escenario 1: Anulación exitosa por parte del Administrador
* **Dado** que existe una venta con estado "COMPLETADA",
* **Cuando** el Administrador solicita la anulación, ingresa el motivo "Cliente desistió de compra por talla errónea" y confirma su clave,
* **Entonces** el estado de la venta cambia a "ANULADA",
* **Y** las unidades de cada variante son reintegradas inmediatamente al stock en `inventario`,
* **Y** se genera un movimiento de entrada en `kardex` por anulación,
* **Y** se resta el monto correspondiente del arqueo de caja.

#### Escenario 2: Bloqueo de anulación a usuarios no administradores
* **Dado** que un usuario con rol "Vendedor" intenta anular una venta,
* **Cuando** presiona la opción de anular,
* **Entonces** el sistema solicita la autorización o credencial de un Administrador y no permite completar la acción de forma autónoma.

### 3. Consideraciones Técnicas (Clean Architecture + CQRS)
* **Dominio:** Método de agregado `Venta.Anular(string motivo, Guid usuarioId)`.
* **Aplicación:** Command `AnularVentaCommand(int VentaId, string Motivo)`.
* **Infraestructura:** Transacción reversa integral que repone stock, actualiza Kardex y anula saldos en caja.
* **Presentación:** Modal de confirmación con campo obligatorio de motivo y alerta de advertencia.
