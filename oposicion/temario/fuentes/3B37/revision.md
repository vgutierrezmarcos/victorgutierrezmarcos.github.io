# Revisión del 3.B.37 — Las finanzas de la Unión Europea y el presupuesto comunitario. El marco financiero plurianual actual

Revisión completa del 14/11/2026 (entrega 1: tema y ficha de repaso; sin vídeo), en el worktree `revision-temario-2`, en paralelo con los agentes de los 3.B.38 y 3.B.39. Fuente nueva en LaTeX (`3B37.tex`) a partir del Word original (`_trabajo/original.md`, el antiguo 3.B.38 de la versión de 2023), **redactada de nuevo** y puesta al día a noviembre de 2026 con fuentes oficiales (EUR-Lex, Comisión, Consejo, Parlamento y EPRS, Tribunal de Cuentas, Fiscalía Europea, OLAF, Eurostat, Gobierno de España y Ministerio de Hacienda). Las dudas se resuelven con la opción recomendada y se anotan como B37-NN (14/11/2026).

## 1. Resumen

- Se mantienen los 3 bloques del original y sus títulos de segundo nivel: **I. Actividad presupuestaria: la constitución financiera** (I.1 textos; I.2 Tratados y Reglamento financiero: principios y ciclo; I.3 ingresos: Decisión de recursos propios; I.4 gastos: el MFP), **II. Actividad presupuestaria: aproximación descriptiva** (II.1 evolución histórica; II.2 el presupuesto actual: MFP 2021-2027, revisión de 2024, presupuesto de 2026, saldos netos; **II.3 nuevo: la propuesta 2028-2034**) y **III. Actividad extrapresupuestaria** (III.1 instrumentos especiales; III.2 préstamos, endeudamiento y estabilización; III.3 NextGenerationEU). Reparto: introducción 2′30″, I 8′30″, II 9′, III 9′, conclusión 1′.
- 3 modelos nuevos con la estructura rígida a)-e): **bienes públicos europeos** (federalismo fiscal, Samuelson/Bowen entre Estados, `eq:samuelson-ue`), **justo retorno** (el presupuesto como negociación por unanimidad, `eq:justo-retorno`) y **sostenibilidad de la deuda común** (carga de la deuda del NGEU, `eq:carga-ngeu`, con simulación 2028-2058).
- 11 gráficos y figuras propios en TikZ/pgfplots que sustituyen a las 22 imágenes del Word (capturas del Consejo, del PE, de Camarero et al., de Statista y del PIIE): 6 de datos (ingresos 1970-2025, gastos 2000-2025, MFP y NGEU por rúbricas, saldos netos 2025, MRR por Estados, deuda del NGEU), 2 teóricos (bienes públicos, justo retorno) y 3 figuras (constitución financiera, procedimiento del art. 314, propuesta 2028-2034). 2 tablas (etapas históricas; instrumentos de préstamo).
- PDF: 33 páginas de tema, 2 de anexos (balanzas presupuestarias; base jurídica del NGEU; test) y 4 de bibliografía. Ficha de repaso: 4 páginas a 10,5 pt (última, 84 %). `verificar-tema.py` (envoltorio sobre `_trabajo/`): sin errores propios; los 11 «imagen inexistente en el HTML» son el efecto conocido de verificar en `_trabajo/` (rutas relativas) y desaparecen al publicar; quedan avisos de «cifra sin cita» (párrafos cuyo dato se cita en el párrafo vecino o en el gráfico) y los del vídeo (entrega 3).

## 2. Errores corregidos

