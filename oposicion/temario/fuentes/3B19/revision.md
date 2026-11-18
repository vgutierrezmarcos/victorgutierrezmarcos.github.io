# 3.B.19 — La coordinación internacional de políticas económicas: informe de revisión

11/11/2026. Fuente: `fuentes/3B19/3B19.tex` (LyX con tex2lyx). Rama `revision-temario`; nada publicado. Escrito en 2 partes (parte 1: preámbulo, introducción y apartado I; parte 2: apartados II y III, conclusión, anexos, este informe y `seo.json`).

## 1. Resumen

- Tema reescrito en LaTeX sobre el Word de Víctor (19.813 palabras, 2 apartados con el segundo vacío) con **3 apartados** (D-K1): I. Análisis teórico (12′30″), II. La cooperación en la historia reciente (6′), III. Economía política: mecanismos y foros (8′); introducción 2′30″ y conclusión 1′ (30′).
- Errores de teoría corregidos: tabla de Mundell-Fleming con tipo fijo, efecto de vuelta de la fiscal, signo de σ en la reforma estructural, *dollar pricing* como «tercera moneda», ganancias de coordinar con LCP, «modelo de Corden» (es el diagrama de Hamada), Rogoff (1985), FSB (2009), G-7 de 2013 (declaración de ministros, no cumbre), rondas de QE y fechas.
- Huecos del título cubiertos: el G-20, la OCDE y los otros foros (vacíos en el original; D119, desde el 3.B.35), la introducción y la conclusión completas, la historia con fechas (Bonn, Plaza, Louvre, Londres, Toronto, 2013) y la problemática de teoría de juegos de los foros.
- Recortes: el IS-LM-BP de un país (3.A.32), la caja del cártel (3.A.14 y 3.A.19), el juego de la gallina España-BCE (3.A.14) y el texto del blog de 2019; los juegos de disciplina y de guerra de divisas, la reforma estructural y el dólar de Corsetti-Pesenti, a los anexos A y B; el anexo C rehecho con el WEO de octubre de 2026.
- 8 gráficos: 2 copiados del 3.A.37 y 6 nuevos; 6 tablas, 3 funciones clave; 116 entradas en `3B19.bib`. Compila: 28 páginas de tema, 5 de anexos, 6 de bibliografía.

## 2. Errores corregidos

| Dónde (original) | Decía | Dice ahora |
|---|---|---|
| Introducción (l. 107) | Friedman, *The Case for Flexible Exchange Rates* (1969) | 1953 (`Friedman1953Case`) |
| I.1, BP (l. 292) | «movilidad perfecta, β = 0» | Sale con el IS-LM-BP de un país; en el modelo de 2 países, $\beta_K\to\infty$ |
| I.1.1, tabla (l. 418-426, nota 9) | Monetaria con tipo fijo: «ambiguo (+)» en A y B | Sube en A y en B; la fiscal con tipo fijo es ambigua en B (`tab:mundell-fleming-2-completa`) |
| I.1.1, fiscal (l. 388) | El efecto de vuelta reduce las exportaciones de A (copiado de la monetaria) | La renta de B sube (locomotora) y la vuelta la absorbe una apreciación adicional de A |
| I.1.1, evidencia (l. 446) | La Reserva Federal normalizó «en 2018» | Primera subida en diciembre de 2015 y reducción del balance desde octubre de 2017 |
| I.1.2, reforma (l. 570-572) | Reforma estructural «↓σ» | σ↑ (NR = (σ−1)/(σχ) crece con σ); anexo A |
| I.1.2 (l. 600) | Precios flexibles rotulados «bajo precios rígidos» | Corregido |
| I.1.2, DP (l. 780) | *Dollar pricing* en una tercera moneda | En la moneda de uno de los 2 países (B, Estados Unidos) |
| I.1.2, implicaciones | Ganancias de coordinar ambiguas con LCP | Sin ganancias con PCP ni con LCP; sí con el dólar, unilaterales (C-P, 2009, § 7.1; Devereux y Engel, 2003) |
| I.2 (l. 919-921) | «Modelo de Corden (1994)» que parte de «Oudiz y Sachs (1974)» | Diagrama de Hamada (1974, 1976), en la versión de Corden (1994); Oudiz y Sachs (1984) |
| I.2, programa (l. 947) | $\min_{\{\pi\}}$ | $\min_{M_A}$ (el instrumento) |
| I.2, evidencia (l. 871, 1088) | 0,5-1 % del PIB (McKibbin) | Medio punto del PNB al año para EE. UU. y 1,6 % del PNB en 1982 (Oudiz y Sachs, 1984); McKibbin sin cifra |
| Conclusión (l. 1552) | Oudiz y Sachs (1994) | 1984 |
| II.1, guerra de divisas (l. 1257) | Fed: «2 rondas de QE entre 2009 y 2011» | 3 rondas: noviembre de 2008, noviembre de 2010 y septiembre de 2012 |
| II.1 (l. 1261) | QE del BCE «en 2014-2015» | Compras de deuda pública desde marzo de 2015 (anunciadas el 22/1/2015) |
| II.1 (l. 1273) | Rousseff, sin año (contexto 2010) | «Tsunami monetario» en 2012 (Frankel, 2016) |
| II.1 (l. 1299, P47) | «Cumbre del G-7 de 2013… el ejemplo más significativo hasta hoy» | Declaración de ministros y gobernadores del 12/2/2013; «el ejemplo reciente más importante», según Frankel (2016) |
| II.1 (l. 1191) | Los republicanos ganaron «el Congreso» en 2010 | La Cámara de Representantes |
| II.1 (l. 1229) | «El PEC y su revisión en 2011» | Reforzado en 2011 y reformado en 2024 (Reglamentos 1175/2011 y 2024/1263) |
| II.2 (l. 1394, P50) | Rogoff (1982), explicado al revés | Rogoff (1985), *JIE*: coordinar solo a los bancos centrales elimina el freno de la depreciación y sube la inflación |
| II/III, FSB (l. 1331, P46) | El FSB sustituyó al FSF «en 2013»; «dio lugar a las ratios de Basilea» | Abril de 2009 (Londres); asociación suiza desde el 28/1/2013; Basilea es del Comité de Basilea |
| Conclusión (l. 1564, P35) | «Acuerdos G-7 (Imposición – 3.B.21)» | Fiscalidad internacional: 2 pilares, `\vertema{4.B.18}` |
| Erratas (C29) | locomotara, parasemos, deprecación, «política monetaria fiscal», continue, «evitar al existencia», contario | Corregidas o desaparecidas con los recortes |

## 3. Marcas resueltas

