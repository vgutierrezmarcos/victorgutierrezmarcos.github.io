# Revisión del tema 3.B.2: La empresa y las decisiones de inversión

Título oficial: «La empresa y las decisiones de inversión. Diferentes criterios de valoración de proyectos. Rentabilidad, riesgo y coste del capital.» Fuente: Word de Víctor (`Tema 3.B.2.docx`, PDF publicado de 31 páginas, «última actualización 10/08/2024»). Revisión del 08/11/2026 (rama `revision-temario-2`), en 2 partes: la parte 1 (preámbulo, introducción, bloques I y II, `3B02.bib`, `seo.json` y todos los gráficos pedidos) y la parte 2 (bloque III, conclusión, anexos, test y bibliografía). Resultado: 30 páginas de tema, 3 de anexos y 5 de bibliografía; los `\minutos` suman 30′.

## 1. Resumen

- **Orden del título** (decisión D1, opción a, recomendada): I. Métodos generales de valoración y selección de inversiones: ¿cómo invierten las empresas? (10′30″); II. Métodos de valoración de otros proyectos de inversión: ¿en qué invierten las empresas? (6′30″); III. Rentabilidad, riesgo y coste del capital: ¿cuánto debe rendir la inversión? (9′30″); introducción 2′30″ y conclusión 1′ (= 30′). Los títulos de los bloques y de segundo nivel del original se conservan; se rotan los bloques (el I del original pasa al final) para que el VAN se escriba con una $k$ genérica en el bloque I y el bloque III termine rellenándola con el WACC.
- **Introducción nueva** con sus 5 bloques: enganche «Más vale un hoy que dos mañanas» con Intel en Magdeburgo (cifras comprobadas de V9), relevancia con la FBCF de las sociedades no financieras (Eurostat), contextualización sin el texto de Bard (Friedman bien atribuido, 3 decisiones, definiciones de inversión, rentabilidad, riesgo, coste del capital y activos reales y financieros, historia de Fisher a Dixit y Pindyck), 3 preguntas y estructura; esquema, reparto del cante y caja de notación.
- **Bloque I**: proceso de decisión (presupuesto de capital) en la apertura; variables con la notación del canon ($I_0$, $\mathrm{FC}_t$, $n$, $\mathrm{VR}$, $k$) y el flujo de caja libre; tabla de tipos de inversión por el signo de sus flujos; 6 principios con la inflación; estáticos con sus críticas completas; VAN como `\funcionclave` (`eq:van`), TIR, comparación con el punto de Fisher ($k^{\mathrm F}=15{,}2$ %, ejemplo comprobado) y tabla completa, TIRM con $VA^{-}$ y $VF^{+}$, índice del VAN y racionamiento de capital (nuevo), tasa ajustada sin $\rho$ y equivalente cierto descontado a $r_f$, sensibilidad y Monte Carlo (Hertz, 1964), opciones reales como modelo a)–d) con la regla de la opción de esperar (`eq:opcion-esperar`, como el 3.A.34); evidencia de Graham y Harvey (2001, 2002), Gitman y Forrester (1977), Graham (2022) y Jagannathan et al. (2016).
- **Bloque II**: apertura completada (la frase cortada y la lista vacía del original); clasificación con la expansión bien definida; vida óptima con la condición discreta del retiro simple, la cadena de renovaciones con la fórmula corregida (derivación al anexo, parte 2) y el VAE; MAPI con el nombre correcto del instituto; existencias con la fórmula de Wilson escrita y la regla $(S,s)$; Baumol-Tobin para la tesorería con la notación y el gráfico del 3.A.35 adaptados a la empresa; Miller-Orr; Holmström y Tirole (2011) redactado de nuevo como motivo precaución; intangibles e inmuebles (nuevo); inversiones financieras en mención, sin el CAPM copiado; capital humano con Becker y Acemoglu y Pischke.
- **Bloque III**: rentabilidad *ex ante* y *ex post* con sus determinantes corregidos (preferencia temporal, inflación); ROA con DuPont y ROE con el apalancamiento y el impuesto bien puesto (`eq:roe-roa`, derivación en el anexo); riesgo con $\mathbb{E}$, $\sigma^2$ y $\pi_s$, sistemático y específico como el 3.B.23; los apartados vacíos de riesgo económico (GAO) y financiero (GAF) escritos, con un ejemplo comprobado; coste del capital: definición proyecto frente a empresa, tabla de las 3 vías (`tab:vias-coste`), CAPM con $\lambda_M$ y Hamada, primas de Damodaran, Gordon-Shapiro despejado, WACC con escudo fiscal como `\funcionclave[eq:wacc]` (idéntico al recuadro del 3.B.4), MM con sus Nobel bien traducidos y la nota del FT reducida a datos de S&P; determinantes ordenados; recapitulación que rellena la $k$ del VAN.
- **Conclusión** con sus 5 bloques («En conclusión,»; idea final con el refrán y Intel) y **anexos**: rentas y perpetuidades (notación del 3.B.4), cadena de renovaciones (derivación corregida y VAE), derivaciones (ROE-ROA, equivalente cierto, solución de esquina de Baumol) y para el tribunal y el test, con el enlace genérico al simulador.
- **Gráficos**: 9 pedidos en `_trabajo/graficos-pedidos.json` (8 del cuerpo y 1 del anexo de renovaciones); `miller-orr` ya copiado del 3.A.35 y adaptado (`graficos/miller-orr.tex`). El bloque III no lleva gráfico (las 3 vías del coste del capital van en tabla, en LaTeX).

### Estado de las propuestas

