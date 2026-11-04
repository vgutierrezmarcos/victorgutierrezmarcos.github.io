# Revisión del tema 3.A.7 — La nueva economía keynesiana. Primera y segunda generación.

Fecha: 04/11/2026. Integración en 2 partes: la 1 escribió el preámbulo, la introducción, el esquema, la nota del reparto y el bloque I entero, `3A07.bib`, `seo.json` y `_trabajo/graficos-pedidos.json` con los 7 gráficos del tema; la 2, los bloques II y III, la conclusión, los 3 anexos y el resto de este informe.

Fuentes de la integración: `_trabajo/original.md` (Word de Víctor), `pendientes.md` (P1-P56), `propuestas-contenido.md` (C1-C43), `propuestas-datos.md` (V1-V79, D1-D6) con `bib-datos.bib` y `datos/*.csv`, y `propuestas-coherencia.md` (K1-K28, CC1-CC9 y estructura final). Criterio ante discrepancias: la estructura, los minutos, la notación y los refranes los decide coherencia; la teoría, contenido; las cifras y las citas, datos; los choques los resolvió el coordinador. Víctor está fuera hasta el 9/11: en cada **[decidir]** se ha aplicado la opción recomendada y se anota abajo (A07-01 en adelante).

## Resumen

- Nueva fuente `3A07.tex` con **3 apartados** (K3): I. Economistas neokeynesianos de primera generación (11′), II. Economistas neokeynesianos de segunda generación (9′) y III. Implicaciones de política económica y la nueva síntesis (6′30″); introducción 2′30″ y conclusión 1′ (suma 30′). Los títulos de primer y segundo nivel del Word se mantienen en su orden; el III se forma con el 2.2.3 y el 2.3 del Word.
- Enganche nuevo: «Por un clavo se pierde una herradura», con la frecuencia de cambio de los precios de consumo de la zona del euro (8 % al mes sin rebajas en 2010-2019, 12 % en 2022; BCE, 2026) y la pregunta «¿cómo pueden fricciones tan pequeñas dar a la política monetaria efectos tan grandes, y qué modelo los explica sin renunciar a agentes racionales?».
- Bloque I: caracterización según Schumpeter con la pieza común del bloque y la variante «escuela sin líder», universidades de agua salada y agua dulce en el texto; rigideces nominales (casi racionalidad, **costes de menú** con gráfico y el ejemplo del test de 2021, Blanchard-Kiyotaki con σ, reglas de tiempo y de estado), rigideces reales de pasada (Ball y Romer, 1990, con χ) y el modelo agregado en resumen (salarios de eficiencia y contratos implícitos con la notación del 3.A.27, WS-PS copiado del 3.A.28, histéresis sin ecuación).
- `3A07.bib` con 146 entradas (todas las de `bib-datos.bib`, las nuevas de contenido y las de los temas revisados con su misma clave); 7 gráficos pedidos (uno, `ws-ps`, copiado del 3.A.28); `seo.json` nuevo.
- Bloque II: caracterización de la 2.ª generación (corrigiendo la errata «de 1.ª generación» del título), con el método como «apalancamiento sobre la nueva macroeconomía clásica» y la tabla de De Vroey (2016) corregida; **el modelo canónico**, del que este es el tema de referencia, con las 3 funciones clave (IS dinámica, NKPC con κ, regla de Taylor canónica), el precio de reajuste de Calvo, la DA dinámica, el principio de Taylor exacto, la pérdida con λ_x = κ/σ, la divina coincidencia bien atribuida y su ruptura (Blanchard y Galí, 2007 y 2010), extensiones, evidencia y valoración.
- Bloque III: política monetaria (objetivos de inflación, credibilidad, variables naturales con la regla de Taylor con datos en una frase, límite inferior, *forward guidance* y su paradoja, tipo sombra en una frase, fricciones financieras), política fiscal con la equivalencia ricardiana matizada, y la nueva síntesis pieza a pieza, 2008, HANK, críticas y la inflación de 2021-2023 con el gráfico de la frecuencia de cambios de precios.
- Conclusión con sus 5 bloques, que empieza «En conclusión,» y cierra con el refrán. Anexos: A, el modelo canónico paso a paso (IS, Calvo y NKPC, DA y determinación, cada uno con `\findemo`); B, la historia de la macroeconomía según De Vroey con el esquema propio `historia-macro`; C, test con el único enlace al simulador.
- La prueba compila sin avisos ni referencias indefinidas: 37 páginas (27 de tema, 4 de anexos y 6 de bibliografía), con los 7 gráficos dibujados.

## Errores corregidos

### Parte 1 (introducción y bloque I)

