# El conector «Prepara con Claude»: cuando los datos llegan solos

Si el opositor tiene conectado el conector oficial de la web (un servidor MCP remoto: `mcp/README.md` en el repositorio), tienes herramientas que empiezan por `leer_`, `proponer_cronograma`, `guardar_informe_cante`, `listar_temas_revisados` y `desconectar`. Entonces:

- **No le pidas que exporte ni suba `oposicion_<id>_para_claude.json`**: llama a las herramientas. Lo que devuelven es el mismo JSON que describe `datos-app.md`, repartido en cuatro llamadas (progreso, tests, cantes, cronograma), con fechas `AAAA-MM-DD` y los códigos de tema con puntos (`3.A.8`).
- Si no hay herramientas del conector en la conversación, sigue como siempre con los ficheros exportados. No menciones el conector salvo que el opositor pregunte cómo ahorrarse la exportación: entonces, `oposicion/prepara-con-claude.html` explica cómo añadirlo.
- Las herramientas son del opositor conectado y solo de él. Nunca busques datos de otra persona ni le pidas a un preparador que las use para sus alumnos: no funcionarían (las reglas de Firestore solo dejan al dueño) y no es el uso autorizado.

## La skill viene en el conector

El conector lleva la skill dentro: `leer_skill()` devuelve `SKILL.md` y `leer_skill(ruta)` cualquier fichero que cite (`references/…`, `assets/…`, `scripts/…`), siempre en su última versión. Así, quien solo ha añadido el conector tiene el equipo completo sin subir ningún ZIP. Si además tiene la skill instalada, es la misma: usa cualquiera de las dos. Los scripts (`informe-pdf.py`, `grafico.py`) y la plantilla LaTeX se leen con `leer_skill` y se guardan en el entorno de código antes de ejecutarlos; las fuentes OTF no son texto: si hacen falta para el PDF y no se pueden bajar de la web, usa las del sistema (Pagella y Latin Modern suelen estar) o entrega el Markdown.

## Fuentes y programa

`fuentes_tema(tema)` reúne todo lo que hay para estudiar un tema (TCEE o DCE): si está revisado, el PDF de victorgutierrezmarcos.es, el tema equivalente de manuelcabadogarcia.es, los apuntes de otros TCEE del repositorio de la ATCEE (autor, promoción, numeración y enlace) y los manuales que la ATCEE recomienda para su bloque. `buscar_temario(consulta)` busca en el programa por materia, bloque o palabras y agrupa los temas por bloque de la organización del temario. `leer_fuente(enlace)` lee cualquiera de esas fuentes: un apunte del repositorio de la ATCEE (PDF, Word, .doc, PowerPoint o Documento de Google), el PDF de un tema de victorgutierrezmarcos.es o una página de manuelcabadogarcia.es, y devuelve el esquema, la extensión y el texto por tramos: úsalo para valorar, comparar u ordenar fuentes por calidad (pide primero el esquema y un tramo corto de cada uno; lee entero solo el que haga falta). Valora con criterios explícitos: cubre el título oficial, actualidad de datos y bibliografía, rigor y orden, si cabe en el tiempo del cante, y lo que el tema revisado considera esencial. No reproduzcas su texto: resume y cita al autor y la promoción. Los de numeración antigua (anteriores a la promoción LXXIII) pueden no ser el mismo tema: comprueba el nombre del fichero.

## Qué devuelve cada una

| Herramienta | Cuándo | Qué trae |
|---|---|---|
| `leer_progreso(oposicion)` | Al empezar casi cualquier tarea (cronograma, dudas, tribunal) | `examen.fechas` por ejercicio e `hitos`; `temas.estudiados`, `enRepaso` y `agenda` (vueltas y pendientes por tema); `notas` propias por tema; `horario` por día; `leitner` (`porCaja`, `vencidas`, `temasConMasFallos`); `ajustes.rubrica` (si usa la rúbrica), `temasExtraidos`, `fechaConvocatoria`, `noCantar` |
| `leer_resultados_test(desde, limite)` | Para el plan de test o para ver qué temas fallan | `tests[]` del más reciente al más antiguo con `notaSobre10`, aciertos, fallos, sin responder, `tiempoSeconds`, `tipo` (`test`, `diario`, `repaso`) y `porTema` (solo en los hechos en la app) |
| `leer_cantes(n)` | Antes de corregir un cante o de valorar la evolución | `hechos[]` (los últimos `n`, con `id`, fecha, temas, `esquema`, `resultado` como en `datos-app.md` y `deberes`), `pendientes[]` (los próximos) y `totalHechos`. **La transcripción no viene**: el opositor la sube él (`cante_<tema>_<fecha>.txt`) |
| `leer_cronograma` | Antes de proponer o retocar el cronograma | El activo: `semanas[]` (`lunes`, `cante`, `temas`, `descanso`), `hechos`, `desmarcados`, `temasPorSemana`, `diaCante` (1 = lunes … 7 = domingo), `fases` y `examen` si es por fases, `propuestasPendientes` de sus preparadores |
| `listar_temas_revisados` | Antes de citar un tema revisado | Qué temas tienen texto, ficha y guion, y qué documentos del dictamen y del canon hay |
| `leer_tema(tema, apartado, guion)` | Para corregir un cante o resolver una duda con el texto revisado | El tema en Markdown, entero o un apartado (`«II»`, `«B»`, `«Introducción»` o parte del título); con `guion: true`, el guion del cante de 30 minutos |
| `leer_ficha(tema)` | Para repasar o para comparar un esquema a ciegas | La ficha de repaso de cuatro páginas |
| `leer_guia_dictamen(documento, seccion)` | Para corregir un dictamen | `guia-1D01`, `resumen-1D01`, `guion-1D01`, `examen-espana`, `solucion-espana`, enteros o por sección |
| `leer_canon(documento)` | Para la notación o para saber en qué tema vive un modelo | `notacion` o `modelos-indice` |

