# Revisión del 3.B.35 — Procesos de integración no comunitarios

Revisión completa del 14/11/2026 (entrega 1: tema y ficha de repaso; sin vídeo), en el worktree `revision-temario-2`, en paralelo con los agentes de los 3.B.34 y 3.B.36. Fuente nueva en LaTeX (`3B35.tex`) a partir del Word original (`_trabajo/original.md`, el antiguo 3.B.36, versión de enero de 2023, que a su vez venía casi entero del tema de un preparador), **redactada de nuevo** y puesta al día a noviembre de 2026 con fuentes oficiales (OMC, FMI, Banco Mundial, Consejo y Parlamento Europeo, AELC, CPTPP, ASEAN, ZLECAf, CEDEAO) y prensa especializada cuando no había fuente oficial. Las dudas se resuelven con la opción recomendada y se anotan como B35-NN (14/11/2026).

## 1. Resumen

- Tema completo en 3 bloques: **I. Justificación económica y marco jurídico** (I.1 formas; I.2 por qué se integran; I.3 regionalismo frente a multilateralismo; I.4 marco jurídico), **II. Los procesos no comunitarios** (II.1 Europa y Eurasia; II.2 América; II.3 Asia-Pacífico; II.4 Oriente Medio y norte de África; II.5 África) y **III. Balance y situación actual** (III.1 cuánto integran; III.2 el regionalismo en un mundo fragmentado). Reparto: introducción 2′30″, I 8′, II 13′30″, III 5′, conclusión 1′.
- Se mantienen los bloques I y II del original y sus títulos de segundo nivel (Delimitación; Motivación; Debate ¿peldaño o escollo?; Marco jurídico / Europa, América, Asia-Oceanía, Magreb y Oriente Medio, África). El antiguo bloque III (organismos de cooperación: OCDE, ASEM, Davos, G-20) sale del título y del tema: va al 3.B.19 (decisión D119 del canon), con una caja gris de remisión. En su lugar, **III. Balance y situación actual** (B35-01).
- 2 modelos con la estructura rígida a)-e): **los bloques de Krugman (1991)** (resuelto numéricamente: arancel de Nash y bienestar mundial para σ = 2, 4 y 8; mínimo con 3 bloques) y **la teoría del dominó de Baldwin (1993, 1995)** ($P(n^*)=R(n^*)$, perturbación y telaraña); más el plato de espaguetis de Bhagwati con su evidencia (Limão, 2006; Estevadeordal, Freund y Ornelas, 2008). La teoría de Viner, Cooper-Massell y Kemp-Wan se resume y se remite al 3.B.10, donde está completa.
- 5 gráficos y 2 figuras en TikZ/pgfplots: 3 de datos reales descargados (ACR nuevos y en vigor por año, 1958-2026, de la base RTA-IS de la OMC; comercio intrarregional de 15 bloques en 2000 y 2025, calculado con el IMTS del FMI; PIB y población de los bloques en 2025, Banco Mundial), 2 teóricos (Krugman, dominó), la cronología de las 4 olas y la ZLC frente a la UA (copiada del 3.B.10). 4 tablas (formas con ejemplos fuera de la UE; el plato de espaguetis de Asia-Pacífico; el modelo de Krugman; fichas de 15 bloques).
- PDF: 26 páginas de tema, 2 de anexos, 5 de bibliografía (33). Ficha de repaso de 4 páginas a 9,5 pt (última, 83 %). `verificar-tema.py`, sobre los ficheros de `_trabajo/` (con `--no-publicar` no se copian a `tercer-ejercicio/`): 0 errores de contenido; quedan los avisos de «cifra sin cita» en párrafos cuya cita está en el párrafo anterior o en el gráfico, y los del vídeo (entrega 3).

## 2. Errores corregidos

