# Revisión del tema 3.A.43 — Crecimiento económico (I)

*Informe de la fase de integración (31/10/2026), escrito en 2 partes: la 1.ª, introducción, I y II; la 2.ª, III, conclusión y anexos A-G.*

## Resumen

- El original era el tema del **título anterior** (I. Harrod-Domar, II. Solow, III. RCK; MRW en una línea). La estructura nueva (decisión del coordinador, DK1/DK2 de coherencia) es: **I. El modelo de Solow** (I.1 Idea: de Harrod y Domar a Solow, 1′30″; I.2 El modelo, 7′; I.3 Evidencia y valoración, 1′30″), **II. Solow aumentado con capital humano (MRW) y otras extensiones** (II.1 MRW, 4′; II.2 trampas de pobreza, recursos naturales, dinero, 2 sectores y puente al crecimiento endógeno, 1′30″) y **III. Ramsey-Cass-Koopmans** (11′). Introducción 2′30″ y conclusión 1′: total 30′.
- Harrod-Domar pasa a antecedente en I.1 a) (2 ideas: tasa garantizada inestable y tasa natural; el «filo de la navaja» de Solow, 1956, p. 65, y el puente $s/v^*=n+g+\delta$); el desarrollo completo va al anexo A, que funde los anexos 2 y 3 del original con el factor ocioso corregido. Nada se borra.
- El progreso técnico exógeno entra desde el principio: $Y=F(K,AL)$, $k\equiv K/(AL)$ sin marca, una sola ecuación fundamental con $n+g+\delta$ (`eq:solow`) y una sola regla de oro (`eq:regla-oro`); la lectura «con $g=0$» de la nota de Víctor se conserva como viñeta y en la nota del cante.
- MRW (el epígrafe que faltaba) tiene ahora un subapartado entero con los bloques a)-e), la ecuación de la renta en logaritmos como función clave (`eq:mrw-renta`) y sus cifras comprobadas.
- RCK en unidades eficientes con $\theta g$ (antes, con $A_t$ dentro de las ecuaciones per cápita y sin estado estacionario si $A$ crecía), hamiltoniano en valor corriente en el cuerpo, ecuación de Euler en sus 2 formas (por persona, para el 3.B.31, y por unidad eficiente), regla de oro modificada $f'(k^*)=\rho+\delta+\theta g$ con tabla comparativa, análisis normativo y sector público redactados de nuevo (el original los copiaba de ICEX-CECO) y evidencia y crecimiento exógeno, que estaban vacíos.
- Anexos: A Harrod-Domar; B neutralidades y teorema de Uzawa con demostración (Jones y Scrimgeour) y la ecuación con trabajo eficiente ($m\to g$, signo corregido); C velocidad de convergencia en Solow, MRW y RCK; D control óptimo (copia literal del 3.A.34 en ff3e63bd salvo las 2 autorremisiones, cambiadas por el coordinador, con la clave `Acemoglu2009` y la caja de aviso de letras); E el RCK paso a paso, el planificador y las demostraciones del 1TFEB y del 2TFEB; F causas próximas y últimas; G test (enlace al simulador).
- Enganche nuevo: el frenazo del crecimiento soviético (Krugman, 1994; Easterly y Fischer, 1995), con el refrán «Poco a poco se va lejos»; Nogales y su foto se reservan al 3.A.45.
- Todo lo que el original copiaba de ICEX-CECO en I y II (duración de la transición) está redactado de nuevo; pasado `ngramas.py` contra Tebar, Cabado, Cerezal (42A) y el original (también tras la parte 2; se reescribieron 3 frases que coincidían con Cabado y Cerezal): solo quedan coincidencias técnicas («tasa de ahorro de la regla de oro», «progreso técnico neutral en el sentido de Harrod», la ecuación fundamental) y las citas literales en inglés del original.

## Errores corregidos

(Introducción, I y II.)

