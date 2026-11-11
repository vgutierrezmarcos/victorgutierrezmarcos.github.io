# Modelo IS-LM-BP (Mundell-Fleming)

- **Área:** macro-abierta · **Tema de referencia:** **3.A.32** (OA-DA en economía abierta: renta, inflación, políticas monetaria y fiscal; sin fuente; **revisado el 11/11/2026**: I.1 `sec:mundell-fleming` con a)-e), II.1 `sec:corto-plazo` con las políticas y `tab:mundell-fleming`, anexo A `anexo:mundell-fleming` con el álgebra). Es su sitio natural en el temario de 2023 (hereda el antiguo 3.A.28, como recuerda la nota de 3.B.12) y es donde se analizan las políticas en economía abierta con carácter general. Se escribió desde cero, con el Word del 3.B.15 de Víctor (corregido: la BP vertical es movilidad **nula**) y el antiguo 3A_28 como referencias; el 3.B.15 pasa a resumen al revisarlo.
- **Temas que lo usan:** 3.A.32 (desarrollo; hecho, 11/11/2026), 3.B.15 (desarrollo → resumen), 3.B.19 (desarrollo → variante de dos países), 3.A.37 (resumen en anexo; hecho, 5/11/2026: anexo D, 2 países grandes con tipo flexible y movilidad perfecta, $\beta_K\to\infty$, gráfico `mundell-fleming-dos-paises` y `tab:mundell-fleming-2`, `\vertema{3.A.32}`), 3.A.38 (mención; hecho, 5/11/2026: una viñeta en I.1 y el anexo A con `tab:mundell-fleming`, `\vertema{3.A.32}`; el efecto locomotora, `\vertema{3.B.19}`), 3.B.14 (borrador → mención), 4.B.4 (resumen). También 3.A.5 (mención; hecho, 3/11/2026: I.2 c) y II, una línea cada vez: IS-LM-BP de Mundell y Fleming como extensión a la economía abierta, `\vertema{3.A.32}`). También 3.A.40 (mención; hecho, 5/11/2026: anexo D y `tab:determinantes`, con tipo de cambio flexible el multiplicador es casi nulo y con tipo fijo positivo, Ilzetzki, Mendoza y Végh, 2013, `\vertema{3.A.32}`), 3.B.11 (mención; hecho, 5/11/2026: III.1, el canal de los tipos, la entrada de capitales y la apreciación en los déficits gemelos), 3.B.13 (mención; hecho, 8/11/2026: l. 864, la PNCI con expectativas estáticas como BP horizontal, `\vertema{3.A.32}`), 1D01 (mención; hecha: l. 1205, los déficits gemelos por 2 vías, `\vertema{3.A.32}`).
- **Manuales de referencia:** Fleming (1962), *IMF Staff Papers* (`Fleming1962Domestic`); Mundell (1963), *Canadian Journal of Economics and Political Science* (`Mundell1963Capital`); Mundell (1962) para la asignación (`Mundell1962Appropriate`) y (1964) para 2 países (`Mundell1964Reply`); Gandolfo, *International Finance and Open-Economy Macroeconomics* (2002, `Gandolfo2002International`); Heijdra, *Foundations of Modern Macroeconomics* (2017, `Heijdra2017Foundations`) para la tabla; Blanchard, *Macroeconomics* (8.ª ed., 2021, `Blanchard2021Macroeconomics`; sin número de capítulo: no comprobado en esa edición); Krugman, Obstfeld y Melitz, cap. 17 (modelo $DD$-$AA$, equivalente); Dornbusch, Fischer y Startz, *Macroeconomía*, cap. 12.
- **Decisión D014 (13/10/2026):** ¿Cuál es el tema de referencia de Mundell-Fleming (IS-LM-BP)? 3.A.32 (OA-DA en economía abierta), escribiéndolo a partir de 3.B.15, que pasa a resumen. **Cumplida el 11/11/2026.**
- **Decisión D016 (13/10/2026):** ¿Se reserva φ para la productividad de Melitz (y la inversa de Frisch en macro) y se cambian sus otros usos en comercio y macro abierta? Sí: función de reacción R_A(q_B), coeficiente técnico de la protección efectiva a_ij, sensibilidad del saldo comercial al tipo real ν.
- **Movilidad del capital $\beta_K$ (CC1 del 3.A.32, A32-02, decidido (Víctor, 11/11/2026): se mantiene $\beta_K$, porque β es el factor de descuento):** la presentación de referencia pasa de β a **$\beta_K$**: el tema de referencia la escribe así (tiene β de descuento en I.3), igual que los 2 temas revisados que la usan con ecuación (3.A.37, 3.A.38); «mismo modelo, misma forma».

