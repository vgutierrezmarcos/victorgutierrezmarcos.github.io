# Lanzamiento conjunto («Lanza todo al público»)

Decidido por Víctor el 11/11/2026 y ampliado el 20/11/2026: nada se despliega
hasta que esté todo, y todo sale el mismo día con una sola orden. Sale:

1. La versión nueva de la app (1.26.0) con el conector de EconomIA integrado
   (burbuja «Tu IA», marca de conexión).
2. Todo lo de EconomIA, visible en la web y en la app.
3. Los temas revisados del 3.er ejercicio (90), la guía del dictamen y «Cómo
   cantar un tema», con cuenta de Google en la app **y en la web** (Víctor,
   24/11/2026): al abrir un tema revisado, con sesión se abre directamente la
   versión nueva (`oposicion/temario/tema-revisado.html`, con PDF, Word, ficha
   de repaso y versión anterior); sin sesión, el aviso «Inicia sesión para ver
   el tema nuevo» y «Seguir con el tema antiguo» si lo había. En la app, igual
   (sin sesión, el aviso y la antigua a un toque). Interruptor de la web:
   `scripts/temas-web-visible.py` (apagado hasta el paso 10).
   **El examen de ejemplo de España del dictamen y su solución no se publican
   nunca** (ni web, ni app, ni conector, ni rama `temario-publicado`).
4. El banco de preguntas de test de EconomIA (1.002 o más, revisadas).

Antes: `python3 scripts/lanzamiento.py --tests` sin ningún FALLA (los DÍA son
los pasos de abajo).

## Antes del día (pendiente al 24/11/2026)

- ~~**Examen de España**: reconstruir la skill sin el examen ni su solución~~
  Hecho el 24/11/2026: `python3 scripts/skill-opositor.py` (skill 2026.11.24-16,
  sin `examen-espana.md` ni `solucion-espana.md` en el ZIP, la carpeta de
  construcción ni la copia desplegada) y ZIP confirmado en `revision-temario-2`
  (0ea0df17). Lo que ya era público: ver «Examen de España» abajo.

- ~~**Vídeo de EconomIA**: la toma G8 («Tu carpeta», 150-158 s) enseña
  `prepara-con-claude.zip` y `oposicion_tcee_para_claude.json`. Hay que rehacer
  la toma y volver a renderizar (`scripts/video-claude/`, HyperFrames).~~
  Hecho el 24/11/2026: G8 enseña ahora `prepara-oposicion.zip` y
  `oposicion_tcee_para_ia.json` (los nombres reales de hoy; parche sobre
  `assets/tomas/G8.mp4`, el resto de la toma igual) y vídeo renderizado de
  nuevo con la misma duración (2:58,9):
  `scripts/video-claude/renders/video-claude_2026-11-24_16-02-53.mp4`, el
  último de `renders/`, que es el que coge `publicar.py`. La subida sigue
  en el paso 9 del día.
- ~~**Vídeos de ayuda desfasados** (revisión del 21/11): `reservar-clase`,
  `clase`, `empezar-preparador`, `instalar-android` e `instalar-iphone`;
  dudosos: `programar-clase`, `huecos-reservas`, `conectar-preparador`,
  `cronograma`, `clase-suelta`, `instalar-windows` e `instalar-mac`.~~
  Hecho el 24/11/2026: burbuja oculta en `capturas_ayuda_test.dart` y en el
  test «DCE» de `capturas_dce_test.dart`; regenerados (capturas y montaje)
  `reservar-clase`, `clase`, `empezar-preparador`, `programar-clase`,
  `huecos-reservas`, `conectar-preparador`, `cronograma`, `instalar-android`,
  `instalar-iphone`, `instalar-windows` e `instalar-mac`. `clase-suelta` se
  queda como estaba (mismas pantallas; solo cambian las fechas). **Ojo:**
  `montar-videos-ayuda.py` sube solo a YouTube si hay permiso en el
  ordenador (`a_youtube`); el día 9, sustituirlos con `/videos` (clave
  `ayuda-<id>`), los once de esta lista.

## Pasos, por este orden

Worktree de revisión: `WT=../victorgutierrezmarcos.github.io-revision-2`
(rama `revision-temario-2`). Fecha del día: `F=DD/MM/AAAA`.

