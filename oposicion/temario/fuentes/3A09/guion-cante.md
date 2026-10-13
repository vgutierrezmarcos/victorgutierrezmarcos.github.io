# Cante del tema 3.A.9: Teoría de la demanda del consumidor (II)

Dualidad e integrabilidad de las preferencias. Sistemas de demanda utilizados en estudios empíricos. Medidas de cambio en el bienestar.

> Mismo texto que `video/escenas.yaml`. Entre corchetes, lo que se escribe o se dibuja en la pizarra (los gráficos son los de `graficos/`, dibujados capa a capa mientras se dice lo que dibujan) y el material de apoyo, que se enseña pero no se escribe. Las líneas «Apunte» son la ayuda didáctica de la franja inferior del vídeo, no se dicen. El vídeo empieza leyendo el título del tema y entra directamente en el enganche con una pregunta, que la idea final responde (la pregunta y su respuesta son propias del vídeo).

## Plan de pizarra

> La pizarra se divide en celdas (rejilla de `escenas.yaml`); cambiar de rejilla la borra. Introducción, II.1, el final de II.2, II.3 y conclusión se cantan sin pizarra. Los títulos de apartado no se escriben (están en la cabecera del vídeo). El material de apoyo sale en una tarjeta azulada y no se escribe. Rejilla de 1 a 3 columnas; rayas solo en I.2, donde separan el primal del dual.
>
> - **I.1** (100 %). Una celda: `esquema-ingredientes-dualidad` (capas 1-6), una caja por frase: conjunto de elección y preferencias, utilidad y gasto, primal, marshalliana, dual, hicksiana. Se borra al pasar a I.2.
> - **I.2, primal** (50 | 50, cada columna en filas 52/48, con rayas). Mitad izquierda: arriba, `primal` (capas 1-4: ejes y problema, recta de balance, mapa de indiferencia, tangencia x* y V); abajo, lagrangiana y condiciones de primer orden (Gossen y RMS). Mitad derecha, aún vacía: apoyo con las propiedades de la marshalliana y de la FIU (y Roy).
> - **I.2, dual**. Se borra la mitad derecha (el apoyo). Arriba, `dual` (capas 1-4: ejes y problema, Ū fija, isogastos, tangencia h* y E); abajo, lagrangiana con μ, condiciones de primer orden con μ* = 1/λ* y lema de Shephard. Después se borran las dos filas de abajo y sale el apoyo de los pares duales (1b-2b), con los dos gráficos todavía arriba.
> - **I.3** (34 | 66). Primero, sobre los dos gráficos de I.2, la pregunta del teorema básico; después se borra todo. Izquierda: `primal-dual` (capas 2-7: primal, dual superpuesto, misma cesta y recuadro del teorema básico). Derecha: `esquema-dualidad` (capas 2-13: problemas, teorema básico, marshalliana y FIU, Roy, hicksiana y FG, Shephard, funciones valor inversas, identidades entre demandas, Slutsky e integrabilidad). **Al acabar el bloque I la pizarra solo tiene el gráfico conjunto y el esquema.**
> - **II.2, forma funcional** (50 | 50). Izquierda: Cobb-Douglas, LES y Rotterdam; debajo, apoyo con la translog. Derecha: función de gasto PIGLOG, participaciones del AIDS (en rojo) y sus restricciones. El resto de II.2 y II.3, sin pizarra.
> - **III.1** (55 | 45). Izquierda: las tres condiciones de integrabilidad, la EDP de Frobenius y U(x⁰) como mínimo de V. Derecha: apoyo con `esquema-dualidad` completo (la flecha de la integrabilidad); se borra y sale el apoyo `recuperar-utilidad` (capa 5).
> - **III.2** (58 | 42). Izquierda: identidad entre demandas, derivada, Shephard, ecuación de Slutsky (en rojo) y su versión en elasticidades. Derecha: dos apoyos con la clasificación (precio propio; precio cruzado, neta y bruta).
> - **III.3, problema y excedente** (50 | 50). Izquierda: `bienestar-problema` (capas 2-5). Derecha: `bienestar-delta-ec` (capas 2-4) y, debajo, la fórmula de ΔEC. Se borra.
> - **III.3, VC y VE** (30 | 35 | 35). Columna 1: métrica monetaria, VC y su integral, VE y su integral. Columna 2: `bienestar-vc` (capas 1-5, cestas arriba y demanda abajo). Columna 3: `bienestar-ve` (capas 1-5). Se borra.
> - **III.3, las tres juntas e índices** (42 | 58). Derecha: `bienestar-vc-ve`, construido por partes (capas 4, 7, 11, 15, 16, 17 y 18: problema, ΔEC, VC, VE, ordenación, Laspeyres y Paasche). Izquierda: Willig, L ≤ VC y VE ≤ P; se borra y se dibuja `indice-konus-laspeyres` (capas 2-5). En la recapitulación se borra la izquierda: **al acabar el bloque III solo queda el gráfico conjunto `bienestar-vc-ve`.**

## Introducción (2 min)

### Enganche

¿Se puede medir en euros algo que solo sabemos ordenar? Piensen en las pensiones: cada enero se revalorizan con el IPC, y en 2026 han subido un 2,7 por ciento. ¿Basta para que el pensionista quede igual? No es evidente: cuando los precios suben de forma desigual, el consumidor sustituye lo que se encarece, y lo que importa es cuánto cuesta volver a estar igual de bien.

Y la utilidad es ordinal: no se puede restar. La herramienta que la traduce a euros es la función de gasto, que aparece al dar la vuelta al problema del consumidor y minimizar el gasto necesario para alcanzar una utilidad. Es la dualidad, el centro de esta exposición.

### Relevancia

Su relevancia es triple. Teórica: da rigor y sencillez a la teoría de la demanda. Empírica: con ella se estiman las elasticidades que necesitan la imposición indirecta o los índices de precios. Y normativa: es la base del análisis coste-beneficio y del exceso de gravamen.

### Contextualización

La teoría liga las preferencias, que no se ven, con la demanda, desde cuatro líneas. La dualidad, de Hotelling y Hicks a Shephard y McKenzie. La integrabilidad, que plantea Antonelli en 1886 y resuelven Hurwicz y Uzawa. La medida del bienestar, de Dupuit y Marshall a Hicks y Willig. Y los sistemas de demanda, de Stone en 1954 a Deaton y Muellbauer en 1980.

