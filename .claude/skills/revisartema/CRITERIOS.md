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

Todos los formatos (PDF, web, Word, ficha de repaso y vídeo) llevan la
licencia **CC BY-NC-ND 4.0** (© año del tema, Víctor Gutiérrez Marcos). La
ponen las plantillas (`tcee.sty`, `tcee-repaso.sty`, `plantilla-tema.html`) y
los scripts (`construir-tema.py`, `generar-video.py`); no hay que escribirla
en cada tema. Ver `LICENSE.md` en la raíz.

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
    Si un bloque no procede, se salta y **las letras siguen seguidas** (a, b,
    c… sin huecos: «a) Idea, b) Modelo, c) Valoración»; el nombre del bloque
    es lo que se memoriza, no la letra; Víctor, 17/10/2026, G06). Si un modelo tiene supuestos,
    desarrollo e implicaciones, **van siempre como bloques distinguidos**
    con su título (i, ii, iii), nunca mezclados en una lista. También la
    unicidad, la estabilidad y cualquier resultado que se cuente como
    modelo llevan esta estructura:
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
    intro 2'30" + cuerpo 26'30" + conclusión 1' = 30'; en la fuente se
    escriben `\minutos{2,5}`, pero **en el texto nunca se escriben minutos
    con decimales** (Víctor, 16/10/2026): siempre `2'30"`, `26'30"`, `1'`
    (el macro ya lo muestra así; en notas y tablas de reparto también, con
    `\tiempo{2,5}`).
    Cada bloque recibe tiempo según su peso real en el título y en el
    examen.
  - **Tres apartados** siempre que se pueda (Víctor, 16/10/2026): I, II y
    III. Si el título pide algo que no está en el original, se integra en
    uno de los tres antes que abrir un cuarto.
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
  cada categoría en su color, el mismo que en los gráficos
  (`\textcolor{tceeverde}` normal/sustitutivos, `tceedorado`
  inferior/complementarios, `tceeazul` ordinario, `tceerojo` Giffen; Víctor,
  13/10/2026). Texto centrado en horizontal y en vertical: columnas
  `>{\centering\arraybackslash}m{…}` y `\multirow{n}{=}[desplazamiento]{\centering …}`,
  con filas de la misma altura (2 líneas con `\newline`).
  construir-tema.py lo pasa también a la web y a Word.
- Las derivaciones que no se cantan (agregaciones de Engel y Cournot,
  homogeneidad, simetría, identidades…) **no se borran**: van a un anexo.
- Enlace a preguntas de test: nunca a quia.com; un único enlace genérico al
  simulador: https://www.victorgutierrezmarcos.es/oposicion/temario/primer-ejercicio/test/simulador.html
- Mantener el estilo esquemático de los temas actuales: viñetas jerárquicas
  (■, –, ○), conceptos clave en **negrita** (`\concepto{}`), autores en
  versalitas (`\autor{}`) con el año de la obra. **Varios niveles de
  sangría** (viñetas de distintos niveles) que hagan el tema fácil de seguir
  y ayuden a la memoria visual (Víctor, 16/10/2026), y **nunca un salto de
  página entre un párrafo y el primero de nivel inferior que lo sigue**
  (lo hace `tcee.sty` y, en Word, «conservar con el siguiente»). Tampoco
  **entre un título y lo que le sigue, aunque sea otro título** (Víctor,
  17/10/2026): si el bloque de títulos no cabe, pasa entero a la página
  siguiente (`tcee.sty`; `verificar-tema.py` da error si un título queda al pie).
- **Funciones centrales del tema en morado y recuadradas** (Víctor,
  16/10/2026) con `\funcionclave{…}`: las que el opositor escribiría en la
  pizarra y probablemente mantendría durante el cante (p. ej., la función de
  costes $C(\vect{w},q)$ y la de beneficio $B(p,\vect{w})$ en el 3.A.12).
  Pocas por tema; no en todos los temas las hay.
- **Problemas de optimización con las restricciones debajo**, cada una en
  su línea (Víctor, 16/10/2026), como en los temas antiguos, para que el
  opositor se acostumbre a ver la función objetivo por un lado y las
  restricciones aparte: `\optim{\max}{\vect{z}}{pF(\vect{z})-\vect{w}\cdot\vect{z}}{F(\vect{z})\geq q\\ \vect{z}\geq\vect{0}}`.
