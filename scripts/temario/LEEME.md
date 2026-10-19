# Revisión del temario del 3.er y 4.º ejercicio (/revisartema)

Cada tema pasa del Word original a una fuente **LyX/LaTeX** con gráficos
**TikZ**, de la que salen el PDF, la página web y el Word. A la vez se
revisa, se actualiza y se preparan su ficha de repaso de cuatro páginas y su
cante de 30 minutos (guion y vídeo).

## Cómo se usa

1. Víctor escribe `/revisartema 3A08` (vale también `3.A.8`) desde la carpeta
   principal del repositorio (en `main`): la orden trabaja sola en el worktree
   de la rama `revision-temario`
   (`/mnt/c/Users/vgutierrez/Documents/src/victorgutierrezmarcos.github.io-revision`).
   Son tres entregas que Víctor aprueba una a una: el tema (`/revisartema T`),
   la ficha de repaso (`--fase repaso`) y el vídeo (`--fase video`). Cada
   entrega deja un resumen con las dudas abiertas y hace commit y push de la
   rama.
2. Revisar: `oposicion/temario/fuentes/3A08/revision.md` (informe), el PDF, el
   Word, la web (`python3 -m http.server 8790` en el worktree y abrir
   `localhost:8790/oposicion/temario/tercer-ejercicio/3A08.html`), la ficha
   (`tercer-ejercicio/3A08-repaso.pdf`), `guion-cante.md` y el vídeo
   (`oposicion/temario/videos/3A08.mp4`, fuera de git; mientras no esté el
   ordenador nuevo, el borrador sin voz `3A08-borrador.mp4`).
3. Subir el vídeo a YouTube como **no listado** (título, descripción con
   capítulos y subtítulos en `videos/3A08-youtube.txt` y `.srt`) y apuntar el
   enlace en `oposicion/temario/videos.json`: `{"3A08": "https://youtu.be/…"}`;
   después `python3 scripts/temario/construir-tema.py 3A08 --solo html` y
   `python3 scripts/temario/publicar-tema.py 3A08` para que aparezca el botón.
4. Cuando se quiera publicar todo lo revisado: fusionar `revision-temario`
   en `main` (solo cuando Víctor lo diga).

Para retomar o repetir una parte: `/revisartema 3A08 --fase <fase>` (fases:
extraer, revisar, integrar, graficos, construir, calidad, canon, publicar,
repaso, video, coherencia; `--canon` y `--organizacion` son generales; ver
`SKILL.md`).

## Cambiar cómo se revisa

- **Criterios** (estilo, fuentes, qué hacer con cada marca, duración, voz…):
  `.claude/skills/revisartema/CRITERIOS.md` (su tabla «Parámetros» tiene las
  cifras que usan agentes y scripts).
- **Pasos y orden**: `.claude/skills/revisartema/SKILL.md`.
- **Cada agente**: `.claude/agents/tema-*.md`.
- **Estética**: `oposicion/temario/latex/` (`tcee-comun.sty` para lo que
  comparten tema y ficha —idioma, Palatino, colores, `\autor`, `\vertema`,
  `\optim`, licencia—, `tcee.sty` para el PDF del tema, `tcee-repaso.sty` para
  la ficha, `tikz-tcee.tex` para los gráficos, `tema.css` y
  `plantilla-tema.html` para la web, `tcee.lua` y `pandoc-macros.tex` para
  pasar las órdenes a la web y a Word, `tcee.csl` para las citas de la web y
  Word, `reference.docx` para Word, que se rehace con `crear-reference-docx.py`,
  y `tcee.module` para que LyX entienda las órdenes) y `generar-video.py` para
  el vídeo. Si se añade una orden a `tcee-comun.sty` o `tcee.sty`, hay que
  añadir su equivalente en `pandoc-macros.tex` (o `tcee.lua`/`construir-tema.py`)
  y, si LyX debe entenderla, en `tcee.module`.
- **Autores de referencia**: `scripts/temario/referencias.json`.

## Ficheros de cada tema (`oposicion/temario/fuentes/<tema>/`)

