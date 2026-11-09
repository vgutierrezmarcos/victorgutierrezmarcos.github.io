# Gasto público productivo y crecimiento endógeno (Barro 1990)

- **Área:** macro cerrada · **Tema de referencia:** 3.A.38 (política fiscal: efectos sobre el crecimiento y el ahorro), escrito con ecuaciones: los efectos de la política fiscal sobre el crecimiento son su título. **Hecho el 5/11/2026**: III.1 `sec:barro` con a)-d) y el anexo F `anexo:barro` (el máximo y la versión con ahorro constante), con la presentación con optimización (D050) que fijó el **3.A.44** (I.2.3, `sec:barro`, y anexo A, `anexo:ak-barro`; revisado el 1/11/2026; allí, resumen como «un $AK$ fabricado con gasto público»): mismas palabras y etiquetas (`eq:barro`, `eq:barro-tau`, `fig:barro`).
- **Temas que lo usan:** 3.A.38 (desarrollo; hecho, 5/11/2026), 3.A.44 (resumen; hecho, 1/11/2026), 4.B.1 (mención), 4.B.5 (resumen), 4.A.11 (mención), 3.A.43 (mención; hecho, 31/10/2026: II.2 «Hacia el crecimiento endógeno», el gasto público productivo hace que el capital privado no tenga rendimientos decrecientes, `\vertema{3.A.38}`)
- **Manuales de referencia:** Barro (1990), *JPE*; Barro y Sala-i-Martin, *Economic Growth* (2.ª ed., 2004), cap. 4 (sec. 4.4); Sala-i-Martín, *Apuntes de crecimiento económico* (2.ª ed., 2000), cap. 3; Barro y Sala-i-Martin (1992), *REStud* (congestión).
- **Decisión D050 (13/10/2026):** ¿Qué versión de Barro (1990) es la de referencia? La de optimización (θ, ρ), como AK y Uzawa-Lucas; la de ahorro exógeno solo como simplificación
- **Decisión D053 (13/10/2026):** ¿Cuál es el tema de referencia de Barro (1990)? 3.A.38 (efectos de la política fiscal sobre el crecimiento), escribiéndolo con ecuaciones

## Presentación de referencia (versión con optimización; escrita en el 3.A.44, I.2.3 y anexo A)
**Pregunta:** ¿puede el gasto público productivo generar crecimiento sostenido y qué tamaño del Estado lo maximiza? Dilema: el gasto productivo hace más productivo el capital privado, pero se financia con impuestos que reducen el rendimiento de invertir.

**Supuestos:** $Y_t=A\,K_t^{\alpha}G_t^{1-\alpha}$ (rendimientos constantes en K y G juntos, decrecientes en cada uno), **población constante normalizada a 1** (los agregados son también por trabajador; A44-04; en la versión con ahorro constante puede llevar $n$), $G$ un **flujo** de servicios públicos que todas las empresas usan a la vez y toman como dado; impuesto proporcional sobre la renta τ con presupuesto equilibrado $G_t=\tau Y_t$ (`\vertema{3.A.39}`); hogares de Ramsey con CRRA (θ) y descuento ρ.

$$G = \tau Y\;\Rightarrow\;Y = A^{1/\alpha}\,\tau^{(1-\alpha)/\alpha}\,K\quad(\text{modelo }AK)$$
$$r=(1-\tau)\,\alpha\,A^{1/\alpha}\tau^{(1-\alpha)/\alpha}-\delta,\qquad \gamma=\frac{1}{\theta}\left[(1-\tau)\,\alpha\,A^{1/\alpha}\,\tau^{(1-\alpha)/\alpha} - \delta - \rho\right]\quad(\texttt{eq:barro})$$
$$\tau^*=\frac{G}{Y}=1-\alpha\quad(\texttt{eq:barro-tau};\ \text{regla de Barro: }\partial Y/\partial G=(1-\alpha)Y/G=1)$$
con la comprobación de que es un máximo (anexo A del 3.A.44): el tipo óptimo es la elasticidad de la producción al gasto público.

**Implicaciones:** 2 efectos del impuesto (τ^{(1−α)/α} positivo, (1 − τ) negativo) y **U invertida** de γ en τ; la composición del gasto importa; **el equilibrio no es óptimo**: el hogar recibe la fracción α del rendimiento social; el planificador crece a $\gamma^{\mathrm P}=[\alpha A^{1/\alpha}(1-\alpha)^{(1-\alpha)/\alpha}-\delta-\rho]/\theta$; con un impuesto de suma fija se alcanzaría el óptimo (Barro y Sala-i-Martin, 2004, sec. 4.4). Matices: reformas de oferta; efectos mayores a largo que a corto plazo (Baxter y King, 1993).

**Extensiones:** congestión (Barro y Sala-i-Martin, 1992); capital público acumulable con dinámica de transición; «en puridad, un modelo de desbordamientos» (nota del 3.A.44: la inversión pública eleva la productividad de todas las empresas, como el conocimiento en `arrow-romer-spillovers`).

