<!-- Material exclusivo de victorgutierrezmarcos.es y la app Oposición TCEE · DCE. Forma parte de la skill «EconomIA»: solo para la preparación personal del opositor en su propia cuenta de Claude. No se autoriza copiarlo, redistribuirlo ni usarlo en otras plataformas o sistemas de IA (ver LICENCIA.md). -->
*Material exclusivo de victorgutierrezmarcos.es y la app Oposición TCEE · DCE. Forma parte de la skill «EconomIA»: solo para la preparación personal del opositor en su propia cuenta de Claude. No se autoriza copiarlo, redistribuirlo ni usarlo en otras plataformas o sistemas de IA (ver LICENCIA.md).*

# 3.A.21. La teoría del equilibrio general.

*Ficha de repaso · actualizada el 17/10/2026*

## Esquema del cante

- **Introducción** · 2′30″

- **I. Construcción del modelo** · 11′

- 1. Supuestos: 2×2×2×2 competitivo · 2′30″

- 2. Empresas, consumidores, $\mathbf{z}(\mathbf{p})$, ley de Walras · 6′

- 3. Equilibrio general competitivo · 2′30″

- **II. Análisis positivo y normativo** · 9′

- 1. Existencia, unicidad, estabilidad · 7′

- 2. Óptimo de Pareto: 1TFEB y 2TFEB · 2′

- **III. Otros desarrollos y aplicaciones** · 6′30″

- 1. Intercambio de Edgeworth · 1′

- 2. Núcleo, estrategia, no convexidades · 2′

- 3. Dinero (Patinkin) · 1′

- 4. Incertidumbre (Arrow-Debreu) · 1′30″

- 5. Modelos computables (Scarf) · 1′

- **Conclusión** · 1′

*Hilo*: ¿es *posible*, *determinada*, *alcanzable*, *deseable* y *robusta* la coordinación por precios? *Pizarra*: caja de la producción, caja de intercambio (de I.3 a III.2), Brouwer, $z_X$ con 3 equilibrios.

## Introducción (2′30″)

- **Enganche**: Bastiat (*Sofismas económicos*, 1845): París, 1 millón de habitantes, se abastece cada día sin que nadie lo organice. ¿Pueden millones de agentes que solo buscan su interés y solo ven precios llegar a planes compatibles, sin que sobre ni falte nada? ¿Y es bueno el resultado? Mano invisible de Smith (1776); para Arrow-Hahn (1971), la pregunta que da sentido a la teoría.

- **Relevancia**: *teórica* (bienestar, H-O, incidencia, precios de estado); *práctica* (MEGC: UE-Mercosur, PIB UE +77.600 M€ hasta 2040); *de política* (cuándo coordinan los precios y cuándo no $\Rightarrow$ intervención [ver tema 3.A.23]).

- **Contextualización**: Quesnay (1758), Smith $\to$ Léon Walras (1874), primer modelo completo (*rareté*, tanteo, numerario) $\to$ Edgeworth (1881), Pareto (1906) $\to$ Cassel (1918), Wald (1935-36), von Neumann (1937) $\to$ Arrow-Debreu y McKenzie (1954), Debreu (1959) $\to$ límites (estabilidad, núcleo, SMD, Radner).

- **Problemática**: ¿qué es un EGC y cómo se obtiene? ¿Existe, es único, es estable? ¿Es eficiente, es justo? ¿Qué pasa al relajar supuestos?

- **Estructura**: I. modelo; II. existencia, unicidad, estabilidad y eficiencia; III. cada extensión relaja un supuesto de I que II necesitaba.

- **Individualismo metodológico**: lo agregado, desde individuos que optimizan.

- **Equilibrio parcial** (Marshall): un mercado aislado [ver tema 3.A.16].

- **Equilibrio general**: todos los mercados interdependientes, precios y cantidades a la vez.

## I. Construcción del modelo (11′)

> Si cada agente optimiza a precios dados, todo el sistema se resume en $\mathbf{z}(\mathbf{p})$; el equilibrio vacía todos los mercados a la vez y la ley de Walras deja solo precios relativos.

### I.1. Supuestos

- **Equilibrio general à la Walras**: tantos mercados como mercancías; en cada uno, demanda, oferta y condición de vaciado.

