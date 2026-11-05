# Restricción presupuestaria del sector público y dinámica de la deuda

- **Área:** macro cerrada · **Tema de referencia:** 3.A.39 (Déficit público: financiación, dominación monetaria y fiscal, dinámica y sostenibilidad de la deuda) — lo tiene en el título. **Hecho (revisado el 4/11/2026):** I.1 (restricción en nivel, en % del PIB y solvencia, con las 2 funciones clave del tema), bloque II entero (sostenibilidad, saldo estabilizador, diagrama de fases, implicaciones, España, Bohn, DSA y el debate $r-\gamma_Y$) y anexo A (Tesoro y banco central por separado, inflación no esperada).
- **Temas que lo usan:** 3.A.39 (desarrollo; hecho, 4/11/2026), 4.B.26 (desarrollo aplicado a España: descomposición de la variación de la deuda), 3.A.35 y 3.A.41 (resumen dentro del señoreaje), 4.B.4 (mención en el NEK con gasto), 1D01 (uso: VI.2, `eq:dinamica-deuda`), 3.B.12 (mención: la misma ecuación para la deuda externa; sin revisar), 3.A.38 (mención; hecho, 5/11/2026: `eq:rbc-gobierno` del ciclo real con gasto, $G_t+r^D_{t-1}D_{t-1}=T_t+\tau_{L,t}w_tL_t+\tau_{K,t}r_tK_t+(D_t-D_{t-1})$, en niveles reales, con $D_t$ al final de $t$ y $r^D_{t-1}$ *ex ante*; el no juego de Ponzi en el anexo B; `\vertema{3.A.39}`; ficha `rbc-sims`). También 3.A.6 (mención; hecho, 4/11/2026: anexo C, la solvencia en % del PIB, $d_{t-1}=\sum_k[(1+\gamma_Y)/(1+r)]^{k+1}(\tau_{t+k}-g_{t+k}+s_{t+k})$, con $r>\gamma_Y$, para la aritmética monetarista; `\vertema{3.A.39}`), 3.A.44 (mención; hecho, 1/11/2026: l. 364, presupuesto equilibrado en el modelo de Barro, «a largo plazo el Estado no puede gastar más de lo que ingresa», `\vertema{3.A.39}`; le falta el matiz de la solvencia, `pendientes-coherencia.md`), 3.A.29 (mención; hecho, 1/11/2026: l. 678, con $r<\gamma_Y$ la deuda se puede renovar, Blanchard, 2019), 3.A.36 (mención; en revisión: la independencia necesita que alguien cierre la restricción, l. 240). También 3.A.40 (mención; hecho, 5/11/2026: III.3 c), $d^*=(g-\tau)(1+\gamma_Y)/(\gamma_Y-r)$ con $r<\gamma_Y$, `eq:deuda-estable`, `\vertema{3.A.39}` `\vertema{3.A.29}`; $r-\gamma_Y$ con el tipo implícito de AMECO, nota frente al −1,2 de Eurostat del 3.A.39, A40-06).
- **Manuales de referencia:** Walsh (2017), cap. 4; Blanchard y Fischer (1989), cap. 10; Sargent y Wallace (1981); Blanchard, *Macroeconomics* (8.ª ed.), cap. 22; Blanchard (2019), «Public Debt and Low Interest Rates», *AER*; Bohn (1998); FMI (2021), marco de sostenibilidad; Esteve y Prats (2023).
- **Decisión D028 (13/10/2026):** ¿Cómo se escriben los intereses de la deuda en la restricción del gobierno? i_{t−1}D_{t−1} (Walsh: la deuda emitida en t−1 paga el tipo pactado al emitirla); i_t D_{t−1} solo si i_t se define como tipo implícito pagado en t (así la descomposición con datos, `eq:descomposicion-deuda` del 3.A.39 y `eq:dinamica-deuda` de la 1D01).
- **Decisión A39-08 (4/11/2026, [decidir]):** $r$ es el tipo real ***ex ante***, como `notacion.md` § 8 ($r_t\equiv i_t-\mathbb{E}_t[\pi_{t+1}]$): $1+r_{t-1}\equiv(1+i_{t-1})/(1+\mathbb{E}_{t-1}[\pi_t])$. Con una inflación igual a la esperada coincide con el *ex post*, $\bar r_{t-1}$, que solo sale en el anexo A del 3.A.39 (local, con barra). La ficha decía antes «$r_t$ tipo real ex post»: corregido. *Alternativa* (C2 de la coherencia del 3.A.39): $r$ sin subíndice en la aproximación y la fila «$r$ es el tipo real que paga la deuda, *ex post*».

