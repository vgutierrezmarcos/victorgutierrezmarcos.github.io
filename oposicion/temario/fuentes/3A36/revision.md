# Revisión del 3.A.36 — Política monetaria (I). El diseño y la instrumentación de la política monetaria.

Revisión autónoma (31/10–9/11/2026, Víctor fuera). Editor en 2 partes (4/11/2026): la 1.ª, preámbulo, esquema,
nota del reparto, introducción y apartado I; la 2.ª, el apartado II, la conclusión, los 6 anexos y el resto
de este informe. Las dudas se resuelven con la opción recomendada y se anotan como A36-NN.

## Resumen

- **Estructura**: 2 apartados, los 2 epígrafes del título y los 2 del original (A36-01): I. Diseño
  (`\minutos{15}`) y II. Instrumentación (`\minutos{11,5}`); introducción `\tiempo{2,5}` y conclusión
  `\tiempo{1}` (suman 30). Los títulos de 2.º nivel del original se mantienen, en su orden, en castellano
  y sin la pregunta (A36-02).
- **Parte 1** (hecha): introducción con sus 5 bloques y el enganche «Lo prometido es deuda» (la promesa del
  BCE de 2021-2025 y el dato de octubre de 2026); I.1 con Barro-Gordon desarrollado con la presentación del
  3.A.6 (R/T/D, CPO lineal, `eq:sesgo`, pérdidas y función de reacción en caja gris, Rogoff con
  perturbación de oferta, contrato de Walsh, independencia y dominación fiscal, evidencia); I.2 con el ancla
  nominal (inflación, nivel de precios, inflación media, PIB nominal, tabla de anclas) y la regla de Taylor
  una sola vez, con el gráfico de datos de la zona del euro; I.3 con el modelo canónico en resumen y la
  política óptima (discreción `eq:discrecion` frente a compromiso); I.4 con el límite inferior, las
  perturbaciones de oferta (2021-2023 y 2026), la estabilidad financiera y la histéresis.
- **Parte 2** (hecha): II.1 (los préstamos crean depósitos, tabla en T, 3 límites), II.2 (multiplicador del
  dinero con BM, Ef, Res, Dep, c_E, c_R, sin letra; la Gran Contracción en cifras; identidad, no mecanismo), II.3
  (esquema operativo; Poole con 𝔼[y_t²] y su condición; cantidad de dinero y monetarismo en resumen con la ley de
  Goodhart; tipos de interés), II.4 (operaciones de mercado abierto, facilidades, reservas mínimas, corredor frente
  a suelo, marco del BCE de 2024 y tipos de 2026, exceso de liquidez y balance, Reserva Federal; no convencionales
  con APP/PEPP; euro digital), conclusión con sus 5 bloques y la idea final «lo prometido es deuda», y 6 anexos
  (balances y multiplicador; agregados sin M4; Poole paso a paso con la regla mixta; cronología del Eurosistema;
  compras de activos en los balances; test con el enlace al simulador).
- Compila sin errores ni referencias o citas indefinidas, con los 4 gráficos nuevos de tema-tikz: 44 páginas
  (tema 32, anexos 5, bibliografía 7). La comprobación de 8-gramas contra Tebar, el original y el OCR del ICEX
  solo encuentra títulos, el TFUE, URL y «el tipo de interés a muy corto plazo».

## Errores corregidos