| Marca | Qué decía | Qué se hizo |
|---|---|---|
| P1 (amarillo, l. 753-757) | Por qué importa el LCP: más rigidez nominal y respaldo empírico | Integrado en I.1.2 («Por qué importa el caso LCP») con Gopinath *et al.* (2020) y remisión al 3.A.37 |
| P2 (amarillo, l. 759) | Con LCP el tipo de cambio mueve poco el comercio | Integrado: sin desvío del gasto (*expenditure switching*) |
| P3 (amarillo, l. 761-763) | La partida de ajuste y Betts y Devereux | Integrado: sobrerreacción con *pricing to market* (Betts y Devereux, 2000) y `\vertema{3.B.14}` |
| P4 Nota al opositor (cambio de temario) | Aviso de 2023 y captura de la guía | Desaparece; su estructura guía la de 3 apartados; nueva `notaopositor` con el reparto del cante |
| P5 Comentario (enlaces de un preparador) | Frankel (2016), Broz y Frieden, New Palgrave | Las 3 obras citadas en el `.bib` y en la caja de lecturas; el comentario no se publica |
| P6 Comentario («aquí o en la conclusión») | Dónde va el ciclo financiero global | En I.1 (resumen) con `\vertema{3.B.15}` y caja de Rey |
| P7 Comentarios de la bibliografía | Notas privadas sobre otros temas | Fuera; bibliografía rehecha con biblatex |
| P9 Caja de Rey | Vídeo, cita en inglés y enlace a helenerey.eu | Conservada en `anotaciones`, cita traducida con la nota 17 y enlaces comprobados (`Rey2013Video`, `Rey2013Dilema`) |
| P10 Caja del cártel | Colusión con ecuaciones e imagen | Reducida a la condición del gatillo aplicada a gobiernos (`eq:gatillo`) y remisiones al 3.A.14 y 3.A.19 |
| P11 Caja del anexo 1 | Enlace al blog «Oberturas fiscales» | Conservado (`GarciaAndres2019Oberturas`) en el anexo C, con resumen propio |
| Notas al pie en inglés (1, 4, 11, 14-16, 21) | Párrafos copiados de Bergin (2008) y C-P (2005) | Traducidos e integrados con cita (C30); la 12 (τ), como nota y en el anexo A; la 20, en el anexo A; la 22 (Stackelberg), en I.2 c) |
| Valoración y apartado 2 vacíos (l. 1514-1532) | Solo títulos | Redactados (III.1 y III.2) |
| «Relevancia», «Extensiones», «Opinión» vacías (conclusión) | — | Redactadas |

No había texto rojo, oculto ni «No cantar» (P8).

## 4. Datos actualizados

| Dato | Anterior | Nuevo | Fuente (clave) | URL | Consulta | 2.ª comprobación |
|---|---|---|---|---|---|---|
| Enganche | Flujos de capital de 2020 | Johannesburgo, 22-23/11/2025, sin EE. UU. | `G20Johannesburgo2025` | g20.utoronto.ca/2025/251122-declaration.html | 11/11/2026 | Agencias (`CBS2025G20Johannesburgo`, CBS) |
| Bonn 1978 | Sin cifras | Alemania hasta el 1 % del PNB; Francia 0,5; Japón +1,5 puntos | `G7Bonn1978Declaration` | g7.utoronto.ca/summit/1978bonn | 11/11/2026 | Frankel (2016) |
| Plaza / Louvre | Solo años | 22/9/1985 (G-5); 22/2/1987 (G-6); Tokio, mayo de 1986 | `G51985Plaza`, `G61987Louvre` | g7.utoronto.ca/finance | 11/11/2026 | Frankel (2016) |
| Londres 2009 | Sin cifras | 5 billones de dólares de expansión; 1,1 billones adicionales; FMI ×3 hasta 750.000 M | `G20Londres2009` | g20.utoronto.ca/2009 | 11/11/2026 | Frankel (2016) |
| Toronto 2010 | — | Déficits de las avanzadas a la mitad antes de 2013 | `G202010Toronto` | (clave del 3.A.40) | 11/11/2026 | 3.A.40 |
| QE | 2 rondas 2009-2011; BCE 2014-2015 | 3 rondas (2008, 2010, 2012); BoJ abril de 2013; BCE marzo de 2015 | `Fed2008QE`, `Fed2010FOMCnov`, `Fed2012FOMCsep`, `BoJ2013QQE`, `BCE2015APP` | federalreserve.gov, boj.or.jp, ecb.europa.eu | 11/11/2026 | Frankel (2016) |
| G-7 2013 | «Cumbre» | Declaración de ministros y gobernadores, 12/2/2013 | `G72013Divisas` | g7.utoronto.ca/finance/fm130212.htm | 11/11/2026 | Frankel (2016), p. 13 |
| Fed, normalización | 2018 | 16/12/2015 y octubre de 2017 | `Fed2015FOMCdic`, `Fed2017Balance` | federalreserve.gov | 11/11/2026 | 3.A.40 |
| G-20: origen y miembros | — | 1999 (Berlín); líderes desde Washington, 2008; 19 + UE + Unión Africana (2023) | `G201999Berlin`, `G20NuevaDelhi2023` | g20.utoronto.ca | 11/11/2026 | FSB (`FSB2026Miembros`) |
| G-20: peso | — | ≈85 % PIB, 75 % comercio, 2/3 población | `G20Acerca` | g20.org/about-g20 | **[comprobar]** (403) | Ficha `g20-ocde` del canon |
| G-20: presidencias | — | Sudáfrica 2025; EE. UU. desde 1/12/2025, Miami 14-15/12/2026, sin Sudáfrica invitada; Reino Unido 2027 (Manchester) | `G20RG2026Miami`, `EEUU2026Miami`, `ReinoUnido2026Manchester` | g20.utoronto.ca, state.gov, gov.uk | 11/11/2026 | Wikipedia y nota británica |
| DSSI | — | Más de 12.000 M$ de casi 50 países (2020-2021); Marco Común (11/2020) | `G202020DSSI`, `G202020MarcoComun`, `G20Roma2021`, `BancoMundial2022DSSI` | g20.utoronto.ca, worldbank.org | 11/11/2026 | Las 2 fuentes difieren (12.700 M$ y 50 países / 12.900 M$ y 48): redacción que vale para las 2 |
| OCDE | — | Convenio 14/12/1960, 20 firmantes, España fundadora; 38 miembros, 8 candidatos; Cormann, 2.º mandato desde junio de 2026 | `BOE1963OCDE`, `OCDE2026Miembros`, `RRI2026Rumania`, `OCDE2025Cormann` | boe.es, oecd.org | 11/11/2026 | oecd.org **[comprobar]** (403) |
| FSB | 2013 | Abril de 2009; asociación suiza desde enero de 2013; Bailey desde julio de 2025 | `FSB2026Historia`, `FSB2025Bailey`, `FSB2026Miembros` | fsb.org | 11/11/2026 | `G20Londres2009` |
| FMI, ESR | — | ESR de 30/7/2026: saldos excesivos crecen en 2025; mejor corregir a la vez | `FMI2026ESR` | imf.org | 11/11/2026 | 3.B.11, 3.B.12 (mismas cifras) |
| Anexo C (gráfico) | Imagen del blog (WEO abr. 2019, aprox.) | 2019 y 2025: cc 7,8/6,9/3,4 → 4,5/7,6/6,5; saldo público 1,3/1,9/0,8 → −2,9/−1,6/−2,3 | `FMI2026WEOdatos` (CSV en `datos/`) | data.imf.org | 11/11/2026 | Eurostat y OCDE EO 119 (±0,3) |
| Alemania 2025 | — | Reforma del freno de la deuda: defensa fuera y fondo de 500.000 M€ en 12 años | `Bundestag2025Grundgesetz` | recht.bund.de | 11/11/2026 | Despachos de abogados y agencias (C19) |