### Problemática

De ahí, cuatro preguntas. ¿Se llega a la misma decisión al dar la vuelta al problema? ¿Cómo se estiman los sistemas de demanda? ¿Qué demandas proceden de unas preferencias? Y ¿cómo se mide en euros lo que gana o pierde un consumidor cuando cambian los precios?

### Estructura

La exposición sigue tres bloques: el análisis teórico de la dualidad; la estimación de sistemas completos de demanda, y tres aplicaciones: la integrabilidad, la ecuación de Slutsky y la medida del bienestar. Vamos de las herramientas a su estimación y a su uso.

## I. Análisis teórico de la dualidad en la decisión de consumo (10 min)

### I.1. Ingredientes comunes del problema primal y el dual

[Borrar la pizarra] Paso al primer bloque: el análisis teórico de la dualidad. Adelanto la conclusión: maximizar la utilidad con una renta dada y minimizar el gasto para alcanzar una utilidad dada llevan a la misma cesta, y de ahí salen unas relaciones para pasar de unas funciones a otras sin resolver nada más.

[Pizarra 1: gráfico `esquema-ingredientes-dualidad` hasta la capa 1] Los ingredientes son comunes a los dos enfoques. Partimos del conjunto de elección, las cestas de bienes, y de las preferencias sobre él, que permiten compararlas.

[Pizarra: gráfico `esquema-ingredientes-dualidad` hasta la capa 2] Con los axiomas, de la completitud a la convexidad estricta, las preferencias se representan con una utilidad continua, creciente y estrictamente cuasicóncava. A su lado, el gasto: pe por equis, con precios dados.

> Apunte: Debreu: racionalidad y continuidad bastan para una U continua; con insaciabilidad local se gasta toda la renta

[Pizarra: gráfico `esquema-ingredientes-dualidad` hasta la capa 3] Con ellos se plantea el problema primal: la utilidad es el objetivo que se maximiza, y el gasto, la restricción presupuestaria.

[Pizarra: gráfico `esquema-ingredientes-dualidad` hasta la capa 4] Su solución es la demanda ordinaria o marshalliana, que depende de los precios y de la renta.

[Pizarra: gráfico `esquema-ingredientes-dualidad` hasta la capa 5] Ahora damos la vuelta: en el problema dual el gasto pasa a ser el objetivo, que se minimiza, y la utilidad, la restricción: alcanzar al menos un nivel, u barra.

[Pizarra: gráfico `esquema-ingredientes-dualidad` hasta la capa 6] Su solución es la demanda compensada o hicksiana, que depende de los precios y de la utilidad exigida. Los supuestos son los mismos: estático, sin incertidumbre, información perfecta, precio-aceptante. Solo cambia qué es objetivo y qué es restricción.

> Apunte: Mismos ingredientes, papeles cambiados: el objetivo pasa a ser la restricción, y al revés

### I.2. Problemas primal y dual: maximización de la utilidad

[Borrar la pizarra] [Pizarra 1a: gráfico `primal` hasta la capa 1] Paso al segundo apartado: los dos problemas, primero el primal, en la mitad izquierda. Trazo los ejes, con las cantidades de los dos bienes, equis uno y equis dos, y encima escribo el problema: maximizar la utilidad, u de equis, sujeto a que el gasto, pe por equis, no supere la renta.

> Apunte: PMU: el óptimo existe (Weierstrass) y, con U estrictamente cuasicóncava, es único

[Pizarra: gráfico `primal` hasta la capa 2] Dibujo la recta de balance, que corta los ejes en la renta entre cada precio, con pendiente menos pe uno entre pe dos, y debajo, sombreado, el conjunto presupuestario.

[Pizarra: gráfico `primal` hasta la capa 3] Encima, el mapa de indiferencia: u cero, u estrella y u dos, que queda fuera de alcance.

[Pizarra: gráfico `primal` hasta la capa 4] El equilibrio está en la curva más alta que toca el conjunto presupuestario: la tangencia, equis estrella. Sus cantidades son la demanda marshalliana, equis de pe y la renta, y la utilidad que alcanza, u estrella, es la función indirecta de utilidad.

[Pizarra 1b: fórmula `\mathcal{L}=U(\vec{x})+\lambda\big(\overline{W}-\vec{p}\cdot\vec{x}\big)`] Analíticamente se resuelve por Kuhn-Tucker. Escribo la lagrangiana: la utilidad más lambda por la renta menos el gasto. Lambda es el precio sombra de la renta, su utilidad marginal.

[Pizarra 1b: fórmula `\frac{U_i}{p_i}=\lambda\ \ \Rightarrow\ \ RMS_{12}=\frac{U_1}{U_2}=\frac{p_1}{p_2}`] En una solución interior, las condiciones de primer orden dan la segunda ley de Gossen: u sub i entre pe sub i igual a lambda para todos los bienes. Y la relación marginal de sustitución se iguala al cociente de precios.

[Apoyo 2, no se escribe: fórmula `\begin{array}{l}\vec{x}(\vec{p},\overline{W}):\ \text{única, continua, homogénea de grado 0 en }(\vec{p},\overline{W})\\[4pt]\text{Ley de Walras: }\vec{p}\cdot\vec{x}(\vec{p},\overline{W})=\overline{W}\\[10pt]V(\vec{p},\overline{W})=U\big(\vec{x}(\vec{p},\overline{W})\big):\ \text{homogénea de grado 0}\\[4pt]\text{creciente en }\overline{W},\ \text{no creciente en }\vec{p},\ \text{cuasiconvexa}\\[6pt]\text{Identidad de Roy: }x_i=-\dfrac{\partial V/\partial p_i}{\partial V/\partial\overline{W}}\end{array}`] Sus propiedades conviene tenerlas a la vista. La marshalliana es única, continua, homogénea de grado cero, porque no hay ilusión monetaria, y cumple la ley de Walras. La indirecta es homogénea de grado cero, creciente en la renta, no creciente en los precios y cuasiconvexa, y de ella sale la demanda con la identidad de Roy.

> Apunte: Cuasiconvexidad de V: con un presupuesto «promedio» no se alcanza más que con el mejor de los extremos

