# Revisión del tema 3.A.34

*Teorías de la inversión en bienes de equipo. Incertidumbre e irreversibilidad de la inversión. Implicaciones de política económica.*

Revisión autónoma del 31/10/2026 (Víctor fuera hasta el 9/11): en cada duda se aplica la opción recomendada y se anota aquí. El editor ha trabajado en 2 partes: **parte 1** (introducción, I y II, bibliografía y pedido de gráficos) y **parte 2** (III, conclusión y anexos). Las 2 partes están ya recogidas en cada sección.

## 1. Resumen

- Fuente nueva en LaTeX (`3A34.tex`) con la estructura del original y los títulos de primer nivel de coherencia (DK11): I. Antecedentes: de Keynes al modelo neoclásico (7′); II. Costes de ajuste: el modelo de la q (9′30″); III. Extensiones: incertidumbre, irreversibilidad y financiación de la inversión (10′); introducción 2′30″ y conclusión 1′.
- Introducción reescrita con sus 5 bloques (el bloque «Estructura» estaba vacío), refrán en el enganche y datos de la Contabilidad Nacional y del índice de incertidumbre de política económica; el falso «los bienes de equipo son más de 2/3 de la inversión» se sustituye por la composición real de la FBCF (gráfico de datos nuevo).
- I y II: notación del canon (b, EMgK, c_K, Φ, B(K), 𝓗 en valor corriente), errores de fórmulas corregidos (Σβ_j = 1, multiplicador con acelerador, −qδ en el coestado), evidencia y valoración de la q completadas (estaban vacías) y 12 gráficos pedidos en TikZ (las imágenes 8 y 9 del original eran la misma).
- III y anexos (parte 2): costes asimétricos y fijos con la banda de inacción en q (misma tabla que el 3.A.26), incertidumbre con costes simétricos (Hartman-Abel, Caballero), la opción de esperar con el ejemplo de 2 periodos de Pindyck, el umbral V* y la evidencia de la incertidumbre de política (Bloom; Baker, Bloom y Davis; España), mercados financieros (Modigliani-Miller, Myers-Majluf, Fazzari-Hubbard-Petersen frente a Kaplan-Zingales, acelerador financiero) y una síntesis de las implicaciones con tabla. El III pasa de unas 500 palabras con huecos a ser el bloque más largo. Conclusión con sus 5 bloques y 5 anexos (control óptimo común, Jorgenson, q y Hayashi, V* en tiempo continuo, test).
- Bibliografía: 87 entradas (las del original, las de contenido y las de datos, con claves unificadas); fuera «Tema Juan Luis Cordero Tarifa».

## 2. Errores corregidos

