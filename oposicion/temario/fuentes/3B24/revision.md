# Revisión del tema 3.B.24 (13/11/2026)

*Análisis de los instrumentos de renta fija. Determinación del precio y rendimiento de los bonos. La estructura temporal de los tipos de interés. Valoración del riesgo y del rendimiento de los bonos: duración y convexidad.* Sesión de agente en la rama `revision-temario-2` (sin fase canon; lo del canon va en `_trabajo/canon-pendiente.md`). Base: Word de Víctor (`_trabajo/original.md`), `pendientes.md` (P1-P73), propuestas de contenido (C1-C49), de datos (V1-V35) y de coherencia (K1-K31, KC1-KC6) de la sesión del 12/11/2026 (copiadas del worktree `revision`), y las reglas de las tandas 4.ª-9.ª y de la revisión transversal del 13/11/2026.

## Resumen

- Tema reescrito en LaTeX con **3 apartados** que siguen el título: I. Los instrumentos de renta fija: precio y rendimiento (bloques I y II del Word unidos, con sus 5 títulos de segundo nivel); II. La estructura temporal de los tipos de interés; III. Valoración del riesgo y del rendimiento: duración y convexidad. Minutos: 2′30″ + 8′ + 9′ + 9′30″ + 1′ = 30′.
- **Funciones clave**: `eq:precio-bono` ($P=\sum \mathrm{FC}_t/(1+r_t)^t=\sum \mathrm{FC}_t/(1+y)^t$), `eq:tipo-largo` (la misma forma y etiqueta del 3.A.37 y el 3.A.40, derivada aquí del no arbitraje) y `eq:precio-duracion-convexidad`. Un **ejemplo conductor** (el bono de la pregunta 42 del test de julio de 2022) recorre todo el tema: $r_1=10{,}01$ %, $r_2=15$ %, $f_2=20{,}22$ %, TIR 14,75 %, $D=1{,}91$, $D^{\mathrm{mod}}=1{,}66$, $\mathrm{Conv}=4{,}27$.
- **Modelos con estructura a)-e)**: Nelson-Siegel-Svensson, teoría de las expectativas, prima por liquidez, segmentación y hábitat preferente (hasta Vayanos y Vila, 2021), Vasicek y CIR, e inmunización (Redington; Fisher y Weil), con desarrollos por pasos.
- Corregido el núcleo de duración y convexidad (curva plana, nominal en el último flujo, duración monetaria sin la $r$ de más, «menor» convexidad, signo de $\Delta y$) y el *putable*, los CoCos, el €STR/EONIA, el LÍBOR, la operación *Twist* y los autores y fechas de las teorías.
- 17 gráficos y figuras nuevos (TikZ y pgfplots, 4 de datos: curva del BCE, curvas de España y EE. UU., prima de riesgo) en lugar de las 36 capturas; 5 anexos (derivaciones, clasificaciones, bonos verdes, ejemplos resueltos y test). PDF: 31 páginas de tema, 5 de anexos y 5 de bibliografía. Ficha de repaso: 4 páginas a 10,5 pt.

## Errores corregidos

