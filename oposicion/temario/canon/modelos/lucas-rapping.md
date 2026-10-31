# Oferta de trabajo intertemporal (Lucas y Rapping, 1969)

- **Área:** macro cerrada (`areas.json` la ponía en pensamiento por el nombre de Lucas; corregido el 31/10/2026) · **Tema de referencia:** 3.A.25 (Teoría neoclásica del mercado de trabajo. Análisis intertemporal de la oferta de trabajo; **revisado el 31/10/2026**, bloque II `sec:intertemporal`, con II.1-II.5 y el anexo `anexo:lr-infinito`): su título pide el análisis intertemporal y es el único tema que lo desarrolla.
- **Temas que lo usan:** 3.A.25 (desarrollo; hecho, 31/10/2026), 3.A.6 (resumen: microfundamentos del mercado de trabajo en la NMC), 3.A.42 (mención: mecanismo de propagación del RBC), 3.A.29 (mención: el horizonte infinito como aplicación de la optimización dinámica; el anexo C del 3.A.25 remite a él).
- **Manuales de referencia:** Lucas y Rapping (1969), *JPE* 77; MaCurdy (1981), *JPE*; Romer (2019), cap. 5.4; Cahuc, Carcillo y Zylberberg (2014), cap. 1; Blanchard y Fischer (1989), cap. 7; Keane (2011), *JEL*; Chetty, Guren, Manoli y Weber (2011), *AER P&P*.
- **Decisión D068 (13/10/2026):** ¿Cuál es el tema de referencia de Lucas-Rapping (oferta de trabajo intertemporal)? 3.A.25 (lo pide su título y es el único que lo desarrolla). **A25-02** (31/10/2026, aplicada la recomendada, **[decidir]**): 2 periodos en el cuerpo y el horizonte infinito en el anexo C.

## Presentación de referencia (3.A.25, II)

**Pregunta:** ¿por qué las horas trabajadas fluctúan tanto con salarios reales que varían poco? Pegatina del 3.A.25: «hacer el agosto».

- **a) Idea (II.1)**: el individuo elige *cuándo* trabajar: el ocio de hoy y el de mañana son sustitutivos. Microfundamento del mercado de trabajo; mercado que se vacía siempre, base de la NMC (3.A.6).
- **b) Modelo (II.2)**. i) Supuestos: hogar que vive 2 periodos, sin incertidumbre ni dinero; una unidad de tiempo por periodo ($O_0=1$), trabajo $L_t$ y ocio $1-L_t$; utilidad separable $\ln C_t+b\ln(1-L_t)$, $b>0$ peso del ocio, con $\beta\equiv1/(1+\rho)$; mercado de capitales perfecto al tipo real $r$; $w_1$, $w_2$ conocidos, sin renta no laboral. ii) Desarrollo (`eq:lr-problema`):
$$\max_{C_1,C_2,L_1,L_2}\ \ln C_1+b\ln(1-L_1)+\beta[\ln C_2+b\ln(1-L_2)]\quad\text{s.a.}\quad C_1+\frac{C_2}{1+r}=w_1L_1+\frac{w_2L_2}{1+r}$$
CPO con λ (utilidad marginal de la riqueza): intratemporal $bC_t/(1-L_t)=w_t$ (la tangencia estática, ficha `oferta-trabajo`), Euler $C_2/C_1=\beta(1+r)$ (3.A.29) y, dividiendo las del ocio, `\funcionclave` (`eq:lr-condicion`):
$$\frac{1-L_1}{1-L_2}=\frac{w_2}{\beta(1+r)\,w_1}$$
La oferta relativa depende del **salario relativo intertemporal** $w_1(1+r)/w_2$; $L_1/L_2=f(w_1/w_2\,(+),\ r\,(+),\ \rho\,(-))$. Solución cerrada: $L_1=1-\frac{b}{(1+b)(1+\beta)}\big[1+\frac{w_2}{(1+r)w_1}\big]$ (con $w_2=(1+r)w_1$ y β = 1, $L_1=1/(1+b)$). iii) Implicaciones (`tab:lr-implicaciones`): salario transitorio ↑ → $L_1$↑, $L_2$↓ (sustitución intertemporal, casi sin efecto riqueza); permanente → sin cambio de la oferta relativa y, con estas preferencias y sin renta no laboral, tampoco de las horas; $r$↑ → $L_1$↑; ρ↑ → $L_1$↓. Política: las medidas transitorias mueven más las horas que las permanentes.
- **c) Extensiones (II.3)**: **elasticidad de Frisch** (`eq:frisch`), con la utilidad de los modelos de ciclo $u(C_t,L_t)=\ln C_t-\chi L_t^{1+\varphi}/(1+\varphi)$ (χ peso de la desutilidad, φ inversa de Frisch; D004): $\chi L_t^\varphi=\lambda_tw_t$ y
$$\varepsilon^F_{L,w}\equiv\left.\frac{\partial\ln L_t}{\partial\ln w_t}\right|_{\lambda}=\frac1\varphi$$
con la utilidad de referencia es $(1-L_t)/L_t$ (2 si se trabaja un tercio del tiempo); es la mayor de las 3 elasticidades; nada que ver con la neutralidad al riesgo (mantiene constante λ). Ciclo vital y jubilación (valor de opción de Stock y Wise, 1990; Gruber y Wise, 1999); RBC (Kydland y Prescott, 1982): efecto riqueza frente a sustitución intertemporal según la persistencia del choque (el permanente se transmite por la inversión; nunca «no hay ciclo»); trabajo indivisible (Hansen, 1985; Rogerson, 1988); la demanda intertemporal son los costes de ajuste (3.A.26, una frase).
- **d) Evidencia (II.4)**: MaCurdy (1981) 0,15, Altonji (1986); Chetty et al. (2011) 0,54 horas, 0,28 participación, 0,82 agregada frente a 2,8 en los RBC; mayor en mujeres y cerca de la jubilación (Keane, 2011; Imai y Keane, 2004; French, 2005); experimentos naturales (Fehr y Goette, 2007; Farber, 2015, frente a Camerer et al., 1997).
- **e) Valoración (II.5)**: mecanismo de propagación y la elasticidad clave de la macro moderna; exige elasticidades mayores que las micro (crítica a los RBC); no explica el paro involuntario (3.A.26-3.A.28); puente al capital humano: «el salario futuro no cae del cielo».
- **Anexo C (horizonte infinito)**: $\max\sum_t\beta^tu(C_t,O_t)$ s.a. $C_t+w_tO_t+b_{t+1}\le w_t+(1+r)b_t+\overline W_t$, **no-Ponzi** $\lim_{T\to\infty}b_T/(1+r)^T\ge0$ (con igualdad en el óptimo; nunca «$\lim B_t=0$»), $b_0$ dado; $b_t$ activos netos (§ 7; en el cuerpo, $b$ sin subíndice es el peso del ocio); da las mismas 3 condiciones y el vínculo de λ con la Frisch.

