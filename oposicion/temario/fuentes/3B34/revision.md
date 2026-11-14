# Revisión del 3.B.34 — La OMC. Los acuerdos distintos de los de mercancías

Revisión completa del 14/11/2026 (entrega 1: tema y ficha de repaso; sin vídeo), en el worktree `revision-temario-2`, en paralelo con los agentes de los 3.B.35 y 3.B.36. Fuente nueva en LaTeX (`3B34.tex`) a partir del Word original (`_trabajo/original.md`, el antiguo 3.B.35 de la versión de 2023), **redactada de nuevo**, coherente con el 3.B.33 (revisado el mismo día) y puesta al día a noviembre de 2026 con wto.org, la OCDE y la Comisión Europea. Las dudas se resuelven con la opción recomendada y se anotan como B34-NN (14/11/2026).

## 1. Resumen

- Tema completo en **3 apartados** con el patrón del original para cada acuerdo (delimitación e importancia, motivación económica, estructura, negociaciones, valoración y perspectivas): **I. El AGCS** (10′), **II. El Acuerdo sobre los ADPIC** (9′30″) y **III. Acuerdos plurilaterales y otros acuerdos** (7′); introducción 2′30″ y conclusión 1′. El bloque I del original («Marco jurídico y marco institucional de la OMC», copia del 3.B.33) desaparece como apartado: queda en la contextualización con una figura propia y la remisión al 3.B.33 (B34-01).
- **3 modelos** con la estructura rígida a)-e): los **modos de suministro con costes fijos regulatorios** (Helpman, Melitz y Yeaple, 2004, adaptado a modo 1/modo 3; Kox y Nordås, 2007), la **protección de la propiedad intelectual entre el Norte y el Sur** (Grossman y Lai, 2004, con un ejemplo lineal-cuadrático propio que reproduce sus resultados; Nordhaus, 1969, y Helpman, 1993) y la **preferencia nacional en la contratación pública** (Baldwin, 1970; Evenett y Hoekman, 2005). Cada uno con su gráfico y su `\funcionclave`.
- **10 gráficos y figuras nuevos** en TikZ/pgfplots: 4 de datos reales descargados (servicios por sector 2005-2025, OMC; STRI 2025 por sector, OCDE; cobros y pagos por propiedad intelectual 2025, OMC/Banco Mundial; partes del ACP 1996-2026, OMC), 4 teóricos (modos con costes fijos, Grossman-Lai, preferencia nacional, curva de la sonrisa) y 2 figuras (mapa de los acuerdos; los 4 modos con su peso TiSMoS). Sustituyen a las 17 imágenes del Word. 2 tablas (listas positivas y negativas; derechos del ADPIC y sus plazos).
- Datos a noviembre de 2026 (tabla del apartado 4): servicios 9,6 billones de $ en 2025 (+8 %, 27,5 % del total), prestados digitalmente 55 %, modos 35/8/56/1 % (2022); STRI 2025; propiedad intelectual 607.000 M$; ACP 22 partes y 49 miembros; ATI, ampliación, reglamentación nacional, comercio electrónico, IFD, art. 31 bis, decisión de la CM12, PMA, MEPC (ver tabla).
- PDF: 29 páginas de tema, 1 de anexos y 4 de bibliografía (34 en total); cante de 30′. Ficha de repaso de 4 páginas. `verificar-tema.py`: sin errores propios (los que quedan son del PDF, el HTML y el Word publicados antiguos, que no se regeneran con `--no-publicar`).

## 2. Errores corregidos

