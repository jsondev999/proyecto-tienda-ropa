# Matriz de Trazabilidad Integral de Requisitos

**Proyecto:** Sistema de Gestión — Tienda de Ropa para Varón  
**Versión:** 2.0  
**Fecha:** 13/10/2026  
**Cobertura:** 100% de Requisitos Funcionales (RF-01 a RF-77)  

---

## 📌 1. Marco Metodológico y Propósito de la Matriz

> *"La matriz es uno de los elementos más importantes porque permite responder: **¿De dónde salió este requerimiento y dónde está implementado/modelado?**"*

La matriz garantiza la consistencia bidireccional del sistema:
* **Hacia adelante (Forward Traceability):** Cada Necesidad del Negocio se descompone en requerimientos, casos de uso, flujos DFD, diseños técnicos y pruebas.
* **Hacia atrás (Backward Traceability):** Cada caso de uso, tabla o prueba tiene su justificación en una necesidad legítima del negocio, erradicando requerimientos huérfanos o funciones innecesarias.

### 1.1 Estructura de las 7 Columnas Oficiales

| Columna | Definición | Artefacto de Referencia |
|---|---|---|
| **Necesidad** | Necesidad del Negocio / Usuario que da origen al requerimiento. | [`docs/necesidades_del_negocio.md`](necesidades_del_negocio.md) (N-01 a N-10) |
| **RF** | Requisito Funcional verificable que describe qué debe hacer el software. | [`docs/requisitos_funcionales.md`](requisitos_funcionales.md) (RF-01 a RF-77) |
| **RNF** | Requisito No Funcional que establece los atributos de calidad, rendimiento y seguridad. | [`docs/requisitos_no_funcionales.md`](requisitos_no_funcionales.md) (RNF-01 a RNF-14) |
| **Caso de Uso** | Caso de uso que operacionaliza la interacción del actor con el sistema. | [`docs/diagramas_casos_de_uso/`](diagramas_casos_de_uso/especificaciones_casos_de_uso.md) (CU-01 a CU-15) |
| **DFD** | Proceso o subproceso del diagrama de flujo donde circulan los datos. | [`docs/diagramas_dfd/`](diagramas_dfd/documentacion_dfd.md) (P1.0 a P5.0) |
| **Diseño** | Diagrama de secuencia técnico (DS) y/o tabla relacional de la base de datos. | [`docs/diagramas_secuencia/`](diagramas_secuencia/) y [`docs/documentacion_tecnica_bd.md`](documentacion_tecnica_bd.md) |
| **Prueba** | Caso de prueba diseñado para validar los criterios de aceptación. | [`docs/casos_de_prueba.md`](casos_de_prueba.md) (CP-01 a CP-77) |

---

## 🔐 2. Módulo 1: Autenticación y Seguridad

| Necesidad | RF | RNF | Caso de Uso | DFD | Diseño (DS / BD) | Prueba |
|:---:|---|:---:|:---:|:---:|---|:---:|
| **N-01** | **RF-01:** Solicitar nombre de usuario | RNF-05 | CU-01 | P 1.0 | DS-01 / Tabla `usuarios` | CP-01 |
| **N-01** | **RF-02:** Solicitar contraseña | RNF-03, RNF-05 | CU-01 | P 1.0 | DS-01 / UI-Login | CP-02 |
| **N-01** | **RF-03:** Autenticar usuario | RNF-02, RNF-03 | CU-01 | P 1.0 | DS-01 / Tabla `usuarios` | CP-03 |
| **N-01** | **RF-04:** Validar credenciales | RNF-03 | CU-01 | P 1.0 | DS-01 / Endpoint `/api/auth/login` | CP-04 |
| **N-01** | **RF-05:** Denegar acceso erróneo | RNF-07 | CU-01 | P 1.0 | DS-01 / Middleware Auth | CP-05 |
| **N-01** | **RF-06:** Bloquear cuenta por intentos | RNF-02, RNF-04 | CU-01 | P 1.0 | DS-01 / Tabla `intentos_login` | CP-06 |
| **N-01** | **RF-07:** Asignar roles (Admin/Vendedor) | RNF-02 | CU-02 | P 1.0 | DS-01 / Tabla `roles` | CP-07 |
| **N-01** | **RF-08:** Restringir funciones según rol | RNF-02, RNF-03 | CU-02 | P 1.0 | DS-01 / RBAC Gateways | CP-08 |
| **N-01** | **RF-09:** Cerrar sesión de usuario | RNF-02 | CU-03 | P 1.0 | DS-01 / Endpoint `/api/auth/logout` | CP-09 |
| **N-02** | **RF-10:** Crear nuevo usuario | RNF-02, RNF-04 | CU-02 | P 1.0 | DS-01 / Tabla `usuarios` | CP-10 |
| **N-02** | **RF-11:** Listar usuarios registrados | RNF-02 | CU-02 | P 1.0 | Tabla `usuarios` / `locales` | CP-11 |
| **N-02** | **RF-12:** Modificar datos de usuario | RNF-04 | CU-02 | P 1.0 | Tabla `usuarios` | CP-12 |
| **N-02** | **RF-13:** Desactivar cuenta de usuario | RNF-02, RNF-04 | CU-02 | P 1.0 | Tabla `usuarios` (`activo=0`) | CP-13 |
| **N-02** | **RF-14:** Desbloquear cuenta de usuario | RNF-02 | CU-02 | P 1.0 | Tabla `intentos_login` | CP-14 |
| **N-02** | **RF-73:** Resetear contraseña por Admin | RNF-02, RNF-03 | CU-02 | P 1.0 | DS-01 / Bcrypt Service | CP-73 |

