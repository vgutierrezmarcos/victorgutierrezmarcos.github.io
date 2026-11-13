# 3.B.16 — Teoría de la integración monetaria: informe de revisión

11/11/2026. Fuente: `fuentes/3B16/3B16.tex` (LyX con tex2lyx). Rama `revision-temario`; nada publicado.

## 1. Resumen

- Tema reescrito en LaTeX sobre el Word de Víctor, con los 3 apartados del original y sus títulos de segundo nivel en su orden (los de primer nivel, acortados: D3). Minutos: introducción 2′30″, I 11′, II 9′, III 6′30″, conclusión 1′ (30′).
- Errores de teoría y de datos corregidos (McKinnon, notación de Magnifico, uniones «incompletas» de la introducción, fechas de Ingram, Frankel y Rose y Rose, federalismo fiscal atribuido a Mundell, PEC y Europa 2020 caducos), con todas las cifras al último dato oficial y citadas.
- Huecos del título cubiertos: beneficios y credibilidad (Barro-Gordon y «atarse las manos»), evidencia, críticas de los 80, fragilidad de De Grauwe (2011) y prestamista de última instancia, política fiscal en la unión (Galí y Monacelli), unión bancaria y fiscal al día.
- El modelo centro-periferia sale del cuerpo (está en el 3.B.6): queda su resultado (Krugman, 1993) en pocas líneas con remisión al 3.B.6, sin anexo (decisión del 12/11/2026). Anexos nuevos: otras uniones monetarias y la salida de una unión; test con el enlace genérico al simulador.
- 7 gráficos TikZ nuevos o copiados (mundell, mundell-devaluacion, amo-flexibilidad, costes-beneficios, endogeneidad hechos; circulo-vicioso y logica-amo pedidos) más 2 copiados sin cambios (joroba, barro-gordon; el tomahawk se quitó el 12/11/2026). 109 entradas en `3B16.bib`.

## 2. Errores corregidos

| Dónde | Decía | Dice ahora |
|---|---|---|
| Introducción (l. 89-111) | Uniones «incompletas» con política monetaria nacional, con la UEMOA y una «Unión Monetaria de América Central» como ejemplos; «la UE es una unión monetaria completa» | Seudounión cambiaria frente a unión cambiaria completa (Corden, 1972); la UEMOA tiene banco central común (BCEAO, anexo de otras uniones); la unión es la zona del euro. «Incompleta» se usa solo en III (sin unión bancaria ni fiscal) |
| Introducción, enganche | Frase de Volcker, enganche del 3.B.13 | «El casado casa quiere» y Bulgaria (21 miembros, 2026) |
| I.1 | «Erga intra / erga extra» | Definiciones de área monetaria y AMO según Mundell (1961), sin latinismos |
| I.2, McKinnon | $\Delta CC/\Delta Y=-m\Delta Y=\dots$ (dimensionalmente incorrecta), $\Delta Y=\Delta G/(1-c+m)$ | $\Delta Y=\Delta\overline G/[1-c(1-t)+m]$, $\Delta\mathrm{XN}=-m\Delta Y$, $\Delta Y/\Delta\mathrm{XN}=-1/m$ (`eq:mckinnon`) |
| I.2, Magnifico | $e=E P^*/P$, $\gamma e=\gamma E+(\pi^*-\pi)$ | $q\equiv EP^*/P$, $\gamma_q\simeq\gamma_E+\gamma_{P^*}-\pi$ (`eq:magnifico`) |
| I.2, Ingram | — | Ingram (1959) y (1973) comprobados en Crossref (ver Dudas) |
| I.2, figuras 3 y 4 | «Shock *transitorio*… con *mobilidad*» | Son del permanente: filas b y c de `fig:mundell` |
| I.2, nota 17 | 3.ª función «ante shocks simétricos»; «cambo»; atribuida a Eichengreen | «aseguradora ante perturbaciones asimétricas»; sin atribuirla a Eichengreen (ver Dudas) |
| II.2.2 | Frankel y Rose (1999) | (1998), *Economic Journal* |
| II.3 | «Ross (2000)»; Bertola y Blanchard y Soskice (2001) sin obra | Rose (2000); Alesina, Ardagna y Galasso (2011) (ver Dudas) |
| II.2.1, modelo centro-periferia | Tabla de mecanismos con errores de signo, γ y μ con 2 sentidos | Sale; resumen del resultado en el cuerpo con \vertema{3.B.6}, sin anexo (12/11/2026) |
| II.4 | Costes de transacción «0,25-0,5 % del PIB» | «En torno al 0,4 %» (Comisión, 1990) |
| III.3.1 | Federalismo fiscal «tal y como proponía Mundell» | Kenen (1969) |
| III.3.2 | PEC «3 % y 60 %»; «Estrategia Europa 2020»; frase duplicada («en ausencia de una integración completa» 2 veces) | Senda de gasto primario neto desde 2024 (Reglamentos 2024/1263 y 2024/1264) con los valores de referencia; Semestre Europeo; reescrita |
| III.2 | «750 puntos básicos» como si fuera un dato | «Por ejemplo, con una prima de riesgo de varios cientos de puntos básicos» (era un ejemplo hipotético, V50) |
| III.2 | «el reciente programa PSPP» | SMP (2010), OMT (2012), APP (2014; deuda pública 2015), PEPP (2020), fin de reinversiones (julio de 2023 y finales de 2024), TPI (2022): las fechas del 3.A.36 y el 3.A.39 |
| Conclusión | «Fondo de Reconstrucción»; manifiesto que «propone una mayor integración fiscal» | NextGenerationEU; Bénassy-Quéré *et al.* (2018), que combinan reparto de riesgos y disciplina de mercado (en III.3.1) |
| Nota 6 | «Sus dos únicas contribuciones»; Reinhart «economista jefa» (hoy) | Tono y datos corregidos (Mundell, 1932-2021; Reinhart, 2020-2022) |
| Anexo 3 | Sin título ni fuente; «reevaluación interna» | «La crisis del euro y la respuesta institucional», con Sanchis i Marco (2014); revaluación |
| Clave `GiavazziPagano1988Advantage` | pp. 1077-1082 y DOI del comentario de Obstfeld | pp. 1055-1075, DOI 10.1016/0014-2921(88)90065-7 (aquí; en otros temas, ver Coherencia) |
| DOI de `Eichengreen1990One` y `DecressinFatas1995Regional` | 10.2307/1344475; erróneo | 10.2307/1344577; 10.1016/0014-2921(94)00102-2 |

