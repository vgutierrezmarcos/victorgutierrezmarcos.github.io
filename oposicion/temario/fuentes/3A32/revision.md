# Revisión del tema 3.A.32 (11/11/2026)

«El modelo de oferta y demanda agregada: determinación de renta e inflación en una economía abierta. Análisis de las políticas monetaria y fiscal, y de los shocks y políticas de oferta.»

## Resumen

- **Tema sin original de Víctor** (`inventario.json`, `sin_original: true`): escrito desde cero, con redacción propia, en revisión autónoma (cada duda, con la opción recomendada aplicada, va en «Dudas abiertas» como A32-NN).
- **Estructura** (CRITERIOS §5): el orden del título, 3 apartados. El eje de las perturbaciones (origen, efectos, respuesta) y el bloque III salen del tema de **Miquel Tebar** (A.32); el orden de I y II, del antiguo 3A_28 de **Luis de Fuentes** (V.2, 17/07/2020) y del bloque «Efectividad de las políticas de demanda (modelo de Mundell-Fleming)» del Word del **3.B.15** de Víctor. Ningún nombre de preparador va en el tema.
- **Contenido**: I. Renta e inflación en una economía abierta (Mundell-Fleming como **desarrollo de referencia**, D014; la DA y la OA abiertas con la cuña exterior y la inflación importada; Galí-Monacelli), II. Las políticas monetaria y fiscal (corto plazo, medio plazo, microfundamentos y *policy mix*), III. Las perturbaciones y las políticas de oferta. Cinco anexos (A-E). Cante: 2′30″ + 10′ + 8′ + 8′30″ + 1′ = 30′.
- **Entregado**: `3A32.tex`, `3A32.bib` (85 entradas, todas citadas), `seo.json`, `datos-actualizables.yaml`, `_trabajo/graficos-pedidos.json` y los 6 gráficos (5 TikZ y 1 pgfplots; `policy-mix` copiado del 3.A.40). Construido con `construir-tema.py` (PDF, HTML y Word; 23 páginas de tema, 5 de anexos y 5 de bibliografía) y `verificar-tema.py 3A32` sin errores.
- **Comprobación de redacción propia** (repetida tras el control de calidad): n-gramas de 8 palabras contra Tebar, Luis de Fuentes (texto descifrado), el Word del 3.B.15 y los `.tex` de todos los temas. Con las referencias solo coincide el título oficial. Con otros temas no queda ninguna frase copiada: solo rótulos y fórmulas fijas, el enlace al simulador, las filas de `tab:mundell-fleming` (iguales a las del 3.A.38 a propósito) y expresiones técnicas cortas («la eficacia de cada política depende del régimen cambiario y de la movilidad del capital», «la BP es menos inclinada que la LM», «sube el tipo de interés y cae la inversión», los episodios del *policy mix*). Se reescribieron las frases que coincidían con 3.A.36, 3.A.37, 3.A.40 y 3.B.11 (la de la devaluación interna, el pie del *policy mix* y «mirar a través», en el control de calidad).

## Errores corregidos

No hay original: no se corrige ningún texto de Víctor. Errores de las **fuentes de referencia** que no se han trasladado (C11, P12):

| Dónde | Qué decía | Qué dice el tema |
|---|---|---|
| Word del 3.B.15 (copiado en el 3.B.19) | «Si existe movilidad perfecta de capital, β = 0, la curva BP será totalmente vertical» | BP vertical = movilidad **nula**, $\beta_K=0$ (I.1 y trampa de test del anexo E) |
| Word del 3.B.15 | Supuesto 5 «movilidad perfecta» y luego se analizan los 3 casos | La movilidad es un parámetro, no un supuesto; los 3 casos van en ii) Desarrollo |
| Tebar | κ = (1 − θ)(1 − βθ)/θ «pendiente de la brecha» | Es el coeficiente del coste marginal; la pendiente es $\kappa_\alpha$ con $(\theta_\alpha+\varphi)$, como `eq:kappa` del 3.A.7 |
| Tebar | «Galí (1992): los shocks de oferta explican principalmente el PIB» frente a «Galí (1999)» | No se usa (no comprobado); solo Blanchard y Quah (1989) y Galí (1999), comprobados |
| Tebar | Rey (2015) | Rey (2013), Jackson Hole, `Rey2013Dilema` (como 3.A.37 y 1D01) |
| Tebar | Guerrieri *et al.* (2020) | 2022 (*AER*, `GuerrieriEtAl2022`, como el 3.A.40) |
| Luis de Fuentes | Furlanetto (2008) | Furlanetto (2006), versión de 1/4/2006 (R1; `Furlanetto2006Fiscal`) |
| Propuesta de contenido | Gráfico de Mundell-Fleming con $E_0$, $E_1$ | Puntos A, B, C ($E$ es el tipo de cambio; K11) |
| Propuesta de contenido | `\autor{Bretton Woods}` | Bretton Woods sin versalitas (es un lugar) |

## Marcas resueltas