- «La inversión agregada es una fracción de la renta nacional $(1-s)$» → $s$ (C6, K10).
- El «filo de la navaja» no es de Joan Robinson: es la expresión de Solow (1956, p. 65) (C5).
- El teorema de Uzawa atribuido a Phelps y como condición «necesaria y suficiente» → Uzawa (1961), condición necesaria (C10, V23).
- Remisión doble del tamaño indeterminado de la empresa («3.A.11 y 3.A.12» / «3.A.10 y 3.A.11») → `\vertema{3.A.11}` `\vertema{3.A.16}` (C9).
- «$\dot K_t=n\Rightarrow\dot Y_t=n$» (punto como tasa) → $\gamma_K=\gamma_Y=\gamma_C=n+g$; el punto es siempre la derivada (C12, K7).
- Regla de oro de Phelps fechada en 1966 → 1961 (el libro es de 1966) (C13, V2); regla de oro sin $g$ → $f'(k_{\mathrm{oro}})=n+g+\delta$; «hemos de aumentar la tasa de oro» → «subir la tasa de ahorro hasta $s_{\mathrm{oro}}$»; «ineficiencia dinámica en la transición» → propiedad del estado estacionario.
- Tabla 1 de estática comparativa: la fila de $A$ (con «Α» griega) daba +, +, +, + y −; un salto de $A_0$ no cambia $k^*$, $y^*$, $c^*$ ni $f'(k^*)$ (están en unidades eficientes) y sube el nivel de $Y/L$; el «¿?» de $c^*$ ante $s$ se resuelve con la regla de oro; la columna $r^*$ pasa a $f'(k^*)$ (el tipo neto es ambiguo ante $\delta$); $w^*$ se sustituye por el nivel de $Y/L$ (C15, K12).
- «Nieves de capital» → «niveles» (C17).
- Koopmans (1963) → 1965 (C19, V3).
- Residuo de Solow: «1909 hasta 1948… 12 %… 88 %» → 1909-1949, 12,5 % y 87,5 % del aumento de la **producción por hora** (V1).
- Nota 12: «el modelo de Solow es un caso particular del de Harrod» → al revés: Harrod-Domar es el caso límite de Solow con elasticidad de sustitución nula (C39).
- Nota 15 (Cobb-Douglas): «estrictamente convexa» → estrictamente cuasicóncava; «homotética ⇒ forma polar de Gorman» → solo homotética; el 70/30 de Douglas → estimación de 1928 de unas tres cuartas partes para el trabajo; senador «1949-1966» → 1949-1967; «linear» → lineal (C37, V14).
- Notas 5 y 14 («tiempo discreto») quitadas: el tema está en tiempo continuo (C44, D6).
- Nota 19: la afirmación «Inada implica asintóticamente Cobb-Douglas» ahora con fuente (Barelli y Pessôa, 2003) y su matiz (Litina y Palivos, 2008) (C38, V22).
- Recursos naturales: «Ver Hryshko (2010)» (no localizada) → Romer (2019, cap. 1), Nordhaus (1992), Solow (1974) y Stiglitz (1974) (V19).
- Solow con dinero: «los monetaristas concluyeron que la inflación afecta al crecimiento» → Tobin (1965), efecto nivel, y la superneutralidad de Sidrauski (1967) (C24, V20).
- Trampas de pobreza: «el propio Solow matiza» → la trampa es de la literatura posterior (Azariadis y Drazen, 1990) (C22, P1).

- RCK: $\theta\in[0,1]$ → $\theta>0$; «con $\theta=1$, máxima concavidad» → la concavidad crece con $\theta$; ESI $\equiv\sigma$ → $1/\theta$ sin símbolo; «$\rho$ factor de descuento» → tasa; $\rho>n$ → $\rho-n>(1-\theta)g$ (C26).
- RCK con $A_t$ dentro de las ecuaciones per cápita y un «$k^{SS}$» que dependía de $A_t$: con $g>0$ no había estado estacionario. Ahora todo por unidad eficiente (C27).
- «$\lambda_t$, precio sombra del capital» en el problema del hogar → valor sombra de los activos $b_t$; «la suma de activos financieros es cero, $b=k$» → se cancelan los préstamos entre hogares y los activos netos son el capital (C27).
- Regla de oro modificada sin $\theta g$ (nota 59 con $A_t$ dentro) → $f'(k^*)=\rho+\delta+\theta g$ (C28).
- «productividad marginal del **trabajo** mayor» → del capital (C28, C31).
- Notas 50 y 54 (Ponzi) duplicadas → una; nota 51 («idéntico al problema del consumidor del tema 3.A.29») → «es el problema del consumidor con horizonte infinito \vertema{3.A.29}»; nota 52 (transversalidad «ad hoc») → necesaria en condiciones generales (Michel, 1982); nota 39 (tiempo discreto) quitada; nota 53 completada con los 3 efectos; nota 56 reescrita en el texto; nota 58 («la velocidad del RCK suele ser mayor porque se ahorra más») → depende de $\theta$ (C29, C43, C44, C46).
- Nota 36: el «precio de Ramsey, trayectoria óptima del precio de un monopolista» → regla de Ramsey de la imposición óptima y su aplicación por Boiteux; sin enlace a Wikipedia (C40, V15).
- Nota 42 (Gorman): la pendiente $b(\vect{p})$ tiene que ser común a todos los hogares (C41).
- Nota 48: la cita en inglés atribuida a Strotz no es literal (se da el resultado sin comillas) y la función hiperbólica es de Loewenstein y Prelec (1992), no de Thaler; sin el gráfico (C42, V21).
- Análisis normativo copiado (amarillos 4-15): remitía a ecuaciones (15)-(26) inexistentes, mezclaba $B_t$ y $b_t$ y hablaba de «un continuo de asignaciones eficientes» con un hogar representativo (C31).
- Sector público: «más gasto improductivo lleva a más acumulación de capital… igual capital» (contradicción) → el capital no cambia con el gasto permanente; «trabajo ofertado de forma perfectamente elástica» → inelástica; «el impuesto sobre la riqueza es más grave» → equivale a uno sobre las rentas del capital de tipo equivalente (C33).
- Anexo de Harrod-Domar: el factor ocioso estaba al revés (con $k<v/a_L$ sobra **trabajo**, no capital); la $\sigma$ de Domar pasa a $1/v$; la $A$ y la $B$ de Barro y Sala-i-Martín pasan a $1/v$ y $1/a_L$; ecuación de Domar mal escrita; «filo de la navaja» de Robinson → de Solow (C47, P51).
- Anexo 4: signo $-(\delta-m-n)$ → $-(n+g+\delta)$ y $m\to g$ (C21).

