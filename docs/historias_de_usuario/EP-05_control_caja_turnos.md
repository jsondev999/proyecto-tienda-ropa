# Épica 05: Control de Turnos de Caja y Arqueos

> **Módulo:** Caja y Tesorería  
> **Requisitos Trazables:** `RF-13`, `RF-14`  
> **Paquete EDT Relacionado:** `1.3.3.5 Módulo Gestión de Turnos de Caja y Arqueos`  

---

## Historia de Usuario: HU-13
### Título: Apertura, Cierre y Arqueo Ciego de Caja

| Atributo | Detalle |
|---|---|
| **Identificador** | `HU-13` |
| **Rol Principal** | Vendedor / Administrador |
| **Prioridad MoSCoW** | **MUST HAVE** |
| **Estimación** | 8 Story Points |
| **Sprint Sugerido** | Sprint 2 |
| **Dependencias** | HU-01, HU-02 |

### 1. Narrativa
```text
Como Vendedor o Administrador,
Quiero abrir un turno de caja indicando el saldo inicial en efectivo y realizar el cierre al final de la jornada mediante un arqueo ciego,
Para contrastar el dinero físico recaudado contra las transacciones del sistema y detectar sobrantes o faltantes con total transparencia.
```

### 2. Criterios de Aceptación (Gherkin)

#### Escenario 1: Apertura de caja al inicio del turno
* **Dado** que un cajero inicia su turno de trabajo y no posee una caja abierta,
* **Cuando** ingresa el monto inicial en efectivo (ej. S/. 100.00 para cambio/sencillo) y confirma,
* **Entonces** el sistema crea un nuevo registro en `cajas_turno` con estado "ABIERTA",
* **Y** habilita de inmediato el módulo de Punto de Venta para ese usuario.

#### Escenario 2: Restricción de doble apertura de caja
* **Dado** que un usuario ya tiene una caja en estado "ABIERTA",
* **Cuando** intenta abrir otra caja simultáneamente en el mismo terminal,
* **Entonces** el sistema bloquea la operación informando *"Ya posee una caja activa abierta. Debe cerrarla antes de iniciar un nuevo turno"*.

#### Escenario 3: Cierre de caja con arqueo ciego y cálculo de diferencias
* **Dado** que el cajero finaliza su jornada laboral,
* **Cuando** procede al cierre e ingresa el monto físico contado en efectivo (sin que el sistema le revele previamente el saldo esperado),
* **Entonces** el sistema registra el monto real declarado,
* **Y** calcula automáticamente el saldo esperado según la fórmula: `MontoInicial + VentasEfectivo + IngresosVarios - EgresosVarios`,
* **Y** calcula la diferencia (`MontoDeclarado - MontoEsperado`), tipificándola como "Cuadrada" (0.00), "Sobrante" (> 0.00) o "Faltante" (< 0.00),
* **Y** cambia el estado de la caja a "CERRADA".

### 3. Consideraciones Técnicas (Clean Architecture + CQRS)
* **Dominio:** Entidad `CajaTurno` (Id, UsuarioId, FechaApertura, FechaCierre, MontoInicial, MontoFinalEsperado, MontoFinalDeclarado, Diferencia, Estado [ABIERTA, CERRADA]).
* **Aplicación:**
  - Command: `AbrirCajaCommand(decimal MontoInicial)`.
  - Command: `CerrarCajaCommand(int CajaId, decimal MontoDeclarado, string Observaciones)`.
  - Query: `GetEstadoCajaActualQuery()`, `GetHistorialCajasQuery(FiltrosCajaDto Filtros)`.
* **Infraestructura:** Validación de restricciones en base de datos para impedir estados anómalos.
* **Presentación:** Pantalla de apertura rápida matutina y modal de cierre con desglose de billetes y monedas.

---

## Historia de Usuario: HU-14
### Título: Registro de Entradas y Salidas Menores de Efectivo

| Atributo | Detalle |
|---|---|
| **Identificador** | `HU-14` |
| **Rol Principal** | Vendedor / Administrador |
| **Prioridad MoSCoW** | **MUST HAVE** |
| **Estimación** | 3 Story Points |
| **Sprint Sugerido** | Sprint 2 |
| **Dependencias** | HU-13 |

### 1. Narrativa
```text
Como cajero,
Quiero registrar egresos e ingresos menores de efectivo durante el turno (gastos operativos, compra de útiles de limpieza, ingreso extra de sencillo),
Para que el balance final de la caja física coincida exactamente con las operaciones del día.
```

### 2. Criterios de Aceptación (Gherkin)

#### Escenario 1: Registro de un egreso menor justificado
* **Dado** que la caja se encuentra abierta,
* **Cuando** el usuario registra un egreso de S/. 25.00 con motivo "Compra de bolsas de empaque",
* **Entonces** el sistema disminuye el saldo disponible en efectivo del turno,
* **Y** almacena el registro en la tabla `movimientos_caja` vinculándolo a la caja activa.

#### Escenario 2: Bloqueo de egreso que supere el efectivo disponible
* **Dado** que la caja tiene actualmente un saldo acumulado en efectivo de S/. 40.00,
* **Cuando** el usuario intenta registrar un retiro de S/. 60.00,
* **Entonces** el sistema bloquea la transacción informando *"El monto del egreso supera el efectivo disponible en caja (Disponible: S/. 40.00)"*.

### 3. Consideraciones Técnicas (Clean Architecture + CQRS)
* **Dominio:** Entidad `MovimientoCaja` (Id, CajaId, Tipo [INGRESO, EGRESO], Monto, Motivo, Fecha, UsuarioId).
* **Aplicación:** Command `RegistrarMovimientoCajaCommand(int CajaId, TipoMovimientoCaja Tipo, decimal Monto, string Motivo)`.
* **Infraestructura:** Actualización transaccional dentro del contexto del turno de caja.
* **Presentación:** Formulario modal intuitivo con selector de tipo de movimiento y descripción obligatoria.
