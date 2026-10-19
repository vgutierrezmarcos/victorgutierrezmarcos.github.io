# Revisión del tema 3.A.14 — Teoría de juegos. Principales conceptos. Aplicaciones, con especial referencia a las subastas.

Fecha: 19/10/2026. **Tema sin original de Víctor** (CRITERIOS § 5). Integración en 2 partes: la 1 escribió el preámbulo, la introducción y los bloques I y II; la 2, el bloque III, la conclusión, los anexos A-D, `seo.json` y este informe.

Fuentes de la integración: `_trabajo/original.md` (Word de partida de otra opositora: esquema de 3.836 palabras, sin bibliografía), `estructura.md` (estructura base de **Miquel Tebar**), `pendientes.md` (P1-P59), `propuestas-contenido.md` (C1-C54), `propuestas-datos.md` (V1-V47) con `bib-datos.bib`, y `propuestas-coherencia.md` (K1-K29, estructura final, C1-C10 al canon, D1-D10). El tema de ICEX-CECO del temario nuevo (PDF escaneado) lo usaron los revisores como referencia de estructura y contenido; **no se cita ni se copia** en el tema: donde una idea procede de él, se cita la obra original (Mas-Colell, Whinston y Green; Gibbons; Krishna; Klemperer). Criterio ante discrepancias: la estructura, los minutos, las etiquetas y la notación los decide coherencia; la teoría y los ejemplos, contenido; las cifras, datos.

## Resumen

- Nueva fuente `3A14.tex` escrita desde cero, en 3 bloques que siguen el título: **I. Principales conceptos (I): juegos con información completa** (9′); **II. Principales conceptos (II): información incompleta, negociación y juegos cooperativos** (7′30″); **III. Aplicaciones, con especial referencia a las subastas** (10′: aplicaciones 1′30″, diseño de mecanismos 2′, subastas 6′30″). Introducción 2′30″ y conclusión 1′ (suma 30′).
- Hilo conductor: la **tabla de clasificación** de los juegos (estático/dinámico × información completa/incompleta, más cooperativos) con su concepto de solución en cada casilla (EN, ENPS, EBN, EBP; Nash, núcleo, Shapley); el bloque III da la vuelta a la pregunta (diseño de mecanismos) y termina en las subastas. Funciones clave: `eq:nash`, `eq:nash-negociacion` y `eq:puja`.
- Modelos con la estructura a)-e): equilibrio de Nash, ENPS, juegos repetidos, EBN, EBP y señalización, negociación, diseño de mecanismos y el modelo de valores privados independientes de las subastas.
- Corregidos los errores del Word de partida (EN con desigualdad estricta, Pareto al revés, núcleo con el signo cambiado, fórmula de Shapley, «EBPS», equivalencia de ingresos mal atribuida, subastas «secuenciales», el «siempre» de Milgrom, las «subastas eléctricas» españolas y las «tarifas multidimensionales» de Wilson) y sustituidos todos sus ejemplos e imágenes por ejemplos propios o de manual citado.
- `3A14.bib` con 120 entradas; 6 gráficos pedidos (`juego-entrada`, `inspeccion`, `arbol-harsanyi` y `nucleo`, ya hechos en `graficos/`; `pujas` y `multiunidad`, todos ya hechos en `graficos/`) y 5 tablas en LaTeX; 4 anexos (test, Rubinstein, cooperativos, subastas).

## Errores corregidos

