# Modelo de la diagonal o de índice (Sharpe, 1963): riesgo sistemático y específico

- **Área:** finanzas-empresa · **Tema de referencia:** **3.B.23** (revisado el 8/11/2026, `sec:sharpe-diagonal`, a)-c)) — variante aplicada de `markowitz`; `mapa.yaml` lo listaba sin ficha. Ficha propia creada en la pasada final (noviembre de 2026) porque la usan 2 temas (alternativa de la nota del 3.B.23: variante dentro de `markowitz`).
- **Temas que lo usan:** 3.B.23 (desarrollo; hecho, 8/11/2026), 3.B.2 (mención; hecho, 8/11/2026: riesgo sistemático y específico del proyecto, `\vertema{3.B.23}`).
- **Manuales de referencia:** Sharpe (1963), *Management Science* (`Sharpe1963Simplified`); Solnik (1974); French y Poterba (1991); Bodie, Kane y Marcus (2021), cap. 8.

## Presentación de referencia (3.B.23)
**Pregunta:** ¿cómo aplicar Markowitz a cientos de títulos?

**Modelo de índice en excesos de rentabilidad (`eq:modelo-indice`):** $r_i-r_f=\alpha_i+\beta_i(r_M-r_f)+\varepsilon_i$, con $\mathbb{E}[\varepsilon_i]=0$, $\mathrm{Cov}(\varepsilon_i,r_M)=0$ y $\mathrm{Cov}(\varepsilon_i,\varepsilon_j)=0$ (residuos independientes: la matriz de los residuos es diagonal). $\alpha_i$ es el **α de Jensen** (constante del modelo); $\varepsilon_i$ perturbación específica (local, avisada).

**Desarrollo:** $\sigma_i^2=\beta_i^2\sigma_M^2+\sigma_{\varepsilon_i}^2$; con $\beta_p=\sum_iw_i\beta_i$, `eq:riesgo-sistematico` $\sigma_p^2=\beta_p^2\sigma_M^2+\sum_iw_i^2\sigma_{\varepsilon_i}^2$; $3n+2$ parámetros en lugar de $n(n+3)/2$.

**Implicaciones:** diversificar elimina el riesgo específico, no el sistemático; lo que importa de una acción en una cartera diversificada es su beta (puente al CAPM); diversificación internacional (Solnik, 1974) y sesgo doméstico (French y Poterba, 1991).

**Gráfico de referencia:** `oposicion/temario/fuentes/3B23/graficos/diversificacion.tex` (riesgo de la cartera frente al número de títulos: el específico tiende a cero, el sistemático queda) y `diversificacion-internacional.tex`.

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.B.23 | Teoría de carteras | desarrollo (hecho, 8/11/2026) | Todo lo anterior | — |
| 3.B.2 | Riesgo del proyecto | mención (hecho, 8/11/2026) | Riesgo sistemático y específico; solo se paga el primero | El modelo |

## Divergencias encontradas en el temario actual
- Ninguna conocida.

Autor: Víctor Gutiérrez Marcos
