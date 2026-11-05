# Modelo de ciclo real con gasto público (Christiano y Eichenbaum, 1992; Baxter y King, 1993)

- **Id:** `rbc-sims` (se conserva porque está en el mapa y en `alias.json`; alias `rbc-fiscal`, `rbc-gasto`, `rbc-politica-fiscal`).
- **Área:** sector público · **Tema de referencia:** **3.A.38** (política fiscal: efectos sobre el crecimiento y el ahorro; D088), **hecho el 5/11/2026**: I.2 `sec:rbc-fiscal` con a)-e) y el anexo B `anexo:rbc-fiscal` paso a paso. El RBC base está en el 3.A.42 (II.1; ficha `rbc`), del que parte sin volver a derivarlo. 4.B.4 lo resume con lo imprescindible para cantarse sin el 3.A.38.
- **Temas que lo usan:** 3.A.38 (desarrollo; referencia; hecho, 5/11/2026), 4.B.4 (resumen; hoy desarrollo en su Word), 3.A.40 (resumen; hecho, 5/11/2026: II.2.2 `sec:ciclo-real`, «El ciclo real: el efecto riqueza», con a)-d), `BaxterKing1993Fiscal` y `\vertema{3.A.42}` `\vertema{3.A.38}`; transitorio, positivo y menor que 1; permanente, puede superar 1; Barro, 1990, en mención con `\vertema{3.A.38}`), 3.A.42 (mención; hecho, 4/11/2026: II.1.2 c), el gasto público como extensión con $K_{t+1}=(1-\delta)K_t+Y_t-C_t-G_t$, efecto riqueza, Christiano y Eichenbaum, 1992, y Baxter y King, 1993, `\vertema{3.A.38}`), 3.A.6 (mención; hecho, 4/11/2026: anexo D, el gasto público como perturbación real, y el efecto riqueza del gasto en el anexo C; `\vertema{3.A.38}`).
- **Manuales y fuentes de referencia:** Baxter y King (1993), «Fiscal policy in general equilibrium», *AER* (`BaxterKing1993Fiscal`, la clave de los temas revisados; el 3.A.44 usa `BaxterKing1993`, duplicada); Christiano y Eichenbaum (1992), *AER* (`ChristianoEichenbaum1992Current`); Sims (2017), notas de clase sobre el ciclo real con política fiscal (`Sims2017Fiscal`; el Word decía «Sims (2015)», no comprobado: el 3.A.38 lo cita como «seguimos la presentación de Sims (2017)», la versión que sigue en línea); McGrattan (1994) para los impuestos distorsionantes; Romer, *Advanced Macroeconomics*, cap. 5; calibración de Prescott (1986) y Hansen y Wright (1992).
- **Decisión D088 (13/10/2026):** ¿Cuál es el tema de referencia del RBC con política fiscal? 3.A.38 (elegida por Víctor; la recomendada era «4.B.4, como en el mapa»).
- **Rehecha el 5/11/2026** a raíz del 3.A.38 (CC1 de su `propuestas-coherencia.md`): notación canónica, gráfico de referencia propio, cifras de la simulación y el título sin «Sims».

## Presentación de referencia (la del 3.A.38, I.2)

**Pregunta:** ¿qué hace un aumento del gasto público si no hay rigideces y los hogares saben que lo pagarán?

**Pegatina** (3.A.38, A38-03): «lo que no va en lágrimas va en suspiros» (el gasto se paga, hoy o mañana). La de la equivalencia ricardiana, «no hay plazo que no se cumpla ni deuda que no se pague», es la del 3.A.39 (mismo concepto).