- **Notas al pie del original**: se mantienen las que estaban bien
  desarrolladas (Víctor, 16/10/2026), como notas al pie y no integradas en
  el texto ni borradas: amenizan la lectura, dan curiosidades y material
  para el cante sin ser centrales. Pueden llevar un gráfico pequeño
  (`\graficonota{…}`).
- **Numeración de páginas**: el tema (de la portada a la conclusión) en
  1…N; los anexos en A-1, A-2…; la bibliografía en B-1… La primera página
  dice cuántas páginas tiene cada parte (lo hace `tcee.sty`).
- **Manuales por bloques** (idea de Víctor, 16/10/2026): con las fichas de
  cuatro páginas se harán manuales por bloques del temario; las fichas de
  un mismo bloque tienen que poder unirse sin retoques (mismo estilo,
  notación y orden de secciones).
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
- **Sin nombres de preparadores** en el tema (ni «cantado en clase con…», ni
  nombres de profesores): solo se citan obras. `revision.md` no es público y
  puede llevarlos.
- Cada apartado lleva sus minutos de cante con `\minutos{n}` tras el título.
  La suma debe ser 30.
- No inventar citas textuales: una cita entre comillas debe estar en la fuente
  citada.
- **Comprensión antes que concisión** (Víctor, 17/10/2026): al cerebro le
  vienen bien los espacios en blanco y las ideas muy mascadas y
  estructuradas. Cuando un pasaje es complejo, primero va su
  **interpretación o implicación en palabras sencillas** y después el
  desarrollo, que puede ir en una caja (`anotaciones`, gris) o en una nota
  al pie. Se puede ocupar más espacio si así se entiende mejor.
- **El lector no ha estudiado aún los temas que se citan**: lo que se toma
  de otro tema se cuenta con lo necesario para entenderlo aquí (en el
  cuerpo, en una caja o en una nota), coherente con ese tema, y con los
  **nombres completos** la primera vez («primer teorema fundamental de la
  economía del bienestar (1TFEB)»), no solo las siglas.
- **Nexos entre bloques** (Víctor, 17/10/2026): al empezar cada bloque (y
  cada subapartado cuando ayude) una frase que lo enlace con el anterior,
  del tipo «Una vez estudiado …, pasamos a analizar …».
- **Negrita y cursiva con un patrón fijo** (Víctor, 17/10/2026), para que el
  lector reconozca la estructura y memorice mejor:
  - **negrita** (`\concepto{}`): el término que se define o el concepto
    clave, la primera vez que sale;
  - *cursiva* (`\emph{}`): el **rótulo** con que empieza una viñeta
    («*Idea*:», «*Propiedades*:», «*Interpretación gráfica*:»), los títulos
    de obras y las palabras en otro idioma; y el énfasis puntual, con
    mesura;
  - en una misma lista, **todas las viñetas hermanas siguen el mismo
    patrón**: si una empieza con rótulo en cursiva, todas; si una empieza
    con el concepto en negrita, todas. Nunca una en negrita y la de al lado
    en cursiva para lo mismo.
- **Demostraciones**: terminan con `\findemo` (∎, fin de la demostración).
  Las que se llevan a los anexos se desarrollan **al menos tanto como en el
  tema antiguo**, paso a paso; en el cuerpo queda la intuición, bien
  explicada.
- En las notas al opositor (y en todo el tema), los demás temas se citan
  siempre por su número («[ver tema 3.A.22]»), nunca como «temas vecinos».

### Órdenes de `tcee.sty` para estas reglas (cómo se usan)

Funcionan igual en PDF, web y Word (construir-tema.py y tcee.lua las
convierten); el detalle está en la cabecera de `latex/tcee.sty`.

- `\minutos{2,5}` tras el título de un apartado (entrada decimal, para que
  los scripts sumen; se ve 2′30″). En el texto, los minutos se escriben con
  `\tiempo{2,5}` → 2′30″ («introducción, `\tiempo{2,5}`; I, `\tiempo{11}`
  (I.1, `\tiempo{5,5}`…)», «(unos `\tiempo{3}`)»), nunca «2,5 minutos». En
  `guion-cante.md`, a mano: «## Introducción (2′30″)».
- `\funcionclave{C(\vect{w},q)=…}`: función central en display, morada y
  recuadrada; `\funcionclave[eq:costes]{…}` con número (`\eqref{eq:costes}`).
  Va sola (fuera de `$$…$$`).
