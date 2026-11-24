# Dictamen de práctica: ponerlo, resolverlo y corregirlo

El opositor pide un dictamen de coyuntura para practicar. Le das un cuadernillo como el del examen sobre un país real con nombre ficticio, con datos de fuentes oficiales y preguntas que salen de la situación de ese país. Después, si lo pide, le das la guía de resolución (que dice qué país era) o le corriges su respuesta. Lee antes `references/oposiciones/tcee.md` (formato) y ten a mano el resumen de la guía: `leer_guia_dictamen(«resumen-1D01»)`.

Sin el conector no hay banco de países: dilo en una línea y sigue con el apartado «Datos fuera del banco».

## 1. Configuración: por defecto, sin preguntar

No hagas preguntas antes de empezar. Si el opositor no dice nada, se aplica la configuración por defecto de `preparar_dictamen`:

- **Momento:** situación actual. Datos observados hasta el último año del WEO y dos años de previsión.
- **País:** avanzado o emergente, fuera de la UE, al azar. Pasa en `excluir` los países de sus dictámenes anteriores; la lista sale de `leer_dictamenes(revelar: true)`, que llamas sin enseñarle nada.
- **Formato:** 1 h 45 min, 6 preguntas, 6-8 gráficos o tablas y nivel de examen.

Cambia solo lo que pida, en sus palabras:

| Si dice… | Pasa… |
|---|---|
| «Un país en desarrollo», «emergente», «avanzado» | `tipo` |
| «Un exportador de petróleo / de materias primas» | `tipo: materias_primas` |
| «De Latinoamérica», «de Asia», «de África» | `region` |
| «Una crisis», «la crisis asiática», «Grecia 2010» | `episodio` |
| «De 2015» | `anio` |
| «Más corto», «de una hora», «solo tres preguntas» | `duracion`, `preguntas` |
| «Fácil para empezar», «difícil» | `dificultad: basica` o `exigente` |
| Un país concreto | `pais` (sabe cuál es: no hay sorpresa, pero sí práctica) |

Al empezar, enseña la configuración aplicada en **una línea**, sin el país, y di que puede cambiar cualquier cosa. Por ejemplo: «Economía emergente, situación actual (datos hasta 2025 y previsiones a 2027), 6 preguntas, 1 h 45 min. Si quieres otro tipo de país, una región, una crisis histórica o un formato más corto, dímelo.»

## 2. El cuadernillo

Sigue el formato de los cuadernillos del examen y de los simulacros de la web (Narnia, Meridia):

1. **Portada con las instrucciones del examen.** Número de preguntas y tiempo. «El Tribunal valorará la capacidad de síntesis y la capacidad de repartir adecuadamente el tiempo». No se permite calculadora. Sin abreviaturas personales, porque se lee literal.
2. **Enunciado.** «En el cuadro y los gráficos adjuntos se facilita información macroeconómica referida al periodo [primer año]-[último año] (los datos de [años de previsión] son previsiones) sobre un país real al que nos referimos como **[nombre ficticio]**. Atendiendo a dicha información, responda a las siguientes preguntas:».
3. **Las preguntas.** Usa la cantidad configurada y pon en negrita el concepto central de cada una. Reglas en el apartado 3.
4. **Las tablas.** Van agrupadas como las da `preparar_dictamen` y en ese orden:
   - producción, demanda y oferta;
   - mercado de trabajo;
   - comercio exterior, protección comercial, competitividad y tipo de cambio, balanza de pagos, posición exterior;
   - ahorro e inversión;
   - sector público (ingresos y gastos, saldos, deuda);
   - precios, tipos de interés y dinero, sistema financiero;
   - pro memoria: indicadores sociales y demografía.

   Cada tabla lleva su unidad en cada fila y las columnas de previsión marcadas. Omite las filas vacías o casi vacías, y las que no sirvan para ninguna pregunta si el cuadro pasa de unas 60 filas. Si un dato hace falta para una pregunta y falta en el banco, búscalo como dice el apartado 5. No rellenes huecos inventando.
