# Matriz de Tareas Técnicas y Sprint Backlog — SYSELL Web (v2.0)

**Proyecto:** SYSELL — Sistema de Gestión Comercial para Tienda de Ropa para Varón  
**Equipo de Desarrollo:** Pollitos Design — ESIS UNJBG (2026)  
**Marco de Trabajo:** Scrum / Clean Architecture + CQRS / API-first  
**Roles del Equipo:**
- **Johan Mamani:** Líder / Jefe de Proyecto & Product Owner
- **Luis Condori:** Diseñador UI/UX & Analista Funcional
- **Aron Cachicatari:** Desarrollador Full-Stack & Líder Técnico
- **Giorgini Disalvatore:** Analista de Calidad (QA) & Scrum Master

---

## 📌 Resumen General de Planificación por Sprints

| Sprint | Enfoque Estratégico | Historias Cubiertas | Story Points | Total Tasks | Carga Horaria Estimada |
|:---:|---|:---:|:---:|:---:|:---:|
| **Sprint 1** | Cimientos, Autenticación (RBAC) y Catálogos Maestros | HU-01, HU-02, HU-03, HU-04 | 21 SP | 24 Tasks | ~86 horas |
| **Sprint 2** | Control de Stock Multi-Local, Ajustes de Inventario y Caja | HU-06, HU-07, HU-08, HU-13, HU-14 | 29 SP | 26 Tasks | ~94 horas |
| **Sprint 3** | Punto de Venta (POS), Liquidación Multitendencia y Tickets | HU-05, HU-09, HU-10, HU-11, HU-12, HU-15, HU-16 | 30 SP | 28 Tasks | ~102 horas |
| **Sprint 4** | Reportería Gerencial, Auditoría y Despliegue con Docker | HU-17, HU-18 | 14 SP | 16 Tasks | ~58 horas |
| **TOTAL** | **Ciclo Completo de Desarrollo** | **18 Historias** | **94 SP** | **94 Tasks** | **~340 horas** |

---

## 🚀 SPRINT 1: Arquitectura Base, Seguridad (RBAC) y Catálogo Maestro
> **Meta del Sprint:** Establecer el entorno de desarrollo con Docker, la persistencia en MySQL, la autenticación por tokens JWT/Sanctum y la administración de catálogos maestros de prendas (categorías, marcas, tallas y colores).

### HU-01: Autenticación Segura y Gestión de Sesión (5 SP)
| Código Task | Descripción de la Tarea Técnica | Capa / Disciplina | Responsable | Est. (Horas) | Definición de Terminado (DoD) |
|---|---|---|---|:---:|---|
| `TSK-01.1` | Configurar entorno Docker Compose (PHP 8.2, MySQL 8, Node.js) y repositorio base. | DevOps / Infraestructura | Aron C. | 4h | Contenedores corriendo y comunicados con volumen persistente en local. |
| `TSK-01.2` | Crear migración y seeder de la tabla `usuarios` en MySQL con campos de hash, rol y bloqueo. | Base de Datos | Aron C. | 2h | Migración versionada ejecutada exitosamente con índices de unicidad. |
| `TSK-01.3` | Implementar entidad de dominio `Usuario` y Value Object `EmailAddress` / `PasswordHash`. | Backend — Dominio | Aron C. | 3h | Reglas puras de validación de correo y contraseña implementadas sin dependencias externas. |
| `TSK-01.4` | Implementar `LoginCommand`, `LoginCommandHandler` y `AuthResponseDto` en la capa de aplicación. | Backend — Aplicación | Aron C. | 4h | Lógica de validación contra repositorio desacoplado devolviendo DTO seguro. |
| `TSK-01.5` | Implementar emisión y validación de tokens JWT mediante Laravel Sanctum con expiración. | Backend — Infraestructura | Aron C. | 3h | Middleware de autenticación funcional que rechaza peticiones no autorizadas (HTTP 401). |
| `TSK-01.6` | Crear endpoint `POST /api/auth/login` y `POST /api/auth/logout` con FormRequest de validación. | Backend — Presentación | Aron C. | 2h | Endpoints documentados que responden 200 con token o 401 genérico ante fallos. |
| `TSK-01.7` | Diseñar wireframe y prototipo de alta fidelidad para pantalla de Login responsive en Figma. | UI / UX | Luis C. | 4h | Prototipo aprobado que contempla estados de carga, error y adaptabilidad móvil. |
| `TSK-01.8` | Construir componentes React de Login con Tailwind CSS y validaciones en tiempo real. | Frontend — UI | Luis C. | 4h | Formulario responsive con accesibilidad y prevención de doble submit. |
| `TSK-01.9` | Integrar cliente HTTP (Axios) con interceptor de token y redirección según rol de usuario. | Frontend — Integración | Aron C. | 3h | Flujo completo login -> almacenamiento seguro -> dashboard operativo. |
| `TSK-01.10`| Crear casos de prueba unitarios en PHPUnit para `LoginHandler` y pruebas funcionales de login. | QA & Pruebas | Giorgini D. | 3h | Pruebas pasando al 100% cubriendo escenarios de credenciales válidas y erróneas. |