| Nº | Dónde (Word) | Decía | Dice ahora |
|---|---|---|---|
| E1 | Marco institucional | 164 miembros (17/02/2023) | 166 (remisión al 3.B.33) |
| E2 | Nota 7 | Mandato de la DG «terminará el 31 de agosto de 2025» | Se quita (organización en el 3.B.33, donde está al día: 2.º mandato desde el 1/9/2025) |
| E3 | Examen de políticas | 4 primeras potencias «cada 2 años», 16 siguientes «cada 4» | Cada 3, 5 y 7 años (desde 2019) |
| E4 | Órgano de solución de diferencias | Etapas en orden consulta → grupo especial → «solución» del Consejo General → apelación | Se remite al 3.B.33 (orden correcto: la apelación va antes del cumplimiento); aquí solo lo propio (represalias cruzadas, no infracción) |
| E5 | Importancia del AGCS | «permite reducir los costes de transporte» | Costes de transacción e incertidumbre (no de transporte) |
| E6 | Principios del GATS | «las reglas básicas que rigen el comercio de mercancías son», con la NMF ilustrada con aranceles a teléfonos móviles (notas 11 y 12) | Obligaciones del AGCS (servicios y proveedores); las notas del GATT se quitan |
| E7 | Principios del GATS, punto 10 | «Contratación pública: las autorizaciones que los proveedores extranjeros necesitan… sin demoras indebidas» | La contratación pública (art. XIII) está excluida de la NMF, el trato nacional y el acceso; la frase sobre autorizaciones es del art. VI (reglamentación nacional) |
| E8 | Excepciones del GATS | Art. XXIV del GATT con «arancel externo común» y 90 % del comercio, Croacia y los ajos, cláusula de habilitación | Art. V del AGCS: «cobertura sectorial sustancial» y eliminación en lo esencial de la discriminación (los aranceles no existen en servicios); lo del GATT queda en el 3.B.33 |
| E9 | Excepciones del GATS | «Cláusula de salvaguardia: autoriza … medidas de urgencia» | El art. X solo manda negociarla; nunca se acordó: no hay salvaguardia en servicios |
| E10 | Compromisos específicos | «el comercio de servicios se restringe exclusivamente con regulaciones» | Mayoritariamente regulaciones (discriminatorias o heterogéneas), que actúan como costes fijos |
| E11 | Nota 18 (listas) | La lista positiva «se compromete a liberalizar todo lo contenido en la lista. En una segunda fase, el socio … enumera excepciones» | Positiva: solo lo listado, con sus limitaciones; negativa: todo salvo reservas; mixta (TiSA) |
| E12 | Definición de servicio | «siguiendo la definición del 6MBP» | MBP6 del FMI (actividad que cambia el estado de quien lo recibe o facilita intercambios) |
| E13 | Alcance | Excepción cultural «defendida por Francia… finalmente quedó incluido» | Cubierto, pero sin compromisos de la UE y con exenciones de la NMF |
| E14 | Situación de las negociaciones | Moratoria del comercio electrónico «se amplió hasta la 13.ª Conferencia» y «es poco relevante» | Prorrogada en Abu Dabi hasta la CM14; expiró en Yaundé (marzo de 2026); situación posterior al día (III.2) |
| E15 | TiSA (en amarillo) | «se negocia en el seno de la OMC… incluye 23 miembros… podría multilateralizarse» | Se negoció fuera de la OMC (2013-2016), suspendido en noviembre de 2016 y no retomado |
| E16 | Motivación económica | «las empresas prestadoras de servicios son más productivas que aquellas que producen mercancías» | Se quita (no es un hecho general); se sustituye por la evidencia de exportadores de servicios más productivos (Breinlich y Criscuolo, 2011) y por las ganancias de los usuarios (Arnold, Javorcik y Mattoo, 2011) |
| E17 | Importancia del ADPIC | «la protección… reduce los costes de transporte» y falsificaciones «2,5 % del comercio» sin fecha | Sin transporte; falsificaciones 2,3 % (2021; OCDE y EUIPO, 2025) |
| E18 | Importancia del ADPIC | Sectores intensivos en PI «45 % del PIB» (Comisión Europea) | 47 % del PIB y casi el 30 % del empleo directo (EPO y EUIPO, 2022, datos de 2017-2019) |
| E19 | Patentes | «Productos peligrosos para los seres vivos o perjudiciales para el medioambiente» como no patentables | Exclusiones *facultativas* por orden público o moralidad (incluida la protección de la salud y el medio ambiente), no prohibición |
| E20 | Derechos de autor | «no protege los derechos morales» | Incorpora Berna salvo los derechos morales (el ADPIC no obliga a protegerlos; no dice que no se protejan) |
| E21 | Marcas | «Período de protección: sine die. Se puede renovar el registro cada 7 años» | Al menos 7 años, renovables indefinidamente |
| E22 | Dibujos y esquemas de trazado | Esquemas: «circuitos con corriente eléctrica» | Diseño de los circuitos integrados (10 años) |
| E23 | Indicaciones geográficas (nota 24) | «dentro de las indicaciones geográficas se incluyen las normas de origen» | Se quita: las normas de origen son otra cosa (3.B.33) |
| E24 | Historia (OMPI) | «agencia especializada de las Naciones Unidas creada en 1947» | Convenio de Estocolmo de 1967, en vigor en 1970, organismo especializado desde 1974 |
| E25 | Doha | Licencias obligatorias «no es necesario que sea en caso de emergencia»; «En 2005 se acordó que estas disposiciones pasaran a formar parte del TRIPS» | Libertad para fijar motivos y emergencias (Declaración de 2001); decisión de 2003 (párrafo 6), enmienda de 2005 y entrada en vigor del art. 31 bis el 23/1/2017 |
| E26 | Nota 29 | «En 2004 se acuerda…»; lista de «23 países desarrollados (entre ellos España)» | 30/8/2003; la lista de países que no usarán el sistema como importadores es de los desarrollados (la UE como tal), se recoge sin cifra |
| E27 | PMA | «hasta 2006, aunque eventualmente se ha prorrogado hasta 2034»; farmacéuticos «hasta el año 2033» | General hasta el 1/7/2034 (decisión de junio de 2021); productos farmacéuticos hasta el 1/1/2033 (2015) |
| E28 | Vacunas COVID-19 | Situación de 2021 («España lo rechaza…», Biden mayo de 2021) | Decisión de la CM12 (17/6/2022): solo vacunas, 5 años; no extensión a diagnósticos y tratamientos; caja gris con el debate |
| E29 | Contratación pública | «Fue creado en 1994 y revisado en 2014. Cuenta con 48 miembros» | Código de Tokio (1979), ACP de 1994 (en vigor en 1996), revisado en 2012 (en vigor el 6/4/2014); 22 partes y 49 miembros |
| E30 | Contratación pública | «Permite mayor apertura y mayor transferencia» | Transparencia |
| E31 | Comercio y medio ambiente | EGA «27 países»; impuesto al carbono en frontera «la UE está valorando» | 46 miembros, suspendido en 2016; el MAFC ya existe (3.B.31 y 3.B.33); diálogos TESSD, plásticos y combustibles fósiles |
| E32 | Perspectivas del ADPIC | TPP con «11 países… sin China» como acuerdo «bilateral» | Tratado Integral y Progresista de Asociación Transpacífico, acuerdo regional (ADPIC-plus) |
| E33 | Conclusión | «declaración conjunta del G-20 en 2018» como idea final | Idea final nueva que responde a la pregunta del enganche |