| Dónde (Word) | Decía | Dice ahora |
|---|---|---|
| IV.2.2 Duración y nota 21 | deriva un precio con $r_1,\dots,r_T$ distintos respecto a «$(1+r)$»; la fórmula final y los pesos suman solo «Cupón$_t$» | con **curva plana** ($r_t=y$) y con $\mathrm{FC}_t$ (el nominal en $T$): los pesos suman 1; derivación paso a paso en el anexo A (P58) |
| IV.2.2 | la duración, «elasticidad… ante un cambio porcentual del tipo de interés»; «tiempo promedio que tarda en recuperar el precio» | elasticidad respecto a $1+y$; la modificada, semielasticidad respecto a $y$; no es un plazo de recuperación |
| IV.2.3 | «el cambio porcentual en el precio se define como el producto de la duración modificada y la *yield-to-maturity*» | $\Delta P/P\simeq-D^{\mathrm{mod}}\,\Delta y$ (por la **variación** de la TIR, con signo menos) (P60) |
| IV.2.3 | «Duración en unidades monetarias = Precio · r · Duración Modificada»; «cuánto varía el precio cuando el rendimiento varía 100 pb» | $D^{\mathrm{mon}}=P\,D^{\mathrm{mod}}$; DV01 $=P\,D^{\mathrm{mod}}\times0{,}0001$ (P59, `informe-repaso.md` l. 227) |
| IV.2.3 | «buena medida… hasta 0,5 puntos porcentuales» (sin fuente, V33) | el error se muestra con el ejemplo ($+1$ y $+3$ puntos), sin umbral |
| IV.2.4 Convexidad | «su precio caerá menos que el de otro bono con **mayor** convexidad»; «siempre positiva»; «siempre infraestima» | con **menor** convexidad; positiva y con la duración quedándose corta solo en bonos sin opciones; el *callable* tiene convexidad negativa (P61) |
| I.3.7 *Putable* | «ventaja para el emisor: refinanciar su deuda en condiciones más favorables al incluir la prima por la opción» | el tenedor compra la opción y acepta un **cupón más bajo**: esa es la ventaja del emisor (P62) |
| I.3.7 CoCos | «la conversión depende del emisor… ratio de capital Tier 1… (*bail-in*)» | conversión o pérdida de valor **automática** si el CET1 cae del umbral (al menos el 5,125 %), como el 3.B.3 |
| Nota 10 | «El EONIA fue reemplazado con el €STR en 2020»; LÍBOR como referencia viva | €STR desde el 2/10/2019; EONIA = €STR + 8,5 pb hasta el 3/1/2022; LÍBOR del dólar sin panel desde el 30/6/2023; Euríbor híbrido desde 2019 (V11-V13) |
| I.3.8 | mercado monetario «menor de 18 meses»; bonos de 18 meses a 10 años; obligaciones de más de 10 | mercado monetario hasta 1 año (los 18 meses, en nota); Tesoro: bonos de 2 a 5 años, obligaciones de más de 5 (V15) |
| I.2 | cupones «típicamente semestrales» | anuales en la deuda del Estado español, semestrales en EE. UU. (V18) |
| III.2.1-III.2.5 | «Fisher y Hicks, 1940s»; «Hicks, 1946»; «Culberston»; «Bodie, Kane y Markus, 2018, pág. 497»; «Liebowitz» | Fisher (1896), Hicks (1939), Lutz (1940); Culbertson (1957); Bodie, Kane y Marcus (2021); Leibowitz (V21-V25) |
| III.3.2 | «*flattening twist* en 2012» | operación *Twist* de septiembre de 2011 a finales de 2012, y la de 1961 (V14, como el 3.A.36) |
| III.2.4 y III.3.1 | «En los años 2000 previos a la crisis, había una curva de tipos decreciente… fondos de pensiones» | enigma de Greenspan (2005) y curva de EE. UU. invertida en buena parte de 2006-2007; el ejemplo de hábitat es la reforma de las pensiones del Reino Unido de 2004 (Greenwood y Vayanos, 2010) (P64, V30) |
| III.3.1 | curva plana «puede predecir una recesión… preferencia por la liquidez» (mezcla) | lectura por teorías: tipos constantes con expectativas puras; ligeras bajadas con prima por liquidez (como la 1D01) (P72) |
| IV.1 | 8 riesgos numerados «1, 1, 2…7», sin el de liquidez; Malkiel numerado «1, 1, 2, 8, 9, 10» | 8 riesgos ordenados con el de liquidez; 6 proposiciones numeradas 1-6 (5 de Malkiel y 1 de Homer y Leibowitz) |
| IV.2.1 | en un bono a tipo variable «si se reduce el tipo… se producen pérdidas» | es riesgo de renta (reinversión), no de precio: en cada revisión vale casi el nominal |
| Kessel (1965) | «los emisores prefieren plazos largos porque evitan costes de negociación» | los bonos cortos son sustitutos cercanos del dinero y la prima sube con los tipos (P71) |
| Conclusión | prima de riesgo de «649 puntos» (sin fuente) | 555 pb de media en julio de 2012, máximo de la serie (BCE) (V1) |
| Conclusión | bonos verdes «aumentan en aproximadamente un 4 % la emisión»; NGEU «un tercio» | 4,3 % de las emisiones mundiales (2025); hasta el 30 % de NGEU (V7, V10) |

## Marcas resueltas