- **Coherencia (K)**: aplicadas K1 (opción a), K2 (títulos con `\newline`; «coste del capital»), K3 (con las cifras de V9; sin «la mayor inversión extranjera de la historia de Alemania», que datos no comprobó aparte), K4 (con V11), K5 (fundida con C7), K6, K7 y el esquema, K8 (con $\mathrm{FC}_t$ y $\mathrm{VR}$ en redonda, por ser siglas), K9 (proceso en la apertura, FCL, nota de las 5 variables, tabla de signos), K10 (con «borrón y cuenta nueva»), K11 (todo; ejemplo de Fisher con los números de C28, que el coordinador fija: $k^{\mathrm F}=15{,}2$ %), K12 (opciones reales pasan a un apartado propio, I.3.4, con estructura de modelo; ver «Coherencia» por $r_f$ en lugar de $r$), K13, K14, K15, K16 (la derivación de la cadena va al anexo `anexo:renovaciones`, parte 2), K17 (Wilson con $Q^*$, $Y$, $b$, $c_a$; Baumol sin `\funcionclave`; Miller-Orr con la notación del 3.A.35; Holmström y Tirole en 2 viñetas y nota con los corolarios), K18, K19, K25 (remisiones del bloque I y II), K26, K27 y K28 en lo que toca a la parte 1. K20-K24 y K29: parte 2 o canon.
- **Contenido (C)**: aplicadas C2, C3 (con la notación de K donde chocan: $VA^{-}$/$VF^{+}$ en lugar de $X$/$Y$; $Q$, $Y$ en el lote económico en lugar de $q$, $x$; $M^{\mathrm{inf}}$ en lugar de $M_{\mathrm{inf}}$), C4 (solo Friedman/Jensen y la nota de los 3 objetivos; el enganche «quien siembra, recoge» con el gasto de las tecnológicas no se usa: manda K3), C5, C6 (con el dato de V11), C7 (sin la frase de «lugar en el temario», que ya da la de las 3 decisiones; Gitman y Forrester pasan a I.4), C21-C30, C31 (la prima con la beta se remite a III), C32 (sin las «pruebas de resistencia», que no tienen fuente), C33 (sin el 27 % de Graham y Harvey: no comprobado, D4 de contenido), C34 (el proceso en la apertura del bloque I; cifras de V5 y V6), C35-C41, C42 (la cifra de Corrado, Hulten y Sichel, sin comprobar, queda como «del mismo orden que las máquinas»), C43, C44 (la cita de Becker de la nota 27 se parafrasea sin comillas), C45 y C19 (los corolarios en nota, en la tesorería). **No aplicadas**: C1 (estructura y reparto: mandan K1 y la decisión del coordinador) y C8 (problemática y estructura: mandan K6 y K7). C9-C18, C20, C46-C51: parte 2.
- **Datos (V)**: aplicadas V1 (con Damodaran, comienzos de 2026, y el PIB de España de 2025; no el S&P 500 de Bloomberg), V5, V6, V9, V10 (Jagannathan et al. en I.4; Krüger et al., para la opinión de la parte 2), V11, V12, V14, V16, V17, V20, V21, V22, V24, V25, V26, V27, V30, V31; L3, L4, L5 y L6 (fuera). V2-V4, V7, V8, V13, V15, V18, V19, V23, V28, V29, V32: parte 2.
- **Parte 2, coherencia (K)**: aplicadas K20 (con la fórmula del ROE con el $(1-t_{IS})$ multiplicando a todo, valores contables), K21 (sin la pegatina «cuando llueve, todos se mojan», que K deja sin cantar; $\pi_s$; Knight con las palabras del 3.A.10), K22 (definición una vez, 3 vías en tabla, CAPM con $\lambda_M$, Hamada, Gordon-Shapiro con $t=1$, $V_{D,0}$ y $S_t$ para la deuda, WACC idéntico al del 3.B.4 como `\funcionclave`, MM con el endeudamiento óptimo remitido al 3.B.3; la nota del FT reducida a 1 frase sin la cita), K23 (con las extensiones de K, el dato de vivienda de V4 y Alesina y Perotti de V13; opinión con Krüger et al. y Jagannathan et al.), K24 (anexos A y B; el C, la solución de esquina de Baumol, dentro del de derivaciones), K25-K27 en el bloque III.
- **Parte 2, contenido (C)**: aplicadas C9, C10 (con la notación $V_D/V_E$ de K20 en lugar de «deuda/patrimonio neto»), C11, C12, C13, C14, C15 (el 73,5 % del CAPM, de Graham y Harvey, 2002), C16 (sin $g=b\cdot\mathrm{ROE}$, para no chocar con la $b$ de Baumol), C17 (con $V_{D,0}$ en lugar de $D_0$, canon-pendiente 3 y 10), C18 (la nota del FT con los datos públicos de S&P de V2-V3: grado especulativo del 24 % al 48 % y 225 impagos en 2020; **sin** las 2 empresas AAA, que solo tienen fuente de prensa), C20, C46 (con el refrán y la idea final de K23 en lugar de «quien siembra, recoge»; sin Lane, 2012, cuyo DOI no se comprobó: el dato de vivienda de V4 lo sustituye), C47 (con la notación $F$, $k$, $VA$ del 3.B.4, como pide K24), C48 (anexo de derivaciones y de test), C49-C51. Holmström y Tirole (C19) sale del coste del capital y está en la tesorería (parte 1).
- **Parte 2, datos (V)**: aplicadas V2 (sin las AAA), V3 (225 impagos de 2020; sin los 88 trimestrales ni la frase de 1988), V4 (España e Irlanda; Italia entre el 35 % y el 58 %), V7 (primas y WACC medio de Damodaran, como el 3.B.23), V8 (sin el gráfico del FT; el de calificaciones de S&P no se usa: no cabe en el cante y la nota ya da las 2 cifras), V13 (Alesina y Perotti, 1996; sin Persson y Tabellini), V15, V18 (MM, 1963, para el escudo fiscal), V19, V23 (Churchman et al. y Mao en el anexo; Kaufmann, sin comprobar, fuera), V28, V29, V32 (sin las fechas dudosas de la nota 14: no se reproduce). L2 (FT) se cita sin la cita literal.

