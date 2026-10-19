# Sistema de Gestión — Tienda de Ropa para Varón (SYSELL Web v2.0)

> **Denominación Formal:** **SYSELL Web**  
> **Denominación Comercial:** **Sistema de Gestión para Tienda de Ropa para Varón (v2.0)** para la tienda comercial de indumentaria masculina *Machi's*.  
> **Equipo de Ingeniería:** Pollitos Design — Escuela Profesional de Ingeniería en Informática y Sistemas (ESIS), UNJBG  
> **Metodología:** Enfoque Híbrido RUP + Scrum (Clean Architecture + CQRS)

Sistema integral de gestión de ventas, control de inventario y catálogo digital diseñado para una tienda de ropa masculina con dos locales físicos.

---

## 📌 Contexto del Proyecto y Transición a la Versión 2.0

Este repositorio representa la **Versión 2.0** del proyecto. La versión anterior (**v1.0**) sirvió como un antecedente preliminar, pero presentaba debilidades críticas en su estructuración:
- Requisitos ambiguos e incompletos que dejaban dudas al programar.
- Falta de catálogos maestros obligatorios (riesgo de texto libre en colores, tallas y marcas).
- Confusión entre aplicaciones móviles nativas y sistemas web centralizados.
- Ausencia de diagramas y modelado formal de casos de uso.

Por ello, se tomó la decisión de **refundar el proyecto desde sus cimientos**, formalizando 77 requerimientos funcionales técnicos, 14 no funcionales y modelando toda la interacción en diagramas PlantUML.

> 📁 Para consultar la documentación previa y ver el análisis comparativo detallado, revisa la carpeta: [`docs/legacy_v1.0/`](docs/legacy_v1.0/).

---

## ⚖️ Resumen Comparativo: v1.0 vs. v2.0

| Dimensión | Versión 1.0 (Legado) | Versión 2.0 (Actual) |
|---|---|---|
| **Madurez de Requisitos** | 72 requisitos empíricos y breves. | **77 requisitos** exhaustivos con criterios técnicos de aceptación. |
| **Modelado UML** | Inexistente. | **Diagramas de Casos de Uso completos** (fuentes `.puml` e imágenes `.png`). |
| **Integridad de Datos** | Atributos abiertos (texto libre). | **Catálogos maestros** gestionados por el Administrador (RF-74). |
| **Emisión en Ventas** | Confusión con comprobantes tributarios. | **Tickets digitales internos** desligados de SUNAT (RF-76). |
| **Enfoque Tecnológico** | No delimitado. | **Arquitectura cliente-servidor API-first** (Clean Architecture + CQRS) con Docker Compose (RF-72). |

---

## 🚀 Módulos del Sistema (v2.0)

El sistema se estructura en **5 módulos principales**:

1. **🔐 Autenticación y Seguridad:**
   - Control de acceso basado en roles (**Administrador** y **Vendedor**).
   - Gestión y reseteo de contraseñas exclusivo del Administrador (RF-73).
   - Auditoría de inicios de sesión y bloqueo por intentos fallidos.

2. **📦 Gestión de Inventario:**
   - Registro y modificación de prendas con imágenes, tallas, colores, categorías y marcas.
   - Administración de **catálogos maestros** controlados por el Administrador (RF-74).
   - Control de stock independiente por local y alertas automáticas de reposición.
   - Búsqueda en tiempo real y filtros dinámicos combinables (RF-75).

3. **💳 Registro y Gestión de Ventas:**
   - Punto de venta rápido compatible con múltiples medios de pago (efectivo, tarjetas, billeteras digitales).
   - Generación y almacenamiento automático de **ticket digital** de venta.
   - Historial completo y auditable de transacciones comerciales (RF-76).
   - Soporte para operación offline temporal y sincronización automática.

4. **📊 Reportes y Análisis:**
   - Reportes de ventas por período, producto, empleado y sucursal.
   - Identificación de productos más y menos vendidos.
   - Exportación de métricas en formatos PDF y Excel.

5. **🌐 Catálogo Digital (Web Pública):**
   - Portal web responsivo para clientes finales sin requerir registro.
   - Visualización de prendas en existencia con fotos y ficha técnica.
   - Filtros avanzados por categoría, talla y color (RF-77).
   - Consulta de disponibilidad en tiempo real por cada local físico y geolocalización de tiendas.

---

## 📋 Documentación del Proyecto

