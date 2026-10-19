# Revisión del tema 3.A.10 (19/10/2026)

Teoría de la demanda del consumidor (III). Elección del consumidor en situaciones de riesgo e
incertidumbre. Fase «integrar» de /revisartema. Entradas: `_trabajo/original.md` (Word de
`oculto/`, 10/08/2024), `pendientes.md` (P1-P71), `propuestas-contenido.md` (C1-C58),
`propuestas-datos.md` (V1-V92), `propuestas-coherencia.md` (K1-K48, D1-D8) y `bib-datos.bib`.

## Resumen

- Se mantienen los 3 bloques y los 7 apartados de segundo nivel del original (riesgo: utilidad
  esperada; riesgo: críticas y alternativas; incertidumbre), con títulos algo retocados («(I)»,
  «(II)», «Teoría de las perspectivas» en lugar de *Prospect Theory*) y la estructura a)-e) en
  cada modelo. Reparto: introducción 2'30", I 13', II 8', III 5'30", conclusión 1' (30').
- Se corrigen unos 40 errores (fechas, atribuciones, axioma de independencia, seguros, Schmeidler,
  criterios de decisión, Nobel, San Petersburgo, Diamond-Dybvig) y se unifica la notación con el
  canon (x̃, π_s, U(x̃) = 𝔼[u(x̃)], r_A, r_R, θ, W̄, γ, τ, 𝓛, 𝒫).
- Contenido nuevo: teorema de Pratt, CARA/CRRA/HARA, prudencia, aproximación de Arrow-Pratt,
  dominancia con las funciones de distribución, demanda de un activo con riesgo (Arrow) y empresa
  aversa al riesgo (Sandmo) como «no se canta», teoría de las perspectivas con fórmulas y patrón
  cuádruple, otras teorías no esperadas, Savage con actos, Ellsberg completo, modelos de ambigüedad
  y criterios clásicos con una matriz nueva.
- Anexos: A cardinal-ordinal, B San Petersburgo, C Diamond-Dybvig **resumido** (decisión de
  Víctor), D media-varianza, E derivaciones (nuevo), F test y tribunal. Bibliografía nueva en
  biblatex (unas 140 entradas; las citas, todas con `\textcite`/`\parencite`).
- Construido con `construir-tema.py` (PDF, web y Word): tema 35 páginas, anexos 7 y bibliografía 6;
  `verificar-tema.py` sin errores. Los 12 gráficos están hechos en TikZ (11 figuras y el de la nota de
  las 3 actitudes). Faltan el guion del cante y el vídeo (entrega 3).

## Errores corregidos

