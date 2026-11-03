# Modelo schumpeteriano de mejoras de calidad (Aghion y Howitt 1992)

- **Área:** macro cerrada · **Tema de referencia:** **3.A.44** (crecimiento endógeno: innovación tecnológica) — único tema que lo desarrolla: II.2.2 (`sec:aghion-howitt`, 3′ en el cante) con a)-e) y el anexo D paso a paso (`anexo:aghion-howitt`); revisado el 1/11/2026. Premio Nobel de Economía de 2025 (Aghion y Howitt, con Mokyr).
- **Temas que lo usan:** 3.A.44 (desarrollo; hecho, 1/11/2026), 3.A.17 (mención; hecho, 17/10/2026: U invertida competencia-innovación y efecto reemplazo de Arrow), 3.A.15 (mención; hecho, 20/10/2026: patentes y efecto reemplazo), 3.B.28 (mención; hecho, 3/11/2026: III.1, distancia a la frontera de Acemoglu, Aghion y Zilibotti, 2006, imitar o innovar, y trampa de la renta media, Gill y Kharas, 2007, con el WDR 2024 y sus 3 «íes», `\vertema{3.A.44}`), 3.B.31 (mención; hecho, 31/10/2026: cambio técnico dirigido, Acemoglu et al., 2012), 3.B.42 (mención), 4.A.15 (mención prevista: la competencia como política de crecimiento)
- **Manuales de referencia:** Aghion y Howitt (1992), *Econometrica*; Aghion y Howitt, *The Economics of Growth* (2009), cap. 4; Acemoglu (2009), cap. 14; Barro y Sala-i-Martin (2004), cap. 7; Grossman y Helpman (1991), cap. 4.

## Presentación de referencia (3.A.44, II.2.2 y anexo D)

**a) Idea.** ¿Cómo genera crecimiento la destrucción creativa? Progresar es **mejorar la calidad** de lo que existe; cada mejora deja obsoleta la anterior y el innovador tiene un monopolio temporal («rey muerto, rey puesto»). Pone ecuaciones a Schumpeter; frente a Romer, hay ganadores y perdedores. **No** se modeliza con Dixit-Stiglitz (eso es Romer): es una escalera de calidades.

**b) i) Supuestos.**
- *Bien final* competitivo con un único intermedio de calidad $A_t$: $y_t=A_t\,x_t^{\alpha}$, 0 < α < 1.
- *Intermedio*: en monopolio del último innovador, una unidad de trabajo por unidad.
- *Investigación*: con **$L_I$** investigadores, innovaciones de **Poisson a la tasa $\lambda_IL_I$**; cada una multiplica la calidad por **$\gamma_q>1$** (escalera de calidades; γ sola queda para tasas de crecimiento). El monopolista en ejercicio no investiga (**efecto reemplazo** de Arrow, 1962, `\vertema{3.A.17}`).
- *Trabajo*: $L=x+L_I$, mismo salario. *Hogares* neutrales al riesgo: $r=\rho$.

**b) ii) Desarrollo.**
- Beneficio: $B_t=A_t\frac{1-\alpha}{\alpha}\,\omega\,x$, con $\omega\equiv w/A$ (local).
- Valor de una innovación, con la obsolescencia como depreciación:
$$V_{t+1}=\frac{B_{t+1}}{r+\lambda_IL_I}$$
- Arbitraje $w_t=\lambda_IV_{t+1}$; en el estado estacionario:
$$1=\lambda_I\,\gamma_q\,\frac{1-\alpha}{\alpha}\;\frac{L-L_I}{\rho+\lambda_IL_I}\qquad(\texttt{eq:ah-arbitraje})$$
  decreciente en $L_I$ (menos producción, monopolios más cortos); su corte con 1 da $L_I^*$.
- Crecimiento medio:
$$\gamma=\lambda_I\,L_I^*\,\ln\gamma_q,\qquad L_I^*=\frac{\gamma_q\frac{1-\alpha}{\alpha}L-\frac{\rho}{\lambda_I}}{1+\gamma_q\frac{1-\alpha}{\alpha}}\qquad(\texttt{eq:ah-gamma})$$
  (pizarra: «A-H: $\gamma=\lambda_IL_I^*\ln\gamma_q$»; sin recuadro: el 3.A.44 tiene 2 funciones clave, Euler y Jones).