## Presentación de referencia (3.A.32, I.1, II.1 y anexo A)

Estructura a)-e) (CRITERIOS). **Pregunta:** ¿qué eficacia tienen las políticas fiscal y monetaria según el régimen cambiario y la movilidad del capital?

**a) Idea.** Fleming (1962), desde el FMI, y Mundell (1963), con Bretton Woods en marcha y los capitales empezando a moverse: el IS-LM (`\vertema{3.A.5}`) con el comercio en la IS y un tercer mercado, el de divisas, resumido en la BP. Referencia de la macro abierta durante 30 años e intuición de partida de bancos centrales y FMI. Nobel de Mundell en 1999.

**b) i) Supuestos** (separados de los 3 casos de movilidad, que no son un supuesto: el modelo se resuelve para los 3):
- precios fijos, $P=P^*=1$, luego $i=r$ y $q=E$;
- país pequeño: $Y^*$ (renta exterior) e $i^*$ (tipo mundial) dados;
- expectativas estáticas, $\gamma E^e=0$: la PNCI $i=i^*+\gamma E^e$ se reduce a $i=i^*$ con movilidad perfecta (`\vertema{3.B.13}`);
- **activos nacionales y extranjeros sustitutos perfectos y agentes neutrales al riesgo** (sin prima);
- Marshall-Lerner (`\vertema{3.B.12}`);
- los flujos de capital responden al diferencial: cuenta financiera neta $\beta_K(i-i^*)$, $\beta_K\ge0$, con la nota de que es un enfoque de **flujos**;
- sin esterilización: con tipo fijo, la intervención cambia la base monetaria.

**b) ii) Desarrollo** (IS y BP, `\funcionclave`; la LM en `equation`, para no pasar de 4 funciones clave; con $\overline A\equiv\overline C+\overline I+\overline G$, como el 3.A.38):

$$\text{IS (\texttt{eq:is-abierta}):}\quad Y=\frac{\overline A-b\,i+x\,Y^*+\nu\,q}{1-c\,(1-t)+m}$$
$$\text{LM (\texttt{eq:lm}):}\quad \frac{M}{P}=k\,Y-h\,i\qquad(\text{como el 3.A.5; con tipo fijo, } M=\mathrm{CI}+R)$$
$$\text{BP (\texttt{eq:bp}):}\quad \underbrace{x\,Y^*-m\,Y+\nu\,q}_{\text{saldo comercial}}+\underbrace{\beta_K\,(i-i^*)}_{\text{cuenta financiera neta}}=0\;\Longrightarrow\;\frac{\mathrm di}{\mathrm dY}\bigg|_{\mathrm{BP}}=\frac{m}{\beta_K}$$

$XN=x\,Y^*-m\,Y+\nu\,q$ ($x$ propensión a exportar, $m$ a importar, $\nu$ sensibilidad del saldo comercial al tipo real, D016). La BP se escribe como **suma igual a 0** (no $XN=-\beta(i-i^*)$). Por encima de la BP, superávit; por debajo, déficit; una depreciación la desplaza a la derecha. **Casos** (rótulos del gráfico): $\beta_K=0$ movilidad **nula** (BP vertical); $0<\beta_K<\infty$ imperfecta (BP creciente; **alta** si la BP es más plana que la LM, $m/\beta_K<k/h$; **baja** si es más inclinada); $\beta_K\to\infty$ **perfecta** (BP horizontal en $i=i^*$).