| Dónde | Decía | Dice ahora |
|---|---|---|
| Nota 3 | *Theory of Games…* «publicada en 1994»; «casa bien»; «la utilidad del café era el doble que la del té» | 1944, con la derivación axiomática en el apéndice de la 2.ª ed. (1947); el «doble» solo con la normalización u(nada) = 0 (escala de intervalo) |
| Introducción | Etimología del «veneciano *rischio*» y los escollos de los puertos | DLE: del antiguo *riesco*, «risco» (V31) |
| Nota 5 | Motivación del Nobel de Kahneman mezclada con la de Vernon Smith | Motivación oficial de Kahneman y mención aparte de Smith (V22) |
| Introducción | Tversky «hubiera recibido el galardón» | Falleció en 1996 y el premio no se concede a título póstumo |
| I.1.1, axiomas 2-3 y notas 17-18 | Axiomas escritos sobre ℝⁿ₊ | Sobre 𝓛 (loterías) |
| I.1.1 y II.1 | «Independencia de alternativas irrelevantes» | Axioma de independencia (la IIA es la de Arrow; se aclara en una nota) |
| I.1.1, continuidad | p ∈ (0,1) | τ ∈ [0,1] (MWG 6.B.3) |
| I.1.1, independencia | Un solo sentido y cuantificadores mal colocados | «Si y solo si», τ ∈ (0,1) |
| I.1.1 | V(ỹ), V(F), U(F), ū(ỹ), E[u(ỹ)] para lo mismo | U(x̃) = 𝔼[u(x̃)] (función clave) |
| I.1.2, l. 478 | Invariante ante «transformaciones lineales crecientes» | Afines positivas |
| I.1.2, l. 508 | «ESI ≡ σ = 1/θ»; θ «representa la elasticidad de la utilidad marginal» | ESI = 1/θ; r_R es esa elasticidad cambiada de signo |
| Nota 22 | La continuidad de u se debe al axioma de continuidad | Se supone (el axioma es sobre mezclas de loterías) |
| I.1.2, dominancia | Definiciones con u′ > 0; «basadas únicamente en esperanza y dispersión»; nota 29 («preferirán la lotería B») y nota 30 («de naturaleza ordinal») | u no decreciente; caracterización F ≤ G y por las integrales; orden parcial; las notas 29 y 30 desaparecen |
| I.1.2, l. 566 | Media-varianza justificada por el teorema central del límite | Utilidad cuadrática o rendimientos normales (elípticos): Tobin (1958), Chamberlain (1983) |
| I.1.2, nota al opositor | «La aversión al riesgo es condición necesaria» del ahorro precautorio | La condición es u‴ > 0 (prudencia), necesaria y suficiente; la DARA la implica |
| I.2, título | «Modelo de Rothschild y Stiglitz, 1976» | Demanda de seguros (Mossin, 1968); Rothschild-Stiglitz es la selección adversa del 3.A.13 |
| I.2 | A = (p₁, p₂; W, W − **P**) | A = (W̄, W̄ − L) |
| I.2 | −dx₂/dx₁ = −(1 − r)/r | Pendiente −(1 − γ)/γ; RMSE en valor absoluto |
| I.2 | Prima favorable = «competencia imperfecta» | Favorable (γ < π) solo con subvención; la recargada es la habitual |
| I.2, tabla de 10 gráficos | Celdas incoherentes (sobreaseguro permitido en una fila y no en otra) | Tabla en color con 0 ≤ S ≤ L |
| I.3 | «Falta de realismo… limitada aplicación práctica» | Valoración del 3.A.21 (equilibrio y mercados incompletos en el 3.A.21) |
| II.1 | Crítica de los casinos atribuida a Friedman-Savage y repetida en la nota 40 | Es de Markowitz (1952b) |
| II.1, Allais | Ejemplo 110 €/100 € no clásico, «más pago esperado», «añadir una alternativa irrelevante», enlace de YouTube | Versión clásica (Allais 1953, MWG), consecuencia común, derivación en el anexo E |
| Nota 41 | «Precio mínimo»; medalla de bronce; «la gente aprende y corrige» | Efecto consecuencia común y razón común (Kahneman y Tversky, 1979, problemas 3-4); se quita lo no documentado |
| II.2 | Colaboración de Kahneman y Tversky «desde los años 50 en el ejército»; «capitán de paracaidistas» | Desde 1969, en la Universidad Hebrea; en los 50, cada uno por su lado (Kahneman, 2002) |
| II.2 | Anécdota del nombre atribuida a Bernstein | Fuente primaria: autobiografía de Kahneman |
| II.2, l. 932 | *framework effect* | *framing effect* |
| II.2 | «Siempre rechazamos…» | «La mayoría rechaza…» |
| II.2, conclusión | «Cuatro décadas de vida» | «Casi medio siglo» |
| Caja *behavioral finance* | Remisión a 3.B.24; «más de 6 puntos» sin fuente; dividendos «tributaban más hasta ahora» | 3.A.1 y 3.B.23; ≈ 6 puntos frente a letras y ≈ 5 frente a bonos, con fuente; tributaron más hasta 2003 |
| III.1 | Teorema de Savage con «independencia ampliada» y «estado-uniformes» | Esa es la versión de Anscombe-Aumann/MWG 6.F; Savage con actos y P1-P7 |
| Nota 46 | «digieren» | difieren |
| III.2 | Schmeidler (1989) = utilidad dependiente del rango y «sofisticación probabilística» | Schmeidler = utilidad de Choquet (no aditiva), que explica Ellsberg; la dependiente del rango es de Quiggin (1982) |
| III.2 | «Modelos de múltiples previos» = criterios de Wald, Hurwicz… | Múltiples previos = Gilboa y Schmeidler (1989); los criterios clásicos son de la decisión en ignorancia |
| III.2 | Criterio de Savage = suma de pesares; matriz con C dominante; Hurwicz remite a «la tabla de abajo» | Mínimo del pesar máximo; matriz nueva sin acción dominante; una sola tabla antes de los criterios |
| Anexo 1 | La vNM es «ordinal» porque admite «cualquier transformación lineal creciente», con el ejemplo 24[∫u dF]³ | u es cardinal (afín positiva); U sobre loterías, ordinal si se renuncia a la forma de utilidad esperada |
| Anexo 2 | Nicolaus Bernoulli «jurista aficionado»; cita sin autor claro; «precio justo o equivalente cierto» | Matemático; la cita es de Cramer (1728); precio justo (∞) ≠ equivalente cierto (4) |
| Anexo 3 | «3 tipos de agentes»; notación τ, r₁, r₂; medidas «a., a., b.»; FGD «vía presupuestos (caso alemán)»; Grecia 50.000 M€; 3.B.17 | Depositantes impacientes/pacientes; π, R, L, c₁, c₂; financiación por las entidades (0,8 %); unos 40.000 M€ en el 1S 2015; 3.B.26 y 3.B.27 |
| Nota 2 | «Kevin Lancaster» | La nota sale con el enganche nuevo |

