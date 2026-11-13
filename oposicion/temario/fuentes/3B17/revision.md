# Revisión del 3.B.17: Teorías explicativas de las crisis de balanza de pagos

11/11/2026. Fuente: `3B17.tex` (escrito en 2 partes: introducción y I; II, III, conclusión y anexos), `3B17.bib` (84 entradas, todas citadas), `seo.json`, `datos-actualizables.yaml` (7 datos) y `_trabajo/graficos-pedidos.json` (4 gráficos). Original: Word de Víctor (PDF publicado de 35 páginas, «última actualización 10/08/2024»).

## 1. Resumen

- El tema pasa de 4 apartados a 3 (opción B ajustada): **I. Crisis cambiarias: primera y segunda generación** (11′), **II. Tercera generación: crisis gemelas** (9′) y **III. Contagio, predicción y ¿cuarta generación?** (6′30″), con introducción de 2′30″ y conclusión de 1′ (30′).
- Las 3 generaciones tienen ya su modelo escrito con la notación del canon y una función clave cada una: el momento del ataque de Flood y Garber (1984), la cláusula de escape de Obstfeld (1996, sección 3) y la condición de colapso de Krugman (1999); las derivaciones, paso a paso, en el anexo A.
- Se añaden los 4 epígrafes que faltaban: paradas súbitas y pecado original (II.2.3), evidencia y valoración de la tercera generación (II.3-II.4, con la tabla de las 3 generaciones), capacidad de predicción (III.4) y ¿cuarta generación? (III.5); la introducción y la conclusión tienen sus 5 bloques.
- Corregidas las atribuciones erróneas (riesgo moral, nota 7, Kaminsky y Reinhart, Van Rijckeghem y Weder, Reinhart y Rogoff, «Sahuquillo»), el error de la «esterilización» y las cifras (Grecia, Soros); México 1994 se lee como crisis mixta.
- Diamond y Dybvig queda en mención en II.2.1 y en un anexo corto (B) con el gráfico del 3.A.10; 4 gráficos de teoría y datos en TikZ/pgfplots (3 hechos por la fase de gráficos, `hojas-balance` pedido).

## 2. Errores corregidos

| Dónde | Decía | Dice ahora |
|---|---|---|
| Introducción, enganche | Reinhart y Rogoff (2011) | 2009 (Princeton UP; la traducción del FCE es de 2011) |
| Contextualización | Reinhart y Rogoff (2008), «desde el siglo XIII» | 2009, con datos desde los impagos de Inglaterra del siglo XIV |
| I.1 Implicaciones | El modelo se ajusta a la ruptura de Bretton Woods | Se mantiene que Bretton Woods motivó el modelo (Krugman, 2001, p. 1, comprobado); el antecedente es Salant y Henderson (1978), sobre el oro, y la falta de efectos reales pasa a la valoración |
| I.1 Desarrollo | El banco central «esteriliza» la pérdida de reservas | Con tipo fijo la pérdida de reservas es automática ($\Delta R=-\Delta\mathrm{CI}$); la esterilización pasa a extensiones (Flood, Garber y Kramer, 1996) |
| I.1, gráfico | «Fuente: Sahuquillo» (no es una publicación) | «Elaboración propia a partir de Krugman (1979) y Flood y Garber (1984)» |
| I.1, supuestos | Multiplicador $(e+1)/(e+q)=1$; $e$ y $\tilde e$ | «Multiplicador igual a 1» sin letras; $\tilde E$, $\bar E$, $M^S_t=\mathrm{CI}_t+R_t$ |
| I.1 Idea | Volcker, 1980-1982 | 1979-1982 |
| Título de I.2 | «Obstfeld, Calvo y Jeanne» | «Obstfeld, 1994, 1996»; Calvo (1988) es la deuda y Calvo (1998) las paradas súbitas; Jeanne (2000), síntesis |
| I.2 Modelo | $L_{flex}=\frac{\alpha+\alpha^2}{(1+\alpha)^2}X^2$; «$Y^*-Y$» / «$Y-Y^*$»; $\pi^e>0$ «sin valor» en el cielo | $\frac{\gamma}{1+\gamma}X^2$; brecha $Y^{\mathrm{obj}}-Y$; las 3 regiones con $x_1$ y $x_2$ |
| I.2 Notación | α peso de la inflación (choca con la α de Krugman); $K$ brecha (choca con el capital); $Y^*$ objetivo; $Y_{TNP}$ | γ, $\Delta\equiv Y^{\mathrm{obj}}-Y^n$, $Y^{\mathrm{obj}}$, $Y^n$ |
| I.2 Implicaciones | Kydland-Prescott y Barro-Gordon «[ver tema 3.A.6]» | `\vertema{3.A.36}` (tema de referencia de `barro-gordon`) |
| I.2 Idea | Reunificación alemana «a finales de los 80» | 1990 |
| I.2 Evidencia | Soros «convirtió 10.000 millones de libras en marcos» | Sin cifra (no hay fuente primaria): los fondos que apostaron contra la libra, con el de Soros a la cabeza, ganaron |
| I.2 Evidencia | México 1994 como segunda generación pura | Crisis mixta, desarrollada en II.2.3 c) |
| I.1 Valoración | Crítica de Hélène Rey al modelo de primera generación | Es una crítica al trilema: pasa a III.5 |
| II.1 Idea | «Apertura brusca de la cuenta corriente y financiera» | La corriente ya estaba abierta: apertura de la cuenta financiera |
| II.2.1, título | Riesgo moral «(Hausmann y Eichengreen)» | McKinnon y Pill (1998), Krugman (1998, «What happened to Asia?») y Corsetti, Pesenti y Roubini (1999); Chang y Velasco (2001) para la iliquidez |
| II.2.2 | «XN» exportaciones netas; ϰ; β; $D$, $D^*$ | $X$ exportaciones (dadas, en bien extranjero); $q$; $m$; $B$, $B^*$ (nota con las letras de Krugman) |
| II.2.2 | Tramos «i, i, ii» | i), ii), iii) |
| II.2.2 | «Stiglitz (2000)» (no localizado como obra académica) | Furman y Stiglitz (1998), *BPEA*, la crítica a los tipos altos en Asia |
| Nota 7 | «Currency mismatches…» de Eichengreen y Hausmann | De Eichengreen, Hausmann y Panizza (2003, NBER WP 10036), integrada en II.2.3 b) iii) |
| III.1 | «Reinhart y Kaminsky (2000)» | Kaminsky y Reinhart (2000), *JIE* |
| III.2 | «Kaminsky y Reinhart (1998)» (prestamista común) | Kaminsky y Reinhart (2000) |
| III.2 | Van Rijckeghem y Weder (1999); Rusia: «Alemania» | 2001 (*JIE* 54(2)); «bancos europeos» (lo que dice el artículo) |
| III.1 | Calvo y Reinhart (1996) | Es **Sara** Calvo (Banco Mundial), no Guillermo: la cita lo distingue |
| Anexo B | Grecia: «50.000 millones en el primer semestre de 2015» | Unos 40.000 millones (mismas fuentes que el 3.A.10) |
| Anexo B (nota 24) | FGD «vía presupuestos (caso alemán)» | Sale con el anexo resumido (en la UE los financian las entidades; lo cuenta el 3.A.10) |
| Erratas (C47) | «este tan depreciado», «es imposible que… es imposible que», «dejando fluctuarla», «modelos del cuarta generación», «endogeneiza», «Credito Interno», «siguiente supuestos», «Asignación de tras» | Corregidas o desaparecen con el texto rehecho |