## 3. Marcas resueltas

| Marca | Original | Qué se hizo |
|---|---|---|
| P1 (comentario) | «Ver Gandolfo pág. 529 y añadir definición informe Werner» | Definición del Informe Werner (fuente primaria) y Delors en la contextualización; Gandolfo (2016) no se cita (p. 529 no comprobada) |
| P2 (amarillo) | Impulsos contrarios a Schengen (2016) | Controles en fronteras interiores al día: 8 países en noviembre de 2026; reforma del Código de fronteras de 2024 |
| P3 (amarillo) | «Frankel y Rose (con la hipótesis de …)» | Hipótesis de la endogeneidad (1998) |
| P4-P5 (amarillo) | Condiciones de equilibrio del centro-periferia incompletas | El modelo sale (está en el 3.B.6); no hacen falta |
| P6-P11 (amarillo) | La integración monetaria reduce costes de comercio → aglomeración | Integrado en II.2.1 (Krugman, 1993) y en el anexo de especialización |
| P12 (notas al opositor) | Aviso del cambio de temario y ficha ICEX-CECO | Fuera; la estructura propuesta se tuvo en cuenta (beneficios, fragilidad, política fiscal) |
| P13 (comentario) | Enlace de YouTube | Es la conferencia de Óscar Vara «El euro como zona monetaria (no) óptima» (2019): caja de anotaciones de la introducción (`Vara2019Euro`) |
| P14 (comentario) | Ligar los criterios entre sí | Criterios ordenados por las 3 dimensiones de De Grauwe, con columna «Dimensión» en `tab:criterios` y nexos; nombre del preparador fuera |
| P15 (comentario) | Títulos según «Gandolfo, *Tablas de Economía de la UE*» | Obra no localizada; no se cita (ver Dudas) |
| P16 (comentario) | Coordinar con el anexo del 3.A.19 (hoy 3.A.27) | Calmfors-Driffill resumido con `joroba` copiado del 3.A.27 y `\vertema{3.A.27}` |
| P17 (comentario) | Coordinar con 3.B.6, 3.B.9, 3.B.10 | Resultado aquí, modelo en el 3.B.6 (D1) |
| P18 (comentarios) | Desarrollar Barro-Gordon (De Grauwe, pp. 41 y ss.) | Credibilidad en II.4 con a)-d), `eq:sesgo` y `fig:credibilidad` |
| P19 (comentario) | «Es un poco lioso… hay que reestructurar» | Reordenado por debajo de los títulos; no se publica |
| P20-P24, P26 (figuras) | Imágenes 1-4, nota 13, imagen 6 | TikZ: `mundell` (3 filas), `mundell-devaluacion` (caja gris), `amo-flexibilidad`, `endogeneidad`; la superficie 3D sale. La imagen 6 citaba el tema de otro opositor: fuente cambiada a De Grauwe (2022) |
| P25, P29 | Calmfors-Driffill y *tomahawk* escaneados | `joroba` (3.A.27) copiado sin cambios; el `tomahawk` (3.B.6) se copió y se quitó el 12/11/2026 con su anexo |
| P27, P32 | Tablas de criterios y de ventajas | `tab:criterios` y `tab:beneficios-costes` en LaTeX con color |
| P28, P30 | Miniaturas y tabla de mecanismos del centro-periferia | Salen con el modelo (están en el 3.B.6) |
| P31, P33 | Capturas «Size matters» y «¿La Zona Euro es un AMO?» | La idea de tamaño, en II.1 de palabra; la captura, como `tab:zona-euro-amo` con datos al día (caja gris) |
| Anexo 1 | Diagrama escaneado de Baldwin y Wyplosz | Pedido en TikZ (`logica-amo`) |
| Nota 2 | Espectro de regímenes del FMI | Una línea con el AREAER de 2023 en la caja de anotaciones (`\vertema{3.B.15}`) |
| P34-P39 | Pendientes del canon | Cumplidos (credibilidad, joroba, OA-DA con $q$, libra en 1992 con fuente del Banco de Inglaterra, Galí y Monacelli) |
| P40-P52 | Errores | Ver sección 2 |
| P53-P59 | Huecos | Ver sección 5 |
| P63-P65 | Comentarios, nombres de preparadores, `file:///`, quia.com | Fuera; obras citadas sin enlace local; test con el enlace genérico al simulador (anexo) |
| P66 | Preguntas de otros exámenes | `notaopositor` al final de III, con dónde está la respuesta |