| Dónde | Decía | Dice ahora |
|---|---|---|
| I.1, autores (l. 214; P38, V5) | «Paul Romer», con nota sobre su Nobel de 2018 por el crecimiento endógeno | David Romer (y Christina Romer); sin la nota |
| I.1, autores | Carlin y Soskice entre los «seguidores» de la 1.ª generación | Fuera de la lista (son la versión de manual de la NAIRU); Layard y Nickell, en Europa |
| I.1, «3 puntos» (l. 304) | La 1.ª generación «cambió de manera radical al abandonar la síntesis y **aceptar la TCR**» | La 2.ª generación acepta el **marco** (método) de la NMC, no la teoría del ciclo real |
| Introducción, rigidez real (P9, nota 6) | «las que provocan que el precio óptimo diste del walrasiano, siendo generalmente superior» | Confundía rigidez real con poder de mercado. Ahora: el precio o salario **relativo** deseado responde poco a la actividad (Ball y Romer, 1990) |
| I.2, lista de modelos (V17) | Fischer, 1979 | Fischer, **1977** (*JPE* 85(1)) |
| I.2, salarios de eficiencia (V34, P31) | «Salop, 1979; Shapiro y Stiglitz, 1984» | **Solow (1979)** para la condición de Solow; Salop (1979) queda como el motivo de la rotación |
| I.2.1, reglas dependientes del tiempo (l. 527, K11.4) | «los precios se modifican **en función de la evolución de los acontecimientos**» | Al revés: se revisan en **fechas fijadas de antemano**; las que dependen de los acontecimientos son las de estado |
| I.2.1, Fischer y Taylor (K11.5) | Rotulados como «rigideces nominales de **precios**» | Contratos escalonados de **salarios** nominales, aplicables a los precios (como el 3.A.37) |
| I.2.1, nota 9 (C17) | Contrato de Fischer $W_t=\mathrm{E}_t[P_{t+1}]$ | $w^j_t=\mathbb{E}_{t-j}[p_t]$ (ficha `fischer-taylor-contratos`) |
| I.2.1, sincronización (l. 548, V41) | «el único equilibrio estable es la sincronización (Ball, 1987)» | **Ball y Romer (1989)**, *RES* 56(2) (Ball, 1987, trata de la duración de los contratos) |
| I.2.1, Blanchard y Kiyotaki (P36) | Elasticidad θ (en el canon, θ es la CRRA) | **σ**, con el margen $1+\mu\equiv\sigma/(\sigma-1)$ como el 3.A.28 |
| I.2.1, costes de menú (C14) | «Si los precios permanecen estáticos, la pérdida social será mayor que la pérdida individual» | El efecto sobre el bienestar es de **primer orden** (positivo o negativo según el signo de la perturbación); la ganancia privada, de segundo |
| I.2.1, críticas (C18) | «si el shock se percibe como permanente, el ajuste sería más rápido» presentado como crítica | Es una implicación del modelo: los costes de menú explican la rigidez ante perturbaciones **pequeñas y transitorias** |
| I.2.1, limitaciones | «equilibrios múltiples, extremos y estables… ya no puede salir» | Equilibrios múltiples, con y sin ajuste, para la misma perturbación (Ball y Romer, 1990) |
| I.2.2, rigideces reales (V33) | «economías de aglomeración (Diamond, 1993)» | **Diamond (1982)**, *JPE* 90(5) (mercados densos); el de 1993 es otro artículo |
| I.2.3, salarios de eficiencia (P31) | Coste por unidad de eficiencia $e(w)/w$; $\varepsilon_{w,e}$; «teorías sociológicas»; rotación de «Milgram» | Minimiza $w/e(w)$; $\varepsilon_{e,w}=1$; 5 motivos con sus autores; la rotación es de Salop (1979) |
| I.2.3, contratos implícitos (P32) | Generan paro involuntario | **No** generan paro involuntario: estabilizan el salario real con el empleo eficiente (3.A.27) |
| I.2.3, contratos implícitos (V35) | «Azariadis, Baily y Gordon, 1970's» | Baily (1974), Gordon (1974), Azariadis (1975) |
| I.2.3, NAIRU (P33, V38) | «Nickell y Layard, 1985», SRN/SRP, $U_n$, α, la NAIRU «introducida» por la NEK | Layard y Nickell (1985) y Layard, Nickell y Jackman (1991); WS, PS, $U^n$ con las ecuaciones del 3.A.28; la idea es de Modigliani y Papademos (1975, NIRU) |
| I.2.3, histéresis (V39) | Blanchard y Summers (1987) | **1986** (*NBER Macroeconomics Annual*), como el 3.A.28 |
| I.2.3, histéresis | Capital «(Carlin y Soskice)», capital humano «(Layard y Nickell)», *insiders* «(Lindbeck y Snower)» sin año | Los 3 mecanismos, con Blanchard y Summers (1986); Lindbeck y Snower (1986, 1988) |
| I.3 (P41, K11.2) | «los autores de la NEK aceptan la discrecionalidad» | No hay posición común: Taylor propondrá su regla y la 2.ª generación defenderá el compromiso (3.A.36) |
| Introducción (V1) | Cita de Mankiw sin obra (P40 suponía 1990) | **Mankiw (2006)**, *JEP*, traducción revisada |
| Introducción (V28) | *The New Keynesian Economists* | ***New Keynesian Economics*** (Mankiw y Romer, eds., 1991) |
| Notas 3 y 4 (V6) | Hall sin año en la nota 3; lista de agua salada sin el MIT y con Brown y Duke | Hall (1976); MIT, Harvard, Princeton, Yale, Columbia, Stanford, Berkeley y la LSE en Europa |

### Parte 2 (bloques II y III, conclusión y anexos)

| Dónde | Decía | Dice ahora |
|---|---|---|
| Título de II.1 (P39, K11.1) | «Caracterización general de la NEK **de 1.ª generación**» | «de 2.ª generación» |
| Título de II | «Economistas keynesianos de segunda generación» | «neokeynesianos», como en I |
| II.1, autores (P38) | «Paul Romer», Akerlof y Yellen en la 2.ª generación | Sin ellos; con Goodfriend, King, Rotemberg, Woodford, Clarida, Galí, Gertler, Christiano, Eichenbaum, Evans, Smets, Wouters |
| II.1 (V14, K11.7) | Nueva síntesis aceptada «hasta la llegada de la Gran **Depresión**» | Hasta la crisis de 2008 |
| II.1, método | Describía hogares, empresas competitivas y la ausencia de sector público del **ciclo real** como si fueran de la NEK | EGDE con sus 4 letras y los 2 cambios de la NEK (competencia monopolística y rigideces) |
| Tabla 1.ª frente a 2.ª (P27) | Sin fuente; «la oferta no coincide con la oferta»; «defensa del contexto walrasiano» | «Adaptado de De Vroey (2016), tabla 18.1»; «con la demanda»; «defensa de una macroeconomía homogénea de estilo walrasiano» |
| Hogares (C24) | Desutilidad del trabajo con **+**; $u_t$ como perturbación de demanda en la IS; «condición de sustitución intertemporal del ocio» | Con **−** (y CRRA con −1); la perturbación de demanda dentro de $r^n_t$; condiciones de Euler y de oferta de trabajo |
| Tipo natural (C24) | «Depende negativamente de los shocks tecnológicos» | $r^n_t=\rho+\theta\,\mathbb{E}_t[\Delta y^n_{t+1}]$: depende del crecimiento esperado de la producción natural |
| Empresas (C25, P36) | «$P^*=\mu+\mathrm{CMg}$» en niveles; pendiente **δ** = (1−η)(1−βη)/η; la brecha como «proxy» del coste marginal | En logaritmos con μ margen neto; **κ** = [(1−η)(1−βη)/η](θ+φ), y (1−η)(1−βη)/η es el coeficiente del coste marginal real; $\widehat{\mathrm{cmg}}_t=(\theta+\varphi)x_t$ es un resultado exacto de primer orden |
| Perturbación de costes | $e_t$ | $u_t$ (canon) |
| Regla de Taylor (P37) | Forma original como regla del modelo; versión «modificada» $i_t=\nu i_{t-1}+\phi\pi_t+x_t+\varepsilon_t$, sin coeficiente en $x_t$ ni (1−ν) | Canónica $i_t=\rho+\phi_\pi\pi_t+\phi_x x_t+\varepsilon_t$ (función clave); suavización con (1−ν); la original en una línea con `\vertema{3.A.36}` |
| Principio de Taylor (P36) | «φ + (1−β)/δ > 1» | κ(φ_π − 1) + (1 − β)φ_x > 0 |
| Conferencia de Taylor (V8) | «conferencia de 1992» sin cita | Taylor (1993), conferencia Carnegie-Rochester de noviembre de 1992 |
| Equilibrios múltiples (V53) | Blanchard y Fischer (1993) | **1989** (*Lectures on Macroeconomics*) |
| Divina coincidencia (P35, V49) | «hallada por Rotemberg y Woodford (2005) y bautizada por Blanchard y Galí (2005)», también en el título | Resultado de Goodfriend y King (1997) y Rotemberg y Woodford (1997); nombre de Blanchard y Galí (**2007**, *JMCB*) |
| Nota 37 (P34, V50) | «Blanchard y Galí (2005)» con búsqueda (DMP) | Blanchard y Galí (**2010**), *AEJ: Macroeconomics*; separado del de 2007 |
| Pérdida (V51) | «Woodford (1999)»; $\lambda\hat y^2$ | Rotemberg y Woodford (1997) y Woodford (2003); $\pi_t^2+\lambda_x x_t^2$, $\lambda_x=\kappa/\sigma$ |
| Brecha (K11.3) | «Diferencia entre el PIB **nominal** y el potencial» | Producción frente a la **natural** (con precios flexibles), en logaritmos; nota de que no es la brecha de las estadísticas |
| Críticas a la NKPC (C28) | Contradicción: no explica la persistencia y «consigue explicar la persistencia»; Ball (1994) por los saldos reales | Sin la contradicción; la desinflación creíble es expansiva porque la inflación cae antes que la producción |
| Híbrida (C28, CC3) | $\alpha\pi_{t-1}+\beta\mathbb{E}_t\pi_{t+1}+\delta x_t+e_t$ | $\gamma_b\pi_{t-1}+\gamma_f\mathbb{E}_t\pi_{t+1}+\kappa x_t+u_t$ |
| Equivalencia ricardiana (P4) | «Los modelos de 2.ª generación aceptan la equivalencia ricardiana, lo que limita el efecto expansivo de la política fiscal» | Se cumple con hogares ricardianos e impuestos de suma fija y afecta a la **financiación**, no al gasto; deja de cumplirse con hogares de regla de pulgar (Galí, López-Salido y Vallés, 2007) |
| Multiplicador en el límite inferior (P52) | `[ver tema 3.A.38]` | `\vertema{3.A.40}` |
| FMI (V11, V12) | Nota fiscal «justo después de la quiebra de Lehman»; tercera conferencia «(2016)» | «A finales de 2008, tres meses después»; abril de 2015 (libro de 2016) |
| Blanchard (2008) (V60) | Documento de trabajo | Blanchard (2009), *Annual Review of Economics* |
| «Riesgo sistemático» | — | Riesgo sistémico |
| Nota 24 | Causalidad de Granger y VAR como «avances matemáticos» para optimizar | Se quita (mezclaba econometría con optimización) |

