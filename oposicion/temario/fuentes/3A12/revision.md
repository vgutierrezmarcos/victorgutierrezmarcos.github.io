# Revisión del tema 3.A.12 (14/10/2026; comentarios de Víctor aplicados el 16/10/2026)

Teoría de los costes. Análisis de dualidad en el ámbito de la empresa. Aplicaciones empíricas.

Las referencias «C», «V», «K» y «P» remiten a `_trabajo/propuestas-contenido.md`, `propuestas-datos.md`, `propuestas-coherencia.md` y `pendientes.md`; «l. NNN», a `_trabajo/original.md`.

**Estado:** tema completo (integrado en dos partes el 14/10/2026 y reestructurado en tres apartados el 16/10/2026), con sus 25 gráficos (23 TikZ y 2 de datos) y construido en PDF (60 páginas: tema 46, anexos 9, bibliografía 5), HTML y Word. Pendientes de la entrega siguiente: ficha de repaso, guion del cante y vídeo.

## Resumen

- **16/10/2026**: el tema pasa a **tres apartados** (I Dualidad · II Análisis de los costes: estática comparativa, plazos y extensiones, que absorbe el antiguo III como II.3-II.6 · III Aplicaciones empíricas, el antiguo IV), con minutos 2,5 · 9 · 12 · 5,5 · 1 = 30, enganche nuevo de la fotovoltaica y el resto de cambios de la sección «Cambios del 16/10/2026» (al final). Lo que sigue describe la integración del 14/10 con la numeración de entonces.

- Introducción rehecha con sus cinco bloques (enganche nuevo de Christensen y Greene, 1976; relevancia teórica, empírica y de política; contextualización con fechas comprobadas; cinco preguntas; estructura en cuatro bloques con el IV nuevo de aplicaciones empíricas), esquema de pizarra y reparto del cante: 2,5 + 9 + 8,5 + 3,5 + 5,5 + 1 = 30.
- Bloque I con la forma del bloque I del 3.A.9 (tabla de ingredientes, cada problema con a)-e), propiedades numeradas, lemas de Hotelling y Shephard, tabla de pares, gráfico conjunto y esquema de dualidad por capas). La «dualidad» del cuerpo es MB-MC, con la recuperación de la tecnología desde C (Shephard-Uzawa-McFadden) y desde B (función soporte); el primal de Segura pasa al anexo `anexo:segura`.
- Bloque II corregido: demandas condicionadas como análogas de las hicksianas, ε_{q,λ} = 1/ε_{C,q} en general en el óptimo (Hanoch, 1975) con demostración y tabla de color, U del CMe a largo plazo por los rendimientos a escala (no por la ley de proporciones variables), ecuación de Slutsky de los factores con efecto escala y sin factores Giffen, ∂CMg/∂w_i, corto plazo con CMg = w_L/PMg_L, envolvente sin el error de Viner y Le Châtelier-Samuelson.
- Notación según las decisiones de esta integración: μ (multiplicador de la MC), λ (escala), κ (factor de homogeneidad en precios), S(w⃗,q) (matriz de sustitución), q, F(z⃗), z⃗(w⃗,q) / z⃗(p,w⃗), B(p,w⃗), C(w⃗,q), C(w⃗,q;z̄_K), «efecto escala», vectores con flecha.
- Bloque III reducido a lo que es propiedad de C(w⃗,q): competencia perfecta y monopolio natural con remisiones a 3.A.16 y 3.A.17, y la subaditividad como definición. Las economías externas se separan del aprendizaje, Stigler y Leibenstein se redactan de nuevo (sin el texto de Policonomics) y III.4 trata la empresa multiplanta (nueva), la multiproducto y las curvas de aprendizaje.
- **Bloque IV nuevo, «Aplicaciones empíricas»** (5,5 min):
  - estimación por dualidad: Cobb-Douglas de costes, translog con ecuaciones de participación y Leontief generalizada;
  - economías de escala en los datos: Nerlove, Christensen y Greene (con un gráfico de datos), densidad frente a escala, técnica del superviviente, costes en L y aprendizaje;
  - medición de la eficiencia: Farrell, frontera estocástica frente a DEA (con tabla comparativa) y evidencia de banca (BCE y España, con un gráfico de la ratio de eficiencia), de la regulación alemana, de la Comisión Europea (DP 217) y de estudios españoles verificados; tabla de ejemplos por sectores.
- Conclusión con sus cinco bloques e idea final que responde al enganche. Anexos A-H: Kuhn-Tucker y condiciones de segundo orden; envolvente (Hotelling y Shephard); hessiana (anexo C del 3.A.9 adaptado); dualidad estricta de Segura; estática comparativa (derivación de la ecuación de Slutsky de los factores y prueba de Le Châtelier-Samuelson); geometría de los costes; formas funcionales; aspectos para el test, con el enlace al simulador.
- 24 gráficos pedidos en `_trabajo/graficos-pedidos.json`: 22 TikZ de teoría y 2 de datos con pgfplots (`christensen-greene-1970` y `ratio-eficiencia-bancos`, ya hechos, con sus CSV en `datos/`). Ninguna captura, escaneo, nota manuscrita ni imagen de Policonomics pasa a la fuente. `3A12.bib` tiene 85 entradas. El PDF tiene 52 páginas, sin errores, referencias sin definir ni líneas demasiado largas (la URL de la Bundesnetzagentur se parte gracias a las penalizaciones `biburl…` del preámbulo del tema, sin tocar `tcee.sty`).

## Errores corregidos