| Dónde (Word de partida) | Decía | Dice ahora |
|---|---|---|
| l. 65 y 79 (P23, C25) | EN con desigualdad **estricta**, sin «∀ s_i»; S_i mayúscula para la estrategia; dominancia sin distinguir estricta y débil | `eq:nash` con ≥, ∀ s_i ∈ S_i, ∀ i, y su forma de mejor respuesta s_i* ∈ R_i(s_{−i}*); dominancia estricta y débil; eliminación iterativa (I.2) |
| l. 25-27 (P24, C26) | Estrategia mixta como «distribución de frecuencia»; «nos centraremos en las puras» | Distribución de probabilidad π⃗_i ∈ Δ(S_i), pagos de vNM, propiedad de indiferencia, existencia (Nash, 1950; Kakutani) y ejemplo de la inspección |
| l. 57 y 95 (P25, C27) | Confunde nodos y conjuntos de información | Nodo, conjunto de información y subjuego definidos (I.1, I.3) |
| l. 85 (P26, C28) | Eficiencia de Pareto definida al revés; no dice que el EN puede no existir en puras | Limitaciones del EN bien enunciadas (I.2, e) |
| Nota 1 (P27, C28) | «La información perfecta implica información completa e información simétrica» | Completa (pagos) frente a perfecta (jugadas): conceptos distintos; el dilema del prisionero es completo e imperfecto (I.1) |
| Imagen 5 (P5, P28, C29) | Inducción hacia atrás como «tipo de equilibrio»; falta el pago de la rama u del nodo 1 | Procedimiento, no equilibrio (Zermelo, Kuhn); ejemplo sustituido por el juego de entrada (I.3) |
| Imagen 10 (P10, P29, C30) | Errata (−5, 11) por (−5, −11); solo se resuelve un candidato; «equilibrio bayesiano» con creencias en la senda | EBN con su nombre canónico y definición correcta; ejemplo propio de entrada con capacidad desconocida, resuelto entero (II.1) |
| Imágenes 11-12 (P11, P12, P30, C31) | «SOL: ∃ EBPS (L, L)» (errata por (A, A)); «EBPS» definido como «EB en cada subjuego»; A/B como niveles de educación y p, q creencias | EBP con sus 3 condiciones; juego de Spence con y ∈ {0, ŷ}, ν, μ(y); criterio intuitivo (II.2) |
| l. 196 (P31, C32) | Núcleo como vector «que no bloquea ninguna coalición» y Σ x_i ≤ v(S) (signo cambiado); sin eficiencia; notación I, P(I), S | Núcleo 𝒞(v) con Σ_{i∈T} x_i ≥ v(T) y eficiencia; N, T ⊆ N, v(T) (II.3) |
| l. 232-254 (P32, C33) | Fórmula de Shapley sin «∖» ni restricción de la suma; axioma del «jugador ficticio» confuso; aditividad mal dicha; «fácil de computar» | `eq:shapley` sobre T ⊆ N∖{i}; 4 axiomas (jugador nulo, con el ficticio en nota); 2^{n−1} coaliciones por jugador |
| l. 262-330 (P33, C34, C45) | Subastas con información completa como modelo; pago π = v_i − b_j sin definir j | Modelo de valores privados independientes; pago v_i − max_{j≠i} b_j; lo de información completa se suprime (queda la frase de los EN con estrategias débilmente dominadas) |
| l. 328 (P34, C35) | «Siempre que se jueguen estrategias no dominadas, el resultado será el mismo… Teorema de la equivalencia de ingresos»; θ_1 y v_1 mezclados; α_2 sin definir; no llega a n | Teorema de equivalencia de ingresos con sus supuestos (Vickrey; Myerson; Riley y Samuelson), `eq:equivalencia` = (n−1)/(n+1); b(v) = (n−1)v/n sin letra para la pendiente |
| l. 268 (P18a, C36) | Subastas abiertas llamadas «secuenciales» | Abiertas (inglesa, holandesa) frente a sobre cerrado; «secuencial» es otra cosa (dicho en el texto) |
| Conclusión (P35, C37, V6) | Milgrom «probó que el vendedor **siempre** obtiene mayores ingresos» con pujas abiertas | Principio de vinculación con valores afiliados, en esperanza y con desigualdades débiles |
| Conclusión (P35, C38, V3) | Formatos de Milgrom y Wilson usados «en España para las subastas eléctricas» | Quitado (sin fuente): España adoptó la SMRA para el espectro |
| Conclusión (P35, C38, V5) | Wilson diseñó «tarifas multidimensionales» que financian capacidad y abaratan el suministro | Tarificación no lineal de los servicios públicos (Wilson, 1993) |
| Bibliografía (P36, C39) | Ninguna | `3A14.bib` con las obras originales y las fuentes oficiales |

Errores de las referencias de otros preparadores (no publicables; no afectan al texto): ICEX-CECO fecha el concepto de Nash en 1954 (es 1950-1951), escribe «Roshental» y da las páginas de Asker (2010) como «724-62»; Tebar llama «amenazas creíbles (gatillo)» al ejemplo de Cortés, mezcla el maximin de Wald con el minimax de von Neumann y define mal el jugador nulo (C42, C43).

## Marcas resueltas

El Word de partida no tiene marcas amarillas, texto en rojo, texto oculto, comentarios, «Nota al opositor» ni «No cantar» (`pendientes.md`, A y B). Lo único asimilable:

| Marca | Qué se hizo |
|---|---|
| Anotaciones manuscritas en las imágenes 8, 10, 11 y 13 | Su idea («creencias fuera del equilibrio») se reescribe en las implicaciones del EBP (II.2); las imágenes no se publican (P55) |
| Imágenes escaneadas 2 y 3 (Mas-Colell, Whinston y Green) | No se publican; sustituidas por la matriz canónica del dilema y el juego 3×3 de Gibbons en LaTeX |
| Nombre de la autora del Word (P54) | No aparece en ningún fichero público |

## Datos actualizados

No había datos en el Word salvo la conclusión del Nobel (V1-V7). Todos los datos son nuevos; consulta del 19/10/2026.

| Dato | Valor anterior | Valor nuevo | Fuente | URL | Consulta | Segunda comprobación |
|---|---|---|---|---|---|---|
| Nobel 2020, motivación | sin motivación | «por sus mejoras de la teoría de las subastas…» (como el 3.A.13) | nobelprize.org | https://www.nobelprize.org/prizes/economic-sciences/2020/summary/ | 19/10/2026 | Nota de prensa (V1) |
| Motivaciones Nobel 1994, 1996, 2005, 2007, 2012 | — | traducciones de las oficiales | nobelprize.org | https://www.nobelprize.org/prizes/economic-sciences/ | 19/10/2026 | *Scientific Background* de cada año (V8-V12) |
| Primera SMRA de la FCC | sin fecha | julio de 1994; 10 licencias, 47 rondas, 617 M$; > 120.000 M$ en 20 años | *Popular Science Background* 2020 | https://www.nobelprize.org/prizes/economic-sciences/2020/popular-information/ | 19/10/2026 | *Scientific Background* 2020 (España entre los adoptantes) (V2) |
| Subasta de 700 MHz | — | julio de 2021, 12 rondas, 1.010.089.000 € | Ministerio de Asuntos Económicos y Transformación Digital | https://digital.gob.es/comunicacion/notas-prensa/secretaria-estado-telecomunicaciones-e-infraestructuras-digitales/2021/07/210721_np_-subasta_ | 19/10/2026 | La Moncloa, 21/07/2021 (V30) |
| Subasta de 3,6-3,8 GHz | — | 2018, 34 rondas, 437,6 M€ (> 4 veces la salida) | Ministerio de Economía y Empresa | https://digital.gob.es/comunicacion/notas-prensa/secretaria-estado-telecomunicaciones-e-infraestructuras-digitales/2018/07/180717_np_subasta5g | 19/10/2026 | **Sin segunda fuente** (V31) |
| Subasta de 26 GHz | — | dic. 2022, 9 de 12 concesiones estatales a su precio de salida (4 M€ cada una) y 1 de 38 autonómicas: 36,2 M€ en total | Ministerio de Asuntos Económicos y Transformación Digital | https://digital.gob.es/comunicacion/notas-prensa/secretaria-estado-telecomunicaciones-e-infraestructuras-digitales/2022/12/subasta-de-26-ghz | 19/10/2026 | **Sin segunda fuente** (V32) |
| Formato de las subastas del Tesoro | «precio ofrecido» (P18g) | «convencional corregida», híbrida | Tesoro Público y Orden ECM/2/2026, art. 12 | https://www.tesoro.es/deuda-publica/mercado/mercado-primario/procedimiento-de-emision-y-subasta-de-los-valores-del-tesoro/la-subasta | 19/10/2026 | BOE-A-2026-678 (V35) |
| Subastas del Tesoro en 2025 | — | 46 subastas; 80 % de la financiación a medio y largo plazo | *Estrategia de financiación 2026*, p. 7 | https://www.tesoro.es/documents/d/tesoro/estrategia_tesoro_publico_2026_espanol | 19/10/2026 | Histórico de subastas (24 de Letras + 22 de Bonos y Obligaciones) (V37) |
| REER: formato | — | pago según oferta, con precio de reserva | RD 960/2020 y Orden TED/1161/2020 | https://www.boe.es/buscar/act.php?id=BOE-A-2020-13591 | 19/10/2026 | Nota del MITECO de 26/01/2021 (V40) |
| REER: primera subasta | — | 3.034 MW de 9.700 ofertados; 24,47 y 25,31 €/MWh | MITECO, 26/01/2021 | https://www.miteco.gob.es/es/prensa/210126resultadosprimerasubastaderenovablesd_tcm30-522089.pdf | 19/10/2026 | Nota del MITECO de 23/11/2022 (acumulados) (V41) |
| REER: cuarta subasta | — | 45,5 de 3.300 MW (precio de reserva) | MITECO, 23/11/2022 | https://www.miteco.gob.es/es/prensa/221123_ndpelmitecocelebralacuartasubastadeasignacionderegimeneconomicodeenergiasrenovables_tcm30-548346.pdf | 19/10/2026 | Prensa sectorial (≈50 MW como avance) (V42) |
| 3G de 2000 por habitante | — | RU y Alemania > 600 €; Países Bajos 170, Austria 100, Italia 240, Suiza 20 | Klemperer (2002), *JEP* | https://doi.org/10.1257/0895330027166 | 19/10/2026 | Comprobado por contenido en el artículo y en una conferencia del autor (C20) |
| Sanción a constructoras | — | 203,6 M€, 6 empresas, 25 años (julio de 2022) | CNMC, nota de prensa | https://www.cnmc.es/prensa/sancionador-obra-civil-20220707 | 19/10/2026 | Prensa (C20); la resolución está recurrida: el texto no dice que sea firme |
| Derechos de emisión de la UE | — | ronda única, sobre cerrado, precio uniforme | Reglamento Delegado (UE) 2023/2830, considerando 13 | https://www.boe.es/doue/2023/2830/L00001-00056.pdf | 19/10/2026 | Considerando 13 en la versión española (boe.es/doue): «en una sola ronda, en oferta sellada y en formato de precio uniforme» (V45 cerrada) |