No hay marcas: sin Word original, no hay subrayado amarillo, texto rojo, texto oculto, notas al opositor, comentarios, «No cantar», figuras ni «Fuente:» vacías (`inventario.json`). Las notas de trabajo que se leyeron en las fuentes (Word del 3.B.15: «ver cómo lo cuenta…», «cantado en clase con…»; nota de cambio de temario del 3.B.12) no se publican (P33).

## Datos actualizados

Todos los datos son **nuevos** (no hay valor anterior). Doble comprobación hecha en la fase de datos (`_trabajo/propuestas-datos.md`), consultas del 11/11/2026.

| N.º | Dato en el tema | Fuente (clave) | URL | Segunda comprobación | Dónde |
|---|---|---|---|---|---|
| V1 | Embargo del 17/10/1973; −4,4 mb/d (7,5 %); precio duplicado el 1/1/1974 | `Hamilton2011Historical` | nber.org/papers/w16790 | Pink Sheet mensual del Banco Mundial | caja de III.2 |
| V2 | Crudo de 2,8 a 11,0 $/barril (1973-1974), «casi por 4» | `BancoMundial2026PinkSheet` | CMO-Historical-Data-Annual.xlsx | Energy Institute (x3,5) | III.2 y caja |
| V3 | Irán: −4,8 mb/d (7 %); Irán-Irak 6 %; de 12,9 a 36,9 $ (1978-1980) | `Hamilton2011Historical`, `BancoMundial2026PinkSheet` | ídem | Energy Institute (precio); producción solo Hamilton | caja de III.2 |
| V4 | OCDE: inflación 15,5 % (1974) y 13,6 % (1980); crecimiento 0,4 % (1975) y 0,2 % (1982) | `BancoMundial2026WDIhist` | data.worldbank.org | agregado OCDE con una sola fuente | caja de III.2 |
| V5 | España: 28,4 % (agosto de 1977); PIB 0,5 % (1975) y 0 % (1979) | `INE2026IPCSerie`, `CE2026AMECO` | ine.es tabla 76134 | WDI y AMECO | caja de III.2 |
| V6 | IAPC 10,6 % (oct. 2022); energía 44,3 % (mar. 2022); subyacente 5,7 % (mar. 2023) | `Eurostat2026IAPC` | prc_hicp_minr | BCE (ICP) | enganche, III.2 y caja |
| V7 | España: energía 60,3 % (mar. 2022) y 7,9 % (oct.) frente a 41,5 % de la zona | `Eurostat2026IAPC` | ídem | BCE (ICP) | caja de III.2 |
| V8 | Gas TTF ×8 (2019-2022); unos 236 €/MWh en agosto de 2022 | `BancoMundial2026PinkSheet` | CMO-Historical-Data-Monthly.xlsx | Energy Institute | caja de III.2 |
| V9 | Brent +124 % en dólares y +158 % en euros (ene. 2021-jun. 2022); en ese periodo el euro cae un 13 % frente al dólar, y hasta 0,98 $ en octubre de 2022 (−19 % desde enero de 2021) | `EIA2026Brent`, `BCE2026EXR` | eia.gov RBRTE; data.ecb.europa.eu EXR | brent.csv de la 1D01; BPI | enganche, I.2, caja y gráfico |
| V24 | Déficit corriente del 9,4 % del PIB en 2007 y superávit desde 2012 (−9,35 y +0,16 %) | `BdE2026BE17` | bde.es be17.zip | `3B11/datos/bp-espana-capacidad-cuenta-financiera.csv` y el 3.B.11 (misma clave y cifras) | II.2 |
| V10 | Brent 123,9 $ en octubre de 2026, por encima del máximo de 2022 | `EIA2026Brent` | ídem | Banco Mundial (125,0) | enganche |
| V11 | Octubre de 2026: inflación 4,0 %, energía 20,8 %, subyacente 2,5 % | `Eurostat2026IAPCoct` | euro-indicators | 3.A.41 (mismas cifras) | enganche y III.2 |
| V12 | PIB: zona del euro 3,7 % → 0,4 %; España 6,4 % → 2,4 % (2022-2023) | `Eurostat2026nama10gdp`, `INE2026CNA2025` | nama_10_gdp | INE CNA 2025 | caja de III.2 |
| V13 | España 2025: X 36,5 %, M 32,6 %, apertura 69 % | `INE2026CNA2025`, `Eurostat2026nama10gdp` | ine.es CNA2025 | INE CNTR 67823 | introducción y I.1 |
| V14 | Dependencia energética: España 69 %, UE 57 % (2024) | `Eurostat2026nrgindid` | nrg_ind_id | nrg_bal_c y Statistics Explained | III.1 |
| V15 | Traspaso: 0,3 % a los precios de importación, 0,04 % al IAPC | `OrtegaOsbat2020ERPT`, `ComunaleKunovac2017ERPT` | ecb.op241 | Comunale y Kunovac (2017) | I.2 |
| V16 | Regímenes del FMI a 30/4/2023: 44,8 / 32,5 / 13,4 / 9,3 % | `FMI2024AREAER2023` | elibrary.imf.org | recuento de la tabla 4 | caja de II.1 |
| V17 | BCE: primera subida el 21/7/2022; 10 subidas, de −0,50 % a 4 % | `BCE2022DecisionesJulio`, `BCE2026TiposOficiales` | ecb.europa.eu | API FM del BCE | III.2 |
| V18 | BCE 2026: 2,25 % (junio) y 2,50 % (septiembre) | `BCE2026TiposOficiales` | ídem | API FM | III.2 |
| V19 | Excepción ibérica: 40 €/MWh 6 meses, hasta 65 € en dic. 2023 | `BOE2022RDL10`, `BOE2022OrdenTED517`, `BOE2023RDL3`, `CE2022AyudaIberica` | boe.es | Comisión, IP/22/3550 | caja de III.2 |
| V20 | IVA de la electricidad 21 → 10 → 5 %; 0,20 € por litro de carburante | `BOE2021RDL12`, `BOE2022RDL6`, `BOE2022RDL11` | boe.es | 2 textos por medida (solo BOE) | caja de III.2 |
| V21 | Efecto de las medidas (BdE, 2,3 pp) | **no usado**: sin fuente primaria | — | — | se usa Dao *et al.* (2023), como el 3.A.40 |
| V22 | Zona del euro con 21 países | — | — | — | **no usado** (no hacía falta) |
| V23 | Reformas laborales de 2012 y 2021 | `BOE2012RDL3`, `BOE2012Ley3`, `BOE2021RDL32` | boe.es | títulos y fechas en el BOE | III.3 |
| R1-R11 | Años de las referencias académicas | ver `propuestas-datos.md` | Crossref | — | todas aplicadas (Furlanetto 2006, Rey 2013, Hamilton 1983, Kilian 2009, Blanchard y Galí 2010…) |

