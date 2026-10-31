# Modelo de Solow aumentado con capital humano (Mankiw, Romer y Weil 1992)

- **Área:** macro cerrada · **Tema de referencia:** **3.A.43** (crecimiento I): el modelo está en su título. **Revisado el 31/10/2026**: II.1 «El modelo de Mankiw, Romer y Weil (1992)» (4′, a)-e) completos) y anexo C, b) (velocidad de convergencia). Reparto (D090): el modelo teórico en el 3.A.43 y la estimación, sus muestras y la evidencia en el 3.A.45.
- **Temas que lo usan:** 3.A.43 (desarrollo; hecho, 31/10/2026), 3.A.45 (uso empírico: estimación y evidencia, con la ecuación y la notación del 3.A.43), 3.A.44 (mención: con α + β = 1 sería crecimiento endógeno; Uzawa-Lucas como salida a sus críticas), 3.B.28 (mención), 3.B.42 (mención)
- **Manuales de referencia:** Mankiw, Romer y Weil (1992), *QJE*, tablas I, II y V; Romer (2019), caps. 1 y 4; Barro y Sala i Martín (2004), cap. 1; Acemoglu (2009), cap. 3; Hall y Jones (1999); Klenow y Rodríguez-Clare (1997); Caselli (2005).
- **Decisión D090 (13/10/2026):** ¿Cómo se reparte Mankiw-Romer-Weil entre 3.A.43 y 3.A.45? Modelo teórico en 3.A.43 (con Harrod-Domar como antecedente breve) y estimación y evidencia en 3.A.45
- **Decisión D107 (13/10/2026):** ¿Qué letra lleva la elasticidad del capital humano en Mankiw-Romer-Weil? β, como el artículo (no convive con el factor de descuento en 3.A.43-3.A.45)

## Presentación de referencia (3.A.43, II.1)

**Pregunta:** ¿explica el modelo de Solow las diferencias internacionales de renta si se incluye el capital humano?

**a) Idea.** Con α = 1/3, Solow predice una elasticidad de la renta respecto al ahorro de α/(1 − α) = 0,5 y una convergencia del 4 %; los datos piden más. Falta un factor acumulable, el capital humano H (`\vertema{3.A.25}`).

**b) Modelo.**
- *Supuestos*: los de Solow con una Cobb-Douglas de 3 factores,
$$Y_t=K_t^{\alpha}H_t^{\beta}(A_tL_t)^{1-\alpha-\beta},\qquad\alpha+\beta<1\qquad(\texttt{eq:mrw})$$
  (con α + β = 1 sería crecimiento endógeno, `\vertema{3.A.44}`); fracciones $s_K$ y $s_H$ de la renta; un solo bien; misma δ; n, g exógenos.
- *Acumulación* (`eq:mrw-acumulacion`), con $k\equiv K/(AL)$, **$h\equiv H/(AL)$** (agregado por unidad de trabajo eficiente; nota: el h del 3.A.25 es individual, no conviven) e $y=k^{\alpha}h^{\beta}$:
$$\dot k_t=s_K\,k_t^{\alpha}h_t^{\beta}-(n+g+\delta)\,k_t,\qquad\dot h_t=s_H\,k_t^{\alpha}h_t^{\beta}-(n+g+\delta)\,h_t$$
- *Estado estacionario*: $h^*/k^*=s_H/s_K$; $k^*=[s_K^{1-\beta}s_H^{\beta}/(n+g+\delta)]^{1/(1-\alpha-\beta)}$, $h^*=[s_K^{\alpha}s_H^{1-\alpha}/(n+g+\delta)]^{1/(1-\alpha-\beta)}$; único y estable (en (k, h), $\dot k=0$ convexo y $\dot h=0$ cóncavo).
- *Ecuación de la renta* (función clave):
$$\boxed{\ln\frac{Y_t}{L_t}=\ln A_0+g\,t+\frac{\alpha}{1-\alpha-\beta}\ln s_K+\frac{\beta}{1-\alpha-\beta}\ln s_H-\frac{\alpha+\beta}{1-\alpha-\beta}\ln(n+g+\delta)}\qquad(\texttt{eq:mrw-renta})$$
  y la 2.ª forma con $h^*$ (la de Solow con un término $\frac{\beta}{1-\alpha}\ln h^*$): omitir el capital humano sesga al alza los coeficientes de $s_K$ y n (por eso α = 0,6).
