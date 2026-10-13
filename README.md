# Sistema de Gestión — Tienda de Ropa para Varón (Versión 2.0)

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

- 📄 [Necesidades del Negocio (`docs/necesidades_del_negocio.md`)](docs/necesidades_del_negocio.md) — 10 necesidades de negocio/usuario y árboles de derivación hacia RFs y RNFs (Fase 1).
- 📄 [Estándares de Arquitectura (`docs/estandares_arquitectura/`)](docs/estandares_arquitectura/estandares_arquitectura_desarrollo.md) — Lineamientos oficiales de Clean Architecture, CQRS, codificación y CI/CD.
- 📄 [Requisitos Funcionales (`docs/requisitos_funcionales.md`)](docs/requisitos_funcionales.md) — 77 requisitos detallados (Versión 2.0).
- 📄 [Requisitos No Funcionales (`docs/requisitos_no_funcionales.md`)](docs/requisitos_no_funcionales.md) — 14 requisitos de calidad y rendimiento (Versión 2.0).
- 📄 [Documentación Técnica de Base de Datos (`docs/documentacion_tecnica_bd.md`)](docs/documentacion_tecnica_bd.md) — Diccionario de datos y modelo transaccional MySQL.
- 🖼️ [Diagramas de Casos de Uso (`docs/diagramas_casos_de_uso/`)](docs/diagramas_casos_de_uso/) — Fuentes PlantUML y diagramas PNG organizados por módulo.
- 📦 [Documentación Legada (`docs/legacy_v1.0/`)](docs/legacy_v1.0/) — Especificación original de la versión 1.0.

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
├── docs/
│   ├── diagramas_casos_de_uso/
│   │   ├── codigo_puml/              # Código fuente PlantUML (.puml)
│   │   └── imagenes_png/             # Diagramas renderizados (.png)
│   ├── legacy_v1.0/                  # Archivo histórico del proyecto anterior
│   │   ├── README.md                 # Análisis comparativo v1.0 vs v2.0
│   │   ├── requisitos_funcionales_v1.0.md
│   │   └── requisitos_no_funcionales_v1.0.md
│   ├── necesidades_del_negocio.md     # Especificación formal de necesidades (N-01 a N-10)
│   ├── requisitos_funcionales.md      # Especificación funcional v2.0 (RF-01 a RF-77)
│   └── requisitos_no_funcionales.md   # Criterios de calidad v2.0
└── README.md                          # Guía general del proyecto (v2.0)
```
