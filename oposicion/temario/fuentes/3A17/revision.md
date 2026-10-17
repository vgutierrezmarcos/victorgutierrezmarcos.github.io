# Revisión del tema 3.A.17 — Análisis de mercados (II). Teoría del monopolio. Discriminación de precios. Monopolio natural. Producción conjunta. Análisis de eficiencia y bienestar. Monopsonio. Monopolio bilateral.

Fecha: 17/10/2026. Integración en tres partes: la 1 escribió el preámbulo, la introducción y los bloques I y II; la 2, el bloque III; la 3, la conclusión, los anexos A-C, la bibliografía, los gráficos pedidos, `seo.json` y este informe.

Fuentes de la integración: `_trabajo/original.md`, `pendientes.md` (P1-P58), `propuestas-contenido.md` (C1-C49), `propuestas-datos.md` (V1-V53, E1-E11, F1-F4) con `bib-datos.bib`, y `propuestas-coherencia.md` (K1-K53, estructura final, esquema de pizarra y gráficos). Criterio ante discrepancias: la estructura y la notación las decide coherencia; la teoría, contenido. Mientras Víctor no conteste en el artifact de dudas, se aplican las decisiones provisionales del orquestador (abajo, «Dudas abiertas»).

## Resumen

- Nueva fuente `3A17.tex` (con los gráficos: **36 páginas de tema, 18 de anexos y 6 de bibliografía**). Estructura en 3 bloques: I. Teoría del monopolio (escenario base, equilibrio y regla de Lerner, eficiencia y bienestar); II. Desarrollos (discriminación de precios, monopolio natural con su regulación básica, producción conjunta); III. Monopsonio y monopolio bilateral, que estaban **vacíos** en el Word. Minutos: 2'30" + 8' + 11'30" + 7' + 1' = 30'.
- Hilo conductor: la regla de la elasticidad inversa (índice de Lerner, función clave que se queda en la pizarra todo el cante) reaparece por grupos (3.er grado), amortiguada (Ramsey-Boiteux), con elasticidades cruzadas (multiproducto) y en espejo (monopsonio, segunda función clave).
- Corregidos más de 25 errores de teoría, fórmulas y atribuciones (Lerner multiproducto, λ en Ramsey-Boiteux, eficiencia del 1.er grado, subaditividad multiproducto, subsidios cruzados, paro involuntario con monopsonio, pico-valle, Laffont-Tirole, efecto trinquete, *regulatory lag*, Olson, Shleifer, Boiteux, Mill, Pigou, Marshall 1920…); resueltas las 10 marcas amarillas (P1-P10).
- El bloque 4 del original (regulación y control) pasa entero al anexo A, corregido y reescrito desde las fuentes, con remisión al 3.A.20; derivaciones al anexo B (con «al menos tanto desarrollo como el original»); test y preguntas del tribunal al anexo C.
- `3A17.bib` con 130 entradas; 21 gráficos pedidos en `_trabajo/graficos-pedidos.json`, con 2 códigos base comunes y el de `subaditividad` del 3.A.12 reutilizado.

## Errores corregidos

