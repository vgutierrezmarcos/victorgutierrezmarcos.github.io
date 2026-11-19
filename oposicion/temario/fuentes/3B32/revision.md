# Revisión del 3.B.32 — Perspectivas económicas mundiales. Estructura sectorial y geográfica de los flujos comerciales y financieros internacionales. Las nuevas áreas emergentes

Tema hecho desde cero el 14/11/2026 (entrega 1: tema y ficha de repaso; sin vídeo), por un agente en paralelo con los del 3.B.30 y el 3.B.33, sin tocar ficheros comunes ni el canon (propuestas en `_trabajo/canon-pendiente.md`). Las dudas se resuelven con la opción recomendada y se anotan como B32-NN.

## 1. Resumen

- **Material de partida.** No había tema anterior en el repositorio. El tema era el antiguo 3.B.33 («Evolución y estructura sectorial y geográfica de los flujos comerciales y financieros internacionales. Los bloques comerciales y las nuevas áreas emergentes en el comercio internacional»).
  - Del disco D: de Víctor:
    - `Temas a imprimir\10. Historia económica y organismos internacionales\Tema 3.B.33 - v.2023.pdf` y sus versiones de 2024 (`Mis temas\Tema 3.B.33.docx` y `Tema 3.B.33 - v.2.docx`). Son solo un esqueleto: plantilla vacía, 2 imágenes del manual de Alonso (apertura de la economía mundial y comercio por productos) y la bibliografía (Alonso, 2019; «Tema ICEX-CECO: no está mal, pero requiere actualización»).
    - De la carpeta «Tema 3.B.33» de materiales por temas: `3B-33.pdf` (tema de otro preparador, solo para contrastar), `Comercio.xlsx` (datos de 2019, sustituidos por los oficiales de 2025-2026) y los manuales de Alonso (dir.), *Lecciones sobre economía mundial*, 9.ª ed., 2019, y de Requeijo, *Economía mundial*, 4.ª ed. (citados en el `.bib`).
    - De la nueva colección de ICEX-CECO: `3B32i.pdf` (2023, ya con la numeración actual), solo para contrastar estructura y enfoque.
  - Referencias de otros preparadores (`_trabajo/referencias.md`): la estructura sigue la de Miquel Tebar (CRITERIOS §5), que coincide con la de ICEX-CECO: perspectivas; flujos comerciales con las áreas emergentes; flujos financieros. Aquí, los 3 epígrafes del título son los 3 apartados (B32-01).
- **Estructura** (la del 14/11/2026; desde el 19/11/2026 el orden es I. Flujos, II. Emergentes, III. Perspectivas: ver «Comentarios de Víctor (18/11/2026)»):
  - Introducción (2′30″).
  - **I. Perspectivas económicas mundiales** (8′):
    - I.1 Coyuntura (WEO de octubre de 2026).
    - I.2 Riesgos y recomendaciones.
    - I.3 Medio y largo plazo, con el **centro de gravedad económico** (Quah, 2011) con estructura a)-e).
  - **II. Estructura de los flujos comerciales y financieros** (13′):
    - II.1 Mercancías.
    - II.2 Servicios y CGV.
    - II.3 **Modelo de gravedad**, a)-e).
    - II.4 Flujos financieros.
    - II.5 **Ciclo financiero global** (Rey, 2013), a)-e).
  - **III. Las nuevas áreas emergentes** (5′30″):
    - III.1 Concepto y **convergencia condicional**, a), b), c) Evidencia y d) Valoración (sin extensiones).
    - III.2 Áreas.
    - III.3 Retos.
  - Conclusión (1′).
- **Páginas**: 24 de tema, 1 de anexos (fuentes para poner al día el tema; test) y 4 de bibliografía (60 entradas). Ficha de repaso: 4 páginas a 10 pt (la última, al 91 %).
- **Gráficos**: 13, todos en TikZ/pgfplots, con 1 figura. 12 llevan datos reales bajados el 14/11/2026 con `graficos/datos-3B32.py`, que los rehace cada año.
- Compila sin errores ni referencias indefinidas. `verificar-tema.py` solo da los errores de lo no publicado (PDF, HTML y Word de `tercer-ejercicio/`, que construye `publicar`).

## 2. Errores corregidos

No había tema anterior propio que corregir. Del material de partida:

| Dónde | Decía | Dice ahora |
|---|---|---|
| Título (esqueleto de 2023) | «Los bloques comerciales y las nuevas áreas emergentes en el comercio internacional» | Título vigente: «Perspectivas económicas mundiales… Las nuevas áreas emergentes». Los bloques comerciales tienen ahora tema propio (3.B.35); aquí solo salen como contexto (B32-02) |
| Bibliografía del esqueleto | «Alonso, J. A. y Álvarez, I. (2019)» | La 9.ª edición (2019) es una obra colectiva dirigida por José Antonio Alonso (portada del PDF del disco D:). Isabel Álvarez no figura en ella |
| Bibliografía del esqueleto | Enlace a quia.com | Enlace genérico al simulador (anexo B) |
| Tema de otro preparador (2021), contrastado | Mercancías 19,5 billones $ (2018); servicios 5,85 billones; IED 1,3 billones (2018) | 26,3 billones (2025, OMC); 9,6 billones; 1,6 billones (UNCTAD, WIR 2026) |
| Tema ICEX-CECO (2023), contrastado | WEO de abril de 2024: mundo 3,2 % | WEO de octubre de 2026: 3,5 / 3,1 / 3,4 % (2025-2027) |

## 3. Marcas resueltas

| Marca (esqueleto de Víctor) | Qué se hizo |
|---|---|
| «Enganche: Noticia https://voxeu.org/columns/topics» y vídeo de YouTube (LUK5LZBiOBY) | El enganche es la noticia del año: el choque de Ormuz y la resistencia de la economía mundial (WEO de octubre de 2026), con el refrán (B32-07). El enlace genérico a VoxEU no aporta una fuente concreta. El vídeo no se pudo identificar sin abrirlo y no se ha enlazado (B32-09) |
| Imagen 1: «Evolución de la apertura de la economía mundial, 1960-2017» (Alonso, a partir del Banco Mundial) | Ese gráfico ya está en el 3.B.21 (`apertura-comercial`, 1970-2024). Aquí se usa el crecimiento del volumen del comercio frente al PIB, 1981-2025 (gráfico 5), que cuenta lo mismo por etapas |
| Imagen 2: «Comercio mundial por productos, 1950-2017» (Alonso, a partir de la OMC) | Rehecha con datos oficiales y la CUCI, 1995-2025 (gráfico 6; Banco Mundial a partir de UN Comtrade) |
| «Tema ICEX-CECO: no está mal, pero requiere actualización» | Datos de 2025-2026 de fuentes oficiales |
| «Preguntas de otros exámenes» (vacío) | Sin datos en el material. La ficha recoge 10 preguntas probables del tribunal |

## 4. Datos actualizados

Todos se consultaron el 14/11/2026 y están en `datos-actualizables.yaml`.

