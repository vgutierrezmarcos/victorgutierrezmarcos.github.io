## Lo que no se encontró o se cambió

- **Saldo estructural 2007-2009**: AMECO solo lo da desde 2010 para España (celdas en blanco).
- **CET1 y préstamos dudosos antes de 2014**: los datos bancarios consolidados del BCE (CBD2) empiezan en 2014 con la definición de Basilea III y FINREP; para 2008-2013 habría que acudir al Boletín Estadístico del Banco de España (otra definición), que no se ha descargado ni se mezcla. ROE y ROA de España desde 2008.
- **Tasa de vacantes 2007-2009**: la serie de Eurostat (jvs_q_r21) salta de 0,7 % (4T2009) a 1,4 % (1T2010) sin marca de ruptura; el cuadro y el gráfico de Beveridge la dan desde 2010.
- **Paro de la zona del euro y paro de larga duración 2007-2008**: une_rt_a y une_ltu_a empiezan en 2009.
- **Exportaciones de alta tecnología**: tipsex12 llega a 2022 (Eurostat no la ha actualizado). **Gasto en I+D**: hasta 2024.
- **Previsiones 2026-2027**: solo en las filas que AMECO publica. No hay previsión de contribuciones ni de la balanza por componentes. Las del Banco de España de septiembre de 2026 no se descargaron (sin enlace legible por programa): una sola fuente, la Comisión. Pendiente: actualizarlas con las de otoño (17/11/2026; ver README.md).
- **AMECO frente a Eurostat**: AMECO (mayo de 2026) es anterior a la última revisión del INE: PIB de 2025 +2,8 % en AMECO y +2,6 % en Eurostat; deuda de 2025, 100,7 % frente a 100,5 %. Brecha, potencial y saldos ajustados: AMECO en toda la serie.
- **IPCA anual**: prc_hicp_aind (ECOICOP ver. 1, hasta 2025); el mensual de 2026, prc_hicp_minr (ECOICOP ver. 2). En 2025 coinciden (2,7 %).
- **Calificación crediticia**: no hay fuente oficial (las agencias son privadas); no se incluye. **Vida media de la deuda y tenedores**: el Tesoro los publica en PDF, sin API; no se incluyen.
- **Colchón de capital anticíclico (macroprudencial)**: no se encontró una serie descargable por programa (Banco de España/JERS); no se incluye. La pregunta 8 se responde con las ratios bancarias, el crédito, la deuda privada y el precio de la vivienda.
- **Exportaciones a EE. UU. (sql_comex)**: la base interna de DataComex no estaba accesible desde la herramienta; se usó Comext de Eurostat.