## 3. Marcas resueltas

| Marca | Texto original | Qué se ha hecho |
|---|---|---|
| Nota al opositor (l. 1-4) | Aviso del cambio de temario de 2023 | Desaparece |
| Comentario | «Copiado del tema de Juan Luis todo. Ver tema de ICEX-CECO.» | No se publica; tema redactado de nuevo; los temas de preparadores solo de contraste |
| Comentarios de la introducción | Ronda de desarrollo, Kemp-Wan, 90 % del art. XXIV, enlaces de IPS y EFE, «posibilidad de empezar con…» | Lo del art. XXIV va al 3.B.33; el enlace de IPS (vacunas) se recoge con la decisión de la CM12; el enganche nuevo (refrán y moratoria digital) |
| Amarillo (introducción) | «Temas tan importantes como este… En esta exposición… Para ello vamos a empezar por explicar qué es la OMC» | Resuelto: contextualización con los anexos y la remisión al 3.B.33 |
| Comentarios «Coordinar en temas 3.B.33 y 3.B.34», «mencionar rápidamente», «Juan Luis lo menciona en un subapartado» | — | Resuelto: el marco jurídico e institucional se queda en el 3.B.33; aquí una figura y 2 líneas (B34-01) |
| Comentario «Importante recordar la estructura organizativa» | — | Mencionada en una línea (consejos de Servicios y ADPIC) con remisión |
| Comentario «Posiblemente mejor llevarlo después a los acuerdos plurilaterales del final» | Iniciativas de servicios | Hecho: ACP en III.1; TiSA y reglamentación nacional en I.4 (son de servicios) |
| Amarillo (TiSA, 2 párrafos, uno en inglés) | TiSA «se negocia… 23 miembros» | Corregido (E15) y en castellano |
| Amarillo (nota 18) | TiSA con lista mixta | Recogido en la tabla de listas |
| Apartados vacíos | Adquisición y mantenimiento; Prevención y solución de diferencias; Disposiciones institucionales; Relevancia, Extensiones y Opinión de la conclusión; Anexo 1 | Las partes del ADPIC sin contenido se nombran en la estructura; lo de diferencias va a III.3; conclusión completa; el anexo vacío se quita |
| Frase en inglés | «Los derechos de propiedad intelectual are far from the most pressing…» | Integrada en castellano en la caja de las vacunas |
| Imágenes 1-6 y de notas | Capturas de la OMC, Wikipedia, blogs (Feás, Diario del exportador) | Sustituidas por figuras y gráficos propios (mapa, modos, sonrisa, servicios por sector); el mapa de miembros de Wikipedia y el logo se quitan |
| Enlace de test | quia.com | Caja estándar del simulador (`tema=3.B.34`) |
| Bibliografía | Temas de ICEX-CECO y J. L. Cordero Tarifa, wto.org | Los temas de preparadores no se citan (CRITERIOS §5); obras originales y fuentes oficiales |
| Enlaces del original | trade.ec.europa.eu (listas), ec.europa.eu/trade (TiSA), wto.org (ADPIC), oepm.es (licencias), blognewdeal.com, diariodelexportador.com | Conservados los oficiales en el .bib (`CE2016Listas`, `CE2026TiSA`, `OMC1994ADPIC`); el de la OEPM no se cita (la explicación de la licencia obligatoria está en el texto y el art. 31); los de blogs se sustituyen por los gráficos propios (Feás, curva de la sonrisa → Baldwin, 2016) |

