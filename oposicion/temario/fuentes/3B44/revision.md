# Revisión del 3.B.44: La Unión Bancaria: Pilares y Código normativo único. La Unión de Mercados de Capitales

Tema nuevo, hecho el 14/11/2026 (entrega 1: tema y ficha de repaso; sin vídeo) en el worktree `revision-temario-2`, en paralelo con los agentes del 3.B.43 y el 3.B.45. No había tema anterior en el repositorio ni tema propio de Víctor con este título: la estructura sigue, adaptada a tres apartados, la del tema de ICEX-CECO de 2023 (3B44, numeración actual; usado como base de estructura y contenido, no citado), y la parte de la unión bancaria toma lo aprovechable del antiguo 3.B.46 de Víctor (v. 2023 en PDF y v.2 2024 en Word). Todo se ha **redactado de nuevo** y puesto al día a noviembre de 2026 con fuentes oficiales (BCE/Supervisión Bancaria, JUR, ABE, AEVM, Comisión, Consejo, Parlamento Europeo, MEDE, Eurostat, Banco Mundial, Reserva Federal). Las dudas se han resuelto con la opción recomendada y se anotan como B44-NN (14/11/2026).

## 1. Resumen

- **Estructura**: 3 apartados. **I. Origen, fundamentos y código normativo único** (I.1 origen: de la crisis a la decisión de 2012; I.2 ¿por qué una unión bancaria?; I.3 el código normativo único). **II. Los pilares de la unión bancaria** (II.1 MUS; II.2 MUR, con el FUR, el respaldo del MEDE, los casos y la reforma CMDI; II.3 la garantía común de depósitos y el tratamiento de la deuda pública). **III. La Unión de Mercados de Capitales** (III.1 por qué; III.2 la UMC 2015-2024; III.3 la Unión de Ahorros e Inversiones 2025-2026, con el euro digital como infraestructura). Reparto: introducción 2′30″, I 7′30″, II 10′30″, III 8′30″, conclusión 1′ (18′ de unión bancaria y 8′30″ de UMC, como recomienda la nota del tema de ICEX).
- **5 modelos** con la estructura rígida a)-e):
  - el **círculo vicioso banca-soberano en forma reducida**, con la función clave $s^*=(s_0+\alpha L_0)/(1-\alpha\beta)$ y el multiplicador $1/(1-\alpha\beta)$; cada pieza de la unión bancaria actúa sobre $\alpha$, $\beta$ o $L_0$;
  - el **trilema financiero** de Schoenmaker, con $\theta B\geq C$ frente a $B\geq C$;
  - la **recapitalización interna frente al rescate**, con $r-r_f\approx\pi(1-R)$ (subvención implícita);
  - el **seguro de depósitos común y el riesgo moral**, con $F_c/F_n=\sqrt{\rho+(1-\rho)/n}$;
  - el **reparto de riesgos** de Asdrubali, Sørensen y Yosha, con $1=\beta_K+\beta_F+\beta_C+\beta_U$.
- **11 gráficos y figuras propios** en TikZ/pgfplots:
  - 2 teóricos: el círculo vicioso en el plano $(L,s)$ y el fondo común frente al nacional;
  - 5 de datos con CSV en `datos/`: CET1 y préstamos dudosos de las entidades significativas 2015-2026 (BCE, SUP), FUR 2016-2025 (JUR), capitalización bursátil UE-27/EE. UU./Japón 2001-2025 (Eurostat y Banco Mundial), préstamos sobre la deuda de las empresas zona del euro/EE. UU. 2000-2025 (BCE y Fed), reparto de riesgos EE. UU./zona del euro (ASY 1996 y BCE 2022);
  - 4 figuras: cronología 2009-2027, pilares de la unión bancaria (gráfico de referencia de la ficha del canon), trilema financiero (mismo triángulo que el trilema del 3.B.15) y jerarquía de acreedores.
