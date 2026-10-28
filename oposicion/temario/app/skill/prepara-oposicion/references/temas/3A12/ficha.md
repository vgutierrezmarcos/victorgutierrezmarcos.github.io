<!-- Material exclusivo de victorgutierrezmarcos.es y la app Oposición TCEE · DCE. Forma parte de la skill «Prepara con Claude»: solo para la preparación personal del opositor en su propia cuenta de Claude. No se autoriza copiarlo, redistribuirlo ni usarlo en otras plataformas o sistemas de IA (ver LICENCIA.md). -->
*Material exclusivo de victorgutierrezmarcos.es y la app Oposición TCEE · DCE. Forma parte de la skill «Prepara con Claude»: solo para la preparación personal del opositor en su propia cuenta de Claude. No se autoriza copiarlo, redistribuirlo ni usarlo en otras plataformas o sistemas de IA (ver LICENCIA.md).*

# 3.A.12. Teoría de los costes. Análisis de dualidad en el ámbito de la empresa. Aplicaciones empíricas.

*Ficha de repaso · actualizada el 17/10/2026*

## Esquema del cante

- **Introducción** · 2′30″

- **I. «Dualidad» MB–MC. Función de costes** · 9′

- 1. Ingredientes comunes (papeles cambiados) · 1′30″

- 2. MB $\to B(p,\mathbf{w})$; MC $\to C(\mathbf{w},q)$ · 5′

- 3. Relaciones de «dualidad»; $C\leftrightarrow F$, $B\leftrightarrow\mathcal{Y}$ · 2′30″

- **II. Estática comparativa, plazos y empírica** · 14′

- 1. $\Delta q$ (escala) y $\Delta\mathbf{w}$ (sustitución) · 4′

- 2. Corto y largo plazo; Le Chatelier · 4′30″

- 3. Estimación por dualidad: translog · 2′

- 4. Economías de escala en los datos · 1′30″

- 5. Eficiencia: Farrell, SFA y DEA · 2′

- **III. Extensiones y críticas** · 3′30″

- 1-2. Estructura de mercado; economías externas · 1′

- 3. Stigler y Leibenstein · 2′

- 4. Multiplanta, multiproducto, aprendizaje · 0′30″

- **Conclusión** · 1′

Pizarra: esquema de dualidad por capas; $C(\mathbf{w},q)$ no se borra.

## Introducción (2′30″)

- **Enganche**: fotovoltaica: coste nivelado $0{,}41\to0{,}044$ \$/kWh (2010-2025, $-89$ %); módulos $-27$ % por cada duplicación de la producción acumulada; en España, 1.ª tecnología en potencia. *¿Cuánto de esa caída se debe a la escala, cuánto al aprendizaje y cuánto a los precios de los factores?*

- **Contexto**: ¿qué dicen los costes de la empresa y cómo se miden? 3 restricciones: *técnicas* [ver tema 3.A.11], *económicas* (costes), *de mercado* [ver tema 3.A.16-19].

- **Definiciones**: **coste económico** = coste de oportunidad (con mercados competitivos, precio de mercado) $\neq$ coste contable; **función de costes** $C(\mathbf{w},q)$: coste mínimo de producir $q$ a precios $\mathbf{w}$ $\Rightarrow$ eficiencia técnica + económica.

- **Relevancia**: *teórica* (puente tecnología–mercado: oferta, cuántas empresas caben); *empírica* (tecnología desde costes y precios); *política* (regulación de redes, predación de Areeda-Turner).

- **Historia**: Marshall (1890), Wicksell, Viner (1931) $\to$ dualidad (Hotelling 1932, Shephard 1953, Uzawa) $\to$ estimación (Nerlove, translog) y eficiencia (Farrell); críticas de Stigler y Leibenstein.

- **«Dual»**: estricto = intercambiar objetivo y restricción (mín. coste de $q$ $\leftrightarrow$ máx. $q$ con coste dado); amplio = MB–MC (no estricto: el MB lleva ingresos) $\Rightarrow$ «dualidad» entre comillas.

- **Problemática**: ¿qué contiene $C$? ¿Relación MB–MC–tecnología? ¿Respuesta a $q$, $\mathbf{w}$ y plazo? ¿Estimación y eficiencia? ¿CMe en U? ¿Minimizan costes?

- **Estructura**: I. «dualidad»; II. estática comparativa, plazos y empírica (se estiman las mismas funciones); III. extensiones y críticas.

