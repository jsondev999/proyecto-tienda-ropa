# Especificación de Diagramas de Flujo de Datos (DFD)

**Proyecto:** Sistema de Gestión — Tienda de Ropa para Varón  
**Versión:** 2.0  
**Fecha:** 13/10/2026  

---

## 📌 1. Marco Metodológico y Elementos del DFD

Un **Diagrama de Flujo de Datos (DFD)** es una herramienta de modelado estructurado que representa cómo se mueve, transforma y almacena la información dentro de un sistema.

A diferencia del **Caso de Uso** (que modela *quién interactúa con qué pantalla para lograr una meta*), el **DFD** se concentra en:
> **Entidad Externa ➔ Proceso (Transformación) ⇄ Flujo de Datos ⇄ Almacén de Datos**

### 1.1 Elementos Notacionales (Gane & Sarson / Yourdon)

| Símbolo | Elemento | Definición en el Sistema |
|:---:|---|---|
| 🟩 | **Entidad Externa** | Persona u organización externa al software que envía datos de entrada o recibe resultados del sistema (*Vendedor, Administrador, Cliente*). |
| 🔵 | **Proceso** | Función o rutina del software que transforma datos de entrada en datos de salida mediante reglas de negocio. |
| ➔ | **Flujo de Datos** | Tubería o movimiento de información entre procesos, entidades y almacenes. **Siempre se nombra con un sustantivo**. |
| 🗄️ | **Almacén de Datos (D1, D2...)** | Repositorio pasivo donde los datos se guardan para su uso posterior (tablas de la base de datos). |

### 1.2 Reglas Básicas Cumplidas en este Modelo
1. **Regla de Nomenclatura:** Todos los flujos tienen nombres sustantivos (ej. *"Datos de venta"*, no verbos como *"Vender"*).
2. **Conservación de Información:** Ningún proceso puede ser un "agujero negro" (solo recibir datos sin emitir) ni un "milagro" (solo emitir datos de la nada).
3. **No comunicación directa entre entidades:** Dos actores externos nunca se comunican directamente a través del DFD.
4. **No comunicación directa entre almacenes:** Dos almacenes de datos nunca se transfieren datos directamente sin que medie un proceso.
5. **Consistencia y Balanceo entre Niveles:** Todas las entradas y salidas del Nivel 0 se mantienen de forma balanceada en el Nivel 1.

---

## 🛰️ 2. DFD Nivel 0 (Diagrama de Contexto)

El **Nivel 0** delimita la frontera del sistema: muestra al software completo como un **único proceso central (Proceso 0)** interactuando exclusivamente con las entidades externas.

```mermaid
flowchart LR
    %% Configuración de Estilos
    classDef entidad fill:#E8F5E9,stroke:#2E7D32,stroke-width:2px,color:#1B5E20,font-weight:bold;
    classDef entidadAdmin fill:#FFEBEE,stroke:#C62828,stroke-width:2px,color:#B71C1C,font-weight:bold;
    classDef entidadCliente fill:#FFF8E1,stroke:#F57F17,stroke-width:2px,color:#E65100,font-weight:bold;
    classDef procesoCentral fill:#E1F5FE,stroke:#0277BD,stroke-width:3px,color:#01579B,font-weight:bold;

    %% Entidades Externas
    E_VENDEDOR["Vendedor<br/>(Caja / Mostrador)"]:::entidad
    E_ADMIN["Administrador<br/>(Propietario / Gerente)"]:::entidadAdmin
    E_CLIENTE["Cliente<br/>(Público Web / Comprador)"]:::entidadCliente

    %% Proceso Central (Nivel 0)
    P0(("0<br/><br/><b>Sistema Web de Gestión —<br/>Tienda de Ropa para Varón</b><br/>")):::procesoCentral

    %% Flujos de Información - Vendedor
    E_VENDEDOR -->|"Credenciales de acceso"| P0
    E_VENDEDOR -->|"Datos de venta y medio de pago"| P0
    E_VENDEDOR -->|"Consulta de prendas y existencias"| P0
    P0 -->|"Confirmación de acceso y rol"| E_VENDEDOR
    P0 -->|"Disponibilidad de stock por local"| E_VENDEDOR
    P0 -->|"Ticket digital de venta emitido"| E_VENDEDOR

    %% Flujos de Información - Administrador
    E_ADMIN -->|"Parámetros de catálogos maestros"| P0
    E_ADMIN -->|"Datos de prendas, precios e imágenes"| P0
    E_ADMIN -->|"Ajustes de inventario y compras"| P0
    E_ADMIN -->|"Gestión de usuarios y contraseñas"| P0
    E_ADMIN -->|"Criterios y filtros de reportes"| P0
    P0 -->|"Reportes estadísticos y gráficos"| E_ADMIN
    P0 -->|"Alertas de quiebre de stock crítico"| E_ADMIN
    P0 -->|"Historial y auditoría de operaciones"| E_ADMIN

    %% Flujos de Información - Cliente
    E_CLIENTE -->|"Criterios de búsqueda y filtros web"| P0
    E_CLIENTE -->|"Consulta de prendas y tallas"| P0
    P0 -->|"Catálogo interactivo con precios"| E_CLIENTE
    P0 -->|"Disponibilidad referencial por local"| E_CLIENTE
    P0 -->|"Ubicación y datos de tiendas físicas"| E_CLIENTE
```

