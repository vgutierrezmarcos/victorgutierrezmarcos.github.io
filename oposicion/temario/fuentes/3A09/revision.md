# Revisión del tema 3.A.9

**Teoría de la demanda del consumidor (II). Dualidad e integrabilidad de las preferencias. Sistemas de demanda utilizados en estudios empíricos. Medidas de cambio en el bienestar.**

Fecha: 13/10/2026. Fuente nueva: `3A09.tex` y `3A09.bib`. El tema se ha integrado en tres partes (1: introducción, I y II; 2: III; 3: conclusión y anexos); cada sección del informe recoge las tres.

## Resumen

- Introducción reescrita con sus cinco bloques y propia del tema (ya no copia la de 3.A.8): enganche con la revalorización de las pensiones por el IPC (pregunta que responde la idea final), contextualización por las cuatro líneas del tema (dualidad, integrabilidad, bienestar, sistemas de demanda), problemática distinta de la contextualización y estructura con los tres bloques y el porqué del orden.
- Bloque I recortado y reequilibrado: el primal se resume con remisión a 3.A.8; el dual (minimización del gasto, demanda hicksiana, función de gasto, Shephard, matriz de Slutsky) se desarrolla como tema de referencia; tablas de ingredientes y de pares duales; esquema de dualidad corregido.
- Bloque II reescrito: idea con fines y requisitos, cinco pasos con Cobb-Douglas, LES, Rotterdam, translog indirecta, AIDS completo y QUAIDS, cuadro comparativo, separabilidad, EPF vigente, especificación, resultados y usos; la Valoración, vacía en el original, está escrita.
- Bloque III: integrabilidad con el teorema de Frobenius y condiciones necesarias y suficientes (sin la contradicción del original); Slutsky derivada por dualidad, con la matriz y sus propiedades y la clasificación en versión compacta; bienestar con excedente, métrica monetaria, VC y VE, Willig y Hausman, variaciones de Laspeyres y Paasche, índices de Konüs, Laspeyres, Paasche, Fisher y Törnqvist, sesgo del IPC (Boskin, Manser y McDonald, IPC encadenado de EE. UU.) y cajas del IPC base 2025 y del deflactor.
- Conclusión con sus cinco bloques (la idea final responde a la pregunta de las pensiones del enganche) y caja de lecturas; seis anexos (Kuhn-Tucker y CSO con Sarrus, envolvente con Roy y Shephard, hessiana y cuasiconcavidad, ordenación demostrada de las medidas, Willig y test).
- Minutos: introducción 3, I 7, II 5, III 12, conclusión 3 (30). Siete gráficos en TikZ (`_trabajo/graficos-pedidos.json`, dibujados en `graficos/`). El PDF tiene 37 páginas y compila sin errores ni referencias sin definir; el tema también se genera en HTML y Word.

## Errores corregidos