| Id | Dónde (Word) | Decía | Dice ahora |
|---|---|---|---|
| E1 | Relevancia | «en torno a 420 acuerdos regionales notificados» | 390 ACR notificados y en vigor (416 con las adhesiones), y al menos 84 sin notificar (OMC, octubre de 2026) |
| E2 | Contextualización | Bretton Woods establece el «nuevo orden económico internacional» | Ese nombre es el de la declaración de la ONU de 1974; se quita (el orden de Bretton Woods se resume en el 3.B.33) |
| E3 | Delimitación | El D-8, «formado por 8 países árabes», y las preferencias parciales como «estructura no aceptada por la OMC» | El D-8 es de países de mayoría musulmana (solo Egipto es árabe), y las preferencias entre países en desarrollo están permitidas por la cláusula de habilitación |
| E4 | Delimitación | La unión económica «permitiría la libre movilidad de capitales» | La libre circulación de capitales es propia del mercado común (tabla `tab:formas`) |
| E5 | Delimitación | Mercosur como ejemplo de mercado común; SACU con «Suazilandia» | Mercosur, unión aduanera imperfecta; Suazilandia es Esuatini desde 2018 |
| E6 | Marco jurídico | «Se tienen que cubrir al menos el 90 % de los flujos» | El art. XXIV dice «lo esencial de los intercambios»; el 90 % es la referencia práctica, no una regla |
| E7 | Marco jurídico | Kemp y Wan: «el arancel exterior común tal que se cree comercio y evite la desviación» | Un arancel exterior común que deja igual al resto del mundo y no empeora a ningún miembro |
| E8 | Debate | «Teoría del gigante (*Juggernaut Theory*, Baldwin y Robert-Nicoud): teoría del dominó» | Son 2 teorías distintas: dominó (Baldwin, 1993) y apisonadora (*juggernaut*, Baldwin y Robert-Nicoud, 2015) |
| E9 | Debate | «Efecto bowl de tallarines (*noodle bowl*)» de Bhagwati | Bhagwati habla de *spaghetti bowl*; *noodle bowl* es como se llama en Asia |
| E10 | AELC | Fundada por «Reino Unido (Portugal, Suecia, Dinamarca)» | 7 fundadores: Reino Unido, Austria, Dinamarca, Noruega, Portugal, Suecia y Suiza |
| E11 | AELC | En 1994 «se acuerda la creación de una zona de libre comercio CEE-EFTA. Surge así el EEE» | El EEE extiende el mercado único (no es una ZLC); las ZLC CEE-AELC venían de 1972-1973 |
| E12 | AELC (nota 12) | Referéndums «en 1991» en Austria, Finlandia y Suecia | Fueron en 1994; entraron en la UE en 1995 |
| E13 | AELC | «25 tratados de libre comercio con 36 países» | Unos 30 con unos 40 socios; nuevos con la India (2025) y el Mercosur (2026) |
| E14 | CAN | «En 1995, nace la Comunidad Andina con la entrada de Venezuela» | Venezuela entró en el Pacto Andino en 1973; la CAN se llama así desde 1996 (Protocolo de Trujillo) |
| E15 | CAN | «todos menos Bolivia tienen acuerdos de asociación con la UE» | Colombia, Perú y Ecuador tienen un acuerdo comercial (no de asociación) con la UE |
| E16 | Mercosur | «en 2019 se firma finalmente un tratado de libre comercio con la Unión Europea» | En 2019 hubo un acuerdo político; la firma fue el 17/1/2026 y el acuerdo interino aplica desde el 1/5/2026 |
| E17 | Mercosur | Arancel exterior común «muy elevado (de hasta el 30 %)» | Media en torno al 11 %, con máximos del 35 % (automóviles) |
| E18 | T-MEC | «Este acuerdo se revisará cada 6 años» | Revisión conjunta a los 6 años: si no se confirma (julio de 2026), revisiones anuales y fin en 2036 |
| E19 | T-MEC | México, «segundo socio comercial de EE. UU. (por detrás de Canadá)» | Primer socio comercial de EE. UU. |
| E20 | RCEP | Entró en vigor «después de ser ratificado por todos los Estados miembros» | Entró en vigor en 2022 para los que lo habían ratificado; los últimos (Indonesia, Filipinas), en 2023 |
| E21 | RCEP | «pasa por alto áreas como la agricultura o el comercio electrónico» | Tiene capítulo de comercio electrónico; es superficial en agricultura, servicios, trabajo y medio ambiente |
| E22 | RCEP (nota) | «30 % del PIB mundial y 2.100 millones de consumidores» | 27 % del PIB y 28 % de la población (2.300 millones), Banco Mundial 2025 |
| E23 | CPTPP | El TPP se firma «entre 11 países» | 12, con Estados Unidos |
| E24 | CPTPP | «omite 20 provisiones» | 22 disposiciones suspendidas |
| E25 | APEC | «21 países» | 21 economías (Hong Kong y Taiwán no son Estados) |
| E26 | UEMOA | «14 países [...] con la excepción de Guinea Ecuatorial y Guinea Bissau» | La UEMOA tiene 8 miembros; 14 es toda la zona del franco CFA (UEMOA + CEMAC), y Guinea Ecuatorial está en la CEMAC |
| E27 | ZLECAf | «afectará al 90 % del comercio» | Al 90 % de las líneas arancelarias (más un 7 % de productos sensibles después) |
| E28 | ZLECAf | Aumento del comercio del 16 % «según el FMI» y 30 millones fuera de la pobreza | La cifra de los 30 millones es del Banco Mundial (2020), no del FMI; no se recoge (estimación *ex ante* antigua) |
| E29 | Conclusión | Evidencia empírica «[ver tema 3.B.7]» | La medición de los efectos está en el 3.B.10 |

