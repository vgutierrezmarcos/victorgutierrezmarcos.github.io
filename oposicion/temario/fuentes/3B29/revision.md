# 3.B.29 — Informe de revisión (12/11/2026)

«La financiación exterior del desarrollo económico. El problema de la deuda externa. La ayuda al desarrollo.»

## 1. Resumen

- Tema **sin original de Víctor**, escrito desde cero (fase 3 en 2 partes) con la estructura de Miquel Tebar reordenada por los 3 epígrafes del título (CRITERIOS §5), contrastada con Andrea Cerezal (su «30B») y Luis de Fuentes (3B_30), y con las fichas del canon.
- I financiación exterior (8′30″: brecha de ahorro y 2 brechas, enfoque intertemporal en resumen, Lucas y puzle de la asignación, fuentes con tabla y gráfico de flujos); II deuda (9′: sostenibilidad con `eq:deuda-externa`, impago soberano, sobreendeudamiento y curva de Laffer de la deuda, crisis de 1982 a hoy, marco institucional); III ayuda (8′30″: concepto y medida, del 0,7 % a Sevilla, debate de la eficacia). Introducción 2′30″ y conclusión 1′30″: 30′.
- 5 gráficos (2 copiados del 3.B.12 y 3 nuevos: `flujos-desarrollo`, `laffer-deuda`, `aod-rnb`), 7 tablas, 2 funciones clave, 5 anexos (cronología, derivaciones, umbrales, temas, test).
- Datos al 12/11/2026: IDR 2026 del Banco Mundial (5/11/2026), AOD preliminar de 2025 de la OCDE (9/4/2026), lista del LIC DSF a 31/3/2026.
- Compila limpio (26 páginas de tema, 3 de anexos, 5 de bibliografía; 0 avisos de LaTeX y biber); N-gramas de 8 palabras frente a Tebar, Cerezal y De Fuentes: solo nombres de instituciones y el título.

## 2. Errores corregidos

No hay texto de Víctor. Son errores de las referencias que el tema **no hereda** (C24):

| # | Referencia | Dice | El tema dice | Fuente |
|---|---|---|---|---|
| E1 | Tebar | Chile 2010, «escala 10 veces mayor» que Haití | Enganche cambiado (Sevilla 2025); el terremoto no se usa | — |
| E2 | Tebar | $BC/Y=(r-g)(-B/Y)$ y «bc > 0» como déficit (mezcla saldo comercial y corriente) | `eq:deuda-externa` y `eq:saldo-estabilizador` del 3.B.12 con $b$, $d$, $r^*$, $\gamma_Y$ | ObstfeldRogoff1996Foundations |
| E3 | Tebar | Club de París, «20 miembros» | 22 miembros permanentes (Corea y Brasil, 2016) | ClubParis2026Miembros, Francia2026ClubParis |
| E4 | Tebar, Cerezal | Consenso OCDE de 1976 | 1978, nacido de un consenso de 1976 entre menos países | OCDE1978Consenso |
| E5 | Tebar | Paquete de Helsinki de 1992 | Reglas de Helsinki de 1991 (aplicadas desde 1992) | OCDE1978Consenso |
| E6 | Tebar | Elemento de donación «15 % renta media» | 15 % renta media-baja; 10 % media-alta y multilaterales | OCDE2026DefinicionAOD |
| E7 | Tebar | «36 países HIPC en 2023» | 37 en el punto de culminación (Somalia, 13/12/2023), Sudán en el de decisión, Eritrea antes | FMI2023HIPC, FMI2023Somalia |
| E8 | Tebar | Addis Abeba, «3.ª Conferencia del PNUD» | III Conferencia de la ONU sobre la Financiación para el Desarrollo | — |
| E9 | Tebar | «0,7 % del PIB» | 0,7 % de la renta nacional bruta | OCDE2026Meta07 |
| E10 | Tebar | Nueva financiación HIPC del FMI por la «PRGF» | La PRGF se sustituyó en 2010 por el PRGT; los servicios son del 3.B.22 (no se cuentan) | — |
| E11 | Tebar | «Ya llega al 80 % la desligada»; «la AOD es 2/3 de la financiación exterior de los PMA» | 81,5 % de los compromisos bilaterales en 2022 (DAC7b); la fracción de los PMA no se usa (no comprobable) | OCDE2026DAC7b |
| E12 | Cerezal | Líbano en impago «(2021)» | No se usa (fue en marzo de 2020; sin fuente en el `.bib`) | — |
| E13 | Cerezal | Recomendación de desligar «aprobada en 2002» | 2001 (en vigor en 2002) | OCDE2018AyudaDesligada |
| E14 | Tebar | Paradoja de Lucas explicada solo por la PTF | 2 familias: fundamentales y fallos del mercado de capitales | Lucas1990Why |
| E15 | Tebar | IED frente a exportar de «Antràs-Yeaple» | Helpman, Melitz y Yeaple (2004), con remisión al 3.B.18 | HelpmanMelitzYeaple2004 |
| E16 | `pendientes.md` P7 | $r_A$ para el tipo de autarquía | $r^A$ ($r_A$ es Arrow-Pratt en el canon) | notación §9 |
| E17 | C30 | Clave `ChenerySrout1966` | `CheneryStrout1966` | — |

