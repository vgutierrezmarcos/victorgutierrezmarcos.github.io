# Revisión del tema 3.B.25 (8/11/2026)

*Análisis de los instrumentos y de los mercados de derivados.* Sesión personal (sin fase canon; lo del canon va en `_trabajo/canon-pendiente.md`). Base: Word de Víctor (`original.md`), `pendientes.md` (P1-P78), propuestas de contenido (C1-C62), de datos (V1-V26, L1-L17) y de coherencia (K1-K37), y `decisiones-coordinador.md`, que manda cuando chocan.

## Resumen

- Tema reescrito en LaTeX con la estructura del Word y 3 apartados: I futuros y *forwards*, II opciones y III *swaps*. Cada bloque sigue el mismo guion: definición, tipos, pago, estrategias y valoración. El «apartado 0» pasa a la introducción, a I.2 y a III.6.
- Para cubrir la mitad «mercados» del título, que el Word apenas trataba, hay un subapartado nuevo, **III.6 «Los mercados de derivados: tamaño, participantes, regulación y estabilidad»**, con 2 gráficos de datos (BIS 1998-2025 y FIA 2025).
- Minutos: 2′30″ + 7′ + 11′30″ + 8′ + 1′ = 30′. Funciones clave: `eq:spot-forward` $F_0=S_0e^{rT}$, `eq:put-call` y `eq:black-scholes`.
- Corregido el núcleo teórico:
  - comprador y vendedor estaban confundidos en las definiciones;
  - el pago del futuro estaba mal planteado;
  - la paridad *spot-forward* tenía el signo cambiado y le faltaba $T$;
  - el binomial no usaba la réplica y daba $c=9$ en vez de 9,09;
  - Black-Scholes tenía una integral mal escrita y una lectura errónea de $N(d)$;
  - se atribuía la muerte a Scholes, cuando fue Black.
- Seis anexos: A, valoración neutral al riesgo con Girsanov desarrollado; B, cámaras; C, contango completo (tema de referencia); D, estrategias; E, griegas; F, test.
- Gráficos: 15 en TikZ y pgfplots en lugar de las capturas. Enganche nuevo: «cubrirse las espaldas» y el WTI a −37,63 $ del 20/4/2020.

## Errores corregidos

