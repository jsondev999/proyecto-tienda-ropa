# Product Backlog Priorizado — Sistema SYSELL

> **Proyecto:** SYSELL — Sistema Web de Gestión de Inventario y Ventas  
> **Metodología:** Híbrida RUP + Scrum  
> **Equipo:** Pollitos Design  
> **Horizonte:** 4 Sprints (28 días calendario)  
> **Capacidad Estimada:** 20–25 Story Points por Sprint (Total: 94 SP)  
> **Fecha de Actualización:** Octubre 2026  

---

## 1. Definición del Backlog y Criterios de Calidad

El **Product Backlog** es el inventario ordenado y vivo de todo el trabajo que el equipo necesita realizar en SYSELL. Cada elemento del backlog (PBI) es una Historia de Usuario que cumple estrictamente con los filtros de calidad acordados en el [Working Agreement](file:///Users/aron/githubRepo/proyecto-tienda-ropa/docs/acuerdos/acuerdo_trabajo_equipo.md).

### 1.1. Filtro de Entrada: Definition of Ready (DoR)
Para que una historia de usuario pueda ser seleccionada en un Sprint Planning, debe satisfacer:
1. **Formato estándar:** Redactada como *"Como [rol], Quiero [acción], Para [beneficio]"*.
2. **Criterios de Aceptación:** Definidos formalmente en sintaxis Gherkin (*Dado / Cuando / Entonces*).
3. **Estimación:** Puntuada por el equipo mediante Planning Poker en la escala Fibonacci (1, 2, 3, 5, 8, 13).
4. **Independencia (INVEST):** Sin dependencias bloqueantes no resueltas de sprints futuros.
5. **Alineación de Arquitectura:** Mapeada a las 4 capas de Clean Architecture y clasificada como Command o Query (CQRS).
6. **Diseño de Interfaz:** Mockup o prototipo conceptual validado por el Diseñador/Analista (Luis Condori).
7. **Trazabilidad:** Asociada a un Requisito Funcional formal (`RF-XX`).

### 1.2. Filtro de Salida: Definition of Done (DoD)
Una historia solo se considera **Terminada** (Done) si:
1. El código compila sin errores ni warnings críticos en la rama de integración.
2. Respeta las capas de Clean Architecture (el Dominio no depende de bibliotecas externas ni bases de datos).
3. Pruebas unitarias ejecutadas con cobertura mínima del 80% en lógica de negocio.
4. Cumple el 100% de los criterios de aceptación Gherkin verificados por QA (Giorgini Disalvatore).
5. Revisión de código (Pull Request) aprobada por el Líder Técnico (Aron Cachicatari) y validada por el PO (Johan Mamani).
6. Base de datos actualizada mediante scripts o migraciones versionadas y reproducibles.
7. Desplegado y verificado en el entorno de pruebas/staging.

---

## 2. Matriz Maestra del Product Backlog (Priorizada por Valor y Dependencias)

| Prioridad | ID HU | Épica | Título de la Historia de Usuario | SP | MoSCoW | Valor Negocio | Complejidad Técnica | Dependencias | Sprint | Estado DoR |
|:---:|:---:|---|---|:---:|:---:|:---:|:---:|:---:|:---:|:---:|
| **1** | `HU-01` | EP-01 Seguridad | Autenticación Segura y Gestión de Sesión | 5 | **MUST** | Crítico | Media | Ninguna | Sprint 1 | **READY** |
| **2** | `HU-02` | EP-01 Seguridad | Control de Acceso Basado en Roles y Permisos (RBAC) | 5 | **MUST** | Crítico | Media | HU-01 | Sprint 1 | **READY** |
| **3** | `HU-03` | EP-02 Catálogo | Gestión de Marcas y Categorías Maestras | 3 | **MUST** | Alto | Baja | HU-01, HU-02 | Sprint 1 | **READY** |
| **4** | `HU-04` | EP-02 Catálogo | Catálogo de Productos y Variantes (Talla/Color/SKU) | 8 | **MUST** | Crítico | Alta | HU-03 | Sprint 1 | **READY** |
| **5** | `HU-05` | EP-02 Catálogo | Configuración de Precios y Tarifas de Venta | 3 | **MUST** | Alto | Baja | HU-04 | Sprint 1 | **READY** |
| **6** | `HU-13` | EP-05 Caja | Apertura, Cierre y Arqueo Ciego de Caja | 8 | **MUST** | Crítico | Alta | HU-01, HU-02 | Sprint 2 | **READY** |
| **7** | `HU-14` | EP-05 Caja | Registro de Entradas y Salidas Menores de Efectivo | 3 | **MUST** | Medio | Baja | HU-13 | Sprint 2 | **READY** |
| **8** | `HU-06` | EP-03 Inventario | Control de Stock por Almacén y Alertas de Quiebre | 5 | **MUST** | Crítico | Media | HU-04 | Sprint 2 | **READY** |
| **9** | `HU-07` | EP-03 Inventario | Movimientos de Kardex y Ajustes de Inventario Físico | 8 | **MUST** | Crítico | Alta | HU-06 | Sprint 2 | **READY** |
| **10** | `HU-08` | EP-03 Inventario | Órdenes de Compra y Recepción de Mercadería | 5 | **SHOULD** | Alto | Media | HU-06, HU-07 | Sprint 2 | **READY** |
| **11** | `HU-15` | EP-06 Comercial | Directorio y Búsqueda Rápida de Clientes en POS | 3 | **SHOULD** | Alto | Baja | HU-01 | Sprint 3 | **READY** |
| **12** | `HU-16` | EP-06 Comercial | Directorio y Mantenimiento de Proveedores | 3 | **COULD** | Medio | Baja | HU-01 | Sprint 3 | **READY** |
| **13** | `HU-09` | EP-04 POS | Terminal de Venta Rápida (POS) y Carrito Transaccional | 8 | **MUST** | Crítico | Alta | HU-04, HU-06, HU-13 | Sprint 3 | **READY** |
| **14** | `HU-10` | EP-04 POS | Liquidación Multitendencia de Medios de Pago Mixtos | 8 | **MUST** | Crítico | Alta | HU-09, HU-13 | Sprint 3 | **READY** |
| **15** | `HU-11` | EP-04 POS | Emisión y Generación de Comprobantes de Venta | 5 | **MUST** | Alto | Media | HU-10 | Sprint 3 | **READY** |
| **16** | `HU-12` | EP-04 POS | Anulación Controlada de Venta y Restitución de Stock | 5 | **SHOULD** | Alto | Media | HU-10, HU-11 | Sprint 3 | **READY** |
| **17** | `HU-17` | EP-07 Analítica | Tablero de Reportería Estratégica y Métricas de Ventas | 5 | **SHOULD** | Alto | Media | HU-09, HU-10 | Sprint 4 | **READY** |
| **18** | `HU-18` | EP-07 Analítica | Registro de Auditoría y Trazabilidad del Sistema | 5 | **MUST** | Crítico | Media | HU-01, HU-02 | Sprint 4 | **READY** |

---

## 3. Distribución de Carga y Capacidad por Sprint

```
+--------------------------------------------------------------------------------------+
|                               DISTRIBUCIÓN DEL BACKLOG                               |
+-------------------+-------------------------------------------+-----------+----------+
| Sprint            | Historias Asignadas                       | Puntos    | % Total  |
+-------------------+-------------------------------------------+-----------+----------+
| Sprint 1          | HU-01, HU-02, HU-03, HU-04, HU-05         | 24 SP     | 25.5 %   |
| Sprint 2          | HU-06, HU-07, HU-08, HU-13, HU-14         | 29 SP     | 30.8 %   |
| Sprint 3          | HU-09, HU-10, HU-11, HU-12, HU-15, HU-16  | 32 SP     | 34.0 %   |
| Sprint 4          | HU-17, HU-18 + Hardening, UAT y VPS       | 10 SP (*) | 9.7 %    |
+-------------------+-------------------------------------------+-----------+----------+
| TOTAL             | 18 Historias de Usuario                   | 94 SP     | 100 %    |
+-------------------+-------------------------------------------+-----------+----------+
```
*(*) En el Sprint 4 se asignan 10 SP de historias funcionales para reservar el 60% de la capacidad del equipo en actividades de pruebas de carga, corrección de defectos menores (Bug fixing), auditoría de seguridad y despliegue final en producción.*

---

## 4. Clasificación MoSCoW del Alcance Global

* **MUST HAVE (80 SP / 85.1%):**  
  Las 13 historias vitales sin las cuales el sistema no puede operar legalmente ni comercialmente: Autenticación, Roles, Catálogo, Tallas/Colores, Precios, Stock, Kardex, Caja/Arqueo, POS, Medios de Pago, Comprobante y Auditoría.
* **SHOULD HAVE (11 SP / 11.7%):**  
  Funcionalidades de alto impacto que enriquecen la operativa: Órdenes de compra a proveedores (HU-08), Clientes en POS (HU-15) y Dashboard estadístico (HU-17).
* **COULD HAVE (3 SP / 3.2%):**  
  Mantenimiento de directorio de proveedores (HU-16).
* **WON'T HAVE (Para versión futura v2.1):**  
  Integración directa con pasarela de pagos Visa/Mastercard online (se maneja cobro manual vía POS físico) e integración automática con facturación electrónica OSE/SUNAT en la nube (se emiten comprobantes de control interno).
