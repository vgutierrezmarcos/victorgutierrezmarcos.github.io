# Revisión del 3.B.43 — El origen del euro: SME, criterios de convergencia, SEBC y política monetaria de la zona del euro desde 2009

Tema hecho desde cero el 14/11/2026 (entrega 1: tema y ficha de repaso; sin vídeo), en el worktree `revision-temario-2`, en paralelo con los agentes de los 3.B.44 y 3.B.45. No había tema anterior en el repositorio: la base son los temas propios de Víctor del disco D: con la numeración antigua (3.B.45 «Funcionamiento y evolución del SME. El euro: origen y evolución» y 3.B.46 «El SEBC y la política monetaria de la eurozona…», versiones de 2023 y «Mis temas» de 2024), **redactados de nuevo**, reorganizados para el título actual y puestos al día a noviembre de 2026 con fuentes oficiales (BCE, Banco de España, EUR-Lex, Consejo, TJUE, Eurostat, Comisión). Las dudas se resuelven con la opción recomendada y se anotan como B43-NN (14/11/2026).

## 1. Resumen

- Tema nuevo con 3 apartados: **I. Del SME al euro** (I.1 de Bretton Woods a la serpiente; I.2 el SME, con el modelo de la asimetría y la crisis de 1992-1993; I.3 Delors, Maastricht y las 3 fases; I.4 los criterios de convergencia nominal), **II. El SEBC** (II.1 marco institucional; II.2 objetivo y estrategia; II.3 instrumentos, con el marco operativo de 2024 y el euro digital) y **III. La política monetaria desde 2009** (III.1 crisis de la deuda, con el modelo de la crisis autocumplida; III.2 deflación y expansión cuantitativa; III.3 pandemia, inflación y normalización hasta noviembre de 2026; III.4 la «talla única», con la regla de Taylor por país). Reparto: introducción 2′30″, I 8′30″, II 8′, III 10′, conclusión 1′. Une el antiguo 3.B.45 (SME y euro) y la parte monetaria del antiguo 3.B.46; la gobernanza fiscal y la unión bancaria van a los 3.B.45 y 3.B.44.
- 3 modelos con la estructura rígida a)-e): **la asimetría del SME (problema n−1)**, con `eq:asimetria` $i_B=i_A+\delta^e$; **la crisis de deuda autocumplida** (Calvo, 1988; De Grauwe, 2011) con `eq:autocumplida` $p(1-p)=\kappa$, el umbral $\kappa=1/4$ y el respaldo del banco central (OMT, TPI), y **la talla única**, con `eq:talla-unica` y la regla de Taylor calculada para Alemania, España, Italia, Francia y la zona del euro con datos reales. La credibilidad prestada (Giavazzi-Pagano) y la cláusula de escape (Obstfeld) se aplican y remiten a los 3.B.16 y 3.B.17, que las desarrollan.
- 12 gráficos y figuras propios: 6 de datos (tipos del BCE 1999-2026, balance del Eurosistema, inflación, diferenciales a 10 años, regla de Taylor por país, Informe de Convergencia de 2026), 3 teóricos (serpiente, asimetría del SME, crisis autocumplida; más el marco operativo copiado del 3.A.36) y 2 figuras (cronología, órganos del SEBC); 3 tablas (convergencia 2026, cronología del BCE 2008-2026) y 3 anexos (cronología, derivación del modelo de la crisis, papel internacional del euro) más el de test.
- PDF: 26 páginas de tema, 3 de anexos y 6 de bibliografía (35). Ficha de repaso de 4 páginas a 10,5 pt (última, 81 %). `verificar-tema.py` (envoltorio sobre `_trabajo/`): sin errores propios (los 12 de «imagen inexistente en el HTML» son el efecto conocido de verificar en `_trabajo/`); quedan avisos de «cifra sin cita» en párrafos cuya cita va en el gráfico o en el párrafo vecino, y los del vídeo (entrega 3).
- Datos a noviembre de 2026 con 2 agentes de apoyo: uno descargó las series (BCE, Eurostat, AMECO, Informe de Convergencia) e hizo los gráficos de datos (`_trabajo/datos-graficos.md`); otro comprobó los hechos en fuentes oficiales (`_trabajo/hechos.md`, `_trabajo/bib-hechos.bib`).