## I. «Dualidad» MB–MC. Función de costes (9′)

- *Conclusión anticipada*: minimizar el coste de cada $q$ y elegir después $q$ = maximizar el beneficio; $C$ contiene toda la información relevante de la tecnología.

### I.1. Ingredientes comunes

- **Eficiencia técnica** (no hay otro proceso con menos factores para igual $q$) no basta: deja toda la isocuanta $\Rightarrow$ hacen falta precios $\Rightarrow$ **eficiencia económica**: cada $q$ de la forma más barata.

- *Ingredientes*: $\mathcal{Y}$, $q=F(\mathbf{z})$, $V(q)=\{\mathbf{z}\geq\mathbf{0}:F(\mathbf{z})\geq q\}$; $F$ *estr. cuasicóncava* (MB exige además *estr. cóncava* $\Rightarrow$ $C$ existe con cualquier rendimiento, $B$ no); $\mathbf{w}\gg\mathbf{0}$ y, en MB, $p>0$. *Supuestos*: estático, información perfecta, un producto y una planta, *largo plazo*.

|  | *Máx. beneficio* | *Mín. coste* |
|:---|:---|:---|
| Objetivo | $pF(\mathbf{z})-\mathbf{w}\cdot\mathbf{z}$ | $\mathbf{w}\cdot\mathbf{z}$ |
| Restricción | $\mathbf{z}\geq\mathbf{0}$ ($F$ en el objetivo) | $F(\mathbf{z})\geq q$ |
| Parámetros | $p$, $\mathbf{w}$ | $\mathbf{w}$, $q$ |
| Mercado prod. | precio-aceptante | cualquiera |
| Solución | $\mathbf{z}(p,\mathbf{w})$, $q(p,\mathbf{w})$ | $\mathbf{z}(\mathbf{w},q)$ |
| Función valor | $B(p,\mathbf{w})$ | $C(\mathbf{w},q)$ |

### I.2. Problemas primal y dual

- *MB en una etapa*: contiene toda la información, pero solo vale para la empresa precio-aceptante en todo.

$\begin{array}{rl}\max_{\mathbf{z}} & p\,F(\mathbf{z})-\mathbf{w}\cdot\mathbf{z} \\ \text{s.a.} & \mathbf{z}\geq\mathbf{0}\end{array}$$\Rightarrow$$p\,\mathrm{PMg}_i=w_i$,  $\mathrm{RMST}_{LK}=\dfrac{w_L}{w_K}$

- Valor del PMg = precio del factor. Con RCE, $B^*=0$ y escala indeterminada; con crecientes, no acotado. **Demandas no condicionadas** $\mathbf{z}(p,\mathbf{w})$ y **oferta** $q(p,\mathbf{w})$: únicas, continuas (Berge), homog. de grado 0 en $(p,\mathbf{w})$.

$$B(p,\mathbf{w})=\begin{array}{rl}\max_{\mathbf{z}} & p\,F(\mathbf{z})-\mathbf{w}\cdot\mathbf{z} \\ \text{s.a.} & \mathbf{z}\geq\mathbf{0}\end{array}$$

- **Propiedades de $B$**: continua; homog. de grado 1 en $(p,\mathbf{w})$; no decreciente en $p$ y no creciente en $w_i$; *convexa* en $(p,\mathbf{w})$ (reoptimizar gana al menos lo lineal); lema de Hotelling.

$$\text{Hotelling (1932):}\quad \frac{\partial B}{\partial p}=q(p,\mathbf{w}),\qquad \frac{\partial B}{\partial w_i}=-z_i(p,\mathbf{w})$$

- $D^2B$ *simétrica* (Schwarz/Young: $\partial z_i/\partial w_j=\partial z_j/\partial w_i$; $-\partial z_i/\partial p=\partial q/\partial w_i$) y *semidef. positiva*: $\partial q/\partial p\geq0$ (*ley de la oferta*), $\partial z_i(p,\mathbf{w})/\partial w_i\leq0$ $\Rightarrow$ sin factores Giffen. Análogo de Roy.

- *MC*: fijado $q$, ¿combinación más barata? Vale para competencia, monopolio u oligopolio (si precio-aceptantes en factores; Shephard, 1953).

