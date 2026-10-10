---
name: revisartema
description: Revisa de principio a fin un tema del 3.er o 4.º ejercicio de la oposición TCEE (p. ej. /revisartema 3A08). Lo migra a LyX/LaTeX con gráficos TikZ, corrige errores, resuelve lo marcado en amarillo y rojo, actualiza los datos con fuentes, comprueba la coherencia, genera PDF, HTML y Word, el guion del cante de 30 minutos y el vídeo, y hace commit en la rama revision-temario.
argument-hint: "<tema> [--fase extraer|revisar|integrar|graficos|construir|guion|video|calidad|publicar]"
---

# /revisartema

Orquestas un equipo de agentes que deja **un tema** revisado y cerrado. Tú
coordinas; el trabajo lo hacen los agentes `tema-*` de `.claude/agents/`.

Argumentos: `$ARGUMENTS`. El primero es el código del tema (3A08, 3.A.8,
4B12…). Opcionales: `--fase X` (empezar en esa fase, para retomar o repetir
una parte) y `--sin-video`.

## Antes de nada

1. Lee `.claude/skills/revisartema/CRITERIOS.md` entero: manda sobre todo lo demás.
2. Comprueba que estás en el worktree de la rama:
   `git rev-parse --abbrev-ref HEAD` debe dar `revision-temario` y la carpeta
   debe ser `…/victorgutierrezmarcos.github.io-revision`. Si no, para y dile a
   Víctor que abra Claude Code en esa carpeta. **Nunca** trabajes en `main`.
3. Pasa a todos los agentes **rutas absolutas** del worktree. Llamamos `R` a la
   raíz del worktree, `T` al código del tema (3A08) y `D = R/oposicion/temario/fuentes/T`.
4. Fusiona lo último de main en la rama: `git fetch origin && git merge --no-edit origin/main`
   (fusionar, nunca rebasar). Si hay conflictos, para y avisa.
5. Lee `D/estado.json` si existe: indica las fases hechas. Retoma desde la
   primera no hecha (o desde `--fase`). Al acabar cada fase, márcala con la
   fecha y hora en `estado.json` (`"fases": {"extraer": "2026-10-10T20:15"}`).
6. Crea una lista de tareas (TodoWrite) con las fases, para que Víctor vea el avance.

Comprueba también LyX: `python3 -c "import sys; sys.path.insert(0,'R/scripts/temario'); import comun; print(comun.LYX)"`.
Si da `None`, sigue sin LyX (se trabaja sobre el `.tex`) y avísalo en el resumen final.

## Fases

### 1. extraer — agente `tema-extractor`
Ejecuta `extraer-docx.py` e `indexar-referencias.py` y prepara
`D/_trabajo/pendientes.md` (lista numerada de todo lo que hay que resolver) y
`D/_trabajo/estructura.md` (índice del tema original con su extensión).

### 2. revisar — tres agentes **en paralelo** (un solo mensaje con tres llamadas)
- `tema-revisor-contenido` → `D/_trabajo/propuestas-contenido.md`
- `tema-verificador-datos` → `D/_trabajo/propuestas-datos.md` y `D/_trabajo/bib-datos.bib`
- `tema-coherencia` → `D/_trabajo/propuestas-coherencia.md` (incluye la estructura
  final con minutos por apartado)

Los tres solo proponen; ninguno escribe la fuente del tema.

### 3. integrar — agente `tema-editor-lyx`
Escribe `D/T.tex` y `D/T.bib` con todo lo aceptado, deja los gráficos
pedidos en `D/_trabajo/graficos-pedidos.json` y redacta `D/revision.md`.
Si el tema es largo (más de ~25 páginas en el PDF publicado), lánzalo por
partes: primero introducción y apartados I-II, luego el resto, luego
conclusión, bibliografía y anexos (le dices qué parte toca en cada llamada).

### 4. graficos — agentes `tema-tikz` en paralelo
Reparte `graficos-pedidos.json` en grupos de 3-5 gráficos y lanza un agente
por grupo (hasta 6 a la vez). Cada uno escribe `D/graficos/<nombre>.tex`, lo
compila y lo compara con el original.

### 5. construir — tú mismo
`python3 R/scripts/temario/construir-tema.py T`. Si falla, pásale el error a
`tema-editor-lyx` (o a `tema-tikz` si es de un gráfico) para que lo arregle y
repite (máximo 3 intentos). Si LyX está instalado, el script sincroniza el
`.lyx` y el `.tex`.

### 6. guion y repaso — agentes `tema-guionista` y `tema-repaso` en paralelo
- `tema-guionista` escribe `D/guion-cante.md` y `D/video/escenas.yaml` y
  ajusta su longitud con `generar-video.py T --medir`.
- `tema-repaso` escribe la ficha de repaso de dos páginas
  (`D/repaso/T-repaso.tex`) y la compila con `construir-repaso.py T`.

### 7. video — agente `tema-video`, **solo cuando Víctor lo pida**
Víctor revisa primero el tema y el guion. El vídeo no se genera en la pasada
diaria: se lanza después con `/revisartema T --fase video`, cuando él dé el
visto bueno (y tras aplicar sus correcciones).

### 8. calidad — agente `tema-control-calidad`
Ejecuta `verificar-tema.py`, revisa PDF, HTML y Word, y lee el informe. Si
devuelve correcciones, mándalas a `tema-editor-lyx` (o al agente que toque),
vuelve a construir y repite la calidad **una vez** como máximo. Lo que quede
va a «Dudas abiertas» de `revision.md`.

### 9. publicar — tú mismo
1. `python3 R/scripts/temario/construir-tema.py T --solo html` (para que la
   página enlace la ficha de repaso) y
   `python3 R/scripts/temario/publicar-tema.py T` (índice, `temario.json`, buscador).
2. Comprueba con `git status` que solo cambian cosas del tema `T`, su línea en
   el índice, `temario.json`, `search-index.json` y, si hizo falta, la
   infraestructura común. `_trabajo/` no debe aparecer (está en .gitignore).
3. Commit en `revision-temario`:
   `Tema <código> revisado: <resumen en una línea>` y, en el cuerpo, el resumen
   de `revision.md` (sin las tablas). Termina el mensaje con las líneas de
   atribución que indique el sistema.
4. `git push origin revision-temario`. Si da 403, la cuenta activa de `gh` es
   la del trabajo: usa
   `git -c credential.helper= -c 'credential.helper=!f(){ echo username=x-access-token; echo password=$(gh auth token -u vgutierrezmarcos); }; f' push origin revision-temario`.
   **Nunca** hagas push a `main` ni fusiones la rama.

## Resumen final para Víctor

Termina con un mensaje breve, en castellano:
- qué se ha hecho (cinco líneas como máximo) y las cifras clave (errores
  corregidos, marcas resueltas, datos actualizados, gráficos rehechos);
- las **dudas abiertas** que necesitan su decisión;
- dónde mirar: `D/revision.md`, `D/guion-cante.md`, el PDF, el HTML (con
  `python3 -m http.server` en el worktree), el Word y el MP4 (`Vídeos\temario\T.mp4`),
  y el texto para YouTube (`Vídeos\temario\T-youtube.txt`);
- si algo no se pudo hacer (LyX sin instalar, Drive inaccesible, vídeo omitido…).

## Reglas

- Si una fase falla dos veces por lo mismo, no insistas: anótalo en
  «Dudas abiertas» y sigue con lo que se pueda.
- Ningún agente toca otros temas ni `main`.
- Si Víctor pide cambiar cómo se revisa, el cambio va a `CRITERIOS.md` (o a
  los agentes) en esta rama, con su commit.