## 2. Errores corregidos

| Dónde (original) | Decía | Dice ahora |
|---|---|---|
| Introducción, l. 37 | «Siguiendo a Milton Friedman (1970), el objetivo… es la maximización del valor de mercado de sus acciones» | Friedman (1970): aumentar los beneficios; la maximización del valor es la traducción de las finanzas corporativas (Jensen, 2001) |
| Introducción, l. 49 | «compromiso real de dinero… con la esperanza de recibir beneficios» | «compromiso actual… con la expectativa de obtener beneficios», citado (Bodie, Kane y Marcus, cap. 1) |
| Contextualización, l. 91-95 | 3 párrafos de Bard (Smith, Ricardo y Pacioli como antecedentes) | Contextualización histórica con fuentes: Fisher, Keynes, Dean, Lorie y Savage, Hirshleifer, Markowitz, Sharpe, MM, Myers, Dixit y Pindyck |
| II.1 (ahora I.1), l. 486-532 | $A$, $Q_t$, WACC como tasa; «Coste de capital (WACC): ya lo hemos estudiado» | $I_0$, $\mathrm{FC}_t$, $k$ genérica con remisión al apartado del coste del capital |
| II.1, l. 508 | «Inversiones puras: solo existe un cambio de signo» | Puras y mixtas según el saldo acumulado del proyecto (Teichroew, Robichek y Montalbano, 1965); un cambio de signo define la inversión simple |
| II.2, principio 4 | «los costes de financiación ya vienen incluidos implícitamente en el WACC» (aún no definido) | La financiación entra por la tasa de descuento, con remisión al apartado del coste del capital |
| II.3.1 | «La rentabilidad se suele expresar en base anual…» como crítica del *payback*; falta la crítica principal | Ignora los flujos posteriores a la recuperación; *payback* descontado |
| II.3.2, VAN | «el valor actualizado de todos los rendimientos esperados» | Menos el desembolso inicial; la «hipótesis de reinversión» leída bien |
| II.3.2, VAN y TIR | «Tasa Interna de Retorno» | «tasa interna de rentabilidad», como el 3.A.34 |
| Nota 18 | Regla de Descartes mal enunciada | El número de raíces positivas no supera el de cambios de signo |
| II.3.2, comparación, l. 719 | «se dice que existe *inconsistencia dinámica*» | Conflicto de ordenación (la inconsistencia dinámica es otra cosa) |
| II.3.2, l. 729 | «la TIR podría favorecer proyectos con pequeñas rentabilidades» | Favorece proyectos pequeños o cortos con rentabilidad porcentual alta |
| II.3.2, l. 731 | En las mixtas, VAN y TIR «no coinciden» | «pueden no coincidir» |
| Tabla VAN-TIR | Fila de la TIR incompleta; $k^*$ y WACC; $I_{\mathrm A}$, $I_{\mathrm B}$ | Tabla completa (la TIR elige B en las 3 columnas), $k^{\mathrm F}$, proyectos A y B |
| TIRM, l. 747-764 | Mezcla $k$ y WACC; $X$ e $Y$; «elimina la inconsistencia» y «consistente con el VAN» | $VA^{-}$, $VF^{+}$, tasa $k$; es única, pero puede ordenar distinto que el VAN con escalas distintas |
| II.3.3, l. 796 | $s=\mathrm{WACC}+\rho$ («WACC es el coste de capital de riesgo») | $k=r_f+$ prima del proyecto; sumar una prima al WACC de un proyecto de riesgo medio cuenta el riesgo 2 veces |
| II.3.3, l. 807 | Equivalente cierto descontado al WACC | Descontado a $r_f$, con $\xi_t=\alpha_t\mathbb{E}[\mathrm{FC}_t]$ y la equivalencia entre los 2 métodos |
| II.3.3, l. 813 | El análisis de sensibilidad «permite estimar los flujos» | Mide cómo cambia el VAN si cambian los supuestos |
| II.3.3, l. 825 | «El método del VAN asume irreversibilidad» | Supone que la inversión es reversible o de ahora o nunca (Dixit y Pindyck, cap. 1) |
| II.3.3, l. 845 | «Costes de modificar el proyecto (+)» | El valor de la opción crece con la irreversibilidad |
| II.4, l. 857 | Graham y Harvey: «las pymes utilizan sobre todo la intuición» | Las pequeñas usan el *payback* casi tanto como el VAN; cifras comprobadas (V5) |
| III, l. 869-875 | Frase cortada («Esto nos obliga a tener en cuenta») y lista vacía | Apertura completa |
| III.1.1, l. 887 | Expansión: «creación de nuevos productos» | Ampliar la capacidad para lo que ya se vende; lo nuevo es innovación |
| III.1.2, l. 905 | «CPO: $\partial\mathrm{VAN}/\partial n=0$» con $n$ entero | Condición discreta $\mathrm{FC}_{n+1}+\mathrm{VR}_{n+1}\geq(1+k)\mathrm{VR}_n$ |
| III.1.2, l. 923-925 | $\mathrm{VC}_i(n_i)/(1+k)^{-n_i}$ (multiplica en vez de descontar) | $\mathrm{VAN}_\infty(n)=\mathrm{VAN}(n)(1+k)^n/[(1+k)^n-1]$; derivación en el anexo (parte 2) |
| III.1.2, l. 937 | *Machinery and Allied Product Institute*; costes «directos» e «indirectos» | *Products*; coste del capital e inferioridad de servicio (Terborgh) |
| III.1.2, pie de la imagen 3 | Suárez Suárez et al. (2020), 22.ª ed. | 22.ª ed. de 2014 (V12) |
| III.1.3, Baumol | «el individuo», su «renta»; corretaje dibujado como recta; $M^D=f(Y+\|b+\|i-)$; implicación de flexibilizar el sistema financiero | Empresa, pagos $Y$; hipérbola $bY/M$; signos bajo los argumentos; las implicaciones macro, al 3.A.35 |
| I.1, l. 140-148 | Rentabilidad = ganancia / sacrificio | (valor final − valor inicial) / valor inicial |
| I.1, l. 160-162 | «Preferencia por la liquidez»; la inflación «no es generalmente un factor a considerar» | Preferencia temporal; la inflación esperada sí importa (Fisher) |
| I.1.2 | «el ROE se puede falsear aumentando la deuda»; sin relación con el ROA | Relación ROE-ROA con el apalancamiento y el impuesto sobre todo el corchete |
| I.2, l. 221 | $\sigma^2=\sum p_i\bullet(r_i-\bar r)^2$ | $\sigma^2=\sum_s\pi_s(r_s-\mathbb{E}[r])^2$ |
| I.2, l. 243 | Riesgo sistemático «en común con las de su misma categoría, mercado, región» | El que depende de la marcha de la economía y no se elimina diversificando (3.B.23) |
| I.2.1, I.2.2 | Títulos vacíos | Riesgo económico (GAO) y financiero (GAF), con ejemplo |
| I.3.1, l. 271 | Segunda condición llamada «rentabilidad financiera» | «Condición financiera» (el nombre de rentabilidad financiera es del ROE) |
| I.3.2, l. 297-301 | «El riesgo sistemático representa la volatilidad del título»; $k=r_f+\beta_A(r_M-r_f)$ | La beta es una sensibilidad; $r_E=r_f+\beta_E\lambda_M$, $r_A=r_f+\beta_A\lambda_M$, con Hamada |
| I.3.2, l. 324 | $V=\sum_{t=0}^{\infty}\mathrm{FC}_t/(1+k)^t$ | Desde $t=1$, con el WACC; y $r_E=D_1/P_0+g$ |
| I.3.2, l. 340-342 | $I_0$ para los fondos recibidos por la deuda; suma hasta infinito | $V_{D,0}$ y suma hasta $n$ |
| I.3.2, l. 346 | $\mathrm{WACC}=k=r_E(1-L)+r_DL$ | $\mathrm{WACC}=r_E(1-L)+r_D(1-t_{IS})L$ (escudo fiscal) |
| I.3.2, l. 352 | «la financiación ajena siempre es más barata que la financiación interna» | Más barata que la **propia** |
| Nota 7 | «el coste de capital no es la media ponderada de dos costes separados» | Lo fija el riesgo de los activos; proposición II de MM |
| Nota 8 | Nobel de Modigliani «por sus análisis de los mercados de ahorro…»; *life-cicle* | «por sus análisis pioneros del ahorro y de los mercados financieros»; *life-cycle*; Miller con Markowitz y Sharpe |
| I.3.2, l. 360 | Holmström y Tirole (2013) | 2011 |
| I.3.3, l. 400-420 | Numeración rota; «el coste de capital del mercado es la agregación…»; el impago no afecta al coste | Lista ordenada; el impago esperado entra en $r_D$ |
| Conclusión, l. 1157 | «España, Italia e Irlanda» | España e Irlanda, con el dato de vivienda (Italia subió mucho menos) |
| Conclusión, l. 1161 | «Perotti y Tabellini» | Alesina y Perotti (1996) |
| Anexo 1 | $r$, $F$; falta la fórmula cerrada de la renta constante | $k$, $F$, $VA$ como el 3.B.4, con todas las fórmulas cerradas |
| III.2, renta variable | 7 viñetas copiadas con errores («valoración de carteras», «gap de rendimiento», alfa) | El CAPM en una línea y el VAN nulo en un mercado eficiente |
| Nota 26 | Nobel de Becker mal traducido | «por haber extendido el análisis microeconómico a un amplio abanico de comportamientos e interacciones humanas, incluidos los que no pasan por el mercado» |

