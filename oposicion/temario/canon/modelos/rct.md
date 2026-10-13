# Evaluación de impacto: experimentos aleatorizados y cuasiexperimentos

- **Área:** sector público · **Tema de referencia:** 4.B.6 (evaluación de políticas públicas; técnicas de evaluación de impacto) — título; la fuente (viejo 4.B.7, solo ACB) **no lo trata**: hay que escribirlo.
- **Temas que lo usan:** 4.B.6 (desarrollo; falta), 3.A.1 (resumen: métodos empíricos recientes en economía), 4.A.26 (mención prevista), 4.A.16 (mención prevista: evaluación de políticas activas de empleo), 3.B.28 (mención)
- **Manuales de referencia:** Angrist y Pischke, *Mostly Harmless Econometrics* (2009); Gertler et al., *Impact Evaluation in Practice* (Banco Mundial, 2.ª ed. 2016); Duflo, Glennerster y Kremer (2007), *Handbook of Development Economics*; Card y Krueger (1994), *AER*; Imbens y Wooldridge (2009), *JEL*; Ley 27/2022 de institucionalización de la evaluación de políticas públicas en la AGE.

## Presentación de referencia
**Pregunta:** ¿qué efecto causal tiene una política?

**Marco (Rubin):** resultados potenciales $Y_i(1)$, $Y_i(0)$; efecto medio del tratamiento $ATE=E[Y_i(1)-Y_i(0)]$; sesgo de selección al comparar tratados y no tratados. **Técnicas:** experimento aleatorizado (RCT; Banerjee, Duflo y Kremer, Nobel 2019); diferencias en diferencias (Card y Krueger, 1994: salario mínimo); regresión discontinua; variables instrumentales (Nobel 2021: Card, Angrist, Imbens); emparejamiento y *propensity score*; control sintético (Abadie). Validez interna frente a externa.

**Gráfico de referencia:** diferencias en diferencias (tendencias paralelas, efecto tras el tratamiento). No hay `.tex` todavía.

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 4.B.6 | Técnicas de evaluación de impacto | Desarrollo (hay que escribirlo) | Marco causal, técnicas, institucionalización (AIReF, Ley 27/2022) | — |
| 3.A.1 | Metodología económica | Resumen | Revolución de la credibilidad | Técnicas en detalle |
| 4.A.16 | Mercado de trabajo | Mención | Evaluaciones de políticas activas | — |

## Divergencias encontradas en el temario actual
- 4.B.6: faltan por completo los epígrafes nuevos «evaluación de las políticas públicas» y «técnicas de evaluación de impacto»; el inventario no recoge el modelo porque la fuente no lo trata.
- 4.B.6 denota la tasa de descuento con $\delta$ (depreciación en el resto del temario): ver `_notacion/sector-publico.md` ($r_s$).
