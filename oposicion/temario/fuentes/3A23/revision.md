# Revisión del tema 3.A.23

Economía del bienestar (II). Fallos de mercado: externalidades y bienes públicos. Intervención y fallos del sector público.

Revisión del 21/10/2026 (fase 3, integración). Tema completo: introducción, bloques I-III, conclusión, 8 anexos (A-H) y bibliografía. 31 páginas de tema, 7 de anexos y 5 de bibliografía.

## Resumen

- Tema sin el apartado de optimalidad desarrollado: con la decisión A23-01 (opción a), el 1TFEB y el 2TFEB se resumen en 1′ con `\vertema{3.A.22}`, y el 2×2×2×2 con sus demostraciones pasa al 3.A.22 (aquí queda un anexo corto de recordatorio).
- Bloque I con la tabla común de supuestos del 3.A.16 más «mercados completos», la fila que el tema levanta en salmón (tabla `tab:fallos-supuestos`), y los 4 fallos con su tema.
- Bloque II reescrito con un hilo conductor (el río: acería y piscifactoría, la mota del pueblo, la pesca y el riego), las tablas de bienestar corregidas, Coase con su argumento real, un apartado propio para los mercados de derechos (Dales, Montgomery, Weitzman y el RCDE con datos de octubre de 2026), la provisión privada como equilibrio de Nash y Clarke-Groves redactado de nuevo con un ejemplo propio.
- Introducción nueva con los 5 bloques y el refrán «Unos por otros, la casa sin barrer», que retoma la idea final.
- Bloque III con los 3 tipos de fallo (información, incentivos y compromiso) y el nuevo III.1.3 sobre la inconsistencia temporal (Kydland y Prescott, 1977), con su propio ejemplo de las zonas inundables, que cierra el hilo del río. Anexos nuevos con las derivaciones (2×2×2×2, externalidad en equilibrio general y en la producción, Samuelson, provisión privada, Groves-Clarke), Ostrom con el modelo de Gordon, el bloque y el test.
- Reparto: introducción 2′30″, I 3′, II 17′ (II.1 9′, II.2 8′), III 6′30″ (III.1 5′, III.2 1′30″), conclusión 1′ (los `\minutos` suman 30; antes II 17′30″ y III 6′, cambiado el 21/10/2026 al ampliar el bloque III).
- Gráficos pedidos (9, en `_trabajo/graficos-pedidos.json`): fallo-mercado, externalidad, externalidad-intervencion, coase, cap-and-trade, samuelson-eg, bowen, provision-privada y niskanen (este, en nota). Segunda vuelta (21/10/2026, a petición de Víctor): externalidad-pigou, externalidad-estandar, coase-externalidad, cap-and-trade-esquema y cap-and-trade-instalaciones; `coase` pasa a una nota al pie y `externalidad-intervencion` queda solo para el vídeo.

## Errores corregidos