- **PDF**: 27 páginas de tema, 2 de anexos y 7 de bibliografía (36 en total). **Ficha de repaso**: 4 páginas a 10,5 pt, última al 83 %.
- **`verificar-tema.py`** (con el envoltorio sobre `_trabajo/`): sin errores propios (las 11 «imágenes inexistentes en el HTML» salen porque se verifica en `_trabajo/`, con rutas relativas, como en el 3.B.36 y el 3.B.38). Quedan avisos de «cifra sin cita» en párrafos de fechas y de estructura (la cita va en el párrafo vecino o no procede) y los del vídeo (entrega 3).

## 2. Errores corregidos

Correcciones al tema antiguo (parte de unión bancaria del antiguo 3.B.46, v. 2023 y v.2 2024):

| Id | Dónde (tema antiguo) | Decía | Dice ahora |
|---|---|---|---|
| E1 | 3.1.3, MUS | El BCE supervisa «unas 120 entidades, más del 80 % de los activos»; las nacionales, «unas 3.000» | 109 significativas a 1/9/2026, en torno al 85 %; 1.828 menos significativas en 2025 (BCE) |
| E2 | 3.1.3, MUR | FUR de «alrededor de 80.000 millones en 2024», que «los bancos abonarán durante esos 8 años» | Se constituyó en 2016-2023; más de 81.000 millones a finales de 2025; sin aportaciones en 2024-2026 (JUR) |
| E3 | 3.1.3, MUR | «Hasta la fecha, el MUR ha llevado a cabo únicamente una resolución, la del Banco Popular» | También las filiales croata y eslovena de Sberbank (2022); se añaden los casos sin interés público (Vicenza y Veneto, ABLV, PNB) |
| E4 | 3.1.3, *common backstop* | «Implementación prevista para 2024»; «la cuantía total llegaría a 110.000 millones» | La reforma del MEDE (firmada el 27/1/2021) no está en vigor: Italia la rechazó el 21/12/2023; respaldo de hasta 68.000 millones |
| E5 | 3.1.4 | «Se ha conseguido aprobar el Common Backstop, el Sistema Europeo de Garantía de Depósitos…» | Falso: el EDIS nunca se aprobó y la Comisión lo retira en su programa de trabajo para 2027 (4/11/2026); el respaldo no está en vigor |
| E6 | 3.1.3, EDIS | «La Comisión propone un esquema basado en el coaseguro… solo actúa en caso de insuficiencia… proporcionando liquidez» | La propuesta de 2015 tenía 3 fases (reaseguro, coaseguro, seguro pleno en 2024); la versión de 2017 empezaba por liquidez |
| E7 | 3.1.1 | «[ver tema 3.B.28]» para el SESF | La regulación financiera es hoy el 3.B.27 |
| E8 | 3.1.3, código normativo único | Los 3 hitos sin el tercer paquete bancario ni la reforma de crisis | CRR3/CRD VI (desde 2025; suelo 50 % → 72,5 %; FRTB en 2027) y la reforma CMDI (Directivas 2026/806 y 2026/804, Reglamento 2026/808) |
| E9 | 3.2 | «La UMC revestiría mayor importancia si se introduce Central Bank Digital Currency» | Se sustituye por el euro digital como infraestructura común de pagos, con su estado legislativo (trílogos desde julio de 2026) |
| E10 | 3.2, «otros desarrollos» | «European Safe Asset: objetivo 2020-2024»; fondo de desempleo, etc. | No se cumplió; el activo seguro se menciona como forma de bajar $\beta$ con remisión al 3.B.37; el resto es materia del 3.B.45 |
| E11 | Nota 51 | DGSFP «del Ministerio de Asuntos Económicos y Transformación Digital» | No se repite aquí (es del 3.B.27 y del 4.A.19); hoy la DGSFP depende del Ministerio de Economía, Comercio y Empresa |

## 3. Marcas resueltas