## 4. Datos actualizados

Todos consultados el 14/11/2026.

Primera fuente: wto.org (páginas, notas de prensa, textos jurídicos y ficheros de datos de descarga masiva), OCDE (SDMX) y Banco Mundial; segunda comprobación indicada. Detalle de la comprobación en el scratchpad de la sesión (`b34-hechos.md`).

| Dato | Antes (Word) | Ahora | Fuente | Segunda comprobación |
|---|---|---|---|---|
| Servicios comerciales mundiales | «más de un 20 %» (Informe anual 2019) | 9.594 mil M$ en 2025 (+8,4 %), 27,5 % de bienes y servicios comerciales (20,7 % en 2005) | OMC, conjunto anual WTO-UNCTAD-ITC (ITS_CS_AX6) | Global Trade Outlook, marzo de 2026: 9,56 billones (+8 %) |
| Servicios prestados digitalmente | — | 5.274 mil M$ (2025), 55 % de los servicios | OMC, fichero de servicios digitales | GTOS 2026: 5,26 billones (+10 %) |
| Modos de suministro | «el modo 3 es el más importante» | 2022: M1 34,7 %, M2 8,0 %, M3 56,1 %, M4 1,2 % (2005: 26,1/11,3/60,3/2,3) | OMC, TiSMoS | CRIT-IIFT, Policy Brief 17; WTR 2019 (58,9 % en 2017) |
| Peso en valor añadido | 49,8 % (TiVA) | «casi la mitad» | OCDE, TiVA 2025 | — |
| STRI | — | 2025: aéreo 0,400; jurídicos 0,348; contabilidad 0,325; distribución 0,196; España 0,142 (2.ª más abierta) | OCDE, SDMX DF_STRI_MAIN | Nota de prensa OCDE, feb. 2026 (cualitativa) |
| Propiedad intelectual | «45 % del PIB» de la UE | Cobros mundiales 606,8 mil M$ (2025); EE. UU. saldo +133,9; Irlanda −190,6; UE 47 % del PIB (2017-2019) | OMC (producto SH); EPO y EUIPO (2022) | Banco Mundial WDI (BX/BM.GSR.ROYL.CD), salvo Países Bajos (B34-07) |
| Falsificaciones | 2,5 % del comercio | 2,3 % (2021); 4,7 % de las importaciones de la UE | OCDE y EUIPO (2025) | — |
| 4.º y 5.º Protocolos | — | Telecom.: en vigor 5/2/1998, 69 gobiernos, >91 % de los ingresos; Documento de Referencia: 107 miembros. Finanzas: en vigor 1/3/1999, 70 miembros (56 listas) | OMC, telecom_results_e; news98 fsfor | — |
| Exención de servicios PMA | Nairobi la prorrogó | WT/L/847 (2011), hasta finales de 2030; >50 miembros notificantes | OMC, ldc_mods_negs_e | WT/L/982 |
| Reglamentación nacional | Grupo de trabajo de 1999 | 67 (2/12/2021); en vigor desde feb. 2024; 73 participantes, rige para 57 y 6 certificados | OMC, jsdomreg_e | Notas de prensa 2021-2024 |
| TiSA | «se negocia… 23 miembros» | 23 partes (50 países), 2013-2016, suspendido | Fuentes secundarias (páginas de la Comisión con error 404) | — |
| Art. 31 bis | — | En vigor 23/1/2017; 142 aceptaciones (última, Kazajistán, 3/9/2026); plazo hasta 31/12/2027 | OMC, amendment_e | WT/L/1228 |
| Decisión CM12 | Situación de 2021 | Solo vacunas, 5 años; extensión no acordada (dic. 2022; feb. 2024); ningún uso (Consejo ADPIC, 22/7/2026) | OMC, notas de prensa trip_15dec22, trip_13feb24, trip_22jul26 | — |
| Transición PMA (ADPIC) | «prorrogado hasta 2034»; farmacéuticos 2033 | General 1/7/2034 (IP/C/88, 2021); farmacéuticos 1/1/2033 | OMC, trips_e/ldc_e | — |
| No infracción ADPIC | — | Moratoria expirada el 30/3/2026 | OMC, trip_24apr26 | 3.B.33 |
| ACP | 48 miembros; 1,7 billones | 22 partes, 49 miembros; >1,7 billones al año; 39 observadores, 12 negociando; Macedonia del Norte 30/10/2023 | OMC, memobs_e y gp_gpa_e | Serie reconstruida con las cifras históricas de la OMC (20/48 en 2019; 21/48 en 2021) |
| ATI | — | 84 participantes, 97 %; ampliación de 16/12/2015: 24 participantes (53 miembros), 90 % del comercio, 201 productos, >1,3 billones, recortes desde 1/7/2016 en 5-7 años | OMC, inftec_e e itabriefingnotes | 3.B.33 |
| Comercio electrónico | Moratoria hasta la CM13 | Moratoria expirada (30/3/2026); 19 miembros sin derechos entre sí desde 8/5/2026; ACE: texto cerrado en dic. 2024; 66 en Yaundé (hoy 68); vigor 30 días tras 45 aceptaciones; propuesta de la Comisión de 13/7/2026 | OMC, mc14_28mar26, gc_06may26, joint_statement_e | Legislative Observatory (2026/0191(NLE)) |
| IFD | — | 131 participantes (94 en desarrollo, 29 PMA); 165 de 166 a favor en Yaundé | OMC, invfac_e, infac_30mar26 | 3.B.33 |
| MEPC | cada 2/4/7 años | 3/5/7 (desde 2019); UE: abril de 2023, siguiente 8 y 10/12/2026 | OMC, tprm_e; calendario de reuniones 2026 | — |
| OMPI | «creada en 1947» | Convenio de 1967, en vigor 1970, ONU 1974; tratado de 2024 no en vigor (4 de 15 ratificaciones) | OMPI | — |
| DS632 | — | UE-China, regalías mundiales de patentes esenciales: consultas 20/1/2025; grupo establecido 19/3/2026, compuesto 13/7/2026; arbitraje MPIA pactado | OMC, ds632_e | — |

