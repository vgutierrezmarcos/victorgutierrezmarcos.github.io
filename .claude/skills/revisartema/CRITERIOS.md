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
- Estructura del tema: **Introducción** (enganche, relevancia, contextualización
  y estructura de la exposición), apartados numerados **I., II., III.** con
  subapartados **I.1., I.1.1.**, y **Conclusión** (recapitulación, valoración y
  cierre). Introducción y conclusión, unos 3 minutos cada una en el cante.
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
- **Cómo citar**: cada dato con `\footcite{clave}` a una entrada del
  `.bib` del tema. Para fuentes en línea: autor institucional, título, año,
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
- Cada elemento que en el cante se dibuja después va en `\capa{n}{…}`, en el
  orden en que se dibujaría en la pizarra (el vídeo los muestra en ese orden).
- Los gráficos de datos (series) se hacen con pgfplots a partir de
  `datos/*.csv` con el último dato y la fuente en la cabecera del CSV.
- Fotos, logotipos o escaneos que no son gráficos se quedan como imagen. Las
  capturas de tablas se convierten en tablas LaTeX.

## 8. Guion del cante y vídeo

- `guion-cante.md`: esquema de pizarra (lo que se escribe al empezar) y el
  texto del cante, apartado a apartado, con minutos. Unas **4.000 palabras**
  (≈135 palabras por minuto, 30 minutos).
- Registro: el de un opositor ante el tribunal («Señores miembros del
  tribunal…» solo al principio), claro, sin leer fórmulas largas: se dibujan.
- Vídeo: voz **es-ES-AlvaroNeural** (Edge TTS), velocidad normal. Entre 27 y
  33 minutos. Pizarra blanca con la estética de la web. Se pueden incluir
  imágenes (retratos de autores, portadas) solo si son de dominio público o
  con licencia libre (Wikimedia Commons), citando la fuente en el `pie`.
- El vídeo se guarda en `Vídeos\temario\` de Windows. Víctor lo sube a
  YouTube como **no listado** y anota el enlace en
  `oposicion/temario/videos.json`.

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