**Gráfico de referencia:** no imprescindible; `oposicion/temario/fuentes/3A25/graficos/lr-oferta.tex` (apoyo): oferta de hoy $L_1$ frente a $w_1$ para 2 valores de $w_2$, más horas cuanto mayor es el salario de hoy frente al de mañana. En la pizarra, la condición `eq:lr-condicion` y el cuadro de flechas de `tab:lr-implicaciones`.

## Cómo se adapta en cada tema

| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.25 | Oferta de trabajo intertemporal | desarrollo (hecho, 31/10/2026) | Todo lo anterior | — |
| 3.A.6 | La NMC | resumen | Como microfundamento del mercado de trabajo en el equilibrio continuo: la condición `eq:lr-condicion` en una línea, la sustitución intertemporal y la crítica de las elasticidades; $\varepsilon_{L,w}$ y φ (no $\varepsilon_{(L^S,w)}$), remitiendo al 3.A.25 | La derivación y las «2 razones para aumentar la oferta de trabajo» desarrolladas |
| 3.A.42 | Ciclos reales | mención | Mecanismo de propagación (efecto riqueza frente a sustitución según la persistencia); la Frisch 1/φ que piden los modelos (≈ 2,8) frente a la micro (≈ 0,5-0,8); remitir | El modelo |
| 3.A.29 | Modelización dinámica | mención | El horizonte infinito con $b_t$ y no-Ponzi como aplicación de la optimización dinámica | El modelo de 2 periodos |

## Divergencias encontradas en el temario actual

- 3.A.25 original: horizonte infinito sin la presentación de referencia, $(1+r)/(1+\rho)$ sin β, $B_t$, $M_t$, «$\lim B_t=0$», aumento permanente «en la misma proporción», RBC «permanentes: no hay ciclo», nota 28 (Frisch y neutralidad al riesgo). **Resuelto** en la revisión (31/10/2026).
- 3.A.6 y 3.A.42 (sin revisar): desarrollan Lucas-Rapping («2 razones para aumentar la oferta de trabajo…») con $\varepsilon_{(L^S,w)}$: deben resumir (3.A.6) y mencionar (3.A.42) con $\varepsilon_{L,w}$, φ y remisión al 3.A.25 (`mapa.yaml`, contradicciones del 3.A.25).

Autor: Víctor Gutiérrez Marcos
