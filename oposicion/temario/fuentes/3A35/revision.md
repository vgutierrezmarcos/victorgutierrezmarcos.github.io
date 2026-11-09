# Revisión del 3.A.35 · Teorías de la demanda de dinero. Implicaciones de política económica.

Revisión autónoma del 5/11/2026 (Víctor fuera: las dudas se resuelven con la opción recomendada y se anotan como A35-NN). Integración en 2 partes: **parte 1** (preámbulo, introducción, esquema, nota del reparto y apartado I entero; `3A35.bib`, `seo.json`, `graficos-pedidos.json` con todos los gráficos) y **parte 2** (II, III, conclusión y anexos). Las 2 partes están hechas.

## 1. Resumen

- El Word era un tema «en transición» (lo decía él mismo): estructura de la guía de un compañero, capturas de libros y de temas ajenos, modelos a medio hacer, sin bloque de implicaciones de política económica y con la conclusión y la estructura vacías.
- Se mantienen los 3 bloques del original en su orden; el tercero pasa a llamarse «Implicaciones de política económica. Una economía sin dinero en efectivo» y recoge el epígrafe del título que faltaba (III.1-III.3 nuevos; el apartado 3 original es III.4).
- Parte 1: introducción con sus 5 bloques y enganche nuevo («Poderoso caballero es don Dinero» y la paradoja del efectivo, con el SPACE 2024 y el BSI de septiembre de 2026); teoría cuantitativa desarrollada (tema de referencia), Keynes y Friedman en resumen con las ecuaciones del 3.A.4 y del 3.A.5, y el dinero fiduciario con Menger, Hahn, Samuelson (resumen) y Kiyotaki-Wright (desarrollo breve).
- Reparto: introducción 2′30″; I 7′30″; II 11′30″; III 7′30″; conclusión 1′. Compila sin avisos ni referencias indefinidas.
- Parte 2: II con los modelos ordenados por la función del dinero (Baumol-Tobin desarrollado con el ejemplo de Lucía, la condición de segundo orden, la velocidad endógena y la esquina, y Miller-Orr como extensión; Whalen; el MIU de Sidrauski con `eq:miu`, una sola derivación y la superneutralidad; el tiempo de compra y el pago por adelantado; Tobin (1958) con $w_{\mathrm B}$; Cagan en resumen) y la evidencia, cerrada con `tab:modelos-demanda-dinero`; III nuevo (regla de Friedman, eficacia de la estabilización con Poole, Goodhart y el dinero endógeno, señoreaje con la Laffer copiada y la economía sin efectivo con los datos de 2024-2026), la conclusión y 3 anexos (Sidrauski paso a paso, el origen del dinero, test). Tema completo: 30 págs. de tema, 2 de anexos y 5 de bibliografía en la prueba.

## 2. Errores corregidos