## 2. Errores corregidos

Errores del tema antiguo (3.B.45 y 3.B.46 de 2023-2024) corregidos al pasar al nuevo:

| Id | Dónde (tema antiguo) | Decía | Dice ahora |
|---|---|---|---|
| E1 | 3.B.45 y 3.B.46, introducción | La integración «tiene su origen en el Tratado de Roma en 1957» | En el Tratado de París (1951); en este tema no hace falta: la introducción empieza en el euro |
| E2 | Ambos, introducción y notas | UEM «para 20» de los Estados | 21 desde el 1/1/2026 (Bulgaria) |
| E3 | 3.B.45, I.1 | La serpiente reducía las bandas «de ±4,5 % a ±2,25 %» | El túnel era de ±2,25 % frente al dólar (4,5 % de ancho entre 2 monedas europeas); la serpiente limitaba a un 2,25 % la separación entre las monedas comunitarias |
| E4 | 3.B.45, I.1 y II.2.1 | El Informe Werner proponía una UEM «mediante un proceso que debía comenzar en 1980» | Proponía completarla en 3 etapas **antes de 1980** (en 10 años desde 1971) |
| E5 | 3.B.45, II.2.1 | El Informe Werner fue «el resultado de los trabajos del Consejo de Ministros» | Fue un grupo presidido por Pierre Werner, por encargo de la cumbre de La Haya (diciembre de 1969) |
| E6 | 3.B.45, II.2.2 | Delors, «presidente de la Comisión Económica» | Presidente de la Comisión Europea |
| E7 | 3.B.45, I.4.4 | En 1992 «la moneda finlandesa, la libra, la corona sueca y la lira abandonaron el SME» | La libra y la lira suspendieron su participación en el **MTC**; Finlandia y Suecia no estaban en el MTC (tenían su moneda unida al ECU de forma unilateral) y la dejaron flotar |
| E8 | 3.B.45, criterios | Inflación y tipo largo frente a «los 3 Estados miembros con menor inflación» | Frente a los 3 «con mejor comportamiento en materia de estabilidad de precios» (Protocolo 13), sin los atípicos |
| E9 | 3.B.45, criterios | Déficit y deuda como umbrales numéricos («inferior al 3 %», «inferior al 60 %») | El criterio es no estar sometido a una decisión de déficit excesivo (art. 126.6 TFUE); los umbrales son los del PDE |
| E10 | 3.B.45, criterios | Estabilidad cambiaria «en el MTC del SME» | Desde 1999, en el MTC II (banda normal ±15 %) |
| E11 | 3.B.46, objetivos | Valor de referencia de M3 del 4,5 % «actualmente fijado» | Dejó de revisarse en 2003; desde 2021 hay un análisis monetario y financiero |
| E12 | 3.B.46, BCN | Mandato de los gobernadores «fijado en 5 años» | Mínimo de 5 años (art. 14.2 de los Estatutos) |
| E13 | 3.B.46, órganos | El Consejo de Gobierno «se suele reunir el primer jueves de cada mes» | Reuniones de política monetaria cada 6 semanas desde 2015 |
| E14 | 3.B.46, órganos | La rotación de votos (6 + 15) aparecía en el **Consejo General** | Es del **Consejo de Gobierno**; con 21 gobernadores, 2 grupos (5 con 4 votos y 16 con 11) |
| E15 | 3.B.46, variable operativa | El €STR, «promedio de los préstamos interbancarios intradía», «desde 2020» | Tipo medio de los depósitos a un día sin garantía que toman los bancos; publicado desde octubre de 2019; el eonia dejó de publicarse el 3/1/2022 |
| E16 | 3.B.46, reservas mínimas | 1 % «desde 2011» y «se remunera al tipo repo» | 1 % desde el 18/1/2012; sin remuneración desde el 20/9/2023 |
| E17 | 3.B.46, OMA | Subasta a tipo variable «habitual hasta 2009» | Tipo fijo y adjudicación plena desde el 15/10/2008 |
| E18 | 3.B.46, medidas de 2022 | «El BCE ha subido los tipos progresivamente desde julio de 2021» | Desde julio de 2022 |
| E19 | 3.B.46, OMT | Anunciadas «en agosto de 2012 (el mismo día de la célebre intervención de Draghi)» | El discurso fue el 26/7/2012; el anuncio, el 2/8/2012, y las características técnicas, el 6/9/2012 |
| E20 | 3.B.46, objetivos | El sesgo verde de las compras de bonos corporativos «quedará para 2024» | Se aplicó desde octubre de 2022 |
| E21 | 3.B.45, nota 29 | Duisenberg, gobernador del banco central «neerlandés» (bien) y elegido «por común acuerdo» frente al veto francés | Se mantiene, con la sucesión hasta Lagarde |

