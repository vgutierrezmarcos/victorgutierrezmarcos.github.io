# Revisión del 3.B.28 — Economía de los países en desarrollo, teorías recientes del desarrollo, evidencia experimental y políticas

Revisión autónoma (Víctor fuera del 31/10 al 9/11/2026). Fuente nueva en LaTeX (`3B28.tex`), escrita en 2 partes el 3/11/2026: la **parte 1**, la introducción y los apartados I y II; la **parte 2**, el apartado III, la conclusión y los anexos. Las dudas se resuelven con la opción recomendada y se anotan como B28-NN. El Word del original es, según su propio comentario, una copia del tema de otro preparador: **todo el texto está redactado de nuevo**. Para la estructura y el contenido se han contrastado los temas de Miquel Tebar («B.28 Economía de los países en desarrollo») y de Luis de Fuentes («3B_29», temario anterior: fallo de coordinación, gran empujón, anillo O); no se ha copiado texto de ninguno (comprobado con 8-gramas y con subcadenas de 45 letras: solo coinciden el título oficial, los títulos de los apartados del original y la motivación oficial del Nobel de 1974).

## 1. Resumen

- Tema completo (3/11/2026). Parte 1: introducción con sus 5 bloques, esquema, nota del reparto, notación, «Para saber más», apartado I (medición y características) y apartado II (de los 50 a los 90). Parte 2: apartado III (teoría formal, enfoque cultural, institucional, micro y aproximación experimental, políticas), conclusión y 5 anexos (IDH, teorías clásicas con MSV, evaluación de impacto con la demostración del sesgo de selección, tabla de experimentos, test).
- Estructura de la fase de coherencia: I 3′30″ (I.1 1′30″, I.2 2′), II 7′30″ (II.1 y II.2 45″, II.3 4′30″, II.4 1′30″), III 15′30″ y conclusión 1′; introducción 2′30″.
- Enganche nuevo: «Unos nacen con estrella y otros estrellados», con Kenia frente a España y la prima de ciudadanía de Milanović; Kenia es el ejemplo conductor.
- Datos al día: pobreza con la línea de 3,00 $ de PPA de 2021 (43,4 % → 10,1 %, 824 millones, 70 % en el África subsahariana, China 64 % de la caída), IDH 2023, clasificación por renta de julio de 2026, tabla de rasgos con datos del WDI; 3 gráficos de datos y 5 de teoría pedidos (uno, copia del 3.A.43).
- III con la descomposición del sesgo de selección como única función clave, la evidencia experimental con Kenia como hilo (desparasitación, comidas en preescolares, libros de texto, fertilizantes, GiveDirectly, M-Pesa) y 6 lecciones de política; conclusión que retoma el refrán del enganche.
- `3B28.bib` (153 entradas, con las claves de los temas revisados), `graficos-pedidos.json` (8 gráficos), `seo.json`. Compila sin referencias ni citas indefinidas: 30 págs. de tema, 6 de anexos.

## 2. Errores corregidos

