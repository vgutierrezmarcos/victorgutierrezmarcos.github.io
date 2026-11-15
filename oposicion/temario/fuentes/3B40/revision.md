# Revisión del 3.B.40 — La Cohesión Económica y Social en la Unión Europea: política regional e instrumentos presupuestarios y financieros. Política social y de empleo. El proceso de convergencia real en la Unión Europea

Revisión completa del 14/11/2026 (entrega 1: tema y ficha de repaso; sin vídeo), en el worktree `revision-temario-2`, en paralelo con los agentes de los 3.B.41 y 3.B.42. Fuente nueva en LaTeX (`3B40.tex`) a partir del Word original (`_trabajo/original.md`, el antiguo 3.B.41, que el propio Word marcaba como «copiado del tema de Juan Luis»), **redactada de nuevo** y puesta al día a noviembre de 2026 con fuentes oficiales (EUR-Lex, Comisión —cohesiondata, informes de cohesión, revisión intermedia—, Parlamento y OEIL, Consejo, TJUE, BEI, Eurostat y Ministerio de Hacienda). Las dudas se resuelven con la opción recomendada y se anotan como B40-NN (14/11/2026).

## 1. Resumen

- Se mantienen los 3 bloques del original y sus títulos de segundo nivel: **I. Política regional** (I.1 importancia y justificación —se juntan «Importancia» y «Justificación»—; I.2 marco jurídico; I.3 antecedentes; I.4 instrumentos presupuestarios y financieros; I.5 cómo se gestionan), **II. Políticas social y de empleo** (II.1 social; II.2 empleo, cada una con justificación, marco, historia e instrumentos) y **III. El proceso de convergencia real** (III.1 caracterización teórica; III.2 evidencia de convergencia; III.3 papel de la política regional; III.4 dificultades de medición). Reparto: introducción 2′30″, I 11′, II 7′, III 8′30″, conclusión 1′.
- 3 modelos con la estructura rígida a)-e): **integración, localización y el dilema de la cohesión** (capital móvil de Martin y Rogers, 1995, `eq:mercado-domestico`), **convergencia β y σ aplicada a las regiones de la UE** (`eq:convergencia-beta`, la del 3.A.45, con una **regresión propia** con Eurostat NUTS 2) y **regresión en discontinuidad en el umbral del 75 %** (Becker, Egger y von Ehrlich, 2010, `eq:rdd`).
- 9 gráficos y figuras propios (TikZ/pgfplots) que sustituyen a las 10 imágenes del Word (capturas del 8.º informe de cohesión): 6 de datos (convergencia β regional, σ regional y nacional, PIB por habitante de España frente al Este y el Sur 1995-2025, asignaciones de cohesión por Estado, objetivos del Pilar), 2 teóricos (mercado doméstico, discontinuidad) y 2 figuras (historia de la cohesión, arquitectura 2021-2027). 1 tabla en anexo (objetivos por periodo).
- PDF: 26 páginas de tema, 2 de anexos (derivación del modelo de capital móvil; objetivos por periodo; test) y 4 de bibliografía (53 entradas). Ficha de repaso: 4 páginas a 10,5 pt (última, 89 %). `verificar-tema.py` (envoltorio sobre `_trabajo/`): ver el final de este informe.

## 2. Errores corregidos