### HU-02: Control de Acceso Basado en Roles y Permisos (RBAC) (5 SP)
| Código Task | Descripción de la Tarea Técnica | Capa / Disciplina | Responsable | Est. (Horas) | Definición de Terminado (DoD) |
|---|---|---|---|:---:|---|
| `TSK-02.1` | Crear middleware de autorización por rol (`RoleMiddleware`) para proteger rutas de la API. | Backend — Presentación | Aron C. | 3h | Bloqueo automático con HTTP 403 Forbidden para usuarios sin privilegios. |
| `TSK-02.2` | Implementar `ObtenerUsuariosQuery` y `RestablecerPasswordCommand` (exclusivo para Administrador). | Backend — Aplicación | Aron C. | 4h | Solo el Admin puede resetear claves de empleados sin conocer la clave anterior. |
| `TSK-02.3` | Diseñar interfaz de gestión y listado de usuarios del sistema en React. | Frontend — UI | Luis C. | 4h | Tabla responsive con estados de usuario (activo, inactivo, bloqueado). |
| `TSK-02.4` | Pruebas de seguridad para evaluar intentos de escalamiento de privilegios y bypass de rutas. | QA & Seguridad | Giorgini D. | 3h | Reporte de pruebas confirmando que un Vendedor no accede a endpoints de Admin. |

### HU-03: Gestión de Marcas y Categorías Maestras (3 SP)
| Código Task | Descripción de la Tarea Técnica | Capa / Disciplina | Responsable | Est. (Horas) | Definición de Terminado (DoD) |
|---|---|---|---|:---:|---|
| `TSK-03.1` | Crear migraciones para tablas maestras `categorias`, `marcas`, `tallas` y `colores` en MySQL. | Base de Datos | Aron C. | 3h | Tablas con restricciones de unicidad e integridad referencial aplicadas. |
| `TSK-03.2` | Crear Commands y Handlers para creación y activación/desactivación lógica de catálogos. | Backend — Aplicación | Aron C. | 4h | Prohibición de borrado físico si el elemento tiene prendas vinculadas en inventario. |
| `TSK-03.3` | Diseñar y maquetar módulo de administración de catálogos maestros en React. | Frontend — UI | Luis C. | 4h | Formularios modales ágiles para agregar y editar marcas, categorías y colores con picker HEX. |
| `TSK-03.4` | Pruebas de integración API para creación y desactivación lógica de catálogos maestros. | QA & Pruebas | Giorgini D. | 2h | Validación de endpoints con códigos de respuesta HTTP 200, 201 y 422. |

