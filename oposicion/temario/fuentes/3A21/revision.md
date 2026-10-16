# Revisión del tema 3.A.21 — La teoría del equilibrio general.

Fecha: 14/10/2026. Integración en dos partes: la parte 1 escribió el preámbulo, la introducción y los bloques I y II; la parte 2, el bloque III, la conclusión, los anexos A-F y la bibliografía.

Fuentes de la integración: `_trabajo/original.md`, `pendientes.md` (P1-P72), `propuestas-contenido.md` (C1-C38), `propuestas-datos.md` (V1-V33, B1-B6, L1-L13) con `bib-datos.bib`, y `propuestas-coherencia.md` (K1-K19, estructura final y notación). Criterio ante discrepancias: la estructura y la notación las decide coherencia; la teoría, contenido.

## Resumen

- Nueva fuente LaTeX `3A21.tex` (41 páginas en la compilación de prueba): introducción en 5 bloques con el enganche de Bastiat; I (supuestos, empresas, consumidores, exceso de demanda, ley de Walras y EGC en la caja de intercambio); II (existencia, unicidad, estabilidad y normativo resumido); III (Edgeworth, núcleo con comportamiento estratégico y no convexidades, dinero, incertidumbre y mercados incompletos, modelos computables con datos de 2026); conclusión con sus 5 bloques, y los títulos de primer y segundo nivel del original.
- Corregidos más de 40 errores de teoría, fechas y atribuciones (convexidad y rendimientos, núcleo en la caja de la producción, ley de Walras sin fórmula, prueba de existencia, unicidad, SMD, supuestos del 1TFEB, Scarf y Debreu, Patinkin, Arrow-Debreu); resueltas las 5 marcas amarillas del dinero y la incertidumbre.
- Lo que no se canta va a 6 anexos: A modelo general y dos etapas; B existencia y unicidad; C Pareto y teoremas; D estabilidad en un mercado; E estática comparativa (Stolper-Samuelson y Rybczynski); F aspectos para el test, preguntas probables y enlace al simulador.
- `3A21.bib` con 129 entradas sin duplicados; 13 gráficos TikZ pedidos en `_trabajo/graficos-pedidos.json` (7 en la parte 1 y 6 en la 2), ninguno 3D.
- Construido con `construir-tema.py` (PDF de 41 páginas con los 13 gráficos, HTML y Word): sin errores, sin referencias sin definir y sin cajas desbordadas; `verificar-tema.py` sin errores.

## Errores corregidos