| # | Qué | Órdenes | Vuelta atrás |
|---|---|---|---|
| 1 | Confirmar lo pendiente de `main` y de la rama de revisión (rutas explícitas) | `git status`; `git add <rutas>`; `git commit` | — |
| 2 | Fecha común y reconstrucción del temario | en `WT`: `python3 scripts/temario/fecha-comun.py $F --reconstruir` | `git checkout -- .` en `WT` |
| 3 | Marcar aprobados los 90 temas, sus fichas y 1D01 (Víctor ya los ha revisado) y generar el manifiesto | en `WT`: `aprobado.tema` y `aprobado.repaso` en cada `estado.json` y fila b) de `oposicion/temario/estado-revision.md`; `python3 scripts/temario/manifiesto-app.py`; commit (y push de `revision-temario-2` solo si se decide seguir publicándola: ver «Examen de España») | revertir el commit |
| 4 | Rama de publicación **sin el examen de España** | `python3 scripts/rama-publicada.py` (instantánea sin historia de `revision-temario-2` sin `oposicion/temario/fuentes/1D01/examen-espana/` ni nada con `examen-espana`/`solucion-espana`, con el manifiesto fijado a ella; se niega si el ZIP de la skill los lleva); `git -C $WT push --force origin temario-publicado`; `python3 scripts/rama-publicada.py --comprobar` (FALLA si la rama local o la de GitHub los llevan, en el árbol, en un ZIP o en su historia). **Nunca** `git push origin revision-temario-2:temario-publicado` | `git push origin :temario-publicado` |
| 5 | Contenido del conector (temas revisados, fichas, dictamen y canon) | `python3 scripts/skill-opositor.py` y `python3 mcp/publicar-contenido.py` (no sube el examen de España ni su solución y borra sus claves del KV, `dictamen/examen-espana.md` y `dictamen/solucion-espana.md`, por si quedaron de antes) | volver a publicar la versión anterior del KV (`--limpiar` y el `indice.json` previo) |
| 6 | Banco de test | `python3 scripts/banco-test.py --publicar` | publicar el banco anterior |
| 7 | Worker | `cd mcp/worker && npm test && npx wrangler deploy`; probar con Claude que aparece `users/{uid}/cuenta/conector` y que `listar_temas_revisados` da 91 | `npx wrangler rollback` |
| 8 | App 1.26.0 | `version: 1.26.0+<n>` en `app/pubspec.yaml`; `python3 scripts/publicar-app-web.py`; AAB y subida con `/play` (prueba cerrada y producción) | detener la publicación en Play; `app/abrir/` anterior desde git |
| 9 | Vídeos | `python3 scripts/publicar-videos-app.py promo-app` y `python3 scripts/video-claude/publicar.py --subir --web`; commit de `videos.json` | `scripts/youtube.py` (deja privado el nuevo y vuelve la clave al anterior) |
| 10 | EconomIA visible, temas revisados en la web con sesión y registro de exclusivos | `python3 scripts/economia-visible.py --mostrar`; `python3 scripts/temas-web-visible.py --mostrar`; `python3 scripts/exclusivos.py`; `node build-search-index.js`; commit y push de `main` | `economia-visible.py --ocultar`, `temas-web-visible.py --ocultar` y push |
| 10b | PDF revisados en la web con la URL de siempre (Víctor, 25/11/2026) | `python3 scripts/temas-revisados-web.py` (copia de `temario-publicado` el tema a `tercer-ejercicio/3A08.pdf` y la ficha a `3A08-repaso.pdf`; la primera vez mueve el antiguo a `tercer-ejercicio/anterior/`; la guía del dictamen, a `primer-ejercicio/esquema_dictamen_economico.pdf` y `…-resumen.pdf`); `git add` de los PDF; `python3 scripts/metadatos-pdf.py` (título, conceptos del índice y licencia de uso personal), `python3 scripts/datos-estructurados-temario.py`, `node generate-sitemap.js`, `node build-search-index.js`, `node build-app-data.js`; commit y push | `git revert` del commit |
| 11 | Comprobar en vivo | `/app/`, `/oposicion/economia.html`; en `/oposicion/temario/tercer-ejercicio.html`, sin sesión, un tema revisado da el aviso con «Seguir con el tema antiguo» (y el 3.A.14, sin antigua, solo el de entrar) y, con sesión, abre `tema-revisado.html` con PDF, Word, ficha y versión antigua; lo mismo desde el buscador, la lista de exclusivos de `/oposicion/temario.html` y la guía del dictamen (`tema-revisado.html?tema=1D01`); la app web en `/app/abrir/` (con sesión, el tema revisado; sin sesión, el aviso y la antigua a un toque); el conector ya no ofrece `examen-espana` ni `solucion-espana` en `leer_guia_dictamen` | — |
| 12 | Al aprobarse en Play | `versionActual: "1.26.0"` en `oposicion/app-config.json`; una sola novedad con lo de `app/play-store/novedades-pendientes.md` (`python3 scripts/novedades.py`); push | — |

