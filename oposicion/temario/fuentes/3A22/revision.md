# Revisión del tema 3.A.22 — Economía del bienestar (I). Los teoremas fundamentales del bienestar. Óptimo económico y «second-best»

Revisión del 21/10/2026 (/revisartema, fase 3, integración), en 2 tandas: la primera, la introducción y los bloques I y II; la segunda, el bloque III, la conclusión, los 7 anexos y la bibliografía.

## Resumen

- El Word tenía ya el título de 2023, pero el contenido del anterior: los teoremas solo se mencionaban («no desarrollarlo con demostraciones») y los criterios de compensación ocupaban un bloque entero. Con la decisión **A22-01 (opción a)** el bloque 2 pasa a ser «Teoremas fundamentales de la economía del bienestar» y la compensación va entera a un anexo (anexo `anexo:compensacion`, parte 3), con una viñeta en I.3.
- Estructura de `propuestas-coherencia.md` (§ 5). Minutos (ajustados el 21/10/2026 al añadir el equilibrio general competitivo al 1TFEB): introducción 2′30″; I, 9′30″ (I.1, 1′; I.2, 6′30″; I.3, 2′); II, 10′ (II.1, 5′30″; II.2, 4′30″); III, 7′ (III.1, 3′; III.2, 1′30″; III.3, 1′30″; III.4, 1′); a petición de Víctor, 1′30″ más al I y menos al III; conclusión, 1′. Total, 30′.
- Bloque I: supuestos del 2×2×2×2 corregidos (como el 3.A.21), problemas de eficiencia con multiplicadores positivos, **un solo problema del planificador** con precios sombra que da las 3 condiciones (`\funcionclave`), FPP, FPU, GFPU, la FBS en mención y la valoración del criterio sin repeticiones.
- Bloque II: equilibrio de referencia, **1TFEB** (tabla de 5 supuestos, condiciones marginales, tabla planificador/mercado, prueba por reducción al absurdo) y **2TFEB** (supuestos con convexidad y condición de renta, intuición en la caja, demostración con el hiperplano separador, límites y soluciones), con estructura a)-c).
- Bloque III: teoría del *second best* con a)-c) (restricción no trivial, origen de la distorsión, resultado general con $\psi\neq1$, gráfico en la GFPU con F, P, Q, montaña, Davis-Whinston, Diamond-Mirrlees, Bhagwati-Ramaswami), aplicaciones rehechas, apartado nuevo de información y diseño de mecanismos (tabla `tab:mecanismos`) y valoración (sin la frase de Joan Robinson, que Víctor reserva para otro tema). Conclusión con sus 5 bloques; la idea final retoma el refrán «No hay mal que por bien no venga».
- Anexos: criterios de compensación (bloque 2 del Word, redactado de nuevo y corregido), curvas de contrato especiales, planificador general (con la caja de Maté y Pérez transcrita), demostraciones, *second best* analítico, qué estudia cada tema del bloque y test con preguntas del tribunal.
- Fuente nueva en LaTeX (`3A22.tex`), `3A22.bib` (106 entradas, base `bib-datos.bib`) y `seo.json`. Construido entero (PDF, web y Word) y `verificar-tema.py` sin errores: 25 págs. de tema, 12 de anexos y 4 de bibliografía. Hay 15 gráficos (2 reutilizados y 13 dibujados en TikZ), y el texto está ajustado a lo dibujado: rótulos $E=E_2$, $W_k$, $W^*$, $\vec{x}_A$, F, P y Q, los 9 casos de curvas de contrato y las letras de los gráficos de compensación.

## Errores corregidos

