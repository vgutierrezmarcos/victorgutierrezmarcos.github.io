# Revisión del tema 3.B.13 (8/11/2026)

*Mercados de divisas: operaciones e instrumentos.* Sesión personal, sin fase canon: lo del canon va en `_trabajo/canon-pendiente.md`. Base:

- el Word de Víctor (`original.md`, 10/08/2024) y `pendientes.md` (P1-P53);
- las propuestas de contenido (C1-C46 y C40bis), de datos (V1-V29 y L1-L16) y de coherencia (K1-K32);
- `decisiones-coordinador.md`, que manda cuando las propuestas chocan.

## Resumen

- **Estructura**: tema reescrito en LaTeX con la estructura del Word y sus 3 apartados: I, caracterización; II, instrumentos y operaciones; III, eficiencia. El antiguo «1.0» pasa a I.1.
- **Minutos**: introducción 2′30″, I 9′, II 12′30″, III 5′ y conclusión 1′, que suman 30′. Las funciones clave son la PCI `eq:pci`, la PNCI `eq:pnci`, el tipo real `eq:tipo-real` y la regresión de Fama `eq:fama`.
- **Modelo de referencia**: las paridades de intereses, con la estructura de modelo a)-e).
  - La PCI tiene sus supuestos propios, la suma de logaritmos y el signo del ajuste corregido; el margen a plazo ya no se presenta como depreciación esperada, y se añaden las desviaciones desde 2008.
  - La PNCI ya no repite la PCI ni dice que el arbitraje la garantiza.
  - El contraste es una hipótesis conjunta, con la depreciación observada y la condición de Fama, que va al anexo C.
- **Huecos del título cubiertos**:
  - en I.3, la liquidación con el riesgo de Herstatt, CLS y el pago contra pago, y el Código Global de Conducta;
  - en II.1, los NDF y los futuros;
  - en II.2, la especulación a plazo, el *carry trade*, las 4 formas de cobertura y la intervención;
  - en II, las tablas de instrumentos y de operaciones.
- **Datos**: todos de la Encuesta Trienal definitiva de 2025: 9,5 billones de dólares diarios, +27 %.
- **Lo que se lleva a anexos**:
  - el bloque de alta frecuencia, que hablaba de bolsa, va resumido y neutral al anexo B;
  - Kallianiotis y Mishkin, al anexo A;
  - De Grauwe y Grimaldi, al anexo D.
- **Anexo 2 de contango**: se quita y queda una mención con `\vertema{3.B.25}`.
- **Enganche**: «quien no arriesga, no gana», la frase de Volcker sin comillas, abril de 2025 y una pregunta. Ejemplo conductor: una almazara de Jaén que cobra 1 millón de dólares a 3 meses.
- **Anexos**: A, flujos y activos; B, alta frecuencia; C, la prima de riesgo de Fama; D, De Grauwe y Grimaldi; E, test. K preveía A-D: se añade el C para la derivación de la pendiente, que no se canta (CRITERIOS §2).
- **Comprobaciones**:
  - Construido con `construir-tema.py` (8/11/2026), con los 10 gráficos pedidos: 48 páginas (tema 36, anexos 5 y bibliografía 7).
  - `verificar-tema.py`: 0 errores (0 remisiones a mano, 0 fórmulas separadas, 0 apellidos sin `\autor`, minutos = 30 y 3 apartados).
  - Tras las correcciones de calidad de este informe se ha vuelto a compilar la fuente en una carpeta temporal, sin errores ni avisos; la reconstrucción final la hace el coordinador.

## Errores corregidos

