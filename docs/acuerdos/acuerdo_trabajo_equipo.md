# Working Agreement — Metodología Híbrida RUP + SCRUM

> **Proyecto:** SYSELL — Sistema Web de Gestión de Inventario y Ventas  
> **Equipo:** Pollitos Design  
> **Institución:** UNJBG  
> **Asignatura:** Ingeniería de Software I — Ciclo VI  
> **Horizonte del proyecto:** 28 días calendario

---

## Tabla de contenidos

1. [Propósito del documento](#1-propósito-del-documento)
2. [Objetivos del Working Agreement](#2-objetivos-del-working-agreement)
3. [Fundamentos de la metodología híbrida RUP + SCRUM](#3-fundamentos-de-la-metodología-híbrida-rup--scrum)
4. [Principios culturales y valores del equipo](#4-principios-culturales-y-valores-del-equipo)
5. [Estructura de organización, roles y Matriz RACI](#5-estructura-de-organización-roles-y-matriz-raci)
6. [Canales de comunicación, horarios y disponibilidad](#6-canales-de-comunicación-horarios-y-disponibilidad)
7. [Normativa para las ceremonias y eventos Scrum](#7-normativa-para-las-ceremonias-y-eventos-scrum)
8. [Gestión de requisitos, artefactos y trazabilidad](#8-gestión-de-requisitos-artefactos-y-trazabilidad)
9. [Control de versiones, commits y Code Review](#9-control-de-versiones-commits-y-code-review)
10. [Filtros de calidad: DoR y DoD](#10-filtros-de-calidad-dor-y-dod)
11. [Gestión de impedimentos, riesgos y conflictos](#11-gestión-de-impedimentos-riesgos-y-conflictos)
12. [Control de cambios y gobierno del acuerdo](#12-control-de-cambios-y-gobierno-del-acuerdo)
13. [Compromiso y firmas de conformidad](#13-compromiso-y-firmas-de-conformidad)

---

## 1. Propósito del documento

Este **Working Agreement** es el contrato operativo del equipo Pollitos Design para el desarrollo del sistema SYSELL. Establece las reglas de trabajo, los roles, los canales de comunicación, los criterios de calidad y los procedimientos de resolución de conflictos que regirán durante todo el ciclo de vida del proyecto.

Su cumplimiento es **obligatorio** para todos los integrantes del equipo desde el día de su firma.

---

## 2. Objetivos del Working Agreement

- **Canales y Gobierno:** Definir los canales oficiales de comunicación e intercambio de artefactos, eliminando la dispersión de acuerdos informales.
- **Roles e Integración:** Formalizar la estructura organizativa mediante una Matriz RACI que alinee los roles tradicionales de RUP (Analistas, Arquitectos, QA, DBA) con la dinámica de Scrum (Product Owner, Scrum Master, Developers).
- **Aseguramiento de Calidad:** Establecer criterios unificados para la **Definition of Ready (DoR)** y **Definition of Done (DoD)**, asegurando que ningún componente sea considerado finalizado sin la debida verificación de calidad y trazabilidad.
- **Estándares de Código:** Normalizar el flujo de trabajo en el control de versiones (Git), definiendo reglas para la creación de ramas, convención semántica de commits y revisiones obligatorias de código (Code Review).
- **Gestión de Conflictos:** Proveer un protocolo formal para la detección, reporte y resolución de impedimentos, riesgos y desacuerdos técnicos o funcionales.

---

## 3. Fundamentos de la metodología híbrida RUP + SCRUM

La adopción de un enfoque híbrido responde a la necesidad de cumplir con la entrega de documentación formal, arquitectura robusta y modelado UML (propios de **RUP**) en un horizonte de tiempo acotado de 28 días, donde la capacidad de respuesta al cambio y las demostraciones semanales al área usuaria (propias de **Scrum**) resultan indispensables.

> **RUP** actúa como el marco contenedor de gobierno de ingeniería y arquitectura.  
> **Scrum** opera como el motor de ejecución diaria por medio de Sprints de 1 semana.

### 3.1. Integración de fases RUP y Sprints de Scrum

| Fase RUP | Sprint | Días | Actividades principales |
|----------|--------|------|------------------------|
| **Inicio** | Sprint 0 | 1–3 | Alineación inicial, especificación de alcance, evaluación de riesgos, preparación del entorno y construcción del Product Backlog inicial. |
| **Elaboración** | Sprint 1 | 4–10 | Levantamiento de procesos de negocio, especificación de casos de uso RUP primarios, diseño de arquitectura base, modelado de datos MySQL y validación del prototipo. |
| **Construcción** | Sprints 2 y 3 | 11–24 | Desarrollo incremental de módulos funcionales bajo disciplina de construcción, pruebas y revisiones de código. |
| **Transición** | Sprint 4 y Release Final | 25–28 | Pruebas de aceptación (UAT), despliegue en VPS institucional, entrega del código fuente versionado, capacitación de usuarios y firma del acta de conformidad. |

---

## 4. Principios culturales y valores del equipo

Inspirados en los principios del Manifiesto Ágil, la Guía de Scrum 2020 y las prácticas de ingeniería de software de alto rendimiento, el equipo asume los siguientes compromisos:

| Valor | Compromiso |
|-------|-----------|
| **Humildad Profesional** | El código y los artefactos son propiedad colectiva del equipo. Nadie adoptará una postura defensiva ante observaciones técnicas constructivas durante las revisiones. |
| **Respeto Mutuo** | Tratar a todos los integrantes con consideración y empatía, valorando la especialidad técnica de cada rol. |
| **Confianza y Autonomía** | Delegar autoridad y asumir la responsabilidad individual sobre los compromisos adquiridos en el Sprint Planning. Fomentar una cultura **Blameless** orientada al análisis de causa raíz. |
| **Transparencia Radical** | Reflejar el estado real del proyecto en el tablero de gestión. Ocultar retrasos o impedimentos es considerado una **falta grave** contra el equipo. |
| **Foco y Disciplina** | Mantener el enfoque en el Sprint Goal. Se evitará la incorporación de características no solicitadas (**Gold Plating**) que pongan en riesgo el cronograma. |

---

## 5. Estructura de organización, roles y Matriz RACI

### 5.1. Simbología RACI

| Letra | Significado |
|-------|------------|
| **R** | Responsable de la ejecución |
| **A** | Aprueba / Accountable final |
| **C** | Consultado |
| **I** | Informado |
| **F** | Facilitador |

### 5.2. Matriz RACI del proyecto

| Actividad | Jefe Proy / PM | Product Owner | Scrum Master | Líder Técnico | Analista / QA | Developers |
|-----------|:-:|:-:|:-:|:-:|:-:|:-:|
| Definición de Alcance & Prioridades | A | R | C | C | C | I |
| Levantamiento de Requisitos & Casos de Uso | C | A | C | C | R | C |
| Diseño de Arquitectura Base & Modelo de Datos | A | I | C | R | C | C |
| Planificación del Sprint (Sprint Planning) | I | A | F/C | C | C | R |
| Desarrollo de Software (Frontend/Backend) | I | I | C | A | C | R |
| Ejecución de Pruebas Unitarias & QA | I | I | I | A | R | R |
| Code Review & Aprobación de Pull Request | I | I | I | A | C | R |
| Demostración de Incremento (Sprint Review) | C | A | F | C | R | R |
| Pruebas de Aceptación de Usuario (UAT) | C | A | I | C | R | I |
| Despliegue en VPS Institucional & Cierre | A | A | C | R | C | R |

### 5.3. Roles del equipo Pollitos Design

| Rol | Integrante |
|-----|-----------|
| **Líder / Jefe de Proyecto** | Johan Mamani |
| **Diseñador / Analista Funcional** | Luis Condori |
| **Programador / Developer** | Aron Cachicatari |
| **Testeador / Analista QA** | Alex Chata |
| **Analista / Scrum Master** | Pierrette Chávez |

---

## 6. Canales de comunicación, horarios y disponibilidad

### 6.1. Canales oficiales

| Canal | Plataforma | Uso |
|-------|-----------|-----|
| **Comunicación general** | Discord / WhatsApp | Mensajería instantánea, coordinación del día a día, avisos rápidos y alertas de impedimentos. **No** se aprobarán cambios de alcance por este medio. |
| **Videoconferencias** | Google Meet / Teams | Reuniones síncronas (Daily, Planning, Review, Retrospective). Se mantendrá un único enlace persistente. |
| **Repositorio documental** | Google Drive | Almacenamiento de documentación técnica, Actas, Modelo de Casos de Uso y Matriz de Trazabilidad. |
| **Código y tareas** | GitHub | Repositorio único para código fuente, gestión de incidencias (Issues), tablero del backlog (Projects) y revisiones de código (Pull Requests). |

### 6.2. Reglas de horarios y disponibilidad

- **Horario laboral preferente:** Días hábiles de Lunes a Viernes, **08:30 a 18:00 hrs**.
- **Daily Scrum:** Todos los días a las **09:00 hrs** de forma estricta.
- **Puntualidad:** Tolerancia máxima de **3 minutos**. La ausencia injustificada afectará el indicador de compromiso del integrante.
- **Notificación de ausencias:** Comunicar con un mínimo de **12 horas de anticipación** a través del canal oficial.

---

## 7. Normativa para las ceremonias y eventos Scrum

### 7.1. Daily Scrum — Sincronización diaria (15 min)

Reunión diaria a las **09:00 hrs**. Cada integrante responde:

1. ¿Qué actividades completé desde la última Daily?
2. ¿Qué actividades tengo planificadas para hoy?
3. ¿Existe algún impedimento que bloquee mi avance?

> **Regla:** La Daily no es un espacio de resolución de problemas; los impedimentos se registran y se atienden fuera de la sesión.

### 7.2. Sprint Planning — Planificación del Sprint

Sesión al inicio de cada Sprint donde:
- El **Product Owner** presenta y prioriza los ítems del Product Backlog que cumplen el **Definition of Ready (DoR)**.
- El equipo de desarrollo selecciona los ítems según su capacidad real y define el **Sprint Goal**.

### 7.3. Sprint Review — Demostración de incrementos

Se realizará el **último día del Sprint**. El equipo presentará un incremento de software **totalmente funcional y desplegado** en el servidor de pruebas/VPS.

> **Prohibido:** Presentar diapositivas estáticas o conceptos no codificados. Únicamente software operativo que cumpla con la **Definition of Done (DoD)**.

### 7.4. Sprint Retrospective — Mejora continua (45 min)

Sesión interna celebrada tras la Sprint Review. El equipo analiza:
- ¿Qué funcionó bien?
- ¿Qué problemas surgieron?
- ¿Qué compromisos de mejora se incorporarán al Working Agreement para el siguiente Sprint?

---

## 8. Gestión de requisitos, artefactos y trazabilidad

La trazabilidad es el **pilar central** que garantiza la conformidad contractual y la calidad de la ingeniería de software.

### 8.1. Cadena de trazabilidad obligatoria

```
Necesidad Institucional
    → Caso de Uso RUP
        → Elemento del Product Backlog (User Story)
            → Criterios de Aceptación
                → Tarea de Desarrollo Git
                    → Componente de Código
                        → Caso de Prueba QA
                            → Evidencia de Aceptación
```

> Cada necesidad del área usuaria debe ser **rastreable a lo largo de todo el ciclo de vida** del desarrollo.

---

## 9. Control de versiones, commits y Code Review

### 9.1. Estrategia de ramas (GitFlow adaptado)

```
main / master    ← Solo código estable en producción (merge desde develop o hotfix)
develop          ← Rama de integración continua
feature/*        ← feature/RF-XXX-descripcion  (a partir de develop)
fix/*            ← fix/DEF-XXX-descripcion  (corrección de defectos en QA)
```

> **Prohibido:** push directo a `main` o `develop`. Toda integración **debe realizarse vía Pull Request**.

### 9.2. Convención semántica de commits

Los commits deben ser **atómicos, frecuentes** y seguir la siguiente estructura:

```
feat: incorporar registro de producto con validación de stock
fix: corregir validación de DNI en módulo de usuarios
docs: actualizar matriz de trazabilidad y especificación de casos de uso
test: agregar casos de prueba unitarios para RegistrarSalidaProductoHandler
refactor: extraer lógica de ganancia a clase de dominio
```

### 9.3. Protocolo de Pull Requests (PR) y Code Review

| Paso | Responsable | Acción |
|------|------------|--------|
| **1. Apertura de PR** | Developer | Abre el PR vinculando el Issue/Tarea de GitHub correspondiente. |
| **2. Revisión obligatoria** | Peer Reviewer o Líder Técnico | Al menos **UN** desarrollador debe revisar el código. |
| **3. Criterios de aprobación** | Revisor | Verificar: no rompe funcionalidades existentes, cumple con la arquitectura, no contiene credenciales expuestas y pasa las pruebas unitarias. |
| **4. Tono constructivo** | Todo el equipo | Las observaciones se realizan con tono amable y profesional, enfocado en el **código**, no en la persona. |

---

## 10. Filtros de calidad: DoR y DoD

### Definition of Ready (DoR) — Filtro para ingresar al Sprint

Un ítem del backlog puede entrar al Sprint **solo si** cumple todos los siguientes criterios:

- [ ] Requisito/Historia con descripción clara y origen validado.
- [ ] Actor o perfil de usuario identificado.
- [ ] Criterios de Aceptación explícitos e inambiguos.
- [ ] Dependencias técnicas/funcionales identificadas.
- [ ] Estimado por el equipo de desarrollo.
- [ ] Mockups o bocetos de interfaz disponibles.
- [ ] Aprobado por el Product Owner.

### Definition of Done (DoD) — Filtro para cerrar el incremento

Un incremento se considera **terminado solo si** cumple todos los siguientes criterios:

- [ ] Código compilado sin advertencias.
- [ ] Repositorio Git actualizado mediante PR aprobado.
- [ ] Code Review realizado y observaciones cerradas.
- [ ] Pruebas unitarias y funcionales ejecutadas sin fallas.
- [ ] Cero defectos de prioridad Alta/Crítica abiertos.
- [ ] Trazabilidad en Matriz RUP/Scrum actualizada.
- [ ] Desplegado en entorno VPS de Pruebas/Piloto.
- [ ] Demostrado y aceptado por el Product Owner.

---

## 11. Gestión de impedimentos, riesgos y conflictos

### 11.1. Escalación de impedimentos

Un **impedimento** es cualquier bloqueo que detiene el avance de una tarea por más de **2 horas**.

| Paso | Acción |
|------|--------|
| **1** | El desarrollador registra la incidencia en **GitHub Issues** y la notifica al Scrum Master por el canal de mensajes. |
| **2** | El Scrum Master evalúa si el bloqueo es técnico interno o externo (falta de aclaración funcional del PO o accesos a servidor). |
| **3** | Si es externo, el SM coordina con el PO o el cliente institucional para destrabar el requerimiento en un plazo no mayor a **24 horas**. |

### 11.2. Resolución de desacuerdos técnicos y funcionales

| Fase | Mecanismo | Responsable |
|------|-----------|------------|
| **Fase 1 — Consenso técnico** | Debate técnico abierto entre los involucrados aportando argumentos basados en evidencia. | Equipo |
| **Fase 2 — Decisión técnica** | Si no hay acuerdo en **30 minutos**, el Líder Técnico toma la decisión arquitectónica basada en estándares de ingeniería. | Líder Técnico |
| **Fase 3 — Decisión de negocio** | Si el desacuerdo es de carácter funcional o de negocio, la decisión final corresponde **exclusivamente** al Product Owner. | Product Owner |

---

## 12. Control de cambios y gobierno del acuerdo

El proyecto cuenta con un horizonte cerrado de **28 días calendario**. Todo cambio de alcance debe ser gestionado bajo estricto control de impacto.

- **Solicitud formal:** No se aceptarán solicitudes de cambio verbales ni por chats informales. Toda solicitud debe ser formulada por el PO mediante el formato formal de **Control de Cambios**.
- **Evaluación de impacto:** El Jefe de Proyecto y el Líder Técnico evaluarán el impacto en días calendario, arquitectura y costo. Si un nuevo requisito es incorporado, un requisito de esfuerzo equivalente debe ser retirado del Product Backlog (**Trueque de Alcance**).
- **Evolución del acuerdo:** El Working Agreement es un **documento vivo**. Se revisará al final de cada Sprint durante la Retrospectiva para realizar ajustes y mejoras continuas.

---

## 13. Compromiso y firmas de conformidad

Los abajo firmantes declaran conocer, comprender y aceptar en su totalidad las cláusulas, reglas operativas y compromisos de calidad establecidos en el presente Working Agreement, comprometiéndose a velar por su estricto cumplimiento durante la ejecución del proyecto.

| Nombre y Apellido | Rol en el Proyecto | Conformidad | Fecha |
|-------------------|--------------------|:-----------:|-------|
| Johan Mamani | Líder / Jefe de Proyecto | CONFORME | ___/___/2026 |
| Pierrette Chávez | Scrum Master / Analista | CONFORME | ___/___/2026 |
| Aron Cachicatari | Developer / Programador | CONFORME | ___/___/2026 |
| Luis Condori | Diseñador / Analista Funcional | CONFORME | ___/___/2026 |
| Alex Chata | Analista de Calidad (QA) | CONFORME | ___/___/2026 |

---

*Pollitos Design — UNJBG 2026*
