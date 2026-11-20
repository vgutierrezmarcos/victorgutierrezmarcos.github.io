# Mercados recíprocos: dumping recíproco (Brander, 1981; Brander y Krugman, 1983) y arancel estratégico (Brander y Spencer, 1984)

- **Área:** comercio · **Tema de referencia:** 3.B.8 (Política comercial estratégica) para la **versión con arancel**, que es de **Brander y Spencer (1984)**, «Tariff protection and imperfect competition» (en Kierzkowski, ed., *Monopolistic Competition and International Trade*), y del panorama de Brander (1995, *Handbook of International Economics*, vol. 3, NBER WP 5020); **Brander (1981)** y **Brander y Krugman (1983)** son el modelo **sin política** (comercio intraindustrial de bienes idénticos con costes de transporte), que el **3.B.6** cuenta como modelo base, con a)-e) compactos y gráfico (D115 con la profundidad de la pasada final: «resumen con gráfico»). El 3.B.8 parte de ese gráfico y pone el arancel $t_A$ en el lugar de $(\tau-1)c$. Alias (CP6 del 3.B.8): `brander-1981` → esta ficha; `eaton-kierzkowski` → mención aquí (ficha `oligopolio-diferenciado` para el producto diferenciado).
- **Temas que lo usan:** 3.B.8 (desarrollo; hecho, 5/11/2026: II.2 `sec:mercados-reciprocos` con `eq:reaccion-arancel`, `eq:bienestar-arancel`, `eq:arancel-estrategico` y `fig:arancel-reciproco`; Eaton y Kierzkowski en `sec:eaton-kierzkowski` y anexo), 3.B.6 (resumen con gráfico, modelo base; hecho, 5/11/2026: II.1 `sec:dumping-reciproco` con `eq:reaccion-dumping` y `fig:dumping-reciproco`; ejemplo numérico en `anexo:dumping`), 3.A.19 (mención; hecho, 20/10/2026: «el dumping recíproco \vertema{3.B.6}»), 3.B.10 (mención: efecto procompetitivo de suprimir el arancel dentro de la unión, de monopolio a Cournot, `\vertema{3.B.8}`)
- **Manuales de referencia:** Brander (1981, *JIE* 11); Brander y Krugman (1983, *JIE* 15); Brander y Spencer (1984); Brander (1995); Feenstra, cap. 7; Helpman y Krugman, *Trade Policy and Market Structure* (1989).
- **Decisión D016 (13/10/2026):** ¿Se reserva φ para la productividad de Melitz (y la inversa de Frisch en macro) y se cambian sus otros usos en comercio y macro abierta? Sí: función de reacción R_A(q_B), coeficiente técnico de la protección efectiva a_ij, sensibilidad del saldo comercial al tipo real ν
- **Decisión D115 (13/10/2026):** ¿Dónde se desarrolla Brander-Krugman (dumping recíproco)? 3.B.8 la versión con arancel (Brander, 1981) y 3.B.6 resume el dumping recíproco como explicación del comercio intraindustrial

## Presentación de referencia
**Pregunta:** ¿por qué se exporta e importa el mismo bien homogéneo, y puede un arancel trasladar beneficios?

**Supuestos:** dos países, una empresa en cada uno, mercados segmentados, competencia Cournot, costes de transporte o arancel $t$; coste marginal $c$.

**Ecuaciones (notación canónica):** $q_i^A$ = ventas de la empresa $i$ en el mercado A.
**Modelo base (3.B.6):** $p^A(Q^A)=a-bQ^A$, coste marginal $c$ y $\tau c$ para vender fuera (iceberg); función clave `eq:reaccion-dumping`: $R_A(q_B^A)=\frac{a-c}{2b}-\frac12q_B^A$, $R_B(q_A^A)=\frac{a-\tau c}{2b}-\frac12q_A^A$, de donde $q_A^A=\frac{a-2c+\tau c}{3b}$, $q_B^A=\frac{a-2\tau c+c}{3b}$ y el beneficio $B_B^A$ (D003). Contraste: con **Bertrand homogéneo** y mercados segmentados no hay comercio (el dumping recíproco desaparece); el contraste con producto diferenciado es Eaton y Kierzkowski (1984). Eaton y Grossman (1986) es política (3.B.8, ficha `brander-spencer`).