- **Competencia perfecta**: agentes racionales, información perfecta, bienes homogéneos, atomicidad (precio-aceptantes): $\mathbf{p}=(p_X,p_Y,w_L,w_K)$.

- **Mercados completos**: sin externalidades ni bienes públicos.

- **2×2×2×2 estático** (Bator, 1957): 2 bienes $X,Y$; 2 factores $L,K$ con $\overline{L},\overline{K}$ de los consumidores; 2 consumidores con preferencias completas, transitivas, continuas, estr. monótonas y estr. convexas; 2 empresas con $\mathcal{Y}_j$ *convexo* $\Rightarrow$ rendim. no crecientes (crecientes, fuera: III.2).

- **Tanteo** (*tâtonnement*): precio $\uparrow$ con exceso de demanda, $\downarrow$ con exceso de oferta; ajustan los precios.

$\overline{W}_i=w_L\overline{L}_i+w_K\overline{K}_i+\sum_j\theta_{ij}B_j$,$\sum_i\theta_{ij}=1$

|  | *Bienes $X,Y$* | *Factores $L,K$* |
|:---|:--:|:--:|
| Consumidores | demanda $X_i(\mathbf{p})$ | oferta $\overline{L}_i,\overline{K}_i$ |
| Empresas | oferta $q_j(p_j,\mathbf{w})$ | demanda $L_j,K_j$ |
| 4 mercados: 3 independientes (Walras), 3 precios relativos |  |  |

### I.2. Desarrollo: agentes, $\mathbf{z}(\mathbf{p})$, ley de Walras

- *Empresas*: $p_j\mathrm{PMg}^j_L=w_L$, $p_j\mathrm{PMg}^j_K=w_K$ $\Rightarrow$ tasa subjetiva = objetiva. Demandas de factores y oferta homogéneas de grado 0 en $(p_j,\mathbf{w})$; oferta función si $F_j$ estr. cóncava (con RCE escala indeterminada: la fija el pleno empleo).

$\begin{array}{rl}\max_{L_j,K_j} & p_jF_j(L_j,K_j)-w_LL_j-w_KK_j \\ \text{s.a.} & L_j\geq 0,\ K_j\geq 0\end{array}$
$\mathrm{RMST}^X_{LK}=\dfrac{w_L}{w_K}=\mathrm{RMST}^Y_{LK}$;$\mathrm{RMT}_{XY}=\dfrac{\mathrm{CMg}_X}{\mathrm{CMg}_Y}=\dfrac{p_X}{p_Y}$

- *Interpretación gráfica*: isocoste común tangente a las 2 isocuantas $\Rightarrow$ asignación en la **curva de contrato** (eficiencia en la producción) $\to$ **FPP**; $p_X/p_Y$ elige el punto de la FPP.

*[Gráfico: Caja de la producción: isocoste $w_L/w_K$ en la curva de contrato; $p_X/p_Y$ tangente a la FPP]*

- *Consumidores*: $\max U_i$ s.a. $p_XX_i+p_YY_i=\overline{W}_i$ $\Rightarrow$ $\mathrm{RMS}^A_{XY}=p_X/p_Y=\mathrm{RMS}^B_{XY}$. Demandas únicas, continuas, homogéneas de grado 0 y que agotan la renta; ofrecen toda la dotación.

- *Demanda de mercado*: suma horizontal. *Hereda* continuidad, homogeneidad 0, ley de Walras, cota inferior. *No hereda*: independencia del reparto de la renta (salvo Gorman), ley de la demanda, Slutsky, axioma débil.

- *Efecto renta-dotación*: la renta sale de vender la dotación; si $p_k\uparrow$, el vendedor neto ($x_{ik}<\omega_{ik}$) se enriquece $\Rightarrow$ su demanda puede $\uparrow$ sin ser Giffen.

- **Exceso de demanda**: demanda $-$ oferta; $z_k>0$ falta, $z_k<0$ sobra. *Ventaja*: todo el modelo en función de los precios.

$$\mathbf{z}(\mathbf{p})=\sum_{i}\mathbf{x}_i\big(\mathbf{p},\overline{W}_i(\mathbf{p})\big)-\sum_{i}\mathbf{\omega}_i-\sum_{j}\mathbf{y}_j(\mathbf{p})$$

