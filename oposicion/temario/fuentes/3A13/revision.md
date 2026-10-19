# Revisión del tema 3.A.13 — Economía de la información y teoría de la agencia: selección adversa y riesgo moral.

Fecha: 19/10/2026. Integración en 2 partes: la 1 escribió el preámbulo, la introducción y los bloques I y II; la 2, el bloque III, la conclusión, los anexos A-D, los gráficos pedidos, `seo.json` y este informe.

Fuentes de la integración: `_trabajo/original.md`, `pendientes.md` (P1-P58), `propuestas-contenido.md` (C1-C64), `propuestas-datos.md` (V1-V41, F1-F14) con `bib-datos.bib`, y `propuestas-coherencia.md` (K1-K37, estructura final, esquema de pizarra, C1-C6 al canon, D1-D9). Criterio ante discrepancias: la estructura, los minutos y la notación los decide coherencia; la teoría, contenido. Mientras Víctor no conteste en el artifact, se aplican las decisiones del orquestador (las dudas A13-01 a A13-03 con la opción recomendada; ver «Dudas abiertas»).

## Resumen

- Nueva fuente `3A13.tex` (**28 páginas de tema, 6 de anexos y 5 de bibliografía**, con los 7 gráficos en TikZ). Tres bloques: I. Selección adversa (Akerlof, Spence, Rothschild-Stiglitz, otras soluciones); II. Problema de agencia y riesgo moral (principal-agente completo); III. Selección adversa y riesgo moral a la vez (Stiglitz-Weiss, que deja de ser «comodín» y pasa a desarrollo de referencia, D070). El bloque 0 del original («Implicaciones sobre la eficiencia») pasa a la contextualización de la introducción.
- Hilo conductor: la teoría de la agencia como marco común (quien no tiene la información diseña un contrato con participación, PC, y compatibilidad de incentivos, IC) y el «precio de la información», que alguien paga. Función clave: el programa del principal con PC e IC (`eq:principal-agente`), que se queda en la pizarra de II.2 al final.
- El riesgo moral, que estaba a medio hacer (caso c con «[…]», caso d sin resolución analítica, «Soluciones de la teoría de la agencia» y «Valoración» vacías, anexo 1 de 3 viñetas), queda resuelto entero: CPO, condición de Holmström-Mirrlees, pagos explícitos, coste de agencia por Jensen, venta del negocio, tabla de los 4 casos, extensiones, evidencia y anexo A paso a paso.
- Corregidos más de 25 errores de teoría, fórmulas y atribuciones (distorsión «en la cumbre» al revés, «Arrow-Hahn», principio de revelación, programa del agente con PC e IC, w(e), «equilibrio aunador» en Akerlof, Stiglitz-Weiss con proyectos «muy rentables y arriesgados» y E[B] = r̂ × Pr, dato del S&P 500…); resueltas las 3 marcas amarillas y todas las notas al opositor y comentarios.
- `3A13.bib` con 102 entradas; 7 gráficos TikZ en `graficos/` (akerlof, spence, seguro-simetrico, rothschild-stiglitz, rs-inexistencia, principal-agente, stiglitz-weiss).

## Errores corregidos

