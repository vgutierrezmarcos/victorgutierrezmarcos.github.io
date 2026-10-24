# Brecha crédito-PIB y colchón de capital anticíclico

- **Área:** finanzas-empresa · **Tema de referencia:** **3.B.27** (regulación bancaria: el colchón anticíclico de Basilea III), con **3.A.42** para el ciclo financiero.
- **Temas que lo usan:** 3.B.27 (desarrollo), 3.A.42 (resumen: ciclo financiero), 4.A.19 (resumen: el colchón del Banco de España), 4.A.18 (mención: colchón anticíclico sectorial), 1D01 (uso: III.2, política macroprudencial y `tab:indicadores-financiero`)
- **Manuales de referencia:** BCBS (2010), *Guidance for national authorities operating the countercyclical capital buffer*; Drehmann y Tsatsaronis (2014), *BIS Quarterly Review*; Borio (2014), «The financial cycle and macroeconomics»; Banco de España, metodología del colchón de capital anticíclico; CERS (2014), recomendación ESRB/2014/1.

## Presentación de referencia
**Pregunta:** ¿está el crédito creciendo más de lo que su tendencia justifica?

**Definición:** desviación de la ratio crédito al sector privado / PIB respecto a su tendencia (filtro HP de una cola con λ = 400.000 en el BCBS), en puntos porcentuales: la versión financiera de la brecha de producción (ficha `brecha-produccion`).

**Regla del BCBS (2010):** el colchón se empieza a activar cuando la brecha supera **2 puntos** y llega al máximo (2,5 % de los APR) con una brecha de **10 puntos** o más **[comprobar]** (duda 8 de la 1D01: no lo comprobó el verificador). Positiva y creciente: auge del crédito; negativa: crédito por debajo de su tendencia, no procede activar (y conviene liberar si estaba activado). Desde 2024 el Banco de España fija un colchón positivo en una fase de riesgo «estándar» **[comprobar el porcentaje vigente]**.

**Cautelas:** tras un desapalancamiento largo la tendencia estadística arrastra la brecha (falsas señales negativas); por eso se completa con otros indicadores (precio de la vivienda, servicio de la deuda, crédito nuevo).

**Gráfico de referencia:** ratio crédito/PIB y su tendencia, con la brecha en barras. Sin `.tex` aún.

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.B.27 | Regulación financiera | Desarrollo | Colchón anticíclico, regla y crítica | — |
| 3.A.42 | Ciclo financiero | Resumen | La brecha como medida del ciclo financiero | La regla regulatoria |
| 4.A.19 | Sector bancario español | Resumen | Decisiones del Banco de España | La regla |
| 1D01 | Dictamen de coyuntura | Uso | Definición, umbral de 2 puntos, qué hacer en cada fase | La estimación |

## Divergencias encontradas en el temario actual
- La 1D01 remite la brecha crédito-PIB a `\vertema{3.A.42}` (cuerpo y anexo A); con esta ficha conviene añadir `\vertema{3.B.27}` (pendiente menor de la 1D01, ver `pendientes-coherencia.md`).

Autor: Víctor Gutiérrez Marcos
