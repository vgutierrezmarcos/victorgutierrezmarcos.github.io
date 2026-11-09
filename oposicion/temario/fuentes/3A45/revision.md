# Revisión del 3.A.45 — Evidencia empírica sobre el crecimiento, contabilidad del crecimiento y convergencia

Revisión autónoma (Víctor fuera del 31/10 al 9/11/2026). Fuente nueva en LaTeX (`3A45.tex`), escrita en 2 partes el 1/11/2026: la **parte 1**, la introducción y los apartados I y II; la **parte 2**, el apartado III, la conclusión y los anexos A-D. Las dudas se resuelven con la opción recomendada y se anotan como A45-NN.

## 1. Resumen

- Tema reescrito entero con redacción propia en 3 apartados que siguen el título: I. Hechos y distribución de la renta (7′), II. Contabilidad del crecimiento y PTF (9′30″), III. Convergencia y factores del crecimiento (10′); introducción 2′30″ y conclusión 1′.
- Nuevo el I.3 (distribución funcional: Euler, CES, Gollin, caída de la participación del trabajo y sus explicaciones, Piketty en caja); la contabilidad corregida (Solow por hora, Kaldor y no «Friedman», dual con $c_K$) y completada (desarrollo con datos de 2023, problemas, evidencia de España, zona del euro y EE. UU.).
- III con la regresión de convergencia como 2.ª función clave, la evidencia de 1960 a 2023, Barro (1991) con 98 países, robustez y las causas últimas con AJR como modelo (0,94 frente a 0,52; Nigeria y Chile), Rodrik et al., democracia y las 4 visiones.
- Enganche de Nogales con foto de dominio público y «Por sus frutos los conoceréis»; ejemplo conductor Corea del Sur–Nigeria; conclusión con 5 bloques y 4 anexos (contabilidad, desarrollo, econometría, test).
- `3A45.bib` (136 entradas), 13 gráficos pedidos, `seo.json`; 39 págs. de tema, 4 de anexos y 7 de bibliografía, sin referencias ni citas indefinidas.

## 2. Errores corregidos