| Dónde | Decía | Dice ahora |
|---|---|---|
| Intro, enganche (l. 29) | Definición de Marshall entre cursivas como si fuera literal, y el mismo enganche que el 3.A.8 | Enganche de Bastiat (1845), *Sofismas*, 1.ª serie, cap. XVIII (C3) |
| Intro (l. 71, 81) | Walras «influenciado por Malthus»; modelo construido sobre «los flujos monetarios internacionales de Cournot» | Sin Malthus (sin fuente); Cournot fuera (la frase de que «el problema completo excede el análisis de su tiempo» era de memoria: quitada el 16/10/2026) (C5) |
| Intro (l. 99) | Walras, «primer autor junto a Marshall que propone una teoría del valor coherente» | Utilidad marginal de Walras, Jevons y Menger (1871-1874); demanda recíproca de Mill (C5) |
| Intro (l. 107) y II.1.1 (l. 655) | Wald (1951) / Wald (1934) | Wald (1935 y 1936); 1951 es la traducción inglesa (V10) |
| Intro (l. 109) y l. 1089 | 1TFEB «propuesto por Lerner» / teoremas «formulados por Lerner» | Condiciones marginales de Lerner (1934) y Lange (1942); demostración moderna de Arrow (1951) y Debreu (1951), por separado (V13) |
| Nota 7 | Cassel y Wicksell «de la Escuela de Estocolmo… seguirán la óptima» | Cassel (1918) simplifica el sistema; Schlesinger y Wald en Viena; von Neumann (1937) (C5). El 16/10/2026: Wicksell y Cassel, anteriores a la escuela; la escuela se distanció de Cassel; fuera «Wicksell (1898) parte del equilibrio walrasiano» (sin fuente); citas HET y Ekelund y Hébert, cap. 17 |
| I.2, nota del tanteo | Cita de Walras con «sa demanda ou offre» | Literal en francés con «sa demande ou offre» (§126, p. 127, 1.ª ed., cotejada con 2 escaneos) y traducción propia (16/10/2026) |
| Notas 8, 9 y 33 | Nobel de Arrow sin Hicks y mal traducido; notas duplicadas | Una sola nota con las motivaciones oficiales (V23, P63) |
| I.1 (l. 202) | «Libre entrada en el largo plazo» con 2 empresas | Quitado; con rendimientos constantes el beneficio es nulo (P47, K5) |
| I.1 (l. 220-226, 248-260) | Utilidad «ordinal» y con «UMg positiva pero decreciente»; producción «cardinal», derivadas cruzadas positivas, Inada | Axiomas de las preferencias y utilidad continua, creciente y estrictamente cuasicóncava (nota: la UMg decreciente no es ordinal); tecnología con conjunto convexo (P46, C8, K5) |
| I.1 / I.2.1 (l. 256, 278, 280; notas 12, 15) | Convexidad **estricta** del conjunto (rendimientos decrecientes) y a la vez rendimientos no crecientes y constantes | Conjunto de producción **convexo** (no estricto): con la inacción, rendimientos no crecientes, que incluyen los constantes; la concavidad estricta solo para que la oferta sea función, en nota (P37a, K5, C9; decisión del orquestador) |
| I.2.1 (l. 354-360) | «Núcleo» en la caja de la producción («que las empresas actúen de forma racional») | Quitado: el núcleo se define una sola vez en III.2 (P48, K6) |
| I.2.1 (l. 366, nota 25) | FPP cóncava «porque las funciones son estrictamente cóncavas»; «beneficios positivos y economías de alcance» | Nota única con la forma de la FPP según rendimientos e intensidades, como en el 3.A.11 (P49) |
| Nota 23 | La curva de contrato es isoclina «con funciones homotéticas» | Solo es de pendiente constante (la diagonal) si las intensidades factoriales coinciden (C9) |
| Nota 26 | $RMT=-(CMg_X/CMg_Y)$ | $RMT_{XY}=CMg_X/CMg_Y>0$ (D035) |
| I.2.1 (l. 314-322) | Oferta homogénea porque «la riqueza del agente depende de los beneficios» | Homogénea de grado 0 en $(p_j,\vect{w})$ porque el problema no cambia al escalar los precios (C9) |
| I.2.2 (l. 441-449) | Propiedades de la demanda copiadas de la oferta («las curvas de oferta netas no varían») | Propiedades de la demanda propias; ley de Walras *individual* distinguida de la agregada (P37b, K7) |
| I.2.2, nota 28 | Walras «trabaja con funciones de demanda empíricas» | Quitada: los *Éléments* derivan la demanda de la *rareté* (C10) |
| I.2.3 (l. 479) | Bien libre: «la oferta es mayor a la oferta» | «la oferta supera a la demanda» (P62) |
| I.2.4 (l. 501) | «relacionadas mediante la fórmula» (sin fórmula); párrafo del numerario duplicado | $\vect{p}\cdot\vect{z}(\vect{p})\equiv 0$ con demostración; un solo párrafo del numerario (P50, K8) |
| I.2.4 (l. 509-511) | Marshall-numerario-Keynes: «no se cumple la ley de Say» como consecuencia de la ley de Walras | Nota que distingue la ley de Walras (identidad) de la de Say (Lange, 1942); Keynes critica la segunda (C12) |
| II.1.1 (l. 655-663) | Wald «garantizaría la existencia solo con ecuaciones lineales»; Arrow-Debreu con preferencias estrictamente convexas «lo que implicará que la tecnología no presenta rendimientos crecientes» | Contar ecuaciones no es condición necesaria ni suficiente; Arrow y Debreu suponen preferencias y conjuntos de producción convexos (C16, K5) |
| Nota 35 | Nash, «pionero» en usar el punto fijo | Von Neumann (1937), Kakutani (1941), Nash (1950) (C16) |
| II.1.1 (l. 683, 785) | «$D\in\mathbb{R}^n$», «Brower», $\rho$ como punto fijo | $\Delta\subset\mathbb{R}^n$, Brouwer, $\vect{p}^*$ (P51) |
| II.1.1 (l. 763-769) | «Saciedad de las preferencias» para la continuidad | Condición de frontera (MWG 17.C); la saciedad contradiría la no saciedad local (P52, K10a) |
| II.1.1 (l. 808-818) | Paso algebraico incorrecto (mete $z_i$ dentro del máximo) | En el cuerpo, la intuición; la prueba correcta va al anexo B (C17) |
| II.1.2 (l. 865-911) | Unicidad «demostrada» con el ADPR agregado; valoración con curvas de Engel e igual elasticidad-renta | El ADPR agregado solo da un conjunto convexo de equilibrios; condición suficiente: preferencias homotéticas y dotaciones proporcionales (P53, C18) |
| II.1.2 (l. 921, 927, 951) | Sustitutivos brutos «mantienen curvas de Engel rectas»; «la clave es la convexidad de las preferencias»; convergencia del tanteo como resultado de unicidad | Sin requisito sobre Engel; la convexidad no implica sustitución bruta; la convergencia pasa a II.1.3 (P54, K10d-e) |
| Nota 39 | Equilibrios «localmente óptimos» | Localmente únicos (economías regulares) (P54) |
| II.1.2 (l. 957, nota 40) | SMD: «cualquier conjunto de precios puede ser el equilibrio»; la demanda «debe cumplir condiciones de monotonía para que el equilibrio exista» | Enunciado correcto (cualquier función continua, homogénea y con ley de Walras) y nota nueva (P55) |
| II.1.2 (l. 959) | «Debreu, siguiendo el programa de Edgeworth, demostró que el conjunto de equilibrios es finito» | Debreu (1970), economías regulares; índice (Dierker, 1972) (P55, V16) |
| II.1.3 (l. 993, 1003, 1011-1015) | «Exceso de oferta negativo»; el subastador «canta el precio del numerario»; ecuación discreta y continua mezcladas, $k_i\geq 0$; distancia sin fórmula | Tanteo multimercado $\dot p_k=\kappa_kz_k(\vect{p})$, $\kappa_k>0$, distancia al equilibrio escrita, Arrow-Block-Hurwicz y Scarf (P56, K12, C19) |
| II.1.3 (l. 977) | Musgrave y la estabilidad del tanteo como justificación de la estabilización macroeconómica | Quitado (es otra cosa; está en 3.A.16) (K10n, C19) |
| II.2.2 (l. 1105-1117) | Supuestos del 1TFEB copiados del equilibrio parcial de MWG («bien no numerario») y con rendimientos no crecientes | 1TFEB: no saciedad local, mercados completos, precio-aceptación y precios comunes; no necesita convexidad (P61, C21) |
| II.2.2 (l. 1153-1157) | Párrafo de la introducción del 3.A.23 («nos vamos a centrar en la intervención por eficiencia…») | Sustituido por el puente al bloque III (K10i) |
| III.1 (l. 1169) | «En el contexto walrasiano se alcanza un equilibrio único» | El precio walrasiano no depende del poder negociador; el de Edgeworth sí (P57, K10b) |
| III.1 (l. 1205) | 2TFEB explicado otra vez con la caja | Solo en II.2 (K10j) |
| III.2 (título y l. 1207-1233) | «Scarf y Debreu (1963)»; núcleo con el valor de Shapley y «transferencias de pagos»; «si las preferencias son continuas y convexas, el EG pertenece al núcleo»; «Demuestra» sin sujeto | Debreu y Scarf (1963); núcleo en asignaciones (utilidad no transferible); basta la no saciedad local; teorema del límite con réplicas y Aumann (1964) (P58, V14, C23) |
| III.2 (l. 1237-1239) | Equilibrio aproximado «siguiendo el enfoque del valor de Shapley»; Shapley-Folkman sin cita | Lema de Shapley-Folkman en Starr (1969) (V15, C25) |
| III.3 (l. 1247-1251) | Texto de Segura en amarillo con una frase cortada («y llamando …») | Redactado de nuevo: regla de Cambridge con proporción $\varphi$, ley de Walras con dinero, dicotomía inválida (P1-P3, C26) |
| III.3 (l. 1255) | «modelo de intercambio puro estudiado anteriormente» | «el modelo estudiado hasta aquí» (K10h) |
| III.3 (l. 1273-1285) | Historia de Patinkin en 4 pasos (desequilibrio) | Una línea y remisión al 3.A.4 (D111, K14d) |
| III.4 (l. 1303-1309) | El equilibrio exige consumidores «aversos al riesgo» y que «asignen probabilidades» | Basta con preferencias convexas sobre planes contingentes (P60) |
| III.4 (l. 1311-1313) | «el número de equilibrios crece exponencialmente con la magnitud de los estados»; frase sin sentido | Indeterminación real con activos nominales (continuo de dimensión $S-1$; Balasko y Cass, 1989; Geanakoplos y Mas-Colell, 1989); con mercados completos, determinado y eficiente (P4-P5, C27) |
| III.5 (l. 1329) | Scarf (1969) | Scarf (1967) y Scarf y Hansen (1973) (V4) |
| III.5 (l. 1343-1351) | NAFTA y TTIP como ejemplos vigentes; EREMS «elaborado por el Ministerio…»; perturbaciones «del coronavirus» | T-MEC, TTIP abandonado, UE-Mercosur; REMS (2008) y EREMS; Observatorio de abril de 2026 (V1-V8) |
| III.5 | DICE como EGC multisectorial | Modelo de evaluación integrada de crecimiento óptimo (V5, C28) |
| III.5 | «EGC» también para los computables | MEGC (K9) |
| Conclusión (l. 1357) | Recapitulación sin el análisis positivo ni las extensiones; «Opinión» vacía; «ese han expandido» | Recapitulación en 3 pasos, opinión e idea final que responde al enganche (K18, C29) |
| Nota 57 | Cita de De Vroey (2018) en inglés, no localizada | Paráfrasis de De Vroey (2004) (V29, C29) |
| Anexo 1 | Capturas de Martínez-Giralt | Anexo E redactado con las fórmulas de Jones (1965) (P23i, C20) |
| Nota 43 | Tabla con miniaturas y «🗴» en rojo | Tabla LaTeX comprobada (C19) en el anexo D |

