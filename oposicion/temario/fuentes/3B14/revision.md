# 3.B.14 — Teorías de la determinación del tipo de cambio: informe de revisión

Revisión del 11/11/2026 (/revisartema, fase 3). Fuente: `3B14.tex` y `3B14.bib` (110 entradas). Cante: introducción 2′30″, I 6′30″, II 12′30″, III 7′30″, conclusión 1′ (30′). PDF de prueba: 36 páginas de tema, 6 de anexos y 6 de bibliografía.

## 1. Resumen

- Se conservan los 3 bloques del original (tradicionales, activos, desarrollos recientes) y sus segundos niveles, con títulos limpios (K1). El tipo de cambio real que pedía la propuesta de contenido entra dentro de ellos: PPA y **Balassa-Samuelson en desarrollo** en I.2, persistencia de las desviaciones en I.2.1 y en el anexo A, y **tipo real de equilibrio (FEER, BEER, EBA)** como III.1.3 nuevo.
- **Dornbusch y Branson en desarrollo** (el 3.B.14 es su tema de referencia), con la notación del canon ($k$, $h$, ψ, ν, $\bar a$, θ local; $w_{\mathrm M}$, $w_{\mathrm B}$, $w_{\mathrm B^*}$), las 3 funciones clave (`eq:balassa-samuelson`, `eq:monetario`, `eq:sobrerreaccion`) y anexos con el diagrama de fases, las pendientes del modelo de cartera y la θ racional.
- La paradoja del margen *forward* y la eficiencia, que estaban desarrolladas (2.240 palabras), pasan a un resumen con remisión al 3.B.13; III.2 se recorta (Corsetti-Pesenti a mención) y gana III.2.3 (Gabaix y Maggiori, Itskhoki y Mukhin, Lilley *et al.*).
- Datos al día: BIS 2025 (9,5 billones diarios), OMC 2025 (34,65 billones), índice Big Mac de julio de 2026 (gráfico nuevo con datos), External Sector Report del FMI de 2026. Enganche nuevo con refrán («El hombre propone y Dios dispone») y el euro frente al dólar 1999-2022; la idea final lo retoma.
- Unos 20 errores corregidos, las 68 marcas de `pendientes.md` resueltas, 11 gráficos pedidos (10 ya dibujados), anexo de test con las 22 preguntas oficiales y el enlace genérico al simulador.

## 2. Errores corregidos

| Dónde (original) | Decía | Dice ahora |
|---|---|---|
| 1.1, l. 176 (P51) | si la moneda se deprecia, aumentan las exportaciones y las entradas de capital y «disminuye la **demanda** de divisas» | aumenta la **oferta** de divisas (I.1 b) i)) |
| 1.3, l. 534 (P52) | «la PCI se cumple continuamente con mucha precisión» | se cumplía casi exactamente hasta 2008; desde entonces, base de los *swaps* (Du, Tepper y Verdelhan, 2018) |
| 1.3, l. 520-522 y nota 15 (P53) | implicaciones con $s_{t+1}$ en vez del esperado; «$\ln(1+i)=\ln(1+i^*)\cdot\ln(\dots)$» | $E^e_{t+1}$; los logaritmos convierten el producto en suma |
| 3.1.2, l. 1337 (P54) | PCI = la cotización descuenta la información pública; PNCI = también la privada | la PCI es no arbitraje y la PNCI, especulación con neutralidad al riesgo (sale con el recorte; resumen en III.1.2) |
| 3.1.2, l. 1361 (P54) | «la **PCI** señalaría que…» | la PNCI (y aviso en el anexo de test: la pregunta de 2006 da por buena la redacción con PCI) |
| 2.3, l. 1175 (P55) | el paseo aleatorio predice peor al acortar el horizonte… | el error del paseo aleatorio crece con el horizonte y aun así los modelos no lo superan; a varios años los fundamentos recuperan algo (Mark, 1995) |
| 2.3, l. 1233 (P56) | el residuo no es ruido blanco, «por lo que en realidad sigue caos determinista» | las no linealidades las explica sobre todo una volatilidad cambiante (Hsieh, 1989); no prueba caos (nota al pie) |
| 2.1.3, l. 909 (P57) | precios fijos a corto plazo «y flexibles a corto plazo» | flexibles a largo plazo |
| 2.1.3, nota 31 | efecto de $h$ en la sobrerreacción al revés | mayor cuanto **menor** es $h$ (y $\theta$): $de/dm=1+1/(h\theta)$ |
| 2.2, l. 1109 | «cuenta comercial» | cuenta corriente |
| Fechas (P58, V14-V41) | Frenkel y Mussa (1976) como un artículo; Branson 1976; Obstfeld y Rogoff 2001; Engel y West 2004; Hume (1752) como identidad del gasto; Hodrick 1990; Frenkel y Mussa (1980) para las noticias; Bacchetta y van Wincoop 2009; NOEM «a principios de los 90»; Roll (1977) | Frenkel (1976), Mussa (1976) y Bilson (1978); Branson (1977); 2000; 2005; Fisher (1911), con Hume de antecedente; Hodrick (1987); Frenkel (1981) y Mussa (1982); 2013; 1995 (*Redux*); Roll (1979) (la de 1977 es la crítica del CAPM: nota quitada) |
| Evans y Lyons (V34) | la predicción de 1 día a 1 mes atribuida al artículo de 2002 | es de Evans y Lyons (2005) |
| Clarida (V26) | «Richard Clarida», «diez divisas» | Clarida y Waldman (2008), 10 países, 2001-2005 |
| Anexo 3, burbujas (C21) | con información perfecta no puede haber burbujas; solo con información imperfecta | Blanchard y Watson (1982): burbujas **racionales**, compatibles con expectativas racionales (`eq:burbuja`); coincide con el test de julio de 2022 (n.º 36) |
| Conclusión, nota 47 (P60) | un tipo de interés más alto «deprecia» y la nota dice que aprecia | Frankel (1979): deprecia si refleja más inflación esperada y aprecia si refleja una política restrictiva (`eq:frankel`) |
| Anexo 2 (P61) | la productividad abarata los comerciables y aprecia, sin relación con Balassa-Samuelson | se reconcilian: apreciación nominal por la demanda (Mishkin) frente a apreciación real por los no comerciables (B-S) (anexo `anexo:mishkin`) |
| Balassa-Samuelson, l. 389-391 | suben los salarios **reales**; los salarios reales iguales al producto marginal | el salario **nominal** se iguala entre sectores y es igual al **valor** del producto marginal, $W=P_TA_T=P_NA_N$ |
| Nobel de Fama (V28) | «análisis empírico de precios de posesiones capitales» | sale con el recorte (está bien en el 3.B.13) |
| Big Mac (P20) | captura de FXSSI con «Porcelana» por China, sin fuente | gráfico de datos nuevo con *The Economist* (julio de 2026) |