## Marcas resueltas

### Parte 1

| Marca | Original | Qué se hizo |
|---|---|---|
| P1 (amarillo, l. 465-469) | 3 párrafos sobre la interacción de rigideces nominales y reales (Ball y Romer, 1990; Mankiw y Romer, 1991; Romer, 1993) | Integrados en negro en I.2.2 (idea con Ball y Romer y Mankiw y Romer), en la valoración de los costes de menú (Romer, 1993) y en la nota de los 3 matices de la introducción. Citas comprobadas (V26-V28) |
| P2 (amarillo, l. 471-485) | Lista de rigideces reales del mercado de bienes | Mercados de clientes (Okun, 1975 y 1981) y colusión contracíclica (Rotemberg y Saloner, 1986) en el cuerpo; el resto, en una caja gris (no se canta). «Stigler» sin año: no encontrado (V32), la reserva de capacidad queda **sin autor**; Diamond 1993 → 1982 |
| P5 | Salto de línea en amarillo | Desaparece |
| P6 | 4 notas al opositor del cambio de temario y la captura de la propuesta del tribunal | No se publican; la propuesta del tribunal (contexto, autores y universidades; método; objeto) guía I.1 y II.1 |
| P7 | 6 comentarios de Víctor (sintetizar, muchos autores, costes de menú y NAIRU más desarrollados, Solow y contratos escalonados de palabra, distinguir rigideces nominales y reales) | Aplicados y no publicados: costes de menú con a)-e), gráfico y ejemplo; Solow y Fischer-Taylor de palabra (Fischer-Taylor con una nota); rigideces nominales y reales en subapartados distintos (I.2.1, I.2.2). La NAIRU, en resumen con el gráfico del 3.A.28 copiado (A07-03) |
| P8 | «Dedicar mucho tiempo a este apartado» (I.1) | I.1 recibe 3′ |
| P9 | Comentario «coordinar 3.A.7 y 3.A.37» y 2 notas al opositor con las definiciones | Definiciones corregidas en la introducción (contextualización); Fischer-Taylor en resumen con `\vertema{3.A.37}` |
| P10 | «[de verde los que tienen que estar en la exposición y de amarillo los que deberían estar de pasada]» | No se publica; usado como criterio: el amarillo, de pasada |
| P11 | 3 referencias a clases de un profesor | No se publican |
| P12 | «Estructura» vacía | Redactada (3 apartados y por qué ese orden) |
| P13 | «Estos modelos en este tema tendrían que ser de pasada» (rigideces salariales) | Resumen en I.2.3 con `\vertema{3.A.27}` |
| P14 | «La información imperfecta puede ser el nexo con los salarios de eficiencia» | Nota al pie en I.2.3 |
| P15 | «Coordinar 3.A.28 y 3.A.7» y «ESTO ESTÁ MAL» sobre la SRN en $(L,W/P)$ | WS-PS en $(U,W/P)$ con el gráfico del 3.A.28 (que explica el plano en su nota) |
| P20 | Cajas de anotaciones (idea de los contratos implícitos; SRN con forma lineal y α) | La primera, integrada en el resumen; la forma lineal sale (está en el anexo C del 3.A.28) |
| P21-P22 | Imágenes 1 y 2 | Rehechas en TikZ (`casi-racionalidad`, `costes-menu`), con números que cuadran entre sí |
| P23-P25 | Imágenes 3-11 (Solow, Shapiro-Stiglitz, SRN, SRP, equilibrio, subsidio) | Fuera del 3.A.7 (sus temas de referencia, 3.A.27 y 3.A.28, las tienen corregidas); solo `ws-ps` copiado del 3.A.28 |
| P30 | 11 fotos de autores y mapa *saltwater* | Fuera (licencias no comprobadas); el mapa, sustituido por la viñeta de universidades |
| P31-P33 | Textos antiguos de salarios de eficiencia, contratos implícitos y NAIRU | Resumidos con la notación del canon (ver «Errores corregidos») |
| P38 | Paul Romer | David Romer |
| P40 | Citas de Mankiw y de Ball y Mankiw | Comprobadas (V1, V2): Mankiw (2006); Ball y Mankiw (1994) con «herejes» y Hume |
| P41 | Discrecionalidad | Matizado en I.3 |
| P43-P44 | Universidades; método como «refuerzo de la síntesis por el lado de la oferta» | En el texto de I.1 |
| P56 | Ruta `file:///`, «Coordinado por Carlos Herrero», «Tema Juan Luis Cordero Tarifa», enlace a quia.com | Quitados; un único enlace al simulador en el anexo de test. Cuerpo y Quesada (2016) se mantiene con `\nocite` (A07-09) |