| Dónde (Word) | Decía | Dice ahora |
|---|---|---|
| PCI, supuestos (l. 889-895) | movilidad, sustituibilidad perfecta, neutralidad al riesgo y expectativas no sesgadas | PCI: movilidad, mismo riesgo de impago y sin costes; la neutralidad y las expectativas homogéneas son solo de la PNCI (C1, K10.1) |
| Nota 35 | $\ln(1+i)=\ln(1+i^*)\cdot\ln(\dots)$ | **suma** de logaritmos; relación exacta $(F-E)/E=(i-i^*)/(1+i^*)$ (C1) |
| PCI (l. 931) | margen *forward* rotulado también «tasa de depreciación esperada» | «margen a plazo»: un precio, no una previsión; coincide con la depreciación esperada solo si además se cumple la PNCI (K10.2) |
| PCI, ajuste (l. 944) | $(1+\uparrow i)>(1+\downarrow i^*)\,f/\uparrow s$ en el segundo caso, sin mover el *forward* | signo «<» y ajuste de $i$, $i^*$, $E$ y $F$ en los 2 casos (K10.3, C1) |
| Especulación (l. 1028-1072) | bloque de la PCI repetido, numeración 1-3 / 1-4 rota, igualdad con $s_{t+1}$ como «ausencia de arbitraje» y «el arbitraje garantiza el cumplimiento continuo de la PDI» | PNCI partiendo del mismo inversor sin cubrirse; no es condición de arbitraje y falla en los datos (C2, K10.4-5) |
| Nota 34 | repetía la PNCI | se quita (K10.16) |
| Tipo efectivo (l. 228) | «media geométrica», pero con la fórmula aritmética $\sum\alpha_iE_i$; $\varkappa$ | $E^{ef}=\prod E_i^{\omega_i}$; $q=EP^*/P$ y $q^{ef}$ geométrico; aviso de que el BCE publica en la convención contraria (C3, V17) |
| *Bid/ask* (l. 194) | «la transacción se cerrará cuando *bid* y *ask* se igualen» | con creadores de mercado se opera al *bid* o al *ask*; el *spread* es lo que cobra el *dealer*; el cruce de órdenes solo en los libros de órdenes (C4) |
| *Pip* | «*Price Increment Point*» | convención del decimal; el acrónimo no está fijado (nota) (C5) |
| *Majors* | incluía el renminbi | sin el CNY, con la explicación (CNY/CNH) (C5) |
| Divisa (marca roja) | incluye billetes y monedas | sentido amplio y estricto; moneda de libre uso del FMI y cesta del DEG (C6) |
| Oferta de divisas (l. 674) | «aumentan las exportaciones… y, por lo tanto, **disminuye la demanda**» | **aumenta la oferta**; matiz de la elasticidad y Marshall-Lerner (C7) |
| l. 700 | «los movimientos de capitales no tuvieron lugar hasta los años 70» | grandes bajo el patrón oro, hundidos entre guerras y con Bretton Woods (Obstfeld y Taylor, 2004) (C7, K10.14) |
| OTC (l. 338-354) | «Compensación: mediante una cámara de contrapartida» (contradicho más abajo); «no se pueden prohibir ventas en corto»; «Reglamento MiFIR» como norma de compensación | 3 etapas bien definidas; compensación bilateral; compensación obligatoria = EMIR (ninguna clase de divisas); MiFIR = negociación (C8, K10.10, V19) |
| Nota 15 | Dodd-Frank eximió el *spot* y el *forward* | el Tesoro eximió en 2012 los FX *swaps* y los *forwards* con entrega; el contado nunca fue *swap* (V19) |
| Opción (l. 600) | «da a su **vendedor** el derecho» | al **comprador**; el vendedor cobra la prima (C9, P2) |
| Estrategias (l. 610) | «solamente comprar o solamente vender» y la misma proporción en *straps* y *strips* | *strip* = 1 *call* + 2 *puts*, *strap* = 2 + 1; sintéticas por la paridad *put-call* (C9) |
| FX *swaps* (l. 572-576) | «para evitar el riesgo de tipo de cambio»; «tanto en términos absolutos como en términos absolutos» | gestión de liquidez en otra moneda; precio = PCI (C10) |
| *Currency swaps* (l. 590) | ejemplo del FMI | empresas, Tesoros y bancos multilaterales que se financian en una moneda y prestan en otra (C12) |
| Líneas de la Fed (l. 520, 765, 790) | «*Currency swaps*» | líneas *swap* con estructura de FX *swap*, de un día a 3 meses (V12) (P3, C10-C11) |
| Nota 28 | «el tipo repo lo fija un banco central»; «repo = *repossession*» | *repurchase agreement*, tipo de mercado (C11) |
| Liquidez (l. 770-776) | «escasez de dólares en América» mezclando el repo de septiembre de 2019 con marzo de 2020 | marzo de 2020: escasez de dólares fuera de EE. UU., base disparada, líneas el 15 y el 19 de marzo (C11, V13) |
| l. 783 | «el FMI está preparando un nuevo instrumento de DEG» | Línea de Liquidez a Corto Plazo (abril de 2020) y asignación de DEG de 2021 (V14) |
| Bancos custodios | entre proveedores y usuarios de liquidez a la vez | solo entre los proveedores (King, Osler y Rime, 2012) (K10.11) |
| «Fondos soberanos: también menos del 1 %» | sin referente | sector oficial, 1,4 % del volumen (V9) |
| I.4.4 | «La Reserva Federal provee liquidez… mediante *swaps* de divisas» | líneas *swap* con remisión a II.2.2; los bancos centrales operan como clientes (K10.13, C23) |
| Eikon | «plataforma minorista» | es un terminal (hoy LSEG Workspace); plataformas interbancarias y de clientes (C22) |
| Reservas | «[Rodrick]»; «multiplicado por 9»; China «3 billones» | Rodrik (2006); más de 8 veces las de 1997 (COFER); China 3,4 billones (V15-V16) |
| Fama, Nobel | «análisis empírico de precios de posesiones capitales»; hipótesis conjunta con «un modelo de valoración por arbitraje (CAPM o APT)» | «por su análisis empírico de los precios de los activos»; modelo de equilibrio (CAPM) o de arbitraje (APT) (K10.17, C17) |
| III.3 (l. 1184) | «PCI = descuenta la información pública; PDI = la privada» | la PCI es de no arbitraje; la PNCI con expectativas racionales es la eficiencia informativa con neutralidad al riesgo (K10.6, C14) |
| III.2 (l. 1130) | «la PCI se cumple continuamente con mucha precisión», fallos por comisiones | hasta 2007; desde 2008, base persistente por el coste del balance (Du, Tepper y Verdelhan, 2018) (K10.7, C13) |
| Nota 46 | prima sumada a la rentabilidad bruta en niveles: $f=s^e+\delta$ | descomposición en logaritmos $f_t-e_t=\mathbb{E}_t\Delta e_{t+1}+\rho_t$ y condición de Fama (anexo C) (C15) |
| Hodrick (l. 1302) | «Hodrick (1990)», con la depreciación **esperada** a la izquierda; «$\beta_0$ suele ser positivo y alto» | depreciación observada; Hodrick (1987); el matiz de la constante, sin la afirmación empírica (C16) |
| Nota 42 | Roll (1977) con enlaces a la «crítica de Roll» del CAPM | Roll (1979), PPA de mercados eficientes; fuera los enlaces (C17) |
| Grimaldi y De Grauwe | orden de autores; enlace CESifo 1849 | De Grauwe y Grimaldi (2006), Princeton UP; el CESifo 1849 es de De Grauwe y Rovira Kaltwasser (V27) |
| Introducción y I.3 a) | el mismo párrafo (Segunda Guerra Mundial, 7,5 billones) repetido | en la introducción, la cifra del enganche; en I.3 a), el desarrollo (K10.15) |
| Erratas | «a nivel microeconómico como a nivel microeconómico», «merados», «financiaros», «ente», «riegos», «dormán», «desconocía», «Banco Internacional de Pagos» | corregidas; Banco de Pagos Internacionales (BPI) (K10.19, C18) |
| Notas 13, 16, 18, 22, 23, 36 | renminbi repetido, *ranking* de *dealers*, cita de Investopedia sobre Apple, Liberbank, clases de IIC y «2/3 de las operaciones» | fuera (sin fuente, desfasado o de otro tema); de la 18 queda que los *dealers* no cobran comisión aparte (C40, V28) |

