# Revisión del 3.B.39 — El mercado único de la UE. Libre circulación de mercancías, servicios, personas y capitales. La política de competencia

Revisión completa del 14/11/2026 (entrega 1: tema y ficha de repaso; sin vídeo), en el worktree `revision-temario-2`, en paralelo con los agentes de los 3.B.37 y 3.B.38. Fuente nueva en LaTeX (`3B39.tex`) a partir del Word original (`_trabajo/original.md`, el antiguo 3.B.40 de agosto de 2023), **redactada de nuevo** y puesta al día a noviembre de 2026 con fuentes oficiales (EUR-Lex, Comisión, DG Competencia, Eurostat, Consejo, TJUE, FMI). Las dudas se resuelven con la opción recomendada y se anotan como B39-NN (14/11/2026).

## 1. Resumen

- 3 bloques: **I. El mercado único** (I.1 fundamentos jurídicos; I.2 de Roma a la estrategia de 2025; I.3 efectos económicos), **II. Las 4 libertades** (II.1 bienes; II.2 servicios; II.3 personas; II.4 capitales) y **III. La política de competencia** (III.1 motivación; III.2 los 4 pilares; III.3 promoción, coordinación y debate). Reparto: introducción 2′30″, I 7′, II 9′, III 10′, conclusión 1′30″. El bloque «Mercado interior» del original se parte en I y II (se conservan sus títulos de segundo nivel) y sus «Otras cuestiones» vacías (fiscalidad, contratación pública) se integran en II.1 y II.4 (B39-01).
- 4 modelos con la estructura rígida a)-e): **integración de mercados oligopolísticos** (Cournot con libre entrada; resultado clave `eq:margen-tamano`, p* − c = √(CF/S)), **coste del cártel y multa disuasoria** (`eq:multa-disuasoria`, M ≥ ΔB/π), **compromiso de Williamson** (`eq:williamson`) y **carrera de subvenciones** (dilema del prisionero entre Estados, tabla).
- 9 gráficos y figuras propios: 3 teóricos (mercado integrado, coste del cártel, Williamson), 4 de datos (comercio intra-UE 2002-2025, multas por cártel 1990-2025, concentraciones notificadas 1991-2025, ayudas de Estado 2000-2024 y por Estado en 2024) y 2 figuras (línea de tiempo; pilares de la competencia). Sustituyen a las imágenes del Word (FT, Wikipedia, logo de la ALE, capturas). 2 tablas (las 4 libertades; matriz de subvenciones).
- PDF: 34 páginas de tema, 1 de anexos y 6 de bibliografía (41). Ficha de repaso de 4 páginas a 10,5 pt (última, 81 %). `verificar-tema.py` (envoltorio sobre `_trabajo/`): sin errores propios (las 9 «imágenes inexistentes en el HTML» son un efecto de verificar en `_trabajo/`, con rutas relativas, como en el 3.B.36; avisos de «cifra sin cita» en párrafos cuya fuente es el propio acto jurídico citado y los del vídeo).

## 2. Errores corregidos