## Marcas resueltas

| Marca | Texto original (resumen) | Qué se ha hecho |
|---|---|---|
| P1, amarillo 1 | «el propio Solow matiza que pueden existir trampas de pobreza… (se podrían seguir cumpliendo las condiciones de Inada)» | Desarrollado en II.2 con los bloques a)-d), gráfico `trampa-pobreza` y atribución corregida; la frase sobre Inada se conserva y se explica |
| P2, amarillo 2 | Anuncio traducido de Acemoglu de un «modelo aumentado de Solow… y regresiones» | Sustituido por la evidencia de verdad (I.3 c) y el MRW de II.1, con la estimación remitida al 3.A.45 |
| P3, amarillo 3 | Residuo de Solow «1909-1948, 12 %, 88 %» | Corregido (V1) y en una viñeta con `\vertema{3.A.45}` |
| P7, notas 1-3 | Aviso del cambio de temario | Desaparecen; se hace lo que piden (MRW en lugar de Harrod-Domar) |
| P8, nota 4 e imagen de la guía | Debate de Cambridge | Caja gris en los supuestos de Solow con Robinson (1953), Sraffa (1960) y Samuelson (1966), `\vertema{3.A.4}` |
| P9, nota 6 | Harrod-Domar «5′ como mucho» | Antecedente en I.1 a); desarrollo completo en el anexo A |
| P10, nota 7 | «Aprovechar para hilar con el siguiente modelo» | El puente $s/v^*=n+g+\delta$ y la cita de Solow (1956) en nota |
| P11, notas 8-14 | Orden alternativo para contar Solow | Se conserva en la nota del cante del apartado I y en la viñeta «Empecemos con $g=0$»; el modelo se escribe una sola vez con $n+g+\delta$ |
| P12, nota 15 | «Ver capítulo 2 Sala-i-Martín» | Usado en las extensiones (trampas de pobreza) |
| P13, nota 16 | MRW «necesario desarrollar» | II.1 completo (C20) |
| P14, nota 17 | AK, Sobelow y Barro de pasada | II.2, «Hacia el crecimiento endógeno», con `\vertema{3.A.44}` y `\vertema{3.A.38}` |
| P15, notas 18-19 | Evidencia de Solow y hechos de Kaldor | Caja de Kaldor en la introducción con datos de EE. UU. y gráfico; I.3 c) con los 5 de 6, el residuo y la convergencia |
| P17, comentario inicial | Falta estática comparativa, extensiones y velocidad de convergencia | Estática comparativa con gráfico y tabla; extensiones en II.2; velocidad de convergencia redactada de nuevo, con su derivación en el anexo C |
| P19, comentario | Uzawa («ver clase…») | Caja gris del teorema de Uzawa con fuentes publicadas; el comentario no se publica |
| P22, comentarios | Introducción con Sala-i-Martín/Acemoglu; «Estructura» vacía | Introducción con los 5 bloques; estructura redactada y esquema |
| P23, cajas de anotaciones | 4 enlaces con opiniones de trabajo | Caja «Para saber más» con los 4 enlaces y el vídeo de la UVa, sin opiniones; canal corregido («Economics Explained») y sin el parámetro `list` |
| P25 | Imagen 1, superficie (Fuleky, enlace roto) | Gráfico `funcion-produccion` (pgfplots, perspectiva del canon), elaboración propia |
| P26-P30 | Imágenes 2-5 y Tabla 1 | Gráficos `solow`, `consumo-ahorro`, `ineficiencia-dinamica` (con la senda contraria), `solow-tasas`, `solow-ahorro`; tabla `tab:estatica-solow` corregida y con color; la derivación manuscrita de $s_{\mathrm{oro}}=\alpha$ pasada a ecuaciones |
| P31 | Tabla de Inada | Reducida a las 6 condiciones que importan (`tab:inada`); en el III se remitirá con `\ref` |
| P32 | Recuadro de notación | Caja gris con la notación del canon ($k$, $y$, $c$ sin virgulilla; punto = derivada; $\gamma_X$) |
| P43 | Foto de Nogales sin licencia | Quitada con el enganche (decisión del coordinador: Nogales se reserva al 3.A.45) |
| P44 | Gráficos en notas 20 y 22 | Nota 20: `\graficonota{solow-no-existencia}`; nota 22: las 3 neutralidades en la caja de Uzawa, con `\vertema{3.A.11}`, sin gráfico (es el de la ficha `progreso-tecnico-neutral`) |
| P57 | Comentarios privados, nombres de profesores, «copiado de ICEX-CECO» | Nada publicado; tramo de la duración de la transición redactado de nuevo |