- `$$\optim{\max}{\vect{z}}{p\,F(\vect{z})-\vect{w}\cdot\vect{z}}{F(\vect{z})\geq q\\ \vect{z}\geq\vect{0}}$$`:
  la variable bajo «max», el objetivo en la primera línea y «s.a.» con cada
  restricción, separadas por `\\`, en su línea. Dentro de `$$…$$`, `\[…\]`,
  `equation` o `\funcionclave{…}`.
- `\findemo`: ∎ al final de una demostración (a la derecha), siempre fuera
  de las fórmulas (dentro de una, el Word no lo convierte).
- `\footnote{Texto.\graficonota{nombre}}`: gráfico pequeño (0,45 del ancho)
  centrado en la nota; `\graficonota[0.35]{nombre}` con otro ancho.
- Listas: no hace falta nada; `tcee.sty` (y el Word) impiden el salto de
  página entre un párrafo o viñeta y la lista que lo sigue.
- Páginas: basta con `\appendix` antes de los anexos y `\bibliografia` al
  final; la numeración (1…N, A-n, B-n) y la línea de la portada salen solas.
  construir-tema.py y verificar-tema.py dicen las «páginas del tema».

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
     **Toda remisión (a un tema, apartado, anexo, gráfico, tabla o ecuación)
     es un enlace: `\vertema` para temas y `\ref`/`\hyperref` para lo
     interno; lo comprueba verificar-tema.py** (Víctor, 18/10/2026). En la
     práctica: nunca «[ver tema …]», «(II.3)», «apartado~I.2», «bloque~III»
     ni «anexo~B» escritos a mano, sino `\vertema{3.A.12}`,
     `(\ref{sec:…})`, `apartado~\ref{sec:…}`, `bloque~\ref{sec:…}`,
     `anexo~\ref{anexo:…}`. Cada apartado numerado lleva su `\label{sec:…}`
     (en los anexos, `\label{anexo:…}`) justo tras el título. En la ficha de
     repaso, los números de `\bloque` y `\sub` van a mano: la etiqueta va
     dentro del título (`\sub{I.2. Título\label{rep:I.2}}`) y la remisión es
     `\hyperref[rep:I.2]{I.2}`. `\vertema` enlaza en el PDF y en el Word al
     PDF del tema en la web (o a tema-no-disponible.html) y en la web a la
     página del tema si está revisado (si no, a su PDF); la tabla de destinos
     sale de temario.json (`latex/tcee-destinos.tex`, la escriben los scripts).
     Las listas de tiempos del cante («I.1, `\tiempo{3}`») no son remisiones.
- **Estructuras de mercado (3.A.16-3.A.19) con los mismos supuestos**
  (Víctor, 18/10/2026): al caracterizar cada estructura (competencia perfecta,
  monopolio, competencia monopolística, oligopolio), los cuatro temas parten de
  la **misma lista de supuestos**, con el mismo orden y las mismas palabras
  (la del 3.A.16, ficha `competencia-perfecta-equilibrio-parcial`), y cada
  tema **marca de forma visible qué supuesto levanta** (p. ej. el supuesto
  tachado o en color con «se levanta: …», o una tabla con la columna del
  tema resaltada). Facilita memorizar y ver el bloque como un todo.
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
- Las representaciones en tres dimensiones, en la **perspectiva del gráfico 4
  del 3.A.8 del 10/10/2026** (cuasiconcavidad; la que Víctor llama
  «caballera», 14/10/2026): la vista por defecto de pgfplots, acimut 30° y
  elevación 28°. Origen a la izquierda, eje vertical hacia arriba, el primer
  eje de la base (x_1, z_L) hacia la derecha y algo hacia abajo (≈ −15°) y el
  segundo (x_2, z_K) hacia la derecha y hacia arriba, en profundidad
  (≈ +40°). En pgfplots: `x={(1.2cm,-0.33cm)}, y={(0.69cm,0.56cm)},
  z={(0cm,1.22cm)}` (o `view={30}{28}`) y `z buffer=sort` en las superficies.
  **No** el eje de profundidad a 45° con el primer eje horizontal, ni los
  ejes de Jehle y Reny.
- Los gráficos de datos (series) se hacen con pgfplots a partir de
  `datos/*.csv` con el último dato y la fuente en la cabecera del CSV.
- Fotos, logotipos o escaneos que no son gráficos se quedan como imagen. Las
  capturas de tablas se convierten en tablas LaTeX.
