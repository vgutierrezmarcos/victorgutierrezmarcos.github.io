# Revisión del 3.B.42 — Las relaciones económicas exteriores de la Unión Europea. La política de cooperación al desarrollo de la Unión Europea

Revisión completa del 14/11/2026 (entrega 1: tema y ficha de repaso; sin vídeo), en el worktree `revision-temario-2`, en paralelo con los agentes del 3.B.40 y el 3.B.41. Fuente nueva en LaTeX (`3B42.tex`) a partir del Word original (`_trabajo/original.md`, versión del 10/08/2024, el antiguo 3.B.44), **redactada de nuevo** y puesta al día a noviembre de 2026 con fuentes oficiales (EUR-Lex, Comisión, SEAE, Consejo, OCDE-CAD, Eurostat, BCE, OMC, Banco Mundial). Las dudas se resuelven con la opción recomendada y se anotan como B42-NN (14/11/2026).

## 1. Resumen

- Tema completo con los **3 bloques del original** y sus títulos de segundo nivel en su orden: **I. Visión global** (I.1 marco jurídico e institucional, **nuevo**; I.2 el peso económico de la Unión —antes «Datos sobre el desempeño económico»—; I.3 organizaciones y foros), **II. Visión regional** (II.1 la economía como instrumento geoestratégico: ampliación, vecindad, PESC y sanciones; II.2 el movimiento de bienes y factores: los grandes socios) y **III. La cooperación al desarrollo** (III.1 consideraciones generales; III.2 la UE y la AOD: datos, marco, historia de Yaundé a Samoa, instrumentos y retos). Reparto: introducción 2′30″, I 7′30″, II 11′, III 7′30″, conclusión 1′30″.
- **4 modelos nuevos** con la estructura rígida a)-e): el **efecto Bruselas** (Bradford, 2012; regla $F>c\,M_R$), la **condicionalidad de la adhesión** (incentivos externos de Schimmelfennig y Sedelmeier, 2004, como mecanismo de compromiso: $C\leq g+p\,\delta^T B$; evidencia de Campos, Coricelli y Moretti, 2019), el **tope al precio del petróleo ruso** (Johnson, Rachel y Wolfram, 2023; renta $R=[\theta\bar P+(1-\theta)(P^*-k)-c]\bar Q$; evidencia de Kilian, Rapson y Schipper y de los ingresos rusos) y el **reparto eficiente de la ayuda** (Collier y Dollar, 2002: $m_1=m_2$; de 30 a 80 millones de personas al año), que aplica a la UE lo que el 3.B.29 desarrolla sobre la eficacia de la ayuda.
- **11 gráficos y figuras propios** en TikZ/pgfplots: 3 de datos (comercio con los 10 mayores socios en 2025; AOD de los Estados en % de la RNB 2024-2025; IVDCI por partidas), 4 teóricos (efecto Bruselas, condicionalidad, tope al petróleo, reparto de la ayuda) y 4 figuras (actores de la acción exterior, círculos de las relaciones exteriores, etapas de la adhesión, cronología de la cooperación), que sustituyen a las 7 imágenes y 5 cuadros del Word (Wikipedia, BIS, BCE 2017, Camarero et al. 2016). 5 tablas (TFUE quinta parte, la UE en las organizaciones, anclas del euro, competencias).
- PDF: **27 páginas de tema**, 3 de anexos (papel internacional del euro; reparto de competencias; de los ODM a la Agenda 2030; test) y 4 de bibliografía (34). Ficha de repaso de 4 páginas a 10,5 pt (última, 97 %). `verificar-tema.py` con el envoltorio sobre `_trabajo/`: sin errores propios; quedan los de «imagen inexistente en el HTML» (rutas relativas por verificar en `_trabajo/`, como en el 3.B.36), avisos de «cifra sin cita» (párrafos cuya cita va en el gráfico o en la frase siguiente) y los del vídeo (entrega 3).

## 2. Errores corregidos

