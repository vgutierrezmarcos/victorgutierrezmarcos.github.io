# Dilema del prisionero

- **Área:** mercados-información-juegos · **Tema de referencia:** 3.A.14 (Teoría de juegos; revisado el 19/10/2026, I.2.1 y, repetido, I.3.2)
- **Temas que lo usan:** 3.A.14 (resumen como juego de referencia; hecho, 19/10/2026), 3.A.19 (mención; hecho, 20/10/2026: el cártel como dilema con su tabla `tab:cartel-dilema`; la «lente» de Cournot como dilema; teorema de tradición oral aplicado a la colusión con β ≥ 1 − 1/n y 9/17; la clemencia convierte el cártel en un dilema entre sus miembros, Motta y Polo, 2003; ficha `cartel`), 3.A.23 (mención: polizón en bienes públicos), 3.B.7 (mención: guerra arancelaria de Johnson, 1953, como dilema; cooperación en los acuerdos comerciales por repetición), 3.A.36 (mención: reputación en juegos repetidos, ficha `barro-gordon`), 4.A.15 (mención: programas de clemencia), 3.B.31 (mención; hecho, 31/10/2026: III.2, Reducir/Emitir entre 2 países con los pagos de `tab:dilema-prisionero` en `tab:dilema-clima`, gatillo β ≥ 1/5 y su versión con club climático `tab:club-clima`; ficha `clubes-climaticos`); lo usan sin id 4.B.18-4.B.19 (coordinación fiscal); 3.A.23 (mención; hecho, 21/10/2026).
- **Manuales de referencia:** Tucker (1950); Gibbons (1992), *Un primer curso de teoría de juegos*, cap. 1; Mas-Colell, Whinston y Green (1995), cap. 8 y 12; Friedman (1971); Fudenberg y Maskin (1986); Axelrod (1984).

## Presentación de referencia (3.A.14)
Juego simultáneo 2×2, información completa (e imperfecta). **Matriz de referencia** (`tab:dilema-prisionero` del 3.A.14): la **guerra de precios** entre el instalado I (filas) y el entrante E (columnas), pagos en beneficios, con las mejores respuestas subrayadas y el equilibrio sombreado:

| | Precio alto | Precio bajo |
|---|---|---|
| **Precio alto** | (5, 5) | (0, 6) |
| **Precio bajo** | (6, 0) | (1, 1) |

Precio bajo es estrictamente dominante para ambos (6 > 5 y 1 > 0); (Bajo, Bajo) es el único equilibrio de Nash y está dominado en el sentido de Pareto por (Alto, Alto): racionalidad individual frente a colectiva. Los temas que aplican el dilema **usan estos mismos pagos (5, 6, 0, 1) con estrategias con palabras** para que se reconozca (el 3.B.31: Reducir/Emitir). El clásico Callar/Confesar (años de cárcel en negativo: (−1, −1), (−10, 0), (0, −10), (−5, −5)) va en el anexo de clásicos del 3.A.14 (`anexo:clasicos`); con él el gatillo también da 1/5.