| Marca | Qué decía | Qué se hizo |
|---|---|---|
| P1 (amarillo) | pie de las capturas UC3M (Moreno y Gutiérrez, 2018) | capturas pasadas a texto y ecuaciones propias (tipos de contado, *strips*); la cita UC3M se conserva en la fuente del gráfico del precio sucio (`MorenoGutierrez2018RentaFija`, sin URL: duda R24-07) |
| P2-P6 (amarillo) | bloque de expectativas empresariales, ley de los grandes números, hipótesis keynesiana, monetarista y de Fisher | P2-P4, en una nota de «La curva y el ciclo» con los *animal spirits* de Keynes (1936) y `\vertema{3.A.34}`; P5 y P6 quitados (sin fuente, no son de la ETTI) (duda R24-06) |
| P7-P10 (amarillo) | «Fuente: […]» vacías de las imágenes 10-13 | `formas-curva` y `movimientos-curva` en TikZ, «elaboración propia a partir de…» |
| P11-P12 (rojo) | «esperanza de recibir beneficios futuros»; «tiempo y riesgo» | en negro, con «expectativa» y la cita de Bodie, Kane y Marcus, como el 3.B.23 |
| P13-P14 (nota al opositor) | cambio de temario; ficha ICEX-CECO | quitadas; la ficha sirvió para cubrir gestión activa y pasiva y coberturas |
| P15-P16 (nota al opositor) | «Ver Mishkin… cap. 6»; «Ver apuntes de Juan Luis y Bodie, Kane y Markus págs. 513-524» | hecho: los 3 hechos de Mishkin ordenan la valoración de las teorías (tabla 3); inmunización, *cash-flow matching* y gestión activa y pasiva desarrolladas; las notas desaparecen |
| P17-P20 (comentarios) | pregunta 42 de 2022 y apuntes manuscritos de clase | no se publican; la pregunta 42 es el ejemplo conductor y el anexo de ejemplos; el supuesto de curva plana entra en la derivación |
| P39 (anexo 2 manuscrito) | 3 estrategias a 2 años | anexo D con números comprobados y la figura `estrategias-expectativas` |
| P69 (anexo 1 en inglés) | bonos verdes copiados de Investopedia | anexo C redactado en español y al día (ICMA, Reglamento 2023/2631, BIS) |
| quia.com | enlace de test | sustituido por la caja estándar del simulador (`tema=3.B.24`) |

## Datos actualizados

| Dato | Anterior | Nuevo | Fuente | Consulta | 2.ª comprobación |
|---|---|---|---|---|---|
| Curva de la zona del euro (AAA, Svensson) | — (capturas sin fecha) | 2,62 % a 3 m, 3,33 % a 10 a, 3,57 % a 30 a (10/11/2026); invertida (03/07/2023); negativa (30/12/2020) | BCE, YC | 12/11/2026 | Eurostat, criterio de convergencia |
| Curva de España | captura de worldgovernmentbonds | sept. 2026, jul. 2023, dic. 2020 (negativa hasta 5 años, −0,42 %) | Banco de España, BE 22.6-22.7 | 12/11/2026 | BCE (IRS) y subastas del Tesoro |
| Curva de EE. UU. | captura | 10/11/2026, 03/07/2023, 31/12/2020 | Tesoro de EE. UU. | 12/11/2026 | FRED |
| Inversión de EE. UU. | — | 25/10/2022-12/12/2024, mínimo −1,89 el 1/6/2023 | Tesoro (cálculo propio) | 12/11/2026 | FRED; NBER sin recesión |
| Prima de riesgo | 649 pb | 555 pb (jul. 2012); 45 pb (sept. 2026) | BCE, IRS | 12/11/2026 | Eurostat; BdE |
| Rating de España | — | A+ S&P y Scope, A3 Moody's, A Fitch, A (high) DBRS | Tesoro | 12/11/2026 | DBRS (nota de 2024) |
| Renta fija mundial | — | 160,7 billones de $ (2025) | SIFMA | 12/11/2026 | pendiente (BIS) |
| Bonos verdes | «un 4 %», «un tercio» | 4,3 % (2025); NGEU hasta 30 %, 86.240 M€; Tesoro 18.384 M€ | LSEG; Comisión; Tesoro | 12/11/2026 | parcial (CBI) |
| Mercado español | — | AIAF 1,56 billones (pública), 366.625 M (privada); MARF > 10.000 M | BME | 12/11/2026 | parcial (3.B.3) |

Todos en `datos-actualizables.yaml` (14 entradas).

## Contenido añadido