| Dónde | Decía | Dice ahora |
|---|---|---|
| Intro, enganche (l. 45) | Cita de Marshall «la ciencia de la vida diaria…» (no literal; es el enganche del 3.A.8) | Refranes «Dar gato por liebre» y «El ojo del amo engorda al caballo» con el rescate de los depositantes de Silicon Valley Bank (12/03/2023); la idea final lo retoma (K10, C4) |
| Intro, Nobel 2007 (l. 77) | «…que determina cuándo los mercados están trabajando de manera efectiva» | Solo la motivación oficial: «por haber sentado las bases de la teoría del diseño de mecanismos» (V3) |
| Intro, Nobel 2014 (l. 79) | «por sus análisis sobre el poder y las regulaciones del mercado» | «por su análisis del poder de mercado y la regulación» (V4); las 6 motivaciones con su cita a nobelprize.org |
| Contextualización (l. 91) y nota 5 | Laffont y Martimort (2001) | 2002 (Princeton); la cita de Schumpeter está en su introducción (V8) |
| Bloque 0 (l. 140) | Rendimientos no crecientes como supuesto del 1TFEB | El 1TFEB solo necesita no saciedad local (MWG, prop. 16.C.1); la convexidad la necesitan la existencia y el 2TFEB (C6) |
| Bloque 0 (l. 148) | «Teorema de Arrow-Hahn» | Modelo de Arrow-Debreu con mercados contingentes (Arrow, 1953; Debreu, 1959, cap. 7) (V10, K14.2) |
| Bloque 0 (l. 144-148) | «Con información incompleta se podría dar una asignación no eficiente» y, a la vez, que con información incompleta pero simétrica se llega al óptimo | Definiciones limpias: imperfecta / incompleta simétrica / asimétrica con conflicto de intereses (K5, K14.1) |
| Bloque 0 (l. 152) y nota 8 | Sin conflicto de intereses, los agentes «intercambiarán información automáticamente de acuerdo con el principio de revelación de Myerson» | El principio de revelación bien enunciado (Gibbard, Dasgupta-Hammond-Maskin, Myerson) en I.3.2 (K7, C21) |
| I.3.2 (l. 400) | «Los modelos de autoselección se basan en el principio de revelación de Myerson (1979)» (anacronismo: R-S es de 1976) | «Su lógica es la del principio de revelación» |
| Nota 12 | Milgrom y Roberts (1993) | 1982, *Econometrica* (V11) |
| Nota 13 | Laffont y Tirole (1991) [ver tema 3.A.20] | Laffont y Tirole (1993), `\vertema{3.A.17}` (V12, K36, decisión del orquestador) |
| I.2 (l. 240) | Solo se venden limones a 500 € «(equilibrio aunador)» | «En equilibrio solo se venden limones» (no es un agrupador) (K14.3, C14) |
| I.2 (l. 250) | «calidad del precio» | «un precio más alto atrae coches mejores» (C14) |
| I.3.1 (l. 340-346) | Restricciones estrictas, w^R, E para la educación, sin participación del tipo B | IC_A e IC_B con ≥, y para la educación, participación de cada tipo, doble desigualdad `eq:spence` (C18, D129) |
| I.3.1 (l. 376) | Equilibrio sin creencias | Creencias, salarios y decisiones; criterio intuitivo (Cho y Kreps, 1987) (C19) |
| I.3.1 (l. 394) | «El propio Spence muestra empíricamente que los trabajadores tienden a sobreeducarse» | Implicación teórica del modelo; Spence (1973) no tiene datos (V16, C20) |
| Nota 18 | «Spence se ha arrepentido de que se haya tomado su teoría como una descripción literal» | Sin el «arrepentimiento» (sin fuente): el modelo supone que la educación no aumenta la productividad para aislar la señal (V17) |
| I.3.2 (l. 440) | A = (p_1, p_2; W, W − P) | Lotería (1 − π, π; W̄, W̄ − L), punto A = (W̄, W̄ − L), como el 3.A.10 |
| I.3.2 (l. 470) | −dx_2/dx_1 = −(1−r)/r | Pendiente −(1−γ)/γ (signo corregido; γ prima por euro, como el 3.A.10) |
| I.3.2 (l. 644) y nota 25 | La «distorsión en la cumbre» afecta a los buenos conductores | No hay distorsión arriba: el temerario recibe el contrato eficiente; la distorsión recae en el prudente (K14.5, C28) |
| I.3.2 (l. 640) | Frase acabada en «:» sin nada detrás; Imagen 13 «Fuente: ¿?» | Inexistencia del equilibrio explicada en el cuerpo y en el anexo B, con gráfico propio (K14.13, C27) |
| Nota 26 | Soluciones públicas «en el mercado de trabajo» | En el mercado de seguros; norma vigente RDLeg 8/2004 (V24) |
| II.1 (l. 680-692, 789) | Condiciones numeradas «1, 1, 4» y «[se cumple el punto 2]» | 1. acción oculta; 2. conflicto; 3. riesgo y aversión, con `\ref` (K14.6) |
| II.1 (l. 684) | «no es verificable por parte del directivo» | Por parte del principal (C31) |
| II.1 (l. 676) | Arrow (1970) | Arrow (1963), con Pauly (1968) (V19) |
| II.1 (l. 698) | «Este conflicto proviene de los efectos sustitución» | El dilema incentivos–reparto del riesgo explicado (C32) |
| II.2 (l. 752-775) | El programa del agente lleva PC e IC; w(e) «que depende del esfuerzo»; R[·] del principal | Programa del principal con PC e IC; w(x); principal neutral en el cuerpo y u_P solo en el anexo (K14.7, K24) |
| II.2 (l. 868) | Fórmula con el texto «Dejar hueco para otra restricción…» dentro | Programa con `\optim`; la idea pasa al vídeo |
| II.2 (l. 914-916) | «cada esfuerzo de la naturaleza», «cuevas» | «estado de la naturaleza», «curvas» |
| II.2 (l. 968) | «Se sigue cumpliendo el 1TFEB y la asignación competitiva sigue siendo eficiente» | Asignación eficiente en el sentido de Pareto (es un contrato bilateral) (C59) |
| II.2 (l. 1076) | El salario depende «de la probabilidad relativa de realizar un esfuerzo bajo» | Depende del cociente de verosimilitud del resultado (C40) |
| II.2 (l. 1102) | «incentivar únicamente el riesgo bajo» | «el esfuerzo bajo» |
| Nota 29 | «El riesgo moral es una situación en la que el agente tiene más información sobre el riesgo» (es selección adversa) | Reescrita: agencia como marco, riesgo moral como acción oculta (C60) |
| Nota 31 | El principal «obtendrá un nivel de beneficios superior que si el agente fuera neutral» | Al principal neutral le sale más barato asegurar al averso por completo (C40) |
| III (l. 1174-1180) | 2 tipos de clientes: «muy rentables y arriesgados» / «menos rentables y menos arriesgados» | Igual rendimiento medio y distinto riesgo, responsabilidad limitada (K32, C47) |
| III (l. 1184-1190) | Dinámica de «criterios medios» y prima *ex post* | 3 efectos de subir r̂: directo, selección adversa e incentivo (C48) |
| III (l. 1198) | E[B] = r̂ × Pr(repago) | 𝔼[B_banco] = (1 + r̂)·Pr(repago \| r̂) (ficha `stiglitz-weiss`) |
| III (l. 1216) | «Curva de oferta cóncava» | Oferta que se dobla hacia atrás a partir de r̂* (K32) |
| III (l. 1246) | QE desplaza la oferta «hacia arriba» | Más fondos desplazan la oferta a la derecha: canal del crédito; ejemplo TLTRO del BCE (C49) |
| III (l. 1248-1250) | Holmström y Tirole: las empresas del S&P 500 tienen «1.450 millones de dólares» en efectivo | Dato quitado (escala errónea, sin fuente y mal atribuido); la idea de Holmström y Tirole (1998) con Bates, Kahle y Stulz (2009): 10,5 % → 23,2 % del activo (V22, decisión del orquestador) |
| Bibliografía | Laffont-Martimort en ResearchGate (403) | DOI y año 2002 (V39) |
| Enlace al test | quia.com con href roto | Enlace único al simulador (V38) |