| Id | Dónde (Word) | Decía | Dice ahora |
|---|---|---|---|
| E1 | Introducción | La integración «tiene su origen en el Tratado de Roma en 1957» | En el Tratado de París (1951); el mercado común, en Roma (coherente con el 3.B.36) |
| E2 | Introducción | UEM «para 20» | 21 desde 2026 (no se repite en este tema: remisión al 3.B.36) |
| E3 | Libro Blanco | Libre circulación «de mercancías, personas y capitales» | Las 4 libertades; unas 280 medidas contra barreras físicas, técnicas y fiscales |
| E4 | Derecho derivado de bienes | «Reglamento de reconocimiento mutuo (2008)» y propuesta de 2017 «todavía en discusión» | Reglamento (UE) 2019/515, aplicable desde el 19/4/2020 |
| E5 | Comercio electrónico | «Reglamentos (2016)»: acuerdo del Consejo sobre el geobloqueo | Reglamento (UE) 2018/302, aplicable desde el 3/12/2018 |
| E6 | Instrumentos | «Programa Customs vigente desde 2014» | Programa Aduana 2021-2027 (Reglamento (UE) 2021/444) y nuevo Código Aduanero (Reglamento (UE) 2026/2108) |
| E7 | Barreras fiscales | «La fiscalidad sigue siendo competencia exclusiva de los Estados» | No es una competencia exclusiva en el sentido del art. 3 TFUE: los Estados conservan su soberanía fiscal y la armonización indirecta exige unanimidad (art. 113) |
| E8 | Nota 11 (tipos de IVA) | «1 o 2 tipos reducidos (uno no inferior al 5 %)» | Directiva (UE) 2022/542: general ≥ 15 %, hasta 2 reducidos ≥ 5 %, uno < 5 % y tipo cero para una lista limitada |
| E9 | Impuestos especiales | Directiva de 1992 como vigente | Directiva (UE) 2020/262, aplicable desde el 13/2/2023 |
| E10 | Contratos públicos | «En torno al 16 % del PIB» | 2,6 billones de euros, el 15 % del PIB (Comisión) |
| E11 | Servicios, excepciones | Sujetas al «artículo 36 del TFUE» | Arts. 51 (poder público) y 52 (orden, seguridad y salud públicos), aplicables a los servicios por el art. 62; el 36 es de mercancías |
| E12 | Nota 24 | Directiva Bolkestein transpuesta por la «Ley 12/2009 (Ley Paraguas)» | Ley 17/2009 (paraguas) y Ley 25/2009 (ómnibus) |
| E13 | Bolkestein | Se fija «el principio del país de origen» | El principio del país de origen de la propuesta de 2004 se suprimió; queda la libertad de prestación con excepciones |
| E14 | Desplazamiento | «La duración máxima del trabajo será de 1 año, prorrogable 6 meses» | No hay duración máxima: a partir de 12 meses (18 con notificación) se aplica casi todo el Derecho laboral de acogida; misma remuneración |
| E15 | Schengen | «23 Estados miembros»; Bulgaria, Chipre y Rumanía «asociados» | 29 miembros: 25 de la UE (Bulgaria y Rumanía, de pleno derecho desde el 1/1/2025) + 4 de la AELC; fuera Irlanda y Chipre |
| E16 | Nota 39 (Gibraltar) | Acuerdo que «debe materializarse en un tratado antes de 6 meses» (2020) | Acuerdo firmado el 14/7/2026, aplicado provisionalmente desde el 15/7/2026; falta la aprobación del PE |
| E17 | Directiva 88/361 | Restricciones transitorias en «España, Irlanda y Portugal» | También Grecia; hasta finales de 1992, prorrogable para Grecia y Portugal |
| E18 | Capitales, retos | «Timmermans propone un tipo mínimo del 18 %» | Sin fuente; se sustituye por la Directiva (UE) 2022/2523 (pilar 2, mínimo del 15 %, desde 2024) y BEFIT (2023, sin acuerdo) |
| E19 | Capitales, valoración | «Stock intra-UE de IED del 63 % del PIB» y «los bancos realizan el 85 % de sus préstamos en su propia moneda» | Cifras sin fuente y sin sentido claro: se quitan; queda la valoración cualitativa |
| E20 | Art. 101 | Excepciones: incluye «acuerdos con finalidad medioambiental» y «cuota menor del 10 %» como excepciones del art. 101 | Las 4 condiciones acumulativas del 101.3; los acuerdos de menor importancia (comunicación *de minimis*) y los de sostenibilidad (directrices horizontales de 2023) van aparte |
| E21 | Abuso | Dominio si la cuota «es superior al 40 %» | Presunción por encima del 50 % (jurisprudencia) y poco probable por debajo del 40 % (directrices de 3/9/2026) |
| E22 | Abuso | Google, «en 2018, multa de 4.125 millones» | La decisión de 2018 fue de 4.343 M€; el Tribunal General la rebajó a 4.125 (2022) y el TJ la confirmó el 2/7/2026 |
| E23 | Concentraciones | Fase I «en el plazo de un mes» | 25 días hábiles; fase II, 90 días hábiles |
| E24 | Siemens/Alstom | «No prohibió la fusión… la autorizó en todos sus ámbitos salvo la alta velocidad» | La Comisión la **prohibió** (6/2/2019) por sus efectos en la señalización ferroviaria y en los trenes de muy alta velocidad |
| E25 | Conclusión | «Multas por valor de 30.000 millones desde 1990, abriéndose casi 900 expedientes» | Cárteles: 30.593 M€ ajustados en 162 decisiones (1990-2025) |
| E26 | Conclusión | «El mercado único europeo es el mayor del mundo» | Se describe con cifras (450 millones de consumidores, 18 billones de PIB) sin el superlativo |
| E27 | Conclusión | «2,7 millones de empleos y 2,13 % del PIB» (2013) | Comisión (2025): al menos 3-4 % del PIB y 3,6 millones de empleos |
| E28 | Personas | «Los trabajadores migrantes de la UE suponen el 4 % del empleo»; «11,8 millones en 2016» | 14 millones viven o trabajan en otro Estado, 1,9 millones de fronterizos y 3,6 millones de desplazados (Comisión, 2026) |
| E29 | ALE | «No se espera que esté totalmente operacional hasta 2024» | Inició su actividad en octubre de 2019; reforma del mandato propuesta el 15/9/2026 |
| E30 | Personas | «La movilidad laboral es 3 veces más baja que en EE. UU.» | Sin fuente comprobada: se dice «mucho menor» (B39-07) |

## 3. Marcas resueltas