| Dónde (Word) | Decía | Dice ahora |
|---|---|---|
| 1.1.1, Implicaciones (l. 388-392) | «La renta per cápita se duplicó… 12,5 %… 87,5 %» | La **producción bruta por hora trabajada** del sector privado no agrario se duplicó; 1/8 (12,5 %) por el capital por hora y 7/8 (87,5 %) de residuo (Solow, 1957, pp. 316 y 320), con las mismas palabras que el 3.A.43 |
| 0.b, hecho 6 (l. 244) | «el único que Kaldor no consigue explicar con el modelo de Solow» | Es el modelo de Solow el que no lo reproduce salvo como dinámica de transición (Kaldor no usó el modelo) |
| 0.b, nuevos hechos (l. 252) | Jones y Romer «en 2009» | **2010** (*AEJ: Macroeconomics*) |
| 0.b, hecho 5 y nota 8 | $\alpha=rK/Y$ | $\alpha=c_K\,K/Y$, con $c_K=r+\delta$ el coste de uso ($r$ es el tipo neto en el canon) |
| 0.b, hecho 5 en el modelo | Las participaciones constantes exigen una Cobb-Douglas | En la senda equilibrada basta cualquier función neoclásica; la Cobb-Douglas las hace constantes también fuera de ella |
| 0.b, hecho 2 | «capital por hora trabajada» | «capital por trabajador» (lista canónica de la ficha `hechos-kaldor`, palabras del 3.A.43) |
| 1.1.1, Supuestos (l. 344) | Condiciones de Inada | Fuera: la contabilidad no las necesita |
| 1.1.1, Desarrollo | $y=A\,k^{\alpha}$ con $y=Y/L$; $\dot A/A$; $\alpha_K$, $\alpha_L$; «RS + ε» | $\gamma_{Y/L}=\gamma_A+\alpha\gamma_{K/L}$ (`eq:residuo-hora`); $\gamma_A$, $\alpha$, $1-\alpha$ (canon §7: $y$, $k$ son por unidad de trabajo eficiente) |
| 1.1.1, Valoración (l. 421) | Prescott «[ver tema 3.A.6]» | `\vertema{3.A.42}` (ciclo real), con Kydland y Prescott (1982) y Prescott (1986) |
| 1.1.1, Valoración (l. 439-441) | Crítica de la separación entre movimientos y desplazamientos atribuida a «Friedman» | **Kaldor (1957)**, con su función de progreso técnico (V11) |
| 1.1.1, Valoración (l. 438-446) | Abramovitz: la PTF solo debe recoger avances «no costosos» | La «medida de nuestra ignorancia» es de Abramovitz (1956, p. 11); la idea de que lo costoso (I+D, formación) es factor es el programa de Jorgenson y Griliches (1967) |
| 1.1.2, Supuestos | El dual no necesita «competencia perfecta en los mercados de factores» | Necesita que los precios observados agoten el producto; lo que no necesita es la forma funcional, el tipo de progreso técnico ni el stock de capital |
| 1.1.2, Valoración | Young (1998): Hsieh «no trata correctamente los impuestos sobre el capital» | Young (1998, NBER WP 6657): errores de cálculo y de método y otros datos que confirman la caída del rendimiento del capital |
| 1.2 (l. 562-584) | Regresión con «RS + ε» presentada como la identidad; «Tal y como dijo Friedman…» | Regresión con $\beta_0,\beta_1,\beta_2$ y $u_t$ (`eq:econometrico`), distinta de la identidad; el problema es la simultaneidad (Marschak y Andrews, 1944) |
| 1.3, anexo 1 | Hall y Jones: «R² = 0,79, el 79 % de la varianza se explica por el residuo» | Correlación de los logaritmos 0,89; su cuadrado, 0,79, es la varianza que acompaña, no que «explica» |
| 1.4.1 (l. 640) | Mincer (1971) | Mincer (1974), *Schooling, Experience, and Earnings* |
| 1.4.1 | «Oulton y Srinivasan proponen 2 métodos» (sin obra) | Oulton y Srinivasan (2003), Bank of England WP 192 |
| 1.4.1 (l. 658) | «el 96,7 % del crecimiento» sin periodo ni cita | EE. UU. 1945-1965, residuo del 1,6 % al 0,1 % (Jorgenson y Griliches, 1967; V20) |
| 1.5.2 (l. 676-682) | Mundo 1960-2000: 40 % capital, 10 % capital humano, 50 % PTF «del total» (sin fuente) | Bosworth y Collins (2003, tabla 1): de la producción **por trabajador** (2,3 %), 1,0 puntos de capital (43 %), 0,3 de educación (13 %) y 0,9 de PTF (39 %) |
| 1.5.3 | «Mero efecto estadístico debido al mayor control por capital humano» como explicación de la desaceleración | Fuera: medir mejor baja el nivel del residuo, no explica su frenazo |
| 1.5.3 | Errores de medida «descartados», con el ejemplo de WhatsApp sin cita | Syverson (2017) y Byrne, Fernald y Reinsdorf (2016); fuera WhatsApp |
| Apartado 0 (l. 174) | India: pobreza del 39,1 % en 1988 al 12 % en 2000 (sin fuente, no cuadra con ninguna serie) | Banco Mundial (PIP), 3 dólares diarios en PPA de 2021: 52 % (1987), 27 % (2011), 5 % (2022), con nota del cambio de encuesta; mundo 43 % (1990) → 10 % (2024) |
| Enganche | «La renta media es de 30.000 dólares» | Renta **mediana de los hogares** (≈30.000 $, la del libro; 29.442 $ en el censo de 2006-2010) y la actual (43.214 $, ACS 2020-2024) |
| Notas 3, 4 y 7 | Sin fuente; nota 7 con «20/20 = 23 veces» | Nota 3 con Maddison 2023 (×12-23 en 2 siglos, ×5-10 en uno); nota 4 con Panagariya (2004); nota 7 con Hall y Jones (1999, p. 83) sin el «20/20», que no está en el artículo (V31) |
| 2.1.2 (l. 734-770) | $\gamma^y_{t,t-1}=\beta_0+\beta_1\ln(y_{t-1})+u_t$ con $y$ per cápita; $\sigma^2_{y,t-1}>\sigma^2_{y,t}$ | `eq:convergencia-beta` con $(Y/L)_{i,t}$, $\vect{x}_i\cdot\vect{\psi}$ y $u_{i,t}$; $\sigma_t<\sigma_{t-T}$ con $\sigma_t$ la desviación típica (canon §7, CC3) |
| 2.1.2 | Las definiciones «introducidas por Sala-i-Martín (1990)» | Su tesis de 1990 y Barro y Sala-i-Martín (1991), la primera publicación (V38) |
| 2.2.1 (l. 828-832) | Heston y Summers: «más de 130 países… desde 1960»; «hallaron que no existe β-convergencia» | Summers y Heston (1988): 130 países desde 1950; la regresión sin convergencia de 1960-1985 es de MRW (1992, tabla III) (V36) |
| 2.2.2 (l. 884-946) | «jay que añadir un vector $\vec z$»; $\vec\eta\cdot\vec z$ | Errata corregida; $\vect{x}_i\cdot\vect{\psi}$; coeficientes sobre 25 años (V3) |
| Caja de β (l. 930-960) | $x$ y $\beta$ (velocidad); $\hat y$ | $g$ y $\lambda$; $y$ por unidad eficiente sin marca (`eq:bsm`) |
| 2.2 (l. 962) | Johnson y Papageorgiou (2018); clubes y trampa de pobreza atribuidos | 2020 (*JEL*); su resultado comprobado en el resumen; los clubes, con Quah (1996) y Durlauf y Johnson (1995) (V5) |
| 2.2 (l. 970-996) | Kremer, Willis y You (2021, documento de trabajo); Acemoglu y Molina (2022), «Converging to convergence? A comment», con 3 críticas | Versión publicada (*NBER Macroeconomics Annual* 36, 2022); título «Converging to Converge? A Comment» y su crítica real (efectos fijos); las 3 críticas del Word no están en el texto (V6, V7) |
| 3.2 (l. 1028) | Barro (1991): «130 países», «5 regresiones» con la inflación | 98 países, 1960-1985, con distorsión de precios de la inversión, inestabilidad política y ficticias regionales; sin inflación (es Barro, 1995) (V2) |
| 3.2, regresiones 4.ª y 5.ª | Atribuidas a Barro (1991) | Son las tablas IV y V de MRW (1992), en III.2 |
| 3.2 (l. 1089-1094) | Debate «Mankiw frente a Romer» | Quitado: sin fuente (A45-10) |
| 3.3 (l. 1106-1112) | «Frenkel y Romer»; «Democracia (Acemoglu y Robinson, 2019)… provisión de balanza de pagos» | Frankel y Romer (1999); Acemoglu, Naidu, Restrepo y Robinson (2019), ≈20 %, «provisión de bienes públicos» (V9, V14) |
| 3.4.1 (l. 1124-1130) | Leamer (1982); frase en inglés («Do not make any prior hypothesis…») | Leamer (1983); en castellano (V10, P54) |
| 3.4.2 (l. 1138-1146) | «Kneller et al.»; lista de gastos productivos con «subsidios a la I+D»; «llevo» | Kneller, Bleaney y Gemmell (1999); el resultado sin la lista, no comprobada (V15, A45-10) |
| 3.5.1 (l. 1158-1170) | «Hall Jones»; Hayek, «la falta arrogancia»; Coase sin obra | Hall y Jones (1999); Hayek (1988), *La fatal arrogancia*, p. 76; Coase (1960) |
| 3.5.2 (l. 1202) | El instrumento de AJR «está correlacionado con el crecimiento del PIB per cápita»; «resultado robusto y casual» | Correlacionado con las instituciones (primera etapa, −0,61) y con el **nivel** de la renta (−0,57); causal; VI 0,94 frente a MCO 0,52 (V18) |
| 3.5.2, pasos a)-d) | Explicación en 4 pasos que parecía traducida de un manual | Redactada de nuevo como cadena de 3 eslabones |
| 3.5.2 final (l. 1210) | «Visión ideológica (Piketty)» | Una de las 4 visiones de AJR (2005, p. 424), que ponen como ejemplo a Piketty (1995) (V13) |
| 3.5.2 final (l. 1216) | «Bénabou (1996)… dilema del prisionero» | Benhabib y Rustichini (1996) (V12) |
| Anexo 1 (P35) | MRW con $\gamma_A=0{,}02$ y $\delta=0{,}06$; «α = 2/3»; «R² = 0,8»; Hall y Jones «R² = 0,79, el 79 % de la varianza se explica por el residuo» | $g+\delta=0{,}05$; α implícita 0,60 (0,31 con capital humano); R² 0,59 y 0,78; correlación 0,89 (tablas `tab:enfoques-crecimiento` y `tab:enfoques-desarrollo`) |

## 3. Marcas resueltas