- *Propiedades*: (1) continua; (2) homogénea de grado 0, $\mathbf{z}(\alpha\mathbf{p})=\mathbf{z}(\mathbf{p})$; (3) ley de Walras; (4) acotada inferiormente y, con bienes deseables, *condición de frontera* ($z_k\to\infty$ si $p_k\to0$).

- *Tipos de bienes*: **económicos**, $p^*_k>0$, $z_k(\mathbf{p}^*)=0$ ($z_k$ corta el eje); **libres**, $p^*_k=0$, $z_k(\mathbf{p}^*)\leq0$ (el aire; no corta): Schlesinger y Wald (1935).

- **Ley de Walras**: a *cualquier* precio, el valor de los excesos de demanda suma 0. En el 2×2×2×2: $p_Xz_X+p_Yz_Y+w_Lz_L+w_Kz_K\equiv0$.

$$\mathbf{p}\cdot\mathbf{z}(\mathbf{p})\equiv\sum_{k=1}^{n}p_k\,z_k(\mathbf{p})=0$$

- *Demostración*: sumar las restricciones presupuestarias saturadas (no saciedad local) con $\sum_i\theta_{ij}=1$.

- *Implicaciones*: mercados interdependientes; si $n-1$ se vacían y $p_n>0$, el $n$-ésimo también; con homogeneidad, solo $n-1$ precios relativos: **numerario** ($p_1=1$) o símplice. Sin dinero, precios absolutos indeterminados.

- *Naturaleza*: *identidad*, no condición de equilibrio. $\neq$ ley de Say (Lange, 1942: excesos de los bienes sin dinero $\equiv0$, objeto de la crítica de Keynes).

*[Gráfico: Bien económico y bien libre: mercado y exceso de demanda]*

### I.3. Equilibrio general competitivo

- **EGC** (walrasiano): $\mathbf{p}^*\geq\mathbf{0}$ y $(\mathbf{x}^*_i,\mathbf{y}^*_j)$ con (1) consumidores maximizan $U$; (2) empresas maximizan $B$; (3) todos los mercados se vacían:

$$z_k(\mathbf{p}^*)\leq 0\quad\text{y}\quad p^*_k\,z_k(\mathbf{p}^*)=0,\quad k=1,\dots,n$$ $\mathrm{RMS}^A_{XY}=\mathrm{RMS}^B_{XY}=\dfrac{p_X}{p_Y}=\mathrm{RMT}_{XY}$,$\mathrm{RMST}^X_{LK}=\mathrm{RMST}^Y_{LK}=\dfrac{w_L}{w_K}$

- *Formación de precios*: **subastador walrasiano**: anuncia precios, recoge planes, sin transacciones fuera del equilibrio, sube donde falta y baja donde sobra. (Walras no habla de subastador: impersonal «*on*»; la literatura lo personifica.)

- *Interpretación gráfica*: **caja de Edgeworth del intercambio**: lados $\overline{X},\overline{Y}$; dotación $\mathbf{\omega}$; recta de precios por $\mathbf{\omega}$ con pendiente $-p_X/p_Y$; las tangencias al girarla dan las **curvas de oferta-demanda** $\mathrm{OD}_A$, $\mathrm{OD}_B$. Fuera del equilibrio: exceso de demanda de $X$ = exceso de oferta de $Y$ de igual valor $\Rightarrow$ $p_X/p_Y\uparrow$.

- *Equilibrio* $E$: $\mathrm{OD}_A\cap\mathrm{OD}_B$, tangencia de $U^*_A$ y $U^*_B$, dentro de la **lente**.

*[Gráfico: Curvas de oferta-demanda y equilibrio $E$ en la caja de intercambio]*

- *Valoración*: el subastador es la pieza más irreal $\Rightarrow$ III busca otros fundamentos.

## II. Análisis positivo y normativo (9′)

> Con supuestos razonables el EGC *existe*; solo con supuestos fuertes es *único* y *estable* (SMD); en cambio, es *eficiente* con muy pocos.