**Control de calidad (12/11/2026)**

| N.º | Dónde | Antes | Ahora | Fuente |
|---|---|---|---|---|
| E18 | Recompra de Bolivia (II.1.3, c) | «Estaba en el tramo creciente, donde la quita es un regalo al acreedor» (contradecía el anexo B) | «Estaba donde la curva es casi plana: reducir la deuda apenas bajaba lo que se esperaba cobrar, así que la recompra al precio medio fue un regalo a los acreedores» | BulowRogoff1988Buyback |
| E19 | Impagos recientes (II.3) | «Zambia, Ghana y Etiopía reestructuraron dentro del Marco Común» | Zambia y Ghana reestructuraron; Etiopía sigue en ello | Francia2026MarcoComun, FMI2026ListaDSA |
| E20 | Riesgo para los bancos (II.2) | 176 % de los 9 mayores bancos citado a la FDIC (que da otra cifra: 147 % de 8 bancos) | Misma cifra, citada a su fuente | SimsRomero2013LatAm (nueva) |
| E21 | Bibliografía | FMI2023Brady con autor institucional | Neil Shenai y Marijn A. Bolhuis | — |
| E22 | AOD: 0,21 % (2001), «desde 2004», «tres cuartas partes» | Sin cita de la serie | Añadida OCDE2026DAC1 | OCDE2026DAC1 |
| E23 | SDRM | «Anne Krueger, vicedirectora del FMI» | «primera subdirectora gerente del FMI» | Krueger2002SDRM |
| E24 | Maquetación | Pág. 27 con 4 líneas; título partido tras «el» | Retoques de redacción en III.3 y la conclusión (sin quitar ideas): tema en 26 págs.; `\cortetitulo` antes de «El problema» | — |

## 3. Marcas resueltas

No hay Word original: ni marcas amarillas ni rojas, ni notas ni comentarios. Los «pendientes» son P1-P34 de `_trabajo/pendientes.md`:

| P | Qué pedía | Qué se hizo |
|---|---|---|
| P1-P3 | Cubrir los 3 epígrafes | Un apartado por epígrafe y en su orden (K1) |
| P4 | Círculo vicioso de Nurkse (Cerezal) | I.1, idea de la brecha |
| P5 | Estructura de De Fuentes en 3 bloques | Sin acción: coincide con la elegida |
| P6 | Enganche (Haití y Chile) | Sustituido por «Dale un pez…» y Sevilla 2025 (decisión del coordinador) |
| P7-P9 | Gráficos intertemporal, dinámica de la deuda, Laffer | Los 2 primeros copiados del 3.B.12; `laffer-deuda` nuevo |
| P10-P11 | Gráficos de flujos y de AOD | `flujos-desarrollo` (serie 2000-2025) y `aod-rnb` (1960-2025) |
| P12 | Gráfico del servicio de la deuda [decidir] | **No** (decisión del coordinador): el CSV queda para las cifras del II.2 |
| P13-P16 | Tablas de fuentes, umbrales, cronología, elemento de donación | `tab:fuentes-desarrollo`, `tab:indicadores-deuda`, `tab:umbrales-licdsf` y `tab:ppme` (anexo C), `tab:cronologia-deuda` (anexo A), `tab:elemento-donacion` (caja gris) |
| P17-P30 | Lo que prometen otros temas | Ver «Coherencia» |
| P31 | `mapa.yaml` vacío | Para `tema-canon` (K40) |
| P32 | Remisiones | Todas con `\vertema` al margen de la frase (71) |
| P33-P34 | Conclusión de Tebar; `.md` de De Fuentes corrupto | Conclusión propia; De Fuentes solo para contrastar |

## 4. Datos actualizados

Consulta: 12/11/2026 (fase de datos). Todos en `datos-actualizables.yaml` con el literal del `.tex`.