| Dónde | Decía | Dice ahora |
|---|---|---|
| Cabecera del PDF | «Teorías de la demanda de inversión…» (título anterior) | Título oficial en `\tcetema` |
| Introducción | Inversión = bienes de equipo + construcción + variación de existencias; bienes de equipo «más de 2/3 del total» | Formación bruta de capital = FBCF + existencias + objetos valiosos (SEC 2010); FBCF por activos con la propiedad intelectual; maquinaria y bienes de equipo = 26,8 % de la FBCF en 2025; lo que supera los 2/3 es la inversión no residencial (71,9 %) |
| Introducción, Contextualización | Ricardo: «la demanda de inversión es motor de crecimiento»; Marx: «pauperización» | Para los clásicos la inversión no es un problema de demanda (ley de Say); Ricardo, rendimientos decrecientes y estado estacionario; Marx, la acumulación como motor y origen de las crisis (con remisión al 3.A.2) |
| I.1 Keynes | I = I₀ − v·r con «tipo de interés real»; δ para la eficiencia marginal | I = Ī − b·i (D009); EMgK en redonda (DK6); tipo de interés monetario, que con precios rígidos coincide con el real |
| I.1, nota 1 | «Keynes toma el concepto de Fisher» | Keynes dice que la «tasa de rendimiento sobre el coste» de Fisher es **idéntica** a su EMgK (cap. 11, apdo. II) |
| I.1, implicaciones y nota 2 | «Ni la política fiscal ni la monetaria son efectivas para afectar a la inversión» | La monetaria es poco eficaz sobre la inversión privada (2 eslabones débiles); la fiscal es eficaz sobre la renta y Keynes pide la inversión pública y «una socialización bastante completa de la inversión» (cap. 24) |
| I.1 | «Keynes enfatiza que el mensaje central de la Teoría General es la incertidumbre» (sin fuente) | Citado a Keynes (1937), *QJE*, su respuesta a los críticos |
| I.2 | Multiplicador ∂Y/∂G = 1/(1 − c − v) sin más | Es solo el de impacto y exige c + v < 1; a largo plazo 1/(1 − c); dinámica de Samuelson (1939) en nota con remisión al 3.A.42 |
| I.2, acelerador flexible | Σβ_j = 0 | Σβ_j = 1 (pesos de una media); equivalencia con el ajuste parcial de Koyck (1954) y Chenery (1952) |
| I.4 Jorgenson | Objetivo nominal descontado con el tipo «real»; transversalidad como restricción | Nivel general de precios constante (r nominal = real); la transversalidad es condición de optimalidad y la restricción es K₀ dado |
| I.4, nota 4 | Condiciones de Inada con «lim F = ∞» | Solo las 2 de Inada sobre F_K (y F_L) más la esencialidad |
| I.4 | Faltaba cómo se cierra el modelo | Con rendimientos constantes solo se fija K/L; Jorgenson toma la producción dada: K* = αPY/c_K |
| II, título e idea | «Este modelo fue utilizado por primera vez por Tobin (1969)»; «1980s» | Tobin (1969) define la q sin costes de ajuste; los costes son de Eisner y Strotz (1963), Lucas (1967), Gould (1968) y Treadway (1969); el modelo, de Summers (1981), Abel (1982) y Hayashi (1982) |
| II, supuestos | C(κ̇) = c(κ_t − κ_{t−1})² (mezcla tiempo discreto y continuo; C es el consumo) | Φ(I) convexo con Φ(0) = Φ′(0) = 0 (D130); ejemplo (φ/2)I² |
| II, desarrollo | π(K) a la vez «ingreso marginal» y «beneficio por unidad de capital» | B(K), beneficio por unidad de capital (DK4), que para la empresa es también su beneficio marginal |
| II, CPO | −q_t·δ en la ecuación de coestado aunque δ = 0; nota 20 con (r + δ) | Sin depreciación en el cuerpo (como Romer); la versión con δ en nota y en el anexo C |
| II, segunda condición | «la empresa invierte hasta que…» | Es una condición de arbitraje (cuánto vale el capital), con su solución hacia delante |
| II, numeración | Listas «1., 6.», «i., iii), iv)» | Listas limpias |
| II, q media | Condiciones de Hayashi: «homogeneidad, bienes de capital idénticos, mercados financieros eficientes» | Precio-aceptante y producción y coste de ajuste homogéneos de grado 1, Φ(I,κ) = κφ(I/κ); los mercados eficientes son para **medir** la q media en bolsa; con el Φ(I) de Romer no coinciden exactamente |
| II, implicaciones | Imágenes 8 y 9 iguales (las 2 eran la del aumento temporal) | 2 gráficos distintos pedidos |
| II, desgravación permanente | «q disminuye… se reduce la q crítica» (confuso) | K̇ = 0 baja a q = 1 − θ; q cae, pero menos que el umbral: por eso se invierte |
| II, nota 21 | A medias | Completa: el lugar q̇ = 0 sube y gira |
| II, evidencia | Summers «…»; Cummins, Hassett y Hubbard «…» (inacabadas) | Completas con las cifras comprobadas (0,03 y 65 %; 0,5 y 4 %) |
| Pies de los gráficos | «Romer (2018)» | Romer (2019), 5.ª ed., una sola clave |
| III.1 (imagen 14) | Imagen sin título con «Fuente: Romer»: no era la de los costes asimétricos (es una figura de Romer con E′, A y B); «el sendero de silla se curva más» sin explicar | Sustituida por la función de inversión con banda de inacción, I(q), derivada en el texto (`fig:inversion-banda`) |
| III.2-III.3 | «Este enfoque tiene sus orígenes en Abel y Bernanke» | Abel (1983), como Hartman (1972), muestra lo contrario (la incertidumbre puede aumentar la inversión con costes convexos); la opción de esperar es de Bernanke (1983), McDonald y Siegel (1986), Pindyck (1991) y Dixit y Pindyck (1994); Abel y Eberly (1994) los unen |
| III.3, desarrollo | «se invertirá hasta que la productividad marginal sea igual al coste de uso más el valor de mantener viva la opción» (sin modelo) | Modelo de 2 periodos con la regla \eqref{eq:opcion-esperar}, el principio de las malas noticias y el umbral V* = β₁/(β₁−1)·I |
| III.3, implicaciones | «evitar grandes desigualdades en la distribución de la renta (fuente de tensión social…, como vemos en la actualidad)» | Quitado: sin fuente y ajeno al modelo; queda la estabilidad en sentido amplio (precios, tipos, reglas fiscales, seguridad jurídica, derechos de propiedad) |
| Anexo, principio del máximo | «y_T = Z → condición de transversalidad» | Es una condición terminal; la transversalidad aparece con y_T libre (λ_T = 0) o con horizonte infinito |
| Anexo, horizonte infinito | «lim 𝓗^c e^{−ρt} = 0» como transversalidad | Es la condición de un momento final libre; la de este problema es lim e^{−ρt}λ_t y_t = 0 (nota) |
| Anexo | «Pontryagin (1956)» | Anunciado en 1956 por Boltianski, Gamkrelidze y Pontriaguin; libro de Pontryagin *et al.* (1962) |
| Anexo, suficiencia | Solo Arrow | Añadido Mangasarian (más fácil de comprobar) |
| Conclusión | Recapitulación larga que repetía el cuerpo; Relevancia, Extensiones y Opinión vacías | Reescrita con sus 5 bloques; empieza por «En conclusión,» |