| P4, amarillos 4-15 | Teoremas del bienestar en el RCK (copiados de ICEX-CECO) | Redactados de nuevo: idea y enunciados en III.2, planificador y demostraciones con `\findemo` en el anexo E |
| P5, amarillo 16 | Gobierno en el RCK (copiado de ICEX-CECO) | Redactado de nuevo en III.3 c): gasto permanente y temporal, impuestos, Chamley-Judd y equivalencia ricardiana |
| P6, rojos 1-5 | Aspas de la tabla de Leontief | Comprobadas (correctas) y pasadas a la tabla `tab:leontief-inada` con ✓ en verde y × en rojo |
| P16, notas 20-23 | 1TFEB en Solow y planificador | «¿Y en Solow?»: no falla el 1TFEB, no se puede plantear (III.2) |
| P18 | Recurso natural, DICE, dinero, 2 sectores | Recurso, dinero y 2 sectores en II.2; DICE en III.3 c) con `\vertema{3.B.31}` |
| P20, comentarios | Versión descentralizada y planificador | Es la estructura del III; los comentarios no se publican |
| P24 | Bibliografía y quia.com | `.bib` completo; anexo G con el simulador; sin el tema de Cordero |
| P33-P36 | Imágenes 6-9 (la 9 sin fuente) | Fundidas en `rck-fases` (Acemoglu, 2009, fig. 8.1, y Romer) |
| P37 | 4 gráficos de estática comparativa sin título | `rck-rho` con texto y fuente (Romer, fig. 2.6) |
| P38 | Imagen 10 sin fuente (diapositivas de la UCM) | `rck-theta`, elaboración propia a partir de Barro y Sala-i-Martín |
| P39-P41 | Imágenes 11-12 y 3 sin título | `rck-gasto` y `rck-impuesto` (Barro y Sala-i-Martín, figs. 3.1 y 3.2; Romer, 2.8 y 2.9; Acemoglu, 8.2) |
| P42 | Imágenes 13-16 del anexo 3 | `hd-produccion`, `hd-caso1`, `hd-caso2` y `hd-caso3` |
| P45 | Capturas en inglés (Campante) y de Jones (2023) | Redactada la condición de utilidad acotada; Jones (2023) citado en la relevancia y la idea final |
| P50 | Supuestos del RCK repetidos, θ, Koopmans, $W_t$ | Solo «lo que cambia», con `\ref`; errores de θ corregidos; $w_t$ |
| P51 | Factor ocioso del anexo 3 | Corregido |
| P22, «Relevancia» de la conclusión vacía | — | Redactada |

## Datos actualizados

| Dato | Antes | Ahora | Fuente |
|---|---|---|---|
| Residuo de Solow | 1909-1948, 12/88 % | 1909-1949, 12,5/87,5 % de la producción por hora | Solow (1957), pp. 316 y 320 (V1) |
| Phelps, Koopmans | 1966, 1963 | 1961, 1965 | V2, V3 |
| MRW | Sin cifras | $R^2$ 0,59 con α implícita 0,60 (Solow); 0,78 con α ≈ 0,31 y β ≈ 0,28 (ampliado); convergencia 1,4-2 % | MRW (1992), tablas I, II y V (V6, V7) |
| MRW con datos actuales (nuevo) | — | 1960-2023, 78 países: α implícita 0,64, $R^2$ 0,54; con capital humano, 0,76 | PWT 11.0 (V8) |
| Hechos de Kaldor (nuevo) | — | EE. UU.: K/Y 3,8 (1960) y 3,2 (2023), rentabilidad ≈8 %, participación del trabajo 63,7 % → 56,8 %; España, K/Y creciente | PWT 11.0 y AMECO (V9) |
| Crecimiento de EE. UU. (nuevo) | Captura de Jones (2023) | «Cerca del 2 % desde la posguerra (1,96 %, BEA 1947-2025) y algo menos desde 1870 (1,64 %, Maddison 1870-2022)» | V10 |
| Convergencia (nuevo) | Kremer *et al.* (2021) | Sin convergencia absoluta en 1960-2023 salvo en la OCDE; algo desde 2000, «lenta y sensible a la base de datos»; Kremer *et al.* fechado en 2022 (volumen de 2021) | PWT 11.0, Maddison (V11) |
| Lucas, Nobel 1995 | Motivación incompleta | Motivación oficial completa | V13 |

## Contenido añadido