Todos los datos que caducan están en `datos-actualizables.yaml` (presidencias del G-20, peso del G-20, miembros de la OCDE, secretario general, presidente del FSB, ESR, DSSI, gráfico del WEO, freno de la deuda alemán). **Caduca el 1/12/2026** el «preside el grupo en 2026» del enganche y **el 15/12/2026** la cumbre de Miami.

## 5. Contenido añadido

- Introducción con sus 5 bloques (C2, K2): refrán «Cada uno en su casa y Dios en la de todos», Johannesburgo 2025 frente a Londres 2009, escalera de la cooperación, 3 etapas de las ideas (Bergin, 2008).
- I.1: 2 motivos y 5 canales; ciclo financiero global en resumen (Rey, 2013; Miranda-Agrippino y Rey, 2020; Habib y Venditti, 2018); Mundell-Fleming con 2 países con la fiscal (locomotora) y el modelo en 4 ecuaciones; Corsetti-Pesenti como tema de referencia, con PCP, LCP y dólar y las ganancias de coordinar comprobadas en el artículo.
- I.2: diagrama de Hamada completo (pérdida, programa con `\optim`, reacciones, N, lente, curva de contrato, núcleo), repetición con la matriz de la locomotora y `eq:gatillo` con los pagos del canon.
- II.1: línea del tiempo (`tab:cronologia`), Bonn, Londres, Toronto, policy mix entre países (sin gráfico, D-K12), disciplina fiscal, guerra de divisas con el matiz del límite inferior (Eichengreen y Sachs, 1985), *swaps*, Plaza y Louvre como batalla de los sexos, y el **ajuste simétrico de Keynes** (K12.6, el texto que piden el 3.B.11 y el 3.B.12).
- II.2: Frankel y Rockett (1988), Putnam (1988, juegos de 2 niveles), Broz y Frieden (2013).
- III.1 (nuevo): qué hace un foro (repite, informa, vigila, liga asuntos), amplitud, profundidad y tamaño, clubes (Nordhaus, 2015) y la escalera con los foros (`fig:escalera`).
- III.2 (nuevo): G-20, OCDE y otros foros (G-7 y Club del Clima, FSB, FMI con su visión institucional de 2012 y 2022, BPI, OMC, Club de París, UE, ICN, Davos, ASEM) con la misma plantilla y valoración.
- Anexos: A (τ_B, reforma estructural y dólar con sus gráficos), B (tablas de disciplina y guerra de divisas, 2 lecturas de la posición alemana, batalla de los sexos), C (países con superávit, rehecho), D (enlace genérico al simulador de test).

### Propuestas: aplicadas y no aplicadas

**Contenido (C)**
- Aplicadas: C1-C5, C7-C14, C15 (con cambios), C16, C17, C18 (repartida entre II.3 y III.1, ver K14), C19 (repartida en II.1 y II.3), C20, C21, C22, C23, C24, C25, C28, C29, C30, C40, C46, C47, C48, C49.
- C6 y C10: aplicadas en el anexo A, con los gráficos que ha dibujado el coordinador (puntos $O'$, $O_B'$, $D$, $\ell_D$, $H$ en gris).
- C15: γ es el peso de la inflación (canon § 8); el poder negociador es $\omega$; «punto de felicidad» con $F_A$, $F_B$; sin `eq:cooperacion` como función clave.
- C19: no se aplica la frase de la cláusula de la moneda escasa (no comprobada en el Convenio del FMI); el arrepentimiento alemán de Bonn sí (Frankel). La frase de Alemania 2025 va al anexo C, no al cuerpo. Rousseff se mantiene con su año.
- C20: «12.900 M$ de 48 países» se cambia por «más de 12.000 M$ de casi 50 países» para casar con V37; la viñeta de límites usa Johannesburgo (C49) y la exclusión de Sudáfrica de Miami con `G20RG2026Miami` (`EEUU2026G20` no existe en el `.bib`). Brisbane 2014 (+2 % del PIB) no se añade: sin fuente comprobada.
- C21: sin la referencia del Reglamento (UE) 1233/2011 (sin entrada en el `.bib` ni comprobación del DOUE): se dice que la UE incorporó el Consenso a su derecho. Sin fechas exactas de la OECE, la entrada en vigor y Costa Rica (V34: no vistas en oecd.org). `OCDE1960Convenio` y `OCDE2021DosPilares` no existen: se citan `BOE1963OCDE` y `G20Roma2021`. Sin el paquete «lado a lado» de enero de 2026 (solo fuentes secundarias).
- C22: aplicada; la RIC y Davos en una línea, con ASEM (Word del 3.B.35).
- C26 (juego de la gallina España-BCE): **fuera**, sin línea (decisión del coordinador); ya está en el 3.A.14 con sus fuentes y no es coordinación entre países.
- C27 (blog de 2019): el texto pegado sale; queda el anexo C con resumen propio, cita, enlace y gráfico nuevo.
- C45: no toca este tema (pasa al canon: ver Coherencia).

**Datos (V)**: aplicados V1, V6-V8, V10, V12-V31, V33-V40, V44-V47, V49, V50. V2 desaparece con el recorte del modelo de un país. V9: McKibbin sin cifra. V32 (salidas de 2020): no se usa (el enganche cambió). V41 (Euro Plus): no se menciona (sin fuente primaria). V42: desaparece con la caja del cártel. V43: GEM citado con `Bayoumi2004GEM`. V48: fuera, sin fuente.

**Coherencia (K)**: aplicadas K1-K7, K9-K22, con estos cambios: K12.2 sin el gráfico del policy mix (D-K12); K12.5 (gallina) fuera del todo; K13 sin el dicho en el cuerpo de los obstáculos (iba en la guerra de divisas; quitado el 13/11/2026); K14: amplitud, profundidad y tamaño en III.1 (no en II.3), como pide K14; K16: Brisbane, presupuesto de la OCDE y Rambouillet sin fecha (sin fuente); K18-K19: anexo A, B y C como propone K19, más el anexo D de test.

- Control de calidad (12/11/2026): en III.2.3 (FMI), una línea sobre el ejercicio de alerta temprana del FMI y el FSB desde 2009 (`FMI2010EWE`, la misma clave del 3.B.17), porque el 3.B.17 remite aquí.

## 6. Coherencia

