# Revisión del 3.B.8. La política comercial (II): la política comercial estratégica

Revisión autónoma (Víctor está fuera del 31/10 al 9/11/2026). La fuente es nueva, en LaTeX (`3B08.tex`), y se escribió en 2 partes el 5/11/2026:

- **parte 1**: la introducción y el apartado I;
- **parte 2**: los apartados II y III, la conclusión y los 6 anexos.

Las dudas de estructura D1-D4 se resuelven con lo que recomendó el agente de coherencia y aparecen en «Dudas abiertas», para que Víctor las confirme.

## 1. Resumen

- **Estructura** (K1 de coherencia, decisión 1 del coordinador). Se mantienen los 3 bloques del original y sus títulos de segundo nivel:
  - I. Política comercial estratégica: idea; ofensiva (Brander-Spencer, Eaton-Grossman y Airbus-Boeing); defensiva (arancel en mercados recíprocos, Eaton-Kierzkowski e industria naciente); críticas.
  - II. Promoción exterior: objetivos, justificación e instrumentos.
  - III. Se retitula «Comportamiento estratégico entre gobiernos: represalias y guerras comerciales» y tiene 3 subapartados nuevos: represalias en los modelos de oligopolio, la guerra arancelaria de Johnson y la salida cooperativa.
- **Minutos**: introducción 2′30″, I 17′, II 5′, III 4′30″ y conclusión 1′, en total 30′. Dentro del I: I.1 2′; I.2 7′30″ (4′ + 1′30″ + 2′); I.3 5′30″ (2′30″ + 30″ + 2′30″); I.4 2′.
- **Lo más importante que se ha rehecho**:
  - Brander-Spencer, con la regla de la subvención óptima $s_A^*=q_Ap'R_B'$, el caso lineal $(a-c)/4$, el compromiso creíble y la nota sobre Stackelberg.
  - Eaton-Grossman, con las implicaciones corregidas y la regla de las conjeturas.
  - El arancel en mercados recíprocos, atribuido a Brander y Spencer (1984), con la notación y el gráfico del dumping recíproco del 3.B.6: $t^*=(a-c)/3$ y el arancel prohibitivo a partir de $(a-c)/2$.
  - La industria naciente, con 3 condiciones, los criterios de Mill, Bastable y Kemp, el gráfico de las economías externas del 3.B.6 y evidencia moderna.
  - El bloque III, reorientado a los juegos entre gobiernos.
- **Introducción y conclusión propias del tema**: sustituyen a las comunes del bloque 3.B.5-3.B.9. El enganche es «Arrieros somos y en el camino nos encontraremos», con la disputa de Airbus y Boeing en la OMC (2004-2026). La idea final responde a la pregunta del enganche y retoma el refrán.
- **Ficheros**:
  - `3B08.bib`, con 102 entradas y DOI comprobados en Crossref el 5/11/2026;
  - `graficos-pedidos.json`, con 8 gráficos de teoría; 3 parten de gráficos del 3.B.6 y del 3.A.19;
  - `seo.json`.
- **Compilación**: tras las correcciones del control de calidad (5/11/2026), el tema no se ha vuelto a compilar; lo construirá el coordinador cuando estén todos los gráficos. La última copia temporal, anterior a esas correcciones, compiló sin referencias ni citas indefinidas, con 30 páginas de tema, 7 de anexos y 6 de bibliografía. Para no pasar de unas 32 páginas, el desarrollo de Eaton y Kierzkowski y la industria naciente en equilibrio general se llevaron a los anexos. No se ha ejecutado `construir-tema.py`.

## 2. Errores corregidos