¿Basta con esto? No: la utilidad indirecta se mide en útiles, que solo ordenan. ¿Y si, con los mismos ingredientes, damos la vuelta al problema? ¿Llegamos al mismo equilibrio?

### I.2. Problemas primal y dual: minimización del gasto

[Borrar 2] [Pizarra 2a: gráfico `dual` hasta la capa 1] Lo vemos en la mitad derecha. Borro, trazo los mismos ejes y escribo el problema dual: minimizar el gasto, pe por hache, sujeto a que la utilidad alcance al menos u barra. Llamo hache a la cesta para no confundir las dos demandas.

[Pizarra: gráfico `dual` hasta la capa 2] Ahora se procede al revés. La curva u barra queda fija, y por encima sombreo las cestas que alcanzan al menos esa utilidad.

[Pizarra: gráfico `dual` hasta la capa 3] Trazo las rectas isogasto, paralelas: la de gasto e uno corta la curva, así que puede gastarse menos; la de e dos no la alcanza. Las desplazo hacia el origen mientras toquen la curva.

[Pizarra: gráfico `dual` hasta la capa 4] El mínimo está en la tangencia, hache estrella: la isogasto más baja que alcanza u barra. Es la demanda hicksiana, y el gasto mínimo, e estrella, es la función de gasto.

[Pizarra 2b: fórmula `\mathcal{L}=\vec{p}\cdot\vec{h}+\mu\big(\overline{U}-U(\vec{h})\big)`] Analíticamente, la lagrangiana es el gasto más mu por u barra menos la utilidad de la cesta. Mu es el coste marginal de la utilidad.

[Pizarra 2b: fórmula `\frac{p_i}{U_i}=\mu\ \ \Rightarrow\ \ RMS_{12}=\frac{p_1}{p_2},\quad\mu^*=\frac{1}{\lambda^*}`] Las condiciones de primer orden dan pe sub i entre u sub i igual a mu: la misma tangencia que en el primal. Y en la cesta común, mu estrella es uno entre lambda estrella: si un euro compra lambda útiles, un útil cuesta uno entre lambda euros.

[Pizarra 2b: fórmula `h_i(\vec{p},\overline{U})=\frac{\partial E(\vec{p},\overline{U})}{\partial p_i}`] La función de gasto es el concepto central: mide la utilidad en euros. Y cumple el lema de Shephard: hache sub i es la derivada del gasto respecto a pe sub i, porque si un precio sube un euro, la cesta apenas cambia y el gasto sube hache sub i euros.

> Apunte: Shephard (1953), McKenzie (1957): las hicksianas se obtienen derivando la función de gasto

[Borrar 1b, 2b] [Apoyo 1b-2b, no se escribe: fórmula `\begin{array}{l|l}\vec{x}\ \text{homogénea de grado 0 en }(\vec{p},\overline{W}) & \vec{h}\ \text{homogénea de grado 0 en }\vec{p}\\[2pt]\vec{p}\cdot\vec{x}=\overline{W}\ \text{(Walras)} & U(\vec{h})=\overline{U}\ \text{(sin exceso de utilidad)}\\[2pt]V\ \text{creciente en }\overline{W},\ \text{no creciente en }\vec{p} & E\ \text{creciente en }\overline{U},\ \text{homogénea de grado 1 en }\vec{p}\\[2pt]V\ \text{cuasiconvexa} & E\ \text{cóncava en }\vec{p}\\[2pt]x_i=-\frac{\partial V/\partial p_i}{\partial V/\partial\overline{W}}\ \text{(Roy)} & h_i=\frac{\partial E}{\partial p_i}\ \text{(Shephard)}\end{array}`] Sus propiedades forman pares duales con las del primal, y las resumo abajo. La hicksiana es homogénea de grado cero solo en los precios; el gasto, de grado uno, creciente en la utilidad y, sobre todo, cóncavo: si el consumidor mantuviera su cesta, el gasto variaría linealmente; como sustituye lo que se encarece, gasta como mucho eso.

De ahí sale la matriz de Slutsky, las segundas derivadas del gasto: simétrica y semidefinida negativa. Su diagonal es no positiva: es la ley de la demanda compensada, y un bien Giffen es imposible en la hicksiana. Pero no se observa: depende de una utilidad que no se ve.

> Apunte: Matriz de Slutsky: segundas derivadas de E(p, Ū) en los precios; simétrica, semidefinida negativa y S·p = 0

### I.3. Relaciones de dualidad

Paso al tercer apartado: las relaciones de dualidad. Fíjense en los dos gráficos: el mismo mapa, la misma pendiente y la misma cesta. ¿Es casualidad? No: es el teorema básico de la dualidad.

[Nueva rejilla: se borra la pizarra] [Pizarra 1: gráfico `primal-dual` hasta la capa 2] Lo veo superponiendo los dos gráficos en uno solo. Borro y, a la izquierda, trazo los ejes y la recta de balance del primal, con su conjunto presupuestario sombreado debajo.

[Pizarra: gráfico `primal-dual` hasta la capa 4] Encima, el mapa de indiferencia: u cero y u dos en gris, y u estrella en azul, que es la que nos interesa. Y marco la tangencia del primal, equis estrella, la demanda marshalliana.

[Pizarra: gráfico `primal-dual` hasta la capa 5] Ahora el dual, en el mismo gráfico: u estrella es su restricción, u barra; las isogastos que no tocan van en gris, y la isogasto tangente coincide con la recta de balance.

[Pizarra: gráfico `primal-dual` hasta la capa 6] La cesta más barata, hache estrella, cae exactamente sobre equis estrella, y al proyectarla sus coordenadas son las mismas: equis uno estrella es hache uno estrella.

[Pizarra: gráfico `primal-dual` hasta la capa 7] Es el teorema básico: si equis estrella resuelve el primal, resuelve el dual con la utilidad que alcanza, y el gasto mínimo es la renta; y al revés. Misma cesta, con la renta igual a e estrella y u barra igual a u estrella.

> Apunte: Teorema básico (MWG, prop. 3.E.1): U continua, insaciabilidad local y precios positivos

[Pizarra 2: gráfico `esquema-dualidad` hasta la capa 2] Las dos demandas son funciones distintas, pero del teorema salen relaciones entre ellas, que resumo en el esquema de dualidad. A la derecha escribo los dos problemas. Arriba a la izquierda, el primal: maximizar la utilidad sujeto a la restricción presupuestaria. Y arriba a la derecha, el dual: minimizar el gasto sujeto a la restricción de utilidad.

