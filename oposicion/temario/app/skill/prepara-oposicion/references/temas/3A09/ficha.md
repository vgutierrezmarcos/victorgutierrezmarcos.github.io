<!-- Material exclusivo de victorgutierrezmarcos.es y la app Oposición TCEE · DCE. Forma parte de la skill «Prepara con Claude»: solo para la preparación personal del opositor en su propia cuenta de Claude. No se autoriza copiarlo, redistribuirlo ni usarlo en otras plataformas o sistemas de IA (ver LICENCIA.md). -->
*Material exclusivo de victorgutierrezmarcos.es y la app Oposición TCEE · DCE. Forma parte de la skill «Prepara con Claude»: solo para la preparación personal del opositor en su propia cuenta de Claude. No se autoriza copiarlo, redistribuirlo ni usarlo en otras plataformas o sistemas de IA (ver LICENCIA.md).*

# 3.A.9. Teoría de la demanda del consumidor (II). Dualidad e integrabilidad de las preferencias. Sistemas de demanda utilizados en estudios empíricos. Medidas de cambio en el bienestar.

*Ficha de repaso · actualizada el 18/10/2026*

## Esquema del cante

- **Introducción** · 2′

- **I. Análisis teórico de la dualidad** · 10′

- 1. Ingredientes comunes (papeles cambiados) · 2′

- 2. Primal $\to\mathbf{x}$, $V$; dual $\to\mathbf{h}$, $E$ · 5′

- 3. Relaciones de dualidad (Roy, Shephard) · 3′

- **II. Sistemas completos de demanda** · 5′

- 1. Idea: fines y requisitos · 0′30″

- 2. Pasos: forma funcional (LES $\to$ AIDS), datos · 3′30″

- 3. Valoración · 1′

- **III. Aplicaciones de la dualidad** · 12′

- 1. Integrabilidad (Antonelli; Hurwicz-Uzawa) · 2′30″

- 2. Ecuación de Slutsky y clasificación · 3′30″

- 3. Bienestar: $\Delta$EC, VC, VE, índices · 6′

- **Conclusión** · 1′

*Hilo*: herramientas (I) $\to$ estimación (II) $\to$ uso (III). *Pizarra*: esquema de dualidad por capas; $E(\mathbf{p},\overline{U})$ y Slutsky, recuadradas, no se borran.

## Introducción (2′)

- **Enganche**: pensiones revalorizadas con la media del IPC (+2,7 % en 2026). *¿Basta para quedar igual?* Si los precios suben de forma desigual, se sustituye: importa cuánto cuesta *volver a estar igual de bien*. Utilidad *ordinal* $\Rightarrow$ ¿se puede medir en euros algo que solo sabemos ordenar? $\Rightarrow$ **función de gasto** $\Rightarrow$ **dualidad**.

- **Relevancia**: *teórica* (Slutsky en dos líneas; integrabilidad); *empírica* (elasticidades: IVA, índices, pobreza); *normativa* (VC y VE: coste-beneficio, exceso de gravamen).

- **Contextualización**: ligar *preferencias* (no se ven) y *demanda* (se ve). 4 líneas: *dualidad* (Hotelling 1932 $\to$ Shephard 1953, McKenzie 1957); *integrabilidad* (Antonelli 1886 $\to$ Hurwicz-Uzawa 1971); *bienestar* (Dupuit 1844 $\to$ Hicks, Willig); *sistemas* (Stone 1954 $\to$ AIDS 1980; Nobel a Deaton, 2015).

- **«Dual»**: *estricto* = intercambiar objetivo y restricción; *amplio* = papeles invertidos (empresa [ver tema 3.A.12]). Aquí, estricto.

- **Problemática**: ¿se llega a la misma decisión al «dar la vuelta» al problema? ¿Cómo se estiman los sistemas de demanda? ¿Qué demandas proceden de unas preferencias? ¿Cómo medir en euros el bienestar y qué error cometen el excedente y los índices?

- **Estructura**: I. dualidad (herramientas); II. sistemas de demanda (estimación); III. aplicaciones: integrabilidad, Slutsky, bienestar. La integrabilidad tras II: responde si lo estimado puede venir de un consumidor racional.

## I. Análisis teórico de la dualidad (10′)

- *Conclusión anticipada*: máx. $U$ con renta dada y mín. gasto con utilidad dada $\Rightarrow$ *misma cesta*; de ahí, relaciones para pasar de unas funciones a otras sin resolver más problemas.

### I.1. Ingredientes comunes

- *Dos enfoques*: **primal**: recursos dados, máx. utilidad; **dual**: «da la vuelta»: utilidad dada (restricción), mín. gasto (objetivo). Mismo problema de fondo.

- *Conjunto de elección*: $S\subseteq\mathbb{R}^n_+$ no vacío, cerrado y convexo (normalmente $\mathbb{R}^n_+$).

- *Preferencias* $\succcurlyeq$: completitud, reflexividad, transitividad, continuidad ($\Rightarrow$ $U$ continua, Debreu); insaciabilidad local; convexidad estricta; diferenciabilidad.

