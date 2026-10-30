# Vídeo «Prepara con IA» (clave `claude-prepara`)

Apaisado 1920×1080, 3-4 minutos, sin voz (rótulos y pantallas grabadas), con la música y la estética del promocional de la app (`scripts/video-app/`). Se publica con `/videos` (clave `claude-prepara`) y lo enlazan `oposicion/prepara-con-ia.html`, `app/index.html#claude` y la app (Más → Prepara con IA).

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

## Cambio a «Prepara con IA» (30 oct., sin renderizar)

El conector se llama «Oposición TCEE · DCE» y funciona en Claude, ChatGPT, Le Chat y Gemini (con Claude, completo). En `index.html`: marca y portada con el icono de la app y «Prepara con IA» (sin el asterisco de Claude), escena nueva **plataformas** tras «porque» (4 compases: «En tu IA. Con Claude, completo.» y una tarjeta por IA), las tomas corridas 4 compases y el cierre con las cuatro IA y `prepara-con-ia.html`; el resto de escenas sigue enseñándolo en Claude. Antes de renderizar hay que **volver a grabar G2c** (la página de autorización y la de entrar con Google ya no llevan el asterisco ni el nombre antiguo) y revisar las capturas de `claude-movil-*` (el conector puede salir con el nombre antiguo).

## Escenas (versión del 28 oct., unos 3:36; con la escena de plataformas, 3:53)

1. **Portada**: «Prepara con Claude» · «Complementa tu preparación con la skill de Claude» · aviso «No sustituye a un preparador para la oposición: lo complementa».
2. **Gancho**: «Tu preparador te corrige una vez a la semana. Entre clase y clase, las dudas esperan.» → «A la medida de cada opositor. Cada semana te conoce mejor.»
3. **Qué hace**: seis tarjetas (cantes, dictámenes, dudas, cronograma, tribunal, test), para TCEE y DCE.
4. **No es un chatbot genérico**: «Sabe tu temario. Y tú aprendes de ella.» · lleva el temario · parte de tu preparación real · tiene memoria (cada vez te conoce mejor) · se mantiene al día sola.
5. **Instalar** (toma G2): tres pasos, una sola vez.
6. **Un cante**: la app transcribe (móviles de TCEE y DCE) → adjuntar y pedir (G4a) → el informe con el minuto y la fuente, el tribunal y el PDF (G4b).
7. **Un dictamen** (G5a, G5b): aunque esté a mano; diagnóstico, coherencia, preguntas de la defensa.
8. **Una duda** (G6a, G6b): ve el temario en conjunto.
9. **El cronograma**: exportar (las dos apps) → un opositor a DCE pide el reparto del cante de 20 minutos y el cronograma por fases (G9na, G9nb; colores y letra de DCE; el nombre «Manuel» solo en el saludo «Buenas noches, Manuel») → en TCEE igual (G7b) → traerlo a la app.
10. **Tu carpeta** (G8): la estructura por ejercicios y Claude trabajando desde ella.
11. **En el móvil**: la app de Claude con la misma skill (la app → el chat con el cante adjunto → la respuesta; capturas de claude.ai con viewport de móvil).
12. **Y mucho más**: «Pide lo que se te ocurra», seis ejemplos.
13. **Al día**: se actualiza sola, tus datos son tuyos, material exclusivo.
14. **Cierre**: Claude Pro, aviso y dirección.

## Montaje (hecho el 28 oct. con HyperFrames)

`index.html` es la composición (copiada del promocional `scripts/video-app/`: misma paleta, GSAP, rótulos de bloque y barrido dorado; la escena de DCE usa el granate, el azul y Latin Modern). `guion.json` fija el compás en que empieza cada escena; `preparar.py` lo lleva al HTML y prepara `assets/` (fuentes, el asterisco del logo de Claude —el nombre va siempre en Pagella, nunca con la letra de la marca; el icono de la app aparece aparte, en la portada y el cierre—, capturas de la app y de claude.ai en el móvil, páginas del informe en PDF, las tomas MP4 y la banda sonora de `musica.py`: la música del promocional compuesta de una pieza para esta duración, con un respiro en cada cambio de bloque, sin bucle ni cortes). La ventana de las tomas tiene su misma proporción (1912 × 948) y `object-fit: contain`, para que no se recorten los lados. El rótulo de bloque (arriba a la derecha) lleva solo el nombre del bloque; «Prepara con Claude» aparece una vez, en la marca de arriba a la izquierda. Las tomas se graban en un Edge aparte con `cdp.mjs` y se montan con `montar-toma.py` (carpeta `C:\Users\vgutierrez\AppData\Local\Temp\claude-video`); van en la raíz de `index.html`, fuera de las escenas, porque HyperFrames no admite un `<video data-start>` dentro de otro elemento con `data-start`. Rótulos sobre cada toma: qué está pasando y qué aporta.

```bash
python3 scripts/video-claude/preparar.py        # recursos y compases
cd scripts/video-claude && npx hyperframes lint && npx hyperframes render
python3 scripts/video-claude/publicar.py --subir  # MP4 para la web, pósteres y YouTube (clave claude-prepara)
```

Después, quitar `hidden` a los reproductores de `oposicion/prepara-con-ia.html` y `app/index.html#claude` y hacer commit de `videos.json`. Nunca usar `scripts/montar-video-app.py`.