## Marcas resueltas

| Marca | Original | Qué se hizo |
|---|---|---|
| P1, amarillo + comentario «Copiar de Sahuquillo» (l. 986) | «[…]» en la resolución analítica del caso c | Redactada de nuevo desde Laffont-Martimort (2002, cap. 4) y MWG 14.B: venta del negocio w(x) = x − k, coste de agencia nulo, salvedad de la responsabilidad limitada (caso 3 y anexo A.3). No se copia material de preparador |
| P2, amarillo en comentario (l. 1115) + tabla `image25.png` | «He intentado hacer esta tabla…» | Tabla `tab:agencia-casos` con color, solo con lo que justifica el gráfico (principal neutral); el poder de negociación va a una nota (solo cambia el reparto de rentas) |
| P3, amarillo (l. 1280) | «Por ejemplo, (votación política)» | Relevancia de la conclusión: votantes como principal y gobernantes como agente (Barro, 1973; Ferejohn, 1986), con `\vertema{4.B.2}` |
| P4, nota inicial de cambio de temario + ficha del tribunal | «Con el cambio de temario…» | Desaparece; lo que pide la ficha (programa, CPO y soluciones del riesgo moral; autoselección formalizada) queda cubierto |
| P5, P7, P8, P9, P10, P18, comentarios (l. 17-41, 170, 254-272, 358, 653, 988, 1114-1120) | Notas de trabajo, fotos de pizarra, «Llegar aquí en el minuto 3», clases y capturas | No se publican. Las preguntas de test que citaban (2019 p. 7, 2020 p. 8) se resuelven en el texto y en el anexo A.5 |
| P6 | Fotos de pizarra | Referencia para el esquema y el vídeo |
| P11, nota al opositor (l. 386) | «El nivel de educación necesario no lo marca la empresa» | `notaopositor` reescrita: lo fijan las creencias; criterio intuitivo |
| P12, notas (l. 412-430) | «Es el modelo del 3.A.10…», «Coordinar», Tugores, YouTube | `notaopositor` de una frase con `\vertema{3.A.10}` y caja de Mossin; el resto desaparece |
| P13, nota + escaneo de la p. 17 (`image20.png`) | Página escaneada de un manual de preparador | Eliminada de todos los formatos; su contenido (agrupador, descreme, separador, inexistencia) redactado de nuevo citando Rothschild y Stiglitz (1976) y Wilson (1977) |
| P14, notas (l. 728-736) | «Explicar contexto como en págs. 667-668 de Fernández de Castro y Tugores» | a) Idea del principal-agente redactada (vendedor de enciclopedias) |
| P15, notas de pizarra (l. 797-843) | Plan de pizarra en 2 columnas | `notaopositor` de II y «Instrucciones para el vídeo» |
| P16, título «[no cantar]» del caso b | Esfuerzo observable y agente averso | Se canta (decisión del orquestador): una sola caja Z → T; casos 1 y 3 de palabra |
| P17, nota «Comodín» (l. 1158) | «Cantar sólo si me quedo corto» | Desaparece: Stiglitz-Weiss es bloque III con 4'30" (D070) |
| P19-P35, imágenes | 19 imágenes, varias de preparadores o escaneos, una sin fuente | 7 gráficos TikZ pedidos con «Elaboración propia a partir de…»; las fuentes de ICEX-CECO / Rodríguez López (2017) desaparecen |
| Notas 3, 7, 24 | Koutsoyiannis; Lerner/Arrow-Debreu; enlace de YouTube | Quitadas (materia del 3.A.22 o solo un enlace) |
| Notas 6, 10, 11, 12, 13 | Referencias en nota | Citas en el texto (`\parencite`) |
| Nota 23 | Primas favorable/desfavorable | Una frase en la caja de Mossin con `\vertema{3.A.10}` |
| Nota 26 | Soluciones públicas | Integrada en I.3.3 |
| Nota 39 | Esfuerzo continuo | c) Extensiones y anexo A.3 |
| Resto de notas (1, 2, 4, 9, 14-17, 19-22, 27, 30-38, 40, 41) | — | Se mantienen como notas, corregidas cuando procedía (notación π, W̄, γ; «agrupador»; «stricto sensu»; Taleb con cita) |

