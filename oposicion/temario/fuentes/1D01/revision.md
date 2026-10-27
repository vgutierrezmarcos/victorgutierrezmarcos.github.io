# Revisión de 1D01 · Guía para el dictamen de coyuntura económica

Editor de /revisartema, 23-24/10/2026. Escrita en 4 partes (método y perfil cíclico; mercados de factores y competitividad; sector exterior,
políticas y recomendaciones; anexos). Este informe recoge las 4.

## Cuarta vuelta (25/10/2026)

Encargo: `_trabajo/comentarios-victor-24oct.md`, «Cuarta vuelta». Guía larga rehecha con las fuentes de D: (informes
`_trabajo/guias-d-comparacion-esquemas.md` y `-materiales.md`), más visual y coherente con el resumen.

### Páginas

- **Cuerpo: 74** (antes 50; objetivo «~70»). **Anexos: 32** (antes 37). **Bibliografía: 11** (169 → 206 entradas: 37 nuevas). Total 117.
- `verificar-tema.py 1D01`: **0 errores**; avisos: solo guion y vídeo pendientes (las cifras sin cita bajan de 9 a 0).
  0 líneas desbordadas. Revisadas a ojo las 36 páginas con gráficos o tablas: nada se solapa y no quedan huecos de más
  del 10 % en el cuerpo (la última página del cuerpo, al 30 %).
- Si hay que bajar a 70: lo más fácil sería devolver al anexo A la tabla de economías avanzadas y emergentes y la de
  hechos estilizados (≈ 1,2 págs.) o pasar al anexo B los cuadros «Ejemplo de redacción» del perfil cíclico (≈ 1,5 págs.).

### Qué ha cambiado

- **Gráficos de los anexos, al cuerpo, junto a su indicador** (14): ciclo y tendencia y 4 fases (I.2), comovimientos y
  tabla de hechos estilizados (I.2, nuevo párrafo «Hechos estilizados: cómo se mueve cada variable con el ciclo»),
  consumo-renta-ahorro (I.4), PIB y comercio mundial (I.4), Brent (I.5), empleo y horas, PIB por persona en edad de
  trabajar y Beveridge (II.1), IAPC (III.1), tipos y balance del BCE (V.1), impulso fiscal, inflación y cuentas públicas
  (V.3), *policy mix* (V.4). También al cuerpo: el caso del petróleo (I.5 «Un sector dominante»), la tabla de economías
  avanzadas y emergentes (I.6), **Okun y Phillips** (II.1, con la fórmula de Phillips en cuadro morado y la de Okun
  numerada) y las **reglas fiscales completas** (V.3).
- **Infografías del resumen en la guía** (14, copiadas de `repaso/graficos/rep-*.tex` a `graficos/` con nombre
  descriptivo y `\capa{n}` y marco fijo para el vídeo): `esquema-perfil-ciclico`, `-clu-margen`, `-tipos-paro`,
  `-ipc-deflactor`, `-origen-inflacion`, `-devaluacion`, `-cuenta-financiera`, `-tono-politicas`, `-canales-monetaria`,
  `-basilea`, `-semaforo-banca`, `-deuda-estabilizadora`, `-dato-recomendacion` y `-umbrales-pdm` (anexo A; en él el
  tipo de cambio real pasa a tener los 2 umbrales, $\pm3$). **2 nuevas**: `arbol-deficit-corriente` (árbol propio
  «financiar o ajustar», IV.4) y `canales-choque-externo` (anexo B). Todas con la paleta `dic…`. Pedidas en
  `_trabajo/graficos-pedidos.json`. No se ha usado `rep-calificaciones` (la tabla de calificaciones ya está en V.3).
- **Fórmulas en cuadros morados como en el resumen**: contribuciones (`eq:contribuciones`), identidad PAT, tasas del
  mercado de trabajo, CLU, tipo de cambio real, PIIN, regla de Taylor (`eq:taylor`), saldo estructural primario y
  esfuerzo (`eq:esfuerzo`); efecto base y Okun numeradas.
- **Énfasis** (código explicado en la introducción): **negrita** en palabras clave de cada viñeta; *cursiva* para
  rótulos, términos y matices; **subrayado** (`\uline`, paquete `ulem` con `normalem` cargado en el preámbulo de
  `1D01.tex`) en unas 40 ideas «para decir sí o sí» (1-2 por apartado). Sale en el PDF, en la web (`<u>`), en Word
  (subrayado sencillo) y en LyX (`\bar under`).
- **Anexos reordenados** (primero la economía, después el examen; pares pedidos por Víctor):
  A. **Indicadores, umbrales y fórmulas** (antes B y C): umbrales de un vistazo (infografía), tablas de indicadores
  (con deuda externa, su servicio, tasa de renovación y necesidades brutas de financiación nuevas), fórmulas
  imprescindibles partidas en 2 tablas (ahora con efecto base, PPA, Okun, saldo corriente que estabiliza la deuda
  externa, $b^{pe}$ y ROE), cálculos tipo (nuevo: saldo corriente que estabiliza la deuda externa) y lectura de series
  (lo que quedaba de «Los datos» del antiguo A). B. **Casos frecuentes y expresiones útiles** (antes E y K): nuevos
  «choque externo o geopolítico» (con gráfico), «crisis bancaria: liquidez, solvencia y resolución», «curva de Phillips
  plana: una lección de prudencia» y, dentro del brote de inflación, por qué fue baja durante años y por qué repuntó.
  C. **FMI, un caso de España y dónde se estudia cada bloque** (antes F, G y J): nuevo «escenario base y brecha de
  financiación» (presentación analítica, financiación excepcional, marco vigente de riesgo de tensión soberana).
  D. **El ejercicio y el método** (antes H) **y qué se ha preguntado** (antes I, ahora D.9): nuevo D.7 «Comprobaciones de
  coherencia entre bloques» y, en «dónde practicar», leer el artículo IV de un emergente.
  **Desaparecen** el anexo de hechos estilizados y el de gráficos de lectura (su contenido económico está en el cuerpo;
  «Los datos» va a A.4).
- **Huecos**: las figuras y tablas del cuerpo pasan de `[H]` a `[!htb]` (quedan en la página del párrafo o arriba de la
  siguiente); con `[H]` quedaban huecos de un tercio de página. En los anexos siguen en `[H]`.
- **Umbral de la vivienda del PDM: comprobado**. El cuadro vigente (desde el informe de alerta de 2025) usa el precio
  **nominal, +9 %** (Eurostat, *Statistics Explained*, «The Macroeconomic Imbalance Procedure (MIP) introduced», tabla 2,
  consultada el 25/10/2026). El 6 % **real** (deflactado) era el del cuadro anterior: se deja dicho en una nota al pie
  para quien lo vea en cuadros antiguos. No hay que corregir nada (tampoco en el resumen).

### Fuentes de D: incorporadas (prioridad alta y media), con fuente primaria propia

Nada copiado ni citado de otros preparadores; las ideas se redactan de nuevo y se citan con su fuente primaria.

| Bloque | Qué entra | Dónde | Fuente primaria |
|---|---|---|---|
| I | Contribución real frente a saldo nominal (efecto precio) | I.4 | (razonamiento; sin cifras) |
| I | Efecto sustitución y renta del tipo en el consumo; distribución de la renta | I.4, nota | FMI2022edXFPP |
| I | Inversión: coste de otros insumos; volatilidad cambiaria y de la inflación | I.4 | FMI2022edXFPP |
| I | Ahorro forzoso frente a precautorio; por qué la demanda embalsada sale despacio | I.4 | Eurostat2026nama10gdp |
| II | Efecto desánimo; acaparamiento de trabajo (productividad procíclica); efecto composición en los salarios reales | II.1 | INE2025EPA; Biddle2014LaborHoarding; Solon1994Composicion |
| II | Ajuste por cantidades o por precios (flexibilidad); NAIRU para toda la serie; secuelas de una recesión | II.1 | FMI2021WEOabr |
| III | Choque de oferta o de demanda (regla de precios y cantidades) | III.1 | Shapiro2022Oferta |
| III | Efectos directos, indirectos y de segunda ronda; pacto de rentas | III.1 | BdE2022InformeAnual2021 (cap. 4, comprobado en el PDF) |
| III | Inflación desigual por renta y percibida | III.1 | BCE2022RentaBaja |
| III | Causas de la baja inflación y del repunte | Anexo B.1 | BPI2022Inflacion |
| III | Inflación a largo plazo ≈ dinero menos crecimiento real | III.1 | McCandlessWeber1995 |
| III | Efecto valor y volumen (curva J); PPA relativa; Balassa-Samuelson y convergencia frente a exceso de demanda | III.2 | Rogoff1996PPA; Balassa1964; Samuelson1964 |
| III | Ancla cambiaria y sobrevaloración; defensa de un tipo fijo; entradas de capital y coste de esterilizar | III.2 | KrugmanObstfeldMelitz2018; Calvo1991Esterilizacion; FMI2012VisionInstitucional |
| IV | Exportaciones: oferta, precio-aceptante, diversificación, contenido importado, aranceles | IV.1 | FMI2022edXFPP; OCDE2023TiVA |
| IV | 3 combinaciones de saldos sectoriales (tabla nueva) | IV.1 | FMI2013CaseStudy |
| IV | Déficits y superávits razonables; superávit persistente (y fila nueva en la tabla de recomendaciones) | IV.1, VI.2 | FMI2013CaseStudy; BlanchardGiavazzi2002; CE2025AMR2026 |
| IV | Presentación analítica y financiación excepcional | IV.2 (pregunta) y anexo C.1 | FMI2009MBP6 |
| IV | Paridad con prima de riesgo, *carry trade*, factores de empuje y atracción, ciclo financiero mundial; lectura de la IED y la cartera | IV.2 | CalvoLeidermanReinhart1993; Rey2013Dilema |
| IV | Deuda a corto a vencimiento residual; deuda externa y servicio sobre exportaciones; tipo implícito, renovación; EMBI y CDS | IV.2-IV.3 y tabla del anexo A | FMI2014DeudaExterna; FMI2013CaseStudy |
| IV | Lista del signo del efecto valoración; tenedores no residentes; círculo flujo-stock | IV.3 | LaneMilesiFerretti2007; ArslanalpTsuda2014 |
| IV | Enfoque de balances (4 descalces; deuda en divisas entre residentes) | IV.3 | Allen2002Balances |
| IV | Saldo corriente sin intereses que estabiliza la deuda externa; frenazo y compresión de importaciones | IV.4 y anexo A | FMI2013CaseStudy; Calvo1998SuddenStops |
| IV/VI | Árbol del déficit corriente: financiar lo temporal, ajustar lo permanente; reductoras y desviadoras del gasto | IV.4 (gráfico propio) | FMI2013CaseStudy; Johnson1958 |
| V.1 | Objetivo aparente del banco central; tipo real frente al crecimiento (orientativo); tipo natural y sus determinantes | V.1 | RachelSmith2017 |
| V.1 | Retardos (29 meses de media); canal del crédito roto; deuda privada y transmisión | V.1 | HavranekRusnak2013; BernankeGertler1995 |
| V.2 | CAMELS; PER; CDS; sector empresarial (cobertura de intereses) | V.2 | FMI2013CaseStudy; CampbellShiller1998 |
| V.2 | Prestamista de última instancia, garantía de depósitos y herramientas de resolución | V.2 (remisión) y anexo B.1 | Bagehot1873; DiamondDybvig1983; DirUE2014BRRD |
| V.3 | Saldo estructural engañoso en los auges | V.3 | MorrisSchuknecht2007 |
| V.3 | Prociclicidad y sus causas; saldos alternativos (no petrolero, operativo, sin donaciones, aumentado) | V.3 | Kaminsky2004Rains; FMI2013CaseStudy |
| V.3 | Multiplicadores según el instrumento (cualitativo) y mayores de lo previsto | V.3 | Coenen2012Multiplicadores; BlanchardLeigh2013 |
| V.3 | Tipos de reglas fiscales | V.3 | Schaechter2012Reglas |
| V.3 | Necesidades brutas de financiación; 4 formas de financiar el déficit; pasivos contingentes y APP; escenario histórico y a políticas constantes | V.3 | FMI2021DSA; FMI2013CaseStudy |
| V.3 | Calidad del ajuste; política fiscal en una crisis según su origen | V.3 | FMI2013CaseStudy |
| VI | Naturaleza, origen y gravedad del desequilibrio; menú (demanda, oferta, tipo de cambio) | VI.1 | FMI2013CaseStudy |
| VI | Pacto de rentas; política energética | VI.2 | BdE2022InformeAnual2021; CE2022REPowerEU |
| Anexos | Canales de un choque externo; Phillips plana y el error de previsión de 2021; comprobaciones de coherencia; artículo IV de un emergente; escenario base y marco de sostenibilidad del FMI | B.1, D.7, C.1 | FMI2022WEOabr; FMI2021WEOoct; FMI2013CaseStudy; FMI2021DSA |