- **Tipos a plazo** (`eq:forward`), **bootstrapping** por pasos con el ejemplo, **Nelson-Siegel-Svensson** con a)-e), el gráfico de los 3 factores y la curva del BCE (el BCE publica los parámetros: la ecuación los reproduce).
- **`eq:tipo-largo` derivada** (no arbitraje exacto → logaritmos → prima), con la misma forma del 3.A.37 y el 3.A.40; **evidencia** (Campbell y Shiller, Fama y Bliss, Cochrane y Piazzesi, ACM); **Vayanos y Vila (2021)**; **Vasicek y CIR** con a)-e); tabla de qué explica cada teoría.
- **La curva y el ciclo** (Estrella y Hardouvelis; Estrella y Mishkin; inversión de 2022-2024 sin recesión) y **la curva y la política monetaria** (*Twist*, compras, control de la curva: cumple la promesa del 3.A.36).
- **Calificación crediticia**, diferencial de crédito y prima de riesgo (gráfico 1993-2026); **rentabilidad realizada**, *yield to call*, letras; **duración efectiva** y **convexidad negativa**; **inmunización** con a)-d) y la derivada $\mathrm{d}V_H/\mathrm{d}y=(1+y)^{H-1}P(H-D)$; **brecha de duración** (forma del 3.B.26); **gestión activa y pasiva**.
- **Nobel** (notas con el motivo oficial): Hicks (1972), Modigliani (1985), Shiller (2013, con Fama y Hansen) y Bernanke (2022).
- **\vertema al 4.º ejercicio**: 4.B.26 (Tesoro, plazos, subastas, bonos verdes, conclusión), 4.A.20 (mercado español) y 4.A.19 (brecha de duración de los bancos).

## Coherencia

- Tabla `tab:renta-fija-variable` copiada del 3.B.23; «cuya remuneración fija un contrato»; los 3 supuestos de la TIR con las palabras del 3.B.2; CoCos como el 3.B.3; `eq:tipo-largo` y «hábitat preferente» como el 3.A.37; control de la curva y *Twist* con las fechas y claves del 3.A.36; «prima por plazo» (sumando) frente a «prima por liquidez» (teoría de Hicks), con el aviso de que no es la preferencia por la liquidez de Keynes (3.A.35).
- Contradicciones con otros temas (no se tocan): 3.B.26, l. 887, escribe $\Delta i$ en la brecha de duración; el 3.B.24 usa $\Delta y$ (canon §11). La 1D01 dice «prima de liquidez»; compatible.
- Notación nueva (a `canon-pendiente.md`): $\mathrm{FC}_t$, $f_t$, $r_n\equiv i^{(n)}_0$, $D^{\mathrm{mon}}$, DV01, $\mathrm{Conv}$, $\Delta y$.

## Revisión transversal (13/11/2026)

- **Nobel**: notas añadidas para Hicks, Modigliani, Shiller (con Fama y Hansen) y Bernanke, con `\nocite` de las entradas existentes en otros temas.
- **4.º ejercicio**: 4.B.26, 4.A.20 y 4.A.19, pocas y detrás de la idea.
- **Refranes**: el del enganche, «¡Cuán largo me lo fiáis!» (nuevo: el Word no tenía refrán), que retoma la idea final. Se conserva uno más, «cada mochuelo a su olivo», integrado en una frase que explica la relación con el hábitat preferente y coherente con el 3.A.37 (duda R24-04). Quitadas todas las «pegatinas» propuestas en la fase 2 («tanto monta», «ni tanto ni tan calvo», «el fiel de la balanza» como dicho, «cuando el río suena», «las cuentas de la lechera»).

## Dudas abiertas

Fecha de todas: 13/11/2026. En todas se ha aplicado la opción recomendada.

- **R24-01 (K1). Cómo pasar de 4 bloques a 3.**
  - Aplicada (a): unir I y II del Word (instrumento y precio) en el apartado I, conservando sus 5 títulos de segundo nivel.
  - Alternativa (b): unir III y IV (ETTI y riesgo).
- **R24-02 (K28, C3). Enganche.**
  - Aplicada (a): «¡Cuán largo me lo fiáis!» con el bono austriaco a 100 años (de 139 a 33 por 100 de nominal, Saxo Bank, 2024; sin segunda fuente oficial: la OeBFA no se ha podido consultar).
  - Alternativas: (b) la obligación del Tesoro a 50 años (cifras sin comprobar); (c) «Al freír será el reír».
- **R24-03 (K14). Título de la teoría de Hicks.**
  - Aplicada (a): «Teoría de la prima por liquidez», con el aviso de que no es la de Keynes.
  - Alternativa (b): «preferencia por la liquidez» con el aviso.
- **R24-04 (K29, 9.ª tanda). «Cada mochuelo a su olivo» en el hábitat preferente.**
  - Aplicada (a): mantenerlo, integrado en una frase, por coherencia con el 3.A.37.
  - Alternativa (b): quitarlo (regla restrictiva de refranes).
- **R24-05 (K21, D3-D5). Notación nueva.**
  - Aplicada (a): $f_t$ para el tipo a plazo, $D^{\mathrm{mon}}$, $\mathrm{Conv}$ y $\Delta y$ en todo el tema, también en la brecha de duración; proponer al 3.B.26 cambiar su $\Delta i$.
  - Alternativas: (b) $f_{m,n}$; (c) dejar $\Delta i$ en el 3.B.26 y avisar.