## 3. Marcas resueltas

- **Amarillo y rojo (P1-P5)**: P1/P20 (fuente vacía del Big Mac): gráfico rehecho con el repositorio de *The Economist* y citado. P2 (IS-LM-BP borrador): I.4 en 3 viñetas con `\vertema{3.A.32}` (decisión del canon). P3/P4 (identidad del gasto, «omisible»): nota al pie del II.1.1 con Fisher (1911) y Hume (1752). P5 (rojo, hechos de Mussa): tabla rehecha con Mussa (1979, 1984) y Frankel y Rose (1995); los hechos 5 y 7 del original no son de Mussa y se sustituyen; el «más del 90 %» no se ha encontrado y no se da.
- **Notas al opositor y comentarios (P6-P18)**: aviso del cambio de temario, «ver Gandolfo», «lo que falta sacar del tema de ICEX-CECO», los tiempos («5′», «10-12′», «8-10′») y los comentarios sobre clases y preparadores: no se publican. P8 (la evidencia es muy importante) → `notaopositor` del reparto. P13/P15 (cartera: 2 curvas; $B^*B^*$ arriba o abajo) → `notaopositor` tras el gráfico de cartera. P16 (3 ideas de Meese y Rogoff) → `notaopositor`. P11 y P17 (coordinar con 3.B.12 y 3.B.13): hecho (I.1 como teoría de flujos con remisión al 3.B.13; paradoja del *forward* resumida).
- **Figuras (P19-P34)**: todas a TikZ o pgfplots (ver «Instrucciones para el vídeo» y `_trabajo/graficos-pedidos.json`); la lámina escaneada del modelo de cartera (P31), de otro autor, pasa a la tabla `tab:branson`; las 3 fórmulas pegadas de De Grauwe y Grimaldi (P32) salen (están en `anexo:degrauwe` del 3.B.13); tablas de supuestos y de modelos (P33, P34): `tab:supuestos-activos` y `tab:modelos`.
- **Epígrafes (P35-P42)**: P39 (dinámica del tipo real) en I.2.1 c) y anexo A; P40 (Balassa-Samuelson) en desarrollo en I.2.2 y tipo real de equilibrio en III.1.3; P41 (apartados vacíos): evidencia del monetario flexible, evidencia y valoración de cartera, valoración de Corsetti-Pesenti, implicaciones de Evans-Lyons y relevancia, extensiones y opinión de la conclusión, todo escrito; P42 (preguntas de otros exámenes) → anexo de test.
- **Remisiones (P43-P50)**: todas con `\vertema` detrás de la idea (lista K21); internas con `\ref`.
- **P59** (inglés): notas 18, 42, 45 y el bloque *scapegoat* redactados en castellano o retirados; nota 39 (Fox y Quiggin) retirada (opinión sobre la eficiencia, 3.B.23).
- **P63-P65 (bibliografía y enlaces)**: «Tema ICEX-CECO», «Tema Juan Luis Cordero Tarifa» y la nota de «José Luis» no se publican; Comín (2014) no se usa. Enlaces: economist.com/big-mac-index → `Economist2026BigMac` (dirección nueva); Wikipedia del índice Big Mac → sustituida por el repositorio de datos (`Economist2026BigMacDatos`); DOI de Taylor y Taylor (2004) en su entrada; FT (Garnham, 2007) en `Garnham2007Canadian` (muro de pago, no comprobado); ifo.de CESifo WP 1849 (roto y de otros autores) → `DeGrauweRovira2006` (ideas.repec); BCE WP 1418 → `FratzscherSarnoZinna2012`; Wikipedia e Investopedia de la crítica de Roll: fuera con la nota 41; quia.com: fuera (anexo de test con el simulador).