$\begin{array}{rl}\min_{\mathbf{z}} & \mathbf{w}\cdot\mathbf{z} \\ \text{s.a.} & F(\mathbf{z})\geq q\\ \mathbf{z}\geq\mathbf{0}\end{array}$$\mathcal{L}=\mathbf{w}\cdot\mathbf{z}+\mu\big(q-F(\mathbf{z})\big)$
$\dfrac{w_L}{\mathrm{PMg}_L}=\dfrac{w_K}{\mathrm{PMg}_K}=\mu$,$\mathrm{RMST}_{LK}=\dfrac{w_L}{w_K}$

- *Misma* tangencia que en MB. $\mu^*=\partial C/\partial q=$ **coste marginal** (envolvente). CSO: $|\overline{H}|>0$.

- **Demandas condicionadas** $\mathbf{z}(\mathbf{w},q)$, análogas a las *hicksianas*: únicas; continuas; homog. de grado 0 en $\mathbf{w}$ (no en $q$); $F(\mathbf{z}(\mathbf{w},q))=q$; $(\mathbf{w}'-\mathbf{w})\cdot(\mathbf{z}'-\mathbf{z})\leq0$.

$$C(\mathbf{w},q)=\mathbf{w}\cdot\mathbf{z}(\mathbf{w},q)=\begin{array}{rl}\min_{\mathbf{z}} & \mathbf{w}\cdot\mathbf{z} \\ \text{s.a.} & F(\mathbf{z})\geq q\\ \mathbf{z}\geq\mathbf{0}\end{array}$$

- **Propiedades de $C$**: continua, $C(\mathbf{w},0)=0$; homog. de grado 1 en $\mathbf{w}$; estr. creciente en $q$; no decreciente en $w_i$; *cóncava en $\mathbf{w}$* (la empresa «pasiva» pagaría un coste lineal; sustituyendo, paga como mucho eso); Shephard; matriz de sustitución.

$$\text{Shephard (1953):}\quad z_i(\mathbf{w},q)=\frac{\partial C(\mathbf{w},q)}{\partial w_i}$$

- $S(\mathbf{w},q)=D^2_{\mathbf{w}}C$, $S_{ij}=\partial z_i(\mathbf{w},q)/\partial w_j$: *simétrica*; *semidef. negativa* ($S_{ii}\leq0$, ley de la demanda condicionada); $S\mathbf{w}=\mathbf{0}$ (Euler) $\Rightarrow$ con 2 factores, *sustitutivos netos*.

*[Gráfico: MC: isocoste más baja tangente a la isocuanta]* · *[Gráfico: $C$ cóncava en $w_i$, pendiente $z_i$ (Shephard)]*

Leontief: $C=(a\,w_K+b\,w_L)\,q$ (lineal en $\mathbf{w}$)
CD ($k=\alpha+\beta$): $C=k\Big(\dfrac{q}{A}\Big)^{1/k}\Big(\dfrac{w_K}{\alpha}\Big)^{\alpha/k}\Big(\dfrac{w_L}{\beta}\Big)^{\beta/k}$,  $s_K=\dfrac{\alpha}{k}$
Homotética: $C=\phi(q)\,c(\mathbf{w})$;  homogénea de grado $k$: $C=q^{1/k}c(\mathbf{w})$

| *Beneficio $B(p,\mathbf{w})$* | *Costes $C(\mathbf{w},q)$* |
|:---|:---|
| $\mathbf{z}(p,\mathbf{w})$, $q(p,\mathbf{w})$ grado 0 en $(p,\mathbf{w})$ | $\mathbf{z}(\mathbf{w},q)$ grado 0 en $\mathbf{w}$ |
| grado 1 en $(p,\mathbf{w})$ | grado 1 en $\mathbf{w}$ |
| $\uparrow$ en $p$, $\downarrow$ en $\mathbf{w}$ | estr. $\uparrow$ en $q$, $\uparrow$ en $\mathbf{w}$ |
| convexa | cóncava en $\mathbf{w}$ |
| Hotelling (con $-$ en $z_i$) | Shephard (sin signo $-$) |
| $D^2B$ simétr., semidef. positiva | $S$ simétr., semidef. negativa, $S\mathbf{w}=\mathbf{0}$ |

### I.3. Relaciones de «dualidad»

- **MB en dos etapas**: 1.º mín. coste de cada $q$ $\to C$; 2.º elegir $q$: $B(p,\mathbf{w})=\begin{array}{rl}\max_{q} & p\,q-C(\mathbf{w},q) \\ \text{s.a.} & q\geq 0\end{array}$$\Rightarrow$$p=\mathrm{CMg}$,  $\dfrac{\partial^2C}{\partial q^2}\geq0$
  $\mathbf{z}(p,\mathbf{w})\equiv\mathbf{z}\big(\mathbf{w},q(p,\mathbf{w})\big)$;$B(p,\mathbf{w})\equiv p\,q(p,\mathbf{w})-C\big(\mathbf{w},q(p,\mathbf{w})\big)$

