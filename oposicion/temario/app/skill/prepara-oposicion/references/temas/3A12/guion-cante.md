<!-- Material exclusivo de victorgutierrezmarcos.es y la app Oposición TCEE · DCE. Forma parte de la skill «Prepara con Claude»: solo para la preparación personal del opositor en su propia cuenta de Claude. No se autoriza copiarlo, redistribuirlo ni usarlo en otras plataformas o sistemas de IA (ver LICENCIA.md). -->
*Material exclusivo de victorgutierrezmarcos.es y la app Oposición TCEE · DCE. Forma parte de la skill «Prepara con Claude»: solo para la preparación personal del opositor en su propia cuenta de Claude. No se autoriza copiarlo, redistribuirlo ni usarlo en otras plataformas o sistemas de IA (ver LICENCIA.md).*

# Cante del tema 3.A.12: Teoría de los costes. Dualidad en la empresa

Teoría de los costes. Análisis de dualidad en el ámbito de la empresa. Aplicaciones empíricas.

## Plan de pizarra

> La pizarra se divide en celdas (rejilla de `escenas.yaml`, en porcentaje del ancho y, entre paréntesis, del alto de cada columna). Introducción y conclusión se cantan sin pizarra. Los títulos de apartado no se escriben (están en la cabecera del vídeo). El material de apoyo sale en una tarjeta azulada y no se escribe. Las fórmulas, con las siglas en redonda (PMg, PMe, RMST, CMg, CMe, CVMe) y los vectores con flecha.
>
> **Funciones clave en la esquina.** Las dos `\funcionclave` que se usan después se escriben recuadradas en morado abajo a la izquierda (celda 1b: 24 % del ancho y 45 % del alto, la misma en todas las rejillas desde I.2) y se quedan hasta el final con `conservar: ["1b"]`: la función de costes como problema de mínimo (mín w⃗·z⃗ arriba y, debajo, «s.a.» con F(z⃗) ≥ q y z⃗ ≥ 0⃗, cada restricción en su línea), desde el final de I.2, y el lema de Shephard, zᵢ(w⃗, q) = ∂C(w⃗, q)/∂wᵢ, debajo. El bloque II empieza por la función de costes, la elasticidad del coste respecto a un precio y las participaciones de la translog salen de Shephard, y la ineficiencia X multiplica C(w⃗, q). La función de beneficio no va a la esquina: no se vuelve a ella después del bloque I y ya está en el esquema.
>
> - **I.1**. Una celda (100): `esquema-ingredientes-empresa` (capas 1-6: conjunto tecnológico, F, ingresos y costes; MB y sus soluciones; MC y las suyas). Se borra (cambia la rejilla).
> - **I.2 e I.3**. Rejilla 24(55/45) | 20(55/45) | 56. Columna 3: el **esquema de dualidad de la empresa** (`esquema-dualidad-empresa`), que crece por capas durante todo el bloque (1-3 en la MB, 4-6 en la MC, 7-8 con la MB en dos etapas y las identidades, 9 con la recuperación de la tecnología) y no se borra hasta el final del bloque. 1a-2a: los gráficos que se dibujan y se borran: `mb-un-factor` (capas 1-6), `mc` (1-6), `concavidad-c` (1-6), el gráfico conjunto `mb-mc` (1-8) y `recuperar-isocuanta` (1-6). 1b-2b: las fórmulas de paso (p·PMgᵢ = wᵢ, el apoyo con las propiedades de B, la lagrangiana y las CPO de la MC), que se borran antes de escribir la función de costes; 1b: desde el final de la MC, las dos funciones clave; 2b: la matriz de sustitución. Al acabar el bloque quedan el esquema completo y la esquina.
> - **II.1 y II.2**. Rejilla 24(55/45) | 38 | 38 (cambia la rejilla: se borra todo menos 1b). 1a: ε_C,q = CMg/CMe y, recuadrada, ε_q,λ = 1/ε_C,q; 2: `senda-expansion` (capas 1-6); 3: `costes-largo` (capas 1-9). Con Δw⃗: 2, `demanda-condicionada-w` (capas 1-5); 3, la ecuación de Slutsky de los factores y ε_C,wᵢ = sᵢ. Corto plazo: 1a, el problema a corto (mín arriba y «s.a.» debajo), CMg = w_L/PMg_L y CVMe = w_L/PMe_L, y ε_CV,q; 2-3, apoyo con `corto-largo-senda`, que se borra; 2, `costes-corto` (capas 1-10); 3, apoyo con la tabla de fases. Largo plazo: 2, `envolvente` (capas 1-13); 3, apoyo con el detalle `tangencia-corto-largo` y, debajo, el principio de Le Chatelier-Samuelson.
> - **II.3 y II.4**. Rejilla 24(55/45) | 76 (se conserva 1b). 1a: la Cobb-Douglas de costes en logaritmos; 2: la translog de costes en dos líneas, sus restricciones, las participaciones sᵢ (Shephard) y ε_C,q; en II.4 se borra la columna 2 para el apoyo con `christensen-greene-1970`.
> - **II.5**. Rejilla 24(55/45) | 38 | 38 (se conserva 1b). 2: `farrell` (capas 1-6; las tres eficiencias como cocientes de segmentos salen en el propio gráfico, no se escriben aparte); 3: la frontera estocástica, el problema del DEA (mín arriba y restricciones debajo) y apoyo con la comparación SFA-DEA.
> - **III**. Misma rejilla; al empezar se borra todo menos 1b. III.1: 1a, la subaditividad; 2-3, apoyo con `subaditividad`. III.2, de palabra. III.3: 2-3, `stigler` (capas 1-6); 1a, C^obs = (1 + χ)C(w⃗, q) con χ ≥ 0 debajo, junto a la función de costes de la esquina. III.4: 1a, las economías de alcance y la curva de aprendizaje; 2-3, apoyo con `aprendizaje`. Así queda hasta la conclusión, con las dos funciones clave en la esquina.

## Introducción (2′30″)

### Enganche