| Id | Dónde (Word) | Decía | Dice ahora |
|---|---|---|---|
| E1 | Introducción | Historia general de la integración (Monnet, Roma, «20» en el euro) | Fuera (está en el 3.B.36); la intro se centra en la cohesión y el euro tiene 21 Estados |
| E2 | Relevancia | Vacía | Escrita (392.000 M€, propuesta 2028, España) |
| E3 | Modelos de geografía | «[ver tema 3.B.6]» y modelo centro-periferia «[ver tema 3.B.10]» | Remisiones a 3.B.6 y 3.B.10 como enlaces; el modelo se cuenta en su variante de capital móvil |
| E4 | Tabla centro-periferia | Mecanismos con notación $n_i^*/N^*$, $\gamma$ para el peso de las manufacturas | Canon: $\mu$ para el peso, $\phi=\tau^{1-\sigma}$; se cuenta el modelo de capital móvil |
| E5 | Integración monetaria | «[ver tema 3.B.17]» (en el índice) | \vertema{3.B.16} |
| E6 | Marco jurídico | Lista completa de competencias de los arts. 3-6 | Resumida en una viñeta (detalle en el 3.B.36) |
| E7 | Art. 174 | Sin la dimensión territorial | «Territorial» desde Lisboa; zonas transfronterizas y muy poco pobladas |
| E8 | Historia 2021-2027 | «Se reforzará un 2,7 %»; «377.000 M€»; «47.500 de REACT» | 392.000 M€ (Comisión); REACT-EU solo como historia |
| E9 | FEDER | «200.400 M€; España 25.300»; regiones en transición con «cofinanciación 75-85 %»; menos desarrolladas «hasta el 100 %» y en la tabla «PIBpc < 100 %» | FEDER 214.300 (+ 9.400 Interreg); España 23.400; cofinanciación UE 85/60(70)/40(50) % (art. 112 RDC); umbral < 75 % |
| E10 | FEDER | «80 % / 60 % / 50 % a objetivos verdes e inteligentes» por región | Concentración por grupos de Estados (85 % OP1+OP2; 40 % OP1; 25 % OP1; 30 % OP2; Reg. 2021/1058, art. 4) |
| E11 | Fondo de Cohesión | «42.600 M€… *grosso modo* Grecia y Portugal» | 39.000 M€ (+11.300 al MCE); 15 Estados (Este, Grecia, Portugal, Chipre, Malta) |
| E12 | Regiones de España | Transición: Galicia, Asturias, CyL, Cantabria, La Rioja, C. Valenciana, Canarias | 9 en transición (faltaban Baleares y Murcia); menos desarrolladas también Ceuta y Melilla; 5 más desarrolladas (Decisión 2021/1130) |
| E13 | FEIE | FEADER 85.400, FEMP 5.900 como fondos del grupo | 2021-2027: ya no existe la etiqueta FEIE; RDC común a 8 fondos; FEADER fuera del RDC (remisión al 3.B.38) |
| E14 | FSUE | «500 M€ al año» | Reserva Europea de Solidaridad, hasta 1.016 M€ de 2018 al año (revisión del MFP de 2024) |
| E15 | Preadhesión | 12.565 M€; lista de candidatos con Georgia como «potencial» | IPA III sin cifra, con remisión al 3.B.42 (lista de candidatos cambiante) |
| E16 | Gestión | Prioridades del «Estudio Prospectivo Anual» | Semestre actual; ciclo acuerdo de asociación → programas → autoridades → reembolso |
| E17 | Gestión | Suspensión «por déficit»; nota 18 con 7.500 M€ a Hungría (prensa) | Condicionalidad macro (art. 19 RDC) y del Estado de Derecho; Hungría con remisión al 3.B.37 (6.300 M€ aprobados) |
| E18 | Política social | Carta de Derechos «vinculante tras la firma de Lisboa en 2007» | En vigor con Lisboa en 2009 |
| E19 | Art. 153 | Lista de unanimidad sin la pasarela | Pasarela salvo seguridad social; 153.5 con el cierre patronal |
| E20 | AROPE | Privación material severa «4 de 9» | Indicador 2021: privación material y social severa, 7 de 13 |
| E21 | FSE+ | «88.000 M€; España 25.300» | ≈95.000 M€ corrientes (87.995 de 2018); España 11.300 |
| E22 | Política de empleo | Objetivos en el «art. 145» como «de la política social» | Art. 145 es empleo; arts. 146-150 |
| E23 | FEAG | 1.300 M€ | Máximo 30 M€ de 2018 al año tras la revisión del MFP de 2024 (186 antes); más de 200 despidos |
| E24 | SURE | «100.000 M€, acordado por el Eurogrupo»; base jurídica «como el MEEF» | 98.400 M€ concedidos a 19 Estados (art. 122); España 21.324 |
| E25 | Convergencia | $\sigma^2_{y,t}>\sigma^2_{y,t+k}$ y la imagen β/σ copiada del 3.A.45 | Notación del 3.A.45 y remisión; sin la imagen |
| E26 | Evidencia | «Brecha de 2.500 €»; Andalucía «68 % en 2018, 81 % en 2008» | Datos de Eurostat 2000-2024 (Andalucía 72 → 69; España 92 % en 2025) |
| E27 | Papel de la política | «Sosvilla (2010)», «de la Fuente (2002)» sin referencia | Se mantienen De la Fuente y Vives (1995) con su resultado comprobado; «trabajos posteriores, 1/5-1/3» sin autor (B40-05) |
| E28 | Conclusión | Idea final con «prioridades de la Comisión 2019-2024» | Retoma el refrán del enganche |

