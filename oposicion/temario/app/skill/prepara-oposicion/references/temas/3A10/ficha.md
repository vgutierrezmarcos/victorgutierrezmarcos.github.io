<!-- Material exclusivo de victorgutierrezmarcos.es y la app Oposición TCEE · DCE. Forma parte de la skill «Prepara con Claude»: solo para la preparación personal del opositor en su propia cuenta de Claude. No se autoriza copiarlo, redistribuirlo ni usarlo en otras plataformas o sistemas de IA (ver LICENCIA.md). -->
*Material exclusivo de victorgutierrezmarcos.es y la app Oposición TCEE · DCE. Forma parte de la skill «Prepara con Claude»: solo para la preparación personal del opositor en su propia cuenta de Claude. No se autoriza copiarlo, redistribuirlo ni usarlo en otras plataformas o sistemas de IA (ver LICENCIA.md).*

# 3.A.10. Teoría de la demanda del consumidor (III). Elección del consumidor en situaciones de riesgo e incertidumbre.

*Ficha de repaso · actualizada el 19/10/2026*

## Esquema del cante

- **Introducción** · 2′30″

- **I. Riesgo: teoría de la utilidad esperada** · 13′

- 1. Fundamentos: axiomas, TUE, $\rho$, $r_A$, dominancia · 8′

- 2. Aplicaciones: demanda de seguros (Mossin) · 4′

- 3. Extensiones: estados y contingentes · 1′

- **II. Riesgo: críticas y enfoques alternativos** · 8′

- 1. Friedman-Savage, Markowitz, Allais, marco · 3′30″

- 2. Teoría de las perspectivas · 4′30″

- **III. Incertidumbre** · 5′30″

- 1. Probabilidad subjetiva (Savage); Ellsberg · 3′

- 2. Ambigüedad; criterios clásicos · 2′30″

- **Conclusión** · 1′

*Hilo*: de lo conocido (riesgo) a lo desconocido (incertidumbre); en cada caso, modelo $\to$ paradoja (Allais, Ellsberg) $\to$ alternativa. *Pizarra*: $U(\tilde{x})=\sum_s\pi_s\,u(x_s)$ en una esquina todo el cante; gráficos de la actitud ante el riesgo, del seguro y de la función de valor en S.

## Introducción (2′30″)

- **Enganche**: *¿Somos prudentes o temerarios ante el riesgo?* «Más vale pájaro en mano que ciento volando», pero «de perdidos, al río». España, 2025: **$\approx$86.000 M€ en primas de seguro, $\approx$5 % del PIB** (Mapfre; Eurostat), y en diciembre, el décimo de Navidad (devuelve menos de lo que recauda). Con el seguro se paga por *librarse* del riesgo; con el décimo, por *asumirlo*.

- **Relevancia**: *teórica*, lenguaje de toda la economía con riesgo: información asimétrica [ver tema 3.A.13], juegos y subastas [ver tema 3.A.14], mercados contingentes [ver tema 3.A.21], ahorro [ver tema 3.A.33], dinero como activo [ver tema 3.A.35], carteras [ver tema 3.B.23]; *práctica*, asegurarse, ahorrar, invertir, hipoteca fija o variable; sus fallos, origen de la economía conductual [ver tema 3.A.1].

- **Contextualización**: *riesgo*, de *riesco*, «risco». Cramer (1728), Bernoulli (1738): San Petersburgo $\to$ Knight, Keynes (1921) $\to$ von Neumann-Morgenstern (1944) $\to$ Savage (1954) $\to$ Pratt (1964), Arrow (1965) $\to$ anomalías: Allais (1953), Ellsberg (1961) $\to$ perspectivas (Kahneman-Tversky, 1979; Nobel 2002) y ambigüedad (1989).

- **Problemática**: ¿qué hace falta para maximizar una utilidad *esperada* y qué dice de la actitud ante el riesgo? ¿Qué demanda de seguros sale? ¿Se comportan así las personas? ¿Qué cambia sin probabilidades conocidas?

- **Estructura**: I, utilidad esperada (fundamentos, seguros, extensiones); II, críticas y perspectivas; III, incertidumbre. II y III, misma lógica: modelo, paradoja, alternativa.