## 4. Datos actualizados

Fecha de consulta: 11/11/2026 salvo que se diga. Detalle completo y segunda comprobación en `_trabajo/propuestas-datos.md` (V1-V53) y en `datos-actualizables.yaml`.

| Dato | Antes | Ahora | Fuente | URL | 2.ª comprobación |
|---|---|---|---|---|---|
| Miembros de la zona del euro | 19 | 21 (Bulgaria, 1/1/2026) | Comisión, BCE | https://economy-finance.ec.europa.eu/euro/eu-countries-and-euro_en | BCE (`BCE2026Bulgaria`) |
| Regímenes del FMI | sin fecha | 44,8 % blando, 32,5 % flota, 13,4 % duro (30/4/2023) | FMI, AREAER 2023 | elibrary.imf.org | 3.A.32 (mismas cifras) |
| Controles Schengen | 2016 | 8 países en noviembre de 2026 | Comisión (DG HOME) | home-affairs.ec.europa.eu | Reglamento (UE) 2024/1717 |
| Movilidad intra-UE | — | unos 10 millones, menos del 4 % de 20-64 años | Eurostat `migr_pop1ctz` | ec.europa.eu/eurostat | Comisión (10,1 millones) |
| Comercio intrazona | UNCTAD 2015, 23 % de las importaciones mundiales | 47,6 % de las exportaciones en 2025 (52-53 % en 2002-2007) | Eurostat `ext_st_easitc` | ec.europa.eu/eurostat | Comext (46,8 %) |
| Apertura | — | 69 % España, 78 % Alemania | Eurostat `nama_10_gdp` | ec.europa.eu/eurostat | Banco Mundial |
| Inflación España/Alemania | — | 1999-2008: +37 %/+18 %; 2008-2019: +13 %/+15 %; 2022: 5,9 % Francia, 19,4 % Estonia | Eurostat `prc_hicp_aind` | ec.europa.eu/eurostat | 3.A.32 |
| Sincronía | — | factor común >65 %; Grecia 0,3-0,5 frente a 0,8 España | BCE (2018); Eurostat | — | CSV en `_trabajo/datos/` |
| Presupuesto UE | — | 190.100 M€ en 2026, ~1 % del PIB; EE. UU. 23 % | PE; CBO | — | CBO bloquea: comprobación indirecta |
| Fondo Único de Resolución | — | más de 81.000 M€ (31/12/2025) | JUR | https://www.srb.europa.eu/en/content/2026-srf-contributions-cycle | Informe al Eurogrupo (mayo de 2026) |
| EDIS | propuesta | sin aprobar (propuesto el 24/11/2015) | Comisión, COM(2015) 586 | eur-lex.europa.eu | 1D01 |
| Programas del BCE | «el reciente PSPP» | SMP, OMT, APP, PEPP, TPI con fechas | BCE | ecb.europa.eu | 3.A.36 y 3.A.39 |
| NGEU | «Fondo de Reconstrucción» | 750.000 M€ de 2018, MRR hasta 2026 | Comisión; Reglamento (UE) 2021/241 | commission.europa.eu | 3.A.04 |
| PEC | «3 % y 60 %» | senda de gasto primario neto (4-7 años) desde 2024 | Reglamentos 2024/1263 y 2024/1264 | eur-lex.europa.eu | 3.A.39 |
| Stiglitz (anexo) | «PIB per cápita apenas creció 2007-2015» | 28.800 € (2007) frente a 28.930 € (2015); paro 12,2 % en 2013 | Eurostat `nama_10_pc`, `une_rt_a` | ec.europa.eu/eurostat | EA20 frente a EA21 |
| Uniones del franco CFA (anexo, nuevo) | — | UMOA 8 Estados (BCEAO), CEMAC 6 (BEAC), 655,957 francos por euro | BCEAO; BEAC | https://www.bceao.int/fr/content/presentation-de-la-bceao; https://www.beac.int | Las 2 webs (cotización del 11/11/2026) y AREAER |
| Grecia, junio de 2015 (anexo, nuevo) | — | cierre de bancos y controles de capital tras mantener el BCE el techo de la liquidez de emergencia | BCE, nota de 28/6/2015 | https://www.ecb.europa.eu/press/pr/date/2015/html/pr150628.en.html | La nota no dice el cierre (hecho conocido) |

