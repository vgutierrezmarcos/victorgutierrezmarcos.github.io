# Ahorro precautorio (Leland, 1968; Sandmo, 1970; Kimball, 1990; Zeldes, 1989; Carroll, 1997)

- **Área:** macro cerrada · **Tema de referencia:** **3.A.33** para la parte macro (revisado el 31/10/2026: II.3 `sec:precautorio`, la deriva en el anexo C `anexo:hall-ccapm`); la prudencia como propiedad de u (u‴ > 0, coeficiente de Kimball) es del **3.A.10** (ficha `aversion-riesgo-arrow-pratt`). Ficha creada en la fase canon del 3.A.33 (K16, K26, **[decidir]**).
- **Temas que lo usan:** 3.A.33 (desarrollo; hecho, 31/10/2026), 3.A.10 (mención; hecho, 19/10/2026: la prudencia en I.1.2, «no se canta», con `tab:prudencia` y `\vertema{3.A.33}`), 3.A.42 (mención: choques de incertidumbre; Fernández-Villaverde y Guerrón-Quintana, 2020), 3.A.40 (mención: ahorro precautorio y tipo natural bajo), 1D01 (mención aplicada; hecho: la incertidumbre como determinante del consumo, l. 423, y el ahorro de 2020, l. 432).
- **Manuales de referencia:** Leland (1968), *QJE*; Sandmo (1970), *REStud*; Kimball (1990), *Econometrica*; Zeldes (1989), *QJE*; Carroll (1997), *QJE*; Carroll y Kimball (1996); Gourinchas y Parker (2002); Romer (2019), cap. 8; Fernández-Villaverde y Guerrón-Quintana (2020), *Review of Economic Dynamics*.

## Presentación de referencia (3.A.33, II.3)

Pregunta: ¿por qué el riesgo sobre la renta futura lleva a ahorrar más? Primera salida al modelo de Hall (pieza 1, la utilidad). Estructura a)-e). Pegatina: «Hombre prevenido vale por dos».

- **Supuestos:** 2 periodos, renta Y_1 hoy e incierta Ỹ_2 mañana, ahorro S ≡ Y_1 − C_1 al tipo r; preferencias de Fisher con esperanzas.
$$\max_{C_1}\ u(C_1)+\beta\,\mathbb{E}\big[u(\tilde C_2)\big]\quad\text{s.a.}\quad \tilde C_2=(1+r)\,S+\tilde Y_2,\qquad u'(C_1)=\beta(1+r)\,\mathbb{E}\big[u'(\tilde C_2)\big]$$
  (la `eq:euler-estocastica` con 2 periodos).
- **Desarrollo:** si u′ es convexa (u‴ > 0), por Jensen 𝔼[u′(C̃_2)] > u′(𝔼[C̃_2]): se consume menos hoy. La condición es la **prudencia**, u‴ > 0, **necesaria y suficiente** para que cualquier riesgo de media cero sobre la renta futura aumente el ahorro, **sea cual sea el signo de u″**; Kimball (1990): prudencia absoluta −u‴/u″ (sin símbolo propio, como el 3.A.10). La cuadrática es aversa y no prudente; la CRRA, prudente, con prudencia (θ+1)/C (`tab:prudencia`, la misma que en el 3.A.10). DARA ⇒ prudencia.
- **Implicaciones:** el consumo crece aunque r = ρ (anexo C):
$$\mathbb{E}_t\big[\Delta\ln C_{t+1}\big]\simeq\frac{1}{\theta}\,(r-\rho)+\frac{\theta}{2}\,\operatorname{var}_t\big(\Delta\ln C_{t+1}\big);$$
  exceso de sensibilidad (Zeldes, 1989) y de suavidad; en el agregado, más incertidumbre baja el tipo natural y el efecto sobre la actividad es ambiguo (`\vertema{3.A.40}`).
- **Extensiones:** ahorro de colchón (*buffer stock*, Carroll, 1997) con ρ > r y prudencia; se refuerza con las restricciones de liquidez (ficha `restricciones-liquidez`).
- **Evidencia:** Gourinchas y Parker (2002): colchón hasta unos 40 años y ciclo vital después; España: Núñez Carrasco (2013) y la tasa de ahorro de los hogares en 2020 (25,6 % en 2020-T2; gráfico `tasa-ahorro-hogares.tex`).
- **Valoración:** la salida más aceptada (solo exige DARA); la Euler deja de tener solución cerrada.

**Gráficos de referencia** (`oposicion/temario/fuentes/3A33/graficos/`): `precautorio.tex` (u′ convexa con 𝔼[u′(C̃_2)] > u′(𝔼[C̃_2]); no imprescindible) y la tabla `tab:prudencia` (copiada del 3.A.10 con su `\fuente`). Datos: `tasa-ahorro-hogares.tex` (profundización).

**Notación:** S ≡ Y_1 − C_1 ahorro en nivel (§ 7); tilde para lo aleatorio (§ 2); θ CRRA y 1/θ ESI (D001); var_t, 𝔼_t (§ 0). El 3.A.10 escribe la misma ecuación con W̄ − s y ỹ (locales de su apartado): misma ecuación, no hace falta cambiarla.

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.33 | Consumo con incertidumbre | desarrollo (hecho, 31/10/2026) | Todo lo anterior; en el cante, 1 o 2 frases sobre la Euler de la pizarra (pieza 1) | — |
| 3.A.10 | Elección con riesgo | mención (hecho) | Prudencia u‴ > 0, Kimball, `tab:prudencia`; «el paseo aleatorio de Hall excluye el ahorro precautorio» con `\vertema{3.A.33}` | La parte macro |
| 3.A.42 | Ciclos | mención | Los choques de incertidumbre reducen el consumo por precaución | El modelo |
| 3.A.40 | Políticas desde 2008 | mención | Ahorro precautorio y tipo natural bajo | El modelo |
| 1D01 | Dictamen | mención aplicada (hecho) | Incertidumbre (−) y ahorro de 2020 | La teoría |

## Divergencias encontradas en el temario actual
- 3.A.33 original: «u‴ > 0, condición suficiente» y «la aversión, condición necesaria»; sin Kimball; tabla de Fernández-Villaverde con σ. **Resuelto** (31/10/2026) con la redacción del 3.A.10.
- 1D01 (revisada): «Incertidumbre, volatilidad y paro esperado (−): por la aversión al riesgo, ahorro precautorio» (l. 423): lo que da el ahorro precautorio es la **prudencia** (u‴ > 0), no la aversión (`pendientes-coherencia.md`, sección del 3.A.33; menor).

Autor: Víctor Gutiérrez Marcos