5. **Los gráficos.** Entre 6 y 8, numerados (Gráfico 1, 2…), dibujados con código a partir del cuadro o de datos de fuentes oficiales, con `scripts/grafico.py` y las reglas de `references/graficos-y-formulas.md`. Cada uno lleva título, unidad y fuente genérica («FMI», «Banco Mundial», «Banco central nacional»), sin el nombre del país. Elige los que hacen falta para contestar las preguntas. Por ejemplo:
   - contribuciones de la demanda al crecimiento;
   - inflación frente al objetivo del banco central;
   - saldo corriente y su financiación;
   - ahorro frente a inversión;
   - deuda pública con su dinámica;
   - crédito al sector privado;
   - tipo de cambio efectivo real frente a la relación real de intercambio.

   **Gráficos del artículo IV del FMI.** Puedes usar los del último artículo IV del país (enlace en `oculto.articuloIV`) y de sus *Selected Issues*. Son los que suelen poner los simulacros: inflación y tipo de cambio, instrumento de política monetaria, descomposición de la deuda, curva de tipos, informalidad, productividad.
   - Nunca copies la imagen: delata el país por el estilo, la moneda, los nombres o las notas.
   - Saca los datos (tablas del informe, cifras del texto, los ejes del gráfico) y **redibújalo** con el estilo del cuadernillo, anonimizado (apartado 4).
   - Si solo puedes aproximar los valores leyendo el gráfico, dilo en la guía de resolución, no en el cuadernillo.
   - Si tu entorno no puede leer el artículo IV, quédate con los gráficos del cuadro.
6. **Entrega.**
   - El cuadernillo va en PDF con la plantilla de la oposición (`references/documentos-y-graficos.md`). Si no puedes ejecutar código, en Markdown con las tablas y los gráficos descritos en una línea cada uno.
   - Al final del cuadernillo: «NO DÉ LA VUELTA A LAS HOJAS HASTA QUE LO INDIQUE EL TRIBUNAL».
   - Ofrece guardarlo en su cuenta con `guardar_dictamen`. Al crearlo, pasa `pais` con el país real y el año T, para corregirlo después, aunque el opositor no lo vea.
   - Dile que lo haga con el tiempo del examen y sin calculadora, y que después te mande su respuesta (texto, foto o PDF) o te pida la guía.

## 3. Las preguntas

- **Salen del país, no de una plantilla.** Lee el cuadro y las `senales` que devuelve `preparar_dictamen`. Haz tu propio diagnóstico antes de escribir ninguna pregunta: fase del ciclo, desequilibrios, política económica. La pregunta del reto principal va sobre el desequilibrio que más pesa (por ejemplo, la deuda externa a corto plazo con reservas bajas, o la inflación con el tipo de cambio).
- **Cubren las áreas de la guía 1D01.** Siguen este orden:
  1. perfil cíclico, con demanda y oferta;
  2. mercado de trabajo o mercados de factores;
  3. competitividad y sector exterior;
  4. política monetaria y sistema financiero;
  5. política fiscal y sostenibilidad de la deuda;
  6. vulnerabilidades, riesgos y recomendaciones.

  Con menos preguntas se juntan áreas; con más, se desdobla la del reto principal.
- **Como en el examen.** Cada pregunta tiene dos a cuatro subpreguntas: «Analice brevemente…», «Examine…», «Evalúe…», «¿Considera que…?», «¿Qué políticas recomendaría…?». Al menos una pide un dato concreto o un cálculo sencillo que se haga sin calculadora (una tasa, una contribución, una diferencia entre dos años), y alguna pide una cuestión conceptual ligada al país (media simple frente a ponderada de los aranceles, regla de Taylor, r − g, enfermedad holandesa…).
- **Dificultad.**
  - *Básica:* datos que cuentan una historia clara y preguntas guiadas.
  - *De examen:* como Meridia.
  - *Exigente:* señales cruzadas (crecimiento alto con desequilibrios que se acumulan, inflación que baja por una apreciación que resta competitividad) y una pregunta que exige elegir entre objetivos.
- **Sin pistas del país.** No uses palabras que lo delaten (nombres de instituciones, del banco central, de la moneda, de socios, de regiones), ni hechos que solo encajen con él.

## 4. Anonimización

`preparar_dictamen` ya separa lo que delata el país en el bloque `oculto`: país, moneda, región, PIB en dólares, población, nivel del tipo de cambio y factor PPA.