## 5. Contenido añadido

- **Introducción**: los 5 bloques; Werner (1970), Delors (1989), Corden (1972), Tinbergen (1954); unión monetaria como anclaje duro con el AREAER; convención del tipo de cambio.
- **I**: Mundell con la estructura a)-e) y la devaluación interna (Schmitt-Grohé y Uribe, 2016); escenarios benigno y maligno (De Grauwe); evidencia de movilidad (Blanchard y Katz, 1992; Decressin y Fatás, 1995); carta del BCE de 2011; cuánto aseguran el presupuesto federal y los mercados (Asdrubali, Sørensen y Yosha, 1996); instituciones laborales con la joroba; McKinnon corregido; línea AMO; críticas de los 80 y «Mundell II» (Mundell, 1973; McKinnon, 2004).
- **II**: costes y beneficios frente a la apertura y al tamaño; Krugman (1993) con a)-c); Frankel y Rose (1998) con su evidencia (BCE, 2018; Campos, Fidrmuc y Korhonen, 2019); evidencia (Bayoumi y Eichengreen, 1993; Rose, 2000; Rose y Stanley, 2005; Glick y Rose, 2016; Polák, 2019; Alesina, Ardagna y Galasso, 2011); tabla «¿Es la zona del euro un AMO?» con los 7 criterios; beneficios micro, credibilidad con Barro-Gordon y Giavazzi-Pagano (con la libra en 1992 y Rogoff, 1985), geopolíticos; costes adicionales; terceros países (Bayoumi, 1994).
- **III** (nuevo en gran parte): la fragilidad de De Grauwe (2011) con a)-d) (equilibrios múltiples, Calvo, 1988; Reino Unido frente a España; prestamista de última instancia; Draghi, 2012); el círculo vicioso con sus 5 pasos y en los 2 sentidos (`fig:circulo-vicioso`); contagio por balances, flujos (TARGET), moneda común y reversibilidad; monetización con los programas del BCE, la dominación fiscal, el art. 123 del TFUE y las sentencias *Gauweiler* (2015) y *Weiss* (2018); unión bancaria (MUS, MUR con el FUR, EDIS sin aprobar), Unión de Ahorros e Inversiones, unión fiscal de Kenen, NGEU y Bénassy-Quéré *et al.* (2018); solución imperfecta con Galí y Monacelli (2008), Nakamura y Steinsson (2014), la devaluación fiscal (Farhi, Gopinath e Itskhoki, 2014), el art. 125 del TFUE y las reglas de 2024.
- **Conclusión**: los 5 bloques; idea final que responde a la pregunta del enganche y retoma el refrán.
- **Anexos**: lógica de las AMO (TikZ pedido); Stiglitz (con datos de Eurostat y contrapunto); crisis del euro y respuesta; otras uniones y la salida de una unión (nuevo, D4); test.

### Propuestas: aplicadas y no aplicadas

- **Contenido (C1-C52)**: aplicadas todas, con estas desviaciones:
  - C2 sin Gandolfo (2016); C8 con el orden de K8; C9 en 3 filas; C10 en `figuracaja` (K18); C11, C17, C18 con las cifras de datos; C13 sin atribuir las 3 funciones a Eichengreen (V41); C14: Ingram (1959) se mantiene; C16 sin la fórmula del IPC; C20 con el nombre `amo-flexibilidad`; C22/C27: frente a la apertura y al tamaño, en II.1; C25 sin «0,4 → 0,6»; C26 sin «50 %» ni «2-6 %» y con Alesina *et al.* en vez de Bertola-Blanchard y Soskice; C41 con `Vara2019Euro`.
  - C3 (minutos 10/9,5/7 y etiquetas `sec:incompleta`, `sec:fragilidad` de III.2): se usan los minutos y etiquetas de coherencia (11/9/6,5; `sec:incompletas`); `sec:fragilidad` sí existe, como III.2.1.
  - C30: el título no lleva `\cortetitulo` (cabe en una línea en el PDF).
  - C31: la fragilidad se cuenta como modelo (a)-d)) y la comparación Reino Unido-España va sin años (C31 dudaba del periodo).
  - C32: sin Basilea; «750 pb» → ejemplo genérico.
  - C33, C34, C35: aplicadas con los textos de V33, V34 y V32; la viñeta de NGEU con V36 y la del manifiesto con V37.
  - C36: aplicada; Bénassy-Quéré *et al.* en III.3.1, no en la opinión (no repetir). C36 remitía a un `anexo:salida`: la salida va dentro de `anexo:otras-uniones` (D4).
  - C42: aplicada en `notaopositor` al final de III.
  - C43: pedido en TikZ.
  - C44: aplicada (cita del libro y del artículo; contrapunto).
  - C45: aplicada con el texto del original (que se conserva entero) y sin los hitos de los rescates a cada país, que C45 daba sin fuente.
  - C46: aplicada en el anexo de otras uniones, con De Grauwe (2022) en vez de (2018) y la nota del BCE de 28/6/2015.
  - C47: aplicada sin el párrafo del *eco* (reforma de 2019, salida de Burkina Faso, Malí y Níger de la CEDEAO en 2025): no se ha podido comprobar en una fuente primaria. La UMOA en vez de la UEMOA para el banco central (el BCEAO es el de la UMOA, según su web).
  - C48-C51: para la fase canon (Coherencia).
