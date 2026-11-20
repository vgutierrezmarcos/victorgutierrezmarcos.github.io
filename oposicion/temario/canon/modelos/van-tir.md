# Criterios VAN y TIR

- **Área:** finanzas-empresa · **Tema de referencia:** 3.B.2 (La empresa y las decisiones de inversión: criterios de valoración de proyectos) — lo tiene en el título; 4.B.6 lo aplica al análisis coste-beneficio público.
- **Temas que lo usan:** 3.B.2 (desarrollo; revisado el 8/11/2026), 3.B.4 (mención: valoración por descuento de flujos; ficha `dcf`), 3.B.24 (mención: la TIR del bono es su rentabilidad a vencimiento; ficha `precio-bono`), 4.B.6 (desarrollo → resumen con la tasa social de descuento), 3.A.34 (mención; hecho, 31/10/2026: la EMgK de Keynes es la TIR, con la nota de que el orden por TIR puede no coincidir con el del VAN; con irreversibilidad e incertidumbre la regla $V\ge I$ falla, ficha `opciones-reales`; `\vertema{3.B.2}` en I.1, III.3 y la conclusión), 3.A.25 (mención; hecho: la decisión de formarse como un VAN)
- **Manuales de referencia:** Brealey, Myers y Allen, *Principles of Corporate Finance*, caps. 2, 5-6; Berk y DeMarzo, *Corporate Finance*, caps. 4 y 7; Suárez Suárez, *Decisiones óptimas de inversión y financiación en la empresa*; Boardman et al., *Cost-Benefit Analysis* (para 4.B.6).

## Presentación de referencia
**Pregunta:** ¿qué proyectos debe acometer la empresa?

**Supuestos:** flujos de caja ciertos (o en equivalente cierto), tasa de descuento = coste de oportunidad del capital ($WACC$ si el proyecto tiene el riesgo medio de la empresa), mercado de capitales perfecto (Fisher).

**Ecuaciones (notación canónica):**
$$VAN = -I_0 + \sum_{t=1}^{n}\frac{FC_t}{(1+k)^t} + \frac{VR}{(1+k)^n}, \qquad -I_0 + \sum_{t=1}^{n}\frac{FC_t}{(1+TIR)^t} + \frac{VR}{(1+TIR)^n} = 0$$
TIR modificada: $\big(\sum_t FC_t(1+k)^{n-t}\big)/I_0 = (1+TIRM)^n$; *payback* $= I_0/FC$ con flujos constantes.

**Resultado:** el VAN es el criterio coherente con maximizar el valor; la TIR puede ordenar mal proyectos excluyentes (escala, calendario: punto de Fisher) y puede ser múltiple o no existir.

**Gráfico de referencia:** `oposicion/temario/fuentes/3B02/graficos/van-fisher.tex` (VAN en función de $k$ para dos proyectos, con las TIR y el punto de Fisher, $k^{\mathrm F}=15{,}2$ %; pasada final, nov. 2026).

**Nombre y notación (3.B.2, 8/11/2026):** «**tasa interna de rentabilidad** (TIR)», como el 3.A.34 (nunca «de rendimiento»). $k^{\mathrm F}$ tasa de Fisher; en la TIRM, $VA^{-}$ (valor actual de los flujos negativos) y $VF^{+}$ (valor final de los positivos); con racionamiento, $\mathrm{IVAN}=\mathrm{VAN}/I_0$; equivalente cierto $\xi_t=\alpha_t\,\mathbb{E}[FC_t]$ descontado a $r_f$ (α_t local: no es la α de Jensen); la tasa ajustada al riesgo se escribe sin ρ ni «WACC + prima»; $\mathrm{VAN}(n)$ y $\mathrm{VAN}_\infty(n)$ en la renovación de equipos (ficha `mapi`). $I_0$ es siempre el desembolso (D085), nunca los fondos netos de la deuda.

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.B.2 | Criterios de valoración de proyectos | desarrollo (hecho, 8/11/2026) | VAN, TIR, TIRM con $VA^-$ y $VF^+$, *payback*, IVAN con racionamiento; riesgo (tasa ajustada sin ρ, equivalente cierto $\xi_t$); gráfico `van-fisher` | — |
| 3.B.4 | Valoración de empresas | mención | El DCF es un VAN de la empresa (ficha `dcf`) | Los criterios |
| 3.B.24 | Bonos | mención | La TIR del bono es su rentabilidad a vencimiento; el precio es el desembolso que hace nulo el VAN (ficha `precio-bono`) | Los criterios |
| 3.A.34 | Teorías de la inversión | mención (hecho, 31/10/2026) | EMgK ≈ TIR; el VAN falla con irreversibilidad e incertidumbre | Los criterios |
| 4.B.6 | Análisis coste-beneficio | resumen aplicado | $VAN = \sum_t (B_t - C_t)/(1+\delta)^t$ con tasa social de descuento $\delta$; TIR y sus problemas en una línea [ver tema 3.B.2] | Punto de Fisher y TIRM completos |

## Divergencias encontradas en el temario actual
- **Resuelto en el 3.B.2 (8/11/2026):** desembolso $A$ → $I_0$; «tasa interna de rendimiento» → «de rentabilidad». Sigue pendiente el 3.A.25 (l. 750, «tasa interna de rendimiento»; `pendientes-coherencia.md`).
- Desembolso $A$ y flujos $Q_t$ en 3.B.2 (original) frente a $B_t - C_t$ en 4.B.6 y $FC_t$/$FCL_t$ en 3.B.4. Canon: $I_0$ y $FC_t$ en finanzas; $B_t$, $C_t$ y $\delta$ en ACB público.
- Tasa de descuento $k$, $WACC$ o $r$ usados indistintamente en 3.B.2: canon $k$ (genérica) y $WACC$ cuando se use el coste medio ponderado.
- 3.B.2 (sin revisar): «el método del VAN asume irreversibilidad»: mejor «**supone que la inversión es reversible o que es de ahora o nunca**» (Dixit y Pindyck, 1994, cap. 1); con irreversibilidad e incertidumbre la regla del VAN falla (ficha `opciones-reales`).
- 3.A.25 (revisado), l. 724: «igual que una empresa decide una inversión por su valor actual neto `\vertema{3.A.34}`»: el VAN se desarrolla en el 3.B.2 (tema de referencia de esta ficha); mejor `\vertema{3.B.2}` (o los 2) (`pendientes-coherencia.md`, «Pendiente del 3.A.34»; menor).

Autor: Víctor Gutiérrez Marcos
