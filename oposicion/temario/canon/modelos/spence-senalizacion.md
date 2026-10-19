# Señalización en el mercado de trabajo (Spence, 1973)

- **Área:** mercados-información-juegos · **Tema de referencia:** **3.A.13** («selección adversa» en el título; revisado el 19/10/2026, I.3.1) — la señalización como solución de la parte informada, con a)-d), la doble desigualdad, separadores y agrupadores y el criterio intuitivo. El 3.A.14 tendrá que desarrollar el **juego de señalización** como aplicación del equilibrio bayesiano perfecto (creencias μ, criterio intuitivo de Cho y Kreps) con este mismo modelo y esta notación. Ficha creada a raíz de la revisión del 3.A.13.
- **Temas que lo usan:** 3.A.13 (desarrollo; hecho, 19/10/2026), 3.A.14 (resumen previsto: juego de señalización, equilibrio bayesiano perfecto y criterio intuitivo; hoy solo un esbozo de trabajadores «buenos y malos»), 3.A.25 (mención: alternativa a la teoría del capital humano; hoy con la misma nota que el 3.A.13), 3.B.3 (mención: dividendos y deuda como señal, Bhattacharya, 1979; Ross, 1977; orden jerárquico de Myers y Majluf, 1984), 3.A.15 (mención: precio límite como señal, Milgrom y Roberts, 1982).
- **Manuales de referencia:** Spence (1973), *QJE*; Mas-Colell, Whinston y Green (1995), cap. 13.C; Cho y Kreps (1987), *QJE*; Macho-Stadler y Pérez-Castrillo (2001), cap. 6; Hungerford y Solon (1987); Tyler, Murnane y Willett (2000), *QJE*.

## Presentación de referencia (3.A.13, I.3.1)

Pregunta: ¿puede la parte informada resolver la selección adversa? Conclusión: sí, con una señal creíble **porque** cuesta más a quien no tiene la cualidad; el coste lo paga ella y el resultado queda por debajo del *first best*.

- **a) Idea:** transmisión creíble de información privada de la parte informada a la no informada con una acción que cuesta relativamente más al tipo bajo; si no costara, todos la enviarían y no valdría nada.
- **b) Modelo.** i) Supuestos: 2 tipos de trabajador, productividad alta (A) y baja (B), en proporciones **ν** y 1 − ν (ν, proporción del tipo bueno); empresas en competencia con beneficio nulo que pagan la productividad esperada (w_A > w_B con información; w̄ = νw_A + (1 − ν)w_B sin ella: el problema de Akerlof en el trabajo); educación **y** ≥ 0 observable que **no aumenta la productividad**; coste c_i(y) creciente, mayor para el tipo B, c_B(y) > c_A(y) y c_B'(y) > c_A'(y) (**cruce único**). ii) Desarrollo: las empresas creen que quien tiene al menos ŷ es A; cada uno elige ŷ o 0; el **equilibrio separador** exige
$$w_{\mathrm A}-c_{\mathrm A}(\hat y)\ge w_{\mathrm B}\ (\mathrm{IC}_{\mathrm A}),\qquad w_{\mathrm B}\ge w_{\mathrm A}-c_{\mathrm B}(\hat y)\ (\mathrm{IC}_{\mathrm B})\ \Longrightarrow\ c_{\mathrm A}(\hat y)\le w_{\mathrm A}-w_{\mathrm B}\le c_{\mathrm B}(\hat y)$$
(`eq:spence`, función pequeña de la pizarra; además, la participación de cada tipo). Gráfico: w_A − w_B horizontal y las 2 curvas de coste; separan los ŷ con c_B^{−1}(w_A − w_B) ≤ ŷ ≤ c_A^{−1}(w_A − w_B). **Equilibrio** = creencias, salarios y decisiones de educación con creencias confirmadas: **separadores** (infinitos) y **agrupadores** (todos igual, cobran w̄). **La empresa no fija ŷ: lo fijan sus creencias.** El **criterio intuitivo** (Cho y Kreps, 1987) deja solo el separador más barato, c_B(ŷ*) = w_A − w_B (MWG cap. 13). El separador es peor que el *first best* y ni siquiera siempre es el mejor resultado posible con esa información (con muchos productivos, un agrupador puede dejar mejor a todos): el listón es el **óptimo restringido** (*second best* de la teoría de contratos), que no es el de Lipsey-Lancaster (ficha `second-best`). iii) Implicaciones: educación y salario se correlacionan aunque la educación no aumente la productividad (la diferencia con el capital humano de Becker, 3.A.25; los datos de salarios por años de estudio no distinguen las 2 explicaciones); **sobreeducación** (despilfarro social en el modelo); ilustración de Bolonia (si los grados cuestan menos, la carrera deja de separar y hace falta el máster).
- **c) Evidencia:** efecto diploma (*sheepskin effect*, Hungerford y Solon, 1987); GED: +10-19 % de ingresos de jóvenes blancos sin estudios sin cambiar sus conocimientos (Tyler, Murnane y Willett, 2000).
- **d) Valoración:** la parte informada resuelve el problema pero paga el coste; la alternativa es que lo resuelva la no informada (autoselección, ficha `rothschild-stiglitz`).

