# Dinero en la función de utilidad (MIU): Sidrauski (1967)

- **Área:** macro cerrada · **Tema de referencia:** **3.A.35** (Teorías de la demanda de dinero; revisado el 5/11/2026: II.1.1, «El dinero en la función de utilidad: Sidrauski (1967)», con a)-d), `\funcionclave` `eq:miu` y el anexo A `anexo:miu` paso a paso) — es una teoría de la demanda de dinero y el único tema que la cuenta entera. Ficha creada en la fase canon del 3.A.35 (5/11/2026, CC1, **[decidir]**).
- **Temas que lo usan:** 3.A.35 (desarrollo; hecho, 5/11/2026), 3.A.21 (mención; hecho, 14/10/2026: una de las 4 vías para meter el dinero en el equilibrio general, «es una forma reducida… da una demanda de dinero que crece con el consumo y cae con el tipo de interés», l. 993), 3.A.29 (mención; hecho, 1/11/2026: l. 510, la demanda de dinero microfundamentada con `\vertema{3.A.35}`), 3.A.39 (mención; hecho, 4/11/2026: l. 696, si el dinero da utilidad es superneutral a largo plazo y el coste de la inflación es tener menos saldos reales), 3.A.43 (mención; hecho, 31/10/2026: l. 596, el efecto Mundell-Tobin, 1965, frente a la superneutralidad de Sidrauski, con `\vertema{3.A.41}`; falta `\vertema{3.A.35}`, cosmético en `pendientes-coherencia.md`), 3.A.41 (resumen; hecho, 5/11/2026: II.1.1, la superneutralidad de Sidrauski frente a Mundell-Tobin y Stockman, `\vertema{3.A.35}` y `\vertema{3.A.43}`; II.2.1, $u_m/u_c=i$ con la discreta entre paréntesis y `\vertema{3.A.35}` para la derivación —con $c$ minúscula, pendiente cosmético—), 3.A.4 (mención: Patinkin, 1956, como antecedente; ficha `patinkin`), 3.A.7 (mención: la NEK con utilidad separable prescinde del dinero, «economía sin dinero» de Woodford).
- **Manuales de referencia:** Sidrauski (1967), «Rational Choice and Patterns of Growth in a Monetary Economy», *AER*; Walsh (2017), *Monetary Theory and Policy*, cap. 2; Blanchard y Fischer (1989), cap. 4; Feenstra (1986), *JME*; Brock (1974), *IER*; Woodford (2003); Galí (2015), cap. 2.

## Presentación de referencia

**Pregunta:** ¿afecta el crecimiento del dinero, y con él la inflación, a la acumulación de capital? Y, de paso: ¿qué demanda de dinero sale de un modelo dinámico de equilibrio general?

**a) Idea:** en equilibrio general el dinero solo tiene valor si se le da una función que el modelo sin dinero no tenga (3.A.21). La más directa: poner los saldos reales en la utilidad, como resumen de que ahorran tiempo y molestias al pagar. Patinkin (1956) ya lo hacía para romper la dicotomía (`\vertema{3.A.4}`); Sidrauski lo lleva al RCK (`\vertema{3.A.43}`).

**b) Modelo** (notación canónica, `notacion.md` § 8):

- *Supuestos:* hogar representativo de horizonte infinito, previsión perfecta, población constante y trabajo inelástico; produce $f(K_{t-1})$ con el capital de final del periodo anterior y lo deprecia a la tasa $\delta$; utilidad $u(C_t,m_t)$ con **$m_t\equiv M_t/P_t$ saldos reales**, $u_C>0$, $u_m>0$, cóncava; descuento $\beta\equiv1/(1+\rho)$; el dinero crece a la tasa **$\gamma_M$** y el Estado devuelve el señoreaje como transferencia de suma fija (**$T_t<0$**); $1+\pi_t\equiv P_t/P_{t-1}$.
- *Problema* (con `\optim`):
$$\max_{\{C_t,K_t,m_t\}}\sum_{t=0}^{\infty}\beta^t u(C_t,m_t)\quad\text{s.a.}\quad C_t+K_t+m_t=f(K_{t-1})+(1-\delta)K_{t-1}-T_t+\frac{m_{t-1}}{1+\pi_t}$$
- *Condiciones de primer orden* (anexo `anexo:miu`, con $\lambda_t$): $u_C=\lambda_t$; $\lambda_t=\beta\lambda_{t+1}(1+r_t)$ con **$1+r_t\equiv f'(K_t)+1-\delta$**; $u_m=\lambda_t-\beta\lambda_{t+1}/(1+\pi_{t+1})$. Con la ecuación de Fisher exacta, **$1+i_t\equiv(1+r_t)(1+\pi_{t+1})$** (`\vertema{3.A.3}`):
$$\boxed{\frac{u_m(C_t,m_t)}{u_C(C_t,m_t)}=\frac{i_t}{1+i_t}}\qquad(\texttt{eq:miu},\ \text{función clave})$$
En tiempo continuo, $u_m/u_C=i$ (la forma que usa el 3.A.41, con la discreta entre paréntesis).

