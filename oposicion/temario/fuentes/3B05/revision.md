# Revisión del 3.B.5: Teoría del comercio internacional (I). Ventaja comparativa, relación real de intercambio, factores específicos y Heckscher-Ohlin-Samuelson

Revisión autónoma (Víctor fuera del 31/10 al 9/11/2026). La fuente nueva está en LaTeX (`3B05.tex`) y se escribió en 2 partes el 5/11/2026. La parte 1 comprende el preámbulo, la introducción y los apartados I y II; la parte 2, el apartado III, la conclusión y los 8 anexos. La base es el Word de Víctor (≈17.000 palabras, 38 págs. en el PDF publicado, 45 notas al pie y 33 imágenes). Las dudas de estructura (D1-D5) se han resuelto con la opción que recomendaba coherencia y se anotan en «Dudas abiertas».

## 1. Resumen

- **Estructura de 3 apartados (D1, D2)**: el «Pensamiento neoclásico» del original se parte en 2.
  - I, pensamiento clásico: Smith y Ricardo-Torrens, con DFS y Eaton-Kortum como extensiones.
  - II, Haberler y un subapartado nuevo de determinación de la RRI: Mill, Marshall y Meade.
  - III, las dotaciones: los factores específicos suben de extensión a III.1, y el H-O-S queda como III.2, con cada teorema en su `\subsubsection`.
  - Se mantienen todos los títulos de segundo nivel del original y se sigue el orden del título oficial.
- **Minutos**: introducción 2′30″ · I 6′30″ · II 6′ · III 13′30″ · conclusión 1′30″ = 30′.
- **Lo más importante que se ha corregido**:
  - el salario real en Stolper-Samuelson: la nota 37 decía lo contrario del teorema;
  - la unicidad y la estabilidad de las curvas de oferta neta;
  - la notación de Ricardo, alineada con el canon y el 3.A.2;
  - los años y los autores: Hume 1752, Hamilton 1791, Robert Peel, Bernhofen y Brown, Trefler 1995 y Leamer 1980.
- **Contenido nuevo**:
  - determinación de la RRI, con la oferta relativa escalonada, las curvas de indiferencia comercial de Meade, la condición de Marshall-Lerner en el trueque, sus usos y Prebisch-Singer;
  - factores específicos con sus bloques a)-e);
  - el álgebra de Jones con el efecto magnificación;
  - los apartados que estaban vacíos: fallos en los supuestos, valoración e influencia del H-O-S;
  - la tabla de los 4 modelos (`tab:modelos`);
  - un anexo de datos de España con 3 gráficos pgfplots, en lugar de las capturas.
- **Enganche nuevo**: «Lo que abunda no daña», con los aceites de España (ventaja comparativa revelada de 3,65 en 2024) y su déficit energético. La idea final retoma el refrán.
- **Ficheros**:
  - `3B05.bib`, con 120 entradas;
  - `graficos-pedidos.json`, con 22 gráficos (19 de teoría y 3 de datos);
  - `seo.json`.
- **Construcción**: compila sin referencias ni citas indefinidas y sin líneas desbordadas: 29 págs. de tema, 11 de anexos y 5 de bibliografía (45 en total), con los 22 gráficos del tema.

## 2. Errores corregidos