| Dónde (Word) | Decía | Dice ahora |
|---|---|---|
| Definición de futuros (L264) | dan «a su **vendedor** la obligación de comprar» … «a un precio de ejercicio» | obligan al comprador (largo) a comprar y al vendedor (corto) a vender, a un precio a plazo $F_0$; un futuro no tiene precio de ejercicio (C10, K14) |
| Definición de opción (L488) | «da a su **vendedor** el derecho» | al **comprador**, que paga la prima (C20) |
| Pago del futuro (L330-336) | el largo tiene ganancias «limitadas ya que el precio no puede bajar de cero»; $S_T-P_{\text{ejercicio}}$ | lo limitado es su **pérdida** (como mucho $F_0$); el corto tiene la pérdida ilimitada; $S_T-F_0$ y $F_0-S_T$ (C13) |
| Paridad *spot-forward* (L379-414) | $F_0=S_0-$ coste neto financiero; $F_0=(S_0-I)e^{r_F}$ sin $T$ | $F_0=S_0e^{rT}$ por *cash and carry*; $(S_0-I)e^{rT}$, $S_0e^{(r-q)T}$ y $S_0e^{(r+u-y)T}$ (C15, K17) |
| Binomial (L912-938) | $C_0=\mathbb{E}[C_1](1-r_f)=9$, con las probabilidades «reales» del 66,67 % | réplica con $\Delta=1/3$ y $B=24{,}24$; $c=(2/3\cdot15)/1{,}1\approx9{,}09$; el 2/3 es la probabilidad **neutral al riesgo** $\pi$, no la real (C28, K23) |
| Black-Scholes (L976-988) | «ecuación diferencial» que era una integral con la densidad real $g(S_T)$ y $Xe^{-rT}$ dentro del máximo; $N(d)$ como «la probabilidad de ejercer» | EDP de Black-Scholes y $c=e^{-rT}\mathbb{E}^{\mathbb{Q}}[\max(S_T-K,0)]$; $N(d_2)=\mathbb{Q}(S_T>K)$ y $N(d_1)=\Delta$ (C29); la integral resuelta, en el anexo A |
| Nota 27 | «**Scholes** habría fallecido en 1995» | murió Fischer **Black** (V14) |
| Nota 26 | «Fisher Black» | Fischer Black |
| Tabla de la paridad *put-call* (L806-816) | la *protective put* aparecía como «comprar futuros + comprar *put*» | acción + *put* (C25, P33) |
| Paridad *put-call* (L821) | «a mismo valor esperado a vencimiento, el coste debe ser el mismo» | lo que se iguala es el pago en **cada estado** (C25) |
| Valor temporal (L848) | en los dividendos, «el **tipo de interés** afectará en sentido contrario» | los **dividendos** afectan como una bajada del subyacente (C26, P54) |
| Tablas de determinantes | *call* europea con «+» incondicional en el plazo | «?» con nota: sin dividendos, +; con dividendos grandes, puede bajar (Hull, tabla 11.1) (C27) |
| Nota 23 | «las probabilidades están a favor del vendedor» | la probabilidad de ganar no es el valor esperado; sin arbitraje, ninguna posición tiene valor positivo con $\mathbb{Q}$ (C22) |
| Estrategias complejas (L688) | «solamente comprar o solamente vender» | combinaciones: *calls* y *puts* compradas o vendidas a la vez (C23, P61) |
| *Bear spread* (L706-720) | la *call* comprada aporta «ingresos (menores) de la prima» | es la que se paga; se cobra la prima neta (anexo D, C23); letras a), d), e) → texto sin letras |
| Digitales (L544) | pagan si $S>K$ | *call* digital si $S_T>K$; *put* digital si $S_T<K$ (C21) |
| Apartado 0 (L194) | los derivados son «instrumentos fuera de balance» | desde la NIC 39 y hoy la NIIF 9, están en balance a valor razonable; el nominal solo va en la memoria (C7) |
| Nota 9 / L198 | en la balanza de pagos se registran «como VNA y VNP» | en la cuenta financiera, en términos netos (MBP6, cap. 6), como en el 3.B.11 |
| FRA (L314-322, nota 17) | A paga LIBOR + 2 % y B el 3 % (es un *swap* de un periodo); el comprador «pide prestado dinero» | *forward* sobre un tipo de interés, sin préstamo: se liquida la diferencia descontada, `eq:fra`; Euríbor/€STR (C12, P3, P41, P65) |
| L186 | «valor del dólar con respecto al dólar» | el euro frente al dólar (P56) |
| *Stock swap* (L1214) | rendimiento total contra interés **fijo** | contra tipo **variable** más un diferencial (C34) |
| FX *swap* / *currency swap* (L1216-1228) | las 2 definiciones con la misma frase | el FX *swap* no tiene pagos intermedios; el *currency swap* intercambia intereses periódicos (C34, K26) |
| IRS (L1210) | la contraparte «esperaría pagar un tipo variable menor» | la contraparte quiere fijar su coste (o espera subidas) (C35) |
| Valoración de *swaps* (L1283) | «sucesión de contratos de **futuros**» | de *forwards* (FRA) (C40, P60) |
| Nota 19 | la PCI «se cumple continuamente con mucha precisión» | se cumplía casi exactamente hasta 2008; desde entonces, desviaciones persistentes (Du, Tepper y Verdelhan, 2018) (C17) |
| Historia y datos | siglo XVI en Inglaterra; CME «en 1970»; opciones en España «desde 1980»; tulipanes hundidos por «malas cosechas»; Buffett «en relación con la crisis de 2008»; ITF para «reducir el uso especulativo de los derivados»; RD 1814/1991 vigente | ver «Datos actualizados» (V6-V15) |

## Marcas resueltas

