# Equivalencia ricardiana (Ricardo; Barro, 1974)

- **Área:** macro cerrada · **Tema de referencia:** 3.A.39 (Déficit público. Financiación y sus consecuencias macroeconómicas) — compara financiación con impuestos y con deuda; el propio autor anota en 3.A.38 que «es más del tema 3.A.39». **Hecho (revisado el 4/11/2026):** I.3.1 con a)-d), las ecuaciones del hogar y del Estado, Blanchard (1985) y las 5 razones del incumplimiento en el orden de Heijdra; evidencia en I.4.1.
- **Temas que lo usan:** 3.A.39 (desarrollo; hecho, 4/11/2026), 3.A.6 (resumen; hecho, 4/11/2026: II.4 con a)-c), como consecuencia de las expectativas racionales aplicada a la política fiscal, «Are Government Bonds Net **Wealth**?», el nombre de Buchanan, 1976; anexo C con lo que no implica, los efectos no keynesianos, las 5 razones del incumplimiento de Heijdra, la economía abierta y la evidencia; `\vertema{3.A.39}`), 3.A.38 (resumen: efectos del gasto sobre el ahorro; hoy desarrollo), 4.B.4 (resumen), 4.B.10 (resumen; hoy mención), 4.B.11 (resumen; hoy mención: punto de partida de la suavización impositiva), 3.A.33 (mención; hecho, 31/10/2026: nota en las implicaciones de la renta permanente, I.2.2, que la separa de ella; y en la liquidez, II.3, la deuda como crédito a quien no lo tenía; `\vertema{3.A.39}`), 3.A.43 (mención; hecho, 31/10/2026: III.3 c), en el RCK financiar el gasto con deuda o con impuestos de suma fija no cambia nada con horizonte infinito; Barro, 1974; `\vertema{3.A.39}`), 3.A.29 (mención; hecho, 1/11/2026: la dinastía de Barro como agente de vida infinita y su fallo con OLG salvo herencias altruistas, `tab:mhi-mgs`). También 3.A.7 (mención; hecho, 4/11/2026: III.1.2, con hogares ricardianos e impuestos de suma fija afecta a la financiación, no al gasto, y deja de cumplirse con hogares de regla de pulgar, Galí, López-Salido y Vallés, 2007; `\vertema{3.A.39}`). 3.A.2 (mención; hecho, 4/11/2026: nota en la política de Ricardo, II.3.5, l. 523: en el cap. 17 de los *Principles* (3.ª ed.) compara pagar una guerra con un impuesto de 20 millones o con un préstamo; en teoría serían equivalentes, pero Ricardo duda de que la gente razone así; Barro (1974) la revive y Buchanan (1976) la bautiza; `\vertema{3.A.39}`, no 3.A.38).
- **Manuales de referencia:** Barro (1974), «Are Government Bonds Net Wealth?», *JPE* 82; Buchanan (1976); Ricardo (1821), *Principles*, cap. 17 (`Ricardo1821Principles`); Romer (2019), cap. 13; Heijdra (2017); Blanchard (1985); Blanchard y Fischer (1989), cap. 3; Seater (1993), *JEL*; Bernheim (1987).

## Presentación de referencia

**Pregunta:** ¿son los bonos públicos riqueza neta para quien los tiene? ¿Afecta al consumo y al ahorro nacional que un gasto público dado se financie con deuda en lugar de con impuestos?

**a) Idea:** Ricardo (cap. 17 de los *Principles*, 3.ª ed., 1821) compara pagar una guerra con un impuesto o con un préstamo: en teoría daría igual, pero **duda de que la gente razone así y prefiere los impuestos** (nunca «la descartó por irrelevante»). Barro (1974) la recupera («Are Government Bonds Net **Wealth**?») y Buchanan (1976) le da el nombre. «Teorema de Modigliani-Miller de las finanzas públicas» (en nota).

**b) Modelo. Supuestos** (5, en este orden): horizonte infinito (Barro usa **generaciones solapadas unidas por herencias altruistas**: la dinastía equivale a un agente de vida infinita, `\vertema{3.A.29}`; el hogar del RCK, `\vertema{3.A.43}`; nunca «Barro usa EGDE»); impuestos de suma fija; mercados de capitales perfectos (sin restricciones de liquidez; Estado y hogares al mismo $r$); expectativas racionales (`\vertema{3.A.6}`); senda de gasto dada.

**Ecuaciones** (reales; Romer, 2019, cap. 13): restricción del hogar (`eq:ricardiana-hogar`)

$$\sum_{t=0}^{\infty}\frac{C_t}{(1+r)^t} = K_0 + (1+r)D_{-1} + \sum_{t=0}^{\infty}\frac{w_tL_t - T_t}{(1+r)^t}$$