| Id | Dónde (Word) | Decía | Dice ahora |
|---|---|---|---|
| E1 | Introducción | El proceso de integración «tiene su origen en el Tratado de Roma en 1957»; UEM «para 20» | Se quita la historia general (está en el 3.B.36); la UEM tiene 21 Estados desde 2026 |
| E2 | Nota 2 | Tratado de Lisboa «(2007)» suprime la Comunidad | En vigor en 2009 |
| E3 | Principios | Rige el Reglamento financiero de 2018 | Refundición 2024/2509, aplicable desde el 30/9/2024 |
| E4 | Control (TCE) | Informes anuales «referidos al período t − 2» | Al ejercicio anterior (t − 1); el descargo es el de t − 2 |
| E5 | Nota 11 | Definición de «empréstito» como nota del principio de anualidad | Se quita (no viene a cuento); créditos de compromiso y de pago y RAL (501.100 M€ en 2025) |
| E6 | Recursos propios | «Más del 90 %» con recursos propios; techo «1,4 %» sin el 1,46 % de compromisos | Techos 1,40 % (pagos) y 1,46 % (compromisos) + 0,6 temporal; estructura de 2025 y 2026 con cifras oficiales |
| E7 | Ingresos | Porcentajes de 2021 (RPT 15 %, IVA 12 %, RNB 72 %) | 2025: RPT 15 %, IVA 15 %, RNB 65 %, plástico 4 % de los recursos propios; 2026: RNB 70 % |
| E8 | Nota 30 | Tipo reducido de IVA para Alemania, Países Bajos y Suecia (0,15 %) en 2021-2027 | Eso era 2014-2020; en 2021-2027, reducciones a tanto alzado de la RNB para DK, DE, NL, AT, SE (377, 3.671, 1.921, 565 y 1.069 M€ de 2020) |
| E9 | Nuevos recursos | CBAM «se mantiene 3 años hasta su entrada definitiva en 2026» (amarillo); impuesto digital y BICCIS como propuestas vigentes | Periodo definitivo desde el 1/1/2026, certificados desde febrero de 2027; propuestas de 2021, 2023 y 2025 con su estado (ninguna aprobada) |
| E10 | Proceso del MFP | Parlamento «puede aprobar o rechazar la posición del Consejo» | Aprueba (consentimiento) el reglamento; no lo enmienda; prórroga del último año si no hay acuerdo (art. 312.4) |
| E11 | MFP 2014-2020 | «El tipo de referencia de los recursos IVA… 0,15 %» como cambio de 2014 | Se integra en la tabla de etapas con lo correcto |
| E12 | MEEF | «hasta 60 millones de euros» | 60.000 millones |
| E13 | MEDE | Capacidad de préstamo de 410.000 millones; capital de 700.000 | 500.000 millones de capacidad; detalle con remisión al 3.B.45 |
| E14 | NGEU | «Reembolsables en 2058» con 3 posibilidades «en el aire» | Devolución 2028-2058 con máximo anual del 7,5 % de 390.000 M€; las 3 vías se analizan en el modelo de la deuda |
| E15 | NGEU | MRR de 672.500 M€ (2018) | 723.800 M€ corrientes al inicio; 573.000 tras las renuncias a préstamos (360.000 + 213.000) |
| E16 | España | «140.000 millones del MRR y 12.000 de REACT-EU»; «Garicano: ejecución muy baja» | Plan final de 102.000 M€ tras el recorte de préstamos (dic. 2025); 77.600 M€ recibidos; 7.º pago pedido |
| E17 | Fiscalía Europea (nota 16) | «Se creó en 2021» | Funciona desde junio de 2021; 25 Estados; cifras de 2025 |
| E18 | Rúbricas | Importes de la infografía de 2020 (con NGEU incluido en cada rúbrica) | Techos tras la revisión de 2024 en precios corrientes y NGEU aparte |

## 3. Marcas resueltas

| Marca | Texto original | Qué se ha hecho |
|---|---|---|
| Notas al opositor (cambio de temario) y captura | — | Desaparecen |
| Comentario «faltaría desarrollar mejor la actividad extrapresupuestaria» | — | III reescrito: base jurídica del endeudamiento, tabla de instrumentos, SURE, SAFE, Ucrania (préstamo de 90.000 M€), BEI, financiación unificada |
| Comentario de Ángel: «¿puede endeudarse la UE?» | — | Resuelto en III.2.1 y en el anexo B (no para el presupuesto; sí para prestar y, con la DRP, para gastar) |
| Comentarios con enlaces (Draghi en prensa, nota de otro preparador) | — | No se publican |
| Caja de anotaciones «Flujos financieros España-UE» (PGE 2022) | Enlace | Sustituido por la publicación vigente de Hacienda (`Hacienda2026RelacionesFinancieras`) y los datos de la Comisión |
| Amarillo CBAM | «comienza a aplicarse en octubre de 2023…» | Actualizado (definitivo desde 2026) |
| Amarillo MEDE (financiación, BCE y C-62/14) | — | Resumido: el MEDE es intergubernamental y su detalle va al 3.B.45 |
| Amarillo SURE (base jurídica, financiación, valoración, ERTE) | — | Integrado en III.2.2 (art. 122, garantías del 25 %, 98.400 M€, España 21.324); la valoración de los ERTE va al 3.B.45/4.A.29 |
| Amarillo nota 47 (base jurídica del art. 122) | — | Resuelto en el anexo B (dictamen del Servicio Jurídico del Consejo y sentencia del Tribunal Constitucional alemán de 2022) |
| Amarillo bibliografía («Anexo de los PGE», «Fichas del PE») | — | Citadas las fichas vigentes del PE y Hacienda |
| «Presupuesto comunitario de 2023 (actualizar)» con apartados vacíos | — | Presupuesto de 2026 (ingresos y gastos), ejecución de 2025 y acuerdo de 2027 |
| «Contribuyentes y receptores netos» vacío | — | II.2.4 con el gráfico de saldos 2025 y el modelo del justo retorno; anexo A con la metodología |
| «Instrumentos de asistencia a terceros países» vacío | — | Ayuda macrofinanciera y Ucrania |
| Extensiones y Opinión vacías (conclusión) | — | Escritas |
| Imágenes 1-11, Cuadro A1 y anexo 2 (infografías del Consejo) | Capturas | Rehechas en TikZ o tablas; el anexo 2 se sustituye por el anexo B |
| Enlace de test | quia.com | Caja estándar del simulador (`tema=3.B.37`) |
| Reglas mnemotécnicas | «la Unión Europea forma una unión aduanera…»; «Mi colega Renato…» | Se conservan |
| Cita de Thatcher (nota 19) | — | Se conserva como nota |

