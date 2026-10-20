# Oligopolio de Bertrand (1883): competencia simultánea en precios y sus salidas

Variantes en la ficha: `edgeworth-capacidad` (ciclos de Edgeworth) y `kreps-scheinkman` (capacidad elegida antes). Id relacionado: `liderazgo-precios` (la casilla secuencial en precios, solo en el 3.A.19).

- **Área:** mercados-información-juegos · **Tema de referencia:** **3.A.19** (Teoría del oligopolio…; revisado el 20/10/2026, I.4 `sec:bertrand`, con el anexo `anexo:gatillo` para la colusión con Bertrand) — lo desarrolla con a)-d) y ordena sus 5 salidas. Ficha creada a raíz de esa revisión (K31 de coherencia).
- **Temas que lo usan:** 3.A.19 (desarrollo; hecho, 20/10/2026), 3.A.18 (mención; hecho, 19/10/2026: los 5 supuestos de la paradoja con las mismas palabras; levanta el 2.º con producto diferenciado, $p^B<p^C$, ficha `oligopolio-diferenciado`; Hotelling con $p=c+t$), 3.A.14 (mención; hecho, 19/10/2026: Bertrand como EN), 3.A.16 (mención histórica; hecho, 17/10/2026: las críticas de Bertrand, 1883, y Edgeworth al tanteo de Walras, nota de la historia del tanteo), 3.A.15 (mención; hecho, 20/10/2026: θ = 0 «competencia o Bertrand» en la NOIE), 3.B.8 (mención: Eaton y Grossman, 1986, con competencia en precios, ficha `brander-spencer`), 3.B.6 (mención: Bertrand como contraste del dumping recíproco, ficha `brander-krugman`).
- **Manuales de referencia:** Bertrand (1883); Mas-Colell, Whinston y Green (1995), § 12.C; Tirole (1988), cap. 5; Vives (1999), cap. 5; Edgeworth (1897); Levitan y Shubik (1972); Kreps y Scheinkman (1983); Dastidar (1995); Davidson y Deneckere (1986); Maskin y Tirole (1988); Singh y Vives (1984); Byrne y de Roos (2019).

## Presentación de referencia (3.A.19, I.4)

Pregunta: ¿qué pasa si las empresas eligen precios? Conclusión: con 2 empresas iguales, el precio es el coste marginal (**paradoja de Bertrand**); la paradoja descansa en 5 supuestos, y levantar cada uno es una **salida** que ordena buena parte de la teoría.

- **a) Idea**: la objeción de Bertrand (1883) a Cournot: las empresas eligen precios, no cantidades.
- **b) Modelo. i) Supuestos**: 2 empresas, producto homogéneo, el mismo coste marginal constante $c$, sin restricciones de capacidad, eligen **a la vez** el precio una sola vez; demanda de la empresa $i$: $x(p_i)$ si $p_i<p_j$, $\tfrac12x(p_i)$ si $p_i=p_j$, 0 si $p_i>p_j$. **ii) Desarrollo**: mejores respuestas ($p^M$ si $p_j>p^M$; «un céntimo por debajo» si $c<p_j\le p^M$; cualquier $p_i\ge c$ si $p_j\le c$); **único EN** $p_1^B=p_2^B=c$ (MWG § 12.C); reacciones crecientes (**complementos estratégicos**). **iii) Implicaciones**: **paradoja de Bertrand** (2 empresas, resultado competitivo, eficiente, 3.A.22); los **5 supuestos** de la paradoja, con estas palabras (las mismas del 3.A.18): costes marginales iguales, producto homogéneo, sin restricciones de capacidad, contexto estático y sin cooperación.
- **c) Extensiones (las salidas)**: costes **distintos** $c_1<c_2$ (la eficiente cobra un céntimo por debajo de $c_2$ y se queda el mercado); costes **crecientes** (oferta competitiva $S_i(p)$; con racionamiento no hay equilibrio en puras; obligada a servir, un intervalo de equilibrios; Dastidar, 1995); **capacidad limitada**: ciclos de **Edgeworth** (variante `edgeworth-capacidad`: capacidad $k<x(c)\le2k$, racionamiento eficiente, demanda residual $x(p)-k$, $\overline p=\arg\max(p-c)[x(p)-k]$, $(\underline p-c)k=(\overline p-c)[x(\overline p)-k]$; mixtas de Levitan y Shubik, 1972; equilibrio en puras $p(2k)$ si la capacidad es pequeña; ciclos como equilibrio de Maskin y Tirole, 1988; gasolina en Perth); **capacidad elegida antes** (variante `kreps-scheinkman`: juego en 2 etapas cuyo único ENPS es el resultado de Cournot); **producto diferenciado** ($p^B<p^C$, Singh y Vives, 1984; 3.A.18); **contexto dinámico** (ficha `cartel`, colusión tácita con β ≥ 1 − 1/n); **cooperación** (ficha `cartel`).
- **d) Valoración**: ¿Cournot o Bertrand? No son rivales sino modelos de mercados distintos: Cournot donde la capacidad se decide antes y es cara de cambiar (cantidades, sustitutos estratégicos, competencia más suave); Bertrand donde sobra capacidad o se produce por encargo (precios, complementos estratégicos, competencia más dura).

