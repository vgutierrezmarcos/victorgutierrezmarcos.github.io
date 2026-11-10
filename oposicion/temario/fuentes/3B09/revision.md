# Revisión del tema 3.B.9: Comercio internacional y crecimiento económico

Título oficial: «Comercio internacional y crecimiento económico. Especial referencia a los efectos del comercio sobre el crecimiento.» Fuente: Word de Víctor (`Tema 3.B.9.docx`, PDF publicado de 33 páginas, 10/08/2024). Revisión del 05/11/2026 (rama `revision-temario-2`), en 2 partes: la parte 1 (preámbulo, introducción y bloque I) y la parte 2 (bloque II, conclusión, anexos y bibliografía). Cada sección recoge las 2 partes.

## 1. Resumen

- Se mantienen los 2 apartados del original (las 2 direcciones de la relación) con sus títulos de segundo nivel; minutos de coherencia: introducción 2′30″, I 11′, II 15′30″, conclusión 1′.
- Introducción nueva con sus 5 bloques: enganche «¿Qué fue antes, el huevo o la gallina?» con Corea del Sur (Banco Mundial), relevancia con la apertura mundial y el comercio de 2025, contextualización reducida a comercio y crecimiento, 3 preguntas y estructura; esquema, reparto del cante y caja de notación.
- Bloque I con la estructura de modelo (a, b con i-iii, c): clasificación de Johnson (1955) en tabla con color, país grande con el crecimiento empobrecedor y su condición formal, Rybczynski con el efecto magnificación, la enfermedad holandesa bien definida (Corden y Neary, 1982) y el progreso técnico de Findlay y Grubert (1959) con las cadenas lógicas corregidas.
- Gráficos de la parte 1: 5 nuevos o rehechos en TikZ/pgfplots (pedidos) y 3 reutilizados del bloque (3.B.5, 3.A.11, 3.B.6); con la parte 2, 9 nuevos o adaptados y 3 reutilizados, 12 en total.
- Bloque II rehecho con la notación de coherencia y del 3.A.44: los 4 mecanismos de Grossman y Helpman (2015) como guía; crecimiento exógeno y Baldwin; externalidades de Arrow y Romer (no «modelo de Lucas»), con el grado de apertura sin símbolo; Romer y Rivera-Batiz-Romer con `eq:romer-gamma`; Grossman y Helpman con el modelo correcto (economía pequeña con 2 factores) y una nota sobre el test de 2014 y 2022; Young, Lucas (1993), la U invertida y Melitz; difusión de Barro y Sala-i-Martin (1997); CEPAL, ISI e IOE con evidencia y Thirlwall; centro-periferia en resumen con la notación del 3.B.6; evidencia empírica completa y comprobada.
- Conclusión con sus 5 bloques, que empieza por «En conclusión,» y cierra con el huevo y la gallina; 4 anexos más el de test (progreso técnico con la caja de Edgeworth y el álgebra de Jones, centro-periferia con las 5 condiciones, externalidades, Grossman y Helpman). En total, 9 gráficos nuevos o adaptados pedidos y 3 reutilizados.

### Estado de las propuestas

- **Coherencia (K)**: aplicadas K1 (enganche, con las cifras del coordinador y sin Ghana, no comprobada), K2 (sin la cita de Lucas; el coste de la fragmentación sin cifra, porque no se comprobó), K3, K4, K5, K6, K7 (`eq:importaciones` como `\funcionclave`), K8 (tabla con color; filas ordenadas de ultraprocomercio a ultraanticomercio, como las regiones del gráfico, en lugar del orden de K; imagen 3 suprimida), K9 (gráfico del 3.B.5 adaptado; un solo gráfico de 2 paneles para el bienestar), K10 (Rybczynski del 3.B.5, segundo panel, enfermedad holandesa, implicaciones, Corea), K11, K12, K28 y K29 (etiquetas y remisiones del bloque I), K30 (caja de notación), K31. K10 y K11 se cuentan en 2 subapartados (I.2.3 e I.2.4) en lugar de uno, para que cada modelo tenga sus bloques con título.
- **Contenido (C)**: aplicadas C3, C4 (fusionadas con K3 y K4), C5, C6, C7, C8 (con $\overline W$ en lugar de $I$, por K8), C9, C10, C11 (con la derivación en caja y $Y$ como numerario; la imagen 5 dibujada), C12 (dentro de iii) Implicaciones, no como bloque c) propio), C13, C14, C15 (la tabla y las 2 cadenas; el álgebra va al anexo `anexo:progreso` de la parte 2), C16, C31, C32 (notas 1-11). **No aplicadas**: C1 en los minutos (manda coherencia: I 11′, II 15′30″; decisiones del coordinador) y en los anexos (manda K); C2 en el enganche «más ven cuatro ojos que dos» (retirado en el 3.A.44; manda K1) y en la cita de Lucas (pendientes-coherencia, l. 509); C34 en sus refranes (mandan los de K).
- **Datos (V)**: aplicadas V1, V2 (gráfico G1), V5, V6, V10-V16 y V18 (fuentes de los pies). V8 y V9 no se aplican: la cita de Lucas y la nota del Nobel salen por coherencia. V17: se cita `Gandolfo2014Growth`, cap. 13, págs. 307-308 en el pie del gráfico del país grande. L1, L5 (vídeo en caja), L9 y L10: aplicados (bibliografía y simulador, parte 2).
- **Parte 2, coherencia (K)**: aplicadas K13 (con Melitz en una línea), K14 (los 4 mecanismos numerados y traducidos), K15, K16 (título, $(X+M)/Y$ sin símbolo, η = 0, nivel frente a tasa, Lucas, 1988 y 1993; pegatina), K17 (con $N_t$, $L_I$, $\eta_I$, $\gamma^{\mathrm E}$; `eq:romer-gamma` como `\funcionclave`; pegatina), K18 (pegatina), K19 (Norte-Sur, Young, U invertida y pegatina), K20 (sin la cifra de I+D de Corea, porque no se comprobó; el ejemplo queda sin número), K21 (Thirlwall con la fórmula del 3.B.28; sin «especialización perversa»), K22, K23 (`tab:isi-ioe`), K24, K25 (con «desastres», como el 3.A.45), K26, K27 (anexos A, B y C; anexo de test con el simulador), K28 y K29 (etiquetas propias para los 6 modelos del II.1, cada uno en su `\subsubsection`). La lista de K30 está completa en la caja de notación.
- **Parte 2, contenido (C)**: aplicadas C17, C18 (con las palabras del 3.B.10 para Baldwin), C19 (con $(X+M)/Y$ en lugar de β, porque manda coherencia en la notación; se quita la nota de β), C20 (sin el bloque iv, que pasa a c) Valoración), C21 (decisión del coordinador: el mecanismo es el de la economía pequeña con 2 factores, `GrossmanHelpman1991Small`; el AER de 1990 para lo suyo; nota al opositor del test), C22 (escalera de calidades dentro de Grossman y Helpman; difusión con su propio subapartado y gráfico), C23, C24 (sin Grubel), C25 (sin la cifra del 6 o el 7 % de crecimiento de los tigres, que no tenía fuente), C26, C27 (con las cifras de datos cuando difieren: Feyrer, 17 %; Altomonte, 0,3; Bloom, 14 %; Wacziarg y Welch, también +5 puntos de comercio), C28 (la idea final de K, no la del refrán retirado), C29 y C30 (el anexo de test va en una caja `anotaciones`). El anexo D de C21 se conserva (anexo `anexo:grossman-helpman`).
- **Parte 2, datos (V)**: aplicadas V3 (en la relevancia de la conclusión), V4, V7, V19-V27, V31, V33-V48, L3, L6-L8, L10. V28 (nota 6) y V29-V30 (nota 1, Ruhr) se aplican al quitar las notas o en el texto (el Ruhr, en el II.3). V32: sin la atribución a Grubel. V34: la nota 13 pasa a `Chang2002`; la 15 se resume con `Irwin2021`, como el 3.B.28 (la entrada `Economist2020ISI` queda en el .bib sin citar).
- **Pendientes (P)** resueltos en la parte 1: P1, P2, P5-P9, P19-P27, P33, P41, P43, P44, P57-P64, P73, P76, P77. En la parte 2: P3, P4, P10-P18, P28-P32, P34-P40, P42, P45-P51, P52-P56, P65-P72, P74, P75.