| Dónde | Decía | Dice ahora |
|---|---|---|
| Contextualización | Pigou (1907) | Pigou (1917), *QJE* |
| I.1.1, Cambridge | Marshall (1871) | Marshall, en declaraciones ante comisiones oficiales y en *Money, Credit and Commerce* (1923), como el 3.A.3 |
| I.1.1, Fisher | «identidad propuesta por Hume (1752)… Fisher fue el primer autor en expresar la ecuación cuantitativa» | Hume la expresa en palabras; la ecuación la escribe antes Newcomb (1885), a quien Fisher dedica el libro |
| I.1.1, Cambridge | $k\in(0,1)$; «constante de Cambridge» | $M^D=k\,P\,Y$, $k=1/V$ sin acotar; «enfoque de los saldos de caja de Cambridge»; $k$ como decisión |
| Nota de Salamanca | «13 años antes que Bodin» | 12 años (1556 y 1568), con Molina (1597) |
| I.1.1, evidencia | 0,92-0,96 | 0,925 (base monetaria), 0,958 (M1), 0,950 (M2), con los de la OCDE (V9) |
| I.1.1, implicaciones | «la PM y la PF son inefectivas» | la monetaria solo mueve los precios; la fiscal, a pleno empleo, expulsa gasto privado por el tipo real |
| I.1.2, Keynes | precaución $=f(Y,i)$ | la precaución depende de la renta, como en `eq:liquidez` del 3.A.4; su respuesta al tipo se anuncia con Whalen (1966) |
| I.1.2, Keynes | «mantener toda su **renta** en dinero» | toda su **riqueza** (decisión de cartera) |
| I.1.2, Keynes | tipo crítico $i_E$ = «el que genera pleno empleo» (nota 11) | tipo «normal», sin símbolo, el que cada inversor espera que vuelva; la nota 11 sale |
| I.1.2, Keynes | demanda escrita 2 veces | una sola, `eq:liquidez` como función clave (igual que el 3.A.4) |
| I.1.2, Keynes | «Keynes es el primer autor en concebir el dinero como activo» | lo nuevo es la especulación; Cambridge ya lo veía como depósito de valor |
| I.1.2, Keynes y Friedman | «ni la PF ni la PM son efectivas para afectar a la demanda de dinero»; «la PF no es efectiva para afectar a la demanda de dinero» | la pregunta es la eficacia sobre la renta, y depende de $h$: una frase con los 2 eslabones del 3.A.34 y remisión a III.2 |
| I.1.2, Friedman | $W_L/W$; «rentabilidad de activos financieros/reales»; depende «positivamente del nivel de precios» | `eq:demanda-dinero-friedman` del 3.A.5, con $r_b-r_m$, $r_e-r_m$, $\pi^e-r_m$ y $\overline W_H/\overline W$; demanda de saldos reales, sin $P$ |
| I.1.2, Friedman | «no es sensible al tipo de interés» | poco sensible ($h$ pequeño) |
| I.1.2, Friedman | «los monetaristas se oponen a la neutralidad» | no neutral a corto plazo, neutral a largo |
| Nota 18 | la regla del k % «coherente» con la regla de Friedman (1969) | nota nueva: son reglas distintas (k % da inflación baja y positiva; la de 1969, $i=0$ y deflación $-r$) |
| I.2, OLG | bloque con capital, ocio y 3 equilibrios según la depreciación (texto de otro opositor) | Samuelson (1958) en resumen con las letras y la pegatina del 3.A.29; la condición de dominancia (bien que se deprecia), en nota |
| Modelos de búsqueda | Kiyotaki y Wright (1993) solo | 1989 (*JPE*) y 1993 (*AER*) |

| II, Baumol-Tobin | $M$ «saldos reales» con $Y$ y $b$ nominales; la demanda es $M$; «elasticidad elevada al tipo»; «la evidencia no apoya las elasticidades» | Todo nominal y la homogeneidad en $P$ en una viñeta; la demanda es el saldo medio $M^*/2$; elasticidad $-1/2$ (moderada); con datos largos, 0,3-0,6 (Benati *et al.*, 2021) |
| II, Baumol-Tobin | «Baumol y Tobin destacan la necesidad de flexibilizar el sistema financiero» | Fuera (no está en los artículos); en su lugar, la innovación financiera baja $b$ |
| II, Miller-Orr | «el ingreso sigue un paseo aleatorio»; «estos límites son arbitrarios» (nota 20) | El saldo de caja de una empresa sigue un paseo aleatorio; solo el mínimo lo fija la empresa, retorno y límite superior son óptimos, con $z^*=(3b\sigma^2/4i)^{1/3}$ |
| II, Whalen | «el efecto de la renta es incierto»; «el beneficio marginal tiene forma de S invertida» (nota 21) | Elasticidad renta de 1/3 a 2/3 según crezca el número o el tamaño de los pagos; ley de la raíz cúbica; la S invertida era la probabilidad de iliquidez, no el beneficio marginal |
| II, MIU | «modelo RKC»; Patinkin (1951); restricción de 2 periodos que mezcla $(1+r)$ y $1/(1+\pi)$ y una CPO con $i$ que no aparece; derivación repetida en el anexo 2 | RCK; Patinkin (1956); una sola derivación, de horizonte infinito con capital, con $1+i_t\equiv(1+r_t)(1+\pi_{t+1})$ (anexo A) |
| II, MIU | «superneutralidad con utilidad separablemente aditiva» | La superneutralidad necesita trabajo inelástico; con trabajo elástico y utilidad no separable se pierde (Brock, 1974) |
| II, tiempo de compra | McCallum y Goodfriend (1985); ocio $h_t$ y tiempo $s_t$ | McCallum y Goodfriend (1987), con Saving (1971); $\psi(C_t,m_t)$ y el ocio sin letra |
| II, Tobin | «Arrow y Tobin (1958)»; $\alpha$, $\sigma_g$ y $\sigma_B$; indiferencia convexa «porque la aversión al riesgo es creciente»; efecto renta explicado con deudores y acreedores; el Reino Unido en 1992 | Tobin (1958); $w_{\mathrm B}$, $\sigma_{\mathrm B}$, $\mathbb{E}[r_p]$; convexa porque es averso al riesgo; efecto renta: misma rentabilidad con menos riesgo; el Reino Unido fuera (sin relación con el modelo) |
| II, Cagan | $\gamma$ constante, $\vartheta$, expectativas mezclando tiempo continuo y discreto, «$\alpha\beta>1$ típico de países menos adelantados», Meade | $\zeta$, $\alpha$, $\gamma_M$, $\dot\pi^e=\gamma(\pi-\pi^e)$; sin la estabilidad (3.A.39 y 3.A.41); fuera la frase sin fuente y la de Meade |
| II.2 | «más elástica a la riqueza que a la renta»; «la trampa no se pudo confirmar hasta Japón en los 90»; «estables hasta los 80» | Con fuentes: Ball (2001), Meltzer (1963), Knell y Stix (2005); Japón a finales de los 90 (Krugman, 1998) y 2008; ruptura desde 1974 (Goldfeld, 1976) |
| III.4 | «el tipo nominal no puede bajar de 0 %»; «esto es lo que ocurre en la actualidad»; *La maldición del metálico* como libro de Rogoff, «eliminar billetes de más de 20 y después las monedas»; Dinamarca 25 %, Suecia 2 %, España 60 %; economía sumergida 10-15 % | Límite efectivo algo negativo (BCE: −0,50 % de 2019 a 2022; hoy 2,50 %); *The Curse of Cash* (2016): primero 100 y 50, conserva los pequeños y las monedas; datos de 2024-2026; sin cifra de economía sumergida |
| Anexo 2 | «deberá imprimir dinero hasta que $i=0$» | Al revés: $i=0$ exige que el dinero decrezca, $1+\gamma_M=\beta$ |