No ha entrado nada de lo marcado como dudoso o erróneo en los informes (EBE = deflactor − CLU, PIIN = pasivos −
activos, intereses contados 2 veces en la PIIN, umbrales antiguos del PDM, «zonas» del DSA, tono por la variación del
tipo, etc.).

### Prioridad baja: pendiente de que decida Víctor (no se ha metido)

- NAIRU deducida del paro a partir del cual se acelera la inflación (complemento del criterio de la brecha nula).
- Variabilidad de la inflación como coste y calidad de los datos de precios en emergentes.
- Precios hedónicos (ajuste por calidad), en una nota del IPC.
- Vivienda como activo refugio con oferta rígida.
- Estrategia de salida de la política monetaria no convencional.
- «Datos que dan el diagnóstico y datos que lo contrastan» (anexo de método).
- El salario como coste y como demanda a la vez («arma de doble filo»).
- Políticas de mantenimiento del empleo frente a reasignación; competencia tras las crisis; transición climática (V.5).
- Del resumen del WEO 2020-2021: empresas zombis y moratorias, marco común del G-20 y cláusulas de acción colectiva.
- Cuadrantes paro-empleo entre países (gráfico de dispersión): idea de prioridad media que **no** se ha hecho porque
  pide datos nuevos de Eurostat; si se quiere, se pide como gráfico de datos.
- Descomposición del ROA de la banca (idea del enunciado de práctica): no entra por ahora.

### El resumen, al día con la cuarta vuelta (26/10/2026)

- **Páginas**: 10 exactas a 10 pt (9 de resumen + 1 de anexos); revisadas una a una en PNG: columnas al 93-99 % en las
  9 primeras (la 9.ª, al 95 %), la de anexos al 91 %; nada cortado ni desbordado (0 *overfull*), tablas pegadas a la
  frase que las presenta, ningún título al pie de columna. `verificar-tema.py 1D01`: 0 errores.
- **Orden y numeración de la guía**: I.1-I.3, I.4, I.5-I.6; IV.1 a IV.4 (capacidad o necesidad, cómo se financia, PIIN y
  deuda externa, ¿es sostenible?); V.1 a V.5. Identidad de la balanza de pagos desarrollada, igual que en la guía.
- **Entra de la guía nueva**: contribución real frente a saldo nominal; ahorro forzoso y precautorio (pie del gráfico);
  efecto desánimo, acaparamiento de trabajo y efecto composición; choque de oferta o de demanda (regla de precios y
  cantidades); efectos directos, indirectos y de segunda ronda; π ≈ γ_M − γ_Y; pacto de rentas; PPA
  relativa y Balassa-Samuelson; efecto valor y volumen de la curva J; ancla cambiaria, defensa de un tipo fijo
  y respuesta a las entradas de capital; aranceles de un tercero e integración asimétrica; canales de un choque externo
  (con su infografía, en I.6); saldos sectoriales (tabla de las 3 historias); déficits y superávits razonables;
  financiación excepcional, *carry trade*, empuje y atracción; composición por tenedores, círculo flujo-stock, signo del
  efecto valoración, indicadores de deuda externa y enfoque de balances; saldo corriente sin intereses que estabiliza la
  deuda externa; frenazo súbito; **financiar o ajustar** con el árbol del déficit corriente (a lo ancho de la página);
  objetivo aparente, retardos (29 meses) y canal del crédito roto; CAMELS, cobertura de intereses y liquidez frente a
  solvencia; saldo estructural engañoso en los auges, prociclicidad, multiplicadores, tipos de reglas fiscales,
  necesidades brutas de financiación, 4 formas de financiar el déficit, pasivos contingentes, calidad del ajuste y
  fiscal en una crisis según su origen; naturaleza, origen y gravedad del desequilibrio y el menú de ajustes; fila de
  superávit persistente en la tabla de recomendaciones.
- **Sale** (para caber): los gráficos del Brent, del PIB por persona en edad de trabajar y de empleo, horas y actividad
  (su idea queda en el texto); la cita del FMI sobre España en la frase ejecutiva. «Ojo en el dictamen» pasa a la
  página de anexos (con un error típico más: tono monetario por el nivel, fiscal por la variación) y el anexo A suma
  π ≈ γ_M − γ_Y, PPA, servicio de la deuda externa, Greenspan-Guidotti, NBF y cobertura de intereses.
- **Subrayado** (`\uline`): 12, solo en las ideas que hay que decir sí o sí (antes no había ninguno).
- **Una sola copia de las infografías** (decisión de Víctor): el resumen usa las de `graficos/` (las mismas de la
  guía; `tcee-repaso.sty` ya las busca en `../graficos/`, sin cambiar `construir-repaso.py`). Se han borrado las 15
  `repaso/graficos/rep-*`: 14 tenían equivalente (`esquema-…`) y `rep-calificaciones` pasa a
  `graficos/escala-calificaciones.tex` (paleta `dic…`, con capas y marco fijo; la guía no la usa).

### Dudas para Víctor

1. **Extensión**: el cuerpo queda en 74 páginas (pedía ~70). ¿Vale así o devuelvo al anexo A las tablas de economías
   avanzadas/emergentes y de hechos estilizados (≈ 72) o los ejemplos de redacción del perfil cíclico (≈ 70)?
2. **Infografías duplicadas**: resuelto el 26/10/2026 (una sola copia en `graficos/`; ver «El resumen, al día con la cuarta vuelta»).
3. **`[!htb]` en lugar de `[H]`** en el cuerpo (CRITERIOS §2 pide `[H]`): evita los huecos de un tercio de página; la
   figura queda como mucho arriba de la página siguiente. ¿Lo dejamos así (y lo anoto en CRITERIOS) o vuelvo a `[H]`?
4. **Subrayado**: con `ulem` cargado solo en este documento. Si se va a usar en más temas, convendría una orden
   semántica en `tcee-comun.sty` (p. ej. `\clave{}`) con su equivalente en `pandoc-macros.tex` y en el módulo de LyX.
5. **Multiplicadores por instrumento**: solo en cualitativo (Coenen et al., 2012). Las cifras de los materiales
   (inversión ≈ 1, consumo ≈ 0,8, transferencias ≈ 0,2…, del modelo NiGEM) no tienen aún fuente primaria localizada;
   tampoco la prueba de tensión del FMI (+10 puntos de deuda por pasivos contingentes, depreciación del 30 %).
6. **Árbol del déficit corriente**: la figura de `Imagen.docx` no tiene fuente identificada; el gráfico es propio, «a
   partir del enfoque de programación financiera del FMI» (FMI2013CaseStudy, el manual del curso, que sí trata
   financiar frente a ajustar).
7. **Cláusula de defensa**: el texto antiguo decía «en 17 Estados» sin fuente; ahora dice que la Comisión invitó a
   pedirla con un margen de hasta el 1,5 % del PIB y que la mayoría la pidió (Comunicación C(2025) 2000). Si quieres el
   número exacto de Estados, hay que citar la decisión del Consejo.

## Aportaciones de la guía v24 (25/10/2026)

Del inventario `_trabajo/v24-comparacion.md` se ha metido en el **cuerpo** todo el apartado (b) pedido, cada cosa en su
bloque y con fuente propia (no se cita la guía de otro preparador); nada del apartado (c).

- **Método (introducción y I.4)**: «los gráficos no suelen ser gratuitos» y «ser perspicaz, no descriptivo», con un cuadro
  «Ejemplo de redacción: descriptivo frente a perspicaz» antes del del motor del crecimiento.
- **II.2**: fuentes de financiación (crédito bancario, valores, capital riesgo, banca pública) (encuesta SAFE del BCE).
- **III.1**: por qué es mala la deflación de demanda (aplazamiento de compras, deflación por deudas de Fisher, tipo real
  con tipos en el límite) y la «buena» de oferta (Bordo y Filardo, 2005). Antes solo estaba la recomendación con deflación.
- **III.2**: nuevo párrafo «Efectos de una devaluación para corregir el déficit exterior» (Marshall-Lerner, curva J,
  casos en que no mejora, efecto inflacionista con sus 4 determinantes, deuda en divisas, paro friccional, empleo según la
  intensidad factorial; Krugman, Obstfeld y Melitz; Campa y Goldberg; pecado original).
- **IV.1**: tasa de cobertura y comercio inter e intraindustrial (índice de Grubel y Lloyd).
- **IV.2**: factores de la inversión directa y de cartera, huida hacia la liquidez o la seguridad, falta de consenso sobre
  abrir la cuenta financiera (FMI, 2012); las partidas de la balanza son **flujos**; ajuste con tipo fijo (reservas y
  agregados monetarios, riesgo de crisis cambiaria) o flexible (tipo de cambio), sin la frase errónea de que «la balanza
  estaría siempre en equilibrio».
- **V.1**: desequilibrios a vigilar: liquidez, monetización y *liquidity crunch* (Taylor y Williams, 2009).
- **V.3**: aviso de deuda bruta frente a neta y tipo a corto frente a tipo medio de la deuda viva (FMI, Fiscal Monitor
  2018; Reinhart et al., 2003); gasto corriente frente a gasto de capital (SEC 2010).
- **VI**: recomendaciones para el déficit exterior según su causa (precio, no precio, entradas de capital con controles
  temporales y excepcionales; visión institucional del FMI).
- Bibliografía: 8 entradas nuevas (BCE2026SAFE, Fisher1933, BordoFilardo2005Deflacion, KrugmanObstfeldMelitz2018,
  FMI2012VisionInstitucional, GrubelLloyd1975, TaylorWilliams2009, FMI2018FiscalMonitor).

**Lo que se ha llevado a los anexos para compensar (≈ 2 páginas), con remisión desde el cuerpo**: los gráficos de la
inflación de la zona del euro, de los tipos y el balance del BCE, de la curva de Beveridge, de las 4 fases del ciclo y de
los cuadrantes del *policy mix* (a los anexos de series y de gráficos de lectura); la ley de Okun y la curva de Phillips
(al anexo de casos, con una línea en el cuerpo); la volatilidad y el comovimiento del consumo y la inversión, condensados
con remisión a la tabla de hechos estilizados; el ejemplo del FMI para España de la recomendación de gasto (está en el
anexo de España); y el texto largo de «rigidez del sistema financiero» de VI, que ya está en V.2.

Resultado: **cuerpo 50 páginas**, anexos 39, bibliografía 9 (98 en total). `verificar-tema.py 1D01`: 0 errores,
11 avisos (cifras sin cita en anexos y guion/vídeo pendientes). Para evitar falsos «títulos al pie», en el esquema de la
introducción los números de apartado van sin punto y la función de importaciones va en línea.

## Segunda vuelta 24/10/2026

Aplicados los comentarios de Víctor del 24/10 (`_trabajo/comentarios-victor-24oct.md`), CRITERIOS §7 y §11 actualizados e
inventario `_trabajo/recuperar.md` (R-01 a R-122). Fuente `1D01.tex` + `1D01.bib` (161 entradas) y `1D01.lyx` sincronizado
por `construir-tema.py`. Compila sin errores; `verificar-tema.py 1D01`: **0 errores, 11 avisos** (9 «cifra sin cita» en
anexos, que son fechas de exámenes o datos del recuadro de Beveridge ya citados en su párrafo, y guion y vídeo pendientes).

