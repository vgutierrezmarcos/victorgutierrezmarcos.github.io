# Ley de Okun

- **Área:** macro-cerrada · **Tema de referencia:** **3.A.28** (revisado el 31/10/2026: desarrollo breve, 1′ de cante, en II.1.3 `sec:okun`, con `eq:okun` y el gráfico `okun-espana`) **[decidir]** (A28-05/K29) — completa la tasa natural (paro y producción, tasa natural y potencial), es del 3.er ejercicio (CRITERIOS § 6) y la 1D01 la usa junto a la Phillips. Alternativa: 4.B.4, que solo la usa en los estabilizadores.
- **Temas que lo usan:** 3.A.28 (desarrollo; hecho, 31/10/2026), 4.B.4 (resumen: respuesta del paro al ciclo en los estabilizadores), 4.A.16 (mención: elasticidad alta del empleo al PIB en España; el 3.A.28 le remite los ERTE de 2020), 3.A.42 (mención: la brecha de producción), 1D01 (uso: III.1, preguntada en 2021 junto a la curva de Phillips).
- **Manuales de referencia:** Okun (1962), «Potential GNP: Its Measurement and Significance» (`Okun1962`); Ball, Leigh y Loungani (2017), «Okun's Law: Fit at 50?», *JMCB* (`Ball2017Okun`); Blanchard, *Macroeconomics*, cap. 9. Las claves son las de la 1D01.

## Presentación de referencia (3.A.28, II.1.3)
**Pregunta:** ¿cuánto baja el paro cuando la economía crece por encima de su potencial?

**Idea:** la Phillips habla de paro y la política de demanda mueve la producción; Okun (1962), asesor de Kennedy, midió cuánta producción se perdía por cada punto de paro por encima del objetivo de la época (4 %): **unos 3 puntos de PNB por punto de paro** (relación 3 a 1). Es el puente entre las 2 variables, y entre la tasa natural y el potencial.

**Ecuaciones** (`eq:okun`; $U_t$ tasa de paro, como en § 6):
$$U_t-U_{t-1}\approx-\vartheta\,(\gamma_{Y,t}-\bar\gamma_Y)\quad\text{(en diferencias)},\qquad U_t-U^n\approx-\vartheta'\,\mathrm{OG}_t\quad\text{(en brechas)},$$
con γ_{Y,t} el crecimiento del PIB, γ̄_Y el que mantiene estable el paro (cercano al potencial) y OG_t la brecha en % del potencial Y^p (ficha `brecha-produccion`). **ϑ y ϑ′ sin subíndice** (`notacion.md` § 6; **[decidir]**).

**Cifras (no confundir):** la de Okun (1962), 3 puntos de producción por punto de paro, equivale a **ϑ ≈ 1/3**. El «**medio punto** menos de paro por cada punto de crecimiento por encima de γ̄_Y» en EE. UU. (≈ 0,45) es la estimación moderna de **Ball, Leigh y Loungani (2017)**, no de Okun. Ball *et al.*: 0,15 en Japón, 0,45 en EE. UU., 0,85 en España (el más alto, por los contratos temporales). España 1996-2025 sin 2020-2021 (Eurostat `nama_10_gdp` y AMECO ZUTN): ΔU = 1,45 − 0,803γ_Y, R² = 0,71: cada punto por encima del 1,8 % baja el paro 0,8 puntos.

**Resultado:** el coeficiente es menor que 1 (cuando cae la producción bajan también las horas, la participación y la productividad: las empresas retienen plantilla) y varía mucho entre países y en el tiempo. Implicaciones: para que baje el paro hay que crecer por encima de γ̄_Y; llevando la forma en brechas a la Phillips aumentada, π_t = π^e_t + aϑ′·OG_t + ε_t (oferta agregada de corto plazo). Valoración: regularidad empírica, no modelo; falla con mucha economía sumergida y cuando se protege el empleo (ERTE de 2020: la producción cayó un 10,9 % y el paro subió 1,4 puntos), y con cambios de régimen.

**Gráfico de referencia:** `oposicion/temario/fuentes/3A28/graficos/okun-espana.tex` (datos, apoyo en pantalla): nube de la variación de la tasa de paro frente al crecimiento del PIB real de España, 1996-2025, con la recta de MCO sin 2020-2021 de pendiente −ϑ que corta el eje horizontal en γ̄_Y ≈ 1,8 %. En la pizarra, `eq:okun` en una línea, sin gráfico.

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.28 | Tasa natural y persistencia | desarrollo breve (hecho, 31/10/2026) | Idea, las 2 formas, la cifra de Okun (ϑ ≈ 1/3) y la de Ball *et al.* (0,45; España 0,85), implicaciones (Phillips en producción), evidencia de España con `okun-espana`, valoración (ERTE) | — |
| 4.B.4 | Estabilizadores automáticos | Resumen | Respuesta del paro (y de las prestaciones) a la brecha, con `eq:okun` en brechas y ϑ′; remisión al 3.A.28 solo para ampliar | La estimación |
| 4.A.16 | Mercado de trabajo en España | Mención | Elasticidad alta del empleo al PIB en España (Ball *et al.*, 2017: 0,85) y los ERTE de 2020 | — |
| 3.A.42 | Ciclos | Mención | La brecha de producción y el paro | — |
| 1D01 | Dictamen de coyuntura | Uso | En palabras y con `eq:okun` de coeficiente 0,5: a partir de qué crecimiento baja el paro; cuándo no es razonable usarla | Ecuaciones |

## Divergencias encontradas en el temario actual
- **1D01 (revisada)**: atribuye a `Okun1962` el «medio punto menos de paro por cada punto de crecimiento» (III.1, `eq:okun` con ΔU_t ≈ −0,5(γ_{Y,t} − γ_{Y^p,t}), ficha de repaso y guion): es la estimación de `Ball2017Okun`; Okun dio la relación 3 a 1. Entrada en `pendientes-coherencia.md` (pendiente de que Víctor lo decida; no se ha tocado la 1D01).
- Ficha `estabilizadores-automaticos` y Word del 4.B.4: la escriben como una elasticidad del número de parados al PIB, $\varepsilon_{U,Y}<0$; la forma habitual es en puntos de paro frente a crecimiento (arriba). Unificar al revisar el 4.B.4.
- La propuesta de coherencia de la 1D01 (C2) la escribía con $u_t$; el canon usa $U_t$ para la tasa de paro en los modelos (§ 6, regla de la tasa de paro en `notacion.md`).
- **Resuelto (31/10/2026)**: el 3.A.28 no la citaba; ahora es su tema de referencia.

Autor: Víctor Gutiérrez Marcos