[Pizarra: gráfico `esquema-dualidad` hasta la capa 3] Los une, con una flecha doble, el teorema básico de la dualidad: la renta del primal igual al gasto mínimo del dual, y u barra igual a la utilidad máxima. Todo lo demás, dentro de este recuadro, son relaciones de dualidad.

[Pizarra: gráfico `esquema-dualidad` hasta la capa 5] Bajando por la columna del primal: resolviéndolo sale la demanda marshalliana, equis de pe y la renta; y, sustituida en la utilidad, la función indirecta, uve de pe y la renta.

[Pizarra: gráfico `esquema-dualidad` hasta la capa 6] Y de la indirecta se vuelve a la demanda, sin resolver nada, con la identidad de Roy, que escribo a la izquierda: equis sub i es igual a menos la derivada de uve respecto a pe sub i, dividida entre la derivada de uve respecto a la renta. Intuición: subir un precio un euro equivale a quitar al consumidor equis sub i euros de renta.

[Pizarra: gráfico `esquema-dualidad` hasta la capa 8] En la columna del dual, igual: resolviéndolo sale la demanda hicksiana, hache de pe y u barra, y sustituida en el objetivo, la función de gasto, pe por hache estrella.

[Pizarra: gráfico `esquema-dualidad` hasta la capa 9] De la función de gasto se vuelve a la hicksiana con el lema de Shephard: la derivada del gasto respecto al precio, sin signo menos, a diferencia de Roy.

[Pizarra: gráfico `esquema-dualidad` hasta la capa 10] Abajo, entre las funciones valor, dos identidades dicen que son inversas: uve evaluada en el gasto mínimo da u barra, y el gasto evaluado en la utilidad indirecta da la renta. Hallada una de ellas, la otra se obtiene despejando, sin resolver su problema.

> Apunte: Cobb-Douglas: de V = W(α/p₁)^α((1−α)/p₂)^(1−α) se despeja E = Ū(p₁/α)^α(p₂/(1−α))^(1−α)

[Pizarra: gráfico `esquema-dualidad` hasta la capa 11] Y entre las demandas, las dos flechas discontinuas que se cruzan en diagonal. Por la primera, la marshalliana es la hicksiana evaluada en la utilidad indirecta, y por la segunda, la hicksiana es la marshalliana evaluada en el gasto mínimo. Es la extensión natural del teorema básico, de las cestas a las funciones de demanda.

[Pizarra: gráfico `esquema-dualidad` hasta la capa 12] Las dos últimas flechas anuncian el tercer bloque. En el centro, entre las dos demandas, escribo la ecuación de Slutsky, que sale de derivar la identidad entre ellas: el efecto total, la derivada de la marshalliana de i respecto al precio de jota, es igual al efecto sustitución, la derivada de la hicksiana, menos equis sub jota por la derivada de la marshalliana respecto a la renta, que es el efecto renta. La demostraremos en el tercer bloque; aquí basta ver de dónde sale: de la flecha que une las dos demandas.

[Pizarra: gráfico `esquema-dualidad` hasta la capa 13] Y recorrer el esquema al revés, de la demanda a la utilidad, es la integrabilidad. Recapitulando, basta resolver uno de los dos problemas para obtener las cuatro funciones, y la función de gasto mide la utilidad en dinero. Antes de usarla, veamos cómo se estima la caja de la que parte todo: el sistema de demandas.

> Apunte: Idea clave: el mismo problema visto desde dos lados; la función de gasto traduce la utilidad a euros

## II. Desarrollos empíricos: estimación de sistemas completos de ecuaciones de demanda (5 min)

### II.1. Idea (sin pizarra)

Paso al segundo bloque: la estimación de sistemas completos de demanda. Adelanto la conclusión: la dualidad permite elegir una función de gasto flexible, derivar de ella demandas estimables y contrastar la teoría, y el sistema casi ideal de Deaton y Muellbauer es el punto de equilibrio.

Un sistema completo explica a la vez el gasto en todos los bienes, en función de los precios y del gasto total. Se estima para medir elasticidades, contrastar la teoría y valorar el bienestar, y debe ser coherente con la teoría, flexible, agregable y fácil de estimar: cuatro requisitos que tiran en direcciones opuestas.

### II.2. Pasos que sigue la literatura: forma funcional

[Borrar la pizarra] La estimación sigue cinco pasos. El primero es elegir la forma funcional: gracias a la dualidad puede ponerse en la utilidad, en la función indirecta o en la de gasto, y el sistema es coherente con la maximización por construcción.

> Apunte: Cinco pasos: forma funcional, sistema completo, datos, especificación econométrica, estimación y contraste

[Pizarra 1: fórmula `U=\sum_i\alpha_i\ln x_i\ \Rightarrow\ s_i\equiv\frac{p_ix_i}{\overline{W}}=\alpha_i`] El punto de partida es la Cobb-Douglas: con esta utilidad, la participación de cada bien en el gasto es constante, alfa sub i. Es trivial de estimar, pero demasiado rígida: elasticidades-renta unitarias, cruzadas nulas, y sin ley de Engel.

[Pizarra 1: fórmula `p_ix_i=p_i\gamma_i+\alpha_i\Big(\overline{W}-\sum_jp_j\gamma_j\Big)`] Para recoger la ley de Engel, el sistema lineal de gasto de Stone: el gasto en cada bien es pe sub i por gamma sub i más alfa sub i por la renta supernumeraria. El consumidor compra unos mínimos, gamma, y reparte el resto en proporciones fijas.

> Apunte: Stone (1954), con la utilidad de Stone-Geary: mínimos de subsistencia γ

Fue el primer sistema estimado con datos reales, y sus curvas de Engel no pasan por el origen: distingue bienes necesarios y de lujo. Pero es aditivo: no admite bienes inferiores ni complementarios netos, y Deaton rechaza esa aditividad con datos británicos. Hace falta más flexibilidad.