El bloque III antiguo (OCDE y otros foros) no se ha corregido porque sale del tema; el canon ya anotaba sus errores («90 %», «duplicar», «18 países», «G-8 con Rusia») para que no se trasladen.

## 3. Marcas resueltas

| Marca | Texto original | Qué se ha hecho |
|---|---|---|
| Notas al opositor (inicio) | Aviso del cambio de temario de 2023, tablas de correspondencia y «Copiado todo del tema de Juan Luis…» | Desaparecen (notas de trabajo). El texto se ha redactado de nuevo; no se cita al preparador |
| Nota «Toda esta sección está estrechamente relacionada con el tema 3.B.10» y «Exponer brevemente, no aporta gran valor» | Bloque I | Resuelto: la teoría se resume (I.2) y se remite al 3.B.10; el bloque I se centra en lo propio de este tema (el debate del regionalismo con 2 modelos y el marco jurídico) |
| Comentario «Coordinar en temas 3.B.10 y 3.B.35» | Delimitación | Resuelto: la tabla de formas del 3.B.10 lleva aquí los ejemplos de fuera de la UE (el 3.B.10 remite a este tema para ello) y la figura ZLC/UA se copia igual |
| Comentario «Gandolfo a partir del mercado común dice que puede haber más grados» | Delimitación | Recogido en la escalera (unión económica, UEM, integración total) |
| Nota «Con el cambio de temario este apartado se traslada al nuevo tema 3.B.19» | Organismos de cooperación | Cumplido: el bloque sale del tema; caja gris con remisión al 3.B.19 |
| 15 tramos en amarillo | ALCA y ALBA (fichas a medias: «Delimitación», «Objetivo», «Contexto», «Valoración» vacíos) | Resueltos en «Otros procesos de América Latina y el Caribe»: el ALCA (Miami 1994; muerto en Mar del Plata, 2005) y el ALBA (2004, contrapropuesta, más política que comercial) |
| Apartados vacíos | Contexto del CARICOM, valoración de la ASEAN, contexto de la APEC, relevancia de Oriente Medio, GAFTA y CCG, y todas las fichas de África (CEMAC, CEEAC, SACU, SADC, EAC, COMESA, Tripartita, CEDEAO, UEMOA, Unión Africana) | Escritos, con el patrón fijo (miembros y forma, origen, situación actual, valoración) y datos de 2026; los africanos, agrupados en «comunidades regionales» y la ZLECAf |
| 75 imágenes (mapas y logotipos de Wikipedia, imagen de Camarero y Tamarit) | Todo el bloque II | Se quitan los mapas y logotipos (no son gráficos y no tienen licencia clara); se sustituyen por la figura ZLC/UA, la tabla del plato de espaguetis de Asia-Pacífico, los gráficos de datos y el anexo de fichas |
| «Debate acerca del regionalismo»: viñetas sueltas («Larry Summers,», «Economía política», «Identificar cuantitativamente el éxito (Tinbergen)») | I | Desarrollado en I.3 con la anécdota de 1992 (del paper de Baldwin, 2004, del disco D:) y los 2 modelos |
| Apartados vacíos de la conclusión | Relevancia, Opinión | Escritos |
| Bibliografía y anexos vacíos | — | Bibliografía con 80 entradas; anexos: modelo de Krugman, fichas de los bloques, test |

## 4. Datos actualizados

Todos consultados el 14/11/2026; los detalles, en `datos-actualizables.yaml` (15 entradas).

