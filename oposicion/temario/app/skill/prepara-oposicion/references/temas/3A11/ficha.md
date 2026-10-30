<!-- Material exclusivo de victorgutierrezmarcos.es y la app Oposición TCEE · DCE. Forma parte de la skill «EconomIA»: solo para la preparación personal del opositor en su propia cuenta de Claude. No se autoriza copiarlo, redistribuirlo ni usarlo en otras plataformas o sistemas de IA (ver LICENCIA.md). -->
*Material exclusivo de victorgutierrezmarcos.es y la app Oposición TCEE · DCE. Forma parte de la skill «EconomIA»: solo para la preparación personal del opositor en su propia cuenta de Claude. No se autoriza copiarlo, redistribuirlo ni usarlo en otras plataformas o sistemas de IA (ver LICENCIA.md).*

# 3.A.11. Teoría de la producción. Caracterización de la tecnología de la empresa a corto y largo plazo. El conjunto de posibilidades de producción. La función de producción. Rendimientos locales y globales a escala. Elasticidad de sustitución. Producción conjunta.

*Ficha de repaso · actualizada el 18/10/2026*

## Esquema del cante

- **Introducción** · 2′30″

- **I. La tecnología: función de producción** · 10′

- 1. Conjunto tecnológico $\mathcal{Y}$ y sus axiomas · 3′

- 2. Función de producción: propiedades y curvatura · 2′30″

- 3. Isocuantas: RMST, $\sigma$; CD, CES, Leontief · 4′30″

- **II. Leyes temporales de la producción** · 11′30″

- 1. Corto plazo: productividad y etapas · 4′

- 2. Largo plazo: rendim. globales y locales · 5′

- 3. Muy largo plazo: progreso técnico · 2′30″

- **III. Empresa multiproducto** · 4′30″

- 1. Caja de Edgeworth, curva de contrato, FPP · 2′30″

- 2. Producción conjunta: $T(\mathbf{y})\leq 0$, RMT · 2′

- **Conclusión** · 1′30″

*Hilo*: qué es posible (I) $\to$ cómo varía con el plazo (II) $\to$ con varios productos (III). *Pizarra*: $F$ y $\sigma$ recuadradas en la esquina de I.2 al final; la superficie con los 3 plazos une los bloques (curvas de nivel = isocuantas; cortes = plazos).

## Introducción (2′30″)

- **Enganche**: ¿puede una sola función resumir lo que una empresa sabe hacer? Fábrica de alfileres de Smith (1776): 10 operarios, 18 operaciones, $>$48.000 alfileres/día ($\approx$4.800 por persona) frente a $<$20 cada uno solo $\Rightarrow$ organización y escala multiplican la producción. ¿Qué puede producir la empresa y cómo cambia con sus factores, su tamaño o su tecnología?

- **Relevancia**: *micro* (costes, oferta, demanda y remuneración de factores [ver tema 3.A.12][ver tema 3.A.25]); *macro* (crecimiento [ver tema 3.A.43], productividad total de los factores (PTF) [ver tema 3.A.45], ciclo real); *internacional* (Ricardo, Heckscher-Ohlin, intraindustrial [ver tema 3.B.5][ver tema 3.B.6]); *política* ($\sigma$ y automatización frente a participación del trabajo; rendimientos y monopolio natural [ver tema 3.A.17]).

- **Contextualización**: Hesíodo, Jenofonte $\to$ Turgot (1767), proporciones variables $\to$ rendim. decrecientes de la tierra (1815) $\to$ Walras, Pareto: producción = intercambio indirecto; Wicksteed, Clark, Wicksell: función de producción $\to$ Marshall (plazos); Sraffa (1926) $\to$ competencia imperfecta [ver tema 3.A.18] $\to$ Cobb-Douglas (1928), $\sigma$ (Hicks, Robinson), CES (1961) $\to$ Koopmans (1951), Debreu (1959): conjunto de producción; dualidad (Shephard, Uzawa).

- **Problemática**: ¿cómo representar lo que la empresa *puede* producir y qué supuestos llevan a una función manejable? ¿Cómo responde la producción si cambia un factor, todos o la tecnología? ¿Cómo medir sustitución y escala; por qué rendimientos distintos según el tamaño? ¿Qué cambia con varios productos?

- **Estructura**: I. tecnología ($\mathcal{Y}$, $F$, isocuantas); II. leyes temporales (corto, largo, muy largo plazo); III. empresa multiproducto. Orden distinto del título, deliberado: los plazos son el hilo y $\sigma$ va con las isocuantas (mide su curvatura).

- **Individualismo metodológico**: lo agregado (oferta de un mercado, crecimiento) desde agentes individuales que optimizan [ver tema 3.A.8].

- **Teoría de la empresa**: transforma factores (*inputs*) en productos (*outputs*) con 3 restricciones: *técnicas* (**teoría de la producción**, este tema), *económicas* (costes [ver tema 3.A.12]) y *de mercado y organizativas* [ver tema 3.A.15][ver tema 3.A.16-19].