Todas aceptan `oposicion` (`tcee` por defecto, `dce` si el opositor prepara DCE: pregúntalo una vez y mantenlo en toda la conversación). Lee solo lo que necesitas: `leer_cantes` con `n` pequeño y `leer_resultados_test` con `desde` reciente bastan casi siempre.

## Perfil preparador (herramientas previstas, fase 2 b)

Cuando existan, `leer_perfil` (papeles por oposición: opositor, preparador o los dos), `leer_alumnos`, `leer_cantes_alumno(alumno, n)`, `leer_sesiones(n)`, `guardar_nota_alumno(alumno, texto)` y `guardar_deberes(alumno, lineas)` sirven al perfil de preparador (`perfiles.md`) con los mismos permisos que tiene en la app (solo lo que cada alumno ha decidido que vea). Si en la conversación no están, el perfil se decide como dice `perfiles.md` y los datos de cada alumno los exporta el alumno desde su app.

## Cuándo escribir en la app

Dos herramientas escriben, y las dos **solo después de que el opositor haya visto el resultado entero y confirme expresamente** («sí, guárdalo en la app»). Nunca escribas «por si acaso», ni como paso intermedio, ni para corregir algo que acabas de guardar sin decírselo.

- **`proponer_cronograma`** sustituye al bloque «Traer el tuyo» de `datos-app.md` §5: en vez de devolver el bloque de texto para que lo pegue, enséñale la tabla explicativa, pregúntale si lo guarda y, si dice que sí, llama a la herramienta con una entrada por semana de cante (`cante` en `AAAA-MM-DD`, siempre el día de cante de `leer_cronograma` o el que te diga; `temas` con los códigos con puntos), `diaCante`, `ejercicio` y, si procede, `temasPorSemana` y `examen` (ejercicio escrito). El anterior queda archivado, no borrado: díselo, y que lo verá en la app al sincronizar. Si la herramienta devuelve errores (fecha fuera del día de cante, tema repetido), corrige y vuelve a preguntar; no insistas sin enseñarle el cambio.
- **`guardar_informe_cante`** sustituye a copiar el bloque «Para la app» (`datos-app.md` §4): al terminar el informe de un cante que está en su diario (`id` de `leer_cantes`; si el cante no está aún en la app, que lo cierre allí primero), ofrécele guardarlo y, con su sí, llama a la herramienta con `informe` (el informe completo en Markdown), `valoracion` (1-5 con el criterio de §4), `valoraciones` por tema si cantó varios, `comentarios` (≤ 300 caracteres, lo más importante primero), `criterios` solo si usa la rúbrica (`ajustes.rubrica` no vacía) y `tareas` (las tres de antes del próximo cante). La valoración y los comentarios pasan al diario como si los hubiera escrito él; el informe queda guardado junto al cante y lo ve también su preparador enlazado (como ve el cante): díselo antes de guardar. Si el opositor prefiere no tocar el diario, llama solo con `informe`.

Si una herramienta responde que la sesión ha caducado o se ha revocado, no lo reintentes: dile que vuelva a conectar el conector en Claude (Personalizar → Conectores) y sigue, mientras tanto, con lo que tengas en la conversación o con los ficheros exportados.

## `desconectar`

Solo si el opositor lo pide con esas palabras o parecidas («desconéctate de la app», «quita el acceso»). Confírmalo en una frase y llama con `confirmar: true`. Después, el resto de herramientas dejan de funcionar hasta que vuelva a conectar. Si lo que quiere es borrar algo que se guardó por error, eso se hace en la app (el informe o el cronograma se pueden borrar allí), no desconectando.

## Skill ligera

Cuando la skill está instalada en su versión «ligera» (sin `references/temas`, `references/dictamen` ni `references/canon`: `scripts/skill-opositor.py --ligera`), los temas revisados, las fichas, la guía del dictamen y el canon se leen **siempre** con `leer_tema`, `leer_ficha`, `leer_guia_dictamen` y `leer_canon`; `listar_temas_revisados` sustituye a `references/temas/INDICE.md`. Todo lo demás de la skill (el método de corrección, `como-se-canta.md`, los agentes, `oposiciones/`) sigue igual. El material que llega por el conector es exclusivo del opositor conectado: no lo copies fuera de la conversación ni lo resumas para terceros.
