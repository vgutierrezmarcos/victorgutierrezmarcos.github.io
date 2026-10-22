# Función de bienestar social rawlsiana (maximin)

- **Área:** equilibrio general y bienestar · **Tema de referencia:** 3.A.24 (Funciones de bienestar social); **hecho, 22/10/2026** (II.3.2 `sec:rawls` con a)-c) y gráfico `fig:cis-formas`, panel derecho).
- **Temas que lo usan:** 3.A.24 (desarrollo; hecho, 22/10/2026), 4.B.3 (resumen: velo de la ignorancia como legitimación de la redistribución), 4.B.2 (en la ficha `funcion-bienestar-social`), 3.A.10 (mención; hecho, 19/10/2026: nota del criterio de Wald, el *maximin* de la decisión en ignorancia es el de Rawls, «aversión infinita a la incertidumbre tras el velo», frente a la utilitarista de Harsanyi basada en la utilidad esperada, con `\vertema{3.A.24}`). Recoge el id `rawls-velo-ignorancia`.
- **Manuales de referencia:** Rawls (1971), *A Theory of Justice*; Harsanyi (1953, 1955); Sen (1970); Hammond (1976); Nozick (1974); Mas-Colell, Whinston y Green, cap. 22.

## Presentación de referencia (3.A.24, II.3.2)

**Idea:** Rawls (1971) renueva el contrato social de Locke, Rousseau y Kant (no Hobbes): los principios justos son los que acordarían personas libres y racionales en una situación inicial de igualdad; el bienestar social es el del peor situado.

**Supuestos:** **posición original** tras el **velo de la ignorancia** (no se sabe qué posición, talento o gustos se tendrán); decisión grave e irreversible, sin probabilidades fiables.

**Desarrollo:** criterio *maximin* (aversión **infinita** a la incertidumbre, \vertema{3.A.10}; nunca «aversión absoluta», que es la de Arrow-Pratt):
$$W=\min\{U_1,U_2,\dots,U_I\}$$
y los 2 principios de la justicia en su orden (en nota): 1) libertad; 2) a) igualdad equitativa de oportunidades y b) **principio de diferencia** (las desigualdades solo si benefician al menos aventajado). Harsanyi, con utilidad esperada y la misma probabilidad $1/I$ de ser cada uno, llega a la utilitarista (ficha `funcion-bienestar-social`).

**Implicaciones:** CIS **en forma de L** con los vértices en la bisectriz; el óptimo social es de igualdad de utilidades. *Leximin*: si 2 estados empatan en el peor, se mira al segundo peor…; cumple Pareto fuerte (Sen, 1970; Hammond, 1976). Es el límite $\epsilon\to\infty$ de la FBS isoelástica y del índice de Atkinson (`atkinson-indice`). Base informativa: ordinal con comparabilidad de niveles (`tab:bases-informativas`).

**Valoración:** desde el utilitarismo, el *maximin* es una regla extrema (rechaza una ganancia enorme de casi todos por una pérdida mínima del peor); Nozick (1974) le opone la **teoría de los títulos** (justicia histórica: una distribución es justa si nace de adquisiciones y transferencias justas; nunca «igualdad de oportunidades»); Rawls responde que las capacidades naturales y las condiciones sociales no se merecen.

**Gráfico de referencia:** `oposicion/temario/fuentes/3A24/graficos/cis-formas.tex` (3.A.24, 22/10/2026), 3 paneles del mismo tamaño: utilitarista, $\epsilon=0$ (rectas $U_A+U_B=k$); intermedia, $\epsilon=1$ (hipérbolas $U_AU_B=k$); rawlsiana, $\epsilon\to\infty$ (L con vértices en $(1,1)$, $(2,2)$, $(3,3)$). En la pizarra, en una celda, 3 bocetos.

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.24 | Formas de la FBS | desarrollo (hecho, 22/10/2026) | a) Idea; b) velo, *maximin*, los 2 principios (nota), CIS en L, *leximin*; c) críticas utilitarista y de Nozick; gráfico `cis-formas` | — |
| 4.B.3 | Justificar la redistribución | resumen | Velo de la ignorancia (Harsanyi frente a Rawls), «aversión infinita a la incertidumbre»; `\vertema{3.A.24}` | Gráfico |
| 3.A.10 | Criterios de decisión en ignorancia | mención (hecho, 19/10/2026) | Nota: el *maximin* de Wald es el criterio de Rawls; Harsanyi maximiza la utilidad esperada (es neutral respecto a la **utilidad**, no a la renta) | La FBS |

## Divergencias encontradas en el temario actual
- Resueltas en el 3.A.24 revisado (22/10/2026): principio de diferencia mezclado con becas y exenciones (nota 34) → los 2 principios en su orden; Nozick y la «igualdad de oportunidades» → teoría de los títulos; gráfico sin fuente → `cis-formas`.
- 4.B.3 habla de «aversión absoluta al riesgo» en Rawls: decir aversión infinita a la incertidumbre (no confundir con la aversión absoluta de Arrow-Pratt).
