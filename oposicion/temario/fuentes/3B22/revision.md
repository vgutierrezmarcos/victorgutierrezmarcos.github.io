# Revisión del 3.B.22 — El Fondo Monetario Internacional. Estructura y políticas. La prevención y solución de crisis

Revisión completa del 13/11/2026 (entrega 1: tema y ficha de repaso; sin vídeo), en el worktree `revision-temario-2`, en paralelo con los agentes de los 3.B.20 y 3.B.21. Fuente nueva en LaTeX (`3B22.tex`) a partir del Word original (`_trabajo/original.md`). Según su propio comentario interno, el Word era una copia del tema de otro preparador con añadidos: **todo el texto está redactado de nuevo**, con datos comprobados en imf.org a noviembre de 2026 (imf.org bloquea la descarga automática: las páginas se leyeron con WebFetch, las tablas dinámicas en copias de web.archive.org y las series con la API SDMX del FMI). Las dudas se resuelven con la opción recomendada y se anotan como B22-NN (13/11/2026).

## 1. Resumen

- Tema completo con la estructura del original en 3 apartados: **I. Estructura** (evolución histórica en 4 etapas, marco jurídico, marco institucional: organización y finanzas), **II. Políticas** (supervisión, asistencia técnica, política financiera) y **III. Prevención y solución de crisis** (el antiguo «Análisis de coyuntura del FMI», ampliado con la prevención que pide el título). Reparto: introducción 2′30″, I 8′30″, II 8′30″, III 9′30″, conclusión 1′.
- 3 modelos con la estructura rígida a)-e): la **financiación catalítica** (Corsetti, Guimarães y Roubini, 2006; Morris y Shin, 2006), la **adecuación de las reservas** (métrica ARA; el 3.B.22 es su tema de referencia en el canon) y la **programación financiera** de Polak (1957), con su anexo paso a paso.
- 6 gráficos y figuras nuevos en TikZ/pgfplots: 4 con datos reales del FMI (votos, cesta del DEG, crédito vivo 1970-2026; las cuotas por grupos van en el texto) y 2 figuras (cronología y gobierno, que sustituyen a las imágenes 1 y 2 del Word); más el gráfico teórico de las 3 regiones. Tabla de instrumentos y balance de la CRG.
- Datos a noviembre de 2026: 191 miembros, 25 sillas, 16.ª revisión sin vigor (76,7 % de consentimientos; plazo hasta el 15/11/2026), Principios de Diriyah, cesta del DEG, límites de acceso, recargos de 2024, programas de Argentina (2025) y Ucrania (2026), crédito vivo por países (octubre de 2026), revisiones de 2026 (supervisión, condicionalidad, FSAP, LIC-DSF), cargos (Georgieva, Katz, Tenreyro, Aljadaan).
- PDF: 28 páginas de tema, 1 de anexos, 5 de bibliografía (34 en total); cante de 30′. Ficha de repaso de 4 páginas a 10,5 pt (última, 84 %). `verificar-tema.py` sobre el PDF de `_trabajo/` (con `--no-publicar` no se publica): sin errores propios (solo faltan el HTML y el Word, que salen al construir con publicación).

## 2. Errores corregidos