- 3 preguntas, cada una presupone la anterior: **existencia** (¿algún $\mathbf{p}$ vacía todo?), **unicidad** (¿solo uno? si no, no predice) y **estabilidad** (¿lo alcanza el mercado?).

### II.1.1. Existencia

- *Idea*: Walras cuenta ecuaciones e incógnitas ($n-1$): ni necesario ni suficiente (precios negativos; $x^2+1=0$). Schlesinger (1935) desigualdades; Wald (1935-36) primeras pruebas; Arrow-Debreu y McKenzie (1954) punto fijo.

- *Supuestos*: $\mathbf{z}$ continua, homogénea de grado 0 y ley de Walras (detrás: convexidad y no saciedad local). **Teorema de Brouwer** (1911): $\Delta$ no vacío, compacto y convexo, $\mathbf{f}:\Delta\to\Delta$ continua $\Rightarrow$ $\exists\,\mathbf{p}^*=\mathbf{f}(\mathbf{p}^*)$. Correspondencias: Kakutani (1941).

*[Gráfico: Brouwer en 1 dimensión: la gráfica corta la diagonal]*

- *Desarrollo (intuición en 3 pasos)*:

  - *conjunto*: por homogeneidad, **símplice** $\Delta=\{\mathbf{p}\geq\mathbf{0}:\sum_kp_k=1\}$, no vacío, compacto y convexo;

  - *función*: el subastador como regla que sube los precios con exceso de demanda y baja los demás sin salir de $\Delta$; continua $\Rightarrow$ punto fijo;

  - *punto fijo = equilibrio*: ningún precio tiene motivo para moverse; precio nulo $\Rightarrow$ $z_k\leq0$ (libre); por Walras, precio positivo $\Rightarrow$ $z_k=0$.

$f_k(\mathbf{p})=\dfrac{\max\{0,\,p_k+\kappa_kz_k(\mathbf{p})\}}{\sum_l\max\{0,\,p_l+\kappa_lz_l(\mathbf{p})\}}$

- *Implicaciones*: coordinación por precios *lógicamente posible* con supuestos no más fuertes que los del consumidor y la empresa; prueba *no constructiva*.

- *Valoración*: cruciales la convexidad y la ausencia de poder de mercado (III.2); nada dice del número ni de cómo se alcanza.

### II.1.2. Unicidad

- *Idea*: existencia $\not\Rightarrow$ unicidad. Con $p_Y=1$, $z_X>0$ a precios bajos y $<0$ a altos: corta un nº impar de veces (1, 3…). **Economías regulares** (Debreu, 1970): salvo medida nula, nº finito y localmente únicos; impar por el **teorema del índice** (Dierker, 1972; índices $+1$ y $-1$ suman $+1$).

*[Gráfico: $z_X$ con 3 equilibrios; flechas del tanteo: extremos estables, intermedio inestable]*

- *Supuestos*: los de la existencia + condición de frontera ($\mathbf{z}(\mathbf{p}^*)=\mathbf{0}$) + forma de $\mathbf{z}$ (2 condiciones suficientes):

  - **sustitutivos brutos**: $\partial z_k/\partial p_l>0$ $\forall l\neq k$; «brutos»: con efectos renta y renta-dotación;

  - **axioma débil agregado**: la demanda de mercado como la de un consumidor coherente.

- *Intuición (sustitutivos brutos)*: si hubiera 2 equilibrios, se mide el 2.º para que el bien que *menos* se encarece cueste lo mismo; los demás, igual o más caros $\Rightarrow$ los agentes se pasan a él $\Rightarrow$ su $z_k>0$: no es equilibrio. Con 2 bienes, $z_X(p_X,1)$ siempre decreciente: un solo corte.

- *Intuición (axioma débil)*: el «consumidor agregado» elegiría $A$ pudiendo pagar $B$ y viceversa.

- *Condición común* (MWG §17.F), base también de la estabilidad: $\mathbf{p}^*\cdot\mathbf{z}(\mathbf{p})>0\quad\forall\,\mathbf{p}\not\propto\mathbf{p}^*$

- *Implicaciones*: único en precios relativos; con sustitutivos brutos, $\uparrow$ demanda de un bien $\Rightarrow$ $\uparrow$ su precio relativo.

