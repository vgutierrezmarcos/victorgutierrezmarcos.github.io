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