Todos los datos que caducan están en `datos-actualizables.yaml` (19 entradas).

Cambios del control de calidad (11/11/2026): los multiplicadores en 2 `equation` (salían rotos en el HTML y sin número en Word), «OA de largo plazo» para la OA vertical (como `OA$_{\mathrm{LP}}$` del 3.A.5), V9 precisado, nuevos textos de la devaluación interna, el pie del *policy mix* y «mirar a través», Furlanetto reordenado y el autor de Blanchard y Giavazzi (2003) con la inicial.

## Contenido añadido

Todo es nuevo. Por apartados, y de dónde sale:

- **Introducción**: los 5 bloques con el rótulo solo en su línea; enganche de 2022 y 2026 (coordinador, datos V9-V11); relevancia con la apertura de España (V13); definiciones (economía pequeña y abierta, $E$, $q$, régimen, movilidad, perturbación, política de oferta); contextualización Hicks → Fleming y Mundell (Nobel de 1999) → estanflación → Obstfeld-Rogoff y Galí-Monacelli; problemática de 3 preguntas (K6); esquema con `\esqtiempo` y nota al opositor con el reparto.
- **I.1 Mundell-Fleming** con a)-e) (ficha `mundell-fleming`; Word del 3.B.15 corregido; C3): supuestos separados de los 3 casos de $\beta_K$, IS y BP como funciones clave, LM `eq:lm`, gráfico `is-lm-bp`, equilibrio con tipo fijo y flexible, aislamiento (Friedman, 1953), extensiones (2 países, Dornbusch, enfoque monetario), evidencia (Obstfeld, Shambaugh y Taylor, 2005; Ilzetzki, Mendoza y Végh, 2013, con las palabras del 3.A.40; Feldstein y Horioka, 1980).
- **I.2 DA y OA abiertas** (C3): efecto saldos reales y efecto competitividad, `eq:da-abierta` por régimen; OA con insumos importados y salario de consumo; la curva aumentada del 3.A.28 como OA en tasas (K9); `eq:nairu-abierta` (cuña exterior, Layard, Nickell y Jackman; Bruno y Sachs) como función clave; equilibrio y devaluación interna; `eq:inflacion-abierta` (inflación importada) como función clave, con el traspaso (Gopinath, 2020; BCE, V15).
- **I.3 Galí-Monacelli** con a)-e): 2 inflaciones, IS dinámica y NKPC abiertas con la notación del 3.A.7, Backus-Smith y la facturación en dólares.
- **II.1**: los 4 casos con movilidad perfecta (gráfico de 4 paneles), devaluación como cambio del gasto (Meade), **dilema del régimen** (K13, Krugman, 1979), trilema con pegatina, Rey (2013) en una viñeta, caja de regímenes del FMI (V16), multiplicadores con $\beta_K$ (`eq:multiplicadores-fijo` y `-flexible`, derivados en el anexo A), `tab:mundell-fleming` **ampliada a la monetaria**, asignación de Mundell (1962) con Meade, Tinbergen y Swan, déficits gemelos por las 2 vías (las de la 1D01 y el 3.B.11) y España de la peseta al euro (K5).
- **II.2**: neutralidad con tipo flexible y Dornbusch; la fiscal con tipo fijo desplaza exportaciones netas; devaluación frente a devaluación interna (Schmitt-Grohé y Uribe, 2016) y el ajuste de España (las cifras del 3.B.11); unión monetaria (Galí y Monacelli, 2008; Nakamura y Steinsson, 2014).
- **II.3**: DITR > CITR > tipo fijo (Galí y Monacelli, 2005) y «mirar a través»; miedo a flotar (Engel, 2011; Calvo y Reinhart, 2002); política fiscal en economía abierta (Furlanetto, 2006; Ilzetzki, Mendoza y Végh, 2013; Corsetti, Kuester y Müller, 2011); *policy mix* con el gráfico del 3.A.40 y dominación (Sargent y Wallace; Leeper).
- **III.1**: definición y 3 tipos de perturbaciones; dependencia energética de España (V14); perturbación de oferta keynesiana (mención, 3.A.40); identificación (Blanchard y Quah, 1989; Galí, 1999; Kilian, 2009; Hamilton, 1983), con el detalle y `eq:blanchard-quah` en caja gris.
- **III.2**: efectos en la OA-DA abierta (gráfico `oferta-abierta`, panel a), dilema, «mirar a través» (BCE, 2025), el régimen como amortiguador, política fiscal (Dao *et al.*, 2023), caja de España en 2022 (V19, V20, V7), 3 episodios (70, 2000, 2021-2026) con caja de cifras y el gráfico de datos `energia-tipo-cambio-zona-euro` (V9).
- **III.3 Políticas de oferta** (ninguna referencia las trata; P4): definición y 3 frentes, efectos en economía abierta (panel b), devaluación fiscal (Farhi, Gopinath e Itskhoki, 2014), políticas de rentas (mención, 3.A.5), evidencia (Blanchard y Giavazzi, 2003; Duval y Furceri, 2018; Eggertsson, Ferrero y Raffo, 2014; reformas de 2012 y 2021, OCDE, 2014), agenda (Draghi, MRR, OCDE 2026), valoración.
- **Conclusión** con sus 5 bloques; empieza por «En conclusión,» y la idea final retoma el refrán del enganche y contesta la problemática.
- **Anexos**: A Mundell-Fleming paso a paso (multiplicadores con $\beta_K$, límites, aislamiento, déficits gemelos); B DA y OA abiertas paso a paso (pendientes, cuña exterior, inflación de consumo); C Galí-Monacelli paso a paso (comprobado con el documento de trabajo, C3); D `tab:perturbaciones`; E aspectos para el test con el enlace único al simulador.