| Id | Dónde (Word) | Decía | Dice ahora |
|---|---|---|---|
| E1 | III, AOD (definición del CAD) | AOD con «3 características» | 4 requisitos del CAD (organismo público, país de la lista, objetivo de desarrollo, concesionalidad), como el 3.B.29 |
| E2 | III, concesionalidad | «Tras la reforma de 2016» | La donación equivalente se aplica desde los datos de 2018 (45/15/10 %) |
| E3 | Nota 44 | «El Acuerdo de Cotonú (2000) reguló las relaciones… hasta 2007» | Cotonú rigió de 2000 a 2023 (prorrogado) y le sucede el Acuerdo de Samoa (firmado el 15/11/2023, aplicado provisionalmente desde el 1/1/2024, aún sin vigor) |
| E4 | Anexo 3 | «Declaración del Consejo Europeo de 1999 en Copenhague» | Copenhague, junio de **1993**; Madrid, 1995 |
| E5 | Introducción, nota 3 | Eurozona de 20 Estados, con una lista que incluía al Reino Unido, Dinamarca, Suecia, Hungría, Polonia, Chequia, Rumanía y Bulgaria | 21 Estados desde el 1/1/2026 (Bulgaria) |
| E6 | III, financiación | Instrumento de Ayuda Humanitaria «10.300 millones» | 11.569 millones en 2021-2027 (1.900 iniciales en 2026) |
| E7 | II, adhesión | IPA «12.565 millones» con 5 «capítulos» (transición, transfronteriza, regional, recursos humanos, rural) | Eran los componentes del IPA I (2007-2013); IPA III: 14.162 millones, ligado a reformas |
| E8 | III, instrumentos | ENPI, ICD, Instrumento de Estabilidad, etc. «desde 2007», como vigentes | Sustituidos desde 2021 por el IVDCI-Europa Global (79.462 millones), que integra también el FED |
| E9 | II, candidatos | Moldavia y Ucrania «a la espera de iniciar negociaciones»; Georgia, candidato potencial | Paquete del 4/11/2026: 9 candidatos (Georgia incluida, «de nombre»), Kosovo potencial; Ucrania y Moldavia con 4 bloques abiertos; Montenegro 21/33 capítulos cerrados |
| E10 | I.2, OCDE | «23 Estados de la UE son miembros» | 22 (no lo son Bulgaria, Croacia, Chipre, Malta ni Rumanía) |
| E11 | II, vecindad | MFP «Vecindad y resto del mundo: 98.400 millones» | 113.700 millones corrientes tras la revisión de 2024 (coherente con el 3.B.37) |
| E12 | I.1 y III.2 | «La UE contribuyó al 43 % del Desarrollo Oficial global» (2021, Europa Press) y «68 % del CAD en 2016» | Datos de 2025 de la OCDE: los 27, la mitad de la AOD del CAD; instituciones, 23.100 M€ |
| E13 | Anexo 4 | Esfuerzo de ayuda «en proporción al PIB» | En proporción a la RNB |
| E14 | II, vecindad | Imagen 3 (Asociación Oriental) con el enlace de Wikipedia de la Unión por el Mediterráneo | Se quita; la figura de los círculos la sustituye |
| E15 | II, SPG | SPG estándar «renta media y media-baja (4.045 $)», SPG+ «para renta baja (1.036 $)» | Mal caracterizado: el SPG+ es para países vulnerables del SPG estándar que aplican 27 convenios. El detalle pasa al 3.B.41 (frontera del encargo) con remisión |
| E16 | I.2, G-20 | «19 países y la UE» | Y la Unión Africana desde 2023 (cifra canónica del 3.B.19) |
| E17 | I.1, ONU | Estados de la UE «más del 30 %» del presupuesto ordinario | En torno a una quinta parte (estimación con las escalas de cuotas; ver B42-10) |

## 3. Marcas resueltas

