# Diagramas de Secuencia Técnicos — SYSELL Web v2.0

**Proyecto:** Sistema de Gestión Comercial — Tienda de Ropa para Varón  
**Estándar de Modelado:** UML 2.5 (PlantUML con estilo `strictuml`)  
**Cobertura:** Transacciones críticas y flujos de arquitectura en 4 capas (Clean Architecture + CQRS)  

---

## 📌 1. Catálogo de Diagramas de Secuencia

| Código | Diagrama de Secuencia | Caso de Uso | Requisitos Funcionales | Archivo Fuente PUML |
|:---:|---|:---:|:---:|---|
| **DS-01** | Autenticación JWT y Bloqueo de Intentos | `CU-01` | `RF-01` al `RF-06`, `RF-09` | [`codigo_puml/ds_01_autenticacion_jwt.puml`](codigo_puml/ds_01_autenticacion_jwt.puml) |
| **DS-02** | Registro de Prendas y Validación de Catálogos | `CU-05`, `CU-07` | `RF-15`, `RF-19`, `RF-74` | [`codigo_puml/ds_02_registro_producto_variantes.puml`](codigo_puml/ds_02_registro_producto_variantes.puml) |
| **DS-03** | Transacción de Venta POS y Emisión de Ticket | `CU-08`, `CU-09` | `RF-21`, `RF-40` al `RF-50`, `RF-76` | [`codigo_puml/ds_03_transaccion_venta_pos.puml`](codigo_puml/ds_03_transaccion_venta_pos.puml) |
| **DS-04** | Ajuste de Inventario y Movimiento en Kardex | `CU-06` | `RF-20`, `RF-24`, `RF-25` | [`codigo_puml/ds_04_ajuste_inventario_kardex.puml`](codigo_puml/ds_04_ajuste_inventario_kardex.puml) |
| **DS-05** | Generación y Exportación de Reportes de Ventas | `CU-13`, `CU-14` | `RF-56` al `RF-66` | [`codigo_puml/ds_05_generacion_reporte_ventas.puml`](codigo_puml/ds_05_generacion_reporte_ventas.puml) |
| **DS-06** | Gestión de Usuarios, Roles y Desbloqueo | `CU-02` | `RF-07`, `RF-08`, `RF-10` al `RF-14`, `RF-73` | [`codigo_puml/ds_06_gestion_usuarios.puml`](codigo_puml/ds_06_gestion_usuarios.puml) |
| **DS-07** | Consulta de Catálogo Digital Público y Stock | `CU-15` | `RF-67` al `RF-72`, `RF-77` | [`codigo_puml/ds_07_catalogo_digital_publico.puml`](codigo_puml/ds_07_catalogo_digital_publico.puml) |
| **DS-08** | Anulación de Venta y Reversión Atómica de Stock | `CU-12` | `RF-53` | [`codigo_puml/ds_08_anulacion_venta.puml`](codigo_puml/ds_08_anulacion_venta.puml) |

---

## 🛠️ 2. Convenciones de Modelado y Arquitectura

Cada diagrama de secuencia modela las interacciones a través de las capas definidas en los Estándares de Arquitectura:

1. **Actor / Cliente:** Usuario (`Administrador`, `Vendedor`) o `Visitante Web` interactuando con la interfaz (`UI-SPA` en React/TypeScript).
2. **Controlador API REST:** Punto de entrada HTTP (Laravel) que aplica validaciones sintácticas y middlewares de seguridad (Auth, RBAC, Rate Limiting).
3. **Servicio de Aplicación (Command / Query):** Orquestador de la lógica de negocio y casos de uso, desacoplado de la persistencia mediante interfaces de repositorio.
4. **Dominio / Entidad:** Modelos de negocio con reglas de validación invariantes.
5. **Base de Datos (MySQL 8.0):** Persistencia relacional con soporte transaccional ACID (aislamiento InnoDB).

---

## 🎨 3. Cómo Renderizar los Diagramas

Para regenerar las imágenes `.png` a partir del código fuente `.puml`:

```bash
# Con la CLI de PlantUML instalada:
plantuml -tpng docs/diagramas_secuencia/codigo_puml/*.puml -o ../imagenes_png/

# O utilizando Docker:
docker run --rm -v $(pwd):/data plantuml/plantuml -tpng docs/diagramas_secuencia/codigo_puml/*.puml -o ../imagenes_png/
```