¿Cuánto del abaratamiento de la energía solar se debe a la escala, cuánto al aprendizaje y cuánto a los precios de los factores? Entre 2010 y 2025, el coste nivelado de la electricidad de las plantas fotovoltaicas nuevas bajó un 89 por ciento, y cada vez que se ha duplicado la producción mundial de módulos, su precio ha caído en torno a un 27 por ciento.

Detrás está la pregunta de esta exposición: ¿qué nos dicen los costes de una empresa sobre su tecnología, su conducta y su mercado, y cómo se miden? De sus restricciones técnicas, económicas y de mercado, los costes son las económicas: cuál es la combinación posible más barata.

Dos definiciones. El coste económico de un factor es su coste de oportunidad, que con mercados competitivos es su precio de mercado. Y la función de costes, ce de uve doble y cu, da el coste mínimo de producir cu a los precios de los factores: supone eficiencia técnica y económica.

### Relevancia

¿Por qué importa? Es el puente entre la tecnología y el mercado: de ella sale la oferta, y su forma decide cuántas empresas caben. Con la dualidad, la tecnología se estudia con costes y precios, que se observan. Y con ella se regulan las redes y se juzgan los precios predatorios.

### Contextualización

Marshall distingue las economías internas de las externas y los plazos; Wicksell da la U del coste medio, y Viner dibuja en 1931 las curvas de corto y de largo plazo. La dualidad arranca con Hotelling en 1932 y con Shephard en 1953, y la generalizan Uzawa, Diewert y McFadden.

De ella salen las estimaciones de Nerlove y la translog de Christensen, Jorgenson y Lau, y Farrell mide la eficiencia. Y Stigler duda de la U, y Leibenstein, de que se minimicen los costes.

### Problemática

De ahí, las preguntas clave. ¿Cómo elige la empresa la forma más barata de producir, y qué información contiene la función de costes? ¿Qué relación hay entre beneficio, coste y tecnología? ¿Cómo responden a la producción, a los precios y al plazo, y cómo se estiman? Y ¿son en U, y se minimizan?

### Estructura

La exposición sigue tres bloques: la «dualidad» entre maximizar el beneficio y minimizar el coste, de la que sale la función de costes; su análisis, con la estática comparativa, los plazos y las aplicaciones empíricas, que van juntas porque se estima esa misma función, y sus extensiones y críticas.

## I. «Dualidad» entre maximización de beneficios y minimización de costes. Obtención de la función de costes. Análisis de largo plazo (9′)

### I.1. Ingredientes comunes del problema primal y el dual

[Rejilla 100] [Borrar la pizarra] Paso al primer bloque: la «dualidad» entre maximizar el beneficio y minimizar el coste. Adelanto la conclusión: minimizar el coste y elegir después cuánto producir es maximizar el beneficio, y la función de costes contiene la tecnología.

[Pizarra 1: gráfico `esquema-ingredientes-empresa` hasta la capa 1] La eficiencia técnica no basta para decidir: deja todos los puntos de una isocuanta. Hace falta información económica, los precios. Los dos problemas parten de los mismos ingredientes. Primero, el conjunto tecnológico, i griega caligráfica, con sus axiomas.

[Pizarra: gráfico `esquema-ingredientes-empresa` hasta la capa 2] De él sale la función de producción, cu igual a efe de zeta, estrictamente cuasicóncava. Y los precios: los ingresos, pe por cu, y los costes, uve doble por zeta, con la empresa precio-aceptante.

[Pizarra: gráfico `esquema-ingredientes-empresa` hasta la capa 3] En la maximización del beneficio, los tres ingredientes forman el objetivo: pe por efe de zeta menos uve doble por zeta.

[Pizarra: gráfico `esquema-ingredientes-empresa` hasta la capa 4] Su solución, las demandas no condicionadas de factores y la oferta.

[Pizarra: gráfico `esquema-ingredientes-empresa` hasta la capa 6] En la minimización del coste, los papeles cambian: el coste es el objetivo, y la tecnología, la restricción, producir al menos cu. Su solución, las demandas condicionadas de factores.

Los supuestos son comunes, con largo plazo. Solo cambia el papel de cada ingrediente. No son duales en sentido estricto, porque el beneficio incluye los ingresos: de ahí las comillas. Y el beneficio exige efe cóncava; el coste, solo cuasicóncava.

> Apunte: En sentido estricto, el dual de minimizar el coste es maximizar la producción con un coste dado (Segura, 1986)

### I.2. Problemas primal y dual: maximización del beneficio

[Rejilla 24(55/45) | 20(55/45) | 56] [Pizarra 3: gráfico `esquema-dualidad-empresa` hasta la capa 1] Paso al segundo apartado: los dos problemas. A la derecha empiezo el esquema de la dualidad de la empresa, que completaremos en todo el bloque. Arriba a la izquierda, la maximización del beneficio en una etapa: el máximo, eligiendo zeta, de pe por efe de zeta menos uve doble por zeta.

[Pizarra 1a-2a: gráfico `mb-un-factor` hasta la capa 2] Con un solo factor lo vemos en el gráfico: los ejes, el factor y la producción, y la función de producción, cóncava.

[Pizarra: gráfico `mb-un-factor` hasta la capa 3] Las rectas de isobeneficio tienen pendiente uve doble entre pe y cortan el eje vertical en el beneficio entre pe: cuanto más arriba, más beneficio. Esta corta la función de producción: puede ganarse más.

[Pizarra: gráfico `mb-un-factor` hasta la capa 4] La empresa sube hasta la más alta que toca la función de producción: la tangente, de pendiente uve doble entre pe.

[Pizarra 1b-2b: fórmula `p\,\mathrm{PMg}_i=w_i\quad\forall i`] En la tangencia, la productividad marginal iguala el salario real. Lo escribo: pe por la productividad marginal de cada factor igual a su precio. Cada factor se contrata hasta que el valor de su producto marginal iguala su precio.

[Pizarra: gráfico `mb-un-factor` hasta la capa 5] [Pizarra: gráfico `esquema-dualidad-empresa` hasta la capa 2] El punto E da la demanda del factor y la oferta. Con varios factores, las demandas no condicionadas, zeta de pe y uve doble, y la oferta, cu de pe y uve doble, que escribo en el esquema, debajo del problema.