## 3. Marcas resueltas

| Marca | Qué se hizo |
|---|---|
| P1, P2 (amarillo: «no hay contextualización»; texto de Bard) | Contextualización nueva con fuentes; el texto de Bard fuera |
| P9, P10 (rojo: «esperanza», «riesgo») | Integrados en negro con «expectativa» y las citas de Bodie, Kane y Marcus y de Sharpe, Alexander y Bailey |
| P11 (rojo: «Desembolso inicial (A)») | Definición correcta, con $I_0$ |
| P5-P7 (amarillo: «Modelos de Wilson y Tobin/Baumol»; implicaciones; elasticidades) | Wilson en existencias, Baumol-Tobin en tesorería, Miller-Orr; elasticidades integradas con la lectura de economías de escala |
| P8 (amarillo, renta variable) | Reducida a una viñeta con `\vertema{3.B.23}` |
| P12 (avisos de cambio de temario y tabla) | Fuera; de la tabla se aprovechan los intangibles e inmuebles y que las inversiones financieras no son FBC |
| P13 («Falta por añadir Baumol») | Cerrada: Baumol-Tobin desarrollado |
| P14, P17, P25 (comentarios con nombres de compañeros y preparadores) | No se publican |
| P15 (tiempos del cante) | `\minutos` y la nota del reparto |
| P16 (notas de capítulos de Vernimmen y Suárez Suárez) | Citas en el texto (`\parencite[cap.~28]{Vernimmen2017Corporate}`, `[caps.~18-19]{SuarezSuarez2014Decisiones}`) |
| P18 (¿métodos antes que principios?) | Se mantiene el orden variables → principios → métodos (los principios dicen qué flujos entran); la línea de flujos se queda en la pizarra durante los métodos |
| P19, P35d (fotos de Suárez Suárez) | No se publican; el texto que las copiaba se redacta de nuevo |
| P20 («Ver modelos s-S») | Regla $(S,s)$ con Arrow, Harris y Marschak (1951) y Scarf (1960) |
| P21 («Coordinar en temas 3.A.35 y 3.B.2», visible en el PDF) | Fuera; aplicada la ficha `baumol-tobin` con la notación y el gráfico del 3.A.35 |
| P22 («Si sobra tiempo…» y *Disclaimer*) | Fuera; la idea va al texto con `\vertema` |
| P23 (¿inversiones financieras?) | Mención breve (D6, recomendada) |
| P24 (capital humano) | Mención con Becker y Acemoglu y Pischke, `\vertema{3.A.25}` |
| P26-P35 (figuras) | Pedidas en TikZ (ver «Instrucciones para el vídeo» y `graficos-pedidos.json`); la tabla del Word, completa en LaTeX; el esquema de signos, en tabla |
| P36, P37 (proceso, IVAN, racionamiento, FCL, inflación, intangibles) | Añadidos |
| P3, P4 (amarillo: riesgo económico y financiero vacíos) | Escritos con el GAO y el GAF |
| P16 (Vernimmen, caps. 29 y 30) | `\parencite[cap.~29]` y `[cap.~30]` |
| P17 («Leer esto…», «Ver Tema…») | No se publican |
| P25 (comentarios de la bibliografía) | Fuera; quedan las obras |
| P35b (gráfico del FT) | Fuera, con la cita literal; la idea, en una nota con datos públicos de S&P |
| P38-P40 (rentabilidad, riesgo, coste del capital) | Ver «Errores corregidos» |
| P46 (notas privadas en el PDF) | Fuera, también la ruta `file:///` y las entradas de temas de preparadores de la bibliografía |
| P47 (citas largas del FT y de *Nada es Gratis*) | Resumidas y redactadas de nuevo |
| P49, P50 (Friedman, Perotti y Tabellini, Italia) | Corregidos |
| P51 (anexo de rentas) | Completado |
| Enlace a quia.com y «Preguntas de otros exámenes» vacía | Sustituidos por el anexo para el tribunal y el test con el enlace genérico al simulador |
| P48 (enlaces: TIRM de Wolters Kluwer, vídeo de Monte Carlo) | Sustituidos por Brealey, Myers y Allen y por Hertz (1964) |