## 3. Marcas resueltas

| Marca | Texto original | Qué se ha hecho |
|---|---|---|
| Notas al opositor (cambio de temario) y captura | — | Desaparecen |
| Comentario «Está copiado todo el tema de Juan Luis» | — | No se publica; el tema se ha redactado de nuevo |
| Amarillo (5 tramos de la contextualización) | competencia compartida, objetivo, ampliaciones, 2 ejes, objetivo de la exposición | Integrados en la contextualización y la estructura |
| Amarillo «La teoría neoclásica defiende una convergencia automática…» | — | I.1, justificación económica |
| Amarillo «La crisis de la COVID-19…» (vacío) | — | III.2: convergencia a 2 velocidades, con datos hasta 2025 |
| Nota al opositor «De palabra y brevemente» (competencias) | — | El marco se resume |
| Comentario «Sahuquillo habla de cómo se gestionan…» | — | No se publica; I.5 reescrito |
| Comentario «Coordinar en temas 3.A.45 y 3.B.40» | — | Hecho: misma ecuación y remisión |
| Estructura, Relevancia, Extensiones, Opinión vacías | — | Escritas |
| «Estimación 2021-2027» vacía | — | Modelos de la Comisión del 9.º informe (1 € → 1,3 € de PIB en 2030) |
| Imágenes 1-6 (capturas del 8.º informe) | — | Rehechas con datos de Eurostat y de la Comisión (gráficos 6-7) |
| Nota 15 (Albania), 18 y 21 (prensa), 20-21 (ERTE) | — | Quitadas (datos viejos o de prensa); SURE con datos oficiales |
| Bibliografía «Tema Juan Luis», «Tema ICEX-CECO» | — | No se citan (preparadores); bibliografía nueva |
| Enlace de test | — | Caja estándar del simulador (`tema=3.B.40`) |

## 4. Datos actualizados

Todos consultados el 14/11/2026.

| Dato | Antes | Ahora | Fuente | Segunda comprobación |
|---|---|---|---|---|
| Cohesión 2021-2027 | 377.000 | 392.000 M€; por fondos (FEDER 214.300, FC 39.000, FSE+ 95.100, FTJ 22.100, Interreg 9.400) | Comisión (available budget) | Ficha del PE 95; reparto por fondos reconstruido con cohesiondata (B40-02) |
| Asignaciones por Estado | — | 27 Estados; España 35.562 (724 €/hab.) | cohesiondata pbbz-hmfu | hgyj-gyin; ficha mtr26-es |
| AA de España | 25.300 + 25.300 | 36.700: FEDER 23.400, FSE+ 11.300, FTJ 870, FEMPA 1.120 | cohesiondata (ms=ES) | Cifra habitual de 36.700 (la web de Hacienda no abrió: B40-03) |
| Categorías | — | 5/9/5 regiones españolas | Decisión 2021/1130 | — |
| Revisión intermedia | — | 34.600 M€, 186 programas; España 3.200 | Comisión, factsheet-mtr26 | cohesiondata gsn7-zaih |
| STEP | — | 15.200 M€ en prioridades STEP | cohesiondata hgyj-gyin | Sin segunda fuente (B40-04) |
| Ejecución | — | 30 % pagado (21 % sin anticipos); España 20 %; 2014-2020: 99,6 % | cohesiondata pbbz-hmfu, gayr-92qh | — |
| Propuesta 2028-2034 | — | 865.076 M€; 782.879 en planes; ≥217.798 menos desarrolladas | COM(2025) 565 | OEIL (estado del procedimiento) |
| PIB por habitante PPA | España 2018 | 1995-2025 por países | Eurostat prc_ppp_ind_1 (julio 2026) | prc_ppp_ind (2025) y tec00114 coinciden ±1 |
| PIB regional | Andalucía 2018 | 232 NUTS 2, 2000-2024 | Eurostat nama_10r_2gdp (febrero 2026) | Total UE y España igual que prc_ppp_ind_1 ±1 |
| Empleo 20-64 | — | UE 76,1 %, España 72,4 % (2025) | Eurostat lfsi_emp_a | Informe EMCO 2026 (Consejo) |
| AROPE | — | 92,7 M (20,9 %), 2019: 95,5 M; España 25,7 % | Eurostat sdg_01_10 | INE, ECV 2025 (25,7 %) |
| Ninis | — | 11 % (2025) | Informe EMCO 2026 | — |
| SURE | 100.000 | 98.400 a 19 Estados; España 21.324; 31,5 M trabajadores (2020) | Comisión (DG ECFIN) | 3.B.37 (mismas cifras) |
| FEAG | 1.300 | 30 M€ de 2018/año | Reg. 2024/765 | Reg. 2021/691 |
| BEI | — | 42.800 M€, 48 % en regiones de cohesión (2025) | BEI | — |
| InvestEU | — | garantía 26.152 M€; 372.000 movilizados | Reg. 2021/523 | — |
| 9.º informe | 8.º informe | trampa: 28,4 % de la población; 46 regiones en la trampa del talento; Este 45 % → ≈80 % | Comisión (2024) | Diemer et al. (2022) |
| Salario mínimo | — | Directiva 2022/2041; TJUE C-19/23 (11-11-2025) anula el art. 5.2 y una cláusula del 5.3 | Comunicado de prensa 136/25 (vía FRA) | Notas de despachos (B40-06) |
| Pilar renovado | — | COM(2026) 650 (22-7-2026); Estrategia contra la Pobreza COM(2026) 538 (6-5-2026); Vivienda COM(2025) 1025 | Comisión | Metadatos de la Oficina de Publicaciones |