| Dónde (original) | Decía | Dice ahora |
|---|---|---|
| Nota 37 (Stolper-Samuelson) | El salario real crece en términos de *X* «pero no es seguro que lo haga en términos de *Y*» | En el 2×2 el salario real sube en términos de los 2 bienes ($\hat w>\hat p_Y>\hat p_X>\hat r$, `eq:magnificacion`). Lo que decía la nota es el resultado de los factores específicos, y ahora va en una nota que avisa de esa confusión (C32) |
| Haberler, unicidad (l. 544) | El equilibrio es único si los 2 bienes son normales | La normalidad no lo garantiza: con un tramo inelástico puede haber varios cortes, que alternan estables e inestables (C22) |
| Haberler, estabilidad (l. 544) | $\lvert\varepsilon_M\rvert+\lvert\varepsilon_X\rvert>1$ | $\lvert\varepsilon_M^A\rvert+\lvert\varepsilon_M^B\rvert>1$: son las elasticidades de importación de los 2 países (`eq:ml-trueque`) |
| Curva de oferta neta (l. 536-538, nota 24) | Tramos elástico e inelástico con la causa invertida; «es convexa» | `eq:oferta-neta-elasticidad`: la curva sube si $\varepsilon_M>1$, es vertical si vale 1 y se dobla hacia atrás si es menor; se curva hacia el eje del bien importado |
| Nota 23 (Meade) | «las exportaciones son un bien y las importaciones un mal» | Al revés: exportar es un coste y por eso la curva de indiferencia comercial tiene pendiente positiva |
| Libre comercio en Haberler (l. 512) | «mayor consumo de ambos bienes», en contradicción con la nota 21 | Una curva de indiferencia social más alta, no necesariamente más de los 2 bienes; se separan las ganancias del intercambio y de la especialización (C21) |
| Ricardo (l. 258, 290, nota 14) | Si la RRI iguala el coste de un país, ese país «no tendría interés en comerciar» | Comercia, pero no gana (caso del país grande); la RRI de equilibrio siempre queda dentro del intervalo (C10) |
| Ricardo, desigualdad | $80/90<120/100$ (RRI medida en vino) | `eq:ventaja-comparativa`: $100/120<p_X/p_Y<90/80$, como en el 3.A.2 |
| Tabla 2 y nota 13 | $a_1,a_2,b_1,b_2$ | $a_X^A,a_Y^A,a_X^B,a_Y^B$ (canon § 10) |
| Rybczynski (l. 816 y amarillo) | Un aumento de L en una viñeta y de K en las siguientes; los precios de los factores constantes como supuesto | Siempre un aumento de $\overline K$ (C33). Que los precios de los factores no cambien es una consecuencia, no un supuesto |
| Factores específicos (l. 1023) | La curva $P_Y\cdot\mathrm{PMgL}_Y$ «se desplazará hacia la izquierda» | Sube; las flechas apuntan a la izquierda porque se mide desde $O_Y$ (anexo `anexo:factores-especificos`) |
| Nota 33 | Llamaba «reversión factorial» a un sesgo de demanda | Es una contradicción entre las 2 definiciones de abundancia, no una reversión (`fn:sesgo-demanda`) |
| Supuestos del H-O-S | Homotecia = «la proporción de la renta dedicada a cada bien no cambia» | La proporción entre las cantidades no depende de la renta a precios dados (eso otro es Cobb-Douglas) |
| Teorema H-O | Los 2 países consumen en el mismo punto | Consumen en el mismo rayo; coinciden solo si tienen la misma renta (C30) |
| Deardorff (l. 957) | Enunciado incorrecto | El de su artículo: la cadena se cumple con costes de comercio *o* bienes intermedios, pero puede romperse con los 2 (C37) |
| Nota 7 | Falvey como competencia monopolística; «Kierzowski» | Nota quitada: el 3.B.6 la tiene bien (Falvey es neo-H-O, Kierzkowski) |
| Nota 31 | Con movilidad de factores «las conclusiones seguirán siendo las mismas» | Los factores sustituyen al comercio (Mundell, 1957) |
| Anexo 1 | Atribuía de forma confusa el equilibrio parcial | El equilibrio parcial es el de Keynes y el efecto renta lo introduce Ohlin (C43) |
| Fechas y nombres | Hume (*Discursos políticos*, 1952); Hamilton (1790); «Sir Thomas Peel»; Ricardo cap. 7 de 1817; «Brown *et al.* (2005)»; «Trefler (1959)»; Leamer sin año; Samuelson 1949; neolítico en el 6000 a. C. | 1752; 1791; Sir Robert Peel, junio de 1846; cap. VI en 1817 y VII en 1821; Bernhofen y Brown (2004, 2005); Trefler (1995); Leamer (1980); Samuelson (1948-1949); hacia el 10.000 a. C. |
| Erratas | «tranformación», «ente», «linear», «porque» por «por qué», «mucho países», «libre-cambio», HOS/H-O sin unificar, $W$ mayúscula | Corregidas; H-O-S para el modelo y teorema de Heckscher-Ohlin para el teorema; $w$ y $r$ en todo el tema |

## 3. Marcas resueltas

| Marca | Texto original | Qué se hizo |
|---|---|---|
| P1 (amarillo, Rybczynski) | 5 viñetas a medio redactar tras la Imagen 10 | Reescritas como intuición, álgebra de Jones (`eq:magnificacion-ryb`) y plano de los bienes, siempre con un aumento de K |
| P2 (amarillo vacío) | «Fallos en los supuestos del modelo: …» | Escrito: capital humano, recursos naturales y Leamer (1980) en el cuerpo; el resto de explicaciones en el anexo `anexo:leontief` |
| P3, P4 (amarillo vacío) | «Valoración» e «Influencia» del H-O-S | Escritas (C38, C39) |
| P5, P6 (amarillo y comentario) | Appleyard y Field, y la idea de un «apartado cero» | Sin apartado cero: mercantilistas y Hume van en la nota de la contextualización, como en el 3.B.6. No se cita Appleyard y Field (su capítulo 2 no se ha podido leer); la entrada sigue en el `.bib` sin citar |
| P7 (amarillo, anexo 1) | Keynes contra Ohlin | Reescrito con las fuentes de 1929, Samuelson (1952, 1954) y Leontief (1936); se queda aquí (D5) |
| P8 (amarillo vacío) | Estructura de la introducción | Escrita con los 3 apartados y el porqué del orden |
| P9 | 4 «Nota al opositor» del cambio de temario y la captura | Quitadas |
| P10 | *Disclaimer* de las FPP | Convertido en una frase del texto (K8) |
| P11, P12 | «Las 3 primeras extensiones no da tiempo…» y «Gandolfo, pág. 24/25/28 – Llevar a anexos» | Al anexo `anexo:ricardo-extensiones`, con 3 gráficos rehechos; en el cuerpo, una viñeta de remisión |
| P13 | «Debe enfatizarse que este modelo no es exitoso…» | Integrada en la evidencia del HOV y matizada con Davis y Weinstein (2001) |
| P14 | «Modelo muy apropiado para… distribución de la renta» | En la valoración de los factores específicos |
| P15 (comentario) | «No perder mucho tiempo en la exposición…» | No se publica; con el título nuevo la RRI tiene subapartado propio, así que no se pasa de puntillas |
| P16 (comentario) | Nota privada sobre un tema de otro preparador | No se publica. Ese tema no estaba entre las referencias disponibles |
| P53 | Temas de preparadores en la bibliografía | Quitados |
| P54 | Forvo, YouTube (nota 22), archive.org (nota 19), hetwebsite, quia.com, glosario de umich | Quitados; el test, con el enlace genérico al simulador (`anexo:test`) |
| Notas al pie | 45 en el original | Se mantienen como notas, reescritas donde hacía falta: 1, 2, 5, 8, 9, 10, 12, 15, 17, 18, 20, 21, 26, 29, 31, 32, 33, 34, 35, 37, 38, 39, 40, 43 y 44. Pasan al texto la 11, 14, 23, 24, 27, 28, 36, 41 y 42. Se quitan la 3 (fundida en la relevancia), 4, 6, 7 y 45 (son del 3.B.6), 13, 16 (sustituida por un gráfico), 19, 22, 25 (vacía) y 30 (en el anexo de la igualación). La 29 y la 32 pasan al anexo `anexo:igualacion` con sus gráficos |
| Imágenes | Capturas del Anexo 2 y recortes de un manual (nota 32) | No se publican; se sustituyen por gráficos pgfplots y TikZ |

