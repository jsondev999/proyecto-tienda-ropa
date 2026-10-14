# Especificación de Casos de Prueba (QA / Testing)

**Proyecto:** Sistema de Gestión — Tienda de Ropa para Varón  
**Versión:** 2.0  
**Fecha:** 13/10/2026  
**Estándar de Pruebas:** IEEE 829 / ISTQB  
**Total de Casos de Prueba:** 77 Casos de Prueba (CP-01 a CP-77)  

---

## 📌 1. Marco Metodológico y Estructura del Caso de Prueba

En concordancia con la pregunta metodológica de la cátedra:
> *"¿Cómo demuestro que realmente se cumplió el requerimiento? Respuesta: **Criterios de aceptación y pruebas**."*

Cada **Caso de Prueba (CP)** representa un escenario de verificación empírico que valida los criterios de aceptación técnicos establecidos en el documento de especificación funcional ([`docs/requisitos_funcionales.md`](requisitos_funcionales.md)).

### 1.1 Estructura Estándar de cada Caso de Prueba
* **Identificador:** Código único correlativo `CP-XX`.
* **Requerimiento Asociado:** Código y nombre del Requisito Funcional `RF-XX`.
* **Criterios de Aceptación Evaluados:** Reglas de negocio que el software debe cumplir para considerarse aceptado.
* **Tipo de Prueba:** Funcional (Positiva / Negativa / Validación de Límites).
* **Precondiciones y Datos de Entrada:** Estado previo del sistema y valores introducidos.
* **Procedimiento / Pasos de Prueba:** Acciones ejecutadas en la interfaz de usuario o API.
* **Resultado Esperado:** Comportamiento verificable que debe manifestar el sistema según sus criterios de aceptación.
* **Estado de la Prueba:** **Pendiente (Diseñado — Listo para ejecución en fase de implementación)**.

---

## 📋 2. Índice General de Mapeo: RF ↔ CP

| Módulo | Rango de Requisitos | Rango de Casos de Prueba | Cantidad |
|---|:---:|:---:|:---:|
| **M1: Autenticación y Seguridad** | RF-01 al RF-14, RF-73 | CP-01 al CP-14, CP-73 | 15 CP |
| **M2: Gestión de Inventario** | RF-15 al RF-39, RF-74, RF-75, RF-77 | CP-15 al CP-39, CP-74, CP-75, CP-77 | 28 CP |
| **M3: Registro de Ventas** | RF-40 al RF-55, RF-76 | CP-40 al CP-55, CP-76 | 17 CP |
| **M4: Reportes y Análisis** | RF-56 al RF-66 | CP-56 al CP-66 | 11 CP |
| **M5: Catálogo Digital Web** | RF-67 al RF-72 | CP-67 al CP-72 | 6 CP |
| **TOTAL GENERAL** | **RF-01 al RF-77** | **CP-01 al CP-77** | **77 Casos de Prueba** |

---

## 🔐 3. MÓDULO 1: AUTENTICACIÓN Y SEGURIDAD (CP-01 a CP-14, CP-73)