## 5. Contenido añadido

- **Modelo de la integración y la localización** (I.1.4): capital móvil de Martin y Rogers (1995), mercado doméstico amplificado, transferencias e infraestructuras («carretera de doble sentido»), dilema crecimiento-equidad de Martin (1999); extensiones de Krugman (1991, Nobel 2008), Krugman y Venables (1995) y Baldwin y Forslid (2000); evidencia de Puga (2002), Iammarino et al. (2019) y Rodríguez-Pose (2018). Derivación en el anexo A.
- **Justificación política** con el Informe Padoa-Schioppa (1987) y los pagos laterales; Myrdal (Nobel 1974).
- **I.4** reescrito para 2021-2027: RDC, 5 objetivos, fondos, categorías, método de Berlín, concentración, clima, condiciones favorecedoras, $n+3$; Acuerdo de Asociación de España; **revisión intermedia de 2025** y STEP; FSUE, IPA, instrumentos financieros, BEI, InvestEU.
- **I.5**: ciclo de gestión, condicionalidades, ejecución y absorción, y la **propuesta 2028-2034** con su debate.
- **II**: Pilar Europeo de Derechos Sociales y su plan (con el seguimiento de 2025), renovación de 2026, salario mínimo y sentencia del TJUE, transparencia salarial, trabajo en plataformas, Garantía Infantil y Juvenil, marco de convergencia social del Semestre, FEAG y SURE actualizados.
- **III**: modelo de convergencia con la notación del 3.A.45 y **regresión propia** (232 regiones, 2000-2024; `datos/preparar-datos.py`); trampa del desarrollo regional y del talento; Este frente a Sur con datos de 1995-2025; **regresión en discontinuidad** (Becker, Egger y von Ehrlich 2010, 2013, 2018; Pellegrini et al., 2013), modelos de la Comisión, De la Fuente y Vives (1995), Boldrin y Canova (2001).
- Anexos: A (equilibrio del modelo de capital móvil), B (objetivos de la cohesión por periodos, tabla) y C (test).
- **Material del disco D: usado**: «Temas a imprimir\11. Unión Europea\Tema 3.B.41 - v.2023.pdf» (mismo contenido que el Word de partida); «Evolución política de cohesión.pdf» (Panorama 64, 2018: dotaciones y receptores de cada periodo, citado como `CE2018Panorama64`; figura de la historia); «02_rmicciche_politicadecohesion2021-2027» (presentación de la DG REGIO, 2020: 5 objetivos, método de Berlín, concentración en la propuesta; contrastado con el reglamento final, que cambió los porcentajes); ficha del PE 3.1.1 (antigua; sustituida por la vigente). No se usaron las 80 medidas de simplificación (sustituidas por la revisión intermedia), el acuerdo del MFP de 2020 (está en el 3.B.37) ni los temas de otros preparadores ni el de ICEX-CECO.

## 6. Coherencia

