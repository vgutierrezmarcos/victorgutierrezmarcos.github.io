# Modelo binomial de valoración de opciones (Cox, Ross y Rubinstein, 1979; Sharpe, 1978)

- **Área:** finanzas-empresa · **Tema de referencia:** **3.B.25** (revisado el 8/11/2026, II.5, `eq:replica` y `eq:binomial`) — desarrollo. Ficha creada en la pasada final (noviembre de 2026) a propuesta del 3.B.25 (§ 9, punto 3).
- **Temas que lo usan:** 3.B.25 (desarrollo; hecho, 8/11/2026), 3.A.34 y 3.B.2 (mención: el árbol de 2 ramas de la opción de esperar, con la misma $\pi$; ficha `opciones-reales`), 3.B.4 (mención: valoración de opciones reales).
- **Manuales de referencia:** Cox, Ross y Rubinstein (1979), *JFE*; Sharpe (1978); Hull (2022), cap. 13.

## Presentación de referencia (3.B.25, II.5)
**Pregunta:** ¿cuánto vale una opción si el subyacente solo puede subir o bajar?

a) **Idea:** con 2 estados la opción se **replica** con acciones y un bono, así que su precio no depende de la probabilidad real ni de la aversión al riesgo. b) **Desarrollo:** un periodo, factores $u$ y $d$; ratio de cobertura $\Delta=(c_u-c_d)/(S_0u-S_0d)$; probabilidad **neutral al riesgo** $\pi=(1+r-d)/(u-d)$ (en continuo, $(e^{r\Delta t}-d)/(u-d)$);
$$c=\frac{\pi\,c_u+(1-\pi)\,c_d}{1+r}\qquad(\texttt{eq:binomial})$$
**Ejemplo de referencia:** $S_0=100$, $u=1{,}25$, $d=0{,}8$, $K=110$, $r=10$ % simple: $c_u=15$, $c_d=0$, $\Delta=1/3$, $\pi=2/3$, $c\approx9{,}09$. De palabra: «se compra 1/3 de acción y se pide prestado lo justo para que la cartera pague lo mismo que la *call* en los 2 estados». Con muchos pasos converge a Black-Scholes (ficha `black-scholes`).

**Notación:** $\pi$ neutral al riesgo (la misma letra del árbol del 3.A.34), $\Delta$ ratio de cobertura; $u$, $d$ locales (avisar: $u$ no es el coste de almacenamiento).

**Gráfico de referencia:** `oposicion/temario/fuentes/3B25/graficos/arbol-binomial.tex` (`fig:arbol-binomial`).

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.B.25 | Valoración de opciones | desarrollo (hecho, 8/11/2026) | Todo lo anterior | — |
| 3.A.34, 3.B.2 | Opción de esperar | mención | «Es el mismo árbol que la opción de esperar», con la misma $\pi$ | La réplica |
| 3.B.4 | Valoración de empresas | mención | Opciones reales | — |

## Divergencias encontradas en el temario actual
- 3.B.25 (original): $C_1(1-r_f)=9$ y la probabilidad del 66,67 % presentada como real. **Resuelto** (8/11/2026).

Autor: Víctor Gutiérrez Marcos
