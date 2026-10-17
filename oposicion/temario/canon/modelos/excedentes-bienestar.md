# Excedentes del consumidor y del productor; teoremas del bienestar en equilibrio parcial

- **Área:** mercados-información-juegos · **Tema de referencia:** 3.A.16 (Mercados I: análisis de eficiencia y bienestar; revisado el 17/10/2026, II.2)
- **Temas que lo usan:** 3.A.16 (desarrollo; hecho, 17/10/2026), 4.B.6 (resumen: valoración en el ACB), 3.A.17 (mención: comparación del monopolio con el competitivo, PIE; hecho, 17/10/2026); lo usan además 3.B.7 (arancel), 4.B.8 y 4.B.9 (impuestos).
- **Manuales de referencia:** Mas-Colell, Whinston y Green, cap. 10.C-10.E; Marshall (1890), libro III, cap. VI; Dupuit (1844); Varian, cap. 14; Harberger (1964).

## Presentación de referencia (3.A.16, II.2)
**Pareto** (1906): asignación factible que no admite otra en la que alguien mejore sin que nadie empeore; criterio mínimo, ordinal e incompleto (3.A.24). Con utilidad cuasilineal el numerario pasa de un agente a otro uno a uno (FPU recta de pendiente −1): una asignación es óptima de Pareto **si y solo si maximiza el excedente total**, y los óptimos solo difieren en el reparto del numerario (MWG § 10.D; anexo A del 3.A.16). El excedente es medida exacta del bienestar (VC = ΔEC = VE, ficha `vc-ve`, 3.A.9). Principio de compensación (mejora potencial de Pareto).
$$\mathrm{EC}=\int_0^{x^*}p^D(x)\,dx-p^*x^*,\qquad \mathrm{EP}=p^*q^*-\int_0^{q^*}p^S(q)\,dq,\qquad \mathrm{ET}=\mathrm{EC}+\mathrm{EP}$$
con p^S(q) el coste marginal de la industria; EP_j = B_j + CF_j (el EP es el beneficio antes de los costes fijos). ET(x) = ∫_0^x (p^D − p^S): ET'(x) = 0 ⇔ p^D(x*) = CMg(q*), x* = q*.

**1TFEB en equilibrio parcial** (`\funcionclave` `eq:max-et`):
$$\max_{(x_i)_i,(q_j)_j}\ \sum_{i=1}^{I}\phi_i(x_i)-\sum_{j=1}^{J}C_j(q_j)\quad\text{s.a.}\ \sum_ix_i=\sum_jq_j,\ x_i\ge0,\ q_j\ge0$$
CPO: φ_i'(x_i) = λ si x_i > 0, CMg_j(q_j) = λ si q_j > 0: son las condiciones del equilibrio (`eq:equilibrio`) con **λ* = p*** (precio sombra). Supuestos como la ficha `teoremas-bienestar` (precio-aceptantes, un mercado para cada bien, precios comunes, no saciedad local, que asegura el numerario); **no necesita convexidad ni rendimientos no crecientes** (vale con libre entrada y CMe en U) ni la forma cuasilineal. Fallos: poder de mercado (3.A.17), externalidades y bienes públicos (3.A.23), impuesto (cuña). «Mano invisible» (3.A.2). Origen: Lerner (1934) y Lange (1942); Arrow (1951) y Debreu (1951), como el 3.A.21.
**2TFEB en equilibrio parcial**: inmediato, porque las transferencias de numerario de suma fija no cambian x* ni q* (sin efecto renta); la versión general exige convexidad y el hiperplano separador (3.A.22). Separación eficiencia-equidad.

**Gráfico de referencia:** `oposicion/temario/fuentes/3A16/graficos/excedentes.tex` (oferta y demanda con las áreas de EC y EP en el equilibrio; **imprescindible**). La pérdida irrecuperable de un impuesto, en `incidencia.tex` (ficha `incidencia-equilibrio-parcial`); la de los precios máximos y mínimos, en `controles-precios.tex` (anexo C del 3.A.16). Estática comparativa normativa (choques de demanda y de oferta: el EP sube con la demanda, el EC con la mejora técnica; el otro, ambiguo), `choques.tex`.

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.16 | Eficiencia y bienestar | desarrollo (hecho, 17/10/2026) | Pareto, EC, EP, ET con p^D y p^S, maximización de ET como `\funcionclave` junto a la del equilibrio (λ* = p*), 1TFEB y 2TFEB parciales; anexo A paso a paso; impuesto y controles de precios | Los teoremas en general (3.A.22) |
| 4.B.6 | ACB | resumen | Valoración de insumos y productos del proyecto con cambios de excedentes (mercado del asfalto) | Las demostraciones |
| 3.A.17 | Monopolio | mención (hecho, 17/10/2026) | I.3: el competitivo maximiza ET (1TFEB parcial, remite a 3.A.16 y 3.A.22; en equilibrio parcial cuasilineal Pareto y eficiencia asignativa coinciden); transferencia, PIE ≈ ½𝓛p^Mq^M = B/2, con `bienestar-monopolio.tex` (mismos colores que `excedentes.tex`: EC morado, EP y transferencia dorado, pérdida rojo al 30 %); 1.er grado eficiente con EC = 0; Ramsey-Boiteux con ET(p⃗) = EC(p⃗) + B(p⃗) | Definiciones y teoremas |
| 3.B.7, 4.B.8 | Arancel, impuestos | mención | Triángulo de pérdida | Definiciones |
| 3.A.9 | Medidas de cambio en el bienestar del consumidor | resumen (hecho, 13/10/2026) | $\Delta\mathrm{EC}=\int_{p_1^1}^{p_1^0}x_1\,dp_1$ de un consumidor; exacto con efecto renta nulo; independencia del camino; Willig como justificación de usarlo en equilibrio parcial [3.A.16] (ficha `vc-ve`) | Excedente del productor y teoremas parciales (3.A.16) |

## Divergencias encontradas en el temario actual
- 3.A.16 original escribía $P(x^*)=C'(x^*)$, Dupuit (1884), el 1TFEB con «rendimientos no crecientes» y el 2TFEB «no demostrable por contradicción»: resuelto (17/10/2026), $p^D(x^*)=\mathrm{CMg}(q^*)$ con $x^*=q^*$, Dupuit (1844), sin convexidad y 2TFEB inmediato con cuasilineales.
- Bienestar total: $W$ en 3.A.17 (Ramsey-Boiteux) chocaba con $W(\cdot)$ función de bienestar social y $\overline W$ renta: canon $\mathrm{ET}$ (excedente total) en equilibrio parcial. **Resuelto** en la revisión del 3.A.17 (17/10/2026), que también corrige «eficiencia asignativa ≠ Pareto» y el 1.er grado «con ineficiencia asignativa».
- Nombres de la pérdida: **PIE** (pérdida irrecuperable de eficiencia) en general, triángulo de Harberger (1954) en el monopolio; con un impuesto, **exceso de gravamen (EG)**, triángulo de Harberger (1964) (3.A.16). No es una divergencia: cada tema usa el nombre de su caso (`notacion.md` § 0 y § 14).