| Marca | Texto original | Qué se ha hecho |
|---|---|---|
| Notas al opositor (aviso del cambio de temario de 2023, captura) | — | Desaparecen (avisos de trabajo) |
| «Todo esto brevemente, pues también forma parte del tema 3.B.43» | Nota al opositor | Aplicado: el papel internacional del euro queda resumido en I.2 y desarrollado en el anexo A, según la ficha del canon (D117: referencia en el 3.B.43) |
| Comentarios internos («copiado lo de Juan Luis…», «Estudiar por aquí», notas de ICEX-CECO, «Estructura tema Ángel») | — | No se publican; ningún preparador se nombra. De la nota «me parece clave hacer una mención… al euro» se conserva la mención |
| «Aquí hay que copiar resumidito el tema 3.B.41…» | Comentario | Aplicado en II.2: resumen de los socios con remisión al 3.B.41 para el contenido comercial |
| Amarillo (introducción: naturaleza jurídica, 3 rasgos y atribución de competencias) | Párrafo | Integrado en la contextualización (competencias exclusivas, paralelas e intergubernamentales) y en I.1.2 |
| Amarillo (anexo 4: datos del CAD 2017, esfuerzo de ayuda, cuadro 5, ODM y Compromiso de Barcelona) | Bloque | Datos actualizados en III.2.1 (gráfico de la AOD por Estados 2025); los ODM, Monterrey, el Compromiso de Barcelona y la Agenda 2030 pasan al anexo C, corregidos |
| Apartados vacíos: FSB, «Acuerdos en vigor con países europeos/americanos/…», Relevancia, Opinión e Idea final de la conclusión | — | Escritos (II.2 por socios; conclusión completa) |
| Imágenes 1-7 y cuadros 1-5 | Capturas (BIS, BCE, Wikipedia, OCDE, Camarero et al.) | Rehechas como gráficos y figuras TikZ con datos de 2025 o como tablas |
| Enlaces del original (Fichas del PE sobre socios comerciales; Comisión, papel internacional del euro; BIS; BCE; europa.eu adhesión) | — | Sustituidos por las páginas vigentes en la bibliografía (`CE2026PosicionComercio`, `BCE2026PapelEuro`, `CE2020Metodologia`…); Wikipedia y Europa Press se quitan |
| Anexo 2 (tipo de cambio del euro) | 2 páginas | Resumido en una viñeta del anexo A, con el art. 219 TFUE |
| Bibliografía (Camarero et al., tema de J. L. Cordero, página de la Comisión) | — | Los temas de preparadores no se citan; Camarero et al. no se cita porque sus cuadros se sustituyen por datos oficiales |
| Enlace de test | — | Caja estándar del simulador (`tema=3.B.42`) |

## 4. Datos actualizados

| Dato | Antes | Ahora | Fuente | Consulta | 2.ª comprobación |
|---|---|---|---|---|---|
| Peso de la UE | 15,6 billones € de PIB (2021), «18 %» | 17,9 % del PIB mundial, 14,0 % PPA, 5,5 % de la población (2025) | Banco Mundial WDI | 14/11/2026 | OMC 2026 (cuotas comerciales) |
| Comercio | «Un tercio del comercio global»; China 16,2 % (2021) | 2.º exportador (13,8 %) e importador (12,9 %) de bienes; 1.º de servicios (22,7 %); socios 2025 en el gráfico | OMC (marzo 2026); Eurostat ext_st_eu27_2020sitc | 14/11/2026 | Eurostat SE (déficit con China 372 mm; CSV 375) |
| IED | «Mayor inversor» | 9,3 billones € fuera, 7,0 dentro (2024) | Eurostat (5/11/2025) | 14/11/2026 | — |
| Euro | Reservas 20,1 % (2017), SWIFT 35,7 % | Reservas 20,2 %, deuda 24,6 %, divisas 28,5 %, SWIFT 23 %, facturación 60,0/53,1 % (2025) | BCE, junio 2026 | 14/11/2026 | BIS 2025 (divisas) |
| AOD de la UE | 70.200 M€, 0,49 % (2021) | 27 Estados ≈87.000 M$ (0,41 %, mitad del CAD); instituciones 23.100 M€; CAD 0,26 % | OCDE DAC1 (API) y nota del 9/4/2026 | 14/11/2026 | Coherente con el 3.B.29 |
| AOD por Estados | Lista de 2021 (Luxemburgo 0,99 … España 0,26) | 26 Estados 2024-2025 (gráfico `aod-ue-estados`) | OCDE DAC1 | 14/11/2026 | Focus 2030 (los 4 que superan el 0,7 %) |
| España AOD | 0,26 % | 4.554 M€, 0,27 % (2025) | OCDE DAC1; MAEUEC | 14/11/2026 | 3.B.29 |
| IVDCI | 80 % geográficos / 20 % temáticos | 79.462 M€: 60.388 geográficos, 6.358 temáticos, 3.182 respuesta rápida, 9.534 colchón | Reglamento 2021/947, art. 6 | 14/11/2026 | Síntesis de EUR-Lex |
| IPA III | 12.565 M€ | 14.162 M€ | Reglamento 2021/1529 | 14/11/2026 | DG ENEST |
| Ayuda humanitaria | 10.300 M€ | 11.569 M€ (2021-2027); 1.900 M€ iniciales en 2026 | MFP; ECHO | 14/11/2026 | — |
| Ampliación | Candidatos de 2023 | Paquete del 4/11/2026 | Comisión, IP/26/2325 | 14/11/2026 | 3.B.36 (mismos datos) |
| Ucrania | — | Mecanismo: >32.000 M€ pagados (2/10/2026); Préstamo de Apoyo 90.000 M€ | Comisión | 14/11/2026 | — |
| Sanciones | — | 21 paquetes; tope 44,1 $; ≈210.000 M€ inmovilizados; Reglamento 2026/261 | Comisión (Helpdesk), SEAE, PE | 14/11/2026 | Prensa (ver B42-04) |
| Global Gateway | — | 306.000 M€ movilizados (2021-2024) | Comisión (9/10/2025) | 14/11/2026 | Página de DG INTPA (sin balance posterior) |
| Europa Global 2028-2034 | — | ≈200.000 M€ (0,14 % de la RNB) | CGD, Bruegel | 14/11/2026 | No leída la propuesta oficial (B42-05) |

