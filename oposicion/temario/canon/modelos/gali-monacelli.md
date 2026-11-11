# Modelo neokeynesiano de economía pequeña y abierta (Galí y Monacelli, 2005, 2008)

- **Área:** macro-abierta · **Tema de referencia:** **3.A.32**, **revisado el 11/11/2026** (I.3 `sec:gali-monacelli` con a)-e); II.3 `sec:microfundamentos`, las reglas y la política fiscal en una unión monetaria; anexo C `anexo:gali-monacelli` con la derivación). **[decidir]** (CC4 del 3.A.32, A32-04): es el único tema que lo desarrolla y el que tiene en el título la renta y la inflación en economía abierta. *Alternativa*: sin ficha propia, como variante abierta en `nek-3-ecuaciones`.
- **Temas que lo usan:** 3.A.32 (desarrollo; hecho, 11/11/2026), 3.A.7 (mención; hecho, 4/11/2026: l. 798, «la misma estructura con tipo de cambio da la versión de Galí y Monacelli», `\vertema{3.A.32}`), 3.A.18 (mención; hecho, 19/10/2026: l. 356, versiones de economía abierta de la NEK, `\vertema{3.A.32}`), 3.A.38 (mención de 2008; hecho, 5/11/2026: l. 835, la fiscal como instrumento que queda en una unión monetaria, `GaliMonacelli2008Optimal`, `\vertema{3.B.16}`; l. 911, 2008 y no 2005), 3.B.16 (resumen; hecho, 11/11/2026: III.3.2 `sec:politica-fiscal`, `GaliMonacelli2008Optimal`, con Nakamura y Steinsson, 2014, y la devaluación fiscal), 4.B.4 (unión monetaria: resumen de 2008), 3.B.19 (mención: países grandes y coordinación)
- **Manuales de referencia:** Galí y Monacelli (2005), *Review of Economic Studies* (`GaliMonacelli2005Monetary`); Galí y Monacelli (2008), *Journal of International Economics* (`GaliMonacelli2008Optimal`); Galí, *Monetary Policy, Inflation, and the Business Cycle* (2.ª ed., 2015, cap. 8, `Gali2015Monetary`); Obstfeld y Rogoff (1995, `ObstfeldRogoff1995Redux`) como origen de la nueva macroeconomía abierta; Corsetti y Pesenti (2009, `CorsettiPesenti2009`) y Engel (2011, `Engel2011Currency`) para la moneda de facturación; Gopinath (2020, `Gopinath2020DCP`).

## Presentación de referencia (3.A.32, I.3, II.3 y anexo C)

Estructura a)-e). **Pregunta:** ¿qué cambia la apertura en la IS dinámica y en la curva de Phillips, y qué inflación debe estabilizar el banco central de una economía abierta?

**a) Idea.** La versión para una economía pequeña del modelo neokeynesiano canónico (ficha `nek-3-ecuaciones`, `\vertema{3.A.7}`), dentro de la nueva macroeconomía abierta de Obstfeld y Rogoff (1995).

**b) i) Supuestos:** un continuo de economías pequeñas ($y^*_t$, producción mundial en logaritmos, dada); hogares del modelo canónico con aversión relativa al riesgo **θ** y la inversa de Frisch **φ** (`\varphi`), que consumen una parte **α de importaciones** (**α grado de apertura**, local y avisada; $1-\alpha$ el sesgo hacia lo nacional); competencia monopolística entre variedades nacionales con elasticidad **σ** (`\vertema{3.A.18}`, ficha `dixit-stiglitz`) y Calvo con **η** (probabilidad de **no** revisar); precios en la moneda del productor y ley del precio único; mercados financieros completos.

**b) ii) Desarrollo** (ecuaciones, no funciones clave; minúsculas en logaritmos):
- **2 inflaciones:** con **$\tau_t\equiv p_{F,t}-p_{H,t}$** (precio de lo importado en términos de lo nacional, en logaritmos: la **inversa** de la relación real de intercambio $P_X/P_M$, misma letra que en Corsetti-Pesenti; nunca $s_t$, que es el ahorro; A32-09, **[decidir]**), `eq:inflacion-gm` $\pi_t=\pi_{H,t}+\alpha\,\Delta\tau_t$, con **$\pi_{H,t}$ inflación interna** (de lo producido en casa) y **$\pi_t$ IPC**. Con la ley del precio único, $\tau_t=e_t+p^*_t-p_{H,t}$, y es la misma identidad que `eq:inflacion-abierta` (ficha `oa-da`).
- **IS dinámica abierta** (`eq:is-abierta-gm`): $x_t=\mathbb E_t[x_{t+1}]-\frac{1}{\theta_\alpha}\big(i_t-\mathbb E_t[\pi_{H,t+1}]-r^n_t\big)$, $\theta_\alpha\equiv\theta/(1+\alpha\Theta)$; $r^n_t$ depende también del crecimiento esperado de la producción mundial.
- **NKPC abierta** (`eq:nkpc-abierta`): $\pi_{H,t}=\beta\,\mathbb E_t[\pi_{H,t+1}]+\kappa_\alpha x_t$, $\kappa_\alpha\equiv\frac{(1-\eta)(1-\beta\eta)}{\eta}(\theta_\alpha+\varphi)$ (como `eq:kappa` del 3.A.7; κ no es la «pendiente de la brecha» de Tebar con $(1-\theta)(1-\beta\theta)/\theta$, que es el coeficiente del coste marginal).
- Cierre con una regla de política monetaria **sin suavización** (ν es la sensibilidad del saldo comercial en los temas con XN; K19).
- Locales (anexo C): **$\Theta$**, **$\Psi\equiv\theta\sigma_F+(1-\alpha)(\theta\sigma_{HF}-1)$** (ω son los pesos de los tipos efectivos, D044), **$\sigma_{HF}$** (nacionales-extranjeros) y **$\sigma_F$** (entre extranjeros) en la familia de σ (η y γ ya tienen dueño); $\Theta\equiv\Psi-1$. Reparto del riesgo $c_t=c^*_t+\frac1\theta(1-\alpha)\tau_t$; vaciado $y_t=y^*_t+\tau_t/\theta_\alpha$.

