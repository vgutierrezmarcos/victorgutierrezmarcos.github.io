# Revisión del tema 3.A.25 — La teoría neoclásica del mercado de trabajo. Análisis intertemporal de la oferta de trabajo. Teoría del capital humano. Función de ingresos de capital humano y evidencia empírica.

Fecha: 31/10/2026. Integración en tres partes: la 1 escribió el preámbulo, la introducción y el bloque I; la 2, los bloques II y III y la conclusión; la 3, los anexos A-F, la puesta al día de la bibliografía, los gráficos de los anexos, `seo.json` y este informe.

Fuentes de la integración: `_trabajo/original.md`, `pendientes.md` (P1-P69), `propuestas-contenido.md` (C1-C32), `propuestas-datos.md` (V1-V34) con `bib-datos.bib`, y `propuestas-coherencia.md` (K1-K43, DK1-DK9, D-P8, D-P10, D-P11, D-P33, D-P40, D-P64, estructura final y plan de pizarra). Víctor está fuera hasta el 9/11: en cada decisión se ha aplicado la opción recomendada, y las que debe confirmar están en «Dudas abiertas» (A25-01 a A25-12).

## Resumen

- Nueva fuente `3A25.tex` (**34 páginas de tema, 14 de anexos y 5 de bibliografía**). Estructura del original en 3 bloques: I. Teoría neoclásica de la oferta y la demanda de trabajo (I.1-I.4); II. Análisis intertemporal de la oferta: Lucas y Rapping (1969) (II.1-II.5); III. Teoría del capital humano y función de ingresos (III.1-III.3). Minutos: 2'30" + 10' + 6'30" + 10' + 1' = 30'.
- Hilo conductor: la tabla de 8 supuestos del modelo neoclásico (las 5 filas comunes del 3.A.16 y 3 propias del trabajo), con la columna de dónde se levanta cada uno; el enganche «El tiempo es oro» y la pregunta «¿cuánto vale una hora de nuestro tiempo?», que responde la idea final; pegatinas «hacer el agosto» (II) y «el saber no ocupa lugar» (III).
- Corregidos los errores de teoría del original (efectos de la oferta individual al revés, restricción y holgura de Kuhn-Tucker, condiciones de segundo orden de la demanda, unicidad y estabilidad, Marshall, Lucas-Rapping, Frisch y la neutralidad al riesgo, monopsonio con «paro involuntario» y GMg = oferta, Gardner, Becker 1962/1964, Acemoglu y Autor por Fisher…); rellenados los apartados vacíos (evidencia y valoración de la oferta, formación específica, función de ingresos) y añadida la evidencia de los Nobel de 2021 y 2023 repartida por bloques.
- Lo que no se canta pasa a 6 anexos: A (Kuhn-Tucker y Slutsky con dotación), B (demanda a largo plazo, de mercado y reglas de Marshall-Hicks), C (Lucas-Rapping con horizonte infinito), D (poder de mercado: monopsonio, salario mínimo y sindicato), E (Ben-Porath y la derivación de la ecuación de Mincer) y F (test y preguntas del tribunal).
- `3A25.bib` con 100 entradas; 21 gráficos pedidos en `_trabajo/graficos-pedidos.json` (2 copiados del 3.A.17, 1 de datos con la EES de 2022).

## Errores corregidos