## 3. Marcas resueltas

| Marca | Qué se hizo |
|---|---|
| P1 (tabla vacía en «Estructura») | Escrita la Estructura (3 apartados y por qué ese orden) y la caja `esquema` |
| P2-P3 (notas al opositor del cambio de temario y tabla del tribunal) | Quitadas; la guía del tribunal sirvió para añadir III.4 y III.5 |
| P4 (comentario «no me acuerdo de dónde he sacado este modelo») | Fuente localizada: Obstfeld (1996, sección 3), con la presentación de Jeanne (2000); no se publica el comentario |
| P5 (comentario «lo importante es la intuición») | En el cuerpo, resultados y gráfico; la derivación, al anexo A |
| P6 (comentario «coordinar 3.A.10, 3.B.17 y 3.B.27») | Diamond y Dybvig en mención (II.2.1) y anexo B corto con el gráfico del 3.A.10 copiado sin cambios |
| P7 («NOTA:» en el desarrollo de Flood y Garber) | Integrada: en $T$ cae la cantidad de dinero porque sube el tipo de interés esperado |
| P8 (qué no se canta) | Anexos A-C, la caja gris de la derivada de Krugman y las notas al pie |
| P9 (portada de *This Time Is Different*) | Quitada (derechos de la cubierta); queda la cita |
| P10, P11, P16 (gráficos de teoría) | `primera-generacion`, `segunda-generacion-regiones` y `hojas-balance` en TikZ (el último, pedido) |
| P12, P45 de C (tabla «Justificación en 3 pasos») | Sustituida por `tab:tres-generaciones` (tabla de clasificación con color); los «pasos» ya están en cada «Idea» |
| P13 (ecuaciones en tablas de Word) | `equation` con etiqueta; la derivada, en caja gris |
| P14 (4 imágenes escaneadas del anexo) | Fuera; el anexo B usa el gráfico TikZ del 3.A.10 |
| P15, P58 (captura de preguntas y enlace a quia.com) | Anexo C con el enlace único al simulador. Las 7 preguntas oficiales que el simulador asigna al 3.B.17 (2024 n.º 35; 2023 n.º 34; 2019 n.º 32; 2011 n.º 29; 2006 n.º 28; 2003 n.º 38 y 39) se responden con el tema revisado; la de «México años 80» (2011 n.º 35) es de otro tema |
| P17 (gráfico de datos) | `crisis-frecuencia` (Laeven y Valencia, 2020) en la relevancia |
| P18 («[ver Imagen 2]», «[ver anexo A.1]») | `\ref` |
| P56 (comentarios y notas privadas) | No se publican |
| P57 (bibliografía: «Tema Juan Luis Cordero Tarifa») | Fuera (tema de otro preparador); Sims (2019) se queda en el anexo B |
| P59 (forvo en el título de I.2) | Fuera (decisión del coordinador): pronunciaciones de apellidos, no contenido |
| P60 (Wikipedia: manchas solares y *Great Contraction*) | Conservados: nota 17 (manchas solares) y anexo B (Gran Contracción) |
| P61 (cita de Bernanke) | No se copia la cita (está en el 3.A.5); el anexo B dice que Bernanke dio la razón a Friedman y Schwartz, con `Bernanke2002Friedman` |