## 3. Marcas resueltas

| Marca | Texto original | Qué se ha hecho |
|---|---|---|
| Avisos de cambio de temario (ambos temas) | «Con el cambio de temario, a partir de 2023…» | Desaparecen; el tema se rehace con el título actual |
| Notas de trabajo («Está copiado todo lo del tema de Juan Luis…», «Del tema 3.B.46 de Juan Luis están copiadas…», «El primer apartado está mejor por aquí») | — | No se publican; no se nombra a ningún preparador |
| Relevancia, Extensiones y Opinión vacías (ambos) | «‒ » | Escritas |
| Problemática «¿?» (3.B.46) | — | Escrita (4 preguntas) |
| «Objetivo principal» y «Otros objetivos: la estabilidad financiera» vacíos (3.B.46, 1.2.1) | — | Escritos en II.2 |
| «Gobernanza: inicios y evolución» vacíos (3.B.46, 2.2) | — | No se escriben aquí: la gobernanza es el 3.B.45 (remisión) |
| Imagen 1 del 3.B.45 (serpiente, de Víctor) | Imagen | Rehecha en TikZ (`serpiente`) |
| Imágenes de tipos del BCE (RTVE), Semestre (Consejo), pilares de la Unión Bancaria (Comisión), organización del SEBC («Fuente: …» vacía), sistema de rotación (BCE 2011) | Capturas | Sustituidas por gráficos y figuras propios (`tipos-bce`, `organos-sebc`) y el texto de la rotación; Semestre y Unión Bancaria van a los 3.B.45 y 3.B.44 |
| «Fuente: …» vacía (organización del SEBC; etapas hacia una UEM genuina) | — | Figura propia con fuente (Protocolo 4, BCE); la otra imagen pertenece al 3.B.45 |
| Enlaces de YouTube (introducción) y de la BBC («Black Wednesday») | Enlaces | No se conservan en el texto: son vídeos divulgativos; la crisis de 1992 va con fuentes del Banco de Inglaterra y Eichengreen y Wyplosz (B43-08) |
| «Faltarían los anexos… CBDC y euro digital» | — | El euro digital, en II.3.3 |
| Anexos 1-3 del 3.B.46 («son del 3.B.45»: ventajas e inconvenientes de la unión, criterios de adhesión, tríada) y anexo 6 (agregados) vacíos | — | Ventajas, inconvenientes y tríada son del 3.B.16 y del 3.B.15 (remisión); los agregados, del 3.A.35 |
| Anexo 7 del 3.B.46 (regla de Taylor e índices de condiciones monetarias) | Texto | Pasa al cuerpo como el modelo de la «talla única» (III.4), con datos reales por país |
| Anexo 1 del 3.B.45 (programas de asistencia) y anexos 4-5 del 3.B.46 (PEC, Semestre) | Tablas | Son del 3.B.45 (gobernanza): no se repiten |
| Enlace de test | — | Caja estándar del simulador (`tema=3.B.43`) |

## 4. Datos actualizados

Todos consultados el 14/11/2026. No había tema anterior en el repositorio: «antes» es el tema de Víctor de 2023-2024.