### Páginas

- **Cuerpo: 50 páginas** (introducción con esquema, I-VI y conclusión). **Anexos: 37** (A-J). **Bibliografía: 9.** Total 96.
- Anexos: A El ejercicio y el método · B Indicadores y umbrales · C Qué se ha preguntado · D Expresiones (D.1 Párrafos
  modelo por bloque) · E Análisis de casos frecuentes · F Lectura de series · G Cálculos tipo · H FMI (programación y
  programas) · I España · J Temas.

### Qué se ha hecho, punto por punto

- **Método al anexo A**: «El ejercicio y el método» sale del cuerpo entero (etiquetas `anexo:metodo`, `anexo:tiempo`,
  `anexo:leer`…), con la **matriz completa de 9 columnas** de la guía antigua (tabla 8, R-05), la tabla antigua de minutos
  por número de preguntas (tabla 5, R-03, con sus supuestos), las normas de la sala del examen de 2022 (R-01, con el pie
  corregido: era 2022, no 2021), el matiz «no suelen ser países de renta baja, sí emergentes» (R-02), «releer cada
  pregunta» y «si el dictamen es libre, anunciar la estructura», y «dónde practicar y leer ejemplos» (R-106).
- **Lo de exámenes, en notas al opositor**: todas las menciones a años de examen del texto corrido («se preguntó en…»,
  «(2021)», «(2016, 2019 y 2024)») pasan a 14 recuadros `notaopositor`, uno por bloque. Ninguna idea teórica queda atada a
  un año suelto; los efectos no keynesianos ya no dicen «(2022)».
- **Esquema (índice) al final de la introducción**, numerado desde I (Perfil cíclico = I … Recomendaciones = VI), con
  enlaces a cada apartado y el segundo nivel, inspirado en el índice de la pág. 2 del PDF antiguo (R-04).
- **Reparto del tiempo**: en la introducción, 4 reglas ligeras y orientativas (no se sabe cuántas preguntas habrá; ~10 %
  de lectura y ~5 % de repaso; más tiempo a las preguntas donde están los retos reales de la economía; ninguna en blanco).
  La regla, la tabla por convocatoria y la tabla antigua, en el anexo A.3.
- **Balanza de pagos desarrollada** (R-80): 2 fórmulas recuadradas (`\funcionclave`): la identidad completa con llaves
  (CC + CK = capacidad/necesidad; + EO = CF = ID + IC + D + OI + ΔR), numerada como `eq:identidad-bp`, y la cadena
  CC = (X − M) + RP + RS = (Y − A) + RP + RS = S − I = (S_P − I_P) + (T − G), con su lectura en palabras. Nota 33 antigua
  reescrita con la forma alternativa bien explicada.
- **IPC y deflactor** (R-68 a R-73): 2 cuadros grises paralelos, «El IPC, un índice de Laspeyres» y «El deflactor del PIB,
  un índice de Paasche», con qué compara cada uno, la fórmula con sumatorios (y en vectores), cesta fija o variable,
  encadenamiento (INE base 2025) y el sesgo. **Nota 30 corregida**: el IPC no recoge que los consumidores sustituyen los
  bienes *más caros por otros más baratos* (la antigua lo decía al revés). Las 2 diferencias entre índices, en lista.
  Índices especializados (IPP/IPRI, IPRIX/IPRIM, costes laborales), las 3 familias de subyacente y el triángulo de Gordon.
- **Política fiscal** (págs. 19-20 antiguas, R-91 a R-101, R-119): consenso y política discrecional; las 5 variables del
  saldo en lista con su definición; tono; ejemplo del Consejo Fiscal Europeo; **efectos no keynesianos** con texto completo,
  Giavazzi y Pagano (1990) y la evidencia posterior (Guajardo et al., 2014), sin años de examen; **la inflación y las
  cuentas públicas** punto por punto (ingresos, intereses, gasto indexado, compras, denominador) y el esquema del FMI
  «Repercusiones inmediatas de la inflación en las finanzas públicas» **redibujado como tabla** (tabla 1: 4 canales → 4
  efectos); otros análisis: nivel de ingresos y gastos con el esquema de la ficha 4 (más impuestos / ingresos no
  tributarios), estabilizadores automáticos ($b-b^{ca}=\varepsilon\cdot\mathrm{OG}$), deuda a corto, vida media, deuda
  regional y corresponsabilidad, calidad crediticia.
- **Tabla de calificaciones** (antigua tabla 11, hoy tabla 14, anexo B): S&P, Moody's y Fitch en las primeras columnas;
  DBRS en cursiva y discreta; Scope en la fuente; una fila por escalón de AAA a D, cada celda en una línea, con el bloque
  (inversión, especulativo, impago) y el nivel del Eurosistema.
- **Nuevo V.2 «Estabilidad financiera y política macroprudencial»** (R-50 a R-62, R-118, R-120), justo después de la
  monetaria: endeudamiento y ciclo financiero (umbrales del PDM, brecha crédito-PIB, bucle bancario-soberano); solvencia
  (APR explicados, CET1/Tier 1/total, *fully loaded* y *phased-in*, apalancamiento, regla antigua del 12 % con su
  advertencia); calidad de los activos (dudosos explicados); liquidez (LCR, NSFR, LTD alta y baja); rentabilidad (por qué
  importa, ROE/ROA, eficiencia, coste del capital); riesgos (vivienda, crédito, divisas, tipos bajos, bolsa, externos);
  regulación microprudencial (Basilea III y sus 3 pilares, MREL/TLAC); supervisión y unión bancaria (MUS, MUR, garantía
  de depósitos pendiente; euro de 21); política macroprudencial (colchones, LTV/LTI/DSTI, fase alcista y bajista con
  «operar por debajo de los colchones»). Nota al opositor: pregunta propia (2020, 2022) o coletilla de la monetaria
  (2023, Meridia). En II.2 «Mercado de capitales» queda el capital físico (R-49) y el crédito y la financiación como
  factor, con remisión a V.2.
- **Anexo C**: quitada la transcripción de los exámenes; queda hasta la tabla de bloques por año (hoy tabla 16).
- **Cálculos (anexo G)**: tabla visual de las fórmulas imprescindibles por bloque (la del A.5 antiguo, con la fórmula 10
  corregida: el CLU real es la participación salarial; y la 14: $\mathrm{PIIN}_t=\mathrm{PIIN}_{t-1}+\mathrm{CF}_t+
  \mathrm{OV}_t$), y cuadros por bloque con la fórmula recuadrada, sus términos y un ejemplo: la derivación de las
  contribuciones paso a paso (R-13), brecha y potencial, tasas trimestrales, deflactor, tipos reales, salario real,
  índices, PAT-CLU-margen (con tabla de ejemplo), ahorro e inversión, PIIN, exportaciones, saldos y esfuerzo, saldo
  estabilizador. Fuera «desde 2022 no se piden cálculos» (y el «sin cálculos» de la tabla de formatos).
- **Recuperado de la guía antigua** (además de lo anterior): A.8 en I.1 «Conceptos generales: el PIB» (3 enfoques con
  fórmulas, RNB y RNDB, 5 problemas de medida, R-115); funciones del consumo, la renta disponible, la inversión, las
  exportaciones, las importaciones y la sostenibilidad con sus signos (R-17, R-24, R-30, R-87); SEC 2010 de la inversión
  (R-22, en nota); nota 12 de la curva de tipos completa (R-19); nota 17 con la hipótesis de inflación de los *swaps*
  (R-26); nota 18 completa (R-27); definiciones del mercado de trabajo, fuga de cerebros, pleno empleo con la OIT, cadena
  CLU-beneficios-bolsa-precios, usos de los CLU nominales, Calmfors y Driffill (R-40 a R-46); nota 27 de Beveridge como
  lectura de la curva española 1994-2022 (R-48); RRI, preguntas guía del saldo, cuenta de capital, reservas, monedas y
  valoración de la PIIN (R-31, R-82 a R-88); tipos de interés (R-89); políticas de oferta por tipo de paro con su
  diagnóstico (R-103, en V.5); recomendaciones que faltaban (R-36, R-105, R-121, R-122); anexos A.1 y A.3 completos
  (tipos de datos, tendencias, frecuencia, cointegración, los rasgos del comovimiento; proporciones, porcentajes, índices,
  tasas; R-107, R-110), A.4 (R-111) y el contexto 2020-2022 de A.6 (R-113, con la fecha de recuperación corregida).
- **Ejemplos de redacción** (22 entradas de la antigua): `tcee.sty` no tiene entorno propio, así que van en cajas grises
  `anotaciones` con el rótulo en negrita «Ejemplo de redacción: …», con años y cifras genéricos (20xx). Corregidos al
  recuperarlos: tipo real «contractivo» con el nominal en cero (ahora: el tipo real cercano a cero no recoge todo el
  estímulo; R-90), «Numitor» → «esta economía» (R-90, R-99), coste del capital frente a «tipos de mercado» (R-52), punto
  iv) vacío (R-52, ahora liquidez), erratas. **15 cuadros en el cuerpo y 11 en el anexo D.1** (ver abajo).
- **Gráfico de comovimientos**: pie y ancho nuevos (`\textwidth`, panel d del Conference Board) según
  `pies-graficos-24oct.md`. Ningún pie nombra colores, así que no hubo que ajustarlos a la paleta.
- `seo.json` al día (estabilidad financiera, balanza de pagos, IPC y deflactor).

### Lo que se ha llevado a los anexos para no pasar de 50 páginas (con remisión en el cuerpo)

- Tablas de consulta: indicadores del sistema financiero, Basilea III, ratios de la banca (con una columna nueva de 2021,
  R-61) y calificaciones → anexo B.
- Gráficos de lectura: consumo-renta-ahorro, PIB y comercio mundial, empleo y horas, PIB por persona en edad de trabajar,
  impulso fiscal y el gráfico de la inflación en las cuentas públicas (la tabla del FMI sí está en el cuerpo) → anexo F.
- Casos concretos → anexo E: un sector dominante (petróleo), demografía/visados/salario mínimo, aranceles, la curva de
  Beveridge española, los fondos europeos en la balanza de pagos, el brote de inflación (resistencia, cambio de tendencia,
  «última milla») y el detalle de las reglas fiscales (en el cuerpo queda un resumen de 2 líneas).
- Ejemplos de redacción largos → anexo D.1: frase del FMI de 2022, sector dominante y tejido productivo, el párrafo del
  BCE sobre el mercado de trabajo, demanda de trabajo y paro persistente, exportaciones e importaciones, relación con el
  ciclo de la monetaria, endeudamiento, banca bien capitalizada, macroprudencial con tipos bajos, tono fiscal con déficit
  alto y paquetes de estímulo.
- El programa del FMI (antiguo VI.3) → anexo H.
- Para evitar huecos, la tabla de recomendaciones y el gráfico de tipos del BCE van con `[tbp]` (pueden moverse a la
  página siguiente); el resto, `[H]`.

### Dudas nuevas para Víctor

1. **Ejemplos junto al indicador frente a las 50 páginas**: para no pasar del límite, 11 ejemplos largos están en el
   anexo D.1 con remisión. ¿Prefiere subir el límite (todos en el cuerpo serían unas 53 páginas) o así vale?
2. **Tablas de la banca y de calificaciones en el anexo B** (el texto de regulación sí está en el cuerpo, V.2). ¿Las
   quiere en el cuerpo aunque haya que mover otra cosa?
3. **Anexo E de casos** (petróleo, aranceles, demografía, reglas fiscales en detalle, brote de inflación): ¿le parece bien
   sacarlos del cuerpo?
4. **Método del Banco de España para el tipo real a largo** (nota 17 antigua: *swaps* de inflación a 15, 10 y 5 años
   según el préstamo): no he podido comprobar que siga usando esos plazos; en la nota queda la idea sin los plazos.
