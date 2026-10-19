# Historias de Usuario — Sistema Web SYSELL

Este directorio contiene las **18 Historias de Usuario (HU)** formales del sistema SYSELL, estructuradas y detalladas de acuerdo a los estándares ágiles de Scrum, con trazabilidad directa a los 18 Requisitos Funcionales (`RF-01` al `RF-18`) y al modelo de arquitectura **Clean Architecture + CQRS**.

---

## Estructura de Carpetas y Documentos

```
docs/historias_de_usuario/
├── README.md                                 ← Índice general y estándar de especificación
├── matriz_tasks_sprint_backlog.md            ← Desglose de tareas técnicas por Sprint (Tasks de desarrollo)
├── EP-01_seguridad_acceso.md                 ← HU-01, HU-02
├── EP-02_catalogo_prendas.md                 ← HU-03, HU-04, HU-05
├── EP-03_inventario_kardex_compras.md        ← HU-06, HU-07, HU-08
├── EP-04_punto_de_venta_pos.md               ← HU-09, HU-10, HU-11, HU-12
├── EP-05_control_caja_turnos.md              ← HU-13, HU-14
├── EP-06_directorio_comercial.md             ← HU-15, HU-16
└── EP-07_analitica_auditoria.md              ← HU-17, HU-18
```

---

## Tabla Resumen de Historias de Usuario y Mapeo a los 77 RFs Detallados

En concordancia con el marco de ingeniería del proyecto, las **18 Historias de Usuario (HUs)** actúan como unidades de entrega ágil (Product Backlog Items) que agrupan y operacionalizan los **77 Requisitos Funcionales Técnicos (`RF-01` al `RF-77`)** definidos en la [Matriz de Trazabilidad Integral](../matriz_de_trazabilidad.md) y los [Casos de Prueba IEEE 829](../casos_de_prueba.md):