| Marca | Texto original | Qué se hizo |
|---|---|---|
| P1 | Estructura de la introducción vacía (tabla y `{.mark}`) | Escrita con los 3 apartados y por qué ese orden (de los hechos a su medida y de su medida a sus causas) |
| P2 | Nota al opositor del cambio de temario | Quitada |
| P3 | Nota «indagar más en la distribución funcional» | Resuelta con el apartado I.3 entero |
| P4, P13 | Ficha del cambio de temario (image1) | Privada: no se publica; su propuesta I-III sirvió a la estructura |
| P5 | «Ver el cap. 7 de Campante et al. (2021)» | Quitada; Campante et al. (2021) en «Para saber más» |
| P6 | «Basado en el tema de Juan Luis» | Quitada; todo redactado de nuevo (n-gramas contra Tebar, el Word y el PDF: solo coinciden el título y la definición de PTF de la nota 15, que es del propio Word de Víctor) |
| P7 | «Esquema de Ángel» | Quitado; usado para la estructura |
| P8, P10 | «Dedicar 5 minutos…» | Quitados; los tiempos van en el reparto del cante |
| P9 | «Leer el documento de Juan Carlos» | Quitado |
| P11 | Comentarios y correo tras la bibliografía | No se publican; Klenow y Rodríguez-Clare (1997) y Bloom et al. (2020) entran citados |
| P14, P70 | Foto de Nogales sin fuente | Sustituida por la de dominio público de la CBP (Robert Bushell, 4/2/2019, Wikimedia Commons), `graficos/nogales-valla.jpg`, con la cita al libro y al censo |
| P16-P18 | Imágenes 4-6 de Jones (2016) sin título ni fuente | Rehechas con datos: `mrw-ajuste` (2023), `ptf-renta` (2023) y `pib-pc-largo` (Maddison 2023) |
| P19 | Nota 13 e imagen 7 (neutralidades) | Una nota con `\vertema{3.A.11}` (ficha `progreso-tecnico-neutral`: aquí mención) |
| P20 | Capturas de las tablas I y II de MRW | Tabla `tab:mrw` en LaTeX |
| P21, P22, P51 | Imagen 10, captura de Campante y nota personal sobre Hall y Jones | Redactado con las cifras comprobadas en el artículo y la réplica de 2023; tabla `tab:desarrollo` y gráfico `ptf-renta` |
| P23 | Diapositiva «Producción total o valor añadido» | Redactado (II.4) |
| P24 | Diapositiva «Contabilidad frente a causalidad» | Redactado con `eq:causalidad` (II.4) |
| P36 a, b | Faltan las barras de la contabilidad y la participación del trabajo | Pedidos `contabilidad-espana` y `participacion-trabajo` |
| P52 | «Ejercicio 1», «Ejercicio 2» | Quitados |
| P55 | «Resumen… (Link)» | Recapitulación y nexo al final de II.5 |
| P56 | Bibliografía «Tema ICEX-CECO» y «Tema de Juan Luis» | Sustituida por `3A45.bib` con los artículos |
| P57 | Preguntas de otros exámenes (vacío) y quia.com | Anexo de test con el enlace genérico al simulador |
| Notas 1, 2, 6, 14 | Nobel de Lucas, cita de Lucas, Nobel de Solow, cita de Solow | Notas 1 y 6 conservadas (mismas palabras que el 3.A.43); 2 y 14 pasan a cita en el texto |
| Notas 5, 8, 9, 10, 11, 12, 15, 16, 17 | — | 5: nota de los clásicos; 8: nota del quinto hecho; 9: pasa al gráfico `convergencia-periodos` (III.2); 10: nota del sexto nuevo hecho; 11: se conserva la anécdota de Cobb y Douglas en nota (sus propiedades están en el 3.A.11); 12: integrada en II.4; 15: nota de PTF frente a productividad del trabajo, con la «productividad contracíclica» como efecto composición (A45-09); 16: nota del dual; 17: nota de las superestrellas |
| P12 | Cajas «Evidencia sobre convergencia (β)» y «Enfoque no regresivo (σ)» | La primera, caja gris de Barro y Sala-i-Martín con `eq:bsm` y el gráfico `estados-eeuu` (BEA, 1929-2025); la segunda, absorbida en la definición de σ (III.1) |
| P15, P28, P29 | Imágenes 3, 4 y 5 (crecimiento frente a renta de 1960; ausencia de convergencia; OCDE) | Gráfico `convergencia-periodos` (1960-2000 y 2000-2023, OCDE resaltada), con las filas de 1960-2000 calculadas y añadidas al CSV |
| P25 | Imagen 1, tipos de convergencia | Árbol `tipos-convergencia` rehecho en TikZ, fiel al original (A45-18) |
| P26 | Imágenes 15-17 (β y σ) | Gráfico `beta-sigma` en TikZ |
| P27 | Imagen 3, tabla de teorías | Tabla `tab:teorias-convergencia` en LaTeX, fiel al original, con la nota de Sobelow y Jones (A45-19) |
| P30 | Imagen 21 (estados de EE. UU.) sin título ni fuente | Gráfico `estados-eeuu` con el BEA, 1929-2025, dentro de la caja (A45-20) |
| P31, P32, P53 | Capturas de Campante et al. y de Kremer et al.; «Idea sacada de…» | Redactado con las citas (Kremer, Willis y You, 2022; Campante et al., 2021) |
| P33 | Captura de Jones (2023) con enlace `t.co` | Cita en la «Opinión» de la conclusión |
| P34, P35 | Fórmulas de Caselli en imagen; tablas del anexo 1 | Ecuaciones en el anexo B; tablas `tab:enfoques-crecimiento` (anexo A) y `tab:enfoques-desarrollo` (anexo B), corregidas |
| P42, P43, P73 | Faltaban Baumol, De Long, Pritchett, clubes, la convergencia desde 2000 y las causas últimas | III.2 y III.4 |
| P45, P46 | «[ver temas 3.A.43 y 3.A.44]», «[ver tema 3.B.9]» | `\vertema{3.A.43}` `\vertema{3.A.44}` por separado; `\vertema{3.B.9}` |
| P54 | Frase en inglés del EBA | En castellano |
| P58 | Conclusión con 3 bloques vacíos | Escrita con sus 5 bloques |
| P61-P68 | Errores de Barro, MRW, BSM, Mincer, AJR, visiones y Bénabou, democracia, Kneller y Leamer | Ver «Errores corregidos» |
| Notas 18-25 | — | 18: nota de la inflación (causalidad simultánea); 19: nota de Giavazzi y Tabellini (2005); 20, 21 y 25: integradas en el anexo de econometría (paneles quinquenales, multicolinealidad, variables omitidas; «Lee y Gordon, Wildman», sin comprobar, no se citan); 22: integrada en Kneller (causalidad inversa); 23: nota del Nobel de North; 24: nota del Consenso de Washington con Williamson (1990) |

## 4. Datos actualizados

Consultas del 1/11/2026 salvo que se diga otra cosa; detalle y URL en `_trabajo/propuestas-datos.md` (V) y en la cabecera de cada CSV de `_trabajo/datos/`.