| Dónde | Decía | Dice ahora |
|---|---|---|
| Introducción, contextualización | «Ya en el siglo XIX, Jeremy Bentham» | A finales del siglo XVIII, Bentham (1789) |
| Introducción | «Jevons, Menger y Walras» con utilidad cardinal y reparto igualitario | Los marginalistas introducen la utilidad marginal decreciente; solo Jevons y Walras la tratan como cardinal; el argumento igualitario es de Edgeworth y Pigou (V6) |
| Introducción | Marshall «primer economista del bienestar propiamente dicho» | Marshall mide el bienestar con el excedente; Pigou (1920) funda la disciplina |
| Introducción | *Manual de Política Económica* (1906) | *Manuale di economia politica* (1906) (V7) |
| Introducción, problemática | «sin entrar a valorar si una asignación descentralizada constituye un sistema óptimo» (contradice el título) | Problemática y estructura nuevas (K8, K9) |
| I.1 | «Ya en 1971, Arrow y Hahn formalizan el concepto» | Formulación moderna de Arrow (1951) y Debreu (1959) (V9) |
| I.2, supuestos | Utilidades «ordinales» con «utilidad marginal positiva pero decreciente» | Preferencias completas, transitivas, continuas, estrictamente monótonas y convexas; se dice expresamente que la utilidad marginal decreciente no es ordinal |
| I.2, supuestos | Producción «cardinal», «segundas derivadas cruzadas positivas», condiciones de Inada (nota 19 en notación de crecimiento) y nota 18 con un marcador roto | Supuestos del 3.A.21 (continuas, crecientes, isocuantas convexas, conjuntos convexos); Inada y derivadas cruzadas, fuera |
| I.2, producción | Lagrangiana con μ negativo, $\lvert\mathrm{RMST}^K_L\rvert_X$ | λ > 0 con interpretación; $\mathrm{RMST}^X_{LK}$ (D035) |
| I.2, nota 23 | «La curva de contrato es una isoclina solo con funciones homotéticas» | Hace falta además la misma intensidad factorial a cualquier precio relativo (homotéticas idénticas salvo escala) |
| I.2, nota 25 | $\mathrm{RMT}=-(\mathrm{CMg}_X/\mathrm{CMg}_Y)$ | $\mathrm{RMT}_{XY}=\mathrm{CMg}_X/\mathrm{CMg}_Y$, positiva |
| I.2, nota 26 | Rendimientos decrecientes ⇒ «economías de alcance para producción conjunta» | Quitado (no hay producción conjunta); queda la nota de los beneficios y las participaciones θ_ij |
| I.2, eficiencia global | Problema que maximiza solo en $X_A$, $Y_A$ con «FPP: Y = F(X)»: no puede dar las 3 condiciones a la vez | Problema completo del planificador (8 variables, 5 restricciones) con multiplicadores $\lambda_U,\lambda_X,\lambda_Y,\lambda_L,\lambda_K$ (K11, C9) |
| I.2 | «modelo 2×2×2» (10 incógnitas) | 2×2×2×2 |
| I.2, nota 30 | Cita en inglés de HET con enlace a `paretocont.htm` | Paráfrasis con la página correcta (`HETParetoSocial`, V16) |
| I.2, nota 29 | «Según Samuelson (1962)…» (obra no identificada) | Se atribuye a HET; Allais (1943) y Samuelson (1950) con su referencia (V14, V15) |
| I.3 | «esto es lo que Baumol denominaba "tiranía de las minorías"» | Sin el nombre (no se ha encontrado la atribución) |
| I.3, nota 36 | Cualquier reparto del ultimátum sería «equilibrio de Nash perfecto en subjuegos» | Solo lo es ofrecer lo mínimo y aceptarlo (K19, P52) |
| I.3, nota 37 | Cifras del 40-50 % y del 50 % de rechazos atribuidas a Güth *et al.* (1982); «corroborando la teoría de Stigler (1981)» | Reparto a medias como moda en Güth *et al.*; metaanálisis de Oosterbeek, Sloof y van de Kuilen (2004): oferta media del 40 % y 16 % de rechazos (V30); Stigler, quitado (decía lo contrario, V31) |
| I.3, nota 43 | «Wicksell (1958)» como fecha del argumento | Sus reseñas de Pareto, recogidas en la edición póstuma de 1958, pp. 143 y 169 (V34) |
| II (antes 1.3), 1TFEB | Supuestos de equilibrio parcial de MWG («el bien no numerario dispone de un precio») y «rendimientos no crecientes, pues en caso contrario no existe solución» | Supuestos de equilibrio general (MWG § 16.C) en una tabla; se dice que el 1TFEB no necesita convexidad ni condición sobre los rendimientos |
| II, nota 38 | «Desarrollado por Abba Lerner y formalizado por Arrow y Debreu» | Lerner (1934, 1944) y Lange (1942); pruebas de Hotelling (1938) y Allais (1943); Arrow (1951) y Debreu (1951, 1954) (V10) |
| II, nota 40 | $w/r$, $\lvert\mathrm{RMS}^y_x\rvert$, x minúsculas | $w_L/w_K$, $\mathrm{RMS}^A_{XY}$, X e Y (integrado en el desarrollo del 1TFEB) |
| II, 2TFEB | Dotación $e$, $e'$; «el planificador central» | $\vect{\omega}$, $\vect{\omega}'$ (D045); «el Estado» (en el 2TFEB solo redistribuye) |
| Notas 10 y 34 | Motivaciones de los Nobel aproximadas; Arrow solo | Motivaciones literales; Arrow con Hicks (V11, V12) |
| Nota 6 (Dupuit) | 1884 | 1844 (V4) |
| Erratas | «Primer Teorema del Fundamental», «linear», «no se hayan», «en con el objetivo» | Corregidas |
| III, título | «Teoría del second best (Lipsey y Lancaster, 1956)», propuesta «por Meade (1955)» | Anticipada por Meade (1955) en las uniones aduaneras y formalizada por Lipsey y Lancaster (1956) |
| III | La analogía de la montaña «propuesta por Meade» | Se cita a Gandolfo (2014), de donde sale el gráfico (no se ha encontrado en Meade; V51) |
| III, gráfico | Puntos A, B, C en el espacio $(U_A,U_B)$, donde A y B son los consumidores | F, P, Q (K7) |
| III, valoración | Mishan: «el *second best* solo afecta a las condiciones de eficiencia global» | Quitado (tesis no comprobada, V26); en su lugar, el resultado comprobado de Diamond y Mirrlees (1971) en las extensiones |
| III.2 | Títulos con «[Temas 3.B.8 y 3.B.17]» y «[Tema 3.A.20]» | Remisiones en el texto: 3.B.8 (industria naciente), 3.B.28 (Rodrik), 3.B.17 (crisis asiática), 3.A.17, 3.A.23 y 3.A.20 (monopolio contaminante) (K22) |
| III.2, FMI | «cuando estaba a punto de incorporar… la crisis que se inició… aquel otoño» (orden invertido) | La crisis empieza en julio de 1997; en septiembre el Comité Provisional aún aprobó en Hong Kong la propuesta de enmienda (V28). No se afirma que la enmienda se abandonara (sin fuente del FMI legible) |
| III.2 | «brecha entre el nivel de precios doméstico y la RRI» | Reescrito sin la sigla (K29) |
| III.1, nota 53 | Impuesto sobre Netflix presentado como real | Ejemplo hipotético; el impuesto sobre determinados servicios digitales no grava esas suscripciones (V35) |
| Anexo 2 (*second best*) | Restricción $U_1-\beta T_1=0$ con «$\lambda\neq\beta>0$»; «la maximización ya no se alcanzará necesariamente sobre la FPP» | Restricción sobre los cocientes, $U_1/U_n=\psi T_1/T_n$; el segundo óptimo sigue en la frontera, lo que deja de cumplirse es RMS = RMT en los demás bienes (C24) |
| Nota 56 | Excepción solo con utilidad aditiva y tecnologías lineales | Basta la separabilidad ($\Psi_k=\Psi_n=0$, Davis y Whinston) |
| Anexo 1, caso 3 | «Para que exista curva de contrato es necesario que las proporciones de complementariedad sean iguales… a la diagonal» | Los óptimos siempre existen: la diagonal si los vértices coinciden; si no, la zona entre los 2 rayos (C22) |
| Anexo de compensación | «Criterio de Kaldor-Hicks (1941)» | Doble criterio de Scitovsky (1941) (V17) |
| Anexo de compensación | Samuelson, «aportación trivial, ya que el criterio de Pareto sí nos permite comparar» | Compara situaciones (fronteras), no asignaciones: no es trivial (C21) |
| Anexo de compensación | Little: «tanto el punto 2 como el punto 6» cumplen Kaldor y Hicks | Los cumplen 2, 3, 4, 5 y 6 (tabla del propio gráfico); Little se queda con 2, 4 y 5 (C21) |
| Anexo 3 | Atribuía el 2TFEB al 3.A.24 | Sustituido por «Qué estudia cada tema del bloque», gemelo del 3.A.16 (K20, X7) |
| Conclusión | Relevancia, Extensiones y Opinión vacías; «CONCLUSI**Ó**N» | Completas (C20, K10) |
| Bibliografía | Temas de ICEX-CECO, A. Sahuquillo y J. L. Cordero | Quitados: solo obras originales y manuales (P54) |

