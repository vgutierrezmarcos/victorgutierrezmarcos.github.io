# Modelo IS-LM (Hicks, 1937; Modigliani, 1944; Hansen)

- **Área:** pensamiento · **Tema de referencia:** **3.A.5** (La síntesis neoclásica. El monetarismo; revisado el 3/11/2026: I.2 `sec:islm` con a)-e), anexo A `anexo:islm` con el álgebra) — es el modelo de la síntesis y el único tema que lo desarrolla entero. El Word del 3.A.4 lo desarrollaba con el reparto anterior al temario vigente (D031): al revisarlo, resumen.
- **Temas que lo usan:** 3.A.5 (desarrollo; hecho, 3/11/2026), 3.A.4 (resumen; hecho, 4/11/2026: la lectura de Hicks en 3 viñetas, sin ecuaciones ni casos), 3.A.28 (mención; hecho, 31/10/2026: II.1.1, una viñeta: en la síntesis el paro existe porque el salario nominal es rígido; con salarios flexibles, solo la trampa de la liquidez o una inversión insensible al tipo lo impiden, `\vertema{3.A.5}`; los casos, en el anexo A), 3.A.34 (mención; hecho, 31/10/2026: I.3, 3 viñetas-puente, la inversión de Keynes con $I=\overline I-b\,i$ en la IS, y la nota de las pendientes en I.1 con $M/P=kY-h\,i$; `\vertema{3.A.5}`), 3.A.37 (resumen: transmisión keynesiana), 3.A.38 (resumen: efectividad de la política fiscal), 3.A.39 (resumen: financiación del déficit, Blinder-Solow), 4.B.4 (resumen). En economía abierta, Mundell-Fleming (ref. 3.A.32, D014) y OA-DA abierta (3.A.32). También 3.A.7 (mención; hecho, 4/11/2026: contextualización, la síntesis traduce a Keynes al IS-LM, `\vertema{3.A.5}`; II.2, la IS dinámica sale de la optimización del hogar, a diferencia de la IS de la síntesis).
- **Manuales de referencia:** Hicks (1937), «Mr. Keynes and the “Classics”; A Suggested Interpretation», *Econometrica* (no «Reinterpretation»); Modigliani (1944); Hansen (1949, 1953); Dornbusch, Fischer y Startz, *Macroeconomía*, caps. 10-12; Blanchard, *Macroeconomics*, cap. 6; Heijdra (2009), cap. 1; De Vroey y Hoover (2004); De Vroey (2016), caps. 1-3; Fischer (1986), NBER WP 1797; Bordo y Schwartz (2003) para el debate de las pendientes.
- **Decisión D009 (13/10/2026):** ¿Cómo se escribe la sensibilidad de la inversión al tipo de interés en IS-LM y Mundell-Fleming? b (I = Ī − b·i), como Dornbusch-Fischer-Startz; v queda solo para la relación capital-producto (acelerador, Harrod-Domar)
- **Decisión D031 (13/10/2026):** ¿Se deshace el cruce de contenidos entre los Word de 3.A.4 y 3.A.5? Sí: IS-LM y la curva de Phillips (síntesis) a 3.A.5 (Phillips en resumen; desarrollo en 3.A.28); el desequilibrio (Patinkin, Clower, Leijonhufvud, Malinvaud) a 3.A.4

## Presentación de referencia (3.A.5, I.2)

Estructura a)-e) (CRITERIOS): a) idea; b) modelo con i) supuestos, ii) desarrollo, iii) implicaciones; c) extensiones; d) evidencia; e) valoración.

**a) Idea.** Hicks (1937) reduce la *Teoría general* y la teoría clásica a un mismo sistema para ver en qué se diferencian y llama **LL** a su segunda curva; Modigliani (1944) separa el submodelo clásico (salarios flexibles) del keynesiano (salario nominal rígido a la baja); la etiqueta IS-LM se generaliza con Hansen (1949, 1953) (sin decir quién cambió LL por LM: no hay fuente). IS es *investment = saving*; LM, *liquidity preference = money supply*. **Pregunta:** ¿cómo se determinan a la vez la renta y el tipo de interés a corto plazo, y qué eficacia tienen las políticas fiscal y monetaria?

**b) i) Supuestos:** economía cerrada, a corto plazo, P = P̄ (recursos ociosos; la producción se ajusta a la demanda); π^e = 0, de modo que i = r (decirlo); 3 mercados (bienes, dinero, bonos) y la ley de Walras: basta con la IS y la LM (el IS-LM es un equilibrio general pequeño, no un equilibrio parcial marshalliano); consumo $C=\overline C+c\,Y^d$ con $Y^d=(1-t)Y$; inversión $I=\overline I-b\,i$ (`\vertema{3.A.34}`); $\overline G$ exógeno; demanda de saldos reales $kY-h\,i$ (`\vertema{3.A.35}`) y $M$ fijada por el banco central.