| Marca | Texto original | Qué se hizo |
|---|---|---|
| P1 (amarillo, fuente vacía de la Imagen 1) | «Fuente: …» de una imagen de Rankia | gráfico `pago-futuro` en TikZ, con fuente en Hull (2022), cap. 1 |
| P2 (amarillo, L1232-1248) | notas de clase sobre las líneas *swap* de la Fed (UBS vía JP Morgan, repo, Brasil y México apreciados) | caja `anotaciones` en III.2 redactada de nuevo con la nota de la Fed (19/3/2020), García-Escudero y Sánchez Pérez (2020) y Eren, Schrimpf y Sushko (2020); fuera el ejemplo de UBS/JP Morgan y la apreciación del real y del peso, que no tienen fuente (V20) |
| P3 (amarillo, nota 17, FRA) | «el comprador pide prestado…» | FRA explicado sin préstamo, con la fórmula `eq:fra` (Hull, cap. 4) |
| P4 (amarillo, nota 18) | $R_t=F/S_0\neq1+r_F$ ⇒ arbitraje | integrado como nota del *cash and carry*: $F_0/S_0=e^{rT}$, con la operación inversa |
| P5 (rojo, signos de las tablas) | 7 «➖» en rojo | los signos estaban bien; tabla única `tab:determinantes`, con los signos en verde y rojo y la columna de la griega |
| P6 (rojo, nota 1) | «esperanza» y «riesgo» | era énfasis; la definición de inversión la da el 3.B.23 y aquí no se repite (la introducción va directa a los derivados) |
| P7 (notas al opositor, cambio de temario e imagen de equivalencias) | — | eliminadas (notas de trabajo) |
| P8 («Apartado cero, contar brevemente») | — | aplicado: el 0 va a la contextualización de la introducción, a I.2 y a III.6 (K2, D3 de K) |
| P9 («Pago del *swap* a vencimiento: No aplica») | — | III.3 se titula «Pagos del *swap*» y explica que hay un pago por fecha, el de un FRA (D4 de K) |
| P10 («valorar como sucesión de futuros con la ETTI») | — | III.5 desarrollado: diferencia de bonos, tipo *swap* con la ETTI `eq:tipo-swap` y cartera de FRA |
| P11, P12, P14, P16 (comentarios de clase: Juan Luis, Juan Carlos, Ángel, «Está muy bien», minutos de grabaciones) | — | no se publican. Se aprovecha la idea: notas al opositor sobre cómo cantar la paridad *put-call* y el binomial «de palabra»; reparto de minutos con énfasis en la valoración |
| P13 (comentarios: *swaps* tras futuros) | — | se mantiene el orden del Word (CRITERIOS); el III abre con «un *swap* es una cartera de *forwards*» (D1 de K) |
| P15 («Coordinar en 3.B.13 [anexo] y 3.B.25») | — | este tema es la referencia (anexo C); se anota en «Coherencia» para el 3.B.13 |
| P17 (9 cajas de enlaces) | — | los 6 vídeos y Wikipedia funcionan y se conservan; el de brokeronline.es redirige a un sitio alemán y se quita; el del BCE pasa a la URL nueva (`BCE2026LineasSwap`) |
| P18 (enlace a quia.com) | — | sustituido por el enlace genérico al simulador (anexo F) |
| P19 («Preguntas de otros exámenes», vacío) | — | anexo F con las 15 preguntas oficiales de `preguntas.json` y el apartado donde se contestan |
| P20-P39 (imágenes y tablas en captura) | Imágenes 1-10, tablas de estrategias, caja de griegas, árbol | rehechas en TikZ y pgfplots (15 gráficos) o en tablas LaTeX; las redundantes se funden (4 capturas de pagos en `pagos-opciones`; 2 tablas de determinantes en una) |
| P40, P42 (esquemas de las ECC del BdE) | 4 capturas de Núñez y Valdeolivas (2019) | `ccp`, `ccp-miembros` y `ccp-cascada` en TikZ; el diagrama de los canales de contagio (p. 101) pasa a texto en el anexo B |
| P43 (ilustración de la tulipomanía, «Emprepedia») | — | quitada: derechos desconocidos; la tulipomanía queda en nota (Garber 1990, Thompson 2007) |
| P44 (2 tablas iguales de ventajas) | — | una sola, `tab:organizados-otc` |
| Nota 4 (etimología de «tulipán») y nota 5 (Wikipedia) | — | quitadas (curiosidad sin fuente; no es una cita) |
| Nota 35 (¿qué es más arriesgado?) | — | quitada; las colas gruesas (Mandelbrot, 1963) lo cuentan con fuente |
| «Velocidad» en la caja de griegas | — | quitada (no está en los manuales de referencia) |

## Datos actualizados

Fecha de consulta: 8/11/2026 en todos los casos.