## I. La tecnología: definición y propiedades de la función de producción (10′)

- *Nexo*: planteadas las preguntas, empezamos por la tecnología en sí: cómo se representa lo que la empresa puede producir.

- *Conclusión anticipada*: pocos axiomas sobre los planes posibles dan una función de producción; sus isocuantas miden con un solo número, $\sigma$, la facilidad para sustituir factores.

- *Método*: el del consumidor [ver tema 3.A.8] en 3 pasos: $\mathcal{Y}$ y axiomas $\to$ $F$ (un producto) $\to$ isocuantas y sustitución. Con precios de los factores: costes y dualidad [ver tema 3.A.12].

### I.1. Conjunto tecnológico: el conjunto de posibilidades de producción

- *Definición*: **conjunto de posibilidades de producción** (o **tecnológico**) $\mathcal{Y}\subset\mathbb{R}^S$: todos los planes que permite la tecnología (Mas-Colell-Whinston-Green, 1995, cap. 5). Forma más general: no presupone cuántos bienes ni cuáles son factores.

- *Plan*: **vector de producción neta** (*netput*) $\mathbf{y}=(y_1,\dots,y_S)$: negativos = factores; positivos = productos. Un bien puede ser factor en un plan y producto en otro.

- *Requerimientos*: **conjunto de requerimientos de factores** $V(q)=\{\mathbf{z}\geq\mathbf{0}:(q,-\mathbf{z})\in\mathcal{Y}\}$; su frontera, la isocuanta (I.3).

- *Axiomas básicos* (necesarios para $F$): (1) **no vacío**; (2) **cerrado**: incluye su frontera $\Rightarrow$ *máximo* de $q$ para cada $\mathbf{z}$; (3) **eliminación gratuita**: $\mathbf{y}'\leq\mathbf{y}\in\mathcal{Y}$ $\Rightarrow$ $\mathbf{y}'\in\mathcal{Y}$: todo el «sudoeste» es posible, frontera no creciente; (4) **imposibilidad de producción gratuita**: $\mathcal{Y}\cap\mathbb{R}^S_+\subseteq\{\mathbf{0}\}$.

- *Deseables*: **posibilidad de inacción** $\mathbf{0}\in\mathcal{Y}$ (no con costes hundidos: propiedad del LP) $\Rightarrow$ $\mathcal{Y}\cap\mathbb{R}^S_+=\{\mathbf{0}\}$, frontera por el origen; y convexidad (I.2).

- *Eficiencia*: la frontera = planes **técnicamente eficientes**: no se obtiene más de un producto sin más de algún factor o menos de otro producto.

*[Gráfico: $\mathcal{Y}$ en el plano de los *netputs*: cada rasgo de su forma, un axioma]*

### I.2. La función de producción

- *Definición*: definido $\mathcal{Y}$, con un producto, relación técnica que asigna a cada $\mathbf{z}\geq\mathbf{0}$ la *máxima* producción posible (existe porque $\mathcal{Y}$ es cerrado):

$$q=F(\mathbf{z})\equiv\begin{array}{rl}\max_{q\geq 0} & q \\ \text{s.a.} & (q,-\mathbf{z})\in\mathcal{Y}\end{array}$$

- *Métodos*: solo los **técnicamente eficientes**: máx. $q$ para cada $\mathbf{z}$ = mín. factores para cada $q$. Con $L$ y $K$, **superficie de producción**; debajo, planes posibles; encima, imposibles.

- *Propiedades generales*: (1) *cardinal* (unidades físicas, $\neq$ utilidad); (2) $F(\mathbf{0})=0$; (3) no decreciente, $\mathrm{PMg}_i\equiv\partial F/\partial z_i\geq0$ (productividad marginal); (4) continua y dos veces diferenciable (supuesto instrumental: factores sustituibles, infinitas técnicas, producto divisible).

*[Gráfico: $F(z_L,z_K)$: superficie sobre el plano de los factores]* · *[Gráfico: $\mathcal{Y}$ convexo: si $\mathbf{a}$, $\mathbf{b}$ posibles, también $\mathbf{c}$]*

- *Propiedades de escala* de $\mathcal{Y}$ (deciden la curvatura y los rendim. *globales*): **divisibilidad** ($\lambda\mathbf{y}$, $\lambda\in[0,1]$: rendim. no crecientes); **aditividad** ($\mathbf{y}+\mathbf{y}'$, libre entrada: no decrecientes); **rendimientos constantes** ($\lambda\geq0$: $\mathcal{Y}$ *cono*); **convexidad** ($\tau\mathbf{y}+(1-\tau)\mathbf{y}'\in\mathcal{Y}$; con inacción $\Rightarrow$ divisibilidad); **irreversibilidad** ($-\mathbf{y}\notin\mathcal{Y}$). Aditivo y divisible $\Leftrightarrow$ cono convexo (MWG, 5.B.2).