## 3. Marcas resueltas

| Marca | Qué era | Qué se hizo |
|---|---|---|
| P1 | Estructura vacía (amarillo) | Escrita (K26) y esquema |
| P2 | Amarillos de la crítica de OLG que anunciaban «otros dos modelos» | Sustituidos por la valoración de Samuelson (paradoja del dinero dominado) y el nexo con II |
| P11 | Notas al opositor del cambio de temario y captura | Fuera |
| P12 | «Muy brevemente» (teoría cuantitativa) | Completa en el documento (tema de referencia), 2′ en el cante |
| P13 | 4 notas de clase sobre el dinero fiduciario | Redactadas en I.2 (paradoja del pasivo, confianza, equilibrios múltiples, divisa nueva o criptoactivo que no circula) |
| P20 | Enlace ccu.edu.tw (404) | Sustituido por el documento de trabajo del NBER (w3482), en una caja de anotaciones |
| P24-P26, P81 | Comentarios internos (Ángel, Juan Luis, José Luis, Sahuquillo; «copiar…») | No se publican |
| P31-P33 | Cajas de anotaciones (Hélène Rey, Khan Academy, UVa, Fraser) | Conservadas en `anotaciones` sin `?modal=1` (los de Khan Academy no se pudieron comprobar automáticamente, E2 y E5) |
| P35 | Caja de texto de OLG | Integrada en el cuerpo |
| P44, P45, P46, P47, P48, P49, P53 | Capturas de Fisher, Cambridge, Serletis, Keynes, trampa, OLG | Fuera; texto redactado de nuevo; gráficos `preferencia-liquidez` (3.A.4) y `samuelson` (3.A.29) copiados |
| Notas 3-18 | Salamanca, Guan Zhong, Serletis, velocidad, Cambridge (inglés), neutralidad (Sargent), Keynes (inglés), 10-17 | Salamanca completa; Guan Zhong fuera (V16); Serletis parafraseado; neutralidad/superneutralidad/dicotomía en nota sin la cita de Sargent (enlace bloqueado); la de Keynes, traducción propia; 10 y 13 integradas; 11 fuera; 12 en nota; 14 y 17, a III.2 (una frase aquí); 15 integrada; 16 a III.1; 18 corregida |