Verificación de datos del 22/10/2026 (`_trabajo/verificacion-21oct.md`; 9 afirmaciones de la evidencia empírica del 1TFEB, 8 correctas):

| Dónde | Decía | Dice ahora |
|---|---|---|
| II.1 (1TFEB), d) Evidencia empírica, Smith (1962) (D1) | «convergen en pocas rondas [...] y se aprovecha casi todo el excedente posible» (Smith mide la convergencia de los precios, no la eficiencia) | «convergen en pocos periodos de negociación [...], siempre que no haya colusión y todas las pujas sean públicas» (Smith, 1962, p. 134, conclusión 1) |

No se aplica D2 (atribuir la eficiencia casi del 100 % también a los mercados con personas de Gode y Sunder): solo se ha podido leer el resumen del artículo, que lo afirma de los programas con restricción; la frase de Gode y Sunder se queda como estaba. La ficha de repaso no cambia: no decía nada del excedente.

## Marcas resueltas

| Marca | Texto original | Qué se hizo |
|---|---|---|
| P1 (amarillo, 2TFEB) | «Si se parte de una dotación inicial e y el planificador central pretende alcanzar el punto eficiente E′…» | Explicación comprobada (correcta) e integrada en II.2 b) ii) con $\vect{\omega}\to\vect{\omega}'$ y el gráfico `caja-intercambio-teoremas` del 3.A.21 (que no existía en el Word); además, el gráfico pedido `segundo-teorema-gfpu` |
| P8 (rojo, nota del bloque 2) | «Con el cambio de temario esto desaparece del título…» | Desaparece; el bloque 2 pasa a ser el de los teoremas (A22-01) |
| P9 (notas iniciales y ficha del tribunal) | Aviso del cambio de temario y encargo de demostrar los TFEB | Desaparecen; el encargo es el bloque II |
| P10 (nota y comentario en la FBS) | «Esto corresponde al tema 3.A.24, aquí únicamente mencionar la idea» | FBS en 4 viñetas con gráfico de apoyo y \vertema{3.A.24}; Sen y Rawls pasan a la crítica distributiva |
| P13, P16, P18, P20 (comentarios privados) | Clases, correo de la bibliografía, «no desarrollarlo con demostraciones» | No se publican; P20 (planificador como el equilibrio general del 3.A.21) se aplica en I.2 y en la tabla planificador/mercado |
| P15 (notación) | Seguir la notación de la caja de «Resolución analítica» | Notación del canon (D035, D045, D020) |
| P17 (comentario) | ¿Sen y Rawls mejor en Little? | En la crítica 4 del criterio de Pareto (I.3) y en 3.A.24 |
| P21 (instrucciones entre corchetes) | «[aprovechar el existente en pizarra]»; «[mencionar brevemente, del tema 3.A.23, cómo la competencia perfecta iguala las RMS…]» | Lo primero, a las instrucciones del vídeo; lo segundo es ahora el desarrollo del 1TFEB en el 2×2×2×2 |
| P22 (caja de anotaciones con capturas de Maté y Pérez) | Tres capturas con fórmulas | Su planteamiento es ahora el problema del planificador del cuerpo; en el cuerpo queda una caja `anotaciones` que lo resume. La transcripción completa va al anexo `anexo:planificador-general` (parte 3) |
| P37 (tabla de Inada) | Nota 19 | Fuera: no hace falta para el óptimo |
| P38, P57 (estructura vacía, introducción contradictoria) | — | Introducción nueva con sus cinco bloques, esquema y reparto |
| P49 (remisiones a mano) | «[ver nota al pie 29]», «página 11», «Imagen 5…» | Todas con `\ref`/`\eqref` |
| P52 (ultimátum) | Nota 36 errónea | Versión del 3.A.14, en nota de la crítica distributiva |
| P56 (Wikipedia, nota 7) | Enlace a «Ofelimidad» | Nota con Pareto (1906) y HET |
| Nota 4 (Pigou) | «El principal motivo del análisis económico es contribuir a la mejora social» | No está literal en el libro: sustituida por la cita comprobada de la parte I, cap. I, § 1 (V2, C26) |
| Notas 1, 2, 3, 5, 8, 9 y 33 | Individualismo, tecnologías del consumo, tareas de Koutsoyiannis, estado estacionario, *New New Welfare Economics*, UPC/UPF | Quitadas con la introducción nueva (C28, V49: las tareas y páginas de Koutsoyiannis no se han podido comprobar) |
| P2 (amarillo, compensación potencial) | «suponen compensaciones potenciales, no efectivas, lo que conlleva implícita una comparación interpersonal…» | Correcta: integrada en la valoración del anexo de compensación, con Little (1950) |
| P3 (amarillo, cita en inglés de HET) | «The L.S.E. position is a bit braver…» | Parafraseada en castellano en la idea del anexo; la frase «liberal o socialista… cristiano o pagano» se atribuye a Hicks (1939) a través de HET (V22) |
| P4 (Inman) | «Inman» | Inman (1987), *Handbook of Public Economics*: lectura recomendada en la bibliografía (`\nocite`) |
| P5 (Gaertner) | «Gaertner» | Es teoría de la elección social (3.A.24): no se incluye |
| P6 (amarillo en la nota 41) | Usar la frase de Pareto en la conclusión junto a la de Pigou | Hecho en la idea final, parafraseada (no se ha localizado el pasaje en el *Manuale*, V33) |
| P7 (comentario, Lipsey y Chrystal pág. 414) | — | No consultado (sin acceso al manual); se usa Lipsey (2007), que revisa la teoría a los 50 años |
| P11, P13, P14, P19 (notas y comentarios de la compensación) | Scitovsky, Gorman, Samuelson; gráficos individuales; versión con producción | Orden Kaldor, Hicks, Scitovsky, Little, Samuelson, Gorman; un gráfico por criterio; versión en el espacio de utilidades (basta en un anexo) |
| P12 (enlace HET) | — | Funciona: en `anotaciones` del anexo |
| P32 (cajas de Fonseca en la nota 45) | — | Quitadas con la nota; enlace a HET en el anexo |
| P35 (curvas de contrato especiales) | 8 dibujos sin título | Un gráfico con 8 cajas pedido |
| P42 (*second best* incompleto) | Faltaban resultado general, origen de la distorsión e información | III.1 y III.3 nuevos |
| P44 (anexo 3) | — | Ver errores |
| P55 (test) | quia.com; «Preguntas de otros exámenes» vacío | Enlace genérico al simulador; preguntas probables del tribunal en el anexo de test |
| P59 (conclusión) | — | Completa |