### HU-04: Catálogo de Productos y Variantes Físicas (Talla/Color/SKU) (8 SP)
| Código Task | Descripción de la Tarea Técnica | Capa / Disciplina | Responsable | Est. (Horas) | Definición de Terminado (DoD) |
|---|---|---|---|:---:|---|
| `TSK-04.1` | Crear migraciones para `productos` y `variantes_producto` con restricción UNIQUE compuesta. | Base de Datos | Aron C. | 3h | Estructura 3FN que impide registrar dos veces la misma variante de producto. |
| `TSK-04.2` | Implementar `CrearProductoConVariantesCommand` y generación automática de SKU/código de barras. | Backend — Aplicación | Aron C. | 5h | Creación atómica en BD del producto y su matriz de tallas y colores en una sola transacción. |
| `TSK-04.3` | Implementar `ListarProductosQuery` con filtros combinados (categoría, marca, talla, color). | Backend — Aplicación | Aron C. | 4h | Endpoint paginado con tiempos de respuesta menores a 200ms. |
| `TSK-04.4` | Diseñar interfaz de matriz de variantes y carga de imágenes en React. | Frontend — UI | Luis C. | 6h | Componente interactivo que genera dinámicamente las combinaciones de tallas y colores. |
| `TSK-04.5` | Integrar selector de catálogos maestros desplegables (bloqueando texto libre). | Frontend — Integración | Aron C. | 3h | Selects que consumen la API de catálogos garantizando datos limpios. |
| `TSK-04.6` | Pruebas funcionales de registro de productos con múltiples variantes físicas y fotos. | QA & Pruebas | Giorgini D. | 3h | Validación de carga de imágenes y consistencia de SKUs generados. |

---

## 📦 SPRINT 2: Control de Stock Multi-Local, Kardex y Control de Caja
> **Meta del Sprint:** Administrar el stock físico individualizado por cada uno de los dos locales, registrar movimientos de entrada/salida y habilitar el control de apertura y cierre de turnos de caja.

### HU-06: Control de Stock por Almacén y Alertas de Quiebre (5 SP)
| Código Task | Descripción de la Tarea Técnica | Capa / Disciplina | Responsable | Est. (Horas) | Definición de Terminado (DoD) |
|---|---|---|---|:---:|---|
| `TSK-06.1` | Crear migración de la tabla `inventario` con restricción `UNIQUE (local_id, variante_id)`. | Base de Datos | Aron C. | 2h | Existencias separadas de forma estricta entre Local 1 y Local 2. |
| `TSK-06.2` | Implementar `ConsultarStockPorLocalQuery` y lógica de cálculo de alertas de stock mínimo. | Backend — Aplicación | Aron C. | 4h | Identificación inmediata de productos con existencias <= umbral configurado. |
| `TSK-06.3` | Diseñar vista de inventario con indicadores visuales de semáforo (Verde, Amarillo, Rojo). | Frontend — UI | Luis C. | 4h | Tabla de existencias clara con filtro rápido por local comercial. |
| `TSK-06.4` | Pruebas de verificación de consistencia de stock independiente entre sucursales. | QA & Pruebas | Giorgini D. | 3h | Validación de que alterar stock en un local no modifique las existencias del otro. |

### HU-07: Movimientos de Kardex y Ajustes de Inventario Físico (8 SP)
| Código Task | Descripción de la Tarea Técnica | Capa / Disciplina | Responsable | Est. (Horas) | Definición de Terminado (DoD) |
|---|---|---|---|:---:|---|
| `TSK-07.1` | Crear migración de la tabla `ajustes_inventario` para auditoría de movimientos manuales. | Base de Datos | Aron C. | 2h | Almacena tipo de ajuste, cantidad, motivo obligatorio y usuario responsable. |
| `TSK-07.2` | Implementar `RegistrarAjusteStockCommand` con transacción ACID en base de datos. | Backend — Aplicación | Aron C. | 4h | Actualización inmediata de `inventario.stock_actual` registrando la traza de auditoría. |
| `TSK-07.3` | Implementar exportación de inventario y kardex a formatos Excel (.xlsx) y PDF. | Backend — Infraestructura | Aron C. | 4h | Generación de reportes limpios con cabeceras formales del negocio. |
| `TSK-07.4` | Diseñar modal de ajuste manual de existencias con motivo tipificado y vista de historial. | Frontend — UI | Luis C. | 4h | Interfaz intuitiva exclusiva para rol Administrador. |
| `TSK-07.5` | Pruebas funcionales de ajustes positivos, negativos y validación de justificación requerida. | QA & Pruebas | Giorgini D. | 3h | Cobertura de errores al intentar ajustar stock con cantidades inválidas o sin motivo. |