| P3, P4, P37, P38 | «Fuente: …» vacías de Miller-Orr y Whalen | Gráficos nuevos `miller-orr` y `whalen` con «elaboración propia a partir de…» (los dibuja tema-tikz) |
| P5 | Promesa de una extensión del MIU a economía abierta | Quitada |
| P6, P7, P10, P17, P28, P50, P52 | MIU a medio hacer en amarillo, programa de 2 periodos, crítica duplicada, «Ver Anexo A.2», ecuaciones como imagen | MIU completo con a)-d) y una sola derivación en LaTeX (anexo~A, `\ref`) |
| P8, P9 | Notas de Cagan (unidad de cuenta, Sargent, Meade; credibilidad y fragilidad) | Integradas en II.1.3 y III.3; Meade fuera (no se encontró la obra) |
| P14 | «Los bienes compran dinero…» | Aforismo de Clower (1967), parafraseado como en el 3.A.21 |
| P15, P16, P18 | Feenstra, NEK, superneutralidad, regla de Friedman, Divisia, «faltaría explicar cómo se obtiene» | Integrados: Feenstra en la valoración del MIU; NEK «sin dinero» con aviso frente a III.4; regla de Friedman derivada (III.1, anexo A); Divisia en II.2 |
| P19 | «Ver Doepke, cap. 8.3» | Manuscrito; se cita Walsh (2017) |
| P21-P23 | Tobin como modelo de referencia; IPE; «Sacado de Richard Roca» | Tobin (1958) desarrollado en clave monetaria; IPE como transmisión por carteras (`\vertema{3.A.37}`); Roca fuera, citados Tobin (1958) y Walsh |
| P34 | 2 cajas de *Nada es Gratis* | Conservadas en una `anotaciones` (enlaces activos) |
| P36, P39, P43 | Imágenes 1, 4 y 9 (capturas, fuente de otro opositor y estudio de 2022) | Gráficos nuevos `baumol-tobin`, `tobin-cartera` y `medios-pago-space` (SPACE 2024) |
| P40-P42 | Gráficos de Cagan (expectativas, estabilidad, señoreaje) | Fuera los 3 primeros; el del señoreaje, sustituido por `laffer-senoreaje` copiado del 3.A.39 |
| P51 | Gráfico del tipo de vaciado negativo | Sin gráfico: `\vertema{3.A.40}` (decisión del coordinador) |
| P60, P83 | Preguntas de otros exámenes vacías; enlace a quia.com | Anexo C con el enlace al simulador y las 7 preguntas que han caído; quia fuera |
| P84 | Biografía de Sidrauski (2 notas) | Una nota, sin datos personales |
| P85 | Notas en inglés (22, 31, 32) | Parafraseadas con cita (Feenstra, Schmitt-Grohé y Uribe, Walsh) |
| P86 | Afirmaciones sin fuente | Corregidas o fuera (ver «Errores») |

## 4. Datos actualizados

| Dato | Antes | Ahora | Fuente | URL | Consulta | 2.ª comprobación |
|---|---|---|---|---|---|---|
| Efectivo en pagos en tienda, zona del euro (número) | — | 72 % (2019) → 52 % (2024) | BCE, SPACE 2024 | https://www.ecb.europa.eu/stats/ecb_surveys/space/shared/pdf/ecb.space2024_charts.en.xlsx | 5/11/2026 | Texto del informe («52 %») |
| Ídem, España | — | 83 % (2019) → 57 % (2024) | BCE, SPACE 2024 | ídem | 5/11/2026 | Hoja ES del Excel por país (57,4 %) |
| Efectivo en circulación, zona del euro | — | 1,62 billones de € (sept. 2026), 341.200 M€ en 1999 | BCE, BSI | https://data.ecb.europa.eu/data/datasets/BSI | 5/11/2026 | Nota «Monetary developments» de sept. 2026 y 3A36 V9 |
| McCandless y Weber | 0,92-0,96 | 0,925 / 0,958 / 0,950; OCDE 0,894 / 0,940 / 0,958 | McCandless y Weber (1995), tabla 1 | https://www.minneapolisfed.org/research/qr/qr1931.pdf | 5/11/2026 | Verificador del 3.A.36 (copia de archive.org) |

