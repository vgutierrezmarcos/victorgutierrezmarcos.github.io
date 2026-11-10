# El conector «EconomIA»: cuando los datos llegan solos

Si el usuario tiene conectado el conector oficial de la web (un servidor MCP remoto: `mcp/README.md` en el repositorio), tienes herramientas como `empezar`, las que empiezan por `leer_`, `preguntas_test`, `proponer_cronograma`, `guardar_informe_cante`, `anotar_tema`, `agendar_clase` y `desconectar`. Entonces:

- **Empieza por `empezar`**: en una llamada dice si es opositor, preparador o las dos cosas, en qué oposición tiene datos (pásala en `oposicion` a todo lo demás), cuántos días faltan para cada ejercicio, qué toca esta semana, sus últimos cantes, los deberes pendientes y las tareas que dejó la última corrección guardada. No preguntes lo que ya viene ahí.
- **No le pidas que exporte ni suba `oposicion_<id>_para_ia.json`**: llama a las herramientas. Lo que devuelven es el mismo JSON que describe `datos-app.md`, repartido en varias llamadas (progreso, tests, cantes, cronograma), con fechas `AAAA-MM-DD` y los códigos de tema con puntos (`3.A.8`).
- Si no hay herramientas del conector en la conversación, sigue como siempre con los ficheros exportados. No menciones el conector salvo que pregunte cómo ahorrarse la exportación: entonces, `oposicion/economia.html` explica cómo añadirlo.
- Las herramientas son del usuario conectado. Un opositor solo ve lo suyo. Un preparador ve, además, lo que cada alumno enlazado comparte con él en la app (apartado «Perfil preparador»): nunca busques datos de nadie más ni compares alumnos entre sí sin que lo pida.
- Los textos largos (un tema, la guía del dictamen, el canon) llegan por tramos: pide el `apartado` o la `seccion` que necesites y, si hace falta seguir, repite la llamada con el `desde` que indica el final del tramo.

## La skill viene en el conector

El conector lleva la skill dentro: `leer_skill()` devuelve `SKILL.md` y `leer_skill(ruta)` cualquier fichero que cite (`references/…`, `assets/…`, `scripts/…`), siempre en su última versión. Así, quien solo ha añadido el conector tiene el equipo completo sin subir ningún ZIP. Si además tiene la skill instalada, es la misma: usa cualquiera de las dos. Para una tarea concreta, `leer_metodo(tarea)` da de una vez el agente que la hace, las reglas comunes y cómo se entrega (sin tarea, la lista); es lo que usan las otras IA (ChatGPT, Le Chat, Gemini), que no tienen skills, y los *prompts* del conector («Corregir un cante», «Simulacro completo»…) lo cargan solos. Los scripts (`informe-pdf.py`, `grafico.py`) y la plantilla LaTeX se leen con `leer_skill` y se guardan en el entorno de código antes de ejecutarlos; las fuentes OTF no son texto: si hacen falta para el PDF y no se pueden bajar de la web, usa las del sistema (Pagella y Latin Modern suelen estar) o entrega el Markdown.

## Fuentes y programa

`fuentes_tema(tema)` reúne todo lo que hay para estudiar un tema (TCEE o DCE): si está revisado, el PDF de victorgutierrezmarcos.es, el tema equivalente de manuelcabadogarcia.es, los apuntes de otros TCEE del repositorio de la ATCEE (autor, promoción, numeración y enlace) y los manuales que la ATCEE recomienda para su bloque. `buscar_temario(consulta)` busca en el programa por materia, bloque o palabras y agrupa los temas por bloque de la organización del temario. `leer_fuente(enlace)` lee cualquiera de esas fuentes: un apunte del repositorio de la ATCEE (PDF, Word, .doc, PowerPoint o Documento de Google), el PDF de un tema de victorgutierrezmarcos.es o una página de manuelcabadogarcia.es, y devuelve el esquema, la extensión y el texto por tramos: úsalo para valorar, comparar u ordenar fuentes por calidad (pide primero el esquema y un tramo corto de cada uno; lee entero solo el que haga falta). Valora con criterios explícitos: cubre el título oficial, actualidad de datos y bibliografía, rigor y orden, si cabe en el tiempo del cante, y lo que el tema revisado considera esencial. No reproduzcas su texto: resume y cita al autor y la promoción. Los de numeración antigua (anteriores a la promoción LXXIII) pueden no ser el mismo tema: comprueba el nombre del fichero.

## Qué devuelve cada una