| Dato | Antes | Ahora | Fuente | Segunda comprobación |
|---|---|---|---|---|
| Tipos del BCE | 4,25 % OPF (agosto de 2023) | Depósito 2,50 %, OPF 2,65 %, marginal 2,90 % desde el 16/9/2026 (subidas del 17/6 y 16/9/2026; mantenidos el 29/10) | BCE, FM y tabla de tipos | Nota de prensa del 29/10/2026; copia del BdE de la del 10/9 |
| Lista de cambios 2008-2026 | — | 42 cambios con fecha de efecto (anexo A) | BCE, FM | Tabla «Key ECB interest rates» |
| Balance del Eurosistema | — | Máximo 8,836 billones (24/6/2022); 5,913 (6/11/2026) | BCE, ILM | CSV del 1D01 (mismos valores) |
| Inflación de la zona del euro | — | 10,6 % (oct. 2022); −0,6 % (ene. 2015); 4,0 % y subyacente 2,5 % (oct. 2026, avance) | Eurostat prc_hicp_minr | CSV del 3A41 y nota de avance |
| Diferenciales a 10 años | — | Grecia 2.739 pb (feb. 2012), Portugal 1.203, España 555 (jul. 2012), Italia 519 (nov. 2011); oct. 2026: Francia 147, Italia 126, España 65 | BCE, IRS | CSV del 3B26 (2007-2016, iguales) |
| Regla de Taylor por país | Anexo sin datos | 2003: España 7,2 %, Alemania 1,9 %; 2026: España 7,5, zona del euro 5,1, Alemania 4,3 | Eurostat, AMECO (primavera de 2026), BCE | Zona del euro igual que el 3A36 |
| Informe de Convergencia | 2022 | 24/6/2026: referencias 2,7 % y 5,1 %; Chequia y Suecia cumplen los económicos; HU, PL, RO con PDE; nadie en el MTC II | BCE (informe y nota) | Tabla 3.1 y cap. 4 del informe |
| Bulgaria | — | Informe de 4/6/2025; Decisión 2025/1407 y Reglamento 2025/1409 (8/7/2025); 1,95583 leva; euro desde 1/1/2026 | BCE; EUR-Lex | «Our money» del BCE |
| España en 1998 | — | IAPC 1,8 %; déficit 2,6 %; deuda 68,8 %; tipo largo 6,3 % | IME (1998) | — |
| Comité Ejecutivo | Lagarde y De Guindos | Lagarde hasta el 7/2/2027 (anunciado el 29/10/2026); Vujčić VP desde 1/6/2026; Schnabel al FMI el 3/1/2027 | BCE (mandatos y notas) | HNB; notas de prensa |
| Rotación de votos | 6 + 15 | Igual con 21 gobernadores (5 con 4 votos, 16 con 11); con 22, 3 grupos (4, 8 y 3) | BCE | Boletín Mensual de julio de 2009 |
| Capital del BCE | 10.825 M€ (2023) | 10.825 M€; Banco de España 9,6690 % (11,6851 % del Eurosistema) | BCE | — |
| Resultados del BCE | — | −1.266 M€ (2023), −7.944 (2024), −1.254 (2025) | BCE, cuentas | Nota de 2024 |
| Estrategia | 2021 | Evaluación de 30/6/2025 | BCE | Rueda de prensa de Sintra |
| Reservas mínimas | 1 % «remunerado al tipo repo» | 1 % sin remunerar desde 20/9/2023 | BCE | Marco operativo de 2024 |
| Euro digital | «analizado por el BCE» | Consejo (19/12/2025); mandato negociador del PE (9/7/2026); trílogos sin acuerdo | OEIL; BCE | Prensa (trílogos) |
| SME: devaluaciones de la peseta | «fuertes devaluaciones» | −5 % (sept. 1992), −6 % (22/11/1992), −8 % (13/5/1993), −7 % (6/3/1995) | BPI, informes anuales | — |
| Papel internacional del euro | BIS 2022, 30 % de los cambios; 20 % de reservas | 20,2 % de las reservas (4T 2025) y 20,6 % (2T 2026, COFER); deuda internacional 24,6 % | BCE (junio de 2026); FMI | COFER |

## 5. Contenido añadido

