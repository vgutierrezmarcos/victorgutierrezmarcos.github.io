# Conector «Oposición TCEE · DCE» en varias IA (plan del 30 oct. 2026)

«Prepara con Claude» pasa a ser un conector MCP que funciona en Claude, ChatGPT, Le Chat y Gemini. Se lanza todo junto, con la página aún oculta hasta el final (`scripts/prepara-con-claude-visible.py`).

## Decisiones de Víctor (30 oct.)

- **Nombre del conector:** «Oposición TCEE · DCE» (el de la app, con su logo). Página, botón de la web y entrada de la app: «Prepara con IA».
- **Claude recomendada:** «Funciona con Claude, ChatGPT, Le Chat y Gemini. Con Claude, completo» y una tabla con lo que incluye cada una (en Claude: informe del cante en PDF, gráficos con el estilo de los temas, agentes).
- **Plataformas al lanzar:** Claude, ChatGPT, Le Chat (Mistral) y Gemini. Copilot no (la versión personal no admite conectores propios). Los clientes de programación (Cursor, VS Code, Gemini CLI) funcionan, pero no se anuncian.
- **Instrucciones:** solo el conector. El método lo sirve el servidor; el opositor solo añade la URL. Sin texto para pegar ni GPT público.
- **URL:** `mcp.victorgutierrezmarcos.es`. El DNS está en DonDominio (`ns1/ns2.dondominio.com`), no en Cloudflare: ver «Pendiente».
- **Vídeo** (`scripts/video-claude`): se rehace con el nombre nuevo y una escena de en qué IA funciona.
- **Cuentas para probar:** solo Le Chat (gratis). Sin ChatGPT Plus ni Google AI Ultra: ChatGPT y Gemini quedan documentados pero sin probar. Hay que decidir si se anuncian como «en pruebas».

## Pasos

1. **Método en el servidor.**
   - Herramienta `leer_metodo(tarea)`: corrector de cante y de dictamen, tribunal, simulacro, organizador, preparador… Sirve los `references/agentes/*.md` desde el KV `CONTENIDO`, subidos con `publicar-contenido.py`.
   - *Prompts* MCP («Corregir un cante», «Simular al tribunal», «Hacer el cronograma», «Repasar un tema») que remiten a `leer_metodo`.
   - Campo `instructions` del servidor en `initialize`: «antes de corregir o simular, llama a `leer_metodo`».
   - Descripciones de las herramientas sin mencionar a Claude ni la skill.
   - La skill de Claude queda ligera: su valor propio son el PDF, los gráficos y el kit de documentos.
2. **Nombre en el servidor.**
   - `serverInfo.name` y `title`, página de consentimiento (`paginas.ts`), `login.html`, `wrangler.toml` (Worker `oposicion-mcp` o similar) y la URL nueva en todos los sitios donde estaba la anterior (README, `login.html`, la página).
   - La dirección de vuelta del OAuth no depende de Claude. Comprobar que funciona el registro de ChatGPT (`chatgpt.com/connector_platform_oauth_redirect`), Le Chat y Gemini.
3. **Nombre en la web.**
   - Página nueva `oposicion/prepara-con-ia.html`; `prepara-con-claude.html` pasa a página puente (`scripts/paginas-puente.py`).
   - Pasos de alta por plataforma, tabla de qué incluye cada una y Claude recomendada.
   - Actualizar `prepara-con-claude-visible.py` (marca, ficheros), `generate-sitemap.js`, `llms.txt`, el índice de búsqueda, `exclusivos.py`, la portada, `/oposicion` y `/app/`.
4. **Nombre en la app.** Más → «Prepara con IA», «Desconectar la IA» en vez de «Desconectar Claude» y textos de privacidad. Requiere compilar: anotarlo en `app/play-store/novedades-pendientes.md`.
5. **Skill y ZIP.** El nombre técnico `prepara-oposicion` no cambia. Título visible, `LEEME.md`, `CLAUDE.md` y menciones en `oposicion/temario/app/skill/`.
6. **Textos legales.**
   - `condiciones-materiales.html#ia`: el material exclusivo pasa por el proveedor de IA que elija el opositor; el uso sigue siendo personal.
   - `politica-cookies.html` 2.3: el nombre nuevo, y que el proveedor de IA lo elige y contrata el opositor.
7. **Vídeo:** rehacerlo en `scripts/video-claude` con HyperFrames (`preparar.py`, render, `publicar.py`).
8. **Pruebas.** Claude.ai y Claude Code (Víctor), Le Chat (Víctor), ChatGPT y Gemini sin cuenta. En cada una: alta, consentimiento, login con Google, leer progreso, escribir con confirmación y revocar desde la app.
9. **Lanzamiento:** `--mostrar`, la novedad en `novedades.json` y `novedades.py`, y push.
10. **Directorios:** primero el de Anthropic (ver `mcp-fase-2.md`, punto 9) y después el de OpenAI, con nombre neutro.

