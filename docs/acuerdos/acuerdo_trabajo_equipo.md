# Working Agreement — Metodología Híbrida RUP + SCRUM

> **Proyecto:** SYSELL — Sistema Web de Gestión de Inventario y Ventas  
> **Equipo:** Pollitos Design  
> **Institución:** Universidad Nacional Jorge Basadre Grohmann (UNJBG)  
> **Facultad:** Facultad de Ingeniería (FI)  
> **Escuela Profesional:** Ingeniería en Informática y Sistemas (ESIS)  
> **Asignatura:** Ingeniería de Software I — Ciclo VI  
> **Horizonte del proyecto:** 28 días calendario  
> **Misión Universitaria:** Fomentar la creación y consolidación de una mejor universidad mediante el rigor académico, el desarrollo de soluciones tecnológicas de impacto real para el sector productivo y la adopción de estándares profesionales de ingeniería de software.

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

Este **Working Agreement** es el contrato operativo del equipo **Pollitos Design** para el desarrollo del sistema SYSELL. Establece las reglas de trabajo, los roles, los canales de comunicación, los criterios de calidad y los procedimientos de resolución de conflictos que regirán durante todo el ciclo de vida del proyecto.

El equipo asume este proyecto no solo como una entrega académica, sino como una contribución tangible a la construcción de una mejor universidad, demostrando que desde las aulas de la **Escuela Profesional de Ingeniería en Informática y Sistemas (ESIS - UNJBG)** se desarrollan productos de software con arquitectura empresarial, calidad certificada y alto valor social y comercial.

Su cumplimiento es **obligatorio** para todos los integrantes del equipo desde el día de su firma.

---

## 2. Objetivos del Working Agreement

- **Excelencia Universitaria y Formativa:** Posicionar el proyecto como un modelo de referencia técnica en la universidad, aplicando metodologías formales (RUP) y marcos ágiles (Scrum) con rigor y profesionalismo.
- **Canales y Gobierno:** Definir los canales oficiales de comunicación e intercambio de artefactos, eliminando la dispersión de acuerdos informales.
- **Roles e Integración:** Formalizar la estructura organizativa mediante una Matriz RACI optimizada para el equipo de 4 integrantes, alineando los roles de análisis, arquitectura, desarrollo y calidad.
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

### 5.2. Matriz RACI del proyecto (Equipo de 4 Integrantes)

| Actividad | Johan Mamani (PM / PO) | Giorgini Disalvatore (SM / QA) | Aron Cachicatari (Líder Técnico / Dev) | Luis Condori (UX / Analista) |
|---|:---:|:---:|:---:|:---:|
| Definición de Alcance & Prioridades | **A / R** | C | C | C |
| Levantamiento de Requisitos & Casos de Uso | A | C | C | **R** |
| Prototipado UI/UX & Flujos Visuales | C | C | C | **R** |
| Diseño de Arquitectura Base & Modelo de Datos | A | I | **R** | C |
| Planificación del Sprint (Sprint Planning) | A | **F / C** | R | R |
| Desarrollo de Software (Clean Arch + CQRS) | I | C | **R** | I |
| Ejecución de Pruebas Unitarias & Automatizadas | I | **A / R** | R | I |
| Code Review & Aprobación de Pull Request | I | C | **A / R** | I |
| Facilitación de Ceremonias Scrum (Daily, Retro) | C | **R / F** | C | C |
| Demostración de Incremento (Sprint Review) | **A** | F | R | R |
| Pruebas de Aceptación de Usuario (UAT) | A | **R** | I | C |
| Despliegue en VPS Institucional & Release Final | **A** | C | **R** | I |

### 5.3. Roles y Responsabilidades del equipo Pollitos Design

| Integrante | Rol Principal | Rol Secundario / Especialidad | Responsabilidades Clave |
|---|---|---|---|
| **Johan Mamani** | Líder / Jefe de Proyecto | Product Owner (PO) | Gestión del alcance global, priorización del Product Backlog, interlocución con stakeholders, resolución de bloqueos de negocio y aprobación final de entregables. |
| **Luis Condori** | Diseñador UI/UX | Analista Funcional | Modelado formal de casos de uso, prototipado de interfaces, diseño de interacción y usabilidad del punto de venta (POS) y validación visual. |
| **Aron Cachicatari** | Líder Técnico | Desarrollador Full-Stack | Diseño e implementación de Clean Architecture + CQRS, desarrollo de API y lógica de negocio, integración con MySQL, DevOps y despliegue en VPS. |
| **Giorgini Disalvatore** | Analista de Calidad (QA) | Scrum Master (SM) | Aseguramiento de la calidad, diseño y ejecución de planes de prueba (unitarias/E2E), verificación estricta de DoR y DoD, facilitación de ceremonias ágiles y remoción de impedimentos. |

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
|---|---|:---:|:---:|
| **Johan Mamani** | Líder / Jefe de Proyecto & Product Owner | CONFORME | ___/___/2026 |
| **Luis Condori** | Diseñador UI/UX & Analista Funcional | CONFORME | ___/___/2026 |
| **Aron Cachicatari** | Desarrollador Full-Stack & Líder Técnico | CONFORME | ___/___/2026 |
| **Giorgini Disalvatore** | Analista de Calidad (QA) & Scrum Master | CONFORME | ___/___/2026 |

---

*Pollitos Design — Escuela Profesional de Ingeniería en Informática y Sistemas (ESIS)*  
*Facultad de Ingeniería — Universidad Nacional Jorge Basadre Grohmann (UNJBG) — Tacna, 2026*