## 2. Errores corregidos

| Dónde (original) | Decía | Dice ahora |
|---|---|---|
| Nota 4 (Hume) | «*Discursos políticos*, 1952» | 1752 (`Hume1752Balance`), en la nota de los clásicos |
| Contextualización, l. 73 | Hamilton (1790) | 1791, *Report on Manufactures* (`Hamilton1791Report`) |
| Nota 6 | Falvey en competencia monopolística, «Kierzowski», Brander bajo heterogeneidad | Se quita (es materia del 3.B.6, que la tiene corregida en `tab:clasificacion`) |
| I.1, Solow (l. 152) | «En el estado estacionario, los agentes no tendrán incentivos a invertir porque se iguala la PMg del capital a la depreciación» | En el estado estacionario se sigue invirtiendo: la inversión repone la depreciación y equipa a los nuevos trabajadores, $s f(k^*)=(n+\delta)k^*$ |
| I.2.1, l. 216 | $\lvert\varepsilon_{Y,M}\rvert=\mathrm{PMgC}_Y/\mathrm{PMeC}_Y$ | $\varepsilon_{Y_C,\overline W}$ con su signo y la propensión media sin sigla (canon §0 y §7) |
| I.2.1, l. 264 | demanda de importaciones «$C_YQ_Y$» | $M^A=Y^A_C-Y^A_P$ (`eq:importaciones`) |
| I.2.1, imagen 1 | renta $I_Y$ | $\overline W$, renta nacional en unidades de $Y$ (canon, D002) |
| I.2.1 | efecto total «a partir de las elasticidades» sin fórmula | `eq:elasticidad-importaciones`, $\varepsilon_{M^A,\overline W}=(Y_C/M^A)\varepsilon_{Y_C,\overline W}-(Y_P/M^A)\varepsilon_{Y_P,\overline W}$ (comprobada derivando $M^A=Y_C-Y_P$) |
| I.2.2, l. 352 | «Descartando el caso de que el crecimiento sea anti-comercial» | «descartando el crecimiento ultraanticomercio, el único que reduce las importaciones» |
| I.2.2, condiciones de Bhagwati | 5 condiciones: «crecimiento débil», «muy pro-comercio» y «sesgado hacia el exportador» (la misma contada 2 veces), demanda inelástica, sin arancel óptimo | 4 condiciones: sesgo hacia el exportable (ultraprocomercio en la producción), demanda exterior inelástica, país muy dependiente del comercio ($M^A$ grande frente a $\mathrm d\overline W_0$) y sin política óptima, con su razón (Bhagwati (1968)). «Crecimiento débil» no es una condición de Bhagwati: lo que importa es la ganancia a precios constantes frente a las importaciones (C11) |
| I.2.2, implicaciones (l. 412) | «una política de ISI … generaría un sesgo ultra anti-comercial mejorando la RRI. Que realizar esta política sea una buena idea ya es otra historia» | El sesgo es del crecimiento, no de una política; el argumento correcto es el arancel óptimo o el impuesto a la exportación, y la lectura histórica es la de Prebisch y Singer (remite al II.2) |
| I.2.3, Rybczynski (l. 428, 452) | «aumento de la dotación *relativa*… siempre que se mantengan constantes los precios de los bienes **y de los factores**», sin magnificación | Enunciado del 3.B.5: a precios de los bienes constantes, la producción del bien intensivo crece más que proporcionalmente y la del otro cae; los precios de los factores constantes son una consecuencia; `eq:rybczynski` |
| I.2.3, supuestos (l. 434-438) | «No cambian ni los precios de los factores ni los precios relativos de los bienes» | Solo los de los bienes (país pequeño); consumo neutral como supuesto del análisis |
| I.2.3, l. 456 | «la producción (en valor absoluto) de X ha aumentado más que la renta» | más que proporcionalmente |
| I.2.3, enfermedad holandesa (l. 486) | «Este deterioro de la RRI que tiene lugar en un país grande … se denomina enfermedad holandesa» y una secuencia que acaba en el deterioro de la RRI | Es la contracción de los demás comerciables por los efectos movimiento de recursos y gasto, en un país pequeño, sin cambio de la RRI (Corden y Neary (1982), como el 3.B.5 y el 3.B.28); el deterioro de la RRI del país grande se queda con su nombre |
| I.2.4, Hicks (l. 512) | «La cantidad de factores utilizados disminuye» | Para $K/L$ dado, la RMST no cambia; las isocuantas se acercan al origen sin cambiar de pendiente (3.A.11) |
| I.2.4 (l. 514-520) | «Intensificador del capital: … un ejemplo es el neutral de Solow»; Harrod, «la relación capital-producto permanece constante» | Aumentador no es sesgado (con σ < 1, el aumentador del capital ahorra capital); Harrod: para $K/Y$ dado, no cambian las participaciones (3.A.11 y ficha `progreso-tecnico-neutral`) |
| I.2.4, términos | «intensificador de trabajo / de capital» para el sesgo | «ahorrador de capital» / «ahorrador de trabajo» (Hicks), como el 3.A.11 |
| I.2.4, l. 552 | «sector del bien exportable (*Y*)» | (*X*) |
| I.2.4, cadenas lógicas (l. 566-590) | el progreso «intensificador de trabajo» en $X$ sube el coste del capital frente al salario, y el «intensificador de capital» lo contrario | A precios de los bienes dados, cualquier progreso en $X$ sube la renta del factor en que es intensivo $X$ (el capital) y baja la del otro, con cualquier sesgo (efecto coste); la ambigüedad viene del factor que libera el progreso (efecto ahorro). Comprobado con el álgebra de Jones (C15; va al anexo `anexo:progreso`) |
| I.2.4, implicaciones (l. 598) | «(y del progreso intensificador del capital en el sector del bien intensivo en trabajo) se producen efectos ultra pro-comercio» | El progreso en el importable es ultraanticomercio para $A$ (tabla `tab:findlay-grubert`) |
| I.2.4, supuestos | «Irreversibilidad de la intensidad factorial» | «No reversión de las intensidades factoriales» (término del 3.B.5) |
| Notas 11 y 12 | Acemoğlu, 2008; cita en inglés sin referencia | Acemoglu (2009), cap. 2, en castellano y sin comillas (la página 59 y la cita literal no se han podido comprobar: se da como paráfrasis) |
| Pies de las imágenes 2 y 4 | «Sahuquillo (2017) 3A-9» | Errata y fuente de otro preparador: «elaboración propia a partir de» las obras originales |
| II.1, mecanismos (l. 690-698) | numeración «i., i), ii), iii)» y en inglés | 1-4 en castellano con el término inglés en cursiva |
| II.1, l. 742 | en la 1.ª generación «el progreso tecnológico es un resultado exógeno» | un subproducto no buscado de la inversión |
| II.1, «modelo de Lucas» (l. 738-789) | externalidad del capital físico atribuida a Lucas; grado de apertura β; «si $E=0$, Cobb-Douglas»; «a mayor β, mayor tasa» | Externalidades de Arrow (1962) y Romer (1986); apertura $(X+M)/Y$; Cobb-Douglas con $\eta=0$; la tasa sube solo si $\alpha+\eta=1$, si no, el nivel |
| II.1, Baldwin (l. 726) | sin año ni mecanismo | Baldwin (1992), efecto de acumulación a medio plazo; Baldwin (1989) para el mercado único |
| II.1, clásicos | «permite aprovechar los rendimientos decrecientes de la tierra» | permite eludirlos importando alimentos (Ricardo); la *vent for surplus* con su nombre (Myint, 1958) |
| II.1, Grossman y Helpman (1990) (l. 817-839) | el mecanismo de Stolper-Samuelson atribuido al AER de 1990; «baja el precio de la I+D»; «subvencionar las importaciones, como sugieren los autores»; «política comercial estratégica» | El mecanismo es del modelo de economía pequeña con 2 factores (Grossman y Helpman, 1991, WP 2970); baja la remuneración del capital humano; los autores no lo recomiendan (crecer no es bienestar); fuera «estratégica» |
| II.1, Barro y Sala-i-Martín | sin año ni obra | Barro y Sala-i-Martin (1997), *Journal of Economic Growth* |
| II.2, CEPAL (l. 861-889) | «Prébisch»; los primarios «intensivos en trabajo»; «especialización perversa» de Grubel; «aisló a América Latina, Argentina e India… de las cadenas globales de valor» | Prebisch; primarios intensivos en recursos naturales; sin la atribución (no hay fuente) ni el término (el 3.B.10 lo usa con otro sentido); sin el anacronismo de las cadenas de valor |
| II.2, IOE (l. 891-913) | «política que defiende las subvenciones a la exportación»; objetivos 2 y 3 repetidos; países en versalitas | Neutralidad de incentivos (Bhagwati, 1988) con los 3 instrumentos del 3.B.28; 3 objetivos distintos; países en redonda |
| II.3 (l. 915-1257) | notación γ, ζ, ζ_B, ζ_S; «Rühr»; Baldwin y Forslid (2004) como evidencia | $\mu$, $\phi_\tau$, $\phi^{\mathrm r}_\tau$, $\phi^{\mathrm s}_\tau$; Ruhr; Baldwin y Forslid (2000), como extensión teórica |
| II.4, Panagariya (l. 1259-1269) | «3 décadas», lista desde «b.», sin obra; «fracasos» | Panagariya (2004), 1961-1999, «desastres» como el 3.A.45; sale de la conclusión, donde se repetía |
| Nota 12 | «Acemoğlu, 2008» | Acemoglu (2009), cap. 19 |
| Anexo centro-periferia (l. 1037-1039) | $\bar L=n(F+cq)$ frente a $\lambda_i\gamma=n_i(F+cq)$; 5.ª condición sin desarrollar | Una sola, $\lambda_i\mu=n_i(F+cq^*)$; la balanza comercial desarrollada |

