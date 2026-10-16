# Traducción del temario al inglés: convenciones, glosario y plan

Preparación para traducir más adelante (con IA y revisión de Víctor) los temas
revisados del 3.er y 4.º ejercicio de la oposición TCEE al inglés, para
publicarlos en la web (`/en/`) y, quizá, en un libro con todo el temario.
**Todavía no se ha traducido ningún tema**; sí están traducidos los 146
títulos oficiales del 3.er y 4.º ejercicio (`temario-en.json`, § 1.2). Este fichero fija las reglas antes
de empezar, para que todos los temas salgan con el mismo inglés, igual que el
canon (`notacion.md`, `modelos/`, `mapa.yaml`) los hace coherentes en castellano.

Lo leen el agente o el script que traduzca y quien revise. Si una regla de
aquí choca con `notacion.md`, manda `notacion.md` en la notación (los símbolos
no se tocan) y este fichero en todo lo demás. Las decisiones de Víctor del
16/10/2026 están en § 3.7; ya no queda ningún **[decidir]** abierto.

Fuentes de esta primera versión (16/10/2026): `canon/notacion.md`, los nombres
de las fichas de `canon/modelos/`, los temas revisados 3.A.8, 3.A.9, 3.A.11,
3.A.12 y 3.A.21 (`fuentes/<tema>/<tema>.tex` y sus gráficos), los títulos de
`temario.json` y `.claude/skills/revisartema/CRITERIOS.md`.

Autor: Víctor Gutiérrez Marcos

---

## 1. Convenciones

### 1.1. Variante: inglés americano

**Inglés americano** (decidido por Víctor el 16/10/2026) (ortografía de Merriam-Webster; puntuación del
*Chicago Manual of Style*):

- Es el de los manuales de referencia del canon: Mas-Colell, Whinston y Green;
  Varian; Jehle y Reny; Romer; Blanchard; Krugman, Obstfeld y Melitz;
  Acemoglu; Galí; Brealey-Myers. Los términos del glosario salen de ellos y el
  lector que los ha estudiado los reconoce tal cual (*labor supply*, *behavior*,
  *modeling*, *center-periphery*).
- Es el inglés mayoritario de la literatura académica de economía (AER,
  Econometrica, JPE, QJE) que citan los temas.

Excepciones (se respeta la grafía oficial, aunque sea británica):

- Nombres propios de instituciones, programas y normas de la UE, el Reino Unido
  y organismos internacionales: *European Labour Authority*, *Stability
  Programme*, *Recovery and Resilience Facility*, *Office for Budget
  Responsibility*, *International Labour Organization*.
- Títulos de obras y citas literales (§ 1.12).

Reglas de estilo derivadas:

- Comillas dobles “…” y simples ‘…’ dentro (en LaTeX, ``` ``…'' ``` y `` `…' ``,
  o `\enquote{}` de csquotes con `american`). Las «» desaparecen. Coma y punto
  dentro de las comillas (estilo americano), salvo cuando lo entrecomillado es
  un símbolo o código.
- Coma serial (*Oxford comma*): «prices, quantities, and income».
- Mayúsculas en los títulos de apartado: **solo la primera palabra y los
  nombres propios** (*sentence case*), como en castellano. Así los títulos
  largos con `\newline` se cortan igual y no hay que decidir caso a caso.
- Los signos de apertura ¿ ¡ desaparecen; las preguntas de la Problemática se
  mantienen como preguntas.
- *e.g.*, *i.e.*, *cf.*, *et al.* en redonda y con coma detrás de *e.g.* e
  *i.e.* («e.g., the CES»).

### 1.2. Títulos oficiales y código del tema

- El **código se conserva tal cual**: «Topic 3.A.8». Es la referencia del
  examen, de la web, de la app y de las remisiones; no se renumera ni se
  convierte en «Chapter 8».
- «Tema» es siempre **topic** (nunca *theme*, *unit* ni *subject*). En el libro,
  cada tema es un capítulo, pero el texto sigue diciendo *topic*.
- El título se traduce **fiel al oficial**, frase a frase, con los términos del
  glosario, aunque en inglés suene enumerativo: es el programa del examen y el
  lector tiene que reconocer qué epígrafe cubre cada apartado. Ejemplo:

  > **Topic 3.A.8. Consumer demand theory (I).** Axioms on preferences,
  > utility function, and Marshallian demand function. Revealed preference
  > theory. Hedonic prices.

  > **Topic 3.A.12. Cost theory.** Duality analysis in the theory of the firm.
  > Empirical applications.

  > **Topic 3.A.21. General equilibrium theory.**

  > **Topic 4.B.19. Wealth taxation in Spain:** the wealth tax, the
  > inheritance and gift tax, the transfer and stamp duty, and the property
  > tax.

- En la portada, bajo el título inglés, el **título oficial en castellano** en
  cursiva y gris, con la etiqueta «Official title (Spanish)». La traducción es
  nuestra, no oficial, y la portada lo dice una vez: «Unofficial translation of
  the syllabus of the Spanish competitive examination for entry into the
  High Corps of Spanish State Economists and Trade Experts (TCEE)».
- El título corto de `\tcetema[…]` (cabeceras) se traduce igual de fiel:
  «Cost theory. Duality in the firm».
- Los títulos ingleses se guardan en un solo sitio, `temario-en.json` (mismo
  esquema que `temario.json`: código → título), para que portada, índice web,
  libro y buscador digan lo mismo. **Hecho (16/10/2026)**: están traducidos
  los 146 títulos del 3.er y 4.º ejercicio, con los nombres de las partes y de
  los ejercicios (`oposicion/temario/temario-en.json`; mismo esquema y mismas
  claves que `temario.json`, pero solo `codigo` y `titulo` en cada tema). Los
  términos nuevos que fijaron están en § 2.13. Víctor los revisa; si cambia
  uno, se cambia allí y en el glosario a la vez.
- Criterios aplicados a los títulos: el orden y la puntuación del castellano
  (punto entre epígrafes, dos puntos y punto y coma donde los hay); las
  comillas del castellano desaparecen («second-best» → *the second best*;
  «input-output» → *input-output*); las erratas del oficial se corrigen en
  inglés sin nota (*Hecksher* → **Heckscher**; *Bretton-Woods* → **Bretton
  Woods**; *G-20* → **G20**); los nombres oficiales de la UE y de los
  organismos internacionales, con su mayúscula y grafía oficial
  (*Macroeconomic Imbalance Procedure*, *Common Fisheries Policy*, *Stability
  Programme*, *Financial Assistance Programme*); las siglas del título
  castellano se conservan donde están (PGE, CAPM, APT) y no se añaden otras.

### 1.3. La oposición, el examen y sus palabras

| Castellano | Inglés | Nota |
|---|---|---|
| oposición | competitive civil-service examination; *the oposición* | La primera vez, glosa: «the *oposición*, Spain's competitive examination for entry into the civil service». Después, *the exam* o *the oposición* (cursiva). |
| Cuerpo Superior de Técnicos Comerciales y Economistas del Estado (TCEE) | High Corps of Spanish State Economists and Trade Experts (TCEE) | Nombre que da Víctor (16/10/2026); se usa tal cual. Las siglas TCEE se conservan siempre. «Un TCEE» (la persona) → *a State Economist and Trade Expert* o *a TCEE*. |
| Ministerio de Economía, Comercio y Empresa | Ministry of Economy, Trade and Enterprise | Nombre que da Víctor (16/10/2026); sin coma serial (es nombre propio). |
| opositor | candidate | Nunca *opponent* ni *oppositor*. |
| tribunal | examining board; *the board* | Nunca *tribunal* (en inglés es un órgano judicial). «Preguntas del tribunal» → *the board's questions*. |
| ejercicio (1.º, 2.º, 3.º…) | exam (first, second, third…) | «Tercer ejercicio» → *the third exam (oral)*. *Exercise* es falso amigo. |
| cantar un tema; el cante | to present a topic orally; the oral presentation | El verbo *sing* nunca. «Guion del cante» → *presentation script*; «vídeo del cante» → *presentation video*; «se canta en 30 minutos» → *is presented in 30 minutes*. |
| no cantar | not for the oral presentation | Marca de material de consulta. |
| pizarra | whiteboard | |
| ficha de repaso | review sheet (four pages) | Las fichas **no se traducen** (§ 3.7): solo se nombran («review sheet, in Spanish»). |
| Nota al opositor (caja `notaopositor`) | Note for candidates | |
| Caja de anotaciones (`anotaciones`) | Further reading | |
| Idea clave (`ideaclave`) | Key idea | |
| temario | syllabus | El conjunto de temas. «Temario anterior» → *previous syllabus*. |
| preparador | tutor (exam coach) | Solo en `revision.md`; en los temas no salen nombres. |

### 1.4. Estructura del tema

Los bloques fijos (CRITERIOS.md § 2) se traducen siempre igual, con el mismo
formato (negrita y cursiva):

| Castellano | Inglés |
|---|---|
| Introducción | Introduction |
| Enganche | Hook |
| Relevancia (teórica, empírica, de política económica) | Relevance (theoretical, empirical, policy) |
| Contextualización | Context |
| Problemática (preguntas clave) | Key questions |
| Estructura | Outline |
| Conclusión | Conclusion |
| Recapitulación | Recap |
| Relevancia | Relevance |
| Extensiones | Extensions |
| Opinión | Opinion |
| Idea final | Final idea |
| a) Idea | a) Idea |
| b) Modelo: i) Supuestos; ii) Desarrollo; iii) Implicaciones | b) Model: i) Assumptions; ii) Derivation; iii) Implications |
| c) Extensiones | c) Extensions |
| d) Evidencia empírica | d) Empirical evidence |
| e) Valoración | e) Assessment |
| Anexo A, B… | Appendix A, B… |
| Bibliografía | References |
| Gráfico n.– | Figure n. |
| Tabla n.– | Table n. |
| Fuente: … | Source: … |
| Elaboración propia a partir de … | Author's elaboration based on … |
| Portada: «Tema: 18 págs. · Anexos: 6 · Bibliografía: 2» | «Topic: 18 pp. · Appendices: 6 · References: 2» |

- *Valoración* es **assessment** (nunca *valuation*, que es valorar un activo).
  *Desarrollo* es **derivation** (nunca *development*). *Estructura* del tema
  es **outline** (*structure* se queda para la de mercado).
- La numeración (I., I.1., I.1.1.; A-1, B-1), las bandas moradas, los
  recuadros, las funciones clave en morado y los `\optim` con las
  restricciones debajo **no cambian**: es la misma maquetación.
- «s.a.» bajo el problema de optimización → **s.t.** (*subject to*).
- Párrafos que dicen el apartado y el orden («partiremos de…; plantearemos…»)
  en primera persona del plural también en inglés: *we start from… we set up…*

### 1.5. Minutos

- Igual que en castellano: **2′30″, 26′30″, 1′** (prima y doble prima). Los
  macros `\minutos{2,5}` y `\tiempo{2,5}` no cambian: la entrada sigue siendo
  decimal con coma (es un argumento para los scripts, no texto).
- En el texto, «(unos `\tiempo{3}`)» → «(about `\tiempo{3}`)»; nunca
  «3 minutes» ni «2.5 minutes».

### 1.6. Personas en versalitas

- La regla es la misma: el **apellido** de toda persona, en versalitas
  (`\autor{}`), con el nombre de pila y el año en redonda; con varios
  apellidos, todos (`\autor{Mas-Colell}`, `\autor{Sala i Martín}`).
- Los nombres se escriben como en la literatura en inglés: **Slutsky**,
  **Konüs**, **Tönnies**, **Kantorovich**; tildes y diéresis de los nombres
  originales se conservan (*Le Châtelier*, *Gutiérrez*, *Törnqvist*).
- Entre dos autores, **and** («\autor{Christensen} and \autor{Greene}
  (1976)»); con tres o más, *et al.* solo en las citas de biblatex; en el texto
  se nombran como en castellano.
- Los epónimos llevan el genitivo inglés cuando es lo habitual (*Shephard's
  lemma*, *Roy's identity*, *Walras' law*, *Engel curve*, *Slutsky equation*,
  *Edgeworth box*): el glosario fija cuál (§ 2).

### 1.7. Notación matemática

- **Se conserva tal cual**: es la del canon y la del vídeo, la ficha y los
  gráficos. Ningún símbolo cambia de letra al traducir (W̄ renta, B beneficio,
  O ocio, μ multiplicador del dual, λ escala, 𝔼 esperanza, etc.).
- Las letras que en castellano son iniciales de una palabra (B de
  **b**eneficio, O de **o**cio, A de **a**ctivos, C(G) **c**oste social…) se
  explican en una **nota de notación** al principio de cada tema y del libro:
  «Notation follows the common notation of the syllabus: *B* denotes profit
  (Spanish *beneficio*), *O* leisure (*ocio*)…». El lector de MWG espera π para
  el beneficio, pero π es aquí la inflación y la probabilidad (D003, D017):
  cambiarla rompería el canon.
- Lo que **sí se traduce dentro de las fórmulas** son las **siglas**
  (`\mathrm{CMg}` → `\mathrm{MC}`) y los subíndices y superíndices que son
  palabras o siglas (`\mathrm{CMe}_{\mathrm{LP}}` → `\mathrm{AC}_{\mathrm{LR}}`,
  `C^{\mathrm{obs}}` se queda: *observed*; `Q^{\mathrm{ac}}` → `Q^{\mathrm{cum}}`;
  `Y^{\mathrm{obj}}` → `Y^{\mathrm{target}}`; `t_{\mathrm{IS}}` → `t_{\mathrm{C}}`;
  `t_{\mathrm{me}}`, `t_{\mathrm{mg}}` → `t_{\mathrm{av}}`, `t_{\mathrm{m}}`).
  Siguen en redonda, como manda `notacion.md` § 0.
- «s.a.» → «s.t.»; «máx.»/«mín.» no existen (son `\max`/`\min`); `\ln` igual.
- Coma decimal en las fórmulas (`0{,}5`) → punto (`0.5`); § 1.10.

### 1.8. Siglas

Criterio: se traduce a la **sigla inglesa estándar de los manuales** toda sigla
de un concepto económico; se **conserva la castellana, con glosa la primera
vez**, la de una institución, estadística, impuesto, ley o instrumento
españoles (es su nombre propio); las de la UE y organismos internacionales
pasan a su **sigla oficial inglesa**. Una sigla, un significado en todo el
temario inglés, igual que en castellano.

**Cuidado con los cruces** (la traducción no puede hacerse con reemplazos
sucesivos, sino de una vez, sigla a sigla, con esta tabla):

- castellano **VC** (variación compensatoria) → inglés **CV**, y castellano
  **CV** (coste variable) → inglés **VC**;
- castellano **CF** (coste fijo) → inglés **FC**, castellano **FC** (flujo de
  caja) → inglés **CF**, y castellano **CF** (cuenta financiera) → inglés **FA**;
- castellano **EC** (excedente del consumidor) → **CS**; la sigla inglesa EC no
  se usa (se leería *European Commission*).

**Conceptos económicos (se traducen)**

| Castellano | Inglés | Significado |
|---|---|---|
| CMg | MC | marginal cost |
| CMe | AC | average cost (nunca ATC; el canon no usa CTMe) |
| CVMe | AVC | average variable cost |
| CFMe | AFC | average fixed cost |
| CV | VC | variable cost (**cruce**) |
| CF | FC | fixed cost (**cruce**) |
| CT | TC | total cost (solo en rótulos de gráficos) |
| CMgP, CMgE, CMgS | PMC, MEC, SMC | private, marginal external, social marginal cost |
| IMg | MR | marginal revenue |
| PMg, PMe | MP, AP | marginal and average product (`\mathrm{MP}_L`) |
| RMS, RMSE | MRS, MRS between states | marginal rate of substitution |
| RMST | MRTS | marginal rate of technical substitution |
| RMT | MRT | marginal rate of transformation |
| EC, EP, ET | CS, PS, TS | consumer, producer, total surplus (ΔEC → ΔCS) |
| VC, VE | CV, EV | compensating and equivalent variation (**cruce**) |
| EG | EB | excess burden (no DWL: el canon distingue el exceso de gravamen del triángulo; *deadweight loss* se usa en prosa) |
| EGMg, RMg (imposición) | MEB, MR^T | marginal excess burden, marginal tax revenue |
| EfT, EfA, EfE | TE, AE, EE | technical, allocative, economic (cost) efficiency (Farrell) |
| CP, LP (subíndices) | SR, LR | short run, long run |
| EGC | CE | competitive equilibrium (en prosa, *Walrasian equilibrium* cuando es el de MWG) |
| MEGC | CGE models | computable general equilibrium models |
| EGDE | DSGE | dynamic stochastic general equilibrium |
| 1TFEB, 2TFEB | 1FWT, 2FWT | first/second fundamental welfare theorem |
| FPP, FPU, GFPU | PPF, UPF, GUPF | production/utility possibility frontier, grand UPF |
| CIS | SIC | social indifference curve |
| FBS | SWF | social welfare function |
| OD (caja de intercambio) | OC | offer curve (`\mathrm{OC}_A`) |
| ADPR, AFPR, AGPR | WARP, SARP, GARP | weak/strong/generalized axiom of revealed preference |
| ESI | EIS | elasticity of intertemporal substitution |
| CRRA, CARA, CES, LES, AIDS, QUAIDS, OLG, RBC, NKPC, NAIRU, IS-LM, DMP, NEG, CAPM, WACC, DCF, EBIT, ROA, ROE | igual | ya son inglesas |
| NEK, NEC | NK, NC | New Keynesian, New Classical |
| PTF | TFP | total factor productivity |
| PIB, PNB, RNB | GDP, GNP, GNI | |
| PAT | — | *apparent labor productivity*, sin sigla (APL chocaría con AP) |
| IPC, IPCA | CPI, HICP | consumer price index, harmonized |
| BP | BoP | balance of payments |
| CC, CK, CF, EO | CA, KA, FA, E&O | current, capital, financial account; errors and omissions (`\mathrm{FA}^{\mathrm{BdE}}`) |
| PII, PIIN | IIP, NIIP | (net) international investment position |
| CI | DC | domestic credit |
| PNCI, PCI, PPA (PDI) | UIP, CIP, PPP | uncovered/covered interest parity, purchasing power parity |
| TCER, TCEN | REER, NEER | real/nominal effective exchange rate |
| RRI | ToT | terms of trade |
| CLU, CLUR | ULC, RULC | (real) unit labor cost |
| VCR | RCA | revealed comparative advantage |
| SCR | NTB | normalized trade balance |
| GL | GL | Grubel-Lloyd |
| VAN, TIR | NPV, IRR | |
| BPA, PER | EPS, P/E | earnings per share, price-earnings ratio |
| VN, VR | FV, TV | face value, terminal value |
| FCL | FCF | free cash flow |
| APR | RWA | risk-weighted assets |
| BI (base imponible) | TB | tax base (*trade balance* no se abrevia nunca) |
| OG | OG | output gap |
| CE(M), CD(M) (Buchanan-Tullock) | C_E(M), C_D(M) | external and decision-making costs |

**Instituciones, estadísticas, impuestos, normas e instrumentos españoles (se
conservan, con glosa la primera vez)**

| Sigla | Glosa la primera vez |
|---|---|
| AIReF | Independent Authority for Fiscal Responsibility (AIReF) |
| BdE | Banco de España (BdE), Spain's central bank — el nombre propio en castellano, como hace el propio banco en inglés |
| CNMC | National Commission on Markets and Competition (CNMC) |
| CNMV | National Securities Market Commission (CNMV) |
| INE | National Statistics Institute (INE) |
| IGAE | General Comptroller of the State Administration (IGAE) |
| REE | Red Eléctrica (REE), Spain's electricity transmission system operator |
| ICEX, CESCE, COFIDES, FIEM | ICEX Spain Trade and Investment; CESCE, export credit agency; COFIDES, development finance institution; FIEM, Fund for the Internationalization of Companies |
| EPA | Labor Force Survey (EPA) |
| EPF | Household Budget Survey (EPF) |
| PGE | General State Budget (PGE) |
| LOEPSF | Organic Law on Budgetary Stability and Financial Sustainability (LOEPSF, 2012) |
| FLA, FFPP | Regional Liquidity Fund (FLA); Fund for the Financing of Payments to Suppliers (FFPP) |
| IRPF | personal income tax (IRPF) |
| IS (impuesto) | corporate income tax (IS) — en fórmulas `t_{\mathrm{C}}`; en prosa nunca «IS» sola, que es la curva IS |
| IBI, ISD, ITPAJD, IP | property tax (IBI); inheritance and gift tax (ISD); transfer and stamp duty (ITPAJD); wealth tax (IP) |
| IIEE | excise duties (IIEE) |
| IMV | Minimum Vital Income (IMV) |
| ITC (índice de tendencia de competitividad) | the Ministry's competitiveness trend index (ITC); no confundir con el International Trade Centre, que se escribe entero |
| SEC 2010 | → **ESA 2010** (es la norma de la UE, § siguiente) |

**UE y organismos internacionales (sigla oficial inglesa)**

MEDE → ESM; MAFC → CBAM; MRR → RRF; UMC → CMU; UAI → SIU; MUS → SSM; MUR →
SRM; FUR → SRF; EDIS (garantía de depósitos) → EDIS; PDE → EDP; PDM → MIP; PEC
→ SGP; UEM → EMU; BCE → ECB; SEBC → ESCB; MFP → MFF; PAC → CAP; TFUE, TUE →
TFEU, TEU; BEI → EIB; FMI → IMF; OMC → WTO; OCDE → OECD; BPI → BIS; BM → World
Bank; AELC → EFTA; NMF → MFN; SPG → GSP; OTC → TBT; MSF → SPS; AGCS → GATS;
ADPIC → TRIPS; MIC → TRIMs; OSD → DSB; ALC/TLC → FTA; SEC 2010 → ESA 2010;
COFOG, NGEU, SURE, BEPS, ATAD, G20 igual. «Semestre Europeo» → *European
Semester*.

### 1.9. Referencias a otros temas

- `\vertema{3.A.9}` sale **«[see topic 3.A.9]»** (en gris, como ahora). Lo
  hace el macro según el idioma; la fuente no cambia.
- Sigue valiendo la regla de que cada tema se canta solo: nunca «as we saw in
  topic…» ni «studied in topic…».
- En la web, la remisión enlaza a la versión inglesa del tema si existe; si no,
  a la castellana con «(in Spanish)».

### 1.10. Cifras, unidades y fechas

- **Punto decimal y coma de millares**: 0,41 → 0.41; 41.500 MW → 41,500 MW;
  18,4 % → 18.4%. En LaTeX: `0,41` → `0.41` en el texto y `0{,}7` → `0.7` en
  las fórmulas; los millares, `41,500` en el texto y `41{,}500` en las fórmulas
  (la llave evita el espacio tras la coma). Porcentaje pegado a la cifra
  («89\%», no «89\,\%»).
- **Billón** castellano (10¹²) es *trillion*; **mil millones** (10⁹) es
  *billion*. Es el falso amigo más peligroso de los datos: se revisa cifra a
  cifra. «Millones de euros» → «€ million» en tablas, «€1.2 billion» en el texto.
- Unidades del SI igual (kWh, MW); «p.p.» → **pp** (*percentage points*).
- Fechas: **October 16, 2026** en el texto; ISO 8601 (2026-10-16) en metadatos
  y `urldate`. Intervalos con raya corta: 2010–2025.
- Décadas y siglos: «los años 30» → **the 1930s** (nunca *the 30s*);
  «siglo XIX» → **19th century**.
- Números en cifras cuando son datos o cantidades («3 types of constraint»),
  como en castellano (CRITERIOS.md § 2), aunque el estilo americano general
  los escribiría con letra: manda la memoria visual del opositor.
- Monedas: €, $ delante de la cifra y sin espacio (€0.41, $0.044); «dólares de
  2025» → *2025 dollars*.

### 1.11. Citas y bibliografía

- **biblatex en inglés**: `babel` con `american`; `\DeclareFieldFormat{urldate}{(accessed #1)}`;
  «y» → «and» entre autores; *et al.*; «ed.», «eds.», «pp.» de biblatex.
- Las mismas claves y el mismo `.bib` que el tema castellano (no se duplica).
  Cada entrada lleva `langid` (`spanish`, `english`, `french`…) para que
  biblatex aplique las reglas de mayúsculas de cada idioma.
- Obras en castellano: título original, y la traducción entre corchetes en el
  campo `titleaddon` o `usera`, que solo imprime la versión inglesa
  («[Spanish public sector statistics]»). Organismos españoles como autores:
  su nombre en castellano (es el que figura en la obra) — «Instituto Nacional
  de Estadística».
- Si hay edición o traducción inglesa estándar de una obra citada en
  traducción castellana (p. ej., Marshall, Walras, Hicks), se cita la
  inglesa: la clave cambia y se anota en `revision-en.md`.
- `\textcite`/`\parencite` igual (versalitas en las citas, no en la lista).

### 1.12. Qué no se traduce

- **Títulos de obras** en cualquier idioma: van en el original
  (*Principles of Economics*, *Éléments d'économie politique pure*,
  *Förelasningar i nationalekonomi*); si no son inglesas, traducción entre
  corchetes la primera vez.
- **Citas literales**: en el original. Si el original no es inglés, se da la
  traducción inglesa en el texto entre comillas y el original en nota al pie
  («Original: “…”»); si hay traducción inglesa publicada, se usa esa y se
  cita. La regla de CRITERIOS.md sigue: ninguna cita entre comillas que no
  esté en la fuente; tampoco se «mejora» una cita al traducirla.
- **Nombres propios** de instituciones españolas, leyes y programas (con glosa
  la primera vez, § 1.8), empresas, sitios web y conjuntos de datos.
  Topónimos: exónimo inglés si está asentado (*Spain*, *Catalonia*,
  *Andalusia*, *Basque Country*, *Navarre*, *Balearic Islands*, *Canary
  Islands*, *Seville*); si no, el nombre castellano.
- **Leyes españolas**: nombre oficial en castellano y en cursiva + glosa
  inglesa la primera vez: *Ley Orgánica 2/2012, de Estabilidad Presupuestaria
  y Sostenibilidad Financiera* (Organic Law on Budgetary Stability…). Las
  normas de la UE, por su título oficial inglés de EUR-Lex.
- **Latín y francés técnicos** siguen en cursiva (*ceteris paribus*, *tâtonnement*,
  *laissez-faire*; *numéraire* va en redonda, como en MWG). En cambio, los términos ingleses que en
  castellano iban en cursiva (*second-best*, *trade-off*, *netput*,
  *doom loop*) pasan a **redonda**: ya no son extranjerismos.
- **Notación** (§ 1.7) y macros de `tcee.sty` (sus nombres y argumentos).
- URLs, nombres de fichero, claves de bibliografía y etiquetas `\label`.

### 1.13. Registro

- Mismo registro esquemático: viñetas, frases cortas, sin relleno. No se
  alarga para «sonar más natural» ni se añaden conectores que no estén.
- Prosa académica en primera persona del plural (*we*), presente para los
  resultados («Shephard (1953) shows…»), pasado para la historia («Viner
  constructed…»).
- Sin contracciones (*does not*, no *doesn't*).
- La empresa genérica, en singular: *the firm* (no *firms* ni *companies*).

---

## 2. Glosario castellano → inglés

Término inglés estándar de los manuales de referencia (MWG, Varian, Jehle y
Reny, Romer, Blanchard, Krugman-Obstfeld-Melitz, Feenstra, Rosen, Stiglitz,
Brealey-Myers). **Ojo** marca falsos amigos y opciones descartadas. Cuando un
tema use un término que no está, el traductor propone la entrada y el revisor
la añade aquí (no se inventa en el tema). Las tablas se pueden leer con un
script (columna 1 → columna 2) para comprobar la coherencia.

### 2.1. Generales y de método

| Castellano | Inglés | Nota |
|---|---|---|
| renta | income | **Ojo**: *rent* solo para la renta económica, del suelo o ricardiana y en *rent-seeking*. «Renta nacional» → *national income*; «renta per cápita» → *income per capita*; «renta disponible» → *disposable income*. |
| renta económica; búsqueda de rentas | economic rent; rent-seeking | |
| beneficio | profit | **Ojo**: *benefit* es «beneficio» en el sentido de ventaja o prestación («beneficio social» del gasto → *social benefit*; «prestaciones» → *benefits*). |
| beneficio extraordinario / normal | economic (supernormal) profit / normal profit | |
| riqueza | wealth | |
| empresa | firm | *Company* o *business* solo en contexto jurídico o de economía española. |
| agente | agent | |
| individualismo metodológico | methodological individualism | |
| supuesto | assumption | Nunca *supposition*. |
| hipótesis (de un modelo) | assumption; hypothesis (contrastable) | |
| contrastar (empíricamente) | to test | **Ojo**: *contrast* es otra cosa. |
| estática comparativa | comparative statics | |
| condiciones de primer / segundo orden | first-/second-order conditions (FOC, SOC) | |
| multiplicador de Lagrange; lagrangiana | Lagrange multiplier; Lagrangian | |
| precio sombra | shadow price | |
| teorema de la envolvente | envelope theorem | |
| condiciones de Kuhn-Tucker | Kuhn-Tucker (KKT) conditions | |
| solución interior / de esquina | interior / corner solution | |
| máximo absoluto | global maximum | |
| hessiano orlado | bordered Hessian | |
| matriz (semi)definida negativa | negative (semi)definite matrix | |
| homogénea de grado k | homogeneous of degree k | |
| homotética | homothetic | |
| cuasicóncava, estrictamente cuasicóncava | quasiconcave, strictly quasiconcave | |
| concavidad, convexidad | concavity, convexity | |
| símplice | simplex | |
| teorema del punto fijo de Brouwer | Brouwer fixed-point theorem | |
| corto plazo, largo plazo | short run, long run | Adjetivo con guion: *short-run cost*. |
| equilibrio parcial / general | partial / general equilibrium | |
| eficiente en el sentido de Pareto; óptimo de Pareto | Pareto efficient; Pareto optimum | |
| bienestar | welfare | *Well-being* solo en sentido filosófico. |
| elasticidad-precio propia / cruzada | own-/cross-price elasticity | |
| elasticidad-renta | income elasticity | |
| tasa de variación | growth rate; rate of change | |
| tipo (de interés, de cambio, impositivo) | rate (interest, exchange, tax rate) | **Ojo**: *type* solo para el tipo de un jugador o agente. |
| tipo de interés nominal / real | nominal / real interest rate | |
| tasa de descuento; factor de descuento | discount rate; discount factor | |
| previsión; proyección | forecast; projection | |
| evidencia empírica | empirical evidence | |
| política económica | economic policy | |
| economía española | the Spanish economy | |
| crecimiento | growth | |
| ciclo económico | business cycle | |
| dato (último disponible) | (latest available) figure / data | |
| elaboración propia | author's elaboration | |

### 2.2. Consumidor (3.A.8-3.A.10)

| Castellano | Inglés | Nota |
|---|---|---|
| teoría de la demanda del consumidor | consumer demand theory | |
| elección racional | rational choice | |
| conjunto de elección / de consumo | choice set / consumption set | |
| cesta (de bienes) | consumption bundle | *Basket* solo en índices de precios. |
| relación binaria; relación de preferencia | binary relation; preference relation | |
| preferencia débil / estricta; indiferencia | weak / strict preference; indifference | |
| preorden completo | complete preorder (complete and transitive relation) | MWG: *rational preference relation*. |
| completitud, transitividad, reflexividad | completeness, transitivity, reflexivity | |
| continuidad, monotonicidad (fuerte), no saciedad local | continuity, (strong) monotonicity, local nonsatiation | |
| convexidad (estricta) de las preferencias | (strict) convexity of preferences | |
| conjunto «al menos tan bueno como» x | upper contour set (“at least as good as” set) | |
| conjunto «no mejor que» x | lower contour set | |
| axiomas básicos / de regularidad | basic axioms / regularity axioms | |
| función de utilidad | utility function | |
| utilidad ordinal / cardinal | ordinal / cardinal utility | |
| utilidad marginal | marginal utility | |
| utilidad marginal de la renta | marginal utility of income (wealth) | |
| curva de indiferencia; mapa de curvas de indiferencia | indifference curve; indifference map | |
| relación marginal de sustitución (RMS) | marginal rate of substitution (MRS) | |
| preferencias cuasilineales / homotéticas | quasilinear / homothetic preferences | |
| restricción presupuestaria | budget constraint | |
| recta de balance | budget line | |
| conjunto presupuestario walrasiano | Walrasian budget set | |
| problema de maximización de la utilidad | utility maximization problem (UMP) | |
| problema de minimización del gasto | expenditure minimization problem (EMP) | |
| demanda marshalliana (ordinaria, walrasiana) | Marshallian (ordinary, Walrasian) demand | MWG la llama *Walrasian demand function*; aquí *Marshallian*, como el canon. |
| demanda hicksiana (compensada) | Hicksian (compensated) demand | |
| función indirecta de utilidad | indirect utility function | |
| función de gasto | expenditure function | **Ojo**: nunca *spending function*. |
| función de utilidad métrica monetaria | money-metric utility function | |
| identidad de Roy | Roy's identity | |
| lema de Shephard | Shephard's lemma | |
| dualidad; enfoque primal / dual | duality; primal / dual approach | |
| ley de Walras | Walras' law | Con apóstrofo sin s, como MWG. |
| homogeneidad de grado cero | homogeneity of degree zero | |
| ausencia de ilusión monetaria | absence of money illusion | |
| agregación de Engel / de Cournot | Engel / Cournot aggregation | |
| curva de Engel | Engel curve | |
| curva de renta-consumo | income expansion path (income-consumption curve) | |
| curva de precio-consumo | price-consumption curve (offer curve) | |
| efecto sustitución; efecto renta | substitution effect; income effect | |
| ecuación de Slutsky; matriz de Slutsky | Slutsky equation; Slutsky matrix | |
| bien normal / inferior / Giffen | normal / inferior / Giffen good | |
| bien de lujo / necesario | luxury good / necessity | |
| sustitutivos brutos / netos | gross / net substitutes | **Ojo**: nunca *substitutives*. |
| complementarios brutos / netos | gross / net complements | |
| efecto Veblen; efecto arrastre; efecto esnob | Veblen effect; bandwagon effect; snob effect | |
| demanda de mercado; agregación | market demand; aggregation | |
| consumidor representativo | representative consumer | |
| forma polar de Gorman | Gorman polar form | |
| integrabilidad; teorema de integrabilidad | integrability; integrability theorem | |
| preferencia revelada | revealed preference | |
| axioma débil / fuerte / generalizado de la preferencia revelada | weak / strong / generalized axiom of revealed preference (WARP, SARP, GARP) | |
| teorema de Houthakker; teorema de Afriat | Houthakker's theorem; Afriat's theorem | |
| precios hedónicos; función hedónica | hedonic prices; hedonic price function | |
| precio implícito | implicit price | |
| función de puja / de oferta (Rosen) | bid function / offer function | |
| características (Lancaster) | characteristics | |
| tecnologías del consumo; producción doméstica | consumption technologies; household production | |
| renta completa | full income | |
| oferta de trabajo; ocio | labor supply; leisure | |
| sistema completo de demanda | complete demand system | |
| sistema lineal de gasto (Stone-Geary) | linear expenditure system (LES) | |
| sistema casi ideal de demanda | Almost Ideal Demand System (AIDS) | |
| formas funcionales flexibles | flexible functional forms | |
| separabilidad débil; presupuestación en dos etapas | weak separability; two-stage budgeting | |
| variación compensatoria / equivalente | compensating / equivalent variation | |
| excedente del consumidor; variación del excedente | consumer surplus; change in consumer surplus | |
| aproximación de Willig | Willig's approximation | |
| variaciones de Laspeyres / de Paasche | Laspeyres / Paasche variation | |
| índice verdadero del coste de la vida (Konüs) | true cost-of-living index (Konüs) | |
| índice de precios de Laspeyres / Paasche / Fisher / Törnqvist | Laspeyres / Paasche / Fisher / Törnqvist price index | |
| índices superlativos | superlative indexes | Plural *indexes* (americano; *indices* en matemáticas). |
| sesgo de sustitución | substitution bias | |
| participación en el gasto | budget (expenditure) share | |
| utilidad esperada; utilidad de Bernoulli | expected utility; Bernoulli utility | |
| lotería | lottery (gamble) | |
| aversión absoluta / relativa al riesgo | absolute / relative risk aversion | |
| equivalente cierto; prima de riesgo | certainty equivalent; risk premium | |
| teoría de las perspectivas | prospect theory | |
| aversión a las pérdidas; efecto dotación; contabilidad mental | loss aversion; endowment effect; mental accounting | |
| elección intertemporal | intertemporal choice | |
| descuento cuasihiperbólico | quasi-hyperbolic discounting | |

### 2.3. Producción y costes (3.A.11-3.A.12)

| Castellano | Inglés | Nota |
|---|---|---|
| teoría de la producción | production theory (theory of production) | |
| tecnología; conjunto tecnológico | technology; technology set | |
| conjunto de posibilidades de producción | production possibility set | |
| vector de producción neta | netput vector (net output vector) | |
| conjunto de requerimientos de factores | input requirement set | |
| factor productivo | input (factor of production) | |
| función de producción | production function | |
| función neoclásica de buen comportamiento | well-behaved neoclassical production function | |
| isocuanta; isoclina | isoquant; isocline | |
| superficie de producción; líneas de contorno | production surface; contour lines | |
| productividad marginal / media | marginal / average product | *Productivity* para la agregada (TFP, productividad del trabajo). |
| relación marginal de sustitución técnica | marginal rate of technical substitution (MRTS) | |
| elasticidad de sustitución (de Hicks, Allen-Uzawa, Morishima) | elasticity of substitution (Hicks, Allen-Uzawa, Morishima) | |
| elasticidad de sustitución constante (CES) | constant elasticity of substitution (CES) | |
| ley de los rendimientos marginales decrecientes | law of diminishing marginal returns | |
| ley de las proporciones variables | law of variable proportions | |
| región económica de la producción | economic region of production | |
| rendimientos a escala (crecientes, constantes, decrecientes) | (increasing, constant, decreasing) returns to scale | **Ojo**: *yields* nunca. |
| rendimientos globales / locales a escala | global / local returns to scale | |
| elasticidad de escala; factor de escala | elasticity of scale; scale factor | |
| rendimientos marginales mixtos | cross-partial (mixed) marginal products | |
| progreso técnico neutral en el sentido de Hicks / Harrod / Solow | Hicks- / Harrod- / Solow-neutral technical progress | |
| progreso técnico incorporado / no incorporado | embodied / disembodied technical progress | |
| producción conjunta; empresa multiproducto | joint production; multiproduct firm | |
| función de transformación; curva de transformación | transformation function; transformation curve | |
| relación marginal de transformación | marginal rate of transformation (MRT) | |
| teoría de los costes | cost theory | |
| coste económico / contable | economic / accounting cost | |
| coste de oportunidad | opportunity cost | |
| maximización del beneficio; minimización del coste | profit maximization; cost minimization | |
| problema en una / dos etapas | one-stage / two-stage problem | |
| función de costes | cost function | |
| función de beneficio | profit function | |
| demandas condicionadas / no condicionadas de factores | conditional / unconditional factor demands | |
| función de oferta | supply function | |
| lema de Hotelling | Hotelling's lemma | |
| ley de la demanda condicionada | law of (conditional) factor demand | |
| matriz de sustitución de factores | substitution matrix | |
| función soporte | support function | |
| senda de expansión | expansion path | |
| coste total, fijo, variable | total, fixed, variable cost | |
| coste marginal, medio, variable medio, fijo medio | marginal, average, average variable, average fixed cost | |
| curva envolvente (Viner) | envelope curve | |
| principio de Le Châtelier-Samuelson | Le Châtelier-Samuelson principle | |
| economías / deseconomías de escala | economies / diseconomies of scale | |
| economías de escala multiproducto | multiproduct economies of scale (ray economies) | |
| economías de alcance | economies of scope | |
| complementariedad de costes | cost complementarities | |
| subaditividad | subadditivity | |
| escala mínima eficiente | minimum efficient scale (MES) | |
| economías externas / internas | external / internal economies | |
| monopolio natural | natural monopoly | |
| reserva de capacidad (Stigler) | capacity reserve (flexibility) | |
| ineficiencia X | X-inefficiency | |
| eficiencia técnica / asignativa / económica | technical / allocative / economic (cost) efficiency | |
| frontera de eficiencia; frontera estocástica | efficient frontier; stochastic frontier | |
| análisis envolvente de datos | data envelopment analysis (DEA) | |
| función de costes translogarítmica | translog cost function | |
| curva de aprendizaje; producción acumulada | learning curve; cumulative output | |
| coste nivelado de la electricidad | levelized cost of electricity (LCOE) | |
| empresa multiplanta | multiplant firm | |
| demanda derivada | derived demand | |

### 2.4. Mercados, juegos e información (3.A.13-3.A.20)

| Castellano | Inglés | Nota |
|---|---|---|
| competencia perfecta | perfect competition | |
| precio aceptante | price taker | |
| libre entrada y salida | free entry and exit | |
| umbral de rentabilidad; punto de cierre | break-even point; shutdown point | |
| monopolio; monopsonio | monopoly; monopsony | |
| índice de Lerner; margen | Lerner index; markup | |
| discriminación de precios (de primer, segundo, tercer grado) | (first-, second-, third-degree) price discrimination | |
| tarifa en dos partes; tarificación pico-valle | two-part tariff; peak-load pricing | |
| competencia monopolística | monopolistic competition | |
| oligopolio; duopolio | oligopoly; duopoly | |
| función de reacción | reaction (best-response) function | |
| líder y seguidor (Stackelberg) | leader and follower | |
| colusión; cártel | collusion; cartel | |
| mercados impugnables (contestables) | contestable markets | |
| barreras de entrada | barriers to entry | |
| diferenciación de productos (horizontal, vertical) | (horizontal, vertical) product differentiation | |
| regulación por tasa de rentabilidad; precio máximo | rate-of-return regulation; price cap | |
| competencia por comparación | yardstick competition | |
| captura del regulador | regulatory capture | |
| separación vertical; acceso de terceros | vertical separation; third-party access | |
| teoría de juegos; juego no cooperativo | game theory; noncooperative game | |
| equilibrio de Nash; estrategia dominante | Nash equilibrium; dominant strategy | |
| dilema del prisionero | prisoner's dilemma | |
| equilibrio perfecto en subjuegos; inducción hacia atrás | subgame-perfect equilibrium; backward induction | |
| juego bayesiano; creencias | Bayesian game; beliefs | |
| coalición; función característica; imputación | coalition; characteristic function; imputation | |
| núcleo | core | |
| valor de Shapley | Shapley value | |
| principio de revelación | revelation principle | |
| subastas (inglesa, holandesa, de primer / segundo precio) | (English, Dutch, first-/second-price) auctions | |
| información asimétrica | asymmetric information | |
| selección adversa; riesgo moral | adverse selection; moral hazard | |
| señalización; cribado | signaling; screening | |
| principal-agente; restricción de participación / de incentivos | principal-agent; participation / incentive-compatibility constraint | |
| racionamiento del crédito | credit rationing | |
| exceso de demanda | excess demand | |
| ajuste walrasiano (por precios) / marshalliano (por cantidades) | Walrasian (price) / Marshallian (quantity) adjustment | |
| modelo de la telaraña | cobweb model | |

### 2.5. Equilibrio general y bienestar (3.A.21-3.A.24)

| Castellano | Inglés | Nota |
|---|---|---|
| teoría del equilibrio general | general equilibrium theory | |
| equilibrio general competitivo (walrasiano) | competitive (Walrasian) general equilibrium | |
| modelo 2×2×2×2 | 2×2×2×2 model | |
| economía de intercambio puro | pure exchange economy | |
| dotación (inicial) | (initial) endowment | **Ojo**: nunca *dotation*. |
| caja de Edgeworth (de intercambio / de producción) | Edgeworth box (exchange / production) | |
| curva de contrato; lente | contract curve; lens | |
| curva de oferta-demanda | offer curve | |
| participación en los beneficios | profit share (shareholding) | |
| numerario | numéraire | En redonda: término asentado (MWG). |
| bienes económicos / libres | economic / free goods | |
| subastador walrasiano; tanteo | Walrasian auctioneer; tâtonnement | *Tâtonnement* en cursiva. |
| existencia, unicidad, estabilidad | existence, uniqueness, stability | |
| globalmente estable | globally stable | |
| teorema de Sonnenschein-Mantel-Debreu | Sonnenschein-Mantel-Debreu theorem | |
| teorema del índice | index theorem | |
| principio de correspondencia | correspondence principle | |
| economías regulares | regular economies | |
| núcleo; teorema del límite del núcleo; bloquear | core; core limit theorem (Debreu-Scarf); to block | |
| réplica de la economía | replica economy | |
| teoremas fundamentales de la economía del bienestar | fundamental theorems of welfare economics | |
| bien contingente; precios de Arrow-Debreu | contingent commodity; Arrow-Debreu prices | |
| títulos de Arrow; mercados completos / incompletos | Arrow securities; complete / incomplete markets | |
| equilibrio de planes, precios y expectativas de precios (Radner) | equilibrium of plans, prices, and price expectations | |
| efecto saldos reales (Patinkin) | real balance effect | |
| dicotomía clásica | classical dichotomy | |
| teoremas de Stolper-Samuelson / Rybczynski | Stolper-Samuelson / Rybczynski theorems | |
| efecto magnificación | magnification effect | |
| economía del bienestar | welfare economics | |
| frontera de posibilidades de producción / de utilidad | production / utility possibility frontier | |
| función de bienestar social (utilitarista, rawlsiana) | (utilitarian, Rawlsian) social welfare function | |
| criterio de compensación (Kaldor-Hicks) | compensation criterion | |
| teorema de imposibilidad de Arrow | Arrow's impossibility theorem | |
| paradoja de Condorcet; votante mediano | Condorcet paradox; median voter | |
| preferencias unimodales | single-peaked preferences | |
| fallos de mercado | market failures | |
| externalidad; impuesto pigouviano | externality; Pigouvian tax | |
| bien público (puro); condición de Samuelson | (pure) public good; Samuelson condition | |
| polizón | free rider | |
| bien preferente | merit good | |
| teoría del second best | theory of the second best | Ya en inglés: redonda. |
| equidad; aversión a la desigualdad | equity; inequality aversion | |
| curva de Lorenz; índice de Gini | Lorenz curve; Gini index | |

### 2.6. Mercado de trabajo (3.A.25-3.A.28)

| Castellano | Inglés | Nota |
|---|---|---|
| población activa; activos | labor force | **Ojo**: «activos» es también *assets*; se traduce por el contexto. |
| ocupados; parados | employed; unemployed | |
| tasa de actividad; tasa de paro | (labor force) participation rate; unemployment rate | |
| paro estructural / friccional / cíclico | structural / frictional / cyclical unemployment | |
| tasa natural de paro | natural rate of unemployment | |
| vacantes; tensión del mercado | vacancies; labor market tightness | |
| emparejamiento; función de emparejamiento | matching; matching function | |
| tasa de separación | separation rate | |
| salario de reserva | reservation wage | |
| salarios de eficiencia | efficiency wages | |
| contratos implícitos | implicit contracts | |
| poder negociador; negociación colectiva | bargaining power; collective bargaining | |
| histéresis | hysteresis | |
| insiders-outsiders | insider-outsider | |
| elasticidad de Frisch | Frisch elasticity | |
| capital humano | human capital | |
| coste laboral unitario | unit labor cost | |

### 2.7. Macroeconomía: crecimiento, consumo e inversión

| Castellano | Inglés | Nota |
|---|---|---|
| contabilidad del crecimiento | growth accounting | |
| productividad total de los factores | total factor productivity (TFP) | |
| estado estacionario; senda de crecimiento equilibrado | steady state; balanced growth path | |
| regla de oro | golden rule | |
| ineficiencia dinámica | dynamic inefficiency | |
| convergencia β / σ, absoluta / condicional | β- / σ-convergence, absolute / conditional | |
| trampa de pobreza | poverty trap | |
| crecimiento endógeno | endogenous growth | |
| aprendizaje por la práctica | learning by doing | |
| destrucción creativa | creative destruction | |
| difusión tecnológica | technology diffusion | |
| estancamiento secular | secular stagnation | |
| generaciones solapadas | overlapping generations (OLG) | |
| renta permanente; hipótesis del ciclo vital | permanent income; life-cycle hypothesis | |
| propensión marginal a consumir / ahorrar | marginal propensity to consume / save | |
| ahorro precautorio | precautionary saving | |
| restricciones de liquidez | liquidity constraints | |
| suavización del consumo | consumption smoothing | |
| q de Tobin; coste de ajuste | Tobin's q; adjustment cost | |
| coste de uso del capital | user cost of capital | |
| acelerador | accelerator | |
| depreciación | depreciation | En macro abierta, *depreciation* del tipo de cambio también. |
| ciclo real | real business cycle (RBC) | |
| perturbación (shock) | shock | |
| brecha de producción | output gap | |
| producción potencial / natural | potential / natural output | |

### 2.8. Dinero, inflación, política monetaria y fiscal

| Castellano | Inglés | Nota |
|---|---|---|
| teoría cuantitativa del dinero | quantity theory of money | |
| velocidad de circulación | velocity of money | |
| demanda de dinero; saldos reales | money demand; real balances | |
| oferta monetaria; base monetaria | money supply; monetary base | |
| multiplicador monetario | money multiplier | |
| señoreaje; impuesto inflacionario | seigniorage; inflation tax | |
| hiperinflación | hyperinflation | |
| aritmética monetarista desagradable | unpleasant monetarist arithmetic | |
| curva de Phillips (aumentada con expectativas, neokeynesiana) | (expectations-augmented, New Keynesian) Phillips curve | |
| expectativas adaptativas / racionales | adaptive / rational expectations | |
| crítica de Lucas | Lucas critique | |
| inconsistencia temporal; sesgo inflacionista | time inconsistency; inflation bias | |
| reglas frente a discreción | rules versus discretion | |
| regla de Taylor; principio de Taylor | Taylor rule; Taylor principle | |
| objetivo de inflación | inflation targeting | |
| tipo de interés natural | natural rate of interest | |
| cota inferior cero | zero lower bound | |
| expansión cuantitativa | quantitative easing | |
| mecanismo de transmisión | transmission mechanism | |
| rigideces nominales; contratos escalonados | nominal rigidities; staggered contracts | |
| política fiscal; multiplicador fiscal | fiscal policy; fiscal multiplier | |
| estabilizadores automáticos | automatic stabilizers | |
| efecto expulsión | crowding out | |
| equivalencia ricardiana | Ricardian equivalence | |
| consolidación fiscal; efectos no keynesianos | fiscal consolidation; non-Keynesian effects | |
| saldo presupuestario (primario, estructural, cíclico) | (primary, structural, cyclical) budget balance | |
| déficit; deuda pública | deficit; public (government) debt | |
| restricción presupuestaria del sector público | government budget constraint | |
| sostenibilidad de la deuda; diferencial tipo-crecimiento | debt sustainability; interest-growth differential (r − g) | |
| suavización impositiva | tax smoothing | |
| teoría fiscal del nivel de precios | fiscal theory of the price level (FTPL) | |
| dominancia fiscal / monetaria | fiscal / monetary dominance | |
| regla fiscal; regla de gasto | fiscal rule; expenditure rule | |

### 2.9. Macroeconomía abierta y comercio internacional

| Castellano | Inglés | Nota |
|---|---|---|
| balanza de pagos | balance of payments (BoP) | |
| cuenta corriente / de capital / financiera | current / capital / financial account | |
| posición de inversión internacional (neta) | (net) international investment position | |
| tipo de cambio nominal / real | nominal / real exchange rate | |
| tipo de cambio directo (incierto) | exchange rate in direct (price) quotation | Canon: E = moneda nacional por unidad extranjera; ↑ = depreciación. |
| apreciación; depreciación | appreciation; depreciation | |
| devaluación; revaluación | devaluation; revaluation | |
| tipo de cambio fijo / flexible | fixed / floating exchange rate | |
| tipo a plazo; tipo al contado | forward rate; spot rate | |
| paridad de intereses (cubierta, descubierta) | (covered, uncovered) interest parity | |
| paridad del poder adquisitivo | purchasing power parity (PPP) | |
| sobrerreacción del tipo de cambio | exchange rate overshooting | |
| movilidad del capital | capital mobility | |
| enfoque monetario / de cartera / de absorción / de elasticidades | monetary / portfolio balance / absorption / elasticities approach | |
| condición de Marshall-Lerner; curva J | Marshall-Lerner condition; J-curve | |
| trinidad imposible | impossible trinity (trilemma) | |
| áreas monetarias óptimas | optimum currency areas | |
| crisis de balanza de pagos | balance-of-payments crisis | |
| ventaja absoluta / comparativa | absolute / comparative advantage | |
| relación real de intercambio | terms of trade | **Ojo**: nunca *real exchange relation*. |
| abundancia / intensidad factorial | factor abundance / intensity | |
| igualación del precio de los factores | factor price equalization | |
| paradoja de Leontief | Leontief paradox | |
| comercio intraindustrial / interindustrial | intra-industry / inter-industry trade | |
| nueva teoría del comercio internacional | new trade theory | |
| heterogeneidad empresarial | firm heterogeneity | |
| coste iceberg | iceberg trade cost | |
| ecuación de gravedad | gravity equation | |
| margen extensivo / intensivo | extensive / intensive margin | |
| dumping recíproco | reciprocal dumping | |
| política comercial estratégica | strategic trade policy | |
| arancel (ad valorem, específico); arancel óptimo | (ad valorem, specific) tariff; optimal tariff | |
| contingente; restricción voluntaria de exportaciones | quota; voluntary export restraint | |
| protección efectiva | effective rate of protection | |
| subsidio a la exportación | export subsidy | |
| industria naciente | infant industry | |
| creación / desviación de comercio | trade creation / diversion | |
| unión aduanera; zona de libre comercio | customs union; free trade area | |
| arancel exterior común | common external tariff | |
| centro-periferia; nueva geografía económica | core-periphery; new economic geography | |
| tesis de Prebisch-Singer | Prebisch-Singer hypothesis | |
| dilema de Triffin | Triffin dilemma | |
| internacionalización (de la empresa) | internationalization | |
| inversión extranjera directa | foreign direct investment (FDI) | |
| cadenas globales de valor | global value chains | |

### 2.10. Finanzas y empresa

| Castellano | Inglés | Nota |
|---|---|---|
| valor actual neto; tasa interna de rentabilidad | net present value; internal rate of return | |
| flujo de caja (libre) | (free) cash flow | |
| coste de capital; coste medio ponderado del capital | cost of capital; weighted average cost of capital (WACC) | |
| rentabilidad económica / financiera | return on assets / return on equity | **Ojo**: «rentabilidad» es *return* (o *yield* en bonos), nunca *profitability* en finanzas. |
| apalancamiento | leverage | |
| estructura de capital (Modigliani-Miller) | capital structure | |
| dividendo; tasa de retención | dividend; retention (plowback) ratio | |
| cartera; frontera eficiente; diversificación | portfolio; efficient frontier; diversification | |
| línea del mercado de capitales / de títulos | capital / security market line | |
| riesgo sistemático / idiosincrásico | systematic / idiosyncratic risk | |
| hipótesis de los mercados eficientes | efficient market hypothesis (EMH) | |
| finanzas conductuales | behavioral finance | |
| bono; cupón; nominal; duración | bond; coupon; face value; duration | |
| curva de tipos; estructura temporal | yield curve; term structure | |
| contango; normal backwardation | contango; normal backwardation | |
| derivados; opción de compra / de venta; futuro | derivatives; call / put option; future | |
| opciones reales | real options | |
| pánico bancario | bank run | |
| transformación de vencimientos | maturity transformation | |
| requisitos de capital; activos ponderados por riesgo | capital requirements; risk-weighted assets | |
| supervisión micro / macroprudencial | micro- / macroprudential supervision | |
| sistema financiero | financial system | |

### 2.11. Sector público

| Castellano | Inglés | Nota |
|---|---|---|
| sector público; Administraciones Públicas | public sector; general government | «Administraciones Públicas» (SEC) → *general government*. |
| hacienda pública | public finance | |
| funciones de Musgrave (asignación, distribución, estabilización) | Musgrave's functions (allocation, distribution, stabilization) | |
| tamaño del sector público; presión fiscal | size of government; tax burden (tax-to-GDP ratio) | |
| ingresos públicos; recaudación | government revenue; tax revenue | **Ojo**: «ingresos» de la empresa es *revenue*; de las familias, *income*. |
| gasto público | public expenditure (government spending) | |
| presupuesto; ciclo presupuestario | budget; budget cycle | |
| clasificación orgánica / económica / por programas | organizational / economic / functional (program) classification | |
| control presupuestario interno / externo | internal / external audit (budgetary control) | |
| impuesto de suma fija | lump-sum tax | |
| tipo medio / marginal | average / marginal tax rate | |
| base imponible; cuota | tax base; tax liability | |
| progresividad; regresividad | progressivity; regressivity | |
| incidencia legal / económica | statutory / economic incidence | |
| traslación de impuestos | tax shifting | |
| exceso de gravamen; triángulo de Harberger | excess burden; Harberger triangle | |
| imposición óptima; regla de Ramsey | optimal taxation; Ramsey rule | |
| regla de la elasticidad inversa | inverse elasticity rule | |
| regla de Corlett-Hague | Corlett-Hague rule | |
| imposición directa / indirecta | direct / indirect taxation | |
| impuesto dual sobre la renta | dual income tax | |
| impuesto sobre el valor añadido | value added tax (VAT) | |
| impuestos especiales | excise duties | |
| impuesto sobre el patrimonio / sucesiones | wealth tax / inheritance tax | |
| cotizaciones sociales | social security contributions | |
| gasto fiscal; beneficio fiscal | tax expenditure; tax relief | |
| ilusión fiscal | fiscal illusion | |
| elección pública; burócrata (Niskanen) | public choice; budget-maximizing bureaucrat | |
| mayoría óptima | optimal majority | |
| ciclo político-económico | political business cycle | |
| federalismo fiscal; descentralización | fiscal federalism; decentralization | |
| votar con los pies (Tiebout) | voting with one's feet | |
| competencia / armonización fiscal | tax competition / harmonization | |
| restricción presupuestaria blanda | soft budget constraint | |
| financiación autonómica | regional (autonomous community) financing system | |
| comunidades autónomas; corporaciones locales | autonomous communities (regions); local governments | |
| pensiones (de reparto / capitalización) | (pay-as-you-go / funded) pensions | |
| prestaciones por desempleo | unemployment benefits | |
| ingreso mínimo vital | Minimum Vital Income (IMV) | |
| tasa social de descuento | social discount rate | |
| análisis coste-beneficio | cost-benefit analysis | |

### 2.12. Economía española, UE e instituciones

| Castellano | Inglés | Nota |
|---|---|---|
| fuentes estadísticas | statistical sources | |
| Contabilidad Nacional | national accounts | |
| Sistema Europeo de Cuentas (SEC 2010) | European System of Accounts (ESA 2010) | |
| tablas input-output | input-output tables | |
| productividad aparente del trabajo | apparent labor productivity | |
| PIB per cápita | GDP per capita | |
| convergencia real / nominal | real / nominal convergence | |
| criterios de convergencia (Maastricht) | convergence criteria | |
| Pacto de Estabilidad y Crecimiento | Stability and Growth Pact (SGP) | |
| procedimiento de déficit excesivo | excessive deficit procedure (EDP) | |
| Programa de Estabilidad | Stability Programme | Grafía oficial UE. |
| Unión Bancaria; Mecanismo Único de Supervisión / de Resolución | Banking Union; Single Supervisory / Resolution Mechanism | |
| Mecanismo Europeo de Estabilidad | European Stability Mechanism (ESM) | |
| marco financiero plurianual; recursos propios | multiannual financial framework; own resources | |
| política de cohesión; fondos estructurales | cohesion policy; structural funds | |
| Política Agrícola Común | Common Agricultural Policy (CAP) | |
| mercado único; libre circulación | single market; free movement | |
| Comisión Europea; Consejo; Parlamento Europeo | European Commission; Council of the EU; European Parliament | *Council of the EU* ≠ *European Council*. |
| Banco de España | Banco de España | Nombre propio; glosa *Spain's central bank*. |
| Ministerio de Economía, Comercio y Empresa | Ministry of Economy, Trade and Enterprise | Decidido por Víctor (16/10/2026). |
| Secretaría de Estado de Comercio | Secretary of State for Trade | |
| sistema de Bretton Woods; patrón oro | Bretton Woods system; gold standard | |
| mecanismo de flujo especie-precio | price-specie flow mechanism | |
| Ronda Uruguay; cláusula de nación más favorecida | Uruguay Round; most-favored-nation (MFN) clause | |
| desarrollo económico; economía dual (Lewis) | economic development; dual economy | |
| instituciones extractivas / inclusivas | extractive / inclusive institutions | |
| Plan de Estabilización (1959) | Stabilization Plan | |

### 2.13. Términos fijados con los títulos oficiales (16/10/2026)

Salen de traducir los 146 títulos (`temario-en.json`). Se usan igual en los
temas.

| Castellano | Inglés | Nota |
|---|---|---|
| objeto (de la ciencia económica) | subject matter | |
| ciencia económica | economic science; economics | *Economic science* en el título de 3.A.1; en prosa, *economics*. |
| economía conductual | behavioral economics | |
| pensamiento económico | economic thought | |
| desequilibrio (escuela) | disequilibrium (disequilibrium economics) | |
| nueva macroeconomía clásica | new classical macroeconomics | |
| nueva economía keynesiana | New Keynesian economics | *New Keynesian* con mayúscula (adjetivo de Keynes). |
| síntesis neoclásica; monetarismo | neoclassical synthesis; monetarism | |
| economía de la información; teoría de la agencia | economics of information; agency theory | |
| teoría de la organización industrial | industrial organization theory | |
| economía de los costes de transacción | transaction cost economics | |
| análisis de mercados | market analysis | |
| mercado relevante | relevant market | |
| monopolio bilateral | bilateral monopoly | |
| soluciones cooperativas / no cooperativas | cooperative / noncooperative solutions | *Noncooperative* sin guion (americano). |
| óptimo económico; second best | economic optimum; the second best | |
| fallos del sector público | government failures | No *public sector failures*: el término asentado es *government failure*. |
| teoría de la elección colectiva | collective choice theory | Fiel al título; *social choice* en prosa cuando sea Arrow-Sen. |
| función de ingresos de capital humano (Mincer) | human capital earnings function | |
| búsqueda y emparejamiento | search and matching | |
| demanda de trabajo | labor demand | |
| modelización dinámica; toma de decisiones | dynamic modeling; decision-making | |
| horizonte infinito | infinite horizon (infinite-horizon models) | |
| magnitudes macroeconómicas | macroeconomic aggregates | |
| modelo de oferta y demanda agregada | aggregate supply and demand model (AD-AS) | Orden del título castellano; en prosa, *AD-AS model*. |
| shocks y políticas de oferta | supply shocks and supply-side policies | |
| consumo corriente; bienes de consumo duradero | current consumption; consumer durables | |
| bienes de equipo | capital goods | También en 4.A.10 (*capital goods manufacturing*). |
| irreversibilidad de la inversión | irreversibility of investment | |
| diseño e instrumentación (de la política monetaria) | design and implementation | |
| política monetaria convencional / no convencional | conventional / unconventional monetary policy | |
| fricciones financieras | financial frictions | |
| déficit público | public deficit | Igual que *public debt* (§ 2.8). En prosa, *government deficit* vale. |
| dominación (dominancia) monetaria / fiscal | monetary / fiscal dominance | El título dice «dominación»; en inglés solo *dominance*. |
| economías desarrolladas | developed economies | *Advanced economies* solo cuando la fuente es el FMI. |
| Gran Recesión | Great Recession | |
| valor de los multiplicadores fiscales | size of fiscal multipliers | Término de la literatura (*the size of the multiplier*). |
| ciclo financiero; ciclo real | financial cycle; real cycle | |
| progreso técnico exógeno | exogenous technical progress | |
| distribución de la renta entre los factores de producción | distribution of income among factors of production; factor (functional) distribution of income | 3.A.45 y 4.A.3. |
| convergencia económica internacional | international economic convergence | |
| información financiera (de las empresas) | financial reporting | |
| estados de situación / de circulación | statements of financial position / flow statements | |
| criterios de valoración de proyectos | project appraisal criteria | **Ojo**: *valuation* solo para valorar un activo o una empresa (*firm valuation*). |
| financiación propia / ajena | equity / debt financing | |
| política de dividendos | dividend policy | |
| valoración de empresas | firm valuation | |
| fusiones, adquisiciones y alianzas estratégicas | mergers, acquisitions, and strategic alliances | |
| modelo de factores específicos | specific factors model | |
| barreras arancelarias / no arancelarias | tariff / nontariff barriers | *Nontariff* sin guion (Krugman-Obstfeld). |
| mercado de divisas; mercado de cambios | foreign exchange market | |
| operaciones (de divisas) | transactions | |
| régimen cambiario | exchange rate regime | |
| integración monetaria / económica | monetary / economic integration | |
| movimientos internacionales de factores | international factor movements | |
| movilidad de trabajadores | labor mobility | |
| inversión de cartera / directa | portfolio / direct investment | |
| coordinación internacional de políticas económicas | international coordination of economic policies | |
| foros internacionales | international forums | Plural americano (no *fora*). |
| ruptura / desaparición del sistema de Bretton Woods | breakdown / end of the Bretton Woods system | |
| prevención y solución de crisis | crisis prevention and resolution | |
| renta variable / renta fija | equity / fixed income (fixed-income instruments) | |
| análisis fundamental / técnico | fundamental / technical analysis | |
| teoría de la elección de cartera | portfolio choice theory | |
| teoría de valoración por arbitraje | arbitrage pricing theory (APT) | |
| rendimiento (de un bono) | yield (precio y rendimiento); return (riesgo y rendimiento) | **Ojo**: depende del par. |
| valoración (del riesgo y del rendimiento) | assessment | No *valuation*. |
| duración y convexidad | duration and convexity | |
| gestión de riesgos | risk management | |
| regulación bancaria y no bancaria | bank and nonbank (financial) regulation | |
| aproximación experimental | experimental approach | |
| deuda externa; ayuda al desarrollo | external debt; development aid | |
| Grupo del Banco Mundial; bancos regionales de desarrollo | World Bank Group; regional development banks | |
| modelos integrados de evaluación | integrated assessment models (IAMs) | |
| perspectivas económicas mundiales | global economic outlook | No *World Economic Outlook* (es la publicación del FMI). |
| áreas emergentes | emerging areas | |
| Acuerdos sobre el comercio de mercancías (OMC) | agreements on trade in goods | |
| procesos de integración no comunitarios | non-EU integration processes | «Comunitario» → *EU* (o *Community* si es antes de 2009). |
| orden jurídico (de la UE) | legal order | |
| presupuesto comunitario | EU budget | |
| política pesquera común | Common Fisheries Policy (CFP) | |
| libre circulación de mercancías, servicios, personas y capitales | free movement of goods, services, persons, and capital | |
| política de competencia | competition policy | |
| cohesión económica y social | economic and social cohesion | |
| relaciones económicas exteriores | external economic relations | |
| política de cooperación al desarrollo | development cooperation policy | |
| Sistema Monetario Europeo | European Monetary System (EMS) | |
| zona euro; Eurozona | euro area | Término del BCE; no *eurozone* en el texto. |
| Unión Bancaria: pilares y código normativo único | Banking Union: pillars and the single rulebook | |
| Unión de Mercados de Capitales | Capital Markets Union (CMU) | |
| gobernanza económica | economic governance | |
| Procedimiento de Desequilibrios Macroeconómicos | Macroeconomic Imbalance Procedure (MIP) | Singular, como la UE. |
| covid-19 | COVID-19 | |
| recursos humanos; estructura demográfica | human resources; demographic structure | |
| proyecciones de población | population projections | |
| sectores agrario y pesquero | agriculture and fisheries sectors | |
| sistema eléctrico / gasista; productos petrolíferos | electricity / gas system; petroleum products | |
| mitigación y adaptación | mitigation and adaptation | |
| vinculación con (la política de la UE) | relationship with | |
| I+D; I+D+i | R&D; research, development, and innovation (R&D&I) | |
| buenas prácticas internacionales | international good practice | Singular incontable, como la OCDE. |
| empresa industrial / de servicios | industrial firm / service firm | |
| clima de negocio | business climate | |
| sector público empresarial; empresa pública | public enterprise sector; public enterprise | *State-owned enterprise (SOE)* en prosa cuando se hable de la OCDE. |
| industria (sector) | industry; manufacturing | *Manufacturing* cuando se opone a servicios o en las clasificaciones. |
| contenido tecnológico | technological content | |
| industria agroalimentaria / automovilística / química y farmacéutica | agri-food / automotive / chemical and pharmaceutical industry | |
| política de vivienda y suelo | housing and land policy | |
| transportes | transportation | Americano (no *transport*), salvo nombres oficiales UE. |
| distribución comercial | distribution sector (wholesale and retail trade) | |
| comercio electrónico | e-commerce | |
| defensa / promoción de la competencia | competition enforcement / advocacy | |
| garantía de unidad de mercado | guarantee of market unity | Ley 20/2013: *Law on Guaranteeing Market Unity*. |
| políticas de empleo | employment policies | |
| entidades de crédito | credit institutions | |
| Programa de Asistencia Financiera (2012) | Financial Assistance Programme | Nombre oficial del MEDE (grafía británica). |
| mercados de valores | securities markets | |
| financiación no bancaria | nonbank financing | |
| posición frente al Eurosistema | position vis-à-vis the Eurosystem | |
| sostenibilidad externa | external sustainability | |
| balanza de bienes y servicios | goods and services account | MBP6. |
| indicadores de competitividad | competitiveness indicators | |
| inversión exterior; inversión en el exterior | investment abroad | |
| política de internacionalización | internationalization policy | |
| promoción comercial; organismos | trade promotion; bodies | |
| cooperación técnica y financiera | technical and financial cooperation | |
| Comunidades Europeas; adhesión | European Communities; accession | |
| constitución de la zona euro | creation of the euro area | |
| evolución | evolution (de una economía a lo largo de años); trends (de una magnitud); recent developments («evolución reciente» de un sistema) | |
| flujos presupuestarios / extrapresupuestarios; saldo financiero | budgetary / off-budget flows; net financial balance | |
| Marco Financiero Plurianual 2021-2027 | 2021–2027 Multiannual Financial Framework | Mayúsculas con el período (nombre propio); en minúscula el genérico. |
| delimitación (del sector público, SEC) | delimitation | Término del SEC 2010 y del MGDD. |
| operaciones (SEC) | transactions | |
| reglas de votación; democracia representativa | voting rules; representative democracy | |
| producción pública; burocracia | public production; bureaucracy | |
| límites normativos | legal limits | «Normativo» = de normas, no *normative*. |
| presupuesto como elemento de redistribución / compensador | budget as an instrument of redistribution / as a compensatory (stabilizing) instrument | |
| Estado de bienestar | welfare state | |
| componentes discrecionales y automáticos; esfuerzo fiscal | discretionary and automatic components; fiscal effort | |
| evaluación de políticas públicas; evaluación de impacto | public policy evaluation; impact evaluation | |
| análisis coste-eficacia | cost-effectiveness analysis | |
| elementos definidores (de los impuestos); clases de impuestos | defining elements; types of taxes | |
| principios impositivos | principles of taxation | |
| efecto incentivo | incentive effect | |
| compromiso entre eficiencia y equidad | efficiency-equity trade-off | |
| haciendas territoriales; Administraciones Territoriales | subnational governments (teoría); regional and local governments (España) | |
| competencias (de las Administraciones) | powers | |
| política de privatizaciones | privatization policy | |
| impuesto sobre la renta de no residentes | non-resident income tax | |
| convenios de doble imposición; modelo de la OCDE | double taxation conventions; OECD Model Tax Convention | |
| erosión de bases imponibles | base erosion | |
| imposición patrimonial | wealth taxation | IBI → *property tax* (§ 1.8). |
| principios presupuestarios; modificaciones presupuestarias | budgetary principles; budget amendments | |
| elaboración, aprobación, ejecución y control (del presupuesto) | preparation, approval, execution, and control | |
| clasificación por políticas de gasto | spending-policy classification | |
| visión consolidada | consolidated view | |
| en términos de contabilidad nacional | in national accounts terms | |
| gasto por funciones (COFOG) | expenditure by function | |
| subsectores de las Administraciones Públicas | general government subsectors | |
| Seguridad Social; sistema público de pensiones | Social Security; public pension system | |
| política de financiación del Tesoro | Treasury funding policy | |

---

## 3. Plan

### 3.1. Cómo se haría

1. **Antes de empezar** (una vez):
   - Decisiones de Víctor cerradas (16/10/2026, § 3.7) y títulos de los 146
     temas del 3.er y 4.º ejercicio traducidos en `temario-en.json`
     (pendiente de que Víctor los revise).
   - Se pasa el glosario a `canon/traduccion/glosario.tsv` (lo genera un
     script desde las tablas de § 2) para que el traductor y el verificador lo
     lean igual.
   - Se adaptan `tcee.sty`, `tikz-tcee.tex`, `pandoc-macros.tex` y `tcee.lua`
     (§ 3.4) y se cambian en los temas revisados los `\mathrm{CMg}` de
     fórmulas y gráficos por `\sigla{CMg}` (cambio mecánico; el PDF castellano
     sale igual).
   - Piloto con el **3.A.12** (el que más siglas y rótulos tiene): se traduce,
     se revisa entero y lo que salga se añade aquí antes de seguir.
2. **Por tema** (solo temas revisados, en el orden en que se revisan):
   - **Traducción** de la fuente LaTeX `fuentes/3A12/3A12.tex` →
     `fuentes/3A12/en/3A12.tex`, **apartado a apartado** (`\section` de primer
     nivel, unas 4-6 piezas por tema), con este LEEME, el glosario, la
     `notacion.md` y la ficha de cada modelo del tema en el contexto (fijo y
     cacheado). El modelo devuelve LaTeX con los mismos macros, etiquetas,
     `\label`, `\cite`, `\minutos` y gráficos; solo traduce texto, títulos,
     notas al pie y siglas.
   - **Comprobación automática** (verificar-tema.py en modo `en`, § 3.4):
     compila; mismas etiquetas, citas, gráficos, `\minutos` y número de
     fórmulas que el castellano; ninguna palabra castellana suelta; ninguna
     sigla castellana en fórmulas; términos prohibidos del glosario
     (*substitutive*, *dotation*, *theme*, *valuation*, *yields to scale*…);
     cifras: cada número del castellano aparece convertido (punto decimal,
     *billion*/*trillion*).
   - **Revisión por un segundo modelo** (lectura bilingüe apartado a
     apartado): sentido cambiado, omisiones, términos fuera del glosario,
     registro. Propone; no edita.
   - **Gráficos**: los mismos `.tex`, compilados en inglés (§ 3.3).
   - **Revisión de Víctor**: lectura del PDF inglés con el castellano al lado;
     las decisiones nuevas van al glosario. Para el libro, además, una
     corrección final de un nativo con formación económica (*copy-editing*),
     por bloques.
   - **Publicación** en `/en/` (§ 3.5).
   - La ficha de repaso **no se traduce** (decisión de Víctor, 16/10/2026):
     la página inglesa del tema la enlaza como «Review sheet (in Spanish)».
     El guion y el vídeo del cante tampoco se traducen por ahora.
3. **Mantenimiento**: `estado.json` de cada tema guarda, por apartado, la
   huella (hash) de la fuente castellana que se tradujo. Si el tema castellano
   cambia, se retraducen solo los apartados cuya huella ha cambiado y se
   revisa el diff.
4. **Libro**: una clase o plantilla `tcee-libro` que incluya los temas en
   inglés (o en castellano) como capítulos con `\include`, con numeración de
   páginas continua (la 1…N, A-n, B-n de cada tema pasa a numeración del
   libro y los anexos quedan al final de cada capítulo), **bibliografía por
   capítulo** como en los temas (decisión de Víctor, 16/10/2026: un
   `refsection` por tema y su `\printbibliography` al final del capítulo,
   tras los anexos, con el título *References*; sin bibliografía común), la
   nota de notación (§ 1.7)
   y la `notacion.md` como apéndice de notación, y este glosario como apéndice
   bilingüe (útil para el lector). Se hace cuando haya un bloque entero
   revisado (CRITERIOS.md ya prevé manuales por bloques con las fichas).

### 3.2. Fuente y maquetación

- Una fuente por idioma: `fuentes/<tema>/<tema>.tex` (castellano, sale de
  LyX) y `fuentes/<tema>/en/<tema>.tex` (inglés, LaTeX directo; si Víctor
  quiere editarla en LyX, `tex2lyx`). El `.bib`, los `datos/` y los
  `graficos/*.tex` son **comunes**.
- Misma maquetación: el inglés usa `tcee.sty` con la opción de idioma
  (`\usepackage[english]{tcee}`) y todo lo demás (colores, bandas, cajas,
  `\funcionclave`, `\optim`, numeración de páginas, viudas y huérfanas)
  igual. El inglés suele ocupar un 5-10 % menos que el castellano: el número
  de páginas puede bajar.

### 3.3. Gráficos TikZ con rótulos en dos idiomas

Los 116 gráficos de los cinco temas revisados tienen unos 300 rótulos de
texto en castellano («por separado», «juntos», «economías de alcance») y
siglas en las fórmulas de los rótulos (`$\mathrm{CMg}$`). Se parametrizan en
el mismo `.tex`, sin duplicar ficheros:

- En `latex/tikz-tcee.tex`:

  ```latex
  \providecommand{\tceeidioma}{es}
  % \tr{castellano}{inglés}: rótulo según el idioma de compilación
  \newcommand{\tr}[2]{\ifnum\pdfstrcmp{\tceeidioma}{en}=0 #2\else #1\fi}
  % \sigla{CMg}: sigla en redonda en el idioma de compilación (tabla § 1.8)
  \newcommand{\sigla}[1]{\mathrm{\ifcsname tcee@sg@\tceeidioma @#1\endcsname
      \csname tcee@sg@\tceeidioma @#1\endcsname\else #1\fi}}
  \expandafter\def\csname tcee@sg@en@CMg\endcsname{MC}
  \expandafter\def\csname tcee@sg@en@CMe\endcsname{AC}
  % … una línea por sigla de § 1.8 (la genera un script desde el glosario)
  ```

  y lo mismo en `tcee.sty` (para las fórmulas del texto) y en
  `pandoc-macros.tex` (para la web y el Word).
- En cada gráfico, los rótulos pasan a `{\tr{por separado}{separately}}` y
  las siglas a `$\sigla{CMg}$`. Es un cambio mecánico que puede hacer el
  traductor con el glosario; las capas (`\capa`), la geometría y los colores
  no se tocan. Si un rótulo inglés es más largo y se sale, se ajusta su
  `anchor` dentro de `\tr` o se parte con `\\`.
- `construir-tema.py --idioma en` compila cada gráfico con
  `\def\tceeidioma{en}\input{nombre.tex}` y `-jobname`, y deja PDF, SVG y PNG
  en `graficos/en/`; el `\graphicspath` del tema inglés apunta ahí.
- Los rótulos de ejes que son símbolos (`$q_2$`, `$C$`) no cambian.

### 3.4. Cambios en los scripts y plantillas

`scripts/temario/comun.py`
- `Tema(codigo, idioma='es')`: con `en`, `tex` = `fuentes/<t>/en/<t>.tex`,
  `graficos_salida` = `graficos/en/`, `trabajo` = `_trabajo/en/`, título desde
  `temario-en.json`, salida publicada en `en/topics/`.

`scripts/temario/construir-tema.py`
- Opción `--idioma en`; sin `sincronizar_lyx` ni `exportar_latex` (no hay
  LyX).
- `compilar_graficos`: compila con `\tceeidioma{en}` a `graficos/en/`.
- `comunes_pandoc`: `-M lang=en-US`, `reference-section-title=References`;
  `tcee.csl` ya trae `<locale xml:lang="en">`, pero hay que comprobar que los
  términos («accessed», «and») salen en inglés con `lang=en-US`.
- `datos_seo`: lee `seo.en.json` (título y descripción en inglés).
- Plantillas: `plantilla-tema.html` tiene los textos de la página en
  castellano («Descargar PDF», «Descargar Word», `lang="es"`, menú): o una
  `plantilla-tema-en.html`, o variables de pandoc para cada texto
  (recomendado: variables, una sola plantilla). Añadir
  `<link rel="alternate" hreflang="es|en|x-default">` en las dos versiones.
- `reference.docx`: idioma de corrección del Word a inglés (EE. UU.)
  (`crear-reference-docx.py` con un parámetro).
- `numerar_anexos` y `retocar_docx`: «Anexo» → «Appendix», «Bibliografía» →
  «References».

`latex/tcee.sty`
- Opción `english`: `babel` con `american` en lugar de
  `spanish,es-noshorthands,es-tabla,es-nodecimaldot`; sin coma decimal; los
  textos fijos por macro (`\tcee@txt@fuente` «Fuente»/«Source», «Anexos»,
  «Bibliografía», «Tema», «págs.», «Gráfico», «Tabla», «Nota al opositor»,
  «s.a.»); `\vertema` → «[see topic …]»; `urldate` → «(accessed …)»;
  `\tceeidioma` para `\tr` y `\sigla`.

`latex/tcee.lua` y `latex/pandoc-macros.tex`
- `tcee.lua` busca el texto «Fuente:» y pone «Gráfico n.–» y «Tabla n.–»:
  leer `lang` de los metadatos y usar «Source:», «Figure n.», «Table n.».
  `\vertema` y `\fuente` de `pandoc-macros.tex`, según el idioma (una
  `pandoc-macros-en.tex` o un condicional). Minutos: sin cambio.

`scripts/temario/verificar-tema.py`
- Modo `en`: las comprobaciones de estructura y minutos igual; las de estilo
  castellano (comillas «», «se estudió en», minutos con decimales) en su
  versión inglesa; y las nuevas de § 3.1 (paridad de etiquetas, citas,
  gráficos y fórmulas con el castellano; restos de castellano; siglas;
  términos prohibidos; cifras).

`scripts/temario/publicar-tema.py`
- Con `--idioma en`: no toca `oposicion/temario/<ejercicio>.html`; añade la
  línea del tema a la portada inglesa `en/topics/index.html` (título de
  `temario-en.json`, botones PDF, DOCX y, cuando exista, «REVIEW SHEET (ES)»,
  que enlaza la ficha castellana: las fichas no se traducen); copia
  a `en/topics/` el HTML, PDF, DOCX y los gráficos.
- `build-app-data.js`: añadir `urlHtmlEn`/`urlEn` al tema en `temario.json`
  (la app puede ofrecer el enlace; no se traduce la app).
- `generate-sitemap.js`: incluir `/en/` con alternativas `hreflang`.
- `build-search-index.js`: **buscador también en inglés** (decisión de
  Víctor, 16/10/2026). Genera un segundo índice, `en/search-index.json`, con
  los títulos de `temario-en.json` (los 146, desde ya, para encontrar el
  tema aunque solo exista en castellano: el resultado lleva «(in Spanish)» y
  enlaza a la versión castellana) y el texto de los temas traducidos en
  `en/topics/`. `search-ui.js` elige el índice según `<html lang>` (o la ruta
  `/en/`) y traduce sus textos fijos (placeholder, «Sin resultados», atajo
  Ctrl/Cmd+K). `search-engine.js` no cambia (la búsqueda difusa no depende
  del idioma; quitar tildes sigue valiendo). Las páginas de `/en/` cargan
  los mismos scripts, en el mismo orden que el resto del sitio.

Nuevo: `scripts/temario/traducir-tema.py`
- Trocea la fuente por `\section`, monta el contexto fijo (este LEEME,
  `glosario.tsv`, `notacion.md`, fichas de los modelos del tema), llama a la
  API por lotes (Message Batches, 50 % más barato; sin prisa), reensambla
  `en/<tema>.tex`, traduce los rótulos `\tr{…}{…}` de los gráficos y guarda las
  huellas en `estado.json`. Encaja como fase opcional de `/revisartema`
  (`--fase traduccion`) con un agente `tema-traductor`.

### 3.5. Publicación en /en/

- Rutas: `/en/` (portada inglesa breve: qué es la oposición TCEE y qué hay en
  inglés), `/en/topics/` (índice de temas traducidos por ejercicio y bloque) y
  `/en/topics/3A12.html` (+ `.pdf`, `.docx`). **Decidido** (Víctor,
  16/10/2026): la web inglesa va en **/en/**, con el buscador en inglés
  (§ 3.4, `build-search-index.js`). La página de cada tema traducido enlaza la
  ficha de repaso castellana.
- Navegación: la página castellana de un tema traducido enseña «English
  version»; la inglesa, «Versión en castellano». Las páginas generales del
  sitio (inicio, comunidad, cookies) no se traducen por ahora; la inglesa
  enlaza a ellas en castellano.
- Las dos versiones llevan `hreflang`; la inglesa, `og:locale` `en_US` y su
  JSON-LD con `inLanguage: "en"` y `translationOfWork` apuntando a la
  castellana.

### 3.6. Coste aproximado por tema

Volumen de un tema revisado: 15.000-21.000 palabras de fuente LaTeX
(120-180 KB; unos 40.000-60.000 tokens) y 13-32 gráficos (30-100 KB de
TikZ, unos 20-110 rótulos).

| Paso | Tokens (aprox.) | Coste API |
|---|---|---|
| Traducción (Claude Opus 5.5, 4 $/MTok de entrada, 20 $/MTok de salida): contexto fijo de ~25.000 tokens cacheado y reutilizado en 5 piezas, fuente ~55.000, salida ~55.000 más razonamiento | ~110.000 entrada, ~90.000 salida | ~2,3 $ |
| Rótulos de gráficos | ~30.000 entrada, ~10.000 salida | ~0,3 $ |
| Revisión bilingüe por un segundo modelo | ~130.000 entrada, ~15.000 salida | ~0,8 $ |
| Repeticiones y correcciones (margen) | | ~0,6 $ |
| **Total por tema** | | **~4 $** (unos 2 $ con la API de lotes) |

- Los 146 temas del 3.er y 4.º ejercicio: **~600 $** (unos 300 $ por lotes).
  Precios de lista de la API a octubre de 2026; si se hace dentro de Claude
  Code con la suscripción, el coste es el de la suscripción y el tiempo.
- El coste real es **la revisión**: unas **2-3 horas de Víctor por tema**
  (leer 18-25 páginas en inglés con el castellano al lado y resolver lo que
  marque el verificador; el piloto lo medirá), más 1 hora de reconstrucción y
  publicación. Para el libro, la corrección por un nativo economista es aparte
  (presupuesto por palabra a pedir; unas 20.000 palabras por tema).

### 3.7. Decisiones de Víctor (16/10/2026)

1. **Inglés americano** (§ 1.1), con la grafía oficial británica solo en los
   nombres propios de la UE, el Reino Unido y organismos internacionales.
2. La oposición: **«High Corps of Spanish State Economists and Trade
   Experts»** (TCEE); el Ministerio: **«Ministry of Economy, Trade and
   Enterprise»**. Nombres que da Víctor; se usan tal cual (§ 1.2, § 1.3,
   § 2.12).
3. **Títulos traducidos ya**: los 146 del 3.er y 4.º ejercicio en
   `oposicion/temario/temario-en.json` (§ 1.2), fieles frase a frase, con el
   glosario y los términos nuevos en § 2.13. Falta la revisión de Víctor.
4. **Web en /en/ con el buscador también en inglés** (§ 3.4 y § 3.5):
   `en/search-index.json` con los títulos ingleses desde que se publique
   `/en/`, y el texto de cada tema según se traduzca.
5. **Bibliografía del libro por capítulo**, como en los temas (§ 3.1, punto
   4).
6. **Fichas de repaso solo en español**: no se traducen (§ 1.3, § 3.1).
