# Modelo de Solow-Swan (1956)

- **Área:** macro cerrada · **Tema de referencia:** 3.A.43 (crecimiento I) — lo tiene en el título. **Revisado el 31/10/2026**: apartado I «El modelo de Solow: acumulación de capital y progreso técnico exógeno» (10′; I.1 Idea: de Harrod y Domar a Solow, I.2 El modelo, I.3 Evidencia y valoración, con a)-d) repartidos entre los 3 subapartados, A43-01) y anexos B (Uzawa y la ecuación con trabajo eficiente) y C (velocidad de convergencia).
- **Temas que lo usan:** 3.A.43 (desarrollo; hecho, 31/10/2026), 3.A.45 (uso empírico; hecho, 1/11/2026: residuo, convergencia y hechos de Kaldor), 3.A.44 (mención: el punto de partida, γ_k = s f(k)/k − (n + δ) sin progreso técnico, sin los párrafos de supuestos, remitidos; hecho, 1/11/2026), 3.A.38 (resumen: su Word usa la ecuación de Solow con impuestos), 3.A.42 (mención: la ley de movimiento del capital del RBC), 3.A.6 (mención; hecho, 4/11/2026: III.1, el residuo de Solow como medida de la perturbación tecnológica y el ciclo explicado con la misma teoría que el crecimiento, `\vertema{3.A.45}` `\vertema{3.A.43}`; gráfico `residuo-solow`), 3.B.28 (mención; hecho, 3/11/2026: II.1, convergencia condicional y residuo con las palabras del 3.A.45; trampas con el gráfico del 3.A.43), 3.B.42 (mención: su Word cita Solow y MRW entre las causas del subdesarrollo), 4.A.2 (previsto)
- **Manuales de referencia:** Solow (1956), Swan (1956); Romer (2019), cap. 1; Barro y Sala i Martín (2004), cap. 1; Sala i Martín (2000), cap. 1; Acemoglu (2009), cap. 2; Campante, Sturzenegger y Velasco (2021), cap. 3; Phelps (1961).
- **Decisión D010 (13/10/2026):** ¿Qué letras llevan la tasa de progreso técnico, el crecimiento del PIB y el gasto público en ratio? g = progreso técnico (regla de oro n+g+δ); γ_Y = crecimiento del PIB (también en las ecuaciones de deuda: r − γ_Y, y «r − g» solo como nombre del debate de Blanchard); g = G/Y en sector público
- **Decisión D090 (13/10/2026):** ¿Cómo se reparte Mankiw-Romer-Weil entre 3.A.43 y 3.A.45? Modelo teórico en 3.A.43 (con Harrod-Domar como antecedente breve) y estimación y evidencia en 3.A.45

## Presentación de referencia (3.A.43, apartado I)

**Pregunta:** ¿puede la acumulación de capital explicar el crecimiento sostenido y las diferencias de renta entre países?

**a) Idea (I.1).** Harrod y Domar como antecedente en 2 ideas: tasa garantizada s/v, inestable («filo de la navaja», en la expresión de **Solow, 1956, p. 65**, no de Robinson), y tasa natural n; crecer con pleno empleo exige s/v = n, una casualidad. Solow y Swan aceptan todo salvo las proporciones fijas: con una función neoclásica, v se ajusta y la igualdad se cumple sola, **s f(k*)/k* = n + g + δ ⇔ s/v* = n + g + δ**. Harrod-Domar es el caso límite de Solow con σ = 0, no al revés (desarrollo en el anexo A, ficha `harrod-domar`).

**b) Modelo (I.2).**
- *Supuestos*: economía cerrada sin Estado, un bien, tiempo continuo; $Y_t=F(K_t,A_tL_t)$ (`eq:produccion`) neoclásica (productos marginales positivos y decrecientes, rendimientos constantes con principio de réplica, `\vertema{3.A.11}`, e Inada, `tab:inada` con 6 condiciones, A43-05); la tecnología es no rival y, en el modelo, no excluible (`\vertema{3.A.23}`); $\gamma_A=g$, $\gamma_L=n$; agente representativo que ahorra $s\in(0,1)$; competencia perfecta, **$r_t+\delta=F_K$ y $w_t=F_L$** (w real, sin letra para el alquiler); δ > 0. Cajas: teorema de **Uzawa (1961)**, condición necesaria (no Phelps ni «necesaria y suficiente»), con la demostración de Jones y Scrimgeour (2008) en el anexo B, y la **controversia del capital** (Robinson, 1953; Sraffa, 1960; Samuelson, 1966) con `\vertema{3.A.4}`.
- *Notación* (caja del tema): $k_t\equiv K_t/(A_tL_t)$, $y_t$, $c_t$ **sin marca**, por unidad de trabajo eficiente; lo per cápita como cociente ($Y_t/L_t=A_ty_t$); punto = derivada; $\gamma_X\equiv\dot X/X$.
- *Ecuación fundamental* (función clave):
$$\boxed{\dot k_t=s\,f(k_t)-(n+g+\delta)\,k_t}\qquad(\texttt{eq:solow})$$
  inversión efectiva frente a inversión de reposición; precios $r_t=f'(k_t)-\delta$, $w_t=A_t[f(k_t)-k_tf'(k_t)]$. Lectura «empecemos con $g=0$» (la recta $(n+\delta)k$ gira a $(n+g+\delta)k$): adaptación de la nota de Víctor (DK3), sin escribir el modelo 2 veces.