- *Complementariedad*: $F$ **estrictamente cuasicóncava** $\Leftrightarrow$ isocuantas estr. convexas (mezclas rinden más que extremos); *no impone escala*. $\neq$ complementariedad de Edgeworth, $\partial^2F/\partial z_L\partial z_K>0$.

- *Escala*: con un producto, $\mathcal{Y}$ convexo $\Leftrightarrow$ $F$ **cóncava**; con $F(\mathbf{0})=0$ $\Rightarrow$ rendim. no crecientes. Cóncava $\Rightarrow$ cuasicóncava, no al revés (CD con $\alpha+\beta>1$).

- *Buen comportamiento*: **función neoclásica**: rendimientos constantes a escala (RCE), $\mathrm{PMg}>0$ y decrecientes y condiciones de Inada (1963). Cóncava, no estrictamente (lineal en cada rayo).

Inada:  $\displaystyle\lim_{z_i\to0}\mathrm{PMg}_i=+\infty,\qquad \lim_{z_i\to\infty}\mathrm{PMg}_i=0$

- *Por qué importa*: el beneficio no tiene renta que lo acote. Con RCE, $B(\lambda\mathbf{z})=\lambda B(\mathbf{z})$: no acotado, no producir o máximo 0 con escala indeterminada (oferta = correspondencia); crecientes: no acotado; solo concavidad estricta da oferta función. Minimizar costes solo exige cuasiconcavidad $\Rightarrow$ $C$ existe con cualquier rendimiento [ver tema 3.A.12].

### I.3. Las curvas isocuantas

- *Definición*: caracterizada $F$, sus curvas de nivel: **isocuanta** $\{\mathbf{z}:F(\mathbf{z})=\overline{q}\}$: combinaciones que, usadas eficientemente, dan igual $q$; frontera de $V(\overline{q})$; corte horizontal de la superficie proyectado en la base.

- *Propiedades* (como las curvas de indiferencia [ver tema 3.A.8]): infinitas; más lejos = más $q$ (monotonía); no se cortan ($F$ es función); continuas; pendiente $\leq0$ ($<0$ si $\mathrm{PMg}>0$); convexas si $F$ cuasicóncava; pero *cardinales*.

- *Pendiente*: **relación marginal de sustitución técnica** (RMST): capital que se libera al usar una unidad más de trabajo, con $q$ constante. Decrece al $\uparrow z_L$ (isocuanta convexa); depende de las unidades.

$\mathrm{RMST}_{LK}\equiv-\left.\dfrac{dz_K}{dz_L}\right|_{q=\overline{q}}=\dfrac{\mathrm{PMg}_L}{\mathrm{PMg}_K}$

- *Isoclinas*: **isoclinas**: unen puntos de igual RMST; rectas por el origen si $F$ homotética; lo son las líneas de contorno (II.1) y la senda de expansión [ver tema 3.A.12].

- *Elasticidad de sustitución*: **elasticidad de sustitución**: número puro que mide la *curvatura* de la isocuanta (Hicks 1932, Robinson 1933, por separado):

$$\sigma\equiv\frac{d\ln(z_K/z_L)}{d\ln \mathrm{RMST}_{LK}}\geq 0$$

- *Curvatura*: $\sigma\uparrow$ $\Rightarrow$ isocuanta más plana, sustitución más fácil (PMg poco sensibles a la proporción). Sustitutivos perfectos: $\sigma=\infty$; coeficientes fijos: $\sigma=0$.

- *Interpretación económica*: minimizando costes, $\mathrm{RMST}_{LK}=w_L/w_K$ $\Rightarrow$ $\sigma=d\ln(z_K/z_L)/d\ln(w_L/w_K)$: % de sustitución de $L$ por $K$ si el salario relativo sube un 1 %.

- *Distribución*: $\dfrac{w_Lz_L}{w_Kz_K}=\dfrac{w_L/w_K}{z_K/z_L}$; si $w_L/w_K\uparrow$: participación del trabajo $\uparrow$ si $\sigma<1$, $\downarrow$ si $\sigma>1$, igual si $\sigma=1$ (Hicks).

*[Gráfico: Isocuanta convexa: la RMST decrece de $A$ a $B$]* · *[Gráfico: CES: de $\sigma=0$ (Leontief) a $\sigma=\infty$ (lineal)]*

**a) Cobb-Douglas** (la más usada del temario)

- *Idea*: forma más sencilla con buen comportamiento; nombre por Cobb-Douglas (1928), que la estiman; la forma, ya en Wicksell (1901) y von Thünen.

- *Supuestos*: $q=A\,z_K^{\alpha}z_L^{\beta}$, $A,\alpha,\beta>0$; $A$ nivel tecnológico; $\alpha,\beta$ elasticidades-producto.

- *Desarrollo*: $\mathrm{PMg}_K=\alpha\,q/z_K$, $\mathrm{PMg}_L=\beta\,q/z_L$ (exponente $\times$ PMe); cumple Inada $\Rightarrow$ toda en la región económica; $\mathrm{RMST}_{LK}=\frac{\beta}{\alpha}\frac{z_K}{z_L}$ $\Rightarrow$ $\sigma=1$; homogénea de grado $\alpha+\beta$.