- **Notación**: la del canon y del 3.A.37: $\chi$, $\ell$, $\mu$ (tono, avisado), $\tau$ y $\tau_B$, $\beta_K$ para la movilidad y $\beta$ para el descuento, $\gamma_i$ peso de la inflación, $\omega$ poder negociador (local). Puntos del gráfico de referencia: $O$, $R$, $F$, $H$, $L$ (3.A.37) y $O'$, $O_B'$, $D$ en los anexos.
- **Gráficos de referencia**: `mundell-fleming-dos-paises` y `corsetti-pesenti` copiados sin cambios del 3.A.37; este tema pasa a ser su referencia (fichas `mundell-fleming` y `corsetti-pesenti`); `hamada` es nuevo.
- **Cifras compartidas**: Toronto 2010 y el FMI 2 % con las claves y frases del 3.A.40; ESR de 2026 con la clave del 3.B.11, 3.B.12 y 3.B.14; G-20 con las cifras de la ficha `g20-ocde`; pilar 2 (15 %, 750 M€) como la ficha `pilares-ocde`; Club del Clima como el 3.B.31.
- **Remisiones que se cumplen**: 3.A.37 (fiscal con 2 países y C-P), 3.A.38 (locomotora), 3.A.40 (el G-20 coordinó 2009), 3.B.11 y 3.B.12 (ajuste simétrico de Keynes, MAP de Pittsburgh), 3.B.15 (guerra de divisas: aquí el desarrollo), 3.B.31 (Club del Clima sin aranceles y clubes).
- **Para cambiar en otros temas** (no se tocan aquí; para `pendientes-coherencia.md` en la fase canon):
  - **Ficha `corsetti-pesenti`**: su «Resultado» dice que con LCP hay ganancias de coordinar; el artículo (§ 7.1) y Devereux y Engel (2003) dicen que no (sí con el dólar, unilaterales). Texto propuesto en C45.1. Su gráfico de referencia pasa a ser el de este tema (el mismo del 3.A.37) y la clave del modelo, `CorsettiPesenti2009`.
  - **3.B.35** (sin revisar, D119): quitar la sección IV (G-20, OCDE) y remitir aquí; no copiar sus errores («90 % del PIB», «duplicar los recursos del FMI», «18 países», Turquía 2 veces, «G-8» con Rusia, fuente Wikipedia).
  - **3.B.21** (sin revisar): narra Plaza, Louvre y Londres; que use las fechas y claves de aquí (`G51985Plaza`, `G61987Louvre`, `G20Londres2009`, «triplicar» los recursos del FMI).
  - **3.A.14 l. 1786**: la batalla de los sexos remite al 3.B.45 la coordinación entre países; debería remitir al 3.B.19 (anexo B).
  - **3.B.10 l. 779**: remite al 3.B.19 la coordinación de la unión económica, que es del 3.B.45.
  - **Ficha `policy-mix`** y `pendientes-coherencia.md` l. 965: el 3.B.19 da el mix entre países en una viñeta, sin el gráfico (D-K12); corregir la entrada.
  - **`mapa.yaml`**: quitar `juego-coordinacion` (sin ficha) y añadir una fila 3.B.19 a `dilema-prisionero` (locomotora, disciplina y guerra de divisas con los pagos del canon); `g20-ocde` con 3.B.19 como referencia hecha; el `faltan` 3.A.32 dice «IS-LM-BP de dos países» (es de uno).
  - **Ficha `ciclo-financiero`**: referencia en el 3.B.15 (aplicado aquí: resumen y remisión).
  - **Ficha `hamada-coordinacion`** (o fila en `dilema-prisionero`): pendiente de decisión; el diagrama de aquí sería su referencia. Koichi Hamada frente a Robert Hamada (3.B.2, 3.B.3, 3.B.23): avisado en una nota al pie.
  - **Refranes**: este tema usa «Cada uno en su casa y Dios en la de todos» (enganche) y «¿quién le pone el cascabel al gato?» (integrado en la idea de Hamada; «Mal de muchos, consuelo de tontos» se quitó el 13/11/2026); añadirlos a CRITERIOS § 8 al aprobarse y comprobar que el 3.B.15 y el 3.B.17 no los usan.

- Control de calidad (12/11/2026): en I.1.1 iii, la política monetaria con tipo flexible es un juego de «suma negativa» (no «suma cero»), como en el anexo B y en el 3.B.15; el título del II corta con `\cortetitulo` tras «La cooperación económica» para que «reciente» no quede sola.

## Puesta al día con las reglas de esta rama (13/11/2026)

Tema traído de la rama `revision-temario`; adaptado a las reglas de las tandas 4.ª-9.ª y de la revisión transversal, sin quitar contenido.

| Regla | Cómo se ha aplicado |
|---|---|
| Citas (5.ª y 7.ª tanda) | 112 `\parencite` pasan a `\nocite` (script); revisadas las frases. Los `\textcite` quedan solo donde el autor es sujeto; el de `Friedman1971Supergames` pasa a «\autor{James W. Friedman} (1971)» para no confundirlo con Milton Friedman |
| Anexo de test (7.ª) | Caja estándar `anotaciones` con `?tema=3.B.19`; fuera la cita `GutierrezMarcos2026Simulador` y su entrada del `.bib` (8.ª, regla 1) |
| Figura / Gráfico / Imagen | `escalera-cooperacion` es un esquema sin ejes: pasa a `infografia`, `figu:escalera`, «figura». Los otros 7 siguen como gráfico (ejes o datos). No hay imágenes pegadas |
| Pegatinas y dichos (8.ª, 9.ª) | Se queda el refrán del enganche («Cada uno en su casa y Dios en la de todos»), que retoma la idea final. «¿Quién le pone el cascabel al gato?» se integra sin etiqueta en la idea de Hamada, explicando la relación (cada país espera a que se mueva el otro). «Mal de muchos, consuelo de tontos» (guerra de divisas) se quita: no estaba en el tema antiguo y repetía la frase anterior. Ninguno de los 3 venía del tema antiguo (`3B19-anterior.pdf`) |
| Estructura rígida de modelo (8.ª) | Mundell-Fleming, Corsetti-Pesenti y Hamada ya tenían a)-e). «La repetición» (I.2.2) pasa a a) Idea, b) Modelo (i supuestos con la matriz de la locomotora, ii desarrollo con `eq:gatillo`, iii implicaciones) y c) Valoración, sin quitar nada |
| Resultados clave en morado | Ya lo estaban: `eq:corsetti-pesenti`, `eq:hamada`, `eq:gatillo` |
| Términos en inglés | NOEM: «(\emph{new open economy macroeconomics}, NOEM)»; FSB: «(\emph{Financial Stability Board}, FSB)»; el resto ya estaba |
| Remisiones | La frase «(no confundir con las «generaciones» de crisis del \vertema{3.B.17})», gramaticalmente dependiente de la remisión y sin sentido aquí, se sustituye por la diferencia real con Hamada (funciones de pérdida postuladas) |
| Nobel (transversal) | Notas nuevas en la primera mención: \autor{Nash} (1994), \autor{Milton Friedman} (1976), \autor{Mundell} (1999; estaba en el tema antiguo, nota 5, y se había perdido), \autor{Stiglitz} (2001, con \autor{Dixit}), \autor{Lucas} (1995), \autor{Nordhaus} (2018) y \autor{Woodford} (2026, con una frase en la idea de la NOEM: su modelo neokeynesiano con microfundamentos es el marco de Corsetti-Pesenti). Entradas copiadas de otros temas (`Nobel1994Nash`, `Nobel1976Friedman`, `Nobel2001AkerlofSpenceStiglitz`, `NobelPrize1995Lucas`, `Nobel2018Nordhaus`, `Nobel2026Prensa`) |
| 4.º ejercicio | Relevancia para España: la respuesta fiscal de 2008-2009 dentro del estímulo concertado del G-20 \vertema{4.A.28}; ajuste simétrico: España vivió el lado deficitario tras 2008 \vertema{4.A.21}. Ya estaban \vertema{4.A.24} (Consenso de la OCDE) y \vertema{4.B.18} (2 pilares) |
| Pizarra / vídeo en el texto | No había; las «pegatinas» de «Instrucciones para el vídeo» y de «Coherencia» se han reescrito |
| NEK (x,π), identidad contable | No aparecen en el tema |
| Compilación | `construir-tema.py 3B19 --solo pdf --no-publicar`: 28 páginas de tema, 5 de anexos, 7 de bibliografía. `verificar-tema.py`: solo los 3 errores de PDF/HTML/Word publicados anteriores a la fuente y avisos de «cifra sin cita» ya existentes |

