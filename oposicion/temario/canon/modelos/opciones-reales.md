# Inversión bajo incertidumbre e irreversibilidad (opciones reales; Bernanke 1983; McDonald y Siegel 1986; Pindyck 1991; Dixit y Pindyck 1994)

- **Área:** macro cerrada · **Tema de referencia:** 3.A.34 (incertidumbre e irreversibilidad de la inversión) — lo tiene en el título. **Revisado el 31/10/2026**: III.2 (incertidumbre con costes simétricos: Hartman-Abel), III.3 «La irreversibilidad de la inversión: la opción de esperar» (a)-e)) y anexo D (V* en tiempo continuo). Presentación fijada en la fase canon del 3.A.34 (DK7, A34-07, A34-10, A34-15, **[decidir]**).
- **Temas que lo usan:** 3.A.34 (desarrollo; hecho, 31/10/2026), 3.B.2 (resumen: valoración de proyectos), 3.A.33 (mención; hecho, 31/10/2026: III.2 c), la opción de esperar explica el aplazamiento de la compra de duraderos; Bernanke, 1983; Dixit y Pindyck, 1994; `\vertema{3.A.34}`), 3.A.26 (mención; hecho, 31/10/2026: con costes lineales e incertidumbre, valor de opción de esperar, «como la inversión irreversible del 3.A.34»), 3.A.10 (mención; hecho, 19/10/2026: «la incertidumbre y la irreversibilidad retrasan la inversión»), 3.B.25 (mención: la opción de esperar es una *call* americana sobre el proyecto)
- **Manuales de referencia:** Dixit y Pindyck, *Investment under Uncertainty* (1994), caps. 1, 2 y 5; Pindyck (1991), *JEL*; Bernanke (1983); McDonald y Siegel (1986); Romer (2019), cap. 9; Abel y Eberly (1994, 1999).

## Presentación de referencia (3.A.34, III.2-III.3)

**Pregunta:** ¿por qué la incertidumbre retrasa la inversión aunque el VAN sea positivo?

**Antes, el contraste (III.2):** con costes de ajuste **simétricos y convexos** y sin irreversibilidad, la incertidumbre puede **aumentar** la inversión (Hartman, 1972; Abel, 1983): con el trabajo flexible, el beneficio por unidad de capital es convexo en el precio, $B(p)=\alpha(1-\alpha)^{(1-\alpha)/\alpha}w^{-(1-\alpha)/\alpha}p^{1/\alpha}$, y por Jensen más dispersión eleva $\mathbb E[B(p)]$, $q$ y la inversión (`\vertema{3.A.10}`); Caballero (1991): el signo depende de la asimetría de costes y de la competencia. Nunca «el enfoque tiene sus orígenes en Abel y Bernanke».

**a) Idea.** Si la inversión es irreversible y aplazable, la oportunidad de invertir es una **opción real**: el derecho, no la obligación, de pagar un coste hundido $I$ a cambio de un proyecto que vale $V$; invertir la extingue. Antecedentes: Arrow (1968), Henry (1974); Bernanke (1983) al ciclo; McDonald y Siegel (1986); Pindyck (1991) y Dixit y Pindyck (1994).

**b) Supuestos.** Un proyecto produce una unidad al año para siempre; precio de hoy $p_0$; desde el año 1, $p^{\mathrm A}$ con **probabilidad π** o $p^{\mathrm B}<p^{\mathrm A}$ con $1-\pi$ (π probabilidad, no p, que es precio; estados A y B en redonda); coste **$I$ hundido** (la misma $I$ del tema, en una sola vez, con nota); se puede invertir hoy o dentro de un año; neutral al riesgo, tipo $r$.

**c) Desarrollo.** $V^{\mathrm A}=p^{\mathrm A}(1+r)/r$, $V^{\mathrm B}=p^{\mathrm B}(1+r)/r$, $V_0=p_0+[\pi V^{\mathrm A}+(1-\pi)V^{\mathrm B}]/(1+r)$. Invertir hoy: $\mathrm{VAN}_0=V_0-I$. Esperar (con $V^{\mathrm B}<I<V^{\mathrm A}$): $\mathrm{VAN}_{\mathrm{esperar}}=\pi(V^{\mathrm A}-I)/(1+r)$. **Regla** (`eq:opcion-esperar`, función clave):
$$\boxed{V_0-I\ \ge\ \frac{\pi\,(V^{\mathrm A}-I)}{1+r}}$$
(«No por mucho madrugar amanece más temprano»). **Principio de las malas noticias** (Bernanke, 1983): $\mathrm{VAN}_0-\mathrm{VAN}_{\mathrm{esperar}}=[p_0-rI/(1+r)]-(1-\pi)(I-V^{\mathrm B})/(1+r)$; $V^{\mathrm A}$ no aparece.
**Ejemplo de referencia: Pindyck (1991)** (A34-07, **[decidir]**; sustituye al I = 100 con 160/60 de la propuesta de coherencia): $I=1.600$, $p_0=200$, precios 300 o 100 con $\pi=0{,}5$, $r=10$ %: $V_0=2.200$, $\mathrm{VAN}_0=600$; $\mathrm{VAN}_{\mathrm{esperar}}\approx773$; esperar cuesta ≈ 55 y evita ≈ 227; invertir hoy solo compensa si $I\le1.283$; con 350 o 50, esperar vale ≈ 1.023. Tabla `tab:opcion-dos-periodos`.
**Tiempo continuo** (anexo D): $dV=\alpha_VV\,dt+\sigma V\,dz$ ($\alpha_V<r$ tendencia, σ volatilidad, $dz$ Wiener); $rO(V)=\alpha_VVO'(V)+\tfrac12\sigma^2V^2O''(V)$; $O(V)=AV^{\beta_1}$, β₁ > 1 raíz positiva de $\tfrac12\sigma^2\beta(\beta-1)+\alpha_V\beta-r=0$; continuidad $O(V^*)=V^*-I$ y tangencia $O'(V^*)=1$:
$$V^*=\frac{\beta_1}{\beta_1-1}\,I>I\qquad(\texttt{eq:umbral-inversion}),$$
con β₁ decreciente en σ. Ejemplo $\alpha_V=0$, $r=4$ %, σ = 0,2 ⇒ β₁ = 2, $V^*=2I$ (la cifra de McDonald y Siegel; A34-10).