## Presentación de referencia

**Pregunta:** ¿cómo se financia el déficit y cuándo es sostenible la deuda?

**Supuestos:** Tesoro y banco central consolidados (la derivación por separado, con $D^{\mathrm T}$, $D^{\mathrm M}$ y las transferencias de beneficios $\mathrm{TBC}_t$, en el anexo A del 3.A.39); $D_t$ deuda nominal en manos del público a final de $t$, emitida a un periodo; $M_t$ base monetaria; la deuda emitida en $t-1$ paga en $t$ el tipo $i_{t-1}$ fijado al emitirla. $G_t$ gasto sin intereses, $T_t$ ingresos (las tasas y multas, dentro; la venta de patrimonio reduce la deuda, no el déficit).

**Restricción en nivel** (`eq:restriccion-nivel`, 3 fuentes: impuestos, deuda, dinero):

$$\underbrace{G_t + i_{t-1}D_{t-1}}_{\text{gastos}} = T_t + (D_t - D_{t-1}) + (M_t - M_{t-1})$$

**En porcentaje del PIB** (`\funcionclave` `eq:restriccion-ratios`, exacta en nominal; g_t = G_t/P_tY_t, τ_t = T_t/P_tY_t, d_t = D_t/P_tY_t, s_t = (M_t − M_{t−1})/P_tY_t; 1+γ^N_t = (1+π_t)(1+γ_{Y,t}); D_{t−1}/(P_tY_t) = d_{t−1}/(1+γ^N_t)):

$$d_t - d_{t-1} = \underbrace{(g_t - \tau_t)}_{\text{déficit primario}} - s_t + \underbrace{\frac{i_{t-1} - \gamma^N_t}{1+\gamma^N_t}\,d_{t-1}}_{\text{efecto bola de nieve}}$$

**En términos reales** (`eq:restriccion-real`): con el tipo real *ex ante* y la inflación igual a la esperada, $(1+i_{t-1})/(1+\gamma^N_t)=(1+r_{t-1})/(1+\gamma_{Y,t})$ (igualdad, no aproximación), y

$$d_t - d_{t-1} = (g_t - \tau_t) - s_t + \frac{r_{t-1} - \gamma_{Y,t}}{1+\gamma_{Y,t}}\,d_{t-1}.$$

Regla: **nunca mezclar** tipo nominal con crecimiento real ni al revés. La inflación no esperada, en un término aparte (`eq:inflacion-sorpresa`, anexo A del 3.A.39): $-\frac{(1+r_{t-1})(\pi_t-\mathbb{E}_{t-1}[\pi_t])}{(1+\pi_t)(1+\gamma_{Y,t})}d_{t-1}$. Déficit total = primario + $i_{t-1}D_{t-1}/(P_tY_t)$. **Déficit operativo** (`eq:deficit-operativo`): $G_t+(i_{t-1}-\pi_t)D_{t-1}-T_t$.

**Solvencia** (`\funcionclave` `eq:solvencia`; $r$ y $\gamma_Y$ constantes, sin subíndice; condición de no-Ponzi $\lim_{K\to\infty}[(1+\gamma_Y)/(1+r)]^{K+1}d_{t+K}=0$; índice de suma $k$):

$$d_{t-1} = \sum_{k=0}^{\infty}\left(\frac{1+\gamma_Y}{1+r}\right)^{k+1}\left(\tau_{t+k} - g_{t+k} + s_{t+k}\right)\qquad (r>\gamma_Y)$$

La deuda se valora «como una acción». Con $\gamma_Y=0$, la forma de Walsh. Si $r<\gamma_Y$ la suma no converge: la ratio se estabiliza sin superávits primarios (Blanchard, 2019). En el 3.A.39 la solvencia es el hilo y se lee **3 veces**: restricción de los impuestos (equivalencia ricardiana, suavización), condición de sostenibilidad ($r$ frente a $\gamma_Y$), reparto entre las 2 autoridades (dominación; la FTPL la reescribe como `eq:valoracion`, ficha `ftpl`).

**Saldo primario estabilizador** (`eq:saldo-estabilizador`, sin señoreaje ni sorpresa, $d_t=d_{t-1}=d$):

$$\tau - g = \frac{i-\gamma^N}{1+\gamma^N}\,d = \frac{r-\gamma_Y}{1+\gamma_Y}\,d$$