| Dónde | Decía | Dice ahora |
|---|---|---|
| 1.1.2, condiciones de primer orden (l. 249, 265) (P44, K4) | Restricción «$= wO_0 + O$» | $C+wO=wO_0+\overline{W}$ (anexo A) |
| 1.1.2, holgura complementaria (l. 257) (P45, K4) | Primera condición «≥ 0» | $C\,(U_C-\lambda)=0$ y las 4 de holgura con igualdad, explicando por qué (anexo A) |
| 1.1.2, estática comparativa y l. 359-371 (P46, K3) | Con salarios bajos «los efectos renta prevalecen» y la oferta es creciente; con altos domina la sustitución y se vuelve hacia atrás | Al revés: con salarios bajos domina la sustitución (el efecto renta es proporcional a las horas) y con altos el renta (I.1 iii) |
| l. 385 (P47, V4) | «Ragnar Frisch halló empíricamente» un tramo inicial decreciente | Sin Frisch: la S invertida de Sharif (2000) y Dessing (2002); la de los subsidios, en nota, como hipótesis sin atribuir |
| l. 443, nota 13 (P48, V5) | «La elasticidad del margen extensivo es mayor que la del intensivo» | Chetty et al. (2011): 0,30 intensiva y 0,26 extensiva (hicksianas); el extensivo domina en las mujeres casadas |
| Demanda a corto plazo (l. 547, nota 16) (P49, K8) | CSO «estrictamente cóncava (rendimientos a escala decrecientes)»; «Kuhn-Tucker» sin restricciones | $pF_{LL}<0$, sin condición sobre los rendimientos; condición de primer orden simple |
| Demanda a largo plazo (l. 593) (P49) | «Estrictamente cuasicóncava (i.e. rendimientos decrecientes)» | Estrictamente cóncava; con $F(\vec 0)=0$ implica rendimientos decrecientes; nota 16 reescrita (cuasiconcavidad basta en la minimización del coste) (anexo B) |
| Equilibrio (l. 708) (P50, K2) | «Existencia, unicidad y estabilidad por trabajar con supuestos competitivos [ver tema 3.A.14]» | Existencia sí; unicidad y estabilidad no las garantiza la competencia (3.A.21); estabilidad walrasiana si la demanda corta a la oferta desde arriba |
| Marshall (l. 734) (P51, K9) | Oferta normal «con pendiente negativa» | Creciente, como en el 3.A.16 y De Vroey (2016) |
| Lucas-Rapping (P52a) | Transversalidad «$\lim B_t=0$» | No-Ponzi $\lim b_T/(1+r)^T\geq 0$, con igualdad en el óptimo (anexo C) |
| Lucas-Rapping (P52b) | $(1+r)/(1+\rho)$ sin β y $B_t$, $M_t$ | $\beta(1+r)$, $b_t$, $\overline{W}_t$ (anexo C) |
| Lucas-Rapping (P52c) | Aumento permanente: «la oferta en t aumenta en la misma proporción que en t+1» | Lo nulo es el cambio de la oferta **relativa**; el nivel depende del efecto riqueza (II.2 y anexo C) |
| Kydland y Prescott (P52d) | Choque permanente: «no se producirá ningún ciclo» | Apenas cambia la oferta relativa; se transmite por la inversión y la acumulación de capital |
| Nota 28 (P52e) | «La utilidad marginal es constante para las personas neutrales al riesgo» | La Frisch mantiene constante la utilidad marginal de la riqueza λ; nada que ver con el riesgo (nota en II.3) |
| Nota 29 (P52f, V10-V12) | Regularidades de la Frisch sin fuente | Keane (2011), Imai y Keane (2004), French (2005); la de las mujeres con hijos, como elasticidad estática (Blundell, Duncan y Meghir, 1998) |
| Usos del capital humano (l. 892) (P53a) | Becker: $h$ en la «función de utilidad» | En la función de producción |
| l. 894 y 1179 (P53b) | «Gardener» | Howard Gardner (1983) |
| Contextualización (P53c, K11) | Becker «(1962)» y «(1964)» mezclados | Artículo de 1962 y libro de 1964; Mincer (1958) también como pionero |
| Nota 32 (P53d) | «Arrepentimiento» de Spence | Quitado (sin fuente); nota sobre por qué Spence supone que la educación no aumenta la productividad |
| l. 1004 (P53e) | Oferta escalonada «según Becker» sin obra | Becker (1967), conferencia Woytinsky |
| Mincer (P54a, V21-V22) | «Retorno de entre el 5 % y el 8 %… entre el 1 % y el 20 %» | ≈ 9 % de media mundial, 8 % en renta alta (Psacharopoulos y Patrinos, 2018); superior ≈ 15 % (Montenegro y Patrinos, 2014) |
| Murillo Huertas et al. (P54b, V23) | 2016; «20,1 %, 12,4 % y 7,7 %» | 2017, datos de 2010, puntos logarítmicos (20, 12 y casi 8) |
| VI (P54c, V26) | «Francia 14 %, Estados Unidos 7,5 %» | Francia quitada (sin fuente); EE. UU., Angrist y Krueger (1991), 7-10 % |
| *Ability bias* (P54d, V25) | «No existe una relación unívoca entre escolarización y renta» | Sesgo de habilidad y error de medida, con Griliches (1977) |
| Notas 27 y 34 (P54e-f, K16) | En inglés | En castellano, citando a Cahuc et al. (2014) y Borjas (2020) |
| Anexo A.2 (P55a, K27) | «GMgF, i.e. la curva de oferta de trabajo» | El $\mathrm{GMg}_L$ queda por encima de la oferta; el salario lo da la oferta (anexo D) |
| Anexo A.2 (P55b) | «IMgF, i.e. la curva de demanda de trabajo» | Con monopsonio no hay curva de demanda (anexo D) |
| Anexo A.2 (P55c) | «Aumenta el salario para todas las unidades, por lo que la oferta de los trabajadores será mayor» | Contratar uno más obliga a subir el salario de todos: su coste supera su salario |
| Anexo A.2 y nota 36 (P55d, K14) | Monopsonio y monopolio «provocando paro involuntario» | En ninguno de los 4 casos hay paro involuntario; solo con sindicato o con salario mínimo por encima de $w^c$ (I.4 y anexo D) |
| Anexo A.2 (P55e, P56) | $W$, $\Pi$, IMgF, GMgF, $c(L)$ | $w_L(L)$, $\varepsilon_{L,w_L}$, $B$, $\mathrm{VPMg}_L$, $\mathrm{IPMg}_L$, $\mathrm{GMg}_L$, $U_S=wL-v(L)$, $\mathrm{IMg}_S$, $w^S$ (como el 3.A.17) |
| Anexo A.1, tabla (C24, P38) | Filas de «demandante neto» de ocio ($O^*>O_0$) y celdas con 2 signos | Sin filas imposibles ($O\leq O_0$ siempre); 4 filas (normal que trabaja, normal en el umbral, frontera, inferior) con colores |
| Nota 8 (P57) | Condiciones de Kuhn-Tucker del consumidor con $x$, $p$ | Las del problema de la oferta, con $\lambda$ y $\mu$ (anexo A) |
| P57 | «marhalliana»; Schultz y Becker como creadores sin Mincer | Corregidos |
| Introducción (P58, V1) | Paro del 11,6 % (2023 T2), tabla 4086 congelada | 10,18 % (3.er trimestre de 2026), tabla 65334 |
| Conclusión (P59) | Jubilación «como un problema de opciones reales» sin desarrollo; nota 35 «en los siguientes temas» | Valor de opción (Stock y Wise, 1990) en II.3; remisiones con `\vertema` |
| Nota 4 (Matthews) | Cita literal en inglés | Paráfrasis en castellano (la cita literal no se ha podido ver) |
| Contextualización | Keynes sin año, Lucas y Rapping «33 años después» | Correcto (1969 − 1936); se mantiene |
| Kleven et al. (parte 2) | «40 % en 1980 y 80 % en 2013» citado al artículo de *AEJ: Applied* | Comprobado en el resumen del DT 24219 del NBER (2018), que es el que da las cifras; el resumen del *AEJ* solo dice «un aumento drástico». Se cita el DT |
| Control de calidad: perfiles edad-ingresos (III) | «Las 2 curvas son crecientes y cóncavas» | Cóncavas: crecen deprisa al principio, cada vez más despacio, y pueden caer algo al final de la vida laboral (como en el gráfico) |
| Control de calidad: gráfico `ben-porath` (anexo E) | Extremo del eje rotulado $T$ | $S+T$ en los 2 paneles ($T$ son los años de vida laboral) |
| Control de calidad: nota de la prima por horas extraordinarias (I) | $L_n$ y $w_e$ sin definir | Definidos en el texto de la nota; gráfico de la nota a 0,35 del ancho y `efectos-salario` tras su ítem, para no dejar una página casi en blanco |