### Tabla de Balanceo del Nivel 0 (Entradas y Salidas)

| Entidad Externa | Flujos de Datos que Envía (Entradas al Sistema) | Flujos de Datos que Recibe (Salidas del Sistema) |
|---|---|---|
| **Vendedor** | • Credenciales de acceso<br>• Consulta de prendas y existencias<br>• Datos de venta y medio de pago | • Confirmación de acceso y rol<br>• Disponibilidad de stock por local<br>• Ticket digital de venta emitido |
| **Administrador** | • Gestión de usuarios y contraseñas<br>• Parámetros de catálogos maestros<br>• Datos de prendas, precios e imágenes<br>• Ajustes de inventario y compras<br>• Criterios y filtros de reportes | • Alertas de quiebre de stock crítico<br>• Reportes estadísticos y gráficos<br>• Historial y auditoría de operaciones |
| **Cliente (Web)** | • Criterios de búsqueda y filtros web<br>• Consulta de prendas y tallas | • Catálogo interactivo con precios<br>• Disponibilidad referencial por local<br>• Ubicación y datos de tiendas físicas |

---

## 🏙️ 3. DFD Nivel 1 (Procesos Principales del Sistema)

El **Nivel 1** descompone el Proceso 0 en sus **5 procesos fundamentales** y formaliza los **5 almacenes de datos ($D1$ a $D5$)** que dan soporte a las transacciones de la tienda.

```mermaid
flowchart TB
    %% Estilos de Nodos
    classDef entidad fill:#E8F5E9,stroke:#2E7D32,stroke-width:2px,color:#1B5E20,font-weight:bold;
    classDef entidadAdmin fill:#FFEBEE,stroke:#C62828,stroke-width:2px,color:#B71C1C,font-weight:bold;
    classDef entidadCliente fill:#FFF8E1,stroke:#F57F17,stroke-width:2px,color:#E65100,font-weight:bold;
    classDef proceso fill:#E1F5FE,stroke:#0277BD,stroke-width:2px,color:#01579B,font-weight:bold;
    classDef almacen fill:#EDE7F6,stroke:#512DA8,stroke-width:2px,color:#311B92,font-weight:bold;

    %% Entidades Externas
    E_ADMIN["Administrador<br/>(Gerente)"]:::entidadAdmin
    E_VENDEDOR["Vendedor<br/>(Cajero)"]:::entidad
    E_CLIENTE["Cliente<br/>(Público Web)"]:::entidadCliente

    %% Procesos Nivel 1
    P1(("1.0<br/>Gestionar<br/>Autenticación<br/>y Usuarios")):::proceso
    P2(("2.0<br/>Gestionar<br/>Inventario y<br/>Prendas")):::proceso
    P3(("3.0<br/>Procesar<br/>Ventas y<br/>Tickets")):::proceso
    P4(("4.0<br/>Generar<br/>Reportes y<br/>Analítica")):::proceso
    P5(("5.0<br/>Publicar<br/>Catálogo<br/>Digital Web")):::proceso

    %% Almacenes de Datos
    D1[("D1 | Usuarios y Credenciales")]:::almacen
    D2[("D2 | Catálogos Maestros")]:::almacen
    D3[("D3 | Prendas y Stock por Local")]:::almacen
    D4[("D4 | Registro de Ventas y Tickets")]:::almacen
    D5[("D5 | Bitácora de Auditoría y Kardex")]:::almacen

    %% Flujos - Proceso 1.0 (Seguridad y Usuarios)
    E_VENDEDOR -->|"Credenciales de acceso"| P1
    E_ADMIN -->|"Gestión de cuentas y reseteo de claves"| P1
    P1 -->|"Confirmación de rol y sesión"| E_VENDEDOR
    P1 -->|"Confirmación y estado de usuarios"| E_ADMIN
    P1 -->|"Lectura y validación de usuarios"| D1
    D1 -->|"Datos de usuario y permisos"| P1
    P1 -->|"Registro de evento de login/bloqueo"| D5

    %% Flujos - Proceso 2.0 (Inventario y Prendas)
    E_ADMIN -->|"Atributos de catálogos maestros"| P2
    E_ADMIN -->|"Alta de prendas y ajustes de stock"| P2
    E_VENDEDOR -->|"Consulta de existencias físicas"| P2
    P2 -->|"Alertas de stock bajo por local"| E_ADMIN
    P2 -->|"Stock disponible por local"| E_VENDEDOR
    P2 -->|"Registro de marcas, tallas y colores"| D2
    D2 -->|"Valores maestros normalizados"| P2
    P2 -->|"Actualización de stock y prendas"| D3
    D3 -->|"Datos de prendas y umbrales"| P2
    P2 -->|"Kardex de movimientos y transferencias"| D5

    %% Flujos - Proceso 3.0 (Ventas y Tickets)
    E_VENDEDOR -->|"Ítems a vender y medio de pago"| P3
    P3 -->|"Verificación de existencias"| D3
    D3 -->|"Stock disponible del local"| P3
    P3 -->|"Descuento automático de stock"| D3
    P3 -->|"Registro de transacción completada"| D4
    P3 -->|"Ticket digital emitido (PDF/Impreso)"| E_VENDEDOR
    P3 -->|"Asiento de venta en auditoría"| D5

    %% Flujos - Proceso 4.0 (Reportes)
    E_ADMIN -->|"Parámetros y filtros de reporte"| P4
    D4 -->|"Histórico de ventas y pagos"| P4
    D3 -->|"Datos de rotación y existencias"| P4
    P4 -->|"Reportes estadísticos y gráficos"| E_ADMIN

    %% Flujos - Proceso 5.0 (Catálogo Digital)
    E_CLIENTE -->|"Filtros y búsqueda de prendas"| P5
    D3 -->|"Prendas activas y stock referencial"| P5
    P5 -->|"Galería interactiva y fichas de producto"| E_CLIENTE
    P5 -->|"Disponibilidad física por tienda"| E_CLIENTE
```

