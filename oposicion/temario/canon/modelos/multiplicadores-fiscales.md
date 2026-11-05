# Multiplicadores fiscales

- **Área:** sector público · **Tema de referencia:** 3.A.40 para la teoría de los multiplicadores (keynesiano, IS-LM, NEK en el límite inferior); 4.B.4 para las definiciones empíricas (impacto, acumulado, máximo) y la evidencia, con un resumen de la teoría suficiente para cantarse sin el 3.A.40.
- **Temas que lo usan:** 4.B.4 (resumen keynesiano + desarrollo empírico), 3.A.38 (resumen; hecho, 5/11/2026: I.3 c) en 4 viñetas —gasto, impuestos, efectos no keynesianos y remisión— y el anexo D con las definiciones, 11 determinantes y la evidencia; de acuerdo con D052, CC7 del 3.A.38), 3.A.40 (desarrollo; en revisión el 5/11/2026), 4.A.11 (mención: inversión pública, Plan E), 4.B.26 (mención: consolidación), 3.A.33 (mención; hecho, 31/10/2026: con hogares sin liquidez el multiplicador es mayor, Galí, López-Salido y Vallés, 2007, `\vertema{3.A.40}`; ficha `restricciones-liquidez`). También 3.A.7 (mención; hecho, 4/11/2026: III.1.2, el multiplicador es mayor cuanto más rígidos los precios, más persistente el gasto y más acomodaticio el banco central, y en el límite inferior puede superar con creces la unidad, Woodford, 2011, y Christiano, Eichenbaum y Rebelo, 2011; III.2, Romer y Romer, 2010, y Perotti, 2011; `\vertema{3.A.40}`).
- **Manuales de referencia:** Blanchard, cap. 3 y 22; Romer, *Advanced Macroeconomics*, cap. 12; Ramey (2019), «Ten years after the financial crisis: what have we learned from the renaissance in fiscal research?», *JEP*; Blanchard y Leigh (2013); Christiano, Eichenbaum y Rebelo (2011); Galí, López-Salido y Vallés (2007); Hall (2009).
- **Decisión D052 (13/10/2026):** ¿Cuál es el tema de referencia de los multiplicadores fiscales? 3.A.40 para la teoría (keynesiano, IS-LM, NEK en el límite inferior) y 4.B.4 para las definiciones empíricas y la evidencia

## Presentación de referencia
**Pregunta:** ¿cuánto cambia la producción por cada euro de gasto o de impuestos?

**Ecuaciones (notación de la ficha `is-lm` para el modelo keynesiano):** cruz keynesiana con tipo proporcional $t$ y propensión a importar $m$: $\frac{\Delta Y}{\Delta G}=\frac{1}{1-c(1-t)+m}$. Definiciones empíricas:
$$m^{\,t}_t=\frac{\Delta Y_t}{\Delta G_t},\qquad m^{\,t+k}_t=\frac{\Delta Y_{t+k}}{\Delta G_t},\qquad m^{\mathrm{acum}}_{t,k}=\frac{\sum_{j=0}^k\Delta Y_{t+j}}{\sum_{j=0}^k\Delta G_{t+j}},\qquad m^{\max}=\max_k m^{\,t+k}_t .$$
El acumulado es **el cociente de las sumas, no la suma de los cocientes** (el Word del 3.A.38 lo escribía mal; corregido en su anexo D, 5/11/2026).

**Resultado:** el multiplicador no es un número: depende de la política monetaria (mayor en el límite inferior de tipos), de la apertura, del tipo de instrumento (inversión > consumo público > transferencias > impuestos, en general), de la posición cíclica, de la deuda y de las expectativas (equivalencia ricardiana, efectos no keynesianos). Estimaciones: **la mayoría entre 0,6 y 1 para el gasto** (Ramey, 2019, comprobado en el 3.A.38); Hall (2009), 0,7-1 en tiempos normales y ≈ 1,7 con el tipo en cero; Christiano, Eichenbaum y Rebelo (2011), < 1 con regla de Taylor y, con el tipo en cero, 1,6 en el impacto y 2,3 de máximo si el gasto dura 12 trimestres; impuestos: una subida del 1 % del PIB reduce la producción casi un 3 % (Romer y Romer, 2010), 0,78-1,33 en el máximo con SVAR (Blanchard y Perotti, 2002); el FMI supuso ≈ 0,5 en 2010-2011 y fueron muy superiores a 1 (Blanchard y Leigh, 2013). En el ciclo real con gasto (ficha `rbc-sims`): 0,03 (transitorio), 0,32 (persistente), −0,68 (impuesto sobre el trabajo) en el impacto, 0,75 a largo plazo con gasto permanente; en la NEK con precios flexibles, θ/(θ + φ) = 0,5 (ficha `nek-3-ecuaciones`).