[Pizarra: gráfico `mb-un-factor` hasta la capa 6] Sustituidas en el objetivo, dan el beneficio máximo, que en el gráfico se lee en la ordenada en el origen de la isobeneficio tangente: be entre pe.

[Pizarra: gráfico `esquema-dualidad-empresa` hasta la capa 3] Es la función de beneficio, be de pe y uve doble, que escribo en el esquema debajo de las demandas. Y el camino de vuelta es la flecha morada, el lema de Hotelling: la derivada del beneficio respecto a pe es la oferta, y respecto al precio de cada factor, con signo menos, su demanda no condicionada. Basta derivar.

[Apoyo 1b-2b, no se escribe: fórmula `\begin{array}{l}B(\kappa p,\kappa\vec{w})=\kappa B(p,\vec{w});\ \text{convexa}\\[4pt] \dfrac{\partial q}{\partial p}\geq 0,\quad\dfrac{\partial z_i(p,\vec{w})}{\partial w_i}\leq 0\end{array}`] La función de beneficio es homogénea de grado uno y convexa en los precios: de ahí la ley de la oferta, y que no hay factores Giffen.

Pero exige empresa precio-aceptante y rendimientos decrecientes. Para estudiar los costes de cualquier empresa, aislamos la parte que no depende de los ingresos.

### I.2. Problemas primal y dual: minimización del coste

[Borrar las zonas 1a, 1b, 2a y 2b] [Pizarra: gráfico `esquema-dualidad-empresa` hasta la capa 4] Es la minimización del coste, el problema central de la teoría de los costes. En el esquema, a la derecha, escribo el problema: el mínimo, eligiendo zeta, de uve doble por zeta, sujeto a producir al menos cu. No aparece el precio del producto: vale para el monopolista o el oligopolista, siempre que compren los factores a precios dados.

> Apunte: Shephard (1953): la función de costes y su relación con la tecnología

[Pizarra 1a-2a: gráfico `mc` hasta la capa 2] Gráficamente, trazo los ejes, trabajo y capital, y la isocuanta del nivel exigido, cu, que queda fija; por encima, el conjunto de las combinaciones que la alcanzan.

[Pizarra: gráfico `mc` hasta la capa 3] Las isocostes son rectas paralelas de pendiente menos uve doble ele entre uve doble ka. La más baja no alcanza la producción exigida.

[Pizarra: gráfico `mc` hasta la capa 4] La siguiente corta la isocuanta en zeta prima y zeta dos primas: se produce cu, pero más caro de lo necesario.

[Pizarra: gráfico `mc` hasta la capa 6] El mínimo está en la isocoste más baja que toca la isocuanta: la tangencia, zeta asterisco, donde la relación marginal de sustitución técnica iguala el precio relativo de los factores.

[Pizarra 1b-2b: fórmula `\mathcal{L}=\vec{w}\cdot\vec{z}+\mu\big(q-F(\vec{z})\big)`] Analíticamente, por Kuhn-Tucker, con la lagrangiana: el coste más mu por cu menos efe de zeta.

[Pizarra 1b-2b: fórmula `\frac{w_L}{\mathrm{PMg}_L}=\frac{w_K}{\mathrm{PMg}_K}=\mu=\mathrm{CMg}`] En una solución interior, el precio de cada factor entre su productividad marginal es igual a mu: la misma tangencia que en el beneficio. Y mu, el precio sombra de la producción, es el coste marginal.

[Pizarra: gráfico `esquema-dualidad-empresa` hasta la capa 5] La solución son las demandas condicionadas, zeta de uve doble y cu, condicionadas a producir cu: las análogas de las hicksianas del consumidor, no de las marshallianas. Las escribo en el esquema.

[Borrar las zonas 1b y 2b] [Pizarra: gráfico `esquema-dualidad-empresa` hasta la capa 6] [Pizarra 1b, función clave recuadrada en morado, se queda en la esquina: fórmula `\funcionclave{C(\vect{w},q)=\optim{\min}{\vect{z}}{\vect{w}\cdot\vect{z}}{F(\vect{z})\geq q\\ \vect{z}\geq\vect{0}}}`] Y sustituidas en el objetivo, la función valor: la función de costes, con el lema de Shephard en verde. Es el concepto central de la exposición, así que la recuadro en morado abajo a la izquierda, donde se quedará hasta el final: ce de uve doble y cu es el mínimo, eligiendo zeta, de uve doble por zeta; sujeto a que efe de zeta sea al menos cu, y a que zeta no sea negativo.

[Borrar las zonas 1a, 2a y 2b] [Pizarra 1a-2a: gráfico `concavidad-c` hasta la capa 2] Sus propiedades: es homogénea de grado uno en los precios de los factores, creciente en cu, no decreciente en cada precio y, sobre todo, cóncava. Lo vemos en el gráfico: los ejes, el precio del factor uno y el coste, y la función de costes, cóncava.

[Pizarra: gráfico `concavidad-c` hasta la capa 4] En el precio inicial, si la empresa mantuviera su combinación, el coste crecería en línea recta con el precio: la recta azul. Pero puede sustituir el factor que se encarece, y gasta como mucho eso.

[Pizarra: gráfico `concavidad-c` hasta la capa 6] [Pizarra 1b, función clave recuadrada en morado, se queda en la esquina: fórmula `\funcionclave{z_i(\vect{w},q)=\frac{\partial C(\vect{w},q)}{\partial w_i}}`] La diferencia es el ahorro por sustitución. Y la pendiente de la recta tangente es zeta uno: el lema de Shephard. Lo recuadro debajo de la función de costes: la demanda condicionada de cada factor es la derivada del coste respecto a su precio. Si un precio sube un euro, la combinación apenas cambia y el coste sube zeta i euros.

[Pizarra 2b: fórmula `\begin{array}{c}S_{ij}=\dfrac{\partial^2C}{\partial w_i\,\partial w_j}=\dfrac{\partial z_i(\vec{w},q)}{\partial w_j}\\[6pt] S_{ii}\leq 0\end{array}`] Sus segundas derivadas forman la matriz de sustitución de factores: simétrica, por el teorema de Young, y semidefinida negativa, por la concavidad. Su diagonal es la ley de la demanda condicionada: si sube el precio de un factor, su demanda condicionada nunca aumenta.