- **El modelo de la asimetría del SME** (problema n−1), con el gráfico de los 2 mercados de dinero y la evidencia de Giavazzi y Giovannini (1989) y Fratianni y Von Hagen (1990).
- **El modelo de la crisis de deuda autocumplida** con el respaldo del banco central (anexo B con la derivación, la estabilidad y el respaldo), la evidencia de De Grauwe y Ji (2013) y de Altavilla, Giannone y Lenza (2016), y la caja de los tribunales (*Gauweiler*, *Weiss*, Karlsruhe 2020, infracción de 2021).
- **La talla única** con la regla de Taylor por país (desarrolla el anexo 7 del antiguo 3.B.46).
- **Criterios de convergencia** con el texto del Protocolo 13, los informes de 2024, 2025 (Bulgaria) y 2026, el MTC II y la valoración.
- **SEBC**: independencia en 4 dimensiones, rotación de votos, clave de capital, pérdidas del BCE, Comité Ejecutivo a noviembre de 2026.
- **Estrategia**: las 4 versiones (1998, 2003, 2021, 2025).
- **Instrumentos**: el marco operativo de 2024 (con el gráfico del 3.A.36), los no convencionales en 5 familias, OMT frente a TPI, el euro digital.
- **La política desde 2009 hasta noviembre de 2026**: crisis de deuda (SMP, Deauville, subidas de Trichet, LTRO a 3 años, «lo que sea necesario»), deflación y APP, PEPP, inflación y subidas de 450 pb, normalización, recortes de 2024-2025 y las subidas de 2026 por la guerra de Oriente Próximo.
- **Anexos**: cronología de las decisiones del BCE 2008-2026 y el papel internacional del euro (tema de referencia según D117).
- **Material del disco D: usado**: «Temas a imprimir\11. Unión Europea\Tema 3.B.45 - v.2023.pdf» y «Tema 3.B.46 - v.2023.pdf» (base de la estructura y del contenido), «Mis temas\Tema 3.B.45 - v.2 - 2024.docx» y «Tema 3.B.46 - v.2 - 2024.docx» (versión algo reordenada; añade el papel internacional del euro y los regímenes ligados al euro), la imagen «3.B.45 Serpiente Monetaria Europea.jpg» (rehecha en TikZ), De Grauwe, *Economics of Monetary Union* (citado), «BCE Política monetaria 2011» (instrumentos clásicos; no se cita: superado por las fuentes actuales), ECB WP 2527 y «The ECB Quantitative Easing Programme: Limits and Risks» (consultados; no se citan). El tema de ICEX-CECO 3B43 (82 páginas escaneadas, sin texto) solo se miró como contraste de estructura; no se cita. El tema 44-B de Ángel y los apuntes de unión monetaria no se usaron (el contenido está cubierto por las fuentes citadas).

## 6. Coherencia

- **3.B.16**: no se repite la teoría de las AMO, la credibilidad prestada (Barro-Gordon, Giavazzi-Pagano: II.4.2) ni la fragilidad de palabra (III.2.1): se remite y aquí se formaliza la crisis autocumplida con el papel del banco central. Mismas claves (`GiavazziPagano1988Advantage`, `DeGrauwe2011Governance`, `Draghi2012Speech`, `BCE2012OMT`, `TJUE2015Gauweiler`, `TJUE2018Weiss`) y la misma traducción de la frase de Draghi.
- **3.B.17**: la crisis de 1992-1993 se cuenta con hechos y se remite a su modelo de la cláusula de escape (misma clave `Obstfeld1996`, `EichengreenWyplosz1993Unstable`, `BoE1992Operation`).
- **3.A.36**: instrumentos convencionales, no convencionales, marco operativo y euro digital, coherentes; el gráfico `pasillo-suelo` se copia sin cambios como `marco-operativo`; los valores de la regla de Taylor de la zona del euro son los suyos. Su caja «Aquí no se trata el detalle institucional del Eurosistema \vertema{3.B.43}» queda cubierta en II.1.
- **3.A.40**: mismas cifras (PEPP 1,85 billones, 450 pb, balance 8,8 y 5,9 billones, OMT nunca usadas, TPI); no se repiten el *policy mix* ni las fases fiscales.
- **3.B.36**: la descripción del BCE es coherente, salvo la fecha de salida de Lagarde (anotada en `_trabajo/canon-pendiente.md`).
- **3.B.44 / 3.B.45**: la supervisión del BCE (MUS), MUR, FUR y EDIS van al 3.B.44; PEC, Semestre, PDM, MEDE y la respuesta fiscal a la Covid, al 3.B.45; aquí solo se remite (OMT con programa del MEDE, criterios fiscales del TPI).
- **4.º ejercicio**: \vertema{4.A.27} (ajuste de España para entrar en el euro), \vertema{4.A.28} (la crisis en España), \vertema{4.A.21} (TARGET y la balanza de pagos), \vertema{4.A.19} (Banco de España y sistema financiero).
- **Canon**: propuestas en `_trabajo/canon-pendiente.md` (fichas nuevas `asimetria-sme` y `crisis-deuda-autocumplida`, variante «talla única» de `taylor`, puesta al día de `criterios-convergencia-nominal` y `papel-internacional-euro`, y 6 discrepancias con otros temas, que no se han tocado).

