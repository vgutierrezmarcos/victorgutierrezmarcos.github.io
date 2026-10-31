# Modelo neoclásico de inversión y coste de uso del capital (Jorgenson 1963; Hall y Jorgenson 1967)

- **Área:** macro cerrada · **Tema de referencia:** 3.A.34 (teorías de la inversión) — es la teoría neoclásica de la inversión. **Revisado el 31/10/2026**: I.4 (dentro de I «Antecedentes: de Keynes al modelo neoclásico») y anexo B (derivación en valor corriente y presente, inversión infinita).
- **Temas que lo usan:** 3.A.34 (desarrollo; hecho, 31/10/2026), 4.B.10 (desarrollo: impuesto de sociedades), 3.A.33 (mención; hecho, 31/10/2026: el coste de uso del duradero, c^d_t ≃ p^d_t(r + δ − π^d_{t+1}), `eq:coste-uso`, con los 3 componentes de c_K y `\vertema{3.A.34}`; ficha `bienes-duraderos`)
- **Manuales de referencia:** Jorgenson (1963); Hall y Jorgenson (1967); Haavelmo (1960); Romer (2019), cap. 9; Blanchard y Fischer (1989).
- **Decisión D009 (13/10/2026):** ¿Cómo se escribe la sensibilidad de la inversión al tipo de interés en IS-LM y Mundell-Fleming? b (I = Ī − b·i), como Dornbusch-Fischer-Startz; v queda solo para la relación capital-producto (acelerador, Harrod-Domar)

## Presentación de referencia (3.A.34, I.4)

**Pregunta:** ¿cuál es el stock de capital deseado y de qué depende?

**a) Idea.** Microfundamentar la inversión como Friedman el consumo: problema dinámico de una empresa que maximiza el valor actual de sus beneficios (Jorgenson, 1963, entre los 20 artículos más influyentes del primer siglo de la *AER*). Resultado central: el **coste de uso del capital**.

**b) Supuestos** (5): empresa representativa; competencia perfecta en producto ($P$), trabajo ($W$) y bienes de capital ($P^K$); $Y_t=F(K_t,L_t)$ neoclásica con rendimientos constantes e Inada (solo las 2 sobre $F_K$ y $F_L$ más la esencialidad, `\vertema{3.A.43}`); **$r$ constante y nivel general de precios constante, de modo que $r$ es a la vez nominal y real** (A34-01, **[decidir]**: alternativa, el bien como numerario con $P=1$ y $w$ real, como el 3.A.25 y el 3.A.26); sin costes de ajuste, depreciación δ.

**c) Desarrollo.**
$$\max_{\{L_t,I_t\}}\int_0^\infty e^{-rt}\big[P_tF(K_t,L_t)-W_tL_t-P^K_tI_t\big]dt\quad\text{s.a.}\quad\dot K_t=I_t-\delta K_t,\ K_0\ \text{dado}\qquad(\texttt{eq:problema-jorgenson})$$
Hamiltoniano **en valor corriente** (DK8, **[decidir]**): $\mathcal H_t=P_tF-W_tL_t-P^K_tI_t+\lambda_t(I_t-\delta K_t)$, con **λ_t precio sombra del capital**; la transversalidad es condición de optimalidad (no restricción). CPO: $PF_L=W$; $\lambda_t=P^K_t$; y
$$\boxed{P\,F_K(K^*,L)=c_K\equiv P^K\Big(r+\delta-\frac{\dot P^K}{P^K}\Big)}\qquad(\texttt{eq:coste-uso},\ \text{función clave})$$
con 3 componentes: coste de oportunidad $P^Kr$, depreciación $P^K\delta$, ganancia de capital $-\dot P^K$. «Como si la empresa se alquilara el capital a sí misma.» **Cierre**: con rendimientos constantes la condición solo fija $K/L$; Jorgenson toma la producción como dada: con Cobb-Douglas, $K^*=\alpha PY/c_K$. Inversión: $I_t=K^*_t-K_{t-1}+\delta K_{t-1}$, repartida con retardos distribuidos (como el acelerador flexible, ficha `acelerador`).

**Con impuestos** (Hall y Jorgenson, 1967; I.4, viñeta y nota, con `\vertema{4.B.10}`): tipo del impuesto de sociedades $t$, desgravación de una fracción **θ** del precio del capital (local, como Romer; nota de que θ no es aquí la CRRA) y valor actual $z$ de las amortizaciones fiscales por euro:
$$c_K=P^K(r+\delta)\,\frac{(1-\theta)(1-tz)}{1-t};$$
con $z=1$ y $\theta=0$, el impuesto es neutral; si solo se deduce la depreciación económica, $z=\delta/(r+\delta)$ y $c_K=P^K[r/(1-t)+\delta]$.

**d) Valoración.** Teoría del capital deseado, no de la inversión (Haavelmo, 1960): si $c_K$ baja de golpe, la inversión sería infinita en ese instante; solo importan las variables de hoy; los retardos son *ad hoc* → paso a la q (ficha `q-tobin`).

**Gráfico de referencia:** `oposicion/temario/fuentes/3A34/graficos/jorgenson.tex`, plano $(K,\ \text{coste})$: $PF_K$ decreciente y $c_K$ horizontal, corte en $K^*$; por capas en el cante (ejes, $PF_K$, $c_K$, $K^*$, bajada de $r$).

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.34 | Teorías de la inversión | desarrollo (hecho, 31/10/2026) | Coste de uso, capital deseado, cierre, impuestos en nota, limitaciones y paso a la q; anexo B | — |
| 4.B.10 | Efecto del impuesto de sociedades sobre la inversión | desarrollo (aplicación) | Coste de uso con impuestos según la deducibilidad de amortizaciones e intereses; neutralidad; la fórmula de arriba con θ, $t$, $z$ (o la letra que fije el 4.B.10 para la desgravación, con nota) | La derivación básica [ver tema 3.A.34] |
| 3.A.33 | Demanda de duraderos | mención (hecho, 31/10/2026) | El paralelo: c^d_t del hogar frente a c_K de la empresa, misma δ y r; la compra de duraderos como inversión del hogar | El stock deseado de la empresa |

## Divergencias encontradas en el temario actual
- 3.A.34: coste en términos reales con el tipo «real» descontando un objetivo nominal; transversalidad como restricción; Inada con «lim F = ∞»; v como sensibilidad al tipo; sin cierre del modelo. **Resuelto** (31/10/2026).
- 4.B.10 (sin revisar): escribe el coste con $P^K=1$: unificar con **c_K** y la fórmula de Hall y Jorgenson de arriba.
- 3.A.4 (sin revisar): escribe la inversión keynesiana I = Ī − v·r: con D009, **I = Ī − b·i** (v es la relación capital-producto del acelerador) y la eficiencia marginal del capital con sigla, EMgK (ficha `eficiencia-marginal-capital`).

Autor: Víctor Gutiérrez Marcos