5. **Regla del 33 % de esfuerzo en vivienda**: se mantiene como orientativa, sin fuente (junto a la de sobrecarga de
   Eurostat, 40 %).
6. **Curso del FMI en español (edX)**: el enlace de la guía antigua da error 404; se mantiene la referencia con la nota
   «enlace de la guía anterior». La entrada de Bankinter no tiene fecha (la web bloquea la consulta automática).
7. **Imagen 2 antigua** (descomposición del consumo por fuentes de renta, BCE): no se ha rehecho; ¿pedimos un gráfico
   nuevo con las cuentas sectoriales de Eurostat?
8. **Vídeos de YouTube del anexo A.6 antiguo**: no se han recuperado (no se sabe qué son).
9. La numeración de tablas ha cambiado: la antigua «tabla 11» es la 14 y la «tabla 13» es la 16.


## 1. Resumen

- Guía nueva en LaTeX (`1D01.tex`, sin `\minutos`, CRITERIOS §11): **cuerpo de 44 páginas** (introducción, método,
  perfil cíclico, mercados de factores, competitividad, sector exterior, políticas, recomendaciones y conclusión),
  **20 de anexos** (A-H) y 8 de bibliografía (149 entradas).
- Aplicadas casi todas las propuestas (C, K, V) y las decisiones de Víctor D-01 a D-05: reparto del tiempo como regla
  con tabla de convocatorias, umbrales oficiales y orientativos separados, anexo de España reescrito, $Y^p$.
- Corregidos unos 60 errores del Word (PIIN al revés, déficits gemelos, tono monetario y fiscal, margen, CLU, IPC
  frente a deflactor, hechos estilizados, tasa de actividad…) y resueltas las 22 marcas amarillas y las notas.
- Datos al último dato oficial (BOE de 2025, Eurostat, BCE, Banco de España, ABE, FMI octubre de 2026, PDM de 2025);
  15 gráficos pedidos (8 en el cuerpo, 7 en los anexos) con CSV y «qué hay que ver».
- Compila sin errores ni «??» (PDF de 72 páginas con los gráficos reales: cuerpo de 44); verificar-tema solo pide los
  productos de construir-tema.py.

### Detalle por partes

- Fuente nueva `1D01.tex` (LaTeX de `tcee.sty`, sin `\minutos`, CRITERIOS §11) con introducción breve,
  capítulo I de método (8 apartados) y capítulo II de perfil cíclico (5 apartados), en la estructura K1
  de `propuestas-coherencia.md` ajustada a `decisiones-victor.md`.
- Reparto del tiempo convertido en **regla** según duración y número de preguntas, con tabla de las
  convocatorias de 2016 a 2026 y 10-12′ de lectura (D-02); umbrales no regulatorios marcados como
  orientativos (D-03); PIB potencial con $Y^p$ (D-05).
- Corregidos los errores de concepto de estos capítulos (brecha de producción «tendencial» del FMI,
  inversión y brecha, existencias, consumo público, población joven, equivalencia ricardiana, PMI,
  recesión, umbrales de crecimiento y de país desarrollado) y actualizados sus datos (convocatoria de
  2025, consumo, FBCF, crecimiento y renta per cápita 2025, artículo IV de 2026).
- `1D01.bib` (149 entradas al final; 145 en la parte 1: `bib-datos.bib`, C90 sin duplicados, bibliografía del original y 3 clásicos),
  4 gráficos pedidos y PDF de prueba de la parte 1: 22 páginas (aún sin los gráficos reales).

**Parte 2.** Capítulos III (mercado de trabajo; mercado de capitales: endeudamiento y ciclo financiero,
banca, vivienda, bolsa, macroprudencial) y IV (precios e inflación, tipo de cambio, no precio y aranceles),
en ≈ 13 páginas (el PDF de prueba pasa de 22 a 33 páginas: la parte 1 baja a ≈ 20 al llevar a los anexos
las tablas de temas por bloque y de economía avanzada/emergente). Lo de ampliación (tablas de Basilea y de
ratios bancarios, párrafos modelo, gráficos de horas, empleo y Brent) queda en comentarios «% A ANEXO»
para la parte 4. 2 gráficos nuevos en el cuerpo (Beveridge, IAPC) y 3 pedidos para los anexos.

**Parte 3.** Capítulos V (sector exterior), VI (políticas monetaria, fiscal, *policy mix* y de oferta) y VII
(recomendaciones por desequilibrio y programa del FMI) y una conclusión breve sobre cómo cerrar el
dictamen. El cuerpo termina en la página 44 del PDF de prueba (V-VII y conclusión, ≈ 12 páginas). En la
curva de Phillips de III.1 se usa ahora $U_t$/$U^n$, como fija el canon (§ 6), con una nota que lo
distingue de $u=U/A$ de la EPA (§ 13).

## 2. Errores corregidos

| Dónde (original) | Decía | Dice ahora |
|---|---|---|
| l. 390-393 y nota 7 (brecha) | OCDE: frente al PIB potencial; FMI: frente al PIB «tendencial» | Un solo concepto (frente al potencial), 2 métodos de estimación: función de producción (Comisión, OCDE, FMI; Havik et al., 2014) y filtro estadístico (Hodrick-Prescott) (C9, K13) |
| l. 407 | «γ Output gap = γ PIB obs. − γ PIB pot.» | $\Delta\mathrm{OG}_t\approx\gamma_{Y,t}-\gamma_{Y^p,t}$, en puntos (K13) |
| Nota 6 | `[ver tema 4.B.5]` (numeración antigua) | `\vertema{4.B.4}` y además 3.A.42, 3.A.45 y 3.A.28 (P61) |
| l. 368-376 y l. 1036 | Tramos 0/1/1,5/3,5 % y «PD: 2-4 %» (contradictorios) | Un solo juego, orientativo: <0, 0-1, 1-2, >2,5-3 %, con el dato del FMI (avanzadas 2,0 %, emergentes 4,5 % en 2025) (C22, V21) |
| l. 1040-1044 | Renta per cápita EE. UU. 50.000 $, Alemania 36.000, España 30.000; primario ~10 % en PD | 90.000, 61.000 y 39.000 $ (2025, FMI); primario 1,8 % del VAB de la UE; tabla avanzada/emergente (C22, C59, V21) |
| l. 547, 555 | Consumo 60-70 % del PIB | 53 % en la UE (2025), en torno a 2 tercios en EE. UU. (V18) |
| l. 565 | Consumo «ligeramente atrasado» | Contemporáneo (Stock y Watson, 1999; 3.A.42) (K12) |
| l. 699 | Existencias con «efecto anticíclico» | Procíclicas y muy volátiles; amortiguan a muy corto plazo pero amplifican el ciclo (C10, Blinder y Maccini, 1991) |
| l. 717 | Inversión «adelantada» | Equipo contemporáneo o algo retrasado; residencial adelantada (C10, K12) |
| l. 755 | *Output gap* entre los determinantes negativos de la inversión | Positivo (acelerador), junto a la utilización de la capacidad (C11, K15) |
| l. 787 | Consumo público «generalmente procíclico» | Acíclico o algo contracíclico en avanzadas; procíclico en muchos emergentes (C10; Kaminsky et al., 2004) |
| l. 619 | «Población joven (−): los jóvenes ahorran más de cara a la vejez» | Efecto ambiguo: ahorra la población en edad de trabajar; más dependientes, más consumo (C12; Modigliani y Brumberg, 1954; Leff, 1969) |
| l. 639 | Política fiscal futura expansiva reduce el consumo «–equivalencia ricardiana–» | Equivalencia ricardiana bien definida (Barro, 1974), remisión a 3.A.39 (C12) |
| l. 779-799 | «C + I + G» con la inversión pública en G | En la CN, G es el consumo público; la inversión pública está en I (K9) |
| l. 942 | «γY = s_L·γL + s_K·γK + γA» | $\gamma_Y=\gamma_A+\alpha\gamma_K+(1-\alpha)\gamma_L$ (canon, K16) |
| l. 836-858 | $e=EP^*/P$ | $q=EP^*/P$, subida = depreciación real (canon D013/D015, K10) |
| Nota 13 | PMI > 50 «denota optimismo» | Índice de difusión: >50, la actividad crece respecto al mes anterior (C8) |
| Nota 5 | Recesión = 2 trimestres, sin matiz | Regla práctica (Shiskin, 1974); NBER y CEPR usan un criterio más amplio; depresión según *The Economist* (C26, P104) |
| l. 51 | «No usar abreviaturas (salvo PIB e IPC)» | Regla de 2026: solo las del enunciado y las convencionales (P73, V6) |
| l. 25 | «Generalmente, no se han venido realizando preguntas» | Quitado (sin fuente; la convocatoria prevé hasta 15 minutos): consejo para la lectura (C45, V4) |
| l. 348 | «huego» y otras erratas del bloque | Corregidas al redactar de nuevo (P110) |

### Parte 2

| Dónde (original) | Decía | Dice ahora |
|---|---|---|
| l. 1124 | «junto con la tierra y el trabajo» | «junto con el capital» (C1, P96) |
| l. 1128-1138 | 16-64 años; «tasa de participación» = activos/población total; OCDE 70 % frente a España 60 % | EPA: $A/P_{16}$, $L/P_{16}$, $u=U/A$; mismas edades para comparar: España 74,9 % (15-64, 2025), OCDE 73,9 % (2024), España 58 % (16+) (K17, C21, V16-V17) |
| l. 1186, 1271 | «γ CLU = γ w_nominales − γ PAT_real» (w minúscula) | $\gamma_{\mathrm{CLU}}=\gamma_W-\gamma_{\mathrm{PAT}}$, $W$ nominal (canon §6, K18) |
| l. 1199 | «CLU = P·s_L» | $\mathrm{CLU}=P\cdot WL/(PY)$; CLU real = participación salarial (K16, K18) |
| l. 1283-1287 | Margen ≈ PQ − WL y tasas de una diferencia | $P=(1+\mu)\mathrm{CLU}$, $\gamma_{1+\mu}\approx\gamma_P-\gamma_{\mathrm{CLU}}$; EBE ≠ margen (C7, K18) |
| l. 1265 | Demanda de trabajo función de los CLU nominales | De los CLU reales (C31) |
| l. 1305 | NAIRU: «punto en el cual el empleo para de crecer» | Paro compatible con inflación estable, no techo al empleo; NAWRU de la Comisión (C25); quitado el ejemplo de Suecia (sin fuente) |
| Nota 24 | «Paradoja de Kaldor» = ausencia de relación CLU-PIB | Kaldor (1978): CLU al alza y cuota al alza; Felipe y Kumar (2011) para la zona del euro (C28) |
| l. 1376, 1484 | ROE frente a «tipos de interés de mercado» | Frente al coste del capital (8-12 %, ABE) (C5, C36) |
| l. 1378 | «RWA» | APR (canon §11, K23) |
| l. 1430 | Euro de 20 países | Párrafo de Unicaja quitado (C81); no hace falta la cifra |
| l. 1460-1474 | Apalancamiento en «Liquidez»; LCR de «flujos esperados»; LTD alto = falta de liquidez para «requisitos de capital»; dato de 3,921 billones sin fecha | Apalancamiento en solvencia; LCR con escenario de tensión; NSFR añadido; LTD como riesgo de financiación; dato quitado (C4, P99) |
| l. 1581 | Ponderaciones del IPC «revisadas en cada período» | Actualización anual, base 2025 desde enero de 2026 (C30, K21, coherente con 3.A.9) |
| l. 1577, 1603 | Laspeyres y Paasche con $q_i$ | $\vect{p}\cdot\vect{x}$ (canon §0, K21) |
| l. 1594 | «PIB a precios fijos» | PIB en volumen encadenado; deflactor = Paasche encadenado (K21) |
| l. 1628 | IPC < deflactor = «aumento del precio de los activos financieros» | Mejora de la RRI, bienes de inversión o servicios públicos; ninguno incluye activos financieros (C13, K21) |
| l. 886 | Deflactor de M < IPC = «falta de competitividad exterior» | Las importaciones se abaratan frente a lo nacional (C13) |
| l. 1648 | «efectos de segunda ronda de la política monetaria» | De los choques de oferta (C14) |
| Nota 32 | Subyacente «sin comida y energía» | INE: sin alimentos no elaborados ni energía; Eurostat/BCE: IAPC sin energía ni alimentos (K22) |
| l. 1684-1690 | *Bid-ask spread* como liquidez; salarios como *demand-pull* | Quitado; salarios en *cost-push* (C16) |
| l. 1720, 1738 | «Si la inflación se acelera, no hay duda: PM contractiva»; «BCE sólo utiliza el pilar económico» | Según el origen; estrategia del BCE de 2021 confirmada en 2025 (C15, V25) |