## Marcas resueltas

| Marca | Original | Qué se hizo |
|---|---|---|
| P1 (amarillo, 2 tramos) | «Añadir explicación de la Imagen 5 (ver Cahuc pág. 19)» y 6 capturas en inglés del Cahuc | Descomposición en 3 efectos redactada (E→E'→E''→E₁, renta compensada $\overline{W}^c=\overline{W}-(w_1-w)L_0$, efecto renta global) y un solo gráfico por capas `efectos-salario`; capturas quitadas |
| P2 (amarillo, 2 tramos) | «Imagen 7», «Fuente: Sahuquillo» | `demanda-corto` en TikZ; fuente Cahuc et al. (2014), cap. 3 |
| P3 (amarillo, 2 tramos) | «Imagen 10», «Fuente: Sahuquillo» | `demanda-agregada` en el anexo B (cuasidemandas, A→C y no A→B); fuente Cahuc et al. (2014) |
| P4 (amarillo, 2 tramos) | «Fuente: …» vacía; «Copiado del tema de Juan Luis» | `equilibrio-trabajo` por capas con el salario mínimo; texto redactado de nuevo; fuente Cahuc et al. (2014) |
| P5 (amarillo, 6 tramos) | Ley $\dot h=\theta\sigma h$, «se puede demostrar que…», «Copiando de Cahuc, pág. 202» | Modelo de Ben-Porath redactado de nuevo en el anexo E con $\dot h=a[1-u]h$: especialización, $S^*$, $\beta_1\approx r$ y la derivación del término cuadrático de Mincer; en III.2, la versión de 2 periodos y la de años de estudio |
| P6 (amarillo, 3 tramos) | «Imagen 18» (boceto del sindicato), «…», «Fuente: Elaboración propia» | `sindicato-monopolista` pedido con las funciones de `monopolio-bilateral.tex` del 3.A.17; fuente Dunlop (1944) y Cahuc et al. (2014) |
| P7 (amarillo) | Tabla vacía y salto de línea tras el título del apartado 1 | Borrados |
| P8 (nota al opositor) | Cambio de temario de 2023 y ficha del tribunal; «dar más peso a la evidencia de los Nobel de 2021 y 2023» | Desaparece; la evidencia de los Nobel se integra en cada bloque (Goldin en I.1 y III.3; Card y Krueger en I.4; Card (1990) en I.2; experimentos naturales en III.3). Estructura: duda A25-01 |
| P9 | Comentarios privados (opositor que cantó el tema y su nota; «el modelo de Becker está bien en el tema de Zapico»; documento con márgenes e introducción) | No se publican; tenidos en cuenta (márgenes intensivo y extensivo, brecha de género, *ability bias*) |
| P10 | «Meter en el cuerpo la competencia imperfecta… salario mínimo, tributación» | Resumen del monopsonio en I.4 (45″) y anexo D corregido; impuestos y oferta con remisión al 4.B.10 (duda A25-03) |
| P11 | Comentarios de reparto («10-10-10», «muy poco tiempo a la demanda… corto plazo», «Sahuquillo poco común», «Mincer más que Spence», «5 minutos» a Lucas-Rapping) | Reparto 10 / 6'30" / 10 (A25-06); solo el corto plazo de la demanda en el cuerpo; Lucas-Rapping con la presentación del canon; Spence en una viñeta y Mincer con 4'30" |
| P12 | «Ver Borjas, cap. 6»; «recomendación de Ángel» | Borjas (2020), cap. 6, consultado y citado (Fisher, perfiles, gemelos) |
| P13 | «Lo de aquí abajo copiado de Zapico»; «Basado en el Cahuc» | Formación general y específica redactada de nuevo desde Becker (1964); sin nombres |
| P14 | «Coordinar en temas 3.A.17 y 3.A.25 [Ver clase Juan Carlos 10…]» (×2) | Coordinación hecha con el 3.A.17 revisado (ficha `monopsonio`); las clases no están accesibles |
| P16a | Caja de agregación con $d\phi(\check M)$ | Caja gris con $F(\overline{W})$, $dF(\overline{W})$, $\overline{W}^R(w)$ e indivisibilidades |
| P16b | «Para profundizar ver Cahuc pág. 202» | Integrada en P5 (anexo E) |
| P16c | Caja de McConnell y Brue; «teorema de la separación de Acemoğlu y Autor» | Perfiles edad-ingresos en el cuerpo (`perfiles-edad`, imprescindible); caja de la separación de **Fisher** (1930), que Acemoglu y Autor aplican al capital humano; quitada la primera frase que no encajaba |
| P17-P38 | 18 imágenes del original | Todas pedidas en TikZ o pgfplots (ver `graficos-pedidos.json`); P23 (capturas) quitadas; P33 con gráfico de datos de la EES (A25-04) |
| P61 | Enlace a quia.com | Enlace único al simulador en el anexo F |
| P66, P67 | Nombres de opositores y preparadores, «Fuente: Sahuquillo/Zapico», capturas y marcas en el PDF publicado | Nada de ello se publica |

### Fuentes de preparadores sustituidas

| Dónde | Decía | Dice ahora |
|---|---|---|
| Imagen 7 (demanda a corto plazo) | Fuente: Sahuquillo | Cahuc, Carcillo y Zylberberg (2014), cap. 3 |
| Imagen 9 (corto y largo plazo) | Fuente: Sahuquillo | Cahuc et al. (2014), cap. 3 (anexo B) |
| Imagen 10 (demanda agregada) | Fuente: Sahuquillo | Cahuc et al. (2014), cap. 3 (anexo B) |
| Imagen 11 (equilibrio) | Vacía; texto «copiado del tema de Juan Luis» | Cahuc et al. (2014), cap. 3; texto nuevo |
| Imagen 13 (decisión de formación) | Fuente: Sahuquillo | Becker (1967) |
| Imagen 14 (decisión de inversión) | Fuente: Zapico | Fisher (1930) y Borjas (2020), cap. 6 |
| Formación específica | «Copiado de Zapico» | Becker (1964), redactado de nuevo |
| Ley de acumulación | «Copiando de Cahuc, pág. 202» | Ben-Porath (1967), Mincer (1974) y Cahuc et al. (2014), cap. 4, redactado de nuevo |

## Datos actualizados

| Dato | Valor anterior | Valor nuevo | Fuente | URL | Consulta | Segunda comprobación |
|---|---|---|---|---|---|---|
| Tasa de paro (V1, V2) | 11,6 % (2023 T2) | 10,18 % (2026 T3) | INE, EPA, nota del 3.er trimestre de 2026 | https://www.ine.es/dyngs/Prensa/EPA3T26.htm | 31/10/2026 | INE, tabla 65334: 10,18. Eurostat `une_rt_q`: 9,9 en 2026 T2 (coherente) |
| Definición de parado de la OIT (V3) | Sin fuente | Resolución I de la 19.ª CIET (2013), párr. 47 | OIT | https://www.ilo.org/sites/default/files/wcmsp5/groups/public/@dgreports/@stat/documents/normativeinstrument/wcms_234036.pdf | 31/10/2026 | Texto literal en la versión española |
| Elasticidades por margen (V5) | «Extensivo mayor» | 0,30 intensiva y 0,26 extensiva (hicksianas micro) | Chetty et al. (2011), *AER P&P*, cuadro 1 (artículo publicado; el DT w16729 da 0,3/0,25 en el resumen y 0,33/0,25-0,26 en el texto) | https://doi.org/10.1257/aer.101.3.471 | 31/10/2026 | Chetty et al. (2013), NBER Macro Annual |
| Segundos perceptores (V6) | González-Páramo, sin obra | 0,14 sin hijos, 0,21 (0-2 años), 0,37 (3-4 años) | Blundell, Duncan y Meghir (1998), cuadro IV | https://ideas.repec.org/a/ecm/emetrp/v66y1998i4p827-862.html | 31/10/2026 | Keane (2011) |
| Elasticidad de la demanda (V7) | ≈ 0,3 sin fuente | 0,15-0,75, valor central 0,3 | Hamermesh (1993) | https://press.princeton.edu/node/26337 | 31/10/2026 | Hamermesh (2004), cap. 11 (el intervalo, en citas secundarias) |
| Elasticidad de Frisch (V8) | «Reducida» | MaCurdy 0,15; Chetty et al. 0,54, 0,28 y 0,82 frente a 2,8 en los modelos de ciclo | MaCurdy (1981); Chetty et al. (2011) | https://doi.org/10.1257/aer.101.3.471 | 31/10/2026 | Keane (2011) |
| Nobel 1969, 1992, 2021, 2023 (V9, V16, V28) | Traducciones libres | Motivaciones oficiales | nobelprize.org | https://www.nobelprize.org/prizes/economic-sciences/ | 31/10/2026 | API oficial |
| Rendimiento de la educación (V21) | 5-8 %; 1-20 % | ≈ 9 % (8 % renta alta) | Psacharopoulos y Patrinos (2018) | https://documents1.worldbank.org/curated/en/442521523465644318/pdf/WPS8402.pdf | 31/10/2026 | Montenegro y Patrinos (2014): 10,1 % |
| Rendimiento por niveles (V22) | «Terciaria la más alta» sin fuente | ≈ 15 % la superior | Montenegro y Patrinos (2014) | https://documents1.worldbank.org/curated/en/830831468147839247/pdf/WPS7020.pdf | 31/10/2026 | Psacharopoulos y Patrinos (2018) |
| Brecha de Murillo et al. (V23) | 20,1/12,4/7,7 % (2016) | 20, 12 y casi 8 puntos logarítmicos (EES 2010; artículo de 2017) | *Social Indicators Research* 134(3) | https://doi.org/10.1007/s11205-016-1461-8 | 31/10/2026 | Postprint de la UB: 36-39 % sin explicar |
| Brecha salarial actual (V24) | — | 83,9 % (16,1 %) anual en 2024; 7,3 % por hora (UE 11,1 %) | INE, EAES 2024; Eurostat `earn_gr_gpgr2` | https://www.ine.es/dyngs/Prensa/EAES2024.htm | 31/10/2026 | Cálculo propio (16,07 %); Eurostat `sdg_05_20` |
| VI con trimestre de nacimiento (V26) | Francia 14 %, EE. UU. 7,5 % | EE. UU. 7-10 %; Francia quitada | Angrist y Krueger (1991) | https://www.nber.org/papers/w3572 | 31/10/2026 | Resumen del DT (cifras del DT, no del *QJE*) |
| Card (1995), gemelos (V27) | — | VI 25-60 % mayor que MCO; gemelos 12-16 % | Card (1995); Ashenfelter y Krueger (1994) | https://www.nber.org/papers/w4483 | 31/10/2026 | Card (2001) |
| Penalización por hijos (V29) | — | ≈ 20 % a largo plazo; 40 % (1980) y 80 % (2013) de la desigualdad | Kleven, Landais y Søgaard (2019) y DT 24219 (2018) | https://www.nber.org/papers/w24219 | 31/10/2026 | Resumen del *AEJ: Applied* (Crossref): 20 % y «aumento drástico» |
| Perfiles por edad y estudios (V30) | Gráfico estilizado | EES 2022: estudios superiores largos 34.596 € (25-34) y 51.491 € (≥ 55); 2.ª etapa de secundaria 19.315 € y 27.734 € (+86 % a partir de 55) | INE, EES 2022, tabla 36870 | https://www.ine.es/jaxiT3/Tabla.htm?t=36870 | 31/10/2026 | Tablas 36850 y 36847 coinciden |

Sin cambios, ahora con fuente: V9, V13, V14, V17 (Marshall, sin página), V18 (Becker, 1964), V20 (Heckman et al., 2006), V32 (URL de Becker, 1964). V31 (tabla 4086) y V33 (quia.com) sustituidos.

## Contenido añadido

- **Introducción** con los 5 bloques (C2, K40-K42): enganche con refrán y pregunta, relevancia micro, macro y de política, contextualización (Marshall, Hicks, Keynes, Mincer, Schultz, Becker, Lucas y Rapping, revolución de la credibilidad), problemática y estructura; esquema y nota con el reparto.
- **I**: tabla de 8 supuestos con dónde se levanta cada uno (K1, DK5); oferta a)-e) con el salario de reserva y su nota, los 3 efectos con la renta compensada, prima por horas extraordinarias (nota con gráfico), oferta individual corregida y la S invertida, agregación en caja, producción doméstica (Gronau) y modelos unitario y colectivo (Chiappori), evidencia (3 elasticidades, márgenes, U de Goldin) y valoración (C3-C9, K20-K21); demanda a corto plazo con su función clave y evidencia (Hamermesh, Card 1990, Borjas 2017) (C10, K22); equilibrio con propiedades positivas y normativas, salario mínimo en competencia y caja de Marshall (C11, K23-K24, DK7); valoración con el monopsonio y Card y Krueger (C12, K25-K26).
- **II**: presentación de referencia de dos periodos (ficha `lucas-rapping`, D068) con solución cerrada, gráfico y tabla de implicaciones; Frisch derivada con φ; ciclo vital y jubilación (Stock y Wise, Gruber y Wise); ciclos reales; trabajo indivisible (Hansen, Rogerson); costes de ajuste de la demanda; evidencia (MaCurdy, Altonji, Chetty, Imai y Keane, French, Fehr y Goette, Farber, Camerer) y valoración (C13-C16, K28-K33).
- **III**: usos del capital humano con los 5 enfoques de Acemoglu y Autor y las 2 cadenas Becker/Spence (C18, K34); Becker en 2 periodos y en años de estudio, gráfico de Becker (1967), caja de Fisher, perfiles edad-ingresos, formación general y específica con Acemoglu y Pischke (C19-C20, K35-K37); Mincer derivada (escolarización), Oaxaca-Blinder, brecha actual, Goldin y la penalización por hijos, habilidades no cognitivas, evidencia MCO y VI de los Nobel de 2021, España con la EES (C21-C22, K38-K39).
- **Conclusión** con sus 5 bloques (C23, K43).
- **Anexos** (parte 3): A, condiciones de Kuhn-Tucker completas y ecuación de Slutsky con dotación derivada con la función de gasto, tabla con colores (C24, K4); B, largo plazo en 2 etapas, Le Chatelier, descomposición sustitución-escala sin factores Giffen, cuasidemandas y reglas de Marshall-Hicks con la fórmula de Hicks-Allen (C10, K22, DK8); C, horizonte infinito con no-Ponzi, restricción intertemporal y el vínculo con la Frisch (C17); D, problema general con $\mathrm{IPMg}_L=\mathrm{GMg}_L$, los 4 casos en una frase, salario mínimo por tramos, sindicato monopolista de Dunlop y monopolio bilateral en 2 frases (C25, K27, DK4); E, Ben-Porath con hamiltoniano, especialización, $S^*=T+\frac{1}{r}\ln(1-r/a)$, $\beta_1=a\approx r$ y la derivación de $\beta_2=k_0(a+1/T)>0$ y $\beta_3=-ak_0/(2T)<0$, con la depreciación (P5); F, test, las 4 preguntas de otros exámenes con su respuesta y 7 preguntas probables (C27, C28).

