# Historias de Usuario — Sistema Web SYSELL

Este directorio contiene las **18 Historias de Usuario (HU)** formales del sistema SYSELL, estructuradas y detalladas de acuerdo a los estándares ágiles de Scrum, con trazabilidad directa a los 18 Requisitos Funcionales (`RF-01` al `RF-18`) y al modelo de arquitectura **Clean Architecture + CQRS**.

---

## Estructura de Carpetas y Documentos

```
docs/historias_de_usuario/
├── README.md                                 ← Índice general y estándar de especificación
├── EP-01_seguridad_acceso.md                 ← HU-01, HU-02
├── EP-02_catalogo_prendas.md                 ← HU-03, HU-04, HU-05
├── EP-03_inventario_kardex_compras.md        ← HU-06, HU-07, HU-08
├── EP-04_punto_de_venta_pos.md               ← HU-09, HU-10, HU-11, HU-12
├── EP-05_control_caja_turnos.md              ← HU-13, HU-14
├── EP-06_directorio_comercial.md             ← HU-15, HU-16
└── EP-07_analitica_auditoria.md              ← HU-17, HU-18
```

---

## Tabla Resumen de Historias de Usuario

| ID | Épica | Título de la Historia de Usuario | Story Points | Prioridad MoSCoW | RF Mapeado | Sprint Asignado |
|:---:|---|---|:---:|:---:|:---:|:---:|
| **HU-01** | EP-01 Seguridad | Autenticación Segura y Gestión de Sesión | 5 | **MUST** | RF-02 | Sprint 1 |
| **HU-02** | EP-01 Seguridad | Control de Acceso Basado en Roles y Permisos (RBAC) | 5 | **MUST** | RF-01 | Sprint 1 |
| **HU-03** | EP-02 Catálogo | Gestión de Marcas y Categorías Maestras | 3 | **MUST** | RF-03 | Sprint 1 |
| **HU-04** | EP-02 Catálogo | Catálogo de Productos y Variantes Físicas (Talla/Color/SKU) | 8 | **MUST** | RF-04 | Sprint 1 |
| **HU-05** | EP-02 Catálogo | Configuración de Precios y Tarifas de Venta | 3 | **MUST** | RF-05 | Sprint 3 |
| **HU-06** | EP-03 Inventario | Control de Stock por Almacén y Alertas de Quiebre | 5 | **MUST** | RF-06 | Sprint 2 |
| **HU-07** | EP-03 Inventario | Movimientos de Kardex y Ajustes de Inventario Físico | 8 | **MUST** | RF-07 | Sprint 2 |
| **HU-08** | EP-03 Inventario | Órdenes de Compra y Recepción de Mercadería | 5 | **SHOULD** | RF-08 | Sprint 2 |
| **HU-09** | EP-04 POS | Terminal de Venta Rápida (POS) y Carrito Transaccional | 8 | **MUST** | RF-09 | Sprint 3 |
| **HU-10** | EP-04 POS | Liquidación Multitendencia de Medios de Pago Mixtos | 8 | **MUST** | RF-10 | Sprint 3 |
| **HU-11** | EP-04 POS | Emisión y Generación de Comprobantes de Venta | 5 | **MUST** | RF-11 | Sprint 3 |
| **HU-12** | EP-04 POS | Anulación Controlada de Venta y Restitución de Stock | 5 | **SHOULD** | RF-12 | Sprint 3 |
| **HU-13** | EP-05 Caja | Apertura, Cierre y Arqueo Ciego de Caja | 8 | **MUST** | RF-13 | Sprint 2 |
| **HU-14** | EP-05 Caja | Registro de Entradas y Salidas Menores de Efectivo | 3 | **MUST** | RF-14 | Sprint 2 |
| **HU-15** | EP-06 Comercial | Directorio y Búsqueda Rápida de Clientes en POS | 3 | **SHOULD** | RF-15 | Sprint 3 |
| **HU-16** | EP-06 Comercial | Directorio y Mantenimiento de Proveedores | 3 | **COULD** | RF-16 | Sprint 3 |
| **HU-17** | EP-07 Analítica | Tablero de Reportería Estratégica y Métricas de Ventas | 5 | **SHOULD** | RF-17 | Sprint 4 |
| **HU-18** | EP-07 Analítica | Registro de Auditoría y Trazabilidad del Sistema | 5 | **MUST** | RF-18 | Sprint 4 |

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
