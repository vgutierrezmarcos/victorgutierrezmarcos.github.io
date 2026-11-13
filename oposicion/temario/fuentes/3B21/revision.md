# Revisión del 3.B.21 — El sistema económico internacional desde la desaparición del sistema de Bretton Woods

Revisión completa del 13/11/2026 (entrega 1: tema y ficha de repaso; sin vídeo), hecha por un agente en paralelo con los del 3.B.20 y el 3.B.22, sin tocar ficheros comunes ni el canon (propuestas en `_trabajo/canon-pendiente.md`). Fuente nueva en LaTeX (`3B21.tex`) a partir del Word de Víctor (`Tema 3.B.21.docx`, 17.043 palabras, 33 páginas, 46 notas), redactada de nuevo y puesta al día hasta noviembre de 2026. Las dudas se resuelven con la opción recomendada y se anotan como B21-NN.

## 1. Resumen

- **Estructura**: introducción (2′30″) con los 5 bloques; **I. Del fin de Bretton Woods a la Gran Moderación (1971-2007)** (11′: I.1 ruptura 1971-1976, I.2 primeros años del no sistema, I.3 sistema comercial, I.4 sistemas monetario y financiero, con la cooperación cambiaria, las crisis de los emergentes y el modelo de **Bretton Woods II** con a)-e)); **II. De la crisis financiera global a la pandemia (2007-2021)** (7′); **III. La actualidad: retos y propuestas de reforma** (8′30″); conclusión (1′). Los 4 apartados del Word pasan a 3 (B21-01): el antiguo I (los acuerdos de 1944 y su ruptura, casi idéntico al 3.B.20) queda en I.1 como resumen de la ruptura, según la decisión D025 del canon.
- **Páginas**: 20 de tema, 2 de anexos (cronología 1971-2026; complementos del tema anterior; test) y 6 de bibliografía (101 entradas). Ficha de repaso: 4 páginas a 10,5 pt (última, 81 %).
- **Gráficos** (8, todos TikZ/pgfplots; 5 con datos reales descargados el 13/11/2026): trilema con la ruptura, figura de Bretton Woods II, cronología, tipo de cambio efectivo real del dólar (BPI, 1970-2026), comercio mundial en % del PIB (Banco Mundial, 1970-2024), desequilibrios globales (FMI, WEO de octubre de 2026), reservas por monedas (FMI, COFER 2026T2) y arancel efectivo de EE. UU. (BEA, 1929-2026).
- **Al día** (fuentes oficiales, comprobadas con una segunda fuente): aranceles de EE. UU. de 2025-2026 (IEEPA, sentencia del Supremo del 20/2/2026, sección 122, sección 301 de julio de 2026), CM14 de la OMC, COFER 2026T2, papel internacional del euro y el oro (BCE, junio de 2026), encuesta trienal del BPI de 2025, ley GENIUS, euro digital, 16.ª revisión de cuotas del FMI, paquete «lado a lado» del pilar 2, G-20 de Johannesburgo y Miami, Basilea III, guerra con Irán y Ormuz (WEO de octubre de 2026).
- Compila sin errores ni referencias indefinidas; `verificar-tema.py` (sobre el PDF de `_trabajo`, con un envoltorio que no toca ficheros comunes) solo da los errores de lo no publicado (HTML y Word, que construye `publicar`).

## 2. Errores corregidos