En suma, la minimización del coste vale para cualquier empresa que compre sus factores a precios dados. Falta relacionarla con el beneficio y con la tecnología.

> Apunte: Leontief: C lineal en w · Cobb-Douglas: participaciones constantes en el coste

### I.3. «Dualidad» entre maximización del beneficio y minimización del coste

[Borrar las zonas 1a, 2a y 2b] [Pizarra: gráfico `esquema-dualidad-empresa` hasta la capa 7] Paso al tercer apartado: la relación entre los dos problemas. La clave es que el beneficio puede maximizarse en dos etapas: primero se minimiza el coste de cada producción, y después se elige la producción. Lo escribo arriba, en el centro del esquema: el máximo, eligiendo cu, de pe por cu menos la función de costes. Su condición de primer orden, pe igual al coste marginal, da la oferta.

[Pizarra 1a-2a: gráfico `mb-mc` hasta la capa 2] Lo vemos en el gráfico conjunto. A la derecha, los ejes, la producción y los costes unitarios; el coste medio, en U, y el coste marginal, que lo corta en su mínimo.

[Pizarra: gráfico `mb-mc` hasta la capa 5] Con el precio pe, la empresa produce donde el precio iguala al coste marginal, en su tramo creciente: cu asterisco. El rectángulo sombreado es el beneficio máximo.

[Pizarra: gráfico `mb-mc` hasta la capa 8] A la izquierda, la isocuanta de esa producción, cu asterisco, y la isocoste tangente, en zeta asterisco. La combinación que maximiza el beneficio es la de mínimo coste para la producción con pe igual al coste marginal.

[Pizarra: gráfico `esquema-dualidad-empresa` hasta la capa 8] De ahí, las relaciones de «dualidad», que trazo en el esquema con dos flechas. Arriba, entre demandas: zeta de pe y uve doble es igual a zeta de uve doble y cu de pe y uve doble. La no condicionada es la condicionada evaluada en la producción que maximiza el beneficio. Abajo, entre funciones valor: be de pe y uve doble es pe por la oferta menos el coste de producirla. La de beneficio sale de la de costes maximizando en cu, sin volver a minimizar.

Fíjense en la asimetría: la función de costes existe con cualquier rendimiento; la de beneficio, solo con decrecientes.

[Borrar las zonas 1a y 2a] [Pizarra 1a-2a: gráfico `recuperar-isocuanta` hasta la capa 2] ¿Basta conocer los costes para conocer la tecnología? Borro y trazo los ejes de los factores. Un vector de precios da una isocoste mínima, y la tecnología queda en el semiplano de las combinaciones que cuestan al menos ese mínimo.

[Pizarra: gráfico `recuperar-isocuanta` hasta la capa 3] Con otros precios, otra isocoste mínima, más plana, con su semiplano, que también contiene la tecnología.

[Pizarra: gráfico `recuperar-isocuanta` hasta la capa 5] Y con precios relativos cada vez menores, otras dos, todavía más planas, cada una con la flecha de su semiplano.

[Pizarra: gráfico `recuperar-isocuanta` hasta la capa 6] La tecnología está en todos esos semiplanos a la vez, y su intersección es la envolvente de las isocostes, la zona sombreada: la isocuanta, que pasa por los puntos de tangencia, y con ella el conjunto de requerimientos de factores. La tecnología se recupera a partir de los costes.

[Pizarra: gráfico `esquema-dualidad-empresa` hasta la capa 9] Es el teorema de dualidad de Shephard y Uzawa: toda función continua, homogénea de grado uno y cóncava en los precios, y creciente en cu, es la función de costes de alguna tecnología. Y la de beneficio es la función soporte del conjunto de posibilidades de producción. Lo cierro en el esquema con las flechas rojas.

> Apunte: Integrabilidad: demandas homogéneas de grado 0 en w y S simétrica y semidefinida negativa ⇒ existe la tecnología

Recapitulando: basta resolver un problema para obtener todas las funciones de la empresa, y la de costes, la más general, contiene la tecnología. Conocer los costes es conocer la empresa. ¿Cómo cambian con la producción, los precios y el plazo?

> Apunte: Idea clave: minimizar el coste y elegir después p = CMg es maximizar el beneficio

## II. Análisis de los costes: estática comparativa, plazos y aplicaciones empíricas (14′)

### II.1. Estática comparativa: variaciones en la producción

[Rejilla 24(55/45) | 38 | 38; se borra todo menos la celda 1b (funciones clave)] Paso al segundo bloque: el análisis de los costes. Adelanto la conclusión: la demanda condicionada nunca crece con su precio; la forma de los costes refleja la tecnología, según el plazo, y basta estimar la función de costes para medir la escala y la eficiencia.

[Pizarra 2: gráfico `senda-expansion` hasta la capa 2] Borro todo menos las dos funciones de la esquina, y partimos de la de costes con dos factores. Empezamos por la producción, con los precios fijos: los ejes del trabajo y el capital, la isocuanta cu uno y su isocoste tangente en A.

[Pizarra: gráfico `senda-expansion` hasta la capa 4] Al aumentar la producción, nuevas isocuantas, cu dos y cu tres, con isocostes paralelas, tangentes en be y en ce.

[Pizarra: gráfico `senda-expansion` hasta la capa 5] Uniendo los puntos de mínimo coste, la senda de expansión: una isoclina, porque la relación marginal de sustitución técnica no cambia.

[Pizarra: gráfico `senda-expansion` hasta la capa 6] Entre be y ce la senda se vuelve hacia atrás: al producir más se usa menos trabajo. Es un factor inferior, como el trabajo poco cualificado cuando la empresa se automatiza; no todos pueden serlo a la vez. Y si la función es homotética, la senda es un rayo desde el origen.

> Apunte: Curva de Engel del factor: z_L frente a q, creciente si es normal y decreciente si es inferior

[Pizarra 3: gráfico `costes-largo` hasta la capa 2] ¿Y el coste? A la derecha, arriba, los ejes y la curva de costes totales, en ese invertida.

