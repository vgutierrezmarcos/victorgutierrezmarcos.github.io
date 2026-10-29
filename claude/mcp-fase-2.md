# Conector «Prepara con Claude» (MCP remoto): diseño para la fase 2

Decidido el 28 de octubre de 2026: la skill sale primero; el conector se hace cuando el uso lo justifique (medir con los eventos `claude_descarga`, `claude_exportar`, `cante_transcrito` y `cronograma_importado` de la app y con el informe mensual). Si en dos o tres meses hay decenas de opositores que usan la skill cada semana, compensa.

## Qué resuelve que la skill no

1. **Protección real del material exclusivo**: los temas, las fichas y la guía se sirven solo a usuarios con sesión y se pueden revocar; la skill pasa a ser solo el enrutador y los agentes, sin `references/temas`.
2. **Datos siempre al día** sin exportar un JSON: Claude lee el progreso, los cantes y el cronograma directamente.
3. **Escritura en la app** sin copiar y pegar: el cronograma acordado y el informe del cante quedan guardados.

## Arquitectura mínima (sin Blaze, coste 0 €)

- **Cloudflare Worker** (plan gratuito: 100.000 peticiones al día) con el protocolo MCP sobre Streamable HTTP, dado de alta por cada opositor como «conector personalizado» en Claude.ai (Pro, Max, Team), Claude Desktop y Claude Code.
- **OAuth 2.1 propio** del Worker (PKCE y registro dinámico de clientes, que Claude.ai exige). El paso de login redirige a una página mínima de la web (`/mcp/login.html`) que hace `signInWithPopup` con Google en el mismo proyecto de Firebase (`web-vgm`) y devuelve al Worker el ID token y el refresh token de Firebase. El Worker emite su propio token de acceso (JWT firmado, una hora) con el `uid`, y guarda el refresh token de Firebase **cifrado** en KV para pedir ID tokens frescos (API REST de Secure Token).
- **Firestore por REST** con el ID token del alumno en `Authorization: Bearer`: `https://firestore.googleapis.com/v1/projects/web-vgm/databases/(default)/documents/users/{uid}/…`. **Las reglas actuales valen tal cual**: el dueño lee y escribe todo `users/{uid}/**`. Sin cuenta de servicio y sin que nadie más que el propio alumno toque sus datos. Para DCE, la raíz es `users/{uid}/oposiciones/dce/…`.
- **Contenido exclusivo** en KV o R2: los `.md` que genera `scripts/skill-opositor.py`, subidos por un script de publicación; se sirven solo con sesión válida.

## Herramientas

| Herramienta | Lee / escribe | Notas |
|---|---|---|
| `leer_progreso` | `progress/settings`, `progress/spaced_repetition` (resumen por caja), `notes` | Lo mismo que `oposicion_<id>_para_claude.json` |
| `leer_resultados_test(desde)` | `exam_results` | Con acierto por tema calculado en el Worker |
| `leer_cantes(n)` | `cantes` (los últimos n hechos, con `resultado`) | La transcripción no está en la nube (queda en el móvil); si se quisiera, un subdocumento `cantes/{id}/privado/transcripcion` con una regla nueva que solo lea el dueño |
| `leer_cronograma` | `cronogramas` (el activo) | |
| `proponer_cronograma(semanas[], diaCante, ejercicio)` | Escribe `cronogramas/{id}` con el JSON de `Cronograma.toJson` y `manual: true`; pone `archivado: true` en el anterior | La app lo muestra al sincronizar (cada 3 minutos o al abrir) |
| `guardar_informe_cante(canteId, informe, valoracion, comentarios)` | Nuevo `cantes/{id}/informes/{fecha}`; opcionalmente actualiza `resultado.valoracion` y `comentarios` | Hace falta una regla nueva en `app/tool/reglas/generar.py` (dueño lee y escribe; preparador enlazado lee) y una pantalla en la app que los muestre |
| `listar_temas_revisados` | Manifiesto `revisados.json` | |
| `leer_tema(T, apartado)`, `leer_ficha(T)`, `leer_guia_dictamen(seccion)` | KV/R2 | Solo con sesión: la protección real |
| `desconectar` | Borra el refresh token de KV | También desde la app, Más → Prepara con Claude → «Desconectar Claude» |

## Cambios que arrastra