[Pizarra 1: fórmula `\bar{s}_i\,d\ln x_i=b_i\,d\ln Q+\sum_jc_{ij}\,d\ln p_j`] El modelo de Rotterdam, de Barten y Theil, la gana sin partir de una utilidad: escribe la ecuación de Slutsky en diferencias logarítmicas con coeficientes constantes, y la teoría pasa a ser restricciones lineales, como la simetría de los ce sub i jota. Barten, con datos de los Países Bajos, rechaza a menudo la homogeneidad. Y su límite es que es local y no tiene una función de gasto con la que valorar el bienestar.

[Apoyo 1, no se escribe: fórmula `\ln V=\alpha_0+\sum_i\alpha_i\ln\frac{p_i}{\overline{W}}+\frac{1}{2}\sum_i\sum_j\beta_{ij}\ln\frac{p_i}{\overline{W}}\ln\frac{p_j}{\overline{W}}`] La translog de Christensen, Jorgenson y Lau recupera esa función: aproxima en segundo orden una función indirecta cualquiera, y con Roy da las participaciones. Es muy flexible y sirvió para rechazar la aditividad y la homoteticidad con datos de Estados Unidos, pero no es lineal en los parámetros, no agrega bien y la concavidad no está garantizada lejos del punto de aproximación.

[Pizarra 2: fórmula `\ln E(\vec{p},\overline{U})=(1-\overline{U})\ln a(\vec{p})+\overline{U}\ln b(\vec{p})`] Y llegamos al sistema casi ideal, el AIDS de Deaton y Muellbauer, que reúne los cuatro requisitos. Parte de una función de gasto de la clase PIGLOG, compatible con la agregación: su logaritmo pondera, con la utilidad, el coste de subsistencia, a, y el de saciedad, be.

[Pizarra 2: fórmula `s_i=\alpha_i+\sum_j\gamma_{ij}\ln p_j+\beta_i\ln\frac{\overline{W}}{P}`, en rojo] Por Shephard en logaritmos salen las participaciones: alfa sub i, más gamma sub i jota por el logaritmo de cada precio, más beta sub i por el logaritmo del gasto real.

> Apunte: Deaton y Muellbauer (1980): Almost Ideal Demand System

[Pizarra 2: fórmula `\sum_j\gamma_{ij}=0,\ \ \gamma_{ij}=\gamma_{ji};\qquad\beta_i\gtrless0`] Sus restricciones son lineales: homogeneidad, la suma de los gamma es cero, y simetría, gamma sub i jota igual a gamma sub jota i. Si beta es positiva, el bien es de lujo; si es negativa, necesario: la ley de Engel.

Agrega exactamente y, con el índice de Stone, se estima por mínimos cuadrados. Es casi ideal porque la negatividad no está garantizada. Y el QUAIDS de Banks, Blundell y Lewbel añade un término cuadrático, porque algunas curvas de Engel se curvan.

> Apunte: LA-AIDS: con el índice de precios de Stone; QUAIDS (1997): sistema de rango 3

### II.2. Pasos que sigue la literatura: sistema, datos y estimación (sin pizarra)

Los otros pasos, más rápido. El sistema debe ser completo, en participaciones que suman uno, y se agrupan los bienes, con la separabilidad débil y la presupuestación en dos etapas.

Los datos, en España, son los microdatos de la Encuesta de Presupuestos Familiares del INE, con unos 24.000 hogares; en 2025, el gasto medio por hogar fue de 35.101 euros. El problema son los precios, casi iguales para todos: se combinan años y regiones o se usan valores unitarios.

En la especificación se elimina una ecuación y se tratan el gasto endógeno, los gastos nulos y la demografía. Los resultados: elasticidades para simular reformas del IVA, como en España con un AIDS sobre la EPF, y contrastes que, con datos agregados, rechazaron a menudo la homogeneidad.

### II.3. Valoración (sin pizarra)

Valoremos. La dualidad convierte la teoría en un instrumento de medida: sus restricciones pasan a ser hipótesis contrastables, y el AIDS concilia flexibilidad, agregación y sencillez.

Sus límites: la tensión entre flexibilidad y parsimonia; la agregación, porque la teoría es individual y los datos son medias de consumidores distintos, y el marco estático. De ahí la respuesta de Deaton: microdatos y heterogeneidad.

Recapitulando: estimar un sistema de demandas no garantiza que proceda de unas preferencias. Saber cuándo lo hace es la primera aplicación de la dualidad: la integrabilidad.

## III. Aplicaciones de la dualidad (12 min)

### III.1. El problema de la integrabilidad de las preferencias

[Borrar la pizarra] [Apoyo 2, no se escribe: gráfico `esquema-dualidad` hasta la capa 13] Paso al tercer bloque: las aplicaciones de la dualidad. Adelanto la conclusión: una es teórica, la integrabilidad, que recorre el esquema de dualidad al revés, y dos son prácticas: la ecuación de Slutsky y la medida del bienestar en euros.

La pregunta es de Antonelli, en 1886: dado un sistema de demandas observado, ¿qué condiciones debe cumplir para proceder de unas preferencias? Si las cumple, podemos integrarlo y recuperar la utilidad.

> Apunte: Hurwicz y Uzawa (1971); MWG, §3.H; Jehle y Reny, teorema 2.6

[Pizarra 1: fórmula `(1)\ \ \vec{p}\cdot\vec{x}(\vec{p},\overline{W})=\overline{W}`] Una demanda diferenciable procede de una utilidad creciente y cuasicóncava si y solo si cumple tres condiciones. Primera, la ley de Walras: el gasto es igual a la renta.

[Pizarra 1: fórmula `(2)\ \ S_{ij}=\frac{\partial x_i}{\partial p_j}+x_j\frac{\partial x_i}{\partial\overline{W}}=S_{ji}`] Segunda, la simetría de la matriz de Slutsky construida con observables: la derivada de equis sub i respecto a pe sub jota más equis sub jota por su derivada respecto a la renta es igual a ese sub jota i.

[Pizarra 1: fórmula `(3)\ \ S(\vec{p},\overline{W})\ \text{semidefinida negativa}`] Y tercera, la negatividad: esa matriz de Slutsky es semidefinida negativa. Las tres son necesarias, como hemos visto, y el teorema prueba que también son suficientes. Con dos bienes, la simetría es automática.

