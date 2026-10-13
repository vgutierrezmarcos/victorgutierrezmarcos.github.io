---
name: revisartema
description: Revisa de principio a fin un tema del 3.er o 4.º ejercicio de la oposición TCEE (p. ej. /revisartema 3A08), coherente con el resto del temario (canon común de notación y modelos, referencias «[ver tema …]»). En tres entregas que Víctor aprueba por separado: el tema (LyX/LaTeX con gráficos TikZ → PDF, HTML y Word), la ficha de repaso de dos páginas y el vídeo del cante de 30 minutos. Todo en la rama revision-temario.
argument-hint: "<tema> [--fase extraer|revisar|integrar|graficos|construir|calidad|canon|publicar|repaso|video|coherencia] | --canon | --organizacion"
---

# /revisartema

Orquestas un equipo de agentes (`.claude/agents/tema-*.md`) que deja **un
tema** revisado, coherente con el resto del temario, en tres entregas que
Víctor aprueba una a una:

1. **El tema** (HTML, PDF y Word) → **parada**: Víctor lo revisa.
2. **La ficha de repaso** de dos páginas, solo con el tema aprobado → **parada**.
3. **El vídeo** del cante, solo con el tema y la ficha aprobados → **parada**.

Argumentos: `$ARGUMENTS`. El primero es el código del tema (3A08, 3.A.8,
4B12…). Sin `--fase`, se hace la entrega que toque según `D/estado.json`.
Además:
- `--fase X`: empezar o repetir esa fase.
- `--fase coherencia`: poner al día un tema **ya revisado** con los cambios
  del canon (notación, modelos, referencias), sin revisarlo de nuevo.
- `--canon`: rehacer el repaso general del temario y el canon (abajo).
- `--organizacion`: al final de todo, propuesta de cambios al PowerPoint de
  organización del temario (abajo).

## Antes de nada

1. Lee `.claude/skills/revisartema/CRITERIOS.md` entero (manda sobre todo lo
   demás) y el **canon**: `oposicion/temario/canon/LEEME.md`, `notacion.md`,
   las fichas de `modelos/` de los modelos que salen en el tema y `mapa.yaml`.
2. Víctor lanza la orden desde la carpeta principal del repositorio (que está
   en `main`): **no** le pidas que abra otra carpeta. Todo el trabajo se hace
   en el worktree de la rama, `R = /mnt/c/Users/vgutierrez/Documents/src/victorgutierrezmarcos.github.io-revision`
   (si no existe, créalo con `git worktree add ../victorgutierrezmarcos.github.io-revision revision-temario`),
   con rutas absolutas y `git -C R …`. Comprueba que `git -C R rev-parse --abbrev-ref HEAD`
   da `revision-temario`. **Nunca** cambies de rama la carpeta principal ni
   trabajes en `main`.
3. Pasa a todos los agentes **rutas absolutas** del worktree. Llamamos `R` a la
   raíz del worktree, `T` al código del tema (3A08) y `D = R/oposicion/temario/fuentes/T`.
4. Fusiona lo último de main en la rama: `git fetch origin && git merge --no-edit origin/main`
   (fusionar, nunca rebasar). Si hay conflictos, para y avisa.
5. Lee `D/estado.json` si existe: fases hechas y aprobaciones de Víctor
   (`"aprobado": {"tema": "2026-10-20", "repaso": null, "video": null}`).
   Al acabar cada fase, márcala con fecha y hora en `"fases"`. Las
   aprobaciones solo las anotas cuando Víctor las da explícitamente.
6. Crea una lista de tareas (TodoWrite) con las fases, para que Víctor vea el avance.
7. Si el tema tiene entradas en `canon/pendientes-coherencia.md` (cambios del
   canon posteriores a su revisión), aplícalas en la fase de integrar.

Comprueba también LyX: `python3 -c "import sys; sys.path.insert(0,'R/scripts/temario'); import comun; print(comun.LYX)"`.
Si da `None`, sigue sin LyX (se trabaja sobre el `.tex`) y avísalo en el resumen final.