| Dónde (Word) | Decía | Dice ahora |
|---|---|---|
| Introducción, enganche (l. 31) y notas 1-3 | 8,4 % de pobreza extrema con 2,15 $ de PPA de 2017, frente al 35 % en 1990; China, del 66 % al 2 %; la mitad de los pobres en África | Línea de **3,00 $ de PPA de 2021** (desde junio de 2025): 43,4 % (1990) → 10,1 % (2024), 824 millones; China, 83 % → 0 desde 2019 y 64 % de la caída; el 70 % de los pobres en el África subsahariana (V1-V6) |
| Introducción (l. 49) | «El caso paradigmático es China, con un fuerte crecimiento económico pero un bajo desarrollo» | China tiene desarrollo humano **alto** (0,797, puesto 78): el ejemplo se sustituye por Guinea Ecuatorial frente a Sri Lanka (misma renta, puestos 133 y 89) y Kenia frente a Nigeria (V8) |
| Introducción, relevancia (l. 57) | «el PIB real per cápita en economías emergentes se ha más que doblado entre 1995 y 2019», sin fuente | ×2,6 entre 1995 y 2024, frente a ×1,5 en las avanzadas (FMI, WEO de octubre de 2026; V7) |
| I.1 (l. 162-175) y nota 4 | IDH «ponderado»; «PNB per cápita»; índices de pobreza humana como vigentes | IDH = **media geométrica** (desde 2010); **RNB** por habitante en PPA; el índice de pobreza multidimensional **sustituyó en 2010** a los de pobreza humana (V11, V12) |
| I.2 (l. 180-215) | «elevado desempleo»; «no hay una clase media»; «alta tasa de natalidad y de mortalidad»; «crecimiento de la población que supera el del producto» | Poco paro abierto y mucho subempleo e informalidad; desigualdad alta, sobre todo en América Latina y el África austral; transición demográfica a medias (mortalidad ya baja); el lastre de una $n$ alta en el modelo de Solow, sin generalizar |
| II.1 (l. 196) | Residuo de Solow «del 88 %… el capital un 12 %» | 87,5 % del aumento de la **producción por hora trabajada** en EE. UU., 1909-1949 (Solow, 1957; V17), con las palabras del 3.A.45 |
| II.1 (l. 190) | Convergencia condicional: «el **tamaño** de las economías converge» | La **renta por habitante** de cada país converge a su propio estado estacionario |
| II.2 (l. 218) | «Como apuntaba el Premio Nobel Theodore Schultz, el problema no era una inversión débil, sino que el desarrollo incipiente actuaba como barrera para lograr invertir» | No es la tesis de Schultz (1964), que es la contraria: los campesinos son pobres pero eficientes y les faltan factores nuevos; se presenta como la excepción y germen de la contrarrevolución (V45), sin comillas |
| II.3.1, Lewis, implicaciones | «¿Qué se necesita para la transición? Una expansión en la demanda de bienes industriales… Un fallo de coordinación» | En Lewis el motor es la **acumulación del beneficio** del sector moderno (oferta); el fallo de coordinación es del gran empujón |
| II.3.1, Lewis | $L^D=P\cdot\mathrm{PMg}_L$; «excedente del productor»; «desaparición del desempleo» | $p\,\mathrm{PMg}_L(K)=w_M$ (la demanda de trabajo fija $L_M$); beneficio de los capitalistas; desaparece el **subempleo** (excedente de trabajo) |
| II.3.1, Rostow | «(años 60)»; 2.ª etapa «transición», 4.ª «madurez económica», 5.ª «consumo en masa» | **Rostow (1960)**; «condiciones previas para el despegue», «camino hacia la madurez», «era del alto consumo de masas» (V25) |
| II.3.2, Myrdal y nota 8 | «Myrdal (1956)»; Nobel por el análisis de la «**independencia**» de los fenómenos | **Myrdal (1957)**; «**interdependencia**» (V19, V20) |
| II.3.2, Kaldor | «Kaldor (1974)»; «2 ecuaciones» sin escribir; «β·α < 1 y las constantes son 0»; nota 10 | **Kaldor (1966 y 1970)** y Dixon y Thirlwall (1975) (V26); las ecuaciones van al anexo B (parte 2) con letras del canon; la nota 10 se explica allí |
| II.3.2, Nurkse | Lista de 4 causas (elasticidad de sustitución, mercados financieros, demografía, impaciencia) atribuida a Nurkse | Nurkse (1953) es el **círculo vicioso** por la oferta y por la demanda; la lista pasa a los supuestos de la trampa como mecanismos posibles, sin atribuírsela |
| Nota 11 | «Solow matiza que pueden existir trampas de pobreza» | La trampa con función en S es de **Azariadis y Drazen (1990)** (canon, ficha `trampas-pobreza`; V29), con el gráfico del 3.A.43 |
| Nota 12 | «Nelson» sin año | **Nelson (1956)**, *AER* (V28), con su gráfico pequeño en la nota |
| II.3.2 | Hirschman sin año | **Hirschman (1958)** (V30) |
| II.3.3 | «Argumento centro-periferia (o teoría de la dependencia)» | La teoría de la dependencia (Frank, 1967; Cardoso y Faletto, 1969) es una corriente posterior y más radical que el estructuralismo de la CEPAL |
| II.3.3 | «lo que **Grubel** tildó de “especialización perversa”» | Quitado: ninguna fuente lo atribuye a Grubel (V36) |
| II.3.3 | Prebisch y Singer «en los años 50» | Prebisch (1949) y Singer (1950) (V35) |
| II.3.4 | «IOE: se trata de una política que defiende las subvenciones a la exportación» | Tipo de cambio realista, acceso libre a los insumos importados y apoyos condicionados a exportar (P52) |
| II.5.2 (l. 741) | Conferencia Mundial sobre el Empleo de la OIT «en 1975» | **1976** (Ginebra, 4-17 de junio) (V39) |
| II.4 y II.5.3 | Williamson «(1990)» en un sitio y «en 1989» en otro | Conferencia de noviembre de **1989**, publicada en **1990** (V37) |
| II.4 (l. 699) | Stiglitz, «el milagro del Sudeste Asiático» (1993) | El informe es del **Banco Mundial (1993)**, *The East Asian Miracle*; Stiglitz escribe en **1996** (V38) |
| II.5.3 (l. 805) | «en 1998 se promulgó el “Consenso de Santiago”» | No se promulgó: es la propuesta del presidente del Banco Mundial (Wolfensohn, 1998) de las reformas de segunda generación (V40) |
| II.4 y II.5 | Tigres (Corea, Taiwán, Hong Kong, Singapur) y «dragones» | Solo «los 4 tigres asiáticos» (V58) |
| III.1, enfoque cultural | «gap de la ambición» de Ray; *mindset effect* de Duflo sin fuente | **Brecha de aspiraciones** (Ray, 2006; Genicot y Ray, 2017); la desesperanza con su fuente (Duflo, 2012, Tanner Lectures), sin comillas (V46) |
| III.2, enfoque institucional | Instrumento de AJR «correlacionado con el crecimiento del PIB per cápita»; «resultado robusto y casual» | Correlacionado con las instituciones y con el **nivel** de renta; efecto **causal** (VI 0,94 frente a MCO 0,52), en una frase y con `\vertema{3.A.45}` (D125; V44) |
| III.2 | «Hall Jones»; «la falta arrogancia» (Hayek); «visión ideológica (Piketty)»; «Bénabou (1996)» | Hall y Jones (1999); la cita de Hayek se quita (está en el 3.A.45); solo la visión del conflicto social de AJR (2005), sin atribuir la ideológica a Piketty; Benhabib y Rustichini (1996) no se repite aquí (V42, V43) |
| III.2 | «Más allá del consenso de Washington»: «había que suplementar las ideas del Consenso de Washington con reformas institucionales» entre comillas | Burki y Perry (1998) sin comillas: la frase no está literal en el libro (V41) |
| III.3, crédito y nota 19 | «la CIEDI del Banco Mundial, la cual provee aseguramiento a inversiones extranjeras» | El seguro contra riesgos políticos es del **OMGI (MIGA)**; el CIADI resuelve diferencias (V55) |
| III.3, crédito | «[ver nota al pie 16]» a mano | Quitado (la industria naciente está en el anexo B) |
| III.3, vacunación (l. 985) | «las tasas de vacunación pasaron del 18 % al 75 % cuando las vacunas dejaron de costar algo menos de un dólar» | Mezclaba 2 estudios: vacunas con lentejas en Udaipur, **6 → 18 → 39 %** (Banerjee et al., 2010); desparasitación en Kenia, una tasa pequeña redujo la participación **en torno a un 80 %** (Kremer y Miguel, 2007) (V47) |
| III.3, educación y notas 21-22 | Desayunos gratis en Kenia «no se tradujo en una mejora del aprendizaje»; la desparasitación no mejoró los resultados | Comidas en **preescolares**: +31 % de asistencia y mejores pruebas donde el maestro tenía experiencia (Vermeersch y Kremer, 2005); desparasitación: una cuarta parte menos de absentismo (Miguel y Kremer, 2004) y más consumo y salario 20 años después (Hamory et al., 2021) (V48) |
| III.3, microcréditos | Fertilizantes y sesgo al presente como resultado de los microcréditos | Separados: 6 RCT de microcréditos con efectos modestos (Banerjee, Karlan y Zinman, 2015); fertilizantes, Duflo, Kremer y Robinson (2011) (V50) |
| III.3, valoración | Cita de Deaton entre comillas («Es como descubrir cómo matar a una avispa…») | No aparece en ninguna fuente: sin comillas, la idea de Deaton (2010) de palabra (V51) |
| III.3, valoración | «el enfoque experimental no está respaldado por una teoría»; «la capacidad de extrapolar sería casi nula»; «los Nobeles quieren que el Estado haga más cosas» | Validez externa con Deaton (2010) y Deaton y Cartwright (2018); la exageración y la frase sin fuente se quitan |
| III.3, valoración | Efecto Hawthorne sin fuente | Con Levitt y List (2011), que muestran que la versión original no se sostiene (V54) |

