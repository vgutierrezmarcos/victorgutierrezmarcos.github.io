# Diagrama de Hamada: el juego de la política monetaria entre 2 países (Hamada, 1974, 1976; Corden, 1994)

- **Área:** macro-abierta (con mercados-información-juegos) · **Tema de referencia:** **3.B.19** (Coordinación internacional de políticas; revisado el 11/11/2026, fase canon del 12/11/2026: I.2.1 `sec:hamada` con a)-e), `eq:hamada` como función clave, el programa con `\optim` y el gráfico `fig:hamada`) — único tema que lo desarrolla, y es la «condición suficiente» de su título (las ganancias de coordinar). **Ficha nueva** de la fase canon del 3.B.19 (CC3, D-CC3, duda 3 de su `revision.md`, **[decidir]**: *recomendado*, la ficha, porque la usarán el 3.B.45, el 4.B.4 y, si se amplía, el 3.B.16; *alternativa*, sin ficha, con la notación local del 3.B.19 y la fila de `notacion.md` § 9). Recoge el id **`juego-coordinacion`** del inventario del 3.B.19 («ganancias de la coordinación: curvas de reacción y equilibrio de Nash frente a cooperativo»), que pasa a alias (`_inventario/alias.json`).
- **No confundir:** **Koichi Hamada** (1974, 1976), el de este diagrama, con **Robert Hamada** (1972), el de la beta apalancada de las finanzas (3.B.2, 3.B.3, 3.B.23; ficha `capm`). El 3.B.19 lo avisa en una nota al pie.
- **Temas que lo usan:** 3.B.19 (desarrollo; hecho, 12/11/2026). Previstos: 3.B.45 (mención: la coordinación fiscal en la UE como juego; sin revisar), 4.B.4 (mención: coordinación de la política fiscal; sin revisar). El 3.B.16 (revisado) cita las preferencias de política compatibles como criterio de las AMO (Corden, 1972; De Grauwe, 1975) sin el diagrama: no lo usa.
- **Manuales de referencia:** Hamada (1976), «A Strategic Analysis of Monetary Interdependence», *JPE*, 84(4) (`Hamada1976Strategic`); Hamada (1974), en Aliber (ed.), *National Monetary Policies and the International Financial System* (`Hamada1974Alternative`); Corden (1994), *Economic Policy, Exchange Rates, and the International System* (`Corden1994Economic`), la versión con objetivo de tipo de cambio que se cuenta; Oudiz y Sachs (1984), *BPEA* (`OudizSachs1984`), la cuantificación; Rogoff (1985), *JIE* (`Rogoff1985Counterproductive`); Blanchard, Ostry y Ghosh (2013) (`BlanchardOstryGhosh2013`, «el monstruo del lago Ness»); McKibbin (1997) (`McKibbin1997Empirical`, entrada sin comprobar: duda 10 del 3.B.19); Frankel (2016), NBER WP 21878 (`Frankel2016Coordination`).

## Presentación de referencia (3.B.19, I.2.1)

Estructura a)-e). **Pregunta:** si hay desbordamientos, ¿es ineficiente que cada país decida por su cuenta y se sostiene la solución cooperativa?

**a) Idea.** Hamada (1976) lleva la teoría de juegos a la política monetaria entre 2 países con un diagrama que todavía se usa; Corden (1994) lo expone con el tipo de cambio como objetivo. En un solo gráfico: por qué el equilibrio sin coordinar es ineficiente y por qué la solución cooperativa es frágil. Pegatina del 3.B.19: «¿Quién le pone el cascabel al gato?».

**b) i) Supuestos:** 2 países, A y B, con un instrumento cada uno, su oferta monetaria **$M_A$, $M_B$** (sin el superíndice $S$); disyuntiva inflación-paro (Phillips, `\vertema{3.A.28}`) y pérdida con la forma de la de Barro y Gordon (`\vertema{3.A.36}`); **B más contrario a la inflación que A ($\gamma_B>\gamma_A$)**; el tipo de cambio lo fija el dinero relativo, $E=f(M_A/M_B)$, $f'>0$ (modelo monetario, `\vertema{3.B.14}`): una expansión relativa de A deprecia su moneda, le sube la inflación y le baja el paro; PNCI (`\vertema{3.B.13}`); **objetivo de tipo de cambio común, $E_0$**; juego estático, una vez.

**b) ii) Desarrollo** (función clave `eq:hamada`):
$$L_i=(U_i-U^*_i)^2+\gamma_i\,(\pi_i-\pi^*_i)^2,\qquad i\in\{A,B\}$$
$$\optim{\min}{M_A}{L_A=(U_A-U^*_A)^2+\gamma_A(\pi_A-\pi^*_A)^2}{\pi_A=\pi_A(\underset{+}{E},\underset{+}{M_A})\\ U_A=U_A(\underset{-}{E},\underset{-}{M_A})\\ E=f(M_A/M_B)}$$
- **γ_i peso de la inflación** (canon, `notacion.md` § 1, como Barro-Gordon); $U^*_i$, $\pi^*_i$ objetivos (el asterisco es aquí el objetivo, avisado; no hay resto del mundo aparte de los 2 países).
- **Funciones de reacción** $M_A=R_A(M_B)$ y $M_B=R_B(M_A)$ (D016: $R$ con el argumento, como en el oligopolio).
- **Gráfico** en el plano $(M_A,M_B)$: cada rayo desde el origen es un tipo de cambio (más inclinado, A más apreciada); **puntos de felicidad** $F_A$ y $F_B$ (pérdida nula), los 2 en el rayo $E_0$, $F_A$ más lejos del origen (A prefiere una política más laxa en los 2 países); curvas de indiferencia circulares; con círculos, $R_A$ es la vertical por $F_A$ y $R_B$ la horizontal por $F_B$.
- **Nash, $N$**: el corte de las funciones de reacción (`\vertema{3.A.14}`); no es Pareto: por $N$ pasan 2 curvas que forman una **lente**; en $N$, el tipo $E_N$ deja la moneda de A demasiado depreciada para los 2.
- **Solución cooperativa:** minimizar $\omega\,L_A+(1-\omega)\,L_B$, con **ω ∈ (0,1) el poder negociador de A** (local; no γ, que es el peso de la inflación en el mismo modelo); **curva de contrato** (el segmento $F_AF_B$ con círculos); **núcleo**, la parte de la curva de contrato dentro de la lente; todo el núcleo está sobre $E_0$.

