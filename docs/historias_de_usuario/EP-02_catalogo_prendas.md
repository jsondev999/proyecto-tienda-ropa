# Épica 02: Catálogo Maestro y Variantes de Prendas

> **Módulo:** Catálogo y Productos  
> **Requisitos Trazables:** `RF-03`, `RF-04`, `RF-05`  
> **Paquete EDT Relacionado:** `1.3.3.2 Módulo Catálogo Maestro y Variantes de Ropa`  

---

## Historia de Usuario: HU-03
### Título: Gestión de Marcas y Categorías Maestras

| Atributo | Detalle |
|---|---|
| **Identificador** | `HU-03` |
| **Rol Principal** | Administrador |
| **Prioridad MoSCoW** | **MUST HAVE** |
| **Estimación** | 3 Story Points |
| **Sprint Sugerido** | Sprint 1 |
| **Dependencias** | HU-01, HU-02 |

### 1. Narrativa
```text
Como Administrador de la tienda de ropa,
Quiero crear, editar y consultar las marcas comerciales y categorías de prendas (Polos, Pantalones, Casacas, etc.),
Para organizar jerárquicamente el catálogo de productos y facilitar la búsqueda de artículos por parte del personal de ventas.
```

### 2. Criterios de Aceptación (Gherkin)

#### Escenario 1: Registro exitoso de una nueva categoría
* **Dado** que el Administrador accede a la gestión de categorías,
* **Cuando** ingresa el nombre "Casacas Urbanas" y una descripción válida,
* **Entonces** el sistema valida que no exista otra categoría activa con el mismo nombre,
* **Y** almacena la nueva categoría quedando disponible de inmediato en los selectores del catálogo.

#### Escenario 2: Prevención de nombres duplicados
* **Dado** que ya existe la marca "Levis" registrada en el sistema,
* **Cuando** el Administrador intenta registrar otra marca con el nombre "LEVIS" (ignorando mayúsculas/minúsculas),
* **Entonces** el sistema rechaza la operación informando *"La marca ya se encuentra registrada"*.

#### Escenario 3: Desactivación lógica de una categoría con productos asociados
* **Dado** que una categoría tiene prendas registradas activas,
* **Cuando** el Administrador solicita eliminar dicha categoría,
* **Entonces** el sistema no ejecuta un borrado físico de la base de datos, sino un borrado lógico (estado inactivo), preservando la integridad referencial histórica de las ventas.

### 3. Consideraciones Técnicas (Clean Architecture + CQRS)
* **Dominio:** Entidades `Categoria` (Id, Nombre, Descripcion, Activo), `Marca` (Id, Nombre, Activo).
* **Aplicación:**
  - Commands: `CrearCategoriaCommand`, `EditarCategoriaCommand`, `CambiarEstadoCategoriaCommand`, `CrearMarcaCommand`.
  - Queries: `GetCategoriasActivasQuery`, `GetMarcasActivasQuery`.
* **Infraestructura:** Índices únicos `UNIQUE KEY (nombre)` en tablas `categorias` y `marcas`.
* **Presentación:** Formulario modal ligero y tabla de mantenimiento con buscador instantáneo.

---

## Historia de Usuario: HU-04
### Título: Catálogo de Productos y Variantes Físicas (Talla/Color/SKU)

| Atributo | Detalle |
|---|---|
| **Identificador** | `HU-04` |
| **Rol Principal** | Administrador |
| **Prioridad MoSCoW** | **MUST HAVE** |
| **Estimación** | 8 Story Points |
| **Sprint Sugerido** | Sprint 1 |
| **Dependencias** | HU-03 |

### 1. Narrativa
```text
Como Administrador,
Quiero registrar prendas base asociándoles múltiples variantes físicas con combinación de Talla, Color, Código SKU único y Código de Barras,
Para controlar individualmente las características reales de la ropa y permitir su identificación inmediata en el inventario y punto de venta.
```

### 2. Criterios de Aceptación (Gherkin)