## 3. Marcas resueltas

| Marca | Texto original | Qué se hizo |
|---|---|---|
| P1 (amarillo, introducción) | «La teoría del desarrollo – hay debate no hay programa de investigación asentado… Debate formal – modelos estructurales y aportaciones más recientes.» | Última viñeta de la contextualización histórica: no hay programa asentado; modelos estructurales (de la teoría a los datos) frente a experimentos (de los datos a la teoría), con `\vertema{3.A.1}`. Se retoma en la conclusión (parte 2) |
| P2-P4 (amarillo, III.3) | «No hay problema en principio…», «¿no existe algún sesgo de selección?… cuando eliges tu muestra… 100 colegios», «el país y los colegios los eliges por conveniencia… en la capital… voluntad de participar» | III.4.2, «Validez interna y externa»: el azar elimina el sesgo entre tratados y controles (interna); la elección de la muestra y del sitio afecta a la externa, con el ejemplo de los 100 colegios de Kenia y Allcott (2015). Los puntos 2 y 4 de las limitaciones del original se funden ahí |
| P5 (notas al opositor del cambio de temario y captura del título) | — | Desaparecen |
| P6 (nota al opositor) | «Mínimo 15 minutos al apartado de economía del desarrollo desde los 90.» | III con `\minutos{15,5}` y reescrita como consejo en la nota del reparto |
| P7 (nota al opositor, II.3.3) | Coordinar con el 3.B.9 y el 3.B.19 | Desaparece; queda `\vertema{3.B.9}` en la CEPAL y la IOE. La mención del 3.B.19 no tenía relación y se quita |
| P8 (comentarios, «influencia de las ideas… en el crecimiento endógeno») | 3 comentarios sin texto | El bloque pasa a III.1 (DK2; parte 2). En II.2 queda la nota 5 del original reescrita, que anuncia esa incorporación (`\ref{sec:formal}`) |
| P9 (4 comentarios de II.4) | Revitalización neoclásica, Consenso, crisis y *market-friendly*, aportación macro | Los 4 cubiertos en II.4, en orden |
| P10 (comentario «Aquí faltarían cosas…» y II.5 copiado) | — | II.4 y II.5 fundidos en un II.4 cronológico (60-70 → 70 → 80 → 1989 → 90) con los 2 títulos (DK1) |
| P11 (coordinar con el 3.A.45; 3 comentarios) | Concepto de instituciones, evidencia, falta de consenso | III.3: qué son y por qué importan; AJR en una frase con `\vertema{3.A.45}` (D125); «no hay consenso», con Rodrik y China |
| P12 (coordinar con el 3.A.1) | — | III.4.2 cuenta la técnica sin depender del 4.B.6; `\vertema{3.A.1}` en III.2 y `\vertema{4.B.6}` en III.4 y el anexo C |
| P13, P15 (comentarios privados) | Notas sobre la copia | No se publican |
| P14 (3 comentarios de la conclusión) | Separación y convergencia entre desarrollo y crecimiento; las 3 aportaciones; anticipación | Recapitulación de la conclusión, viñetas 2 y 3 |
| P16 (comentario: Myrdal ¿externo?) | — | Se queda en los factores internos (donde actúa el mecanismo) y una frase dice que vale entre países y hace de puente con los externos (DK8) |
| P17 (comentario: Kaldor sin fórmulas) | — | Cuerpo de palabra; ecuaciones de Dixon y Thirlwall en el anexo B (parte 2) |
| P18 (caja de anotaciones, *The Economist*) | Enlace de 2019 | Se conserva en `anotaciones` al final de la valoración de III.4, con `Economist2019Nobel` (el servidor da 403 a los robots; el artículo existe) |
| P19 (notas 20, 25 y frases sueltas) | Nota 20 vacía; nota 25 «paradoja de Lucas»; «no consolidado. Determinación consumo…» | Nota 20 quitada; la paradoja de Lucas (1990), nota de III.1; las frases sueltas, sustituidas por el debate estructural frente a experimental en la recapitulación |
| Notas 23 y 24 | *Ex ante* y *ex post*; cita en inglés de *The Economist* | La 23, en «diseño antes que evaluación»; la 24, quitada (la idea va en la validez externa) |
| Nota 26 | Ahorro de China, 52 % en 2008 | Nota de la opinión: 51 % (2008) y 42,9 % (2024) (FMI; V16) |
| Comentario inicial («Aquí está copiado todo el tema de…») | — | No se publica; todo redactado de nuevo |

## 4. Datos actualizados