**Inflación y capital** (CC7 del 3.A.41; pregunta de referencia en el 3.A.41, II.1.1, y modelos en el 3.A.35 y el 3.A.43): ¿cambia la inflación anticipada el capital de estado estacionario? Depende de por qué se tiene dinero: **Mundell-Tobin** (Mundell, 1963; Tobin, 1965): el dinero es un activo alternativo al capital; más inflación, más capital (`\vertema{3.A.43}`); **superneutralidad** (Sidrauski, 1967): con hogares que optimizan, el capital lo fija la regla de oro modificada y no depende de la inflación (`\vertema{3.A.35}`); **Stockman (1981)**: con **restricción de pago por adelantado** también sobre la inversión, más inflación, **menos** capital (ficha `cia`). En los datos, la inflación alta va con menos inversión, sobre todo por su volatilidad.
- *Interpretación:* la relación marginal de sustitución entre dinero y consumo se iguala a su precio relativo (como el consumidor con 2 bienes, 3.A.8). *Ejemplo:* con $u=\ln C_t+\ln m_t$, $m_t=C_t(1+i_t)/i_t$.

**c) Implicaciones:**

- **Demanda de dinero** $m_t=L(C_t,i_t)$: crece con el consumo (la escala es el gasto, no la renta) y baja con el tipo nominal. Para el hogar representativo; con hogares distintos, solo con la forma polar de Gorman (`\vertema{3.A.8}`, en nota).
- **Superneutralidad:** en el estado estacionario, $f'(K^*)=\rho+\delta$ y $C^*=f(K^*)-\delta K^*$, independientes de $\gamma_M$; $\pi=\gamma_M$ y $1+i=(1+\rho)(1+\gamma_M)$: más crecimiento del dinero solo baja $m^*$. La inflación cuesta bienestar solo por los saldos reales que se dejan de tener. Distinguir **neutralidad**, **superneutralidad** y **dicotomía clásica** (nota de I.1.1 del 3.A.35, con Serletis, 2007).
- **Cantidad óptima de dinero:** $u_m=0\Leftrightarrow i=0$: regla de Friedman, $1+\gamma_M=1+\pi=\beta$ (ficha `regla-friedman`; desarrollo en el 3.A.41).

**d) Extensiones y valoración:** con trabajo elástico y utilidad no separable, se pierde la superneutralidad (Brock, 1974); la NEK, con utilidad separable, resuelve el modelo «sin dinero» (Woodford, 2003; Galí, 2015, cap. 2; `\vertema{3.A.7}`), que **no es la economía sin efectivo** del 3.A.35 (III.4). A favor: sencillo, demanda positiva en equilibrio general, comparaciones de bienestar. En contra: supone lo que había que explicar (Hahn, 1965); $u_m$ y $u_{Cm}$ sin fundamento. **Feenstra (1986):** los modelos de costes de transacción son equivalentes a un MIU: es una **forma reducida** (ficha `cia`).

**Pegatina:** «el dinero no da la felicidad» (en este modelo, sí: por eso es un atajo).

**Gráfico de referencia:** ninguno (el 3.A.35 no lo dibuja).

## Cómo se adapta en cada tema

| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.35 | Demanda de dinero | desarrollo (hecho, 5/11/2026) | a)-d) con `eq:miu`, ejemplo logarítmico, superneutralidad, regla de Friedman derivada; anexo `anexo:miu` | — |
| 3.A.21 | El dinero en el equilibrio general | mención (hecho, 14/10/2026) | Una de las 4 vías (Clower, Kiyotaki-Wright, MIU, OLG): forma reducida; demanda creciente en el consumo y decreciente en el tipo | Las condiciones de primer orden |
| 3.A.29 | Modelización dinámica | mención (hecho, 1/11/2026) | Ejemplo de agregado microfundamentado (l. 510), `\vertema{3.A.35}` | El modelo |
| 3.A.39 | Señoreaje e impuesto inflacionario | mención (hecho, 4/11/2026) | Superneutral a largo plazo; el coste de la inflación, tener menos saldos reales (frente a la CIA) | El modelo |
| 3.A.41 | Costes de la inflación, inflación óptima | resumen (hecho, 5/11/2026) | Superneutralidad y $u_m/u_C=i$ ($i/(1+i)$ en discreto) como base de la regla de Friedman y del coste de bienestar; `\vertema{3.A.35}` para la derivación | La derivación del anexo |
| 3.A.43 | Crecimiento exógeno | mención (hecho, 31/10/2026) | Tobin (1965) frente a Sidrauski: con hogares que optimizan, el capital no depende de la inflación; `\vertema{3.A.35} \vertema{3.A.41}` (hoy solo el 3.A.41) | — |
| 3.A.7 | NEK | mención | La economía «sin dinero» (*cashless limit*) de Woodford | — |

## Divergencias encontradas en el temario actual

- El Word del 3.A.35 decía «modelo RKC», Patinkin (1951), mezclaba $(1+r)$ y $1/(1+\pi)$ en una restricción de 2 periodos y repetía la derivación en un anexo: resuelto (RCK, Patinkin 1956, una sola derivación de horizonte infinito con capital).
- **3.A.41 (revisado el 5/11/2026; pendiente cosmético en `pendientes-coherencia.md`, «Pendiente del 3.A.41»):** escribe $u_m/u_c=i$ con $c$ minúscula (l. 483); el canon es **$u_C$** (subíndice como la variable, $C_t$ consumo agregado en macro). Ver `mapa.yaml`, contradicciones del 3.A.35.
- La propuesta inicial de la coherencia (K37) usaba bonos $b_t$ y renta exógena $Y_t$; el tema usa la versión con capital (la de Sidrauski y Walsh), que es la de referencia.

Autor: Víctor Gutiérrez Marcos