*Corrección de la ficha (fase canon del 3.B.31, 31/10/2026, CC6):* la ficha daba Callar/Confesar como `tab:dilema-prisionero`; en el 3.A.14 revisado esa etiqueta es la guerra de precios. **No cambia ningún tema revisado** (el 3.A.14 ya es así; el 3.A.19 y el 3.A.23 usan sus propias tablas, `tab:cartel-dilema` y `tab:polizon`, con sus pagos).
**Repetición** (I.3.2 del 3.A.14; concepto en el 3.A.14 y aplicación a la colusión en el 3.A.19, D4 del 3.A.14): con repetición finita, confesar en cada etapa; con repetición infinita, la estrategia del **gatillo** es un ENPS si (`eq:gatillo`)
$$\beta\;\geq\;\frac{u^{\mathrm D}-u^{\mathrm C}}{u^{\mathrm D}-u^{\mathrm N}}=\frac{6-5}{6-1}=\frac15,$$
con β el factor de descuento y $u^{\mathrm C}$, $u^{\mathrm D}$, $u^{\mathrm N}$ los pagos por periodo de cooperar, desviarse y del EN de la etapa (los de la matriz, que sigue en la pizarra: se señalan 5, 6 y 1); **teorema de tradición oral** (*folk theorem*: Friedman, 1971; Fudenberg y Maskin, 1986; ficha `equilibrio-nash`). Evidencia: Axelrod (1984, *tit for tat*), Dal Bó (2005).
Gráfico de referencia: la matriz de pagos (tabla LaTeX, no imagen).

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.14 | Conceptos: dominancia, EN, repetición | resumen (hecho, 19/10/2026) | Matriz, dominancia, ineficiencia del EN; gatillo con β ≥ 1/5 y teorema de tradición oral; Axelrod y Dal Bó | — |
| 3.A.19 | Colusión | mención (hecho, 20/10/2026) | El cártel como dilema con su propia tabla 2×2 (cumplir la cuota o producir la de Cournot; 0,125 / 0,104 / 0,139 / 0,111 en unidades de $(a-c)^2/b$); Friedman (1971): `eq:colusion` con β ≥ 1 − 1/n con $n$ empresas (½ en el duopolio de Bertrand) y 9/17 con Cournot; la clemencia convierte el cártel en un dilema (Motta y Polo, 2003); remite a 3.A.14 el enunciado general del teorema de tradición oral | La matriz genérica (Callar/Confesar) y el teorema |
| 3.A.23 | Bienes públicos; recursos comunes | mención (hecho, 21/10/2026) | El polizón como dilema (tabla `tab:polizon`: la mota cuesta 120 y cada vecino la valora en 100; no contribuir es dominante); la tragedia de los comunes como dilema con muchos jugadores (anexo de Ostrom); la cooperación repetida, `\vertema{3.A.14}` | — |
| 3.B.31 | Acuerdos climáticos | mención (hecho, 31/10/2026) | Reducir/Emitir entre 2 países con los pagos del 3.A.14 (`tab:dilema-clima`); gatillo β ≥ 1/5 y por qué no basta con el clima; su versión con club climático (`tab:club-clima`, ficha `clubes-climaticos`) tachando 2 celdas | La matriz de la guerra de precios y el teorema |
| 3.B.7 | Guerra arancelaria | mención | Johnson (1953): arancel óptimo de cada país como estrategia dominante; la repetición sostiene los acuerdos; remitir a 3.A.14 | — |
| 3.A.36 | Credibilidad | mención | Reputación en juegos repetidos (ficha `barro-gordon`) | — |
| 4.A.15 | Clemencia | mención | La clemencia convierte el cártel en un dilema del prisionero para sus miembros; remitir el concepto al 3.A.14 y su aplicación al cártel (con `eq:colusion`) al 3.A.19 | — |

## Divergencias encontradas en el temario actual
- 3.A.14 (Word de partida): EN con desigualdad estricta, $S_i$ para la estrategia y $S$ para coaliciones, matriz de MWG escaneada. **Resuelto** (19/10/2026): $u_i(s_i^*,s_{-i}^*)\ge u_i(s_i,s_{-i}^*)$, $s_i\in S_i$, $T\subseteq N$, matriz canónica en LaTeX con Callar/Confesar.
- 3.B.7 y 3.B.8 (sin revisar): «Johnson (1953) demostró que existirá un equilibrio de Nash [ver tema 3.A.19]» → 3.A.14.
- 4.A.15 (sin revisar): clemencia como dilema del prisionero «[ver tema 3.A.16]» → «\vertema{3.A.14} \vertema{3.A.19}» (concepto en el 3.A.14 y aplicación al cártel en el 3.A.19, revisado el 20/10/2026). Lo mismo en 3.B.39 (l. 1060 de su Word, «[ver tema 3.A.19]»: añadir el 3.A.14).

Autor: Víctor Gutiérrez Marcos