### Estado de cada propuesta

- **Contenido**: C1 aplicada (estructura del original y reparto recomendado). C2-C12 aplicadas (C4 con las condiciones completas en el anexo A y no en el cuerpo, por K4; C10 sin la restricción $L\geq 0$ en el `\optim`, porque el problema es sin restricciones, y con las reglas de Marshall-Hicks en el anexo B en vez de en el cuerpo; C12 con el texto de K26). C13-C16 aplicadas. C17 aplicada en el anexo C (con $b_t$, no-Ponzi y $\beta(1+r)$; se añade la restricción intertemporal y el vínculo con λ). C18 aplicada. C19 aplicada **con cambios**: en el cuerpo, la versión de 2 periodos y la de años de estudio con $w(S)$ y $c$ (más fácil de cantar); la acumulación $\dot h$ pasa al anexo E con $a$ (no $B_h$, por coherencia y por el encargo); la pegatina es «el saber no ocupa lugar» (DK6) y no «quien tiene un oficio…». C20 aplicada. C21 aplicada con un cambio: Card (1995) con «un 25-60 % mayor que MCO» (V27) en lugar de «13 % frente a 7 %», que no se ha comprobado; la nota de Ben-Porath se desarrolla en el anexo E. C22-C27 aplicadas (C25 con la etiqueta `anexo:poder-mercado-trabajo` de coherencia). C28 aplicada con `\href` al simulador, como en los demás temas revisados, no con `\parencite{VGM2026Simulador}`. C29 aplicada con los nombres de coherencia (`oferta-trabajo`, `efectos-salario`, `prima-horas`, `demanda-corto`, `minimizacion-coste`, `demanda-lp-cp`, `perfiles-edad`, `becker-inversion`, `sindicato-monopolista`, `lr-oferta`); `curvas-indiferencia-ocio` se funde con `oferta-trabajo`. C30-C31 aplicadas. C32 aplicada salvo `AMECO2026WageShare`, `YehMacalusoHershbein2022Monopsony`, `DebEtAl2022Wage`, `BOE2026SMI` y `VGM2026Simulador`, que no se citan en el texto.
- **Datos**: V1-V3, V4 (con la hipótesis de los subsidios en nota, sin atribuir), V5, V6 (sin González-Páramo), V7-V12, V15-V30 aplicadas; V13, V14, V32 sin cambios; V31 y V33 sustituidas; V34 («Tema ICEX-CECO») **no aplicada**: se mantiene con `\nocite` por CRITERIOS § 2 (las lecturas de clases se citan como en el original) y por el encargo (A25-08).
- **Coherencia**: K1-K21 aplicadas. K22 aplicada sin Lichter, Peichl y Siegloch (2015), que pedía comprobación y no se ha comprobado. K23-K43 aplicadas. DK1-DK9 y D-P8, D-P10, D-P11, D-P33, D-P40, D-P64 aplicadas con la recomendada (dudas A25-01 a A25-07).