## Reglas de las tandas 8.ª y 9.ª y transversal (aplicadas, 14/11/2026)

| Regla | Cómo se ha aplicado |
|---|---|
| Estructura rígida de modelo | 3 modelos con a) Idea, b) Modelo (i-iii), c) Extensiones, d) Evidencia empírica, e) Valoración |
| Sin citas Harvard | Solo `\nocite` y `\textcite` de obras originales; ningún `\parencite` |
| Nunca citar a Víctor | Ninguna entrada suya; gráficos «elaboración propia» |
| Ni «Pegatina» ni «Dicho» | No hay; un solo refrán, el del enganche («Cría fama y échate a dormir», no usado en otro tema; anotado en refranes-tanda.txt), retomado en la idea final |
| Nobel con motivo oficial | Mundell (1999), Kydland y Prescott (2004), Diamond, Dybvig y Bernanke (2022), Hall y Woodford (2026) |
| `\vertema` al 4.º ejercicio | 4.A.19, 4.A.21, 4.A.27, 4.A.28 |
| Resultados clave en morado | `eq:asimetria`, `eq:autocumplida`, `eq:talla-unica` con `\funcionclave` |
| Pasos con sangría | Desarrollos por pasos en sublistas |
| Cajas grises | Notación; los tribunales; test |
| Ejemplos sin nombres propios | Países A y B, «un Estado» |
| Inglés entre paréntesis | *adjustable peg*, *redundancy problem*, *opt-out*, *demand-driven floor*, *quantitative easing*, *forward guidance*, *one size fits all*… |
| Identidad frente a teoría cuantitativa | No sale |
| Anexo de test | Caja estándar con `tema=3.B.43` |
| Sin páginas en blanco ni desbordes | Comprobado con `verificar-tema.py` sobre `_trabajo/` y sin líneas desbordadas |

## 7. Dudas abiertas

Todas aplicadas con la opción recomendada (14/11/2026); para que Víctor las confirme.