## Datos actualizados

El tema es teórico: no hay series. Los datos cambiados son atribuciones y fechas (tabla de `propuestas-datos.md`; URL sacadas del `.bib`; todas las consultas, el 21/10/2026):

| Dato | Anterior | Nuevo | Fuente | URL | Consulta | Segunda comprobación |
|---|---|---|---|---|---|---|
| Régimen definitivo del MAFC (enganche) | — | 1/1/2026 | Reglamento (UE) 2023/956 (`UE2023CBAM`) | http://data.europa.eu/eli/reg/2023/956/oj | 21/10/2026 | Ficha canon `cbam` |
| Cita de Pigou | frase no literal | parte I, cap. I, § 1 | Econlib (`Pigou1920Economics`, V2) | https://www.econlib.org/library/NPDBooks/Pigou/pgEW1.html | 21/10/2026 | búsqueda en el texto |
| Atkinson | sin fuente | Atkinson (2001, 2011) | Crossref (V3) | https://doi.org/10.1111/j.0023-5962.2001.00148.x ; https://doi.org/10.1257/aer.101.3.157 | 21/10/2026 | OpenAlex |
| Bentham | siglo XIX | 1789 | Wellcome Collection (V5) | https://works.www.wellcomecollection.org/works/u2ctu354 | 21/10/2026 | UCL Bentham Project |
| Pareto en Lausana | sin año | 1893 | HET (V8) | https://www.hetwebsite.net/het/profiles/pareto.htm | 21/10/2026 | Britannica |
| Formalización de los teoremas | Arrow y Hahn, 1971 | Arrow (1951), Debreu (1951, 1954, 1959) | Crossref (V9, V10) | https://doi.org/10.1073/pnas.40.7.588 | 21/10/2026 | HET |
| Nobel de Arrow y de Sen | motivaciones aproximadas | literales | nobelprize.org (V11, V12) | https://www.nobelprize.org/prizes/economic-sciences/1972/summary/ ; https://www.nobelprize.org/prizes/economic-sciences/1998/summary/ | 21/10/2026 | notas de prensa |
| FPU y GFPU | «Allais y Samuelson» | Allais (1943), Samuelson (1950) | HET (V14) | https://www.hetwebsite.net/het/essays/paretian/paretosocial.htm ; https://doi.org/10.1093/oxfordjournals.oep.a041383 | 21/10/2026 | Crossref |
| Ultimátum | 40-50 %, 50 % de rechazos | moda del 50 % (Güth *et al.*); 40 % y 16 % (metaanálisis) | Crossref (V30) | https://doi.org/10.1023/B:EXEC.0000026978.14316.74 | 21/10/2026 | OpenAlex |
| Dupuit | 1884 | 1844 | `Dupuit1844Mesure` (V4) | — (revista impresa) | 21/10/2026 | 3.A.9 |
| Crisis asiática y FMI | «aquel otoño» | flotación del bat el 2/7/1997; Comité Provisional del 21/9/1997 | FMI (`FMI1997HongKong`) | https://www.imf.org/en/news/articles/2015/09/28/04/51/cm970921 | 21/10/2026 | Banco de Tailandia: https://www.bot.or.th/en/our-roles/special-measures/Tom-Yum-Kung-lesson.html |
| Referencias del bloque III | sin referencia | Viner (1950), Meade (1955), Lipsey (1957), Rodrik (2008), Davis y Whinston (1965) | Crossref y Open Library (V24-V29) | https://doi.org/10.1257/aer.98.2.100 ; https://doi.org/10.2307/2296327 ; https://doi.org/10.2307/2296233 | 21/10/2026 | OpenAlex, IDEAS |
| Impuesto sobre servicios digitales | ejemplo como real | no grava las suscripciones de vídeo | BOE, Ley 4/2020 (V35) | https://www.boe.es/buscar/act.php?id=BOE-A-2020-12355 | 21/10/2026 | XML del BOE |

## Contenido añadido

- **Introducción** completa (C1, K8, K9, K12): refrán «No hay mal que por bien no venga» (decisión de Víctor; sustituye a «Lo mejor es enemigo de lo bueno») con el MAFC como hecho actual; Pigou y Atkinson en la relevancia; contextualización corregida; problemática y estructura.
- **Esquema y nota al opositor** con el reparto de minutos (K9, C3).
- **I.2**: supuestos del 2×2×2×2 como el 3.A.21 (C6); problemas de producción y consumo con multiplicadores positivos e interpretados (C7, C8); problema del planificador con precios sombra y las 3 condiciones como función clave (K11, C9); FBS en mención con el punto de felicidad y los puntos a-d (K18).
- **I.3**: ventajas y críticas una sola vez (C11), Sen con su obra, Huerta de Soto para la eficiencia dinámica, viñeta de las respuestas a la incompletitud con remisión al anexo de compensación (K17).
- **II**: equilibrio de referencia y transferencias de suma fija (C12); 1TFEB con tabla de supuestos (K21), condiciones en el 2×2×2×2, tabla planificador/mercado y prueba general en 5 pasos (C13); 2TFEB con condición de renta, demostración con el hiperplano separador (Minkowski), límites (información, convexidad, cálculo, multiplicidad) y soluciones (Ramsey, Mirrlees, Diamond-Mirrlees, Atkinson-Stiglitz, *tagging*) (C14, K25).
- Fuentes nuevas: las de `bib-datos.bib` y, de las propuestas de contenido (C38), Minkowski (1911), Diamond y Mirrlees (1971), Atkinson y Stiglitz (1976), Akerlof (1978), Huerta de Soto (2004), UE (2023) y las que usará el bloque III.