| Dónde (Word) | Decía | Dice ahora |
|---|---|---|
| Conclusión | «ruptura del acuerdo de Bretton Woods en la década de 1979» | Ruptura entre 1971 y 1973 |
| Apartado I entero | Los acuerdos de 1944, Triffin y los factores de mantenimiento, copiados del 3.B.20 | Resumen de la ruptura (1971-1976) con remisión al 3.B.20 (D025; fichas `bretton-woods` y `triffin`) |
| Contextualización | 2 tríadas llamadas «pilares» (las instituciones de 1944 y los planos del SEI) | «Pilares» para FMI, BIRF y GATT; «planos» para comercial, monetario y financiero (ficha `bretton-woods`) |
| I.2, sistema financiero | Comité de Basilea creado «en 1975» por «11 países» (con una nota sobre la segunda crisis del petróleo que no venía al caso) | Finales de 1974, gobernadores del G-10, tras la quiebra de Herstatt (BPI, historia del Comité) |
| Crisis de 1982 | Subida de tipos «en 1980-1982»; Plan Baker, Plan Brady, Clubes de París y de Londres sin explicar | Volcker 1979-1982; 1982 en resumen con Baker (1985) y Brady (1989) explicados y `\vertema{3.B.29}` (ficha `alivio-deuda`) |
| México 1994-1995 | «Crisis de primera generación»; subida de tipos de EE. UU. por la «estrategia de Paul Volcker»; déficit corriente del 8 %; PIB −6,2 % | Crisis mixta (fundamentos frágiles y pánico de deuda a corto en dólares, parada súbita; ficha `paradas-subitas`); la subida de tipos de 1994 no fue de Volcker (presidente de la Fed hasta 1987); déficit cercano al 7 %; PIB −5,9 % (WEO, como el 3.B.17) |
| Notas 35 y 45 | La nota de la «década perdida» colgaba de México 1994; la de la refinanciación de Argentina, de las líneas *swap* de 2020 | Cada idea en su sitio (la década perdida, con 1982) |
| Asia 1997 | Detonante «en 1996 aumenta el tipo de interés del yen» | Sin ese detonante (no comprobado); la devaluación del bat tailandés en julio de 1997 |
| Rusia 1998, Brasil 1999 | «Tercera generación» | Rusia, mixta (fiscal y de deuda con la banca expuesta); Brasil, contagio (sin etiqueta pura), como pide el 3.B.17 |
| Argentina 2001-2002 | «La mayor suspensión de pagos de la historia»; «el PIB cayó aproximadamente un 20 % en 3 años» | «La mayor suspensión de pagos soberana de su tiempo» (Grecia la superó en 2012); PIB −10,9 % en 2002 (WEO) |
| Euro | «En la actualidad 20 países» | 21, con Bulgaria desde el 1/1/2026 |
| OMC | «164 países» | 166 miembros (Timor Oriental, 2024) |
| G-20 | «Más del 90 % del PIB»; enumeración con Rusia como «G-8» | ≈85 % del PIB, 75 % del comercio y 2/3 de la población (canon `g20-ocde`), 19 países, la UE y la Unión Africana (2023) |
| Basilea III | «Implementación completa prevista para 2023» | UE desde enero de 2025 (cartera de negociación, 2027); EE. UU., nueva propuesta de marzo de 2026 sin norma final |
| Crisis de 2007 | La Fed subió del 1 % al 5,25 % «entre 2004 y 2007» | De mediados de 2004 a junio de 2006 (canon, 3.B.26) |
| Crisis de 2007 y COVID | PIB mundial «más de un 2 %» en 2009 y «sobre un 4 %» en 2020 | −0,4 % (2009) y −2,7 % (2020), WEO de octubre de 2026 |
| Gran colapso del comercio | «Cayó un 10 % frente a una caída del 1 % del PIB mundial» (2008-2009) | Más del 10 % en volumen en 2009, frente a −0,4 % del PIB |
| Guerra comercial | Aranceles «por valor de 350.000 millones» | Unos 370.000 millones de importaciones (listas 1 a 4A de la sección 301; PIIE) |
| Transición energética | Acuerdo de París «firmado en 2016» | Adoptado en 2015, en vigor desde 2016; EE. UU. fuera desde el 27/1/2026 |
| Partes en inglés y francés | Frases sin traducir (COVAX, *Buy American*, exenciones del impuesto mínimo) | Redactadas en castellano (anexo de complementos) |

## 3. Marcas resueltas