## Coherencia

- **Notación** (canon `notacion.md` y fichas): $\overline{W}$ renta no laboral (nunca $M$); $w$ salario real con $P_C=1$; $w^R$ salario de reserva; $O(w,\overline{W})$, $h_O(w,\overline{U})$ con nota (la $h$ sin subíndice es el capital humano), $L(w,\overline{W})=O_0-O$; $\overline{W}^R(w)$ y $F(\overline{W})$ en la agregación; $\varepsilon_{L,w}$, $\varepsilon^h_{L,w}$, $\varepsilon^F_{L,w}=1/\varphi$; empresa con $p$, $w_L$, $w_K$, $B$, $w\equiv w_L/p$, $\mathrm{VPMg}_L$, $\mathrm{IPMg}_L$, $\mathrm{GMg}_L$; $w^c$, $L^c$, $w^M$, $L^M$, $\underline{w}$; $U_S=wL-v(L)$, $w^D(L)$, $\mathrm{IMg}_S$, $w^S$ como el 3.A.17; Lucas-Rapping con $L_t$, $1-L_t$, $\beta=1/(1+\rho)$, $b$ peso del ocio (en el cuerpo) y $b_t$ activos (en el anexo C, donde no aparece el peso), $\chi$ y φ; capital humano $h$, $c(h)$, $w(h)$, $\dot h=a[1-u]h$; Mincer con $S$, $X$, $\varepsilon_i$; Oaxaca-Blinder con grupos A y B y $\hat{\vect{\beta}}$.
- **Lo que prometen los temas revisados** (coherencia § 3.1): cumplido. 3.A.8 (producción doméstica de Gronau con nota de que $O_0$ es la $T$ de Becker, 1965), 3.A.12 (demanda no condicionada por Hotelling y sin factores Giffen), 3.A.13 (Spence en una viñeta), 3.A.16 (oferta normal creciente de Marshall), 3.A.17 (salario mínimo en competencia en I.3 y «al revés que en competencia» en I.4), 1D01 (margen extensivo).
- **3.A.17**: gráficos `monopsonio` y `salario-minimo` copiados sin cambios; `eq:monopsonio` con la misma etiqueta; la tabla de los 4 casos no se repite (ficha); `sindicato-monopolista` y `monopsonio-monopolio` se piden con las mismas funciones que `monopsonio.tex` y `monopolio-bilateral.tex`.
- **Contradicciones con otros temas** (no se tocan; para `canon/pendientes-coherencia.md`):
  - **3.A.29** (sin revisar): «teorema de la separación de Acemoğlu y Autor» en la decisión de capital humano: es el de Fisher (1930); debe remitir al 3.A.25 para la teoría de Becker.
  - **3.A.26 y 3.A.27** (sin revisar): salario de reserva $w_R$ → $w^R$. El 3.A.27 escribe el sindicato con $c(L)$ y $W(L)$: debe usar $U_S=wL-v(L)$, $w^D(L)$, $\mathrm{IMg}_S$ y $w^S$, como el anexo D y el 3.A.17.
  - **3.A.26, 3.A.27 y 3.A.28**: repiten la contextualización de Marshall, Hicks y Keynes; el 3.A.26 dice que el equilibrio neoclásico es «único, estable y de pleno empleo» (solo «sin paro involuntario»: la competencia no da unicidad ni estabilidad, 3.A.21). El 3.A.28 debe resumir el enfoque neoclásico con la misma tabla de supuestos.
  - **3.A.6 y 3.A.42** (sin revisar): desarrollan Lucas-Rapping con $\varepsilon_{(L^S,w)}$; deben resumir y remitir, con $\varepsilon_{L,w}$ y φ.
  - **4.B.10** (sin revisar): «[ver tema 3.A.18]» → 3.A.25; renta no laboral $M$ → $\overline{W}$; el gráfico de referencia de la oferta es el de este tema.
  - **3.B.2** (sin revisar): pide coordinar el capital humano general pagado por la empresa: está en III.2 (Becker y Acemoglu-Pischke); el 3.B.2 debe remitir.
  - **3.A.8** (revisado): sin contradicción; usa $T$ y $t_w$ (Becker, 1965) donde aquí van $O_0$ y $L$ (nota en I.1).
