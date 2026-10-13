# Archivo Histórico — Versión 1.0 (Proyecto Legado)

Este directorio conserva la documentación inicial (Versión 1.0) tomada como referencia previa al proceso de refundación y formalización de requisitos.

---

## 📌 Motivo de la Transición a la Versión 2.0

La **Versión 1.0** presentó un avance inicial del proyecto desarrollado con bases preliminares y limitaciones importantes:
- **Falta de granularidad técnica:** Los requisitos eran ambiguos y no definían claramente cómo debía operar el sistema a nivel de programación.
- **Vacíos funcionales críticos:** No se contemplaba la administración de catálogos maestros (colores, tallas, marcas, categorías), lo que provocaba inconsistencias por texto libre; faltaba la gestión de contraseñas por parte del administrador, filtros avanzados y especificación del soporte offline.
- **Confusión de plataformas:** Se planteaban requerimientos de aplicaciones móviles aisladas sin definir una arquitectura web responsiva multiplataforma base.
- **Falta de trazabilidad visual:** No existían diagramas de casos de uso formales bajo el estándar UML.

---

## ⚖️ Cuadro Comparativo: Versión 1.0 vs. Versión 2.0

| Criterio | Versión 1.0 (Legado) | Versión 2.0 (Actual) |
|---|---|---|
| **Enfoque del Proyecto** | Prototipo inicial con especificación empírica e informal. | Refundación formal con ingeniería de requisitos estructurada. |
| **Volumen de Requisitos Funcionales** | 72 requisitos con criterios breves y genéricos. | **77 requisitos** exhaustivos con criterios de aceptación técnicos y verificables. |
| **Catálogos Maestros (Colores, Tallas, Marcas)** | No especificado (riesgo de texto libre y reportes rotos). | **Estandarizado (RF-74)** con listas desplegables administradas exclusivamente por el Administrador. |
| **Gestión de Usuarios** | Roles básicos sin control centralizado de contraseñas. | **Control total del Administrador (RF-73)** para listar y resetear credenciales de empleados. |
| **Ventas y Emisión** | Términos confusos ("comprobantes" con riesgo de asunción de SUNAT). | **Tickets digitales internos (RF-76)** desligados de SUNAT, con almacenamiento y envío digital. |
| **Diagramas UML** | Inexistentes. | **Suite completa de Casos de Uso en PlantUML** (código fuente `.puml` e imágenes renderizadas `.png`). |
| **Estrategia Multiplataforma** | Planteaba aplicaciones móviles nativas desarticuladas. | **Aplicación Web Responsiva (RF-72)** centralizada y desacoplada mediante API REST. |

---

## 📂 Archivos en esta Carpeta

- `requisitos_funcionales_v1.0.md`: Especificación funcional original antes de la refundación.
- `requisitos_no_funcionales_v1.0.md`: Criterios no funcionales originales.