- **Individualismo metodológico** [ver tema 3.A.8]: ahora cada alternativa lleva a varios resultados posibles.

- **Riesgo**: probabilidades conocidas y *objetivas* (moneda, tablas de mortalidad). **Incertidumbre**: sin ellas; a lo sumo, creencias *subjetivas* (Knight, 1921).

## I. Riesgo: teoría de la utilidad esperada (13′)

- *Conclusión anticipada*: con 5 axiomas sobre loterías se elige *como si* se maximizara la esperanza de una utilidad; su curvatura mide la aversión y basta para la demanda de seguros (completa con prima justa).

### I.1. Fundamentos

- *Idea*: la **teoría de la utilidad esperada** (TUE) aplica el método del consumidor [ver tema 3.A.8] (conjunto de elección, preferencias, axiomas, $U$, maximización), con 2 diferencias: (1) se eligen *loterías*, no cestas; (2) $U$ con forma concreta, *lineal en las probabilidades*.

- *Supuestos*: $S$ **estados de la naturaleza**, mutuamente excluyentes y colectivamente exhaustivos; resultado $x_s$ (riqueza). **Lotería** $\tilde{x}\equiv(x_1,\dots,x_S;\ \pi_1,\dots,\pi_S)$, $\pi_s\geq0$, $\sum_s\pi_s=1$: *simple*, *compuesta* (se reduce multiplicando ramas) o *degenerada* (certeza); un punto del **símplex**. **No se eligen resultados, sino loterías**.

- *Axiomas* sobre $\succcurlyeq$: *preorden completo*: (1) **completitud**, (2) **reflexividad**, (3) **transitividad**; *regularidad*: (4) **continuidad** (sin resultados infinitamente buenos o malos) $\Rightarrow$ existe $U$; (5) **axioma de independencia**, el propio del riesgo, $\tau\in(0,1)$: $\tilde{x}^1\succcurlyeq\tilde{x}^2\iff\tau\tilde{x}^1+(1-\tau)\tilde{x}^3\succcurlyeq\tau\tilde{x}^2+(1-\tau)\tilde{x}^3$ Solo ocurre *una* rama: lo común ($\tilde{x}^3$) no debe alterar el orden.

- *Desarrollo*: **teorema de la utilidad esperada** (von Neumann-Morgenstern, 1944; prueba en la 2.ª ed., 1947): con los 5 axiomas existe $u(\cdot)$ sobre resultados ciertos, la **utilidad de Bernoulli**, tal que $$U(\tilde{x})=\mathbb{E}\big[u(\tilde{x})\big]=\sum_{s=1}^{S}\pi_s\,u(x_s)$$ $U$: **utilidad esperada**. Construcción: $u(x)=\tau$ que iguala $x$ seguro a (mejor, $\tau$; peor, $1-\tau$).

- *Implicaciones*: preserva el orden; lineal en probabilidades y *separable* entre estados; $u$ única salvo *afines positivas* $a\,u+b$ $\Rightarrow$ **cardinal** (sin comparaciones interpersonales); $u$ es un *resultado*. Continuo: $U=\int u(x)\,dF(x)$.

- *Idea central*: **esperanza de la utilidad, no utilidad de la esperanza**. **Paradoja de San Petersburgo** (N. Bernoulli, 1713): premio $2^k$ con prob. $1/2^k$ $\Rightarrow$ $\mathbb{E}[\tilde{x}]=\infty$; con $u=\ln x$, $\xi=4$ ducados (con $\sqrt{x}$, Cramer, $\approx$5,83).

- *Valoración*: fundamento axiomático y contrastable; el discutido, la independencia (II.1).

- *Componentes*: *subjetivo*, $u(x)$ $\to$ actitud ante el riesgo; *objetivo*, $F(x)$ $\to$ comparar loterías sin conocer $u$.

- *Actitud ante el riesgo* (desigualdad de Jensen): **averso** si $u(\mathbb{E}[\tilde{x}])>\mathbb{E}[u(\tilde{x})]$ $\iff$ $u$ estrictamente cóncava; **neutral**, $=$, lineal; **amante**, $<$, convexa. Averso: el euro perdido duele más que lo que alegra el ganado.