---

## 📦 3. Módulo 2: Gestión de Inventario

| Necesidad | RF | RNF | Caso de Uso | DFD | Diseño (DS / BD) | Prueba |
|:---:|---|:---:|:---:|:---:|---|:---:|
| **N-04** | **RF-15:** Registrar prenda | RNF-04, RNF-11 | CU-05 | P 2.0 | DS-02 / Tabla `productos` | CP-15 |
| **N-04** | **RF-16:** Modificar prenda | RNF-04 | CU-05 | P 2.0 | DS-02 / Tabla `productos` | CP-16 |
| **N-04** | **RF-17:** Eliminar prenda | RNF-04 | CU-05 | P 2.0 | Tabla `productos` (Soft Delete) | CP-17 |
| **N-04** | **RF-18:** Consultar prenda por SKU/nombre | RNF-08 | CU-04 | P 2.0 | DS-02 / Índice SKU | CP-18 |
| **N-04** | **RF-19:** Registrar stock inicial por local | RNF-11 | CU-05 | P 2.0 | DS-02 / Tabla `inventario` | CP-19 |
| **N-04** | **RF-20:** Actualizar stock por ingreso/ajuste | RNF-04, RNF-11 | CU-06 | P 2.0 | DS-04 / Tabla `ajustes_inventario` | CP-20 |
| **N-04** | **RF-21:** Descontar stock tras venta | RNF-08, RNF-11 | CU-08 | P 3.4 | DS-03 / Tabla `inventario` | CP-21 |
| **N-04** | **RF-22:** Consultar stock disponible por local | RNF-08, RNF-11 | CU-04 | P 2.0 | Tabla `inventario` / `locales` | CP-22 |
| **N-04** | **RF-23:** Emitir alertas de bajo stock | RNF-05 | CU-06 | P 2.0 | UI-Inventario (Etiqueta Alerta) | CP-23 |
| **N-04** | **RF-24:** Configurar umbral de stock mínimo | RNF-11 | CU-06 | P 2.0 | Tabla `inventario` (`stock_minimo`) | CP-24 |
| **N-04** | **RF-25:** Notificar stock crítico al Admin | RNF-07 | CU-06 | P 2.0 | Dashboard Alertas Admin | CP-25 |
| **N-03** | **RF-26:** Registrar categoría | RNF-14 | CU-07 | P 2.0 | Tabla `categorias` | CP-26 |
| **N-03** | **RF-27:** Modificar categoría | RNF-14 | CU-07 | P 2.0 | Tabla `categorias` | CP-27 |
| **N-03** | **RF-28:** Eliminar categoría | RNF-04 | CU-07 | P 2.0 | Tabla `categorias` (FK Check) | CP-28 |
| **N-03** | **RF-29:** Registrar talla | RNF-14 | CU-07 | P 2.0 | Tabla `tallas` | CP-29 |
| **N-03** | **RF-30:** Modificar talla | RNF-14 | CU-07 | P 2.0 | Tabla `tallas` | CP-30 |
| **N-03** | **RF-31:** Registrar color | RNF-14 | CU-07 | P 2.0 | Tabla `colores` (código HEX) | CP-31 |
| **N-03** | **RF-32:** Modificar color | RNF-14 | CU-07 | P 2.0 | Tabla `colores` | CP-32 |
| **N-03** | **RF-33:** Registrar marca | RNF-14 | CU-07 | P 2.0 | Tabla `marcas` | CP-33 |
| **N-03** | **RF-34:** Modificar marca | RNF-14 | CU-07 | P 2.0 | Tabla `marcas` | CP-34 |
| **N-05** | **RF-35:** Búsqueda en tiempo real | RNF-08 | CU-04 | P 2.0 | Full-Text Search / Query | CP-35 |
| **N-05** | **RF-36:** Filtrar por categoría | RNF-05 | CU-04 | P 2.0 | Query Filtro `categoria_id` | CP-36 |
| **N-05** | **RF-37:** Filtrar por talla | RNF-05 | CU-04 | P 2.0 | Query Filtro `talla_id` | CP-37 |
| **N-05** | **RF-38:** Filtrar por marca | RNF-05 | CU-04 | P 2.0 | Query Filtro `marca_id` | CP-38 |
| **N-05** | **RF-39:** Filtrar por rango de precio | RNF-08 | CU-04 | P 2.0 | Query `precio BETWEEN min AND max` | CP-39 |
| **N-03** | **RF-74:** Catálogos maestros cerrados | RNF-04, RNF-14 | CU-07 | P 2.0 | DS-02 / D2 Catálogos | CP-74 |
| **N-05** | **RF-75:** Filtros dinámicos combinables | RNF-08 | CU-04 | P 2.0 | Query Builder Multicriterio | CP-75 |
| **N-04** | **RF-77:** Alertas reposición por local | RNF-11 | CU-06 | P 2.0 | Servicio Alertas Multilocal | CP-77 |

