# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Qué es este repositorio

Ejercicios de un curso de bases de datos (PostgreSQL) sobre un gimnasio. Todo está en español. La usuaria está aprendiendo: el objetivo es que ella haga los ejercicios, no que Claude los resuelva.

- `gimnasio.sql`: script único, organizado por ejercicios con comentarios `/*B1*/`, `/*B2*/`, `/*B3*/`.
- `respuestas.md`: respuestas escritas de la usuaria (Parte A teórica, Parte B práctica).

## Forma de trabajar (importante)

- **No modificar archivos sin consultar antes.** Proponer primero el cambio y esperar confirmación, incluso en tareas que parecen mecánicas (lint, formato).
- No cambiar el contenido de las respuestas de la usuaria ni completar ejercicios por ella salvo que lo pida explícitamente. Preferir explicar o revisar.

## Comandos

```bash
# Ejecutar el script (recrea todo desde cero gracias a los DROP iniciales)
psql -d <basededatos> -f gimnasio.sql

# Lint del Markdown (config en .markdownlint.json: MD013 desactivada)
npx --yes markdownlint-cli2 respuestas.md
```

## Estructura de `gimnasio.sql`

- **B1 (esquema):** `planes` ← `socios` ← `tarjetas` (1:1 mediante `socio_id UNIQUE`); `monitores` ← `clases` (1:N); `reservas` es la tabla N:M socios–clases con `UNIQUE (socio_id, clase_id)`; `monitor_especialidades` es la N:M monitores–especialidades con PK compuesta. Los `DROP TABLE` van en orden inverso de dependencias; mantener ese orden si se añaden tablas.
- **B2 (datos):** los `INSERT` usan ids fijos en las claves ajenas (p. ej. `plan_id = 2`), que dependen de que las columnas `IDENTITY` empiecen en 1. Por eso el script debe ejecutarse siempre completo y desde cero. Hay casos límite intencionados, indicados en comentarios: Diego (socio 8) sin tarjeta, Rubén (monitor 4) sin clases, la clase 6 sin reservas.
- **B3 (restricciones):** sentencias que **fallan a propósito** para comprobar las restricciones (FK, UNIQUE). Los errores obtenidos y su explicación se documentan en `respuestas.md`. Al ejecutar el script completo, se espera que estas sentencias den error.
