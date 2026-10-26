# Notas para la solución de máximos del examen de España (1D01, entregable 3)

> 26/10/2026: el examen pasa a 7 preguntas y 2 horas (ver «Lo general»). Las secciones de abajo conservan el
> contenido por bloque; su título dice en qué pregunta nueva entra cada uno.

Para el agente que escriba la solución de máximos (entregable 4). Todas las cifras salen de `datos/*.csv`
(consulta 26/10/2026; fuentes y códigos en `datos/fuentes.md`). Entre corchetes, dónde está cada dato en el
cuadernillo: C = cuadro, G = gráfico (la numeración es la del PDF y la de los ficheros). Las referencias
«guía `…`» son etiquetas de `../1D01.tex`.

## Lo general

- **Examen completo, en 7 preguntas** (Víctor, 26/10/2026; antes eran 10, una por bloque): la antigua 3 (consumo,
  ahorro, inversión y crédito) va dentro de la 1; la competitividad precio (de la antigua 4) y la no precio con los
  aranceles (antigua 5) van dentro del sector exterior (nueva 3); la inflación (antigua 4) va con la política
  monetaria (nueva 4), como en los dictámenes de 2016 y 2023. Los cuadros y gráficos del cuadernillo no cambian.
- **Tiempo: 2 horas** orientativas, con la regla de la guía (anexo `anexo:tiempo`): lectura ≈ 10 % (12 min), repaso
  ≈ 5 % (6 min); $W=102$; $t=W/(n+0{,}25)=102/7{,}25\approx14$; perfil cíclico $1{,}25\,t\approx18$; dentro de esa
  media, más a las preguntas con más retos.
- **Pesos** (decisión de Víctor, 26/10/2026): la solución da más extensión donde España tiene de verdad más retos o
  más que contar. Resumen (detalle y razones en cada pregunta):

| Pregunta | Bloques de la guía | Peso | Minutos (de 102) |
|---|---|---|---|
| 1 | I. Perfil cíclico + II. Capital, ahorro y crédito | **alto** (×1,25) | 18 |
| 2 | II. Trabajo y productividad | **alto** | 15 |
| 3 | IV. Sector exterior + III. Competitividad precio, no precio y aranceles | medio | 14 |
| 4 | III. Inflación + V. Política monetaria | **alto** | 15 |
| 5 | V. Estabilidad financiera y macroprudencial | bajo | 10 |
| 6 | V. Política fiscal y deuda | **alto** | 15 |
| 7 | VI. Desequilibrios y recomendaciones | **alto** | 15 |

  Por qué así: la 4 junta el problema coyuntural de 2026 (inflación del 5,0 % frente a 3,8 %, riesgo de segunda
  ronda) con la respuesta del BCE, y sube a peso alto; la 3 tiene mucho que contar (la gran corrección exterior, la
  devaluación interna, los aranceles), pero el reto actual es moderado (energía, una PIIN aún bajo el −35 %), y se
  queda en medio; la banca sigue en bajo.

  La solución puede decirlo así al principio («los retos están en la productividad, el paro estructural, las cuentas
  públicas y el nuevo choque de precios; el sector exterior, la banca y el crédito no son hoy un problema»): es el
  criterio que la guía pide aplicar en el examen (anexo `anexo:tiempo`).
- **El país está nombrado** (España). La solución puede usar lo que se sabe del país (reforma laboral de 2021,
  «excepción ibérica», fondos NGEU, reglas fiscales de 2024), siempre anclado en un dato del cuadernillo y con
  condicionales.
- **Diagnóstico general (frase para abrir la 1)**: España encadena desde 2021 una expansión más intensa que la de la
  zona del euro (PIB 2019-2025: +10,0 % frente a +6,8 % [G2]), apoyada en el empleo y en la población (inmigración),
  con brecha positiva desde 2022 (+2,0 % en 2025 [C1]), superávit exterior y desapalancamiento privado, pero con
  productividad estancada, paro que dobla al europeo, deuda pública en torno al 100 % del PIB y, en 2026, un nuevo
  choque energético que lleva la inflación al 5,0 % (septiembre) y al BCE a subir tipos.