- *Utilidad*: $U(\mathbf{x})$ continua, creciente, estr. cuasicóncava [ver tema 3.A.8]. *Gasto*: $\mathbf{p}\cdot\mathbf{x}$, $\mathbf{p}\gg\mathbf{0}$ dados.

- *Supuestos*: estático, sin incertidumbre, información perfecta, bienes homogéneos, precio-aceptante. Solo cambia qué es objetivo y qué restricción:

|  | *Primal (PMU)* | *Dual (PMG)* |
|:---|:---|:---|
| Objetivo | $U(\mathbf{x})$ (máx.) | $\mathbf{p}\cdot\mathbf{h}$ (mín.) |
| Restricción | $\mathbf{p}\cdot\mathbf{x}\leq\overline{W}$ | $U(\mathbf{h})\geq\overline{U}$ |
| Parámetros | $\mathbf{p}$, $\overline{W}$ | $\mathbf{p}$, $\overline{U}$ |
| Solución | marshalliana $\mathbf{x}(\mathbf{p},\overline{W})$ | hicksiana $\mathbf{h}(\mathbf{p},\overline{U})$ |
| Función valor | FIU $V(\mathbf{p},\overline{W})$ | gasto $E(\mathbf{p},\overline{U})$ |

### I.2. Problemas primal y dual

**Problema primal: maximización de la utilidad (PMU)**

- *a) Idea*: necesidades ilimitadas, recursos escasos; punto de partida de la dualidad [ver tema 3.A.8].

- *b.i) Supuestos*: los de I.1.

- *b.ii) Desarrollo*: óptimo que existe (Weierstrass), global y único; Kuhn-Tucker con $\mathcal{L}=U+\lambda(\overline{W}-\mathbf{p}\cdot\mathbf{x})$; $\lambda$ = **utilidad marginal de la renta**: $\begin{array}{rl}\max_{\mathbf{x}} & U(\mathbf{x}) \\ \text{s.a.} & \mathbf{p}\cdot\mathbf{x}\leq\overline{W}\\ \mathbf{x}\geq\mathbf{0}\end{array}$$\Rightarrow$$\dfrac{U_i}{p_i}=\lambda$ (Gossen),  $\mathrm{RMS}_{12}=\dfrac{p_1}{p_2}$

- *b.iii) Implicaciones*:

  - **Demanda marshalliana** $\mathbf{x}(\mathbf{p},\overline{W})$: única; continua (Berge); sin ilusión monetaria (grado 0); ley de Walras (tabla).

  - **Función indirecta de utilidad** (FIU) $V(\mathbf{p},\overline{W})=U(\mathbf{x}(\mathbf{p},\overline{W}))$: utilidad máxima; *cuasiconvexa* (con el presupuesto promedio no se alcanza más que con el mejor extremo; no exige preferencias convexas); identidad de Roy (1947).

- *c) Valoración*: $V$ en «útiles», solo ordena $\Rightarrow$ ¿y si se da la vuelta al problema?

**Problema dual: minimización del gasto (PMG)**

- *a) Idea*: la forma más barata de alcanzar un nivel de utilidad.

- *b.i) Supuestos*: idénticos a los del primal.

- *b.ii) Desarrollo*: $\mathcal{L}=\mathbf{p}\cdot\mathbf{h}+\mu(\overline{U}-U(\mathbf{h}))$ $\Rightarrow$ $p_i/U_i=\mu$: *misma* tangencia $\mathrm{RMS}_{12}=p_1/p_2$; $\mu^*=\partial E/\partial\overline{U}$ = **coste marginal de la utilidad** $=1/\lambda^*$; restricción saturada.

*[Gráfico: Primal: la curva de indiferencia más alta alcanzable con $\overline{W}$]* · *[Gráfico: Dual: la isogasto más baja que alcanza $\overline{U}$]*

- *b.iii) Implicaciones*:

  - **Demanda hicksiana** (compensada) $\mathbf{h}(\mathbf{p},\overline{U})$: única, continua; homog. de grado 0 en $\mathbf{p}$; sin exceso de utilidad; **ley de la demanda compensada** $\partial h_i/\partial p_i\leq0$ $\Rightarrow$ Giffen imposible (no hay efecto renta). *No observable*: depende de $\overline{U}$.

  - **Función de gasto** (FG): gasto mínimo para alcanzar $\overline{U}$; mide la utilidad en *euros*:

$$E(\mathbf{p},\overline{U})=\mathbf{p}\cdot\mathbf{h}(\mathbf{p},\overline{U})=\begin{array}{rl}\min_{\mathbf{h}} & \mathbf{p}\cdot\mathbf{h} \\ \text{s.a.} & U(\mathbf{h})\geq\overline{U}\\ \mathbf{h}\geq\mathbf{0}\end{array}$$

- *Propiedades de $E$*: continua; homog. de *grado 1* en $\mathbf{p}$; estr. creciente en $\overline{U}$; no decreciente en $p_i$; *cóncava* en $\mathbf{p}$: el consumidor «pasivo» pagaría $\mathbf{p}\,'\cdot\mathbf{h}(\mathbf{p},\overline{U})$ (lineal); sustituyendo, como mucho eso: $E(\mathbf{p}\,',\overline{U})\leq\mathbf{p}\,'\cdot\mathbf{h}(\mathbf{p},\overline{U})$;Shephard: $h_i(\mathbf{p},\overline{U})=\dfrac{\partial E(\mathbf{p},\overline{U})}{\partial p_i}$
  $S_{ij}\equiv\dfrac{\partial^2E}{\partial p_i\,\partial p_j}=\dfrac{\partial h_i(\mathbf{p},\overline{U})}{\partial p_j}$(**matriz de Slutsky**)

