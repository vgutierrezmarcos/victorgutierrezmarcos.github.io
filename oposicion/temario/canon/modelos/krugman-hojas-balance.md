# Crisis de tercera generación: riesgo moral y hojas de balance (Krugman, 1999)

- **Área:** macro-abierta · **Tema de referencia:** **3.B.17** (Teorías explicativas de las crisis de balanza de pagos), **revisado el 12/11/2026**: lo desarrolla en II.2 (`sec:tercera-modelos`): II.2.1 riesgo moral y fragilidad financiera (`sec:riesgo-moral`) y II.2.2 hojas de balance (`sec:hojas-balance`), con la función clave `eq:krugman-condicion`, la caja gris con la derivada y el gráfico propio; II.2.3 (paradas súbitas y pecado original) tiene ficha propia, `paradas-subitas`. Ficha nueva de la fase canon del 3.B.17 (12/11/2026; C3 de sus propuestas, **[decidir]**). El id estaba en el mapa sin fichero.
- **Temas que lo usan:** 3.B.17 (desarrollo; hecho, 12/11/2026), 3.B.11 (mención; hecho, 5/11/2026: descalces de monedas y crisis gemelas, `KaminskyReinhart1999`; ficha `enfoque-hoja-balance`), 3.B.12 (mención; hecho, 11/11/2026: Asia y el tipo fijo como seguro implícito; Tailandia ≈8 % del PIB, `FMI1997WEOdic`), 3.A.22 (mención; hecho, 21/10/2026: entradas masivas con sistemas financieros débiles, III.2), 3.B.15 (mención; hecho, 12/11/2026: I.2.3, la tercera generación —la devaluación hunde los balances y la crisis cambiaria se junta con la bancaria—; I.2.4, riesgo moral y dolarización con Eichengreen y Hausmann, 1999; miedo a flotar; sin la etiqueta «crisis gemelas»), 3.B.22 (mención prevista: el FMI en Asia, la crítica a la subida de tipos y las líneas de crédito), 3.B.26 (mención; hecho, 12/11/2026: crisis gemelas desde la banca), 3.B.21 (uso: Asia 1997-1998, Argentina 2001-2002), 1D01 (uso; aprobada: enfoque de balances).
- **Fuentes de referencia** (fijadas en el 3.B.17): **Krugman (1999, *International Tax and Public Finance* 6, `Krugman1999Balance`)**; Krugman (1998, «What happened to Asia?», **`Krugman1998Asia`**: nunca `Krugman1998What`, que es la nueva geografía económica del 3.B.6); McKinnon y Pill (1998, `McKinnonPill1998`); Corsetti, Pesenti y Roubini (1999, `CPR1999PaperTigers`); Burnside, Eichenbaum y Rebelo (2001, `BER2001Prospective`); Chang y Velasco (2001, `ChangVelasco2001Model`); Aghion, Bacchetta y Banerjee (2001, `ABB2001Currency`); Kaminsky y Reinhart (1999, *AER*, `KaminskyReinhart1999`); Radelet y Sachs (1998); Furman y Stiglitz (1998, *BPEA*); Krugman (2001, `Krugman2001Next`); Gandolfo, cap. 16 (gráfico).

## Presentación de referencia (3.B.17, II.2.1-II.2.2)

**Pregunta:** ¿por qué un país con buenos fundamentos sufre a la vez una crisis cambiaria y una bancaria, con grandes efectos reales?

**Riesgo moral (II.2.1, a)-b)):** garantías implícitas (rescates del Estado o del FMI) y un tipo fijo que se da por seguro son un seguro implícito: los bancos se endeudan en divisas y a corto y prestan a proyectos arriesgados (McKinnon y Pill, 1998; Krugman, 1998). Los rescates esperados son **deuda pública oculta**: cuando se revelan las pérdidas, el mercado anticipa monetización y ataca (la lógica de la primera generación con un déficit que no se ve: Corsetti, Pesenti y Roubini, 1999; Burnside, Eichenbaum y Rebelo, 2001). **Iliquidez internacional** (Chang y Velasco, 2001): el pánico bancario de Diamond y Dybvig en economía abierta (ficha `diamond-dybvig`, mención); con deuda en divisas, el banco central no puede ser prestamista de última instancia. Implicaciones: regular antes de abrir la cuenta financiera (`\vertema{3.B.27}`), reservas frente a la deuda a corto (`\vertema{3.B.22}`), más flexibilidad, y en el extremo la dolarización (`\vertema{3.B.15}`).

**Hojas de balance, supuestos (II.2.2):** $Y=K^{\alpha}L^{1-\alpha}$ (α participación del capital, canon § 1); trabajadores sin crédito que consumen $C=(1-\alpha)Y$; empresarios que ahorran e invierten; **riqueza neta de los empresarios** (`eq:krugman-riqueza`)
$$W=\alpha Y-B-q\,B^{*}$$
con **$B$ deuda en moneda nacional, $B^*$ deuda en divisas** (nunca $D$, $D^*$) y $q$ el tipo de cambio real (↑ depreciación real; ficha `tipo-cambio-real`); **$W$ local** (riqueza, avisada); restricción de crédito $I\le I_F\equiv(1+\theta)W$, **$I_F$ inversión financiable** y **θ apalancamiento, local y avisado** («no la aversión al riesgo»); equilibrio del bien nacional con **$m$ parte importada del gasto** y **$X$ exportaciones dadas, en bien extranjero** («no son las exportaciones netas») (`eq:krugman-bienes`):
$$Y=(1-m)\bigl[(1-\alpha)Y+I\bigr]+q\,X\;\Longrightarrow\;q=\frac{\bigl[1-(1-m)(1-\alpha)\bigr]Y-(1-m)I}{X}$$
Nota al pie con las letras de Krugman: λ apalancamiento, μ parte importada, $p$ tipo real, $F$ deuda en divisas.