| Dato | Valor anterior (referencias) | Valor nuevo | Fuente | URL | 2.ª comprobación |
|---|---|---|---|---|---|
| Deuda externa de renta baja y media | IDR 2025 | 9,4 billones $ (2025), +5,5 % | BancoMundial2026IDR | bancomundial.org/es/news/press-release/2026/11/05/… | IDS (API): 9.445,0 |
| Servicio de esa deuda | — | 1,4 billones $, 13,1 % de las exportaciones | BancoMundial2026IDR, IDS | ídem; api.worldbank.org/v2/sources/6/… | IDS: 1.398,8 |
| Transferencias netas 2022-2025 | 741.000 M$ (2022-2024, IDR 2025) | 436.000 M$ (2022-2025) | BancoMundial2026IDR | ídem | No se mezclan ediciones |
| Remesas, IED, deuda neta (I.3) | sin cifra | 703,6; 494,3; 423,5 miles de M$ (2025); AOD recibida 251,9 (2023) | BancoMundial2026WDIFlujos | api.worldbank.org/v2/country/LMY/… | Nota del BM; FIDA da 728,6 (otra cobertura) |
| PPME | 36 (2023) | 39 en la iniciativa, 37 en culminación | FMI2023HIPC, FMI2023Somalia | imf.org (factsheet y PR 23/438) | Banco Central de Somalia |
| Lista del LIC DSF | — | 9 en sobreendeudamiento, 23 en riesgo alto (31/3/2026) | FMI2026ListaDSA | imf.org/external/pubs/ft/dsa/dsalist.pdf | Kit de deuda del BM (buscador): **[comprobar el PDF]** |
| Club de París | 20 | 22 | ClubParis2026Miembros | clubdeparis.org/en/frequently-asked-questions | Tesoro francés |
| Marco Común | — | 4 países; Chad, primer acuerdo (2022) | G202020MarcoComun, Francia2026MarcoComun | bercy1.applis.finances.gouv.fr/en/common-framework | Prensa (estado de cada caso) |
| AOD del CAD 2025 | −7,1 % (2024, preliminar) | 174.300 M$, −23,1 %, 0,26 % de la RNB | OCDE2026AODPreliminar | oecd.org (nota del 9/4/2026) | DAC1 (SDMX): cuadra |
| AOD 2024 definitiva | −7,1 % | −6 % | OCDE2025AODFinal2024 | oecd.org (18/12/2025) | DAC1: −6,1 % |
| Estados Unidos y Alemania 2025 | — | EE. UU. −56,9 %; Alemania, primer donante | OCDE2026AODPreliminar | ídem | DAC1 por donante |
| 4 países sobre el 0,7 % | — | Noruega, Luxemburgo, Suecia, Dinamarca | OCDE2026AODPreliminar | ídem | DAC1 |
| España 2025 | — | 4.554 M€, 0,27 % de la RNB | OCDE2026DAC1, Exteriores2026AOD | data-explorer.oecd.org; exteriores.gob.es | El % solo en la OCDE |
| Reino Unido | — | Del 0,5 % al 0,3 % en 2027 | ReinoUnido2025AOD | gov.uk (25/2/2025) | Parlamento, Full Fact |
| Ayuda desligada | 80 % (sin fuente) | 81,5 % (2022) | OCDE2026DAC7b | data-explorer.oecd.org | Informe de desligamiento (otra base) |
| Elemento de donación | 45/15/10 «renta media» | 45/15/10 con 15 % renta media-baja; descuentos 9/7/6 y 5-6 % | OCDE2026DefinicionAOD | oecd.org | DFAT (Australia) |
| Consenso OCDE | 1976 | 1978 | OCDE1978Consenso | legalinstruments.oecd.org (OECD-LEGAL-5005) | Página de la OCDE |
| 0,7 % | «del PIB» | De la RNB; Pearson 1969, resolución 2626 (1970) | OCDE2026Meta07 | search.oecd.org (no responde: ver Dudas) | legislation.gov.uk |
| Sevilla | — | 30/6-3/7/2025; resolución 79/323 | ONU2025Sevilla, ONU2025SevillaNoticia | digitallibrary.un.org; news.un.org | Recuento de votos no dado (no cuadra) |
| Brecha de los ODS | — | unos 4 billones $ al año | ONU2025Sevilla, ONU2025FfD4Cierre | un.org (nota de cierre) | Ver D-P1-1 |

No se usan (no comprobados): el 8,2 % de los préstamos privados nuevos de la AIF (lectura dudosa de la nota del BM), la previsión de AOD de 2026 (−5,8 % o −6,9 %, 2 cifras de la OCDE), la tabla de los 5 mayores donantes (solo Focus 2030; la OCDE devolvió 403) y el peso de los refugiados en la AOD de 2025.

## 5. Contenido añadido

