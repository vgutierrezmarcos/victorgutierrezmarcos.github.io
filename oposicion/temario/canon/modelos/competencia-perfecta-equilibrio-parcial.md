# Competencia perfecta en equilibrio parcial

- **Área:** mercados-información-juegos · **Tema de referencia:** **3.A.16** (Mercados I: competencia perfecta; revisado el 17/10/2026) — lo tiene en el título y lo desarrolla entero (construcción con J fijo, estudio positivo y normativo, plazos y libre entrada).
- **Temas que lo usan:** 3.A.16 (desarrollo; hecho, 17/10/2026), 3.A.12 (mención: p = CMg y la oferta desde los costes; hecho, 14/10/2026), 3.A.21 (mención: competencia perfecta en un mercado aislado, precio-aceptación y frontera parcial-general, remite aquí; hecho, 14/10/2026), 4.A.15 (mención: referencia de eficiencia); 3.A.13 (mención; hecho, 19/10/2026: la economía de la información levanta el supuesto 2, «información perfecta y simétrica», con esas palabras); 3.A.17 (mención: punto de comparación del monopolio; hecho, 17/10/2026); 3.A.18 (mención: misma tabla con la fila 3 levantada; hecho, 19/10/2026); lo usan como punto de partida 4.B.8 (incidencia) y 3.B.7 (arancel en equilibrio parcial).
- **Manuales de referencia:** Mas-Colell, Whinston y Green (1995), cap. 10 (§ 10.B-10.F); Varian (1992), caps. 13 y 21; Marshall (1890), libro V; Viner (1931); Pérez Domínguez (2004).

## Presentación de referencia (3.A.16)

**Pregunta:** ¿cómo se forma el precio en un mercado en el que nadie puede fijarlo, llega el mercado a él por sí solo, es bueno el resultado y qué cambia con el plazo?

**Supuestos** (I.1, tabla `tab:supuestos`): la lista canónica de abajo. Equilibrio parcial: un mercado con los demás precios dados, que resume el numerario (precio 1), y preferencias cuasilineales (sin efecto renta).

## Supuestos canónicos de las estructuras de mercado

Regla de CRITERIOS.md § 6 (Víctor, 18/10/2026). Los cuatro temas de estructuras de mercado (3.A.16 competencia perfecta, 3.A.17 monopolio, 3.A.18 competencia monopolística y 3.A.19 oligopolio) parten de **esta misma lista**, con este orden y estas palabras (los nombres en negrita son fijos), en una tabla como la `tab:supuestos` del 3.A.16 (columnas «N.º», «Supuesto» y «Qué significa»). Cada tema la repite idéntica y **marca de forma visible el supuesto que levanta** (fila resaltada o con «se levanta: …»); el 3.A.16 la presenta completa y deja en una `notaopositor`: «Los temas 3.A.17 a 3.A.19 parten de esta misma lista y marcan el supuesto que levantan».

| N.º | Supuesto | Qué significa |
|---|---|---|
| 1 | **Agentes racionales** | los consumidores maximizan su utilidad y las empresas, su beneficio |
| 2 | **Información perfecta y simétrica** | los consumidores conocen las características del producto y el precio, y las empresas, su tecnología y el precio; nadie sabe más que los demás |
| 3 | **Producto homogéneo (sin sustitutivos cercanos)** | los consumidores ven como sustitutivos perfectos las unidades de todas las empresas, de modo que solo les importa el precio |
| 4 | **Mercado atomizado: muchos compradores y vendedores (precio-aceptantes)** | cada uno es pequeño respecto al mercado y sus decisiones individuales no mueven el precio: todos son precio-aceptantes, y el precio lo determinan las decisiones de todos juntos, no las de ninguno en particular |
| 5 | **Libre entrada y salida (a largo plazo)** | a largo plazo, si hay beneficios extraordinarios, entran empresas hasta agotarlos, y si hay pérdidas, salen |

El orden es el del temario antiguo (Víctor, 18/10/2026): de los agentes y la información al producto, el número de agentes y la entrada.

Qué levanta cada tema (orientativo; lo concreta cada revisión): 3.A.17, el 4 por el lado de la oferta (un solo vendedor, que fija el precio), con barreras que impiden el 5 (hecho así en el 3.A.17); 3.A.18, el 3 (producto diferenciado), con el 4 «se mantiene en parte» y el 5 en pie en la competencia monopolística; en su bloque II (oligopolio diferenciado) levanta además el 4 y el 5, salvo en la ciudad circular de Salop, con libre entrada (hecho así en el 3.A.18, 19/10/2026); 3.A.19, el 4 (pocos vendedores, que se saben interdependientes), a menudo con barreras al 5. Levantar el 2 (información perfecta y simétrica) lleva a la economía de la información (3.A.13).

## Presentación de referencia (3.A.16), continuación

