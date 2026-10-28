# Prepara con Claude: experiencia de usuario y cómo llegan las mejoras

Víctor pidió el 28 de octubre de 2026 tres cosas: que la skill sea fácil de encontrar desde la web, que cualquier mejora llegue al opositor sin que tenga que hacer nada y, como ideal, que el opositor hable con Claude desde la app con su propia cuenta. Este documento fija lo que se ha hecho, lo que queda para la app y por qué el ideal se consigue de otra manera.

## 1. Dónde está hoy el rozamiento

| Paso | Antes (v1, 28 oct. por la mañana) | Problema |
|---|---|---|
| Encontrarla | Solo desde el submenú de `/oposicion/`, `/app/#claude` y `comunidad.html` | La portada no la mencionaba |
| Empezar | Descargar el ZIP con sesión → Ajustes de claude.ai → Skills → Subir | Cinco pantallas antes del primer mensaje; exige plan de pago |
| Mantenerla al día | La skill comprobaba `version.json` y leía los contenidos nuevos de la web, pero si cambiaban las instrucciones pedía volver a descargar y subir el ZIP | Las skills subidas a claude.ai no se actualizan solas |
| Con la app | Exportar JSON → adjuntarlo a mano; transcripción → guardar .txt → adjuntar | Tres cambios de aplicación para cada cante |

## 2. Lo hecho (28 oct., tarde)

**Acceso desde la web.** Enlace en la portada (debajo del banner de la app), en el submenú de todas las páginas de `/oposicion/`, en `/app/#claude` y en `comunidad.html`. La página `oposicion/prepara-con-claude.html` abre con el logo de Claude y los dos botones de arranque.

**Empezar sin instalar: botón «Empezar en Claude».** Abre `https://claude.ai/new?q=<mensaje>` (comprobado el 28 oct.: el parámetro `q` deja el mensaje escrito en el cuadro) con un mensaje que pide a Claude leer `SKILL.md` de la copia publicada de la skill en la propia web (`base` de `version.json`: `oposicion/temario/app/skill/prepara-oposicion/` en `main`, servida por GitHub Pages; comprobado el 28 oct. que claude.ai no puede leer raw.githubusercontent.com, githack ni jsDelivr, y sí victorgutierrezmarcos.es) y seguirla toda la conversación. Ventajas: cero instalación, siempre la última versión, y funciona con cualquier cuenta que pueda leer páginas web (también la gratuita, con sus límites de uso). Inconvenientes: hay que usar el enlace en cada chat (o guardarlo en favoritos) y Claude tarda unos segundos en leer la skill. La página sugiere el paso intermedio: crear en claude.ai un *Proyecto* «Oposición» con ese mismo mensaje en las instrucciones, y así todos los chats del proyecto empiezan con la skill y con memoria de los anteriores.

**La skill instalada se actualiza sola.** El paso 0 de `SKILL.md` ya no pide volver a subir nada: una vez por conversación compara `version.json` con `VERSION.txt` y, si la web es más reciente, lee `SKILL.md` de la web y lo sigue, y toma `references/` y `assets/` de la web. La copia subida a claude.ai es solo el punto de partida. Solo habría que volver a subir el ZIP si cambiara el `name` o la `description` del frontmatter (es lo que claude.ai usa para reconocerla), y eso se evita salvo necesidad. `scripts/skill-opositor.py` despliega la skill fichero a fichero en `oposicion/temario/app/skill/prepara-oposicion/` de `main` (y deja el ZIP en el árbol de revisión) en cada ejecución, así que publicar una mejora es ejecutar el script y hacer commit en las dos ramas.

**La página explica las tres vías** (sin instalar, Proyecto, instalada) y la pregunta «¿Se actualiza sola?» ahora responde que sí.

## 3. Lo que queda en la app (sesión con Flutter; anotado en `app/DCE.md`)

Hablar con Claude «desde la app» se consigue con enlaces, no con un chat propio:

- **Más → Prepara con Claude → «Abrir Claude»**: lanza `claude.ai/new?q=` con el mensaje de la skill más el contexto que la app ya sabe (oposición, día de cante, fecha del examen). En Android, `launchUrl` con `externalApplication` abre la app de Claude si está instalada; si no, el navegador. El opositor entra con su cuenta de Claude y no sale de su móvil.
- **Diario de cantes → «Corregir con Claude»**: si la transcripción cabe en la URL (menos de unos 6000 caracteres) va dentro del mensaje; si no, se comparte el `.txt` con la hoja de compartir del sistema (la app de Claude para Android acepta ficheros compartidos) y el mensaje queda en el portapapeles.
- **Cronograma → «Pedir el cronograma a Claude»**: exporta los datos y lanza el mensaje con el JSON compacto dentro si cabe; si no, comparte el fichero. La respuesta se trae con «Traer el tuyo», que ya existe.
- **Eventos de Analytics** (`claude_abrir`, `claude_corregir_cante`, `claude_cronograma`, `cronograma_importado`) para saber cuánto se usa antes de invertir en la fase 2.

## 4. Por qué no hay un chat dentro de la app (y qué lo sustituye)

Anthropic prohíbe desde febrero de 2026 que aplicaciones de terceros usen la sesión de Claude Pro del usuario: la app no puede iniciar sesión «como el opositor» y hablar con Claude en su nombre. Las alternativas, de menos a más:

1. **Enlaces y compartir (apartado 3).** Cero coste, cero servidor, la cuenta es del opositor. Es lo que se hace ahora.
2. **Conector MCP remoto (fase 2, `claude/mcp-fase-2.md`).** El opositor añade una vez el conector «Oposición TCEE · DCE» en claude.ai (Ajustes → Conectores) y Claude lee sus datos de Firestore directamente (sin exportar nada) y escribe de vuelta el cronograma y los informes de los cantes. Las mejoras son del lado del servidor: no hay nada que reinstalar. Sigue siendo chat en claude.ai, no dentro de la app. Se hará cuando el uso de la skill lo justifique (medido con los eventos de Analytics).
3. **Chat dentro de la app con nuestra clave de API.** Sería «hablar con Claude desde la app» literalmente, pero pagaríamos nosotros cada conversación (unos céntimos por cante corregido) y haría falta un servidor que guarde la clave. Choca con la regla de no tener servidor ni costes; solo tendría sentido como función de pago, y no está previsto.

## 5. Vídeo

El vídeo explicativo (`scripts/video-claude/`, HyperFrames, unos 4 minutos) sigue el orden de uso: qué es y por qué no es un chatbot genérico, instalar, un cante (app → chat → informe → PDF), un dictamen, una duda, el cronograma (exportar → pedir → traer), también DCE (con los colores y la letra de esa oposición), la carpeta de la oposición en el ordenador, otros usos, cómo se actualiza y el cierre con el aviso. Se publica con `python3 scripts/video-claude/publicar.py --subir` (clave `claude-prepara`) y lo enlazan la página, `/app/#claude` y la app.