| Dónde | Decía | Dice ahora |
|---|---|---|
| Intro, enganche (l. 75-77) | Vídeo de la «paradoja de Barbie» y definición de Marshall (mismo enganche que 3.A.12, 3.A.16, 3.A.18 y 3.A.19) | Refrán «Quien parte y reparte…» y sentencia de Google (5/8/2024); la idea final lo responde (K9, C2) |
| Contextualización (l. 129) | Smith señaló «la colusión o el poder de mercado» | Cita de Smith (libro I, cap. VII) sin la redundancia (V9) |
| Contextualización (l. 133-135) | Ricardo, «costes crecientes y decrecientes del monopolista»; Mill «introdujo la discriminación de precios» | Ricardo (1817): precio de monopolio sin relación con el coste; Mill (1848): productos conjuntos; Dupuit (1849): primera discriminación de precios (V10) |
| Contextualización (l. 145-147) | Marshall introdujo la pérdida irrecuperable; Pigou propuso impuestos que internalizaran los efectos externos del monopolio | Dupuit (1844), germen de la pérdida; Harberger (1954) la cuantifica; Pigou (1920): 3 grados de discriminación (V12, V13) |
| Nota 4 | Marshall, 1920 | 1890 (1920 es la 8.ª ed.) (V8) |
| Nota 10 | Molina, 1592; Azpilcueta «13 años» antes que Bodin; citas literales | Molina, *De iustitia et iure*, t. II (1597) (decisión del orquestador; datos decía 1593 para la 1.ª ed.); 12 años; sin citas literales (no comprobadas) (V16) |
| Nota 6 | Cita literal de Modigliani entre comillas; Ekelund y Hébert «solo Dupuit examinó…» | Paráfrasis con Modigliani (1958); la frase de Ekelund y Hébert se quita (sin comprobar) (V14) |
| Bloque 0, supuesto 3 y nota 11 | «Producto homogéneo… sustitutos perfectos»; «si hubiera efectos cruzados el poder de mercado se perdería» | Bien sin sustitutivos cercanos de otras industrias; el poder se reduce, no se pierde (C3) |
| Bloque 0 y 1.2 | «Información perfecta» / «información completa», supuestos duplicados | Una sola lista en I.1, «información completa y simétrica» (K15) |
| 1.2, problema | max B(q) s.a. B(q) ≥ B(0), mal maquetado | `\optim` y viabilidad aparte (K29, C4) |
| l. 279 | «|ε| ≥ 1» | |ε| > 1 estricto (P56) |
| Nota 19 | P − ∂P/∂q·q + P sin paréntesis | p − (p′q + p) (P56) |
| Nota 20 / 21 | «La pendiente del IMg será negativa»; «cuasicóncava» | Pendientes con su signo, el IMg suele ser decreciente; «estrictamente cuasicóncava» (C44) |
| l. 337 | A largo plazo «por lo menos se cubran los costes variables» | Se cubren todos los costes; la condición se evalúa en q^M (C5, P22) |
| Nota 25, 31, 57 | Eficiencia asignativa ≠ Pareto; el 1.er grado «sigue habiendo ineficiencia asignativa»; tarifa en dos partes no es eficiente | En equilibrio parcial cuasilineal coinciden; el 1.er grado es eficiente; la cuota es una transferencia de suma fija (C7, K19) |
| Nota 26 | RMST = w/r | RMST_{LK} = w_L/w_K (K29) |
| l. 483 | Lerner multiproducto con ε_{q_i,P_j} | ε_{q_j,p_i} (derivación en el anexo B) (C17) |
| l. 497 | Complementarios: «menor… (i.e. mayor que la inversa…)» | Menor (C17) |
| l. 505-509 | Costes no separables = *learning-by-doing*; precio < CMg como «subsidio cruzado» | Complementariedad de costes; aprendizaje en nota como producción conjunta en el tiempo; «subsidio cruzado» reservado para Faulhaber (C18, K20, K21) |
| l. 573, 663 | 2.º grado «conoce la distribución»; 3.er grado «no conoce ni la valoración ni la distribución» | Criterio común por la información del monopolista (K17, C10, C13) |
| l. 587 | 2.º grado = «descuentos para conjuntos de bienes» | Eso es *bundling* (caja aparte) (C14) |
| l. 683 | 3.er grado: «mejoras en sentido de Pareto» | Aumento del excedente total solo si aumenta la cantidad (Schmalensee, 1981; Varian, 1985); mejora paretiana si se abre un mercado (K18, C13) |
| l. 709 | «Discriminación de 4.º grado» | Discriminación intertemporal; «algunos manuales la llaman de cuarto grado» (K24, C16) |
| l. 807 | Multiproducto: «el concepto clave no sería la subaditividad sino las economías de alcance» | La definición sigue siendo la subaditividad; alcance, necesaria no suficiente (contradicción X3 del 3.A.12) (K22) |
| Nota 45 | Pruebas de subsidios cruzados, condición suficiente | Necesaria (Faulhaber, 1975) (V22) |
| Nota 49 | «Los costes por unidad aumentan hasta tornarse positivos»; necesaria/suficiente mezclados | Reescrita en el anexo B (sostenibilidad) |
| l. 1075, 1117 | «Ramsey-Boiteaux (1927)» | Ramsey (1927) y Boiteux (1956) (V27) |
| l. 1121-1138 | W(P) y «cuanto mayor sea λ menor será el margen» | ET(p⃗); el número de Ramsey λ/(1+λ) crece con λ (K23, C23) |
| l. 1113 | Punta: CF/n + CMg·q | p_v = b, p_p = b + β (Boiteux, 1949; Steiner, 1957) (C31) |
| l. 1183 (Averch-Johnson) | r como coste del capital y como rentabilidad | w_K y s; derivación con μ (C32) |
| l. 1295-1313, nota 66 (Laffont-Tirole) | «El principal no observa el coste», «sin conocer la distribución», «*trade-off* eficiencia e igualdad», contrato *fixed-cost* | Reescrito desde Laffont y Tirole (1993): C = β − e, renta informativa, menú t(C) = a − b(C − C^a), dilema incentivos-rentas (C35) |
| Caja del anexo 2 | Cost plus «óptimo con información perfecta»; P_{t+1} = P_0(1 + IPC − X)^t | Corregidos; p_{t+1} ≤ p_t(1 + IPC_t − X) (C35) |
| l. 1317-1323 y nota 67 | Efecto *ratchet* traducido de Wikipedia (Hardin, Higgs en inglés); *regulatory lag* «entre la revisión y su aplicación» | Weitzman (1980), Freixas, Guesnerie y Tirole (1985); desfase = tiempo entre revisiones (Joskow, 1974) (C36, V32, V33) |
| l. 1325 | «Schleifer»; ejemplo de generación eléctrica | Shleifer (1985), redes de distribución; modelo y DEA/SFA (C37) |
| l. 1371-1383, nota 70 | Captura por «contacto personal»; Olson (1992); cita de Rodríguez Braun sin obra | Stigler (1971) como teoría económica; Olson (1965); la cita se quita (C39, V36) |
| l. 981 / nota 48 | [ver tema 3.B.4] (×2); art. 101 TFUE recortado sin marcar | 3.A.15 y 3.B.39; art. 101 completo (V5, C29) |
| Anexo 1 | «GMg, i.e. la curva de oferta de trabajo»; con monopsonio «paro involuntario» (y nota 71) | El GMg está por encima de la oferta; sin paro involuntario en los 4 casos (solo con sindicato o salario mínimo > w^c) (K27, C27) |
| Imagen 1 y 12; bibliografía | Fuentes de preparadores («Bueno García, Intecysa», «Sahuquillo», «Tema Juan Luis Cordero Tarifa») | Fuentes académicas (Varian, Averch y Johnson…); «Apuntes ICEX-CECO» como en el original (F1-F4) |
| propuestas-datos, V17 | Para el índice de Lerner daba «Lerner (1934), *REStud* 2(1), 51-61» (*Economic Theory and Socialist Economy*) | **Error de la propuesta**: el índice está en «The Concept of Monopoly and the Measurement of Monopoly Power», *REStud* 1(3), 157-175 (`Lerner1934Concept`). El 3.A.21 usa con razón el otro artículo para las condiciones marginales |
| I.2 (CSO), anexo B.1 y pie del gráfico 17 (control de calidad) | El CMg decreciente que maximiza «corta al IMg desde arriba»; «desde abajo» sería un mínimo | Corta al IMg **desde abajo** (a la izquierda de q^M, IMg > CMg); si lo corta desde arriba, es un mínimo |
| Nota de I.3 y anexo B.3 (control de calidad) | `\tfrac` con numerador compuesto: en Word salía «a − c/2» | `\frac`: (a − c)/2 sin ambigüedad en PDF, web y Word |
| Gráficos `bienestar-monopolio`, `monopsonio`, `regulacion-monopolio-natural` (control de calidad) | Pérdida irrecuperable en morado (o dorado), distinta del 3.A.16 | En rojo (`perdida`, tceerojo al 30 %), como el triángulo del 3.A.16; «transferencia» del monopsonio ya no la cruza el GMg |
| Anexo C, ejemplo isoelástico (control de calidad) | p^M = 10 con C = 5q + 10 sin decir que da pérdidas | Añadido: B < 0, solo produce a corto plazo (p > CVMe) |
| Notas de Molina-Azpilcueta y de la Barbie; nota del primer óptimo (control de calidad) | Medina, Molina, Azpilcueta, Bodin y Sala-i-Martín sin versalitas; nota del «primer y segundo óptimo» confusa | Con `\autor{}`; nota aclarada |