| Dato | Antes | Ahora | Fuente | Segunda comprobación |
|---|---|---|---|---|
| ACR en vigor | ≈420 (2023) | 390 notificados (sin adhesiones), ≥84 sin notificar | RTA-IS de la OMC (exportación completa) | Portada del RTA-IS: 383 a 1/4/2026 (= mi serie a finales de 2025); 3.B.10: 390 |
| ACR por tipo | — | 343 ZLC, 26 AAP, 16 UA, 5 AIE | RTA-IS | — |
| Comercio intrarregional | — | 15 bloques, 2000/2010/2024/2025 | FMI, IMTS (API SDMX) | UNCTADstat US.IntraTrade 2024: UE 59,8 % y Mercosur 10,7 % (aquí 61,2 y 11,4 con Bolivia) |
| PIB y población de los bloques | RCEP «30 %» | 2025: T-MEC 29,5; RCEP 27,2/28,2; CPTPP 14,3; ZLECAf 2,7/18,8 | Banco Mundial, WDI (11/11/2026) | ASEAN y USTR (órdenes de magnitud) |
| T-MEC | renegociado (2020) | Revisión del 1/7/2026 sin prórroga; revisiones anuales; fin en 2036 | IISD (9/9/2026) | Reuters (1/7/2026), Greenberg Traurig |
| UE-Mercosur | «firmado en 2019» | Firma 17/1/2026; interino provisional 1/5/2026; TJUE | Consejo; Comisión; PE | Prensa (Intereconomics 2026) |
| AELC | 25 ALC | India (1/10/2025); Mercosur (1/10/2026 para Islandia y Brasil) | efta.int | OMC, Comité de ACR (29/10/2026) |
| Reino Unido | CPTPP firmado (2023) | CPTPP en vigor 15/12/2024; India 15/7/2026; CCG firmado mayo de 2026 | ODI; PwC | techUK; Hogan Lovells |
| ASEAN | 10 | 11 (Timor Oriental, 26/10/2025); ATIGA mejorado y ACFTA 3.0 (oct. 2025) | ASEAN; MTI de Singapur | Jakarta Post (sept. 2026) |
| RCEP | en vigor 2022 | Grupo de adhesión (Hong Kong, Sri Lanka, Chile, Bangladés), sept. 2026 | Financial Express | CGTN (2/10/2026) |
| CPTPP | 11 + Reino Unido firmado | 12; Costa Rica cerrada (mayo 2026); Uruguay; diálogo con la UE | DFAT (26/6/2026); gov.uk (27/3/2026) | Canning House |
| ZLECAf | «pendiente de ratificación» | 54 firmantes, 50 ratificaciones, 26 comerciando | Secretaría de la ZLECAf (julio de 2026) | tralac (sept. 2026: 50) |
| CEDEAO | — | Salida de Mali, Burkina Faso y Níger (29/1/2025) | Comisión de la CEDEAO | Al Jazeera |
| Tripartita | 2015 (firma) | En vigor 25/7/2024 | SADC | COMESA |
| CAN | — | Guerra arancelaria Ecuador-Colombia; resolución de mayo de 2026 | Forbes Colombia | Primicias, El Espectador |
| CARICOM | — | Libre circulación plena de 4 países (1/10/2025) | The Gleaner | Gobierno de San Vicente |
| México | — | Aranceles de hasta el 50 % a países sin acuerdo (1/1/2026) | Expansión | El Imparcial, DOF (29/12/2025) |
| NMF | — | 83 % (2022) → 72 % (2026); 17 % usa preferencias | OMC (igual que el 3.B.33) | 3.B.32 |

## 5. Contenido añadido

- **Modelo de los bloques de Krugman (1991)** con solución numérica propia (anexo A, `datos/krugman-bloques.csv`, script en `_trabajo/krugman.py`): confirma el mínimo con 3 bloques para σ = 2, 4 y 8. Extensiones (Krugman 1991b, Frankel-Stein-Wei, Deardorff-Stern, Bond-Syropoulos) y evidencia.
- **Teoría del dominó de Baldwin** con gráfico propio y evidencia (AELC tras el mercado único, Canadá en el TLCAN, Baldwin-Jaimovich, Egger-Larch); apisonadora (Baldwin y Robert-Nicoud) y multilateralización del regionalismo (Baldwin, 2006).
- **El escollo** (Bhagwati 1995 y 2008; Limão, 2006) frente al peldaño (Estevadeordal, Freund y Ornelas, 2008).
- **Acuerdos profundos** (Horn, Mavroidis y Sapir, 2010) y **ganancias no tradicionales** (Fernández y Portes, 1998).
- **Bloques nuevos o ampliados**: Reino Unido tras el *Brexit*, Unión Económica Euroasiática, Alianza del Pacífico, SICA, SAARC/SAFTA y BIMSTEC, ANZCERTA y PACER Plus, CCG completo, Agadir y UMA, CEDEAO/UEMOA/CEMAC/SACU/EAC/Tripartita, ZLECAf al día.
- **Bloque III nuevo**: comercio intrarregional, peso de los bloques, evidencia (Baier-Bergstrand; Mattoo, Mulabdic y Ruta; uso de preferencias) y las 4 tendencias de la fragmentación.
- **Material del disco D: usado**: la versión propia de 2023 («Temas a imprimir\10…\Tema 3.B.36 - v.2023.pdf») y la de 2024 («Mis temas\Tema 3.B.36 - v.2 - 2024.docx»), idénticas en contenido al Word de partida; el paper de Baldwin («3.B.36. Baldwin 10.1.1.463.3203.pdf» = *Stepping stones or building blocs?*, 2004), citado y base de la anécdota Summers-Bhagwati y del planteamiento «liberalización discriminatoria»; el tema de ICEX-CECO (3B35, numeración actual, escaneado), solo el índice, como contraste de estructura (lo ordena por forma: ZLC y uniones aduaneras; se ha preferido el orden geográfico del original) y sin citarlo; Jovanovic (2006) se cita como manual de la tipología. El 3B-36 de la carpeta de materiales y los temas de otros preparadores no se han usado.

## 6. Coherencia