**Evidencia:** Aschauer (1989), elasticidad ≈ 0,4; metaanálisis de Bom y Ligthart (2014): 0,083 a corto y 0,122 a largo plazo para el capital público de la Administración central, casi el doble en infraestructuras básicas regionales y locales.

**Versión simplificada à la Solow** (tasa de ahorro s exógena, solo como simplificación y diciéndolo; anexo A del 3.A.44): $\gamma = s(1-\tau)A^{1/\alpha}\tau^{(1-\alpha)/\alpha} - \delta$ (con población a n, $-(n+\delta)$), con el mismo τ*.

**Gráfico de referencia:** γ frente a τ, en U invertida con máximo en τ* = 1 − α: `oposicion/temario/fuentes/3A44/graficos/barro.tex` (a partir de Barro, 1990, y Sala-i-Martín, 2000). En el cante del 3.A.44, a mano alzada en una esquina (15″). Fila de `tab:resumen-modelos` del 3.A.44 con $r=(1-\tau)\alpha A^{1/\alpha}\tau^{(1-\alpha)/\alpha}-\delta$.

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.38 | Efectos de la política fiscal sobre el crecimiento | desarrollo (hecho, 5/11/2026; 5′30″ en el cante) | III.1 con la versión de arriba: las 2 caras del Estado (con la nota de las partidas que la literatura considera productivas), `eq:barro-produccion` numerada, `eq:barro`, `eq:barro-tau` como función clave (A38-17), U invertida, regla ∂Y/∂G = 1, τ* = elasticidad; implicaciones (tamaño, composición, equilibrio < óptimo con γ^P y la suma fija, matices de las reformas de oferta); extensiones (congestión, capital público acumulable); valoración (filo de la navaja del $AK$, gasto homogéneo, elasticidad difícil de medir). **Lo que añade al 3.A.44**: el gasto como **flujo** frente al **stock** $K^G_t$ de Baxter y King (I.2 c), ficha `rbc-sims`), y III.2 con Rebelo (`eq:rebelo`, τ_K; ficha `ak`), la jerarquía de la OCDE, Aschauer, Bom y Ligthart, Kneller, Bleaney y Gemmell con las palabras del 3.A.45 y la inversión pública de España (`inversion-publica-espana`). Pegatina «ni contigo ni sin ti». La versión con ahorro constante, en el anexo F, sin llamar g al gasto por trabajador | — |
| 3.A.44 | Crecimiento endógeno: un AK con gasto público | resumen (hecho, 1/11/2026; 1′ en el cante) | I.2.3 con a)-e): ecuación de γ, τ* = 1 − α, regla ∂Y/∂G = 1, equilibrio < óptimo, Bom y Ligthart; la versión con s exógena en el anexo A; `\vertema{3.A.38}` | La discusión de política fiscal `\vertema{3.A.38}` |
| 4.B.1 | Tamaño óptimo del gasto público | mención | τ* = 1−α y la regla ∂Y/∂G = 1 | Derivación completa; remitir |
| 4.B.5 | Tamaño óptimo del sector público | resumen | Igual que 4.B.1, con lo imprescindible para cantarse sin el 3.A.38 | Idem |
| 4.A.11 | Obra civil | mención | Efecto de oferta del gasto en infraestructuras | — |
| 3.A.43 | Puente al crecimiento endógeno | mención (hecho, 31/10/2026) | Una viñeta junto al AK y Sobelow | El modelo `\vertema{3.A.38}` |

## Divergencias encontradas en el temario actual
- 3.A.44 (Word): versión con ahorro exógeno y $g=G/L$, figura con «Sala i Martín (1999)», «Baxter y King» sin año. **Resuelto** (1/11/2026): versión de referencia con optimización y la de s exógena en el anexo A.
- **3.A.38 resuelto (5/11/2026):** su Word tenía ecuaciones con ahorro exógeno $s$ y $g=G/L$ (CC8 del 3.A.44) y «Sala i Martín (1999)»; ahora la versión con optimización (D050), $G$ en niveles, la de s exógena en el anexo F diciendo que es una simplificación y Sala-i-Martín (2000), 2.ª ed.
- **Gráfico**: `barro.tex` copiado sin cambios del 3.A.44 al 3.A.38 (`fuentes/3A38/graficos/barro.tex`); si cambia, copiarlo otra vez.
- **Clave de Baxter y King (1993)**: el 3.A.44 cita `BaxterKing1993` (l. 402) y el 3.A.38, el 3.A.6, el 3.A.39, el 3.A.40 y el 3.A.42, `BaxterKing1993Fiscal` (`pendientes-coherencia.md`, Pendiente del 3.A.38).
- 4.B.1 y 4.B.5 lo presentan con **ahorro exógeno s** y son copia literal entre sí (mismas ecuaciones y gráfico): resumir con la versión de referencia y no duplicar.
- g = gasto público por trabajador choca con g = progreso técnico (3.A.43): escribir **G** (con población normalizada) o G/L con definición explícita.

Autor: Víctor Gutiérrez Marcos