## Marcas resueltas

| Marca | Texto original | Qué se hizo |
|---|---|---|
| P1 (anexo 2 y su comentario) | Expectativas, *normal backwardation* y *contango*, en inglés, con la imagen de Bodie, Kane y Marcus | se quita; mención en III.3 d) con `\vertema{3.B.25}` (K18) |
| P5 (amarillo) | «Algunos bancos centrales actúan como *dealers*» | sin fuente: los bancos centrales operan como clientes (sector oficial, 1,4 %) (C23, V9) |
| P6 (amarillo ×13) | bloque de alta frecuencia sobre bolsa, en tono de opinión | en el cuerpo, 4 viñetas neutrales sobre divisas (latencia, *last look*, libra 7/10/2016, yen 3/1/2019 y la diferencia con el franco suizo del 15/1/2015). Al anexo B: ventajas e inconvenientes, *quote stuffing* y *spoofing*, *flash crash* de 2010, MiFID II (arts. 17, 48 y 49, y RD 2017/588), 500 ms, periodo mínimo de tenencia y tasa Tobin (Tobin, 1978; propuestas de la UE de 2011 y 2013; ITF español). Fuera: el *flash crash* alemán de 2014 (no encontrado), «2/3 de las operaciones» (sin fuente) y el tono de campaña |
| P7 (amarillo ×4) | eficiencia de Pareto copiada del 3.B.23 | aplicada a divisas: mercados incompletos y pecado original, externalidades pecuniarias, información asimétrica y *fixings*; Cochrane citado con su obra (2011) (K16, C25) |
| P8 (rojo ×2) | «divisa» | definición fijada (C6) |
| P9 (notas al opositor) | aviso del cambio de temario | desaparece |
| P10 (nota al opositor) | «Es un apartado importante…» | integrada en la nota «En el cante» de I |
| P11 (comentarios) | minutos de la lectura de referencia | sustituidos por el reparto de K (2′30″/9′/12′30″/5′/1′) |
| P12 (comentarios de método) | notas con nombres | no se publican |
| P13 (comentario) | «coordinar con 3.B.12 [Anexo], 3.B.13 y 3.B.14» | oferta y demanda de divisas en II.2.1 con remisiones; Kallianiotis y Mishkin al anexo A (K23) |
| P14 (comentario) | enlace y captura de Kallianiotis (2018) | caja `anotaciones` en III.3 con la versión publicada (`Kallianiotis2018Efficient`) |
| P15 (comentario) | «es parecido en 3.B.13 y 3.B.14» | el 3.B.13 desarrolla y el 3.B.14 resumirá (ver «Coherencia») |
| P16 (cajas de la introducción) | DB Research (roto), Wei (Project Syndicate) y su cita en inglés | fuera DB Research (L1); Wei parafraseado en una caja de I.3 b) (L2) |
| P17 (4 cajas) | teorías del ajuste con tipo fijo | una sola caja con `\vertema{3.B.12}`, sin «en el tema 3.B.12 estudiamos» (C30) |
| P18 (caja) | vídeo de YouTube sobre alta frecuencia | quitado; no se cita (decisión del coordinador) |
| Imágenes 1-6 y nota 14 | capturas | se piden 10 gráficos (ver «Instrucciones para el vídeo»); la imagen 3 de horarios de bolsa se sustituye por las sesiones del mercado de divisas; el logotipo del enganche se quita |
| Fórmulas en imagen (P26) | De Grauwe y Grimaldi | en LaTeX en el anexo D, con $e$ y $e^{\mathrm{fund}}$ |
| Anexo 1 (P27) | tabla de Mishkin en inglés, convención indirecta | `tab:mishkin` en castellano y con la convención **directa** (todas las flechas del tipo de cambio cambian de sentido), en el anexo A |
| Bibliografía y quia (P47-P49) | lectura de referencia, tema de un preparador y quia | bibliografía desde el `.bib`, sin temas de preparadores; enlace único al simulador (anexo E); «Preguntas de otros exámenes», vacío, se quita |

## Datos actualizados