**d) Implicaciones.** Fallan las reglas del VAN ($V\ge I$) y de Jorgenson ($PF_K=c_K$); más incertidumbre, más espera; con incertidumbre alta, bajar el tipo mueve poco la inversión: lo que más ayuda es reducir la incertidumbre de la propia política (estabilidad y credibilidad, Rodrik, 1991; III.5 y `tab:implicaciones-inversion`).

**e) Extensiones, evidencia y valoración.** Otras opciones reales (ampliar, abandonar, por fases; *call* americana, `\vertema{3.B.25}`, `\vertema{3.B.2}`); competencia; duraderos (`\vertema{3.A.33}`); **histéresis de Dixit (1989)** y Baldwin y Krugman (1989), con nota de que no es la histéresis del paro (ficha `histeresis`, `\vertema{3.A.28}`). Evidencia: McDonald y Siegel (1986), Guiso y Parigi (1999), Bloom (2009), Bloom, Bond y Van Reenen (2007), Baker, Bloom y Davis (2016), Julio y Yook (2012, −4,8 % en años electorales), Ghirelli, Pérez y Urtasun (2019) con el índice del Banco de España. Valoración: equilibrio parcial, riesgo y no incertidumbre knightiana, efecto ambiguo sobre el capital a largo plazo (Abel y Eberly, 1999), causalidad.

**Gráficos de referencia** (`oposicion/temario/fuentes/3A34/graficos/`): **`opcion-esperar.tex`** (valor de la opción **O(V)** convexo frente a $V-I$, tangente en $V^*$); de datos, `epu-espana.tex` (índice del Banco de España, 1997-2026, media 1997-2018 = 100; A34-19).

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.34 | Incertidumbre e irreversibilidad | desarrollo (hecho, 31/10/2026) | Todo lo anterior; anexo D | — |
| 3.B.2 | Valoración de inversiones en la empresa | resumen | Opciones reales (diferir, ampliar, abandonar) como complemento del VAN; el VAN **supone inversión reversible o de ahora o nunca**; la regla $V\ge I+$ valor de la opción, con `\vertema{3.A.34}` | La derivación en tiempo continuo y la evidencia macro |
| 3.A.33 | Demanda de duraderos | mención (hecho, 31/10/2026) | Compra en parte irreversible; con incertidumbre, valor de opción de esperar (principio de las malas noticias); Eberly (1994) | El ejemplo de 2 periodos |
| 3.A.26 | Costes de ajuste del empleo | mención (hecho, 31/10/2026) | Con costes lineales e incertidumbre, opción de esperar al contratar o despedir | El modelo |
| 3.A.10 | Incertidumbre y riesgo | mención (hecho) | La irreversibilidad con incertidumbre retrasa la inversión | El modelo |
| 3.B.25 | Derivados | mención | La opción de esperar como *call* americana sobre el proyecto | El modelo de inversión |

## Notación
O(V) valor de la opción (**DK7/A34-15, [decidir]**: F es la producción en el mismo tema; Dixit y Pindyck escriben F(V)); V, V_0, V^A, V^B, V* valores del proyecto (V con subíndice o superíndice, como los valores en finanzas, § 1); π probabilidad; I desembolso hundido; α_V, σ, dz, β₁ y A del anexo D, locales (β con subíndice = coeficiente o raíz, § 1; A constante de integración, no la productividad).

## Divergencias encontradas en el temario actual
- 3.A.34: el modelo de la opción no estaba (3.3 sin título y 3.4 vacío); «orígenes en Abel y Bernanke»; frase sobre la desigualdad sin fuente. **Resuelto** (31/10/2026).
- 3.B.2 (sin revisar): «el método del VAN asume irreversibilidad»: más preciso, «supone que la inversión es **reversible** o que es **ahora o nunca**» (Dixit y Pindyck, 1994, cap. 1); su apartado de opciones reales es coherente con la ficha.

Autor: Víctor Gutiérrez Marcos