- **B43-01** Estructura: no hay un único tema antiguo; se unen el 3.B.45 (SME y euro: sus bloques I y II pasan a I) y la parte monetaria del 3.B.46 (su bloque 1 pasa a II); la evolución del euro (bloque 3 del 3.B.45) se rehace como III, solo con la política monetaria, porque la gobernanza y la unión bancaria tienen ahora sus temas. Opciones: (a) así **[aplicada]**; (b) mantener el bloque «El euro: evolución» del 3.B.45 con la gobernanza resumida.
- **B43-02** Refrán: «Cría fama y échate a dormir» (credibilidad del BCE, OMT que nunca se usaron; idea final: la fama no permite dormirse, 2021). Opciones: (a) mantenerlo **[aplicada]**; (b) «Más vale prevenir que curar» (ya en 3.B.22 y 3.B.31).
- **B43-03** El modelo de la crisis autocumplida es una versión propia y sencilla (superávit uniforme, impago total, inversores neutrales al riesgo) de la idea de Calvo (1988) y De Grauwe (2011), para llegar a una condición cantable $p(1-p)=\kappa$; los tipos del ejemplo numérico ($\kappa=0{,}16$) son exagerados a propósito (anexo B lo dice). Opciones: (a) así **[aplicada]**; (b) contarlo solo de palabra, como el 3.B.16.
- **B43-04** Modelo del SME: se elige la asimetría (problema n−1) y no Barro-Gordon con «atarse las manos» ni Obstfeld, que ya desarrollan los 3.B.16 y 3.B.17; aquí se aplican y remiten. Opciones: (a) así **[aplicada]**; (b) repetir el Barro-Gordon aplicado.
- **B43-05** Papel internacional del euro (D117: tema de referencia el 3.B.43): va en un anexo, no en el cuerpo, por tiempo. Opciones: (a) anexo **[aplicada]**; (b) un subapartado III.5 quitando tiempo a III.2-III.3.
- **B43-06** Brecha de producción de AMECO: se usa la previsión de primavera de 2026 (la de otoño sale el 17/11/2026); rehacer `datos/taylor-paises.csv` y el del 3A36 ese día. Inflación de octubre de 2026: avance (definitivo el 17/11).
- **B43-07** Lagarde deja el BCE el 7/2/2027 y Schnabel el 3/1/2027 (notas del BCE); a 14/11/2026 no hay sucesores (el Consejo Europeo del 26-27/11 podría nombrarlos: solo prensa). Revisar en la próxima pasada; el 3.B.36 dice «hasta octubre de 2027» (anotado, no tocado).
- **B43-08** Los enlaces de YouTube del tema antiguo (introducción y «Black Wednesday» de la BBC) no se conservan; la crisis de 1992 va con fuentes oficiales (BPI, Banco de Inglaterra). Opciones: (a) así **[aplicada]**; (b) añadirlos en una nota «Para ver».
- **B43-09** No comprobados en fuente oficial: el número de realineamientos del SME (11 entre 1979 y 1987, de un documento de trabajo del Banco de Inglaterra), los porcentajes de los referendos danés (2000) y sueco (2003), que no se dan, y los criterios 3 y 4 del TPI (leídos solo los 2 primeros en la nota; los otros 2, de la propia nota según 3A36). El texto del TFUE no pudo descargarse de EUR-Lex (bloqueo): sus artículos se citan por el Informe de Convergencia de 2026.
- **B43-10** La revisión de los parámetros del marco operativo prevista para 2026 no se ha publicado: el tema dice que no se ha anunciado aún.
- **B43-11** El diferencial español con Alemania en 2005-2007: el tema antiguo decía que llegó a −5 pb el 25/11/2004 (dato diario no comprobado); con medias mensuales del BCE el mínimo es 0 pb (agosto de 2005). Se dice «prácticamente nulo».

## 8. Instrucciones para el vídeo

- **Enganche e idea final**: «Cría fama y échate a dormir»; Draghi en Londres (26/7/2012) y las primas que bajan sin compras; hoy, 21 Estados y tipos al 2,50 % por la energía. Idea final: la fama de 2012 bastó, pero 2021 enseñó que no se puede dormir: la credibilidad se cría cumpliendo el 2 %.
- **Introducción y conclusión, sin pizarra** (`modo: guion`).
- **I**: la serpiente en la pizarra por capas (ejes, túnel, centro, bordes, anchos, fin del túnel, rótulos); la cronología como apoyo; el modelo de la asimetría en la pizarra: `sme-asimetria` por capas (A: ejes, demanda, oferta e $i_A$; B: ejes, demanda, recta de la paridad y oferta; la contracción en A, el nuevo $i_A$ y la contracción forzosa en B) con la función clave `eq:asimetria` recuadrada; criterios: la lista en la pizarra (4 + legal) y `convergencia-2026` como apoyo.
- **II**: `organos-sebc` como apoyo que se va completando; la rotación de votos se escribe (5 → 4; 16 → 11; 6 + 15 = 21); estrategia de palabra; `marco-operativo` en la pizarra por capas (como en el 3.A.36); `tipos-bce` y `balance-eurosistema` como apoyo.
- **III**: `tipos-bce` vuelve como apoyo al empezar; `diferenciales` como apoyo; el modelo de la crisis en la pizarra: los pasos 1-3 como fórmulas, la función clave `eq:autocumplida` recuadrada y `crisis-autocumplida` por capas (ejes, bisectriz, curva, equilibrios, huida, $\kappa'$, respaldo); `inflacion-zona-euro` como apoyo; la talla única: `eq:talla-unica` recuadrada y `taylor-paises` como apoyo.
- **Funciones clave que se conservan**: `eq:asimetria` (I.2), `eq:autocumplida` (III.1-III.2) y `eq:talla-unica` (III.4).
- Nunca se dice el número de un tema en voz alta.

## Listas en las notas al pie (15/11/2026)

- Nota de las funciones básicas del Eurosistema: las otras 5 funciones del BCE, en itemize; la del tipo de cambio sigue en párrafo aparte.