- *Estado estacionario*: $s\,f(k^*)=(n+g+\delta)k^*$, único y estable por Inada; con Cobb-Douglas $k^*=[s/(n+g+\delta)]^{1/(1-\alpha)}$. Senda equilibrada: $\gamma_{Y/L}=\gamma_{K/L}=\gamma_{C/L}=g$; $\gamma_Y=\gamma_K=\gamma_C=n+g$; $r^*$ constante, $w$ crece a g; reproduce 5 de los 6 hechos de Kaldor (ficha `hechos-kaldor`).
- *Regla de oro* (**Phelps, 1961**; el libro es de 1966), función clave:
$$\boxed{f'(k_{\mathrm{oro}})=n+g+\delta}\qquad(\texttt{eq:regla-oro}),\qquad r_{\mathrm{oro}}=n+g,\qquad s_{\mathrm{oro}}=\alpha\ \text{(Cobb-Douglas)}$$
  ineficiencia dinámica si $s>s_{\mathrm{oro}}$ (propiedad del estado estacionario, pegatina «la avaricia rompe el saco»); eficiencia dinámica si $s<s_{\mathrm{oro}}$ (conflicto entre generaciones que el modelo no puede resolver sin preferencias); la regla de oro no es un óptimo.
- *Tasas de crecimiento* (`eq:tasas-solow`): $\gamma_k=s\,f(k)/k-(n+g+\delta)$.
- *Estática comparativa* (`tab:estatica-solow`, corregida): filas $s$, $n$, δ, $A_0$ (nivel: no cambia $k^*$, $y^*$, $c^*$ ni $f'(k^*)$, sube el nivel de Y/L) y $g$ (la única que cambia $\gamma_{Y/L}$ a largo plazo, en verde); columnas $k^*$, $y^*$, $c^*$ (± según la regla de oro), $f'(k^*)$, nivel de Y/L, $\gamma_{Y/L}$ y $\gamma_Y$. Sin fila de $s_H$ (A43-02: va en el II.1).
- *Velocidad de convergencia* (`eq:velocidad`): $d\ln k_t/dt\simeq-\lambda(\ln k_t-\ln k^*)$, **λ = (1 − α)(n + g + δ)** con α ≡ k*f′(k*)/f(k*); con α = 1/3 y n + g + δ = 0,06, λ = 4 % y semivida ln 2/λ ≈ 17 años (derivación en el anexo C).
- *Implicaciones*: crecimiento exógeno (efecto nivel, no crecimiento); convergencia absoluta dentro de grupos homogéneos, condicional en general, en tasas; paradoja de Lucas (1990).

**c) Evidencia (I.3).** Kaldor (5 de 6; España con K/Y creciente); residuo de Solow (1957, pp. 316 y 320): **1909-1949, 12,5 % / 87,5 % del aumento de la producción por hora**; con progreso técnico aumentador del trabajo la PTF crece a $(1-\alpha)g$, no a $g\equiv\gamma_A$ (A43-21; caja «Dos formas de escribir la tecnología» del 3.A.45), con `\vertema{3.A.45}`; convergencia 1960-2023 (PWT 11.0): solo dentro de la OCDE, algo desde 2000 (Kremer, Willis y You, 2022); condicionada, 1,4-2 % (MRW, tabla V); MRW con α implícita 0,6.

**d) Valoración (I.3).** Aportaciones (estable, corrige el filo de la navaja, Kaldor, contabilidad); 3 limitaciones que abren lo siguiente: cuantitativa → MRW (II), normativa → RCK (III), teórica (g exógeno) → `\vertema{3.A.44}`.

