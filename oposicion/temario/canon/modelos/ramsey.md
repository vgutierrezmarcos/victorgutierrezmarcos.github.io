# Regla de Ramsey (1927): imposición óptima de bienes

- **Área:** sector público · **Tema de referencia:** 4.B.11 (imposición óptima) — está en el título («Regla de Ramsey»).
- **Temas que lo usan:** 4.B.11 (desarrollo), 4.B.13 (mención: tipos no uniformes de los impuestos especiales e IVA), 4.B.20 (mención prevista: tipos reducidos del IVA), 3.A.17 (variante Ramsey-Boiteux, ficha propia `ramsey-boiteux`)
- **Manuales de referencia:** Ramsey (1927), «A contribution to the theory of taxation», *EJ*; Diamond y Mirrlees (1971), *AER*; Atkinson y Stiglitz, *Lectures*, lección 12; Stiglitz y Rosengard, cap. 20; Rosen y Gayer, cap. 16; Salanié, *The Economics of Taxation*, cap. 3; Informe Mirrlees (2011), cap. 6 y 9.

## Presentación de referencia
**Pregunta:** si hay que recaudar $\bar R$ solo con impuestos sobre bienes (sin suma fija y sin poder gravar el ocio), ¿qué estructura de tipos minimiza el exceso de gravamen?

**Supuestos:** consumidor representativo (o idénticos); precios de producción fijos (oferta perfectamente elástica, $p_i$ dados, normalizados a 1 si conviene); ocio no gravable; sin suma fija; recaudación exógena $\bar R$; sin consideraciones de equidad (se añaden con Diamond, 1975).

**Ecuaciones (notación canónica; $q_i=p_i+t_i$ precio al consumidor):**
$$\min_{t_1,\dots,t_n} EG=-\tfrac12\sum_i\sum_j S_{ij}t_it_j \quad\text{s.a.}\quad \sum_i t_i x_i\ge\bar R ,$$
condición de óptimo: $\dfrac{EGMg_i}{RMg_i}=\lambda$ para todo $i$. Forma general (**reducción proporcional de la demanda compensada**):
$$\frac{\sum_k t_k S_{ik}}{h_i}=-\theta\quad\forall i,\qquad \theta\in(0,1)\ \text{común}.$$
Caso de demandas independientes (**regla de la elasticidad inversa**, ficha `elasticidad-inversa`): $\dfrac{t_i}{q_i}=\dfrac{\theta}{\lvert\varepsilon^h_i\rvert}$.

**Resultado principal:** el impuesto óptimo reduce en la misma proporción la demanda compensada de todos los bienes; con demandas independientes, tipos inversamente proporcionales a la elasticidad. El tipo uniforme solo es óptimo en casos especiales (Corlett-Hague, Atkinson-Stiglitz). Tensión con la equidad: los bienes inelásticos suelen ser de primera necesidad (Diamond, 1975: la regla se corrige con la covarianza entre consumo y utilidad marginal social de la renta).

**Gráfico de referencia:** dos mercados independientes con oferta horizontal; mismo tipo genera triángulos de EG muy distintos según la pendiente; en el óptimo se igualan $EGMg/RMg$. No hay `.tex` todavía.

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 4.B.11 | Tipo y estructura óptimos | Desarrollo | Planteamiento, condición $EGMg/RMg=\lambda$, regla de reducción proporcional, elasticidad inversa, Corlett-Hague, Diamond-Mirrlees (eficiencia productiva), Diamond (1975, equidad), Atkinson-Stiglitz | El EG desde cero (resumen y «[ver tema 4.B.9]») |
| 4.B.13 | Teoría de la imposición indirecta | Mención | Justificación de tipos diferenciados y de los impuestos especiales; contrapeso de equidad y de administración (Informe Mirrlees: tipo único de IVA + transferencias) | La derivación |
| 4.B.20 | IVA en España | Mención prevista | Tipos reducidos: argumento Ramsey/Corlett-Hague frente a su coste recaudatorio y su mala focalización | — |
| 3.A.17 | Monopolio natural | Variante (otra ficha) | Ramsey-Boiteux: $\frac{p_i-CMg_i}{p_i}=\frac{\lambda}{1+\lambda}\frac{1}{\lvert\varepsilon_i\rvert}$ | Confundirla con la regla impositiva |

## Divergencias encontradas en el temario actual
- **Nombre:** «Ramsey» designa en el temario tres cosas: la regla impositiva (4.B.11, 4.B.13), el modelo de crecimiento Ramsey-Cass-Koopmans (3.A.6, 3.A.29, 3.A.42-3.A.43) y la tarificación Ramsey-Boiteux (3.A.17, 4.B.15). **Propuesta:** escribir siempre «regla de Ramsey (1927)», «modelo de Ramsey-Cass-Koopmans» y «precios de Ramsey-Boiteux». `_inventario/alias.json` lista «ramsey» como alias de `ramsey-cass-koopmans`: hay que quitarlo (ya hay excepción para 3.A.6) para que el mapa no cuente mal.
- 4.B.11: la lista inicial de «6 reglas» está corrupta (punto 5 vacío, el 6 con el texto de Corlett-Hague, luego 7) Diamond y 8) Corlett-Hague otra vez); $\tau$ con tres significados; falta el 3.1. Mirrlees y la fórmula de Saez están vacíos aunque el título pide el «tipo impositivo óptimo».
- 4.B.13: las fórmulas de elasticidad inversa y de Ramsey son imágenes vacías.
- 4.B.15 escribe «Ramsey-Boiteaux»: es **Boiteux**.
- 4.B.1 y 4.B.5 atribuyen el «índice de Frank» a «Frank Ramsey»: error (ver `indicadores-tamano-sector-publico.md`).