- Introducción: enganche soviético con refrán; relevancia con el interés compuesto y la serie de EE. UU. (gráfico de datos); definiciones (crecimiento, senda equilibrada, estado estacionario, convergencia, causas próximas y últimas); caja de los hechos de Kaldor con gráfico de datos; estructura redactada; esquema; nota del reparto del cante y del plan de la pizarra.
- I: puente Harrod-Domar → Solow; supuestos con progreso técnico desde el principio; tabla de Inada; cajas de Uzawa y de la controversia del capital; caja de notación; estado estacionario con Cobb-Douglas; senda equilibrada y Kaldor; regla de oro con $g$ y $s_{\mathrm{oro}}=\alpha$; ineficiencia y eficiencia dinámica (pegatina «la avaricia rompe el saco»); estática comparativa completa con gráfico y tabla; velocidad de convergencia (λ = 4 %, semivida de 17 años); implicaciones (convergencia absoluta, condicional y en tasas; paradoja de Lucas); evidencia (Kaldor, residuo, convergencia con gráfico de datos, MRW); valoración en 3 limitaciones que abren II, III y el 3.A.44.
- II: MRW con a)-e) (supuestos, acumulación, estado estacionario, ecuación de la renta, segunda forma con $h^*$ y el sesgo de omitir el capital humano, elasticidades, λ = 2 %, regla de oro con $s_K=\alpha$ y $s_H=\beta$; extensiones de Hall y Jones y la contabilidad del desarrollo; evidencia de MRW y con datos actuales; valoración); trampas de pobreza (pegatina «al perro flaco todo son pulgas»); recursos naturales con su tasa de crecimiento; dinero (Tobin, Sidrauski); 2 sectores (Uzawa); puente al crecimiento endógeno (AK, Sobelow, Barro).

- III: idea con las notas de Ramsey, Koopmans y la microfundamentación; supuestos solo con lo que cambia (utilidad CRRA con el −1, descuento, tamaño del hogar, restricción por persona, no Ponzi, utilidad acotada); hogar con el hamiltoniano en valor corriente y la ecuación de Euler en 2 formas (y su lectura como fórmula de Ramsey del descuento); equilibrio y ecuación de acumulación; diagrama de fases y punto de silla con Cobb-Douglas ($k^*$, $s^*$); caída de ρ; planificador, 1TFEB y 2TFEB; regla de oro modificada con tabla; convergencia y velocidad según θ, tasa de ahorro en la transición; crecimiento exógeno; sector público (gasto permanente y temporal, equivalencia ricardiana, impuestos, Chamley-Judd); clima (DICE) y ciclos reales; evidencia (velocidad, ahorro en Asia, eficiencia dinámica, tipo natural) y valoración.
- Conclusión con sus 5 bloques, empezando por «En conclusión,», y la idea final con el refrán.
- Anexos A-G (ver «Resumen»).

### Propuestas aplicadas y no aplicadas (parte 1)

- **Contenido (C1-C24, C37-C39, C44, C45, C53, C54)**: aplicadas C2 (salvo Nogales, foto y datos [dato], por decisión del coordinador), C3 (en caja de la introducción, como pide coherencia K5, no como párrafo de I.1), C4-C20, C22-C24, C37-C39, C44 (notas 5 y 14), C45 (fundida en la caja de Uzawa). C1 no se aplica tal cual: la estructura y los minutos son los de coherencia (DK1/DK2) por decisión del coordinador. C21 (anexo 4) y C23 (DICE) se completan en la parte 2 (anexo B; DICE en III.3). En C15 no se pone la fila de $s_H$ en la tabla (coherencia K12: el efecto de $s_H$ se cuenta en II.1 iii). En C20 se añade el bloque c) Extensiones (Hall y Jones; K21) y no se usa la pegatina «el saber no ocupa lugar» (el coordinador fijó solo 2 pegatinas).
- **Contenido, parte 2 (C25-C36, C40-C43, C46-C51)**: aplicadas, con estos cambios: la estructura del III es la de coherencia (III.1 descentralizada con el diagrama y la caída de ρ; III.2 normativo con planificador, regla de oro modificada, convergencia y crecimiento exógeno; III.3 c)-e)); el hamiltoniano del cuerpo va en valor corriente (DK7) y el de valor presente, en el anexo E; las ecuaciones recuadradas son `eq:euler-rck` (con las 2 formas, K17), `eq:acumulacion-rck` y `eq:regla-oro-modificada` en lugar de `eq:rck-sistema`; las etiquetas `sec:rck-bienestar`, `anexo:teoremas-rck` y `anexo:velocidad` de contenido pasan a `sec:rck-normativo`, `anexo:rck` y `anexo:convergencia`; en el anexo A la Leontief se escribe con $a_L$ (DK9) y no con $\overline y$; en el anexo C no se usa la $m$ local (se escribe $n+g+\delta$). C36: la idea final retoma el enganche soviético (no Nogales). C50: se copia el anexo cerrado del 3.A.34. C51: sin la mención a Nogales.
- **Datos (V1-V54)**: aplicadas; V12 y V44 (Nogales) no aplican; V17 (Barro y Sala-i-Martín) se cita en la edición inglesa de 2004, la que da las figuras 3.1 y 3.2; V18 (Easterly) en la española de 2003; V33 (la cita de *The Economist*) no se usa porque no se pudo comprobar; V38 (UCM) solo como origen de la imagen sustituida; V42 (Fuleky) se sustituye por elaboración propia; V50-V51 (Wikipedia) fuera.
- **Coherencia (K1-K14, K19, K21, K25, K27, K27 bis; DK1-DK5, DK11, DK12)**: aplicadas. K6 se funde con C4; K11 con C19. K2 con su esquema; K27 con el plan de la pizarra.
- **Pendientes P1-P57**: todos resueltos (ver «Marcas resueltas»); P21, P52-P56 en «Coherencia».
- **Coherencia, parte 2 (K15-K20, K22-K26; DK6-DK10, DK13)**: aplicadas. K24 adaptado a la idea final del refrán.