## Marcas resueltas

| Marca | Original | Qué se hizo |
|---|---|---|
| P1 (amarillo) | Imagen 3 del 1.er grado, «Fuente:» vacía, «cambiar imagen» | Gráfico nuevo `primer-grado` (capa del central en el vídeo), fuente Tirole (1988) |
| P2 (amarillo) | «[Meter discriminación autoselectiva]» y 4 páginas manuscritas | Modelo de 2 tipos completo en II.1.2 (t_1 < t_2, π) y derivación en el anexo B; manuscritos transcritos y comprobados |
| P3 (amarillo) | Cuota fija distinta según renta («h» sin definir) | Integrado en II.2.3 (nota) y anexo A |
| P4 (amarillo) | Teoría positiva reconstruida de memoria | Reescrita en el anexo A con Stigler (1971), Olson (1965), Peltzman (1976), Becker (1983), Laffont y Tirole (1991) |
| P5 (amarillo) | Imagen 15 vacía (sindicato) | Capas del sindicato en `monopolio-bilateral`; derivación en el anexo B |
| P6-P8 (amarillo) | Notas 33-35: selección adversa, calidad (Mussa-Rosen), resultados y «procedimiento para el test» | Integrados en II.1.2 (idea, implicaciones, extensión de calidad) y anexo C (procedimiento generalizado a n_1, n_2) |
| P9 (amarillo) | Nota 38 (aprendizaje) mal colocada | Nota del multiproducto (II.3.1) |
| P10 (amarillo) | Nota 39 (excedente total) | Cuerpo de II.1.3 con Schmalensee y Varian |
| P11-P16 | Notas al opositor (cambio de temario, ficha del tribunal, reordenación, escenario base, «desarrollar 3», esquema de regulación) | Aplicadas como estructura (K1-K5) y desaparecen |
| P17-P19 | Notas del menú de contratos (enlace de UBS), Baldwin-Cave-Lodge, caja del anexo 2 | Desaparecen; Baldwin et al. citados en la competencia por comparación; caja corregida en el anexo A |
| P20-P28, P55 | 35 comentarios (clases, preparadores, coordinación) | No se publican |
| P21 | «Sustituir x por q en el 3.A.14» | No se toca otro tema: ver «Coherencia» |
| P22 | Duda P ≥ CVMe en el óptimo o en el mínimo | Resuelta en nota de I.2 y anexo B (equivalencia demostrada) |
| P41, P42 | Monopsonio y monopolio bilateral vacíos | Bloque III completo (C25-C27, K39-K40) |
| P43 | Producción conjunta escasa | 4 casos, proporciones fijas y multiplanta (C17-C20, K42) |
| P44-P46 | 2.º grado sin modelo; bienestar sin cuantificar; impuestos y demanda lineal | C8, C12, C6, C47 |
| P47-P54 | Referencias, regulación, coherencia con 3.A.12 y 3.A.21, notación | Aplicadas (abajo) |
| P56-P58 | Fórmulas, autores y datos | Ver «Errores corregidos» y «Datos actualizados» |