| Dato | Anterior | Nuevo | Fuente | URL | Consulta | Segunda comprobación |
|---|---|---|---|---|---|---|
| Pobreza extrema mundial | 8,4 % (2,15 $, PPA 2017) | 10,1 %, 824 millones (2024; 3,00 $, PPA 2021) | Banco Mundial, PIP | https://pip.worldbank.org | 3/11/2026 | Blog del Banco Mundial del 22/9/2026 y WDI (V1) |
| Pobreza extrema en 1990 | 35 % | 43,4 % | PIP | ídem | 3/11/2026 | WDI (V2) |
| Regiones | — | Asia oriental 67 → 2 %; Asia meridional 50 → 3 %; África subsahariana 62 → 45 % (321 → 581 millones) | PIP | ídem | 3/11/2026 | WDI (V3) |
| China | 66 % → 2 %; 2/3 de la caída | 83 % → 0 desde 2019; 64 % de la caída | PIP | ídem | 3/11/2026 | WDI (V4, V6) |
| Pobres en África | la mitad | 70 % | PIP | ídem | 3/11/2026 | Suma de regiones (V5) |
| Líneas de 4,20 y 8,30 $ | — | 18 % y 46 % | PIP | ídem | 3/11/2026 | WDI para 4,20 $ (V13) |
| PIB por habitante de los emergentes | ×2 (1995-2019) | ×2,6 (1995-2024); avanzadas ×1,5 | FMI, WEO oct. 2026 | https://api.imf.org/external/sdmx/3.0/data/dataflow/IMF.RES/WEO/+/G200.NGDPRPPPPC.A | 3/11/2026 | WDI (V7) |
| IDH | 2021: Suiza 0,962, Sudán del Sur 0,385, España 27.ª (0,905) | 2023: Islandia 0,972, Sudán del Sur 0,388, España 28.ª (0,918), China 78.ª (0,797), Kenia 143.ª (0,628) | PNUD, HDR 2025 | https://hdr.undp.org | 3/11/2026 | Anexo estadístico y Eustat (V8, V9) |
| Clasificación por renta | — | ≤ 1.175 / 4.635 / 14.375 $ (julio de 2026) | Banco Mundial, FY27 | https://documents1.worldbank.org/curated/en/099063026190549947/pdf/BOSIB-8ff63426-3c40-412d-bad2-cc20a4ebea81.pdf | 3/11/2026 | API de países (V14) |
| Tabla de rasgos (`tab:hechos`) y población en países de renta baja y media (82,7 %) | — | Datos del WDI de 2024-2025 (empleo agrario, fecundidad, población, esperanza de vida, crédito, ahorro) y de Kenia | WDI (8/10/2026) | https://api.worldbank.org/v2/country/KEN;LIC;LMC;HIC/indicator/SL.AGR.EMPL.ZS?format=json&mrnev=1 (y los demás indicadores con la misma consulta) | 3/11/2026 | Segunda consulta a la API por el editor (coinciden las cifras de contenido); falta otra fuente (OIT, ONU): B28-12 |
| India / EE. UU. | sin cifra | 6,5 % (1950) → 5 % (1980) | Maddison 2023 | https://doi.org/10.34894/INZBF2 | 3/11/2026 | PWT 11.0 (V15) |
| Kuznets en corte transversal | — | 150 países, ajuste cuadrático con R² = 0,10 | WDI | https://api.worldbank.org/v2/country/all/indicator/SI.POV.GINI | 3/11/2026 | PIP (V59) |
| Ahorro de China (nota 26) | 52 % (2008) | 51 % (2008) y 42,9 % (2024) | FMI, WEO oct. 2026 | https://api.imf.org/external/sdmx/3.0/data/dataflow/IMF.RES/WEO/+/CHN.NGSD_NGDP.A | 3/11/2026 | WDI (V16) |
| Vacunas con lentejas | 18 % → 75 % (mezclado) | 6 → 18 → 39 % | Banerjee et al. (2010), *BMJ* | https://pubmed.ncbi.nlm.nih.gov/20478960/ | 3/11/2026 | J-PAL (V47) |
| Desparasitación con tasa | — | participación ≈ −80 % | Kremer y Miguel (2007) | https://www.nber.org/papers/w10324 | 3/11/2026 | J-PAL (V47) |
| Comidas en preescolares | «desayunos… sin mejora» | +31 % de asistencia | Vermeersch y Kremer (2005) | https://documents.worldbank.org/en/publication/documents-reports/documentdetail/343781468273045337 | 3/11/2026 | J-PAL (V48) |
| J-PAL | — | más de 2.700 evaluaciones en más de 140 países | J-PAL | https://www.povertyactionlab.org/about-us | 3/11/2026 | Sin segunda fuente: «más de» (V18) |
| Trampa de la renta media | — | 34 economías a renta alta desde 1990; 108 en renta media con unos 6.000 millones de personas | Banco Mundial, WDR 2024 | https://www.worldbank.org/wdr2024 | 3/11/2026 | Pendiente (B28-18) |
| Multiplicador de GiveDirectly | — | ≈ 2,5 | Egger et al. (2022) | https://doi.org/10.3982/ECTA17945 | 3/11/2026 | Propuesta de contenido (versión publicada) |

## 5. Contenido añadido