- **Fases del ciclo** (guía `sec:etapas`, `fig:fases-ciclo`): 2007-2008, final de la expansión inmobiliaria (PIB +3,5 %
  y +0,8 %; brecha +3,3 %; déficit exterior −9,4 %); 2009-2013, doble recesión (−3,8 % en 2009, −2,9 % en 2012; brecha
  −9,6 % en 2013; paro 26,1 %; prima de riesgo 435 pb en 2012); 2014-2019, recuperación con desapalancamiento y
  superávit exterior; 2020, pandemia (−10,9 %, frente a −6,0 % en la zona del euro [G2]); 2021-2023, rebote y choque
  de precios; 2024-2026, expansión con brecha positiva (+3,7 %, +2,6 %; 0,6 % y 0,7 % trimestral en 1T y 2T de 2026
  [G1]) y moderación prevista (2,4 % y 1,9 %, Comisión, primavera de 2026 [C1]).

## 1. Perfil cíclico (bloque I) · peso ALTO

**Por qué alto**: ordena todo el examen, la economía ha vivido un ciclo completo con dos recesiones, y hay un
«porqué» de mucho contenido (PIB por habitante). **Qué se busca**: fases, composición del crecimiento por la demanda y
la oferta, posición cíclica con la brecha, coyuntura de 2026 y el PIB por habitante.

- Demanda [C1]: la demanda nacional explica expansiones (+4,2 pp en 2007 y 2015; +3,4 pp en 2025) y recesiones (−6,5 pp
  en 2009, −4,9 pp en 2012); la externa es contracíclica (+2,8 pp en 2009, +2,3 pp en 2011 y 2022, por el turismo) y
  resta en 2025 (−0,8 pp; importaciones +5,5 %). Existencias −1,5 pp en 2023 (dato atípico).
- Trimestral [G1]: 0,5-0,8 % trimestral desde 2023; 2T2026, consumo privado +0,67 pp y externa −0,46 pp. Ritmo
  anualizado ≈ 2,6-2,8 % ($(1+g)^4-1$), algo por encima de la previsión de 2026 (2,4 %).
- Oferta [C2]: industria débil (−2,1 % en 2023, +0,6 % en 2025), agricultura volátil (−16,9 % en 2022, sequía; +15,0 % y
  +11,9 % después), servicios de mercado al alza (profesionales +8,3 % y +7,2 % en 2024-2025), construcción +6,0 % en 2025.
- Brecha y potencial [C1]: brecha −9,6 % (2013) → +3,1 % (2019) → −8,5 % (2020) → +2,0 % (2025); potencial 2,7 % (alto
  por la población). $\Delta OG\approx\gamma_Y-\gamma_{Y^p}$: 2025, 2,6 − 2,7 ≈ 0 (la brecha casi no se abre; la serie
  de AMECO es de otra vintage, ver avisos).
- PIB por habitante [C1, C2 bis, G2]: 2019-2025 PIB +10,0 % y por habitante +5,0 % (zona del euro +6,8 % y +4,7 %).
  Descomposición 2019-2025 (tasas medias anuales, C2 bis): PIB 1,59 = población 0,79 + peso de la población en edad de
  trabajar −0,01 + tasa de ocupación 0,95 + horas por ocupado −0,46 + PIB por hora 0,33. Crecimiento extensivo
  (inmigración: población extranjera del 10,3 % al 14,1 % [C3]); en 2013-2019 el PIB por habitante crecía casi como el PIB.
- Guía: `sec:perfil`, `fig:esquema-perfil`, `sec:demanda` (contribuciones), `sec:oferta`, `fig:pib-por-pet` (misma
  descomposición), `sec:medidores`, `sec:anticipar`. Complementarios: tabla de fases (PIB, brecha, contribuciones y paro
  medios); descomposición 2019-2025 frente a 2013-2019.

## 2. Mercado de trabajo y productividad (bloque II) · peso ALTO

**Por qué alto**: el paro estructural y la productividad estancada son los dos grandes retos de España; hay mucho que
explicar (Beveridge, temporalidad, inmigración, horas). **Qué se busca**: caracterizar el mercado, tensión, Beveridge,
temporalidad y productividad.

