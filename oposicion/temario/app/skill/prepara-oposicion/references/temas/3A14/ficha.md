<!-- Material exclusivo de victorgutierrezmarcos.es y la app Oposición TCEE · DCE. Forma parte de la skill «EconomIA»: solo para la preparación personal del opositor en su propia cuenta de Claude. No se autoriza copiarlo, redistribuirlo ni usarlo en otras plataformas o sistemas de IA (ver LICENCIA.md). -->
*Material exclusivo de victorgutierrezmarcos.es y la app Oposición TCEE · DCE. Forma parte de la skill «EconomIA»: solo para la preparación personal del opositor en su propia cuenta de Claude. No se autoriza copiarlo, redistribuirlo ni usarlo en otras plataformas o sistemas de IA (ver LICENCIA.md).*

# 3.A.14. Teoría de juegos. Principales conceptos. Aplicaciones, con especial referencia a las subastas.

*Ficha de repaso · actualizada el 21/10/2026*

## Esquema del cante

- **Introducción** · 2′30″

- **I. Conceptos (I): información completa** · 9′

- 1. Elementos, representación y clasificación · 1′30″

- 2. Estáticos: dominancia; EN; mixtas; minimax · 3′30″

- 3. Dinámicos: secuenciales (ENPS) y repetidos · 4′

- **II. Conceptos (II): incompleta y cooperativos** · 7′30″

- 1. Bayesianos (Harsanyi): EBN · 2′

- 2. EBP y señalización; criterio intuitivo · 2′

- 3. Negociación; núcleo; valor de Shapley · 3′30″

- **III. Aplicaciones: especial referencia a subastas** · 10′

- 1. Aplicaciones en economía · 1′30″

- 2. Diseño de mecanismos: revelación; límites · 2′

- 3. Subastas: formatos, equivalencia, colusión · 6′30″

- **Conclusión** · 1′

*Ejemplo*: **I** (instalada) y **E** (entrante): guerra de precios $\to$ entrada $\to$ cada mes $\to$ costes ocultos $\to$ consorcio con O $\to$ pujan por el 5G.

## Introducción (2′30″)

- **Enganche**: «Hoy por ti, mañana por mí»: ayudamos sin firmar nada a quien volveremos a ver; no somos mejores, cambia el *juego*. Julio de 2021: subasta de 700 MHz (5G), 12 rondas, 1.010 M€ (salida 995,5 M€). *¿Se puede predecir qué harán agentes interdependientes? ¿Y diseñar reglas para que revelen lo que saben?*

- **Relevancia**: *teórica* (lenguaje común de la micro; 6 Nobel: 1994, 1996, 2005, 2007, 2012, 2020); *empírica* (oligopolio [ver tema 3.A.19], negociación salarial [ver tema 3.A.27], entrada [ver tema 3.A.15], guerras comerciales [ver tema 3.B.7], credibilidad del BC [ver tema 3.A.36]); *de política* (el Estado subasta deuda, espectro, renovables, CO$_2$ y persigue cárteles en licitaciones).

- **Contextualización**: Cournot (1838), Bertrand (1883), Zermelo (1913) $\to$ minimax de von Neumann (1928) y *Theory of Games* (1944) $\to$ 1950-75: Nash (1950), Shapley (1953), Selten (1965), Harsanyi (1967) $\to$ desde los 70, aplicación masiva; desde los 90, diseño de subastas y mercados. En competencia perfecta y monopolio no hace falta [ver tema 3.A.16][ver tema 3.A.17]: sí con pocos agentes.

- **Problemática**: ¿qué predecir cuando cada uno elige pensando en los demás? ¿Cuándo es creíble una amenaza? ¿Qué cambia con turnos, repetición, información privada? ¿Cómo repartir las ganancias de cooperar? ¿Qué formato de subasta conviene? ¿Por qué la cooperación del refrán es un problema en las licitaciones?

- **Estructura**: I, información completa (elementos, estáticos, dinámicos); II, información incompleta, negociación y cooperativos; III, aplicaciones y subastas. Eje: el *concepto de equilibrio*, que se refina con cada ingrediente (tiempo, información privada, acuerdos); III le da la vuelta: elegir el juego que da el resultado deseado.

- **Teoría de juegos**: estudia situaciones de **interdependencia estratégica**: lo que obtiene cada agente depende de sus decisiones y de las de los demás, y cada uno lo sabe. **Juego**: su representación formal. La decisión con riesgo es el caso de 1 jugador frente a la naturaleza [ver tema 3.A.10].

## I. Principales conceptos (I): información completa (9′)

> Con información completa, el EN es el concepto central: existe siempre (en mixtas) en juegos finitos, pero puede ser ineficiente, múltiple o apoyarse en amenazas no creíbles; el ENPS lo afina y la repetición sostiene la cooperación sin contratos.

### I.1. Elementos, representación y clasificación

- *4 elementos* (Mas-Colell et al., 1995): **jugadores** $i\in N$; **reglas** (quién mueve, cuándo, qué sabe, qué **acciones**); **resultados**; **pagos** $u_i$ (utilidad esperada vNM si hay azar [ver tema 3.A.10]).