Todos consultados el 8/11/2026 (detalle y URL en `_trabajo/propuestas-datos.md`).

| Dato | Antes | Ahora | Fuente | Segunda comprobación |
|---|---|---|---|---|
| Volumen diario | 7,5 billones de dólares (2022) | **9,5 billones** (abril de 2025), +27 % | BIS, datos definitivos (API `WS_DER_OTC_TOV`) | Huang, Krohn y Sushko, BIS QR, dic. 2025. **No 9,6**: era la cifra preliminar |
| Frente al comercio | 2.737,5 billones al año, ~88 veces | menos de 4 días = comercio de un año (34,65 billones en 2025) | OMC, GTOS, marzo de 2026 | UNCTAD, abril de 2026 |
| PIB de España (nota) | más de 6 veces | unas 5 veces | FMI, WEO, oct. 2026 | Eurostat × tipo del BCE |
| Motivo financiero | 99 % / 1 % (sin fuente) | clientes no financieros 4,6 % (13,4 % en 2010) | BIS | nota del BIS de 30/9/2025 |
| Divisas | USD 88; EUR 30,5; JPY 16,7; GBP 12,9; CNY 7 | USD 89,1; EUR 28,5; JPY 16,9; GBP 10,2; CNY 8,6; EUR/USD 20,7 % | BIS | nota del BIS |
| Plazas | 5 centros > 78 %; Reino Unido 38 % «49 % en 2016» | RU 37,8; EE. UU. 18,6; Singapur 11,8; Hong Kong 7,0; 5 centros 78,7 %; máximo del RU 43,2 % (2019); España 67.900 M$ diarios | BIS; Banco de España | nota del BdE |
| *Interdealer* | 46 % (38 % en 2019) | 46,7 % | BIS | nota del BIS |
| Contrapartidas | tarta de 2022 | otras financieras 48,6 % (23,1 / 13,3 / 8,0 / 1,4); *prime brokerage* 22,7 %; minoristas 2,5 % | BIS | nota del BIS |
| Instrumentos | 28/15/51/2/4 % | contado 31; plazo 18 (NDF 3,5); FX *swaps* 42; *currency swaps* 2; opciones 7 | BIS | BIS QR |
| Liquidación | — | Herstatt 26/6/1974; CLS desde 2002, 18 monedas, más de 75 miembros; en 2025, 36 % PvP y 10 % (1,4 billones) expuesto | CPSS (1996); BIS (2019); Drehmann et al. (2026); CLS | tabla del BIS de junio de 2026 |
| Código Global | — | 25/5/2017, 55 principios, revisiones de 2021 y 2024; multas del 12/11/2014: más de 1.100 M£ (FCA) y más de 1.400 M$ (CFTC) | BIS; GFXC; FCA; CFTC | notas del GFXC |
| Regulación OTC | MiFIR | EMIR (ninguna clase de divisas, ESMA 2015); exención del Tesoro de EE. UU., 16/11/2012 | EUR-Lex; ESMA; Federal Register | coherente con el 3.B.25 |
| Líneas *swap* | sin fechas | 15/3/2020 (5 permanentes abaratadas), 19/3/2020 (9 temporales), ~450.000 M$ a finales de abril | Fed | García-Escudero y Sánchez (2020); Eren, Schrimpf y Sushko (2020) |
| FMI | «nuevo instrumento de DEG» | Línea de Liquidez a Corto Plazo (15/4/2020); asignación de DEG de 2021 (~650.000 M$); cesta del DEG de 2022 | FMI | ficha del DEG |
| Reservas | ×9 desde los 90; China ~3 billones | 13,2 billones (2.º trim. 2026), más de 8 veces las de 1997; USD 56,7 %, EUR 20,6 %, CNY 2,1 %; China 3,41 billones (oct. 2026) | FMI COFER; SAFE | Banco Mundial; prensa |
| Coste de las reservas | «Summers o Rodrick, ~1 %» | Rodrik (2006), ~1 % del PIB; Summers (2006), 1,85 % del PIB de los 10 mayores tenedores de reservas «excesivas» | Rodrik (IEJ); texto archivado de la conferencia de Summers (comprobado en esta fase) | NBER WP 11952 |
| Tipo efectivo del euro | — | TCEN-17 = 98,2 (oct. 2026), −3,6 % interanual | BCE | BIS, `WS_EER` |
| Enganche (abril de 2025) | — | dólar −3,3 % (índice amplio de la Fed); EUR/USD de 1,08 a 1,14 | Fed H.10; BCE | BIS, `WS_EER` |
| *Carry trade* | nota sin cifras | 5/8/2024: Nikkei −12,4 %, yen +12 % desde el 10/7, ~250.000 M$ de posiciones | BIS Bulletin 90; FRED | tipos del BCE |
| Episodios relámpago | *flash crash* de 2010 y alemán de 2014 | libra 7/10/2016 (−9 %), yen 3/1/2019 (+3 % en ~30 s); el de 2010 en el anexo B | BIS MC Papers 9; RBA; SEC-CFTC | nota del BIS |
| China, manipulación | Trump, sin fechas | designada el 5/8/2019 y retirada el 13/1/2020; informe de julio de 2026 | Tesoro de EE. UU. | prensa |
| Euro, energía | 80 % sin fuente | más del 80 % en 2018, COM(2018) 796 | Comisión Europea | — |

**Enlaces** (L1-L16):