**Gráficos de referencia** (`oposicion/temario/fuentes/3A43/graficos/`): `solow.tex` (plano (k, ·): f(k), s f(k), recta (n + δ)k que gira a (n + g + δ)k, k*, c* y la capa dorada de la regla de oro; por capas en el cante), `solow-tasas.tex` (s f(k)/k frente a n + g + δ: subida de s y 2 economías que convergen), `consumo-ahorro.tex` (c* frente a s con máximo en s_oro), `ineficiencia-dinamica.tex` (sendas de k y c al bajar o subir s hacia s_oro), `solow-ahorro.tex` (subida de s con sendas de k, c, γ_{Y/L} y ln(Y/L)), `funcion-produccion.tex` (superficie 3D), `solow-no-existencia.tex` (nota de Inada), `convergencia.tex` (datos, PWT 11.0).

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.43 | Acumulación de capital y progreso técnico exógeno | desarrollo (hecho, 31/10/2026) | Modelo con n + g + δ desde el principio, regla de oro con g, estática comparativa, λ, convergencia, evidencia, 3 limitaciones; anexos B y C | — |
| 3.A.45 | Evidencia empírica y convergencia | uso empírico (hecho, 1/11/2026) | Residuo (1909-1949, 87,5 %), convergencia β y σ, hechos de Kaldor (misma lista, ficha `hechos-kaldor`), λ ≈ 2 % frente al 4 % teórico | Derivación `\vertema{3.A.43}` |
| 3.A.44 | Crecimiento endógeno | mención (hecho, 1/11/2026; `tab:supuestos-neoclasicos` y `tab:ak-solow`) | Punto de partida: γ_k = s f(k)/k − (n + δ) sin progreso técnico, rendimientos decrecientes e Inada; AK y Sobelow sobre el mismo gráfico de tasas | Los párrafos de supuestos (tecnología bien público, tamaño indeterminado, costes de ajuste): remitir |
| 3.A.38 | Política fiscal y crecimiento | resumen | La ecuación fundamental con impuestos; el RCK con gasto e impuestos remitido al 3.A.43 (III.3 c) | La derivación |
| 3.A.42 | Ciclos reales | mención | La ley de movimiento del capital del RBC | — |
| 3.A.6 | NMC | mención (hecho, 4/11/2026) | El residuo de Solow como perturbación tecnológica (Prescott, 1986), corregido por utilización (Fernald; Basu, Fernald y Kimball, 2006); ley de movimiento del capital en el ciclo real | El modelo de Solow |
| 3.B.28 | Desarrollo | mención (hecho, 3/11/2026) | II.1: Solow (1956) y sus 2 resultados (convergencia condicional de la renta por habitante; el residuo, 87,5 % de la producción por hora en EE. UU. 1909-1949, Solow, 1957, y Abramovitz, con las palabras del 3.A.45); la $n$ alta baja la renta de estado estacionario (I.2); trampas de pobreza (ficha `trampas-pobreza`) | El modelo |
| 3.B.42 | Cooperación al desarrollo de la UE | mención | Solow y MRW entre las causas del subdesarrollo | — |
| 4.A.2 | Crecimiento de la economía española | previsto | Marco para la contabilidad del crecimiento | — |

## Divergencias encontradas en el temario actual
- 3.A.43: regla de oro sin g y ley de movimiento con δ + n; g y m; «(1 − s)» como tasa de inversión; punto encima como tasa; Phelps 1966; filo de la navaja atribuido a Robinson; Uzawa atribuido a Phelps y «necesaria y suficiente»; tabla de estática comparativa con «Α» griega y una fila de A errónea; «Solow es un caso particular de Harrod»; residuo 1909-1948 con 12/88 %; referencias gemelas «3.A.10 y 3.A.11» / «3.A.11 y 3.A.12»; Harrod-Domar como apartado 1 y MRW en una línea. **Resuelto** (31/10/2026).
- Párrafos duplicados literalmente entre 3.A.43 y 3.A.44 (tecnología como bien público, tamaño indeterminado de la empresa, costes de ajuste): se quedan en el 3.A.43; el 3.A.44 remite. **Resuelto** (1/11/2026).
- 3.A.38 (sin revisar): la ecuación de Solow con impuestos (l. 1523 de su Word) con ahorro exógeno; el gasto y los impuestos con hogares que optimizan son los del RCK del 3.A.43 (III.3 c).
- Esta ficha decía «3.B.42 (subdesarrollo)»: el tema del desarrollo es el **3.B.28** (el 3.B.42 es la cooperación al desarrollo de la UE y queda en mención).

Autor: Víctor Gutiérrez Marcos