Dudas nuevas: 18 y 19 (abajo).

## 7. Dudas abiertas

Víctor está fuera: cada duda lleva aplicada la opción recomendada.

1. **3 apartados** (D-K1): aplicada (el 1.3 del original sube a II y el 2 vacío pasa a III). Alternativa: 2 apartados como el original.
2. **Policy mix** (D-K12): sin el gráfico del 3.A.40, con una viñeta entre países en II.1. Alternativa: copiar `fuentes/3A40/graficos/policy-mix.tex` a un anexo.
3. **Ficha `hamada-coordinacion`** (D-CC3): no se crea de momento; Hamada se cuenta con notación local ($\omega$, $F_A$, $F_B$) y una nota al pie distingue a Koichi de Robert Hamada.
4. **Referencia del ciclo financiero global** (CC4): el 3.B.15; aquí, resumen y caja de Rey.
5. **LCP sin ganancias y ficha `corsetti-pesenti` a corregir** (CC1): el tema dice lo comprobado en el artículo; la ficha hay que corregirla en la fase canon. Ganancias con LCP fuera de la versión simple (Corsetti, Dedola y Leduc, 2010; Engel, 2011): no citadas, sin comprobar.
6. **$\tau_B$ con $\mu^*$**: mezcla de notación que viene del canon ($E=\mu/\mu^*$) y del 3.A.37 ($\tau_B$). Proponer al canon $\mu_B$ o dejarlo. En el anexo A, $P_B$ es el IPC de B.
7. **Enganche y refrán**: Johannesburgo 2025 (hecho comprobado con la declaración y agencias) en vez de Miami 2026 o los flujos de 2020; «Cada uno en su casa y Dios en la de todos», que la idea final retoma. Caduca el 1/12/2026 («preside en 2026»).
8. **El juego de la gallina España-BCE**: fuera del todo (está en el 3.A.14). Si se quiere, una línea en II.1 con `\vertema{3.A.14}`.
9. **Oudiz y Sachs (1984)**: se usan las cifras de las pp. 2 y 4 (medio punto del PNB al año, 1,6 % del PNB en 1982); algunas tablas del artículo dan ganancias menores (0,17 % en 3 años, modelo MCM).
10. **`McKibbin1997Empirical`**: entrada escrita sin ver el volumen (editores, editorial y año de memoria): comprobar o quitar la cita de I.2 d).
11. **oecd.org y g20.org sin ver** (403 a programas): **[comprobar]** en el navegador las cifras del peso del G-20 (85/75/2/3, `G20Acerca`, entrada creada sin poder abrir la página), los 38 miembros y 8 candidatos, el segundo mandato de Cormann y que los 20 firmantes del Convenio de 1960 son los 18 europeos más EE. UU. y Canadá.
12. **Rumanía**: tenía 24 de 25 dictámenes en abril-junio de 2026; si el Consejo de la OCDE ya la ha invitado, decirlo en III.2.
13. **Broz y Frieden (2013)**: el PDF del original (scholar.harvard.edu) da 403; no se ha podido ver que sea ese capítulo. Se cita con prudencia en II.2 (argumento del proteccionismo, del resumen de la versión de trabajo).
14. **Putnam (1988)**: añadida de memoria (*International Organization* 42(3): 427-460) para los juegos de 2 niveles; comprobar el DOI.
15. **La gráfica `mundell-fleming-dos-paises-fiscal`** tiene la LM de B algo más inclinada para que las rentas no suban igual; la caja de las 4 ecuaciones dice que, con LM iguales, suben lo mismo. Coherente, pero Víctor puede preferir LM iguales.
16. **DSSI**: G-20 (12.700 M$, 50 países) y Banco Mundial (12.900 M$, 48 países) difieren; el texto dice «más de 12.000 millones de casi 50 países».
17. **Sudáfrica en Miami**: se ha quitado «y no ha invitado a Sudáfrica a la de Miami» de los límites del G-20 (III.2.1): no hay en el `.bib` un anuncio oficial de EE. UU. (26-27/11/2025) ni una noticia de agencia que lo compruebe, y el G20 Research Group no basta. Si Víctor quiere recuperarlo, hace falta esa fuente.

18. **Dichos** (13/11/2026): se conserva «¿quién le pone el cascabel al gato?» integrado en la idea de Hamada y se quita «Mal de muchos, consuelo de tontos». Alternativas: (a) quitar también el del cascabel; (b) recuperar el segundo integrado en la guerra de divisas. **Aplicada: conservar uno (recomendada).**
19. **La repetición como modelo** (13/11/2026): I.2.2 pasa a la estructura a)-c) (sin Extensiones ni Evidencia, que no tenía). Alternativa: dejarlo como aplicación de Hamada sin bloques. **Aplicada: estructura de modelo (recomendada, regla rígida de la 8.ª tanda).**

## Ficha de repaso (13/11/2026)

- `repaso/3B19-repaso.tex`, nueva, con el modelo de las fichas de esta rama (3B27, 3B13, 3B28). `construir-repaso.py 3B19 --no-publicar`: **4 páginas, 10 pt; última página al 90 %**; `verificar-tema.py 3B19` sin errores de la ficha (solo los 3 de los formatos publicados anteriores a la fuente).
- Contenido, todo sacado del tema: esquema del cante con minutos y plan de pizarra; los 5 bloques de la introducción; I con Mundell-Fleming (pareja fiscal/monetaria y resumen en 4 ecuaciones), Corsetti-Pesenti (3 curvas en morado, gráfico de referencia, reforma y dólar), Hamada (pérdida en morado y diagrama) y la repetición (gatillo en morado); II con los episodios, obstáculos y formas; III con la figura de la escalera y los foros; conclusión; definiciones, datos clave (con el gráfico del anexo C), tablas de Mundell-Fleming, línea del tiempo, los 3 juegos de Frankel y los foros de un vistazo; autores y fechas; 12 preguntas del tribunal; «Ojo en el test».
- Dicho: solo «quién le pone el cascabel al gato», integrado, como en el tema. En la tabla de foros solo hay datos del tema (OMC y UE sin año ni miembros, porque el tema no los da). Las indicaciones de pizarra van solo en la ficha (bloque «Pizarra» bajo el esquema del cante), no en el tema.
- Común (no se toca): con un título largo, el pie de página de la ficha pisa el «© 2026 Víctor Gutiérrez Marcos» (se ve en las 4 páginas); es de `tcee-repaso.sty`, para quien mantenga la plantilla.

## 8. Instrucciones para el vídeo

- **Introducción** (2′30″): sin pizarra, modo guion con los 5 bloques. Enganche: el refrán «Cada uno en su casa y Dios en la de todos» y las 2 cumbres (Londres 2009, Johannesburgo 2025); pregunta: «¿basta con que cada país ponga orden en su casa, o hay problemas que solo se arreglan entre todos?».
- **I.1** (8′30″):
  - los 5 canales, 5 palabras en una columna estrecha;
  - Mundell-Fleming: solo se dibuja la **expansión fiscal** (`mundell-fleming-dos-paises-fiscal`), por partes: panel A (IS→IS′, sube $i^*$) y después panel B (IS′, sube la renta: locomotora); la monetaria (`mundell-fleming-dos-paises`) va de **apoyo**, y de la tabla solo se escribe la fila del tipo flexible;
  - Corsetti-Pesenti: el recuadro con las 3 curvas `eq:corsetti-pesenti` (**función clave**) y el gráfico de referencia por capas: panel a, $O\to R\to F$; panel b, $H$ con PCP y $L$ con LCP. El dólar, la reforma y τ (anexo A), solo de apoyo si el tiempo sobra.