- *Implicaciones*: con RCE y pago según PMg (Euler), participaciones constantes $\alpha$ y $1-\alpha$ $\Rightarrow$ $Y=AK^{\alpha}L^{1-\alpha}$ [ver tema 3.A.43][ver tema 3.A.45]; las 3 neutralidades del progreso técnico coinciden (II.3).

- *Evidencia*: industria de EE. UU. 1899-1922: $q\approx1{,}01\,z_K^{1/4}z_L^{3/4}$: RCE y exponentes $\approx$ participaciones.

- *Valoración*: impone $\sigma=1$ y participaciones que no responden a los precios $\Rightarrow$ hace falta la CES.

**b) CES** (elasticidad de sustitución constante)

- *Idea*: generaliza la CD a cualquier $\sigma$ constante; Arrow-Chenery-Minhas-Solow (ACMS, 1961); Solow (1956) ya la usa de ejemplo.

- *Supuestos*: $q=A\big[\sum_ia_iz_i^{\rho}\big]^{\nu/\rho}$, $\rho\equiv\frac{\sigma-1}{\sigma}$, $\sum_ia_i=1$.

- *Desarrollo*: homogénea de grado $\nu$ (habitual $\nu=1$); $\mathrm{RMST}_{LK}=\frac{a_L}{a_K}\big(\frac{z_K}{z_L}\big)^{1-\rho}$ $\Rightarrow$ $\sigma=\frac{1}{1-\rho}$. *Límites*, no casos (en $\rho=0$ no está definida; L’Hôpital): $\rho\to1$ lineal ($\sigma\to\infty$); $\rho\to0$ CD; $\rho\to-\infty$ Leontief ($\sigma\to0$).

- *Implicaciones*: participaciones que varían con los precios $\Rightarrow$ forma para estimar $\sigma$. $\sigma>1$: ningún factor imprescindible [ver tema 3.A.44]; agregador de Dixit-Stiglitz [ver tema 3.A.18].

- *Evidencia*: $\sigma_{KL}<1$ (datos clave); agregada $\neq$ de planta (reasignación). CD: comodidad, no hecho empírico.

- *Valoración*: $\sigma$ igual en todos los puntos y pares $\Rightarrow$ formas flexibles (translog, anexo).

**c) Coeficientes fijos (Leontief)**

- *Idea*: límite $\sigma\to0$: sin sustitución; Cassel (1918); Leontief (1936): tablas *input-output* [ver tema 3.A.31].

- *Supuestos*: $q=\min\{z_K/a;\,z_L/b\}$, coeficientes técnicos $a,b>0$.

- *Desarrollo*: isocuantas en ángulo recto, vértice en $z_K/z_L=a/b$; el factor sobrante tiene PMg nula; RMST $0$ o $\infty$, $\sigma=0$; RCE.

- *Implicaciones*: proporción independiente de los precios; $C=(a\,w_K+b\,w_L)\,q$ [ver tema 3.A.12].

- *Extensiones*: varias técnicas $\Rightarrow$ isocuantas poligonales: *análisis de actividades* (Koopmans, 1951), enlace con $\mathcal{Y}$.

- *Valoración*: útil si la sustitución es despreciable (CP, intersectorial); a LP sí se sustituye.

> Pocos axiomas sobre $\mathcal{Y}$ dan $F$; sus isocuantas miden la sustitución con la RMST y, sin unidades, con $\sigma$: de 0 (Leontief) a $\infty$ (lineal), con la CD en $\sigma=1$. La superficie de producción es el mapa del bloque II: cada plazo, un corte.

## II. Análisis de la función de producción: las leyes temporales (11′30″)

- *Nexo*: caracterizada la tecnología, pasamos a cómo varía lo posible según el plazo.

- *Conclusión anticipada*: los 3 plazos de Marshall son 3 cortes de la superficie: CP, rendim. decrecientes; LP, rendim. a escala globales o locales; muy LP, progreso técnico, cuya neutralidad depende de qué se mantenga constante.

- *Plazos* (Marshall, 1890, libro V): grados de libertad, no calendario. *Corto*: algún factor fijo ($z_K=\overline{z}_K$), corte por un plano: **productividad**. *Largo*: todos variables, corte por un rayo: **rendimientos a escala**. *Muy largo*: la superficie se desplaza: **progreso técnico**.

*[Gráfico: Los 3 plazos sobre la superficie de producción]*

### II.1. Corto plazo: productividad

- *Conjunto*: $\mathcal{Y}(\overline{z}_K)=\{\mathbf{y}\in\mathcal{Y}:z_K=\overline{z}_K\}\subseteq\mathcal{Y}$ $\Rightarrow$ $q^{\mathrm{LP}}\geq q^{\mathrm{CP}}$; coste LP = envolvente de los de CP [ver tema 3.A.12]; sin inacción si hay coste hundido.