**Notas al pie del original**: 1 (parada súbita), al cuerpo (introducción y II.2.3); 2 (convención del tipo de cambio), a la contextualización; 3 (solo intervención), reescrita como supuesto; 4 (momento del ataque), reescrita como nota y el ejemplo numérico al anexo A; 5 (peseta y escudo), al texto de III.2; 6 (causalidad no unidireccional), a los 3 nexos de II.1; 7, al cuerpo con sus autores; 8 y 20 (Nobel 2022), una sola, con Bernanke, en II.2.1 (con el enlace de la Fundación Ramón Areces vía `Repullo2022Nobel`); 9 (descalce de plazos), nota en II.2.1 con `\vertema{3.B.11}`; 10 (derivada), caja gris; 11 y 12, notas en II.2.2; 13 (definición de contagio), nota en III.1; 14 (contagio en la UE), quitada (lo cubre III.3 con remisión); 15 (Uruguay), nota con el enlace de *El Economista*; 16 (Schinasi y Smith), nota; 17 (manchas solares), nota con el enlace; 18 (BNP Paribas «una semana antes»), quitada (no comprobada; queda la congelación del 9/8/2007 en el texto); 19 (*doom loop*), quitada con `\vertema{3.B.16}` `\vertema{3.B.44}`; 21-25 (anexo), salen con el anexo resumido.

## 4. Datos actualizados

Consultas del 11/11/2026 (fase de datos; detalle y URL en `_trabajo/propuestas-datos.md`).

| N.º | Dato | Antes | Ahora | Fuente | Segunda comprobación | Aplicado |
|---|---|---|---|---|---|---|
| V1 | Libro de Reinhart y Rogoff | 2011 | 2009 | `ReinhartRogoff2009This` (doi 10.1515/9781400831722) | Crossref | Sí |
| V2 | Arranque de los datos | siglo XIII | siglo XIV, 66 países, 8 siglos | idem | NBER WP 13882 | Sí (siglo XIV, decisión del coordinador) |
| V3 | Crisis cambiarias por década | sin cifra | 25 / 74 / 84; máximo de 20 en 1994; 151 bancarias y 236 cambiarias en 1970-2017 | `LaevenValencia2020` (fichero MOESM1) | pestaña «Crisis Years» y réplica `stevedata::SBCD` | Sí (y gráfico) |
| V4 | Fechas de Rusia, Brasil, Turquía | — | años de L-V | `LaevenValencia2020` | IEO-FMI (Argentina) | Sí, solo años |
| V5 | Atribución de las «generaciones» | ERW (1995) | se mantiene ERW (1995) | Krugman (2001), p. 1 | — | **No** la frase neutra: la atribución se comprobó |
| V6 | Volcker | 1980-1982 | 1979-1982 | conocimiento general | — | Sí |
| V7 | Origen del modelo | Bretton Woods | Salant y Henderson (1978) → Krugman (1979) | Crossref | — | Sí (con Bretton Woods como motivación) |
| V8 | México 1973-1982 | sin fuente | Blanco y Garber (1986): devaluaciones de 1976 y 1982 | `BlancoGarber1986` | L-V | Sí |
| V9 | Reunificación | finales de los 80 | 1990 | `EichengreenWyplosz1993Unstable` | — | Sí |
| V10 | Soros | 10.000 M£ | sin cifra | `BoE1992Operation` para la fecha | 3.B.16 | Sí, sin cifra |
| V11 | México 1994-1995 | — | PIB de 1995 −5,9 % | `FMI2026WEOdatos` | WDI −5,9 % | Sí (sin días de la devaluación) |
| V12 | Argentina y Uruguay 2001-2002 | 2002 | impago dic. 2001, fin de la convertibilidad ene. 2002; PIB −10,9 % y −7,7 % | `FMI2004IEOArgentina`, `FMI2026WEOdatos` | L-V, WDI | Sí |
| V13 | Tailandia | sin fecha | bat 2/7/1997; rupia 14/8/1997 | `FMI1997WEOdic` (cap. III) | L-V | Sí |
| V14 | PIB 1998 Asia | — | −13,1 / −7,6 / −7,4 / −4,9 % | `FMI2026WEOdatos` | WDI (iguales) | Sí |
| V15 | Rusia → Brasil | — | 1998 → 1999 | `LaevenValencia2020` | — | Sí, sin cifras de PIB |
| V16 | Grecia 2009 | — | sin cifra, remisión | — | — | Sí |
| V17 | BNP Paribas | «una semana antes» | 9/8/2007, sin la frase no comprobada | — | — | Sí; el importe del BCE (94.841 M€) **no** se pone: la nota de prensa no se pudo abrir (404) |
| V18 | Grecia 2015 | 50.000 M€ | unos 40.000 M€ | `BCE2026BSIGrecia`, `BIS2017Stournaras` | 3.A.10 | Sí |
| V19 | FGD | 100.000 €, «caso alemán» | — | — | — | No aplica: el anexo B no da la cifra |
| V20 | Turquía 2018 | — | −28 % frente al dólar | `BCE2026EXR` | `BIS2026XRU` (no del todo independiente) | Sí |
| V21 | Argentina 2018, 2023 y 2025 | — | −50 %, 56.300 M$; 366,5 → 800; 20.000 M$ | `FMI2018PR395`, `BIS2026XRU`, `FMI2025PR101` | BIS M.AR.ARS.E | Sí |
| V22 | Grecia (cierre de bancos) | — | finales de junio de 2015 | V18 | — | Sí |
| V23 | Templeton | «las 4 palabras más caras» | — | solo secundarias | — | **No**: no comprobada en el libro (decisión del coordinador) |
| V24 | Nobel 2022 | — | Bernanke, Diamond y Dybvig | `Repullo2022Nobel` | nobelprize.org | Sí |
| V25 | Preguntas de test | — | — | `preguntas.json` | — | Ver P15 |
| — | Riksbank | — | 500 % el 16/9/1992; corona flotante el 19/11/1992 | `Riksbank2026Ranta500` | — | Sí (I.2 iii) |
| — | Kaminsky y Reinhart (1999) | — | 76 cambiarias y 26 bancarias, 1970-1995 | `KaminskyReinhart1999` | fase de contenido | Sí (II.3) |
| — | Tailandia, déficit corriente | — | ≈8 % del PIB en 1995-1996 | `FMI1997WEOdic` | 3.B.12 | Sí (II.3) |