### HU-08: Órdenes de Compra y Recepción de Mercadería (5 SP)
| Código Task | Descripción de la Tarea Técnica | Capa / Disciplina | Responsable | Est. (Horas) | Definición de Terminado (DoD) |
|---|---|---|---|:---:|---|
| `TSK-08.1` | Crear endpoints para recepción masiva de mercadería e incremento automático de stock. | Backend — Aplicación | Aron C. | 4h | Actualización por lotes protegida por transacciones atómicas. |
| `TSK-08.2` | Diseñar pantalla de ingreso de compras por lote de prendas recibidas. | Frontend — UI | Luis C. | 4h | Formulario con lectura rápida por SKU o selección en tabla. |
| `TSK-08.3` | Pruebas de integración de recepción de compras y recálculo de costos unitarios. | QA & Pruebas | Giorgini D. | 3h | Verificación de actualización simultánea de existencias y costos referenciales. |

### HU-13 & HU-14: Gestión de Turnos de Caja y Movimientos Menores (11 SP)
| Código Task | Descripción de la Tarea Técnica | Capa / Disciplina | Responsable | Est. (Horas) | Definición de Terminado (DoD) |
|---|---|---|---|:---:|---|
| `TSK-13.1` | Crear migraciones para `turnos_caja` y `movimientos_caja` en MySQL. | Base de Datos | Aron C. | 3h | Control de monto inicial de apertura, monto de cierre y balance calculado. |
| `TSK-13.2` | Implementar `AbrirCajaCommand`, `CerrarCajaCommand` y cálculo de arqueo ciego. | Backend — Aplicación | Aron C. | 5h | Validación de que un vendedor no pueda cobrar si no tiene una caja abierta. |
| `TSK-13.3` | Implementar `RegistrarMovimientoCajaCommand` para salidas menores justificadas (gastos). | Backend — Aplicación | Aron C. | 3h | Descuento del saldo en efectivo de la caja activa con motivo registrado. |
| `TSK-13.4` | Diseñar interfaz de terminal de caja: estado de turno, balance actual y arqueo de billetes. | Frontend — UI | Luis C. | 5h | Pantalla clara con teclado numérico accesible para agilizar el conteo. |
| `TSK-13.5` | Pruebas del flujo de caja: apertura -> operaciones del turno -> arqueo -> cierre final. | QA & Pruebas | Giorgini D. | 4h | Verificación de detección de sobrantes y faltantes de efectivo en el cuadre. |

---

## 💳 SPRINT 3: Punto de Venta (POS), Liquidación Mixta y Tickets Digitales
> **Meta del Sprint:** Construir la experiencia central de ventas en tienda: catálogo de búsqueda rápida, carrito transaccional, pagos combinados (Yape/Efectivo/Tarjeta), descuento automático de stock y ticket digital sin conexión con SUNAT.

### HU-09: Terminal de Venta Rápida (POS) y Carrito Transaccional (8 SP)
| Código Task | Descripción de la Tarea Técnica | Capa / Disciplina | Responsable | Est. (Horas) | Definición de Terminado (DoD) |
|---|---|---|---|:---:|---|
| `TSK-09.1` | Implementar buscador predictivo de productos por nombre, código de barras y SKU. | Backend — Aplicación | Aron C. | 4h | Respuesta rápida optimizada con índices MySQL para cobro ágil. |
| `TSK-09.2` | Diseñar pantalla de Punto de Venta (POS) en React con navegación táctil y atajos de teclado. | Frontend — UI | Luis C. | 6h | Carrito lateral con cálculo automático de totales, botones de cantidad y limpieza rápida. |
| `TSK-09.3` | Implementar estado global del carrito de compras (Zustand / Context) con validación de stock local. | Frontend — Lógica | Aron C. | 5h | Impide agregar más unidades de las disponibles físicamente en la tienda actual. |
| `TSK-09.4` | Configurar persistencia local temporal del carrito en IndexedDB para prevenir pérdida de datos. | Frontend — Offline | Aron C. | 4h | Si el navegador se refresca por accidente, la venta en curso se recupera intacta. |