### Diccionario de Almacenes de Datos (D1 a D5)

| Código | Nombre del Almacén | Contenido de Datos Almacenados | Tablas Físicas de la BD |
|:---:|---|---|---|
| **D1** | **Usuarios y Credenciales** | Cuentas de acceso, nombres, roles (Admin/Vendedor), hashes bcrypt de contraseñas, estado (Activo/Inactivo/Bloqueado) y contador de intentos. | `usuarios`, `roles`, `intentos_login` |
| **D2** | **Catálogos Maestros** | Atributos fijos normalizados administrados por el dueño: categorías, tallas numéricas y alfabéticas, catálogo de colores con código HEX y marcas. | `categorias`, `tallas`, `colores`, `marcas` |
| **D3** | **Prendas y Stock por Local** | Ficha técnica de prendas (código SKU, nombre, descripción, precio compra, precio venta, foto) y tabla de existencias independientes para **Local 1** y **Local 2** con umbral mínimo. | `prendas`, `inventario_local`, `sucursales` |
| **D4** | **Registro de Ventas y Tickets** | Encabezado de transacciones (número correlativo de ticket, fecha/hora, cajero, local, medio de pago, totales) y líneas de detalle de prendas vendidas. | `ventas`, `detalle_ventas`, `tickets_digitales` |
| **D5** | **Bitácora de Auditoría y Kardex** | Historial inmutable de movimientos de inventario (ingresos, traslados entre sedes, mermas) y auditoría de accesos al sistema con dirección IP y fecha. | `kardex_movimientos`, `auditoria_sistema` |

---

## 🏠 4. DFD Nivel 2 (Descomposición del Proceso 3.0: Procesar Ventas y Tickets)

Siguiendo el estándar de las láminas académicas, el **Nivel 2** le aplica un zoom de máximo detalle al **proceso núcleo del negocio**: la venta en mostrador, descomponiéndolo en sus 5 subprocesos (`3.1` a `3.5`).