## 4. Datos actualizados

| Dato | Valor anterior | Valor nuevo | Fuente | URL | Consulta | Segunda comprobación |
|---|---|---|---|---|---|---|
| Volumen diario del mercado de divisas | 7,5 billones de $ (abril de 2022) | 9,5 billones de $ (abril de 2025) | BIS, Encuesta Trienal 2025 (`BIS2026TrienalDatos`) | https://www.bis.org/statistics/rpfx25.htm | 11/11/2026 | Huang, Krohn y Sushko (2025), BIS QR: 9,5; la página del BIS titula 9,6 (ver dudas) |
| Comercio mundial de bienes y servicios | 31 billones de $ (2022); «~88 veces» | 34,65 billones de $ (2025); «en menos de 4 días» | OMC, *Global Trade Outlook* (marzo de 2026) (`OMC2026GTOS`) | https://www.wto.org/english/res_e/booksp_e/gtos0326_e.pdf | 11/11/2026 | 3B05, 3B06, 3B07 y 3B13 (34,65) |
| Índice Big Mac | captura de 2022 sin fuente | julio de 2026: euro +13,8 % (ajustado +29,1 %), franco suizo +45 %, yen −50 %, renminbi −37 % (ajustado −24 %), rupia indonesia −62 % | *The Economist*, repositorio `big-mac-data` (`Economist2026BigMacDatos`) | https://github.com/TheEconomist/big-mac-data | 11/11/2026 | Le News (31/7/2026), ZKB (julio de 2026), tipo del BCE del 1/7/2026 |
| Evaluación del FMI de la posición exterior | — (nuevo) | 2025: zona del euro en línea; EE. UU. más débil; China, Alemania y España más fuertes; Japón algo más fuerte | FMI, *External Sector Report 2026* (`FMI2026ESR`) | https://www.imf.org/en/publications/esr/issues/2026/07/30/external-sector-report-2026 | 11/11/2026 (fase de contenido) | solo dentro del propio informe (2 listas que coinciden) |
| Euro frente al dólar (enganche) | — (nuevo) | 1,1789 (4/1/1999), 0,8252 (26/10/2000), 1,5990 (15/7/2008), 0,9565 (28/9/2022) | BCE (`BCE2026EURUSD`, la clave del 3.B.13) | serie EXR.D.USD.EUR.SP00.A | 11/11/2026 | 3.B.13; históricos, no caducan |

Todo lo que caduca está en `datos-actualizables.yaml` (4 entradas: `trienal-volumen`, `trienal-vs-comercio`, `big-mac`, `fmi-esr-evaluacion`) y en `datos/bigmac-2026-07.csv`.

## 5. Contenido añadido