## Marcas resueltas

| Marca | Texto original | Qué se hizo |
|---|---|---|
| P8 Nota al opositor (p. 1) | Aviso de cambio de temario; «no acotar al EGC» | El aviso desaparece; la recomendación se cumple en la «Estructura» y en el bloque III |
| P9 Nota al opositor con la ficha del tribunal (`image1.png`) | Propuesta de estructura | No se publica; usada como lista de control |
| P10 Nota al opositor | Tema áspero; privilegiar la intuición y 5 conceptos | Reescrita en la `notaopositor` tras el esquema (con el reparto de minutos) |
| P12 / P39 Comentario «Consejos de Ángel» | Disclaimer «nos centraremos en el EGC»; modelo estilizado | No se publica (nombre de preparador); su consejo va a la «Estructura» |
| P13 Comentario (II.1.3) | «Hay que meterle dinamismo… [Coordinar con 3.A.16]» | Estabilidad rehecha con la dinámica del tanteo multimercado; la de un mercado, al anexo D con remisión al 3.A.16 |
| P15 Caja de anotaciones (I) | Enlace a Wikipedia «Tanteo walrasiano» | Se conserva (funciona, L2) y se añade la página de HET sobre la existencia |
| P16 Caja de anotaciones (I.3, Segura) | ≈ 650 palabras casi literales de Segura | Redactada de nuevo en el cuerpo de I.3 con la caja de intercambio única; el monopolio, al recuadro de III.2 |
| P6 / P41 Texto oculto (nota 44) | Idea de conclusión con Pigou | No se publica; la cita de Pareto de la nota 44 (sin página localizable) se quita |
| P7 Rojo (nota 43) | Tabla walrasiano/marshalliano | Comprobada correcta por contenido; va al anexo D como tabla de color |
| P1-P3 Amarillo (III.3) | Texto de Segura sobre el dinero, con una frase cortada | Redactado de nuevo con fuentes verificables (Lange, 1942; Patinkin, 1965; Archibald y Lipsey, 1958; Hahn, 1965); la frase cortada se completa con la regla de Cambridge. Segura no se ha podido consultar (ver dudas) |
| P4-P5 Amarillo (III.4) | Número de equilibrios y estados; «la universalidad de mercados juega a favor de la determinación» | Reescrito como indeterminación real con mercados incompletos y determinación con mercados completos |
| P40 «[Subrayado porque no entiendo]» | Nota de trabajo | Quitada |
| P11 Nota al opositor (III.3) | «Ver Segura, págs. 282-287» | Quitada; resuelta con P1-P3 |
| P14 Comentario (III.4) | «Coordinar en temas 3.A.10 y 3.A.21» | Remisión al 3.A.10 para la elección individual; aquí, el equilibrio con mercados contingentes |
| P23i Anexo 1 | Capturas | Anexo E redactado y 2 gráficos pedidos |
| P30b | «Opinión» y «Preguntas de otros exámenes» vacías | Opinión escrita; preguntas probables del tribunal en el anexo F |
| P44 / P72 Bibliografía | Enlaces `file:///`, z-lib; temas de preparadores | Enlaces quitados; «Tema Juan Luis Cordero Tarifa» quitado (nombre de preparador); «Tema ICEX-CECO» se mantiene como lectura, como en el original (CRITERIOS §2); `3A21.bib` |
| P45 Anexo 2 | Relación de temas | Publicado corregido (16/10/2026) en 2 `notaopositor`: al final de I.3 (frontera con el 3.A.16) y al final de II.2 (reparto con 3.A.22, 3.A.23 y 3.A.24). Corregido: el 2TFEB es del 3.A.22, no del 3.A.24; numeración y títulos actuales; sin la frase del «sistema tecnocrático» del 3.A.22 |
| P71 | Enlace a quia.com | Enlace genérico al simulador, en el anexo F |
| P42-P43 Anexos 3-5 | Correo, estructura de clase, idea de Víctor | No se publican; usados para el reparto de minutos y los huecos |

## Datos actualizados

| Dato | Valor anterior | Valor nuevo | Fuente | URL | Consulta | Segunda comprobación |
|---|---|---|---|---|---|---|
| Relevancia práctica (l. 53): evaluación de acuerdos de la UE con modelos de EG | Sin cita ni dato | UE-Mercosur: PIB de la UE +77.600 M€ hasta 2040; exportaciones de la UE al Mercosur +39 % | DG Trade (2025), `CE2025MercosurAnalisis` | https://op.europa.eu/en/publication-detail/-/publication/6f1a741f-677e-11f0-bf4e-01aa75ed71a1/language-en | 14/10/2026 | Página de la Comisión e *Intereconomics* 2026/3 (V3) |
| Wald | 1934 / 1951 | 1935 y 1936 | HET, ficha de Wald | https://www.hetwebsite.net/het/profiles/wald.htm | 14/10/2026 | Crossref, doi:10.2307/1907464 (V10) |
| Nobel de Arrow y Debreu | Motivación incompleta, sin Hicks | 1972 (con Hicks) y 1983, motivaciones oficiales | nobelprize.org | https://www.nobelprize.org/prizes/economic-sciences/1972/summary/ | 14/10/2026 | https://www.nobelprize.org/prizes/economic-sciences/1983/summary/ (V23) |
| Cita de Walras (§126, p. 127) | Cita francesa con errata («sa demanda») | Paráfrasis con la página | Walras (1874), Internet Archive | https://archive.org/details/lmentsdconomiep01walrgoog | 14/10/2026 | Segundo escaneo y Google Books (V26) |
| III.5: NAFTA | Ejemplo vigente | Sustituido por el T-MEC (1/7/2020); evaluación de la USITC: +0,35 % del PIB real de EE. UU. y 176.000 empleos; en julio de 2026 EE. UU. no lo prorrogó (revisiones anuales). Kehoe (2005): los modelos *ex ante* infravaloraron el comercio | USITC (2019); USTR (2026); Kehoe (2005) | https://ustr.gov/about/policy-offices/press-office/press-releases/2026/july/ambassador-greer-issues-statement-usmca-joint-review | 14/10/2026 | DLA Piper (16/7/2026), IISD; Thompson Hine (2019) para las cifras de la USITC (V1) |
| III.5: TTIP | En curso | Negociación parada en 2016; directrices «obsoletas» (Consejo, abril de 2019); estudio CEPR: +119.000 M€ al año | Consejo, doc. 6052/19; Francois et al. (2013) | https://data.consilium.europa.eu/doc/document/ST-6052-2019-INIT/en/pdf | 14/10/2026 | Parlamento de Austria; informe final del CEPR (V2) |
| III.5: UE-Mercosur | — | Firmado el 17/1/2026; aplicación provisional desde el 1/5/2026; evaluado con GTAP dinámico | DG Trade (2025); Aguiar et al. (2025) | (V3) | 14/10/2026 | Comisión; *Intereconomics* 2026/3 |
| III.5: DICE | Sin versión | DICE-2023; Nobel de 2018 | Barrage y Nordhaus (2024); nobelprize.org | https://www.nobelprize.org/prizes/economic-sciences/2018/summary/ | 14/10/2026 | Yale; NBER WP 31112 (V5) |
| III.5: EREMS | «Elaborado por el Ministerio…» | REMS (2008) con Hacienda/Economía, U. de Valencia, F. Rafael del Pino y BBVA; EREMS, versión estimada, la usa el Observatorio | Boscá et al. (2010, 2020); FRP | https://frdelpino.es/investigacion/en_gb/macroeconomic-modelling-and-analysis-rems | 14/10/2026 | Observatorio de abril de 2026, p. 3 (V6) |
| III.5: perturbaciones | Coronavirus | 4T2025: demanda +2,6 pp; oferta −2,1 pp (capital residencial −1,3) | Boscá et al. (2026), Fedea EEE 2026/12 | https://documentos.fedea.net/pubs/eee/2026/eee2026-12.pdf | 14/10/2026 | Ficha de Fedea del 16/4/2026 (sin fuente independiente: son resultados del modelo) (V7) |
| Nota 56: Observatorio | Edición del 27/4/2023 | XV edición, 16/4/2026; firmantes BBVA Research, Fedea y F. Rafael del Pino | Fedea | https://fedea.net/ciclo-economico-y-precio-de-la-vivienda-en-espana/ | 14/10/2026 | Página del Observatorio en la FRP (V8) |
| III.5 (nota): modelos institucionales | — | QUEST (Comisión), NAWM II (BCE), FiMod y BEMOD (Banco de España) | JRC MIDAS; BCE WP 2200; Banco de España DT 0631 | https://web.jrc.ec.europa.eu/policy-model-inventory/explore/models/model-quest | 14/10/2026 | Crossref (FiMod) (V9) |
| Enlaces | Gallica (403), hurkens (503), quia, file:///, z-lib | Internet Archive para Walras; repositorio de la UAB para Martínez-Giralt; simulador; sin enlaces locales | propuestas-datos L1-L13 | — | 14/10/2026 | — |