No usados: la ratio de cobertura oficial del Tesoro (2,76 en 2025, mezcla subastas y sindicaciones, V38); la emisión bruta de 2026 (discrepancia de 16 M€ con la prensa, V36); la última subasta de bonos (caduca pronto, V39); la subasta 4G de 2011 (V33); el BCE a tipo fijo con adjudicación plena (sin segunda fuente ni vigencia comprobada, V44); CESUR (V46); la cifra británica de 34.000 M$ (V47; se usa la comparación por habitante de Klemperer).

## Contenido añadido

Todo el tema es nuevo (redactado desde cero con las fichas del canon y los manuales):

- **Introducción**: los 5 bloques; enganche con el refrán «Quien hace la ley hace la trampa» y la subasta de 700 MHz; 6 premios Nobel con su motivación oficial (1994, 1996, 2005, 2007, 2012, 2020); historia de Cournot y Zermelo a Harsanyi; esquema y reparto del cante.
- **I**: elementos, conocimiento común (Aumann), formas normal y extensiva, clasificación y tabla con color; dominancia y dilema del prisionero canónico; EN a)-e) con mejor respuesta R_i, mixtas (juego de la inspección en una caja con su tabla y su gráfico), existencia, minimax, penaltis (Palacios-Huerta, 2003); ENPS a)-e) con el juego de entrada, compromiso (Cortés, Coase, Kydland-Prescott, Barro-Gordon), juegos en 2 etapas, ciempiés (McKelvey y Palfrey, 1992); repetidos a)-e) con `eq:gatillo` (β ≥ 1/5), teorema de tradición oral (Friedman; Fudenberg y Maskin), cadena de tiendas y reputación, Axelrod (1984) y Dal Bó (2005).
- **II**: EBN a)-d) con Harsanyi, ejemplo discreto de entrada y `arbol-harsanyi`, Cournot con costes privados en una caja, purificación; EBP a)-d) con Spence como juego, separadores, agrupadores, criterio intuitivo, equilibrio secuencial y mano temblorosa; negociación a)-d) con `eq:nash-negociacion`, Rubinstein, Binmore-Rubinstein-Wolinsky y ultimátum; núcleo con el ejemplo del vendedor y los 2 compradores, Bondareva-Shapley y Debreu-Scarf; valor de Shapley con axiomas, `eq:shapley`, ejemplo y aplicaciones.
- **III**: aplicaciones con remisiones; diseño de mecanismos a)-d) (Hurwicz, principio de revelación con el enunciado común, PC_i e IC_i, VCG, renta informativa, Maskin, Gibbard-Satterthwaite, Myerson-Satterthwaite, compromiso); subastas: formatos y valores, modelo IPV a)-e) con segundo precio, primer precio (`eq:puja`), holandesa, equivalencia de ingresos (`eq:equivalencia`), subasta óptima con ψ(v) y p^R, aversión al riesgo, asimetría, maldición del ganador, vinculación, evidencia (Capen-Clapp-Campbell, Kagel-Levin, REER y 26 GHz), Klemperer (entrada y colusión, 3G, *bid rigging*, CNMC); multiunidad (uniforme frente a discriminatoria, reducción de la demanda), SMRA, combinatorias, subasta de incentivos, España (Tesoro, espectro, REER) y UE (derechos de emisión).
- **Conclusión**: recapitulación, relevancia con el Nobel de 2020 bien contado (Wilson y la maldición del ganador, Milgrom y la vinculación en esperanza, formatos para el espectro adoptados por España, eficiencia antes que recaudación, tarificación no lineal), extensiones, opinión (multiplicidad de equilibrios, racionalidad y conocimiento común exigentes, racionalidad limitada; éxito práctico) e idea final que retoma el refrán.
- **Anexos**: A, métodos y ejemplos para el test (matrices, mixtas por indiferencia, inducción hacia atrás, ENPS con subjuego simultáneo, EBN discreto, gatillo, subastas, enlace al simulador); B, Rubinstein y su límite; C, núcleo, núcleo vacío y tabla de Shapley; D, primer precio con F general, equivalencia por la envolvente, subasta óptima con U[0,1], valor común.