- **Introducción**: enganche con refrán y el euro 1999-2022 (BCE); relevancia nueva desde la pregunta del tema, con BIS y OMC (las cifras del 3.B.13) y Volcker en nota; caja gris de notación (K3); esquema con minutos.
- **I.1**: ecuación de flujos de Kallianiotis (2013), Marshall-Lerner y tipo de cambio sombra (3.B.17).
- **I.2**: PPA absoluta y relativa en a)-d), cita de Cassel (1922, págs. 138-139) traducida, evidencia (Mussa, 1984 y 1986; Rogoff, 1996; Taylor y Taylor, 2004; Taylor, Peel y Sarno, 2001; nota de Roll, 1979), caja del Big Mac; Balassa-Samuelson en a)-e) con su derivación, gráfico de flechas, extensiones y evidencia (Chong, Jordà y Taylor, 2012; Engel, 1999).
- **I.3**: cuadro de las paridades (gráfico), base de los *swaps* desde 2008.
- **II**: tabla de supuestos que levanta cada modelo; enfoque monetario con la solución de valor presente (`eq:valor-presente`); Dornbusch con 4 ecuaciones, largo plazo, `eq:dornbusch-activos`, gráficos de mercados y trayectorias, expansión anunciada (Wilson, 1979), Frankel (1979), *delayed overshooting* (Eichenbaum y Evans, 1995; Faust y Rogers, 2003); Branson con riqueza, pesos, prima de riesgo, tabla de efectos y evidencia (Frankel, 1982; Dominguez y Frankel, 1993; Blanchard, Adler y Carvalho, 2015); contrastación con Engel y West (2005), Sarno y Schmeling (2014) y Rossi (2013).
- **III (parte 2)**:
  - III.1.1: la regla de Taylor en diferenciales (`eq:taylor-tc`, la forma de Engel y West, 2006, y Molodtsova y Papell, 2009) y gráfico nuevo `paradoja-apreciacion`; Garnham (2007) en nota (enlace del original).
  - III.1.2: la regresión de Fama (`eq:fama-tc`), Froot y Thaler (1990), el matiz de Hodrick (1987) y las 3 salidas, en resumen; noticias, burbujas, expectativas heterogéneas y chivo expiatorio al anexo `anexo:expectativas`.
  - III.1.3 (nuevo): modelo de fondos prestables (Mankiw, 2014; pregunta de test de 2016), tabla `tab:equilibrio-real` (PPA, FEER de Williamson, 1983; BEER de Clark y MacDonald, 1999; EBA del FMI, 2013) y la evaluación del ESR de 2026.
  - III.2.1: NOEM en mención (Obstfeld y Rogoff, 1995; SIGMA y GEM con fuente; Corsetti y Pesenti, 2009, versión publicada del documento de trabajo de 2005, la misma clave que el 3.A.37; PCP frente a LCP; Betts y Devereux, 2000; facturación en dólares, Gopinath *et al.*, 2020).
  - III.2.2: Evans y Lyons con su ecuación (`eq:evans-lyons`), implicaciones (estaban vacías), evidencia de 2002 y 2005 y valoración.
  - III.2.3 (nuevo): Gabaix y Maggiori (2015), Itskhoki y Mukhin (2021) con la PNCI con prima (`eq:pnci-prima`) y Lilley *et al.* (2022); caja `ideaclave` que resume las respuestas a la desconexión.
- **Conclusión**: recapitulación por horizontes con Frankel (1979) y Rossi (2013), Edgeworth en paráfrasis, relevancia, extensiones, opinión e idea final que retoma el refrán.
- **Anexos**: A, evidencia sobre la PPA (regresiones, raíz unitaria, cointegración, series largas y paneles; Lothian y Taylor, 1996; Imbs *et al.*, 2005); B, Dornbusch completo con el término $b\,i$, curvas $\dot e=0$ y $\dot p=0$, θ racional (`eq:theta-racional`), senda de silla, gráfico `dornbusch-fases`, expansión anunciada y producción variable; C, pendientes del modelo de cartera con $w$ y ley de Walras; D, factores reales de Mishkin, Matthews y Giuliodori (2013) reconciliados con B-S; E, modelos de expectativas (noticias, burbujas racionales con `eq:burbuja`, chartistas, chivo expiatorio); F, test.

### Propuestas: qué se aplicó

- **Contenido (C1-C31)**: aplicadas C2-C3, C5 (con otro refrán), C7, C8, C10-C24 (recolocadas en la estructura de coherencia), C25 (con el refrán de coherencia y Edgeworth sin año), C26-C31. Rechazadas o adaptadas: **C1** (estructura del contenido oficial: rechazada por CRITERIOS §2, se conservan los bloques del original; su contenido entra en I.2 y III.1.3); **C4** ($w$ en Branson, $\omega_N$ en B-S, caja de notación en vez de nota); **C6** (relevancia nueva, sin repetir la del 3.B.13); **C9** (sustituida por K3); **C21** (los enfoques alternativos van en III.1 y III.2, no en II.3.2; las expectativas pasan al anexo E para no alargar el cante; la cita literal de Fama del Nobel no se usa); **C24** (el arancel aprecia «sin cambiar las exportaciones netas», tal cual); **C27** (etiquetas adaptadas a la estructura final).
- **Datos (V1-V48)**: aplicadas todas las correcciones (V13-V15, V17, V22, V23, V26, V28, V31-V34, V39, V41, V42) y actualizaciones (V1-V4). Sin poder comprobar y tratadas así: V12 (página de Gandolfo: no se da), V18 (Wolff: sin autor), V19 («90 %»: no se da), V21 (Blaug: paráfrasis sin comillas), V36 (Edgeworth: sin año ni cita), V38 («1-3 años»: se da la cifra de Taylor y Taylor, 2004, pág. 146), V45 (páginas de KOM 2018: se cita KOM 2022 por capítulo), V46 (SIGMA y GEM: se citan Erceg, Guerrieri y Gust, 2005, como el 3.A.37, y Bayoumi *et al.*, 2004, IMF Occasional Paper 239, comprobada en Crossref el 11/11/2026: DOI 10.5089/9781589063754.084, ocho autores —Bayoumi, Faruqee, Laxton, Karam, Rebucci, Lee, Hunt y Tchakarov—, Washington D. C.).
- **Coherencia (K1-K24)**: aplicadas todas, con 2 matices: K10 (se conserva el gráfico `monetario-flexible`, además de la discontinua en `dornbusch-trayectorias`) y K13 (el caos va en nota al pie, no en caja gris). Anexos en el orden de K22 salvo que la teoría del caos no tiene anexo propio (está en la nota de II.3.2).
- **Pendientes (P1-P68)**: todas resueltas (sección 3). P66-P68 (otros preparadores): Tebar contrastado por la fase de contenido; Luis de Fuentes cifrado; Cerezal y Cordero, sin material útil.

