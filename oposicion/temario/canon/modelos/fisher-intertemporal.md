# Elección intertemporal de Fisher (dos periodos)

- **Área:** macro cerrada · **Tema de referencia:** **3.A.33** (revisado el 31/10/2026: I.2.1 `sec:fisher` con β(1+r) = 1; r ≠ ρ, CRRA y efectos del tipo de interés en II.3 `sec:r-rho`; liquidez en `sec:liquidez`; T periodos y Slutsky con dotación en el anexo B `anexo:optimizacion`) — es la base microeconómica de ciclo vital y renta permanente.
- **Temas que lo usan:** 3.A.33 (desarrollo; hecho, 31/10/2026), 3.A.29 (desarrollo → resumen), 4.B.9 (desarrollo: impuestos y ahorro), 4.B.10 (desarrollo: impuestos), 3.A.25 (mención; hecho, 31/10/2026: la restricción intertemporal de Lucas-Rapping y la separación de Fisher en la decisión de educarse, caja de III.2 con `fisher-capital-humano.tex`)
- **Manuales de referencia:** Fisher, *The Theory of Interest* (1930); Romer (2019), cap. 8; Heijdra (2017); Mas-Colell, Whinston y Green (1995), cap. 20; Rosen y Gayer (imposición del ahorro).
- **Decisión D001 (13/10/2026):** ¿Qué letra lleva el coeficiente de aversión relativa al riesgo (CRRA) de u(c)=c^{1−θ}/(1−θ), y cómo se escribe la elasticidad de sustitución intertemporal? θ para la CRRA en todo el temario y la ESI como 1/θ, sin símbolo propio; σ queda para la elasticidad de sustitución intratemporal (CES, Dixit-Stiglitz) y la desviación típica
- **Decisión D099 (13/10/2026):** ¿Dónde se desarrolla el modelo de Fisher con impuestos (consumo-ahorro)? En 4.B.10 (efectos incentivo sobre el ahorro); 4.B.9 lo resume

## Presentación de referencia
Pregunta: ¿cómo reparte un hogar el consumo entre hoy y mañana? Supuestos: dos periodos; rentas Y_1, Y_2; mercado de capitales perfecto (presta y pide prestado al tipo real r); preferencias U(C_1, C_2) = u(C_1) + β u(C_2), con β ≡ 1/(1+ρ).

$$\max\; u(C_1) + \beta\,u(C_2)\quad\text{s.a.}\quad C_1 + \frac{C_2}{1+r} = Y_1 + \frac{Y_2}{1+r}$$
$$u'(C_1) = \beta\,(1+r)\,u'(C_2) = \frac{1+r}{1+\rho}\,u'(C_2)\quad(\text{ecuación de Euler})$$
Con CRRA, u(C) = C^{1−θ}/(1−θ): $\;C_2/C_1 = [(1+r)/(1+\rho)]^{1/\theta}$, y 1/θ es la elasticidad de sustitución intertemporal.
Resultado: el consumo depende de la riqueza (valor actual de las rentas), no de la renta corriente; un cambio de r tiene efecto sustitución (más ahorro) y efecto renta (de signo opuesto si el hogar es prestamista).
Gráfico de referencia: plano (C_1, C_2); restricción presupuestaria con pendiente −(1+r) que pasa por el punto de dotación (Y_1, Y_2); curva de indiferencia tangente; un aumento de r gira la recta sobre el punto de dotación (prestamista frente a prestatario).