### Estado de cada propuesta

- **Coherencia**: K1-K5 aplicadas (títulos largos con «Principales conceptos», etiquetas de K2, subastas al final de III, negociación entera en II.3 con el orden negociación → núcleo → Shapley, tabla de clasificación). K6-K9 aplicadas, combinando el texto de K6 con el de C1 (enganche con el refrán y el 700 MHz). K10-K19 aplicadas. K20 (juego de los guantes) **no**: se conserva el ejemplo del vendedor y los 2 compradores de contenido (C10-C11), porque su núcleo coincide con el resultado de la subasta inglesa y engancha con III; queda como duda. K21-K28 aplicadas; K25 con un cambio de forma: el problema del pujador va en una ecuación aparte y la `\funcionclave` es solo b(v_i) = (n−1)v_i/n (lo que se queda en la pizarra). K29 aplicada (etiquetas, gráficos nuevos con fuente). C1-C10 (canon): para `tema-canon`. Esquema de pizarra: en la caja `esquema` de la introducción.
- **Contenido**: C1-C24 aplicadas con estos cambios: estructura, etiquetas y minutos de coherencia (no los de la tabla de contenido: I 10′, II 7′, III 9′30″); notación de coherencia (π_i para las mixtas y no σ_i; φ_i(v) con `\phi` y no `\varphi`; u_i^0 y no U_i^0; p^R y no p_0; c_A, c_B con probabilidad π en Cournot y no c̲, c̄ con ν; «Luchar» y no «Guerra»; Arriba/Medio/Abajo e Izquierda/Centro/Derecha en el 3×3 en vez de A/M/B e i/c/d); el EBN discreto pasa del anexo al cuerpo de II.1 (lo pide el árbol de Harsanyi, gráfico imprescindible); el Cournot con costes privados, a una caja de profundización (K15 lo dejaba en mención, pero no se borra); la evidencia experimental de la holandesa (C21) se quita porque Kagel y Levin (1993) no la respaldan; se citan las claves de `bib-datos.bib` cuando contenido y datos tenían claves distintas para la misma obra. C25-C44 documentados arriba; C45-C49 recortes respetados; C50-C52 gráficos pedidos; C53 al canon salvo σ_i, p_0 y c̲/c̄ (sustituidos por π_i, p^R y c_A/c_B); C54 integrado en el `.bib`.
- **Datos**: V1-V13, V30-V32, V35, V37, V40-V42 aplicadas; V2-V7 en la conclusión y en III.3; V14-V28 en el `.bib`; V33, V36, V38, V39, V44, V46, V47 no usadas (motivo arriba); V29 con dudas; V45 cerrada con la versión española.
- **Añadido por el editor**: Palacios-Huerta (2003), McKelvey y Palfrey (1992) y Dal Bó (2005), comprobados en Crossref; Axelrod (1984), con datos de catálogo. Se quitaron 2 afirmaciones de laboratorio sin fuente (cooperación en el dilema de una sola vez; porcentajes del ultimátum).