| Marca | Texto original | Qué se ha hecho |
|---|---|---|
| Notas al opositor (l. 1-14) | Aviso del cambio de temario de 2023 y capturas | Desaparecen (aviso de trabajo) |
| Comentarios sobre el tema de ICEX-CECO y de un preparador | — | No se publican; ningún preparador se nombra |
| Amarillo «Tras 30 años de mercado único… … millones de puestos de trabajo y … % del PIB» | Hueco | Resuelto con la estimación de la Comisión (2025): al menos 3-4 % del PIB y 3,6 millones de empleos, y el rango académico (in 't Veld, Mayer et al.) |
| Amarillo «Se excluyen las barreras fiscales…» | Nota de trabajo | Se integran las barreras fiscales en II.1 como armonización de la imposición indirecta (tema de referencia según el canon, D074) |
| Amarillo «DMA y DSA» con enlace | Esbozo | Escrito: DSA en II.2 y DMA en III.2 (guardianes de acceso, multas) |
| Amarillo «Efectos de los movimientos de capitales» (Gopinath et al., 2017) | Línea suelta en personas | Pasa a la valoración de capitales (II.4), con la cita correcta (QJE, 2017) |
| Amarillo «paradoja de Feldstein y Horioka» | 4 párrafos | Caja gris en II.4, con remisión al 3.B.12 |
| Nota al opositor «tema del 4.º ejercicio (4.B.18)» | — | Remisiones a 4.B.18 y 4.B.20 |
| Nota al opositor «tema 4.A.15» | — | Remisiones a 4.A.15 |
| Nota al opositor «Ver tema de ICEX-CECO (pág. 23)» | — | Desaparece; la fiscalidad está en II.1 y II.4 |
| «Relevancia» vacía (intro, barreras físicas, personas) y conclusión con bloques vacíos | — | Escritas |
| Apartados vacíos «Contratación pública» y «Derecho societario y propiedad intelectual» | — | Contratación pública en II.1; Derecho de sociedades con el 28.º régimen (EU Inc.) en I.2 (B39-01) |
| Imagen 1 (FT, 4 libertades) | Captura | Tabla 1 de las 4 libertades |
| Imagen 2 (mapa de Schengen, Wikipedia) | Captura | Texto con los 29 miembros y nota |
| Logo de la ALE, «curva de la sonrisa» (imagen), anexo «30 años de mercado único» (infografía del PE) | Imágenes | Se quitan; la curva de la sonrisa queda en nota con remisión al 3.B.34; las cifras del anexo, actualizadas en el texto |
| Enlaces del original (Comisión, PE, EBA, Consejo, FT, The Economist, Funcas, Card, Gopinath) | — | Las fuentes oficiales y académicas se citan en el .bib; los de prensa no se conservan (artículos de opinión de 2017 y 2019 sin datos que se usen) (B39-08) |
| Bibliografía del Word | Temas de ICEX-CECO, Cordero, Sahuquillo; Camarero et al. | Los temas de preparadores no se citan; se citan los Tratados, la normativa, Cecchini, Muns (ed.), Monti, Letta, Draghi, FMI y artículos académicos |

## 4. Datos actualizados

Todos consultados el 14/11/2026.

| Dato | Antes | Ahora | Fuente | Segunda comprobación |
|---|---|---|---|---|
| Comercio intra-UE de bienes | «22 %» (importaciones) | 21,8 % del PIB en 2025 (media X+M); servicios 8,0 % | Eurostat (ext_lt_intratrd, bop_its6_det, nama_10_gdp) | Informe anual del mercado único 2026: el indicador empeora |
| Efectos del mercado único | 2,7 M empleos y 2,13 % (2013) | ≥ 3-4 % del PIB, 3,6 M empleos | IP/25/1274 y ficha de la estrategia | in 't Veld (2019) ≈ 9 %; Mayer et al. (2019) 4,4 % |
| Barreras intra-UE | — | 44 % (manufacturas) y 110 % (servicios), 2020; productividad +7 % | FMI, REO Europa oct. 2024, nota 1, recuadro 1.2 | Discurso de Kammer (14/11/2024) |
| Cecchini | 4-5 % PIB, −6,1 %, 1,8 M empleos | 4,5 %, −6,1 %, 1,8 M, +2,2 pp, +1 pp, ±30 % | SEC (88) 524 (copia del disco D:) | *European Economy* 35 |
| Multas por cártel | 30.000 M€ | 30.593 M€ (1990-2025), 162 decisiones; 2025: 859,5 M€ en 4 | DG COMP, *Cartel statistics* | Notas de prensa de 2025 (vía prensa) |
| Concentraciones | — | 10.200 notificaciones, 311 fases II, 33 prohibiciones | DG COMP, *Merger statistics* (31/10/2026) | Informe de competencia (agente) |
| Ayudas de Estado | — | 168.230 M€, 0,94 % del PIB (2024); España 0,99 % | State aid Scoreboard 2025 | Texto del informe (0,94 y 0,85 sin crisis) |
| DMA | — | 7 guardianes, 23 servicios; Apple 500, Meta 200, Google 890 M€ | digital-markets-act.ec.europa.eu | Informe de revisión COM(2026) 178 |
| DSA | — | 25 VLOP y 3 VLOSE; multas X 120, Temu 200, AliExpress 550 M€ | digital-strategy.ec.europa.eu | — |
| Schengen | 23 | 29; controles en 7 Estados de la UE y Noruega | home-affairs.ec.europa.eu | Consejo (BG y RO, 2024) |
| Movilidad | 11,8 M (2016) | 14 M; 1,9 M fronterizos; 3,6 M desplazados | COM(2026) 970 | Informe A1 (3,6 M por el art. 12) |
| Control de IED | 2019/452 | Reglamento (UE) 2026/1386 (en vigor 16/7/2026; aplicable 17/1/2028) | Comisión (DG TRADE) y EUR-Lex | — |
| Contratación pública | 16 % | 15 % del PIB, 2,6 billones | single-market-economy.ec.europa.eu | — |

## 5. Contenido añadido

- **Historia completa** de Roma a 2026 (I.2), con línea de tiempo: estancamiento, Libro Blanco, Acta Única, Cecchini (cifras del comunicado original), Monti, Letta, Draghi, IMERA, estrategia de 2025 con los «Terrible Ten», hoja de ruta «Una Europa, un mercado» y EU Inc.
- **Modelo del mercado integrado** (I.3) y evidencia (Badinger, in 't Veld, Mayer et al., FMI).
- **Jurisprudencia de bienes** (Dassonville, Cassis, Keck, fresas españolas), nuevo enfoque y NLF, IVA (ViDA), aduanas (reforma de 2026 y fin de la franquicia de 150 €).
- **Servicios**: jurisprudencia, Bolkestein bien contada, cualificaciones, DSA.
- **Personas**: ciudadanía, Directiva 2004/38, Schengen al día, desplazamiento corregido.
- **Capitales**: arts. 63-66 completos, acciones de oro, control de IED (2026), UAI en mención, imposición directa (pilar 2, BEFIT).
- **Competencia**: tradiciones (Harvard, Chicago, ordoliberalismo), art. 101.3, exenciones, Reglamento 1/2003, clemencia y transacción; **modelo del cártel**; art. 102 con las directrices de 2026 y casos; DMA; umbrales y procedimiento de concentraciones, *Illumina*; **Williamson**; ayudas de Estado (criterios, RGEC, *de minimis*, marcos de crisis, CISAF, IPCEI); **carrera de subvenciones**; Reglamento de subvenciones extranjeras; industrias de red (de la parte de mercado interior de transporte y energía del antiguo 3.B.42); debate de los campeones europeos.
- **Nobel**: Tinbergen (1969), Krugman (2008), Card (2021), Stigler (1982), Tirole (2014), Becker (1992), Williamson (2009), con motivo oficial.
- **Material del disco D: usado**: «Mis temas\Tema 3.B.40 - v.2 - 2024.docx» (comparado palabra a palabra con el Word de partida: idéntico salvo remisiones y marcas, 94 tokens distintos); «Temas a imprimir\11. Unión Europea\Tema 3.B.42 - v.2023.pdf» (esbozo de mercado interior de transporte y energía: solo títulos; usado para III.3); «Informe Cecchini 1988 - Los costes de la no-Europa.pdf» (comunicado SEC (88) 524, citado; de él salen las cifras y el dato de las 20 frente a 4 empresas del enganche); «Lecturas de integración económica.pdf» (Muns, ed., 2005; citado). No se usaron los temas de otros preparadores ni el informe Letta del D: (falta, se leyó el oficial).

## 6. Coherencia

- **Canon**: propuestas en `_trabajo/canon-pendiente.md` (fichas nuevas `mercado-integrado`, `multa-disuasoria`, `williamson-tradeoff`; S local; `armonizacion-fiscal-ue` desarrollada aquí; UMC en mención con remisión al 3.B.44, según D073 y D074).
- **3.B.10**: no se repite Brander-Krugman ni Corden; se remite. Cecchini compatible. **3.B.36**: Libro Blanco (280 medidas), Cassis, competencias (arts. 3 y 4), coincidentes. **3.A.15/3.A.17/3.A.19/3.A.20**: DMA (7 y 23), Google Android (TJ 2026), Harberger, clemencia y SSNIP coherentes; se remite sin repetir la estabilidad del cártel. **3.B.15**: art. 63 y controles de capitales coherentes.
- **4.º ejercicio**: \vertema{4.A.15} (competencia en España), 4.A.22, 4.A.5, 4.A.6, 4.A.12, 4.B.15, 4.B.18, 4.B.20.

## Reglas de las tandas 8.ª y 9.ª y transversal (aplicadas, 14/11/2026)

| Regla | Cómo se ha aplicado |
|---|---|
| Estructura rígida de modelo | 4 modelos con a) Idea, b) Modelo (i-iii), c) Extensiones, d) Evidencia, e) Valoración |
| Sin citas Harvard | Solo `\nocite` y `\textcite` de obras originales |
| Nunca citar a Víctor | Ninguna entrada suya; gráficos «elaboración propia» |
| Ni «Pegatina» ni «Dicho» | Un solo refrán, el del enganche («El pez grande se come al chico», no usado en otro tema), retomado en la idea final |
| Nobel con motivo oficial | 8 laureados en su primera mención |
| Resultados clave en morado | `eq:margen-tamano`, `eq:multa-disuasoria`, `eq:williamson` |
| Pasos con sangría | Pasos en sublistas |
| Cajas grises | Notación; Feldstein-Horioka |
| Ejemplos sin nombres propios | Estados 1 y 2; países de tamaño S |
| Inglés entre paréntesis | *Terrible Ten*, *trade deflection*, *home bias*, *dumping* |
| Anexo de test | Caja estándar con `tema=3.B.39` |

