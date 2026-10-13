# Progreso técnico neutral (Hicks, Harrod, Solow)

- **Área:** consumidor-producción · **Tema de referencia:** 3.A.11 (Teoría de la producción, II.3) — único que lo desarrolla, como caracterización de la tecnología a muy largo plazo. Revisado el 13/10/2026: la presentación de referencia es la del 3.A.11.
- **Temas que lo usan:** 3.A.11 (desarrollo), 3.B.9 (resumen), 3.A.43 (mención: Solow supone neutralidad de Harrod), 3.A.45 (mención: PTF de Solow, 1957, con neutralidad de Hicks); 3.B.5 (sesgo del crecimiento en H-O, sin id).
- **Manuales de referencia:** Hicks (1932); Harrod (1948); Uzawa (1961); Acemoglu (2009), *Introduction to Modern Economic Growth*, cap. 2 y 15; Romer, cap. 1; Barro y Sala-i-Martin, cap. 1.

## Presentación de referencia
Pregunta: ¿cómo se clasifica el progreso técnico según su efecto sobre el reparto de la renta entre los factores?

Con $A_t$ el nivel tecnológico y $F$ homogénea de grado uno (3.A.11, `eq:neutralidad`):
$$\text{Hicks: }q=A_tF(z_K,z_L);\qquad \text{Solow: }q=F(A_tz_K,z_L);\qquad \text{Harrod: }q=F(z_K,A_tz_L)$$
Orden de los argumentos: $(z_K,z_L)$ solo en estas tres fórmulas, como Romer y Acemoglu ($F(K,AL)$); en el resto del temario de producción, $z=(z_L,z_K)$ (`notacion.md` §3). Se mantiene así porque el 3.A.11 revisado lo escribe de este modo; cambiarlo obligaría a reordenar `eq:neutralidad`.

- **Criterio de cada neutralidad** (qué proporción se mantiene con participaciones o RMST constantes):
  - Hicks (*aumentador del producto*): para $z_K/z_L$ dado, la RMST no cambia; las isocuantas se desplazan hacia el origen a lo largo de cada rayo sin cambiar de pendiente.
  - Solow (*aumentador del capital*, $A_tz_K$): para $z_L/q$ dado, las participaciones no cambian.
  - Harrod (*aumentador del trabajo*, $A_tz_L$): para $z_K/q$ dado, las participaciones no cambian.
  No son una jerarquía: son tres criterios distintos.
- **Sesgo (Hicks)**, con $RMST_{LK}=PMg_L/PMg_K$: si la RMST sube para $z_K/z_L$ dado, el progreso es ahorrador de capital (utilizador de trabajo); si baja, ahorrador de trabajo.
- **Aumentador no es sesgado**: dónde entra $A_t$ (a qué factor aumenta) no dice hacia qué factor está sesgado. Con σ < 1, el progreso aumentador del capital eleva más la $PMg_L$ que la $PMg_K$: está sesgado hacia el trabajo (Acemoglu, 2009, cap. 15).
- **Cobb-Douglas**: las tres coinciden, $A_tz_K^{\alpha}z_L^{\beta}=(A_t^{1/\alpha}z_K)^{\alpha}z_L^{\beta}=z_K^{\alpha}(A_t^{1/\beta}z_L)^{\beta}$.
- **Teorema de Uzawa (1961)**: con rendimientos constantes, una senda de crecimiento equilibrado exige que el progreso técnico pueda representarse como aumentador del trabajo (neutral de Harrod); por eso Solow lo supone (3.A.43).

Gráficos de referencia (3.A.11): `oposicion/temario/fuentes/3A11/graficos/progreso-tecnico.tex` (la función se desplaza hacia arriba y la isocuanta hacia el origen) y `oposicion/temario/fuentes/3A11/graficos/progreso-tecnico-neutral.tex` (tres paneles: Hicks, Solow, Harrod).

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.11 | Tecnología a muy largo plazo | desarrollo (hecho, 13/10/2026) | Tres definiciones con su criterio, sesgo de Hicks, aumentador frente a sesgado, coincidencia en Cobb-Douglas, Uzawa, dos gráficos | — |
| 3.B.9 | Comercio y crecimiento | resumen | Sesgo del progreso técnico por sectores y efecto sobre la RRI, con las definiciones de 3.A.11 en una línea cada una | Las definiciones formales (remitir a 3.A.11); no confundir aumentador con sesgado |
| 3.A.43 | Solow | mención | Supuesto de neutralidad de Harrod ($AL$ trabajo efectivo) justificado por Uzawa; remitir a 3.A.11 | Las tres neutralidades |
| 3.A.45 | Contabilidad del crecimiento | mención | La PTF (residuo de Solow, 1957) se mide con neutralidad de Hicks, $Y=A_tF(K,L)$; remitir a 3.A.11 | Las definiciones (nota 13 actual) |

## Divergencias encontradas en el temario actual
- 3.A.11: resueltas en la revisión del 13/10/2026 ($\breve F$, definiciones imprecisas, sin Uzawa ni coincidencia en la Cobb-Douglas).
- 3.B.9 (l. 552-558) y 3.A.45 (nota 13): definiciones antiguas («en Hicks… la cantidad de factores utilizados disminuye»; Harrod «la relación capital-producto permanece constante») y confusión de «intensificador del capital» con sesgado hacia el capital. Al revisarlos, usar esta ficha.
- Factores: $z_K,z_L$ en temas de producción; $K,L$ en macro y comercio ($F(K,AL)$).