- Paro 8,2 % (2007) → 26,1 % (2013) → 14,1 % (2019) → 10,5 % (2025), 10,2 % en 2T2026; doble que la zona del euro (6,4 %).
  Juvenil 24,9 %; larga duración 3,4 % (13,0 % en 2013). Actividad 15-64 en máximos (74,9 %); empleo 67,0 % (54,8 % en 2013) [C3].
- Beveridge [G3]: 2010-2013 hacia más paro y menos vacantes; 2014-2019 baja el paro con vacantes estables (0,4-0,7 %);
  2021-2025 vacantes al 0,9 % con el paro bajando al 10,5 %. Tasa de vacantes muy baja frente a la europea (2,25 % en
  2025, EA21; `../datos/beveridge-espana-zona-euro.csv`, no está en el cuadernillo). Tensión limitada en el agregado,
  pero creciente (salarios por asalariado +4,4 % en 2025; CLU +4,4 % frente a 3,3 % en la zona del euro). Ojo: salto
  de la serie de vacantes en 2009-2010.
- Temporalidad 25,4 % (2021) → 21,4 % (2022) → 15,4 % (2025): caída brusca y persistente en plena expansión, más propia
  de un cambio normativo (reforma laboral de diciembre de 2021) que del ciclo; decirlo con condicional.
- Okun: 2014-2019 crecimientos del 1,5-4,1 % y caídas del paro de 1,2-2,5 pp al año; 2022-2025, caídas de 0,8-1,9 pp
  con crecimientos del 2,4-6,4 %: con más población activa hace falta más crecimiento para bajar el paro.
- Productividad [C3, C2 bis]: por hora +0,33 % anual en 2019-2025 y por ocupado −0,13 %; en 2007-2013 la productividad
  por hora subió (1,63 %) por un efecto composición (se destruyó empleo poco productivo). Demografía: dependencia de los
  mayores 24,0 % → 31,2 %.
- Guía: `sec:trabajo`, `eq:okun`, `fig:beveridge`, `fig:esquema-paro`, `fig:esquema-clu`, `fig:empleo-horas`, anexo de
  casos (inmigración, envejecimiento, salario mínimo). Fórmulas: $\gamma_{PAT}=\gamma_Y-\gamma_L$,
  $\gamma_{CLU}=\gamma_W-\gamma_{PAT}$ (2025: 4,4 − 0,0). Complementarios: tabla de productividad por fases; Beveridge
  de la zona del euro para comparar.

## 1 (cont.). Consumo, ahorro, inversión y crédito (bloque II, capital) · dentro de la pregunta 1

**Por qué medio**: hay buena historia (desapalancamiento ejemplar, inversión más sana que en 2007), pero hoy no es un
problema; el único foco de riesgo es la vivienda (precios al alza con poca inversión residencial).

- Hogares [C4, G5]: tasa de ahorro 6,0 % (2007) → 17,6 % (2020, ahorro forzoso) → 11,9 % (2025); renta disponible real
  por habitante +3,2 % y +3,3 % en 2023-2024 y +0,9 % en 2025, con el consumo +3,1 %: en 2025 el consumo crece más que
  la renta y baja el ahorro (12,8 → 11,9). 2012: renta −6,6 %.
- Inversión [C1, C4]: FBCF −37,4 % acumulado en 2007-2013 (vivienda −51,6 %); 2019-2025 +13,4 % con propiedad
  intelectual +47,4 %, otras construcciones +14,9 % (fondos europeos: cuenta de capital 1,0-1,1 % del PIB desde 2021
  [C7]), vivienda +6,0 %, maquinaria +2,7 %. Tasa de inversión de los hogares 15,8 % (2007) → 4,7 % (2015) → 7,4 % (2025);
  de las empresas 30,2 % → 18,8 % (2009) → 24,4 % (2025), con beneficios en el 38,9 % del VAB (43,8 % en 2016).
  Determinantes: demanda esperada (acelerador; brecha positiva), coste de la financiación (préstamos a empresas 4,6-4,7 %
  en 2023-2024, 3,4 % en 2025), fondos NGEU, balances saneados, incertidumbre (aranceles), oferta de vivienda rígida.