---

## 💳 4. Módulo 3: Registro de Ventas

| Necesidad | RF | RNF | Caso de Uso | DFD | Diseño (DS / BD) | Prueba |
|:---:|---|:---:|:---:|:---:|---|:---:|
| **N-06** | **RF-40:** Iniciar nueva venta | RNF-05 | CU-08 | P 3.0 | DS-03 / UI-POS | CP-40 |
| **N-06** | **RF-41:** Agregar prendas a la venta | RNF-08 | CU-08 | P 3.1 | DS-03 / Carrito en Memoria | CP-41 |
| **N-06** | **RF-42:** Modificar cantidad de prendas | RNF-08 | CU-08 | P 3.2 | DS-03 / Validador Stock | CP-42 |
| **N-06** | **RF-43:** Eliminar prenda de la venta | RNF-05 | CU-08 | P 3.2 | DS-03 / Controlador POS | CP-43 |
| **N-06** | **RF-44:** Calcular total y descuentos | RNF-08 | CU-08 | P 3.2 | DS-03 / Calculadora Montos | CP-44 |
| **N-06** | **RF-45:** Seleccionar medio de pago | RNF-05 | CU-08 | P 3.3 | DS-03 / Tabla `metodos_pago` | CP-45 |
| **N-06** | **RF-46:** Registrar cobro y cambio | RNF-08 | CU-08 | P 3.3 | DS-03 / Tabla `pagos_venta` | CP-46 |
| **N-06** | **RF-47:** Confirmar y registrar venta | RNF-08, RNF-10 | CU-08 | P 3.3 | DS-03 / Transacción SQL ACID | CP-47 |
| **N-07** | **RF-48:** Generar ticket digital | RNF-01, RNF-10 | CU-09 | P 3.5 | DS-03 / Tabla `ventas` / D4 | CP-48 |
| **N-07** | **RF-49:** Imprimir ticket térmico/PDF | RNF-05 | CU-09 | P 3.5 | Plantilla Ticket ESC/POS / PDF | CP-49 |
| **N-07** | **RF-50:** Enviar ticket por WhatsApp | RNF-14 | CU-09 | P 3.5 | API Gateway WhatsApp | CP-50 |
| **N-07** | **RF-51:** Consultar historial de ventas | RNF-04, RNF-08 | CU-11 | P 3.0 | Tabla `ventas` (`fecha, local`) | CP-51 |
| **N-07** | **RF-52:** Consultar detalle de venta | RNF-08 | CU-11 | P 3.0 | Tabla `detalle_ventas` | CP-52 |
| **N-07** | **RF-53:** Anular venta (exclusivo Admin) | RNF-02, RNF-04 | CU-12 | P 3.0 | Transacción Anulación / D5 | CP-53 |
| **N-08** | **RF-54:** Operar en modo offline | RNF-09, RNF-14 | CU-10 | P 3.0 | Service Worker / IndexedDB | CP-54 |
| **N-08** | **RF-55:** Sincronizar ventas offline | RNF-09, RNF-10 | CU-10 | P 3.0 | Sync Worker / Endpoint Lote | CP-55 |
| **N-07** | **RF-76:** Tickets internos sin SUNAT | RNF-10 | CU-09 | P 3.5 | DS-03 / Formato Comprobante | CP-76 |