| Dónde (original) | Decía | Dice ahora |
|---|---|---|
| I.1.1 (l. 97) | Actúa la «autoridad fiscal» | Actúa el gobierno, que mueve primero y se compromete. Se define con 3 elementos (quién, con qué y para qué) siguiendo a Brander (1995) |
| I.1.2 (l. 117) | Eaton y Kierzkowski (**1985**), «un **impuesto** óptimo» | 1984 y un **arancel** |
| I.1.3 (l. 141) | Anuncia «un modelo de política defensiva» y lista 2; no anuncia la industria naciente | 3 modelos ofensivos y 3 defensivos, con la tabla de modelos `tab:modelos` |
| I.2.1 (l. 159-293) | El duopolio de partida es «Brander y Krugman (1983)» | Es el Cournot estándar en un tercer mercado. Brander y Krugman (1983) es el dumping recíproco (ficha `brander-spencer`) |
| I.2.1 (l. 187-195) | $\pi$, $P(\cdot)$, $q_j^e$ y la función de reacción $\varphi$ | $B$, $p(Q)$ y $R_A(q_B;s_A)$, con la notación del canon (φ es la productividad de Melitz; π, la inflación) |
| l. 199 y nota 12 | «Ser la función inversa de demanda decreciente. Se dice que las cantidades son sustitutos estratégicos» | Sustitutos estratégicos: $\partial^2B_i/\partial q_i\partial q_j<0$ (Bulow, Geanakoplos y Klemperer, 1985), con las 2 condiciones de Hahn. Que la demanda sea decreciente no basta |
| Nota 11 | El equilibrio de Nash se define como lo mejor «da igual la estrategia que tome la otra empresa» | Esa es la definición de estrategia dominante. Un equilibrio de Nash es la mejor respuesta a lo que de verdad hace la otra |
| Nota 13 | Unicidad «por la condición de Gale-Nikaido» | Unicidad porque la aplicación de mejores respuestas es una contracción ($R_i'\in(-1,0)$). Gale y Nikaido (1965) queda como criterio equivalente en el anexo B |
| l. 343 | «el gobierno fijará un subsidio que permita a las empresas fijar el nivel de producción que maximice su beneficio al margen del subsidio» | El gobierno busca que la empresa produzca como una líder de Stackelberg: regla $s_A^*=q_A\,p'\,R_B'$ y, en el caso lineal, $(a-c)/4$ |
| Nota 16 | «à la Cournot como si fuera Stackelberg», confusa | Reescrita: la líder de Stackelberg está fuera de su función de reacción y la empresa subvencionada está sobre $R_A'$; se aclara qué isobeneficio es el tangente |
| l. 369 | ENPS definido como «cada jugador juega su mejor respuesta» (eso es el equilibrio de Nash) | ENPS: equilibrio de Nash en cada subjuego, también en los que no se alcanzan |
| l. 285-293 y 365-383 | Implicaciones de Cournot y de Brander-Spencer casi iguales | Se dejan una sola vez |
| l. 445 | Bertrand criticó a Cournot porque los precios «no los elige un subastador» | El subastador es walrasiano y posterior. Bertrand (1883) objetó que las empresas fijan precios |
| l. 465 | Coste de Eaton-Grossman $C_i(p_i,p_j^e)$ | El coste depende de la cantidad: $B_A=(p_A-c+s_A)\,q_A(p_A,p_B)$ |
| l. 499 | «Empresa nacional: pierde […], pero su beneficio neto de impuestos aumenta» (contradictorio) | Sube el beneficio **antes** del impuesto, que es el bienestar nacional. El beneficio neto puede bajar (en el caso lineal baja de 4/9 a 25/64) |
| l. 515-517 | Con la reacción extranjera en Eaton-Grossman, «el bienestar global disminuye» (presentado como un dilema más) | Los 2 países exportadores **ganan** (de 4/9 a 56/121); pierde el tercer país. No es un dilema del prisionero |
| l. 535 | El juego Airbus-Boeing se titula «en forma extensiva» | Las matrices son de forma normal; la secuencia se cuenta con palabras. Título: «Un ejemplo: *Airbus* frente a *Boeing*» |
| I.3.1 (título y l. 565) | «Modelo de Brander (1981) (aranceles)» | Brander (1981) no tiene aranceles. El modelo con arancel es de **Brander y Spencer (1984)** (Brander, 1995, § 4) |
| l. 590-625 | Coste fijo $F$ restado en cada mercado | $F$ se paga una sola vez y no afecta a las condiciones de primer orden |
| l. 645 | 1.ª etapa: «Elección del subsidio» | Elección del **arancel** |
| l. 651 | $W_A$ con $U_A$ menos el gasto más $\pi_A$ de los 2 mercados | $W_A=\mathrm{EC}^A+B_A^A+t_Aq_B^A$ en el mercado $A$ |
| l. 683 | «los beneficios de la empresa **doméstica** en el mercado nacional caigan, los beneficios de la empresa doméstica aumenten» | Caen los de la **extranjera** y suben los de la nacional |
| l. 741 | El arancel «obligaría a reducir a la empresa extranjera su precio de exportación» | Baja el precio que **ingresa** la extranjera, neto del arancel; el que pagan los consumidores no cambia |
| Industria naciente (l. 773) | «Ha-Joon-Chang» | Ha-Joon Chang (2002), con su obra |
| Nota 21 | Prébisch-Singer dentro de las economías externas | Fuera: no tiene que ver. La ISI va en una línea con `\vertema{3.B.28}` |
| Nota 25 | Las economías de escala «no son condición suficiente» y, a la vez, con las externas «sí hace falta protección», sin orden | Ordenado por tipos de economías de escala, con el criterio de Kemp. Con economías internas, el fallo está en el crédito; con externas, hay un fallo de coordinación |
| Nota 26 | Test de Bastable = «elegir un sector con potencial de demanda» | Bastable: el valor actual de las ganancias supera el coste de la protección. La selección de sectores pasa a las críticas |
| l. 847 | El arancel prohibitivo aparece como el caso general | Se presenta como caso extremo; la comparación relevante es con el coste (Bastable) |
| Imagen 9 (pie) | Fuente: el tema de otro preparador | Krugman, Obstfeld y Melitz (2018, cap. 7) |
| I.4 (l. 890-910) | 8 críticas sin jerarquía; la 1 repite la nota 25 | 4 grupos (información, disipación, economía política, represalias y reglas), sin repeticiones |
| Nota 27 | EE. UU. dio *tax-credits* a Boeing «en respuesta» | DS316: préstamos de lanzamiento a Airbus. DS353: ventajas fiscales federales y del estado de Washington y fondos de la NASA y de Defensa a Boeing |
| Anexo 1 | «Al haber economías de escala **externas** es más eficiente que produzca una sola empresa» | Que solo quepa una empresa se debe a un coste fijo grande, es decir, a economías **internas** |
| Nota 28 | FONPRODE como instrumento de internacionalización | Era de cooperación al desarrollo. Lo sustituyó en 2023 el FEDES (Ley 1/2023 y RD 810/2025), que no está ligado a empresas españolas |
| Nota 30 | Pymes, 99,9 %, «mayor a la del resto de países de la UE» | 99,8 % y 61 % del empleo. La proporción es la misma que en la UE (99,85 % frente a 99,84 %) |
| Bloque III (l. 1105-1297) | Toda la construcción de Meade, con erratas: nota 34 (exportaciones como bien), nota 35 (el arancel «disminuye» el precio relativo), l. 1221 (Stolper-Samuelson para las cantidades), «Equilibrio inicial» repetido, elasticidad infinita confusa, remisión al 3.A.23 | Fuera del tema (decisión 2): remisión a `\vertema{3.B.5}` y `\vertema{3.B.7}`. Johnson queda resumido. En la nota de las curvas de indiferencia comercial, el signo va bien (importaciones como bien, exportaciones como coste). Fórmula con $\varepsilon^*$ |
| l. 1083 | ICEX Next «[ver tema 4.A.24]» | `\vertema{4.A.25}` para ICEX y `\vertema{4.A.24}` para FIEM, CESCE y COFIDES (`mapa.yaml`) |
| III.2 y `tab:represalias` (versión de la parte 2) | Puede ganar la guerra arancelaria el país de oferta neta «mucho menos elástica» | Es al revés: gana el de oferta neta **más** elástica, es decir, cuando la del otro es mucho menos elástica; en la práctica, el país mucho mayor (Kennan y Riezman, 1988). Corregido por el control de calidad |
| III.1 (versión de la parte 2) | «Las 2 empresas estarían mejor si ningún gobierno subvencionara» | Las empresas ganan ($4(a-c)^2/25b$ frente a $(a-c)^2/9b$); los que pierden son los países |

## 3. Marcas resueltas

| Marca (original) | Qué decía | Qué se hizo |
|---|---|---|
| P1, amarillo (l. 387) | «[…]» en la evidencia de Brander-Spencer | Evidencia nueva: la calibración del A300 de Baldwin y Krugman (1988), sin cifras (decisión 6); Krishna, Hogan y Swagel (1989) sobre Dixit (1988); Irwin y Pavcnik (2004), con el 3,7 % y el 5 %. El límite del 33 % del acuerdo de 1992 se quita (decisión 7) |
| P2, amarillo (l. 427) | «[…]» en otras extensiones | Varias empresas nacionales (Dixit, 1984, con la fórmula para $n$ y $m$), libre entrada (Horstmann y Markusen), consumo nacional, I+D (Spencer y Brander, 1983), entrada (Dixit y Kyle, 1985), información asimétrica (Brander, 1995) y crecimiento (Grossman y Helpman, 1991; Krugman, 1987) |
| P3-P4, amarillo (nota 9) | Relación entre el tercer mercado y los mercados recíprocos del 3.B.6 | Reescrito como 2 notas aclaratorias en I.1, sin «en el tema 3.B.6 tratamos» |
| P5, nota al opositor inicial | Aviso del cambio de temario y captura de la tabla de otro preparador | Fuera. El bloque II se mantiene, como pedía la nota |
| P6, nota al opositor (industria naciente) | «Se juntan 3 problemas» | Integrada en la idea como las 3 condiciones que tienen que darse a la vez |
| P7, nota al opositor (instrumentos) | *World Trade Report* 2008, con un enlace a un PDF local | Integrada en II.2 como cita (`OMC2008WTR`, sección C). El enlace local no se publica |
| P8, nota al opositor (III) | «Muy por encima y con cuidado»; título «sacado de la manga» | III reorientado a la interacción entre gobiernos, con título nuevo (D1). Meade sale del tema |
| P9, 4 comentarios (l. 205-219) | Costes y demanda no lineales; qué pasa si se relajan los supuestos | Resuelto con la forma de las funciones de reacción en el anexo B y una nota sobre demanda muy convexa |
| P10, P13 y P14, comentarios | Origen de un párrafo, «ver tema de…», «coordinar con 3.B.7» | No se publican. La coordinación con el 3.B.7 la ha hecho coherencia (sección 6) |
| P11, comentarios (l. 543-553) | Cambiar el orden ofensiva y defensiva; fuente Brander (1995) | Se mantiene el orden (CRITERIOS § 2). Brander (1995) se cita como `Brander1995Strategic` |
| P12, comentarios del bloque II | Menos tiempo, es política comercial, más sutil, cuidado con la justificación | Aplicado: 5′ frente a 17′; justificación ordenada como fallos de mercado; compatibilidad con el Acuerdo SMC |
| P15-P30, figuras | 14 imágenes, 7 capturas y una captura de nota | 8 gráficos TikZ pedidos y 4 matrices en LaTeX. Las capturas de Policonomics y de un manual con derechos no se publican. Las imágenes 11-13 no se rehacen (decisión 2) |
| P62-P63 | Enlaces y tonos privados, bibliografía de temas de preparadores y enlace a un cuestionario externo | Fuera. La bibliografía sale de las obras del `.bib` y el test es el enlace genérico al simulador |

## 4. Datos actualizados

Todas las consultas se hicieron el 5/11/2026. Las URL están en `3B08.bib`.

| Dato | Antes | Ahora | Fuente | Segunda comprobación |
|---|---|---|---|---|
| Laudos de Airbus y Boeing (enganche) | — | DS316: 7.496,6 M USD al año (2019); DS353: 3.993 M USD (2020). En el texto, «unos 7.500» y «unos 4.000» | OMC, fichas DS316 y DS353 | Comisión Europea (DS353) y Reglamento de Ejecución 2020/1646: cuadra |
| Tregua y prórroga | — | Suspensión de 5 años desde el 11/7/2021; prórroga de la UE en julio de 2026 (Reglamento de Ejecución 2026/1549) | USTR (15/6/2021); Gafta (7/7/2026) | Federal Register 2021-14550; Bloomberg y gov.uk para 2026. EUR-Lex no se pudo abrir (ver «Dudas abiertas») |
| CHIPS and Science Act | — | 52.700 M USD (2022) | Casa Blanca, *fact sheet* de 9/8/2022 | congress.gov y NIST: cuadra |
| IRA | — | Sin importe; en 2025, recorte de créditos (Ley 119-21) | congress.gov | Bufetes que analizan la Ley 119-21 |
| Ley Europea de Chips | — | En vigor el 21/9/2023; propuesta de una segunda ley en junio de 2026 | Comisión Europea | DOUE y Digital Policy Alert |
| Sentencia del Supremo de EE. UU. | — | 20/2/2026: la IEEPA no autoriza aranceles | Jones Day | Thomson Reuters. La sentencia no se abrió |
| Comercio mundial (nota 4) | 31 billones (2022) | Se quita con la introducción común | — | — |
| Precios de los aviones tras el acuerdo de 1992 | — | +3,7 %, coherente con +5 % del coste marginal | Irwin y Pavcnik (2004) | Resumen del NBER WP 8648 |
| Eaton y Kierzkowski | 1985 y 1984 | 1984 | Clave del 3.B.6 | Crossref |
| Base de exportadores regulares | «La pasada crisis» | +33,7 % entre 2011 y 2016 | Estrategia de Internacionalización 2017-2027 | Coherencia interna de las tasas; sin segunda fuente independiente |
| Oficinas Económicas y Comerciales | Sin número | 107 en 86 países | ICEX, *Memoria 2025* | *Memoria 2024* (104 en 85) |
| 40 dólares por dólar (nota 29) | Sin fuente | 40 para la agencia mediana, con rendimientos decrecientes; 15 de media en estimaciones posteriores | Lederman, Olarreaga y Payton (2006, WP 4044; publicado en 2010) | Olarreaga, Sperlich y Trachsel (2015 y 2020) |
| Pymes (nota 30) | 99,9 %, «mayor que en la UE» | 99,8 % y 61 % del empleo; la misma proporción que en la UE | *Cifras PYME*, septiembre de 2026 | Eurostat `sbs_sc_ovw` (2024) |
| ICEX Next | Hasta 13.270 € | 60 % de los gastos, con un máximo de 24.000 € en 24 meses (convocatoria de 2026) | BDNS 934425 / BOE de 10/10/2026 | ICEX, *Memoria 2025* |
| Planes Integrales de Desarrollo de Mercado | 16 en 2015 | Sustituidos en 2017 por la Estrategia PASE (12 países). Los «16 de 2015» se quitan porque no se pueden comprobar | Secretaría de Estado de Comercio (PASE) | Estrategia 2017-2027 |
| Marco de la internacionalización | — | Estrategia 2017-2027 y Plan de Respuesta y Relanzamiento Comercial (RDL 4/2025, 14.100 M €) | La Moncloa (8/5/2025) | BOE, RDL 4/2025 |
| FONPRODE y FIEM (nota 28) | FONPRODE como instrumento de internacionalización | FIEM: Ley 11/2010. FONPRODE sustituido por el FEDES (Ley 1/2023, RD 810/2025) | BOE | BOE, Ley 36/2010 derogada |
| Consenso OCDE (nota 31) | Sin fecha | Modernizado en 2023, en vigor el 5/7/2023: plazos de hasta 15 años y de 22 para las inversiones verdes | Mayer Brown (8/8/2023) | EXIM (4/4/2023). La web de la OCDE da 403 |

## 5. Contenido añadido

- **Introducción**:
  - El enganche de Airbus y Boeing, con la pregunta que responde la idea final.
  - La relevancia teórica, con Krugman (1987, pág. 132) parafraseado.
  - La relevancia práctica, con CHIPS, IRA, la Ley Europea de Chips, los derechos sobre los vehículos eléctricos chinos y los aranceles de 2025.
  - La contextualización desde el 3.B.7 y el 3.B.6, la problemática y la estructura.
  - La caja de notación y la `notaopositor` con el reparto y las pegatinas.
- **I.1**:
  - La definición con 3 elementos.
  - El principio de focalización (Bhagwati y Ramaswami, 1963).
  - El ENPS bien definido.
  - La tabla de modelos `tab:modelos`, que es la pizarra fija del tema.
- **I.2.1**:
  - Las condiciones de Hahn.
  - La caja del caso lineal simétrico (Cournot y Stackelberg), con los valores del canon.
  - La descomposición $dW_A/ds_A$ y la regla de la subvención óptima.
  - La subvención con costes distintos (Brander, 1995).
  - Las extensiones de P2.
  - La evidencia de P1.
  - La valoración, con el coste de los fondos públicos.
- **I.2.2**:
  - La regla del impuesto óptimo.
  - La regla general de las conjeturas (Eaton y Grossman, 1986).
  - La evidencia y la valoración, que faltaban.
- **I.2.3**: las matrices de Krugman (1987), con 2 equilibrios de Nash sin subvención y uno con ella.
- **I.3.1**:
  - Supuestos, desarrollo, implicaciones, extensiones, evidencia y valoración, que el original dejaba vacíos.
  - La protección de las importaciones como promoción de las exportaciones (Krugman, 1984), con la simulación de las memorias de 16K (Baldwin y Krugman, 1986).
  - La incidencia de los aranceles de 2018.
- **I.3.2**: la idea, que faltaba, y una valoración breve. El desarrollo del original, corregido, pasa al anexo D.
- **I.3.3**:
  - El criterio de Kemp (1960).
  - La evidencia: Head (1994), Irwin (2000), Juhász (2018), Lane (2025) y una frase general sobre la literatura reciente.
  - Melitz (2005) en la valoración.
  - El gráfico de la frontera de posibilidades de producción, en el anexo E.
- **II**:
  - Una conclusión anticipada.
  - La compatibilidad con el Acuerdo SMC.
  - La información sobre mercados exteriores como bien público.
  - El coste fijo de exportar del modelo de Melitz.
  - El autodescubrimiento (Hausmann y Rodrik, 2003).
  - La evidencia de las agencias de promoción.
  - Las cifras al día.
- **III**:
  - III.1: la tabla `tab:represalias` y el gráfico en 2 paneles.
  - III.2: Johnson resumido, con el país que puede ganar la guerra y la evidencia de Broda, Limão y Weinstein (2008).
  - III.3: Bagwell y Staiger (1999), el dilema repetido, el cierre del ejemplo de Airbus y Boeing, las guerras comerciales de 2018 y 2025, y la nueva carrera de subvenciones.
- **Conclusión**: con los 5 bloques; la relevancia faltaba en el original.
- **Anexos**:
  - A. Las políticas óptimas con demanda lineal: subvención, $n$ y $m$ empresas, guerra de subvenciones, impuesto, impuestos de los 2 países, arancel con τ y guerra de aranceles con su matriz.
  - B. Existencia, unicidad y estabilidad de Cournot, con la forma de las funciones de reacción.
  - C. El juego de entrada: la variante con ventaja de costes de Boeing y el anexo 1 de Víctor, corregido.
  - D. El modelo de Eaton y Kierzkowski en detalle: supuestos, desarrollo e implicaciones del original, corregidos, con las notas 19 y 20. En el cuerpo quedan la idea y el resultado.
  - E. La industria naciente en equilibrio general: el gráfico de la frontera de posibilidades de producción en 3 paneles.
  - F. El enlace al simulador de test.

**Propuestas de contenido (C1-C36)**:

- **Aplicadas**: C2-C18, C20-C33, C35 y C36.
- **Aplicadas con cambios**:
  - C1: estructura, minutos y refranes de coherencia.
  - C19: Krugman (1984) va como extensión del I.3.1 y no como subapartado propio (K1).
  - C34: el anexo es el anexo C.
- **Cambios dentro de propuestas aplicadas**:
  - C2: el enganche es el de coherencia (decisión 10). Las cifras de CHIPS e IRA pasan a la relevancia.
  - C10 y C15: las reglas óptimas van como `equation`, no como `\funcionclave`. El impuesto se escribe $s_A<0$, porque $t_A$ es el arancel.
  - C12: sin las cifras de Baldwin y Krugman (1988) ni el 33 % (decisiones 6 y 7).
  - C17: la variante de costes pasa al anexo C.
  - C18: el arancel negativo con demanda muy convexa se cita a Brander (1995), comprobado por OCR, y no al resumen del *JIE*.
  - C20: la nota 20 no se quita. Se traduce y se cita con Bhagwati (1982) y Dinopoulos (1988) (V14).
  - C21: botones y países 1 y 2 (decisión 4).
  - C22: la nota sobre Meade se conserva con su obra (`Meade1955Trade`).
  - C27: la cifra de los 40 dólares sí se da (decisión 5).
  - C28: ICEX Sourcing se quita, porque no aparece en las memorias de ICEX de 2024 ni de 2025 (V38).
  - C31: la nota de las curvas de indiferencia comercial remite al 3.B.5, donde se derivan.
- **Rechazadas**:
  - Los refranes de C1 y C26 («cada uno barre para casa», «las palabras se las lleva el viento», «enséñale a pescar», «ojo por ojo»; decisión 10).
  - El texto de PERTE Chip y del Plan ICEX de Alto Impacto: no están en los datos comprobados.

## 6. Coherencia

- **Propuestas de coherencia (K1-K24)**:
  - Aplicadas: todas.
  - Sin el anexo de equilibrio general de K1 y K20 (decisión 2): Meade se remite al 3.B.5 y el arancel óptimo, al 3.B.7.
  - K14: los números del juego son los de Krugman (1987) y no los del manual (decisión 3).
  - K17: países 1 y 2 y no Suiza y Tailandia (decisión 4).
  - K22: la caja de Cournot y Stackelberg va sin gráfico, porque $C$ y $S$ están en `fig:brander-spencer`.
- **Notación**:
  - $R_A$ y $B$; $p(Q)$; $q_A^A$ y $q_B^A$ como en el 3.B.6; $s_A$ (impuesto si es negativa); $t_A$ arancel específico (avisado en la caja de notación); $\varepsilon^*$; EC en redonda.
  - El canon § 10 define $t$ como *ad valorem*. Va a `canon-pendiente.md`, sin tocar el canon (esta sesión no tiene fase canon).
- **Con el 3.B.6 (revisado)**: el 3.B.8 cumple todo lo que el 3.B.6 promete:
  - el arancel en lugar del coste de transporte, con el mismo gráfico y la misma ecuación;
  - la subvención de Brander-Spencer;
  - el impuesto de Eaton-Grossman;
  - la industria naciente sobre el gráfico de las economías externas, con los mismos botones y los mismos números.
- **Con el 3.B.10 (revisado)**: el arancel prohibitivo $t_A\geq(a-c)/2$ sostiene sus «2 monopolios nacionales protegidos por el arancel». Sin cambio.
- **Con el 3.A.22 y el 3.B.28 (revisados)**: la industria naciente con los 2 fallos (capitales y apropiabilidad) y el arancel como segundo óptimo (Bhagwati y Ramaswami), con las mismas palabras.
- **Con el 3.A.14 y el 3.A.19 (revisados)**: Brander-Spencer como compromiso creíble, con Dixit (1980) y el ENPS.
- **Contradicciones con otros temas** (no se han tocado):
  1. **3.A.14, l. 1097**: remite la guerra arancelaria de Johnson al 3.B.7. Según la ficha `arancel-optimo`, se queda en el 3.B.8. Anotado en `canon-pendiente.md`.
  2. **Ficha `brander-krugman`** del canon: atribuye el arancel en mercados recíprocos a Brander (1981); es de Brander y Spencer (1984). Anotado en `canon-pendiente.md` (CP1).
  3. **3.B.7 (Word, sin revisar)**: duplica Meade, el arancel óptimo y Johnson (con remisión a 3.A.19, que debe ser 3.A.14). Al revisarlo, Johnson en una línea con `\vertema{3.B.8}` y las subvenciones estratégicas remitidas aquí.
  4. **3.B.41 (Word)**: da la promoción exterior por tratada aquí. Es coherente porque se mantiene el bloque II.
  5. **3.B.33 (Word)**: «15 años» de litigio entre Airbus y Boeing. Las mismas fechas (2004-2019) en los 2 temas.
  6. **3.B.5 (en revisión en paralelo)**: deriva las curvas de oferta neta y las de indiferencia comercial; aquí se remite, con la misma notación. Refranes distintos.
  7. **4.A.24 y 4.A.25**: ICEX va al 4.A.25 (`mapa.yaml`); FIEM, CESCE y COFIDES, al 4.A.24.
- **Refranes**: «Arrieros somos y en el camino nos encontraremos» (enganche e idea final); como pegatinas, «Poderoso caballero es don Dinero», «A caballo regalado no le mires el diente», «Muerto el perro, se acabó la rabia», «Quien paga, manda» y «Dos no riñen si uno no quiere». Se comprobó que no los usa ningún otro tema. Quedan para añadir a CRITERIOS § 8 cuando se apruebe el tema.

## 7. Dudas abiertas

- **D1, título del III**: se aplicó la propuesta recomendada, «Comportamiento estratégico entre gobiernos: represalias y guerras comerciales». La alternativa es mantener el título original entero.
- **D2, bloque II**: se mantiene con 5′ aunque la promoción exterior ya no esté en el título de 2023, porque el 3.B.41 la da por tratada aquí. Si Víctor lo quitara, esa remisión del 3.B.41 quedaría rota.
- **D3, juego de Airbus y Boeing**: en el cuerpo van los números de Krugman (1987) (−5, 100 y subvención de 10). Los del anexo 1 de Víctor (−2, 5 y subvención de 5) están en el anexo C.
- **D4, minutos**: introducción 2′30″ y conclusión 1′. La alternativa es 2′ y 1′30″.
- **Meade sin anexo** (decisión del coordinador): la construcción de la relación real de intercambio, las curvas de oferta neta, las curvas de indiferencia comercial y las 4 condiciones de Pareto del original no se conservan en este tema. Se remiten al 3.B.5 (donde se derivan) y al 3.B.7 (arancel óptimo). CRITERIOS § 2 pide que lo que alarga vaya a un anexo y no desaparezca, así que conviene que Víctor confirme que basta con que esté en esos temas. Si no, se recupera como anexo con las erratas corregidas (lista en la sección 2).
- **Prórroga de la tregua de 2026** (Reglamento de Ejecución (UE) 2026/1549): está comprobada con fuentes secundarias (Gafta, Bloomberg, gov.uk), porque EUR-Lex devolvía una página antirrobots. No se sabe si es indefinida ni qué ha hecho Estados Unidos. El texto lo dice con prudencia: «mientras Estados Unidos no reactive los suyos».
- **El 33 % del acuerdo de 1992** sobre grandes aviones civiles no se ha confirmado en fuente primaria y se ha quitado.
- **Páginas sin comprobar**:
  - del capítulo de Brander y Spencer (1984) en el libro de Kierzkowski (el `.bib` va sin páginas);
  - de *Trade and Welfare* (Meade, 1955), donde está el argumento de que las economías de escala no bastan. La obra existe y está comprobada por sus reseñas.
- **Melitz (2005)**: no se ha leído el resumen. La frase de la valoración es cualitativa (el instrumento depende de cuánto y con qué rapidez se aprende, y de la sustituibilidad).
- **`Mill1909Principles`**: sale «Mill (1909)», la edición de Ashley, como en el 3.A.2. Si Víctor prefiere 1848, habría que cambiar la clave en los 2 temas.
- **Otras**:
  - La prohibición constitucional de los impuestos a la exportación en EE. UU. (art. I, sec. 9, cl. 5) va sin cita.
  - ICEX Sourcing se ha quitado porque no figura en las memorias de ICEX.
  - La serie de exportadores regulares de 2011-2016 tiene una sola fuente.
  - Dixit (1988) y Dixit y Kyle (1985) no se han podido comprobar en línea; son referencias habituales.
- **Decisiones del editor**:
  - Krugman (1984) va como extensión del I.3.1.
  - El impuesto se escribe $s_A<0$.
  - Solo hay 2 `\funcionclave`.
  - La nota 20 se conserva, traducida.
  - Para acortar el I, pasan a los anexos la forma de las funciones de reacción (anexo B), el desarrollo de Eaton y Kierzkowski (anexo D) y la industria naciente en equilibrio general (anexo E).
  - En III.3 no se repiten las cifras del enganche, de la relevancia ni de los aranceles de 2018.

- **Control de calidad (5/11/2026)**: 9 correcciones devueltas (Johnson: gana el de oferta neta más elástica, por comprobar en Johnson 1953-54; guerra de subvenciones: ganan las empresas y pierden los países; desborde de 83 pt en el anexo A; remisión de la l. 27; cita del párrafo de Airbus y Boeing en III.3; notación R_A′; conclusión; etiquetas de arancel-reciproco y sustitutos-complementos). Se ha aplicado:
  - **Introducción**: la remisión al 3.B.7 queda como «se estudian aparte \vertema{3.B.7}». El enganche ya no da «15 años» ni «17 años»: dice «años después» y «Detrás de ese pleito».
  - **Johnson**: corregido en III.2 y en la tabla de represalias, citando a Kennan y Riezman (1988; DOI 10.2307/2526808, nueva clave `KennanRiezman1988Big`). Falta comprobar la formulación en el texto de Johnson (1953-54). El pie del gráfico `johnson` añade «Caso simétrico: la RRI no cambia y los 2 pierden».
  - **Guerra de subvenciones**: las empresas ganan y los 2 países estarían mejor sin subvenciones.
  - **Anexo A**: la ecuación desbordada se parte en 2 y $3{,}5(a-c)^2/9b$ pasa a $7(a-c)^2/18b$.
  - **Notación**: $R_A'$ pasa a $R_A(q_B;s_A)$ en el texto, en la nota de Stackelberg y en la sección 8.
  - **III.3**: el párrafo de Airbus y Boeing cita los laudos DS316 y DS353 y la tregua (`USTR2021Aircraft` y `Gafta2026Aircraft`).
  - **Conclusión**: «lo normal es que los 2 países pierdan».
  - **Pies de gráficos**: el de `arancel-reciproco` dice que la curva desplazada, $R_B(q_A^A;t_A^*)$, es la del arancel óptimo $t_A^*=(a-c)/3$. En `sustitutos-complementos` no hay nada que cambiar: el texto de la nota no nombra el equilibrio (ni $B$ ni $p^B$) ni usa los subíndices 1 y 2.

## Enlaces del original (9/11/2026)

Repaso de los enlaces del Word original (CRITERIOS § 4). Los demás enlaces del original ya estaban en el tema.

- **Restaurados**:
  - Brander (1995), «Strategic Trade Policy», versión de libre acceso como NBER Working Paper 5020 (comentario del original: el modelo sale de sus págs. 38-42): `url`, `urldate` y `addendum` en `Brander1995Strategic`, que ya se cita en el tema.
  - Vídeo de Economicsfun que anima la curva de oferta neta (nota 33): «Para ver» en la nota de las curvas de indiferencia comercial de la guerra arancelaria de Johnson (III).
- **Ya conservados por otra vía**: JSTOR 2296310 es Hahn (1962), `Hahn1962Stability`, con su DOI (10.2307/2296310); la página general del *World Trade Report* de la OMC queda cubierta por `OMC2008WTR`, que enlaza directamente la sección C del informe de 2008 que recomendaba la nota del original.
- **No restaurados**: Policonomics, «Duopolio de Cournot» y «Duopolio de Stackelberg» (cajas de fuente del original): todas las páginas del sitio dan un error de WordPress (500) el 9/11/2026. Si vuelve, se pueden añadir como «Para ver» en los modelos de Cournot y Stackelberg.
- **No restaurado**: OMC, *Examen estadístico del comercio mundial 2023* (nota sobre el volumen del comercio mundial): la cifra que respaldaba se ha sustituido por la de 2025 (`OMC2026Perspectivas`). El enlace funciona; si Víctor quiere conservarlo como lectura, se añade al `.bib`.

## 8. Instrucciones para el vídeo

Todavía no hay vídeo: este tema se entrega sin guion ni escenas (entregas 1 y 2). Para cuando se haga:

- **Esquina fija de la pizarra**, desde el inicio del I y durante todo el cante:
  - la tabla de modelos (`tab:modelos`) vacía, que se rellena fila a fila;
  - las 2 funciones clave, `eq:reaccion-subvencion` y `eq:reaccion-arancel`, que se conservan con `conservar:`.
  - En III.1 se añade a la tabla la columna «si responden» (`tab:represalias`); no se escribe otra tabla aparte (nunca 2 veces lo mismo).
- **Gráficos a la pizarra**, por capas según `graficos-pedidos.json`:
  - `brander-spencer`: de $C$ a $S$ con la función desplazada $R_A(q_B;s_A)$;
  - `arancel-reciproco`: el del dumping recíproco con la función de reacción de la extranjera desplazada hacia el origen;
  - `industria-naciente`: las 8 capas del 3.B.6 más «protección temporal» y «apertura»;
  - las matrices de Airbus y Boeing, primero sin subvención y después cambiando la casilla de Airbus.
- **De palabra o con un boceto**: `eaton-grossman` (30″) y `johnson`, solo si sobra tiempo.
- **Apoyo, no se escriben en la pizarra**: la caja del caso lineal simétrico, `industria-naciente-fpp` (anexo E; 3 paneles, que puede «moverse» por paneles), `represalias-oligopolio` y la matriz de la guerra de aranceles del anexo A.
- **Ejemplo conductor**: Airbus y Boeing, en I.1 (por qué hace falta la teoría de juegos), I.2.3 (las matrices), I.4 (la variante de costes) y III.3 (la OMC y la tregua). Nunca se dice «hilo» en voz alta.
- **Enganche e idea final**: «Arrieros somos y en el camino nos encontraremos». La pregunta es «¿Puede un país ganar ayudando a sus empresas a competir fuera, si los demás pueden hacer lo mismo?» y la idea final la responde con el refrán.
- **Pegatinas**, que se apuntan al decirlas junto a su casilla: «Poderoso caballero es don Dinero» (compromiso), «A caballo regalado no le mires el diente» (el tercer país), «Muerto el perro, se acabó la rabia» (industria naciente), «Quien paga, manda» (captura) y «Dos no riñen si uno no quiere» (cooperación).
- **Bloque II**: un esquema de 3 casillas (objetivos, justificación e instrumentos), sin cifras en la pizarra.
- **Números de tema**: no se dicen en voz alta ni en la pizarra.
