# Criterios de revisión del temario (/revisartema)

Este fichero es de Víctor: aquí se decide **cómo** se revisa cada tema. Todos
los agentes lo leen antes de empezar. Para cambiar el proceso basta con editar
este fichero (o pedírselo a Claude) y hacer commit en la rama
`revision-temario`. Si algo de aquí contradice a un agente, manda esto.

## 1. Objetivo

Cada tema revisado debe quedar:

1. **Correcto**: sin errores de teoría, fórmulas, fechas, autores ni datos.
2. **Cerrado**: sin nada pendiente. Todo lo subrayado en amarillo, el texto en
   rojo, las «Nota al opositor», los comentarios internos y los «Fuente: …»
   vacíos están resueltos.
3. **Actualizado**: con el último dato disponible de fuentes oficiales, y con
   cada dato citado.
4. **Coherente**: consigo mismo y con el resto del temario (mismas
   definiciones, notación, cifras y referencias cruzadas correctas).
5. **Cantable**: un opositor que lo estudie puede exponerlo en 30 minutos con
   una pizarra. El documento puede ser más largo que el cante (profundiza para
   preguntas del tribunal), pero el guion del cante dura 30 minutos.

## 2. Estilo de redacción

- Castellano cuidado, con todas las tildes. Términos en inglés en cursiva
  (*second-best*, *trade-off*) solo si son los habituales en la literatura.
- Estructura del tema (guía de Víctor «Cómo cantar un tema»,
  `oposicion/organizacion/como_cantar_un_tema.pdf`, y la de Manuel,
  manuelcabadogarcia.es/como-cantar-un-tema.html):
  - **Introducción**, siempre con los mismos cinco bloques: **Enganche**,
    **Relevancia**, **Contextualización**, **Problemática** (preguntas clave) y
    **Estructura** (los apartados y por qué ese orden). Las definiciones básicas
    se dan aquí.
  - **Se mantiene la estructura de bloques del tema original de Víctor**:
    los apartados de primer nivel y sus títulos de segundo nivel (I.1, I.2…),
    en su orden. Por debajo se puede reorganizar. No se reestructura según la
    ficha del tribunal. Lo que alarga demasiado el cuerpo (modelos
    complementarios, desarrollos empíricos, enfoques históricos) puede pasar a
    un **anexo**, nunca desaparecer. Si falta un epígrafe del título oficial,
    se añade donde encaje y se anota en el informe.
  - Apartados numerados **I., II., III.** con subapartados **I.1., I.1.1.**
    Cada apartado empieza anunciando su conclusión y termina con una
    recapitulación y el enlace con el siguiente. Cada concepto importante:
    definición, interpretación analítica e interpretación gráfica.
  - **Estructura de un modelo** (Víctor, 13/10/2026; para memorizar). Cada
    modelo se cuenta con estos bloques, con **títulos propios** de nivel 4 y 5
    (`\paragraph{a) Idea}`, `\subparagraph{i) Supuestos}`; letras a mano).
    Si un bloque no procede, se salta:
    a) **Idea**: contexto y por qué contamos este modelo.
    b) **Modelo**: i) **Supuestos**; ii) **Desarrollo** (en el cante importan
       sobre todo los resultados; analítico, gráfico o de palabra);
       iii) **Implicaciones**.
    c) **Extensiones**.
    d) **Evidencia empírica**: cómo se ve en los datos.
    e) **Valoración**: críticas y limitaciones, que abren la puerta al
       desarrollo siguiente (el tema tiene que tener **hilo conductor**).
  - **Conclusión**, con sus bloques: **Recapitulación** (ideas clave, sin
    repetir el tema), **Relevancia**, **Extensiones** (otros enfoques y
    partes del temario, para «lanzar la caña» al tribunal), **Opinión** (si
    procede) e **Idea final** (p. ej., la respuesta a la problemática).
  - **Reparto de minutos** (Víctor, 13/10/2026): introducción
    **2'00"–2'30"** y conclusión **1'00"–1'30"**; el cuerpo, **26–27
    minutos**. Los `\minutos{}` de los apartados suman exactamente eso (p. ej.
    intro 2,5 + cuerpo 26,5 + conclusión 1 = 30; se admiten medios minutos:
    `\minutos{2,5}`). Cada bloque recibe tiempo según su peso real en el
    título y en el examen.
