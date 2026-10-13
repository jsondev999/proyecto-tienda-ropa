# Épica 06: Directorio Comercial (Clientes y Proveedores)

> **Módulo:** Contactos Comerciales  
> **Requisitos Trazables:** `RF-15`, `RF-16`  
> **Paquete EDT Relacionado:** `1.3.3.6 Módulo Directorio Comercial (Clientes y Proveedores)`  

---

## Historia de Usuario: HU-15
### Título: Directorio y Búsqueda Rápida de Clientes en POS

| Atributo | Detalle |
|---|---|
| **Identificador** | `HU-15` |
| **Rol Principal** | Vendedor / Administrador |
| **Prioridad MoSCoW** | **SHOULD HAVE** |
| **Estimación** | 3 Story Points |
| **Sprint Sugerido** | Sprint 3 |
| **Dependencias** | HU-09 |

### 1. Narrativa
```text
Como Vendedor,
Quiero buscar un cliente por su DNI/RUC o registrarlo rápidamente desde la pantalla de cobro sin perder el carrito de ventas,
Para asociar la venta al comprador, permitir la emisión de comprobante personalizado y acumular historial comercial.
```

### 2. Criterios de Aceptación (Gherkin)

#### Escenario 1: Búsqueda y selección instantánea de cliente registrado
* **Dado** que el cajero se encuentra en el flujo de cobro del POS,
* **Cuando** tipea los primeros dígitos del documento `72948192` o el apellido del cliente,
* **Entonces** el sistema autocompleta los datos del cliente (Nombres, DNI, Teléfono),
* **Y** lo asocia a la venta en curso sin interrumpir el flujo.

#### Escenario 2: Registro rápido de nuevo cliente sin recargar la página
* **Dado** que un nuevo cliente no figura en el sistema,
* **Cuando** el cajero presiona "Nuevo Cliente", ingresa DNI de 8 dígitos y nombre completo,
* **Entonces** el sistema valida el formato del documento, lo guarda en la base de datos `clientes` y lo deja seleccionado inmediatamente en el POS.

#### Escenario 3: Opción predeterminada "Cliente Varios"
* **Dado** que el comprador no desea brindar sus datos personales,
* **Cuando** se procesa la venta,
* **Entonces** el sistema asigna por defecto el registro maestro `Clientes Varios (DNI 00000000)`, permitiendo continuar sin fricciones.

### 3. Consideraciones Técnicas (Clean Architecture + CQRS)
* **Dominio:** Entidad `Cliente` (Id, TipoDocumento, NumeroDocumento, Nombres, Apellidos, Telefono, Email). Value Object `DocumentoIdentidad`.
* **Aplicación:**
  - Command: `RegistrarClienteCommand(string NumeroDocumento, string Nombres, string Apellidos, string Telefono)`.
  - Query: `BuscarClientePorDocumentoQuery(string Termino)`.
* **Infraestructura:** Búsqueda indexada por `numero_documento`.
* **Presentación:** Componente autocompletado con modal flotante de registro express.

---

## Historia de Usuario: HU-16
### Título: Directorio y Mantenimiento de Proveedores

| Atributo | Detalle |
|---|---|
| **Identificador** | `HU-16` |
| **Rol Principal** | Administrador |
| **Prioridad MoSCoW** | **COULD HAVE** |
| **Estimación** | 3 Story Points |
| **Sprint Sugerido** | Sprint 3 |
| **Dependencias** | HU-01, HU-02 |

### 1. Narrativa
```text
Como Administrador,
Quiero administrar la información de los proveedores textiles y marcas mayoristas (RUC, Razón Social, Contacto, Teléfono),
Para vincularlos formalmente a las órdenes de compra y mantener organizado el directorio de abastecimiento.
```

### 2. Criterios de Aceptación (Gherkin)

#### Escenario 1: Registro de proveedor con RUC válido
* **Dado** que el Administrador accede al mantenimiento de proveedores,
* **Cuando** registra un nuevo proveedor con RUC de 11 dígitos numéricos y Razón Social válida,
* **Entonces** el sistema valida la unicidad del RUC y guarda el proveedor con estado "Activo".

#### Escenario 2: Prevención de RUC duplicado
* **Dado** que ya existe un proveedor registrado con el RUC `20601234567`,
* **Cuando** se intenta registrar otro con el mismo número,
* **Entonces** el sistema bloquea el guardado advirtiendo *"El proveedor con dicho RUC ya se encuentra registrado"*.

### 3. Consideraciones Técnicas (Clean Architecture + CQRS)
* **Dominio:** Entidad `Proveedor` (Id, Ruc, RazonSocial, ContactoNombre, Telefono, Email, Direccion, Activo).
* **Aplicación:**
  - Command: `CrearProveedorCommand`, `ActualizarProveedorCommand`.
  - Query: `GetProveedoresActivosQuery()`.
* **Infraestructura:** Índice único `UNIQUE KEY (ruc)`.
* **Presentación:** Vista CRUD limpia con filtros y botón de exportación.
