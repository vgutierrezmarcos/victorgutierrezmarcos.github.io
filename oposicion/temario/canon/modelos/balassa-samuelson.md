# Efecto Balassa-Samuelson

- **Área:** macro-abierta · **Tema de referencia:** 3.B.14 (Teorías de la determinación del tipo de cambio), **revisado el 11/11/2026**: lo desarrolla en I.2.2 con a)-e), la derivación, la función clave `eq:balassa-samuelson` y un gráfico propio; el tipo real de equilibrio (III.1.3) vuelve a él. Ficha nueva del 11/11/2026 (CC4 del 3.B.14, D-4, **[decidir]**); id nuevo (no estaba en el mapa).
- **Temas que lo usan:** 3.B.14 (desarrollo; hecho, 11/11/2026), 1D01 (uso; aprobada), 3.B.11 (mención; hecho, 5/11/2026), 3.B.16 (mención; hecho, 11/11/2026), 4.A.22 (uso).
- **Fuentes de referencia:** Balassa (1964, `Balassa1964`) y Samuelson (1964, `Samuelson1964`), las claves de la 1D01 y del 3.B.11; Harrod (1933, `Harrod1933International`) como antecedente; Obstfeld y Rogoff, *Foundations…*, cap. 4 (con capital); De Gregorio, Giovannini y Wolf (1994) (demanda); Chong, Jordà y Taylor (2012, `ChongJordaTaylor2012Harrod`); Engel (1999, `Engel1999Accounting`).

## Presentación de referencia (3.B.14, I.2.2)

**Pregunta:** ¿por qué los países ricos tienen niveles de precios más altos y por qué una parte de las desviaciones de la PPA no se corrige?

**Supuestos:** 2 sectores en cada país, comerciables ($T$) y no comerciables ($N$); ley del precio único en los comerciables, $P_T=EP^*_T$; un solo factor, el trabajo, móvil entre sectores pero no entre países, $Y_j=A_jL_j$; competencia perfecta; el nivel de precios pondera los no comerciables con el mismo peso **$\omega_N$** en los 2 países.

**Ecuaciones (notación canónica; minúsculas en logaritmos, $a\equiv\ln A$):**
- El salario **nominal** se iguala entre sectores y es el **valor** del producto marginal: $W=P_TA_T=P_NA_N$ ⇒ $\dfrac{P_N}{P_T}=\dfrac{A_T}{A_N}\Longleftrightarrow p_N-p_T=a_T-a_N$ (`eq:bs-precio-relativo`).
- $p=(1-\omega_N)p_T+\omega_Np_N=p_T+\omega_N(p_N-p_T)$, y lo mismo fuera.
- **Función clave** `eq:balassa-samuelson`: $q=-\,\omega_N\big[(a_T-a_N)-(a^{*}_T-a^{*}_N)\big]$, con $q\equiv e+p^*-p$.

**Resultado:** el país cuya productividad en los comerciables crece más que en los no comerciables, y más que fuera, ve **apreciarse su tipo real** ($\downarrow q$) sin que cambie el nominal de los comerciables: sube la productividad en $T$ → sube el salario en $T$ → por la movilidad, en toda la economía → suben los precios de $N$ → sube el nivel de precios. *Efecto Penn*: los países ricos tienen precios más altos (y sus monedas salen «caras» en el índice Big Mac). Con tipo fijo o en una unión monetaria, la apreciación real llega por más inflación: **la convergencia trae más inflación sin pérdida de competitividad preocupante en los comerciables** (las mismas palabras en la 1D01, el 3.B.11 y el 3.B.16).

**Extensiones y evidencia:** con capital móvil entre países, el mismo resultado con las participaciones del trabajo (Obstfeld y Rogoff); con demanda (gasto público y servicios) si el trabajo no es perfectamente móvil (De Gregorio, Giovannini y Wolf, 1994). Funciona en el corte transversal; el yen en los años 70 y 80; en series temporales, más débil (Chong, Jordà y Taylor, 2012; Engel, 1999: a corto plazo el tipo real lo mueven los comerciables). Con los precios dados, la productividad también aprecia por la demanda de bienes nacionales (Mishkin, anexo D del 3.B.14, reconciliado con B-S).

**Gráfico de referencia:** **`oposicion/temario/fuentes/3B14/graficos/balassa-samuelson.tex`**: esquema de flechas en TikZ con la cadena productividad en $T$ → salario en $T$ → salario en toda la economía → precio de $N$ → nivel de precios → apreciación real (imprescindible en el cante, con la ecuación).

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.B.14 | Determinación del tipo de cambio | desarrollo (hecho, 11/11/2026) | I.2.2 a)-e) con `eq:bs-precio-relativo`, `eq:balassa-samuelson` y `balassa-samuelson.tex`; III.1.3 (BEER con la productividad relativa); anexo D | — |
| 1D01 | Dictamen de coyuntura | uso (aprobada) | IV.2, l. 1027: la convergencia sube salarios y precios de los no comerciables sin pérdida de competitividad | La derivación |
| 3.B.11 | Balanza de pagos | mención (hecho, 5/11/2026) | l. 400: no toda inflación diferencial es pérdida de competitividad | La derivación |
| 3.B.16 | Integración monetaria | mención (hecho, 11/11/2026) | l. 391: los diferenciales de inflación pueden ser de equilibrio en una unión, `\vertema{3.B.14}` | La derivación |
| 4.A.22 | Sector exterior de España | uso | La apreciación real de la convergencia al valorar la competitividad-precio, `\vertema{3.B.14}` (solo para B-S; `uso: ampliar`) | La derivación |

## Divergencias encontradas en el temario actual
- **Resuelto en el 3.B.14 (11/11/2026)**: el Word decía que suben los salarios **reales** y que son iguales al producto marginal; es el salario **nominal**, igual al **valor** del producto marginal. No tenía ecuación (5 pasos y un esquema dentro de la valoración de la PPA).
- **Peso de los no comerciables**: $\omega_N$ (coherencia, como los pesos $\omega_i$ de los tipos efectivos, D044) y no α (que en macro abierta es el grado de apertura del 3.A.32) (D-4 del 3.B.14, **[decidir]**).

Autor: Víctor Gutiérrez Marcos