Referencias comprobadas además en Crossref el 11/11/2026 por esta fase: Cole y Kehoe (1996), de la Plaza y Sirtaine (2005), Dornbusch, Goldfajn y Valdés (1995), Eichengreen y Gupta (2015), Frankel y Saravelos (2012), Furman y Stiglitz (1998), Radelet y Sachs (1998), Masson (1998, IMF WP 98/142), Merler y Pisani-Ferry (2012, página de Bruegel) y Krugman (1998, página del MIT). Los enlaces del original: eleconomista.com.ar y las 2 de Wikipedia responden (200); el de Sims redirige a academicweb.nd.edu, que da 403 a clientes automáticos (comprobar en un navegador).

## 5. Contenido añadido

- **Introducción**: definiciones de crisis de balanza de pagos y sus 4 formas, ataque especulativo, tipo sombra, contagio, índice de presión cambiaria (ERW, 1995); convención del tipo directo; historia en oleadas; las generaciones con sus autores; problemática; estructura; gráfico `crisis-frecuencia` (Laeven y Valencia, 2020).
- **I.1**: Krugman (1979) como modelo fundacional (Salant y Henderson, 1978); el modelo lineal completo; extensiones (incertidumbre, esterilización); evidencia de México, Argentina y Bretton Woods (Blanco y Garber, 1986; Cumby y van Wijnbergen, 1989; Garber, 1993); dominación fiscal (Sargent y Wallace, 1981).
- **I.2**: el modelo de la cláusula de escape con 3 regiones; el coste de defender la paridad con la PNCI con prima y el Riksbank (500 %); el juego de 2 especuladores de Obstfeld (1996, sección 2) con las 3 matrices; juegos globales (Morris y Shin, 1998); Obstfeld (1986); Calvo (1988); Jeanne (1997).
- **II.1**: los 3 nexos entre la crisis bancaria y la cambiaria (idea del tema de Miquel Tebar, redactada de nuevo; anotado aquí, no en el tema).
- **II.2.1**: rescates como deuda pública oculta (Corsetti, Pesenti y Roubini, 1999; Burnside, Eichenbaum y Rebelo, 2001); iliquidez internacional (Chang y Velasco, 2001) con la mención de Diamond y Dybvig.
- **II.2.2**: supuestos y ecuaciones con la notación del canon, la espiral en 4 pasos, la caja con la derivada, los 3 equilibrios con gráfico, prevención término a término.
- **II.2.3 (nuevo)**: paradas súbitas (Calvo, 1998; Dornbusch, Goldfajn y Valdés, 1995; Calvo, Izquierdo y Mejía, 2004), pecado original (Eichengreen y Hausmann, 1999; Eichengreen, Hausmann y Panizza, 2003 y 2005), miedo a flotar (Calvo y Reinhart, 2002), intolerancia a la deuda (Reinhart, Rogoff y Savastano, 2003) y México 1994-1995 como crisis mixta (Sachs, Tornell y Velasco, 1996; Cole y Kehoe, 1996; Calvo y Mendoza, 1996; Flood, Garber y Kramer, 1996).
- **II.3 y II.4 (antes una línea y vacía)**: Tailandia, crisis gemelas (Kaminsky y Reinhart, 1999), caídas del PIB, Radelet y Sachs (1998) frente a Corsetti, Pesenti y Roubini (1999), Turquía y Argentina recientes; valoración con Aghion, Bacchetta y Banerjee (2001) y la tabla de las 3 generaciones.
- **III.1-III.3**: definición y choques comunes (Masson, 1998), evidencia de contagio (Forbes y Rigobon, 2002; Eichengreen y Gupta, 2015), Uruguay con fuente del Banco Mundial (de la Plaza y Sirtaine, 2005).
- **III.4 (nuevo)**: señales (Kaminsky, Lizondo y Reinhart, 1998), probit (Frankel y Rose, 1996), fracaso fuera de muestra (Berg y Pattillo, 1999) y acierto en 2008-2009 (Frankel y Saravelos, 2012), indicadores de vulnerabilidad, ejercicio FMI-FSB (FMI, 2010). Rose y Spiegel (2011), que proponía K21, no se usa: Frankel y Saravelos da un resultado más útil y comprobado.
- **III.5 (nuevo)**: Krugman (2001), 2007-2008, el euro y TARGET (Merler y Pisani-Ferry, 2012), el dilema de Rey (2013), las instituciones (Breuer, 2004; viñeta de la conclusión del original) y la respuesta (red de seguridad, macroprudencial, visión institucional del FMI, 2012).
- **Conclusión**: Relevancia, Extensiones y Opinión (vacías en el original); las 3 conclusiones del original pasan a la Opinión; la idea final retoma el refrán y responde la pregunta del enganche.
- **Anexos**: A (derivaciones de Flood y Garber, con el ejemplo numérico del gráfico, y de la cláusula de escape, con `\findemo`), B (Diamond y Dybvig, corto, con el gráfico del 3.A.10 copiado a `graficos/diamond-dybvig.tex` sin cambios) y C (test).

### Propuestas de contenido (C1-C47)