| Dato | Valor anterior | Valor nuevo | Fuente | Segunda comprobación |
|---|---|---|---|---|
| PIB por habitante de EE. UU. a largo plazo | 1870-1990: 2.244 → 18.258 $ de 1985, 1,75 % | 1870-2022: 4.803 → 58.487 $ de 2011, 1,6 %; con un punto menos, ≈12.800 $; con uno más, ≈267.000 $ | Maddison 2023 (`BoltvanZanden2025`) | BEA (3.A.43): 1,9-2,0 % en 1947-2025 (V27) |
| Crecimiento 1960-2022 por países | 1900-1987 (India 0,64 %, Japón 2,95 %…) | Corea del Sur y Taiwán > 5 %, India y España ≈ 3 %, Argentina ≈ 1,2 % | Maddison 2023 | PWT 11.0 (V28; China discrepa: 4,7 frente a 6,1) |
| Dispersión de niveles | 1960: EE. UU. = 39 × Etiopía, d. t. 0,90; 1990: 65 ×, 1,1 | 1960: 36 × Etiopía; 2023: EE. UU. = 117 × Sudán del Sur; d. t. del ln (96 países sin petroleros) 0,96 (1960) → 1,34 (2000) → 1,27 (2023) | PWT 11.0 (`sigma-convergencia.csv`; V29) | Maddison 1960: 0,95; WDI 2023 (A45-12) |
| Dispersión de ritmos | 1960-1990, 114 países: 1,8 %, d. t. 1,8; Corea ×7,4 | 1960-2023, 111 países: 1,9 %, d. t. 1,3; China 6,1 %, Corea 5,4 % (×30, del puesto 89 al 28), R. D. del Congo −1,5 % | PWT 11.0 (V30) | Maddison: Corea 5,3 % |
| Corea del Sur y Nigeria | Corea frente a Irak, 1960-1990 | 1960: 1.363 y 2.182 $ (PPA de 2021); 2023: 52.389 y 4.578 $; crecimiento 5,4 % y 0,5 % anual | PWT 11.0 (cálculo propio, 1/11/2026) | Maddison 2023: 1960, 1.548 y 1.307 $ de 2011; Nigeria 2,2 % anual en 1960-2022; 2022, ratio 8 (nota al pie; A45-05) |
| Pobreza extrema | India 39,1 % (1988) → 12 % (2000) | India 52 % (1987), 27 % (2011), 5 % (2022); mundo 43 % (1990) → 10 % (2024), 3 $ en PPA de 2021 | Banco Mundial, PIP (`BM2026PIP`) | WDI SI.POV.DDAY (V34) |
| Nogales | 30.000 $ de renta media | ≈30.000 $ de renta mediana de los hogares (libro); 43.214 $ en 2020-2024 | Acemoglu y Robinson (2012, cap. 1); Census ACS (`Census2025ACSNogales`) | ACS 2006-2010: 29.442 $ (V35) |
| Hechos de Kaldor, EE. UU. y España (tabla `tab:kaldor`) | — | EE. UU.: $Y/L$ 2,0 %, $K/L$ 1,7 %, rentabilidad 8,0 → 8,1 %, $K/Y$ 3,8 → 3,2, trabajo 63,7 → 56,8 %; España: 2,5 %, 3,2 %, 9,9 → 6,7 %, 4,0 → 6,2, 66,7 → 59,4 % (1960-2023) | PWT 11.0 (`kaldor-eeuu-espana.csv` del 3.A.43) | AMECO (mismo CSV) |
| Participación salarial ajustada | «α entre 0,2 y 0,5» sin fuente | EE. UU. 62,9 % (1960), 61,4 % (2000), 54,4 % (2025); España 61,3 % (1960), 67,5 % (1976), 55,3 % (2007), 56,6 % (2025); zona del euro 58,4 % (1995), 54,2 % (2007), 56,9 % (2025); α en países avanzados 0,3-0,5, mediana 0,38 | AMECO ALCD0 (`CE2026AMECO`); PWT (V23) | PWT `labsh`; Fernald: capital del sector empresarial 0,32 → 0,41 |
| Remuneración de asalariados de España | — | 48,4 % del PIB en 2025 (56,6 % ajustada) | Eurostat `nama_10_gdp` (las cifras del 3.A.11) | AMECO |
| MRW (tabla `tab:mrw`) | Capturas en inglés; anexo con $\alpha=2/3$ | R² 0,59/0,59/0,01 y 0,78/0,77/0,24; α 0,60/0,59/0,36 y 0,31/0,29/0,14; β 0,28/0,30/0,37 | MRW (1992), tablas I y II | 3.A.43 (V6 del 3.A.43); réplica PWT de 1960-2023: α 0,64, R² 0,54 → 0,76 |
| Hall y Jones con datos actuales | Captura de Campante et al. | 1988: 31,7 = 1,8 × 2,2 × 8,3; 2023: 59,5 = 1,1 × 2,1 × 24,8; Corea/Nigeria 2023: 8,1 = 0,7 × 1,8 × 6,2 | Hall y Jones (1999, p. 92); PWT 11.0 (`contabilidad-desarrollo-pwt.csv`) | Réplica de 1988 con PWT: 56,8; 2,0; 2,1; 13,6 (V16) |
| Caselli | Vacío | Éxito 0,39 (0,34 con percentiles) en 1996; 0,30 en 2023 (143 países) | Caselli (2005); PWT 11.0 | 2019: 0,31 (V17) |
| Contabilidad de España, zona del euro y EE. UU. | Ninguna | España 1996-2007: 3,6 = 1,8 K + 2,0 horas + 0,4 capital humano − 0,5 PTF; PTF −0,8 (2008-2013), +0,6 (2014-2019), ≈0 (2020-2025), +2,0 de 2,8 (1971-1985); zona del euro PTF 0,5; −0,5; 0,6; −0,2; EE. UU. 1,2 (1996-2007) y 0,8 (2020-2025) | AMECO + PWT `hc` (`contabilidad-crecimiento-esp-ea-eeuu.csv`; manda sobre las cifras de la fase de contenido) | PTF de AMECO (ZVGDF), OCDE y Fernald (V25) |
| PTF de EE. UU. | Denison (1985), sin cifras | 2,1 % (1948-1973), 0,5 % (1974-1995), 1,8 % (1996-2004), 0,5 % (2005-2019), 1,1 % (2020-2025); 0,9 % de media desde 1970 (como el 3.A.44) | Fernald (`FRBSF2026PTF`, versión del 1/10/2026) | AMECO (V26) |
| Mundo 1960-2000 | 40/10/50 % | 43/13/39 % de la producción por trabajador | Bosworth y Collins (2003, tabla 1) | Texto del mismo artículo (V24) |
| Jorgenson y Griliches | 96,7 % sin periodo | 1945-1965, PTF 1,6 % → 0,1 % | Jorgenson y Griliches (1967) | Solo fuentes secundarias (V20) |
| Convergencia β con PWT | 1960-1985 (MRW) | 1960-2000: pendiente +0,25 sin petroleros (divergencia), OCDE −1,03 (λ ≈ 1,3 %); 2000-2023: −0,52 (182 países), −0,34 sin petroleros ni pequeños, OCDE −1,49 (λ ≈ 1,8 %) | PWT 11.0 (`convergencia-pwt.csv`; 1960-2000 calculado el 1/11/2026 con el método del 3.A.43) | Maddison 2000-2022: casi nula (V6) |
| Convergencia σ | — | Mundo (96 países) 0,96 → 1,34 (2000-2007) → 1,27 (2023); OCDE 0,61 → 0,44; UE-27 0,55 → 0,33; UE-14 sin Irlanda ni Luxemburgo 0,38 → 0,15 (2007) → 0,20 (2023) | PWT 11.0 (`sigma-convergencia.csv`; columna sin Irlanda ni Luxemburgo añadida el 1/11/2026) | Maddison y WDI (mismo CSV) |
| MRW, convergencia condicional | −0,14 y −0,34 sin detalle | −0,14 (con $s$ y $n$), −0,29 (con escolarización, λ 1,4 %), OCDE −0,34, λ hasta 2 %; coeficientes sobre 25 años | MRW (1992), tablas III-V | 3.A.43 (V3) |
| Estados de EE. UU. | 1880-1988, sin fuente | BSM: λ ≈ 2 %; BEA 1929-2025: λ ≈ 1,4 %, R² 0,88, 48 estados | Barro y Sala-i-Martín (1992); BEA SAINC1 (`BEA2026SAINC`) | FRED (V19) |
| Pritchett | — | Ricos/pobres: 8,7 (1870) → 45 (1990) | Pritchett (1997) | PDF (C37) |
| Barro (1991) | 130 países | 98 países, 1960-1985 | Barro (1991) | NBER WP 3120 (V2) |
| Frankel y Romer | — | +1 punto de comercio/PIB: +0,5 a 2 % de renta | Frankel y Romer (1999), resumen | — (C45) |
| Democracia | «Acemoglu y Robinson (2019)» | ≈ +20 % del PIB por habitante en 25 años | Acemoglu, Naidu, Restrepo y Robinson (2019) | NBER WP 20004 (V14) |
| Promedios bayesianos | — | 18 de 67 variables robustas | Sala-i-Martín, Doppelhofer y Miller (2004) | Resumen del artículo |
| AJR | Sin cifras | 64 colonias; primera etapa −0,61; VI 0,94; MCO 0,52; renta-mortalidad −0,57 (R² 0,48); Nigeria-Chile ×7 (Chile 11 veces más rico); 2023, 62 países sin Venezuela (dato atípico en la PWT): pendiente −0,61, r −0,73; Nigeria 5,5 de protección, Chile 7,8 | AJR (2001); ficheros de réplica (`AJR2001Datos`); PWT 11.0 | Réplica propia de la tabla 4 (V18) |
| Corea del Sur y Nigeria, capital humano | — | Índice 3,9 frente a 2,1 (2023) | PWT 11.0 | — |