**b) iii) Implicaciones:** con desbordamientos, actuar por separado es ineficiente y coordinar mejora a los 2; pero la solución cooperativa **no es un equilibrio de Nash**: cada país tiene incentivos a ser **polizón** (*free rider*); es un dilema del prisionero en versión continua (con círculos, incluso con estrategia dominante); hace falta que la cooperación se sostenga (repetición, gatillo: fichas `dilema-prisionero` y `equilibrio-nash`).

**c) Extensiones:** liderazgo a la Stackelberg (`\vertema{3.A.19}`): con círculos no cambia nada (el líder acaba en $N$); con elipses, sí (Hamada, 1976); repetición (`eq:gatillo` del 3.B.19, con los pagos 5, 6, 0, 1 del 3.A.14 en el juego de la locomotora, β ≥ 1/5).

**d) Evidencia:** Oudiz y Sachs (1984), con modelos de Estados Unidos, Alemania y Japón: ganancia modesta, para Estados Unidos **medio punto del PNB al año**, algo parecido para Alemania y algo más para Japón; razón, el poco comercio (exportaciones de mercancías de EE. UU. a la CE, **1,6 % de su PNB en 1982**); los repasos posteriores, ganancias pequeñas (McKibbin, 1997; Ostry y Ghosh, 2013). **Nunca «0,5-1 % del PIB (McKibbin)»** ni «Oudiz y Sachs (1974)» o «(1994)», como decía el Word.

**e) Valoración:** muestra la diferencia entre Nash y Pareto y la fragilidad de la cooperación; límites: círculos y objetivo común muy simplificadores; coordinar solo a los bancos centrales puede ser **contraproducente** sin credibilidad frente al sector privado (Rogoff, 1985: sube la inflación de equilibrio; `\vertema{3.A.36}`); ganancias medidas pequeñas («el monstruo del lago Ness», Blanchard, Ostry y Ghosh, 2013).

**Gráfico de referencia:** `oposicion/temario/fuentes/3B19/graficos/hamada.tex` (`fig:hamada`, nuevo del 3.B.19). Plano $(M_A,M_B)$ por capas: ejes; rayo $E_0$ discontinuo (`tceeverde`, $M_B=0{,}8\,M_A$); $F_A=(5;4)$ en `tceeazul` y $F_B=(2{,}5;2)$ en `tceemorado`; círculos de A y de B; reacciones $R_A$ (vertical $M_A=5$) y $R_B$ (horizontal $M_B=2$); **$N=(5;2)$** en el rayo $E_N$ ($M_B=0{,}4\,M_A$); por $N$, el círculo de A de radio 2 y el de B de radio 2,5 (la lente); curva de contrato $F_AF_B$; núcleo de $(3{,}44;\,2{,}75)$ a $(4{,}45;\,3{,}56)$. En el cante, por capas, con la pegatina junto al diagrama.

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.B.19 | Coordinación internacional | desarrollo (referencia; hecho, 12/11/2026) | I.2.1 con a)-e), `eq:hamada` (función clave) y el programa con `\optim`; $M_A$, $M_B$, $R_A(M_B)$, $R_B(M_A)$, $F_A$, $F_B$, $N$, $E_0$, $E_N$, ω; lente, curva de contrato y núcleo; Stackelberg en c); Oudiz y Sachs (1984) en d); Rogoff (1985) y el lago Ness en e); nota de Koichi frente a Robert Hamada. Después, I.2.2: la locomotora (`tab:locomotora`) y `eq:gatillo` | — |
| 3.B.45 | Coordinación de las políticas en la UE | mención (prevista; sin revisar) | Por qué coordinar con reglas dentro de la unión: el Nash ineficiente y el polizón, en una línea, `\vertema{3.B.19}` | El diagrama |
| 4.B.4 | Política fiscal | mención (prevista; sin revisar) | Si trata la coordinación fiscal internacional, el efecto locomotora y el juego, `\vertema{3.B.19}` | El diagrama |

## Divergencias encontradas en el temario actual
- **Word del 3.B.19 (resuelto el 12/11/2026):** lo llamaba «modelo de Corden (1994)» que partía de «Oudiz y Sachs (1974)»; escribía $\min_{\{\pi\}}$ (el instrumento es $M_A$), $M^S_A$, $L(\pi,U)$, «puntos de saturación» $a$, $b$ (ahora «puntos de felicidad» $F_A$, $F_B$) y reacciones sin nombre; daba «0,5-1 % del PIB (McKibbin)» y Oudiz y Sachs (1994). Corregido.
- **Hamada en otros temas:** en el 3.B.2, el 3.B.3 y el 3.B.23 «Hamada» es Robert Hamada (1972) y la beta apalancada: otro autor, sin relación (ficha `capm`).

Autor: Víctor Gutiérrez Marcos