| Propuesta | Estado |
|---|---|
| C1 | Aplicada; cambiadas 2 pegatinas: «a perro flaco todo son pulgas» (3.A.43) y «quien avisa no es traidor» (3.A.36) están cogidas; se usan «tanto va el cántaro a la fuente…», «la fe mueve montañas», «no hay dos sin tres» y «no es la velocidad lo que mata, es la parada súbita» |
| C2 | Aplicada con $Y^{\mathrm{obj}}$, $Y^n$ en mayúscula (canon § 1), no en minúscula |
| C3 | Para la fase canon (fichas nuevas `flood-garber`, `obstfeld-segunda-generacion`, `krugman-hojas-balance`, `paradas-subitas`) |
| C4-C9 | Aplicadas (C6 con `LaevenValencia2020` y «varias veces» para la peseta; C7 con la atribución a ERW, 1995, comprobada) |
| C10-C13, C15 | Aplicadas (C10 con $M^S_t$ y el tipo sombra en `equation`, no recuadrado) |
| C14 | Aplicada con la extensión de la esterilización reescrita (Flood, Garber y Kramer pasan a un modelo de cartera; no «el ataque llega en cuanto se agotan las reservas») |
| C16 | Aplicada sin la ampliación de las bandas al ±15 % de agosto de 1993 (sin fuente en el `.bib`) |
| C17-C22 | Aplicadas (C21 sin la cifra de Soros) |
| C23 | Aplicada con «no hay dos sin tres» en lugar de «a perro flaco…» y con `\vertema{3.B.18}` en la apertura financiera |
| C24 | Aplicada con `McKinnonPill1998` (comprobado) en lugar de McKinnon y Pill (1996, no comprobado), y con la estructura a) Idea, b) Modelo (i-iii) |
| C25 | Aplicada (+ «menos predecibles» y «para paliar», del original, una sola vez: C46) |
| C26 | Pedido el gráfico; sin los rótulos $U_E$, $H_E$ |
| C27 | Aplicada (caja gris con `\findemo`) |
| C28 | Aplicada como modelo con a) Idea, b) Modelo (i-iii) y c) Evidencia, en lugar de «a) Paradas súbitas, b) Pecado original» (los a)-e) se reservan para los bloques de un modelo); claves `STV1996Lessons`, `CIM2004SuddenStops`, `Reinhart2003Intolerancia` (la de `ReinhartRogoffSavastano2003Debt` era la misma obra) |
| C29 | Aplicada; `BoT2026TomYumKung` (no existe) sustituida por `FMI1997WEOdic` |
| C30 | Aplicada con `BER2001Prospective` y `ABB2001Currency` |
| C31 | Aplicada; Masson con el WP del FMI de 1998 (comprobado; el capítulo de 1999 es la misma obra) |
| C32 | Aplicada; Schinasi y Smith con `SchinasiSmith2001` (Claessens y Forbes, eds., 2001), como el original; la versión de *IMF Staff Papers* (2000) es la misma obra |
| C33 | Aplicada **sin** la cifra del BCE (94.800 M€): la nota de prensa no se pudo comprobar |
| C34 | Aplicada |
| C35 | Aplicada; Merler y Pisani-Ferry con fecha y URL de Bruegel |
| C36 | Aplicada sin Sri Lanka (no comprobado) y sin Templeton |
| C37 | Aplicada (`crisis-frecuencia`, decisión del coordinador) |
| C38 | Opción (a): anexo corto con el gráfico copiado y $t=0,1,2$ |
| C39 | Aplicada, con el ejemplo numérico completo |
| C40 | Aplicada (ver «Notas al pie» arriba) |
| C41 | Anexo C con el enlace; la lista de 7 preguntas queda en este informe (CRITERIOS: solo el enlace genérico) |
| C42 | Aplicada (forvo fuera; Cordero fuera; Sims en el anexo B) |
| C43 | Aplicada (7 entradas) |
| C44-C47 | Aplicadas |

## 6. Coherencia

### Propuestas de coherencia (K1-K30)

| Propuesta | Estado |
|---|---|
| K1 | Aplicada: los epígrafes de la guía del tribunal (predicción, cuarta generación) están en III.4-III.5 |
| K2 | Aplicada (estructura B ajustada, títulos y etiquetas). Los cortes de título de II.2.1, II.2.2, III y III.4 se quitaron: caben en una línea (comprobado en el PDF) |
| K3-K4 | Aplicadas (la `notaopositor` añade las pegatinas y no menciona el anexo B) |
| K5 | Aplicada con la atribución a ERW (1995) en vez de la frase neutra |
| K6-K9, K11-K14 | Aplicadas (K12 con las 3 matrices de Obstfeld, 1996) |
| K10 | Aplicada con $Y^{\mathrm{obj}}$, $Y^n$ y $\Delta E/E=\pi$ en vez de $\gamma_E=\pi$ (para no juntar 2 γ) |
| K15-K16 | Aplicadas (nota con las letras de Krugman; sin $U_E$, $H_E$) |
| K17 | Aplicada con `FMI1997WEOdic` |
| K18-K22 | Aplicadas (K21 con Frankel y Saravelos en vez de Rose y Spiegel; K22 sin las «3 semejanzas y 2 diferencias» de Tebar) |
| K23 | Aplicada sin Templeton ni Sri Lanka |
| K24 | Aplicada salvo `tab:contagio-canales` (árbol de canales): no se crea; la jerarquía de III.2-III.3 (a/b, i/ii) ya es el árbol, y se propone como apoyo del vídeo |
| K25-K28 | Aplicadas (K27 con anexo corto; remisiones de K28 detrás de la idea, más `\vertema{3.B.18}`) |
| K29 | Aplicada (ver «Notas al pie») |
| K30 | Aplicada con las claves de `bib-datos.bib` cuando había 2 para la misma obra (`FloodGarber1984`, `KLR1998Leading`, `ForbesRigobon2002`…); `Krugman1998Asia` y no `Krugman1998What` |