| ID CP | RF Vinculado | Tipo de Prueba | Precondiciones y Datos de Entrada | Procedimiento de Prueba | Resultado Esperado (Criterios Verificados) | Estado |
|:---:|---|:---:|---|---|---|:---:|
| **CP-01** | **RF-01** — Solicitar usuario | Validación UI | Pantalla de Login activa.<br>Usuario: `[Vacío]`. | 1. Dejar campo usuario en blanco.<br>2. Ingresar contraseña y pulsar "Ingresar". | El sistema bloquea el envío y muestra mensaje de campo obligatorio requerido. | ⏳ Pendiente |
| **CP-02** | **RF-02** — Solicitar contraseña | Seguridad UI | Formulario Login.<br>Password: `Clave123!`. | 1. Escribir contraseña en el campo.<br>2. Inspeccionar caracteres tipeados. | Los caracteres se muestran enmascarados (puntos u asteriscos) protegiendo la privacidad. | ⏳ Pendiente |
| **CP-03** | **RF-03** — Autenticar usuario | Funcional (Positiva) | Usuario registrado y activo.<br>Datos válidos. | 1. Ingresar usuario y contraseña correctos.<br>2. Clic en "Ingresar". | Sistema valida credenciales en BD, concede acceso y redirige al panel según su rol. | ⏳ Pendiente |
| **CP-04** | **RF-04** — Validar credenciales | Lógica Backend | Endpoint `/api/auth/login`.<br>Payload JSON con credenciales. | 1. Enviar petición HTTP POST.<br>2. Verificar hashing en BD. | El backend compara el hash bcrypt y retorna token JWT válido si coincide. | ⏳ Pendiente |
| **CP-05** | **RF-05** — Denegar acceso erróneo | Funcional (Negativa) | Usuario existente.<br>Password errónea: `BadPass`. | 1. Ingresar credenciales inválidas.<br>2. Pulsar botón "Ingresar". | Sistema rechaza acceso, no genera token y muestra mensaje de advertencia. | ⏳ Pendiente |
| **CP-06** | **RF-06** — Bloqueo por intentos | Seguridad | Usuario activo.<br>3 intentos con clave errónea. | 1. Ingresar clave errónea 3 veces seguidas.<br>2. Intentar 4to acceso. | A la 3ra falla la cuenta pasa a estado "Bloqueada" y rechaza accesos posteriores. | ⏳ Pendiente |
| **CP-07** | **RF-07** — Asignar roles | Autorización | Panel de gestión de usuarios.<br>Rol: Administrador / Vendedor. | 1. Crear o editar colaborador.<br>2. Seleccionar rol del desplegable. | El rol queda persistido en BD asignando los permisos correspondientes. | ⏳ Pendiente |
| **CP-08** | **RF-08** — Restringir por rol | Seguridad (RBAC) | Sesión iniciada con rol Vendedor.<br>Intento de acceso a `/reportes`. | 1. Vendedor intenta navegar a módulos restringidos de administración. | Sistema deniega acceso con error HTTP 403 Forbidden y redirige a su panel POS. | ⏳ Pendiente |
| **CP-09** | **RF-09** — Cerrar sesión | Seguridad | Sesión activa con token JWT.<br>Opción "Cerrar Sesión". | 1. Clic en "Cerrar Sesión".<br>2. Confirmar salida. | Token se invalida en cliente/servidor y redirige a la pantalla de login público. | ⏳ Pendiente |
| **CP-10** | **RF-10** — Crear usuario | Funcional | Admin autenticado.<br>Formulario nuevo usuario. | 1. Completar datos, rol y local.<br>2. Guardar usuario. | Nuevo colaborador registrado con contraseña cifrada y estado activo. | ⏳ Pendiente |
| **CP-11** | **RF-11** — Listar usuarios | Consulta | Admin autenticado.<br>Módulo usuarios. | 1. Ingresar a "Usuarios".<br>2. Revisar tabla. | Despliega lista completa de usuarios con rol, local asignado y estado. | ⏳ Pendiente |
| **CP-12** | **RF-12** — Modificar usuario | Funcional | Admin autenticado.<br>Usuario existente. | 1. Editar nombre o local de usuario.<br>2. Guardar cambios. | Datos actualizados en BD reflejándose de inmediato en la tabla. | ⏳ Pendiente |
| **CP-13** | **RF-13** — Desactivar cuenta | Seguridad | Admin autenticado.<br>Colaborador retirado. | 1. Seleccionar "Desactivar cuenta".<br>2. Confirmar. | Estado cambia a "Inactivo" e impide que el usuario vuelva a iniciar sesión. | ⏳ Pendiente |
| **CP-14** | **RF-14** — Desbloquear cuenta | Seguridad | Cuenta en estado "Bloqueada".<br>Admin autenticado. | 1. Seleccionar cuenta bloqueada.<br>2. Clic en "Desbloquear". | Estado pasa a "Activo" y contador de intentos fallidos se reinicia a cero. | ⏳ Pendiente |
| **CP-73** | **RF-73** — Resetear contraseña | Seguridad Admin | Admin autenticado.<br>Nueva clave temporal. | 1. Admin pulsa "Resetear Clave".<br>2. Ingresa nueva contraseña. | Contraseña del empleado se actualiza con nuevo hash bcrypt en BD. | ⏳ Pendiente |