**b) iii) Implicaciones.** γ sube con $\lambda_I$, $\gamma_q$, $L$ (**efecto escala**) y la paciencia; **baja con la competencia** (α mayor, menos margen: efecto schumpeteriano). **Eficiencia ambigua**: de menos por el efecto intertemporal y el de apropiabilidad; de más por el **robo de negocio**. Economía política: los perdedores frenan la innovación (`\vertema{3.A.20}`, `\vertema{4.A.15}`).

**c) Extensiones.** **U invertida** competencia-innovación con competencia paso a paso (Aghion et al., 2005: efecto escapar de la competencia frente al schumpeteriano; `\vertema{3.A.17}`); **distancia a la frontera** (Acemoglu, Aghion y Zilibotti, 2006: imitar o innovar, instituciones apropiadas; `\vertema{3.B.28}`); escalera de calidades con muchos sectores (Grossman y Helpman, 1991, *RES*; `\vertema{3.B.9}`); cambio técnico dirigido (Acemoglu et al., 2012; `\vertema{3.B.31}`); Mokyr (2002), conocimiento proposicional y prescriptivo y sociedad abierta al cambio.

**d) Evidencia.** Aghion et al. (2005), U invertida en la industria británica; García-Macía, Hsieh y Klenow (2019): la mayor parte del crecimiento viene de empresas establecidas que mejoran sus productos; trampa de la renta media (Gill y Kharas, 2007).

**e) Valoración.** A favor: obsolescencia, organización industrial y crecimiento, economía política, predicciones con datos de empresas. En contra: efecto escala; bienestar ambiguo; la evidencia matiza el peso de la destrucción creativa.

**Gráfico de referencia:** `oposicion/temario/fuentes/3A44/graficos/aghion-howitt.tex`: a la izquierda, el arbitraje en el plano ($L_I$, ·), lado derecho de `eq:ah-arbitraje` decreciente cortando el 1 en $L_I^*$; a la derecha, la escalera de calidades. Tabla `tab:variedades-calidades` (frente a Romer).

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.44 | Innovación tecnológica como motor | desarrollo (hecho, 1/11/2026) | Lo de arriba; comparación con Romer (variedades frente a calidades) | — |
| 3.A.17 | Monopolio y eficiencia dinámica | mención (hecho, 17/10/2026) | Efecto reemplazo de Arrow y U invertida (Aghion et al., 2005) | El modelo `\vertema{3.A.44}` |
| 3.A.15 | Barreras y patentes | mención (hecho, 20/10/2026) | El monopolista innova menos (Arrow, 1962) | El modelo |
| 3.B.28 | Desarrollo | mención (hecho, 3/11/2026) | Distancia a la frontera (lejos: imitar, con grandes grupos y crédito bancario; cerca: innovar, con competencia y mercados de capitales) y trampa de la renta media (34 economías a renta alta desde 1990; 108 en renta media con unos 6.000 millones; invertir, incorporar, innovar; BM, 2024) | Derivación |
| 3.B.31 | Cambio climático | mención (hecho, 31/10/2026) | Cambio técnico dirigido, subvención a la investigación limpia | El modelo |
| 3.B.42 | Desarrollo | mención | Instituciones y distancia a la frontera | Derivación |
| 4.A.15 | Liberalización y competencia | mención (prevista) | La defensa de la competencia como política de crecimiento | El modelo |

## Divergencias encontradas en el temario actual
- 3.A.44 (Word): epígrafe «innovación tecnológica y variedad de productos» (la variedad es Romer), «en el marco de Dixit-Stiglitz», distancia a la frontera atribuida al modelo de 1992 (es Acemoglu, Aghion y Zilibotti, 2006), extensiones copiadas del índice de otro material, sin ecuaciones. **Resuelto** (1/11/2026).
- **Esta ficha** escribía hasta el 1/11/2026 $n$ para el trabajo en I+D (n es el crecimiento de la población, `eq:jones`) y $\pi_{t+1}$ para el beneficio (π es inflación y probabilidad): ahora **$L_I$** y **$B_{t+1}$** (DK9, DK12 del 3.A.44).

Autor: Víctor Gutiérrez Marcos