| Marca | Texto original | Qué se ha hecho |
|---|---|---|
| Nota inicial | Aviso del cambio de temario de 2023 y de qué estaba copiado de otro preparador | Desaparece; no se nombra a ningún preparador |
| Enganche (cita de Monnet) | Enganche genérico de la UE | Sustituido por el refrán «Empezar la casa por el tejado» (B44-02) y la crisis de 2010-2012 |
| IMAGEN 6 (pilares, Comisión) | Captura | Rehecha: figura `pilares-union-bancaria` |
| IMAGEN 7 (etapas hacia una UEM genuina), «Fuente:» vacía | Captura sin fuente | Sustituida por la figura `cronologia` |
| Conclusión | Relevancia, Extensiones y Opinión vacías; recapitulación de política monetaria y PEC | Escrita entera, solo con lo de este tema |
| Anexos 1-4 | «Son del tema 3.B.45, no de este» | No se incluyen; los anexos nuevos son el multiplicador, los requisitos de capital y pasivos y los conceptos |
| Enlaces (esm.europa.eu, fbf.eui.eu, blognewdeal.com) | Notas 55, 57, 58 | Sustituidos por fuentes oficiales (MEDE, Eurogrupo, JUR); el blog no se mantiene |

## 4. Datos actualizados

Todos consultados el 14/11/2026. Las fuentes completas están en `datos-actualizables.yaml`, en las cabeceras de los CSV y en `_trabajo/notas-ub.md` y `_trabajo/notas-umc.md`.

| Dato | Antes | Ahora | Fuente | Segunda comprobación |
|---|---|---|---|---|
| Entidades significativas | ~120, >80 % | 109 (1/9/2026), ~85 % | Lista de entidades supervisadas (oct. 2026) | Informe anual de supervisión 2025 (112 a 1/1/2026); 3.B.27 (109) |
| CET1 / dudosos | — | 16,0 % / 1,89 % (2,17 % sin efectivo), 2T 2026 | API del BCE (SUP) | Nota de prensa del 15/9/2026 |
| PRES 2025 | — | CET1 11,2 %; total 15,6 %; P2R 1,2 % | Nota de 18/11/2025 | Discurso de la presidenta del mismo día |
| FUR | ~80.000 (2024) | >81.000 (31/12/2025) | JUR, ciclo 2026 | Informe anual 2025 de la JUR; 3.B.26 y 3.B.27 |
| MREL | — | 27,8 % de APR; déficit 0,2 mm€ | Dashboard 2S 2025 | Dashboard 1S 2025 (27,9 %, 0,3) |
| Respaldo del MEDE | En vigor en 2024, 110.000 | No en vigor; 68.000 | Informe anual del MEDE 2025 | Comunicado del Eurogrupo de 27/1/2021 |
| CMDI | — | DOUE 20/4/2026; aplicación mayo de 2028 | Declaración de la JUR de 20/4/2026 | Texto PE-CONS 17/26 (preferencia en 3 niveles) |
| EDIS | Coaseguro | Retirado (COM(2026) 710, anexo III) | Programa de trabajo 2027 | Q&A de la Comisión de 17/7/2026 |
| Sesgo doméstico | — | 39 % → ~28 %; 9,3 % del activo | Discurso de C. Buch (19/5/2026) | — (dato único; B44-04) |
| Capitalización | «la mitad que EE. UU.» (2021) | UE 71 %, EE. UU. 224 % (2025) | Eurostat y Banco Mundial | Comisión (IP/25/2893): 73 % y 270 % en 2024 (otra fuente) |
| Financiación de las empresas | — | 73 % préstamos (euro) vs 37 % (EE. UU.) | BCE (BSI, QSA) y Fed (Z.1) | Eurostat nasa_10_f_bs (F4 y F3 de S11) |
| Reparto de riesgos | — | EE. UU. 39/23/13/25; euro ~10/30/0/60 | ASY (1996); BCE (2022) | 3.B.16 (mismas cifras de EE. UU.) |

## 5. Contenido añadido