| Marca | Texto | Qué se hizo |
|---|---|---|
| Nota al opositor (×4) | Aviso del cambio de temario de 2023 y la imagen de la tabla de equivalencias | Notas de trabajo: desaparecen |
| Comentario (apartado I) | «Esto en este tema brevemente (coordinar con el tema 3.B.20)» | Aplicado: la ruptura en resumen (I.1) y los acuerdos de 1944 con `\vertema{3.B.20}` |
| Comentario (apartado III) | «Artículo BICE (actualizado en diciembre de cada año)… Francesc Granell…» | Nota privada: no se publica; los datos se han tomado de fuentes primarias (FMI, OMC, BPI, BCE) |
| Amarillo en «Estructura» (vacía) | Bloque sin redactar | Redactado con los 3 apartados y su porqué |
| Conclusión | Relevancia, Extensiones y Opinión vacías | Redactadas |
| Anexo 1 (vacío) | — | Anexos nuevos: cronología, complementos y test |
| Imágenes del Word | Trinidad imposible (imagen 1), serpiente en el túnel (nota 24), fórmula suiza (gifs de la nota 27), tigres asiáticos, curva del elefante, IS-LM de la nota 26 | La trinidad imposible se rehace en TikZ (`trilema-ruptura`, del gráfico de referencia del 3.B.15); la fórmula suiza queda en una nota con su fórmula y un ejemplo; la serpiente, la IS-LM y Bretton Woods van al 3.B.20, el 3.B.16 y el 3.A.32; la curva del elefante se cuenta en el texto con su fuente (Lakner y Milanović, 2016) |

## 4. Datos actualizados

| Dato | Antes | Ahora | Fuente | URL | Consulta | 2.ª comprobación |
|---|---|---|---|---|---|---|
| Arancel efectivo de EE. UU. | — | 2,6 % (2024) → 8,0 % (2025), 11,3 % en 2025T4, 8,1 % en 2026T1-T3 | BEA (FRED: B235RC, A255RC) | fred.stlouisfed.org | 13/11/2026 | Penn Wharton (7,1 % en agosto de 2026); Yale Budget Lab (legal 10,9 % en agosto de 2026) |
| Reservas por monedas | — | Dólar 56,7 %, euro 20,6 %, yen 5,0 %, libra 4,6 %, renminbi 2,1 % (2026T2); dólar 71 % en 1999 | FMI, COFER 7.0.1 | data.imf.org | 13/11/2026 | IMF Data Brief 30/9/2026; 3.B.11 y 3.B.13 (mismas cifras) |
| Reservas totales | — | 1,8 billones $ (1999) → 6,7 (2007) → 13,2 (2026T2) | FMI, COFER | data.imf.org | 13/11/2026 | 3.B.15 |
| Dólar en el mercado de divisas | — | 89,2 %; renminbi 8,5 % (5.º) | BPI, trienal 2025 | bis.org | 13/11/2026 | 3.B.13 (89,1 %; diferencia de redondeo en la tabla del BPI; se usa 89,2 del comunicado) |
| Oro en las reservas | — | 27 % a precios de mercado a finales de 2025 (Tesoro 22 %, euro 15 %) | BCE, *International role of the euro* 2026 | ecb.europa.eu | 13/11/2026 | Nota de prensa del BCE del 2/6/2026 |
| Comercio mundial / PIB | — | 37,1 % (1985) → 60,3 % (2008) → 56,7 % (2024) | Banco Mundial, WDI | data.worldbank.org | 13/11/2026 | Coherente con la «lentiglobalización» del 3.B.18; 2025 (68,5) excluido por cobertura incompleta |
| Desequilibrios | — | EE. UU. −1,54 % del PIB mundial (2006); China +0,65 % (2008) y +0,67 % (2026p) | FMI, WEO oct. 2026 | imf.org/external/datamapper | 13/11/2026 | FMI, ESR 2026 («rising imbalances») |
| Dólar real (BPI) | — | 116,3 (mar. 1985), 89,1 (feb. 1987, −23 %), 73,5 (2011), 111,9 (oct. 2022), 104,4 (jul. 2026) | BPI (FRED RNUSBIS) | fred.stlouisfed.org | 13/11/2026 | Frankel (2015) para el Plaza |
| PIB mundial | 2009 «más de −2 %»; 2020 «−4 %» | −0,4 % (2009), −2,7 % (2020), 3,5 % (2025), 3,1 % (2026p) | FMI, WEO oct. 2026 | imf.org | 13/11/2026 | Prensa del 13/10/2026 |
| Comercio OMC | 2021 +9,7 % (FMI) | +4,6 % (2025), +3,9 % (2026p), +4,1 % (2027p) | OMC, 8/10/2026 | wto.org | 13/11/2026 | AP |
| Miembros OMC / MPIA | 164 | 166; MPIA 62 miembros, 60,4 % del comercio | OMC; Comisión Europea | wto.org; policy.trade.ec.europa.eu | 13/11/2026 | 3.B.33 |
| Aranceles 2025-2026 | Guerra comercial de 2018-2020 | IEEPA, recíprocos, Ginebra, Busan, acuerdos UE-Japón-Corea (15 %), sección 232 (50 %), Supremo (20/2/2026, 6-3), sección 122 (10 %, feb.-jul. 2026), sección 301 (24/7/2026, 10-12,5 %, 60 economías) | Casa Blanca, USTR, Federal Register; Jones Day | whitehouse.gov; federalregister.gov | 13/11/2026 | King & Spalding, White & Case, Global Trade Alert; 3.B.07 (misma sentencia) |
| CM14 | — | Yaundé, 26-30/3/2026, sin resultados; expira la moratoria del comercio electrónico | OMC; USTR | wto.org; ustr.gov | 13/11/2026 | 3.B.07 |
| FMI, cuotas | — | 16.ª revisión (+50 %, dic. 2023) sin vigor; plazo 15/11/2026; 76,66 % de consentimientos en abril (hace falta el 85 %) | FMI | imf.org | 13/11/2026 | Tesoro de EE. UU. |
| DEG 2021 | — | 456.000 M DEG ≈ 650.000 M$ (23/8/2021) | FMI | imf.org | 13/11/2026 | 3.B.19 |
| Pilar 2 | Acuerdo G-7/G-20 de 2021; UE 2022 | G-7 28/6/2025 y paquete «lado a lado» del 5/1/2026 | G-7; OCDE | g7.canada.ca; oecd.org | 13/11/2026 | KPMG, EY |
| G-20 | — | Johannesburgo (22-23/11/2025) sin EE. UU.; Miami (14-15/12/2026) | G-20 | g20.utoronto.ca | 13/11/2026 | 3.B.19 |
| Guerra con Irán | — | Desde el 28/2/2026; cierre de Ormuz; el FMI lo llama el mayor choque petrolero en décadas | FMI, WEO oct. 2026 | imf.org | 13/11/2026 | The National, Al Jazeera |