- **Datos (V1-V53)**: aplicadas todas salvo V11 (Ingram 1962 en vez de 1959: rechazada, Crossref confirma Ingram, 1959, *QJE* 73(4), 619-632) y V52 (obra no localizada). V40-V42 y V50, con lo dicho arriba.
- **Coherencia (K1-K41, D1-D5, CC1-CC8)**: aplicadas K1-K41 y D1-D5 con las opciones recomendadas. K20 con la fuente del Banco de Inglaterra (`Eichengreen2008Globalizing` no existe). CC1-CC8 los aplica la fase canon.

## 6. Coherencia

Cambios en este tema: notación del canon ($q$, $\gamma_q$, $\gamma_{P^*}$, $\mathrm{XN}$, $\mathrm{DA}_{\mathrm{ES}}$); «zona del euro» y «perturbación»; remisiones con `\vertema` a 3.A.6, 3.A.27, 3.A.32, 3.A.36, 3.A.38, 3.A.39, 3.A.40, 3.B.6, 3.B.10, 3.B.11, 3.B.12, 3.B.14, 3.B.15, 3.B.17, 3.B.19, 3.B.26, 3.B.37, 3.B.40, 3.B.43, 3.B.44, 3.B.45, 4.A.16 y 4.A.28; promesas de otros temas cumplidas (3.B.10, 3.A.32, 3.A.27, 3.A.6/3.A.28/3.A.36, 3.A.38, 3.A.39, 3.A.40, 3.B.11); fragilidad, OMT y TPI con las palabras y claves del 3.A.39 y el 3.A.36; Galí-Monacelli y Nakamura-Steinsson con las del 3.A.32, 3.A.38 y 3.A.40; el centro-periferia, resumen del resultado con \vertema{3.B.6}, sin anexo (12/11/2026).

**Lo que hay que cambiar en otros temas** (no se ha tocado ninguno; para `canon/pendientes-coherencia.md`):

1. **Clave `GiavazziPagano1988Advantage` mal en 3A06, 3A28 y 3A36**: pp. 1077-1082 y DOI 10.1016/0014-2921(88)90067-0, que es el comentario de Obstfeld. Correcto: *European Economic Review* 32(5), 1055-1075, DOI 10.1016/0014-2921(88)90065-7 (corregida en `3B16.bib`).
2. **Ficha `areas-monetarias-optimas`, filas del 4.A.28 y 4.A.30**: el 4.A.28 es «Evolución de la economía española desde la constitución de la zona euro hasta 2019» (la mención «one size fits all» encaja, la pregunta no es «política monetaria y España»); el 4.A.30 es «Relaciones financieras de España con la UE… convergencia real», no «España en la UEM»: convergencia real y presupuesto de la UE como seguro pequeño, o quitar la fila.
3. **`mapa.yaml`, modelo `centro-periferia`**: «3.B.16: desarrollo» → «resumen del resultado (Krugman, 1993); *tomahawk* copiado del 3.B.6 en un anexo, sin derivación» (CC2); el 12/11/2026, «resumen del resultado, sin anexo». La ficha `centro-periferia` usa γ en sus ecuaciones: cambiar a μ (D019, 3.B.6).
4. **Alias**: `de-grauwe-coste-beneficio` y `frankel-rose` → alias de `areas-monetarias-optimas` (CC1), con los gráficos de referencia `mundell`, `costes-beneficios`, `amo-flexibilidad` y `endogeneidad` de este tema.
5. `mapa.yaml`, entrada del 3.B.16: la de coherencia (sección 5.3 de `propuestas-coherencia.md`).
6. Fichas `barro-gordon` (3.B.16 como resumen aplicado; alias `giavazzi-pagano`), `doom-loop`, `union-bancaria`, `pec`, `mede`, `semestre-europeo`, `papel-internacional-euro`, `criterios-convergencia-nominal`, `oa-da`, `tipo-cambio-real`, `calmfors-driffill` y `notacion.md` § 9: filas del 3.B.16 (CC3-CC8).
7. Opcionales: 3.A.6 (l. 740), «desaparece el *trade-off*» → «desaparece el sesgo inflacionista»; 3.B.10 (l. 778), la moneda común y la concentración de la industria.
8. «Atarse las manos» se desarrolla aquí (D2): el 3.B.15, cuando se revise, lo resume en una línea con `\vertema{3.B.16}`.

## Puesta al día con las reglas de esta rama (13/11/2026)

Tema traído de la rama `revision-temario`; puesto al nivel de los temas de `revision-temario-2` sin quitar contenido. PDF construido con `--solo pdf --no-publicar` (31 páginas de tema, 4 de anexos, 7 de bibliografía); `verificar-tema.py` sin errores propios (solo los de «anterior a la fuente» del PDF, HTML y Word publicados).