## 3. Marcas resueltas

| Marca | Texto original | Qué se hizo |
|---|---|---|
| P1, amarillo | Pie de la imagen 3: «Fuente: Zapico» | La imagen 3 se suprime (decisión D4 del coordinador): en el país pequeño el bienestar sube siempre y basta una frase (I.2.1, iii). El material de Zapico no es una obra publicada localizable |
| P2, amarillo | Imagen 5 «Mejora de bienestar en país grande con crecimiento» sin imagen y «Fuente: …» vacía | Se dibuja como panel izquierdo de `fig:bienestar-grande` (pedido `bienestar-grande`), con el empobrecedor a la derecha; fuente: Bhagwati (1958) y Gandolfo (2014, cap. 13, págs. 307-308) |
| P5, amarillo | Estructura vacía | Estructura escrita con el porqué del orden, esquema y nota del reparto |
| P6, notas al opositor | Cambio de temario de 2023, «estaría actualizado», tabla en imagen | Se quitan (notas de trabajo) |
| P7, comentarios | Capturas del *World Trade Statistical Review* 2023 | Sustituidas por datos actuales en la relevancia (Banco Mundial, apertura 1970-2024, y OMC, octubre de 2026) y el gráfico de datos `fig:comercio-pib-mundial` |
| P8, nota y comentario | «Ver Gandolfo, Part V, cap. 13-15; principalmente el 13» | El bloque I se ha contrastado con Gandolfo (2014), cap. 13 (`Gandolfo2014Growth`), que es la fuente de los pies; la nota y el comentario no se publican |
| P9, comentario | «Ver Zapico (págs. 9-13) si no se entiende; cajas de Edgeworth; la no reversión de intensidades es clave» | Resuelto con la fuente primaria (Findlay y Grubert, 1959) y el álgebra de Jones (1965): las cadenas lógicas se corrigen en el cuerpo, la no reversión se explica en los supuestos y la caja de Edgeworth y el álgebra van al anexo `anexo:progreso` (parte 2) |
| Notas 1-3 | Neolítico; Nobel de Lucas; Lucas (1988) | Nota 1 fuera (enganche común con 3.B.5, 3.B.6 y 3.B.8). La cita de Lucas (1988) y la nota del Nobel salen de la relevancia por coherencia (`pendientes-coherencia.md`, l. 509: la usa el 3.A.43); Lucas (1988) queda citado en la contextualización |
| Notas 4-6 | Hume, «nuevas teorías», clasificación | 4 corregida e integrada en la nota de los clásicos; 5 y 6 fuera (materia del 3.B.6) |
| Nota 7 | País pequeño | Integrada en los supuestos del I.2.1 |
| Nota 8 | Edgeworth (1894) | Se mantiene, resumida |
| Nota 9 | Vídeo de VisualEconomik | El enlace funciona (datos, L5): se conserva como lectura en una caja `anotaciones` al final del I.2.3, no como fuente de la definición |
| Nota 10 | Aumento del factor del importable (ultraanticomercio) con gráfico | Se mantiene como nota al pie; el gráfico pasa a panel derecho de `fig:rybczynski` |
| Nota 11 | Cita de Acemoglu en inglés | Traducida como paráfrasis y citada (cap. 2) |
| Implicaciones vacías (P64) | Acumulación de factores, «Implicaciones» sin texto | Escritas (I.2.3, iii) |
| P3 y P4, amarillo | Condiciones del centro-periferia: 4.ª con notación distinta y 5.ª sin desarrollar | Anexo `anexo:centro-periferia`, con la notación del 3.B.6 y la 5.ª condición desarrollada |
| P10, notas al opositor | «Posibles fuentes» (Grossman y Helpman, 1991; Acemoglu, cap. 19; Feenstra, cap. 10; Melitz) | Usadas como fuentes del II y fuera; Melitz en una línea con remisión |
| P11, comentarios | Guion del cante de otro opositor | No se publica |
| P12, nota y viñeta vacía | Romer (1990): «centrarse en los determinantes y en cómo puede afectar el comercio» | Escrito: determinantes de la tasa, `eq:romer-gamma` y la versión abierta de Rivera-Batiz y Romer (1991), con gráfico |
| P13, comentarios | «Aquí copiado el modelo de Sahuquillo»; coeficientes | Redactado de nuevo con las fuentes primarias (C21) |
| P14-P17, comentarios | «Coordinar con…»; «ver Gandolfo cap. 16» | Coordinación hecha (3.A.44, 3.B.6, 3.B.10, 3.B.28); no se publican |
| P18, comentarios de la bibliografía | «el segundo apartado es manifiestamente mejorable: Grossman y Helpman (2015), Rivera-Batiz y Romer» | Es la guía del II (los 4 mecanismos y el modelo abierto) |
| Notas 13-16 | Vídeo de Chang; ley de Engel; cita de *The Economist* en inglés; industria naciente | 13 → `Chang2002`; 14 se mantiene; 15 → `Irwin2021`, en castellano; 16 se resume con remisión al 3.B.8 |
| Notas 17-22 | Ruhr, historia de la NEG, utilidad, libre entrada, salario real, causación circular | El Ruhr pasa al texto; las demás son del 3.B.6 y salen; lo necesario va al anexo B |
| Bibliografía (P56) | «Tema ICEX-CECO», «Tema A. Sahuquillo», «Tema Juan Luis Cordero Tarifa» y enlaces `file:///` | Fuera (encargo del coordinador: sin nombres de preparadores ni enlaces locales); las obras recomendadas en los comentarios (Gandolfo, Appleyard y Field, Feenstra) salen en la bibliografía con `\nocite` y Grossman y Helpman (2015) con su DOI |
| P42, anexos | «Anexo 1» y «Preguntas de otros exámenes» vacíos; enlace a quia.com | Fuera; anexo de test con el enlace genérico al simulador |
| Conclusión (P40) | Relevancia, opinión e idea final vacías; viñeta vacía; Panagariya repetido | Escritas; la repetición sale |