- **3.B.10** (teoría de la integración, ya revisado): misma tabla de formas (aquí con ejemplos fuera de la UE, que el 3.B.10 remite a este tema), misma figura ZLC/UA (copiada), misma terminología («desviación del tráfico», «peldaño/escollo», «plato de espaguetis»), misma cifra de ACR (390, misma base). Su dicho del dominó («cuando las barbas de tu vecino…») y su refrán («dime con quién andas…») no se repiten aquí.
- **3.B.33** (OMC y GATT): art. XXIV, Entendimiento de 1994, cláusula de habilitación y Kemp-Wan con las mismas palabras; aranceles de EE. UU. de 2025-2026 y NMF 83 → 72 % iguales. Discrepancia menor: el 3.B.33 dice «unos 380» ACR (anotado en `_trabajo/canon-pendiente.md`).
- **3.B.19**: G-20 y OCDE fuera, como pide el canon (D119); remisión en caja gris.
- **3.B.21 y 3.B.32**: fragmentación, ZLECAf (50 ratificaciones) y regionalismo de los 90 coherentes.
- **3.B.41 y 3.B.42**: los acuerdos de la UE con estos bloques solo desde el lado del bloque no comunitario, con remisión.
- **4.º ejercicio**: `\vertema{4.A.22}` (cadenas de valor e internacionalización), `\vertema{4.A.23}` (inversión española en América Latina), `\vertema{4.A.24}` (diversificación de mercados).
- **Canon**: propuestas de fichas `krugman-bloques` y `domino-baldwin` y de símbolos locales en `_trabajo/canon-pendiente.md`.

## Comentarios de Víctor (14/11/2026, reglas de la 9.ª tanda aplicadas)

| Regla | Cómo se ha aplicado |
|---|---|
| Estructura rígida de modelo | Krugman y dominó con a) Idea, b) Modelo (i-iii), c) Extensiones, d) Evidencia empírica, e) Valoración |
| Sin citas Harvard | Solo `\nocite` y `\textcite` de obras originales; ningún `\parencite` |
| Nunca citar a Víctor | Ninguna entrada suya; gráficos «elaboración propia» |
| Ni «Pegatina» ni «Dicho» | No hay etiquetas; el único dicho es el del enganche («juntos, pero no revueltos»), retomado en la idea final e integrado en 3 frases (ZLC frente a UA, AELC) |
| Refranes del temario antiguo | El original abría con un eslogan del Plan Marshall, no con un refrán; se quita (B35-02) |
| Nobel con motivo oficial | Tinbergen (1969, con Frisch), Mundell (1999) y Krugman (2008), en su primera mención |
| `\vertema` al 4.º ejercicio | 4.A.22, 4.A.23, 4.A.24 |
| Resultados clave en morado | `eq:krugman` y `eq:domino` con `\funcionclave` |
| Pasos con sangría | Desarrollos por pasos en sublistas |
| Cajas grises | Notación y siglas; lectura del debate de la OMC; «Lo que aquí no se trata» (G-20, OCDE, bancos regionales) |
| Ejemplos sin nombres propios | Sí (no hay ejemplos con personas) |
| Sin remisiones vacías | Cada `\vertema` tras la idea completa |
| Inglés entre paréntesis la primera vez | *regional trade agreements*, *trade deflection*, *rules of origin*, *building/stumbling block*, *domino effect*, *juggernaut effect*, *spaghetti bowl*, *hub-and-spoke*, *open regionalism*, *Factory Asia*, *cumulation*, *friend-shoring* |
| Anexo de test | Caja estándar con `tema=3.B.35` |
| Sin páginas en blanco ni desbordes | Comprobado con `verificar-tema.py` sobre `_trabajo/`; 0 líneas desbordadas |

## 7. Dudas abiertas

Todas aplicadas con la opción recomendada (14/11/2026); para que Víctor las confirme.

