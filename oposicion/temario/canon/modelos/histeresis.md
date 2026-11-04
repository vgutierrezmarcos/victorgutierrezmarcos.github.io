# Histéresis del desempleo (Blanchard y Summers, 1986)

- **Área:** macro cerrada · **Tema de referencia:** **3.A.28** (La tasa natural de paro y la NAIRU. La persistencia del desempleo; revisado el 31/10/2026: subapartado propio III.4 `sec:persistencia`, 4′, con a)-d)) — la persistencia está en el título.
- **Temas que lo usan:** 3.A.28 (desarrollo; hecho, 31/10/2026), 3.A.7 (resumen; hecho, 4/11/2026: I.2.3, versión pura y débil, los 3 mecanismos de Blanchard y Summers, 1986, con Lindbeck y Snower, 1986 y 1988, sin la ecuación, `\vertema{3.A.28}`; III.2, la histéresis en la NEK, Galí, 2022), 4.A.16 (mención: paro de larga duración y desplazamiento de la curva de Beveridge en España), 1D01 (mención: III.1 y VII.2), 3.A.27 (mención; hecho, 31/10/2026: el mecanismo de *insiders* y *outsiders* desarrollado allí, III.3 y anexo E, con Blanchard y Summers, 1986, y remisión aquí; en el caso B el empleo depende de la historia; ficha `insiders-outsiders`), 3.A.26 (mención; hecho, 31/10/2026: II.3, el paro de larga duración, que encuentra empleo con más dificultad, baja la eficiencia del emparejamiento y aleja la curva de Beveridge del origen, con Boscá *et al.*, 2017, y `\vertema{3.A.28}`; III.5, los costes de ajuste dan persistencia del empleo, pero la histéresis exige que el paro de hoy cambie el de equilibrio de mañana; Farmer y los equilibrios múltiples, remitidos al 3.A.28), 3.A.34 (mención; hecho, 31/10/2026: III.3 c), la histéresis de Dixit, 1989, y Baldwin y Krugman, 1989, con la nota «No es la histéresis del paro…; uno de sus canales es precisamente el capital físico que se pierde en una recesión larga `\vertema{3.A.28}`»), 3.A.36 (mención; hecho, 4/11/2026: I.4.4 `sec:histeresis`, propio y corto, A36-06: Blanchard y Summers, 1986, Galí, 2022, la Fed de 2020 que responde a los déficits de empleo y su vuelta al enfoque equilibrado en 2025, el BCE; I.1.2, la frontera que se difumina; `\vertema{3.A.28}`), 3.A.41 (mención: triángulo de Gordon con histéresis, remitido a `eq:phillips-histeresis`).
- **Manuales de referencia:** Blanchard y Summers (1986), «Hysteresis and the European Unemployment Problem», *NBER Macroeconomics Annual* (`BlanchardSummers1986Hysteresis`; el de 1987 en la *EER* es la versión corta: nunca «Blanchard y Summers, 1987» como referencia); Lindbeck y Snower (1988), *The Insider-Outsider Theory*; Blanchard y Diamond (1994), el *ranking* de los parados; Layard, Nickell y Jackman (1991); Ball (2009), NBER w14818; Galí (2015, ECB Forum; 2022, *insiders* y política monetaria); Blanchard, Cerutti y Summers (2015); Blanchard (2018), *JEP*; Cahuc, Carcillo y Zylberberg (2014), cap. 9.
- **Decisión D020 (13/10/2026):** ¿Se reserva λ para multiplicadores y precios sombra? Sí: factor de escala t (3.A.11), tasas de búsqueda f(θ) y q(θ) (DMP), persistencia de la histéresis λ_h con subíndice; se admite λ local en Laffont-Tirole (coste de los fondos públicos) y en Kahneman-Tversky

## Presentación de referencia (3.A.28, III.4)

**Pregunta:** ¿por qué el paro no vuelve a su nivel previo tras una recesión?