## Datos actualizados

| Dato | Valor anterior | Valor nuevo | Fuente | URL | Consulta | Segunda comprobación |
|---|---|---|---|---|---|---|
| Rescate de SVB (enganche) | — | 12/03/2023, protección de todos los depositantes | Comunicado conjunto del Tesoro, la Fed y la FDIC | https://www.federalreserve.gov/newsevents/pressreleases/monetary20230312b.htm | 19/10/2026 | Comprobado por el agente de contenido (C4) |
| Motivaciones Nobel 1996-2020 | traducciones libres | traducciones de las oficiales | nobelprize.org | https://www.nobelprize.org/prizes/economic-sciences/ | 19/10/2026 | Lindau, RePEc, prensa (V1-V6) |
| Rechazos de *Lemons* | «una de ellas argumentó…» | AER, RES y JPE; la frase es de los evaluadores de la JPE | Akerlof (2003), ensayo Nobel | https://www.nobelprize.org/prizes/economic-sciences/2001/akerlof/article/ | 19/10/2026 | The Economist (2016), p. 4 (V7) |
| Selección adversa en seguros de salud (Harvard) | — | pérdida del 2-4 % del gasto; primas −5-8 % | Cutler y Reber (1998), *QJE* | NBER w5796 | 19/10/2026 | Ficha de Harvard (V36) |
| GED | — | +10-19 % de ingresos (jóvenes blancos sin estudios) | Tyler, Murnane y Willett (2000), *QJE* | — | 19/10/2026 | **Sin segunda comprobación** (cifra del resumen del artículo; ver dudas) |
| Safelite | — | productividad +44 %, mitad incentivo, mitad selección | Lazear (2000), *AER* | — | 19/10/2026 | Resumen del artículo (C42) |
| RAND | — (contenido proponía «≈45 %») | ≈31 % menos de gasto con franquicia alta; elasticidad ≈ −0,2 | Manning et al. (1987), *AER* | JSTOR 1804094 | 19/10/2026 | Aron-Dine, Einav y Finkelstein (2013), *JEP* (V37) |
| Efectivo de las empresas | «1.450 millones de $» (S&P 500, sin fecha) | 10,5 % (1980) → 23,2 % (2006) del activo | Bates, Kahle y Stulz (2009), *JF* | — | 19/10/2026 | SSRN y W. P. Carey (C50). No se usa el dato de la Fed (9,7 billones, 2T 2026; V22), por decisión del orquestador |
| TLTRO | — | anunciadas el 05/06/2014 | BCE, nota de prensa | https://www.ecb.europa.eu/press/pr/date/2014/html/pr140605_2.en.html | 19/10/2026 | Página abierta en esta integración (título y mención de las TLTRO) |
| Garantía legal | — | 3 años; en segunda mano, mínimo 1 año pactado | RDL 7/2021 (art. 120 TRLGDCU) | https://www.boe.es/eli/es/rdl/2021/04/27/7 | 19/10/2026 | Art. 120.1 leído en el BOE (texto del RDL 7/2021, BOE-A-2021-6872) en el control de calidad: «tres años desde la entrega» y, en segunda mano, «no podrá ser inferior a un año» |
| Seguro obligatorio del automóvil | sin norma | RDLeg 8/2004 (actualizado el 18/02/2026) | BOE | https://www.boe.es/buscar/act.php?id=BOE-A-2004-18911 | 19/10/2026 | Ficha consolidada del BOE (V24) |
| Primas unisex | — | desde el 21/12/2012 | STJUE Test-Achats, C-236/09 | https://eur-lex.europa.eu/legal-content/ES/TXT/?uri=CELEX:62009CJ0236 | 19/10/2026 | **URL construida, sin abrir** (EUR-Lex no responde desde el entorno) |