## 4. Datos actualizados

| Dato | Valor anterior | Valor nuevo | Fuente | URL | Consulta | Segunda comprobación |
|---|---|---|---|---|---|---|
| Corea del Sur, exportaciones de bienes y servicios sobre el PIB (enganche) | — (nuevo) | 2,6 % en 1960; 44,4 % en 2024 | Banco Mundial, WDI, NE.EXP.GNFS.ZS (`BancoMundial2026Corea`) | https://data.worldbank.org/country/korea-republic | 05/11/2026 | **Una sola fuente** (consulta del coordinador a la API del Banco Mundial); no hay segunda comprobación independiente |
| Corea del Sur, PIB por habitante en dólares constantes de 2015 | — (nuevo) | 1.038 (1960) y 37.048 (2024): unas 36 veces | Banco Mundial, WDI, NY.GDP.PCAP.KD (`BancoMundial2026Corea`) | ídem | 05/11/2026 | **Una sola fuente**, como el anterior |
| Comercio mundial de bienes y servicios sobre el PIB (relevancia y gráfico) | — (capturas del WTSR 2023) | 25,8 % (1970), 60,3 % (2008), 62,2 % (2022, máximo), 56,7 % (2024); en el texto, 26 %, 62 % y 57 % | Banco Mundial, WDI, NE.TRD.GNFS.ZS (`BancoMundial2026Apertura`) | https://data.worldbank.org/indicator/NE.TRD.GNFS.ZS | 05/11/2026 | FMI (WEO, oct. 2026) y OMC: 58,0 % en 2024, cuadra a 1,3 puntos (V2). La serie 1970-2008 solo la publica el Banco Mundial |
| Volumen del comercio mundial de mercancías y PIB mundial, 2025 | — | +4,2 % frente a +3,0 % (1,4 veces) | OMC, *Global Trade Outlook and Statistics*, octubre de 2026 (`OMC2026PerspectivasOct`) | https://www.wto.org/english/res_e/booksp_e/gtos1026_e.pdf | 05/11/2026 | Banco Mundial, WDI: PIB +2,92 % y exportaciones +4,88 % en 2025; cuadra (V1) |
| Fechas y citas del bloque I | Hume 1952, Hamilton 1790, Johnson sin año, Grubel, Acemoglu 2008 | Hume 1752, Hamilton 1791, Johnson 1955 y 1958, Findlay y **Grubert** 1959, Acemoglu 2009; sin cambios Harrod 1939, Domar 1946, Solow 1956, Rybczynski 1955, Bhagwati 1958, Edgeworth 1894 | Crossref, Founders Online y claves de los temas revisados (V5, V6, V10-V16) | — | 05/11/2026 | Cuadran (V5-V16); la página 59 de Acemoglu, sin comprobar |
| Citas nuevas del bloque I | — | Bhagwati (1968), Johnson (1967), *The Economist* (1977), Krugman (1987), Young (1995) | Propuestas de contenido (C11, C14) y claves del 3.B.6 y el 3.A.45 | — | 05/11/2026 | Revista, volumen y páginas comprobados en la fase de contenido |
| Caídas del comercio en las recesiones (conclusión) | «periodos de recesión… acompañados de caídas» sin cifra | Volumen de mercancías −12,2 % en 2009 y −5,3 % en 2020 | OMC, comunicados 598 y 876 | https://www.wto.org/english/news_e/pres10_e/pr598_e.htm ; https://www.wto.org/english/news_e/pres21_e/pr876_e.htm | 05/11/2026 | Banco Mundial, WDI: mismo signo, el comercio cae varias veces más que el PIB (V3) |
| Corea del Sur, exportaciones sobre el PIB en 1970 (IOE) | — | 11,3 % (en el texto, 11 %) | Banco Mundial, WDI (`BancoMundial2026Corea`) | ídem | 05/11/2026 | Una sola fuente (coordinador) |
| Panagariya (2004) | «3 décadas», «más del 3 %» | 1961-1999; 3 % o más | Panagariya (2004) | https://rsie.econ.lsa.umich.edu/acit/Documents/MiraclesDebacles.pdf | 05/11/2026 | Crossref y resumen publicado (V4) |
| Sachs y Warner (1995) | — | 4,5 % frente a 0,7 % anual por habitante (1970-1989) | *BPEA* 1995(1) | https://www.brookings.edu/wp-content/uploads/1995/01/1995a_bpea_sachs_warner_aslund_fischer.pdf | 05/11/2026 | Resumen de los editores (V39) |
| Frankel y Romer (1999) | — | entre medio y 2 puntos (la frase del 3.A.45) | *AER* 89(3) | https://doi.org/10.1257/aer.89.3.379 | 05/11/2026 | Fuentes secundarias; el artículo no se ha abierto (V40) |
| Wacziarg y Welch (2008) | — | +1,5 puntos de crecimiento; inversión +1,5-2; comercio +5 puntos del PIB (1950-1998) | *WBER* 22(2) | https://doi.org/10.1093/wber/lhn007 | 05/11/2026 | Crossref (V44) |
| Feyrer (2019) | — | elasticidad 0,5; 17 % de la variación del crecimiento (1960-1995) | *AEJ: Applied* 11(4) | https://doi.org/10.1257/app.20170616 | 05/11/2026 | NBER WP 14910 (V45) |
| Altomonte, Bonacorsi y Colantone (2018) | — | elasticidad 0,3 (1995-2007) | BAFFI CAREFIN WP 97 | https://doi.org/10.2139/ssrn.3295553 | 05/11/2026 | VoxEU; documento de trabajo (V46) |
| Bloom, Draca y Van Reenen (2016); Autor et al. (2020) | — | 14 % de la mejora tecnológica europea (2000-2007); patentes a la baja en EE. UU. | *RES* 83(1); *AER: Insights* 2(3) | https://doi.org/10.1093/restud/rdv039 | 05/11/2026 | Crossref (V47) |
| Comisión sobre el Crecimiento (2008) | — | 13 economías con un 7 % o más durante 25 años desde 1950 | *The Growth Report* | — | 05/11/2026 | Resúmenes (C27); sin página, como decidió el coordinador |

