# Teoría de las perspectivas (Kahneman y Tversky, 1979; Tversky y Kahneman, 1992)

- **Área:** consumidor-producción · **Tema de referencia:** **3.A.10** (Demanda III: riesgo e incertidumbre; revisado el 19/10/2026, II.2) — único que lo desarrolla, con fórmulas, gráficos y la teoría acumulativa, como alternativa a la utilidad esperada (ficha `utilidad-esperada-vnm`).
- **Temas que lo usan:** 3.A.10 (desarrollo; hecho), 3.A.1 (resumen: economía conductual), 3.A.8 (mención; hecho: la dependencia del marco en la nota de la transitividad, la economía conductual en la valoración, l. 1209, y el **anexo de Thaler**, l. 1672-1679, donde el efecto dotación se explica por la aversión a las pérdidas), 3.B.23 (mención: finanzas conductuales, enigmas financieros; desarrollo de la eficiencia en la ficha `emh`).
- **Manuales de referencia:** Kahneman y Tversky (1979), *Econometrica*; Tversky y Kahneman (1992), *JRU* (teoría acumulativa y forma paramétrica); Kahneman (2003), conferencia Nobel; Wakker (2010); Starmer (2000), *JEL*; Thaler (2015, 2018); Barberis (2013), *JEP*.

## Presentación de referencia (3.A.10, II.2, estructura a)-e))

Pregunta: ¿por qué las personas violan los axiomas de la utilidad esperada (Allais, efecto marco), y qué teoría describe mejor cómo eligen?

- **a) Idea:** teoría **descriptiva** (positiva) de la utilidad **no esperada**; difiere de la utilidad esperada en cómo se **definen** las alternativas (ganancias y pérdidas respecto a un punto de referencia), cómo se **valoran** (función de valor en S) y cómo se **ponderan** (pesos de decisión, no probabilidades). Colaboración desde 1969 en la Universidad Hebrea; nombre elegido sin significado preciso (Kahneman, 2002). Título en castellano: «teoría de las perspectivas» (*prospect theory* entre paréntesis una vez).
- **b) Modelo.** i) Supuestos: **fase de edición** (codificación respecto a un **punto de referencia r**, combinación, segregación, cancelación, eliminación de dominadas) y **fase de evaluación**. ii) Desarrollo:
$$V=\sum_{s=1}^{S}w(\pi_s)\,v(x_s-r)$$
(`\funcionclave`, `eq:perspectivas`; con r = 0, w(π) = π y v = u es la utilidad esperada). **Función de valor** v(·): dependencia del punto de referencia, **sensibilidad decreciente** (cóncava en ganancias, convexa en pérdidas) y **aversión a las pérdidas** (quiebro en r). Forma de Tversky y Kahneman (1992), con la misma curvatura en ganancias y pérdidas:
$$v(z)=\begin{cases} z^{\beta} & z\ge 0\\ -\lambda\,(-z)^{\beta} & z<0\end{cases}\qquad z=x_s-r,\quad \beta\approx 0{,}88,\quad \lambda\approx 2{,}25$$
(`eq:funcion-valor`). **Función de ponderación** w(π): creciente, w(0) = 0, w(1) = 1, sobrepondera las probabilidades bajas e infrapondera las medias y altas, efecto certeza en los extremos:
$$w(\pi)=\frac{\pi^{\delta}}{\big[\pi^{\delta}+(1-\pi)^{\delta}\big]^{1/\delta}},\qquad \delta\approx 0{,}61\ \text{(ganancias)},\ 0{,}69\ \text{(pérdidas)}$$
(`eq:ponderacion`; con δ = 0,61, w(0,01) ≈ 0,055 y w(0,9) ≈ 0,71). iii) Implicaciones: **patrón cuádruple** (aversión en ganancias y búsqueda en pérdidas con probabilidades medias y altas; al revés con probabilidades bajas: se compra **lotería** y **seguro**), que responde a Friedman-Savage sin una u con tramos; efecto marco (experimento de los problemas 11 y 12: 84 % y 69 %); **efecto dotación** como aversión a las pérdidas aplicada a los bienes (Kahneman, Knetsch y Thaler, 1990; 3.A.8).
- **c) Extensiones:** **teoría acumulativa** (Tversky y Kahneman, 1992: w sobre probabilidades acumuladas, una para ganancias y otra para pérdidas; respeta la dominancia y se aplica a la incertidumbre); otras teorías no esperadas (tabla `tab:no-esperada`): utilidad dependiente del rango (Quiggin, 1982; función g), subjetivamente ponderada (Karmarkar, 1978), ponderada (Chew, 1983; función h > 0), del pesar (Loomes-Sugden y Bell, 1982), esperada generalizada (Machina, 1982; abanico).
- **d) Evidencia:** réplica de 2020 (4.098 personas, 19 países, 94 %; Ruggeri et al.); rigidez a la baja de los salarios nominales (Kahneman, Knetsch y Thaler, 1986); vivienda (Genesove y Mayer, 2001); riesgos nuevos y poco probables (Gigerenzer, 2004: 11-S); felicidad y renta (Easterlin, 1974, frente a Stevenson y Wolfers, 2008). Caja de **finanzas conductuales** (anotación, no se canta): prima de las acciones (Mehra-Prescott, 1985; ≈ 6 puntos sobre letras y ≈ 5 sobre bonos; aversión miope a las pérdidas de Benartzi-Thaler, 1995), exceso de volatilidad (Shiller, 1981; Barberis-Huang-Santos, 2001), efecto disposición (Shefrin-Statman, 1985), dividendos (hasta 2003; contabilidad mental y Maquiavelo).
- **e) Valoración:** la descripción que mejor encaja con los experimentos; origen de la economía y las finanzas conductuales; racionalidad limitada (Simon, 1955; Kahneman, 2003); *nudges* (Thaler, 2018). Límites: punto de referencia indeterminado, sin fuerza normativa, agregación de sesgos. Complemento, no sustituto, de la utilidad esperada.