### Parte 3

| Dónde (original) | Decía | Dice ahora |
|---|---|---|
| l. 1768, 1792, 1860, 1890 | La identidad de la BP 4 veces, con «Y − A + rentas» (A choca con activos y PTF del canon) | Una vez, `eq:identidad-bp`, con la notación del canon: CC + CK + EO = CF (K11, C85) |
| l. 1832 | «¿Deuda interna anémica?» | Demanda interna débil (C2, P97) |
| l. 1852-1856 | «↑(T − G) ⇒ ↑i…» y «enfoque fiscal de la BP» | ↓(T − G), hipótesis de los déficits gemelos (C6, K25) |
| l. 1926 | PIIN = pasivos − activos | Activos − pasivos; negativa si deudor neto (C3, K26, P98) |
| Nota 34 | «Cobertura de la base monetaria»: 20 % de M2 | Dinero en sentido amplio (M2) (C29) |
| Nota 35 | ΔPIIN ≈ PIIN·(i − g) + CC + CK (intereses contados 2 veces; g del canon es progreso técnico) | `eq:dinamica-piin` con γ^N y otras variaciones (C20, K27, P107) |
| l. 1942-1946 | Inflación siempre (+); depreciación siempre (−) | Inflación solo licúa la deuda en moneda nacional; pecado original (C19) |
| l. 1950 | Deuda externa preocupante > 100 %, muy preocupante > 200 % | Regla práctica orientativa que no sirve para el euro; PIIN −35 % (PDM) y composición (C19, D-03) |
| l. 1974 | Tipos «lo normal en países de desarrollo» | Desarrollados (K28) |
| l. 1984 | Interbancario «ligeramente superior» | Con exceso de liquidez, el tipo a un día cotiza por debajo de la facilidad de depósito (C17) |
| l. 1996-2000 | Expansiva si el tipo baja mucho; acomodaticia «algo intermedio» | Nivel del tipo real frente al natural; acomodaticia = expansiva; regla de Taylor (K28, C17, P101) |
| l. 2018-2020 | «Análisis opcionales» fiscales dentro de la política monetaria | Llevados a VI.2 (P87) |
| l. 2047 | Política fiscal neutral = saldo estructural en equilibrio | Neutral = Δb^pe ≈ 0, sea cual sea el nivel (C18, K29) |
| l. 2085 | Sostenibilidad con «γ PIB real» y el coste de la deuda | Dinámica del canon (`eq:dinamica-deuda`): i − γ^N o r − γ_Y (C18, C62) |
| Nota 38 | ERTE de 25.000 M€ como *one-off* | Sin el ejemplo (no comprobado, V28, C27): definición general de medida puntual y aviso de que las medidas COVID se trataron como temporales |
| l. 2155 | Policy mix coherente = «ambas contractivas o expansivas» | Coherente si cada política ayuda a la otra (K30, C64) |
| l. 2316 | «Rigidez del sistema financiero» (texto repetido de la matriz) | Fila «Fragilidad financiera» con medidas (C75) |

### Parte 4 (anexos)

| Dónde (original) | Decía | Dice ahora |
|---|---|---|
| Anexo 1 | «tendencia linear», «sin empiezan»; conformidad repetida 3 veces | Resumido en `anexo:series` (conceptos), con persistencia (K12) |
| Anexo 2 | Gasto público «anticíclico, retardado»; comercio «anticíclico»; inversión «adelantada»; 5 filas vacías | `tab:hechos-ciclo` completa y alineada con el 3.A.42: consumo público acíclico, importaciones procíclicas, demanda externa neta contracíclica, inversión en equipo contemporánea y residencial adelantada (K12, C10, P21, P22, P109) |
| Anexo 5 | «γ Output gap = …», «γ PIIN = γ saldo CF + …», «Spread… = fórmula» | `anexo:calculos` con la notación del canon y ejemplos resueltos (C78, P107, P108) |
| Anexo 4 | Equilibrio interno y externo vacíos | Completados; las 4 cuentas y sus vínculos (`anexo:fmi`) |
| Anexo 6 | España 2020-2022, en parte copiado del Banco de España | Reescrito como caso de diagnóstico con datos de 2024-2026 (D-04, `anexo:espana`) |

## 3. Marcas resueltas

| Marca | Qué hacía | Qué se ha hecho |
|---|---|---|
| Notas al opositor 1-7 (l. 1-27, BOE de 30/12/2024) | Cita de la convocatoria | Actualizada a la Resolución de 22/12/2025 (BOE de 29/12/2025, texto idéntico) y llevada a I.1 con la calificación (P23, V1-V3) |
| `image1.png` «Examen oficial 2021» | Instrucciones del examen | Era el de 9/7/2022; sustituida por la tabla de formato 2011-2026 (`tab:formato`) (P35, V5) |
| Nota 8 «la más larga y siempre aparece» | | Matizada: 13 de 14 dictámenes, no en 2025; `notaopositor` de hacerla primero sin pasarse (P24, C46) |
| Nota 9 «hay preparadores que recomiendan…» | | Decidido: primero (Claves); sin nombres de preparadores (P24) |
| Caja C1 «¿?» (perfil cíclico) | Hueco | Recuadro `ideaclave` «Qué hay que contestar» (P31, P32, C48) |
| Cajas C3-C4 «¿Cuál es el motor…?» | Preguntas guía | Integradas en los recuadros «Qué hay que contestar» (P32) |
| Nota 10 «¡A veces pueden parecer contradictorios!» y nota 4 | | Integradas en el texto de II.2 con un ejemplo (P25, C47) |
| C2 «el output-gap se cierra/se abre» | Terminología | En II.2 y remitida al anexo de expresiones (parte 3) (P34) |
| Nota 11 «Nota 27/09/2021: El manual dice…» | Nota privada | Quitada (P26, P67, C82) |
| «Poco que contar, gastos de personal…» (l. 785) | Apunte | Sustituido por el texto de C10 (C82) |
| Nota 12 «Comentar brevemente…» (demanda externa) | | `notaopositor` (P27, C47) |
| «Si no tuviéramos nada, nos lo inventamos usando condicionales» (l. 777) | | «se pueden mencionar como posible factor, con condicionales» (C82) |
| Nota 13 «problemas estructurales… difíciles de localizar» | | `notaopositor` en II.5, ampliada (P28) |
| Matriz de fortalezas y debilidades (l. 147-288) | 9 columnas, la mitad vacías | Plantilla de 4 columnas con ejemplos en I.7 (`tab:matriz`); la tabla desequilibrio → recomendación irá en VII.2 (P57, C49) |
| `[Desarrollo coyuntura]` del perfil cíclico | Frases modelo con «20xx», «x,x %» | Las útiles quedan como ejemplos «Cómo se escribe» sin datos inventados; el resto, al anexo de expresiones (parte 3) |
| Frase de turismo «10,1 % de media en la UE» (l. 930) | Cifra sin fuente | Quitada (V39) |

### Parte 2

| Marca | Qué se ha hecho |
|---|---|
| P1-P3 (huecos del párrafo modelo del sistema financiero: moratorias y dividendos; política monetaria; ahorro precautorio y forzoso) | Completados en el párrafo modelo de C34, que va al anexo de expresiones (comentario «% A ANEXO»); en III.2 queda el análisis |
| P4 (Tier 1 > 12 %) | Mínimos regulatorios (7/8,5/10,5 %), requisitos totales del MUS (11 % CET1, 16 % total) y, aparte y como orientativos, los tramos de la ABE (CET1 > 14 % holgado) (D-03) |
| P5 (ROE > 10 %) | Se mantiene como referencia orientativa de la ABE (> 10 % favorable) junto al coste del capital (8-12 %) |
| P6 (efecto precio y volumen de los tipos) | Integrado en «Cómo se lee» del sector bancario |
| P7 (Precio de la vivienda, título vacío) | Escrito (C38): fundamentos frente a burbuja, umbral del PDM (+9 % nominal), sobrecarga de Eurostat (40 %, orientativo) en lugar del «33 %» sin fuente de l. 1014 |
| P8 (Índice bursátil, título vacío) | Escrito (C39) |
| P9-P13 (macroprudencial, duplicado) | Reescrito en general por fases del ciclo (C40); una copia del párrafo modelo, al anexo de expresiones |
| Notas 14 («incidir al cantar») | `notaopositor` con «leer» (P29) |
| Cajas C5 («¿Es flexible…?»), C7 («¿Está controlada?…»), C6 y C18 («¿?») | Recuadros «Qué hay que contestar» (P31, P32); «Mercado de capital físico» quitado (C72, P80) |
| Cajas C8-C17 (IPC, Laspeyres, Paasche) | Una caja `anotaciones` con las 2 fórmulas y remisión a 3.A.9 (P33) |
| `image10` (Rankia) e `image11` (Unicaja, 2T2021) | Tablas con fuente primaria y datos de 2T2026, en el comentario del anexo (P44, P45, V12-V15) |
| Texto copiado del blog de Unicaja (l. 1428-1498) y del Informe Anual del BCE 2022 (l. 1337-1339) | Redactado de nuevo (C81, C83); el párrafo del BCE se quita |
| `image7` (captura del FMI en inglés), `image8`-`image9` (Boscá et al.) | Sustituidas por el gráfico de Beveridge con Eurostat (P41-P43) |
| `image12`, `image13` (duplicada), `image14` (datosmacro, «Percio») | IAPC con Eurostat en el cuerpo; image13 quitada; Brent con la EIA al anexo (P46-P48) |
| Nota 27 (curva de Beveridge de España, Boscá et al., 2023) | Sustituida por el pie del gráfico con datos de Eurostat hasta 2026 |

### Parte 3

| Marca | Qué se ha hecho |
|---|---|
| Caja C19 «desequilibrios externos suelen ser síntoma de internos» | Al principio de V |
| P14 «Vida media de la deuda [ver Sahuquillo 2023]» | Explicada en VI.2 con `\parencite{Sahuquillo2023}`; sin el dato del Tesoro (no verificado) |
| P15-P17 (viñetas vacías de políticas de oferta, activas y pasivas) | Desarrolladas en VII.2 por tipo de paro (C42) |
| P18 (párrafo posiblemente copiado del BCE, fuente no localizada) | Redactado de nuevo con el Ageing Report y el Art. IV de España de 2026 (C43, V30) |
| Notas al opositor 15 (recomendaciones al final) y cajas C20-C21 | `notaopositor` y «Cómo se plantea la pregunta» (C46, P30) |
| Enlaces de Wikipedia y elEconomista (l. 1968-1970) | Quitados (P68) |
| «Numitor» y párrafos modelo con cifras de un examen (l. 2022-2030, 2141-2151) | Sin el nombre ni las cifras; las ideas, en VI.1 y VI.2; los párrafos, al anexo de expresiones si se quieren (V40) |
| `image15`-`image16` | Gráfico `tipos-balance-bce` con datos del BCE hasta octubre de 2026 |
| `image17`, `image18`, `image19` | Al anexo (comentarios «% A ANEXO»): impulso fiscal (FMI), esquema TikZ de la inflación y las cuentas públicas, escala de calificaciones del Eurosistema (no la del blog de Bankinter) |
| `image20` (FMI, en inglés) | Esquema TikZ `policy-mix` |
| Recuadro del FMI | Ampliado con tipos de programa y condicionalidad (C69, P92) |
| «Conclusión» del Word | Conclusión breve de la guía con el ejemplo de cierre del original |