- *Lema de Shephard* (1953; McKenzie 1957): si $p_i$ sube 1 €, la cesta apenas cambia en primer orden (envolvente) $\Rightarrow$ el gasto sube $h_i$ €.

- *Matriz $S$*: *simétrica* (Schwarz/Young); *semidef. negativa* ($E$ cóncava; $S_{ii}\leq0$); $S\mathbf{p}=\mathbf{0}$ (Euler).

*[Gráfico: $E$ cóncava: bajo su tangente, de pendiente $h_i$ (Shephard)]*

| *Primal: $\mathbf{x}(\mathbf{p},\overline{W})$, $V(\mathbf{p},\overline{W})$* | *Dual: $\mathbf{h}(\mathbf{p},\overline{U})$, $E(\mathbf{p},\overline{U})$* |
|:---|:---|
| $\mathbf{x}$ grado 0 en $(\mathbf{p},\overline{W})$ | $\mathbf{h}$ grado 0 en $\mathbf{p}$ |
| Walras: $\mathbf{p}\cdot\mathbf{x}=\overline{W}$ | sin exceso: $U(\mathbf{h})=\overline{U}$ |
| $V$ grado 0 en $(\mathbf{p},\overline{W})$ | $E$ grado 1 en $\mathbf{p}$ |
| $V$ $\uparrow$ en $\overline{W}$, no $\uparrow$ en $\mathbf{p}$ | $E$ $\uparrow$ en $\overline{U}$, no $\downarrow$ en $\mathbf{p}$ |
| $V$ cuasiconvexa | $E$ cóncava en $\mathbf{p}$ |
| Roy: $x_i=-\dfrac{\partial V/\partial p_i}{\partial V/\partial\overline{W}}$ | Shephard: $h_i=\dfrac{\partial E}{\partial p_i}$ |

- *c) Valoración*: misma tangencia y 2 funciones nuevas: $\mathbf{h}$ (cumple siempre la ley de la demanda, pero inobservable) y $E$ (utilidad en dinero). Falta ligarlas con las del primal, que sí se observan.

### I.3. Relaciones de dualidad

- **Teorema básico de la dualidad**: con $U$ continua, insaciabilidad local y $\mathbf{p}\gg\mathbf{0}$: (1) si $\mathbf{x}^*$ resuelve el PMU con $\overline{W}>0$, resuelve el PMG con $\overline{U}=U(\mathbf{x}^*)$ y gasto mínimo $\overline{W}$; (2) si $\mathbf{h}^*$ resuelve el PMG, resuelve el PMU con $\overline{W}=\mathbf{p}\cdot\mathbf{h}^*$ y utilidad máx. $\overline{U}$.

- **Coinciden las cestas**, no las funciones: $\mathbf{x}$ y $\mathbf{h}$ dependen de variables distintas ($\overline{W}$, $\overline{U}$).

$\mathbf{x}(\mathbf{p},\overline{W})\equiv\mathbf{h}\big(\mathbf{p},V(\mathbf{p},\overline{W})\big)$,$\mathbf{h}(\mathbf{p},\overline{U})\equiv\mathbf{x}\big(\mathbf{p},E(\mathbf{p},\overline{U})\big)$
$E\big(\mathbf{p},V(\mathbf{p},\overline{W})\big)\equiv\overline{W}$,$V\big(\mathbf{p},E(\mathbf{p},\overline{U})\big)\equiv\overline{U}$

- *Lectura*: entre demandas, se sustituye $\overline{U}$ por $V$ o $\overline{W}$ por $E$; $V$ y $E$, **inversas** en su 2.º argumento: hallada una, la otra se despeja.

- *Ejemplo* (Cobb-Douglas): $x_1=\alpha\overline{W}/p_1$ $\to$ $V$ $\to$ invirtiendo, $E$ $\to$ Shephard: $h_1=\alpha E/p_1$ (como la marshalliana, con $E$ en lugar de $\overline{W}$).

*[Gráfico: Esquema de dualidad: problemas, soluciones, funciones valor y relaciones (Roy, Shephard, inversas, Slutsky, integrabilidad)]*

> Maximizar la utilidad con una renta y minimizar el gasto con una utilidad son el mismo problema visto desde dos lados. $E$ mide la utilidad en dinero, sus derivadas son las hicksianas (Shephard) y su concavidad da la ley de la demanda compensada. Las flechas del esquema son las herramientas de II y III.

## II. Sistemas completos de demanda (5′)

- *Conclusión anticipada*: se elige una $E$ o una $V$ flexible, se derivan demandas estimables y se contrastan las restricciones de la teoría; el AIDS equilibra flexibilidad, coherencia, agregación y sencillez.

### II.1. Idea

- *Definición*: **sistema completo de ecuaciones de demanda**: gasto en *todos* los bienes (o grupos) en función de precios y gasto total, derivado de una optimización.