**Notación:** V (valor; en el 3.A.10 no convive con la función indirecta de utilidad V(p⃗,W̄), que se nombra de palabra), v(·), w(·), r (punto de referencia; local, no es el tipo de interés), z = x_s − r, **β** curvatura de v (local; no es el factor de descuento), **λ** aversión a las pérdidas (local avisado en `notacion.md` § 1), **δ** parámetro de w (local; se eligió δ y no γ para no chocar con la prima del seguro del mismo tema); probabilidades π_s (D017).

**Gráficos de referencia** (`oposicion/temario/fuentes/3A10/graficos/`): `funcion-valor.tex` (**imprescindible**: función de valor en S con el quiebro en el punto de referencia), `ponderacion.tex` (función de ponderación frente a la bisectriz) y, como antecedente, `friedman-savage-markowitz.tex` (II.1).

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.10 | Alternativas a la utilidad esperada | desarrollo (hecho, 19/10/2026) | Todo lo anterior | — |
| 3.A.1 | Economía conductual | resumen | Idea, función de valor en S con aversión a las pérdidas (λ ≈ 2,25), aplicaciones (efecto dotación, statu quo, *nudges*); remite a 3.A.10 | Fórmulas de 1992, teoría acumulativa |
| 3.A.8 | Teoría del consumidor | mención (hecho) | Marco y aversión a las pérdidas como desviaciones de los axiomas; efecto dotación en el anexo de Thaler | El modelo |
| 3.B.23 | Renta variable y carteras | mención | Finanzas conductuales: la aversión a las pérdidas explica la prima de las acciones y el efecto disposición; remite a 3.A.10 | La caja de enigmas completa, que repetiría el 3.A.10 (con cifras con fuente: ≈ 6 puntos sobre letras, ≈ 5 sobre bonos) |

## Divergencias encontradas en el temario actual
- 3.A.10 original: sin fórmulas, *framework effect*, colaboración «desde los años 50 en el ejército», anécdota del nombre atribuida a Bernstein, «cuatro décadas», tabla de la nota 43 con π(p_i) y sin fuente. **Resuelto** (19/10/2026): fórmulas de 1992, *framing effect*, fuentes primarias, w(π_s), tabla propia citando cada obra.
- **Notación de la ponderación:** w(π_s) (Tversky y Kahneman, 1992; D017), nunca π(p_s) del original de 1979: p son precios y π las probabilidades (y la inflación en macro). En el 3.A.10 w no choca con el salario (no sale); si el 3.A.1 escribe la ponderación, también w(π_s).
- **Parámetros:** β (curvatura) y δ (ponderación), no α ni γ de Tversky y Kahneman (1992): α es la inversión en el activo con riesgo y el coeficiente de Hurwicz del mismo tema, y γ la prima del seguro.
- 3.B.23: misma caja de enigmas que el 3.A.10, casi literal, con «más de 6 puntos» sin fuente (`mapa.yaml`, contradicciones del 3.A.10; ficha `emh`).

Autor: Víctor Gutiérrez Marcos