**Versión con arancel (3.B.8):** $\max_{q_B^A}B_B^A=[p^A(q_A^A+q_B^A)-c-t_A]\,q_B^A$; `eq:reaccion-arancel`, $R_B(q_A^A;t_A)=\frac{a-c-t_A}{2b}-\frac12q_A^A$ (la del 3.B.6 con $c+t_A$ en lugar de $\tau c$); bienestar $W_A=\mathrm{EC}^A+B_A^A+t_Aq_B^A$ (`eq:bienestar-arancel`); con demanda lineal $t_A^*=(a-c)/3$ y arancel prohibitivo $t_A\ge(a-c)/2$; con aranceles en los 2 países, Pareto-inferior al libre comercio.

**Resultado:** comercio bidireccional del mismo bien (dumping recíproco) con efecto ambiguo sobre el bienestar; un arancel desplaza la reacción extranjera y traslada beneficios a la empresa nacional.

**Gráficos de referencia:** `oposicion/temario/fuentes/3B06/graficos/dumping-reciproco.tex` (modelo base, funciones de reacción en el mercado A) y `fuentes/3B08/graficos/arancel-reciproco.tex` (desplazamiento de $R_B$ con el arancel).

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.B.8 | Política comercial estratégica | desarrollo (hecho, 5/11/2026) | Versión con arancel (Brander y Spencer, 1984): traslado de rentas, $t_A^*$, prohibitivo, guerra Pareto-inferior; Eaton y Kierzkowski (monopolista extranjero) | El modelo base (3.B.6) |
| 3.B.6 | Nueva teoría del comercio | resumen con gráfico (modelo base; hecho, 5/11/2026) | Dumping recíproco como comercio intraindustrial de homogéneos, a)-e) compactos, `eq:reaccion-dumping`; Bertrand homogéneo sin comercio como contraste y Eaton-Kierzkowski | La versión con política |
| 3.B.10 | Integración económica | mención | Efecto procompetitivo de suprimir el arancel dentro de la unión, de monopolio a Cournot, `\vertema{3.B.8}` | El modelo |
| 3.A.19 | Oligopolio | mención (hecho, 20/10/2026) | «El dumping recíproco \vertema{3.B.6}» (l. 24, 1133): se cumple con el modelo base del 3.B.6 | — |

## Divergencias encontradas en el temario actual
- 3.B.8 llama «modelo de Brander y Krugman (1983)» al duopolio Cournot en un **tercer mercado** de partida de Brander-Spencer: Brander-Krugman (1983) es el de mercados recíprocos (dumping recíproco). Corregir la atribución (ver `brander-spencer`).
- Función de reacción $\varphi_A(q_B)$ en 3.B.8; canon $R_A(q_B)$, coherente con la ficha `cournot` (creada el 20/10/2026 con el 3.A.19, tema de referencia de Cournot: $R_i(q_j)$, $q^C$, `eq:lerner-cournot`, gráfico `3A19/graficos/cournot.tex`). El 3.B.6 y el 3.B.8 remiten al 3.A.19 la derivación general (el 3.A.19 ya remite a los 2 en su relevancia y en la conclusión).
- En la ecuación de la presentación, $\pi_B^A$ y $P^A$ deben ser $B_B^A$ y $p^A$ (D003, D046) al revisar el 3.B.8.
- **Atribución corregida (pasada final, CC2 del 3.B.6 y CP1 del 3.B.8):** el arancel en mercados recíprocos era «Brander (1981)» en la ficha y en el mapa; es Brander y Spencer (1984). Las divergencias de $\pi\to B$ y $P\to p$ quedan **resueltas** al revisar el 3.B.8 (5/11/2026), y la de $\varphi_A$ también.

Autor: Víctor Gutiérrez Marcos