**Gráfico de referencia:** funciones impulso-respuesta del PIB a un choque de gasto. No hay `.tex` todavía.

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 4.B.4 | Política fiscal discrecional | Resumen + evidencia | Definiciones empíricas y determinantes; evidencia España (AIReF, BdE) | La derivación IS-LM completa |
| 3.A.40 | Teoría de los multiplicadores | Desarrollo (referencia de la teoría, D052; en revisión) | Teoría por escuelas y en el límite inferior, definiciones, HANK y evidencia; resume el ciclo real con gasto y Barro con `\vertema{3.A.38}` | Datos de España |
| 3.A.38 | Política fiscal: corto plazo, ahorro y crecimiento | **resumen (hecho, 5/11/2026)**, no desarrollo | I.3 b) iii): ΔY/ΔG = 1 + ΔC/ΔG, el multiplicador según el banco central (θ/(θ + φ), 1, < 1 con Taylor, > 1 en el límite inferior) y con hogares que viven al día; I.3 c): 4 viñetas con las cifras de arriba y `\vertema{3.A.40}` `\vertema{4.B.4}`; anexo D: las 4 definiciones con esta notación, 11 determinantes y la evidencia remitida | La teoría completa (`\vertema{3.A.40}`) |
| 4.A.11 | Construcción | Mención | Multiplicador de la inversión pública (Plan E) | — |
| 3.A.33 | Consumo | mención (hecho, 31/10/2026) | El multiplicador depende de la fracción de hogares *hand-to-mouth* (λ de Campbell y Mankiw); `tab:implicaciones` | El cálculo |
| 3.A.7 | Política fiscal en la NEK | mención (hecho, 4/11/2026) | Los 3 mecanismos (riqueza, rigidez de precios con margen contracíclico, respuesta del banco central); el multiplicador en el límite inferior; `\vertema{3.A.40}` | La evidencia |

## Divergencias encontradas en el temario actual
- 4.B.4: la sensibilidad de la inversión al tipo de interés es $v$ en las ecuaciones y $b$ en el texto; el texto dice que con presupuesto equilibrado $\Delta Y<\Delta G$ por desplazamiento y la nota 13 da el multiplicador de Haavelmo $=1$ sin aclarar que difieren por la inversión endógena.
- 4.B.4, nota 29: «$\phi_\pi=\phi_\pi=0{,}5$» → $\phi_y=\phi_\pi=0{,}5$.
- Tema de referencia fijado: teoría en 3.A.40, evidencia en 4.B.4.
- **Solape del anexo D del 3.A.38 con el 3.A.40** (A38-22, control de calidad, **[decidir]** al revisar el 3.A.40): el anexo D (definiciones, 11 determinantes y evidencia) repite lo que desarrollará el 3.A.40. *Recomendado*: dejarlo en un resumen con `\vertema{3.A.40}` cuando el 3.A.40 esté revisado; *alternativa*: quitarlo.
- **Contradicción interna de la ficha resuelta (5/11/2026, CC7 del 3.A.38)**: la fila «3.A.38 / 3.A.40 | Desarrollo» chocaba con D052 y con el mapa («3.A.38: resumen»); ahora 2 filas, el 3.A.38 en resumen.
- **Word del 3.A.38, resuelto (5/11/2026)**: «Christiano… entre 1,2 y 1,3», «Blanchard y Portugal sostienen que el gobierno puede elevar el multiplicador» (ahora FMI, 2014, *WEO* de octubre, cap. 3), «Galí y Monacelli (2005)» (2008, *JIE*), Alesina citado con *The Economist* (Alesina, Favero y Giavazzi, 2019), «Hahn» (Kahn, 1931), Hall «entre 0,5 y 1» (0,7-1).