| Dónde (Word) | Decía | Dice ahora |
|---|---|---|
| Introducción y I.3 | 190 países miembros | 191 (Liechtenstein entró el 21/10/2024) |
| Bretton Woods (l. 120) | «una paridad del dólar con respecto al dólar (35 $/onza)» | El dólar convertible en **oro** a 35 $ la onza |
| Bretton Woods (l. 120) | «creado en 1945 por 44 países con una dotación de 8.000 millones» | Convenio firmado en julio de 1944 por 44 países, en vigor el 27/12/1945; opera desde el 1/3/1947 (la cifra de 8.000 millones no se pudo comprobar y se quita) |
| Crisis financiera (l. 220) | «el FMI prestó más de 200 billones de dólares» | Error de escala; se sustituye por el gráfico del crédito vivo (máximo de unos 96.000 millones de DEG en 2012) |
| Junta de Gobernadores (l. 336) | Nota: «Nadia Calviño es titular y Pablo Hernández de Cos suplente» | Gobernador: el ministro de Economía, Comercio y Empresa; suplente: el gobernador del Banco de España (sin nombres, que caducan) |
| Directorio (l. 378-384) | 24 representantes; 8 sillas propias (con Rusia y Arabia Saudí); España con «7 países de Centroamérica» y México, Colombia… | **25** sillas desde noviembre de 2024; sillas propias de Estados Unidos, Japón, China, Alemania, Francia y el Reino Unido; España con México, Colombia, Costa Rica, El Salvador, Guatemala y Honduras (Venezuela no aparece en la declaración de España ante el CMFI de abril de 2026; B22-06) |
| Gerencia (l. 406-410 y notas 19-21) | Economista jefe Gita Gopinath; subdirectora estadounidense Gopinath; José Viñals «desde 2009» | Primer subdirector gerente Dan Katz (octubre de 2025); economista jefe Silvana Tenreyro (agosto de 2026); Viñals dirigió el Departamento de Mercados Monetarios y de Capital entre 2009 y 2016 |
| CMFI (l. 422 y nota 22) | «24 gobernadores»; «reunión bianual» | 25 miembros; se reúne 2 veces al año (primavera y otoño); presidente Mohammed Aljadaan desde enero de 2024 |
| Cuotas (l. 478) | «se ha asignado un total de 715.700 millones de DEG» (con un enlace a la ficha del DEG) | Confundía las cuotas de la 16.ª revisión (715.700 millones, **sin vigor**) con las vigentes (476.000 millones) y con las asignaciones de DEG (660.800 millones) |
| Cuotas (l. 368 y 506) | «La 16.ª revisión está en curso y se prevé que concluya en diciembre de 2023» | Aprobada en diciembre de 2023; sin vigor en noviembre de 2026: 149 miembros con el 76,7 % (falta EE. UU.), 4 prórrogas, la última hasta el 15/11/2026 |
| Cuotas (l. 482) | Las cuotas «se remuneran al tipo del DEG, igual que una línea de crédito» | Se remunera la posición de reserva; el tipo del DEG remunera las tenencias por encima de la asignación y es la base del coste de los préstamos |
| Fórmula de cuotas (l. 354-362) | Variabilidad de los «últimos 3 años»; fórmula sin factor de compresión numérico | Desviación respecto de la tendencia de 3 años en 13 años; compresión 0,95; reservas, media de 12 meses |
| Votos (nota 26) | Votos básicos «el 5,5 %, el triple que antes de la reforma de 2010» | 5,502 %, triplicados por la reforma de **2008** |
| Préstamos (nota 27) | NAP «duplicados en 2020 a 361.000 millones»; ABP 2020 por 139.000 millones | NAP de 364.000 millones de DEG para 2026-2030 (40 participantes); 39 acuerdos bilaterales por 136.600 millones en abril de 2026 |
| Reservas del FMI (l. 518) | «reserva prudencial de en torno a 25.000 millones de $» | Saldos precautorios de 26.300 millones de **DEG** (objetivo 25.000 millones) |
| Supervisión (l. 586) | FSAP «cada 5 años en 29 países» | 47 jurisdicciones (32 cada 5 años, 15 cada 10) hasta la revisión de 2026; España: 2006, 2012, 2017 y 2024 |
| Supervisión estadística (l. 630) | «vigente la Sexta Edición» del manual de balanza de pagos | MBP7 publicado en marzo de 2025, aplicación hacia 2029-2030 (con el SCN 2025) |
| Supervisión estadística (nota 29) | Déficit griego de 2009 revisado «a 15,8 %» | «más de un 15 %» (las cifras de Eurostat cambiaron entre revisiones: 15,4 % y 15,8 %; B22-09) |
| Facilidades (l. 702) | «El acceso normal anual es del 145 % de la cuota» (nota: 435 % acumulado) | 200 % anual y 600 % acumulado (decisión de diciembre de 2024, hasta que entre en vigor la 16.ª revisión) |
| Facilidades (l. 768) | Préstamos a países pobres «al 0 % y otros tipos bajos 0,5 %», «con condicionalidad limitada» | Desde 2025, tipo 0 para los más pobres y el 40 o el 70 % del tipo del DEG para los demás; condicionalidad normal (salvo los de urgencia) |
| Facilidades (l. 776-788) | La Facilidad Rápida de Crédito «de 2 años», dirigida a «importes modestos (75 %)»; la «Facilidad de Crédito Stand-By» con «problemas normales» | Tabla de instrumentos vigente con duración y reembolso de cada uno (tabla 2) |
| Otras iniciativas (l. 800-804) | La Línea de Liquidez a Corto Plazo (2020) como vigente | Se extingue en abril de 2027 (decisión de diciembre de 2025) |
| DSA (l. 966-972) | 3 «zonas» (verde, gris, roja) | Marco de 2021 para los países con mercado (riesgo de tensión bajo/moderado/alto) y LIC-DSF; el filtro del acceso excepcional (sostenible con alta probabilidad / no alta: alargar vencimientos / insostenible: reestructurar) |
| Grecia (l. 230) | «aportar el 3.000 % de la cuota» | Más del 3.200 % (3.212 %), unos 30.000 millones de euros |
| Grecia (nota 13) | El programa carecía de reestructuración «ya que el BCE se negó» | Se dice que la deuda se reestructuró en 2012 y que la evaluación *ex post* del FMI admitió que debió llegar antes (la atribución al BCE no se pudo comprobar; B22-10) |
| Valoración (l. 1064) | Crítica a los modelos «no adaptados a la literatura reciente» | Se mantiene, pero dentro de la valoración de Polak, con las críticas concretas (velocidad estable, sin expectativas ni enfoque intertemporal) |