## 5. Contenido añadido

- **Marco jurídico e institucional** (I.1): arts. 21-22 TUE, tabla de la quinta parte del TFUE, competencias exclusivas/paralelas/PESC, actores (figura), tipos de acuerdos y acuerdos mixtos (Dictamen 2/15), instrumentos financieros de la rúbrica 6.
- **Modelos**: efecto Bruselas (con poder normativo de Manners y poder blando de Nye), condicionalidad, tope al petróleo (con la eficacia de las sanciones de Hufbauer et al. y Pape en extensiones), reparto eficiente de la ayuda.
- **Ampliación** al día: metodología de 2020, IPA III, Plan de Crecimiento de los Balcanes, Moldavia, Mecanismo y Préstamo para Ucrania, paquete del 4/11/2026.
- **Vecindad**: DG ENEST y DG MENA (2025), Pacto por el Mediterráneo, asociaciones estratégicas (Túnez, Mauritania, Egipto, Jordania).
- **Grandes socios**: EE. UU. (Turnberry y la declaración de agosto de 2025, el Supremo de 2026), China (2019, cumbre de 2025), Reino Unido (cumbres de 2025 y 2026), América Latina (CELAC 2025, Mercosur), África (Luanda 2025), Asia e Indo-Pacífico, Golfo.
- **Cooperación**: Consenso de 2017, coherencia de políticas, historia de Yaundé a Samoa (figura), IVDCI con gráfico, FEDS+ y la Garantía de Acción Exterior, Equipo Europa, Global Gateway y su crítica, ayuda humanitaria, propuesta Europa Global 2028-2034, España (Ley 1/2023, FEDES, Plan Director 2024-2027).
- **Nobel**: nota de Acemoglu, Johnson y Robinson (2024), con `NobelPrize2024` reutilizada del 3.A.01.

## 6. Coherencia

- Cifras iguales que en los temas ya hechos: rúbrica 6 (113.700 M€) y propuesta 2028-2034 con Europa Global de 200.000 M€ (3.B.37); AOD del CAD 2025, Alemania primer donante, España 4.554 M€ y 0,27 % (3.B.29); 9 candidatos, Montenegro 21/33, Ucrania y Moldavia (3.B.36); peso del G-20 (canon, 3.B.19); BEI Global (3.B.30).
- Remisiones (`\vertema`): 3.B.19, 3.B.22, 3.B.28, 3.B.29, 3.B.30, 3.B.31, 3.B.33, 3.B.35, 3.B.36, 3.B.37, 3.B.39, 3.B.41, 3.B.43, 3.B.44, 3.A.35, 3.A.38, 3.A.43, 3.A.44, y al 4.º ejercicio 4.A.24 y 4.A.26.
- Frontera con el 3.B.41 (encargo): aquí el marco político y la relación de conjunto con cada socio; los contenidos comerciales de los acuerdos, el SPG y la defensa comercial, allí.
- Las «trampas de pobreza» se citan sin «multidimensional» y con `\vertema{3.B.28}`, como pide el canon; la AOD se resume y remite al 3.B.29 (pendiente del canon cumplido).
- Contradicciones con otros temas: ninguna detectada. Nota: el 3.B.29 da la caída de la AOD de 2025 sin el dato de la UE; aquí se añade (instituciones −13,8 %).

## 7. Dudas abiertas

