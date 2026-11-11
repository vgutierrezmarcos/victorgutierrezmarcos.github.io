# Modelo centro-periferia (Krugman, 1991) y nueva geografía económica

- **Área:** comercio · **Tema de referencia:** 3.B.6 (Nueva teoría del comercio: competencia imperfecta, rendimientos crecientes) — el modelo es la extensión de Krugman (1980) con movilidad de factores y comparte con él Dixit-Stiglitz y los costes iceberg, que 3.B.6 ya desarrolla.
- **Temas que lo usan:** 3.B.6 (desarrollo), 3.A.18 (mención; hecho, 19/10/2026), 3.B.9 (desarrollo → resumen), 3.B.10 (resumen), 3.B.16 (resumen del resultado; hecho, 11/11/2026: II.2.1 `sec:krugman` con la hipótesis de Krugman, 1993, resumen del resultado, sin anexo (12/11/2026), con el punto de ruptura de palabra y `\vertema{3.B.6}`), 3.B.35 (resumen), 3.B.40 (desarrollo → resumen aplicado), 4.A.12 (mención), 4.A.17 (resumen)
- **Manuales de referencia:** Krugman (1991), «Increasing Returns and Economic Geography», *JPE*; Fujita, Krugman y Venables, *The Spatial Economy* (1999), caps. 4-5; Baldwin, Forslid, Martin, Ottaviano y Robert-Nicoud, *Economic Geography and Public Policy* (2003); Combes, Mayer y Thisse, *Economic Geography* (2008); Feenstra, *Advanced International Trade*, cap. 5.
- **Decisión D019 (13/10/2026):** ¿Cómo se escriben en la NEG el peso del gasto en manufacturas y el margen? μ para el peso de las manufacturas (Krugman 1991, FKV) y el margen como σ/(σ−1) sin símbolo; utilidad U = X^{1−μ}V^{μ}
- **Decisión D041 (13/10/2026):** ¿Se mantiene un solo id para la familia de la nueva geografía económica? Sí: `centro-periferia` con un apartado «familia NEG»; la hipótesis de especialización de Krugman (1993) va en `areas-monetarias-optimas`

## Presentación de referencia
**Pregunta:** ¿por qué y cuándo la industria se concentra en unas regiones dejando a otras como periferia, sin diferencias exógenas entre ellas?

**Supuestos:** dos regiones A y B; agricultura (bien $X$ homogéneo, rendimientos constantes, trabajadores inmóviles, proporción $1-\mu$ repartida a partes iguales, sin costes de transporte, numerario); manufacturas (variedades Dixit-Stiglitz, coste $w_i(F + cq)$, trabajadores móviles, proporción $\mu$; $\lambda_i$ = cuota de la región $i$); costes iceberg $\tau > 1$.

**Ecuaciones (notación canónica):**
$$U = X^{1-\mu}\,V^{\mu}, \qquad V = \Big[\sum_{k=1}^{n} x_k^{\rho}\Big]^{1/\rho},\quad \rho=\frac{\sigma-1}{\sigma}, \quad \sigma > 1$$
$$p_{ii} = \frac{\sigma}{\sigma-1}\,c\,w_i, \qquad p_{ij} = \tau\,p_{ii}, \qquad q^* = \frac{F(\sigma-1)}{c}, \qquad n_i = \frac{\lambda_i\,\mu}{\sigma F}$$
$$\omega_i = \frac{w_i}{P_X^{1-\mu}P_i^{\mu}}, \qquad \dot\lambda_A = \omega_A(\lambda_A) - \omega_B(\lambda_A)$$
**Resultado:** fuerzas de aglomeración (efecto mercado doméstico, vínculo de coste de vida) frente a dispersión (competencia, demanda agrícola inmóvil); con costes de transporte bajos el equilibrio estable es centro-periferia, con altos el simétrico; puntos de ruptura y de sostenibilidad e histéresis.

