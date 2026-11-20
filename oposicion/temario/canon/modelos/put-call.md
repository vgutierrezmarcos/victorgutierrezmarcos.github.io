# Paridad *put-call* y valor intrínseco y temporal de las opciones

- **Área:** finanzas-empresa · **Tema de referencia:** **3.B.25** (revisado el 8/11/2026, II.5, `eq:put-call` función clave) — desarrollo. Ficha creada en la pasada final (noviembre de 2026) a propuesta del 3.B.25 (§ 9, punto 2).
- **Temas que lo usan:** 3.B.25 (desarrollo; hecho, 8/11/2026), 3.B.13 (mención: opciones sobre divisas; al revisarlo, la definición correcta de opción, derecho del **comprador**).
- **Manuales de referencia:** Stoll (1969); Hull (2022), cap. 11.

## Presentación de referencia (3.B.25, II.5)
**Pregunta:** ¿qué relación hay entre el precio de una *call* y el de una *put* europeas sobre el mismo subyacente?

**Desarrollo:** 2 carteras pagan $\max(S_T,K)$ en $T$: la *fiduciary call* (una *call* más un bono cupón cero de nominal $K$) y la *protective put* (una *put* más el subyacente); sin arbitraje valen lo mismo hoy:
$$c+K\,e^{-rT}=p+S_0\qquad(\texttt{eq:put-call})$$
Para americanas, desigualdades. Valor intrínseco y valor temporal; tabla de determinantes del valor ($S_0$, $K$, $T$, $\sigma$, $r$, dividendos).

**Notación:** $K$ precio de ejercicio (nunca $X$ ni «P ejercicio»), $c$ y $p$ europeas ($C$, $P$ americanas), $r$ continuo, $D$ dividendos (o $q$ si es un rendimiento).

**Gráfico de referencia:** `oposicion/temario/fuentes/3B25/graficos/paridad-put-call.tex`; de apoyo, `pagos-opciones.tex`, `valor-call.tex`, `determinantes-bs.tex`.

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.B.25 | Valoración de opciones | desarrollo (hecho, 8/11/2026) | Todo lo anterior | — |
| 3.B.13 | Mercado de divisas | mención | Opciones sobre divisas, `\vertema{3.B.25}` | La paridad |

## Divergencias encontradas en el temario actual
- 3.B.25 y 3.B.13 (Word): «da a su **vendedor** el derecho» en la definición de opción. **Resuelto** en el 3.B.25 (8/11/2026); pendiente el 3.B.13 si lo conserva.

Autor: Víctor Gutiérrez Marcos
