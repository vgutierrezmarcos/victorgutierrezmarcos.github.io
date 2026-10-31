# Crecimiento por aumento del número de variedades (Romer 1990; Grossman y Helpman 1991)

- **Área:** macro cerrada · **Tema de referencia:** **3.A.44** (crecimiento endógeno: innovación tecnológica) — único tema que lo desarrolla: II.2.1 (`sec:romer`, 3′30″ en el cante) con a)-e) y el anexo C paso a paso (`anexo:romer`); revisado el 1/11/2026.
- **Temas que lo usan:** 3.A.44 (desarrollo; hecho, 1/11/2026), 3.A.18 (mención; hecho, 19/10/2026: extensión de Dixit-Stiglitz al crecimiento), 3.A.15 (mención; hecho, 20/10/2026: patentes y monopolio temporal como precio de la innovación), 3.B.9 (resumen: comercio y crecimiento, Rivera-Batiz y Romer 1991), 3.B.34, 3.B.39, 3.B.42 (mención), 4.A.7 (previsto)
- **Manuales de referencia:** Romer (1990), *JPE*; Romer (2019), cap. 3; Barro y Sala-i-Martin (2004), cap. 6; Acemoglu (2009), cap. 13; Grossman y Helpman (1991), cap. 3.
- **Decisión D023 (13/10/2026):** ¿Se reserva M para el dinero (y las importaciones) y se cambian sus otros usos? Sí: número de variedades de Romer (1990) N_t, función de emparejamiento m(U,V), renta no laboral W̄
- **Decisiones D003 y D026:** B beneficio (π es inflación y probabilidad); w salario real.

## Presentación de referencia (3.A.44, II.2.1 y anexo C)

**a) Idea.** ¿Cómo genera crecimiento sostenido la invención de nuevos bienes intermedios? El progreso técnico es un aumento del número de variedades (tractores, fertilizantes, semillas además de azadas). El agregador es la CES de Dixit y Stiglitz (`\vertema{3.A.18}`): con variedades de bienes intermedios, la preferencia por la variedad se convierte en rendimientos crecientes.

**b) i) Supuestos** (en este orden; gráfico `romer-sectores`, 3 sectores):
- *Bien final*, competencia perfecta: $Y_t=L_Y^{1-\alpha}\sum_{j=1}^{N_t}x_j^{\alpha}$, 0 < α < 1 (`eq:romer-y`); $N_t$ número de variedades (D023).
- *Bienes intermedios*: un monopolista por variedad con patente perpetua; coste marginal 1 (bien final).
- *I+D* con libre entrada: $\dot N_t=\eta_I\,L_I\,N_t$ (`eq:romer-ideas`), **$L_I$ investigadores** y **$\eta_I$ productividad de la investigación**; las ideas ya inventadas, no rivales, hacen más productivos a los investigadores («a hombros de gigantes»).
- *Trabajo*: población constante, **$L=L_Y+L_I$**, mismo salario **w**.
- *Hogares de Ramsey* CRRA, que ahorran comprando patentes.

**b) ii) Desarrollo** (hacia atrás, `\vertema{3.A.14}`):
- Bien final: $p_j=\alpha L_Y^{1-\alpha}x_j^{\alpha-1}$, elasticidad $1/(1-\alpha)=\sigma$ de Dixit-Stiglitz.
- Monopolista: margen $\sigma/(\sigma-1)=1/\alpha$ (`eq:lerner-variedad` del 3.A.18, μ = 1/α), $p=1/\alpha$; $x=\alpha^{2/(1-\alpha)}L_Y$; beneficio por periodo **$B_j=\frac{1-\alpha}{\alpha}\alpha^{2/(1-\alpha)}L_Y$**.
- Patente: **$V=B_j/r$**; libre entrada, $\eta_INV=w$ ⇒ **$r=\alpha\,\eta_I\,L_Y$** (pizarra: «Romer: $r=\alpha\eta_IL_Y$»).
- Equilibrio: $\gamma=\eta_IL_I=\eta_I(L-L_Y)$ y la Euler `eq:euler-endogeno`:
$$\gamma^{\mathrm E}=\frac{\alpha\,\eta_I\,L-\rho}{\alpha+\theta}\qquad(\texttt{eq:romer-gamma})$$
- Planificador (sin margen, $x=\alpha^{1/(1-\alpha)}L_Y$; internaliza el desbordamiento):
$$\gamma^{\mathrm P}=\frac{\eta_I\,L-\rho}{\theta}\;>\;\gamma^{\mathrm E}.$$
- Forma general de Barro y Sala-i-Martin: $\gamma=(\eta_IL-\Lambda\rho)/(1+\Lambda\theta)$; **con la normalización del 3.A.44, Λ = 1/α**, y sale la fórmula de arriba. En el tema no se escribe Λ (en el § 0 de `notacion.md`, Λ es el nombre alternativo de la lagrangiana).

