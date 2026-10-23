# Revisión del tema 3.A.20 — Poder de mercado y regulación óptima. Definición del mercado relevante. Desarrollos en presencia de información asimétrica. Aplicaciones prácticas

Revisión del 22-23/10/2026 (`/revisartema`, fase integrar; segunda vuelta del 23/10/2026 con el
Word de Víctor).

## Resumen

- **Base: el Word de Víctor**, su antiguo 3.A.25 «Teoría de la regulación. Implicación sobre la
  liberalización de los sectores» (31/08/2023; `_trabajo/original.md`). **Por decisión de Víctor
  (23/10/2026)**, la estructura del primer borrador (22/10/2026), adaptada al título nuevo, se
  mantiene: I. Poder de mercado, mercado relevante y regulación con información completa (8′: I.1
  2′30″, I.2 2′30″, I.3 3′); II. Desarrollos en presencia de información asimétrica (11′: II.1 2′,
  II.2 2′, II.3 3′30″, II.4 2′, II.5 1′30″); III. Regulación con varias empresas y aplicaciones
  prácticas (7′30″: III.1 2′, III.2 1′30″, **III.3 2′30″, III.4 1′30″**). La introducción dura
  2′30″ y la conclusión 1′: en total, 30′.
- **Dentro va todo lo aprovechable del Word**: la definición de regulación y sus motivos (Musgrave;
  tabla 2.1 de Baldwin, Cave y Lodge en LaTeX), su algoritmo de Braeutigam (gráfico rehecho con la
  caja vacía rellena), el dilema del monopolio natural con la subaditividad, la caja de
  Laffont-Tirole, la captura ordenada (Bernstein, Stigler, Posner) y la búsqueda de rentas, los
  mercados impugnables (resumen y remisión al 3.A.15), la liberalización y la re-regulación, los
  CTC, la ECPR con el ejemplo del Word, las formas de separación vertical (fuente real: OCDE, 2001)
  con un gráfico de 6 paneles y un ejemplo español por forma (Telefónica, ADIF-Renfe, Aena,
  CLH/Exolum, distribuidoras), y las notas al pie bien desarrolladas. Lo que no es del título nuevo
  (otros fallos de mercado, fallos del sector público, mecanismos cuasi-competitivos, criterios de
  una buena regulación) va en una línea del cuerpo con `\vertema{3.A.23}` y en el anexo nuevo
  «La regulación en la economía del bienestar» (`anexo:bienestar-regulacion`). Se respetan todas
  las fuentes del Word, completadas o con su copia archivada.
- **Tebar y Cabado, solo de contraste**: sus temas sirvieron ayer para completar lo que el Word no
  tenía (mercado relevante, modelos con información asimétrica, aplicaciones); no son la estructura
  ni la redacción. Cotejo del 23/10/2026 (8 palabras seguidas, sin tildes): con el tema DCE 3.A.18
  de Cabado solo coinciden nombres propios (CNMC, «primer teorema fundamental…», «regla del precio
  eficiente de los componentes»), títulos de normas, la cita del Nobel, datos y fórmulas; con el de
  Tebar, el título del tema y «la inversa de la elasticidad de la demanda».
- **Tamaño**: 43 páginas de tema, 14 de anexos y 11 de bibliografía (68 en total; 209 entradas en
  el `.bib`). 14 gráficos (13 TikZ y el grabado del *Leviatán*); `verificar-tema.py`: 0 errores.
- **Se mantienen** el enganche («Tener la sartén por el mango» y la tasa de retribución del 6,58 %),
  las pegatinas, el ejemplo conductor *Redes del Valle* y el tema de referencia de los modelos
  (P21-02).

## Errores corregidos

### Del Word de Víctor

| Dónde (Word) | Qué decía | Qué dice ahora |
|---|---|---|
| 1.2.4 y 3.1.5 | «Ramsey-Boiteaux (1927)» | \autor{Ramsey} (1927) y \autor{Boiteux} (1956) (I.3) |
| 4.1.2 | «Schleifer (1985)» | Shleifer (1985) (III.1) |
| Introducción, 1.1, 4.1; nota 9 vacía | «Laffont y Tirole (1991)» como la obra que incorpora la información asimétrica | 1986 (*JPE*) y 1993 (libro); 1991 solo para la captura (II.5) |
| 3.1.3 | Sostenible = «obtener pérdidas»; no sostenible = «obtener beneficios» | Definición de Panzar-Willig y Baumol-Bailey-Willig y gráfico `subaditividad-sostenibilidad` (I.3) |
| 1.2.4, 3.1.4-3.1.6 y algoritmo | «Óptimos de 1.er/2.º/3.er orden» | Primer, segundo y tercer óptimo (nota de I.3 y algoritmo) |
| Algoritmo (Imagen 9) | Caja vacía en la rama «Sí» del primer óptimo; mercados impugnables colgados del monopolio **no** sostenible | Caja rellena (impuesto de suma fija si hay beneficios; subvención con impuestos de suma fija si hay pérdidas, Hotelling); los impugnables pasan a la rama «Sí» (un mercado impugnable solo tiene equilibrio con una configuración sostenible) |
| 4.2 y 2.1.2 | Captura atribuida a «Posner (1974)» y a «Stigler (1971)» indistintamente; «el simple contacto… crea relaciones personales» | Bernstein (1955, ciclo de vida) → Stigler (1971, teoría económica) → Posner (1974, clasificación) → Peltzman (1976); mecanismos de la captura en vez del trato personal (II.5) |
| 2.1.2 y nota 33 | Olson «(1992)» | 1965 |
| 4.2 | «entre el 7 % y el 50 % del PNB (Mueller, 2013)» | Mueller (2003), §15.6, pp. 355-358: 7,3 % (Krueger, India 1964) y 30-45 % (Mohammad y Whalley, India 1980-81); el 50 % sale (sin fuente) |
| 4.3.1 | Los mercados impugnables nacen «en el seno de la Nueva Teoría de la Regulación» | Vienen de la organización industrial (Baumol, Panzar y Willig, 1982) (III.2 y trampa del test) |
| Nota 38 | ECPR: el precio de acceso no puede superar el precio final menos «el coste marginal de la empresa integrada» | Menos el coste del incumbente en el **resto del servicio**, $c_I$: $A\leq p-c_I$ (III.3) |
| 5.2.3 | Propiedad compartida del «componente **competitivo**» | Del componente **no** competitivo (OCDE, 2001, p. 13) |
| 5.2.3 | «Desintegración operativa/funcional» | Separación **operativa**; la **funcional** es otra, más débil (lista de formas débiles) |
| 5.2.3 | En las actividades con economías de red «no se da ese *trade-off*: solo hay ineficiencia asignativa» | El poder de mercado viene de las economías de escala **y también** de las de red (OCDE, 2001) |
| 5.2.3 (CLH) | «Forman parte de su accionariado Cepsa y BP (y, hasta 2015, también Repsol)» | Exolum, sin petroleras desde enero de 2016 (ver Datos) |
| 5.2.3 (Telefónica) | «Todas las operadoras tienen acceso al cableado de Telefónica tras el pago de un canon» | Solo sigue regulado el acceso a conductos y postes (MARCo); NEBA desregulado en 2025 |
| Enganche | Cita de Kahn: «El objetivo central de la regulación **moderna**…» | Traducción fiel: Kahn habla de la tarea «central y permanente» de legisladores y reguladores (1988, vol. I, p. xxxvii); va en la opinión de la conclusión |
| Anexo 3 | Baldwin, Cave y Lodge «(2013)» | 2012, 2.ª ed., cap. 3, pp. 25-39 |
| Nota 11 | Weitzman, *Prices vs. Quantities* «(2019)» | 1974, *Review of Economic Studies* 41(4) |
| 1.1 | Pareto, «*Manual de Política Económica*» | *Manuale di economia politica* (1906) |
| Nota 2 | «Kevin» Lancaster | Kelvin Lancaster (1966) |
| 1.2.2 | «Elinor Ostrom (1977) propuso la siguiente clasificación» | V. Ostrom y E. Ostrom (1977) |
| Nota 10 | Impuesto pigouviano con «$\max_{\{t\}}$» | La empresa elige $q$; el regulador fija $t^{*}=\mathrm{CMgE}(q^{*})$ |
| Nota 31 | «Ilusión de la deuda de Niskanen» | Ilusión fiscal de Puviani (1903) y Buchanan y Wagner (1977); Niskanen es el de la burocracia |
| Nota 27 | «Nordhaus saca la teoría del ciclo electoral de Kalecki» | Kalecki (1943) es un precedente |
| 2.1.1 d) y comentario | Experimento de 2010 del MIT; bienes «pozo, alcantarillado, alumbrado» | Olken (2010, *APSR*): el trabajo de campo es de 2005-2006 y los proyectos, carreteras y puentes, regadío y agua potable |
| Fuente de la imagen 2 | «Sahquillo (2017)» | Sahuquillo (2017) |
| Caja de Edgeworth de Coase (F3) | Curvas «trasladadas horizontalmente», curva de contrato horizontal | No se dibuja: depende de los ejes; el 3.A.23 la tiene con la externalidad en abscisas (curva de contrato vertical) |
| URL del RDL 7/2006 en las propuestas | `BOE-A-2006-11257` (una resolución de Loterías) | `BOE-A-2006-11285` |
| ISBN de Baldwin, Cave y Lodge en las propuestas | 978-0-19-957608-**6** | 978-0-19-957608-**1** |