| Dónde | Decía | Dice ahora |
|---|---|---|
| Introducción (l. 125) | Pareto, *Manual de Política Económica* (1906) | *Manuale di economia politica* (1906) |
| Introducción (l. 137) | TFEB «introducidos por Abba Lerner» | condiciones marginales de Lerner (1934) y Lange (1942); demostración de Arrow (1951) y Debreu (1951), por separado (como el 3.A.21) |
| 1TFEB (l. 452-462) | 6 supuestos (libre entrada, bienes homogéneos, funciones neoclásicas…) | lista del canon (MWG): mercados completos, precio-aceptantes, información perfecta, precios comunes; sin convexidad |
| l. 460 | «bienes púbicos» | bienes públicos |
| Tabla del impuesto pigouviano (l. 711-735) | fila «Excedente del consumidor» | «Daño a la piscifactoría» (con demanda horizontal no hay excedente del consumidor) |
| Tabla del estándar (l. 769-793) | ídem | ídem |
| Nota 25 | Weitzman, *Prices vs. Quantities* (2019) | 1974 |
| Coase (l. 805) | critica a Pigou por la «discrecionalidad» | el daño es recíproco y las partes pueden negociar |
| Nota de la caja de Edgeworth (l. 884) | curva de contrato «horizontal» con utilidad cuasilineal | vertical en $q^*$ (externalidad en abscisas) |
| Nota 32 | RCDE «aplicación exitosa del sistema de Coase… acuerdos del Protocolo de Kioto» | *cap and trade* de Dales (1968) y Montgomery (1972), inspirado en Coase; instrumento de la UE para Kioto |
| l. 912 | «ninguno de los mecanismos busca desincentivar… el comportamiento» | todos lo reducen hasta $q^*$; no buscan eliminarlo (contaminación óptima no nula) |
| Idea de 2.1.3 | provisión del bien «única forma posible de intervención en el caso de bienes públicos» | «como suele hacer con los bienes públicos» (Tiebout, Ostrom, provisión privada) |
| l. 941 y pie de la Imagen 7 | «Elinor Ostrom (1977)», fuente «Sahquillo (2017)» | Vincent y Elinor Ostrom (1977), elaboración propia a partir de ellos |
| l. 980 (P14) | «la solución de libre óptima» | problema del **planificador** (óptimo de Pareto); se quita la restricción $X_A+X_B=\overline X$, incompatible con $T(X,G)=0$ |
| Notación (Samuelson) | $\lvert\mathrm{RMT}_X^G\rvert$ y $\mathrm{RMT}_G^X$ | $\mathrm{RMS}^i_{GX}$, $\mathrm{RMT}_{GX}$ |
| Bowen | «equivalente» de Samuelson | versión de equilibrio parcial, anterior (1943) |
| Nota 42 (P6) | «las utilidades marginales cortan el eje en el mismo punto» como regla | es un caso particular; en general la suma vertical tiene un vértice |
| III (l. 1474-1480) | captura del regulador como «sesgo inconsciente» por el trato personal | teoría económica de Stigler (1971): la regulación se demanda y se ofrece |
| l. 1482, nota 58 | Olson (1992) | Olson (1965) |
| l. 1450 | Leviatán «defendida por Buchanan» | Brennan y Buchanan (1980), que lo suponen para diseñar límites constitucionales |
| Nota 56 | «ilusión de deuda de Niskanen»; «Buchanan (1977)» | ilusión fiscal de Puviani (1903) recuperada por Buchanan y Wagner (1977) |
| Nota 59 | «entre el 7 % y el 50 % del PNB (Mueller, 2013)» | solo el dato comprobado de Krueger (1974): 7 % (India) y 15 % (Turquía); el 50 % no se ha encontrado y se quita |
| l. 1442 | aversión al riesgo de los burócratas «según Atkinson y Stiglitz» | se quita la atribución (no localizada) |
| Nota 46 | Nobel de Ostrom «por sus teorías sobre el papel de las empresas…» | «por su análisis de la gobernanza económica, especialmente de los bienes comunes» |
| Nota 65 | Ostrom, «primera no economista» en recibir el Nobel | primera mujer; antes, Simon (1978) no era economista de formación |
| Anexo 2 | «Garret Hardin»; «Como Elinor Ostrom»; Kenia, Guatemala y Nepal entre los casos | Garrett; «Cómo»; los casos de Ostrom (1990): Törbel, Japón, huertas españolas, Filipinas, Alanya, Los Ángeles |
| Nota 64 | «Muñoz Moldes (2018)» | no identificado: se cita Ostrom (1990, pp. 61-65) y Netting (1981) |
| Conclusión (l. 1530) | cita de Milton Friedman sin fuente | se quita; la idea va con Demsetz (1969) y Kahn (1988), sin comillas |
| Anexo 1 | relación de temas con títulos antiguos y el 2TFEB en el 3.A.24 | anexo G con los títulos vigentes (2TFEB en el 3.A.22) |
| l. 1322 | cooperación como «estrategia dominante» en el juego infinito | equilibrio sostenido por la amenaza de castigo |
| Olken (l. 1326) | «en 2010 economistas del MIT llevaron a cabo un experimento» | experimento de 2005-2006, artículo de 2010 |
| Levinson (l. 1328) | columna de VoxEU sin fecha | artículo de 2012 (texto) y columna de 2009 (anotaciones) |

## Marcas resueltas