## 5. Contenido añadido

- **Enganche y relevancia nuevos** (K1, K2, coordinador): el dicho del huevo y la gallina con Corea del Sur, y la apertura mundial con el gráfico de datos `fig:comercio-pib-mundial` (P32).
- **Contextualización** centrada en comercio y crecimiento (K3 y C3): los clásicos (Smith, Ricardo), la teoría del comercio estática, el crecimiento cerrado, los 2 puentes y la economía del desarrollo; definiciones de crecimiento y apertura.
- **I.2.1**: tabla de clasificación con color de los 5 tipos de crecimiento de Johnson (`tab:sesgos`, K8) y la elasticidad de las importaciones que pondera los 2 lados (`eq:elasticidad-importaciones`).
- **I.2.2**: la descomposición del bienestar del país grande (`eq:bhagwati`), con su derivación en una caja gris (identidad de Roy y envolvente); Bhagwati (1968) (sin distorsión no hay empobrecimiento; con el arancel óptimo, imposible) y Johnson (1967) (también en un país pequeño con arancel); el panel de la mejora del bienestar que faltaba.
- **I.2.3**: Rybczynski con el efecto magnificación, el panel del factor del importable y el ejemplo de Corea; la enfermedad holandesa bien definida (Corden y Neary, 1982; *The Economist*, 1977; Krugman, 1987, para el efecto permanente).
- **I.2.4**: el sesgo de Hicks distinto de la neutralidad, los 2 efectos del progreso técnico (coste y ahorro de factores) y la tabla `tab:findlay-grubert`.
- **I.3**: lo que aporta, la crítica y el puente al II.
- **II.1** (C17-C23, K13-K20): los 4 mecanismos; Baldwin (1992) y la *vent for surplus*; externalidades con apertura y su gráfico; Romer y Rivera-Batiz-Romer con el gráfico en el plano $(\gamma,r)$, efectos escala y redundancia y la crítica de Jones (1995); Grossman y Helpman (economía pequeña, 2 países, Norte-Sur, calidades y ciclo del producto) con la nota del test; Young (1991), Lucas (1993), la U invertida (Aghion et al., 2005), Melitz, Pavcnik (2002) y Goldberg et al. (2010); difusión (Barro y Sala-i-Martin, 1997) con gráfico nuevo, Ben-David (1993) y Coe y Helpman (1995).
- **II.2**: la tesis de Prebisch y Singer en 3 viñetas como lectura histórica del crecimiento empobrecedor, Thirlwall, la ISI con su valoración (Chang, Krueger, Harvey et al., 2010), la IOE con la definición de Bhagwati (1988) y la comparación con evidencia (`tab:isi-ioe`; estudios del NBER, Banco Mundial, 1993; Rodrik, 1995; Young, 1995; Krugman, 1994; Juhász, Lane y Rodrik, 2024).
- **II.3**: el centro-periferia en resumen y, como idea central, geografía y crecimiento (Baldwin y Forslid, 2000; Martin y Ottaviano, 1999; Baldwin, Martin y Ottaviano, 2001).
- **II.4**: la dificultad de la causalidad y la evidencia en 3 bloques (comparaciones entre países, variables instrumentales, liberalizaciones y empresas) con su valoración. La idea de usar a Altomonte et al. (2018) y a Acemoglu, Johnson y Robinson (2005) la sugiere el tema de Miquel Tebar Barbero (solo contraste; redactado de nuevo).
- **Anexos**: A, progreso técnico (caja de Edgeworth y álgebra de Jones); B, centro-periferia (5 condiciones); C, externalidades (3 pasos y Ramsey); D, Grossman y Helpman (Stolper-Samuelson y coste de la I+D); E, test.
- Reorganización por debajo del segundo nivel: el II.1 se cuenta en 6 subapartados de tercer nivel, uno por modelo, para que cada uno tenga sus bloques con título.
- Reorganización por debajo del segundo nivel (bloque I): el «según su origen» del original (1.2.3) se parte en I.2.3 (acumulación de factores) e I.2.4 (progreso técnico), para que cada modelo tenga sus bloques i), ii) y iii) con título (CRITERIOS §2). Los títulos de primer y segundo nivel son los del original.