## Datos actualizados

| Dato | Valor anterior | Valor nuevo | Fuente | URL | Consulta | Segunda comprobación |
|---|---|---|---|---|---|---|
| Sentencia de Google (enganche) | — | 5/8/2024; «Google es un monopolista…»; cuota del 89,2 % en búsquedas y del 94,9 % en móviles | *United States v. Google LLC*, D.D.C., 20-3010 (APM) | — | 17/10/2026 | **Solo en prensa** (2 fuentes que reproducen la sentencia, según contenido C2); no se ha consultado la sentencia original: ver dudas |
| Márgenes precio-coste | — | 21 % (1980) → 61 % (2016) | De Loecker, Eeckhout y Unger (2020), *QJE* | https://doi.org/10.1093/qje/qjz041 | 17/10/2026 | IDEAS y OpenAlex (V43) |
| Harberger | — | «una treceava parte del 1 % de la renta nacional», 1924-1928 | Harberger (1954) vía Schmitz (2012) | https://minneapolisfed.org/article/2012/new-and-larger-costs-of-monopoly-and-tariffs | 17/10/2026 | Cowling y Mueller (1978), introducción (V41) |
| Card y Krueger | — | 410 restaurantes; 4,25 → 5,05 $/h el 1/4/1992; sin caída del empleo | Card y Krueger (1994) | https://ideas.repec.org/a/aea/aecrev/v84y1994i4p772-93.html | 17/10/2026 | Resumen del artículo (V45) |
| Monopsonio en EE. UU. | — | IPMg 53 % sobre el salario; 65 centavos por dólar | Yeh, Macaluso y Hershbein (2022), *AER* | — | 17/10/2026 | Página de la AEA (C25) |
| Estancamiento salarial | — | 75 % monopolio, 25 % monopsonio (1997-2016) | Deb et al. (2022), *JEEA* | — | 17/10/2026 | BSE y UPF (C25) |
| SMI 2026 | — | 1.221 €/mes en 14 pagas (17.094 €/año), +3,1 % | RD 126/2026, BOE-A-2026-3815 | https://www.boe.es/diario_boe/txt.php?id=BOE-A-2026-3815 | 17/10/2026 | Fieldfisher, CSIF (V46) |
| Franjas 2.0TD (nota 58) | «El Gobierno… 3 franjas; llano 25 % y valle 95 % más baratos» | Periodos de la CNMC desde 1/6/2021 (horas), **sin porcentajes** | Circular 3/2020 | https://www.boe.es/buscar/act.php?id=BOE-A-2020-1066 | 17/10/2026 | MITECO (V1). Los porcentajes de 2026 (70 % y 97 %) no se publican por decisión del orquestador |
| Price cap en España (nota 62) | Telefónica y AENA sin fechas | Telefónica hasta 2012; Aena con DORA; DORA 2027-2031 aprobado en septiembre de 2026 (**sin la X = +0,33 %**) | CNMC (2018); BOE (DORA) | https://www.boe.es/diario_boe/txt.php?id=BOE-A-2026-19507 | 17/10/2026 | V3 |
| ADIF (nota 60) | Tarifas de tracción y contenedores reguladas por tasa de beneficio | Tarifas de tracción orientadas a costes, supervisadas por la CNMC (sin contenedores) | CNMC (2018) | — | 17/10/2026 | V2 |
| Ley 2/2015 | Correcta | Vigente, desarrollada por el RD 55/2017 | BOE | https://www.boe.es/buscar/act.php?id=BOE-A-2015-3443 | 17/10/2026 | V4 |
| Nobel de Tirole y Stigler (notas 46-47) | Correctos | Motivaciones oficiales traducidas | nobelprize.org | — | 17/10/2026 | V6 |
| Enlaces | quia.com, Policonomics (roto), UBS (403), apuntes de City University, Wikipedia | Simulador; gráficos propios; citas a las obras | E1-E11 | — | 17/10/2026 | — |