- **P1, P2** (amarillo, demostraciones de los TFEB y capturas de MWG): no se desarrollan aquí; van al 3.A.22, su tema de referencia (decisión A23-01). Las capturas no se publican. Los errores del 2×2×2×2 que no deben pasar al 3.A.22 están en `propuestas-contenido.md`, C4 (lagrangiana con el signo mal, «utilidad marginal decreciente» con utilidad ordinal, «RMT ≡ ∂FPP/∂X», rendimientos e Inada como supuestos del 1TFEB).
- **P3, P15, P18** (amarillo y comentarios: Clarke-Groves y la caja de la farola copiados de Varian y de otros apuntes): redactado de nuevo, con el ejemplo propio de la mota y 3 vecinos (tabla `tab:clarke-groves`), demostración en nota, VCG y Green-Laffont.
- **P4** (amarillo, bienes comunales copiados): reescrito e integrado en II.2.1 (recursos comunes, tragedia de los comunes, Ostrom y el Tribunal de las Aguas, anticomunes).
- **P6** (amarillo, nota 42, suma vertical): integrado en Bowen y corregido; las capturas de Wikipedia se sustituyen por el gráfico `bowen`.
- **P7, P8, P37** (notas al opositor del cambio de temario): desaparecen; el reparto del tiempo va en las `notaopositor`.
- **P9** (nota al opositor, equilibrio general frente a parcial): reescrita como `notaopositor` en II.1.2; la versión en la producción irá al anexo `anexo:externalidad-eg`.
- **P12, P13, P16, P42** (comentarios internos, clases, otros preparadores): no se publican.
- **P14** (comentario sobre la solución de Samuelson): era el planificador; corregido.
- **P19-P28** (figuras): rehechas como gráficos TikZ pedidos (abajo) o tablas LaTeX (`tab:rivalidad-exclusion`, tablas de bienestar y de pagos). Las que citaban a otro preparador (Imagen 7 y 9) pasan a «elaboración propia a partir de» Ostrom y Ostrom (1977) y Bowen (1943). El manuscrito de la provisión privada (P28) es ahora texto en II.2.2 c) ii) y su gráfico irá al anexo `anexo:provision-privada`.
- **P30** (QR e imágenes de Olken, Levinson y el pódcast *Economics in Ten*): sin QR; Olken y Levinson en el texto y en `anotaciones`; el pódcast no se ha podido identificar y no se incluye.
- **P32** (1.3.1 y 1.3.2 sin cuerpo): poder de mercado e información asimétrica con su tema en I.3.
- **P33** (justificación vacía, Weitzman en notas, RCDE): escritos.
- **P34** (provisión privada, club, comunales): escritos.
- **P35** (diseño de mecanismos): Clarke-Groves como VCG, principio en palabras, Green-Laffont, Gibbard-Satterthwaite con remisión.
- **P38, P39** (remisiones): todas con `\vertema` o `\ref`; 2.ª ley de Gossen ya no se cita; «[ver tema 3.A.23]» autorreferente sustituido por `\ref`.
- **P46-P48** de los bloques I y II: ver «Errores corregidos».

- **P5** (amarillo, bienes públicos globales y 3.B.31): en las extensiones de la conclusión (Kindleberger, Hirshleifer, clubes climáticos de Nordhaus, MAFC), con `\vertema{3.B.31}` y `\vertema{4.A.6}`.
- **P10** (nota al opositor del apartado 3): reescrita como `notaopositor` del bloque III, con los minutos.
- **P11, P44** (captura de Stigler, promarket.org y YouTube): captura reescrita y los 2 enlaces, comprobados por el agente de datos, en `anotaciones` con sus claves del 3.A.17. Blog katalepsis (nota 55) y enlaces de la UFM: fuera.
- **P17** (coordinar con 3.A.20): la teoría positiva de la regulación y el menú de contratos remiten al 3.A.20.
- **P29** (gráficos de las notas): Niskanen como `\graficonota` (gráfico pedido); el ciclo político va sin gráfico (Rogoff y Kalecki en nota); Peltzman, solo de palabra con remisión al 3.A.20; la portada del Leviatán de Hobbes no se publica.
- **P31** (capturas de test y quia.com): no se publican; anexo H con trampas del test, preguntas del tribunal y el enlace único al simulador. El agente de datos comprobó que las preguntas de 2017 (n.º 12) y 2019 (n.º 15) están en `preguntas.json`.
- **P36** (inconsistencia temporal): nuevo III.1.3 con a)-c).
- **P43** (bibliografía con temas de preparadores y un blog): rehecha en `3A23.bib`; Sala-i-Martín no se usa.
- **P45** (apartados vacíos): relevancia y opinión de la conclusión, preguntas del tribunal, escritos.

## Datos actualizados

(Todos de `propuestas-datos.md`, consultados el 21/10/2026, con su segunda comprobación allí.)