## 4. Datos actualizados

| Dato | Anterior | Nuevo | Fuente | URL | Consulta | Segunda comprobación |
|---|---|---|---|---|---|---|
| Comercio mundial de bienes y servicios | 31 billones de USD (2022) | 34,65 billones (2025) | OMC, *Perspectivas…* marzo de 2026 | https://www.wto.org/spanish/res_s/booksp_s/gtos0326_s.pdf | 05/11/2026 | UNCTAD, *Global Trade Update*, abril de 2026 (≈35 billones): cuadra |
| Comercio de mercancías de España (anexo 2) | 2022, en capturas | Exportaciones 387.092 M€, importaciones 444.146 M€, saldo −57.055 M€, cobertura 87,2 %, UE 61,8 % (2025) | Ministerio de Economía, Comercio y Empresa, informe mensual de diciembre de 2025 | https://comercio.gob.es/ImportacionExportacion/Informes_Estadisticas/Historico_Informes/Mensuales/2025/2025-12_Informe_Mensual_Comercio_Exterior.pdf | 05/11/2026 | Nota de prensa de 19/2/2026 y Eurostat Comext: cuadra |
| Ventaja comparativa revelada de España (enganche y anexo 2) | — | Aceites y grasas 3,65; intensivas en trabajo y recursos naturales 1,44; tecnología media 1,12; alta 0,67 (2024) | UN Comtrade (SITC Rev. 4) con la clasificación de la UNCTAD | https://comtradeplus.un.org/ | 05/11/2026 | UNCTADstat US.RCA: 1,41 / 1,19 / 0,74, cuadra (secciones CUCI solo con Comtrade) |
| Déficit energético de España (enganche) | — | −29.292 M€ (2025) | Ministerio, informe mensual (cuadro 17) | ídem | 05/11/2026 | Eurostat Comext SA 27, misma estructura |
| Revolución neolítica | 6000 a. C. | Hacia el 10.000 a. C. | National Geographic | https://www.nationalgeographic.com/culture/topics/reference/neolithic-agricultural-revolution/ | 05/11/2026 | Citéco (Banco de Francia): ≈8500 a. C., mismo orden de magnitud |
| Corn Laws | «Sir Thomas Peel» | Sir Robert Peel, junio de 1846 | Gobierno del Reino Unido | https://www.gov.uk/government/history/past-prime-ministers/robert-peel-2nd-baronet | 05/11/2026 | EBSCO Research Starters: cuadra |
| Leontief (1953) | Sin cifra | 18.184 frente a 13.991 USD de capital por año-hombre (≈30 % más) | Cuadro de Leontief (1953), reproducido por Nowak (2019) | https://prawo.uwr.edu.pl/wp-content/uploads/sites/210/2022/08/IE_Lecture3_2019.pdf | 05/11/2026 | Otra fuente secundaria: 14.010 y 18.180, el mismo 30 %. El artículo original no se ha leído |
| Eaton y Kortum (2002) | 19 países de la OCDE, 1990 | Igual, y θ ≈ 8,28 | Separata de Cowles | https://cowles.yale.edu/sites/default/files/2024-03/p1866.pdf | 05/11/2026 | RePEc: cuadra |
| Harrigan (1997) | Sin muestra | 10 países de la OCDE, 20 años | RePEc | https://econpapers.repec.org/RePEc:aea:aecrev:v:87:y:1997:i:4:p:475-94 | 05/11/2026 | NBER WP 5722: cuadra |
| Bowen, Leamer y Sveikauskas (1987) | Sin muestra | 27 países, 12 factores, 1967 | RePEc | https://econpapers.repec.org/RePEc:aea:aecrev:v:77:y:1987:i:5:p:791-809 | 05/11/2026 | NBER WP 1918: cuadra |
| Balassa (1963) | Datos de 1951 | Datos de 1950-1951 | MIT 14.581 (Costinot), lección 6 | https://ocw.tau.edu.ng/courses/economics/14-581-international-economics-i-spring-2013/lecture-slides/MIT14_581S13_Lecslides6.pdf | 05/11/2026 | **Sin segunda comprobación** |
| Kreinin (1965) | Entre un 20 y un 25 % | «Como mucho un 25 %» | Tsoulfidis, «Revisiting Leontief's Paradox» | https://ruomoplus.lib.uom.gr/bitstream/8000/1230/1/Tsoulfidis_IRAE_Revisiting%20Leontief%27s%20Paradox_2R.pdf | 05/11/2026 | Discrepancia leve: se usa la formulación prudente |
| Magee (1980) | — | 19 de 21 sectores con la misma postura de capital y trabajo; 2 de 21 con Stolper-Samuelson | Magee, Davidson y Matusz (2005) | https://doi.org/10.1016/j.jinteco.2004.04.002 | 05/11/2026 | Una sola fuente (la versión de trabajo es el mismo texto) |
| Nobel de Ohlin y Meade, Samuelson y Leontief | Motivaciones incompletas | Textos de nobelprize.org | https://www.nobelprize.org/prizes/economic-sciences/1977/summary/ | 05/11/2026 | Texto literal |