| Regla | Cómo se ha aplicado |
|---|---|
| Citas (5.ª tanda) | 105 `\parencite` → `\nocite` con `quitar_citas.py`; las 2 `\cite` de «cálculo propio con datos de Eurostat» (II.2.2 c y tabla de la zona del euro), también a `\nocite`; el `\parencite` del pie de `fig:credibilidad` pasa a «como muestran \textcite{GiavazziPagano1988Advantage}». Frases revisadas: ninguna queda coja. Los `\textcite` que quedan son obras originales (Mundell, McKinnon, Kenen, Krugman, Frankel y Rose…) o De Grauwe como autor de la idea (escenarios benigno/maligno, 3 dimensiones). |
| Plantilla (7.ª tanda) | Anexo de test con la caja estándar (`tema=3.B.16`); fuera la entrada `GutierrezMarcos2026Simulador` del `.bib` (nunca se cita a Víctor). `tcefecha` a 13/11/2026. Títulos: ya tenían `\cortetitulo` donde hacía falta; `verificar-tema.py` no avisa. |
| Gráfico / Figura / Imagen | `circulo-vicioso` y `logica-amo` (cajas y flechas, árbol de preguntas) pasan a `infografia` con `figu:` («la figura»). Los otros 7 son gráficos (ejes o curvas). No hay imágenes pegadas. |
| Pegatina (8.ª tanda) | Fuera la etiqueta «Pegatina:»; el refrán «Arrímate a los buenos y serás uno de ellos» (aprobado por Víctor el 12/11/2026, duda 13) queda integrado en la frase que explica la credibilidad prestada. |
| Resultados clave en morado | El sesgo inflacionista de Barro-Gordon (`eq:sesgo`) pasa a `\funcionclave`. McKinnon y Magnifico se quedan como ecuaciones corrientes (no son el resultado clave del tema). |
| Estructura a)-e) | Los modelos con estructura (Mundell, Krugman, Frankel y Rose, credibilidad, fragilidad) ya la tenían, con letras seguidas. Los criterios de Kenen, Ingram, Magnifico y McKinnon siguen como criterios con «Idea / Mecanismo / En la zona del euro» (duda 19). |
| Términos en inglés | Añadidos la primera vez: *pseudo exchange-rate union* y *complete exchange-rate union* (Corden), *moral hazard*, *home bias*, *cluster* (como «aglomeración industrial»), *trade-off* («disyuntiva»), *time inconsistency*, *lender of last resort*, *sudden stop*. |
| Nobel (revisión transversal) | Nota con el motivo oficial en la primera mención: Tinbergen (1969, con Frisch), Samuelson (1970), Tobin (1981, dentro de la nota de Mundell), Ohlin (1977, dentro de la nota de la nueva geografía), Lucas (1995), Mundell (1999, nota reescrita con el motivo literal), Stiglitz (2001; fuera la aposición «premio Nobel en 2001» del anexo), Krugman (2008). Contribuciones de premiados añadidas donde encajan: Kydland y Prescott (2004; inconsistencia temporal en la idea de la credibilidad, con `KydlandPrescott1977Rules`), Diamond y Dybvig con Bernanke (2022; los pánicos bancarios como lógica de la fragilidad de la deuda, con `DiamondDybvig1983`) y Hall y Woodford (2026; nota en Galí y Monacelli: el modelo neokeynesiano de `Woodford2003Interest` extendido a la unión). Entradas copiadas de otros temas: `Nobel1969`, `Nobel1970Samuelson`, `Nobel1977MeadeOhlin`, `Nobel1981Tobin`, `Nobel1995Lucas`, `Nobel2001AkerlofSpenceStiglitz`, `Nobel2004KydlandPrescott`, `Nobel2008Krugman`, `Nobel2022Bancos`, `Nobel2026Prensa`. |
| 4.º ejercicio | Añadidos `\vertema{4.B.14}` (federalismo fiscal, en Kenen), `\vertema{4.A.21}` (saldos TARGET y posición del Banco de España) y `\vertema{4.A.18}` (rescate bancario español de 2012, en el círculo vicioso). Ya estaban 4.A.28 y 4.A.16. |
| Dichos | Se quedan «El casado casa quiere» (refrán inicial) y «Arrímate a los buenos…» (aprobado). No hay otros. |
| Pizarra, vídeo, «lo que se suele preguntar», enlaces a otros formatos | No había ninguno en el texto. |
| NEK en (x, π), identidad cuantitativa | No salen en este tema (el gráfico de Barro-Gordon está en el plano (U, π) y no es la NEK). |
| Ficha de repaso | El tema no tiene ficha (`repaso/` no existe); no se crea en esta puesta al día. |

## 7. Dudas abiertas

Cada una con la opción aplicada:

1. **Inflación de los socios**: $\gamma_{P^*}$, porque en II.4 $\pi^*$ es el objetivo de Barro-Gordon (A32-08, recomendado). Alternativa: $\pi^*$ para la exterior y $\pi^{\mathrm{obj}}$ para el objetivo.
2. **Ingram (1959 y 1973)**, no 1962: V11 rechazada con Crossref.
3. **Las 3 funciones del presupuesto federal** (nota de Kenen): no están en Eichengreen (1990); la nota se conserva sin atribuirlas. ¿De dónde salen? (¿Informe MacDougall, 1977?).
4. **Costes de transacción**: «en torno al 0,4 % del PIB» (Comisión, 1990) en vez del «0,25-0,5 %» del original, que no aparece en la fuente primaria.
5. **La peseta se devaluó varias veces en 1992-1993** (Eichengreen y Wyplosz, 1993): página no comprobada.
6. **Carta del BCE de 5/8/2011**: contenido según prensa (el PDF del BCE está escaneado).
7. **De Grauwe**: se cita la 14.ª edición (2022) en vez de la 12.ª (2018); las «pp. 41 y ss.» del comentario no se han comprobado en la 14.ª.
8. **Gráfico `barro-gordon`** copiado del 3.A.6 con la tentación T y los pasos intermedios; si se prefiere uno más sencillo (solo R y D, con la flecha de D a R), habría que pedir una variante.
9. **Obras sin localizar sustituidas**: Bertola y Blanchard y «Soskice (2001)» → Alesina, Ardagna y Galasso (2011); «Gandolfo, *Tablas de Economía de la UE*» no se cita.
10. **Centro-periferia** (D1). **Respuesta de Víctor (12/11/2026):** «resultado brevemente y remisión al tema 3.B.6, pero sin anexo». Aplicado: fuera el anexo de especialización con el *tomahawk* (y `graficos/tomahawk.*`); en II.2.1 queda el resultado de Krugman (1993) en pocas líneas, con el punto de ruptura de palabra y \vertema{3.B.6}.
11. **Títulos de primer nivel acortados** (D3), sin «(1960s-1970s)» ni «aplicación para el caso de la eurozona»; el I con `\cortetitulo` tras «:».
12. **Anexo de otras uniones y salida** (D4): aplicado, breve y sin cantar. Sin el *eco* ni la salida de Burkina Faso, Malí y Níger de la CEDEAO (sin fuente primaria comprobada); el número de miembros de la Unión del Caribe Oriental (8) se apoya en el AREAER (la web del ECCB devuelve 403).
13. **Refranes**: enganche «El casado casa quiere» (no usado en ningún otro tema) y pegatina «Arrímate a los buenos y serás uno de ellos» para la credibilidad. **Respuesta de Víctor (12/11/2026):** aprobados, el enganche y los refranes.
14. **Tabla «¿Es la zona del euro un AMO?»**: en caja gris en II.3 (no anexo) y con la diversificación cualitativa («en general, sí»), por no haber un indicador oficial sencillo.
15. **Grecia, junio de 2015**: el cierre de bancos y los controles de capital se citan con la nota del BCE del 28/6/2015, que no los menciona (dice que mantiene el techo de la liquidez de emergencia). Si prefiere, añadir el decreto griego.
16. **Reino Unido frente a España** (De Grauwe, 2011): sin años, porque no se ha comprobado el periodo exacto en esa versión.
17. **Pista para la duda 3** (control de calidad, 11/11/2026): Cabado (DCE 3.B.22, 22.A.1) cita a Eichengreen (1990, pp. 138-139), que distingue 2 justificaciones del federalismo fiscal en Estados Unidos (redistribución y seguro entre regiones), y de ahí saca las 3 funciones (igualadora, estabilizadora, aseguradora). Si se quiere atribuir, sería «a partir de Eichengreen (1990, pp. 138-139)», comprobando la página.
18. **Metáfora de la casa** (control de calidad): Cabado tiene en una nota la de «compartir moneda es como compartir un piso». El enganche y la idea final del 3.B.16 («El casado casa quiere», «compartir moneda exige compartir también la casa») no la copian, pero la imagen se parece. ¿Le vale o prefiere otro refrán?

19. **Criterios sin estructura a)-e)** (13/11/2026): Kenen (fiscal y diversificación), Ingram, Magnifico y McKinnon se quedan con «Idea / Mecanismo / Límites / En la zona del euro», porque son criterios y no modelos completos. Opciones: (a) dejarlos así; (b) darles a)-e) con títulos de nivel 4 y 5, lo que alarga I.2 unas 2 páginas. **Aplicada: (a)**.
20. **Contribuciones de premiados añadidas** (13/11/2026): Kydland y Prescott, Diamond y Dybvig y Hall y Woodford entran en una frase o una nota, no en el cuerpo del cante. Opciones: (a) así; (b) quitarlas si se ven como relleno. **Aplicada: (a)**.

## 8. Instrucciones para el vídeo