## 5. Contenido añadido

- **Introducción**: definiciones de distribución funcional, contabilidad, PTF, convergencia y causas próximas y últimas (C6); relevancia con la pobreza, el Nobel de 2024 y el reparto (C5); recuadro de notación (K4); «Para saber más» con Jones (2016), Campante et al. (2021) y Jones (2023), las 3 obras del Word.
- **I.1**: datos de PWT 11.0 y Maddison 2023 (C8, V27-V30); ejemplo conductor Corea del Sur–Nigeria (DK9).
- **I.2**: tabla `tab:kaldor` con los datos de EE. UU. y España frente a la senda equilibrada de Solow (K6, DK3); nota del quinto hecho en el original de Kaldor (V43); Piketty y Zucman (2014) sobre la medida del capital; los nuevos hechos de Jones y Romer (2010) con la nota 10.
- **I.3, nuevo** (C12-C15, K8): teorema de Euler (`eq:euler-reparto`), Cobb-Douglas (con la anécdota de Cobb y Douglas de la nota 11) y CES (`eq:ces-participacion`); medida (Gollin, 2002; autónomos; vivienda); estabilidad y caída (Karabarbounis y Neiman, 2014; AMECO; Fernald; Gutiérrez y Piton, 2020); 5 explicaciones (precio del capital, globalización y Elsby, Hobijn y Şahin, 2013; superestrellas, Autor et al., 2020; márgenes, De Loecker, Eeckhout y Unger, 2020, Barkai, 2020, Philippon, 2019; instituciones laborales); caja de Piketty con $v\equiv K/Y$, las 2 leyes (`eq:piketty`), $r>g$ y 4 críticas (Rognlie, 2015; Krusell y Smith, 2015; Acemoglu y Robinson, 2015; Mankiw, 2015) y la remisión a la distribución personal (3.A.24, 3.B.28, 4.A.3).
- **II.1**: estructura de modelo a)-c) del primal y a)-d) del dual; caja «Dos formas de escribir la tecnología» (DK4); dual con $c_K$ y la frontera de precios de los factores (DK6); el debate de los tigres (Young, 1995 y 1998; Hsieh, 2002; Fernald y Neiman, 2011; Krugman, 1994) con la pegatina «las apariencias engañan».
- **II.2**: Marschak y Andrews (1944), Hall (1988, 1990).
- **II.3** (vacío en el Word): `eq:hall-jones`, MRW como estimación (`eq:mrw-regresion`, tabla, gráfico `mrw-ajuste`), Hall y Jones con 1988 y 2023 (`tab:desarrollo`, gráfico `ptf-renta`), Caselli (2005) y la conclusión de Klenow y Rodríguez-Clare (1997).
- **II.4**: servicios del capital frente a riqueza (Oulton y Srinivasan, 2003), Denison, la medida en el sector público; producción bruta frente a VAB con los pesos de Domar; contabilidad frente a causalidad con `eq:causalidad` y la pegatina «unos cardan la lana y otros llevan la fama».
- **II.5**: Bosworth y Collins (2003); contabilidad de España, zona del euro y EE. UU. (gráfico `contabilidad-espana`); desaceleración con Fernald, Syverson (2017), Byrne, Fernald y Reinsdorf (2016), Baumol, Bloom et al. (2020, las cifras del 3.A.44), Gordon (2016), García-Santana et al. (2020), Brynjolfsson, Rock y Syverson (2021) y Acemoglu (2025); nota de PTF frente a productividad del trabajo y Malmquist (`\vertema{3.A.12}`, ficha `eficiencia-frontera`).

### Propuestas de la fase de contenido (C)