## 7. Dudas abiertas

Todas aplicadas con la opción recomendada (14/11/2026).

- **B39-01** Estructura: el original tenía 2 bloques (mercado interior; competencia) y unas «Otras cuestiones» vacías. Se parte el primero en I (mercado único) y II (4 libertades) con sus títulos de segundo nivel, y fiscalidad y contratación pública se integran en II.1 y II.4. Opciones: (a) así **[aplicada]**; (b) 2 bloques como el original, con I muy largo.
- **B39-02** Refrán del enganche: «El pez grande se come al chico» (no usado en otro tema; «Hecha la ley…» está en el 3.B.33, «Juntos pero no revueltos» en 3.B.4, 3.B.35 y 3.A.40, «Allá donde fueres» en 3.B.31). Opciones: (a) mantenerlo **[aplicada]**; (b) otro.
- **B39-03** Modelo del mercado integrado: versión propia simplificada (Cournot con libre entrada, mercados segmentados frente a integrado) inspirada en Smith y Venables (1988), cuyo texto completo no se pudo leer (de pago). Opciones: (a) así, citándolos como inspiración **[aplicada]**; (b) contar solo de palabra sus simulaciones.
- **B39-04** Probabilidad de detección: Combe, Monnier y Legal (2008) (12,9-13,3 %, cota superior); el ejemplo π = 1/6 es ilustrativo. Ninguna acción.
- **B39-05** Asimetría de las ayudas de los marcos temporales (Alemania ≈ 49 % y Francia ≈ 23 % de lo aprobado): no se encontró en fuente oficial; el tema solo dice «buena parte se concentró en Alemania y Francia». Opciones: (a) así **[aplicada]**; (b) dar cifras cuando se localice la fuente oficial.
- **B39-06** Decisiones de cárteles de 2025 (reciclaje de vehículos 458 M€; Delivery Hero/Glovo 329 M€): cifras de prensa coherentes con el total oficial (859,5 M€). Ninguna acción.
- **B39-07** «Movilidad mucho menor que en EE. UU.» sin cifra (el original decía «3 veces»): no se encontró fuente oficial reciente. Opciones: (a) cualitativo **[aplicada]**; (b) buscar una estimación (OCDE, Comisión).
- **B39-08** Enlaces de prensa del original (FT 2017, The Economist 2019): no se conservan porque eran opinión sin datos que se usen. Opciones: (a) quitarlos **[aplicada]**; (b) conservarlos en una caja de lecturas.
- **B39-09** Eventos de 2026 solo comprobados en prensa: votación del PE sobre la e-declaración (20/10/2026), aplazamiento de la revisión del Reglamento 1/2003 a 2027, fase II UPM/Sappi; el tema solo da lo oficial (no hay propuesta). Ninguna acción.
- **B39-10** El Reglamento de inversiones extranjeras 2026/1386: la página de la Comisión da 2 fechas de entrada en vigor (17/6 y 16/7/2026); se usa julio de 2026. Comprobar en EUR-Lex.
- **B39-11** Las multas por cártel se publican ya solo por quinquenios hasta 2020: el gráfico usa quinquenios más 2025. Opciones: (a) así **[aplicada]**; (b) serie anual de otra fuente (no oficial).