**b) ii) Desarrollo** (las 2 primeras, `\funcionclave`; con $\overline A\equiv\overline C+\overline I+\overline G$):

$$\text{IS (\texttt{eq:is}):}\quad Y=\frac{\overline A-b\,i}{1-c(1-t)},\qquad \frac{di}{dY}=-\frac{1-c(1-t)}{b}$$

$$\text{LM (\texttt{eq:lm}):}\quad \frac{M}{P}=kY-h\,i\ \Longleftrightarrow\ i=\frac{1}{h}\Big(kY-\frac{M}{P}\Big),\qquad \frac{di}{dY}=\frac{k}{h}$$

$$\text{Equilibrio (\texttt{eq:equilibrio-islm}):}\quad Y^*=\frac{h\,\overline A+b\,M/P}{h[1-c(1-t)]+bk},\qquad i^*=\frac{k\,\overline A-[1-c(1-t)]\,M/P}{h[1-c(1-t)]+bk}$$

Lectura de las pendientes, con las mismas palabras que el 3.A.34: **b grande, IS más plana; h grande, LM más plana**.

**b) iii) Implicaciones:**
- Multiplicador fiscal con **efecto expulsión** (de E a F con el simple, a E′ con expulsión; `eq:multiplicador-fiscal`): ∂Y*/∂Ḡ = 1/[1 − c(1−t) + bk/h] < 1/[1 − c(1−t)].
- Multiplicador monetario, canal del tipo de interés (de E a E″; `eq:multiplicador-monetario`; `\vertema{3.A.37}`): ∂Y*/∂(M/P) = b/{h[1 − c(1−t)] + bk}.
- **Casos extremos** en tabla (`tab:casos-islm`; A05-09, **[decidir]**: tabla en lugar del gráfico de 3 miniaturas), con los keynesianos en azul y los clásicos en verde: general; trampa de la liquidez (h → ∞, LM horizontal: fiscal con el multiplicador simple, monetaria 0); clásico (h = 0, LM vertical, la teoría cuantitativa Y = (1/k)M/P: fiscal 0, monetaria 1/k); inversión insensible (b = 0, IS vertical: fiscal simple, monetaria 0); inversión muy sensible (b → ∞, IS horizontal: fiscal 0, monetaria 1/k). El **debate de las pendientes** se anuncia aquí y se desarrolla en el monetarismo (ficha `monetarismo`, gráfico `pendientes`).
- **¿Paro de equilibrio con precios flexibles?** En 3 pasos y con estos nombres (los del 3.A.28, anexo A, y del 3.A.21, III.3): **efecto Keynes** (baja P, sube M/P, la **LM** se desplaza a la derecha); falla en los 2 casos de Keynes (trampa de la liquidez, inversión insensible: «bajar salarios no crea empleo»); **efecto saldos reales o efecto Pigou-Patinkin** (C̄ crece con M/P, se desplaza la **IS**; `\vertema{3.A.21}`, `\vertema{3.A.4}`; ficha `patinkin`). Conclusión de Modigliani (1944): el paro involuntario existe porque el salario nominal es rígido a la baja; Keynes, caso particular.

**c) Extensiones:**
- **DA** (`\funcionclave` `eq:da`): la misma expresión de Y* leída para cada P, $Y=\dfrac{h\,\overline A+b\,M/P}{h[1-c(1-t)]+bk}$; decreciente en (Y, P) por el efecto Keynes; vertical en la trampa de la liquidez o con b = 0, y el efecto Pigou-Patinkin la vuelve a inclinar. **OA**: a corto plazo creciente con el salario nominal rígido **W₀** (local; W̄ es la riqueza, D002) u horizontal en P̄ con precios fijos; a largo plazo vertical en **Y^n**. Ajuste: el dinero es neutral a largo plazo; la expansión fiscal acaba en expulsión total.
- IS-LM-BP (Mundell, 1963; Fleming, 1962) con `\vertema{3.A.32}`; financiación del déficit (Blinder y Solow, 1973) con `\vertema{3.A.39}`.

**d) Evidencia:** esqueleto de los modelos macroeconométricos (Klein y Goldberger, 1955; los de los 60 con cientos de ecuaciones); dominó unos 25 años la macroeconomía y la política (De Vroey y Hoover, 2004).

**e) Valoración:** virtudes, sencillez y versatilidad (Fischer, 1986, literal: «la versatilidad del modelo es responsable de su supervivencia»); críticas que abren el resto del 3.A.5: precios dados (falta la Phillips), un solo canal y un solo activo (monetaristas), estático y sin microfundamentos (Lucas, 1976, `\vertema{3.A.6}`), el paro como salario rígido sin justificar (desequilibrio, `\vertema{3.A.4}`).

