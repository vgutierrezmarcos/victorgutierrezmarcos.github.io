# Cuotas a la importación: equivalencia con el arancel (Bhagwati, 1965) y renta de la cuota

- **Área:** comercio · **Tema de referencia:** **3.B.7** (Política comercial (I): instrumentos y efectos; revisado el 5/11/2026, II.1 `sec:cuotas`) — es el único que la desarrolla, con la equivalencia en competencia perfecta y la no equivalencia con monopolio. Ficha creada en la pasada final del canon (noviembre de 2026) a propuesta del 3.B.7 (C1 b); `mapa.yaml` ya listaba el id `cuotas` en el 3.B.7 sin ficha.
- **Temas que lo usan:** 3.B.7 (desarrollo; hecho, 5/11/2026), 3.B.33 (mención: art. XI del GATT y sus excepciones, arancelización de la Ronda Uruguay; hecho, 14/11/2026), 3.B.41 (mención: contingentes arancelarios y salvaguardias de la UE), 3.B.38 (mención: contingentes en la PAC).
- **Manuales de referencia:** Bhagwati (1965), «On the Equivalence of Tariffs and Quotas»; Feenstra y Taylor (2021), *International Economics*, cap. 8; Krugman, Obstfeld y Melitz, cap. 9; Krueger (1974) para la búsqueda de rentas.

## Presentación de referencia (3.B.7, II.1)

**Pregunta:** ¿da lo mismo limitar las importaciones con una cuota que con un arancel?

**Supuestos:** los 5 de la competencia perfecta (misma lista y orden que en todas las estructuras de mercado, `tab:supuestos-cuota`, `\vertema{3.A.16}`); país pequeño importador neto; precio mundial $p^W$.

**Desarrollo:** una cuota $\bar M$ menor que las importaciones de libre comercio sube el precio interior hasta que la demanda de importaciones $M=x-q$ es igual a $\bar M$. Para cada cuota hay un **arancel equivalente** que da el mismo precio interior, consumo, producción, excedentes y pérdida ($b+d$). La diferencia es el área $c$: con el arancel es recaudación; con la cuota es la **renta de la cuota**, $(p-p^W)\bar M$, que se queda quien tiene la licencia: el Estado si la subasta (mismo resultado que el arancel), los importadores nacionales si se regala (con **búsqueda de rentas**, Krueger, 1974; ficha `rent-seeking-tullock`) o los exportadores extranjeros (RVE: el país pierde además $c$).

**Implicaciones:** con la cuota se fija la cantidad y se ajusta el precio; con el arancel, al revés. **No equivalencia con monopolio nacional** (levanta el supuesto 4, precio-aceptante): con la cuota el monopolista se enfrenta a la demanda residual $x(p)-\bar M$ e iguala IMg = CMg sobre ella: produce menos y cobra más que con el arancel equivalente (ficha `monopolio`). Tampoco son equivalentes con demanda que crece (la cuota no deja entrar más) ni con incertidumbre.

**Gráficos de referencia:** `oposicion/temario/fuentes/3B07/graficos/cuota.tex` (`fig:cuota`, cuota y arancel equivalente en un país pequeño, ejemplo del acero: cuota de 40 t, precio de 20 a 30, $b+d=100$, renta 400) y `cuota-monopolio.tex` (`fig:cuota-monopolio`).

**Notación:** la de equilibrio parcial del 3.B.7 (`notacion.md` § 10): $p^W$ precio mundial, $p^W(1+t)$ precio interior, $q$, $x$, $M=x-q$, áreas $a$-$e$; $\bar M$ la cuota.

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.B.7 | Instrumentos de política comercial | desarrollo (hecho, 5/11/2026) | Definición y gestión (orden de llegada, licencias subastadas o asignadas), equivalencia de Bhagwati con `fig:cuota`, renta de la cuota, no equivalencia con monopolio (`fig:cuota-monopolio`, `tab:supuestos-cuota`), RVE (`sec:rve`) | — |
| 3.B.33 | OMC | mención (hecho, 14/11/2026) | Prohibición general del art. XI y sus excepciones; arancelización | El modelo |
| 3.B.38, 3.B.41 | PAC; política comercial de la UE | mención | Contingentes arancelarios y salvaguardias, con `\vertema{3.B.7}` | El modelo |

## Divergencias encontradas en el temario actual
- Ninguna en los temas revisados.

Autor: Víctor Gutiérrez Marcos