[Pizarra 1: fórmula `\nabla_{\vec{p}}E(\vec{p},\overline{U})=\vec{x}\big(\vec{p},E(\vec{p},\overline{U})\big)`] ¿Por qué bastan? Primero, por Shephard, el gradiente de la función de gasto desconocida debe ser la demanda evaluada en ese gasto: un sistema de ecuaciones en derivadas parciales que, por el teorema de Frobenius, tiene solución si las derivadas cruzadas coinciden: la simetría.

[Borrar 2] [Pizarra 1: fórmula `U(\vec{x}^0)=\min_{(\vec{p},\overline{W})}V(\vec{p},\overline{W})\ \ \text{s.a.}\ \ \vec{p}\cdot\vec{x}^0\leq\overline{W}`] [Apoyo 2, no se escribe: gráfico `recuperar-utilidad` hasta la capa 5] Segundo, para ser una función de gasto le falta la concavidad, y su hessiana es la matriz de Slutsky: de ahí la negatividad. Tercero, invirtiendo se obtiene la indirecta, y de ella la utilidad: la de una cesta es el mínimo de la utilidad indirecta entre los presupuestos con los que es asequible.

Su relevancia: cierra el círculo, porque las preferencias no añaden nada a tres propiedades contrastables, y permite recuperar la función de gasto para medir el bienestar con exactitud. Y la simetría tiene una lectura económica: la ecuación de Slutsky.

> Apunte: Preferencia revelada: axioma fuerte (Houthakker, 1950); Afriat (1967) con datos finitos

### III.2. La ecuación de Slutsky y la clasificación de los bienes

[Borrar la pizarra] [Pizarra 1: fórmula `h_i(\vec{p},\overline{U})\equiv x_i\big(\vec{p},E(\vec{p},\overline{U})\big)`] Paso a la ecuación de Slutsky, que la dualidad demuestra en dos líneas. Partimos de la identidad entre demandas: la hicksiana del bien i es la marshalliana evaluada en el gasto mínimo.

[Pizarra 1: fórmula `\frac{\partial h_i}{\partial p_j}=\frac{\partial x_i}{\partial p_j}+\frac{\partial x_i}{\partial\overline{W}}\,\frac{\partial E}{\partial p_j}`] Como vale para todos los precios, derivo los dos lados respecto a pe sub jota, con la regla de la cadena a la derecha: la derivada de la marshalliana, más su derivada respecto a la renta por la del gasto.

[Pizarra 1: fórmula `E=\overline{W},\qquad\frac{\partial E}{\partial p_j}=h_j=x_j(\vec{p},\overline{W})`] Uso dos relaciones de dualidad: el gasto mínimo es la renta y, por Shephard, la derivada del gasto es hache sub jota, que coincide con equis sub jota.

[Pizarra 1: fórmula `\underbrace{\frac{\partial x_i}{\partial p_j}}_{\text{total}}=\underbrace{\frac{\partial h_i}{\partial p_j}}_{\text{sustitución}}\underbrace{-\,x_j\frac{\partial x_i}{\partial\overline{W}}}_{\text{renta}}`, en rojo] Despejando, llegamos a la ecuación de Slutsky, que escribo en rojo: el efecto total, la derivada de la marshalliana respecto a pe sub jota, es igual al efecto sustitución, la derivada de la hicksiana, que mantiene la utilidad, menos equis sub jota por la derivada de equis sub i respecto a la renta, que es el efecto renta, debido al cambio del poder adquisitivo. Vale para el precio propio y para los cruzados.

> Apunte: Slutsky (1915), demostrada por dualidad

[Pizarra 1: fórmula `\varepsilon_{x_i,p_j}=\varepsilon^{h}_{i,p_j}-s_j\,\varepsilon_{x_i,\overline{W}}`] En elasticidades, el efecto renta es la participación del bien cuyo precio cambia por la elasticidad-renta: pesa más cuanto más pesa el bien.

Su valor: el efecto sustitución no se observa, y los otros dos, sí, así que la matriz de Slutsky se calcula con datos: simétrica, semidefinida negativa y con ese pe igual a cero, de modo que todo bien tiene al menos un sustitutivo neto.

> Apunte: S·p = 0: todo bien tiene al menos un sustitutivo neto (Hicks)

[Apoyo 2, no se escribe: fórmula `\begin{array}{l}\text{Precio propio: }\ \dfrac{\partial h_i}{\partial p_i}\leq0\\[8pt]\text{normal }(ER<0)\ \Rightarrow\ \text{ordinario}\\[2pt]\text{inferior }(ER>0):\ \text{ordinario si domina ES;}\\ \qquad\text{Giffen si domina ER}\end{array}`] Con ella clasificamos los bienes. Ante su propio precio, el efecto sustitución es no positivo. Un bien normal es siempre ordinario: es la ley de la demanda. Uno inferior es ordinario si domina el efecto sustitución, y Giffen si domina el de renta. Todo Giffen es inferior; no al revés.

[Apoyo 2, no se escribe: fórmula `\begin{array}{l}\text{Neta: signo de }S_{ij}\text{, simétrica}\\[2pt]\text{Bruta: signo de }\partial x_i/\partial p_j\text{, no simétrica}\\[4pt]\text{sustitutivos netos}+i\text{ inferior}\Rightarrow\text{sustitutivos brutos}\\[2pt]\text{complementarios netos}+i\text{ normal}\Rightarrow\text{complementarios brutos}\end{array}`] Ante un precio cruzado, la relación neta es simétrica, como la definieron Hicks y Allen; la bruta no, porque los efectos renta no tienen por qué coincidir. Dos bienes pueden ser sustitutivos netos y complementarios brutos.

Y explica las pendientes: para un bien normal, la marshalliana es más plana que la hicksiana; sin efecto renta, coinciden. Es el puente con el bienestar. Recapitulando: la dualidad demuestra Slutsky, la hace calculable y explica la asimetría de las relaciones brutas.

### III.3. Análisis de bienestar: el problema y el excedente

[Borrar la pizarra] Paso a la última aplicación: el bienestar de un consumidor ante cambios de precios. El decisor público debe guiarse por el bienestar, no por las demandas: salus populi suprema lex esto.

> Apunte: Cicerón, De legibus, III, 8: «el bienestar del pueblo sea la ley suprema»

[Pizarra 1: gráfico `bienestar-problema` hasta la capa 2] El problema, en el plano de los dos bienes: trazo los ejes, la recta de balance inicial, a los precios pe cero, y la curva u cero, tangente en la cesta equis cero.