### Parte 2

| Marca | Original | Qué se hizo |
|---|---|---|
| P3 (amarillo) | «Todo lo producido será consumido, $Y_t=C_t$» | Comprobado y justificado en los supuestos: sin capital ni sector público, en economía cerrada (Galí, 2015, cap. 3) |
| P4 (amarillo) | Equivalencia ricardiana | Matizada en la política fiscal de III.1 (ver «Errores corregidos») |
| P16 | «Coordinar 3.A.7, 3.A.37 y 3.A.42» | Desarrollo aquí; los otros temas lo resumen (ficha `nek-3-ecuaciones`) |
| P17 | «Faltaría aquí desarrollar la derivación» | Intuición y resultados en II.2; derivación paso a paso en el anexo A |
| P18 | Comentario de la bibliografía con el nombre del coordinador | No se publica |
| P19, P28 | Anexo 1 (TNP frente a NAIRU) con la advertencia «¡Cuidado!…» y la tabla con errores | Sustituido por la frase de Ball y Mankiw (2002) y la NIRU en I.2.3; el anexo corregido está en el 3.A.28 |
| P26 | Imagen 12 con la regla sin $\phi_x$ y la pendiente δ | Rehecha como `nek-esquema` y nuevo gráfico de referencia `nek-xpi` |
| P27 | Tabla 1.ª frente a 2.ª | `tab:generaciones`, con fuente y erratas corregidas |
| P29 | Anexo 2 con 3 capturas de De Vroey | Anexo B con el esquema propio `historia-macro` y la tabla 0.1 resumida en el texto |
| P34-P37 | Blanchard y Galí, divina coincidencia, δ, regla de Taylor | Ver «Errores corregidos» |
| P39 | Erratas y fechas | Corregidas (título de II.1, Gran Depresión, Fischer 1977; Estrella y Mishkin, 1998, ya no se cita al quitarse el anexo 1) |
| P42 | Nueva síntesis en una viñeta | III.2 con lo que aporta cada escuela (`tab:nueva-sintesis`), con las palabras que espera el 3.A.5 |
| P45 | Microfundamentos del modelo canónico | Dixit-Stiglitz (`\vertema{3.A.18}`) y Calvo en el cuerpo y en el anexo |
| P46 | Valoración parada en 2011 | Fricciones financieras, límite inferior y *forward guidance*, HANK, paro, críticas e inflación de 2021-2023 |
| P47 | Evidencia micro | Gautier et al. (2026) y Bils y Klenow (2004), con el gráfico `frecuencia-precios` |
| P48 | 4 bloques vacíos de la conclusión | Redactados |
| P49 | «Preguntas de otros exámenes» vacío | Las 8 preguntas del primer ejercicio con el tema 3.A.7, en el anexo de test (no hay preguntas del tercer ejercicio) |
| Notas 22-39 | EGDE, Calvo y Rotemberg en nota, enlaces, notas en inglés | 22-24 fuera; 25 integrada en II.1; 26-27 a la bibliografía; 28 en las extensiones; 29 (enlace roto) sustituida por Guisinger, Owyang y Shell (2018); 30-32 en la regla de Taylor; 31-33 y 36 reescritas en castellano con Galí (2015, 2018) y Woodford (2003); 34-35 integradas (la 35, nota de Wicksell); 37 corregida; 38 como nota de la política fiscal; 39 (borrador de Sims y Wu) sustituida por Sims, Wu y Zhang (2023) |

## Datos actualizados

### Parte 1

| Dato | Valor anterior | Valor nuevo | Fuente | URL | Consulta | Segunda comprobación |
|---|---|---|---|---|---|---|
| Frecuencia mensual de cambios de precios, zona del euro (enganche, costes de menú) | — (nuevo) | 8,2 % sin rebajas en 2010-2019; 12,0 % en 2022 | Gautier et al. (2026), BCE, WP 3181, tabla B1 | https://www.ecb.europa.eu/pub/pdf/scpwps/ecb~44d02b04fd.wp3181en.pdf | 4/11/2026 | Resumen PRISMA del BCE (18/7/2023) y texto del WP (V77) |
| Inflación media de la zona del euro en 2022 | — | 8,4 % | Eurostat, `prc_hicp_aind` | ver `bib-datos.bib` (`Eurostat2026IAPC`) | 4/11/2026 | BCE, `ICP.A.U2.N.000000.4.AVR` (V78) |
| Frecuencia con rebajas a principios de siglo (nota del enganche) | — | 15,1 % zona del euro; 24,8 % EE. UU. | Dhyne et al. (2006), *JEP* 20(2) | https://doi.org/10.1257/jep.20.2.171 | 4/11/2026 | Tabla 2 del WP del Banco de Portugal (V77) |
| Duración mediana de los precios en EE. UU. | — | 4,3 meses | Bils y Klenow (2004) | NBER WP 9069 | 4/11/2026 | V77 |
| «90 % de los economistas» de Samuelson | «a mediados de los 50» | 1955, *Economics*, 3.ª ed., p. 212 | `Samuelson1955Economics` | — | 4/11/2026 | 3.A.5 revisado (V4) |
| Cita de Mankiw sobre la *Teoría general* | sin obra | Mankiw (2006), *JEP* 20(4) | NBER WP 12349 | https://www.nber.org/system/files/working_papers/w12349/w12349.pdf | 4/11/2026 | Copias del artículo (V1) |
| Cita de Ball y Mankiw | sin año en la frase | Ball y Mankiw (1994), con «heretics» y Hume | *Carnegie-Rochester* 41 | https://www.nber.org/papers/w4677 | 4/11/2026 | V2 |
| Cita de Shapiro y Stiglitz (nota) | en inglés, sin página | traducida, p. 438 | *AER* 74(3) | ver V3 | 4/11/2026 | V3 |
| Hall, agua dulce y agua salada | sin año / 1976 | 1976 | Perfil de Robert Hall (Stanford) | https://profiles.stanford.edu/robert-hall?tab=bio | 4/11/2026 | R. J. Gordon (2004) (V6) |
| Ejemplo de costes de menú | — (nuevo) | $z\geq 250$; excedente 1.215 → 1.540 | Pregunta 18 del examen de julio de 2021 (OEP 2020), `preguntas.json` id 213 (respuesta b, 250) | — | 4/11/2026 | Cálculo propio de los excedentes |

