# Especificación de Necesidades del Negocio y de Usuario

**Proyecto:** Sistema de Gestión — Tienda de Ropa para Varón  
**Versión:** 2.0  
**Fecha:** 13/10/2026  

---

## 📋 1. Catálogo General de Necesidades de Negocio

| ID | Nombre de la Necesidad | Actor Principal | Módulo de Negocio Relacionado |
|---|---|---|---|
| **N-01** | Control de acceso seguro y diferenciado | Administrador / Vendedor | M1 — Autenticación y Seguridad |
| **N-02** | Administración centralizada de usuarios | Administrador | M1 — Autenticación y Seguridad |
| **N-03** | Estandarización de atributos de prendas | Administrador | M2 — Gestión de Inventario |
| **N-04** | Control y abastecimiento de stock multisede | Administrador / Vendedor | M2 — Gestión de Inventario |
| **N-05** | Búsqueda ágil de prendas en mostrador | Vendedor | M2 — Gestión de Inventario |
| **N-06** | Procesamiento rápido de transacciones comerciales | Vendedor | M3 — Registro de Ventas |
| **N-07** | Emisión y respaldo de comprobantes internos | Vendedor / Cliente | M3 — Registro de Ventas |
| **N-08** | Continuidad operativa ante caídas de red | Vendedor | M3 — Registro de Ventas |
| **N-09** | Análisis gerencial del rendimiento comercial | Administrador | M4 — Reportes y Análisis |
| **N-10** | Exposición pública y digital de productos | Cliente / Administrador | M5 — Catálogo Digital Web |

---

## 🔍 2. Detalle y Desglose de Necesidades de Negocio

---

### N-01 — Control de acceso seguro y diferenciado

* **Declaración:** El personal de la tienda (Administrador y Vendedor) necesita acceder al sistema mediante credenciales personales y roles diferenciados para proteger la información comercial sensible y evitar operaciones no autorizadas.

#### Desglose de Elementos:
| Elemento | Contenido |
|---|---|
| **Actor/Interesado** | Administrador y Vendedor |
| **Necesidad** | Identificarse y acceder de manera segura mediante roles |
| **Objeto** | Módulos del sistema de gestión comercial |
| **Propósito** | Proteger la confidencialidad de la información y prevenir operaciones no autorizadas |

#### Árbol de Derivación:
```text
N-01
│
├── RF-01 Solicitar nombre de usuario
├── RF-02 Solicitar contraseña
├── RF-03 Autenticar usuario
├── RF-04 Validar credenciales
├── RF-05 Denegar acceso con credenciales incorrectas
├── RF-06 Bloquear cuenta por intentos fallidos
├── RF-07 Asignar roles (Administrador y Vendedor)
├── RF-08 Restringir funciones según rol
├── RF-09 Cerrar sesión de usuario
│
├── RNF-02 Control de acceso basado en roles
├── RNF-03 Encriptación de contraseñas
└── RNF-04 Auditoría y trazabilidad de operaciones
```

---

### N-02 — Administración centralizada de usuarios y cuentas

* **Declaración:** El Administrador de la tienda necesita gestionar el ciclo de vida de las cuentas de usuario y restablecer contraseñas de forma centralizada para garantizar que solo los colaboradores activos tengan acceso operativo.

#### Desglose de Elementos:
| Elemento | Contenido |
|---|---|
| **Actor/Interesado** | Administrador |
| **Necesidad** | Crear, listar, suspender y restablecer credenciales de usuarios |
| **Objeto** | Cuentas de acceso de los colaboradores |
| **Propósito** | Mantener el control administrativo del personal con acceso al sistema |

#### Árbol de Derivación:
```text
N-02
│
├── RF-10 Crear nuevo usuario
├── RF-11 Listar usuarios registrados
├── RF-12 Modificar datos de usuario
├── RF-13 Desactivar cuenta de usuario
├── RF-14 Desbloquear cuenta de usuario
├── RF-73 Gestión y restablecimiento de contraseñas por Administrador
│
├── RNF-02 Control de acceso basado en roles
└── RNF-04 Registro de auditoría
```