## 4. Datos actualizados

| Dato | Valor anterior | Valor nuevo | Fuente | URL | Consulta | Segunda comprobación |
|---|---|---|---|---|---|---|
| Enganche: Intel en Magdeburgo | — | >30.000 M€ (06/2023), 9.900 M€ de ayuda, aplazada (09/2024), cancelada (07/2025) | Intel; Bundesregierung | intc.com; bundesregierung.de (ver `bib-datos.bib`) | 08/11/2026 | Intel y Gobierno federal coinciden; prensa (V9) |
| FBCF de las sociedades no financieras, España | — | 217.993 M€ en 2025, 12,9 % del PIB | Eurostat, `nasa_10_nf_tr` | ec.europa.eu/eurostat | 08/11/2026 | Suma de los trimestres de `nasq_10_nf_tr` (V11) |
| Efectivo de las empresas | 1,45 billones $ (S&P 500) ≈ PIB de España y Portugal (dato de 2016) | ≈1,9 billones $ (cotizadas no financieras de EE. UU., enero de 2026) ≈ PIB de España en 2025 | Damodaran; FMI, WEO | pages.stern.nyu.edu/~adamodar; imf.org | 08/11/2026 | Bloomberg (S&P 500, 1,9); Eurostat × tipo BCE para el PIB (V1) |
| Graham y Harvey (2001) | Sin cifras; «pymes: intuición» | 392 CFO; VAN 74,9 %, TIR 75,7 %; *payback* más de la mitad | JFE 60 | faculty.fuqua.duke.edu | 08/11/2026 | Graham (2022), tabla I (V5) |
| Uso del VAN en el tiempo | — | 10 % de las grandes como regla principal (mediados de los 70); 77 % de las grandes y 40 % de las pequeñas (2020) | Gitman y Forrester (1977); Graham (2022) | nber.org/papers/w29841 | 08/11/2026 | Fig. 2 y tabla I de Graham (2022) (V6) |
| Tasa mínima frente a coste del capital | — | 15 % frente a ≈9 %, unos 6 puntos más | Graham (2022); Jagannathan et al. (2016) | doi.org/10.1016/j.jfineco.2016.01.012 | 08/11/2026 | Graham (2022) cita a Jagannathan et al. (V6, V10) |
| Prima de las acciones (EE. UU.) | — | 6,6 puntos (1928-2025); prima implícita 4,2 % (2026); prima país España 1,6 puntos | Damodaran | pages.stern.nyu.edu/~adamodar | 08/11/2026 | Misma cifra y clave que el 3.B.23; 2 ficheros de Damodaran para la implícita (V7) |
| Coste del capital medio | — | 7,7 % (cotizadas no financieras de EE. UU., enero de 2026) | Damodaran, `wacc` | ídem | 08/11/2026 | Graham (2022): WACC declarado del 9 %, mismo orden (V7) |
| Calificaciones de S&P | 65 AAA hace 40 años, 5 hoy (FT, 2020) | Grado especulativo del 23,6 % (1981) al 48,1 % (2024); 225 impagos en 2020 | S&P Global Ratings, estudio anual 2024, tablas 1 y 29 | maalot.co.il | 08/11/2026 | Tabla 1 frente a tabla 29 (misma publicación) (V2, V3) |
| Vivienda (conclusión) | «España, Italia e Irlanda», sin cifras | Precio real ×2 o más en España e Irlanda (1997-2007); Italia +35-58 % | BPI (FRED); OCDE | fred.stlouisfed.org | 08/11/2026 | OCDE, RHP (V4) |
| Misma tasa para todos los proyectos | — | casi el 60 % | Graham y Harvey (2002) | people.duke.edu/~charvey | 08/11/2026 | Comprobado por contenido en el PDF de la JACF (C34) |