### Parte 2

| Dato | Valor anterior | Valor nuevo | Fuente | URL | Consulta | Segunda comprobación |
|---|---|---|---|---|---|---|
| Frecuencia de cambios de precios en la zona del euro, 2010-2024 (gráfico) | — (nuevo) | sin rebajas 8,2 / 8,0 / 8,0 / 12,0 / 10,2 / 8,6 %; con rebajas 12,0 / 11,9 / 11,8 / 15,7 / 14,2 / 13,2 % | Gautier et al. (2026), WP 3181 del BCE, tabla B1 | `datos/frecuencia-precios.csv` | 4/11/2026 | Resumen PRISMA (2023) y texto del WP (V77) |
| Regla de Taylor en la zona del euro (una frase; el gráfico, al 3.A.36) | — | 2020: −1,6 %; 2022: 14 % con inflación del 8,4 % | BCE, Eurostat y AMECO | `_trabajo/datos/regla-taylor-zona-euro.csv` | 4/11/2026 | BCE y OCDE (V78) |
| Tipo sombra de la zona del euro (una frase) | — | −7,8 % en agosto de 2019 | Wu y Xia | https://sites.google.com/view/jingcynthiawu/shadow-rates | 4/11/2026 | Sin segunda fuente independiente; coincide con el tipo a un día lejos del límite (V79) |
| Regla original de Taylor (V9) | sin cita | $i_t=1+1{,}5\pi_t+0{,}5x_t$ | Taylor (1993), p. 202 | https://doi.org/10.1016/0167-2231(93)90009-L | 4/11/2026 | Galí (2015) |
| FMI, «Rethinking Macroeconomic Policy» (V10) | — | febrero de 2010 | SPN/10/03 | https://doi.org/10.5089/9781455224982.004 | 4/11/2026 | CrossRef |
| Nota fiscal del FMI (V11) | «justo después de Lehman» | finales de 2008 | SPN/08/01 | https://doi.org/10.5089/9781589067981.004 | 4/11/2026 | CrossRef la fecha en 2009: se dice «a finales de 2008» |
| Tercera conferencia del FMI (V12) | 2016 | abril de 2015 (libro de 2016) | FMI | https://www.imf.org/en/news/seminars/conferences/2016/12/31/rethinking-macro-policy-iii | 4/11/2026 | PIIE |
| Solow (2002) (V13) | sin obra | *Revue de l'OFCE* 83 | https://doi.org/10.3917/reof.083.0007 | — | 4/11/2026 | Blinder (2004) |
| Objetivo del BCE | — | 2 % simétrico a medio plazo desde 2021, confirmado en 2025 | `BCE2021Estrategia`, `BCE2025Estrategia` (claves de la 1D01) | — | — | — |

Las citas bibliográficas (V17-V68) se han comprobado una a una por el agente de datos; los cambios están en «Errores corregidos».

## Contenido añadido

### Parte 1

- Introducción con sus 5 bloques: enganche con refrán y dato actual, relevancia propia (teoría, política, actualidad) con los motivos de Schumpeter en una viñeta y la misma nota que el 3.A.5, contextualización en 6 viñetas con remisiones (3.A.2-3.A.6, 3.A.42) y las **definiciones de rigidez nominal y real** (P9), problemática de 4 preguntas y estructura.
- I.1: pieza común de Schumpeter con la variante «escuela sin líder» (CC6/CC7), contexto, universidades (Hall, 1976), cuerpo doctrinal (Mankiw y Romer, 1991; Ball y Mankiw, 1994), método «refuerzo de la síntesis por el lado de la oferta» (palabras del tribunal), comparación con la síntesis, el desequilibrio (`\vertema{3.A.4}`, coordinado con lo que el 3.A.4 remite aquí), el monetarismo y la NMC; caja gris con los fundamentos en 4 puntos (del original).
- I.2: cuadro de los modelos de la 1.ª generación por pregunta (C11; separar rigideces reales por mercados es idea de **Miquel Tebar**, citada aquí); pérdida de segundo orden con el desarrollo de Taylor (`eq:perdida-segundo-orden`); costes de menú con a)-e), la condición (`eq:costes-menu`), la ganancia privada frente a la pérdida social y el **ejemplo del test de 2021**; Blanchard-Kiyotaki con la demanda (`eq:demanda-bk`); reglas de tiempo (Fischer, Taylor, Calvo) y de estado (Sheshinski y Weiss) con Ball, Mankiw y Romer (1988), Ball y Romer (1989) y Ball y Cecchetti (1988); rigideces reales con la ecuación de Ball y Romer (`eq:ball-romer`) y la complementariedad estratégica; crédito (Stiglitz y Weiss, 1981; Bernanke y Gertler, 1989, idea de Tebar); condición de Solow (`eq:condicion-solow`); WS, PS y NAIRU (`eq:ws`)-(`eq:nairu`); NIRU de Modigliani y Papademos (1975) y Ball y Mankiw (2002).
- I.3: valoración con De Vroey (2016) y Blinder et al. (1998).

### Parte 2

- II.1: autores, contexto (la Gran Moderación), universidades e instituciones (con los bancos centrales), el método como «apalancamiento sobre la nueva macroeconomía clásica» (palabras del tribunal) con la pegatina «si no puedes con tu enemigo, únete a él», y la tesis de De Vroey de las 2 transformaciones del programa EGDE.
- II.2 (C23-C28): supuestos con $Y_t=C_t$ justificado; problema del hogar con `\optim`; IS dinámica con $r^n_t$ y la nota de Wicksell; precio de reajuste de Calvo (`eq:precio-reajuste`) con «más vale tarde que nunca»; κ (`eq:kappa`); regla de Taylor canónica y la original en una línea; DA dinámica (`eq:da-dinamica`, derivación propia comprobada); principio de Taylor (`eq:determinacion`, «más vale pasarse que quedarse corto») con Clarida, Galí y Gertler (2000); pérdida (`eq:perdida`); divina coincidencia («matar dos pájaros de un tiro») y su ruptura; caja de equilibrios múltiples; nota al opositor de la pregunta de marzo de 2025; extensiones (híbrida, Mankiw y Reis, Erceg, Henderson y Levin, Smets y Wouters, economía abierta), evidencia y valoración.
- III (C29-C34, con el reparto del coordinador): objetivos de inflación con la estrategia del BCE; credibilidad y compromiso; variables naturales con la regla de Taylor con datos; límite inferior, *forward guidance* y su paradoja (Eggertsson y Woodford, 2003; Del Negro, Giannoni y Patterson, 2023; McKay, Nakamura y Steinsson, 2016), compras de activos (Sims, Wu y Zhang, 2023) y tipo sombra; fricciones financieras (BGG, Gertler y Karadi, Gertler y Kiyotaki, Cúrdia y Woodford); política fiscal con los 3 mecanismos (nota 38 del original), equivalencia ricardiana y multiplicadores; nueva síntesis (`tab:nueva-sintesis`), 2008, HANK, paro, inflación de 2021-2023 y críticas (Romer, 2016; Stiglitz, 2018; Blanchard, 2018; Galí, 2018).
- Anexo A (C37, P17): derivación paso a paso de la IS, de la NKPC desde Calvo y de la condición de determinación, con μ margen neto (la propuesta usaba $\ln\mu$ con μ bruto: cambiado por coherencia, A07-05).

