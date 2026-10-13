# Especificación de Casos de Uso

**Proyecto:** Sistema de Gestión — Tienda de Ropa para Varón  
**Versión:** 2.0  
**Fecha:** 13/10/2026  
**Módulos cubiertos:** 5 Módulos del Sistema (CU-01 a CU-15)  

---

## 📋 1. Índice General de Casos de Uso por Módulo

| ID | Nombre del Caso de Uso | Actor(es) | Requisitos Vinculados | Necesidad |
|---|---|---|---|---|
| **CU-01** | Iniciar Sesión y Validar Credenciales | Administrador, Vendedor | RF-01, RF-02, RF-03, RF-04, RF-05, RF-06 | N-01 |
| **CU-02** | Gestionar Usuarios del Sistema | Administrador | RF-07, RF-08, RF-10, RF-11, RF-12, RF-13, RF-14, RF-73 | N-01, N-02 |
| **CU-03** | Cerrar Sesión de Usuario | Administrador, Vendedor | RF-09 | N-01 |
| **CU-04** | Consultar Inventario de Prendas y Stock | Administrador, Vendedor | RF-18, RF-22, RF-35, RF-36, RF-37, RF-38, RF-39, RF-75 | N-04, N-05 |
| **CU-05** | Administrar Prendas de Vestir | Administrador | RF-15, RF-16, RF-17, RF-19 | N-04 |
| **CU-06** | Ajustar Existencias y Umbrales de Stock | Administrador | RF-20, RF-23, RF-24, RF-25, RF-77 | N-04 |
| **CU-07** | Gestionar Catálogos Maestros de Prendas | Administrador | RF-26 a RF-34, RF-74 | N-03 |
| **CU-08** | Registrar Venta en Mostrador (POS) | Administrador, Vendedor | RF-21, RF-40, RF-41, RF-42, RF-43, RF-44, RF-45, RF-46, RF-47 | N-06 |
| **CU-09** | Emitir y Enviar Ticket Digital de Venta | Administrador, Vendedor | RF-48, RF-49, RF-50, RF-76 | N-07 |
| **CU-10** | Operar Ventas en Modo Offline y Sincronizar | Vendedor | RF-54, RF-55 | N-08 |
| **CU-11** | Consultar Historial y Detalle de Ventas | Administrador, Vendedor | RF-51, RF-52, RF-76 | N-07 |
| **CU-12** | Anular Venta Registrada | Administrador | RF-53, RF-20 | N-07 |
| **CU-13** | Generar y Filtrar Reportes Analíticos de Ventas | Administrador | RF-56, RF-57, RF-58, RF-61, RF-62, RF-65, RF-66 | N-09 |
| **CU-14** | Consultar Ranking de Prendas y Exportar Métricas | Administrador | RF-59, RF-60, RF-63, RF-64 | N-09 |
| **CU-15** | Explorar Catálogo Digital Web y Disponibilidad | Cliente (Público) | RF-67, RF-68, RF-69, RF-70, RF-71, RF-72 | N-10 |

---

## 🔐 MÓDULO 1: AUTENTICACIÓN Y SEGURIDAD

---

### CU-01 — Iniciar Sesión y Validar Credenciales

* **Id Caso de Uso:** CU-01
* **Id Requerimientos (Trazabilidad):** RF-01, RF-02, RF-03, RF-04, RF-05, RF-06
* **Necesidad Vinculada:** N-01
* **Actor Principal:** Administrador, Vendedor
* **Objetivo:** Autenticar la identidad del usuario en el sistema mediante nombre de usuario y contraseña, garantizando acceso seguro y asignación del entorno de trabajo según su rol.

#### Precondiciones:
1. El usuario debe encontrarse previamente registrado en la base de datos con estado "Activo".
2. La cuenta no debe encontrarse en estado bloqueada.
3. El usuario debe acceder a la interfaz web de inicio de sesión.

#### Flujo Principal:
1. El usuario visualiza el formulario de acceso solicitando nombre de usuario y contraseña.
2. El usuario ingresa su nombre de usuario y contraseña enmascarada.
3. El usuario hace clic en el botón "Iniciar Sesión".
4. El sistema valida que ninguno de los campos se encuentre vacío.
5. El sistema consulta las credenciales en la base de datos comparando el hash de la contraseña (bcrypt).
6. El sistema verifica que la cuenta esté activa y sin bloqueos por intentos fallidos.
7. El sistema reinicia el contador de intentos fallidos a cero.
8. El sistema genera el token de sesión segura (JWT) e identifica el rol asignado (Administrador o Vendedor).
9. El sistema redirige al usuario al panel principal correspondiente a sus privilegios de rol.
10. El sistema registra el acceso en la bitácora de auditoría (usuario, fecha, hora, dirección IP).

#### Flujos Alternativos:
* **A1. Campos obligatorios vacíos:**
  * 4.a. El sistema detecta que el campo de usuario o contraseña está vacío.
  * 4.b. El sistema resalta los campos faltantes con el mensaje: *"Por favor complete todos los campos obligatorios"*.
  * 4.c. El flujo regresa al paso 2.