## Contenido añadido

- Introducción con sus 5 bloques, esquema de pizarra y nota con el reparto; contextualización ampliada (Ricardo, Mill, Dupuit, Robinson y «monopsonio», Bowley, Lerner, Harberger, Coase, Boiteux, Baumol, Mussa-Rosen, Maskin-Riley, Laffont-Tirole).
- I.1: escenario base con la tabla de qué supuesto levanta cada desarrollo (K7). I.2: estructura a)-d), funciones clave, impuestos en caja. I.3: Harberger y su tamaño (PIE ≈ B/2), Tullock-Posner, ineficiencia X con (1+χ), Hicks (1935, p. 8), eficiencia dinámica (Schumpeter, Arrow, Aghion et al.), evidencia.
- II.1: autoselección con 2 tipos, tarifa de Oi con su fórmula, calidad (Mussa-Rosen, *damaged goods*), *bundling* (Adams-Yellen), cotas de Varian, Coase con Gul-Sonnenschein-Wilson y Bulow. II.2: sostenibilidad (Panzar-Willig, Baumol-Bailey-Willig), mercados impugnables, Faulhaber, regulación básica con primer y segundo óptimo y Ramsey-Boiteux como Lerner amortiguado. II.3: 4 casos, proporciones fijas (Marshall), multiplanta, aprendizaje (Wright).
- III: monopsonio a)-e) con la tabla de los 4 casos con color, isocostes curvas, salario mínimo por tramos, Manning, evidencia; monopolio bilateral con Bowley, Fellner, Edgeworth, sindicato de Dunlop (1944), poder compensatorio de Galbraith (1952), Nash con γ, Rubinstein y Binmore-Rubinstein-Wolinsky, doble marginalización (Spengler), McDonald-Solow.
- Anexo A: todo el bloque 4 con Braeutigam (diagrama nuevo), Demsetz y Williamson, punta y valle firme y desplazada, Averch-Johnson con su derivación, *price cap*, Loeb-Magat, Laffont-Tirole, trinquete y desfase, *yardstick* con modelo y DEA/SFA (caso alemán), evidencia (Joskow, 2014), teoría positiva, instituciones (CNMC, Ley 3/2013). Anexo B: CSO, viabilidad, 2.º grado, Lerner multiproducto, Ramsey-Boiteux, sostenibilidad, 4 casos y sindicato, Nash, Averch-Johnson. Anexo C: test y 10 preguntas probables.