y del Estado (`eq:ricardiana-estado`, la solvencia en niveles y sin dinero) $\sum_t T_t/(1+r)^t = \sum_t G_t/(1+r)^t + (1+r)D_{-1}$. Sustituyendo (`eq:ricardiana`): $\sum_t C_t/(1+r)^t = K_0 + \sum_t (w_tL_t - G_t)/(1+r)^t$: **la riqueza depende de la senda de $G$, no de la de $T$ ni de la deuda**. Ejemplo de 1 euro: $-1+(1+r)/(1+r)=0$; el ahorro privado sube lo que baja el público. (La ficha escribía antes $b_0$ para la riqueza inicial; el 3.A.39 separa $K_0$ y $(1+r)D_{-1}$.)

**Implicaciones:** «la deuda pública no es riqueza neta, sino impuestos aplazados» («no hay plazo que no se cumpla ni deuda que no se pague»); frente a la renta permanente, la ER va más allá: ni una rebaja permanente financiada con deuda mueve el consumo (`\vertema{3.A.33}`); **lo que no dice**: que el gasto no tenga efectos (Baxter y King, 1993) ni nada de la monetización; en economía abierta, sin déficits gemelos (Uribe y Schmitt-Grohé, 2017, `\vertema{3.B.11}`).

**c) Por qué falla — las 5 razones, en el orden de Heijdra (2017)** (las mismas del anexo C del 3.A.6):
1. **Vidas finitas**: Blanchard (1985), probabilidad de morir **$p$** por unidad de tiempo (local, avisada: no es un precio; π es la inflación), descuento a $r+p$; los vivos pagan en valor actual $\int_0^\infty r e^{-(r+p)s}ds = r/(r+p)<1$, su riqueza sube $p/(r+p)$; con $p=0$ vuelve la equivalencia. OLG sin herencias (Diamond, 1965, `\vertema{3.A.29}`).
2. **Impuestos distorsionantes**: punto de partida de la suavización (ficha `suavizacion-impositiva-barro`).
3. **Gasto productivo**: más un aviso que un fallo: lo que mueve la economía es el gasto.
4. **Restricciones de liquidez**: $C_t=\lambda(Y_t-T_t)+(1-\lambda)C^{\mathrm R}_t$ (Campbell y Mankiw, 1989, λ ≈ 0,5; **λ fracción de hogares**, avisada; $C^{\mathrm R}_t$ ricardianos); la deuda como crédito a quien no lo tenía (`\vertema{3.A.33}`); hogares de regla de pulgar en la NEK (Galí, López-Salido y Vallés, 2007, `\vertema{3.A.7}`); *wealthy hand-to-mouth* (Kaplan, Violante y Weidner, 2014).
5. **Miopía o racionalidad limitada** (`\vertema{3.A.1}`).

Y una 6.ª: **incertidumbre** sobre los impuestos futuros (Barsky, Mankiw y Zeldes, 1986: la rebaja funciona como seguro).

**d) Evidencia** (3.A.39, I.4.1): devoluciones de 2001 (Johnson, Parker y Souleles, 2006: 20-40 % en no duraderos) y pagos de 2008 (Parker *et al.*, 2013); Israel a favor (Barro, 1989); Canadá frente a EE. UU., por el trato fiscal del ahorro (Carroll y Summers, 1987; **no** es experimento favorable); tipos (Laubach, 2009); cuenta corriente 0,6 (Bluedorn y Leigh, 2011); revisiones de Bernheim (1987) y Seater (1993). Cifras pendientes de 2.ª comprobación (A39-10). **Valoración:** punto de referencia; obliga a pensar con la restricción intertemporal; abre la suavización.

**Gráfico de referencia:** no imprescindible (el 3.A.39 no lo dibuja); si se usa, elección intertemporal de Fisher en (C_1, C_2) con el punto de dotación desplazándose sobre la misma recta presupuestaria.

## Cómo se adapta en cada tema

| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.39 | Financiación del déficit | Desarrollo (hecho, 4/11/2026) | I.3.1 a)-d) con `eq:ricardiana-hogar`, `eq:ricardiana-estado` y `eq:ricardiana`, ejemplo de 1 euro, Blanchard (1985) con $r/(r+p)$, las 5 razones de Heijdra con λ de Campbell-Mankiw, incertidumbre; evidencia en I.4.1 | — |
| 3.A.6 | La NMC | resumen (hecho, 4/11/2026) | II.4: enunciado, supuestos (horizonte infinito o dinastías, suma fija, sin restricciones de liquidez, mismo tipo), la deuda no es riqueza neta, lo que no dice; anexo C con las 5 razones del incumplimiento (vidas finitas, impuestos distorsionantes, gasto productivo, liquidez, miopía) y la economía abierta (Uribe y Schmitt-Grohé, 2017); `\vertema{3.A.39}` (las razones del incumplimiento van al 3.A.39, no al 3.A.38) | La restricción del hogar y del Estado con ecuaciones |
| 3.A.38 | Efectos fiscales sobre el ahorro | Resumen (hoy desarrollo en su Word, l. 592-668) | Efecto nulo del déficit sobre el ahorro nacional frente a OLG (Diamond 1965), con `\vertema{3.A.39}` | La derivación y las razones del incumplimiento |
| 4.B.4 | Efectividad de la política fiscal | Resumen | Neutralidad de la financiación; razones del incumplimiento | — |
| 4.B.10, 4.B.11 | Impuestos y ahorro; imposición óptima | Resumen (hoy mención; D139 (13/10/2026)) | Enunciado, supuestos y por qué falla; punto de partida de la suavización impositiva | El desarrollo |
| 3.A.33 | Teorías del consumo | mención (hecho, 31/10/2026) | Renta permanente: lo **transitorio** apenas mueve el consumo; la equivalencia ricardiana va más allá: ni una rebaja **permanente** financiada con deuda lo mueve si el gasto no cambia (horizonte infinito o herencias, impuestos de suma fija, sin restricciones de liquidez); `tab:implicaciones` | La derivación |
| 3.A.29 | Horizonte infinito y generaciones solapadas | mención (hecho, 1/11/2026) | La dinastía de Barro (1974) como agente de vida infinita, «de tal palo, tal astilla» (II.2 a)); con OLG falla salvo herencias altruistas (III.1 c)); fila de `tab:mhi-mgs` | La derivación `\vertema{3.A.39}` |
| 3.A.43 | RCK con sector público | mención (hecho, 31/10/2026) | Una viñeta en el gasto público del RCK; con OLG cambia (`\vertema{3.A.29}`) | La derivación `\vertema{3.A.39}` |
| 3.A.7 | Política fiscal en la NEK | mención (hecho, 4/11/2026) | Se cumple con hogares ricardianos e impuestos de suma fija (Barro, 1974): da igual impuestos o deuda; el gasto sí mueve la demanda; con hogares de regla de pulgar deja de cumplirse (Galí, López-Salido y Vallés, 2007); nunca «la 2.ª generación acepta la equivalencia ricardiana, lo que limita el efecto del gasto»; `\vertema{3.A.39}` | La derivación |
| 3.A.2 | Los clásicos | mención (hecho, 4/11/2026) | El origen en Ricardo (cap. 17) y su duda; Barro (1974) y el nombre de Buchanan (1976), en nota | La derivación `\vertema{3.A.39}` |

## Divergencias encontradas en el temario actual

- **3.A.39 resuelto** (4/11/2026): «Net Worth» → «Net **Wealth**»; «Barro trabaja con modelos EGDE… infinitos periodos» → OLG con herencias altruistas; Ricardo «la descartó por irrelevante» → duda de que la gente razone así (misma clave y frase que el 3.A.2, l. 523); la monetización fuera del teorema; «Schmitt-Grohe *et al.*, 2016» → Uribe y Schmitt-Grohé (2017); Canadá y EE. UU. no son evidencia a favor (Carroll y Summers, 1987); las 2 páginas escaneadas sustituidas por la derivación propia. Ahora tiene ecuaciones: el 3.A.6 puede adelgazar su anexo C y el 3.A.38 quedarse en resumen.

- **Desarrollo en tres temas** (3.A.6, 3.A.38, 3.A.39) sin ecuaciones en ninguno: propuesta, desarrollo con ecuaciones solo en 3.A.39 y remisión en los demás. **3.A.6 resuelto** (4/11/2026): resumen en II.4 y anexo C, «Net **Wealth**» (el Word decía «Net Worth»), sin la monetización como parte del teorema; su remisión al 3.A.38 por las razones del incumplimiento pasa al 3.A.39. El Word del 3.A.39 (sin revisar) copia casi literal el bloque del Word del 3.A.6: al revisarlo, desarrollo con ecuaciones y el 3.A.6 podrá adelgazar su anexo C.
- 3.A.33 original: la nota 14 atribuía a la renta permanente la ineficacia fiscal porque «el individuo conoce la restricción del Gobierno» (es la equivalencia ricardiana). **Resuelto** (31/10/2026). 3.A.38 y 3.A.39 (sin revisar) la cuentan casi con el mismo texto: un solo desarrollo en el 3.A.39 y remisión al 3.A.33 para la renta permanente y Hall; λ de Campbell y Mankiw entre las razones del incumplimiento.

Autor: Víctor Gutiérrez Marcos