| Dato | Antes | Ahora | Fuente (clave) | URL | 2.ª comprobación |
|---|---|---|---|---|---|
| Nocional OTC | 95 (2000), 670 (pre-2008), 610 (2021) bn USD | 95,2 (dic. 2000), 672,6 (jun. 2008), **844,6 (dic. 2025)**; valor bruto 22,8; exposición 3,35 | BIS (`BIS2026OTCDerivados`) | https://data.bis.org/topics/OTC_DER | ISDA (2026) |
| Composición OTC | — | tipos 669,5 (79 %), IRS 545,0; divisas 148,7; 78,7 % de los de tipos frente a ECC | BIS | ídem | ISDA (2026), salvo el 78,7 % (solo BIS) |
| CDS | «casi doblan cada año desde 2003» | 6,4 (2004) → 61,2 (dic. 2007) → 11,0 (dic. 2025) bn | BIS | ídem | categoría de crédito del mismo BIS |
| Ranking de bolsas | 2019 (Bloomberg) | 2025: NSE, BSE, B3, CME, ICE…; Eurex 14.º; MEFF 34.º | FIA (`FIA2026ETDQ4`) | https://www.fia.org/sites/default/files/2026-02/Q4%202025%20ETD%20webinar.pdf | NSE (16/7/2026), BME (2026) |
| Volumen mundial | — | 119,29 mm de contratos en 2025 (−42,2 %) | FIA (`FIA2026ETDDic`) | https://www.fia.org/fia/articles/etd-volume-december-2025 | FIA Q4 2025 |
| MEFF | «principal mercado oficial» | 35,05 M de contratos en 2025 (+22,6 %); opciones sobre acciones 16,3 M (+48 %); BME Clearing; grupo SIX; rectora absorbida por BME Markets & Exchanges (1/1/2026) | BME (`BME2026InformeMercado`), CNMV, SIX | ver `.bib` | FIA, p. 76 |
| Marco legal | RD 1814/1991, art. 1 | derogado en 2010; hoy Ley 6/2023, art. 2.1.d), y RD 814/2023, art. 3 | BOE | https://www.boe.es/buscar/act.php?id=BOE-A-2023-7053 | preámbulo del RD 814/2023 |
| Origen en España | 1989 y «1980» | 1989; MEFF mercado oficial en 1992 | BOE (`BOE1992OrdenMEFF`) | ver `.bib` | — (sin fuente para los meses) |
| CME | «se crea en 1970» | fundado en 1898; futuros sobre divisas del IMM en mayo de 1972 | CFTC, Chalupa (1982) | ver `.bib` | 10-K de CME |
| Origen de los futuros | «siglo XVI, Inglaterra» | Dojima (Osaka), 1730; CBOT 1848, reglas formales de 1865 | Schaede (1989), CFTC | ver `.bib` | — |
| Cboe | Chicago 1973, «solo *calls*» | Cboe 1973 (se quita «solo *calls*», no comprobado) | 10-K de Cboe | ver `.bib` | — |
| Buffett | «en relación con la crisis de 2008» | carta del ejercicio 2002 (21/2/2003), p. 15 | `Buffett2003Carta` | https://www.berkshirehathaway.com/letters/2002pdf.pdf | lectura del PDF original |
| Bernanke | frase sin fuente | Bernanke (2018): gravedad por el pánico de la financiación mayorista; Bernanke (2010) para AIG | `Bernanke2018Real`, `Bernanke2010Causes` | ver `.bib` | Brookings |
| ITF | 0,2 %; «reducir la especulación con derivados» | 0,2 % sobre compra de acciones > 1.000 M€; no grava derivados; 339,15 M€ en 2025 (+36,5 %) | BOE, AEAT | ver `.bib` | AEAT, cap. 6 |
| Nobel 1997 | «Scholes habría fallecido» | Black murió en 1995 | `Nobel1997Prensa` | ver `.bib` | Crossref |
| Tulipomanía | «malas cosechas» de 1637 | 1634-1637; Garber y Thompson | `Garber1990Famous`, `Thompson2007Tulipmania` | — | Crossref |
| FX *swaps* | «el más utilizado», sin dato | 4 bn USD diarios, 42 % (abril de 2025) | `BIS2025Trienal`, `HuangKrohnSushko2025FX` | https://www.bis.org/statistics/rpfx25_fx.htm | nota del BIS del 30/9/2025; cifra definitiva del total (9,5 billones) en el BIS Quarterly Review de dic. 2025, comprobada al revisar el 3.B.13 |
| Líneas *swap* de la Fed | amarillo | 19/3/2020, 9 bancos más los 5 permanentes; máximo ≈450.000 M$ a finales de abril | `Fed2020Swaps`, `GarciaEscuderoSanchez2020Swaps` | ver `.bib` | BdE (2020) |
| Regulación OTC | EMIR 2012 y 2019 | G-20 de 2009, EMIR, Refit, 2.2, EMIR 3 (2024/2987), MiFIR, ventas en corto | EUR-Lex, G20 | ver `.bib` | autoridades de Malta y Austria (EMIR 3) |
| LIBOR | ejemplo de referencia | dejó de publicarse (último sintético USD, 30/9/2024): Euríbor/€STR | `FCA2026LIBOR` | ver `.bib` | ICMA (2024) |
| WTI (enganche) | — | −37,63 $/barril el 20/4/2020 | `CFTC2020WTI`, `EIA2026WTI` | ver `.bib` | serie EIA RCLC1 |