| Dónde (original) | Decía | Dice ahora |
|---|---|---|
| Introducción, enganche (l. 33) | Cita de Marshall entre comillas que no es literal | Se quita: el enganche es nuevo (pensiones e IPC), sin cita textual |
| Introducción (l. 67-73) | «Las 3 leyes de Gossen» | Se quita la historia del ordinalismo (está en 3.A.8) |
| Introducción (l. 75) | Walras y Marshall «siguen a Gossen» | Se quita (3.A.8 ya lo cuenta bien) |
| Introducción (l. 79) | Pareto (1896) | Se quita (3.A.8 dice 1906) |
| Introducción (l. 81) | Hicks y Allen (1934) «introducen el concepto de preferencias» | Se quita (3.A.8: reformulan la teoría en términos ordinales) |
| Introducción (l. 85) | Antonelli (1886) «daría origen a la teoría de la dualidad» | Antonelli plantea la integrabilidad; la dualidad viene de Hotelling (1932), Hicks (1939), Roy (1947), Shephard (1953) y McKenzie (1957), y la generalizan Uzawa (1964) y Diewert (1974) |
| Introducción (l. 87) | Preferencia revelada de Samuelson (1947) | Samuelson (1938, 1948) y Houthakker (1950) |
| Introducción (l. 115-119) | La problemática copiaba tres preguntas de la contextualización | Cuatro preguntas nuevas, una por bloque y una para la medida del bienestar |
| Introducción, estructura (l. 121-133) | Anunciaba dos bloques y omitía el II | Anuncia los tres y justifica el orden |
| I.1 (l. 166-179) | Monotonía estricta en la lista de axiomas; «riqueza» | Insaciabilidad local (como 3.A.8); «renta» |
| I.2.1 (l. 281, 351) y I.2.2 (l. 461, 543) | Ley de Walras y «no exceso de utilidad» por la «estricta monotonía» | Walras, por la insaciabilidad local; la saturación del dual, por la continuidad de U (MWG, prop. 3.E.3) |
| I.2.1 y I.2.2 (l. 321, 503) | $RMS\equiv-UMg_1/UMg_2=-p_1/p_2$ | $RMS_{12}=U_1/U_2=p_1/p_2$, positiva (canon) |
| I.2.1, propiedad 6 de la FIU (l. 377) | Cuasiconvexidad «debido a la convexidad de las curvas de indiferencia»; «presupuestarios extremos» | Redactada como en 3.A.8 revisado: no depende de la convexidad de las preferencias |
| I.2.2 (l. 428-443) | Variable de elección $h$ en el PMG; multiplicador μ | Variable de elección $x$ (la solución es $h(p,\overline U)$); multiplicador $\lambda^E$ |
| Nota 18 | λ y μ «relacionados de forma inversa» (vago) | $\lambda^{E*}=1/\lambda^*$, con la derivación en nota |
| I.2.2, SCEDC (l. 518) | El vector repetía $h_1^*$ | $h_1,\dots,h_n$ |
| I.2.2, propiedad 3 (l. 541) | $h(\theta p,\overline U)$ (θ es la CRRA en el canon) | $h(kp,\overline U)$ |
| I.2.2, propiedad 5 (l. 547) | La matriz de Slutsky, «matriz de primeras derivadas» | Primeras derivadas de $h$, segundas de $E$ |
| I.2.2, FG propiedad 6 (l. 571) | Concavidad explicada como «aumentos en los precios llevan a aumentos en el gasto menos que proporcionalmente» (contradice la homogeneidad de grado uno) | Plano tangente: $E(p',\overline U)\le p'\cdot h(p,\overline U)$, con la aclaración de que con subidas equiproporcionales el gasto sube en la misma proporción |
| I.2.2, matriz de Slutsky (l. 581-591) | $s_{ij}$ (choca con la participación $s_i$) | $S_{ij}$ (canon) |
| I.3 (l. 651) | $V(p,w)$ en minúscula | $V(p,\overline W)$ |
| Imagen 3 (l. 494) | Repetía el fichero de la Imagen 1 | Gráfico doble nuevo `primal-dual` |
| Imagen 5 (cuadro resumen) | Shephard con signo menos; $w$ minúscula en Roy; $V(p,\overline W)=V(p,V(p,\overline W))$ y $E(p,\overline U)=V(p,E(p,\overline U))$ | Pedido corregido en `esquema-dualidad`; en el texto, las cuatro identidades bien escritas (ec. `eq:dual-valor` y `eq:dual-demanda`) |
| II.2, Cobb-Douglas (l. 705-744) | $\sum\alpha_i=1$ y a la vez «homogénea de grado α+β», demandas con α/(α+β) y $P_x$ | Forma del canon: participaciones constantes $s_i=\alpha_i$, $\ln x_i=\ln\alpha_i+\ln\overline W-\ln p_i$; las demandas, en 3.A.8 |
| II.2, Stone-Geary (l. 748-756) | «Forma log-lineal», «diferencias de logaritmos», errata «comparará» | Sistema lineal de gasto con su ecuación $p_ix_i=p_i\gamma_i+\alpha_i(\overline W-\sum p_j\gamma_j)$ y sus límites |
| II.2, translog (l. 768) | Directa con «−ln u(x)» y sin autores | Solo la indirecta de Christensen, Jorgenson y Lau (1975), con las participaciones por Roy |
| II.2, paso 3 (l. 800) | La Encuesta Continua de Presupuestos Familiares como fuente vigente | Es la antecesora (1985-2005); hoy, la EPF anual (desde 2006), con panel corto |
| Nota 27 | Motivación del Nobel de Deaton con «los sistemas de demanda» | Motivación oficial: «por su análisis del consumo, la pobreza y el bienestar» |
| Nota 29 | Copia literal del BICE 3070 (Aguilar y Mateos, 2015, pp. 21-22); Rotterdam como «versión generalizada del Sistema Lineal de Gasto»; *Economic and Consumer Behavior* | Reescrita con palabras propias en II.2, paso 5, citando el BICE; Rotterdam como sistema en diferencias de Barten (1964) y Theil (1965); *Economics and Consumer Behavior* |
| Nota 30 | «entrevistas o empresas» | «encuestas o experimentos de precios» |
| Nota 26 | Douglas senador «entre 1949 y 1966»; reparto 70/30 | Una línea: estimación de 1928 con 3/4 para el trabajo y 1/4 para el capital; senador de 1949 a 1967; remisión a 3.A.11 |
| III.1 (l. 830) | Antonelli «de la Escuela de Lausanne» | Se quita (era ingeniero formado en Pisa y Milán) |
| III.1 (l. 864) y nota 32 | «Teorema de Rouché-Frobenius», con un vídeo de YouTube sobre sistemas lineales | Teorema de **Frobenius** (integrabilidad de sistemas de ecuaciones en derivadas parciales), citando MWG §3.H; se quita el vídeo |
| III.1 (l. 834) frente a l. 880 y nota 33 | «Si y solo si» frente a «condición suficiente, pero no necesaria» | Necesarias y suficientes, explicando por qué; nota 33 suprimida |
| III.1 (l. 842) | Cita entre comillas de Jehle y Reny («una bella ilustración…») no comprobada | Se quitan las comillas: «es una buena muestra de la potencia de la dualidad» |
| III.1 (l. 874-878) | Tres escaneos sin fuente | Ecuación `eq:u-desde-v` y gráfico `recuperar-utilidad` |
| III.2 (l. 917) | «Ecuación de Slusky» | Ecuación de Slutsky |
| III.2, tabla (l. 956) | «Bien Giffen o Veblen» (rojo) | Giffen en la clasificación; Veblen aparte (el precio entra en las preferencias), como en 3.A.8 |
| III.2 | $s_{ij}$, $\varepsilon^c_{ij}$ | $S_{ij}$, $\varepsilon^h_{i,p_j}$ (canon y 3.A.8) |
| III.3 (l. 1041) | Dupuit (1884) | Dupuit (1844) |
| III.3 (l. 1059, 1089, 1097) | Integrales sin $dp_1$; «VEC» | Con $dp_1$; $\Delta EC$ |
| III.3 (l. 1067) | El excedente es válido solo con utilidad cuasilineal y supone elasticidades cruzadas nulas | Exacto con efecto renta nulo en el bien que cambia; con varios precios, independencia del camino solo con elasticidades-renta iguales o efectos renta nulos; aproximación de Willig |
| Nota 36 | VC y VE «introducidas por Hicks (1956) y desarrolladas por Willing (1976)» | Hicks (1939, 1941, 1943), sistematizadas en 1956; Willig (1976) muestra cuándo el excedente las aproxima |
| III.3 (l. 1161) | VE para políticas «en consideración», VC para las «implementadas» | VE para ordenar varias políticas (misma referencia de precios); VC para diseñar compensaciones (MWG §3.I) |
| III.3 (l. 1201, 1249; notas 39 y 41) | Laspeyres y Paasche como «aproximación mediante una serie de Taylor» | Laspeyres es la aproximación de primer orden de $E(p^1,\overline U^0)$ y, por la concavidad, una cota superior de $I_K(\overline U^0)$; Paasche, cota inferior de $I_K(\overline U^1)$; solo con preferencias homotéticas $I_P\le I_K\le I_L$ |
| III.3 (l. 1243) | En la sección de la VE, «no es posible calcular el índice de variación compensatoria» | Desaparece al reescribir los índices como $I_K(\overline U^0)$ e $I_K(\overline U^1)$ |
| Nota 38 | Igualdad «si los bienes fueran independientes netos» | «Si no hay posibilidad de sustitución (preferencias de Leontief)» |
| Nota 40 | Los consumidores «sustituyen ítems más baratos por ítems más caros» | Sustituyen los que se encarecen por los que se abaratan |
| Caja del IPC (l. 1230) | «Las ponderaciones se revisan en cada período»; sin base | Laspeyres encadenado, base 2025, ponderaciones anuales con CN y EPF, actualización completa en cada cambio de base |
| Caja del deflactor (l. 1266) | Paasche de base fija | Paasche encadenado (volúmenes encadenados del SEC 2010) |
| Imágenes 6 y 7 | Fuente salasweb.info (enlace roto, 404) | Gráfico nuevo con fuente MWG §3.I |
| Imagen 8 (al final de III.3) y Anexo 3 manuscrito | Subida de precio con «EC»; nota manuscrita privada | Fusionados en `bienestar-vc-ve` (bajada, bien normal, $\Delta EC$, capas de $L$ y $P$); la nota no se publica |
| Conclusión | Opinión vacía; sin sistemas de demanda ni remisiones | Cinco bloques completos con remisiones (3.A.12, 3.A.16, 3.A.22, 3.A.24, 4.B.6, 4.B.9, 3.A.30, 4.A.1, 3.A.10, 3.A.29) |
| Anexos 1-4 | Demostraciones manuscritas y capturas en inglés sin fuente | Anexos B, C y D en LaTeX con la notación del canon |
| «Preguntas de otros exámenes» y enlace a quia.com | Vacío; enlace a «Quia - A08» | Se quita lo vacío; enlace al simulador del sitio en el anexo de test |

## Marcas resueltas

| Marca (original) | Qué hacía | Qué se ha hecho |
|---|---|---|
| Nota al opositor inicial (l. 3-17, P3): cambio de temario de 2023 y ficha del tribunal | Aviso de trabajo | Se quita. La ficha sirve para completar contenidos: métrica monetaria y clasificación bruta/neta (partes 2 y 3) |
| Comentario «Incluir Regla de Sarrus…» (l. 19-21, P8) | Nota de trabajo | No se publica; se resuelve en el anexo A (parte 3), al que remite el texto |
| Comentarios con marcas de clases (l. 23-25, 29-31; P9) | Notas privadas | No se publican |
| Tabla vacía y salto en amarillo (l. 135-140, P2) | Hueco | Se quitan; la estructura se escribe de verdad, con esquema de pizarra y nota al opositor |
| Tablas-esquema rotas (l. 154-164, 197-205, 401-409; P26a) y tabla de axiomas (l. 170-179, P26b) | Esquemas de Word | Sustituidos por la tabla `tab:ingredientes` (objetivo, restricción, parámetros, solución y función valor de cada problema) y la frase de ingredientes con remisión a 3.A.8 |
| Caja «Teoremas básicos de la optimización condicionada» (l. 245-259, P17a) | Unicidad mal redactada; repetía 3.A.8 | Se quita y se remite a 3.A.8, donde está corregida |
| Nota 10, «Regla de Sarrus» (P8) | Marcador vacío | Se quita; el texto remite al anexo A (condiciones de segundo orden con el hessiano orlado) |
| Imagen 1 (P18), Imagen 3 (P20), Imagen 4 | Escaneos de Maté y Pérez Domínguez; la 3 repetía la 1 | Gráfico `primal-dual` (dos paneles), pedido en TikZ |
| Imagen 2 (P19) | Cuasiconvexidad de la FIU | Gráfico `cuasiconvexidad-fiu`, pedido en TikZ, como profundización |
| Imagen 5 (P21) | Cuadro resumen con errores | Gráfico `esquema-dualidad`, pedido en TikZ con las correcciones |
| Comentario de II (l. 675-677, P10) | Nota privada | No se publica |
| Nota al opositor de II (l. 679-681, P4): ampliar con Deaton | Nota de trabajo | Se quita; el bloque II se amplía (AIDS, QUAIDS, Rotterdam, resultados de Barten, Deaton y Deaton y Muellbauer) |
| Imagen sin título ni fuente en II.2, paso 2 (l. 786, P23) | Escaneo del sistema en cantidades y participaciones | Ecuación `eq:sistema-completo` con la notación del canon |
| Nota 28: «Leer páginas 21 y 22» (P37) | Instrucción privada | Se quita; el BICE se cita en el texto, con las páginas 21-22 |
| II.3 Valoración vacía (P29a) | Hueco | Escrita (aportaciones y tres limitaciones, enlace con la integrabilidad) |
| Comentario de III.1 (l. 822-824, P11): «Candidato a recortar… a partir de 2024» | Nota privada (y con la fecha mal: el título es de la convocatoria de 2023) | No se publica; la integrabilidad se canta (3 minutos) |
| Comentario «En el tema de Zapico…» (l. 888-890, P12) | Nota privada | No se publica |
| Nota al opositor «Ver Pérez Domínguez (UVa)…» y comentarios (l. 894-904, P5, P13) | Nota de trabajo | No se publica. No se ha podido consultar ese documento; III.2 se ha contrastado con MWG §3.G y Jehle y Reny (2011) |
| Rojo «Bien Giffen o Veblen» (l. 956, P1) | Dudoso | Resuelto como en 3.A.8: Giffen en la clasificación y Veblen aparte |
| Comentario «explayarse y representar efecto sustitución y renta» (l. 995-997, P14) | Nota privada | No se publica; el texto remite al gráfico de la descomposición de 3.A.8 |
| Caja «Relación entre la VC y la VE en otros casos» y su tabla (l. 1103-1155, P17b) | Correcta en valor absoluto, sin $L$ ni $P$ | Tabla con signo y con $L$ y $P$ (`tab:ordenacion`), demostrada en el anexo D |
| Nota al opositor «Aquí falta incluir Paasche y Laspeyres (en la versión compensación)… y meter la Imagen 8» (l. 1167-1169, P6) | Tarea | Hecha: variaciones $L$ y $P$ (ec. `eq:var-laspeyres-paasche`), cotas, ordenación y capas del gráfico `bienestar-vc-ve` |
| Cajas del IPC y del deflactor (P17c, P17d) | Anotaciones | Conservadas y actualizadas (V3-V6), con remisiones a 4.A.1 y 3.A.30 |
| Nota al opositor «Comodín: 4.B.9…» (l. 1289-1291, P7) y nota 37 | Consejo útil | Reescrita como `notaopositor` (exceso de gravamen $EG=-VE-T$) y extensión de la conclusión |
| Comentarios de los anexos (clases, «Coordinar en temas 3.A.8, 3.A.9 y 3.A.12», P9, P15) | Notas privadas | No se publican; el anexo C se propone como versión común (Coherencia) |
| Nota al opositor «Buscar regla de Sarrus» (l. 1379-1381, P8) | Tarea | Hecha en el anexo A (hessiano orlado y Sarrus, con las CSO del primal y del dual) |
| Anexo 3 manuscrito con «Según mis cálculos, no lo veo en ningún sitio» (P20, P37) | Duda privada | La ordenación está verificada (anexo D) y confirma lo que Víctor escribió a mano; la nota no se publica |
| Línea suelta «Vector gradiente de primeras derivadas» (l. 1407) | Sin contexto | Integrada en el anexo C |
| Bibliografía: comentario sobre Rodríguez López y «Tema Juan Luis Cordero Tarifa» (P16) | Notas privadas | No se publican; Rodríguez López pasa a la caja de lecturas complementarias como material no publicado; Cordero se quita |

## Datos actualizados

| Dato | Valor anterior | Valor nuevo | Fuente | URL | Consulta | Segunda comprobación |
|---|---|---|---|---|---|---|
| Revalorización de las pensiones (enganche, V9) | — | Media de las tasas interanuales del IPC de los doce meses anteriores; 2,7 % en 2026 | BOE, LGSS art. 58; Ministerio de Inclusión (12/12/2025) | https://www.boe.es/buscar/act.php?id=BOE-A-2015-11724 ; https://www.lamoncloa.gob.es/serviciosdeprensa/notasprensa/inclusion/Paginas/2025/121225-revalorizacion-pensiones.aspx | 13/10/2026 | Media de las tasas del INE (tabla 76134) de dic. 2024 a nov. 2025 = 2,667 % (verificador de datos) |
| EPF (II.2, paso 3; V1) | «Encuesta de Presupuestos Familiares», sin más | Anual desde 2006, unos 24.000 hogares, microdatos; EPF 2025: gasto medio por hogar de 35.101 € | INE, nota de prensa EPF 2025 (25/06/2026) | https://www.ine.es/dyngs/Prensa/EPF2025.htm | 13/10/2026 | INE, metodología de la EPF y EPF base 2006, *Principales características* |
| ECPF (II.2, paso 3; V2) | Fuente vigente de panel | Antecesora (1985-2005), trimestral, ocho trimestres por hogar; la EPF da un panel de dos años | INE, metodología de la EPF | https://www.ine.es/metodologia/t25/t2530p458.pdf | 13/10/2026 | INE, EPF base 2006, *Principales características* |
| Estimación de un AIDS con la EPF para el IVA (II.2, paso 5; V13) | — | Sanz-Sanz y Romero-Jordán (2012), CIE 228 | Funcas | https://www.funcas.es/wp-content/uploads/Migracion/Articulos/FUNCAS_CIE/228art02.pdf | 13/10/2026 | CIE 229 de los mismos autores (verificador) |
| Enlace del BICE 3070 (V54) | presidencia.gva.es | argos.gva.es (destino de la redirección) | `3A09.bib` | https://argos.gva.es/documents/166658342/166714754/Ejemplar+3070/2957e02b-f135-4235-98a6-bfc909292066 | 13/10/2026 | Redirección 301 comprobada por el verificador |
| Sesgo del IPC: Comisión Boskin (III.3; V10) | — | 1,1 puntos al año, de ellos 0,4 de sustitución | Gordon (2006), NBER WP 12311 | https://www.nber.org/papers/w12311 | 13/10/2026 | Kliesen (1997), Fed de St. Louis (0,4 de 1,1) |
| Sesgo de sustitución con índices superlativos (V11) | — | 0,18 puntos al año (1959-1985) | Manser y McDonald (1988), *Econometrica* | https://doi.org/10.2307/1912704 | 13/10/2026 | Resumen en IDEAS/RePEc |
| CPI-U frente a C-CPI-U (V12) | — | 0,25 puntos menos al año (dic. 2005-dic. 2024, cálculo propio con las series del BLS); 0,25-0,3 | BLS, API (CUUR0000SA0 y SUUR0000SA0) | https://api.bls.gov/publicAPI/v1/timeseries/data/SUUR0000SA0 | 13/10/2026 | Klick (2021), BLS (0,3) |
| IPC: fórmula y base (caja; V3, V5) | Laspeyres encadenado «revisado en cada período»; sin base | Laspeyres encadenado, base 2025 desde enero de 2026, ECOICOP v2, precios de referencia de diciembre del año anterior, ponderaciones anuales (las de 2026 con datos de 2024) | INE, *IPC base 2025. Metodología*, pp. 5, 8 y 16 | https://www.ine.es/metodologia/t25/metodologia_IPC_base_2025.pdf | 13/10/2026 | INE, *Principales novedades metodológicas del IPC base 2025* |
| IPC: cesta y ponderaciones 2026 (caja; V4) | — | 487 artículos, 196 subclases, 13 grupos; alimentos 17,4 %, restauración y alojamiento 17,0 %, transporte 15,5 % | INE, tabla 76156 | https://www.ine.es/jaxiT3/Tabla.htm?t=76156 | 13/10/2026 | *Principales novedades*, pp. 4, 5 y 7, y API |
| Deflactor del PIB (caja; V6) | Paasche de base fija | Paasche encadenado; +3,0 % en 2025 | INE, CNA 2023-2025 (18/09/2026); SEC 2010 | https://www.ine.es/dyngs/Prensa/CNA2025.htm | 13/10/2026 | Eurostat, `nama_10_gdp` (3,0). Los números de apartado del SEC 2010 no se comprobaron en EUR-Lex: se cita el capítulo 10 sin apartados |
| Indexación de las pensiones (III.3; V9) | Indexación «de todo tipo de rentas», sin ejemplo | Pensiones revalorizadas con la media de las tasas del IPC (art. 58 LGSS) | BOE | https://www.boe.es/buscar/act.php?id=BOE-A-2015-11724 | 13/10/2026 | Ver la fila del enganche |
| IPC de septiembre de 2026 (V8) | — | **No se usa**: el INE solo ha publicado el indicador adelantado (4,9 %); el definitivo no estaba publicado a 13/10/2026 | INE, API Tempus, tabla 76134 (dato de septiembre con tipo «provisional/adelantado») | https://servicios.ine.es/wstempus/js/ES/DATOS_TABLA/76134?nult=3 | 13/10/2026 | La nota IPC0926 aún devuelve 404 |

Fechas y atribuciones corregidas en esta parte (sin cifra): V18 (Samuelson 1938 y 1948), V21 (Antonelli, integrabilidad; ingeniero de Pisa, no de Lausana), V23 (Nobel de Deaton), V24-V26 (nota 29), V27 (Cobb-Douglas), V30-V31 (Marshall y Gossen: se quitan), V41-V44 (Stone, Geary, CJL 1975, AIDS 1980, Muellbauer 1975-1976, Deaton 1974), V40 (Blume, 2008). Los DOI de las entradas nuevas del `.bib` (Hotelling, Uzawa, Klein y Rubin, Barten 1964, Gorman 1959, Strotz, Working, Leser, Pollak y Wales, Blundell, Browning y Crawford, Banks, Blundell y Lewbel) se han comprobado en Crossref; el DOI de Working (1943) que proponía el agente de contenido era erróneo y se ha cambiado por el de Crossref (10.1080/01621459.1943.10501775). Diewert (1974, pp. 106-171) y Gorman (1981, pp. 7-30) se han comprobado en referencias indexadas en Crossref.

## Contenido añadido

Parte 1:
- **Introducción**: enganche nuevo (pensiones e IPC, la utilidad no se resta, función de gasto); relevancia en tres planos (C5); contextualización con la historia de la dualidad (Hotelling, Hicks, Roy, Shephard, McKenzie, Uzawa, Diewert), de la integrabilidad, de la medida del bienestar (Dupuit, Marshall, Hicks, Willig, Konüs) y de los sistemas de demanda (Stone, Deaton y Muellbauer, Nobel de 2015) (K3, C6); el párrafo del sentido estricto y amplio de «dual» con la nota 7 reescrita; esquema de pizarra y nota con el reparto de minutos (K1).
- **I.1**: tabla `tab:ingredientes` con los papeles cambiados en cada problema.
- **I.2.2**: existencia de solución del PMG (MWG, prop. 3.E.1); $\lambda^E$ como coste marginal de la utilidad y $\lambda^{E*}=1/\lambda^*$ con su derivación; ley de la demanda compensada en forma general; concavidad de $E$ con el argumento del plano tangente y gráfico nuevo `concavidad-fg`; intuición del lema de Shephard; matriz de Slutsky como $D^2_pE$ con $Sp=0$; tabla de pares duales `tab:pares-duales` (K8).
- **I.3**: enunciado del teorema básico (MWG, prop. 3.E.1); ejemplo Cobb-Douglas de inversión de $V$ en $E$ (comprobado); idea clave y recapitulación que anuncia el resto del tema (K9).
- **II.1**: tres fines de los sistemas de demanda y cuatro requisitos (Deaton y Muellbauer, 1980a y 1980b). La agrupación en requisitos se inspira en el tema de Tebar (3A09), redactado de nuevo y apoyado en Deaton y Muellbauer, sin citar el tema del preparador (CRITERIOS §5).
- **II.2**: modelo de Rotterdam con su ecuación y restricciones; translog indirecta con sus participaciones; AIDS completo (función de gasto PIGLOG, participaciones, restricciones, curvas de Engel de Working-Leser, elasticidades, agregación exacta, LA-AIDS); QUAIDS (Banks, Blundell y Lewbel, 1997); tabla comparativa `tab:sistemas` (C18); separabilidad débil y presupuestación en dos etapas (Strotz, 1957; Gorman, 1959); valores unitarios (Deaton, 1997); singularidad de la matriz de covarianzas (Barten, 1969), endogeneidad del gasto, censura y variables demográficas (Pollak y Wales, 1981); historia de los contrastes (nota 29 reescrita) y contrastes no paramétricos (Blundell, Browning y Crawford, 2003); usos y ejemplo español (Sanz-Sanz y Romero-Jordán, 2012). El enfoque comparativo LES-Rotterdam-AIDS lo usan también Tebar y Cabado (DCE 3.A.4); aquí está redactado de nuevo.
- **II.3**: valoración completa (K12 y C24 fusionadas).

Partes 2 y 3:
- **III.1**: teorema con su enunciado y la necesidad y suficiencia explicadas; simetría automática con dos bienes (cálculo propio, en nota); intuición en tres pasos con el teorema de Frobenius; recuperación de la utilidad (ec. `eq:u-desde-v`, gráfico `recuperar-utilidad`); preferencia revelada (Houthakker, KMS, Afriat); relevancia teórica, empírica y normativa (Hausman, 1981).
- **III.2**: derivación por dualidad, forma en elasticidades, compensación de Hicks y de Slutsky, propiedades de $S$ (todo bien tiene un sustitutivo neto), clasificación compacta (propio y cruzado, netos simétricos y brutos no), pendientes de las demandas como puente a III.3.
- **III.3**: métrica monetaria (McKenzie, 1957; Samuelson, 1974; MWG §3.I) con VC y VE como sus diferencias; VC y VE como disposición a pagar y a aceptar; independencia del camino; aproximación de Willig y crítica de Hausman; criterio de elección entre VC y VE; nota del exceso de gravamen; variaciones de Laspeyres y Paasche con sus cotas; índice de Konüs, cotas de Laspeyres y Paasche, índices superlativos de Fisher y Törnqvist (Diewert, 1976); magnitud del sesgo de sustitución (V10-V12); *salus populi* con su fuente (Cicerón, *De legibus*, III, 8).
- **Conclusión** con sus cinco bloques y caja de lecturas complementarias.
- **Anexos**: A (Kuhn-Tucker de los dos problemas lado a lado y CSO con hessiano orlado y Sarrus, comprobadas a mano), B (envolvente: Roy por envolvente y por dualidad, Shephard por envolvente y por concavidad), C (hessiana, concavidad y cuasiconcavidad; propuesto como versión común), D (ordenación de las medidas, demostrada), E (Willig) y F (test, con el enlace al simulador).

### Propuestas de esta parte: aplicadas y rechazadas

**Contenido (C1-C25)**
- C1 (reequilibrio, primal en resumen): aplicada.
- C2 (minutos): **no aplicada en sus cifras**; mandan las de coherencia (I 7, II 5, III 12), como se indicó.
- C3 (orden: integrabilidad tras los sistemas): aplicada; enlaces en II.1, II.2 (paso 5) y II.3.
- C4 (enganche con la nota de prensa del Nobel de 2015): **rechazada**. La página de nobelprize.org devolvía 403 al verificador y la frase no está comprobada; además, el enganche de coherencia (compensar a un hogar cuando sube un precio) enlaza con la idea final. Se ha concretado con la revalorización de las pensiones (V9, dato comprobado). El Nobel de Deaton sale en la contextualización con la motivación oficial.
- C5 (relevancia teórica, empírica y normativa): aplicada.
- C6 (contextualización): aplicada, fusionada con K3.
- C7 (problemática): aplicada, fusionada con K2 (cuatro preguntas, una por bloque).
- C8 (estructura y esquema): aplicada con el texto de K1 y el esquema de coherencia § 3.2; la nota de minutos, con las cifras de coherencia.
- C9 (I.1 e I.2.1 en resumen): aplicada. Se conserva la frase de ingredientes y se añade la tabla de I.1; las propiedades de la FIU se dan en una frase y la cuasiconvexidad va en nota y gráfico de profundización (no desaparece lo que tenía el original).
- C10 (dual, planteamiento): aplicada con $\lambda^E$ en lugar de μ y con las condiciones completas de Kuhn-Tucker en el anexo A (K6/K21), no en el cuerpo.
- C11 (hicksiana): aplicada.
- C12 (función de gasto, concavidad, Shephard, matriz de Slutsky): aplicada; gráfico `concavidad-fg` pedido.
- C13 (gráfico primal-dual y esquema corregido): aplicada; el gráfico se pide con **dos** paneles (coherencia K9) y una capa final con $\overline W=E^*$, $\overline U=U^*$ en lugar del tercer panel.
- C14 (relaciones de dualidad e idea clave): aplicada.
- C15 (quitar nota y comentario de II): aplicada.
- C16 (II.1): aplicada, fusionada con K10.
- C17 (formas funcionales): aplicada con dos cambios: Stone-Geary con $\alpha_i$ (como el anexo `anexo:sistemas` de 3.A.8, K11) en lugar de $\beta_i$; Rotterdam con $b_i$, $c_{ij}$ (K11) en lugar de $\theta_i$, $\pi_{ij}$, para no chocar con θ (CRRA) del canon; QUAIDS con $\vartheta_i$ (C4 del canon) en lugar de $\lambda_i$. La elasticidad compensada se escribe $\varepsilon^h_{i,p_j}$, como 3.A.8 revisado. El LES se precisa: no admite complementarios **netos** (con $\gamma_j>0$ sí puede haber complementariedad bruta). Se rebaja «hoy es el estándar» del QUAIDS.
- C18 (tabla comparativa): aplicada; LES «lineal en los parámetros: no» (el original de la propuesta decía «casi») y QUAIDS «agregación: sí».
- C19 (sistema completo y separabilidad): aplicada.
- C20 (EPF): aplicada con las cifras de V1 y V2.
- C21 (especificación): aplicada.
- C22 (resultados y usos): aplicada, con la nota 29 reescrita (V26) y el ejemplo español (V13). Deaton (1988) no se cita: no se han podido comprobar sus datos bibliográficos; basta Deaton (1997).
- C23 (nota del Nobel): aplicada en la contextualización.
- C24 (valoración): aplicada, fusionada con K12.
- C25 (nota 26): aplicada con la línea acordada (3/4 y 1/4, senador hasta 1967, remisión a 3.A.11).
- C26 (integrabilidad): aplicada. La frase de Jehle y Reny va sin comillas (V58).
- C27 (Slutsky y clasificación): aplicada en versión compacta, sin tablas (criterio fijado). No se reproduce aquí el gráfico de 3.A.8: se remite a él.
- C28 (idea de III.3): aplicada, conservando el *salus populi* de Víctor con su fuente (V46).
- C29 (métrica monetaria): aplicada con $m(\bar p;p,\overline W)$ (coherencia) en lugar de μ, que en el canon es otra cosa; se omite la versión directa $m(\bar p,x)$.
- C30 (VC y VE): aplicada; el gráfico se pide como `bienestar-vc-ve` (nombre de coherencia), no `vc-ve`.
- C31 (excedente, Willig, Hausman): aplicada.
- C32 (L y P, ordenación): aplicada; la tabla va al anexo D (K16/K21) y el gráfico `ordenacion-medidas` no se pide aparte: $L$ y $P$ son las capas finales de `bienestar-vc-ve` (K16).
- C33 (cuál usar): aplicada sin citar a Chipman y Moore (1980), cuyos datos no se pudieron comprobar; la nota del exceso de gravamen cita MWG §3.I sin número de ejemplo ni página (V60).
- C34 (índices): aplicada.
- C35 (caja del IPC): aplicada con los datos de V3-V5 (la subordinada de «diciembre del año anterior» está comprobada por el verificador en la metodología, p. 5, lo que resuelve la duda D4 de contenido). No se usa `INE2026IPCAvance`.
- C36 (caja del deflactor): aplicada con V6 (`UE2013SEC2010`, `INE2026CNA2025`) en lugar de `INEBaseMovil`, cuyo título no se pudo comprobar.
- C37 (conclusión): aplicada, fusionada con K17; la idea final responde a la pregunta del enganche (pensiones).
- C38, C39 (Roy y Shephard): aplicadas en un único anexo B (`anexo:envolvente`), con las dos demostraciones de cada resultado.
- C40 (ordenación): aplicada en el anexo D.
- C41 (Willig): aplicada en el anexo E.
- C42 (hessiana, Sarrus, CSO): aplicada, repartida entre el anexo A (CSO y Sarrus) y el C (hessiana, concavidad, cuasiconcavidad), como pide K21.
- C43-C45 (notas 1, 15, 16 y demás): aplicadas en la parte 1 (desaparecen con el recorte).
- C46 (bibliografía): aplicada; Rodríguez López en la caja de lecturas como material no publicado.
- C47 (preguntas vacías y enlace): aplicada.
- C48 (anexo de test): aplicada y ampliada.

**Coherencia (K1-K12 y transversales de esta parte)**
- K1, K2, K3: aplicadas. K4 (minutos y notas «En el cante»): aplicada en I y II.
- K5: aplicada en el texto; la figura `ingredientes-primal-dual` **no se pide**: la tabla `tab:ingredientes` cumple la misma función y la fila superior del esquema de dualidad ya dibuja los dos problemas (evita un gráfico redundante).
- K6, K7, K8, K9: aplicadas.
- K10, K11, K12: aplicadas (K11 con las ecuaciones de 3.A.8 para el LES, el AIDS y la Cobb-Douglas).
- K18 (remisiones) en esta parte: 3.A.8 (introducción, I.1, I.2.1, I.2.2, ejemplo Cobb-Douglas, II.1, II.2, II.3), 3.A.11 (Cobb-Douglas), 3.A.12 (nota del sentido amplio de «dual»), 3.A.33 (marco estático), y para ampliar 4.A.1, 4.B.6, 4.B.9 y 4.B.11 (relevancia, II.1 y usos).
- K19 (notación): aplicada en esta parte ($\overline W$ «renta», $U_i$, RMS positiva, $\min_x$, $\lambda^E$, $h(kp,\overline U)$, $S_{ij}$, $s_i$, $p_i$ en minúscula).
- K20: ecuaciones con `\label` y figuras con `\ref`.
- K22 (Walras e insaciabilidad local): aplicada. K23: Dupuit 1844 en la introducción y en III.3; Pareto y Samuelson (1947) desaparecen o se corrigen.
- K13-K16: aplicadas (K15 con la clasificación compacta y sin la tabla cruzada, por el criterio fijado; K16 con la tabla de ordenación en el anexo D).
- K17: aplicada. K18-K20: completadas en III y la conclusión (3.A.3, 3.A.16, 3.A.22, 3.A.24, 3.A.30, 4.A.1, 4.B.6, 4.B.9, 3.A.10, 3.A.29, 3.A.12). K21: aplicada, con un anexo E propio para Willig y el de test al final.

**Datos (V)**: aplicadas V1-V6, V9-V27, V30-V31, V33-V50 (comprobadas sin cambios o con las fechas corregidas), V52-V54, V55 (vídeo quitado), V56 (simulador), V58 (sin comillas), V60 (sin página), V63-V64. Rechazadas o sin usar: V7 (IPC frente al deflactor del consumo: el propio verificador advierte que no mide el sesgo, porque la cobertura es distinta); V8 (IPC de septiembre de 2026: solo hay indicador adelantado); V28 y V29 no proceden (la introducción ya no repite las notas 3 y 5 de 3.A.8); V59 y V62 quedan como dudas (páginas de MWG y datos de Maté y Pérez Domínguez).

## Coherencia

- **Reparto con 3.A.8**: el primal, los axiomas, la solución de esquina, la caja de teoremas y las demandas de la Cobb-Douglas se resumen con remisión; el dual, la función de gasto, Shephard, las identidades de dualidad y los sistemas de demanda se desarrollan aquí como tema de referencia. Las ecuaciones del LES, la Cobb-Douglas, el Rotterdam y el AIDS son las mismas que el anexo `anexo:sistemas` de 3.A.8, y la redacción de la EPF y de la singularidad de Barten coincide con la suya.
- **Canon**: se usa $\lambda^E$ para el multiplicador del dual (propuesta C3 de coherencia, pendiente de pasar a `notacion.md`); $\vartheta_i$ (QUAIDS), $b_i$, $c_{ij}$ (Rotterdam), $\gamma_{ij}$, $\beta_i$ (AIDS) y $\gamma_i$ (Stone-Geary) como letras locales (C4); $\varepsilon^h_{i,p_j}$ como en 3.A.8 (C2).
- **Anexo C (hessiana, concavidad y cuasiconcavidad)**: se propone como versión común para 3.A.8 y 3.A.12 (C5 de coherencia); 3.A.12 tiene hoy las mismas capturas en inglés.
- **Ficha `indices-precios` del canon**: su relación con la VC tiene el signo cambiado y presenta Laspeyres y Paasche como cotas del mismo índice; el tema usa la versión correcta (C6 de coherencia). **Ficha `ipc`**: dice base 2021; la vigente es la 2025. Estas dos, el $s_{ij}$ del anexo `der:matriz-slutsky` de 3.A.8 y la propuesta de $\lambda^E$ (a decidir) están anotadas en `canon/pendientes-coherencia.md`.
- **Formato**: las siglas VC, VE, ΔEC y EG van en redonda dentro de las fórmulas (`\mathrm{}`, `notacion.md` § 0); las ecuaciones de varias líneas son ecuaciones separadas y las filas de resumen de las tablas 2 y 4 son una línea bajo la tabla, para que salgan bien en HTML y Word.
- **Contradicciones con otros temas** (no se tocan; recogidas por el agente de coherencia, § 7 de `propuestas-coherencia.md`): 3.A.8 escribe $s_{ij}$ en su anexo `der:matriz-slutsky` (aquí $S_{ij}$); 3.A.11 debe recoger la historia de la Cobb-Douglas con las mismas cifras (3/4 y 1/4 en 1928; Douglas senador de 1949 a 1967).

## Dudas abiertas

Criterios aplicados mientras Víctor no diga otra cosa:
1. **Orden de los epígrafes** (D1): se mantiene el de Víctor (integrabilidad en III.1, después de los sistemas de demanda) y se justifica en la Estructura. La alternativa sería llevarla a I.3, lo que cambiaría los títulos de segundo nivel.
2. **Clasificación de los bienes** (D2): versión compacta en III.2 que remite a las tablas de 3.A.8 (parte 2).
3. **Multiplicador del dual** (D3): $\lambda^E$, con $\lambda^{E*}=1/\lambda^*$. Si se prefiere otra letra, hay que cambiarla también en el canon.
4. **Historia de la Cobb-Douglas** (D4): pasa a 3.A.11; aquí queda una línea en nota con \vertema{3.A.11} y las cifras coordinadas (3/4 y 1/4, estimación de 1928; Douglas senador hasta 1967).
5. **Translog**: solo la indirecta de Christensen, Jorgenson y Lau (1975). No se ha podido comprobar el signo de la directa del original («−ln u(x)»), que se quita.
6. **Rodríguez López (ICEX-CECO)**: pasa a lecturas complementarias (`anotaciones`) en la parte final; no es bibliografía citable.
7. **Opinión de la conclusión: BORRADOR para Víctor.** Está escrita en el `.tex` (la dualidad como teoría abstracta muy útil; límites del consumidor estático y de la agregación; la herencia de Deaton), pero es una propuesta del revisor: hay que leerla y cambiarla por la opinión propia. No se ha puesto ninguna marca en el documento para no publicar notas internas.
8. **IPC de septiembre de 2026** (V8): se omite porque el dato definitivo aún no está publicado.

Otras dudas de esta parte:
9. **Enganche**: se ha elegido la revalorización de las pensiones por el IPC (dato comprobado) en lugar de la nota de prensa del Nobel de 2015 (C4), que no se pudo verificar. La idea final de la conclusión debe responder a esta pregunta («¿basta la subida del IPC para que el pensionista quede igual?»).
10. **Imágenes de Maté y Pérez Domínguez (2007)**: se citan como base de la tabla de ingredientes y de los gráficos `primal-dual` y `esquema-dualidad`, pero la editorial y el año no se han podido comprobar en línea (V62). Conviene mirarlos en el ejemplar.
11. **Clasificación de los bienes**: se ha seguido la versión compacta con remisión a las tablas de 3.A.8. Si se prefiere que el 3.A.9 tenga también la tabla del precio cruzado (la ficha del tribunal pone la clasificación neta y bruta en este tema), basta copiar `tab:slutsky-cruzado` de 3.A.8.
12. **Idea final**: responde que la revalorización por el IPC tiende a sobrecompensar si la cesta del pensionista se parece a la del IPC (sesgo de sustitución), y que puede quedarse corta si su cesta es distinta. Es una afirmación cualitativa; no se cuantifica para los pensionistas españoles porque no hay un dato comprobado del sesgo del IPC en España.
13. **Páginas de MWG** (figura 3.D.5, ejemplo 3.I.1) y **Jehle y Reny (teorema 2.6)**: citadas por apartado o proposición, sin página, porque no se han podido comprobar en el ejemplar.
14. **Rodríguez López (2018) en «Lecturas complementarias»** (control de calidad, 13/10/2026): es material no publicado de un curso de preparación, y el lector de la web no puede consultarlo. Además, el verificador avisa de una cifra sin cita en esa línea. ¿Se mantiene, se quita o se cambia por una referencia pública?
15. **Símbolo $\lambda^E$** (control de calidad): el canon dice hoy «λ (λ_k si hay varios)» (D020), y $\lambda^E$ no está registrado en `canon/notacion.md` ni en `canon/informe-repaso.md` como propuesta [decidir]. Hasta que se decida, el tema se aparta del canon en este símbolo.