### De las referencias de ayer (no heredados)

| Dónde (referencia) | Qué decía | Qué dice el tema |
|---|---|---|
| Tebar 2.2 | Monopolio natural «fuerte/débil»; en el tramo de deseconomías, «CMg < CMe» | Sostenible / no sostenible (3.A.17); con CMe creciente, CMg > CMe (I.3) |
| Tebar 3.2 | Ramsey con elasticidades cruzadas sin el margen del otro bien | Solo el caso de demandas independientes, \eqref{eq:ramsey-boiteux}, con remisión al 3.A.17 |
| Tebar 3 | «Precios óptimos de 1.er/2.º orden» | Primer, segundos y terceros óptimos, con nota (I.3) |
| Tebar 4.1 | La tasa de rentabilidad responde a «no conocer la demanda»; «p = CMe» | Responde a no conocer los costes eficientes; cubre costes de operación más s sobre la base de activos (II.1) |
| Tebar 4.2 | ψ'(e) = q con información completa | ψ'(e*) = 1 con proyecto de tamaño dado; ψ'(e) = q solo con C = (β − e)q (anexo) |
| Tebar 4.2 | IC con el esfuerzo donde va el coste | Forma reducida con Φ(e) = ψ(e) − ψ(e − Δβ) (II.3 y anexo) |
| Tebar 4.2 | Contrato de la ineficiente «b = 0 y a = 0» | a tiene que cubrir ψ(ē) (8,1 en el ejemplo; nota de II.3) |
| Tebar 4.2 | Probabilidad «p» del tipo eficiente | ν (canon) |
| Cabado 18.3 | TR = a + b(C − C^a), b = 0 precio fijo | t(C) = a − b(C − C^a), b = 1 precio fijo, b → 0 coste incrementado |
| Tebar 5.1 | *Yardstick* en la generación eléctrica | En las redes de distribución (III.1) |
| Tebar 6 | Guardianes de la DMA = «GAFAM» | 7 guardianes (Alphabet, Amazon, Apple, ByteDance, Meta, Microsoft y Booking), 23 servicios |
| Tebar 6 | «Los WhatsApp llegan a Telegram» | Interoperabilidad gratuita de las funciones básicas, a petición de otro proveedor (art. 7) |
| Tebar 2.1 | 40 % «para posición dominante»; 30 % sin norma | 50 % presunción (AKZO), por debajo del 40 % improbable (Directrices de 2026); 30 % del Reglamento 2022/720 |
| Tebar 4.3 | Reparto de beneficios de la telefónica de Florida | Quitado (sin fuente) |
| Tebar 4.3 | *Price cap* de «las llamadas telefónicas» en España | Cuota de abono de Telefónica hasta 2012 |
| Tebar 4.3 | Valor de la información mal explicado | Con ν mayor se distorsiona más a la ineficiente y baja Φ(ē) (II.3) |

## Marcas resueltas

Marcas del Word (lista P de `_trabajo/pendientes.md`; figuras F1-F18 y notas al pie 1-40):

- **P1-P2** (encaje y títulos): decisión de Víctor del 23/10/2026: estructura del 3.A.20 de ayer y,
  dentro, el Word; los títulos de primer nivel siguen el título oficial.
- **P3** (amarillo, portada: «De este modo… muy lejos de estar actualizado») y el enganche en
  amarillo del PDF de 2023 («La vida política de un país gira…»): aviso de cambio de temario; no
  se publica ni se recupera.
- **P4** (amarillo, frases sin terminar de selección adversa y riesgo moral): completadas en el anexo
  (`anexo:otros-fallos`, información asimétrica, con Akerlof).
- **P5** (amarillo, «Ver tema ICEX-CECO…»): nota de trabajo; su contenido lo cubre todo el bloque II.
- **P6** (amarillo, «Stigler» en la bibliografía): Stigler (1971), *Bell Journal* 2(1), 3-21
  (`Stigler1971Theory`).
- **P7** (amarillo, nota 22 y su fuente): la nota se conserva en el anexo (información incompleta
  simétrica, seguros), con las 3 razones y la fuente «Internet Chapter Two: Uncertainty, Asymmetric
  Information, and Market Failure» citada con la copia del Internet Archive (`ICUncertainty2002`,
  sin autor: ver Dudas).
