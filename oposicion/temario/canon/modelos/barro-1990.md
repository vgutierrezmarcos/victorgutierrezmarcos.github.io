# Gasto público productivo y crecimiento endógeno (Barro 1990)

- **Área:** macro cerrada · **Tema de referencia:** 3.A.38 (política fiscal: efectos sobre el crecimiento y el ahorro), escrito con ecuaciones: los efectos de la política fiscal sobre el crecimiento son su título (sin revisar). Mientras tanto, la presentación con optimización (D050) ya está escrita en el **3.A.44** (I.2.3, `sec:barro`, y anexo A, `anexo:ak-barro`; revisado el 1/11/2026), que lo resume como «un $AK$ fabricado con gasto público»: el 3.A.38 debe partir de ella.
- **Temas que lo usan:** 3.A.38 (desarrollo; su Word ya tiene ecuaciones, pero con ahorro exógeno $s$ y $g=G/L$), 3.A.44 (resumen; hecho, 1/11/2026), 4.B.1 (mención), 4.B.5 (resumen), 4.A.11 (mención), 3.A.43 (mención; hecho, 31/10/2026: II.2 «Hacia el crecimiento endógeno», el gasto público productivo hace que el capital privado no tenga rendimientos decrecientes, `\vertema{3.A.38}`)
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
| 3.A.38 | Efectos de la política fiscal sobre el crecimiento | desarrollo | La versión de arriba (con optimización, G en niveles y población normalizada), U invertida, comparación con el óptimo, gasto productivo frente a improductivo, impuestos que distorsionan o no; la de ahorro exógeno de su Word, solo como simplificación | — |
| 3.A.44 | Crecimiento endógeno: un AK con gasto público | resumen (hecho, 1/11/2026; 1′ en el cante) | I.2.3 con a)-e): ecuación de γ, τ* = 1 − α, regla ∂Y/∂G = 1, equilibrio < óptimo, Bom y Ligthart; la versión con s exógena en el anexo A; `\vertema{3.A.38}` | La discusión de política fiscal `\vertema{3.A.38}` |
| 4.B.1 | Tamaño óptimo del gasto público | mención | τ* = 1−α y la regla ∂Y/∂G = 1 | Derivación completa; remitir |
| 4.B.5 | Tamaño óptimo del sector público | resumen | Igual que 4.B.1, con lo imprescindible para cantarse sin el 3.A.38 | Idem |
| 4.A.11 | Obra civil | mención | Efecto de oferta del gasto en infraestructuras | — |
| 3.A.43 | Puente al crecimiento endógeno | mención (hecho, 31/10/2026) | Una viñeta junto al AK y Sobelow | El modelo `\vertema{3.A.38}` |

## Divergencias encontradas en el temario actual
- 3.A.44 (Word): versión con ahorro exógeno y $g=G/L$, figura con «Sala i Martín (1999)», «Baxter y King» sin año. **Resuelto** (1/11/2026): versión de referencia con optimización y la de s exógena en el anexo A.
- **3.A.38 (sin revisar):** esta ficha decía «3.A.38 (desarrollo, sin ecuaciones)», pero su Word **sí** tiene ecuaciones, con ahorro exógeno $s$ y $g=G/L$ (CC8 del 3.A.44). Al revisarlo: versión con optimización (D050), $G$ en niveles (g es el progreso técnico, 3.A.43) y la de s exógena solo como simplificación, diciéndolo.
- 4.B.1 y 4.B.5 lo presentan con **ahorro exógeno s** y son copia literal entre sí (mismas ecuaciones y gráfico): resumir con la versión de referencia y no duplicar.
- g = gasto público por trabajador choca con g = progreso técnico (3.A.43): escribir **G** (con población normalizada) o G/L con definición explícita.

Autor: Víctor Gutiérrez Marcos