## 4. Datos actualizados

Todos consultados el 14/11/2026. [PR] = solo prensa.

| Dato | Antes | Ahora | Fuente | Segunda comprobación |
|---|---|---|---|---|
| MFP 2021-2027 | 1.074.300 M€ (2018) | + 1.225.900 corrientes tras 2024; rúbricas | COM(2026) 299; Comisión | Ficha del PE (nov. 2025) |
| Revisión intermedia | — | 64.600 M€; Ucrania 50.000; STEP; EURI | Reglamento 2024/765; OEIL | Ficha del PE |
| Presupuesto 2026 | 2023 vacío | 192.768 / 190.092 M€; ingresos | DO L 2026/72 | OEIL (conciliación 15/11/2025) |
| Presupuesto 2027 | — | Acuerdo de conciliación 199.708 / 211.520 M€ | Comisión IP/26/2385 | Nota del Consejo (11/11/2026) |
| Ejecución 2025 y RAL | — | 155.200 / 216.400 M€; RAL 501.100 | TCE, informe anual 2025 | Excel de la Comisión |
| Ingresos 1970-2025 | Camarero (1980-2017) | Serie completa | Comisión: Financial Report 2008 y Excel 2000-2025 | Coinciden en 2000-2007 |
| Saldos netos | Camarero (1997-2017) | 2025 por Estado (cálculo propio) | Excel de la Comisión | Orden de magnitud igual que Statista para 2023 (B37-03) |
| Nuevos recursos | 2021 | 2025: 5 recursos, 58.500 M€/año; ninguno aprobado | TCE, dictamen 04/2026 | Ficha del PE, EPRS |
| MFP 2028-2034 | — | Propuesta y negociación (PE 28/4/2026; caja irlandesa 10/10/2026; cumbre 26-27/11) | EPRS (4/11/2026) | Comisión; prensa para cifras de la caja [PR] |
| Control | — | TCE: error 3,8 %, desfavorable; EPPO 3.602 / 67.270 M€; OLAF | TCE; EPPO; OLAF | — |
| Hungría | — | Levantamiento propuesto (23/9/2026) y aprobado (oct. 2026) | Comisión IP/26/1941 | Decisión 2026/2324 [PR] (B37-05) |
| MRR | 672.500 (2018) | 573.000; 450.000 pagados (1/10/2026); 68 % de hitos | Informe anual del MRR COM(2026) 546 | Página del NGEU |
| Deuda de la UE | — | 836.800 M€ (30/6/2026); ≈875.000 (nov.); coste 3,32 % | Informe semestral de endeudamiento | IP/26/2384 |
| España PRTR | 140.000 | Plan 102.000; 77.600 recibidos; 7.º pago 25.861 | planderecuperacion.gob.es | Página de la Comisión |
| MRR por países | — | Recibido 2020-2025, % PIB | Eurostat gov_rrf_fa | Total de subvenciones igual al del informe anual |
| SAFE | — | 150.000 M€; España 1.000 | DO (Decisión 2026/370) | DG DEFIS |
| Préstamo a Ucrania | — | 90.000 M€ (Reglamento 2026/467) | EPRS BRI(2026)782649 | Prensa |

## 5. Contenido añadido