- **Bloque III**: teorema general con la notación de coherencia ($\psi$, $\lambda_1$, $\lambda_2$, $\Psi_k$; CC3-CC4) y el origen de la distorsión; aplicaciones con la fórmula del impuesto óptimo al monopolio contaminante ($t^*=\mathrm{CMgE}-p/\lvert\varepsilon\rvert$, Buchanan, 1969; Barnett, 1980), Corlett-Hague, Ramsey-Boiteux, monopolio natural impugnable y variedad óptima (K14); eficiencia restringida (Hart, 1975; Greenwald y Stiglitz, 1986), mecanismos en estrategias dominantes (VCG, Green-Laffont, Gibbard-Satterthwaite) y bayesianos (d'Aspremont-Gérard-Varet, Arrow, 1979; Myerson-Satterthwaite) con la tabla `tab:mecanismos` (K28); la frase de Joan Robinson se quitó de la valoración (decisión de Víctor).
- **Anexos**: compensación con 2 tablas de cumplimiento pasadas a LaTeX desde las imágenes 7 y 8; planificador general (MWG § 16.F) y transcripción de la caja de Maté y Pérez Domínguez en 4 bloques A-D con la notación del tema; demostraciones paso a paso (MWG prop. 16.C.1, 16.D.1 y 16.D.2); *second best* analítico corregido.

### Estado de las propuestas (parte 1)

**Contenido (C)**

| Propuesta | Estado |
|---|---|
| C1 | Aplicada, con la problemática y la estructura de coherencia (K8, K9) y la cita de Pigou y Atkinson de datos (V2, V3) |
| C2 | Aplicado el refrán recomendado (decisión del coordinador); después Víctor eligió «No hay mal que por bien no venga» y la frase de Robinson no va en este tema |
| C3 | Aplicada con el texto de coherencia (K9) |
| C4 | Aplicada la idea; título del bloque I el del Word («Óptimo económico. Criterio de Pareto»), como pide coherencia |
| C5 | Aplicada; título del subapartado el del Word. Gravelle y Rees sin capítulo (no comprobado, duda de C5) |
| C6 | Aplicada; la nota «\vertema{3.B.6}» sobre la FPP convexa no se aplica (no está comprobado que ese tema lo trate); la idea queda en el texto |
| C7 | Aplicada; el gráfico es el del 3.A.11 reutilizado (`caja-edgeworth-fpp`, sin la capa de la FPP desplazada), no uno nuevo `caja-produccion-fpp` (K30) |
| C8 | Aplicada; gráfico `caja-consumo-fpu` (nombre de coherencia) |
| C9 | Aplicada con la notación de coherencia ($\lambda_U$ en lugar de $\lambda_B$, CC4); gráfico `gfpu` |
| C10 | Aplicada en parte: la FBS va al final de I.2 (K18) y el ultimátum a la crítica distributiva de I.3 (K19), con las cifras de datos (V30) en lugar de las de Camerer (2003) |
| C11 | Aplicada; las críticas siguen el orden del Word y de coherencia (la incompletitud la última, para enlazar con la compensación) |
| C12 | Aplicada; minutos de II, 9′ (coherencia) en lugar de 9′30″; origen con Hotelling y Allais (V10) |
| C13 | Aplicada; supuestos en la tabla de coherencia (K21, orden 1-5 que copiará el 3.A.23) y paso 5 de la prueba con la factibilidad como desigualdad |
| C14 | Aplicada; enunciado citado con Debreu (1954); el gráfico `2tfeb-gfpu` se llama `segundo-teorema-gfpu` |
| C26, C27, C29, C30, C31, C33 | Aplicadas en lo que toca a la parte 1 (la cita de Pareto de la nota 41 va a la conclusión, parte 2) |
| C28 | Aplicada (notas quitadas; la 7 con Pareto y HET) |
| C15 | Aplicada la idea; título del bloque III el del esquema de coherencia («La teoría del *second best*») |
| C16 | Aplicada con la estructura de coherencia: a) Idea, b) Modelo, c) Extensiones en III.1, y la valoración como III.4 (K27); notación $\psi$, $\lambda_1$, $\lambda_2$, $\Psi_k$ (CC3) en lugar de $1+t$, $\lambda$, $\lambda_D$, $Q_k$; puntos F, P, Q (K7) en lugar de A, B, C; «óptimo restringido» pasa a III.3 |
| C17 | Aplicada; la industria naciente remite al 3.B.8 y no al 3.B.7 (K22, K31: el 3.B.7 no la trata); FMI con la redacción de datos (V28), sin afirmar que la enmienda se abandonó ni citar el informe de la IEO |
| C18 | Aplicada, con la tabla `tab:mecanismos` de coherencia (K28) |
| C19 | Aplicada (A22-02, opción a), en III.4 |
| C20 | Aplicada, con la relevancia y la opinión de coherencia (K10) |
| C21 | Aplicada; Little citado con 1949 y 1950 (V21: el criterio aparece en los 2); tablas de cumplimiento en LaTeX |
| C22 | Aplicada |
| C23 | Aplicada; el «contraejemplo de Arrow (1951)» no se nombra (sin comprobar), se cita MWG prop. 16.D.2 |
| C24 | Aplicada con la notación de coherencia ($\psi$ en lugar de $1+t$) |
| C25 | No aplicada: se usa el texto de coherencia (K20), gemelo del anexo D del 3.A.16 |
| C32, C34-C38 | Aplicadas (C34: Inman como lectura con `\nocite`, Gaertner fuera) |