| Dónde (original) | Decía | Dice ahora | Propuesta |
|---|---|---|---|
| I.2.1, CSO (l. 283) | H = (p·f_kl) = **pⁿ·F**, con «∂²I(z*)» | Hessiana p·D²F(z⃗*) = (p F_ij) | P59, C5 |
| I.2.1 (l. 289) | Semidefinida negativa exige F **estrictamente** cóncava | Semidefinida negativa ↔ concavidad; la concavidad estricta da la unicidad | P60, C5 |
| Nota 10 | «Si la función de producción es convexa, el beneficio tiende a +∞» | Con rendimientos crecientes y beneficio positivo el problema no está acotado; con constantes, beneficio nulo y escala indeterminada | C5 |
| Notas 12, 13, 20, 21 | Existencia y unicidad «por el teorema de la función implícita» | Existencia y unicidad por la concavidad (cuasiconcavidad) estricta; continuidad por el teorema del máximo; el TFI da la diferenciabilidad | P74, C5 |
| I.2.1, propiedad 3 de B | B «estrictamente creciente en p» | No decreciente en p (estrictamente creciente si q > 0) | K11, C5 |
| I.2.2 (l. 601-603) | Demandas condicionadas homogéneas de grado cero en (w⃗, Q̄) | Homogéneas de grado cero **solo en w⃗**; no en q | C6 (error nuevo) |
| I.2.2 (l. 535) | En la MC «se contrata un factor hasta que el valor de la PMg del capital se iguala al ingreso»; «el coste del bien» | w_i/PMg_i = μ (coste marginal) para todo i; «precio del factor» | P61, P70, C6 |
| I.2.2 (l. 619-637) | Propiedades de C numeradas 1, 8, 9, 10… | 1-7, como la función de gasto del 3.A.9 | P62 |
| I.2.2 (l. 631) y nota 22 | Concavidad = «el coste aumenta menos que proporcionalmente» | Concavidad = por debajo del plano tangente (combinación «pasiva»); con todos los precios a la vez sube en la misma proporción | C6, K8 |
| I.2.2 (l. 655) y nota 23 | Diagonal de Σ «no negativa»; «demanda **no condicionada**» y «demandas hicksianas» | Diagonal **no positiva**; demanda **condicionada** | P63 |
| I.2.2, Idea (l. 478) | «El problema dual fue introducido por Samuelson en 1947» | Formalización en los años 30-40 (Viner, Hicks, Samuelson); la dualidad coste-producción y el lema, de Shephard (1953); la función de beneficio y su lema, de Hotelling (1932) | P72, V5, C7 |
| I.1 (l. 169) | «plantear el problema del **consumidor**» | Se quita (el apartado se reescribe) | P70 |
| I.1, propiedad vi | Rendimientos no crecientes y concavidad para los dos problemas | Concavidad estricta solo para la MB; para la MC basta la cuasiconcavidad (la función de costes existe con cualquier rendimiento) | K17.3, C3 |
| Nota 5 | En la Cobb-Douglas «la PMg del capital aumenta cuanto aumenta el capital» | Aumenta con el trabajo (∂²F/∂z_K∂z_L > 0) y disminuye con el capital si α < 1 | P68, C4 |
| I.3.1 (l. 715-720) | Recuperación de f con una «función de producción indirecta» χ no definida | V*(q) = {z⃗ ≥ 0⃗ : w⃗·z⃗ ≥ C(w⃗,q) ∀ w⃗ ≫ 0⃗} y F(z⃗) = max{q : z⃗ ∈ V*(q)} (Shephard, 1953; McFadden, 1978); χ pasa al anexo de Segura | P43, P75, C9 |
| I.3.2 (l. 726, 730) | 𝒴 ≡ {(q,z) > 0 : q ≤ f(z)} (no admite la inacción) y 𝒴 ≡ {… ≤ B} | 𝒴 en *netputs* (q, −z⃗) como en el 3.A.11; la segunda definición es 𝒴*, que coincide con 𝒴 solo si es convexo | P1, C10 |
| II.1.1 (l. 878-880) | Factor normal si la demanda es «creciente en la riqueza»; «efecto riqueza»; «el bien es inferior» | ∂z_i(w⃗,q)/∂q > 0 (normal) o < 0 (inferior); al menos un factor es normal | C13 |
| II.1.1 (l. 914) | «Hemos asumido por simplicidad que la elasticidad es constante» | Se quita (no se había supuesto) | C13 |
| II.1.1 (l. 1018-1024) | ε_{C,Q} = 1/ε_{Q,λ} solo con homotéticas; «economías de escala con rendimientos decrecientes… incrementando un solo factor» | ε_{q,λ}(z⃗(w⃗,q)) = CMe/CMg = 1/ε_{C,q} en general en el óptimo (Hanoch, 1975), con demostración; la homoteticidad la extiende a toda la senda; con rendimientos globales solo implicaciones en un sentido (tabla) | P3, P66, K17.1, C14 |
| II.1.1, caja l. 970-980 y notas 28-30 | U del CMe a largo plazo por la ley de proporciones variables; Cobb-Douglas «convexa»; «punto de inflación»; «rendimientos marginales crecientes implican economías de escala» | U a largo plazo por rendimientos a escala variables (tecnología en S); la ley de proporciones variables explica el corto plazo; Cobb-Douglas cóncava con α+β ≤ 1; inflexión | P67, K17.2, C15 |
| II.1.2 (l. 1050) | «Las isocostes rotan sobre el punto en el que cortan el eje…» (lógica de la recta de balance, primal de Segura) | Isocuanta fija; la isocoste cambia de pendiente y se desplaza para seguir tangente | P21, K15 |
| II.1.2 (l. 1110-1135) | Slutsky con el primal de Segura, z_i(w⃗,C̄); segundo término ∂z_i/∂**p**; «efecto renta»; «dos efectos contrapuestos» | ∂z_i(p,w⃗)/∂w_j = ∂z_i(w⃗,q)/∂w_j + (∂z_i(w⃗,q)/∂q)(∂q(p,w⃗)/∂w_j): efecto sustitución + **efecto escala**, del mismo signo para el precio propio | P64, K15, C16 |
| II.2 (l. 1258-1266) | «A corto plazo los rendimientos a escala se estudian con la elasticidad-coste»; fases I-III como economías y deseconomías de escala | A corto plazo no hay escala que cambiar; CMg = w_L/PMg_L, CVMe = w_L/PMe_L | P67, C17 |
| II.2, largo plazo (l. 1282-1284) | La envolvente sin precisar dónde toca | Tangencia en el tramo decreciente a la izquierda del mínimo del CMe_LP y en el creciente a la derecha; coinciden los mínimos solo allí (error de Viner) | C17 |
| II.2 (l. 1300) y nota 35 | Gibbs «con base en» Le Châtelier (anacronismo: Gibbs 1875-1878, Le Châtelier 1884); biografía larga | Samuelson traslada el principio de Le Châtelier (1884); Nobel 1970, en una nota de dos líneas | P71, V11, C17 |
| III.1.1 (l. 1320) | «Condiciones de primer orden: P < CMg» | p = CMg con q > 0 (p ≤ CMg en general) | P65, C18 |
| III.1.1 (l. 1322) | Oferta «a partir del mínimo de los costes medios» | Por encima del mínimo del CVMe a corto plazo o del CMe a largo | C18, C35 |
| III.1.2 (l. 1330) | La subaditividad, «condición necesaria y suficiente», como supuesto | Es la definición del monopolio natural (Baumol, 1977) | K14 |
| III.1.3 (l. 1344) | «En la empresa multiproducto el concepto relevante sería la existencia de economías de alcance» | La definición sigue siendo la subaditividad; las economías de alcance son necesarias, no suficientes (Baumol, Panzar y Willig, 1982) | K14, X3 |
| III.1.2 (l. 1336) | «la eficiente productiva» | la eficiencia productiva | P70 |
| III.2 (l. 1356-1360) | Las economías de aprendizaje y los *clusters* como economías externas | Las de aprendizaje son sobre todo internas y dinámicas; solo su difusión es externa; las externas marshallianas, por aglomeración | P69, C19 |
| III.3.2 (l. 1400) | El esfuerzo según «la ley psicológica de Yerkes-Dodson», atribuida a Leibenstein | Sin la atribución (no comprobable): el esfuerzo responde a la presión externa | P73, C21, V13 |
| III.3.2 (l. 1396-1416) | Texto copiado casi literalmente de Policonomics; «el comportamiento optimizador es una **excepción**»; «relajares»; «resultados mixtos» | Redactado de nuevo con Leibenstein (1966), C^obs = (1+χ)C, la diferencia con la ineficiencia asignativa, la evidencia (Nickell, 1996; Bloom y Van Reenen, 2007) y la réplica de Stigler (1976) | V13, C21 |
| III.4.1 (l. 1432-1450) | Repetía la subaditividad de III.1 | Pasa a ser la empresa multiplanta (P32); la subaditividad sale una sola vez | K14, C22 |
| III.4.2 (Imagen 15) | Dos fronteras de posibilidades de producción como «economías de alcance» (no muestran costes) | Gráfico de costes conjuntos frente a separados | P41.15, C22 |
| Conclusión (l. 1502-1530) | «Un lado del mercado: la oferta»; «a lo largo de la aplicación»; relevancia vacía; «dl mercado»; «paso precio» | Cinco bloques rehechos | P78, P70, C29 |
| Anexo 2 | Capturas en inglés sobre la hessiana | Anexo C del 3.A.9 adaptado a C y a B | P41.26, C30 |
| Anexo 3 y nota 37 | C(q,w⃗), «AC(q)», capturas de MWG; repetía la nota 9 | C(w⃗,q) y CMe; seis casos redactados y gráfico propio; la MB en dos etapas queda en I.3 | P41.16, P76, C31 |

## Marcas resueltas