## 6. Coherencia

- **Notación** (canon § 9): $E$ directo, $e=\ln E$, $E^e_{t+1}$, $\gamma E^e$, $\gamma_E$, $q=EP^*/P$, $\mathbb{E}_t$, ρ; Dornbusch con $k$, $h$, ψ, ν, $\bar a$, θ local y, ahora también en el cuerpo, $b$ de la IS en la demanda (para que coincida con el gráfico de fases); Branson con $W$, $w_{\mathrm M}$, $w_{\mathrm B}$, $w_{\mathrm B^*}$, $MM$, $BB$, $B^*B^*$ en $(i,E)$; B-S con $\omega_N$, $a\equiv\ln A$; regla de Taylor en diferenciales con $\phi_\pi$, $\phi_x$, $x_t$ (las del 3.A.36), $\pi^*$ extranjera avisada; $\mathrm{FO}_t$ local; $E_0$ para el tipo de vaciado.
- **Mismas cifras y claves** que el 3.B.13 (BIS, OMC, BCE, Froot y Thaler, Hodrick, De Grauwe y Grimaldi), el 3.A.37 (Corsetti y Pesenti, SIGMA, Gopinath), el 3.B.11 (ESR 2026, EBA), el 1D01 (Rogoff, 1996: 3 a 5 años).
- **Cambios al canon** propuestos por coherencia (CC1-CC9): fichas `dornbusch` y `branson` con la notación de este tema y sus gráficos de referencia (`dornbusch-trayectorias`, `dornbusch-mercados`, `dornbusch-fases`, `branson`); fichas nuevas `ppa`, `balassa-samuelson`, `enfoque-monetario-tc` y `oferta-demanda-divisas`; filas nuevas de `notacion.md`; `mapa.yaml`. Los aplica `tema-canon`.
- **Para otros temas** (no se han tocado; van a `canon/pendientes-coherencia.md`):
  - **3.B.13** (C1): rotula $E^{*}$ el tipo de vaciado del mercado de divisas (l. 453, 601, 611 y `graficos/oferta-demanda-divisas.tex`, l. 18); debería ser $E_0$, como la copia de aquí.
  - **3.B.13** (C2, opcional): l. 352, añadir `\vertema{3.B.14}` al flujo de órdenes.
  - **3.A.32** (C3): l. 185 remite el enfoque monetario de la balanza de pagos solo al 3.B.14; debería remitir también al 3.B.12 (y la fila del 3.A.32 en la ficha `mundell-fleming`).
  - **Hodrick (1987)**: el matiz de la constante se cita con `Hodrick1987Empirical`, como el 3.B.13 (el original decía «Hodrick, 1990»).
- **Temas sin revisar** (para cuando se revisen): 3.B.12 (año y obra de Branson; su anexo de oferta y demanda de divisas duplica; enfoque monetario de la BP simétrico al de aquí), 3.B.15 (copia el Dornbusch del Word con la misma errata; «Frenkel y Mussa, 1979»), 3.B.16 (enganche con Volcker; Balassa-Samuelson con la ecuación de aquí), 3.B.19 (Frenkel, 1976, y Mussa, 1976).

## 7. Dudas abiertas