**Supuestos del modelo** (I.2 i): 2 bienes, x y el numerario n; I consumidores i = 1,…,I con dotación de numerario W̄_i (incluye su parte de los beneficios); J empresas j = 1,…,J con costes C_j(w⃗,q_j) y w⃗ fijo; **número de empresas fijo y todos los factores variables** en I y II (es el largo plazo sin libre entrada).

**Consumidores:**
$$U_i(n_i,x_i)=n_i+\phi_i(x_i),\qquad \max_{n_i,x_i}\ n_i+\phi_i(x_i)\ \text{s.a.}\ n_i+p\,x_i\le\overline W_i\ \Rightarrow\ \phi_i'(x_i)=p,\quad x_i(p)=(\phi_i')^{-1}(p),\quad x(p)=\sum_{i=1}^{I}x_i(p)$$
Demanda **marshalliana** («ordinaria o walrasiana», una vez), sin efecto renta (coincide con la hicksiana); λ = 1. Demanda inversa **p^D(x)**: beneficio marginal social. ε_D = (dx/dp)(p/x) < 0.

**Productores** (maximización en 2 etapas, 3.A.12):
$$\max_{q_j\ge0}\ B_j=p\,q_j-C_j(q_j)\ \Rightarrow\ p=\mathrm{CMg}_j(q_j)\ (\text{tramo creciente}),\qquad q(p)=\sum_{j=1}^{J}q_j(p)$$
Supuesto: CMg_j creciente en el tramo relevante (no hace falta F estrictamente cóncava). Inacción: produce si p cubre el **mínimo del CMe** sin costes hundidos (I-II, III.2) o del **CVMe** a corto plazo (III.1); con CMe en U, la oferta salta de 0 a q̄_j en c̄_j = min CMe_j. Oferta inversa **p^S(q) = q^{−1}(q)**: coste marginal de la industria. ε_S ≥ 0.

**Equilibrio** (`\funcionclave` `eq:equilibrio`): φ_i'(x_i*) = p* (i = 1,…,I), p* = CMg_j(q_j*) (j = 1,…,J), Σ_ix_i* = Σ_jq_j* (esquinas: φ_i'(0) ≤ p* si x_i* = 0; p* ≤ CMg_j(0) si q_j* = 0). Gráficamente, p^D(x*) = p^S(q*) con x* = q*.