| Marca | Texto original | Qué se hizo |
|---|---|---|
| P1 (amarillo, I.3.2) | «La tecnología puede representarse mediante el conjunto productivo…» y «B es la función de soporte de 𝒴» | Redactado de nuevo (C10): 𝒴 en *netputs*, B como función soporte, recuperación de 𝒴* con su condición de convexidad; las cuatro capturas de Pérez Domínguez (`image10-13`) se sustituyen por el gráfico `beneficio-soporte` y el texto |
| P2 (amarillo, II.1.1) | Rendimientos marginales crecientes ⇒ CMg decrecientes… curva en U | Es de corto plazo: pasa a II.2 con CMg = w_L/PMg_L |
| P3 (amarillo, Anexo 1) | Rendimientos y economías de escala («sacado del tema de…») | Integrado en el cuerpo (II.1.1), redactado de nuevo con la demostración y Hanoch (1975); sin la procedencia. El anexo desaparece (C28) |
| P4 (amarillo vacío) | Salto de línea | Se quita |
| P5 (notas del cambio de temario e `image1.png`) | Aviso de 2023 y ficha del tribunal | No se publican; la ficha orienta el bloque IV |
| P6 (nota) | Por qué empezar por el beneficio | Integrado en a) Idea y e) Valoración de I.2.1 y en la fila «Mercado del producto» de la tabla de ingredientes |
| P7, P8, P9 (notas) | «Ver Maté y Pérez», «coordinar con 3.A.9», «centrarse en la MC» | Resueltas en el texto (misma forma que el 3.A.9) y en los minutos (I.2.2 recibe 3,5 de los 5 minutos de I.2) |
| P10, P11 (notas de pizarra) | Dejar C escrita; tener ambos problemas enfrentados | En `notaopositor` del bloque I y en «Instrucciones para el vídeo» |
| P12, P13, P16 (notas) | «Muy rápido hasta los plazos»; aviso de que es análogo al 3.A.8; hacer aquí el largo plazo | Minutos del II; aviso en una frase (análogas a las hicksianas, 3.A.9); orden: q (largo plazo) → w⃗ → plazos |
| P14 (nota) | Elasticidad del CMg respecto al precio de un factor; plazos de Marshall y Viner | Añadidos: ∂CMg/∂w_i = ∂z_i(w⃗,q)/∂q y envolvente con Viner |
| P15, P24, P27 (notas y comentarios) | Ver Tugores y Gravelle | Gravelle y Rees (2004) citado; Tugores no identificado (ver Dudas) |
| P17, P26 (nota y comentario) | ¿Factores Giffen? | Resuelto en el texto (no, por la concavidad de C y la convexidad de B) y en una `notaopositor` |
| P18 (nota) | Slutsky «solo si sobra tiempo» | Una línea en el cuerpo; derivación detallada al anexo `anexo:estatica` |
| P20 (advertencia) | «Menor que uno son economías de escala» | `notaopositor` de trampa de test |
| P21 (advertencias) | La Imagen 8 es el primal de Segura | Gráfico rehecho con la isocuanta fija (`demanda-condicionada-w`) |
| P22, P23, P25, P28 (comentarios) | Clases, «cantado con… (grabado)», nombres inventados | No se publican; los nombres se sustituyen por los de los manuales (senda de expansión, curva de Engel del factor, demandas condicionadas y no condicionadas, ε_{C,q}, ε_{C,w_i}; sin SCEDIC/SCEDINC) |
| P33, P35, P36 (foto de la pizarra, idea de estructura, correo) | Privados | No se publican; el correo decide el enfoque MB-MC del bloque I |
| P37 (caja de anotaciones, MB con un factor) | Ejemplo gráfico con isobeneficios | Conservada en `anotaciones`, con el gráfico `mb-un-factor` |
| P38 (caja de anotaciones, integrabilidad) | Teorema de integrabilidad de la demanda | Conservada en `anotaciones`, ajustada a las condiciones del 3.A.9 y con el análogo de la empresa |
| P39 (caja, ley de proporciones variables) | U del CMe a largo plazo por proporciones variables | Reescrita: dos explicaciones para dos curvas |
| P41.1-P41.12, P41.18-P41.22, P41.27-P41.28 | Imágenes, capturas y tablas de I y II | Sustituidas por los 16 gráficos TikZ pedidos y por tablas LaTeX; las capturas de Pérez Domínguez, la página escaneada (`image4`), el hessiano orlado con notas a mano (`image6-7`) y las de Policonomics (`image24-26`) no se publican |
| P41.17 (tabla escaneada de la nota 7) | Beneficio contable frente a económico | Se quita; la definición de coste de oportunidad queda en la introducción (notas 7 y 8 unificadas) |
| P41.23 (`image19.png`, notas a mano) | Rendimientos y economías, con y sin homoteticidad | Convertida en la tabla de color `tab:rendimientos-economias` |
| P47 | Autorreferencias «[tema 3.A.12]» | Quitadas («esta exposición») |
| P79-P84 | Nombres de preparadores, correo, capturas con derechos, notas a mano | Nada de ello pasa a la fuente |
| P19 (nota) | III.4 «si sobra tiempo» | `notaopositor` del bloque III: III.4 es de profundización |
| P29, P30, P31 (comentarios) | «Ver tema de…», «coordinar con 3.A.15», economías externas y aprendizaje | No se publican; coordinación con 3.A.15 con `\vertema`; aprendizaje separado de las economías externas |
| P32 (comentario y correo) | Empresa multiplanta | Añadida (III.4.1), con Gravelle y Rees (2004) |
| P3 (Anexo 1) | Rendimientos y economías de escala | El anexo desaparece: la demostración está en el cuerpo (II.1.1) |
| P34 (comentario del Anexo 2) | Coordinar 3.A.8, 3.A.9 y 3.A.12 | Anexo C del 3.A.9 adaptado |
| P40 (caja de anotaciones, III.4.3) | Tres enlaces a Policonomics y una captura de vídeo | La caja no se conserva: el sitio tiene spam oculto inyectado (L1-L8 de datos); la captura se sustituye por el gráfico `aprendizaje` |
| P41.13-P41.16, P41.24-P41.26 | Stigler, subaditividad, alcance, curva de experiencia, MWG §5.D, capturas en inglés | Gráficos TikZ propios (`stigler`, `subaditividad`, `alcance`, `aprendizaje`, `geometria-costes`) y anexo C en LaTeX |
| P44 | Aplicaciones empíricas inexistentes | Bloque IV nuevo |
| P46 | III.1 fuera del índice | Con `\subsection` sale en el índice |
| P85, P86 | «Tema ICEX-CECO», «Tema Juan Luis…», «Tugores», «Gravelle» sin datos | «Tema ICEX-CECO» se mantiene, como en el original, en las lecturas complementarias (CRITERIOS §2); fuera el tema con nombre de preparador y Tugores (sin identificar); Gravelle y Rees (2004) con su entrada |
| P87 | «Preguntas de otros exámenes» vacío | Se quita |
| P88 | Enlace a quia.com | Enlace genérico al simulador en el anexo de test |

## Datos actualizados

El tema es teórico: se comprueban fechas, atribuciones y obras, y se añaden los datos del bloque IV (todos nuevos, sin valor anterior):