## 5. Contenido añadido

- Proceso de decisión de inversión (presupuesto de capital, 5 etapas; Brealey, Myers y Allen, cap. 10) y su problema de incentivos.
- Flujo de caja libre del proyecto (como el 3.B.4) y tabla de tipos de inversión según el signo de los flujos (Teichroew, Robichek y Montalbano, 1965), con ejemplos comprobados (TIR de 13,1 %, 12,9 % y 10 % y 20 %).
- Principio de coherencia nominal/real (inflación); *payback* descontado.
- Índice del VAN y racionamiento de capital con `\optim` y un ejemplo (Lorie y Savage, 1955; Weingartner, 1963).
- Ejemplo numérico del punto de Fisher (A: 144 en $t=2$; B: 125 en $t=1$; $k^{\mathrm F}=15{,}2$ %; con $k=8$ %, $\mathrm{VAN}_{\mathrm A}\approx23{,}5$ y $\mathrm{VAN}_{\mathrm B}\approx15{,}7$).
- Equivalencia entre tasa ajustada y equivalente cierto, $\alpha_t=[(1+r_f)/(1+k)]^t$ (Brealey, Myers y Allen, cap. 9).
- Opciones reales como modelo, con la regla de la opción de esperar y el ejemplo de Pindyck (1991), los mismos que el 3.A.34.
- Valor anual equivalente; condición discreta del retiro simple.
- Fórmula de Wilson (Harris, 1913; Wilson, 1934) y modelos $(S,s)$; ejemplo numérico de Baumol para una empresa (3,6 M€, 50 €, 4 %: $M^*\approx94.900$ €, 38 reposiciones, 47.400 € de media, ≈3.800 € de coste); Miller y Orr (1966) con la notación del 3.A.35; Bates, Kahle y Stulz (2009).
- Intangibles (las «4 S» de Haskel y Westlake, 2017) e inmuebles (tasa de capitalización).
- Acemoglu y Pischke (1998, 1999) en el capital humano.
- Bloque III: determinantes de la rentabilidad con la relación de Fisher; DuPont; relación ROE-ROA; coeficiente de variación; riesgo económico y financiero con GAO, GAF y apalancamiento total; tabla de las 3 vías; Hamada; primas y coste del capital medio de Damodaran; estimación implícita con Gordon-Shapiro; WACC con escudo fiscal (MM, 1963); proposición II de MM en nota; datos de calificaciones e impagos de S&P.
- Conclusión: q de Tobin, canal del coste del capital, vivienda en España e Irlanda, Alesina y Perotti (1996), opinión con Krüger, Landier y Thesmar (2015) y Jagannathan et al. (2016).
- Anexos: derivación de la cadena de renovaciones y del VAE; derivaciones del ROE-ROA y del equivalente cierto; solución de esquina de Baumol; preguntas para el tribunal y trampas del test.

## 6. Coherencia

- **Notación**: la del canon (§ 11) y la de K27 en todo el bloque I y II. Siglas en redonda también en las fórmulas ($\mathrm{FC}_t$, $\mathrm{VR}$, $\mathrm{VAN}$, $\mathrm{TIR}$, $\mathrm{TIRM}$, $\mathrm{IVAN}$, $\mathrm{WACC}$, $\mathrm{VAE}$); el canon escribe «FC_t, VR» sin precisar: K8 los ponía en cursiva, aquí van en redonda como el resto de siglas (el 3.B.4 escribe $\mathrm{FCL}_t$). Para el canon (`canon-pendiente.md`, punto 10): fijarlo.
- **Opción de esperar**: misma presentación y ejemplo que el 3.A.34 (`eq:opcion-esperar` allí), pero con $I_0$ (desembolso del tema) y $r_f$ (el tipo sin riesgo del tema) en lugar de $I$ y $r$; dicho en una nota. K12 proponía $r$; se usa $r_f$ porque en el 3.B.2 $r_f$ ya es el tipo sin riesgo y $r$ no está definida.
- **Baumol-Tobin y Miller-Orr**: notación del 3.A.35 ($b$, $Y$, $i$, $M^*$, $M^D$, $CT$, $M^{\mathrm{inf}}$, $M^{\mathrm{sup}}$, $M^{\mathrm{ret}}$, $z^*$); `graficos/miller-orr.tex` es copia del 3.A.35 con «activos» en lugar de «bonos»; `baumol-tesoreria` se pide como adaptación de `baumol-tobin.tex` del 3.A.35 al ejemplo de la empresa. Pegatina compartida «en el término medio está la virtud» (D3). Lote económico con la misma forma ($Q^*=\sqrt{2bY/c_a}$, K17).
- **Pegatinas**: «borrón y cuenta nueva», «lo bueno, si breve, dos veces bueno» y «renovarse o morir», sin usar en otros temas; «no por mucho madrugar…» (3.A.34) y «en el término medio…» (3.A.35), compartidas por modelo (D3). Frase de Joan Robinson: no.
- **CAPM y WACC**: mismas ecuaciones que el 3.B.23 (`eq:sml`, $\lambda_M$, $\mathbb{E}[\cdot]$) y que el recuadro del WACC del 3.B.4; $r_D$ con $V_{D,0}$ y $S_t$ (el 3.B.4 escribe $D_0$: ver contradicciones). Primas de Damodaran con la misma clave y cifra que el 3.B.23. El anexo de rentas usa la notación del anexo `perpetuidades` del 3.B.4.
- **Remisiones** del bloque III y la conclusión: 3.A.3, 3.A.10, 3.A.13, 3.A.34, 3.A.37, 3.B.1, 3.B.3, 3.B.4, 3.B.23, 3.B.27, 4.B.6 y 4.B.10.
- **Remisiones** del bloque I y II: 3.A.10, 3.A.12, 3.A.13, 3.A.25, 3.A.33, 3.A.34, 3.A.35, 3.A.43, 3.A.44, 3.B.1, 3.B.3, 3.B.4, 3.B.23, 3.B.24, 3.B.25 y 4.B.6, todas con `\vertema`; las internas con `\ref`/`\eqref`.
- **Contradicciones con otros temas** (no se tocan; ver `_trabajo/canon-pendiente.md`, § 7): el 3.B.3 copia el bloque de coste del capital del original y fecha Holmström y Tirole en 2013 (es 2011); el 3.B.1 usa EBIAT en el ROA y un ROE-ROA sin $(1-t_{IS})$; el 3.B.4 usa $D_0$ también para lo que recibe la empresa por su deuda y $\mathbb{E}(r_M)$ con paréntesis; el 3.A.25 dice «tasa interna de rendimiento» y remite el VAN al 3.A.34.