**Gráficos de referencia** (`oposicion/temario/fuentes/3A05/graficos/`):
- `is-lm.tex` (**imprescindible**): plano (Y, i) por capas: ejes, IS, LM, E con proyecciones; IS′, F y E′ con la flecha de la expulsión; LM′ y E″.
- `da-oa.tex` (apoyo): DA decreciente en (Y, P), OA de corto plazo con W₀ y vertical de largo plazo en Y^n.
- `pendientes.tex` (**imprescindible** en el monetarismo): 2 paneles, keynesianos (IS inclinada, LM plana) y monetaristas (IS plana, LM inclinada), con la misma expansión fiscal y monetaria.
- La derivación algebraica, en el anexo A del 3.A.5 (`eq:anexo-is`, `eq:anexo-lm`), que no se canta.

## Cómo se adapta en cada tema

| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.5 | La síntesis neoclásica | desarrollo (hecho, 3/11/2026) | a)-e) completo en 6′; IS, LM y DA como funciones clave; tabla de casos; efectos Keynes y Pigou-Patinkin; DA-OA; debate de las pendientes en el monetarismo con el matiz de Bordo y Schwartz (2003): Friedman no hacía depender su tesis de una LM vertical | — |
| 3.A.4 | Keynes y su pensamiento | resumen (hecho, 4/11/2026) | II.3 «La lectura de Hicks: el IS-LM» en 3 viñetas sin ecuaciones ni casos: Hicks (1937, «A Suggested Interpretation»), Modigliani (1944) y la síntesis (Keynes como el caso de los salarios rígidos); el multiplicador de II.1 va «a tipo dado» (`eq:multiplicador`) y la IS sale de él con el tipo variable; $h\to\infty$, la trampa, en nota de `eq:liquidez`; «¿traducción o traición?» como puente a los postkeynesianos y al desequilibrio. El gráfico `is-lm` del 3.A.5, solo de apoyo en el vídeo | Las ecuaciones, la DA y los casos extremos (3.A.5) |
| 3.A.28 | Tasa natural y NAIRU | mención (hecho, 31/10/2026) | Solo como marco de demanda (II.1.1) y la curva de Phillips que lo cierra; los casos de la trampa de la liquidez y la inversión inelástica, en el anexo A | Todo lo demás |
| 3.A.34 | Teorías de la inversión | mención (hecho, 31/10/2026) | La inversión keynesiana dentro de la IS; con $b$ pequeño la IS es muy inclinada | Las ecuaciones completas y los casos |
| 3.A.37 | Transmisión monetaria | resumen | Canal del tipo de interés en la síntesis: M ↑ → i ↓ → I ↑ → Y ↑, con sus 2 eslabones débiles (h grande, b pequeño), frente al reajuste de carteras monetarista | La política fiscal |
| 3.A.38 | Efectos de la política fiscal | resumen | Multiplicador con expulsión (`eq:multiplicador-fiscal` del 3.A.5); debate de las pendientes | La política monetaria |
| 3.A.39 | Financiación del déficit | resumen | Blinder-Solow: financiación con deuda frente a dinero y efecto riqueza | Las ecuaciones básicas |
| 4.B.4 | Política fiscal española | resumen | Ecuaciones y gráfico mínimo, con la notación del 3.A.5 y su remisión | — |
| 3.A.7 | NEK | mención (hecho, 4/11/2026) | La IS de la síntesis frente a la IS dinámica, estructural; `\vertema{3.A.5}` | Las ecuaciones |

## Divergencias encontradas en el temario actual

- **Cruce entre 3.A.4 y 3.A.5** (D031): resuelto en el 3.A.5 (3/11/2026), que desarrolla IS-LM y Phillips (esta en resumen); queda el 3.A.4, que al revisarse pasa el IS-LM a resumen y recibe el desequilibrio.
- **Resuelto en el 3.A.5**: título de Hicks («Reinterpretation»), «IS: *Investment and Savings*, LM: *Liquidity and Money*», «el IS-LM muestra que la dicotomía clásica no se cumple» (a corto plazo, con precios dados; a largo plazo el dinero es neutral), el IS-LM como «visión marshalliana de equilibrio parcial», la cita de Stanley Fischer sin fuente, Hansen «cambió la terminología a IS-LM».
- **Sensibilidad de la inversión v** (3.A.4, 3.A.37, 3.A.38, 4.B.4) choca con v = relación capital-producto (acelerador, 3.A.34; Harrod-Domar, 3.A.43): canon **b** (I = Ī − b·i, Dornbusch-Fischer-Startz), también en Mundell-Fleming.
- **3.A.4** usa r en la inversión e i en la demanda de dinero sin decir que con π^e = 0 coinciden.
- **3.A.37** incluye XN en la IS de una economía cerrada: quitarlo o remitir a Mundell-Fleming.
- **Signo de la LM:** M/P = kY − h·i (4.B.4) e i = (1/h)(kY − M/P) (3.A.37, 3.A.38) son equivalentes; el 3.A.5 escribe las 2 en `eq:lm`.

Autor: Víctor Gutiérrez Marcos