1. **Estructura** (D-1, C1 frente a K1): se ha aplicado la del original de Víctor (3 bloques: tradicionales, activos, recientes), con el tipo real de equilibrio en III.1.3. La alternativa de contenido (I paridades, II nominal, III real) cambiaría los títulos de primer nivel. Aplicada: la del original. **Respuesta de Víctor (12/11/2026):** bloques del Word (tradicionales, de activos y recientes).
2. **Notación de Dornbusch** (D-2): $k$, $h$, ψ, ν, $\bar a$, θ local (coherente con el 3.A.35) en lugar de φ, λ, π, δ, $u$ de Dornbusch (1976). Aplicada: la del canon. Además, a petición del coordinador y para que coincida con el gráfico de fases, la demanda lleva el término $-b\,i$ también en el cuerpo (II.1.2).
3. **Notación de Branson** (D-3): pesos $w_{\mathrm M}$, $w_{\mathrm B}$, $w_{\mathrm B^*}$ (los de la cartera de Tobin del 3.A.35) en lugar de $m$, $b$, $f$ o $s$. Aplicada: $w$.
4. **Peso de los no comerciables en B-S**: $\omega_N$ (coherencia) frente a $\alpha$ (contenido). Aplicada: $\omega_N$.
5. **Fichas nuevas** (D-4): `ppa`, `balassa-samuelson`, `enfoque-monetario-tc` (o una sola `enfoque-monetario` con 2 variantes) y `oferta-demanda-divisas` (referencia en el 3.B.13 o aquí). Recomendado: las 4, con `oferta-demanda-divisas` en el 3.B.13. Lo decide Víctor al aplicar el canon.
6. **Refranes** (D-5): enganche e idea final «El hombre propone y Dios dispone» (en lugar de «El tiempo pone a cada uno en su sitio» de C5); frases para recordar «dar tiempo al tiempo» (PPA), «las prisas no son buenas consejeras» (sobrerreacción), «cada día trae su afán» (paseo aleatorio). Ninguno usado en otro tema. **Respuesta de Víctor (12/11/2026):** enganche y frases para recordar aprobados (dos se quitan el 13/11/2026: duda 19).
7. **III.2.3 nuevo** (D-6): Gabaix y Maggiori e Itskhoki y Mukhin (1′30″ de cante) a costa de recortar Corsetti-Pesenti a mención. Aplicado.
8. **Wolff (1987)** (V18): la extensión de Dornbusch con la PPA solo para los comerciables va sin autor; el Wolff de 1987 que existe trata de predicción.
9. **Edgeworth** (V36): la comparación del reloj parece de «The Theory of International Values» (1894, parte II), no de 1905; va en paráfrasis, sin año ni cita, hasta comprobarla en papel.
10. **Hechos de Mussa** (V19): el «más del 90 %» de variaciones imprevistas no aparece en Mussa (1979) y no se da; la tabla se rehace con Mussa (1979, 1984) y Frankel y Rose (1995).
11. **Taylor, Peel y Sarno (2001)**: se da «con perturbaciones del 1 al 5 %, vida media inferior a 3 años; con las mayores, mucho menor» (Taylor y Taylor, 2004, pág. 146); la horquilla «1-3 años» del original no se pudo comprobar.
12. **BIS: 9,5 o 9,6 billones** (V1): se mantiene 9,5, como el 3.B.13 (Data Portal y Huang, Krohn y Sushko, 2025), aunque la página del BIS titula 9,6 (9,595 en sus tablas).
13. **Índice Big Mac** (V3-V4): el gráfico da la desviación en bruto; la ajustada por el PIB (euro +29 %, renminbi −24 %) va en el texto de la caja. ¿Basta así o se añade una segunda serie al gráfico?
14. **GEM del FMI**: resuelta (11/11/2026). `Bayoumi2004GEM` comprobada en Crossref: título correcto, ocho autores (Bayoumi, Faruqee, Laxton, Karam, Rebucci, Lee, Hunt y Tchakarov), Washington D. C., DOI 10.5089/9781589063754.084.
15. **Línea desbordada** (6 pt, l. 145 del `.tex`, `eq:vaciado`, parte 1): no impide compilar; acortar si molesta.
16. **Control de calidad (11/11/2026)**: correcciones devueltas al editor y a `tema-tikz` (página de Frankel, 1979, impresa como «sin confirmar»; `Bayoumi2004GEM` comprobada en Crossref, DOI 10.5089/9781589063754.084, falta añadirlo; ecuaciones 12-15 pegadas en el HTML; rótulos de `dornbusch-fases`). Nada que decidir aparte de las dudas 1-13.
17. **Correcciones aplicadas tras el control de calidad (11/11/2026)**: Frankel (1979), págs. 610-622 (RePEc), sin la nota «sin confirmar»; `Bayoumi2004GEM` con DOI, autores y lugar; las ecuaciones \eqref{eq:dornbusch-pnci}-\eqref{eq:dornbusch-precios} con `\qquad\text{…}` en vez de `&& \text{…}` (salían pegadas al texto en el HTML; no hay otro `align` numerado con `&&`); Frenkel (1976) y Mussa (1976) con la paginación de la revista y la reimpresión de 1977 sin páginas (en `addendum`); Blaug (1992) con «1.ª ed., 1980» como `addendum` (salía «2.ª ed. 1.ª ed., 1980»); Rogoff (2002) con `issue = {Special Issue}`; Corsetti y Pesenti pasan a la versión publicada (2009), como en el 3.A.37; en I.4 el subíndice de $\beta_K$ se justifica por los coeficientes $\beta$ de la regresión \eqref{eq:flujos-e}, no por el descuento; la caja de notación ya no se parte (`unbreakable`) y el desborde de 6 pt de la l. 145 (que no era \eqref{eq:vaciado}, sino la fórmula en línea $XN_t(\dots)=SK_t(\dots)$ del párrafo siguiente) se quita permitiendo el corte tras las comas. Al moverse la paginación, la función clave \eqref{eq:balassa-samuelson} quedaba al pie de la pág. 10 (verificar-tema.py lo tomaba por un título): un `\Needspace` la lleva a la página siguiente con su viñeta. Reconstruido: 0 errores en verificar-tema.py.