| Dato | Anterior | Nuevo | Fuente | URL | Consulta | Segunda comprobación |
|---|---|---|---|---|---|---|
| Objetivo 2040 y aplazamiento del RCDE 2 (enganche) | — | −90 % neto en 2040; RCDE 2 de 2027 a 2028 | Reglamento (UE) 2026/667 | https://eur-lex.europa.eu/eli/reg/2026/667/oj | 21/10/2026 | Comisión, página del ETS2 |
| Precio del derecho (relevancia y RCDE) | — | unos 85 €/t (subasta del 20/10/2026); 6 €/t en 2017; más de 80 €/t en 2023 | EEX, informe de subastas 2026 | https://public.eex-group.com/eex/eua-auction-report/emission-spot-primary-market-auction-report-2026-data.xlsx | 21/10/2026 | precio del certificado CBAM (Comisión) |
| Creación y fases del RCDE | 2005, «sistema de Coase» | Directiva 2003/87/CE; desde 2005; 4.ª fase 2021-2030 | Comisión Europea | https://climate.ec.europa.eu/eu-action/carbon-markets/eu-emissions-trading-system-eu-ets/development-eu-ets-2005-2020_en | 21/10/2026 | EUR-Lex (nota 8 del Reg. 2026/667) |
| Factor de reducción lineal | — | 4,3 % (2024-2027) y 4,4 % (desde 2028) | Comisión Europea | https://climate.ec.europa.eu/eu-action/carbon-markets/eu-emissions-trading-system-eu-ets/eu-ets-emissions-cap_en | 21/10/2026 | EPRS (sept. 2026) |
| Resultado del RCDE | «aplicación exitosa» | emisiones a la mitad desde 2005; −1,3 % en 2025; objetivo −62 % en 2030 | Comisión Europea, 10/4/2026 | https://climate.ec.europa.eu/news-other-reads/news/eu-emissions-trading-system-sustains-downward-trend-covered-emissions-2026-04-10_en | 21/10/2026 | EPRS (sept. 2026) |
| Reserva de estabilidad | — | unos 190 millones de derechos entre 9/2026 y 8/2027 | Comisión Europea, 29/5/2026 | https://climate.ec.europa.eu/news-other-reads/news/190-million-eu-ets-allowances-be-placed-market-stability-reserve-between-september-2026-and-august-2026-05-29_en | 21/10/2026 | prensa especializada (Carbon Pulse) |
| MAFC | — | régimen definitivo desde el 1/1/2026; certificado de 82,32 €/t en el 3.er trimestre de 2026 | Reglamento (UE) 2023/956; Comisión (DG TAXUD) | https://taxation-customs.ec.europa.eu/carbon-border-adjustment-mechanism/cbam-definitive-regime_en | 21/10/2026 | medias de la EEX |

No se usan, por no estar comprobados en EUR-Lex: la escala de retirada de la asignación gratuita (V9) ni el tope de 2026. Tampoco la propuesta de 5.ª fase (V6), que es solo una propuesta y alargaba la conclusión. La serie `datos/precio-eua-subastas.csv` no se ha convertido en gráfico (opcional; el dato va en el texto). Fechas y atribuciones del bloque III (Olson 1965, Brennan y Buchanan 1980, Buchanan y Wagner 1977, Krueger 1974, Nobel de Buchanan, Ostrom y Simon): V14-V16, V26, V36-V45.

## Contenido añadido

### Cambios pedidos por Víctor (21/10/2026, segunda vuelta)

Petición: «Haz gráficos distinguidos para el instrumento pigouviano y el estándar medioambiental aunque en el vídeo se use el mismo dibujo. Creo que también es interesante mantener el mismo aparato gráfico para el teorema de Coase (pudiendo llevar al actual gráfico 4 y tabla 5 a una nota al pie de página). Me interesa que al explicar el mecanismo de cap and Trade mantengas la antigua Imagen 6 para explicar cómo funciona de manera visual. Creo que de manera coherente con lo que se va a ver en el tema 4.B.2 se puede añadir algo más de fallos del sector público.»