---

## 📦 4. MÓDULO 2: GESTIÓN DE INVENTARIO (CP-15 a CP-39, CP-74, CP-75, CP-77)

| ID CP | RF Vinculado | Tipo de Prueba | Precondiciones y Datos de Entrada | Procedimiento de Prueba | Resultado Esperado (Criterios Verificados) | Estado |
|:---:|---|:---:|---|---|---|:---:|
| **CP-15** | **RF-15** — Registrar prenda | Funcional | Admin autenticado.<br>Datos completos y foto de prenda. | 1. Completar formulario con atributos maestros.<br>2. Guardar. | Prenda registrada con SKU único y existencias iniciales por local. | ⏳ Pendiente |
| **CP-16** | **RF-16** — Modificar prenda | Funcional | Prenda existente.<br>Cambio de precio de venta. | 1. Editar precio de venta.<br>2. Confirmar modificación. | Precio actualizado en BD y reflejado en POS y catálogo web. | ⏳ Pendiente |
| **CP-17** | **RF-17** — Eliminar prenda | Integridad | Prenda con historial de ventas vs. prenda nueva sin ventas. | 1. Intentar borrar prenda con ventas históricas.<br>2. Probar con prenda sin ventas. | Prenda con ventas aplica borrado lógico (desactivación); sin ventas permite borrado físico. | ⏳ Pendiente |
| **CP-18** | **RF-18** — Consultar prenda | Consulta | SKU: `CAM-AZ-001` o término `"Camisa Slim"`. | 1. Digitar en barra de búsqueda.<br>2. Presionar Enter. | Sistema localiza la prenda y exhibe descripción, precios y stock por local. | ⏳ Pendiente |
| **CP-19** | **RF-19** — Stock inicial por local | Multi-local | Prenda nueva.<br>Local 1: 15 un., Local 2: 20 un. | 1. Asignar stock diferenciado por tienda.<br>2. Guardar. | Registros independientes en tabla `inventario` para cada local comercial. | ⏳ Pendiente |
| **CP-20** | **RF-20** — Ajustar stock | Funcional | Ingreso de 10 unidades por compra en Local 1. | 1. Seleccionar tipo "Ingreso".<br>2. Digitar cantidad y motivo. | Stock del Local 1 se incrementa en 10 y se genera asiento en Kardex. | ⏳ Pendiente |
| **CP-21** | **RF-21** — Descontar stock por venta | Transaccional | Stock inicial: 8 unidades.<br>Venta de 2 unidades en POS. | 1. Finalizar venta de 2 prendas.<br>2. Verificar stock restante. | Stock del local donde se vendió disminuye automáticamente a 6 unidades. | ⏳ Pendiente |
| **CP-22** | **RF-22** — Consultar stock por local | Consulta | Vendedor en mostrador.<br>Prenda seleccionada. | 1. Abrir ficha de inventario.<br>2. Revisar desglose. | Exhibe columnas separadas para existencias en Local 1 y Local 2. | ⏳ Pendiente |
| **CP-23** | **RF-23** — Alertas visuales stock | UI / Alerta | Prenda con stock 2 (umbral mínimo configurado en 5). | 1. Consultar tabla de inventario.<br>2. Verificar distintivo. | Muestra fila resaltada en naranja/rojo con etiqueta "Stock Bajo". | ⏳ Pendiente |
| **CP-24** | **RF-24** — Configurar umbral mínimo | Configuración | Prenda en Local 1.<br>Nuevo umbral: 6 unidades. | 1. Asignar umbral mínimo de 6.<br>2. Guardar. | Umbral actualizado; activa alertas automáticas si el stock cae a $\le 6$. | ⏳ Pendiente |
| **CP-25** | **RF-25** — Notificar stock crítico | Notificaciones | Stock llega a 0 en cualquier local. | 1. Vender última unidad.<br>2. Iniciar sesión como Admin. | Panel de administración muestra alerta prioritaria de reposición urgente. | ⏳ Pendiente |
| **CP-26** | **RF-26** — Registrar categoría | Catálogos | Admin autenticado.<br>Nueva: `"Bermudas"`. | 1. Ingresar nombre en catálogos maestros.<br>2. Guardar. | Categoría creada y disponible en combos de registro de prendas. | ⏳ Pendiente |
| **CP-27** | **RF-27** — Modificar categoría | Catálogos | Categoría existente. | 1. Cambiar denominación.<br>2. Guardar. | Nombre actualizado sin alterar la relación con las prendas asociadas. | ⏳ Pendiente |
| **CP-28** | **RF-28** — Eliminar categoría | Integridad | Categoría con prendas asociadas. | 1. Intentar eliminar categoría en uso. | Sistema bloquea el borrado informando prendas vinculadas activas. | ⏳ Pendiente |
| **CP-29** | **RF-29** — Registrar talla | Catálogos | Nueva talla: `"34"`. | 1. Registrar talla numérica en maestro.<br>2. Guardar. | Talla disponible en selector de prendas. | ⏳ Pendiente |
| **CP-30** | **RF-30** — Modificar talla | Catálogos | Talla registrada. | 1. Editar valor de talla.<br>2. Guardar. | Actualiza valor en catálogo maestro. | ⏳ Pendiente |
| **CP-31** | **RF-31** — Registrar color | Catálogos | Nombre: `"Vino"`, HEX: `#5E1914`. | 1. Guardar nuevo color maestro.<br>2. Verificar en prenda. | Color registrado con muestra visual de color hexadecimal. | ⏳ Pendiente |
| **CP-32** | **RF-32** — Modificar color | Catálogos | Color existente. | 1. Editar nombre o código HEX.<br>2. Guardar. | Cambios persistidos en el catálogo de colores. | ⏳ Pendiente |
| **CP-33** | **RF-33** — Registrar marca | Catálogos | Nueva marca: `"Dockers"`. | 1. Guardar nueva marca en maestro.<br>2. Verificar selector. | Marca añadida al catálogo cerrado para selección en prendas. | ⏳ Pendiente |
| **CP-34** | **RF-34** — Modificar marca | Catálogos | Marca existente. | 1. Editar denominación.<br>2. Guardar. | Nombre de marca actualizado correctamente. | ⏳ Pendiente |
| **CP-35** | **RF-35** — Búsqueda predictiva | Usabilidad | Campo de búsqueda.<br>Tipear `"Pol"`. | 1. Escribir 3 letras en el buscador de inventario. | Filtra instantáneamente mostrando Polos y Poleras en $< 1$ segundo. | ⏳ Pendiente |
| **CP-36** | **RF-36** — Filtrar por categoría | Consulta | Selector categoría: `"Camisas"`. | 1. Seleccionar filtro Camisas. | Tabla actualiza mostrando exclusivamente prendas de dicha categoría. | ⏳ Pendiente |
| **CP-37** | **RF-37** — Filtrar por talla | Consulta | Selector talla: `"M"`. | 1. Seleccionar talla M. | Despliega prendas con disponibilidad en talla M. | ⏳ Pendiente |
| **CP-38** | **RF-38** — Filtrar por marca | Consulta | Selector marca: `"Levi's"`. | 1. Seleccionar marca. | Filtra el catálogo por la marca comercial elegida. | ⏳ Pendiente |
| **CP-39** | **RF-39** — Filtrar por precio | Validación límites | Rango: S/ 50.00 a S/ 120.00. | 1. Establecer rango mínimo y máximo. | Muestra solo productos con precio de venta dentro del intervalo. | ⏳ Pendiente |
| **CP-74** | **RF-74** — Validación catálogos | Integridad datos | Formulario de prenda.<br>Intento de texto libre. | 1. Verificar si existen campos de texto libre para talla o color. | Comprueba que el 100% de atributos son listas desplegables cerradas. | ⏳ Pendiente |
| **CP-75** | **RF-75** — Filtros combinables | Complejidad | Filtro simultáneo: Categoría + Talla + Local. | 1. Aplicar "Pantalones" + Talla "32" + "Local 1". | Sistema resuelve la intersección lógica (AND) mostrando el resultado exacto. | ⏳ Pendiente |
| **CP-77** | **RF-77** — Alerta reposición local | Notificaciones | Local 1 sin stock, Local 2 con stock. | 1. Revisar panel de inventario por local. | Sugiere traslado interno de mercadería desde Local 2 hacia Local 1. | ⏳ Pendiente |