## 3. Marcas resueltas

| Marca | Qué decía | Qué se hizo |
|---|---|---|
| P1, amarillo | «Fuente: Sahuquillo» (imagen 1) | Sahuquillo no es un manual localizable (apuntes de un preparador): gráfico rehecho, «elaboración propia a partir de Keynes (1936, cap. 11)» |
| P2, amarillo | «Fuente: Sahuquillo» (imagen 2, escaneo) | Rehecho con valores ilustrativos: «elaboración propia a partir de Koyck (1954) y Chenery (1952)» |
| P4-P6, notas al opositor | Aviso del cambio de temario y «requiere modificaciones» (Romer, págs. 444-453); ficha del tribunal | Desaparecen; lo que piden es el III (parte 2). La ficha pedía mercados financieros: III.4 |
| P8, comentario | «faltaría por desarrollar mejor el apartado 3» | No se publica; III completo en la parte 2 |
| P9, comentario | IS-LM: «comodín, casi igual mejor no decir nada» | I.3 queda como 3 viñetas-puente (30″), con remisión al 3.A.5 |
| P10, P11, comentarios | Nombre de un preparador y de una clase | No se publican; la interpretación de la q se redacta de nuevo (solución hacia delante y q marginal/media) |
| P14, cajas | 2 vídeos de YouTube; «ver Romer págs. 441-443»; *The Economist* en incertidumbre | Vídeos comprobados (canal *Understand Economics @Berkeley*), en `anotaciones` de II.1; Romer en `anotaciones` de II.3 con las páginas comprobadas (441-444); *The Economist* pasa a II.3 (trata de competencia e inversión, no de incertidumbre), con Gutiérrez y Philippon (2017) |
| P15, nota 14 | «No es necesario cantar la derivación» | Las derivaciones van a los anexos B y C (parte 2) y fuera del guion |
| P39, P42 | Nota 7 («collage» de otros apuntes); «Tema Juan Luis Cordero Tarifa» en la bibliografía | Nota neutra (no mezclar ecuaciones y gráficos de presentaciones distintas); fuera de la bibliografía |
| P3, amarillo (anexo) | «Pasamos a repasar… por ser el más útil en la oposición» | Reescrito sin subrayado: por qué el control óptimo (tiempo continuo, restricciones sobre los controles, lectura económica del coestado) |
| P7, notas al opositor del anexo | Manuales de optimización dinámica | Caja `anotaciones` «Para profundizar» con las referencias completas (Perman *et al.*, 4.ª ed., apéndice 14.1, comprobado por el verificador) |
| P12, comentario | «buscar Smets-Wouters o Christiano, Eichenbaum y Evans» | Conclusión, Extensiones: costes de ajuste de la inversión S(I_t/I_{t−1}) y la respuesta en joroba |
| P13, comentario | Coordinar el anexo con 3.A.29, 3.A.33, 3.A.43 | Anexo A redactado como pieza común en tiempo continuo (DK9), con una nota que lo dice; la ficha `optimizacion-dinamica` la crea tema-canon |
| P14 (*The Economist*) | Caja en incertidumbre | Movida a II.3 |
| P41 | Enlace a quia.com | Anexo E con el enlace genérico al simulador en caja `anotaciones` |
| Notas al pie | 24 en el original | Se mantienen las bien desarrolladas (1, 2 condensada, 4 corregida, 6 ampliada con Hall y Jorgenson, 8, 9, 12, 20 y 21); la 3 (Fisher, una línea genérica), la 10 (integrada en el texto), la 15 (función inversa, reducida a una aclaración en el texto) y la 16 (integrada) se quitan; la 17-18 pasan a II.3; la 5 y la 13 pasan al anexo A (principio del máximo); la 22 (varias variables) y la 23 (hamiltoniano maximizado) se mantienen en el anexo A; la 24 (crecimiento óptimo) pasa a la caja de lecturas |

## 4. Datos actualizados