## Contenido añadido

- Introducción: enganche de Bastiat (C3); definiciones de equilibrio parcial/general y EGC; relevancia práctica con el dato del Mercosur (V3); contextualización con Cassel, Schlesinger, Wald, von Neumann, Hicks, Samuelson, Lerner y Lange y la cronología 1959-1974 (C5); «Estructura» que estaba vacía (P30, K2, C7); esquema de pizarra y nota al opositor (K2, C2).
- I: tabla de agentes y mercados con color (P17, en I.1 en lugar de la introducción, K2.4); renta con participaciones en beneficios $\theta_{ij}$ (K5, D045/D058); ecuaciones numeradas (`eq:renta`, `eq:empresa`, `eq:rmst-precios`, `eq:rmt-precios`, `eq:consumidor`, `eq:rms-precios`, `eq:exceso`, `eq:exceso-general`, `eq:ley-walras`, `eq:egc`, `eq:egc-2x2`); lo que el equilibrio general añade a la caja de la producción del 3.A.11 (isocoste y recta de precios) (K6); exceso de demanda en forma general (C11); demostración de la ley de Walras y su relación con la ley de Say (C12, Lange 1942; Becker y Baumol 1952); caja de intercambio con curvas de oferta-demanda (C14, K15); historia del tanteo (Walker, 1987).
- II: estructura a)-e) en existencia y estabilidad (K4); símplice y aplicación del subastador con $\kappa_k$ (K11); economías regulares y teorema del índice (Debreu, 1970; Dierker, 1972); condición $\vect{p}^*\cdot\vect{z}(\vect{p})>0$; SMD con sus 4 referencias; tanteo multimercado, distancia al equilibrio, Arrow-Block-Hurwicz (1959) y Scarf (1960); procesos sin tanteo (Varian, cap. 21) y enlace con el desequilibrio (C19, K12); análisis normativo resumido (K13) con la imagen de Feldman y la crítica de Wicksell en paráfrasis.
- III: estructura a)-e) en el núcleo, el dinero y la incertidumbre; definición formal de bloqueo y núcleo, teorema del límite (Debreu y Scarf, 1963) y Aumann (1964, 1975) (C23); comportamiento estratégico con Negishi (1961), Gabszewicz y Vial (1972), Roberts y Sonnenschein (1977) y Roberts y Postlewaite (1976), y el monopolio en la caja en recuadro (C24, K14a); diseño de mecanismos y debate del cálculo socialista en un recuadro de profundización (C24, K14e); no convexidades con Starr (1969) y fallos de coordinación (C25, K14b); dinero en clave de equilibrio general: ley de Walras con dinero, dicotomía inválida, efecto saldos reales, Archibald y Lipsey, problema de Hahn y modelos monetarios modernos (C26, K14d); bienes contingentes, ec. de los precios de estado, títulos de Arrow ($n+S$ mercados), Radner, mercados incompletos, generaciones solapadas y evidencia (C27, K14c); metodología de los MEGC y ejemplos de 2026 (C28, V1-V9).
- Conclusión con los 5 bloques (K18, C29), De Vroey (2004) en paráfrasis.
- Anexos: A (modelo con $I$, $J$ y $n$ y las 2 etapas, notas 19, 20 y 27); B (prueba de la existencia corregida, con $\kappa_k$ por mercado, y unicidad por sustitutivos brutos y ADPR agregado); C (ventajas, críticas e historia del criterio de Pareto y teoremas, sin la atribución a Baumol); D (ajustes walrasiano y marshalliano con tabla de color); E (estática comparativa con el efecto magnificación de Jones); F (aspectos para el test, preguntas probables del tribunal y enlace al simulador).
- Fuentes de las figuras: ninguna cita ya a otros preparadores ni a Policonomics; «Elaboración propia a partir de» Bator (1957), Gravelle y Rees (2004), Segura (1986), MWG (1995) y Delgado Toral (2014).

### Estado de cada propuesta