**b) iii) Implicaciones:** misma estructura que la cerrada (la apertura cambia $\theta_\alpha$, $\kappa_\alpha$ y $r^n_t$; con $\alpha=0$ o con $\theta=\sigma_{HF}=\sigma_F=1$, el modelo canónico); el tipo de cambio es un precio relativo que reasigna el gasto, como en Mundell-Fleming, pero sale de la optimización; 2 inflaciones, 2 objetivos posibles.

**Política (II.3, `eq:reglas-gm`):** DITR $i_t=\rho+\phi_\pi\pi_{H,t}$; CITR $i_t=\rho+\phi_\pi\pi_t$; PEG $e_t=0$ (`\vertema{3.A.36}`). Con elasticidades unitarias, lo óptimo es **$\pi_{H,t}=0$ y $x_t=0$** (la divina coincidencia vale para la **inflación interna**, ficha `divina-coincidencia`), con el tipo de cambio y $\tau_t$ fluctuando mucho; **DITR > CITR > tipo fijo** (el fijo, el peor en todas las calibraciones). Fundamento de «mirar a través» de una perturbación energética (efecto directo). Matices: precios en la moneda del comprador o en dólares (Engel, 2011; Gopinath, 2020; Corsetti y Pesenti, 2009) y miedo a flotar (Calvo y Reinhart, 2002). **Unión monetaria (2008):** el banco central estabiliza la inflación media y cada gobierno usa el gasto para cerrar su brecha. Política fiscal abierta: Furlanetto (2006), Ilzetzki, Mendoza y Végh (2013), Corsetti, Kuester y Müller (2011).

**c) Extensiones:** precios en la moneda del comprador (Corsetti-Pesenti, `\vertema{3.A.37}`, `\vertema{3.B.19}`); mercados incompletos y emergentes (Uribe y Schmitt-Grohé, 2017); uniones monetarias y 2 países (2008, `\vertema{3.B.19}`).

**d) Evidencia:** Backus y Smith (1993): el reparto del riesgo falla; traspaso incompleto y facturación en dólares (Gopinath, 2020).

**e) Valoración:** el marco con el que se piensa hoy la política monetaria de una economía abierta, con criterio de bienestar; límites: mercados completos, traspaso completo, economía pequeña, sin deuda exterior ni efectos sobre los demás.

**Gráfico de referencia:** ninguno (en el cante, solo las 2 ecuaciones en una esquina). La pizarra de la NEK cerrada es `nek-xpi` del 3.A.7.

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.32 | Renta e inflación en economía abierta; qué inflación estabilizar | desarrollo (referencia, [decidir]; hecho, 11/11/2026) | I.3 con a)-e), `eq:inflacion-gm`, `eq:is-abierta-gm`, `eq:nkpc-abierta`; II.3 con `eq:reglas-gm`, DITR > CITR > fijo, «mirar a través», miedo a flotar y la fiscal en unión monetaria; anexo C paso a paso | — |
| 3.A.7 | NEK de 2.ª generación | mención (hecho, 4/11/2026) | Una viñeta en las extensiones: misma estructura con tipo de cambio, `\vertema{3.A.32}` | Las ecuaciones abiertas |
| 3.A.18 | Competencia monopolística | mención (hecho, 19/10/2026) | Versiones abiertas de la NEK con la CES de variedades, `\vertema{3.A.32}` | — |
| 3.A.38 | Política fiscal | mención (hecho, 5/11/2026) | Galí y Monacelli (**2008**) en la unión monetaria, `\vertema{3.B.16}` | El modelo |
| 3.B.16 | Integración monetaria: la solución imperfecta | resumen (hecho, 11/11/2026) | III.3.2 `sec:politica-fiscal`: en un modelo neokeynesiano de unión monetaria lo óptimo es que el banco central estabilice la inflación media y cada gobierno use el gasto para cerrar su brecha (`GaliMonacelli2008Optimal`, `\vertema{3.A.32}`), con Nakamura y Steinsson (2014, multiplicador relativo ≈1,5, `\vertema{3.A.38}`) y la devaluación fiscal (Farhi, Gopinath e Itskhoki, 2014); las mismas palabras que el 3.A.32 (l. 483) | La derivación |
| 4.B.4 | Política fiscal | mención | Ídem (2008) | — |
| 3.B.19 | Coordinación internacional | mención | Países grandes y 2 países; Corsetti-Pesenti (su referencia) | El modelo de economía pequeña |

## Divergencias encontradas en el temario actual
- Notación de Galí (2015) frente al canon: σ CRRA → **θ** (D001); θ Calvo → **η**; ε variedades → **σ**; $s_t$ relación de intercambio → **$\tau_t$**; ω → **Ψ**; η y γ de las elasticidades → **$\sigma_{HF}$**, **$\sigma_F$**; $\sigma_\alpha$ → **$\theta_\alpha$**. Así en el 3.A.32.
- Galí y Monacelli **2005** (política monetaria) frente a **2008** (política fiscal en una unión monetaria): el Word del 3.A.38 los mezclaba (resuelto el 5/11/2026).

Autor: Víctor Gutiérrez Marcos