## 5. Contenido añadido

- **I.1 con el trilema** (gráfico nuevo a partir del de referencia del 3.B.15): la ruptura como paso del lado del tipo fijo con controles al de la flotación; los 4 pasos con fechas del canon (Smithsonian ±2,25 % hasta marzo de 1973; Jamaica 1976; Segunda Enmienda 1978) y el «no sistema» de Williamson (1976).
- **Bretton Woods II** como modelo con a)-e) (Dooley, Folkerts-Landau y Garber, 2003 y 2009), con la función clave CC ≡ S − I, la figura del circuito y, en extensiones, exceso de ahorro (Bernanke, 2005), escasez de activos seguros (Caballero, Farhi y Gourinchas, 2017), privilegio exorbitante (Gourinchas y Rey, 2007) y Triffin moderno (Farhi, Gourinchas y Rey, 2011). En el Word solo había una lista de 3 rasgos.
- **Tabla de las crisis de los emergentes** (`tab:crisis-emergentes`), coherente con `tab:tres-generaciones` del 3.B.17.
- **Plano monetario tras 2008**: líneas *swap* de la Fed, ciclo financiero global y dilema de Rey, guerras de divisas.
- **Apartado III nuevo** (el Word solo tenía transición energética e impuesto mínimo): fragmentación geoeconómica, aranceles de 2025-2026 y sentencia del Supremo, OMC tras la CM14, resistencia del comercio, guerra con Irán, dominancia del dólar, oro, renminbi, *stablecoins* y euro digital, vuelta de los desequilibrios, red de seguridad financiera mundial y propuestas de reforma por plano.
- **Anexos**: cronología 1971-2026 (figura) y complementos del tema anterior (historia económica como método, TTIP y Airbus-Boeing, política industrial y COVAX, el porqué del impuesto mínimo y los enlaces del original).
- **Notas de los Nobel**: Mundell (1999), Friedman (1976), Stiglitz (2001), Krugman (2008), Bernanke (2022) y Nordhaus (2018), con el motivo oficial y las mismas palabras que en otros temas.

## 6. Coherencia