| Original | Corrección | Dónde |
|---|---|---|
| CPO con cuadrados y π = π* + (α/γ)(Ū − U*)² (P62) | CPO lineal y `eq:sesgo`, π^D = π* + (α/γ)(U^n − U*) | I.1.3 |
| «Juego de información imperfecta», la autoridad mueve primero | Información completa sin compromiso; el público mueve primero | I.1.3 |
| Puntos 0-1-2-3-F, *bliss point* en (0,0) o (U^n,0), «curvas cóncavas», «hard-nosed / wet nosed», «más de 16.000 citas» | R, T, D; punto de felicidad (U*, π*) con U* < U^n; elipses; fuera lo demás | I.1.3 |
| Rogoff (1985) llamado «independencia institucional» | Banquero conservador (Rogoff) e independencia (Alesina y Summers; Cukierman, Webb y Neyapti) separados | I.1.3 c)-d) |
| Sargent y Wallace «(1965)» (P63) | 1975 | I.1.2 |
| Ecuación de Fisher r_t = i_t + E[π_{t+1}] (nota 8, P64) | r_t ≡ i_t − 𝔼_t[π_{t+1}] | I.1.1 |
| Ball y Romer «(1987)» | 1990 | I.1.1 |
| Discurso de Friedman «(1967)» | Pronunciado en diciembre de 1967, publicado en 1968 | I.1.2 |
| «Modelo de Lucas-Phelps», «islas de Phelps» | Islas de Lucas (1972), sobre la idea de Phelps (1970) | I.1.2 |
| Regla de Taylor con ρ en 2 sentidos, φ_y, ŷ_t; «Taylor (1992)»; «Clarida et al. (2000xx)» (P65) | Forma original con r* + π* y OG_t; canónica `eq:taylor` con φ_π, φ_x, x_t; Taylor (1993), conferencia de noviembre de 1992; Clarida, Galí y Gertler (2000) | I.2.3 |
| Staiger, Stock y Watson para el intervalo del tipo natural, «al menos 2 puntos» | Laubach y Williams (2003) y Holston, Laubach y Williams (2017) para el tipo natural; SSW (1997) para la NAIRU, sin cifra | I.2.3 e) |
| «Sack (1998)» | Sack (2000), *JME* | I.2.3 c) |
| «De acuerdo con Svensson y Mishkin, 5 elementos»; cita entre comillas del ancla nominal (P71) | Los 5 elementos son de Mishkin (1999); el ancla, parafraseada (no era literal: juntaba 2 frases) | I.2.2 |
| NKPC con δ = (1−η)(1−βη)/η como pendiente de la brecha, «x_t = dcmg», «mayor tasa de descuento β», u_t de demanda y e_t de costes, regla sin φ_x (P66) | κ; β factor de descuento; demanda dentro de r^n_t y u_t de costes; regla canónica con φ_x | I.3 |
| Condición «φ + (1−β)/δ > 1» | κ(φ_π − 1) + (1 − β)φ_x > 0 con su intuición | I.3 iii) |
| Divina coincidencia de «Rotemberg y Woodford (2005)», nombre de «Blanchard y Galí (2005)», «Woodford (1999)» con λŷ², brecha con el PIB **nominal**, perturbación de costes «de Mankiw, Reis y Ball» (P67) | Goodfriend y King (1997) y Rotemberg y Woodford (1997); nombre de Blanchard y Galí (2007); pérdida de Rotemberg y Woodford (1997) y Woodford (2003) con λ_x = κ/σ; brecha real; Clarida, Galí y Gertler (1999) | I.3 |
| Nota 21: Blanchard y Galí «(2005)» con el DMP (P72) | Blanchard y Galí (2010) | I.3 c) |
| *Leaning against cleaning* | *Leaning against the wind* frente a *cleaning* | I.4.3 |
| Volcker: «líder de un grupo de trabajo» (nota 14) | Se resume en una línea (presidente de la Reserva Federal de 1979 a 1987, con fuente); lo demás sobra | I.1.3 c) |
| «8,4 % en 2022 (IPC)»: dato de España presentado como general (P71) | 8,4 % de media del IAPC de la zona del euro en 2022 (coincide con el de España) y dato de octubre de 2026 | Introducción |
| Multiplicador con E, e, q, b; «el pasivo representa M1» (P43, P44) | BM, Ef, Res, Dep, c_E, c_R, multiplicador sin letra; el dinero es M | II.2 y anexo A |
| Pasivo de los bancos «activos frente al sector privado (activos del banco central)» (P43) | Préstamos del banco central | Anexo A |
| «Reservas legales remuneradas y voluntarias no remuneradas» | El exceso se remunera solo en la facilidad de depósito; las mínimas, al 0 % desde el 20/9/2023 | II.4.1 |
| Poole: función objetivo «E[y_t]²» e implicación «con varianzas iguales, el tipo es mejor cuanto más empinada la LM y más plana la IS» (P68) | 𝔼[y_t²]; fijar el tipo si σ²_LM/σ²_IS > k² + 2hk/b; con varianzas iguales fijar la cantidad nunca es peor | II.3.2 y anexo C |
| Fuente de la imagen 7: el tema de un preparador (P41) | «Elaboración propia a partir de Poole (1970)» | II.3.2 |
| Banco de Inglaterra con objetivos «desde 1973» | Objetivos publicados desde 1976 (Hotson, 2010); Reserva Federal 1975-1982 también en la tabla de anclas | II.3.2 d), I.2.2 |
| Reservas mínimas «1 % desde 2011, remuneradas al tipo repo» (P69) | 1 % desde el 18/1/2012; 0 % desde el 20/9/2023 | II.4.1 |
| Nota 31: las operaciones principales «a un día»; nota 27 «siglo XVII»; nota 32 «el pasillo es relativamente novedoso» | OPF a una semana y facilidad marginal a un día; fuera el siglo; el corredor existe desde 1999 | II.4.1 |
| Operaciones de mercado abierto como «compraventa a cambio de colaterales» | Temporales (préstamos con garantía) o en firme | II.4.1 |
| «Operación Twist en 2012», como control de la curva | Septiembre de 2011-finales de 2012; alargamiento de vencimientos, no control de la curva | II.4.2 |
| Draghi «Haremos todo lo posible para salvar el euro…» como orientación | Traducción fiel del 26/7/2012 y su sitio: el anuncio que lleva a las OMT | II.4.2 |
| «QE for the people» «desde 2012», sin autor | Muellbauer (2014), sin «desde 2012» | II.4.2 |
| «97 % de M4» sin decir que es el Reino Unido; tabla de agregados con M4 (P45, P70) | Reino Unido; M1-M3 del BCE, sin M4 | II.1 y anexo B |
| ESTR | €STR | II.3.1 |
| McLeay y Radia (2014) | McLeay, Radia y Thomas (2014) | II.1 |
| Friedman «siempre y en todo lugar» | «siempre y en todas partes» (canon) | II.3.3 |