- Ahorro e inversión nacional [C4]: formación bruta de capital 30,5 % (2007) → 17,4 % (2013) → 21,7 % (2025); ahorro
  nacional 21,1 % → 25,0 %: $S-I\approx$ 3,3 % ≈ saldo corriente (3,2 %), identidad útil para la pregunta 6.
- Crédito y deuda [C4, G4]: flujo de crédito 26,5 % del PIB (2007) → −11,2 % (2012) → 2,6 % (2025); deuda de los hogares
  85,0 % (2009) → 42,9 %; empresas 119,0 % → 62,0 %. Préstamos a hogares +4,5 % y a empresas +4,2 % en diciembre de 2025,
  tras caer en 2023: reactivación moderada. Vivienda: +12,7 % nominal y +9,7 % real en 2025; precio real ya cerca del
  de 2007 (G4: índice 87, 2007 = 100).
- Guía: `sec:capitales`, `fig:consumo-renta-ahorro`, `tab:saldos-sectoriales`, `sec:estabilidad` (desapalancamiento sano).

## 4 (y 3). Inflación (pregunta 4) y competitividad precio (pregunta 3) (bloque III)

**Por qué alto**: es el problema coyuntural de 2026 (5,0 % frente a 3,8 %), con riesgo de segunda vuelta y pérdida de
competitividad coste desde 2019.

- 2021-2022 [C5, G6]: choque energético (energía +21,1 % y +27,6 %; deflactor de las importaciones +22,4 % en 2022) que
  pasa a alimentos (+10,7 % y +11,1 % en 2022-2023) y a la subyacente (3,8 % y 4,1 %). Pico: España 10,7 % (julio de
  2022), zona del euro 10,6 % (octubre). España baja antes: 3,4 % en 2023 frente a 5,4 % (energía −16,1 % frente a −2,0 %):
  traslado más rápido de la electricidad mayorista y medidas como el tope al gas, con condicional. Subyacente: 5,1 %
  (enero de 2023) frente a 5,7 % (marzo de 2023).
- 2026 [G6, G7]: Brent de 62,5 $ (diciembre de 2025) a 117,3 $ (abril) y 114,2 $ (septiembre); IPCA 5,0 % frente a 3,8 %
  en septiembre; subyacente 3,5 % frente a 2,5 %. Por qué más en España: brecha positiva y demanda fuerte, traslado más
  rápido de la energía, salarios y CLU creciendo más (4,4 % frente a 3,3 % en 2025), vivienda y alquileres.
- Segunda vuelta: la subyacente española sube del 3,0 % (enero) al 3,7 % (mayo) y se mantiene en el 3,5-3,7 %;
  salarios +4-5 %; margen $\gamma_{1+\mu}\approx\gamma_P-\gamma_{CLU}$ = 3,0 − 4,4 = −1,4 pp en 2025 (los márgenes se
  estrechan: no hay «inflación de beneficios» ese año). Salario real 2025: 4,4 − 2,7 = +1,7.
- Competitividad precio y coste [C3, C6, G8]: CLU acumulados 2007-2013 +1,2 % frente a +12,1 % en la zona del euro
  (devaluación interna); 2013-2019 +5,0 % frente a +6,5 %; 2019-2025 +26,8 % frente a +23,0 % (se pierde parte). TCER con
  CLU frente a la zona del euro −9,4 % de 2007 a 2025; con IPC frente a 42 socios, casi plano. Exportaciones en volumen
  +56 % desde 2007.
- Guía: `sec:precios`, `fig:esquema-indices`, `eq:efecto-base`, `fig:esquema-inflacion`, `fig:iapc-zona-euro`,
  `fig:brent`, `anexo:casos-frecuentes` (el último brote y la «última milla»), `sec:tipo-cambio`, `fig:esquema-devaluacion`.

## 3 (cont.). Competitividad no precio y política comercial (bloque III) · dentro de la pregunta 3

**Por qué bajo**: la exposición directa a EE. UU. es pequeña y las cuotas se mantienen; el reto de fondo (I+D, tamaño
empresarial) se desarrolla mejor en la 10. Basta un análisis ordenado y dos o tres medidas.