- **R24-06 (C24). Bloque amarillo P2-P6.**
  - Aplicada (a): la idea de P2-P4 en una nota de «La curva y el ciclo»; P5 y P6 fuera.
  - Alternativa (b): quitarlo todo.
- **R24-07 (P1, C20). Los apuntes de la UC3M.**
  - Aplicada (a): se citan como en el original (Moreno y Gutiérrez, 2018), sin URL, solo en la fuente del gráfico del precio sucio.
  - Alternativa (b): quitar la cita y dejar solo Bodie, Kane y Marcus.
- **R24-08. Vasicek y CIR en el cuerpo.**
  - Aplicada (a): subapartado con a)-e) en II.2 (30″ del cante, sin fórmulas del precio en la pizarra).
  - Alternativa (b): caja gris o anexo, sin cantar.
- **R24-09. Extensión.** El tema ocupa 31 páginas (más que los vecinos): se ha preferido no perder nada del Word ni de lo pedido (NSS, Vasicek/CIR, desarrollos por pasos). Si Víctor lo quiere más corto, lo primero que puede pasar a anexo: Vasicek y CIR, la caja de las curvas de España y EE. UU. y la gestión activa.
- **Pendientes de comprobar** (no cambian el texto si se confirman): cifra de SIFMA con el BIS; precios del bono austriaco con la OeBFA; enlaces de Economipedia e Investopedia (dan 403 a robots).

## Enlaces del original

Se conservan con entrada en el `.bib`: Economipedia (precio sucio), AnalystNotes (*callable*/*putable*), FundsPeople (duración), Mascareñas (monografías, en una caja de lecturas), blog de Vicente Esteve (deuda perpetua), Tesoro (*strips*), Investopedia (bonos verdes) y Forbes (fondos ESG). worldgovernmentbonds.com se sustituye por el BCE, el Banco de España y el Tesoro. Quitado quia.com. No se citan los apuntes de academias ni el tema de Juan Luis Cordero (sin idea concreta tomada; no disponible).

## Instrucciones para el vídeo

- **Enganche e idea final**: «¡Cuán largo me lo fiáis!» y el bono austriaco a 100 años; la idea final lo retoma: el largo plazo se paga 2 veces, con la prima por plazo en el precio y con la duración en el riesgo.
- **Funciones clave que se conservan** en una esquina de la rejilla: `eq:precio-bono` (desde I.4), `eq:tipo-largo` (desde II.2) y `eq:precio-duracion-convexidad` (desde III.2.4).
- **Gráficos y figuras imprescindibles en la pizarra**: la figura `linea-temporal-bono` (I.2); el gráfico `precio-rentabilidad` por capas, que se dibuja en I.5 (curva y punto) y se completa en III.2.3 (tangente, $-P_0D^{\mathrm{mod}}$) y III.2.4 (error que corrige la convexidad), así que conviene no borrarlo entre I y III o volver a trazarlo deprisa; `prima-liquidez` (II.2); `movimientos-curva` o `formas-curva` (II.3, mejor movimientos); `balanza-duracion` (III.2.2).
- **Como apoyo** (no se dibujan): `pull-to-par`, `precio-sucio`, `opciones-bono`, `nss-factores`, `curva-bce-zona-euro`, `curvas-espana-eeuu`, `prima-riesgo-espana`, `malkiel-bonos`, `convexidad-bonos`, `inmunizacion-horizonte`, la figura `estrategias-expectativas` y las tablas.
- **Ejemplo conductor en la pizarra**: el bono a 2 años (1.000 €, 10 %, 922,6 €) y el cupón cero (100 € a 90,9 €): en I.4, el arbitraje (831,7; $r_1$, $r_2$); en II.1, $f_2=20{,}22$ %; en II.2, el tipo esperado; en III.2, $D=1{,}91$, $D^{\mathrm{mod}}=1{,}66$, $+3$ puntos: $-4{,}98$ % frente a $-4{,}80$ %, y con convexidad $-4{,}79$ %; en III.2.5, inmuniza a 1,91 años. Repetir los datos cada vez (no obligar a recordarlos).
- **Desarrollos por pasos**: no arbitraje → logaritmos → prima (II.2); *bootstrapping* en 3 pasos (II.1); inmunización en 4 pasos (III.2.5).
- **No se cantan**: notas al pie, cajas grises (notación, lecturas, curvas de España y EE. UU.), las fórmulas de Vasicek y CIR (solo la idea), las clasificaciones del anexo B y las derivaciones del anexo A.