## 8. Instrucciones para el vídeo

- **Enganche e idea final**: «El pez grande se come al chico»; Cecchini (20 empresas eficientes en el mercado comunitario frente a 4 en el nacional) y Draghi (empresas europeas pequeñas). Idea final: el mercado agranda el estanque, la competencia vigila que se crezca por ser mejor; hay que quitar las redes que lo parten.
- **Introducción y conclusión, sin pizarra** (`modo: guion`).
- **I.1-I.2**: de palabra; `linea-tiempo` como apoyo; la tabla de las 4 libertades como apoyo.
- **I.1** (antes I.3; 19/11/2026): la idea de palabra y la función clave `eq:margen-tamano` recuadrada, que se conserva todo el bloque I y se recupera en III.1; `mercado-integrado` (ahora en el anexo A) como apoyo; `comercio-intra-ue` como apoyo.
- **I.2**: el art. 26 leído y la figura `base-juridica` por capas (art. 26; competencias; art. 114; exclusiones; libertades).
- **II, al final**: `sintesis-libertades` por capas (una columna por libertad) como recapitulación; `mapa-schengen` solo como apoyo.
- **II**: casi todo de palabra, con el mismo patrón en cada libertad; en bienes se escriben en la pizarra solo los 3 nombres (Dassonville, Cassis, Keck) con su año.
- **III.2**: `pilares-competencia` como apoyo; desde el 19/11/2026 el cártel, la clemencia, Williamson y la carrera de subvenciones se cuentan de palabra y sus gráficos y ecuaciones están en cajas grises: en la pizarra, si da tiempo, `eq:multa-disuasoria`, la condición de la colusión con clemencia (`eq:colusion-clemencia`, flechas: baja B^C, sube B^D) y `eq:williamson`; `cartel-bienestar`, `williamson`, `multas-carteles`, `concentraciones` y `ayudas-estado` como apoyo; la matriz de subvenciones, como apoyo.
- **Funciones clave que se conservan**: `eq:margen-tamano` (I y III.1); `eq:multa-disuasoria`, `eq:colusion-clemencia` y `eq:williamson` ya no son `\funcionclave` (van en cajas grises), pero pueden escribirse en III.2.
- Nunca se dice el número de un tema en voz alta.