**Quitado por no tener fuente**: el 80 % de los CDS al descubierto; el 1-3 % de futuros con entrega; los *warrants* «hasta 15 años»; el primer *swap* IBM–Banco Mundial (1981), que solo tiene fuentes secundarias; la causalidad de los CDS en la quiebra de Lehman; «siglo XVI, Inglaterra». No se usan «unas 7 veces el PIB mundial» ni el máximo del VIBEX, que no tienen doble comprobación.

## Contenido añadido

- **Introducción completa**:
  - enganche nuevo, con dicho, caso real, Buffett y pregunta;
  - relevancia en 3 planos (completar mercados, tamaño y estabilidad, Nobel);
  - contextualización con definición, 3 rasgos, tipos, 3 usos de Hull e historia corregida;
  - problemática y estructura (antes vacías);
  - caja de notación (Hull, D108 del canon).
- **I**:
  - cámara, márgenes, liquidación diaria e interés abierto (C11);
  - riesgo de base y ratio de mínima varianza (C14);
  - la paridad *spot-forward* con la estructura a)-e);
  - expectativas, *normal backwardation* y *contango* redactados de nuevo, con aviso de terminología, relación con el CAPM y evidencia (Gorton y Rouwenhorst; Fama y French; Fama). Este tema es el de referencia de la ficha `expectativas-contango`.
- **II**:
  - tabla de tipos;
  - cono, *bull spread*, *put* protectora, *call* cubierta y seguro de carteras de 1987 (Brady);
  - paridad *put-call* con a)-e), extensiones (dividendos y americanas) y ejemplo de la pregunta de marzo de 2026;
  - cotas;
  - binomial con réplica y paso a Black-Scholes;
  - Black-Scholes con supuestos completos, EDP, medida neutral al riesgo, ejemplo (10,45 y 5,57), volatilidad implícita, VIX y VIBEX, extensiones (Merton, Black 1976, Heston), evidencia (sonrisa de volatilidad, Mandelbrot, MacKenzie y Millo) y LTCM;
  - opciones reales.
- **III**:
  - Fed: caja de las líneas *swap* de la Fed.
  - Derivados de crédito: subapartado propio (CDS con $s\simeq\lambda(1-R)$, índices, CLN, CDO, AIG).
  - Estrategias con *swaps* (vacías en el Word), con la ventaja comparativa y la crítica de Turnbull (1987).
  - Valoración: tipo *swap* con la ETTI.
  - **III.6 nuevo**:
    - tamaño, con el gráfico del BIS y el de la FIA;
    - participantes e infraestructura;
    - mercado español;
    - regulación tras 2008;
    - eficiencia y estabilidad, que es el «análisis» del título.
- **Conclusión** con sus 5 bloques. Relevancia, extensiones y opinión estaban vacías; la idea final responde a la pregunta del enganche.
- **Anexos**:
  - A, teorema fundamental, binomial paso a paso, Itô y EDP, Girsanov y la integral resuelta, con `\findemo`;
  - B, cámaras (texto de Víctor con cascada y canales de contagio);
  - C, contango completo (CAPM y Dusak, presión de cobertura, teoría del almacenamiento de Kaldor y Working, evidencia);
  - D, estrategias y sintéticas;
  - E, griegas con fórmulas;
  - F, test.
- **Bibliografía**: 82 entradas, todas citadas en el texto. Las de datos se copian con sus claves (salvo 5 sin citar que se quitan: `BIS2025OTCCommentary`, `Garber2000Famous`, `FMA2025CuentaActiva`, `ICMA2024LIBOR` y `CNMV2026GuiaOpcionesFuturos`, que eran segundas comprobaciones o alternativas). Se añaden las de C62, MiFIR (`UE2014MiFIR`, de EUR-Lex) y la ley Dodd-Frank (`DoddFrank2010`, Public Law 111-203, en govinfo.gov; congress.gov devuelve 403 a las peticiones automáticas). La Ley 6/2023 y la Ley 5/2020 van como artículo del *Boletín Oficial del Estado* (con número y fecha), como las leyes del 3.B.03. El informe del LTCM lleva la URL comprobada del Tesoro; el de Archegos, sin URL (el enlace del despacho da 404). Bodie, Kane y Marcus pasa a la 12.ª edición. Núñez y Valdeolivas va con las páginas correctas (pp. 75-110). Fuera los 2 temas de preparadores (ICEX-CECO y Juan Luis Cordero), que no son fuente de nada del tema (D13 de C).