| Dato | Valor | Fuente y URL | Segunda comprobación |
|---|---|---|---|
| Crecimiento mundial 2025-2027 | 3,5 / 3,1 / 3,4 % (avanzadas 2,0/2,1/1,8; EMED 4,5/3,7/4,4) | FMI, WEO oct. 2026, DataMapper NGDP_RPCH | Cuadro 1.1 del capítulo 1 del WEO |
| Medio plazo | 3,2 % (2028-2031) frente a 3,7 % (2000-2019) | WEO oct. 2026, cap. 1 | DataMapper (2028-2031: 3,3/3,2/3,1/3,1) |
| Inflación mundial | 4,1 / 4,7 / 4,1 % | WEO, PCPIPCH | Cuadro 1.1 |
| Petróleo y Ormuz | +41,3 % en 2026 (APSP 95,74 $); ~20 mb/d; reapertura en mar. 2027 | WEO, cap. 1 | 3.B.21 (misma fuente) |
| Peso en el PIB (PPA) | Avanzadas 39,5 %; China 19,6 %; EE. UU. 14,6 %; India 8,2 % (2025) | DataMapper PPPSH | Mercado (NGDPD): EE. UU. 26,0 %, China 16,6 % |
| Comercio 2025 | Mercancías 26,26 billones $ (+7 %); servicios 9,56 (+8 %) | OMC, GTOS mar. 2026 | UNCTAD GTU abr. 2026: ~35 billones (+7,5 %) |
| Volumen de mercancías | 4,2 % (2025, revisado), 3,9 % (2026), 4,1 % (2027) | OMC, GTOS oct. 2026 | WEO: comercio de bienes y servicios 5,0/4,6/4,7 |
| Bienes de la IA | 14,8 % del comercio (1.er sem. 2026); 47 % del crecimiento | OMC, GTOS oct. 2026 | GTOS mar. 2026 (otra definición: 4,18 billones en 2025) |
| Principales exportadores e importadores | Tabla 1 | OMC, GTOS mar. 2026 | Banco Mundial (China 14,3 %) |
| Estructura por productos (CUCI) | Manufacturas 69,7 %; combustibles 9,5 %… | BM, WDI (Comtrade) | OMC (las cifras de combustibles de la OMC son algo mayores: B32-06) |
| Servicios por tipo | TIC 15,7 %; viajes 19,8 %; transporte 15,4 % | BM, WDI | OMC: viajes 1,89 de 9,56 (19,8 %) |
| IED 2025 | 1,6 billones $ (+6 %) | UNCTAD, WIR 2026 | BM (balanza de pagos): 1,8 billones (B32-08) |
| Banca transfronteriza | 49,5 billones $ (2026T2); crédito +11 % | BPI, LBS y nota del 29/10/2026 | Serie descargada (5J, 5R, 4T) |
| Desequilibrios | 3,8 % del PIB mundial; China +735 mm $; EE. UU. −1.116; PIIN EE. UU. −27,5 billones | FMI, ESR 2026 | WEO cap. 1 |
| Remesas | 685 mm $ (2024) | BM, WDI / KNOMAD | La cifra de 2025 no se pudo comprobar en fuente oficial |
| BRICS | 11 miembros, 10 socios; 40,5 % del PIB en PPA (elaboración propia) | Al Jazeera (cumbre de Nueva Delhi); FMI PPPSH | Business Today |
| OCDE | 2,9 % (2026), 3,0 % (2027) | Informe intermedio de sept. 2026 | Solo prensa (Euronews): la nota oficial daba 403 (B32-05) |
| Banco Mundial | 2,5 % (2026); «casi una década de convergencia perdida» | GEP jun. 2026, cap. 1 | — |
| Gravedad (España) | Pendiente −1,29; R² 0,39; 160 destinos | UN Comtrade 2024, FMI, Natural Earth (elaboración propia) | — |
| Convergencia | Pendiente −0,43; R² 0,08; 189 países | BM, WDI NY.GDP.PCAP.PP.KD | Canon `convergencia-beta-sigma` (PWT: −0,52, 2000-2023) |
| Centro de gravedad | 1980: 66° N 16° O; 2025: 61° N 65° E; ~3.800 km | Elaboración propia (método de Quah) | Quah (2011), cualitativo |

## 5. Contenido añadido

Todo el tema es nuevo. Lo que no estaba en ninguna referencia:

- **4 modelos con estructura a)-e)**:
  - centro de gravedad (Quah, 2011);
  - gravedad (Tinbergen, 1962; Anderson-van Wincoop, 2003), con datos de España;
  - ciclo financiero global (Rey, 2013; Miranda-Agrippino y Rey, 2020);
  - convergencia condicional (Barro y Sala-i-Martín; MRW), con 189 países.
- **El cálculo propio del centro de gravedad** con el WEO de octubre de 2026, y su mapa.
- **Lo nuevo de 2025-2026**:
  - la perspectiva «bifurcada» del FMI (Ormuz frente al auge de la IA);
  - los bienes de la IA en el comercio;
  - la inversión en sectores estratégicos (UNCTAD);
  - la banca transfronteriza (BPI);
  - el ESR 2026;
  - los BRICS ampliados y la cumbre de Nueva Delhi;
  - las economías conectoras (Gopinath et al., 2025).
- **La diferencia entre previsiones**: PPA frente a tipos de mercado (FMI 3,1 % frente al BM 2,5 %).
- **Anexo A**: dónde buscar cada dato para la actualización anual.
- **Notas de Nobel** con el motivo oficial: Tinbergen (1969), Krugman (2008), Lucas (1995), Solow (1987), Mundell (1999), Acemoglu, Johnson y Robinson (2024), y Aghion, Howitt y Mokyr (2025).
- **Remisiones al 4.º ejercicio**: 4.A.13, 4.A.21, 4.A.22, 4.A.23, 4.A.24, 4.A.25 y 4.A.29.