- **I.2** (4′): `eq:hamada` (**función clave**) y el diagrama por capas (rayo $E_0$, $F_A$ y $F_B$, círculos, reacciones, $N$, lente, curva de contrato, núcleo); el dicho «¿quién le pone el cascabel al gato?» se dice de palabra al presentar el polizón. La matriz de la locomotora y `eq:gatillo` (**función clave**) se quedan en una esquina con `conservar:`.
- **II** (6′):
  - II.1: la **línea del tiempo** (`tab:cronologia`) se dibuja como una flecha horizontal con los años (1944, 1978, 1985-1987, 1999, 2009, 2010, 2013, 2020-2021, 2025), que crece mientras se cuentan los episodios; sobre la matriz de la locomotora que se conservó se tachan los rótulos: Expandir → Consolidar / Gastar (disciplina) → Contener / Depreciar (guerra de divisas). El ajuste simétrico de Keynes, de palabra;
  - II.2: los 5 obstáculos económicos en 5 palabras (polizón, contraproducente, incertidumbre, preferencias, reparto) y 2 políticos; II.3, de palabra.
- **III** (8′):
  - III.1: la **escalera de la cooperación** (`escalera-cooperacion`), peldaño a peldaño, con los foros en cada uno; se queda en la pizarra para III.2;
  - III.2: de palabra con 3 datos por foro (año, miembros, un hito), completando la escalera con el año y el número de miembros junto a cada foro; G-20 2′30″, OCDE 2′, otros 2′.
- **Al final**, la pizarra queda con la escalera completa, la matriz con sus rótulos tachados y las 3 funciones clave.
- **Conclusión** (1′): sin pizarra; empieza por «A modo de conclusión,» e **idea final** que retoma el refrán: poner orden en la propia casa es la primera regla, pero cuando la casa de uno ocupa media calle, la de todos también es suya.
- Lo que no se canta: anexos A-D, la caja de las 4 ecuaciones, el tipo fijo, la evidencia de M-F, las extensiones de C-P, Stackelberg, el detalle de los órganos e instrumentos de la OCDE y los foros menores (BPI, Club de París, RIC, Davos, ASEM).

## Listas en las notas al pie (15/11/2026)

Ninguna nota lo necesitaba.

## Comentarios de Víctor (16/11/2026)

Estructura antes: I. Análisis teórico (1. Condición necesaria: desbordamientos [M-F 2 países; C-P]; 2. Condición suficiente: teoría de juegos [Hamada; la repetición]) · II. La cooperación en la historia reciente (1. Ejemplos, con a)-d); 2. Obstáculos; 3. Formas) · III. Economía política (1. Por qué hacen falta foros; 2. G-20, OCDE y otros). Minutos 2,5 + 12,5 + 6 + 8 + 1. Cuerpo: **28 páginas** (anexos 5; total 40).

Estructura después (la propuesta por Víctor): I. Aspectos teóricos: justificación y deseabilidad (15′): 1. Justificación: los desbordamientos como condición necesaria (1.1 Modelo estático: IS-LM-BP; 1.2 Modelo dinámico con expectativas racionales: Corsetti y Pesenti); 2. Deseabilidad: las ganancias como condición suficiente. Teoría de juegos (2.1 Hamada y Corden; 2.2 Juegos repetidos: cómo se obtiene la cooperación); 3. Obstáculos, formas de coordinación y por qué hacen falta foros (3.1 Obstáculos; 3.2 Formas; 3.3 La problemática de teoría de juegos) · II. Aspectos prácticos (1): el G-20, la OCDE y otros foros internacionales (7′): 1. G-20; 2. OCDE; 3. Otros foros (3.1 G-7; 3.2 FMI, FSB y BPI; 3.3 Foro de Davos; 3.4 ASEM; 3.5 OMC, Club de París y UE) · III. Aspectos prácticos (2): la cooperación en la historia reciente (4′30″): 1. La línea del tiempo; 2. La política fiscal; 3. La monetaria; 4. Los tipos de cambio; 5. ¿Quién ajusta? Minutos 2,5 + 15 + 7 + 4,5 + 1 = 30. Cuerpo: **40 páginas** (anexos 15; total 63). Anexos: A, Mundell-Fleming en distintos escenarios (nuevo); B, Corsetti y Pesenti: reforma y dólar (antes A); C, juegos; D, superávit; E, test.