Todo es nuevo (tema sin original). Lo que no está en ninguna referencia:
- **II.1**: los 3 conceptos (liquidez, solvencia, sostenibilidad) con Milesi-Ferretti y Razin (1996) y el FMI (2002); la dinámica con la función clave `eq:deuda-externa` del 3.B.12; la deuda concesional ($r^*<\gamma_Y$) de palabra; por qué pagan los Estados (Eaton y Gersovitz, 1981; Bulow y Rogoff, 1989 a y b; Arellano, 2008; Borensztein y Panizza, 2009; Cruces y Trebesch, 2013) y el sobreendeudamiento con la curva de Laffer de la deuda (Krugman, 1988 y 1989; Sachs, 1989; recompra de Bolivia; Pattillo, Poirson y Ricci, 2002), con la tabla de indicadores de la 1D01.
- **II.2**: la exposición de los bancos en 1982 (FDIC, 176 % del capital), el resultado del Plan Brady (Reinhart y Trebesch, 2016), China como acreedor (Horn, Reinhart y Trebesch, 2021), ISSD, Marco Común, Mesa Redonda Global y los datos del IDR 2026.
- **II.3**: el LIC DSF con su revisión de 2026, los foros (Club de París con sus 6 principios y la fecha de corte, Club de Londres, bonistas), el SDRM de Anne Krueger, las CAC, las cláusulas climáticas y los canjes.
- **III**: la cadena cooperación ⊃ ayuda ⊃ AOD, los 4 requisitos, la donación equivalente (caja gris con su cálculo), la ayuda ligada y su regulación, el TOSSD; la agenda de París a Busan y de Monterrey a Sevilla; los recortes de 2024-2025; la evidencia (Alesina y Dollar, Burnside y Dollar, Easterly, Levine y Roodman, Rajan y Subramanian 2008 y 2011, Clemens et al. 2012, Galiani et al. 2017) y el debate (Sachs, Easterly, Deaton, Moyo, los experimentos aleatorios y la crítica de Deaton, 2010).
- **Anexos**: cronología 1956-2026; derivación del saldo estabilizador, la solvencia, la forma en divisas y el sobreendeudamiento con $\min\{B,\theta Y(I)\}$ (con la función del gráfico); umbrales del LIC DSF y requisitos de la PPME; temas del bloque; test.
- **Recortes frente a Tebar** (C25): programas del FMI y respuesta a la COVID-19 (≈ 1.000 palabras) a una línea con `\vertema{3.B.22}`; la derivación del modelo intertemporal a un resumen; Markowitz, fondos soberanos y capital riesgo fuera; la desigualdad global (curva del elefante) fuera (es del 3.B.28).

### Propuestas aplicadas y rechazadas

- **C1-C6, C23** (parte 1): ver `_trabajo/notas-editor.md`; resumen: aplicadas con los cambios que allí se dicen; fuera `UNCTAD2026WIR`, `IFAD2026Remesas`, el 70 % de la IED a Asia y el cupón del 9,4 %.
- **C7** aplicada como modelo a)-c) (Idea, Modelo, Valoración), con la tabla de indicadores; el ejemplo numérico y la deuda concesional de palabra (K26).
- **C8** aplicada (a)-e)); `ReinhartRogoff2009` sustituida por `ReinhartRogoff2009This` (la del 3.B.17, misma obra).
- **C9** aplicada con **$B$ y $V(B)$** (decisión del coordinador), la dicho y la quita; el gráfico es el nuevo `laffer-deuda` (no la Bézier del borrador).
- **C10** aplicada; el 176 % de la FDIC se refiere a la deuda latinoamericana (la propuesta decía «países en desarrollo»).
- **C11** aplicada con **PPME (HIPC)** e **IADM (MDRI)**; los umbrales con `FMI1999HIPCReforzada`; fuera el BID (2007) y el FFACC (la clave `FMI2026FFACC` llevaba «comprobar la dirección»; el FFACC queda para el 3.B.22).
- **C12** aplicada sin el 8,2 % de la AIF ni el estado detallado de Zambia, Ghana y Etiopía (solo prensa); `BM2026IDR` → `BancoMundial2026IDR`, `FMI2026DSAList` → `FMI2026ListaDSA`, `GSDR2026` → `FMI2023GSDR` (la primera reunión, comprobada). Los impagos recientes van a una caja gris.
- **C13** aplicada en un II.3 más corto (2′): la tabla del LIC DSF pasa al anexo C (K36); fuera la quita del 90 % de Colonia y las fechas de las CAC de la zona del euro (sin comprobar); `ClubParis2026` → `ClubParis2026Miembros`; `ClubParis2016Informe` no hace falta (Francia2026ClubParis da 2016).
- **C14** aplicada; tabla del elemento de donación en caja gris (`tablacaja`); `OCDE2026Glosario` → `OCDE2026DefinicionAOD`, `OCDE2026Consenso` → `OCDE1978Consenso`, `OCDE2001Desligar` → `OCDE2018AyudaDesligada`, `Jepma1991` → `Jepma1991Tying` (la del 3.B.07); fuera el 13 % de refugiados (sin comprobar).
- **C15** aplicada sin la tabla de donantes (sin comprobar) ni la previsión de 2026; con `fig:aod-rnb`; `Pearson1969` y `ONU1970Res2626` no se citan (la meta va con `OCDE2026Meta07`, comprobada); Sevilla con la resolución 79/323.
- **C16-C17** aplicadas; la frase del refrán al principio del III.3 se queda sin repetir el refrán entero (vuelve en la idea final).
- **C18** aplicada con la idea final de K39 (pez y caña, respuesta a la pregunta del enganche) en lugar de «deudas viejas, ni se pagan ni se cobran» (un segundo refrán en la idea final rompía el hilo con el enganche).
- **C19-C22** aplicadas con las etiquetas de K4 (`anexo:cronologia`, `anexo:deuda`, `anexo:umbrales`, `anexo:temas`, `anexo:test`); sin Líbano en la cronología; los datos para el test en una caja del anexo C y el anexo de test solo con el enlace al simulador (CRITERIOS §2).
- **C24-C30**: en este informe; del `.bib` de C30 se han añadido 28 entradas (más 9 copiadas del 3.B.12, 3.B.28, 3.B.07 y 3.B.17), sin las claves duplicadas ni las notas internas («Comprobar los autores» se quitó de `FMI2023Brady`, y la nota de `FIDA2026Remesas`).
- **V1-V36**: aplicados todos los comprobados; V30, V32, V35 y la tabla de donantes, no; V29 (USAID) sin fecha ni clave.
- **K1-K40**: aplicados. K33: el aviso de notación va en los supuestos del modelo del II.1, no en una caja aparte. K36: aplicado (cajas grises y anexos). C1-C7 del canon quedan para `tema-canon`.

