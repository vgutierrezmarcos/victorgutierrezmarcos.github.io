# Regresiones de crecimiento: Barro (1991) y su robustez (Levine y Renelt, 1992; Sala-i-Martín, 1997)

- **Área:** macro cerrada · **Tema de referencia:** **3.A.45** (III.3 «Impacto de los distintos factores que influyen sobre el crecimiento: las causas próximas», 2′; **revisado el 1/11/2026**) — «factores que influyen sobre el crecimiento» está en el título del apartado III. Ficha creada en la fase canon del 3.A.45 (CC6, **[decidir]**); el id ya estaba en `mapa.yaml`, `alias.json` y `areas.json` sin fichero.
- **Temas que lo usan:** 3.A.45 (desarrollo; hecho, 1/11/2026), 3.A.38 (mención, prevista: Kneller, Bleaney y Gemmell, 1999, gasto productivo e impuestos distorsionantes; Barro, 1990, ficha `barro-1990`), 3.B.9 (mención, prevista: comercio y crecimiento, Frankel y Romer, 1999, con instrumento geográfico), 3.B.28 (no lo usa: revisado el 3/11/2026, sin regresiones de crecimiento; la mención era opcional), 4.A.27 (mención posible)
- **Manuales de referencia:** Barro (1991), *QJE* (NBER WP 3120); Barro (1995, inflación); Barro (1997), *Determinants of Economic Growth*; Mankiw, Romer y Weil (1992), tablas III-V; Levine y Renelt (1992), *AER*; Leamer (1983); Sala-i-Martín (1997), *AER P&P*; Sala-i-Martín, Doppelhofer y Miller (2004), *AER*; King y Levine (1993); Frankel y Romer (1999); Kneller, Bleaney y Gemmell (1999); Durlauf, Johnson y Temple (2005).

## Presentación de referencia (3.A.45, III.3)

**Idea.** La regresión de convergencia condicional (`eq:convergencia-beta`, ficha `convergencia-beta-sigma`) usada al revés: dada la renta inicial, ¿qué variables de $\vect{x}_i$ se asocian a crecer más? Son las **causas próximas** (capital físico, humano, tecnología): describen *cómo* se crece, no *por qué* (ficha `ajr-instituciones`).

**Barro (1991)**: **98 países, 1960-1985** (no «130 países» ni «5 regresiones con la inflación»), con regresiones de la forma `eq:convergencia-beta`: sin controles no hay convergencia; dado el capital humano inicial (matrícula de 1960 en primaria y secundaria), convergencia condicional; capital humano → más crecimiento, menos fecundidad, más inversión; consumo público (sin educación ni defensa) → menos crecimiento, inversión pública no significativa; inestabilidad política (revoluciones, golpes, asesinatos) y **distorsión del precio de los bienes de inversión** frente a la PPA → menos; ficticias de África subsahariana y América Latina negativas (falta algo). **Sin inflación**: es Barro (1995), con la cautela de la causalidad simultánea; Barro (1997) añade imperio de la ley, relación real de intercambio, fecundidad y esperanza de vida. Las regresiones 4.ª y 5.ª del Word **son de MRW (1992, tablas IV y V)**: con $s$ y $n$, −0,14; con escolarización, −0,29 (λ 1,4 %).

**Otros determinantes**: inversión (la más robusta; causalidad de ida y vuelta), desarrollo financiero (King y Levine, 1993), comercio con instrumento geográfico (Frankel y Romer, 1999: +1 punto de comercio/PIB, +0,5 a 2 % de renta; `\vertema{3.B.9}`), geografía, salud y demografía. La democracia, con las causas últimas.

**Robustez**: más de 50 variables significativas en alguna regresión. **Levine y Renelt (1992)**, análisis de cotas extremas de **Leamer (1983)** (no 1982): solo la inversión (y el comercio, por la inversión) es robusta. **Sala-i-Martín (1997)**: toda la distribución de los coeficientes en millones de regresiones; «una parte considerable» de variables robusta (sin la cifra «22 de 59», no comprobada). **Sala-i-Martín, Doppelhofer y Miller (2004)**, promedios bayesianos (BACE): 18 de 67 robustas (ficticia de Asia oriental, escolarización primaria, precio relativo de la inversión, renta inicial). Problemas: multicolinealidad, endogeneidad, paneles quinquenales (anexo C de econometría). **Kneller, Bleaney y Gemmell (1999)**: con la restricción presupuestaria completa, impuestos distorsionantes −, gasto productivo +, improductivo 0 (sin la lista de partidas, no comprobada; `\vertema{3.A.38}`).

**En el cante**: una columna de signos a la derecha (+ capital humano inicial, + inversión, − consumo público, − inestabilidad, − distorsiones; «robusta: inversión»). Sin gráficos.

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.45 | Factores que influyen sobre el crecimiento | desarrollo (hecho, 1/11/2026) | Lo de arriba | — |
| 3.A.38 | Política fiscal y crecimiento | mención (prevista) | Kneller, Bleaney y Gemmell (1999) y el consumo público de Barro (1991) como evidencia del gasto productivo | La robustez `\vertema{3.A.45}` |
| 3.B.9 | Comercio y crecimiento | mención (prevista) | Frankel y Romer (1999) y la robustez del comercio en Levine y Renelt | La lista de Barro |
| 3.B.28 | Desarrollo | no se usa (revisado, 3/11/2026) | La mención prevista era opcional y no se puso: el tema pasa de las causas próximas a las instituciones (AJR en una frase, `\vertema{3.A.45}`) | — |

## Divergencias encontradas en el temario actual
- Resuelto en el 3.A.45 (1/11/2026): Barro (1991) con «130 países» y la inflación; regresiones de MRW atribuidas a Barro; debate «Mankiw frente a Romer» sin fuente (quitado); Leamer (1982); «Kneller et al.» con lista sin comprobar.

Autor: Víctor Gutiérrez Marcos