**Equilibrio:** con tipo fijo, las incógnitas son $Y$, $i$ y $M$ (la LM se desplaza con las reservas); con tipo flexible, $Y$, $i$ y $E$ (la IS y la BP se desplazan). **Los equilibrios se escriben $Y_0$, $Y_1$ y los puntos $A$, $B$, $C$; nunca con asterisco** ($Y^*$ es la renta exterior; D038) **ni con $E$** ($E$ es el tipo de cambio).

**b) iii) Implicaciones:** el régimen decide qué se ajusta (dinero endógeno con tipo fijo); la eficacia depende del régimen y de la movilidad; **aislamiento** con tipo flexible frente a la demanda exterior (Friedman, 1953, `Friedman1953Case`), no frente a las perturbaciones financieras; un instrumento para cada objetivo (Tinbergen, 1952).

**Resultado (II.1, `fig:mundell-fleming-politicas`):** con movilidad perfecta, la fiscal es **muy eficaz** con tipo fijo (multiplicador abierto $1/[1-c(1-t)+m]$, sin expulsión por el tipo) e **ineficaz** con flexible (expulsión de las exportaciones netas, que caen lo que sube el gasto); la monetaria, **ineficaz** con fijo (solo cambia la composición del balance: más crédito interno, menos reservas) y **muy eficaz** con flexible ($\Delta Y=\Delta(M/P)/k$, canal del tipo de cambio, `\vertema{3.A.37}`). La devaluación con tipo fijo, política de **cambio del gasto** (Meade, 1951).

**Dilema del régimen (K13):** con tipo fijo, la política monetaria no sirve con **ninguna** movilidad (con movilidad nula se va en reservas a medio plazo; con perfecta, en el acto); si se insiste, crisis de primera generación (Krugman, 1979, `\vertema{3.B.17}`). Trilema (Obstfeld, Shambaugh y Taylor, 2005, `\vertema{3.B.15}`) y «más que un trilema, un dilema» (Rey, 2013, `Rey2013Dilema`, `\vertema{3.A.37}`).

**Multiplicadores con movilidad imperfecta** (`eq:multiplicadores-fijo` y `eq:multiplicadores-flexible`, derivados en el anexo A):
$$\text{fijo:}\ \frac{\partial Y}{\partial\overline G}=\frac{\beta_K}{[1-c(1-t)]\beta_K+m(b+\beta_K)},\ \frac{\partial Y}{\partial M}=0;\qquad \text{flexible:}\ \frac{\partial Y}{\partial\overline G}=\frac{h}{h[1-c(1-t)]+(b+\beta_K)k},\ \frac{\partial Y}{\partial(M/P)}=\frac{b+\beta_K}{h[1-c(1-t)]+(b+\beta_K)k}.$$
Con tipo flexible, la IS y la BP juntas son la IS cerrada con sensibilidad $b+\beta_K$; con $\beta_K=0$, los multiplicadores son los del IS-LM cerrado sin importaciones.

**Tabla de referencia `tab:mundell-fleming` (8 casillas, las 2 políticas; K26):** filas fiscal y monetaria × tipo fijo y flexible; columnas movilidad perfecta, alta, baja, nula. Fiscal con fijo: muy eficaz, eficaz, poco eficaz, ineficaz; fiscal con flexible: ineficaz, poco eficaz, eficaz, muy eficaz; monetaria con fijo: ineficaz en las 4; monetaria con flexible: muy eficaz, eficaz, eficaz, eficaz. Colores `tceeverde` (eficaz), `tceedorado` (poco eficaz), `tceerojo` (ineficaz); cabecera `tceeazulpalido`. Las 2 filas fiscales son las del 3.A.38 (anexo A), a propósito.

**Asignación de Mundell (1962)** y **déficits gemelos** por 2 vías (las mismas de la 1D01, l. 1205, y del 3.B.11), en II.1 y en el anexo A.

**c) Extensiones:** 2 países grandes («empobrecer al vecino», Mundell, 1964; `\vertema{3.A.37}`, `\vertema{3.B.19}`); expectativas y sobrerreacción (Dornbusch, 1976, `\vertema{3.B.14}`); fondos frente a flujos (enfoque monetario, Frenkel y Johnson, 1976; cartera; `\vertema{3.B.14}`).

