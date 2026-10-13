# Requisitos No Funcionales

**Proyecto:** Sistema de Gestión — Tienda de Ropa para Varón  
**Versión:** 2.0  
**Fecha:** 12/10/2026  

---

## Índice de Categorías

1. [Seguridad](#seguridad)
2. [Usabilidad](#usabilidad)
3. [Rendimiento y Disponibilidad](#rendimiento-y-disponibilidad)
4. [Escalabilidad](#escalabilidad)

---

## Seguridad

> Requisitos que garantizan la protección de los datos, el acceso controlado y la integridad de la información del sistema.

---

### NF-01 — Copias de seguridad automáticas

**Descripción:** El sistema deberá realizar copias de seguridad automáticas de forma mensual, programando un backup completo de toda la información al final de cada mes.  
**Prioridad:** Media

**Criterios de Verificación:**
- El sistema genera un backup automático el último día de cada mes sin intervención manual.
- Los backups se almacenan en una ubicación segura y accesible por el administrador.
- El proceso de backup no interrumpe el funcionamiento normal del sistema.

---

### NF-02 — Control de acceso basado en roles

**Descripción:** El sistema deberá implementar niveles de acceso diferenciados según el rol del usuario (administrador vs. empleado), restringiendo las operaciones sensibles solo al administrador.  
**Prioridad:** Alta

**Criterios de Verificación:**
- El administrador tiene acceso completo a todas las funcionalidades del sistema.
- El empleado solo puede acceder a las funciones de registro de ventas y consulta de inventario.
- El sistema rechaza cualquier intento del empleado de acceder a funciones restringidas.

---

### NF-03 — Encriptación de contraseñas

**Descripción:** Las contraseñas de los usuarios deberán almacenarse de forma encriptada en la base de datos, nunca en texto plano.  
**Prioridad:** Alta

**Criterios de Verificación:**
- Las contraseñas se almacenan usando un algoritmo de hashing seguro (ej. bcrypt).
- No es posible recuperar la contraseña original a partir de la base de datos.
- Al cambiar la contraseña, el hash anterior se invalida inmediatamente.

---

### NF-04 — Trazabilidad de operaciones

**Descripción:** Toda operación crítica del sistema (ventas, ajustes de inventario, transferencias, modificaciones de productos) deberá quedar registrada con el usuario, fecha y hora que la realizó.  
**Prioridad:** Media

**Criterios de Verificación:**
- El sistema mantiene un log de auditoría de todas las operaciones sensibles.
- El log es consultable por el administrador en cualquier momento.
- Los registros del log no pueden ser eliminados ni modificados por ningún usuario.

---

## Usabilidad

> Requisitos que aseguran que el sistema sea fácil de aprender, operar y usar por los distintos tipos de usuarios.

---

### NF-05 — Interfaz intuitiva y fácil de usar

**Descripción:** El sistema deberá contar con una interfaz de usuario intuitiva y fácil de usar, que no requiera capacitación técnica extensa para el personal del negocio.  
**Prioridad:** Alta

**Criterios de Verificación:**
- Un empleado nuevo puede completar el registro de una venta sin asistencia tras una capacitación inicial breve.
- Los menús y acciones principales son accesibles con no más de 3 clics desde la pantalla principal.
- Los mensajes del sistema (errores, confirmaciones, alertas) son claros y comprensibles para usuarios no técnicos.

---

### NF-06 — Diseño adaptable para móvil

**Descripción:** El sistema deberá estar optimizado para su uso en dispositivos móviles, adaptando su interfaz a distintos tamaños de pantalla.  
**Prioridad:** Alta

**Criterios de Verificación:**
- La interfaz se visualiza correctamente en smartphones y tablets con pantallas desde 4 pulgadas.
- Los elementos interactivos (botones, campos de texto) tienen un tamaño adecuado para su uso táctil.
- No se requiere zoom para leer o interactuar con el contenido en pantalla móvil.

---

### NF-07 — Mensajes de retroalimentación claros

**Descripción:** El sistema deberá proporcionar mensajes de retroalimentación inmediata ante cualquier acción del usuario, tanto en caso de éxito como de error.  
**Prioridad:** Media

**Criterios de Verificación:**
- Toda acción completada exitosamente muestra un mensaje de confirmación visible.
- Todos los errores muestran un mensaje descriptivo que indica la causa y cómo resolverla.
- Los mensajes desaparecen automáticamente tras un tiempo prudente o con interacción del usuario.

---

## Rendimiento y Disponibilidad

> Requisitos que garantizan la estabilidad operativa, la velocidad de respuesta y la continuidad del servicio del sistema.

---

### NF-08 — Estabilidad del sistema

**Descripción:** El sistema deberá priorizar la estabilidad, manteniéndose operativo de forma continua sin caídas inesperadas durante el horario comercial.  
**Prioridad:** Alta

**Criterios de Verificación:**
- El sistema no presenta caídas no planificadas durante el horario de operación del negocio.
- En caso de fallo, el sistema se recupera automáticamente sin pérdida de datos.
- Los errores críticos quedan registrados para diagnóstico posterior.

---

### NF-09 — Funcionamiento sin conexión a internet

**Descripción:** El sistema deberá operar de forma local sin requerir conexión a internet para las funcionalidades principales (registro de ventas e inventario).  
**Prioridad:** Alta

**Criterios de Verificación:**
- El registro de ventas y la gestión de inventario funcionan correctamente sin conexión activa a internet.
- Los datos generados offline se almacenan localmente de forma íntegra.
- El sistema detecta automáticamente cuando se restaura la conexión y reanuda la sincronización.

---

### NF-10 — Sincronización automática con la nube

**Descripción:** El sistema deberá sincronizar los datos locales con la nube de forma automática al recuperarse la conexión a internet, sin pérdida de información.  
**Prioridad:** Alta

**Criterios de Verificación:**
- La sincronización se inicia automáticamente al detectar conexión disponible.
- Los datos registrados offline se sincronizan en el orden correcto y sin duplicados.
- El sistema muestra el estado de la sincronización (pendiente, en proceso, completada) de forma visible.

---

### NF-11 — Tiempo de respuesta aceptable

**Descripción:** El sistema deberá responder a las acciones del usuario en un tiempo razonable que no afecte la operación del negocio.  
**Prioridad:** Media

**Criterios de Verificación:**
- Las consultas de inventario y registro de ventas se completan en menos de 3 segundos en condiciones normales.
- La carga inicial del sistema no supera los 5 segundos en dispositivos compatibles.
- Los reportes se generan en menos de 10 segundos para periodos de hasta 12 meses de datos.

---

## Escalabilidad

> Requisitos que aseguran que el sistema pueda crecer y adaptarse a las necesidades futuras del negocio.

---

### NF-12 — Soporte para múltiples tiendas

**Descripción:** El sistema deberá estar diseñado para soportar la gestión de más de dos locales en el futuro, sin necesidad de rediseño estructural.  
**Prioridad:** Media

**Criterios de Verificación:**
- La arquitectura del sistema permite agregar nuevas sucursales sin modificar el código base.
- La adición de un nuevo local no afecta el funcionamiento de los locales existentes.

---

### NF-13 — Escalabilidad del catálogo de productos

**Descripción:** El sistema deberá permitir registrar un número creciente de productos en el inventario sin degradación del rendimiento.  
**Prioridad:** Media

**Criterios de Verificación:**
- El sistema mantiene tiempos de respuesta aceptables con catálogos de hasta 10,000 productos registrados.
- La búsqueda y consulta de productos no se ve afectada significativamente al aumentar el volumen del catálogo.

---

### NF-14 — Extensibilidad de integraciones externas

**Descripción:** El sistema deberá estar diseñado para facilitar la integración con nuevas plataformas de venta online o medios de pago en el futuro.  
**Prioridad:** Baja

**Criterios de Verificación:**
- La arquitectura contempla puntos de integración estándar (APIs) para conectar nuevas plataformas.
- Agregar una nueva integración no requiere modificaciones extensas en el núcleo del sistema.

---