| Fichero | Qué es |
|---|---|
| `<tema>.tex` y `<tema>.lyx` | La fuente. El `.tex` es el que escriben los agentes; el `.lyx` se regenera de él para que Víctor pueda abrirlo en LyX. Al construir, `estado.json` guarda la huella de los dos: si solo cambió el `.lyx` (Víctor), se exporta a `.tex`; si solo el `.tex`, se regenera el `.lyx`; si los dos, el script se para y avisa (nunca pisa ninguno). |
| `<tema>.bib` | Bibliografía y fuentes de los datos. |
| `graficos/*.tex` | Un gráfico TikZ por fichero (con sus `.pdf`, `.svg` y `.png` generados). |
| `datos/*.csv` | Series de los gráficos de datos, con su fuente. |
| `repaso/<tema>-repaso.tex` | La ficha de repaso de cuatro páginas (`tcee-repaso.sty`). |
| `revision.md` | Informe de la revisión para Víctor (secciones de CRITERIOS §9, con «Instrucciones para el vídeo»). |
| `seo.json` | Título para buscadores, resumen, palabras clave y materia de la página web (CRITERIOS §9 bis). |
| `guion-cante.md` | Plan de pizarra y guion del cante con tiempos. |
| `video/escenas.yaml` | Guion del vídeo por pasos. |
| `estado.json` | Fases hechas, aprobaciones de Víctor, huellas de la fuente y letra de la ficha (para retomar). |
| `_trabajo/` | Intermedios (extracción, propuestas, auxiliares de LaTeX, audios). No va a git. |

Los resultados públicos van a `oposicion/temario/<ejercicio>/<tema>.{pdf,html,docx}`,
`<tema>-repaso.pdf` y, la primera vez, `<tema>-anterior.{pdf,docx}` (la versión
de main antes de la revisión). Los SVG de la web se sirven desde `fuentes/<tema>/graficos/`.

## Scripts

| Script | Qué hace |
|---|---|
| `extraer-docx.py T` | Word original → Markdown con las marcas, imágenes, páginas del PDF e inventario de pendientes. Si el tema no tiene Word original (33 temas), deja un `original.md` con el título oficial y sus epígrafes e `inventario.json` con `sin_original: true`. |
| `indexar-referencias.py [--indexar] T` | Baja los temas de otros preparadores y de Manuel para el tema. |
| `construir-tema.py T [--solo pdf\|html\|docx\|graficos] [--grafico nombre] [--no-publicar]` | Gráficos, PDF, HTML y Word. Avisa de referencias sin definir, líneas desbordadas, marcadores raros, caracteres que faltan y de que los `\minutos` no sumen 30. |
| `construir-repaso.py T [--no-publicar]` | La ficha de repaso: elige la letra (10,5–8 pt) para que ocupe exactamente cuatro páginas; falla si no. |
| `verificar-tema.py T [--json]` | Comprobaciones finales (fuente, PDF, HTML, Word, ficha, informe, guion y escenas; reglas de CRITERIOS que se pueden comprobar). |
| `reconstruir-todos.py [T…] [--revisados] [--excepto T]` | Reconstruye varios temas (o todos los revisados) en dos pasadas, verifica y publica de una vez. Para cuando cambian las plantillas. |
| `generar-video.py T [--borrador] [--medir] [--tramo 3:00-6:00] [--fotogramas]` | Vídeo del cante (30:00 exactos). `--borrador` sin voz (duración estimada); `--medir` solo dice cuánto dura la narración y el ajuste de ritmo. |
| `voz-todos.py [--voz '{…}']` | En el ordenador nuevo: genera la voz de todos los temas con el borrador aprobado y vuelve a montar cada vídeo. |
| `publicar-tema.py T [T…]` | Enlaces en el índice, `temario.json` y buscador. |
| `manifiesto-app.py [--comprobar]` | `oposicion/temario/app/revisados.json`: lo que la app ofrece en exclusiva (temas y fichas aprobados). |
| `crear-reference-docx.py` | Plantilla de estilos de Word. |
| `word-a-pdf.vbs` | Word → PDF con Microsoft Word, para revisar (PowerShell está bloqueado). |

## Programas que usa

- **MiKTeX** (pdflatex, biber, pdftocairo) y el **pandoc** de Quarto, en Windows.
- **LyX** en Windows (para el `.lyx`; sin él se trabaja con el `.tex`).
- Python: python-docx, PyMuPDF, Pillow, lxml, PyYAML, gdown, edge-tts,
  imageio-ffmpeg (`pip install --user --break-system-packages …`).
- Voz: VoiceStudio (backend local en `~/src/VoiceStudio`, `~/src/arrancar-voicestudio.sh`),
  XTTS (`~/.venvs/voz`) o Edge TTS (necesita la versión de Edge instalada en
  Windows; el script la detecta sola). Rutas configurables con las variables
  de entorno `TCEE_*` que lista la cabecera de `generar-video.py`.
- Los Word originales están en `oculto/` del repositorio principal (no en git);
  los scripts los leen de ahí (`TCEE_REPO_MAIN`).

Autor: Víctor Gutiérrez Marcos