---

### N-03 — Estandarización de atributos y catálogo maestro de prendas

* **Declaración:** El Administrador necesita administrar catálogos maestros controlados de marcas, tallas, colores y categorías para evitar inconsistencias de datos por texto libre y uniformizar la clasificación de la ropa masculina.

#### Desglose de Elementos:
| Elemento | Contenido |
|---|---|
| **Actor/Interesado** | Administrador |
| **Necesidad** | Gestionar y parametrizar catálogos maestros cerrados |
| **Objeto** | Atributos de prendas (categorías, tallas, colores, marcas) |
| **Propósito** | Garantizar la integridad de los datos y evitar registros duplicados o ambiguos |

#### Árbol de Derivación:
```text
N-03
│
├── RF-26 Registrar categoría
├── RF-27 Modificar categoría
├── RF-28 Eliminar categoría
├── RF-29 Registrar talla
├── RF-30 Modificar talla
├── RF-31 Registrar color
├── RF-32 Modificar color
├── RF-33 Registrar marca
├── RF-34 Modificar marca
├── RF-74 Catálogos maestros de prendas gestionados por Administrador
│
├── RNF-04 Integridad de datos y trazabilidad
└── RNF-14 Modularidad del sistema
```

---

### N-04 — Control y abastecimiento de existencias multisede

* **Declaración:** El Administrador y los Vendedores necesitan monitorear el stock de prendas discriminado por cada uno de los dos locales comerciales para prevenir desabastecimientos y coordinar traslados oportunamente.

#### Desglose de Elementos:
| Elemento | Contenido |
|---|---|
| **Actor/Interesado** | Administrador y Vendedores de cada local |
| **Necesidad** | Monitorear existencias físicas en tiempo real por sucursal |
| **Objeto** | Niveles de stock de prendas masculinas por local comercial |
| **Propósito** | Evitar quiebres de stock y facilitar la reposición inteligente de mercadería |

#### Árbol de Derivación:
```text
N-04
│
├── RF-15 Registrar prenda
├── RF-16 Modificar prenda
├── RF-17 Eliminar prenda
├── RF-18 Consultar prenda por código o nombre
├── RF-19 Registrar stock inicial por local
├── RF-20 Actualizar stock por ingreso o ajuste
├── RF-21 Descontar stock automáticamente tras venta
├── RF-22 Consultar stock disponible por local
├── RF-23 Emitir alertas visuales de bajo stock
├── RF-24 Configurar umbral de stock mínimo por prenda
├── RF-25 Notificar al administrador cuando el stock sea crítico
├── RF-77 Alertas automáticas de reposición por local
│
├── RNF-08 Tiempo de respuesta óptimo (< 2 segundos)
├── RNF-09 Disponibilidad de inventario (99.5%)
└── RNF-11 Soporte nativo para múltiples sucursales
```

---

### N-05 — Búsqueda ágil de prendas en mostrador

* **Declaración:** El Vendedor necesita buscar y filtrar prendas rápidamente por múltiples criterios simultáneos (talla, color, marca, local) para atender a los clientes con rapidez en el punto de atención.

#### Desglose de Elementos:
| Elemento | Contenido |
|---|---|
| **Actor/Interesado** | Vendedor |
| **Necesidad** | Localizar prendas y consultar disponibilidad mediante filtros combinables |
| **Objeto** | Catálogo interno de prendas e inventario disponible |
| **Propósito** | Reducir el tiempo de espera del cliente en el local comercial |

#### Árbol de Derivación:
```text
N-05
│
├── RF-35 Búsqueda de prendas en tiempo real
├── RF-36 Filtrar prendas por categoría
├── RF-37 Filtrar prendas por talla
├── RF-38 Filtrar prendas por marca
├── RF-39 Filtrar prendas por rango de precio
├── RF-75 Filtros dinámicos y combinables en inventario
│
├── RNF-05 Interfaz intuitiva y accesible
└── RNF-08 Tiempo de respuesta en búsquedas (< 2 segundos)
```