## 3. Marcas resueltas

| Marca | Texto original | Qué se ha hecho |
|---|---|---|
| Amarillo (l. 155) | «de esto no pone nada [el otro preparador], pero me parecería más interesante añadir un pelín de contexto … [sacado del tema 3.B.20]» | Contexto de los 60 (dilema de Triffin, AGP de 1962) en I.1.1, breve y con `\vertema{3.B.20}`, sin duplicar el 3.B.20 |
| Amarillo (l. 163) | «[Sacar un poco de contexto del tema 3.B.20]» (años 70) | 15 de agosto de 1971, Smithsonian, flotación de 1973 y segunda enmienda (Jamaica), con `\vertema{3.B.20}` y `\vertema{3.B.21}` |
| Amarillo (l. 325) | «Fuente: Martínez-Díaz (2008)[…]» | Localizada: Martinez-Diaz (2008), documento de antecedentes de la OEI BP/08/08; la imagen se sustituye por la figura TikZ `gobierno-fmi` |
| Nota al opositor (l. 1-14) | Aviso de cambio de temario de 2023 y tabla | Desaparece (aviso de trabajo) |
| Comentarios internos | «copiado todo el tema de [otro preparador]…», «Sacar de [preparador]», «[preparadores]» | No se publican; el tema se redacta de nuevo; sin nombres de preparadores |
| Logotipo e imagen del enganche | Imágenes del Word | Se quitan (no son gráficos) |
| Imágenes 1 y 2 | Organigrama del FMI (captura) y panorama de gobierno (Martinez-Diaz) | Figura 2 propia en TikZ; el enlace al organigrama se conserva en la bibliografía (`FMI2026Organigrama`) |
| Apartados vacíos | «Funciones» y «Políticas» de la etapa COVID; Activo del balance; Relevancia, Extensiones, Opinión e Idea final de la conclusión | Escritos |
| Bibliografía del Word | Fichas del FMI y temas de preparadores | Fichas del FMI conservadas con sus URL actuales; los temas de preparadores no se citan (CRITERIOS §5) |

## 4. Datos actualizados

Todos consultados el 13/11/2026. Primera fuente: imf.org (WebFetch o web.archive.org) o la API SDMX del FMI; segunda comprobación indicada.

| Dato | Antes | Ahora | Fuente | Segunda comprobación |
|---|---|---|---|---|
| Miembros | 190 | 191 | IA 2026 del FMI; PR 24/387 | CRS R49499 (oct. 2026) |
| Sillas del Directorio | 24 | 25 (nov. 2024) | PR 24/403 | IA 2026 |
| Personal | unos 3.000 | 3.118 (abr. 2026) | IA 2026, cuadro web 3.2 | CRS («about 3,100») |
| Cuotas totales | 715.700 M (sic) | 476.000 M de DEG | IA 2026 | Tabla de cuotas (476.372,0 M) y API (476.272,0 M; B22-08) |
| 16.ª revisión | «en curso» | sin vigor, 149 miembros / 76,66 %, plazo 15/11/2026 | Policy Paper 2026/017 | CRS R49499 |
| Votos de EE. UU. | — | 16,49 % | Tabla de cuotas y votos (17/6/2026, web.archive.org) | CRS |
| Votos de Japón, China, Alemania, Francia, Reino Unido, España | — | 6,14 / 6,08 / 5,31 / 4,03 / 4,03 / 1,92 % | Tabla de cuotas y votos | Cuotas del BdE (2025): EE. UU. 17,4 %, Japón 6,46 %, China 6,39 % (solo cuotas; B22-07) |
| Cuotas de las avanzadas | — | 61,6 % | API FA (IMFQ_XDR, oct. 2026) | — |
| NAP | 361.000 M (2020) | 364.000 M de DEG, 2026-2030 | IA 2026 | — |
| Acuerdos bilaterales | 139.000 M (2020) | 39, unos 136.600 M de DEG | IA 2026 | CRS (cifra antigua) |
| Cesta del DEG | dólar, euro, libra, yen, renminbi (sin pesos) | 43,38 / 29,31 / 12,28 / 7,59 / 7,44 % | PR 22/153 | PDF de pesos históricos del FMI; PR 22/281 |
| Valor y tipo del DEG | — | 1,347190 $; 3,119 % | rms_sdrv.aspx y sdr_ir.aspx | — |
| Asignaciones acumuladas | — | 660.800 M de DEG | IA 2026 | Ficha del DEG (456.000 M en 2021) |
| Saldos precautorios | 25.000 M $ | 26.300 M de DEG | PR 26/114 | IA 2026 |
| Oro | — | 90,5 M de onzas, 2.814,1 t | Ficha «Gold in the IMF» | Estados financieros 2025 (90,474 M) |
| Límites de acceso | 145 % / 435 % | 200 % / 600 % | PR 24/499 | IA 2026 |
| Margen y recargos | — | 60 pb; 200 pb > 300 % de la cuota; +75 pb > 36 meses (51 en el SAF); −36 %, 1.200 M $ al año | PR 24/385 | IA 2026 |
| Tipos del FFCLP | 0 % / 0,5 % | 0 %; 40 % y 70 % del tipo del DEG (desde mayo de 2025) | FAQ de la revisión del PRGT | — |
| Crédito vivo total | — | 122.717 M de DEG (oct. 2026); CRG 92.050 M | API FA (CLIMF, IMFOPGRA) | balmov2.aspx (122.366,6 M el 12/11/2026) |
| Mayores deudores | — | Argentina 41.968,7 M (45,6 % de la CRG), Ucrania 10.504,7, Pakistán 7.571,6, Egipto 7.461,2, Ecuador 6.913,3 | API FA | balmov2.aspx (mismas cifras) |
| Argentina | — | SAF 11/4/2025: 20.000 M $ (DEG 15.267 M, 479 %); 2.ª revisión 21/5/2026 | PR 25/101 y PR 26/165 | Agente de datos (prensa: 3.ª revisión en diciembre) |
| Ucrania | — | SAF 26/2/2026: 8.100 M $ (DEG 5.935 M, 295 %), sustituye al de 2023 | PR 26/066 | — |
| FSAP | 29 países | 47 jurisdicciones; revisión de sept. 2026 | PR 26/298 | — |
| España FSAP / art. IV | — | FSAP 2024; art. IV mayo de 2026 | Country Report 24/154; PR 26/163 | — |
| MBP7 | MBP6 vigente | MBP7 (20/3/2025), aplicación 2029-2030; SCN 2025 (5/3/2025) | PR 25/072 | — |
| FFACC | — | 31 países (no se da la cifra en el texto) | Ficha del CCRT | — |
| Métrica ARA | — | pesos 10/10/30/20 (fijo) y 5/5/30/15 (flexible); 100-150 % | FMI (2016), guía y GFSN | Informe de país del FMI 2023/129 (pesos con tipo fijo); réplica de la base ARA (tipo flexible) |

