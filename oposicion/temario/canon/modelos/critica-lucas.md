# Crítica de Lucas (1976)

- **Área:** pensamiento · **Tema de referencia:** **3.A.6** (La nueva macroeconomía clásica; revisado el 4/11/2026: II.2.3 `sec:critica-lucas`, tercer nivel con título propio y a)-e), **un solo sitio**; en I y en la contextualización, una línea con `\ref`) — está en el título.
- **Temas que lo usan:** 3.A.6 (desarrollo; hecho, 4/11/2026), 3.A.1 (mención; hecho, 4/11/2026: II.3.2, la crítica de Lucas, 1976, a los modelos macroeconométricos, `\vertema{3.A.6}`; II.3.4, la crítica como criterio de un buen modelo —parámetros estructurales— y el modelo como «economía artificial», Lucas, 1980; II.3.3, argumento a favor del realismo de los supuestos estructurales; III.3.5, el aprendizaje automático ante un cambio de política; anexo A, de palabra con el ejemplo del dinero en $t-1$, sin ecuaciones). 3.A.7 (mención; hecho, 4/11/2026: introducción, la crítica de Lucas, 1976, en la contextualización; II.1, los microfundamentos de la 2.ª generación como respuesta, porque los parámetros de preferencias y tecnología no cambian con la política; II.2, la IS dinámica es estructural y la crítica no la alcanza; `\vertema{3.A.6}`). 3.A.36 (mención; hecho, 4/11/2026: I.1.3 e), la crítica de Lucas lleva a la misma conclusión que Barro-Gordon por otro camino: evaluar reglas, no decisiones sueltas, `\vertema{3.A.6}`). 3.A.33 (mención; hecho, 31/10/2026: en las implicaciones de Hall, II.1, la Euler no depende de la política y se estima directamente, `\vertema{3.A.6}`). También 3.A.5 (mención; hecho, 3/11/2026: I.2 e), última crítica del IS-LM: estático y sin microfundamentos, sus parámetros cambian con la política; III.2, de las adaptativas a las racionales; `\vertema{3.A.6}`); 3.A.28 (mención; hecho, 31/10/2026: II.3, l. 376, la Phillips de los 60 no era un menú estable); 3.A.29 (mención; hecho, 1/11/2026: l. 39 y 407, el porqué del agente representativo); 3.A.4 (mención; hecho, 4/11/2026: l. 924, la crítica a los modelos de desequilibrio).
- **Manuales de referencia:** Lucas (1976), «Econometric Policy Evaluation: A Critique», *Carnegie-Rochester* 1 (`Lucas1976Econometric`); Lucas (1973) y Ball, Mankiw y Romer (1988) para la evidencia; Sims (1980), *Econometrica*; Leeper y Zha (2003); Favero y Hendry (1992); Lindé (2001); Rudebusch (2005); Chari, Kehoe y McGrattan (2009); Romer (2019), cap. 7; Heijdra (2017), cap. 5; De Vroey (2016), cap. 10.

## Presentación de referencia (3.A.6, II.2.3)

**Pregunta:** ¿se pueden usar modelos econométricos estimados con datos del pasado para evaluar cambios de política? Pegatina del 3.A.6: «otros tiempos, otras costumbres».

**Idea:** los grandes modelos macroeconométricos (herederos de Klein y Goldberger, 1955) se estimaban con datos de un régimen y se simulaban con otro manteniendo fijos los coeficientes; pero las reglas de decisión, y con ellas los coeficientes, dependen de la política que se espera.

**Supuestos:** 2 tipos de parámetros: **profundos o estructurales** (preferencias, tecnología, restricciones, varianzas de las perturbaciones reales), que no cambian con la política, y los de las **reglas de decisión** estimadas, que los mezclan con la regla de política a través de las expectativas; expectativas racionales y regla conocida.

**Ecuación de referencia** (CC7: el ejemplo sale del **propio modelo de islas**, ficha `lucas-islas`; sustituye a la ecuación ilustrativa anterior). Con `eq:produccion-lucas` y la regla $m_t=\mu+\rho_m m_{t-1}+\varepsilon_t$ ($\mathbb{E}_{t-1}[m_t]=\mu+\rho_mm_{t-1}$), la **forma reducida de 3 coeficientes** (`eq:forma-reducida`):

$$y_t=\underbrace{(y^n-\tilde\psi\mu)}_{\beta_0}+\underbrace{\tilde\psi}_{\beta_1}\,m_t\underbrace{-\tilde\psi\rho_m}_{\beta_2}\,m_{t-1},\qquad \tilde\psi\equiv\frac{\psi}{1+\psi}$$

Quien estime $y_t=\beta_0+\beta_1m_t+\beta_2m_{t-1}$ encuentra $\hat\beta_1>0$; pero si el banco central sube μ para explotarlo, β_0 cae lo justo y la producción no cambia; si cambia ρ_m, cambia β_2; si la política se vuelve más errática, baja ψ y cambia hasta β_1. Parámetros **profundos**: $y^n$, $\varepsilon_S$ y $\sigma^2_z$; los β son funciones de la política. Variables en minúscula (logaritmos); β con subíndice = coeficientes de regresión (`notacion.md` § 1); μ, ρ_m locales. Versión de palabra (la que prometía el 3.A.28): la curva de Phillips de los 60 no era un menú estable.