- *Función*: **rendimientos marginales mixtos**: $q$ crece a ritmo creciente, luego decreciente, máximo y cae (**ley de las proporciones variables**, Turgot).

- *Advertencia*: *incumple la eliminación gratuita* (PMg $<0$); no es neoclásica. Lo malo no es PMg decreciente, sino negativa. Se mantiene por motivo *histórico* (Cassels, 1936, anterior a la axiomática) y *didáctico* (delimita la región económica).

- **Líneas de contorno**: $\mathrm{PMg}_K=0$ (arriba) y $\mathrm{PMg}_L=0$ (abajo); isoclinas con RMST $\infty$ y 0.

- **Región económica**: entre ellas, ambas PMg $>0$: zona de sustitución. Fuera, lo mismo con más de algún factor. Con Inada (CD), toda la función.

- **Productividad media** (PMe): pendiente del rayo desde el origen al producto total (PT).

- **Productividad marginal** (PMg): pendiente de la tangente al PT; máx. en su inflexión, 0 en el máx. del PT.

- **Elasticidad-producto**: % de $q$ ante un 1 % más de factor variable.

$\mathrm{PMe}_L=\dfrac{q}{z_L}$,$\mathrm{PMg}_L=\dfrac{\partial F(z_L,\overline{z}_K)}{\partial z_L}$,$\varepsilon_{q,z_L}=\dfrac{\mathrm{PMg}_L}{\mathrm{PMe}_L}$
$\dfrac{d\mathrm{PMe}_L}{dz_L}=\dfrac{\mathrm{PMg}_L-\mathrm{PMe}_L}{z_L}$  $\Rightarrow$  $\mathrm{PMg}_L=\mathrm{PMe}_L$ en el máx. de la PMe

- *Etapas* (Cassels, 1936): *I*, demasiado factor fijo, producción extensiva; con RCE, Euler: $\mathrm{PMe}_L=\mathrm{PMg}_L+\mathrm{PMg}_K\,z_K/z_L$ $\Rightarrow$ $\mathrm{PMg}_K<0$. *II*: región económica; aquí produce la empresa (punto según precios [ver tema 3.A.16]). *III*: demasiado factor variable; reducir $z_L$ aumenta $q$.

| *Tramo* | *Productividades* | $\varepsilon_{q,z_L}$ | *Producción* |
|:---|:--:|:--:|:---|
| Etapa I | $\mathrm{PMg}_L>\mathrm{PMe}_L$ | $>1$ | extensiva |
| Margen extensivo | $\mathrm{PMg}_L=\mathrm{PMe}_L$ máx. | $=1$ | óptimo técnico |
| Etapa II | $0<\mathrm{PMg}_L<\mathrm{PMe}_L$ | $(0,1)$ | región económica |
| Margen intensivo | $\mathrm{PMg}_L=0$, máx. $q$ | $=0$ | máximo técnico |
| Etapa III | $\mathrm{PMg}_L<0$ | $<0$ | intensiva |

*[Gráfico: Región económica entre las líneas de contorno]* · *[Gráfico: PT (arriba), PMe y PMg (abajo): etapas]*

### II.2. Largo plazo: rendimientos a escala

- *Nexo*: estudiado el CP, pasamos al LP: todos los factores variables; corte por un rayo desde el origen.

- *Definición*: $\mathbf{z}\to\lambda\mathbf{z}$, $\lambda$ = **factor de escala**. Para $\lambda>1$, $F(\lambda\mathbf{z})\gtreqless\lambda F(\mathbf{z})$: rendim. *crecientes*, *constantes*, *decrecientes*. Isocuantas $q,2q,3q$ en un rayo: cada vez más juntas, equidistantes, más separadas.

- *Causas* (Varian): crecientes: especialización (Smith), indivisibilidades, relaciones físicas (tubería: diámetro $\times2$ $\Rightarrow$ sección $\times4$); decrecientes: coordinación, factores no ampliables (en rigor, proporciones variables).

- *Medida*: **elasticidad de escala** (coeficiente de la función): % de $q$ ante un 1 % más de todos los factores; $>$, $=$, $<1$.

$\varepsilon_{q,\lambda}(\mathbf{z})\equiv\left.\dfrac{d\ln F(\lambda\mathbf{z})}{d\ln\lambda}\right|_{\lambda=1}=\dfrac{\sum_i\mathrm{PMg}_iz_i}{F(\mathbf{z})}=\sum_i\varepsilon_{q,z_i}$
Homogénea: $F(\lambda\mathbf{z})=\lambda^kF(\mathbf{z})$;Euler: $\sum_i\mathrm{PMg}_iz_i=kF(\mathbf{z})$

*[Gráfico: Isocuantas sobre un rayo: crecientes, constantes, decrecientes y variables]*