| Efectivo en España (medio principal) | 60 % de las transacciones (sin año) | 57 % efectivo, 25 % tarjeta, 18 % móvil (2026) | BdE, *Estudio sobre hábitos en el uso del efectivo* 2026 | https://www.bde.es/f/webbe/GAP/Secciones/SalaPrensa/NotasInformativas/26/presbe2026-100.pdf | 5/11/2026 | Bases muestrales del informe ejecutivo |
| Efectivo en pagos en tienda, número y valor | — | España 57,4 % y 44,7 %; zona del euro 51,6 % y 39,2 % (2024) | BCE, SPACE 2024 | (la de arriba) | 5/11/2026 | Hoja por país y texto del informe |
| Dinamarca y Suecia | 25 % y 2 % | Dinamarca 9 % de los pagos (2025); Suecia 5 % pagó en efectivo su última compra (2025); Países Bajos 21,6 % (2024) | Danmarks Nationalbank; Riksbank; BCE | https://www.nationalbanken.dk/… ; https://www.riksbank.se/… | 5/11/2026 | Cifras de 2023 de las mismas fuentes |
| Efectivo en circulación y su peso | — | 1,62 billones; 14,3 % de M1 y 9,1 % de M3 (7,3 % en 1999) | BCE, BSI | https://data.ecb.europa.eu/data/datasets/BSI | 5/11/2026 | Nota monetaria de sept. 2026 |
| Velocidad | — | M2 de EE. UU.: 2,19 (1997), 1,13 (2020), 1,42 (2026T3); M3 zona del euro: 1,42 (1999) → 0,94 (2025) | FRED; BCE y Eurostat (cálculo propio) | https://fred.stlouisfed.org/series/M2V | 5/11/2026 | Recalculada con PIB y M2SL |
| Tipos negativos del BCE | «en la actualidad» | 11/6/2014-26/7/2022, mínimo −0,50 %; hoy 2,50 % | BCE | https://data.ecb.europa.eu/data/datasets/FM | 5/11/2026 | FRED ECBDFR |
| Euro digital | — | Comisión 28/6/2023; Consejo 19/12/2025; Parlamento 9/7/2026; sin acuerdo; piloto 2027 y emisión 2029 si se aprueba | BCE; Observatorio Legislativo del PE | https://oeil.europarl.europa.eu/… | 5/11/2026 | Ficha del PE y 3.A.36 |
| MiCA | — | Reglamento (UE) 2023/1114; *stablecoins* desde 30/6/2024, resto desde 30/12/2024 | EUR-Lex | https://eur-lex.europa.eu/eli/reg/2023/1114/oj | 5/11/2026 | Parcial (EUR-Lex bloquea la consulta automática) |
| Rogoff | *La maldición del metálico* (oct. 2016), billetes de más de 20 y monedas | *The Curse of Cash* (2016): primero 100 y 50, conserva los pequeños | Rogoff (2016) | — | 5/11/2026 | Parcial (reseñas) |
| Economía sumergida | 10-15 % del PIB | Sin cifra (no hay dato oficial) | — | — | 5/11/2026 | — |
| Sidrauski | «murió a los 28 años…» | 1939-1968, Chicago 1966, MIT | HET, Palgrave | https://hetwebsite.net/het/profiles/sidrauski.htm | 5/11/2026 | 2 fuentes |

## 5. Contenido añadido

- Introducción: enganche, relevancia (teoría, política, actualidad), contextualización propia (3 etapas; no la del Word, que repetía la del 3.A.36), problemática con 3 preguntas, estructura (C7-C10, K24-K27).
- I.1.1: Newcomb (1885), lectura de $k$ como decisión (3.A.3), `eq:cuantitativa-tasas`, McCandless y Weber completos y la causación inversa de Tobin (1970) (C12).
- I.1.2: cuadro `tab:keynes-friedman` (el anexo 1 del Word pasa al cuerpo, C16).
- I.2: apertura con la paradoja del dinero fiduciario (1971, `\vertema{3.B.20}`, McLeay, Radia y Thomas, 2014), Menger (1892) y Hahn (1965) (C18, C19); Kiyotaki y Wright con a)-d) y Lagos y Wright (2005) como extensión (K41).
- II: función general `eq:demanda-general` (C22); Baumol-Tobin con condición de segundo orden, homogeneidad, esquina, velocidad endógena, suela de zapato, ejemplo de Lucía y evidencia (C24); Miller-Orr con su fórmula (C25); Whalen con la ley de la raíz cúbica y Goldman (C26); MIU con superneutralidad, ejemplo logarítmico, Brock, la NEK y Feenstra (C27, C28); tiempo de compra y CIA con sus condiciones, Lucas y Stokey, Cooley y Hansen (C30, C31); Tobin con los efectos sustitución y renta (C33); Cagan con expectativas racionales (C34); evidencia con Divisia, identificación y 6 hechos con fuente, la velocidad copiada del 3.A.5 y el cuadro de síntesis con los colores de cada función (C35).
- III (nuevo, P54): regla de Friedman derivada con Lucía y los matices (Bailey, Lucas, Phelps, Schmitt-Grohé y Uribe) en resumen; pendientes de la LM, Poole, Goodhart, Bouey, el pilar monetario del BCE, el dinero endógeno y la transmisión por carteras; señoreaje con `eq:senoreaje` del 3.A.39, la Laffer y la credibilidad (Sargent, 1982); límite inferior, Rogoff, datos de pagos, criptoactivos, *stablecoins* (BPI, MiCA) y euro digital con la frase del 3.A.36 (C36-C42).
- Conclusión con sus 5 bloques y la idea final de K28 (C43); anexos de Sidrauski (C29), del origen del dinero (anexo 3 reducido, C3) y de test (C2).