- **Pigou y estándar, 2 gráficos**: la figura `fig:externalidad-intervencion` desaparece del documento. En su lugar, `fig:externalidad-pigou` (gráfico `externalidad-pigou`), pegada al b) Modelo del impuesto, con las áreas explicadas en viñetas (A para la acería, B+C de recaudación, C de daño, E recuperada); la nota de las áreas con prima ($B'$, $C'$, $D'$, $E'$) pasa a su pie. Y `fig:externalidad-estandar` (gráfico `externalidad-estandar`), pegada al b) Modelo del estándar (oferta quebrada en $\overline q=q^*$, excedente $A+B+C$ con la renta de escasez $B+C$, daño $C$), seguida de una viñeta de bienestar. Las tablas `tab:pigou-bienestar` y `tab:estandar-bienestar` remiten cada una a su gráfico. Todas las remisiones a `fig:externalidad-intervencion` (nota del reparto de la introducción y nota de II.1) se han cambiado; en los anexos no había ninguna.
- **Coase con el mismo aparato**: la figura principal es `fig:coase-externalidad` (gráfico `coase-externalidad`), pegada al ii) Desarrollo, que ahora se cuenta con $\overline p$, $\mathrm{CMgP}$, $\mathrm{CMgS}$, $q^*$, $q^c$ y las áreas A–E: con derechos de la acería, la piscifactoría paga entre $D$ y $D+E$; con derechos de la piscifactoría, la acería paga entre $C$ y $A+B+C$; en los 2 casos el bienestar es $A+B$. El gráfico `coase` (BMg/DMg) pasa a una nota al pie con `\graficonota[0.5]{coase}`, que explica que es la misma negociación con $\mathrm{BMg}=\overline p-\mathrm{CMgP}$ y $\mathrm{DMg}=\mathrm{CMgE}$. La tabla `tab:coase-pagos` desaparece como tabla: sus 6 casillas van en 2 frases de la nota (no se ha metido un `tabular` en la nota para no arriesgar la partición de la nota ni el Word). Comprobado que los pagos coinciden con las áreas de los 2 gráficos: bajo BMg hasta $q^*$ queda $A+B+C$ (= excedente entre $\overline p$ y CMgP), bajo DMg $C$; entre $q^*$ y $q^c$, $D$ bajo BMg y $D+E$ bajo DMg.
- **Cap and trade visual (la antigua Imagen 6)**: en a) Idea, una viñeta con el resultado y el esquema `fig:cap-and-trade-esquema` (gráfico `cap-and-trade-esquema`); en b) Modelo, antes del gráfico de Montgomery (`fig:cap-and-trade`, que se queda), la explicación con 5 instalaciones en escalones (`fig:cap-and-trade-instalaciones`, gráfico `cap-and-trade-instalaciones`) en 3 pasos numerados: el tope fija $R_0$; el precio $p_E$ lo fija la instalación que hace la última reducción necesaria (la 4); las de coste menor (1-3) reducen y venden, la 5 compra derechos. Fuente: elaboración propia a partir de Energía y Sociedad (2022), nueva clave `EnergiaSociedad2022CapTrade`, y Montgomery (1972). El modelo continuo (ecuación `eq:cap-and-trade`) sigue después, con el gráfico de Montgomery pegado a su viñeta.
- **Fallos del sector público, coherente con el 4.B.2** (título del 4.B.2: mecanismos de decisión, reglas de votación, democracia representativa, burocracia, límites normativos; inventario `canon/_inventario/4B02.json`). Lo que ya estaba (información, Niskanen, ilusión fiscal, Leviatán, Nordhaus, búsqueda de rentas, Stigler, Peltzman, inconsistencia temporal) no se repite. Se añade:
  - en III.1, la clasificación de Wolf (1979) de los fallos del no mercado (internalidades y objetivos privados, costes redundantes y crecientes, externalidades derivadas, desigualdad de poder y de privilegios) y las 4 razones de Stiglitz (información limitada, control limitado sobre las respuestas privadas y sobre la burocracia, limitaciones del proceso político), con una tabla nueva, `tab:fallos-no-mercado`, que las ordena en los 3 tipos del tema (información; incentivos y proceso político; compromiso);
  - en III.1.1, el control limitado de las respuestas privadas (externalidades derivadas) con 2 ejemplos del río;
  - III.1.2 pasa a «Problemas de incentivos y del proceso político: la elección pública» y empieza por las reglas de votación: paradoja de Condorcet (1785), teorema de imposibilidad de Arrow (1951), votante mediano (Black, 1948) con la convergencia de Downs (1957) y por qué no es eficiente (Bowen, 1943: solo si la mediana coincide con la media), y el intercambio de votos (Tullock, 1959); remisiones a \vertema{3.A.24} y \vertema{4.B.2};
  - el triángulo de hierro, en una frase, tras Peltzman, con \vertema{4.B.2};
  - la introducción (estructura), el esquema, la recapitulación de III, la conclusión y el anexo del test (una trampa y una pregunta del tribunal nuevas) se ponen al día. Claves nuevas: `Condorcet1785Essai`, `Arrow1951Social`, `Black1948Rationale`, `Tullock1959Problems`.
- **Minutos**: II baja a 17′ (II.2 de 8′30″ a 8′: la provisión pública según la capacidad de pago se canta en 30″; en II.1, Coase baja a 1′30″ porque reutiliza el dibujo y el cap and trade sube a 1′30″) y III sube a 6′30″ (III.1 de 4′30″ a 5′: el proceso político, 2′30″). Suman 30 (`verificar-tema.py`: minutos 30,0). Extensión: el tema crece unas 2-3 páginas (2 figuras nuevas en el bloque II, 2 en el cap and trade, una tabla y una página de texto en el III); conviene revisarlo en el PDF al reconstruir.

### Contenido de la primera revisión