### Contradicciones con otros temas (no se tocan)

1. **3.B.19** (en revisión, `3B19.tex` l. 319): llama «modelos de coordinación de segunda generación» a los NOEM; choca con las generaciones de crisis de este tema. Propuesta para el 3.B.19: «con microfundamentos (NOEM)» o un aviso.
2. **`Krugman1998What`** (3.B.6) es «What's new about the new economic geography?»; «What happened to Asia?» es `Krugman1998Asia` aquí. Conviene que ningún tema use la primera para Asia.
3. **Diamond y Dybvig con 2 claves**: `DiamondDybvig1983Bank` (3.A.10 y aquí) y `DiamondDybvig1983` (1D01), misma obra: unificar en la fase canon. El 3.A.10 escribe los periodos $T=0,1,2$; aquí $t=0,1,2$, porque $T$ es el momento del ataque (el gráfico copiado no rotula los periodos).
4. **3.B.21** (Word sin revisar): México 1994 como «primera generación», Rusia 1998, Brasil 1999 y Argentina 2001-2002 como «tercera». Lectura propuesta: México, mixta (II.2.3 c); usar `tab:tres-generaciones` sin clasificar sin matiz.
5. **3.B.14** (l. 163): «cuando las reservas se agotan, el tipo fijo cae si $\tilde E>\bar E$»; aquí el ataque se adelanta al agotamiento (cosmético; propuesta en `propuestas-coherencia.md` § 7).
6. **3.B.16**: rótulos 0, 1, 2, 3, F del gráfico de Barro-Gordon frente a R, T, D del canon.
7. **3.B.15** (en revisión): que remita el pecado original también al 3.B.17 (papel en las crisis), no solo al 3.B.11; misma clave `EichengreenHausmann1999`.
8. **Canon contra sí mismo**: § 9 de `notacion.md` escribe $Y_n$ y § 0-§ 1, $Y^n$; se aplica $Y^n$. Proponer en `canon/pendientes-coherencia.md` corregir la fila de § 9 (y `_notacion/macro-abierta.md`, fila 15). La fila α de `_notacion/macro-abierta.md` es contradictoria: aquí γ para el peso de la inflación y α para la participación del capital.
9. **3.B.22** (Word sin revisar): no remite al 3.B.17; al revisarlo, que la respuesta del FMI en Asia coincida con II.2.2 iii) (crítica a la subida de tipos).
10. **3.B.26** (sin fuente): tendrá que cubrir las crisis gemelas desde el lado bancario, Diamond y Dybvig en desarrollo y la crisis de 2007-2008, que aquí solo se mencionan.

### Promesas de otros temas, cumplidas

3.A.14 (juego de coordinación: I.2 c y tabla), 3.A.22 (entradas masivas con sistemas débiles: II.1 y II.3), 3.A.32 (`Krugman1979Model` y el dilema del régimen: I.1), 3.A.39 (monetización con tipo fijo: I.1), 3.B.11 (ataque antes de agotar reservas, parada súbita, pecado original, `KaminskyReinhart1999`, `Obstfeld1996`: I.1, II.2.3, II.3, I.2), 3.B.12 (América Latina, Asia y el euro; Tailandia ≈8 %; `Krugman1979Model`; México con tesobonos: introducción, I.1, II.2.3, II.3, III.5), 3.B.13 (Soros, PNCI con prima, pecado original, peso de 1976: I.2, II.2.3, I.1), 3.B.14 ($\tilde E$, $\bar E$: I.1), 3.B.16 (16/9/1992, peseta, expectativas, «la crisis cambiaria que una unión evita»: I.2, III.5).

## Puesta al día con las reglas de esta rama (13/11/2026)

Tema traído de la rama `revision-temario`; puesto al nivel de los temas de `revision-temario-2` sin quitar contenido. PDF construido con `--solo pdf --no-publicar` (25 páginas de tema, 4 de anexos, 6 de bibliografía); `verificar-tema.py` sin errores propios (solo los de «anterior a la fuente» del PDF, HTML y Word publicados).