**a) Idea:** hechos (Reino Unido ≤ 3,3 % en 1945-1970 y > 12 % a mediados de los 80; la Comunidad Europea se dobló en 1970-1980 y otra vez después; España, cada crisis con un máximo más alto: 19,7 % en 1987, 24,1 % en 1994, 26,1 % en 2013). **Persistencia** (vuelve, despacio) frente a **histéresis** (no vuelve: el equilibrio cambia con el paro pasado); el término viene de la física y lo traen Blanchard y Summers (1986).

**b) Modelo.** *Supuestos:* la curva aceleracionista con expectativas adaptativas; una tasa natural que depende del paro pasado y de un nivel $\overline U^n$ que fija la estructura (los $Z$ y μ de la NAIRU). *Ecuación* (`\funcionclave` `eq:histeresis`):

$$U^n_t = \lambda_h\, U_{t-1} + (1-\lambda_h)\,\overline U^n,\qquad 0 \le \lambda_h \le 1$$

con λ_h = 0 sin histéresis (la NAIRU de antes: vuelve a $\overline U^n$; «agua pasada no mueve molino»), 0 < λ_h < 1 persistencia, λ_h = 1 histéresis pura (el paro sigue un paseo aleatorio; «de aquellos polvos vienen estos lodos»). En la Phillips aceleracionista (`eq:phillips-histeresis`):

$$\pi_t-\pi_{t-1} = -a\,(U_t - U^n_t) = -a\big[(U_t - U_{t-1}) + (1-\lambda_h)(U_{t-1} - \overline U^n)\big]$$

con histéresis pura importa la **variación** del paro, no su nivel: el «límite de velocidad» de Phillips (1958).

**Mecanismos** (los 3 los ordenan Blanchard y Summers, 1986, que consideran principal el 3.º; nunca «de Carlin y Soskice», «de Layard y Nickell»): (1) **capital físico**: la recesión desguaza capacidad, baja la PS y el paro de equilibrio sube hasta que se reconstruye el capital (`\vertema{3.A.34}`); (2) **capital humano** y estigma: el parado pierde cualificación y contactos, y las empresas contratan antes a quien lleva menos tiempo parado (Blanchard y Diamond, 1994); los parados de larga duración no moderan los salarios y la curva de Beveridge se aleja del origen (`\vertema{3.A.26}`); (3) ***insiders* y *outsiders*** (Lindbeck y Snower, 1988; modelo en el 3.A.27, ficha `insiders-outsiders`): los que quedan fijan salarios que solo garantizan su empleo; «quien se fue a Sevilla perdió su silla». En el lenguaje de la NAIRU, (2) y (3) suben la WS y (1) baja la PS.

*Implicaciones:* la política de demanda vuelve a importar a largo plazo (economía de alta presión); las desinflaciones salen más caras (3.A.41); la política monetaria debe mirar más al empleo (Galí, 2022; 3.A.36); políticas activas para los parados de larga duración y negociación que tenga en cuenta a los *outsiders* (3.A.27).

**c) Evidencia:** Blanchard y Summers (1986) (Europa frente a EE. UU.); Ball (2009): en 20 economías las subidas de la NAIRU coinciden con desinflaciones; España 6,5 % (1980) → 14,4 % (1995) (método distinto de AMECO: no se mezclan); Galí (2015): componente no estacionario del paro de la zona del euro; Blanchard, Cerutti y Summers (2015): 2/3 de 122 recesiones en 23 países dejaron el PIB por debajo de la tendencia; NAWRU de España que sigue al paro con retraso (+3,5 puntos en 2005-2013 frente a +17 del paro), en parte por cómo se estima (Havik *et al.*, 2014).

**d) Valoración:** explica el paro europeo y español y da a la demanda un papel duradero; pero es difícil distinguirla de una tasa natural que cambia despacio, la evidencia no es concluyente (Blanchard, 2018) y el paro depende también de reglas e instituciones (Blanchard y Wolfers, 2000; Malinvaud, con remisión al 3.A.4). El modelo NEK con desempleo (Blanchard y Galí, **2010**: más persistencia en mercados escleróticos) va en III.5 y en el 3.A.7.