| Dato | Valor anterior | Valor nuevo | Fuente | URL | Consulta | Segunda comprobación |
|---|---|---|---|---|---|---|
| Peso de los bienes de equipo en la inversión | «más de 2/3» | 26,8 % de la FBCF (2025); construcción 52,9 %; propiedad intelectual 19,7 % (7,0 % en 1995); no residencial 71,9 % | INE, CNTR, tabla 67823 | https://www.ine.es/jaxiT3/Tabla.htm?t=67823 | 31/10/2026 | Eurostat `nama_10_an6`: mismos valores |
| FBCF / PIB | — | 21,0 % (2025); máx. 30,0 % (2006); mín. 17,6 % (2013); zona del euro 21,3 % | INE, CNTR; Eurostat `nama_10_gdp` | ídem; https://ec.europa.eu/eurostat/databrowser/view/nama_10_gdp/default/table | 31/10/2026 | Eurostat `nama_10_gdp`: cuadra |
| Volatilidad de la inversión | «el componente más volátil» (sin dato) | Desv. típica 1996-2019: FBCF 6,6, PIB 2,3; 2009-T2: FBCF −20,3 %, PIB −4,3 % | INE, CNTR, tabla 67824 | https://www.ine.es/jaxiT3/Tabla.htm?t=67824 | 31/10/2026 | Eurostat `namq_10_gdp`: cuadra |
| Incertidumbre de política económica (enganche) | — | Récord del índice de Baker, Bloom y Davis para España en abril de 2025 (529); índice del Banco de España en 2025 un 77 % sobre su media | policyuncertainty.com; Banco de España | ver `bib-datos.bib` | 31/10/2026 | Los 2 índices no cuadran en los picos (miden distinto); se usa el BBD solo para el récord |
| Summers (1981) | «coeficiente de q reducido…» | 0,03 (e. t. 0,005), costes del 65 %, semivida > 10 años; datos 1931-1978 | Summers (1981), cuadro 4; Romer (2019), 442-443 | Brookings | 31/10/2026 | Romer da las mismas cifras |
| Cummins, Hassett y Hubbard (1994) | «…» | Reformas de 1962, 1971, 1981 y 1986; coeficiente ≈ 0,5; costes ≈ 4 % | CHH (1994); Romer (2019), 443-444 | Brookings | 31/10/2026 | Romer: cuadra (Romer dice 1982 para la ley de 1981: se usan las fechas del artículo) |
| Incertidumbre de política económica en España (III.3) | — | Máximos del índice del Banco de España en mayo de 2020 (262) y junio de 2012 (234); media de 2025, 177 (77 % sobre la media histórica); gráfico `fig:epu-espana` (1997-2026) | Banco de España (Ghirelli, Pérez y Urtasun) | https://www.bde.es/f/webbe/SES/AnalisisEconomico/Investigacion/Datos_y_recursos/NEW_SPAIN_EPU_INDEX.xlsx | 31/10/2026 | Índice de Baker, Bloom y Davis: no cuadra en los picos (otra metodología); solo se cita para el récord de abril de 2025 |
| Julio y Yook (2012) | — | −4,8 % de inversión en años electorales | Julio y Yook (2012), resumen | DOI 10.1111/j.1540-6261.2011.01707.x | 31/10/2026 | Revisor de contenido |
| Fazzari, Hubbard y Petersen (1988) | — | Sensibilidad al flujo de caja 0,46 frente a 0,23 | FHP (1988), cuadro 4 | DOI 10.2307/2534426 | 31/10/2026 | Reproducido en apuntes de Gourinchas (Berkeley); no comprobado en el PDF original |

## 5. Contenido añadido

- Introducción: refrán, hecho actual, relevancia con datos, definiciones del SEC 2010, gráfico de la FBCF por activos, recorrido histórico completo (con Tobin, los costes de ajuste y las imperfecciones financieras), problemática y estructura.
- I.1: los 3 supuestos de Keynes, la definición formal de la EMgK, las 2 razones de su pendiente y la eficiencia marginal de la inversión de Lerner (nota).
- I.2: origen del principio de aceleración (Clark, 1917), ajuste parcial de Koyck y Chenery, multiplicador de impacto y de largo plazo, nota de Samuelson; valoración con la asimetría del acelerador.
- I.4: hamiltoniano en valor corriente, K* con Cobb-Douglas, paso del capital a la inversión, coste de uso con impuestos de Hall y Jorgenson (1967) con su caso neutral (remisión al 4.B.10) y la crítica de Haavelmo (1960).
- II: la q como valor actual de los beneficios futuros, la analogía con el empleo (3.A.26), la versión con depreciación (nota), la lección de política de las desgravaciones temporales (Abel, 1982), la q media y la marginal de Hayashi, la evidencia completa (Summers; CHH; Philippon, 2009; Peters y Taylor, 2017; Gutiérrez y Philippon, 2017) y la valoración (Blanchard, Rhee y Summers, 1993).

