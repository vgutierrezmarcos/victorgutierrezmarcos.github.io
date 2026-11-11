# Vídeo «EconomIA» (clave `claude-prepara`)

Apaisado 1920×1080, tres minutos como máximo (2:59 desde el 11 nov.), sin voz (rótulos y pantallas grabadas), con la música y la estética del promocional de la app (`scripts/video-app/`). Se publica con `/videos` (clave `claude-prepara`) y lo enlazan `oposicion/economia.html`, `app/index.html#claude` y la app (Más → EconomIA).

Qué hace falta grabar (Víctor, con su cuenta de Claude.ai; grabación de pantalla a 1920×1080, sin voz, despacio, con el ratón visible):

| # | Toma | Dónde | Segundos |
|---|---|---|---|
| G1 | Descargar la skill desde la web con la sesión iniciada (botón) y desde la app (Más → Prepara con Claude → Descargar) | web + móvil (grabación del móvil o emulador) | 15 |
| G2 | claude.ai: Ajustes → Skills → Añadir → Subir Skill → elegir el ZIP → Subir → aparece «prepara-oposicion» en «Tuyos» | claude.ai | 20 |
| G3 | App: Cantar → «Transcribir» → reloj corriendo (acelerado) → guardar en el diario → «Enviar a Claude» | móvil | 20 |
| G4 | claude.ai: chat nuevo, adjuntar el `.txt`, escribir «corrige este cante» → el informe aparece (scroll lento por las ocho secciones) → el PDF generado, abierto | claude.ai | 35 |
| G5 | claude.ai: foto de un dictamen a mano + «corrige este dictamen» → informe | claude.ai | 20 |
| G6 | claude.ai: «¿dónde se estudia la ecuación de Slutsky y con qué temas conecta?» → respuesta con las fuentes | claude.ai | 15 |
| G7 | App: Más → Prepara con Claude → Exportar mis datos → claude.ai: «hazme el cronograma hasta el examen» → copiar el bloque → app: Cronograma → Traer el tuyo → pegar → el cronograma en Hoy | móvil + claude.ai | 35 |
| G8 | El explorador de ficheros con la carpeta «Oposición TCEE» ordenada (0_organizacion, 1_primer_ejercicio, 3_tercer_ejercicio/A/3A08/cantes…) y Claude Desktop (o Claude Code) trabajando sobre ella: «corrige el cante de hoy y guarda el informe al lado» → el PDF aparece en `cantes/` del tema | escritorio | 30 |

## Cambio a «EconomIA» (30 oct., sin renderizar)

El conector se llama «Oposición TCEE · DCE» y funciona en Claude, ChatGPT, Le Chat y Gemini (con Claude, completo). En `index.html`: marca y portada con el icono de la app y «EconomIA» (sin el asterisco de Claude), escena nueva **plataformas** tras «porque» (4 compases: «En tu IA. Con Claude, completo.» y una tarjeta por IA), las tomas corridas 4 compases y el cierre con las cuatro IA y `economia.html`; el resto de escenas sigue enseñándolo en Claude. Antes de renderizar hay que **volver a grabar G2c** (la página de autorización y la de entrar con Google ya no llevan el asterisco ni el nombre antiguo) y revisar las capturas de `claude-movil-*` (el conector puede salir con el nombre antiguo).

## Escenas (versión del 11 nov.: 2:59, 82 compases)

El 11 nov. se acortó de 4:39 a 2:59 y se añadieron las vistas interactivas del conector (MCP Apps). Las tomas grabadas son las mismas, aceleradas (`guion.json` → `tomas`: de qué escena cuelga cada una, cuánto dura en el vídeo y qué tramo de la grabación se usa; `preparar.py` las recodifica en `assets/tomas/r-*.mp4`). Las vistas son capturas reales de `mcp/worker/src/vistas/` hechas con `vistas/capturar.py` (cliente simulado, datos de ejemplo con preguntas y títulos reales); en el vídeo van dentro de un cuadro con el nombre del conector, un cursor pulsa el botón y la captura pasa de «antes» a «después».

