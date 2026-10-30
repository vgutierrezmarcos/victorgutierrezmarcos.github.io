# Conector «Prepara con Claude» (MCP remoto)

Servidor MCP remoto de la app «Oposición TCEE · DCE», como Cloudflare Worker en el plan gratuito. Cada opositor lo añade como **conector personalizado** en Claude.ai, Claude Desktop o Claude Code, entra con su cuenta de Google (la de la app) y, desde entonces, Claude lee su progreso, sus tests, sus cantes y su cronograma directamente de la app, sirve los materiales exclusivos solo a quien tiene sesión y, cuando el opositor lo confirma, guarda en la app el cronograma acordado y el informe de un cante. Diseño en `claude/mcp-fase-2.md`; instrucciones para Claude en `claude/prepara-con-claude/references/conector.md`.

## Qué hay aquí

| Ruta | Qué es |
|---|---|
| `worker/` | El Worker (TypeScript): `src/index.ts` (OAuth y rutas), `src/mcp.ts` (transporte MCP), `src/herramientas.ts` (las doce herramientas), `src/firestore.ts` (REST de Firestore), `src/datos.ts` (documentos de la app ↔ JSON de la skill), `src/firebase.ts` (Secure Token e Identity Toolkit), `src/cifrado.ts` (AES-GCM), `src/contenido.ts` (material exclusivo en KV), `src/paginas.ts` (consentimiento), `test/` (vitest sobre workerd) |
| `login.html` | Página de la web (`https://www.victorgutierrezmarcos.es/mcp/login.html`) que entra con Google (Firebase 8.10.1, como el resto de la web) y devuelve los tokens al Worker |
| `publicar-contenido.py` | Sube al KV `CONTENIDO` los `.md` exclusivos de la skill (`oposicion/temario/app/skill/prepara-oposicion/references/`) |

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

## Herramientas

| Herramienta | Lee / escribe |
|---|---|
| `leer_skill(ruta)` | La skill publicada en la web: `SKILL.md` sin ruta, o el fichero que cite |
| `leer_metodo(tarea)` | El método de una tarea (`corregir_cante`, `simulacro`, `tribunal`, `cronograma`…): cabecera y reglas comunes de `SKILL.md` más el agente y lo que haga falta leer; sin tarea, la lista. Lo usan las IA sin skills (ChatGPT, Le Chat, Gemini). Cada tarea es también un *prompt* MCP (`TAREAS` en `herramientas.ts`) |
| `leer_progreso(oposicion)` | `progress/settings`, `progress/plan`, `progress/spaced_repetition`, `notes/*` → el JSON de `datos-app.md` (sin cantes, cronograma ni tests) |
| `leer_resultados_test(desde, limite)` | `exam_results` con acierto por tema (a partir de `respuestas` y `preguntas.json`) |
| `leer_cantes(n)` | Los últimos `n` hechos (con `resultado`) y los próximos pendientes |
| `leer_cronograma` | El activo, semana a semana |
| `proponer_cronograma(semanas[], diaCante, ejercicio, …)` | Escribe `cronogramas/{id}` como `Cronograma.toJson()` con `manual: true`; archiva el anterior |
| `guardar_informe_cante(canteId, informe, valoracion, …)` | Escribe `cantes/{id}/informes/{fecha}` y, si el cante está hecho, `resultado.valoracion/valoraciones/comentarios/criterios` |
| `listar_temas_revisados` | `indice.json` de `CONTENIDO` |
| `leer_tema(tema, apartado, guion)`, `leer_ficha(tema)`, `leer_guia_dictamen(documento, seccion)`, `leer_canon(documento)` | `CONTENIDO` |
| `desconectar(confirmar)` | Revoca las concesiones OAuth del opositor y borra su ID token cacheado |

## Desplegar (Víctor)

Hace falta una cuenta de Cloudflare (gratuita) y `node` 20 o posterior. Todo desde `mcp/worker/`:

```bash
cd mcp/worker
npm install
npx wrangler login                       # abre el navegador con la cuenta de Cloudflare

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
4. Subir el contenido exclusivo: `python3 scripts/skill-opositor.py && python3 mcp/publicar-contenido.py` (usa `wrangler kv bulk put --remote`). Repetirlo cada vez que se apruebe un tema o una ficha.
5. Probar con la cuenta propia: Claude.ai → Personalizar → Conectores → **Añadir conector personalizado** → nombre «Prepara con Claude», URL `https://…/mcp`, sin client id ni secreto (Claude se registra solo) → Conectar → consentimiento → Google → «Cuenta conectada» → de vuelta en Claude. En Claude Code: `claude mcp add --transport http prepara-con-claude https://…/mcp` y `/mcp` para entrar.