Series en `datos/`: `credito-fmi.csv` (1970-2026), `cuotas-votos.csv`, `cuotas-grupos.csv`, `mayores-deudores.csv`, `cesta-deg.csv`, con la fuente y la consulta en la cabecera. Todo lo que caduca está en `datos-actualizables.yaml` (17 entradas).

## 5. Contenido añadido

- **Prevención de crisis** (epígrafe del título que el Word no desarrollaba): III.1 (el FMI como prestamista internacional; modelo de la financiación catalítica con su gráfico), III.2 (adecuación de las reservas con a)-e) y líneas precautorias y red de seguridad).
- **Programación financiera** como modelo a)-e) con anexo A (derivación y ejemplo numérico propio).
- **Reestructuración de la deuda** (SDRM, CAC, préstamo con atrasos, Marco Común, Mesa Redonda, 3 pilares) en resumen, remitiendo al 3.B.29.
- **Evidencia sobre los programas** (Przeworski y Vreeland, Barro y Lee, Dreher, Blanchard y Leigh) y 3 casos (Asia, Grecia, Argentina).
- Marco jurídico ampliado: artículos IV, VI, VIII, XIV y XXVI, Visión institucional 2012/2022, censura a Argentina (2013-2016).
- Novedades 2024-2026: 25.ª silla, reforma de recargos, límites de acceso, revisiones de 2026, Principios de Diriyah, Bessent (2025), Bangkok (2026), Ucrania 2026, extinción de la LLCP.
- Notas al pie conservadas del original (bien desarrolladas): coste de las cuotas para EE. UU., aportaciones monetarias frente a fiscales, troika con mandatos distintos, prestigio del tipo de cambio, Ecuador 1999, directores gerentes y economistas jefe, Solchaga y el Comité Provisional.
- Bibliografía: 77 entradas (las del FMI con URL y fecha de consulta).

## 6. Coherencia

- Con el **canon**: notación de `notacion.md` ($R$, CI, $M$, $k$ de Cambridge, $m$ propensión a importar); $\Delta R=-\Delta\mathrm{CI}$ como en el 3.B.12 y el 3.B.17; 3 regiones con los colores del 3.B.17 (verde, dorado, rojo). Propuestas al canon en `_trabajo/canon-pendiente.md` (ficha ARA cerrada, fichas nuevas de financiación catalítica y programación financiera, filas del 3.B.22 en 12 fichas).
- Con el **3.B.20 y el 3.B.21** (en revisión a la vez): solo la historia imprescindible del FMI (4 etapas en I.1, una figura), con remisiones; no se cuenta el sistema monetario internacional.
- Con el **3.B.17**: crisis de segunda generación, gemelas, riesgo moral, crítica a la subida de tipos en Asia, reservas como indicador de alerta; mismas palabras.
- Con el **3.B.29**: SDRM (Krueger, 2001-2003), CAC (México, 2003), Marco Común, Mesa Redonda, LIC-DSF; el 3.B.22 resume y remite.
- Con el **3.B.12**: enfoque monetario y dinámica de la deuda exterior (`eq:deuda-externa`) para el DSA; absorción y políticas que reducen y desvían el gasto.
- Con el **3.B.19**: Londres 2009 (recursos ×3, 750.000 M $), con la misma cifra.
- **4.º ejercicio**: `\vertema{4.A.27}` (España en 1958 y el Plan de Estabilización), `\vertema{4.A.18}` y `\vertema{4.A.28}` (2012: banca y FSAP), `\vertema{4.A.21}` (balanza de pagos de España).
- Contradicción menor: el 3.B.17 da 56.300 M $ para el préstamo a Argentina de 2018; aquí, «más de 50.000 millones» (B22-11).