### Propuestas aplicadas y rechazadas

- **K1-K37** (coherencia): todas aplicadas, con la opción recomendada en las dudas D1-D8. La caja de notación avisa de las letras locales de Hull, sin $u_s$ ni $y_c$.
- **V1-V26** y **L1-L17** (datos): aplicadas, salvo V16 (IBM–Banco Mundial, sin fuente primaria) y V10 («solo *calls*», no comprobado). Los *swaps* quedan «a principios de los 80» con Hull.
- **C1-C62** (contenido): aplicadas con estos cambios o rechazos.
  - **C2 (minutos)**: rechazada. Se usan los de K y del coordinador (7 / 11,5 / 8 / 1).
  - **C5, C14, C49 (refranes)**: rechazados «curarse en salud» y «quien juega con fuego, se quema», porque ya los usa el 3.A.41. Van los de K: «cubrirse las espaldas», «cada día tiene su afán», «lo que se gana en los columpios se pierde en los tiovivos», «el que paga, manda» y «dos caras de la misma moneda».
  - **C5 (Bernanke en el enganche)**: no se usa ahí; Bernanke va en III.6 (Bernanke, 2018) y en AIG (Bernanke, 2010).
  - **C3, C28 y C50 (notación)**:
    - $\pi$ en lugar de $\pi^{\mathbb{Q}}$ (D7 de K);
    - $q$ para el rendimiento continuo e $y$ para el de conveniencia (K12), en lugar de la $y$ genérica;
    - $\mathbb{E}_0[S_T]$;
    - en los CDS, la intensidad de impago es $\lambda$ para no chocar con $\pi$.
  - **Etiquetas**: van las de K30, no las de contenido (`eq:spot-forward`, `anexo:ccp`, `anexo:valoracion-neutral`, `sec:mercados-derivados`, `tab:put-call`).
  - **C6**: sin «unas 7 veces el PIB mundial», que está pendiente de comprobar (D8 de C).
  - **C7**: sin «solo con *calls* sobre 16 acciones» del Cboe ni el IBM de 1981.
  - **C11**: el RD 814/2023 se cita por su art. 3 (comprobado por datos), no por los arts. 117-119.
  - **C29**: sin el máximo del VIBEX del 9 de abril.
  - **C33, C37, C42**: sin los datos de ISDA que datos no comprobó (índices de CDS 6,4 bn; 85 % de reducción por *netting*; 70 % de CDS frente a ECC).
  - **C36**: la cifra de la Fed es la de datos, ≈450.000 M$ a finales de abril, no 449.000 a finales de mayo.
  - **C43**: sin la novedad de marzo de 2025 en MEFF, que no tiene comprobación.
  - **C44**: sin las prohibiciones de la CNMV de 2011-2013, que no tienen fuente; la de 2020 queda sin días exactos (fuentes solo de prensa).
  - **C52**: los diagramas del BdE no van como imagen, sino en TikZ (miembros y cascada) y en texto (contagio).
  - **C55**: no se pone la nota de inversión ni el contexto del ahorro. El 3.B.23 ya la tiene y K9 la sustituye por la contextualización de los derivados.

## Coherencia

- **Remisiones nuevas**: `\vertema` a 3.A.21, 3.A.34, 3.B.2, 3.B.4, 3.B.22, 3.B.26 y 3.B.27. Se mantienen las de 3.B.11, 3.B.13, 3.B.14, 3.B.23 y 3.B.24, y se quitan las autorreferencias a 3.B.25 (K32, K37).
- **3.B.23**: misma definición de activo financiero; $r$ es el $r_f$ en continua; $\mathbb{E}[\cdot]$ con corchetes; enganche distinto. Su remisión al «interés abierto» tiene destino en I.2.
- **3.B.4, 3.B.2 y 3.A.34**: la fórmula de Black-Scholes tiene la misma forma que el recuadro del 3.B.4. El binomial usa la misma $\pi$ y el mismo árbol que la opción de esperar. La frase «la opción de esperar es una *call* americana sobre el proyecto» coincide con la del 3.A.34.
- **Contradicciones con otros temas** (no se han tocado; para cuando se revisen; detalle en `propuestas-coherencia.md` § 10 y en `_trabajo/canon-pendiente.md`):
  1. **3.B.13**: su anexo 2 copia literalmente el contango del 3.B.25 original, en inglés. Debe quedar en mención con `\vertema{3.B.25}` y `anexo~\ref{anexo:contango}` (D116).
  2. **3.B.13**: llama *currency swaps* a las líneas de la Fed. Aquí se describen con estructura de FX *swap*; hay que usar la misma etiqueta.
  3. **3.B.13**: repite «da a su **vendedor** el derecho» y la clasificación errónea de estrategias.
  4. **3.B.13**: cuota de los FX *swaps* con la Encuesta Trienal de 2022 (51 %). Aquí va la de 2025 (42 %).
  5. **3.B.24**: usa el mismo enganche antiguo (ahorrador y empresa) y data a Hicks en «los 40». Es de 1939.
  6. **3.B.27**: se reparten la regulación. Aquí el qué y el funcionamiento; allí el porqué y la evidencia.
  7. **3.B.11**: mismo registro en la balanza de pagos, en términos netos.
  8. **3.B.14**: su remisión a la «versión general» tiene destino estable, `sec:spot-forward`.
  9. **4.A.18-4.A.20**: remiten con la numeración antigua.