### Parte 4

| Marca | Qué se ha hecho |
|---|---|
| P19 («Buscar imagen buena del ciclo», salió publicada en 2024) | Gráfico TikZ `ciclo-tendencia` pedido |
| P20 («Buscar imagen buena de comovimientos») e `image22` (tuit con marca de redistribución prohibida) | Gráfico TikZ `comovimientos` pedido; citado el Conference Board |
| P21, P22 (gasto público anticíclico, retardado) | Resueltas en `tab:hechos-ciclo` |
| C2 y C19 (terminología; desequilibrios externos como síntoma) | En el anexo de expresiones (y C19 al principio de V) |
| Párrafos modelo `[Desarrollo coyuntura]` (≈ 60) | Plantillas sin datos inventados en `anexo:expresiones`, con 2 ejemplos de respuesta (sistema bancario en una crisis; estabilidad financiera con tipos bajos, una sola copia, erratas corregidas) |
| Recuadro de Claves sobre NGEU en la BP | Caja en `anexo:expresiones` con `\parencite{BdE2021NGEU}` |
| Anexo 3 (estadísticas derivadas) | Lo útil (índices, cambio de base) en `anexo:calculos`; el resto se quita (C79) |
| Lista «Temas relevantes» | `tab:donde-se-estudia` en `anexo:temas` (K6, C80) |

## 4. Datos actualizados

Todos consultados el 23/10/2026 por el verificador de datos (`propuestas-datos.md`), con su segunda
comprobación allí.

| Dato | Anterior | Nuevo | Fuente | URL | 2.ª comprobación |
|---|---|---|---|---|---|
| Convocatoria vigente | BOE 30/12/2024 | BOE 29/12/2025 (BOE-A-2025-26902), mismo texto; mínimo 4 en el dictamen, 12/30 en el ejercicio, nota del test ≥ 8 fijada por el tribunal | BOE | https://www.boe.es/diario_boe/txt.php?id=BOE-A-2025-26902 | BOE-A-2024-27439 |
| Formato del examen 2011-2026 | — | Tabla `tab:formato` | Enunciados oficiales (ATCEE) | https://atcee.es/la-oposicion-tcee/examenes-anteriores/ | `examenes.md` |
| Consumo privado / PIB | 60-70 % | UE 53 % (2025); EE. UU. ≈ 68 % (2024) | Eurostat nama_10_gdp; Banco Mundial | ver `bib-datos.bib` | WDI |
| FBCF / PIB | ≈ 20 % | 21,5 % UE (2025) | Eurostat nama_10_gdp | ídem | pendiente (V19) |
| Crecimiento de avanzadas / emergentes | PD 2-4 %, PED > 5 % | 2,0 % / 4,5 % (2025); inflación avanzadas 2,5 % | FMI, WEO oct. 2026 | https://www.imf.org/en/publications/weo/issues/2026/10/13/world-economic-outlook-october-2026 | publicación WEO |
| PIB per cápita | 50.000 / 36.000 / 30.000 $ | 90.267 / 61.255 / 38.595 $ (2025) | FMI WEO | ídem | — |
| Sector primario | ~10 % en PD | 1,8 % del VAB UE (2025); agricultura > 25 % del PIB en renta baja | Eurostat nama_10_a10; Banco Mundial WDI | ver bib | WDI |
| Frase ejecutiva de ejemplo | Art. IV España 2022 (feb. 2023) | Art. IV España 2026 (nota de 22/5/2026) | FMI | https://www.imf.org/en/news/articles/2026/05/22/pr26163-spain-imf-executive-board-concludes-2026-article-iv-consultation | Country Report 26/102 |
| Gráfico de contribuciones (image2) | BCE 2012-2022 | Eurostat EA21 2012-2025 | `datos/image2-…csv` | | |
| Consumo, renta y ahorro (image3) | Modelo del BCE | Eurostat EA21 2012-2025 | `datos/image3-…csv` | | |
| PIB y comercio mundiales (image4) | BCE | FMI WEO oct. 2026, 2005-2027 | `datos/image4-…csv` | | |

### Parte 2

| Dato | Anterior | Nuevo | Fuente |
|---|---|---|---|
| Tasa de actividad | OCDE 70 %, España 60 % | España 74,9 % (15-64, 2025), OCDE 73,9 % (2024), España 58 % (16+) | OCDE; Eurostat lfsa_argan; INE |
| NAWRU | «muy superior al 5 %» (Claves) | Zona del euro ≈ 6,6 %, España ≈ 12,1 % (2025) | Comisión, AMECO (sin 2.ª fuente: V37) |
| Umbrales del PDM | Cuadro anterior a 2024 | Cuadro de 2025: paro 10 %, actividad −0,2 pp, CLU por hora +9/+12 %, deuda hogares 55 %, SNF 85 %, crédito 14/13 %, vivienda nominal +9 %, TCER ±3/±10 %, exportaciones −3 % | CE, AMR 2026; Eurostat (MIP) |
| Requisitos de capital | Tabla de Rankia | 7/8,5/10,5 % + colchones; requisitos totales MUS 11,2 % CET1 y 15,6 % total | BCBS; CRR/CRD; BCE, SREP 2025 |
| Ratios de la banca española | 2T2021 | 2T2026: ROE 16,05 %, CET1 14,11 % (UE: 11,3 % y 16,1 %) | BdE (5/10/2026); ABE Risk Dashboard 2T2026 |
| Coste del capital bancario | — | 8-12 % | ABE, Risk Assessment Report dic. 2025 |
| Curva de Beveridge | España 1994-2022 (Boscá et al.) | España 2010-2026 y zona del euro 2009-2026 | Eurostat jvs_q_r21, une_rt_q |
| IAPC | 2017-2022 (BCE) | Hasta septiembre de 2026: 3,8 %, subyacente 2,5 % | Eurostat |

### Parte 3

| Dato | Anterior | Nuevo | Fuente |
|---|---|---|---|
| Tipos oficiales del BCE | hasta 2023 | Facilidad de depósito 2,50 %, OPF 2,65 %, marginal 2,90 % desde el 16/9/2026 | BCE (FM; tabla de tipos oficiales) |
| Balance del Eurosistema | hasta 2023 | 5,9 billones (16/10/2026); máximo de 8,8 a mediados de 2022 | BCE (ILM) |
| Reglas fiscales | PEC 3 % y 60 % | Marco de 2024: gasto primario neto, salvaguardas de 1 y 0,5 pp y 1,5 % estructural; cláusula de defensa en 17 Estados | Reglamentos (UE) 2024/1263 y 2024/1264; Consejo |
| Umbrales del PDM exterior | CC −4/+6 %; PIIN −35 % | Sin cambios (confirmados) | CE, AMR 2026 |
| MBP | MBP6 | MBP6 vigente; MBP7 publicado en 2025 | FMI |
| Ajuste fiscal recomendado a España | — | ≈ 0,5 pp del PIB al año en 2026-2030 | FMI, Art. IV 2026 |
| Grado de inversión | escala de Bankinter | BBB−/Baa3/BBBL (CQS 3 del Eurosistema) | BCE, ECAF |

### Parte 4

- Tablas de anexos con los datos ya verificados: indicadores y umbrales (PDM 2025, Tratado, reglamentos de 2024,
  Basilea III, SREP 2025, ABE 2T2026), ratios de la banca (2T2026), escala de calificaciones del Eurosistema
  (1/4/2026), gráficos de PIB por PET de España (2T2026), empleo y horas de la zona del euro (2T2026), Brent
  (septiembre de 2026) e impulso fiscal (FMI, octubre de 2026).
- Anexo de España: crecimiento 3,5 % (2024) y 2,8 % (2025), déficit 2,5 % (2025), ajuste recomendado de 0,5 pp
  anuales (FMI, Art. IV 2026); nivel prepandemia en el 2T2022 (Eurostat; sin 2.ª fuente independiente, V22);
  tasa de actividad 74,9 %, apertura ≈ 70 %, paro 10,5 % (Eurostat); ROE 16 % y CET1 14 % (BdE).

## 5. Contenido añadido

- **Capítulo I completo** (C50, P71-P73, Claves): calificación, 4 capacidades y 2 principios, regla del
  tiempo con tabla por convocatoria (`tab:reparto`, elaboración propia con la regla), 7 pasos de lectura
  del cuadernillo con un cuadro de ejemplo marcado (`tab:cuadernillo`, inventado y dicho así), cómo
  redactar, errores típicos y la lectura, matriz y tabla de temas por bloque (`tab:donde-se-estudia`,
  K6/C80; el «3.A.27 Análisis macroeconómico del mercado de trabajo» antiguo se sustituye por
  3.A.25-3.A.28).
- **II.2** PIB frente a RNB (P74, C51; 2023 y 2026) e indicadores adelantados y de alta frecuencia
  (P75, C52; sustituye la imagen del Conference Board, que no se puede publicar).
- **II.4** Sector dominante: petróleo y materias primas (P77, C54; 2016 y 2025), con enfermedad
  holandesa (Corden y Neary, 1982).
- **II.5** Tabla avanzada/emergente (C59).
- Paseo aleatorio del consumo con su fuente (Hall, 1978; Friedman, 1957) y *animal spirits* (Keynes,
  1936): entradas añadidas por el editor al `.bib`.
- Cada indicador del capítulo II con el esquema de §11 (qué mide · cómo se calcula · umbral · cómo se
  lee y con qué se cruza · tema).

### Parte 2

- III.1: definiciones de la EPA con la advertencia de las edades, salario real de consumo y de producto,
  margen bien derivado, demanda y oferta de trabajo, tipos de paro (ficha 5 de Claves), Okun y Phillips y
  cuándo usarlos (C66; 2021), Beveridge con gráfico (C68), demografía (C65; 2026), visados (2020) y
  salario mínimo (C67; 2019).
- III.2: endeudamiento con los umbrales del PDM, brecha crédito-PIB, préstamos en divisas (C73), sector
  bancario completo pero compacto (C4, C5, C35-C37), vivienda (C38), bolsa (C39) y macroprudencial (C40).
- IV.1: IPC frente a deflactor e inflación importada (C13), subyacente y segunda ronda (C14, K22), origen
  de la inflación (C16), efecto base y persistencia (C55; 2023, 2025, 2026), política según el origen
  (C15).
- IV.2: tipo de cambio con la convención del canon y aviso de las estadísticas (K10), traspaso,
  Marshall-Lerner y curva J, régimen e intervención (C56; 2021, 2022, 2026). La adecuación de reservas,
  a V.2 (parte 3).
- IV.3: competitividad no precio (C57) y aranceles: medias simple y ponderada, efectos de aranceles de un
  tercero (C58; 2026 y Meridia).

### Parte 3

- V: saldos sectoriales y volatilidad de la capacidad de financiación (C53; 2018, 2023), superávit (C2),
  apertura, penetración y RRI (llevadas aquí desde la demanda externa), NGEU en la BP (nota; el recuadro
  de Claves, al anexo), reservas en el texto (C29, P85), métricas de vulnerabilidad (nota 35), dinámica
  de la PIIN (C20).
- VI.1: diseño, instrumentos, tono con Taylor, canales, eficacia, balance, dominancia fiscal y «última
  milla» (C60; 2020, 2021, 2024, 2025, 2026).
- VI.2: tono y esfuerzo (C63), reglas de 2024 (C61, V29), dinámica de la deuda y saldo estabilizador
  (C62), riesgos y estrategias (2026), vida media (C41), ingresos bajos y tamaño (C71), inflación y
  cuentas públicas, efectos no keynesianos.
- VI.3 y VI.4: *policy mix* (C64, K30) y políticas de oferta con diagnóstico previo (C70).
- VII: tabla desequilibrio → indicios → recomendaciones (C75, ficha 7 de Claves; base de la ficha de
  repaso), políticas de empleo (C42), presiones de gasto (C43), programa del FMI (C69).