- Oferta = tramo creciente del CMg sobre el CMe evitable [ver tema 3.A.16]. $B$ desde $C$ sin volver a minimizar. *Asimetría*: $C$ con cualquier rendimiento, $B$ no $\Rightarrow$ $C$, más general.

*[Gráfico: Esquema de dualidad de la empresa: MB (izq.), MC (dcha.), dos etapas (arriba) y tecnología (abajo)]*

- **$C\leftrightarrow F$** (Shephard 1953, McFadden 1978): $V^*(q)=\{\mathbf{z}\geq\mathbf{0}:\mathbf{w}\cdot\mathbf{z}\geq C(\mathbf{w},q)\ \forall\mathbf{w}\gg\mathbf{0}\}$ = envolvente de las isocostes mínimas. $V$ convexo + eliminación gratuita $\Rightarrow$ $V^*=V$; si no, su envoltura convexa (la que importa para la conducta).

- Toda $C$ con esas propiedades es función de costes de alguna tecnología (Shephard-Uzawa) $\Rightarrow$ se estima $C$ sin escribir $F$.

- **$B\leftrightarrow\mathcal{Y}$**: $B$ = **función soporte** de $\mathcal{Y}$; $\mathcal{Y}^*=\{(q,-\mathbf{z}):pq-\mathbf{w}\cdot\mathbf{z}\leq B\ \forall(p,\mathbf{w})\}$; $=\mathcal{Y}$ si convexo, cerrado y con eliminación gratuita.

> Minimizar el coste de cada $q$ y elegir $p=\mathrm{CMg}$ = maximizar el beneficio. $C$ es cóncava y homogénea de grado 1 en $\mathbf{w}$, sus derivadas son las demandas condicionadas (Shephard) y contiene la misma información que la tecnología: basta conocer los costes para conocer la empresa.

## II. Estática comparativa, plazos y aplicaciones empíricas (14′)

- *Conclusión anticipada*: la demanda condicionada nunca crece con su precio; a LP la forma de los costes refleja los rendimientos a escala y a CP los del factor variable; a LP se responde más; con la dualidad se estiman escala y eficiencia: costes en L, ineficiencias persistentes.

### II.1. Estática comparativa

- *$\Delta q$, demandas*: **senda de expansión**: combinaciones de mínimo coste al $\uparrow q$ con $\mathbf{w}$ fijo; RMST constante $\Rightarrow$ isoclina (análogo de la curva renta-consumo); homotética $\Rightarrow$ rayo.

- Factor **normal** si $\partial z_i(\mathbf{w},q)/\partial q>0$; **inferior** si $<0$ (senda hacia atrás). No todos inferiores: $\sum_iF_i\,\partial z_i/\partial q=1$.

*[Gráfico: Senda de expansión, con trabajo inferior entre $B$ y $C$]* · *[Gráfico: CMe: pendiente del rayo; CMg: de la tangente]*

- *$\Delta q$, costes*: $\mathrm{CMe}=C/q$ (rayo), $\mathrm{CMg}=\partial C/\partial q$ (tangente); CMg corta al CMe en su mínimo.

$\dfrac{d\,\mathrm{CMe}}{dq}=\dfrac{\mathrm{CMg}-\mathrm{CMe}}{q}$;$\varepsilon_{C,q}\equiv\dfrac{\partial C}{\partial q}\dfrac{q}{C}=\dfrac{\mathrm{CMg}}{\mathrm{CMe}}$
Hanoch (1975):  $\boxed{\varepsilon_{q,\lambda}\big(\mathbf{z}(\mathbf{w},q)\big)=\dfrac{\mathrm{CMe}}{\mathrm{CMg}}=\dfrac{1}{\varepsilon_{C,q}}}$

- $\varepsilon_{C,q}<1$: **economías de escala** (CMe $\downarrow$); $=1$: CMe mínimo (*escala mínima eficiente*); $>1$: **deseconomías**. Grado: $1-\varepsilon_{C,q}$.