- *Fines*: (1) *medir* elasticidades (IVA, índices, pobreza); (2) *contrastar* la teoría (homogeneidad, simetría, negatividad = integrabilidad, III.1); (3) *valorar* el bienestar (VC, VE).

- *Papel de la dualidad*: se especifica $E$ o $V$ y se deriva (Shephard/Roy) $\Rightarrow$ coherente con la maximización *por construcción*, sin resolver ningún problema.

- *Requisitos* (tiran en sentidos opuestos): coherencia con la teoría; flexibilidad (no fijar elasticidades); agregación (la media con la forma individual); sencillez (lineal en los parámetros).

### II.2. Pasos que sigue la literatura

- *Pasos*: (1) forma funcional; (2) sistema completo; (3) datos; (4) especificación econométrica; (5) estimar y contrastar.

- *(1) Forma funcional*: compromiso sencillez–flexibilidad; cada sistema supera el límite del anterior. Punto de partida, **Cobb-Douglas** $U=\sum_i\alpha_i\ln x_i$: $s_i=\alpha_i$ constantes; $\varepsilon_{\overline{W}}=1$, $\varepsilon_{ii}=-1$, cruzadas 0, $\sigma=1$; homotética $\Rightarrow$ no recoge la ley de Engel.

**Sistema lineal de gasto (LES)**

- *a) Idea*: recoger la ley de Engel (necesarios y de lujo) sin perder linealidad.

- *b) Modelo*: *supuestos*: utilidad de Stone-Geary $U=\sum_i\alpha_i\ln(x_i-\gamma_i)$, $\alpha_i>0$, $\sum\alpha_i=1$; *desarrollo*: $p_ix_i=p_i\gamma_i+\alpha_i\big(\overline{W}-\sum_jp_j\gamma_j\big)$: subsistencia $\gamma_i$ + renta *supernumeraria* en proporciones fijas; *implicaciones*: curvas de Engel rectas que no pasan por el origen.

- *c) Evidencia*: Stone (1954), Reino Unido, primer sistema estimado; Deaton (1974) rechaza la aditividad.

- *d) Valoración*: *aditivo* $\Rightarrow$ sin inferiores ($\alpha_i>0$) ni complementarios netos; elasticidades-precio ligadas a las de renta.

**Modelo de Rotterdam y translog**

- **Rotterdam** (Barten 1964, Theil 1965): *idea*: Slutsky en diferencias logarítmicas con coeficientes constantes; *implicaciones*: restricciones lineales; *evidencia*: Países Bajos, rechaza la homogeneidad; *valoración*: local, sin $E$ explícita.

- **Translog** (Christensen-Jorgenson-Lau, 1975): *idea*: forma *flexible*, $\ln V$ de 2.º orden en $\ln(p_i/\overline{W})$, participaciones por Roy; *evidencia*: EE. UU. 1929-72, rechaza la teoría y la homoteticidad; *valoración*: no lineal, no agrega.

**Sistema casi ideal de demanda (AIDS)**

- *a) Idea*: reunir los 4 requisitos (Deaton-Muellbauer, 1980).

- *b.i) Supuestos*: $E$ de la clase **PIGLOG** (Muellbauer), compatible con la agregación; $a(\mathbf{p})$ coste de subsistencia ($\overline{U}=0$), $b(\mathbf{p})$ de saciedad ($\overline{U}=1$).

- *b.ii) Desarrollo*: Shephard en logaritmos ($s_i=\partial\ln E/\partial\ln p_i$) y $\overline{U}$ despejada de $E=\overline{W}$: $\ln E(\mathbf{p},\overline{U})=(1-\overline{U})\ln a(\mathbf{p})+\overline{U}\ln b(\mathbf{p})$
  $s_i=\alpha_i+\sum_j\gamma_{ij}\ln p_j+\beta_i\ln\dfrac{\overline{W}}{P}$,$\ln P=\ln a(\mathbf{p})$ (translog)
  $\varepsilon_{x_i,\overline{W}}=1+\dfrac{\beta_i}{s_i}$

- *b.iii) Implicaciones*: restricciones *lineales*: agregación $\sum_i\alpha_i=1$, $\sum_i\gamma_{ij}=\sum_i\beta_i=0$; homogeneidad $\sum_j\gamma_{ij}=0$; simetría $\gamma_{ij}=\gamma_{ji}$; negatividad no impuesta. Engel de Working-Leser: $\beta_i>0$ lujo, $\beta_i<0$ necesario. *Agregación exacta* (PIGLOG).

- *c) Extensiones*: *LA-AIDS*: índice de Stone $\ln P^*=\sum_ks_k\ln p_k$ $\Rightarrow$ lineal, MCO ecuación a ecuación. **QUAIDS** (Banks-Blundell-Lewbel, 1997): término en $(\ln\overline{W})^2$, rango 3 (Gorman): un bien, de lujo para renta baja y necesario para alta.

- *d) Evidencia*: Reino Unido, rechazan la homogeneidad (dinámica).

- *e) Valoración*: «*casi*» ideal: negatividad no garantizada y Engel restrictivas.