* **A2. Credenciales incorrectas:**
  * 5.a. El sistema no encuentra coincidencia para el usuario o la contraseña ingresada.
  * 5.b. El sistema incrementa en 1 el contador de intentos fallidos para el usuario.
  * 5.c. El sistema muestra el mensaje de error: *"Usuario o contraseña incorrectos"*.
  * 5.d. Si el contador de intentos es menor a 3, el flujo regresa al paso 2.
* **A3. Bloqueo de cuenta por superación de intentos fallidos:**
  * 5.e. El sistema detecta que el contador de intentos fallidos alcanzó el límite de 3 intentos consecutivos.
  * 5.f. El sistema cambia automáticamente el estado de la cuenta a "Bloqueada".
  * 5.g. El sistema muestra el mensaje: *"Su cuenta ha sido bloqueada preventivamente por reiterados intentos fallidos. Contacte al Administrador para su desbloqueo"*.
  * 5.h. El sistema registra el evento de seguridad en el log de auditoría y finaliza el caso de uso.
* **A4. Cuenta desactivada por el Administrador:**
  * 6.a. El sistema detecta que la cuenta del usuario tiene estado "Inactiva".
  * 6.b. El sistema muestra el mensaje: *"Acceso denegado: Su cuenta se encuentra desactivada"*.
  * 6.c. El flujo finaliza sin conceder acceso.

#### Postcondición:
* El usuario cuenta con una sesión autenticada con token activo y los permisos de su rol cargados; el evento queda guardado en la tabla de auditoría.

---

### CU-02 — Gestionar Usuarios del Sistema

* **Id Caso de Uso:** CU-02
* **Id Requerimientos (Trazabilidad):** RF-07, RF-08, RF-10, RF-11, RF-12, RF-13, RF-14, RF-73
* **Necesidad Vinculada:** N-01, N-02
* **Actor Principal:** Administrador
* **Objetivo:** Permitir al Administrador registrar nuevos usuarios, listar colaboradores, modificar sus datos, desactivar cuentas, desbloquear accesos y restablecer contraseñas de forma centralizada.

#### Precondiciones:
1. El Administrador debe haber iniciado sesión exitosamente con credenciales y privilegios de rol Administrador.

#### Flujo Principal:
1. El Administrador accede a la sección "Gestión de Usuarios".
2. El sistema consulta la base de datos y despliega la tabla de usuarios registrados con sus datos (nombre, usuario, rol, local asignado, estado y fecha de creación).
3. El Administrador selecciona una de las acciones disponibles:
   * **Crear Usuario:** Selecciona "Nuevo Usuario", completa datos obligatorios, asigna rol (Vendedor/Admin), asigna local físico y define contraseña inicial.
   * **Modificar Usuario:** Selecciona un usuario existente, edita sus datos y confirma cambios.
   * **Restablecer Contraseña:** Selecciona "Resetear Contraseña", introduce la nueva contraseña temporal y confirma la operación.
   * **Desactivar / Activar Usuario:** Cambia el estado del usuario para suspender o rehabilitar su acceso.
   * **Desbloquear Cuenta:** Selecciona una cuenta con estado "Bloqueada" y reinicia el contador de intentos fallidos a cero.
4. El sistema valida los datos ingresados y aplica las reglas de negocio (unicidad del nombre de usuario, complejidad de contraseña).
5. El sistema persiste los cambios en la base de datos.
6. El sistema muestra un mensaje de confirmación: *"Operación realizada con éxito"*.
7. El sistema actualiza la lista visual de usuarios y registra la acción en el log de auditoría.

#### Flujos Alternativos:
* **A1. Nombre de usuario duplicado:**
  * 4.a. Al crear o modificar, el sistema detecta que el nombre de usuario ya pertenece a otra cuenta.
  * 4.b. El sistema muestra el mensaje: *"El nombre de usuario ingresado ya está registrado. Elija uno diferente"*.
  * 4.c. El Administrador corrige el nombre y el flujo retoma el paso 4.
* **A2. Intento de auto-desactivación del único Administrador:**
  * 4.d. El sistema detecta que el Administrador intenta desactivar su propia cuenta o la única cuenta de Administrador activa.
  * 4.e. El sistema rechaza la operación con el mensaje: *"No es posible desactivar la única cuenta de Administrador activa del sistema"*.

#### Postcondición:
* La cuenta del usuario queda creada, actualizada, desbloqueada o con nueva contraseña en la base de datos y el cambio tiene efecto inmediato.

---

### CU-03 — Cerrar Sesión de Usuario

* **Id Caso de Uso:** CU-03
* **Id Requerimientos (Trazabilidad):** RF-09
* **Necesidad Vinculada:** N-01
* **Actor Principal:** Administrador, Vendedor
* **Objetivo:** Finalizar de manera controlada y segura la sesión de trabajo activa del usuario, invalidando los tokens de acceso para prevenir accesos no autorizados en el equipo.

#### Precondiciones:
1. El usuario debe encontrarse con sesión activa en el sistema.

