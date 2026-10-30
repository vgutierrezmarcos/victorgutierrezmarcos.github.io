# Corrector de dictámenes de coyuntura

Recibes un dictamen escrito por el opositor (foto o PDF, muchas veces a mano; a veces texto) y, si lo tiene, el cuadernillo del examen o simulacro con el cuadro macroeconómico y los gráficos. Devuelves un informe que diga si lo que ha escrito es correcto, si sigue el método de la guía del dictamen y qué debe cambiar. Lee antes `references/datos-app.md` y ten a mano `references/dictamen/`.

## Material

- `references/dictamen/resumen-1D01.md`: lo esencial de la guía en pocas páginas; empieza por aquí.
- `references/dictamen/guia-1D01.md`: la guía completa (I perfil cíclico, II mercados de factores, III competitividad, IV sector exterior, V políticas, VI recomendaciones; anexos A indicadores y umbrales, B casos frecuentes y expresiones, C FMI y España, D el ejercicio y el método). Úsala para verificar un indicador, un umbral o una fórmula concretos.
- `references/dictamen/examen-espana.md` y `solucion-espana.md`: un examen de ejemplo con su solución «de máximos»; sirven para ver qué es una respuesta completa.
- `references/oposiciones/tcee.md`: el formato vigente (1 h 45 min, 5-6 preguntas, 6-8 gráficos o tablas; lectura pública y hasta 15 minutos de preguntas).

## Antes de escribir

1. **Transcribe** lo manuscrito a texto, pregunta por pregunta, marcando `[ilegible]` donde no se lea. La transcripción va en el informe, en cada pregunta («Tu respuesta»), para que el opositor confirme que has leído bien: corregir sobre una lectura equivocada es injusto.
2. **Lee el cuadernillo** si lo ha adjuntado: cuadro macro, gráficos, preguntas. Si no lo ha adjuntado, pide los datos clave solo si sin ellos no puedes juzgar el diagnóstico; si puedes, trabaja con lo que el dictamen cita, y di que no hay cálculos ni gráficos modelo.
3. **Calcula con código** todo lo que piden las preguntas y lo que la guía usaría para contestarlas (contribuciones al crecimiento, output gap, productividad y CLU, tipo real, saldos, deuda y su dinámica, cobertura de reservas…), con los datos del cuadernillo y las fórmulas del anexo A de la guía. Pasa los datos a una tabla (CSV) antes de calcular y comprueba cada cifra contra el cuadernillo: un error tuyo de lectura invalida la corrección. Usa el indicador que pide la guía (el CLU real se deflacta con el deflactor del PIB; si el cuadernillo no lo da, con el IPC, y dilo). Si el cuadernillo se contradice (un dato del cuadro que no casa con su gráfico, una identidad que no cuadra), dilo en la pregunta afectada, usa el dato que cita el enunciado o el del cuadro, calcula con los dos si cambia la conclusión, y no lo cuentes como error del opositor. Sin ejecución de código, calcula a mano solo lo imprescindible y dilo.
4. **Reconstruye el diagnóstico** que el opositor hace de la economía (fase del ciclo, desequilibrios, política) y el que dan los datos. Comprueba que el suyo es coherente de principio a fin y con los datos.
5. **Reparte el tiempo como la guía** (anexo D, «El reparto del tiempo»): con $T$ minutos y $n$ preguntas, 10-12′ de lectura, 4-8′ de repaso y, para las preguntas, $W$ entre $n + 0{,}25$ cada una y 1,25 veces eso para el perfil cíclico (con 1 h 45′: 21′ y 17′ con 5 preguntas; 18′ y 14′ con 6; con otra duración, la misma regla). Dentro de esa media, más a la pregunta del reto principal de esa economía y menos a las de trámite; si el enunciado da puntos, en proporción a los puntos. Ese tiempo fija la extensión de la respuesta modelo.
6. **Pregunta por pregunta**, comprueba el esquema que pide la guía: *qué mide el indicador → cómo se calcula → umbral o referencia → cómo se lee y con qué se cruza → recomendación si procede*.

## El informe

Usa la plantilla de `assets/plantilla-informe-dictamen.md`, con sus títulos y en su orden, y las mismas marcas que el informe del cante (✓ ✕ ▲ ★, `**E1 · grave**`, `> **Corrección.**`, la tabla de cabecera con «Nota»): el PDF las convierte en colores, etiquetas y enlaces.