| *Sistema* | *Parte de* | *Flex.* | *Agreg.* | *Lineal* | *Límite* |
|:---|:---|:---|:---|:---|:---|
| C-D | $U$ directa | no | sí | sí (log) | $s_i$ constantes |
| LES | $U$ directa | no | sí | no | aditivo |
| Rotterdam | Slutsky | local | no | sí | sin $E$ explícita |
| Translog | FIU | sí | no | no | no lineal |
| AIDS | $E$ PIGLOG | sí | exacta | LA-AIDS | Engel lineal en $\ln\overline{W}$ |
| QUAIDS | $E$ | sí | sí | no | más parámetros |

- *(2) Sistema completo*: estimación *conjunta*, $\sum_is_i=1$. Agrupar ($\sim n^2$ parámetros): **separabilidad débil** y **presupuestación en dos etapas** (Strotz, Gorman).

- *(3) Datos*: microdatos de la **Encuesta de Presupuestos Familiares** (EPF, INE). Precios casi iguales en un corte $\Rightarrow$ años y regiones o valores unitarios (Deaton).

- *(4) Econometría*: covarianzas singulares $\Rightarrow$ se quita una ecuación (MV: Barten); gasto endógeno; ceros; demografía.

- *(5) Resultados*: con series agregadas se rechaza sobre todo la *homogeneidad*; Deaton: rigidez, dinámica y, sobre todo, *agregación* $\Rightarrow$ microdatos. Usos: IVA, incidencia, índices por hogar, pobreza; España: AIDS con la EPF (Sanz-Romero, 2012).

### II.3. Valoración

- *Aportaciones*: la teoría pasa a ser instrumento de medida; sus restricciones, hipótesis contrastables; AIDS y QUAIDS concilian flexibilidad, agregación y sencillez.

- *Limitaciones*: (1) flexibilidad vs. parsimonia ($n(n+1)/2$ términos cruzados; flexibilidad local); (2) agregación: consumidor representativo solo con forma polar de Gorman o PIGLOG; **teorema de Sonnenschein-Mantel-Debreu**: las restricciones individuales no tienen por qué cumplirse en la media; (3) marco estático: hábitos, duraderos, liquidez [ver tema 3.A.33].

- *Enlace*: estimar no garantiza que el sistema proceda de unas preferencias $\Rightarrow$ integrabilidad.

## III. Aplicaciones de la dualidad (12′)

- *Conclusión anticipada*: una aplicación teórica, la *integrabilidad* (el esquema al revés, de la demanda a las preferencias), y dos prácticas: Slutsky en dos líneas (separa lo observable de lo que no) y el bienestar en euros con $E$.

### III.1. Integrabilidad de las preferencias

- *Pregunta*: dado $\mathbf{x}(\mathbf{p},\overline{W})$ observado (estimado en II), ¿existe una $U$ de la que proceda? Si sí, se «integran» las demandas. Antonelli (1886); Hurwicz-Uzawa (1971).

- *Respuesta*: **teorema de integrabilidad**: $\mathbf{x}$ continuamente diferenciable es demanda de una $U$ creciente y cuasicóncava *si y solo si*: (1) ley de Walras; (2) $S$ *simétrica*; (3) $S$ *semidef. negativa* (y homogeneidad). Con 2 bienes, simetría automática. Necesarias (I.2, III.2) y suficientes (teorema).

$S_{ij}(\mathbf{p},\overline{W})=\dfrac{\partial x_i}{\partial p_j}+x_j\dfrac{\partial x_i}{\partial\overline{W}}=S_{ji}$(observable)
$\nabla_{\mathbf{p}}E(\mathbf{p},\overline{U})=\mathbf{x}\big(\mathbf{p},E(\mathbf{p},\overline{U})\big)$,$E(\mathbf{p}^0,\overline{U})=\overline{W}^0$

- *Intuición de la demostración* (por dualidad):

  - *de la demanda a $E$*: Shephard + dualidad $\Rightarrow$ sistema de ecuaciones en derivadas parciales; solución $\Leftrightarrow$ derivadas cruzadas iguales (**teorema de Frobenius**) $\Leftrightarrow$ *simetría* de $S$;

  - *que sea función de gasto*: homogénea de grado 1 y creciente por construcción; falta la *concavidad*: su hessiana es $S$ $\Rightarrow$ *negatividad*;

  - *de $E$ a $U$*: $E\to V$ invirtiendo; $U(\mathbf{x}^0)$ = mín. de $V$ entre los presupuestos con los que se compra $\mathbf{x}^0$.

*[Gráfico: Recuperar $U$ desde $V$: el mínimo de $V$ entre los presupuestos que permiten comprar $\mathbf{x}^0$]*

- *Preferencia revelada* [ver tema 3.A.8]: axioma débil $\Rightarrow$ $S$ semidef. negativa, *no* simétrica; axioma fuerte (Houthakker, 1950) sí racionaliza; Kihlstrom-Mas-Colell-Sonnenschein (1976) los unen; Afriat (1967), datos finitos.

- *Relevancia*: *teórica* (cierra el círculo: las preferencias no añaden nada a 3 propiedades contrastables); *empírica* (contraste sin hallar $U$); *normativa* ($E$ exacta desde la demanda: Hausman, 1981).