## 6. Coherencia

- **3.B.12**: `eq:deuda-externa` (función clave), `eq:saldo-estabilizador`, $\overline b$ y el gráfico copiado; Volcker (1979-1982) y el Plan Brady con sus mismas frases; LIC DSF con 30/40/55 y 140/180/240 % y la revisión de 2026 (mismas claves); el puzle de la asignación y Lucas (15; 0,4; 58; 5). Cumple sus 5 remisiones.
- **3.B.28**: la brecha con su ecuación y letras, el gran empujón (Rosenstein-Rodan, Sachs) y su crítica, el Consenso de Washington en mención, los experimentos aleatorios de palabra (el dicho «ver para creer» de la ficha `rct`, ya en el 3.B.28 y el 3.A.1, se quitó aquí el 13/11/2026 para no repetirlo; K30) y Deaton (2010).
- **3.B.19**: ISSD con la misma frase y cifras (más de 12.000 millones de casi 50 países, mayo de 2020-diciembre de 2021), Marco Común (noviembre de 2020), Club de París y CAD.
- **3.B.17**: misma definición de crisis de deuda externa, pecado original con la misma frase; las crisis de los 90 en una viñeta con remisión.
- **1D01**: los indicadores de su tabla (deuda externa bruta como pasivos exigibles, deuda y servicio sobre exportaciones, tasa de renovación) están en `tab:indicadores-deuda`.
- **3.A.39**: aviso de notación $b$/$d$ frente a la deuda pública (canon §9).
- **Contradicciones con otros temas** (no se tocan):
  - **3.B.42** (Word, sin revisar): repite la definición de AOD con «3 características» (el CAD da 4), fecha la donación equivalente «tras la reforma de 2016» (se aplica desde los datos de 2018), dice «30 miembros» del CAD y da datos de donantes antiguos, **sin remitir al 3.B.29**. Al revisarlo: resumir la definición con `\vertema{3.B.29}` y quedarse con la cooperación de la UE.
  - **3.B.21** (Word, sin revisar): desarrolla la crisis de 1982 (Volcker, Baker, Brady, Clubes de París y de Londres), la ISSD y el Marco Común **sin remitir al 3.B.29**, y fecha la subida de tipos en «1980-1982» (el 3.B.12, el 3.B.17 y el 3.B.29 dicen 1979-1982). Al revisarlo: cronología breve con `\vertema{3.B.29}`.
  - **4.A.27**: su remisión por Lewis apunta al 3.B.29, pero Lewis está en el 3.B.28 (el 3.B.29 no lo trata; ya en `pendientes-coherencia.md`).
  - **4.A.24**: Consenso OCDE en 1978 (Tebar y Cerezal dicen 1976).
  - **1D01**: la regla práctica del 100-200 % para la deuda externa bruta frente a «sin umbral universal» (ver Dudas).
  - **3.B.22, 3.B.30** (sin revisar): reparto anotado (PPME e IADM aquí; FFACC, PRGT y programas en el 3.B.22; la AIF en el 3.B.30).