- **Rendimientos globales**: propiedad de *toda* la tecnología ($\forall\mathbf{z}$, $\lambda>1$) = propiedad de escala de $\mathcal{Y}$ (cono, divisibilidad, aditividad). Caso: **homogénea de grado $k$**: $\varepsilon_{q,\lambda}=k$ siempre; PMg de grado $k-1$; RMST de grado 0. Con $k=1$, pagar la PMg agota el producto (Wicksteed).

- **Rendimientos locales**: en un punto, con $\varepsilon_{q,\lambda}(\mathbf{z})$ = suma de elasticidades-producto: une CP (eje) y LP (rayo). CD: $\alpha+\beta$.

- **Rendimientos variables**: *regular ultra passum law* (Frisch, 1965) o «wicksellianos»: crecientes de pequeña (indivisibilidades), constantes, decrecientes de grande. Ejemplo (Jehle-Reny): $q=\dfrac{\kappa}{1+z_L^{-a}z_K^{-b}}$$\Rightarrow$$\varepsilon_{q,\lambda}=(a+b)\Big(1-\dfrac{q}{\kappa}\Big)$

- Crecientes si $q<\kappa\frac{a+b-1}{a+b}$ ($a+b>1$). Homotética, no homogénea: tecnología «en S» $\to$ CMe en U [ver tema 3.A.12].

- *Homotéticas*: $F=g(h(\mathbf{z}))$, $h$ homogénea de grado 1, $g$ creciente: isoclinas rectas; $\varepsilon_{q,\lambda}$ depende solo de $q$. Homogénea $\Rightarrow$ homotética, no al revés: $\ln(1+z_K^{1/2}z_L^{1/2})$.

- *Economías de escala*: $\neq$ rendimientos: propiedad de los costes. En la senda de mínimo coste, $\varepsilon_{q,\lambda}=\mathrm{CMe}/\mathrm{CMg}$ (coste medio / coste marginal; Hanoch, 1975); coinciden punto a punto si homotética [ver tema 3.A.12].

- *RCE*: tamaño de la empresa indeterminado; lo deciden demanda o entrada [ver tema 3.A.16].

- *Evidencia*: industria de EE. UU. (2 dígitos): rendim. constantes o algo decrecientes, mayores al agregar (Basu-Fernald, 1997) $\Rightarrow$ avala RCE agregados.

### II.3. Muy largo plazo: progreso técnico

- *Nexo*: con la tecnología dada en CP y LP; ahora cambia la propia tecnología.

- *Concepto*: **progreso técnico**: cambios en los métodos; innovaciones de *proceso* (más con lo mismo) y de *producto* (calidad, bienes nuevos). Amplía $\mathcal{Y}$: $F\uparrow$, isocuantas hacia el origen.

- *Clasificación* (Hicks, 1932, por el reparto): **neutral** si no altera una relación concreta entre PMg; **sesgado** (ahorrador de trabajo o de capital) si la altera.

Hicks: $A_tF(z_K,z_L)$;Solow: $F(A_tz_K,z_L)$;Harrod: $F(z_K,A_tz_L)$
CD: $A_tz_K^{\alpha}z_L^{\beta}=\big(A_t^{1/\alpha}z_K\big)^{\alpha}z_L^{\beta}=z_K^{\alpha}\big(A_t^{1/\beta}z_L\big)^{\beta}$

- **Neutral de Hicks** (aumentador del producto): RMST constante para $z_K/z_L$ dado; isocuantas hacia el origen sin cambiar de pendiente en cada rayo. RMST $\uparrow$ $\Rightarrow$ ahorrador de capital; $\downarrow$, de trabajo. Base de la PTF [ver tema 3.A.45].

- **Neutral de Solow** (aumentador del capital): participaciones constantes para $z_L/q$ dado.

- **Neutral de Harrod** (aumentador del trabajo, 1948): participaciones constantes para $z_K/q$ dado.

*[Gráfico: Neutralidad de Hicks (A), Solow (B) y Harrod (C)]*

- *Relación*: no jerarquía, 3 criterios con 3 proporciones constantes; coinciden en la CD.

- *Teorema de Uzawa* (1961): crecimiento equilibrado con RCE exige progreso aumentador del trabajo $\Rightarrow$ el modelo de Solow lo supone [ver tema 3.A.43].

- *Aumentar $\neq$ sesgar*: con $\sigma<1$, el aumentador del capital eleva más la PMg del trabajo: sesgado hacia el trabajo (Acemoglu). Sesgo sectorial $\to$ comercio y relación real de intercambio [ver tema 3.B.9].

> Cada plazo es un corte de la superficie: a CP, la ley de rendimientos decrecientes delimita la región económica y las etapas; a LP, la elasticidad de escala, global o local, mide la respuesta al tamaño; a muy LP, el progreso técnico desplaza la tecnología, neutral o sesgado.

## III. Empresa multiproducto: curva de contrato (4′30″)

- *Nexo*: vista la producción de un bien en cada plazo, pasamos a la empresa que obtiene varios.