## Comentarios de Víctor (13/11/2026, 9.ª tanda)

| Regla | Cómo se ha aplicado |
|---|---|
| Estructura rígida de modelo | Los 3 modelos con a) Idea, b) Modelo (i-iii), c) Extensiones, d) Evidencia empírica, e) Valoración |
| Sin citas Harvard | Solo `\nocite` y `\textcite` de obras originales; ningún `\parencite` |
| Nunca citar a Víctor | Ninguna entrada suya; gráficos «elaboración propia» |
| Ni «Pegatina» ni «Dicho» | No hay; el único refrán es el del enganche («Más vale prevenir que curar»), retomado en la idea final |
| Nobel con motivo oficial | Diamond y Dybvig (2022), Stiglitz (2001), Krugman (2008), en su primera mención |
| `\vertema` al 4.º ejercicio | 4.A.18, 4.A.21, 4.A.27, 4.A.28 |
| Resultados clave en morado | 4 funciones clave: votos, catalítica, ARA y techo de crédito (más la fórmula de cuotas) |
| Pasos con sangría | Desarrollos de los modelos por pasos en sublistas |
| Cajas grises | Notación; sanciones del FMI |
| Ejemplos sin nombres propios | Sí (el ejemplo numérico de Polak, sin personas) |
| Sin remisiones vacías | Cada `\vertema` va tras la idea completa |
| Inglés entre paréntesis la primera vez | *global financial safety net*, *firm surveillance*, *spillovers*, *fear of floating*, *groupthink*, *bail-in*… |
| Anexo de test | Caja estándar con `tema=3.B.22` |
| Sin páginas en blanco ni desbordes | Comprobado con `verificar-tema.py` sobre el PDF de `_trabajo/` |
| MBP7 | Recogido en II.1.3 con su estado (publicado en 2025, aplicación 2029-2030) |

## Revisión transversal (13/11/2026)

- Nobel añadidos: Diamond y Dybvig (2022, con Bernanke), Stiglitz (2001, con Akerlof y Spence), Krugman (2008).
- `\vertema` al 4.º: 4.A.18, 4.A.21, 4.A.27 y 4.A.28.
- Refranes: solo el del enganche (nuevo, B22-01); el eslogan del Plan Marshall del original no es un refrán y no se ha podido comprobar (B22-02).

## 7. Dudas abiertas

Todas aplicadas con la opción recomendada (13/11/2026); para que Víctor las confirme.

