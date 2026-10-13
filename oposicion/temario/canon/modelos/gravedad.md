# Modelo de gravedad y efecto frontera

- **Área:** comercio · **Tema de referencia:** 3.B.10 (Teoría de la integración económica) — tiene los tres epígrafes (gravedad, gravedad con heterogeneidad, efecto frontera) y es la herramienta para medir la integración; 3.B.6 debe quedarse con los microfundamentos en una línea.
- **Temas que lo usan:** 3.B.10 (desarrollo), 3.B.6 (resumen), 3.B.15, 3.B.35, 3.B.41 (mención), 4.A.22, 4.A.24, 4.A.25 (mención)
- **Manuales de referencia:** Tinbergen (1962); Anderson y van Wincoop (2003, *AER*); Head y Mayer (2014, *Handbook of International Economics*, vol. 4); Chaney (2008); McCallum (1995); Rose (2000); Feenstra, cap. 5; Yotov et al. (2016), *An Advanced Guide to Trade Policy Analysis: The Structural Gravity Model* (OMC-UNCTAD).

## Presentación de referencia
**Pregunta:** ¿qué determina el volumen de comercio bilateral y cuánto pesan las fronteras y los acuerdos?

**Ecuaciones (notación canónica):**
$$\ln X_{ij} = \beta_0 + \beta_1 \ln Y_i + \beta_2 \ln Y_j - \beta_3 \ln d_{ij} + \beta_4\,ACR_{ij} + \varepsilon_{ij}$$
Versión estructural (Anderson-van Wincoop): $X_{ij} = \dfrac{Y_i Y_j}{Y_W}\Big(\dfrac{t_{ij}}{\Pi_i P_j}\Big)^{1-\sigma}$ con resistencias multilaterales $\Pi_i$, $P_j$ (en la práctica, efectos fijos de exportador e importador; estimación PPML).

**Resultado:** elasticidad renta ≈ 1, elasticidad distancia ≈ −1; efecto frontera grande (McCallum: Canadá-EE. UU.); efecto moneda común (Rose, 2000, sobrestimado); con heterogeneidad (Chaney, 2008) la distancia actúa sobre el margen extensivo.

**Gráfico de referencia:** dispersión del comercio bilateral (log) frente a la distancia o al producto de los PIB. Sin `.tex` aún.

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.B.10 | Integración económica | desarrollo | Tinbergen, AvW, heterogeneidad y efecto frontera (hoy sin ecuaciones: añadirlas) | — |
| 3.B.6 | Nueva teoría del comercio | resumen | La gravedad como implicación de Krugman (1980) y Melitz-Chaney | Estimación y efecto frontera |
| 3.B.15 | Regímenes cambiarios | mención | Efecto moneda común (Rose, 2000) y su corrección posterior | — |
| 3.B.35, 3.B.41 | Regionalismo, UE | mención | Evaluación de acuerdos (p. ej. Timini y Viani, 2020, UE-Mercosur) | — |
| 4.A.22, 4.A.24, 4.A.25 | Comercio y empresa española | mención | Potencial infraexplotado en Asia | — |

## Divergencias encontradas en el temario actual
- La ecuación solo aparece en 3.B.6 (Tinbergen), mientras 3.B.10, que la desarrolla, no tiene ninguna: llevar la ecuación a 3.B.10.
- $\beta$ son coeficientes de regresión aquí; en 3.B.9 $\beta$ es el grado de apertura y en 3.B.15 la movilidad del capital: aceptable si se define, porque no se mezclan.
- Ids fusionados (`gravitatorio`, `modelo-gravedad`): correcto.

Autor: Víctor Gutiérrez Marcos