- **P8** (`[\ ]` vacío tras la estructura): ignorado.
- **P9** (texto rojo, caja «Modelo de Tirole y Laffont (1986)», «comodín»): la nota roja no se
  publica; el contenido entra en II.3 a) Idea (agencia, selección adversa y riesgo moral,
  eficiencia frente a rentas, reparto del riesgo).
- **P10** (notas al opositor de la portada y ficha ICEX, F1): no se publican.
- **P11** (Laffont-Tirole, *cost plus* y *fixed price*, enlace de UBS): ya en II.3 c); el enlace
  funciona y va a una caja de anotaciones al final de II.3.
- **P12** (ProMarket y Stigler Center): caja de anotaciones en II.5, junto con la nota 35 (CADEP,
  con la copia archivada).
- **P13** (Baldwin, Cave y Lodge, cap. 2 y tabla 2.1): «¿Por qué regular?» en I.1 y tabla
  `tab:motivos-regulacion` (F2), traducida, con las filas de poder de mercado en salmón.
- **P14** («no hay que mencionar otros fallos»): una línea en I.1 con `\vertema{3.A.23}` y
  `\vertema{3.A.13}`, y el anexo.
- **P15** («Coordinar en temas 3.A.23 y 3.A.25»): hecho al escribir el anexo (comprobado contra
  `3A23.tex`; solo se resume y se remite); no se publica.
- **P16** («Baldwin, Cave y Lodge, pág. 500 y ss.», *yardstick*): cita del cap. 26 (pp. 492-504)
  en III.1.
- **P17** (comentario del MIT): Olken (2010) en el anexo, con el enlace de DSpace en la bibliografía
  y en la caja «Para ampliar».
- **P18** (comentario de VoxEU): Levinson (2009, columna) y Levinson (2012, artículo) en el anexo.
- **P19** (comentario de Katalepsis): en la caja «Para ampliar» del anexo; la ilusión fiscal se
  atribuye a Puviani y a Buchanan y Wagner.
- **P20** (comentario de Wikipedia sobre CLH): dato actualizado con la web de Exolum (ver Datos).
- **P21-P26** (epígrafes del título): cubiertos por la estructura de ayer.
- **P27** (mercados impugnables, 633 palabras): resumidos en III.2 con los 3 supuestos del 3.A.15,
  sus 2 aportaciones y sus 2 críticas, y remisión.
- **P28** (4.4, 5 títulos vacíos): escritos en el anexo (`anexo:cuasi-competitivos`).
- **P29** (conclusión vacía): se mantiene la de ayer, con Kahn en la opinión y la economía
  conductual en las extensiones. La recapitulación del Word («desde que nacemos hasta que
  morimos…») no pasa: es genérica y de economía pública.
- **P30** (enganche de Kahn): a la opinión (C16), entre comillas con traducción fiel.
- **P31-P34** (remisiones y canon): ver «Coherencia».
- **P35-P37** (fuentes y datos): ver «Errores corregidos», «Datos actualizados» y «Dudas».
- **P38-P42** (lo de ayer, `_trabajo/sin-original/`): se conservan los datos verificados V1-V27, el
  canon y la coherencia (C1-C9, K27, fichas nuevas), el contenido redactado (I.1-III.4 y anexos) y
  los 9 gráficos de ayer; `algoritmo-regulacion` se sustituye por el de Víctor. La estructura se
  atribuye ahora al Word de Víctor (adaptada al título nuevo por su decisión) y no a Tebar, cuyo
  tema solo sirvió de contraste.