**Reparto del cante** (nota que iba tras el esquema del tema; quitada del tema el 19/11/2026 a petición de Víctor, se conserva aquí para el vídeo):

> Reparto del cante (puesto al día el 19/11/2026): introducción, \tiempo{2,5}; I, \tiempo{7} (I.1 justificación económica, \tiempo{3}, casi todo para la idea del mercado integrado y su resultado; I.2 fundamentos jurídicos, \tiempo{1,5}, con el art. 26 y la figura de la base jurídica; I.3 historia, \tiempo{2,5}); II, \tiempo{9} (II.1, \tiempo{3}; II.2, \tiempo{2,5}; II.3, \tiempo{1,5}; II.4, \tiempo{2}, con la síntesis final); III, \tiempo{10} (III.1, \tiempo{1}; III.2, \tiempo{8}: marco, toma de decisiones y evolución, \tiempo{1}; acuerdos, cárteles y clemencia, \tiempo{2}; abusos, \tiempo{1,5}; concentraciones y Williamson, \tiempo{1,5}; ayudas, carrera de subvenciones e instrumentos nuevos, \tiempo{2}; III.3, \tiempo{1}), y conclusión, \tiempo{1,5}. Las figuras imprescindibles son la de la base jurídica (art. 26) y la síntesis de las 4 libertades; los gráficos del cártel y de Williamson y la matriz de subvenciones están en cajas grises y se dibujan si hay tiempo. Lo que va en cajas grises, en notas y en los anexos es para las preguntas del tribunal.

## Listas en las notas al pie (15/11/2026)

- Nota de los 2 principios para gravar el comercio entre Estados: origen y destino, en itemize; la resistencia de los Estados al origen sigue en párrafo aparte.

## Comentarios de Víctor (19/11/2026)

Aplicados el 19/11/2026 (encargo común del 18/11 y añadido de la UE del 19/11). PDF: antes 34 páginas de tema + 1 de anexos + 6 de bibliografía (41); ahora **38 + 5 + 6 (49)**. Ficha: 4 páginas a 10 pt (última, 98 %). `verificar-tema.py`: 0 errores, 17 avisos (los de siempre: cifras sin cita en títulos, esquema y actos jurídicos que se citan a sí mismos, y los 2 del vídeo).