### III.2. Ecuación de Slutsky y clasificación de los bienes

- *Derivación*: derivar $h_i(\mathbf{p},\overline{U})\equiv x_i\big(\mathbf{p},E(\mathbf{p},\overline{U})\big)$ respecto a $p_j$ (regla de la cadena); evaluar en $\overline{U}=V(\mathbf{p},\overline{W})$: $E=\overline{W}$ y, por Shephard, $\partial E/\partial p_j=h_j=x_j$:

$$\underbrace{\frac{\partial x_i(\mathbf{p},\overline{W})}{\partial p_j}}_{\text{ET}}=\underbrace{\frac{\partial h_i(\mathbf{p},\overline{U})}{\partial p_j}}_{\text{ES}}\ \underbrace{-\,x_j\,\frac{\partial x_i(\mathbf{p},\overline{W})}{\partial\overline{W}}}_{\text{ER}}$$ En elasticidades:$\varepsilon_{x_i,p_j}=\varepsilon^{h}_{i,p_j}-s_j\,\varepsilon_{x_i,\overline{W}}$

- *Lectura*: efecto sustitución (ES, utilidad constante, Hicks) inobservable; ET y efecto renta (ER) observables $\Rightarrow$ $S$ calculable con datos. ER pesa más cuanto mayor es $s_j$.

- *Propiedades de $S$*: simétrica; semidef. negativa ($S_{ii}\leq0$); $S\mathbf{p}=\mathbf{0}$ $\Rightarrow$ $\sum_{j\neq i}p_jS_{ij}=-p_iS_{ii}\geq0$: **todo bien tiene al menos un sustitutivo neto** (Hicks); con 2 bienes, sustitutivos netos.

- *Precio propio*: normal $\Rightarrow$ ordinario (ley de la demanda); inferior: ordinario si domina el ES, Giffen si domina el ER ($s_i$ alto). Giffen $\Rightarrow$ inferior, no al revés. Veblen, fuera (precio en las preferencias).

| *ES propio* |  *ER propio*   | *ET propio*                                 |
|:-----------:|:--------------:|:--------------------------------------------|
|   $\leq0$   |  $<0$: normal  | $\leq0$: ordinario                          |
|   $\leq0$   | $=0$: frontera | $\leq0$: ordinario                          |
|   $\leq0$   | $>0$: inferior | ordinario si $|\mathrm{ES}|\geq\mathrm{ER}$ |
|             |                | $>0$: Giffen si $\mathrm{ER}>|\mathrm{ES}|$ |

- *Precios cruzados*: relación *neta* (signo de $S_{ij}$) *simétrica* (Hicks-Allen, 1934); *bruta* (signo de $\partial x_i/\partial p_j$) no: los ER cruzados difieren. Sustitutivos netos + $i$ inferior $\Rightarrow$ sustitutivos brutos; complementarios netos + $i$ normal $\Rightarrow$ complementarios brutos; los otros casos, ambiguos (sustitutivos netos y complementarios brutos, posible).

- *Pendientes* en $(x_i,p_i)$: bien normal, marshalliana más plana (más elástica) que la hicksiana; inferior, más inclinada; sin ER, coinciden $\Rightarrow$ puente con el bienestar: normal y baja el precio, $\mathrm{VC}\leq\Delta\mathrm{EC}\leq\mathrm{VE}$.

### III.3. Análisis de bienestar del consumidor individual

- *Idea*: **economía del bienestar**: deseabilidad de las asignaciones. Aquí, *un* consumidor y cambios de *precios* (equilibrio parcial [ver tema 3.A.16]): evita comparar personas. Usuario: el decisor público.

- *Problema*: baja $p_1$ $\Rightarrow$ de $\overline{U}^0$ a $\overline{U}^1$. ¿Cuánto mejora? Utilidad ordinal: $\overline{U}^1-\overline{U}^0$ no significa nada $\Rightarrow$ medida en euros con $E$. Notación: $\mathbf{p}^0\to\mathbf{p}^1$, $\overline{W}$ fija, $\overline{U}^k=V(\mathbf{p}^k,\overline{W})$.

- **Variación del excedente del consumidor** (Dupuit 1844, Marshall 1890): área a la izquierda de la marshalliana entre los dos precios. Observable, pero *mezcla* ES y ER. Exacta si el ER es nulo (cuasilineal); con varios precios, depende del camino.

- **Métrica monetaria** (McKenzie, Samuelson): $m(\bar{\mathbf{p}};\mathbf{p},\overline{W})\equiv E\big(\bar{\mathbf{p}},V(\mathbf{p},\overline{W})\big)$: una FIU en euros $\Rightarrow$ sus diferencias sí tienen sentido. VC: referencia $\mathbf{p}^1$; VE: $\mathbf{p}^0$ (Hicks).

$\Delta\mathrm{EC}=\displaystyle\int_{p_1^1}^{p_1^0}x_1(p_1,\overline{\mathbf{p}}_{-1},\overline{W})\,dp_1$
$\mathrm{VC}=\overline{W}-E(\mathbf{p}^1,\overline{U}^0)=\displaystyle\int_{p_1^1}^{p_1^0}h_1(p_1,\overline{\mathbf{p}}_{-1},\overline{U}^0)\,dp_1$
$\mathrm{VE}=E(\mathbf{p}^0,\overline{U}^1)-\overline{W}=\displaystyle\int_{p_1^1}^{p_1^0}h_1(p_1,\overline{\mathbf{p}}_{-1},\overline{U}^1)\,dp_1$