- **Reglas**: solo el bloque `cantes/{id}/informes/{f}` (y, si se sube la transcripción, `cantes/{id}/privado/{d}`); regenerar con `generar.py` y probar con `app/tool/reglas/prueba.mjs`.
- **Privacidad**: por primera vez un servidor nuestro (el Worker) toca datos de usuario: hay que añadir a Cloudflare como encargado en `politica-cookies.html` (2.3 y tabla de terceros), describir el flujo (token cifrado, caducidad, revocación) y la base legal; en la app, un botón «Desconectar Claude» y el aviso en `TarjetaPrivacidad`. Los datos de Google Calendar no se exponen por el conector (política de uso limitado de Google).
- **Condiciones**: el apartado «1 bis» ya contempla «el conector oficial».
- **Skill**: versión «ligera» (sin `references/temas`, `dictamen` ni `canon`) que indica a Claude que use las herramientas del conector; `scripts/skill-opositor.py --ligera`.

## Esfuerzo y riesgos

Tres o cuatro días de trabajo: Worker con OAuth (un día), herramientas de lectura (medio día), escritura y reglas (medio día), publicación del contenido y skill ligera (medio día), privacidad y app (un día). Riesgos: el registro dinámico de clientes de Claude.ai cambia con el tiempo (seguir la documentación de conectores personalizados); el refresh token de Firebase caduca si el usuario cambia la contraseña de Google o revoca la app (el conector pide volver a entrar); el límite gratuito de Firestore (50.000 lecturas al día) comparte cuota con la app.

## Estado (29 oct. 2026)

**Hecho (sin desplegar; el agente principal hace el commit):**

- `mcp/worker/`: el Worker entero en TypeScript, con `@cloudflare/workers-oauth-provider` 1.2.4 (OAuth 2.1: PKCE S256, registro dinámico RFC 7591, metadatos RFC 8414 y RFC 9728, `iss` RFC 9207, revocación, tokens por hash y `props` cifrados en `OAUTH_KV`) y `@modelcontextprotocol/sdk` 1.32.2 (protocolo 2025-11-25; Claude negocia 2025-06-18) con el transporte Streamable HTTP **sin estado** del SDK (`WebStandardStreamableHTTPServerTransport`, un servidor por petición): sin Durable Objects ni `McpAgent` (obsoleto según Cloudflare; los DO con SQLite entran en el plan gratuito desde abril de 2025, pero no hacen falta). Las doce herramientas de la tabla (más `leer_canon`), Firestore por REST con el ID token del opositor, refresh token cifrado con AES-GCM (`CLAVE_CIFRADO`) y caché cifrada del ID token en `SESIONES`, contenido exclusivo en `CONTENIDO`, comprobación del refresh token de Firebase en cada renovación (`invalid_grant` si la app lo revocó). Pruebas: 38 con vitest sobre workerd (conversión Firestore, acierto por tema, Leitner, `Cronograma.toJson()` exacto, informe, cifrado, las doce herramientas con un Firestore simulado, initialize y tools/list por HTTP), todas en verde; `wrangler dev --local` recorrido con curl: 401 con `resource_metadata`, los dos `.well-known`, registro de cliente, página de consentimiento y 302 a `login.html`.
- `mcp/login.html` (entra con Google con Firebase 8.10.1 y devuelve los tokens al Worker), `mcp/publicar-contenido.py` (sube los `.md` de la skill a KV con `wrangler kv bulk put` e `indice.json`), `mcp/README.md` (despliegue, secretos, límites del plan gratuito, alta en Claude, mantenimiento).
- Reglas: bloque `cantes/{id}/informes/{informe}` en `app/tool/reglas/generar.py` (el dueño lee y escribe por la regla general; el preparador enlazado lee), `firestore.rules` regenerado, 9 casos nuevos en `prueba.mjs`; emulador pasado: **344 correctas, 0 fallidas**. Pendiente de publicar en la consola.
- Privacidad: `politica-cookies.html`, apartado 2.3 (punto «Conector “Prepara con Claude”»: qué hace, con qué sesión, qué guarda cifrado, caducidad, cómo revocar, base legal consentimiento), tabla de terceros (Cloudflare como encargado, región no fijable en el plan gratuito) y la lista de encargados.
- Skill: `claude/prepara-con-claude/references/conector.md` (usar las herramientas en vez del JSON, qué devuelve cada una, escribir solo con confirmación, skill ligera). `SKILL.md` y `skill-opositor.py --ligera` los tocan otros agentes.
- App: tareas anotadas en `app/DCE.md`, epígrafe «Conector Claude (MCP)».