**Gráficos de referencia:** `oposicion/temario/fuentes/3A19/graficos/bertrand-reaccion.tex` (plano $(p_1,p_2)$, reacciones justo por debajo de la bisectriz entre $c$ y $p^M$, corte en $(c,c)$) y `3A19/graficos/edgeworth.tex` (demanda residual y ciclo de precios). Los 2 son de apoyo; en la pizarra, la lista vertical de los 5 supuestos con su salida al lado. Con producto diferenciado, `3A18/graficos/reaccion-diferenciado.tex` (ficha `oligopolio-diferenciado`).

**Notación** (`notacion.md` § 4): $p_i$, $x(p)$, $x_i(p_i,p_j)$, $c$, $c_1<c_2$; $p^B$ (superíndice B en cursiva: Bertrand; $p^B=c$ en el homogéneo); $R_i(p_j)$; **$k$ capacidad** (local de este apartado, con nota: no es el capital ni el grado de homogeneidad); $\overline p$, $\underline p$ (Edgeworth); $S_i(p)$ oferta competitiva (local); «un céntimo por debajo» con palabras (nunca $p_1=c_2-\varepsilon$: ε es elasticidad).

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.19 | Soluciones no cooperativas | desarrollo (hecho, 20/10/2026; 3′30″ en el cante) | Todo lo anterior | El producto diferenciado (3.A.18) y la definición de EN (3.A.14) |
| 3.A.18 | Diferenciación como salida | mención (hecho, 19/10/2026) | Los 5 supuestos con las mismas palabras; levanta el 2.º; $p^B<p^C$ | El homogéneo y las demás salidas |
| 3.A.14 | EN | mención (hecho, 19/10/2026) | Bertrand como ejemplo de EN; remite al 3.A.19 | — |
| 3.A.16 | Historia del tanteo walrasiano | mención (hecho, 17/10/2026) | Bertrand (1883) y Edgeworth critican el tanteo de Walras (no es el modelo de oligopolio) | El modelo |
| 3.B.8 | Política comercial estratégica | mención | Eaton y Grossman (1986): con precios, el instrumento óptimo es un impuesto a la exportación (complementos estratégicos) | La paradoja |

## Divergencias encontradas en el temario actual
- 3.A.19 original: $P_1=\mathrm{CMg}_2-\varepsilon$ (ε es elasticidad); CMg_1 < CMg_2 como siglas; gráfico de Bertrand con producto diferenciado repetido del 3.A.18. **Resuelto** (20/10/2026): «un céntimo por debajo», $c_1<c_2$, una línea y remisión al 3.A.18.

Autor: Víctor Gutiérrez Marcos