- **B35-01** (14/11/2026) Bloque III. El original tenía 3 bloques y el tercero (organismos de cooperación) ya no está en el título. Opciones: (a) sustituirlo por «III. Balance y situación actual» (comercio intrarregional, peso de los bloques, evidencia y fragmentación) **[aplicada]**; (b) partir el bloque II en 2 (América / resto del mundo) y dejar el balance en la conclusión.
- **B35-02** (14/11/2026) Enganche. El original abría con el eslogan del Plan Marshall («Sople donde sople el viento…»), que habla de la cooperación occidental y no de la integración fuera de la UE. Opciones: (a) el dicho «juntos, pero no revueltos» (no lo usa ningún otro tema; el 3.B.10 usa «dime con quién andas» y el 3.B.33 «hecha la ley, hecha la trampa») con los hechos de 2026 **[aplicada]**; (b) mantener el eslogan.
- **B35-03** (14/11/2026) El modelo de Krugman se presenta con su resultado en forma aproximada ($t^N\approx1/[(\sigma-1)(1-\tilde s)]$, la regla de la inversa de la elasticidad con CES) y el mínimo de 3 bloques con una solución numérica propia del modelo exacto (anexo A). Opciones: (a) así, avisando de la aproximación **[aplicada]**; (b) solo de palabra y el gráfico.
- **B35-04** (14/11/2026) El encargo situaba los acuerdos de la UE con terceros en temas «4.B»; en el temario actual el 4.B es hacienda pública y esos acuerdos están en el 3.B.41 y el 3.B.42. Opciones: (a) remitir al 3.B.41/3.B.42 **[aplicada]**; (b) otra.
- **B35-05** (14/11/2026) Comercio intrarregional calculado con el IMTS del FMI y la composición **actual** de cada bloque para todos los años (no hay serie oficial para todos; UNCTADstat solo tiene la UE y el Mercosur). Incluye estimaciones del FMI para países que no informan (Rusia desde 2022, parte de África). Opciones: (a) así, explicado en la fuente del gráfico **[aplicada]**; (b) solo los bloques con dato oficial.
- **B35-06** (14/11/2026) Estado de algunos acuerdos sin fuente oficial a mano: la revisión del T-MEC (IISD y Reuters, no el comunicado del USTR), el acuerdo Reino Unido-CCG (PwC), los acuerdos de la UEE con los Emiratos, Mongolia e Indonesia (se dicen «firmados», sin afirmar su entrada en vigor; hay prensa de que el de los Emiratos entró en vigor en octubre de 2026) y la firma del DEFA de la ASEAN (prevista en la cumbre de Manila de noviembre; se dice «negocia»). Ninguna acción; revisar en la próxima actualización.
- **B35-07** (14/11/2026) Alianza del Pacífico: las fuentes sobre su presidencia rotatoria son contradictorias (Chile-Perú en 2023; Colombia-México en enero de 2026; Perú anuncia que la asumirá en diciembre de 2026). Se dice solo lo seguro (México la ejerce en 2026). Ninguna acción.
- **B35-08** (14/11/2026) El modelo centro-periferia (que el original repetía con su tabla de mecanismos) y los determinantes de primera y segunda naturaleza se quitan: están en el 3.B.10 y el 3.B.40 (`informe-repaso.md`). Opciones: (a) quitarlos **[aplicada]**; (b) una línea con remisión.

- **B35-09** (18/11/2026) Lectura de «meter un poco más de los modelos que metes» (comentario 2) junto al comentario 1. Opciones: (a) los modelos, completos y algo más desarrollados, en anexos (Krugman con su solución numérica, el dominó y uno nuevo, Krishna, 1998, con una versión lineal propia), y en el cuerpo solo su interpretación de palabra, salvo el gráfico de los bloques de Krugman, que se queda en I.3.2 como único gráfico de teoría del cante **[aplicada]**; (b) además, dejar en el cuerpo las 2 funciones clave ($t^N$ y $P(n^*)=R(n^*)$) y el gráfico del dominó, a costa de unos 30 segundos de II; (c) todo de palabra, sin ningún gráfico de teoría en el cuerpo.
- **B35-10** (18/11/2026) Reparto de minutos tras el cambio. Opciones: (a) I 7′ (I.3, 3′30″), II 13′, III 6′30″ (III.1, efectos económicos, 3′30″; III.2, 3′) **[aplicada]**: los procesos siguen siendo casi la mitad del cuerpo; (b) I 6′30″, II 14′, III 6′, si Víctor prefiere dar aún más peso a los procesos.
- **B35-11** (18/11/2026) El mapa (gráfico 3). Opciones: (a) un solo mapa del mundo a todo el ancho, con color por bloque regional, trama del CPTPP, contorno del RCEP y de la ZLECAf y el número de acuerdos de cada país para el plato de espaguetis **[aplicada]**; (b) añadir 2 mapas de detalle (Centroamérica y el Caribe; África occidental y oriental), donde los países pequeños se ven poco; (c) una versión apaisada a página completa. Sin banderas ni logotipos (derechos); los bloques se marcan con sus siglas.
- **B35-12** (19/11/2026) Refrán del enganche. Opciones: (a) «Más vale solo que mal acompañado» (integrarse o no, y con quién) **[aplicada]**; (b) «Quien tiene un amigo tiene un tesoro» (los socios y el acceso a mercados; encaja con el dominó de Baldwin: nadie quiere quedarse fuera); (c) «Más vale ser cabeza de ratón que cola de león» (el poder de cada socio dentro del bloque: el Mercosur frente al ALCA, los pequeños en el CPTPP).

## 8. Instrucciones para el vídeo