[Pizarra: gráfico `costes-largo` hasta la capa 3] En una producción cu cero, el coste medio, ce entre cu, es la pendiente del rayo que va del origen a la curva.

[Pizarra: gráfico `costes-largo` hasta la capa 4] Y el coste marginal, el de producir una unidad más, es la pendiente de la tangente en ese punto: aquí, menor que el medio.

[Pizarra: gráfico `costes-largo` hasta la capa 5] El mínimo del marginal está en el punto de inflexión, y el del medio, donde el rayo es tangente a la curva.

[Pizarra: gráfico `costes-largo` hasta la capa 8] Debajo, los ejes y el coste marginal, en U, y el coste medio, que el marginal corta en su mínimo: mientras el marginal está por debajo del medio, el medio baja; cuando lo supera, sube.

[Pizarra 1a: fórmula `\varepsilon_{C,q}\equiv\frac{\partial C}{\partial q}\,\frac{q}{C}=\frac{\mathrm{CMg}}{\mathrm{CMe}}`] Lo mide la elasticidad del coste respecto a la producción, que escribo arriba a la izquierda: la derivada del coste respecto a cu, por cu entre ce; es decir, el coste marginal entre el medio.

[Pizarra: gráfico `costes-largo` hasta la capa 9] Si es menor que uno, el coste medio decrece: hay economías de escala; si es mayor, deseconomías. Cuidado con la trampa del test: en los costes, menor que uno son economías.

[Pizarra 1a: fórmula `\boxed{\varepsilon_{q,\lambda}\big(\vec{z}(\vec{w},q)\big)=\frac{1}{\varepsilon_{C,q}}}`] ¿Son lo mismo que los rendimientos a escala? No: los rendimientos son una propiedad de la tecnología, y las economías, de los costes. Pero en la combinación de mínimo coste son inversas, como muestra Hanoch: la elasticidad de escala es uno entre la elasticidad del coste. Y no hace falta homoteticidad.

> Apunte: Hanoch (1975): elasticidad de escala = CMe/CMg en la combinación de mínimo coste, con cualquier tecnología

De ahí la U a largo plazo: rendimientos crecientes a escala baja, por las indivisibilidades, y decrecientes a escala alta, por las dificultades de dirección; no la ley de proporciones variables, que es de corto.

### II.1. Estática comparativa: variaciones en los precios de los factores

[Borrar la zona 2] [Pizarra 2: gráfico `demanda-condicionada-w` hasta la capa 3] Pasamos a los precios de los factores, con la producción fija. Borro la senda y trazo los ejes, la isocuanta de cu, que no se mueve, y la isocoste inicial, tangente en A.

[Pizarra: gráfico `demanda-condicionada-w` hasta la capa 5] Si sube el salario, la isocoste se vuelve más inclinada y la nueva tangencia, be, está más arriba y a la izquierda: menos trabajo y más capital para producir lo mismo. La demanda condicionada nunca crece con su precio, por la concavidad de la función de costes.

[Borrar la zona 3] [Pizarra 3: fórmula `\underbrace{\frac{\partial z_i(p,\vec{w})}{\partial w_j}}_{\text{total}}=\underbrace{\frac{\partial z_i(\vec{w},q)}{\partial w_j}}_{\text{sustitución}}+\underbrace{\frac{\partial z_i(\vec{w},q)}{\partial q}\,\frac{\partial q(p,\vec{w})}{\partial w_j}}_{\text{escala}}`] ¿Y la no condicionada? Se relaciona con la condicionada por una ecuación de tipo Slutsky, que escribo a la derecha, en lugar de los costes. La derivada de la demanda no condicionada del factor i respecto al precio jota, el efecto total, es la derivada de la condicionada, el efecto sustitución, con la producción constante, más la derivada de la condicionada respecto a cu por la de la oferta respecto a uve doble jota: el efecto escala, el cambio de la producción que maximiza el beneficio.

No hay efecto renta, y el efecto escala refuerza al de sustitución: no hay factores Giffen.

> Apunte: Pregunta del tribunal: ¿factores Giffen? No (concavidad de C y convexidad de B); inferiores, sí

[Pizarra 3: fórmula `\varepsilon_{C,w_i}=\frac{w_i\,z_i(\vec{w},q)}{C(\vec{w},q)}=s_i`] ¿Y el coste? Por el lema de Shephard de la esquina, la elasticidad del coste respecto al precio de un factor es su participación en el coste, ese i. Si el trabajo es el 30 por ciento del coste, subir el salario un 10 por ciento lo eleva en torno a un 3.

Y el coste marginal sube si el factor es normal, y baja si es inferior. La producción mueve a la empresa por su senda; los precios, por su isocuanta.

### II.2. Análisis de plazos: corto plazo

[Borrar las zonas 1a, 2 y 3] [Pizarra 1a: fórmula `\optim{\min}{z_L}{w_Lz_L+w_K\overline{z}_K}{F(z_L,\overline{z}_K)\geq q}`] Paso a los plazos. Siguiendo a Marshall, a corto plazo algún factor es fijo, normalmente el capital; a largo, todos son variables. Escribo arriba a la izquierda el problema a corto: el mínimo, eligiendo zeta ele, de los costes variables, uve doble ele por zeta ele, más los fijos, uve doble ka por zeta ka barra, sujeto a producir cu con ese capital.

[Apoyo 2-3, no se escribe: gráfico `corto-largo-senda` completo] No hay elección de proporciones. Por eso el coste a corto nunca es menor que el de largo, y solo coinciden cuando el capital fijo es el óptimo para esa producción, como en el apoyo.

[Borrar las zonas 2 y 3] [Pizarra 2: gráfico `costes-corto` hasta la capa 3] Los costes a corto, en el gráfico. Arriba, los ejes, los costes fijos, una recta horizontal, y los variables, en ese invertida desde el origen.

[Pizarra: gráfico `costes-corto` hasta la capa 4] Los totales son los variables desplazados hacia arriba en los fijos.