**Estudio del equilibrio** (II): existencia por Bolzano con z(p) = x(p) − q(p) continua (no convexidades: salto de la oferta en c̄); unicidad con curvas normales (sin intercambio y precio indeterminado si max φ_i'(0) < min CMg_j(0)); estabilidad (ficha `tatonnement`) y telaraña (ficha `telarana`); bienestar (ficha `excedentes-bienestar`); estática comparativa con z(p;α) y el principio de correspondencia, dp*/dα = −(∂z/∂α)/z'(p*); impuesto (ficha `incidencia-equilibrio-parcial`).

**Plazos** (III; tabla `tab:plazos`): solo con la terminología moderna (MWG 10.F); los periodos de Marshall (periodo de mercado, valor normal; ficha `marshall-equilibrio-parcial`) van aparte, en una caja de antecedente histórico con el gráfico del pescado dentro, sin mezclarlos con estos (Víctor, 18/10/2026):
- **corto plazo**: C_j(q_j) = CF_j + CV_j(q_j), CF hundido; oferta sobre el **mínimo de explotación** (min CVMe), pérdidas como mucho CF_j; q^CP(p) = Σ_jq_j^CP(p);
- **largo plazo sin libre entrada**: todos los factores variables, J fijo; oferta sobre el min CMe; **Le Chatelier-Samuelson**, ∂q^LP_j/∂p ≥ ∂q^CP_j/∂p ≥ 0 (ficha `costes-corto-largo-plazo`); beneficio no negativo, que perdura como renta si la entrada está cerrada (Clark, 1899; cuasirrentas de Marshall);
- **largo plazo con libre entrada**: (p*, q*, J*) con q* que maximiza p*q − C(q), x(p*) = J*q* y p*q* − C(q*) = 0 ⇒ p* = CMg(q*) = CMe(q*) = min CMe. Casos: rendimientos constantes (p* = c, J* y q* indeterminados con J*q* = x(c)); decrecientes en todo el dominio (no hay equilibrio); crecientes en todo el dominio (no hay equilibrio competitivo: monopolio natural, 3.A.17); **CMe en U** (`\funcionclave` `eq:largo-plazo`): p* = c̄ = min CMe, q* = q̄, J* = x(c̄)/q̄ (entero). Eficiencia productiva y asignativa (1TFEB sin convexidad).
- **Oferta de la industria a largo plazo** con C(q_j; q): costes **constantes** (horizontal), **crecientes** (deseconomías externas: creciente, más elástica que la de corto) y **decrecientes** (economías externas de Marshall: decreciente). Economías externas pecuniarias y tecnológicas (Viner, 1931; Scitovsky, 1954); solo las tecnológicas causan ineficiencia (3.A.23). Una empresa con rendimientos crecientes **internos** en todo el dominio no es compatible con la competencia.

**Gráficos de referencia** (`oposicion/temario/fuentes/3A16/graficos/`): `agregacion-demanda.tex` (apoyo); `oferta-empresa.tex` (CMg, CMe, salto en c̄; **imprescindible**); `equilibrio.tex` (suma horizontal de las ofertas y equilibrio, D y S; **imprescindible**); `no-convexidad.tex` y `multiplicidad.tex` (apoyo); `choques.tex` (dos paneles; apoyo); `oferta-corto-plazo.tex` (mínimo de explotación); `libre-entrada.tex` (tres casos de rendimientos; profundización); `corto-largo-industria.tex` (empresa | industria, A → B → C tras un aumento de la demanda; **imprescindible**); `oferta-largo-plazo.tex` (costes constantes, crecientes y decrecientes; apoyo). Tablas de color: `tab:supuestos` (lista canónica), `tab:plazos`, `tab:beneficio-economico` (dentro de su caja de anotaciones, como el gráfico `marshall-periodos`). Anexo D del 3.A.16: el equilibrio parcial como caso particular del general (numerario, ley de Walras, θ_ij).

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.16 | Equilibrio, ajuste, bienestar y plazos | desarrollo (hecho, 17/10/2026) | Todo lo anterior (I 8'30", II 12', III 6'); enlaza con `tatonnement`, `telarana`, `excedentes-bienestar`, `incidencia-equilibrio-parcial`, `marshall-equilibrio-parcial` y `costes-corto-largo-plazo` | Las propiedades de C en w⃗ y la geometría de los costes (resumen y anexo B con el gráfico del 3.A.12); la historia del tanteo (3.A.21) |
| 3.A.12 | Costes y estructura de mercado | mención (hecho, 14/10/2026) | p = CMg en el tramo creciente por encima del mínimo del CVMe (corto) o del CMe (largo); tamaño indeterminado con rendimientos constantes; remite a 3.A.16 | El equilibrio de mercado |
| 3.A.21 | Equilibrio general | mención (hecho, 14/10/2026) | Equilibrio parcial frente a general; precio-aceptación; `notaopositor` de la frontera (simétrica de la del final de I.1 del 3.A.16) | El modelo de un mercado |
| 4.A.15 | Defensa de la competencia | mención | Competencia perfecta como benchmark (1TFEB) | Modelo |
| 3.A.17 | Monopolio | mención (hecho, 17/10/2026) | Comparación p = CMg frente a IMg = CMg: la empresa precio-aceptante tiene IMg = p (\|ε_{q,p}\| → ∞, 𝓛 = 0); equilibrio competitivo de referencia q^c, p^c con p(q^c) = CMg(q^c) (en el 3.A.16, x* = q*, p*, con p^D y p^S); con rendimientos crecientes, p = CMg da pérdidas (monopolio natural) | La construcción del equilibrio |
| 3.A.18 | Competencia monopolística y oligopolio diferenciado | mención (hecho, 19/10/2026) | Tabla `tab:supuestos` idéntica a la del 3.A.17, con la fila 3 en salmón y «Se levanta» y la 4 «Se mantiene en parte» (I.1); II.1 remite a ella y levanta además el 4 y el 5 (salvo Salop); escala mínima eficiente $\bar q$ como referencia del exceso de capacidad ($q^*<\bar q$) | El modelo de un mercado |

## Divergencias encontradas en el temario actual
- Resueltas en la revisión del 3.A.16 (17/10/2026): $C_i(\bar q_i,w)$ y otras cinco formas de la función de costes → $C_j(\vec w,q_j)$ y $C_j(q_j)$; demanda «walrasiana» → marshalliana; $P(x)$ → $p^D(x)$; $C'(q)=q^{-1}(q)=P(q)$ (oferta inversa confundida con la demanda inversa) → $p^S(q)$; consumidores $m$ y empresas $i$ → $i$ y $j$; $J$ como número de bienes, suprimido; $Q(p)$ → $q^{\mathrm{LP}}(p)$; F estrictamente cóncava a la vez que CMe en U → CMg creciente en el tramo relevante; «$p\ge\min CMe$» sin distinguir plazos → CVMe a corto, CMe a largo; $p^*\ge c$ en la libre entrada → $p^*\le c$ para que haya solución y $p^*=c$.
- Pendiente fuera del 3.A.16: el 3.A.12 (l. 443) dice «por encima del mínimo del coste medio» sin el matiz del plazo (`pendientes-coherencia.md`, recomendado y menor).

Autor: Víctor Gutiérrez Marcos