- I.3: mercados incompletos (Arrow, 1969), ineficiencia restringida (Greenwald y Stiglitz, 1986), tabla común de supuestos con «mercados completos» en salmón.
- II.1.1: clasificación agotables/no agotables (Baumol y Oates, 1988), Scitovsky (1954), tabla de ejemplos.
- II.1.2: el impuesto pigouviano en equilibrio general; frase puente EG→EP.
- II.1.3: justificación (vacía en el original); Pigou con monopolio contaminante (Buchanan, 1969, *second best*); Myerson-Satterthwaite como límite de Coase; mercados de derechos como apartado propio (Dales, Montgomery, Weitzman, Roberts y Spence, RCDE, reserva de estabilidad, RCDE 2, MAFC); tabla comparativa de los 5 mecanismos (`tab:instrumentos`, idea propia).
- II.2.1: bienes de club (Buchanan, 1965), anticomunes (Heller, 1998; Heller y Eisenberg, 1998), bienes preferentes (Musgrave, 1959), el faro (Coase, 1974; Bertrand, 2006).
- II.2.2: dilema del prisionero de la mota (tabla `tab:polizon`), provisión privada con Nash, neutralidad (Warr; Bergstrom, Blume y Varian), Andreoni (1990), evidencia experimental (Ledyard, 1995).
- II.2.3: Clarke-Groves con ejemplo propio y demostración; Green y Laffont (1977); votación con remisión al 3.A.24.
- III: Wolf (1979), ignorancia racional (Downs, 1957), Rogoff (1990), Weber (1922), Peltzman (1976); III.1.3 completo (Kydland y Prescott, 1977, con la formulación de 2 periodos; Fischer, 1980; Helm, Hepburn y Mash, 2003; Kornai, 1986; Barro y Gordon, 1983; sesgo deficitario de Persson y Svensson, 1989, Alesina y Tabellini, 1990, y fondo común); soluciones en 3 familias (K23) con el *second best* (Lipsey y Lancaster, 1956).
- Conclusión: bienes públicos globales (Kindleberger, 1986; Hirshleifer, 1983; Nordhaus, 2015) y falacia del nirvana (Demsetz, 1969).
- Anexos: externalidad en la producción en equilibrio general (deducción propia, comprobada: $\mathrm{RMS}=\mathrm{RMT}+|\partial F_Y/\partial X|$); provisión privada con el ejemplo cuasilineal; mecanismos de Groves en general; modelo de Gordon (1954) en el de Ostrom.

Fuentes: `propuestas-contenido.md` (C1-C24) y `propuestas-coherencia.md` (K2-K20); ninguna idea tomada de otros preparadores se cita ni se copia.

## Coherencia

- Estructura, etiquetas y minutos de `propuestas-coherencia.md` (§ 7). Títulos: I «Optimalidad del equilibrio competitivo\newline y fallos de mercado»; I.2 rebautizado «El equilibrio general competitivo y los teoremas del bienestar» (D1, opción recomendada, aplicada provisionalmente).
- Cuando chocaban contenido y coherencia: el ejemplo de Clarke-Groves es la **mota** de 3 vecinos (hilo del río, K4) con los números comprobados de C23 (farola); el precio de Lindahl se escribe $p^i_G$ (CC2) y Bowen con $\mathrm{RMS}^i_{GX}(G)$ (K27), no $p_i$ ni $\mathrm{BMg}_i$; solo 2 `\funcionclave` ($\mathrm{CMgS}$ y Samuelson, K7), el resto en `equation`; las derivaciones con condiciones de primer orden van a los anexos B y C (K5), no a notas al pie.
- Precio dado de la acería: $\overline p$ (exógeno, canon § 0) en Pigou y en Coase, para que se lean juntos; $q^c$ en lugar de $q'$ (CC1).
- **Desviación menor de K7**: el «gráfico maestro con capas» de la externalidad se pide como varios ficheros con las mismas rectas y letras (`externalidad`, en II.1.2; `externalidad-pigou`, `externalidad-estandar` y `coase-externalidad`, en II.1.3), para que cada figura vaya pegada a su párrafo (CRITERIOS § 2). En el vídeo es un único gráfico que crece por capas (`externalidad-intervencion`, que se conserva para eso).
- Lista común de supuestos del 3.A.16 (1-5, mismas palabras) más el 6 «mercados completos», en salmón y con «Se levanta», como piden los temas 3.A.16-3.A.19 y `pendientes-coherencia.md` («3.A.23: la misma lista de supuestos del 3.A.16 para el 1TFEB»).
- 3.A.14: VCG con sus palabras («hacen pagar a cada uno el daño que su presencia causa a los demás; así, decir la verdad es una estrategia dominante»); aquí se añade que el presupuesto no se equilibra (Green y Laffont). Matiz opcional para el 3.A.14 en `pendientes-coherencia.md` (lo anota la fase canon).
- III.2 agrupa las 7 soluciones del original en 3 familias (K23), no por fallo (C29): manda coherencia en la estructura; no se pierde ninguna.
- Preguntas del tribunal en el anexo H (K25), no tras la conclusión (C31).
- Inconsistencia temporal: el modelo general de C28 con el ejemplo de las zonas inundables de K22, que es del propio artículo de Kydland y Prescott y cierra el hilo del río (la mota). Sin derivar Barro-Gordon (3.A.36). No se menciona la DANA de 2024 (D5, opción recomendada).
- Citas con 2 autores escritas con `\textcite` sin los nombres de pila delante (evita «Edward Kydland y Prescott»).
- Contradicciones con otros temas (no se tocan): ver `propuestas-coherencia.md` § 9 (3.A.22, 3.A.24, 3.B.37, 4.B.2, 3.A.14).