- **P43** (preguntas de otros exámenes): añadidas al anexo de test, reescritas (el texto del
  paternalismo libertario del Word venía de Wikipedia y no se copia); «optimin optimout» se lee
  como *opt-in*/*opt-out* (ver Dudas). La de Akerlof la cubre el 3.A.13.
- **P44** (quia.com): sustituido por el enlace único al simulador.
- **P45** (notas al pie): ver la lista siguiente.
- **Figuras**: F1 no se publica; F2 → tabla LaTeX; F3 (Edgeworth de Coase), F4 (*cap and trade*) y
  F5 (rivalidad y exclusión) no se reproducen, porque el 3.A.23 los tiene (se citan sus fuentes:
  Energía y Sociedad, Sahuquillo); F6 es la fuente de F7; F7 → `algoritmo-regulacion` (el de
  Víctor); F8 → `subaditividad-sostenibilidad` (del 3.A.17); F9, duplicado de F7; F10 →
  `ciclo-politico` (inflación y paro en el tiempo, como el original; figura del anexo); F11 → `niskanen` (del
  3.A.23, en una nota, a 0,35 del ancho); F12 → `leviatan.jpeg` (dominio público, British Library); F13-F17 →
  `separacion-vertical` (6 paneles); F18 → $t(C)=a-b(C-C^a)$ y $p=bF+(1-b)C$ (ya estaban) y la
  senda $p_t=p_0(1+\mathrm{IPC}-X)^t$ (II.4).
- **Notas al pie del Word**:
  - 1, 2, 3, 5, 7, 8: anexo, historia del bienestar (corregidas: Lancaster, Pareto). La 7 (ofelimidad)
    conserva su fuente del Word, Wikipedia («Ofelimidad», responde el 23/10/2026), y añade Pareto (1906)
    como fuente primaria.
  - 4: nota de «¿Por qué regular?» (I.1).
  - 6: nota del Nobel de Tirole en la introducción (Laffont murió en 2004, TSE).
  - 9 (vacía): era la cita de Laffont y Tirole; resuelta con 1986/1993.
  - 10, 13, 14: notas de las externalidades en el anexo (10 corregida).
  - 11: Weitzman (1974) en el texto del anexo.
  - 12: Nobel de Coase (1991), en la nota de Coase.
  - 15, 16: definiciones de rivalidad y exclusión, en la frase de Ostrom y Ostrom.
  - 17: nota de la rivalidad relativa.
  - 18: remisión interna; ya no hace falta.
  - 19: vídeo de la UFM, en «Para ampliar».
  - 20 (definición de «coactivo» del DRAE): no se conserva (la financiación de los bienes públicos
    está en el 3.A.23).
  - 21: nota de Törbel, con Ostrom (1990, pp. 61-65), Netting (1981) y Muñoz Moldes (2018) como en
    el original.
  - 22: nota de la información incompleta (P7).
  - 23, 24: nota de Hayek.
  - 25: Nobel de Buchanan (1986), en el texto.
  - 26: pasa al texto del anexo, con el gráfico `ciclo-politico` como figura junto a su párrafo
    (en nota dejaba media página en blanco).
  - 27: corregida (Kalecki, precedente).
  - 28: nota de Niskanen con su gráfico.
  - 29: nota del Leviatán con el grabado.
  - 30: nota de los países nórdicos («se suele citar»; ver Dudas).
  - 31: nota de la ilusión de la deuda (corregida).
  - 32: en el texto de la búsqueda de rentas (II.5).
  - 33: nota de Olson, con Rodríguez Braun «según recoge» Libertad Digital.
  - 34: nota de cómo medir la productividad (el juez), en las soluciones del anexo.
  - 35: CADEP en la caja de la captura.
  - 36: nota del avión en III.3, sin la cifra de 700 € ni el piano (ver Dudas).
  - 37: en el cuerpo (los CTC) y la norma en la nota.
  - 38: nota del ejemplo de telefonía en la ECPR (corregida).
  - 39: nota de la separación operativa.
  - 40: nota de la circularidad en los criterios de buena regulación.
- **Anexo 1 del Word** (correo de un preparador): no se publica; su idea útil (separar regulación por
  eficiencia y por equidad; Baldwin, Cave y Lodge como visión amplia) está en I.1.
- **Anexo 2** (liberalización y desregulación): fundido en III.3.
- **Anexo 3** (5 criterios de Baldwin, Cave y Lodge): `anexo:buena-regulacion`.
- **Bibliografía del Word**: las valoraciones («manifiestamente mejorables», «Bastante bien…») no se
  publican; las obras sí: Den Hertog (2000 y 2010) en II.5, Stiglitz (2000) en el anexo, Viscusi,
  Harrington y Vernon (2005) con `\nocite`, papeles42 de la UMA en I.3, Baldwin, Cave y Lodge
  (2012) en I.1, III.1 y el anexo, y Stigler (1971).

## Datos actualizados

### Del Word (23/10/2026)

| Dato | Valor anterior (Word) | Valor nuevo | Fuente | URL | Consulta | Segunda comprobación |
|---|---|---|---|---|---|---|
| Accionariado de CLH | Cepsa y BP (Repsol hasta 2015) | Exolum, sin petroleras desde enero de 2016; el mayor accionista, CVC, con el 24,84 % (no se suman en el texto los 2 paquetes de Stoneshield, 19,59 % y 4,93 %, porque su nota de mayo de 2026 habla de «alrededor del 20 %») | Exolum (`Exolum2026Capital`); Alimarket (`Alimarket2016BP`) | https://exolum.com/en/shareholders-and-investors/distribution-of-share-capital/ | 23/10/2026 | Alimarket, 21/01/2026 (cuadra). **Aviso**: CVC busca comprador para su 24,84 % (elEconomista, 9/2026, sin fuente primaria): no va al texto; revisar antes de publicar |
| Nombre | CLH | Exolum desde 2021 (CAMPSA 1927 → CLH 1993) | Exolum (`Exolum2026Historia`) | https://exolum.com/en/about-exolum/history/ | 23/10/2026 | Wikipedia y Alimarket |
| Límites al capital de CLH | — | Nadie más del 25 %; las refinadoras, juntas, no más del 45 % (RDL 6/2000, art. 1) | BOE (`BOE2000RDL6`) | https://www.boe.es/buscar/act.php?id=BOE-A-2000-11836 | 23/10/2026 | Web de Exolum |
| Acceso a oleoductos | — | Acceso negociado de terceros, no discriminatorio y con precios públicos supervisados por la CNMC (Ley 34/1998, art. 41) | BOE (`BOE1998LH`) | https://www.boe.es/buscar/act.php?id=BOE-A-1998-23284 | 23/10/2026 | La propia norma |
| ADIF-Renfe | Sin fecha ni norma | Ley 39/2003, en vigor el 31/12/2004 (plazo del RDL 1/2004); la Ley 38/2015 mantiene el modelo | BOE (`BOE2003LSF`, `BOE2004RDL1`, `BOE2015LSF`) | https://www.boe.es/buscar/doc.php?id=BOE-A-2003-20978 | 23/10/2026 | RDL 1/2004 |
| Competencia en la alta velocidad | — | Ouigo desde 2021, Iryo desde finales de 2022 | CNMC (`CNMC2025BalanceLiberalizacion`) | https://www.cnmc.es/sites/default/files/6148400.pdf | 23/10/2026 | Hosteltur (Iryo, 25/11/2022) |
| Cuotas y precios (2025) | — | Renfe, 50-67 % en los corredores con competencia; precios reales ≈ −40 % desde 2019; cánones, 46 % de los costes en el Madrid-Barcelona | CNMC, informe anual 2025 (`CNMC2026InformeFerroviario2025`) | https://www.cnmc.es/prensa/inf-anual-ferro-25-20260717 | 23/10/2026 | Nota del 4T-2025 (Madrid-Barcelona: Renfe 56 %, Iryo 24 %, Ouigo 19 %) |
| Aena | «Propietaria de los aeropuertos» | 46 aeropuertos; ENAIRE tiene el 51 % | ENAIRE (`ENAIRE2025PlanActuacion2026`) | enaire.es (Plan de actuación 2026) | 23/10/2026 | Informe de gestión 2025 de ENAIRE |
| Telefónica | Acceso al cableado con canon | Solo regulado el acceso a conductos y postes (MARCo); oferta de compromisos en consulta desde el 30/06/2026, sin resolver a 23/10/2026 | CNMC (`CNMC2025Desregulacion`, `CNMC2026CompromisosTelefonica`) | https://www.cnmc.es/prensa/consulta-compromisos-telefonica-20260630 | 23/10/2026 | Nota de 13/08/2025 |
| CTC | Sin norma ni cuantía | Ley 54/1997: tope de 1.988.561 M pta (≈ 11.951 M€, a 166,386), 10 años como máximo, pagados por todos los consumidores; suprimidos por el RDL 7/2006 | BOE (`BOE1997LSE`, `BOE1997RD2017`, `BOE2006RDL7`) | https://www.boe.es/buscar/doc.php?id=BOE-A-2006-11285 | 23/10/2026 | RD 2017/1997, art. 12 (mismo tope) |
| Desregulación de EE. UU. | «Carter y Reagan» | Airline Deregulation Act, Pub. L. 95-504 (24/10/1978); Kahn presidió la CAB en 1977-1978 | govinfo (`USC1978AirlineDeregulation`); `JoskowNoll2012Kahn` | https://www.govinfo.gov/content/pkg/STATUTE-92/pdf/STATUTE-92-Pg1705.pdf | 23/10/2026 | Joskow y Noll (2012). Motor Carrier Act (Pub. L. 96-296, 1/07/1980) y Staggers Rail Act (Pub. L. 96-448, 14/10/1980), leídas en govinfo (`USC1980MotorCarrier`, `USC1980StaggersRail`) |
| Vuelo Madrid-Londres | 700 € ≈ salario medio | Sin cifra (no hay fuente) | — | — | 23/10/2026 | — |
| Muerte de Laffont | 2004 | 1/05/2004 | TSE (`TSE2024Laffont`) | https://www.tse-fr.eu/remembering-jean-jacques-laffont-celebrating-his-life-work-and-legacy | 23/10/2026 | Maskin (2004) |
| Coste de la búsqueda de rentas | 7-50 % del PNB | 7,3 % (India, 1964) y 30-45 % (India, 1980-81) | Mueller (2003, §15.6), Krueger (1974), Mohammad y Whalley (1984) | — | 23/10/2026 | Econlib (Krueger) y RePEc (Mohammad-Whalley) |

### Del primer borrador (22/10/2026)

| Dato | Valor anterior (referencias) | Valor nuevo | Fuente | URL | Consulta | Segunda comprobación |
|---|---|---|---|---|---|---|
| Comunicación de definición de mercado | no citada | C/2024/1645, DO C de 22/2/2024; sustituye a la de 1997 (punto 116) | Comisión Europea | https://eur-lex.europa.eu/eli/C/2024/1645/oj | 22/10/2026 | CMS y Gibson Dunn |
| SSNIP | 5-10 % (3.A.18) | 5-10 %, «pequeño, pero significativo y no transitorio» (punto 29, nota 53) | Comisión Europea | ídem | 22/10/2026 | Comunicación de 1997, punto 17 |
| SSNDQ y plataformas | «desde Google Android», sin cita | Punto 30, nota 54 (Google Android); puntos 94-98 | Comisión Europea | ídem | 22/10/2026 | Noerr, Mondaq |
| Falacia del celofán | — | Nota 55; du Pont, 351 U.S. 377 (1956) | Comisión Europea | ídem | 22/10/2026 | Tirole (1988) |
| Umbrales de dominancia | 40 % | ≥ 50 % presunción (AKZO); < 40 % improbable (punto 24) | Directrices art. 102, C(2026) 6118 | página de la Comisión | 22/10/2026 | Página del art. 102 (retirada de la Orientación de 2009) |
| Acuerdos verticales | 30 % sin norma | 30 % (art. 3 del Reglamento 2022/720) | DOUE | https://eur-lex.europa.eu/eli/reg/2022/720/oj | 22/10/2026 | Considerandos 8-9 |
| *De minimis* | — | 10 % entre competidores, 15 % entre no competidores (puntos 8-9) | Comunicación 2014/C 291/01 | EUR-Lex | 22/10/2026 | Una sola lectura |
| IHH de concentraciones | — | < 1.000; 1.000-2.000 y Δ < 250; > 2.000 y Δ < 150 (apdos. 19-20); revisión prevista para el 4.º trimestre de 2026 | Directrices de 2004 | EUR-Lex | 22/10/2026 | 3.A.15 (V2) |
| Tasa de retribución eléctrica | Cabado, sin fecha | 6,58 % en 2026-2031 (antes 5,58 %) | Circular 9/2025, BOE-A-2025-27019 | https://www.boe.es/diario_boe/txt.php?id=BOE-A-2025-27019 | 22/10/2026 | Nota de prensa de la CNMC de 22/12/2025 |
| Tasa de retribución gasista | — | 6,46 % en 2027-2032 (transporte y regasificación) | Circular 5/2026, BOE-A-2026-19426 | https://www.boe.es/diario_boe/txt.php?id=BOE-A-2026-19426 | 22/10/2026 | Nota de prensa de la CNMC |
| DORA 2027-2031 | Aena, sin datos | IMAP 10,52 € (2026) → 10,69 € (2031); X = +0,33 % (se suma); CNMC −0,59 %, Aena +3,82 % | BOE-A-2026-19507; informe de la CNMC | https://www.boe.es/diario_boe/txt.php?id=BOE-A-2026-19507 | 22/10/2026 | Nota del Ministerio de 15/9/2026 |
| Cánones de ADIF | sin norma | Coste directamente imputable más recargos «si el mercado puede aceptarlo» | Ley 38/2015 | https://www.boe.es/buscar/act.php?id=BOE-A-2015-10440 | 22/10/2026 | Directiva 2012/34/UE, arts. 31-32 |
| RIIO-3 | sin periodo | Abril de 2026-marzo de 2031; rentabilidad de los fondos propios del 5,70 % (electricidad) y del 6,12 % (gas), reales; eficiencia del 1 % anual | Ofgem, Final Determinations (4/12/2025) | ofgem.gov.uk (anexo financiero y ET) | 22/10/2026 | Ashurst, Oxera |
| Excepción ibérica | — | Desde el 14/6/2022, 40 €/MWh con senda creciente; prorrogada hasta el 31/12/2023 | RDL 10/2022 (BOE-A-2022-7843), Orden TED/517/2022, RDL 3/2023 (BOE-A-2023-7937) | boe.es | 22/10/2026 | Informe de la CNMC, GA_P |
| Telecomunicaciones | — | Recomendación 2020/2245: 2 mercados mayoristas (acceso local fijo y capacidad dedicada) | DOUE L 439 | https://eur-lex.europa.eu/eli/reco/2020/2245/oj | 22/10/2026 | Comunicación de 2024, nota 36 |
| Desregulación de NEBA | — | Desde octubre de 2021 solo el 30 % de la población; retirada el 13/8/2025 con 6 meses de transición; se mantiene la infraestructura física | Nota de prensa de la CNMC | https://cnmc.es/prensa/desregulacion-banda-ancha-fija-20250813 | 22/10/2026 (leída por el editor) | Propuesta de contenido C18 |
| DMA, guardianes | «GAFAM» | 7 guardianes y 23 servicios | Comisión, portal DMA | https://digital-markets-act.ec.europa.eu/gatekeepers-portal_en | 22/10/2026 | Comunicado de 6/9/2023 (SEAE) |
| DMA, umbrales y multas | — | 7.500 / 75.000 millones, 45 millones de usuarios y 10.000 profesionales; 10 % y 20 % | Reglamento 2022/1925 | https://eur-lex.europa.eu/eli/reg/2022/1925/oj | 22/10/2026 | eu-digital-markets-act.com |
| Multas de la DMA | — | Apple 500 M€ y Meta 200 M€ (23/4/2025); Google 890 M€ (23/7/2026) | Comisión Europea | digital-markets-act.ec.europa.eu | 22/10/2026 | Brussels Times; Concurrences |
| Google Shopping y Android | — | 2.424 M€ (TJUE, 10/9/2024) y 4.125 M€ (TJUE, 2/7/2026); mismas cifras y claves que el 3.A.15 | TJUE | curia.europa.eu | 22/10/2026 | 3.A.15 |
| Nobel de Tirole | — | 2014, «por su análisis del poder de mercado y la regulación» | nobelprize.org | https://www.nobelprize.org/prizes/economic-sciences/2014/press-release/ | 22/10/2026 | 3.A.13, 3.A.15 |
| Autor *et al.* (2020) | sin páginas | *QJE* 135(2), 645-709 | Harvard, LSE | — | 22/10/2026 | RePEc |
| Guasch, Laffont y Straub (2008) | — | 307 concesiones de agua y transporte en América Latina, 1989-2000; alta incidencia de renegociaciones | *IJIO* 26(2), 421-442 | https://ideas.repec.org/a/eee/indorg/v26y2008i2p421-442.html | 22/10/2026 (leído por el editor) | — |

## Contenido añadido

### Segunda vuelta (23/10/2026): el Word de Víctor

Propuestas de contenido C1-C21 (`_trabajo/propuestas-contenido.md`), **todas aplicadas**, con estos
cambios:

- **C1** (minutos y notas): aplicada; III.3 sube a 2′30″ y III.4 baja a 1′30″; el esquema y las 3
  notas al opositor, al día. El título de III.2 pasa a «Competencia por el mercado e
  impugnabilidad», como en el esquema.
- **C2** (¿Por qué regular?, tabla 2.1): aplicada. La fuente de la tabla dice «cap. 2, tabla 2.1»
  sin página (no se ha podido ver el libro).
- **C3** (algoritmo de Víctor): aplicada; gráfico rehecho. La fuente no da el número de figura de
  Braeutigam (23.6 sin comprobar).
- **C4** (subaditividad y dilema en 3 pasos) y **C5** (primer óptimo con beneficios o pérdidas):
  aplicadas.
- **C6** (nota de Laffont): aplicada, con la cita de la TSE (D14).
- **C7** (caja de Laffont-Tirole y UBS): aplicada; la frase «entre un principal (el regulador) y un
  agente (la empresa)» se reescribió porque coincidía con Cabado.
- **C8** (senda del *price cap*): aplicada.
- **C9** (captura y búsqueda de rentas): aplicada, con 4 cambios: la nota de Mueller lleva las
  cifras comprobadas (7,3 % y 30-45 %; fuera «cerca de la mitad del PNB»); la nota de Olson
  conserva a Rodríguez Braun «según recoge» Libertad Digital; se cita a Den Hertog (2000, 2010) al
  presentar la teoría positiva; y la caja de anotaciones añade el CADEP (nota 35). Los motivos de
  la captura van en viñetas. Becker no se canta.
- **C10** (*yardstick* en Baldwin, Cave y Lodge, cap. 26): aplicada.
- **C11** (mercados impugnables): aplicada al final de III.2.
- **C12** (liberalización, CTC, problemas del regulador): aplicada; la nota de los CTC con los
  datos de D11 y Kahn al frente de la CAB (D12); la nota del avión, sin cifras.
- **C13** (ECPR como techo y la nota 38): aplicada.
- **C14** (6 formas de separación): aplicada, con los datos D1-D10 (Telefónica/MARCo, ADIF-Renfe con
  Ouigo, Iryo y las cuotas de 2025, Aena y ENAIRE, Exolum con sus límites legales y el acceso de
  terceros). La lista de formas débiles cita también a Armstrong, Cowan y Vickers (1994), que ya
  la sostenía ayer.
- **C15** (recortes de III.4): aplicada; el ítem de los cánones de ADIF sale de III.4 (está en I.3) y
  el párrafo pasa a «Redes eléctricas y gasistas en España».
- **C16** (Kahn y extensiones): aplicada; la cita va **entre comillas** con traducción fiel y página
  (vol. I, p. xxxvii; F1).
- **C17** (anexo nuevo): aplicado, con estos añadidos pedidos por Víctor: Olken (2010) con los
  proyectos correctos; Levinson (2009, columna; 2012, artículo) y la economía de la felicidad;
  Muñoz Moldes (2018) como en el original junto a Ostrom (1990, pp. 61-65) y Netting (1981);
  Atkinson y Stiglitz (lección 10, pp. 259-263) y Mueller (2003, §16.4.2, p. 370) para la aversión
  al riesgo; Weber (1922) y Niskanen (1971) con la nota 28 y su gráfico; los Nobel de Buchanan,
  Coase y Ostrom; Stiglitz (2000, caps. 4 y 5); la nota 34; y una caja «Para ampliar» con los
  enlaces del Word (DSpace del MIT, VoxEU, UFM, Energía y Sociedad, Katalepsis).
- **C18** (test y tribunal): aplicada; la pregunta del *opt-in*/*opt-out* va aparte, con Johnson y
  Goldstein (2003) y Madrian y Shea (2001); la de cómo se evalúa una regulación va sin la cita del
  cap. 15 de Baldwin, Cave y Lodge (no comprobada); se añade la trampa de los mercados impugnables.