**Supuestos:** los del ciclo real del 3.A.42 (economía cerrada, un bien, tiempo discreto, horizonte infinito, hogar y empresa representativos, competencia perfecta, precios y salarios flexibles, expectativas racionales, Cobb-Douglas con perturbación tecnológica persistente; el bien es el numerario: $w_t$ salario real y $r_t+\delta$ alquiler del capital). Se añade un **Estado** que compra $G_t$ (no da utilidad ni produce; con utilidad separable $u(C,L)+v(G)$ nada cambia) con un proceso propio y lo financia con impuestos de suma fija $T_t$ (recaudación), tipos proporcionales $\tau_{L,t}$ y $\tau_{K,t}$ sobre las rentas del trabajo y del capital y deuda $D_t$ (al final de $t$, D028):

$$\ln G_t=(1-\rho_G)\ln\overline G+\rho_G\ln G_{t-1}+\varepsilon^G_t,\quad 0\le\rho_G<1\qquad(\texttt{eq:rbc-gasto})$$
$$G_t+r^D_{t-1}D_{t-1}=T_t+\tau_{L,t}\,w_tL_t+\tau_{K,t}\,r_tK_t+(D_t-D_{t-1})\qquad(\texttt{eq:rbc-gobierno})$$

con $r^D_{t-1}$ el tipo real de la deuda emitida en $t-1$, fijado al emitirla (*ex ante*, como `restriccion-gobierno`).

**Hogar** (con `\optim`): $\max\ \mathbb E_0\sum_t\beta^t\big[(C_t^{1-\theta}-1)/(1-\theta)-\chi L_t^{1+\varphi}/(1+\varphi)\big]$ s.a. $C_t+K_{t+1}+D_t=(1-\tau_{L,t})w_tL_t+[1+(1-\tau_{K,t})r_t]K_t+(1+r^D_{t-1})D_{t-1}-T_t$. La empresa no tiene problema intertemporal salvo con costes de ajuste (`\vertema{3.A.34}`, no 3.A.29).

**Ecuaciones** (las etiquetas del 3.A.42, con las cuñas fiscales; con $\tau_L=\tau_K=0$ y $G_t=0$ son las del modelo base):
$$Y_t=A_tK_t^{\alpha}L_t^{1-\alpha},\quad \ln A_t=\rho_A\ln A_{t-1}+\varepsilon^A_t\qquad(\texttt{eq:rbc-tecnologia})$$
$$w_t=(1-\alpha)A_t(K_t/L_t)^{\alpha},\quad r_t+\delta=\alpha A_t(K_t/L_t)^{\alpha-1}\qquad(\texttt{eq:rbc-precios})$$
$$C_t^{-\theta}=\beta\,\mathbb E_t\big[C_{t+1}^{-\theta}\big(1+(1-\tau_{K,t+1})r_{t+1}\big)\big],\quad \chi L_t^{\varphi}=C_t^{-\theta}(1-\tau_{L,t})\,w_t\qquad(\texttt{eq:rbc-hogar})$$
$$K_{t+1}=(1-\delta)K_t+Y_t-C_t-G_t\qquad(\texttt{eq:rbc-acumulacion},\ \text{función clave, la del 3.A.42 con }-G_t)$$

La restricción del hogar sobra (Walras). En el anexo B: lagrangiano con $\beta^t\lambda_t$, 4 condiciones de primer orden (con la Euler de los bonos, $\lambda_t=\beta\mathbb E_t[\lambda_{t+1}](1+r^D_t)$, y el no arbitraje $r^D_t=(1-\tau_{K,t+1})r_{t+1}$ sin incertidumbre), no juego de Ponzi del Estado y `tab:equilibrio-rbc-fiscal` (la `tab:equilibrio-rbc` del 3.A.42 más $G_t$ y la restricción del Estado).