**Implicaciones:** microfundamentar (modelos con parámetros profundos, agentes que optimizan y expectativas racionales: el programa de los EGDE, ficha `egde`); evaluar **reglas**, no decisiones sueltas; estimar las **condiciones de optimalidad** (la Euler de Hall, 1978, y Hansen y Singleton, 1983, `\vertema{3.A.33}`); también una crítica de método (`\vertema{3.A.1}`). **Extensiones:** Sims (1980): los VAR, y para las decisiones dentro de una regla las formas reducidas sirven, «intervenciones modestas» (Leeper y Zha, 2003).

**Evidencia** (A06-09, **[decidir]**: la del modelo de islas va aquí): la pendiente cambia con la volatilidad de la política (Lucas, 1973, 18 países, 1952-1967); Ball, Mankiw y Romer (1988), 43 países, 1948-1986: −1,639 con la volatilidad sola, pero con la inflación media la volatilidad deja de ser significativa (NEK, `\vertema{3.A.7}`); la Phillips de EE. UU. de 1960-1985 se desplaza en los 70 (gráfico `phillips-eeuu-1960-1985`, `\vertema{3.A.28}`); contrastes formales matizados (Favero y Hendry, 1992: los parámetros de la demanda de dinero no cambian; Lindé, 2001: poca potencia; Rudebusch, 2005: cambios de política demasiado pequeños).

**Valoración:** cambió la profesión más que a los bancos centrales (que siguieron con modelos keynesianos hasta los EGDE estimados); se vuelve contra sus herederos (hábitos, costes de ajuste e indexación, ¿son profundos?, Chari, Kehoe y McGrattan, 2009); puerta a la inconsistencia temporal (`barro-gordon`).

**Gráfico de referencia:** `oposicion/temario/fuentes/3A06/graficos/phillips-eeuu-1960-1985.tex` (datos del BLS vía FRED; apoyo en el cante). En la pizarra, `eq:forma-reducida` bajo la producción.

## Cómo se adapta en cada tema

| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.6 | La NMC | desarrollo (hecho, 4/11/2026) | II.2.3 con a)-e): idea, parámetros profundos, `eq:forma-reducida`, implicaciones, Sims, evidencia con Lucas (1973), BMR y la Phillips de EE. UU., valoración | — |
| 3.A.1 | Métodos de la ciencia económica | mención (hecho, 4/11/2026) | Como ejemplo de cambio de paradigma (Kuhn) y del debate sobre la econometría | El ejemplo formal |
| 3.A.33 | Consumo | mención (hecho, 31/10/2026) | Una función de consumo estimada con una política no sirve para otra; la Euler de Hall, sí | La crítica en general |
| 3.A.5 | Síntesis y monetarismo | mención (hecho, 3/11/2026) | Crítica de los modelos macroeconométricos de la síntesis (Lucas, 1976) en la valoración del IS-LM, con `\vertema{3.A.6}` | El ejemplo formal |
| 3.A.7 | NEK de 2.ª generación | mención (hecho, 4/11/2026) | Los EGDE con parámetros estructurales como respuesta (II.1); la IS dinámica, a diferencia de la de la síntesis, no la alcanza (II.2); `\vertema{3.A.6}` | La crítica formalizada |
| 3.A.28 | Paro y Phillips | mención (hecho, 31/10/2026) | La Phillips de los 60 no era un menú estable | El ejemplo formal |
| 3.A.29 | Modelización dinámica | mención (hecho, 1/11/2026) | El porqué del agente representativo y de los microfundamentos | El ejemplo formal |
| 3.A.4 | Keynes y el desequilibrio | mención (hecho, 4/11/2026) | La crítica a los modelos de desequilibrio | — |
| 3.A.36 | Diseño de la política monetaria | mención (hecho, 4/11/2026) | Evaluar reglas, no decisiones sueltas | El ejemplo formal |
| 3.A.41 | Causas de la inflación | mención (hecho, 5/11/2026) | I.2.1: la curva de Phillips no es un menú estable porque sus parámetros cambian con la política; I.2.3 d): la persistencia de la inflación depende del régimen monetario (Benati, 2008), «la crítica de Lucas aplicada a la inflación»; `\vertema{3.A.6}` | La forma reducida |

## Divergencias encontradas en el temario actual

- **3.A.6 (Word)**: la contaba en 2 sitios (I y II.2, con una caja) con Y_t = β̂_0 + β̂_1 m_{t−1}. **Resuelto** (4/11/2026): un solo sitio y la forma reducida de 3 coeficientes con y_t en minúscula.
- **Esta ficha** tenía como ecuación ilustrativa y_t = β̂_0 + β̂_1m_{t−1} + ε_t con la regla m_t = μ + ρ_mm_{t−1} + e_t: **sustituida** por la del 3.A.6 (CC7), coherente con `lucas-islas` (ε_t la sorpresa monetaria, nunca e_t).

Autor: Víctor Gutiérrez Marcos