- **Introducción**: enganche con refrán, Kenia frente a España y la prima de ciudadanía (Milanović, 2016); Nobel completos (Sen, Deaton, 2019 con su motivación, 2024); crecimiento frente a desarrollo con las capacidades de Sen y un ejemplo con datos; 3 etapas de la disciplina; P1.
- **I.1**: RNB y PPA (65 frente a 26 veces), clasificación de julio de 2026, pobreza absoluta y relativa, líneas de 3,00, 4,20 y 8,30 $, gráfico de la pobreza por regiones, IDH con su base en Sen y su agregación geométrica, gráfico del IDH por grupos y regiones, IPM.
- **I.2**: tabla de rasgos con Kenia; informalidad (OIT); enfermedad holandesa (Corden y Neary, 1982; cumple la remisión del 1D01); **curva de Kuznets** con el gráfico de datos que muestra que no se cumple en corte transversal (cumple la remisión del 3.A.45), Deininger y Squire, Piketty y la curva del elefante (Lakner y Milanović, 2016); tendencias (convergencia, trampa de la renta media).
- **II**: Lewis con a)-e) completos (tema de referencia: Ranis y Fei, Harris y Todaro con su ecuación, evidencia de China y España); Rostow con la **brecha de financiación** y su fracaso (Easterly), Gerschenkron; Myrdal y Kaldor con a)-c); la trampa de pobreza con el gráfico del 3.A.43, la trampa demográfica de Nelson, el gran empujón de Rosenstein-Rodan, Murphy-Shleifer-Vishny (álgebra en el anexo B) e Hirschman, evidencia (Kraay y McKenzie; Campante et al.); CEPAL resumida con la RRI, la ISI, Thirlwall, la dependencia, Krueger y Chang; IOE; II.4 cronológico con la OIT (1976), la crisis de la deuda, el Consenso, sus críticas, *market-friendly* (1991), Burki y Perry, el Consenso de Santiago y lo que queda.

- **III** (parte 2): crecimiento endógeno ($AK$, `\vertema{3.A.44}`) y paradoja de Lucas; fallo de coordinación de Murphy, Shleifer y Vishny (vuelta al gráfico de la trampa); anillo O de Kremer (1993) con un ejemplo numérico propio ($0{,}95^{10}=0{,}60$; $0{,}90^{10}=0{,}35$); distancia a la frontera y trampa de la renta media (WDR 2024, las 3 «íes»); aspiraciones (Ray; Genicot y Ray), desesperanza (Duflo), escasez (Mani et al., 2013), trampas de los hogares (Balboni et al., 2022, frente a Kraay y McKenzie); instituciones inclusivas y extractivas, AJR en una frase, conflicto social, Botsuana (AJR, 2003), Rodrik y China, diagnóstico del crecimiento y autodescubrimiento; microcréditos con responsabilidad conjunta (Grameen; Ghatak; Stiglitz; Giné y Karlan), seguros, M-Pesa (Suri y Jack, 2016); el método (Rubin, ATE, sesgo de selección, validez interna y externa, Allcott, intención de tratar, cuasiexperimentos); la evidencia por áreas; la valoración (Deaton, Heckman y Smith, Ravallion, Rodrik, Levitt y List, ética); 6 lecciones de política, Agenda 2030 y clima.
- **Conclusión** con los 5 bloques; **anexos** A (IDH paso a paso), B (Kaldor-Verdoorn y Dixon-Thirlwall, correa de transmisión, industria naciente, ISI frente a IOE, los 10 puntos, MSV con su gráfico), C (demostración del sesgo de selección con `\findemo`, intención de tratar, cuasiexperimentos), D (tabla de 15 experimentos), E (test).

### Propuestas de contenido (C) — parte 1

| Propuesta | Estado |
|---|---|
| C1 (estructura y reparto) | Aplicada con la estructura y los minutos de la fase de coherencia (K1, K2), que mandan: no se crea el I.3 de contenido; sus tendencias van al final de I.2 |
| C2, C3 | Aplicadas |
| C4 (enganche «Obras son amores…» y Nobel 2019) | **No** como enganche (manda la coherencia: «Unos nacen con estrella…»); el refrán pasa a pegatina de III.5 (parte 2); el par Guinea Ecuatorial-Sri Lanka y el gráfico de la pobreza, aplicados (el gráfico en I.1, no en el enganche, K3) |
| C5 (relevancia) | Aplicada en parte: Nobel y el 80 % (comprobado: 82,7 %); el ODS 1 queda para III.5 (parte 2) |
| C6, C7 | Aplicadas, fundidas con K3 |
| C8 (título «Economía de los países en desarrollo» para el I) | **Rechazado el título**: se mantiene «¿Qué es el desarrollo?» del original (CRITERIOS §2; K1). Contenido aplicado |
| C9 | Aplicada (tabla con una columna de Kenia y el crédito, sin la renta media-alta) |
| C10 (I.3 nuevo) | Contenido aplicado dentro de I.2 (Kuznets, elefante, convergencia); no hay I.3 (estructura de coherencia) |
| C11 | Aplicada (II.1 y II.2 separados, como el original y K1) |
| C12 | Aplicada salvo la «prima del 30 %» de Lewis (no comprobada en el artículo: se quita la cifra) |
| C13 | Aplicada; implicación con la brecha de financiación (K7) |
| C14 | Aplicada; la nota 9 (Young) se conserva |
| C15 | Cuerpo aplicado; anexo B en la parte 2. La cifra de 0,5 de Verdoorn no se usa (no comprobada) |
| C16 | Aplicada; el gráfico del gran empujón va al anexo B (decisión del coordinador); el gráfico de la trampa es la copia del 3.A.43, aquí en II.3.2 y no en III.1 (K8, K9) |
| C17 | Aplicada: la captura se quita; su contenido, en d) Evidencia de la trampa |
| C18 | Parte 2 (III.1) |
| C19 | Aplicada (Thirlwall en nota; nota de la ISI monetaria con Irwin, 2021; Kenia) |
| C20 | Aplicada; la tabla de los 10 puntos va al anexo B (parte 2); Rodrik en una viñeta con remisión a III.3 |
| C21 | Aplicada |
| C22 | Aplicada con el título de III del original (sin el `\newline`) |
| C23 | Aplicada en parte: la brecha de financiación ya está en II (Rostow); la paradoja de Lucas, nota de III.1; el diagnóstico y el autodescubrimiento, en III.3 (decisión del coordinador). **Sin** gráfico `diagnostico` (el coordinador no lo pide) ni los ejemplos de Brasil y El Salvador (no comprobados). La pegatina «la cadena se rompe por el eslabón más débil» no se usa: es del 3.A.23 |
| C24 | Aplicada: la trampa macro no se repite (está en II.3.2; III.1 vuelve al gráfico), el anillo O con $m$ tareas y $\overline V$ (letras locales para no chocar con $n$ e $y$ del canon), las trampas de los hogares en III.2 (coordinador). **Sin** `\funcionclave` de la trampa (la única función clave es el sesgo de selección) y **sin** gráfico `trampa-hogares` (no lo pide el coordinador); Sachs (2005), en la bibliografía pero no citado |
| C25 | Aplicada; los «6.000 millones» del WDR 2024 sin segunda fuente (B28-18) |
| C26 | Aplicada, más las trampas de los hogares |
| C27 | Aplicada **sin las 2 Coreas** (reservadas al 3.A.45), sin las 4 visiones desarrolladas ni Benhabib-Rustichini ni la democracia (están en el 3.A.45); con Botsuana (K14) |
| C28 | Aplicada, más M-Pesa |
| C29 | Aplicada; la demostración, en el anexo C (`anexo:evaluacion`); sin la pegatina «cada casa es un mundo» (se usa «del dicho al hecho…») |
| C30 | Aplicada con los datos del verificador: −80 % (no 75 % → 19 %), sin cifras de Hamory (solo «más consumo y salario»), sin los 0,7 años de Progresa (no comprobados); sin la pegatina «a caballo regalado…» |
| C31 | Aplicada; el balance de China pasa a la opinión de la conclusión con la nota 26 |
| C32 | Aplicada con 6 lecciones reordenadas (K16) y la pegatina «Obras son amores, que no buenas razones»; sin la Ley 27/2022 (va en el 4.B.6) |
| C33 | Aplicada salvo la idea final, que retoma el refrán del enganche de la coherencia («unos nacen con estrella…»), no «obras son amores» |
| C34-C36 | Aplicadas con el orden A IDH, B clásicas (con MSV dentro, no en un anexo aparte), C evaluación, D experimentos, E test |
| C37-C39 | Aplicadas (C39: solo los gráficos que pide el coordinador) |