## Coherencia

- **Notación (canon)**: N, s_i ∈ S_i, u_i; R_i(s_{−i}) mejor respuesta (= función de reacción, D016); π⃗_i ∈ Δ(S_i) y π_i en los 2×2; U_i = 𝔼[u_i]; t_i ∈ 𝒯_i, prior π (ejemplos genéricos) y ν (Spence), μ(y) = Pr(A | y); A, B en redonda solo para tipos; β factor de descuento (gatillo, Rubinstein β_1, β_2), ρ_1, ρ_2 tasas (BRW); γ poder de negociación del jugador 1, u_i^0, 𝒰; T ⊆ N, v(T), x, 𝒞(v), φ_i(v); v_i, b(v_i) sin letra para la pendiente; F, f, v_(1), v_(2), I, p^R, v_0, ψ(v); u^C, u^D, u^N. Locales avisados: v(T) (II.3) y v_i (III.3) en apartados distintos; γ es aquí poder de negociación (en Barro-Gordon, peso de la inflación: no se escribe).
- **Promesas de temas revisados que se cumplen**: 3.A.10 (pagos esperados, mixtas, subastas; *Theory of Games* y el apéndice de 1947), 3.A.13 (incompleta frente a imperfecta, EBN y EBP, criterio intuitivo con el separador más barato, principio de revelación con el enunciado común, Nobel 2020), 3.A.17 (conjetura de Coase como inconsistencia temporal; Rubinstein y BRW con γ = ρ_2/(ρ_1 + ρ_2), igual que su γ = ρ_B/(ρ_S + ρ_B)), 3.A.21 (Nash y Kakutani; 4 axiomas de Nash con las mismas palabras; núcleo y Debreu-Scarf; Hurwicz y el cálculo socialista; subasta de reloj y tanteo).
- **Para el canon** (`tema-canon`, propuestas-coherencia § 6): fichas nuevas `equilibrio-nash`, `nucleo-shapley` y `nash-negociacion` (referencia 3.A.14); aprobar la D9 (`diseno-mecanismos` con referencia 3.A.14); *folk theorem* como concepto aquí y aplicación en el 3.A.19 (`dilema-prisionero`); ficha `subastas`: usuario 4.B.26 (y 4.A.20) en lugar de 4.A.19, quitar b_i = β_iv_i, añadir equivalencia, subasta óptima, vinculación, Klemperer y la nota de terminología, usuarios 4.A.5, 4.A.6, 4.A.12, 4.A.15, 3.A.17 y 3.A.21; filas nuevas de `notacion.md` (C7, con π_i y p^R); `mapa.yaml` (C8); `barro-gordon` y `spence-senalizacion` (C9, C10). Derechos de emisión remitidos a **4.A.6** (no a 3.B.37, que es el presupuesto de la UE).
- **Cambios opcionales a temas revisados** (para `pendientes-coherencia.md`): 3.A.21, nota de l. 695, «equilibrio perfecto en subjuegos» → «equilibrio de Nash perfecto en subjuegos»; 3.A.17, l. 1075, añadir `\vertema{3.A.14}` tras la subasta de Demsetz; 3.A.21, l. 778, principio de revelación con el enunciado común (ya anotado).
- **Contradicciones con otros temas** (no se tocan): 4.A.19 (Word, numeración antigua) llama «holandesa» a la de precio único: es la jerga del Tesoro, opuesta a la teoría (nota al pie en III.3; su contenido es del 4.B.26); 3.A.19 repite la teoría de juegos en su anexo 1, desarrolla el Cournot bayesiano (aquí, caja), usa φ para la función de reacción (canon R_i) y remite *Theory of Games* al 3.A.10; 3.A.18 (nota 25) remite la teoría de juegos al 3.A.10; 3.A.27 desarrolla Nash y Rubinstein en extenso con otra notación; 3.B.7 y 3.B.8 remiten Johnson (1953) al 3.A.19; 4.A.15 remite la clemencia al 3.A.16; 3.A.6, 3.A.36, 3.A.41 y 3.A.44 remiten los juegos repetidos de Barro-Gordon al 3.A.17 o 3.A.19.

## Dudas abiertas

Mientras Víctor no conteste en el artifact, se aplica la opción recomendada de cada duda.