[Pizarra 1a: fórmula `\mathrm{CMg}=\frac{w_L}{\mathrm{PMg}_L},\quad\mathrm{CVMe}=\frac{w_L}{\mathrm{PMe}_L}`] ¿Por qué esa forma? Porque el coste marginal es el salario entre la productividad marginal del trabajo, y el variable medio, el salario entre la productividad media: son su imagen invertida.

[Pizarra: gráfico `costes-corto` hasta la capa 6] Abajo, los ejes de los costes unitarios, y el coste fijo medio, siempre decreciente, porque el coste fijo se reparte entre más unidades.

[Pizarra: gráfico `costes-corto` hasta la capa 8] Después, el variable medio, en U, y el medio, que suma los dos y queda por encima.

[Pizarra: gráfico `costes-corto` hasta la capa 9] Y el coste marginal, en U por la ley de proporciones variables, que corta al variable medio y al medio en sus mínimos.

[Pizarra: gráfico `costes-corto` hasta la capa 10] El mínimo del variable medio es el mínimo de explotación: por debajo de ese precio, la empresa competitiva cierra. Y el mínimo del medio, el óptimo de explotación. Estas fases no son economías de escala, que son de largo plazo.

[Pizarra 1a: fórmula `\varepsilon_{\mathrm{CV},q}=\frac{\mathrm{CMg}}{\mathrm{CVMe}}=\frac{1}{\varepsilon_{q,z_L}}`] [Apoyo 3, no se escribe: fórmula `\begin{array}{lcc}\text{Tramo} & \varepsilon_{q,z_L} & \varepsilon_{\mathrm{CV},q}\\ \hline \text{Etapa I (CVMe decreciente)} & >1 & <1\\ \text{Mínimo de explotación} & =1 & =1\\ \text{Etapa II (CVMe creciente)} & (0,1) & >1\\ \text{Capacidad máxima} & =0 & \to\infty\\ \text{Etapa III} & <0 & \text{---}\end{array}`] Las ordena la elasticidad del coste variable, que escribo: el coste marginal entre el variable medio, la inversa de la elasticidad-producto del trabajo. Son las etapas de la producción vistas desde los costes, como resume la tabla de apoyo.

Menor que uno en la etapa uno; mayor que uno en la dos, donde produce la empresa competitiva. La tres nunca está en la función de costes.

### II.2. Análisis de plazos: largo plazo y principio de Le Chatelier-Samuelson

[Borrar las zonas 1a, 2 y 3] [Pizarra 2: gráfico `envolvente` hasta la capa 4] A largo plazo, la empresa elige el tamaño de la planta. Borro y trazo, arriba, los ejes y los costes totales a corto de tres plantas, cada una con su coste fijo.

[Pizarra: gráfico `envolvente` hasta la capa 5] La curva de largo plazo es su envolvente: toca a cada una en la producción para la que esa planta es la óptima.

[Pizarra: gráfico `envolvente` hasta la capa 6] Abajo, lo mismo con los costes medios: los ejes y las tres producciones de tangencia, cu uno, cu dos y cu tres.

[Pizarra: gráfico `envolvente` hasta la capa 9] Y las tres curvas de coste medio a corto plazo, una por planta, cada una en U.

[Pizarra: gráfico `envolvente` hasta la capa 10] Y su envolvente, el coste medio a largo plazo. Fíjense: no pasa por los mínimos de las de corto. A la izquierda de su mínimo toca el tramo decreciente de cada planta, con exceso de capacidad; a la derecha, el creciente. Fue el error del dibujo de Viner.

> Apunte: Viner (1931) trazó la envolvente por los mínimos de las curvas de corto: solo es posible en el mínimo del CMe a largo plazo

[Pizarra: gráfico `envolvente` hasta la capa 12] [Apoyo 3, no se escribe: gráfico `tangencia-corto-largo` completo] El coste marginal a largo plazo y el de corto de la primera planta, que lo corta en la tangencia con más pendiente, como se ve ampliado en el apoyo.

[Pizarra: gráfico `envolvente` hasta la capa 13] Solo en el mínimo del coste medio a largo coinciden los cuatro: los costes medio y marginal, a corto y a largo.

[Pizarra 3: fórmula `\begin{array}{l}\dfrac{\partial z_i^{\mathrm{LP}}}{\partial w_i}\leq\dfrac{\partial z_i^{\mathrm{CP}}}{\partial w_i}\leq 0\\[10pt] \dfrac{\partial q^{\mathrm{LP}}}{\partial p}\geq\dfrac{\partial q^{\mathrm{CP}}}{\partial p}\geq 0\end{array}`] Lo explica el principio de Le Chatelier-Samuelson, que escribo debajo: a largo plazo, las demandas de factores y la oferta son más elásticas que a corto. Cuantas más restricciones tiene la empresa, menos responde a los precios.

> Apunte: Samuelson (1947) traslada el principio del químico Le Chatelier (1884)

Recapitulando: a largo plazo, los costes reflejan los rendimientos a escala; a corto, los del factor variable. Todo es una sola función, que la dualidad permite estimar.

### II.3. Estimación de funciones de costes por dualidad

[Rejilla 24(55/45) | 76; se borra todo menos la celda 1b (funciones clave)] Paso a las aplicaciones empíricas. ¿Por qué estimar costes y no la producción? Porque si los precios y la producción le vienen dados a la empresa, como a una eléctrica, los argumentos de la función de costes son exógenos. Y contiene la tecnología.

> Apunte: Supuestos: la empresa minimiza costes, es precio-aceptante en los factores y su producción es exógena

[Pizarra 1a: fórmula `\ln C=\beta_0+\frac{1}{k}\ln q+\sum_i\frac{\alpha_i}{k}\ln w_i`] Lo más sencillo es la Cobb-Douglas en logaritmos, que escribo arriba a la izquierda: lineal en los parámetros, y el coeficiente del logaritmo de cu es la inversa del grado de rendimientos. Es la que estima Nerlove en 1963. Pero impone una elasticidad de sustitución unitaria.

