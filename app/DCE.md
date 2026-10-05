# DCE en la app: guía para la web de Manuel

La app «Oposición TCEE · DCE» sirve a dos oposiciones independientes. Cada usuario elige la suya al abrirla, y su papel en ella (opositor o preparador); las dos cosas se cambian en *Más → Ajustes*, y cada oposición tiene su contenido, los datos de sus opositores y su propia red de preparadores. La app es una sola, para no duplicar nada: la versión para Android, la del navegador ([victorgutierrezmarcos.es/app/abrir/](https://www.victorgutierrezmarcos.es/app/abrir/)) y su página ([victorgutierrezmarcos.es/app/](https://www.victorgutierrezmarcos.es/app/)). **El contenido de DCE lo descarga de la web de Manuel, [manuelcabadogarcia.es](https://manuelcabadogarcia.es)**, así que actualizar su web actualiza la app sin publicar una versión nueva.

**Aspecto**: con DCE elegida, la app usa los colores y la tipografía de su web: granate `#7a1f4b`, crema `#f7f4ec` y azul `#234a6b` (en oscuro, fondo `#1e1d1b` y verde menta `#3ee6a8`), con Latin Modern Roman (`PaletaMarca.dce` en `lib/theme/app_theme.dart`). El logo es la diana partida: la mitad izquierda con los colores de TCEE y la derecha con los de DCE.

**Temas en la web**: los apuntes de Manuel son páginas web, no PDF. La ficha del tema muestra «Leer el tema», que abre la página dentro de la app (`Tema.esPaginaWeb`).

Desarrolladores: Víctor Gutiérrez Marcos (TCEE) y Manuel Cabado García (DCE).

## El examen de DCE en la app

Según la convocatoria de la OEP 2025 ([BOE-A-2025-26896](https://www.boe.es/diario_boe/txt.php?id=BOE-A-2025-26896)). Está en `lib/data/models/oposicion.dart` (`Oposiciones.dce`):

| Ejercicio | Qué es | En la app |
|---|---|---|
| 1.º | Escrito: dos temas, uno de cada par extraído de cada parte (A, Economía española, 18 temas; B, Economía pública, políticas comunitarias e instituciones multilaterales, 18) | Sorteo y probabilidad (2 temas por parte), cronograma |
| 2.º | Idiomas | Solo la fecha |
| 3.º | Oral: dos temas, uno de cada par de cada parte (A, Microeconomía y economía del sector público, 22; B, Macroeconomía y economía internacional, 22). 30 min de preparación y 40 de exposición | Cantes, sorteo, probabilidad, cronograma, preparadores y sustituciones |
| 4.º | Escrito: dos temas, uno de cada par de cada parte (A, Técnicas comerciales y marketing internacional, 10; B, Organización del Estado, 9) y ocho preguntas prácticas | Sorteo y probabilidad (2 temas por parte), cronograma |

La probabilidad de aprobar se calcula como en el Excel de organización de TCEE: en cada parte, la de saberse al menos uno de los dos temas del par, `x/N + (N−x)/N · x/(N−1)`, y en cada ejercicio, el producto de sus partes. Da por hechos los idiomas y las preguntas prácticas del 4.º.

**DCE no tiene test**, pero la app deja practicar el de TCEE de forma voluntaria (con un aviso que lo explica). Los resultados se guardan en el historial de DCE, no en el de TCEE.

## Qué tiene que publicar la web de DCE

Ya están generados en [`para-manuel/`](para-manuel/), con instrucciones para él en [`para-manuel/LEEME.md`](para-manuel/LEEME.md): copiar la carpeta `oposicion/` a su web y añadirla a `resources` de su `_quarto.yml`. El temario se genera con `python3 scripts/generar-temario-dce.py` (títulos del programa oficial del BOE y enlaces de los temas que ya ha publicado, sacados de su «Índice de temas»).


Con el mismo formato que la web de TCEE, en la carpeta `/oposicion/` de su web (se puede cambiar con `rutaContenido`):

| Fichero | Para qué | Cómo se hace en TCEE |
|---|---|---|
| `oposicion/temario/temario.json` | Ejercicios, partes, temas y enlaces a los PDF | `node build-app-data.js` |
| `oposicion/organizacion/estructura_temario.json` | Bloques con colores, esquemas y conexiones (opcional: sin él, la app funciona sin colores ni esquemas) | `python3 scripts/extraer-estructura-temario.py` a partir del PowerPoint |
| `oposicion/enlaces.json` | Enlaces útiles (opcional) | `node build-app-data.js` |
| `oposicion/app-config.json` | Contacto, avisos y, si hiciera falta, otras reglas de sorteo (`sorteo`) sin publicar la app | A mano |
| `oposicion/organizacion/como_cantar_un_tema.pdf` | Ayuda de la pantalla Cantar (opcional) | — |

Los **códigos de tema** siguen la forma `ejercicio.parte.número`, con los ejercicios de DCE: `1.A.1`–`1.A.18`, `1.B.1`–`1.B.18`, `3.A.1`–`3.A.22`, `3.B.1`–`3.B.22`, `4.A.1`–`4.A.10` y `4.B.1`–`4.B.9`. Pueden coincidir con códigos de TCEE: los datos de cada oposición van aparte.

GitHub Pages permite que la app pida estos ficheros desde otro dominio, así que no hay que configurar nada más.

## Inicio de sesión e historial (mismo Firebase)

La app y las dos webs usan el mismo proyecto de Firebase (`web-vgm`), para que haya un solo inicio de sesión.

1. Víctor da acceso a Manuel al proyecto en la consola de Firebase y añade el dominio de su web en *Authentication → Settings → Authorized domains*.
2. La web de DCE usa el mismo `firebase-config.js`, pero con `const OPOSICION_WEB = 'dce';`. Así su simulador y su cuenta guardan en `users/{uid}/oposiciones/dce/…` (con `docUsuario(db, uid)`), sin mezclarse con TCEE.

## Administrador de la red de preparadores de DCE

Cada oposición tiene su red: un preparador verificado en TCEE no lo está en DCE, y quien prepare las dos tiene que verificarse en cada una. Manuel es el administrador de DCE y Víctor, el de TCEE.

- En la consola de Firestore, crear el documento `oposiciones/dce/admins/{correo de Google de Manuel}` (con cualquier campo, p. ej. `desde: "consola"`).
- Después, en la app: *Más → Ajustes → Oposición → DCE* (le aparece por ser administrador, aunque no esté lanzada), *Más → Ajustes → Tu papel → Preparador* y *Más → Preparador → Verificarme*.

Víctor es además **administrador general**: su documento `admins/{…}` de la raíz lleva el campo `general: true`, y con él administra también la red de DCE.

Las reglas (`firestore.rules`, generadas con `tool/reglas/generar.py`) ya separan las dos redes y sus administradores.

## Enlazar la app desde su web

- Página de la app: `https://www.victorgutierrezmarcos.es/app/`
- App en el navegador: `https://www.victorgutierrezmarcos.es/app/abrir/`
- Descarga para Android: la `urlApk` de `https://www.victorgutierrezmarcos.es/oposicion/app-config.json` (o copiar `app-banner.js`, que la rellena sola).

## Lanzamiento (lo hace Víctor cuando lo decida)

1. Comprobar que su web publica los ficheros de arriba (https://manuelcabadogarcia.es/oposicion/temario/temario.json). En la rama `dce` ya están su web y `lanzada: true`. Hasta entonces, DCE solo la ven en la app sus administradores y el general, en *Más → Ajustes → Oposición*.
2. Fusionar `main` en `dce` (para traer lo último de TCEE) y después `dce` en `main`.
3. Publicar `firestore.rules` en la consola (si ha cambiado) y crear el administrador de DCE.
4. Subir la versión en `pubspec.yaml`, compilar el APK y la versión web (`scripts/publicar-app-web.py`) y poner la versión en `app-config.json`.
5. Rehacer las capturas y el vídeo de `app/index.html` con las dos oposiciones (`tool/capturas_test.dart`, `scripts/montar-video-app.py`).