**De coherencia (D1-D10)**:

1. **D1, estructura**: aplicada la recomendada (I información completa 9′ / II información incompleta, negociación y cooperativos 7′30″ / III aplicaciones con las subastas al final 10′) con los títulos largos que repiten «Principales conceptos». Alternativas: A1 (cooperativos en I), A2 (subastas como bloque propio), A4 (orden de ICEX-CECO por tiempo y luego información) o títulos cortos.
2. **D2, peso de las subastas**: 6′30″ + 2′ de diseño de mecanismos (aplicado). ¿Subir a 7′30″ quitando 30″ al minimax (I.2) y 30″ a II.3?
3. **D3**: ficha `diseno-mecanismos` con referencia en el 3.A.14 (aplicado en el texto: III.2 la desarrolla).
4. **D4**: *folk theorem* como concepto aquí (gatillo, β ≥ 1/5) y aplicación a la colusión en el 3.A.19 (aplicado).
5. **D5**: `nash-negociacion` con referencia en el 3.A.14 y el 3.A.27 como resumen aplicado (aplicado aquí; el Word del 3.A.27 hoy lo desarrolla en extenso).
6. **D6**: crear `equilibrio-nash` y `nucleo-shapley` (recomendado) o dejar las filas en `nucleo` y `dilema-prisionero`.
7. **D7, notación nueva**: π_i para las mixtas (no σ_i, p, q), φ_i(v), β en repetidos y Rubinstein (no δ), p^R, I, ψ(v) (aplicada).
8. **D8**: ficha `subastas` con usuario 4.B.26 (y 4.A.20) en lugar de 4.A.19 (aplicado en las remisiones).
9. **D9, ejemplos propios**: juego de entrada para el ENPS (aplicado); Cournot bayesiano solo como profundización (aplicado, en caja) y la subasta de primer precio como ejemplo continuo del EBN (aplicado). **Ejemplo cooperativo**: coherencia recomendaba el juego de los guantes (núcleo (1, 0, 0), Shapley (2/3, 1/6, 1/6)); se ha aplicado el del **vendedor y 2 compradores** de contenido (núcleo: el comprador 3 compra entre 60 y 100; Shapley (66⅔, 6⅔, 26⅔), fuera del núcleo), porque enlaza con la subasta inglesa. ¿Cambiamos a los guantes?
10. **D10, enganche**: el refrán «Quien hace la ley hace la trampa» más un hecho actual (subasta de 700 MHz de 2021), combinando las 2 opciones. La idea final retoma el refrán.

**De contenido (D1-D4)**: D1 (negociación junta en II.3, alternativa A3): aplicada; D2 (`diseno-mecanismos` con referencia 3.A.14): ver D3 de coherencia; D3 (ficha `nash-negociacion` y símbolos de C53): aplicada con la notación de coherencia (π_i, p^R); D4 (remisión de los derechos de emisión): **4.A.6**, no 3.B.37.

**Datos sin verificar o con una sola fuente**:

- Subastas de 3,6 GHz (2018) y 26 GHz (2022): una sola fuente oficial (V31, V32).
- Zermelo (1913), Kuhn (1953), Bertrand (1883): datos bibliográficos no comprobados en Crossref (V29); Bertrand se nombra sin cita.
- Selten (1965): solo comprobada la parte I; Hurwicz (1960) sin páginas; Harsanyi (1967) con pp. 159-182 (el *Scientific Background* da 159-189, V18).
- Axelrod (1984): datos de catálogo, sin Crossref.
- Calendario REER: no se ha encontrado ninguna subasta posterior a noviembre de 2022 (V43); no se dice nada en el texto sobre subastas futuras.
- Ninguna subasta de espectro posterior a 2022 encontrada (V34).

**Otras**: la frase reservada de Joan Robinson no encaja aquí. Extensión: 29 páginas de tema, 3 de anexos y 6 de bibliografía; el cante se ciñe a las notas al opositor.

**Control de calidad (19/10/2026)**: con correcciones pendientes (lista al editor y a `tema-tikz`). Comprobado en esta fase: el considerando 13 del Reglamento Delegado (UE) 2023/2830 en la **versión española** (boe.es/doue) dice «en una sola ronda, en oferta sellada y en formato de precio uniforme» (V45 cerrada); las 34 rondas de 3,6-3,8 GHz están en la propia nota de 2018 (sigue con una sola fuente, V31); los 36,2 M€ de 26 GHz incluyen la concesión autonómica de Castilla y León (9 × 4 M€ + autonómica), así que el texto se corrige. Para Víctor, sin decisión nueva: en el Word, la caja de anotaciones con una fórmula en display (Cournot con costes privados) se parte en varias cajas y la ecuación de Shapley sale sin número; es cosa de la plantilla (`construir-tema.py`), no del tema.