## 5. Contenido añadido

- **3 modelos a)-e)** (I.2, II.2, III.1), con sus gráficos, funciones clave y evidencia empírica (Nordås y Rouzet, 2017; Breinlich y Criscuolo, 2011; Arnold, Javorcik y Mattoo, 2011; McCalman, 2001; Branstetter, Fisman y Foley, 2006; Kyle y McGahan, 2012; Herz y Varela-Irimia, 2020). Lo pedía el encargo.
- **Estructura del AGCS completa**: artículos (II, III, V, VI, VII, VIII-IX, XI, XII, XIV, XIV bis, XVI con las 6 limitaciones, XVII, XVIII), programa incorporado (X, XIII, XV), clasificación W/120, ejemplo de una casilla de una lista (caja gris), anexos sectoriales con los Protocolos 4.º y 5.º y el Documento de Referencia de telecomunicaciones.
- **ADPIC**: principios (incluido el agotamiento y las importaciones paralelas), excepción Bolar (DS114), licencias obligatorias (art. 31), IG reforzadas; art. 31 bis y su uso (Canadá-Ruanda); COVID-19 y la decisión de la CM12; tratado de la OMPI de 2024; reclamaciones sin infracción; ACTA y ADPIC-plus.
- **Bloque III nuevo**: ACP (historia, contenido, partes y adhesiones con gráfico), MIC (con las diferencias de energía renovable y DS623), IFD, ATI y su ampliación, moratoria y Acuerdo sobre Comercio Electrónico, reglamentación nacional, MEPC, represalias cruzadas, reforma y posición de la UE.
- **Notas Nobel**: Romer y Nordhaus (2018), con el motivo oficial (`Nobel2018Romer`, `Nobel2018Nordhaus`).
- **`\vertema` al 4.º ejercicio**: 4.A.7 (I+D y patentes), 4.A.8 (empresa de servicios), 4.A.12 (telecomunicaciones), 4.A.14 (comercio electrónico), 4.A.15 (competencia), 4.A.22 (servicios y cadenas de valor en España).
- **Material del disco D: usado**: «Temas a imprimir\10. Historia económica y organismos internacionales\Tema 3.B.35 - v.2023.pdf» y «Mis temas\Tema 3.B.35 - v.2 - 2024.docx» (idénticos en contenido al Word de partida; confirman la estructura); de la carpeta «Tema 3.B.35»: «3B-35.pdf» (tema de otro preparador, solo de contraste: clasificación W/120, 6 limitaciones del art. XVI, plazos del ADPIC), «B - Tema 35 v4.doc» y «3B-35_v3.doc» (vistos, sin texto legible sin antiword; no aportan); de la carpeta del antiguo 3.B.34: *The Oxford Handbook on the WTO* (capítulos de servicios y ADPIC, de contraste para la estructura del AGCS y la historia del ADPIC) y «Lecturas sobre la OMC a veinte años de su creación» (índice; capítulos de servicios y propiedad intelectual, de contraste). El tema de ICEX-CECO 3B34 y el «35-B.pdf» de CECO (escaneado, sin texto) no se usaron. Ninguno se cita (los preparadores no se citan; las cifras salen de fuentes oficiales).