- **Enganche e idea final** (refrán cambiado el 19/11/2026): «Más vale solo que mal acompañado» (integrarse o no, y con quién); los 3 hechos de 2026 como las 2 respuestas (UE-Mercosur el 1 de mayo y ZLECAf con 50 ratificaciones; en sentido contrario, T-MEC sin renovar el 1 de julio); pregunta: ¿abren los bloques el comercio o lo trocean? La idea final vuelve al refrán y la responde: para un país casi nunca vale más ir solo (más creación que desviación; las cadenas de valor, buena compañía); peldaño si los bloques siguen abiertos al resto del mundo; si se cierran, los 3 bloques que temía Krugman.
- **Introducción y conclusión, sin pizarra** (`modo: guion`); la cronología de las 4 olas, como apoyo.
- **I.1**: la escalera de formas, de palabra con la tabla como apoyo; la figura ZLC/UA, en la pizarra (2 paneles: la flecha de la desviación del tráfico y la frontera única).
- **I.3, imprescindible**: el modelo de Krugman en la pizarra: la función clave `eq:krugman` recuadrada y el gráfico `krugman-bloques` por capas (ejes y libre comercio; curva σ = 4; el mínimo en B = 3; las otras 2 curvas). Después el dominó: `eq:domino` y el gráfico `domino-baldwin` por capas (ejes; R; P y E₀; P′ con la flecha; los escalones; E₁). Las 2 funciones clave se conservan hasta el final del bloque I (`conservar:`) y se vuelven a señalar en III.2 y en la idea final.
- **I.4**: el gráfico `acr-anuales` como apoyo (o en la pizarra por capas si hay tiempo: barras, ejes, línea, puntos, rótulos).
- **II**: patrón fijo por bloque, de palabra; en la pizarra solo una rejilla con los bloques que se van nombrando (forma y año). La tabla del plato de espaguetis de Asia-Pacífico, como apoyo en II.3. Nunca se dice el número de un tema en voz alta.
- **III.1**: el gráfico `comercio-intrarregional` en la pizarra por capas (barras de 2000, de 2025, ejes, rótulos); el de PIB y población, como apoyo.

**Reparto del cante** (nota que iba tras el esquema del tema; quitada del tema el 19/11/2026 a petición de Víctor, se conserva aquí para el vídeo):

> Reparto del cante: introducción, \tiempo{2,5}; I, \tiempo{7} (I.1, \tiempo{1,5}; I.2, \tiempo{1}; I.3, \tiempo{3,5}; I.4, \tiempo{1}); II, \tiempo{13} (II.1, \tiempo{2}; II.2, \tiempo{4,5}; II.3, \tiempo{3,5}; II.4, \tiempo{1}; II.5, \tiempo{2}); III, \tiempo{6,5} (III.1, \tiempo{3,5}; III.2, \tiempo{3}), y conclusión, \tiempo{1}. El grueso del cante son los procesos (bloque~\ref{sec:procesos}), que se apoyan en el mapa de los bloques (gráfico~\ref{fig:mapa}). Del debate del regionalismo se cantan los argumentos del peldaño y del escollo con la interpretación de los modelos de \autor{Krugman}, \autor{Baldwin} y \autor{Krishna}, cuyo desarrollo está en los anexos; el gráfico de los bloques de \autor{Krugman} es el único de teoría que conviene dibujar. De cada bloque se canta el patrón fijo (miembros y forma, origen, situación actual, valoración) en pocas líneas; las fichas largas, las cajas grises y los anexos son para las preguntas del tribunal.

## Coherencia con el 3.B.41 (14/11/2026)
- Corregido por el coordinador a partir del 3.B.41 (Mercosur: negociación cerrada en diciembre de 2024 y firma el 17/1/2026; México firmado; Indonesia, la India y Australia cerrados en 2025-2026; salvaguardia del acero sustituida el 1/7/2026 por el Reglamento 2026/1384; el SPG se trata en el 3.B.41).

## Listas en las notas al pie (15/11/2026)

- Nota del T-MEC: el nombre en cada país (México, Estados Unidos, Canadá), en itemize.

## Comentarios de Víctor (18/11/2026)

