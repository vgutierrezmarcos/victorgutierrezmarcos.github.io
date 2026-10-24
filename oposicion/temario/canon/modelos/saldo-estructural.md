# Saldo cíclico, cíclicamente ajustado y estructural (método de la Comisión Europea)

- **Área:** sector público · **Tema de referencia:** 4.B.4 — está en el título («saldo cíclico, saldo estructural y esfuerzo fiscal»).
- **Temas que lo usan:** 4.B.4 (desarrollo), 1D01 (uso: VI.2, saldos, tono e impulso fiscal; anexos A y E), 4.B.1 (mención), 4.B.21 (mención: límite de déficit estructural de la LOEPSF), 4.B.26 (resumen: evolución del saldo estructural de España), 3.B.45 (gobernanza fiscal de la UE: ficha `pec`)
- **Manuales de referencia:** Mourre et al. (2013, 2019), *European Economy*; Havik et al. (2014), PIB potencial de la Comisión (función de producción, NAWRU); Comisión Europea, *Vade Mecum on the Stability and Growth Pact* y, desde 2024, el marco del Reglamento (UE) 2024/1263; AIReF, informes sobre el saldo estructural; Blanchard, cap. 22.
- **Decisión D029 (13/10/2026):** ¿Cómo se escriben el saldo presupuestario y sus componentes? b (% PIB, positivo = superávit); b^c cíclico, b^{ca} cíclicamente ajustado, b^e estructural, b^p primario; semielasticidad ε (b^c = ε·OG); brecha OG

## Presentación de referencia
**Pregunta:** ¿qué parte del saldo se debe al ciclo y cuál a decisiones de política? ¿Cuál es la orientación (tono) de la política fiscal?

**Ecuaciones (notación canónica, todo en % del PIB, $b>0$ superávit):**
$$b^{c}_t=\varepsilon\cdot OG_t,\qquad b^{ca}_t=b_t-\varepsilon\cdot OG_t,\qquad b^{e}_t=b^{ca}_t-\text{medidas puntuales},\qquad b^{pe}_t=b^{e}_t+\text{intereses}_t ,$$
con $\mathrm{OG}_t=(Y_t-Y^p_t)/Y^p_t\times100$ (ficha `brecha-produccion`; $Y^p$ PIB potencial, D-05 de la 1D01: el asterisco es el extranjero) y $\varepsilon$ la semielasticidad del saldo ($\approx 0{,}6$ para España [comprobar dato vigente]). **Esfuerzo fiscal** (u orientación, tono): $\Delta b^{pe}_t$; positivo = contractiva, $\approx0$ neutral (deja actuar a los estabilizadores, sea cual sea el nivel del saldo); **impulso fiscal** (FMI) $=-\Delta b^{pe}_t$.

**Resultado:** el saldo estructural es la referencia de las reglas (art. 135 CE, LOEPSF, Tratado de Estabilidad); su gran debilidad es la incertidumbre del PIB potencial y de la NAWRU (revisiones, prociclicidad). Por eso el marco de la UE de 2024 sustituye el objetivo de saldo estructural por una **senda de gasto primario neto** como único indicador operativo.

**Ejemplo coherente (España, 2022, cifras del tema):** $b=-4{,}8$; $b^{c}=-1{,}0$ ⇒ $b^{ca}=-3{,}8$; con medidas puntuales de $-0{,}2$ ⇒ $b^{e}=-3{,}6$ [comprobar con AIReF/Comisión].

**Gráficos de referencia:** estimaciones de la brecha de producción (Comisión, FMI, OCDE, AIReF); saldo total, cíclico y estructural en el tiempo. No hay `.tex` todavía.

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 4.B.4 | Saldo cíclico, estructural y esfuerzo fiscal | Desarrollo | Todo lo anterior, PIB potencial, críticas y marco 2024 | — |
| 4.B.1 | Saldos en contabilidad nacional | Mención | Definir capacidad/necesidad de financiación y **saldo primario = saldo + intereses**; «[ver tema 4.B.4]» | La descomposición |
| 4.B.21 | LOEPSF | Mención | Límites: ninguna AP con déficit estructural; 0,4 % del PIB para el conjunto con reformas estructurales (art. 11) | El cálculo |
| 4.B.26 | Evolución del saldo en España | Resumen | Serie de saldo total y estructural; esfuerzo por etapas | El método |
| 1D01 | Dictamen de coyuntura | Uso | $b$, $b^p$, $b^{ca}=b-\varepsilon\cdot\mathrm{OG}$, $b^e$, $b^{pe}$; tono por $\Delta b^{pe}$ (no por el nivel); medida puntual definida sin el ejemplo de los ERTE | El método de la Comisión |

## Divergencias encontradas en el temario actual
- **Error de signo en 4.B.4 (España 2022):** con déficit $-4{,}8$ y saldo cíclico $-1$, el saldo cíclicamente ajustado es $-3{,}8$ (no $-5{,}8$) y el estructural $-3{,}6$ (no $-6$). Además infiere el tono expansivo del **nivel** del déficit estructural, cuando el tono se mide por su **variación**. **Corregir.**
- 4.B.4: falta el «esfuerzo fiscal» como concepto propio, aunque está en el título.
- 4.B.1: «saldo primario = saldo − servicio de la deuda»; debe ser saldo excluidos los intereses (con déficit: déficit primario = déficit − intereses).
- Notación: $B_t$ (choca con bonos), $\eta$ (choca con Calvo), «elasticidad»/«semielasticidad» mezcladas. Propuesta: $b$, $\varepsilon$, «semielasticidad».
- **Límites de déficit estructural (0,5 % frente a 0,4 %):** ver `loepsf.md`.
- **Esta ficha** escribía $OG_t=(Y_t-Y^*_t)/Y^*_t$: corregido a $Y^p$ el 24/10/2026 (D-05 de la 1D01; el asterisco es el extranjero, § 0).
- 4.B.4 (Word) remite el filtro de Hodrick-Prescott a «[ver tema 3.A.41]»: es el **3.A.42**.
