# Modelo de información imperfecta de Lucas (1972, 1973): islas de Phelps y curva de oferta de Lucas

- **Área:** pensamiento · **Tema de referencia:** **3.A.6** (La nueva macroeconomía clásica; revisado el 4/11/2026: II.2.1 `sec:oferta-lucas` y II.2.2 `sec:inefectividad`, con a)-e), y el anexo A `anexo:lucas` paso a paso) — es el modelo fundacional de la NMC y combina expectativas racionales con neutralidad del dinero anticipado.
- **Temas que lo usan:** 3.A.6 (desarrollo; hecho, 4/11/2026), 3.A.37 (resumen; hecho, 5/11/2026: I.1, $y_t=y^n+\psi(p_t-p^e_t)$ en una línea con `\vertema{3.A.6}`, Lucas, 1973, sobre la varianza y Ball, Mankiw y Romer, 1988, sobre el nivel; anexo A con ω coeficiente de proyección, $p_{i,t}=p_t+z_{i,t}$ y las cifras de BMR, −1,639 y −0,322), 3.A.41 (mención; hecho, 5/11/2026: I.2.1, $\omega$ coeficiente de proyección, Lucas, 1973, sobre la varianza y Ball, Mankiw y Romer, 1988, sobre el nivel; Phelps, 1970, en nota; el modelo con $\omega$, $\psi$, $\varepsilon_S$, $y^n$ en el anexo E, sin gráfico), 3.A.42 (resumen; hecho, 4/11/2026: II.2.1, el primer ciclo nominal microfundamentado, $y_t=y^n+\psi(p_t-p^e_t)$ con `\vertema{3.A.6}`, las islas de Phelps, 1970, en nota; «su crisis» y la fila «Monetario» de `tab:teorias-ciclo`). También 3.A.5 (mención; hecho, 3/11/2026: II.2.2 y III.2: con las racionales, Lucas (1972) llega a una conclusión aún más dura contra la estabilización, `\vertema{3.A.6}`); 3.A.7 (mención; hecho, 4/11/2026: contextualización y I.3, en la NMC solo la política no anticipada mueve la producción, Lucas, 1972; en la NEK, también la anticipada); 3.A.28 (mención; hecho, 31/10/2026: II.3, la curva de oferta de Lucas). También 3.A.36 (mención; hecho, 4/11/2026: I.1.2, «islas de Lucas (1972), sobre la idea de Phelps (1970)», nunca «modelo de Lucas-Phelps» ni «islas de Phelps», como decía el Word; solo la parte no anticipada mueve la producción, `\vertema{3.A.6}`); 3.B.17 (mención; hecho, 12/11/2026: la oferta de Lucas con pendiente 1 y perturbación $u$, $Y=Y^n+(\pi-\pi^e)+u$, en niveles y en mayúscula, como restricción de la 2.ª generación, `\vertema{3.A.6}`).
- **Manuales de referencia:** Lucas (1972), «Expectations and **the** Neutrality of Money», *JET* 4 (`Lucas1972Expectations`); Lucas (1973), *AER* 63 (`Lucas1973Some`); Phelps (1970) (`Phelps1970Microeconomic`); Ball, Mankiw y Romer (1988), *BPEA* (`BallMankiwRomer1988`); Romer (2019), cap. 6; Attfield, Demery y Duck (1991); Blanchard y Fischer (1989), cap. 7; Heijdra (2017), cap. 5; De Vroey (2016), cap. 9.
- **Decisión D036 (13/10/2026):** ω = σ²_z/(σ²_z+σ²_p) y ψ ≡ ω·ε_S en la curva de oferta de Lucas. En el modelo de islas, **y^n sin subíndice** (constante), como U^n; y^n_t solo donde varía (NEK).

## Presentación de referencia (3.A.6, II.2.1-II.2.2 y anexo A)

**Pregunta:** ¿por qué el dinero mueve la producción a corto plazo si los agentes son racionales y los mercados se vacían? Respuesta: porque los productores confunden una subida de su precio *relativo* con una del nivel *general*. Da fundamento a la curva aumentada de Friedman y Phelps (`\vertema{3.A.5}`) sin errores sistemáticos. Versión simplificada de los manuales (el original es un modelo de generaciones solapadas, `\vertema{3.A.29}`, en nota).