---

## 💳 5. MÓDULO 3: REGISTRO DE VENTAS (CP-40 a CP-55, CP-76)

| ID CP | RF Vinculado | Tipo de Prueba | Precondiciones y Datos de Entrada | Procedimiento de Prueba | Resultado Esperado (Criterios Verificados) | Estado |
|:---:|---|:---:|---|---|---|:---:|
| **CP-40** | **RF-40** — Iniciar venta | POS / Funcional | Vendedor autenticado.<br>Punto de venta (POS). | 1. Clic en "Nueva Venta". | Inicializa orden limpia con fecha, cajero y local asignado. | ⏳ Pendiente |
| **CP-41** | **RF-41** — Agregar prendas | POS | Escaneo de SKU o selección en catálogo. | 1. Agregar prenda con stock disponible. | Artículo se añade a la grilla de venta con precio unitario y cantidad 1. | ⏳ Pendiente |
| **CP-42** | **RF-42** — Modificar cantidad | POS | Prenda en carrito.<br>Cambiar cantidad de 1 a 3. | 1. Editar cantidad en carrito de venta. | Valida stock y recalcula subtotal de la línea de producto. | ⏳ Pendiente |
| **CP-43** | **RF-43** — Eliminar prenda | POS | 2 prendas en orden.<br>Eliminar 1 prenda. | 1. Pulsar icono papelera en una línea. | Quita el artículo del carrito y descuenta su importe del total general. | ⏳ Pendiente |
| **CP-44** | **RF-44** — Calcular total | Aritmética | Prendas por S/ 100.00 y S/ 50.00.<br>Descuento 10%. | 1. Aplicar descuento promocional del 10%. | Calcula Subtotal: S/ 150.00, Descuento: S/ 15.00, Total a pagar: S/ 135.00. | ⏳ Pendiente |
| **CP-45** | **RF-45** — Medios de pago | Funcional | Selectores: Efectivo, Tarjeta, Yape/Plin. | 1. Seleccionar medio de pago deseado. | Habilita campos específicos (monto recibido para efectivo o código de operación). | ⏳ Pendiente |
| **CP-46** | **RF-46** — Cobro y cambio | Aritmética | Total: S/ 85.00.<br>Efectivo recibido: S/ 100.00. | 1. Digitar S/ 100 en importe recibido. | Calcula y muestra automáticamente el cambio/vuelto: S/ 15.00. | ⏳ Pendiente |
| **CP-47** | **RF-47** — Confirmar venta | Transaccional | Venta completa con pago validado. | 1. Clic en "Confirmar y Cobrar". | Registra venta, descuenta stock del local y bloquea edición de la orden. | ⏳ Pendiente |
| **CP-48** | **RF-48** — Generar ticket digital | Funcional | Venta confirmada exitosamente. | 1. Finalizar venta en mostrador. | Genera ticket con código correlativo único (ej. `TICK-L1-000124`). | ⏳ Pendiente |
| **CP-49** | **RF-49** — Imprimir ticket | Salida física | Impresora térmica / PDF. | 1. Clic en "Imprimir Ticket". | Abre cuadro de impresión térmica de 80mm o descarga directa de PDF. | ⏳ Pendiente |
| **CP-50** | **RF-50** — Enviar ticket digital | Salida digital | Número de celular / WhatsApp. | 1. Ingresar número telefónico del cliente.<br>2. Enviar. | Despacha enlace al ticket digital vía API de mensajería/WhatsApp. | ⏳ Pendiente |
| **CP-51** | **RF-51** — Historial de ventas | Auditoría | Módulo historial.<br>Rango de fechas. | 1. Consultar historial de ventas. | Despliega lista cronológica con tickets, montos, local y estado. | ⏳ Pendiente |
| **CP-52** | **RF-52** — Detalle de venta | Consulta | Venta registrada previamente. | 1. Clic en ver detalle de ticket. | Muestra desglose de prendas vendidas, precios unitarios y medio de pago. | ⏳ Pendiente |
| **CP-53** | **RF-53** — Anular venta | Seguridad Admin | Admin autenticado.<br>Venta completada. | 1. Admin pulsa "Anular Venta".<br>2. Ingresa motivo obligatorio y clave. | Venta pasa a "Anulada" y el stock se reintegra de inmediato al local. | ⏳ Pendiente |
| **CP-54** | **RF-54** — Operación offline | Tolerancia fallos | Desconexión de cable de red/WiFi en caja. | 1. Procesar venta sin Internet. | Guarda venta localmente en IndexedDB y emite ticket offline provisional. | ⏳ Pendiente |
| **CP-55** | **RF-55** — Sincronización offline | Sincronización | Reconexión a Internet tras modo offline. | 1. Restablecer conexión de red. | Sincroniza ventas locales con el servidor central consolidando stock. | ⏳ Pendiente |
| **CP-76** | **RF-76** — Tickets internos sin SUNAT | Legal / Negocio | Formato de ticket emitido. | 1. Inspeccionar campos del ticket impreso. | Verifica que indique "Comprobante de Control Interno sin validez tributaria". | ⏳ Pendiente |