- Cuotas [C6]: cuota mundial de bienes y servicios ≈ 2,0 % estable desde 2007 pese al auge de los emergentes; bienes
  1,9 % → 1,8 %; servicios 3,5 % (2007) → 1,7 % (2020) → 2,7 % (2025). Variación en 5 años +10,7 % (2025), tras
  −12,7 % (2020). Alta tecnología 4,2 % → 8,5 % de las exportaciones (2022). I+D 1,50 % del PIB (UE 2,26 %, 2024).
- Aranceles [G9]: exportaciones a EE. UU., suma de 12 meses, del índice 99,7 (marzo de 2025) a 88,9 (mayo de 2026),
  ≈ −11 %, con repunte hasta 93,0 en agosto de 2026; al mundo, estables (101-103). Peso de EE. UU. 4,7 % (2024) → 4,2 %
  (mayo de 2026); unos 17.000 millones de euros al año (≈ 1 % del PIB). Canales indirectos: cadenas de valor (Alemania),
  desvío de comercio de China hacia la UE, incertidumbre.
- Medidas: diversificación de mercados (acuerdos de la UE), apoyo a la internacionalización (ICEX, financiación), I+D y
  tamaño empresarial, defensa comercial dentro de la UE (la política comercial es comunitaria).
- Guía: `sec:no-precio`, anexo de casos (aranceles de un tercero), `tab:indicadores-exterior`.

## 3. Sector exterior (bloque IV) · peso MEDIO

**Por qué medio**: la gran historia (de −9,4 % a +3,2 %) está resuelta y la PIIN mejora; queda la vulnerabilidad
energética y una PIIN todavía más negativa que el umbral del −35 %.

- Cuenta corriente −9,4 % (2007) → superávit desde 2012 → 3,2 % (2025); capacidad de financiación 4,3 %; previsión 1,9 %
  y 1,8 % (energía) [C7]. Composición [G10]: déficit de bienes (−3,0 %; −4,4 % en 2022) más que compensado por servicios
  (6,8 %; viajes 4,3 %); rentas primarias de −2,8 % (2008) a +0,2 % al bajar la deuda externa.
- ¿Estructural o cíclico? Estructural: superávit con brecha positiva (2018-2019, 2022-2025), exportaciones +56 %, cuota
  estable, devaluación interna, ahorro nacional al 25 % [C4]. Cíclico: en 2009-2013 la corrección vino del hundimiento
  de las importaciones (−18,3 % en 2009) y de la inversión; el déficit de bienes reaparece con la energía.
- Financiación [C7]: hasta 2008 entradas por cartera y otra inversión; 2011-2012 salida privada compensada por el Banco de
  España (otra inversión del BdE −10,6 % y −14,9 %: TARGET2); 2013, devolución.
- PIIN [G11]: −97,2 % (2009) → −40,0 % (2024) → −42,7 % (2025); NENDI −9,7 %; deuda externa neta 42,7 %. En 2025 la PIIN
  pasa de −638.257 a −721.250 millones (−82.993) con una cuenta financiera de +85.198 → otras variaciones ≈ −168.000
  millones (≈ −10 % del PIB): revalorización de los pasivos (bolsa) y depreciación del dólar sobre los activos; la NENDI
  mejora 6,6 pp, así que no es deuda. $\mathrm{PIIN}_t=\mathrm{PIIN}_{t-1}+\mathrm{CF}_t+\mathrm{OV}_t$ (`eq:dinamica-piin`).
- Sostenibilidad: con $\gamma^N$ = 5,7 % y un tipo implícito bajo, el saldo corriente sin intereses que estabiliza la
  deuda externa es negativo: la deuda externa neta baja sola.
- Guía: `sec:exterior` (`eq:identidad-bp`), `sec:cuenta-corriente`, `sec:financiacion`, `sec:piin`, `fig:umbrales-pdm`,
  `sec:sostenibilidad-exterior`, `fig:arbol-deficit`.

## 4 (cont.). Política monetaria (bloque V) · dentro de la pregunta 4, peso ALTO

