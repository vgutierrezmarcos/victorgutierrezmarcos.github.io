# Modelo de Cagan (1956): demanda de dinero en hiperinflación y señoreaje

- **Área:** macro cerrada · **Tema de referencia:** 3.A.41 (La inflación… Hiperinflación y deflación) — la hiperinflación está en el título.
- **Temas que lo usan:** 3.A.41 (desarrollo), 3.A.35 (resumen; hecho, 5/11/2026: II.1.3 «La demanda de dinero en las hiperinflaciones», un solo `\paragraph` con Idea, Modelo e Implicaciones (A35-10), `eq:cagan` con $\mathbb{E}_t[\pi_{t+1}]$, las adaptativas de Cagan en continuo y las racionales de Sargent y Wallace, 1973; en III.3, el señoreaje con `eq:senoreaje` y la Laffer en mención con el gráfico `laffer-senoreaje` **copiado del 3.A.39**, sin cantarla; sin la estabilidad, `\vertema{3.A.41}`), 3.A.39 (resumen; hecho, 4/11/2026: III.2 con la curva de Laffer del señoreaje y la estabilidad en el anexo D, `\vertema{3.A.41}`). Bloque copiado casi literal en los tres. También 3.A.5 (mención; hecho, 3/11/2026: II.1: Cagan (1956) como uno de los autores de las expectativas adaptativas (la inflación esperada en las hiperinflaciones); ficha `expectativas-adaptativas`).
- **Manuales de referencia:** Cagan (1956), en Friedman (ed.), *Studies in the Quantity Theory of Money*; Sargent (1982), «The Ends of Four Big Inflations»; Romer (2019), cap. 11.8; Walsh (2017), cap. 4; Blanchard y Fischer (1989), cap. 4.
- **Decisión D061 (13/10/2026):** ¿Cómo se escriben los parámetros de la demanda de dinero de Cagan? α semielasticidad respecto a la inflación esperada y ζ constante de escala

## Presentación de referencia

**Pregunta:** ¿por qué se producen las hiperinflaciones y cuánto puede recaudar el Estado con la emisión de dinero?

**Supuestos:** en hiperinflación, la demanda de saldos reales depende sobre todo de la inflación esperada; expectativas adaptativas (Cagan) o racionales (Sargent y Wallace 1973).

**Ecuaciones:**

$$\frac{M^D_t}{P_t} = \zeta\, e^{-\alpha\, \mathbb{E}_t[\pi_{t+1}]},\qquad \alpha > 0$$

Señoreaje en estado estacionario (γ_M = π = π^e):

$$S = \frac{\Delta M}{P} = \pi\,\frac{M}{P} = \pi\,\zeta\,e^{-\alpha\pi},\qquad \frac{dS}{d\pi} = 0 \iff \pi^* = \frac{1}{\alpha}$$

**Resultado:** curva de Laffer del señoreaje; si el déficit a financiar supera el máximo S(1/α), no hay estado estacionario: hiperinflación; con expectativas adaptativas y ajuste rápido, inestabilidad. Las hiperinflaciones terminan con reformas fiscales creíbles (Sargent 1982).

**Señoreaje** (3.A.39, `eq:senoreaje`, con la deuda constante): $S_t\equiv\frac{M_t-M_{t-1}}{P_t}=\left(\frac{M_t}{P_t}-\frac{M_{t-1}}{P_{t-1}}\right)+\frac{\pi_t}{1+\pi_t}\frac{M_{t-1}}{P_{t-1}}$ (aumento de los saldos reales + **impuesto inflacionario**, de base los saldos reales y tipo π/(1+π)); $s_t=S_t/Y_t$. **Laffer del señoreaje** (`eq:laffer-senoreaje`): $S(\pi)=\pi\zeta e^{-\alpha\pi}$, $S'(\pi)=\zeta e^{-\alpha\pi}(1-\alpha\pi)=0\iff\pi^*=1/\alpha$, $S^{\max}=\zeta/(\alpha e)$; un déficit menor que $S^{\max}$ tiene 2 equilibrios, $\pi_{\mathrm B}$ y $\pi_{\mathrm A}$; uno mayor, ninguno (hiperinflación). Es el límite de la financiación monetaria y el puente con la aritmética monetarista (ficha `aritmetica-monetarista`).

**Estabilidad** (anexo D del 3.A.39; desarrollo en el 3.A.41): en tiempo continuo, $\ln(M_t/P_t)=\ln\zeta-\alpha\pi^e_t$ y adaptativas $\dot\pi^e=\gamma(\pi-\pi^e)$ (**γ de las adaptativas**, la canónica, no la constante de escala); $\pi=\frac{\gamma_M-\alpha\gamma\pi^e}{1-\alpha\gamma}$, $\dot\pi^e=\frac{\gamma}{1-\alpha\gamma}(\gamma_M-\pi^e)$: **estable si $\alpha\gamma<1$**, inestable si $\alpha\gamma>1$ (la inflación puede dispararse sin que el dinero se acelere). Explica la paradoja de Cagan: la inflación efectiva superó con mucho la que maximizaba el señoreaje.