- **Constitución financiera** con la figura de los 4 textos y cómo se aprueba cada uno; **procedimiento del art. 314** en figura; doceavas partes; modos de gestión; control con TCE, descargo, OLAF, Fiscalía Europea y condicionalidad.
- **Margen de maniobra** como garantía de la deuda; nuevos recursos propios por tandas con su estado.
- **Modelo de los bienes públicos europeos** (I.4.2), con Nobel de Nash y Samuelson; evidencia de Alesina, Angeloni y Schuknecht (2005) y del informe Draghi (2024).
- **Tabla de etapas históricas** (1951-2027) y series de ingresos y gastos.
- **Revisión intermedia de 2024**, presupuesto de 2026, acuerdo de 2027, **saldos netos de 2025** y **modelo del justo retorno** (Monti, 2016; Kauppi y Widgrén, 2004).
- **II.3 propuesta 2028-2034** y su negociación a noviembre de 2026.
- **III**: base jurídica del endeudamiento, financiación unificada, SURE, SAFE, Ucrania, FEAP; NGEU en 6 rasgos (los del original), MRR, financiación y España; **modelo de la sostenibilidad de la deuda común** con simulación propia (`datos/deuda-ngeu.py`), extensión de Hamilton y Sargent (Nobel 2011).
- Anexos: A (balanzas presupuestarias: metodología, límites y evolución, a partir del anexo 1 del original) y B (base jurídica del NGEU, a partir de la nota 47).
- **Material del disco D: usado**: «Temas a imprimir\11. Unión Europea\Tema 3.B.38 - v.2023.pdf» y «Mis temas\Tema 3.B.38 - v.2 - 2024.docx» (mismo contenido que el Word de partida, comprobado por palabras y títulos); «European Union public finance 5th ed.» (Comisión, 2014; citada para la tabla de etapas y los techos históricos); los 2 documentos de Ángel (Boletín ICE 3127 y revista ICE 916, de 2020; desactualizados, solo de contraste); `flujos.xls` (antiguo; sustituido por los datos de Hacienda y de la Comisión). No se usaron los temas de otros preparadores ni el de ICEX-CECO.

## 6. Coherencia

- **3.B.36**: el art. 314 se cuenta aquí como procedimiento y allí como competencia; mismas cifras (Tribunal de Cuentas, Fiscalía Europea con 25 Estados, MEDE de 500.000 M€). Remisión \vertema{3.B.36} en I.2 y en el modelo de Oates.
- **Fronteras**: PAC (\vertema{3.B.38}) y cohesión (\vertema{3.B.40}) solo como peso en el gasto; MEDE, SURE como respuesta fiscal y NGEU como política fiscal común, con remisión al \vertema{3.B.45}; NGEU como instrumento de financiación, aquí (canon: `next-generation-eu`). MAFC: resumen con remisión al \vertema{3.B.31}. Europa Global: \vertema{3.B.42}. BEI: \vertema{3.B.30}.
- **4.º ejercicio**: \vertema{4.A.30} (relaciones financieras España-UE), \vertema{4.A.29} (PRTR), \vertema{4.B.14} (federalismo fiscal), \vertema{4.B.21} (principios presupuestarios en España).
- Propuestas al canon en `_trabajo/canon-pendiente.md` (fichas `mfp`, `recursos-propios-ue`, `next-generation-eu`; 3 modelos nuevos).

## Reglas de las tandas 8.ª y 9.ª y transversal (aplicadas, 14/11/2026)

| Regla | Cómo se ha aplicado |
|---|---|
| Estructura rígida de modelo | 3 modelos con a) Idea, b) Modelo (i-iii), c) Extensiones, d) Evidencia empírica, e) Valoración |
| Sin citas Harvard | Solo `\nocite` y `\textcite` de obras originales |
| Nunca citar a Víctor | Ninguna entrada suya; gráficos «elaboración propia» |
| Ni «Pegatina» ni «Dicho» | Un solo refrán, el del enganche («Cuentas claras, amistades largas», no usado en otro tema), retomado en la idea final |
| Nobel con motivo oficial | Nash (1994), Samuelson (1970), Sargent (2011), con las notas de otros temas |
| `\vertema` al 4.º ejercicio | 4.A.29, 4.A.30, 4.B.14, 4.B.21 |
| Resultados clave en morado | `eq:samuelson-ue`, `eq:justo-retorno`, `eq:carga-ngeu` con `\funcionclave` |
| Pasos con sangría | Desarrollos por pasos en sublistas |
| Cajas grises | Notación y siglas; el NGEU en el presupuesto; test |
| Ejemplos sin nombres propios | Estados $i$, «un gobierno» |
| Inglés entre paréntesis | *headroom*, *reste à liquider*, *free riders*, *juste retour*, *back-to-back* |
| Anexo de test | Caja estándar con `tema=3.B.37` |
| Sin páginas en blanco ni desbordes | Comprobado con `verificar-tema.py` sobre `_trabajo/` |