## Comentarios de Víctor (11/11/2026, 4.ª tanda)

| Comentario | Cómo se ha aplicado |
|---|---|
| Reglas generales del 11/11 (pizarra, títulos) | Quitadas o reescritas 9 indicaciones de pizarra o de caja («se borra», «recuadrada en la esquina», «(caja gris)»…) en el texto del tema, conservando tiempos y orden del cante; su contenido va a «Instrucciones para el vídeo». Títulos largos (PDF actual): ninguno (los de I y II ya cortan en su punto, decisión K2), con `\cortetitulo`. Sin `c_K` en el tema. |

## 7. Dudas abiertas

El artifact de dudas no estaba disponible en esta sesión: todas las dudas quedan aquí, con la opción recomendada ya aplicada en el tema.

- **D1. Orden de los bloques** (K1): aplicada (a), el del título rotando los bloques (criterios → otros proyectos → rentabilidad, riesgo y coste). Alternativas: (b) intercambiar solo I y II, como el 3.B.4; (c) el orden del original, justificado en la Estructura.
- **D2. Subtítulo del bloque III** (K2): aplicado «¿cuánto debe rendir la inversión?» en lugar de «¿qué es la inversión?».
- **D3. Pegatinas compartidas por modelo**: aplicadas «no por mucho madrugar amanece más temprano» (del 3.A.34) y «en el término medio está la virtud» (del 3.A.35) para los mismos modelos, como el 3.B.23 con Tobin. Si Víctor lo aprueba, conviene la regla en CRITERIOS § 8; si no, buscar refranes nuevos.
- **D4. Enganche**: aplicado Intel en Magdeburgo. Alternativa: la gigafactoría de baterías de Stellantis y CATL en Figueruelas (anunciada en diciembre de 2024).
- **D5. Holmström y Tirole**: aplicado en 2 viñetas en la tesorería con nota de corolarios, remitiendo al 3.B.3 y al 3.B.4.
- **D6. Inversiones financieras**: aplicada la mención de 30″ (alternativa: quitarlas del cante y dar el tiempo a los intangibles).
- **Contenido D1**: capítulos de Vernimmen et al. (2017): se citan 28, 29 y 30 como en las notas del original (V27 confirma la numeración en la 6.ª edición); las páginas («509 y ss.», «528-529») no se han comprobado y no se citan.
- **Contenido D2**: página de «time and risk» en Sharpe, Alexander y Bailey (1999): se cita el capítulo 1 sin página.
- **Contenido D3**: la frase «Equity is soft, debt hard…» del FT (Stewart y Glassman, 1988, según datos; la última palabra no se ha comprobado): fuera.
- **Contenido D8**: el dato de inversión de las tecnológicas de C4 no se usa (manda el enganche de Intel).
- **Contenido D9**: aplicado «tasa interna de rentabilidad», como el 3.A.34.
- **Contenido D10**: $k^{\mathrm F}$, $M^{\mathrm{inf}}$ (notación del 3.A.35), $Q$, $c_a$ y los gráficos `van-fisher` y `mapi` como gráficos de referencia: propuestos al canon en `_trabajo/canon-pendiente.md`.
- **Krüger, Landier y Thesmar (2015)**: se cita solo lo que dice su resumen (las empresas con una sola tasa invierten de más en las divisiones arriesgadas y de menos en las seguras); datos no leyó el artículo completo.
- **Las 2 empresas AAA** (Microsoft y Johnson & Johnson): solo con fuente de prensa; no se usan. Si Víctor quiere el dato, hay que comprobarlo en S&P.
- **DOI de Gordon y Shapiro**: `10.1287/mnsc.3.1.102`, el mismo que en el 3.B.4 (comprobado por el coordinador: allí ya era el correcto).
- **Contenido D4**: el ≈27 % de Graham y Harvey para las opciones reales no se ha leído en el texto: se dice «pocas empresas lo usan de forma sistemática», sin cifra. El 56,7 % del *payback* se da como «más de la mitad».
- **Contenido D5**: la cifra de Corrado, Hulten y Sichel (2009) para la inversión en intangibles frente a la tangible: se dice «del mismo orden», sin año ni cifra.
- **Contenido D6**: la ubicación de la cita de Marshall (1890) en los *Principles*; la de Becker (nota 27) se parafrasea sin comillas.
- **Contenido D7**: tercer autor de la 22.ª edición de Suárez Suárez (Paloma Suárez García, como en el original).
- **DOI** de Teichroew et al. (1965) y Corrado et al. (2009): los dio contenido de memoria; comprobar en doi.org antes de publicar. *Control de calidad (08/11/2026)*: los 2 resuelven en doi.org y Crossref da el mismo título, volumen y páginas que el `.bib`.
- **Control de calidad (08/11/2026), fuera del tema (conversor y CSS)**: (1) en el HTML, el esquema pierde los números que van tras `\quad` («1. Variables… . Principios…»: falta el «2.»); pasa igual en el 3.A.34 y en los demás temas que escriben varios epígrafes en una línea del esquema: hay que arreglarlo en el conversor a HTML, no en cada tema. (2) En modo oscuro, las filas con `\rowcolor{tceesalvia}` (aquí, «¿Coinciden?» de la tabla del VAN y la TIR) conservan el fondo claro y el «Sí» verde claro apenas se lee: es del CSS común de los temas.