- *Valoración*: condiciones suficientes, muy restrictivas (excluyen complementarios; el axioma débil, que se redistribuya la renta). **Teorema SMD** (Sonnenschein 1972-73, Mantel 1974, Debreu 1974): toda función continua, homogénea de grado 0 y con ley de Walras es el exceso de demanda de alguna economía (precios $>0$) $\Rightarrow$ la racionalidad individual no impone nada más: cualquier nº impar de equilibrios y cualquier dinámica.

### II.1.3. Estabilidad

- *Idea*: estable si fuera del equilibrio hay fuerzas que llevan a él; **local** (perturbación pequeña) o **global** (cualquiera). Estable: argumento para la mano invisible; si no, estabilización (Musgrave, 1959). Ajuste **walrasiano** (precios), no **marshalliano** (cantidades).

- *Supuestos*: tanteo en tiempo continuo, sin intercambios fuera del equilibrio; $\mathbf{z}$ con la condición de unicidad.

$\dot p_k=\kappa_k\,z_k(\mathbf{p}),\quad\kappa_k>0$
$\dfrac{d}{dt}\Big[\tfrac12\sum_k\dfrac{(p_k-p^*_k)^2}{\kappa_k}\Big]=\underbrace{\mathbf{p}\cdot\mathbf{z}(\mathbf{p})}_{=0}-\mathbf{p}^*\cdot\mathbf{z}(\mathbf{p})$

- *Intuición*: **función de Liapunov**: si la distancia al equilibrio baja siempre fuera de él, se llega, aunque no se sepa la trayectoria. Baja si $\mathbf{p}^*\cdot\mathbf{z}(\mathbf{p})>0$: la condición de la unicidad. Con 2 bienes: estables los cortes de arriba abajo.

- *Implicaciones*: **Arrow-Block-Hurwicz** (1959; antes Arrow-Hurwicz, 1958): sustitutivos brutos $\Rightarrow$ *globalmente estable*: la misma condición da unicidad y estabilidad.

- *Valoración*: **contraejemplo de Scarf** (1960): 3 consumidores, 3 bienes complementarios, equilibrio único que el tanteo no alcanza (los precios giran). Tanteo ficticio; sin tanteo, estable más fácil pero depende del camino; enlace con desequilibrio (Clower, Leijonhufvud) [ver tema 3.A.4].

### II.2. Análisis normativo

- *Criterio*: **óptimo de Pareto** (1906): asignación factible que no admite mejorar a uno sin empeorar a otro. Ordinal, pocos juicios de valor, pero *incompleto* (infinitos óptimos, también muy desiguales). En la caja: $\mathrm{RMS}^A_{XY}=\mathrm{RMS}^B_{XY}$, **curva de contrato** $O_AO_B$.

- *Origen*: condiciones marginales de Lerner (1934) y Lange (1942); prueba con análisis convexo de Arrow (1951) y Debreu (1951), por separado.

*[Gráfico: 1TFEB: $E$ en la curva de contrato; 2TFEB: de $\mathbf{\omega}$ a $\mathbf{\omega}'$ para alcanzar $E'$]*

- *1TFEB*: **primer teorema fundamental de la economía del bienestar**: con no saciedad local, *todo EGC es óptimo de Pareto*; no necesita convexidad. *Idea*: todos igualan sus relaciones marginales a los mismos precios. *Supuestos*: mercados completos, precio-aceptantes, precios comunes (sin impuestos), información perfecta; si fallan, fallos de mercado [ver tema 3.A.23]. Mano invisible formalizada; no dice que sea *justo*.

- *2TFEB*: **segundo teorema fundamental de la economía del bienestar**: con preferencias y tecnologías *convexas*, *todo óptimo de Pareto es alcanzable como EGC* tras una redistribución de suma fija. *Idea*: de $\mathbf{\omega}$ a $\mathbf{\omega}'$ en la recta tangente en $E'$. Separa eficiencia y equidad; pero las transferencias de suma fija no son factibles (información privada) $\Rightarrow$ vuelve el dilema.

## III. Otros desarrollos y aplicaciones (6′30″)

> El equilibrio walrasiano resiste quitar el subastador con muchos agentes (núcleo), pero no el poder de mercado, las no convexidades, el dinero sin valor intrínseco ni los mercados incompletos.