- **Canon**: fichas nuevas propuestas `spot-futuros`, `put-call`, `binomial`, `black-scholes` y, a decidir, `estrategias-opciones`. Cambios en `expectativas-contango` ($\mathbb{E}_0[S_T]$; gráfico de referencia `fuentes/3B25/graficos/contango.tex`). Filas en `capm`, `opciones-reales`, `arrow-debreu-incertidumbre` y `paridad-intereses`. D108 ampliada. Refranes para CRITERIOS § 8. Todo en `_trabajo/canon-pendiente.md`.

## Dudas abiertas

El artifact de dudas no está disponible en esta sesión: van aquí. En todas se ha aplicado la opción recomendada.

- **D1 (K1). Orden de los bloques.**
  - Aplicada (a): futuros → opciones → *swaps*, el orden del Word. El III abre con «un *swap* es una cartera de *forwards*».
  - Alternativa (b): *swaps* en II, como proponían los comentarios de clase. Los minutos no cambian.
- **D2 (K3). Dónde va el análisis de los mercados.**
  - Aplicada (a): el funcionamiento en I.2 y el subapartado nuevo III.6 (3′).
  - Alternativas: (b) en la conclusión, donde no cabe; (c) un I.6.
- **D3 (K2). El apartado 0.**
  - Aplicada (a): a la contextualización de la introducción y a I.2 y III.6.
  - Alternativa (b): una apertura de 30″ del bloque I.
- **D4 (K6). Título del III.3.**
  - Aplicada (a): «Pagos del *swap*».
  - Alternativa (b): mantener «Pago del *swap* a vencimiento» y explicar en una línea por qué no hay un único pago.
- **D5 (K12, K35). Letras de Hull que chocan con el canon.**
  - Aplicada (a): $u$ almacenamiento y $u$ binomial, $y$ conveniencia, $I$ rentas, con aviso en la caja de notación.
  - Alternativa (b): $u_s$ y $y_c$.
- **D6 (K7). Enganche.**
  - Aplicada (a): «cubrirse las espaldas» + WTI a −37,63 $.
  - Alternativa (b): el níquel de la LME (marzo de 2022) o Archegos (2021).
- **D7 (K23). Probabilidad neutral al riesgo.**
  - Aplicada (a): $\pi$, como en el 3.A.34 y el 3.B.2, aclarando que no es la real.
  - Alternativas (b): $q$ (choca con el rendimiento $q$) o $p$ (choca con la *put*). Contenido proponía $\pi^{\mathbb{Q}}$.
- **D8 (K5). Anexos de estrategias y griegas.**
  - Aplicada (a): fuera del cuerpo (anexos D y E).
  - Alternativa (b): dejar la caja de las griegas en II.5, con unas 2 páginas más de cuerpo.
- **D7 de contenido. Ranking de bolsas de 2025.** Se usa el dato anual de la FIA (Q4 2025): NSE primera, confirmada por la nota de la NSE. La B3 superó a la NSE solo en los primeros meses de 2025.
- **D8 de contenido. Segundas comprobaciones pendientes antes de publicar.**
  - El PIB mundial de 2025 (no se usa «7 veces»).
  - Resuelto al revisar el 3.B.13 (8/11/2026): la cifra definitiva del total es 9,5 billones (la preliminar era 9,6); los FX swaps siguen en 4 billones y el 42 %.
  - El máximo de las líneas *swap* de la Fed en la serie SWPT de FRED.
  - Las URL estables de los informes de Archegos, LTCM y Brady.
  - Una cita del BIS, el FSB o la ESMA para la prociclicidad de los márgenes (2020 y 2022) y la concentración de la compensación en la UE.