## Marcas resueltas

- **P1** (amarillo, McCandless y Weber): cifras comprobadas (V22: 110 países, 1960-1990, 0,93-0,96); a la contextualización, con cita y `\vertema{3.A.35}`.
- **P2** (amarillo, correlación no es causalidad): redactado de nuevo, con Walsh (2017, cap. 1) y Tobin (1970), `\vertema{3.A.5}`.
- **P3** (amarillo, Lucas 1996): una sola versión, en la introducción, con la traducción del fragmento literal comprobado (V23); la conclusión no la repite (parte 2).
- **P4-P6** (amarillo, «nos centraremos en 2 aspectos…»): fuera; la problemática y la estructura son las del tema; el sesgo deficitario, al 3.A.39 (mención en la dominación fiscal).
- **P7-P8** (amarillo «…» de la regla de cierre): completados (cada término y φ_x) en I.2.3 ii) y I.3.
- **P11-P12** (amarillo, Taylor duplicado en II.3.4): la regla queda una sola vez, en I.2.3; II.3.4 remitirá con `\ref{sec:taylor}` (parte 2). La viñeta «no tiene un componente no estocástico» se sustituye por los inconvenientes reales.
- **P13** (amarillo, ELB vacío, «Ver Juan Luis, págs. 6, 7 y 8»): ELB escrito en resumen en I.4.1; sin el nombre.
- **P15** (rojo, nota 9, Ramsey y Pontryagin): completada (regla de Keynes-Ramsey) y llevada a la idea de I.1.3, `\vertema{3.A.29}`.
- **P16** (nota al opositor del cambio de temario): desaparece.
- **P19-P28** (comentarios): no se publican; lo que piden (perturbaciones de oferta, diseño actual, coordinación de Barro-Gordon con el 3.A.6 y de la NEK con el 3.A.7) está hecho en I.
- **P29** (6 enlaces de la caja de la introducción): fuera los de prensa y redes; tipos y estrategia del BCE como citas (`BCE2026TiposOficiales`, `BCE2021Estrategia`, `BCE2025Estrategia`).
- **P30** (cajas de I.4.3 y capturas): capturas fuera; Blanchard y Summers (2017) resumido en castellano con cita; caja `anotaciones` con el enlace del NBER y Nair y Anand (2020).
- **P34-P38** (imágenes 1-5): sustituidas por `barro-gordon`, `barro-gordon-preferencias`, `objetivo-precios` (copiados del 3.A.6) y `nek-esquema`, `nek-xpi` (copiados del 3.A.7).
- **P42** (imagen del FMI del anexo 3): tabla LaTeX `tab:expectativas-elb` en I.4.1, como elaboración propia (A36-04).
- **P47** (gráfico de la regla de Taylor con datos): pedido (`regla-taylor-zona-euro`, CSV de datos actualizado).
- **P49-P52** (huecos del diseño): hechos (ELB, perturbaciones de oferta, evidencia de Barro-Gordon, nivel de precios, PIB nominal, inflación media, política óptima).
- Notas al pie del original (parte 1): nota 7 (valor natural) se queda, redactada de nuevo; nota 8, reescrita (credibilidad y transparencia); nota 9, completada; nota 11, se queda; notas 2-6, 10, 12-14, 17-21 fuera o integradas (nota 6 → caja con Mankiw y Reis, 2018).

