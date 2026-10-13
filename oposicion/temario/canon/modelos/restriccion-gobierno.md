# Restricción presupuestaria del sector público y dinámica de la deuda

- **Área:** macro cerrada · **Tema de referencia:** 3.A.39 (Déficit público: financiación, dominación monetaria y fiscal, dinámica y sostenibilidad de la deuda) — lo tiene en el título.
- **Temas que lo usan:** 3.A.39 (desarrollo), 4.B.26 (desarrollo aplicado a España: descomposición de la variación de la deuda), 3.A.35 y 3.A.41 (resumen dentro del señoreaje), 4.B.4 (mención en el NEK con gasto).
- **Manuales de referencia:** Walsh (2017), cap. 4; Blanchard y Fischer (1989), cap. 10; Sargent y Wallace (1981); Blanchard, *Macroeconomics* (8.ª ed.), cap. 22; Blanchard (2019), «Public Debt and Low Interest Rates», *AER*; Esteve y Prats (2023).
- **Decisión D028 (13/10/2026):** ¿Cómo se escriben los intereses de la deuda en la restricción del gobierno? i_{t−1}D_{t−1} (Walsh: la deuda emitida en t−1 paga el tipo pactado al emitirla); i_t D_{t−1} solo si i_t se define como tipo implícito pagado en t

## Presentación de referencia

**Pregunta:** ¿cómo se financia el déficit y cuándo es sostenible la deuda?

**Supuestos:** Tesoro y banco central consolidados; D_t deuda nominal en manos del público a final de t, emitida a un periodo; M_t base monetaria; la deuda emitida en t−1 paga en t el tipo i_{t−1} fijado al emitirla.

**Restricción en nivel (flujo):**

$$G_t + i_{t-1}D_{t-1} = T_t + (D_t - D_{t-1}) + (M_t - M_{t-1})$$

**En ratios sobre el PIB nominal** (g_t = G_t/P_tY_t, τ_t = T_t/P_tY_t, d_t = D_t/P_tY_t, s_t = (M_t − M_{t−1})/P_tY_t; 1+γ^N_t = (1+π_t)(1+γ_{Y,t})):

$$d_t - d_{t-1} = (g_t - \tau_t) - s_t + \frac{i_{t-1} - \gamma^N_t}{1+\gamma^N_t}\,d_{t-1} \;\approx\; (g_t - \tau_t) - s_t + \frac{r_t - \gamma_{Y,t}}{1+\gamma_{Y,t}}\,d_{t-1}$$

con r_t tipo real ex post. El último término es el **efecto bola de nieve**; en datos se añade el ajuste déficit-deuda (ADD).

**Estado estacionario:** d estable si el superávit primario es (τ − g) + s = [(r − γ_Y)/(1 + γ_Y)] d. **Solvencia** (con r > γ_Y y condición no-Ponzi):

$$d_{t-1} = \sum_{k=0}^{\infty}\left(\frac{1+\gamma_Y}{1+r}\right)^{k+1}\left(\tau_{t+k} - g_{t+k} + s_{t+k}\right)$$

Si r < γ_Y la deuda se estabiliza sola con déficit primario constante (Blanchard 2019; ver `estancamiento-secular`).

**Gráfico de referencia:** diagrama de fases d_t frente a d_{t−1} con la bisectriz: recta de pendiente (1+r)/(1+γ_Y) más el déficit primario; inestable si r > γ_Y (la deuda diverge salvo superávit), estable si r < γ_Y.

## Cómo se adapta en cada tema

| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.39 | Financiación del déficit y sostenibilidad | Desarrollo | Restricción en nivel y en ratios, fuentes de financiación, solvencia intertemporal, diagrama de fases; base de la aritmética monetarista y la FTPL | — |
| 4.B.26 | Financiación del sector público español | Desarrollo aplicado | Versión de Walsh con Tesoro y banco central separados (D^T, D^M, transferencia de beneficios del banco central); descomposición de Esteve y Prats con el tipo implícito de la deuda | La derivación de la solvencia (remitir a 3.A.39) |
| 3.A.35 | Demanda de dinero | Mención | Solo para definir el señoreaje S_t = (M_t − M_{t−1})/P_t | La restricción completa |
| 3.A.41 | Hiperinflación | Resumen | Déficit financiado con dinero → señoreaje → Cagan | La dinámica de la deuda |
| 4.B.4 | Política fiscal en el NEK | Mención | Restricción en términos reales con r_{t−1}D_{t−1} | — |

## Divergencias encontradas en el temario actual

- **Intereses i_{t−1}D_{t−1} frente a i_t D_{t−1}:** 3.A.39 (restricción principal) y 4.B.26 usan i_{t−1}D_{t−1}; 3.A.35, 3.A.41 y la sección de señoreaje de 3.A.39 usan i_t D_{t−1}. Canon: **i_{t−1}D_{t−1}** (Walsh; la deuda emitida en t−1 paga el tipo pactado en t−1). La forma i_t D_{t−1} solo es correcta si i_t se define como tipo implícito pagado en t (así en la descomposición de 4.B.26, que debe decirlo).
- **3.A.39** define γ^Y como crecimiento **nominal** del PIB pero lo combina con r (real) en (r_{t−1} − γ^Y_t)/(1+γ^Y_t): o i con nominal o r con real. 4.B.26 lo hace bien (real con real).
- **3.A.39** escribe los impuestos con T latina y con Τ (tau mayúscula griega): uniformar a **T_t**.
- **Señoreaje:** «Señoreaje» sin símbolo (3.A.35), s_t (4.B.26): canon **S_t** en nivel real y **s_t** en % del PIB.
- **Copia:** el bloque restricción-señoreaje-Cagan está casi literal en 3.A.35, 3.A.39 y 3.A.41: desarrollar en 3.A.39 (restricción) y 3.A.41 (Cagan), y remitir.

Autor: Víctor Gutiérrez Marcos