Lo que **no** se dice: que Spence «muestra empíricamente» la sobreeducación (es una implicación teórica: Spence, 1973, no tiene datos) ni que Spence «se arrepintió» de la lectura literal (sin fuente): se dice que supone que la educación no aumenta la productividad **para aislar la señal**.

**Notación:** y, ŷ, ŷ*; c_A(y), c_B(y); w_A, w_B, w̄; ν; IC_A, IC_B (subíndices A, B en redonda, mnemónicos de alto y bajo); en el juego de señalización del 3.A.14, creencias μ (`notacion.md` § 1). Nunca E ni Ê para la educación (D129), ni w^R para la participación.

**Gráfico de referencia** (`oposicion/temario/fuentes/3A13/graficos/spence.tex`): educación en abscisas, coste y diferencia salarial en ordenadas; recta horizontal w_A − w_B, curvas c_A(y) y c_B(y) (la de B más inclinada) y el intervalo de ŷ que separa; se dibuja en la pizarra con la doble desigualdad.

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.13 | Soluciones de la selección adversa: la parte informada | desarrollo (hecho, 19/10/2026) | Todo lo anterior | — |
| 3.A.14 | Juegos dinámicos con información incompleta | resumen (previsto) | El modelo como juego de señalización: tipos, creencias μ, equilibrio bayesiano perfecto, separadores y agrupadores, criterio intuitivo (Cho y Kreps); con la notación de arriba y remisión a 3.A.13 para la doble desigualdad y las implicaciones | La evidencia y Bolonia |
| 3.A.25 | Capital humano | mención | La educación como señal, alternativa a Becker; mismo dato de correlación salario-educación y misma nota (supuesto para aislar la señal), con y para la educación | El modelo |
| 3.B.3 | Política de dividendos y estructura de capital | mención | Dividendos y deuda como señal (Bhattacharya, 1979; Ross, 1977); emisión de acciones como mala señal (Myers y Majluf, 1984) | El modelo de trabajo |
| 3.A.15 | Barreras de entrada | mención | Precio límite como señal de costes bajos (Milgrom y Roberts, 1982) | El modelo |

## Divergencias encontradas en el temario actual
- 3.A.13 original: E y Ê para la educación, w^R en la participación, restricciones estrictas sin la del tipo B, equilibrio sin creencias, «Spence muestra empíricamente…», «arrepentimiento» de Spence. **Resuelto** (19/10/2026).
- 3.A.25 (sin revisar): presenta Spence como alternativa al capital humano con remisión a 3.A.13 y la misma nota (32) que el 3.A.13 original (nota 18): coherente; al revisarlo, y para la educación (D129) y quitar el «arrepentimiento».
- 3.A.14 (sin fuente completa): solo un esbozo de «buenos y malos» trabajadores; debe desarrollar el juego de señalización (`mapa.yaml`, contradicciones del 3.A.13).

Autor: Víctor Gutiérrez Marcos