| Comentario | Cómo se ha aplicado |
|---|---|
| «Mundell-Fleming… en un anexo muchos ejemplos… lógica paso a paso… por qué se desplaza cada curva» (también en los gráficos del cuerpo) | Nuevo anexo A con 6 figuras y pasos numerados en gráfico y texto: país pequeño con movilidad perfecta (2×2), imperfecta (2×2, se mueven IS y BP), nula (2×2); 2 países grandes con tipo fijo, monetaria y fiscal; el tamaño del país (pequeño, grande, cerrada; monetaria y fiscal), y tabla resumen de todos los escenarios. Los 2 gráficos del cuerpo llevan ahora los pasos 1-5 numerados (círculos), flechas y leyenda, y el texto del desarrollo sigue esos números. En el fiscal se corrigió la geometría: el tipo mundial subía a 3,2, por encima de lo que subiría el de A siendo cerrada (3,17); ahora 3,0, con IS′ bruta e IS″ tras la apreciación. |
| Corsetti y Pesenti: a) cada función con su fórmula numerada | Preferencias \eqref{eq:cp-utilidad} (con la curva de indiferencia), AD \eqref{eq:cp-ad}, AS \eqref{eq:cp-as}, $\tau$ \eqref{eq:cp-tau} (antes en nota), NR \eqref{eq:cp-nr} y $E$ \eqref{eq:cp-e}, cada una por separado; las 4 curvas, en morado. Sustituyen a `eq:corsetti-pesenti` (y `eq:tau-b` pasa a nota del paso 4). |
| b) representación gráfica desde las ecuaciones, paso a paso; la economía cerrada (sin $\tau$) ayuda, incluida la curva de indiferencia | El desarrollo va por pasos, cada uno un escenario con su gráfico: paso 1, las 3 curvas en la cerrada (`cp-cerrada-paso1`); paso 2, equilibrio $O$, curva de indiferencia $U_O$ que corta la AS desde arriba y punto eficiente $X$ (`cp-cerrada-paso2`); paso 3, $Z\uparrow$ con precios rígidos ($B$), flexibles ($A$) y la respuesta monetaria (`cp-cerrada`); paso 4, la economía mundial (`cp-pcp-paso1`); paso 5 y escenarios 1-3: PCP (`cp-pcp`), LCP (`cp-lcp`) y dólar (anexo). La economía cerrada va en el cuerpo (no en caja gris), porque es la base del resto; en caja gris solo la derivación de la NR. |
| c) colores como en el paper y las slides originales | El código de colores del artículo (NBER WP 11341, figuras 1-13): negro, lo inicial; azul, lo exógeno ($Z$, $\mu$, $\sigma$); rojo, lo endógeno ($P$, $\tau$, $C$, $\ell$), con las flechas de giro de las AS y los números de paso. Se explica en el texto y en el pie de cada gráfico. Las *slides* no las he encontrado enlazadas en el tema (ver duda). |
| d) infografía completa M-F frente a C-P | Figura `mf-vs-cp` (página entera, al final de I.1.2): cabecera con un esquema de cada modelo y tabla por bloques (supuestos, desarrollo, implicaciones, valoración) y franja «En qué se parecen». En la ficha, una tabla resumida. |
| Anexo A de C-P coherente | Ahora anexo B: reforma (`cp-reforma`) y dólar (`cp-dolar`, ahora con los 2 países: el emisor como economía cerrada y el no emisor) rehechos con el mismo código de colores, números y pasos. |
| Gráfico 4: título «diagrama de Hamada en el modelo de Corden» y detalles del antiguo | Título cambiado (y el apartado se llama «Hamada y Corden»). Recuperado del gráfico antiguo: los ángulos de los rayos $E_0$ y $E_N$ en el origen, las funciones de reacción como flechas que salen de cada punto de felicidad y pasan por $N$, y la tentación del polizón (si A cumple en $C$, B vuelve a su función de reacción), que el texto antiguo contaba con $M_A^*$. |
| OCDE y G-20: más texto, miembros del G-20 en subpárrafos, OCDE ≥2 caras, infografías, Davos y ASEM | G-20: miembros en 6 subpárrafos por continente (con la regla «antiguo G-8 + 11 + UE + UA»), funcionamiento en 3 mecanismos, logros en 5 frentes, la presidencia de EE. UU. 2026 (prioridades, 4 grupos, Sudáfrica excluida, reuniones sin comunicado, Miami 14-15/12/2026), Reino Unido 2027 (Mánchester) y Corea 2028; figura `g20-esquema`. OCDE (unas 3 páginas): origen (OECE, UEP, AME, Convenio de París), 4 oleadas de adhesión, miembros por región, 8 candidatos y procedimiento, socios clave, órganos (Consejo, comités, Secretaría), presupuesto 2026, los 5 tipos de instrumentos jurídicos, el Consenso de créditos a la exportación (del tema antiguo), análisis (EO, estudios, Going for Growth → Foundations, PISA), fiscalidad (BEPS, Marco Inclusivo, 2 pilares, paquete «paralelo» de 2026) y valoración; figura `ocde-esquema`. Otros foros con apartado propio: G-7, FMI-FSB-BPI, **Foro de Davos** y **ASEM** (del antiguo 3.B.36, puestos al día) y una tabla de foros. Datos a 16/11/2026 de fuentes oficiales (g20.org, state.gov, treasury.gov, gov.uk, oecd.org, weforum.org, admin.ch, aseminfoboard.org, asef.org, consilium.europa.eu, fsb.org). |
| Estructura propuesta | Aplicada tal cual (ver arriba). Lo de economía política (obstáculos, formas, problemática) pasa a I.3; la historia, a III, con 5 subapartados en lugar de las letras a)-d). |
| Minutos, esquema y ficha | \minutos suma 30; esquema y nota del opositor rehechos. Ficha: esquema del cante, I con las 4 funciones de C-P por separado y los gráficos `cp-cerrada`, `cp-pcp` y `cp-lcp`, I.3, II con miembros del G-20 por continentes, OCDE, Davos y ASEM y las 2 figuras, III con la historia, tabla M-F frente a C-P y trampas nuevas. 4 páginas a 9 pt (antes 10 pt), última página al 93 %. |
| Reglas generales del 16/11 | Títulos con numeración completa (III con subapartados 1-5, sin letras sueltas); enumeraciones con párrafo de entrada y subpárrafos; autores nombrados (Fleming, Mundell; Corsetti y Pesenti; Hamada, Corden, Oudiz y Sachs; Schwab); refrán inicial sin cambios. |

Compilación: `construir-tema.py 3B19 --solo pdf --no-publicar` y `verificar-tema.py 3B19`: sin errores propios (solo los 3 de formatos publicados anteriores a la fuente) y sin desbordes.

### Dudas (16/11/2026)

- **D16-1. Las *slides* originales de Corsetti y Pesenti.** En el tema y en su .bib solo está el enlace al NBER (WP 11341 y la versión del ISOM 2007); no hay enlace a diapositivas. He seguido los colores de las figuras del artículo (negro, azul, rojo). Opciones: (a) dejarlo así; (b) si Víctor tiene el enlace a las slides, adaptarlo a sus colores. **Aplicada: (a).**
- **D16-2. Economía cerrada de C-P en el cuerpo o en caja gris.** Víctor dejaba elegir. Opciones: (a) en el cuerpo, porque es la base de los pasos siguientes y de la curva de indiferencia; (b) en caja gris. **Aplicada: (a)**; solo la derivación de la NR va en caja gris.
- **D16-3. Gráficos antiguos de C-P.** `corsetti-pesenti`, `corsetti-pesenti-reforma` y `corsetti-pesenti-dolar` ya no se usan en el tema ni en la ficha (los sustituyen los `cp-*`), pero el canon (`canon/modelos/corsetti-pesenti.md`, `mapa.yaml`) los cita como gráficos de referencia. Opciones: (a) conservarlos y que la fase canon pase la referencia a `cp-cerrada`/`cp-pcp`/`cp-lcp`; (b) borrarlos ya. **Aplicada: (a)** (cambio común pendiente para el canon; también cambian las etiquetas: `eq:corsetti-pesenti` → `eq:cp-ad`… y `fig:corsetti-pesenti` → `fig:cp-*`).
- **D16-4. Datos de foros de fuentes no oficiales.** Que Rumanía y Bulgaria son los candidatos más adelantados a la OCDE, la reducción de grupos de afinidad del G-20 en 2026 y la reunión de ministros de Educación de la ASEM en noviembre de 2026 solo los he visto en fuentes secundarias; los he redactado sin cifras. Que España vaya a Miami como «observador invitado» (EFE) no lo he puesto en el texto (solo «invitado permanente»; sí en la figura del G-20). Opciones: (a) mantenerlos así; (b) quitarlos. **Aplicada: (a).**
- **D16-5. Gobernanza de Davos.** Desde febrero de 2026 dirige el Foro \autor{Alois Zwinggi}, al principio con carácter interino; no he encontrado el nombramiento definitivo. Redactado «al principio de forma interina». Opciones: (a) así; (b) quitar los nombres y dejar solo la salida de Schwab. **Aplicada: (a).**
- **D16-6. Ficha a 9 pt.** Con el contenido nuevo (G-20, OCDE, Davos, ASEM, gráficos de C-P) la ficha pasa de 10 a 9 pt; quité la tabla «Los foros de un vistazo», que repetían las figuras. Opciones: (a) 9 pt; (b) recortar más para volver a 10 pt. **Aplicada: (a).**

### Instrucciones para el vídeo (16/11/2026)