**Implicaciones:**
- **Equivalencia ricardiana:** con suma fija, ni $T_t$ ni $D_t$ aparecen en las ecuaciones; dada la senda del gasto, la del déficit es indiferente (Barro, 1974; resumen con las palabras del 3.A.39; ficha `equivalencia-ricardiana`).
- **Efecto riqueza negativo:** el hogar consume menos y trabaja más; la demanda de trabajo no cambia, el salario real baja, suben empleo y producción; **multiplicador positivo y menor que 1** (en nota: el tipo real sube en el impacto y la sustitución intertemporal empuja también la oferta de trabajo).
- **La persistencia lo decide** (simulación propia, `tab:gasto-rbc`): **multiplicador de impacto 0,03** con gasto transitorio ($\rho_G=0$; se paga sobre todo con menos inversión: $\Delta I=-0{,}93$), **0,32** con gasto persistente ($\rho_G=0{,}95$; $\Delta C=-0{,}36$, horas +0,49 %) y **−0,68** si se financia con un impuesto sobre el trabajo con presupuesto equilibrado cada periodo (horas −1,02 %). Al retirarse el gasto se deshace el camino (consumo y salario suben; horas y producción bajan): impacto y vuelta, separados.
- **Largo plazo con gasto permanente:** el tipo de interés y $K/L$ vuelven a su nivel y el salario no cambia; de $\varphi\hat L=-\theta\hat C$ y la restricción de recursos, $\Delta Y/\Delta G=1/[s_C(\theta+\varphi)/\theta+s_G]$ (con $s_C$, $s_G$ pesos del consumo y del gasto, locales) = **0,75** con $\theta=\varphi=1$, $s_C\approx0{,}563$, $s_G=0{,}2$; con trabajo más elástico puede superar 1 (Baxter y King, 1993).
- **Oferta de trabajo inelástica:** el gasto no mueve las horas ni la producción y expulsa consumo e inversión uno a uno (**expulsión completa**); con gasto permanente, todo es consumo, como en el RCK del 3.A.43 (enlace con II.1 del 3.A.38, ficha `ramsey-cass-koopmans`).

**Extensiones:** impuestos distorsionantes (la forma de financiar importa tanto como el gasto; $\tau_L$ reduce el salario neto y las horas, $\tau_K$ el rendimiento del ahorro y, a largo plazo, el capital; McGrattan, 1994); suavización impositiva en una viñeta con la nota del exceso de gravamen (`exceso-gravamen`, gráfico pequeño en nota; ficha `suavizacion-impositiva-barro`); **gasto productivo** de Baxter y King con $Y_t=A_tK_t^{\alpha}L_t^{1-\alpha}(K^G_t)^{\alpha_G}$, $0<\alpha_G<1-\alpha$ ($K^G_t$ y $\alpha_G$ locales: el capital público es un stock, frente al flujo $G_t$ de Barro, 1990; 3 efectos; con $\alpha_G=1-\alpha$, crecimiento endógeno).

**Evidencia:** acierta en el signo de la producción y las horas, falla en el consumo, que **sube** en los VAR (Blanchard y Perotti, 2002; Galí, López-Salido y Vallés, 2007): lo intenta cerrar la NEK con hogares que viven al día. Ramey (2011) no se cita (no comprobado, A38-12); Campbell (1994, «1/10») tampoco (A38-04).

**Valoración:** mecanismo microfundamentado (efecto riqueza) y lo que importa es el gasto y cómo se financia, no el déficit; en contra, el consumo cae, la elasticidad del trabajo que hace falta es mayor que la micro (`\vertema{3.A.25}`) y el ciclo es eficiente: no hay nada que estabilizar.

**Calibración y simulación:** modelo log-linealizado, Blanchard-Kahn, $\alpha=1/3$, $\beta=0{,}99$, $\delta=0{,}025$, $\theta=\varphi=1$, $G/Y=0{,}2$ (Prescott, 1986; Hansen y Wright, 1992). Script `fuentes/3A38/graficos/irf-rbc-gasto.py` y datos `fuentes/3A38/datos/irf-rbc-gasto.csv`.