- **Introducción** (sin pizarra, `modo: guion`): enganche con el refrán «El casado casa quiere» y Bulgaria (21 miembros); la pregunta que recorre todo: «¿cuándo compensa a un país renunciar a su moneda y a su tipo de cambio propios? Y, si renuncia, ¿qué casa común hace falta?». Estructura con los 3 apartados.
- **I.1**: de palabra; como mucho, las 3 cosas que se pierden.
- **I.2**:
  - `fig:mundell` por capas, imprescindible: fila a (perturbación: A → B), fila b (flexibilidad salarial: España W↓ P↓ q↑, Alemania W↑ P↑ q↑, C en $Y^n$); la fila c (movilidad: OA′ y $Y^n$ a la izquierda en España y a la derecha en Alemania, C en $P_0$ sobre la DA′) de palabra sobre el mismo dibujo o como apoyo.
  - `tab:criterios` en versión mínima (autor + criterio + dimensión), que se rellena criterio a criterio y se queda hasta I.3.
  - La joroba (`fig:joroba`) en 20″.
  - Las ecuaciones de McKinnon (`eq:mckinnon`, basta $\Delta Y/\Delta\mathrm{XN}=-1/m$) y de Magnifico (`eq:magnifico`), escritas.
  - La caja de la devaluación (`fig:mundell-devaluacion`), como apoyo.
- **I.3**: la línea AMO (`fig:amo-flexibilidad`; simetría en el eje vertical, flexibilidad en el horizontal).
- **II.1**: `fig:costes-beneficios` con el umbral $T^*$, imprescindible.
- **II.2**: `fig:endogeneidad` con las 2 trayectorias, imprescindible (es el gráfico conjunto del bloque: primero la línea AMO, luego el punto de partida, luego Frankel y Rose, luego Krugman).
- **II.3**: de palabra; la tabla de la zona del euro, como apoyo.
- **II.4**: `tab:beneficios-costes` en 3 filas; Barro-Gordon por capas (R, T, 2, 3, función de reacción, F = D) (el gráfico del 3.A.6, `fig:credibilidad`) y `eq:sesgo`; el refrán «Arrímate a los buenos y serás uno de ellos» junto a la credibilidad.
- **III**:
  - III.1, de palabra.
  - III.2: la fragilidad de palabra (el contraste Reino Unido-España, la cita de Draghi como apunte); la figura `figu:circulo-vicioso` en la pizarra, por capas (las 3 cajas, la perturbación, Estado → bancos, bancos → Estado, la economía real); los programas del BCE, como apoyo (línea de tiempo 2010-2022).
  - III.3: 2 columnas «perfecta / imperfecta», con 3 viñetas cada una (unión bancaria, unión fiscal, primeros pasos | Galí y Monacelli, devaluación fiscal, reglas de 2024). Es el esquema que queda al final del bloque.
- **Funciones clave que se conservan**: ninguna `\funcionclave`; entre bloques no se deja nada salvo, de I.2 a I.3, `tab:criterios` (sus 3 dimensiones son los ejes de la línea AMO).
- **Conclusión** (sin pizarra): empieza por «En conclusión,»; la idea final responde a la pregunta del enganche («compensa cuando las perturbaciones son simétricas o hay con qué absorberlas; si no, las instituciones tienen que hacer de seguro») y cierra con el refrán: «compartir moneda exige compartir también la casa».
- No se cantan: cajas grises, notas, la tabla de la zona del euro, la evidencia detallada, los programas del BCE fecha a fecha y los anexos.

## Correcciones del control de calidad (11/11/2026)

1. Tabla `tab:zona-euro-amo`: la caja `anotaciones` que la contiene es ahora `[unbreakable]`; título y tabla salen juntos (pág. 19 del PDF).
2. Misma tabla: anchos de columna con `\textwidth` (0,22 / 0,14 / 0,50), como `tab:criterios`; en Word las 2 tablas salen ya con la misma configuración.
3. II.3 «Comercio»: \textcite de Glick y Rose (2016), que rebajan la cifra con datos del euro, y el metaanálisis de Polák (2019) como cita aparte.
4. Reformulado sin calcar a Cabado: conclusión («En conclusión, todo el tema gira en torno a un balance…»), anexo E (salir es caro en sí mismo: redenominar deudas y contratos, frenar la fuga de depósitos) y II.2.1 c) (los trabajadores se trasladan a donde se concentra la industria y en Europa cambian poco de país).
5. Anexo A: nombres enteros (Ronald McKinnon, Peter Kenen, Robert Mundell), como en el gráfico de la lógica de las AMO.
6. Introducción: «la UMOA, pilar monetario de la UEMOA, y la CEMAC», igual que el anexo E.
7. Correlaciones de Grecia y España (II.2.2 c y tabla 2): «cálculo propio con datos de Eurostat».
8. I.2.1 d): el BCE «anunció que aplicaría activamente su programa para los mercados de valores (en la práctica, compró deuda española e italiana)».
9. I.3: la zona del euro queda por debajo de la línea AMO y Estados Unidos por encima.
10. Gráfico `barro-gordon` (`fig:credibilidad`): el texto de II.4 explica los puntos en orden (0 = R, 1 = T, 2, 3, función de reacción, F = D) y el pie lo resume; el título es ahora «El sesgo inflacionista: de la regla, R, al equilibrio con discreción, F = D», sin «atado a un ancla creíble», porque el dibujo no lo muestra; el efecto del ancla (D baja por la vertical $U^n$ hacia R) va en el texto y en la fuente.