## Enlaces del original (9/11/2026)

Restaurados:
- Fernández-Villaverde, «Liquidez interna y externa (I)», *Nada es Gratis* (2016): entrada `FernandezVillaverde2016Liquidez`, citada en la nota de los Nobel de Holmström y Tirole (II, la liquidez como seguro). En el original era la fuente del efectivo de las empresas del S&P 500, dato que el tema actualiza con Damodaran (2026).
- «¿En qué consiste el Método Montecarlo?» (*Date un Voltio*, YouTube): nota al pie nueva en la simulación de Monte Carlo (I.4).

No restaurados:
- Wolters Kluwer, *Guías jurídicas*, «Tasa Interna de Retorno Modificada (TIRM)»: da 404 y no se ha encontrado la dirección nueva (la guía es de pago y su dirección cambia con cada sesión). La TIRM del tema no depende de ella.

## 8. Instrucciones para el vídeo

- *Pizarra (sacado del texto del tema el 11/11/2026)*: línea de flujos arriba a lo ancho; VAN recuadrado a la derecha hasta el final; en III, el WACC con una flecha a la $k$ del VAN.

- **Enganche e idea final**: el refrán «Más vale un hoy que dos mañanas» abre (con Intel en Magdeburgo y la pregunta «¿cómo decide una empresa qué proyectos acometer, y qué rentabilidad tiene que exigirles?») y vuelve en la idea final (parte 2): más vale un hoy que dos mañanas, salvo que esos 2 mañanas, descontados al coste del capital, valgan más. Introducción y conclusión sin pizarra (`modo: guion`), con el refrán en la esquina superior izquierda.
- **Funciones clave que se conservan**: el VAN `eq:van` (`\funcionclave`), que se escribe en I.3.2 a la derecha de la pizarra y se conserva hasta el final (`conservar:`); el WACC `eq:wacc` (bloque III, parte 2), recuadrado con una flecha a la $k$ del VAN: es el cierre del hilo. La regla de la opción de esperar (`eq:opcion-esperar`) se escribe en una línea bajo el VAN y se borra al cambiar de bloque.
- **Bloque I** (rejilla sugerida «100» arriba para la línea de flujos y «65|35» debajo): arriba, a lo ancho, `esquema-pagos` por capas (imprescindible), numerando las 5 variables; en el centro, `van-fisher` por capas (imprescindible): ejes, VAN_A y su TIR, VAN_B y su TIR, punto de Fisher, y debajo la tabla `tab:van-tir` en versión mínima (3 columnas, 3 filas); pegatinas «borrón y cuenta nueva» (I.2), «lo bueno, si breve, dos veces bueno» (comparación) y «no por mucho madrugar amanece más temprano» (opción de esperar), cada una junto a su concepto. Apoyo (no se escribe): la tabla de tipos de inversión `tab:signos`, `tirm`, `arbol-opciones`, `van-sin-fisher` (dibujado, pero ya no va en la nota del punto de Fisher, para no dejar un tercio de página en blanco; puede servir de apoyo en el vídeo), el problema del racionamiento con `\optim` y las cifras de Graham y Harvey.
- **Bloque II**: se borra el centro (el VAN se queda). Gráfico conjunto por partes: a la izquierda, la fórmula de Wilson $Q^*$; en el centro, `baumol-tesoreria` por capas, primero el panel b (costes en U, imprescindible) y el panel a (dientes de sierra) si da tiempo; debajo de $M^*$, la fórmula de Wilson ya escrita, para que se vea que es la misma (no se escribe 2 veces: $M^*$ se escribe debajo de $Q^*$ y se dice «el tipo de interés es el coste de almacenar el dinero»); luego, en el hueco de la derecha, `miller-orr` (recomendado). `mapi` pequeño antes de la tesorería, con «renovarse o morir». Pegatina «en el término medio está la virtud» junto a la U. La subida del tipo (capa 9 de `baumol-tesoreria`) puede ir como apoyo. Holmström y Tirole, intangibles, inversiones financieras y capital humano, de palabra (`apunte:` con autor y año).
- **Bloque III**: se borra el centro (el VAN se queda). La relación ROE-ROA `eq:roe-roa` en una línea y el GAO y el GAF con el ejemplo en 2 líneas (se borran después). En el centro, el esquema de las 3 vías (`tab:vias-coste`, imprescindible) en 3 columnas, que se va llenando: en la directa, el CAPM y Hamada; en la implícita, Gordon-Shapiro despejado; en la indirecta, el WACC `eq:wacc` recuadrado (`\funcionclave`), con una flecha a la $k$ del VAN de la derecha: «es la tasa que faltaba». Las primas de Damodaran y la nota de S&P, como apoyo. Al final la pizarra queda lo más limpia posible: el VAN, el WACC y la flecha.
- **Conclusión**: `modo: guion`, empieza por «En conclusión,»; la idea final retoma el refrán y a Intel.
- **Gráficos pedidos** (`_trabajo/graficos-pedidos.json`): `esquema-pagos`, `van-fisher`, `van-sin-fisher`, `tirm`, `arbol-opciones`, `mapi`, `baumol-tesoreria`, `miller-orr` (ya copiado; solo compilar) y `cadena-renovaciones` (anexo, parte 2).