1. **Antiguo 4.B.18 y 4.A.15.** Comparado el 4.B.18 (barreras fiscales) con el tema: entran, puestos al día, la justificación de la armonización (distorsiones y competencia fiscal a la baja como dilema del prisionero), por qué avanza poco (unanimidad, ventaja y recaudación), las 3 estrategias (igualación, aproximación explícita o implícita, diferencial), las 3 etapas del IVA, el régimen transitorio con la inversión del sujeto pasivo (2010) y la OSS (2021), ViDA (2025/516), los impuestos especiales (1992, 2003/96, 2020/262, 2020/1151, reformas pendientes), Fiscalis 2021-2027 y una caja gris con cifras (tipos del IVA 17-27 %, brecha del IVA de 2023: 128.000 M€ y 9,5 %; fraude carrusel ≈ 50.000 M€/año). En capitales, la imposición directa en 4 frentes (matrices y filiales 2011/96, intereses y cánones 2003/49, fusiones 2009/133; código de conducta 1997 y lista de jurisdicciones; ATAD; pilar 2 con el *side-by-side* de enero de 2026), lo pendiente (BICCIS retirada, BEFIT, tipos del IS del 9 al 30 %) y la fiscalidad del ahorro (Directiva 2003/48 → DAC/CRS 2016, criptoactivos 2026, FASTER 2025/50). No se trae lo que es de otros temas (recursos propios nuevos → 3.B.37; arancel común y regímenes aduaneros → 3.B.41; ITF y servicios digitales en España → 4.B.20 y 4.B.18). Competencia alineada con el 4.A.15: criterio de efecto apreciable (5 % y 40 M€), autoridad «mejor situada» y Comisión cuando afecta a más de 3 Estados, art. 109, umbrales, plazos, casos. Las diferencias del 4.A.15 están en «Coherencia con el 4.A.15» (abajo); no se ha tocado.
2. **Art. 26 y base jurídica.** El I.1 antiguo (fundamentos) es ahora I.2 (ver 9): empieza por el art. 26 TFUE **redactado entero** en una caja `ideaclave`, con su lectura en 3 ideas (mandato, definición, equilibrio) y su origen (art. 8A del Acta Única); una **infografía nueva** (`base-juridica`, figura 1) ordena por peso el art. 26 → art. 114 (procedimiento legislativo ordinario, 114.3-114.6) → exclusiones con unanimidad (113 y 115) → los títulos de las 4 libertades, con las competencias a los lados. La antigua tabla 1 va en una **caja gris** con un párrafo por libertad (qué dice su base jurídica y sus excepciones). Se añaden la toma de decisiones (art. 294, mayoría cualificada) y subsidiariedad y proporcionalidad.
3. **Justificación teórica en II.1.1.** Nueva viñeta «Justificación económica» con 4 razones y remisiones: especialización (Ricardo, Heckscher-Ohlin) \vertema{3.B.5}; escala y variedad (Krugman, Melitz) \vertema{3.B.6}; barreras de fricción frente a arancel (Baldwin y Wyplosz) \vertema{3.B.7}; más allá de la unión aduanera (Viner) \vertema{3.B.10}. Sin desarrollar modelos.
4. **Diagrama al final de II.** Figura nueva `sintesis-libertades`: las 4 libertades en columnas (base jurídica, jurisprudencia, derecho derivado e instrumentos, barreras que quedan, grado de avance) y la conclusión «mismo patrón, distinto avance → política de competencia». Va con la recapitulación del bloque, que ahora incluye los retos comunes del mercado único.
5. **Mapa de Schengen.** Gráfico nuevo `mapa-schengen` (caja gris en II.3), hecho con datos y código como el del 3.B.35: `datos/mapa-schengen.py` + `datos/mapa-schengen.csv` (Natural Earth 1:50m, proyección LAEA). 25 de la UE en Schengen (con Bulgaria y Rumanía), 4 asociados, Irlanda (exención) y Chipre (pendiente) en colores distintos y trama en los 8 con controles interiores temporales. Comprobado en la página de la DG HOME (29 países; BG y RO el 1/1/2025; Chipre sin abolir controles) y en su lista de controles (8 Estados a 19/11/2026).
6. **Subpárrafos en las listas de instrumentos.** Pasadas a viñetas: iniciativas tras Monti, instrumentos y barreras de la movilidad de personas, marcos de crisis de las ayudas (IPCEI aparte), instrumentos de la imposición directa y del ahorro, impuestos especiales, ViDA, régimen transitorio.
7. **Cártel, clemencia, Williamson y subvenciones sin estructura de modelo.** En el cuerpo, la idea en viñetas (coste, multa disuasoria, palancas, evidencia, debate; criterio de Williamson y el matiz del consumidor; carrera de subvenciones, solución, asimetría y límite); en cajas grises, el gráfico y las ecuaciones (sobreprecio y PIE, `eq:multa-disuasoria`; `eq:williamson` con su gráfico; la matriz de pagos). **Caja nueva de la clemencia** con la condición del 3.A.19 en su notación, β ≥ (B^D − B^C)/(B^D − B^N) (`eq:colusion-clemencia`): la clemencia baja B^C y sube B^D y estrecha B^C − B^N, así que hace falta mucha más paciencia (ver B39-12). Además, por la regla de los temas institucionales (CRITERIOS, 14/11), el modelo del mercado integrado pasa al **anexo A** con su a)-e) completo y en el cuerpo queda la idea y el resultado `eq:margen-tamano` (ver B39-13).
8. **Colores de la figura de los pilares.** Cada pilar con su color: acuerdos azul, abuso naranja, concentraciones verde, ayudas dorado, subvenciones extranjeras rojo y mercados digitales morado; rótulos «empresas», «Estados» y «desde 2023» encima.
9. **Estructura común de las políticas de la UE y anexo de competencias.** Encaje: *Relevancia* en la introducción; *Justificación* en el bloque I, ahora en el orden pedido: (a) teoría económica = I.1 (antes I.3), (b) delimitación de competencias, (c) marco jurídico y (d) toma de decisiones = I.2 (antes I.1); *Evolución* = I.3 (antes I.2); *Articulación* = bloque II (las 4 libertades, cada una con su justificación, marco, implementación y valoración); *Retos* = valoraciones de cada libertad y recapitulación de II (retos comunes) y, para la competencia, III.3. En el bloque III, la misma secuencia: III.1 justificación teórica; III.2 competencias, base jurídica, **toma de decisiones** y **evolución** (nuevas, en 4 etapas), y los 4 pilares (articulación); III.3 retos. Los títulos de primer nivel y los de segundo nivel se conservan (solo se reordenan los del bloque I y cambia el de I.3 → I.1, «La justificación económica: competencia y escala»). **Anexo de competencias** pegado de `_trabajo/anexo-competencias.tex` como anexo B, antes del de test, con remisiones desde la delimitación de competencias de I.2 y de III.2.

### Coherencia con el 4.A.15 (no se ha tocado; para su revisión)