- **B22-01** Refrán del enganche: «Más vale prevenir que curar», porque es literalmente el epígrafe «prevención y solución de crisis». El 3.B.31 lo usa una vez dentro del texto (no como enganche). Opciones: (a) mantenerlo **[aplicada]**; (b) «En la necesidad se conoce al amigo»; (c) «Cuando las barbas de tu vecino veas pelar…» (ya es dicho del 3.B.10).
- **B22-02** El enganche del original («Sople donde sople el viento… *whatever the weather we only reach welfare together*», eslogan del Plan Marshall) se quita: no es un refrán, no se ha podido comprobar su origen y el Plan Marshall no es el FMI. Opciones: (a) quitarlo **[aplicada]**; (b) conservarlo como nota al pie.
- **B22-03** Estructura: se mantienen los 3 bloques del original y sus títulos de segundo nivel, pero el III («Análisis de coyuntura del FMI») pasa a llamarse «Prevención y solución de crisis» y añade III.1 (Idea: el FMI como prestamista internacional) y III.2 (La prevención); «Documentos» pasa a «La solución: los documentos del programa». Opciones: (a) así **[aplicada]**; (b) mantener el título antiguo del III y meter la prevención en II.3.
- **B22-04** Modelo de la financiación catalítica: es una versión simplificada propia (umbrales con información perfecta y umbral único citado) de Corsetti, Guimarães y Roubini (2006) y Morris y Shin (2006), no la de ninguno de los 2 artículos. El gráfico pone $\theta^*$ a mitad de la zona de pánico a título ilustrativo. Opciones: (a) mantenerlo como modelo a)-e) **[aplicada]**; (b) dejarlo en una caja gris de palabra.
- **B22-05** La ARA como modelo a)-e) (es una métrica, no un modelo), porque el canon hace del 3.B.22 su tema de referencia con «desarrollo». Opciones: (a) a)-e) **[aplicada]**; (b) caja con los indicadores.
- **B22-06** Silla de España en el Directorio: se nombran México, Colombia, Costa Rica, El Salvador, Guatemala y Honduras (declaración de España ante el CMFI, abril de 2026, y blog del BdE de 2025). Venezuela estaba en la silla y no se ha podido comprobar si sigue (la tabla del FMI es dinámica). Tampoco se ha podido comprobar en imf.org que la directora ejecutiva sea Xiana Méndez (sí figura en el IA 2026). Opciones: (a) como está **[aplicada]**; (b) quitar los nombres.
- **B22-07** Votos de los 12 mayores y España: leídos en la copia de web.archive.org de la tabla del FMI de 17/6/2026 (la tabla de imf.org se actualizó el 3/4/2026 y no se puede leer sin navegador); solo EE. UU. (16,49 %) tiene segunda comprobación (CRS). Opciones: (a) usarlos **[aplicada]**; (b) dar solo el de EE. UU.
- **B22-08** Las cuotas totales difieren 100 millones de DEG entre la tabla de cuotas (476.372,0) y la API (476.272,0): el texto dice «476.000 millones». Ninguna acción.
- **B22-09** Déficit griego de 2009: «más del 15 %» en lugar de una cifra (15,4 % en la notificación de 2010; 15,8 % después). Opciones: (a) así **[aplicada]**; (b) 15,8 % con la cita de Eurostat de 2011.
- **B22-10** La nota del original que atribuía al BCE la falta de reestructuración griega en 2010 y la de los «polis buenos y malos» (con Blanchard pidiendo un objetivo de inflación del 4 %) se quitan: no se han podido comprobar. Opciones: (a) quitarlas **[aplicada]**; (b) buscar fuente y recuperarlas.
- **B22-11** Préstamo a Argentina de 2018: «más de 50.000 millones de dólares» (acuerdo ampliado a unos 57.000; el 3.B.17 dice 56.300). Opciones: (a) así **[aplicada]**; (b) unificar con el 3.B.17 por el canon.
- **B22-12** Plazos de reembolso de LCF, LPL, SCA, SCS y SCR en la tabla 2: los estándar (3¼-5 y 5½-10 años; SCS 4-8), sin segunda comprobación en las fichas actuales del FMI. Opciones: (a) mantenerlos **[aplicada]**; (b) quitar la columna.
- **B22-13** Plazo de la 16.ª revisión: vence el 15/11/2026, 2 días después de esta revisión. Si se prorroga o entra en vigor, cambiar I.3.2, la ficha y `datos-actualizables.yaml` (entrada `revision-16-cuotas`).
- **B22-14** Relevo de Bo Li por Liao Min (1/12/2026) solo en prensa: no se menciona; los subdirectores no se nombran.
- **B22-15** Se cita a Stiglitz (2002) y a Krugman como críticos de Asia; el texto no da cifras de su crítica. Ninguna acción.

## 8. Instrucciones para el vídeo

- **Enganche e idea final**: «Más vale prevenir que curar»; Argentina 2025 (20.000 M $, casi la mitad del crédito de la cuenta general). La idea final retoma el refrán: la cura funciona a tiempo, con el solvente y sin quitarle las ganas de cuidarse.
- **Introducción y conclusión, sin pizarra** (`modo: guion`).
- **I**: la cronología (figura 1) como **apoyo**, por etapas; en la pizarra, solo la fórmula de los votos (`eq:votos`) y el gráfico de los votos (`cuotas-votos`) dibujado por capas: barras, ejes, la línea del 15 % y el rótulo del veto. El gobierno (figura 2) se construye por capas (los 3 niveles; los comités; G-20 y OEI). La fórmula de cuotas y la cesta del DEG, apoyo.
- **II**: casi de palabra; la tabla de instrumentos como apoyo; el crédito vivo (`credito-fmi`) **imprescindible**, por capas (barras, ejes, máximos y rótulos de las oleadas), mientras se cuentan las 4 etapas otra vez en una frase.
- **III.1** (16/11/2026): de palabra, sin pizarra de modelo; las 3 zonas, como mucho, en una línea (insolvente | pánico | a salvo) con una flecha de $L$ que estrecha el pánico. El gráfico `catalitica` queda en el anexo B.
- **III.2** (16/11/2026): de palabra; la caja de las reservas no se canta salvo pregunta.
- **III.3** (16/11/2026): la función clave `eq:dinamica-deuda` recuadrada, que se queda hasta el final (`conservar:`); el abanico (`dsa-abanico`) **imprescindible**, por capas (histórico, base, abanico, tensión y lecturas); la figura `dsa-decision` como **apoyo**, por capas (los 2 marcos, las 3 zonas, lo que hace el FMI, el Marco Común). Polak, de palabra (caja y anexo A).
- **Funciones clave que se conservan**: `eq:dinamica-deuda` (desde III.3).
- **I y II** (16/11/2026): la figura 2 (`gobierno-fmi`, página entera) y la figura 3 (`politicas-fmi`) son de repaso; en el vídeo, como apoyo por capas.
- Nunca se dice el número de un tema en voz alta.