## Contenido añadido

- **Introducción**: los 5 bloques; relevancia teórica, empírica y de política; contextualización histórica (Schumpeter en Laffont-Martimort, The Economist, rechazos de Akerlof) y teórica (bloque 0 reescrito: supuesto 2 del 3.A.16, imperfecta / incompleta simétrica / asimétrica, oculta / acción oculta, la agencia como marco común con PC e IC); tabla de clasificación con color; caja con los supuestos del 1TFEB; esquema de pizarra y reparto.
- **I**: juegos bayesianos y doctrina de Wilson; aplicaciones con autor (Bhattacharya, Myers-Majluf, Milgrom-Roberts, Laffont-Tirole, Stiglitz-Weiss); Akerlof a)-e) con el caso continuo (`eq:akerlof`, test de 2020) y evidencia; Spence con creencias, separadores y agrupadores, criterio intuitivo, óptimo restringido distinto del de Lipsey-Lancaster, efecto diploma y GED; Rothschild-Stiglitz formalizado (rectas de isobeneficio, cruce único, agrupador que no se sostiene, separador `eq:rs-separador`, inexistencia), 2.º grado con el lenguaje del 3.A.17, evidencia (Chiappori-Salanié, Finkelstein-Poterba, Einav-Finkelstein); otras soluciones privadas y públicas.
- **II**: definición con Smith, Arrow, Pauly, Ross, Mirrlees, Stiglitz, Holmström y Grossman-Hart; 3 condiciones; dilema incentivos–riesgo; aplicaciones; modelo a)-e) completo con los 4 casos, `eq:holmstrom-mirrlees`, pagos explícitos, coste de agencia, tabla; extensiones (MLRP, esfuerzo continuo, contrato lineal); evidencia (Safelite, RAND); valoración; soluciones de la teoría de la agencia (retribución variable, franquicias y aparcería, coaseguro, evaluación relativa y torneos, supervisión, salarios de eficiencia, multitarea) y otras (competencia, reputación, condicionalidad).
- **III**: Stiglitz-Weiss a)-e): supuestos de la ficha, convexidad/concavidad de los pagos por la responsabilidad limitada, 3 efectos, `eq:stiglitz-weiss`, oferta que se dobla hacia atrás, implicaciones (colateral, microcréditos, canal del crédito y TLTRO, avales públicos), extensiones (Bester, de Meza-Webb), evidencia (Berger-Udell; Holmström-Tirole con Bates-Kahle-Stulz), valoración.
- **Conclusión**: recapitulación con el hilo PC/IC, relevancia política, extensiones con remisiones, opinión (*social scoring* y la lección de Spence), idea final que responde al enganche.
- **Anexos**: A, principal-agente (planteamiento del anexo 1 original, regla de Borch con u_P y sus 4 casos, CPO paso a paso con la prueba de λ_1, λ_2 > 0, pagos, Jensen, agente neutral, esfuerzo continuo, contrato lineal CARA-normal, ejercicio de 2019 p. 7); B, Rothschild-Stiglitz (inexistencia, Wilson, Riley, Wilson-Miyazaki-Spence); C, Stiglitz-Weiss formal; D, test (simulador y dónde se responde cada pregunta oficial).

