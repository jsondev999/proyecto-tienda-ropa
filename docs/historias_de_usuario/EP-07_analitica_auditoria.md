# Épica 07: Reportería Estratégica, Analítica y Auditoría

> **Módulo:** Analítica de Negocio y Control de Calidad  
> **Requisitos Trazables:** `RF-17`, `RF-18`, `RNF-05`  
> **Paquete EDT Relacionado:** `1.3.3.7 Módulo Reportería Estratégica, Analítica y Auditoría`  

---

## Historia de Usuario: HU-17
### Título: Tablero de Reportería Estratégica y Métricas de Ventas

| Atributo | Detalle |
|---|---|
| **Identificador** | `HU-17` |
| **Rol Principal** | Administrador |
| **Prioridad MoSCoW** | **SHOULD HAVE** |
| **Estimación** | 5 Story Points |
| **Sprint Sugerido** | Sprint 4 |
| **Dependencias** | HU-09, HU-10 |

### 1. Narrativa
```text
Como Administrador de la tienda,
Quiero visualizar paneles gráficos y reportes detallados de ventas por fecha, recaudación por medio de pago y ranking de prendas más vendidas por talla y color,
Para evaluar el rendimiento comercial del negocio y tomar decisiones de compra basadas en datos reales.
```

### 2. Criterios de Aceptación (Gherkin)

#### Escenario 1: Dashboard de ventas por rango de fechas
* **Dado** que el Administrador accede al módulo de Analítica,
* **Cuando** selecciona un rango de fechas (ej. último mes),
* **Entonces** el sistema presenta el total recaudado, el ticket promedio y un gráfico de barras interactivo con la evolución diaria de ventas.

#### Escenario 2: Reporte de prendas más vendidas (Top Sellers)
* **Dado** que se consulta el ranking de prendas,
* **Cuando** el usuario solicita el Top 10 de artículos vendidos,
* **Entonces** el sistema desglosa los artículos agrupando por variante (nombre de prenda, talla y color) indicando cantidad total vendida e ingreso generado.

#### Escenario 3: Exportación de datos a Excel / CSV
* **Dado** que se visualiza una tabla de resultados en el reporte,
* **Cuando** el usuario presiona "Exportar a Excel",
* **Entonces** el sistema genera y descarga un archivo `.xlsx` estructurado con la información filtrada en menos de 3 segundos.

### 3. Consideraciones Técnicas (Clean Architecture + CQRS)
* **Dominio:** Definición de entidades de agregación y DTOs analíticos.
* **Aplicación:** Queries especializadas CQRS de alta velocidad:
  - `GetDashboardResumenQuery(DateTime Desde, DateTime Hasta)`.
  - `GetTopPrendasVendidasQuery(int TopCount, DateTime Desde, DateTime Hasta)`.
  - `GetVentasPorMedioPagoQuery(DateTime Desde, DateTime Hasta)`.
* **Infraestructura:** Consultas optimizadas con cláusulas `GROUP BY` e índices compuestos sobre `fecha_venta`.
* **Presentación:** Gráficos responsivos (Chart.js / CSS Grid) y selector de rangos de fechas (Hoy, Esta semana, Este mes, Personalizado).

---

## Historia de Usuario: HU-18
### Título: Registro de Auditoría y Trazabilidad del Sistema

| Atributo | Detalle |
|---|---|
| **Identificador** | `HU-18` |
| **Rol Principal** | Administrador |
| **Prioridad MoSCoW** | **MUST HAVE** |
| **Estimación** | 5 Story Points |
| **Sprint Sugerido** | Sprint 4 |
| **Dependencias** | HU-01, HU-02 |

### 1. Narrativa
```text
Como Administrador,
Quiero consultar una bitácora inmutable de auditoría donde se registren automáticamente los eventos críticos del sistema (anulaciones de venta, cambios de precios, ajustes manuales de stock y accesos no autorizados),
Para asegurar la total transparencia operativa, disuadir fraudes internos y tener evidencia forense ante discrepancias.
```

### 2. Criterios de Aceptación (Gherkin)

#### Escenario 1: Registro automático de evento sensible
* **Dado** que un usuario ejecuta una acción crítica (ej. Anular una venta o Cambiar el precio de una variante),
* **Cuando** la transacción de base de datos se confirma exitosamente,
* **Entonces** el interceptor de auditoría inserta automáticamente un registro en la tabla `auditoria` guardando: `UsuarioId`, `Accion`, `TablaAfectada`, `RegistroId`, `ValoresPrevios`, `ValoresNuevos`, `DireccionIP` y `Timestamp`.

#### Escenario 2: Inmutabilidad estricta del log de auditoría
* **Dado** que existen registros en la tabla de auditoría,
* **Cuando** cualquier usuario (incluso con perfil Administrador) intenta modificar o purgar filas del log,
* **Entonces** el sistema deniega la acción; no existen endpoints ni permisos de mutación sobre la bitácora.

#### Escenario 3: Filtro y búsqueda en la bitácora
* **Dado** que el Administrador investiga una irregularidad,
* **Cuando** filtra los logs por usuario, tipo de acción o rango horario,
* **Entonces** el sistema devuelve la lista cronológica detallando qué usuario ejecutó cada operación.

### 3. Consideraciones Técnicas (Clean Architecture + CQRS)
* **Dominio:** Entidad `LogAuditoria` (Id, UsuarioId, Accion, Entidad, EntidadId, DatosPreviosJson, DatosNuevosJson, IpOrigen, Fecha).
* **Aplicación:** Pipeline Behavior / Middleware que intercepta Commands de mutación y graba eventos en segundo plano.
  - Query: `GetLogsAuditoriaQuery(FiltrosAuditoriaDto Filtros)`.
* **Infraestructura:** Tabla con política `INSERT ONLY` y retención histórica.
* **Presentación:** Visor de auditoría con visor comparativo de cambios tipo diff (JSON previo vs JSON nuevo).