## 5. Contenido añadido

- **I.2 Ricardo**:
  - la tabla única que pasa de Smith a Ricardo (110 → 90, K7) y las fronteras de posibilidades de producción con la RRI;
  - el salario relativo (`eq:salario-relativo`) y la ganancia como ahorro de trabajo (C11);
  - DFS y Eaton-Kortum con sus ecuaciones (C16, C17), con las mismas frases que el 3.B.6 (ACR, gravedad);
  - en la evidencia, Bernhofen y Brown, Kiyota (2007, 2011), Costinot y Donaldson (2012) y Costinot, Donaldson y Komunjer (2012).
- **II.1 Haberler**: las 2 ganancias del comercio, implicaciones propias, Harrigan con su muestra y una valoración.
- **II.2 Determinación de la RRI** (P41), nueva:
  - Mill con la `\funcionclave` `eq:mill` y la oferta relativa escalonada;
  - las curvas de oferta neta de Marshall y Edgeworth, con su forma, existencia, unicidad y estabilidad;
  - las curvas de indiferencia comercial de Meade, a partir de Leontief (1933) y Lerner (1934);
  - los usos (arancel, crecimiento empobrecedor de Bhagwati, integración, transferencias) y Prebisch-Singer.
- **III.1 Factores específicos** (P42): bloques a)-e), con el diagrama de Mussa, la magnificación de Jones (1971), Magee, Grossman y Levinsohn, Kovak y la enfermedad holandesa (Corden y Neary, 1982).
- **III.2 H-O-S**:
  - en los supuestos, las 2 definiciones de abundancia en el texto, la especialización incompleta y el número de bienes y de factores;
  - en la igualación del precio de los factores, las curvas de coste unitario, el cono de diversificación, Lerner (1952) y Mundell (1957);
  - en Stolper-Samuelson, el álgebra de Jones con `\funcionclave` `eq:magnificacion` y el 2TFEB (remisión al 3.A.22);
  - en Rybczynski, el álgebra de Jones y la dualidad con Samuelson (1953);
  - en la evidencia, Leamer (1980), el HOV con `eq:hov`, Trefler, Davis y Weinstein, Romalis y Schott;
  - las extensiones (más bienes o más factores, Jones, Deardorff, reversión, costes de transporte, Davis, 1995, y Bernard, Redding y Schott), la valoración y la influencia (Wood, Autor, Dorn y Hanson, Harberger).
- **Tabla `tab:modelos`** (K14): 4 preguntas × 4 modelos; se construye en la pizarra a lo largo de todo el cante.
- **Anexos**:
  - A, Ricardo con más bienes o más países (Gandolfo; Jones, 1961);
  - B, transferencias;
  - C, dotaciones en el modelo de factores específicos;
  - D, la igualación paso a paso, con Samuelson-Johnson, la reversión y los coeficientes fijos;
  - E, Rybczynski gráficamente, el álgebra de Jones demostrada y la reciprocidad;
  - F, la paradoja de Leontief en detalle;
  - G, datos de España (3 gráficos pgfplots);
  - H, test.

## 6. Coherencia

- **Notación del canon**:
  - A, B, X e Y en todo el tema, con A = Inglaterra (abundante en capital) y X = paño (intensivo en capital);
  - $a_X^A$, $\mathrm{RRI}=p_X/p_Y$, $w$ y $r$ (D011) y el cociente siempre $w/r$;
  - el álgebra de Jones con $s_{Lj}$, $\ell_{Lj}$ y $\hat x$;
  - siglas en redonda.
  - Son símbolos locales, avisados en la caja de notación: θ y $T_i$ (EK), $\vartheta(\tilde z)$ (DFS), $\varepsilon_M^A$, $r_X$, $r_Y$, $G(\cdot)$ y $\varsigma^i$. Están en `_trabajo/canon-pendiente.md` para el canon (esta sesión no tiene fase canon).
- **Mismo modelo, misma forma**:
  - `tab:pano-vino` y `eq:ventaja-comparativa` son idénticas a las del 3.A.2;
  - la nota de Hume, Hamilton y List y la del neolítico tienen la forma del 3.B.6;
  - Eaton-Kortum y Bernard-Redding-Schott dicen lo mismo que en el 3.B.6;
  - los gráficos de coste unitario y de Rybczynski parten de los del 3.A.21, con X e Y intercambiados (D4);
  - Haberler usa la geometría de Robinson Crusoe del 3.A.29.