## Orden de revisión de los temas

Por bloques de `oposicion/organizacion/estructura_temario.json` y, dentro de
cada bloque, primero los **temas de referencia** de sus modelos (donde
`mapa.yaml` dice que el modelo se desarrolla en extenso): así los demás temas
resumen algo ya fijado. El orden propuesto está en `canon/informe-repaso.md`.
Si Víctor pide otro tema, se hace ese, pero avísale si su tema de referencia
aún no está revisado (y apóyate en la ficha del canon).

## Entrega 1: el tema

### 1. extraer — agente `tema-extractor`
Ejecuta `extraer-docx.py` e `indexar-referencias.py` y prepara
`D/_trabajo/pendientes.md` (lista numerada de todo lo que hay que resolver) y
`D/_trabajo/estructura.md` (índice del tema original con su extensión).

### 2. revisar — tres agentes **en paralelo** (un solo mensaje con tres llamadas)
- `tema-revisor-contenido` → `D/_trabajo/propuestas-contenido.md`
- `tema-verificador-datos` → `D/_trabajo/propuestas-datos.md` y `D/_trabajo/bib-datos.bib`
- `tema-coherencia` → `D/_trabajo/propuestas-coherencia.md`: estructura final
  con minutos, referencias «[ver tema …]» corregidas, notación y modelos según
  el canon (o propuestas de cambio al canon) y coherencia con los temas del
  bloque y los citados.

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
compila y lo compara con el original. Si el gráfico es el de un modelo del
canon, parte de su gráfico de referencia (`canon/modelos/<id>.md`) para que
se reconozca igual en todos los temas.

### 5. construir — tú mismo
`python3 R/scripts/temario/construir-tema.py T`. Si falla, pásale el error a
`tema-editor-lyx` (o a `tema-tikz` si es de un gráfico) para que lo arregle y
repite (máximo 3 intentos). Si LyX está instalado, el script sincroniza el
`.lyx` y el `.tex`.

### 6. calidad — agente `tema-control-calidad`
Ejecuta `verificar-tema.py`, revisa PDF, HTML y Word, y lee el informe. Si
devuelve correcciones, mándalas a `tema-editor-lyx` (o al agente que toque),
vuelve a construir y repite la calidad **una vez** como máximo. Lo que quede
va a «Dudas abiertas» de `revision.md`.

### 7. canon — agente `tema-canon`
Lleva al canon lo que el tema fija o cambia: símbolos nuevos de
`notacion.md`, fichas de modelos (presentación de referencia si este es su
tema de referencia; variante resumida si no), y `mapa.yaml` (referencias,
modelos y estado del tema). Si un cambio afecta a temas **ya revisados**, los
anota en `canon/pendientes-coherencia.md` con qué hay que cambiar.

### 8. publicar — tú mismo
1. `python3 R/scripts/temario/publicar-tema.py T` (índice de la web de la
   rama con HTML, PDF y Word, `temario.json`, buscador).
2. Comprueba con `git status` que solo cambian cosas del tema `T`, su línea en
   el índice, `temario.json`, `search-index.json`, el canon y, si hizo falta,
   la infraestructura común. `_trabajo/` y `oposicion/temario/videos/` no
   deben aparecer (están en .gitignore).
3. Commit en `revision-temario`: `Tema <código> revisado: <resumen>` y, en el
   cuerpo, el resumen de `revision.md` (sin las tablas), con las líneas de
   atribución que indique el sistema.
4. `git push origin revision-temario`. Si da 403, la cuenta activa de `gh` es
   la del trabajo: usa
   `git -c credential.helper= -c 'credential.helper=!f(){ echo username=x-access-token; echo password=$(gh auth token -u vgutierrezmarcos); }; f' push origin revision-temario`.
   **Nunca** hagas push a `main` ni fusiones la rama: pasar a `main` (lo que
   ven los usuarios) lo decide Víctor, por tandas.

**Parada**: resumen para Víctor y espera a que apruebe el tema (o pida cambios).