#### Escenario 1: Creación de prenda base con matriz de tallas y colores
* **Dado** que el Administrador registra la prenda "Polo Oversize Algodón 24/1",
* **Cuando** selecciona la Categoría "Polos", la Marca "Oversize Co." y define las tallas [S, M, L] en los colores [Negro, Blanco],
* **Entonces** el sistema genera automáticamente 6 variantes independientes con su SKU estructurado (ej. `POL-NEG-S`, `POL-NEG-M`, etc.),
* **Y** crea los registros en la base de datos manteniendo el vínculo con el producto padre.

#### Escenario 2: Validación de unicidad de código SKU y código de barras
* **Dado** que se está ingresando o editando una variante de prenda,
* **Cuando** se asigna un código de barras o SKU que ya pertenece a otra variante en la base de datos,
* **Entonces** el sistema bloquea el guardado advirtiendo *"El código de barras / SKU ya está asignado a otra prenda"*.

#### Escenario 3: Consulta y filtrado avanzado de productos
* **Dado** que un usuario busca un artículo en el catálogo,
* **Cuando** filtra por categoría "Pantalones", marca "Levis" y talla "32",
* **Entonces** el sistema lista únicamente las variantes que coincidan exactamente con dichos criterios en menos de 1 segundo.

### 3. Consideraciones Técnicas (Clean Architecture + CQRS)
* **Dominio:**
  - Agregado: `Producto` (Id, Nombre, Descripcion, CategoriaId, MarcaId, Activo).
  - Entidad hija: `VarianteProducto` (Id, ProductoId, Talla, Color, Sku, CodigoBarras, PrecioVenta, Activo).
  - Regla de negocio: Un producto debe crearse con al menos 1 variante física.
* **Aplicación:**
  - Command: `RegistrarProductoConVariantesCommand(string Nombre, int CategoriaId, int MarcaId, List<VarianteInputDto> Variantes)`.
  - Command: `ActualizarVarianteCommand`.
  - Query: `GetProductoDetalladoQuery(int Id)`, `BuscarProductosCatalogoQuery(FiltrosCatalogoDto Filtros)`.
* **Infraestructura:** Mapeo relacional `productos` 1 -> N `variantes_producto`.
* **Presentación:** Vista maestro-detalle con grilla dinámica para agregar/quitar tallas y colores de manera visual.

---

## Historia de Usuario: HU-05
### Título: Configuración de Precios y Tarifas de Venta

| Atributo | Detalle |
|---|---|
| **Identificador** | `HU-05` |
| **Rol Principal** | Administrador |
| **Prioridad MoSCoW** | **MUST HAVE** |
| **Estimación** | 3 Story Points |
| **Sprint Sugerido** | Sprint 3 |
| **Dependencias** | HU-04 |

### 1. Narrativa
```text
Como Administrador,
Quiero definir y actualizar los precios de venta por variante de prenda,
Para asegurar que los montos facturados en el punto de venta reflejen la política de precios vigente de la tienda.
```

### 2. Criterios de Aceptación (Gherkin)

#### Escenario 1: Asignación de precio de venta a variante
* **Dado** que el Administrador edita el precio de una variante física,
* **Cuando** ingresa un valor numérico positivo mayor a cero (ej. S/. 45.00),
* **Entonces** el sistema actualiza el precio vigente de la variante,
* **Y** registra la fecha de modificación y el ID del usuario en la bitácora de auditoría.

#### Escenario 2: Rechazo de precios negativos o nulos
* **Dado** que se edita el precio de un producto,
* **Cuando** se intenta ingresar un monto igual o menor a 0.00,
* **Entonces** el sistema rechaza el valor con el mensaje *"El precio de venta debe ser estrictamente mayor a S/. 0.00"*.

### 3. Consideraciones Técnicas (Clean Architecture + CQRS)
* **Dominio:** Value Object `Precio` con validación de no negatividad y redondeo a 2 decimales.
* **Aplicación:** Command `ActualizarPrecioVarianteCommand(int VarianteId, decimal NuevoPrecio)`.
* **Infraestructura:** Actualización transaccional con generación de evento de dominio `PrecioModificadoEvent`.
* **Presentación:** Edición rápida en celda o modal emergente con validación numérica estricta.