| Regla | Cómo se ha aplicado |
|---|---|
| Citas (5.ª tanda) | 78 `\parencite` → `\nocite` con `quitar_citas.py`. En la introducción, la lista de generaciones perdía sus autores al quitar las citas: se dicen en el texto («de \autor{Krugman} (1979) y \autor{Flood} y \autor{Garber} (1984)»…). Frases revisadas; ninguna queda coja. `\textcite` solo de obras originales. |
| Plantilla (7.ª tanda) | Anexo de test con la caja estándar (`tema=3.B.17`); fuera `GutierrezMarcos2026Simulador` del `.bib`. `tcefecha` a 13/11/2026. Títulos: «Segunda generación: crisis autocumplidas» con `\cortetitulo` antes de los autores (como la primera) y el anexo A acortado a «Anexo: derivaciones de las 2 primeras generaciones» (una línea); `verificar-tema.py` ya no avisa. |
| Gráfico / Figura / Imagen | Los 5 son gráficos (ejes, curvas o datos); no hay figuras ni imágenes. |
| Pegatinas y dichos (8.ª tanda y revisión transversal) | Fuera las 4 etiquetas «Pegatina:». Se quedan, integrados en la frase: el refrán del enganche («Nadie escarmienta en cabeza ajena», que vuelve en la idea final), «tanto va el cántaro a la fuente que al final se rompe» (la pérdida diaria de reservas hasta el ataque) y la frase de los banqueros que citan Dornbusch, Goldfajn y Valdés (1995), «no es la velocidad lo que mata, es la parada súbita». Fuera «la fe mueve montañas» (segunda generación: la creencia no mueve nada, la profecía se cumple sola; puede confundir) y «no hay dos sin tres» (crisis gemelas que «son triples»: forzado). Ninguno venía del tema antiguo. `notaopositor` y vídeo, al día (duda 19). |
| Resultados clave en morado | Ya estaban `eq:momento-ataque`, `eq:escape` y `eq:krugman-condicion`; no se añaden más. |
| Estructura a)-e) | Primera y segunda generación, completas. A los 3 modelos de la tercera generación les faltaba la valoración: se añaden «c) Valoración» al riesgo moral y a las hojas de balance y «d) Valoración» a las paradas súbitas (tras su evidencia), breves y escritas para enlazar con el modelo siguiente (riesgo moral → hojas de balance → paradas súbitas → contagio). La valoración de conjunto de II.4 se mantiene. |
| Pasos con sangría | Las 2 «intuiciones en 3 pasos» (primera y tercera generación): el rótulo del paso en su viñeta y su contenido debajo, un nivel más adentro. |
| Términos en inglés | Añadidos la primera vez: *sudden stop*, *twin crises*, *speculative attack*, *shadow exchange rate*, *exchange market pressure index*, *escape clause*, *time inconsistency*, *global games*, *moral hazard*, *original sin*, *fear of floating*, *debt intolerance*, *monsoonal effects*, *common lender effect*, *sunspots*, *early warning systems* (con una frase de definición nueva al principio de III.4). |
| Nobel (revisión transversal) | Nota con el motivo oficial en la primera mención: Krugman (2008, en la lista de generaciones de la introducción, con su papel en el tema: 1.ª, 3.ª y la pregunta por la 4.ª), Sargent (2011, dominación fiscal), Lucas (1995, oferta de Lucas), Kydland y Prescott (2004, inconsistencia temporal, ahora nombrados en el texto), Nash (1994, juego del ataque), Stiglitz (2001, crítica a la receta del FMI), Friedman (1976, anexo de pánicos). La nota de Bernanke, Diamond y Dybvig (2022) ya existía: ahora cita `Nobel2022Bancos` además de Repullo (2022). Entradas copiadas: `Nobel1976Friedman`, `Nobel1994Nash`, `Nobel1995Lucas`, `Nobel2001AkerlofSpenceStiglitz`, `Nobel2004KydlandPrescott`, `Nobel2008Krugman`, `Nobel2011SargentSims`, `Nobel2022Bancos`. |
| 4.º ejercicio | Añadidos `\vertema{4.A.27}` (devaluaciones de la peseta de 1992-1993), `\vertema{4.A.28}` (parada súbita de la periferia en 2010-2012) y `\vertema{4.A.21}` (saldos TARGET). |
| Pizarra, vídeo, «lo que se suele preguntar», enlaces a otros formatos | No había ninguno. |
| NEK en (x, π), identidad cuantitativa | No salen (la demanda de dinero de Flood y Garber es una función de demanda, no la teoría cuantitativa). |
| Ficha de repaso | El tema no tiene ficha (`repaso/` no existe); no se crea en esta puesta al día. |

## Ficha de repaso (13/11/2026)

Nueva: `repaso/3B17-repaso.tex`, con la estructura de las fichas del bloque (3B13, 3B28): esquema del cante con minutos e indicaciones de pizarra (solo en la ficha), introducción con sus 5 bloques, los 3 apartados con idea clave, subapartados con etiquetas `rep:`, conclusión, autores y fechas, datos clave, preguntas del tribunal y trampas del test. Solo resume el tema. Gráficos del tema: `crisis-frecuencia`, `primera-generacion`, `segunda-generacion-regiones`, `diamond-dybvig`, `hojas-balance`; juego del ataque con reservas 10 y tabla de las 3 generaciones. Funciones clave: momento del ataque, cláusula de escape y condición de colapso; bloque «Derivaciones para el tribunal» con los pasos del anexo A. Dichos: «Nadie escarmienta en cabeza ajena», «tanto va el cántaro…» y la frase de los banqueros, como en el tema. `construir-repaso.py 3B17 --no-publicar`: 4 páginas, 10,5 pt; última página llena al 92~%; `verificar-tema.py 3B17` sin errores de la ficha. Sin publicar: queda pendiente de la aprobación de Víctor.

## 7. Dudas abiertas

Todas aplicadas ya con la opción indicada; basta confirmarlas o cambiarlas.