## 6. Coherencia

- **19/11/2026**: el sistema monetario (I.3) usa las mismas cifras y fuentes que el 3.B.21 (COFER, BPI, BCE, ley GENIUS). El 3.B.21 da un 4,6 % para el volumen del comercio de mercancías de 2025; aquí, el 4,2 % revisado de la OMC (B32-13).

- **No se duplica el 3.B.21.** Su historia (hiperglobalización, aranceles de EE. UU., dólar y renminbi) se resume en una línea y se remite. Las cifras compartidas son las mismas: arancel efectivo 2,6 → ~7 %, Ormuz, WEO de octubre de 2026, NMF 80 → 72 %.
- **Las CGV** se cuentan en resumen y se remiten al 3.B.18 (ficha `cadenas-globales-valor`).
- **El trilema y el dilema** se resumen y se remiten al 3.B.15. **La paradoja de Lucas** se resume y se remite al 3.B.12 y al 3.B.18.
- **Gravedad**: la misma ecuación y la misma notación que la ficha del canon y el 3.B.10 (`eq:gravedad`, `ACR`, `u_ij`), en «resumen aplicado».
- **Convergencia β**: la misma función clave del canon (`eq:convergencia-beta`, 3.A.45).
- **Notación local nueva**: $\vect{u}_i$ y $\vect{c}$ (centro de gravedad), anotada para el canon.
- **El 3.B.21**, en su conclusión, ya remite al 3.B.32 («perspectivas de la economía mundial»).

## Reglas vigentes aplicadas (9.ª tanda y revisión transversal, 13/11/2026)

- **Modelos**: estructura rígida a)-e), con las letras seguidas.
- **Resultados clave en morado** (`\funcionclave`): el centro de gravedad, la ecuación de gravedad y la de convergencia.
- **Pasos con sangría** (centro de gravedad y ciclo financiero global).
- **Citas**: sin Harvard en el texto (`\nocite`); `\textcite` solo para obras originales.
- **Nunca se cita a Víctor.** Nada de «Pegatina» ni «Dicho:».
- **Un solo refrán**, el del enganche, retomado en la idea final.
- **Términos en inglés** entre paréntesis la primera vez (*catch-up*, *friend-shoring*, *taper tantrum*…).
- **Ejemplos** sin nombres propios.
- **Anexo de test** con la caja estándar.
- **Nobel** con el motivo oficial en la primera mención (véase §5). **\vertema al 4.º ejercicio**, pocas y bien elegidas.

## 7. Dudas abiertas

- **B32-01 (14/11/2026). Estructura.** Tebar e ICEX-CECO meten las áreas emergentes dentro del comercio y dejan las finanzas en un tercer apartado.
  - (a) 3 apartados que siguen los 3 epígrafes del título (perspectivas; flujos comerciales y financieros; emergentes).
  - (b) Comercio y finanzas en apartados distintos, con los emergentes dentro del comercio.
  - **Aplicada: (a)**: respeta el orden del título y da a los emergentes un apartado con su propio modelo.
  - **Superada el 19/11/2026**: Víctor pide el orden flujos → emergentes → perspectivas.
- **B32-02 (14/11/2026). Bloques comerciales.** Estaban en el título antiguo.
  - (a) Fuera, con remisiones al 3.B.35 y al 3.B.41.
  - (b) Un subapartado.
  - **Aplicada: (a)**: ya no están en el título.
- **B32-03 (14/11/2026). Centro de gravedad.** El cálculo propio (centroides de país y proyección del centro de masas) da latitudes altas: Atlántico Norte → Siberia. Quah (2011), con unas 700 localizaciones y otra proyección, lo sitúa más al sur.
  - (a) Cálculo propio, avisando de que lo que importa es la dirección.
  - (b) Solo el mapa cualitativo de Quah.
  - **Aplicada: (a)**: se rehace cada año con el WEO.
- **B32-04 (14/11/2026). Gráfico de gravedad con datos de España** (elaboración propia con UN Comtrade). Los MCP del ministerio no respondían (DATACOMEX, sin conexión).
  - (a) Comtrade.
  - (b) DATACOMEX cuando esté disponible.
  - **Aplicada: (a)**.