- *Rendimientos* (tecnología, rayo) $\neq$ *economías* (costes, senda). Prueba: $w_i=\mathrm{CMg}\,\mathrm{PMg}_i$ $\Rightarrow$ $C=\mathrm{CMg}\,q\,\varepsilon_{q,\lambda}$. Vale *sin* homoteticidad (locales, en el óptimo); *con*, en toda la senda. *Globales*: solo $\Rightarrow$.

- CMe LP en U $\Leftarrow$ rendim. *variables* («en S», Wicksell), no proporciones variables (CP). Homogéneas: CMe monótono; RCE: tamaño indeterminado.

- *$\Delta\mathbf{w}$, demandas*: $w_L\uparrow$ $\Rightarrow$ menos $z_L$, más $z_K$ en la misma isocuanta. $\varepsilon_{z_i,w_j}=s_j\sigma_{ij}$ (Allen-Uzawa).

Slutsky de factores:  $\underbrace{\dfrac{\partial z_i(p,\mathbf{w})}{\partial w_j}}_{\text{total}}=\underbrace{\dfrac{\partial z_i(\mathbf{w},q)}{\partial w_j}}_{\text{sustitución}}+\underbrace{\dfrac{\partial z_i(\mathbf{w},q)}{\partial q}\dfrac{\partial q(p,\mathbf{w})}{\partial w_j}}_{\text{escala}}$
propio: efecto escala $=-\dfrac{(\partial z_i/\partial q)^2}{\partial^2C/\partial q^2}\leq0$

- **Efecto escala** sustituye al efecto renta y *refuerza* al de sustitución $\Rightarrow$ no condicionada *más elástica*; *sin factores Giffen*.

- *$\Delta\mathbf{w}$, costes*: $\varepsilon_{C,w_i}=s_i$ (trabajo 30 %, salario $+10$ % $\Rightarrow$ coste $\approx+3$ %). $\partial\mathrm{CMg}/\partial w_i=\partial z_i/\partial q$: normal $\Rightarrow$ CMg $\uparrow$; inferior $\Rightarrow$ CMg $\downarrow$.

### II.2. Análisis de plazos

- Marshall: **corto plazo** (algún factor fijo, la planta) y **largo plazo** (todos variables; costes *planeados*, *ex ante*).

$\begin{array}{rl}\min_{z_L} & w_Lz_L+w_K\overline{z}_K \\ \text{s.a.} & F(z_L,\overline{z}_K)\geq q\\ z_L\geq 0\end{array}$
$\boxed{C(\mathbf{w},q;\overline{z}_K)=\underbrace{w_Lz_L(\mathbf{w},q;\overline{z}_K)}_{\mathrm{CV}(q)}+\underbrace{w_K\overline{z}_K}_{\mathrm{CF}}}\ \geq C(\mathbf{w},q)$
$\mathrm{CMg}=\dfrac{w_L}{\mathrm{PMg}_L}$,$\mathrm{CVMe}=\dfrac{w_L}{\mathrm{PMe}_L}$,$\varepsilon_{\mathrm{CV},q}=\dfrac{\mathrm{CMg}}{\mathrm{CVMe}}=\dfrac{1}{\varepsilon_{q,z_L}}$

- Económicamente eficiente solo si $\overline{z}_K=z_K(\mathbf{w},q)$. CMg = imagen invertida del PMg $\Rightarrow$ U por la **ley de proporciones variables**; CMe baja por el reparto del CF: *no* son economías de escala.

- *Mínimo de explotación* = mín. CVMe (cierre a CP); *óptimo de explotación* = mín. CMe (beneficio).

*[Gráfico: Costes a CP: CT, CV, CF; CMg, CMe, CVMe, CFMe]*

| *Tramo* | *Costes* | $\varepsilon_{q,z_L}$ | $\varepsilon_{\mathrm{CV},q}$ |
|:---|:---|:--:|:--:|
| Etapa I | CMg $<$ CVMe $\downarrow$ | $>1$ | $(0,1)$ |
| Margen extensivo | mín. CVMe (mín. explot.) | $=1$ | $=1$ |
| Etapa II | CMg $>$ CVMe $\uparrow$ (óptimo expl.) | $(0,1)$ | $>1$ |
| Margen intensivo | CMg $\to\infty$ (capacidad) | $=0$ | $\to\infty$ |
| Etapa III | fuera de la función de costes | $<0$ | — |

- *LP*: CT y CMe = **envolvente** de las de CP. Izq. del mín.: exceso de capacidad; dcha.: sobrecarga. Solo en el mín. coinciden los cuatro (error de Viner, 1931). CMg$_{\mathrm{CP}}$ corta al de LP desde abajo.