- III.1: costes quebrados con la función de inversión I(q), la banda de inacción en q (`eq:banda-inaccion-q`, función clave), la dependencia de la historia, los costes fijos y la regla (S,s), la tabla de tipos de costes con la misma familia que el 3.A.26, Caballero y Engel (1999), Doms y Dunne (1998), Cooper y Haltiwanger (2006), Abel y Eberly (1994).
- III.2: Hartman (1972) y Abel (1983) con la convexidad del beneficio en el precio (desigualdad de Jensen); Caballero (1991).
- III.3: la opción de esperar (Arrow, Henry, Bernanke, McDonald y Siegel, Pindyck, Dixit y Pindyck); modelo de 2 periodos, regla con la opción (función clave), principio de las malas noticias, ejemplo numérico de Pindyck (1991) con tabla, V* en tiempo continuo; extensiones (otras opciones reales, competencia, duraderos, histéresis de Dixit, 1989, y Baldwin y Krugman, 1989, con la nota de que no es la histéresis del paro); evidencia (McDonald y Siegel; Guiso y Parigi; Bloom, 2009; Bloom, Bond y Van Reenen, 2007; Baker, Bloom y Davis, 2016; Julio y Yook, 2012; Ghirelli, Pérez y Urtasun, 2019, con el gráfico del índice del Banco de España); valoración (Abel y Eberly, 1999).
- III.4: Modigliani y Miller (1958), jerarquía financiera (Myers y Majluf, 1984; Myers, 1984), prima de financiación externa con gráfico, Fazzari, Hubbard y Petersen (1988) frente a Kaplan y Zingales (1997), Erickson y Whited (2000), Lamont (1997), acelerador financiero (Bernanke y Gertler, 1989; Bernanke, Gertler y Gilchrist, 1999; Kiyotaki y Moore, 1997; Gertler y Gilchrist, 1994).
- III.5: síntesis (estabilidad y credibilidad, Rodrik, 1991; incentivos temporales, House y Shapiro, 2008, y Zwick y Mahon, 2017; políticas monetaria, fiscal y financiera) con `tab:implicaciones-inversion`.
- Conclusión: DSGE (Christiano, Eichenbaum y Evans, 2005; Smets y Wouters, 2007), intangibles (Haskel y Westlake, 2017), relación con 3.A.25, 3.A.26, 3.A.33, 3.B.2, 3.B.3; opinión sobre la transición energética y digital; idea final con el refrán.
- Anexos: A, control óptimo corregido como pieza común (con tabla de valor presente frente a valor corriente en lugar de las 2 imágenes de líneas de tiempo del original); B, Jorgenson paso a paso (valor corriente y presente) e inversión infinita; C, CPO de la q, solución hacia delante, linealización y pendiente de la senda de silla, versión con depreciación y demostración de Hayashi; D, V* con el lema de Itô, continuidad y tangencia, estática comparativa y ejemplo (V* = 2I); E, test.

Propuestas de contenido de la parte 1 (C1-C25, C38-C39):