- *Implicaciones*: con α = β = 1/3, elasticidad respecto a $s_K$ igual a 1 (el doble) y respecto a n + g + δ igual a −2 (el cuádruple); una subida de $s_H$ eleva k*, h*, y* y el nivel de Y/L pero no $\alpha y^*/k^*=\alpha(n+g+\delta)/s_K$; **λ = (1 − α − β)(n + g + δ)** ≈ 2 % y semivida ≈ 35 años (anexo C, b); efecto nivel, no crecimiento; regla de oro con $s_K=\alpha$ y $s_H=\beta$.

**c) Extensiones.** Hall y Jones (1999): $Y=K^{\alpha}(AhL)^{1-\alpha}$ con $h=e^{\phi(S)}$, φ′(S) rendimiento de Mincer (φ local, avisada; `\vertema{3.A.25}`, ficha `mincer`); contabilidad del desarrollo (Klenow y Rodríguez-Clare, 1997; Hall y Jones, 1999; Caselli, 2005): la mayor parte es A (`\vertema{3.A.45}`).

**d) Evidencia.** MRW, 1960-1985, 98 países no petroleros, $g+\delta=0{,}05$: Solow, $R^2$ ajustado 0,59 con α implícita 0,60; ampliado, 0,78 con α ≈ 0,31 y β ≈ 0,28 (tablas I y II); convergencia condicional 1,4-2 % (tabla V). Con datos actuales (cálculo propio, PWT 11.0, 1960-2023, 78 países): α implícita 0,64 y $R^2$ 0,54; con capital humano, 0,76 (`inversion-renta`). La estimación y sus muestras, en el 3.A.45.

**e) Valoración.** Devuelve a Solow al debate empírico; críticas: la matrícula en secundaria mide mal $s_H$; $A_0$ correlacionado con las tasas de inversión (instituciones, anexo F); misma tecnología y g en todos los países → Uzawa-Lucas (`\vertema{3.A.44}`).

**Gráficos de referencia** (`oposicion/temario/fuentes/3A43/graficos/`): ninguno de pizarra; en el cante, la ecuación `eq:mrw-renta` recuadrada junto a `eq:solow`, y el gráfico de tasas de Solow con la curva $s_K f(k)/k$ más alta. De apoyo: `mrw-fases.tex` (lugares $\dot k=0$ y $\dot h=0$ en el plano (k, h)) e `inversion-renta.tex` (datos, PWT 11.0). El gráfico de la renta observada frente a la predicha es del 3.A.45.

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.43 | Solow aumentado (título) | desarrollo (hecho, 31/10/2026) | a)-e) completos; `eq:mrw-renta` función clave; λ ≈ 2 %; Hall y Jones; cifras de MRW y con datos actuales | La estimación detallada `\vertema{3.A.45}` |
| 3.A.45 | Evidencia empírica y convergencia | uso empírico | Estimación, resultados por muestras (amplia, intermedia, OCDE), convergencia condicional, críticas, contabilidad del desarrollo; con `eq:mrw-renta` y la notación del 3.A.43 (β, $s_K$, $s_H$) | El modelo teórico `\vertema{3.A.43}` |
| 3.A.44 | Crecimiento endógeno | mención | Con α + β = 1, crecimiento endógeno; Uzawa-Lucas como respuesta a las críticas | El modelo |
| 3.B.28 | Desarrollo | mención | Por qué persisten las diferencias de renta | — |
| 3.B.42 | Cooperación al desarrollo de la UE | mención | Por qué persisten las diferencias | — |

## Divergencias encontradas en el temario actual
- 3.A.43: MRW en una línea con el título nuevo, y el Word del 3.A.45 lo desarrollaba (1.3.1). **Resuelto en el 3.A.43** (31/10/2026); el 3.A.45 debe pasar a la estimación con la ecuación del 3.A.43 (`mapa.yaml`, contradicciones del 3.A.43).
- β es aquí la elasticidad del capital humano y en el resto de macro el factor de descuento: en el 3.A.43 no conviven (el RCK se escribe con ρ). En el mismo II.2, las participaciones del recurso y de la tierra se escriben $\alpha_R$, $\alpha_T$ (no las β, γ de Romer) para no chocar con esta β.

Autor: Víctor Gutiérrez Marcos