[Pizarra: gráfico `bienestar-problema` hasta la capa 3] Baja el precio del bien uno: la recta gira hacia fuera y el consumidor gana el triángulo sombreado.

[Pizarra: gráfico `bienestar-problema` hasta la capa 4] El nuevo óptimo es equis uno, en una curva más alta, u uno.

[Pizarra: gráfico `bienestar-problema` hasta la capa 5] Ha mejorado, pero ¿cuánto? Restar las utilidades no tiene sentido, porque la utilidad es ordinal. Hace falta una medida en euros.

[Pizarra 2: gráfico `bienestar-delta-ec` hasta la capa 2] La clásica es la variación del excedente del consumidor, de Dupuit y Marshall. A la derecha, con el precio en vertical, trazo la demanda marshalliana del bien uno.

> Apunte: Dupuit (1844), Marshall (1890): el área bajo la demanda marshalliana y sobre el precio

[Pizarra: gráfico `bienestar-delta-ec` hasta la capa 3] Marco los dos precios, pe uno cero y pe uno uno, con la llave de la caída del precio, y bajo las cantidades demandadas en cada caso, equis uno cero y equis uno uno.

[Pizarra: gráfico `bienestar-delta-ec` hasta la capa 4] [Pizarra 2: fórmula `\Delta\mathrm{EC}=\int_{p_1^1}^{p_1^0}x_1(p_1,\bar{\vec{p}}_{-1},\overline{W})\,dp_1`] La variación del excedente es el área a la izquierda de la marshalliana entre los dos precios: la integral de la demanda entre el precio final y el inicial.

Solo necesita la demanda, que se observa, pero a lo largo de la marshalliana cambia la utilidad: solo es exacta sin efecto renta. La dualidad propone medir con las demandas compensadas.

### III.3. Análisis de bienestar: variaciones compensatoria y equivalente

[Borrar la pizarra] [Pizarra 1: fórmula `m(\bar{\vec{p}};\vec{p},\overline{W})\equiv E\big(\bar{\vec{p}},V(\vec{p},\overline{W})\big)`] La herramienta es la función de utilidad métrica monetaria, eme: a unos precios de referencia, pe barra, lo que costaría alcanzar la utilidad que da un presupuesto. Es una utilidad indirecta medida en euros, y sus diferencias sí tienen sentido.

> Apunte: McKenzie (1957), Samuelson (1974): función de utilidad métrica monetaria

[Pizarra 2: gráfico `bienestar-vc` hasta la capa 1] Las dos medidas de Hicks la usan con dos precios de referencia. Primero, la variación compensatoria. En el centro, arriba, recupero el plano de las cestas: las dos rectas, las curvas u cero y u uno y las cestas equis cero y equis uno.

[Pizarra: gráfico `bienestar-vc` hasta la capa 2] A los precios finales, trazo la paralela a la nueva recta tangente a la curva inicial: toca en la cesta compensada, hache de pe uno y u cero.

[Pizarra: gráfico `bienestar-vc` hasta la capa 3] [Pizarra 1: fórmula `\mathrm{VC}=\overline{W}-E(\vec{p}^{\,1},\overline{U}^0)`] La variación compensatoria es la distancia entre las dos rectas: lo que, a los precios finales, devuelve al consumidor a la utilidad inicial; si baja un precio, lo máximo que pagaría por la bajada. Es la renta menos e de pe uno y u cero.

[Pizarra: gráfico `bienestar-vc` hasta la capa 4] Abajo, el plano de la demanda: los dos precios, las guías que bajan de las cestas, la marshalliana, en tenue, y la hicksiana de la utilidad inicial, más inclinada para un bien normal, que pasa por equis uno cero y por la cesta compensada.

[Pizarra: gráfico `bienestar-vc` hasta la capa 5] [Pizarra 1: fórmula `=\int_{p_1^1}^{p_1^0}h_1(p_1,\bar{\vec{p}}_{-1},\overline{U}^0)\,dp_1`] Por Shephard, como el gasto es la integral de la hicksiana, la variación compensatoria es el área a su izquierda entre los dos precios, en azul.

[Pizarra 3: gráfico `bienestar-ve` hasta la capa 1] Segundo, la variación equivalente. A la derecha repito el mismo plano de las cestas, con las dos rectas de balance, las dos curvas de indiferencia y las dos cestas elegidas, porque ahora mediremos a los precios iniciales.

[Pizarra: gráfico `bienestar-ve` hasta la capa 2] Trazo la paralela a la recta inicial tangente a la curva final, u uno: la cesta hache de pe cero y u uno.

[Pizarra: gráfico `bienestar-ve` hasta la capa 3] [Pizarra 1: fórmula `\mathrm{VE}=E(\vec{p}^{\,0},\overline{U}^1)-\overline{W}`] La variación equivalente es la distancia entre ellas: lo que, a los precios iniciales, deja al consumidor en la utilidad final; si baja un precio, lo mínimo que aceptaría por renunciar a la bajada. Es e de pe cero y u uno menos la renta.

[Pizarra: gráfico `bienestar-ve` hasta la capa 4] Abajo repito el plano de la demanda, con los dos precios, las cantidades y la marshalliana en tenue, y trazo la hicksiana de la utilidad final, discontinua, que para un bien normal queda a la derecha de la marshalliana y pasa por la cesta final, equis uno uno.

[Pizarra: gráfico `bienestar-ve` hasta la capa 5] [Pizarra 1: fórmula `=\int_{p_1^1}^{p_1^0}h_1(p_1,\bar{\vec{p}}_{-1},\overline{U}^1)\,dp_1`] Y la variación equivalente es el área a la izquierda de esa hicksiana final entre los dos precios, que sombreo en verde: la integral de hache uno con u uno.

### III.3. Análisis de bienestar: las tres medidas juntas

[Borrar la pizarra] [Pizarra 2: gráfico `bienestar-vc-ve` hasta la capa 4] Junto las tres medidas en un único gráfico, que es el que conviene recordar. Arriba, el problema: los ejes, la recta inicial con la curva u cero y la cesta equis cero, y la nueva recta con la curva u uno y la cesta equis uno.