- Con el canon: decisión D025 (Bretton Woods solo en el 3.B.20); fichas `bretton-woods`, `triffin`, `trilema`, `ciclo-financiero`, `g20-ocde`, `alivio-deuda`, `paradas-subitas`, `cadenas-globales-valor`: se aplican todas las contradicciones que `mapa.yaml` anota sobre el 3.B.21 (del 3.B.15, 3.B.17, 3.B.19, 3.B.26 y 3.B.29). Propuestas para el canon en `_trabajo/canon-pendiente.md` (ficha nueva `bretton-woods-ii`).
- Con el 3.B.20 (en revisión a la vez): este tema empieza en 1971; no desarrolla los acuerdos de 1944 ni el dilema de Triffin.
- Con el 3.B.22 (en revisión a la vez): el FMI solo en su papel en el sistema (Jamaica y el artículo IV, DEG de 2021, 16.ª revisión de cuotas, red de seguridad), con `\vertema{3.B.22}`.
- Con el 3.B.13 y el 3.B.11: mismas cifras de COFER y de la encuesta trienal; el renminbi como en el 3.B.13 (Wei, 2023).
- Con el 3.B.07: misma sentencia del Supremo (`JonesDay2026IEEPA`) y la misma caída de la NMF (80 → 72 %).
- Con el 3.A.40: la guerra con Irán y el choque petrolero de 2026 (su cronología recoge subidas de tipos en septiembre de 2026); aquí solo se cita el WEO.
- `\vertema` al 4.º ejercicio: 4.A.21 y 4.A.22 (España, balanza e internacionalización), 4.A.27 (la peseta en el SME), 4.A.28 (la crisis del euro en España) y 4.B.18 (fiscalidad internacional).

## Comentarios de Víctor (13/11/2026, 9.ª tanda)

| Comentario (regla) | Cómo se ha aplicado |
|---|---|
| Estructura rígida de los modelos a)-e) | Bretton Woods II con a) Idea, b) Modelo (i-iii), c) Extensiones, d) Evidencia, e) Valoración |
| Sin citas Harvard en el texto | Solo `\nocite` y `\textcite` de obras originales; ninguna `\parencite` |
| Nunca citar a Víctor Gutiérrez Marcos | Ninguna entrada suya; gráficos propios con «elaboración propia» |
| Nada de «Pegatina» ni «Dicho:» | Ninguna etiqueta |
| Refranes: solo el inicial y los del tema antiguo | «Lo provisional es lo que más dura» (enganche e idea final) y «nada dura para siempre» (del Word, en la contextualización) |
| Nobel con motivo oficial en la primera mención | 6 notas (ver § 5) |
| `\vertema` al 4.º ejercicio donde sea relevante | 5 remisiones (ver § 6) |
| Resultados clave en morado; pasos con sangría | `\funcionclave[eq:cc-ahorro]`; los 4 pasos de Bretton Woods II en sublistas |
| Cajas grises para lo no cantable | Notación, «Para saber más» y los complementos del anexo |
| Ejemplos sin nombres propios | No hay ejemplos con personas |
| Términos en inglés entre paréntesis la primera vez | *non-system*, *revived Bretton Woods system*, *global saving glut*, *great trade collapse*, *slowbalization*, *friend-shoring*, *taper tantrum*, *side-by-side*, *stablecoins* |
| Anexo de test con la caja estándar | `tema=3.B.21` |
| Sin páginas en blanco ni desbordes | Comprobado con `verificar-tema.py` sobre el PDF de `_trabajo` |
| Cante de 30 minutos | 2′30″ + 11′ + 7′ + 8′30″ + 1′ |

## Revisión transversal (13/11/2026)

- **Nobel**: Mundell (1999), Friedman (1976), Stiglitz (2001, con Akerlof y Spence), Krugman (2008), Bernanke (2022, con Diamond y Dybvig) y Nordhaus (2018, con Romer), cada uno en su primera mención con `\nocite`. Hall y Woodford (2026) no salen en el tema.
- **4.º ejercicio**: 4.A.21, 4.A.22, 4.A.27, 4.A.28 y 4.B.18.
- **Dichos**: se conservan el del enganche (nuevo) y «nada dura para siempre» (del Word); no hay otros.

## 7. Dudas abiertas