### Propuestas de datos (V) — parte 1

Todas aplicadas. V18 con «más de» (una sola fuente); V40 con Wolfensohn (1998), como pidió el coordinador; V42 (Hayek): la cita no se pone (está en el 3.A.45); V52 con Cohen y Easterly (2009); V53-V54 con Allcott, Deaton y Cartwright y Levitt y List; V55 OMGI; V56 Lucas (1990); V57 Stiglitz y Weiss.

### Propuestas de coherencia (K) — parte 1

K1-K19 aplicadas, salvo la pegatina «cada maestrillo tiene su librillo» (B28-05) y la frase de Joan Robinson de K17 (B28-15). En K15, las trampas de los hogares van en III.2 (coordinador).

### Pendientes (P) — parte 1

Todos resueltos. P26: la curva en S de los hogares se cuenta de palabra en III.2 (sin gráfico); P36: el mapa se sustituye por el gráfico de barras del IDH (I.1) y el anexo A; P49 (fichas `big-push` y `rostow`) es de la fase canon.

## 6. Coherencia

- Remisiones de la parte 1: 3.A.1, 3.A.22, 3.A.24, 3.A.43, 3.A.45, 3.B.6, 3.B.8, 3.B.9, 3.B.29, 3.B.31 y 4.A.27, todas con `\vertema`.
- Se cumplen las remisiones que otros temas hacen al 3.B.28: 3.A.43 (trampas y su papel en la política, con el mismo gráfico, copiado con sus capas), 3.A.45 (Kuznets y la distribución personal; mismas cifras de pobreza y la misma clave `BM2026PIP`), 4.A.27 (Lewis con el año), 1D01 (enfermedad holandesa, con `CordenNeary1982`).
- Mismas palabras que los temas revisados: Solow (1957) y Abramovitz como el 3.A.45; la trampa como el 3.A.43 (Azariadis y Drazen; «gran empujón»); la brecha de financiación con la $v$ del 3.A.43 y Easterly (2003, cap. 2).
- No se repite nada del 3.A.45 (Nogales, Coreas, Corea-Nigeria, AJR, las 4 visiones, Hayek).
- Contradicciones con otros temas (para cuando se revisen; no se tocan): las de la fase de coherencia (§ 9 de `propuestas-coherencia.md`), en particular el 3.B.9 (mismo texto de la CEPAL y la IOE, con «IOE: subvenciones a la exportación»), el 4.A.27 (Lewis remite al 3.B.29), el 3.B.42 («trampas de pobreza multidimensional (Nurkse)») y el 3.A.45 («gran impulso» en lugar de «gran empujón»).
- Claves de bibliografía: las de los temas revisados donde coinciden (`AcemogluJohnsonRobinson2001Colonial`, `MurphyShleiferVishny1989Industrialization`, `RosensteinRodan1943Problems`, `KraayMcKenzie2014Do`, `Campante2021`, `HallJones1999Why`, `Rodrik2008Second`, `StiglitzWeiss1981Credit`, `Young1928Increasing`, `GillKharas2007East`, `NobelPrize2024`, `NobelPrize1993North`, `GGDC2025PWT`, `BoltvanZanden2025`…); **`Kremer1993ORing`** para el anillo O, distinta de la `Kremer1993` del 3.A.44.
- Parte 2: se cumplen las remisiones del 3.A.13 (microcréditos con responsabilidad conjunta, con sus claves `Ghatak1999Group` y `Stiglitz1990Peer`), del 3.A.22 (Rodrik, 2008, con `\vertema{3.A.22}`), del 3.A.44 (AK, distancia a la frontera y trampa de la renta media, con sus claves), del 3.A.45 (AJR en una frase, 0,94 frente a 0,52, nivel y no crecimiento) y del 3.B.31 (países pobres y cálidos; responsabilidades comunes pero diferenciadas). Nuevas remisiones: 3.A.1, 3.A.13, 3.B.29, 3.B.30, 3.B.42, 4.A.26, 4.B.6.
- El 3.B.28 queda como tema de referencia de la técnica experimental en el 3.er ejercicio (DK7): el 4.B.6, cuando se revise, debería usar la misma descomposición `eq:sesgo-seleccion` y la notación $Y_i(1)$, $Y_i(0)$, $D_i$.
- `canon/pendientes-coherencia.md`: no se ha tocado; lo hace el coordinador o la fase canon (fichas `big-push`, `rostow`, `kuznets`, `consenso-washington` y `rct` rehecha).