## 6. Coherencia

- Ecuaciones y gráficos iguales a los de sus temas de referencia: `eq:liquidez` (3.A.4), `eq:demanda-dinero-friedman` (3.A.5), `eq:cuantitativa` para $MV\equiv PT$ (3.A.3) y `eq:cuantitativa-tasas` para las tasas (D7 a); `preferencia-liquidez` (3.A.4) y `samuelson` (3.A.29) copiados sin cambios (con una línea de origen al principio).
- Pegatinas: la del 3.A.4 para la trampa y la del 3.A.29 para Samuelson; nuevas (comprobadas con grep, sin uso en otros temas): «juntarse el hambre con las ganas de comer» (Kiyotaki-Wright) y las de II-III, ya anunciadas en la nota del reparto. Enganche «Poderoso caballero es don Dinero», sin uso en el temario. Sin la frase de Joan Robinson.
- Remisiones de la parte 1: 3.A.1, 3.A.2, 3.A.3, 3.A.4, 3.A.5, 3.A.21, 3.A.29, 3.A.33, 3.A.34, 3.A.36, 3.A.37, 3.A.38, 3.A.39, 3.A.41, 3.B.20, 3.B.24.
- Se cumplen las promesas de otros temas: Salamanca completa con 12 años (3.A.1, 3.A.2); Fisher, Cambridge y Menger con las palabras del 3.A.3; Hahn (3.A.21); Samuelson con sus letras (3.A.29); McCandless y Weber en desarrollo (3.A.36).
- **Contradicción menor** (para `pendientes-coherencia.md`): el 3.A.36 escribe «de 0,93 a 0,96» (redondeo válido de 0,925-0,958); aquí van los valores exactos. No se toca el 3.A.36.
- Parte 2: `eq:senoreaje` y `laffer-senoreaje` iguales que el 3.A.39; `velocidad-dinero` copiado del 3.A.5; euro digital con la frase del 3.A.36; Poole y Goodhart en mención con las palabras del 3.A.5 y el 3.A.36; Cagan en resumen con $\zeta$, $\alpha$, $\gamma_M$ (ficha `cagan`); «restricción de pago por adelantado» y Cooley y Hansen como el 3.A.6 y el 3.A.42; el MIU como forma reducida y la economía «sin dinero» de la NEK avisada frente a la economía sin efectivo (3.A.7); RCK (3.A.43); Gorman en una nota con `\vertema{3.A.8}`. `estancamiento-secular` no se copia: solo `\vertema{3.A.40}`.
- Para el canon (CC1-CC10 de coherencia): fichas nuevas `miu-sidrauski`, `cia` y `kiyotaki-wright` con este tema de referencia; terminología «pago por adelantado» a unificar en el 3.A.21 y el 3.A.29 (cosmético).
- Remisiones de la parte 2: 3.A.3, 3.A.4, 3.A.5, 3.A.7, 3.A.8, 3.A.10, 3.A.21, 3.A.34, 3.A.36, 3.A.37, 3.A.39, 3.A.40, 3.A.41, 3.A.42, 3.A.43, 3.B.2, 3.B.23.

## 7. Dudas abiertas

Resueltas con la opción recomendada (decisiones del coordinador y de coherencia): D1 a (III con título ampliado), D2 a (Kiyotaki-Wright en I.2), D3 a (Keynes y Friedman en resumen, fuera las «3 razones»), D5 a (anexo «El origen del dinero» reducido), D6 a (enganche), D7 a (etiquetas), D8 a (Salamanca completa aquí), D9 → $w_{\mathrm B}$ en Tobin; $M^D=M^*/2$ sin barra.