- **B42-01** (14/11/2026) — *Estructura*. El original no tenía el marco jurídico e institucional, que pide el encargo. Opciones: (a) añadirlo como I.1 y renumerar los subapartados originales (I.1 → I.2, I.2 → I.3); (b) meterlo en la introducción. **Aplicada: (a)**. Además, el título de II.2 («Políticas económicas de la UE en relación con el movimiento transfronterizo de bienes y factores») se acorta a «El movimiento de bienes y factores: los grandes socios».
- **B42-02** (14/11/2026) — *El papel internacional del euro*. Víctor lo quería «un poco largo» en 2024; el canon (D117) lo da en resumen aquí y en desarrollo en el 3.B.43. Opciones: (a) resumen en I.2 y anexo A con indicadores, determinantes y anclas; (b) apartado propio en el cuerpo. **Aplicada: (a)**.
- **B42-03** (14/11/2026) — *Cifra del Equipo Europa 2025*. No hay aún cifra oficial del Consejo/Comisión; se da la suma de los 27 de la OCDE (≈87.000 M$, 0,41 %, la mitad del CAD), cálculo propio. Opciones: (a) mantenerla y sustituirla cuando salga el informe anual; (b) dar solo la de los miembros UE del CAD (0,42 %). **Aplicada: (a)** (ambas aparecen).
- **B42-04** (14/11/2026) — *Datos solo en prensa*: fechas de apertura de los bloques 6 (julio) y 2-3 (octubre) con Ucrania y Moldavia (el comunicado oficial solo da «4 bloques en el último año», que es lo que dice el tema); congelación del tope en 44,1 $ hasta julio de 2027 (21.º paquete); inmovilización indefinida de los activos rusos por el art. 122 TFUE; importes de Túnez y Mauritania; desembolsos acumulados del Plan de Crecimiento (no usados). **Aplicada**: se usan con la redacción prudente; revisar con las fuentes oficiales.
- **B42-05** (14/11/2026) — *Europa Global 2028-2034*: cifras (200.300 M€, 0,14 % de la RNB, 90 % AOD, humanitaria hasta 25.000 M€, reserva de Ucrania) tomadas de CGD y Bruegel, no de la propuesta COM(2025) 551, que no se pudo leer. El estado de la negociación (Consejo Europeo del 26-27/11/2026) es el del 3.B.37.
- **B42-06** (14/11/2026) — *Comercio 2025*: la serie revisada de Eurostat (noviembre de 2026; saldo +106.000 M€, importaciones de China 574.400) difiere de la nota de prensa de marzo (saldo +128.000; China 559.400). **Aplicada**: la revisada, en todo el tema y en el CSV.
- **B42-07** (14/11/2026) — *Refrán adicional*. Se usa «Antes de meter, prometo; y una vez metido, olvido lo prometido» integrado en la extensión de la condicionalidad (inconsistencia temporal tras la adhesión), porque a Víctor le gustó. Nota del coordinador: ya lo usa el 3.A.23 (por eso le gustó), así que aquí se repetiría. Opciones: (a) mantenerlo también aquí, porque encaja muy bien con la inconsistencia temporal tras la adhesión; (b) quitarlo para no repetir. **Aplicada: (a)**.
- **B42-08** (14/11/2026) — *SPG y acuerdos de asociación económica*. El original los desarrollaba (con errores, E15); el encargo los asigna al 3.B.41. **Aplicada**: aquí solo su función en la cooperación, con remisión. Si el 3.B.41 no los cubre al cerrarse, recuperar el bloque en un anexo.
- **B42-09** (14/11/2026) — *Evidencia del tope*. Kilian, Rapson y Schipper atribuyen el descuento sobre todo al embargo y al poder negociador de la India, no al tope. Se cuenta así en d) y e); el modelo se mantiene como explicación del diseño.

- **B42-10** (14/11/2026) — *Cuotas en la ONU y en el FMI*: «en torno a una quinta parte» del presupuesto ordinario de la ONU y «en torno a una cuarta parte» de los votos del FMI son estimaciones con las escalas conocidas, no comprobadas en la fuente oficial en esta sesión (se agotó la búsqueda). **Aplicada**: redacción aproximada; comprobar en la resolución de escalas de la ONU (2025-2027) y en la tabla de votos del FMI.

## 8. Instrucciones para el vídeo