## Listas en las notas al pie (15/11/2026)

Ninguna nota lo necesitaba (la de las aportaciones monetarias y fiscales es un solo contraste en una frase).

## Comentarios de Víctor (16/11/2026)

Páginas del tema: antes 28 (anexos: 1), ahora **32** (anexos: 4: A, programación financiera; B, financiación catalítica; C, test). Total del PDF: 34 → 42. `\minutos` sigue en 30; III, 9′30″, con el reparto nuevo III.1 1′30″, III.2 1′30″, III.3 4′30″. Ficha de repaso: 4 páginas (89 % la última).

- **«En la figura 2 puedes ocupar más espacio, pero que sintetice lo que hay en las antiguas imágenes 1 y 2 de manera más completa.»** Rehecha `graficos/gobierno-fmi.tex` como figura de página entera (`\graficopagina`, flotante `[p]`) en 2 partes. *A. El gobierno*: los 3 niveles (Junta, Directorio, director gerente) y el personal técnico, con todas las relaciones de la imagen 2 antigua (delega, elige, preside, dirige, informa y asesora); el CMFI (asesora a la Junta y orienta al Directorio), el Comité para el Desarrollo, el G-7, el G-20 y el G-24 como influencia informal, la OEI, que informa al Directorio, y las **autoridades nacionales** (nombran gobernadores, eligen directores y reciben art. IV, programas y asistencia técnica), que faltaban. *B. La organización* (la imagen 1 antigua, el organigrama): la Gerencia con sus oficinas (Presupuesto y Planificación, Auditoría Interna, Gestión de Riesgos, Inversiones del Plan de Jubilación) y los 4 grupos de departamentos, con qué hace cada uno. Datos de noviembre de 2026. El texto del I.3.1 presenta la figura y el párrafo del personal enumera los 4 grupos de departamentos en lista sangrada.
- **«Introduce una figura que sintetice las políticas del FMI.»** Nueva figura 3 (`graficos/politicas-fmi.tex`, página entera, al empezar el II, presentada en el texto): arriba los recursos (cuotas, NAP, bilaterales, fondos fiduciarios, DEG); en 3 columnas la supervisión (base, bilateral, regional, multilateral, estadística), el préstamo (los instrumentos y servicios de la CRG por finalidad, FFCLP, FFRS, sin dinero; coste, límites de acceso y crédito vivo de octubre de 2026) y la asistencia técnica (asesoramiento, formación, ámbitos, destinatarios); abajo la condicionalidad, que las une (acciones previas, criterios cuantitativos de ejecución, metas indicativas y referencias estructurales, revisiones y tramos, por qué), con flechas desde cada política. Fuentes y datos vigentes en el pie.
- **«Creo que del DSA se puede hablar un poco más y desarrollar un poco más […]»** El análisis de sostenibilidad de la deuda pasa a ser una subsección propia (III.3.2, unas 5 páginas con figuras) con 7 partes: qué es y para qué sirve (señal de riesgo frente a valoración de la sostenibilidad); la dinámica de la deuda, con la ecuación en morado (`eq:dinamica-deuda`, notación del 3.A.39) y el superávit que la estabiliza; el escenario base y las herramientas de realismo; los escenarios de tensión y el **gráfico de abanico** (gráfico nuevo `dsa-abanico`, ilustrativo, con sus 3 lecturas); los 2 marcos y sus señales (SRDSF de 2021, con los 3 horizontes y sus módulos; LIC-DSF de 2018, en 3 pasos, con la **tabla de umbrales** y la revisión de 2026); del riesgo a la decisión de prestar (las 3 zonas del tema antiguo con lo que hace el FMI en cada una, el acceso excepcional, el reperfilamiento, las recomendaciones según el tipo de cambio y el préstamo con atrasos); y el DSA en las reestructuraciones (el Marco Común del G-20 en 6 pasos, con los casos de Chad, Zambia, Ghana, con sus objetivos de 2028, y Etiopía; los problemas: lentitud y falta de neutralidad; la Mesa Redonda y los 3 pilares). Nueva figura 4 (`dsa-decision`) con los 2 marcos, las 3 zonas, lo que hace el FMI y los pasos del Marco Común.
- **«[…] mientras que de otras partes del modelo del FMI como prestamista internacional que no estaban en la versión anterior se podrían meter en cajas grises, manteniendo la idea.»** Lo que no estaba en el tema antiguo pasa a cajas grises y, si es un modelo, a anexo (regla 5): *III.1*: en el cuerpo, la idea de la financiación catalítica de palabra (3 pasos numerados y 4 consecuencias, con sus autores); caja gris con el riesgo moral del acreedor, la señal y la evidencia; el modelo formal, con su gráfico y su función, al **anexo B**. *III.2*: la adecuación de las reservas (indicadores, métrica ARA, coste, óptimo, evidencia), a una caja gris; en el cuerpo, la idea en 2 viñetas. *III.3*: la programación financiera de Polak, a una caja gris (idea, techo de crédito, qué deja y qué ha cambiado) y el modelo entero al **anexo A** (con la derivación paso a paso en caja); la reestructuración (SDRM y CAC), a una caja gris dentro del DSA. *III.4*: «lo que dicen los datos», a una caja gris. El nexo del III.3 recupera del tema antiguo los 3 pasos del análisis (diagnóstico, previsión, recomendaciones) y sus raíces (Alexander, Johnson, Polak), y la presentación analítica de la balanza de pagos vuelve al cuerpo (estaba en el antiguo).
- **Reglas generales del 16/11**: (1) desaparecen las series a)-e) del cuerpo del III (solo quedan en los anexos, completas); (2) las enumeraciones nuevas y las de la valoración llevan párrafo introductorio; (3) autores nombrados en la catalítica (Morris y Shin; Corsetti, Guimarães y Roubini), la absorción (Alexander), el enfoque monetario (Johnson) y la programación financiera (Polak); (4) cuerpo de 32 páginas; (5) modelos a anexos. Refrán inicial sin cambios.
- **Otros arreglos**: la frase de los NAP del I.3.2 estaba rota («…\nocite miembros e instituciones, que son…»): reescrita. En el modelo catalítico, «cada euro del FMI reduce la zona de pánico más que en un euro» no era cierto en general: la reducción es $1/\psi-1$ por unidad (más de una solo si $\psi<1/2$); corregido en el anexo B. La nota al opositor, el esquema de tiempos, la ficha de repaso (III reescrito, fórmula de la dinámica de la deuda, abanico, figuras 2 y 3 de palabra) y las instrucciones del vídeo (§ 8) están actualizados. Bibliografía nueva: Alexander (1952) y Johnson (1972) (reutilizadas), revisión del LIC-DSF de 2026, Ghana (2023 y 2026), Marco Común del G-20 (2020) y directrices de condicionalidad (2002).