- **Variación compensatoria** (VC): a precios *finales*, renta que devuelve a la utilidad *inicial*. Baja $p$: lo *máximo que pagaría*; sube: $-$VC, compensación mínima. Área bajo la hicksiana *inicial*.

- **Variación equivalente** (VE): a precios *iniciales*, renta que lleva a la utilidad *final*. Baja $p$: lo *mínimo que aceptaría* por renunciar; sube: $-$VE, lo máximo que pagaría por evitarla. Área bajo la hicksiana *final*.

*[Gráfico: VC, $\Delta$EC y VE (y $L$, $P$) ante una bajada de $p_1$ de un bien normal]*

$L\leq\mathrm{VC}\leq\Delta\mathrm{EC}\leq\mathrm{VE}\leq P$(bien normal, baja $p_1$)
Willig (1976):  $\mathrm{VC}\approx\Delta\mathrm{EC}-\dfrac{\varepsilon_{x_1,\overline{W}}(\Delta\mathrm{EC})^2}{2\overline{W}}$,  $\mathrm{VE}\approx\Delta\mathrm{EC}+\dfrac{\varepsilon_{x_1,\overline{W}}(\Delta\mathrm{EC})^2}{2\overline{W}}$

- *Ordenación*: inferior, se invierte; si sube el precio, se invierte en valor absoluto; ER nulo: VC $=\Delta$EC $=$ VE.

- *Willig*: error relativo $\approx|\varepsilon_{x_1,\overline{W}}|\,|\Delta\mathrm{EC}|/2\overline{W}$ (5 % de la renta y elasticidad 1: 2,5 %) $\Rightarrow$ justifica el excedente en equilibrio parcial y coste-beneficio. Hausman (1981): falla en la pérdida irrecuperable (2.º orden) $\Rightarrow$ $E$ exacta resolviendo la ecuación de la integrabilidad.

- *¿Cuál usar?* *Ordenar políticas*: VE (base fija $\mathbf{p}^0$; la VC puede ordenar mal). *Compensar* (criterio de Kaldor-Hicks [ver tema 3.A.22]): VC (precios que regirán). Exceso de gravamen: $\mathrm{EG}=-\mathrm{VE}-T>0$ [ver tema 4.B.9].

- *Información incompleta* (solo $\mathbf{x}^0$, $\mathbf{x}^1$): variaciones de Laspeyres $L=(\mathbf{p}^0-\mathbf{p}^1)\cdot\mathbf{x}^0\leq\mathrm{VC}$ y de Paasche $P=(\mathbf{p}^0-\mathbf{p}^1)\cdot\mathbf{x}^1\geq\mathrm{VE}$, para cualquier bien: **sesgo de sustitución** (las cestas fijas ignoran que se reoptimiza).

Konüs (1924):  $I_K(\overline{U})=\dfrac{E(\mathbf{p}^1,\overline{U})}{E(\mathbf{p}^0,\overline{U})}$
$I_L=\dfrac{\mathbf{p}^1\cdot\mathbf{x}^0}{\mathbf{p}^0\cdot\mathbf{x}^0}\geq I_K(\overline{U}^0)$,$I_P=\dfrac{\mathbf{p}^1\cdot\mathbf{x}^1}{\mathbf{p}^0\cdot\mathbf{x}^1}\leq I_K(\overline{U}^1)$

- **Índice verdadero de coste de la vida** (Konüs): $I_K(\overline{U}^0)$, versión de la VC; $I_K(\overline{U}^1)$, de la VE. Exige $E$.

- **Laspeyres**: aproximación de 1.^(er) orden de $E(\mathbf{p}^1,\overline{U}^0)$ $\Rightarrow$ por la concavidad, *cota superior*: sobrestima (indexar con $I_L$ sobrecompensa). **Paasche**: cota inferior de $I_K(\overline{U}^1)$. Acotan índices *distintos*: $I_P\leq I_K\leq I_L$ solo con homotéticas; igualdades solo con Leontief ($S=0$).

*[Gráfico: Laspeyres sobrestima: el sesgo de sustitución]*

- **Índices superlativos** (Diewert, 1976): exactos para formas flexibles: Fisher $I_F=\sqrt{I_LI_P}$ ($E$ cuadrática homogénea); Törnqvist $\ln I_T=\sum_i\tfrac12(s_i^0+s_i^1)\ln(p_i^1/p_i^0)$ (translog): puente con II.

- **IPC del INE**: índice *de tipo Laspeyres* encadenado (base 2025; ponderaciones anuales: reducen el sesgo, no lo eliminan) $\Rightarrow$ sobrevalora. **Deflactor del PIB**: Paasche encadenado $\Rightarrow$ infravalora [ver tema 3.A.30][ver tema 4.A.1].

> $E$ traduce la utilidad a euros: la VC y la VE miden exactamente el cambio de bienestar; el $\Delta$EC las aproxima tanto mejor cuanto menor es el efecto renta (Willig), y Laspeyres y Paasche las acotan con un sesgo de sustitución que sigue en los índices oficiales.