- 📊 [**Informe de Análisis y Mejoras (`INFORME_ANALISIS_Y_MEJORAS.md`)**](INFORME_ANALISIS_Y_MEJORAS.md) — Auditoría integral de coherencia, diagnóstico de trazabilidad y hoja de ruta de mejoras.
- 📄 [Necesidades del Negocio (`docs/necesidades_del_negocio.md`)](docs/necesidades_del_negocio.md) — 10 necesidades de negocio/usuario y árboles de derivación hacia RFs y RNFs (Fase 1).
- 📄 [Estándares de Arquitectura (`docs/estandares_arquitectura/`)](docs/estandares_arquitectura/estandares_arquitectura_desarrollo.md) — Lineamientos oficiales de Clean Architecture, CQRS, codificación y CI/CD.
- 📄 [Requisitos Funcionales (`docs/requisitos_funcionales.md`)](docs/requisitos_funcionales.md) — 77 requisitos detallados (Versión 2.0).
- 📄 [Requisitos No Funcionales (`docs/requisitos_no_funcionales.md`)](docs/requisitos_no_funcionales.md) — 14 requisitos de calidad y rendimiento (Versión 2.0).
- 📄 [Documentación Técnica de Base de Datos (`docs/documentacion_tecnica_bd.md`)](docs/documentacion_tecnica_bd.md) — Diccionario de datos y modelo transaccional MySQL.
- 📊 [Diagrama Entidad-Relación (`docs/diagrama_entidad_relacion.mmd`)](docs/diagrama_entidad_relacion.mmd) — Modelo ER en Mermaid con 15 entidades y relaciones.
- 🖼️ [Diagramas de Casos de Uso (`docs/diagramas_casos_de_uso/`)](docs/diagramas_casos_de_uso/) — Fuentes PlantUML y diagramas PNG organizados por módulo.
- 📝 [Especificaciones de Casos de Uso (`docs/diagramas_casos_de_uso/especificaciones_casos_de_uso.md`)](docs/diagramas_casos_de_uso/especificaciones_casos_de_uso.md) — 15 fichas de casos de uso con flujos, precondiciones, postcondiciones y trazabilidad (CU-01 a CU-15).
- 🔄 [Diagramas de Flujo de Datos DFD (`docs/diagramas_dfd/documentacion_dfd.md`)](docs/diagramas_dfd/documentacion_dfd.md) — DFD Nivel 0 (Contexto), Nivel 1 (Procesos) y Nivel 2 (Ventas) con código Mermaid y almacenes D1 a D5.
- ⚡ [Diagramas de Secuencia (`docs/diagramas_secuencia/`)](docs/diagramas_secuencia/) — 5 flujos transaccionales clave en PlantUML y PNG (Autenticación, Producto/Variantes, POS, Kardex y Reportes).
- 🧪 [Especificación de Casos de Prueba (`docs/casos_de_prueba.md`)](docs/casos_de_prueba.md) — 77 casos de prueba (CP-01 a CP-77) bajo estándar IEEE 829 para verificación funcional de criterios de aceptación.
- 🎯 [Matriz de Trazabilidad Integral (`docs/matriz_de_trazabilidad.md`)](docs/matriz_de_trazabilidad.md) — Matriz oficial de 7 columnas relacionando Necesidad, RF, RNF, Caso de Uso, DFD, Diseño y Prueba para el 100% de requisitos.
- 📖 [Historias de Usuario y Matriz de Tasks (`docs/historias_de_usuario/`)](docs/historias_de_usuario/) — 18 HUs en 7 Épicas (EP-01 a EP-07) con criterios Gherkin y 94 tareas técnicas desglosadas.
- 📋 [Product Backlog Priorizado (`docs/product_backlog/product_backlog.md`)](docs/product_backlog/product_backlog.md) — Backlog priorizado por valor y dependencias, filtros DoR y DoD.
- ⏱️ [Planificación Maestra de Sprints (`docs/sprints/planificacion_sprints.md`)](docs/sprints/planificacion_sprints.md) — Planificación de 4 Sprints (94 SP, horizonte de 28 días).
- 🏗️ [Análisis y Propuesta de EDT / WBS (`docs/analisis_edt/`)](docs/analisis_edt/) — Diagnóstico crítico de la EDT legacy y propuesta optimizada para la cuenta de control 1.3.3.
- 🤝 [Acuerdo de Trabajo del Equipo (`docs/acuerdos/acuerdo_trabajo_equipo.md`)](docs/acuerdos/acuerdo_trabajo_equipo.md) — Working Agreement oficial bajo RUP + Scrum y Matriz RACI.
- 📦 [Documentación Legada (`docs/legacy_v1.0/`)](docs/legacy_v1.0/) — Archivos y especificación histórica preliminar.

---

## 👥 Roles y Permisos

| Rol | Alcance y Responsabilidades |
|---|---|
| **Administrador** | Acceso total al sistema, configuración de catálogos maestros, gestión de usuarios, reseteo de credenciales, reportes gerenciales e inventario global. |
| **Vendedor** | Registro de ventas en caja, consulta de stock por tienda, emisión de tickets digitales y búsqueda de productos. |
| **Cliente** | Acceso de solo lectura al catálogo digital público para consultar prendas y disponibilidad por tienda. |

---

## 🛠️ Arquitectura y Tecnologías Oficiales