| Dato | Valor anterior | Valor nuevo | Fuente | URL | Consulta | Segunda comprobación |
|---|---|---|---|---|---|---|
| Evidencia (antes enganche): economías de escala en la generación eléctrica de EE. UU. | — (enganche de Marshall, paráfrasis no literal) | En 1955 casi todas las empresas tenían economías de escala por aprovechar; en 1970 el grueso de la producción estaba en el tramo casi plano del CMe | Christensen y Greene (1976) | https://doi.org/10.1086/260470 | 14/10/2026 | IDEAS/RePEc; datos de 1970 cotejados con Greene (F4.4) y AER (V22) |
| **Enganche (16/10)**: LCOE medio mundial de la fotovoltaica nueva (E1) | — (enganche de Christensen y Greene) | 0,41 → 0,044 USD/kWh (USD de 2025), −89 % (2010-2025) | IRENA (2026), *Renewable Power Generation Costs in 2025*, apdo. 3.6 | https://www.irena.org/Publications/2026/Jul/Renewable-Power-Generation-Costs-in-2025 | 16/10/2026 | Fichero de datos de IRENA (407,7 → 43,5) y nota de prensa de 2/7/2026 («fallen by 89%») |
| Enganche: tasa de aprendizaje de los módulos (E4); también en II.6.3 con b ≈ 0,45 | — | ≈ 27 % por duplicación de la producción acumulada (26,7 %, unos 45 años) | Fraunhofer ISE, *Photovoltaics Report* (14/7/2026) | https://www.ise.fraunhofer.de/en/publications/studies/photovoltaics-report.html | 16/10/2026 | ITRPV 2026 según PV Tech (26 %, 1976-2025); ITRPV original no leído |
| Enganche: potencia y generación fotovoltaica en España (E6, E7) | — | Más de 41.500 MW (31/12/2025, primera tecnología); 18,4 % de la generación en 2025 | REE, *Las renovables en el sistema eléctrico español 2025* | https://www.sistemaelectrico-ree.es/es/informe-de-energias-renovables/sol/generacion/solar-fotovoltaica-solgeneracion | 16/10/2026 | Nota de prensa de REE de 11/3/2026 (18,4 %); la API REData da 19,1 % (otro denominador): se deja el informe anual |
| Idea final: TIC −6 % en 2025 y LCOE sin bajar por el coste del capital (E2, E3) | — | 667 USD/kW (−6 %); LCOE 44 USD/MWh, plano | IRENA (2026), apdos. 3.3 y 3.6 | ídem E1 | 16/10/2026 | Figura S1 de IRENA y PV Tech (2/7/2026) |
| Wicksell y la U | «Wicksell desarrolla la curva de CMe en U» | Funciones con tramos de rendimientos crecientes, constantes y decrecientes; idea compartida con Barone y Walras | Humphrey (1997), pp. 73-74 | https://www.richmondfed.org/publications/research/economic_quarterly/1997/winter/humphrey | 14/10/2026 | HET (V2) |
| Marshall, economías internas y externas | Sin obra | Marshall (1890), libro IV, cap. IX | Econlib | https://www.econlib.org/library/Marshall/marP.html?chapter_num=24 | 14/10/2026 | marxists.org (V3) |
| Fechas de la dualidad | Sin fechas | Hotelling (1932), Samuelson (1947), Shephard (1953), Uzawa (1964), Diewert (1971, 1974), McFadden (1978) | HET y DOI de cada obra | https://www.hetwebsite.net/het/essays/product/prodintro.htm | 14/10/2026 | OpenAlex (V4) |
| Le Châtelier y Samuelson | Gibbs «con base en» Le Châtelier | Le Châtelier, 1884; Samuelson, *Foundations* (1947); Nobel 1970 | Nobel Prize | https://www.nobelprize.org/prizes/economic-sciences/1970/summary/ | 14/10/2026 | Fechas de Gibbs y Le Châtelier por fuente secundaria (V11) |
| Pérez Domínguez, *Microeconomía avanzada* (UVa) | 2007 en el pie, 2004 en la bibliografía | 2004 (clave `Perez2004Microeconomia`, la de 3.A.9 y 3.A.11) | Portal de la ciencia de la UVa (el libro de 2007 es el de Maté y Pérez) | https://portaldelaciencia.uva.es/documentos/63bf6274f877cf5dadb03baa?lang=en | 14/10/2026 | Material de 2004 no localizado en línea (V7) |
| Eficiencia en costes de la banca de la zona del euro | — | Banco mediano ≈ 84 % (2006-2017); ineficiencia persistente; las grandes, menos eficientes; las pequeñas, más economías de escala | BCE, WP 2305 (Huljak, Martin y Moccero, 2019) | https://www.ecb.europa.eu/pub/pdf/scpwps/ecb.wp2305~f2c93ab1af.en.pdf | 14/10/2026 | BCE, FSR de mayo de 2018, recuadro 6 (82-83 % en 2006-2015) (V28) |
| Ratio de eficiencia de las entidades significativas, 2T 2026 | — | España 42,89 %; supervisión europea 53,06 % (serie 2T 2015-2T 2026 en `datos/ratio-eficiencia-bancos.csv`) | BCE, Supervisory Banking Statistics (SUP) | https://data.ecb.europa.eu/data/datasets/SUP | 14/10/2026 | Nota de prensa del BCE de 15/09/2026 y tabla T02.02.2 de la publicación del 2T 2026 (V29) |
| Economías de escala de la banca española | — | Aumentaron tras la reestructuración posterior a 2012 | Carbó y Rodríguez (2014), *PEE* | https://www.funcas.es/wp-content/uploads/Migracion/Articulos/FUNCAS_PEE/EXT0114art04.pdf | 14/10/2026 | Sin segunda fuente oficial; coherente con el BCE (V30) |
| Regulación alemana por comparación | — | DEA y frontera estocástica obligatorias; se toma el valor más alto; mínimo del 60 % | Bundesnetzagentur | https://www.bundesnetzagentur.de/DE/Beschlusskammern/BK08/BK8_05_EOG/54_Effizienzvgl/start.html | 14/10/2026 | ARegV, § 12 y anexo 3 (V31) |
| Eficiencia del gasto público en la UE | — | Cerca de la frontera en cantidad, lejos en calidad; rendimientos decrecientes; España entre los más eficientes en titulados superiores | Comisión Europea, DP 217 (Canzonieri y Giamboni, 2024) | https://economy-finance.ec.europa.eu/publications/efficiency-public-expenditure-education-and-health_en | 14/10/2026 | IDEAS y texto completo, p. 26 (V32) |
| Estudios españoles con fronteras | — | Puertos de contenedores (función de distancia translog); ayuntamientos valencianos (DEA) | González y Trujillo (2008); Balaguer-Coll, Prior y Tortosa-Ausina (2007) | https://ideas.repec.org/a/eee/transa/v42y2008i1p243-257.html | 14/10/2026 | Versión del Banco Mundial (2005); IDEAS (V33) |
| Christensen y Greene (1976), datos de 1970 | — | 123 empresas, CMe frente a producción (`datos/christensen-greene-1970.csv`) | Greene, tabla F4.4 | https://pages.stern.nyu.edu/~wgreene/Text/Edition7/tablelist8new.htm | 14/10/2026 | Cotejo fila a fila con `AER::Electricity1970` (V22, B.4) |
| Nerlove (1963), Caves, Christensen y Tretheway (1984), Lieberman (1984), Berger y Humphrey (1997) | — | 145 eléctricas de 1955; densidad frente a escala; 37 productos químicos; 130 estudios en 21 países | Resúmenes en IDEAS/RePEc | https://ideas.repec.org/ | 14/10/2026 | OpenAlex por DOI (V21, V23, V24, V27) |

## Contenido añadido

- **Introducción**: enganche propio (C2/K5), definición de coste de oportunidad y de función de costes, relevancia en tres planos, contextualización con las tres líneas (costes, dualidad, estimación) y las críticas, delimitación de «dual» alineada con el 3.A.9 (K9), problemática de K5 y estructura con el bloque IV.
- **I.1**: tabla `tab:ingredientes` (K10) y esquema `esquema-ingredientes-empresa` como el del 3.A.9; supuesto de concavidad solo para la MB.
- **I.2.1**: MB compacta con a)-e), CPO, CSO, por qué hace falta concavidad, propiedades numeradas de z⃗(p,w⃗), q(p,w⃗) y B(p,w⃗), lema de Hotelling, D²B y ausencia de factores Giffen (C5).
- **I.2.2**: MC con μ, μ* = CMg, hessiano orlado en LaTeX, propiedades de z⃗(w⃗,q) (incluida la ley de la demanda condicionada) y de C(w⃗,q) (1-7, con la concavidad por la combinación «pasiva»), matriz S(w⃗,q), ejemplos Leontief, Cobb-Douglas (comprobado con α = β = 1/2: C = 2q√(w_Kw_L)) y homotéticas, tabla de pares `tab:pares-duales` (K11).
- **I.3**: MB en dos etapas, identidades `eq:dual-demanda` y `eq:dual-valor` (K12), gráfico conjunto `mb-mc` (K13), asimetría B/C, ejemplo con F homogénea de grado k < 1 (B = (1−k) p q(p,w⃗), comprobado que ∂B/∂p = q), esquema `esquema-dualidad-empresa`, `ideaclave` y recapitulación. I.3.1 y I.3.2 redactados de nuevo (C9, C10).
- **II.1.1**: al menos un factor normal; Σ s_i ε_{z_i,q} = ε_{C,q}; dCMe/dq = (CMg − CMe)/q; relación general con los rendimientos (demostración y tabla de color); tamaño indeterminado con rendimientos constantes (X9 de coherencia).
- **II.1.2**: elasticidades de la demanda condicionada y Allen-Uzawa, Slutsky de los factores con efecto escala, signo del efecto escala propio, ε_{C,w_i} = s_i con ejemplo numérico, ∂CMg/∂w_i (P14), `notaopositor` de los factores Giffen.
- **II.2**: C(w⃗,q;z̄_K), CMg y CVMe como imágenes invertidas de las productividades, CFMe, mínimos de explotación, envolvente y error de Viner, CMg a corto frente a largo, Le Châtelier-Samuelson con desigualdades, `ideaclave` y puente al III.