**Supuestos:** islas de Phelps; cada productor ve $p_{i,t}$ pero no $p_t$; variables en logaritmos; **2 perturbaciones normales e independientes**: $p_{i,t}=p_t+z_{i,t}$, con $z_{i,t}$ real de media nula y varianza $\sigma^2_z$ (ante ella lo óptimo es producir más) y $p_t$ con media $p^e_t\equiv\mathbb{E}_{t-1}[p_t]$ y varianza $\sigma^2_p$ (la mueve el dinero); oferta de la isla $y_{i,t}=y^n+\varepsilon_S\,\mathbb{E}[z_{i,t}\mid p_{i,t}]$, con ε_S > 0 que viene de la oferta de trabajo intertemporal (`lucas-rapping`); **demanda agregada cuantitativa** con la velocidad normalizada, $y_t=m_t-p_t$ (`\vertema{3.A.35}`); expectativas racionales (`eq:her`, ficha `expectativas-racionales`).

**Ecuaciones:** extracción de señales (`eq:extraccion`)

$$\mathbb{E}[z_{i,t} \mid p_{i,t}] = \omega\,(p_{i,t} - p^e_t),\qquad \omega = \frac{\sigma^2_z}{\sigma^2_z + \sigma^2_p}\in[0,1]$$

(ω es la parte de la varianza del precio de la isla que se debe a las perturbaciones reales, un **coeficiente de proyección**, $\mathrm{Cov}/\mathrm{Var}$; **no es una probabilidad**). Agregando, la **curva de oferta de Lucas** (`\funcionclave` `eq:oferta-lucas`):

$$y_t = y^n + \psi\,(p_t - p^e_t),\qquad \psi = \omega\,\varepsilon_S,\quad \omega=\frac{\sigma^2_z}{\sigma^2_z+\sigma^2_p}$$

No hay efecto real si σ²_z = 0, ε_S = 0 o p_t = p^e_t. **Equilibrio** con la demanda (`\funcionclave` `eq:produccion-lucas` y `eq:precios-lucas`):

$$y_t = y^n + \frac{\psi}{1+\psi}\left(m_t-\mathbb{E}_{t-1}[m_t]\right),\qquad p_t = \mathbb{E}_{t-1}[m_t]-y^n+\frac{1}{1+\psi}\left(m_t-\mathbb{E}_{t-1}[m_t]\right)$$

La parte prevista del dinero va entera a los precios; la sorpresa se reparte. La varianza de los precios es endógena, $\sigma^2_p=\sigma^2_\varepsilon/(1+\psi)^2$: cuanto más errático el dinero, menor ω y menor ψ.

**Implicaciones:** la pendiente depende de la política (semilla de la crítica, `critica-lucas`); con la ley de Okun, la oferta de Lucas es la **curva de Phillips con expectativas racionales**, $U_t=U^n-\alpha(\pi_t-\pi^e_t)$ (`\vertema{3.A.28}`; α = 1/a, `notacion.md` § 8), casi vertical con inflación errática (`\vertema{3.A.41}`); los efectos duran un periodo (sin persistencia, salvo capital: Lucas, 1975). Base de la proposición de inefectividad (`sargent-wallace-inefectividad`). **Evidencia** (en la crítica de Lucas del 3.A.6, A06-09): Lucas (1973), 18 países, 1952-1967: donde la demanda nominal es más **volátil** (importa la varianza, no el nivel de la inflación), su efecto real es menor; Ball, Mankiw y Romer (1988), 43 países, 1948-1986: −1,639 con la volatilidad sola, pero con la inflación media la volatilidad deja de ser significativa (lo que predice la NEK, `\vertema{3.A.7}`). **Valoración**: el vaciado continuo deja fuera el paro involuntario; la información imperfecta es poco creíble con el IPC y los agregados mensuales; necesita una oferta muy elástica; no genera persistencia.

**Gráfico de referencia:** `oposicion/temario/fuentes/3A06/graficos/oferta-lucas.tex` (antes «no imprescindible»; ahora es **el gráfico de la inefectividad** en el cante, CC5): plano (y, p), vertical en y^n, oferta de Lucas con pendiente 1/ψ que la corta en p = p^e, demanda y = m − p; por capas: expansión **no anticipada** (solo se desplaza la demanda: suben y y p) y **anticipada** (se desplazan la demanda y la oferta, porque sube p^e: solo sube p). En la pizarra, `eq:oferta-lucas` recuadrada y conservada hasta el final del bloque II.