### Parte 4

- Anexo A (`anexo:indicadores`): 3 tablas de indicadores con columnas separadas de referencia oficial y
  orientativa (D-03, C74, K7), Basilea III, ratios bancarios, calificaciones y avanzada/emergente.
- Anexo B (`anexo:preguntas`): tabla de bloques por examen y las preguntas literales de los 14 dictámenes
  (C77, P94), generadas de `examenes.md`.
- Anexos C (expresiones), D (series, hechos estilizados y 7 gráficos de lectura), E (cálculos tipo), F
  (programación financiera del FMI), G (España) y H (dónde se estudia cada bloque).

## 6. Coherencia

- Notación del canon: $\gamma_X$ con subíndice (D012), $Y^p$ potencial (D-05; la ficha
  `saldo-estructural` usa $Y^*$, ya anotado como C3), $\mathrm{OG}$, $q=EP^*/P$ (D013, D015),
  $\alpha$ participación del capital (ficha `contabilidad-crecimiento`), PAT $=Y/L$.
- Hechos estilizados alineados con el 3.A.42 (K12): consumo contemporáneo, consumo público acíclico,
  importaciones procíclicas y demanda externa neta contracíclica. La tabla completa irá en el anexo de
  series (parte 3).
- Remisiones: todas con `\vertema`, con la numeración de `temario.json` (comprobados los 85 códigos);
  primero 3.er ejercicio, luego 4.º (K5). Las internas con `\ref`.
- Contradicciones con otros temas (no se tocan): las 11 de `propuestas-coherencia.md` («Contradicciones
  con otros temas») siguen vigentes; las que afectan a esta parte: 3.A.42 (volatilidad del empleo,
  inversión residencial y existencias), ficha `saldo-estructural` ($Y^*$) y 4.B.4 (filtro HP remitido al
  3.A.41).
- Cambios al canon propuestos (C1-C14) los aplica `tema-canon`; esta parte usa C1 (brecha), C3 ($Y^p$) y
  C10 (hechos estilizados).

### Propuestas de esta parte: aplicadas y rechazadas

- **Aplicadas**: K1 (I y II), K2 (lo de I-II), K4 (remisiones de l. 535, 659, nota 6, nota 7), K5, K6,
  K8, K9, K10 (solo la convención, el texto completo va en IV.2), K13, K14, K15, K16; C8, C9 (con $Y^p$),
  C10 (texto; la tabla, en la parte 3), C11, C12, C22, C26, C45, C46, C47, C48, C50 (con la regla del
  tiempo en lugar de la tabla fija), C51, C52, C54, C59, C80, C82, C83 (FBCF resumida con cita al SEC
  2010), C86; V1-V6, V18, V19, V21, V31, V33, V34, V39.
- **Modificadas**: C49 (la matriz no se va al anexo: queda en I.7 simplificada, como pide K1; la tabla
  desequilibrio → recomendación irá en VII.2); C50 (tabla de reparto fija → regla y tabla por
  convocatoria, D-02; 12′ de lectura → 10-12′); C51 (sin la cifra de Irlanda, «25 % [VERIFICAR]», que el
  verificador no comprobó: se deja el ejemplo sin cifra); C86/V33 (la cita de Peter va como «atribuida»
  con `\parencite{Peter1977}`, sin página).
- **Aplazadas a otras partes**: C13 y el bloque «opcionales» de la demanda externa (apertura,
  penetración, inflación importada, RRI) → V.1; C53 (saldos sectoriales) → V.1; C23 y las
  «Recomendaciones» del perfil cíclico (l. 1078-1110) → VII.2; C44 (gráficos del ciclo y comovimientos)
  y la tabla de C10 → anexo de series.
- **Rechazadas**: la afirmación de la nota 17 de que el Banco de España calcula los tipos reales con
  *swaps* de inflación a 15, 10 y 5 años (V38, no comprobada): queda la idea general sin atribuirla.

### Parte 2

- Notación: $u=U/A$ en las fórmulas de la EPA (canon § 13) y, desde la parte 3, $U_t$/$U^n$ en la curva de Phillips (canon § 6); pendiente $a$ en la curva de Phillips (D060);
  $W$ nominal, $\mu$ margen (canon §6); $q=EP^*/P$ y $q^{ef}$ (D013, D015); APR (canon §11); ROA
  bancario distinto del ROA = EBIT/AT de D062 (C11 del canon).
- IPC y deflactor dichos como en el 3.A.9 revisado (base 2025, Laspeyres encadenado, Paasche
  encadenado) y con su misma fuente (`INE2026IPCMetodologia`, copiada de `3A09.bib`).
- Aplicadas: K17-K23, K10 (IV.2), C1, C4, C5, C7, C13-C16, C21, C25, C28, C30, C31, C34-C40 (C34 y el
  duplicado de C40, al anexo), C55-C58, C65-C68, C72, C73, C81, C83; V7-V17, V25, V37.
- Modificadas: C56 (las reservas pasan a V.2, como en K1); C58 (sin las fechas de los aranceles de 2025
  ni el rango 0,2-7 % de Aiyar et al., que el verificador no comprobó); C66 (en la parte 3 se vuelve a $U_t$/$U^n$, como fija el canon); C67 (sin la
  cifra del SMI, para no duplicar el 3.A.17).
- Aplazadas a la parte 3: C42 (políticas de empleo, a VII.2) y adecuación de reservas (V.2). A la parte 4
  (anexos): tablas de Basilea y de ratios bancarios, párrafos modelo de C34 y C40, gráficos de horas,
  empleo y Brent, y las tablas de temas por bloque y de economía avanzada/emergente movidas desde la
  parte 1.
- Rechazado: el ejemplo de la nota 38 y similares no tocan esta parte.

### Parte 3

- **Tasa de paro**: el canon fija $U_t$, $U^n$ para la tasa de paro y la tasa natural (§ 6, D057; como
  en el 3.A.28) y $u=U/A$ con $U$ parados en las fórmulas de la EPA (§ 13, D048, D065). La guía usa
  ahora las 2 según el contexto (EPA en los indicadores; Phillips con $U_t$) y avisa en nota. Propuesta
  al canon (C9 de coherencia): fijar una regla para los textos que usan las 2 cosas (1D01, 4.A.16,
  4.A.29), p. ej. $u$ tasa y $U$ parados, o una nota estándar como la de la guía.
- Notación aplicada: identidad de la BP de la ficha `identidad-balanza-pagos`; dinámica de la deuda de
  `restriccion-gobierno` (g − τ, i − γ^N, r − γ_Y, ADD, bola de nieve); saldos de `saldo-estructural`
  (b, b^p, b^{ca} = b − ε·OG, b^e, b^{pe}; ε, no η); Taylor de la ficha `taylor` en la forma con
  φ_π = 1,5 y φ_x = 0,5 aplicada a OG; $r^n$ natural (D037); 𝔼 (§ 0).
- Aplicadas: K11, K24-K30, C2, C3, C6, C17-C20, C29, C41-C43, C53, C60-C64, C69-C71, C75; V26, V27, V29,
  V30.
- Modificadas: C17 (Taylor con OG en vez de $x_t$); C19 (sin la cifra de Reinhart, 30-40 %, que no se
  ha comprobado); C27 (sin el ejemplo de la recapitalización de 2012 ni su cifra [VERIFICAR]); C41 (sin
  la vida media del Tesoro); C61 (17 Estados con la cláusula de defensa, según V29, en lugar de «unos 15»).
- A la parte 4 (comentarios «% A ANEXO»): impulso fiscal, inflación y cuentas públicas, escala de
  calificaciones, recuadro NGEU de Claves.

### Parte 4

- Hechos estilizados alineados con el 3.A.42 (K12, C10 del canon: ficha nueva `hechos-estilizados-ciclo`
  propuesta). La volatilidad del empleo queda «similar o algo menor» que la del PIB, distinta de lo que dice
  el Word del 3.A.42 («más volátil»): contradicción anotada para cuando se revise ese tema.
- Anexo de España remite a \vertema{4.A.29} y no repite su contenido.

## 7. Dudas abiertas

1. **Frase cortada de Claves** («en estas estructuras, debe predominar la…», P127): no se ha usado. ¿Qué decía?
2. **Regla del tiempo**: **Resuelta (D-06, 24/10/2026)**: sí; lectura ≈ 10 %, repaso ≈ 5 %, perfil cíclico con peso 1,25.
3. **Umbrales orientativos de crecimiento**: **Resuelta (D-07)**: tramos 0/1/2/3 % con «sólido» desde el 3 % (aplicado en II.2 y en `tab:indicadores-ciclo`).
4. **Cita de Laurence J. Peter**: atribución dudosa (versiones de 1949-1973); queda «atribuida», citando
   *Peter's Quotations* (1977) sin página.
5. **Irlanda 2015**: ¿quieres la cifra de crecimiento del PIB (hay que verificarla en la CSO)?
6. **Guías de preparadores** (Vich Gadella, Cordero Tarifa, Sahuquillo): en la bibliografía con `\nocite` y
   Sahuquillo citado en la vida media de la deuda; ninguna está en local. ¿Bien así?
7. **Ejemplo inventado del cuadernillo**: **Resuelta (D-08)**: `tab:cuadernillo` usa ahora filas reales del dictamen de 2026 (versión rectificada), con fases y fortalezas y debilidades en salvia y salmón; los ejemplos de redacción de II.1 y II.3 pasan a años reales.
8. **Brecha crédito-PIB**: el umbral de 2 puntos (BCBS, 2010) no lo comprobó el verificador (U39).
9. **Sobrecarga del coste de la vivienda** (40 % de la renta, Eurostat), en lugar del «33 %» sin fuente: no
   comprobado en esta revisión (U47).
10. **Regla práctica de deuda externa**: **Resuelta (D-10)**: se queda como orientativa, con su advertencia.
11. **Ejemplo de medida puntual**: **Resuelta (D-11)**: ejemplo de la banca en 2012, en la nota de VI.2: déficit del 10,6 % del PIB, 111.641 M€ (Eurostat, euro indicators 64/2013, primaria, verificada en el PDF); ayudas de 38.343 M€ y déficit sin ellas del 6,98 % (Secretaría de Estado de Presupuestos, 24/4/2013, vía INAP). Comprobación aritmética: 111.641 − 38.343 = 73.298 M€ = 6,98 % del PIB de 1.049.525 M€; ayudas = 3,65 pp.
12. **Notación de la tasa de paro**: **Resuelta (D-12)**: $U_t$/$U^n$ en los modelos y $u=U/A$ en la EPA, con nota; regla para todo el temario (a `canon/pendientes-coherencia.md` por el coordinador).
13. **Tipos reales con *swaps* de inflación del Banco de España** (nota 17): quitado por no localizar la fuente
    (V38). ¿Lo tienes?
14. **Volatilidad del empleo**: **Resuelta (D-09)**: «similar o algo menor» que la del PIB en todo el temario (ya así en `tab:hechos-ciclo`); queda pendiente de coherencia para el 3.A.42.
15. **Pendiente de 2.ª comprobación** (verificador): FBCF de la UE (V19), España prepandemia con INE (V22),
    impulso fiscal de España en 2020 con AMECO, NAWRU con otra fuente (V37), métrica ARA del FMI.
16. **Extensión**: con los gráficos reales el PDF tiene 72 páginas y el cuerpo, 44 (máximo, 50). Si hubiera que recortar, lo primero que podría ir a anexos es la tabla de reparto por convocatoria (I.3) o el apartado de demografía, migración y salario mínimo (III.1).
17. **Tabla de temas por bloque**: **Resuelta (D-13)**: nueva orden `\vertemacorto{código}` (mismo enlace que `\vertema`, texto solo el código, en gris) en `tcee-comun.sty`, `pandoc-macros.tex`, `tcee.module` (LyX), `tcee.lua` (comentario), `construir-tema.py` (enlaces en HTML y Word y `data-app`) y `verificar-tema.py`; usada en `tab:donde-se-estudia`. Los temas ya revisados no la usan, así que no cambian.