- **Canon** (para `tema-canon`, K40 y C1-C7 de `propuestas-coherencia.md`): entrada del 3.B.29 en `mapa.yaml`; fichas `sostenibilidad-deuda-externa` y `cuenta-corriente-intertemporal` en «resumen»; `rostow` con las 2 brechas y $\mathrm{FE}$; notación local $B$, $V(B)$, $\underline B$, $B^{\max}$, $\theta$; aviso de que `Brady1988Report` no es el Plan Brady.

## Puesta al día con las reglas de esta rama (13/11/2026)

Tema traído de la rama `revision-temario`; adaptado a las reglas de las tandas 4.ª-9.ª y de la revisión transversal, sin quitar contenido.

| Regla | Cómo se ha aplicado |
|---|---|
| Citas | 91 `\parencite`/`\parencites` pasan a `\nocite` (script); queda 1 dentro de un `\fuente{}`. Los `\textcite` que quedan tienen al autor como sujeto |
| Anexo de test | La caja tenía un `\url` con texto propio («Preguntas de test de exámenes anteriores, con su explicación»): pasa a la caja estándar con `\href` y `?tema=3.B.29`. No había cita al simulador |
| «Lo que se suele preguntar» | Fuera de la `notaopositor` la frase «El tribunal suele preguntar lo que el título no dice…»; las 3 preguntas siguen en la problemática |
| Figura / Gráfico / Imagen | Los 5 son gráficos (ejes, curvas o datos); no hay esquemas ni imágenes pegadas |
| Dichos (8.ª, 9.ª) | Se queda el refrán del enganche («Dale un pez…», que retoma la idea final). De los 3 dichos con etiqueta (el tema no tenía original de Víctor), se quedan 2 integrados sin etiqueta: «al que tiene, se le dará» (el capital va a donde ya hay capital, en la paradoja de Lucas) y «quien presta, no cobra; y si cobra, no todo» (el sobreendeudamiento). Se quita «ver para creer», que además ya usan el 3.B.28 y el 3.A.1 |
| Estructura rígida de modelo | Los 5 modelos (brecha, intertemporal, sostenibilidad, impago, sobreendeudamiento) ya tenían a)-e) con i)-iii); sin cambios |
| Resultados clave en morado | Además de `eq:dos-brechas` y `eq:deuda-externa`, pasa a `\funcionclave` el saldo que estabiliza la deuda (`eq:saldo-estabilizador`), resultado del modelo de sostenibilidad que usan las implicaciones y el gráfico |
| Términos en inglés | LIC DSF, SDRM y TOSSD llevan ahora su nombre en inglés entre paréntesis la primera vez |
| Nobel | Notas nuevas: \autor{Lucas} (1995, en la primera mención de la paradoja), \autor{Krugman} (2008; ahora se nombra a Krugman y Sachs en el sobreendeudamiento, con la advertencia de que lo premiado es su comercio internacional), \autor{Deaton} (2015), \autor{Banerjee}, \autor{Duflo} y \autor{Kremer} (2019; antes «(Nobel de 2019)» sin motivo) y \autor{Acemoglu}, \autor{Johnson} y \autor{Robinson} (2024; una frase nueva: las instituciones, entre los fundamentales que explican la paradoja de Lucas, \vertema{3.B.28}). Entradas copiadas de otros temas |
| 4.º ejercicio | Ya estaban \vertema{4.A.24}, \vertema{4.A.26}, \vertema{4.B.6} y \vertema{4.B.18}; sin cambios |
| Pizarra / vídeo, NEK, identidad contable | No aparecen en el texto del tema |
| Compilación | `construir-tema.py 3B29 --solo pdf --no-publicar`: 26 páginas de tema, 3 de anexos, 6 de bibliografía; `verificar-tema.py`: solo los 3 errores de los formatos publicados anteriores a la fuente y avisos de «cifra sin cita» |

## 7. Dudas abiertas