- quitados: DB Research, FVP Trade, FOREX.com, Cinco Días, Investopedia, Wikipedia, FT y quia;
- sustituidos: BIS 2022 por los datos de 2025; la página del BCE por la nueva; el PDF de Kallianiotis por su versión publicada;
- el vídeo de WEED no se cita.

## Contenido añadido

- **I.1**: sentido estricto de «divisa»; convertibilidad; moneda de libre uso (art. XXX(f) del Convenio del FMI) y cesta del DEG.
- **I.2**: caja de notación; el par EUR/USD con la almazara; la cotización directa como inversa del par; tipo efectivo nominal y real geométrico; aviso de la convención del BCE.
- **I.3 d)**: 3 etapas; compensación bilateral, EMIR, MiFIR y Dodd-Frank; **liquidación y riesgo de Herstatt, CLS y PvP**, con los datos de 2025.
- **I.3 e)-f)**: plataformas reales; **Código Global de Conducta** con el *last look* y las multas de 2014.
- **I.4**: clasificación de King, Osler y Rime (2012) con los datos de 2025; *prime brokerage*; los bancos centrales como clientes.
- **II.1**: **NDF** (McCauley y Shu, 2016) y **futuros** (Chicago, 1972); usos de cada instrumento con la almazara; `tab:instrumentos`.
- **II.2**:
  - oferta con la elasticidad (Marshall-Lerner) y el patrón oro (Obstfeld y Taylor, 2004);
  - las líneas *swap* contadas como en el 3.B.25;
  - 4 formas de cobertura y la cobertura natural;
  - intervención y esterilización con `\vertema{3.B.15}`;
  - reglas de suficiencia de reservas (Greenspan-Guidotti, métrica del FMI);
  - PCI y PNCI con estructura de modelo, ejemplo numérico (F = 0,8541) y gráfico de los 2 caminos;
  - **especulación a plazo** y ***carry trade*** (Brunnermeier, Nagel y Pedersen, 2009; agosto de 2024);
  - `tab:operaciones`.
- **III**:
  - tabla de los 3 sentidos de la eficiencia aplicada a divisas;
  - Grossman y Stiglitz;
  - Pareto aplicada a divisas (Eichengreen y Hausmann, 1999; Korinek, 2011; Cochrane, 2011);
  - contraste como hipótesis conjunta con estructura de modelo;
  - salidas: prima de riesgo variable (Fama, 1984; Engel, 1996; Lustig y Verdelhan, 2007), *peso problem* (Krasker, 1980; Burnside et al., 2011), encuestas y expectativas heterogéneas (Frankel y Froot, 1987, 1990; Froot y Frankel, 1989) y el matiz de la constante (Hodrick, 1987).
- **Conclusión completa**: relevancia, opinión e idea final, que antes estaban vacías; Dedola et al. (2021) en lugar de Corsetti (2016), que no se ha podido identificar; Draghi (25/1/2018); informes del Tesoro de 2019, 2020 y 2026.
- **Anexo C**: la condición de Fama sobre la pendiente, deducida paso a paso (`\findemo`).
- **Huecos que señalan las preguntas oficiales** (control de calidad, Q2):
  - en I.1, las 3 funciones del mercado de divisas: transferir poder adquisitivo, financiar el comercio a corto plazo y facilitar la cobertura;
  - en II.2.2, una nota sobre los euromercados y los eurodólares;
  - en II.2.3, los 3 tipos de exposición al riesgo de cambio (de transacción, contable y económica), con Williamson (2001, JFE 59(3), 441-475, comprobado en Crossref).
- **Anexo E, para el test**: las 9 preguntas oficiales de `preguntas.json` con el apartado donde se contestan (Q1).
- **Anexo B**: las ventajas e inconvenientes de la alta frecuencia se citan con BIS (2011) y BIS (2020), y el arbitraje por latencia con Budish, Cramton y Shim (2015, QJE 130(4), DOI comprobado). Se recorta lo que no tenía fuente: «funciona mejor en mercados muy líquidos», «para algunos analistas reduce la volatilidad» y el detalle de los bucles entre programas.
- **Summers (2006)**: se mantiene junto a Rodrik (2006), aunque la fase de datos proponía quitarlo. Es una cita del original y en esta fase se ha comprobado en el texto archivado de su conferencia en el Banco de la Reserva de la India: estima el coste de oportunidad de las reservas «excesivas» en el 1,85 % del PIB de los 10 mayores tenedores.
- **Otras correcciones de calidad**:
  - definición de $E^{ef}$ como precio de una cesta de divisas, con $\uparrow E^{ef}$ = depreciación efectiva;
  - por qué se usa la media geométrica;
  - riesgo de las líneas *swap* en la `tab:operaciones`;
  - *currency swaps* 1,7 % y opciones 6,6 %, iguales en la lista y en la tabla;
  - «otras (2,9 %)» para llegar al 48,6 %;
  - sin $\lambda$ en el par;
  - la caja de Wei reescrita y el matiz de Hodrick con «margen a plazo, $f_t-e_t$».