*[Gráfico: Envolvente: CT (arriba) y CMe, CMg (abajo); tangencias en $q_1,q_2,q_3$]*

Le Chatelier-Samuelson (1947):
$\dfrac{\partial z_i^{\mathrm{LP}}}{\partial w_i}\leq\dfrac{\partial z_i^{\mathrm{CP}}}{\partial w_i}\leq0$,$\dfrac{\partial q^{\mathrm{LP}}}{\partial p}\geq\dfrac{\partial q^{\mathrm{CP}}}{\partial p}\geq0$

- Más restricciones $\Rightarrow$ menos respuesta (químico Le Chatelier, 1884).

> LP: los costes reflejan los rendimientos a escala ($\varepsilon_{q,\lambda}=1/\varepsilon_{C,q}$ en el óptimo); CP: los del factor variable. La curva de LP envuelve a las de CP, y la empresa responde más cuantos menos factores fijos tenga.

### II.3. Estimación por dualidad

- *Idea*: estimar $F$ exige cantidades elegidas por la empresa; si $\mathbf{w}$ y $q$ son exógenos (eléctrica regulada) $\Rightarrow$ estimar $C$ (Nerlove, 1963) y, por Shephard, las demandas.

- CD (Nerlove): impone $\sigma=1$ y escala igual a todo tamaño.

**Translog de costes** (Christensen-Jorgenson-Lau 1973):
$\ln C=\alpha_0+\alpha_q\ln q+\tfrac12\beta_{qq}(\ln q)^2+\sum_i\alpha_i\ln w_i$
$+\tfrac12\sum_i\sum_j\beta_{ij}\ln w_i\ln w_j+\sum_i\beta_{iq}\ln w_i\ln q$
$s_i=\dfrac{\partial\ln C}{\partial\ln w_i}=\alpha_i+\sum_j\beta_{ij}\ln w_j+\beta_{iq}\ln q$,$\sum_is_i=1$
$\varepsilon_{C,q}=\alpha_q+\beta_{qq}\ln q+\sum_i\beta_{iq}\ln w_i$

- **Forma flexible**: 2.º orden, no impone $\sigma$ ni rendimientos; $\varepsilon_{C,q}$ varía con $q$ (U o L). Sistema coste + participaciones. Anidados: $\beta=0$ CD; $\beta_{iq}=0$ homotética. Otra: Leontief generalizada (Diewert, 1971).

- Restricciones *contrastables*. Berndt-Wood (1975): energía-capital complementarios, energía-trabajo sustitutivos. *Valoración*: locales; si no minimiza, media y no frontera.

### II.4. Economías de escala en los datos

- *Métodos* (Stigler, 1958): estadístico, ingeniería, *superviviente* (tamaños que ganan cuota).

- Nerlove: economías que se agotan. Christensen-Greene (1976): en 1970, el grueso en el tramo *plano* $\Rightarrow$ competencia en generación [ver tema 3.A.17].

*[Gráfico: CMe y producción de las eléctricas de EE. UU. en 1970 (123 empresas)]*

- Caves et al. (1984): *densidad* $\neq$ escala. Johnston, Walters: costes en **L**. Lieberman (1984): aprendizaje $>$ escala estática.

### II.5. Medición de la eficiencia

- *Idea*: $C$ es una *frontera*; Farrell (1957): distancia a las mejores prácticas. Isocuanta unitaria $SS'$, empresa en $P$, $Q$ en la isocuanta y $R$ en la isocoste, sobre el rayo $OP$: $\mathrm{EfT}=\dfrac{OQ}{OP}$,$\mathrm{EfA}=\dfrac{OR}{OQ}$,$\mathrm{EfE}=\dfrac{OR}{OP}=\mathrm{EfT}\cdot\mathrm{EfA}=\dfrac{1}{1+\chi}$

- **Técnica**: reducir todos los factores (ineficiencia X); **asignativa**: $\mathrm{RMST}=w_L/w_K$; **económica**: $C/C^{\mathrm{obs}}$.

*[Gráfico: Eficiencia técnica, asignativa y económica de Farrell]*

- **Frontera estocástica** (SFA, 1977): $\ln C_j^{\mathrm{obs}}=\ln C(\mathbf{w}_j,q_j)+v_j+u_j$, $v_j$ ruido, $u_j\geq0$ ineficiencia; paramétrica, separa ruido; exige forma y distribución.