- **A35-01** · Cuadro Keynes-Friedman: (a) **en el cuerpo, al cerrar I.1.2** (`tab:keynes-friedman`, propuesta C16; aplicado), o (b) como anexo A, como proponía coherencia.
- **A35-02** · Cita de Azpilcueta: (a) **solo la frase clave**, con ortografía modernizada, citada por Grice-Hutchinson (1952) (aplicado); la redacción literal no se ha cotejado con la edición de 1556; (b) quitar las comillas y parafrasear.
- **A35-03** · «Como señala Laidler» (Word): (a) **se mantiene la cita con Laidler (1993), *The Demand for Money*, 4.ª ed.** (aplicado; la edición y la página no se han comprobado); (b) quitarla.
- **A35-04** · Hicks: «el dinero se define por lo que hace» va **parafraseado, sin comillas ni página** (Hicks, 1967); la cita literal del Word no se ha encontrado.
- **A35-05** · La nota de Mill, Wicksell y Walras (contextualización del Word) se conserva en una nota al pie con Wicksell (1898) y Walras (1874) en vez de «Wicksell (1906)» y «Walras (1890)» (F5).
- **A35-06** · Kiyotaki y Wright (1989): los equilibrios «fundamental» y «especulativo» y el mixto con probabilidad $x$ (1993) se han redactado con el artículo como referencia, sin cotejar la página.
- **A35-07** · `samuelson` se incluye como figura en el documento (no se canta), aunque coherencia la proponía solo como apoyo del vídeo.

- **A35-08** · Contenido propuso 4 anexos más (inventarios, tiempo de compra y CIA, coste de bienestar con el triángulo de Bailey y su gráfico): (a) **no se hacen** (el coordinador fija 3 anexos; las derivaciones de Whalen y del tiempo de compra van en notas al pie y el coste de bienestar se resume en III.1 con `\vertema{3.A.41}`); (b) añadirlos.
- **A35-09** · El Reino Unido en 1992: (a) **fuera** (la explicación por la deuda a tipo variable no tiene fuente y no sale de Tobin; si se citara, sería la salida del mecanismo de tipos de cambio del SME); (b) mantenerlo sin la causa.
- **A35-10** · Cagan va como un solo `\paragraph` con rótulos en viñetas (Idea, Modelo, Implicaciones) por ser resumen de 1′; (a) **así**; (b) con a)-c) en `\subparagraph`.
- **A35-11** · La condición de la CIA ($u_{\text{ocio}}/u_C=w/(1+i)$ en el estado estacionario) y la del tiempo de compra se dan sin anexo propio, con la derivación del tiempo de compra en una nota; el orden de los mercados (Lucas frente a Svensson) solo cambia el desfase del tipo.
- **A35-12** · Pegatina de la unidad de cuenta: contenido proponía «cuentas claras y chocolate espeso»; (a) **sin pegatina** para Cagan (no está en la lista del coordinador); (b) añadirla.
- **A35-13** · `eq:demanda-general` va como ecuación numerada, no como `\funcionclave`, para dejar las 3 funciones clave (`eq:liquidez`, `eq:baumol-tobin`, `eq:miu`); en la pizarra se escribe a la derecha y se llena.
- **A35-14** · Los gráficos nuevos los dibuja tema-tikz a la vez: cuando los entregue, comprobar que las capas y los rótulos coinciden con el texto ($M^{\mathrm{inf}}$, $M^{\mathrm{ret}}$, $M^{\mathrm{sup}}$; $w_{\mathrm B}$, $\mathbb{E}[r_p]$; panel a y b de Baumol-Tobin).
- **A35-15** (control de calidad, 5/11/2026) · $\pi^*$ significa 2 cosas en III: la inflación de la regla de Friedman ($\pi^*\simeq-r$, `eq:regla-friedman`, III.1) y la que maximiza el señoreaje ($\pi^*=1/\alpha$, III.3 y el gráfico `laffer-senoreaje` copiado del 3.A.39, que lo rotula así). (a) **dejarlo** (cada uno es el canon de su tema de referencia, 3.A.41 y 3.A.39, y van en apartados distintos); (b) en este tema, escribir $\pi^{S}=1/\alpha$ (o $\pi^{\max}$) en III.3 y en el gráfico.
- **A35-16** (control de calidad) · «Milton Friedman» sin `\autor` en el título del vídeo del Fraser Institute (anotaciones de I.1.2): es el título literal del vídeo y no se toca (el aviso de verificar-tema se acepta).