- **III.1**: competencia perfecta y monopolio natural uni y multiproducto en forma de resumen, con la subaditividad como definición y el gráfico `subaditividad` (C18, K14).
- **III.2**: economías externas marshallianas frente a aprendizaje (C19).
- **III.3**: Stigler con a)-e) y gráfico propio (C20); Leibenstein con a)-e), C^obs = (1+χ)C, evidencia y réplica de Stigler (1976) (C21).
- **III.4**: empresa multiplanta (nueva), multiproducto (economías de alcance, complementariedad de costes, economías de escala multiproducto) y curvas de aprendizaje (C22).
- **IV.1**: Cobb-Douglas de costes en logaritmos, translog con restricciones, participaciones, ε_{C,q}, elasticidades de Allen-Uzawa y casos anidados, Leontief generalizada y Berndt y Wood (1975) (C23).
- **IV.2**: métodos (estadístico, de ingeniería, del superviviente) y resultados (Nerlove; Christensen y Greene, con el gráfico de datos; densidad frente a escala; costes en L; aprendizaje) (C24, V21-V25).
- **IV.3**: Farrell (EfT, EfA, EfE) con gráfico, frontera estocástica (error compuesto, u_j = ln(1+χ_j)), DEA (CCR y BCC), tabla SFA frente a DEA, Malmquist, evidencia (banca, regulación, sector público, España) con el gráfico de la ratio de eficiencia, tabla de ejemplos por sectores e `ideaclave` (C25-C27, V26-V33).
- **Conclusión**: C29, con la opinión sobre los mercados de factores no competitivos y la idea final que responde al enganche; lecturas complementarias.
- **Anexos**: `anexo:kt`, `anexo:envolvente` (Hotelling y Shephard por la envolvente y por la convexidad o concavidad), `anexo:hessiana` (C30), `anexo:segura` (C11), `anexo:estatica` (elasticidades, derivación de Slutsky de los factores con su simetría, ∂CMg/∂w_i y prueba de Le Châtelier-Samuelson), `anexo:geometria` (C31), `anexo:formas-costes` (C32) y `anexo:test`.

### Estado de las propuestas

| Propuesta | Estado |
|---|---|
| C1 (minutos 2,5/9/7,5/4/6/1 y título del I) | **Rechazada en los minutos y el título**: mandan K2 y K3 (2,5/9/8,5/3,5/5,5/1, título del original). Aplicada la idea de la `notaopositor` |
| C2 | Aplicada (enganche «En los años 70», con la frase de V22); Areeda y Turner citado en la relevancia; Wicksell con la formulación de V2 |
| C3 | Aplicada, con la tabla de K10 (etiqueta `tab:ingredientes`, no `tab:ingredientes-empresa`) y el párrafo de K9 |
| C4 | Aplicada como nota al pie (corrección de la Cobb-Douglas); notas 3, 4 y 6 integradas en la lista de propiedades |
| C5 | Aplicada; la caja con un factor se conserva en `anotaciones` |
| C6 | Aplicada con **μ** en lugar de λ^C, **S(w⃗,q)** en lugar de S^C y **κ** como factor de homogeneidad (decisiones de la integración) |
| C7 | Aplicada (Samuelson fuera de la Idea; atribución de V5 en la contextualización) |
| C8 | Aplicada con las identidades de K12; la frase «de B se obtiene C y viceversa solo si la tecnología es convexa» se reformula como asimetría (B solo existe con rendimientos decrecientes) |
| C9 | Aplicada; la caja de integrabilidad **se conserva** en `anotaciones` (CRITERIOS §3: las cajas de anotaciones se conservan), acortada |
| C10 | Aplicada, sin la notación π⃗ para el vector de precios |
| C11 | Aplicada en el anexo `anexo:segura` |
| C12 | Aplicada (aviso de K15, ecuación de C con dos factores, orden q → w⃗ → plazos) |
| C13 | Aplicada; el «factor frontera» (ε = 0) del original se queda como caso límite sin nombre (no es término de los manuales) |
| C14 | Aplicada, con la tabla en el formato de color de CRITERIOS (fila salvia con la ecuación; crecientes en verde, constantes en azul, decrecientes en rojo) |
| C15 | Aplicada (caja reescrita) |
| C16 | Aplicada; la condición para el signo del efecto escala, con Varian y Gravelle y Rees |
| C17 | Aplicada salvo la anécdota del delineante de Viner, que no he podido comprobar: queda «el error del dibujo original de Viner (1931)» |
| C33 | Aplicada la de los factores Giffen; la de P6 se integra en el texto (sin caja) |
| C34 (recortes 1, 2, 3, 4, 5, 7, 8) | Aplicados: notas 7/8 unificadas en la introducción, nota 1 reducida a la remisión, nota 2 suprimida, nota 35 en dos líneas, notas «por el teorema de…» integradas, RMST explicada una sola vez por problema, II sin repetir el problema |
| C35, C36, C37, C39 | Aplicadas (salvo θ → k de C36: se usa κ, CC3 de coherencia) |
| K2, K3, K4, K5, K6, K8, K9, K10, K11, K12, K13, K15, K17, K18, K19 | Aplicadas en I y II (K19 con μ en lugar de λ^C) |
| K12 (recíproco C = max_p {p q − B}) | No escrito: hay que verificarlo en la fuente antes (Varian, cap. 6) |
| V2, V3, V4, V5, V7, V11, V22 | Aplicadas |
| V1 (cita literal de Marshall) | No se usa: el enganche es el de Christensen y Greene |
| C18 | Aplicada con el título del original (no «Extensiones y críticas…») y los minutos de K2 (3,5); se conservan los tres títulos de tercer nivel de III.1, muy reducidos |
| C19, C20, C21, C22 | Aplicadas. C21 sin la redacción literal de los supuestos de Leibenstein (de memoria: se dejan como paráfrasis); C22 sin la cifra del 80 % de Wright, que solo está en fuentes secundarias contradictorias (V24) |
| C23 | Aplicada, con S(w⃗,q) en lugar de S^C |
| C24 | Aplicada con `CavesChristensenTretheway1984Density` y la frase de V23 |
| C25 | Aplicada con EfT, EfA, EfE (CC7) en lugar de ET, EA, EE (ET es el excedente total) y la variable e en lugar de θ (θ es la CRRA en el canon); la evidencia de Hughes y Mester (2013) no se usa (sin verificar la versión publicada) y se sustituye por la del BCE (V28) |
| C26 | Aplicada como tabla al final de IV.3 (no como IV.4: K1 fija tres subapartados), con las filas de banca europea, redes alemanas y gasto público de la UE en lugar de las de Hughes y Mester |
| C27 | Aplicada (`ideaclave` y recapitulación) |
| C28 | Aplicada (el anexo 1 desaparece) |
| C29 | Aplicada, con las extensiones de K7 |
| C30, C31, C32 | Aplicadas; C30 copia los puntos del anexo C del 3.A.9 para que el tema se lea solo |
| C33 (III.4) | Integrada en la `notaopositor` del bloque III |
| C34.9, C34.10 | Aplicadas |
| C38 | Aplicada (anexo de test) |
| C40 | Entradas incorporadas al `.bib` (ver Dudas, 7) |
| K1, K7, K14, K16, K20, K21 | Aplicadas. K16: sin anexo F (la demostración está en el cuerpo) y con el anexo de formas funcionales de C32 |
| V12, V13, V20-V33 | Aplicadas; V13 sin citar Policonomics ni Yerkes-Dodson |
| V14 (nota 2: tecnologías del consumo) | No aplica: la nota se suprime (C34.3) |
| L1-L8 (Policonomics) | **No se enlazan** ni entran en la bibliografía: el sitio tiene spam oculto inyectado; los gráficos son propios y el contenido se cita a manuales y artículos |