## Conclusión (1′)

- **Recapitulación**: $\mathbf{h}$, $E$ y dualidad: un problema da las 4 funciones (I); AIDS y microdatos (II); integrabilidad, Slutsky y bienestar: VC, VE; $\Delta$EC aproxima, Laspeyres-Paasche acotan (III).

- **Relevancia**: de lo inobservable (utilidad) a restricciones sobre lo observable y bienestar en euros.

- **Extensiones**: empresa [ver tema 3.A.12]; parcial [ver tema 3.A.16]; bienestar [ver tema 3.A.22]; coste-beneficio [ver tema 4.B.6]; gravamen [ver tema 4.B.9]; IPC [ver tema 4.A.1]; riesgo [ver tema 3.A.10]; intertemporal [ver tema 3.A.29].

- **Opinión**: la teoría más abstracta, muy útil en la práctica; límites: consumidor estático y agregación (sumar exige juicios de valor); herencia de Deaton: microdatos y heterogeneidad.

- **Idea final**: ¿euros para algo que solo se ordena? Sí: lo que cuesta alcanzar la utilidad. Pensionista: si su cesta es como la del IPC, la subida sobrecompensa algo (Laspeyres); si es distinta, puede quedarse corta; la exacta, la VC. Sumar personas exige juicios de valor.

## Autores y fechas

**1844** Dupuit: excedente del consumidor

**1915** Slutsky: efecto sustitución y renta

**1924** Konüs: índice verdadero de coste de la vida

**1939** Hicks: demanda compensada; VC y VE (1941-43)

**1947** Roy: identidad de Roy

**1953** Shephard: lema; 1954, Stone: LES

**1957** McKenzie: función de gasto, métrica monetaria

**1971** Hurwicz-Uzawa: integrabilidad

**1976** Willig: aproximación; Diewert: superlativos

**1980** Deaton-Muellbauer: AIDS

**1981** Hausman: bienestar exacto

**1996** Comisión Boskin: sesgo del IPC

**2015** Nobel a Deaton

## Datos clave

- Revalorización de las pensiones: **+2,7 % en 2026** (media del IPC, Ley General de la Seguridad Social).

- EPF: **unos 24.000 hogares** (INE), anual desde 2006; gasto medio **35.101 €/hogar** (INE, EPF 2025).

- IPC base 2025: **487 artículos, 196 subclases, 13 grupos** (INE, 2026).

- Deflactor del PIB: **+3,0 %** (INE, 2025).

- Sesgo del IPC de EE. UU.: **1,1 p. p./año, 0,4 de sustitución** (Comisión Boskin, 1996); **0,18 p. p./año** (Manser-McDonald, 1959-85); IPC encadenado **0,25 p. p. menos/año** (BLS, 2005-24).

## Preguntas del tribunal

1.  **¿Por qué $\mu^*=1/\lambda^*$?** Derivando $E(\mathbf{p},V(\mathbf{p},\overline{W}))=\overline{W}$ respecto a $\overline{W}$: $\frac{\partial E}{\partial\overline{U}}\frac{\partial V}{\partial\overline{W}}=1$.

2.  **¿Por qué la hicksiana no admite bienes Giffen?** No tiene efecto renta y $E$ es cóncava: $\partial h_i/\partial p_i\leq0$.

3.  **¿Qué condiciones da la integrabilidad?** Ley de Walras, simetría y negatividad de $S$; con 2 bienes la simetría es automática.

4.  **¿Por qué es «casi ideal» el AIDS?** Flexible, coherente, agrega exactamente y lineal (LA-AIDS); pero negatividad no garantizada y Engel restrictivas.

5.  **¿VC o VE?** VE para ordenar políticas (base fija); VC para compensar a los perjudicados.

6.  **¿Por qué el IPC sobrestima el coste de la vida?** Laspeyres fija la cesta e ignora la sustitución; la concavidad de $E$ lo hace cota superior.

> **Ojo en el test.**
>
> - $E$: homog. de grado *1* en $\mathbf{p}$; $\mathbf{h}$: grado *0* en $\mathbf{p}$; $V$ y $\mathbf{x}$: grado 0 en $(\mathbf{p},\overline{W})$.
>
> - Shephard sin signo menos; Roy, con signo menos.
>
> - $S$: *primeras* derivadas de $\mathbf{h}$, *segundas* de $E$.
>
> - $V$ *cuasiconvexa* (no cuasicóncava), sin depender de la convexidad de las preferencias; $E$ *cóncava* en $\mathbf{p}$.
>
> - VC: utilidad *inicial*, precios *finales*; VE: utilidad *final*, precios *iniciales*. ER nulo: VC $=\Delta$EC $=$ VE, pero $L\neq P$ si hay sustitución.
>
> - Laspeyres y Paasche acotan índices verdaderos *distintos*; $I_P\leq I_K\leq I_L$ solo con homotéticas.
>
> - Axioma débil $\Rightarrow$ $S$ semidef. negativa, *no* simétrica.
>
> - Giffen $\Rightarrow$ inferior; inferior $\not\Rightarrow$ Giffen.