#### Flujo Principal:
1. El usuario hace clic en la opción "Cerrar Sesión" en la barra superior del sistema.
2. El sistema solicita confirmación mediante un diálogo emergente: *"¿Está seguro de que desea cerrar la sesión actual?"*.
3. El usuario confirma la acción.
4. El sistema invalida el token JWT activo tanto en el cliente como en el servidor.
5. El sistema purga la memoria de sesión del navegador (localStorage/sessionStorage).
6. El sistema redirige automáticamente a la pantalla pública de inicio de sesión.
7. El sistema registra el cierre de sesión en la bitácora de auditoría.

#### Flujos Alternativos:
* **A1. El usuario cancela la salida:**
  * 3.a. El usuario presiona "Cancelar" en el diálogo emergente.
  * 3.b. El sistema cierra el diálogo y mantiene al usuario en su pantalla de trabajo habitual.

#### Postcondición:
* La sesión queda destruida; cualquier intento posterior de navegación hacia rutas protegidas requerirá un nuevo inicio de sesión.

---

## 📦 MÓDULO 2: GESTIÓN DE INVENTARIO

---

### CU-04 — Consultar Inventario de Prendas y Stock

* **Id Caso de Uso:** CU-04
* **Id Requerimientos (Trazabilidad):** RF-18, RF-22, RF-35, RF-36, RF-37, RF-38, RF-39, RF-75
* **Necesidad Vinculada:** N-04, N-05
* **Actor Principal:** Administrador, Vendedor
* **Objetivo:** Consultar la disponibilidad de prendas masculinas en tiempo real, discriminando existencias por cada uno de los dos locales comerciales y aplicando filtros dinámicos combinados.

#### Precondiciones:
1. El usuario debe estar autenticado en el sistema con rol Vendedor o Administrador.

#### Flujo Principal:
1. El usuario ingresa a la sección "Inventario".
2. El sistema recupera y muestra el catálogo completo de prendas en una tabla paginada, incluyendo código SKU, nombre, categoría, marca, precio de venta y stock por local (Local 1 y Local 2).
3. El usuario ingresa términos de búsqueda en la barra predictiva (código SKU o nombre de la prenda) o selecciona filtros en los controles desplegables:
   * Categoría (pantalones, camisas, polos, casacas, trajes).
   * Talla (S, M, L, XL, 30, 32, etc.).
   * Color.
   * Marca.
   * Local comercial (Local 1, Local 2, o consolidado).
   * Rango de precios.
4. Conforme el usuario interactúa, el sistema procesa los filtros de forma combinada y actualiza dinámicamente los resultados en pantalla en un tiempo menor a 2 segundos.
5. Si alguna prenda tiene stock igual o inferior al umbral mínimo, el sistema resalta la fila con una etiqueta visual de color naranja/rojo ("Stock Bajo").
6. El usuario visualiza la ficha resumida de stock y disponibilidad del producto deseado.

#### Flujos Alternativos:
* **A1. Búsqueda sin coincidencias:**
  * 4.a. El sistema comprueba que ningún producto satisface los filtros ingresados.
  * 4.b. El sistema muestra el mensaje: *"No se encontraron prendas que coincidan con los criterios de búsqueda"*, ofreciendo un botón para "Limpiar Filtros".
  * 4.c. El usuario limpia los filtros y el sistema vuelve a listar el catálogo general.

#### Postcondición:
* El usuario obtiene la información exacta y actualizada del stock de prendas por local comercial.

---

### CU-05 — Administrar Prendas de Vestir

* **Id Caso de Uso:** CU-05
* **Id Requerimientos (Trazabilidad):** RF-15, RF-16, RF-17, RF-19
* **Necesidad Vinculada:** N-04
* **Actor Principal:** Administrador
* **Objetivo:** Registrar nuevas prendas en el inventario con sus atributos normalizados e imágenes, modificar sus características o eliminarlas según las reglas de negocio.

#### Precondiciones:
1. El Administrador debe estar autenticado con permisos de Administrador.
2. Deben existir registros previos en los catálogos maestros (categorías, marcas, tallas y colores).

#### Flujo Principal (Registro de Nueva Prenda):
1. El Administrador accede a "Gestión de Inventario" y selecciona "Registrar Prenda".
2. El sistema muestra el formulario con los campos: Código SKU, Nombre de la prenda, Descripción, Precio de compra, Precio de venta, Categoría (selector), Marca (selector), Talla (selector), Color (selector), Imagen y Stock inicial para Local 1 y Local 2.
3. El Administrador diligencia los campos seleccionando los valores desde las listas maestras y carga la imagen del producto.
4. El Administrador presiona "Guardar Prenda".
5. El sistema valida los datos:
   * SKU único en el sistema.
   * Precios numéricos mayores a cero, verificando que Precio de Venta > Precio de Compra.
   * Asignación obligatoria de categorías y atributos desde listas desplegables cerradas.
   * Formato de imagen válido (JPG, PNG o WEBP con tamaño máximo de 2 MB).
6. El sistema almacena la prenda en la base de datos y crea los registros de inventario inicial para cada local físico.
7. El sistema confirma: *"Prenda registrada exitosamente en el inventario"*.
8. La nueva prenda se lista inmediatamente en el módulo de inventario y queda disponible para el catálogo web y ventas.