## Hecho

- **`leer_metodo(tarea)` y un *prompt* MCP por tarea** (30 oct.): `TAREAS` en `mcp/worker/src/herramientas.ts`, con sus pruebas; las instrucciones del servidor mandan usarla. Desplegado el 30 oct.
- **Nombre en el servidor** (30 oct., desplegado):
  - `serverInfo` y `resource_name` «Oposición TCEE · DCE»; consentimiento, errores y portada sin Claude: solo el icono de la app y el nombre de la IA que se conecta.
  - Aviso de material exclusivo: «en su propia cuenta de su asistente de IA».
  - El cronograma (`autorNombre`) y el informe del cante (`origen: 'ia'`, `cliente`) se firman con el nombre que dio el cliente al registrarse («Claude», «ChatGPT»…); si no hay, «IA».
  - `mcp/login.html` cambiado, pero no está publicado hasta el push.
  - Siguen sin cambiar: el nombre del Worker y su URL (cambian con el dominio propio) y los enlaces a `oposicion/prepara-con-claude.html` (cambian con la web, paso 3).
- **DNS a Cloudflare** (30 oct.): zona creada en la cuenta de Cloudflare con los 30 registros de DonDominio (`dnszone.csv`), todos en «DNS only». Entre ellos, `dmb7afvgijyc` (verificación de Google) y `firebase1/2._domainkey.www` (DKIM de los correos de Firebase), que no salían en la consulta pública. Comprobado contra `chloe.ns.cloudflare.com`: 30 de 30. Servidores cambiados en DonDominio a `chloe` y `johnny.ns.cloudflare.com`; pendiente de que se propague.

- **Página nueva** (30 oct., sin push): `oposicion/prepara-con-ia.html` (`git mv` de la anterior) con «En qué IA funciona» (`#plataformas`: tabla y pasos de ChatGPT, Le Chat, Gemini y otros programas) y textos neutros. Claude, recomendada; las otras tres, «En pruebas».
  - `prepara-con-claude.html` pasa a ser página puente (`scripts/paginas-puente.py`).
  - Actualizados la sub-nav de `/oposicion/`, la portada, `comunidad.html`, `app/index.html`, `exclusivos.js/.py/.json`, `sitemap.xml` (sin la dirección antigua), la URL de la página en `skill-opositor.py` y `skill-espejo.py`, y `scripts/prepara-con-ia-visible.py` (antes `prepara-con-claude-visible.py`; marca `data-oculto="prepara-con-ia"`). Sigue oculta.

- **Textos legales** (30 oct., aprobados por Víctor): `condiciones-materiales.html` 1 bis (conector en cualquier asistente, skill en Claude, nada fuera de lo oficial, pedir que se desactive el entrenamiento), `politica-cookies.html` 2.3 y tablas, `LICENCIA.md` y la cabecera de `SKILL.md` (fuente y copia publicada).
- **Vídeo** (30 oct., sin renderizar): nombre nuevo y escena «plataformas» (ver `scripts/video-claude/GUION.md`); falta volver a grabar G2c.

## Pendiente

- ~~**Textos legales**~~ hechos el 30 oct. (con el visto bueno de Víctor): `condiciones-materiales.html` (1 bis: «en su propia cuenta de Claude» → de su asistente de IA) y `politica-cookies.html` 2.3 y tablas (conector «Oposición TCEE · DCE», el proveedor de IA lo elige el opositor). Cuando cambien, ajustar las `SUSTITUCIONES` de `prepara-con-ia-visible.py`.
- **App:** Más → «Prepara con IA», «Enviar a la IA», «Exportar mis datos para la IA», «Desconectar la IA» (la página ya los nombra así).
- **Vídeo** con el nombre nuevo (`scripts/video-claude`, `publicar.py` y `videos.json` aún dicen «Prepara con Claude»).

- **DNS para `mcp.victorgutierrezmarcos.es`:** (resuelto: ver «Hecho»; falta el dominio en el Worker, con un token con «Zone → DNS → Edit» y «Workers Routes → Edit», o desde el panel del Worker) un dominio propio para un Worker exige que la zona esté en Cloudflare. Hay dos opciones:
  - Pasar los DNS de DonDominio a Cloudflare (gratis), copiando antes todos los registros: GitHub Pages, correo (MX, SPF, DKIM) y verificaciones de Google.
  - Usar `oposicion-mcp.victorgutierrezmarcos.workers.dev` y migrar más adelante. En ese caso, los opositores tendrían que volver a añadir el conector.
- **ChatGPT y Gemini sin probar:** decidir si se anuncian como «en pruebas» o si alguien con cuenta lo prueba antes.