**Gráfico de referencia:** diagrama *tomahawk*: $\lambda_A$ en ordenadas frente a $\tau$ (o a la libertad comercial $\phi_\tau = \tau^{1-\sigma}$) en abscisas, con equilibrios estables (trazo continuo) e inestables (discontinuo), puntos de ruptura $\phi_\tau^{\mathrm r}$ y de sostenibilidad $\phi_\tau^{\mathrm s}<\phi_\tau^{\mathrm r}$. **`.tex` de referencia: `oposicion/temario/fuentes/3B06/graficos/tomahawk.tex`** (3.B.6); copiado sin cambios en `fuentes/3B10/graficos/tomahawk.tex` (11/11/2026); el 3.B.16 ya no lo usa (resumen del resultado, sin anexo, 12/11/2026).

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.B.6 | Nueva teoría del comercio | desarrollo | Modelo completo y tomahawk | — |
| 3.B.9 | Comercio y crecimiento | resumen | Resultado y variante dinámica: geografía y crecimiento (Baldwin y Martin; Martin y Ottaviano, 1999) — integración → aglomeración → divergencia de rentas | Las ecuaciones (copia literal hoy) |
| 3.B.10 | Integración económica | resumen (revisado en el otro *worktree*: II.1 `sec:centro-periferia`, *tomahawk* copiado) | Integración profunda reduce $\tau$ (sube $\phi_\tau$) y puede concentrar la actividad | Las ecuaciones |
| 3.B.16 | Integración monetaria | resumen del resultado (hecho, 11/11/2026) | Solo el argumento de especialización (Krugman, 1993) frente a la endogeneidad de Frankel-Rose, con a)-c) en II.2.1 (fuerzas de aglomeración y dispersión de palabra, `\vertema{3.B.6}`); resumen del resultado, sin anexo (12/11/2026) | Las ecuaciones y la tabla de mecanismos |
| 3.B.35 | Regionalismo / integración regional | resumen | Efectos de la integración en la localización | — |
| 3.B.40 | Política regional de la UE | resumen aplicado | Justificación de la política regional: fuerzas centrípetas y centrífugas, Venables (1996) | Derivación |
| 4.A.12, 4.A.17 | Industria y regiones de España | mención / resumen | Fuerzas de aglomeración frente a dispersión; 4.A.12 trata **primera naturaleza** (orografía, recursos), que no es este modelo | — |
| 3.A.18 | Competencia monopolística | mención (hecho, 19/10/2026) | Dixit-Stiglitz es la base del modelo centro-periferia de la nueva geografía económica (Krugman, 1991), con `\vertema{3.B.6}` | El modelo |

## Divergencias encontradas en el temario actual
- **Copia literal** del bloque completo (siete ecuaciones y el tomahawk) en 3.B.6, 3.B.9 y 3.B.10, y versión reducida pero propia en 3.B.16 y 3.B.40. **3.B.16 resuelto (11/11/2026):** sin ecuaciones; resumen del resultado, sin anexo (12/11/2026). **3.B.10:** la ficha decía «mención» y `mapa.yaml`, «resumen»; el 3.B.10 revisado (otro *worktree*) lo cuenta en II.1 `sec:centro-periferia` con el *tomahawk* copiado: «resumen» en las 2 (unificado el 11/11/2026).
- **Fusión de ids** (`krugman-centro-periferia`, `nueva-geografia-economica` → `centro-periferia`): correcta para el modelo de Krugman (1991), que es la presentación canónica de la NEG en el temario, pero **no del todo** para (i) la hipótesis de especialización de Krugman (1993) que usa 3.B.16 (es un argumento de AMO; va en `areas-monetarias-optimas`), (ii) las determinantes de primera naturaleza de 4.A.12 y (iii) los vínculos verticales de Venables (1996) y Fujita-Krugman-Venables de 3.B.40/4.A.17. Canon: un solo id con un apartado «familia NEG» en la ficha, sin fichas nuevas; la hipótesis de especialización de Krugman (1993) va en `areas-monetarias-optimas`.
- La utilidad del inventario se escribe $u = X^{\alpha}[\dots]$ mientras el gasto en manufacturas es $\gamma$: canon $U = X^{1-\mu}V^{\mu}$ (D019). **Corregido en esta ficha el 11/11/2026** (fase canon del 3.B.16, CC2): sus «Ecuaciones (notación canónica)» y supuestos usaban todavía γ contra D019 y el 3.B.6 revisado; ahora μ, con el agregador y $n_i$ como en el anexo del 3.B.6.
- Choques de símbolos: $\gamma$ (peso de manufacturas) frente a $\gamma$ tasa de variación en macro abierta; $\mu$ markup aquí frente a $\mu$ peso de manufacturas en Krugman (1991) y FKV. Canon (`_notacion/comercio.md`): $\mu$ = peso de las manufacturas (Krugman 1991, FKV) y el margen escrito $\sigma/(\sigma-1)$, sin símbolo; utilidad $U=X^{1-\mu}V^{\mu}$.
- La libertad comercial se escribe $\zeta$ en 3.B.6; canon $\phi_\tau = \tau^{1-\sigma}$ (Baldwin et al.) o $\zeta$, pero uno solo.

Autor: Víctor Gutiérrez Marcos