- **Propuestas no aplicadas o aplicadas de otra forma**:
  - C41: su enganche («quien no arriesga, no gana» sin Volcker) se combina con el de K: refrán + Volcker + abril de 2025.
  - C40bis: la tabla de Mishkin no se quita, porque K23 y el coordinador la mantienen en el anexo A.
  - C24 «una cuarta parte del contado en 2011»: no se usa, sin comprobar.
  - V29: no se ponen horas de apertura y cierre semanales.
  - Símbolo de la prima: K y el coordinador piden $\rho$, así que no se usa el $\mathrm{PR}_t$ de C2 y C15.
  - Minutos: los de K (2′30″/9′/12′30″/5′/1′), no los de C.
  - El resto de las propuestas C, V y K se ha aplicado.

## Coherencia

- **Notación del canon** (`notacion.md` § 9):
  - $E$ directo; $F_t^{t+1}$; $e$ y $f$ para los logaritmos; $E^e_{t+1}$ y $\gamma E^e$; $q$, $E^{ef}$, $q^{ef}$ y $\omega_i$;
  - fuera $s_t$, $f_t^{t+1}$ en niveles, $\varkappa$ y $\alpha_i$;
  - PNCI, con PDI como sinónimo; HME y no EMH; Banco de Pagos Internacionales (BPI).
- **Símbolos locales, propuestos al canon** (`_trabajo/canon-pendiente.md`): $E^{\mathrm{bid}}$ y $E^{\mathrm{ask}}$; la prima cambiaria $\rho$; $Z_t$ para las distorsiones de Kallianiotis (en lugar de $\chi$); $e^{\mathrm{fund}}_t$; y $\mu$, $V^k$ y $\phi$ en el anexo D.
- **3.B.25 (revisado)**: misma definición de opción, mismo FX *swap* y mismas líneas *swap* (cifras y claves), misma PCI ($S_0\equiv E_t$), mismo EMIR/Dodd-Frank, mismos futuros de 1972 y el mismo gráfico `ccp`. Ya está corregido en esta rama: dice 9,5 billones de dólares diarios (la cifra definitiva, no la preliminar de 9,6) y no dice «el menor desde 2010» de los FX *swaps* (con los datos definitivos, el peso de 2013 fue más bajo). En los 2 temas: 4 billones, el 42 %.
- **3.B.23 (revisado)**: misma HME, mismas definiciones de Duffie y la misma defensa de Cochrane. Aquí va con su obra (Cochrane, 2011); conviene añadir la cita también en el 3.B.23 (`sec:son-eficientes`). El 3.B.13 usa su término, «exceso de confianza».
- **3.B.14 (sin revisar)**: repite casi literalmente las paridades («la PCI se cumple continuamente»), Kallianiotis, De Grauwe-Grimaldi y el Nobel con «posesiones capitales». Al revisarlo, que resuma y remita a `\vertema{3.B.13}` (referencia de `paridad-intereses`).
- **3.B.12 (sin revisar)**: su anexo copia la oferta de divisas con el error «disminuye la demanda».
- **3.B.15 (sin revisar)**: copia los motivos de acumulación de reservas; aquí se resumen y se remite allí.
- **1D01**: remite al 3.B.13 y es coherente (tipo efectivo geométrico, convención del BCE). No se remite a él porque no tiene destino en `tcee-destinos.tex`.
- **Remisiones nuevas**: 3.A.1, 3.A.10, 3.A.22, 3.A.32, 3.B.11, 3.B.12, 3.B.14, 3.B.15, 3.B.17, 3.B.20, 3.B.21, 3.B.22, 3.B.23, 3.B.24, 3.B.25, 3.B.26, 3.B.27, 3.B.43, 4.A.22 y 4.B.18.
- **Pegatinas del tema**, para añadirlas a CRITERIOS § 8 (`canon-pendiente.md`): «quien no arriesga, no gana» (enganche), «camarón que se duerme, se lo lleva la corriente», «ande yo caliente, y ríase la gente», «lo que no puede ser no puede ser, y además es imposible», «sube por la escalera y baja en ascensor» y «en todas partes cuecen habas».

## Comentarios de Víctor (11/11/2026, 4.ª tanda)

| Comentario | Cómo se ha aplicado |
|---|---|
| Reglas generales del 11/11 (pizarra, títulos) | Quitadas o reescritas 10 indicaciones de pizarra o de caja («se borra», «recuadrada en la esquina», «(caja gris)»…) en el texto del tema, conservando tiempos y orden del cante; su contenido va a «Instrucciones para el vídeo». Títulos largos (PDF actual): anexos A y D: corte tras el punto, con `\cortetitulo`. Sin `c_K` en el tema. |

## Dudas abiertas

El artifact de dudas no está disponible en esta sesión: en cada duda se ha aplicado la opción recomendada.

**Coherencia (D1-D10 de K)**:

- D1. Orden instrumentos-operaciones: se mantiene el del original y se explica en la «Estructura».
- D2. Tema de referencia de De Grauwe y Grimaldi: el 3.B.13, en un anexo (el D).
- D3. Minutos de la eficiencia: 5′.
- D4. Remisión al 1D01: no se remite.
- D5. ¿Dibujar el 3.B.13 también en el bloque «Economía abierta»? Queda para Víctor; no afecta al tema.
- D6. Arbitraje por latencia: 4 viñetas en el cuerpo y el resto en el anexo B.
- D7. Volcker: sin comillas.
- D8. Kallianiotis: en el anexo A, con Mishkin.
- D9. Enganche: abril de 2025 (el *carry trade* de 2024 va en II.2.6).
- D10. Ficha `oferta-demanda-divisas`: referencia en el 3.B.14, propuesto al canon.