- Orden del final del documento: **anexos** (con `\appendix`) y después la
  **bibliografía**. Salto de página (`\clearpage`) tras la conclusión, antes
  de los anexos (no tras la introducción); el de antes de la bibliografía lo
  pone `\bibliografia`.
- **Sin líneas viudas ni huérfanas** en ningún tema: ningún párrafo deja una
  línea sola al pie o al principio de una página (lo hacen `tcee.sty`, con
  penalizaciones de 10000, el control de viudas y huérfanas del Word y
  `orphans`/`widows` en la web). No se desactiva en ningún tema; si una página
  queda corta, se acepta el hueco.
- **Tablas de clasificación con color**, como en los temas en Word (p. ej.,
  la ecuación de Slutsky): fila de la ecuación sobre fondo salvia
  (`\cellcolor{tceesalvia}`), banda del título en `tceeazulpalido` o
  `tceesalmon` (`\rowcolor`), celdas combinadas (`\multirow`) y el texto de
  cada categoría en su color (`\textcolor{tceeverde}` normal/sustitutivos,
  `tceenaranja` inferior/complementarios, `tceeazul` ordinario, `tceerojo`
  Giffen). construir-tema.py lo pasa también a la web y a Word.
- Las derivaciones que no se cantan (agregaciones de Engel y Cournot,
  homogeneidad, simetría, identidades…) **no se borran**: van a un anexo.
- Enlace a preguntas de test: nunca a quia.com; un único enlace genérico al
  simulador: https://www.victorgutierrezmarcos.es/oposicion/temario/primer-ejercicio/test/simulador.html
- Mantener el estilo esquemático de los temas actuales: viñetas jerárquicas
  (■, –, ○), conceptos clave en **negrita** (`\concepto{}`), autores en
  versalitas (`\autor{}`) con el año de la obra.
- **Personas en versalitas** (regla fija, para memorizar y distinguir
  autores): el **apellido** de toda persona que se nombra va en versalitas,
  siempre, en el texto, gráficos y cajas: `\autor{Marshall}` (1890); el
  nombre de pila y el año, en redonda; con varios apellidos, todos
  (`\autor{Mas-Colell}`). Las citas (`\textcite`, `\parencite`) ya salen así
  en PDF, web y Word. La bibliografía final no.
- **Décadas y números en cifras**: «en los años 30», «los 70», «3 rasgos»
  cuando son datos o cantidades; nunca «los años treinta».
- **Preguntas entre signos**: si el texto plantea una pregunta («detrás está
  la pregunta…»), se escribe como pregunta: ¿…?
- **Vectores con flecha** encima (`\vect{x}`, `\vect{p}`, `\vect{z}`) en
  todas las fórmulas; los escalares (x_i, W̄, p_1) sin flecha.
- **Títulos de primer nivel** (bandas moradas): que quepan en una línea; si
  no, cortar donde tenga sentido con `\newline` (la segunda línea queda
  sangrada bajo el texto) y nunca dejar una palabra sola.
- **Recuadros grises** (`anotaciones` o una `tcolorbox` gris) para
  definiciones de apoyo y resultados técnicos que se consultan (p. ej.,
  funciones homogéneas y homotéticas).
- Referencias a otros temas con `\vertema{3.A.9}` (salen en gris). **Cada
  tema se canta solo**: se puede remitir con `\vertema{}`, pero **nunca** se
  dice en el texto que algo «se ha estudiado / visto / desarrollado en el
  tema …»; se cuenta lo necesario (aunque sea resumido) y se remite.
- Las notas al pie salen **siempre al pie de la página** (`footmisc` con
  `bottom`), aunque la página tenga hueco.
- Lecturas de clases y preparadores (ICEX-CECO…) se citan **como en el tema
  original**, sin añadir «no publicado».
- Cada apartado lleva sus minutos de cante con `\minutos{n}` tras el título.
  La suma debe ser 30.
