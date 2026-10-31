# Modelo de Ramsey-Cass-Koopmans

- **Área:** macro cerrada · **Tema de referencia:** 3.A.43 (crecimiento I: Solow, MRW y Ramsey-Cass-Koopmans) — lo tiene en el título. **Revisado el 31/10/2026**: apartado III (11′; III.1 Idea y solución descentralizada, III.2 Análisis normativo e implicaciones, III.3 Extensiones, evidencia empírica y valoración) y anexos C, c) (velocidad), D (control óptimo, copia de la pieza común) y E (el RCK paso a paso: hamiltoniano en valor presente, planificador y demostraciones del 1TFEB y del 2TFEB).
- **Temas que lo usan:** 3.A.43 (desarrollo; hecho, 31/10/2026), 3.A.29 (resumen: horizonte infinito), 3.A.42 (resumen: base del RBC), 3.A.38 (mención: el gasto y los impuestos en el RCK se cuentan en el 3.A.43; Chamley-Judd), 3.A.39 (mención: equivalencia ricardiana con horizonte infinito), 3.A.6 (mención), 3.A.35 (mención: Sidrauski sobre el RCK), 3.A.34 (mención; hecho, 31/10/2026: anexo A, el crecimiento óptimo como aplicación del control óptimo, `\vertema{3.A.43}`; la nota de Inada), 3.B.31 (resumen; hecho, 31/10/2026: base del DICE en tiempo discreto, con $\beta\equiv1/(1+\rho)$, $\theta$, $\alpha$, $\delta$, $A_t$, $c_t\equiv C_t/L_t$; la fórmula de Ramsey del descuento $r_s=\rho+\theta\gamma_c$ como la ecuación de Euler leída al revés, $\gamma_c\simeq(r-\rho)/\theta$, en caja gris; ficha `dice`)
- **Manuales de referencia:** Ramsey (1928), Cass (1965), Koopmans (1965); Romer (2019), cap. 2 (figs. 2.6, 2.8 y 2.9); Barro y Sala i Martín (2004), caps. 2 y 3 (figs. 3.1 y 3.2); Acemoglu (2009), cap. 8 (figs. 8.1 y 8.2); Blanchard y Fischer (1989), cap. 2; Obstfeld y Rogoff (1996); Michel (1982).
- **Decisión D010 (13/10/2026):** ¿Qué letras llevan la tasa de progreso técnico, el crecimiento del PIB y el gasto público en ratio? g = progreso técnico (regla de oro n+g+δ); γ_Y = crecimiento del PIB (también en las ecuaciones de deuda: r − γ_Y, y «r − g» solo como nombre del debate de Blanchard); g = G/Y en sector público
- **Decisión D026 (13/10/2026):** ¿Cómo se distinguen el salario real y el nominal en macro? w real y W nominal en todo el temario (como en WS-PS)

## Presentación de referencia (3.A.43, apartado III)

**Pregunta:** ¿qué pasa en el modelo neoclásico de crecimiento si el ahorro es una decisión óptima? ¿Ahorra el mercado lo que conviene?

**a) Idea (III.1).** Ramsey (1928), recuperado por Cass (1965) y **Koopmans (1965)** (no 1963): el modelo de Solow con hogares que optimizan en horizonte infinito. 2 ventajas: ahorro endógeno y análisis normativo. 3 formas de contarlo (descentralizada, hogar-productor, planificador); se empieza por la descentralizada.