## 7. Dudas abiertas

Todas aplicadas con la opción recomendada (14/11/2026); para que Víctor las confirme.

- **B37-01** Títulos de primer nivel: el original decía «Actividad presupuestaria (I)» y «(II)»; los números romanos entre paréntesis chocan con la comprobación de remisiones escritas a mano. Opciones: (a) «Actividad presupuestaria: la constitución financiera» y «…: aproximación descriptiva» **[aplicada]**; (b) recuperar (I) y (II) y aceptar el aviso.
- **B37-02** Refrán del enganche: «Cuentas claras, amistades largas» (no usado en otro tema; enlaza con los saldos netos y el justo retorno). Opciones: (a) mantenerlo **[aplicada]**; (b) «Quien paga, manda».
- **B37-03** Saldos netos: la Comisión ya no publica el saldo operativo en su Excel de 2000-2025; se ha calculado con su metodología tradicional (elaboración propia). Para 2023 sale Alemania −17.400 M€ frente a −15.800 de otras fuentes; Luxemburgo aparece como receptor neto (+0,9 % de la RNB), lo que conviene revisar (probablemente gasto de agencias asignado allí). Opciones: (a) usarlo, avisando en la fuente **[aplicada]**; (b) quitar el gráfico y dar solo cifras de Hacienda para España.
- **B37-04** MRR por países: el cuadro de indicadores de la Comisión solo da los datos en su panel interactivo; el gráfico usa lo recibido 2020-2025 según Eurostat (sin los pagos de 2026 ni las asignaciones). Opciones: (a) así **[aplicada]**; (b) rehacerlo en 2027 con el cierre del MRR.
- **B37-05** Datos que solo se han visto en prensa: la decisión del Consejo que levanta las medidas a Hungría (octubre de 2026), las cifras de la caja de negociación irlandesa por rúbricas y la fecha de las elecciones españolas citada por la prensa (no usada). Comprobar en la próxima pasada.
- **B37-06** La simulación de la deuda del NGEU (gráfico `deuda-ngeu`) es propia: amortización lineal 2028-2058, $D_0$ = 421.000 M€ (parte no reembolsable), $i$ = 3,3 %, crecimiento nominal del 3,5 %. No hay calendario oficial; la Comisión estima el 0,11 % de la RNB en 2028-2034. Opciones: (a) así **[aplicada]**; (b) dar solo la cifra de la Comisión.
- **B37-07** El MFP 2028-2034 se decidirá (o no) en la cumbre del 26-27/11/2026, días después de esta revisión: el tema dice «en noviembre de 2026» y está registrado en `datos-actualizables.yaml` para actualizar.
- **B37-08** Becker, Egger y von Ehrlich (2010): «+1,6 puntos de crecimiento al año» en las regiones de objetivo 1, de memoria del artículo (no releído hoy). Comprobar.

## 8. Instrucciones para el vídeo

- **Enganche e idea final**: «Cuentas claras, amistades largas»; la Comisión publica los saldos de cada Estado y, aun así, el MFP 2028-2034 sigue sin acuerdo. Idea final: las cuentas claras miden lo que vuelve a cada socio; la amistad será larga si se mira lo que solo se consigue juntos.
- **Introducción y conclusión, sin pizarra** (`modo: guion`).
- **I**: `constitucion-financiera` en la pizarra por capas (un texto por capa); `procedimiento-presupuestario` como apoyo; `ingresos-composicion` como apoyo; el modelo de los bienes públicos en la pizarra: `bienes-publicos-europeos` por capas (ejes; $c$; BMg de un Estado y $G^{\mathrm N}$; suma vertical y $G^*$; triángulo) y la función clave `eq:samuelson-ue`, que se conserva hasta el final del bloque II.
- **II**: `gastos-evolucion` y `mfp-2021-2027` como apoyo; `saldos-netos` como apoyo; el justo retorno en la pizarra: `eq:justo-retorno` y el gráfico `justo-retorno` por capas (ejes; ganancia real; ganancia percibida; brecha); `mfp-2028-2034` como apoyo que se va completando.
- **III**: tabla de instrumentos como apoyo; `mrr-paises` como apoyo; la deuda común en la pizarra: `eq:carga-ngeu` y `deuda-ngeu` por capas (área de la deuda; línea de la carga).
- **Funciones clave que se conservan**: `eq:samuelson-ue` (I.4-II), `eq:justo-retorno` (II.2-II.3), `eq:carga-ngeu` (III.3).
- Nunca se dice el número de un tema en voz alta.