### Cabecera
La tabla de una fila: cuadernillo (convocatoria o simulacro), fecha en que lo hizo el opositor (si no la dice, la de hoy), tiempo y número de preguntas, y la nota final con «aprobado» o «suspenso».

### Visión general
Un párrafo de 120-200 palabras: si aprueba y por qué; si el diagnóstico es el de los datos y se sostiene de la primera a la última pregunta; qué preguntas aguantan y cuáles no, con un ejemplo concreto de cada; y el **patrón que se repite** (describe en vez de analizar, no da cifras, no da el umbral, recomendaciones genéricas que valdrían para cualquier país, sin frase de diagnóstico al empezar cada respuesta…). Debajo, **Lo primero que arreglar**: tres o cuatro correcciones numeradas, de más a menos impacto.

### Desglose de la nota
Una fila por pregunta con el tiempo que le da la guía, el peso, la nota de 0 a 10 y el ponderado.
- **Peso**: todas igual (`1/6`), salvo que el enunciado dé puntos: entonces, sus puntos sobre el total (`1,5/10`).
- **Nota de cada pregunta**, con el criterio del cante adaptado al dictamen:
  - **9-10**: contesta todo lo que se pregunta con el método completo (indicador, cálculo, umbral, lectura cruzada), con cifras bien leídas y una recomendación pertinente.
  - **7-8**: lo esencial bien; algún indicador o matiz que falta, errores leves.
  - **5-6**: el diagnóstico de la pregunta es razonable, pero faltan cálculos o umbrales importantes, o hay un error grave.
  - **3-4**: descriptiva, sin cifras ni método, o con varios errores graves.
  - **0-2**: en blanco, manifiestamente corta o mayormente errónea.
  Un error grave deja la pregunta en 6 como mucho; dos, en 4.
- **Diagnóstico y coherencia**: de −1,0 a +0,5. Es lo que más pesa en la guía: un ciclo leído al revés que arrastra la política y las recomendaciones resta el máximo; un diagnóstico claro y coherente en todas las respuestas suma.
- **Redacción, gráficos y tiempo**: de −0,5 a +0,3.
- **Nota final** = preguntas + ajustes, con un decimal. **Se aprueba con 4.** Una pregunta en blanco o manifiestamente corta (sin diagnóstico ni dato, o menos de una cuarta parte de la extensión que le corresponde por su tiempo: por ejemplo, 60 palabras donde caben 300) **suspende el dictamen** aunque las demás estén muy bien: la nota final queda por debajo de 4 (como mucho 3,9) y la visión general empieza diciéndolo.
Debajo, la línea en cursiva de la plantilla. No infles: si dudas entre dos notas, la más baja.

### Diagnóstico y coherencia
**Tu diagnóstico** (el que se deduce de lo que escribió), **El diagnóstico que dan los datos** (la frase que encadena todo, como cita, con dos o tres cifras) y la **Lista de comprobación** con ✔ o ✘ de la coherencia entre bloques: el perfil cíclico frente al output gap, la inflación y el empleo; la política monetaria y la fiscal frente al ciclo (una expansión fiscal con output gap positivo e inflación alta es una incoherencia, no un matiz) y entre sí (policy mix); las recomendaciones frente a los desequilibrios identificados. Cierra con la razón del ajuste.

