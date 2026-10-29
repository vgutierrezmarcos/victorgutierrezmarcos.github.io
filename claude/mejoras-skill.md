# Prepara con Claude: mejoras de la skill antes de lanzar el vídeo (28-29 oct. 2026)

Víctor preguntó el 28 oct. por la noche: (1) si todo lo que genera la skill puede usar la misma plantilla LaTeX que los temas; (2) si hay una forma más sencilla de instalarla (¿un repositorio aparte?); (3) qué más se puede mejorar; (4) si el MCP seguía pendiente; (5) si el vídeo puede contar que Claude también está en el móvil. También pasó el artículo de Anthropic «When to fold subagents into your main agent loop» (22 oct. 2026) preguntando si se tuvo en cuenta.

## 0. Lo comprobado el 28 oct. en claude.ai

Pedido a Claude en un chat sin skill que ejecutara `command -v` en su entorno de código (captura `latex2-1.png` en la carpeta de grabación):

| Hay | No hay |
|---|---|
| `pdflatex`, `xelatex`, `lualatex`, `latexmk`, `kpsewhich` (TeX Live en `/usr/share/texlive`) | `tectonic`, `typst`, Chromium |
| `pandoc`, `soffice`/`libreoffice`, `wkhtmltopdf` | `weasyprint`, `fpdf`, `fitz` |
| Python: `reportlab`, `matplotlib`, `python-docx`, `pypdf`, `PIL` | |

Conclusión: **la plantilla LaTeX de los temas es viable en claude.ai**, y `scripts/grafico.py` (matplotlib) también.

## 1. Misma plantilla LaTeX que los temas

Propuesta (sin hacer todavía; pide el visto bueno de Víctor porque cambia `informe-pdf.py` y copia ficheros de la rama de revisión):

- Copiar a la skill `assets/latex/tcee-comun.sty` (colores, licencia, pie de exclusivo) y escribir `assets/latex/tcee-informe.sty`: la versión corta de `tcee.sty` para documentos de 2-8 páginas (geometría, cabecera y pie `fancyhdr` iguales a los temas, banda de sección `titlesec`, cajas `tcolorbox` para «Para la app», «Aviso» y citas, sin TikZ ni pgfplots). Variante DCE con `\dceoposicion`: granate `#7A1F4B`, azul `#234A6B`, crema, Latin Modern (`lmodern`) en vez de newpx.
- `informe-pdf.py`: `pandoc fichero.md -t latex --template assets/latex/informe.tex` → `latexmk -pdf` (pdflatex). Si no hay TeX (Claude Desktop sin MiKTeX), la ruta actual DOCX → PDF con LibreOffice/Word sigue como alternativa. Las fórmulas `$…$` del Markdown pasan a LaTeX sin tocarlas (hoy pandoc las convierte a ecuaciones de Word).
- Vale para todo lo que entrega la skill: informe del cante, del dictamen, fichas propias, cronograma, resumen de una duda. Un solo aspecto: el del temario.
- Paquetes comprobados el 28 oct. (TeX Live 2023/Debian del sandbox, captura `latex3-1.png`): **hay** tcolorbox, pgfplots, tikz, titlesec, fancyhdr, lastpage, microtype, csquotes, enumitem, booktabs, tabularx, multirow, caption, float, footmisc, needspace, hhline, setspace, etoolbox, fontspec, xcolor, geometry, hyperref, mathtools; **no hay** newpxtext/newpxmath, lmodern, tgpagella, ulem, ccicons, y `babel-spanish` no se encontró como `.sty` (hay que comprobar `spanish.ldf`). `fc-list` da 77 fuentes Pagella/Latin Modern instaladas en el sistema. Por tanto: compilar con **xelatex + fontspec** usando las OTF que la skill ya lleva en `assets/fuentes` (Pagella para TCEE, Latin Modern para DCE) en vez de newpx; `\uline` con `soul` o un `\underline` propio; sin ccicons (el pie de licencia en texto); y meter `spanish.ldf` (babel) en `assets/latex/` con `TEXINPUTS` si falta. Las fórmulas con `unicode-math` o `amsmath` normal.

## 2. Instalación más sencilla

Lo que permite claude.ai hoy (help center, comprobado el 28 oct.): skills propias solo por **ZIP** (Customize → Skills → + → Subir), o desde la biblioteca de la organización en Team/Enterprise. No hay instalación por URL ni desde GitHub. **Una skill subida a claude.ai se sincroniza sola con Claude Code** (misma cuenta) y vale en los complementos de Office; el help center no nombra las apps de iOS/Android: hay que probarlo en el móvil de Víctor.

Lo que ya tenemos: el botón «Empezar en Claude» (sin instalar) y el Proyecto con la instrucción en claude.ai; la skill instalada se actualiza sola desde la web.

Un repositorio aparte **no simplifica la instalación en claude.ai**; sí serviría para Claude Code, Cursor, Codex y similares con `npx skills add victorgutierrezmarcos/prepara-oposicion` (CLI de Vercel, lee `SKILL.md` de un repo público). Como la copia desplegada en `oposicion/temario/app/skill/` ya es pública (GitHub Pages), un espejo público no expone nada nuevo. Propuesta: que `scripts/skill-opositor.py` empuje la carpeta desplegada a un repo `prepara-oposicion` (rama `main`, un commit por versión) y la página añada una línea «En Claude Code: `npx skills add …`». Hacerlo cuando haya opositores que usen Claude Code; para el 95 % (claude.ai en el navegador o el móvil) el camino sigue siendo ZIP o «Empezar en Claude».