**Coherencia (K)**: K1-K14 y K17-K30 aplicadas. K15 y K16 (coordinación con el 3.A.23 y el 3.A.24) y K31-K34 (`mapa.yaml`) y CC1-CC5 (canon) son para la fase canon. K30: todos los gráficos de su tabla pedidos o reutilizados (la compensación en 5 gráficos, como pide P14).

**Datos (V)**: V2-V12, V14-V35, V39, V41 y V51 aplicadas (V26: Mishan quitado; V28: sin afirmar la retirada de la enmienda; V31: Stigler quitado). **V1 no aplicada**: la definición de Marshall alargaba un enganche que ya tiene refrán, hecho actual y pregunta (la introducción debe durar 2′30″); Marshall queda en la contextualización con el excedente. V13 (Arrow, 1951, imposibilidad), en las extensiones de la conclusión. V42 (Gaertner), no se usa. V36 y V37: las notas que las usaban se quitan.

## Cambios pedidos por Víctor (21/10/2026)

- **Enganche (MAFC)**: «Lo mejor sería un precio mundial del carbono» pasa a «Lo mejor sería que todo el que emite, en cualquier país, pagara lo mismo por cada tonelada de CO₂, un precio igual al daño marginal que causa, con un impuesto o con un mercado mundial de derechos de emisión; como no existe, la Unión grava en la frontera…». La expresión no se repetía en la idea final ni en otro sitio del tema (sí en `3A22.lyx`, que se regenera, y en `_trabajo/`).
- **Tabla `tab:supuestos-1tfeb`, fila 3**: «poder de mercado \vertema{3.A.17} \vertema{3.A.18} \vertema{3.A.19}». Por coherencia, también en la viñeta del poder de mercado de la valoración del 1TFEB.
- **El equilibrio general competitivo hilado en el 1TFEB** (II.1, `sec:primer-teorema`), redactado de nuevo a partir del desarrollo del 3.A.23 antiguo de Víctor (`tercer-ejercicio/3A23-anterior.docx`, «Construcción del modelo de Equilibrio General Competitivo»). El subapartado pasa a tener los 5 bloques de un modelo:
  - a) *Idea*: el planificador resolvía un problema enorme; ahora cada agente resuelve el suyo mirando solo precios, y los precios reparten el trabajo del planificador;
  - b) *Modelo: el equilibrio general competitivo 2×2×2×2*: i) supuestos (la economía de Bator de I.2 más mercados, precios dados, rentas $\overline{W}_A=w_L\overline{L}_A+w_K\overline{K}_A+\theta_{AX}B_X+\theta_{AY}B_Y$, conducta maximizadora; la tabla de 5 supuestos; lo que no hace falta y lo que se añade para derivar); ii) desarrollo en 4 pasos: consumidores (`eq:egc-consumidores`, $\mathrm{RMS}^A=p_X/p_Y=\mathrm{RMS}^B$), empresas en los factores (`eq:egc-empresas`, $\mathrm{RMST}^X=w_L/w_K=\mathrm{RMST}^Y$), empresas en los bienes (`eq:egc-global`, $p_X/p_Y=\mathrm{CMg}_X/\mathrm{CMg}_Y=\mathrm{RMT}$) y vaciado de los mercados con la ley de Walras; resultado (`eq:egc-condiciones`) comparado con \eqref{eq:condiciones-pareto} y cerrado con «es el 1TFEB en el modelo 2×2×2×2» y ∎; la tabla `tab:planificador-mercado` gana la columna «Quién la cumple» (con el paso); caja `ideaclave` (un problema con toda la información frente a 4 pequeños que solo comparten los precios); interpretación gráfica en la caja y en la GFPU; iii) implicaciones (sin cambios);
  - c) *Extensiones*: la prueba general por reducción al absurdo (antes en el desarrollo), con $I$, $J$ y $n$ y sin derivadas, y el equilibrio con transferencias como puente con el 2TFEB;
  - d) *Evidencia empírica* (nueva): subastas dobles de Smith (1962), Gode y Sunder (1993) con agentes de «inteligencia cero» y el Nobel de Smith (2002); claves nuevas `Smith1962Experimental`, `GodeSunder1993Allocative` (comprobadas en Crossref) y `Nobel2002Smith` (motivación comprobada en nobelprize.org);
  - e) *Valoración* (antes c), sin cambios salvo el \vertema{3.A.18}.
  - No se repite el problema del planificador: se remite a \eqref{eq:planificador}, a \eqref{eq:condiciones-pareto} y al anexo `anexo:planificador-pasos`.
  - No hay ejemplo conductor en el 3.A.22 (los consumidores $A$ y $B$ y las empresas $X$ e $Y$ del 2×2×2×2 hacen de hilo), así que no se añade ninguna viñeta de ejemplo.
  - Pregunta nueva del tribunal en `anexo:test`: qué agente cumple cada condición y para qué hace falta el vaciado.
  - Esquema, estructura de la introducción y nota al opositor puestos al día (minutos de arriba; los 4 pasos se escriben en la pizarra debajo de las 3 condiciones).
- **Qué debe hacer el 3.A.23** (no se toca; para su próxima pasada): su `sec:egc-teoremas` ya resume en 2 viñetas lo que hace cada agente y remite al 3.A.22; basta con que diga «(paso a paso en \vertema{3.A.22})» o similar. Su `anexo:condiciones-2x2` repite el planificador y el equilibrio como recordatorio para las derivaciones de externalidades y bienes públicos; puede quedarse así (es un recordatorio con la misma notación: $\lambda_U$, $\lambda_X$…, $p_j\,\mathrm{PMg}^j_L=w_L$), sin pasos ni tabla.

## Coherencia