### Propuestas: qué se aplicó

**Contenido (C1-C14, D-01 a D-20)**: aplicadas C1-C9 y C12 (todo el texto, con la notación de coherencia y los datos de la fase de datos), C10-C11 (recortes y errores no trasladados), C13-C14 (en este informe y en `datos-actualizables.yaml`). Cambios sobre el texto propuesto:
- **Enganche**: «Las desgracias nunca vienen solas» (coordinador, K20) en lugar de «más vale doblarse que quebrarse» (D-18), que pasa a pegatina del tipo flexible como amortiguador (III.2).
- **Pegatina del trilema**: «no se puede nadar y guardar la ropa» (K23) en lugar de «el oro y el moro».
- **Datos**: los de `propuestas-datos.md` (coordinador: mandan los datos): Brent de octubre de 2026 (123,9 $) y no el de abril (117 $); claves `BCE2026TiposOficiales`, `BCE2026EXR`, `Hamilton2011Historical`, `Kilian2009NotAll`; sin `BCE2026Decisiones` ni la paridad de julio de 2022 (no comprobada como dato).
- **$s_t$ → $\tau_t$** y **$\omega$ → $\Psi$** en Galí-Monacelli (CC2: $s$ es el ahorro y ω son los pesos de los tipos efectivos).
- **D-08** (no citar Furlanetto): **rechazada**, porque la fase de datos sí leyó el original (R1) y el resumen confirma el resultado; se cita en II.3.
- **D-12** (sin gráfico de datos): **rechazada** por decisión del coordinador (punto 5): se hace `energia-tipo-cambio-zona-euro`, en caja, que no repite el `brent` de la 1D01 (añade la depreciación del euro).
- **D-14** (sin fichas nuevas): queda como duda A32-04 frente a CC3/CC4.
- **D-15** (superávit desde 2013): se escribe «desde 2012», como el 3.B.11 revisado con la misma clave.
- **D-20** (Blanchard, caps. 19-20): se quita el número de capítulo (no comprobado en la 8.ª edición).
- `\fuente` del *policy mix*: sin la cita del Fiscal Monitor de 2023 (no consta que respalde los episodios) y sin mencionar otro tema.
- La afirmación «con costes en el nivel de vida de los trabajadores» de la reforma de 2012 se ha quitado (no está comprobada en la OCDE, 2014).
- Frases reescritas para no coincidir con otros temas (ver Resumen).