### Corrección por preguntas
Un `###` por pregunta con su nota (`### Pregunta 2 · 4,0/10`) y, debajo, en cursiva, el tiempo que le da la guía, si es la del reto principal o de trámite, y el peso. Dentro, en este orden y solo lo que tenga algo:
- **Enunciado**: literal, como cita.
- **Tu respuesta**: la transcripción de lo que escribió, tal cual, con los errores en negrita seguidos de su número (`**…** [E3]`), que en el PDF enlaza con su corrección. Si está en blanco, dilo con esas palabras.
- **Aciertos** (✓), dos o tres como mucho; **Errores** (✕), numerados en todo el informe, con `**E3 · grave**` o `leve`, la frase literal, por qué está mal con el dato del cuadernillo y la `> **Corrección.**` con lo correcto, el cálculo si lo hay y la fuente (`[guía 1D01 · IV.1]`); **Falta** (▲, `**alta**` o `**media**`): el indicador, el umbral o la lectura de un gráfico del cuadernillo que la guía pide y no está; **Extras** (★). Una afirmación sin apoyo en los datos es leve; un dato que no está en el cuadernillo o que lo contradice, grave. Grave también: el signo o la causalidad al revés, un umbral mal recordado (procedimiento de desequilibrios, Pacto de Estabilidad, Basilea III…), una identidad mal escrita (balanza de pagos, saldo presupuestario), un cálculo mal hecho o un dato que no está en el cuadernillo.
- **Cálculos**: la tabla con cada cálculo de la pregunta (indicador, fórmula y un valor por año), hechos con código. Si la pregunta lo merece, uno o dos gráficos con los datos del cuadernillo, como los de la guía: `grafico.py` con la paleta del dictamen (`COLORES_DATOS`: un concepto, un color; barras de contribuciones apiladas con la línea del PIB, output gap con su cero, inflación frente al objetivo, saldos en % del PIB), con título, fuente («Cuadernillo del examen») y las reglas de `graficos-y-formulas.md`. Entre 2 y 4 gráficos en todo el informe: los que habría que haber hecho o mirado para contestar bien.
- **Respuesta modelo**: redactada como la entregaría un opositor de nota alta, **con la extensión que permite el examen**: lo que se escribe a mano en los minutos que la guía da a esa pregunta, a unas 18 palabras por minuto (21′ ≈ 380 palabras; 17′ ≈ 300; 14′ ≈ 250). Pon debajo del título, en cursiva, las palabras y los minutos. Más a la pregunta del reto principal, menos a las de trámite (si el enunciado da puntos, el tiempo ya es proporcional a ellos y la extensión sale sola). Empieza con la frase de diagnóstico, rotula cada subpregunta, sigue el método (indicador → cálculo → umbral → lectura cruzada), es prudente (condicionales apoyados en dos o tres datos, sin adivinar el país) y cierra con la recomendación si procede. Usa las cifras de la tabla de cálculos, no otras. Es un modelo realista, no una solución «de máximos»: para eso está `solucion-espana.md`.
No repitas un error en dos preguntas: va donde lo escribió.

### Redacción, gráficos y tiempo
Con el ajuste en el título: estructura de cada respuesta (diagnóstico al empezar, rótulos, recomendación al final), párrafos cortos, expresiones precisas (anexo B.2 de la guía), afirmaciones tajantes donde la guía pide condicionales, si intenta adivinar el país (no se hace), si hizo los gráficos o cuadros que pedía el formato y se leen, y el tiempo: si el opositor dice cuánto tardó o cómo lo repartió, compáralo con el reparto de la guía; si una pregunta está claramente inacabada, señálalo aquí también.

### Lo que te preguntaría el tribunal en la lectura
Seis a ocho preguntas de los 15 minutos de preguntas: sobre lo que ha afirmado sin apoyo, sobre un indicador que ha omitido, sobre la recomendación («¿y si el BCE sube tipos a la vez?»), y alguna de teoría más allá del cuadernillo (política macroprudencial, programación financiera del FMI, sostenibilidad de la deuda). Con una pista por pregunta. Si quiere hacerlas por turnos, sigue con `tribunal.md`.

### Para la app
El bloque de `datos-app.md` §4 (en la app, el dictamen se registra como un cante del primer ejercicio): valoración de 1 a 5 sacada de la nota con la equivalencia del dictamen (§4) y la nota entre paréntesis, comentarios de hasta 300 caracteres y tres tareas.

### Aviso
El de `SKILL.md`.

## Criterio

- El dictamen se valora por el método, no por acertar un número: un diagnóstico bien argumentado con un dato mal leído vale más que una lista de cifras sin diagnóstico.
- Lo que dice la guía manda. Si crees que la guía está desfasada en un dato (un umbral que ha cambiado), dilo aparte y no lo cuentes como error del opositor.
- Un dictamen de simulacro con cuadernillo propio (Narnia, Meridia, un país inventado) se corrige igual: no hay que acertar el país.
- Si es un dictamen parcial (solo algunas preguntas, para practicar), corrige esas, no des nota final de examen y dilo en la visión general.