[Pizarra 2: fórmula `\begin{array}{l}\ln C=\alpha_0+\alpha_q\ln q+\tfrac12\beta_{qq}(\ln q)^2+\sum_i\alpha_i\ln w_i\\[4pt] \qquad+\tfrac12\sum_i\sum_j\beta_{ij}\ln w_i\ln w_j+\sum_i\beta_{iq}\ln w_i\ln q\end{array}`] Por eso se usan formas flexibles, aproximaciones de segundo orden a cualquier función de costes. La más usada es la translogarítmica, que escribo a la derecha: el logaritmo del coste es una constante, más los términos de primer orden en los logaritmos de cu y de los precios, más todos los de segundo orden y los cruzados.

> Apunte: Christensen, Jorgenson y Lau (1973); de costes, Christensen y Greene (1976)

[Pizarra 2: fórmula `\beta_{ij}=\beta_{ji},\quad\sum_i\alpha_i=1,\quad\sum_i\beta_{ij}=\sum_i\beta_{iq}=0`] Debajo, sus restricciones: simetría, beta i jota igual a beta jota i, y homogeneidad de grado uno en los precios: los alfa i suman uno, y las sumas de los beta i jota y de los beta i cu, cero.

[Pizarra 2: fórmula `s_i=\frac{\partial\ln C}{\partial\ln w_i}=\alpha_i+\sum_j\beta_{ij}\ln w_j+\beta_{iq}\ln q`] Y aquí entra Shephard, el de la esquina: derivando respecto al logaritmo de cada precio, las participaciones en el coste son lineales en los parámetros. Se estima el sistema de la función de costes y sus participaciones.

[Pizarra 2: fórmula `\varepsilon_{C,q}=\alpha_q+\beta_{qq}\ln q+\sum_i\beta_{iq}\ln w_i`] Y la elasticidad del coste respecto a la producción, que ahora varía con cu: la translog admite un coste medio en U o en L. De los beta salen además las elasticidades de sustitución de Allen-Uzawa.

Las restricciones de la teoría son contrastables. Berndt y Wood encuentran la energía y el capital complementarios: algo que una Cobb-Douglas no puede dar. Su límite: supone que la empresa minimiza costes.

### II.4. Economías de escala y forma de los costes en los datos

¿Qué dicen los datos? Hay tres métodos: el estadístico, el de ingeniería y el del superviviente de Stigler, que mira qué tamaños ganan cuota.

[Borrar la zona 2] [Apoyo 2, no se escribe: gráfico `christensen-greene-1970` completo] Nerlove encuentra economías de escala que se agotan al crecer las eléctricas. Christensen y Greene, con la translog, ven en 1970 el grueso de la generación ya en el tramo casi plano del coste medio, como muestra el apoyo. La competencia en la generación no exige sacrificar economías de escala.

En las aerolíneas, los costes dependen de la densidad de tráfico, no de la escala. Y la evidencia encuentra costes medios decrecientes hasta una escala mínima eficiente y casi constantes después: costes en L, más que en U.

> Apunte: Caves, Christensen y Tretheway (1984) · Johnston (1960), Walters (1963) · Lieberman (1984): el aprendizaje pesa más

### II.5. Medición de la eficiencia: frontera estocástica frente a análisis envolvente de datos

[Rejilla 24(55/45) | 38 | 38; se borra todo menos la celda 1b (funciones clave)] [Pizarra 2: gráfico `farrell` hasta la capa 2] Paso a la eficiencia. Hasta aquí, la empresa producía sobre su función de costes, que es una frontera. Farrell propone en 1957 medir la distancia a la de las mejores prácticas. Trazo los ejes, los factores por unidad de producto, y la isocuanta unitaria eficiente, ese ese prima.

[Pizarra: gráfico `farrell` hasta la capa 4] Una empresa produce en pe, por encima. Sobre el rayo o pe, cu está en la isocuanta: la eficiencia técnica es o cu entre o pe, la proporción en que podría reducir todos sus factores.

[Pizarra: gráfico `farrell` hasta la capa 5] La isocoste tangente en cu prima corta el rayo en erre: la eficiencia asignativa, o erre entre o cu, mide si la combinación es la adecuada a los precios.

[Pizarra: gráfico `farrell` hasta la capa 6] Y la eficiencia económica, o erre entre o pe, es su producto: el cociente entre el coste mínimo y el observado. Las tres van de cero a uno.

[Pizarra 3: fórmula `\ln C_j^{\mathrm{obs}}=\ln C(\vec{w}_j,q_j)+v_j+u_j,\ \ u_j\geq 0`] La frontera no se conoce y hay que estimarla, con dos familias de métodos. La frontera estocástica, que escribo a la derecha: el logaritmo del coste observado es el de la frontera, más un ruido simétrico, uve, más la ineficiencia, u, siempre positiva.

> Apunte: Aigner, Lovell y Schmidt (1977); Meeusen y van den Broeck (1977)

[Pizarra 3: fórmula `\optim{\min}{e,\,\vect{\tau}}{e}{\sum_j\tau_j\vect{z}_j\leq e\,\vect{z}_0\\ \sum_j\tau_jq_j\geq q_0}`] Y el análisis envolvente de datos, con programación lineal: el mínimo de e, la proporción de sus factores con la que una combinación de las empresas observadas produciría al menos lo mismo.

> Apunte: Charnes, Cooper y Rhodes (1978); con rendimientos variables, Banker, Charnes y Cooper (1984)

[Apoyo 3, no se escribe: texto «SFA: econométrica; separa ruido e ineficiencia; exige forma funcional / DEA: programación lineal; sin forma funcional; todo es ineficiencia»] La frontera estocástica separa el ruido de la ineficiencia, pero exige forma funcional; el análisis envolvente no la necesita, pero atribuye toda desviación a ineficiencia. No siempre ordenan igual a las empresas.

El BCE estima que el banco mediano del euro podría producir lo mismo con el 84 por ciento de sus costes, y el regulador alemán fija así los ingresos de las distribuidoras eléctricas. La ineficiencia se vuelve medible.

> Apunte: BCE (2019): eficiencia en costes ≈ 84 % (2006-2017) · Alemania: DEA y SFA, el valor más favorable (mínimo 60 %)