**b) iii) Implicaciones.** Crecimiento endógeno por la innovación, sin transición ni convergencia; **efecto escala** (γ crece con $L$; por eso $L$ constante; ficha `semiendogeno`); el mercado crece de menos por **2 distorsiones**: estática (margen de monopolio, pocos intermedios) y dinámica (apropiabilidad y desbordamiento intertemporal) ⇒ **2 instrumentos**: subvención a la compra de intermedios de tipo $1-\alpha$ y subvenciones a la I+D (Barro y Sala-i-Martin, 2004, cap. 6); con uno solo, segundo óptimo. Patentes: eficiencia estática frente a dinámica (`\vertema{3.A.15}`). Apertura: integrar 2 economías que intercambian bienes **e ideas** equivale a duplicar $L$ (Rivera-Batiz y Romer, 1991). Instituciones (North y Thomas, 1973; Estatuto de Monopolios de 1624).

**c) Extensiones.** Versión de laboratorio (la I+D usa bien final: un $AK$ en las ideas, sin efecto escala del trabajo; única distorsión, el margen); caja de **Grossman y Helpman (1991)**: Stolper-Samuelson y coste de la I+D (`\vertema{3.B.5}`, `\vertema{3.B.9}`), efectos sobre el crecimiento, no sobre el bienestar.

**d) Evidencia.** Jones y Williams (1998): la I+D óptima de EE. UU. sería de 2 a 4 veces la observada; Broda y Weinstein (2006): variedades importadas; el efecto escala choca con los datos (III del 3.A.44).

**e) Valoración.** A favor: la innovación como inversión deliberada con su financiación (monopolio) y sus fallos. En contra: efecto escala; producción de ideas lineal en $N$ (filo de la navaja); no hay obsolescencia → Aghion-Howitt.

**Gráfico de referencia:** `oposicion/temario/fuentes/3A44/graficos/romer-sectores.tex` (esquema de los 3 sectores). Tabla `tab:variedades-calidades` (frente a Aghion-Howitt) y fila de `tab:resumen-modelos`.

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.44 | Innovación como fuente de crecimiento | desarrollo (hecho, 1/11/2026) | Lo de arriba | — |
| 3.B.9 | Comercio y crecimiento | resumen | Integración y difusión de ideas (Rivera-Batiz y Romer): duplicar el mercado eleva el crecimiento; Grossman y Helpman con el mismo mecanismo de Stolper-Samuelson que la caja del 3.A.44; $N_t$, $L_I$, $\eta_I$ | Derivación `\vertema{3.A.44}` |
| 3.A.18 | Competencia monopolística | mención (hecho, 19/10/2026) | Con variedades de bienes intermedios, la preferencia por la variedad se convierte en rendimientos crecientes y sostiene el crecimiento; `\vertema{3.A.44}` (ficha `dixit-stiglitz`) | El modelo |
| 3.A.15 | Barreras, patentes | mención (hecho, 20/10/2026) | Patentes como monopolio temporal que paga la innovación | El modelo |
| 3.B.34, 3.B.39, 3.B.42 | Liberalización, desarrollo | mención | Ideas no rivales como motor | — |
| 4.A.7 | Política de ciencia y tecnología | previsto | No rivalidad, 2 distorsiones y 2 instrumentos; efecto escala corregido por Jones | El modelo |

## Divergencias encontradas en el temario actual
- 3.A.44 (Word): $n$ o $M$ para el número de variedades, $W$, ϕ coste de la invención, sin fórmula de γ, «la versión de Romer se llama semiendógena» (es Jones, 1995). **Resuelto** (1/11/2026): $N_t$, $w$, $1/\eta_I$, $L_I$, $B_j$, γ^E y γ^P.
- **Esta ficha** escribía hasta el 1/11/2026 $L_N$ (trabajo en I+D), π y $V=\pi/r$: ahora **$L_I$** (la misma letra en Romer, Aghion-Howitt y Jones; DK12 del 3.A.44) y **$B_j$**, **$V=B_j/r$** (B beneficio, D003).
- Romer/Grossman-Helpman duplicado entre 3.A.44 y 3.B.9: el 3.B.9 debe resumir y remitir, y redactar de nuevo la parte copiada de otro preparador.

Autor: Víctor Gutiérrez Marcos