## 6. Coherencia

- **3.B.33** (revisado hoy): mismas cifras y fechas: 166 miembros; CM14 en Yaundé (26-30/3/2026); expiran las moratorias digital y de reclamaciones sin infracción; 19 miembros sin aranceles digitales (mayo); IFD 131 y veto de la India; Comercio Electrónico 66 en Yaundé; ACP 22/49; ATI 84 participantes y 97 %, ampliado en 2015 a 201 productos; MPIA y DS611; reforma con 4 líneas (junio de 2026); MEPC 3/5/7 años; DS623. No se repite la organización ni el ESD; se remite con `\vertema{3.B.33}`.
- **3.B.18**: el modelo de servicios usa las rectas, los colores y la notación del gráfico `hmy` (copiado y adaptado a `servicios-modos-hmy.tex`), con $\Omega$ como factor de demanda.
- **3.B.6**: notación de Melitz del canon ($\varphi$, $\sigma$, $F^d$, $\tau$).
- **3.A.44**: Romer (1990) y la nota Nobel con el mismo texto que en los demás temas.
- **3.B.41**: el encargo decía que la política comercial común está en el 4.º ejercicio; en `temario.json` es el **3.B.41**, al que se remite (B34-02).
- Cambios propuestos al canon: `_trabajo/canon-pendiente.md` (3 fichas nuevas y símbolos locales).

