# Vídeo «Prepara la oposición con Claude» (clave `claude-prepara`)

Apaisado 1920×1080, 3-4 minutos, sin voz (rótulos y pantallas grabadas), con la música y la estética del promocional de la app (`scripts/video-app/`). Se publica con `/videos` (clave `claude-prepara`) y lo enlazan `oposicion/prepara-con-claude.html`, `app/index.html#claude` y la app (Más → Prepara con Claude).

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

## Escenas

1. **Portada** (0:00-0:08). «Prepara con Claude» · «Tu equipo de preparación, con tu temario y tus datos» · rótulo pequeño: «No sustituye a un preparador: lo complementa».
2. **Qué es** (0:08-0:25). Tres rótulos sobre la página web: corrige tus cantes y dictámenes · resuelve dudas viendo el temario entero · organiza tu cronograma y lo manda a la app. Logo de Claude.
3. **Instalar** (0:25-0:50). G1 + G2 con tres rótulos: «1. Descarga el ZIP» · «2. Ajustes → Skills → Añadir → Subir Skill» · «3. Escribe lo que quieras».
4. **Un cante** (0:50-1:45). G3 + G4. Rótulos: «La app transcribe con marcas de minuto» · «Errores con el minuto y la fuente» · «Lo que te preguntaría el tribunal» · «El informe, en PDF con la estética de tu oposición».
5. **Un dictamen** (1:45-2:05). G5. Rótulo: «Aunque esté a mano».
6. **Una duda** (2:05-2:20). G6. Rótulo: «Ve el temario en conjunto y cita dónde se estudia».
7. **El cronograma** (2:20-2:55). G7. Rótulos: «Exporta tus datos» · «Pide el cronograma» · «Tráelo a la app».
8. **Tu carpeta** (2:55-3:25). G8. Rótulos: «Una carpeta ordenada con toda la oposición» · «Claude trabaja desde ella: lee, corrige y guarda» · «Los informes, junto a cada cante».
9. **Cierre** (3:25-3:40). «Hace falta Claude Pro (unos 20 € al mes)» · «Material exclusivo: para tu uso personal» · «No sustituye a un preparador: lo complementa» · victorgutierrezmarcos.es/oposicion/prepara-con-claude.html.

## Montaje

Copiar `scripts/video-app/` a esta carpeta (`guion.json`, `index.html` de HyperFrames, `preparar.py`, `musica.py`, `publicar.py`), cambiar las escenas por las de arriba y poner las grabaciones en `scripts/video-claude/tomas/G1.mp4 … G8.mp4`. Las tomas de la app (G3, G7) pueden salir de `app/tool/capturas_ayuda_test.dart` cuando existan las pantallas de transcripción y de Prepara con Claude. Después: `npx hyperframes render`, `publicar.py` y `python3 scripts/youtube.py subir claude-prepara …` (skill `/videos`); los pósteres `oposicion/img/claude/video.webp` y `app/promo/ayuda/claude-prepara.webp` salen del fotograma de la portada. Nunca usar `scripts/montar-video-app.py`.