```mermaid
flowchart LR
    %% Estilos de Nodos
    classDef entidad fill:#E8F5E9,stroke:#2E7D32,stroke-width:2px,color:#1B5E20,font-weight:bold;
    classDef proceso fill:#E1F5FE,stroke:#0277BD,stroke-width:2px,color:#01579B,font-weight:bold;
    classDef almacen fill:#EDE7F6,stroke:#512DA8,stroke-width:2px,color:#311B92,font-weight:bold;

    %% Entidades Externas
    E_VENDEDOR["Vendedor<br/>(Cajero Mostrador)"]:::entidad
    E_CLIENTE["Cliente<br/>(Comprador)"]:::entidad

    %% Subprocesos Nivel 2
    P3_1(("3.1<br/>Validar Prenda<br/>y Stock")):::proceso
    P3_2(("3.2<br/>Calcular Totales<br/>y Descuentos")):::proceso
    P3_3(("3.3<br/>Registrar Cobro<br/>y Medio Pago")):::proceso
    P3_4(("3.4<br/>Actualizar<br/>Inventario")):::proceso
    P3_5(("3.5<br/>Generar y Emitir<br/>Ticket Digital")):::proceso

    %% Almacenes de Datos que intervienen
    D3[("D3 | Prendas y Stock por Local")]:::almacen
    D4[("D4 | Ventas y Tickets Digitales")]:::almacen
    D5[("D5 | Kardex y Auditoría")]:::almacen

    %% Flujos de Subproceso 3.1: Validar Prenda y Stock
    E_VENDEDOR -->|"Código SKU y cantidad solicitada"| P3_1
    D3 -->|"Existencias actuales por local"| P3_1
    P3_1 -->|"Aviso de stock insuficiente"| E_VENDEDOR
    P3_1 -->|"Prendas confirmadas y precio unitario"| P3_2

    %% Flujos de Subproceso 3.2: Calcular Totales
    P3_2 -->|"Resumen de cuenta e importe total"| E_VENDEDOR
    P3_2 -->|"Importe total exigible"| P3_3

    %% Flujos de Subproceso 3.3: Registrar Cobro
    E_VENDEDOR -->|"Medio de pago y monto recibido"| P3_3
    P3_3 -->|"Cambio / vuelto y confirmación de cobro"| E_VENDEDOR
    P3_3 -->|"Detalle de prendas para descarga"| P3_4
    P3_3 -->|"Detalle de pago y venta completada"| P3_5

    %% Flujos de Subproceso 3.4: Actualizar Inventario
    P3_4 -->|"Deducción de existencias en el local"| D3
    P3_4 -->|"Registro de movimiento de salida"| D5

    %% Flujos de Subproceso 3.5: Generar y Emitir Ticket
    P3_5 -->|"Almacenamiento de ticket correlativo"| D4
    P3_5 -->|"Ticket digital impreso o descargado"| E_VENDEDOR
    P3_5 -->|"Ticket digital vía WhatsApp o correo"| E_CLIENTE
```

### Detalle de Subprocesos del Nivel 2

1. **P3.1 — Validar Prenda y Stock:** Recibe el SKU leído por escáner o teclado, consulta en tiempo real el almacén `D3` filtrando por el local del vendedor. Si el stock es inferior al pedido, emite un aviso al vendedor; si es suficiente, transfiere el artículo confirmado y su precio al cálculo de totales.
2. **P3.2 — Calcular Totales y Descuentos:** Agrupa las líneas de venta, aplica promociones autorizadas y calcula el Subtotal, Descuentos e Importe Total a pagar en soles, mostrándoselo al cajero y pasando el monto neto al cobro.
3. **P3.3 — Registrar Cobro y Medio de Pago:** Captura el método de pago (Efectivo, Tarjeta, Yape/Plin), calcula el vuelto a entregar al cliente y confirma la aprobación económica de la venta.
4. **P3.4 — Actualizar Inventario y Kardex:** Realiza la deducción atómica de las existencias vendidas en el almacén `D3` correspondiente al local físico y asienta la salida por venta en la bitácora `D5`.
5. **P3.5 — Generar y Emitir Ticket Digital:** Asigna número de serie único interno, almacena el comprobante en `D4` y despacha el ticket para impresión térmica, descarga en PDF o envío instantáneo al cliente por WhatsApp.

---

## 🔗 5. Matriz de Trazabilidad: DFD vs. Requisitos Funcionales

| Proceso DFD | Nombre del Proceso | Requisitos Funcionales que Implementa |
|:---:|---|---|
| **1.0** | Gestionar Autenticación y Usuarios | RF-01, RF-02, RF-03, RF-04, RF-05, RF-06, RF-07, RF-08, RF-09, RF-10, RF-11, RF-12, RF-13, RF-14, RF-73 |
| **2.0** | Gestionar Inventario y Prendas | RF-15, RF-16, RF-17, RF-18, RF-19, RF-20, RF-22, RF-23, RF-24, RF-25, RF-26 a RF-34, RF-35 a RF-39, RF-74, RF-75, RF-77 |
| **3.0** | Procesar Ventas y Tickets | RF-21, RF-40, RF-41, RF-42, RF-43, RF-44, RF-45, RF-46, RF-47, RF-48, RF-49, RF-50, RF-51, RF-52, RF-53, RF-54, RF-55, RF-76 |
| **4.0** | Generar Reportes y Analítica | RF-56, RF-57, RF-58, RF-59, RF-60, RF-61, RF-62, RF-63, RF-64, RF-65, RF-66 |
| **5.0** | Publicar Catálogo Digital Web | RF-67, RF-68, RF-69, RF-70, RF-71, RF-72 |