- **Enganche e idea final**: el refrán «Más vale vecino cercano que hermano lejano» (el hermano lejano: EE. UU. con sus aranceles de 2025 y su recorte de ayuda); la idea final lo retoma y responde a la pregunta «¿para qué usa la Unión su peso económico fuera, y le basta con comerciar?».
- **Pizarra**:
  - I.1: la figura de los actores va como **apoyo**; en la pizarra, solo «arts. 21-22 TUE / 205-222 TFUE».
  - I.2: el gráfico del efecto Bruselas (5 capas: ejes, diagonal, zona de arriba, zona de abajo, ejemplos A y B) en la pizarra; la regla $F>c\,M_R$ como `\funcionclave` en una esquina hasta el final de I. El gráfico de comercio, apoyo.
  - II: la **figura de los círculos** como apoyo al empezar II y al volver a cada círculo. Condicionalidad: gráfico en la pizarra por capas (rayo $T_1$ y zona de reforma; rayo $T_2$; recta con $g$; el candidato $X$), y la condición $C\leq g+p\,\delta^T B$ en la esquina durante todo II.1. Las etapas de la adhesión, apoyo. Tope: gráfico en la pizarra (7 capas: ejes, oferta, $P^*$, renta, tope, reparto, flota en la sombra) y la fórmula de $R$.
  - III: el gráfico del reparto de la ayuda en la pizarra (5 capas: caja, $m_1$, $m_2$, $E$, reparto igual y pérdida) con $m_1=m_2$; los gráficos de la AOD por Estados, del IVDCI y la cronología, como apoyo.
- **Funciones clave que se conservan**: $F>c\,M_R$ (en I), $C\leq g+p\,\delta^T B$ (en II.1), $m_1=m_2$ (en III).
- No se dicen números de temas en voz alta.

**Reparto del cante** (nota que iba tras el esquema del tema; quitada del tema el 19/11/2026 a petición de Víctor; puesto al día el 19/11/2026 con la nueva estructura):

> Reparto del cante: introducción, \tiempo{2,5}; I, \tiempo{8,5} (I.1, \tiempo{3}, con el papel internacional del euro; I.2, \tiempo{3}: justificación teórica, competencias y base, actores y decisiones, evolución e instrumentos; I.3, \tiempo{2,5}); II, \tiempo{10} (II.1, \tiempo{6}: ampliación con la idea de la condicionalidad, \tiempo{2,5}; vecindad, \tiempo{1,5}; sanciones con el tope al petróleo, \tiempo{2}; II.2, \tiempo{4}: factores, socios y retos); III, \tiempo{7,5} (III.1, \tiempo{2}; III.2, \tiempo{5,5}, con la fórmula común: relevancia, justificación y marco, evolución, instrumentos y retos), y conclusión, \tiempo{1,5}. Los gráficos y figuras imprescindibles son el del euro en las reservas, los círculos de las relaciones exteriores y el de la AOD por Estados. Lo que va en cajas grises (el mapa de la exposición, el tope en un gráfico, el tipo de cambio del euro), en notas y en los anexos (los 3 modelos) es para las preguntas del tribunal.

- **Pizarra tras el 19/11/2026** (sustituye a lo de arriba donde choque): los modelos del efecto Bruselas, la condicionalidad y el reparto de la ayuda ya no se cantan (anexo A); se nombra su idea de palabra. En I.1, el gráfico del euro en las reservas como apoyo y, en la pizarra, solo «20 % / 57 %»; en I.2, el esquema de los argumentos (escala, externalidades frente a heterogeneidad); en I.3, la tabla de las organizaciones como apoyo; en II.1.3, el gráfico del tope como apoyo (caja gris). El mapa de la exposición no se dibuja (apoyo al final de la introducción). Funciones clave que se conservan: ninguna en el cuerpo.

## Listas en las notas al pie (15/11/2026)

Ninguna nota lo necesitaba.

## Refranes únicos (15/11/2026)

Regla de Víctor: un refrán o dicho no se repite en temas distintos.

- Quitado «antes de meter, prometo; y una vez metido, olvido lo prometido» (inconsistencia temporal tras la adhesión, tema y ficha): se queda en el 3.A.23, donde lo vio Víctor (B42-07 lo había repetido aquí). La idea queda: lo que se promete para entrar deja de convenir cumplirlo una vez dentro.

- Corrección (15/11/2026): Víctor aclara que lo único que no puede repetirse es el **refrán inicial** de cada tema; en el resto del cuerpo los refranes pueden repetirse. Se deshacen los cambios de la sección «Refranes únicos» de arriba: el texto vuelve a como estaba.

## Comentarios de Víctor (19/11/2026)