- **Contenido**: C1 aplicada. C2 aplicada con la versión de coherencia (minutos 11/9/6,5 y esquema de K2). C3 aplicada (decisión del orquestador). C4 aplicada con cambios: la relevancia teórica no menciona los DSGE (van a la relevancia de la conclusión, K2.3) y se añade el dato del Mercosur (V3); la remisión a 4.B.8 se quita (no se remite al 4.º ejercicio, CRITERIOS §6). C5 aplicada salvo la frase de Cournot sobre «el cambio entre plazas» y la nota sobre Auguste Walras, que contenido daba de memoria (queda solo que Cournot ve el problema completo; ver dudas). C6 aplicada sin la pregunta de estática comparativa (va al anexo E). C7 fundida con K2.6. C8 aplicada; para la tecnología se usa el texto de K5 (conjunto convexo, no estricto); la tabla de Inada (nota 16) se quita (ver dudas). C9 aplicada con el gráfico de K6; la nota 20 (dos etapas) pasa a una línea y al anexo A (coherencia) en lugar de quitarse. C10, C11 y C12 aplicadas (C12 con la parte de Say en nota). C13 aplicada, pero la nota del tanteo va en I.1, donde aparece por primera vez (K10g), y la cita de Walras como paráfrasis con página (V26). C14 aplicada como caja única (K15); el monopolio, en III.2. C15 y C16 aplicadas (nota 34 de Arrow y Hahn quitada: sin comprobar; Gale, 1976, se mantiene porque datos la comprueba, V11). C17 aplicada en el anexo B con la notación de coherencia ($f_k$, $\kappa_k$ por mercado: la prueba de contenido se ha adaptado dividiendo por $\kappa_k$). C18 aplicada; la condición $\vect{p}^*\cdot\vect{z}(\vect{p})>0$ se cita a MWG 17.F y no a Wald (atribución no comprobada). C19 aplicada con la notación de coherencia (sin la letra $V$: distancia ponderada escrita sin nombre). **C20 rechazada en el cuerpo** (II.1.4 nuevo): por la estructura de coherencia la estática comparativa va al anexo E, con una nota en II.1.2. C21 aplicada con el texto de K13; las ventajas y críticas de Pareto, al anexo C; la remisión a 4.B.3 se quita. C33 (erratas) y C34 (notas 3, 4, 10, 11, 15, 41, 42) aplicadas. C22 aplicada (con la corrección de K10b). C23 aplicada. C24 aplicada con cambios: el monopolio va como recuadro con su gráfico propio (coherencia: gráfico 6, no una capa de la caja) y el diseño de mecanismos y el debate del cálculo, en un recuadro de profundización y una línea en la conclusión (K14e), no como apartado que se canta. C25 aplicada. C26 aplicada; la proporción de Cambridge se llama $\varphi$ y no $k$ (choca con el índice de los bienes), y la cita literal de Hahn (1982) se da como paráfrasis (solo comprobada en fuente secundaria). C27 aplicada con la notación de coherencia ($n$ bienes, $x_{ks}$, $p_{ks}$; no $L$, que es el trabajo). C28 aplicada sin la remisión a 4.B.8 y con «MEGC» (K9); la remisión de «(II.1.4)» pasa al anexo E. C29 aplicada fundida con K18 (empieza por «En conclusión,», CRITERIOS §8); Thaler se mantiene con su Nobel (V25). C30 aplicada. C31 aplicada en el anexo F, como en el 3.A.11. C32: anexo 2 no publicado. C35-C38 aplicadas (anexos A-F; la letra la pone LaTeX).
- **Datos**: V3, V10, V11, V12, V13, V16, V21, V22, V23, V26 (paráfrasis), V27 aplicadas; V1-V9 aplicadas en III.5; V14, V15, V17-V19, V24, V25 aplicadas; V28, V29 (De Vroey 2018, sustituida por la paráfrasis de De Vroey, 2004) y V30 (Baumol) quitadas por no comprobadas; V31 (Ekelund y Hébert) se cita como en el 3.A.11; V32 no procede (no se usa Marshall). B1-B4 y B6 aplicadas en `3A21.bib`; B5 (temas de preparadores) no van al `.bib`. L1 (Internet Archive en el `.bib`), L2, L3 (Policonomics fuera de las figuras), L4, L5-L6 (fuera), L8 (Liu, 2019), L9, L10, L11 y L12 aplicadas.
- **Coherencia**: K1-K9 aplicadas; K10 aplicada entera (a-n); K11-K13 aplicadas; K14 a-f aplicadas (e, como recuadro y línea en la conclusión); K15 aplicada en los pedidos de gráficos; K16 aplicada (también 3.A.10, 3.A.17, 3.A.19, 3.A.29, 3.A.31, 3.A.35, 3.B.6 y 3.B.31; no se usan 3.B.10 ni 3.B.19 porque la conclusión ya no menciona gravedad ni NOEM); K17 aplicada; K18 aplicada fundida con C29; K19 aplicada (anexos A-E y, además, F para el test, como en el 3.A.11).

## Coherencia

- **Notación del canon**: orden $(L,K)$, $F_j(L_j,K_j)$, $B_j$, consumidores $i=A,B$, $\vect{\omega}_i$, $\theta_{ij}$, $\overline{W}_i$, $RMST^X_{LK}$, $RMS^A_{XY}$ y $RMT_{XY}$ positivas y sin barras, $\vect{p}=(p_X,p_Y,w_L,w_K)$, $\vect{w}=(w_L,w_K)$, $z_k(\vect{p})$, $\Delta$, $\kappa_k$, $\vect{p}^0,\vect{p}^1$ para dos vectores de precios, vectores con flecha. Aviso en nota del doble uso de $z$ (exceso de demanda aquí, factores en el 3.A.11).
- **Siglas**: EGC = equilibrio general competitivo; nunca «EG» (es el exceso de gravamen); MEGC para los computables.
- **Símbolos locales nuevos** (para el canon): $\varphi$ proporción de Cambridge (III.3), $\overline{M}_i$, $M^D$ (canon § 5); $\mathcal{S}$ coalición (III.2, para no chocar con $S$ estados); $s_{Lj}$ y $\ell_{Lj}$ (anexo E, en lugar de los $\theta_{ij}$ y $\lambda_{ij}$ de Jones).
- **Cambios del canon aplicados (14/10/2026)**: $C(\vect{w},q)$ y $\mathrm{CMg}(\vect{w},q)$ en el anexo A (precios delante, `notacion.md` § 3); en el anexo E el numerario se quita con el subíndice $-1$ ($\vect{p}_{-1}$, $\vect{z}_{-1}$) y el circunflejo queda solo para las tasas de variación de Jones; demanda de dinero $M^D$ en III.3.
- **3.A.11**: la caja de la producción y la FPP son el mismo gráfico que `caja-edgeworth-fpp` del 3.A.11 con 2 capas propias (isocoste y recta de precios); se cumplen las 2 remisiones del 3.A.11 a este tema ($RMT_{XY}=p_X/p_Y$ y la forma de la FPP).
- **3.A.8**: remisiones para los axiomas, la ley de Walras individual y el axioma débil; la ley de Walras agregada y SMD, aquí, como pide el 3.A.8.
- **3.A.16**: la estabilidad en un mercado (ajuste walrasiano y marshalliano, tabla de la nota 43) pasa al anexo D con remisión; aquí, el tanteo multimercado.
- **3.A.22 / 3.A.23 / 3.A.24**: el normativo se resume (enunciados) y remite; la nota 17 remite ahora a 3.A.23 (antes 3.A.22).
- **Contradicciones con otros temas** (no se tocan; las recoge `propuestas-coherencia.md` §5): 3.A.22 y 3.A.23 copian el criterio de Pareto, el 1TFEB y el modelo 2×2×2×2 con supuestos de equilibrio parcial; 3.A.16 tiene la misma estabilidad copiada y una imagen con fuente «Tema 3A-21» de otro opositor; 3.A.10 repite el texto de los bienes contingentes; 3.A.25 dice que la competencia garantiza existencia, unicidad y estabilidad; 3.A.35 fecha a Patinkin en 1951; 3.A.14 define el núcleo con utilidad transferible.
- **Canon**: las propuestas de `propuestas-coherencia.md` §4.4 (matizar en la ficha `equilibrio-general-walras` la frase sobre la convexidad estricta; fichas `nucleo` y `arrow-debreu-incertidumbre`; símbolos $\Delta$, $\kappa_k$, $x_{ks}$, $p_{ks}$; siglas EGC/MEGC) quedan para `tema-canon`. Contenido propone además fijar la notación local de Jones ($s_{Lj}$, $\ell_{Lj}$) para el anexo E.