- **3.B.37**: el peso de la cohesión (≈1/3, rúbrica 2a), la STEP, el MRR, Hungría y la propuesta 2028-2034 se dan en una línea con remisión; no se repite el presupuesto. Discrepancia: su l. 886 dice «1,6 puntos más **al año**» (Becker et al., 2010); aquí, «en el periodo de programación» (B40-01, `canon-pendiente.md`).
- **3.A.45**: misma `eq:convergencia-beta` y misma `eq:convergencia-sigma`; la imagen β/σ y la derivación se remiten. Sus σ de la UE-27 (PWT, 0,55 → 0,33) y las de aquí (Eurostat, 0,56 → 0,31) coinciden en orden de magnitud.
- **3.B.6 y 3.B.10**: el centro-periferia y el *tomahawk* solo como extensión; aquí la variante de capital móvil (propuesta al canon). El 3.B.10 remite su «U» de Krugman y Venables al 3.B.40: está en I.1.4 c).
- **3.B.36** (competencias, CESE, Comité de las Regiones), **3.B.38** (FEADER), **3.B.39** (*dumping* social), **3.B.30** (BEI), **3.B.42** (IPA), **3.B.43** (convergencia nominal), **3.B.45** (Semestre, SURE como estabilizador, condicionalidad macro), **3.B.16**, **3.B.11**, **3.A.18**, **3.A.26**, **3.A.43**, **3.A.44**, **3.B.28**.
- **4.º ejercicio**: \vertema{4.A.17} (regiones españolas y convergencia), \vertema{4.A.30} (flujos España-UE), \vertema{4.A.28} (convergencia de España hasta 2019), \vertema{4.A.16} (mercado de trabajo, ERTE), \vertema{4.B.14} (federalismo fiscal).
- Propuestas al canon en `_trabajo/canon-pendiente.md` (variante de capital móvil; modelo nuevo de discontinuidad; ficha de convergencia con la notación del `.tex` del 3.A.45).

## Reglas de las tandas 8.ª y 9.ª y transversal (aplicadas, 14/11/2026)

| Regla | Cómo se ha aplicado |
|---|---|
| Estructura rígida de modelo | 3 modelos con a) Idea, b) Modelo (i-iii), c) Extensiones, d) Evidencia empírica, e) Valoración |
| Sin citas Harvard | Solo `\nocite` y `\textcite` de obras originales |
| Nunca citar a Víctor | Ninguna entrada suya; gráficos «elaboración propia» |
| Ni «Pegatina» ni «Dicho» | Un solo refrán, el del enganche («Dios da pan a quien no tiene dientes», no usado en otro tema ni en la tanda), retomado en la capacidad de absorción y en la idea final |
| Nobel con motivo oficial | Krugman (2008), Solow (1987), Myrdal (1974), con las notas de otros temas |
| `\vertema` al 4.º ejercicio | 4.A.16, 4.A.17, 4.A.28, 4.A.30, 4.B.14 |
| Resultados clave en morado | `eq:mercado-domestico`, `eq:convergencia-beta`, `eq:rdd` con `\funcionclave` |
| Pasos con sangría | Desarrollos por pasos en sublistas |
| Cajas grises | Notación y siglas; test |
| Ejemplos sin nombres propios | Regiones $N$ y $S$, «una región» |
| Inglés entre paréntesis | *footloose capital*, *big push*, *regression discontinuity design*, *fuzzy*, *crowding out/in* |
| Anexo de test | Caja estándar con `tema=3.B.40` |
| Sin páginas en blanco ni desbordes | Comprobado con `verificar-tema.py` sobre `_trabajo/` |

## 7. Dudas abiertas

Todas aplicadas con la opción recomendada (14/11/2026); para que Víctor las confirme.