## Marcas resueltas

- **P1-P2** (rojo, «comportamiento»): el enganche se rehace; desaparecen.
- **P3** (aviso de cambio de temario y ficha del tribunal): fuera.
- **P4** (caso continuo): nota al opositor en I.1.1.
- **P5, P21** (San Petersburgo): frase en el cuerpo («esperanza de la utilidad y no utilidad de la
  esperanza») y anexo B.
- **P6, P16** (prima máxima, justa y de riesgo con el manuscrito): ejemplo √x con 64/16 en I.1.2 y
  gráfico `actitud-riesgo`.
- **P7, P8, P17, P18** (Fernández-Villaverde, Leland, Sandmo, prudencia, tabla): apartado de
  prudencia «no se canta», tabla `tab:prudencia` con θ y la fuente real (Fernández-Villaverde y
  Guerrón-Quintana, 2020, tabla 1); corregido el error de la «condición necesaria».
- **P9** (cantar solo los seguros): nota al opositor de I.2.
- **P10, P12** (cartera «no cantar», vacío): demanda de un activo con riesgo (Arrow, 1965), con nota
  «No se canta».
- **P11** (conferencias Nobel, racionalidad limitada): valoración de II.2 con Kahneman (2003),
  Simon (1955) y Thaler (2018).
- **P13-P25** (comentarios con nombres de preparadores, clases, minutos, «coordinar»): no se
  publican; las coordinaciones se resuelven en «Coherencia».
- **P26-P46** (figuras): 12 gráficos pedidos en TikZ (sin imágenes con derechos), 7 tablas LaTeX
  en color; fuentes rehechas (sin Policonomics ni Yemshanov ni Neuroprofiler).
- **P47-P53** (huecos de contenido): ver «Contenido añadido».
- **P54** (contradicción con el 3.A.21): preferencia por el estado reducida a la elección
  individual, con remisión.
- **P55-P58** (remisiones): ver «Coherencia».
- **P60-P63** (privado, enlaces): fuera nombres de preparadores, «Tema Juan Luis Cordero Tarifa»,
  Policonomics (enlace roto), ebooks7-24 (404), YouTube, quia → simulador.
- **P64-P66**: ver «Errores corregidos» y «Datos actualizados».
- **P67** (enganche repetido de Marshall): refranes + seguro y Lotería de Navidad (decisión de
  Víctor).
- **P68** (Diamond-Dybvig): resumido (decisión de Víctor).
- **P69** (caja de *behavioral finance*): conservada en `anotaciones`, redactada de nuevo con las
  fuentes originales de cada enigma.
- **P70** (teorema subjetivo): III.1 con Savage y Anscombe-Aumann.

## Datos actualizados