[Pizarra: gráfico `bienestar-vc-ve` hasta la capa 7] Abajo, el plano de la demanda: los dos precios, pe uno cero y pe uno uno; las guías que bajan desde las dos cestas; la demanda marshalliana, que pasa por ellas, y el área de la variación del excedente, en dorado, a la izquierda de la marshalliana.

[Pizarra: gráfico `bienestar-vc-ve` hasta la capa 11] Añado la variación compensatoria: arriba, la paralela a la nueva recta tangente a u cero, y su llave en el eje; abajo, la hicksiana inicial y su área, en azul, que queda dentro del excedente.

[Pizarra: gráfico `bienestar-vc-ve` hasta la capa 15] Y la variación equivalente: arriba, la paralela a la recta inicial tangente a u uno, y su llave, más larga; abajo, la hicksiana final, discontinua, y su área en verde, que va más allá de la marshalliana. Fíjense en el orden de las tres áreas.

[Pizarra: gráfico `bienestar-vc-ve` hasta la capa 16] Para un bien normal, si baja el precio, la compensatoria es menor que el excedente, y este, menor que la equivalente. Para uno inferior, el orden se invierte; sin efecto renta, coinciden.

> Apunte: VC ≤ ΔEC ≤ VE (bien normal, bajada del precio)

[Pizarra 1: fórmula `\mathrm{VC}\approx\Delta\mathrm{EC}-\frac{\varepsilon_{x_1,\overline{W}}\,(\Delta\mathrm{EC})^2}{2\overline{W}}`] ¿Cuánto se equivoca el excedente? Willig, en 1976, aproxima el error: la elasticidad-renta por el excedente al cuadrado entre dos veces la renta. Si el excedente es el 5 por ciento de la renta, el error ronda el 2,5 por ciento: si el bien pesa poco, el excedente basta.

Hausman matiza que no basta para la pérdida irrecuperable de un impuesto. ¿Cuál usar? Para ordenar políticas, la equivalente, que valora todo a los mismos precios; para compensar, la compensatoria, a los precios que regirán.

> Apunte: Hausman (1981): medida exacta recuperando E de la demanda estimada; EG = −VE − T

[Pizarra: gráfico `bienestar-vc-ve` hasta la capa 17] [Pizarra 1: fórmula `L=(\vec{p}^{\,0}-\vec{p}^{\,1})\cdot\vec{x}^0\leq\mathrm{VC}`] Con solo las cestas observadas hay dos medidas de cesta fija. La de Laspeyres valora el cambio con la cesta inicial: es este rectángulo rojo, y acota la compensatoria por abajo.

[Pizarra: gráfico `bienestar-vc-ve` hasta la capa 18] [Pizarra 1: fórmula `\mathrm{VE}\leq P=(\vec{p}^{\,0}-\vec{p}^{\,1})\cdot\vec{x}^1`] La de Paasche usa la cesta final, el rectángulo grande, y acota la equivalente por arriba. La diferencia es el sesgo de sustitución: las cestas fijas ignoran que el consumidor reoptimiza.

### III.3. Análisis de bienestar: índices de coste de la vida

[Borrar 1] [Pizarra 1: gráfico `indice-konus-laspeyres` hasta la capa 2] Ese sesgo está en los índices de precios. Borro las fórmulas y, a la izquierda, dibujo la cesta inicial, equis cero, tangente a u cero con la renta.

[Pizarra: gráfico `indice-konus-laspeyres` hasta la capa 3] Sube el precio del bien uno. Laspeyres valora la cesta inicial a los precios nuevos: la recta por equis cero con la nueva pendiente.

[Pizarra: gráfico `indice-konus-laspeyres` hasta la capa 4] El índice verdadero de coste de la vida, de Konüs, es el cociente de gastos mínimos para alcanzar la misma utilidad: la paralela tangente a u cero.

> Apunte: Konüs (1924): cociente de gastos mínimos, E(p¹, Ū)/E(p⁰, Ū)

[Pizarra: gráfico `indice-konus-laspeyres` hasta la capa 5] La distancia entre las dos rectas es el sesgo de sustitución, que marco con una llave. Y escribo la comparación: el índice de Laspeyres, la cesta inicial a los precios nuevos entre su coste inicial, es mayor o igual que el de Konüs. Laspeyres sobrestima el coste de la vida, porque supone que no se sustituye lo que se encarece; Paasche, en cambio, subestima el índice verdadero con la utilidad final.

Los índices superlativos de Diewert, como el de Fisher o el de Törnqvist, lo corrigen. ¿Cuánto pesa? La Comisión Boskin le atribuyó 0,4 puntos al año en Estados Unidos, donde hoy el IPC encadenado crece unos 0,25 puntos menos.

> Apunte: IPC del INE: Laspeyres encadenado, base 2025; deflactor del PIB: Paasche encadenado

[Borrar 1] Recapitulando, la dualidad pasa de la utilidad, que solo ordena, a medidas en euros, y explica los sesgos del excedente y de los índices. Borro el resto y dejo el gráfico conjunto, que lo resume.

> Apunte: Idea clave: la función de gasto traduce la utilidad a euros; el excedente aproxima y las cestas fijas acotan

## Conclusión (1 min)

### Recapitulación

En conclusión, al dar la vuelta al problema del consumidor hemos obtenido la función de gasto y unas relaciones que conectan las cuatro funciones, la estimación de sistemas como el AIDS y tres aplicaciones: integrabilidad, Slutsky y bienestar.

### Relevancia

Su relevancia: convierte una teoría de lo inobservable en restricciones sobre lo observable y en medidas en euros.

### Extensiones

Se extiende a la empresa, con la función de costes; al bienestar agregado, y a la economía pública, con el exceso de gravamen y el coste-beneficio.

### Opinión

En mi opinión, es un caso en que la teoría más abstracta ha resultado más útil, con el límite de un consumidor estático y racional.

### Idea final

Volvamos a la pregunta del principio: ¿se puede medir en euros algo que solo sabemos ordenar? Sí, si no medimos la utilidad, sino lo que cuesta alcanzarla. Así, si su cesta se parece a la del IPC, la subida compensa al pensionista algo de más; si es distinta, puede quedarse corta. Lo que esa traducción no permite es sumar el bienestar de personas distintas: para eso hacen falta juicios de valor, y ahí empieza la economía del bienestar.