#### Flujos Alternativos:
* **A1. Modificación de Prenda existente:**
  * 1.a. El Administrador selecciona una prenda de la lista y presiona "Editar".
  * 1.b. El sistema carga los datos en el formulario.
  * 1.c. El Administrador edita los atributos deseados (nombre, precios, descripción, imagen) y guarda.
  * 1.d. El sistema valida y persiste las modificaciones.
* **A2. Eliminación de Prenda:**
  * 1.e. El Administrador selecciona "Eliminar Prenda".
  * 1.f. El sistema verifica si la prenda tiene historial de ventas asociadas.
  * 1.g. Si tiene ventas históricas: El sistema impide el borrado físico para preservar la integridad transaccional y aplica un *borrado lógico* (desactiva la prenda para ventas futuras).
  * 1.h. Si no tiene ventas históricas: El sistema solicita confirmación y elimina el registro físicamente.
* **A3. Código SKU duplicado:**
  * 5.a. El sistema detecta que el SKU ingresado ya pertenece a otra prenda.
  * 5.b. El sistema muestra el error: *"El código SKU ya existe en el sistema. Ingrese un código único"*.

#### Postcondición:
* La prenda queda registrada o actualizada en la base de datos con su inventario por local listo para transacciones.

---

### CU-06 — Ajustar Existencias y Umbrales de Stock

* **Id Caso de Uso:** CU-06
* **Id Requerimientos (Trazabilidad):** RF-20, RF-23, RF-24, RF-25, RF-77
* **Necesidad Vinculada:** N-04
* **Actor Principal:** Administrador
* **Objetivo:** Realizar ingresos de mercadería, transferencias entre sucursales o ajustes por merma/inventario físico, y fijar el umbral mínimo de alerta para reposición de existencias.

#### Precondiciones:
1. El Administrador debe estar autenticado en el sistema.
2. La prenda a ajustar debe estar registrada previamente.

#### Flujo Principal:
1. El Administrador selecciona una prenda en el módulo de inventario y pulsa "Ajustar Stock".
2. El sistema despliega el modal de ajuste indicando el stock actual por local (Local 1 y Local 2).
3. El Administrador selecciona el tipo de movimiento:
   * **Ingreso por Compra / Reabastecimiento.**
   * **Transferencia entre Locales (origen y destino).**
   * **Ajuste por Diferencia de Inventario / Merma.**
4. El Administrador selecciona el local afectado, la cantidad de unidades y escribe el motivo obligatorio del ajuste.
5. El Administrador define o actualiza el "Umbral de Stock Mínimo" para esa prenda en ese local.
6. El Administrador hace clic en "Confirmar Ajuste".
7. El sistema valida que la cantidad a restar o transferir no supere las existencias físicas actuales en el local de origen.
8. El sistema actualiza el stock en la tabla de inventario del local correspondiente.
9. El sistema registra el movimiento en el historial de Kardex/Auditoría (prenda, local, tipo movimiento, cantidad, usuario, fecha y motivo).
10. Si el nuevo stock queda por debajo del umbral mínimo, el sistema activa la alerta visual y la notificación para el Administrador.
11. El sistema muestra el mensaje: *"Stock actualizado correctamente"*.

#### Flujos Alternativos:
* **A1. Intento de ajuste negativo mayor al stock disponible:**
  * 7.a. La cantidad que se intenta transferir o restar supera el stock actual del local.
  * 7.b. El sistema cancela el ajuste con el mensaje: *"No es posible deducir la cantidad indicada. El stock actual en el local seleccionado es de [N] unidades"*.
  * 7.c. El flujo regresa al paso 4 para corregir la cantidad.

#### Postcondición:
* Las existencias del local quedan actualizadas y el movimiento queda asentado en la bitácora histórica de inventario.

---

### CU-07 — Gestionar Catálogos Maestros de Prendas

* **Id Caso de Uso:** CU-07
* **Id Requerimientos (Trazabilidad):** RF-26 a RF-34, RF-74
* **Necesidad Vinculada:** N-03
* **Actor Principal:** Administrador
* **Objetivo:** Mantener controlados y normalizados los catálogos de categorías, tallas, colores y marcas, impidiendo el uso de texto libre para garantizar la coherencia en reportes y búsquedas.

#### Precondiciones:
1. El usuario debe estar autenticado con rol Administrador.