**Por qué medio**: la política es común (el tono no lo decide España), pero hay dos cosas propias que contar: la
transmisión rápida (hipotecas variables) y que el tipo real es más bajo para España.

- Facilidad de depósito [C8, G12]: −0,50 % hasta julio de 2022 → 4,00 % (20/09/2023) → recortes hasta 2,00 % (11/06/2025)
  → subidas a 2,25 % (17/06/2026) y 2,50 % (16/09/2026). Activo del Eurosistema 15,9 % del PIB de la zona (2007) → 67,7 %
  (2021) → 38,8 % (2025): compras de activos y su reducción. M3 12,3 % (2020), 0,0 % (2023), 2,8 % (2025).
- Tipos de mercado [C4, C8, G12]: Euríbor 3,25 % en septiembre de 2026 (2,22 % de media en 2025); hipotecas nuevas 3,04 %
  (agosto de 2026); bono a 10 años 3,93 % y diferencial con Alemania 45 pb (435 pb en 2012).
- Tipo real a corto ($r\approx i-\pi$): septiembre de 2026, 2,50 − 5,0 = −2,5 % con la inflación española (−1,3 % con la
  europea); 2023: 4,00 − 3,4 = +0,6 %.
- Reacción de 2026: subir ante un choque de oferta solo se justifica si hay riesgo de desanclaje (subyacente europea en el
  2,4-2,6 % desde mayo, general 3,8 %, lección de 2021-2022); subidas graduales de 25 pb.
- Guía: `sec:monetaria`, `fig:esquema-tono`, `fig:esquema-canales`, `fig:tipos-balance-bce`.

## 5. Sistema bancario y estabilidad financiera (bloque V) · peso BAJO

**Por qué bajo**: la banca es rentable y solvente y la deuda privada está en mínimos; el riesgo a vigilar es la vivienda.
Respuesta corta y ordenada (semáforo) con una o dos medidas macroprudenciales.

- [C8]: CET1 13,9 % (UE 16,4 %), capital total 18,1 %, dudosos 2,4 % (UE 2,0 %), ROE 14,2 % (UE 9,3 %), ROA 0,96 %
  (UE 0,71 %): ROE = ROA × apalancamiento (14,2 ≈ 0,96 × 14,8). Muy rentable (margen de intereses con tipos altos y
  crédito variable), por encima de los requisitos, pero con menos capital de máxima calidad que la media. 2012: ROE −25,6 %.
- Riesgos: vivienda (+12,7 % en 2025, precio real cerca del de 2007 [G4]), morosidad si suben los tipos y se enfría la
  economía, concentración en hipotecas a tipo variable; a favor, deuda de los hogares en el 42,9 % del PIB.
- Medidas: colchón de capital anticíclico (el cuadernillo no da su nivel), límites LTV/LTI, vigilancia del crédito para
  vivienda, mantener provisiones.
- Guía: `sec:estabilidad`, `fig:esquema-basilea`, `fig:esquema-semaforo`, `tab:indicadores-financiero`, `tab:basilea`,
  `tab:ratios-banca`.

## 6. Cuentas públicas y política fiscal (bloque V) · peso ALTO

**Por qué alto**: deuda en torno al 100 %, déficit estructural del 3 % con brecha positiva, envejecimiento y nuevas reglas
fiscales: es uno de los retos mayores.

- [C9]: saldo −2,4 % (2025), primario 0,0 %, estructural −3,2 % y estructural primario −0,8 % del PIB potencial;
  previsión −2,4 % y −2,0 %. Deuda 100,5 % (2025), 99,6 % y 98,9 % previstos; máximo 119,3 % (2020).
- Tono [G13]: 2012-2013 consolidación en recesión (+2,9 y +2,5 pp con brecha −8,7 y −9,6: procíclica); 2019 relajación
  con brecha +3,1 (−1,3 pp: procíclica expansiva); 2020-2022 expansiva; 2023-2027 consolidación moderada (+1,3, +0,4, +0,3,
  +0,4, +0,4 pp) con brecha positiva: contracíclica pero tímida.