### Estado de cada propuesta

- **Coherencia**: K1-K9 aplicadas. K10 aplicada con el enganche de los 2 refranes y SVB (decisión del orquestador), manteniendo la nota del individualismo metodológico como el 3.A.17 (no se borra, contra lo que proponía K10). K11-K13 aplicadas (K13: sin el Reglamento de IA, porque no se pudo comprobar el artículo; ver dudas). K14 (1-13), K15, K17-K24, K26-K36 aplicadas (K36 solo con 3.A.17). K16 aplicada salvo: dotación **A** (no D) y prima **γ** (no r), por coordinación con el 3.A.10; λ_1, λ_2 como propone. K25 aplicada (k = 𝔼[x|e^A] − v(e^A) − U^R). K37: los 7 gráficos, con 2 paneles en `rothschild-stiglitz` (en vez de una sola figura) para que se lea en papel; el vídeo puede dibujarlo como un solo gráfico por capas.
- **Contenido**: C1, C3-C32, C34-C41, C43-C48, C50-C53, C55-C63 aplicadas. C2 (minutos) no: mandan los de coherencia (11'/11'/4'30"). C33 aplicada sin «Criminalidad» (sin contenido ni fuente). C42: RAND con las cifras de datos (31 %, −0,2), no el 45 %. C49: TLTRO con la URL comprobada. C54 aplicada sin el Reglamento de IA. C57: anexo C, sin numerar los teoremas de riesgo moral del artículo (no comprobados). C64 al canon.
- **Datos**: V1-V15, V18-V21, V23, V24, V26, V27, V29 (en paráfrasis), V30-V39, V41 aplicadas. V16 y V17: reformuladas/quitadas. V22: opción de Bates-Kahle-Stulz (sin el dato de la Fed), decisión del orquestador. V25 (Admiral): frase genérica sin el caso. V28 (Taleb, 2018): se mantiene con entrada `.bib` (Random House), sin segunda comprobación. V40: los vídeos de YouTube no van.

## Coherencia

- **Notación**: π, π(e), 𝔼[·], U^R, w(x), v(e), λ_1 y λ_2, PC/IC e IC_i en redonda; tipos A/B en redonda (alto/bajo) en los 3 modelos; ν para la proporción del tipo bueno; y, ŷ, c_A(y), w_A, w_B en Spence; x_E > x_F, w_E, w_F en la agencia; seguros con W̄, L, S, **γ**, x_1 (sin accidente), x_2 (con accidente), dotación **A = (W̄, W̄ − L)**, igual que el 3.A.10; 𝔼[B_banco] = (1 + r̂)·Pr(repago | r̂). θ y G son locales del anexo C; s y α, locales de Akerlof.
- **Para el canon** (`tema-canon`): las 4 fichas nuevas de C1 (`akerlof-lemons`, `spence-senalizacion`, `rothschild-stiglitz`, `principal-agente`); filas nuevas de `notacion.md` (C2, con γ en vez de r y A en vez de D para la dotación); C3 (numeración de la ficha `competencia-perfecta-equilibrio-parcial`), C4 (`mapa.yaml`), C5 (divergencias de `stiglitz-weiss`), C6 (`second-best`: «óptimo restringido» frente a «terceros óptimos» del 3.A.17).
- **Remisiones que se cumplen**: 3.A.16 (levantar el supuesto 2), 3.A.17 (2.º grado como *screening*, terna de condiciones, regulación como agencia, Laffont-Tirole), 3.A.21 (Arrow-Debreu, mercados que faltan, principio de revelación), 3.A.10 (caja de Mossin).
- **Contradicciones con otros temas** (no se tocan):
  - **3.B.27 y 4.A.20**: Stiglitz-Weiss con proyectos «muy rentables y arriesgados», «criterios medios», E[B] = r̂ × Pr y «oferta cóncava»: al revisarlos, resumen con la ficha y remisión aquí.
  - **3.A.7**: desarrolla Shapiro-Stiglitz (la referencia es el 3.A.27); que llame «restricción de compatibilidad de incentivos» a la *no-shirking condition*.
  - **3.A.27**: usar «IC» y e para el esfuerzo.
  - **3.A.10**: no titular su demanda de seguros «Rothschild y Stiglitz (1976)» (es Mossin); mismos ejes, A y γ (ya en su P59).
  - **3.A.14**: tendrá que desarrollar los juegos de señalización, el criterio intuitivo y el diseño de mecanismos a los que se remite aquí.
  - **3.A.23**: resumir la información asimétrica con la terna y las soluciones públicas de I.3.3, sin repetir los modelos.
  - **3.A.25**: Spence como alternativa al capital humano (coherente); usar y para la educación.

## Dudas abiertas

1. **Decisiones provisionales del orquestador** (A13-01 a A13-03 del artifact y las demás de la integración), aplicadas con la opción recomendada a la espera de tu respuesta: bloque 0 a la contextualización y 3 bloques (D1); caso 2 cantado con una sola caja Z → T, casos 1 y 3 de palabra (D2); Laffont-Tirole remitido al 3.A.17 (D3); enganche con los 2 refranes y SVB (D4); tipos A/B y ν (D5, D6); principal neutral en el cuerpo y u_P solo en el anexo (D7); sin «Tema de Juan Luis Cordero Tarifa» en la bibliografía (D8). La anécdota de los capitanes romanos (sin fuente) se sustituye por la cita de Adam Smith; la cita de Schumpeter en Laffont-Martimort se mantiene (localizada en su introducción).
2. **Fernández de Castro y Tugores, *Fundamentos de microeconomía***: edición sin confirmar (los catálogos dan otros títulos y las págs. 666-681 y 752 no caben en ellos, V34). Se cita solo en la fuente del gráfico `principal-agente`. ¿Puedes mandar portada y créditos de tu ejemplar?
3. **Cifras y normas sin segunda comprobación**: el 10-19 % del GED (Tyler, Murnane y Willett, 2000); la URL de EUR-Lex de Test-Achats (construida; EUR-Lex responde con una página de comprobación y no se ha podido leer); la edición de Taleb (2018, V28). El plazo del art. 120 TRLGDCU ya está comprobado en el BOE.
4. **Reglamento (UE) 2024/1689 de inteligencia artificial** (K13): no se ha podido abrir EUR-Lex para comprobar el artículo que prohíbe la puntuación social y el anexo que trata la evaluación de solvencia como alto riesgo; la opinión queda sin él. ¿Se añade tras comprobarlo?
5. **Imagen 13** del original (fuente «¿?»): probablemente de Macho-Stadler y Pérez-Castrillo (V31); se redibuja como `rs-inexistencia` con fuente Rothschild-Stiglitz y Wilson.
6. **Frase de Joan Robinson** (mapa a escala 1:1): no encaja aquí; no se ha puesto.
7. **Extensión**: 28 páginas de cuerpo; el cante se ciñe a lo marcado en las notas al opositor.
8. Control de calidad (19/10/2026): sin incidencias pendientes en el tema. Corregido en esta fase: la nota al opositor de III decía «los 2 efectos» (son 3); la lotería del seguro, con el orden del 3.A.10, $(\overline{W},\overline{W}-L;\ 1-\pi,\pi)$, y «prima recargada» en vez de «desfavorable»; el equilibrio separador de Spence y el de Rothschild-Stiglitz ya no se llaman «óptimo restringido» sin matiz (pueden no ser el mejor resultado posible con esa información: agrupador que domina en Spence, menú con subvenciones cruzadas en R-S), y la conclusión dice «en el mejor de los casos, un óptimo restringido»; la nota del caso 2 citaba un punto $R$ que no está en el gráfico; el ejercicio de 2019 decía que era el caso de franquicia del anexo (no lo es: el principal es neutral ante $X$) y citaba una opción «a)» que no se reproduce; las condiciones de primer orden del anexo A.3 daban un error de MathJax en la web (dos `\label` en un `align`): ahora son 2 ecuaciones. Queda, de las plantillas y no del tema: en el móvil, las ecuaciones anchas (4) y (9) se salen por la derecha, y en el Word las ecuaciones no llevan número aunque se remita a ellas.

