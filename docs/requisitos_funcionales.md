# Requisitos Funcionales

**Proyecto:** Sistema de Gestión — Tienda de Ropa para Varón  
**Versión:** 2.0  
**Fecha:** 12/10/2026  

---

## Índice de Módulos

1. [Módulo 1 — Autenticación y Seguridad](#módulo-1--autenticación-y-seguridad)
2. [Módulo 2 — Gestión de Inventario](#módulo-2--gestión-de-inventario)
3. [Módulo 3 — Registro de Ventas](#módulo-3--registro-de-ventas)
4. [Módulo 4 — Reportes y Análisis](#módulo-4--reportes-y-análisis)
5. [Módulo 5 — Catálogo Digital](#módulo-5--catálogo-digital)

---

## Módulo 1 — Autenticación y Seguridad

> Gestiona el acceso al sistema mediante credenciales, roles de usuario y mecanismos de protección ante accesos no autorizados.

---

### RF-01 — Solicitar nombre de usuario

**Descripción:** El sistema deberá solicitar el nombre de usuario como campo obligatorio para iniciar sesión.  
**Actor(es):** Administrador, Empleado  
**Prioridad:** Media

**Criterios de Aceptación:**
- El campo nombre de usuario es obligatorio y no permite estar vacío.
- El sistema no permite continuar con el inicio de sesión sin ingresar el usuario.

---

### RF-02 — Solicitar contraseña

**Descripción:** El sistema deberá solicitar una contraseña como campo obligatorio para iniciar sesión.  
**Actor(es):** Administrador, Empleado  
**Prioridad:** Media

**Criterios de Aceptación:**
- El campo contraseña es obligatorio.
- La contraseña se muestra enmascarada (caracteres ocultos) durante la escritura.

---

### RF-03 — Autenticar usuario

**Descripción:** El sistema deberá validar las credenciales ingresadas y conceder acceso solo al personal autorizado.  
**Actor(es):** Administrador, Empleado  
**Prioridad:** Media

**Criterios de Aceptación:**
- Si las credenciales son correctas, el sistema concede acceso y redirige al panel principal.
- Si las credenciales son incorrectas, el sistema deniega el acceso.
- El acceso está restringido exclusivamente al personal registrado.

---

### RF-04 — Usuarios propios por vendedor

**Descripción:** El sistema deberá permitir que cada vendedor cuente con un usuario propio para registrar todos sus movimientos de forma individual.  
**Actor(es):** Administrador  
**Prioridad:** Alta

**Criterios de Aceptación:**
- El administrador puede crear, editar y desactivar usuarios individuales.
- Cada acción registrada en el sistema queda asociada al usuario autenticado que la realizó.
- Los nombres de usuario son únicos e irrepetibles.

---

### RF-05 — Bloquear tras intentos fallidos

**Descripción:** El sistema deberá bloquear al usuario que ingrese credenciales incorrectas de forma consecutiva repetidas veces.  
**Actor(es):** Sistema  
**Prioridad:** Alta

**Criterios de Aceptación:**
- Tras N intentos fallidos consecutivos (N configurable por el administrador), la cuenta queda bloqueada temporalmente.
- El sistema muestra un mensaje claro indicando el bloqueo.
- Solo el administrador puede desbloquear manualmente la cuenta afectada.

---

### RF-06 — Mostrar señal de acceso exitoso

**Descripción:** El sistema deberá mostrar una confirmación visual al validar correctamente las credenciales del usuario.  
**Actor(es):** Administrador, Empleado  
**Prioridad:** Media

**Criterios de Aceptación:**
- Al iniciar sesión con éxito, se muestra un mensaje o indicador visual de bienvenida.
- El sistema redirige automáticamente al panel principal del rol correspondiente.

---

### RF-07 — Mostrar señal de error de acceso

**Descripción:** El sistema deberá mostrar un mensaje de error claro cuando las credenciales ingresadas no sean válidas.  
**Actor(es):** Administrador, Empleado  
**Prioridad:** Media

**Criterios de Aceptación:**
- El sistema muestra un mensaje de error sin revelar cuál campo es incorrecto.
- El usuario puede reintentar el ingreso de sus credenciales.

---

### RF-73 — Gestión y visualización de usuarios

**Descripción:** El sistema deberá permitir al Administrador visualizar la lista de todos los usuarios registrados y restablecer o modificar sus contraseñas. Los empleados no podrán modificar sus propias contraseñas ni las de otros usuarios.  
**Actor(es):** Administrador  
**Prioridad:** Alta

**Criterios de Aceptación:**
- El sistema muestra una tabla con los usuarios registrados (nombre de usuario, rol asignado, estado activo/inactivo y fecha de creación).
- Solo el Administrador tiene acceso a la vista y acciones de gestión de usuarios.
- El Administrador puede restablecer la contraseña de cualquier usuario ingresando una nueva clave válida.
- El sistema no permite que los usuarios con rol Empleado editen contraseñas ni accedan a la administración de cuentas.

---

## Módulo 2 — Gestión de Inventario

> Controla el registro, modificación, consulta y seguimiento de todos los productos en los dos locales del negocio.

---

### RF-08 — Registrar nuevo producto

**Descripción:** El sistema deberá permitir el registro de productos nuevos en el inventario del local correspondiente.  
**Actor(es):** Administrador  
**Prioridad:** Alta

**Criterios de Aceptación:**
- El formulario de registro incluye todos los campos obligatorios del producto.
- El producto queda disponible inmediatamente en el inventario del local seleccionado.
- No se permite duplicar el mismo producto en el mismo local.

---

### RF-09 — Registrar nombre del producto

**Descripción:** El sistema deberá permitir ingresar el nombre del producto al momento de registrarlo.  
**Actor(es):** Administrador  
**Prioridad:** Alta

**Criterios de Aceptación:**
- El campo nombre es obligatorio y no puede estar vacío.
- Acepta valores alfanuméricos.

---

### RF-10 — Registrar color del producto

**Descripción:** El sistema deberá permitir registrar el color del producto.  
**Actor(es):** Administrador  
**Prioridad:** Alta

**Criterios de Aceptación:**
- El campo color es obligatorio.
- Se puede seleccionar de una lista predefinida o ingresar un valor personalizado.

---

### RF-11 — Registrar talla del producto

**Descripción:** El sistema deberá permitir registrar la talla del producto.  
**Actor(es):** Administrador  
**Prioridad:** Alta

**Criterios de Aceptación:**
- El campo talla es obligatorio.
- Acepta valores estándar (XS, S, M, L, XL, XXL) o numéricos según el tipo de prenda.

---

### RF-12 — Registrar marca del producto

**Descripción:** El sistema deberá permitir registrar la marca del producto.  
**Actor(es):** Administrador  
**Prioridad:** Alta

**Criterios de Aceptación:**
- El campo marca es obligatorio.
- Se puede seleccionar de una lista de marcas existentes o registrar una nueva.

---

### RF-13 — Registrar precio de venta

**Descripción:** El sistema deberá permitir registrar el precio de venta del producto.  
**Actor(es):** Administrador  
**Prioridad:** Media

**Criterios de Aceptación:**
- El campo precio es obligatorio y acepta solo valores numéricos positivos.
- El precio queda visible en el inventario, punto de venta y catálogo digital.

---

### RF-14 — Registrar costo del producto

**Descripción:** El sistema deberá registrar el costo de adquisición de cada producto para calcular la utilidad bruta.  
**Actor(es):** Administrador  
**Prioridad:** Media

**Criterios de Aceptación:**
- El campo costo es obligatorio y acepta solo valores numéricos positivos.
- El costo solo es visible para el administrador, no para el empleado.

---

### RF-15 — Registrar cantidad del producto

**Descripción:** El sistema deberá permitir registrar la cantidad inicial disponible del producto al momento de su registro.  
**Actor(es):** Administrador  
**Prioridad:** Alta

**Criterios de Aceptación:**
- El campo cantidad es obligatorio y acepta solo números enteros positivos.
- La cantidad queda reflejada en el stock del local seleccionado.

---

### RF-16 — Registrar imagen del producto

**Descripción:** El sistema deberá permitir registrar imágenes de los productos para su reconocimiento y visualización.  
**Actor(es):** Administrador  
**Prioridad:** Baja

**Criterios de Aceptación:**
- Se puede cargar al menos una imagen por producto.
- La imagen se muestra en el inventario y en el catálogo digital.
- Formatos aceptados: JPG, PNG, WEBP.

---

### RF-17 — Mostrar cantidad en stock

**Descripción:** El sistema deberá mostrar la cantidad disponible de un producto al consultarlo, diferenciada por local.  
**Actor(es):** Administrador, Empleado  
**Prioridad:** Alta

**Criterios de Aceptación:**
- Al consultar un producto, se muestra el stock actual del local del usuario autenticado.
- El administrador puede ver el stock de ambos locales.

---

### RF-18 — Mostrar descripción completa del producto

**Descripción:** El sistema deberá mostrar el nombre, marca, color, talla y precio de cada producto consultado.  
**Actor(es):** Administrador, Empleado, Cliente  
**Prioridad:** Media

**Criterios de Aceptación:**
- Todos los atributos registrados se muestran en la ficha del producto.
- La información es legible y está visualmente organizada.

---

### RF-19 — Buscar productos

**Descripción:** El sistema deberá permitir buscar productos por nombre, marca, color, talla u otros atributos.  
**Actor(es):** Administrador, Empleado  
**Prioridad:** Media

**Criterios de Aceptación:**
- El buscador filtra resultados en tiempo real conforme se escribe.
- Los resultados muestran coincidencias por cualquier atributo del producto.

---

### RF-20 — Mostrar productos sustitutos

**Descripción:** El sistema deberá mostrar productos alternativos con características similares cuando no se encuentre coincidencia exacta.  
**Actor(es):** Administrador, Empleado  
**Prioridad:** Baja

**Criterios de Aceptación:**
- Al no hallar el producto buscado exactamente, el sistema sugiere productos con atributos similares.
- Las sugerencias son relevantes y claras para el usuario.

---

### RF-21 — Inventarios independientes por tienda

**Descripción:** El sistema deberá permitir que cada tienda maneje su propio inventario de forma independiente.  
**Actor(es):** Administrador  
**Prioridad:** Alta

**Criterios de Aceptación:**
- Cada local tiene su propio registro de stock separado.
- Un cambio en el inventario de un local no afecta automáticamente al otro.

---

### RF-22 — Control de inventario multitienda

**Descripción:** El sistema deberá llevar un control consolidado del inventario de los dos locales, visible para el administrador.  
**Actor(es):** Administrador  
**Prioridad:** Alta

**Criterios de Aceptación:**
- El administrador puede ver el stock de ambos locales en una sola vista centralizada.
- Los datos se actualizan en tiempo real.

---

### RF-23 — Transferir productos entre locales

**Descripción:** El sistema deberá rastrear y controlar el movimiento de productos enviados de una tienda a la otra.  
**Actor(es):** Administrador, Empleado  
**Prioridad:** Media

**Criterios de Aceptación:**
- El usuario puede iniciar una transferencia indicando el producto, cantidad y local destino.
- Al confirmar, el stock del local origen disminuye y el del local destino aumenta.
- La transferencia queda registrada con fecha, hora y usuario responsable.

---

### RF-24 — Disminuir stock automáticamente

**Descripción:** El sistema deberá reducir el stock de forma automática cuando se registre una venta o una transferencia.  
**Actor(es):** Sistema  
**Prioridad:** Alta

**Criterios de Aceptación:**
- Al confirmar una venta, el stock del producto disminuye en el local correspondiente.
- Al confirmar una transferencia, el stock del local de origen disminuye.
- El sistema no permite vender más unidades de las disponibles en stock.

---

### RF-25 — Añadir existencias al stock

**Descripción:** El sistema deberá permitir agregar unidades a un producto ya registrado sin crear un registro duplicado.  
**Actor(es):** Administrador  
**Prioridad:** Alta

**Criterios de Aceptación:**
- El usuario selecciona el producto existente e indica la cantidad a añadir.
- El stock total se actualiza sumando la cantidad indicada al valor actual.

---

### RF-26 — Ajuste de inventario

**Descripción:** El sistema deberá contar con una función para corregir manualmente el stock por errores o pérdidas.  
**Actor(es):** Administrador  
**Prioridad:** Media

**Criterios de Aceptación:**
- Solo el administrador puede realizar ajustes de inventario.
- El ajuste requiere indicar el motivo y queda registrado con fecha, hora y usuario.

---

### RF-27 — Indicador de nivel de stock

**Descripción:** El sistema deberá mostrar un indicador visual del nivel de stock por producto (bajo, normal, alto).  
**Actor(es):** Administrador, Empleado  
**Prioridad:** Baja

**Criterios de Aceptación:**
- Los productos con stock bajo o en cero se resaltan visualmente con colores o íconos.
- El umbral de stock bajo es configurable por el administrador.

---

### RF-28 — Agregar nuevos inventarios

**Descripción:** El sistema deberá permitir incorporar nuevos productos al inventario en cualquier momento posterior a la implementación.  
**Actor(es):** Administrador  
**Prioridad:** Media

**Criterios de Aceptación:**
- El sistema no impone límite al número de productos registrables.
- El registro de nuevos productos no afecta los registros existentes.

---

### RF-29 — Registrar movimientos de inventario

**Descripción:** El sistema deberá guardar automáticamente la fecha, hora y usuario responsable de cada movimiento de inventario.  
**Actor(es):** Sistema  
**Prioridad:** Media

**Criterios de Aceptación:**
- Todo movimiento (entrada, salida, ajuste, transferencia) queda registrado en el historial de trazabilidad.
- El historial es consultable por rango de fechas, tipo de movimiento y usuario.

---

### RF-30 — Calcular valor total del stock

**Descripción:** El sistema deberá calcular automáticamente el valor total del stock (costo de adquisición × cantidad disponible).  
**Actor(es):** Administrador  
**Prioridad:** Media

**Criterios de Aceptación:**
- El valor total se calcula multiplicando el costo unitario por la cantidad de cada producto.
- El resultado se muestra en el módulo de inventario y se actualiza con cada movimiento.

---

### RF-31 — Mostrar proyecciones de duración del stock

**Descripción:** El sistema deberá mostrar una proyección automática de cuántos días durará el stock según el promedio de ventas diarias.  
**Actor(es):** Administrador  
**Prioridad:** Baja

**Criterios de Aceptación:**
- El sistema calcula los días estimados de duración por producto basándose en el historial de ventas.
- La proyección se recalcula periódicamente.

---

### RF-32 — Modificar información de producto

**Descripción:** Solo el administrador podrá modificar precios, costos y atributos de los productos registrados.  
**Actor(es):** Administrador  
**Prioridad:** Media

**Criterios de Aceptación:**
- El empleado no tiene permisos para editar atributos de productos.
- Toda modificación queda registrada con fecha, hora y usuario que la realizó.

---

### RF-33 — Sincronizar inventario con catálogo digital

**Descripción:** El sistema deberá mantener el catálogo en línea sincronizado con el inventario físico para evitar sobreventa.  
**Actor(es):** Sistema  
**Prioridad:** Alta

**Criterios de Aceptación:**
- Cualquier cambio en el stock se refleja en el catálogo digital de forma automática.
- Si un producto se agota, el catálogo lo marca como no disponible de inmediato.

---

### RF-34 — Sincronizar con plataformas de venta online

**Descripción:** El sistema deberá sincronizar el inventario automáticamente con plataformas externas como Facebook Shop o Marketplace.  
**Actor(es):** Administrador  
**Prioridad:** Media

**Criterios de Aceptación:**
- El stock disponible se actualiza automáticamente en las plataformas externas conectadas.
- El administrador puede activar o desactivar la sincronización por plataforma individualmente.

---

### RF-35 — Exportar inventario

**Descripción:** El sistema deberá permitir exportar el inventario completo en formatos Excel y PDF.  
**Actor(es):** Administrador  
**Prioridad:** Media

**Criterios de Aceptación:**
- El usuario selecciona el formato de exportación (Excel o PDF).
- El archivo exportado incluye todos los campos del inventario con los datos vigentes.

---

### RF-74 — Gestión de catálogos maestros de productos

**Descripción:** El sistema deberá permitir al Administrador gestionar (crear, editar y activar/desactivar) los catálogos maestros de colores, tallas, marcas y categorías. Al registrar o editar un producto en inventario, los usuarios seleccionarán exclusivamente de estas listas predefinidas para evitar errores tipográficos o inconsistencias.  
**Actor(es):** Administrador  
**Prioridad:** Alta

**Criterios de Aceptación:**
- El Administrador gestiona listas independientes para categorías, marcas, colores y tallas con nombre único y estado activo/inactivo.
- En los formularios de registro y edición de productos, estos atributos se seleccionan de listas desplegables, impidiendo la escritura en texto libre.
- No se permite eliminar elementos que tengan productos asociados con stock vigente, permitiendo únicamente su desactivación lógica.

---

### RF-75 — Filtros y búsqueda avanzada en inventario

**Descripción:** El sistema deberá proporcionar herramientas de búsqueda y filtros combinables para que el personal consulte y localice productos en el inventario de manera rápida y precisa.  
**Actor(es):** Administrador, Empleado  
**Prioridad:** Media

**Criterios de Aceptación:**
- Permite buscar en tiempo real por nombre, código de barras o código SKU.
- Permite filtrar simultáneamente por local, categoría, marca, talla, color, rango de precios y estado de stock (disponible, bajo, agotado).
- Los resultados se actualizan dinámicamente y se incluye una opción para limpiar todos los filtros aplicados.

---

## Módulo 3 — Registro de Ventas

> Gestiona el proceso de registro de transacciones de venta, incluyendo los productos vendidos, los medios de pago y la sincronización de datos.

---

### RF-36 — Registrar venta

**Descripción:** El sistema deberá permitir registrar una venta indicando los productos, la fecha, la hora y el medio de pago utilizado.  
**Actor(es):** Administrador, Empleado  
**Prioridad:** Alta

**Criterios de Aceptación:**
- Se puede registrar una venta con uno o más productos.
- La venta queda asociada al usuario que la registró y al local correspondiente.
- El stock se reduce automáticamente al confirmar la venta.

---

### RF-37 — Registrar fecha y hora de venta

**Descripción:** El sistema deberá registrar automáticamente la fecha y hora exacta en que se confirma cada venta.  
**Actor(es):** Sistema  
**Prioridad:** Alta

**Criterios de Aceptación:**
- La fecha y hora se capturan automáticamente al confirmar la venta.
- El dato no puede ser modificado manualmente por el usuario.

---

### RF-38 — Identificar punto de venta

**Descripción:** El sistema deberá identificar y asociar automáticamente la sucursal donde se realizó cada venta.  
**Actor(es):** Sistema  
**Prioridad:** Alta

**Criterios de Aceptación:**
- Cada venta queda vinculada al local desde el cual se realizó el registro.
- El local se asigna automáticamente según la sesión activa del usuario autenticado.

---

### RF-39 — Registrar múltiples productos en una venta

**Descripción:** El sistema deberá permitir incluir varios productos en una sola venta, con detalle de cantidad, talla y color de cada ítem.  
**Actor(es):** Administrador, Empleado  
**Prioridad:** Media

**Criterios de Aceptación:**
- Se pueden agregar múltiples ítems a una venta antes de confirmarla.
- Cada ítem detalla: producto, cantidad, talla y color.
- El total de la venta se calcula automáticamente sumando todos los ítems.

---

### RF-40 — Registrar medios de pago

**Descripción:** El sistema deberá registrar el o los medios de pago utilizados en cada venta (efectivo, Yape, Plin, tarjeta, etc.).  
**Actor(es):** Administrador, Empleado  
**Prioridad:** Media

**Criterios de Aceptación:**
- El usuario selecciona el medio de pago al momento de confirmar la venta.
- Se permite registrar pago combinado con más de un medio.
- El medio de pago queda almacenado para consulta y reportes.

---

### RF-41 — Alertar por falta de sincronización

**Descripción:** El sistema deberá mostrar una alerta visible cuando existan ventas o movimientos pendientes de sincronizar con la nube.  
**Actor(es):** Sistema  
**Prioridad:** Media

**Criterios de Aceptación:**
- Cuando el sistema detecta datos locales no sincronizados, muestra una notificación activa y visible.
- La alerta desaparece automáticamente una vez completada la sincronización exitosa.

---

### RF-42 — Exportar registro de ventas

**Descripción:** El sistema deberá permitir exportar el historial de ventas en formatos Excel y PDF.  
**Actor(es):** Administrador  
**Prioridad:** Media

**Criterios de Aceptación:**
- El usuario puede filtrar las ventas a exportar por rango de fechas.
- El archivo exportado incluye todos los campos registrados de cada venta.

---

### RF-43 — Funcionar sin conexión a internet

**Descripción:** El sistema deberá operar de forma completamente local sin requerir conexión a internet para sus funcionalidades principales.  
**Actor(es):** Administrador, Empleado  
**Prioridad:** Alta

**Criterios de Aceptación:**
- El registro de ventas y gestión de inventario funcionan sin conexión activa.
- Los datos se almacenan localmente y quedan en cola para sincronizarse al recuperar la conexión.

---

### RF-44 — Sincronización en la nube

**Descripción:** El sistema deberá sincronizar ventas e inventario en la nube, retomando la sincronización automáticamente al restaurarse la conexión.  
**Actor(es):** Sistema  
**Prioridad:** Alta

**Criterios de Aceptación:**
- Los datos locales se sincronizan automáticamente con la nube al recuperar internet.
- El sistema muestra el estado actual de la sincronización.
- No se pierde ningún dato registrado durante el período sin conexión.

---

### RF-76 — Historial y consulta de ventas

**Descripción:** El sistema deberá permitir consultar el historial completo de ventas realizadas, permitiendo auditar todas las transacciones registradas con filtros detallados.  
**Actor(es):** Administrador, Empleado  
**Prioridad:** Alta

**Criterios de Aceptación:**
- Presenta el listado cronológico de ventas con número correlativo de ticket digital, fecha/hora, local, vendedor, medio de pago y total.
- Permite filtrar por rango de fechas, local comercial, vendedor y medio de pago.
- Permite consultar el desglose detallado de productos, cantidades y precios de cada venta registrada, junto con su ticket digital generado.

---

## Módulo 4 — Reportes y Análisis

> Permite generar, visualizar, filtrar, exportar y programar reportes de ventas para el análisis del rendimiento del negocio.

---

### RF-45 — Generar reporte de ventas

**Descripción:** El sistema deberá generar reportes de ventas para un periodo de tiempo indicado, con desglose de productos vendidos.  
**Actor(es):** Administrador  
**Prioridad:** Media

**Criterios de Aceptación:**
- El usuario selecciona el periodo y el sistema genera el reporte correspondiente.
- El reporte incluye el detalle de cada venta y los productos involucrados en el periodo.

---

### RF-46 — Filtrar reporte por rango de fechas

**Descripción:** El sistema deberá permitir filtrar reportes de ventas seleccionando una fecha de inicio y una fecha de fin personalizables.  
**Actor(es):** Administrador  
**Prioridad:** Alta

**Criterios de Aceptación:**
- El usuario selecciona fecha de inicio y fecha de fin para el filtro.
- El reporte muestra solo las ventas comprendidas dentro del rango seleccionado.

---

### RF-47 — Generar reporte por local

**Descripción:** El sistema deberá generar reportes de ventas diferenciados por sucursal.  
**Actor(es):** Administrador  
**Prioridad:** Media

**Criterios de Aceptación:**
- El usuario puede seleccionar uno o ambos locales al generar el reporte.
- El reporte presenta los datos segmentados por sucursal de forma clara.

---

### RF-48 — Comparar ventas entre locales

**Descripción:** El sistema deberá permitir comparar el rendimiento de ventas entre las dos sucursales en un mismo reporte.  
**Actor(es):** Administrador  
**Prioridad:** Media

**Criterios de Aceptación:**
- El reporte muestra métricas de ambos locales en paralelo para su comparación directa.
- Se incluyen gráficos comparativos entre sucursales.

---

### RF-49 — Mostrar total de ventas

**Descripción:** El sistema deberá mostrar el monto total de ventas acumulado en el periodo seleccionado por el usuario.  
**Actor(es):** Administrador  
**Prioridad:** Media

**Criterios de Aceptación:**
- El reporte muestra el monto total vendido para el rango de fechas indicado.
- El total se presenta de forma destacada en el reporte.

---

### RF-50 — Mostrar productos más vendidos

**Descripción:** El sistema deberá listar los artículos con mayor cantidad de unidades vendidas en un periodo determinado.  
**Actor(es):** Administrador  
**Prioridad:** Alta

**Criterios de Aceptación:**
- El reporte ordena los productos de mayor a menor por cantidad de unidades vendidas.
- Se puede filtrar por periodo y por local.

---

### RF-51 — Mostrar productos menos vendidos

**Descripción:** El sistema deberá identificar los artículos con menor rotación para apoyar decisiones comerciales.  
**Actor(es):** Administrador  
**Prioridad:** Alta

**Criterios de Aceptación:**
- El reporte lista los productos con menor cantidad de unidades vendidas en el periodo.
- Permite identificar artículos estancados o con bajo movimiento.

---

### RF-52 — Mostrar productos no vendidos

**Descripción:** El sistema deberá identificar los productos que no registraron ninguna venta en el periodo seleccionado.  
**Actor(es):** Administrador  
**Prioridad:** Media

**Criterios de Aceptación:**
- El reporte lista los productos con cero ventas en el rango de fechas indicado.
- Se indica el stock disponible actual de cada producto no vendido.

---

### RF-53 — Mostrar productos con mayor utilidad

**Descripción:** El sistema deberá identificar los productos que generan el mayor margen de ganancia en un periodo determinado.  
**Actor(es):** Administrador  
**Prioridad:** Alta

**Criterios de Aceptación:**
- El reporte lista productos ordenados por utilidad bruta generada (precio de venta menos costo).
- Se puede filtrar por periodo de tiempo.

---

### RF-54 — Mostrar utilidad bruta en reportes

**Descripción:** El sistema deberá incluir en los reportes la utilidad bruta por producto, usando el costo registrado en inventario.  
**Actor(es):** Administrador  
**Prioridad:** Media

**Criterios de Aceptación:**
- Cada producto en el reporte muestra: precio de venta, costo unitario, ganancia unitaria y ganancia total del periodo.

---

### RF-55 — Mostrar días con más ventas

**Descripción:** El sistema deberá identificar los días de la semana con mayor volumen de ventas.  
**Actor(es):** Administrador  
**Prioridad:** Alta

**Criterios de Aceptación:**
- El reporte identifica los días de mayor y menor facturación en el periodo seleccionado.
- Los resultados pueden visualizarse en un gráfico de barras por día de la semana.

---

### RF-56 — Filtrar reportes por categoría de producto

**Descripción:** El sistema deberá permitir filtrar reportes de ventas por categoría de producto (polos, pantalones, accesorios, etc.).  
**Actor(es):** Administrador  
**Prioridad:** Media

**Criterios de Aceptación:**
- El usuario puede seleccionar una o varias categorías para acotar el reporte.
- El reporte muestra solo los productos pertenecientes a las categorías elegidas.

---

### RF-57 — Filtrar reportes por atributos

**Descripción:** El sistema deberá permitir agrupar y filtrar las ventas por combinaciones de talla y color para identificar preferencias de los clientes.  
**Actor(es):** Administrador  
**Prioridad:** Media

**Criterios de Aceptación:**
- El reporte puede filtrarse por talla, color o la combinación de ambos atributos.
- Los resultados muestran qué combinaciones son más demandadas por los clientes.

---

### RF-58 — Filtrar reportes por método de pago

**Descripción:** El sistema deberá mostrar las ventas agrupadas y diferenciadas por método de pago utilizado.  
**Actor(es):** Administrador  
**Prioridad:** Media

**Criterios de Aceptación:**
- El reporte diferencia las ventas según el medio de pago (efectivo, tarjeta, Yape, Plin, etc.).
- Se muestra el total facturado y el porcentaje que representa cada método de pago.

---

### RF-59 — Filtrar reportes a preferencia del usuario

**Descripción:** El sistema deberá permitir al usuario aplicar múltiples filtros combinados de forma personalizada en los reportes.  
**Actor(es):** Administrador  
**Prioridad:** Baja

**Criterios de Aceptación:**
- El usuario puede combinar dos o más filtros disponibles al mismo tiempo al generar un reporte.

---

### RF-60 — Visualizar reportes en tablas y gráficos

**Descripción:** El sistema deberá mostrar los reportes tanto en formato tabular como en gráficos (barras, torta, líneas).  
**Actor(es):** Administrador  
**Prioridad:** Media

**Criterios de Aceptación:**
- El usuario puede alternar entre la vista de tabla y la vista de gráfico dentro del mismo reporte.
- Los gráficos son interactivos, legibles y se actualizan al aplicar filtros.

---

### RF-61 — Historial de reportes generados

**Descripción:** El sistema deberá guardar un historial de todos los reportes generados para su consulta futura sin reconfigurarlos.  
**Actor(es):** Administrador  
**Prioridad:** Media

**Criterios de Aceptación:**
- Los reportes generados se almacenan automáticamente y son accesibles desde un historial.
- El historial es consultable y filtrable por fecha y tipo de reporte.

---

### RF-62 — Alertar por bajas ventas

**Descripción:** El sistema deberá generar alertas cuando el total de ventas caiga por debajo de un umbral definido por el usuario.  
**Actor(es):** Administrador  
**Prioridad:** Baja

**Criterios de Aceptación:**
- El administrador configura el umbral mínimo de ventas esperadas para un periodo dado.
- El sistema notifica al administrador cuando las ventas están por debajo del umbral configurado.

---

### RF-63 — Exportar reportes en PDF y Excel

**Descripción:** El sistema deberá permitir exportar los reportes generados en formatos PDF y Excel.  
**Actor(es):** Administrador  
**Prioridad:** Media

**Criterios de Aceptación:**
- El usuario elige el formato de exportación (PDF o Excel).
- El archivo exportado reproduce fielmente el contenido y estructura del reporte en pantalla.

---

### RF-64 — Enviar reportes por correo electrónico

**Descripción:** El sistema deberá permitir enviar reportes al correo electrónico del usuario cuando este lo solicite.  
**Actor(es):** Administrador  
**Prioridad:** Media

**Criterios de Aceptación:**
- El usuario ingresa la dirección de correo destinataria y confirma el envío.
- El reporte se adjunta al correo en formato PDF o Excel según la preferencia.

---

### RF-65 — Agendar reportes periódicos

**Descripción:** El sistema deberá permitir configurar reportes automáticos con frecuencia periódica (semanal o mensual) enviados al correo.  
**Actor(es):** Administrador  
**Prioridad:** Baja

**Criterios de Aceptación:**
- El usuario define la frecuencia (semanal o mensual) y el correo de destino.
- El sistema genera y envía el reporte automáticamente en la fecha y hora configuradas.

---

### RF-66 — Configurar reportes personalizados

**Descripción:** El sistema deberá permitir al usuario guardar configuraciones de reportes con filtros elegidos para reutilizarlos.  
**Actor(es):** Administrador  
**Prioridad:** Baja

**Criterios de Aceptación:**
- El usuario puede guardar una configuración de reporte con sus filtros aplicados.
- Las configuraciones guardadas son editables y eliminables desde el módulo de reportes.

---

## Módulo 5 — Catálogo Digital

> Interfaz web pública que permite a los clientes visualizar los productos disponibles, sus características y la ubicación de las tiendas.

---

### RF-67 — Catálogo online de productos

**Descripción:** El sistema deberá implementar una página web pública donde los clientes puedan visualizar los productos disponibles en stock.  
**Actor(es):** Cliente  
**Prioridad:** Media

**Criterios de Aceptación:**
- La página es accesible desde cualquier navegador web sin necesidad de registro.
- Muestra únicamente productos con stock disponible.
- La información se mantiene actualizada con el inventario interno.

---

### RF-68 — Mostrar solo productos en stock

**Descripción:** El catálogo digital deberá mostrar únicamente los productos que cuentan con stock disponible en alguno de los locales.  
**Actor(es):** Cliente  
**Prioridad:** Media

**Criterios de Aceptación:**
- Los productos agotados no se muestran o se marcan claramente como no disponibles.
- El stock mostrado es consistente con el inventario interno del sistema.

---

### RF-69 — Organizar catálogo por categorías

**Descripción:** El catálogo digital deberá organizar los productos por categoría para facilitar la navegación del cliente.  
**Actor(es):** Cliente  
**Prioridad:** Alta

**Criterios de Aceptación:**
- El cliente puede navegar y filtrar por categorías (polos, pantalones, accesorios, etc.).
- Cada categoría muestra sus productos correspondientes de forma organizada.
- La navegación entre categorías es intuitiva y rápida.

---

### RF-70 — Mostrar características del producto en catálogo

**Descripción:** El catálogo deberá mostrar el nombre, marca, color, talla, precio e imagen de cada producto listado.  
**Actor(es):** Cliente  
**Prioridad:** Media

**Criterios de Aceptación:**
- Cada producto en el catálogo cuenta con ficha completa con todos sus atributos visibles.
- Las imágenes del producto se muestran de forma clara y en buena resolución.

---

### RF-71 — Mostrar ubicación de tiendas físicas

**Descripción:** El catálogo digital deberá mostrar la ubicación exacta de los locales del negocio mediante un mapa o referencia clara.  
**Actor(es):** Cliente  
**Prioridad:** Alta

**Criterios de Aceptación:**
- El cliente puede visualizar la ubicación de ambas tiendas directamente desde el catálogo.
- Se utiliza un mapa interactivo o una referencia de dirección clara y precisa.

---

### RF-72 — Acceso multiplataforma mediante aplicación web responsiva

**Descripción:** El sistema se implementará como una aplicación web centralizada y completamente responsiva, accesible desde cualquier navegador estándar en computadoras, laptops, tablets y smartphones, permitiendo a futuro su empaquetado o migración a aplicación de escritorio o app móvil nativa sin rehacer la lógica de negocio.  
**Actor(es):** Administrador, Empleado, Cliente  
**Prioridad:** Alta

**Criterios de Aceptación:**
- El sistema opera de manera íntegra desde navegadores modernos sin requerir instalación previa de software en el cliente.
- La interfaz adapta automáticamente su disposición de elementos, botones y formularios táctiles o de puntero al tamaño de pantalla del dispositivo.
- La arquitectura desacoplada (Frontend / API Backend) permite reutilizar los servicios si a futuro se empaqueta como app de escritorio o móvil.

---

### RF-77 — Búsqueda y filtros para clientes en el catálogo digital

**Descripción:** El catálogo digital deberá permitir a los clientes buscar y filtrar prendas mediante múltiples criterios combinados, facilitando encontrar productos y consultar la disponibilidad en cada una de las dos tiendas físicas.  
**Actor(es):** Cliente  
**Prioridad:** Alta

**Criterios de Aceptación:**
- El cliente puede buscar prendas por texto predictivo y filtrar por categoría, color, talla y tienda física.
- El catálogo muestra con claridad la disponibilidad de stock por local para el producto seleccionado.
- Las prendas o combinaciones sin stock disponible muestran la etiqueta visual de "Agotado" sin interrumpir la navegación.

---