---

## 📊 6. MÓDULO 4: REPORTES Y ANÁLISIS (CP-56 a CP-66)

| ID CP | RF Vinculado | Tipo de Prueba | Precondiciones y Datos de Entrada | Procedimiento de Prueba | Resultado Esperado (Criterios Verificados) | Estado |
|:---:|---|:---:|---|---|---|:---:|
| **CP-56** | **RF-56** — Ventas por fechas | Analítica | Rango: 01/10/2026 al 15/10/2026. | 1. Establecer rango y generar reporte. | Lista transacciones e ingresos generados exactamente en ese intervalo. | ⏳ Pendiente |
| **CP-57** | **RF-57** — Ventas por local | Analítica | Filtro: "Local 1" vs. "Local 2". | 1. Seleccionar sucursal física. | Discrimina ingresos y volumen transaccional de la tienda elegida. | ⏳ Pendiente |
| **CP-58** | **RF-58** — Ventas por empleado | Analítica | Filtro: Vendedor específico. | 1. Seleccionar colaborador en reporte. | Calcula ventas brutas y número de tickets emitidos por el empleado. | ⏳ Pendiente |
| **CP-59** | **RF-59** — Ranking Top prendas | Analítica | Ventas acumuladas del mes. | 1. Abrir reporte de productos más vendidos. | Muestra Top 10 de prendas con mayor cantidad de unidades vendidas. | ⏳ Pendiente |
| **CP-60** | **RF-60** — Prendas baja rotación | Analítica | Ventas de últimos 60 días. | 1. Consultar prendas con rotación cero o baja. | Identifica prendas estancadas para aplicar descuentos o promociones. | ⏳ Pendiente |
| **CP-61** | **RF-61** — Ingresos totales | Aritmética | Sumatoria de tickets del mes. | 1. Consultar reporte de recaudación. | Totaliza ingresos en soles deduciendo ventas anuladas. | ⏳ Pendiente |
| **CP-62** | **RF-62** — Filtrar por categoría/marca | Analítica | Filtro: Marca "Boston" en Pantalones. | 1. Combinar filtros en reportes. | Genera estadísticas de ventas segmentadas por marca y categoría. | ⏳ Pendiente |
| **CP-63** | **RF-63** — Exportar a PDF | Salida reporte | Reporte de ventas en pantalla. | 1. Clic en "Exportar a PDF". | Descarga documento PDF formal con membrete, tablas y firmas. | ⏳ Pendiente |
| **CP-64** | **RF-64** — Exportar a Excel | Salida datos | Reporte de ventas en pantalla. | 1. Clic en "Exportar a Excel". | Descarga archivo `.xlsx` estructurado en celdas para análisis contable. | ⏳ Pendiente |
| **CP-65** | **RF-65** — Gráficos estadísticos | Dashboard UI | Módulo de reportes. | 1. Visualizar panel de métricas. | Renderiza gráficos de barras y líneas temporales de ventas en $< 3$ seg. | ⏳ Pendiente |
| **CP-66** | **RF-66** — Comparativo entre locales | Analítica | Ventas del mes en ambos locales. | 1. Clic en "Comparativa Local 1 vs Local 2". | Exhibe gráfico comparativo de ingresos y unidades entre sucursales. | ⏳ Pendiente |

