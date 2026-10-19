# Demanda de seguros con información simétrica (Mossin, 1968)

- **Área:** consumidor-producción · **Tema de referencia:** **3.A.10** (Demanda III; revisado el 19/10/2026, I.2.1 y anexo E.3) — la aplicación más sencilla de la utilidad esperada, con la estructura a)-e), el gráfico por capas y la tabla de casos; el 3.A.13 la resume en una caja previa para pasar a Rothschild-Stiglitz. Ficha creada a raíz de esa revisión (K43). **No es Rothschild-Stiglitz** (1976), que es la selección adversa del 3.A.13 (ficha `rothschild-stiglitz`).
- **Temas que lo usan:** 3.A.10 (desarrollo; hecho), 3.A.13 (resumen; hecho, 19/10/2026: caja «El seguro con información simétrica» de I.3.2 y gráfico `seguro-simetrico.tex`, misma notación y ejes), 3.A.21 (mención opcional: el plano (x_1, x_2) con la recta de precios de estado es el de la preferencia por el estado, ficha `arrow-debreu-incertidumbre`), 4.B.3 y temas de sanidad o pensiones (mención si tratan los seguros: franquicias, seguro obligatorio; sin fijar).
- **Manuales de referencia:** Mossin (1968, *JPE*); Smith (1968); Mas-Colell, Whinston y Green (1995), § 6.C; Varian (1992), cap. 11, y Varian, *Intermedia*, cap. 12 (γ para la prima); Rodríguez López (2017); Cook y Graham (1977) y Karni (1985) para la utilidad dependiente del estado; Sydnor (2010) para la evidencia; Arrow y Lind (1970) para el *risk spreading*.

## Presentación de referencia (3.A.10, I.2.1)

Pregunta: ¿cuánto seguro compra un consumidor averso que puede sufrir una pérdida?