- **Teoría**: los 5 modelos (arriba), el anexo con el multiplicador y su estabilidad, la inconsistencia temporal del no rescate y el MREL, el riesgo moral entre países y la evidencia (Acharya et al., Schäfer, Schnabel y Weder di Mauro, Carmassi et al., FMI 2014).
- **Unión bancaria**: el SESF, los informes de los 4 y de los 5 presidentes, la cumbre del 29/6/2012, el código normativo único (CRR/CRD con CRR3/CRD VI y la FRTB, BRRD, DGSD, ABE), el MUS completo (base jurídica, criterios, gobernanza, PRES y su reforma, evaluación global, resultados), el MUR (decisión, instrumentos, FUR, acuerdo intergubernamental, respaldo), los casos, la reforma CMDI, el EDIS y su retirada y el tratamiento regulatorio de la deuda pública.
- **UMC y UAI**: los planes de 2015 y 2020, los logros (STS, folleto y *Listing Act*, ELTIF, ESAP, PEPP, inversión minorista, cinta consolidada, EMIR 3, T+1, FASTER, insolvencia), la UMC verde, los informes Letta y Draghi, la estrategia de marzo de 2025 y sus medidas de 2025-2026, y el euro digital como infraestructura.
- **Nobel**: Tirole (2014), Diamond y Dybvig (2022) y Merton (1997), con las notas ya usadas en el temario.
- **Material del disco D: usado**:
  - «Nuevos temas oposición a TCEE - ICEX-CECO\3B\3B44.pdf» (escaneado; OCR en `_trabajo/icex-3B44.txt`): base de estructura y contenido; no se cita;
  - «Temas a imprimir\11. Unión Europea\Tema 3.B.46 - v.2023.pdf» (texto en `_trabajo/antiguo-3B46-2023.txt`) y «Mis temas\Tema 3.B.46 - v.2 - 2024.docx» (misma parte de unión bancaria): de ellos salen las correcciones E1-E11;
  - los 2 documentos de AFI (Ontiveros y Berges; «La Unión Bancaria como vía de fortalecimiento del SME») y la nota sobre el Informe de los cinco presidentes: contexto de 2012-2015; no se citan (son de 2013-2015 y sus cifras están superadas);
  - no se han usado los temas de otros preparadores.

## 6. Coherencia

- **3.B.26**: el círculo vicioso se desarrolla allí (referencia del canon); aquí va una forma reducida con su propio gráfico y la remisión (B44-03). La garantía de depósitos, el EDIS y la CMDI coinciden (Directivas 2026/804 y 2026/806, Reglamento 2026/808, mayo de 2028).
- **3.B.27**: 109 significativas (septiembre de 2026), FUR de más de 81.000 millones, CRR3 desde 2025 con el suelo del 50 % al 72,5 % y transitorios a 2032, CRD VI hasta el 10/1/2026, FRTB en 2027, Popular por 1 euro, Italia y el MEDE: todo coincide. Aquí no se repite la teoría de la regulación: se remite.
- **3.B.16**: ASY 39/13/23/25 y la unión bancaria como solución perfecta: coincide.
- **3.B.39**: la UMC relanzada como UAI en marzo de 2025: coincide; aquí se desarrolla.
- **3.B.18** y **3.B.15**: el trilema financiero se cuenta aquí con su modelo y con el mismo triángulo que el trilema del 3.B.15.
- **3.B.36** (ABE, AEVM, AESPJ) y **3.B.37** (activo seguro, bonos de la UE): se remite.
- **3.B.43** y **3.B.45** (en curso a la vez): el BCE como banco central y el euro digital, en el 3.B.43; el MEDE, en el 3.B.45. Aquí solo el respaldo del FUR.
- **4.º ejercicio**: \vertema{4.A.18}, \vertema{4.A.19}, \vertema{4.A.20}, \vertema{4.B.24}.
- **Canon**: propuestas en `_trabajo/canon-pendiente.md`.

## Reglas de las tandas 8.ª y 9.ª y transversal (aplicadas, 14/11/2026)