- **P9-P10** (amarillo, monetarismo): resumido en II.3.3 con la regla del k % escrita γ_M = γ̄_M, la cita de Friedman (1963) con fuente, la ley de Goodhart con las palabras del 3.A.5, la «ecuación que falta» de Friedman (1970) y la Gran Contracción en II.2.
- **P11-P13** (II.3.4): sin repetir Taylor ni el límite inferior; remiten con `\ref`.
- **P14** (nota 35, «trucutrú», en inglés): fuera; la idea de Galí (2020), en el «a favor» del dinero helicóptero, con cita.
- **P17, P26, P46, P76** (anexo 2, hilo de Twitter en inglés con capturas): no se publica; lo útil, rehecho en el anexo E con fuentes académicas (McLeay, Radia y Thomas, 2014; Bowman et al., 2015).
- **P18** («este apartado es más bien un anexo»): balances y expansión banco a banco al anexo A; en el cuerpo, la idea y `eq:multiplicador-dinero`.
- **P31** (caja con la cita en inglés): traducida y resumida en `anotaciones`, con los 3 autores.
- **P32** (enlaces del Banco de España y monetarypolicyrules.org): `BdE2026Instrumentos`; el de Taylor no se usa.
- **P33** (VoxEU): Muellbauer (2014), con autor.
- **P39-P41, P43-P45** (imágenes 6, 7, 14 y tablas): tabla `tab:creacion-dinero`, gráficos `poole` y `esquema-operativo` (tema-tikz), tablas de los anexos A y B.
- **P53-P55** (marco de 2024, no convencionales, euro digital): hechos en II.4.
- **P56** (conclusión vacía): 5 bloques; fuera el texto de Walsh en inglés y la nota 36 (ecuación de San Luis, del 3.A.5).
- **P75** (bibliografía con temas de preparadores): fuera; queda Mishkin, Matthews y Giuliodori (2013) y las obras citadas.
- **P76** (quia.com): un solo enlace al simulador, en el anexo F (10 preguntas asignadas, 2002-2023).
- Notas al pie (parte 2): nota 23 (analogía de Poole) y nota 30 (subastas) redactadas de nuevo, la segunda sin la fórmula de la rentabilidad del bono; notas 22, 26-29, 31-34 y 36, fuera o integradas.

## Datos actualizados

- Introducción: IAPC de la zona del euro 4,0 % en octubre de 2026, energía +20,8 %, subyacente 2,5 % (V1); 8,4 % de media en 2022; facilidad de depósito del −0,50 % al 4 % (2022-2023) y 2,50 % vigente, tipos mantenidos el 29/10/2026 (V3).
- Estrategias: BCE 2021 y evaluación del 30/6/2025, siguiente en 2030 (V11); Fed: inflación media en 2020 y abandono el 22/8/2025 (V12); Nueva Zelanda 1990 y seguidores (V18); Volcker (V19).
- Regla de Taylor con el CSV actualizado de datos (inflación general): −1,6 % en 2020, 14,2 % en 2022 (facilidad de depósito 0,08 %), 5,1 % en 2026 frente a 2,16 % de media; 3,1 % con r* ≈ 0 (Brand, Lisack y Mazelis, 2025). Comentario de que en 2022 y 2026 exagera por la energía.
- Tipos negativos del BCE (junio de 2014-julio de 2022; −0,50 % de septiembre de 2019 a julio de 2022), subida de 450 pb en 14 meses.
- Sin cifra: Kydland y Prescott («16.000 citas», V37) y el intervalo de Staiger, Stock y Watson (V26).

- II (V4-V10, V13-V17, V21, V28, V29): marco del BCE de 2024 (15 pb desde el 18/9/2024; revisión prevista en 2026, sin decisión publicada a 4/11/2026); tipos 2,50/2,65/2,90 desde el 16/9/2026; reservas mínimas (1 % desde el 18/1/2012, 0 % desde el 20/9/2023, unos 175.000 M€); balance del Eurosistema 8,8 → 5,9 billones (jun. 2022 → 30/10/2026); exceso de liquidez 4,7 → 2,1 billones, €STR unos 7 pb bajo la facilidad de depósito; APP y PEPP sin reinversión desde jul. 2023 y fin de 2024; TLTRO III vencidas; agregados de septiembre de 2026 (M3 17,72 billones, +3,5 %; efectivo el 9 % de M3); Reserva Federal (reservas amplias desde 2019, fin de la reducción del balance en dic. 2025, fondos federales 3,75-4,00 % desde el 17/9/2026); euro digital (Consejo 19/12/2025, Parlamento 9/7/2026, negociación abierta; piloto 2027 y emisión 2029 si se aprueba en 2026); Operación Twist; Draghi; TPI; objetivos monetarios de los 70 y Bouey.
- V2 (BCE desde el 1/6/1998) y V39 (composición del Consejo de Gobierno) no se usan: no hacen falta aquí (son del 3.B.43). V38: se mantiene Mishkin, Matthews y Giuliodori (2013) sin capítulos.

