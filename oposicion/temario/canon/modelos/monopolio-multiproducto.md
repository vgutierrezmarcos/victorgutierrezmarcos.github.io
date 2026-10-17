# Producción conjunta: monopolio multiproducto, proporciones fijas y monopolio multiplanta

- **Área:** mercados-información-juegos · **Tema de referencia:** **3.A.17** («Producción conjunta» en el título; revisado el 17/10/2026, II.3). Id `monopolio-multiproducto` (ya en `_inventario/alias.json`). Ficha creada a raíz de esa revisión.
- **Temas que lo usan:** 3.A.17 (desarrollo; hecho, 17/10/2026), 3.A.12 (mención: reparto entre plantas como minimización del coste, economías de alcance y complementariedad de costes, III.4; hecho), 3.A.11 (mención: remite a 3.A.17 para el monopolio natural multiproducto; hecho), 3.A.19 (mención prevista: el cártel maximiza como un monopolio multiplanta), 3.A.15 (mención prevista: la doble marginalización tiene la lógica de los complementarios; ficha `monopolio-bilateral`).
- **Manuales de referencia:** Tirole (1988), cap. 1 (multiproducto); Marshall (1890), libro V, cap. 6 (oferta conjunta); Mill (1848); Baumol, Panzar y Willig (1982); Wright (1936) para el aprendizaje.

## Presentación de referencia (3.A.17, II.3)

Pregunta: ¿qué cambia cuando el monopolista vende varios bienes o produce en varias plantas? Conclusión: **internaliza** las relaciones de demanda y de costes entre ellos.

- **Monopolio multiproducto**, q⃗ = (q_1,…,q_n), demandas q_i(p⃗), costes C(q⃗). **4 casos**:
  1. demandas independientes y costes separables: 𝓛_i = 1/|ε_{q_i,p_i}|;
  2. demandas dependientes y costes separables (anexo `anexo:multiproducto`):
$$\mathcal{L}_i=\frac{1}{|\varepsilon_{q_i,p_i}|}+\sum_{j\neq i}\frac{(p_j-\mathrm{CMg}_j)\,q_j}{p_i\,q_i}\cdot\frac{\varepsilon_{q_j,p_i}}{|\varepsilon_{q_i,p_i}|}$$
  (elasticidad de la demanda de j respecto al precio de i): **sustitutivos** (ε_{q_j,p_i} > 0) ⇒ precios más altos que varios monopolistas independientes; **complementarios** ⇒ más bajos, 𝓛_i menor que la inversa de la elasticidad propia, incluso negativo (consolas e impresoras);
  3. demandas independientes y costes no separables: **complementariedad de costes** ∂²C/∂q_1∂q_2 < 0 (implica economías de alcance, 3.A.12), IMg_i(q_i) = ∂C(q⃗)/∂q_i, se produce más de los 2;
  4. los 2 efectos a la vez.
  - El **aprendizaje** no es el caso 3: es el mismo bien en 2 periodos (nota): IMg_1(q_1) = c_1 + βc_2'(q_1)q_2 < c_1, con β el factor de descuento; Wright (1936); ficha `curva-aprendizaje`.
  - Un precio por debajo del CMg corriente (complementarios, aprendizaje) **no** se llama subsidio cruzado: el término se reserva para Faulhaber (1975) (ficha `monopolio-natural`).
- **Producción conjunta en proporciones fijas** (a)-c); oferta conjunta de Marshall, coque y gas de Mill): cada unidad del proceso, de coste C(q), da una de cada bien; se vende s_i ≤ q (propuesto x_i, `pendientes-coherencia.md`) y se puede desechar el resto:
$$\mathrm{IMg}_1(q)+\mathrm{IMg}_2(q)=\mathrm{CMg}(q)\ \text{(suma vertical)};\qquad \text{en general } \sum_i\max\{\mathrm{IMg}_i(q),0\}=\mathrm{CMg}(q)$$
  si en ese punto un IMg es negativo, se vende de ese bien hasta IMg = 0 (elasticidad unitaria) y se desecha el resto. Implicaciones: el reparto del coste conjunto es arbitrario; el monopolista puede destruir producción útil.
- **Monopolio multiplanta**: max p(q_1+q_2)(q_1+q_2) − C_1(q_1) − C_2(q_2) ⇒ IMg(Q) = CMg_1(q_1) = CMg_2(q_2), Q = q_1 + q_2: cuánto (IMg con la suma horizontal de los CMg) y cómo repartirlo (minimizar el coste, 3.A.12); con CMg constantes y capacidades, orden de mérito; **el cártel resuelve el mismo problema** (3.A.19).
- **Bienestar**: frente a monopolistas independientes, mejor para los consumidores con complementarios y peor con sustitutivos; el ahorro de costes es eficiencia productiva.

**Gráfico de referencia:** `oposicion/temario/fuentes/3A17/graficos/produccion-conjunta.tex` (suma vertical de los ingresos marginales; apoyo, no pizarra). En la pizarra, solo la estructura de la regla de Lerner con el término cruzado y sus 2 signos.

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.17 | Producción conjunta | desarrollo (hecho, 17/10/2026) | Todo lo anterior | — |
| 3.A.12 | Costes multiproducto y multiplanta | mención (hecho) | Reparto entre plantas (CMg iguales), alcance y complementariedad de costes como propiedades de C(w⃗,q⃗); remite a 3.A.17 | Las reglas de precios |
| 3.A.11 | Producción | mención (hecho) | Remisión para el monopolio natural multiproducto | — |
| 3.A.19 | Oligopolio | mención (prevista) | El cártel maximiza el beneficio conjunto como un monopolio multiplanta; remitir a 3.A.17 II.3.3 | La derivación |

## Divergencias encontradas en el temario actual
- 3.A.17 original: Lerner multiproducto con ε_{q_i,p_j} (era ε_{q_j,p_i}) y «mayor» en el paréntesis de los complementarios; costes no separables confundidos con el aprendizaje; «subsidio cruzado» para un precio por debajo del CMg; sin el 4.º caso, sin proporciones fijas y sin multiplanta. **Resuelto** en la revisión (17/10/2026).
- 3.A.17 revisado: s_i para la cantidad vendida en las proporciones fijas choca con la participación s_i (§ 2 y § 3) y con la tasa s de Averch-Johnson del mismo tema: propuesto x_i (`pendientes-coherencia.md`).
- 3.A.19 (sin revisar): no remite al 3.A.17 para el cártel como multiplanta (`faltan` de 3.A.19).

Autor: Víctor Gutiérrez Marcos