- **D1. Estructura** (K1, D-P1-3): 3 apartados por epígrafe, con la AOD fuera del I (Tebar la mete dentro). Aplicada. Títulos cortos «¿Por qué financiarse fuera?» (I.1) y cabecera «Financiación exterior, deuda externa y ayuda al desarrollo».
- **D2. Fichas nuevas** (K32, C4): `impago-soberano` (con la curva de Laffer dentro), `alivio-deuda` y `ayuda-desarrollo` (con la eficacia dentro), con el 3.B.29 de referencia. Recomendado: sí, las 3. El texto ya está escrito para que sirvan.
- **D3. Siglas** (K33, C5): aplicada la recomendada, **PPME (HIPC)** e **IADM (MDRI)** la primera vez y después las castellanas; ISSD, LIC DSF, CAC, SDRM y TOSSD. Alternativa: HIPC y MDRI, más usadas en los manuales.
- **D4. Enganche y refranes** (K38): aplicado «Dale un pez a un hombre…» con Sevilla 2025; dichos «al que tiene, se le dará» (I.2), «quien presta, no cobra; y si cobra, no todo» (II.1) y «ver para creer» (III.3, la de la ficha `rct`, que ya usan el 3.B.28 y el 3.A.1: si se quiere un refrán propio en cada tema, cambiarla). Para CRITERIOS §8 (C6), cuando Víctor apruebe.
- **D5. $\mathrm{FE}$** en las 2 brechas (K27, C3): aplicada.
- **D6. Gráfico del servicio de la deuda** (P12): no se hace (decisión del coordinador); el CSV queda como fuente de las cifras del II.2.
- **D7. Segundo gráfico de la deuda concesional** (K26): no, de palabra.
- **D8. Regla del 100-200 %** de la 1D01: el 3.B.29 dice «sin umbral universal» en la tabla de indicadores y no da otro número. Opciones: dejarlo así (aplicado) o añadir la regla práctica con la fuente de la 1D01.
- **D9. Cifras sin confirmar**:
  - lista del LIC DSF a 31/3/2026 (**9 y 23**): de 2 resúmenes del buscador; abrir `dsalist.pdf` antes de publicar;
  - umbrales del servicio de la deuda del LIC DSF (10/15/21 % y 14/18/23 %) y la referencia de la deuda pública total (35/55/70 %): los del marco de 2018 de memoria del revisor; comprobar en la nota de orientación de 2018;
  - **17 países** del Plan Brady (FMI, WP 23/258, sin autores visibles en el PDF: la entrada va con autor institucional);
  - el 176 % de la FDIC (cap. 5 de *History of the Eighties*);
  - Somalia: deuda del 64 % del PIB en 2018 a menos del 6 % (nota 23/438);
  - la recompra de Bolivia (casi la mitad a unos 11 centavos);
  - el 0,21 % de 2001 y el «nivel más bajo desde 2004» (CSV y nota de la OCDE);
  - las cláusulas de deuda resiliente al clima en Sevilla (nota de cierre de la FfD4);
  - `OCDE2026Meta07` apunta a search.oecd.org, que no responde: buscar la dirección nueva en oecd.org/en antes de publicar;
  - de la parte 1: D-P1-1 (brecha de 4 billones: leer el párrafo del Compromiso), D-P1-2 (Zambia de Easterly, 1999), D-P1-4 (IED con `FMI2009MBP6`).
- **D10. USAID** (V29): no se cita su cierre (1/7/2025) por falta de fuente oficial en el `.bib`; la caída de EE. UU. va con la OCDE.
- **Control de calidad (12/11/2026)**: con correcciones pendientes para el editor (ver informe de la fase 6). Comprobado en las fuentes de D9: la lista del LIC DSF a 31/3/2026 (`dsalist.pdf`: 9 en sobreendeudamiento, 23 en riesgo alto); los umbrales de 2018 (página `lic.htm` del FMI: 30/140/10/14/35, 40/180/15/18/55, 55/240/21/23/70); los 17 países del Plan Brady (1990-1998, México el primero; el WP 23/258 sí tiene autores, Neil Shenai y Marijn A. Bolhuis); el «nivel más bajo desde 2004» (DAC1: 0,25 % en 2004, ninguno menor hasta 2025) y el 0,21 % de 2001 (DAC1); el IDR 2026 (9,4 billones, +5,5 %, 1,4 billones, 436.000 millones). **No cuadra**: el 176 % no está en el cap. 5 de la FDIC (que da, para los 8 mayores bancos, un 147 % del capital y las reservas en deuda de los 4 mayores deudores latinoamericanos y un 247 % del capital en préstamos a países en desarrollo en 1982); el 176 % de los 9 mayores bancos es del ensayo de la Federal Reserve History (Sims y Romero, 2013, que cita a Sachs, 1988). Sigue sin comprobar: Somalia (64 % → menos del 6 %; la nota 23/438 da 403), la recompra de Bolivia, las cláusulas climáticas de Sevilla y la dirección nueva de `OCDE2026Meta07`. Para decidir: el 8,2 % de la AIF se lee sin ambigüedad en la nota del Banco Mundial («los países que pueden recibir financiamiento de la AIF pagaron, en promedio, un 8,2 % por los nuevos compromisos con acreedores privados en 2025, la tasa más alta desde 1989»): se puede recuperar si se quiere.