**Gráfico de referencia:** curva de Laffer del señoreaje, S frente a π, con máximo en π = 1/α y la recta horizontal del déficit a financiar (dos equilibrios, $\pi_{\mathrm B}$ de inflación baja y $\pi_{\mathrm A}$ de inflación alta): **`fuentes/3A39/graficos/laffer-senoreaje.tex`** (el primero hecho en TikZ; el 3.A.41 y el 3.A.35 lo copian). Estabilidad con adaptativas, 2 paneles (a) $\alpha\gamma<1$, b) $\alpha\gamma>1$): `fuentes/3A39/graficos/cagan-estabilidad.tex` (anexo, no se canta en el 3.A.39; en el 3.A.41, en el cuerpo).

## Cómo se adapta en cada tema

| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.41 | Hiperinflación | Desarrollo | Demanda de Cagan, señoreaje, curva de Laffer, estabilidad con expectativas adaptativas, fin de las hiperinflaciones | — |
| 3.A.35 | Demanda de dinero (unidad de cuenta) | resumen (hecho, 5/11/2026) | La función de unidad de cuenta se ve cuando falla; `eq:cagan` con α semielasticidad y ζ; $\dot\pi^e=\gamma(\pi-\pi^e)$ y las racionales (un anuncio creíble baja hoy los precios); $\pi=\gamma_M$ en estado estacionario; en III.3, señoreaje (`eq:senoreaje`), $\pi^*=1/\alpha$ y el gráfico copiado del 3.A.39, con la credibilidad (Sargent, 1982; art. 123 del TFUE) | La estabilidad (αγ) y las hiperinflaciones caso a caso |
| 3.A.39 | Financiación del déficit | Resumen (hecho, 4/11/2026) | III.1 señoreaje e impuesto inflacionario (`eq:senoreaje`); III.2 Cagan a)-c) con la demanda, `eq:laffer-senoreaje` y el gráfico `laffer-senoreaje` en la pizarra; estabilidad con αγ en el anexo D; `\vertema{3.A.41}`. Sin las cifras de Cagan por meses (α = 5,46, 18 % mensual en Alemania), no comprobadas (A39-18) | La dinámica completa y las hiperinflaciones caso a caso |
| 3.A.5 | Monetarismo (expectativas adaptativas) | mención (hecho, 3/11/2026) | Cagan (1956) como seguidor de Friedman y usuario de las adaptativas para la inflación esperada en las hiperinflaciones | La demanda de Cagan y el señoreaje |

## Divergencias encontradas en el temario actual

- **3.A.35 resuelto** (5/11/2026, CC4): resumen; γ (constante) → ζ, ϑ → π, β de las adaptativas → γ, sin los 3 gráficos de Cagan del Word (expectativas, estabilidad, señoreaje) salvo la Laffer, copiada del 3.A.39; fuera «$\alpha\beta>1$ típico de países menos adelantados» y Meade (sin fuente). La ficha decía que el 3.A.35 no repetía el señoreaje: lo menciona en III.3 (es parte de las implicaciones de política del título), sin la estabilidad. **$\pi^*=1/\alpha$** convive en el 3.A.35 con el $\pi^*\simeq-r$ de la regla de Friedman en otro apartado (`notacion.md` § 1, B/π; A35-15, **[decidir]**).
- **Copia literal** del bloque en 3.A.35, 3.A.39 y 3.A.41: desarrollo solo en 3.A.41. **3.A.39 resuelto** (4/11/2026): resumen; ϑ → π, γ (constante) → ζ, $m\bar Y$ fuera, adaptativas con β mezclando discreto y continuo → $\dot\pi^e=\gamma(\pi-\pi^e)$, $i_tD_{t-1}$ → $i_{t-1}D_{t-1}$; la nota 36 (α entre 1/3 y 1/2, 200-300 % «anual», señoreaje del 8-12 % del PIB) fuera, sin fuente y con la unidad mal (Cagan estima por meses).
- **Inflación ϑ** en el señoreaje y π en la demanda (3.A.35, dentro del mismo tema): canon **π**.
- **Constante de escala γ** (3.A.35, 3.A.39, 3.A.41) choca con γ = tasas de crecimiento y peso de la inflación en Barro-Gordon: canon **ζ** (α queda para la semielasticidad).

Autor: Víctor Gutiérrez Marcos