## Cómo se adapta en cada tema

| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.6 | La NMC | desarrollo (hecho, 4/11/2026) | Supuestos, extracción de señales, curva de oferta, demanda y equilibrio, gráfico `oferta-lucas`, implicaciones y valoración; la evidencia de Lucas (1973) y BMR (1988), en la crítica de Lucas; la derivación en el anexo A | — |
| 3.A.37 | Transmisión monetaria | resumen (hecho, 5/11/2026) | I.1: solo la parte no anticipada transmite; `eq:produccion-lucas` en una línea con ψ, $y^n$ y $p^e_t$ y `\vertema{3.A.6}`; la pendiente con Lucas (1973) y Ball, Mankiw y Romer (1988); anexo A con ω, «no una probabilidad» | La extracción de señales |
| 3.A.41 | Inflación | mención (hecho, 5/11/2026) | Inflación volátil → menor efecto real de la política; coste informativo de la inflación (confusión de precios relativos, II.1.1); el resumen del modelo en el anexo E con la notación del 3.A.6 | El modelo en el cuerpo |
| 3.A.42 | Ciclos nominales y reales | resumen (hecho, 4/11/2026) | El primer ciclo nominal de equilibrio (Lucas, 1972) con `eq:oferta-lucas` en una línea; por qué cayó (los precios se conocen pronto; recesiones largas; la política anticipada también parecía importar); Romer y Romer (1989) y los VAR | La derivación y la extracción de señales |
| 3.A.5 | Síntesis y monetarismo | mención (hecho, 3/11/2026) | La puerta de la nueva macroeconomía clásica tras la curva aumentada (Lucas, 1972), con `\vertema{3.A.6}` | El modelo |
| 3.A.7 | NEK | mención (hecho, 4/11/2026) | Solo lo no anticipado mueve la producción en la NMC (Lucas, 1972); en la NEK, perturbaciones anticipadas o no, porque los precios se fijaron antes; `\vertema{3.A.6}` | El modelo |
| 3.A.28 | Paro y Phillips | mención (hecho, 31/10/2026) | La curva de oferta de Lucas (1972) como Phillips con expectativas racionales | El modelo |
| 3.A.36 | Diseño: objetivos reales | mención (hecho, 4/11/2026) | I.1.2: Lucas (1972), sobre la idea de las islas de Phelps (1970); solo la política no anticipada mueve la producción; `\vertema{3.A.6}` | El modelo |
| 3.B.17 | Crisis de 2.ª generación | mención (hecho, 12/11/2026) | $Y=Y^n+(\pi-\pi^e)+u$ (pendiente normalizada a 1; $Y^n$ e $Y^{\mathrm{obj}}$ en mayúscula, no en logaritmos) como restricción del gobierno; `\vertema{3.A.6}` | El modelo |

## Divergencias encontradas en el temario actual

- **3.A.6 (Word)**: θ como «probabilidad de que el shock sea real», con σ²_{p_i} en el numerador; β como respuesta de la producción; y_TNP; E[·]; demanda en una línea y equilibrio vacío; «economía habituada a niveles altos de inflación»; BMR «obteniendo igualmente» el resultado de Lucas. **Resuelto** (4/11/2026): ω, ψ, y^n, 𝔼, `eq:produccion-lucas`, la varianza y BMR bien contados.
- **3.A.41 resuelto** (5/11/2026): ω (no θ «probabilidad», ni $\sigma^2_{p_i}$ en el numerador), ψ, $y^n$; la dependencia de las varianzas, de Lucas (1973), no de Ball, Mankiw y Romer (1988), que la relacionan con el nivel. **3.A.37 resuelto** (hecho, 5/11/2026): ω «coeficiente de proyección, no una probabilidad», ψ, $y^n$ y $p^e_t$ en I.1 y el anexo A; las varianzas de Lucas (1973) y el nivel de Ball, Mankiw y Romer (1988); `\vertema{3.A.6}`.
- **Esta ficha** escribía E[·] y E_{t−1} y no tenía la demanda ni el equilibrio: **corregida** (CC5 del 3.A.6).

Autor: Víctor Gutiérrez Marcos