| Dato | Antes | Ahora | Fuente | URL | Consulta | Segunda comprobación |
|---|---|---|---|---|---|---|
| Primas de seguro en España, 2025 (nuevo, enganche) | — | unos 86.000 M€, ≈ 5 % del PIB | Mapfre Economics con datos de ICEA; Eurostat (PIB) | mapfre.com (presentación del 24/06/2026); nama_10_gdp | 19/10/2026 | ICEA vía prensa (85.879 M€); diferencia de 24 M€ |
| Lotería de Navidad 2025 (enganche) | — | **Sin cifra** | — | — | 19/10/2026 | El programa del sorteo **no está en el BOE** (revisados los sumarios de mayo a diciembre de 2025 con la API de datos abiertos) y la web de SELAE responde 403; la cifra de Newtral (3.554 M€) no tiene segunda comprobación |
| Prima de las acciones | «más de 6 puntos» | ≈ 6 puntos sobre letras y ≈ 5 sobre bonos; 6,18 (1889-1978); 6,7 y 5,5 (1928-2025, geométricas) | Mehra y Prescott (1985); Damodaran; UBS *Yearbook 2026* | ver V1 | 19/10/2026 | Coinciden en ≈ 5 puntos sobre bonos |
| Dividendos en EE. UU. | «hasta ahora tributaban más» | Hasta 2003 | IRS Topic 404; Gravelle (2003) | irs.gov | 19/10/2026 | CRS RS21541 |
| Edad de la teoría de las perspectivas | 4 décadas | Casi medio siglo | Kahneman y Tversky (1979) | — | 19/10/2026 | Cálculo |
| Grecia 2015 | 50.000 M€ en el 1S | Unos 40.000 M€ en el 1S | BCE (BSI) | data-api.ecb.europa.eu | 19/10/2026 | Saldos frente a flujos; Stournaras (BIS, 2017) |
| Garantía de depósitos | 100.000 € (2014/49/UE) | 100.000 €, mantenidos por la Directiva (UE) 2026/804, que protege 6 meses saldos temporales ≥ 500.000 € | Directiva 2014/49/UE; Directiva 2026/804; FGD | eur-lex | 19/10/2026 | EdB; texto italiano del DO. **Comprobar en EUR-Lex el número de DO L** |
| Financiación de los FGD | «vía presupuestos (caso alemán)» | Aportaciones de las entidades; objetivo 0,8 % | Directiva 2014/49/UE, art. 10 | legislation.gov.uk | 19/10/2026 | EdB |
| SVB (nuevo, anexo C) | — | 42.000 M$ retirados el 9/3/2023 | Fed (2023) | federalreserve.gov | 19/10/2026 | Una fuente oficial |
| Parámetros de 1992 | Sin parámetros | β ≈ 0,88, λ ≈ 2,25, δ ≈ 0,61/0,69 | Tversky y Kahneman (1992) | — | 19/10/2026 | Wakker y otras 2 fuentes secundarias (artículo no leído) |
| Allais en 1979 (nuevo) | «La mayoría» | 82 %, 83 %, 61 % | Kahneman y Tversky (1979, p. 266) | — | 19/10/2026 | **Fuente secundaria** (Millroth et al., 2019); comprobar en el PDF de 1979 |
| Efecto marco (nuevo) | «Casi todo el mundo» | 84 % y 69 % (problemas 11-12) | Kahneman y Tversky (1979) | — | 19/10/2026 | **Fuente secundaria**; comprobar en el original |
| Réplica de 2020 (nuevo) | — | 4.098 personas, 19 países, 94 % | Ruggeri et al. (2020) | doi 10.1038/s41562-020-0886-x | 19/10/2026 | IDEAS |
| Aversión relativa estimada (nuevo) | — | ≈ 1 | Chetty (2006); Holt y Laury (2002) | aeaweb | 19/10/2026 | Holt y Laury, parcial |
| Nobel (Allais 1988, Markowitz 1990, Kahneman 2002, Thaler 2017, 2022 con Bernanke) | Motivaciones parafraseadas o mezcladas | Motivaciones oficiales | nobelprize.org | — | 19/10/2026 | Autobiografías |

## Contenido añadido

- **Introducción** completa con sus cinco bloques: enganche nuevo (refranes, seguro y Lotería),
  relevancia con remisiones (3.A.13, 3.A.14, 3.A.21, 3.A.33, 3.A.35, 3.B.23, 3.A.1),
  contextualización corregida, 4 preguntas encadenadas, estructura explicada, esquema de pizarra y
  nota con el reparto (K6-K11, C1-C5).
- **I.1**: estructura a)-c); función clave U(x̃); ejemplo de primas; coeficientes con su porqué;
  teorema de Pratt; CARA/CRRA/HARA (tabla); prudencia (Leland, Sandmo, Kimball); dominancia con
  las funciones de distribución (Hadar-Russell, Rothschild-Stiglitz); estimaciones (Chetty, Holt-Laury).
- **I.2**: seguros de Mossin con a)-e), función clave con `\optim`, evidencia (Sydnor, 2010) y
  valoración con *risk pooling* (Arrow-Lind); activo con riesgo (Arrow) y empresa aversa (Sandmo,
  que cumple la remisión del 3.A.11), las dos «no se canta» (decisión: en el cuerpo, D6).
- **I.3**: utilidad dependiente del estado (Karni; Cook y Graham) y preferencia por el estado con
  la tangencia entre estados.
- **II.1**: Allais clásico con el efecto razón común, inversión de preferencias (Lichtenstein-Slovic,
  Grether-Plott), calibración de Rabin (2000).