---

### N-06 — Procesamiento rápido de transacciones comerciales en caja

* **Declaración:** El Vendedor necesita registrar las ventas del mostrador admitiendo diversos medios de pago (efectivo, tarjetas, billeteras digitales) para agilizar el cobro y mantener el cuadre de caja preciso.

#### Desglose de Elementos:
| Elemento | Contenido |
|---|---|
| **Actor/Interesado** | Vendedor |
| **Necesidad** | Registrar cobros y asociar medios de pago |
| **Objeto** | Carrito de venta, precios, descuentos y medios de pago |
| **Propósito** | Maximizar la velocidad de cobro y asegurar la exactitud de los ingresos |

#### Árbol de Derivación:
```text
N-06
│
├── RF-40 Iniciar nueva venta
├── RF-41 Agregar prendas a la venta
├── RF-42 Modificar cantidad de prendas en venta
├── RF-43 Eliminar prenda de la venta en curso
├── RF-44 Calcular subtotal, descuento e importe total
├── RF-45 Seleccionar medio de pago (efectivo, tarjeta, billetera digital)
├── RF-46 Registrar cobro con importe recibido y cambio
├── RF-47 Confirmar y registrar la venta en el sistema
│
├── RNF-05 Usabilidad y facilidad de operación
└── RNF-08 Procesamiento de transacción en menos de 2 segundos
```

---

### N-07 — Emisión y respaldo de comprobantes de venta internos

* **Declaración:** El Vendedor y el Cliente necesitan contar con un ticket digital interno de venta para sustentar la transacción comercial de forma digital o impresa sin incurrir en complejidades tributarias externas.

#### Desglose de Elementos:
| Elemento | Contenido |
|---|---|
| **Actor/Interesado** | Vendedor y Cliente |
| **Necesidad** | Generar, emitir y consultar comprobantes internos de venta |
| **Objeto** | Ticket digital interno de venta con detalle de prendas y local |
| **Propósito** | Brindar transparencia al comprador y conservar el respaldo auditable de la venta |

#### Árbol de Derivación:
```text
N-07
│
├── RF-48 Generar ticket digital de venta automáticamente
├── RF-49 Imprimir ticket digital en impresora térmica o PDF
├── RF-50 Enviar ticket digital por correo electrónico o WhatsApp
├── RF-51 Consultar historial de ventas registradas
├── RF-52 Consultar detalle de una venta específica
├── RF-53 Anular venta por motivo justificado (exclusivo Administrador)
├── RF-76 Historial completo y auditable de tickets digitales
│
├── RNF-01 Copias de seguridad automáticas
├── RNF-04 Registro de auditoría y trazabilidad
└── RNF-10 Integridad y almacenamiento de transacciones
```

---

### N-08 — Continuidad operativa ante caídas o inestabilidad de red

* **Declaración:** El Vendedor necesita continuar registrando ventas en mostrador aun cuando falle temporalmente la conexión a Internet para no detener la atención comercial física.

#### Desglose de Elementos:
| Elemento | Contenido |
|---|---|
| **Actor/Interesado** | Vendedor |
| **Necesidad** | Operar la venta en modo local/desconectado temporal |
| **Objeto** | Datos de la venta en curso y cola de sincronización |
| **Propósito** | Garantizar la continuidad del negocio ante contingencias de conectividad |

#### Árbol de Derivación:
```text
N-08
│
├── RF-54 Operar en modo offline temporal para ventas
├── RF-55 Sincronizar automáticamente ventas offline al restablecer conexión
│
├── RNF-08 Tiempo de respuesta local
├── RNF-09 Disponibilidad y tolerancia a fallos
└── RNF-14 Arquitectura modular y desacoplada
```

---

### N-09 — Análisis gerencial del rendimiento comercial