- **C19** (errores ya resueltos) y **C20** (recortes R1-R6): aplicadas (R6: nueva pregunta en la
  problemática y la estructura con las industrias de red).
- **C21** (bibliografía): aplicada; 73 entradas nuevas en `3A20.bib`, sin claves repetidas. Cambios:
  papeles42 con la clave `UMA2006Regulacion` y **sin autor** (Universidad de Málaga como
  organización); `ICUncertainty2002` sin autor; `Levinson2009Happiness` con el título de la copia
  archivada («Valuing Public Goods Using Happiness Surveys») y la URL del Word; `Olken2010Direct` con
  el enlace de DSpace; Baldwin, Cave y Lodge con ISBN 978-0-19-957608-1 y DOI.

Propuestas de datos D1-D14 y fuentes F1-F26 (`_trabajo/propuestas-datos.md`): aplicadas, salvo
D13 (sin cifra, a Dudas) y el aviso de la venta del paquete de CVC (fuera del texto). F2 (Den
Hertog), F3 (papeles42), F4 (Internet Chapter Two), F5 (Muñoz Moldes), F20 (Rodríguez Braun), F21
(Atkinson y Stiglitz) y F26 (nota 30) van como pidió Víctor, con sus cautelas en Dudas.

Gráficos (`_trabajo/graficos-pedidos.json`): `algoritmo-regulacion` (sustituido por el de
Víctor), `separacion-vertical` (nuevo), `ciclo-politico` (nuevo, en nota), `subaditividad-sostenibilidad`
(del 3.A.17), `niskanen` (del 3.A.23, en nota) y `leviatan.jpeg` (imagen).