## 6. Coherencia

- **Notación**: la del 3.B.5 en el bloque I ($E^A=X^A_P-X^A_C$, $M^A=Y^A_C-Y^A_P$, $\mathrm{RRI}\equiv p_X/p_Y$ con $p$ minúscula, ON$_A$, CIS, FPP, $\overline K$, $\overline L$); $\overline W$ para la renta (D002); elasticidades con su signo; la propensión media sin sigla; álgebra de Jones con circunflejo. Caja de notación tras la introducción (K30) con el aviso de los 2 usos de $X$, $Y$ y $E$.
- **Mismo modelo, misma forma**: Rybczynski con el enunciado y la ecuación del 3.B.5 y su gráfico; curvas de oferta neta con las palabras y el gráfico del 3.B.5 (adaptado con ON$_A'$); tipos de progreso técnico con las palabras y el gráfico del 3.A.11; enfermedad holandesa con la clave y el contenido del 3.B.5 y el 3.B.28.
- **Remisiones** (todas con `\vertema` o `\ref`): 3.B.5, 3.B.6, 3.B.7 (arancel óptimo), 3.B.8 (industria naciente), 3.B.28, 3.A.8 (identidad de Roy), 3.A.11, 3.A.43, 3.A.44. Fuera la autorremisión «[Tema 3.B.9]».
- **Claves del .bib**: las que eligió datos (`GrossmanHelpman1991`, `Romer1990Endogenous`, `Arrow1962Economic`, `Acemoglu2009`, `Gandolfo2014Growth` para el cap. 13); `Young1995` del 3.A.45 en lugar de `Young1995Tyranny` (C35) para no duplicar la obra. Duplicados entre temas para `canon-pendiente.md`: `FrankelRomer1999` (3.A.45) frente a `FrankelRomer1999Does` (datos).
- **Contradicciones con otros temas** (no se tocan):
  - el 3.A.45 (nota 13) conserva las definiciones antiguas de neutralidad que aquí se corrigen (K, contradicción 9);
  - el 3.B.28 escribe la RRI como $p_X/p_M$, frente a $p_X/p_Y$ del canon y de este tema (K, contradicción 1).

- **Bloque II**: notación del 3.A.44 en Romer ($N_t$, $L_I$, $\eta_I$, `eq:romer-gamma` igual que allí) y en las externalidades (`eq:externalidad` del 3.A.44 con el grado de apertura); el 3.A.44 remite aquí los flujos de capital humano en economía abierta (se cumple). Centro-periferia con la notación y el gráfico del 3.B.6 ($\mu$, $\lambda_i$, $\omega_i$, $\phi_\tau$, `tomahawk`). ISI/IOE con la definición de los instrumentos del 3.B.28, que deja aquí la comparación con evidencia. Frankel y Romer con la frase del 3.A.45; Panagariya con «desastres». Baldwin y Forslid (2000), como el 3.B.6 y el 3.B.10.
- **Remisiones nuevas del II y la conclusión**: 3.A.18, 3.A.45, 3.B.10, 3.B.18, 3.B.40.
- **Contradicción para el canon (anotada en `_trabajo/canon-pendiente.md`)**: la revisión del 3.A.44 (V19) y la ficha `grossman-helpman` dicen que la respuesta oficial de 2014 (pregunta 31) «coincide» con el modelo y atribuyen el mecanismo de Stolper-Samuelson al AER de 1990. Aquí (decisión C21 del coordinador): el mecanismo es el de la economía pequeña con 2 factores (WP 2970, 1989; Grossman y Helpman, 1991) y la de 2014 coincide solo en sentido amplio. No se toca el 3.A.44.
- **Otras para el canon**: «especialización perversa» con 2 sentidos (3.B.10 frente al original del 3.B.9, que aquí desaparece); fichas `grossman-helpman`, `difusion-tecnologica` y `prebisch-singer` con el 3.B.9 como «desarrollo»; `difusion` es el gráfico de referencia de su ficha; claves duplicadas (`GrossmanHelpman1991` / `GrossmanHelpman1991Innovation`, `Romer1990Endogenous` / `Romer1990`, `Arrow1962Economic` / `Arrow1962`, `Acemoglu2009` / `Acemoglu2009Introduction`, `Panagariya2004Miracles` / `Panagariya2004`, `RodriguezRodrik2000Trade` / `RodriguezRodrik2000`, `FrankelRomer1999Does` / `FrankelRomer1999`).

## Comentarios de Víctor (10/11/2026, 3.ª tanda)

| Comentario | Cómo se ha aplicado |
|---|---|
| «El párrafo del modelo de Solow en la página 17 sepáralo en 1 párrafo con varios subpárrafos con indentación para que sea más fácil de seguir idea por idea.» | II.1.1 b): la viñeta del modelo de Solow conserva la idea principal (sube el nivel, no la tasa) y debajo cuelgan 3 subviñetas (efecto mayor que el estático, efecto de acumulación a medio plazo de Baldwin (1992), mercado único de Baldwin (1989)); las 2 primeras con un 3.er nivel, una idea por línea. Mismo texto y citas. |