### Estado de cada propuesta

- **Contenido**: C1 aplicada con la estructura de coherencia (I.1-I.3 y orden II: discriminación, natural, conjunta), no la suya. C2 aplicada con la Estructura y la Problemática de K10-K11; las notas «(Nota n del original)» se sustituyen por el texto de las notas. C3-C8 aplicadas (C4 sin la `\funcionclave` del problema; C8 con la franja de ineficiencia X en lugar del rectángulo porque el CMg del gráfico es creciente; Cowling-Mueller **sin** la cifra 4-13 %, no comprobada). C9 aplicada. C10-C13 aplicadas (C12 con t_i y π por coherencia K29, en lugar de v_i y π_i; sin `\funcionclave`). C14 aplicada. C15: la «paradoja de Barbie» queda en una nota de II.1.2 citando el vídeo de Sala-i-Martín, **sin precios** (como proponía datos, V50; contenido proponía quitarla). C16-C20 aplicadas (C20 sin gráfico `multiplanta`: no lo prevé coherencia). C21 aplicada con la atribución a Segura con `Segura1986Analisis` (contenido proponía `Segura1993Teoria`): ver dudas. C22 en nota y anexo B. C23 aplicada con la presentación de coherencia (sin lagrangiana nombrada; λ en los 2 sentidos) y punta-valle en una viñeta (K37). C24 aplicada. C25 aplicada con w_L(L), L^M (K29), sin remisión a 4.A.27. C26 aplicada en el mercado de trabajo, sobre el gráfico del monopsonio (K40), en lugar del modelo genérico I(q), C(q). C27 aplicada en III.1 (tabla) y anexo B. C28-C40 aplicadas en el anexo A con estos cambios: **C32 sin las tasas de retribución** (5,58 % y 6,46 %: la circular 2026-2031 no está comprobada y la entrada de la Circular 2/2019 no tiene URL comprobada); **C33 sin la X del DORA** (+0,33 %); C31 sin porcentajes de la factura. C41 fundida con K13. C42-C49 aplicadas (C48: 4.A.27 no se usa; 4.B.2 y 4.B.11 como ampliación).
- **Datos**: V1 (franjas, sin porcentajes), V2-V6, V8-V13, V16 (Molina 1597), V17 (con la clave corregida), V18-V36, V38-V49 aplicadas; V7 no procede (sin Marshall en el enganche); V14 en paráfrasis; V15 (Mosca) no se cita (era una nota solo con la referencia); V37 en el pie de II.2.3; V50 sin cifras; V51-V53 aplicadas; E1-E11 aplicados; F1-F4 aplicados.
- **Coherencia**: K1-K8 aplicadas (K8: el anexo B incluye también los 4 casos y Nash; la caja del antiguo anexo 2 va dentro del anexo A). K9-K14 aplicadas (K13 sin la frase de Joan Robinson). K15-K28 aplicadas. K29-K33 aplicadas. K34-K47 aplicadas. K48-K49 aplicadas. K50-K51 aplicadas como códigos base comunes en `graficos-pedidos.json`. K52-K53: el guion lo concretará.