## Coherencia

- Notación del canon: $k$, $y$, $c$, $h$ por unidad de trabajo eficiente sin marca; lo per cápita como cociente ($Y/L$, $\gamma_{Y/L}$); $n+g+\delta$ en todo el tema; $w$ salario real y $f'(k)=r+\delta$; $\gamma_X$ como tasa; λ (sin subíndice) velocidad de convergencia; tiempo continuo; $\alpha_R$, $\alpha_T$ en recursos naturales; $v$ en Harrod-Domar; β elasticidad del capital humano (D107).
- Letras locales nuevas, avisadas en nota: $\phi(S)$ en Hall y Jones (en el canon, φ es la inversa de Frisch, que no sale en el tema); $b$ tasa de agotamiento del recurso (en el III, $b_t$ son los activos); $A$ y $B$ de la función *Sobelow* (Jones y Manuelli), solo en esa viñeta.
- Remisiones añadidas: 3.A.4 (controversia del capital), 3.A.11 y 3.A.16 (rendimientos constantes, neutralidades), 3.A.23 (tecnología como bien público), 3.A.25 (capital humano, Mincer), 3.A.34 (acelerador, costes de ajuste), 3.A.38 (Barro, 1990), 3.A.41 (Tobin, Sidrauski), 3.A.44, 3.A.45, 3.B.28 (trampas de pobreza).
- Contradicción con otros temas (no se tocan): Nogales es el enganche de los Word del 3.A.43, 3.A.44 y 3.A.45 (aquí se cambia; queda para el 3.A.45); la ficha `trampas-pobreza` remite al 3.B.42 y el tema de desarrollo es el 3.B.28 (CC6); el Word del 3.B.28 repite «Solow matiza» las trampas.

- III: CRRA con el −1 (como 3.A.8 y 3.A.33; nota de que el 3.B.31 lo omite); θ>0; utilidad acotada $\rho-n>(1-\theta)g$; $w_t$ real; $b_t$ activos por persona; $\mathcal{H}$ en valor corriente con $\lambda_t$ en el cuerpo y $\mathcal{H}^0$, $\lambda^0_t$ en el anexo E; $\lambda^{\mathrm{P}}_t$ (coestado del planificador, letra local nueva para `notacion.md` § 7); transversalidad $\lim e^{-(\rho-n)t}\lambda_tb_t=0$ (CC3).
- Euler en 2 formas para que se cumpla la remisión del 3.B.31 («$\gamma_c\simeq(r-\rho)/\theta$ \vertema{3.A.43}», con $c$ por habitante).
- Remisiones añadidas en el III y anexos: 3.A.1, 3.A.8, 3.A.9, 3.A.10, 3.A.17, 3.A.21, 3.A.22, 3.A.25, 3.A.29, 3.A.33, 3.A.38, 3.A.39, 3.A.42, 3.B.31.
- **Anexo de control óptimo**: copia literal del 3.A.34 (ff3e63bd) salvo las 2 autorremisiones, que cambió el coordinador: «el crecimiento óptimo \vertema{3.A.43}» pasa a «de este tema» y «de inversión de este tema» pasa a «de inversión \vertema{3.A.34}». Se mantiene el ejemplo final de Jorgenson y la q. Si la pieza común cambia, hay que recopiarla (ver A43-07).
- Para `canon/pendientes-coherencia.md` (no lo toca este agente): la ficha `optimizacion-dinamica` podría decir «los modelos de crecimiento óptimo \vertema{3.A.43} y de inversión \vertema{3.A.34}» para que la pieza se copie sin retoques.

## Dudas abiertas

Víctor está fuera hasta el 9/11: se aplica la opción recomendada.