## 7. Dudas abiertas

- **D1 (enganche)**: se usa Corea del Sur, como decidió el coordinador; Ghana sale de la propuesta K1 porque su dato no se comprobó. Las cifras de Corea tienen una sola fuente (Banco Mundial).
- **D4 (imagen 3)**: se suprime el gráfico del bienestar del país pequeño y queda una frase.
- **Vídeo de VisualEconomik** (nota 9): el enlace funciona y se conserva como lectura en una caja; si Víctor prefiere no enlazar divulgación de YouTube, se quita la caja sin tocar el texto.
- **Derivación del bienestar del país grande**: va en una caja gris junto a la ecuación, no en un anexo (es corta y se consulta al leerla). Es la de C11 reescrita con $Y$ como numerario, para que la renta sea la misma $\overline W$ del I.2.1 y la condición quede en términos de $M^A$ y de la caída porcentual de la RRI.
- **Condiciones de Bhagwati**: quedan 4 (C11) en lugar de las 5 del original; «crecimiento débil» desaparece como condición.

- **Aplicadas con la opción recomendada** (dudas del artifact):
  - **B09-01** (enganche): Corea del Sur;
  - **B09-02** (centro-periferia): resumen en el cuerpo y anexo corto con las 5 condiciones;
  - **B09-03** (Grubel): sin la atribución ni el término «especialización perversa»;
  - **B09-04** (imagen 3): suprimida;
  - **B09-05** (test de 2014): se explica en una nota al opositor (coincide solo en sentido amplio; se marca por eliminación).
- **Control de calidad (5/11/2026)**: 7 correcciones de forma (inciso de Rybczynski, «por la práctica», efecto escala, año de VisualEconomik, tablas del informe, recuento de gráficos, pie del gráfico 8 por un fallo del HTML con \eta en el alt).
- **Corea, I+D**: el ejemplo de que Corea «está entre los países que más invierten en I+D en relación con su PIB» va sin cifra (la de la OCDE no se comprobó); si se quiere el dato, OCDE, MSTI.
- **Comisión sobre el Crecimiento (2008)**: el dato de las 13 economías se ha comprobado en resúmenes, no en el informe: sin página.

## Enlaces del original (9/11/2026)

