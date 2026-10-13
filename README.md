# Sistema de Gestión — Tienda de Ropa para Varón

Sistema integral de gestión de ventas, control de inventario y catálogo digital diseñado para una tienda de ropa masculina con dos locales físicos.

---

## 📌 Descripción del Proyecto

El sistema centraliza y optimiza los procesos operativos del negocio, permitiendo:
- Control preciso de existencias sincronizado entre los dos locales comerciales.
- Registro ágil de ventas en punto de venta (POS) y emisión de comprobantes.
- Catálogo web público para que los clientes consulten prendas, tallas, colores y disponibilidad en cada tienda.
- Consulta e historial completo de transacciones realizadas.
- Generación de reportes financieros y de inventario para la toma de decisiones.

El proyecto está diseñado como una **aplicación web moderna y responsiva**, garantizando acceso inmediato desde computadoras de escritorio, tablets y teléfonos celulares sin necesidad de instalaciones complejas, con arquitectura desacoplada para admitir futuras versiones en escritorio o aplicación móvil.

---

## 🚀 Módulos del Sistema

El sistema se estructura en **5 módulos principales**:

1. **🔐 Autenticación y Seguridad:**
   - Control de acceso basado en roles (**Administrador** y **Empleado**).
   - Gestión y reseteo de contraseñas por parte del Administrador.
   - Auditoría de inicios de sesión y cierre automático por inactividad.

2. **📦 Gestión de Inventario:**
   - Registro y modificación de prendas con imágenes, tallas, colores, categorías y marcas.
   - Administración de **catálogos maestros** (listas predefinidas sin texto libre).
   - Control de stock independiente por local y alertas automáticas de reposición.
   - Búsqueda avanzada y filtros dinámicos en tiempo real.

3. **💳 Registro y Gestión de Ventas:**
   - Punto de venta rápido compatible con múltiples medios de pago (efectivo, tarjetas, billeteras digitales).
   - Historial completo y auditable de transacciones comerciales.
   - Soporte para operación offline temporal y sincronización automática.

4. **📊 Reportes y Análisis:**
   - Reportes de ventas por período, producto, empleado y sucursal.
   - Identificación de productos más y menos vendidos.
   - Exportación de métricas en formatos PDF y Excel.

5. **🌐 Catálogo Digital (Web Pública):**
   - Portal web responsivo para clientes finales sin requerir registro.
   - Visualización de prendas en existencia con fotos y ficha técnica.
   - Filtros avanzados por categoría, talla y color.
   - Consulta de disponibilidad en tiempo real por cada local físico y geolocalización de tiendas.

---

## 📋 Documentación de Requisitos

La especificación completa del sistema se encuentra documentada en:

- 📄 [Requisitos Funcionales (`docs/requisitos_funcionales.md`)](docs/requisitos_funcionales.md) — 77 requisitos detallados con descripción, actores, prioridad y criterios de aceptación.
- 📄 [Requisitos No Funcionales (`docs/requisitos_no_funcionales.md`)](docs/requisitos_no_funcionales.md) — 14 requisitos de seguridad, usabilidad, rendimiento y mantenibilidad.

---

## 👥 Roles y Permisos

| Rol | Alcance y Responsabilidades |
|---|---|
| **Administrador** | Acceso total al sistema, configuración de catálogos maestros, gestión de usuarios, reseteo de credenciales, reportes gerenciales e inventario global. |
| **Empleado (Vendedor)** | Registro de ventas, consulta de stock por tienda, emisión de comprobantes y búsqueda de productos. |
| **Cliente** | Acceso de solo lectura al catálogo digital público para consultar prendas y disponibilidad por tienda. |

---

## 🛠️ Arquitectura y Tecnologías Propuestas

- **Frontend:** Aplicación Web Responsiva (HTML5 / CSS3 / JavaScript moderno o framework SPA/PWA).
- **Backend / API:** Servicios RESTful desacoplados para la lógica de negocio y persistencia.
- **Base de Datos:** Motor relacional con integridad transaccional (MySQL) para garantizar la consistencia en ventas e inventario.
- **Sincronización:** Soporte de almacenamiento local (IndexedDB) con sincronización hacia la base de datos central.

---

## 📂 Estructura del Repositorio

```text
tienda-ropa/
├── docs/
│   ├── requisitos_funcionales.md      # Especificación funcional detallada (RF-01 a RF-77)
│   └── requisitos_no_funcionales.md   # Criterios de calidad, seguridad y rendimiento
└── README.md                          # Información general y guía del proyecto
```

---