## Instrucciones para el vídeo

- Enganche: «Dar gato por liebre» y «el ojo del amo engorda al caballo» con SVB; pregunta: «¿Puede un contrato bien diseñado sustituir al ojo del amo?». La idea final la responde («En parte… alguien pagará por ella»).
- Introducción y conclusión sin pizarra; la tabla de clasificación, como apoyo.
- I: `akerlof` como apoyo o una línea en la pizarra; `spence` en la pizarra con la doble desigualdad; la caja de Mossin (`seguro-simetrico`) como apoyo (2 frases); `rothschild-stiglitz` por capas: primero el panel izquierdo (first best → M → descreme) y después el derecho (E_A → S_B), o un solo gráfico que crece, sin escribir dos veces lo mismo.
- II: rejilla en 2 columnas: a la izquierda el programa `eq:principal-agente` escrito primero **solo con la PC** (caso 2) y con la IC añadida al pasar al caso 4 (sin borrar nada); a la derecha `principal-agente` por capas (caja → certezas → isobeneficio → PC → Z; después IC → T → coste de agencia). Casos 1 y 3 de palabra (apunte). Tabla de los 4 casos como apoyo. Al cambiar de bloque, `conservar:` la columna del programa (función clave) hasta el final.
- III: `stiglitz-weiss` en 2 paneles (rendimiento del banco → mercado con oferta que se dobla) y la función 𝔼[B_banco] pequeña; se recuerda que la responsabilidad limitada es lo que impide «vender el negocio».
- Apoyo, no pizarra: `rs-inexistencia` y todo lo de los anexos.