## Enlaces del original (9/11/2026)

Regla nueva de CRITERIOS § 4: los enlaces del tema original se conservan.

- **Restaurados** (2):
  - Documento de trabajo de Sargent en el repositorio de la Universidad de Minnesota (n.º 1975-56, pp. 60-66), que el original enlazaba en la nota de neutralidad y dicotomía: `\href` en la nota de la neutralidad del dinero (I.1), con el identificador permanente `hdl.handle.net/11299/54808`, porque la dirección antigua (`/bitstream/handle/…`) es de la versión anterior del repositorio. El repositorio bloquea las consultas automáticas (403), así que **no se ha podido ver el título del documento**: conviene que Víctor lo abra y, si es el borrador de *Macroeconomic Theory*, se pase al `.bib`.
  - Documento de trabajo del NBER de Schmitt-Grohé y Uribe (w16054), que el original citaba en la nota de la regla de Friedman: `url` (versión de libre acceso) y `urldate` en la entrada `SchmittGroheUribe2010Optimal`, que cita la versión publicada en el *Handbook*.
- **Ya estaban** (por otra vía): los 2 vídeos de Khan Academy (funciones del dinero y curva de demanda de dinero), en las cajas de anotaciones; Feenstra (1986), con su DOI en el `.bib`; el estudio de hábitos de uso del efectivo del Banco de España, sustituido por la edición de 2026 y por la página con todas las ediciones (`BdE2026HabitosWeb`).
- **No restaurados**:
  - `econ.ccu.edu.tw/graduate/1051114.pdf` (nota al opositor de Kiyotaki y Wright): da 404 y no se ha encontrado otra dirección; el tema ya enlaza el documento de trabajo del NBER de Kiyotaki y Wright.
  - Documento de Google Docs con la estructura del tema de otro preparador: privado y de otro preparador.

## 8. Instrucciones para el vídeo

- Introducción y conclusión sin pizarra. Enganche: Quevedo y la paradoja del efectivo (cada vez se paga menos con billetes y nunca ha habido tantos); idea final que lo retoma (K28): don Dinero es poderoso, pero su poder es prestado.
- I: en el centro, $M\,V\equiv P\,T$ y $M^D=k\,P\,Y$ con $k=1/V$; a la derecha, `eq:liquidez` recuadrada (se conserva hasta III); `preferencia-liquidez` por capas (imprescindible: al menos el panel agregado con el tramo horizontal y la pegatina del caballo); la demanda de Friedman escrita con los signos debajo. McCandless y Weber como apunte. I.2: 2 líneas («Samuelson: depósito de valor entre generaciones»; «Kiyotaki-Wright: medio de cambio por confianza, equilibrios con y sin dinero») con sus pegatinas; `samuelson` solo como apoyo.
- II: se borra todo menos `eq:liquidez`. A la derecha, `eq:demanda-general`, que se llena con los argumentos y elasticidades de cada teoría hasta ser la versión corta de `tab:modelos-demanda-dinero` (nunca se escribe 2 veces). `baumol-tobin` por capas, imprescindible (dientes de sierra, luego la U y el giro al subir $i$), con `eq:baumol-tobin` recuadrada y el ejemplo de Lucía de palabra con 2 cifras; Miller-Orr y Whalen de palabra (sus gráficos, como apoyo). `eq:miu` recuadrada; $C_t\leq m_t$ y $\psi(C_t,m_t)$ en una línea cada una. `tobin-cartera` en 2 cuadrantes, recomendado. Cagan en una línea (`eq:cagan`). `velocidad-dinero` como apoyo.
- III: se conservan `eq:liquidez` y `eq:miu`; junto a esta, «$i=0\Rightarrow\pi=-r$». De palabra, las pendientes, Poole y Goodhart. $S=\pi\,M/P$ y $\pi^*=1/\alpha$ escritos; `laffer-senoreaje` y `medios-pago-space` como apoyo. Al final la pizarra queda con las 3 funciones clave y la tabla de síntesis.
- Pegatinas (una vez cada una, junto a su concepto): «en el término medio está la virtud» (Baumol-Tobin), «por si las moscas» (Whalen), «el dinero no da la felicidad» (MIU), «por dinero baila el perro» (CIA), «no poner todos los huevos en la misma cesta» (Tobin), «ojos que no ven, corazón que no siente» (Rogoff y el efectivo).