- **B21-01** (13/11/2026). El Word tenía 4 apartados (I. Ruptura de Bretton Woods, II. 1973-2007, III. 2007-COVID, IV. Actualidad). Opciones: (a) 3 apartados, con la ruptura en resumen como I.1 del primero (regla de los 3 apartados y D025); (b) mantener 4 con un I muy corto. **Aplicada: (a)**.
- **B21-02** (13/11/2026). Modelo con estructura a)-e): (a) solo Bretton Woods II, el único modelo propio del tema; el trilema, el dilema de Rey y Triffin, en mención con remisión; (b) desarrollar también el trilema (su referencia es el 3.B.15). **Aplicada: (a)**.
- **B21-03** (13/11/2026). Enganche: (a) «Lo provisional es lo que más dura», con la suspensión «temporal» de 1971 y los aranceles de 2025; (b) «No hay mal que cien años dure». **Aplicada: (a)**.
- **B21-04** (13/11/2026). Medida del arancel de EE. UU.: (a) la efectiva oficial, derechos cobrados / importaciones (BEA: 8 % en 2025), con la de Penn Wharton como 2.ª fuente; (b) la de Yale Budget Lab (16,8 % antes de sustitución en noviembre de 2025, que mide tipos legales). **Aplicada: (a)**, porque es serie oficial larga (desde 1929).
- **B21-05** (13/11/2026). Guerra con Irán y cierre de Ormuz (desde el 28/2/2026): (a) una viñeta con el WEO de octubre de 2026; (b) no mencionarla por ser un hecho en curso. **Aplicada: (a)**.
- **B21-06** (13/11/2026). Cuota del renminbi en los pagos de SWIFT (3,10 % en julio de 2026, según fuentes secundarias; otro mes da 2,18 %): (a) no darla hasta comprobarla en el informe de SWIFT; (b) darla. **Aplicada: (a)**.
- **B21-07** (13/11/2026). Tregua comercial EE. UU.-China «hasta enero de 2027»: anunciada por el secretario del Tesoro el 24/9/2026 (CNBC), sin documento oficial. (a) Darla con la hoja de la Casa Blanca de noviembre de 2025 y el PIIE; (b) quitarla. **Aplicada: (a)**.
- **B21-08** (13/11/2026). 16.ª revisión de cuotas del FMI: el plazo vence el 15/11/2026, 2 días después de la revisión. (a) Decir que no ha entrado en vigor y el plazo; actualizar con lo que ocurra (`datos-actualizables.yaml`); (b) no dar el plazo. **Aplicada: (a)**.
- **B21-09** (13/11/2026). Contenido del Word que no se canta (TTIP y Airbus-Boeing, política industrial tras la pandemia, COVAX, el porqué del impuesto mínimo, notas 1-2 sobre la historia económica): (a) anexo de complementos; (b) quitarlo. **Aplicada: (a)** (nada se pierde).
- **B21-10** (13/11/2026). El comercio mundial en % del PIB de 2025 del Banco Mundial (68,5) es incoherente con la serie: (a) excluirlo y dar hasta 2024; (b) darlo. **Aplicada: (a)**.

## 8. Instrucciones para el vídeo

- **Enganche e idea final**: «Lo provisional es lo que más dura»: Nixon, 15/8/1971, suspensión «temporal»; aranceles de 2025 y el dólar aún en el 57 % de las reservas; pregunta: ¿hay un sistema o solo un no sistema? La idea final la responde: un orden de hecho sostenido por el dólar y la cooperación que queda.
- **Patrón**: en cada etapa, los 3 planos en el mismo orden (comercial, monetario, financiero); conviene una rejilla de 3 columnas con esos rótulos en I.2, II.2 y III.
- **A la pizarra**: el trilema (triángulo por capas: lados y régimen de cada uno, y al final la flecha de 1971-1973) y el circuito de Bretton Woods II (centro y periferia, y las 4 flechas en el orden de los pasos). Función clave que se conserva en la esquina desde I.4 hasta III.2: CC ≡ S − I (vuelve para explicar por qué los aranceles apenas corrigen el déficit).
- **Apoyo** (no se dibujan): el dólar real (Plaza y Louvre), la apertura comercial, los desequilibrios, las reservas por monedas, el arancel efectivo de EE. UU. y la cronología; de cada uno, solo la cifra clave en la voz.
- **Tabla de las crisis de los emergentes**: como apoyo, fila a fila mientras se nombra cada crisis.
- **No decir números de temas** en voz alta: «la teoría de las crisis», «el tema del FMI», etc.