| Herramienta | Cuándo | Qué trae |
|---|---|---|
| `empezar()` | Al principio de la conversación, siempre | Por oposición con datos: si es opositor o preparador, `examenes` con los días que faltan, `cronograma.estaSemana` y `siguiente`, `ultimosCantes`, `proximasClases`, `deberesPendientes`, `ultimaCorreccion.tareas`, tests de los últimos siete días; `oposicionPrincipal` y qué temas revisados sirve el conector |
| `leer_progreso(oposicion)` | Al empezar casi cualquier tarea (cronograma, dudas, tribunal) | `examen.fechas` por ejercicio e `hitos`; `temas.estudiados`, `enRepaso` y `agenda` (vueltas y pendientes por tema); `notas` propias por tema; `horario` por día; `leitner` (`porCaja`, `vencidas`, `temasConMasFallos`); `ajustes.rubrica` (si usa la rúbrica), `temasExtraidos`, `fechaConvocatoria`, `noCantar` |
| `leer_resultados_test(desde, limite)` | Para el plan de test o para ver qué temas fallan | `tests[]` del más reciente al más antiguo con `notaSobre10`, aciertos, fallos, sin responder, `tiempoSeconds`, `tipo` (`test`, `diario`, `repaso`) y `porTema` (solo en los hechos en la app) |
| `leer_cantes(n)` | Antes de corregir un cante o de valorar la evolución | `hechos[]` (los últimos `n`, con `id`, fecha, temas, `esquema`, `resultado` como en `datos-app.md` y `deberes`), `pendientes[]` (los próximos) y `totalHechos`. **La transcripción no viene**: el opositor la sube él (`cante_<tema>_<fecha>.txt`) |
| `leer_informes_cante(canteId, n, completo)` | Antes de corregir un cante nuevo, en el informe de la semana y en «cómo voy» | Las correcciones guardadas (de esta IA o de otra): fecha, valoración, criterios, comentarios, `tareas` y el informe (recortado salvo `completo`). Sirve para ver si repite fallos y si hizo las tareas |
| `preguntas_test(temas, n, modo)` | Para un test a medida | Preguntas oficiales de esos temas con `respuesta`, `porQue` (la explicación de la web) e `historial` del opositor; `modo`: `no_dominadas` (por defecto), `falladas` o `todas`. Sustituye a abrir los ficheros de `references/test/` |
| `leer_proceso(oposicion, seccion)` | Fechas de examen, plazos, novedades de la convocatoria | Los documentos que ha publicado el Ministerio del proceso en curso, por sección, y las últimas novedades con su fecha |
| `leer_cronograma` | Antes de proponer o retocar el cronograma | El activo: `semanas[]` (`lunes`, `cante`, `temas`, `descanso`), `hechos`, `desmarcados`, `temasPorSemana`, `diaCante` (1 = lunes … 7 = domingo), `fases` y `examen` si es por fases, `propuestasPendientes` de sus preparadores |
| `listar_temas_revisados` | Antes de citar un tema revisado | Qué temas tienen texto, ficha y guion, y qué documentos del dictamen y del canon hay |
| `leer_tema(tema, apartado, guion)` | Para corregir un cante o resolver una duda con el texto revisado | El tema en Markdown, entero o un apartado (`«II»`, `«B»`, `«Introducción»` o parte del título); con `guion: true`, el guion del cante de 30 minutos |
| `leer_ficha(tema)` | Para repasar o para comparar un esquema a ciegas | La ficha de repaso de cuatro páginas |
| `leer_guia_dictamen(documento, seccion)` | Para corregir un dictamen | `guia-1D01`, `resumen-1D01`, `guion-1D01`, `examen-espana`, `solucion-espana`, enteros o por sección |
| `leer_canon(documento)` | Para la notación o para saber en qué tema vive un modelo | `notacion` o `modelos-indice` |

Todas aceptan `oposicion` (`tcee` por defecto, `dce` si el opositor prepara DCE: pregúntalo una vez y mantenlo en toda la conversación). Lee solo lo que necesitas: `leer_cantes` con `n` pequeño y `leer_resultados_test` con `desde` reciente bastan casi siempre.

## Perfil preparador

Si `empezar` dice que el usuario es preparador (`esPreparador`), tiene además:

| Herramienta | Qué trae o hace |
|---|---|
| `leer_alumnos(oposicion)` | Sus alumnos (id, nombre, ejercicio, si están enlazados, última clase con su valoración y próxima clase), las reservas que le han pedido y no ha contestado y las peticiones de enlace pendientes |
| `leer_alumno(alumno, n)` | La ficha de uno: sus notas privadas sobre él, las últimas clases (tema cantado, valoración, comentarios, criterios, deberes) y las próximas; y, si está enlazado, lo que el alumno comparte: temas estudiados y en repaso, temas que pide no cantar, su cronograma (si lo comparte) y las correcciones guardadas de las clases con este preparador. No da sus tests ni sus notas personales |
| `preparar_clase` y `agendar_clase` | Crear una clase con un alumno (`references/agentes/agendar-clase.md`) |
| `responder_reserva(reserva, aceptar)` | Aceptar (crea la clase en las dos agendas) o rechazar una clase que le han pedido |
| `guardar_nota_alumno(alumno, nota)` | Añadir una anotación con fecha a sus notas privadas del alumno |
| `guardar_deberes(sesion, tareas)` | Poner deberes en una clase: `estudiar`, `esquema`, `cantar` (con tema), `test` (con mínimo de preguntas) o `libre` |

