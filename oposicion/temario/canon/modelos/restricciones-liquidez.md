# Restricciones de liquidez y hogares *hand-to-mouth* (Zeldes, 1989; Campbell y Mankiw, 1989; Deaton, 1991; Kaplan, Violante y Weidner, 2014)

- **Área:** macro cerrada · **Tema de referencia:** **3.A.33** (revisado el 31/10/2026: II.3 `sec:liquidez`, con el gráfico de Fisher quebrado; la fracción λ de Campbell y Mankiw y los *hand-to-mouth* en II.2 `sec:contrastacion`) — es la salida al modelo de Hall por la restricción presupuestaria (pieza 3 de la pizarra). Ficha creada en la fase canon del 3.A.33 (**[decidir]**: hasta ahora era un supuesto suelto de varias fichas, sin id).
- **Temas que lo usan:** 3.A.33 (desarrollo; hecho, 31/10/2026), 3.A.39 (resumen: por qué falla la equivalencia ricardiana; la deuda equivale a dar crédito a quien no lo tenía), 3.A.40 (resumen: multiplicadores con hogares que viven al día; Galí, López-Salido y Vallés, 2007; HANK, Kaplan, Moll y Violante, 2018), 3.A.37 (mención: la política monetaria llega a estos hogares por la renta y el empleo), 3.A.25 (mención; hecho: con restricciones de liquidez la separación de Fisher se rompe y quien tiene menos recursos estudia menos, l. 724), 1D01 (mención aplicada; hecho: crédito y renta corriente de los hogares de renta baja, l. 418-422), 3.A.29 (mención; hecho, 1/11/2026: la separación de Fisher se rompe en las extensiones de Robinson Crusoe, anexo D). También 3.A.7 (mención; hecho, 4/11/2026: III.1.2, hogares de regla de pulgar de Galí, López-Salido y Vallés, 2007; III.2, los HANK con `\vertema{3.A.33}`; ficha `hank`). También 3.A.6 (mención; hecho, 4/11/2026: II.4 c) y anexo C, las restricciones de liquidez y los hogares que consumen su renta corriente, Campbell y Mankiw, 1989, como razones del incumplimiento de la equivalencia ricardiana; `\vertema{3.A.33}`).
- **Manuales de referencia:** Zeldes (1989), *JPE*; Deaton (1991), *Econometrica*; Campbell y Mankiw (1989), *NBER Macro Annual*; Jappelli y Pistaferri (2010, 2017); Kaplan y Violante (2014), *Econometrica*; Kaplan, Violante y Weidner (2014), *BPEA*; Romer (2019), cap. 8.

## Presentación de referencia (3.A.33, II.3, pieza 3)

Pregunta: ¿qué pasa si el hogar no puede endeudarse contra su renta futura? Estructura a)-d).

- **Supuestos:** los de Hall con b_{t+1} ≥ 0.
- **Desarrollo:** en el plano de Fisher, la recta presupuestaria se **quiebra en la dotación A**; el hogar que querría endeudarse se queda en la esquina, C_1 = Y_1. La Euler pasa a desigualdad,
$$u'(C_t)\ \geq\ \beta(1+r)\,\mathbb{E}_t\big[u'(C_{t+1})\big],$$
  estricta cuando la restricción aprieta (C_t = Y_t + (1+r)b_t); los cambios previsibles de la renta pasan al consumo cuando llegan, y la **separación de Fisher se rompe**.
- **Implicaciones:** exceso de sensibilidad; ahorro precautorio aun con cuadrática (Zeldes, 1989; se refuerza con la prudencia, Deaton, 1991; Carroll, 1997); política fiscal más eficaz (transferencias y rebajas, aun transitorias; multiplicador mayor, `\vertema{3.A.40}`; lejos de la equivalencia ricardiana, `\vertema{3.A.39}`); monetaria por la renta y el empleo (`\vertema{3.A.37}`); el desarrollo financiero las relaja. Extensión: renta endógena (Lucas y Rapping, `\vertema{3.A.25}`).
- **Evidencia:** Zeldes (1989): la Euler falla en los hogares con poca riqueza; Campbell y Mankiw (1989), `eq:campbell-mankiw`: ΔC_t = μ + λΔY_t + ε_t con λ ≈ 0,5 (0,35-0,7); cheques fiscales (Johnson, Parker y Souleles, 2006: 20-40 % en no duraderos; Parker *et al.*, 2013: 50-90 % con duraderos); *hand-to-mouth* (Kaplan, Violante y Weidner, 2014: un tercio en EE. UU., 2 de cada 3 «ricos»; en torno al 20 % en España, Francia e Italia, **no comprobado en el artículo**, A33-15); España: Basso y Gómez-García (2025). Pegatina: «Lo comido por lo servido».

**Gráfico de referencia:** `oposicion/temario/fuentes/3A33/graficos/fisher-liquidez.tex` (**imprescindible**: el gráfico de Fisher con la recta quebrada en A; mismos ejes y letras que `fisher.tex`, ficha `fisher-intertemporal`).

**Notación:** b_{t+1} ≥ 0 (§ 7); λ fracción de la renta de los hogares *hand-to-mouth* de Campbell y Mankiw (local, avisada: no es un multiplicador de Lagrange) y μ su constante (local: μ es el margen en el canon); dotación A en el gráfico (§ 1, como el seguro).

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.33 | Consumo con incertidumbre | desarrollo (hecho, 31/10/2026) | Todo lo anterior: la recta quebrada en el gráfico de Fisher de la pizarra y la Euler con ≥ | — |
| 3.A.39 | Déficit y deuda | resumen | Entre las razones del incumplimiento de la equivalencia ricardiana, con λ de Campbell y Mankiw y remisión al 3.A.33 | La derivación |
| 3.A.40 | Políticas desde 2008 | resumen | Multiplicadores con hogares *hand-to-mouth* y HANK | El modelo de consumo |
| 3.A.37 | Transmisión monetaria | mención | Canal de la renta y el empleo en los hogares sin liquidez | — |
| 3.A.29 | Modelización dinámica | mención (hecho, 1/11/2026) | Extensiones de Robinson Crusoe (anexo D c)): con $b_{t+1}\geq0$ la separación de Fisher falla para quien querría endeudarse; la recta quebrada del 3.A.33; HANK en III.2 | El modelo de consumo |
| 3.A.25 | Capital humano | mención (hecho) | La separación de Fisher se rompe con restricciones de liquidez | — |
| 1D01 | Dictamen | mención aplicada (hecho) | Crédito (+) y hogares de renta baja que siguen su renta corriente | — |
| 3.A.7 | Política fiscal y HANK en la NEK | mención (hecho, 4/11/2026) | Hogares de regla de pulgar (Galí, López-Salido y Vallés, 2007): el consumo sube con el gasto público; en los HANK importa la PMC de cada hogar; `\vertema{3.A.33}` | El modelo de consumo |
| 3.A.6 | NMC | mención (hecho, 4/11/2026) | Razón del incumplimiento de la equivalencia ricardiana | El modelo |

## Divergencias encontradas en el temario actual
- 3.A.33 original: «r > ρ ⇒ oferente de ahorro» y Zeldes sin año (son 2 artículos de 1989: *JPE*, liquidez; *QJE*, precaución). **Resuelto** (31/10/2026).

Autor: Víctor Gutiérrez Marcos
