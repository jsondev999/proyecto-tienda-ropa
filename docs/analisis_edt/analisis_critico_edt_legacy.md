# Análisis Crítico y Diagnóstico de la EDT (Legacy v1.0)
## Módulo de Desarrollo y Programación del Sistema

> **Proyecto:** SYSELL — Sistema Web de Gestión de Inventario y Ventas  
> **Documento Fuente:** `docs/legacy_v1.0/TRAJO FINAL II (ANALISIS DE SISTEMAS)).pdf` (Sección 1.1 Diagrama de EDT y 1.2 Diccionario de la EDT, Págs. 5–24)  
> **Área Evaluada:** Cuenta de Control `1.3.3. Programar el sistema` (Fase de Ejecución)  
> **Fecha:** Octubre 2026  
> **Equipo Evaluador:** Pollitos Design  

---

## 1. Contexto y Alcance del Análisis

En el documento previo *Trabajo Final II*, la Estructura de Desglose del Trabajo (EDT / WBS) dividía el ciclo del proyecto en cinco fases clásicas del PMBOK:
1. `1.1. Fase de Inicio`
2. `1.2. Fase de Planificación`
3. `1.3. Fase de Ejecución`
4. `1.4. Fase de Seguimiento`
5. `1.5. Fase de Cierre`

Dentro de la **Fase de Ejecución (1.3)**, el desarrollo del software se concentró formalmente bajo la cuenta de control **`1.3.3. Programar el sistema`**.

Este análisis tiene como objetivo revisar críticamente cada paquete de trabajo definido en dicha cuenta de control, evaluar su viabilidad técnica, coherencia metodológica y pertinencia respecto a las necesidades reales de una tienda de ropa comercial moderna, y contrastarlo con los estándares actuales del proyecto: **Metodología Híbrida RUP + Scrum, Clean Architecture, CQRS y Base de Datos Relacional Normalizada**.

---

## 2. Inventario de Paquetes de Trabajo Legacy en `1.3.3 Programar el sistema`

En el documento fuente se registran los siguientes paquetes:

| Código en PDF | Nombre del Paquete en PDF | Duración Est. | Costo Est. | Responsable | Criterio de Aceptación Declarado |
|:---:|---|:---:|:---:|---|---|
| **1.3.1.1** *(error de codificación)* | Programar login | 8 días | S/. 150.00 | Johan Mamani | "Haya sido probado en diferentes escenarios de acceso" |
| **1.3.1.2** *(error de codificación)* | Programar módulo de inventario | 8 días | S/. 200.00 | Johan Mamani | "Se acepta cuando esté funcionando sin errores" |
| **1.3.1.3** *(error de codificación)* | Programar módulo de registro de ventas | 15 días | S/. 200.00 | Johan Mamani | "Se acepta cuando esté funcionando sin errores" |
| **1.3.1.4** *(error de codificación)* | Programar módulo de reporte de ventas | 14 días | S/. 200.00 | Johan Mamani | "Se acepta cuando los reportes de ventas se generen correctamente" |
| **1.3.1.5** *(error de codificación)* | Programar módulo de gestión de catálogo | 8 días | S/. 200.00 | Johan Mamani | "Se acepta cuando permita realizar las operaciones correspondientes sin errores" |

---

## 3. Diagnóstico Crítico: Deficiencias, Errores y Brechas Encontradas

### 3.1. Errores Estructurales y de Codificación Jerárquica
* **Inconsistencia de nomenclatura WBS:**  
  La cuenta de control padre es `1.3.3. Programar el sistema`. Sin embargo, todos sus hijos fueron codificados como `1.3.1.1`, `1.3.1.2`, `1.3.1.3`, `1.3.1.4`, `1.3.1.5`.  
  El prefijo `1.3.1` ya pertenecía a la cuenta *1.3.1 Analizar requerimientos*. En una EDT formal conforme al PMBOK / ISO 21500, los códigos de segundo nivel jerárquico deben ser descendientes directos: `1.3.3.1`, `1.3.3.2`, etc.

### 3.2. Enfoque Monolítico en Cascada dentro de cada Paquete
* En prácticamente todos los paquetes analizados, las actividades listadas son:
  1. *Diseñar la base de datos...*
  2. *Desarrollar las funcionalidades...*
  3. *Realizar pruebas...*
* **Problema:** En el desarrollo real de software, la base de datos es un modelo integral unificado (con claves foráneas, integridad referencial y restricciones ACID). No se "diseña una BD distinta" para inventario y otra para catálogo.  
* Además, este desglose ignora por completo la arquitectura de software adoptada en el proyecto: **Clean Architecture con CQRS**, donde cada funcionalidad se desglosa horizontal y verticalmente en capas:
  - Capa de Dominio (Entidades de Negocio, Value Objects, Reglas de Invariante).
  - Capa de Aplicación (Commands para mutaciones, Queries para lectura optimizada, DTOs).
  - Capa de Infraestructura (Persistencia, Repositorios, Transacciones).
  - Capa de Presentación (APIs / Controladores y Vistas Web reactivas).