- **Cambios al canon pendientes** (para `tema-canon`, detalle en `propuestas-coherencia.md` § 7):
  - fichas nuevas con el 3.A.25 de referencia: `becker-capital-humano`, `demanda-trabajo`, `mincer`, `oaxaca-blinder`;
  - `notacion.md` § 6: $w^R$; $L(w,\overline{W})$, $O(w,\overline{W})$, $h_O(w,\overline{U})$; $\overline{W}^R(w)$, $F(\overline{W})$; $\varepsilon_{L,w}$, $\varepsilon^h_{L,w}$, $\varepsilon^F_{L,w}=1/\varphi$; $p$, $w_L$, $w_K$, $w\equiv w_L/p$; $C_{\mathrm{mer}}$, $L_{\mathrm{dom}}$; § 7: $c(h)$, $w(h)$, $\dot h=a[1-u]h$ con $a$ local, $S$, $X$, $\varepsilon_i$, grupos A y B de Oaxaca-Blinder; locales del anexo E: $\omega$ (salario por unidad de capital humano), $k(X)$, $E(X)$, δ;
  - fichas `oferta-trabajo` (gráfico por capas, renta compensada, $w^R$), `lucas-rapping` (Frisch con χ y φ; horizonte infinito en el anexo C), `monopsonio` (fila del 3.A.25: «resumen, hecho»), `slutsky` y `fisher-intertemporal` (añadir el 3.A.25), `uzawa-lucas` (mención en el anexo E);
  - `mapa.yaml`: referencias y `faltan` de coherencia § 6;
  - choque de letras: $L^S$ es en el 3.A.17 (y en el anexo D) el empleo que fija el sindicato, y en `notacion.md` § 6 la oferta $L^S(w)$ (A25-10).