*[Gráfico: Cuerda (utilidad esperada) y curva (utilidad del valor esperado): averso, neutral y amante]*

- *Definiciones*: **equivalente cierto** $\xi$: $u(\xi)=\mathbb{E}[u(\tilde{x})]$. **Prima de riesgo** $\rho\equiv\mathbb{E}[\tilde{x}]-\xi$: lo que se sacrifica en valor esperado por librarse del riesgo (o la rentabilidad extra exigida). Averso $\iff\xi<\mathbb{E}[\tilde{x}]\iff\rho>0$.

- *Ejemplo*: $u=\sqrt{x}$, riqueza 64, pierde 48 con prob. $\frac12$: $\mathbb{E}[\tilde{x}]=40$, $\mathbb{E}[u]=6$, $\xi=36$, $\rho=4$. **Prima actuarialmente justa**: pérdida esperada, 24. **Prima máxima**: $64-\xi=28=24+4$; ese margen hace posible el negocio asegurador.

*[Gráfico: $\xi=36$, $\rho=4$, prima justa 24 y prima máxima 28]*

- *Medidas* (Pratt, 1964; Arrow, 1965): curvatura normalizada por la pendiente, invariante a $a\,u+b$: $r_A(x)\equiv-\dfrac{u''(x)}{u'(x)}$,$r_R(x)\equiv x\,r_A(x)$,$\rho\approx\tfrac12\,\sigma^2\,r_A(\overline{W})$ $r_R$: elasticidad de la UMg cambiada de signo. Prima de *segundo orden* ($\sigma^2$); en el ejemplo, 3,6 frente a 4.

- *Comparación*: **teorema de Pratt**; equivalen (1) $r_A^1\geq r_A^2\ \forall x$; (2) $u_1=\psi(u_2)$, $\psi$ creciente y cóncava; (3) $\rho_1\geq\rho_2$ para toda lotería; (4) lo que el 1.º acepta frente a un cierto, lo acepta el 2.º. Evidencia: $r_R\approx1$ (Chetty, 2006).

- *Aversión y riqueza*: CARA, DARA, IARA (y CRRA, DRRA, IRRA). Evidencia e intuición: **DARA** (el rico arriesga más *en euros*). Familias, todas **HARA** ($1/r_A=\eta_0+\eta_1x$ lineal):

| **Función** | $u(x)$ | $r_A$ | $r_R$ | **Tipo** |
|:---|:---|:---|:---|:---|
| **CARA** | $-e^{-ax}$ | $a$ | $a\,x$ | CARA, IRRA |
| **CRRA** | $\frac{x^{1-\theta}-1}{1-\theta}$ ($\ln x$ si $\theta=1$) | $\theta/x$ | $\theta$ | DARA, CRRA |
| **Cuadrática** | $x-\frac b2x^2$, $x<\frac1b$ | $\frac{b}{1-bx}$ | $\frac{bx}{1-bx}$ | IARA, IRRA |

- *CRRA*: la de macro y finanzas; con utilidad separable, $\mathrm{ESI}=1/\theta$ [ver tema 3.A.29] (un parámetro para 2 cosas). *Cuadrática*: solo media y varianza, pero IARA.

- *Prudencia* (no se canta): $u'''>0$ $\Rightarrow$ **ahorro precautorio** (Leland, 1968; Sandmo, 1970): $u'(\overline{W}-s^*)=\mathbb{E}[u'(s^*+\tilde{y})]$. Prudencia absoluta $-u'''/u''$ (Kimball, 1990): CRRA, $(\theta+1)/x$; cuadrática, 0 $\Rightarrow$ paseo aleatorio de Hall [ver tema 3.A.33]. DARA $\Rightarrow$ prudencia.

- *Distribución*: **dominancia estocástica**, loterías que *todos* prefieren. *1.^(er) orden* (toda $u$ no decreciente): $F(x)\leq G(x)\ \forall x$
  *2.º orden* (misma media, toda $u$ cóncava): $\int_{-\infty}^{x}F\leq\int_{-\infty}^{x}G\ \forall x$ 2.º orden $\iff$ $G$, **dispersión que conserva la media** de $F$ (Rothschild-Stiglitz, 1970). Orden *parcial* $\to$ **media y varianza**: coherente solo con $u$ cuadrática o rendimientos normales [ver tema 3.B.23].

> La utilidad esperada separa lo subjetivo ($u$: cuanto más cóncava, más prima por librarse del riesgo) de lo objetivo ($F$: la dominancia ordena algunas loterías para todos).

### I.2. Aplicaciones: demanda de seguros (Mossin, 1968)

- *Idea*: ¿cuánto seguro compra un averso? Trasladar riqueza del estado bueno al malo.

- *Supuestos*: (1) riqueza $\overline{W}$; pierde $L$ con prob. $\pi$: $A=(\overline{W},\overline{W}-L)$ en $(x_1,x_2)$ (sin y con accidente); bisectriz, **línea de certeza**; (2) averso: curvas decrecientes y convexas; (3) cobertura $S\in[0,L]$ a $\gamma$ por euro; (4) información simétrica.

- *Desarrollo*: $x_1=\overline{W}-\gamma S$, $x_2=\overline{W}-L+(1-\gamma)S$ $\Rightarrow$ **recta de aseguramiento** por $A$, pendiente $-(1-\gamma)/\gamma$. El problema: $$\begin{array}{rl}\max_{S} & (1-\pi)\,u\big(\overline{W}-\gamma S\big)+\pi\,u\big(\overline{W}-L+(1-\gamma)S\big) \\ \text{s.a.} & 0\leq S\leq L\end{array}$$ $\mathrm{RMSE}\equiv\dfrac{(1-\pi)\,u'(x_1)}{\pi\,u'(x_2)}=\dfrac{1-\gamma}{\gamma}$ **Relación marginal de sustitución estocástica** (RMSE): en la línea de certeza, $(1-\pi)/\pi$ sea cual sea $u$.

- *Implicaciones*: aseguradoras neutrales en competencia: $(\gamma-\pi)S=0$ $\Rightarrow$ $\gamma=\pi$, **prima justa**. **Teorema de Mossin**: (1) prima justa $\Rightarrow$ $u'(x_1)=u'(x_2)$, $S^*=L$: **seguro completo** ($E$); (2) recargada ($\gamma>\pi$): recta más plana, $S^*<L$: **parcial** ($E'$), franquicias.

*[Gráfico: Completo en $E$ (prima justa) y parcial en $E'$ (recargada)]*

- *Estática comparativa*: cobertura $\uparrow$ con aversión, $\pi$ y $L$; $\downarrow$ con la prima; recargada y DARA: *bien inferior*.

- *Extensiones*: otras primas y actitudes (neutral, lineal en $S$; amante, elige un extremo):

|  | **Favorable** ($\gamma<\pi$) | **Justa** ($\gamma=\pi$) | **Recargada** ($\gamma>\pi$) |
|:---|:---|:---|:---|
| **Averso** | completo (se sobreaseguraría) | completo (Mossin) | parcial (nulo si el recargo es grande) |
| **Neutral** | completo | indiferente | ninguno |
| **Amante** | ninguno; completo si $\gamma\ll\pi$ | ninguno | ninguno |

- *Evidencia*: franquicias, como predice; pero se paga demasiado por evitar riesgos *pequeños* (Sydnor, 2010) $\to$ II.1.

- *Valoración*: explica por qué hay seguros; pero información simétrica: *selección adversa* y *riesgo moral* (Rothschild-Stiglitz, 1976, sobre este gráfico) [ver tema 3.A.13].

- *Otras aplicaciones* (en una frase): *cartera* (Arrow, 1965), problema inverso: todo averso compra *algo* de un activo con $\mathbb{E}[\tilde{r}]>r_f$, y más si es rico con DARA; *empresa aversa* (Sandmo, 1971): $\mathrm{CMg}<\mathbb{E}[\tilde{p}]$, produce menos [ver tema 3.A.11]; *Diamond-Dybvig* (1983): depósitos, seguro de liquidez con 2 equilibrios, el malo un **pánico bancario** [ver tema 3.B.26].

### I.3. Extensiones

- **Utilidad dependiente del estado** $\sum_s\pi_su_s(x_s)$ (Karni, 1985): con prima justa, $u_1'(x_1)=u_2'(x_2)$; si el accidente baja la UMg (salud), seguro *menos* que completo.

- **Preferencia por el estado** (Arrow, 1953; Debreu, 1959): **bienes contingentes** (paraguas si llueve $\neq$ si no), **precios de Arrow-Debreu** $p_s$; $\sum_sp_sx_s\leq\overline{W}$ y tangencia: $\dfrac{\pi_s\,u'(x_s)}{\pi_{s'}\,u'(x_{s'})}=\dfrac{p_s}{p_{s'}}$ El gráfico del seguro con otros nombres. Mercados completos $\Rightarrow$ riesgo repartido eficientemente [ver tema 3.A.21].

> Con 5 axiomas se maximiza una utilidad esperada; la concavidad de $u$ mide la aversión y de ella salen el seguro (completo con prima justa, parcial con recargada) y la demanda de activos con riesgo.

## II. Riesgo: críticas y enfoques alternativos (8′)

- *Conclusión anticipada*: la TUE es buena guía *normativa*, pero falla como *descripción*; las perspectivas lo explican con una referencia y pesos de decisión.

### II.1. Limitaciones y críticas

- **Friedman-Savage** (1948): ¿por qué se compran seguro y lotería? $u$ *cóncava-convexa-cóncava*: la clase media, en el tramo convexo. Incompleta: predice grandes apuestas justas.

- **Markowitz** (1952): los ricos no jugarían. (1) Utilidad de los *cambios* respecto a la riqueza habitual; (2) las pérdidas pesan más. Vuelven en 1979.

- **Paradoja de Allais** (1953): viola la *independencia*; **efecto certeza**. Premios en euros (sombreado, la elección de la mayoría):

|  | **Juego 1** | **Juego 2** |
|:---|:---|:---|
| **Lotería $A$** | 110 con 0,75 ($\mathbb{E}=82{,}5$) | 110 con 0,95 ($\mathbb{E}=104{,}5$) |
| **Lotería $B$** | 100 con 0,80 ($\mathbb{E}=80$) | 100 seguro |

- *Ninguna $u$ lo racionaliza*; con $u(0)=0$: $A_1\succ B_1\iff\dfrac{u(110)}{u(100)}>\dfrac{0{,}80}{0{,}75}\approx1{,}067$;$B_2\succ A_2\iff\dfrac{u(110)}{u(100)}<\dfrac{1}{0{,}95}\approx1{,}053$ *Por qué*: $B_1=0{,}8\,B_2+0{,}2\,\delta_0$, y $0{,}8\,A_2+0{,}2\,\delta_0$ (110 con 0,76) domina a $A_1$: quien prefiere $B_2$ debe preferir $B_1$. Del 80 % al 100 % pesa más que del 75 % al 95 %.

- *Razón común* (Kahneman-Tversky, 1979): 80 %, 3.000 seguros frente a 4.000 al 80 %; 65 %, 4.000 al 20 % frente a 3.000 al 25 %. Triángulo de Marschak-Machina: rectas paralelas; Allais pide *abanico* (Machina, 1982).

- *Invariancia*: **efecto marco** (ganancias o pérdidas $\Rightarrow$ elecciones opuestas); **inversión de preferencias** (se *elige* la segura y se *pide más* por la arriesgada; Lichtenstein-Slovic, 1971).

- *Valoración*: valor *normativo*. Pero **calibración de Rabin** (2000): quien rechaza siempre $-100/+110$ al 50 % rechazaría $-1.000$ frente a *cualquier* ganancia: la aversión a riesgos pequeños viene del punto de referencia, no de la curvatura.

### II.2. Teoría de las perspectivas (Kahneman-Tversky, 1979)

- *Idea*: **utilidad no esperada**, debilita la independencia; *descriptiva*. Cambia cómo se *definen* (ganancias y pérdidas), *valoran* ($v$ en S) y *ponderan* (pesos de decisión) las alternativas.

- *Supuestos*: cálculo limitado $\Rightarrow$ 2 fases: (1) **edición**: *codificación* respecto al **punto de referencia** $r$ (*statu quo*, aspiración); combinación, segregación, cancelación; (2) **evaluación**.

- *Desarrollo*: valor de una alternativa: $$V=\sum_{s=1}^{S}w(\pi_s)\,v(x_s-r)$$ Con $r=0$, $w(\pi)=\pi$ y $v=u$, la TUE.

- *Valor*: **función de valor**: (1) *dependencia de la referencia*; (2) *sensibilidad decreciente*: cóncava en ganancias («pájaro en mano»), convexa en pérdidas («de perdidos, al río»); (3) **aversión a las pérdidas**, quiebro en $r$: $v(z)=z^{\beta}$ si $z\geq0$;  $-\lambda(-z)^{\beta}$ si $z<0$;$\beta\approx0{,}88$, $\lambda\approx2{,}25$

- *Ponderación*: **función de ponderación** $w(\pi)$: $w(0)=0$, $w(1)=1$; *sobrepondera* las probabilidades bajas e *infrapondera* medias y altas; efecto certeza. Con $\delta=0{,}61$: $w(0{,}01)\approx0{,}055$, $w(0{,}9)\approx0{,}71$.

*[Gráfico: Función de valor en S, con quiebro en $r$]* · *[Gráfico: Ponderación: sobre las bajas, bajo las altas]*

- *Implicaciones*: **patrón cuádruple**: con probabilidades medias y altas, aversión en ganancias y búsqueda en pérdidas ($v$); con bajas, al revés: **lotería** y **seguro** ($w$), sin $u$ con tramos. *Efecto marco*: con 1.000, 84 % elige $+500$ seguros; con 2.000, 69 % arriesga $-1.000$ al 50 %. **Efecto dotación** [ver tema 3.A.8].

- *Extensiones*: **teoría acumulativa** (1992): $w$ sobre probabilidades acumuladas, respeta la dominancia. **Dependiente del rango** (Quiggin, 1982), **pesar** (Loomes-Sugden, Bell, 1982), **generalizada** (Machina, 1982).

- *Evidencia*: **94 % replicado, 4.098 personas, 19 países** (Ruggeri et al., 2020); salarios rígidos a la baja; vivienda; 11-S, **$\approx$350 muertes más en carretera** (Gigerenzer, 2004); prima de las acciones, *aversión miope a las pérdidas* (Benartzi-Thaler, 1995) [ver tema 3.B.23]; efecto disposición.

- *Valoración*: la que mejor encaja con los experimentos; **racionalidad limitada** (Simon); *nudges*. Límites: $r$ indeterminado, sin fuerza normativa. *Complemento*, no sustituto.

> La TUE falla al describir por la independencia (Allais) y la invariancia (marco). Las perspectivas lo explican con referencia, aversión a las pérdidas y pesos de decisión: por eso la misma persona compra el seguro y el décimo.

## III. Incertidumbre (5′30″)

- *Conclusión anticipada*: con Savage se actúa *como si* hubiera probabilidades subjetivas; Ellsberg muestra que la gente distingue riesgo de ambigüedad.

### III.1. Teoría de la probabilidad subjetiva

- *Idea*: **incertidumbre** (Knight, 1921), la situación más habitual. **Probabilidad subjetiva**: se *deduce* de las elecciones.

- *Supuestos*: **actos** $\mathbf{x}=(x_1,\dots,x_S)$. Savage (1954), P1-P7: P1 *orden*; P2 **principio de la cosa segura** (independencia subjetiva); P3-P4, resultados y apuestas independientes del estado y del premio; P5-P7, continuidad y técnicas.

- *Desarrollo*: **teorema de la utilidad esperada subjetiva**: existen $\mathbf{\pi}$ única y $u$ (afín) con $\mathbf{x}\succcurlyeq\mathbf{x}'\iff\sum_{s}\pi_s\,u(x_s)\geq\sum_{s}\pi_s\,u(x_s')$ Misma función clave; las $\pi_s$, *creencias*.

- *Implicaciones*: von Neumann-Morgenstern, caso particular; todo I vale; hereda las críticas. *Extensión*: Anscombe-Aumann (1963), caballos y ruleta.

- *Valoración*: **paradoja de Ellsberg** (1961): urna *conocida* (50 rojas, 50 negras) y *ambigua*. Se prefiere la conocida para «roja» *y* para «negra» $\Rightarrow$ $\pi(R)+\pi(N)<1$: **ninguna probabilidad**. **Aversión a la ambigüedad**; menos bolsa (Dimmock et al., 2016).

*[Gráfico: Urna conocida y urna ambigua]*

### III.2. Enfoques alternativos

- **Múltiples probabilidades** (*maxmin*; Gilboa-Schmeidler, 1989): conjunto $\mathcal{P}$; se valora con el peor: $U(\mathbf{x})=\min_{\mathbf{\pi}\in\mathcal{P}}\ \sum_{s}\pi_s\,u(x_s)$ Ellsberg: rojas entre 30 % y 70 % $\Rightarrow$ cada apuesta ambigua vale 0,3 $<$ 0,5.

- **Choquet** (Schmeidler, 1989): *capacidad* no aditiva; convexa $\Rightarrow$ maxmin. **Ambigüedad suave** (Klibanoff-Marinacci-Mukerji, 2005): separa ambigüedad ($\mu$) y actitud ($\phi$).

- **Criterios clásicos en ignorancia** (Luce-Raiffa, 1957):

|  | **Pagos** |  |  | **Pesares** |  |  | **Peor** | **Mejor** | **Media** | **Pesar máx.** |
|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|
| $A$ | 8 | 2 | 8 | 5 | 2 | 0 | 2 | 8 | 6 | 5 |
| $B$ | 4 | 4 | 4 | 9 | 0 | 4 | 4 | 4 | 4 | 9 |
| $C$ | 13 | 0 | 1 | 0 | 4 | 7 | 0 | 13 | 4,67 | 7 |
| $D$ | 10 | 3 | 4 | 3 | 1 | 4 | 3 | 10 | 5,67 | 4 |

- *Elección*: **Wald** (*maximin*) $\to B$; **maximax** $\to C$; **Laplace** (razón insuficiente) $\to A$; **Hurwicz** ($\alpha$ al mejor): $B$ si $\alpha<\frac17$, $D$ si $\frac17<\alpha<\frac12$, $C$ si $\alpha>\frac12$; **Savage** (*minimax regret*) $\to D$.

- *Valoración*: cada criterio falla en algo (Milnor, 1954). Ambigüedad: robustez (Hansen-Sargent).

> Con Savage, la incertidumbre se reduce a riesgo con probabilidades subjetivas; Ellsberg rompe esa equivalencia, y los modelos de ambigüedad la recogen.

## Conclusión (1′)

- **Recapitulación**: axiomas (sobre todo independencia) $\Rightarrow$ utilidad esperada; actitud ante el riesgo en la curvatura de $u$ (I); desviaciones sistemáticas $\to$ perspectivas (II); Savage, Ellsberg, ambigüedad (III).

- **Relevancia**: carteras [ver tema 3.B.23], dinero [ver tema 3.A.35], información asimétrica [ver tema 3.A.13], juegos [ver tema 3.A.14]; seguros obligatorios y garantía de depósitos; economía conductual [ver tema 3.A.1].

- **Extensiones**: contingentes [ver tema 3.A.21]; CRRA y ESI [ver tema 3.A.29]; prudencia frente a Hall [ver tema 3.A.33]; irreversibilidad [ver tema 3.A.34].

- **Opinión**: no compiten: TUE *normativa*; perspectivas *positivas* (ahorro insuficiente, sobreaseguro). Hacen falta las 2.

- **Idea final**: los 2 refranes tienen razón, cada uno en su terreno; ante lo improbable, al revés: por eso se compran el seguro y el décimo.

## Autores y fechas

**1738** D. Bernoulli: esperanza de la utilidad ($\ln x$); Cramer, 1728

**1921** Knight: riesgo frente a incertidumbre; Keynes

**1944** von Neumann-Morgenstern: utilidad esperada (axiomas, 1947)

**1948** Friedman-Savage; 1952, Markowitz

**1953** Allais: paradoja; Arrow: bienes contingentes

**1954** Savage: utilidad esperada subjetiva

**1961** Ellsberg: ambigüedad

**1964** Pratt; 1965, Arrow: medidas de aversión, cartera

**1968** Mossin: demanda de seguros; Leland: prudencia

**1970** Rothschild-Stiglitz: dispersión que conserva la media

**1979** Kahneman-Tversky: teoría de las perspectivas

**1982** Quiggin; Machina; Loomes-Sugden, Bell

**1989** Schmeidler; Gilboa-Schmeidler: maxmin

**1992** Tversky-Kahneman: teoría acumulativa

**2005** Klibanoff-Marinacci-Mukerji: ambigüedad suave

## Datos clave

- Primas de seguro en España: **$\approx$86.000 M€, $\approx$5 % del PIB** (Mapfre; Eurostat, 2025).

- Prima de las acciones (EE. UU.): **6,2 p.** (Mehra-Prescott, 1889-1978); **6,7 p. sobre letras, 5,5 sobre bonos a 10 años** (Damodaran; UBS, 1928-2025).

- Aversión relativa estimada: $\approx1$ (Chetty, 2006).

- Garantía de depósitos (UE): **100.000 €** (por depositante y entidad). Pánicos: Grecia, **$\approx$40.000 M€** (1.^(er) sem. 2015); SVB, **$\approx$42.000 M\$ en un día** (9/3/2023).

- Nobel: Allais 1988; Markowitz 1990; Kahneman 2002; Thaler 2017; Diamond, Dybvig y Bernanke 2022.

## Preguntas del tribunal

1.  **¿Qué axioma da la forma de utilidad esperada?** La independencia; la continuidad (con el preorden) solo da la existencia de $U$.

2.  **¿En qué sentido es cardinal?** $u$, única salvo afines positivas: mide la actitud ante el riesgo, no la intensidad; sin comparaciones interpersonales.

3.  **¿Relación entre $r_R$ y la elasticidad de la UMg?** $r_R=-\varepsilon_{u'(x),x}$; en la CRRA, $\theta$, y con utilidad separable $\mathrm{ESI}=1/\theta$.

4.  **¿Por qué parcial con prima recargada?** En $S=L$, $U'(L)=u'(\cdot)(\pi-\gamma)<0$: reducir la cobertura sube la utilidad esperada.

5.  **¿Cómo explican las perspectivas seguro y lotería a la vez?** $w$ sobrepondera lo improbable: patrón cuádruple.

6.  **¿Por qué Ellsberg no cabe en Savage?** Las probabilidades reveladas suman menos de 1; el maxmin la explica.

7.  **¿Qué aplicación dio el Nobel a Markowitz?** La media-varianza (cuadrática o normales) $\to$ frontera eficiente [ver tema 3.B.23].

> **Ojo en el test.**
>
> - Averso $\iff$ $u$ cóncava $\iff$ $\xi<\mathbb{E}[\tilde{x}]$ $\iff$ $\rho>0$, para toda lotería no degenerada.
>
> - El axioma propio es la *independencia*, no la independencia de las alternativas irrelevantes de Arrow [ver tema 3.A.24].
>
> - $u$, única salvo transformaciones *afines* positivas, no crecientes.
>
> - CRRA $\Rightarrow$ DARA; la cuadrática es IARA y sin prudencia ($u'''=0$). El ahorro precautorio exige $u'''>0$, no basta la aversión.
>
> - Prima justa: completo; recargada: parcial (Mossin, 1968, información simétrica; no Rothschild-Stiglitz, 1976).
>
> - 1.^(er) orden $\iff$ $F(x)\leq G(x)\ \forall x$; el 2.º compara loterías con la misma media.
>
> - Allais viola la independencia; Ellsberg, la cosa segura. Quiggin explica Allais; Schmeidler (Choquet), Ellsberg.
>
> - Criterio de Savage: mínimo del pesar *máximo*, no de la suma.