### Primer borrador (22/10/2026)

Lo de ayer se conserva (propuestas C1-C33, V1-V27 y K1-K34 de `_trabajo/sin-original/`): el
mercado relevante (pérdida crítica, celofán, SSNDQ, Comunicación de 2024), Baron-Myerson como
modelo propio, Peltzman con su gráfico (anexo), la escala de la potencia, la ECPR con
Armstrong-Doyle-Vickers, las aplicaciones de 2025-2026 (tasas de la CNMC, DORA, RIIO-3, NEBA, DMA)
y los anexos de derivaciones, mercado relevante, Peltzman, marco normativo, bloque y test. La tabla
de instrumentos (idea de la tabla 18.1 de Manuel Cabado, rehecha con otra organización) se cita
como elaboración propia.

## Coherencia

- **Anexo nuevo y 3.A.23**: comprobado contra `fuentes/3A23/3A23.tex`. El anexo solo resume las
  externalidades, los bienes públicos y comunes, la información asimétrica y los fallos del sector
  público, con `\vertema{3.A.23}` (y `\vertema{3.A.22}`, `\vertema{3.A.13}`, `\vertema{3.A.24}`,
  `\vertema{3.A.39}`, `\vertema{4.B.2}`, `\vertema{4.B.15}`) en cada bloque, y conserva lo que el
  3.A.23 no tiene: la aversión al riesgo de los burócratas (Atkinson y Stiglitz; Mueller), el
  gráfico del ciclo político, el Leviatán de Hobbes con el grabado, la nota de los países
  nórdicos, la nota 34, los mecanismos cuasi-competitivos y los 5 criterios de Baldwin, Cave y
  Lodge. Mismas claves que el 3.A.23 para las fuentes compartidas (Olken, Levinson, Ostrom,
  Netting, Puviani, Buchanan-Wagner, Weitzman, Coase, Hardin, ProMarket, Stigler Center). El 3.A.23
  podría recoger en su `--fase coherencia` la aversión al riesgo y el gráfico del ciclo político
  (opcional; no se toca ahora). Ojo: `3A23.bib` da a `Levinson2009Happiness` otro título y otra URL;
  aquí va el título de la copia archivada de la columna.