## Contenido añadido

| C | Estado |
|---|---|
| C1, C2 | Aplicadas (notas privadas fuera; quia fuera: el enlace al simulador va en el anexo de test, parte 2) |
| C3 | **Rechazada en parte**: se usa la nota del reparto de coherencia (§ 12) con los minutos del coordinador; fuera las pegatinas «cría fama y échate a dormir» y «más vale pasarse que quedarse corto», que son del 3.A.6 y del 3.A.7 (K54) |
| C4 | Aplicada con cambios: enganche «Lo prometido es deuda» (K53) en lugar de «donde dije digo, digo Diego»; sin el 10,6 % de octubre de 2022 (no lo comprobó la fase de datos); relevancia reordenada en 3 rótulos; delimitación con los vecinos (K3) |
| C5, C6 | Aplicadas; la histéresis pasa a I.4.4 (coordinador; queda una remisión en I.1.2) y la nota 9 a la idea de I.1.3 |
| C7 | Aplicada con la estructura de K29: `eq:sesgo` como función clave; función de reacción, pérdidas y `barro-gordon-preferencias` en caja gris; Rogoff con la perturbación en el cuerpo; la reputación sin refrán; Nueva Zelanda «se acerca a esa idea» (A36-07); dominación fiscal con las palabras del 3.A.39 |
| C8 | Aplicada (nota de la credibilidad, en la idea de I.1.3) |
| C9 | Aplicada |
| C10 | Aplicada con cambios: 5 elementos de Mishkin (1999) y no de 2000 (V25); la inflación media como párrafo propio; la tabla de anclas con ejemplos |
| C11 | Aplicada con cambios: Taylor con a)-e) e i)-iii); el gráfico se llama `regla-taylor-zona-euro` y va en d) con las cifras del CSV nuevo (5,1 y 2,16 en 2026); claves de datos (`LaubachWilliams2003`, `BCE2026TiposOficiales`); sin la pegatina del 3.A.7 |
| C12, C13 | Fusionadas en un solo modelo a)-e) en I.3 (K32): resumen de 3 ecuaciones, pérdida como ecuación (no función clave), discreción como función clave, compromiso, ganancia del compromiso, nivel de precios implícito, objetivo flexible; la innovación de u_t sin letra (A36-05); sin «matar dos pájaros de un tiro» (pegatina del 3.A.7) |
| C14 | Aplicada |
| C15 | Aplicada; la tabla, como elaboración propia (A36-04); se añade Eggertsson y Woodford (2003) para la compensación, `\vertema{3.A.29}` y `\vertema{3.A.40}` |
| C16 | Aplicada y puesta al día con 2026 (vuelta a la promesa del BCE) |
| C17 | Aplicada; recapitulación de I y nexo con II |

Propuestas de coherencia (K) aplicadas en la parte 1: K1-K6 (estructura y títulos), K9 (Taylor una vez), K10 (ELB una vez), K11 (tono una vez, en I.3), K12.1-K12.6, K12.9, K12.10, K12.12, K13, K26-K33, K40 bis (I.4.1-I.4.4), K41-K46 (gráficos), K53-K55, K57 (la parte del apartado I), K58 (remisiones de I), nota del reparto del § 12. **Rechazado**: la viñeta «Con datos» de K30 en b) pasa a d) Evidencia (C11, mismo contenido).

Propuestas de datos (V) aplicadas en la parte 1: V1, V3, V11, V12, V18, V19, V20, V22-V27, V30, V31, V33-V37. V32 (Blanchard y Fischer) no hace falta: la clasificación de equilibrios múltiples sale del tema (está en el 3.A.7). Las demás (V2, V4-V10, V13-V17, V21, V28, V29, V38, V39), en la parte 2.

Propuestas de contenido del apartado II, la conclusión y los anexos:

| C | Estado |
|---|---|
| C18 | Aplicada; título de II.1 «Introducción: la creación del dinero en las economías modernas» (coordinador); el 97 % del Reino Unido y el 9 % de efectivo en M3 |
| C19 | Aplicada y fundida con K34 (multiplicador en el cuerpo con la notación fijada) |
| C20 | Aplicada partida: el esquema operativo en II.3.1 y el corredor frente al suelo, con el marco de 2024, en II.4.1 (K38); gráfico `pasillo-suelo` (no `corredor-suelo`); claves de datos (`BCE2024Marco`, `BCE2026TiposOficiales`, `Fed2019Amplias`) |
| C21 | Aplicada con a)-e); sin la fecha del Reino Unido de 1973 ni la de M3 de 1985 (V21: publicados desde 1976); la regla mixta, al anexo C con su derivación (nueva); el texto describe el gráfico como está dibujado (LM horizontal en ī, IS⁺/IS⁻, LM⁺/LM⁻) |
| C22 | Aplicada en una sola lista; sin el valor de referencia del 4,5 % (no lo comprobó la fase de datos) |
| C23 | Aplicada (título del original: «Los tipos de interés como objetivo intermedio») |
| C24 | Aplicada con cambios: el corredor «en general con 100 pb a cada lado», sin la anchura exacta de enero de 1999 (A36-12) |
| C25 | Aplicada con las claves de datos (`Draghi2012Speech` con la traducción de V16; `BCE2026APP`, `BCE2026PEPP`); TLTRO «ya vencidas» (V8), sin fecha de la última; la regla de Friedman distinguida del helicóptero |
| C26 | Aplicada como II.4.3, con las claves de datos y la del Consejo |
| C27 | **Rechazada en parte**: la idea final retoma «Lo prometido es deuda» y no «donde dije digo…» (K53, coordinador); extensiones de K56 |
| C28 | Aplicada con la notación fijada (BM, Ef, Res, Dep, c_E, c_R) en lugar de EF, ef, q |
| C29 | Aplicada con los saldos de septiembre de 2026 (V9) |
| C30 | Aplicada (anexo E) |
| C31 | Aplicada (notas 23 y 30 redactadas de nuevo; el resto fuera) |
| C32 | Aplicada (tabla de errores) |
| C33-C36 | Los 4 gráficos los dibujó tema-tikz con los nombres `regla-taylor-zona-euro`, `poole`, `esquema-operativo` y `pasillo-suelo` |

Propuestas de coherencia de la parte 2: K7 (6 anexos: los 5 previstos y el de test), K8, K34-K40, K47-K51, K56, K57 (multiplicador y Poole) y K58 (remisiones de II). **No se hace** K52 (gráfico de tipos del BCE), como recomienda la propia K52. Propuestas de datos de II, todas aplicadas (arriba).

## Coherencia

- Barro-Gordon con la presentación, la notación (U^n, U*, γ, α, Δ local, π^T) y el gráfico del 3.A.6; el 3.A.6 no se toca.
- Modelo canónico con la notación del 3.A.7 (x_t, r^n_t, θ, κ, β, ρ, φ_π, φ_x, u_t, ε_t, λ_x = κ/σ) y sus 2 gráficos copiados; el 3.A.7 remite aquí la regla de Taylor y «la 2.ª generación defenderá el compromiso»: cumplido.
- Dominación monetaria y fiscal con las mismas palabras que el 3.A.39 (sin tocarlo).
- 3.A.28: la tasa natural como guía y la histéresis (Galí, 2022), cumplido; 3.A.29 y 3.A.1: inconsistencia temporal, cumplido; 3.A.3: Wicksell y el tono, cumplido; 3.B.31: perturbaciones climáticas, cumplido; 1D01: «objetivo simétrico del 2 % a medio plazo», misma redacción.
- Remisiones de la parte 1: 3.A.1, 3.A.3, 3.A.5, 3.A.6, 3.A.7, 3.A.14, 3.A.20, 3.A.26, 3.A.28, 3.A.29, 3.A.35, 3.A.37, 3.A.39, 3.A.40, 3.A.41, 3.A.42, 3.B.15, 3.B.16, 3.B.26, 3.B.27, 3.B.31, 3.B.43.
- Para el canon (sin cambios aquí): ρ_u local en la política óptima; u_t de oferta en Rogoff, de la misma familia que la de costes (nota al pie).

- Parte 2: el IS-LM de Poole con b, k, h del 3.A.5; la regla del k % como γ_M = γ̄_M y la ley de Goodhart con las palabras del 3.A.5; la Gran Contracción con las cifras de la ficha `historia-monetaria-friedman-schwartz` y la clave `FriedmanSchwartz1963Monetary`; «multiplicador del dinero», distinto del multiplicador de la política monetaria del IS-LM del 3.A.5 (se dice en el texto); la regla de Friedman (3.A.41) distinguida del dinero helicóptero; el detalle institucional del Eurosistema, al 3.B.43; los canales de los no convencionales, al 3.A.37.
- Remisiones nuevas en la parte 2: 3.A.5, 3.A.35, 3.A.37, 3.A.39, 3.A.40, 3.A.41, 3.B.24, 3.B.27, 3.B.43 y, en la conclusión, 3.A.7, 3.A.14, 3.A.28, 3.B.15, 3.B.16.
- Para la fase de canon: fichas nuevas `poole`, `multiplicador-monetario` y `objetivo-inflacion` con el 3.A.36 de referencia (CC1-CC3) y las notas CC4-CC9; en `poole`, la regla mixta H* = bσ²_LM/(kσ²_IS) del anexo C.