**Gráfico de referencia:** `oposicion/temario/fuentes/3A28/graficos/histeresis-sendas.tex` (**imprescindible**, por capas según λ_h: 0, 0,75 y 1): sendas del paro tras una recesión entre $t_0$ y $t_1$ con $U_t=\overline U^n+\lambda_h^{t-t_1}(U_1-\overline U^n)$, $\overline U^n=1{,}5$, $U_1=4$. Apoyo en pantalla: `paro-nawru-espana.tex` (ficha `nairu-layard-nickell`).

## Cómo se adapta en cada tema

| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.28 | Persistencia del desempleo | desarrollo (hecho, 31/10/2026) | Todo lo anterior en III.4 (4′), con la ecuación recuadrada, las sendas y los 3 mecanismos | — |
| 3.A.7 | NEK | resumen (hecho, 4/11/2026) | Como extensión del modelo agregado: versión pura y débil, los 3 mecanismos de Blanchard y Summers (**1986**); Galí (2022) en III.2; la NEK con desempleo (Blanchard y Galí, 2010) en II.2 iii; `\vertema{3.A.28}` | La ecuación de λ_h |
| 3.A.27 | Determinación de salarios: *insiders* | mención (hecho, 31/10/2026) | El modelo de *insiders* y *outsiders* como mecanismo, desarrollado allí (ficha `insiders-outsiders`); `\vertema{3.A.28}` | La ecuación de λ_h |
| 3.A.26 | Curva de Beveridge; costes de ajuste | mención (hecho, 31/10/2026) | El paro de larga duración desplaza la curva de Beveridge hacia fuera (ficha `curva-beveridge`); persistencia del empleo frente a histéresis del paro; `\vertema{3.A.28}` | La ecuación de λ_h |
| 3.A.34 | Inversión | Mención (hecho, 31/10/2026) | El canal del capital físico (la inversión cae con el empleo y el capital perdido reduce la demanda de trabajo durante años) con `\vertema{3.A.28}`; la «histéresis» de la inversión irreversible (banda de inacción de Dixit, 1989) es otra idea | La ecuación |
| 3.A.36 | Política monetaria | mención (hecho, 4/11/2026) | I.4.4: la histéresis como argumento para dar peso al empleo (Blanchard y Summers, 1986; Galí, 2022); la Fed de 2020 (déficits de empleo, no excesos) y su vuelta de 2025; el BCE tiene en cuenta el empleo en el ritmo de vuelta al objetivo; `\vertema{3.A.28}` | La ecuación |
| 3.A.41 | Inflación | Mención | Coste de las desinflaciones y triángulo de Gordon con histéresis: remitir a `eq:phillips-histeresis` del 3.A.28 | La ecuación |
| 4.A.16 | Mercado de trabajo español | Mención | Paro de larga duración y curva de Beveridge (Dolado); máximos crecientes del paro | — |
| 1D01 | Dictamen de coyuntura | Mención | Paro de larga duración, *insiders-outsiders* y pérdida de capital humano: el paro cíclico se vuelve estructural; recomendaciones de políticas activas | El modelo |

## Divergencias encontradas en el temario actual

- **Resuelto en el 3.A.28 (31/10/2026)**: la histéresis era una «extensión» de 460 palabras sin ecuación ni gráfico; «Blanchard y Summers (1987)»; mecanismos atribuidos a Carlin y Soskice, Layard y Nickell y Lindbeck y Snower; «la evidencia de histéresis de Blanchard y Galí» (es Galí, 2015; Ball, 2009; Blanchard, Cerutti y Summers, 2015); jubilaciones anticipadas sin fuente. Esta ficha decía «1986-1987» en el título: queda 1986.
- **3.A.7 (**resuelto** al revisarlo, 4/11/2026; antes)**: «Blanchard y Summers, 1987» y la histéresis copiada del 3.A.28 viejo; «Blanchard y Galí (2005)» (es 2010).
- El coeficiente de persistencia se escribe λ_h (con subíndice) para no chocar con λ = precio sombra.

Autor: Víctor Gutiérrez Marcos