1. **I.3.1-I.3.3 es más un anexo (modelos); en el cuerpo, la interpretación y la remisión; el grueso, los procesos.** Los 3 modelos pasan a anexos con la estructura a)-e) completa: A (bloques de Krugman, con la derivación y la tabla de la solución numérica), B (dominó de Baldwin, con su gráfico) y C (nuevo: la economía política del escollo de Krishna, 1998, con una versión lineal propia que reproduce su resultado, $\Delta\Pi^{M|ACR}=-3t^2/8<0$). En el cuerpo, I.3 queda como debate (I.3.1 argumentos del peldaño, I.3.2 del escollo, I.3.3 balance y condiciones del peldaño), con la interpretación de cada modelo, remisión a su anexo y a \vertema{3.B.10}. La notación de los modelos sale de la introducción y va al principio de los anexos. II pasa a 13′ y es casi la mitad del cuerpo.
2. **Algo más de modelos y más regionalismo frente a multilateralismo y balance con efectos económicos.** I.3 añade: las 2 preguntas de Bhagwati (1993), socios naturales y su crítica (Bhagwati y Panagariya, 1996), complementariedad arancelaria (Ornelas, 2005), los acuerdos como laboratorio, Levy (1997), Krishna (1998), centro y radios (Kowalczyk y Wonnacott, 1992), distracción y poder, y un balance con 5 condiciones del peldaño y las propuestas (Bhagwati, Baldwin, plurilaterales de la OMC; Informe sobre el comercio mundial 2011). III.1 pasa a «Los efectos económicos de los bloques»: medición (MEGC, gravedad con resistencia multilateral, Anderson y van Wincoop, 2003; Baier y Bergstrand, 2007), creación y desviación bloque a bloque (TLCAN: Caliendo y Parro, 2015, y Hakobyan y McLaren, 2016; Mercosur: Yeats, 1998, y Chang y Winters, 2002; RCEP y CPTPP: Petri y Plummer, 2020; ZLECAf: Banco Mundial, 2020), efectos más allá del comercio (IED, convergencia de Venables, 2003, *Brexit*) y los datos de comercio interno y uso de preferencias. Minutos: I 7′, II 13′, III 6′30″ (antes 8′, 13′30″ y 5′). Dudas B35-09 y B35-10.
3. **Mapa grande con los bloques que sirva para el plato de espaguetis.** Nuevo gráfico 3 al principio del bloque II (`graficos/mapa-bloques.tex`), generado con datos y código: contornos de Natural Earth 1:50m (dominio público) proyectados (Equal Earth) por `datos/mapa-bloques.py` y pertenencias en `datos/mapa-bloques.csv`, comprobadas a 18/11/2026 (RTA-IS de la OMC y páginas de cada acuerdo; salida de Mali, Burkina Faso y Níger de la CEDEAO; Guinea reintegrada en enero de 2026; Bolivia en el Mercosur y Venezuela suspendida; ASEAN con Timor Oriental; CPTPP con 12, sin Costa Rica, que solo ha cerrado la negociación; EAC con la RD del Congo y Somalia). Color por bloque regional con siglas sobre el mapa, trama para el CPTPP, contorno para el RCEP y la ZLECAf y un número con los acuerdos a los que pertenece cada país (plato de espaguetis). Sin banderas ni logotipos. Se cita en II, en el plato de espaguetis (I.3.2) y en la ficha. Visto en PNG; en el PDF ocupa media página (p. 11). Duda B35-11.

Otros cambios: reglas del 18/11 aplicadas (5 fuentes esenciales marcadas: Jovanovic, 2006; OMC, 2011; Freund y Ornelas, 2010; Bhagwati, 2008; RTA-IS de la OMC); la conclusión mantiene «Recapitulación: En conclusión, …» y añade los efectos económicos; rótulos de las listas nuevas, todos en cursiva; 16 entradas nuevas en el `.bib`; 2 entradas nuevas en `datos-actualizables.yaml`; ficha de repaso al día (4 páginas a 10 pt; sin el gráfico del dominó ni la tabla de Krugman, con el mapa y III.1 nuevo). PDF: antes 26 + 2 + 5 = 33 páginas; ahora 26 + 8 + 6 = 40. `verificar-tema.py`: 0 errores, 17 avisos (los mismos de antes: cifras sin cita en párrafos antiguos y el vídeo).

**Para el vídeo**: el gráfico de Krugman sigue en la pizarra (I.3.2), pero el dominó ya no (anexo); el mapa (gráfico 3) va como apoyo en II, por capas: tierra, UE, América, Europa y Eurasia, Asia, África, CPTPP, RCEP, ZLECAf, números, rótulos y leyenda.

## Comentarios de Víctor (19/11/2026)

- Mapa de la exposición tras el esquema, en caja gris (figu:mapa-tema).
- Refrán del enganche más popular: «juntos, pero no revueltos» pasa a «Más vale solo que mal acompañado» (integrarse o no, y con quién). Se rehacen el enganche (los hechos de 2026 como las 2 respuestas), la idea final y las 2 menciones del dicho viejo en el cuerpo (la AELC y la recapitulación del bloque II); «juntos, pero no revueltos» se queda solo como dicho de la ZLC frente a la UA en I.1. Ficha, mapa de la exposición e instrucciones del vídeo al día. Sin cifras nuevas. Duda B35-12.
- Ficha rehecha con el formato nuevo (introducción y esquema en la 1.ª columna, anexo en la última); 9 pt. Fuera la tabla «Los bloques en cifras» (sus datos están en los gráficos y en Datos clave): con ella la ficha bajaba a 8,75 pt.

## Opinión (21/11/2026)

- Viñetas: 1 → 2.
- Frase: no tenía asignada.