- **Remisiones nuevas o corregidas** (K20): 3.A.2, 3.A.3, 3.A.4, 3.A.11, 3.A.21, 3.A.22, 3.A.29, 3.A.31, 3.B.6, 3.B.7, 3.B.8, 3.B.9, 3.B.10, 3.B.12, 3.B.18, 3.B.28 y 4.B.8. La nota 23, que remitía al 3.B.7 para algo que se necesita aquí, se ha invertido: el 3.B.5 es el tema de referencia de las curvas de indiferencia comercial.
- **Refranes**: el enganche, «Lo que abunda no daña», y 5 pegatinas («A buen hambre no hay pan duro», «Cada mochuelo a su olivo», «Si la montaña no va a Mahoma…», «No hay rosa sin espinas» y «Donde menos se piensa, salta la liebre»). Ninguno estaba usado en otro tema; habría que avisar al 3.B.8, que se revisa en paralelo.
- **Contradicciones con otros temas** (no se han tocado):
  - el 3.B.7 y el 3.B.8 (Word) desarrollan la curva de indiferencia comercial «añadiéndola al 3.B.5»: al revisarlos, que resuman y remitan aquí;
  - el 3.B.9 (Word) enuncia Rybczynski sin «a precios constantes» y sin el efecto magnificación;
  - el 3.A.21 tiene X intensivo en trabajo en sus gráficos y este tema, en capital: los pies lo dicen;
  - el 3.B.12 (Word) remite aquí por Marshall-Lerner: debería ser solo por la versión de estabilidad de las curvas de oferta;
  - el 3.A.3 llama a las curvas de Marshall «de oferta recíproca»: aquí se dice «oferta neta (u oferta recíproca)»;
  - el 3.B.6 y el 3.B.10 son coherentes con lo escrito (sus remisiones a la RRI, a Stolper-Samuelson y a Mundell tienen contenido aquí).

## Comentarios de Víctor (10/11/2026, 3.ª tanda)