- **B32-05 (14/11/2026). Datos no comprobados en la fuente primaria.**
  - Las previsiones de la OCDE de septiembre de 2026 (solo prensa: la nota oficial daba 403).
  - La pertenencia formal de Arabia Saudí a los BRICS (se cuenta en el 40,5 %).
  - El año de la 4.ª edición de Requeijo (2012; el PDF escaneado confirma la edición, no el año).
  - **Aplicada**: se mantienen, señalados aquí y en `datos-actualizables.yaml`; revisar con el Economic Outlook de diciembre de 2026.
- **B32-06 (14/11/2026). Estructura por productos.**
  - (a) Banco Mundial (WDI, a partir de Comtrade, CUCI), serie larga y descargable cada año.
  - (b) Las cifras de la OMC (combustibles algo más altos).
  - **Aplicada: (a)**, con la regla de usar siempre la CUCI.
- **B32-07 (14/11/2026). Refrán del enganche.** «Dios aprieta, pero no ahoga» (no lo usa ningún otro tema): los choques aprietan, pero la economía sigue creciendo.
  - **Aplicada.** Alternativa: «No hay mal que cien años dure».
- **B32-08 (14/11/2026). IED.**
  - (a) En el texto, la UNCTAD (1,6 billones), y en el gráfico, el BM (1,8), explicando la diferencia.
  - (b) Todo con la UNCTAD (sin serie descargable sin clave).
  - **Aplicada: (a)**.
- **B32-09 (14/11/2026). Vídeo del esqueleto** (youtube.com/watch?v=LUK5LZBiOBY): no se ha podido identificar.
  - (a) No enlazarlo.
  - (b) Que Víctor diga cuál era.
  - **Aplicada: (a)**.

## 8. Instrucciones para el vídeo

- **Enganche**: «Dios aprieta, pero no ahoga». Los choques de 2026 y el 3,1 %. La pregunta: ¿hacia dónde va la economía mundial y quién la mueve? La idea final la responde con el refrán.
- **Pizarra**:
  - I.3: el mapa esquemático con los puntos 1980, 2000, 2025 y la flecha hacia el sureste. Se escribe $\vect{c}=\sum Y_i\vect{u}_i/\sum Y_i$.
  - II.3: la ecuación de gravedad (función clave, se conserva en una esquina hasta el final de II) y la recta decreciente en escala logarítmica, con los socios de la UE por encima.
  - II.5: el circuito de 4 cajas del ciclo financiero global, construido paso a paso (Fed → intermediarios → resto del mundo → vuelta).
  - III.1: la ecuación de convergencia β (función clave) y la nube con la recta.
  - **Nueva numeración (19/11/2026)**: lo anterior de II pasa a I (II.3 → I.1, gravedad; II.5 → I.2, ciclo); III.1 → II.1 (convergencia); I.3 → III.4 (centro de gravedad). Nuevo: III.5, el DAFO en 4 cuadrantes, que se escribe en la pizarra al final del bloque III; la tabla de previsiones (III.2) va como apoyo.
- **Apoyo**, sin pizarra: crecimiento por regiones, peso en PPA, comercio frente a PIB, productos, regiones, servicios, IED, banca y la tabla de exportadores. Basta con decir su cifra clave.
- **Cifras**: una por idea. No recitar tablas.
- **Pausas**: antes de cada modelo y tras la pregunta del enganche.

**Reparto del cante** (nota que iba tras el esquema del tema; quitada del tema el 19/11/2026 a petición de Víctor, se conserva aquí para el vídeo):