Un alumno por llamada y por informe. La transcripción de un cante de un alumno no está en la nube: la pasa el alumno o el preparador. Sin estas herramientas, el perfil se decide como dice `perfiles.md` y los datos de cada alumno los exporta el alumno desde su app.

## Cuándo escribir en la app

Las herramientas que escriben (`proponer_cronograma`, `guardar_informe_cante`, `anotar_tema`, `agendar_clase` y, para preparadores, `responder_reserva`, `guardar_nota_alumno` y `guardar_deberes`) se usan **solo después de que el usuario haya visto el resultado entero y confirme expresamente** («sí, guárdalo en la app»). Nunca escribas «por si acaso», ni como paso intermedio, ni para corregir algo que acabas de guardar sin decírselo.

- **`proponer_cronograma`** sustituye al bloque «Traer el tuyo» de `datos-app.md` §5: en vez de devolver el bloque de texto para que lo pegue, enséñale la tabla explicativa, pregúntale si lo guarda y, si dice que sí, llama a la herramienta con una entrada por semana de cante (`cante` en `AAAA-MM-DD`, siempre el día de cante de `leer_cronograma` o el que te diga; `temas` con los códigos con puntos), `diaCante`, `ejercicio` y, si procede, `temasPorSemana` y `examen` (ejercicio escrito). El anterior queda archivado, no borrado: díselo, y que lo verá en la app al sincronizar. Si la herramienta devuelve errores (fecha fuera del día de cante, tema repetido), corrige y vuelve a preguntar; no insistas sin enseñarle el cambio.
- **`guardar_informe_cante`** sustituye a copiar el bloque «Para la app» (`datos-app.md` §4): al terminar el informe de un cante que está en su diario (`id` de `leer_cantes`; si el cante no está aún en la app, que lo cierre allí primero), ofrécele guardarlo y, con su sí, llama a la herramienta con `informe` (el informe completo en Markdown), `valoracion` (1-5 con el criterio de §4), `valoraciones` por tema si cantó varios, `comentarios` (≤ 300 caracteres, lo más importante primero), `criterios` solo si usa la rúbrica (`ajustes.rubrica` no vacía) y `tareas` (las tres de antes del próximo cante). La valoración y los comentarios pasan al diario como si los hubiera escrito él; el informe queda guardado junto al cante y lo ve también su preparador enlazado (como ve el cante): díselo antes de guardar. Si el opositor prefiere no tocar el diario, llama solo con `informe`.

- **`anotar_tema`** apunta en la agenda de un tema lo que tiene que arreglar en la próxima vuelta (uno por cosa, corto y concreto) y, si lo pide, lo marca como estudiado o en repaso. Ofrécelo al acabar una corrección, una duda larga o un test: «¿te lo apunto en el tema?». No repite lo que ya está pendiente.

`guardar_informe_cante` no cambia una valoración o unos comentarios que ya estuvieran en el diario (los pudo poner su preparador): lo dice en `yaHabia`; cuéntaselo y repite con `sustituir: true` solo si él lo pide. En un cante propio, las `tareas` quedan además como deberes en la app. `proponer_cronograma` conserva los temas ya hechos y sigue compartido con su preparador si el anterior lo estaba.

Si una herramienta responde que la sesión ha caducado o se ha revocado, no lo reintentes: dile que vuelva a conectar el conector en su asistente de IA (en Claude, Personalizar → Conectores) y sigue, mientras tanto, con lo que tengas en la conversación o con los ficheros exportados.

## `desconectar`

Solo si el opositor lo pide con esas palabras o parecidas («desconéctate de la app», «quita el acceso»). Confírmalo en una frase y llama con `confirmar: true`. Después, el resto de herramientas dejan de funcionar hasta que vuelva a conectar. Si lo que quiere es borrar algo que se guardó por error, eso se hace en la app (el informe o el cronograma se pueden borrar allí), no desconectando.

## Skill ligera

Cuando la skill está instalada en su versión «ligera» (sin `references/temas`, `references/dictamen` ni `references/canon`: `scripts/skill-opositor.py --ligera`), los temas revisados, las fichas, la guía del dictamen y el canon se leen **siempre** con `leer_tema`, `leer_ficha`, `leer_guia_dictamen` y `leer_canon`; `listar_temas_revisados` sustituye a `references/temas/INDICE.md`. Todo lo demás de la skill (el método de corrección, `como-se-canta.md`, los agentes, `oposiciones/`) sigue igual. El material que llega por el conector es exclusivo del opositor conectado: no lo copies fuera de la conversación ni lo resumas para terceros.

## Gráficos, test y documentos

Con el conector solo no tienes los ficheros de la skill en el entorno de código: para un gráfico como los de los temas revisados o un documento con la plantilla de los temas, descarga el kit (`scripts/` y `assets/`, con las fuentes) como dice `references/documentos-y-graficos.md` (léelo con `leer_skill('references/documentos-y-graficos.md')`). Sin ejecución de código, gráficos en SVG y documentos en HTML con las plantillas de ese mismo fichero.