| Propuesta | Aplicada | Nota |
|---|---|---|
| C1 (estructura y minutos) | No | Manda coherencia (DK1-DK3, DK10, DK11): III con 5 subapartados y minutos 2′30″/7′/9′30″/10′/1′ |
| C2 | Sí | Enlace de test en el anexo E |
| C3-C8 | Sí | C3 con los datos del verificador (récord BBD y BdE) en lugar del [DATO] de la FBCF trimestral; C5 sin la frase de la transición verde y digital (va a la conclusión, parte 2) |
| C9 | Sí, adaptada | EMgK (DK6) en vez de EMK; la función de Keynes con `equation`, no `\funcionclave` (pocas funciones clave por tema: c_K y la q); la cita de los *animal spirits* como traducción propia |
| C10, C11 | Sí | Nota 2 condensada, no suprimida |
| C12, C13, C14, C15 | Sí | β₀ para la velocidad del ajuste (N2 a), no la a de coherencia |
| C16 | Sí, adaptada | El coordinador pide P F_K = c_K (ficha `jorgenson`): en lugar de normalizar P = 1, se supone constante el nivel general de precios (r nominal = real), lo que resuelve el error de descontar con el tipo real |
| C17 | Sí | |
| C18 | Sí, adaptada | Título del II «Costes de ajuste: el modelo de la q» (DK11); Treadway (1969) añadido (V14) |
| C19, C20 | Sí, adaptadas | B(K) (DK4) en vez de π(K) (N3 rechazada: coordinador); φ (`\phi`) como el 3.A.26; 𝓗 sin superíndice (DK8) |
| C21 | Sí, adaptada | En el cuerpo de II.3 (no en caja); la función de Hayashi con `\varphi`, para no confundirla con el coeficiente φ |
| C22 | Sí | La frase sobre las medidas de la pandemia (mejora tomada de Cabado, redactada de nuevo) va en III.5 |
| C23 | Sí, adaptada | Años 1931-1978 del verificador (V18), no 1932 |
| C24 | Sí | Caja de *The Economist* en II.3 |
| C25, C38 | Sí | |
| C26 | Sí, adaptada | Título del III de coherencia y del coordinador (Extensiones: …) y 5 subapartados, no 6 |
| C27 | Sí | Tabla con las columnas del 3.A.26 (permanente/transitoria) en vez de las de contenido; letras φ como el 3.A.26 |
| C28 | Sí | B(p) en vez de π(p) |
| C29 + C30 | Sí, fusionadas en III.3 (decisión del coordinador) | «Ante la duda, abstente» sustituido por la pegatina del coordinador, «No por mucho madrugar…»; valor de la opción O(V) (DK7), no F(V); gráfico `fig:opcion-esperar` |
| C31 | Sí, adaptada | Riqueza neta RN (sigla) en vez de N, que es el número de empresas del II; prima s(·) (N5 a) |
| C32 | Sí | Etiqueta `tab:implicaciones-inversion` (coherencia); sin la frase de las desigualdades |
| C33 | Sí | Gráficos pedidos; el de datos de la EPU, solo con la serie del Banco de España |
| C34 | Sí | Más K13 (intangibles) |
| C35, C36 | Sí | Anexo A como pieza común (DK9) |
| C37 | Sí, repartida | Derivaciones en los anexos B (Jorgenson) y C (q); la banda y las malas noticias quedan en el cuerpo, que ya las deriva |
| C39 | Sí | `\vertema` a 3.A.2, 3.A.4, 3.A.5, 3.A.10, 3.A.26, 3.A.29, 3.A.30, 3.A.33, 3.A.35, 3.A.37, 3.A.38, 3.A.42, 3.A.43, 3.B.2, 4.B.10 |

Propuestas de datos: V1-V26 aplicadas (V24 y V25, sin poder comprobar: Sahuquillo y las citas de Ricardo y Marx, que se reformulan sin cita; V22, el artículo de 1956 de Pontryagin, se cita por el libro). Propuestas de coherencia: K1-K15 y DK1-DK11 aplicadas; los cambios del canon (§ 5.3, C1-C8) los hace tema-canon.

## 6. Coherencia

- Notación del canon: I = Ī − b·i (D009), v solo en el acelerador; EMgK en redonda (no había sigla en el canon: propuesta para `notacion.md` § 7); c_K = P^K(r + δ − Ṗ^K/P^K) y P F_K = c_K como en la ficha `jorgenson`; Φ(I) y (φ/2)I² (D130, φ como el 3.A.26); B(K) por D003 (la ficha `q-tobin` escribe π(K): **tema-canon** debe ponerla al día, C1 de coherencia); κ local con nota; θ local para la desgravación, con nota (el canon no fija letra; θ es la CRRA, que no sale en el tema); 𝓗 en valor corriente con λ_t (Jorgenson) y q_t (la q) como coestados.
- Remisión recíproca con el 3.A.26 (la q del trabajo) hecha en II.1; la del canal de la histéresis (3.A.28) va en III.3 (parte 2).
- Contradicciones con otros temas (no se tocan): 3.A.4 escribe I = Ī − v·r; 3.A.29 repite la q de forma menos completa y con P_t, W_t nominales; 3.A.37 usa la q media sin distinguirla de la marginal; 3.A.25 remite al 3.A.34 por el VAN (mejor 3.B.2). Ver `propuestas-coherencia.md`, § 8.

- III: remisión recíproca con el 3.A.26 hecha (misma tabla de tipos de costes, mismas letras φ_c, φ_d, banda dividida por r); mención del 3.A.28 con el aviso de que la histéresis de Dixit (1989) es otra idea (pendiente del 3.A.28 cumplido); 3.A.13 (limones y racionamiento), 3.B.3 (Modigliani-Miller), 3.B.25 (opción americana), 3.A.33 (duraderos y (S,s)), 3.A.37 (canal del crédito), 3.A.42 (ciclo financiero), 3.A.7 (DSGE), 3.A.43 (crecimiento óptimo), 3.A.25 (capital humano).
- Notación nueva para el canon (`notacion.md` § 7, para tema-canon): EMgK; B(K) en la ficha `q-tobin` (π(K) hoy); φ_c, φ_d y la banda 1 − φ_d ≤ q ≤ 1 + φ_c; O(V), V*, β₁, α_V, σ y π (probabilidad) en `opciones-reales` (hoy F(V) y p); RN riqueza neta y s(·) de BGG; θ local de la desgravación; λ⁰_t (valor presente) frente a λ_t (valor corriente) en la ficha nueva `optimizacion-dinamica`.
- El anexo A es la pieza común de tiempo continuo (DK9): 3.A.29 y 3.A.43 deben copiarlo al revisarse (anotar en `pendientes-coherencia.md`).

