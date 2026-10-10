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
  - **Se mantiene la estructura del tema original de Víctor** (sus apartados
    y su orden). No se reorganiza según la ficha del tribunal ni se mueve
    contenido a otros temas: se corrige, se completa y se actualiza dentro de
    esa estructura. Si falta un epígrafe del título oficial, se añade donde
    encaje y se anota en el informe.
  - Apartados numerados **I., II., III.** con subapartados **I.1., I.1.1.**
    Cada apartado empieza anunciando su conclusión y termina con una
    recapitulación y el enlace con el siguiente. Los modelos siguen el orden
    idea, supuestos, desarrollo (analítico y gráfico), implicaciones,
    extensiones/evidencia y valoración. Cada concepto importante: definición,
    interpretación analítica e interpretación gráfica.
  - **Conclusión**, con sus bloques: **Recapitulación** (ideas clave, sin
    repetir el tema), **Relevancia**, **Extensiones** (otros enfoques y
    partes del temario, para «lanzar la caña» al tribunal), **Opinión** (si
    procede) e **Idea final** (p. ej., la respuesta a la problemática).
  - Introducción y conclusión, unos 3 minutos cada una en el cante.
- Orden del final del documento: **anexos** (con `\appendix`) y después la
  **bibliografía**. Salto de página (`\clearpage`) tras la conclusión, antes
  de los anexos (no tras la introducción); el de antes de la bibliografía lo
  pone `\bibliografia`.
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
- Referencias a otros temas con `\vertema{3.A.9}` (salen en gris).
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

## 6. Coherencia con el resto del temario

- Los títulos oficiales están en `oposicion/temario/temario.json`. El tema
  debe cubrir **todos** los epígrafes de su título, en ese orden.
- Bloques de temas relacionados en `oposicion/organizacion/estructura_temario.json`.
  Revisar los temas del mismo bloque y los citados con «[ver tema …]»: misma
  notación, mismas definiciones y sin contradicciones.
- Si se detecta una contradicción con **otro** tema, no se cambia el otro tema:
  se anota en `revision.md` («Coherencia») para cuando le toque.

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
- Voz: Edge TTS `es-ES-AlvaroNeural` a **+15 %** (o lo que haga falta para que el ajuste quede cerca de ×1,00) mientras no haya voz clonada
  de Víctor (`voz: {motor: xtts, muestra: …}`). Los nombres que la voz lee mal
  van en `scripts/temario/pronunciacion.yaml` (comunes) o en `pronunciacion:`
  del tema.
- Cabecera tipo Beamer: los bloques de la exposición (`bloques`, con sus
  minutos) y un punto por apartado (cada escena es un apartado o
  subapartado, con `titulo`), el tiempo transcurrido y el que queda.
- Dos modos, y que se distinga siempre lo que es pizarra de lo que es
  didáctico:
  - `modo: guion` cuando el opositor no usaría la pizarra (introducción,
    conclusión, partes habladas): en pantalla el guion en viñetas sangradas
    que aparecen según se dicen. En la introducción y en la conclusión,
    `estructura:` con sus cinco bloques y `parte:` para ir pasando de uno a
    otro.
  - `modo: pizarra` cuando se expone con gráficos y fórmulas: la pantalla es
    solo la pizarra (tres paneles). Hay que **planificar la pizarra** como en
    el examen: qué va en cada panel (p. ej., panel 1 el título del apartado y
    las fórmulas, paneles 2-3 el gráfico), cuándo se borra y que nunca se
    llene (el script avisa). Lo didáctico para el opositor (definición
    precisa, autor y año, idea clave) va en `apunte:`, en la franja de abajo.
- Los gráficos se dibujan con las capas del TikZ (`capa:` creciente, justo
  cuando la narración lo nombra) y el script los traza en el orden del código;
  si un paso tiene demasiado dibujo para su narración, el script avisa y hay
  que repartirlo en más pasos.
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