Aplicados con el encargo común del 18/11 y el añadido de la UE del 19/11. PDF antes: 34 páginas (27 de tema, 3 de anexos, 4 de bibliografía); después: 44 (30 de tema, 9 de anexos, 5 de bibliografía). Ficha de repaso: 4 páginas a 10,5 pt (última al 98 %).

1. **Modelos a anexos y más peso a comercio, inversión, ayuda y moneda**. El efecto Bruselas, la condicionalidad de la adhesión y el reparto eficiente de la ayuda (antiguo III.1.3) pasan al nuevo **anexo A, «3 modelos de la acción exterior»** (A.1-A.3), con la estructura a)-e) completa, sus gráficos y la notación (la caja de notación sale del cuerpo). En el cuerpo queda la idea de palabra con su remisión: el efecto Bruselas entre los argumentos teóricos de I.2.1, la condicionalidad en II.1.1 («Por qué funciona») y la selectividad en III.2.2. El **tope al petróleo ruso** deja de ser un modelo: idea en el cuerpo (II.1.3) y una caja gris con el gráfico, la fórmula de la renta, el tope dinámico, la evidencia y la valoración (ver B42-11). Lo compensa I.1, partido en 3 (comercio e inversión; ayuda; **moneda: el papel internacional del euro**, desarrollado como en el tema de 2024: qué es, 4 determinantes, ventajas e inconvenientes, indicadores por función, evolución, el euro como ancla con la tabla de regímenes y la ambición de 2025-2026), con el informe del BCE de junio de 2026 y un **gráfico de datos nuevo**, `euro-reservas`, con la serie COFER del FMI 1999-2025 descargada de su API (`datos/euro-reservas.csv`). El antiguo anexo del euro se integra en el cuerpo (la historia del tipo de cambio, en caja gris). Datos coherentes con el 3B43 (mismas cifras del BCE y del COFER); el 3B43 no se toca.
2. **Mapa de la exposición** tras la introducción: figura TikZ `mapa-tema` (como la del 3B04), dentro de una caja gris porque no se canta: la pregunta de cada bloque, sus subapartados, el hilo entre bloques y dónde está cada pieza de la fórmula común.
3. **Organizaciones y foros, desarrollado y ordenado**: I.3 pasa a 5 subapartados: principio y base jurídica (arts. 220 y 221 TFUE, 34 TUE, 138 TFUE para el euro y art. 6 de los Estatutos del SEBC; quién habla según la competencia); OMC y Bretton Woods (OMC: miembro, la Comisión, MPIA, MC14 de Yaundé; FMI: no miembro, el BCE observador, EURIMF, votos; Banco Mundial); foros (OCDE con el Protocolo adicional n.º 1 y el CAD, G-7 como miembro no enumerado, G-20); Naciones Unidas y agencias (observador reforzado, FAO, Codex); bancos y foros financieros (BERD, BEI Global, FSB, BPI). La tabla resume estatuto, quién representa y rasgo principal (columna nueva «Quién la representa»).
4. **II.2 desarrollado y ordenado**: 5 subapartados: instrumentos factor a factor (bienes, servicios, capitales con el art. 63 y el control de IED, personas con el Pacto de Migración y Asilo); socios avanzados (EE. UU., Reino Unido, AELC, Japón-Corea-Canadá), los 2 primeros con el mismo patrón «su peso / el marco / la agenda»; rivales sistémicos (China, Rusia); regiones emergentes y en desarrollo; y los retos de la acción exterior.
5. **Los 4 requisitos del CAD en lista numerada** (III.1.1), comprobados con la definición vigente: países de la lista o multilaterales; organismos oficiales; objetivo principal el desarrollo económico y el bienestar; concesionalidad, con los umbrales del elemento de donación (45/15/10 %) y los tipos de descuento (9/7/6 %) desde los datos de 2018.
6. **Justificación teórica en III.2.2 y fórmula común**. En el PDF anterior, III.2.2 era «Marco jurídico y objetivos»; el sitio tiene sentido. Ahora III.2 sigue la fórmula entera: III.2.1 Relevancia; **III.2.2 Justificación y marco jurídico** (aproximación de teoría económica —el antiguo III.1.2 «¿Por qué una política europea de desarrollo?», más la escala y la coordinación y la selectividad remitida al anexo—, delimitación de competencias, marco jurídico, toma de decisiones); III.2.3 Evolución (de Yaundé a Samoa); III.2.4 Articulación (instrumentos); III.2.5 Retos de futuro. III.1 queda con los conceptos básicos y un subapartado nuevo, «La ayuda en el mundo: donantes y agenda» (CAD 2025, receptores, ODM-ODS, de Monterrey a Sevilla, eficacia), que recupera el antiguo «Principales donantes y sectores». **El tema entero** sigue la fórmula: I.1 relevancia (el peso); I.2 justificación (I.2.1 teoría: federalismo fiscal, Oates 1972 y Alesina, Angeloni y Etro 2005), competencias y base jurídica (I.2.2), actores y toma de decisiones (I.2.3), evolución (I.2.4, nuevo: de Roma a la seguridad económica de 2023) e instrumentos (I.2.5); articulación en I.3 (multilateral) y en II (regional); retos de la acción exterior en II.2.5; y la cooperación, con su fórmula completa en III.2. Para ello se invierte el orden de I.1 y I.2 (B42-12).
7. **Anexo de competencias**: el antiguo anexo con la tabla `tab:competencias` se sustituye por el fragmento `_trabajo/anexo-competencias.tex` (figura `competencias-ue`, misma etiqueta `anexo:competencias`, sin duplicar). Todo lo de la tabla está en el diagrama (exclusivas, compartidas con las paralelas, apoyo y PESC), así que no hubo que pasar nada a las viñetas. Va como anexo C, antes del de test; se remite a él desde I.2.2 y III.2.2.
8. **Otros**: `\tcefecha` al 19/11/2026; minutos: introducción 2'30", I 8'30" (antes 7'30"), II 10' (antes 11'), III 7'30", conclusión 1'30" (= 30'); esquema y reparto del cante (en «Instrucciones para el vídeo») al día; ficha de repaso rehecha con la nueva estructura (los 3 modelos, resumidos en un bloque «Anexo: 3 modelos»); `seo.json` y `datos-actualizables.yaml` (euro, COFER, CAD 2025) al día; bibliografía: 8 entradas nuevas o reutilizadas (Alesina-Angeloni-Etro, Oates, Lagarde, EUREP, COFER y su nota, Sevilla, USTR sobre la MC14); las esenciales siguen siendo 4. `verificar-tema.py`: 0 errores.