## 7. Dudas abiertas (aplicada la recomendada)

- **A34-01** Notación de Jorgenson: (a) **P, W y P^K nominales con el nivel general de precios constante** (aplicada: respeta P F_K = c_K de la ficha); (b) bien como numerario, P = 1, w real (como el 3.A.25 y el 3.A.26).
- **A34-02** Función de Hayashi: (a) **Φ(I,κ) = κ·φ(I/κ) con `\varphi`** (aplicada: el coeficiente del cuadrático es `\phi`, como en el 3.A.26); (b) otra letra (ψ).
- **A34-03** Funciones clave: (a) **solo c_K y las 2 condiciones de la q en I y II** (aplicada; en III, la banda y la regla de la opción); (b) también la función de Keynes.
- **A34-04** Sigla de la eficiencia marginal del capital: (a) **EMgK** (aplicada, por el patrón PMg, CMg; propuesta al canon); (b) EMK (revisor de contenido).
- **A34-05** El gráfico de datos de la FBCF va en la introducción (Contextualización) como apoyo, no se dibuja en el cante: (a) **así** (aplicada); (b) en un anexo.
- **A34-06** Riqueza neta de la empresa en III.4: (a) **sigla RN** (aplicada: N es el número de empresas del modelo de la q); (b) N como Bernanke, Gertler y Gilchrist, con aviso.
- **A34-07** Ejemplo de 2 periodos: (a) **el de Pindyck (1991): I = 1.600, precios 200/300/100** (aplicado: cifras comprobadas); (b) el de coherencia (I = 100, valores 160/60).
- **A34-08** Anexo A: (a) **tabla de valor presente frente a valor corriente sin las 2 líneas de tiempo del original** (aplicada); (b) dibujarlas en TikZ.
- **A34-09** Cifras de Fazzari, Hubbard y Petersen (0,46 y 0,23): (a) **se mantienen** (aplicada: vienen de su cuadro 4, reproducido en apuntes universitarios); (b) dejarlo en «casi el doble».
- **A34-10** Ejemplo del anexo D (α_V = 0, r = 4 %, σ = 0,2 ⇒ V* = 2I): (a) **se mantiene** (aplicado: cálculo propio que reproduce la cifra de McDonald y Siegel); (b) quitarlo.
- **A34-11** Gráficos de la desgravación: (a) **a 0,55 del ancho, el permanente justo tras su viñeta** (aplicada: quita el hueco de un cuarto de página); (b) dejarlos a 0,6 juntos al final del bloque, con el hueco.
- **A34-12** Nombres de autor en la bibliografía: (a) **la forma completa en todas las entradas** (aplicada: Ben S. Bernanke, Avinash K. Dixit, Nicholas Bloom, Lawrence H. Summers, Rafael Wouters); (b) la de cada revista.
- De la coordinación: DK1-DK8 y DK11 de coherencia, N1-N2, N4, E2, E4 y E6 de contenido, aplicadas como dijo el coordinador (N3 se resuelve con B(K), DK4).

- **A34-13** Estructura (DK1, coordinador): (a) **original con el III ampliado, «Extensiones: incertidumbre, irreversibilidad y financiación de la inversión», 10′ en 5 subapartados** (aplicada); (b) la de la ficha del tribunal (certidumbre / incertidumbre).
- **A34-14** Beneficio por unidad de capital (DK4 frente a N3): (a) **B(K)** (aplicada, canon D003; π para la probabilidad); (b) π(K) como Romer.
- **A34-15** Valor de la opción (DK7): (a) **O(V)** (aplicada; F es la producción); (b) F(V) con aviso.
- **A34-16** Hamiltoniano (DK8): (a) **𝓗 en valor corriente en el cuerpo** (aplicada); (b) H en valor presente.
- **A34-17** Anexo de control óptimo (DK9): (a) **pieza común; la parte continua de referencia es la de este tema** (aplicada); (b) esperar al 3.A.29.
- **A34-18** «Bienes de equipo, más de 2/3» (datos, D1): (a) **centrar en la inversión productiva (71,9 % de la FBCF)** (aplicada); (b) solo bienes de equipo (26,8 %).
- **A34-19** Índice de incertidumbre (D2): (a) **serie del BdE en el gráfico; BBD solo para el récord de abril de 2025** (aplicada); (b) BBD.
- **A34-20** Caja de The Economist (D4): (a) **a la valoración de la q** (aplicada); (b) quitarla.
- **A34-21** Pies «Sahuquillo» (D5): (a) **elaboración propia a partir de la fuente original** (aplicada); (b) sin fuente.
- **A34-22** Refranes: (a) **«Antes de que te cases, mira lo que haces»; pegatinas «No por mucho madrugar…» y «Dinero llama a dinero»** (aplicada); (b) otros.