#### Flujo Principal:
1. El Administrador ingresa al menú "Configuración" y selecciona "Catálogos Maestros".
2. El sistema presenta pestañas independientes para:
   * **Categorías:** (ej. Pantalones, Camisas, Polos, Casacas, Bermudas).
   * **Tallas:** (ej. XS, S, M, L, XL, XXL, 28, 30, 32, 34).
   * **Colores:** (ej. Negro, Azul Marino, Blanco, Beige, Gris, Verde Militar).
   * **Marcas:** (ej. Dockers, Levi's, Boston, Zara Man, etc.).
3. El Administrador selecciona la pestaña deseada y pulsa "Nuevo Registro".
4. El Administrador ingresa el nombre del nuevo atributo y su descripción o código de color hexadecimal si aplica.
5. El sistema valida que el nombre no se encuentre repetido en ese catálogo maestro.
6. El sistema guarda el nuevo valor en la base de datos.
7. El sistema emite confirmación y actualiza inmediatamente las listas desplegables de todo el sistema.

#### Flujos Alternativos:
* **A1. Eliminación de un valor en uso:**
  * 3.a. El Administrador intenta eliminar una talla, marca o categoría.
  * 3.b. El sistema verifica si existen prendas asociadas a dicho valor.
  * 3.c. Si existen prendas vinculadas: El sistema rechaza la eliminación con el mensaje: *"No se puede eliminar este registro porque está asociado a [N] prendas en el inventario. Desactive el elemento si desea ocultarlo"*.
  * 3.d. Si no tiene prendas vinculadas: El sistema solicita confirmación y elimina el registro.

#### Postcondición:
* Los catálogos maestros quedan actualizados y listos para alimentar los formularios de inventario.

---

## 💳 MÓDULO 3: REGISTRO DE VENTAS

---

### CU-08 — Registrar Venta en Mostrador (POS)

* **Id Caso de Uso:** CU-08
* **Id Requerimientos (Trazabilidad):** RF-21, RF-40, RF-41, RF-42, RF-43, RF-44, RF-45, RF-46, RF-47
* **Necesidad Vinculada:** N-06
* **Actor Principal:** Vendedor, Administrador
* **Objetivo:** Registrar una transacción de venta en el mostrador comercial agregando prendas al carrito, calculando totales, seleccionando el medio de pago, deduciendo stock y concretando la operación en menos de 2 segundos.

#### Precondiciones:
1. El usuario debe estar autenticado con rol Vendedor o Administrador.
2. El usuario debe tener asignado el local comercial donde se efectúa la venta.
3. Debe existir stock disponible de las prendas a comercializar en dicho local.

#### Flujo Principal:
1. El Vendedor accede a la interfaz de "Punto de Venta (POS)".
2. El sistema inicializa una nueva orden de venta vacía, identificando automáticamente la fecha, hora, local y vendedor responsable.
3. El Vendedor busca y agrega prendas al carrito mediante lectura de código SKU o búsqueda por nombre.
4. El sistema valida la disponibilidad de stock en el local para cada prenda solicitada.
5. El sistema agrega el artículo a la lista de venta y actualiza en tiempo real el desglose:
   * Subtotal.
   * Descuentos (si aplica porcentaje promocional autorizado).
   * Importe Total a pagar.
6. El Vendedor selecciona el medio de pago elegido por el cliente:
   * **Efectivo:** Ingresa el monto recibido en soles; el sistema calcula y exhibe el cambio/vuelto automáticamente.
   * **Tarjeta de Débito / Crédito:** Registra los 4 últimos dígitos de la tarjeta y código de operación del POS físico.
   * **Billetera Digital (Yape / Plin):** Registra el número telefónico o código de operación.
7. El Vendedor presiona el botón "Confirmar y Finalizar Venta".
8. El sistema ejecuta una transacción atómica en la base de datos:
   * Guarda el encabezado de la venta (código único de ticket, fecha, hora, total, vendedor, local, medio de pago).
   * Guarda las líneas de detalle de la venta (prenda, talla, color, precio unitario, cantidad, subtotal).
   * Descuenta automáticamente las unidades vendidas del stock del local correspondiente.
9. El sistema invoca automáticamente la generación del ticket digital de venta (**CU-09**).
10. El sistema limpia la pantalla del POS y queda listo para la siguiente transacción.

#### Flujos Alternativos:
* **A1. Stock insuficiente en el local:**
  * 4.a. Al intentar agregar una prenda, el sistema detecta que la cantidad requerida supera el stock disponible en ese local.
  * 4.b. El sistema bloquea el agregado del ítem y emite el mensaje: *"Stock insuficiente en este local. Disponible: [N] unidades"*.
  * 4.c. El sistema informa si existe stock disponible de esa prenda en el otro local comercial para consulta del cliente.
* **A2. Modificación de ítems en el carrito:**
  * 5.a. El Vendedor puede alterar las cantidades o remover prendas del carrito antes de confirmar el pago.
  * 5.b. El sistema recalcula inmediatamente los importes totales.
* **A3. Pago en efectivo insuficiente:**
  * 6.a. El importe recibido ingresado por el Vendedor es menor al total de la venta.
  * 6.b. El sistema no permite habilitar el botón de confirmación y muestra en rojo la diferencia pendiente de cobro.

#### Postcondición:
* La venta queda registrada en estado "Completada", el inventario del local se actualiza en tiempo real y se emite el ticket digital.

---

### CU-09 — Emitir y Enviar Ticket Digital de Venta

* **Id Caso de Uso:** CU-09
* **Id Requerimientos (Trazabilidad):** RF-48, RF-49, RF-50, RF-76
* **Necesidad Vinculada:** N-07
* **Actor Principal:** Vendedor, Administrador
* **Objetivo:** Generar de manera automática el ticket digital interno de venta con número de serie único y permitir su impresión térmica, descarga en PDF o envío digital al cliente (WhatsApp o correo).

#### Precondiciones:
1. Una venta debe haber sido registrada exitosamente (**CU-08**).

#### Flujo Principal:
1. El sistema genera automáticamente el ticket digital de venta estructurado con los siguientes datos:
   * Razón comercial y nombre de la tienda ("Tienda de Ropa para Varón").
   * Identificación del local comercial y dirección física.
   * Número correlativo único de ticket digital (ej. `TICK-L1-0004521`).
   * Fecha y hora exacta de emisión.
   * Nombre del vendedor que atendió.
   * Detalle de prendas vendidas (descripción, talla, color, cantidad, precio unitario e importe).
   * Medio de pago utilizado y vuelto entregado si fue en efectivo.
   * Total de la transacción expresado en moneda nacional (PEN).
   * Nota legal interna: *"Comprobante de control interno sin validez tributaria ante SUNAT"*.
2. El sistema muestra la vista previa del ticket en pantalla con las opciones de salida:
   * **Imprimir:** Envía la orden directa a impresora térmica de 80mm o estándar.
   * **Descargar PDF:** Genera y descarga el archivo digital en el dispositivo local.
   * **Enviar por WhatsApp / Correo:** Permite ingresar el número celular o email del cliente para despachar el enlace o archivo del ticket.
3. El Vendedor selecciona la opción solicitada por el comprador.
4. El sistema ejecuta la acción correspondiente y almacena el ticket digital asociado a la venta en el repositorio digital del sistema.

#### Flujos Alternativos:
* **A1. Cliente no requiere comprobante impreso ni envío:**
  * 3.a. El Vendedor presiona "Finalizar sin imprimir".
  * 3.b. El sistema cierra la vista previa; el ticket queda siempre disponible en el historial de ventas para consultas futuras.

#### Postcondición:
* El ticket digital queda archivado de manera inmutable y entregado al cliente en el formato solicitado.

---

### CU-10 — Operar Ventas en Modo Offline y Sincronizar

* **Id Caso de Uso:** CU-10
* **Id Requerimientos (Trazabilidad):** RF-54, RF-55
* **Necesidad Vinculada:** N-08
* **Actor Principal:** Vendedor
* **Objetivo:** Permitir que el mostrador continúe emitiendo ventas y tickets digitales aun cuando se interrumpa la conexión a Internet, almacenando las operaciones localmente y sincronizándolas al restablecer el enlace.

#### Precondiciones:
1. El terminal de ventas debe haber cargado previamente en caché local el catálogo de prendas y stock del día.
2. La conexión a Internet hacia el servidor central sufre una interrupción.

#### Flujo Principal:
1. El Vendedor inicia una venta y el sistema detecta automáticamente la pérdida de conectividad web.
2. El sistema conmuta a **"Modo Fuera de Línea (Offline)"** y muestra una insignia visual amarilla de advertencia: *"Trabajando sin conexión — Las ventas se sincronizarán automáticamente"*.
3. El Vendedor agrega prendas y procesa el cobro con normalidad utilizando la base de datos local del navegador (IndexedDB).
4. El sistema genera el ticket de venta con un correlativo temporal offline y descuenta el stock de forma local provisional.
5. El sistema encola la transacción en la lista de espera de sincronización local.
6. Al restablecerse la conectividad a Internet, el servicio de sincronización en segundo plano detecta la red activa.
7. El sistema transmite por lotes las ventas encoladas hacia la base de datos central en la nube.
8. El servidor central valida los registros, asigna los correlativos definitivos, consolida el stock general y responde confirmando la sincronización exitosa.
9. El sistema actualiza el estado de la insignia a verde: *"Sistema conectado — Todas las ventas sincronizadas"*.

#### Flujos Alternativos:
* **A1. Conflicto de stock al sincronizar en la nube:**
  * 8.a. Si durante el periodo offline una prenda fue vendida simultáneamente por otro canal agotando el stock real, el servidor central registra la venta pero genera una alerta de discrepancia de inventario para resolución inmediata del Administrador.

#### Postcondición:
* Las transacciones efectuadas fuera de línea quedan formalmente incorporadas a la base de datos central sin pérdida de información de ventas.

---

### CU-11 — Consultar Historial y Detalle de Ventas

* **Id Caso de Uso:** CU-11
* **Id Requerimientos (Trazabilidad):** RF-51, RF-52, RF-76
* **Necesidad Vinculada:** N-07
* **Actor Principal:** Administrador, Vendedor
* **Objetivo:** Visualizar y auditar el listado de todas las transacciones de venta registradas, permitiendo abrir el detalle completo y reimprimir o reenviar el ticket digital.

#### Precondiciones:
1. El usuario debe estar autenticado en el sistema.

#### Flujo Principal:
1. El usuario ingresa a "Historial de Ventas".
2. El sistema despliega las ventas ordenadas cronológicamente de la más reciente a la más antigua, mostrando: N° Ticket, Fecha/Hora, Local, Vendedor, Medio de Pago, Monto Total y Estado (Completada, Anulada).
   * *Si el usuario es Vendedor:* Solo visualiza las ventas efectuadas en su local asignado durante su turno.
   * *Si el usuario es Administrador:* Visualiza las ventas globales de ambos locales comerciales.
3. El usuario aplica filtros según sus necesidades:
   * Rango de fechas (desde / hasta).
   * Local comercial.
   * Vendedor responsable.
   * Medio de pago.
   * Estado de la venta.
4. El sistema actualiza la lista con los registros filtrados.
5. El usuario hace clic sobre una venta para ver su "Detalle de Transacción".
6. El sistema abre la vista detallada mostrando las prendas adquiridas, precios unitarios, descuentos y la opción de volver a emitir/descargar el ticket digital.

#### Flujos Alternativos:
* **A1. Búsqueda directa por número de ticket:**
  * 3.a. El usuario ingresa el código del ticket en el buscador directo.
  * 3.b. El sistema localiza la venta en menos de 1 segundo y despliega directamente su detalle.

#### Postcondición:
* El usuario revisa la trazabilidad de las operaciones sin alterar los registros existentes.

---

### CU-12 — Anular Venta Registrada

* **Id Caso de Uso:** CU-12
* **Id Requerimientos (Trazabilidad):** RF-53, RF-20
* **Necesidad Vinculada:** N-07
* **Actor Principal:** Administrador (Exclusivo)
* **Objetivo:** Permitir la anulación formal de una venta registrada por error o devolución de prendas, reintegrando automáticamente el stock físico al local correspondiente y dejando constancia auditable.

#### Precondiciones:
1. Solo el Administrador del sistema tiene privilegios para anular ventas.
2. La venta debe tener estado "Completada".

#### Flujo Principal:
1. El Administrador busca y abre el detalle de la venta que se desea anular (**CU-11**).
2. El Administrador hace clic en el botón "Anular Venta".
3. El sistema muestra un diálogo de confirmación requiriendo obligatoriamente el "Motivo de la anulación" (ej. devolución por talla incorrecta, error de digitación de medio de pago, reclamo del cliente).
4. El Administrador redacta el motivo y confirma la operación introduciendo su contraseña de seguridad.
5. El sistema valida la contraseña del Administrador.
6. El sistema ejecuta la anulación:
   * Cambia el estado de la venta a "Anulada".
   * Reintegra automáticamente las cantidades de prendas al inventario del local donde se produjo la venta.
   * Registra el usuario que autorizó, la fecha, hora y el motivo en el historial de anulaciones.
7. El sistema emite el mensaje: *"Venta anulada con éxito. El inventario ha sido restablecido"*.
8. La venta permanece visible en el historial con un distintivo rojo de "Anulada" para fines contables y de auditoría.

#### Flujos Alternativos:
* **A1. Contraseña del Administrador incorrecta:**
  * 5.a. La contraseña ingresada no coincide con la del Administrador activo.
  * 5.b. El sistema bloquea la acción con el mensaje: *"Contraseña incorrecta. La anulación no ha sido autorizada"*.
  * 5.c. La venta permanece sin alteraciones.

#### Postcondición:
* La venta queda anulada, las existencias físicas vuelven al stock disponible y el evento queda asentado en la auditoría del sistema.

---

## 📊 MÓDULO 4: REPORTES Y ANÁLISIS

---

### CU-13 — Generar y Filtrar Reportes Analíticos de Ventas

* **Id Caso de Uso:** CU-13
* **Id Requerimientos (Trazabilidad):** RF-56, RF-57, RF-58, RF-61, RF-62, RF-65, RF-66
* **Necesidad Vinculada:** N-09
* **Actor Principal:** Administrador
* **Objetivo:** Consolidar métricas de ingresos, comparar ventas entre los dos locales comerciales y visualizar gráficos interactivos del comportamiento comercial del negocio.

#### Precondiciones:
1. El usuario debe estar autenticado con rol Administrador.

#### Flujo Principal:
1. El Administrador ingresa al módulo de "Reportes y Estadísticas".
2. El sistema despliega el panel analítico (Dashboard) con los indicadores clave del mes en curso:
   * Total de ingresos monetarios.
   * Número total de transacciones completadas.
   * Ticket promedio por compra.
   * Gráfica comparativa de ventas: Local 1 vs. Local 2.
3. El Administrador configura los filtros de consulta:
   * Período: Hoy, Esta semana, Mes actual, o Rango personalizado de fechas.
   * Local comercial: Local 1, Local 2 o Ambos.
   * Vendedor específico.
   * Medio de pago: Efectivo, Tarjeta, Billetera digital.
   * Categoría de prendas.
4. El Administrador presiona "Actualizar Reporte".
5. El sistema procesa los datos y actualiza las tablas analíticas y los gráficos de barras y líneas temporales en un tiempo menor a 5 segundos.
6. El Administrador analiza la evolución de ventas, estacionalidad y desempeño comercial comparativo.

#### Flujos Alternativos:
* **A1. Rango de fechas sin transacciones:**
  * 5.a. El sistema comprueba que no existen ventas en el rango seleccionado.
  * 5.b. El sistema muestra el mensaje informativo: *"No existen registros comerciales para el período y filtros seleccionados"*, mostrando las gráficas en valor cero.

#### Postcondición:
* Las métricas son consolidadas y presentadas para la toma de decisiones gerenciales del propietario.

---

### CU-14 — Consultar Ranking de Prendas y Exportar Métricas

* **Id Caso de Uso:** CU-14
* **Id Requerimientos (Trazabilidad):** RF-59, RF-60, RF-63, RF-64
* **Necesidad Vinculada:** N-09
* **Actor Principal:** Administrador
* **Objetivo:** Identificar las prendas más vendidas (Top ventas) y las de baja rotación en el negocio, permitiendo exportar los reportes a formatos oficiales PDF y Excel (.xlsx).

#### Precondiciones:
1. El usuario debe estar autenticado con rol Administrador.

#### Flujo Principal:
1. El Administrador accede a la pestaña "Ranking de Productos y Exportación".
2. El sistema consulta las líneas de detalle de ventas y presenta dos listas analíticas:
   * **Top 10 Prendas Más Vendidas:** Código, nombre, categoría, unidades comercializadas e ingresos generados.
   * **Prendas de Menor Rotación:** Prendas con baja o nula rotación en los últimos 30/60 días (candidatas a promociones de liquidación).
3. El Administrador selecciona el botón de exportación deseado:
   * **Exportar a PDF:** Genera un documento imprimible con membrete de la tienda, tablas formateadas y firma de control gerencial.
   * **Exportar a Excel (.xlsx):** Genera una hoja de cálculo con los datos crudos organizados en columnas para análisis financiero externo.
4. El sistema construye el archivo correspondiente y lanza la descarga en el navegador del Administrador.
5. El Administrador abre o almacena el archivo generado en su equipo.

#### Flujos Alternativos:
* **A1. Falla temporal en la generación del documento:**
  * 4.a. Si ocurre un error de memoria o conexión al procesar un volumen masivo de datos, el sistema informa: *"No se pudo generar el archivo exportable. Intente acotar el rango de fechas"*.

#### Postcondición:
* El Administrador obtiene un archivo formal (PDF o Excel) con los datos comerciales auditados del negocio.

---

## 🌐 MÓDULO 5: CATÁLOGO DIGITAL WEB (PÚBLICO)

---

### CU-15 — Explorar Catálogo Digital Web y Disponibilidad en Tiendas

* **Id Caso de Uso:** CU-15
* **Id Requerimientos (Trazabilidad):** RF-67, RF-68, RF-69, RF-70, RF-71, RF-72
* **Necesidad Vinculada:** N-10
* **Actor Principal:** Cliente (Visitante Web)
* **Objetivo:** Permitir a cualquier visitante o cliente potencial consultar las prendas de vestir masculinas desde cualquier dispositivo (celular, tablet o PC) sin necesidad de registrarse, revisando fotos, tallas, colores, precios y disponibilidad física por local.

#### Precondiciones:
1. El usuario ingresa a la URL pública del catálogo web a través de un navegador moderno con conexión a Internet.
2. No se requiere autenticación ni registro de usuario.

#### Flujo Principal:
1. El Cliente ingresa a la portada del catálogo digital de la tienda.
2. El sistema carga la galería interactiva con las prendas activas, destacando novedades, colecciones de temporada y precios de venta en soles.
3. El Cliente busca o filtra prendas mediante:
   * Categorías de ropa masculina (camisas, polos, pantalones casuales, trajes, calzado).
   * Tallas disponibles.
   * Colores disponibles.
   * Buscador de texto predictivo por nombre o estilo de prenda.
4. El sistema actualiza la galería de productos en tiempo real según los filtros seleccionados.
5. El Cliente hace clic sobre una prenda de su interés para ver su "Ficha Técnica".
6. El sistema abre la vista detallada de la prenda mostrando:
   * Galería de fotografías en alta resolución con zoom interactivo.
   * Descripción de materiales y cuidados de la prenda.
   * Tallas y colores en existencia.
   * **Disponibilidad física por tienda:** Indicador de existencia en **Local 1** y **Local 2** con la dirección exacta de cada tienda física.
7. El Cliente puede presionar "Compartir" para copiar el enlace de la prenda o enviarlo directamente a través de WhatsApp.

#### Flujos Alternativos:
* **A1. Prenda agotada en ambos locales:**
  * 6.a. Si la prenda no tiene stock en ninguno de los dos locales, el sistema muestra la etiqueta visible: *"Temporalmente Agotado"*.
  * 6.b. Se deshabilita la indicación de existencia por local.
* **A2. Consulta de ubicación de tiendas físicas:**
  * 1.a. El Cliente selecciona la opción "Nuestras Tiendas" en el menú de navegación.
  * 1.b. El sistema despliega un mapa interactivo (Google Maps / OpenStreetMap) con las coordenadas, horarios de atención y números de contacto de los dos locales comerciales.

#### Postcondición:
* El cliente final obtiene información confiable sobre las prendas y ubica la tienda física con existencias para concretar su compra en tienda.