| Comentario | Cómo se ha aplicado |
|---|---|
| Comercio internacional: nada de SEC, todo en sectores CUCI, con datos de los servidores del ministerio | Consulta al SQL Server de comercio (`CMX.TH_DEFINITIVOS_PROVISIONALES`, enero-diciembre de 2025, primer dígito de la CUCI). Nuevo `datos/comercio-sectores-espana.csv` (10 secciones CUCI, sustituye al de sectores SEC del informe mensual) y nueva cita `Datacomex2026`. El gráfico `comercio-sectores-espana` (antiguo gráfico 20) y el texto del anexo de datos pasan a secciones CUCI; el déficit energético del enganche pasa a la sección 3 de la CUCI (−28.562 M€, antes −29.292 M€ de la SEC «productos energéticos»); la ficha y `datos-actualizables.yaml`, igual. |
| Refrán: «El que mucho abarca, poco aprieta» en lugar de «Lo que abunda no daña» | Cambiado en el enganche (la especialización: España no intenta producirlo todo), la idea final de la conclusión, la nota al opositor del reparto, la ficha (esquema, enganche e idea final) y las instrucciones del vídeo. |
| Gráfico 1: notación FPP y FPC, mismo ejemplo con $\overline L$ en los ejes; gráfico combinado en nota al pie | `ricardo-fpp` rehecho: cortes $\overline L/100$, $\overline L/120$, $\overline L/90$, $\overline L/80$, rótulos FPP$^A$, FPC$^A$, FPP$^B$, FPC$^B$; el texto explica las 4 capas. Nuevo `ricardo-fpp-conjunto` (los 2 países en un solo plano, como la imagen 1 del tema anterior) en la nota al pie con `\graficonota`. |
| Tabla 2: los comentarios del 3.A.2 | Quitada la fila del coste relativo; sombreada y en azul la ventaja comparativa de cada país; viñetas con el porqué (desventaja menor de Inglaterra en paño, 1,11 frente a 1,5; ventaja mayor de Portugal en vino, 0,67 frente a 0,9, con los costes comparativos); la tabla 1 de Smith se presenta como el ejemplo de Ricardo con una cifra cambiada y en la pizarra se tacha el 110 y se escribe el 90. Mismos números que el 3.A.2. |
| Nota al pie 16 antigua en una caja gris en el cuerpo | Caja gris «El país grande: cuándo la especialización no es completa» tras las implicaciones de Ricardo; remite al anexo nuevo. |
| Enlace al vídeo y desarrollo de Haberler: curvas de oferta neta desde el gráfico de Haberler y RRI (Ricardo, a un anexo) | Enlace conservado (nota «Para ver» del paso 2). El apartado II desarrolla, en 4 pasos: 1) triángulo de comercio (`haberler-comercio`); 2) curva de oferta neta de A girando la RRI ($p=1$, 1,5, 2), plano de bienes y plano del comercio lado a lado, como el gráfico 5 del 3.B.7 (nuevo `haberler-oferta-neta-a`, 5 capas); 3) la de B ($p=4$, 3, 2; nuevo `haberler-oferta-neta-b`); 4) equilibrio y RRI (`ofertas-netas`). Los números de los 3 gráficos son los mismos (corte en RRI = 2). El ejemplo de Ricardo con la demanda va al anexo nuevo «La RRI con el ejemplo de Ricardo», con la oferta relativa escalonada y un gráfico nuevo, `ricardo-oferta-exportacion` (oferta de exportaciones de Inglaterra y demanda de importaciones de Portugal, la construcción de Feenstra y Taylor de la antigua nota 16; RRI = 1 y, en una capa, el país grande). |
| Gráfico 5 (Meade) en una caja gris | La derivación de Meade y su gráfico, en una caja gris (`figuracaja`) tras el equilibrio. |
| No dividir el apartado 2 en 2 modelos | Apartado II único, «Teoría neoclásica (1): determinación de la RRI. Modelo de Haberler», con a) idea (RRI, Haberler, demanda recíproca de Mill), b) modelo (supuestos, desarrollo en 4 pasos, implicaciones), c) evidencia, d) valoración con los usos de las curvas de oferta neta. |
| En todos los modelos, implicaciones con las 4 preguntas | Ricardo, Haberler, H-O-S y factores específicos responden a por qué se comercia, qué se produce, a qué RRI y quién gana (también en la ficha). |
| Factores específicos: anexo C al cuerpo en una caja gris | Caja gris «Cambios en las dotaciones» con los 2 gráficos (`especificos-ky`, `especificos-l`) dentro del modelo; el anexo desaparece. |
| Anexo G: quitar el gráfico 21 y rehacer el 20 en CUCI | Quitado `vcr-intensidad-factorial-espana` (borrados sus ficheros; la frase con los índices por intensidad factorial se queda, sin gráfico, y su CSV sigue en `datos/`). El 20, en secciones CUCI (ver primera fila). |
| Todos los teoremas con gráfico, numerados 1-4, primera frase en negrita; igualación con el gráfico del tema antiguo en una caja; Rybczynski con la caja de factores | Teorema 1 (H-O, `teorema-ho`), 2 (Stolper-Samuelson, `costes-unitarios`, explicado por capas), 3 (igualación; caja gris con `samuelson-johnson` rehecho con el orden de ejes del tema antiguo: $r/w$ en abscisas, $K/L$ decreciente, $p_X/p_Y$ hacia abajo) y 4 (Rybczynski, `rybczynski-caja` al cuerpo; `rybczynski-fpp`, en nota al pie). Enunciados con la primera frase en negrita. El orden es el que da Víctor (H-O, S-S, igualación, Rybczynski). |
| Reestructurar con el esquema del título | I. Teoría clásica (1. Antecedentes: Smith; 2. Ricardo-Torrens); II. Teoría neoclásica (1): RRI y Haberler; III. Teoría neoclásica (2): H-O-S, con a) idea, b) modelo (supuestos, 4 teoremas, implicaciones), c) evidencia (Leontief, salidas y paso a las extensiones), d) extensiones (i HOV con su evidencia; ii Jones y Deardorff; iii factores específicos, con idea, supuestos, desarrollo, 4 preguntas, extensiones, evidencia y valoración; caja gris con los demás levantamientos de supuestos), e) valoración e influencia. Actualizados la estructura de la introducción, el esquema, `\esqtiempo` y minutos (2,5 + 6,5 + 6 + 13,5 + 1,5 = 30), las notas al opositor, la tabla de los 4 modelos (H-O-S antes que los factores específicos) y la ficha. Los anexos quedan: A extensiones de Ricardo; B la RRI con el ejemplo de Ricardo (nuevo); C transferencias; D igualación (demostración, reversión y coeficientes fijos); E álgebra de Jones y reciprocidad; F Leontief; G datos de España; H test. |
| Gráficos por pasos explicados poco a poco | Cada gráfico nuevo o rehecho tiene capas (`\capa`) y el texto las recorre en orden (FPP/FPC de Ricardo, pasos 2-3 de Haberler, curvas de coste unitario, Samuelson-Johnson, caja de Rybczynski, anexo de Ricardo). |

## 7. Dudas abiertas

1. **D1-D5 (estructura)**, aplicadas con la opción recomendada:
   - D1: 3 apartados en lugar de los 2 del original;
   - D2: factores específicos como III.1, antes del H-O-S;
   - D3: el enganche del aceite (punto 2);
   - D4: X intensivo en capital, como el original, con los gráficos del 3.A.21 intercambiados;
   - D5: el anexo de Keynes y Ohlin se queda aquí.
   ¿Las da por buenas? *Resuelta por Víctor (10/11/2026)*: D1 y D2, con otra estructura (factores específicos como extensión del H-O-S y apartado II único con Haberler); D3 se mantiene con otro refrán.
2. **Enganche sin cifra del aceite de oliva**: no se ha encontrado en una fuente oficial comprobada la cuota de España en las exportaciones mundiales de aceite de oliva. Se usan 2 datos oficiales comprobados:
   - la ventaja comparativa revelada de los aceites y grasas (sección 4 de la CUCI) en 2024, 3,65 (UN Comtrade, elaboración propia);
   - el déficit energético de 2025 (−29.292 M€).
   No se dice que España sea «el primer productor y exportador mundial». Si quiere la cuota del aceite de oliva, haría falta el dato del Consejo Oleícola Internacional o de DataComex (capítulo 1509 del SA).