- **D11. Dichos** (13/11/2026): se quedan 2 de los 3, integrados; fuera «ver para creer» (repetido en el 3.B.28 y el 3.A.1). Alternativa: quedarse solo con el refrán del enganche. **Aplicada: 2 integrados (recomendada).**
- **D12. Acemoglu, Johnson y Robinson** (13/11/2026): frase nueva en I.2 con su nota de Nobel, sin cita de la obra (está en el 3.B.28). Alternativa: no mencionarlos aquí. **Aplicada: mencionarlos (recomendada, revisión transversal).**

## 8. Instrucciones para el vídeo

- **Enganche e idea final**: tras leer el título, el refrán «Dale un pez a un hombre…» y Sevilla 2025 (4 billones al año de brecha, la AOD −23,1 %, 1,4 billones de servicio de la deuda) y la pregunta: «¿por qué el capital que necesitan los países pobres no llega, llega caro o llega regalado y no sirve?». La idea final la responde en 3 partes (no llega: rinde menos de lo que parece y prestar es arriesgado; llega caro: la deuda se come lo que se pesca; regalado: el pez no enseña a pescar) y cierra con «la mejor financiación del desarrollo es la que enseña a pescar». Introducción y conclusión en `modo: guion`, sin pizarra.
- **Funciones clave que se conservan**: `eq:dos-brechas` en la esquina durante el I (se borra al acabar el I); `eq:deuda-externa` en la esquina durante todo el II (`conservar:`), porque el saldo estabilizador, el umbral $\overline b$ y la deuda en divisas salen de ella.
- **I** (8′30″): pizarra con $I/Y=v\bar\gamma_Y$, la brecha y las 2 brechas con el máximo; `cc-intertemporal` por capas (autarquía → apertura → déficit con $\Delta I$ y $\Delta C$); «58 → 5» junto al gráfico con el dicho «al que tiene, se le dará». La tabla de fuentes se canta por filas (3 columnas en la pizarra: ¿crea deuda?, ¿estable?, ¿quién asume el riesgo?); `flujos-desarrollo` como **apoyo** (las remesas superan a la IED desde 2022).
- **II.1** (3′30″): `eq:deuda-externa` y el saldo estabilizador escritos; `dinamica-deuda-externa`, solo el panel b) a mano (superávit, $\overline b$ inestable) y el a) como apoyo; el ejemplo 60 % / 5 % / 2 % → 1,8 % se dice. Eaton-Gersovitz y Bulow-Rogoff de palabra («reputación» frente a «sanciones», 2 palabras en la pizarra). `laffer-deuda` **a la pizarra por capas** (ejes → bisectriz y $\underline B$ → curva → máximo $B^{\max}$ con los 2 tramos → $B_1$ y $B_2$ → flecha de la quita → rayo del precio $V(B)/B$), con la dicho «quien presta, no cobra; y si cobra, no todo» al lado. Al final del II.1 queda en la pizarra la curva de Laffer junto a la función clave.
- **II.2** (3′30″): línea de tiempo a mano 1982 · 1985 · 1989 · 1996/1999 · 2005 · 2020 · 2023, que se va llenando con cada episodio (crisis, Baker, Brady, PPME, IADM, ISSD y Marco Común, Mesa Redonda); los datos de hoy (9,4 billones; 1,4 billones; 9 y 23 países) en `apunte:`. La flecha de la quita del gráfico de Laffer se señala al nombrar el Plan Brady y la PPME (no se redibuja).
- **II.3** (2′): 3 palabras en la pizarra, oficial / privado / contractual (Club de París, Club de Londres y bonistas, CAC); el LIC DSF con 30/40/55 como apoyo.
- **III.1** (2′30″): los 4 requisitos del CAD en columna y 45 / 15 / 10; la tabla del elemento de donación como apoyo.
- **III.2** (2′30″): `aod-rnb` como **apoyo**; a mano, solo la línea del 0,7 % frente al 0,26 % real; las 4 conferencias en una línea.
- **III.3** (3′30″): 2 columnas, «más ayuda» (Sachs, gran empujón) y «mejor ayuda» (Easterly, Deaton, Moyo, experimentos aleatorios), que se llenan con el debate; la lectura «efecto positivo pero pequeño» en `apunte:`.
- **Al final**, la pizarra queda limpia, con la curva de Laffer de la deuda y las 2 columnas de la ayuda si caben; si no, solo las 2 columnas.
- No decir números de temas en voz alta (se nombran los enfoques: «el enfoque intertemporal», «la teoría de las crisis», «el Fondo Monetario»).