1. **Estructura en 3 apartados** (opción B ajustada: I con 1.ª y 2.ª generación; II con los títulos de 2.º nivel del original; III con el contagio del original + predicción y cuarta generación). Alternativa A: I 1.ª, II 2.ª, III 3.ª y contagio.
2. **Diamond y Dybvig**: mención en II.2.1 + anexo corto (B) con el gráfico del 3.A.10. Alternativa: solo la mención.
3. **$Y^{\mathrm{obj}}$ e $Y^n$ en mayúscula** (canon § 1) frente a la minúscula en logaritmos de la oferta de Lucas del 3.A.6 que proponía la fase de contenido; y la contradicción § 1 ($Y^n$) / § 9 ($Y_n$) del canon.
4. **γ y α**: γ peso de la inflación (como `barro-gordon`) y α participación del capital en Krugman (1999); se avisa de que $\gamma E^e$ es la depreciación esperada.
5. **$W$ para la riqueza** de los empresarios en Krugman (1999) (local).
6. **México 1994 como crisis mixta** (II.2.3 c), puente entre la 2.ª generación y las paradas súbitas.
7. **Ficha `contagio`**: no se crea (recomendado esperar al 3.B.26 o al 3.B.16).
8. **Soros sin cifra** (no hay fuente primaria de los 10.000 millones).
9. **Templeton fuera** de la idea final (no comprobado en el libro; la frase atribuida dice «más peligrosas», no «más caras»). Si se quiere: una nota «Se atribuye al inversor John Templeton…».
10. **Forvo fuera** (pronunciación de Flood y Garber).
11. **Deuda soberana en `crisis-frecuencia`**: se pinta con el recuento de «Crisis Years» (80), porque la columna de «Crisis Frequency» (91) no cuadra con el artículo (79). Alternativa: solo bancarias y cambiarias.
12. **Jeanne (2000) como síntesis y Obstfeld (1996, sección 3) como modelo**, con una nota al pie que recoge el nombre «modelo de Jeanne y Obstfeld» de algunos exámenes.
13. **Refranes cambiados** (ver C1): se usan «tanto va el cántaro a la fuente…», «la fe mueve montañas», «no hay dos sin tres» y «no es la velocidad lo que mata, es la parada súbita»; el enganche, «nadie escarmienta en cabeza ajena».
14. **Tipo sombra sin recuadro**: si se quiere $\tilde E_t$ como función clave, basta pasar `eq:tipo-sombra` a `\funcionclave` (serían 4).
15. **Garber (1993)** (págs. 461-494 sin comprobar) y **Jeanne (1997)** (la frase «una parte significativa de la presión» viene de la fase de contenido, no se leyó en el artículo).
16. **Importe del BCE el 9/8/2007** (94.841 M€): fuera hasta comprobar la nota de prensa.
17. **Sims (2019)**: la nueva dirección da 403 a clientes automáticos; comprobar en un navegador.
18. **Turquía 2018 «con rasgos de la tercera generación»**: la clasificación es nuestra (datos del BCE y del BIS).

19. **Dichos** (13/11/2026): se quitan «la fe mueve montañas» y «no hay dos sin tres» (duda 13). Opciones: (a) quitarlos y dejar el refrán del enganche, «tanto va el cántaro…» y la frase de los banqueros; (b) conservar los 4 integrados. **Aplicada: (a)**.
20. **Bloques a)-d) del contagio** (13/11/2026): III.2 y III.3 usan `\paragraph{a) Vínculos comerciales}`, `\subparagraph{i) Bilaterales}`… para clasificar canales, no para los bloques de un modelo. Opciones: (a) dejarlos (no es un modelo); (b) pasarlos a viñetas para que las letras a)-e) solo marquen modelos. **Aplicada: (a)**.

## 8. Instrucciones para el vídeo

- **Reparto**: introducción 2′30″; I 11′ (I.1 5′; I.2 6′); II 9′ (II.1 1′30″; II.2 5′30″, con II.2.1 1′30″, II.2.2 3′ y II.2.3 1′; II.3 1′; II.4 1′); III 6′30″ (III.1 30″; III.2-III.5 1′30″ cada uno); conclusión 1′.
- **Enganche**: «nadie escarmienta en cabeza ajena» + Reinhart y Rogoff («esta vez es distinto») + la pregunta (¿por qué un país sano pasa en días de financiarse a no poder pagar, y por qué no aprende de sus vecinos?). **Idea final**: vuelve al refrán y responde la pregunta (balances que dependen de que el capital siga entrando; «esta vez es distinto»). Sin Templeton.
- **A la pizarra** (los 3 imprescindibles, cada uno con su función clave, que se conserva escrita durante su apartado):
  - I.1 `primera-generacion` por paneles, de arriba abajo (tipo sombra y paridad; dinero y crédito interno; reservas y ataque), con $T=R_0/\mu-h/\ell$ recuadrada;
  - I.2 `segunda-generacion-regiones` (coste fijo, las 2 parábolas, cortes $x_1$ y $x_2$, cielo, purgatorio e infierno), con la cláusula de escape recuadrada;
  - II.2.2 `hojas-balance` por capas (ejes y 45°, curva en 3 tramos, $L$, $U$, $H$, flechas), con $(1+\theta)(1-m)B^*/X>1$ recuadrada; antes, la espiral $\downarrow I\Rightarrow\uparrow q\Rightarrow\downarrow W\Rightarrow\downarrow I_F$ en una línea.
- **Como apoyo, sin dibujar**: `crisis-frecuencia` (introducción), la tabla del juego de los 2 especuladores (I.2 c; si sobra tiempo, solo la matriz de reservas intermedias), `tab:tres-generaciones` (II.4: puede irse llenando con una palabra por casilla) y el gráfico de Diamond y Dybvig (no se canta).
- **Gráfico conjunto por partes**: el de primera generación se dibuja en 3 pasos alineados en $T$ y $T_N$; el de hojas de balance, en 6 capas; los canales del contagio (III.2-III.3) se pueden ir escribiendo como árbol (fundamentos: comerciales/financieros; puro: información/dominó).
- **Refranes y frases** (13/11/2026): «tanto va el cántaro a la fuente que al final se rompe» (I.1) y «no es la velocidad lo que mata, es la parada súbita» (II.2.3), integrados en el texto; «la fe mueve montañas» y «no hay dos sin tres» ya no están.
- **Al empezar**, la convención del tipo de cambio (directo: si sube, se deprecia).
- **No se canta**: los anexos A-C, la caja gris de la derivada de Krugman, las notas al pie (curiosidades para las preguntas del tribunal) y la tabla completa de los datos recientes de Turquía y Argentina (basta nombrarlos).