Recapitulando el bloque: la función de costes responde a la producción, a los precios y al plazo, y la dualidad la hace estimable. Los datos muestran costes en L e ineficiencias persistentes. ¿Qué implica para el mercado?

> Apunte: Idea clave: la dualidad convierte la teoría de los costes en un instrumento empírico

## III. Extensiones y críticas a la teoría de los costes (3′30″)

### III.1. Implicaciones sobre la estructura de mercado

[Borrar la pizarra salvo la celda 1b (funciones clave)] Paso al tercer bloque: extensiones y críticas. Adelanto la conclusión: la forma de los costes condiciona el mercado, y la U y la minimización del coste son cuestiones empíricas.

[Pizarra 1a: fórmula `C\Big(\sum_jq_j\Big)<\sum_jC(q_j)`] La estructura de costes, con el tamaño de la demanda, decide cuántas empresas caben. En competencia perfecta, las deseconomías tienen que llegar pronto. Y hay monopolio natural si la función de costes es subaditiva, que escribo: producirlo todo en una sola empresa cuesta menos que repartirlo.

> Apunte: Baumol (1977): la subaditividad es la definición de monopolio natural

[Apoyo 2-3, no se escribe: gráfico `subaditividad` completo] Con un producto, las economías de escala bastan, pero no son necesarias: en el apoyo, entre cu cero y cu uno una sola empresa es más barata aunque su coste medio ya crezca. Con varios productos, las economías de alcance son necesarias.

### III.2. Economías de escala externas

Las economías vistas son internas. Marshall distingue las externas: el coste de cada empresa baja cuando crece la industria, por el mercado de trabajo, los proveedores y la difusión del conocimiento. No la mueven por su curva: la desplazan hacia abajo.

### III.3. Críticas desde la organización industrial: Stigler y la reserva de capacidad

[Borrar las zonas 1a, 2 y 3] [Pizarra 2-3: gráfico `stigler` hasta la capa 2] Dos críticas atacan los dos supuestos centrales. Primera, la de Stigler en 1939: ¿tiene el coste medio forma de U? Trazo los ejes y la planta A, de coste mínimo, con una U cerrada.

[Pizarra: gráfico `stigler` hasta la capa 3] Si la demanda es incierta, conviene una planta flexible, be: el factor fijo es divisible en la práctica y se ajusta con el variable, y su coste medio es casi plano en un intervalo amplio.

[Pizarra: gráfico `stigler` hasta la capa 4] Su coste marginal es constante e igual al variable medio en ese tramo, y solo sube al agotarlo.

[Pizarra: gráfico `stigler` hasta la capa 6] Con la demanda entre cu mínimo y cu máximo, esa reserva de capacidad da un coste esperado menor aunque su mínimo sea mayor: no hay un tamaño óptimo, sino una horquilla. Y los datos apoyan los costes en L.

### III.3. Críticas desde la organización industrial: la ineficiencia X de Leibenstein

[Pizarra 1a: fórmula `\begin{array}{c}C^{\mathrm{obs}}(\vec{w},q)=(1+\chi)\,C(\vec{w},q)\\[4pt] \chi\geq 0\end{array}`] La segunda va más lejos: ¿producen las empresas sobre su función de costes? Leibenstein, en 1966, sostiene que, sin presión competitiva, no: los contratos fijan el salario, pero no el esfuerzo. Escribo el coste observado: uno más ji por la función de costes de la esquina, con ji decreciente en la competencia.

Con competencia, la amenaza de cierre disciplina el esfuerzo; en el monopolio, la vida tranquila eleva los costes, y la pérdida supera el triángulo de Harberger.

> Apunte: Nickell (1996); Bloom y Van Reenen (2007): peores prácticas de gestión con menos competencia

Stigler replica que es minimización de costes con otros argumentos, como el coste de vigilar el esfuerzo: el debate desemboca en la teoría de la agencia.

### III.4. Otras extensiones

[Borrar la zona 2-3] [Pizarra 1a: fórmula `C(q_1,q_2)<C(q_1,0)+C(0,q_2)`] Por último, otras extensiones. Con varias plantas, el reparto iguala los costes marginales. Con varios productos aparecen las economías de alcance, que escribo: producir juntos cuesta menos que por separado.

[Pizarra 1a: fórmula `c(Q^{\mathrm{ac}})=c_1\,(Q^{\mathrm{ac}})^{-b}`] [Apoyo 2-3, no se escribe: gráfico `aprendizaje` completo] Y las curvas de aprendizaje: el coste unitario baja con la producción acumulada, que escribo: ce de cu acumulada es ce uno por cu acumulada elevada a menos be. Cada duplicación lo multiplica por dos elevado a menos be. En los módulos fotovoltaicos, un 27 por ciento menos por duplicación: be, cerca de cero coma cuarenta y cinco.

> Apunte: Wright (1936): aviones · Fraunhofer ISE (2026): −27 % por duplicación

Recapitulando: la forma de los costes decide la estructura del mercado, y Stigler y Leibenstein cuestionan la U y la minimización, con apoyo en los datos.

## Conclusión (1′)

### Recapitulación

En conclusión, la función de costes resume la elección más barata: es cóncava y homogénea de grado uno en los precios, sus derivadas son las demandas condicionadas y contiene la tecnología. Su forma depende del plazo, y los datos matizan la U.

### Relevancia

Su relevancia: decide cuántas empresas caben en un mercado, y es la referencia de reguladores y autoridades de competencia.

### Extensiones

Abre la puerta a la oferta en cada mercado, a los límites de la empresa, a la regulación y al comercio.

### Opinión

En mi opinión, el supuesto más frágil no es la U, sino la precio-aceptación en los mercados de factores: con monopsonio, las isocostes dejan de ser rectas.

### Idea final

Volvamos a la fotovoltaica: ¿cuánto de su abaratamiento se debe a la escala, al aprendizaje y a los precios de los factores? Ha caído sobre todo por el aprendizaje, que desplaza la curva de costes hacia abajo; pero en 2025 no bajó, porque subió el coste del capital. La función de costes recoge las tres cosas, y la dualidad permite separarlas con datos: esa es su utilidad, que el equilibrio general completará cuando los precios de los factores dejen de ser datos.