**Datos (V1-V23, R1-R11)**: aplicadas todas salvo V21 (sin fuente primaria: se usa Dao *et al.*, 2023) y V22 (no hacía falta). Gráficos de datos: aplicado el CSV 2 (recomendado); el 1 (IAPC) no, porque ya está en el 3.A.41; el 3 (petróleo 1970-2025) queda en `datos/` sin gráfico (sus cifras van en el texto).

**Coherencia (K1-K26, CC1-CC10, D1-D7)**: aplicadas K1 (estructura a), K2 (títulos, con 4 ajustes para que quepan en una línea: I.2 «La demanda y la oferta agregadas: renta e inflación», II.2 «A medio plazo: cuando los precios se ajustan», III.1 «Las perturbaciones de oferta y su identificación», III.2 «Efectos y respuesta de la política económica»), K3, K4 (esquema, con los minutos del coordinador), K5 (España en cada bloque), K6, K7, K8, K9, K10, K11, K12 (en «Instrucciones para el vídeo»), K13, K14, K15 (IS y BP como funciones clave; la LM como `equation`, para no pasar de 4 funciones clave), K16-K19, K20 (sin Suiza: la cifra no está comprobada), K21 (cita completa del Nobel, traducción propia), K22, K23 (con «a la fuerza ahorcan» en el dilema de III.2, no en III.1), K24 (sin la frase de Robinson), K26 (tabla ampliada). CC1-CC10 y D1-D7: para el canon (sección final) y dudas.

**Pendientes (P1-P35)**: P1-P4 (epígrafes, cubiertos en su orden), P5-P7, P9-P15, P17-P30, P32-P33 aplicados; P8 (hechos estilizados abiertos) no, por no repetir `tab:hechos-ciclo` de la 1D01 y el 3.A.42; P16, P31 y P35 son del canon y de otros temas (sección final); P34 es duda A32-17.

## Coherencia

- **Notación** (canon §0, §8, §9): $E$ directo, $q=EP^*/P$, $XN=xY^*-mY+\nu q$, LM $M/P=kY-h\,i$, $\overline A\equiv\overline C+\overline I+\overline G$ (como el 3.A.38), $\beta_K$ avisada, $Y^*$ solo renta exterior y equilibrios $Y_0$, $Y_1$, puntos A, B, C; NEK con $\theta$, $\varphi$, $\eta$, $\sigma$, $\kappa$, $r^n_t$, $u_t$ del 3.A.7; WS-PS con PAT, $\mu$, $F(U,Z)$ del 3.A.28; perturbación de oferta $\varepsilon_t$ en la curva aumentada y $u_t$ en la NKPC con el aviso del 3.A.41. Locales y avisados: $\alpha$ grado de apertura, $P_C$, $\pi_{H,t}$, $\gamma_{P^*,t}$, $\tau_t$, $\theta_\alpha$, $\kappa_\alpha$, $\Theta$, $\Psi$, $\sigma_{HF}$, $\sigma_F$, $D_F$, $D_X$, $\varepsilon^{\mathrm D}_t$, $\varepsilon^{\mathrm S}_t$.
- **Mismo modelo, misma forma**: la DA cerrada `eq:da` del 3.A.5 es el caso $\beta_K=0$ con tipo flexible de la DA abierta (dicho en I.2.1 y en el anexo A); `eq:nairu-abierta` es la `eq:nairu` del 3.A.28 con la cuña $q^\alpha$; `tab:mundell-fleming` repite las 2 filas fiscales del 3.A.38 y añade las monetarias; los gráficos de Mundell-Fleming usan los colores de `mundell-fleming-dos-paises` del 3.A.37; `da-oa-abierta` y `oferta-abierta`, los valores de `da-oa` del 3.A.5; `policy-mix`, copiado del 3.A.40.
- **Remisiones** (`\vertema`, siempre al margen de la frase): 3.A.5, 3.A.6, 3.A.7, 3.A.18, 3.A.28, 3.A.29, 3.A.36, 3.A.37, 3.A.39, 3.A.40, 3.A.41, 3.A.42, 3.A.45, 3.B.11-3.B.17, 3.B.19 y 4.A.22 (solo para ampliar). Sin remisiones a la 1D01 ni al 3.B.40.
- **Lo que remiten al 3.A.32 otros temas revisados**, ya cubierto: 3.A.4 (OA, I.2), 3.A.5 (IS-LM-BP, I.1), 3.A.7 y 3.A.18 (Galí-Monacelli, I.3), 3.A.37 (país pequeño frente a 2 países), 3.A.38 (XN, BP, tabla), 3.A.40 (multiplicador según el régimen, I.1 d)), 3.B.13 (BP horizontal, supuestos de I.1), 1D01 (déficits gemelos por 2 vías, II.1.3).
- **Contradicciones con otros temas** (no se tocan; van a la sección final):
  1. 3.A.38, anexo A: $Y^*$ es a la vez el equilibrio IS-LM y la renta exterior (D038); lo mismo en el 3.A.5, que usa $Y^*$ e $i^*$ para el equilibrio IS-LM (l. 168, 184 y 850-874); cosmético en `eq:multiplicador-abierta` del 3.A.40.
  2. 3.A.38, l. 835: la unión monetaria remite a 3.B.40; debe ser 3.B.16.
  3. 3.A.37, l. 961: el dilema de Rey remite a 3.B.14; debe ser 3.B.15.
  4. 1D01, pie de `fig:brent`: «117 dólares en abril y 114 en septiembre»; el dato de octubre de 2026 es 123,9 $ (máximo desde 2012).
  5. Canon §9 escribe la inflación exterior $\pi^*$ en $\gamma_q\simeq\gamma_E+\pi^*-\pi$ (3.B.11); este tema usa $\gamma_{P^*}$ porque $\pi^*$ es el objetivo de inflación (coordinador; duda A32-08).
  6. Clave del PIB de Eurostat: `Eurostat2026nama10gdp` (aquí, 1D01, 3A30, 3A31, 3A35) frente a `Eurostat2026Nama10gdp` (3A08, 3A09, 3A33, 3A38, 3A45).
  7. `informe-repaso.md`, l. 324: «OA-DA de 3.A.37»; la OA-DA está en el 3.A.5 (y, abierta, aquí).
  8. 3.A.40, fuente de `fig:policy-mix`: «adaptado del gráfico de la guía del dictamen» cita otro documento del temario en `\fuente{}` (CRITERIOS §2, 9/11/2026); aquí se ha quitado.

