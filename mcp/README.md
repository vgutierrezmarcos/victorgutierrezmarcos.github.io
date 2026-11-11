# Conector «EconomIA» (MCP remoto)

Servidor MCP remoto de la app «Oposición TCEE · DCE», como Cloudflare Worker en el plan gratuito. Cada opositor lo añade como **conector personalizado** en Claude.ai, Claude Desktop o Claude Code, entra con su cuenta de Google (la de la app) y, desde entonces, Claude lee su progreso, sus tests, sus cantes y su cronograma directamente de la app, sirve los materiales exclusivos solo a quien tiene sesión y, cuando el opositor lo confirma, guarda en la app el cronograma acordado y el informe de un cante. Diseño en `claude/mcp-fase-2.md`; instrucciones para Claude en `claude/prepara-con-claude/references/conector.md`.

## Qué hay aquí

| Ruta | Qué es |
|---|---|
| `worker/` | El Worker (TypeScript): `src/index.ts` (OAuth y rutas), `src/mcp.ts` (transporte MCP), `src/herramientas.ts` (las herramientas), `src/firestore.ts` (REST de Firestore), `src/datos.ts` (documentos de la app ↔ JSON de la skill), `src/firebase.ts` (Secure Token e Identity Toolkit), `src/cifrado.ts` (AES-GCM), `src/contenido.ts` (material exclusivo en KV), `src/paginas.ts` (consentimiento), `test/` (vitest sobre workerd) |
| `login.html` | Página de la web (`https://www.victorgutierrezmarcos.es/mcp/login.html`) que entra con Google (Firebase 8.10.1, como el resto de la web) y devuelve los tokens al Worker |
| `publicar-contenido.py` | Sube al KV `CONTENIDO` los `.md` exclusivos de la skill (temas, dictamen y canon) desde la carpeta de construcción de `scripts/skill-opositor.py` (`~/.cache/skill-opositor/…`). La copia de la skill desplegada en la web **no** los lleva: solo se sirven con sesión |
| `extraer-textos.py` | Sube a `CONTENIDO` las claves `textos/{tema}` (texto del PDF de la web y de los apuntes de la ATCEE en PDF o .doc) que usa `leer_fuente`. Solo funciona en el equipo de Víctor (usa `curl.exe` y rutas de Windows) |

## Cómo funciona

```
Claude ──POST /mcp (sin token)──► Worker ──401 + WWW-Authenticate: resource_metadata──► Claude
Claude ──GET /.well-known/oauth-protected-resource/mcp, /.well-known/oauth-authorization-server
Claude ──POST /oauth/register (registro dinámico, RFC 7591)──► client_id
Claude ──abre /authorize?code_challenge=… (PKCE S256)──► página de consentimiento (quién pide acceso, a qué)
Opositor ──Aceptar──► 302 a www.victorgutierrezmarcos.es/mcp/login.html?state=…
login.html ──signInWithPopup(Google)──► POST /callback/sesion {state, idToken, refreshToken}  (el Worker comprueba el ID token
                                        con Identity Toolkit, cifra el refresh token y lo guarda 10 min en SESIONES)
login.html ──GET /callback?state=…──► completeAuthorization → 302 a https://claude.ai/api/mcp/auth_callback?code=…
Claude ──POST /oauth/token (code + code_verifier)──► access token (12 h) + refresh token (30 días)
Claude ──POST /mcp (Bearer)──► herramientas: Firestore REST con el ID token del opositor
```