- Si un gráfico o una tabla pertenecen a una caja (anotaciones, ejemplo…),
  van dentro de ella (Víctor, 18/10/2026): con `figuracaja` o `tablacaja` de
  `tcee.sty` en lugar de `figure`/`table` (mismo `\caption`, `\label` y
  `\fuente`, misma numeración; en la web y en Word salen dentro de la caja).

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
  contenido: unas **4.700 palabras** de narración para 30 minutos (≈158 por
  minuto, contando pausas y cambios de escena). La medida buena es la del vídeo:
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
- **Refranes y dichos populares** (Víctor, 16/10/2026): además de las
  preguntas, la apertura y el cierre pueden ser un refrán o un dicho
  popular que el tema explica o matiza; la apertura y el cierre tienen que
  quedar hilados (el cierre retoma la pregunta o el refrán). Los enganches
  del documento, mejor con hechos actuales que con datos de hace décadas.
- **Funciones clave en la pizarra**: entre bloque y bloque se borra toda la
  pizarra salvo las `\funcionclave` (y algún gráfico central) a las que se
  va a volver a hacer referencia; se dejan en una esquina de la rejilla.
  En `escenas.yaml` se escriben con el mismo macro que en el tema
  (`formula: '\funcionclave{\optim{\max}{\vect{x}}{U(\vect{x})}{\vect{p}\cdot\vect{x}\leq\overline{W}\\ \vect{x}\geq\vect{0}}}'`:
  morada, recuadrada y con fondo morado pálido; el recuadro se traza al
  final, como a mano) y se mantienen con **`conservar:`** aunque cambie la
  rejilla: `rejilla: "25|75"` + `conservar: [1]` (zonas de la rejilla de
  antes) borra todo menos lo escrito en la columna 1, que se queda donde
  está y pasa a la celda de la rejilla nueva que lo contiene (tiene que
  caber entero en una; si no, aviso). Sin cambiar de rejilla: `borrar: true`
  + `conservar: [1]`. Así cada apartado puede tener su rejilla sin perder la
  esquina. Las fórmulas admiten los macros de `tcee.sty` (`\vect`,
  `\optim`, `\funcionclave`, `\tiempo`, `\autor`, `\concepto`, colores
  `tcee*`); en las franjas y el guion, `→ ⇒ ≫ ℝ ∈ ᵢ ⱼ` salen con una fuente
  de respaldo (si un carácter no lo tiene ninguna, el script avisa).
- **Pregunta de enganche y cierre (en el documento y en el vídeo**;
  Víctor, 16/10/2026: el enganche del tema es esa pregunta o un refrán, y la
  idea final del documento lo retoma y responde): el vídeo empieza, tras leer el título, con una **pregunta**
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
  una sola cosa, sin rayas. Cambiar de rejilla borra la pizarra, salvo las
  zonas de `conservar:` (funciones clave, arriba). Planifica
  la pizarra como en el examen: qué va en cada celda, cuándo se borra y que
  nunca se llene ni se salga (el script avisa).
- **Los gráficos 3D no se dibujan trazo a trazo en la pizarra** (Víctor,
  14/10/2026): nadie dibuja a mano una superficie con malla ni paneles 3D en
  un cante. O van como **apoyo** o, si hacen falta en la pizarra, como
  **boceto a mano** (ejes y pocas líneas: un corte, una isocuanta, un rayo),
  con la estética de los gráficos de líneas de Jehle y Reny del 3.A.11
  antiguo. En el apoyo el gráfico puede **«moverse»**: se muestran estados
  sucesivos (p. ej., la superficie sola, luego el corte de corto plazo, luego
  el rayo, luego el desplazamiento) a medida que la narración los nombra, en
  lugar de enseñarlo todo a la vez.
- **Nunca se escribe dos veces lo mismo** (Víctor, 14/10/2026, 3.A.9): si un
  esquema o gráfico de síntesis recoge lo que se va contando, se empieza a
  construir desde el principio y crece capa a capa con la exposición; cuando
  se habla de un objeto (p. ej., las propiedades de una función de valor),
  ese objeto ya está escrito en la pizarra tal y como sale en el esquema
  final. Nada de escribir algo aparte y luego copiarlo en el esquema.