- **II.2**: teoría de las perspectivas con fórmulas (ficha `prospect-theory`), 2 gráficos, patrón
  cuádruple, teoría acumulativa, Quiggin, teoría del pesar, Machina, tabla propia de teorías no
  esperadas citando cada obra (Karmarkar, Kahneman-Tversky, Quiggin, Chew, Loomes-Sugden y Bell,
  Tversky-Kahneman; Starmer como revisión), réplica de 2020, anomalías puestas al día (Genesove-Mayer,
  Gigerenzer, Stevenson-Wolfers) y caja de finanzas conductuales con fuentes.
- **III**: Savage con actos y principio de la cosa segura, Anscombe-Aumann, Ellsberg completo (y la
  versión de 3 colores), evidencia de campo (Dimmock et al., 2016), modelos de ambigüedad con números
  (Gilboa-Schmeidler, Choquet, KMM), criterios clásicos con una matriz de 4 acciones sin dominancia
  en la que Wald, maximax, Laplace y Savage eligen acciones distintas (Hurwicz, según α), y
  valoración (Milnor; Hansen-Sargent).
- **Conclusión**: con relevancia y opinión (estaban vacías) e idea final que responde al enganche
  con el patrón cuádruple.
- **Anexos**: D media-varianza (estaba vacío), E derivaciones (Arrow-Pratt, CRRA, Pratt, seguros,
  Allais, prudencia, con `\findemo`), F test y tribunal (simulador, 2 preguntas con respuesta,
  trampas).

## Coherencia

- **Notación del canon**: x̃, π_s, U(x̃) = 𝔼[u(x̃)], u(·), r_A, r_R, θ, ESI = 1/θ, ξ, ρ, W̄, L, S,
  **γ** (prima por euro asegurado; propuesta al canon, K44), τ (mezcla), 𝓛, 𝒫 (previos), a (CARA),
  w(π_s), v(x_s − r). Letras locales: β (curvatura de v), δ (parámetro de w, para no chocar con γ),
  α (inversión en el activo con riesgo y coeficiente de Hurwicz, en bloques distintos), b
  (cuadrática), η₀, η₁ (HARA), ν (capacidad), μ y φ (KMM), g (Quiggin), h (Chew).
- **3.A.13 (en paralelo)**: misma notación del seguro (γ, A = (W̄, W̄ − L), x₁, x₂, RMSE «estocástica,
  o entre estados») y el gráfico `seguros` se hace a partir de `3A13/graficos/seguro-simetrico.tex`
  más una capa de prima recargada. Diferencia menor: el 3.A.13 escribe la lotería con las
  probabilidades delante, (1 − π, π; W̄, W̄ − L), y el 3.A.10 con los resultados delante,
  (W̄, W̄ − L; 1 − π, π), como en su definición de lotería; conviene unificarlo en el 3.A.13 (no se ha
  tocado).
- **Promesas de temas revisados cumplidas**: 3.A.8 (Bernoulli y San Petersburgo; cardinalidad de vNM,
  anexo A redactado para no chocar; CRRA con la misma ecuación y el −1; HARA definida; Markowitz y
  la frontera eficiente en una frase del anexo D con remisión a 3.B.23); 3.A.11 (Sandmo); 3.A.21
  (preferencia por el estado).
- **Remisiones nuevas o corregidas**: 3.A.1, 3.A.14, 3.A.34, 3.A.35, 3.A.11, 3.A.12, 3.A.29, 3.A.24,
  3.B.26 y 3.B.27 (antes 3.B.17), 3.A.1 y 3.B.23 (antes 3.B.24); fuera las 2 autorreferencias.
- **Para `canon/pendientes-coherencia.md`** (no se han tocado otros temas): 3.A.8, l. 1638
  (Markowitz con `\vertema{3.A.10}`: mejor añadir `\vertema{3.B.23}`); 3.A.24 (Harsanyi y la
  neutralidad respecto a la utilidad); 3.A.29 (ESI = 1/θ, no σ); 3.A.33 (añadir Kimball y u‴ > 0);
  3.B.23 (caja de enigmas casi literal, «más de 6 puntos» sin fuente); 3.B.27 y 4.A.20 (notación de
  Diamond-Dybvig); fichas nuevas propuestas `utilidad-esperada-vnm`, `aversion-riesgo-arrow-pratt`
  y `demanda-seguros` (K41-K43); `prospect-theory` (K45), `hall` (K46), `emh` y `tobin-cartera` (K47),
  `diamond-dybvig` (K48: «mención, anexo resumido»).