- Art. 101.3: el 4.A.15 lista como excepciones los acuerdos «con finalidad medioambiental» y los de cuota «menor del 10 %»; no son condiciones del 101.3 (son las directrices horizontales de 2023 y la comunicación *de minimis*).
- Posición de dominio «cuando la cuota es superior al 40 %»: la jurisprudencia la presume por encima del 50 % y la ve poco probable por debajo del 40 %.
- Google Android «en 2018, multa de 4.125 millones»: fueron 4.343 M€ en 2018; 4.125 tras el Tribunal General (2022), confirmada por el TJ (2/7/2026).
- Concentraciones: fase I «en el plazo de un mes» → 25 días hábiles (fase II, 90); faltan los umbrales alternativos (2.500/100/25 M€) y el umbral de 250 M€ se llama «minimis».
- Siemens/Alstom: dice que «no prohibió la fusión» y que «la autorizó salvo la alta velocidad»; la Comisión la **prohibió** (6/2/2019).
- Reparto de casos: dice que la Comisión está bien situada si hay efectos «en 3 o más Estados»; la Comunicación de la Red (2004/C 101/03) dice «más de 3».
- Clemencia: remite a «[ver tema 3.A.16]»; lo correcto es 3.A.14 y 3.A.19 (canon `cartel`).
- Art. 109: correcto. Criterio del 5 % y 40 M€: correcto y ahora también en este tema.

### Datos nuevos (19/11/2026)

| Dato | Valor | Fuente | Segunda comprobación |
|---|---|---|---|
| Brecha del IVA | 128.000 M€, 9,5 % (2023) | Comisión, VAT gap report 2025 (11/12/2025) | Prensa especializada (Bloomberg Tax) |
| Fraude transfronterizo del IVA | ≈ 50.000 M€/año | Comisión, 4/10/2017 | Documento del Consejo ST-14893-2017 |
| Tipos generales del IVA | 17 % (LU) a 27 % (HU); ES 21 % | TEDB (Comisión) | Tax Foundation y tablas de 2026 (no oficial) |
| Tipos del IS | 9 % (HU) a 30,1 % (DE); ES 25 % | Tax Foundation (2026) | Pendiente con OCDE, Corporate Tax Statistics |
| Pilar 2 *side-by-side* | acuerdo del 5/1/2026 | OCDE | KPMG, EY (no oficial) |
| Schengen | 29; 8 con controles | DG HOME (19/11/2026) | Consejo (12/12/2024) |
| Reforma de la directiva del tabaco | sin acuerdo en 2026 | Parlamento Europeo (tren legislativo) | Prensa |

### Dudas abiertas (19/11/2026)

- **B39-12.** Clemencia: Víctor la explicaba «aumentando B_N». En la condición del 3.A.19 la clemencia actúa por B^C (multa esperada) y B^D (exención de quien denuncia); B^N (el castigo) no cambia, pero sí se estrecha B^C − B^N. Opciones: (a) contarlo como en el 3.A.19 (B^C baja, B^D sube; se estrecha la distancia al castigo) **[aplicada]**; (b) decir que sube B^N, lo que no casa con el 3.A.19.
- **B39-13.** El modelo del mercado integrado (antes I.3, con a)-e)) no lo mencionaba el comentario 7, pero la regla de los temas institucionales manda los modelos al anexo. Opciones: (a) anexo A con a)-e) completo y, en el cuerpo, la idea, el resultado `eq:margen-tamano` y las implicaciones **[aplicada]**; (b) devolverlo al cuerpo como estaba; (c) idea en el cuerpo y desarrollo en caja gris, como el cártel.
- **B39-14.** Orden del bloque I: para seguir la estructura común (justificación → competencias y marco → evolución) se ha puesto la justificación económica antes que los fundamentos jurídicos y la historia al final. Opciones: (a) así **[aplicada]**; (b) el orden anterior (fundamentos, historia, efectos), con la teoría al final.
- **B39-15.** Tipos del impuesto sobre sociedades: la cifra viene de la Tax Foundation, no de una fuente oficial. Opciones: (a) mantenerla citada **[aplicada]**; (b) sustituirla por la OCDE (Corporate Tax Statistics, que va un año por detrás).
- **B39-16.** El 4.A.15 tiene 7 diferencias con este tema (lista arriba). Conviene corregirlas cuando se revise el 4.A.15.
- Mapa de la exposición tras el esquema, en caja gris (figu:mapa-tema).
- Ficha rehecha con el formato nuevo (introducción y esquema en la 1.ª columna, anexo en la última); 10 pt.

## Opinión (21/11/2026)

- **Antes → después**: 1 viñeta → 3 cortas: completar servicios, capitales y digital antes que fabricar campeones; directrices con innovación y resiliencia sin abandonar al consumidor; frase de Stigler (quien pide campeones suele aspirar a serlo).
- **Frase célebre**: Sí. Stigler, «The Theory of Economic Regulation», *Bell Journal of Economics and Management Science* 2 (1), 1971, p. 3: «as a rule, regulation is acquired by the industry and is designed and operated primarily for its benefit» (comprobada en Carrigan y Coglianese, capítulo sobre el artículo, GW Regulatory Studies Center, que cita la página). Entrada `Stigler1971Theory` copiada al `.bib`. Ficha: «Stigler: la industria adquiere la regulación».