## Coherencia

- Misma forma que el bloque I del 3.A.9 (K8): tabla de ingredientes, a)-e), propiedades numeradas, «lema de Shephard», «ley de la demanda condicionada», «sin exceso de producción», tabla de pares, gráfico conjunto y esquema por capas. El lema de Hotelling hace el papel de la identidad de Roy, como dice el 3.A.11 (`anexo:productor`).
- Delimitación de «dual» igual que la del 3.A.9 (introducción y su nota 1, que remite al 3.A.12): sentido estricto (Segura) frente a amplio (MB-MC).
- ε_{q,λ} = CMe/CMg a lo largo de la senda de mínimo coste en general, como el 3.A.11 revisado (l. 796); se corrige el original, que la limitaba a las homotéticas. La ficha `rendimientos-escala` dice «con homotéticas» en la fila 3.A.12: anotar en `canon/pendientes-coherencia.md`.
- **Contradicción con el 3.A.11 (anexo `anexo:productor`)**: «B creciente en p, decreciente en w⃗»; lo correcto es no decreciente y no creciente (MWG, prop. 5.C.1). Para `pendientes-coherencia.md` (CC11). No se toca el 3.A.11.
- **Notación frente al canon**: `notacion.md` fija λ^C para el multiplicador de la MC; aquí se usa **μ** por decisión de esta integración (paralelo al dual del consumidor del 3.A.9). Hay que proponer el cambio al canon (`notacion.md` §0 y la fila de λ) si Víctor lo confirma. También κ (CC3) y S(w⃗,q) (CC4), propuestos al canon por coherencia.
- Referencias «[ver tema …]»: Slutsky de los factores remite al 3.A.9 (no al 3.A.8; el `mapa.yaml` está desfasado, CC5); añadidas 3.A.16 (oferta, tamaño indeterminado, mínimos de explotación), 3.A.17 (estructura de mercado), 3.A.20 (regulación), 3.A.25 (demanda derivada de trabajo), 3.B.6 (comercio). Ninguna frase dice que algo «se estudió» en otro tema (K18).
- Contradicciones con otros temas que no se tocan (de K, sección 5): X1 (mismo enganche en 3.A.16-3.A.19), X2 (3.A.16: C_i(q_i,w⃗)), X3 (3.A.17: economías de alcance frente a subaditividad), X4 (3.B.4: Stigler con captura de Policonomics). X5-X10 en `propuestas-coherencia.md`, sección 5.
- Bloque III sin solapes (K14): competencia perfecta y monopolio natural en resumen con remisión a 3.A.16, 3.A.17 y 3.A.20; la subaditividad y las economías de alcance, una sola vez. Stigler (ficha `stigler-costes`) e ineficiencia X (ficha `ineficiencia-x`) con el 3.A.12 como tema de referencia; el gráfico `subaditividad` debe ser el mismo en el 3.A.17 y el de `stigler`, el del 3.B.4 (X3, X4).
- Translog del IV.1: misma forma que la del 3.A.9 (ficha `sistemas-demanda`, que debe pasar de «mención» a «resumen» en el 3.A.12, CC9).
- **Propuestas al canon** (para `--fase coherencia`): μ como multiplicador de la MC (en lugar de λ^C); κ como factor de homogeneidad en precios (CC3); S(w⃗,q) para la matriz de sustitución de factores (CC4); C(w⃗,q;z̄_K), CV, CFMe, ε_{C,q} y s_i en `notacion.md` § 3 (CC1); EfT, EfA, EfE y la frontera ln C_j = ln C(w⃗_j,q_j) + v_j + u_j con u_j = ln(1+χ_j) (CC7); fichas nuevas `dualidad-produccion`, `costes-corto-largo-plazo`, `eficiencia-frontera` y, si se confirma su uso en dos temas, `curva-aprendizaje` (CC8); entradas desfasadas de `mapa.yaml` y de la ficha `rendimientos-escala` (CC5).
- Referencias añadidas en III y IV: 3.A.15 (organización industrial, límites de la empresa, contratos), 3.A.16, 3.A.17 (monopolio natural, Harberger, monopsonio), 3.A.19 (oligopolio), 3.A.20 (regulación por comparación), 3.A.21 (precios de factores endógenos), 3.B.6 y 3.B.8. No se remite al 4.º ejercicio.

## Instrucciones para el vídeo

- Bloque I: el esquema de dualidad de la empresa (`esquema-dualidad-empresa`) se construye por capas en la columna derecha durante todo el bloque (MB, sus soluciones y B con Hotelling; MC, z⃗(w⃗,q) y C con Shephard; MB en dos etapas con p = CMg; identidades; recuperación de la tecnología). En la columna izquierda se dibujan y borran `mb-un-factor` (si da tiempo), `mc` con la lagrangiana y las CPO, `concavidad-c` y, al final, el gráfico conjunto `mb-mc`. Al acabar el I quedan el gráfico conjunto y el esquema completo, con C(w⃗,q) escrita: el bloque II empieza por ella (P10, P11).
- Bloque II: `senda-expansion` | `costes-largo` (50 | 50), con ε_{C,q} y la ecuación de Slutsky de los factores en una línea; después, `envolvente` construida por capas a pantalla completa.
- Bloque II, tabla de fases a corto plazo (`tab:fases-coste`) como apoyo junto a `costes-corto`; extensiones (II.3-II.6, 50 | 50): `stigler` y la fórmula C^obs = (1+χ)C; II.3, II.4 y II.6, sin pizarra (como mucho, `subaditividad` de apoyo).
- Bloque III (50 | 50): la translog de costes y las participaciones s_i en una celda y `farrell` (EfT, EfA, EfE) en la otra; III.2 de palabra, con `christensen-greene-1970` como apoyo; `ratio-eficiencia-bancos` y las tablas, solo de apoyo.
- La idea final responde a la pregunta del enganche (¿cuánto del abaratamiento de la fotovoltaica se debe a la escala, al aprendizaje y a los precios de los factores?).

## Dudas abiertas