## 8. Instrucciones para el vídeo (clase de 1 h 30 min, sin voz por ahora)

> Sustituye al plan de 15 minutos (entregables del 25/10/2026, CRITERIOS §11, punto 5). El guion completo, con lo que enseña cada slide, está en `guion-cante.md`, generado desde `video/escenas.yaml` (`duracion: 5400`, `formato: slides`).

- **Formato** (desde el 27/10/2026, abajo): una clase que recorre toda la guía, con una sección por cada pregunta del dictamen, como **sucesión de slides** que siguen los apartados, gráficos, cuadros y tablas de la guía, con libertad para usar la pizarra. 38 escenas, 148 slides, 244 pasos y unas 14.060 palabras (ritmo ×0,986). Cada slide dice abajo a la derecha su apartado y su página de la guía («§ I.3 · pág. 10», del `.aux`).
- **Minutos por bloque** (cabecera): Introducción 8 (con el método al final) · I. Perfil cíclico 15 · II. Mercados de factores 10 · III. Competitividad 10 · IV. Sector exterior 10 · V. Políticas 26 · VI. Recomendaciones 7 · Conclusión 4.
- **Apartados como en la guía**: I.1-I.6 (I.6, anticipar el diagnóstico, aparte de la oferta), II.1 Mercado de trabajo (4 escenas: cantidades; productividad, CLU y margen; tipos de paro; Okun, Phillips y Beveridge) y II.2 Capitales, III.1 Precios (índices y origen), III.2 Tipo de cambio, III.3 No precio, IV.1-IV.4, V.1-V.5, VI.1-VI.2.
- **Pizarra**: entera en tendencia y ciclo (I.2), el triángulo de Gordon (III.1), los déficits gemelos (IV.1) y los canales de la monetaria (V.1); en un panel al lado de la slide, las fórmulas que conviene llevar al examen (el panel se conserva entre slides seguidas: la brecha de producción en I.3, los determinantes del consumo y de la inversión en I.4, la cadena de los CLU en II.1) y el boceto de Beveridge (`graficos/beveridge-pizarra.tex`, solo del vídeo). Anotaciones a mano encima de las slides: rodear una fila de umbrales o un dato de un gráfico, subrayar la idea clave, tachar la redacción descriptiva, una flecha o una palabra.
- **Lo del anexo junto a su indicador**: umbrales del procedimiento de desequilibrios, Basilea III y reglas fiscales (cuadros verdes), cálculos tipo del anexo A.3 (cuadros azules), expresiones útiles y párrafos modelo (cuadros «Ejemplo de redacción»), lo preguntado en los dictámenes («Nota al opositor») y tablas de la guía (1, 2, 3, 5, 6, 11 y 14) y de los anexos.
- **Script**: `generar-video.py` tiene el formato «slides» como modo nuevo y aditivo (los cantes no cambian: 3A08 sigue en 4816 palabras, ×1,027, 0 avisos, y sus fotogramas son idénticos a los de antes). Mide cada slide y, si algo no cabe aun reduciendo la letra al 80 %, para con un error que dice minuto, escena y texto (también con `--medir`, código 4). `verificar-tema.py` lee los pasos dentro de las slides.

### Formato nuevo de los vídeos de la guía y de la solución (27/10/2026)

Tras ver el borrador de 1 h 30 (sin renderizar de nuevo hasta que Víctor lo pida):
1. El método se junta al final de la introducción (la cabecera queda con 8 bloques).
2. Sucesión de slides con libertad total para usar la pizarra: slide entera, pizarra entera, slide con panel de pizarra o anotaciones a mano encima, según convenga. Sin la franja «Se dice» ni los apuntes. La explicación la dará una voz grabada más adelante; las slides llevan lo esencial y el guion completo queda en el .srt y en las notas.
3. Ningún texto cortado (el borrador cortaba la caja de umbrales del PIB): el generador mide cada caja y parte la slide o falla.
4. Estructura y visualizaciones de la guía en papel, con lo del anexo que sirve para el examen; cada slide lleva «§ … · pág. …» de la guía.
5. Cabecera con el tiempo transcurrido sobre el total, sin lo que queda.
6. Se mantienen las transiciones entre bloques.
7. La ppt del deck, solo cuando Víctor la pida, tras la versión final.
- Vídeo de la solución: como en el examen (cuadro del cuadernillo con el dato resaltado, respuesta escribiéndose como en el papel, slides de por qué entre preguntas).
- El reparto del tiempo, en los 2 vídeos, solo como idea cualitativa (dedicar más tiempo a lo más importante): sin la fórmula ni minutos por pregunta. Sin pausa activa ni «hoja del examen» al final.
- **Aplicado al vídeo de la guía (27/10/2026)**: `escenas.yaml` reescrito en formato slides con el mismo texto hablado aprobado, salvo lo que cambian estas decisiones (el paso de la estructura anuncia el método al final de la introducción; el del uso de la pizarra describe las slides; el reparto del tiempo se cuenta en 2 pasos cualitativos, sin la regla t = W/(n + 0,25) ni los minutos por pregunta). Borrador montado sin audio (`videos/1D01-borrador.mp4`, 90:00), con las notas de cada slide en `videos/1D01-borrador-notas.json`. La ppt, cuando Víctor la pida.

### Decisiones de Víctor sobre la segunda vuelta (24/10/2026)

- Los 11 «Ejemplo de redacción» largos se quedan en el anexo D.1, con remisión desde su indicador.
- La tabla de calificaciones (S&P, Moody's, Fitch; DBRS en cursiva) pasa al cuerpo, en el apartado de política fiscal, junto a la calidad crediticia de la deuda; las tablas bancarias siguen en el anexo B.
- El anexo E («Análisis de casos frecuentes») se mantiene.
- Para que el cuerpo siga en 50 páginas, la conclusión se compacta (el «qué hay que llevarse» ya está en el índice de la introducción) y la tabla de desequilibrios comparte página con ella. Resultado: cuerpo 50, anexos 38, bibliografía 9 (97 págs.).

### Tercera vuelta (25/10/2026)

- Anexos reordenados a petición de Víctor: A Hechos estilizados del ciclo económico y lectura de series; B Indicadores y umbrales; C Cálculos tipo; D Gráficos de lectura (anexo nuevo, separado del de series); E Análisis de casos frecuentes; F FMI; G Un caso: la economía española; H El ejercicio y el método; I Qué se ha preguntado; J Dónde se estudia cada bloque; K Expresiones útiles para redactar (al final). Primero la economía y después el examen. La introducción describe este orden.
- Capas de todos los gráficos rehechas con capas de pgfplots (cuadrícula al fondo; barras y áreas; ejes, cero y umbrales; líneas; puntos; rótulos).
- (25/10) El esquema de la guía va en la caja `esquema` de los temas («Esquema de la guía») al final de la introducción; se quita la conclusión (la guía se cierra con el apartado VI de recomendaciones); la tabla de desequilibrios pasa al principio de VI.2. Cuerpo 50, anexos 37, bibliografía 9.

### Respuestas de Víctor (26/10/2026)

- Cuerpo de 74 págs.: se queda así. Figuras en `[!htb]` (sin huecos). Infografías en una sola copia (`graficos/`). Subrayado `\uline` común a todo el temario (ulem en `tcee-comun.sty`).
- Semáforo de la banca: CET1 <11 % / 11-14 % / >14 %; ROE <8 % / 8-12 % (coste del capital) / >12 %, con el 10 % de la ABE como referencia dentro del tramo intermedio (texto, `tab:indicadores-financiero` y gráfico coherentes).
- Okun con la tasa de paro en mayúscula: $\Delta U_t\approx-0{,}5(\gamma_{Y,t}-\gamma_{Y^p,t})$ (guía, anexo de fórmulas y resumen).
- Duda 6 resuelta: las guías de preparadores se mantienen en la bibliografía como consulta.

### Vivienda: oferta y demanda (26/10/2026)

- Criterio de Víctor: el precio de la vivienda lo fijan las 2 hojas de la tijera de Marshall; hay problema de oferta en la medida en que esta no cubre la demanda existente (a menudo concentrada en ciertas ciudades). Qué filo mover depende de las elasticidades: a corto plazo, con el parque casi fijo, lo que reduce la demanda (vivienda vacía o segunda vivienda, pisos turísticos, compras de no residentes, LTV/LTI) baja la presión, y lo que la apoya (ayudas generales) tiende a capitalizarse en el precio.
- Guía: nueva viñeta «oferta y demanda» en los riesgos de la vivienda (apartado de estabilidad financiera); nueva entrada «Vivienda cara o que se encarece deprisa» en las recomendaciones por desequilibrio (tras la tabla de desequilibrios), en condicional, con las recomendaciones del FMI como tales en notas al pie (Artículo IV 2026, págs. 25-26, 29 y 80-84: desarrollo urbanístico, licencias, ley del suelo, control de alquileres temporal y condicionado, ayudas a la financiación focalizadas, límites LTV; evidencia de Cataluña: alquileres −4-6 %, anuncios −15-30 %; medidas fiscales sobre pisos turísticos y no residentes aún en proyecto, sin evidencia); anexo de España: nueva debilidad (vivienda menos asequible por demanda pujante y oferta rígida, según el FMI, que frena la movilidad) y recomendación de vivienda por los 2 lados, con nota del FMI. Las páginas son las de la edición impresa del informe; no se añade bibliografía nueva (sin red para comprobar artículos, se usa solo lo que dice el FMI).
- Resumen: viñeta «Vivienda cara» en VI; para mantener 10 páginas se acortan las viñetas de déficit exterior, sobrecalentamiento, dependencia energética, medio plazo y paro, 2 rótulos de la tabla y la caja final.
- Mismo problema en otras recomendaciones: corregidas la matriz completa («Políticas de oferta; flexibilizar el mercado laboral» → «Según el tipo de paro») y la inmigración («eleva primero el paro y después el potencial» → eleva el potencial y a corto puede subir algo el paro si el mercado tarda en absorberla). Dudosas, sin tocar: «liberalizar sectores y flexibilizar el mercado de trabajo» si falta competitividad-precio (guía y resumen); las reformas de oferta como «las únicas que elevan el potencial» (la inversión pública también lo hace); «fomento del alquiler» para la movilidad en el paro friccional.
- (Segunda vuelta, aprobada por Víctor) Evidencia de vivienda en `1D01.bib`, con las mismas claves y datos que la solución del examen (Segu2020Vacantes, Carozzi2024HelpToBuy, Fack2006Ayudas, GarciaLopez2020Airbnb, BdE2024Vivienda, Alam2019Macroprudencial, BdF2023AyudasVivienda; siguen también en `solucion.bib`, y biber solo avisa del duplicado). Se citan en la guía: localización (riesgos de la vivienda), vivienda vacía, pisos turísticos, LTV/LTI, no residentes y capitalización de las ayudas (VI.2; Fack, con el 78 % según la reseña del Banco de Francia) y en la recomendación del anexo de España.
- Las 3 frases dudosas, reescritas en la guía y el resumen. Competitividad-precio: medidas según el origen de la pérdida (salarios frente a productividad, márgenes, tipo de cambio). Oferta: «eleva el potencial, como la inversión pública, el capital humano y la I+D» (antes, «las únicas»). Paro friccional: movilidad geográfica si el desajuste es territorial, que la vivienda cara puede frenar (antes, «fomento del alquiler»); también en la infografía `esquema-tipos-paro`. La solución del examen no tenía ninguna de las 3.
- Solución del examen: el entorno `examen` deja de ser una tcolorbox (atrapaba las notas al final de la caja). Ahora es una lista con la misma sangría y la raya morada de changebar, así que las notas van al pie de su página (la raya no se pinta en las notas). `\que` ya no deja espacio antes de `,` `.` `:` `;` `)`; en la guía y el resumen no hay macros que dejen ese hueco.