- **Propuestas aplicadas y no aplicadas**. Aplicadas todas las C1-C58, V1-V92 y K1-K48 salvo:
  C8/C9 (símbolo ⊕ para la lotería compuesta: se usa τx̃¹ + (1 − τ)x̃², como pide el canon, K14);
  C17 (P(x) como símbolo de la prudencia: solo en el anexo E; en el cuerpo, sin símbolo, K44);
  C14 (derivación de Arrow-Pratt en el cuerpo: pasa al anexo E, K5); C33 («a» como exponente de la
  función de valor: β, porque a es la CARA); C44 (matriz de 3 acciones: se usa una de 4 para que
  los criterios elijan acciones distintas); V10 (gasto de 3.554 M€ en la Lotería: sin segunda
  comprobación); V13 se aplica; V17 (65 % del cuestionario de Allais: una sola fuente, no se pone);
  V8 (vacas locas, OGM: sustituidos por el 11-S de Gigerenzer); V27 y V58 (Bernanke y Friedman-
  Schwartz: salen con el anexo C resumido, el desarrollo es del 3.B.26/3.B.27); K11 (I.2 y I.3 sin
  tercer nivel: I.2 lleva 3 subapartados, uno por modelo, para que se vea que hay 3 aplicaciones);
  K12 (Hansen-Sargent en la conclusión: se mantiene, D5).

## Dudas abiertas

- **Decisiones ya tomadas por Víctor**: A10-01, Diamond-Dybvig **resumido** en el anexo C (aplicado);
  A10-02, enganche con los 2 refranes, el seguro y la Lotería de Navidad, y la idea final con el
  patrón cuádruple (aplicado); A10-03 («demanda de activos con riesgo y Sandmo: en el cuerpo como bloques "No cantar" o en
  un anexo»): **Víctor no la ha contestado**; se aplica la opción recomendada, **en el cuerpo, como
  bloques «No se canta»** (I.2.2 y I.2.3, cada uno con su nota al opositor y la estructura a)-c)). Si
  Víctor prefiere llevarlos a un anexo, basta mover los 2 subapartados. El resto de lo propuesto
  (reparto I 13', II 8', III 5'30"; γ para la prima; modelos de ambigüedad completos; Rabin y Sydnor;
  título de II.2 en castellano) se aplica como se recomendaba.
- **Lotería de Navidad sin cifra**: el programa del sorteo de 2025 (70 % a premios) no se ha
  encontrado en el BOE y SELAE no responde; el enganche dice solo que «devuelve en premios menos de
  lo que recauda». Si Víctor quiere la cifra, hace falta la nota oficial de SELAE.
- **Cifras de fuentes secundarias**: Allais en 1979 (82/83/61 %) y efecto marco (84/69 %); comprobar
  en el PDF de Kahneman y Tversky (1979).
- **Directiva (UE) 2026/804**: leída en una copia italiana; comprobar el número de DO L en EUR-Lex.
- **Tabla de la nota 43**: no se ha identificado su fuente (probablemente Starmer, 2000); se ha
  rehecho como tabla propia citando cada obra.
- **Gráficos**: hechos los 12 de `_trabajo/graficos-pedidos.json` (`seguros` a partir del 3.A.13, con
  una capa de prima recargada; la recta de prima justa se rotula «γ = π» para distinguirla de la
  recargada).
- **Damodaran**: la página se titula «1928-2024», pero desde su actualización del 5/1/2026 trae ya la
  fila de 2025; el texto dice 1928-2025 y la bibliografía conserva el título de la página.
- Control de calidad: sin incidencias (19/10/2026). Corregido en esta fase: activo con riesgo, Sandmo
  y el anexo C (Diamond-Dybvig) con bloques a)-c) y supuestos, desarrollo e implicaciones separados;
  rótulo de la recta de prima justa en `seguros`; 2 entradas de la bibliografía (Bernoulli, Machina).
- Control de calidad: sin incidencias (19/10/2026, tras los 7 comentarios de Víctor; correcciones aplicadas en esta fase, ver «Compilado y revisado» al final).

## Instrucciones para el vídeo