## Examen de España: lo que ya era público (hecho el 24/11/2026)

El examen de ejemplo de España del dictamen y su solución estaban en GitHub,
que es público, aunque no se enlazaban desde ningún sitio. Lo hecho el 24/11/2026:

- La carpeta `oposicion/temario/fuentes/1D01/examen-espana/` se sacó de toda la
  historia de las ramas públicas `revision-temario-2` y `revision-temario`
  (reescritas y empujadas con `--force`).
- Se movió al repositorio privado `vgutierrezmarcos/tcee-examen-espana` (copia
  local en `Documents/src/tcee-examen-espana`) y queda ignorada en el worktree
  de revisión.
- Los ZIP de la skill de las dos ramas se limpiaron (sin
  `references/dictamen/examen-espana.md` ni `solucion-espana.md`).

Pendiente:

- (a) Pedir a GitHub Support que purgue las vistas en caché y los commits
  sueltos (ruta `oposicion/temario/fuentes/1D01/examen-espana/` y los `.md` del
  ZIP; ramas `revision-temario-2` y `revision-temario`).
- (b) Quedan copias en la historia de `main`: las referencias de la skill
  (`oposicion/temario/app/skill/prepara-oposicion/references/dictamen/`, del
  28/10 al 10/11/2026; commits 55c59eb4 y 555b6f36). Víctor decidió no
  reescribir `main` (lo recomendado); se incluye en la misma petición a GitHub
  Support.
- (c) El día del lanzamiento: el paso 5 borra las claves del KV
  (`dictamen/examen-espana.md` y `dictamen/solucion-espana.md`) y el paso 7
  despliega el Worker sin ellas; en el paso 10, `exclusivos.py` sustituye el
  enlace antiguo por githack al ZIP en `oposicion/exclusivos.json`.

Las copias que alguien ya haya bajado no se pueden retirar.

## Versión estable cerrada (25/11/2026)

Víctor: «que quede todo en main; las ramas se crearán cuando haya que volver a
hacer cosas». Queda así:

- **`main`**: lo único en lo que se trabaja (web, app, scripts, conector). App
  1.27.0 (70) en producción en Google Play, `versionActual` 1.27.0 y APK de
  respaldo de la 1.27.0.
- **`temario-publicado`**: no es una rama de trabajo, sino el almacén del temario
  revisado que leen la app (desde la 1.26.0), la web (`exclusivos.js`,
  `tema-revisado.html`) y los scripts. No cabe en `main` (unos 1,5 GB, y la web
  de GitHub Pages tiene un tope de 1 GB). Nadie la toca a mano: la rehace
  `scripts/rama-publicada.py`.
- **`revision-temario-2`**: cerrada. Archivada en la etiqueta
  `revision-temario-2-final` (8ed5c2b4) y borrada como rama. La carpeta del
  worktree se ha movido a `../victorgutierrezmarcos.github.io-revision-2-archivo`
  porque guarda material que no está en git: los `_trabajo/` de cada tema
  (1,3 GB) y la copia ignorada del examen de España.
- **`revision-temario`**: se queda en GitHub mientras haya gente con la app
  anterior a la 1.26.0, que lee de ella los temas revisados.

Para volver a revisar temas:

    git worktree add ../victorgutierrezmarcos.github.io-revision-2 -b revision-temario-2 revision-temario-2-final
    # y copiar del archivo las carpetas ignoradas que hagan falta:
    #   oposicion/temario/fuentes/*/_trabajo/ y oposicion/temario/fuentes/1D01/examen-espana/

Después, para publicar: `python3 scripts/rama-publicada.py`, `git -C <worktree>
push --force origin temario-publicado` y `python3 scripts/rama-publicada.py
--comprobar` (paso 4), y en `main` `python3 scripts/temas-revisados-web.py`
(paso 10b).

## Después (no forma parte del lanzamiento)

- Los PDF del temario son públicos en raw/githack (la sesión solo decide qué
  se enseña). Si hiciera falta protegerlos de verdad, se servirían desde el
  Worker con el token de Firebase.
- Revisión del temario del 4.º ejercicio y vídeos o cantes de los temas.

Autor: Víctor Gutiérrez Marcos
