# Modelo de valoración de activos basado en el consumo (C-CAPM: Lucas, 1978; Breeden, 1979) y el enigma de la prima de riesgo (Mehra y Prescott, 1985)

- **Área:** macro cerrada · **Tema de referencia:** **3.A.33** (revisado el 31/10/2026: II.3 `sec:ccapm`, derivación en el anexo C `anexo:hall-ccapm`) — es la ecuación de Euler del consumo con varios activos; Víctor lo pidió para este tema (nota del Word del 3.A.29: «el de C-CAPM habría que meterle en ese tema»). Ficha creada en la fase canon del 3.A.33 (DC3/A33-03, K24, **[decidir]**).
- **Temas que lo usan:** 3.A.33 (desarrollo; hecho, 31/10/2026), 3.B.23 (resumen: beta de consumo frente a beta de mercado; el CAPM como caso particular), 3.A.29 (mención: Euler con incertidumbre), 3.A.1 (mención: enigma de la prima de riesgo y aversión miope a las pérdidas de Benartzi y Thaler, 1995).
- **Manuales de referencia:** Lucas (1978), *Econometrica*; Breeden (1979), *JFE*; Hansen y Singleton (1983), *JPE*; Mehra y Prescott (1985), *JME*; Campbell y Cochrane (1999), *JPE*; Cochrane (2005), *Asset Pricing*, cap. 1; Romer (2019), cap. 8.

## Presentación de referencia (3.A.33, II.3, pieza 2 de las salidas: el tipo de interés)

Pregunta: ¿qué rentabilidad exige un hogar a un activo con riesgo? Estructura a)-e) (idea, modelo, implicaciones, evidencia).

- **Supuestos:** los de Hall (ficha `hall`), con varios activos i de rendimiento real incierto r_{i,t+1} y un activo sin riesgo que rinde r_f.
- **Ecuación** (`eq:ccapm`, una línea sin recuadro):
$$1=\mathbb{E}_t\big[m_{t+1}\,(1+r_{i,t+1})\big],\qquad m_{t+1}\equiv\beta\,\frac{u'(C_{t+1})}{u'(C_t)}$$
  m_{t+1} **factor de descuento estocástico** (alto cuando el consumo de mañana es bajo); con el activo seguro, 1 + r_f = 1/𝔼_t[m_{t+1}]; prima:
$$\mathbb{E}_t[r_{i,t+1}]-r_f=-(1+r_f)\operatorname{Cov}_t\big(m_{t+1},r_{i,t+1}\big)\simeq\theta\operatorname{Cov}_t\big(r_{i,t+1},\Delta\ln C_{t+1}\big)$$
  (CRRA y lognormalidad; derivación en el anexo C).
- **Implicaciones:** se paga el riesgo de rendir poco cuando el consumo es bajo; cuenta la covarianza con el consumo, no la varianza; el CAPM es el caso particular en que el consumo se mueve con la cartera de mercado (`\vertema{3.B.23}`).
- **Evidencia:** Hansen y Singleton (1983) rechazan las restricciones; **enigma de la prima de riesgo** (Mehra y Prescott, 1985): 1889-1978, unos 6 puntos de prima frente a no más de 0,4 con θ ≤ 10; los hábitos son una respuesta (Campbell y Cochrane, 1999; ficha `hall`).

**Gráfico de referencia:** no imprescindible (la ecuación en la pizarra, sobre la Euler estocástica, con el número 2).

**Notación:** m_{t+1} local (M es el dinero; m(U,V) emparejamientos en el 3.A.26, no conviven); r_f, r_{i,t+1} minúsculas (D063); θ (D001); Cov_t y var_t en redonda. La β_i del CAPM es otra (§ 1).

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.33 | Consumo con incertidumbre | desarrollo (hecho, 31/10/2026) | 1′ en el cante: la ecuación y la idea de la covarianza; anexo C con la prima y el enigma | — |
| 3.B.23 | Renta variable, cartera y CAPM | resumen | El C-CAPM como generalización del CAPM (beta de consumo, Breeden, 1979) y el enigma con la explicación conductual que ya tiene; `\vertema{3.A.33}` y un resumen que se cante sin el 3.A.33 | La derivación |
| 3.A.29 | Modelización dinámica | mención | La Euler estocástica con varios activos | El modelo |
| 3.A.1 | Economía conductual | mención | Enigma de la prima y aversión miope a las pérdidas (Benartzi y Thaler, 1995) | El modelo |

## Divergencias encontradas en el temario actual
- 3.A.33 original: «C-CAPM [Buscar modelo]» (P7). **Resuelto** (31/10/2026).
- 3.B.23 (sin revisar): no tiene C-CAPM; debe recibir el resumen. Además dice «descuento **parabólico**» (es exponencial) y remite el hiperbólico al 3.A.29 (es el 3.A.1; ficha `descuento-hiperbolico`).

Autor: Víctor Gutiérrez Marcos