- **Minutos**: introducción 2'30"; I, 13' (I.1, 8': 3'30" de axiomas y teorema + 4'30" de actitud ante el riesgo; I.2, 4', solo seguros; I.3, 1'); II, 8' (II.1, 3'30"; II.2, 4'30"); III, 5'30" (III.1, 3'; III.2, 2'30"); conclusión, 1'. Lo que el tema marca «No se canta» (activo con riesgo, empresa aversa, prudencia, tabla de casos del seguro, anexos) no sale en el vídeo, salvo la frase que piden las notas al opositor.
- **Esquina de la pizarra**: la utilidad esperada (función clave) se escribe en I.1 y se queda hasta el final; en III.1 se dice solo que ahora las $\pi_s$ son subjetivas, sin reescribirla.
- **Actitud ante el riesgo** (I.1): el gráfico de pizarra es la utilidad cóncava con $\mathbb{E}[\tilde x]$, $\xi$ y $\rho$. La Imagen 3 (`actitud-tres-casos`, los 3 casos con la cuerda y el signo de $\rho$ y de $r_A$) va en la nota al pie: sale como apoyo, no se dibuja.
- **Seguros paso a paso** (I.2): el gráfico `seguros` se construye por capas en el orden de los gráficos (a)–(d): (a) ejes, línea de certeza y punto A tras los supuestos; (b) recta de aseguramiento con prima justa tras su ecuación; (c) curva de indiferencia tangente y E con seguro completo (primera parte del teorema de Mossin); (d) prima recargada y E′ con seguro parcial. Al final queda el gráfico completo, que se reutiliza en I.3 para la preferencia por el estado (mismos ejes, bienes contingentes). La Tabla 3 (10 minigráficos) no se canta.
- **Allais** (II.1): con los números de la Tabla 4 y sus 4 árboles (110 € al 75 % frente a 100 € al 80 %; 110 € al 95 % frente a 100 € seguros), la elección de la mayoría sombreada y el razonamiento $u(110)/u(100)>1{,}067$ y $<1{,}053$ a la vez; los árboles salen como apoyo y en la pizarra solo se escriben las 2 desigualdades. Friedman-Savage, con el boceto de su función.
- **Perspectivas** (II.2): la función de valor en S es imprescindible (se dibuja); la de ponderación se muestra también, más breve.
- **Ellsberg** (III): esquema de las 2 urnas, como apoyo.
- **Decisión de cartera**: está en el anexo (`cartera-alfa`, `cartera-riqueza`): no sale en el vídeo; basta la frase de la valoración del seguro. San Petersburgo, tampoco: una frase en I.1.
- **Enganche**: los 2 refranes, las primas de seguro (unos 86.000 millones, ~5 % del PIB) y la Lotería de Navidad; **idea final**: el patrón cuádruple de la teoría de las perspectivas, que responde a la pregunta del enganche.

## Comentarios de Víctor del 19/10/2026