- Notación del canon: $\mathrm{RMS}^A_{XY}$, $\mathrm{RMST}^X_{LK}$, $\mathrm{RMT}_{XY}=\mathrm{CMg}_X/\mathrm{CMg}_Y$ positivas y en redonda (D035); $\vect{\omega}$, $\vect{\omega}'$ (D045); $F_X(L_X,K_X)$; $\overline{U}_B$; $W(U_A,U_B)$ con argumentos; λ con subíndice (D020). Símbolos locales que se proponen al canon (CC4): $\lambda_U,\lambda_X,\lambda_Y,\lambda_L,\lambda_K$ del planificador; $T_i$ (transferencias, $\sum_iT_i=0$), $V_i$, $V$ y $\mathcal{Y}$ en la demostración del 2TFEB.
- Gráficos reutilizados: `caja-edgeworth-fpp` del 3.A.11 (copiado sin la capa 10) y `caja-intercambio-teoremas` con su maestro `caja-intercambio` del 3.A.21 (copiados tal cual).
- Mismas claves bibliográficas que el 3.A.21 para Pareto, Lerner, Lange, Arrow, Debreu, Bator, Feldman, Wicksell y Segura; el origen de los teoremas se cuenta con sus mismas palabras.
- La tabla de supuestos del 1TFEB (5 filas, `tab:supuestos-1tfeb`) es la que el 3.A.23 debe copiar marcando en salmón la fila 2 (mercados completos) con «Se levanta» (K15, CC2). El 3.A.21 tiene 4 (sin la información perfecta): matiz opcional en `pendientes-coherencia.md` (CC2), lo anota la fase canon.
- El 1TFEB y el 2TFEB se desarrollan aquí (tema de referencia, ficha `teoremas-bienestar`); el 3.A.21 los resume (duplicado de la demostración del 1TFEB aceptado por Víctor el 17/10/2026).
- Contradicciones con otros temas (no se tocan; ver `propuestas-coherencia.md` § 9): 3.A.23 y 3.A.24 sin revisar repiten el 2×2×2×2, las críticas de Pareto y atribuyen el 2TFEB al 3.A.24; `mapa.yaml` propone 3.B.7 para la industria naciente cuando es el 3.B.8.

- Las conclusiones del 3.A.23 y del 3.A.24 no deben repetir el cierre de Pigou y Pareto ni el refrán «No hay mal que por bien no venga».
- `mapa.yaml`: añadir al 3.A.22 los modelos `diseno-mecanismos`, `clarke-groves`, `gibbard-satterthwaite`, `industria-naciente` y `ramsey-boiteux`, y crear la ficha `criterios-compensacion` con el 3.A.22 (anexo) como tema de referencia (K33, CC1).

## Dudas abiertas

- **Gode y Sunder (1993)** y **Smith (1962)**: referencias comprobadas en Crossref; el contenido («eficiencia casi completa», convergencia en pocas rondas) es el resultado conocido de los 2 artículos, sin cifra exacta ni página: no se ha leído el texto completo.

- **Gravelle y Rees** (juicios de valor): citados sin capítulo; los «4 juicios de valor» no se han podido comprobar en el libro (V49).
- **Sen (1970)**: la frase del lujo y la inanición, sin página (V32).
- **Maté y Pérez Domínguez (2007)**: la caja del planificador, sin capítulo; además hay 2 claves para el mismo libro en el temario (`MatePerez2007Microeconomia` y `MateGarciaPerezDominguez2007`): se usa la primera (V50).
- **Koutsoyiannis**: «pp. 544 y ss.» del pie de la GFPU sin comprobar: se cita sin página.
- **Minkowski (1911)** como referencia del teorema de separación: si Víctor prefiere no citarla, basta con el nombre del teorema.

- **Cita de Pareto en la idea final**: va parafraseada y sin página. No se ha localizado el pasaje en el *Manuale* (V33).
- **Stiglitz (2002)**: «la mano invisible parece invisible porque no está», parafraseada sin comillas.
- **Lipsey (2007)**: solo se ha visto su ficha; la frase que se le atribuye es prudente.
- **Davis y Whinston (1965)**: referencia comprobada, contenido leído solo en fuentes secundarias (V25).
- **Little (1950), p. 90**: la página viene de HET (2.ª ed.).

## Instrucciones para el vídeo

- **Minutos nuevos** (21/10/2026): I, 8′; II, 10′ (II.1, 5′30″); III, 8′30″ (III.3, 2′). El guion y las escenas hay que ajustarlos.

- **Enganche e idea final**: tras leer el título, «No hay mal que por bien no venga», dice el refrán (si una distorsión no se puede quitar, añadir otra puede mejorar), y el MAFC como solución de segundo óptimo; pregunta: ¿asigna bien los recursos un mercado competitivo y, si una condición falla, conviene cumplir las demás? La idea final retoma el refrán: una distorsión bien elegida puede compensar otra que no se puede quitar, pero solo quien sabe cuál es el óptimo sabe qué mal trae un bien. El refrán se apunta en la pizarra junto al *second best*.
- **Introducción**: sin pizarra (modo guion).
- **I.1**: definición en una línea en la pizarra; los 4 juicios de valor, como guion.
- **I.2**:
  - supuestos en una lista corta (apoyo);
  - `caja-edgeworth-fpp` en boceto rápido (unos 30″): caja, curva de contrato y FPP con la RMT (capas 1-2-3-5-6-7-9; el punto A, opcional);
  - el problema del planificador \eqref{eq:planificador} se escribe **una vez** (es el «existente en pizarra» del Word) y se marcan con color los 2 subproblemas (producción y consumo); los 2 problemas parciales, como apoyo;
  - las **3 condiciones** (`\funcionclave`, `eq:condiciones-pareto`) se escriben recuadradas en una esquina y **se conservan hasta el final del bloque II**;
  - **`gfpu` es el gráfico central del bloque y se construye por partes**: panel izquierdo (FPP, punto E, caja inscrita, E* con RMS = RMT) y después el derecho (FPU de 3 puntos y la GFPU como envolvente);
  - `caja-consumo-fpu` y `fbs-gfpu`: apoyo (no se dibujan).