## Coherencia

### Parte 1

- **Remisiones nuevas o corregidas** (todas con `\vertema`): 3.A.2, 3.A.3, 3.A.4 (desequilibrio), 3.A.5 (síntesis y monetarismo), 3.A.6 (crítica de Lucas, Sargent y Wallace), 3.A.13 (CNE como IC; Stiglitz-Weiss), 3.A.17 (monopolio, nueva), 3.A.18 (Dixit-Stiglitz y Blanchard-Kiyotaki), 3.A.27, 3.A.28, 3.A.36 (reglas), **3.A.37** (análisis dinámico de precios: el «3.A.41» del Word, corregido), 3.A.42 (ciclo real). Remisiones internas con `\ref`.
- **Notación** (K12 y decisiones del coordinador): σ en Blanchard-Kiyotaki; μ margen neto con $1+\mu=\sigma/(\sigma-1)$, como la PS del 3.A.28 (CC1, A07-05); χ local (Ball y Romer); $z$ coste de menú (local); $\varepsilon_{e,w}$ y $w/e(w)$, CNE como IC (3.A.27); WS, PS y NAIRU con las mismas ecuaciones y etiquetas que el 3.A.28 (`eq:ws`, `eq:ps`, `eq:nairu`, sin `\funcionclave` porque aquí no es central); $w^j_t=\mathbb{E}_{t-j}[p_t]$ para Fischer.
- **Gráfico copiado**: `graficos/ws-ps.*` es el de `fuentes/3A28/graficos/` sin cambios. Si cambia allí, copiar de nuevo.
- **Lo que otros temas revisados esperan de este** (cumplido en I): 3.A.5 (la NEK microfundamenta las rigideces de la síntesis), 3.A.18 (con costes de cambiar los precios, el dinero deja de ser neutral, Blanchard y Kiyotaki), 3.A.27 (rigideces reales resumidas con su notación y sin el error del paro involuntario), 3.A.28 (competencia imperfecta y rigideces nominales y reales como fundamento del paro de equilibrio), 3.A.13 (Stiglitz-Weiss; riesgo moral en Shapiro-Stiglitz). El 3.A.4, en revisión, remite aquí por «la nueva economía keynesiana, que fundamenta las rigideces que el desequilibrio daba por supuestas»: I.1 lo dice con esas ideas.
- **Contradicciones con otros temas** (no se tocan): ver § «Contradicciones» de `propuestas-coherencia.md` (3.A.36, 3.A.37, 3.A.38, 3.A.41, 3.A.42 y 4.B.4 sin revisar; 3.A.6 atribuye la nueva síntesis a Solow).

### Parte 2

- **Notación del modelo canónico** fijada aquí para los temas que lo resumen (3.A.36, 3.A.37, 3.A.38, 3.A.42 y 4.B.4): $x_t$, $r^n_t$, θ, φ, σ, μ (margen neto), η, κ, φ_π, φ_x, ν, $u_t$, $\varepsilon_t$, $\widehat{\mathrm{cmg}}_t$, $p^*_t$, γ_b, γ_f, λ_x = κ/σ; $B_t$ bonos (local, avisado). La regla del modelo lleva ρ; la que sigue a $r^n_t$ solo aparece para explicar la divina coincidencia (CC2).
- **Remisiones de II y III**: 3.A.1, 3.A.4, 3.A.5, 3.A.6, 3.A.18, 3.A.26, 3.A.28, 3.A.29, 3.A.32, 3.A.33, 3.A.36, 3.A.37, 3.A.38, 3.A.39, 3.A.40 (antes «3.A.38» para el multiplicador en el límite inferior), 3.A.41, 3.A.42, y 4.B.4 solo en la conclusión, como extensión.
- **Lo que esperan otros temas**: 3.A.5 (la nueva síntesis recoge el legado monetarista: tasa natural, expectativas, reglas, inflación como objetivo; con Goodfriend y King, 1997, y Mankiw, 2006); 3.A.26 y 3.A.28 (Blanchard y Galí, 2010, con sus mismas palabras); 3.A.29 (EGDE neokeynesianos y ecuación de Euler).
- **Para el canon** (fase canon): CC1 (μ margen neto en la macro), CC2 (regla con ρ), CC3 (filas nuevas de § 8), CC4 (`nek-xpi` como gráfico de referencia de la ficha `nek-3-ecuaciones` cuando exista), CC5 (fichas `costes-de-menu`, `blanchard-kiyotaki`, `calvo` como alias), CC6 (mapa), CC7 (variante «escuela sin líder»), CC8 (`historia-macro` como gráfico común del bloque 3.A.1-3.A.7), CC9 (refranes).
- **Contradicciones** con temas sin revisar (no se tocan): 3.A.36, 3.A.37, 3.A.38, 3.A.42 y 4.B.4 copian las erratas del modelo canónico (δ, regla sin φ_x, «Rotemberg y Woodford, 2005», «Blanchard y Galí, 2005»); 3.A.41 copia las críticas a la NKPC con otra notación; 3.A.6 atribuye la nueva síntesis a Solow; las fichas `nek-3-ecuaciones` y `taylor` usan ρ y $r^n_t$ en la regla.

### Propuestas aplicadas y rechazadas