**d) Evidencia:** el trilema en los datos (Obstfeld, Shambaugh y Taylor, 2005); multiplicador fiscal casi nulo con tipo flexible y positivo con fijo (Ilzetzki, Mendoza y Végh, 2013, con las palabras del 3.A.40, `\vertema{3.A.40}`); Feldstein y Horioka (1980): la movilidad no es perfecta (`\vertema{3.B.11}`).

**e) Valoración:** base del trilema y de las uniones monetarias; límites: precios fijos (abre la OA-DA abierta, ficha `oa-da`), flujos y no fondos, expectativas estáticas y sin microfundamentos (Obstfeld y Rogoff, 1995; crítica de Lucas, `\vertema{3.A.6}`; abre Galí-Monacelli, ficha `gali-monacelli`).

**Gráficos de referencia** (`oposicion/temario/fuentes/3A32/graficos/`):
- **`is-lm-bp.tex`** (**imprescindible**): plano $(Y,i)$ por capas: ejes, IS (`tceeazul`), LM (`tceemorado`), el punto $A$, las 3 BP en verde (`tceeverde`), de la más plana a la vertical, rotuladas $\mathrm{BP}(\beta_K\to\infty)$, $\mathrm{BP}(0<\beta_K<\infty)$ y $\mathrm{BP}(\beta_K=0)$, y «superávit/déficit».
- **`mundell-fleming-politicas.tex`** (**imprescindible**): 4 paneles (arriba tipo fijo, abajo flexible; a la izquierda fiscal, a la derecha monetaria), con movilidad perfecta y puntos $A$ (inicial), $B$ (antes de que reaccionen las reservas o el tipo de cambio) y $C$ (final); en el cante solo se dibujan los 2 eficaces (a, fiscal con fijo; d, monetaria con flexible), con capas por panel.
- Colores de IS y LM: **IS azul, LM morada** en todos los gráficos, los de `mundell-fleming-dos-paises` del 3.A.37 y del 3.A.32 (A32-10, decidido (Víctor, 11/11/2026)); el `is-lm` del 3.A.5 se rehízo así el mismo día.
- Variante de 2 países: `fuentes/3A37/graficos/mundell-fleming-dos-paises.tex` (3.A.37, anexo D) hasta que se revise el 3.B.19.

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.32 | OA-DA en economía abierta | desarrollo (referencia, D014; hecho, 11/11/2026) | I.1 con a)-e), `eq:is-abierta`, `eq:lm`, `eq:bp`, `fig:is-lm-bp`; II.1 con `fig:mundell-fleming-politicas`, `tab:mundell-fleming` con las 2 políticas, dilema del régimen, trilema y Rey, asignación de Mundell y déficits gemelos; multiplicadores con $\beta_K$ en el anexo A; la DA abierta sale del modelo dejando libre $P$ (ficha `oa-da`) | — |
| 3.B.15 | Comparación de regímenes | resumen | Solo el cuadro régimen × movilidad (remitiendo a `tab:mundell-fleming`) y el trilema; Poole abierto; corregir «movilidad perfecta, β = 0» (es nula); `\vertema{3.A.32}` | La derivación de IS, LM y BP |
| 3.B.19 | Coordinación internacional | desarrollo de la variante | **Dos países** A y B con $Y^*$ endógeno: efectos desbordamiento (locomotora, *beggar-thy-neighbour*) y juego de políticas; Corsetti-Pesenti | La versión de país pequeño |
| 3.A.37 | Transmisión en economía abierta (anexo D) | resumen en anexo (hecho, 5/11/2026) | Mundell-Fleming con 2 países grandes, solo la política monetaria (la fiscal, una fila de `tab:mundell-fleming-2` con `\vertema{3.B.19}`): sube la renta de A y **baja** la de B en el caso canónico («empobrecer al vecino», Mundell, 1964); cuanto menor es A, más eficaz su política; $\beta_K$ movilidad del capital (avisada: β es el factor de descuento); gráfico `mundell-fleming-dos-paises`; antes de Corsetti-Pesenti; `\vertema{3.A.32}` | Las ecuaciones; la política fiscal con 2 países |
| 3.A.38 | Política fiscal en economía abierta | mención (hecho, 5/11/2026; equilibrio $Y_0$ en el anexo A el 11/11/2026) | I.1: con movilidad perfecta, la política fiscal funciona muy bien con tipo fijo y nada con flexible; anexo A: $XN=xY^*-mY+\nu q$ y la BP con **$\beta_K$**, `tab:mundell-fleming` (las 2 filas fiscales) con color; `\vertema{3.A.32}` (nunca 3.B.14, que es la determinación del tipo de cambio) | El modelo |
| 3.B.14 | Determinación del tipo de cambio | mención | Como teoría de flujos del tipo de cambio en dos líneas; **eliminar el borrador marcado** | El apartado IS-LM-BP sin terminar |
| 4.B.4 | Política fiscal | resumen | Solo la eficacia de la política fiscal según régimen y movilidad (las filas fiscales de `tab:mundell-fleming`) | Derivación |
| 3.A.5 | Síntesis y monetarismo | mención (hecho, 3/11/2026) | Una línea en las extensiones del IS-LM (l. 255) y otra en II (l. 681), con `\vertema{3.A.32}` | El modelo |
| 3.A.40 | Política fiscal (multiplicadores) | mención (hecho, 5/11/2026) | Ilzetzki, Mendoza y Végh (2013): casi nulo con flexible, positivo con fijo, «como predice Mundell-Fleming», `\vertema{3.A.32}` | El modelo |
| 3.B.13 | Mercados de divisas | mención (hecho, 8/11/2026) | La PNCI con expectativas estáticas es la BP horizontal, `\vertema{3.A.32}` | — |
| 3.B.11, 1D01 | Balanza de pagos; dictamen | mención (hechos) | Las 2 vías de los déficits gemelos | El modelo |
| 3.B.12 | Ajuste de la balanza de pagos | mención | IS-LM-BP como mecanismo de ajuste con movilidad del capital y la asignación de Mundell (nota 42 de su Word), `\vertema{3.A.32}` | El modelo |