## Instrucciones para el vídeo

- **Introducción y conclusión, sin pizarra** (`modo: guion`). Enganche: «Quien hace la ley hace la trampa» y la subasta del 700 MHz (12 rondas, 1.010 millones); pregunta: «¿Se puede predecir lo que harán agentes racionales que se anticipan unos a otros, y diseñar reglas para que revelen lo que saben?». La idea final la responde retomando el refrán: la teoría no elimina la trampa, pero enseña a escribir la ley para que no compense; en una buena subasta, quien más valora el bien dice la verdad.
- **Esquema que crece**: al empezar I.1 se dibuja la **tabla de clasificación** como rejilla vacía de 2×2 más una fila de cooperativos, arriba a la izquierda, y no se borra en todo el tema; cada apartado rellena su casilla al llegar (EN en I.2, ENPS en I.3, EBN en II.1, EBP en II.2, Nash/núcleo/Shapley en II.3). No se escribe aparte y luego se copia.
- **Funciones clave que se conservan** (`conservar:`): `eq:nash` desde I.2 hasta el final; `eq:nash-negociacion` desde II.3 hasta el final de II; `eq:puja` desde III.3 hasta la conclusión. Cuando cambie la rejilla, se quedan en la columna de la tabla.
- **I.2**: matriz del dilema (tabla `tab:dilema-prisionero`) escrita a mano y subrayada por pasos (mejores respuestas del 1, del 2, casilla de equilibrio); después `eq:nash` recuadrada. El juego 3×3, el de la inspección y su gráfico, como **apoyo**. El minimax, en una línea de apoyo.
- **I.3**: `juego-entrada` por capas en la pizarra (nodos y ramas, pagos, cruz sobre «Luchar», «Acomodar» y «Entrar» en rojo, rótulo ENPS); compromiso de palabra. Repetidos: la condición `eq:gatillo` escrita a mano junto a la matriz del dilema, que sigue en la pizarra (no se reescribe: se señalan sus pagos −1, 0 y −5). Se borra todo menos la tabla y `eq:nash`.
- **II.1**: `arbol-harsanyi` por capas (Naturaleza, tipos con π y 1 − π, instalada, entrante, línea discontinua, pagos); la cuenta 2π − 1 de palabra o en una línea. Cournot bayesiano, nada.
- **II.2**: sin gráfico; se escribe solo la doble desigualdad c_A(ŷ) ≤ w_A − w_B ≤ c_B(ŷ) y, debajo, c_B(ŷ*) = w_A − w_B (criterio intuitivo). Las 3 condiciones del EBP, como apoyo.
- **II.3**: `eq:nash-negociacion` recuadrada; γ = ρ_2/(ρ_1 + ρ_2) debajo. El núcleo con el ejemplo: v(T) en una línea y el gráfico `nucleo` por capas (o como apoyo si falta tiempo); `eq:shapley` como apoyo y φ = (66⅔, 6⅔, 26⅔) escrito.
- **III.1**: lista de palabras clave como apoyo; nada en la pizarra.
- **III.2**: esquema a mano «tipos → mensajes → resultado» con PC_i e IC_i debajo; los teoremas de imposibilidad, como apoyo.
- **III.3**, pizarra en 2 columnas: a la izquierda, segundo precio (b = v), el problema del pujador de primer precio y `eq:puja` recuadrada, después `eq:equivalencia`; a la derecha, `pujas` por capas (diagonal, n = 2, sombreado, n = 3, n = 10). Subasta óptima: ψ(v) = 2v − 1 y p^R = ½ en una línea a la izquierda. Maldición del ganador, vinculación, multiunidad y España: de palabra, con `multiunidad` y los datos como apoyo. Al terminar, la pizarra queda con la tabla de clasificación completa, `eq:nash`, `eq:puja` y el gráfico de pujas.
- **Pronunciación** (si hace falta): Harsanyi, Selten, Zermelo, Rubinstein, Shapley, Vickrey, Aalsmeer.
