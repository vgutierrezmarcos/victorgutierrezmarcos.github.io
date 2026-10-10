# Revisión del temario del 3.er y 4.º ejercicio (/revisartema)

Cada tema pasa del Word original a una fuente **LyX/LaTeX** con gráficos
**TikZ**, de la que salen el PDF, la página web y el Word. A la vez se
revisa, se actualiza y se prepara su cante de 30 minutos (guion y vídeo).

## Cómo se usa

1. Abrir Claude Code **en el worktree de la rama** (no en el repositorio principal):

   ```
   cd /mnt/c/Users/vgutierrez/Documents/src/victorgutierrezmarcos.github.io-revision
   claude
   ```

2. Escribir `/revisartema 3A08` (vale también `3.A.8`). Tarda varias horas;
   al final deja un resumen con las dudas abiertas y hace commit y push de la
   rama `revision-temario`.
3. Revisar: `oposicion/temario/fuentes/3A08/revision.md` (informe),
   `guion-cante.md`, el PDF, el Word, la web (`python3 -m http.server 8790`
   en el worktree y abrir `localhost:8790/oposicion/temario/tercer-ejercicio/3A08.html`)
   y el vídeo (`Vídeos\temario\3A08.mp4`).
4. Subir el vídeo a YouTube como **no listado** (título, descripción con
   capítulos y subtítulos en `Vídeos\temario\3A08-youtube.txt` y `.srt`) y
   apuntar el enlace en `oposicion/temario/videos.json`:
   `{"3A08": "https://youtu.be/…"}`; después
   `python3 scripts/temario/construir-tema.py 3A08 --solo html` y
   `python3 scripts/temario/publicar-tema.py 3A08` para que aparezca el botón.
5. Cuando se quiera publicar todo lo revisado: fusionar `revision-temario`
   en `main` (solo cuando Víctor lo diga).

Para retomar o repetir una parte: `/revisartema 3A08 --fase graficos` (fases:
extraer, revisar, integrar, graficos, construir, guion, video, calidad,
publicar). Sin vídeo: `--sin-video`.

## Cambiar cómo se revisa

- **Criterios** (estilo, fuentes, qué hacer con cada marca, duración, voz…):
  `.claude/skills/revisartema/CRITERIOS.md`.
- **Pasos y orden**: `.claude/skills/revisartema/SKILL.md`.
- **Cada agente**: `.claude/agents/tema-*.md`.
- **Estética**: `oposicion/temario/latex/` (`tcee.sty` para el PDF,
  `tikz-tcee.tex` para los gráficos, `tema.css` y `plantilla-tema.html` para
  la web, `reference.docx` para Word, que se rehace con
  `crear-reference-docx.py`) y `generar-video.py` para el vídeo.
- **Autores de referencia**: `scripts/temario/referencias.json`.

## Ficheros de cada tema (`oposicion/temario/fuentes/<tema>/`)

| Fichero | Qué es |
|---|---|
| `<tema>.lyx` y `<tema>.tex` | La fuente. Se pueden editar los dos: al construir manda el más reciente y el otro se regenera. |
| `<tema>.bib` | Bibliografía y fuentes de los datos. |
| `graficos/*.tex` | Un gráfico TikZ por fichero (con sus `.pdf`, `.svg` y `.png` generados). |
| `datos/*.csv` | Series de los gráficos de datos, con su fuente. |
| `revision.md` | Informe de la revisión para Víctor. |
| `guion-cante.md` | Esquema de pizarra y guion del cante con tiempos. |
| `video/escenas.yaml` | Guion del vídeo por pasos. |
| `estado.json` | Fases hechas (para retomar). |
| `_trabajo/` | Intermedios (extracción, propuestas, audios). No va a git. |

Los resultados públicos van a `oposicion/temario/<ejercicio>/<tema>.{pdf,html,docx}`.

## Scripts

| Script | Qué hace |
|---|---|
| `extraer-docx.py T` | Word original → Markdown con las marcas, imágenes, páginas del PDF e inventario de pendientes. |
| `indexar-referencias.py [--indexar] T` | Baja los temas de otros preparadores y de Manuel para el tema. |
| `construir-tema.py T [--solo pdf\|html\|docx\|graficos]` | Gráficos, PDF, HTML y Word. |
| `verificar-tema.py T` | Comprobaciones finales. |
| `generar-video.py T [--medir] [--tramo 3:00-6:00] [--borrador]` | Vídeo del cante (30:00 exactos). `--medir` solo dice cuánto dura la narración. |
| `publicar-tema.py T` | Enlaces en el índice, `temario.json` y buscador. |
| `crear-reference-docx.py` | Plantilla de estilos de Word. |
| `word-a-pdf.vbs` | Word → PDF con Microsoft Word, para revisar (PowerShell está bloqueado). |

## Programas que usa

- **MiKTeX** (pdflatex, biber, pdftocairo) y el **pandoc** de Quarto, en Windows.
- **LyX** en Windows (para el `.lyx`; sin él se trabaja con el `.tex`).
- Python: python-docx, PyMuPDF, Pillow, lxml, PyYAML, gdown, edge-tts,
  imageio-ffmpeg (`pip install --user --break-system-packages …`).
- Edge TTS necesita la versión de Edge instalada en Windows; el script la
  detecta sola.
- Los Word originales están en `oculto/` del repositorio principal (no en git);
  los scripts los leen de ahí (`TCEE_REPO_MAIN`).

Autor: Víctor Gutiérrez Marcos