- **DEA** (Charnes-Cooper-Rhodes, 1978): programación lineal, envolvente por tramos; sin forma ni ruido (todo es ineficiencia); multiproducto inmediato; sensible a atípicos.

- *Evidencia*: BCE: banco mediano, 84 % de sus costes; ineficiencia persistente. Regulación por comparación (Shleifer, 1985): Alemania, DEA y SFA. *Valoración*: eficiencia *relativa*; no dice *por qué* [ver tema 3.A.15].

> La dualidad convierte la teoría de los costes en un instrumento empírico: con costes, precios y producción se estiman escala y sustitución sin conocer la tecnología, y con fronteras, la distancia al coste mínimo. Los datos matizan: costes en L e ineficiencias persistentes.

## III. Extensiones y críticas (3′30″)

- *Conclusión anticipada*: la forma de los costes condiciona el mercado; las dos críticas (U y minimización) son cuestiones empíricas que los datos del II matizan.

### III.1. Estructura de mercado

- *Competencia perfecta*: $p=\mathrm{CMg}$ creciente si cubre CVMe (CP) o CMe (LP); muchas empresas si las deseconomías llegan pronto [ver tema 3.A.16].

- **Monopolio natural** $\Leftrightarrow$ **subaditividad**: $C\big(\sum_jq_j\big)<\sum_jC(q_j)$ (Baumol, 1977: es la definición). Uniproducto: economías de escala *suficientes*, no necesarias (subaditiva con CMe creciente entre $q^0$ y $q^1$). Multiproducto: economías de alcance *necesarias*, no suficientes (+ coste incremental medio decreciente) [ver tema 3.A.17].

### III.2. Economías externas

- Marshall: **economías externas**: CMe $\downarrow$ al crecer la *industria* $\Rightarrow$ desplazan la curva. Fuentes: trabajo especializado, proveedores, conocimiento (*clusters*). Compatibles con competencia perfecta [ver tema 3.B.6].

*[Gráfico: Subaditividad con CMe creciente ($q^0$–$q^1$)]* · *[Gráfico: Stigler: reserva de capacidad frente a la U]*

### III.3. Críticas desde la organización industrial

- **Stigler (1939)**: con demanda incierta, planta *flexible*: factor «fijo» divisible $\Rightarrow$ CVMe = CMg constantes en la **reserva de capacidad**; horquilla de tamaños óptimos. Evidencia: costes en L.

- **Leibenstein (1966), ineficiencia X**: contratos incompletos, esfuerzo que responde a la presión $\Rightarrow$ $C^{\mathrm{obs}}=(1+\chi)\,C(\mathbf{w},q)$, $\chi\geq0$ $\downarrow$ con la competencia; pérdida del monopolio $>$ triángulo de Harberger. Evidencia: Nickell (1996), Bloom-Van Reenen (2007). Stigler (1976): es minimización con otros argumentos $\to$ agencia [ver tema 3.A.15].

### III.4. Otras extensiones

- **Multiplanta**: $\mathrm{CMg}_1=\dots=\mathrm{CMg}_J$. **Multiproducto**: **economías de alcance** $C(q_1,q_2)<C(q_1,0)+C(0,q_2)$ (factores compartidos; Panzar-Willig, 1981); complementariedad de costes $\partial^2C/\partial q_1\partial q_2<0$.

- **Curva de aprendizaje**: $c=c_1(Q^{\mathrm{ac}})^{-b}$ (Wright, 1936); fotovoltaica $2^{-b}\approx0{,}73$ $\Rightarrow$ $b\approx0{,}45$. *Desplaza* la curva; industria naciente [ver tema 3.B.8].

*[Gráfico: Curva de aprendizaje y diferencia entre escala y aprendizaje]*

## Conclusión (1′)

- **Recapitulación**: $C$ cóncava, homog. de grado 1, Shephard, = tecnología; forma según el plazo; estimable: costes en L; críticas de Stigler y Leibenstein.

- **Relevancia**: cuántas empresas caben; referencia de reguladores y de competencia.

- **Extensiones**: [ver tema 3.A.15][ver tema 3.A.16][ver tema 3.A.17][ver tema 3.A.20][ver tema 3.A.25][ver tema 3.B.6].

- **Opinión**: lo frágil es la precio-aceptación en factores (monopsonio, equilibrio general [ver tema 3.A.21]).

- **Idea final**: fotovoltaica $-89$ % por escala y, sobre todo, aprendizaje; en 2025 equipos $-6$ % y el coste nivelado no bajó (coste del capital). $C(\mathbf{w},q)$ recoge las tres cosas y la dualidad las separa.