- *Conclusión anticipada*: estar en la isocuanta de cada producto ya no basta: hay que asignar bien los factores (curva de contrato); la frontera es una función de transformación, y su pendiente, la RMT, el coste de oportunidad.

### III.1. Caja de Edgeworth: curva de contrato y FPP

- *Idea*: varios productos con procesos *separables* (una planta cada uno, o empresas de una economía): la frontera sale de *asignar* los factores. Construcción del equilibrio general [ver tema 3.A.21], resumida.

- *Supuestos*: $X=F_X(L_X,K_X)$, $Y=F_Y(L_Y,K_Y)$; $L_X+L_Y=\overline{L}$, $K_X+K_Y=\overline{K}$.

- *Desarrollo*: **caja de Edgeworth**: mapa de $Y$ girado 180° sobre el de $X$, lados $\overline{L}$ y $\overline{K}$. Si las isocuantas se cortan ($A$), reasignando: más $X$ con igual $Y$ ($B$) o más $Y$ con igual $X$ ($C$). **Eficiencia técnica** (de Pareto en la producción): tangencia, $\mathrm{RMST}^X_{LK}=\mathrm{RMST}^Y_{LK}$; lugar de tangencias = **curva de contrato** [ver tema 3.A.22] $\to$ **frontera de posibilidades de producción** (FPP).

*[Gráfico: Caja de Edgeworth, curva de contrato y FPP]*

$\mathrm{RMT}_{XY}\equiv-\dfrac{dY}{dX}=\dfrac{\mathrm{PMg}^Y_L}{\mathrm{PMg}^X_L}=\dfrac{\mathrm{PMg}^Y_K}{\mathrm{PMg}^X_K}=\dfrac{\mathrm{CMg}_X}{\mathrm{CMg}_Y}$

- *Implicaciones*: **relación marginal de transformación** (RMT) = coste de oportunidad de una unidad más de $X$. RMST: pendiente de la isocuanta (2 factores, 1 producto); RMT: de la frontera (2 productos, factores dados).

- *Forma de la FPP*: decreciente; rendim. decrecientes $\Rightarrow$ estr. cóncava; RCE: cóncava si intensidades distintas, *lineal* si iguales; crecientes: puede ser convexa [ver tema 3.B.6]. Progreso técnico y dotaciones: hacia fuera.

- *Extensiones*: competencia perfecta: $p_j\mathrm{PMg}^j_i=w_i$ $\Rightarrow$ $\mathrm{RMST}^X=\mathrm{RMST}^Y=w_L/w_K$ (en la curva de contrato) y $\mathrm{RMT}=p_X/p_Y$.

- *Valoración*: procesos separables: no recoge un proceso con varios productos.

### III.2. La empresa multiproducto y la producción conjunta

- *Idea*: **empresa multiproducto**: varios productos con los mismos factores. $\mathcal{Y}$ la admite sin cambios (más de un componente positivo); lo que no sirve es $F$.

- *Supuestos*: **función de transformación**: $\mathcal{Y}=\{\mathbf{y}:T(\mathbf{y})\leq0\}$, $T=0$ en los planes eficientes; un producto: $T(q,-\mathbf{z})=q-F(\mathbf{z})$.

- *Desarrollo*: con 2 productos y $\overline{\mathbf{z}}$, **curva de transformación** $T(q_1,q_2,-\overline{\mathbf{z}})=0$; su pendiente, la RMT de la empresa. $\mathcal{Y}$ convexo $\Rightarrow$ cóncava, RMT $\uparrow$ al especializarse; más factores o progreso: hacia fuera.

$\mathrm{RMT}_{12}\equiv-\left.\dfrac{dq_2}{dq_1}\right|_{T=0}=\dfrac{\partial T/\partial q_1}{\partial T/\partial q_2}$;óptimo: $\mathrm{RMT}_{12}=\dfrac{p_1}{p_2}$

*[Gráfico: Curva de transformación de la empresa y RMT]*

- *Implicaciones*: **producción conjunta** estricta (un proceso, varios productos): *proporciones fijas* (carne y cuero, trigo y paja: oferta conjunta de Marshall; frontera = punto o ángulo recto; sin imputación técnica del coste) o *variables* (refino del petróleo; ganadería de lana o carne). Con precios, isobeneficio tangente: $\mathrm{RMT}_{12}=p_1/p_2$.

- *Extensiones*: **economías de alcance** (Panzar-Willig, 1981): $C(q_1,q_2)<C(q_1,0)+C(0,q_2)$, por factores compartidos (instalaciones, marca, conocimiento) $\Rightarrow$ con las de escala, subaditividad y monopolio natural multiproducto [ver tema 3.A.17]; límites de la empresa [ver tema 3.A.15].

- *Valoración*: $T$ generaliza $F$, pero solo dice qué es posible; qué se elige depende de los precios.

> Con varios productos, la eficiencia exige además igualar las RMST (curva de contrato); la frontera es $T(\mathbf{y})=0$ y su pendiente, la RMT, el coste de oportunidad.

## Conclusión (1′30″)