## Divergencias encontradas en el temario actual
- **Copia literal** en 3.B.15 y 3.B.19 (mismas ecuaciones, gráficos y texto), y borrador sin terminar en 3.B.14 con notas del autor («Modelo comodín…»).
- **Error en 3.B.15 (y copiado en 3.B.19)**: «Si existe movilidad perfecta de capital, $\beta = 0$, la curva BP será totalmente vertical»: es movilidad **nula** (el 3.A.32 lo corrige y lo pone como trampa de test en el anexo E).
- 3.B.15: el supuesto 5 fija movilidad perfecta pero luego se analizan los tres casos de $\beta$; separar «supuesto» de «casos» (hecho en el 3.A.32).
- Notación: $\phi$ (o $\varphi$) para la sensibilidad de XN a $\varkappa$ choca con $\varphi$ productividad de Melitz (3.B.6) y con $\varphi$ de otros temas de comercio; 3.B.14 escribe $Y = A(r) + BC(Y,Y^*,E)$ con $r$, frente a $i$ en el resto; 3.B.12 escribe la IS con $r$, inversión inducida $zY$ y sin impuestos; la ficha decía $M^S/P$ (canon: $M/P$, como el 3.A.5). Canon: la forma de arriba.
- $Y^*$ es renta extranjera aquí y PIB objetivo del Gobierno en 3.B.17: ver `_notacion/macro-abierta.md`. En el 3.A.5 (l. 168, 184 y 850-874), $Y^*$ e $i^*$ son el equilibrio IS-LM: pendiente (`pendientes-coherencia.md`, «Pendiente del 3.A.32»).
- Fuentes de referencia (Tebar, Word del 3.B.15): Rey (2015) por Rey (2013); el 3.A.32 usa `Rey2013Dilema` (como el 3.A.37 y la 1D01).

Autor: Víctor Gutiérrez Marcos