## Comentarios de Víctor (reglas de la 9.ª tanda aplicadas, 14/11/2026)

| Regla | Cómo se ha aplicado |
|---|---|
| Estructura rígida de modelo | 3 modelos con a) Idea, b) Modelo (i-iii), c) Extensiones, d) Evidencia empírica, e) Valoración |
| Sin citas Harvard | Solo `\nocite` y `\textcite` de obras originales; ningún `\parencite` |
| Nunca citar a Víctor | Ninguna entrada suya; gráficos «elaboración propia» |
| Ni «Pegatina» ni «Dicho» | No hay; el único refrán es el del enganche («ojos que no ven, corazón que no siente», no usado en otro tema), retomado en la idea final. El original no tenía refranes |
| Nobel con motivo oficial | Romer y Nordhaus (2018). Krugman no se nombra (se remite a la nueva teoría del comercio); Helpman, Grossman, Melitz, Baldwin no son Nobel |
| `\vertema` al 4.º ejercicio | 4.A.7, 4.A.8, 4.A.12, 4.A.14, 4.A.15, 4.A.22 |
| Resultados clave en morado | `eq:umbrales-servicios`, `eq:grossman-lai`, `eq:neutralidad` con `\funcionclave` |
| Pasos con sangría | Desarrollos por pasos en sublistas |
| Cajas grises | Notación; umbrales paso a paso; una casilla de una lista; el debate de las vacunas; otras iniciativas |
| Ejemplos sin nombres propios | Sí (el Norte y el Sur, un miembro, un fabricante de genéricos) |
| Sin remisiones vacías | Cada `\vertema` tras la idea completa; lo del 3.B.33 se resume antes de remitir |
| Inglés entre paréntesis la primera vez | *proximity-concentration trade-off*, *prudential carve-out*, *know-how*; siglas inglesas GATS, TRIPS, TRIMs, ITA, TiSA, STRI, TiSMoS |
| Anexo de test | Caja estándar con `tema=3.B.34` |
| Sin páginas en blanco ni desbordes | Comprobado en el PDF de `_trabajo/` |

## 7. Dudas abiertas

Todas aplicadas con la opción recomendada (14/11/2026); para que Víctor las confirme.