18. **Anexo de test** (13/11/2026): tenía una lista útil de las preguntas oficiales por apartado. Opciones: (a) mantener la lista y cerrar con la caja estándar; (b) dejar solo la caja estándar. **Aplicada: (a)**, para no quitar contenido. `verificar-tema.py` avisa de «cifras sin cita» en esa lista (son fechas de exámenes, no datos).
19. **Dichos aprobados el 12/11/2026 frente a la regla restrictiva del 13/11/2026**: «las prisas no son buenas consejeras» sugería un mercado que se precipita, cuando la sobrerreacción de Dornbusch es racional (puede dar pie a malentendidos), y «cada día trae su afán» no tiene una relación clara con el paseo aleatorio. Opciones: (a) quitarlos y conservar integrado «dar tiempo al tiempo» (PPA), que casa bien; (b) conservar los 3 integrados; (c) quitar los 3. **Aplicada: (a)**.
20. **Estructura rígida en III.1.2 y III.2** (13/11/2026): la paradoja del margen *forward*, el tipo real de equilibrio, Corsetti-Pesenti y Gabaix-Maggiori/Itskhoki-Mukhin tenían «b) Modelo» sin i)-iii) o sin modelo. Se han repartido sus viñetas en i) Supuestos, ii) Desarrollo, iii) Implicaciones, con frases nuevas breves donde faltaba algo (la idea del margen *forward*, las implicaciones de Corsetti-Pesenti y de β₁ = 1); en el tipo real de equilibrio, los métodos empíricos (FEER, BEER, EBA) pasan a c) Extensiones. Opción alternativa: tratarlos como hechos y no como modelos. **Aplicada: estructura rígida.**

## 8. Instrucciones para el vídeo

- **Enganche e idea final**: tras leer el título, el refrán «El hombre propone y Dios dispone» y la pregunta: ¿qué determina el precio de una moneda, y se puede predecir? Los datos del euro (1,18 en 1999, 0,83 en 2000, 1,60 en 2008, por debajo de 1 en 2022) se dicen, sin escribirlos. La idea final responde: a la larga, los fundamentos; a corto, «el mercado dispone», y sabemos por qué nadie lo predice. Introducción y conclusión sin pizarra (`modo: guion`). Decir en voz alta, al empezar, que el tipo de cambio es siempre el directo ($\uparrow E$ = depreciación).
- **Funciones clave que se conservan en una esquina**: `eq:balassa-samuelson` (desde I.2.2 hasta el III.1.3, donde se vuelve a ella), `eq:monetario` (desde II.1.1 hasta el final de II, porque Dornbusch vuelve a ella a largo plazo y la conclusión la cita) y `eq:sobrerreaccion` (desde II.1.2 hasta el final). Al empezar III, se borra todo salvo las 3.
- **Dichos** (13/11/2026): «dar tiempo al tiempo» junto a la PPA relativa, integrado en la frase; «las prisas no son buenas consejeras» y «cada día trae su afán» se han quitado (duda 19).
- **I (6′30″)**: `oferta-demanda-divisas` mínimo (D, O, $E_0$; tipo fijo de palabra). Las 2 ecuaciones de la PPA a la pizarra; el Big Mac como **apoyo** (gráfico `big-mac`). Balassa-Samuelson **imprescindible**: el esquema de flechas `balassa-samuelson` trazo a trazo y la función clave. `paridades` recomendado (rombo, capa a capa); `eq:pnci` se queda escrita para el II. Mundell-Fleming de palabra.
- **II (12′30″)**: `tab:supuestos-activos` como apoyo, con las celdas en salmón apareciendo según se levanta cada supuesto. II.1.1: la función clave `eq:monetario` y los 3 signos de palabra; `monetario-flexible` como apoyo. II.1.2, **Dornbusch (4′30″)**: las 4 ecuaciones en una columna, el largo plazo en una línea, la función clave `eq:sobrerreaccion`, y después `dornbusch-trayectorias` trazo a trazo (panel por panel, de arriba abajo: $m$, $p$, $i$, $e$; la discontinua de precios flexibles al final, como contraste). `dornbusch-mercados` como apoyo; `dornbusch-fases` no se canta (anexo). II.2, **Branson**: `branson` en versión mínima con $MM$ y $B^*B^*$ (la $BB$ solo como apoyo); los 2 tipos de expansión monetaria (puntos $B$ y $C$) por capas; la tabla `tab:branson` de palabra o como apoyo. II.3: `tab:modelos` en versión mínima (modelo, $\uparrow m$, $\uparrow i$) como apoyo; los hechos de Mussa (los 4 de corto plazo) y las 3 ideas de Meese y Rogoff de palabra.
- **III (7′30″)**: casi todo de palabra; a la pizarra solo:
  - III.1.1 (1′30″): la regla en diferenciales `eq:taylor-tc` en una línea; `paradoja-apreciacion` como apoyo (o, si sobra tiempo, el panel b trazo a trazo: $i$ sube, $E$ cae y vuelve).
  - III.1.2 (1′15″): `eq:fama-tc` con «$\beta_1=1$» tachado y «$\approx-0{,}9$» al lado (instrucción solo para el vídeo); las 3 salidas de palabra.
  - III.1.3 (0′45″): de palabra; `tab:equilibrio-real` como apoyo.
  - III.2.1 (1′): de palabra; $E=\mu/\mu^*$ como apoyo, con el aviso de que μ no es el margen.
  - III.2.2 (1′30″): `eq:evans-lyons` opcional en la pizarra, con «60 % marco, 40 % yen» como apunte.
  - III.2.3 (1′30″): `eq:pnci-prima` en la pizarra, debajo de la `eq:pnci` del I si sigue, para que se vea que lo único nuevo es $\rho_t$; la `ideaclave` como apunte al cerrar el bloque.