**Contenido (D1-D18)**:

- D1. Froot y Thaler, «−0,88 en unos 75 estudios»: parafraseado como «cerca de −0,9», sin comillas.
- D2. Hodrick: se cita el libro de 1987 y el punto se presenta como un matiz, sin la afirmación de que «$\beta_0$ suele ser positivo y alto».
- D3. Sentido estricto de «divisa»: sin cita. ¿Hay una fuente española que lo diga así (Banco de España, Tugores)?
- D4. Metodología del BCE: se cita su página de metodología, no el *Occasional Paper* 134.
- D5. Soros: sin cifras.
- D6. Prima de riesgo: $\rho$ (decisión del coordinador), propuesta al canon.
- D7. Comercio y China: se usan los datos de V2 (OMC 2026: 34,65 billones) y V15 (SAFE: 3,41 billones).
- D8. Nombres de las plataformas (EBS, LSEG FX Matching, LSEG Workspace): se mantienen. Conviene confirmarlos.
- D9. Multas de 2014: la FCA (más de 1.100 M£) y la CFTC (más de 1.400 M$), sin la suma de «4.000 millones».
- D10. `bp-tipo-flexible`: avisado al canon.
- D11. Vídeo de WEED: quitado.
- D12. Tabla de Mishkin: en el anexo A, en castellano y con la convención directa.
- D13. Volcker: se mantiene sin comillas, con «para Paul Volcker…» y la cita del libro. El contenido de la frase está en `VolckerGyohten1992` según las fuentes secundarias; **la página no está comprobada**.
- D14. Corsetti (2016): sustituido por Dedola et al. (2021). ¿Sabe Víctor qué trabajo era?
- D15. Sesiones: elaboración propia, sin horas exactas de apertura y cierre semanales (V29).
- D16. Reglas de De Grauwe y Grimaldi: se usan las formas de las imágenes del original (fundamentalistas con $\psi$, chartistas con una sola variación retardada). Conviene cotejarlas con el capítulo 2 del libro.
- D17. Metadatos del `.bib`: comprobados en Crossref en esta fase (King-Osler-Rime, Gandolfo, Cochrane, Engel, Lustig-Verdelhan, Burnside et al., Froot-Frankel, Korinek, Dedola et al.) y por URL (Greenspan, Borio et al., McCauley-Shu, BIS MC 5 y 13, FSB). Las URL del FMI (Convenio, *Assessing Reserve Adequacy*) devuelven 403 a robots; existen en Wayback.
- D18. Orden del título: igual que D1 de coherencia.

**Del editor**:

- E1. Gandolfo, págs. 15-18 (nota del arbitraje triangular): se supone la edición de Springer de 2002, cuyo capítulo 2 (págs. 7-30) trata el mercado de divisas. ¿Era esa edición?
- E2. Anexo B, «500 ms» (propuesta del Parlamento Europeo de 2012): solo hay fuentes de prensa especializada. Se mantiene sin cita. ¿Se quita?
- E3. Anexo B, *flash crash* de 2010: se cita el informe CFTC-SEC, que no se pudo abrir (403); las cifras (casi 1.000 puntos, ~9 %) son las habituales.
- E4. FX *swaps*: resuelto. Ni el 3.B.13 ni el 3.B.25 dicen ya «el menor desde…»; los 2 temas dan 4 billones y el 42 % (ver «Coherencia»).
- E5. Anexo C nuevo (prima de riesgo de Fama) añadido a los 4 previstos por K: ¿de acuerdo?

**Del control de calidad (8/11/2026)**:

- Q1 (aplicado: anexo E con las 9 preguntas). Anexo de test: CRITERIOS §2 pide «un único enlace genérico al simulador», pero el 3.B.25 y el 3.B.23 ya revisados listan las preguntas oficiales con el apartado donde se contestan. Se pide al editor completar el anexo E como el 3.B.25 (hay 9 preguntas oficiales del 3.B.13 en `preguntas.json`). ¿Se actualiza CRITERIOS §2 para que diga eso?
- **Para Víctor (sin cambiar aún):** ¿se actualiza CRITERIOS §2 para que el anexo de test liste las preguntas oficiales con el apartado donde se contestan (como el 3.B.13, el 3.B.23 y el 3.B.25), en lugar de un único enlace genérico al simulador? Recomendada: sí.
- Q2 (aplicado: mención en II.2.2 y II.2.3). Dos preguntas oficiales etiquetadas 3.B.13 tratan temas que el tema no cubre: los euromercados (julio de 2021, n.º 40) y la exposición económica al riesgo de cambio de Williamson (2001; el enunciado dice «William») (julio de 2022, n.º 40). Se pide al editor una mención breve de cada una. Si Víctor prefiere tratarlos en otro tema, habría que volver a etiquetar esas preguntas.

## Enlaces del original (9/11/2026)

