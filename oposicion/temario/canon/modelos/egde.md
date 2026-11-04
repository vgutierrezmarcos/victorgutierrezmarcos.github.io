# Surgimiento de los modelos de equilibrio general dinámico estocástico (EGDE)

- **Área:** pensamiento · **Tema de referencia:** **3.A.6** (La nueva macroeconomía clásica… el surgimiento de los EGDE; revisado el 4/11/2026: III.2 `sec:caracteristicas-egde` y III.4 `sec:surgimiento-egde`) — está en el título.
- **Reparto con el 3.A.7** (conciliado en la fase canon del 3.A.6, CC2; resuelve el desajuste entre el K23 del 3.A.7, que se quedaba la transición, y esta ficha, que la ponía en el 3.A.6): el **3.A.6 desarrolla el surgimiento** (qué es un EGDE, el ciclo real como primer EGDE, calibración y después estimación) y **resume** la secuencia hasta Smets y Wouters y los HANK en 4 viñetas; el **3.A.7 desarrolla la nueva síntesis** (los EGDE neokeynesianos, fichas `nek-3-ecuaciones` y `nueva-economia-keynesiana`) y las críticas posteriores a 2008. Cada uno remite al otro (`\vertema{3.A.7}` en III.4 del 3.A.6; `\vertema{3.A.6}` en II.1 del 3.A.7).
- **Temas que lo usan:** 3.A.6 (desarrollo; hecho, 4/11/2026); 3.A.7 (resumen; hecho, 4/11/2026: II.1, el método de la 2.ª generación como «apalancamiento sobre la nueva macroeconomía clásica», el EGDE con sus 4 letras, l. 513, más competencia monopolística y rigideces; De Vroey, 2016: el ciclo real y la NEK como 2 transformaciones del programa EGDE; III.2, Smets y Wouters, 2003 y 2007, en los bancos centrales; `\vertema{3.A.6}`); 3.A.21 (mención; hecho, 14/10/2026: los EGDE como versión agregada e intertemporal del equilibrio general); 3.A.29 (mención; hecho, 1/11/2026: el agente representativo como base de los EGDE); 3.A.1 (mención; hecho, 4/11/2026: III.3.2 `sec:evolucion-revolucion`, ¿evolución o revolución tras 2008?, con Romer, 2016, Stiglitz, 2018, Blanchard, 2018, Reis, 2018, Galí, 2018, Vines y Wills, 2018, Farmer y Leijonhufvud, leído con Kuhn y Lakatos; anexo A, el EGDE de ciclo real de palabra —hogares, empresas competitivas, sin sector público— con las 4 letras). Conectan con 3.A.42 (ciclo real) y 3.A.29 (modelización dinámica).
- **Manuales de referencia:** Kydland y Prescott (1982), *Econometrica* (`KydlandPrescott1982Time`); Long y Plosser (1983), *JPE*; Prescott (1986); Kydland y Prescott (1996), *JEP* (`KydlandPrescott1996Computational`); Kocherlakota (2010) (`Kocherlakota2010Modern`); Smets y Wouters (2003, 2007); Christiano, Eichenbaum y Evans (2005); Galí (2015), cap. 1; Romer (2019), cap. 5; De Vroey (2016), caps. 12-18.

## Presentación de referencia (3.A.6, III.2 y III.4)

**Pregunta:** ¿cómo se construye la macroeconomía tras la crítica de Lucas, y cómo se convirtió el ciclo real en el modelo estándar?

**Qué es un EGDE** (definición común con el 3.A.7, l. 513; Kocherlakota, 2010, traducida): «*dinámico* se refiere a que hogares y empresas miran hacia delante; *estocástico*, a que hay *shocks*; *general*, a que se incluye toda la economía; y *equilibrio*, a que se explicitan las restricciones y los objetivos de hogares y empresas». Son «las reglas del juego» que la NEK aceptará después.

**El ciclo real como modelo de crecimiento con 3 cambios** (`\vertema{3.A.43}`): parte del RCK con hogar y empresa representativos (`\vertema{3.A.29}`), competencia perfecta y sin fallos de mercado, y añade (1) perturbaciones aleatorias y persistentes a la PTF, (2) una oferta de trabajo que responde al salario y al tipo de interés (Lucas-Rapping) y (3) formas funcionales explícitas con valores numéricos.

**Cómo se resuelve**: sin fallos de mercado, el equilibrio competitivo coincide con el planificador (**1TFEB**, `\vertema{3.A.22}`); las CPO se **log-linealizan** alrededor del estado estacionario (Buiter, 2009, en nota: se pierden los umbrales y los aceleradores no lineales) y se resuelven numéricamente.