* **Declaración:** El Administrador (dueño de la tienda) necesita generar reportes analíticos de ventas por período, prenda, colaborador y local para tomar decisiones de compra de mercadería y estrategias de precios.

#### Desglose de Elementos:
| Elemento | Contenido |
|---|---|
| **Actor/Interesado** | Administrador |
| **Necesidad** | Consolidar datos de ventas e inventario en indicadores gerenciales |
| **Objeto** | Reportes consolidados, gráficos y exportables (PDF / Excel) |
| **Propósito** | Fundamentar la toma de decisiones empresariales con base en datos históricos |

#### Árbol de Derivación:
```text
N-09
│
├── RF-56 Generar reporte de ventas por rango de fechas
├── RF-57 Generar reporte de ventas por local comercial
├── RF-58 Generar reporte de ventas por empleado / vendedor
├── RF-59 Identificar prendas más vendidas (ranking top)
├── RF-60 Identificar prendas con menor rotación
├── RF-61 Generar reporte de ingresos totales por período
├── RF-62 Filtrar reportes por categoría y marca
├── RF-63 Exportar reportes en formato PDF
├── RF-64 Exportar reportes en formato Excel (.xlsx)
├── RF-65 Visualizar métricas en panel gráfico de control
├── RF-66 Consultar comparativo de ventas entre locales
│
├── RNF-08 Generación de reportes en tiempo óptimo (< 5 segundos)
├── RNF-10 Capacidad analítica de datos
└── RNF-12 Mantenibilidad y extensibilidad
```

---

### N-10 — Exposición pública y digital de productos

* **Declaración:** Los Clientes finales necesitan explorar las prendas disponibles, sus fotos, tallas, colores y precios desde un navegador web sin necesidad de registrarse para decidir su compra previa a la visita del local.

#### Desglose de Elementos:
| Elemento | Contenido |
|---|---|
| **Actor/Interesado** | Cliente (Público General) |
| **Necesidad** | Navegar por el catálogo digital público de prendas masculinas |
| **Objeto** | Galería web de productos, fotos, descripción, tallas y locales |
| **Propósito** | Incrementar la visibilidad del negocio y atraer clientes a los locales físicos |

#### Árbol de Derivación:
```text
N-10
│
├── RF-67 Visualizar catálogo público sin necesidad de autenticación
├── RF-68 Filtrar catálogo público por categoría, talla y color
├── RF-69 Consultar detalle de prenda con imágenes de alta resolución
├── RF-70 Consultar disponibilidad referencial por local físico
├── RF-71 Compartir ficha de prenda mediante enlace o redes
├── RF-72 Aplicación web responsiva multiplataforma (móvil, tablet, PC)
│
├── RNF-05 Usabilidad y diseño intuitivo para el consumidor
├── RNF-06 Diseño 100% responsivo para dispositivos móviles
├── RNF-08 Carga rápida de imágenes y catálogo (< 3 segundos)
└── RNF-13 Compatibilidad total con navegadores modernos
```

---

## 📊 3. Matriz de Cobertura de Necesidades vs. Módulos

Esta matriz verifica que el 100% del alcance funcional del sistema responda directamente a una necesidad legítima del negocio:

| Módulo del Sistema | Necesidades que lo justifican | Total RF Derivados |
|---|---|:---:|
| **M1: Autenticación y Seguridad** | N-01, N-02 | 15 RFs (RF-01 a RF-14, RF-73) |
| **M2: Gestión de Inventario** | N-03, N-04, N-05 | 27 RFs (RF-15 a RF-39, RF-74, RF-75, RF-77) |
| **M3: Registro de Ventas** | N-06, N-07, N-08 | 17 RFs (RF-40 a RF-55, RF-76) |
| **M4: Reportes y Análisis** | N-09 | 11 RFs (RF-56 a RF-66) |
| **M5: Catálogo Digital Web** | N-10 | 6 RFs (RF-67 a RF-72) |
| **Total Global** | **10 Necesidades** | **77 Requisitos Funcionales** |