## Coherencia

- **Notación**: p, p(q) (demanda inversa en el monopolio, como el canon y la propuesta CN3 del 3.A.16), x(p) demanda de mercado, q^M/p^M y q^c/p^c, 𝓛 índice de Lerner (la lagrangiana nunca se nombra con 𝓛: «problema penalizado»), ε con dos subíndices y |·| en las reglas de margen, siglas en redonda; ET, EC, EP; λ en Ramsey y en Laffont-Tirole con nota que lo dice; μ en Averch-Johnson; t_1 < t_2 y π en la autoselección; T(q) = A + p q; p_v = b, p_p = b + β; w_L(L), ε_{L,w_L}, w^M, w^S, w^c, L^M, L^c; γ poder negociador del sindicato; v(L) desutilidad agregada.
- **Siglas nuevas** (propuesta al canon, § 6 de coherencia): VPMg_L, IPMg_L, GMg_L, en redonda, definidas la primera vez (I.3 y III.1).
- **3.A.12**: se cumple lo que promete (monopolio natural con su mismo gráfico y la definición por subaditividad, triángulo de Harberger más la ineficiencia X, isocostes curvas con monopsonio, multiplanta y multiproducto).
- **3.A.21**: rendimientos crecientes con pérdidas a p = CMg (II.2.3) y negociación de Edgeworth, Nash y Rubinstein con las mismas claves y el mismo relato (III.2).
- **3.A.16 (en revisión)**: misma notación de excedentes y del 1TFEB parcial; enganche distinto (el suyo es «A río revuelto…»).
- **Contradicciones con otros temas** (no se tocan; al canon):
  - **3.A.25**: su anexo copia el anexo 1 del 3.A.17 con sus errores (GMg = oferta; paro involuntario con monopsonio; W y Π). Debe resumir III.1 y remitir aquí.
  - **3.A.27**: sindicato monopolista, Nash con γ, contratos eficientes: debe remitir aquí para el monopolio bilateral y usar w_L, L, γ, U_S.
  - **3.A.13**: remite Laffont-Tirole al 3.A.20 (el canon lo fija aquí, anexo A) y no menciona la discriminación de 2.º grado como *screening*.
  - **3.A.22**: su comentario pide «sustituir x por q» en el 3.A.17; aquí la demanda es x(p) y el monopolista vende q = x(p): resuelto. El comentario análogo del 3.A.17 sobre el 3.A.14 (P21) es privado y no se publica.
  - **3.A.18, 3.A.19**: comparten el enganche antiguo; el 3.A.19 debería remitir aquí para el cártel como multiplanta.
  - **3.A.23**: remite «libre entrada» a 3.A.17 y 3.A.19 (mapa: 3.A.15 y 3.A.16).
  - **4.B.15**: subaditividad remitida a 3.A.10; tarifa de punta CF/n + CMg·q (el mismo error corregido aquí); Averch-Johnson con r y P; signo de la transferencia de Laffont-Tirole.
  - **4.A.12**: remite el *price cap* al 3.A.20 (hoy está en el anexo A de este tema).
- **Canon** (para `tema-canon`): fichas nuevas `monopolio`, `discriminacion-precios`, `monopsonio`, `monopolio-bilateral`; cambios en `ramsey-boiteux`, `monopolio-natural`, `excedentes-bienestar`, `rent-seeking-tullock`, `mercados-impugnables`, `curva-aprendizaje`, `laffont-tirole` (λ en vez de μ); `mapa.yaml` del 3.A.17 (referencias corregidas y faltan); `notacion.md` (siglas y símbolos de arriba). Detalle en `_trabajo/propuestas-coherencia.md`, § 6.

## Dudas abiertas