- **B40-01** Becker, Egger y von Ehrlich (2010): no se ha podido abrir el texto completo; el resumen solo dice «efectos positivos en el crecimiento, no en el empleo». La cifra de 1,6 puntos se atribuye al periodo de programación (acumulada), no anual. Opciones: (a) «en torno a 1,6 puntos más en el periodo de programación» **[aplicada]**; (b) quitar la cifra y dejar solo el signo. El 3.B.37 dice «al año»: anotado en `canon-pendiente.md`.
- **B40-02** El reparto de los 392.000 M€ por fondos no está publicado como tal: se ha reconstruido con los importes iniciales de cohesiondata (FEDER 214.300 + Interreg 9.400 + FC 39.000 + FSE+ 95.100 + FTJ 22.100 + ≈11.300 del FC al MCE). Opciones: (a) dar los importes por fondo como «unos» **[aplicada]**; (b) dar solo el total.
- **B40-03** El Acuerdo de Asociación de España (36.682 M€ y su reparto) sale de cohesiondata; la web de Hacienda no respondió. Comprobar en la próxima pasada.
- **B40-04** STEP (15.200 M€) y el balance de la revisión intermedia (marzo de 2026) solo tienen una fuente oficial cada uno; no se encontró un balance posterior. Opciones: (a) usarlos **[aplicada]**; (b) quitar la cifra de la STEP.
- **B40-05** El original atribuía a «de la Fuente (2002)» un 20 % y a «Sosvilla (2010)» un tercio de la convergencia de España por los fondos; no se han localizado esas obras. Se dice «trabajos posteriores atribuyen en torno a 1/5 o 1/3» sin autores. Opciones: (a) así **[aplicada]**; (b) quitar la frase.
- **B40-06** Sentencia C-19/23: el texto de curia no se pudo descargar; el alcance (anulación del art. 5.2 entero, del inciso del 5.1 y de la cláusula «sin que lleve a una reducción» del 5.3) se ha comprobado en la base de jurisprudencia de la FRA y en notas de despachos. Confirmar con el comunicado 136/25.
- **B40-07** La negociación del Fondo 2028-2034 (posiciones del Consejo y de los «Amigos de la Cohesión») no se ha podido seguir con fuentes oficiales más allá de OEIL; el texto lo dice de forma general. El MFP se decide en la cumbre del 26-27/11/2026: registrado en `datos-actualizables.yaml`.
- **B40-08** El PIB regional en PPA relativo a la media se usa para medir crecimientos (convergencia β propia). Eurostat advierte que el PPA sirve para comparar niveles: lo dice la valoración. Opciones: (a) mantener la regresión con PPA **[aplicada]**; (b) rehacerla con el PIB real regional en euros constantes.
- **B40-09** Refrán del enganche: «Dios da pan a quien no tiene dientes» (registrado en `refranes-tanda.txt`). Opciones: (a) mantenerlo **[aplicada]**; (b) «Más vale enseñar a pescar que dar un pez» (no es un refrán tradicional).

## 8. Instrucciones para el vídeo

- **Enganche e idea final**: «Dios da pan a quien no tiene dientes»; Polonia y Rumanía se acercan a la media mientras España, Italia y Grecia se alejan. Idea final: el pan sí alimenta, pero solo a quien puede masticarlo; la cohesión debe ayudar a las regiones a tener dientes.
- **Introducción y conclusión, sin pizarra** (`modo: guion`).
- **I**: el modelo de capital móvil en la pizarra: `eq:mercado-domestico` (función clave que se conserva hasta el final de I) y `mercado-domestico` por capas (ejes; 1/2 y $s_E$; curva con $s_E=0{,}6$; aglomeración total; flecha de la integración; curva tras la transferencia). `historia-cohesion` como apoyo que se va completando; `marco-cohesion` y `cohesion-estados` como apoyo.
- **II**: sin pizarra salvo una lista breve de los 3 objetivos de 2030; `pilar-social` como apoyo.
- **III**: `eq:convergencia-beta` en la pizarra; `convergencia-regional` como apoyo por capas (recta; resto; Este; España); `sigma-regional` y `pib-pc-paises` como apoyo; el modelo de discontinuidad en la pizarra: `eq:rdd` y `rdd-umbral` por capas (ejes; umbral; puntos; recta $D=0$; recta $D=1$; salto $\tau$), que se conserva hasta el final.
- **Funciones clave que se conservan**: `eq:mercado-domestico` (I), `eq:convergencia-beta` y `eq:rdd` (III).
- Nunca se dice el número de un tema en voz alta.

## Nota del coordinador (14/11/2026)
- B40-01 resuelta: el texto del artículo (versión de trabajo de 2008, SIRE/Stirling) dice que el objetivo 1 eleva el crecimiento del PIB por habitante «by about 1.6 percentage points within the same programming period», medido como tasa de crecimiento anual media («by 1.6% … per annum in the average treated region and programming period»). Se escribe «1,6 puntos más de crecimiento anual medio durante el periodo de programación», coherente con el 3.B.37.

## Listas en las notas al pie (15/11/2026)

Ninguna nota lo necesitaba.