## Decisiones de Víctor (16/10/2026)

Confirmadas las opciones recomendadas; las que piden un cambio, aplicadas el 16/10/2026:

1. **Estructura y minutos**: los de coherencia: introducción 2,5; I, 11 (I.1, 2,5; I.2, 6; I.3, 2,5); II, 9 (II.1, 7; II.2, 2); III, 6,5; conclusión, 1. Se mantienen los bloques y los títulos de segundo nivel del original (el título de I, completo, en 3 líneas); lo que no se canta va a los anexos A-E. Contenido proponía 10/9/7,5 y un II.1.4 de estática comparativa. ¿Te vale o prefieres 12/8,5/6 (D1 de coherencia)? **Confirmada.**
2. **Enganche**: Bastiat (C3), porque el de Marshall no es literal y repite el del 3.A.8. Coherencia proponía el estaño de Hayek (1945), que queda libre para otro tema o para la conclusión. **Confirmada.**
3. **Discrepancias contenido/coherencia**: estructura y notación, de coherencia; teoría, de contenido. **Confirmada.**
4. **Convexidad**: conjunto de producción convexo (no estricto), con rendimientos no crecientes que incluyen los constantes; para las preferencias se mantiene la convexidad estricta (la demanda como función) con una nota que dice qué basta para cada resultado. **Confirmada.**
5. **Citas no comprobadas**: fuera las comillas de Wicksell (nota 51), Feldman (nota 47), la «tiranía de las minorías» de Baumol y la cita de Pareto de la nota 44; Wicksell y Feldman quedan como paráfrasis. La cita de **Walras** en francés también se da como paráfrasis, aunque datos la ha cotejado con dos escaneos de la 1.ª edición (V26, §126, p. 127): si quieres, se puede recuperar literal corrigiendo «sa demanda» → «sa demande». **Víctor (16/10/2026)**: recuperar la cita literal; hecho (francés corregido y traducción propia, en la nota del tanteo de I.2).
6. **Sin nombres de preparadores**: la entrada «Tema Juan Luis Cordero Tarifa» de la bibliografía se quita del tema (nombre de preparador). «Tema ICEX-CECO» se mantiene como lectura en la bibliografía, citada como en el original (CRITERIOS §2), con la clave `ICEXCECO3A21` y `\nocite`. Fuera los enlaces `file:///` y el de z-lib; las figuras que citaban a Fabián Salazar o a Policonomics pasan a «Elaboración propia a partir de <manual>». **Confirmada.**
7. **Anexo 2** del original (relación con los temas vecinos): se propuso no publicarlo por desfasado (atribuía el 2TFEB a 3.A.24). Las notas privadas (anexos 3-5, texto oculto, comentarios) siguen sin publicarse. **Víctor (16/10/2026)**: publicarlo corregido como nota al opositor; hecho (2 cajas, al final de I.3 y de II.2).
8. **Cournot (1838)**: se dice que «advierte de que el problema completo, con todos los mercados a la vez, excede el análisis matemático de su tiempo» (cap. XI-XII de las *Recherches*). Es de memoria; si no lo ves claro, se quita sin perder nada. **Víctor (16/10/2026)**: quitarla; hecho.
9. **Condiciones de Inada** (nota 16, con $K_t$, $L_t$): se quitan del tema porque no son un supuesto del modelo (garantizan soluciones interiores en crecimiento) y están en el 3.A.11. Si prefieres conservarlas, irían al anexo A con la notación $F(L,K)$. **Víctor (16/10/2026)**: fuera.
10. **Nota 34** (Arrow y Hahn, 1971, «equilibrio en mercados oligopolísticos con rendimientos crecientes limitados»): quitada por no comprobada (contenido y datos no la encuentran). En su lugar, III.2 cita Negishi (1961). **Víctor (16/10/2026)**: fuera; queda Negishi (1961).
11. **Unicidad**: la condición $\vect{p}^*\cdot\vect{z}(\vect{p})>0$ se cita a MWG 17.F y no a Wald, como proponía contenido, por no estar comprobada la atribución. **Confirmada.**
16. **Diseño de mecanismos y cálculo socialista** (tu idea, «Hurwicz, Myerson»): recuadro de profundización en III.2 y una línea en la conclusión. ¿Basta o quieres que se cante (quitaría tiempo a otro apartado)? Hurwicz (1972) y Myerson (1979) están en el `.bib` de memoria. **Confirmada.**
17. **Estática comparativa**: anexo E (decisión de coherencia), con una nota en II.1.2 y la mención en III.5. ¿Prefieres un párrafo en el cuerpo (contenido proponía un II.1.4 de 1 minuto)? **Confirmada.**
19. **Remisión a 3.A.19** (oligopolio) en el comportamiento estratégico: añadida por mí; no estaba en las propuestas. **Confirmada.**

## Dudas abiertas