- **Restaurado**: el documento de trabajo de Rivera-Batiz y Romer (NBER WP 3528, `https://www.nber.org/system/files/working_papers/w3528/w3528.pdf`), que el original enlazaba como versión libre del modelo de integración. Va como entrada nueva del `.bib` (`RiveraBatizRomer1990NBER`, con `url` y `urldate`) citada en una nota al pie de «La integración» (\parencite junto a `RiveraBatizRomer1991`, que conserva su DOI).
- **No restaurado, sustituido por la edición vigente**: *World Trade Statistical Review 2023* de la OMC (`wtsr_2023_e.pdf`, enlace con la portada en la introducción). Funciona, pero la OMC dejó de publicarlo y sus datos ya los da *Global Trade Outlook and Statistics* (octubre de 2026), que el tema cita con enlace (`OMC2026PerspectivasOct`). Si Víctor quiere el enlace al de 2023, iría en una nota de la relevancia.
- **Descartados**: el libro de Grossman y Helpman y el artículo de 2015 enlazados como `file:///` (el artículo conserva su DOI en el `.bib`).

## 8. Instrucciones para el vídeo

- **Introducción** (2′30″, `modo: guion`, sin pizarra): tras el título, la pregunta del huevo y la gallina con Corea (2,6 % → 44,4 % de exportaciones sobre el PIB; renta por habitante × 36); la relevancia con el gráfico `fig:comercio-pib-mundial` como **apoyo**; la estructura con los 2 bloques. La idea final de la conclusión tiene que retomar el dicho y responderlo (parte 2).
- **Bloque I** (11′), pizarra en 3 columnas:
  - columna izquierda, **conservada todo el bloque**: `\funcionclave` `eq:importaciones` ($M^A=Y^A_C-Y^A_P$) y la tabla `tab:sesgos` en versión mínima (5 filas, consumo y producción), escrita al terminar el gráfico del consumo;
  - centro, se borra al pasar al II: el gráfico del consumo `fig:consumo` (imprescindible: recta, recta desplazada, vertical, rayo y horizontal por $C_0$, y los 5 tramos de color uno a uno mientras se nombran); el de la producción `fig:produccion` solo si sobra tiempo (si no, como apoyo diciendo que la nomenclatura se invierte); las curvas de oferta neta `fig:ofertas-netas-crecimiento` (imprescindible: ON$_A$, ON$_B$, $E$ y su rayo; después ON$_A'$, $E'$ y el rayo más plano); el gráfico del bienestar del país grande `fig:bienestar-grande`, **por partes**: primero el panel izquierdo (mejora), de apoyo, y luego el derecho (empobrecedor) en la pizarra, capa a capa (FPP$_0$, RRI$_0$, $P_0$, $C_0$, CIS$_0$; FPP$_1$ y la paralela discontinua; RRI$_1$, $P_1$, $C_1$ y la CIS más baja); la `eq:bhagwati` se escribe debajo y se lee término a término; la FPP de Rybczynski (panel izquierdo de `fig:rybczynski`) pequeña, con `eq:rybczynski` debajo;
  - apoyo (no se escribe): la caja de la derivación de `eq:bhagwati`, el panel derecho de `fig:rybczynski`, los tipos de progreso técnico `fig:progreso-neutral` y la tabla `tab:findlay-grubert` (de ella solo se dice la columna del progreso neutral).
  - Pegatinas, junto a su concepto en una esquina: «ir por lana y volver trasquilado» al definir el crecimiento empobrecedor y «morir de éxito» en la enfermedad holandesa.
  - Ejemplo conductor: Corea del Sur vuelve en su propia viñeta en Rybczynski («Volvamos a Corea del Sur…»), con el acero, los barcos y los automóviles; nunca se dice «hilo».
  - Sin números de tema en voz alta («la teoría pura del comercio», «el modelo de Heckscher-Ohlin», «la política comercial»).
- **Bloque II** (15′30″), pizarra:
  - columna derecha, **conservada todo el II.1**: la lista de los 4 mecanismos de Grossman y Helpman (2015); al empezar cada modelo se escribe a su lado el número del mecanismo que ilustra (externalidades, 1; Rivera-Batiz y Romer, 1 y 2; Grossman y Helpman, 3; otros canales, 2; difusión, 4);
  - centro: `\funcionclave` `eq:romer-gamma`, **conservada** hasta el final del II.1; el gráfico de Rivera-Batiz y Romer `fig:rivera-batiz-romer` (imprescindible: hogares, tecnología, equilibrio y, en capa nueva, la recta con $2L$ y el nuevo equilibrio); el de las externalidades `fig:externalidades-apertura` (recomendado) con `eq:externalidad-apertura` debajo; la cadena de Grossman y Helpman en 2 flechas («arancel sobre el tradicional ⇒ $w_L\uparrow$, $w_H\downarrow$ ⇒ I+D más barata ⇒ $\gamma\uparrow$»); el gráfico de la difusión `fig:difusion` pequeño;
  - II.2: la tabla `tab:isi-ioe` en versión mínima (las 2 columnas y 4 filas), recomendada; Thirlwall, de palabra o en una línea;
  - apoyo (no se escribe): el *tomahawk* `fig:tomahawk`, la caja del test de Grossman y Helpman, los anexos;
  - II.4 sin pizarra: guion con la dificultad (huevo y gallina) y los 3 bloques de evidencia;
  - pegatinas, junto a su concepto: «todo se pega menos la hermosura» (externalidades), «no hay que reinventar la rueda» (redundancia), «todo depende del cristal con que se mira» (Grossman y Helpman), «de fuera vendrá quien de casa nos echará» (efecto competencia), «quien no se arriesga no pasa la mar» (IOE);
  - Corea vuelve 2 veces en su viñeta: de imitar a innovar (difusión) y la IOE desde los 60 (11 % → 44 % de exportaciones sobre el PIB).
- **Conclusión** (1′, `modo: guion`, sin pizarra): empieza por «En conclusión,»; recapitulación en 3 ideas, relevancia con las caídas del comercio de 2009 y 2020, extensiones sin números de tema, opinión (condición necesaria, no suficiente) e **idea final**: «¿qué fue antes, el huevo o la gallina?… ninguno de los 2, porque se alimentan el uno al otro». Es la última frase; nada de agradecimientos.

Autor: Víctor Gutiérrez Marcos