- **Control de calidad (21/10/2026)**: 15 correcciones aplicadas. Fórmulas con `\left`/`\right` y `\text{si }i\text{ es pivotal}` para el Word. Notas al opositor con el reparto en viñetas y la Opinión en 3 subviñetas. Sin paréntesis anidados en las citas (Nobel de 2007, Simon, Samuelson 1955). Rótulos de los 4 agentes en cursiva. En el `.bib`, Wolf, Jr. y Coglianese (*ProMarket*). Gráficos corregidos: en `externalidad-intervencion`, $t^*$ fuera de la línea de $\overline q$ y las áreas bajo CMgE como $B'$, $C'$, $D'$ y $E'$, con su equivalencia en el pie; en `provision-privada`, las etiquetas fuera de las rectas; en `bowen`, un hilo que une $p^A_G+p^B_G=\mathrm{CMg}_G$ con $G^*$. `construir-tema.py 3A23` completo y `verificar-tema.py 3A23`: 0 errores (2 avisos, guion y vídeo de la entrega 3).

## Dudas abiertas

- **Stiglitz (fallos del Estado)**: las 4 razones se citan de Stiglitz y Rosengard (2015) sin capítulo ni página; en ediciones anteriores están en el capítulo 1 («government failure»). Conviene comprobar la página si se quiere citar con precisión.
- **Ejemplos del río en III.1.1** (la mota que atrae casas a la zona inundable y la indemnización que desincentiva cuidar los estanques): son ejemplos propios para ilustrar las externalidades derivadas de Wolf y el control limitado de las respuestas privadas de Stiglitz, no de esas obras.
- **Refrán del intercambio de votos**: «Hoy por ti, mañana por mí» es el refrán del 3.A.14, así que se ha sustituido por un ejemplo («yo voto tu carretera y tú votas mi polideportivo»).
- **D1** (título de I.2): aplicado «El equilibrio general competitivo y los teoremas del bienestar» (recomendada). Alternativa: el título original «Construcción del modelo de equilibrio general competitivo».
- **D2** (anexo A corto con el 2×2×2×2): aplicado: anexo A corto, con la notación del canon (recomendada).
- **D3** (enganche): refrán y el río, con Pigou en la contextualización (recomendada).
- **D4** (hilo conductor del río): aplicado (recomendada).
- **D5** (DANA de 2024 en la inconsistencia temporal): no se menciona (recomendada).
- **Kahn (1988)**: la idea de la «mezcla de regulación imperfecta y competencia imperfecta» va sin comillas; no se ha podido comprobar la frase literal (p. xxxvii según fuentes secundarias).
- **Páginas sin comprobar**: Ostrom (1990), pp. 61-65 (Törbel), y Ostrom y Ostrom (1977), pp. 7-49 o 7-47.
- **Stern (2007)**: la frase «el mayor fallo de mercado que el mundo ha visto» es la del resumen ejecutivo del informe; no se ha comprobado la página.

## Instrucciones para el vídeo