**Gráfico de referencia:** `oposicion/temario/fuentes/3A38/graficos/irf-rbc-gasto.tex` (simulación propia; sustituye a la figura de un preparador). Panel a) $Y$, $C$, $I$ en puntos del PIB con suma fija y $\rho_G=0{,}95$ (continuas) o $\rho_G=0$ (discontinuas); b) horas y salario real; c) producción con suma fija frente a impuesto sobre el trabajo. Imprescindible en el cante del 3.A.38: el panel a, trazo a trazo. Tabla de referencia: `tab:gasto-rbc` (los 3 casos en el impacto).

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.38 | Política fiscal: efectos sobre el crecimiento y el ahorro | **desarrollo (referencia; hecho, 5/11/2026)** | I.2 completo (5′ en el cante): lo de arriba, con `irf-rbc-gasto` y `tab:gasto-rbc`; anexo B paso a paso | El RBC base (`\vertema{3.A.42}`) |
| 4.B.4 | Presupuesto compensador y estabilización | resumen | Efecto riqueza, multiplicador positivo y < 1, mayor si el gasto es persistente, negativo con impuestos distorsionantes; contraste con la NEK; las cifras 0,03/0,32/−0,68 si se quiere, con la calibración; `\vertema{3.A.38}` para ampliar | Las ecuaciones completas; la restricción del Estado con otros índices |
| 3.A.40 | Teoría de los multiplicadores | resumen (hecho, 5/11/2026) | El efecto riqueza y la persistencia, con `BaxterKing1993Fiscal`, **«positivo y menor que 1, mayor si el gasto es persistente»**, nunca «≈ 0»; a largo plazo con gasto permanente, 0,75 en la calibración de referencia y > 1 con trabajo más elástico; `\vertema{3.A.38}` (hoy remite solo al 3.A.42) | El modelo con sector público |
| 3.A.42 | Ciclo real | mención (hecho, 4/11/2026) | El gasto como extensión del RBC base con $-G_t$ en la acumulación | El modelo con sector público |
| 3.A.6 | NMC: ciclo real | mención (hecho, 4/11/2026) | El gasto público como perturbación real que mejora el ajuste | El modelo con sector público |

## Divergencias encontradas en el temario actual
- **Resuelto en el 3.A.38 (5/11/2026):** Word con $W_t$, $R_t$, ζ, $(1/(1+\rho))^t$, «E», AR(1) con $\rho_A\in(-1,1)$, $\tau_t$ como pago de suma fija («ninguna condición depende de $\tau_t$») y la restricción $G_t+r_{t-1}D_t\le T_t+D_{t+1}-D_t$; ahora $w_t$, $r_t+\delta$, χ, β, $\mathbb E_t$, `eq:rbc-gasto`, $T_t$ recaudación y $\tau_{L,t}$, $\tau_{K,t}$ tipos, `eq:rbc-gobierno` con $D_t$ al final de $t$ y $r^D_{t-1}$.
- **Resuelto en esta ficha (5/11/2026):** la Euler con $1+R_{t+1}-\delta$ (ahora $1+(1-\tau_{K,t+1})r_{t+1}$, como `rbc`), «no hay `.tex` todavía» (ahora `irf-rbc-gasto`), «Sims 2015» en el título.
- 4.B.4 (sin revisar): la restricción del gobierno con índices distintos en el RBC ($D_{t+1}$) y en la NEK ($D_{t-1}$) del mismo tema; «ninguna condición depende de $\tau_t$» con solo suma fija; descuento ρ; los efectos no keynesianos 2 veces. Al revisarlo: la presentación de arriba en resumen.
- 3.A.40: **resuelto en su revisión (5/11/2026)**: remite el RBC con gasto al 3.A.42 y al 3.A.38 (`\vertema{3.A.42} \vertema{3.A.38}`, D088); «positivo y menor que 1, mayor si el gasto es persistente»; no da las cifras de `tab:gasto-rbc`.
- Clave duplicada: el 3.A.44 cita `BaxterKing1993` (l. 402); el resto, `BaxterKing1993Fiscal` (`pendientes-coherencia.md`, Pendiente del 3.A.38).

Autor: Víctor Gutiérrez Marcos