## 8. Instrucciones para el vídeo

- **Enganche**: «Antes de que te cases, mira lo que haces» y el récord de la incertidumbre de abril de 2025; la idea final (parte 2) lo retoma.
- **Pizarra en 3 zonas**: izquierda, refranes; centro, gráficos; derecha, funciones clave recuadradas que se conservan: c_K (desde I.4) y las 2 condiciones de la q (todo el II).
- **I (7′)**: casi todo de palabra. Se escriben I = Ī − b·i y EMgK = i; el gráfico de la EMgK (`fig:emgk`) solo si sobra tiempo; I_t = vΔY_t escrito; el acelerador flexible y su gráfico, como apoyo. Jorgenson: problema en palabras, c_K recuadrado y `fig:jorgenson` por capas (ejes, P F_K, c_K, K*, bajada de r).
- **II (9′30″)**: el problema con `\optim` una vez; las 2 condiciones recuadradas; **`fig:q-fases` por capas** (ejes → K̇ = 0 → flechas de K → q̇ = 0 → flechas de q → E → senda de silla); después **`fig:q-permanente` sobre el mismo diagrama** (sin borrar: se añaden q̇ = 0′, E′, la nueva senda y el salto). Temporal, tipo de interés y desgravaciones: de palabra, con sus gráficos como apoyo; subrayar que la desgravación temporal anima más que la permanente. II.3: q media en una línea.
- Gráficos de datos (FBCF por activos): apoyo de la relevancia, no pizarra.
- **III (10′)**: III.1, la banda 1 − φ_d ≤ q ≤ 1 + φ_c recuadrada a la derecha (se conserva hasta el final) y `fig:inversion-banda` por capas (ejes, marcas, banda, rectas, recta sin quiebro en discontinuo); la tabla de tipos de costes, de palabra (apoyo). III.2, de palabra; la convexidad B(p) ∝ p^{1/α} como apoyo. III.3 es el centro del bloque: la tabla de los 2 periodos escrita en la pizarra con sus números (I = 1.600; 200; 300/100; 2.200; 600 frente a 773), la regla \eqref{eq:opcion-esperar} recuadrada, la pegatina «no por mucho madrugar amanece más temprano» a la izquierda y `fig:opcion-esperar` por capas (recta V − I, O(V), tangencia en V*, más volatilidad); el gráfico de la incertidumbre de España como apoyo. III.4, de palabra, con la pegatina «dinero llama a dinero» y `fig:coste-fondos` como apoyo. III.5: la tabla de síntesis como apoyo; se dice, no se escribe.
- **Conclusión (1′)**: sin pizarra; empieza por «En conclusión,»; la idea final retoma el refrán del enganche y responde a su pregunta (las empresas dejan de invertir cuando la incertidumbre se dispara, aunque el dinero sea barato; la política no puede quitar la incertidumbre, pero sí dejar de añadirla). Al final quedan en la pizarra las funciones clave (c_K, las 2 condiciones de la q, la banda y la regla de la opción) y el diagrama de fases.

## Control de calidad (31/10/2026): correcciones aplicadas

- Bibliografía: nombres unificados (Bernanke, Ben S.; Dixit, Avinash K.; Bloom, Nicholas; Summers, Lawrence H.; Wouters, Rafael); fuera SmetsWouters2003Estimated, que no se citaba; DOI de Gould (1968) corregido (10.2307/2974406) y DOI de Myers y Majluf (1984) añadido (10.1016/0304-405X(84)90023-0).
- III.3 d): cita del Banco de España tras el +77 % y frase que explica que, con otra metodología (2 periódicos), el índice de Baker, Bloom y Davis marca su récord para España en abril de 2025, mientras que el del Banco de España da entonces 212, por debajo de 2020 y 2012.
- Anexo D: el ∎ suelto tras la fórmula del umbral pasa al final de la viñeta.
- Hueco de un cuarto de página antes de los gráficos de la desgravación: el de la desgravación permanente se adelanta tras su viñeta y los 2 pasan a 0,55 del ancho; la página queda llena (comprobado en la compilación de prueba con los gráficos reales).

## Enlaces del original (9/11/2026)

Los 4 enlaces del original siguen en el tema (en el `.tex` o en el `.bib`): no se ha perdido ninguno.