---

## 🌐 7. MÓDULO 5: CATÁLOGO DIGITAL WEB (CP-67 a CP-72)

| ID CP | RF Vinculado | Tipo de Prueba | Precondiciones y Datos de Entrada | Procedimiento de Prueba | Resultado Esperado (Criterios Verificados) | Estado |
|:---:|---|:---:|---|---|---|:---:|
| **CP-67** | **RF-67** — Acceso público sin login | Funcional | Visitante en navegador de incógnito.<br>URL pública del catálogo. | 1. Ingresar a la URL principal de la tienda. | Acceso inmediato a la galería de prendas sin requerir registro ni contraseña. | ⏳ Pendiente |
| **CP-68** | **RF-68** — Filtros web catálogo | Consulta | Filtro web: Talla L y Color Negro. | 1. Aplicar filtros en catálogo público. | Galería web actualiza dinámicamente mostrando solo prendas coincidentes. | ⏳ Pendiente |
| **CP-69** | **RF-69** — Detalle y fotos en HD | UI / Multimedia | Prenda seleccionada en catálogo. | 1. Clic sobre la foto de la prenda. | Abre ficha técnica con fotos en alta definición, zoom y descripción. | ⏳ Pendiente |
| **CP-70** | **RF-70** — Stock referencial por tienda | Multi-local | Ficha técnica de prenda en web. | 1. Consultar sección "Disponibilidad en Tiendas". | Indica si hay existencias disponibles en **Local 1** y en **Local 2**. | ⏳ Pendiente |
| **CP-71** | **RF-71** — Compartir producto | Integración | Ficha de prenda en catálogo web. | 1. Clic en botón "Compartir en WhatsApp". | Abre enlace con texto y foto del producto listo para enviar a contactos. | ⏳ Pendiente |
| **CP-72** | **RF-72** — Diseño web responsivo | Compatibilidad | Visualización en smartphone (360px), tablet (768px) y monitor (1920px). | 1. Redimensionar pantalla o usar emulador de dispositivos móviles. | La interfaz adapta menú, grilla de fotos y botones sin desbordamientos. | ⏳ Pendiente |