| Regla | Cómo se ha aplicado |
|---|---|
| Estructura rígida de modelo | 5 modelos con a)-e); en el trilema y el reparto de riesgos no hay extensiones: a) Idea, b) Modelo, c) Evidencia, d) Valoración |
| Sin citas Harvard | Solo `\nocite` y `\textcite` de obras originales; ningún `\parencite` |
| Nunca citar a Víctor | Ninguna entrada suya; gráficos de «elaboración propia» |
| Ni «Pegatina» ni «Dicho» | No hay. Un solo refrán, el del enganche («Empezar la casa por el tejado», no usado en otro tema y apuntado en `refranes-tanda.txt`), retomado en la idea final |
| Nobel con motivo oficial | Tirole, Diamond y Dybvig, Merton |
| `\vertema` al 4.º ejercicio | 4.A.18, 4.A.19, 4.A.20, 4.B.24 |
| Resultados clave en morado | `eq:bucle`, `eq:trilema-financiero`, `eq:bail-in`, `eq:seguro-comun`, `eq:asy` |
| Pasos con sangría y cajas grises | Pasos en sublistas; criterios de significatividad, lo que no cubre el código y la UMC verde en cajas |

## 7. Dudas abiertas

- **B44-01** (14/11/2026). Estructura. (a) 3 apartados: origen y código normativo único; pilares; UMC. (b) El código normativo único como apartado propio y los pilares en otro (como el tema de ICEX, 6 apartados). **Aplicada: (a)**, por la regla de los 3 apartados; el código normativo único es el último subapartado del I, antes de los pilares que se apoyan en él.
- **B44-02** (14/11/2026). Refrán. (a) «Empezar la casa por el tejado» (moneda común antes que sistema financiero común). (b) «No poner todos los huevos en la misma cesta» (ya lo usan el 3.A.09, el 3.A.35, el 3.B.14 y el 3.B.23). **Aplicada: (a)**.
- **B44-03** (14/11/2026). El círculo vicioso: `mapa.yaml` lo da como «mención» en el 3.B.44 y el encargo pide un modelo. (a) Modelo en forma reducida (2 rectas y multiplicador), distinto del desarrollo cualitativo del 3.B.26, con remisión. (b) Solo mención. **Aplicada: (a)**; se propone al canon como variante del 3.B.44.
- **B44-04** (14/11/2026). Sesgo doméstico (39 % → 28 %; 9,3 % del activo): solo se ha encontrado en un discurso de la presidenta del Consejo de Supervisión. (a) Usarlo con esa cita. (b) Calcularlo con las series semestrales del BCE (SUP, exposiciones a administraciones públicas por país). **Aplicada: (a)**.
- **B44-05** (14/11/2026). Capitalización bursátil: el agregado de la UE del Banco Mundial no está disponible desde 2018. (a) Eurostat (acciones cotizadas emitidas por residentes) para la UE y Banco Mundial para EE. UU. y Japón, con la comprobación de Alemania y España. (b) Las cifras de la Comisión (73 % y 270 % en 2024), sin serie. **Aplicada: (a)**; la diferencia con la Comisión se debe a la fuente para EE. UU.
- **B44-06** (14/11/2026). Reparto de riesgos en la zona del euro: cifras aproximadas leídas del gráfico 2 del Boletín Económico 7/2022 del BCE (VAR de panel, 11 países, sin Irlanda). (a) Usarlas como orientativas, con la advertencia. (b) Buscar el ECB Occasional Paper 306 completo. **Aplicada: (a)**.
- **B44-07** (14/11/2026). El tamaño del FUR a finales de 2017 no aparece en fuentes oficiales: se estima con la suma de 2016 y las aportaciones de 2017 (barra tramada). **Aplicada**: estimación marcada.
- **B44-08** (14/11/2026). Datos solo en prensa o despachos: las fechas exactas de transposición de la CRD VI (10/1/2026) y de aplicación de la CMDI (mayo de 2028, según los despachos y la JUR), y que los socios han dejado de pedir a Italia la ratificación (Eunews). El texto da «mayo de 2028» y «a finales de 2026 sigue sin ratificarse», sin la parte de prensa. **Aplicada**: redacción prudente.
- **B44-09** (14/11/2026). No confirmados a 14/11/2026: los resultados del PRES 2026 (se usa el ciclo 2025), la votación en el pleno del 12/11/2026 de la estrategia de inversión minorista (se dice solo «acordada en diciembre de 2025»), el número en el DOUE de la directiva de insolvencia (2026/799 según el Observatorio Legislativo; el texto dice «aprobada en 2026») y la fecha de arranque de la cinta de bonos. Revisar al actualizar.
- **B44-10** (14/11/2026). El encargo pedía el «manual único de supervisión» de la ABE: no existe con ese nombre (la ABE tiene manuales temáticos y el BCE su manual de supervisión del MUS). (a) Contarlo así. **Aplicada: (a)**.