## Dudas abiertas

- **A36-01** 2 apartados (D1 de coherencia): aplicada la recomendada (2).
- **A36-02** Títulos de 2.º nivel en castellano y sin la pregunta (D2): aplicada; II.1 se titula «Introducción: la creación del dinero en las economías modernas» (coordinador).
- **A36-03** Suprimida: la notación del multiplicador (BM, Ef, Res, Dep, c_E, c_R, sin letra) la fijó el coordinador y no queda como duda.
- **A36-04** Tabla de las expectativas en el límite inferior: no se ha podido confirmar la figura del FMI (SDN/16/09): `\fuente{elaboración propia.}`.
- **A36-05** La innovación de la perturbación de costes, sin letra («una innovación de media cero»).
- **A36-06** Histéresis como I.4.4 propio y corto (D10).
- **A36-07** El contrato de Walsh y Nueva Zelanda: la frase dice solo que el sistema neozelandés «se acerca a esa idea» (no se ha comprobado el detalle del contrato del gobernador).
- **A36-08** Regla de Taylor con la inflación general (como Taylor, 1993) y una frase de que con la subyacente pediría «bastante menos» (no se ha calculado la cifra).
- **A36-09** Tabla de anclas: SME 1979-1998, caja de conversión búlgara 1997-2025, Bundesbank 1975-1998, Reserva Federal con objetivo explícito desde 2012 y Suecia 1931-1937 vienen de la fase de contenido (Berg y Jonung, 1999, para Suecia); no los releyó la fase de datos.

- **A36-10** Título de II.3.4: se mantiene el del original («Los tipos de interés como objetivo intermedio»), aunque el texto dice que hoy el tipo es objetivo operativo y la previsión de inflación hace de objetivo intermedio.
- **A36-11** Van sin cita propia las operaciones a 3 años de 2011-2012, los tipos negativos desde junio de 2014 y el PEPP en marzo de 2020 (manuales y tabla de tipos del BCE); la fase de datos no los releyó. **Cerrada la parte del control de la curva**: Reserva Federal 1942-1951 con Federal Reserve History (`FedHistory2026Accord`) y Banco de Japón septiembre de 2016-marzo de 2024 con sus notas del 21/9/2016 y del 19/3/2024 (`BoJ2016YCC`, `BoJ2024Marco`), leídas el 4/11/2026.
- **A36-12** Anchura del corredor del BCE: «en general, 100 puntos básicos a cada lado» (las medias anuales del CSV lo confirman, salvo las primeras semanas de 1999).
- **A36-13** El euro digital «sin intereses, con límite de tenencia y utilizable sin conexión» sale de la propuesta de la Comisión de 2023; el texto final puede cambiar en la negociación.
- **A36-14** La regla mixta de Poole (anexo C) es una derivación propia con la notación del tema; Poole (1970) la plantea de otro modo.
- **A36-15** (control de calidad, 4/11/2026) El gráfico `barro-gordon`, copiado sin cambios del 3.A.6, rotula los ejes con subíndices (π_T, U_T) y el texto de los 2 temas usa superíndices (π^T, U^T). Corregirlo exige tocar el gráfico de referencia del canon (3.A.6) y volver a copiarlo: decisión de Víctor (recomendado: superíndices en el gráfico del 3.A.6 y copia al 3.A.36).
- **A36-16** (control de calidad, 4/11/2026) Las letras de las citas del mismo autor y año no coinciden entre el PDF y el HTML (en la introducción, el PDF dice Eurostat 2026b y BCE 2026h; el HTML, Eurostat 2026a y BCE 2026i): biblatex y la conversión del HTML ordenan distinto las entradas sin fecha completa. Es del pipeline, no de este tema; cada formato es coherente con su propia bibliografía.
- Control de calidad (4/11/2026): con correcciones pendientes (Poole con varianzas iguales, cita entre paréntesis dobles en I.2.3, citas de 3 párrafos y retoques del gráfico `poole`); ver el informe de la fase 6.

## Enlaces del original (9/11/2026)

Regla nueva de CRITERIOS § 4: los enlaces del tema original se conservan.