**Cómo lo cuenta el 3.A.33 (presentación de referencia aplicada, 31/10/2026; DC2/A33-02, desdoble de Víctor, **[decidir]**):**
- **I.2.1** (a)-d)): 3 piezas (comportamiento, preferencias, restricción); U(C_1,C_2) = u(C_1) + βu(C_2) con descuento exponencial de Samuelson (1937) (`\vertema{3.A.29}`); problema `eq:fisher` con `\optim` y la riqueza **W̄ ≡ Y_1 + Y_2/(1+r)** en la restricción; Euler `\funcionclave` `eq:euler`, **u′(C_1) = β(1+r)u′(C_2)** (nota de la braquistócrona con `\graficonota{braquistocrona}`); interpretación analítica y gráfica; **caso de referencia β(1+r) = 1**: C_1 = C_2 = [(1+r)/(2+r)]W̄; nota de la **separación de Fisher** (Fisher, 1930; Hirshleifer, 1958) con `\vertema{3.A.34}` y `\vertema{3.A.25}`; T periodos en el anexo B (ficha `optimizacion-dinamica`).
- **II.3, pieza 2** (`sec:r-rho`): CRRA u(C) = (C^{1−θ} − 1)/(1 − θ) (la `eq:crra` del 3.A.8, con el −1); C_2/C_1 = [β(1+r)]^{1/θ}, ln(C_2/C_1) ≃ (r − ρ)/θ; subida de r: **3 efectos** sobre C_1 (sustitución −, renta +, riqueza −), renta y riqueza juntos con el signo del ahorro; ESI baja en los datos (Hall, 1988). Slutsky con dotación (`eq:slutsky-dotacion`, p ≡ 1/(1+r)) en el anexo B.
- **II.3, pieza 3** (`sec:liquidez`): la recta se quiebra en A (ficha `restricciones-liquidez`).
- **Gráficos de referencia** (`oposicion/temario/fuentes/3A33/graficos/`): `fisher.tex` (**imprescindible**: (C_1, C_2), recta de pendiente −(1+r) por la **dotación A = (Y_1, Y_2)**, óptimo **C** en la tangencia, con r = ρ en la bisectriz), `fisher-tipo-interes.tex` (giro sobre A) y `fisher-liquidez.tex` (recta quebrada en A). El gráfico se queda en la pizarra desde I.2.1 hasta el final de II. El 3.A.25 tiene `fisher-capital-humano.tex` con los mismos ejes y letras. Nota: el óptimo se rotula C (no E como proponía K32): letra de punto, no choca con el consumo porque los ejes son C_1 y C_2.

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.33 | Microfundamentos del consumo | desarrollo (hecho, 31/10/2026) | Desdoblado: I.2.1 con β(1+r) = 1 y la separación en nota; r ≠ ρ, CRRA y 3 efectos en II.3; liquidez en II.3; T periodos y Slutsky con dotación en el anexo B | — |
| 3.A.29 | Modelización dinámica | resumen | Euler como piedra angular; generalización a T periodos y a horizonte infinito (anexo común, ficha `optimizacion-dinamica`); C_t, r y ESI = 1/θ | La derivación gráfica (`\vertema{3.A.33}`) |
| 4.B.9 | Imposición y ahorro | desarrollo (aplicación) | Mismo gráfico con impuestos de suma fija (traslación), sobre el consumo y sobre los intereses (giro: r(1−t_r)) | La derivación básica |
| 3.A.25 | Capital humano y oferta intertemporal | mención (hecho, 31/10/2026) | La restricción $C_1+C_2/(1+r)=w_1L_1+w_2L_2/(1+r)$ y la Euler $C_2/C_1=\beta(1+r)$ en Lucas-Rapping; en la caja de Becker, frontera cóncava de rentas $(y_1,y_2)$ y curvas de indiferencia $(C_1,C_2)$: con mercado de capitales perfecto, **teorema de separación de Fisher** (Fisher, 1930; Hirshleifer, 1958), que Acemoglu y Autor (2011) aplican al capital humano; gráfico `fuentes/3A25/graficos/fisher-capital-humano.tex` con los mismos ejes y letras; remite a 3.A.33 | El modelo de consumo |
| 4.B.10 | Efectos de los impuestos | desarrollo (aplicación) | Igual que 4.B.9 con ahorro privado, público y nacional; giro en el punto de ahorro nulo | Idem; coordinar con 4.B.9 para no duplicar |

## Divergencias encontradas en el temario actual
- 3.A.33 original: c_t en Fisher y C_t en Hall, σ como ESI, «r > ρ ⇒ oferente de ahorro», Slutsky con dotación solo en una nota de Víctor. **Resuelto** (31/10/2026): C_1, C_2, Y_1, Y_2, r, β, W̄; ESI = 1/θ; el signo del crecimiento no dice si el hogar presta.
- 3.A.33 (revisado): en el anexo B la demanda compensada se escribe C_1^h; el canon (§ 0) pide la hicksiana con su letra y argumentos, como el 3.A.25 (h_O(w,Ū)): h_{C_1}(p,Ū) y C_1(p,W̄) (`pendientes-coherencia.md`, sección del 3.A.33; menor).
- Desarrollado en cuatro temas con notaciones distintas: c_t, r_t (3.A.29); C_1, C_2, r (4.B.9, 4.B.10). Propuesta: **C_1, C_2, r** en el modelo de dos periodos; C_t en la generalización.
- 3.A.29 llama σ a la ESI («ESI ≡ σ = 1/θ»): canon **1/θ** sin símbolo propio (σ queda para la elasticidad de sustitución intratemporal).
- 3.A.29 (sin revisar): llama «teorema de la separación de Acemoğlu y Autor» a la separación de Fisher en la decisión de capital humano (epígrafe «… (Becker, 1962)»): es Fisher (1930); remitir al 3.A.25 para Becker (`mapa.yaml`, contradicciones del 3.A.25). El 3.A.25 lo corrigió en su original (31/10/2026).
- 4.B.9 y 4.B.10 desarrollan el mismo bloque casi igual: el desarrollo (efectos incentivo sobre el ahorro) va en 4.B.10 y 4.B.9 lo resume.

Autor: Víctor Gutiérrez Marcos