## Dudas abiertas

Víctor está fuera hasta el 9/11: en todas se ha aplicado la recomendada.

- **A25-01. Estructura de bloques frente a la ficha del tribunal** (P8, C1, D-P8). La nota al opositor del original recoge la ficha: I. Modelo neoclásico (estático y Lucas-Rapping), II. Capital humano (Becker y Mincer), III. Economía empírica (regularidades y experimentos naturales). Opciones: (a) la estructura del original, I neoclásico / II intertemporal / III capital humano y Mincer, con la evidencia de los Nobel repartida en cada bloque; (b) la de la ficha, fundiendo I y II y abriendo un III de evidencia. **Recomendada y aplicada: (a)** (CRITERIOS § 2 y tu nota: «integrándola en la parte del tema en que cuadre, sin un apartado propio»).
- **A25-02. Lucas-Rapping en 2 periodos con el horizonte infinito en anexo** (P40, C13, D-P40). Opciones: (a) dos periodos en el cuerpo (presentación de referencia del canon, con solución cerrada y gráfico) y el modelo infinito del original, corregido, en el anexo C; (b) el infinito en el cuerpo y los 2 periodos como intuición. **Recomendada y aplicada: (a)**: cabe en la pizarra y es la de la ficha `lucas-rapping`.
- **A25-03. Monopsonio en I.4 y anexo D** (P10, C12, D-P10, DK4). Opciones: (a) resumen en I.4 (fórmula, sin paro involuntario, salario mínimo que sube el empleo, Card y Krueger; 45″ de cante) y el anexo A.2 corregido en el anexo D, con los 4 casos en una frase; (b) solo en el anexo con una mención en la conclusión; (c) bloque completo en el cuerpo con la tabla de los 4 casos. **Recomendada y aplicada: (a)**: cumple la ficha y la promesa del 3.A.17 sin quitar tiempo a II y III.
- **A25-04. Gráfico de la Encuesta de Estructura Salarial** (P33, D-P33). Opciones: (a) pgfplots con la ganancia media por edad y estudios de la EES de 2022 (`ees-edad-estudios`), de profundización, y en el cante solo la cifra; (b) solo el perfil estilizado. **Recomendada y aplicada: (a)**. La EES es cuatrienal: habrá que actualizarlo con la de 2026 (previsiblemente publicada en 2028).
- **A25-05. Enganche «El tiempo es oro»** (K40, DK6). Opciones: (a) «El tiempo es oro» con la pregunta «¿cuánto vale una hora de nuestro tiempo?» y el Nobel de Goldin, pegatinas «hacer el agosto» (II) y «el saber no ocupa lugar» (III), idea final que retoma el refrán; (b) «El saber no ocupa lugar» como enganche. **Recomendada y aplicada: (a)**: abarca los 3 bloques. Ningún otro tema revisado usa estos refranes.
- **A25-06. Reparto de minutos** (P11, D-P11). Opciones: (a) 2'30" / 10' / 6'30" / 10' / 1'; (b) 2'30" / 10' / 6' / 10' / 1'30"; (c) 2' / 10' / 5' / 11' / 1' (tu comentario de los «5 minutos» para Lucas-Rapping). **Recomendada y aplicada: (a)**: el 3.A.25 es el tema de referencia de Lucas-Rapping.
- **A25-07. Títulos nuevos y notación** (DK1, DK2, D-P64). Se añaden II.4 «Evidencia empírica» y II.5 «Valoración» (como 1.1.4 y 1.1.5 del original), III.3 se titula «Función de ingresos de capital humano: la ecuación de Mincer» (recoge el epígrafe del título) y la empresa usa $p$, $w_L$, $w_K$, $B$ con $w\equiv w_L/p$ (como 3.A.12 y 3.A.17), no $W$ y $\Pi$. **Aplicado**; alternativa: un solo II.4 «Evidencia y valoración», el título «Ecuación de Mincer (1974)» y $W$ nominal.
- **A25-08. «Tema ICEX-CECO» en la bibliografía**. Datos propuso quitarla (V34, sin enlace); contenido y CRITERIOS § 2 dicen citarla como en el original. **Aplicado: se mantiene** con `\nocite{ICEXCECO3A25}`. ¿Quieres un título más preciso?
- **A25-09. Edición de McConnell y Brue**. El original cita «McConnell y Brue (1997)». Se ha puesto *Economía laboral*, 4.ª ed., Madrid, McGraw-Hill, 1997 (la traducción habitual), y se ha quitado la nota interna del `.bib`. Solo se ha podido cotejar a medias: Open Library da una edición española de McGraw-Hill con ISBN 84-481-0790-X, fechada en 1999 (puede ser una reimpresión). ¿Es la que tienes? ¿Qué páginas del capítulo de capital humano?
- **A25-10. $L^S$ para el empleo del sindicato**. En el anexo D se usa, como en el 3.A.17, $L^S$ para el empleo que fija el sindicato, y el texto lo aclara; pero en este tema $L^S(w)$ es también la oferta. Opciones: (a) mantenerlo (aplicado; la oferta se escribe $w_L(L)$ en el anexo); (b) cambiarlo en los 2 temas (p. ej., $L^{\mathrm{sind}}$) y en `monopolio-bilateral.tex`.
- **A25-11. González-Páramo (nota 14)**. No se ha encontrado el trabajo que dice que los perceptores secundarios comparan el salario con el coste de contratar empleados del hogar; se ha sustituido por Keane (2011) y Blundell, Duncan y Meghir (1998). Si tienes la referencia, se puede recuperar.
- **A25-12. Materia en `seo.json`**: «Economía laboral» (la asignatura en la que se estudia el tema) en lugar de «Microeconomía». ¿De acuerdo?
- **R25-01. Título corto en la ficha de repaso** (entrega 2). Con el título corto del tema, «Mercado de trabajo neoclásico y capital humano», el pie izquierdo de la ficha se montaba sobre el derecho (el pie de los materiales exclusivos es largo). Opciones: (a) en la ficha, «Mercado de trabajo y capital humano»; (b) acortar también el del tema (`\tcetema[…]` de `3A25.tex`) para que coincidan; (c) dejar el largo y acortar el pie en `tcee-repaso.sty` (afecta a todas las fichas). **Recomendada y aplicada: (a)**; el tema no se toca.