### 3.3. Criterios de Aceptación Vagos y No Medibles
* Frases como *"Se acepta cuando esté funcionando sin errores"* (1.3.1.2, 1.3.1.3, 1.3.1.5) vulneran las buenas prácticas de ingeniería de requisitos y QA.
* No establecen qué es un "error", qué nivel de cobertura de pruebas se exige, qué tiempos de respuesta son tolerables ni cuáles son las condiciones de borde (ej. concurrencia en stock, pagos mixtos).
* **Solución requerida:** Adoptar criterios de aceptación formales en formato **Gherkin / DoR / DoD**, validados por historias de usuario y suites de pruebas automatizadas.

### 3.4. Sobrecarga y Ausencia de Especialización de Roles
* En los 5 paquetes, el responsable único asignado es Johan Mamani (Líder del Proyecto), mientras que Luis Condori y Alex Chata figuran como "Participa / Revisa".
* Esto genera un cuello de botella artificial y contradice la distribución real del equipo de 4 integrantes definida en el Working Agreement (Johan Mamani como PM/PO, Luis Condori en UX/Análisis, Aron Cachicatari como Líder Técnico / Desarrollador Full-Stack, Giorgini Disalvatore como Analista QA y Scrum Master).

### 3.5. Omisiones Críticas del Modelo de Negocio de SYSELL
Al contrastar la EDT legacy con la especificación de requisitos actual (`docs/requisitos_funcionales.md`) y el modelo relacional (`docs/documentacion_tecnica_bd.md`), se evidencian las siguientes **ausencias graves**:

| Módulo Crítico Faltante en EDT Legacy | Impacto en el Negocio | Requisito Relacionado |
|---|---|---|
| **Gestión de Caja y Arqueo (Turnos)** | Sin apertura/cierre de caja, es imposible auditar el flujo de efectivo del vendedor al final del día. | RF-13, RF-14 |
| **Medios de Pago Múltiples y Mixtos** | En el comercio minorista peruano actual, los clientes combinan Efectivo + Yape/Plin o Tarjeta en una sola compra. El legacy asumía venta simple. | RF-10 |
| **Abastecimiento y Compras a Proveedores** | El inventario no aparece por arte de magia; requiere un flujo formal de órdenes de compra y recepción de stock. | RF-08, RF-16 |
| **Variantes de Producto (Talla y Color)** | En una tienda de ropa no se vende un "polo genérico"; se venden variantes con stock diferenciado por SKU (Talla S/M/L, Color Azul/Rojo). | RF-04 |
| **Movimientos de Kardex y Ajustes de Stock** | No se contemplaban mermas, pérdidas o ajustes manuales auditados por inventario físico. | RF-06, RF-07 |
| **Gestión de Seguridad Integral (RBAC)** | Solo mencionaba "login", omitiendo la autorización por roles (Administrador vs. Vendedor) y permisos de pantalla/endpoint. | RF-01, RF-02 |
| **Auditoría y Trazabilidad** | No existía registro de auditoría de operaciones sensibles (anulaciones de venta, cambios de precio). | RF-18 |

---

## 4. Matriz Comparativa: EDT Legacy vs. Realidad del Proyecto SYSELL

```
+------------------------------------+      +-----------------------------------------+
|       EDT LEGACY (V1.0)            |      |      EDT OPTIMIZADA SYSELL (V2.0)       |
+------------------------------------+      +-----------------------------------------+
| [1.3.1.1] Programar Login          | ---> | [1.3.3.1] Módulo Autenticación y RBAC   |
| [1.3.1.5] Programar Catálogo       | ---> | [1.3.3.2] Catálogo y Variantes (SKU)    |
| [1.3.1.2] Programar Inventario     | ---> | [1.3.3.3] Inventario, Kardex y Compras  |
| [1.3.1.3] Programar Registro Venta | ---> | [1.3.3.4] Punto de Venta (POS) & Pagos  |
|         (INEXISTENTE)              | ---> | [1.3.3.5] Control de Caja y Arqueos     |
|         (INEXISTENTE)              | ---> | [1.3.3.6] Gestión Clientes & Proveedor  |
| [1.3.1.4] Programar Reportes Venta | ---> | [1.3.3.7] Analítica, Reportes & Audit   |
|         (INEXISTENTE)              | ---> | [1.3.3.8] Pruebas Integrales & Despliegue|
+------------------------------------+      +-----------------------------------------+
```

---

## 5. Dictamen y Conclusiones del Análisis

1. **La sección 1.3.3 de la EDT legacy es insuficiente y desactualizada** para guiar el desarrollo de un sistema de producción o un proyecto académico riguroso de Ingeniería de Software.
2. **Es indispensable reestructurar la cuenta de control `1.3.3`**, renombrando y expandiendo sus paquetes de trabajo en conformidad con los 18 Requisitos Funcionales aprobados.
3. Cada nuevo paquete de trabajo debe desglosarse en tareas técnicas alineadas a los patrones **Clean Architecture + CQRS**, garantizando que el equipo de desarrollo y QA tengan criterios claros de completitud (DoR/DoD).
4. La nueva EDT servirá de base directa para articular el **Product Backlog**, agrupar las Historias de Usuario por Épicas y alimentar los **4 Sprints** de la metodología híbrida.