- **Impugnables**: los 3 supuestos con las mismas palabras que el 3.A.15 (ficha `mercados-impugnables`).
- **Subaditividad**: el mismo gráfico que el 3.A.17.
- **Algoritmo**: «primer/segundo/tercer óptimo», como la nota de I.3 y el 3.A.17.
- **`mapa.yaml`** (P34): conviene cambiar la nota del 3.A.20 («revisado sin original») por
  `fuente_disponible: otro-titulo`, con la ruta del Word antiguo 3.A.25 (no se toca ahora).
- Lo de ayer sigue en pie:

- **Supuestos**: tabla del 1TFEB con la misma numeración que el 3.A.22 y el 3.A.23 (el 3 es la
  precio-aceptación y el 5, la información).
- **Notación**: la del canon.
  - 𝓛 es el índice de Lerner, así que ningún problema se escribe con lagrangiana.
  - IHH ≡ Σ(100 s_i)² ∈ (0; 10.000].
  - w_K, s y μ en Averch-Johnson, con nota de que s no es la cuota s_i.
  - β̲, β̄, ν, Φ y λ en Laffont-Tirole, con la nota de la λ común con Ramsey; b = 1 es el precio
    fijo; p_{t+1} ≤ p_t(1 + IPC_t − X).
  - Letras nuevas locales, que hay que proponer al canon (C31): S(q), α (Baron-Myerson),
    𝒜 (Peltzman), A, c_a, c_I, c_E y d (acceso), τ y ℓ^c (pérdida crítica).
- **Promesas de otros temas que se cumplen aquí**:
  - 3.A.12: el *yardstick* con DEA y frontera estocástica y el regulador alemán.
  - 3.A.15: competencia por el mercado, acceso y mercados de 2 lados, con las mismas palabras y
    claves.
  - 3.A.16 y 3.A.17: monopolio natural resumido.
  - 3.A.18: el SSNIP «entre un 5 y un 10 % … no transitoria».
  - 3.A.19: el IHH y Cowling-Waterson.
  - 3.A.22: *second best* y monopolio contaminante.
  - 3.A.23: menú de contratos, Peltzman y captura, sin su refrán.
- **Cambios que esto pide en otros temas** (no se tocan ahora; las entradas están en
  `canon/pendientes-coherencia.md`, texto listo en `_trabajo/propuestas-coherencia.md`, C8):
  - **3.A.13**: las 4 remisiones de Laffont-Tirole y de la regulación con información asimétrica
    (relevancia, selección adversa, riesgo moral y conclusión) pasan de `\vertema{3.A.17}` a
    `\vertema{3.A.20}`; en la relevancia y en la conclusión pueden quedar las 2.
  - **3.A.14**: la regulación como diseño de mecanismos (l. 1089 y 1150) pasa a
    `\vertema{3.A.20}`.
  - **3.A.17, anexo A**:
    - `anexo:nueva-teoria-regulacion` se resume en una viñeta por instrumento, con
      `\vertema{3.A.20}`.
    - Se quitan `fig:averch-johnson` y `anexo:aj`, que ahora están aquí con la misma etiqueta.
    - La teoría positiva pasa a 2 viñetas, y la anotación de ProMarket y Stigler Center se puede
      mover aquí.
    - La notaopositor de la l. 1126 pasa de «se desarrollan» a «se resumen».
  - **3.A.12** (l. 1132): basta `\vertema{3.A.20}` para el *yardstick* (opcional).
  - **3.A.22**: la fila 3 de la tabla del 1TFEB puede añadir `\vertema{3.A.20}` (opcional).
- **Canon** (C1-C7 de coherencia):
  - Las fichas `averch-johnson`, `laffont-tirole`, `price-cap`, `yardstick` y `captura-regulador`
    pasan a «tema de referencia: 3.A.20».
  - En `mapa.yaml`, el nombre «tasa de rentabilidad».
  - Gráfico de referencia nuevo `menu-contratos` y Baron-Myerson dentro de `laffont-tirole`.
  - En `price-cap`, la X del DORA ya está comprobada (+0,33 %).
- **Sin revisar**:
  - 4.A.12 escribe ṗ ≤ IPC − X.
  - 4.B.15 escribe t = a + b(C − C^a) y remite al «3.A.15» antiguo.
  - 3.A.6, 3.A.36 y 3.A.41 duplican «[ver tema 3.A.20]».

## Dudas abiertas

**Nuevas (23/10/2026), para que Víctor decida o confirme**:

1. **«Modelos optimin optimout»** (preguntas de otros exámenes): no existe con ese nombre; se ha
   leído como *opt-in*/*opt-out* (opciones por defecto: Johnson y Goldstein, 2003; Madrian y Shea,
   2001; Thaler y Sunstein, 2003). ¿De acuerdo?
2. **papeles42 de la UMA**: se cita como «Universidad de Málaga (2006), *La regulación económica: el
   problema del monopolio natural*», con la URL del Internet Archive y sin autor. La atribución a
   María del Carmen Ordóñez de Haro sale solo de los metadatos del PDF («Carmina ordoñez de
   haro.doc»): ¿se añade el nombre?
3. **«Internet Chapter Two»** (nota 22): se cita con la URL archivada y sin autor; probablemente es
   de *Public Finance in Canada* (Rosen, Wen, Snoddon, Dahlby y Smith), sin confirmar.
4. **Muñoz Moldes (2018)** (nota 21): se conserva como en el original, junto a Ostrom (1990, pp.
   61-65) y Netting (1981), pero no se ha identificado la obra (no está en la bibliografía).
5. **Carlos Rodríguez Braun** (nota 33): la frase se atribuye «según recoge» Rodríguez Herrera en
   *Libertad Digital* (2014); no se ha encontrado el texto original (otras webs la citan al revés).
6. **Atkinson y Stiglitz** (aversión al riesgo de los burócratas): se citan la lección 10, pp.
   259-263, y Mueller (2003, §16.4.2, p. 370) por los índices; el texto de esas páginas no se ha
   leído. Si Víctor puede mirarlo en su ejemplar, se confirma.
7. **Mueller (2003)**: van las cifras comprobadas por separado (7,3 % y 30-45 %); el 50 % del Word no
   tiene fuente y sale. Las páginas de la tabla de Mueller (§15.6, pp. 355-358) son del índice.
8. **Vuelo Madrid-Londres de 700 €** (nota 36): sin fuente; la nota queda sin la cifra (ni el piano
   en primera clase). Si Víctor tiene la fuente, se recupera.
9. **Kahn (1988, vol. I, p. xxxvii)**: la cita va entre comillas con traducción fiel, comprobada en
   Hempling (2021), que da la página, no en el libro.
10. **Nota 30** (países nórdicos e imposición indirecta): sin fuente; va como «se suele citar». ¿Se
    mantiene?
11. **Baldwin, Cave y Lodge**: la página de la tabla 2.1 y la del *yardstick* (cap. 26) no se han
    visto en el libro (capítulos de pago).
12. **Exolum**: el paquete de CVC (24,84 %) está en venta; revisar el dato antes de publicar.

**Decididas por Víctor el 23/10/2026** (se mantienen): el refrán «Tener la sartén por el mango» y
sus pegatinas (A20-01); Baron-Myerson en el cuerpo (A20-02); el reparto 8′ / 11′ / 7′30″ (A20-02),
y dentro de III, 2′ / 1′30″ / 2′30″ / 1′30″ (23/10/2026); las fichas nuevas del canon (A20-03); el
DORA como *price cap* (A20-04); y lo quitado por no estar comprobado (A20-05: Google Adtech, AWS y
Azure, el recurso contra la Circular 9/2025, Medicare, las cifras de Guasch *et al.*, la cifra de
Forbes, el «desde 2029» y el 0,13 % del PIB, las *killer acquisitions*).

**Siguen abiertas de ayer**: las páginas de Willig (1979); la referencia del DO de las Directrices
del art. 102 de 2026 (se cita C(2026) 6118); si las directrices europeas de concentraciones se
aprueban antes de publicar, revisar los umbrales del IHH; las directrices de EE. UU. de 2023 (IHH >
1.800 y Δ > 100) sin segunda comprobación propia.

## Instrucciones para el vídeo

- **Introducción y conclusión**, sin pizarra (`modo: guion`).
  - Enganche: «Tener la sartén por el mango» y la tasa de retribución eléctrica del 6,58 % («¿es
    mucho o es poco? Quien mejor lo sabe es la empresa»).
  - En la opinión, la cita de Kahn (la mejor combinación de una regulación y una competencia
    «inevitablemente imperfectas»).
  - Idea final: la regulación óptima no le quita la sartén al monopolista natural; le paga lo justo
    para que nos deje ver lo que hay dentro, la renta informativa.
- **Funciones clave que se conservan** (`\funcionclave`, `conservar:`):
  - el índice de Lerner `eq:lerner`, en la esquina superior izquierda todo el cante;
  - la condición del esfuerzo de Laffont-Tirole `eq:laffont-tirole`, debajo, desde II.3;
  - la regla del *price cap* `eq:price-cap`, que se escribe en II.4 y se deja en una esquina.
- **Bloque I**:
  - Qué es regular y los 3 motivos de Musgrave, de palabra; la tabla de Baldwin, Cave y Lodge,
    como **apoyo** (iluminando las filas en salmón).
  - **El algoritmo de Víctor (`algoritmo-regulacion`) va a la pizarra**, por ramas y en este orden
    (sus 6 capas): los 3 orígenes; la llave de la defensa de la competencia; «¿es sostenible?»;
    «¿primer óptimo?» con la caja de suma fija; «¿segundo óptimo?»; y el tercer óptimo en rojo,
    que anuncia el bloque II. Se deja la rama del tercer óptimo visible al pasar a II.
  - `ssnip` por capas mientras se aplica a Redes del Valle.
  - `subaditividad-sostenibilidad` y `regulacion-monopolio-natural`; el dilema en 3 pasos («ni
    desmantelar, ni dejar libre, ni pasarse») de palabra.
  - La regla de Ramsey-Boiteux junto a la de Lerner («Lerner amortiguado»).
  - Como apoyo: la tabla del 1TFEB (filas 3 y 5).
- **Bloque II** (rejilla con franja abajo para la escala de la potencia):
  - `averch-johnson`, `baron-myerson` (ejemplo 80/60/40, renta 800), el menú a mano
    (`menu-contratos`), la tabla del ejemplo de Laffont-Tirole como apoyo y `price-cap` como apoyo
    por capas, con la senda $p_t=p_0(1+\mathrm{IPC}-X)^t$.
  - **Gráfico conjunto por partes**: la escala de la potencia (`escala-potencia`) crece con la
    exposición: tasa de rentabilidad (II.1), menú (II.3), *price cap* (II.4), esquemas intermedios
    (II.4) y *yardstick* (III.1). No se escribe 2 veces.
  - Pegatinas: «Más sabe el loco…» al empezar II, «El que algo quiere…» junto a Φ(ē), «Poner al
    zorro…» junto a la captura (Bernstein → Stigler → Posner → Peltzman, de palabra).
  - La condición de Peltzman en una línea; Becker no se canta.
- **Bloque III**:
  - El *yardstick* a mano (20-22-24 → 23-22-21) con «Las comparaciones son odiosas».
  - Los mercados impugnables en una frase (enlaza con la rama «Sí» del algoritmo).
  - Liberalización frente a desregulación y los CTC, de palabra; la ECPR en una línea, $A=p-c_I$.
  - **`separacion-vertical` como apoyo**, panel a panel (6 capas): mientras sale cada panel se dice
    su ejemplo español (Telefónica/MARCo, ADIF-Renfe y Aena, CLH/Exolum, operadores
    independientes de EE. UU., móviles, distribuidoras como Redes del Valle). En la pizarra, como
    mucho, las siglas ANC/AC de un panel si ayudan.
  - Las aplicaciones de palabra, cada una con su lectura teórica; `tab:instrumentos` como apoyo al
    final, con la escala ya completa.
- **Ejemplo conductor**: siempre con frases naturales («Volvamos a Redes del Valle…»), nunca
  «hilo».
- **Gráficos**:
  - en la pizarra: `algoritmo-regulacion`, `ssnip`, `subaditividad-sostenibilidad`,
    `regulacion-monopolio-natural`, `averch-johnson`, `baron-myerson`, `menu-contratos` y
    `escala-potencia`;
  - como apoyo: `separacion-vertical`, `price-cap`, `peltzman`, las tablas del 1TFEB, de los
    motivos para regular, de lo que observa el regulador y de instrumentos;
  - solo en el documento: `ciclo-politico`, `niskanen` y el grabado del Leviatán (anexo).