### Dudas (16/11/2026)

- **B22-16** Modelos del III en un tema institucional: Víctor pidió cajas grises para lo que no estaba en el antiguo, y la regla general 5 (16/11) pide los modelos en anexos. Opciones: (a) idea de palabra en el cuerpo, comentarios y evidencia en cajas grises y el modelo formal (catalítica, Polak) en los anexos A y B **[aplicada]**; (b) todo en cajas grises en el cuerpo, sin anexos nuevos.
- **B22-17** La métrica ARA y la regla de Greenspan-Guidotti son métricas del FMI, no teoría: van en caja gris (no estaban en el antiguo), sin anexo. Opciones: (a) caja gris **[aplicada]**; (b) devolverlas al cuerpo como parte de la prevención.
- **B22-18** Organigrama (figura 2, parte B): lista de departamentos y oficinas según el organigrama del FMI que recogía el tema antiguo y lo que se conoce del de 2025-2026; la página del organigrama de imf.org no se pudo leer sin navegador para comprobar los nombres exactos de 2026 (p. ej., si Comunicaciones y Servicios Corporativos siguen con esos nombres y si hay un centro de capacitación nuevo). Opciones: (a) mantenerla **[aplicada]**; (b) dejar solo los grupos sin nombrar los departamentos.
- **B22-19** Datos nuevos del DSA comprobados en la web el 16/11/2026 (revisión del LIC-DSF: propuestas de septiembre de 2026, aplicación prevista a mediados de 2027; objetivos de Ghana: 55 % del PIB en valor actual y 18 % de los ingresos en 2028; riesgo moderado desde julio de 2026). Los umbrales del LIC-DSF de 2018 (tabla 3) y los detalles del SRDSF (horizontes, módulos) son los de las notas de orientación, sin segunda comprobación hoy. Opciones: (a) usarlos **[aplicada]**; (b) quitar la tabla de umbrales y dejar la descripción.
- **B22-20** Plazo de la 16.ª revisión de cuotas (B22-13): vencía el 15/11/2026; la búsqueda del 16/11 no encontró aún la decisión del Directorio (prórroga o entrada en vigor). Se mantiene el texto («la última hasta el 15 de noviembre de 2026»). Opciones: (a) mantenerlo hasta que se publique **[aplicada]**; (b) escribir «vencía el 15 de noviembre de 2026».
- **B22-21** El gráfico de abanico es ilustrativo (datos inventados, lo dice el pie), no de un país real. Opciones: (a) ilustrativo **[aplicada]**; (b) el abanico de un análisis real (p. ej., España en el art. IV de 2026), que habría que leer del informe.