| C | Aplicada | Nota |
|---|---|---|
| C1 | Sí, con el reparto del coordinador (I 7′, II 9′30″, III 10′), no el de C1 (6′30″, 9′, 11′) | Esquema en el entorno `esquema`; `\minutos` solo en los apartados de primer nivel, como el 3.A.43 y el 3.A.44 (A45-11) |
| C2 | Sí | — |
| C3 | Sí | Anexo D de test |
| C4 | Sí, con cambios | Refrán «Por sus frutos los conoceréis» (DK8) en lugar de «Del dicho al hecho»; foto de la CBP de 2019 en lugar de la de Darkros (2005), por decisión del coordinador y la fase de datos (A45-04); la renta actual del censo |
| C5 | Sí, con cambios | Pobreza con la serie de la fase de datos (52 % → 27 % → 5 %, mundo 43 % → 10 %), no la de 2011-2012 a 2022-2023 de contenido |
| C6 | Sí | Clásicos en nota; historia ampliada con Jorgenson y Griliches y Hall y Jones |
| C7 | Sí, con la problemática de K3 (3 preguntas) | — |
| C8 | Sí, con las cifras de la fase de datos | Dispersión con la serie fija de 96 países (A45-12); Corea del Sur–Nigeria en lugar de Corea del Sur–España; gráfico con 6 países (sin Alemania) |
| C9 | Sí, salvo el gráfico | Tabla `tab:kaldor` en lugar del gráfico `kaldor-eeuu-espana` (DK3: no duplicar el del 3.A.43); la nota del quinto hecho se conserva (comprobada por la fase de datos, V43) |
| C10 | Sí | Con la nota 10 del Word en el hecho 6 |
| C11 | Sí | Una viñeta remite al apartado III.3 |
| C12-C14 | Sí, reordenadas en a)-e) | La «Idea» y la teoría como bloques de modelo; la medida dentro de la evidencia; la remisión de los márgenes al 3.A.15 (coherencia) y no al 4.A.15 |
| C15 | Sí, en caja (decisión del coordinador) | $v\equiv K/Y$ (DK7) en lugar de $K/Y$ suelto; remisión también al 4.A.3 |
| C16-C21 | Sí | El primal y el dual como `\subsubsection` con sus bloques; la hipótesis de las cifras de inversión infladas, sin atribuir a Sala-i-Martín (no localizada, A45-08) |
| C22 | Sí | — |
| C23-C26 | Sí, con las cifras de la fase de datos | Caselli 0,30 en 2023 (no 0,33 en 2019); Hall y Jones también con 2023 y con Corea del Sur–Nigeria; la segunda medida de Caselli, al anexo B |
| C27-C29 | Sí | Sin la cita a Jorgenson, Ho y Stiroh (2005) para los pesos de Domar (capítulo sin comprobar); Denison sin año en el debate (la réplica de 1969 no está en el `.bib`) |
| C30 | Sí, sin las cifras del este de Asia y de China | No las comprobó la fase de datos (A45-15) |
| C31 | Sí, con las cifras del CSV (manda sobre las de contenido) | Periodos 1996-2007, 2008-2013, 2014-2019, 2020-2025; capital humano aparte |
| C32 | Sí | — |
| C33 | Sí, con cambios | Se conserva el árbol de los tipos de convergencia (A45-18); fuera la viñeta de la convergencia de sistemas de los 50 y 60 (sin fuente, A45-24) |
| C34-C35 | Sí | Función clave `eq:convergencia-beta` con $\vect{x}_i\cdot\vect{\psi}$ (no `eq:beta`); `eq:dispersion` y Galton; clubes y series temporales en III.1 (decisión del coordinador) |
| C36 | Sí, con las filas de la imagen 18 (comprobada: neoclásica, endógena, kaldorianos, nueva geografía) | A45-19 |
| C37 | Sí | Gráfico `convergencia-periodos` (1960-2000 frente a 2000-2023) en lugar de `convergencia-beta` (1960-2023 lo tiene el 3.A.43) |
| C38-C39 | Sí | Sin la «regla del 2 %» como nombre (no comprobado en el manual); α amplia 0,7-0,8 deducida, sin cita al artículo (A45-21); gráfico de los estados con el BEA (A45-20) |
| C40-C42 | Sí | La OCDE y la UE con σ (columna sin Irlanda ni Luxemburgo); Corea del Sur y Nigeria en la nube |
| C43-C44 | Sí | «Mankiw frente a Romer» quitado (A45-10); la inflación con Barro (1995), no con Barro (1997) |
| C45 | Sí, sin la democracia | La democracia pasa a III.4, con las instituciones políticas (A45-23) |
| C46 | Sí, sin «22 de 59» | No comprobado (A45-16) |
| C47 | Sí, sin la lista de gastos | A45-10 |
| C48-C49 | Sí | La suerte con su propio párrafo; Singapur en la geografía |
| C50 | Sí | Hayek con p. 76 (A45-17); nota 24 con Williamson (1990) |
| C51 | Sí | Como modelo a)-d) en un `\subsubsection`, con la caja de las 2 etapas; Nigeria con los datos de los autores; las 2 Coreas (A45-22) |
| C52-C53 | Sí | Con la democracia (Acemoglu et al., 2019) y Piketty (1995) en la visión ideológica |
| C54 | Sí, con cambios | Idea final con Nogales y «Por sus frutos los conoceréis» (no «del dicho al hecho»); Jones (2023) en la opinión (A45-25) |
| C55 | Sí, en 2 tablas (una por anexo) | Caselli con 0,30 en 2023 (no 0,33 en 2019) |
| C56 | Sí, ampliado | Con multicolinealidad, paneles y robustez (notas 20, 21 y 25) |
| C57 | Sí | — |
| C58-C60 | Parcialmente (ver Coherencia y Dudas) | — |

### Propuestas de datos (V)

Todas aplicadas (V1-V50). V31: sin el «20/20». V32: con Maddison. V15: el resultado de Kneller sin la lista. V19: «≈ 2 %» con el artículo y la actualización con el BEA; la «α ≈ 0,8», como deducción (A45-21). V42 (Consenso de Washington): nota con Williamson (1990). V45 («más de 50 variables»): se mantiene como en el Word.

## 6. Coherencia

