# Poder de voto en el Consejo de la UE: índices de Shapley-Shubik y Banzhaf con la doble mayoría

- **Área:** union-europea · **Tema de referencia:** **3.B.36** (`sec:poder`; revisado el 14/11/2026).
- **Temas que lo usan:** 3.B.36 (desarrollo; hecho, 14/11/2026), 3.A.14 (mención: valor de Shapley, ficha `nucleo-shapley`), 3.A.24 (mención, nota de III.2.4), 4.B.2 (mención: reglas de votación).
- **Manuales de referencia:** Shapley y Shubik (1954); Banzhaf (1965); Felsenthal y Machover (1998).
- **Origen de la ficha:** creada en la pasada final del canon (noviembre de 2026) a propuesta del tema de referencia (su `_trabajo/canon-pendiente.md`; duda GEN-01).

## Presentación de referencia
Juego de mayoría ponderada con la **doble mayoría** (55 % de los Estados que reúnan el 65 % de la población; minoría de bloqueo de al menos 4). Función clave `eq:shapley-shubik` $\phi_i(v)=\sum_{T\subseteq N\setminus\{i\}}\frac{|T|!\,(n-|T|-1)!}{n!}[v(T\cup\{i\})-v(T)]$, con la notación de `nucleo-shapley`; Banzhaf como recuento de veces decisivo. Cálculo exacto para los 27 (`datos/poder-voto.py`).

**Gráfico de referencia:** `fuentes/3B36/graficos/poder-voto.tex`.

**Notación:** $\phi_i(v)$, $T\subseteq N$, $v(T)$ (§ 4).

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.B.36 | Instituciones de la UE | desarrollo (hecho, 14/11/2026) | Cálculo para los 27 y el gráfico | — |
| 3.A.14, 3.A.24, 4.B.2 | Juegos cooperativos; elección colectiva; votación | mención | El Consejo como ejemplo, `\vertema{3.B.36}` | El cálculo |

## Divergencias encontradas en el temario actual
- Ninguna detectada en la pasada final (noviembre de 2026).

Autor: Víctor Gutiérrez Marcos