3. **«Hecksher» en el título oficial**: `\tcetema` copia literalmente el título de `temario.json`, con la errata; en el texto siempre se escribe Heckscher. ¿Se corrige en `temario.json`?
4. **Mill, 1848 frente a 1909**: este tema cita los *Principles* con `Mill1848Principles` (libro III, cap. XVIII), como pide coherencia; el 3.A.2 usa también `Mill1909Principles` (la edición de Ashley) para citas con página. Son la misma obra. ¿Se unifica en el canon?
5. **Bibliografía sin comprobar en Crossref**: Crossref cortó por exceso de peticiones (error 429). Quedan con los datos de contenido Edgeworth (1894), Lerner (1952), Vanek (1963), Travis (1964), Leontief (1964), Ethier (1984), Davis (1995), Leamer (1995), Wood (1994), Goldberg y Pavcnik (2007), Keynes (1929, réplica), Samuelson (1954) y Leontief (1936). De Grossman y Levinsohn (1989) Crossref solo devuelve el NBER WP de 1987. Ya estaban sin segunda comprobación en datos: Haberler (1930), DFS (1977), Keesing (1966), Baldwin (1971), Jones (1971) y Costinot, Donaldson y Komunjer (2012).
6. **Datos con formulación prudente**:
   - Magee: «19 de 21» y «2 de 21», con una sola fuente secundaria; el capítulo de 1980 no se ha leído.
   - Kreinin: «como mucho un 25 %», y no el «20-25 %» del original.
   - Balassa: datos de 1950-1951, con una sola fuente.
   - Samuelson (1969): sin página («creérsela» en lugar de «comprenderla»).
   - El 30 % de Leontief sale de un cuadro reproducido en fuentes secundarias.
   - Bernhofen y Brown (2005): «no más de un 8-9 % del PIB», tomado del resumen del artículo.
7. **Decisiones del editor**, por si quiere otra cosa:
   - Rybczynski con un aumento de K (contenido y coordinador), no de L (coherencia K15);
   - Stolper-Samuelson con la `\funcionclave` de la cadena de precios, y la de cantidades como ecuación normal, para no tener 2 funciones clave en el mismo bloque;
   - DFS y EK como `\subparagraph` dentro de las extensiones de Ricardo;
   - el gráfico del mercado de factores (propuesta C32) no se usa en el tema, para no pasar de ~32 páginas (ver el punto 8);
   - la caja de Rybczynski, el plano de los bienes, el diagrama de Samuelson-Johnson, la reversión y los coeficientes fijos van a los anexos (no se dibujan en la pizarra); *Resuelta por Víctor (10/11/2026)*: la caja de Rybczynski y el diagrama de Samuelson-Johnson pasan al cuerpo (este, en caja gris) y el plano de los bienes, a una nota;
   - en la estructura y el esquema se ha escrito «Pensamiento neoclásico» sin «(I)» ni «(II)», porque `verificar-tema.py` lo toma por una remisión a mano.
8. **Control de calidad (05/11/2026)**, para que decida:
   - `graficos/mercado-factores` (propuesta C32) está dibujado y compilado, pero el `.tex` no lo usa. Recomendado: no incluirlo (repite lo que muestran las curvas de coste unitario y alargaría el tema). ¿Se queda fuera, o lo incluimos en el anexo de Rybczynski y Jones?
   - Magee (1980) es Stephen P. Magee y Magee, Davidson y Matusz (2005) es Christopher S. P. Magee: son autores distintos, así que las citas salen con iniciales («S. P. Magee», «C. S. P. Magee»). Es correcto; si prefiere evitarlo, habría que citar el de 2005 sin `\textcite` del apellido junto al de 1980.

9. **D-09. Totales del comercio de España de 2025** (10/11/2026): la consulta a DataComex da 387.404 M€ de exportaciones y 449.733 M€ de importaciones, algo más que el informe mensual de diciembre (387.092 y 444.146), por las revisiones posteriores. Opciones: (a) dejar los totales del informe mensual en el texto y usar DataComex solo para el reparto por secciones CUCI, avisándolo en la fuente del gráfico; (b) pasar también los totales a DataComex. **Aplicada: (a)**.
10. **D-10. Sentido del precio relativo de los factores** (10/11/2026): el canon (`notacion.md` § 10) fija $w/r$; Víctor pide el diagrama de Samuelson-Johnson con el orden de ejes del tema antiguo ($r/w$). Opciones: (a) $r/w$ solo en ese gráfico, $w/r$ en el resto del tema; (b) $r/w$ en todo el tema. **Aplicada: (a)**, apuntado en `_trabajo/canon-pendiente.md`.
11. **D-11. Puntos de consumo del gráfico 1** (10/11/2026): para que coincidan con el anexo nuevo de la RRI con el ejemplo de Ricardo (Inglaterra gasta la mitad en paño, Portugal el 40 %), los consumos pasan a $C^A=(12,12)$ y $C^B=(12,18)$ (antes 14,10 y 10,20). Opciones: (a) estos números; (b) los antiguos, sin relación con el anexo. **Aplicada: (a)**.
12. **D-12. La caja gris de la antigua nota 16** (10/11/2026): la nota tenía 3 imágenes de Feenstra y Taylor; en la caja va solo el texto y su gráfico, rehecho con los números de Ricardo, está en el anexo B (`ricardo-oferta-exportacion`). Opciones: (a) así; (b) meter el gráfico también en la caja. **Aplicada: (a)**.

