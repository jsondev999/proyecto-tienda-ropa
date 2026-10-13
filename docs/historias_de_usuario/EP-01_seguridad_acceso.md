# Épica 01: Seguridad, Autenticación y Control de Acceso (RBAC)

> **Módulo:** Gestión de Acceso y Usuarios  
> **Requisitos Trazables:** `RF-01`, `RF-02`, `RNF-01`, `RNF-02`  
> **Paquete EDT Relacionado:** `1.3.3.1 Módulo Autenticación, Usuarios y RBAC`  

---

## Historia de Usuario: HU-01
### Título: Autenticación Segura y Gestión de Sesión

| Atributo | Detalle |
|---|---|
| **Identificador** | `HU-01` |
| **Rol Principal** | Usuario del Sistema (Administrador / Vendedor) |
| **Prioridad MoSCoW** | **MUST HAVE** |
| **Estimación** | 5 Story Points |
| **Sprint Sugerido** | Sprint 1 |
| **Dependencias** | Ninguna (Historia Fundacional) |

### 1. Narrativa
```text
Como usuario del sistema (Administrador o Vendedor),
Quiero iniciar sesión mediante mi correo electrónico institucional y contraseña cifrada,
Para acceder a las funcionalidades autorizadas de SYSELL garantizando la confidencialidad de mis datos.
```

### 2. Criterios de Aceptación (Gherkin)

#### Escenario 1: Inicio de sesión exitoso con credenciales válidas
* **Dado** que un usuario activo ingresa al formulario de autenticación de SYSELL,
* **Cuando** introduce su correo registrado válido y su contraseña correcta,
* **Entonces** el sistema valida las credenciales contra la base de datos,
* **Y** emite un token de acceso JWT firmado con vigencia de 8 horas,
* **Y** redirige al usuario al panel de inicio correspondiente a su rol.

#### Escenario 2: Intento fallido con credenciales erróneas
* **Dado** que un usuario intenta autenticarse,
* **Cuando** introduce una contraseña incorrecta o un correo no registrado,
* **Entonces** el sistema rechaza la autenticación devolviendo el mensaje *"Credenciales incorrectas"*,
* **Y** no revela si el error fue por correo inexistente o contraseña inválida (mitigación de enumeración de usuarios).

#### Escenario 3: Expiración y cierre automático de sesión por inactividad
* **Dado** que un usuario autenticado mantiene la aplicación abierta sin interacción por más de 30 minutos,
* **Cuando** intenta realizar cualquier petición o navegación,
* **Entonces** el sistema revoca la sesión activa, elimina el token del almacenamiento del cliente y redirige a la vista de login solicitando autenticarse nuevamente.

### 3. Consideraciones Técnicas (Clean Architecture + CQRS)
* **Dominio:**
  - Entidad: `Usuario` (Id, Nombre, Email, PasswordHash, Estado, RolId).
  - Value Objects: `EmailAddress`, `PasswordHash`.
* **Aplicación:**
  - Command: `LoginCommand(string Email, string Password)` -> Retorna `AuthResponseDto(string Token, UsuarioDto Usuario)`.
  - Command: `CerrarSesionCommand(Guid UsuarioId)`.
* **Infraestructura:**
  - Verificación de hash con `BCrypt` / `Argon2id`.
  - Generador de tokens JWT con claims de usuario y expiración.
* **Presentación:**
  - Endpoint: `POST /api/auth/login`, `POST /api/auth/logout`.
  - Interceptor HTTP en frontend que adjunta el encabezado `Authorization: Bearer <token>`.

---

## Historia de Usuario: HU-02
### Título: Control de Acceso Basado en Roles y Permisos (RBAC)

| Atributo | Detalle |
|---|---|
| **Identificador** | `HU-02` |
| **Rol Principal** | Administrador del Sistema |
| **Prioridad MoSCoW** | **MUST HAVE** |
| **Estimación** | 5 Story Points |
| **Sprint Sugerido** | Sprint 1 |
| **Dependencias** | HU-01 |

### 1. Narrativa
```text
Como Administrador del sistema,
Quiero asignar roles y permisos diferenciados a cada usuario (Administrador, Vendedor),
Para restringir las operaciones críticas (gestión de precios, anulación de ventas, reportes financieros) según el perfil del empleado.
```

### 2. Criterios de Aceptación (Gherkin)

#### Escenario 1: Restricción de navegación y vistas según rol
* **Dado** que un usuario con rol "Vendedor" inicia sesión en SYSELL,
* **Cuando** visualiza el menú lateral de navegación,
* **Entonces** solo tiene habilitadas las opciones de "Punto de Venta", "Apertura/Cierre de Caja" y "Consulta de Stock",
* **Y** las opciones de "Configuración de Precios", "Usuarios" y "Reportes Gerenciales" se ocultan de la interfaz.

#### Escenario 2: Protección de endpoints en backend contra acceso no autorizado
* **Dado** que un usuario con rol "Vendedor" intenta consumir directamente un endpoint protegido (ej. `DELETE /api/ventas/{id}` o `POST /api/precios`),
* **Cuando** el servidor procesa la petición con su token JWT,
* **Entonces** el middleware de autorización intercepta la solicitud y responde con código HTTP `403 Forbidden`,
* **Y** registra una entrada de intento no autorizado en el log de auditoría.

#### Escenario 3: Mantenimiento de usuarios por el Administrador
* **Dado** que el Administrador accede al módulo de usuarios,
* **Cuando** registra un nuevo empleado seleccionando rol, datos personales y correo,
* **Entonces** el sistema valida que el correo no esté duplicado, crea el usuario con estado "Activo" y permite asignar o revocar accesos en cualquier momento.

### 3. Consideraciones Técnicas (Clean Architecture + CQRS)
* **Dominio:**
  - Entidad: `Rol` (Id, Nombre, Descripcion), `Permiso` (Id, Codigo, Modulo).
  - Regla de Dominio: Un usuario debe tener al menos un rol asignado.
* **Aplicación:**
  - Command: `CrearUsuarioCommand`, `CambiarRolUsuarioCommand`, `DesactivarUsuarioCommand`.
  - Query: `GetUsuariosQuery`, `GetRolesPermisosQuery`.
* **Infraestructura:**
  - Guardias de autorización por atributo / middleware (`[Authorize(Roles = "Administrador")]`).
* **Presentación:**
  - Tabla de usuarios con selector de rol y switch de activación.