- **Restaurados** (10):
  - Cajas de la introducción (página del BCE sobre el cambio de objetivo, artículo de *Economía 3* sobre las funciones del BCE) e *Informe Anual 2022* del Banco de España (cita del contexto de la invasión de Ucrania): nota nueva al final del enganche; el informe, como `BdE2023InformeAnual2022` (la dirección antigua del PDF sigue valiendo).
  - Página del Banco de España sobre la estrategia del BCE (nota 15 del original): dirección nueva, `BdE2026EstrategiaBCE`, citada junto a la evaluación de 2025 (I.3).
  - MonetaryPolicyRules.org (caja de los instrumentos convencionales): nota «Para ver» al final de la valoración de la regla de Taylor, donde encaja mejor.
  - Tuit de *elEconomista* (4/3/2021) y tribuna de *La Tribune* (24/6/2021) sobre el dinero helicóptero: nota en el dinero helicóptero; el tuit se sustituye por la noticia a la que enlazaba (Vicente Nieves, «Suecia saca el helicóptero del dinero…»; el sitio bloquea la consulta automática, comprobada a través del tuit).
  - Líneas de liquidez del BCE (nota 29): dirección nueva, en nota a las operaciones de mercado abierto.
  - Hilo de @MacroAlf sobre la creación de dinero (título del antiguo anexo 2): en la caja de McLeay, Radia y Thomas.
- **Ya estaban** (por otra vía): PEPP (`BCE2026PEPP` sustituye a data.europa.eu), Mankiw y Reis (2018) con DOI, Galí (2020) en cepr.org, Nair y Anand (2020) con DOI (era el enlace de ScienceDirect de la estabilidad financiera), el PDF de McLeay, Radia y Thomas (página del boletín), los dos enlaces antiguos de instrumentos del Banco de España (`BdE2026Instrumentos`) y la tabla 50934 del INE.
- **Descartados**: ninguno.
- **Para Víctor**: el tuit y el hilo de X pueden borrarse en cualquier momento; si prefiere no enlazar redes sociales, basta con quitar la frase del hilo de la caja de McLeay.

## Instrucciones para el vídeo

- **Enganche**: «Lo prometido es deuda», arriba a la izquierda; la promesa del BCE (2 % simétrico, 2021 y 2025), 2022 (8,4 %) y octubre de 2026 (4 %, subidas de junio y septiembre).
- **Pizarra, bloque I**: gráfico `barro-gordon` por capas (R, T, D) con `eq:sesgo` recuadrada a la derecha y la pegatina «el camino del infierno está empedrado de buenas intenciones»; la regla de Taylor canónica `eq:taylor` recuadrada (2 cifras de la zona del euro de palabra); `nek-xpi`, panel b, con `eq:discrecion` recuadrada y «entre dos males, el menor»; en I.4.2 se vuelve al panel b.
- **Apoyo (no se dibuja)**: `barro-gordon-preferencias`, `objetivo-precios`, `regla-taylor-zona-euro`, `nek-esquema`, tabla de anclas y tabla de las expectativas en el límite inferior.
- **Funciones clave que se conservan**: `eq:sesgo`, `eq:taylor`, `eq:discrecion`.
- **Pizarra, bloque II**: la tabla en T de la creación de dinero (2 cuentas); `eq:multiplicador-dinero` de palabra; `esquema-operativo` rápido (4 cajas); `poole` por paneles (al menos la fila de perturbaciones reales y el panel d), con la pegatina «perturbación real, fija la cantidad; monetaria, fija el tipo»; `pasillo-suelo` si da tiempo; pegatinas «a grandes males, grandes remedios» y «quien avisa no es traidor».
- **Apoyo (no se dibuja)**: los anexos A-E, la tabla de agregados y la cronología.
- **Idea final**: «Lo prometido es deuda, y un banco central creíble es el que la paga», que cierra el enganche.

## Correcciones del control de calidad (4/11/2026)

- Poole: «con varianzas iguales y k ≥ 1, fijar la cantidad nunca es peor (umbral > k² ≥ 1)».
- Citas: sin doble paréntesis en Brand, Lisack y Mazelis (2025); las de la regla de Taylor con datos, a la viñeta que presenta las cifras; `BCE2021Estrategia` para el análisis monetario y financiero; `BCE2024Marco` en la viñeta del diferencial; control de la curva con `FedHistory2026Accord`, `BoJ2016YCC` y `BoJ2024Marco` (nuevas en el .bib).
- Datos: Reserva Federal con objetivos monetarios 1975-1982 en la tabla de anclas (como en II.3.2); APP desde 2014, con deuda pública desde 2015 (II.4.2 y anexo D); €STR unos 6 pb bajo la facilidad de depósito.