- **Restaurados**:
  - Cinco Días (2016), «¿Cuál es la mejor hora para ganar dinero en Bolsa?» (pie de una imagen del original): entrada `StumpfArevalo2016Bolsa` del `.bib` citada en el `\fuente` del gráfico de las sesiones. El original lo atribuía a «Trincado, B.»; los autores, según la propia página, son Andrés Stumpf Guirao y Alicia Arévalo.
  - FOREX.com, curso de introducción a los mercados (pie de la imagen de cómo se lee un par): la dirección antigua (`/ie/…/trading-forex/`) ya no aparece; se pone la nueva del mismo curso (`https://www.forex.com/en/trading-academy/courses/introduction-to-financial-markets/forex-trading`), en el `\fuente` del gráfico del par. El sitio no deja comprobarla con un robot (403); la encuentra el buscador.
  - Investopedia, «Market Maker»: en la nota al pie de los creadores de mercado (sin el fragmento `#:~:text`).
  - Vídeo «High Frequency Trading» (WEED, YouTube): nota «Para ver» en el arbitraje por latencia, donde estaba en la caja.
  - *Financial Times* (febrero de 2018) sobre la disputa Draghi-Mnuchin: nota al pie tras `BCE2018Draghi`. El FT no deja leer la página sin suscripción; no se ha podido comprobar el titular, por eso va sin título.
- **Conservados con otra dirección** (ya estaban en el tema): Kallianiotis (versión definitiva del artículo), líneas de liquidez del BCE (`BCE2026LineasLiquidez`), De Grauwe y Rovira (CESifo WP 1849, vía RePEc).
- **Sustituidos por la edición vigente**: la Encuesta Trienal del BPI de 2022 (`rpfx22`, `rpfx22_fx.pdf`) y la del Banco de España de 2019: el tema usa las de 2025, con enlace (`BIS2025Trienal`, `BIS2026TrienalDatos`, `BdE2025EncuestaTablas`).
- **No restaurados**: FVP Trade, «Understanding Forex Quotes» (el dominio ya no responde y no hay dirección nueva); la «noticia» de Deutsche Bank Research (el enlace lleva a la portada; sin título no se puede localizar); Wikipedia e Investopedia sobre la crítica de Roll: hablan de la crítica de Roll (1977) al CAPM, y la nota de este tema es otro resultado de Roll (1979, la PPA y la eficiencia); esos enlaces van en el 3.B.23, donde está la crítica al CAPM.

## Instrucciones para el vídeo

- *Pizarra (sacado del texto del tema el 11/11/2026)*: esquema de los 3 bloques a la izquierda; PCI y PNCI recuadradas en morado arriba a la derecha hasta el final.

- **Sin pizarra**: la introducción y la conclusión. En una esquina: «quien no arriesga, no gana» y «9,5 billones $/día».
  - El enganche abre con el refrán, Volcker (sin comillas), abril de 2025 y la pregunta «¿deja ganar sin arriesgar, o al menos adivina el tipo de cambio de mañana?».
  - La idea final la responde: «quien no arriesga, no gana… eficiente para no ser explotado, no para predecir».
- **Rejilla**: a la izquierda, el esquema I-II-III, que se queda todo el tema. Esquina superior derecha, desde II.2.5: la PCI \eqref{eq:pci} y debajo la PNCI \eqref{eq:pnci}, recuadradas en morado (`conservar`); en III se añade la regresión de Fama \eqref{eq:fama}. El tipo real \eqref{eq:tipo-real} se queda solo durante I.
- **I (9′)**, en pizarra:
  - `par-divisas` a mano, con la cotización de la almazara;
  - el recuadro de $q$ y $E^{ef}$;
  - un mini esquema de Herstatt (2 flechas con desfase horario y CLS en medio);
  - `estructura-mercado` simplificado.

  Como apoyo (no se escriben): `divisas-bis`, `sesiones`, `contrapartidas-bis` y la nota `ccp`.
- **II (12′30″)**:
  - la tabla de instrumentos en versión mínima (instrumento, qué se intercambia, para qué), con lo que haría la almazara;
  - `oferta-demanda-divisas` trazo a trazo: ejes, D, O, $E^*$, $\bar E$ y el exceso de oferta con $\Delta R>0$;
  - `dos-caminos` como **gráfico conjunto por partes**: primero el camino nacional y el extranjero cubierto (PCI, con el número 0,8541 de la almazara); en la especulación se añade la rama sin cubrir sobre el mismo gráfico (PNCI), sin redibujarlo.

  Apoyo: `instrumentos-bis` y la tabla de operaciones. Pegatinas: «camarón que se duerme…» (24 horas y latencia), «ande yo caliente…» (cobertura), «lo que no puede ser…» (PCI) y «sube por la escalera y baja en ascensor» (*carry trade*).
- **III (5′)**: se borra el centro y quedan las paridades.
  - La tabla de los 3 sentidos: primero 3 columnas; la última («¿se cumple?») se rellena en III.2.
  - `paradoja-forward`: primero la recta de 45°, luego la nube y la recta estimada negativa, con «en todas partes cuecen habas».
  - Las salidas, de palabra. La descomposición \eqref{eq:descomposicion-fama} como apoyo; el anexo C no va al vídeo.
  - Cierre del bloque con la almazara: 0,8541 es un precio exacto, no una previsión.
- **Funciones clave que se conservan**: PCI, PNCI y Fama. La pizarra acaba limpia, con las 3 ecuaciones y el gráfico de la paradoja.
- **Gráficos pedidos** (`_trabajo/graficos-pedidos.json`, 10):
  - parte 1: `par-divisas`, `divisas-bis`, `sesiones`, `ccp` (copia del 3.B.25), `estructura-mercado`, `contrapartidas-bis`, `instrumentos-bis`, `oferta-demanda-divisas` y `dos-caminos`;
  - parte 2: `paradoja-forward`, ilustrativo.