- **Capítulos de Hull (2022)**: las citas con capítulo de Hull (caps. 1-5, 7, 10-12, 17-19, 22, 25…) vienen de las propuestas de contenido y nadie las ha comprobado en el libro (11.ª ed.). Conviene comprobarlas, o quitar el capítulo donde no cuadre. También la página 15 de la carta de Buffett, aunque esa la comprobó datos en el PDF.
- **Sharpe (1978)**: se mantiene como en el original (manual *Investments*, Prentice-Hall), pero no se ha comprobado la edición.
- **Imagen de la tulipomanía**: quitada por derechos desconocidos. Si se quiere, la acuarela del *Semper Augustus* (dominio público, Wikimedia Commons).
- **Control de calidad (8/11/2026): capítulos de Hull.** Contrastados con el índice de la 11.ª ed. (sin el libro delante), cuadran caps. 1-5, 7, 10-12, 19, 25-26 y la tabla 11.1. Quedan 2 dudosos: la aproximación $s\simeq\lambda(1-R)$ está en el cap. 24 («Credit risk»), no en el 25; y la evidencia de la paridad *put-call* (costes de transacción y venta en corto), citada a Hull, cap. 11, que no parece tratarla. Hay que comprobar los dos en el libro.

## Instrucciones para el vídeo

- **Enganche e idea final**: «Cubrirse las espaldas», el futuro del WTI liquidado a −37,63 $ el 20/4/2020 y la advertencia de Buffett (carta de 2002). Pregunta: «¿sirven los derivados para cubrirse las espaldas o multiplican los riesgos que deberían cubrir?».
  - La idea final la responde: los derivados no crean ni destruyen el riesgo, lo cambian de manos y le ponen precio.
  - Con márgenes, cámaras y transparencia, sirven para cubrirse; sin ellos, lo multiplican.
  - Introducción y conclusión, en `modo: guion`.
- **Esqueleto de la pizarra**: a la izquierda, todo el tema, el guion de 5 pasos que se repite en los 3 bloques (definición, tipos, pago, estrategias y valoración).
- **Funciones clave** (`conservar:`), en la esquina superior derecha. Se recuadran al aparecer y se quedan hasta el final:
  - `eq:spot-forward`, en I.5;
  - `eq:put-call`, en II.5;
  - `eq:black-scholes`, en II.5.
- **Bloque I** (7′):
  - `ccp` pequeño (estrella frente a malla), con «cada día tiene su afán»;
  - `pago-futuro`, largo y corto, con la vuelta al WTI;
  - la paridad, con «lo que se gana en los columpios se pierde en los tiovivos», y debajo solo `eq:coste-mantenimiento`;
  - `contango` por capas (expectativas, *backwardation*, *contango*).
  - Como apoyo: la tabla organizados/OTC, la ratio de cobertura y el FRA.
- **Bloque II** (11′30″):
  - `pagos-opciones` (al menos los 2 compradores), con «el que paga, manda»;
  - los 3 perfiles de `estrategias-opciones` a mano alzada;
  - `paridad-put-call` construido por partes (bono + *call* a la izquierda; acción + *put* a la derecha; las 2 sumas iguales), con «dos caras de la misma moneda» junto a la función clave;
  - la tabla de determinantes en versión mínima;
  - `arbol-binomial` con $\Delta=1/3$, $\pi=2/3$ y $c\approx9{,}09$, contado casi de palabra («la probabilidad real no aparece»);
  - Black-Scholes, solo la función clave; $N(d_2)$, $N(d_1)$, sonrisa y VIX van de palabra o en `apunte`.
  - `valor-call` va como apoyo, solo si cabe.
- **Bloque III** (8′):
  - `irs` (banco y empresa);
  - $V_{\mathrm{swap}}=B_{\mathrm{fl}}-B_{\mathrm{fix}}$ en una línea;
  - III.6 en 3 columnas, «tamaño», «reforma de 2009» y «riesgos», con 2-3 palabras en cada una.
  - Los gráficos de datos (`bis-otc-derivados` y `fia-bolsas-2025`) van solo como `apoyo:`, nunca se dibujan.
- **Gráfico conjunto por partes**: no hay un gráfico único del tema. Lo que se va completando es la columna del guion (con las 3 funciones clave a la derecha). Al final la pizarra queda con el guion y las 3 funciones clave.
- **No se dicen números de tema en voz alta**: las extensiones se nombran por su contenido (opciones reales, estructura temporal de los tipos, crisis de 2008, regulación financiera).
- **Anexos y notas**: son de profundización y no entran en el guion.