1. **Imagen 3 (actitud ante el riesgo)**: `actitud-tres-casos` rehecho como el original, con los 3 paneles completos y rotulados: x₁, x₂, 𝔼[x̃], ξ; u(x₁), u(x₂), u(𝔼[x̃]) y 𝔼[u(x̃)] = u(ξ); la cuerda; la prima ρ con su signo (ρ > 0, ρ = 0, ρ < 0); y debajo de cada panel las desigualdades y el signo de r_A. Sigue en la nota al pie, ahora a todo el ancho y con un texto que explica cada caso. Se corrige un error del original: en el panel del amante rotulaba «U(ξ) = U(E[x])» en el punto de la curva en E[x]. Ahí la curva da u(𝔼[x̃]), y u(ξ) = 𝔼[u] está a la altura de la cuerda.
2. **Antigua nota 27 (ESI)**: recuperada como nota al pie donde se dice que ESI = 1/θ con la CRRA. Lleva la definición de la ESI y la derivación paso a paso, con θ, \vertema{3.A.29} y el factor de descuento β, que no cambia el resultado. Cierra con la coincidencia entre la ESI inversa y r_R, como en el original.
3. **Seguros paso a paso**: el gráfico se inserta 4 veces (gráficos (a)–(d)), cada vez junto al texto que lo explica: (a) A y la línea de certeza, tras los supuestos; (b) la recta con prima justa, tras su ecuación; (c) la curva tangente y E, con la primera parte del teorema de Mossin; (d) el gráfico completo, con la prima recargada y E′, con la segunda parte. Mecanismo: `seguros-paso1/2/3.tex` son envoltorios de una línea (`\def\tceepaso{k}\input{seguros.tex}`), y se compilan como cualquier otro gráfico, así que funcionan igual en PDF, HTML y Word. Además, `seguros.tex` lleva un marco fijo (`\useasboundingbox`) para que los 4 pasos salgan a la misma escala. Ojo: construir-tema.py solo recompila un gráfico si cambia su `.tex`. Si se toca `seguros.tex`, hay que forzar los pasos (`--grafico seguros-paso1 …` o `--forzar-graficos`).
4. **Tabla 3**: cada casilla lleva su minigráfico TikZ, 10 en total como el original (2 para el amante con prima favorable: ninguno si la prima es algo favorable, completo si es muy favorable). Son `seguros-averso-favorable`, `-averso-justa`, …, `-amante-recargada`, con la notación de `seguros` (W = 10, L = 6, π = 0,4, A, línea de certeza, γ). El tramo posible de la recta (0 ≤ S ≤ L) va en trazo grueso y la recta con prima justa en gris como referencia. Las utilidades son ln x para el averso y x² para el amante; los números están en la cabecera de cada fichero.
5. **Decisión de cartera a un anexo**: el antiguo I.2.2 pasa entero a un anexo nuevo («Aplicación: la decisión de cartera…», `anexo:cartera`, tras el de San Petersburgo). Lleva 2 gráficos nuevos: `cartera-alfa` (𝔼[u] según α con prima positiva y nula; α* según W̄ con DARA, CARA e IARA) y `cartera-riqueza` (el problema en el plano de la riqueza por estado, como el seguro al revés). También la derivación paso a paso de que con DARA dα*/dW̄ > 0. En el cuerpo queda una frase en la valoración del seguro, con remisión al anexo. Ajustados la introducción (estructura), el esquema de la pizarra, la presentación de las aplicaciones y la remisión del anexo de Arrow-Pratt. Los minutos no cambian, porque ese bloque no se cantaba.
6. **Tabla 4 (Allais)**: vuelve el ejemplo del original (juego 1: 110 € al 75 % frente a 100 € al 80 %; juego 2: 110 € al 95 % frente a 100 € seguros), con un árbol TikZ por lotería (`allais-a1`, `-b1`, `-a2`, `-b2`) y la elección de la mayoría sombreada. Se explica con esos números por qué ninguna utilidad esperada lo racionaliza: u(110)/u(100) tendría que ser > 1,067 y < 1,053 a la vez. También por qué viola el *axioma de independencia*, que se mantiene en lugar de «alternativas irrelevantes». Se corrige además el original, que decía que el juego 2 era el juego 1 «añadiendo un 20 %»: la mezcla exacta no es la misma (75/95 ≠ 80/100). La demostración del anexo usa B₁ = 0,8 B₂ + 0,2 δ₀ y A₂′ = 0,8 A₂ + 0,2 δ₀, que domina a A₁. La versión clásica de Allais (consecuencia común, 82 %/83 %/61 % de Kahneman y Tversky) pasa a una nota al pie. Los datos de razón común de Kahneman y Tversky (problemas 3 y 4: 80 % y 65 %) acompañan al ejemplo.
7. **Anexo de San Petersburgo**: reescrito con el desarrollo del original y sus pasos: (a) valor esperado y juego justo, favorable y desfavorable; (b) el problema de Nicolaus Bernoulli (matemático, no «jurista aficionado»), con la carta de 1713 a Montmort, el enunciado completo y la suma infinita; (c) la solución de Cramer (1728, autor de la frase de los matemáticos) y Daniel Bernoulli (1738), con la utilidad esperada como suma y los cálculos paso a paso con ln x (ξ = 4, incluida la suma Σ k/2^k = 2) y con √x (ξ ≈ 5,83); (d) la salvedad de Menger sobre la utilidad no acotada.

**Compilado y revisado** (control de calidad, 19/10/2026): PDF, HTML y Word regenerados y publicados. Ajustes hechos al revisarlos: rótulos de ρ y curva del averso en `actitud-tres-casos`; rótulos de A, E y E′ en `seguros` y en los 10 minigráficos de la tabla 3; rótulos y origen en `cartera-alfa` y `cartera-riqueza`; los 4 pasos del seguro, todos al mismo ancho (0,55 del texto), para que salgan a la misma escala; la tabla 3 va al final de I.2.1 (tras la valoración), para no dejar 2/3 de página en blanco; la ecuación de Cramer del anexo de San Petersburgo, en 2 líneas (se salía del margen); III.1 sin saltos en las letras: a) Idea pasa bajo «Desarrollo del teorema…» y la paradoja de Ellsberg queda sin letra bajo «Limitaciones y críticas…»; \autor{} en los títulos con Bernoulli, Allais, von Neumann y Morgenstern; y se quita «del tema original» de las fuentes de la tabla 3 y de la tabla 4 (el lector no lo conoce).