### HU-10: Liquidación Multitendencia de Medios de Pago Mixtos (8 SP)
| Código Task | Descripción de la Tarea Técnica | Capa / Disciplina | Responsable | Est. (Horas) | Definición de Terminado (DoD) |
|---|---|---|---|:---:|---|
| `TSK-10.1` | Crear migraciones de `ventas`, `detalle_ventas` y `pagos_venta` en MySQL. | Base de Datos | Aron C. | 3h | Soporte para múltiples registros de pago vinculados a una sola cabecera de venta. |
| `TSK-10.2` | Implementar `RegistrarVentaCommand` con transacción atómica estricta (`DB::transaction`). | Backend — Aplicación | Aron C. | 5h | Operación todo-o-nada: crea venta, registra detalles, descuenta stock y registra pagos. |
| `TSK-10.3` | Implementar validación de cuadre de importes (`suma(pagos) == total_venta`). | Backend — Dominio | Aron C. | 3h | La regla de negocio rechaza la venta si el monto cubierto no coincide exactamente. |
| `TSK-10.4` | Diseñar modal de cobro multitendencia: Efectivo con cálculo de vuelto, Yape, Plin y Tarjeta. | Frontend — UI | Luis C. | 5h | Interfaz con botones rápidos de denominación de billetes y campo de referencia digital. |
| `TSK-10.5` | Pruebas de concurrencia y validación de integridad de stock en ventas simultáneas. | QA & Pruebas | Giorgini D. | 4h | Pruebas de estrés que garantizan que el stock no quede en negativo. |

### HU-11: Emisión y Generación de Ticket Digital de Venta (5 SP)
| Código Task | Descripción de la Tarea Técnica | Capa / Disciplina | Responsable | Est. (Horas) | Definición de Terminado (DoD) |
|---|---|---|---|:---:|---|
| `TSK-11.1` | Diseñar plantilla visual y generador de ticket digital (PDF/HTML térmico 80mm/58mm). | Backend — Infraestructura | Aron C. | 4h | Ticket estandarizado con folio correlativo, desglose de prendas, medios de pago y local. |
| `TSK-11.2` | Implementar modal de confirmación de venta con opciones de descarga y envío digital. | Frontend — UI | Luis C. | 3h | Botón de descarga directa en PDF y visualización previa limpia en pantalla. |
| `TSK-11.3` | Pruebas de generación y formateo de tickets digitales en resoluciones térmicas y estándar. | QA & Pruebas | Giorgini D. | 2h | Verificación de que el ticket no incluye datos tributarios de SUNAT (100% interno). |

### HU-05, HU-15 & HU-16: Catálogo Público, Clientes y Soporte Comercial (9 SP)
| Código Task | Descripción de la Tarea Técnica | Capa / Disciplina | Responsable | Est. (Horas) | Definición de Terminado (DoD) |
|---|---|---|---|:---:|---|
| `TSK-15.1` | Implementar directorio de clientes frecuentes (búsqueda por celular/nombre en caja). | Backend & Frontend | Aron / Luis | 4h | Agiliza asociar el ticket digital a un cliente sin registro engorroso. |
| `TSK-15.2` | Diseñar e integrar portal web público de Catálogo Digital (solo lectura) con fotos y stock. | Frontend — Web | Luis / Aron | 6h | Vista pública responsive que muestra prendas disponibles y disponibilidad por tienda. |
| `TSK-15.3` | Pruebas del catálogo digital público en navegadores móviles (Chrome, Safari). | QA & Pruebas | Giorgini D. | 3h | Navegación fluida y filtros por categoría/talla funcionando correctamente. |

---

## 📊 SPRINT 4: Reportería Gerencial, Auditoría y Despliegue con Docker
> **Meta del Sprint:** Proporcionar al Administrador tableros de rendimiento comercial, auditoría de transacciones, exportaciones ejecutivas y despliegue del sistema empaquetado en producción.