**Cómo se lleva a los datos**: la **calibración** en 5 pasos (construir, calibrar con promedios de largo plazo y estudios micro, resolver, simular y comparar momentos); un «experimento computacional», no un contraste formal (Kydland y Prescott, 1996). *El precio*: menos transparencia, y el agente representativo deja fuera la distribución (`\vertema{3.A.29}`).

**La secuencia** (III.4, en 4 viñetas con la línea del tiempo): (1) **1982-1988**, el ciclo real calibrado (Kydland y Prescott, 1982; Long y Plosser, 1983; Prescott, 1986; ficha `rbc`); (2) **años 90**, los EGDE neokeynesianos con competencia monopolística y precios escalonados: la **nueva síntesis neoclásica** (Goodfriend y King, 1997; Rotemberg y Woodford, 1997; ficha `nek-3-ecuaciones`, `\vertema{3.A.7}`); (3) **años 2000**, los modelos medianos **estimados** con métodos bayesianos (Christiano, Eichenbaum y Evans, 2005; Smets y Wouters, 2003 y 2007), adoptados por los bancos centrales (NAWM del BCE, Christoffel, Coenen y Warne, 2008); (4) **desde 2008**, fricciones financieras (BGG, 1999; ficha `bernanke-gertler`), el límite inferior (`limite-inferior-tipos`) y los HANK (Kaplan, Moll y Violante, 2018; ficha `hank`). *Lectura* de De Vroey (2016): ciclo real y NEK de 2.ª generación son 2 transformaciones sucesivas del programa EGDE, no 2 escuelas enfrentadas. *Críticas* en una viñeta (Paul Romer, 2016; Stiglitz, 2018; Blanchard, 2018), desarrolladas en el 3.A.7 y el 3.A.1.

**Ecuaciones:** las del ciclo real (ficha `rbc`) como prototipo; no se repiten aquí.

**Gráficos de referencia:** `oposicion/temario/fuentes/3A06/graficos/irf-rbc.tex` (respuestas a una perturbación tecnológica de una desviación típica, simulación propia con `irf-rbc.py`) y la franja `linea-tiempo-nmc.tex`, que completa la secuencia (el gráfico `egde-secuencia` de las propuestas no se hizo, A06-15).

## Cómo se adapta en cada tema

| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.6 | La NMC y el surgimiento de los EGDE | desarrollo (hecho, 4/11/2026) | Las 4 letras, el ciclo real como RCK con 3 cambios, 1TFEB, log-linealización, calibración; la secuencia ciclo real → NEK → modelos estimados → HANK en 4 viñetas; críticas en una | La nueva síntesis y las críticas en extenso (`\vertema{3.A.7}`); las ecuaciones del ciclo real en detalle (anexo D y `\vertema{3.A.42}`) |
| 3.A.7 | NEK de 2.ª generación | resumen (hecho, 4/11/2026) | Las 4 letras (las mismas palabras) y los 2 cambios de la NEK; los modelos medianos estimados como herramienta de los bancos centrales; críticas tras 2008 en desarrollo; `\vertema{3.A.6}` | El ciclo real y la calibración |
| 3.A.21 | Equilibrio general | mención (hecho, 14/10/2026) | Los EGDE como versión agregada e intertemporal del equilibrio general | — |
| 3.A.29 | Modelización dinámica | mención (hecho, 1/11/2026) | El agente representativo como base de los EGDE | — |
| 3.A.42 | Ciclos reales y nominales | mención (hecho, 4/11/2026) | II.1.1, el ciclo real como «primer modelo EGDE» con las 4 letras de Kocherlakota (las mismas palabras) y la linealización con la nota de Buiter (2009); el NAWM II del BCE como heredero de Smets y Wouters (2003) en II.2.3 | El surgimiento (`\vertema{3.A.6}`) |
| 3.A.1 | Métodos | mención (hecho, 4/11/2026) | Paradigma dominante y su crítica tras 2008 (Romer, 2016; Stiglitz, 2018; Blanchard, 2018) | El modelo |

## Divergencias encontradas en el temario actual

- **3.A.6 (Word)** reducía el «surgimiento de los EGDE» a las características del ciclo real, repetidas en I y en III.2, y atribuía la nueva síntesis a Solow. **Resuelto** (4/11/2026): III.2 y III.4, con Goodfriend y King (1997).
- **3.A.7 frente a esta ficha** (K23 del 3.A.7: «la transición queda aquí»): **resuelto** con el reparto de arriba; el texto revisado de los 2 temas ya lo cumple (comprobado: mismas claves `GoodfriendKing1997New`, `SmetsWouters2003Estimated`, `SmetsWouters2007Shocks`, `ChristianoEichenbaumEvans2005`, `KaplanMollViolante2018Monetary`, `Romer2016Trouble`, `Stiglitz2018Wrong`).

Autor: Víctor Gutiérrez Marcos