12. **Edición de Segura**: el original dice 2004 y enlazaba un PDF de 1993; el `.bib` usa `Segura1986Analisis` (Alianza, 1986). ¿Qué edición tienes? (las páginas 282-287 del dinero dependen de ella).
13. **Entradas del `.bib` dadas de memoria por contenido («(m)»)**, que conviene cotejar (se ha quitado la marca del campo `note` para que no salga en la bibliografía): `Lange1942Say` (páginas), `BeckerBaumol1952Classical` (páginas), `Feldman1987Welfare` (volumen y páginas), `Gillies1959Solutions`, `Shubik1959Edgeworth`, `Hurwicz1972Informationally`, `Myerson1979Incentive`, `Mises1920Wirtschaftsrechnung`, `Lange1936Socialism`, `CooperJohn1988Coordinating`, `Hahn1965Problems` (páginas) y `Clower1967Reconsideration` (páginas). Las 12 se citan en el tema: conviene cotejarlas antes de publicar.
14. **Gráficos**: los rótulos del texto coinciden con los de las cajas ($OD_A$, $OD_B$, $\vect{x}_A$, $\vect{x}_B$, $U_A^0$, $U_B^0$, $U_A^*$, $U_B^*$, $\overline{X}$, $\overline{Y}$). La caja de intercambio es una sola (`caja-intercambio`, maestro para el vídeo, capas 1-10 de I.3 a III.2) con variantes para el PDF (`caja-intercambio-equilibrio`, `caja-intercambio-teoremas` y `caja-intercambio-nucleo`); el monopolio va aparte (`monopolio-intercambio`), como recuadro; la caja de la producción parte del gráfico del 3.A.11. Ninguno es 3D.
15. **Dinero (III.3)**: no se ha podido consultar Segura, pp. 282-287. El apartado cuenta la inconsistencia de la dicotomía y el problema de Hahn; coteja si Segura atribuye el «fracaso» de Patinkin a lo mismo. La cita de Hahn (1982, p. 1) va como paráfrasis: si la compruebas en el libro, puede ir literal.
18. **Arrow (1953)**: los datos de la edición francesa (coloquio del CNRS, pp. 41-47) no se han comprobado en línea; se cita también la traducción de 1964.
20. **Bibliografía con datos sin comprobar** (control de calidad): se han quitado del campo `note` del `.bib` (salían en la bibliografía pública) los avisos de trabajo de `Wald1936Gleichungssysteme` (página final, 670, sin comprobar), `Arrow1951Extension` (páginas sin comprobar en la edición impresa), `Arrow1953Role` (datos de la edición francesa sin comprobar) y `USITC2019USMCA` (el PDF da 403 a descargas automáticas; cifras tomadas de la nota de Thompson Hine). Conviene cotejarlos antes de publicar.
21. **Ekelund y Hébert, páginas**: las notas de la escuela de Estocolmo y de Bentham a Pareto (y la de las tecnologías del consumo, cap. 26) citan el capítulo; las páginas no se han podido ver (ejemplar restringido). Si las localizas en tu ejemplar, se añaden. La clave sigue siendo `EkelundHebert2013History` (con `year = {2014}`), común a 3A08, 3A09, 3A11, 3A12 y 3A21.

## Instrucciones para el vídeo

- La caja de intercambio se dibuja en I.3 en una celda propia que **no se borra** hasta el final de III.2 y crece capa a capa (`caja-intercambio`: 1-6 en I.3; 7-8 en II.2; 9 en III.1; 10 en III.2). Nunca se dibuja una segunda caja.
- El gráfico de equilibrios múltiples (`equilibrios-multiples`) se dibuja en II.1.2 (capas 1-4) y en II.1.3 se le añaden las flechas del tanteo (capas 5-6) sin borrarlo.
- La caja de la producción con la FPP es la del 3.A.11: en el vídeo, la versión reducida (caja, curva de contrato, isocoste, FPP y recta de precios), con la caja a la izquierda y la FPP a la derecha.
- El punto fijo de Brouwer se dibuja entero (cuadrado, diagonal, una curva y el punto fijo) mientras se dice el teorema; la aplicación del subastador, ec. `aplicacion-brouwer`, puede ir como apoyo y decirse en palabras.
- Bienes libres, monopolio en la caja y los gráficos de los anexos: solo como apoyo o fuera del vídeo.
- Pregunta de enganche sugerida: «¿Cómo es posible que millones de decisiones que nadie coordina encajen sin que sobre ni falte nada?»; la idea final de la conclusión la responde.

## Cambios del 16/10/2026 (criterios nuevos)

Aplicadas las reglas del 16/10/2026 de CRITERIOS.md sin tocar la estructura (mismos apartados, epígrafes, minutos y anexos). El tema sigue en 29 páginas (anexos, 9; bibliografía, 6).

- **Problemas de optimización con `\optim`** (objetivo arriba, cada restricción en su línea): empresa (ec. 2), consumidor (ec. 5), consumidor y empresa del modelo general (anexo A, ecs. 20 y 21) y las 2 etapas de la maximización del beneficio (anexo A.1, que antes iban en línea). En el tema no hay problema del planificador ni de Pareto escrito como optimización.
- **`\funcionclave`** (3): el vector de excesos de demanda $\vec z(\vec p)$ (ec. 8; la renta $\overline{W}_i(\vec p)$ pasa a la línea siguiente), la ley de Walras $\vec p\cdot\vec z(\vec p)\equiv 0$ (ec. 9; la versión 2×2×2×2 pasa al texto, con lo que desaparece el «:» que había dentro de la fórmula) y la condición de equilibrio $z_k(\vec p^*)\leq 0$, $p_k^*z_k(\vec p^*)=0$ (ec. 10).
- **Viñetas con más niveles**: rendimientos admitidos por la convexidad (I.1), supuestos del 1TFEB (II.2.2), bloqueo y núcleo (III.2.1), títulos de Arrow y Radner (III.4) y usos de los MEGC (comercio: TLCAN, T-MEC, TTIP, UE-Mercosur; macroeconomía: REMS, EREMS, datos de 2025).
- **Minutos**: «medio minuto» de la nota al opositor de II → `\tiempo{0,5}`; el resto ya iba con `\tiempo`. Ninguna fórmula en display termina en «:».
- **Notas al pie**: de 25 a 34. Decisión sobre cada una de las 57 notas del original:

| Nota | Contenido | Decisión |
|---|---|---|
| 1 | Individualismo metodológico | **Recuperada** como nota (definición abreviada) en el enganche |
| 2 | Consumidores/productores, tecnologías del consumo | **Ya estaba** como nota; se recupera lo que faltaba: Stigler (1961) y la economía de la información |
| 3 | Clasificación de los modelos (competitivos/no; intercambio/producción) | **Recuperada** como nota (estaba integrada en el texto); en el texto queda «nos centramos en el EGC con producción» |
| 4 | Complejidad matemática | Ya estaba como nota, reescrita (era tautológica, C34) |
| 5 | Equilibrio parcial como alternativa | Descartada: integrada en el texto (viñeta del equilibrio parcial) |
| 6 | Cournot intentó el equilibrio general | Descartada (la frase de la contextualización, dada de memoria, se quita el 16/10/2026) |
| 7 | Escuela de Estocolmo (Cassel y Wicksell) | **Recuperada corregida**: son precursores, no miembros, de la escuela de Estocolmo (C5) |
| 8, 9, 33 | Nobel de Arrow (con Hicks) y de Debreu | Ya estaban, fundidas en una nota con la motivación oficial (V23) |
| 10 | Información perfecta | Ya estaba, reescrita (C8; se quita «la producción antes del intercambio») |
| 11, 17 | Bienes públicos y externalidades: precios no válidos | Ya estaban, fundidas en la nota de mercados completos (remite a 3.A.23) |
| 12 | Arrow-Debreu y McKenzie: participaciones en beneficios | Ya estaba, reescrita (C8) |
| 13 | Definición de función de producción | **Recuperada** como nota (I.1, empresas) |
| 14 | Tecnologías distintas | Ya estaba |
| 15 | Formas de la FPP | Ya estaba (con «lineal» y la última frase corregida, C34) |
| 16 | Tabla de las condiciones de Inada | Descartada: no es supuesto del modelo y está en 3.A.11 (C35) |
| 18, 30 | Walras no habla de subastador («on»), críticas de Bertrand y Edgeworth, tanteo virtual, Smith | Ya estaba, una sola nota; el 16/10/2026 recupera la cita francesa literal corregida, con traducción (V26) |
| 19, 27 | Problemas de la empresa y del consumidor con $H$, $I$, $S$ | Descartadas como nota: están en el anexo A, ahora con `\optim` |
| 20 | Maximización en 2 etapas con su gráfico | Ya estaba como nota breve; el desarrollo y el gráfico, en el anexo A.1 (no hace falta `\graficonota`) |
| 21 | Eficiencia en la producción | Descartada: integrada en el texto |
| 22 | Vértices de la caja en la curva de contrato | Ya estaba |
| 23 | Curva de contrato isoclina solo con homotéticas | Corregida (era falsa) dentro de la nota 22 actual |
| 24 | FPP como equilibrio de las empresas en el espacio de bienes | Descartada: integrada en el texto |
| 25 | Beneficios positivos y economías de alcance | Descartada: errónea (C, l. 408-411) |
| 26 | RMT como cociente de costes marginales | **Recuperada** con el signo del canon (RMT positiva) y la intuición de la FPP |
| 28 | Walras trabaja con demandas empíricas | Descartada: errónea (C10) |
| 29 | Bienes libres «no es de gran relevancia» | Descartada: opinión; el texto explica para qué sirven |
| 31 | URL de Liu (2019) | Descartada como nota: está en las lecturas de II.1.1 con su cita |
| 32 | Rouché-Frobenius y ecuaciones e incógnitas | Ya estaba; se recupera la clasificación de Rouché-Frobenius |
| 34 | Arrow y Hahn (1971) con oligopolios | Descartada: sin comprobar (V20, C16) |
| 35 | Nash, pionero del punto fijo | Ya estaba, corregida (von Neumann, 1937, es el primero) |
| 36 | Velocidad de ajuste $k_i$ | Descartada: integrada en el texto ($\kappa_k$) |
| 37 | Bienes libres en la regla del subastador | **Recuperada corregida** ($z_k\leq 0$, no $\geq 0$) en II.1.1 |
| 38 | $z_1<0$ en el ejemplo | Descartada: repite la condición de los bienes libres |
| 39 | «Equilibrios localmente óptimos» | Descartada: errónea («localmente únicos», ya en el texto) |
| 40 | SMD y equilibrio parcial | Ya estaba, corregida (C18) |
| 41, 42 | Estabilidad local y global; sin intercambios fuera del equilibrio | Descartadas: integradas en el texto (C34) |
| 43 | Tabla de ajuste walrasiano y marshalliano | Descartada como nota: tabla con color en el anexo D |
| 44 | Cita de Pareto sobre la moral y texto oculto | Descartada: cita sin localizar (P67) y nota privada (P6) |
| 45 | Asignaciones justas de Foley | **Recuperada** como nota en II.2.1, con Foley (1967) en la bibliografía |
| 46, 47 | Pareto y la ofelimidad, Wicksell; Feldman y la diana | Ya estaba, una sola nota en el 1TFEB; la GFPU, en el anexo C |
| 48 | Condiciones marginales del 1TFEB | Descartada: integradas en la ec. 11 |
| 49, 50 | Historia: Bentham, Mill, Gossen, Launhardt, ofelimidad | **Recuperadas** como nota en II.2.1 (salen del anexo C, que ahora remite a la nota); la mención a Aristóteles, sin fuente, se quita |
| 51 | Cita inglesa de Wicksell | Descartada: sin obra ni página (V28); queda la paráfrasis |
| 52 | Nobel de Sen | Descartada como nota: está en el anexo C |
| 53 | No convexidades y competencia imperfecta | Descartada: integrada en III.2.3 |
| 54 | Costes de operar los mercados y verificabilidad del estado | **Recuperada** como nota en la valoración de III.4 (estaba integrada) |
| 55 | MEGC para impuestos y transferencias | Ya estaba |
| 56 | Observatorio sobre el ciclo (BBVA, Fedea) | Ya estaba: el Observatorio, en el texto; los tipos de perturbación, en nota |
| 57 | Cita de De Vroey | Descartada: cita no encontrada (V29); paráfrasis en la conclusión |

- **Gráficos en nota**: ninguno. El único gráfico de nota del original (2 etapas, nota 20) ya está como gráfico del anexo A.1; no hay que dibujar nada.
- **Bibliografía**: nueva entrada `Foley1967Resource` (*Yale Economic Essays*, 7(1), 45-98); `Stigler1961Information` ya estaba en el `.bib`.
- **Dudas para Víctor**: la nota de la escuela de Estocolmo y la de la historia del criterio de Pareto se citan desde el 16/10/2026 con Ekelund y Hébert (capítulos 17 y 6), sin páginas (duda 21), y la de Estocolmo además con HET.

## Cambios del 16/10/2026 (respuestas de Víctor)

Sin tocar la estructura, los apartados ni los minutos. Fuente de lo cotejado: `_trabajo/cotejo-16oct.md`.

- **Walras (1874), §126, p. 127**: la nota del tanteo (I.2) recupera la cita literal en francés, corregida («sa demande ou offre»; «liés aux $m-1$ autres»), con su traducción fiel al castellano (traducción propia) y la cita a `Walras1874Elements`. Se mantiene la explicación del impersonal *on* y el resto de la nota (bons, Walker, Smith).
- **Cournot**: quitada de la contextualización la frase de memoria; `Cournot1838Recherches` queda en el `.bib` sin citar (no sale en la bibliografía). Inada y la nota 34 siguen fuera (Negishi en III.2).
- **Ekelund y Hébert**: la nota de Bentham a Pareto (II.2.1) cita los caps. 6 (Bentham y el utilitarismo) y 17 (Pareto, equilibrio general y bienestar); la de las tecnologías del consumo (introducción), el cap. 26, según el cotejo. Páginas no disponibles.
- **Escuela de Estocolmo** (nota de la contextualización): Wicksell, maestro de la escuela, y Cassel, del que la escuela se distanció, como antecesores; miembros (Myrdal, Lindahl, Lundberg, Ohlin) y fechas (1925-1940); fuera «Wicksell (1898) parte del equilibrio walrasiano» (sin fuente); Cassel (1918) con coeficientes fijos y sin utilidad. Citas: `HET2026Swedish`, `HET2026Cassel`, `HET2026Wald` y Ekelund y Hébert, cap. 17. Las 2 entradas HET nuevas, en `3A21.bib`.
- **Anexo 2 del original**, corregido en 2 `notaopositor`: al final de I.3, qué es de este tema y qué del 3.A.16 (sistema de ecuaciones simultáneas, precios endógenos, recuento de ecuaciones, exceso de demanda, ley de Walras), y al final de II.2, el reparto con 3.A.22 (criterio, condiciones del óptimo, los 2 teoremas y *second best*), 3.A.23 (fallos de mercado e intervención) y 3.A.24 (funciones de bienestar social y elección colectiva). Sin nombres ni notas privadas.
- **Decisiones confirmadas**: las dudas 1-11, 16, 17 y 19 pasan a «Decisiones de Víctor (16/10/2026)»; quedan abiertas las de cotejo (12-15, 18, 20 y la nueva 21).