- No inventar citas textuales: una cita entre comillas debe estar en la fuente
  citada.

## 3. Qué hacer con cada marca del Word original

| Marca | Qué hacer |
|---|---|
| Subrayado amarillo | Es una duda o tarea de Víctor («ver Segura pág. 29», «meter reflexiones filosóficas», «revisar las relaciones entre ellas»). Resolverla de verdad (consultando la fuente indicada o equivalentes) e integrar el resultado en el texto sin subrayado. |
| Texto en rojo | Contenido dudoso, nuevo o por confirmar. Verificarlo: si es correcto, se integra en negro; si no, se corrige o se quita. |
| «Nota al opositor» (caja amarilla) | Si es un aviso de cambio de temario o una nota de trabajo, desaparece. Si es un consejo útil para el cante, se reescribe en `notaopositor`. |
| «Comentario» (notas internas: clases, grabaciones, «coordinar con…») | No se publica. Si pide coordinar con otro tema, lo hace el agente de coherencia. |
| Texto oculto | Son notas privadas: nunca se publican. Se tienen en cuenta como pendientes. |
| «Caja de anotaciones» | Lecturas y enlaces complementarios: se comprueba que los enlaces funcionan y se conserva en `anotaciones`. |
| «No cantar» | Se mantiene en el documento, pero fuera del guion del cante. |
| «Fuente: …» vacía | Se busca la fuente real del gráfico o tabla. Si es elaboración propia, «Elaboración propia a partir de …». |
| Anexos | Se revisan igual que el resto. Lo que es solo para el test se marca como tal. |

Todo lo resuelto se anota en `revision.md` (apartado «Marcas resueltas»), con
el texto original y lo que se hizo.

## 4. Datos y fuentes

- **Fuentes por orden de preferencia**:
  1. Fuente primaria oficial: INE, Banco de España, Eurostat, BCE, Comisión
     Europea (AMECO, previsiones), FMI (WEO, BOP), OCDE, OMC, UNCTAD, Banco
     Mundial, BOE/EUR-Lex (normas), AIReF, IGAE, Ministerio de Economía,
     Comercio y Empresa (DataComex, Secretaría de Estado de Comercio),
     Ministerio de Hacienda.
  2. Publicaciones de estas instituciones (informes anuales, boletines).
  3. Manuales académicos de referencia (Mas-Colell, Varian, Romer, Krugman,
     Obstfeld, Blanchard, Stiglitz…) y artículos originales.
  4. Revistas ICE, Papeles de Economía Española, documentos de trabajo.
  5. Temas de otros preparadores (ver sección 5): **solo para contrastar**.
     Nunca son la fuente de un dato.
- **Último dato disponible** a la fecha de la revisión. Si el dato anual aún
  no ha cerrado, usar el último trimestre o mes y decirlo.
- **Doble comprobación**: cada cifra que cambia se comprueba en una segunda
  consulta independiente (otra tabla, otro organismo o la publicación oficial).
  Si no cuadra, se deja el dato anterior y se anota la duda.
- **Cómo citar**: dentro del texto, enlazado a la bibliografía, **nunca con
  una nota al pie solo para autor y año**. Si el autor se nombra en la frase,
  `\textcite{clave}` (sale «Slutsky (1915)»); si no, `\parencite{clave}`
  («(INE, 2026)»). Las notas al pie quedan para aclaraciones con texto. Cada
  dato cita una entrada del `.bib` del tema. Para fuentes en línea: autor institucional, título, año,
  `url` y `urldate` (fecha de consulta). Gráficos y tablas con `\fuente{…}`.
- Se respetan las citas que ya hay en el tema (bibliografía, notas al pie).
  Si una cita antigua no se puede comprobar, se anota en el informe.

## 5. Temas de otros preparadores y de Manuel

- Autores (en `scripts/temario/referencias.json`): Miquel Tebar Barbero,
  Andrea Cerezal Rodríguez, Juan Luis Cordero Tarifa y Luis de Fuentes, y los
  temas DCE de Manuel Cabado García (manuelcabadogarcia.es).
- Ojo: algunos usan la **numeración del temario anterior** (Cerezal: el «8A»
  es la dualidad). Comprobar siempre por el título.
