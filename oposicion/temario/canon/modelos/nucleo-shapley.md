# Juegos cooperativos con utilidad transferible: núcleo y valor de Shapley

- **Área:** mercados-información-juegos · **Tema de referencia:** **3.A.14** (Teoría de juegos; revisado el 19/10/2026, II.3.2 y II.3.3, con el anexo `anexo:cooperativos`) — único tema que desarrolla los juegos cooperativos con utilidad transferible. Ficha creada a raíz de esa revisión (C2; D6 del 3.A.14, aplicada con la opción recomendada, pendiente de que Víctor la confirme). El **núcleo de una economía** de intercambio, sin utilidad transferible, y el teorema de Debreu y Scarf tienen su referencia en el 3.A.21 (ficha `nucleo`).
- **Temas que lo usan:** 3.A.14 (desarrollo; hecho, 19/10/2026), 3.A.21 (mención; hecho, 14/10/2026: núcleo sin utilidad transferible, Gillies, 1959; valor de Shapley con un continuo de agentes, Aumann, 1975; ficha `nucleo`), 3.A.19 (resumen aplicado; hecho, 20/10/2026: III.2 `sec:reparto`, cártel de 3 empresas iguales con $p=4-Q$, $c=0$ y la función característica de las coaliciones que compiten a la Cournot, $v(\{i\})=1$, $v(\{i,j\})=16/9$, $v(N)=4$; núcleo $x_i\ge1$ no vacío; $\phi_i(v)=4/3$ en el núcleo, pero $16/9>4/3$ fuera del cártel; paradoja de las fusiones, Salant, Switzer y Reynolds, 1983; estabilidad interna y externa, d'Aspremont *et al.*, 1983; ficha `cartel`), 3.A.24 (mención: índice de poder de Shapley-Shubik, 1954), temas del 4.º que repartan costes comunes (mención, si lo citan).
- **Manuales de referencia:** Gillies (1959); Shapley (1953, 1967, 1971); Bondareva (1963); Shapley y Shubik (1954); Debreu y Scarf (1963); Aumann (1975); Mas-Colell, Whinston y Green (1995), cap. 18 (apéndice); Osborne y Rubinstein (1994), caps. 13-14; Peleg y Sudhölter (2007).

## Presentación de referencia (3.A.14, II.3.2-II.3.3)

Pregunta: con acuerdos vinculantes y más de 2 jugadores, ¿qué repartos son estables frente a las coaliciones y cuál es equitativo? Conclusión: el núcleo responde a la primera (puede ser vacío o grande); el valor de Shapley, a la segunda (existe siempre y es único, pero no tiene por qué estar en el núcleo).

- **Supuestos**: acuerdos vinculantes y **utilidad transferible** (los pagos se suman y redistribuyen, con dinero).
- **Elementos**: $N$; coaliciones $T\subseteq N$; función característica $v(T)$, con $v(\varnothing)=0$; reparto $x=(x_1,\dots,x_n)$; **imputación**: eficiente, $\sum_{i\in N}x_i=v(N)$, e individualmente racional, $x_i\geq v(\{i\})$.
- **Núcleo** (Gillies, 1959): $T$ bloquea $x$ si $v(T)>\sum_{i\in T}x_i$;
$$\mathcal{C}(v)=\Big\{x:\ \sum_{i\in N}x_i=v(N),\quad \sum_{i\in T}x_i\geq v(T)\ \ \forall\,T\subseteq N\Big\}.$$
  Puede ser vacío (reparto de 100 por mayoría); Bondareva-Shapley: no vacío si y solo si el juego es equilibrado; rara vez un solo punto; en una economía sin utilidad transferible, se encoge hasta el equilibrio walrasiano (Debreu y Scarf, 1963; 3.A.21).
- **Valor de Shapley** (Shapley, 1953): axiomas de eficiencia, simetría, **jugador nulo** (el «ficticio» en nota) y aditividad; única regla (`eq:shapley`):
$$\phi_i(v)=\sum_{T\subseteq N\setminus\{i\}}\frac{|T|!\,\big(n-|T|-1\big)!}{n!}\,\Big[v\big(T\cup\{i\}\big)-v(T)\Big],$$
  la **aportación marginal esperada** con un orden de llegada aleatorio; en el núcleo si el juego es convexo (Shapley, 1971); $2^{n-1}$ coaliciones por jugador; aplicaciones: poder de voto (Shapley-Shubik), reparto de costes, atribución en estadística y aprendizaje automático, continuo de agentes (Aumann, 1975).
- **Ejemplo de referencia** (el del 3.A.14): **un vendedor y 2 compradores**. El 1 valora el objeto en 20; los compradores 2 y 3, en 60 y 100: $v(\{1\})=20$, $v(\{1,2\})=60$, $v(\{1,3\})=v(N)=100$, el resto 0. Núcleo: $x_2=0$, $x_1\in[60,100]$, $x_3=100-x_1$ (el objeto va a quien más lo valora a un precio entre la 2.ª y la 1.ª valoración: el resultado de la subasta inglesa). Shapley: $\phi=(66\tfrac23,\ 6\tfrac23,\ 26\tfrac23)$, **fuera del núcleo**. (La propuesta de coherencia era el juego de los guantes, núcleo (1, 0, 0) y Shapley (2/3, 1/6, 1/6); se aplicó el del vendedor porque enlaza con las subastas: duda D9 del 3.A.14.)

**Gráfico de referencia:** `oposicion/temario/fuentes/3A14/graficos/nucleo.tex` (símplice de imputaciones del ejemplo con el núcleo como segmento); tabla `tab:shapley` del anexo C (aportaciones marginales en los 6 órdenes).

**Notación:** $N$, $T\subseteq N$ (𝒮 en la economía del 3.A.21, porque allí S es el número de estados), $v(T)$, $x$, $\mathcal C(v)$, $\phi_i(v)$ (`\phi`, **siempre con el argumento v**: φ_i(x_i) es la cuasilineal del 3.A.16, en otro tema; `notacion.md` § 1). $v(T)$ y la valoración $v_i$ de las subastas conviven en el 3.A.14 en apartados distintos (aviso en nota).

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.14 | Juegos cooperativos | desarrollo (hecho, 19/10/2026) | Todo lo anterior | La caja de intercambio y el teorema del límite (3.A.21) |
| 3.A.21 | Núcleo de una economía | mención (hecho) | Núcleo sin utilidad transferible (Gillies), Debreu-Scarf; Shapley con un continuo de agentes; remite a 3.A.14 el concepto con utilidad transferible (ficha `nucleo`) | La definición con utilidad transferible |
| 3.A.19 | Cárteles y alianzas | resumen aplicado (hecho, 20/10/2026; 3′ en el cante con la negociación) | Función característica de un cártel con Cournot fuera (3 empresas, $p=4-Q$, $c=0$: 1, 16/9, 4); núcleo no vacío; Shapley 4/3 en el núcleo; la estabilidad cooperativa no es la no cooperativa (16/9 > 4/3 fuera); paradoja de las fusiones; la teoría describe mejor la cooperación legal (consorcios, alianzas); remite a 3.A.14 | Las definiciones, la fórmula general y el ejemplo del vendedor |
| 3.A.24 | Elección colectiva | mención (hecho, 22/10/2026) | Nota de III.2.4: en el voto ponderado (Consejo de la UE) el poder no es proporcional al peso; el índice de Shapley-Shubik (1954) es el valor de Shapley del juego de votación, `\vertema{3.A.14}` | La fórmula |

## Divergencias encontradas en el temario actual
- 3.A.14 (Word de partida): núcleo como vector «que no bloquea ninguna coalición» con Σx_i ≤ v(S) (signo cambiado), sin eficiencia; fórmula de Shapley sin «∖{i}»; «jugador ficticio» confuso; aditividad mal dicha; «fácil de computar»; notación I, P(I), S. **Resuelto** (19/10/2026).
- Tebar (lectura de preparador, no publicable): define mal el axioma del jugador nulo.
- El 3.A.19 (20/10/2026) no usa la función γ de Chander y Tulkens (1997) que proponía coherencia (K32), sino la función característica con las coaliciones que compiten a la Cournot (la misma idea, más sencilla de cantar).

Autor: Víctor Gutiérrez Marcos