- **Contenido (C1-C43)**: aplicadas C1, C4-C7, C10-C12, C14-C18, C20-C32, C34, C36-C43 (C43, fichas del canon, queda para la fase canon). Con cambios: C13 (sin la pegatina «lo perfecto es enemigo de lo bueno»), C19 (repartida: trabajo en I.2.3, crédito en I.2.2), C26 (la caja de equilibrios múltiples se conserva con Blanchard y Fischer, 1989), C29 (las implicaciones del modelo pasan a II.2 iii, A07-12), C33 (la macroprudencial remite al 3.A.42 y no al 3.B.27; Perotti y Romer y Romer se mantienen con `\vertema{3.A.40}`), C35 (la idea final usa el refrán del enganche del coordinador). Rechazadas o sustituidas: C2 (por K5 y las pegatinas del coordinador), C3 («Las cosas de palacio van despacio», por «Por un clavo…»), C8 (por K7), C9 (Hall con su perfil verificado en vez de Gordon, 2004), la nota de C10 sobre el Nobel de Paul Romer y su supresión de «herejes» y Hume (datos los comprobó).
- **Datos (V1-V79)**: aplicadas todas las correcciones; V7 (mapa de Wójcik et al.) y V70 (Wikipedia) no se usan porque el mapa sale; V16 (tipos del BCE de 2023-2026) no se añade, no hace falta; V23 con una sola fuente (A07-08); V32, V37, V52, V54, V61 y V65 sin fuente: fuera (A07-07); D1-D6 como recomendaba el agente de datos (A07-06, A07-13 a A07-15).
- **Coherencia (K1-K28, CC1-CC9)**: aplicadas K1-K28 con el reparto de minutos de K4 y la estructura final; K22 con el reparto del coordinador (A07-12); K17 con el gráfico copiado (A07-03). CC1-CC9 quedan para la fase canon (anotadas en «Coherencia»).
- **Pendientes (P1-P56)**: todas resueltas (ver «Marcas resueltas» y «Errores corregidos»).

## Dudas abiertas

Se aplicó en todas la opción recomendada; Víctor puede cambiarlas a la vuelta.

- **A07-01. Tres apartados** (K3, C1): I 1.ª generación, II 2.ª generación, III implicaciones y nueva síntesis, frente a los 2 del Word y del tribunal. Aplicado.
- **A07-02. Pieza común de Schumpeter** (CC6/CC7): misma frase que el 3.A.5 («reconoce una escuela de pensamiento por 3 rasgos…») con la variante «escuela sin líder» y las universidades como rasgo del tribunal. Aplicado en I.1 y en II.1.
- **A07-03. NAIRU en resumen con el gráfico del 3.A.28** (K17, P7): el comentario de 2021 pedía la NAIRU «más desarrollada», y el canon (3.A.28 revisado) la pone en resumen aquí. Se resume en 1′30″ con WS, PS, NAIRU y el gráfico `ws-ps` copiado (de apoyo en el cante).
- **A07-04. Enganche y pegatinas** (K6, K27, decisión del coordinador): «Por un clavo se pierde una herradura» y 5 pegatinas («entre todos la mataron y ella sola se murió», «si no puedes con tu enemigo, únete a él», «más vale tarde que nunca», «más vale pasarse que quedarse corto», «matar dos pájaros de un tiro»), comprobadas con grep en todos los temas, guiones, fichas y propuestas: ninguna está usada. No se usa «lo perfecto es enemigo de lo bueno» (C13) ni «las cosas de palacio van despacio» (C3).
- **A07-05. μ en la NEK** (CC1): margen neto, $1+\mu=\sigma/(\sigma-1)$, como el 3.A.28. Aplicado en Blanchard-Kiyotaki y en la PS; y en Calvo ($p^*_t=\mu+\ldots$ en logaritmos, $\widehat{\mathrm{cmg}}_t=\mathrm{cmg}_t+\mu$). Pendiente del canon (`notacion.md` § 1).
- **A07-06. Sincronización** (D3): Ball y Romer (1989) en lugar de Ball (1987).
- **A07-07. Citas no encontradas** (D4): «Stigler» (reserva de capacidad) y «Milgram» (rotación) se quitan; la reserva de capacidad queda sin autor y la rotación pasa a Salop (1979). En II y III: la definición de Heijdra y van der Ploeg entre comillas se quita (no se pudo comprobar) y la idea se cuenta sin cita en la caja de equilibrios múltiples; McCallum (2004), fuera; «Blanchard (2010)» sobre el estímulo fiscal, fuera (el estímulo se cita con la nota del FMI de 2008, de la que Blanchard es coautor); «Gertler et al. (2010)» sobre la regulación, fuera (se citan Gertler y Kiyotaki, 2010, y Gertler y Karadi, 2011, por los bancos en el modelo, sin atribuirles la frase del original); la frase de que Taylor «revivió argumentos contra el activismo fiscal», sin fuente, fuera.
- **A07-08. Akerlof y Yellen (1991)** (V23): capítulo del libro en homenaje a Tobin con **una sola fuente** (eumed.net) y sin páginas. Se mantiene la cita (es del original).
- **A07-09. Cuerpo y Quesada (2016)**: el coordinador pidió fuera «ICEX-CECO»; se han quitado el comentario, el nombre del coordinador y la ruta local, pero la obra se mantiene en la bibliografía como en el original, con su editorial, como manda CRITERIOS § 2 y § 4 («se citan como en el tema original») y como hace el 3.A.27. Si Víctor prefiere quitarla, basta con borrar la entrada `CuerpoQuesada2016` y su `\nocite`, al final del `.tex` (no se cita en el texto).
- **A07-10. Hall (1976)**: el trabajo de Hall no está publicado ni se ha podido leer; se cita con su perfil de Stanford, donde él mismo da el año (V6).
- **A07-11. Gráfico de la casi racionalidad**: se mantiene (rehecho, de apoyo), con los mismos números que el de los costes de menú.

- **A07-12. Reparto de II y III** (decisión del coordinador): el principio de Taylor, la pérdida, la divina coincidencia y su ruptura (Blanchard y Galí, 2007 y 2010) van en las implicaciones del modelo canónico (II.2 iii), y III.1 queda para la política monetaria en la práctica (objetivos, credibilidad, variables naturales, límite inferior, *forward guidance*, fricciones financieras) y la fiscal. En el Word estaban todas en 2.2.3.
- **A07-13. Gráfico de la regla de Taylor** (D1): solo una frase con las cifras de 2020 y 2022; el gráfico, para el 3.A.36 (el CSV queda preparado). Regla original con r* = 2 (D2).
- **A07-14. Tipo sombra** (D6): una frase, sin gráfico (serie terminada en 2022 y sin segunda fuente).
- **A07-15. Gráfico de la frecuencia de precios** (D5): sí, en III.2, con la referencia de Estados Unidos.
- **A07-16. λ_x = κ/σ** (D5 de contenido): se escribe; es el peso de la aproximación de segundo orden del modelo básico (Galí, 2015, cap. 4, con ε en lugar de σ). **Resuelta**: coincide con Galí (2015, cap. 4), que lo escribe κ/ε (A07-22).
- **A07-17. Utilidad CRRA con −1** (DK6 del 3.A.43): $(C^{1-\theta}-1)/(1-\theta)$, como pide coherencia.
- **A07-18. Producción natural eficiente**: para que la divina coincidencia y la pérdida se lean como se cuentan, se supone un subsidio que corrige el margen de monopolio; se dice en una frase al justificar la pérdida.
- **A07-19. Smets y Wouters** salen 2 veces (extensiones de II.2 y nueva síntesis): en III.2 solo como herramienta de los bancos centrales.
- **A07-20. Pegatina opcional** «quien avisa no es traidor» (*forward guidance*, K27): no se usa, para no pasar de las 5 del coordinador.
- **A07-21. Ejemplo de costes de menú frente al gráfico** (control de calidad): el gráfico dibuja una caída de la demanda y el ejemplo del test de 2021 una subida. Se mantienen los 2: el gráfico no puede dibujar una subida con el punto B (con la subida, la empresa vende más si no ajusta). Recomendado y pedido al editor: decirlo en el texto y dar también las cifras del gráfico (ajustar da 10; no ajustar le cuesta 35 a la sociedad).
- **A07-22. λ_x = κ/σ** (A07-16): coincide con Galí (2015, cap. 4), que escribe κ/ε con ε como elasticidad de sustitución. Con la notación del temario (σ) es lo mismo. No hace falta cambiarlo.
- Control de calidad (04/11/2026): con correcciones. 10 se devuelven a `tema-editor-lyx` y 3 a `tema-tikz`; las más importantes son la cabecera invisible del cuadro de las 2 generaciones en el HTML, los nombres de autor sin unificar (en el HTML salen «B. Bernanke», «O. Blanchard» y «Paul P. Romer») y la letra diminuta de `nek-esquema`. Tras corregirlas, reconstruir y repasar.