> Reparto del cante (estructura del 19/11/2026): introducción, 2'30"; I, 13' (I.1 sistema comercial, 7': mercancías y sus formas 2'30", servicios y CGV 1'30", gravedad 3'; I.2 sistema financiero, 4'30": flujos financieros y de factores 2', ciclo financiero global 2'30"; I.3 sistema monetario, 1'30"); II, 5' (II.1, 2'30"; II.2, 1'30"; II.3, 1'); III, 8'30" (III.1 coyuntura, 2'; III.2 previsiones de los organismos, 1'30", con la tabla de previsiones como apoyo; III.3 riesgos y recomendaciones, 1'30"; III.4 medio y largo plazo, 2'30", con 1'30" para el centro de gravedad; III.5 DAFO, 1', escrito en la pizarra en 4 cuadrantes), y conclusión, 1'. Es un tema de datos: no se trata de recitar cifras, sino de dar pocas y bien elegidas (una por idea) y de explicarlas con 4 modelos sencillos. Se dibujan la recta de gravedad (gráfico «gravedad»), el circuito del ciclo financiero global (figura «ciclo-global»), la nube de convergencia (gráfico «convergencia»), el desplazamiento del centro de gravedad (gráfico «centro-gravedad») y el DAFO (tabla «dafo»); las funciones clave son la ecuación de gravedad y la de convergencia. Los demás gráficos y la tabla de previsiones son de apoyo. Las cifras caducan: están en el registro de datos del tema; las previsiones, cada vez que publique uno de los organismos de la tabla.

## Material del disco D: usado

- `Temas a imprimir\10. Historia económica y organismos internacionales\Tema 3.B.33 - v.2023.pdf` (esqueleto; base de la intención y de los 2 gráficos rehechos).
- `3. Materiales de otros preparadores\Parte B\Mis temas\Tema 3.B.33.docx` y `Tema 3.B.33 - v.2.docx` (versiones de 2021-2024 del mismo esqueleto).
- `1. Materiales por temas\...\Tema 3.B.33\3B-33.pdf` (tema de otro preparador, 2021: solo contraste), `Comercio.xlsx` (datos de 2019, no usados), `Economía mundial by Jaime Requeijo.pdf` (4.ª ed., citado) y `Lecciones de Economía Mundial…` (Alonso, dir., 9.ª ed., 2019, citado).
- `Preparación oposición a TCEE\01_Oposicion_Estudio\Nuevos temas oposición a TCEE - ICEX-CECO\3B\3B32i.pdf` (ICEX-CECO, 2023: contraste de estructura y del concepto de emergente).
- No se usaron (no aportan a la fotografía de 2026): los documentos de Granell Trias sobre el SEI de 1999-2020, Calvo Hornero, Stutz, los informes de 2018-2020 de la OMC, la UNCTAD y el FMI.

## Listas en las notas al pie (15/11/2026)

Ninguna nota lo necesitaba.

## Comentarios de Víctor (18/11/2026)

1. **Contraste con otros preparadores**: hecho (ver la sección del 19/11/2026).
2. **Perspectivas al día y desarrolladas**: nuevo subapartado III.2 «Las previsiones de los organismos internacionales», con la tabla de previsiones 2026-2027 (tabla «previsiones») de 7 informes con su fecha: FMI (WEO, 13/10/2026), OCDE (informe intermedio, 23/9/2026; el Economic Outlook de diciembre aún no ha salido), Comisión Europea (otoño, 17/11/2026), Banco Mundial (GEP, 11/6/2026), OMC (GTOS, 8/10/2026), BCE (septiembre de 2026) y Funcas (previsiones del 15/10/2026 y panel de septiembre; el de noviembre aún no ha salido; Funcas no da previsiones mundiales: solo la zona del euro y la opinión de los panelistas sobre el entorno internacional). Mundo, EE. UU., zona del euro, China, emergentes y comercio; qué es consenso y qué no (el comercio); riesgos en los que coinciden todos (guerra y energía, corrección de la IA, comercio, deuda y tipos a largo, clima), con el escenario adverso del Banco Mundial (1,3 %). Cifras comprobadas en el documento original (cuadro I.2.1 de la Comisión, cuadro 1.1 del GEP, cuadro 1 de la OMC, cuadros A1/A4 y DataMapper del FMI, cuadro 4 del panel y cuadro 2 de las previsiones de Funcas), salvo la OCDE (B32-11).
3. **Nueva estructura**: I. Estructura de los flujos (I.1 sistema comercial: mercancías —con las formas del comercio—, servicios y CGV, gravedad; I.2 sistema financiero: flujos financieros, ciclo financiero global y flujos de factores; I.3 sistema monetario, breve, con las cifras del 3.B.21); II. Nuevas áreas emergentes (con el peso en el PIB mundial, que pasa aquí desde las perspectivas); III. Perspectivas (coyuntura, previsiones, riesgos, medio y largo plazo con el centro de gravedad, y el DAFO en una tabla de 4 cuadrantes, cantada). Mismos 3 planos (comercial, financiero, monetario) que el 3.B.20 y el 3.B.21. Minutos: 2'30" + 13' + 5' + 8'30" + 1' = 30'. Puestos al día la introducción (contextualización, problemática y estructura), el esquema, los nexos y recapitulaciones de cada bloque, la conclusión, la ficha (4 páginas a 9 pt), el reparto del cante en «Instrucciones para el vídeo» y `datos-actualizables.yaml` (entradas nuevas: previsiones-organismos, funcas-panel, bm-escenario-adverso, cofer-dolar, migrantes y royalties).

## Comentarios de Víctor (19/11/2026)

- **Mapa de la exposición tras el esquema, en caja gris (figu:mapa-tema)**, con la estructura nueva (I flujos, II emergentes, III perspectivas) y la misma forma que el del 3.B.41.
- **Contraste con otros preparadores** (tabla en `_trabajo/contraste-preparadores.md`, 9 ficheros: 7 versiones válidas de 2018 a 2024, 2 de ellas con el título vigente; otros 2 del disco D: resultaron ser del tema de la OMC):
  - *Añadido, porque está en casi todas y aquí faltaba o era una línea*: las formas del comercio (interindustrial, intraindustrial con el índice de Grubel-Lloyd, intraempresa y de bienes intermedios); los acuerdos regionales que ordenan cada polo (mercado único, T-MEC, RCEP, ZLCCA), en una línea, porque los bloques ya no están en el título (B32-02); la IED *greenfield* frente a las fusiones y adquisiciones y el paradigma OLI de Dunning; los bloques como desviación de la gravedad y el efecto de la moneda común (Rose, 2000), en las extensiones del modelo de gravedad; las causas del gran colapso del comercio de 2009 (crédito comercial, inventarios, CGV); los flujos de factores (migrantes, remesas, tecnología), que Víctor pide y que 3 versiones tratan de pasada; el sistema monetario (dólar, reservas, renminbi), que solo esbozan 3.
  - *Solo en el nuestro, y se queda* (es correcto y aporta): el modelo de gravedad desarrollado, el ciclo financiero global, la convergencia condicional y la trampa de la renta media, el centro de gravedad de Quah, el peso en PPA frente a tipos de mercado, el Golfo y el comercio Sur-Sur, y el DAFO. Ninguna versión da una tabla de previsiones de varios organismos: todas se quedan en el FMI (y alguna, el BM o la OMC).
  - *No se ha añadido* (minoritario o de otro tema): la evolución histórica por etapas desde el siglo XIX (es el 3.B.20 y el 3.B.21; aquí quedan las 3 etapas desde 1991), la curva del elefante y los trilemas de Rodrik (2 versiones), la teoría de la IED en detalle y las CGV con su tipología (3.B.18), las fuentes de financiación del desarrollo (AOD, fondos soberanos; 3.B.29) y las finanzas sostenibles (una).
  - Páginas: el tema pasa de 24 a 28 (más 1 de anexos y 5 de bibliografía), por debajo de 45.

## Dudas abiertas (19/11/2026)

- **B32-10. El DAFO, ¿cantado o en caja gris?**
  - (a) Cantado (1'), como cierre del bloque III, en una tabla de 4 cuadrantes en el cuerpo.
  - (b) En una caja gris, sin cantar, y el minuto a las previsiones.
  - **Aplicada: (a)**: resume el bloque y da una recapitulación que se recuerda.
- **B32-11. Previsiones de la OCDE sin comprobar en la fuente** (oecd.org devuelve 403 a todas las descargas): las cifras (2,9/3,0 el mundo) son las de su nota de prensa, reproducida en prensa especializada; van marcadas en la tabla. Sustituirlas por las del Economic Outlook de diciembre de 2026 en cuanto salga. Tampoco se pudo abrir el cuadro 1.1 del WEO (sus cifras salen del apéndice A1/A4 y del DataMapper, que coinciden).
- **B32-12. Dónde van los flujos de factores.**
  - (a) Dentro de I.2, sistema financiero, tras el ciclo financiero global (las remesas son su contrapartida financiera).
  - (b) Un subapartado propio (I.3) y el monetario en I.4.
  - **Aplicada: (a)**: mantiene los 3 planos del 3.B.20 y el 3.B.21.
- **B32-13. Volumen del comercio de mercancías de 2025.** Aquí 4,2 % (cifra revisada de la OMC de octubre de 2026); el 3.B.21 dice 4,6 % (la de su nota de prensa). No se toca el 3.B.21: conviene ponerlo al día con el 4,2 % (anotado también en «Coherencia»).