- **Estructura y reparto** (DK1, DK13, K1): aplicados. Títulos de primer nivel de K1.
- **Hechos de Kaldor** (DK2, CC1): el 3.A.45 es el tema de referencia; lista con las mismas palabras que la caja del 3.A.43; tabla nueva con los datos del mismo CSV.
- **Gráficos del 3.A.43** (DK3): ninguno se repite; se reutilizan sus CSV (copiados a `_trabajo/datos/`): `kaldor-eeuu-espana` para la tabla, `inversion-renta-mrw` para `mrw-ajuste` y `convergencia-pwt` para `convergencia-periodos` (con las filas de 1960-2000 añadidas, mismo método y mismos 111 países).
- **$A$ en 2 sentidos** (DK4, CC7): caja en II.1 y nota en II.3; recuadro de notación. El 3.A.43 ya dice que la PTF crece a $(1-\alpha)g$ (A43-21): coherente.
- **Renta por habitante** como $Y/L$ y $(Y/L)_{i,t}$ (DK5): aplicado en I y II y en la regresión provisional de III.1.
- **Dual con $c_K$** (DK6, CC2): aplicado, con `\vertema{3.A.34}` en la notación.
- **Piketty con $v$** (DK7): aplicado.
- **Refranes** (DK8, CC8): «Por sus frutos los conoceréis» y las 5 pegatinas; ninguno sale en otro tema (`grep` en `fuentes/*/*.tex`, 1/11/2026). Para CRITERIOS §8 cuando Víctor los apruebe.
- **Ejemplo conductor** (DK9): Corea del Sur–Nigeria con PWT 11.0 y nota de Maddison.
- **MRW** (D090, K13): solo la estimación; `eq:mrw-regresion` es la `eq:mrw-renta` del 3.A.43 en forma de regresión, con la misma notación.
- **Residuo de Solow** con las cifras y páginas del 3.A.43; **PTF de EE. UU.** con las del 3.A.44 (0,9 % desde 1970); **Bloom et al.** con las del 3.A.44 (×23, ÷41, 5 %).
- **Remisiones nuevas**: 3.A.11, 3.A.12, 3.A.15, 3.A.24, 3.A.25, 3.A.30, 3.A.34, 3.A.42, 3.A.43, 3.A.44, 3.B.9, 3.B.28, 4.A.3, 4.A.27, 3.A.38, 3.B.40, 4.A.17, 4.A.30.
- **Contradicciones con otros temas** (no se tocan):
  1. **3.A.11**: usa las claves `KarabarbounisNeiman2014Global` y `AMECO2026WageShare`; aquí `KarabarbounisNeiman2014` y `CE2026AMECO` (las del 3.A.43). Unificar en un `.bib` común.
  2. **3.A.44**, l. 275: remite los hechos de Kaldor al 3.A.43; con DK2 debería añadir `\vertema{3.A.45}`.
  3. **3.A.43 y 3.A.44**: Nigeria «sin cifra»; aquí se da con PWT 11.0 y la discrepancia con Maddison en nota. No se contradicen.
  4. **3.B.28** (Word): copia el 3.5 del Word con sus errores (instrumento «correlacionado con el crecimiento», «casual», «la falta arrogancia», «HALL JONES», visión ideológica de Piketty, Bénabou); por D125 debe resumir y remitir aquí.
  5. **3.B.40** y **4.A.17** (Word): desarrollan de nuevo la convergencia β y σ con otra notación; deben resumir con la de `eq:convergencia-beta` y remitir aquí.
  6. **4.A.27** (Word): «60/35/5 %» en 1960-1973 sin fuente.
  7. **Fichas** `contabilidad-crecimiento` (dual con $r$), `convergencia-beta-sigma` ($\ln y$, $X_i'\psi$) y `hechos-kaldor` ([decidir]): cambios CC1-CC7 para `tema-canon`. Todo esto está en `canon/pendientes-coherencia.md`, sección «Adelantado del 3.A.45 (1/11/2026)», para la fase canon; no se ha tocado ningún otro tema.

## 7. Dudas abiertas

Todas resueltas con la opción recomendada, para que Víctor las confirme:

- **A45-01** Estructura en 3 apartados con la convergencia y los factores juntos en III (DK1). Alternativa: 4 apartados (no lo permite CRITERIOS).
- **A45-02** El 3.A.45 como tema de referencia de los hechos de Kaldor (DK2). Alternativa: el 3.A.43.
- **A45-03** Refrán del enganche «Por sus frutos los conoceréis» y 5 pegatinas (DK8). Alternativas: «Del dicho al hecho hay mucho trecho» (propuesta de contenido); quitar «árbol que nace torcido» si son demasiadas.
- **A45-04** Foto de Nogales: la de la CBP de 2019 (Robert Bushell, dominio público; el original mide 5472×3648 y la copia de `graficos/`, 1200×800), del mismo lugar que la del Word. Alternativas: `US-Mexico-Nogales-Border.jpg` (Darkros, 2005, dominio público, propuesta de contenido) o `Mexican-American_border_at_Nogales.jpg` (2007, con las 2 ciudades).
- **A45-05** Cifras de Nigeria con PWT 11.0 y la discrepancia de Maddison en nota (DK9). Alternativa: Maddison (Nigeria crece un 2,2 %, no un 0,5 %).
- **A45-06** $v\equiv K/Y$ para Piketty (DK7) y $c_K$ en el dual (DK6). Alternativas: $\beta$ de Piketty; $r+\delta$.
- **A45-07** $A$ con 2 sentidos avisados (DK4). Alternativa: otra letra para la PTF de Hicks.
- **A45-08** «Según Sala-i-Martín, los líderes políticos hinchaban las cantidades de capital»: no localizado; queda como hipótesis sin autor. Si Víctor tiene la página de Sala-i-Martín (2000), se cita.
- **A45-09** «En España, la productividad es contracíclica» (nota 15): sin fuente; queda como efecto composición, sin cita.
- **A45-10** «Mankiw frente a Romer» y la lista de gastos productivos de Kneller: sin fuente: el debate quitado y el resultado de Kneller sin la lista.
- **A45-11** `\minutos` solo en los apartados de primer nivel; los tiempos de I.1-II.5 van en el reparto y en las notas «En el cante», como el 3.A.43 y el 3.A.44.
- **A45-12** Dispersión de niveles con la serie de 96 países fija (0,96 → 1,34 → 1,27), la del gráfico de σ, en lugar de la de todos los países de cada año (0,94 → 1,20, V29). Las 2 cuentan lo mismo.
- **A45-13** Sin gráfico `kaldor-eeuu-espana` (lo proponía contenido): tabla `tab:kaldor`, para no duplicar el `kaldor-eeuu` del 3.A.43.
- **A45-14** Se conserva la anécdota de Cobb y Douglas de la nota 11 (contenido proponía quitar la nota entera); sus propiedades de la función no, que están en el 3.A.11.
- **A45-15** Sin las cifras del este de Asia y China de Bosworth y Collins (no comprobadas por la fase de datos).

- **A45-16** Sala-i-Martín (1997): sin la cifra «22 de 59 variables» (no comprobada); se dice «una parte considerable de las variables».
- **A45-17** Cita de Hayek (1988, p. 76) traducida; la página es la de la edición inglesa, sin comprobar en el ejemplar.
- **A45-18** El árbol de los tipos de convergencia se conserva (fiel a la imagen del Word, del Río Casasola, 2018) en lugar de quitarlo (propuesta C33).
- **A45-19** La tabla de teorías y convergencia sigue la imagen del Word (con los kaldorianos y la nueva geografía) y añade en la fuente que el Sobelow y Jones sí predicen convergencia.
- **A45-20** Gráfico de los estados de EE. UU. rehecho con el BEA (1929-2025) en lugar de quitarlo (C60.6).
- **A45-21** La participación del capital amplia de 0,7-0,8 de Barro y Sala-i-Martín (1992), deducida de λ = 2 %, sin cita al artículo (no se pudo leer).
- **A45-22** Las 2 Coreas, de forma cualitativa con Acemoglu y Robinson (2012), sin cifras.
- **A45-23** La democracia (Acemoglu et al., 2019) va con las instituciones (III.4) y no entre los determinantes de III.3.
- **A45-24** Quitada la viñeta de la convergencia entre el Occidente capitalista y los países comunistas (años 50 y 60), sin fuente; si se quiere, Tinbergen (1961).
- **A45-25** Idea final con el refrán del enganche (no «del dicho al hecho hay mucho trecho», propuesta C54); Jones (2023) en la opinión.
- **A45-26** (control de calidad, 1/11/2026) Extensión: 39 págs. de tema frente a las 34 del 3.A.43 y del 3.A.44. Se deja así (el título tiene 3 epígrafes y el tema 13 gráficos). Alternativa: llevar a un anexo el árbol `tipos-convergencia` y la tabla `tab:teorias-convergencia` y aligerar la caja de Piketty (unas 2 págs. menos).
- **A45-27** (control de calidad, 1/11/2026) Contabilidad del desarrollo de 2023: los «5 más ricos» de la PWT son Irlanda, Noruega, Brunéi, Catar y Suiza (3 exportadores de petróleo y un centro financiero). Recomendada: dar la cifra sin exportadores de petróleo ni centros financieros (47,1 = 1,07 × 2,29 × 19,1, del mismo CSV), más comparable con Hall y Jones (1999). Alternativa: mantener 59,5 diciendo qué países son.

## Enlaces del original (9/11/2026)

Restaurados:
- Solow (1957), PDF de libre acceso en la web de Piketty: `url` de `Solow1957`.
- Klenow y Rodríguez-Clare, «Externalities and Growth» (*Handbook of Economic Growth*, cap. 11), la página de Charles Jones (con «Are Ideas Getting Harder to Find?») y el capítulo 6 de los apuntes de Jeffrey Parker (Reed College): caja «Para saber más» de la introducción; en el original iban en comentarios y en la bibliografía. Entradas nuevas `KlenowRodriguezClare2005Externalities` y `Parker2012Empirical`.
- *Duda*: el capítulo de Parker da 404 en reed.edu y no se ha encontrado otra dirección; se enlaza la copia del Internet Archive (diciembre de 2025). Si Víctor prefiere no enlazar copias archivadas, se quita esa línea.

Ya enlazados de otra forma (no se tocan):
- Kremer, Willis y You (documento del BFI): `KremerWillisYou2022` enlaza la versión publicada en el NBER.
- Acemoglu y Molina (NBER WP 28992): en la nota de `AcemogluMolina2022`.
- Del Río Casasola (2018), eprints.ucm.es: redirige a docta.ucm.es, que es la `url` de `delRioCasasola2018`.
- t.co/S7U5PS6uDy: lleva a Jones (2023), «The Outlook for Long-Term Economic Growth», ya en la caja «Para saber más» (`Jones2023`).

## 8. Instrucciones para el vídeo

- **Enganche e idea final**: Nogales y «Por sus frutos los conoceréis». La foto (gráfico 1) solo como apoyo, nunca en la pizarra. La idea final vuelve a Nogales y al refrán: la misma tierra y la misma gente dan frutos distintos según las reglas del juego.
- **Rejilla**: 3 zonas (izquierda, funciones clave que se conservan; centro, el gráfico del bloque; derecha, esquemas), como dice la nota del reparto.
- **Funciones clave que se conservan** (`conservar:`): el residuo de Solow `eq:residuo` desde II.1 hasta el final y, en III, la regresión de convergencia `eq:convergencia-beta`. `eq:hall-jones` recuadrada a la derecha durante II.3-II.4 (no morada), y se borra al pasar a III.
- **I**: pizarra con `pib-pc-largo` a mano alzada (Estados Unidos casi recta, España y Corea del Sur que se acercan, India que despega tarde), las cifras del interés compuesto escritas al lado; Corea del Sur y Nigeria como 2 números (1960 y 2023). La lista de Kaldor abreviada a la derecha, con ✓ y ✗ según la senda equilibrada, que se queda durante I. `tab:kaldor` como apoyo. En I.3: Euler y la participación con CES (`eq:ces-participacion`) en la pizarra, la pegatina «σ > 1: capital más barato ⇒ ↑α» al lado y `participacion-trabajo` a mano alzada (3 líneas); la caja de Piketty como apoyo, sin pizarra.
- **II**: el residuo se escribe paso a paso (de la función a la ecuación) y se recuadra; `eq:residuo-hora` debajo con «1/8 y 7/8»; la caja de Hicks y Harrod como apoyo. El dual, `eq:dual` bajo el residuo, con «las apariencias engañan» y «Singapur: primal ≈ 0, dual ≈ +2». II.2 sin pizarra. II.3: `eq:hall-jones` y debajo «31,7 = 1,8 × 2,2 × 8,3» y «Corea/Nigeria: 8 = 0,7 × 1,8 × 6,2»; `tab:mrw`, `mrw-ajuste`, `tab:desarrollo` y `ptf-renta` como apoyo. II.4: la pegatina «unos cardan la lana y otros llevan la fama» y `eq:causalidad` como apoyo. II.5: `contabilidad-espana` construido por partes en el centro (primero el panel de España con las barras de 1996-2007 por capas: capital, horas, capital humano, PTF bajo cero, y la línea del PIB; después los otros 2 paneles como apoyo).
- **Gráfico conjunto por partes**: en I, el de las sendas se completa con la nota de Corea del Sur y Nigeria; en II, las barras de España se van llenando por capas. Al final de cada bloque, la pizarra queda con las funciones clave y el gráfico del bloque, que se borra al empezar el siguiente.
- **III.1**: la regresión de convergencia `eq:convergencia-beta` se escribe y se recuadra a la izquierda, bajo el residuo (las 2 funciones clave se conservan hasta la conclusión); $\beta_1<0$ y las palabras «absoluta» y «condicional» al lado. El panel (c) de `beta-sigma` a mano alzada en el centro («σ ⇒ β, β ⇏ σ»); los paneles (a) y (b), `tipos-convergencia`, `eq:dispersion` y `tab:teorias-convergencia`, como apoyo.
- **III.2**: gráfico conjunto por partes en el centro: `convergencia-periodos` se construye por capas, primero el panel de 1960-2000 (nube y recta plana de todos; recta de la OCDE), después el de 2000-2023; Corea del Sur y Nigeria marcadas en la nube. Pegatinas «no se ganó Zamora en una hora» (2 % frente a 4 %) y «Dios los cría y ellos se juntan» (clubes) en la esquina. La caja de los estados (`eq:bsm`, `estados-eeuu`) y `convergencia-sigma`, como apoyo.
- **III.3**: una columna de signos a la derecha (+ capital humano inicial, + inversión, − consumo público, − inestabilidad, − distorsiones; «robusta: inversión»). Sin gráficos.
- **III.4**: el esquema `causas` se construye a la derecha (causas últimas → próximas → $Y/L$, con la flecha de la causalidad inversa); AJR con la cadena de 3 eslabones escrita como flechas y «VI 0,94 > MCO 0,52» y «Nigeria → Chile: ×7»; pegatina «árbol que nace torcido, jamás su tronco endereza» con el matiz de las 2 Coreas. `ajr-mortalidad`, la caja de las 2 etapas y las 4 visiones, como apoyo.
- **Conclusión**: sin pizarra; empieza por «En conclusión,»; la idea final vuelve a la foto de Nogales (apoyo) y termina con el refrán.
- **Al final**, la pizarra queda con las 2 funciones clave a la izquierda y el esquema de las causas a la derecha.

## Control de calidad (1/11/2026): correcciones aplicadas

- I.3: la participación salarial ajustada de España desde 2007 se mueve «entre el 53 y el 58 %»; el resultado de Gollin, «con el ajuste de Gollin… con datos de los 90».
- I.1: nota de que los niveles son PIB por habitante en PPA encadenada (rgdpe) y las tasas, a precios nacionales constantes (rgdpna); comprobado con el CSV de la PWT 11.0: Corea del Sur 1.363 → 52.389 $ (rgdpe) y 5,38 % anual (rgdpna); Nigeria 2.182 → 4.578 $ y 0,54 % anual (rgdpna): las cifras del texto cuadran.
- II.3 y tabla `tab:desarrollo`: la columna de 2023 es la muestra sin exportadores de petróleo ni centros financieros, 47,1 = 1,07 × 2,29 × 19,1 (la de la cabecera del CSV; recalculada con el CSV sin petroleros ni Irlanda, Luxemburgo, Singapur y Hong Kong sale 47,5 = 1,07 × 2,29 × 19,0, la diferencia es de la lista de centros financieros) (A45-27, en «Dudas abiertas»).
- III.1: tabla de teorías, «el modelo Sobelow \parencite{JonesManuelli1990}» (entrada copiada del 3A43.bib).
- III.3: Sala-i-Martín, Doppelhofer y Miller (2004): sin la tabla del artículo, «entre las más robustas, la ficticia de Asia oriental, la escolarización primaria, el precio relativo de la inversión y la renta inicial», sin orden.
- III.4: AJR con datos de 2023 sin Venezuela (62 países): pendiente −0,61, correlación −0,73.
- Esquema: el título nombra la distribución de la renta entre los factores.
- `.bib`: DOI o URL en Baumol1986 (JSTOR 1816469), DeLong1988 (JSTOR 1807174), CobbDouglas1928 (JSTOR 1811556), ByrneFernaldReinsdorf2016 (10.1353/eca.2016.0014, Crossref), KlenowRodriguezClare1997Neoclassical (10.1086/654324, Crossref), Hall1990 (versión de trabajo, NBER w3034) y Williamson1990 (PIIE); CBP2019Nogales sin la fecha en el título (salía el año 2 veces). Los identificadores de JSTOR de Baumol y Cobb-Douglas no se han podido abrir (JSTOR bloquea la consulta); el de De Long sale de OpenAlex.
- `revision.md`: resumen en 5 líneas, fila de AJR, tamaño de la foto (A45-04) y numeración de las contradicciones de § 6.