- **I.3**: lista de 2 columnas «+ / −» (3 ventajas, 5 críticas) en la pizarra; la compensación y la FBS, de palabra.
- **II.1**:
  - la tabla de supuestos `tab:supuestos-1tfeb` en la pizarra, solo con las 5 palabras clave y el fallo de cada una (el resto, apoyo);
  - el equilibrio general competitivo en **4 pasos**, escritos **debajo** de las 3 condiciones recuadradas de I.2, cada uno junto a la condición que cumple: (1) el problema del consumidor con su restricción presupuestaria → $\mathrm{RMS}^A=p_X/p_Y=\mathrm{RMS}^B$; (2) el beneficio de la empresa → $\mathrm{RMST}^X=w_L/w_K=\mathrm{RMST}^Y$; (3) $p_j=\mathrm{CMg}_j$ → $p_X/p_Y=\mathrm{RMT}$; (4) vaciado, de palabra. Al final se tachan los λ de las condiciones recuadradas y se escriben encima los precios: los precios hacen de precios sombra (la tabla planificador/mercado, con la columna «quién la cumple», es el apoyo); la `ideaclave`, como apunte;
  - la prueba general por reducción al absurdo (extensiones) en 4-5 líneas cortas, con el ∎, solo si sobra tiempo; si no, de palabra;
  - la evidencia (Smith, Gode y Sunder), de palabra, en 2 frases;
  - `caja-intercambio-teoremas` en la pizarra hasta la capa 7 (E en la curva de contrato).
- **II.2**:
  - se completa la **misma caja** con la capa 8 ($\vect{\omega}\to\vect{\omega}'$, E′): no se dibuja otra;
  - `segundo-teorema-gfpu` en la pizarra (pequeño, junto a la caja), o sobre la GFPU de I.2 si sigue en la pizarra (mismo gráfico, añadiendo E, E′ y la flecha);
  - los 4 pasos de la demostración, en 4 líneas; `segundo-teorema-no-convexo`, solo como apoyo y si sobra tiempo;
  - límites y soluciones, como guion.
- Al pasar de II a III se borra todo salvo las 3 condiciones (que el *second best* va a «romper»).
- **III.1**:
  - en la pizarra, la restricción $U_1/U_n=\psi\,T_1/T_n$ debajo de las 3 condiciones recuadradas, tachando la que rompe;
  - el enunciado del teorema de palabra (la fórmula con los $\Psi_k$, como apoyo);
  - `second-best-gfpu` (**imprescindible**): GFPU y F; después la restricción; por último P y Q, diciendo que el segundo óptimo (Q) no es lo más parecido al óptimo de Pareto (P). Se apunta el refrán al lado;
  - `montana-second-best` como boceto rápido (perfil, V, D, B, A y la flecha);
  - las extensiones, como guion.
- **III.2**: lista de 4 palabras clave en la pizarra (unión aduanera, monopolio contaminante, industria naciente, Rodrik); la fórmula del impuesto óptimo $t^*$ solo si sobra tiempo (si no, como apoyo).
- **III.3**: esquema «tipos → mensajes → resultado» con $\mathrm{IC}_i$ y $\mathrm{PC}_i$, y la tabla `tab:mecanismos` (**imprescindible**) en la pizarra, solo con las marcas sí/no; Hart y Greenwald-Stiglitz, de palabra.
- **III.4**: de palabra (sin la frase de Joan Robinson).
- **Conclusión**: sin pizarra. Empieza por «En conclusión,» y termina con la idea final que retoma el refrán. Responde a la pregunta del enganche: el mercado asigna bien cuando se cumplen todas las condiciones, y cuando no, no hay mal que por bien no venga: una distorsión bien elegida puede compensar otra que no se puede quitar, pero solo quien sabe cuál es el óptimo sabe qué mal trae un bien.
- Los anexos no se cantan.

## Control de calidad (21/10/2026)

Correcciones aplicadas tras el control de calidad del coordinador:
- Little: el paso a 3 mejora a $A$ sin empeorar a $B$; en el panel b), el tramo va del corte de las 2 FPU a 4; el criterio de Pareto de la tabla dice «nadie empeora y al menos uno mejora».
- Se quitan FPU$_1$/FPU$_2$ como «inicial/final» en la idea del anexo de compensación.
- La separabilidad es $\Psi_k=\Psi_n=0$ en III.1 y en el anexo; en el 2TFEB, «eso implica que» en lugar de «equivale a».
- Las bandas salvia de las tablas llegan al borde (`\dimexpr…\tabcolsep`).
- El texto que seguía a una lista en la introducción y en I.2 pasa a viñetas; también en el 1TFEB.
- Gráficos:
  - en `caja-intercambio`, las curvas $U_A'$ y $U_B'$ tangentes en E′ (capa 8, que usa `caja-intercambio-teoremas`);
  - en `caja-consumo-fpu`, los rótulos $U_B^1$ y $U_B^3$ intercambiados;
  - en `segundo-teorema-no-convexo`, los rótulos de A dentro de la caja y la flecha E′→$\vec{x}_A$ curvada por debajo de la curva de A.
- Los 3 gráficos están recompilados con `--grafico` y revisados en PNG; el tema, construido entero y verificado sin errores.


## Cambios tras las respuestas de Víctor (21/10/2026)

- **Refrán**: «Lo mejor es enemigo de lo bueno» pasa a «No hay mal que por bien no venga». Va solo en el enganche (primer ítem: si una distorsión no se puede quitar, añadir otra puede mejorar; el CBAM, un gravamen al comercio que compensa que el carbono no tenga precio fuera de la UE, es el ejemplo) y en la idea final. Se quita la nota de Voltaire. El esquema de la introducción pasa a «Introducción: el CBAM, un segundo óptimo»; la frase de la estructura («Es el hilo del refrán…»), el punto P/Q del gráfico del *second best* y el recapitulando de III.1 se reescriben sin «lo mejor/lo bueno». El refrán no sale en ningún otro tema de `fuentes/`.
- **Joan Robinson**: se quita «El mapa imposible» de la valoración del *second best*; la idea (un modelo con todas las interdependencias sería inmanejable) pasa a la viñeta de exigencia de información, y «trabajar con mapas a escala» pasa a «simplificar el problema sin perder las interdependencias que importan». `Robinson1962Essays` sale de `3A22.bib`.
- **Ficha de repaso**: los mismos cambios (esquema, enganche, III.1, III.4, idea final) y la etiqueta «Hilo» pasa a «Idea que guía».
