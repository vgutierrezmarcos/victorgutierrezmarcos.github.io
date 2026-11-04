# La nueva economía keynesiana con desempleo (Blanchard y Galí, 2010; Galí, 2011)

- **Área:** macro cerrada · **Tema de referencia:** **3.A.28** (La tasa natural de paro y la NAIRU. La persistencia del desempleo; revisado el 31/10/2026: III.5 `sec:nek-desempleo`, «El modelo nuevo keynesiano con desempleo», con la curva de Phillips salarial de Galí, 2011, en nota) — es el único tema con un subapartado propio y una ecuación; el 3.A.7 lo resume como ruptura de la divina coincidencia y el 3.A.26 como aplicación del DMP. Ficha creada en la fase canon del 3.A.7 (**[decidir]**: alternativa, el 3.A.7 de referencia, por ser una extensión del modelo canónico; los 2 temas están revisados y no cambian con ninguna de las 2 opciones). Recoge los ids `blanchard-gali-2010` y `gali-2011` (alias).
- **Temas que lo usan:** 3.A.28 (resumen en subapartado propio; hecho, 31/10/2026), 3.A.7 (resumen; hecho, 4/11/2026: II.2 iii), «cuándo se rompe» la divina coincidencia, con `\vertema{3.A.26}` y `\vertema{3.A.28}`, y III.2, el paro en los modelos actuales con Galí, 2011, y la histéresis de Galí, 2022), 3.A.26 (mención; hecho, 31/10/2026: introducción y III, el DMP como mercado de trabajo de los EGDE, `\vertema{3.A.7}`), 3.A.42 (hecho, 4/11/2026, ver la tabla; mención: el DMP en los modelos del ciclo y el puzle de Shimer; ficha `dmp`), 3.A.36 (mención; hecho, 4/11/2026: I.3 c), las fricciones de búsqueda de Blanchard y Galí, 2010, como fuente del dilema, `\vertema{3.A.26}` `\vertema{3.A.28}`; I.4.4, la histéresis y el peso del empleo, Galí, 2022; ficha `histeresis`). Relacionadas: `divina-coincidencia`, `dmp`, `histeresis`, `nairu-layard-nickell`, `nek-3-ecuaciones`.
- **Manuales de referencia:** Blanchard y Galí (2010), «Labor Markets and Monetary Policy: A New Keynesian Model with Unemployment», *AEJ: Macroeconomics* 2(2) (`BlanchardGali2010Labor`; **nunca** «Blanchard y Galí, 2005», ni confundirlo con Blanchard y Galí, 2007, salarios reales rígidos, `BlanchardGali2007Real`); Galí (2011), «The Return of the Wage Phillips Curve», *JEEA* 9(3) (`Gali2011Return`; el libro del mismo año, *Unemployment Fluctuations and Stabilization Policies*, MIT Press, lo desarrolla); Galí (2022), «Insider-Outsider Labor Markets, Hysteresis, and Monetary Policy», *JMCB* 54(S1) (`Gali2022Insider`); Galí (2015), cap. 7.

## Presentación de referencia (3.A.28, III.5, y 3.A.7, II.2 iii)

**Pregunta:** ¿qué cambia en el modelo canónico de la NEK si hay paro y el salario real no se ajusta?

- **Blanchard y Galí (2010)**: añaden al modelo canónico fricciones de **búsqueda y emparejamiento** (DMP, `\vertema{3.A.26}`) y un **salario real rígido**. Resultan una curva de Phillips con paro y el fin de la divina coincidencia: estabilizar la inflación ya no basta para estabilizar el paro. En los mercados **escleróticos** (pocas entradas y salidas del paro, como los europeos) el paro es además más persistente.
- **Galí (2011)**: el paro como la diferencia entre quienes querrían trabajar al salario vigente y quienes trabajan; curva de Phillips **salarial** parecida a la de Phillips (1958):
  $$\gamma_{W,t}=\beta\,\mathbb{E}_t[\gamma_{W,t+1}]-\kappa_W\,(U_t-U^n),\qquad U^n=\mu^W/\varphi$$
  con $\mu^W$ el margen salarial deseado, φ la inversa de la elasticidad de Frisch y κ_W la pendiente (nota del 3.A.28). Su tasa natural existe por el poder de mercado de los trabajadores: une la tasa natural y la NAIRU.
- **Galí (2022)**: con *insiders*, histéresis en la NEK (ficha `histeresis`; 3.A.7, III.2).

**Gráfico de referencia:** ninguno.

**Notación:** γ_{W,t} crecimiento del salario nominal (D010), κ_W (con subíndice, para no chocar con la κ de la NKPC), μ^W margen salarial (superíndice W), $U^n$.

## Cómo se adapta en cada tema

| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.28 | Paro de equilibrio y persistencia | resumen en subapartado propio (hecho, 31/10/2026) | Las 2 viñetas (Blanchard y Galí, 2010; Galí, 2011, con la ecuación en nota); `\vertema{3.A.7}` | El modelo canónico |
| 3.A.7 | Implicaciones del modelo canónico | resumen (hecho, 4/11/2026) | Como 3.ª ruptura de la divina coincidencia, con mercados escleróticos; en III.2, el paro en los modelos actuales (Galí, 2011 y 2022); `\vertema{3.A.26}`, `\vertema{3.A.28}` | La ecuación de Galí |
| 3.A.26 | Búsqueda y emparejamiento | mención (hecho, 31/10/2026) | El DMP como mercado de trabajo de los EGDE nuevos keynesianos, con curva de Phillips con paro; `\vertema{3.A.7}` | — |
| 3.A.42, 3.A.36 | Ciclos; política monetaria | mención (hechos, 4/11/2026; el 3.A.42 en II.2.2 iii) con Blanchard y Galí, 2007 y 2010) | El paro en los modelos del ciclo y el peso del empleo en la política; `\vertema{3.A.28}` | — |

## Divergencias encontradas en el temario actual

- **Resuelto en el 3.A.26, el 3.A.28 (31/10/2026) y el 3.A.7 (4/11/2026)**: «Blanchard y Galí (2005)» con búsqueda; el 3.A.7 separa ahora el de 2007 (salarios reales rígidos, nombre de la divina coincidencia) y el de 2010.
- **3.A.42** (**resuelto** el 4/11/2026): «Blanchard y Galí (2005)» (Word, l. 1478 y 1500) → Blanchard y Galí (2007) para los salarios reales rígidos y (2010) para la búsqueda, en II.2.2 iii).
- **Terminología**: el 3.A.28 y el 3.A.26 escriben «modelo nuevo keynesiano», el 3.A.7 «neokeynesiano» y el 3.A.29 «nuevokeynesianos»; ver `notacion.md` § 14 (**[decidir]**).

Autor: Víctor Gutiérrez Marcos
