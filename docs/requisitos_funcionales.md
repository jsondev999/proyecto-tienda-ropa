# Especificación de Requisitos Funcionales — SYSELL Web

**Proyecto:** Sistema de Gestión Comercial — Tienda de Ropa para Varón (SYSELL Web v2.0)  
**Versión:** 2.1 (Alineada con Matriz de Trazabilidad Integral y Casos de Prueba IEEE 829)  
**Fecha:** Octubre 2026  
**Cobertura:** 77 Requisitos Funcionales Oficiales (RF-01 a RF-77)  

---

## 📌 Índice de Módulos

1. [Módulo 1 — Autenticación y Seguridad (RF-01 a RF-14, RF-73)](#módulo-1--autenticación-y-seguridad)
2. [Módulo 2 — Gestión de Inventario (RF-15 a RF-39, RF-74, RF-75, RF-77)](#módulo-2--gestión-de-inventario)
3. [Módulo 3 — Registro y Gestión de Ventas (RF-40 a RF-55, RF-76)](#módulo-3--registro-y-gestión-de-ventas)
4. [Módulo 4 — Reportes y Análisis Estratégico (RF-56 a RF-66)](#módulo-4--reportes-y-análisis-estratégico)
5. [Módulo 5 — Catálogo Digital Web Público (RF-67 a RF-72)](#módulo-5--catálogo-digital-web-público)

---

## Módulo 1 — Autenticación y Seguridad (RF-01 a RF-14, RF-73)

### RF-01 — Solicitar nombre de usuario

**Descripción:** El sistema deberá requerir un identificador de usuario obligatorio al intentar iniciar sesión en la plataforma.  
**Actor(es):** Administrador, Vendedor  
**Prioridad:** Alta  
**Trazabilidad:** Caso de Uso [CU-01](diagramas_casos_de_uso/especificaciones_casos_de_uso.md) | Caso de Prueba [CP-01](casos_de_prueba.md) | DFD [P 1.0](diagramas_dfd/documentacion_dfd.md) | Calidad `RNF-05`

**Criterios de Aceptación:**
- El campo de nombre de usuario es mandatorio y no admite envíos vacíos ni espacios en blanco exclusivos.
- El sistema bloquea la solicitud de acceso en el cliente y muestra una alerta visual de campo requerido si se omite.
- Acepta formatos alfanuméricos estandarizados asignados por la administración.

---

### RF-02 — Solicitar contraseña

**Descripción:** El sistema deberá solicitar una contraseña de acceso confidencial como requisito indispensable para autenticar la identidad.  
**Actor(es):** Administrador, Vendedor  
**Prioridad:** Alta  
**Trazabilidad:** Caso de Uso [CU-01](diagramas_casos_de_uso/especificaciones_casos_de_uso.md) | Caso de Prueba [CP-02](casos_de_prueba.md) | DFD [P 1.0](diagramas_dfd/documentacion_dfd.md) | Calidad `RNF-03, RNF-05`

**Criterios de Aceptación:**
- El campo contraseña es obligatorio para procesar cualquier solicitud de inicio de sesión.
- Los caracteres ingresados se ocultan inmediatamente en la interfaz gráfica (enmascaramiento con viñetas o asteriscos).
- La interfaz provee un control opcional de alternancia para visualizar u ocultar temporalmente la clave tipeada.

---

### RF-03 — Autenticar usuario

**Descripción:** El sistema deberá validar la correspondencia unívoca entre el nombre de usuario y la credencial ingresada contra la base de datos.  
**Actor(es):** Administrador, Vendedor  
**Prioridad:** Alta  
**Trazabilidad:** Caso de Uso [CU-01](diagramas_casos_de_uso/especificaciones_casos_de_uso.md) | Caso de Prueba [CP-03](casos_de_prueba.md) | DFD [P 1.0](diagramas_dfd/documentacion_dfd.md) | Calidad `RNF-02, RNF-03`

**Criterios de Aceptación:**
- Comprueba la existencia del usuario en la tabla `usuarios` y su condición de cuenta activa (`activo = 1`).
- Si la autenticación es exitosa, se genera una sesión de trabajo autorizada y se redirige al panel según su rol.
- Si el usuario está inactivo o bloqueado, el sistema rechaza el acceso informando el estado sin exponer detalles internos.

---

### RF-04 — Validar credenciales

**Descripción:** El sistema deberá procesar la verificación de la contraseña mediante algoritmos criptográficos unidireccionales seguros.  
**Actor(es):** Sistema (Backend)  
**Prioridad:** Alta  
**Trazabilidad:** Caso de Uso [CU-01](diagramas_casos_de_uso/especificaciones_casos_de_uso.md) | Caso de Prueba [CP-04](casos_de_prueba.md) | DFD [P 1.0](diagramas_dfd/documentacion_dfd.md) | Calidad `RNF-03`

**Criterios de Aceptación:**
- Compara la contraseña en texto plano recibida mediante la función `password_verify` contra el hash Bcrypt (o Argon2) almacenado en la base de datos.
- Bajo ninguna circunstancia se almacenan ni registran contraseñas en texto claro en base de datos, caché o archivos de log.
- La validación se ejecuta en el backend en un tiempo constante para mitigar ataques de temporización (timing attacks).

---

### RF-05 — Denegar acceso erróneo

**Descripción:** El sistema deberá rechazar toda solicitud de inicio de sesión cuyas credenciales no coincidan con las registradas.  
**Actor(es):** Sistema (Seguridad)  
**Prioridad:** Alta  
**Trazabilidad:** Caso de Uso [CU-01](diagramas_casos_de_uso/especificaciones_casos_de_uso.md) | Caso de Prueba [CP-05](casos_de_prueba.md) | DFD [P 1.0](diagramas_dfd/documentacion_dfd.md) | Calidad `RNF-07`

**Criterios de Aceptación:**
- Muestra un mensaje genérico de error ('Credenciales inválidas') sin especificar si falló el usuario o la contraseña.
- No emite ningún token de autorización ni crea sesión en el cliente.
- Registra el intento fallido en el log de auditoría incrementando el contador correspondiente.

---

### RF-06 — Bloquear cuenta por intentos

**Descripción:** El sistema deberá suspender preventivamente la cuenta de usuario tras acumular exactamente 3 intentos fallidos consecutivos de acceso.  
**Actor(es):** Sistema (Seguridad)  
**Prioridad:** Alta  
**Trazabilidad:** Caso de Uso [CU-01](diagramas_casos_de_uso/especificaciones_casos_de_uso.md) | Caso de Prueba [CP-06](casos_de_prueba.md) | DFD [P 1.0](diagramas_dfd/documentacion_dfd.md) | Calidad `RNF-02, RNF-04`

**Criterios de Aceptación:**
- Alcanzado el tercer (3er) intento fallido consecutivo, la cuenta pasa automáticamente al estado 'Bloqueada' (`bloqueado = 1`).
- Cualquier intento subsiguiente de acceso con dicha cuenta es denegado de forma inmediata con mensaje de cuenta bloqueada.
- El desbloqueo requiere la intervención manual directa del Administrador del sistema.

---

### RF-07 — Asignar roles (Admin/Vendedor)

**Descripción:** El sistema deberá clasificar a cada colaborador dentro de un rol predefinido con atribuciones diferenciadas.  
**Actor(es):** Administrador  
**Prioridad:** Alta  
**Trazabilidad:** Caso de Uso [CU-02](diagramas_casos_de_uso/especificaciones_casos_de_uso.md) | Caso de Prueba [CP-07](casos_de_prueba.md) | DFD [P 1.0](diagramas_dfd/documentacion_dfd.md) | Calidad `RNF-02`

**Criterios de Aceptación:**
- Soporta formalmente dos perfiles operacionales: `Administrador` y `Vendedor`.
- El Administrador define el rol al momento de registrar al colaborador o mediante edición posterior.
- La asignación de rol se persiste en la clave foránea `rol_id` de la tabla `usuarios`.

---

### RF-08 — Restringir funciones según rol

**Descripción:** El sistema deberá controlar el acceso a los módulos y endpoints aplicando el principio de mínimo privilegio (RBAC).  
**Actor(es):** Sistema (Middleware)  
**Prioridad:** Alta  
**Trazabilidad:** Caso de Uso [CU-02](diagramas_casos_de_uso/especificaciones_casos_de_uso.md) | Caso de Prueba [CP-08](casos_de_prueba.md) | DFD [P 1.0](diagramas_dfd/documentacion_dfd.md) | Calidad `RNF-02, RNF-03`

**Criterios de Aceptación:**
- El rol `Vendedor` únicamente tiene habilitados los módulos de Terminal POS, Apertura/Cierre de Turno y Catálogo de Inventario.
- El rol `Vendedor` tiene estrictamente denegado el acceso a configuración, anulación de ventas, edición de catálogos y reportes estratégicos (retornando HTTP 403 Forbidden).
- La restricción es validada a nivel de middleware en el servidor de aplicaciones y no únicamente ocultando componentes en la interfaz.

---

### RF-09 — Cerrar sesión de usuario

**Descripción:** El sistema deberá permitir la terminación inmediata y segura de la sesión de trabajo del usuario autenticado.  
**Actor(es):** Administrador, Vendedor  
**Prioridad:** Media  
**Trazabilidad:** Caso de Uso [CU-03](diagramas_casos_de_uso/especificaciones_casos_de_uso.md) | Caso de Prueba [CP-09](casos_de_prueba.md) | DFD [P 1.0](diagramas_dfd/documentacion_dfd.md) | Calidad `RNF-02`

**Criterios de Aceptación:**
- Invalida el token JWT / Sanctum en el servidor revocando sus permisos en memoria o base de datos.
- Destruye todas las variables de sesión y credenciales cacheadas en el almacenamiento local del cliente.
- Redirige de manera automática al usuario a la pantalla pública de autenticación.

---

### RF-10 — Crear nuevo usuario

**Descripción:** El sistema deberá permitir al Administrador registrar nuevos colaboradores para operar en cualquiera de los dos locales.  
**Actor(es):** Administrador  
**Prioridad:** Alta  
**Trazabilidad:** Caso de Uso [CU-02](diagramas_casos_de_uso/especificaciones_casos_de_uso.md) | Caso de Prueba [CP-10](casos_de_prueba.md) | DFD [P 1.0](diagramas_dfd/documentacion_dfd.md) | Calidad `RNF-02, RNF-04`

**Criterios de Aceptación:**
- Solicita nombre completo, documento de identidad, nombre de usuario único, contraseña provisional, rol y local asignado.
- Valida la unicidad del nombre de usuario y documento antes de persistir.
- Cifra la contraseña inicial mediante hash seguro y activa la cuenta por defecto.

---

### RF-11 — Listar usuarios registrados

**Descripción:** El sistema deberá ofrecer una vista tabular con todos los colaboradores dados de alta en el sistema.  
**Actor(es):** Administrador  
**Prioridad:** Media  
**Trazabilidad:** Caso de Uso [CU-02](diagramas_casos_de_uso/especificaciones_casos_de_uso.md) | Caso de Prueba [CP-11](casos_de_prueba.md) | DFD [P 1.0](diagramas_dfd/documentacion_dfd.md) | Calidad `RNF-02`

**Criterios de Aceptación:**
- Exhibe nombre de usuario, nombre y apellido, rol asignado, local comercial al que pertenece y estado actual (Activo/Inactivo/Bloqueado).
- Permite filtrar la lista por local o por rol para agilizar la búsqueda.
- Presenta acciones contextuales de edición, desbloqueo y desactivación por cada fila.

---

### RF-12 — Modificar datos de usuario

**Descripción:** El sistema deberá permitir actualizar la información administrativa de un usuario sin alterar su historial comercial.  
**Actor(es):** Administrador  
**Prioridad:** Media  
**Trazabilidad:** Caso de Uso [CU-02](diagramas_casos_de_uso/especificaciones_casos_de_uso.md) | Caso de Prueba [CP-12](casos_de_prueba.md) | DFD [P 1.0](diagramas_dfd/documentacion_dfd.md) | Calidad `RNF-04`

**Criterios de Aceptación:**
- Permite modificar nombre, apellidos, rol y reasignar la tienda física donde labora el colaborador.
- Mantiene inmutable el identificador de usuario (`id`) preservando la integridad referencial en ventas y auditoría.
- Registra el evento de modificación en la bitácora de auditoría con la fecha y el usuario que ejecutó el cambio.

---

### RF-13 — Desactivar cuenta de usuario

**Descripción:** El sistema deberá permitir suspender la cuenta de un colaborador que deja de laborar en la tienda.  
**Actor(es):** Administrador  
**Prioridad:** Alta  
**Trazabilidad:** Caso de Uso [CU-02](diagramas_casos_de_uso/especificaciones_casos_de_uso.md) | Caso de Prueba [CP-13](casos_de_prueba.md) | DFD [P 1.0](diagramas_dfd/documentacion_dfd.md) | Calidad `RNF-02, RNF-04`

**Criterios de Aceptación:**
- Aplica borrado lógico mediante el atributo `activo = 0`, impidiendo futuros inicios de sesión.
- Conserva intactos los registros históricos de ventas y movimientos realizados por el usuario en el pasado.
- No permite la eliminación física de registros de usuarios para garantizar la trazabilidad contable y legal.

---

### RF-14 — Desbloquear cuenta de usuario

**Descripción:** El sistema deberá facultar al Administrador para restituir el acceso a cuentas bloqueadas por exceso de intentos fallidos.  
**Actor(es):** Administrador  
**Prioridad:** Media  
**Trazabilidad:** Caso de Uso [CU-02](diagramas_casos_de_uso/especificaciones_casos_de_uso.md) | Caso de Prueba [CP-14](casos_de_prueba.md) | DFD [P 1.0](diagramas_dfd/documentacion_dfd.md) | Calidad `RNF-02`

**Criterios de Aceptación:**
- Cambia el estado de la cuenta a `bloqueado = 0` y reinicia el contador `intentos_fallidos` a cero.
- Permite al usuario volver a autenticarse normalmente con su contraseña vigente.
- Registra en la bitácora de seguridad el evento de desbloqueo administrativo.

---

### RF-73 — Resetear contraseña por Admin

**Descripción:** El sistema deberá permitir al Administrador restablecer la contraseña de cualquier colaborador ante olvido o extravío.  
**Actor(es):** Administrador  
**Prioridad:** Alta  
**Trazabilidad:** Caso de Uso [CU-02](diagramas_casos_de_uso/especificaciones_casos_de_uso.md) | Caso de Prueba [CP-73](casos_de_prueba.md) | DFD [P 1.0](diagramas_dfd/documentacion_dfd.md) | Calidad `RNF-02, RNF-03`

**Criterios de Aceptación:**
- El Administrador ingresa una nueva clave temporal segura cumpliendo con la política de complejidad.
- El sistema cifra la nueva clave con Bcrypt y fuerza su actualización en el siguiente acceso si así se configura.
- Los vendedores no poseen privilegios para modificar su propia contraseña ni la de terceros.

---

## Módulo 2 — Gestión de Inventario (RF-15 a RF-39, RF-74, RF-75, RF-77)

### RF-15 — Registrar prenda

**Descripción:** El sistema deberá permitir el ingreso de nuevas prendas de vestir masculinas al catálogo general.  
**Actor(es):** Administrador  
**Prioridad:** Alta  
**Trazabilidad:** Caso de Uso [CU-05](diagramas_casos_de_uso/especificaciones_casos_de_uso.md) | Caso de Prueba [CP-15](casos_de_prueba.md) | DFD [P 2.0](diagramas_dfd/documentacion_dfd.md) | Calidad `RNF-04, RNF-11`

**Criterios de Aceptación:**
- Solicita nombre comercial, descripción, categoría, marca, talla, color, precio de compra referencial, precio de venta y fotografía.
- Genera automáticamente un código SKU normalizado único para cada combinación física de prenda.
- Exige que los atributos de categoría, marca, talla y color sean seleccionados de los catálogos maestros cerrados.

---

### RF-16 — Modificar prenda

**Descripción:** El sistema deberá posibilitar la actualización de descripciones, precios y atributos visuales de una prenda registrada.  
**Actor(es):** Administrador  
**Prioridad:** Media  
**Trazabilidad:** Caso de Uso [CU-05](diagramas_casos_de_uso/especificaciones_casos_de_uso.md) | Caso de Prueba [CP-16](casos_de_prueba.md) | DFD [P 2.0](diagramas_dfd/documentacion_dfd.md) | Calidad `RNF-04`

**Criterios de Aceptación:**
- Permite modificar precio de venta, precio de compra referencial, descripción y fotografía.
- El cambio de precio se refleja de inmediato en los puntos de venta POS y en el catálogo web público.
- No altera el código SKU preexistente para no quebrar la trazabilidad de inventario.

---

### RF-17 — Eliminar prenda

**Descripción:** El sistema deberá controlar la supresión de prendas protegiendo la integridad del historial de ventas.  
**Actor(es):** Administrador  
**Prioridad:** Media  
**Trazabilidad:** Caso de Uso [CU-05](diagramas_casos_de_uso/especificaciones_casos_de_uso.md) | Caso de Prueba [CP-17](casos_de_prueba.md) | DFD [P 2.0](diagramas_dfd/documentacion_dfd.md) | Calidad `RNF-04`

**Criterios de Aceptación:**
- Si la prenda registra ventas históricas en la base de datos, el sistema solo permite el borrado lógico (inactivación comercial).
- Si la prenda fue registrada por error y no cuenta con movimientos de stock ni transacciones, permite su eliminación física.
- Las prendas inactivadas dejan de exhibirse en el POS y en el catálogo público.

---

### RF-18 — Consultar prenda por SKU/nombre

**Descripción:** El sistema deberá proveer una herramienta de búsqueda rápida de prendas en el módulo de inventario.  
**Actor(es):** Administrador, Vendedor  
**Prioridad:** Alta  
**Trazabilidad:** Caso de Uso [CU-04](diagramas_casos_de_uso/especificaciones_casos_de_uso.md) | Caso de Prueba [CP-18](casos_de_prueba.md) | DFD [P 2.0](diagramas_dfd/documentacion_dfd.md) | Calidad `RNF-08`

**Criterios de Aceptación:**
- Permite localizar prendas ingresando el código SKU exacto o términos coincidentes con su denominación comercial.
- Retorna de forma instantánea ficha de la prenda, precios vigentes y desglose de existencias por local.
- Soporta lectura directa mediante lector óptico de códigos de barras sobre el campo SKU.

---

### RF-19 — Registrar stock inicial por local

**Descripción:** El sistema deberá permitir la asignación independiente de unidades físicas disponibles para cada una de las dos sucursales.  
**Actor(es):** Administrador  
**Prioridad:** Alta  
**Trazabilidad:** Caso de Uso [CU-05](diagramas_casos_de_uso/especificaciones_casos_de_uso.md) | Caso de Prueba [CP-19](casos_de_prueba.md) | DFD [P 2.0](diagramas_dfd/documentacion_dfd.md) | Calidad `RNF-11`

**Criterios de Aceptación:**
- Permite definir la cantidad inicial de existencias en el Local 1 (Principal) y en el Local 2 (Sucursal).
- Crea los registros correspondientes en la tabla relacional `inventario` indexados por `(producto_id, local_id)`.
- Establece el balance inicial del producto para el seguimiento posterior en el Kardex.

---

### RF-20 — Actualizar stock por ingreso/ajuste

**Descripción:** El sistema deberá permitir asentar entradas de mercadería, regularizaciones por mermas o inventarios físicos.  
**Actor(es):** Administrador  
**Prioridad:** Alta  
**Trazabilidad:** Caso de Uso [CU-06](diagramas_casos_de_uso/especificaciones_casos_de_uso.md) | Caso de Prueba [CP-20](casos_de_prueba.md) | DFD [P 2.0](diagramas_dfd/documentacion_dfd.md) | Calidad `RNF-04, RNF-11`

**Criterios de Aceptación:**
- Permite registrar movimientos de tipo Entrada (compra/recepción), Salida (merma/daño) o Ajuste directo de conteo.
- Exige registrar el motivo formal del movimiento y el local específico donde se ejecuta.
- Actualiza el stock disponible en la tabla `inventario` e inserta el asiento auditable en `ajustes_inventario`.

---

### RF-21 — Descontar stock tras venta

**Descripción:** El sistema deberá disminuir automáticamente las existencias de cada prenda vendida al momento de confirmar el ticket.  
**Actor(es):** Sistema (Transaccional)  
**Prioridad:** Alta  
**Trazabilidad:** Caso de Uso [CU-08](diagramas_casos_de_uso/especificaciones_casos_de_uso.md) | Caso de Prueba [CP-21](casos_de_prueba.md) | DFD [P 3.4](diagramas_dfd/documentacion_dfd.md) | Calidad `RNF-08, RNF-11`

**Criterios de Aceptación:**
- Resta las unidades especificadas del inventario correspondiente a la sucursal donde se concretó la venta.
- La operación se ejecuta dentro de una transacción ACID garantizando atomicidad (todo o nada).
- Impide registrar ventas que dejen el inventario en saldo negativo salvo configuración de contingencia.

---

### RF-22 — Consultar stock disponible por local

**Descripción:** El sistema deberá exhibir en todo momento las existencias reales diferenciadas por tienda comercial.  
**Actor(es):** Administrador, Vendedor  
**Prioridad:** Alta  
**Trazabilidad:** Caso de Uso [CU-04](diagramas_casos_de_uso/especificaciones_casos_de_uso.md) | Caso de Prueba [CP-22](casos_de_prueba.md) | DFD [P 2.0](diagramas_dfd/documentacion_dfd.md) | Calidad `RNF-08, RNF-11`

**Criterios de Aceptación:**
- Muestra en columnas separadas las unidades disponibles en el Local 1 y en el Local 2 para cada variante.
- Permite a un vendedor en mostrador consultar existencias en la otra tienda para derivar clientes o coordinar traslados.
- La información se actualiza en tiempo real con cada venta o ajuste procesado.

---

### RF-23 — Emitir alertas de bajo stock

**Descripción:** El sistema deberá advertir visualmente cuando las existencias de una prenda alcancen niveles próximos al desabastecimiento.  
**Actor(es):** Sistema (Alertas)  
**Prioridad:** Media  
**Trazabilidad:** Caso de Uso [CU-06](diagramas_casos_de_uso/especificaciones_casos_de_uso.md) | Caso de Prueba [CP-23](casos_de_prueba.md) | DFD [P 2.0](diagramas_dfd/documentacion_dfd.md) | Calidad `RNF-05`

**Criterios de Aceptación:**
- Compara las unidades disponibles contra el umbral mínimo configurado para cada local.
- Resalta visualmente con distintivos amarillos/naranjas en la lista de inventario las prendas en umbral bajo.
- Permite generar listas filtradas de prendas que requieren reposición inmediata.

---

### RF-24 — Configurar umbral de stock mínimo

**Descripción:** El sistema deberá permitir parametrizar la cantidad de seguridad requerida para cada artículo por local.  
**Actor(es):** Administrador  
**Prioridad:** Media  
**Trazabilidad:** Caso de Uso [CU-06](diagramas_casos_de_uso/especificaciones_casos_de_uso.md) | Caso de Prueba [CP-24](casos_de_prueba.md) | DFD [P 2.0](diagramas_dfd/documentacion_dfd.md) | Calidad `RNF-11`

**Criterios de Aceptación:**
- Permite establecer un valor numérico entero en el campo `stock_minimo` de la tabla `inventario`.
- El valor puede configurarse de manera diferenciada según la rotación de cada sucursal.
- Sirve como regla de negocio para detonar las alertas de reposición preventiva.

---

### RF-25 — Notificar stock crítico al Admin

**Descripción:** El sistema deberá alertar de manera prioritaria en el panel de administración cuando un producto se agote totalmente.  
**Actor(es):** Sistema (Notificaciones)  
**Prioridad:** Media  
**Trazabilidad:** Caso de Uso [CU-06](diagramas_casos_de_uso/especificaciones_casos_de_uso.md) | Caso de Prueba [CP-25](casos_de_prueba.md) | DFD [P 2.0](diagramas_dfd/documentacion_dfd.md) | Calidad `RNF-07`

**Criterios de Aceptación:**
- Detecta cuando el saldo de un producto llega a 0 unidades en cualquiera de los dos locales.
- Despliega una tarjeta de advertencia en el Dashboard del Administrador con el listado de quiebres de stock.
- Facilita la toma de decisiones para nuevas compras a proveedores.

---

### RF-26 — Registrar categoría

**Descripción:** El sistema deberá permitir crear nuevas agrupaciones de prendas masculinas en el catálogo maestro.  
**Actor(es):** Administrador  
**Prioridad:** Alta  
**Trazabilidad:** Caso de Uso [CU-07](diagramas_casos_de_uso/especificaciones_casos_de_uso.md) | Caso de Prueba [CP-26](casos_de_prueba.md) | DFD [P 2.0](diagramas_dfd/documentacion_dfd.md) | Calidad `RNF-14`

**Criterios de Aceptación:**
- Permite ingresar el nombre de la categoría (ej. Camisas, Pantalones, Casacas, Polos).
- Valida que no existan categorías duplicadas con el mismo nombre mediante restricción única en BD.
- Queda disponible de inmediato para clasificar prendas en inventario y navegación web.

---

### RF-27 — Modificar categoría

**Descripción:** El sistema deberá permitir editar el nombre o descripción de una categoría existente.  
**Actor(es):** Administrador  
**Prioridad:** Baja  
**Trazabilidad:** Caso de Uso [CU-07](diagramas_casos_de_uso/especificaciones_casos_de_uso.md) | Caso de Prueba [CP-27](casos_de_prueba.md) | DFD [P 2.0](diagramas_dfd/documentacion_dfd.md) | Calidad `RNF-14`

**Criterios de Aceptación:**
- Actualiza la denominación de la categoría sin alterar la clave primaria ni las relaciones existentes.
- Todas las prendas vinculadas reflejan automáticamente la denominación actualizada.

---

### RF-28 — Eliminar categoría

**Descripción:** El sistema deberá regular la eliminación de categorías protegiendo las prendas asignadas.  
**Actor(es):** Administrador  
**Prioridad:** Baja  
**Trazabilidad:** Caso de Uso [CU-07](diagramas_casos_de_uso/especificaciones_casos_de_uso.md) | Caso de Prueba [CP-28](casos_de_prueba.md) | DFD [P 2.0](diagramas_dfd/documentacion_dfd.md) | Calidad `RNF-04`

**Criterios de Aceptación:**
- Si la categoría tiene prendas vinculadas activas, el sistema bloquea la eliminación informando el impedimento.
- Solo permite eliminar categorías vacías que no posean referencias en la tabla `productos`.

---

### RF-29 — Registrar talla

**Descripción:** El sistema deberá permitir dar de alta tallas estandarizadas para prendas de varón.  
**Actor(es):** Administrador  
**Prioridad:** Alta  
**Trazabilidad:** Caso de Uso [CU-07](diagramas_casos_de_uso/especificaciones_casos_de_uso.md) | Caso de Prueba [CP-29](casos_de_prueba.md) | DFD [P 2.0](diagramas_dfd/documentacion_dfd.md) | Calidad `RNF-14`

**Criterios de Aceptación:**
- Permite registrar tallas alfabéticas (S, M, L, XL, XXL) o numéricas (28, 30, 32, 34, 36).
- Valida unicidad para evitar registros redundantes en el catálogo maestro `tallas`.

---

### RF-30 — Modificar talla

**Descripción:** El sistema deberá permitir corregir la denominación de una talla registrada en el catálogo.  
**Actor(es):** Administrador  
**Prioridad:** Baja  
**Trazabilidad:** Caso de Uso [CU-07](diagramas_casos_de_uso/especificaciones_casos_de_uso.md) | Caso de Prueba [CP-30](casos_de_prueba.md) | DFD [P 2.0](diagramas_dfd/documentacion_dfd.md) | Calidad `RNF-14`

**Criterios de Aceptación:**
- Actualiza el valor en la tabla `tallas` preservando la integridad referencial con los productos asociados.

---

### RF-31 — Registrar color

**Descripción:** El sistema deberá permitir ingresar nombres de colores y sus respectivos códigos hexadecimales para visualización gráfica.  
**Actor(es):** Administrador  
**Prioridad:** Alta  
**Trazabilidad:** Caso de Uso [CU-07](diagramas_casos_de_uso/especificaciones_casos_de_uso.md) | Caso de Prueba [CP-31](casos_de_prueba.md) | DFD [P 2.0](diagramas_dfd/documentacion_dfd.md) | Calidad `RNF-14`

**Criterios de Aceptación:**
- Solicita nombre del color (ej. Azul Marino) y código hexadecimal web (ej. `#000080`).
- Permite al cliente final previsualizar la muestra visual exacta del color en el catálogo digital.

---

### RF-32 — Modificar color

**Descripción:** El sistema deberá permitir ajustar el nombre o código cromático de un color en el catálogo maestro.  
**Actor(es):** Administrador  
**Prioridad:** Baja  
**Trazabilidad:** Caso de Uso [CU-07](diagramas_casos_de_uso/especificaciones_casos_de_uso.md) | Caso de Prueba [CP-32](casos_de_prueba.md) | DFD [P 2.0](diagramas_dfd/documentacion_dfd.md) | Calidad `RNF-14`

**Criterios de Aceptación:**
- Actualiza los atributos del color en la tabla `colores` afectando positivamente la representación gráfica en la tienda.

---

### RF-33 — Registrar marca

**Descripción:** El sistema deberá permitir la administración de marcas comerciales de ropa masculina comercializadas.  
**Actor(es):** Administrador  
**Prioridad:** Alta  
**Trazabilidad:** Caso de Uso [CU-07](diagramas_casos_de_uso/especificaciones_casos_de_uso.md) | Caso de Prueba [CP-33](casos_de_prueba.md) | DFD [P 2.0](diagramas_dfd/documentacion_dfd.md) | Calidad `RNF-14`

**Criterios de Aceptación:**
- Permite incorporar nuevas marcas de fabricantes al catálogo maestro cerrado `marcas`.
- Garantiza que ningún usuario ingrese marcas libres con faltas ortográficas o variantes no autorizadas.

---

### RF-34 — Modificar marca

**Descripción:** El sistema deberá permitir corregir o actualizar la denominación de una marca comercial.  
**Actor(es):** Administrador  
**Prioridad:** Baja  
**Trazabilidad:** Caso de Uso [CU-07](diagramas_casos_de_uso/especificaciones_casos_de_uso.md) | Caso de Prueba [CP-34](casos_de_prueba.md) | DFD [P 2.0](diagramas_dfd/documentacion_dfd.md) | Calidad `RNF-14`

**Criterios de Aceptación:**
- Modifica el registro en la tabla `marcas` manteniendo la trazabilidad histórica de los productos.

---

### RF-35 — Búsqueda en tiempo real

**Descripción:** El sistema deberá proveer un buscador ágil que filtre el inventario mientras el usuario escribe.  
**Actor(es):** Administrador, Vendedor  
**Prioridad:** Media  
**Trazabilidad:** Caso de Uso [CU-04](diagramas_casos_de_uso/especificaciones_casos_de_uso.md) | Caso de Prueba [CP-35](casos_de_prueba.md) | DFD [P 2.0](diagramas_dfd/documentacion_dfd.md) | Calidad `RNF-08`

**Criterios de Aceptación:**
- Inicia el filtrado tras ingresar 3 caracteres con un tiempo de respuesta menor a 1 segundo.
- Busca coincidencias en nombre de producto, código SKU, categoría y marca simultáneamente.

---

### RF-36 — Filtrar por categoría

**Descripción:** El sistema deberá permitir segmentar el inventario según el tipo de prenda seleccionado.  
**Actor(es):** Administrador, Vendedor  
**Prioridad:** Media  
**Trazabilidad:** Caso de Uso [CU-04](diagramas_casos_de_uso/especificaciones_casos_de_uso.md) | Caso de Prueba [CP-36](casos_de_prueba.md) | DFD [P 2.0](diagramas_dfd/documentacion_dfd.md) | Calidad `RNF-05`

**Criterios de Aceptación:**
- Presenta un selector con las categorías activas restringiendo los resultados a las prendas asociadas.

---

### RF-37 — Filtrar por talla

**Descripción:** El sistema deberá permitir filtrar las existencias por tamaño de prenda.  
**Actor(es):** Administrador, Vendedor  
**Prioridad:** Media  
**Trazabilidad:** Caso de Uso [CU-04](diagramas_casos_de_uso/especificaciones_casos_de_uso.md) | Caso de Prueba [CP-37](casos_de_prueba.md) | DFD [P 2.0](diagramas_dfd/documentacion_dfd.md) | Calidad `RNF-05`

**Criterios de Aceptación:**
- Permite seleccionar una talla específica desplegando únicamente los artículos con existencias en dicha medida.

---

### RF-38 — Filtrar por marca

**Descripción:** El sistema deberá permitir seleccionar prendas producidas por una marca comercial específica.  
**Actor(es):** Administrador, Vendedor  
**Prioridad:** Media  
**Trazabilidad:** Caso de Uso [CU-04](diagramas_casos_de_uso/especificaciones_casos_de_uso.md) | Caso de Prueba [CP-38](casos_de_prueba.md) | DFD [P 2.0](diagramas_dfd/documentacion_dfd.md) | Calidad `RNF-05`

**Criterios de Aceptación:**
- Filtra el listado de productos asociándolos al `marca_id` seleccionado.

---

### RF-39 — Filtrar por rango de precio

**Descripción:** El sistema deberá posibilitar la consulta de prendas dentro de un intervalo monetario definido.  
**Actor(es):** Administrador, Vendedor  
**Prioridad:** Baja  
**Trazabilidad:** Caso de Uso [CU-04](diagramas_casos_de_uso/especificaciones_casos_de_uso.md) | Caso de Prueba [CP-39](casos_de_prueba.md) | DFD [P 2.0](diagramas_dfd/documentacion_dfd.md) | Calidad `RNF-08`

**Criterios de Aceptación:**
- Permite ingresar valores mínimo y máximo de precio de venta mostrando los productos comprendidos en el rango.

---

### RF-74 — Catálogos maestros cerrados

**Descripción:** El sistema deberá erradicar el ingreso de texto libre en atributos maestros de prendas para evitar inconsistencias.  
**Actor(es):** Sistema (Diseño)  
**Prioridad:** Alta  
**Trazabilidad:** Caso de Uso [CU-07](diagramas_casos_de_uso/especificaciones_casos_de_uso.md) | Caso de Prueba [CP-74](casos_de_prueba.md) | DFD [P 2.0](diagramas_dfd/documentacion_dfd.md) | Calidad `RNF-04, RNF-14`

**Criterios de Aceptación:**
- Los formularios de prendas solo aceptan selecciones provenientes de las tablas `categorias`, `marcas`, `tallas` y `colores`.
- Se prohíbe todo campo de entrada libre para dichos atributos en el frontend y backend.

---

### RF-75 — Filtros dinámicos combinables

**Descripción:** El sistema deberá procesar la aplicación simultánea de múltiples criterios de búsqueda mediante intersección lógica (AND).  
**Actor(es):** Administrador, Vendedor  
**Prioridad:** Media  
**Trazabilidad:** Caso de Uso [CU-04](diagramas_casos_de_uso/especificaciones_casos_de_uso.md) | Caso de Prueba [CP-75](casos_de_prueba.md) | DFD [P 2.0](diagramas_dfd/documentacion_dfd.md) | Calidad `RNF-08`

**Criterios de Aceptación:**
- Permite combinar categoría + talla + color + marca + local en una sola consulta.
- El motor de consultas construye dinámicamente la cláusula SQL con parámetros seguros.

---

### RF-77 — Alertas reposición por local

**Descripción:** El sistema deberá sugerir transferencias de inventario entre locales cuando una sucursal presente déficit y la otra excedente.  
**Actor(es):** Sistema (Lógica)  
**Prioridad:** Media  
**Trazabilidad:** Caso de Uso [CU-06](diagramas_casos_de_uso/especificaciones_casos_de_uso.md) | Caso de Prueba [CP-77](casos_de_prueba.md) | DFD [P 2.0](diagramas_dfd/documentacion_dfd.md) | Calidad `RNF-11`

**Criterios de Aceptación:**
- Identifica prendas con stock $\le$ umbral mínimo en Local 1 pero con saldo favorable en Local 2.
- Muestra una recomendación de traslado interno para balancear el stock sin necesidad de nueva compra.

---

## Módulo 3 — Registro y Gestión de Ventas (RF-40 a RF-55, RF-76)

### RF-40 — Iniciar nueva venta

**Descripción:** El sistema deberá habilitar la apertura de una transacción de cobro limpia en el Punto de Venta (POS).  
**Actor(es):** Vendedor  
**Prioridad:** Alta  
**Trazabilidad:** Caso de Uso [CU-08](diagramas_casos_de_uso/especificaciones_casos_de_uso.md) | Caso de Prueba [CP-40](casos_de_prueba.md) | DFD [P 3.0](diagramas_dfd/documentacion_dfd.md) | Calidad `RNF-05`

**Criterios de Aceptación:**
- Inicializa la orden de venta vinculando automáticamente al vendedor autenticado, local comercial y fecha/hora.
- Genera un identificador temporal en memoria o local para acumular los ítems del ticket.

---

### RF-41 — Agregar prendas a la venta

**Descripción:** El sistema deberá permitir incorporar artículos a la orden mediante lectura de código de barras o selección en pantalla.  
**Actor(es):** Vendedor  
**Prioridad:** Alta  
**Trazabilidad:** Caso de Uso [CU-08](diagramas_casos_de_uso/especificaciones_casos_de_uso.md) | Caso de Prueba [CP-41](casos_de_prueba.md) | DFD [P 3.1](diagramas_dfd/documentacion_dfd.md) | Calidad `RNF-08`

**Criterios de Aceptación:**
- Verifica la disponibilidad de stock físico en el local antes de agregar la prenda a la grilla.
- Carga precio unitario vigente y cantidad predeterminada en 1 unidad.

---

### RF-42 — Modificar cantidad de prendas

**Descripción:** El sistema deberá posibilitar el incremento o disminución de unidades de una línea de venta en el carrito.  
**Actor(es):** Vendedor  
**Prioridad:** Alta  
**Trazabilidad:** Caso de Uso [CU-08](diagramas_casos_de_uso/especificaciones_casos_de_uso.md) | Caso de Prueba [CP-42](casos_de_prueba.md) | DFD [P 3.2](diagramas_dfd/documentacion_dfd.md) | Calidad `RNF-08`

**Criterios de Aceptación:**
- Valida que la cantidad solicitada no supere el inventario físico disponible en la tienda.
- Recalcula en tiempo real el subtotal de la línea de producto.

---

### RF-43 — Eliminar prenda de la venta

**Descripción:** El sistema deberá permitir retirar un ítem cargado por error en la orden de cobro previa a la confirmación.  
**Actor(es):** Vendedor  
**Prioridad:** Media  
**Trazabilidad:** Caso de Uso [CU-08](diagramas_casos_de_uso/especificaciones_casos_de_uso.md) | Caso de Prueba [CP-43](casos_de_prueba.md) | DFD [P 3.2](diagramas_dfd/documentacion_dfd.md) | Calidad `RNF-05`

**Criterios de Aceptación:**
- Remueve la línea seleccionada y deduce su importe de la sumatoria total del ticket.

---

### RF-44 — Calcular total y descuentos

**Descripción:** El sistema deberá computar con precisión aritmética el subtotal, descuentos autorizados y total a liquidar.  
**Actor(es):** Sistema (Aritmética)  
**Prioridad:** Alta  
**Trazabilidad:** Caso de Uso [CU-08](diagramas_casos_de_uso/especificaciones_casos_de_uso.md) | Caso de Prueba [CP-44](casos_de_prueba.md) | DFD [P 3.2](diagramas_dfd/documentacion_dfd.md) | Calidad `RNF-08`

**Criterios de Aceptación:**
- Calcula la sumatoria de las líneas de producto aplicando dos decimales exactos.
- Aplica descuentos promocionales si corresponden y presenta el importe neto exigible.

---

### RF-45 — Seleccionar medio de pago

**Descripción:** El sistema deberá admitir los principales métodos de cobro comercial del mercado peruano.  
**Actor(es):** Vendedor  
**Prioridad:** Alta  
**Trazabilidad:** Caso de Uso [CU-08](diagramas_casos_de_uso/especificaciones_casos_de_uso.md) | Caso de Prueba [CP-45](casos_de_prueba.md) | DFD [P 3.3](diagramas_dfd/documentacion_dfd.md) | Calidad `RNF-05`

**Criterios de Aceptación:**
- Permite seleccionar Efectivo, Tarjeta de Débito/Crédito y Billeteras Digitales (Yape, Plin).
- Soporta pagos mixtos dividiendo el total en dos medios de pago complementarios.

---

### RF-46 — Registrar cobro y cambio

**Descripción:** El sistema deberá calcular automáticamente el vuelto o cambio a entregar cuando el pago se efectúe en efectivo.  
**Actor(es):** Vendedor, Sistema  
**Prioridad:** Alta  
**Trazabilidad:** Caso de Uso [CU-08](diagramas_casos_de_uso/especificaciones_casos_de_uso.md) | Caso de Prueba [CP-46](casos_de_prueba.md) | DFD [P 3.3](diagramas_dfd/documentacion_dfd.md) | Calidad `RNF-08`

**Criterios de Aceptación:**
- Solicita el importe de efectivo entregado por el comprador.
- Valida que el monto recibido sea mayor o igual al total a pagar y muestra en pantalla grande el cambio exacto a devolver.

---

### RF-47 — Confirmar y registrar venta

**Descripción:** El sistema deberá persistir la venta de forma atómica y definitiva en la base de datos central.  
**Actor(es):** Sistema (Transaccional)  
**Prioridad:** Alta  
**Trazabilidad:** Caso de Uso [CU-08](diagramas_casos_de_uso/especificaciones_casos_de_uso.md) | Caso de Prueba [CP-47](casos_de_prueba.md) | DFD [P 3.3](diagramas_dfd/documentacion_dfd.md) | Calidad `RNF-08, RNF-10`

**Criterios de Aceptación:**
- Inserta el registro maestro en `ventas` y los ítems en `detalle_ventas` dentro de una transacción SQL.
- Descuenta el inventario físico de las prendas vendidas en el local.
- Bloquea la orden impidiendo modificaciones posteriores.

---

### RF-48 — Generar ticket digital

**Descripción:** El sistema deberá crear un comprobante digital interno con correlativo único por cada transacción confirmada.  
**Actor(es):** Sistema  
**Prioridad:** Alta  
**Trazabilidad:** Caso de Uso [CU-09](diagramas_casos_de_uso/especificaciones_casos_de_uso.md) | Caso de Prueba [CP-48](casos_de_prueba.md) | DFD [P 3.5](diagramas_dfd/documentacion_dfd.md) | Calidad `RNF-01, RNF-10`

**Criterios de Aceptación:**
- Genera un código correlativo con nomenclatura de tienda (ej. `TICK-L1-000145`).
- Incluye fecha, hora, local, cajero, detalle de prendas, totales y medio de pago.

---

### RF-49 — Imprimir ticket térmico/PDF

**Descripción:** El sistema deberá ofrecer la opción de impresión del ticket en impresoras de punto de venta y descarga en PDF.  
**Actor(es):** Vendedor  
**Prioridad:** Media  
**Trazabilidad:** Caso de Uso [CU-09](diagramas_casos_de_uso/especificaciones_casos_de_uso.md) | Caso de Prueba [CP-49](casos_de_prueba.md) | DFD [P 3.5](diagramas_dfd/documentacion_dfd.md) | Calidad `RNF-05`

**Criterios de Aceptación:**
- Genera formato optimizado para impresoras térmicas de 80 mm o 58 mm.
- Provee la opción de exportar el comprobante en documento PDF descargable.

---

### RF-50 — Enviar ticket por WhatsApp

**Descripción:** El sistema deberá permitir despachar el comprobante de venta digital al teléfono del comprador.  
**Actor(es):** Vendedor  
**Prioridad:** Media  
**Trazabilidad:** Caso de Uso [CU-09](diagramas_casos_de_uso/especificaciones_casos_de_uso.md) | Caso de Prueba [CP-50](casos_de_prueba.md) | DFD [P 3.5](diagramas_dfd/documentacion_dfd.md) | Calidad `RNF-14`

**Criterios de Aceptación:**
- Solicita el número de teléfono celular del cliente.
- Abre la API de WhatsApp con un mensaje preconfigurado y enlace seguro para consultar el ticket digital.

---

### RF-51 — Consultar historial de ventas

**Descripción:** El sistema deberá proveer un listado histórico de todas las operaciones comerciales efectuadas.  
**Actor(es):** Administrador, Vendedor  
**Prioridad:** Media  
**Trazabilidad:** Caso de Uso [CU-11](diagramas_casos_de_uso/especificaciones_casos_de_uso.md) | Caso de Prueba [CP-51](casos_de_prueba.md) | DFD [P 3.0](diagramas_dfd/documentacion_dfd.md) | Calidad `RNF-04, RNF-08`

**Criterios de Aceptación:**
- Permite filtrar ventas por fecha, local comercial, vendedor y número de ticket.
- Exhibe el estado de cada transacción (Completada / Anulada).

---

### RF-52 — Consultar detalle de venta

**Descripción:** El sistema deberá permitir visualizar la composición completa de cualquier ticket del historial.  
**Actor(es):** Administrador, Vendedor  
**Prioridad:** Media  
**Trazabilidad:** Caso de Uso [CU-11](diagramas_casos_de_uso/especificaciones_casos_de_uso.md) | Caso de Prueba [CP-52](casos_de_prueba.md) | DFD [P 3.0](diagramas_dfd/documentacion_dfd.md) | Calidad `RNF-08`

**Criterios de Aceptación:**
- Despliega la ficha con prendas adquiridas, tallas, colores, precios unitarios cobrados y desglose de pago.

---

### RF-53 — Anular venta (exclusivo Admin)

**Descripción:** El sistema deberá restringir la anulación de tickets exclusivamente al rol de Administrador restituyendo el inventario.  
**Actor(es):** Administrador  
**Prioridad:** Alta  
**Trazabilidad:** Caso de Uso [CU-12](diagramas_casos_de_uso/especificaciones_casos_de_uso.md) | Caso de Prueba [CP-53](casos_de_prueba.md) | DFD [P 3.0](diagramas_dfd/documentacion_dfd.md) | Calidad `RNF-02, RNF-04`

**Criterios de Aceptación:**
- Exige el ingreso de la contraseña del Administrador y un motivo formal obligatorio de anulación.
- Marca la venta como anulada (`estado = 'ANULADA'`) y reincorpora automáticamente las prendas al stock del local.
- Registra el evento con fecha, hora y usuario en la bitácora de auditoría.

---

### RF-54 — Operar en modo offline

**Descripción:** El sistema deberá mantener operativa la terminal de venta en caso de interrupción del servicio de Internet o red local.  
**Actor(es):** Sistema (Tolerancia)  
**Prioridad:** Alta  
**Trazabilidad:** Caso de Uso [CU-10](diagramas_casos_de_uso/especificaciones_casos_de_uso.md) | Caso de Prueba [CP-54](casos_de_prueba.md) | DFD [P 3.0](diagramas_dfd/documentacion_dfd.md) | Calidad `RNF-09, RNF-14`

**Criterios de Aceptación:**
- Almacena las ventas realizadas localmente en el navegador mediante IndexedDB o Service Workers.
- Emite tickets provisionales con numeración offline diferenciada.

---

### RF-55 — Sincronizar ventas offline

**Descripción:** El sistema deberá consolidar las operaciones registradas localmente en el servidor una vez restablecida la conectividad.  
**Actor(es):** Sistema (Sincronización)  
**Prioridad:** Alta  
**Trazabilidad:** Caso de Uso [CU-10](diagramas_casos_de_uso/especificaciones_casos_de_uso.md) | Caso de Prueba [CP-55](casos_de_prueba.md) | DFD [P 3.0](diagramas_dfd/documentacion_dfd.md) | Calidad `RNF-09, RNF-10`

**Criterios de Aceptación:**
- Detecta el retorno de la conexión a Internet y envía el lote de ventas pendientes al backend central.
- Actualiza el stock en la base de datos principal y confirma la sincronización exitosa de los tickets.

---

### RF-76 — Tickets internos sin SUNAT

**Descripción:** El sistema deberá delimitar los comprobantes de venta como documentos de control interno no tributarios.  
**Actor(es):** Sistema (Diseño)  
**Prioridad:** Alta  
**Trazabilidad:** Caso de Uso [CU-09](diagramas_casos_de_uso/especificaciones_casos_de_uso.md) | Caso de Prueba [CP-76](casos_de_prueba.md) | DFD [P 3.5](diagramas_dfd/documentacion_dfd.md) | Calidad `RNF-10`

**Criterios de Aceptación:**
- Todo ticket emitido incluye obligatoriamente la leyenda: 'Comprobante de Control Interno — Sin Valor Tributario'.
- No realiza llamadas ni depende de proveedores de facturación electrónica externa.

---

## Módulo 4 — Reportes y Análisis Estratégico (RF-56 a RF-66)

### RF-56 — Reporte ventas por fechas

**Descripción:** El sistema deberá generar reportes consolidados de facturación según intervalos de tiempo especificados.  
**Actor(es):** Administrador  
**Prioridad:** Alta  
**Trazabilidad:** Caso de Uso [CU-13](diagramas_casos_de_uso/especificaciones_casos_de_uso.md) | Caso de Prueba [CP-56](casos_de_prueba.md) | DFD [P 4.0](diagramas_dfd/documentacion_dfd.md) | Calidad `RNF-08`

**Criterios de Aceptación:**
- Permite seleccionar fecha inicial y final para cuantificar transacciones y montos acumulados.
- Excluye de las cifras totales las ventas que hayan sido anuladas.

---

### RF-57 — Reporte ventas por local

**Descripción:** El sistema deberá permitir comparar el rendimiento comercial entre la tienda principal y la sucursal.  
**Actor(es):** Administrador  
**Prioridad:** Alta  
**Trazabilidad:** Caso de Uso [CU-13](diagramas_casos_de_uso/especificaciones_casos_de_uso.md) | Caso de Prueba [CP-57](casos_de_prueba.md) | DFD [P 4.0](diagramas_dfd/documentacion_dfd.md) | Calidad `RNF-08, RNF-11`

**Criterios de Aceptación:**
- Segmenta las ventas por `local_id` permitiendo evaluar la recaudación de cada tienda física.

---

### RF-58 — Reporte ventas por empleado

**Descripción:** El sistema deberá cuantificar el volumen transaccional generado por cada vendedor registrado.  
**Actor(es):** Administrador  
**Prioridad:** Media  
**Trazabilidad:** Caso de Uso [CU-13](diagramas_casos_de_uso/especificaciones_casos_de_uso.md) | Caso de Prueba [CP-58](casos_de_prueba.md) | DFD [P 4.0](diagramas_dfd/documentacion_dfd.md) | Calidad `RNF-04`

**Criterios de Aceptación:**
- Totaliza el número de operaciones y montos recaudados por colaborador para control interno.

---

### RF-59 — Identificar prendas más vendidas

**Descripción:** El sistema deberá proveer un ranking de los artículos con mayor rotación en el negocio.  
**Actor(es):** Administrador  
**Prioridad:** Alta  
**Trazabilidad:** Caso de Uso [CU-14](diagramas_casos_de_uso/especificaciones_casos_de_uso.md) | Caso de Prueba [CP-59](casos_de_prueba.md) | DFD [P 4.0](diagramas_dfd/documentacion_dfd.md) | Calidad `RNF-08`

**Criterios de Aceptación:**
- Exhibe el Top 10 de prendas con mayor cantidad de unidades despachadas en un período dado.

---

### RF-60 — Identificar prendas baja rotación

**Descripción:** El sistema deberá detectar los productos estancados con escaso o nulo movimiento en inventario.  
**Actor(es):** Administrador  
**Prioridad:** Media  
**Trazabilidad:** Caso de Uso [CU-14](diagramas_casos_de_uso/especificaciones_casos_de_uso.md) | Caso de Prueba [CP-60](casos_de_prueba.md) | DFD [P 4.0](diagramas_dfd/documentacion_dfd.md) | Calidad `RNF-08`

**Criterios de Aceptación:**
- Identifica prendas con saldo positivo que no hayan registrado ventas en los últimos 30 o 60 días.
- Facilita la planificación de liquidaciones, descuentos o reubicación de mercadería.

---

### RF-61 — Reporte de ingresos totales

**Descripción:** El sistema deberá computar la recaudación financiera bruta y neta acumulada en moneda nacional (PEN).  
**Actor(es):** Administrador  
**Prioridad:** Alta  
**Trazabilidad:** Caso de Uso [CU-13](diagramas_casos_de_uso/especificaciones_casos_de_uso.md) | Caso de Prueba [CP-61](casos_de_prueba.md) | DFD [P 4.0](diagramas_dfd/documentacion_dfd.md) | Calidad `RNF-08`

**Criterios de Aceptación:**
- Calcula ingresos totales descontando operaciones canceladas y devoluciones.

---

### RF-62 — Filtrar por categoría y marca

**Descripción:** El sistema deberá permitir desglosar las estadísticas de venta combinando categorías y marcas de ropa.  
**Actor(es):** Administrador  
**Prioridad:** Media  
**Trazabilidad:** Caso de Uso [CU-13](diagramas_casos_de_uso/especificaciones_casos_de_uso.md) | Caso de Prueba [CP-62](casos_de_prueba.md) | DFD [P 4.0](diagramas_dfd/documentacion_dfd.md) | Calidad `RNF-08`

**Criterios de Aceptación:**
- Permite analizar qué marcas y tipos de prendas generan la mayor rentabilidad.

---

### RF-63 — Exportar reportes a PDF

**Descripción:** El sistema deberá permitir la descarga formal de cualquier reporte analítico en documento PDF.  
**Actor(es):** Administrador  
**Prioridad:** Media  
**Trazabilidad:** Caso de Uso [CU-14](diagramas_casos_de_uso/especificaciones_casos_de_uso.md) | Caso de Prueba [CP-63](casos_de_prueba.md) | DFD [P 4.0](diagramas_dfd/documentacion_dfd.md) | Calidad `RNF-05`

**Criterios de Aceptación:**
- Genera un archivo PDF maquetado con membrete del negocio, parámetros de consulta, tablas y totales.

---

### RF-64 — Exportar reportes a Excel

**Descripción:** El sistema deberá permitir la exportación de datos crudos a hojas de cálculo `.xlsx` para auditoría externa.  
**Actor(es):** Administrador  
**Prioridad:** Media  
**Trazabilidad:** Caso de Uso [CU-14](diagramas_casos_de_uso/especificaciones_casos_de_uso.md) | Caso de Prueba [CP-64](casos_de_prueba.md) | DFD [P 4.0](diagramas_dfd/documentacion_dfd.md) | Calidad `RNF-05`

**Criterios de Aceptación:**
- Genera un archivo Excel estructurado en celdas numéricas para análisis contable y financiero.

---

### RF-65 — Panel gráfico de control

**Descripción:** El sistema deberá presentar visualizaciones gráficas interactivas del comportamiento de ventas.  
**Actor(es):** Administrador  
**Prioridad:** Media  
**Trazabilidad:** Caso de Uso [CU-13](diagramas_casos_de_uso/especificaciones_casos_de_uso.md) | Caso de Prueba [CP-65](casos_de_prueba.md) | DFD [P 4.0](diagramas_dfd/documentacion_dfd.md) | Calidad `RNF-05, RNF-08`

**Criterios de Aceptación:**
- Renderiza gráficos de barras y líneas temporales (mediante Chart.js o Recharts) de ingresos y unidades en < 3 segundos.

---

### RF-66 — Comparativo entre locales

**Descripción:** El sistema deberá generar visualizaciones comparativas directas entre el Local 1 y Local 2.  
**Actor(es):** Administrador  
**Prioridad:** Media  
**Trazabilidad:** Caso de Uso [CU-13](diagramas_casos_de_uso/especificaciones_casos_de_uso.md) | Caso de Prueba [CP-66](casos_de_prueba.md) | DFD [P 4.0](diagramas_dfd/documentacion_dfd.md) | Calidad `RNF-11`

**Criterios de Aceptación:**
- Presenta gráficos enfrentados de ingresos mensuales y rotación de stock entre ambas sucursales.

---

## Módulo 5 — Catálogo Digital Web Público (RF-67 a RF-72)

### RF-67 — Catálogo público sin login

**Descripción:** El sistema deberá permitir a los clientes acceder a la vitrina virtual de prendas masculinas sin autenticación.  
**Actor(es):** Visitante Web  
**Prioridad:** Alta  
**Trazabilidad:** Caso de Uso [CU-15](diagramas_casos_de_uso/especificaciones_casos_de_uso.md) | Caso de Prueba [CP-67](casos_de_prueba.md) | DFD [P 5.0](diagramas_dfd/documentacion_dfd.md) | Calidad `RNF-05`

**Criterios de Aceptación:**
- Permite la navegación pública y libre por la galería de prendas sin requerir registro ni contraseñas.
- Protege los datos internos de costos y márgenes de ganancia exhibiendo únicamente precio de venta al público.

---

### RF-68 — Filtrar por categoría, talla y color

**Descripción:** El sistema deberá ofrecer a los clientes web filtros de búsqueda intuitivos para encontrar prendas de su interés.  
**Actor(es):** Visitante Web  
**Prioridad:** Alta  
**Trazabilidad:** Caso de Uso [CU-15](diagramas_casos_de_uso/especificaciones_casos_de_uso.md) | Caso de Prueba [CP-68](casos_de_prueba.md) | DFD [P 5.0](diagramas_dfd/documentacion_dfd.md) | Calidad `RNF-05, RNF-08`

**Criterios de Aceptación:**
- Permite seleccionar simultáneamente categoría, talla y color actualizando la vitrina en tiempo real.

---

### RF-69 — Ficha de prenda con fotos HD

**Descripción:** El sistema deberá presentar una vista detallada con fotografías en alta definición y especificaciones de cada prenda.  
**Actor(es):** Visitante Web  
**Prioridad:** Alta  
**Trazabilidad:** Caso de Uso [CU-15](diagramas_casos_de_uso/especificaciones_casos_de_uso.md) | Caso de Prueba [CP-69](casos_de_prueba.md) | DFD [P 5.0](diagramas_dfd/documentacion_dfd.md) | Calidad `RNF-08`

**Criterios de Aceptación:**
- Al hacer clic en un artículo se abre la ficha con fotos de alta resolución, descripción, marca, composición y precio.

---

### RF-70 — Disponibilidad física por tienda

**Descripción:** El sistema deberá informar al cliente en cuál de los dos locales físicos se encuentra disponible la prenda deseada.  
**Actor(es):** Visitante Web  
**Prioridad:** Alta  
**Trazabilidad:** Caso de Uso [CU-15](diagramas_casos_de_uso/especificaciones_casos_de_uso.md) | Caso de Prueba [CP-70](casos_de_prueba.md) | DFD [P 5.0](diagramas_dfd/documentacion_dfd.md) | Calidad `RNF-11`

**Criterios de Aceptación:**
- Indica claramente en la ficha web si existe stock disponible en **Local 1** y/o en **Local 2**.
- Evita que el cliente acuda a una tienda física donde la prenda de su talla se encuentre agotada.

---

### RF-71 — Compartir ficha de prenda

**Descripción:** El sistema deberá facilitar la difusión de prendas a través de redes sociales y mensajería.  
**Actor(es):** Visitante Web  
**Prioridad:** Media  
**Trazabilidad:** Caso de Uso [CU-15](diagramas_casos_de_uso/especificaciones_casos_de_uso.md) | Caso de Prueba [CP-71](casos_de_prueba.md) | DFD [P 5.0](diagramas_dfd/documentacion_dfd.md) | Calidad `RNF-14`

**Criterios de Aceptación:**
- Incluye botón directo para compartir la ficha técnica de la prenda por WhatsApp con imagen y enlace.
- Configura etiquetas OpenGraph para previsualizaciones enriquecidas en plataformas digitales.

---

### RF-72 — Aplicación web responsiva

**Descripción:** El sistema deberá adaptar su interfaz con fidelidad en dispositivos móviles, tablets y computadoras de escritorio.  
**Actor(es):** Visitante Web, Todos  
**Prioridad:** Alta  
**Trazabilidad:** Caso de Uso [CU-15](diagramas_casos_de_uso/especificaciones_casos_de_uso.md) | Caso de Prueba [CP-72](casos_de_prueba.md) | DFD [P 5.0](diagramas_dfd/documentacion_dfd.md) | Calidad `RNF-06, RNF-13`

**Criterios de Aceptación:**
- Sigue la metodología Mobile-first garantizando usabilidad táctil fluida en pantallas desde 360 px de ancho.
- Optimiza la carga de imágenes y recursos para conexiones móviles de datos.

---