### HU-17: Tablero de Reportería Estratégica y Métricas de Ventas (5 SP)
| Código Task | Descripción de la Tarea Técnica | Capa / Disciplina | Responsable | Est. (Horas) | Definición de Terminado (DoD) |
|---|---|---|---|:---:|---|
| `TSK-17.1` | Implementar queries optimizadas de agregación en MySQL para métricas de venta y ganancia neta. | Base de Datos | Aron C. | 4h | Consultas calculadas por fórmulas de costo unitario histórico vs precio de venta. |
| `TSK-17.2` | Implementar `ObtenerMetricasVentasQuery` con filtros por rango de fechas, sucursal y vendedor. | Backend — Aplicación | Aron C. | 4h | Endpoint que entrega resumen consolidado, ranking de productos y flujo por medio de pago. |
| `TSK-17.3` | Diseñar dashboard gerencial con gráficos estadísticos interactivos (Chart.js / Recharts). | Frontend — UI | Luis C. | 6h | Tarjetas de KPI (ventas del día, ticket promedio, top prendas más vendidas) y comparativas. |
| `TSK-17.4` | Implementar exportación de reportes ejecutivos consolidados a Excel y PDF. | Backend — Infraestructura | Aron C. | 3h | Reportes con membrete formal listos para impresión o análisis financiero. |
| `TSK-17.5` | Validación matemática de cálculos de ganancias, totales y filtros cruzados en reportes. | QA & Pruebas | Giorgini D. | 4h | Comparación de suma de tickets individuales contra totales agregados en el dashboard. |

### HU-18: Registro de Auditoría y Trazabilidad del Sistema (5 SP)
| Código Task | Descripción de la Tarea Técnica | Capa / Disciplina | Responsable | Est. (Horas) | Definición de Terminado (DoD) |
|---|---|---|---|:---:|---|
| `TSK-18.1` | Crear middleware y suscriptor de eventos para auditoría de acciones sensibles en BD. | Backend — Infraestructura | Aron C. | 4h | Registro automático de usuario, IP, fecha, hora y acción realizada en el sistema. |
| `TSK-18.2` | Diseñar vista de consulta del registro de auditoría con filtros por fecha y usuario (Solo Admin). | Frontend — UI | Luis C. | 3h | Tabla de trazabilidad protegida que no permite modificación ni borrado de eventos. |
| `TSK-18.3` | Pruebas de inmutabilidad y registro certero de eventos de inicio de sesión y ventas. | QA & Pruebas | Giorgini D. | 3h | Garantía de que cada acción sensible queda grabada en el historial del sistema. |

### Preparación para Producción, CI/CD y Despliegue con Docker (4 SP)
| Código Task | Descripción de la Tarea Técnica | Capa / Disciplina | Responsable | Est. (Horas) | Definición de Terminado (DoD) |
|---|---|---|---|:---:|---|
| `TSK-DP.1` | Configurar Dockerfiles optimizados multi-stage (PHP-FPM, Nginx, Node build) para producción. | DevOps | Aron C. | 4h | Imágenes livianas y seguras sin dependencias innecesarias de desarrollo. |
| `TSK-DP.2` | Configurar pipeline de CI/CD en GitHub Actions (lint, pruebas unitarias automáticas y build). | DevOps & QA | Giorgini / Aron | 4h | Validación automática de pull requests antes de fusionar a la rama `main`. |
| `TSK-DP.3` | Pruebas integrales de extremo a extremo (E2E) simulando jornada comercial completa. | QA & Equipo | Todos | 6h | Validación final de los 5 módulos operando de forma continua sin caídas. |

---

## 👥 Resumen de Asignación y Carga por Integrante del Equipo

| Integrante | Rol Principal | Enfoque de Tareas | Carga Total Estimada |
|---|---|---|:---:|
| **Aron Cachicatari** | Desarrollador Full-Stack & Líder Técnico | Arquitectura Clean, Migraciones MySQL, Endpoints API REST, Lógica transaccional y Docker. | **~158 horas** |
| **Luis Condori** | Diseñador UI/UX & Analista Funcional | Prototipado en Figma, Maquetación con Tailwind CSS, Componentes React y Experiencia POS. | **~92 horas** |
| **Giorgini Disalvatore** | Analista de Calidad (QA) & Scrum Master | Casos de prueba unitarios, E2E, seguridad RBAC, pipeline CI y seguimiento del tablero Scrum. | **~62 horas** |
| **Johan Mamani** | Líder / Product Owner | Gestión de acuerdos, revisión de aceptación de Sprint, validación comercial y documentación. | **~28 horas** |