- Control de calidad (4/11/2026): correcciones aplicadas. El ejemplo de los costes de menú enlaza ya con el gráfico (la misma empresa con los precios en decenas ante una caída de la demanda: ajustar da 10 más de beneficio y no ajustar cuesta 35 a la sociedad) y explica por qué con la subida del test el excedente total sube; cabecera del cuadro de generaciones sin color; «tabla~\ref» en lugar de «cuadro~\ref»; los rendimientos decrecientes en el tamaño del triángulo; nombres unificados en el `.bib` («Blanchard, Olivier J.», «Bernanke, Ben S.», «Christiano, Lawrence J.», «Wouters, Rafael»); `GoodfriendKing1997New` con DOI y «Cambridge (Massachusetts)»; Paul Romer (2016) citado con `\parencite*` (comprobado con el pandoc de Quarto: sale «Paul Romer (2016)»). Para que la idea final no quede sola, un `\clearpage` antes de la conclusión (con su comentario): la conclusión entera pasa a la p. 27; si cambia la paginación, quitarlo.

## Instrucciones para el vídeo

### Parte 1 (introducción y bloque I)

- **Introducción** (2′30″, sin pizarra, `modo: guion`): enganche con el refrán «por un clavo se pierde una herradura» y el dato del 8 % al 12 % (dicho, no escrito); la pregunta del enganche se apunta a la izquierda y vuelve en la idea final. Las definiciones de rigidez nominal y real se dicen en la contextualización.
- **Rejilla**: 3 zonas fijas durante todo el cante. Izquierda (~20 %): refrán y pegatinas. Centro (~50 %): gráficos. Derecha (~30 %): en I, la lista de autores de la 1.ª generación en 2 líneas; desde II.2, las 3 funciones clave.
- **I.1** (3′): en la pizarra solo la lista de autores (apellidos) y «agua salada / agua dulce»; lo demás, de palabra (`guion:`) y con `apunte:` para Mankiw y Romer (1991) y el «refuerzo de la síntesis por el lado de la oferta».
- **I.2.1** (4′): `costes-menu` es **imprescindible** y se dibuja por capas en el centro (ejes → CMg → D e IMg → A → D' e IMg' → C → B → triángulo → trapecio), diciendo cada pieza mientras se traza; el ejemplo numérico del test (250) como `apunte:`. `casi-racionalidad`, como **apoyo** (no se dibuja) al decir la pérdida de segundo orden; la fórmula (`eq:perdida-segundo-orden`) sí se escribe. Blanchard-Kiyotaki: se escribe la demanda (`eq:demanda-bk`) y la pegatina «entre todos la mataron y ella sola se murió» a la izquierda. Reglas de tiempo y de estado, de palabra.
- **I.2.2** (1′30″): se escribe solo $p^*_i=\chi\,m+(1-\chi)\,p$; los mercados de clientes y la colusión contracíclica, de palabra.
- **I.2.3** (1′30″): de palabra los salarios de eficiencia (con $\varepsilon_{e,w}=1$ escrita) y los contratos implícitos; WS y PS se escriben y `ws-ps` sale como **apoyo** (si da tiempo, se dibuja en 20 s); histéresis, de palabra.
- **I.3** (1′): de palabra; al terminar se borra el centro (el gráfico de los costes de menú) y la lista de autores, y se deja la izquierda.

### Parte 2 (bloques II y III y conclusión)

- **II.1** (2′): de palabra, con `apunte:` para los autores, «apalancamiento sobre la NMC» y las 4 letras del EGDE; la pegatina «si no puedes con tu enemigo, únete a él» a la izquierda; `tab:generaciones` como **apoyo**.
- **II.2** (7′), el centro de la pizarra: supuestos de palabra (30″). A la derecha, y **recuadradas**, la IS dinámica, la NKPC y la regla de Taylor, escritas mientras se explican (1′15″, 2′ y 45″), que se **conservan hasta el final** (`conservar:`); κ junto a la NKPC. El problema del hogar y el precio de reajuste, como **apoyo**; «más vale tarde que nunca» junto a la NKPC. `nek-esquema` como **apoyo** al cerrar el modelo. `nek-xpi` es **imprescindible** y se construye por partes en el centro: panel a (ejes, NKPC, DA, E₀, DA′ y la flecha de vuelta: divina coincidencia, «matar dos pájaros de un tiro») y después el panel b (NKPC′: el dilema). El principio de Taylor `eq:determinacion` se escribe bajo la regla, con «más vale pasarse que quedarse corto»; la pérdida `eq:perdida`, en el centro bajo el gráfico. Blanchard y Galí (2010), de palabra. Extensiones, evidencia y valoración, de palabra (45″).
- **III** (6′30″), casi todo de palabra, con la pizarra de II.2 a la vista: en III.1, `apunte:` con el objetivo del 2 %, la paradoja de la orientación y el tipo sombra; en III.2, `tab:nueva-sintesis` y `frecuencia-precios` como **apoyo** (el 8 % → 12 % se dice).
- **Conclusión** (1′, sin pizarra): empieza «En conclusión,». Al final la pizarra queda con las 3 funciones clave, `nek-xpi` y la columna de refranes. **Idea final**: «por un clavo se pierde una herradura» (el clavo es la pequeña fricción; desde 2008 sabemos que no era el único clavo suelto), que responde a la pregunta del enganche.