- `mundell-fleming-dos-paises` y `mundell-fleming-dos-paises-fiscal`: capas 1 (ejes y títulos), 2 (IS, LM, $i^*$ y equilibrio inicial en los 2 países), 3-7 (pasos 1 a 5, cada uno con su flecha, su número y su línea de leyenda).
- C-P en el cante: `cp-cerrada` por capas (1 ejes; 2 AD; 3 AS; 4 NR; 5 $O$ y $U_O$; 6 $X$; 7 $Z\uparrow$; 8 $B$ y brecha; 9 $A$; 10 $\mu\uparrow$), escribiendo cada función al dibujar su curva; después `cp-pcp` (capas 1-2, la economía mundial; 3-5, A; 6-7, B) y, si da tiempo, `cp-lcp`.
- `hamada`: como antes, más los ángulos (capas 2 y 5), las flechas de reacción (4) y el punto $C$ con la desviación de B (9-10).
- II: la figura del G-20 se dibuja como 5 cajas por continente; la de la OCDE, como 3 cajas (Consejo, comités, Secretaría); la escalera, que ya está en la pizarra desde I.3, se completa con los foros.
- Anexo A (no se canta): panel a panel, 3 capas por panel (curva de la política y $B$; ajuste por reservas o tipo de cambio; $C$).

## Comentarios de Víctor (18/11/2026)

Antes: 40 páginas de tema (anexos 15, bibliografía 8; 63 en total). Después: **39** (anexos 15, bibliografía 8; 62). Los gráficos 3, 4 y 5 del PDF anterior eran, por este orden, `cp-cerrada-paso1` (las 3 curvas en la economía cerrada), `cp-cerrada-paso2` (equilibrio $O$, curva de indiferencia y punto eficiente $X$) y `cp-cerrada` (subida de la productividad en la economía cerrada).

| Comentario | Cómo se ha aplicado |
|---|---|
| «El gráfico 3 puedes sustituirlo por el gráfico 4 directamente» | Fuera `cp-cerrada-paso1`; el gráfico `cp-cerrada-paso2` va ahora tras el paso 1 («las 3 curvas, el equilibrio $O$, la curva de indiferencia y el punto eficiente $X$») y el paso 2 lo usa («en el mismo gráfico»). Es ahora el gráfico 3. El fichero `cp-cerrada-paso1.*` queda en `graficos/` sin usar. |
| «La subida de productividad en la economía cerrada a forma de ejemplo y el gráfico 5 en una caja gris y más pequeño» | Caja `anotaciones` «Un ejemplo en la economía cerrada: una subida de la productividad», con los 4 pasos y el gráfico en `figuracaja` al 45 % del ancho (antes 62 %). Es ahora el gráfico 4. La «brecha de empleo» se define (en negrita) en el cuerpo, en el paso 3 nuevo. |
| «El objetivo es mostrar los spillovers en la economía abierta (el paso 3 nos lo saltamos)» | Pasos renumerados: 1 piezas, 2 equilibrio de la cerrada, 3 economía mundial, 4 estabilización y escenarios PCP/LCP/dólar. Lo que el paso 3 antiguo daba al resto se cuenta ahora en la economía abierta, sin remitir a la caja: en el paso 3 (economía mundial), con precios rígidos la subida de $Z$ solo gira la AS de A y abre su brecha, B sigue en $O_B$ y «las rigideces nominales aíslan a las economías»; en el paso 4, la política óptima (replicar los precios flexibles, cerrar la brecha sin inflación); en el escenario PCP, (1) dice que se abre la brecha. La a) Idea dice ahora que el objetivo son los desbordamientos en la economía abierta. Nota del cante: el gráfico imprescindible es el del equilibrio de la cerrada (no el de la productividad), y el ejemplo pasa a «no se canta». |
| Coherencia con el resumen «Coordinación internacional» (Corsetti y Pesenti de 2 países) | Coherente en lo esencial: 3 curvas AD, AS y NR en $(\ell,C)$, $\mu$ como tono monetario (consumo nominal), AS lineal en el empleo con $\tau$, NR con preferencias y margen, $E=\mu/\mu^*$, sin transmisión con precios rígidos hasta que actúa la política monetaria, PCP con desbordamiento positivo y LCP con empobrecimiento del vecino (en B: con PCP sube $\tau_B$ y la AD, con LCP baja $\tau_B$ y la AD no se mueve), sin ganancias de coordinar con PCP ni LCP. Ajustes: (1) la relación de intercambio como la miden los autores, $P_F/(E\,P^*_H)$ (importaciones sobre exportaciones; al subir, $\tau$ baja), comprobada en el *Staff Report* 209, § 5.1; (2) la frase de que las rigideces nominales aíslan a las economías (§ 6.2); (3) dólar: el resumen dice «puede ser ambiguo»; el artículo (§ 6.5) dice que es positivo en el consumo y negativo en el trabajo y que en conjunto domina el consumo por la distorsión monopolística: se dice así; (4) la caja final enlaza la versión del Banco de la Reserva Federal de Nueva York (sr209.pdf, la que el resumen recomienda por sus gráficos), con `\href` y no con entrada del `.bib`, para no partir las citas de 2005 en 2005a y 2005b. La notación sigue siendo la del canon (A y B, $\tau_B$, AD$_B$), no la del resumen ($\tau^*$, AD$^*$). La clasificación del resumen en modelos de primera generación (teoría de juegos: Hamada, Canzoneri y Henderson) y de segunda (NOEM; Canzoneri, Cumby y Diba, 2005) no se añade: cambiaría la estructura del apartado I (ver duda). |
| Ficha de repaso | La pareja de gráficos de C-P lleva ahora `cp-cerrada-paso2` (equilibrio) en lugar de `cp-cerrada`; una viñeta nueva (con precios rígidos B no se entera; el desbordamiento lo lleva la estabilización de A); dólar «en conjunto, gana»; plan de pizarra y gráficos imprescindibles al día. Sigue en 4 páginas a 9 pt. |

### Dudas (18/11/2026)

- **D18-1. Primera y segunda generación de modelos.** El resumen que mandaron clasifica la teoría (siguiendo a Canzoneri, Cumby y Diba, 2005) en Mundell-Fleming, modelos de primera generación (teoría de juegos: Hamada, Oudiz y Sachs, Canzoneri y Henderson, 1991) y de segunda (NOEM: Corsetti y Pesenti). Opciones: (a) dejar la estructura como está (justificación con M-F y C-P; deseabilidad con Hamada); (b) añadir una viñeta en la introducción del apartado I con esa clasificación, sin mover nada; (c) reordenar I según las generaciones. **Aplicada: (a)**; recomiendo (b) si Víctor la quiere para el cante (exigiría comprobar Canzoneri, Cumby y Diba, 2005, que no está en el `.bib`).
- **D18-2. Gráfico `cp-cerrada-paso1` sin usar.** Opciones: (a) dejar el fichero en `graficos/` (como los `corsetti-pesenti*` de D16-3); (b) borrarlo. **Aplicada: (a).**

### Instrucciones para el vídeo (18/11/2026)

- C-P en el cante: ya no se dibuja `cp-cerrada` (la productividad en la cerrada es una caja que no se canta). En la pizarra, `cp-cerrada-paso2` por capas (ejes; AD; AS; NR, escribiendo cada función al dibujar su curva; $O$ y $U_O$; $X$), después `cp-pcp` (capas 1-2, la economía mundial, diciendo que con precios rígidos B no se entera; 3-5, A con la brecha y la respuesta monetaria; 6-7, B) y, si da tiempo, `cp-lcp`.