## Dudas abiertas

Todas con la opción recomendada aplicada.

- **A32-01. Estructura**: (a, aplicada) propia, en el orden del título (I modelo, II políticas, III perturbaciones y políticas de oferta), con el eje de Tebar en III; (b) la de Tebar (perturbaciones en la NEK cerrada), que deja sin cubrir 2 de los 3 contenidos del título y repite 3.A.7, 3.A.36 y 3.A.41; (c) 2 apartados.
- **A32-02. Movilidad del capital**: (a, aplicada) $\beta_K$ en el tema y propuesta de que la ficha `mundell-fleming` pase a $\beta_K$ (como 3.A.37 y 3.A.38); (b) $\beta_K$ solo local.
- **A32-03. Enganche**: (a, aplicada) «Las desgracias nunca vienen solas» con 2022 (energía y euro a la vez) y 2026; (b) «Más vale doblarse que quebrarse» (propuesta de contenido), que queda como pegatina del tipo flexible en III.2; (c) «No se puede nadar y guardar la ropa» con 1992, que es la pegatina del trilema.
- **A32-04. Fichas nuevas del canon**: (a, recomendada por coherencia) crear `oa-da` y `gali-monacelli` con referencia en el 3.A.32; (b, propuesta de contenido) no crearlas y anotar la versión abierta en `nek-3-ecuaciones` e `is-lm`. Lo decide el canon con Víctor; el tema vale para las 2.
- **A32-05. Gráfico de datos**: (a, aplicada) sí, `energia-tipo-cambio-zona-euro` en la caja de cifras de III.2; (b) no.
- **A32-06. Frase de Joan Robinson** (mapa 1:1): (a, aplicada) no ponerla; (b) en e) Valoración de Mundell-Fleming, para defender un modelo de supuestos tan fuertes.
- **A32-07. Ficha `identificacion-choques`**: (a, aplicada) todavía no (caja gris en III.1); (b) crearla con referencia en el 3.A.40.
- **A32-08. Inflación exterior**: (a, aplicada) $\gamma_{P^*,t}$, porque $\pi^*$ es el objetivo de inflación; (b) $\pi^*_t$ como en la fila del tipo real en tasas del canon §9 (3.B.11).
- **A32-09. Relación de intercambio en Galí-Monacelli**: (a, aplicada) $\tau_t\equiv p_{F,t}-p_{H,t}$ (misma letra que Corsetti-Pesenti en el 3.A.37); (b) $s_t$ como Galí, que choca con el ahorro.
- **A32-10. Colores de IS y LM** en `is-lm-bp` y `mundell-fleming-politicas`: (a, pedida) como `mundell-fleming-dos-paises` del 3.A.37 (IS azul, LM morada, BP verde); (b) como `is-lm` del 3.A.5 (IS morada, LM azul). Los 2 temas revisados no coinciden entre sí: conviene unificar en el canon.
- **A32-11. Títulos de subapartados**: (a, aplicada) los de K2 con 4 ajustes para que quepan en una línea (ver «Propuestas»); (b) los de K2 tal cual, con `\cortetitulo`.
- **A32-12. Reparto del cante**: (a, aplicada, coordinador) II 8′ y III 8′30″ (más peso a las políticas de oferta, que no están en otro tema); (b) II 8′30″ y III 8′ (coherencia).
- **A32-13. Pegatinas de III**: (a, aplicada) «a la fuerza ahorcan» en el dilema (III.2), «más vale doblarse que quebrarse» en el régimen como amortiguador (III.2) y «no hay atajo sin trabajo» en las políticas de oferta (III.3); (b) «a la fuerza ahorcan» en III.1 y «más vale doblarse…» en la devaluación interna o las políticas de oferta. Ninguna se usa en otro tema (grep del 11/11/2026).
- **A32-14. OCDE (2026), *Foundations for Growth and Competitiveness***: la web de la OCDE da 403 a las consultas automáticas; que sustituye a *Going for Growth* lo dice la fase de contenido y no se ha podido leer aquí. (a, aplicada) mantener la frase; (b) quitarla si no se confirma a mano.
- **A32-15. OCDE (2014) y la reforma de 2012**: el tema dice solo que la OCDE le atribuyó una contribución a la moderación salarial; comprobar el texto si se quiere más detalle (contratación indefinida).
- **A32-16. Superávit corriente de España**: (a, aplicada) «desde 2012», como el 3.B.11 revisado con la misma clave (`BdE2026BE17`); la propuesta de contenido decía 2013 sin haberlo leído.
- **A32-17. Word propio antiguo**: el disco D: no estaba montado: confirmar que no hay Word de Víctor de los antiguos 3.A.28 o 3.A.40 en «Mis temas» (P34). Si lo hay, habría que conservar su estructura de bloques.
- **A32-18. AREAER**: el último localizado es el de 2023 (publicado en diciembre de 2024); comprobar a mano si hay uno de 2024 o 2025.
- **A32-19. Devaluaciones de la peseta de 1992 y 1993**: se mencionan sin cita (hecho histórico conocido) en el ejemplo de España de II.1; (a, aplicada) dejarlo así; (b) añadir una fuente del Banco de España.
- **A32-20. Títulos con «:»**: tras el control de calidad, el título del anexo B es «Anexo: oferta y demanda agregadas abiertas paso a paso» y ya no da aviso. `verificar-tema.py` sigue avisando de II.3 («Con microfundamentos: qué inflación estabilizar y cómo combinar»), pero en el PDF construido cabe en una línea: (a, aplicada) sin `\cortetitulo`; (b) acortarlo.