- **a) Idea:** trasladar riqueza del estado bueno al malo para reducir la exposición al riesgo.
- **b) Modelo.** i) Supuestos: riqueza inicial **W̄**; con probabilidad **π** pierde **L**; sin seguro, la lotería **(W̄, W̄ − L; 1 − π, π)** (resultados delante, probabilidades detrás, como la definición de lotería de la ficha `utilidad-esperada-vnm`; el 3.A.13 la escribe igual), punto **A = (W̄, W̄ − L)** del plano (x_1, x_2), con la riqueza **sin accidente x_1 en abscisas** y **con accidente x_2 en ordenadas**; u continua, creciente y estrictamente cóncava, U = (1 − π)u(x_1) + πu(x_2) (con ln, una Cobb-Douglas en logaritmos con las probabilidades como exponentes, 3.A.8); cobertura **S**, prima **γ por euro asegurado** (γS en total, haya o no accidente), **0 ≤ S ≤ L**; información simétrica. ii) Desarrollo:
$$x_1=\overline W-\gamma S,\qquad x_2=\overline W-L+(1-\gamma)S\ \Longrightarrow\ x_2=\frac{\overline W}{\gamma}-L-\frac{1-\gamma}{\gamma}\,x_1$$
(`eq:riqueza-estados`, `eq:recta-seguro`; **recta de aseguramiento** por A, pendiente −(1 − γ)/γ, análoga a la recta de balance del 3.A.8);
$$\max_{S}\ (1-\pi)\,u(\overline W-\gamma S)+\pi\,u\big(\overline W-L+(1-\gamma)S\big)\quad\text{s.a. } 0\le S\le L$$
(`\funcionclave` con `\optim`, `eq:problema-seguro`) ⇒ **RMSE** ≡ (1 − π)u'(x_1)/[πu'(x_2)] = (1 − γ)/γ (`eq:cpo-seguro`; relación marginal de sustitución **estocástica, o entre estados**, en valor absoluto, en redonda; vale (1 − π)/π en la **línea de certeza** x_1 = x_2). iii) Implicaciones: beneficio esperado nulo (γ − π)S = 0 ⇒ **prima actuarialmente justa γ = π**; **teorema de Mossin**: con prima justa, seguro completo S* = L (punto **E** en la línea de certeza); con **prima recargada** γ > π, seguro parcial S* < L (punto **E'** entre A y la línea de certeza: franquicias); estática comparativa (más cobertura con más aversión, π y L; menos con γ; con prima recargada y DARA el seguro es un bien inferior).
- **c) Extensiones:** prima **favorable** γ < π (solo con subvención); tabla `tab:seguros-casos` de 9 casos (averso, neutral, amante × favorable, justa, recargada) con 0 ≤ S ≤ L, en color.
- **d) Evidencia:** franquicias y coberturas parciales; sobreaseguro de riesgos pequeños (Sydnor, 2010), que enlaza con la calibración de Rabin (II.1 del 3.A.10).
- **e) Valoración:** explica la existencia del seguro y da la referencia de eficiencia (seguro completo); la aseguradora es neutral por *risk pooling* y *risk spreading* (Arrow y Lind, 1970); supone información simétrica (selección adversa y riesgo moral, 3.A.13) y utilidad independiente del estado.
- **Extensiones del mismo tema (I.3 del 3.A.10):** utilidad dependiente del estado u_s(x_s): con prima justa se igualan las utilidades marginales u_1'(x_1) = u_2'(x_2), no las riquezas, y puede convenir asegurarse menos que por completo (Cook y Graham, 1977); **preferencia por el estado**: es el mismo gráfico con la recta de precios de 2 bienes contingentes, p_2/p_1 = γ/(1 − γ), y la tangencia π_su'(x_s)/[π_{s'}u'(x_{s'})] = p_s/p_{s'} (`eq:precios-estado`, la misma del 3.A.21; ficha `arrow-debreu-incertidumbre`).
- **Notación:** W̄, L, S, π, **γ** (nunca r ni P para la prima, ni W para la riqueza, ni p para la probabilidad), x_1, x_2, RMSE; puntos A (dotación, cursiva, sin subíndice), E (seguro completo), E' (parcial). `notacion.md` § 1 (γ, A, w/r) y § 2.

**Gráfico de referencia:** `oposicion/temario/fuentes/3A10/graficos/seguros.tex` (**imprescindible**, por capas: línea de certeza, A, recta de prima justa rotulada «γ = π» con E, recta recargada con E'); construido a partir de `oposicion/temario/fuentes/3A13/graficos/seguro-simetrico.tex` (misma notación y ejes) más la capa de la prima recargada. El 3.A.13 usa `seguro-simetrico.tex` como caja previa de `rothschild-stiglitz.tex`.

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.10 | Aplicaciones de la utilidad esperada | desarrollo (hecho, 19/10/2026) | Todo lo anterior | — |
| 3.A.13 | Selección adversa: autoselección | resumen (hecho, 19/10/2026) | Caja previa de 2 frases: lotería, A, recta de pendiente −(1 − γ)/γ, γ = π, Mossin; remite a 3.A.10 | La tabla de casos, la derivación, la estática comparativa |
| 3.A.21 | Equilibrio general con incertidumbre | mención (opcional) | El plano (x_1, x_2) y la tangencia con precios de estado, si se dibuja | El seguro |
| 4.B.3 y temas de sanidad o pensiones | Seguros públicos | mención | Seguro completo con prima justa como referencia; seguro obligatorio por selección adversa (3.A.13) | El modelo |

## Divergencias encontradas en el temario actual
- 3.A.10 y 3.A.13 originales: modelo titulado «Rothschild y Stiglitz, 1976» (es Mossin, 1968), A = (p_1, p_2; W, W − P), «−dx_2/dx_1 = −(1 − r)/r», prima favorable como «competencia imperfecta», tabla de 10 gráficos con celdas incoherentes; el 3.A.13 copiaba la derivación literal. **Resuelto** en las dos revisiones (19/10/2026), con γ y A fijados en el canon.
- El orden de la lotería (resultados delante) quedó igualado en el 3.A.13 en su fase de integración (19/10/2026).

Autor: Víctor Gutiérrez Marcos