- **Patrón Arquitectónico:** Arquitectura cliente-servidor API-first con **Clean Architecture** (Dominio → Aplicación → Infraestructura → Presentación) y patrón **CQRS** (separación de Commands y Queries).
- **Frontend (Cliente Web):** React + TypeScript + Vite (interfaz responsive con soporte PWA).
- **Backend (API REST):** PHP 8.2+ con Laravel (endpoints RESTful independientes de la interfaz).
- **Base de Datos:** MySQL 8.0 (persistencia relacional centralizada con transacciones ACID).
- **Contenedores y Despliegue:** Docker y Docker Compose para desarrollo local y despliegue continuo en servidor.

---

## 📂 Estructura del Repositorio
 
```text
tienda-ropa/
├── .github/
│   └── workflows/
│       └── docs-validation.yml          # Flujo CI: Validación de markdown, links rotos y diagramas
├── database/
│   ├── schema.sql                       # Script DDL oficial para MySQL 8.0 (17 tablas normalizadas en 3FN)
│   └── seeds.sql                        # Datos semilla de catálogos cerrados, locales y usuarios
├── docs/
│   ├── acuerdos/                        # Working Agreement y gobernanza del equipo (Scrum + RUP)
│   ├── analisis_edt/                    # Diagnóstico crítico y propuesta optimizada de la WBS
│   ├── diagramas_casos_de_uso/
│   │   ├── codigo_puml/                 # Fuentes PlantUML (.puml)
│   │   ├── imagenes_png/                # Diagramas renderizados (.png)
│   │   └── especificaciones_casos_de_uso.md # Fichas textuales de CU (CU-01 a CU-15)
│   ├── diagramas_dfd/
│   │   ├── dfd_nivel_0_contexto.mmd     # DFD Nivel 0 (Contexto en Mermaid)
│   │   ├── dfd_nivel_1_general.mmd      # DFD Nivel 1 (Procesos principales 1.0 a 5.0)
│   │   ├── dfd_nivel_2_proceso_ventas.mmd # DFD Nivel 2 (Subprocesos 3.1 a 3.5)
│   │   └── documentacion_dfd.md         # Guía completa con diagramas y diccionario D1-D5
│   ├── diagramas_secuencia/
│   │   ├── codigo_puml/                 # Fuentes PlantUML (DS-01 a DS-08)
│   │   ├── imagenes_png/                # Diagramas renderizados (.png)
│   │   └── README.md                    # Catálogo técnico de los 8 diagramas de secuencia
│   ├── estandares_arquitectura/         # Guía técnica Clean Architecture + CQRS + OWASP
│   ├── historias_de_usuario/            # 18 HUs en 7 Épicas (EP-01 a EP-07) y matriz de tasks
│   ├── legacy_v1.0/                     # Archivo histórico y antecedentes del proyecto
│   ├── product_backlog/                 # Product Backlog priorizado (DoR y DoD)
│   ├── sprints/                         # Planificación de 4 Sprints (28 días calendario)
│   ├── casos_de_prueba.md               # 77 Casos de Prueba (CP-01 a CP-77) IEEE 829
│   ├── diagrama_entidad_relacion.mmd    # Modelo ER Mermaid (17 tablas: incluye auditoría e imágenes)
│   ├── documentacion_tecnica_bd.md      # Diccionario técnico MySQL 8.0 (17 tablas)
│   ├── matriz_de_trazabilidad.md        # Matriz integral de 7 columnas (N ➔ RF ➔ RNF ➔ CU ➔ DFD ➔ DS ➔ CP)
│   ├── necesidades_del_negocio.md       # Especificación formal de necesidades (N-01 a N-10)
│   ├── requisitos_funcionales.md        # 77 Requisitos Funcionales Oficiales v2.1
│   └── requisitos_no_funcionales.md     # 14 Criterios de calidad RNF-01 a RNF-14 v2.1
├── .gitignore                           # Exclusión de temporales y archivos del SO
├── .markdownlint-cli2.jsonc             # Reglas afinadas del linter de documentación
├── .markdownlint.json                   # Compatibilidad con extensiones de editor
├── .mlc-config.json                     # Reglas de validación para chequeo de links
├── docker-compose.yml                   # Orquestación de MySQL 8.0 y phpMyAdmin
├── INFORME_ANALISIS_Y_MEJORAS.md        # Auditoría de coherencia y plan de acción
└── README.md                            # Guía general del proyecto (v2.0)
```

---

## 🐳 Inicialización Rápida del Entorno (Base de Datos Local)

Para inicializar la base de datos MySQL 8.0 con su esquema completo de 17 tablas y datos semilla de catálogos maestros:

```bash
# Levantar contenedores en segundo plano:
docker compose up -d

# Acceder al administrador visual phpMyAdmin:
# URL: http://localhost:8080
# Servidor: mysql | Usuario: root | Clave: root_password_secure_2026
```