1. **Estructura** (16/10/2026, provisional): tres apartados, I Dualidad · II Análisis de los costes: estática comparativa, plazos y extensiones (el antiguo III como II.3-II.6, con sus títulos de segundo nivel) · III Aplicaciones empíricas; minutos 2,5 · 9 · 12 · 5,5 · 1. Pendiente de que Víctor la confirme.
2. **Dualidad**: el cuerpo sigue el enfoque de los manuales (MB-MC, Shephard, Hotelling, recuperación de la tecnología) y el primal de Segura pasa a un anexo. ¿Confirmas?
3. **Notación**: μ para el multiplicador de la MC (el canon dice λ^C; habría que cambiar `notacion.md`), λ para la escala, κ para el factor de homogeneidad en precios, S(w⃗,q) para la matriz de sustitución de factores, «efecto escala». ¿Confirmas?
4. **Enganche** (16/10/2026): fotovoltaica (IRENA, Fraunhofer ISE, REE); Christensen y Greene (1976) queda como evidencia en III.2. El 18,4 % de REE no coincide con el 19,1 % de su API (otro denominador); si se prefiere, «casi una quinta parte». No se usa la variante de la subasta de 2021 (`BOE2021SubastaREER` no entra en el `.bib`).
5. **Policonomics**: el sitio tiene enlaces de spam ocultos inyectados en el HTML. No se enlaza ni se cita; los gráficos que salían de allí se rehacen en TikZ y el contenido se cita a manuales y artículos. ¿De acuerdo?
6. **Fuentes por cotejar**: año de Segura (1986, Alianza, frente a «1996» del original); páginas 15, 23, 24 y 26 de Pérez Domínguez (2004), que se citan tal como venían en las notas; capítulo de Gravelle y Rees (2004) para la ecuación de Slutsky de los factores y ∂CMg/∂w_i; **Tugores** (obra y edición sin identificar: no se cita); Le Châtelier (1884), título y páginas finales.
7. **Entradas del `.bib` puestas de memoria** (propuestas de contenido, sin comprobar volumen y páginas): `AreedaTurner1975Predatory` (citada en la introducción), `Chambers1988Applied` (no citada), `JondrowEtAl1982Estimation`, `BankerCharnesCooper1984Some`, `BerndtWood1975Technology`, `JamasbPollitt2001Benchmarking`, `Shleifer1985Theory`, `Johnston1960Statistical`, `Stigler1976Xistence`, `Nickell1996Competition`, `BloomVanReenen2007Measuring`, `Baumol1977Proper`, `Koutsoyiannis1979Modern`. Claves unificadas con las de temas anteriores: `MatePerez2007Microeconomia` y `Perez2004Microeconomia` (en vez de las de `bib-datos.bib`), `CavesChristensenTretheway1984Density`, `MeeusenVandenBroeck1977Efficiency` y `BNetzA2026Effizienzvergleich` (en vez de las de contenido). Las notas internas («SIN COMPROBAR», «verificar») de las entradas no pasan al `.bib`.
8. **Unidades de los datos de Christensen y Greene** (coste en millones de dólares, producción en millones de kWh): deducidas, sin comprobar en el artículo. El gráfico rotula «dólares por MWh».
9. **Contenido sin poder comprobar en la fuente original**: la redacción de los supuestos de Leibenstein (1966, p. 407); la conclusión de Berndt y Wood (1975), que es conocida pero está puesta de memoria; los resultados por industrias de Stigler (1958), Johnston (1960) y Walters (1963), que el texto da sin cifras (solo «costes en L»); la cifra de Wright (1936), que no se da; el capítulo de Marshall sobre las economías externas.
10. **Bloque III**: se conservan los títulos de tercer nivel de III.1 (competencia perfecta, monopolio natural uni y multiproducto), muy reducidos; la alternativa era pasarlos a un anexo.
11. **Ejemplos españoles**: los únicos con fuente comprobada son el BCE (ratio de eficiencia y banca europea), Carbó y Rodríguez (2014), puertos y ayuntamientos valencianos. No hay estudios con fronteras de la AIReF, la CNMC ni el Banco de España (V33, «no encontrado»).
12. **Aviso de compilación** (resuelto en el control de calidad): la URL de la Bundesnetzagentur desbordaba 43 pt en la bibliografía; el preámbulo del tema permite ahora cortar las URL en cualquier letra o número (`\setcounter{biburl…penalty}{9000}`). Si se quiere para todos los temas, habría que llevarlo a `tcee.sty`.
13. **Año de Jamasb y Pollitt**: Crossref fecha el número 9(3) de *Utilities Policy* en 2000; el `.bib` (y la clave) dicen 2001, que es el año con que suele citarse. Comprobar en la revista y, si es 2000, cambiar el año (la clave puede quedarse).
14. **Entradas de memoria (duda 7)**: el control de calidad ha cotejado en Crossref `BankerCharnesCooper1984Some` y `BerndtWood1975Technology` (coinciden volumen, número y páginas); las demás siguen sin comprobar en línea.
15. Control de calidad: sin incidencias pendientes tras las correcciones (14/10/2026). Corregido en esta fase: título del bloque I partido en tres líneas (quedaba «costes.» sola) y título de I.3 en dos; condición suficiente de subaditividad multiproducto (economías de alcance más coste incremental medio decreciente en cada producto, Baumol, Panzar y Willig, 1982); caso 6 del anexo de geometría alineado con su gráfico (CVMe en U) y con la diferencia respecto a Mas-Colell et al. (costes variables convexos: toda la curva de CMg); «Su regulación se estudia en…» sustituido por una remisión; superíndices «obs» y «ac» en redonda (texto y gráfico `aprendizaje`); fracción en línea de II.1.2.
16. **Notas recuperadas el 16/10 sin fuente nueva consultada**: en la de Samuelson, que llegó a Gibbs a través de E. B. Wilson (lo cuenta él mismo en su conferencia Nobel, citada de memoria) y la motivación del Nobel (parafraseada de la página de la Fundación ya citada); en la de Wicksell, la atribución (Humphrey, 1997, ya en el `.bib`). Conviene cotejarlas.
17. **Fallos comunes a todos los temas (no de este)**, vistos en el control de calidad del 16/10/2026: (a) en el PDF, `\min` sale «mın», sin el punto de la i (babel en castellano acentúa los operadores y newpxmath pierde el acento; también en el 3.A.9 y el 3.A.11): se arreglaría con la opción `es-noaccentedop` de babel en `tcee.sty` y reconstruyendo todos los temas; (b) en el Word, las tablas no llevan «Tabla n.–» en el título (los gráficos sí), aunque el texto remite a ellas por número; (c) en el índice lateral del HTML, los minutos de un apartado de título largo (aquí «5′30″» del III) bajan a la línea del primer subapartado. ¿Se corrigen en `tcee.sty`, `construir-tema.py` y `tema.css` para todos?
18. Control de calidad: sin incidencias propias del tema (16/10/2026), salvo los fallos comunes de la duda 17. Corregido en esta fase: el esquema de Segura (gráfico 24) y el de dualidad (gráfico 6) salen ahora a todo el ancho en el HTML y el Word (`\grafico[1\linewidth]` y `[1\textwidth]`: pandoc no traduce `\linewidth` solo y los dejaba a 560 px, ilegibles); la URL de la potencia de REE pasa a `\url{}` en la nota de la entrada (salía como texto sin cortar en la bibliografía); «Estado» de este informe al día (25 gráficos, 60 páginas).

## Cambios del 16/10/2026 (comentarios de Víctor)