Ejemplo de referencia: España 2025, deuda inicial 101,4 %, tipo implícito 2,5 %, $\gamma^N$ 5,7 % ⇒ $\tau-g\approx-3{,}1$ (Eurostat, notificación de octubre de 2026).

**Dinámica** (`eq:dinamica-fases`, ecuación en diferencias): $d_t=(g-\tau)+\frac{1+r}{1+\gamma_Y}d_{t-1}$; estado estacionario $d^*=\frac{(g-\tau)(1+\gamma_Y)}{\gamma_Y-r}$, estable si $r<\gamma_Y$, inestable si $r>\gamma_Y$. **4 casos** (numeración fija): 1 déficit primario y $r<\gamma_Y$ (converge a $d^*>0$); 2 superávit y $r<\gamma_Y$ ($d^*<0$); 3 déficit y $r>\gamma_Y$ (bola de nieve, diverge); 4 superávit y $r>\gamma_Y$ (umbral $d^*>0$ inestable). **Se cantan el 3 y el 4.**

**Descomposición con datos** (`eq:descomposicion-deuda`, Esteve y Prats, 2023): $d_t-d_{t-1}=(g_t-\tau_t)+\frac{i_t-\gamma^N_t}{1+\gamma^N_t}d_{t-1}+\mathrm{ADD}_t$, con $i_t$ **tipo implícito** (intereses de $t$ sobre la deuda de final de $t-1$; por eso subíndice $t$) y $\mathrm{ADD}_t$ el ajuste déficit-deuda.

**Extensiones** (3.A.39, II.6): **test de Bohn (1998)**, $\tau_t-g_t=\psi d_{t-1}+\dots$, sostenible si $\psi>(r-\gamma_Y)/(1+\gamma_Y)$ (es la política fiscal **pasiva** de Leeper, ficha `ftpl`; ψ local, avisada); **DSA** del FMI (gráficos de abanico, necesidades brutas, riesgo bajo/moderado/alto) y de la Comisión (*Debt Sustainability Monitor*; base de la senda de gasto de las reglas de 2024); **umbrales** (Reinhart y Rogoff, 2010, y la réplica de Herndon, Ash y Pollin, 2014: no hay umbral claro); **el debate $r-\gamma_Y$** («$r-g$» solo como nombre del debate; Blanchard, 2019; Mauro y Zhou, 2020; estancamiento secular, ficha `estancamiento-secular`). Liquidez, solvencia y sostenibilidad (FMI, 2021) como 3 conceptos distintos; equilibrios múltiples (Calvo, 1988; De Grauwe, 2011; OMT y TPI).

**Gráfico de referencia:** diagrama de fases $d_t$ frente a $d_{t-1}$ con la bisectriz y la recta de pendiente $(1+r)/(1+\gamma_Y)$ y ordenada en el origen $g-\tau$, **2 paneles: caso 3 (diverge) y caso 4 (umbral $d^*$)**, `fuentes/3A39/graficos/dinamica-deuda.tex`; los casos 1 y 2 ($r<\gamma_Y$, estables) en `fuentes/3A39/graficos/dinamica-deuda-r-menor.tex`, que no se canta. Gráficos de datos de España (no de referencia): `descomposicion-deuda-espana.tex`, `deuda-pde-espana-zona-euro.tex`, `bola-nieve-espana.tex` y `saldo-primario-espana.tex` en `fuentes/3A39/graficos/` (CSV en `fuentes/3A39/datos/`).

## Cómo se adapta en cada tema

| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.39 | Financiación del déficit y sostenibilidad | Desarrollo (hecho, 4/11/2026) | `eq:restriccion-nivel`, `eq:restriccion-ratios` y `eq:solvencia` (las 2 funciones clave), `eq:restriccion-real` con $r$ ex ante, tabla de conceptos (`tab:conceptos-deficit`, saldos $b$…), déficit operativo, saldo estabilizador con España 2025, diagrama de fases (casos 3 y 4), implicaciones (6 vías, equilibrios múltiples, reglas de 2024), España con la descomposición 1996-2025, Bohn, DSA, umbrales, $r-\gamma_Y$; anexo A con Walsh y la sorpresa | — |
| 4.B.26 | Financiación del sector público español | Desarrollo aplicado | Versión de Walsh con Tesoro y banco central separados ($D^{\mathrm T}$, $D^{\mathrm M}$, $\mathrm{TBC}_t$, como el anexo A del 3.A.39); descomposición de Esteve y Prats con el tipo implícito $i_t$ (`eq:descomposicion-deuda`) | La derivación de la solvencia (resumirla y remitir a 3.A.39) |
| 3.A.35 | Demanda de dinero | Mención | Solo para definir el señoreaje $S_t=(M_t-M_{t-1})/P_t$ (`eq:senoreaje` del 3.A.39) | La restricción completa |
| 3.A.41 | Hiperinflación | Resumen | Déficit financiado con dinero → señoreaje → Cagan, con $i_{t-1}D_{t-1}$ | La dinámica de la deuda |
| 4.B.4 | Política fiscal en el NEK | Mención | Restricción en términos reales con $r_{t-1}$ ex ante | — |
| 1D01 | Dictamen de coyuntura | Uso (aprobada) | $d_t-d_{t-1}=(g_t-\tau_t)+\frac{i_t-\gamma^N_t}{1+\gamma^N_t}d_{t-1}+\mathrm{ADD}_t\approx(g_t-\tau_t)+\frac{r_t-\gamma_{Y,t}}{1+\gamma_{Y,t}}d_{t-1}+\mathrm{ADD}_t$ (sin señoreaje en el euro; $i_t$ implícito, de modo que su $r_t$ es el real implícito, coherente con la convención de D028), bola de nieve, saldo primario estabilizador con ejemplo. No está en `temario.json`: el 3.A.39 no la enlaza con `\vertema` (K32) | La solvencia intertemporal |
| 3.A.6 | NMC: aritmética monetarista | Mención (hecho, 4/11/2026) | La solvencia con saldos primarios y señoreaje en % del PIB, la misma de `eq:solvencia` | La derivación |
| 3.A.44 | Crecimiento endógeno con sector público (Barro, 1990) | Mención (hecho, 1/11/2026) | Presupuesto equilibrado $G_t=\tau Y_t$; la restricción como motivo, con el matiz «en valor actual y si el tipo supera al crecimiento» (pendiente) | — |
| 3.A.29 | OLG y deuda | Mención (hecho, 1/11/2026) | Con $r<\gamma_Y$ la deuda se renueva (Blanchard, 2019), coherente con II.6 del 3.A.39 | — |
| 3.B.12 | Deuda externa | Mención (sin revisar) | La misma ecuación con la balanza por cuenta corriente (ficha `sostenibilidad-deuda-externa`) | — |

## Divergencias encontradas en el temario actual

- **Intereses i_{t−1}D_{t−1} frente a i_t D_{t−1}:** canon **i_{t−1}D_{t−1}** (D028). La forma i_t D_{t−1} solo con i_t tipo implícito pagado en t (descomposición con datos del 3.A.39 y de la 1D01; 4.B.26 debe decirlo). **3.A.39 resuelto** (4/11/2026): también en el señoreaje.
- **3.A.39 resuelto** (4/11/2026): γ^Y nominal combinado con r real → $\gamma^N_t$ con $i_{t-1}$ (exacta) y $\gamma_{Y,t}$ con $r_{t-1}$; Τ (tau mayúscula) → $T_t$; índice de suma $i$ → $k$; $\mathrm{E}_{t-1}$ → $\mathbb{E}_{t-1}$; solvencia con el factor $(1+\gamma_Y)/(1+r)$, que el Word no tenía (descontaba a $1/(1+r)^i$ sin crecimiento); la deuda como $b$ en el ejemplo → $d$; el caso 4 decía $r<\gamma$ en el texto y $r>\gamma$ en la imagen → $r>\gamma_Y$; España 2022 mezclaba nominal y real.
- **Señoreaje:** «Señoreaje» sin símbolo (3.A.35), s_t (4.B.26): canon **S_t** en nivel real y **s_t** en % del PIB.
- **Copia:** el bloque restricción-señoreaje-Cagan está casi literal en 3.A.35, 3.A.39 y 3.A.41: desarrollado en 3.A.39 (restricción, hecho) y 3.A.41 (Cagan); los otros 2 remiten.
- **3.A.44** (revisado, l. 364): «A largo plazo el Estado no puede gastar más de lo que ingresa» es cierto en valor actual y con $r>\gamma_Y$; con $r<\gamma_Y$ cabe un déficit primario permanente (`pendientes-coherencia.md`, Pendiente del 3.A.39).

Autor: Víctor Gutiérrez Marcos