1. **Sentencia de Google (enganche)**: la cita («Google es un monopolista y ha actuado como tal para mantener su monopolio») y las cuotas (89,2 % y 94,9 %) están comprobadas **solo en prensa** que reproduce la sentencia, no en el texto de la *Memorandum Opinion* (D.D.C., 5/8/2024). La entrada `Mehta2024Google` no tiene URL. ¿La mantengo (cotejando la sentencia y añadiendo la URL) o dejo solo el refrán?
2. **Decisiones provisionales del orquestador** que esperan tu respuesta en el artifact: estructura de coherencia (D1-D4: regulación básica en II.2.3 y el resto en el anexo A; título del bloque I; orden de II; bienestar en I.3), 1.er grado como capa del gráfico central (D5), enganche con refrán (D7), siglas VPMg, IPMg y GMg (D8).
3. **Frase de Joan Robinson** (mapa a escala 1:1): no se ha puesto (pendiente de tu decisión; encajaría en la opinión).
4. **Segura y la sostenibilidad con reacción del incumbente**: el original dice «como señala Julio Segura» sin obra; se cita `Segura1986Analisis` (la edición que usas, 1996). ¿Es esa obra? ¿Qué páginas?
5. **Cifras no publicadas** (sin fuente primaria definitiva o por decisión provisional): X = +0,33 % del DORA 2027-2031; tasas de retribución de las redes (5,58 % 2020-2025 y la de 2026-2031); porcentajes de la factura eléctrica de 2026 (70 % y 97 %, comprobados por datos en BOE y MITECO); «carga y descarga de contenedores» de ADIF; precios de la Barbie; cifra de Cowling y Mueller.
6. **Entradas del `.bib` sin comprobar del todo**: `CNMC2019Circular2` (sin URL ni fecha de BOE), `Joskow2014Incentive` (páginas), `BaldwinCaveLodge2012Understanding` (página 500 de la nota al opositor), `ICEXCECO3A17` (título genérico: «Apuntes de los temas 3.A.17 y 3.A.25 (temario anterior)»; ¿el título exacto?).
7. **Bibliografía de preparadores**: se quitan «Apuntes Sahuquillo» y «Tema Juan Luis Cordero Tarifa»; queda «ICEX-CECO». ¿De acuerdo?
8. **Nota 10 (Molina y Azpilcueta)**: se conserva breve, con Molina en 1597, sin citas literales. ¿Recortarla más (es materia del 3.A.35)?
9. **Control de calidad (17/10/2026)**: sin incidencias pendientes. Tras el control se pasaron a bloques (supuestos, desarrollo, implicaciones) la conjetura de Coase, las proporciones fijas, Laffont-Tirole y la competencia por comparación; se amplió `subaditividad-sostenibilidad` (eje vertical cortado, con p' y q' del anexo B.6; D' pasa a q' = 2,5) y se recolocaron los rótulos de `autoseleccion`. Los títulos de primer nivel del Word salían justificados: corregido en `latex/reference.docx` (títulos alineados a la izquierda) para todos los temas.
10. **Harberger (1954)**: «una treceava parte del 1 %» no se ha podido recomprobar en el control de calidad (la página de la Fed de Minneapolis no carga sin JavaScript); la segunda comprobación del informe es Cowling y Mueller.

## Instrucciones para el vídeo

- `equilibrio-monopolio` es el gráfico central: se dibuja en I.2 en una celda propia que **no se borra** hasta acabar I.3 y crece capa a capa (bienestar en I.3); la discriminación de 1.er grado es una capa más (la demanda pasa a ser el IMg y el triángulo desaparece) al empezar II.1.
- La función clave del índice de Lerner se escribe en I.2 y se conserva en una esquina todo el cante (`conservar:`); en II.1.3 y II.2.3 las reglas por grupos y de Ramsey-Boiteux se escriben junto a ella; en III.1, la del monopsonio.
- `monopsonio` se dibuja en III.1 y **sobre el mismo gráfico** se añaden en III.2 las capas del sindicato, el intervalo [w^M, w^S] y L*; el salario mínimo, como capa o como apoyo.
- `subaditividad-sostenibilidad` parte del gráfico del 3.A.12 (mismas capas y rótulos).
- Apoyo, no pizarra: la tabla del escenario base, `tercer-grado`, `tarifa-dos-partes`, `produccion-conjunta` y los gráficos de los anexos.
- Pregunta de enganche: «Quien parte y reparte, ¿se queda siempre con la mejor parte?»; la idea final la responde.