1. **Tres apartados**: I «Dualidad…» (sin cambios de título) · II «Análisis de los costes: estática comparativa, plazos y extensiones» (II.1 estática comparativa, II.2 plazos, II.3 implicaciones sobre la estructura de mercado, II.4 economías de escala, II.5 críticas desde la organización industrial, II.6 otras extensiones: los títulos de segundo nivel del antiguo III se conservan como II.3-II.6) · III «Aplicaciones empíricas…» (el antiguo IV). `\minutos`: 2,5 · 9 · 12 · 5,5 · 1 = 30 (construir-tema.py: 30 min). Puestos al día la «Estructura» de la introducción (con viñetas de segundo nivel), el esquema de pizarra, la nota del reparto (II.1 4′, II.2 4′30″, II.3-II.6 3′30″), la `notaopositor` del II (fusión de las del II y el III), la conclusión anticipada del II (tres viñetas), la recapitulación intermedia («Recapitulando lo visto hasta aquí») y la final del II, la conclusión ((II), (III)) y todas las referencias a apartados: IV.1-IV.3 → III.1-III.3, III.3.1 → II.5.1, III.4.2 → II.6.2, III.4.3 → II.6.3, «apartado IV» → III. Las `\ref` a anexos, figuras y tablas siguen bien (sin referencias sin definir).
2. **Enganche nuevo** (fotovoltaica, `propuestas-enganche.md`, datos E1, E2, E3, E4, E6 y E7): sustituye al de Christensen y Greene, que se queda como evidencia en III.2; la idea final retoma la pregunta del enganche. Entradas `IRENA2026CostesGeneracion`, `FraunhoferISE2026Photovoltaics` y `REE2026RenovablesSol` fusionadas en `3A12.bib`. En II.6.3, frase con b ≈ 0,45 (27 % por duplicación). Sin la variante de la subasta.
3. **Segundas derivadas de B y de C** como en el tema antiguo: matriz D²B(p,w⃗) completa (ecuación `eq:matriz-beneficio`) = (por Hotelling) la matriz de ∂q/∂p, ∂q/∂w_j y −∂z_i/∂p, −∂z_i/∂w_j, con su simetría (las dos implicaciones) y su semidefinición positiva (diagonal no negativa: ley de la oferta y −∂z_i/∂w_i ≥ 0); matriz S(w⃗,q) con S_ij ≡ ∂²C/∂w_i∂w_j = (por Shephard) ∂z_i/∂w_j y la llave «∀ i, j», simétrica, semidefinida negativa y con S w⃗ = 0⃗. Notación del canon (D²B sin letra, S y no Σ/ς ni Ξ). Corregida una errata del original: la última columna de la primera fila de Ξ decía ∂²B/∂p∂w_1 en lugar de ∂²B/∂p∂w_n.
4. **Esquema de la Imagen 3** en el anexo `anexo:segura`, en una página apaisada (`pdflscape`, entorno `landscape`, en el preámbulo del tema; no se toca `tcee.sty`), gráfico~24, con pie y fuente «elaboración propia a partir de Segura (1986) y Maté y Pérez (2007, pág. 108)». En HTML y Word sale a ancho completo (pandoc lo lee como un bloque normal; comprobado: 25 imágenes en el Word). El texto del anexo explica las cuatro erratas corregidas respecto al cuadro anterior (Shephard sin signo menos; identidades C(w⃗,χ(w⃗,C̄)) = C̄ y χ(w⃗,C(w⃗,q)) = q; w⃗·z⃗(p,w⃗) en el beneficio; rótulos de las flechas cruzadas) y añade la identidad de Roy de la empresa que muestra el esquema.
5. **Senda de expansión**: sin mención del rayo homotético en el pie ni en el texto que comenta el gráfico (la frase general «si F es homotética, la senda es un rayo» se mantiene como resultado teórico, con su nota). Quitado también de la descripción de `graficos-pedidos.json`.
6. **Fases del coste en elasticidades**: párrafo nuevo en II.2 («Fases del coste a corto plazo en términos de elasticidades») con ε_{CV,q} = CMg/CVMe = PMe_L/PMg_L = 1/ε_{q,z_L} (ecuación `eq:elasticidad-cv`) y tabla `tab:fases-coste` con los mismos tramos y colores que la `tab:etapas` del 3.A.11 (etapa I naranja, II verde, III roja, márgenes extensivo e intensivo), fila salvia con la ecuación y nota con el óptimo de explotación (ε_{C,q} = 1) dentro de la etapa II. El largo plazo remite a `tab:rendimientos-economias` (ya tenía ese formato). Añadida la entrada `Cassels1936Law` (copiada del 3.A.11).
7. **Dos puntos al final de fórmulas**: quitados en `eq:cpo-mb`, `eq:cpo-mc`, `eq:cmg-precio` y `eq:cmg-corto` (ahora punto y la frase siguiente con mayúscula). Comprobado con un script que ninguna fórmula en display (equation, align, \[…\], funcionclave) acaba en «:».
8. **Envolvente**: texto y pie con los dos paneles (costes totales arriba; medios y marginales abajo) y las tangencias en q_1, q_2, q_3 (el texto no da números, así que no hay que ajustar 2,2, 5 y 7,8). Nota 34 recuperada y razonada (si los CT son tangentes en q, coinciden el valor, el CMe y la pendiente, el CMg). Ancho 0,7.
9. **Geometría de los costes**: ancho 0,92 (cabe con su pie en una página del anexo); el texto del anexo explica los dos pisos (tecnología con un factor y 𝒴 arriba, C(q) = F⁻¹(q) con w = 1, rayo tangente = producto medio máximo = CMe mínimo; costes y oferta abajo) y el pie lo dice.
10. **Criterios generales**:
   - `\optim` en todos los problemas: MB (`eq:mb`, `eq:funcion-beneficio`), MC (`eq:mc`, `eq:funcion-costes`), MB en dos etapas, función soporte, corto plazo (`eq:mc-corto`), multiplanta (nuevo display), DEA (`eq:dea`), primal de Segura y los dos problemas del anexo de Kuhn-Tucker.
   - `\funcionclave`: C(w⃗,q) (`eq:funcion-costes`), B(p,w⃗) (`eq:funcion-beneficio`) y el lema de Shephard (`eq:shephard`). Siguen con `\boxed` negro ε_{q,λ} = 1/ε_{C,q} y la función de costes a corto plazo.
   - Viñetas de varios niveles en la estructura, la conclusión anticipada del II, los mínimos de explotación, las propiedades de D²B y el anexo de geometría.
   - **Notas al pie del original** (37; el tema tiene ahora 18):

| Nota | Decisión |
|---|---|
| 1 (individualismo metodológico) | Recuperada, revisada (introducción) |
| 2 (consumidores y productores; tecnologías del consumo) | Recuperada, revisada, con Ekelund y Hébert (2013), Lancaster (1966), Becker (1965), Gronau (1977) y Stigler (1961), que ya estaban en el `.bib`; sin la cita entre comillas de Ekelund y Hébert (no comprobada literalmente) |
| 3 (eficiencia técnica), 4 (continuidad) | Ya eran notas al pie: se mantienen |
| 5 (cuasiconcavidad) | Ya era nota (con el error de la Cobb-Douglas corregido); el párrafo sobre Adam Smith se descarta (atribución sin fuente) |
| 6 (concavidad estricta; rendimientos constantes en distribución y crecimiento) | Recuperada, revisada (I.1) |
| 7, 8 (coste económico y de oportunidad) | Descartadas: están en las definiciones básicas de la introducción; la tabla escaneada de la 7 no se publica |
| 9 (MB en dos etapas) | Descartada: está desarrollada en I.3 |
| 10 (errónea: «F convexa») | Descartada: la versión correcta está en el texto («Por qué se exige concavidad») |
| 11, 15, 19 («ver página … de Pérez Domínguez») | Descartadas: notas de trabajo; la obra se cita en el texto |
| 12-14, 16, 17, 20, 21 («por el teorema de…») | Descartadas: integradas en las propiedades (Berge, función implícita, envolvente), con los errores corregidos |
| 18 (multiplicador de Lagrange) | Descartada: está en el texto (μ* = CMg) |
| 22 (elasticidad de sustitución y concavidad) | Recuperada como nota (sale del texto), con el caso de Leontief |
| 23 (diagonal de S) | Recuperada, corregida (demanda **condicionada**, diagonal **no positiva**) y con el aviso de que el recíproco no vale |
| 24 (senda hacia atrás; capital inferior) | Recuperada (II.1.1) |
| 25 (homotética: senda recta, factores normales) | Recuperada como nota (sale la frase del texto) |
| 26/33 (CMe y secante), 27/32 (CMg y curvatura) | Recuperadas una vez cada una en II.1.1; las repetidas del corto plazo (32, 33) se descartan |
| 28 (forma en S; Cobb-Douglas «convexa») | Descartada: la caja de anotaciones de II.1.1 ya lo dice, corregido |
| 29 (Wicksell, rendimientos mixtos) | Recuperada, revisada (sin «el primero» ni «inflación»), con Humphrey (1997) |
| 30 (errónea) | Descartada |
| 31 (ε_{CMe,w_i} = s_i) | Recuperada con la derivación; el texto se acorta |
| 34 (envolvente) | Recuperada (punto 8) |
| 35 (Samuelson) | Ampliada: estática comparativa, principio de Le Châtelier, su llegada a Gibbs a través de E. B. Wilson (sin el anacronismo del original) y el Nobel de 1970 |
| 36 (p ≤ CMg) | Se mantiene en I.3; se quita la copia de II.3 |
| 37 (costes evitables y hundidos en MWG 5.D) | Recuperada en el anexo de geometría |

   Ninguna nota lleva gráfico: la nota 34 tenía una captura de Policonomics (no se usa). Si se quiere, puede dibujarse un detalle pequeño de la tangencia (`\graficonota`).
11. Construido en PDF (60 páginas: tema 46, anexos 9, bibliografía 5), HTML y Word, sin avisos de LaTeX; `verificar-tema.py`: 0 errores (solo los avisos de guion y vídeo pendientes). Revisadas renderizadas las páginas 1, 3, 9, 13, 29, 31, 32, 46, 47, 51 (apaisada) y 54.