**Desarrollo:** la espiral en 4 pasos, $\downarrow I\Rightarrow\uparrow q\Rightarrow\downarrow W\Rightarrow\downarrow I_F$; se dispara si (**función clave** `eq:krugman-condicion`)
$$\frac{\partial I_F}{\partial I}=\frac{(1+\theta)(1-m)\,B^{*}}{X}>1$$
más fácil cuanto mayor θ, mayor $B^*/X$ y menor $m$. La derivada, en caja gris (`anotaciones`). **3 equilibrios**: $L$ (sin inversión), $U$ (inestable) y $H$ (inversión normal), con la curva de inversión efectiva en 3 tramos (i) nula, ii) restringida por el crédito, iii) fijada por la rentabilidad).

**Implicaciones:** subir los tipos para defender la moneda cierra un canal y abre otro (Krugman, 1999; Furman y Stiglitz, 1998); líneas de crédito de emergencia y controles temporales a la salida (`\vertema{3.B.22}`); prevención: menos apalancamiento y deuda en divisas, supervisión, liberalización ordenada. Variante: Aghion, Bacchetta y Banerjee (2001), el acelerador financiero en economía abierta (`\vertema{3.A.42}`, ficha `bernanke-gertler`).

**Evidencia (II.3):** Tailandia (bat el 2/7/1997; déficit corriente ≈8 % del PIB en 1995-1996), Indonesia, Corea; PIB de 1998 −13,1 / −7,6 / −7,4 / −4,9 %; Kaminsky y Reinhart (1999): 76 cambiarias y 26 bancarias en 1970-1995, la bancaria precede a la cambiaria; Radelet y Sachs (1998) frente a Corsetti, Pesenti y Roubini (1999); Turquía 2018 y Argentina recientes. **Valoración (II.4):** tabla de las 3 generaciones `tab:tres-generaciones`.

**Gráfico de referencia:** **`oposicion/temario/fuentes/3B17/graficos/hojas-balance.tex`** (`fig:hojas-balance`): abscisas inversión esperada $I^e$, ordenadas inversión efectiva $I$; recta de 45°; curva en 3 tramos rotulados i), ii), iii); puntos $L=(0,0)$, $U$ (hueco, inestable) y $H$. **Sin los rótulos $U_E$, $H_E$** del original. A partir de Gandolfo (p. 403). Imprescindible en el cante del 3.B.17.

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.B.17 | Crisis de BP | desarrollo (hecho, 12/11/2026) | II.2.1-II.2.2 completos con el gráfico, II.3 evidencia, II.4 valoración y `tab:tres-generaciones` | — |
| 3.B.11 | Balanza de pagos | mención (hecho, 5/11/2026) | Descalces de monedas y crisis gemelas | El modelo |
| 3.B.12 | Ajuste y sostenibilidad | mención (hecho, 11/11/2026) | Asia y el tipo fijo como seguro implícito; Tailandia ≈8 % | — |
| 3.A.22 | Eficiencia y segundo óptimo | mención (hecho, 21/10/2026) | Liberalizar el capital con un sistema financiero débil | — |
| 3.B.15 | Regímenes | mención (hecho, 12/11/2026) | La tercera generación en una viñeta (I.2.3, `\vertema{3.B.17}`); el tipo fijo como seguro implícito (riesgo moral) y la dolarización como respuesta (I.2.4); miedo a flotar (I.3.1, II.2). Falta la etiqueta «crisis gemelas» (cosmético) | — |
| 3.B.22 | FMI | mención (prevista) | Programas en Asia y la crítica a la subida de tipos con las mismas palabras que II.2.2 iii); líneas de crédito | El modelo |
| 3.B.26 | Crisis financieras | mención (hecho, 12/11/2026) | I.1 y `tab:tipos-crisis`: gemelas y triples en una viñeta (la depreciación hunde los balances de quien se endeudó en divisas y el rescate de los bancos debilita la moneda), `\vertema{3.B.17}`; Diamond y Dybvig en desarrollo en II.1 | El modelo |
| 3.B.21 | Historia desde 1973 | uso | Asia, Argentina 2001-2002 (gemela y de deuda); Rusia 1998 (mixta, sobre todo fiscal y de deuda); Brasil 1999 (más cerca de la 1.ª/2.ª), con `tab:tres-generaciones` | El modelo |
| 1D01 | Dictamen | uso (aprobada) | Enfoque de balances, descalces | — |

## Divergencias encontradas en el temario actual
- **Resuelto en el 3.B.17 (12/11/2026):** $\varkappa$ → $q$ (D015); β propensión a importar → $m$; $D$, $D^*$ → $B$, $B^*$ (resuelve el choque con la ficha `sostenibilidad-deuda-externa`); «XN exportaciones netas» → $X$; tramos «i, i, ii» → i), ii), iii); riesgo moral atribuido a «Hausmann y Eichengreen» → McKinnon y Pill, Krugman, Corsetti, Pesenti y Roubini; «Stiglitz (2000)» → Furman y Stiglitz (1998); «apertura de la cuenta corriente y financiera» → de la financiera.
- **3.B.21 (Word, sin revisar):** Rusia 1998, Brasil 1999 y Argentina 2001-2002 como «tercera generación» sin matiz (contradicción en `mapa.yaml`, 3.B.17).

Autor: Víctor Gutiérrez Marcos