- **Construir el gráfico final por partes** (Víctor, 13/10/2026, 3.A.9): cuando
  un gráfico conjunto resume varios problemas (p. ej., primal y dual), la
  pizarra cuenta el primero en la mitad izquierda, el segundo en la derecha
  y después las relaciones entre ambos hasta completar el gráfico conjunto.
  Se pueden pintar y borrar gráficos intermedios; las propiedades salen como
  nota de apoyo; **al final la pizarra queda lo más limpia posible**, con el
  gráfico conjunto. Las instrucciones concretas de cada tema están en su
  `revision.md` («Instrucciones para el vídeo»).
- Los gráficos se dibujan con las capas del TikZ (`capa:` creciente, justo
  cuando la narración lo nombra) y el script los traza en el orden del código.
- Imágenes (retratos, portadas) solo de dominio público o con licencia libre,
  citando la fuente.
- El vídeo se guarda en `Vídeos\temario\` de Windows. Víctor lo sube a
  YouTube como **no listado** y anota el enlace en
  `oposicion/temario/videos.json`.

## 8 bis. Ficha de repaso (cuatro páginas)

- **Saltos de columna y de página como en el tema** (Víctor, 18/10/2026):
  ningún título (`\bloque`, `\sub`) queda al pie de una columna o de una
  página, ni separado del título o el párrafo del nivel siguiente; tampoco una
  línea que anuncia con «:» lo que viene (la fórmula va pegada a ella: el
  entorno `formula` se pone **dentro** de la viñeta que la presenta, no
  después de `\end{itemize}`). Lo comprueba `verificar-tema.py` (error
  «Ficha de repaso: título o «:» al pie de la columna…»).
- Cada tema tiene una ficha de repaso en **exactamente cuatro páginas** (A4,
  **dos columnas**, estética del tema: `tcee-repaso.sty`; Víctor, 14/10/2026:
  antes eran dos páginas a tres columnas), para repasar antes del
  examen: esquema del cante con minutos, introducción, ideas clave,
  definiciones, fórmulas y 2-4 gráficos por apartado, conclusión, autores y
  fechas, datos clave, preguntas probables del tribunal y trampas del test.
- Solo resume el tema: nada que no esté en él.
- Letra de 8 puntos o más (mejor 9-10) y la cuarta página llena
  (`construir-repaso.py` elige la letra y avisa). Con más sitio, los gráficos
  van más grandes y legibles y se puede incluir alguno más por apartado.
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

## 9 bis. Buscadores (`seo.json`)

Cada tema lleva `fuentes/<tema>/seo.json`, que `construir-tema.py` pasa a la
página HTML (título de la pestaña, descripción, Google Académico, datos
estructurados y un resumen visible bajo el título). La página tiene que atraer
también a universitarios y a quien aprende economía, sin perder la oposición
(el pie de la página ya enlaza el ejercicio, el temario, el simulador y la app).

```json
{"titulo_seo": "Teoría del consumidor: preferencias y demanda",
 "resumen": "Axiomas de preferencias, función de utilidad, demanda marshalliana, ecuación de Slutsky…",
 "palabras_clave": ["teoría del consumidor", "ecuación de Slutsky", "…"],
 "materia": "Microeconomía"}
```

- **`titulo_seo`**: el concepto primero, como lo buscaría un estudiante
  («Modelo de Solow y crecimiento exógeno»), no el código ni el título oficial
  entero: nadie busca «3.A.43». Unos 40-50 caracteres (detrás se añade
  « | Tema 3.A.43 TCEE»).
- **`resumen`**: 2-3 frases o una enumeración, **160 caracteres como máximo**,
  con los modelos y conceptos del tema. Es la descripción que enseña Google.
- **`palabras_clave`**: 10-18, con los nombres de modelos, autores, teoremas y
  lemas que aparecen de verdad en el tema, y la materia.
- **`materia`**: la asignatura universitaria (Microeconomía, Macroeconomía,
  Economía internacional, Economía financiera, Historia del pensamiento
  económico, Economía de la Unión Europea, Economía española, Hacienda pública…).
- Nunca «TECO» en nada visible (título, resumen); tampoco «DCE».

## 10. Lo que nunca se hace

- Publicar en `main` o fusionar la rama: solo Víctor decide cuándo.
- Tocar otros temas que no sean el que se revisa.
- Subir notas privadas (comentarios, texto oculto) a la fuente pública.
- Inventar datos, citas o referencias. Si no se encuentra la fuente, se dice.