### Dudas abiertas (19/11/2026)

- **B42-11** (19/11/2026) — *El tope al petróleo ruso*. Víctor sugería dejar la idea sin plantearlo como modelo, con el gráfico en caja gris. Opciones: (a) idea en el cuerpo y caja gris con el gráfico, la fórmula de la renta, el tope dinámico, la evidencia y la valoración, sin estructura a)-e) ni anexo; (b) además, el modelo completo a)-e) en el anexo A como cuarto modelo. **Aplicada: (a)**, para no repetir el gráfico en 2 sitios; no se pierde nada (los supuestos están en la explicación de la caja).
- **B42-12** (19/11/2026) — *Orden del bloque I*. Para seguir la fórmula (relevancia antes que justificación y marco) el peso económico pasa a I.1 y el marco a I.2. Opciones: (a) así; (b) mantener el marco en I.1 y el peso en I.2. **Aplicada: (a)**, que además recupera el orden del tema de 2024 (datos, luego organizaciones).
- **B42-13** (19/11/2026) — *Datos sin fuente oficial leída hoy*: el 3 % del capital del BERD de la Unión y del BEI, el G-7 «miembro no enumerado» desde 1977, la aplicación del Pacto de Migración y Asilo desde junio de 2026 y las cuotas de la ONU y el FMI (B42-10); la MC14 se cita por la nota del USTR y la prensa, no por la OMC. **Aplicada**: redacción prudente; comprobar.
- **B42-14** (19/11/2026) — *Cuota del euro en las reservas*: el gráfico usa el COFER del FMI a tipos corrientes (20,3 % en 2025) y el texto la cifra del BCE a tipos constantes (20,2 %). Opciones: (a) ambas, explicado en la fuente del gráfico; (b) solo la del FMI. **Aplicada: (a)**, coherente con el 3B43.
- Ficha rehecha con el formato nuevo (introducción y esquema en la 1.ª columna, anexo en la última); 10 pt.

## Opinión (21/11/2026)

- **Antes → después**: 1 viñeta → 2 cortas: más poder del que usa y menos del que cree; la ampliación exige que la Unión se reforme. Fuera «si la promesa es creíble», que ya cierra la idea final («solo si cumple lo que promete»).
- **Frase célebre**: No hay frase asignada. Ficha al día.