## 3. Más mejoras (por orden de valor para el opositor)

1. **Simulacro completo del tercer ejercicio**: sortea cuatro bolas con los pesos de la app, el opositor elige, 45 min de esquema (le da la hora), transcripción, corrección y tribunal. Una sola petición: «hazme un simulacro».
2. **Tribunal por voz en el móvil**: la app de Claude tiene modo de voz; el agente `tribunal` ya existe. Solo hay que decir en la skill y en la web que las preguntas de «más allá del temario» se pueden contestar hablando.
3. **Informe semanal**: con el JSON exportado y los informes de los cantes de la semana, qué ha mejorado, qué se repite y las tres tareas de la semana que viene (ya existe `estadisticas`; faltan la comparación semana a semana y la plantilla).
4. **Test a medida desde `preguntas.json` con explicaciones**: hoy el agente `test-personal` inventa preguntas; con el banco de 1004 explicaciones puede sacar preguntas reales de los temas flojos y explicar el porqué con la explicación de la web.
5. **Tarjetas de repaso (Leitner) exportables** a la app: «hazme 20 tarjetas del 3.A.8» → fichero que la app importe (tarea de la app).
6. **Evals repetidos**, como pide el artículo de Anthropic: los cuatro casos de `evals/` ejecutados tres veces cada uno, con y sin skill, antes de cada versión (`/skill-creator`). Hoy están escritos pero no se han corrido.
7. **Modo preparador**: el preparador humano puede usar la skill con los cantes de sus alumnos para preparar la clase (ya funciona; falta un párrafo en la web para preparadores).
8. **Checklist del día del examen** y **guía de la pizarra** (qué dibujar en cada tema revisado, con el minuto) como ficheros de referencia.

## 4. MCP (fase 2)

Sigue pendiente: diseño en `claude/mcp-fase-2.md` (Cloudflare Worker con OAuth, lee Firestore con el ID token del alumno; sin servidor propio ni Blaze). Se hará cuando los eventos de Analytics de la app (`claude_abrir`, `claude_corregir_cante`, `claude_cronograma`) muestren uso. Con el MCP el opositor no exporta nada: Claude lee sus cantes y escribe el cronograma y los informes.

## 5. El artículo de Anthropic sobre subagentes

La skill ya sigue lo que recomienda: **un solo bucle** (el chat de claude.ai) con divulgación progresiva: `SKILL.md` enruta y carga `references/agentes/*.md` según la petición; no hay subagentes ni traspasos. Lo que falta de ahí: los evals de extremo a extremo repetidos (punto 3.6) y un dueño del «system prompt» (SKILL.md) que apruebe cada cambio: Víctor.

## 6. El móvil en el vídeo

Escena nueva «En el móvil» (compás 85): la app (diario de cantes) → la app de Claude con el `.txt` adjunto → la respuesta. Capturas de claude.ai con viewport de móvil (412 × 893 × 2,6). Antes de renderizar, Víctor debe comprobar en su móvil que la skill se activa en la app de Claude (compartir un `.txt` desde la app y pedir la corrección); si no, el texto de la escena cambia a «desde el navegador del móvil».

## Estado (29 oct. 2026, madrugada)

Víctor pidió hacerlo todo. Hecho y confirmado en `main`:

- **Plantilla LaTeX** (apartado 1): `assets/latex/informe.sty` (opción `tcee`/`dce`, XeLaTeX + fontspec con las OTF de la skill, cabecera y pie como los temas, banda de sección, cajas con el fondo de la app, aviso en caja pálida, tablas booktabs), `informe.tex` (plantilla de pandoc) e `informe.lua` (aviso final y anchos de tabla). `informe-pdf.py --motor latex|docx|auto`: LaTeX si hay xelatex, DOCX si no o si falla. Probado hasta el `.tex` en local (MiKTeX no compila con C: lleno) y compilado en el sandbox de claude.ai (ver el resultado de la prueba `latexsb2.json` en la carpeta de grabación).
- **Conector MCP** (apartado 4): `mcp/` completo (Worker, OAuth, login, herramientas, contenido en KV, tests, README), reglas de informes del cante, privacidad; falta desplegar (pasos en `claude/mcp-fase-2.md`, «Estado»).
- **Medidas** (apartado 3): simulacro, informe semanal, tarjetas, test con las 1004 preguntas oficiales y sus explicaciones (`references/test/`), tribunal por voz, modo preparador, checklist del examen, guía de la pizarra; evals nuevos escritos (no ejecutados). Espejo para `npx skills add`: `scripts/skill-espejo.py` listo, repo sin crear.
- **Skill desplegada 2026.10.29-16** y ZIP completo y ligero (`--ligera`) en la rama de revisión.

Queda en manos de Víctor: desplegar el Worker, publicar las reglas, crear el repo espejo (o no), probar la skill en el móvil y ejecutar los evals.