## Enlaces del original (9/11/2026)

Repaso de los enlaces del Word original (CRITERIOS § 4). Los demás enlaces del original ya estaban en el tema.

- **Restaurados**:
  - *The Theory of International Trade* de Haberler (1936) en archive.org (nota 19 del original): `url` y `urldate` en `Haberler1936Theory`.
  - Semblanza de Haberler en el History of Economic Thought Website y su pronunciación en Forvo (enlaces del nombre en el título del apartado del original): en la nota de II.1 sobre el manual de Haberler. Forvo rechaza las consultas automáticas (403); se da por bueno porque el sitio funciona en el navegador.
  - Lección de Khan Academy sobre la ventaja comparativa (fuente del gráfico de la frontera de posibilidades del original): en el `\fuente` del gráfico `fig:ricardo-fpp`, sin el parámetro `?modal=1`.
  - Vídeo de Economicsfun que anima la curva de oferta neta (nota 22): «Para ver» en la curva de oferta neta (II.2).
  - Diagrama de Lerner del *Glossary of International Economics* de Alan Deardorff (comentario del original): con la dirección nueva (`public.websites.umich.edu`, a la que redirige la antigua), en nota al fundamento de Meade. Responde 403 a las consultas automáticas, pero el glosario sigue publicado.
- **No restaurados**: OMC, *Examen estadístico del comercio mundial 2023* (nota 4), y ICE, *El sector exterior en 2022* (caja del anexo de evolución reciente): las cifras que respaldaban se han sustituido por datos más recientes (`OMC2026Perspectivas` en la introducción y `MINECO2026InformeDic2025` en el anexo de datos de España). Ambos enlaces funcionan; si Víctor quiere conservarlos como lectura, irían en ese anexo.

## 8. Instrucciones para el vídeo

(Aún no hay guion ni escenas: entrega 3. Actualizadas el 10/11/2026 con la 3.ª tanda de Víctor.)

- **Enganche e idea final**: «El que mucho abarca, poco aprieta», con los aceites de España (pesan 3 veces y media más en sus exportaciones que en las del mundo) y la energía que no intenta producir y compra fuera (combustibles, sección 3 de la CUCI). La pregunta es por qué comercian los países, qué intercambian, a qué precio y quién gana. La idea final retoma el refrán: especializarse gana, aunque se sea mejor o peor en todo, pero tiene perdedores dentro. Introducción y conclusión, sin pizarra.
- **Gráfico conjunto por partes**: la tabla `tab:modelos` (4 preguntas × 4 modelos).
  - Se dibuja vacía en una esquina al empezar el I y se rellena una fila al terminar Ricardo, Haberler, el H-O-S y los factores específicos (en este orden).
  - Se queda todo el cante y en la conclusión se señala, sin escribirla otra vez.
  - Cada pegatina se apunta junto a su fila: Mill, igualación, Stolper-Samuelson, Leontief y factores específicos.
- **Funciones clave que se conservan**:
  - `eq:ventaja-comparativa`, desde el I.2 hasta el final del II;
  - `eq:mill`, durante el II;
  - `eq:magnificacion`, desde el teorema 2 hasta el final; la cadena de Rybczynski (`eq:magnificacion-ryb`) se escribe debajo de ella, porque son duales.
- **Rejillas sugeridas**:
  - I, «35|65»: la tabla de Smith y Ricardo (se tacha el 110 y se escribe el 90, y se sombrea la ventaja comparativa) a la izquierda, `ricardo-fpp` por capas (ejes, FPP de A, FPP de B, especialización y FPC de A, de B, ganancia) a la derecha;
  - II, «100» en 4 pasos: `haberler-comercio`; después `haberler-oferta-neta-a` (5 capas: ejes de los 2 planos, autarquía, $p=1{,}5$, $p=2$, la curva) y `haberler-oferta-neta-b` (las mismas capas); por último `ofertas-netas` (el equilibrio);
  - III, «45|55»: `teorema-ho`; `costes-unitarios` con las cadenas; `rybczynski-caja`; después «100» para `especificos`, con la subida de $p_Y$ como capa nueva y la cadena `eq:especificos-magnificacion` debajo.
- **Gráficos de apoyo**, sin escribirlos: `ricardo-fpp-conjunto` (nota), `dfs`, `meade` (caja gris), `samuelson-johnson` (caja gris, 5 capas), `rybczynski-fpp` (nota), `especificos-ky` y `especificos-l` (caja gris). Los de los anexos (`frontera-mundial`, `cadena-ventaja`, `viner`, `ricardo-oferta-exportacion`, `ricardo-oferta-relativa`, `reversion-intensidades`, `fpp-coeficientes-fijos`) y los 2 de datos, nunca a mano.
- **De palabra**: Eaton-Kortum, la evidencia de Ricardo salvo MacDougall y Japón, Harrigan, Prebisch-Singer, la evidencia de los factores específicos salvo Magee, el HOV (solo «el comercio que falta» de Trefler) y los otros levantamientos de supuestos del H-O-S.
- **Nunca** se dice en voz alta el número de un tema.
