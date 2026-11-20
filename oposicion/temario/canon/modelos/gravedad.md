# Modelo de gravedad y efecto frontera

- **Área:** comercio · **Tema de referencia:** 3.B.10 (Teoría de la integración económica) — tiene los tres epígrafes (gravedad, gravedad con heterogeneidad, efecto frontera) y es la herramienta para medir la integración; 3.B.6 debe quedarse con los microfundamentos en una línea.
- **Temas que lo usan:** 3.B.10 (desarrollo; hecho, 5/11/2026: III.2 `sec:gravedad` con `eq:gravedad`, `eq:gravedad-estructural` y `fig:gravedad`), 3.B.6 (resumen; hecho, 5/11/2026: III.2 `sec:gravedad`, la ecuación de Tinbergen y los microfundamentos), 3.B.15 (mención; hecho, 12/11/2026: I.2.3, Rose, 2000, y los metaanálisis, `\vertema{3.B.10}` `\vertema{3.B.16}`), 3.B.35, 3.B.41 (mención), 4.A.22, 4.A.24, 4.A.25 (mención)
- **Manuales de referencia:** Tinbergen (1962); Anderson y van Wincoop (2003, *AER*); Head y Mayer (2014, *Handbook of International Economics*, vol. 4); Chaney (2008); McCallum (1995); Rose (2000); Feenstra, cap. 5; Yotov et al. (2016), *An Advanced Guide to Trade Policy Analysis: The Structural Gravity Model* (OMC-UNCTAD).
- **Al día (pasada final, noviembre de 2026):** ya hay gráfico de referencia con datos: `fuentes/3B32/graficos/gravedad-espana.tex` (antes «sin .tex aún»).

## Presentación de referencia
**Pregunta:** ¿qué determina el volumen de comercio bilateral y cuánto pesan las fronteras y los acuerdos?

**Ecuaciones (notación canónica):**
$$\ln X_{ij} = \beta_0 + \beta_1 \ln Y_i + \beta_2 \ln Y_j - \beta_3 \ln d_{ij} + \beta_4\,\mathrm{ACR}_{ij} + u_{ij}$$
(`eq:gravedad`, función clave del 3.B.10; el 3.B.6 la escribe sin $\mathrm{ACR}_{ij}$). Notación (pasada final, K31 del 3.B.10): **$\tau_{ij}$** coste bilateral de comerciar (no $t_{ij}$, que choca con el arancel $t$; τ es el coste iceberg, D083), **$u_{ij}$** término de error (no $\varepsilon_{ij}$: ε con 2 subíndices es una elasticidad, § 0), **$\mathrm{ACR}_{ij}$** en redonda (sigla de acuerdo comercial regional); Arkolakis, Costinot y Rodríguez-Clare (2012) no se abrevian «ACR» en ningún tema.
Versión estructural (Anderson-van Wincoop, `eq:gravedad-estructural`): $X_{ij} = \dfrac{Y_i Y_j}{Y_W}\Big(\dfrac{\tau_{ij}}{\Pi_i P_j}\Big)^{1-\sigma}$ con resistencias multilaterales $\Pi_i$, $P_j$ (en la práctica, efectos fijos de exportador e importador; estimación PPML).

**Resultado:** elasticidad renta ≈ 1, elasticidad distancia ≈ −1; efecto frontera grande (McCallum: Canadá-EE. UU.); efecto moneda común (Rose, 2000, sobrestimado); con heterogeneidad (Chaney, 2008) la distancia actúa sobre el margen extensivo; un ALC duplica más o menos el comercio entre socios en unos 10 años (Baier y Bergstrand, 2007); estimación PPML (Santos Silva y Tenreyro, 2006).

**Gráfico de referencia:** `oposicion/temario/fuentes/3B10/graficos/gravedad.tex` (dispersión del comercio bilateral en logaritmos frente a la distancia).

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.B.10 | Integración económica | desarrollo (hecho, 5/11/2026) | III.2: Tinbergen, Anderson-van Wincoop, heterogeneidad, efecto frontera, Baier y Bergstrand (2007), PPML | — |
| 3.B.6 | Nueva teoría del comercio | resumen (hecho, 5/11/2026) | La ecuación de Tinbergen en una línea y los microfundamentos (Krugman, 1980; Anderson y van Wincoop, 2003; Chaney, 2008, margen extensivo) | Estimación, efecto frontera y la ecuación estructural completa (3.B.10) |
| 3.B.15 | Regímenes cambiarios | mención (hecho, 12/11/2026) | I.2.3: con una ecuación de gravedad, los países con la misma moneda comerciaban unas 3 veces más (`Rose2000One`); los metaanálisis lo rebajan (`RoseStanley2005Meta`, `GlickRose2016Currency`); `\vertema{3.B.10}` `\vertema{3.B.16}` (el Word remitía al 3.B.6) | La ecuación |
| 3.B.35, 3.B.41 | Regionalismo, UE | mención (3.B.35 hecho, 18/11/2026: I.2 y nota de Tinbergen, `\vertema{3.B.10}`) | Evaluación de acuerdos (p. ej. Timini y Viani, 2020, UE-Mercosur) | — |
| 4.A.22, 4.A.24, 4.A.25 | Comercio y empresa española | mención | Potencial infraexplotado en Asia | — |
| 3.B.32 | Economía mundial | resumen aplicado (hecho, 14/11/2026) | II.3: la geografía del comercio con datos de España 2024 (pendiente −1,29, R² 0,39), gráfico `gravedad-espana`; Disdier y Head (2008); la geopolítica como distancia (Gopinath *et al.*, 2025) | La estimación estructural |

## Divergencias encontradas en el temario actual
- La ecuación solo aparece en 3.B.6 (Tinbergen), mientras 3.B.10, que la desarrolla, no tiene ninguna: llevar la ecuación a 3.B.10.
- $\beta$ son coeficientes de regresión aquí; en 3.B.9 $\beta$ es el grado de apertura y en 3.B.15 la movilidad del capital: aceptable si se define, porque no se mezclan.
- Ids fusionados (`gravitatorio`, `modelo-gravedad`): correcto.
- **Resuelto** (5/11/2026): el 3.B.10 revisado tiene ya la ecuación. Las 2 funciones clave `eq:gravedad` del 3.B.6 y del 3.B.10 son la misma ecuación (el 3.B.6 sin el término del acuerdo): coherente.

Autor: Víctor Gutiérrez Marcos