### III.1. Intercambio de Edgeworth (1881)

- *Idea*: sin precios dados; negociación libre con recontratación (*recontracting*).

- *Desarrollo*: *racionalidad individual* (dentro de la lente) + *eficiencia* (curva de contrato) $\Rightarrow$ tramo $CC'$.

- *Implicaciones*: con 2 agentes, intercambio *indeterminado*: depende del poder de negociación; $E$ es el único punto con precios dados y comunes. Qué punto: **teoría de la negociación** (Nash, 1950; Rubinstein, 1982) [ver tema 3.A.14].

- *Valoración*: conjetura de Edgeworth: con más agentes, el tramo se estrecha hasta $E$.

### III.2. Núcleo, estrategia y no convexidades

- *Idea*: fundamentar el equilibrio sin subastador con juegos cooperativos: **núcleo** (Gillies, 1959; Shubik, 1959); utilidad no transferible.

- *Supuestos*: $I$ consumidores; cualquier **coalición** reparte sus dotaciones; acuerdos vinculantes y sin coste.

- *Desarrollo*: una coalición **bloquea** si con sus recursos mejora a alguno sin empeorar a ninguno. **Núcleo**: asignaciones factibles no bloqueadas; con 2 agentes, $CC'$.

*[Gráfico: Núcleo: tramo $CC'$ que se encoge hacia $E$ al replicar la economía]*

- *Implicaciones*: (1) el equilibrio walrasiano está en el núcleo (no saciedad local); (2) **teorema del límite** (Debreu-Scarf, 1963): replicando $r$ veces con preferencias estr. convexas, el núcleo se encoge hasta los equilibrios walrasianos (conjetura de Edgeworth); Aumann (1964), continuo de agentes: núcleo = equilibrios; (3) precio-aceptación como *resultado*.

- *Extensiones*: **valor de Shapley**, mismas asignaciones (Aumann, 1975).

- *Valoración*: exige muchos agentes, convexidad, coaliciones gratis; no es un proceso.

- *Comportamiento estratégico*: con pocos agentes interesa influir en los precios. Monopolio en la caja: $B$ elige $M$ sobre $\mathrm{OD}_A$ $\Rightarrow$ ineficiente. Negishi (1961); Cournot-Walras (Gabszewicz-Vial, 1972): depende del numerario y puede no existir; el poder se diluye al crecer la economía (Roberts-Postlewaite, 1976).

- *No convexidades*: convexidad = mezclas mejor que extremos y sin ventajas de tamaño $\Rightarrow$ respuestas suaves. Sin ella, saltos: preferencias no convexas o *rendim. crecientes* ($\mathrm{CMg}<\mathrm{CMe}$ $\Rightarrow$ pérdidas con $p=\mathrm{CMg}$) $\to$ monopolio natural [ver tema 3.A.17]. Con muchos consumidores, equilibrios aproximados (Starr, 1969); las de las empresas no se diluyen.

- *Equilibrios múltiples*: **fallos de coordinación** (nadie invierte porque nadie compra; Cooper-John, 1988) [ver tema 3.A.4].

### III.3. Dinero (Patinkin, 1956)

- *Idea*: funciones: medio de cambio, depósito de valor, unidad de cuenta; en Arrow-Debreu solo numerario: no da utilidad, no hace falta para cambiar (subastador) ni para guardar valor (todo se acuerda hoy), y el sector real ya fija todo.

- *Conceptos*: **dicotomía clásica**: sector real $\to$ precios relativos; monetario $\to$ nivel de precios (dinero, velo). **Neutralidad**: $\Delta M$ sin efectos reales.

- *Desarrollo*: *paso 1*, Walras con dinero; *paso 2*, dicotomía: postulado de homogeneidad + regla de Cambridge $M^D_i=\varphi\,\mathbf{p}\cdot\mathbf{\omega}_i$; *paso 3*, inválida (Lange, Patinkin): duplicar $\mathbf{p}$ vacía los bienes pero no el dinero; *paso 4*, **efecto saldos reales** $\overline{M}_i/P$ en la demanda de bienes.

$\sum_kp_kz_k(\mathbf{p})+\big(M^D(\mathbf{p})-\overline{M}\big)\equiv0$

- *Implicaciones*: $P$ determinado; homogeneidad 0 en $(\mathbf{p},\overline{M})$ $\Rightarrow$ *neutralidad sin dicotomía*. Archibald-Lipsey (1958): dicotomía válida en el estacionario. Efecto Pigou-Patinkin [ver tema 3.A.4].

- *Valoración*: **problema de Hahn** (1965): siempre hay un equilibrio con dinero sin valor. 4 vías: generaciones solapadas, *cash in advance*, búsqueda, dinero en la utilidad [ver tema 3.A.35].

### III.4. Incertidumbre (Arrow 1953, Debreu 1959)

- *Idea*: más bienes, no otra teoría: bienes por fecha y *estado de la naturaleza*. Paraguas si llueve $\neq$ paraguas si no llueve.

- *Supuestos*: **bien contingente** $x_{ks}$, precio $p_{ks}$, se paga hoy (póliza); $n\cdot S$ mercados hoy (**mercados completos**); información simétrica; preferencias convexas.

- *Desarrollo*: el modelo de I con $n\cdot S$ bienes: existe, con **precios de Arrow-Debreu**, y valen los 2 TFEB. Sin riesgo agregado, $p_s/p_{s'}=\pi_s/\pi_{s'}$ y seguro completo.

$\dfrac{\pi_s\,u_i'(x_{is})}{\pi_{s'}\,u_i'(x_{is'})}=\dfrac{p_s}{p_{s'}}\quad\forall\,i$

- *Implicaciones*: riesgo repartido de forma eficiente. **Títulos de Arrow** (1953): 1 € si ocurre $s$; $n+S$ mercados en vez de $n\cdot S$ (1.000 bienes y 10 estados: 1.010 frente a 10.000). Radner (1972): equilibrio de planes, precios y expectativas.

- *Extensiones*: **mercados incompletos**: no eficiente ni restringidamente (Hart, 1975), puede no existir (activos reales), indeterminado (activos nominales). Generaciones solapadas: ineficiencia dinámica [ver tema 3.A.29].

- *Evidencia y valoración*: faltan mercados (renta del trabajo, PIB; Shiller, 1993) por costes de transacción e información asimétrica [ver tema 3.A.13].

### III.5. Modelos computables (Scarf)

- *Idea*: **MEGC** (CGE): equilibrio numérico con muchos sectores, hogares y países. Algoritmo de Scarf (1967; con Hansen, 1973) + ordenadores.

- *Metodología* (Shoven-Whalley, 1992): formas funcionales, *calibración* a una matriz de contabilidad social, simulación = estática comparativa.

- *Usos*: comercio (TLCAN infravaloró el comercio; UE-Mercosur con GTAP); clima (DICE, Nordhaus); macro (REMS, EREMS) [ver tema 3.A.6].

- *Valoración*: dependen de elasticidades y cierres; unicidad no garantizada.

## Conclusión (1′)

- **Recapitulación**: con precio-aceptantes y convexidad, existe; no tiene por qué ser único ni estable (SMD), pero es eficiente con mercados completos y competitivos; resiste el núcleo, no el poder de mercado, las no convexidades, los mercados incompletos ni el dinero. Walras formaliza la mano invisible.

- **Relevancia**: lenguaje común: macro DSGE [ver tema 3.A.6], comercio [ver tema 3.B.5], clima [ver tema 3.B.31], MEGC.

- **Extensiones**: parcial [ver tema 3.A.16]; fallos [ver tema 3.A.23]; información [ver tema 3.A.13]; negociación [ver tema 3.A.14]; dinero [ver tema 3.A.35]. Críticas: austriacos, desequilibrio, agregación (Kirman, 1992), conductual.

- **Opinión**: no describe ninguna economía real ni lo pretende: es una referencia exacta; cada supuesto incumplido señala dónde puede fallar el mercado y tener sentido la intervención.

- **Idea final**: volviendo a Bastiat, París se abastece porque los precios coordinan, pero solo con supuestos exigentes: el modelo enseña por qué el mercado funciona cuando lo hace.

## Autores y fechas

**1845** Bastiat: *Sofismas económicos*, el abastecimiento de París

**1874** Léon Walras: *Éléments*, primer modelo de EG, tanteo

**1881** Edgeworth: intercambio, curva de contrato

**1906** Pareto: criterio de eficiencia

**1935** Schlesinger: bienes libres; Wald (1935-36): primeras pruebas

**1942** Lange: ley de Say; con Lerner (1934), condiciones del óptimo

**1951** Arrow; Debreu: teoremas del bienestar

**1953** Arrow: títulos y bienes contingentes

**1954** Arrow-Debreu; McKenzie: existencia

**1956** Patinkin: efecto saldos reales

**1959** Debreu: *Theory of Value*; Arrow-Block-Hurwicz: estabilidad

**1960** Scarf: contraejemplo de inestabilidad

**1963** Debreu-Scarf: límite del núcleo; 1964 Aumann

**1970** Debreu: economías regulares

**1972** SMD (1972-74); Radner: mercados secuenciales

**1983** Nobel a Debreu (en 1972, a Hicks y Arrow)

## Datos clave

- UE-Mercosur: PIB de la UE **+77.600 M€ hasta 2040** (CE, 2025); exportaciones a la región **+39 %** (CE, 2025).

- T-MEC: **+0,35 % del PIB real de EE. UU., 176.000 empleos** (USITC, 2019).

- España, fin de 2025: demanda **+2,6 p.** (EREMS, 2026); oferta (vivienda) **$-$2,1 p.** (EREMS, 2026).

## Preguntas del tribunal

1.  **¿Por qué no basta contar ecuaciones e incógnitas?** Ni necesario ni suficiente: no linealidad (0 o varias soluciones) y precios negativos.

2.  **¿Papel de la convexidad en la existencia y en el 1TFEB?** Sin ella $\mathbf{z}$ salta y no se aplica Brouwer; el 1TFEB no la necesita (solo no saciedad local); el 2TFEB, sí.

3.  **¿Qué dice SMD? ¿Contradice la existencia?** Solo continuidad, homogeneidad 0 y Walras sobreviven a la agregación: justo lo que basta para existir.

4.  **¿Por qué la sustitución bruta da unicidad y estabilidad?** Implica $\mathbf{p}^*\cdot\mathbf{z}(\mathbf{p})>0$ fuera de $\mathbf{p}^*$: impide otro equilibrio y hace bajar la distancia al equilibrio (ABH, 1959).

5.  **¿Ley de Walras o ley de Say?** Walras: identidad con todos los mercados, también el dinero; Say: bienes sin dinero $\equiv0$ (no hay exceso de oferta general).

6.  **¿Por qué el equilibrio walrasiano está en el núcleo?** Si una coalición mejorara con sus dotaciones, alguno habría comprado algo mejor a $\mathbf{p}^*$.

7.  **¿Por qué cuesta meter el dinero en Arrow-Debreu?** No da utilidad ni hace falta para cambiar o guardar valor; siempre hay un equilibrio en que no vale nada (Hahn).

8.  **¿Eficiente con mercados incompletos?** No, ni restringidamente (Hart, 1975; Geanakoplos-Polemarchakis, 1986).

> **Ojo en el test.**
>
> - Ley de Walras: identidad a *cualquier* precio; solo exige no saciedad local.
>
> - EGC: $z_k\leq0$ y $p_kz_k=0$; libre: $p^*_k=0$, $z_k\leq0$; económico: $p^*_k>0$, $z_k=0$.
>
> - Existencia: Wald (1935-36); punto fijo: Arrow-Debreu y McKenzie (1954); Brouwer funciones, Kakutani correspondencias.
>
> - 1TFEB sin convexidad; 2TFEB con convexidad y suma fija.
>
> - Sustitutivos brutos: único y *globalmente* estable (ABH, 1959). Scarf (1960): 3 bienes *complementarios*, equilibrio *único* pero inestable.
>
> - Regulares: nº *finito e impar* (Debreu, 1970). Núcleo: réplicas (1963), continuo (1964).
>
> - Patinkin: neutralidad *sin* dicotomía; homogeneidad 0 en precios *y* dinero.
>
> - Títulos de Arrow: $n+S$ mercados, no $n\cdot S$.