- **OAuth 2.1**: lo hace [`@cloudflare/workers-oauth-provider`](https://github.com/cloudflare/workers-oauth-provider) 1.2 sobre el KV `OAUTH_KV`: PKCE obligatorio, registro dinámico de clientes (lo que usa Claude.ai), metadatos RFC 8414 y RFC 9728, `iss` (RFC 9207), rotación de refresh tokens, revocación (RFC 7009), tokens guardados solo por hash y `props` cifrados. Es la biblioteca que Cloudflare recomienda para conectores remotos con OAuth propio, y la que pide Claude: `token_endpoint_auth_method: none`, `code_challenge_methods_supported: ["S256"]`, callback `https://claude.ai/api/mcp/auth_callback` y loopback de Claude Code.
- **MCP**: SDK oficial `@modelcontextprotocol/sdk` 1.32 (protocolo **2025-11-25**, y acepta 2025-06-18 y 2025-03-26, que son los que negocia Claude) con el transporte `WebStandardStreamableHTTPServerTransport` **sin estado** (un servidor por petición, respuestas JSON): no hace falta Durable Objects ni `McpAgent` (que Cloudflare ha marcado como obsoleto). Solo `POST /mcp`; `GET` responde 405.
- **Firestore por REST** (`https://firestore.googleapis.com/v1/projects/web-vgm/databases/(default)/documents/users/{uid}/…`) con el ID token del opositor en `Authorization: Bearer`: las reglas de siempre deciden, sin cuenta de servicio. En TCEE la raíz es `users/{uid}`; en DCE, `users/{uid}/oposiciones/dce` (parámetro `oposicion` de cada herramienta).
- **Tokens de Firebase**: el refresh token va cifrado con AES-GCM (`CLAVE_CIFRADO`) dentro de los `props` de la concesión (que la biblioteca cifra a su vez); el ID token (1 h) se renueva con la Secure Token API y se cachea cifrado 50 min en `SESIONES`. En cada renovación del token de Claude se comprueba que Firebase sigue aceptando el refresh token: si no (contraseña cambiada, cuenta borrada, «Desconectar Claude» en la app), la concesión se revoca con `invalid_grant` y Claude pide volver a conectar.
- **Contenido exclusivo** en el KV `CONTENIDO`: solo se sirve con sesión válida, con el aviso de uso personal en cada respuesta.
- Sin registros: `observability.enabled = false`; el Worker no guarda nada con datos personales salvo lo anterior (uid, correo y tokens cifrados en KV, con caducidad).
- **Medición anónima** (Workers Analytics Engine, conjunto `analytics_mcp`): por cada llamada, la herramienta, el nombre de la IA cliente, la oposición, si fue bien y los milisegundos. Sin uid, correo ni contenido. Se consulta con la API SQL (`POST https://api.cloudflare.com/client/v4/accounts/<cuenta>/analytics_engine/sql`, p. ej. `SELECT blob1 AS herramienta, blob4 AS resultado, SUM(_sample_interval) AS llamadas FROM analytics_mcp WHERE timestamp > NOW() - INTERVAL '7' DAY GROUP BY herramienta, resultado ORDER BY llamadas DESC`).
- **Dirección antigua** (`…workers.dev`): sigue respondiendo, pero `/authorize` enseña una página que explica cómo volver a añadir el conector con `mcp.victorgutierrezmarcos.es` (la autorización empezada en un dominio no puede acabar en el otro).

## Herramientas

Lecturas (todas con `oposicion`: `tcee` por defecto o `dce`; si una sale vacía y los datos están en la otra, lo avisa):

| Herramienta | Lee |
|---|---|
| `empezar()` | Visión de conjunto de las dos oposiciones: papeles (opositor, preparador), días a cada ejercicio, semana del cronograma, últimos cantes, deberes, tareas de la última corrección, tests de la semana y contenido revisado. Es la primera llamada de cada conversación |
| `leer_metodo(tarea)`, `leer_skill(ruta)` | El método de una tarea (cabecera y reglas comunes de `SKILL.md` más el agente) o un fichero de la skill publicada en la web; lo exclusivo (`references/temas/<T>/`, `dictamen/`, `canon/`), del KV |
| `leer_progreso`, `leer_resultados_test(desde, limite)`, `leer_cantes(n)`, `leer_cronograma` | `progress/*`, `notes/*`, `exam_results` (con acierto por tema), `cantes`, `cronogramas` y `cronogramasRecibidos` |
| `leer_informes_cante(canteId, n, completo)` | `cantes/{id}/informes`: las correcciones guardadas |
| `preguntas_test(temas, n, modo)` | Preguntas oficiales de `preguntas.json` por tema, filtradas con `progress/spaced_repetition`, con la clave de `explicaciones/<examen>.json` |
| `test_interactivo(temas, n, modo)` | Lo mismo que `preguntas_test`, con la vista interactiva del test (ver «Vistas interactivas») |
| `apuntar_test(respuestas, segundos?, clave?)` | Apunta en la app un test hecho en el chat: lo corrige contra el banco, lo deja en `exam_results` (`origen: "ia"`) y actualiza el repaso espaciado (`progress/spaced_repetition`, misma regla que la app). La vista del test la llama sola al terminar; con `clave` no cuenta dos veces |
| `reportar_pregunta(pregunta, motivo, comentario, elegida?)` | Reporta un error en una pregunta oficial o del banco (colección `reportesTest`, las mismas claves que la app; el correo lo manda `reportes-test.yml`). La vista del test tiene su botón |
| `figura_test(url)` | Solo para la vista del test (`visibility: ["app"]`): la imagen de una figura en base64 cuando el cliente no deja cargarla de la web |
| `leer_proceso(seccion)` | `oposicion/proceso.json` (documentos del proceso selectivo en curso) |
| `fuentes_tema(tema)`, `buscar_temario(consulta)`, `leer_fuente(enlace)` | `fuentes-temas.json`; la búsqueda mira también los apartados de cada PDF (`references/temario/indices-temas.md`); `leer_fuente` lee apuntes de la ATCEE, PDF de la web (`textos/{tema}` en KV) y páginas de Manuel |
| `listar_temas_revisados`, `leer_tema`, `leer_ficha`, `leer_guia_dictamen`, `leer_canon` | KV `CONTENIDO`; por apartado o por tramos (`desde`/`limite`, 40.000 caracteres por defecto) |
| `preparar_clase(con, dia)` | Preparadores, huecos, reservas, próximas clases y temas del cronograma para agendar |
| `leer_alumnos`, `leer_alumno(alumno, n)` | Preparadores: `alumnos`, `sesiones`, `reservas` que le piden y, del alumno enlazado, lo que las reglas le dejan ver (`progress/settings`, cronograma compartido, informes de las clases que firma él) |

Escrituras (siempre con confirmación del usuario: en la conversación o con el botón de la vista interactiva):

| Herramienta | Escribe |
|---|---|
| `proponer_cronograma` | `cronogramas/{id}` como `Cronograma.toJson()` y archiva el anterior en un solo `:commit`; hereda `compartir`, `hechos` y `desmarcados` |
| `guardar_informe_cante` | `cantes/{id}/informes/{fecha}`; en el diario solo lo que no estuviera ya puesto (salvo `sustituir`); las tareas, como deberes en un cante propio |
| `borrar_datos_oposicion` | Borra todo lo del usuario en una oposición (`src/borrado.ts`: la misma lista de colecciones que `UsuarioRepo.coleccionesOposicion` de la app, sus enlaces y lo suyo en la red) y deja la marca `users/{uid}/cuenta/app.borrados.{oposicion}` para que la app borre su copia local. Dos pasos: recuento + código (sello con secreto, 10-20 min) y frase «BORRAR DCE» escrita por el usuario |
| `anotar_tema` | `notes/{tema}.pendientes` y, opcional, `temasEstudiados` / `temasEnRepaso` |
| `agendar_clase` | Opositor: `reservas/{id}` y `temasClases`. Preparador: `sesiones/{id}` y la copia en los `cantes` del alumno |
| `responder_reserva`, `guardar_nota_alumno`, `guardar_deberes` | Preparadores: estado de la reserva y la clase `res_{id}` en las dos agendas; `alumnos/{id}.notas`; `tareas` de la sesión y de su copia |
| `desconectar(confirmar)` | Revoca las concesiones OAuth del usuario y borra su ID token cacheado |

Las fechas se escriben como la app: hora de Madrid sin zona. Los ids que llegan de la IA se codifican antes de ir en una ruta.


### Tres tipos de pregunta de test

Por orden de preferencia, y siempre con su etiqueta a la vista:

1. **Oficiales**: las de los exámenes (`preguntas.json` de la web). Es lo que se usa por defecto.
2. **Del banco de EconomIA**: no oficiales, revisadas y con explicación; ids de 100000 en adelante. Material exclusivo: la fuente vive en la rama de revisión (`banco-test/<tema>.json`) y `python3 scripts/banco-test.py --publicar` la valida y la sube al KV `CONTENIDO` (`banco/preguntas.json`), que es de donde las lee el conector. Se piden con `tipo: "banco"` u `"oficiales_y_banco"`. El número de preguntas por tema guarda la proporción de los exámenes oficiales (`--cupos`).
3. **Generadas al vuelo** por la IA del usuario (`nuevas` en `test_interactivo`): sin revisar, id negativo, no se apuntan ni se pueden reportar.

Al apuntar un test, las oficiales van a `progress/spaced_repetition` (el que lee la app) y las del banco a `progress/spaced_repetition_banco`; en `exam_results` las respuestas del banco van en `respuestasBanco` y `fuente` dice si el test es de oficiales, del banco o mixto.

## Vistas interactivas (MCP Apps, «interactive connectors»)

Cinco herramientas declaran una vista (`_meta.ui.resourceUri`) que los clientes compatibles (Claude) pintan dentro del chat; los demás reciben el mismo texto de siempre. Las vistas son recursos `ui://economia/*.html` (`text/html;profile=mcp-app`) que salen de `src/vistas/*.html` (texto empaquetado con la regla `Text` de `wrangler.toml`) y `src/vistas.ts`: `comun.html` lleva los estilos y el puente con el cliente (JSON-RPC por `postMessage`, sin dependencias) y cada vista, su cuerpo.

| Vista | Herramienta | Qué hace |
|---|---|---|
| `test.html` | `test_interactivo` | Una pregunta cada vez, con figura y fórmulas (MathJax de jsDelivr), corrección al momento y «¿Por qué?»; al final manda el resultado al chat y puede pedir más preguntas |
| `cronograma.html` | `proponer_cronograma` | El plan por meses; con `vistaPrevia: true`, botón «Guardar en la app» |
| `informe.html` | `guardar_informe_cante` | Valoración, rúbrica, comentarios y tareas editables; con `vistaPrevia: true`, botón «Guardar en la app» |
| `clase.html` | `agendar_clase` | El resumen de la clase y, si pisa otra, la casilla para seguir; con `vistaPrevia: true`, botón «Pedir la clase» o «Crear la clase» |
| `borrado.html` | `borrar_datos_oposicion` | El recuento del paso 1 y el campo donde el usuario escribe la frase; el botón hace el paso 2 |

- `vistaPrevia: true` valida todo y no escribe nada: el botón de la vista repite la llamada sin `vistaPrevia` (con la sesión del usuario, a través del cliente). Sin vista, el modelo enseña el resultado y repite la llamada cuando el usuario confirma.
- El servidor no sabe si el cliente pinta vistas (no guarda estado entre peticiones): por eso los textos que devuelve dicen al modelo qué hacer en los dos casos, y `test_interactivo` es una herramienta aparte de `preguntas_test`.
- Las vistas no hacen peticiones de red propias; solo `test.html` carga imágenes de la web y MathJax (`_meta.ui.csp.resourceDomains`). Lo que pasa en la vista se le cuenta al modelo con `ui/update-model-context`.
- Para verlas sin Claude: montar cada página (lo común + el cuerpo) y abrirla en un marco con un cliente simulado que conteste a `ui/initialize` y mande `ui/notifications/tool-result`.

## Desplegar (Víctor)

Hace falta una cuenta de Cloudflare (gratuita) y `node` 20 o posterior. Todo desde `mcp/worker/`:

```bash
cd mcp/worker
npm install
export CLOUDFLARE_API_TOKEN=$(cat ~/.config/oposicion-red/cloudflare.token)   # desde WSL, `wrangler login` no sirve

# 1. Los tres espacios KV (copiar cada id en wrangler.toml)
npx wrangler kv namespace create OAUTH_KV
npx wrangler kv namespace create SESIONES
npx wrangler kv namespace create CONTENIDO

# 2. El secreto de cifrado (32 bytes en base64; guardarlo también en el gestor de contraseñas:
#    si se pierde, los opositores tienen que volver a conectar)
openssl rand -base64 32 | npx wrangler secret put CLAVE_CIFRADO

# 3. Desplegar
npx wrangler deploy
```

Después del primer despliegue:

1. Apuntar la URL real del Worker (la que imprime `wrangler deploy`, `https://prepara-con-claude.<subdominio>.workers.dev`) en **tres sitios**: `URL_WORKER` en `wrangler.toml`, la constante `WORKER` de `mcp/login.html` y la URL que se publica en `oposicion/economia.html`; volver a desplegar y publicar la web. Con dominio propio (`mcp.victorgutierrezmarcos.es`: Workers → Settings → Domains & Routes → Custom domain; el DNS tiene que estar en Cloudflare) es lo mismo con esa URL.
2. En la consola de Firebase, Authentication → Settings → **Dominios autorizados**: `www.victorgutierrezmarcos.es` ya está (el login se hace ahí, no en el Worker), así que no hay que añadir nada.
3. Publicar las reglas de Firestore nuevas (`firestore.rules`, bloque `cantes/{id}/informes/{informe}`) en la consola.
4. Subir el contenido exclusivo: `python3 scripts/skill-opositor.py --kv` (construye la skill, despliega en la web la copia sin lo exclusivo y sube lo exclusivo al KV con `mcp/publicar-contenido.py`). Repetirlo cada vez que se apruebe un tema o una ficha.
5. Probar con la cuenta propia: Claude.ai → Personalizar → Conectores → **Añadir conector personalizado** → nombre «EconomIA», URL `https://…/mcp`, sin client id ni secreto (Claude se registra solo) → Conectar → consentimiento → Google → «Cuenta conectada» → de vuelta en Claude. En Claude Code: `claude mcp add --transport http prepara-con-claude https://…/mcp` y `/mcp` para entrar.

Los `vars` de `wrangler.toml` (`FIREBASE_API_KEY`, `URL_LOGIN`, `URL_PREGUNTAS`, `ORIGENES_LOGIN`…) son públicos; el único secreto es `CLAVE_CIFRADO`.

### Límites del plan gratuito

- Workers: 100.000 peticiones/día, 10 ms de CPU por petición (una herramienta gasta 1-5 ms; el resto es espera de Firestore).
- KV: 100.000 lecturas/día y **1.000 escrituras/día**. Escribe el registro de un cliente (uno por conexión nueva), cada concesión y cada renovación de token (de ahí los tokens de acceso de 12 h), la sesión de login y la caché del ID token (una por opositor cada 50 min de uso). Con decenas de opositores activos sobra; si algún día `wrangler tail` enseña `KV PUT failed: limit exceeded`, subir `accessTokenTTL` o pasar a Workers Paid (5 $/mes).
- Firestore: cada herramienta hace de 1 a 4 lecturas de documentos (leer_cantes lista toda la colección: una lectura por cante). Comparte la cuota diaria gratuita con la app.
- Región: el plan gratuito no permite fijar la región del Worker (Data Localization Suite es de Enterprise); corre en el centro de datos de Cloudflare más cercano al opositor (en España para los de España) y KV replica las claves donde se usan. Está dicho así en `politica-cookies.html`.

## Desarrollo y pruebas

```bash
cd mcp/worker
npm test                          # vitest sobre workerd (80 pruebas); si fallan al arrancar workerd a la vez,
                                  # npx vitest run --fileParallelism=false
npm run typecheck
printf 'CLAVE_CIFRADO="%s"\n' "$(openssl rand -base64 32)" > .dev.vars
npx wrangler dev --local --var URL_WORKER:http://localhost:8787      # sin cuenta de Cloudflare, KV local
```

Con `wrangler dev` se puede recorrer todo menos Google: `POST /oauth/register`, `GET /authorize?…` (página de consentimiento), `POST /authorize` (302 a `login.html?state=…&worker=http://localhost:8787`). Para probar el login contra el Worker local, servir la web en `http://localhost:8000` (`python3 -m http.server`) y abrir `http://localhost:8000/mcp/login.html?state=…&worker=http://localhost:8787`: `login.html` solo acepta `worker` si es localhost; con `firebase-config.js` real, Google exige que `localhost` esté en los dominios autorizados de Firebase (lo está por defecto). Para probar las herramientas contra Firestore real hay que pasar por OAuth entero, lo más cómodo con el MCP Inspector (`npx @modelcontextprotocol/inspector`) apuntando al Worker desplegado.

Las pruebas de `test/` cubren la conversión de valores de Firestore, el acierto por tema, Leitner, el cronograma (`Cronograma.toJson()` exacto), el informe del cante, el cifrado, la capa HTTP de Firestore con el `fetch` global (lo que falló en producción), el enrutado de las herramientas con un Firestore simulado y el transporte Streamable HTTP en workerd (initialize, tools/list). `@cloudflare/vitest-pool-workers` avisa de que pasa a llamarse `@cloudflare/vitest-plugin`: cuando se actualice, `npx @cloudflare/codemods vitest:pool-workers-to-vitest-plugin`.

## Mantenimiento

- **Temas nuevos**: `python3 scripts/skill-opositor.py --kv`. `empezar` avisa si la versión del método (web) y la del contenido (KV) no coinciden.
- **Tras cada despliegue**: `node mcp/prueba-humo.mjs` (portada, metadatos OAuth, 401 de `/mcp` y página de la dirección antigua; con `MCP_TOKEN`, además una lectura por herramienta).
- **Cambios en los modelos de la app** (`app/lib/data/models`): `src/datos.ts` replica `Cronograma.toJson()`, `ResultadoCante`, `Ajustes`, `Plan`, `AgendaTema` y `EstadoLeitner`; si cambian, cambiar aquí y en `test/datos.test.ts`.
- **Desconectar desde la app**: la app no puede revocar las concesiones OAuth del Worker directamente; basta con que el opositor cierre sesión en Firebase o revoque la app en su cuenta de Google (el refresh token deja de valer y la siguiente renovación revoca la concesión). Para un botón «Desconectar Claude» inmediato, la app puede llamar a `desconectar` por la misma vía que Claude (ver `app/DCE.md`), o el opositor usa Claude → Personalizar → Conectores → Eliminar.
- **Limpieza de KV**: la biblioteca pone TTL a todo; si se quiere, un Cron Trigger con `env.OAUTH_PROVIDER.purgeExpiredData()`.