## 7. Dudas abiertas

Todas aplicadas con la opción recomendada; para que Víctor las confirme.

- **B28-01** (DK1) II.4 y II.5 del original fundidos en un II.4 cronológico con los 2 títulos. Alternativa: mantenerlos separados.
- **B28-02** (DK2, DK3) III.1 nuevo (teoría formal) y III.5 nuevo (políticas). Parte 2.
- **B28-03** (DK4) Minutos: I 3′30″, II 7′30″, III 15′30″.
- **B28-04** (DK5, DK6) Enganche «Unos nacen con estrella y otros estrellados» y Kenia como ejemplo conductor. Alternativa: «Obras son amores, que no buenas razones» (contenido), que pasa a pegatina de III.5.
- **B28-05** Pegatina de II.4: **«café para todos»** (la misma receta para todos los países) en lugar de «cada maestrillo tiene su librillo», que se queda el 3.A.5 como enganche (indicación del coordinador). Comprobado con `grep` en `fuentes/*/*.tex`: no la usa ningún tema. Alternativa: sin pegatina en II.4.
- **B28-06** Título del I: el del original, «¿Qué es el desarrollo?» (K1), no el de la propuesta de contenido («Economía de los países en desarrollo»).
- **B28-07** Sin I.3 «Tendencias» (C10): las tendencias van en el último párrafo de I.2 y la pobreza en I.1, para respetar los 2 subapartados del original.
- **B28-08** Gráfico de Kuznets con datos (V59, opción a: prueba de que la U no se cumple en corte transversal) y barras del IDH por grupos y regiones en lugar del mapa (opción a). En la pizarra, solo la U a mano alzada.
- **B28-09** Solo la línea de pobreza de 3,00 $ de PPA de 2021 (opción a), como el 3.A.45.
- **B28-10** Milanović (2016) sin cifra: la fase de coherencia proponía «más de la mitad de las diferencias de renta» con otra clave (`Milanovic2015Global`) sin comprobar. Se dice «la mayor parte» y «prima de ciudadanía», sin comillas.
- **B28-11** Cifras con una sola fuente (no hay otra a mano): IPM, 1.100 millones (PNUD y OPHI, 2025); informalidad, 58 % del empleo mundial (OIT, 2023); punto de Lewis de China hacia 2010 (Zhang, Yang y Wang, 2011, *China Economic Review*; entrada de la bibliografía sin DOI, comprobar).
- **B28-12** Tabla de rasgos: solo WDI (consultado 2 veces por la API, coincide); falta una segunda fuente independiente (OIT para el empleo agrario, ONU, *World Population Prospects 2024*, para la demografía). Los impuestos de los países de renta baja son de 2016 (último agregado).
- **B28-13** Frases sin cita concreta (hechos históricos generales): la ISI de Kenia tras 1963 y su ajuste estructural en los 80. Si Víctor quiere, se quita o se busca una fuente.
- **B28-14** Teoría de la dependencia: Frank (1967) y Cardoso y Faletto (1969) añadidos a la bibliografía (libros, sin DOI).
- **B28-15** La frase de Joan Robinson (DK12) **no** se ha puesto en la opinión de la conclusión: se pregunta a Víctor.
- **B28-16** (DK7) El 3.B.28 como tema de referencia de los RCT en el 3.er ejercicio: la técnica (resultados potenciales, sesgo de selección, validez interna y externa) se cuenta entera aquí, con la demostración en el anexo C; el 4.B.6 desarrollaría los cuasiexperimentos.
- **B28-17** Una sola función clave, la descomposición del sesgo de selección; la ecuación de la trampa (propuesta de contenido) no se recuadra porque ya está en el 3.A.43 y aquí se cuenta con el gráfico.
- **B28-18** Trampa de la renta media: «108 países con unos 6.000 millones de personas» (WDR 2024) sin segunda comprobación; si no cuadra, «tres cuartas partes de la población mundial».
- **B28-19** Datos de III con una sola fuente o de la fase de contenido: multiplicador de GiveDirectly ≈ 2,5 (Egger et al., 2022), 111 evaluaciones de Allcott (2015), M-Pesa y 194.000 hogares (Suri y Jack, 2016, entrada nueva), absentismo de los maestros a la mitad (Duflo, Hanna y Ryan, 2012), 61.000 escuelas de Indonesia (Duflo, 2001). Botsuana como uno de los países que más han crecido desde 1966 (AJR, 2003, entrada nueva sin DOI).
- **B28-20** Las trampas de los hogares van en III.2 (enfoque cultural y del comportamiento), como pidió el coordinador, y no en III.1 o III.4. Sin gráfico `trampa-hogares`.
- **B28-21** Pegatinas de la propuesta de contenido no usadas: «a caballo regalado no le mires el diente», «cada casa es un mundo», «la cadena se rompe por el eslabón más débil» (esta última es del 3.A.23). Las 7 que quedan, en la nota del reparto.
- **B28-22** Sin la crítica de las «guerras de los gusanos» al estudio de la desparasitación (reanálisis de 2015): se puede añadir en una nota si Víctor quiere.
- **B28-23** (control de calidad, 3/11/2026) En el Word, las llaves de `\underbrace` de la función clave `eq:sesgo-seleccion` y de la demostración del anexo C salen como un signo diminuto bajo la etiqueta, sin abarcar el término (conversión de pandoc a OMML; pasa igual en los demás temas con `\underbrace`). No es del tema sino de la conversión: el PDF y el HTML están bien. Si molesta, se cambia en el conversor para todos.
- **B28-24** (control de calidad, 3/11/2026) Sobre B28-18: el WDR 2024 dice, en efecto, 108 países de renta media con unos 6.000 millones de personas (el 75 % de la población mundial); la cifra del tema es la del informe, falta solo la segunda fuente independiente.