## 8. Instrucciones para el vídeo

- **Enganche e idea final**: el refrán «empezar la casa por el tejado» (euro de 1999 con cimientos financieros nacionales) y la pregunta «¿puede una unión monetaria funcionar sin un sistema financiero común?»; la idea final responde: puede, pero solo con buen tiempo; la casa estará terminada cuando el seguro de los depósitos sostenga el tejado.
- **Pizarra**:
  - I.1: la cronología, como apoyo (no se dibuja).
  - I.2: el gráfico del círculo vicioso por capas (ejes; recta del Estado; recta de los bancos; $E$; perturbación $\Delta L_0$; $E'$; recta del Estado con unión bancaria; $E''$), con la función clave $s^*=(s_0+\alpha L_0)/(1-\alpha\beta)$, que **se conserva** en una esquina hasta el final de II (cada pilar se asocia a $\alpha$, $\beta$ o $L_0$). Después, el triángulo del trilema financiero (vértices y, al ir nombrándolas, las 3 salidas) con $\theta B\geq C$.
  - II: la figura de los pilares se construye de abajo arriba (base, MUS, MUR, EDIS en gris discontinuo, frontón); los gráficos de solvencia y del FUR, como apoyo; la jerarquía de acreedores por capas con la fórmula $r-r_f\approx\pi(1-R)$; las 3 curvas del fondo común con $F_c/F_n$.
  - III: financiación de las empresas y capitalización como apoyo; la descomposición $1=\beta_K+\beta_F+\beta_C+\beta_U$ se escribe y las barras del reparto de riesgos se dibujan por canales.
- La introducción y la conclusión, en modo guion.

**Reparto del cante** (nota que iba tras el esquema del tema; quitada del tema el 19/11/2026 a petición de Víctor, se conserva aquí para el vídeo):

> Reparto del cante: introducción, \tiempo{2,5}; I, \tiempo{7,5} (I.1, \tiempo{2}; I.2, \tiempo{3,5}, con \tiempo{2} para el círculo vicioso y \tiempo{1,5} para el trilema financiero; I.3, \tiempo{2}); II, \tiempo{10,5} (II.1, \tiempo{3}; II.2, \tiempo{4}, con \tiempo{1,5} para la recapitalización interna; II.3, \tiempo{3,5}, con \tiempo{1,5} para el seguro común); III, \tiempo{8,5} (III.1, \tiempo{3}, con \tiempo{2} para el reparto de riesgos; III.2, \tiempo{2,5}; III.3, \tiempo{3}), y conclusión, \tiempo{1}. Los gráficos y figuras imprescindibles son el círculo vicioso en forma reducida, el trilema financiero, los pilares, la jerarquía de acreedores, el fondo común frente a los nacionales y el reparto de riesgos. Lo que va en cajas grises, en notas y en los anexos es para las preguntas del tribunal.

## Material de trabajo

`_trabajo/`: `icex-3B44.txt` (OCR), `antiguo-3B46-2023.txt` y `a46.txt`, `afi-*.txt`, `cinco-presidentes.txt`, `notas-ub.md`, `notas-umc.md` (verificaciones de datos de 14/11/2026), `parte1-3.tex` (borradores), `canon-pendiente.md`.

## Listas en las notas al pie (15/11/2026)

Ninguna nota lo necesitaba.

## Comentarios de Víctor (19/11/2026)

- Anexo de competencias (arts. 2 a 6 TFUE): nuevo anexo «El reparto de competencias de la Unión» (anexo:competencias) antes del de test, con la figura común `graficos/competencias-ue.tex` (carga `latex/competencias-ue-base.tex`, idéntica en los 10 temas de la UE salvo el resaltado). Resaltado en este tema: el mercado interior (art. 4.2.a, base del art. 114) y la política monetaria del euro (por el art. 127.6, base del MUS). Remisión desde el «Ámbito» del código normativo único (con el art. 114 TFUE).
- **Estructura común de las políticas de la UE**: se aplica (la unión bancaria y la de mercados de capitales son 2 políticas de la Unión, cada una con su porqué, su base, su historia, sus piezas y lo que falta). El tema ya tenía los elementos; se han hecho visibles los que estaban implícitos, sin cambiar títulos de segundo nivel ni minutos (30):
  - *1. Relevancia*: introducción.
  - *2. Justificación*: a) teoría económica, I.2 (círculo vicioso banca-soberano y trilema financiero) y III.1 para la UMC (reparto de riesgos); b) delimitación de competencias, I.3 (mercado interior, art. 114, con la remisión al anexo) y, **nuevo**, en la entrada del bloque III para la UMC (competencia compartida; fiscalidad, insolvencia y pensiones nacionales; unanimidad para armonizar la fiscalidad, arts. 113 y 115); c) marco jurídico, I.3 (código normativo único: CRR/CRD, BRRD, DGSD) y la base de cada pilar en II; d) toma de decisiones: **viñeta nueva «Quién aprueba las normas»** en I.3 (procedimiento legislativo ordinario para el código; el MUS por unanimidad del Consejo, art. 127.6; el MUR por el art. 114 con el acuerdo intergubernamental del fondo) y, ya estaban, la gobernanza del MUS (no objeción) y la decisión de resolución en II.2. El párrafo «Quién lo completa» pasa a «Quién lo aprueba y quién lo completa», con rótulos en sus 3 viñetas.
  - *3. Evolución*: I.1 (de la crisis a la decisión de 2012, con la cronología) y III.2 (UMC 2015-2024).
  - *4. Articulación*: II (los 3 pilares).
  - *5. Retos de futuro*: II.2.2 (CMDI), II.3 (la garantía común de depósitos y el tratamiento de la deuda pública), III.3 (Unión de Ahorros e Inversiones) y la opinión de la conclusión.
  - Viñetas nuevas «El orden del bloque» en la entrada de I y frase de orden en la de III (por qué, evolución, qué queda).
  - Orden: la evolución (I.1, el origen) va antes que la justificación (I.2). Se mantiene: el origen hace de contexto y de motivo de las razones económicas; duda B44-11.
  - Páginas: cuerpo 26 → 26; anexos 3. Ficha sin cambios (lo nuevo son reglas de decisión que ya resume la ficha con el art. 127.6 y el Reglamento 1024/2013). `\tcefecha` a 19/11/2026.

### Dudas (19/11/2026)

- **B44-11. Orden de I.1 y I.2.** La fórmula común pone la justificación antes que la evolución; en el 3.B.44, I.1 (origen: la crisis y la decisión de 2012) va antes que I.2 (por qué una unión bancaria). Opciones: (a) dejarlo así, porque el origen es el contexto que da sentido a los modelos **[aplicada]**; (b) intercambiar I.1 y I.2 (cambia el orden de 2 títulos de segundo nivel, el esquema y la ficha).
- **B44-12. Modelos en el cuerpo de un tema institucional.** El cuerpo conserva 5 modelos (círculo vicioso, trilema, recapitalización interna, seguro común y reparto de riesgos), aunque CRITERIOS (14/11/2026) pide para los temas de la UE la idea en el cuerpo y el modelo en anexos. Opciones: (a) dejarlos hasta que Víctor lo pida **[aplicada]**; (b) llevarlos a anexos como en el 3.B.36 y el 3.B.37.
- Mapa de la exposición tras el esquema, en caja gris (figu:mapa-tema).