**b) Modelo (III.1).**
- *Lo que se mantiene*: la producción de Solow (`tab:inada`, $\gamma_A=g$, $\gamma_L=n$, δ); empresas competitivas sin costes de ajuste (`\vertema{3.A.34}`): $r_t=f'(k_t)-\delta$, $w_t=A_t[f(k_t)-k_tf'(k_t)]$ (w real, D026).
- *Lo que cambia*: hogar representativo (Gorman con pendiente común, `\vertema{3.A.9}`) de $L_t=e^{nt}$ miembros, trabajo inelástico; maximiza la utilidad del consumo **por persona** con la CRRA **con el −1** (como `eq:crra` del 3.A.8 y el 3.A.33; DK6):
$$U_0=\int_0^{\infty}e^{-(\rho-n)t}\,u\!\left(\frac{C_t}{L_t}\right)dt,\qquad u(x)=\frac{x^{1-\theta}-1}{1-\theta},\quad\theta>0\qquad(\texttt{eq:hogar-rck})$$
  θ > 0 (no θ ∈ [0, 1]), ESI = 1/θ sin símbolo, la concavidad crece con θ, ln x con θ → 1 (nota con l'Hôpital; el −1 no cambia el óptimo y el 3.B.31 lo omite); ρ > 0 **tasa** de preferencia temporal (descuento exponencial, Samuelson, 1937; Strotz y el hiperbólico en nota, `\vertema{3.A.1}`); descuento efectivo ρ − n.
- *Restricción por persona*, con **$b_t$ activos netos por persona**: $\dot b_t=w_t+(r_t-n)\,b_t-C_t/L_t$, $b_0$ dado; no-Ponzi $\lim_{t\to\infty}b_te^{-\int_0^t(r_\tau-n)d\tau}\ge0$.
- *Utilidad acotada*: **ρ − n > (1 − θ)g** (con g = 0, ρ > n); de ella sale $k^*<k_{\mathrm{oro}}$.
- *Hogar*: **𝓗 en valor corriente en el cuerpo** (DK7): $\mathcal H_t=u(C_t/L_t)+\lambda_t[w_t+(r_t-n)b_t-C_t/L_t]$, con **λ_t valor (en utilidad de t) de un euro más de activos** (no «precio sombra del capital»); CPO: $(C_t/L_t)^{-\theta}=\lambda_t$; $\dot\lambda_t/\lambda_t=\rho-r_t$; **transversalidad $\lim_{t\to\infty}e^{-(\rho-n)t}\lambda_tb_t=0$** (coherente con la del anexo común en valor corriente, $\lim e^{-\rho t}\lambda_ty_t=0$, con descuento ρ − n y estado $b_t$; necesaria en condiciones generales, Michel, 1982).
- *Ecuación de Euler en sus 2 formas* (función clave; K17, para que se cumpla la remisión del 3.B.31):
$$\boxed{\gamma_{C/L}=\frac{r_t-\rho}{\theta}\qquad\Longleftrightarrow\qquad\frac{\dot c_t}{c_t}=\frac{f'(k_t)-\delta-\rho-\theta g}{\theta}}\qquad(\texttt{eq:euler-rck})$$
  leída al revés, $r=\rho+\theta\gamma_{C/L}$, es la fórmula de Ramsey del descuento (`\vertema{3.B.31}`); en discreto, $u'(C_t)=\beta(1+r)u'(C_{t+1})$ (`\vertema{3.A.33}`); 3 efectos de r en nota (Obstfeld y Rogoff).
- *Equilibrio*: los préstamos entre hogares se cancelan y los activos netos son el capital, $b_t=K_t/L_t=A_tk_t$; ecuación de acumulación (función clave):
$$\boxed{\dot k_t=f(k_t)-c_t-(n+g+\delta)\,k_t}\qquad(\texttt{eq:acumulacion-rck})$$
- *Diagrama de fases*: $\dot c=0$ vertical en $k^*$; $\dot k=0$ en U invertida con máximo en $k_{\mathrm{oro}}$ y corte en $\bar k$; E = (k*, c*) a la izquierda del máximo; punto de silla (k predeterminada, c salta); senda B (el capital se agota, incompatible con Euler) y C (acaba en $(\bar k,0)$, viola la transversalidad). Cobb-Douglas: $k^*=[\alpha/(\rho+\delta+\theta g)]^{1/(1-\alpha)}$, $s^*=\alpha(n+g+\delta)/(\rho+\delta+\theta g)<\alpha$; con α = 1/3, ρ = 0,02, δ = 0,05, n = 0,01, g = 0,02 y θ = 2, $s^*\simeq24~\%$. Senda equilibrada con $r^*=\rho+\theta g$.
- *Estática comparativa*: caída de ρ ($\dot c=0$ a la derecha; c cae de un salto a la nueva senda de silla; efecto nivel).

**Análisis normativo (III.2).** Planificador en unidades eficientes, $\max\int_0^{\infty}e^{-[\rho-n-(1-\theta)g]t}c_t^{1-\theta}/(1-\theta)\,dt$ s.a. `eq:acumulacion-rck`, con **$\lambda^{\mathrm P}_t$** coestado (valor presente) y $\mathcal H^{\mathrm P}$ en el anexo E; **1TFEB** (supuestos del `\vertema{3.A.22}`; r hace de precio sombra del capital) y **2TFEB** sin transferencias; «¿y en Solow?»: no falla el 1TFEB, no se puede plantear. **Regla de oro modificada** (función clave):
$$\boxed{f'(k^*)=\rho+\delta+\theta g}\qquad(\texttt{eq:regla-oro-modificada})$$
  frente a la de Solow en `tab:reglas-oro` (con ρ − n > (1 − θ)g, $k^*<k_{\mathrm{oro}}$): nunca hay ineficiencia dinámica (la pegatina «la avaricia rompe el saco» se tacha); con OLG (Diamond, 1965, `\vertema{3.A.29}`) o externalidades (`\vertema{3.A.44}`), sí puede fallar. Velocidad de convergencia (anexo C, c, con ζ ≡ ρ − n − (1 − θ)g local): 10 %, 8 % y 7 % con θ = 1, 2, 4 (ilustrativas, A43-09), frente al 5 % de Solow con n + g + δ = 0,08; más lenta cuanto mayor es θ (`rck-theta`); la tasa de ahorro en la transición baja si θ < 1/s*. Crecimiento exógeno como en Solow.

**c) Extensiones (III.3).** Sector público (`\vertema{3.A.38}`): gasto $G_t$ que no da utilidad ni produce; **permanente**: $\dot k=0$ baja en la cuantía del gasto, el consumo cae lo mismo, k y r no cambian (A43-08); **temporal**: el consumo cae menos, k baja y r sube mientras dura; deuda frente a impuestos de suma fija: equivalencia ricardiana (Barro, 1974, `\vertema{3.A.39}`); impuestos sobre el consumo y el trabajo (inelástico) como de suma fija; **$\tau_K$** sobre las rentas del capital: $\dot c/c=[(1-\tau_K)(f'(k)-\delta)-\rho-\theta g]/\theta$, menos capital, el consumo salta hacia arriba; riqueza ≡ rentas del capital de tipo equivalente; Chamley (1986) y Judd (1985). DICE (`\vertema{3.B.31}`, ficha `dice`); RBC (Kydland y Prescott, 1982; King, Plosser y Rebelo, 1988; `\vertema{3.A.42}`).

**d) Evidencia.** Velocidad 7-10 % frente al 1,4-2 % observado (capital amplio); ahorro creciente en el despegue de Asia (θ alto o hábitos, Carroll, Overland y Weil, 2000); eficiencia dinámica (Abel *et al.*, 1989); r* = ρ + θg y la caída del tipo natural (Holston, Laubach y Williams, 2017).

**e) Valoración.** Microfundamenta el ahorro y permite el análisis de bienestar; base de la política fiscal, del RBC y de los DSGE; limitaciones: crecimiento exógeno, hogar representativo de vida infinita (OLG, `\vertema{3.A.29}`), mercados completos.

**Gráficos de referencia** (`oposicion/temario/fuentes/3A43/graficos/`): `rck-fases.tex` (diagrama de fases por capas: ejes, $\dot k=0$ con $k_{\mathrm{oro}}$, flechas, $\dot c=0$ en $k^*$, E, senda de silla, sendas B y C; Acemoglu, 2009, fig. 8.1, y Romer), `rck-rho.tex` (caída de ρ; Romer, fig. 2.6), `rck-gasto.tex` (gasto permanente y temporal, con panel temporal; Romer, figs. 2.8 y 2.9), `rck-impuesto.tex` (τ_K), `rck-theta.tex` (senda de silla según θ, con g = 0). Dibujados con $f(k)=k/(1+k)$, cualitativos (A43-12).

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.43 | Crecimiento con ahorro endógeno | desarrollo (hecho, 31/10/2026) | Descentralizado con 𝓗 en valor corriente, Euler en 2 formas, diagrama de fases, caída de ρ; planificador y 1TFEB/2TFEB; regla de oro modificada; velocidad; gasto, impuestos, DICE y RBC; anexos C, D y E | — |
| 3.A.29 | Modelos de horizonte infinito | resumen | Ejemplo de horizonte infinito frente a OLG; la misma utilidad (con el −1), la misma Euler en sus 2 formas y la transversalidad $\lim e^{-(\rho-n)t}\lambda_tb_t=0$; Diamond (1965) y la ineficiencia dinámica son suyos | Diagrama de fases `\vertema{3.A.43}` |
| 3.A.42 | Ciclos reales | resumen | Punto de partida del RBC (ocio y perturbaciones), con $w_t$ real y la misma Euler | Idem |
| 3.A.38 | Política fiscal y crecimiento | mención | Gasto permanente y temporal, τ_K y Chamley-Judd con `\vertema{3.A.43}`; Barro (1990) es suyo | El diagrama |
| 3.A.39 | Déficit público | mención | Equivalencia ricardiana con horizonte infinito | — |
| 3.A.6 | NMC y EGDE | mención | Base del RBC | — |
| 3.A.35 | Demanda de dinero | mención | Sidrauski construye sobre el RCK | — |
| 3.A.34 | Inversión | mención (hecho, 31/10/2026) | Ejemplo de control óptimo en el anexo A (pieza común) | El modelo |
| 3.B.31 | Modelos integrados de evaluación (DICE) | resumen (hecho, 31/10/2026) | El RCK en tiempo discreto, con periodos de 5 años, planificador mundial, daños $\Omega(T_t)$ y reducción $\mu_t$ (ficha `dice`); Euler → $r_s=\rho+\theta\gamma_c$ (`eq:ramsey-descuento`); los supuestos del RCK en una línea con `\vertema{3.A.43}` | El diagrama de fases |

## Divergencias encontradas en el temario actual
- 3.A.43: regla de oro modificada sin θg; A_t dentro de las ecuaciones per cápita (sin estado estacionario con g > 0); W_t; g y m; θ ∈ [0, 1]; ESI ≡ σ; «ρ factor de descuento»; ρ > n; λ_t como precio sombra del capital del hogar; «b = k porque la suma de activos es 0»; «productividad marginal del trabajo»; gasto permanente que acumula capital; «trabajo perfectamente elástico»; análisis normativo copiado con ecuaciones inexistentes. **Resuelto** (31/10/2026).
- Esta ficha escribía la utilidad sobre $C_t$ (el agregado, § 0 de `notacion.md`) y sin el −1, y la transversalidad $\lim\lambda_tk_te^{-\rho t}=0$: canon desde el 3.A.43, utilidad del consumo por persona con el −1 y $\lim e^{-(\rho-n)t}\lambda_tb_t=0$ (en el planificador, $\lim\lambda^{\mathrm P}_tk_t=0$, equivalente).
- **Tiempo discreto en el 3.B.31** (DICE): $W=\sum_t\beta^tL_t\,c_t^{1-\theta}/(1-\theta)$ con $\beta\equiv1/(1+\rho)$, $c_t\equiv C_t/L_t$ **por persona** (local: allí no hay unidades eficientes) y sin el −1 (avisado por el 3.A.43 en nota). Su remisión «$\gamma_c\simeq(r-\rho)/\theta$ \vertema{3.A.43}» se cumple con la forma por persona de la Euler. Sin cambios.
- Anexo de optimización dinámica: el 3.A.43 copia la parte continua del 3.A.34 (ficha `optimizacion-dinamica`), con el aviso de letras y 2 autorremisiones adaptadas (A43-07).
- 3.A.29 (sin revisar): su resumen del RCK debe usar la Euler en 2 formas, la CRRA con el −1 y la transversalidad de arriba, y remitir el diagrama al 3.A.43.

Autor: Víctor Gutiérrez Marcos