## Entrega 2: la ficha de repaso (`--fase repaso`, con el tema aprobado)

Agente `tema-repaso`: escribe `D/repaso/T-repaso.tex` (dos páginas) y la
compila con `construir-repaso.py T`; luego
`construir-tema.py T --solo html` (para que la página enlace la ficha) y
`publicar-tema.py T`. Commit y push como arriba. **Parada**.

## Entrega 3: el vídeo (`--fase video`, con tema y ficha aprobados)

1. `tema-guionista` → `D/guion-cante.md` y `D/video/escenas.yaml`, con todas
   las reglas de CRITERIOS («Vídeo»): pregunta de enganche y respuesta en el
   cierre, registro cercano con énfasis y pausas, voz que no se para,
   coordinación exacta voz–pizarra, apoyo visual, rejilla. Itera con
   `generar-video.py T --borrador --medir` hasta 0 avisos y ritmo ×0,95–1,05.
2. **Mientras no esté el ordenador nuevo** (Víctor, 14/10/2026): el vídeo se
   monta **sin audio** (`generar-video.py T --borrador`, duración estimada) y
   se le pasa para revisar la pizarra. La voz de todos los temas se pone de
   golpe en el ordenador nuevo con `scripts/temario/voz-todos.py` (genera la
   voz de cada tema y vuelve a montar el vídeo sincronizado con ella).
   Después: `tema-video` → voz (motor de `voz:`), vídeo de 30:00 exactos y
   comprobación de fotogramas. Los vídeos van todos a
   `R/oposicion/temario/videos/` (fuera de git): **no se publican** hasta
   que Víctor tenga todos y los suba a YouTube; entonces se rellena
   `oposicion/temario/videos.json`.
3. Commit y push del guion y las escenas. **Parada**.

## `--fase coherencia` (tema ya revisado)

Agente `tema-coherencia` en modo ligero: aplica al tema las entradas de
`canon/pendientes-coherencia.md` que le tocan (notación, presentación del
modelo, referencias) a través de `tema-editor-lyx`; se reconstruye, se
publica en la rama y se borra la entrada. Si cambia algo que sale en la ficha
o en el vídeo, se anota para rehacerlos.

## `--canon`: repaso general del temario

Agentes en paralelo por grupos de bloques (solo lectura) que dejan un
inventario por tema en `canon/_inventario/<T>.json` (formato en
`canon/_inventario/LEEME-agentes.md`); después `tema-canon` lo consolida en
`notacion.md`, `modelos/`, `mapa.yaml` e `informe-repaso.md` (referencias
rotas, modelos contados de forma distinta, notaciones en conflicto y orden de
revisión propuesto). Se hace una vez al principio y se puede repetir.

## `--organizacion`: al final

Con `mapa.yaml` completo, propuesta razonada de cambios a la organización del
temario (`oposicion/organizacion/estructura_temario.ppsx` y su `.json`):
bloques, relaciones entre temas, tema de referencia de cada modelo. Se
entrega como documento para que Víctor decida; no se toca el PowerPoint sin
su aprobación.

## Resumen para Víctor en cada parada

Breve, en castellano:
- qué se ha hecho (cinco líneas como máximo) y las cifras clave;
- las **dudas abiertas** que necesitan su decisión;
- qué cambió en el canon y qué temas ya revisados quedan pendientes de
  coherencia;
- dónde mirar: `D/revision.md`, el PDF, el HTML (con `python3 -m http.server`
  en el worktree), el Word, la ficha, y el MP4 en `oposicion/temario/videos/`;
- si algo no se pudo hacer.

## Reglas

- Si una fase falla dos veces por lo mismo, no insistas: anótalo en
  «Dudas abiertas» y sigue con lo que se pueda.
- Ningún agente toca otros temas ni `main` (los cambios a otros temas pasan
  por `canon/pendientes-coherencia.md`).
- Si Víctor pide cambiar cómo se revisa, el cambio va a `CRITERIOS.md` (o a
  los agentes) en esta rama, con su commit.