## 8. Instrucciones para el vídeo

- **Enganche e idea final**: «Unos nacen con estrella y otros estrellados»; Kenia frente a España (20 años de vida y 8 veces la renta). La idea final (parte 2) responde que la estrella no es un destino.
- **Introducción y conclusión, sin pizarra** (`modo: guion`).
- **Pizarra del I**: columna izquierda con «renta · pobreza · IDH · IPM» y las 3 cifras de la pobreza (43 % → 10 %, 7 de cada 10 en África); a la derecha, la U invertida de Kuznets a mano alzada (2 ejes, IG y $Y/L$, y una curva) con una cruz: «los datos no la confirman». Los gráficos de datos `pobreza-regiones`, `idh-regiones` y `kuznets` van como **apoyo**, nunca a mano.
- **Pizarra del II**: arriba, la línea de tiempo (50, 60, 70, 80, 1989, 90) que se queda todo el bloque. Centro: `lewis` **imprescindible, por capas** (ejes; salario de subsistencia y oferta horizontal; tramo creciente y punto de Lewis; $D(K_1)$ con el beneficio; $D(K_2)$; $D(K_3)$ y la flecha de la reinversión), narrando el mecanismo mientras se dibuja. Rostow: las 5 etapas en una columna y la brecha $I/Y=v\,\bar\gamma_Y$; la escalera `rostow` como apoyo. Myrdal y Kaldor, de palabra. `trampa-pobreza` **imprescindible**, por capas, terminando con la flecha dorada del gran empujón; se deja en una esquina porque se vuelve a él en III.1. La trampa demográfica y el gran empujón de Murphy, Shleifer y Vishny, solo como apoyo si sobra tiempo. CEPAL: «RRI = $p_X/p_M$ ↓» con una flecha. II.4: sobre la línea de tiempo, «OIT 1976», «deuda 1982», «Consenso 1989» y 4 palabras (estabilidad, precios, apertura, privatizar).
- **Pegatinas** en una esquina, al decirlas: «una golondrina no hace verano» (gran empujón) y «café para todos» (Consenso de Washington); en la parte 2, «el hábito no hace al monje», «ver para creer», «del dicho al hecho hay mucho trecho» y «obras son amores, que no buenas razones».
- **Ejemplo conductor**: «Volvamos a Kenia…» en I.1 (renta media-baja, IDH 0,628, frente a Nigeria), I.2 (46 % del empleo en el campo, Gini 38,5), II.3 (lejos del punto de Lewis; ISI tras 1963) y II.4 (ajuste de los 80). Sin decir nunca «hilo».
- **Pizarra del III**: al pasar del II al III se borra todo salvo la trampa de pobreza (esquina). III.1: se vuelve a la trampa para el fallo de coordinación; a la derecha, $\gamma_{Y/L}=sA-(n+\delta)$, el producto $\overline V\prod q_i$ con «$0{,}95^{10}\approx 0{,}60$ / $0{,}90^{10}\approx 0{,}35$» y «lejos: imitar / cerca: innovar». III.2 y III.3, casi sin pizarra: «brecha de aspiraciones», la cadena «mortalidad de los colonos → instituciones → renta» en una línea y el árbol del diagnóstico en 3 palabras (rendimiento · apropiabilidad · financiación). III.4: se borra la trampa y se escribe, recuadrada a la izquierda, la **función clave** `eq:sesgo-seleccion`, término a término mientras se explica; a la derecha, 4 o 5 ejemplos en una palabra con su cifra (gusanos −80 %, lentejas 6→18→39 %, comidas +31 %, GiveDirectly ×2,5). III.5: las 6 lecciones numeradas a la derecha, con la función clave aún a la vista. La tabla de experimentos y la demostración del anexo C, como **apoyo**.
- **Funciones clave**: solo `eq:sesgo-seleccion`, desde III.4 hasta el final (`conservar:`).
- **Idea final**: «volvamos al refrán»: la estrella de nacimiento puede pesar cada vez menos (Botsuana, China, Corea del Sur). Nunca se dice el número de un tema en voz alta.

## Control de calidad (3/11/2026): correcciones aplicadas

- Anexo D, fila de los fertilizantes: «Tanto uso como con subvenciones mucho mayores: sesgo al presente» (antes «Más uso que…»).
- Anexo B, gráfico del gran empujón: se explican las rectas de costes $q=w\,L_j$ (pendiente $w$, beneficio nulo sobre ellas) y los 3 casos: $w_1$ (la empresa se moderniza sola), $w_2$ (entre $A$ y $B$: hace falta el gran empujón) y $w_3$ (ni siquiera todas juntas).
- Nota de Harris y Todaro: «el salario esperado y no el salario seguro».
- Rostow, valoración: las 2 citas de Easterly en un solo `\parencites`.
- `tab:hechos`: «RNB por habitante, PPA (dólares internacionales corrientes, 2025)».
- III.4.3: el Nobel de 2019 sin repetir su motivación entre comillas (ya está en la introducción).
- `3B28.bib`: Banerjee siempre «Abhijit V.», Sen y Karlan con una sola forma, y los DOI de Zhang, Yang y Wang (2011), Ghatak (1999) y Stiglitz (1990). Lo aplica también `scratchpad/b28/hacer_bib.py`, así que se mantiene si se vuelve a generar el fichero.
- § 1: el tema tiene 30 págs.; § 4: URL completas (WEO del FMI, WDI y el documento del Banco Mundial de Vermeersch y Kremer; todas responden 200).
- El coordinador cambió la etiqueta del gráfico de Lewis a «salario institucional» (`graficos/`, no tocado aquí).