**Fase 2 b (perfil preparador, pendiente de implementar en el Worker):** `leer_perfil` (papeles por oposición: hay alumnos → preparador; hay preparadores → opositor), `leer_alumnos`, `leer_cantes_alumno(alumno, n)` (los cantes del alumno enlazado que las reglas ya dejan leer al preparador, `esPreparadorDe`), `leer_sesiones(n)`, `guardar_nota_alumno(alumno, texto)` y `guardar_deberes(alumno, lineas)` (escriben en la ficha del alumno del preparador, como la app). Diseño en `claude/prepara-con-claude/references/perfiles.md` y `conector.md`; se hace con los tests cuando haya sitio en C: para `npm install`.

**Desplegado el 29 oct. 2026 (mediodía)** con el token de API de Víctor (`~/.config/oposicion-red/cloudflare.token`, fuera del repo; `wrangler login` no funciona desde WSL porque la vuelta a localhost no llega): Worker en **`https://prepara-con-claude.victorgutierrezmarcos.workers.dev`** (el subdominio es `victorgutierrezmarcos`, no `vgutierrezmarcos`: corregido en `wrangler.toml`, `mcp/login.html` y la página), tres KV creados con sus id en `wrangler.toml`, secreto `CLAVE_CIFRADO` puesto (copia en `~/.config/oposicion-red/cloudflare-clave-cifrado`, 600: guardarla también en el gestor de contraseñas), contenido subido a KV (44 `.md` + `indice.json`), reglas publicadas. Comprobado: `/mcp` da 401 con `resource_metadata`, los dos `.well-known` responden. Para repetir el despliegue o subir contenido: `CLOUDFLARE_API_TOKEN=$(cat ~/.config/oposicion-red/cloudflare.token) npx wrangler deploy` desde `mcp/worker`.

**Falta (Víctor):**

1. ~~Cuenta de Cloudflare y despliegue~~ Hecho: `npm install`, `wrangler login`, crear los tres KV y poner sus id en `wrangler.toml`, `openssl rand -base64 32 | npx wrangler secret put CLAVE_CIFRADO`, `npx wrangler deploy`.
2. ~~Con la URL real del Worker~~ Hecho (falta el push para que `login.html` publicado lleve la URL nueva): `URL_WORKER` en `wrangler.toml`, la constante `WORKER` en `mcp/login.html` y el enlace en `oposicion/prepara-con-claude.html`; volver a desplegar y publicar la web (login.html tiene que estar en `https://www.victorgutierrezmarcos.es/mcp/login.html`).
3. ~~Publicar `firestore.rules` en la consola de Firebase (bloque `informes`).~~ Hecho por Víctor el 29 oct. 2026.
4. ~~Subir el contenido~~ Hecho el 29 oct.; repetir `python3 scripts/skill-opositor.py && python3 mcp/publicar-contenido.py` (sube el contenido exclusivo a KV); repetirlo con cada tema aprobado.
5. Probar con la cuenta propia: Claude.ai → Personalizar → Conectores → Añadir conector personalizado → URL `https://…/mcp` → Conectar (consentimiento → Google → vuelta a Claude) → «lee mi progreso». En Claude Code: `claude mcp add --transport http prepara-con-claude https://…/mcp`.
6. Skill ligera (`scripts/skill-opositor.py --ligera`) y que `SKILL.md` apunte a `references/conector.md` cuando haya herramientas del conector (otro agente).
7. App (`app/DCE.md`): pantalla de informes del cante, «Desconectar Claude», aviso en `TarjetaPrivacidad`.
8. Página `oposicion/prepara-con-claude.html`: el apartado «Conector» (`#conector`) ya está escrito con los pasos de alta y la URL prevista del Worker, pero lleva `hidden`: quitarlo cuando el conector esté desplegado y probado. La novedad del conector en `novedades.json` también va en ese momento (la de la skill ya está puesta).
9. **Directorio de conectores de Anthropic (tras el lanzamiento, decidido el 30 oct. 2026).** Es la única vía para que Claude muestre el logo de la app en vez de la «P»: en los conectores personalizados Claude no usa el favicon del Worker ni los `icons` del servidor MCP (el servicio de favicons de Google da 404 para `*.workers.dev`). Ya cumple lo que piden: servidor remoto con OAuth 2.1 (DCR + PKCE), anotaciones `readOnlyHint`/`destructiveHint` en las 16 herramientas (30 oct.), política de privacidad (`politica-cookies.html`), condiciones (`condiciones-materiales.html#ia`) y documentación (`oposicion/prepara-con-claude.html`). Para la solicitud hará falta: la página ya visible (`scripts/prepara-con-claude-visible.py --mostrar`), una cuenta de Google de prueba con datos en la app para los revisores de Anthropic, el logo en SVG/PNG (`app/assets/icon/icon.svg`) y ejemplos de uso. La revisión es de Anthropic y no tiene plazo.