## Instrucciones para el vídeo

- **Funciones clave que se conservan** en la esquina: las 3 de Mundell-Fleming, IS `eq:is-abierta`, LM `eq:lm` y BP `eq:bp`, desde I.1 hasta el final de II.1 (la LM se escribe con ellas aunque en el documento no esté recuadrada); `eq:inflacion-abierta` y `eq:nairu-abierta` desde I.2 hasta III.2.
- **Enganche**: «Las desgracias nunca vienen solas»: en 2022 llegaron juntas la energía cara y el euro débil (Brent +124 % en dólares, +158 % en euros; inflación del 10,6 %); en 2026 vuelve (123,9 $, 4,0 %). Pregunta: ¿qué hace una economía abierta cuando la desgracia llega de fuera y por el lado de la oferta? **Idea final**: el refrán otra vez; las políticas de demanda reparten el golpe y dependen del régimen; solo las de oferta hacen que la próxima desgracia duela menos. Introducción y conclusión sin pizarra.
- **I.1 (4′30″)**: a la pizarra el gráfico `is-lm-bp` por capas (ejes, IS, LM, A, las 3 BP de la más plana a la vertical, «superávit/déficit»). Se dice el equilibrio con tipo fijo y flexible sin dibujarlo.
- **I.2 (3′)**: a la pizarra el panel a de `da-oa-abierta` (expansión fiscal con tipo fijo: A → B → C) y, debajo, la identidad de la inflación importada. El panel b se deja para II.2. La cuña `eq:nairu-abierta`, escrita.
- **I.3 (2′30″)**: solo las 2 ecuaciones (IS dinámica y NKPC con $\pi_{H,t}$) en una esquina; sin gráfico.
- **II.1 (4′)**: consejo de cante del Word del 3.B.15 de Víctor: **solo se dibujan los 2 paneles eficaces** de `mundell-fleming-politicas` (a, fiscal con tipo fijo; d, monetaria con tipo flexible); los otros 2 se dicen. Después, la tabla `tab:mundell-fleming` escrita como cuadro (8 casillas). Pegatina «no se puede nadar y guardar la ropa» al lado del trilema. Los multiplicadores con $\beta_K$, de palabra.
- **II.2 (2′)**: sobre `da-oa-abierta`, el panel b (devaluación interna). España 2007-2012, de palabra.
- **II.3 (2′)**: escribir «DITR > CITR > fijo». `policy-mix` solo como apoyo en pantalla.
- **III.1 (2′30″)**: sin gráfico; la restricción de Blanchard y Quah, si da tiempo, en una línea.
- **III.2 (3′)**: a la pizarra el panel a de `oferta-abierta` (estanflación) por capas; pegatinas «a la fuerza ahorcan» (dilema) y «más vale doblarse que quebrarse» (tipo flexible). La tabla `tab:perturbaciones` y el gráfico `energia-tipo-cambio-zona-euro`, como apoyo en pantalla.
- **III.3 (3′)**: el panel b de `oferta-abierta` (política de oferta: A → B → C); pegatina «no hay atajo sin trabajo».
- **Gráfico conjunto por partes**: `mundell-fleming-politicas` tiene capas por panel (a y d primero); `da-oa-abierta` y `oferta-abierta`, un panel en cada momento.
- Nunca se dice «hilo»: el ejemplo de España entra con «Volvamos a España…».