- Sostenibilidad [G14]: $i$ 2,5 % y $g$ 5,7 % en 2025, $i-g=-3,2$ pp. Saldo primario que estabiliza la deuda:
  (2,49 − 5,72)/1,0572 × 101,4 ≈ −3,1 % del PIB; con primario 0,0 % la deuda debería bajar ≈ 3 pp y bajó 0,9: ajuste
  déficit-deuda de ≈ +2 pp (acumulación de activos; a comprobar, no está en el cuadernillo). Riesgos: el tipo marginal
  (bono 3,9 %) supera ya al implícito (2,5 %) y $g$ se modera (5,1 % y 4,5 %); envejecimiento; defensa. Reglas de 2024:
  senda de gasto primario neto del plan fiscal-estructural de medio plazo (deuda > 60 %).
- *Policy mix* 2026: monetaria contractiva para la zona y fiscal ligeramente contractiva: coherentes; como el tipo real es
  más bajo para España, la fiscal debería apretar algo más.
- Guía: `sec:fiscal`, `eq:dinamica-deuda`, `fig:esquema-deuda`, `fig:impulso-fiscal`, `tab:inflacion-cuentas`,
  `sec:policy-mix`, `fig:policy-mix`.

## 7. Desequilibrios, riesgos y recomendaciones (bloque VI) · peso ALTO

**Por qué alto**: es la síntesis que cierra el examen y donde se juntan los retos de verdad (productividad, paro,
deuda, demografía).

- Fortalezas: crecimiento por encima de la zona del euro; empleo récord; superávit exterior y PIIN mejorando (NENDI
  −9,7 %); desapalancamiento privado; banca rentable; prima de riesgo baja.
- Debilidades: productividad estancada (PIB por hora +0,33 % anual en 2019-2025); paro estructural (10,5 %; juvenil
  24,9 %); deuda pública ≈ 100 % con déficit estructural −3,2 %; envejecimiento (dependencia 31,2 %); dependencia
  energética; vivienda; pérdida de competitividad coste desde 2019; I+D baja (1,50 % frente a 2,26 %).
- Riesgos a la baja de las previsiones (2,4 % y 1,9 %): petróleo caro, endurecimiento del BCE, aranceles, consolidación
  fiscal, fin de los fondos europeos (2026), corrección inmobiliaria. Al alza: inmigración, turismo, ejecución de los
  fondos, inversión en intangibles, datos de 2026 por encima de lo previsto.
- Reformas: productividad (capital humano, tamaño empresarial, I+D, competencia), mercado de trabajo (políticas activas,
  emparejamiento), vivienda (oferta de suelo y alquiler), pensiones y consolidación gradual (FMI: ≈ 0,5 pp del PIB al año;
  guía `anexo:espana`), transición energética, integración de la inmigración.
- Guía: `anexo:matriz`, `tab:matriz`, `sec:por-desequilibrio`, `tab:recomendaciones`, `fig:esquema-recomendacion`,
  `sec:politicas-oferta`.

## Avisos sobre los datos

- **Convenciones**: en el tipo de cambio efectivo real un aumento es una apreciación; la deuda externa neta va en C7 con
  signo positivo y en G11 con signo negativo; en la cuenta financiera, + es salida neta de capital.
- **Dos vintages**: AMECO (primavera de 2026) es anterior a la última revisión del INE (PIB 2025: 2,6 % en el cuadro,
  2,8 % en AMECO). Brecha, potencial y saldos ajustados son de AMECO en toda la serie. Se actualizará con las previsiones
  de otoño (17/11/2026; pasos en README.md).
- **IPCA**: anual con ECOICOP 1 (hasta 2025) y mensual con ECOICOP 2 (G6); coinciden en 2025 (2,7 %).
- **Vacantes**: salto de serie 2009-2010 (C3 y G3 desde 2010). **Banca**: CET1 y dudosos desde 2014. **Alta tecnología**:
  hasta 2022. **I+D**: hasta 2024. **Calificación crediticia y colchón anticíclico**: no hay fuente oficial descargable; no
  están en el cuadernillo.
- **Brent**: EIA, comprobado con FRED. **Exportaciones a EE. UU.**: Comext, valor en euros sin deflactar; la suma móvil de
  12 meses tarda en reflejar los cambios.