- **Gráfico conjunto por partes**: no hay un gráfico de síntesis único; el hilo es la PNCI, que se escribe en el I, sostiene Dornbusch en el II, falla en III.1.2 y vuelve con prima en III.2.3. Conviene mantener `eq:pnci` en la esquina junto a las funciones clave y escribir la prima $\rho_t$ al lado al llegar a III.2.3, sin reescribirla.
- **Al final** la pizarra queda con las 3 funciones clave y la PNCI con prima.

## Respuestas de Víctor (12/11/2026)

- Estructura: se mantienen los bloques del Word (tradicionales, de activos y recientes), con el tipo de cambio real dentro.
- Enganche «El hombre propone y Dios dispone» y frases para recordar aprobados (dos de ellas se quitan en la revisión del 13/11/2026: duda 19).

## Puesta al día con las reglas de esta rama (13/11/2026)

Tema traído de la rama `revision-temario`; adaptado a las reglas de las tandas 4.ª-9.ª y de la revisión transversal sin quitar contenido.

| Regla | Cómo se ha aplicado |
|---|---|
| Citas (5.ª tanda) | Los 100 `\parencite` del texto pasan a `\nocite` (`quitar_citas.py`); queda 1 en el `\fuente{}` del índice Big Mac. Los `\textcite` del cuerpo son obras originales con el autor como sujeto; Gandolfo, Sarno y Taylor y Krugman-Obstfeld-Melitz, solo en fuentes. |
| Plantilla (7.ª tanda) | Anexo «para el test» → «preguntas de test», con la caja estándar (`?tema=3.B.14`) al final (duda 18). Títulos ya cortos o con `\cortetitulo`. |
| Gráfico/Figura/Imagen | `paridades` (cuadro de las 4 paridades, cajas unidas por líneas) pasa a **Figura** (`figu:paridades`); los demás son gráficos (el Big Mac, de datos, sigue en `figuracaja`). |
| Estructura rígida (8.ª tanda) | El IS-LM-BP (I.4), que iba en viñetas sueltas, pasa a a) Idea, b) Modelo (i-iii), c) Valoración; la paradoja del margen *forward*, el tipo real de equilibrio, Corsetti-Pesenti y Gabaix-Maggiori, con sus i)-iii) (duda 20). |
| Etiquetas de dichos | Fuera las 3 etiquetas del cuerpo y la lista de la nota del cante; ver dichos. |
| Inglés entre paréntesis | Añadidos: fijación de precios según el mercado (*pricing to market*), operación de diferencial de tipos (*carry trade*), problema del peso (*peso problem*). |
| Nobel | Notas nuevas: Samuelson (1970), Krugman (2008, ahora nombrado con la fijación de precios según el mercado), Mundell (1999), Meade (1977), Tobin (1981), Fama (2013) y Woodford (2026, con una frase nueva en la NOEM: el modelo neokeynesiano de *Interest and Prices*, 2003, como su base). Entradas copiadas al `.bib`. |
| 4.º ejercicio | `\vertema{4.A.22}` (competitividad, en la valoración de Balassa-Samuelson) y `\vertema{4.A.21}` (posición exterior de España, en la evidencia del EBA). |
| Identidad frente a teoría cuantitativa | Reescrita la nota del precedente del modelo monetario: $MV\equiv PY$ es una identidad (Hume) y Fisher la convierte en teoría cuantitativa con supuestos causales. |
| Dichos | Se conservan el refrán del enganche y de la idea final y «dar tiempo al tiempo», integrado; se quitan 2 (duda 19). Ninguno venía del temario antiguo. |
| NEK en (x,π), pizarra, nombres en ejemplos | No aplica. |
| Ficha de repaso | El tema no tiene ficha (`repaso/` no existe). |

Compilación: `construir-tema.py 3B14 --solo pdf --no-publicar` correcto (37 páginas de tema, 7 de anexos, 7 de bibliografía; 30 minutos). `verificar-tema.py 3B14`: solo los errores esperables de PDF/HTML/Word publicados anteriores a la fuente y los avisos de la lista de exámenes del anexo de test.