- **Estrategia** $s_i\in S_i$: *plan completo de acción*, qué hará en cada nodo en que pueda mover, incluso los que no se alcanzan $\neq$ acción. **Perfil** $s=(s_i,s_{-i})$. **Puras** o **mixtas** (al azar).

- **Conocimiento común** (Aumann, 1976): todos saben, todos saben que todos saben…

- *Representación*: **forma extensiva** (árbol: nodos de decisión, ramas, nodos terminales con pagos; **conjunto de información**: nodos que el jugador no distingue, línea discontinua); **forma normal** (matriz). Cada extensiva tiene una normal, no al revés: la normal pierde el orden de las jugadas.

- *Clasificación*: **no cooperativos**/**cooperativos** (acuerdos vinculantes; «no cooperativo» = la cooperación, si la hay, se sostiene sola); **estáticos** (simultáneos)/**dinámicos** (**secuenciales**, una vez por turnos; **repetidos**, un **juego de etapa** finito o infinitas veces); información **perfecta**/**imperfecta** (sobre las *jugadas*); **completa**/**incompleta** (sobre los *pagos*: el **tipo**); suma cero/variable.

|  | **Estáticos** | **Dinámicos** |
|:---|:---|:---|
| **Inf. completa** | **EN** (I.2) | **ENPS** (I.3) |
| **Inf. incompleta** | **EBN** (II.1) | **EBP** (II.2) |
| **Cooperativos** | negociación de Nash, núcleo, Shapley (II.3) |  |

- *Refinamientos*: cada concepto refina al anterior: todo ENPS es EN; todo EBP es EBN. Las subastas son juegos bayesianos.

### I.2. Juegos estáticos: dominancia y equilibrio de Nash

- **Estrictamente dominante**: $u_i(s_i,s_{-i})>u_i(s_i',s_{-i})$ $\forall s_i'\neq s_i$, $\forall s_{-i}$. **Débilmente dominada**: $\geq$ siempre y $>$ en alguna.

- *Ejemplo: guerra de precios* (I filas, E columnas):

|              |      **Alto**       |            **Bajo**             |
|:------------:|:-------------------:|:-------------------------------:|
| 2-3 **Alto** |       $(5,5)$       |       $(0,\underline{6})$       |
| 2-3 **Bajo** | $(\underline{6},0)$ | $(\underline{1},\underline{1})$ |
|     2-3      |                     |                                 |

- Bajar es dominante ($6>5$, $1>0$) $\Rightarrow$ (Bajo, Bajo), *ineficiente en el sentido de Pareto*: **dilema del prisionero** (Tucker, 1950): cártel [ver tema 3.A.19], polizón [ver tema 3.A.23], guerras arancelarias [ver tema 3.B.7], clemencia [ver tema 4.A.15].

- *Eliminación iterativa* de estrictamente dominadas: el orden no importa (con débiles, sí); cada ronda exige un nivel más de conocimiento común. Pocas veces decide.

- **Mejor respuesta** $R_i(s_{-i})=\arg\max_{s_i}u_i(s_i,s_{-i})$ (con acciones continuas, **función de reacción**). **Equilibrio de Nash** (EN; 1950): cada estrategia es mejor respuesta a las de los demás: $$u_i(s_i^*,s_{-i}^*)\geq u_i(s_i,s_{-i}^*)\ \ \forall s_i,\forall i\ \Longleftrightarrow\ s_i^*\in R_i(s_{-i}^*)$$

- Desigualdad *débil*. *Expectativas que se confirman*. Todo EN sobrevive a la eliminación iterativa, no al revés. Cálculo: subrayar mejores respuestas; casilla con los 2 subrayados.

- **Estrategia mixta** $\mathbf{\pi}_i\in\Delta(S_i)$: en el EN, cada jugador está *indiferente* entre las puras que mezcla $\Rightarrow$ *sus probabilidades dependen de los pagos del otro*.

- *Existencia* (Nash, 1950): todo juego con nº finito de jugadores y estrategias puras tiene al menos un EN en mixtas (punto fijo de Kakutani, 1941; Brouwer en 1951). Continuas: EN en puras si estrategias compactas y convexas y pagos continuos y cuasicóncavos (Cournot).

- *Ejemplo: la campaña* (I quiere coincidir, E evitarlo): sin EN en puras; mixtas al 50 %. *Clásicos*: pares o nones; *inspección* (si vigilar se encarece, no se vigila menos: el trabajador se escaquea más).

*[Gráfico: Inspección: mejores respuestas y EN en mixtas ($\pi_V^*=1/2$, $\pi_T^*=3/4$)]*

- *Implicaciones*: predicción mínima (si todos la conocen, ha de ser EN); base de los refinamientos; acciones continuas: corte de las funciones de reacción $=$ Cournot (1838); Bertrand: $p=\mathrm{CMg}$ [ver tema 3.A.19].

- **Teorema minimax** (von Neumann, 1928): 2 jugadores, suma cero: $\max_{\mathbf{\pi}_1}\min_{\mathbf{\pi}_2}U_1(\mathbf{\pi}_1,\mathbf{\pi}_2)=\min_{\mathbf{\pi}_2}\max_{\mathbf{\pi}_1}U_1(\mathbf{\pi}_1,\mathbf{\pi}_2)$

- **Valor del juego**; minimax = EN. No confundir con maximin de Wald (sin interdependencia) [ver tema 3.A.10]. *Evidencia*: penaltis (Palacios-Huerta, 2003: $>$1.400): igualan probabilidad de marcar por cada lado.

- *Valoración: 4 límites del EN*: i) puede no existir en puras; ii) *varios*: **juegos de coordinación**, **puntos focales** (Schelling, 1960: Puerta del Sol); ejemplo: estándar técnico = **batalla de los sexos** (Luce-Raiffa, 1957); amenazas de guerra = **juego de la gallina** (España-BCE, 2012); iii) no *eficiente en el sentido de Pareto*; iv) *amenazas no creíbles* en dinámicos.

### I.3. Juegos dinámicos: secuenciales y repetidos

- *Secuenciales: problema nuevo*, la **credibilidad**. *Ejemplo: entrada de E*: E entra o no; si entra, I acomoda o lucha. 2 EN: (Entrar, Acomodar) y (No entrar, Luchar si entra), este con amenaza *no creíble* ($1>-1$): «Perro ladrador, poco mordedor».

*[Gráfico: Entrada de E y compromiso de I: invertir antes en capacidad hace creíble luchar (en rojo, el ENPS)]*

- **Inducción hacia atrás**: un *procedimiento*: última decisión $\to$ sustituir el subárbol $\to$ repetir hacia la raíz. Juego finito de información perfecta: equilibrio en puras, único si no hay empates (Zermelo 1913; Kuhn 1953).

- **Subjuego**: parte del árbol desde un nodo con conjunto de información unitario, con todos sus sucesores, sin cortar conjuntos de información.

- **Equilibrio de Nash perfecto en subjuegos** (ENPS; Selten, 1965): induce un EN en *todo* subjuego, también fuera de la senda: **racionalidad secuencial**. Refinamiento del EN. Info. perfecta: ENPS = inducción hacia atrás.

- *Compromiso* (Schelling, 1960): reducir las propias opciones da más. Ej.: I invierte en capacidad (hundido 2,5): si E entra, acomodar $-1{,}5$ \< luchar $-1$ $\Rightarrow$ E no entra, I gana $4-2{,}5=1{,}5>1$ (Spence 1977, Dixit 1980) [ver tema 3.A.15]. «Quemar las naves» (Cortés, 1519).

- *Inconsistencia temporal*: conjetura de Coase (1972) [ver tema 3.A.17]; Kydland-Prescott (1977), Barro-Gordon (1983) [ver tema 3.A.36].

- *Extensiones*: juegos en 2 etapas (capacidad/localización $\to$ precios o cantidades) [ver tema 3.A.18][ver tema 3.A.19]; Stackelberg = ENPS de Cournot por turnos; Rubinstein.

- *Evidencia*: ciempiés (Rosenthal, 1981; McKelvey-Palfrey, 1992): casi nadie para al principio. *Valoración*: sin información perfecta apenas hay subjuegos $\Rightarrow$ creencias (EBP).

- *Repetidos*. Ej.: I y E se encuentran cada mes: «Hoy por ti, mañana por mí». Pagos descontados con $\beta\equiv1/(1+\rho)$. **Principio de la desviación única**: ENPS sii nadie gana desviándose en *una sola* etapa tras cualquier historia.

- *Horizonte finito* con EN de etapa único: único ENPS = repetirlo (inducción hacia atrás). **Paradoja de la cadena de tiendas** (Selten, 1978; 20 ciudades): acomoda en todas [ver tema 3.A.15].

- *Horizonte infinito* (o final incierto): **incondicionada** (EN de etapa siempre: ENPS, no saca del dilema) frente a **condicionadas**: **gatillo** (Friedman, 1971): cooperar mientras el otro coopere; si se desvía, EN para siempre. $u^{\mathrm C}/(1-\beta)\geq u^{\mathrm D}+\beta u^{\mathrm N}/(1-\beta)$: $$\beta\geq\frac{u^{\mathrm D}-u^{\mathrm C}}{u^{\mathrm D}-u^{\mathrm N}}$$

- Numerador: ganancia hoy; denominador: pérdida cada etapa después. Castigo creíble $\Rightarrow$ ENPS. Ej.: $(6-5)/(6-1)=1/5$; cada mes, $\beta\approx1$.

- *Otras*: *tit for tat* (ENPS solo con $\beta=1/5$ exacto); *tit for two tats* (no: ni EN); *win-stay, lose-shift* (sí si $\beta\geq1/4$ y $2u^{\mathrm C}>u^{\mathrm D}+u^{\mathrm N}$).

- **Teorema de tradición oral** (*folk theorem*): con infinitas repeticiones, *cualquier* pago medio factible por encima del castigo es ENPS si $\beta\to1$ (Friedman 1971, reversión al EN; Fudenberg-Maskin 1986, minimax). Ej.: entre 1 y 5.

- *Implicaciones*: colusión tácita [ver tema 3.A.19], reputación [ver tema 3.A.36], acuerdos comerciales [ver tema 3.B.7]; también cárteles en licitaciones. Más cooperación con más paciencia, más frecuencia, detección rápida. *Reputación* con tipos «irracionales» (Kreps-Milgrom-Roberts-Wilson, 1982) deshace la paradoja.

- *Evidencia*: torneos de Axelrod (1984): gana *tit for tat*; con errores, *win-stay* (Nowak-Sigmund, 1993); Dal Bó (2005). *Valoración*: permite demasiado $\Rightarrow$ *selección de equilibrios*.

## II. Principales conceptos (II): información incompleta, negociación y cooperativos (7′30″)

> La información privada se trata con tipos, probabilidades y creencias (EBN, EBP); con acuerdos vinculantes, la pregunta pasa a ser cómo repartir lo que el grupo puede conseguir (Nash, núcleo, Shapley).

### II.1. Juegos bayesianos: equilibrio bayesiano de Nash

- *Truco de Harsanyi* (1967): la **Naturaleza** elige el **tipo** $t_i$ de cada uno según una **distribución a priori** común; cada uno ve el suyo $\Rightarrow$ información incompleta $\to$ *imperfecta*.

- *Estrategia*: *regla* $s_i(t_i)$ según el tipo (los rivales tienen que anticipar qué haría cada tipo).

- **Equilibrio bayesiano de Nash** (EBN): cada tipo maximiza su pago *esperado*, dadas creencias y estrategias: EN del juego en que cada tipo es un jugador: $\mathbb{E}_{t_{-i}}\big[u_i(s_i^*(t_i),s_{-i}^*(t_{-i});t_i)\,|\,t_i\big]\geq\mathbb{E}_{t_{-i}}\big[u_i(s_i,s_{-i}^*(t_{-i});t_i)\,|\,t_i\big]$

- *Ejemplo*: E entra mientras I decide si amplía; I de coste alto ($\pi$) nunca amplía, de coste bajo siempre (dominantes). E: $\pi\cdot1+(1-\pi)(-1)=2\pi-1\geq0$ $\Rightarrow$ entra si $\pi\geq1/2$.

*[Gráfico: Entrada sin conocer el coste de I: la Naturaleza elige el tipo; línea discontinua, nodos que E no distingue]*

- *Implicaciones*: se responde a lo que se *espera*; subastas (tipo $=v_i$, estrategia $b(v_i)$) y selección adversa [ver tema 3.A.13]. *Extensiones*: Cournot con costes privados; *purificación* (Harsanyi, 1973). *Valoración*: la **doctrina de Harsanyi** (a priori común) es fuerte.

### II.2. Equilibrio bayesiano perfecto y señalización

- *Idea*: si el informado mueve primero, su acción revela su tipo. Ej.: el precio de I es una señal; E actualiza con la **regla de Bayes**: «Cuando el río suena, agua lleva» (precio límite, Milgrom-Roberts 1982 [ver tema 3.A.15]): $\mu(\text{precio})=\dfrac{\pi\Pr(\text{precio}|\text{alto})}{\pi\Pr(\text{precio}|\text{alto})+(1-\pi)\Pr(\text{precio}|\text{bajo})}$

- *Modelo* (Spence, 1973, como juego [ver tema 3.A.13]): tipos A ($\nu$) y B; $w_{\mathrm A}>w_{\mathrm B}$; educación $y$ improductiva, $c_{\mathrm A}(y)<c_{\mathrm B}(y)$, $c_{\mathrm A}'<c_{\mathrm B}'$ (cruce único); $w(y)=\mu(y)w_{\mathrm A}+[1-\mu(y)]w_{\mathrm B}$.

- **Equilibrio bayesiano perfecto** (EBP): estrategias + **creencias** con 3 condiciones: i) *racionalidad secuencial* dadas las creencias; ii) *Bayes en la senda*; iii) *fuera de la senda*, libres (EBP débil) o con requisitos.

- **Separadores**: A elige $\hat y$, B 0; $\mu(\hat y)=1$, $\mu(0)=0$, si $c_{\mathrm A}(\hat y)\leq w_{\mathrm A}-w_{\mathrm B}\leq c_{\mathrm B}(\hat y)$

- **Agrupadores**: misma $y$, $\mu=\nu$, $\overline w=\nu w_{\mathrm A}+(1-\nu)w_{\mathrm B}$; con creencias pesimistas fuera de la senda.

- **Criterio intuitivo** (Cho-Kreps, 1987): quien elige lo que B no elegiría nunca y A sí $\Rightarrow$ es A. Elimina agrupadores y deja el separador más barato: $c_{\mathrm B}(\hat y^*)=w_{\mathrm A}-w_{\mathrm B}$. *Clásico*: *cerveza o quiche*.

- *Implicaciones*: las creencias fuera del equilibrio sostienen el resultado; la señal cuesta eficiencia. *Refinamientos*: **equilibrio secuencial** (Kreps-Wilson, 1982); **mano temblorosa** (Selten, 1975). *Valoración*: completa la tabla, pero vuelve la multiplicidad.

### II.3. Negociación y juegos cooperativos

- *Idea*: indeterminación de Edgeworth [ver tema 3.A.21] y Bowley [ver tema 3.A.17]; **programa de Nash**: los caminos cooperativo y no cooperativo llegan al mismo sitio. Ej.: acceso de E a la red de I.

- *Supuestos*: $\mathcal{U}$ convexo y compacto; **punto de desacuerdo** $(u_1^0,u_2^0)$.

- *Axiomático* (Nash, 1950): eficiencia, simetría, invariancia afín, independencia de alternativas irrelevantes $\Rightarrow$ máx. producto de ganancias ($\gamma=1/2$); **generalizada**, **poder de negociación** $\gamma$: $$\begin{array}{rl}\max_{u_1,u_2} & (u_1-u_1^0)^{\gamma}(u_2-u_2^0)^{1-\gamma} \\ \text{s.a.} & (u_1,u_2)\in\mathcal{U}\end{array}$$

- *Estratégico* (Rubinstein, 1982): ofertas alternadas por 1 €, descuentos $\beta_1,\beta_2$; único ENPS, acuerdo inmediato: $x^*=\dfrac{1-\beta_2}{1-\beta_1\beta_2}$;$\Delta\to0$: $\gamma=\dfrac{\rho_2}{\rho_1+\rho_2}$

- Gana el más paciente (Binmore-Rubinstein-Wolinsky, 1986): poder = *paciencia relativa*. Aplicaciones: monopolio bilateral [ver tema 3.A.17], salarios [ver tema 3.A.27], cártel [ver tema 3.A.19]. *Evidencia*: **ultimátum** (Güth et al., 1982): ofertas cercanas a la mitad, rechazo de las bajas [ver tema 3.A.1].

- *Cooperativos*: acuerdos vinculantes y **utilidad transferible**; **coaliciones** $T\subseteq N$; **función característica** $v(T)$; **imputación**: eficiente ($\sum x_i=v(N)$) e individualmente racional ($x_i\geq v(\{i\})$).

- **Núcleo** (Gillies, 1959): imputaciones que ninguna coalición **bloquea**: $\mathcal{C}(v)=\{x:\sum_{N}x_i=v(N),\ \sum_{T}x_i\geq v(T)\ \forall T\}$

- *Ejemplo*: I vende su red (20 solo); E la valora en 60, O en 100. Núcleo: $x_2=0$, $x_1\in[60,100]$, $x_3=100-x_1$: la red va a O a un precio entre la 2.ª y la 1.ª valoración (como una subasta inglesa).

*[Gráfico: Imputaciones y núcleo del juego de I (vendedor), E y O]*

- *Límites*: puede ser *vacío* (mayoría por 100); Bondareva-Shapley: no vacío sii juego *equilibrado*; rara vez un punto; se encoge al walrasiano (Debreu-Scarf, 1963) [ver tema 3.A.21].

- **Valor de Shapley** (1953): 4 axiomas (eficiencia, simetría, jugador nulo, aditividad) $\Rightarrow$ regla única: $\phi_i(v)=\displaystyle\sum_{T\subseteq N\setminus\{i\}}\frac{|T|!\,(n-|T|-1)!}{n!}\big[v(T\cup\{i\})-v(T)\big]$

- *Aportación marginal esperada* con orden de llegada aleatorio. Ej.: $\phi=(66\tfrac23,\,6\tfrac23,\,26\tfrac23)$: *no* está en el núcleo (da algo a E). Siempre existe y es único; en el núcleo si el juego es *convexo* (Shapley, 1971). Usos: poder de voto (Shapley-Shubik, 1954) [ver tema 3.A.24], costes comunes, cárteles, aprendizaje automático.

## III. Aplicaciones, con especial referencia a las subastas (10′)

> El diseñador elige las reglas: basta buscar mecanismos en que decir la verdad sea óptimo; la información privada tiene un coste que el diseño reduce pero no elimina; en subastas, con valores privados independientes, el formato importa menos de lo que parece: lo decisivo es atraer pujadores y evitar la colusión.

### III.1. Aplicaciones en economía

- *OI*: Cournot, Bertrand, Stackelberg, colusión tácita [ver tema 3.A.19]; diferenciación por etapas [ver tema 3.A.18]; entrada, capacidad, precio límite [ver tema 3.A.15].

- *Información asimétrica*: señalización, autoselección, principal-agente [ver tema 3.A.13]; regulación [ver tema 3.A.17]. *Trabajo*: negociación [ver tema 3.A.27].

- *Sector público*: polizón, Clarke-Groves [ver tema 3.A.23]; voto estratégico, Gibbard-Satterthwaite [ver tema 3.A.24]; imposición óptima [ver tema 4.B.11].

- *Comercio*: guerra arancelaria (Johnson, 1953) [ver tema 3.B.7]; Brander-Spencer (1985) [ver tema 3.B.8]. *Macro*: inconsistencia temporal [ver tema 3.A.36]; ataques especulativos [ver tema 3.B.17].

- *Competencia*: clemencia [ver tema 4.A.15]. *Diseño de mercados*: aceptación diferida (Gale-Shapley, 1962; Roth). *Evolutiva* (Maynard Smith-Price, 1973) y conductual [ver tema 3.A.1].

### III.2. Diseño de mecanismos y principio de revelación

- *Idea*: elegir las reglas (Hurwicz, 1960, 1972; debate del cálculo socialista [ver tema 3.A.21]). Ej.: el Gobierno no sabe cuánto valen las licencias.

- **Mecanismo**: mensajes $\to$ asignación y pagos (tipos $\to$ mensajes $\to$ resultado); induce un juego bayesiano. **Directo**: el mensaje es el tipo.

- **Principio de revelación** (Gibbard 1973; Dasgupta-Hammond-Maskin 1979; Myerson 1979): todo EBN equivale a un mecanismo directo compatible con los incentivos en que todos dicen la verdad. Basta buscar con $\mathrm{PC}_i$ (participación) e $\mathrm{IC}_i$ (compatibilidad de incentivos).

- *Clásico*: juicio de Salomón: funcionó por sorpresa, no en equilibrio.

- **VCG** (Vickrey 1961, Clarke 1971, Groves 1973): pagar el daño que se causa a los demás $\Rightarrow$ verdad *dominante* y decisión eficiente; caso más sencillo, 2.º precio.

- *Implicaciones*: hay que dejar **renta informativa** [ver tema 3.A.13][ver tema 3.A.17][ver tema 4.B.11]. *Implementación* (Maskin, 1999): en todos los equilibrios, monotonía.

- *Límites*: Gibbard-Satterthwaite ($\geq3$ alternativas: no manipulable $\Rightarrow$ dictatorial; VCG necesita dinero) [ver tema 3.A.24]; Myerson-Satterthwaite (1983): intercambio bilateral, ningún mecanismo eficiente, IC, voluntario y sin déficit; el diseñador ha de poder comprometerse.

### III.3. Subastas

- **Subasta**: mecanismo de asignación y precio a partir de las pujas; la competencia revela valoraciones y reduce rentas de información (Klemperer, 2004).

- *Formatos*: **abiertos**: **inglesa** (ascendente) y **holandesa** (descendente; Aalsmeer, lonjas); **sobre cerrado**: **primer precio** (paga su puja) y **segundo precio** o de Vickrey (paga la 2.ª). Abierta $\neq$ secuencial.

- *Valores*: **privados** ($v_i$ propio; VPI si independientes); **común** (igual para todos, nadie lo sabe: petróleo); **afiliados** (Milgrom-Weber, 1982). Juego bayesiano: estrategia $b(v_i)$, solución EBN.

| **Formato** | **Gana y paga** | **Puja (VPI)** |
|:---|:---|:---|
| **Inglesa** | último; precio al que se retira el penúltimo | hasta $v_i$ (= 2.º precio) |
| **2.º precio** | puja más alta; paga la 2.ª | $b=v_i$ (dominante) |
| **1.^(er) precio** | puja más alta; paga la suya | sombrear: $\frac{n-1}{n}v_i$ |
| **Holandesa** | primero que acepta | = 1.^(er) precio (siempre) |
| *Equivalencia*: los 4 eficientes; ingreso $\frac{n-1}{n+1}$ con $U[0,1]$ |  |  |

- *Modelo de referencia (VPI)*: 1 objeto, $n$ pujadores *neutrales al riesgo* y *simétricos*, $v_i$ independientes de $F$ continua ($U[0,1]$); $v_0=0$, sin reserva.

- *2.º precio*: $b(v_i)=v_i$ *débilmente dominante* (Vickrey, 1961): la puja decide *si* gana, no *cuánto* paga; eficiente. Ej.: $v_{\mathrm I}=10$, $v_{\mathrm E}=8$, $v_{\mathrm O}=6$: I gana y paga 8. *Inglesa*: equivalente con valores privados.

- *1.^(er) precio*: dilema (más puja $\uparrow$ prob. de ganar, $\downarrow$ ganancia): $\max_{b_i}(v_i-b_i)\Pr(\text{ganar})$; con $U[0,1]$: $$b(v_i)=\frac{n-1}{n}\,v_i=\mathbb{E}\big[Y_1\,|\,Y_1<v_i\big]$$

- Puja lo que espera pagar en 2.º precio; $\uparrow n$ $\Rightarrow$ sombrea menos. Ej. ($U[0,12]$, $n=3$): 6,67, 5,33 y 4. *Holandesa*: estratégicamente equivalente al 1.^(er) precio con cualquier valor.

*[Gráfico: Pujas de equilibrio con VPI uniformes: $b=v$ y $b=\frac{n-1}{n}v$]* · *[Gráfico: Varias unidades: precio uniforme frente a discriminatorio]*

- **Teorema de equivalencia de ingresos** (Vickrey 1961; Myerson 1981; Riley-Samuelson 1981): neutrales, simétricos, VPI; todo formato en que i) gana quien más valora y ii) el tipo más bajo espera 0 da el *mismo ingreso esperado*: $\mathbb{E}[I^{\mathrm{1P}}]=\tfrac{n-1}{n}\mathbb{E}[v_{(1)}]=\mathbb{E}[v_{(2)}]=\mathbb{E}[I^{\mathrm{2P}}]=\tfrac{n-1}{n+1}$

- Intuición (envolvente): lo que espera ganar cada tipo depende solo de con qué probabilidad gana. Ej.: 8 frente a 6,67; en promedio, $12\cdot\frac24=6$. También «todos pagan».

- *Subasta óptima* (Myerson; Riley-Samuelson, 1981): formato estándar + **precio de reserva** con $\psi(p^R)=v_0$; **valor virtual** $\psi(v)=v-\frac{1-F(v)}{f(v)}$ (IMg del monopolista [ver tema 3.A.17]). $U[0,1]$: $\psi=2v-1$, $p^R=1/2$ $\forall n$; con 2: $1/3\to5/12$. Sacrifica eficiencia. Bulow-Klemperer (1996): un pujador más ($1/2$) vale más que la reserva.

- *Aversión al riesgo*: 1.^(er) precio recauda más (Holt 1980; Maskin-Riley 1984). *Asimetría*: sin ordenación general (Maskin-Riley, 2000).

- **Maldición del ganador**: con valor común gana quien más sobrestimó; racional: pujar *por debajo* de la estimación, más con más rivales (Wilson, 1969, 1977). «No es oro todo lo que reluce». *Clásicos*: golfo de México (Capen-Clapp-Campbell, 1971); jarra de monedas (Bazerman-Samuelson, 1983).

- **Principio de vinculación** (Milgrom-Weber, 1982): valores afiliados $\Rightarrow$ ingreso esperado inglesa $\geq$ 2.º precio $\geq$ 1.^(er) precio = holandesa; al vendedor le conviene revelar información.

- *Evidencia*: Kagel-Levin (1986, 1993): maldición en el laboratorio; en 1.^(er) precio se puja de más. Reserva en acción: renovables y 26 GHz en 2022 (datos clave).

- *Valoración* (Klemperer, 2002): importa *atraer pujadores* y *evitar la colusión*. 3G (2000): RU, 5 licencias para 4 instalados. Ascendentes desaniman a los débiles; híbrida *anglo-holandesa*.

- *Varias unidades*: **precio uniforme** (todos pagan la última aceptada $\Rightarrow$ **reducción de la demanda**) frente a **discriminatorio** (cada uno sus pujas); ninguno domina. Objetos distintos con complementariedades: **SMRA** (Milgrom, Wilson, McAfee; regla de actividad; FCC 1994: 10 licencias, 47 rondas, 617 M\$); **combinatorias**, reloj, incentivos (FCC 2016-17).

- *España y UE*: Tesoro, «convencional corregida» (sobre el precio medio pagan el medio; entre medio y mínimo, lo ofrecido) [ver tema 4.B.26]; espectro 3,6-3,8 GHz (2018), 700 MHz (2021) [ver tema 4.A.12]; renovables (REER: paga lo ofrecido, con reserva) [ver tema 4.A.5]; derechos de emisión UE: ronda única, sobre cerrado, precio uniforme [ver tema 4.A.6].

- **Colusión** (*bid rigging*): **ofertas de cobertura** y **rotación de ofertas** (Asker, 2010): «Hoy gano yo, mañana tú». Con 2, el que espera: $G\beta/(1-\beta^2)\geq G$: $\dfrac{\beta}{1-\beta^2}\geq1\ \Longleftrightarrow\ \beta\geq\dfrac{\sqrt5-1}{2}\approx0{,}62$;con 3: $\dfrac{\beta^2}{1-\beta^3}\geq1$, $\beta\gtrsim0{,}755$

*[Gráfico: Gatillo y colusión: lo que se gana desviándose (rojo) frente a lo que se pierde con el castigo (azul)]*

- Subastas cada 5 años al 10 %: $\beta=1/1{,}1^5\approx0{,}62$.

- *Remedios* (que no haya «mañana»): sobre cerrado; no publicar pujas; más pujadores; precio de reserva; clemencia [ver tema 4.A.15]. *Clásico*: Alemania 1999 (Mannesmann 18,18 y 20; $18{,}18\times1{,}1\approx20$; 2 rondas).

## Conclusión (1′)

- **Recapitulación**: EN (siempre en mixtas; ineficiente o múltiple) $\to$ ENPS (credibilidad, compromiso; repetición sostiene la cooperación) $\to$ EBN y EBP (creencias, señales) $\to$ Nash, núcleo, Shapley $\to$ diseño de mecanismos: equivalencia; valor común, entrada y colusión deciden. I y E han recorrido todo el camino.

- **Relevancia**: Nobel 2020, Milgrom y Wilson: maldición del ganador, vinculación, formatos para muchos objetos (eficiencia, no máxima recaudación); espectro en medio mundo, también en España.

- **Extensiones**: oligopolio [ver tema 3.A.19], entrada [ver tema 3.A.15], información asimétrica [ver tema 3.A.13], elección colectiva [ver tema 3.A.24], credibilidad [ver tema 3.A.36], competencia [ver tema 4.A.15], conductual [ver tema 3.A.1].

- **Opinión**: demasiados equilibrios y racionalidad exigente (conocimiento común); pero su mayor éxito es práctico: se juzga por cómo funcionan las instituciones que diseña (teoría + experimentos + experiencia).

- **Idea final**: «Hoy por ti, mañana por mí»: la repetición sostiene la cooperación, para bien (reputación) y para mal («hoy gano yo, mañana tú»). Una buena subasta se diseña para que no haya «mañana» que repartir.

## Autores y fechas

**1838** Cournot: duopolio (caso del EN)

**1928** von Neumann: teorema minimax

**1944** von Neumann-Morgenstern: *Theory of Games*

**1950** Nash: equilibrio y negociación; Tucker: prisionero

**1953** Shapley: valor; Kuhn: inducción hacia atrás

**1960** Schelling: puntos focales, compromiso; Hurwicz

**1961** Vickrey: subasta de 2.º precio, equivalencia

**1965** Selten: perfección en subjuegos (ENPS)

**1967** Harsanyi: información incompleta

**1971** Friedman: gatillo; Capen et al.: maldición

**1973** Spence: señalización; Gibbard

**1978** Selten: paradoja de la cadena de tiendas

**1979** Myerson: principio de revelación

**1981** Myerson; Riley-Samuelson: subasta óptima

**1982** Rubinstein; Milgrom-Weber; KMRW

**1984** Axelrod: torneos (*tit for tat*)

**1986** Fudenberg-Maskin: *folk theorem*

**1987** Cho-Kreps: criterio intuitivo

**1996** Bulow-Klemperer: un pujador más

**2002** Klemperer: lo que de verdad importa

## Datos clave

- Subasta de 700 MHz (jul. 2021): **1.010 M€ tras 12 rondas (salida 995,5 M€)** (Ministerio, 2021).

- 3,6-3,8 GHz (2018): **437,6 M€, 34 rondas, $>$4 veces la salida** (Ministerio, 2018).

- Tesoro, 2025: **46 subastas, 80 % de la financiación a medio y largo plazo** (Tesoro, 2026).

- 1.ª subasta de renovables (ene. 2021): **9.700 MW ofertados para 3.034; 24,47 €/MWh FV, 25,31 eólica** (MITECO, 2021).

- 4.ª subasta (nov. 2022): **45,5 de 3.300 MW** (MITECO, 2022); 26 GHz (dic. 2022): **9 de 12 estatales y 1 de 38 autonómicas, 36,2 M€** (Ministerio, 2022).

- 3G (2000): **RU y Alemania $>$600 €/hab.; Países Bajos 170; Suiza 20** (Klemperer, 2002).

- FCC, SMRA: **1994: 617 M\$; en 20 años, $>$120.000 M\$** (Nobel, 2020).

- CNMC (jul. 2022): **203,6 M€ a 6 constructoras, 25 años de licitaciones** (CNMC, 2022).

## Preguntas del tribunal

1.  **¿Diferencia entre información completa y perfecta?** Completa: pagos conocidos; perfecta: jugadas anteriores conocidas. El prisionero: completa e imperfecta. Harsanyi convierte la incompleta en imperfecta.

2.  **¿Por qué el ENPS y no el EN en la entrada?** El EN (No entrar, Luchar) descansa en una amenaza no creíble; el ENPS exige EN en todo subjuego.

3.  **¿De qué dependen las probabilidades de un EN en mixtas?** De los pagos del *otro* jugador (indiferencia).

4.  **¿Se puede cooperar en un dilema repetido?** Infinito y $\beta$ alto: sí (gatillo, *folk theorem*); finito con EN único: no.

5.  **¿Está el valor de Shapley en el núcleo?** No siempre; sí en juegos convexos. En el ejemplo, no.

6.  **¿Qué formato de subasta recauda más?** Con VPI, neutrales y simétricos, todos igual; con afiliados, la inglesa; con aversión al riesgo, 1.^(er) precio. En la práctica, atraer pujadores y evitar la colusión.

> **Ojo en el test.**
>
> - Desigualdad del EN *débil*; mixtas: dependen de los pagos del otro (encarecer la vigilancia no cambia cuánto se vigila).
>
> - Eliminación iterativa: con estrictas, el orden no importa; con débiles, sí.
>
> - Todo ENPS es EN, no al revés; todo EBP es EBN. Inducción hacia atrás = procedimiento.
>
> - Gatillo: $\beta\geq(u^{\mathrm D}-u^{\mathrm C})/(u^{\mathrm D}-u^{\mathrm N})$; *tit for tat* solo es ENPS con un $\beta$ concreto.
>
> - 2.º precio: *débilmente* dominante; holandesa = 1.^(er) precio siempre; inglesa = 2.º solo con valores privados.
>
> - Deuda pública: «holandesa» = precio único y «americana» = precio ofrecido (en teoría, holandesa = descendente).
>
> - Reserva óptima con $U[0,1]$: $1/2$ sea cual sea $n$; supera $v_0$ (ineficiente).