- **Recapitulación**: (1) axiomas $\to$ $F$ e isocuantas, RMST y $\sigma$; CD, CES y Leontief; (2) plazos de Marshall: rendim. decrecientes (CP), a escala globales o locales (LP), progreso técnico (muy LP); (3) varios productos: curva de contrato, FPP y función de transformación.

- **Relevancia**: la forma de $F$ decide resultados: con RCE el producto se agota y las participaciones dependen de $\sigma$; caída de la del trabajo desde los 80 (Karabarbounis-Neiman, 2014), difícil con $\sigma=1$; Harrod y crecimiento equilibrado; rendim. crecientes $\to$ crecimiento endógeno y nuevo comercio.

- **Extensiones**: costes y dualidad [ver tema 3.A.12]; oferta [ver tema 3.A.16-19]; bienestar [ver tema 3.A.22]; controversia de los dos Cambridge [ver tema 3.A.4]; comercio [ver tema 3.B.5][ver tema 3.B.6].

- **Opinión**: idealización poderosa, pero la empresa como *caja negra*; lo de dentro, teoría de la empresa y organización industrial [ver tema 3.A.15].

- **Idea final**: ¿una función resume lo que sabe hacer la empresa? Lo que *puede* producir, no lo que producirá ni cómo se organiza: el mapa de lo técnicamente posible sobre el que precios, costes y mercados trazan la elección.

## Autores y fechas

**1767** Turgot: ley de las proporciones variables

**1890** Marshall: plazos; oferta conjunta

**1894** Wicksteed: $P=f(a,b,c,\dots)$; agotamiento del producto

**1928** Cobb-Douglas: primera estimación

**1932** Hicks: $\sigma$ y neutralidad; 1933 Robinson: $\sigma$

**1936** Cassels: 3 etapas; Leontief: *input-output*

**1948** Harrod: progreso aumentador del trabajo

**1951** Koopmans: análisis de actividades

**1959** Debreu: enfoque axiomático

**1961** ACMS: CES; Uzawa: teorema de neutralidad

**1965** Frisch: *regular ultra passum law*

**1975** Hanoch: $\varepsilon_{q,\lambda}=\mathrm{CMe}/\mathrm{CMg}$

**1981** Panzar-Willig: economías de alcance

## Datos clave

- $\sigma$ capital-trabajo: **0,4-0,6** (Chirinko, 2008); **$\approx$0,3** (Gechert et al., 2022); manufacturas, agregada **0,5-0,7** (Oberfield-Raval, 2021).

- Remuneración de asalariados en España: **48,4 % del PIB** (Eurostat, 2025); **56,6 %** (AMECO, ajustada por autónomos).

## Preguntas del tribunal

1.  **¿Por qué una función con PMg $<0$?** Historia (Cassels, anterior a la axiomática) y didáctica: delimita la región económica.

2.  **¿Cuasiconcavidad o concavidad?** Cuasiconcavidad: isocuantas convexas, nada de escala; concavidad: rendim. no crecientes. Para maximizar el beneficio no basta la primera.

3.  **¿PMg decrecientes y rendimientos crecientes a la vez?** Sí: CD con $\alpha,\beta<1$ y $\alpha+\beta>1$.

4.  **¿Rendimientos globales y locales?** Globales: todo $\mathbf{z}$ (homogéneas, $\varepsilon_{q,\lambda}=k$); locales: $\varepsilon_{q,\lambda}(\mathbf{z})=\sum\varepsilon_{q,z_i}$, cambian con la escala.

5.  **¿Rendimientos y economías de escala?** Tecnología frente a costes; $\varepsilon_{q,\lambda}=\mathrm{CMe}/\mathrm{CMg}$ en la senda de mínimo coste.

6.  **¿Qué pasa con el beneficio con RCE?** Homogéneo de grado 1 $\Rightarrow$ no acotado, no producir o máximo 0; escala indeterminada, oferta correspondencia.

> **Ojo en el test.**
>
> - Imposib. de producción gratuita: $\mathcal{Y}\cap\mathbb{R}^S_+\subseteq\{\mathbf{0}\}$; con inacción, $=\{\mathbf{0}\}$.
>
> - Etapas: Cassels (1936), no Cassel (1918). Margen extensivo = máx. PMe ($\varepsilon_{q,z_L}=1$); intensivo = máx. PT ($\varepsilon_{q,z_L}=0$).
>
> - Isocuantas convexas $\Leftarrow$ cuasiconcavidad; rendim. no crecientes $\Leftarrow$ concavidad. Neoclásica con Inada: cóncava, *no estrictamente*.
>
> - $\sigma=0$ Leontief, 1 CD, $\infty$ lineal: *límites* de la CES, $\sigma=1/(1-\rho)$.
>
> - Hicks: $z_K/z_L$; Solow: $z_L/q$; Harrod: $z_K/q$; coinciden en la CD. Con $\sigma<1$, $w_L/w_K\uparrow$ $\Rightarrow$ participación del trabajo $\uparrow$.