Los `vars` de `wrangler.toml` (`FIREBASE_API_KEY`, `URL_LOGIN`, `URL_PREGUNTAS`, `ORIGENES_LOGIN`…) son públicos; el único secreto es `CLAVE_CIFRADO`.

### Límites del plan gratuito

- Workers: 100.000 peticiones/día, 10 ms de CPU por petición (una herramienta gasta 1-5 ms; el resto es espera de Firestore).
- KV: 100.000 lecturas/día y **1.000 escrituras/día**. Escribe el registro de un cliente (uno por conexión nueva), cada concesión y cada renovación de token (de ahí los tokens de acceso de 12 h), la sesión de login y la caché del ID token (una por opositor cada 50 min de uso). Con decenas de opositores activos sobra; si algún día `wrangler tail` enseña `KV PUT failed: limit exceeded`, subir `accessTokenTTL` o pasar a Workers Paid (5 $/mes).
- Firestore: cada herramienta hace de 1 a 4 lecturas de documentos (leer_cantes lista toda la colección: una lectura por cante). Comparte la cuota diaria gratuita con la app.
- Región: el plan gratuito no permite fijar la región del Worker (Data Localization Suite es de Enterprise); corre en el centro de datos de Cloudflare más cercano al opositor (en España para los de España) y KV replica las claves donde se usan. Está dicho así en `politica-cookies.html`.

## Desarrollo y pruebas

```bash
cd mcp/worker
npm test                          # vitest sobre workerd (38 pruebas); si fallan al arrancar workerd a la vez,
                                  # npx vitest run --fileParallelism=false
npm run typecheck
printf 'CLAVE_CIFRADO="%s"\n' "$(openssl rand -base64 32)" > .dev.vars
npx wrangler dev --local --var URL_WORKER:http://localhost:8787      # sin cuenta de Cloudflare, KV local
```

Con `wrangler dev` se puede recorrer todo menos Google: `POST /oauth/register`, `GET /authorize?…` (página de consentimiento), `POST /authorize` (302 a `login.html?state=…&worker=http://localhost:8787`). Para probar el login contra el Worker local, servir la web en `http://localhost:8000` (`python3 -m http.server`) y abrir `http://localhost:8000/mcp/login.html?state=…&worker=http://localhost:8787`: `login.html` solo acepta `worker` si es localhost; con `firebase-config.js` real, Google exige que `localhost` esté en los dominios autorizados de Firebase (lo está por defecto). Para probar las herramientas contra Firestore real hay que pasar por OAuth entero, lo más cómodo con el MCP Inspector (`npx @modelcontextprotocol/inspector`) apuntando al Worker desplegado.

Las pruebas de `test/` cubren la conversión de valores de Firestore, el acierto por tema, Leitner, el cronograma (`Cronograma.toJson()` exacto), el informe del cante, el cifrado, el enrutado de las doce herramientas con un Firestore simulado y el transporte Streamable HTTP en workerd (initialize, tools/list). `@cloudflare/vitest-pool-workers` avisa de que pasa a llamarse `@cloudflare/vitest-plugin`: cuando se actualice, `npx @cloudflare/codemods vitest:pool-workers-to-vitest-plugin`.

## Mantenimiento

- **Temas nuevos**: `python3 scripts/skill-opositor.py && python3 mcp/publicar-contenido.py`.
- **Cambios en los modelos de la app** (`app/lib/data/models`): `src/datos.ts` replica `Cronograma.toJson()`, `ResultadoCante`, `Ajustes`, `Plan`, `AgendaTema` y `EstadoLeitner`; si cambian, cambiar aquí y en `test/datos.test.ts`.
- **Desconectar desde la app**: la app no puede revocar las concesiones OAuth del Worker directamente; basta con que el opositor cierre sesión en Firebase o revoque la app en su cuenta de Google (el refresh token deja de valer y la siguiente renovación revoca la concesión). Para un botón «Desconectar Claude» inmediato, la app puede llamar a `desconectar` por la misma vía que Claude (ver `app/DCE.md`), o el opositor usa Claude → Personalizar → Conectores → Eliminar.
- **Limpieza de KV**: la biblioteca pone TTL a todo; si se quiere, un Cron Trigger con `env.OAUTH_PROVIDER.purgeExpiredData()`.