| ID HU | Épica | Título de la Historia de Usuario | Story Points | Prioridad MoSCoW | RFs Detallados Cubiertos (77 RFs) | Casos de Uso | Sprint |
|:---:|---|---|:---:|:---:|---|:---:|:---:|
| **HU-01** | EP-01 Seguridad | Autenticación Segura y Gestión de Sesión | 5 | **MUST** | `RF-01` al `RF-06`, `RF-09` *(Login, JWT, bloqueo, logout)* | `CU-01`, `CU-03` | Sprint 1 |
| **HU-02** | EP-01 Seguridad | Control de Acceso RBAC y Gestión de Usuarios | 5 | **MUST** | `RF-07`, `RF-08`, `RF-10` al `RF-14`, `RF-73` *(Roles, CRUD, reset)* | `CU-02` | Sprint 1 |
| **HU-03** | EP-02 Catálogo | Gestión de Marcas y Categorías Maestras | 3 | **MUST** | `RF-26` al `RF-34`, `RF-74` *(Catálogos cerrados maestros)* | `CU-07` | Sprint 1 |
| **HU-04** | EP-02 Catálogo | Catálogo de Productos y Variantes Físicas | 8 | **MUST** | `RF-15` al `RF-19` *(Registro prenda, SKU, fotos, stock inicial)* | `CU-05` | Sprint 1 |
| **HU-05** | EP-02 Catálogo | Configuración de Precios y Tarifas de Venta | 3 | **MUST** | `RF-16`, `RF-39` *(Edición precios y rangos tarifarios)* | `CU-05` | Sprint 3 |
| **HU-06** | EP-03 Inventario | Control de Stock por Almacén y Alertas | 5 | **MUST** | `RF-22` al `RF-25`, `RF-77` *(Stock multi-local, alertas reposición)* | `CU-04`, `CU-06` | Sprint 2 |
| **HU-07** | EP-03 Inventario | Movimientos de Kardex y Ajustes de Inventario | 8 | **MUST** | `RF-20`, `RF-35` al `RF-38`, `RF-75` *(Kardex, búsqueda, filtros)* | `CU-04`, `CU-06` | Sprint 2 |
| **HU-08** | EP-03 Inventario | Órdenes de Compra y Recepción Mercadería | 5 | **SHOULD** | `RF-20` *(Recepción y alta de stock por lote en inventario)* | `CU-06` | Sprint 2 |
| **HU-09** | EP-04 POS | Terminal de Venta Rápida (POS) y Carrito | 8 | **MUST** | `RF-21`, `RF-40` al `RF-44` *(POS, carrito, cálculo totales)* | `CU-08` | Sprint 3 |
| **HU-10** | EP-04 POS | Liquidación Multitendencia Medios de Pago | 8 | **MUST** | `RF-45`, `RF-46` *(Efectivo, tarjetas, billeteras y cambio)* | `CU-08` | Sprint 3 |
| **HU-11** | EP-04 POS | Emisión de Tickets Digitales e Impresión | 5 | **MUST** | `RF-47` al `RF-50`, `RF-76` *(Ticket digital, PDF, WhatsApp, sin SUNAT)*| `CU-09` | Sprint 3 |
| **HU-12** | EP-04 POS | Anulación Controlada y Restitución Stock | 5 | **SHOULD** | `RF-51` al `RF-53` *(Historial, detalle y anulación Admin)* | `CU-11`, `CU-12` | Sprint 3 |
| **HU-13** | EP-05 Caja | Apertura, Cierre y Arqueo Ciego de Caja | 8 | **MUST** | *Control Operativo de Turno en POS (Extensión CU-08)* | `CU-08` | Sprint 2 |
| **HU-14** | EP-05 Caja | Registro de Entradas y Salidas Menores | 3 | **MUST** | *Movimientos de Caja Menor (Extensión CU-08)* | `CU-08` | Sprint 2 |
| **HU-15** | EP-06 Comercial | Directorio y Búsqueda de Clientes en POS | 3 | **SHOULD** | *Datos de Contacto para Envío de Ticket (Extensión CU-09)* | `CU-09` | Sprint 3 |
| **HU-16** | EP-06 Comercial | Directorio y Mantenimiento de Proveedores | 3 | **COULD** | *Gestión de Contactos de Compra (Extensión CU-06)* | `CU-06` | Sprint 3 |
| **HU-17** | EP-07 Analítica | Tablero de Reportería y Métricas Estratégicas | 5 | **SHOULD** | `RF-56` al `RF-66` *(Reportes, PDF/Excel, rankings, gráficos)* | `CU-13`, `CU-14` | Sprint 4 |
| **HU-18** | EP-07 Analítica | Registro de Auditoría y Trazabilidad del Sistema| 5 | **MUST** | `RF-08`, `RF-53`, *Bitácora de Eventos Críticos (`auditoria`)* | `CU-02`, `CU-12` | Sprint 4 |
| **PÚB-01**| Web Pública | Catálogo Digital Público y Disponibilidad | — | **MUST** | `RF-67` al `RF-72` *(Navegación pública, fotos HD, responsive)* | `CU-15` | Sprint 4 |

> 📌 **Nota sobre Alcance de Base de Datos:** Las operaciones de Caja Menor (`HU-13`, `HU-14`), Identificación de Clientes (`HU-15`) y Proveedores (`HU-16`) se integran a nivel operativo en las ventas y auditoría del sistema, registrándose en la bitácora `auditoria` y en los metadatos de tickets de venta en el MVP actual.

**Total de Story Points:** 94 SP distribuidos en 4 Sprints (promedio de 23.5 SP por Sprint).

---

## Estándar de Redacción de cada Historia

Cada historia de usuario en los documentos de épica sigue la estructura:
1. **Identificador, Título y Metadatos** (Rol, Estimación, Prioridad, Trazabilidad).
2. **Narrativa de Usuario:** Formato tradicional `Como [rol], Quiero [acción], Para [beneficio]`.
3. **Criterios de Aceptación (Gherkin):** Escenarios formales `Dado [contexto], Cuando [evento], Entonces [resultado esperado]`.
4. **Desglose Técnico (Clean Architecture + CQRS):**
   - *Capa de Dominio:* Entidades, Value Objects, Reglas de Invariante.
   - *Capa de Aplicación:* Commands / Queries y DTOs específicos.
   - *Capa de Infraestructura:* Persistencia, repositorios, pasarelas externas.
   - *Capa de Presentación:* Componentes UI, endpoints API y validaciones cliente.
5. **Criterios DoR y DoD Específicos.**