- **B34-01** El bloque I del original («Marco jurídico y marco institucional de la OMC») era una copia del 3.B.33 y el tema tendría 4 apartados. Opciones: (a) quitarlo como apartado y dejarlo en la contextualización con una figura propia y la remisión al 3.B.33 **[aplicada]**; (b) mantenerlo como I y fundir II y III del original.
- **B34-02** El encargo situaba la política comercial común de la UE en el 4.º ejercicio; en `temario.json` es el 3.B.41. Opciones: (a) remitir al 3.B.41 **[aplicada]**; (b) remitir a algún tema del 4.º (no hay uno de política comercial de la UE).
- **B34-03** El modelo de Grossman y Lai se cuenta con un ejemplo lineal-cuadrático propio (beneficio $b$, pérdida irrecuperable $d$, excedente $v$, $n=\kappa b\bar T$) que reproduce sus 3 resultados (poca protección sin acuerdo, el Norte protege más, la eficiencia no exige armonizar) pero no es su modelo general. Opciones: (a) así, avisado en el texto **[aplicada]**; (b) solo de palabra.
- **B34-04** El modelo de los servicios es la adaptación de Helpman, Melitz y Yeaple (2004) con costes fijos regulatorios (la idea es de Kox y Nordås, 2007, y Francois y Hoekman, 2010; la formalización con los modos 1 y 3 es propia). Opciones: (a) así **[aplicada]**; (b) contarlo solo de palabra con remisión al 3.B.18.
- **B34-05** El STRI de la OCDE tiene 22 sectores, pero su base de datos SDMX solo publica 18 (faltan arquitectura, ingeniería, transitarios y agentes de aduanas); el gráfico usa los 18 y lo dice. Las cifras de la publicación de la OCDE no se pudieron descargar (403) para el cotejo numérico; cotejo cualitativo con su nota de prensa de febrero de 2026.
- **B34-06** Modos de suministro: la base TiSMoS de la OMC llega solo a 2022 (56 % el modo 3, 35 % el modo 1). Opciones: (a) usar 2022 **[aplicada]**; (b) aproximar el modo 1 con los servicios prestados digitalmente de 2025.
- **B34-07** Cobros por propiedad intelectual de los Países Bajos: 47,2 mil M$ en la OMC y 67,4 en el WDI del Banco Mundial (el resto cuadra). Se usa la OMC, que es la serie del gráfico. Ninguna acción.
- **B34-08** Exámenes de políticas comerciales cada 3 años: la página de la OMC lista ahora a la UE, Estados Unidos, China y el **Reino Unido** (el 3.B.33 dice Japón). Se aplica lo de la OMC en este tema y se anota para el 3.B.33 en `canon-pendiente.md`. Opciones: (a) así **[aplicada]**; (b) mantener Japón como en el 3.B.33.
- **B34-09** IFD en Yaundé: la OMC no nombra a quien bloqueó (dice que 165 de 166 miembros apoyaron incorporarlo); el 3.B.33 dice «veto de la India». Aquí: «con el apoyo de 165 de los 166 miembros, siguió sin consenso» y, en la ficha, «la India, según la prensa». Ninguna acción.
- **B34-10** Acuerdo sobre Comercio Electrónico: 66 miembros en el comunicado de Yaundé y 68 hoy; se dan las 2 cifras. Ninguna acción.
- **B34-11** Las 4 líneas de la reforma de junio de 2026 salieron de una reunión de jefes de delegación del 26/6, no de un Consejo General (como dice el 3.B.33): aquí «abiertas en junio de 2026». Anotado para el 3.B.33.
- **B34-12** No se ha podido comprobar el número total de exámenes de políticas comerciales (recuento propio, unos 500) ni cuántas aceptaciones del Acuerdo sobre Comercio Electrónico hay depositadas: no se dan cifras.

## 8. Instrucciones para el vídeo

- **Enganche e idea final**: «Ojos que no ven, corazón que no siente»; las partidas invisibles; la moratoria digital que expira en Yaundé (marzo de 2026); pregunta: ¿se pueden poner reglas a un comercio que no se ve? Idea final: sí, si antes se hace visible (listas, exámenes).
- **Introducción y conclusión, sin pizarra** (`modo: guion`); la figura `acuerdos-mapa` como apoyo al final de la introducción.
- **I.1**: la figura `modos-suministro` por capas en la pizarra (frontera y países; modo 1; 2; 3; 4), cada modo mientras se nombra; el gráfico `servicios-sector` como apoyo; la curva de la sonrisa en la pizarra (boceto: ejes, fases, curva de hoy).
- **I.2**: el modelo de los servicios en la pizarra con `servicios-modos-hmy` por capas (ejes; $B^d$; modo 1; modo 3 con su corte; grupos; la recta nueva al bajar $R^{\mathrm{M3}}$) y la función clave `eq:umbrales-servicios` recuadrada, que se conserva hasta el final del bloque I. El STRI, apoyo.
- **I.3-I.5**: de palabra; la tabla de listas, apoyo.
- **II.1**: `propiedad-intelectual` como apoyo.
- **II.2**: el modelo de Grossman y Lai en la pizarra: las 2 funciones de bienestar, luego `grossman-lai` por capas (ejes; $R_N$; $R_S$ y $E$; la recta eficiente; $H$ y $A$ con sus flechas) y la función clave `eq:grossman-lai`, que se conserva hasta el final del bloque II.
- **II.3-II.5**: la tabla de derechos, apoyo; la caja de las vacunas, de palabra.
- **III.1**: `acp-adhesiones`, apoyo; el modelo de Baldwin con `contratacion-sesgo` por capas (ejes; $S^d$; $p^*$; $G_1$; $G_2$, $p_g$ y el sobrecoste) y `eq:neutralidad`.
- **III.2-III.4**: de palabra.
- **Funciones clave que se conservan**: `eq:umbrales-servicios` (bloque I), `eq:grossman-lai` (bloque II), `eq:neutralidad` (III.1).
- Nunca se dice el número de un tema en voz alta.