1. **Portada** (2 compases) y **gancho** (3): igual que antes, más breve.
2. **Qué hace** (4): seis tarjetas; el test, «en el propio chat».
3. **No es un chatbot genérico** (4): temario, tu preparación real, memoria y «al día y en tus manos» (antes era una escena aparte al final).
4. **En qué IA funciona** (3).
5. **Conectar** (6, toma G2c): tres pasos.
6. **Un cante** (3 + 4 + 4): la app transcribe → adjuntar y pedir (G4a) → el informe (G4b), el PDF y **la vista del informe**: nota, rúbrica y deberes, y el botón «Guardar en la app».
7. **Un dictamen** (6, G5a y G5b).
8. **Una duda** (4, G6a y G6b) y **con gráfico** (4, G10a y G10b).
9. **El cronograma** (6 + 4): en DCE (G9na y G9nb) → en TCEE, **la vista del cronograma** por meses, el botón de guardar y cómo queda en la app.
10. **Un test** (4, nuevo): **la vista del test** con la figura de la pregunta; al contestar, la corrección y el porqué.
11. **Una clase** (5): la petición, **la vista de la clase** con «Pedir la clase» y la agenda de la app.
12. **Tu carpeta** (5, G8), **en el móvil** (3) e **y mucho más** (4; una de las peticiones es de preparador).
13. **Cierre** (4).

Quitadas: «Claude ya conoce tus datos» (lo dice el rótulo del cronograma), la toma G7b y «Al día» (su contenido va en la escena 3; la tarjeta de «material exclusivo» ya no sale).

## Montaje (hecho el 28 oct. con HyperFrames)

`index.html` es la composición (copiada del promocional `scripts/video-app/`: misma paleta, GSAP, rótulos de bloque y barrido dorado; la escena de DCE usa el granate, el azul y Latin Modern). `guion.json` fija el compás en que empieza cada escena; `preparar.py` lo lleva al HTML y prepara `assets/` (fuentes, el asterisco del logo de Claude —el nombre va siempre en Pagella, nunca con la letra de la marca; el icono de la app aparece aparte, en la portada y el cierre—, capturas de la app y de claude.ai en el móvil, páginas del informe en PDF, las tomas MP4 y la banda sonora de `musica.py`: la música del promocional compuesta de una pieza para esta duración, con un respiro en cada cambio de bloque, sin bucle ni cortes). La ventana de las tomas tiene su misma proporción (1912 × 948) y `object-fit: contain`, para que no se recorten los lados. El rótulo de bloque (arriba a la derecha) lleva solo el nombre del bloque; «Prepara con Claude» aparece una vez, en la marca de arriba a la izquierda. Las tomas se graban en un Edge aparte con `cdp.mjs` y se montan con `montar-toma.py` (carpeta `C:\Users\vgutierrez\AppData\Local\Temp\claude-video`); van en la raíz de `index.html`, fuera de las escenas, porque HyperFrames no admite un `<video data-start>` dentro de otro elemento con `data-start`. Rótulos sobre cada toma: qué está pasando y qué aporta.

```bash
python3 scripts/video-claude/vistas/capturar.py # solo si cambian las vistas del conector: rehace las capturas
python3 scripts/video-claude/preparar.py        # recursos, compases, tomas aceleradas y música
cd scripts/video-claude && npx hyperframes lint && npx hyperframes render -o ~/.local/share/oposicion-web/videos/claude-prepara-render.mp4
python3 scripts/video-claude/publicar.py --render ~/.local/share/oposicion-web/videos/claude-prepara-render.mp4 --web --subir  # MP4 para la web, pósteres y YouTube (clave claude-prepara)
```

Después, quitar `hidden` a los reproductores de `oposicion/economia.html` y `app/index.html#claude` y hacer commit de `videos.json`. Nunca usar `scripts/montar-video-app.py`.