**No verificado** (se dice en el texto lo justo y se cita la obra):

- Sharif (2000) y Dessing (2002): solo metadatos (Crossref) y fuentes secundarias para la S invertida; no se ha leído el texto completo.
- Marshall (1890): cita «el capital más valioso de todos es el que se ha invertido en seres humanos» sin página (libro VI, cap. IV según fuentes secundarias).
- Matthews (1990): capítulo comprobado en el índice del libro; la cita literal de la nota 4 no se ha visto (se parafrasea).
- Heckman, Stixrud y Urzua (2006) y Heckman, Lochner y Todd (2006): solo metadatos; las frases recogen la tesis conocida de cada uno, sin cifras.
- Blau y Kahn (1992): título comprobado; páginas de *AER P&P* 82(2), 533-538 de memoria.
- Altonji (1986): solo metadatos. Imai y Keane (2004) y French (2005): sus resultados se citan a través de Keane (2011). Angrist y Krueger (1991): cifras del DT de 1990, no del *QJE*. Hamermesh (1993): el intervalo 0,15-0,75, de citas secundarias.
- McConnell y Brue (1997): edición (A25-09).
- Las clases citadas en los comentarios (P14) no están accesibles.

## Instrucciones para el vídeo

- **Enganche e idea final**: tras leer el título, «El tiempo es oro» y la pregunta «¿cuánto vale una hora de nuestro tiempo?», con el Nobel de Goldin (2023). La idea final la responde: lo que se paga por ella en el margen, el salario, que no es el mismo hoy que mañana y depende de lo invertido en uno mismo. Introducción y conclusión sin pizarra.
- **Pizarra en 3 zonas fijas** todo el cante:
  - *izquierda*: los 8 supuestos (número y una palabra), escritos al empezar I; se marca el que se levanta en cada bloque (el 6 en I.3, el 4 en I.4, el 3 en III.1 y el 2 con Spence, el 7 con la formación específica);
  - *centro*: los gráficos, que se borran al acabar cada bloque;
  - *derecha*: las funciones clave, que se **conservan** (`conservar:`) hasta el final: la tangencia y el salario de reserva (`eq:oferta-tangencia`, `eq:salario-reserva`), `eq:demanda-corto`, `eq:lr-condicion` y `eq:mincer`; debajo, las pegatinas «hacer el agosto» y «el saber no ocupa lugar».
- **I.1**: `oferta-trabajo` y, sobre el **mismo** gráfico por capas, `efectos-salario` (E→E'→E''→E₁; imprescindible, nunca 2 gráficos); al lado, pequeño, `oferta-individual` (imprescindible). `renta-no-laboral`, `prima-horas` y la caja de agregación, como apoyo o fuera.
- **I.2-I.3, gráfico conjunto por partes**: la demanda de `demanda-corto` es la primera capa de `equilibrio-trabajo`; en I.3 se añaden la oferta, $(w^c,L^c)$ y el salario mínimo con el paro involuntario (imprescindible). `marshall-trabajo`, solo apoyo.
- **I.4**: `eq:monopsonio` escrita sin recuadro; los gráficos `monopsonio` y `salario-minimo`, como apoyo (no se dibujan).
- **II**: el problema `eq:lr-problema` en el centro y la condición `eq:lr-condicion` a la derecha (función clave); las 4 implicaciones como cuadro de flechas (la tabla `tab:lr-implicaciones`); `eq:frisch` en II.3. `lr-oferta`, solo apoyo.
- **III** (instrucciones de la parte 2):
  - pizarra: las 2 cadenas causales de Becker y Spence (III.1), `eq:becker-inversion` con la pegatina «el saber no ocupa lugar» (III.2), `perfiles-edad` **por capas, imprescindible** (costes directos, coste de oportunidad, rendimiento bruto), `eq:mincer` (función clave) y `eq:oaxaca` en una línea (III.3);
  - sin pizarra (apoyo): `becker-inversion`, `fisher-capital-humano` y `ees-edad-estudios` (en el cante basta la cifra del 86 %).
- **Anexos**: nada se canta; sus gráficos (`minimizacion-coste`, `demanda-lp-cp`, `demanda-agregada`, `monopsonio-monopolio`, `sindicato-monopolista`, `ben-porath`) no salen en el vídeo. Ben-Porath, en una frase en III.3.
- No decir números de temas en voz alta; al final la pizarra queda con las 4 funciones clave y la lista de supuestos marcada.