## Autores y fechas

**1890** Marshall: economías internas y externas; plazos

**1901** Wicksell: rendim. variables, CMe en U

**1931** Viner: curvas de coste CP y LP (envolvente)

**1932** Hotelling: función de beneficio y su lema

**1939** Stigler: flexibilidad

**1947** Samuelson: *Foundations*; Le Chatelier-Samuelson

**1953** Shephard: $C\leftrightarrow F$ y su lema

**1957** Farrell: eficiencia técnica y asignativa

**1963** Nerlove: costes de la electricidad

**1966** Leibenstein: ineficiencia X

**1973** Christensen-Jorgenson-Lau: translog

**1975** Hanoch: $\varepsilon_{q,\lambda}=1/\varepsilon_{C,q}$; Berndt-Wood; Areeda-Turner

**1976** Christensen-Greene: escala en electricidad

**1977** SFA (Aigner-Lovell-Schmidt); Baumol: subaditividad

**1978** DEA (Charnes-Cooper-Rhodes); McFadden

**1981** Panzar-Willig: economías de alcance

## Datos clave

- Coste nivelado fotovoltaico: **0,41 $\to$ 0,044 \$/kWh, $-89$ %** (IRENA, 2010-2025); en 2025, equipos **$-6$ %** (IRENA) sin bajar el coste nivelado.

- Módulos: **$-27$ % por duplicación** (Fraunhofer ISE) $\Rightarrow$ $b\approx0{,}45$.

- España: fotovoltaica **$>$41.500 MW** (REE), **18,4 % de la electricidad** (REE, 2025).

- Banca: banco mediano **84 % de sus costes** (BCE, 2006-2017); ratio de eficiencia **42,9 % España vs 53,1 % MUS** (BCE, 2T 2026).

## Preguntas del tribunal

1.  **¿Son MB y MC duales en sentido estricto?** No: MB lleva ingresos; el dual estricto de MC es máx. $q$ con coste dado (Segura). «Dualidad» en sentido amplio.

2.  **¿Por qué existe $C$ con cualquier rendimiento y $B$ no?** Minimizar el coste de $q$ dado está acotado (basta cuasiconcavidad); con RCE o crecientes, $B$ es 0 o no acotado.

3.  **¿Demandas condicionadas: hicksianas o marshallianas?** Hicksianas: el parámetro es $q$, como allí $U$.

4.  **¿Puede haber factores Giffen?** No: concavidad de $C$ y convexidad de $B$; sin restricción presupuestaria no hay efecto renta. Sí inferiores: encarecerlos baja el CMg.

5.  **¿Rendimientos y economías de escala?** Tecnología frente a costes; $\varepsilon_{q,\lambda}=1/\varepsilon_{C,q}$ en el óptimo, con cualquier tecnología; con homotéticas, en toda la senda.

6.  **¿Por qué la U del CMe a CP y a LP?** CP: proporciones variables; LP: rendimientos variables (Wicksell). Dos explicaciones de dos curvas.

7.  **¿SFA o DEA?** SFA separa ruido, pero exige forma y distribución; DEA sin forma, pero todo es ineficiencia.

> **Ojo en el test.**
>
> - $C$ homog. de grado *1* en $\mathbf{w}$ (no en $q$); $\mathbf{z}(\mathbf{w},q)$, grado *0* en $\mathbf{w}$; $B$ grado 1, y $\mathbf{z}(p,\mathbf{w})$, $q(p,\mathbf{w})$ grado 0, en $(p,\mathbf{w})$.
>
> - Shephard sin signo $-$; Hotelling con $-$ en $z_i$ y sin él en $q$.
>
> - $C$ *cóncava* en $\mathbf{w}$; $B$ *convexa*. $S$ semidef. negativa: diagonal *no positiva*.
>
> - $\mu^*=\mathrm{CMg}$. $\varepsilon_{C,q}<1$ = *economías*; $\varepsilon_{q,\lambda}>1$ = rendim. *crecientes*.
>
> - Con 2 factores, siempre sustitutivos netos ($S\mathbf{w}=\mathbf{0}$).
>
> - Mín. CVMe = mínimo de explotación; mín. CMe = óptimo. A CP no hay economías de escala.
>
> - EfE = EfT $\times$ EfA (Farrell). Escala: *por* la curva; aprendizaje y externas: la *desplazan*.
