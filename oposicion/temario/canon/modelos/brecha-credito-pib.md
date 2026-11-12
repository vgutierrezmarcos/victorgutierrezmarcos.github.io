# Brecha crédito-PIB y colchón de capital anticíclico

- **Área:** finanzas-empresa · **Tema de referencia:** **3.B.27** (regulación bancaria: el colchón anticíclico de Basilea III), con **3.A.42** para el ciclo financiero.
- **Temas que lo usan:** 3.B.27 (desarrollo), 3.A.42 (resumen; hecho, 4/11/2026: III.1 `sec:cf-hechos`, la brecha como «versión financiera de la brecha de producción», HP de una cola con λ = 400 000, la regla de 2 y 10 puntos con `\vertema{3.B.27}`, las cifras de España y el colchón vigente; gráfico `brecha-credito-pib-espana`; ficha `ciclo-financiero`), 4.A.19 (resumen: el colchón del Banco de España), 4.A.18 (mención: colchón anticíclico sectorial), 1D01 (uso: III.2, política macroprudencial y `tab:indicadores-financiero`); 3.B.17 (mención; hecho, 12/11/2026: III.4, la brecha entre el crédito y su tendencia en relación con el PIB como indicador de alerta temprana, sin símbolo, `\vertema{3.A.42}`)
- **Manuales de referencia:** BCBS (2010), *Guidance for national authorities operating the countercyclical capital buffer*; Drehmann y Tsatsaronis (2014), *BIS Quarterly Review*; Borio (2014), «The financial cycle and macroeconomics»; Banco de España, metodología del colchón de capital anticíclico; CERS (2014), recomendación ESRB/2014/1.

## Presentación de referencia
**Pregunta:** ¿está el crédito creciendo más de lo que su tendencia justifica?

**Definición:** desviación de la ratio crédito al sector privado / PIB respecto a su tendencia (filtro HP de una cola con λ = 400.000 en el BCBS), en puntos porcentuales: la versión financiera de la brecha de producción (ficha `brecha-produccion`).

**Regla del BCBS (2010):** el colchón se empieza a activar cuando la brecha supera **2 puntos** y llega al máximo (2,5 % de los APR) con una brecha de **10 puntos** o más (`BCBS2010Anticiclico`, citada así en el 3.A.42; la fase de datos del 3.A.42 no la volvió a leer: **[comprobar]** sigue abierto, duda 8 de la 1D01). Positiva y creciente: auge del crédito; negativa: crédito por debajo de su tendencia, no procede activar (y conviene liberar si estaba activado). Desde 2024 el Banco de España fija un colchón positivo en una fase de riesgo «estándar»: **0,5 % desde el 1/10/2025 y 1 % desde el 1/10/2026** (BOE-A-2025-19516, resolución de 29/9/2025; comprobado en el 3.A.42, V40, 4/11/2026; la web del Banco de España aún no lo reflejaba), con la brecha del BIS todavía negativa.

**Cifras canónicas de España** (BIS, `BIS2026CreditGap`, consulta del 4/11/2026; V39 del 3.A.42): **+47,3 pp en 2007T2** (máximo), **−55,6 en 2017T4** (mínimo), **−24,3 en 2026T1**, con un crédito al sector privado no financiero del 119,4 % del PIB (tendencia, 143,7 %); la ratio llegó al **233,8 % en 2010T2**: la brecha cae antes que la ratio porque la tendencia sigue subiendo. Notación: **sin símbolo** («brecha crédito-PIB, en puntos»; en un gráfico, «brecha (pp)»; K38 del 3.A.42).

**Cautelas:** tras un desapalancamiento largo la tendencia estadística arrastra la brecha (falsas señales negativas); por eso se completa con otros indicadores (precio de la vivienda, servicio de la deuda, crédito nuevo).

**Gráfico de referencia:** `oposicion/temario/fuentes/3A42/graficos/brecha-credito-pib-espana.tex` (datos del BIS, 1980T1-2026T1: ratio crédito/PIB de España, su tendencia con un HP de una cola y λ = 400 000, la brecha y el umbral de 2 puntos; CSV en `fuentes/3A42/datos/brecha-credito-pib-espana.csv`). Fase canon del 3.A.42 (CC7). El 3.B.27 y el 4.A.19 lo copian (actualizando el último dato).

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.B.27 | Regulación financiera | Desarrollo | Colchón anticíclico, regla y crítica | — |
| 3.A.42 | Ciclo financiero | resumen (hecho, 4/11/2026) | La brecha como medida del ciclo financiero, con datos de España, el umbral de 2 puntos y el colchón vigente (1 %); gráfico de referencia | La regla regulatoria en detalle (`\vertema{3.B.27}`) |
| 4.A.19 | Sector bancario español | Resumen | Decisiones del Banco de España | La regla |
| 1D01 | Dictamen de coyuntura | Uso | Definición, umbral de 2 puntos, qué hacer en cada fase | La estimación |
| 3.B.17 | Crisis de BP | mención (hecho, 12/11/2026) | Un indicador más de vulnerabilidad en los sistemas de alerta temprana (III.4); `\vertema{3.A.42}` | El cálculo |

## Divergencias encontradas en el temario actual
- La 1D01 remite la brecha crédito-PIB a `\vertema{3.A.42}` (cuerpo y anexo A); con esta ficha conviene añadir `\vertema{3.B.27}` (pendiente menor de la 1D01, ver `pendientes-coherencia.md`).

Autor: Víctor Gutiérrez Marcos