- **A43-01 — Letras de los bloques repartidas entre subapartados.** Solow lleva a) en I.1, b) en I.2 y c)-d) en I.3, como fijó el coordinador (bloques del original agrupados en 3 subapartados). `verificar-tema.py` cuenta las letras por subapartado y avisa («no seguidas: b)» y «c), d)»). Recomendada: dejarlo así (es solo un aviso y la secuencia del modelo es a-d sin huecos); alternativa, quitar las letras de I.2 e I.3.
- **A43-02 — Fila de $s_H$ en la tabla de estática comparativa de Solow.** Contenido la ponía; coherencia (K12) no. Aplicada: sin fila; el efecto de $s_H$ va en II.1 iii).
- **A43-03 — Anécdota de Jruschov (1956).** El «os enterraremos» es la frase conocida de la recepción de noviembre de 1956; se cuenta sin comillas y sin cita propia (Krugman, 1994, y Easterly y Fischer, 1995, se citan para la tesis de la acumulación). Comprobar si se quiere una fuente para la anécdota.
- **A43-04 — Página de las 2 citas de Solow (1956).** El «filo de la navaja» se cita en la p. 65 (coordinador, V5) y «The bulk of this paper…» en la p. 66 (V27: página por confirmar).
- **A43-05 — Tabla de Inada reducida.** De 10 condiciones (2 columnas) a 6 (esencialidad y límites de los productos marginales): la diferenciabilidad y la monotonía van en las 3 propiedades. Recomendada: así.
- **A43-06 — Letras del III.** Como en el I: a) y b) en III.1 y c)-e) en III.3; III.2 lleva párrafos con nombre (las implicaciones, como el II.2 del 3.A.34). El verificador avisará igual que en A43-01. Recomendada: así.
- **A43-07 — Anexo de control óptimo.** Copia literal del 3.A.34 salvo las 2 autorremisiones, que el coordinador cambió: «\vertema{3.A.43}» → «de este tema» y «de inversión de este tema» → «de inversión \vertema{3.A.34}». Decisión del coordinador (31/10/2026): el resto sigue literal; en el 3.A.34 la pieza ya es correcta.
- **A43-08 — Gasto permanente en el RCK.** Se cuenta con el lugar $\dot k=0$ desplazado hacia abajo y el consumo cayendo lo mismo que el gasto (Romer, cap. 2.7); el capital y el tipo de interés no cambian. El original decía lo contrario en una frase (contradicción interna, corregida).
- **A43-09 — Cifras de velocidad del RCK.** 10 %, 8 % y 7 % con $\theta=1,2,4$ y $\alpha=1/3$, $\rho=0{,}02$, $\delta=0{,}05$, $n=0{,}01$, $g=0{,}02$ (calculadas con la fórmula de Barro y Sala-i-Martín y comprobadas de nuevo); $s^*\simeq24~\%$ con $\theta=2$. Son ilustrativas, no estimaciones.
- **A43-10 — Retractación de Domar (1957).** Se cuenta «como cuenta Easterly (2003)», citando también Domar (1957); la «conciencia culpable» del original no se cita literalmente (no comprobada, V18).
- **A43-11 — Opinión de la conclusión con Lucas (2003).** Se cita sin comillas y sin página (C36 pedía comprobar la página).
- **A43-12 — Función de los diagramas del RCK** (control de calidad, 31/10/2026). Los 5 diagramas `rck-*` se dibujan con $f(k)=k/(1+k)$ (CES con σ = 1/2 y $f'(0)=1$: no cumple Inada en el origen), no con la Cobb-Douglas del texto, y los pies no lo dicen. Son cualitativos y la forma es la de los manuales. Recomendada: dejarlo así; alternativa, añadir «(curvas ilustrativas)» al pie.
- **A43-13 — Páginas de las citas en el HTML** (control de calidad, 31/10/2026). En el HTML las citas con página salen sin «p.»: «Lucas (1988, 5)», «Solow (1956, 65)», «Solow, 1957, 316 y 320» (en el PDF, «p. 5»). Es del estilo de citas del HTML y pasa igual en el 3.A.24, el 3.A.33 y el 3.A.34: no es de este tema. Recomendada: revisarlo en la plantilla común, fuera de /revisartema.
- **A43-14 — Estructura (coordinador; DK1 de coherencia y D1 de contenido).** Aplicada: I Solow (Harrod-Domar en la idea y en el anexo A), II MRW y extensiones, III RCK, con los minutos de coherencia (10′, 5′30″, 11′). Alternativas: 2 apartados de la guía del tribunal; Harrod-Domar como I.
- **A43-15 — Enganche.** Aplicada: frenazo soviético con «Poco a poco se va lejos»; Nogales queda para el 3.A.45.
- **A43-16 — Notación por unidad eficiente.** Aplicada: k, y, c, h sin marca; per cápita como cociente (choca con c_t≡C_t/L_t del 3.B.31, anotado en el canon).
- **A43-17 — CRRA con el −1 y 𝓗 en valor corriente.** Aplicada, como 3.A.8, 3.A.33 y 3.A.34.
- **A43-18 — Kaldor.** Aplicada: gráfico de EE. UU. y España como contraste.
- **A43-19 — «En torno al 2 %».** Aplicada: «cerca del 2 % desde la posguerra y algo menos desde 1870».
- **A43-20 — Convergencia reciente.** Aplicada: PWT con la OCDE resaltada, «lenta y sensible a la base de datos».
- Coordinador (1/11/2026): tercera autorremisión del anexo D («Para profundizar», \vertema{3.A.43}) cambiada por «como el del apartado III» (opción b del canon: se adaptan las frases que nombran el propio tema).
- Coordinador (1/11/2026): el gráfico de tasas de Solow (gráfico 7, imprescindible en el cante) vuelve a 0,7 del ancho; a 0,52 los rótulos eran ilegibles. Se acepta el hueco que vuelva a quedar.
- Control de calidad (31/10/2026): `verificar-tema.py` sin errores; PDF, HTML (claro y oscuro) y Word revisados. Quedan correcciones menores de bibliografía, de 4 gráficos y de este informe, devueltas al coordinador.

## Instrucciones para el vídeo

- **Introducción y conclusión, sin pizarra** (modo guion). Enganche: el frenazo soviético con «Poco a poco se va lejos»; la idea final responde que acumular no basta: lo que lleva lejos es aprender a producir más con lo mismo.
- **Esquina izquierda, recuadradas y conservadas** (`conservar:`): `eq:solow` y `eq:regla-oro` desde el I; `eq:mrw-renta` en el II; en el III, `eq:euler-rck`, `eq:acumulacion-rck` y `eq:regla-oro-modificada`, esta última junto a la regla de oro de Solow para compararlas (la tabla `tab:reglas-oro` como apoyo).
- **Gráfico conjunto del I y II, por partes** (centro): `solow` por capas (ejes, $f(k)$, $s f(k)$, recta $(n+\delta)k$ que gira a $(n+g+\delta)k$, $k^*$, dinámica, $c^*$ y, al final, la capa dorada de la regla de oro). Luego `solow-tasas` (subida de $s$; 2 economías para la convergencia; la del país que ahorra menos para la condicional) y, en el II, la curva en N de `trampa-pobreza` como capa en otro color sobre el mismo gráfico. Se borra el centro al empezar el III.
- **Diagrama de fases del III, por capas** (derecha): ejes, $\dot k=0$ con $k_{\mathrm{oro}}$, flechas, $\dot c=0$ en $k^*$, flechas, $E$, senda de silla, sendas divergentes (B y C); después la caída de $\rho$ (`rck-rho`) y el gasto permanente (`rck-gasto`, panel izquierdo) como capas nuevas. Al final, la pizarra queda con el diagrama y la esquina de ecuaciones.
- **Apoyo (no se escribe)**: `pib-pc-eeuu`, `kaldor-eeuu`, `funcion-produccion` (3D), `consumo-ahorro`, `ineficiencia-dinamica`, `solow-ahorro`, `tab:estatica-solow`, `convergencia`, `mrw-fases`, `inversion-renta`, `rck-theta`, `rck-impuesto`, el panel temporal de `rck-gasto` y `tab:reglas-oro`.
- **Pegatinas**: «la avaricia rompe el saco» (ineficiencia dinámica en Solow; en el III se tacha: no hay ineficiencia) y «al perro flaco todo son pulgas» (trampa de pobreza).
- **No se dicen números de tema** en voz alta.

## Control de calidad (1/11/2026): correcciones aplicadas

- `.bib`: Lucas como «Lucas, Jr., Robert E.» (3 entradas); «Bolt y van Zanden» con `useprefix=true` (comprobado en el PDF de prueba); fuera las notas internas de Phelps1961, Koopmans1965, Strotz1956, Nordhaus1992 y los 3 vídeos, con su fecha real (5/4/2020, 10/12/2019 y 8/4/2015).
- `.tex`: `\graficonota[0.85]{solow-no-existencia}`; fuentes de `hd-caso1` a `hd-caso3` unificadas (Barro y Sala-i-Martín, 2004, cap. 1, y Sala-i-Martín, 2000, cap. 2), `hd-produccion` solo con la primera.
- Huecos de las págs. 12, 13 y A-3: resueltos reduciendo el ancho de `ineficiencia-dinamica` (0,72), `solow-tasas` (0,52), `solow-ahorro` (0,78), `hd-produccion` (0,45) y `hd-caso1` a `hd-caso3` (0,42); comprobado en una compilación de prueba con los gráficos reales.
- Pies de los `rck-*`: sin «(curvas ilustrativas)», como recomienda A43-12.
- Anexo D: documentado como copia literal del 3.A.34 salvo las 2 autorremisiones (Resumen, Coherencia y A43-07).