- **Nada de ese bloque va al cuadernillo ni a la conversación** antes de la guía. Si hace falta tamaño o nivel, usa ratios (% del PIB, por habitante en PPA redondeado) o índices.
- **Moneda:** «unidad monetaria local (UML)». **Vecinos y socios:** «principal socio comercial», «economía avanzada vecina», «país exportador de petróleo de la región».
- **Años:**
  - En la situación actual van reales, como en el examen.
  - En un episodio, `preparar_dictamen` los da como T−7 … T: mantenlos así en el cuadernillo y en las preguntas, sin fechas, sin acontecimientos datados y sin nombrar la crisis.
- **Antes de entregar, haz la prueba del tribunal:** ¿un opositor medio adivinaría el país con lo que hay? Si una serie lo delata (una inflación de tres cifras en un año concreto, un precio del petróleo con nombre), quita la etiqueta, pasa la serie a índice o cambia el gráfico. El opositor no tiene que adivinar el país (en el examen no se hace), pero el ejercicio pierde valor si lo sabe.

## 5. Datos fuera del banco

Cuando `preparar_dictamen` devuelve `fueraDelBanco`, o hace falta una serie que el banco no tiene:

1. **Solo fuentes oficiales**, las de `fuentesOficiales`: FMI (WEO, artículo IV, IFS), Banco Mundial, OCDE, Eurostat, BCE, BPI, el banco central y el instituto de estadística del país, UNCTAD y OMC. Nada de prensa, blogs, Wikipedia ni agregadores.
2. **Cita cada serie** (fuente, tabla o código, edición y fecha de consulta) en la guía de resolución, no en el cuadernillo, donde solo va «Fuente: FMI», «Banco Mundial»…
3. **No inventes ni completes ninguna cifra.** Una casilla sin dato oficial se queda vacía, como en el examen.
4. **Si no puedes buscar en la web**, dilo en una línea y ofrece un país o episodio del banco (`disponibles`).
5. **Calcula con código** lo derivado (contribuciones, tipo real, variaciones) y comprueba que cuadra (ahorro − inversión ≈ saldo corriente; saldo primario y deuda coherentes).

## 6. La guía de resolución

Solo cuando la pida. Si lo tienes guardado, léelo con `leer_dictamenes(id, revelar: true)`. Sigue el método del anexo D de la guía (`leer_guia_dictamen(«guia-1D01», seccion: «D»)`):

1. **Diagnóstico global en un párrafo:** la frase que encadena todo, con dos o tres cifras.
2. **Por pregunta:** el tiempo que le da la guía, el esquema (indicador → cálculo → umbral → lectura cruzada → recomendación), los cálculos hechos con código y una respuesta modelo con la extensión del examen (unas 18 palabras por minuto; véase `corrector-dictamen.md`).
3. **Al final, «¿Qué país era?»:**
   - el país y los años reales;
   - por qué encaja (dos o tres rasgos);
   - el enlace a su último artículo IV;
   - las fuentes de cada serie;
   - qué gráficos están redibujados del artículo IV y si alguno lleva valores aproximados.

Entrégala en PDF y ofrece guardarla con `guardar_dictamen(id, guia)`.

## 7. Corregir su respuesta

Sigue `corrector-dictamen.md` con el cuadernillo que le pusiste. Léelo con `leer_dictamenes(id)` si está guardado; si no, pídele que te lo pegue.

- El país real no cambia la corrección: se corrige con los datos del cuadernillo.
- El país se revela al final del informe, si aún no se lo has dicho.
- Ofrece guardar la nota y el informe con `guardar_dictamen(id, respuesta, informe, nota, minutos)`. Así sale su evolución en «cómo voy»: `leer_dictamenes()` da la lista con las notas.

## Criterio

- Un cuadernillo vale lo que valen sus preguntas: que obliguen a usar los datos, que tengan una respuesta defendible con ellos y que se puedan contestar en el tiempo.
- Prudencia con las previsiones: son del FMI y se dicen como tales («según las previsiones»).
- Si al montar el cuadernillo ves que una serie del banco no cuadra con otra (un saldo que no suma, un salto imposible), no la uses y dilo en la guía.