## Para canon/pendientes-coherencia.md

Propuestas para `tema-canon` (no se ha tocado ningún fichero fuera de `fuentes/3A32/`):

1. **Ficha `mundell-fleming`** (CC1): $\beta_K$ como forma de referencia (A32-02); LM $M/P=kY-h\,i$; IS con $\overline A$; supuesto de sustitutos perfectos sin prima; dilema del régimen (K13) y `tab:mundell-fleming` con las 2 políticas; equilibrios sin asterisco; gráficos de referencia `fuentes/3A32/graficos/is-lm-bp.tex` y `mundell-fleming-politicas.tex`; fila 3.A.32 «desarrollo (hecho, 11/11/2026): I.1 con a)-e), `eq:is-abierta`, `eq:lm`, `eq:bp`, `fig:is-lm-bp`, `fig:mundell-fleming-politicas`, `tab:mundell-fleming` con las 2 políticas, multiplicadores con $\beta_K$ en el anexo A».
2. **`notacion.md` §9** (CC2): fila nueva Galí-Monacelli ($\pi_{H,t}$, $\pi_t$, $\alpha$ grado de apertura, $\tau_t$, $\theta_\alpha$, $\kappa_\alpha$, $\Theta$, $\Psi$, $\sigma_{HF}$, $\sigma_F$, locales); $P_C$ y la cuña $P_C/P=q^\alpha$; $\gamma_{P^*}$ frente a $\pi^*$ (A32-08); nota de D038 (equilibrio sin asterisco en macro abierta); nota de ν (regla de Taylor sin suavización en temas con XN); $\varepsilon^{\mathrm D}_t$, $\varepsilon^{\mathrm S}_t$ locales.
3. **Fichas nuevas** `oa-da` y `gali-monacelli` (CC3, CC4; A32-04) y filas del 3.A.32 en `nek-3-ecuaciones` y `divina-coincidencia`.
4. **Ficha `policy-mix`** (CC5): fila 3.A.32 hecha (resumen en II.3, gráfico copiado del 3.A.40, asignación de Mundell en 2 viñetas).
5. **Fichas con fila nueva del 3.A.32** (CC6): `tipo-cambio-real`, `marshall-lerner`, `paridad-intereses`, `multiplicadores-fiscales`, `areas-monetarias-optimas`, `corsetti-pesenti` (mención), `nairu-layard-nickell` (cuña exterior y políticas de oferta), `triangulo-gordon` (mención), `dixit-stiglitz` (mención), `critica-lucas` (mención en I.1 e)), `taylor` (reglas de Galí-Monacelli), `identidad-balanza-pagos` (déficits gemelos).
6. **`informe-repaso.md`, l. 324** (CC7, P35): «OA-DA de 3.A.37» → «OA-DA de 3.A.5 (`eq:da`, `fig:da-oa`)».
7. **`mapa.yaml`** (CC8, P16): entrada 3.A.32 con `fuente_disponible: 'no'`, `revisado: 2026-11-11`, modelos (los de CC8) y referencias (tabla D de coherencia); entrantes que faltan: 3.A.1 → 3.A.32 (l. 299) y 3.B.13 → 3.A.32 (l. 864), `estado: ok`.
8. **Pendiente del 3.A.32 para temas revisados** (CC10): 3.A.38, anexo A, equilibrio $Y_0$ y no $Y^*$; 3.A.5, equilibrio IS-LM con $Y^*$ e $i^*$ (l. 168, 184 y 850-874), que en macro abierta son la renta y el tipo exteriores; 3.A.38, l. 835, 3.B.40 → 3.B.16; 3.A.37, l. 961, 3.B.14 → 3.B.15; 3.A.40, `eq:multiplicador-abierta`, $\Delta Y^*$ (cosmético) y `\fuente` de `fig:policy-mix` sin la guía del dictamen; 1D01, pie de `fig:brent` y `brent.csv` con octubre de 2026 (123,9 $); unificar la clave del PIB de Eurostat; colores de IS y LM entre `is-lm` (3.A.5) y `mundell-fleming-dos-paises` (3.A.37) (A32-10).
9. **Temas del bloque sin revisar** (P31): 3.B.15 pasa a resumen (cuadro y trilema) remitiendo a `tab:mundell-fleming`; 3.B.14 elimina el borrador IS-LM-BP; 3.B.16 puede remitir a la OA-DA abierta y la devaluación interna; 3.B.19 desarrolla los 2 países y Corsetti-Pesenti; 4.B.4 resume la eficacia fiscal con la tabla; 3.B.12 menciona IS-LM-BP y la asignación de Mundell.
10. **Ficha `identificacion-choques`** (CC9): todavía no (A32-07).