- **Enganche**: «Unos por otros, la casa sin barrer» y el hecho de 2026 (objetivo del 90 % y RCDE 2 aplazado); la idea final debe retomar el refrán.
- **Hilo conductor**: el río (acería y piscifactoría; la mota; la pesca y el riego; el organismo de cuenca en III). Refranes pegatina, apuntados una vez a su lado en la pizarra: «El que venga detrás, que arree» (externalidad), «Más vale un mal acuerdo que un buen pleito» (Coase), «Lo que es del común es de ningún» (comunes), «Unos por otros, la casa sin barrer» (polizón).
- **Pizarra, bloque I**: las 3 condiciones de Pareto en una línea; la tabla `tab:fallos-supuestos` (versión breve: fallo → supuesto) a la izquierda, que **se conserva** todo el cante.
- **Pizarra, bloque II**: gráfico de la externalidad construido por capas (base → áreas → $\mathrm{CMgP}+t^*$ → $\overline q$), un solo gráfico que crece; `\funcionclave` $\mathrm{CMgS}=\mathrm{CMgP}+\mathrm{CMgE}$ (se conserva a la derecha); Coase sobre ese mismo dibujo (las áreas A–E ya están: solo se añaden las 2 flechas de quién paga a quién, como en `coase-externalidad`); el gráfico de las 5 instalaciones del cap and trade (`cap-and-trade-instalaciones`), por pasos: escalones, $R_0$, $p_E$ en la instalación 4, quién reduce y quién compra; tabla de rivalidad y exclusión; `\funcionclave` de Samuelson (se conserva hasta la conclusión); gráfico de Bowen (con los precios de Lindahl en la misma figura, sin redibujar); tabla de Clarke-Groves.
- **Apoyo** (no se escribe): tablas de bienestar del impuesto y del estándar, el gráfico BMg/DMg de Coase de la nota, el esquema del cap and trade (`cap-and-trade-esquema`) y el gráfico de Montgomery, datos del RCDE, gráfico de Samuelson en equilibrio general, dilema de la mota, tabla de los 5 mecanismos.
- **Pizarra, bloque III**: la tabla de los 3 tipos con Wolf y Stiglitz (`tab:fallos-no-mercado`) va como apoyo; en la pizarra, solo las 3 palabras (información, incentivos y proceso político, compromiso). Para el proceso político, el ciclo de Condorcet en una línea ($x\succ y\succ z\succ x$) y la mediana frente a la media; ejemplo del intercambio de votos: «yo voto tu carretera y tú votas mi polideportivo». A la derecha, los 4 agentes de la elección pública en columna con un autor cada uno (Downs, Nordhaus, Niskanen, Olson-Stigler) y, debajo, una mini línea del tiempo «anuncio → decisión privada (casas en la zona inundable) → el Estado reoptimiza (construye la mota)»; refranes «Hecha la ley, hecha la trampa» (captura) y «Prometer hasta meter y, una vez metido, olvidar lo prometido» (inconsistencia temporal); las soluciones, 3 palabras: incentivos, reglas, competencia. Las condiciones \eqref{eq:kp-optima} y \eqref{eq:kp-discrecion} van como apoyo; el gráfico de Niskanen no sale.
- **Funciones que se conservan**: $\mathrm{CMgS}=\mathrm{CMgP}+\mathrm{CMgE}$ y la condición de Samuelson, hasta el final del bloque II; la tabla de los fallos (izquierda) hasta la conclusión.
- **Conclusión e idea final**: sin pizarra; empieza por «A modo de conclusión,» y termina con el refrán y su respuesta («poner precio a lo que ensucia, repartir la escoba con reglas… y no olvidar que quien reparte las escobas también necesita reglas»). Al cerrar puede volver el río en una frase: la acería, la mota y el organismo de cuenca.

### Para el vídeo

- **Un único dibujo para el impuesto y el estándar** (Víctor, 21/10/2026): aunque el documento tenga 2 gráficos distintos (`externalidad-pigou` y `externalidad-estandar`), el guion debe usar un solo dibujo, `externalidad-intervencion` (que se conserva en `graficos/` solo para el vídeo), que crece por capas: base → áreas → $\mathrm{CMgP}+t^*$ y recaudación → $\overline q$. Coase se cuenta sobre ese mismo dibujo, sin borrarlo.
- El cap and trade se cuenta con `cap-and-trade-instalaciones` en la pizarra (3 pasos) y el esquema y Montgomery como apoyo.

## Retoques de coherencia del 21/10/2026

A raíz del 3.A.22 (`canon/pendientes-coherencia.md`, opción (a)): la tabla `tab:fallos-supuestos` pasa a la de 5 filas del 3.A.22 (no saciedad local, mercados completos en salmón con «Se levanta», precio-aceptantes, precios comunes, información perfecta), con la columna «Dónde»; la lista de I.3 renumera (poder de mercado: supuesto 3; información asimétrica: supuesto 5), la frase de entrada remite al 3.A.22 y al 3.A.16, y el producto homogéneo pasa a una frase del poder de mercado (\vertema{3.A.18}). En los anexos A y B, los multiplicadores del planificador son $\lambda_U,\lambda_X,\lambda_Y,\lambda_L,\lambda_K$ como en el 3.A.22.