- Se usan para detectar huecos, errores y enfoques mejores. Se puede tomar una
  idea, un orden o un gráfico, pero **redactado de nuevo y citando al autor**
  cuando la aportación sea suya. No se copia texto.
- **Temas sin original de Víctor** (33 según `canon/informe-repaso.md`): la
  estructura y el guion de contenidos salen, por este orden, de los temas de
  **Miquel Tebar**; si no los hay, de los de **manuelcabadogarcia.es** (son de
  DCE: hay que completar lo que el título de TCEE pida y ellos no cubran), y en
  su defecto de los apuntes de **Marta Ramírez**
  (https://sites.google.com/view/apuntes-tcee/). Siempre redactado de nuevo,
  con las fichas del canon y citando al autor de la estructura en `revision.md`.

## 6. Coherencia con el resto del temario

- Los títulos oficiales están en `oposicion/temario/temario.json`. El tema
  debe cubrir **todos** los epígrafes de su título, en ese orden.
- Bloques de temas relacionados en `oposicion/organizacion/estructura_temario.json`.
  Revisar los temas del mismo bloque y los citados con «[ver tema …]»: misma
  notación, mismas definiciones y sin contradicciones.
- **Canon común** (`oposicion/temario/canon/`, ver su `LEEME.md`): todas las
  revisiones son coherentes entre sí en cuatro sentidos.
  1. **Notación matemática**: la de `canon/notacion.md`, en todo el
     temario. Si un tema necesita un símbolo nuevo o cambiar uno, se propone
     el cambio al canon (no se inventa en el tema).
  2. **Mismo modelo, misma forma, adaptado a cada tema**: cada modelo que
     sale en varios temas se cuenta de forma **reconocible** (mismos
     supuestos de partida, mismas ecuaciones y notación, mismo gráfico de
     referencia) pero **adaptado a la pregunta que responde en ese tema**, y
     más extenso en su **tema de referencia** (ficha en `canon/modelos/`).
     Así se entiende y se memoriza el temario como un todo.
  3. **Estructura**: coherente dentro del tema (la introducción anuncia lo que
     se desarrolla, la conclusión lo recoge) y en perspectiva amplia: qué
     aporta el tema dentro de su bloque y del temario, sin solapes
     innecesarios con sus vecinos.
  - **3.er y 4.º ejercicio son dos exámenes distintos**, y los opositores
    suelen estudiar antes y con más detalle el 3.º. Por eso el **tema de
    referencia de un modelo teórico es, siempre que se pueda, uno del 3.er
    ejercicio**; el 4.º lo aplica (a España, al sector público) y lo resume
    remitiendo al 3.º. Cada tema tiene que poder cantarse en su examen sin
    depender de haber estudiado temas del otro ejercicio: un tema del 4.º
    resume lo imprescindible del modelo, aunque esté desarrollado en el 3.º,
    y un tema del 3.º no remite al 4.º para algo que necesite.
  4. **Referencias cruzadas** «[ver tema …]»: cada una apunta al tema donde
     de verdad se trata eso, con la numeración actual; se añaden las que
     faltan (sobre todo al tema de referencia de cada modelo que se use).
- Si se detecta una contradicción con **otro** tema, no se cambia el otro tema:
  se anota en `revision.md` («Coherencia») y, si es del canon, en
  `canon/pendientes-coherencia.md` para ponerlo al día con
  `--fase coherencia`.

## 7. Gráficos

- Todos los gráficos de teoría se rehacen en **TikZ** (o pgfplots si son
  datos), con los estilos de `oposicion/temario/latex/tikz-tcee.tex`: ejes con
  `\ejes`, curvas `curva1`…`curva4`, desplazamientos `curvanueva` y
  `desplazada`, líneas guía `\proyeccion`.
- El vídeo dibuja cada gráfico **trazo a trazo en el orden del código**: el
  código va en el orden en que el opositor lo dibujaría en la pizarra para
  demostrar que lo entiende (ejes y sus rótulos; primera curva y su rótulo;
  punto de equilibrio y sus proyecciones; desplazamiento; nuevo equilibrio…).
- Cada cosa que la narración nombra por separado va en su propia
  `\capa{n}{…}` (de grano fino), siempre como instrucción completa (nunca
  dentro de un camino). Los nodos con nombre que use una capa posterior se
  definen en la capa en que se dibujan o antes.
- Gráficos que muestran **cómo se obtiene** un concepto (no solo el resultado):
  p. ej., la curva de indiferencia como frontera de los conjuntos «al menos
  tan bueno como» y «no mejor que», o el mapa de indiferencia como proyección
  de la superficie de utilidad.
- Las representaciones en tres dimensiones, en perspectiva caballera (eje
  vertical hacia arriba, uno horizontal a la derecha y el de profundidad a
  45° con coeficiente 0,5; en pgfplots, `x={(1cm,0cm)}, y={(0.354cm,0.354cm)},
  z={(0cm,1cm)}` en lugar de `view`).
- Los gráficos de datos (series) se hacen con pgfplots a partir de
  `datos/*.csv` con el último dato y la fuente en la cabecera del CSV.
- Fotos, logotipos o escaneos que no son gráficos se quedan como imagen. Las
  capturas de tablas se convierten en tablas LaTeX.

## 8. Guion del cante y vídeo

### Cómo se canta (guías de Víctor y de Manuel)

- **Sin saludo**: se lee el título del tema y se entra directamente en el
  enganche. Nada de «Señores miembros del tribunal».
- Introducción con sus cinco bloques **en este orden y nombrándolos con
  naturalidad** para que el tribunal sepa dónde está: enganche, relevancia,
  contextualización, problemática y estructura.
- Al empezar cada apartado se dice cuál es («Paso al segundo bloque de la
  exposición: la estática comparativa») y su conclusión anticipada; al
  terminarlo, una recapitulación breve y el puente al siguiente.
- Conectores que guían al tribunal: «en primer lugar», «a continuación»,
  «como acabamos de ver», «esto nos lleva a…», «recapitulando…».
- **Pausas** entre bloques y apartados (el vídeo las pone: 1,8 s entre
  bloques y 1 s entre apartados).
- Lenguaje formal: «la exposición», no «el tema»; sin muletillas.
- La conclusión **empieza siempre por «En conclusión,» o «A modo de
  conclusión,»** (nunca «termino ya» ni similares) y sigue sus bloques:
  recapitulación, relevancia, extensiones, opinión e idea final.
- **No se dicen números de temas** en voz alta («como veremos en el 3.A.9»):
  se mencionan los enfoques o extensiones por su contenido («la teoría de la
  dualidad», «la demanda bajo incertidumbre»). En el guion escrito sí puede
  figurar el número entre corchetes como nota.
- **Nunca** se termina dando las gracias ni con fórmulas de despedida: la idea
  final es la última frase. El vídeo pone después la pantalla de cierre en
  silencio.
- Se usa la pizarra solo cuando ayuda (gráficos, fórmulas clave, esquema); la
  introducción y la conclusión se cantan sin pizarra.

### `guion-cante.md`

- Esquema de pizarra y texto del cante apartado a apartado, con minutos.
- Ritmo algo más rápido que el de una lectura pausada para que quepa más
  contenido: unas **5.500 palabras** de narración para 30 minutos (≈185 por
  minuto con la voz del vídeo). La medida buena es la del vídeo:
  `generar-video.py T --medir` dice cuántas palabras sobran o faltan.

### Vídeo (`video/escenas.yaml`, formato en `scripts/temario/generar-video.py`)

- **Exactamente 30:00**: el script ajusta el ritmo de toda la narración (sin
  cambiar el tono) para que acabe justo antes de la pantalla final. El ajuste
  debe quedar entre ×0,95 y ×1,05; si no, se recorta o se alarga el guion.
- **Cómo habla el vídeo**: registro formal pero cercano y humano, natural
  y fácil de seguir, como un experto en comunicación ante el tribunal: frases
  de longitud variada (más cortas en lo difícil), conectores que guían
  («fíjense en que…», «la clave está en…», «dicho de otro modo…»),
  preguntas retóricas que anticipan lo que viene, **énfasis** en la idea
  central de cada apartado (repetirla con otras palabras, anunciar que es
  importante) y **pausas** donde ayudan a asimilar: `[pausa]` (0,5 s) o
  `[pausa 800]` (ms, hasta 2 s) dentro de `di:`, tras una pregunta, antes de la idea
  clave o entre las partes de una enumeración. Sin abusar: una o dos por
  paso como mucho. Las marcas no salen en los subtítulos.
- **Pregunta de enganche y cierre (solo en el vídeo; los documentos no
  cambian)**: el vídeo empieza, tras leer el título, con una **pregunta**
  sobre lo que se va a ver, que puede ser muy abierta, incluso
  epistemológica («¿Podemos explicar con una teoría algo tan cotidiano como
  lo que compramos?»), y que hace de enganche. Toda la exposición se orienta
  a ella y la **idea final la responde**, aunque sea de forma abierta y
  dejando pie a otras partes del temario. Cierre natural: la última frase es
  esa respuesta; nunca «muchas gracias» ni fórmulas de despedida.
- Voz: Edge TTS `es-ES-AlvaroNeural` a **+15 %** (o lo que haga falta para que el ajuste quede cerca de ×1,00) mientras no haya voz clonada
  de Víctor (`voz: {motor: xtts, muestra: …}`). Los nombres que la voz lee mal
  van en `scripts/temario/pronunciacion.yaml` (comunes) o en `pronunciacion:`
  del tema.
- Cabecera tipo Beamer en tres filas: tema, apartado y tiempo que queda; los
  bloques (`bloques`, con sus minutos; los ya expuestos con ✓), y los
  apartados de segundo nivel del bloque actual (I.1, I.2…; en la introducción
  y la conclusión, sus cinco partes) como pasos, con un punto por escena. Al
  cambiar de bloque o de apartado se ilumina el paso nuevo y, en la pausa,
  sale el **esquema de la exposición** con la banda avanzando del apartado
  anterior al nuevo. El apartado se saca del `titulo` («I.1. …: …»; lo que va
  tras los dos puntos es el tercer nivel) o de `apartado:`.
- Dos modos, y que se distinga siempre lo que se escribe en la pizarra de lo
  que no:
  - `modo: guion` cuando el opositor no usaría la pizarra (introducción,
    conclusión, partes habladas): en pantalla el guion en viñetas sangradas
    que aparecen según se dicen. En la introducción y en la conclusión,
    `estructura:` con sus cinco bloques y `parte:` para ir pasando de uno a
    otro.
  - `modo: pizarra`: en la pizarra blanca, **solo lo que el opositor
    escribiría a mano**. El cante es *de máximos*: ante la duda, a la
    pizarra, pero **solo gráficos y fórmulas**; texto, casi nunca (quita
    tiempo), solo si aclara mucho (p. ej., una palabra que nombra una zona
    del gráfico). Los títulos de apartado no se escriben: ya están en la
    cabecera. Lo que se dice sin escribirlo va en `guion:` (franja «Se dice»
    de abajo, Palatino sobre papel) y lo didáctico (definición precisa, autor
    y año, idea clave) en `apunte:` (franja salvia).
  - Todo lo de la pizarra (fórmulas, texto y gráficos) sale **trazo a trazo
    a la velocidad de una mano**, sin mano visible.
  - **Coordinación perfecta voz–pizarra**: lo que dibuja un paso se escribe
    *mientras se dice ese paso* y nunca invade el siguiente. Mientras se
    escribe algo, la voz habla **exactamente de eso** (si se escribe la
    ecuación de Slutsky, se está explicando la ecuación de Slutsky; si se
    traza la curva de Engel, se está describiendo la curva de Engel).
  - **La voz no se para nunca**: no se queda callada mientras se escribe ni
    esperando a que acabe el dibujo. Cada paso dura lo que tarda en decirse
    y su dibujo tiene que caber en ese tiempo (la mano puede acelerar hasta
    1,6 veces lo natural; si no basta, el script avisa). Los avisos se
    corrigen **diciendo más sobre lo que se está escribiendo** (leer la
    fórmula mientras se escribe, describir cada curva mientras se traza),
    repartiendo el dibujo en más pasos con su narración o aligerando la
    pizarra. Las únicas pausas son las de énfasis (`[pausa]`, de 2 s como
    máximo) y las de cambio de paso, escena y apartado. El vídeo sigue
    durando **exactamente 30:00**. Comprobación rápida (sin voz):
    `python3 scripts/temario/generar-video.py T --borrador --medir`.
  - **Apoyo visual** (`apoyo:` en un paso): en el cuerpo del tema pueden
    salir gráficos, ecuaciones o texto que **no** están en la pizarra pero
    ayudan al oyente a seguir lo que se cuenta (un gráfico completo de
    referencia, la ecuación entera mientras se escribe solo su parte clave,
    una idea clave en texto). Sale de golpe, en una tarjeta azulada con el
    rótulo «APOYO · no se escribe en la pizarra», en una celda de la
    rejilla: así nunca se confunde con lo que escribe el opositor. Sirve
    también para no cargar la mano: lo que no haría falta escribir en el
    examen va a apoyo.
  - Un paso = una idea que se dice y lo que se escribe para ella. Si un paso
    dibuja varias cosas, la narración las recorre en el mismo orden en que
    se dibujan.
- **Rejilla de la pizarra** (`rejilla:` en la escena o en un paso): de 1 a 3
  columnas, cada una con 1 o 2 filas, con el porcentaje que convenga a cada
  celda ("100", "40|60", "35|65(55/45)", "30|40|30"). Las rayas de
  separación solo cuando ayudan a seguir la exposición (`lineas: true`, p. ej.
  fórmulas a un lado y gráfico al otro con dos apartados distintos); si hay
  una sola cosa, sin rayas. Cambiar de rejilla borra la pizarra. Planifica
  la pizarra como en el examen: qué va en cada celda, cuándo se borra y que
  nunca se llene ni se salga (el script avisa).
- Los gráficos se dibujan con las capas del TikZ (`capa:` creciente, justo
  cuando la narración lo nombra) y el script los traza en el orden del código.
- Imágenes (retratos, portadas) solo de dominio público o con licencia libre,
  citando la fuente.
- El vídeo se guarda en `Vídeos\temario\` de Windows. Víctor lo sube a
  YouTube como **no listado** y anota el enlace en
  `oposicion/temario/videos.json`.

## 8 bis. Ficha de repaso (dos páginas)

- Cada tema tiene una ficha de repaso en **exactamente dos páginas** (A4, tres
  columnas, estética del tema: `tcee-repaso.sty`), para repasar antes del
  examen: esquema del cante con minutos, introducción, ideas clave,
  definiciones, fórmulas y 2-4 gráficos por apartado, conclusión, autores y
  fechas, datos clave, preguntas probables del tribunal y trampas del test.
- Solo resume el tema: nada que no esté en él.
- Letra de 7 puntos o más y la segunda página llena (`construir-repaso.py`
  elige la letra y avisa).
- Se publica como `<ejercicio>/<tema>-repaso.pdf`, con botón en el índice y en
  la página del tema.

## 9. Informe para Víctor (`revision.md`)

Secciones obligatorias, en este orden:

1. **Resumen**: qué se ha hecho, en cinco líneas.
2. **Errores corregidos**: cada error, con dónde estaba, qué decía y qué dice ahora.
3. **Marcas resueltas**: cada marca amarilla o roja, nota o comentario y qué se hizo.
4. **Datos actualizados**: tabla con dato, valor anterior, valor nuevo, fuente,
   URL, fecha de consulta y segunda comprobación.
5. **Contenido añadido**: lo nuevo y de dónde sale.
6. **Coherencia**: cambios por coherencia y contradicciones con otros temas.
7. **Dudas abiertas**: lo que necesita la decisión de Víctor. Si no hay, decirlo.

## 10. Lo que nunca se hace

- Publicar en `main` o fusionar la rama: solo Víctor decide cuándo.
- Tocar otros temas que no sean el que se revisa.
- Subir notas privadas (comentarios, texto oculto) a la fuente pública.
- Inventar datos, citas o referencias. Si no se encuentra la fuente, se dice.