---

## 📊 5. Módulo 4: Reportes y Análisis

| Necesidad | RF | RNF | Caso de Uso | DFD | Diseño (DS / BD) | Prueba |
|:---:|---|:---:|:---:|:---:|---|:---:|
| **N-09** | **RF-56:** Reporte ventas por fechas | RNF-08 | CU-13 | P 4.0 | DS-05 / Query Histórico | CP-56 |
| **N-09** | **RF-57:** Reporte ventas por local | RNF-08, RNF-11 | CU-13 | P 4.0 | DS-05 / Query `GROUP BY local_id` | CP-57 |
| **N-09** | **RF-58:** Reporte ventas por empleado | RNF-04 | CU-13 | P 4.0 | DS-05 / Query `usuario_id` | CP-58 |
| **N-09** | **RF-59:** Identificar prendas más vendidas | RNF-08 | CU-14 | P 4.0 | Query `ORDER BY sum(cantidad) DESC` | CP-59 |
| **N-09** | **RF-60:** Identificar prendas baja rotación | RNF-08 | CU-14 | P 4.0 | Query Substracción de Stock | CP-60 |
| **N-09** | **RF-61:** Reporte de ingresos totales | RNF-08 | CU-13 | P 4.0 | DS-05 / `sum(total)` | CP-61 |
| **N-09** | **RF-62:** Filtrar por categoría y marca | RNF-08 | CU-13 | P 4.0 | DS-05 / Multijoin SQL | CP-62 |
| **N-09** | **RF-63:** Exportar reportes a PDF | RNF-05 | CU-14 | P 4.0 | Servicio DomPDF / Laravel | CP-63 |
| **N-09** | **RF-64:** Exportar reportes a Excel | RNF-05 | CU-14 | P 4.0 | Servicio PhpSpreadsheet | CP-64 |
| **N-09** | **RF-65:** Panel gráfico de control | RNF-05, RNF-08 | CU-13 | P 4.0 | Chart.js / Recharts UI | CP-65 |
| **N-09** | **RF-66:** Comparativo entre locales | RNF-11 | CU-13 | P 4.0 | Dashboard Comparativo L1 vs L2 | CP-66 |

---

## 🌐 6. Módulo 5: Catálogo Digital Web (Público)

| Necesidad | RF | RNF | Caso de Uso | DFD | Diseño (DS / BD) | Prueba |
|:---:|---|:---:|:---:|:---:|---|:---:|
| **N-10** | **RF-67:** Catálogo público sin login | RNF-05 | CU-15 | P 5.0 | Vista React Pública | CP-67 |
| **N-10** | **RF-68:** Filtrar por categoría, talla y color | RNF-05, RNF-08 | CU-15 | P 5.0 | Query Endpoint `/api/catalogo` | CP-68 |
| **N-10** | **RF-69:** Ficha de prenda con fotos HD | RNF-08 | CU-15 | P 5.0 | Modal Detalle / Cloud Storage | CP-69 |
| **N-10** | **RF-70:** Disponibilidad física por tienda | RNF-11 | CU-15 | P 5.0 | Consulta Stock `inventario` | CP-70 |
| **N-10** | **RF-71:** Compartir ficha de prenda | RNF-14 | CU-15 | P 5.0 | MetaTags OpenGraph / Social Share | CP-71 |
| **N-10** | **RF-72:** Aplicación web responsiva | RNF-06, RNF-13 | CU-15 | P 5.0 | Tailwind CSS Mobile-First | CP-72 |

---

## 📊 7. Estadísticas de Cobertura y Trazabilidad

| Métrica de Trazabilidad | Valor Alcanzado | Estado de Calidad |
|---|:---:|:---:|
| **Total de Necesidades de Negocio** | 10 Necesidades (N-01 a N-10) | 100% Trazadas |
| **Total de Requisitos Funcionales** | 77 Requisitos (RF-01 a RF-77) | 100% Trazados |
| **Requisitos No Funcionales Vinculados** | 14 Requisitos (RNF-01 a RNF-14) | 100% Asociados |
| **Casos de Uso Vinculados** | 15 Casos de Uso (CU-01 a CU-15) | 100% Cobertura |
| **Procesos DFD Asociados** | 5 Procesos N1 (P1.0 a P5.0) + Subprocesos | 100% Mapeados |
| **Casos de Prueba Diseñados** | 77 Casos de Prueba (CP-01 a CP-77) | 100% Correspondencia |
| **Requisitos Huérfanos detectados** | 0 Requisitos | ✅ Ninguno (Integridad Total) |
