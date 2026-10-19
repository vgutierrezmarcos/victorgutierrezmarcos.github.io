# Notación del área mercados, información y juegos (3.A.13-3.A.20)

Paso 2 del canon (13 oct. 2026). Fuentes: `_inventario/3A13…3A20.json` (3.A.15 y 3.A.20 sin fuente), `resumen-por-area.md` (comprobado), 3.A.8 revisado. Manuales base: Mas-Colell, Whinston y Green (MWG); Tirole, *The Theory of Industrial Organization*; Gibbons, *Un primer curso de teoría de juegos*; Varian; Viscusi, Harrington y Vernon (regulación). Decisiones aprobadas por Víctor el 13/10/2026 (`decisiones.json`): la columna «Canon» es la notación definitiva; `notacion.md` manda si difiere por un choque entre áreas.

## Mercados (competencia perfecta, monopolio, competencia monopolística, oligopolio)

| Símbolo | Significado | Alternativas en el temario (temas) | Canon | Motivo |
|---|---|---|---|---|
| $p$ | Precio del bien | $P$, $P_i$ (3.A.17, 4.B.15), $P(Q)$ (3.A.19 Cournot) y $p$ (Bertrand) | **$p$** minúscula siempre | MWG, Tirole; $P$ es el nivel de precios en macro; quita la incoherencia interna de 3.A.19 |
| $p(q)$, $p(Q)$ | Demanda inversa | $P(x)$ (3.A.16), $P(q)$ (3.A.17), $P(Q)=a-bQ$ (3.A.19) | **$p(q)$**; lineal **$p(Q)=a-bQ$**. En competencia perfecta, donde conviven las dos inversas, **$p^D(x)$** y **$p^S(q)$** (3.A.16 revisado, 17/10/2026; `notacion.md` § 4) | Igual |
| $x$, $x(p)$ | Cantidad demandada, demanda de mercado | $q^m(p)$ (3.A.17), $x_i$ variedad (3.A.18) | **$x(p)$** en competencia perfecta (3.A.16) y en el monopolio, donde el monopolista vende **$q=x(p)$** y trabaja con **$p(q)$** (3.A.17 revisado, 17/10/2026) | MWG separa demanda $x$ y oferta $q$ |
| $q_i$, $Q=\sum_iq_i$ | Producción de la empresa $i$ y de la industria | — | Igual | Unánime |
| $B_i$ | Beneficio | $B$ (3.A.12, 3.A.17, 3.A.19, 4.B.10), $B_i$ (3.A.16, 3.A.19, 3.A.21), $\pi$ (3.A.18, 3.A.19, 4.B.13), $\Pi$ (3.A.19), $\phi(z;\pi)$ (3.A.8) | **$B$** | La mayoría de temas y los manuales en castellano; $\pi$ es la inflación en macro y choca en los temas que mezclan empresa e inflación (NEK: 3.A.7, 3.A.36). Choque menor: consumidor $B$ del 2×2×2×2 (se distingue por el subíndice: $B_X$ beneficio, $U_B$ utilidad) |
| $\sum_t\beta^tB_{it}$ | Beneficio intertemporal (juegos repetidos) | $\Pi$ (3.A.19) | **$\sum_t\beta^tB_{it}$**, sin símbolo propio | Coherente con $\beta$ = factor de descuento en macro |
| $C(q)$, $C(w,q)$ | Coste total | $C_i(\bar q_i,w)$ (3.A.16) | **$C(w,q)$**, o $C(q)$ si $w$ no cambia | Ver `consumidor-produccion.md` |
| $c$, $CF$ | Coste marginal constante y coste fijo | $F$ (3.A.18, choca con la función de producción) | **$c$** y **$CF$**; en Dixit-Stiglitz $C(q)=CF+cq$ | $F(\cdot)$ es la función de producción |
| $IMg$, $CMg$, $CMe$ | Ingreso marginal, coste marginal, coste medio | — | Igual | Unánime |
| $\varepsilon$ | Elasticidad-precio de la demanda | $\varepsilon_i$, $|\varepsilon_{q_i,P_i}|$ | **$|\varepsilon_{q,p}|$** en las reglas de margen, con dos subíndices ($\varepsilon_{q_k,p_k}$, $\varepsilon_{q_j,p_i}$, $\varepsilon_{L,w_L}$; 3.A.17 revisado); $\varepsilon_D$ y $\varepsilon_S$ en competencia perfecta (3.A.16) | Signo explícito |
| $\mathcal L=\frac{p-CMg}{p}$ | Índice de Lerner | $L$ | **$\mathcal L$**; la lagrangiana no se escribe $\mathcal L$ en los temas que lo usan (problema penalizado o $\Lambda$; 3.A.17 revisado) | $L$ es trabajo y pérdida |
| $\mu=\frac{\sigma}{\sigma-1}$ | Margen (mark-up) | — | **$\mu$** | 3.A.18 y macro (NEK) |
| $\sigma$ | Elasticidad de sustitución entre variedades | — | **$\sigma>1$** | Dixit-Stiglitz; misma letra que la CES (3.A.11) |
| $EC$, $EP$, $ET$ | Excedentes del consumidor, del productor y total | $W$ bienestar (3.A.17 Ramsey-Boiteux) | **$ET=EC+EP$** (en regulación $ET=EC+B$) | $W(\cdot)$ es la FBS y $\overline W$ la renta |
| $t$ | Impuesto unitario (3.A.16) / coste de transporte (3.A.18) | — | Ambos, local | No conviven en el mismo tema |
| $d$, $D$ | Demanda percibida y efectiva (Chamberlin) | — | Igual | 3.A.18 |
| $s$, $X$ | Tasa de rentabilidad permitida (Averch-Johnson) y factor de eficiencia del price cap | $r$ coste del capital (4.B.15) | **$s$**, **$X$**; coste del capital **$w_K$** | — |
| $z(p)$ | Exceso de demanda | $D(p)-S(p)$ (3.A.16) | **$z(p)=x(p)-q(p)$** | Igual que en EG (3.A.21) |

**Revisión del 3.A.16 (17/10/2026).** Competencia perfecta con consumidores $i=1,\dots,I$ y empresas $j=1,\dots,J$ (antes $m$ e $i$), $U_i=n_i+\phi_i(x_i)$, $C_j(\vec w,q_j)$, $p^D(x)$ y $p^S(q)$, $q^{\mathrm{CP}}(p)$ y $q^{\mathrm{LP}}(p)$, $J^*$, $\overline c$ y $\overline q$, $p_c=p_v+t$, $\varepsilon_D<0$ y $\varepsilon_S$, $\dot p=f(z(p))$, $\dot q=g(p^D-p^S)$ y la telaraña con $p^e_t$. Detalle y motivos en `notacion.md` § 4 (manda) y en `cambios.md`.

## Juegos (3.A.14)

| Símbolo | Significado | Alternativas (temas) | Canon | Motivo |
|---|---|---|---|---|
| $i\in N$ | Jugadores | — | **$N=\{1,\dots,n\}$** | Gibbons |
| $s_i\in S_i$, $s_{-i}$ | Estrategia y conjunto de estrategias | $S_i$ para la estrategia (3.A.14) | **$s_i\in S_i$** | Gibbons, MWG |
| $u_i(s_i,s_{-i})$ | Pagos | — | **$u_i$** | Unánime |
| EN | $u_i(s_i^*,s_{-i}^*)\ge u_i(s_i,s_{-i}^*)$ | desigualdad estricta (3.A.14) | **$\ge$** | Errata |
| $t_i\in\mathcal T_i$ | Tipo del jugador (juegos bayesianos) | $\theta_1$, $\alpha$ (probabilidad del tipo) (3.A.14) | **$t_i$**, creencias **$\mu$** | Gibbons; $\theta$ es la CRRA y $\alpha$ se usa en la puja |
| $T\subseteq N$, $v(T)$ | Coalición y función característica | $S$, $v(S)$ (3.A.14) | **$T$, $v(T)$** | $S_i$ ya es el conjunto de estrategias |
| $x_i$ | Imputación (pago asignado) | — | **$x_i$**, local | Uso estándar |
| EBP | Equilibrio bayesiano perfecto | «EBPS» (3.A.14) | **EBP** | Nombre estándar |
| $v_i$, $b_i$ | Valoración y puja (subastas) | $\theta_1$ (3.A.14) | **$v_i$, $b_i$**; puja lineal $b_i=\beta_iv_i$ (no $\alpha_2$) | Krishna |

## Información asimétrica (3.A.13)

| Símbolo | Significado | Alternativas (temas) | Canon | Motivo |
|---|---|---|---|---|
| $\overline W$, $L$, $\pi$, $\gamma$, $S$; $A=(\overline W,\overline W-L)$ | Riqueza inicial, pérdida, probabilidad de accidente, prima por euro asegurado, cobertura; dotación sin seguro | $W$, $P$, $p$, $r$, $A=(p_1,p_2;W,W-P)$ (3.A.13 original) | **$\gamma$** (no $r$) y **$A$** (3.A.13 revisado, 19/10/2026, igual que el 3.A.10) | Mismo modelo que 3.A.10; $r$ chocaba con el tipo de interés y con $\hat r$ del mismo tema |
| $\pi_{\mathrm A}>\pi_{\mathrm B}$, $\nu$, $\overline\pi$ | Rothschild-Stiglitz: riesgo alto y bajo, proporción de prudentes, riesgo medio | $p_A$, $p_B$, sin letra para la proporción (3.A.13 original) | **$\pi_{\mathrm A}$, $\pi_{\mathrm B}$, $\nu$** | $\pi$ probabilidad (D017); $\nu$ como Laffont-Tirole; A/B en redonda, mnemónicos de alto y bajo |
| $y$ | Educación (Spence) | $E$ (3.A.13) | **$y$** | Spence (1973) usa $y$; $E$ es la función de gasto y en 3.A.13 también «éxito» |
| $c_{\mathrm A}(y)$, $c_{\mathrm B}(y)$; $w_{\mathrm A}$, $w_{\mathrm B}$; $\nu$ | Spence: coste de la educación y salario de cada tipo; proporción de productivos | $w^R$ en la participación (3.A.13 original) | **Igual** | 3.A.13 revisado (19/10/2026) |
| $x_{\mathrm E}>x_{\mathrm F}$; $w_{\mathrm E}$, $w_{\mathrm F}$ | Resultado (éxito y fracaso) y pagos del principal-agente | $I_E$, $I_F$, éxito $E$ / fracaso $F$ (3.A.13 original) | **Igual**, E y F en redonda | No chocan con la función de gasto |
| $e$, $e^A$, $e^B$ | Esfuerzo (alto, bajo) | — | **$e$** | MWG cap. 14 |
| $\pi(e)$ | Probabilidad de éxito con esfuerzo $e$ | $p_E$, $p_F$ (3.A.13) | **$\pi(e)$** y $1-\pi(e)$ | Coherente con $\pi$ = probabilidad |
| $w(\cdot)$ | Remuneración del agente | $w(I)$ y $w(e)$ mezcladas (3.A.13) | **$w(x)$**, función del resultado observable $x$ | Quita la incoherencia; solo con esfuerzo observable $w(e)$ |
| $v(e)$ | Desutilidad del esfuerzo | — | **$v(e)$** | 3.A.13 |
| $U^R$ | Utilidad de reserva | $\overline U_R$, $w^R$ (3.A.13 original) | **$U^R$** | $\overline U$ es el nivel de utilidad de la dualidad |
| $\lambda_1$, $\lambda_2$ | Multiplicadores de la PC y de la IC | un solo $\lambda$ (3.A.13 original) | **$\lambda_1$, $\lambda_2$** | `notacion.md` § 0 (λ_k si hay varios) |
| $u_P(\cdot)$ | Utilidad del principal averso | $R[\cdot]$ (3.A.13 original) | **$u_P$, solo en los anexos**; en el cuerpo, principal neutral | MWG, Laffont-Martimort; decisión D7 del 3.A.13 (provisional) |
| $\hat r$, $\hat r^*$; $\mathbb E[B_{\mathrm{banco}}]=(1+\hat r)\Pr(\text{repago}\mid\hat r)$ | Tipo del préstamo, el que maximiza el rendimiento del banco y ese rendimiento (Stiglitz-Weiss) | $E[B]=\hat r\times\Pr$ (3.A.13 original, 3.B.27, 4.A.20) | Igual, con $1+\hat r$ | 3.A.13 revisado (19/10/2026) |
| $\mathbb E[\cdot]$ | Esperanza | $E[B]$ (3.B.27, 4.A.20) | **$\mathbb E$** | $E$ es la función de gasto |

## Choques con otras áreas que se mezclan
- **$\pi$**: beneficio (3.A.18-3.A.19) frente a inflación (macro) → beneficio $B$; queda libre para la probabilidad.
- **$W$**: bienestar del regulador (3.A.17) frente a FBS y renta → $ET$.
- **$\theta$**: tipos de jugador y valoraciones (3.A.14) frente a CRRA → $t_i$ y $v_i$.
- **$E$**: educación y éxito (3.A.13) frente a función de gasto y esperanza → $y$, $\pi(e)$, $\mathbb E$.
- **$\lambda$**: coste sombra de los fondos públicos (Laffont-Tirole) y multiplicador de Ramsey-Boiteux en el mismo tema 3.A.17: **resuelto con el 3.A.17 revisado (17/10/2026)**: λ en los 2, con una nota (es la misma idea y da el mismo número de Ramsey λ/(1+λ)); μ queda para el multiplicador de Averch-Johnson.
- **$s$**: tasa de rentabilidad permitida (Averch-Johnson) y, en el 3.A.17 revisado, cantidad vendida $s_i$ en la producción conjunta en proporciones fijas: propuesto $x_i$ para esta (`pendientes-coherencia.md`).
- **$r$**: prima unitaria (seguros) → **$\gamma$** (3.A.10 y 3.A.13, 19/10/2026), coste del capital (4.B.15 → $w_K$), tipo de interés (macro).
- **$\pi$ y $\nu$**: en el 3.A.13, $\pi$ es probabilidad (de accidente o de éxito) y la proporción de tipos es $\nu$; en el 2.º grado del 3.A.17, la proporción de tipos bajos es $\pi$ (no hay probabilidades en ese apartado). Unificar en $\nu$ es una propuesta abierta (`informe-repaso.md` § 14).
- **$v$**: función característica, valoración en subastas, desutilidad del esfuerzo: se distinguen por argumento y subíndice ($v(T)$, $v_i$, $v(e)$); ninguno convive en el mismo apartado.
- **$\beta$**: factor de descuento (juegos repetidos, Rubinstein) frente a la pendiente de la puja lineal $b_i=\beta_iv_i$ que proponía la ficha `subastas` → **la puja va sin letra** (3.A.14, 19/10/2026); β local de Singh-Vives en el 3.A.18 (II.2), con nota.
- **$\theta$**: además de CRRA y tipos, valoración de la calidad en Shaked-Sutton (3.A.18, III.1): excepción local avisada (19/10/2026).
- **$s$**: estrategia $s_i$ (3.A.14), calidad $s_{\mathrm A}>s_{\mathrm B}$ (3.A.18), tasa de Averch-Johnson (3.A.17): temas distintos.
- **$\pi$**: estrategias mixtas $\pi_i$, $\vec\pi_i$ y prior π en el 3.A.14 (nunca $p$, $q$, $\sigma_i$); ν en Spence.
- **$P$**: índice de precios del grupo de variedades (Dixit-Stiglitz, 3.A.18), la única mayúscula de precio en micro, coherente con la macro y el comercio.

**Revisión del 3.A.17 (17/10/2026).** Monopolio: $x(p)$ y $q=x(p)\Leftrightarrow p=p(q)$, $q^M$, $p^M$, $q^c$, $p^c$, $\mathrm{IMg}=p(1-1/|\varepsilon_{q,p}|)$, $\mathcal L=1/|\varepsilon_{q,p}|$ como `\funcionclave`, PIE; discriminación con tipos $t_1<t_2$ y proporción $\pi$, $T(q)=A+p\,q$, grupos $k$; punta y valle $p_v=b$, $p_p=b+\beta$; Ramsey-Boiteux con $\mathrm{ET}(\vec p)$ y λ; Averch-Johnson con $z_K$, $z_L$, $w_K$, $s$ y μ; Laffont-Tirole con $C=\beta-e$, ν, $\psi(e)$, $t$, λ y $t(C)=a-b(C-C^a)$; *yardstick* con $\bar c_{-i}$; monopsonio con $w_L(L)$, $\varepsilon_{L,w_L}$, $\mathrm{VPMg}_L$, $\mathrm{IPMg}_L$, $\mathrm{GMg}_L$, $L^M$, $w^M$, $w^c$, $\underline w$; monopolio bilateral con $U_S=wL-v(L)$, $w^S$ y γ. Colores de los gráficos de bienestar. Detalle y motivos en `notacion.md` § 0, § 1, § 4, § 6 y § 14 (manda) y en `cambios.md`.

**Revisión del 3.A.13 (19/10/2026).** Tipos A/B en redonda (alto y bajo) y ν proporción del tipo bueno; Spence con $y$, $\hat y$, $c_{\mathrm A}(y)$, $w_{\mathrm A}$, $w_{\mathrm B}$, $\mathrm{IC}_{\mathrm A}$, $\mathrm{IC}_{\mathrm B}$; Rothschild-Stiglitz con $\pi_{\mathrm A}>\pi_{\mathrm B}$, $\overline\pi$, $\gamma$ y $A$; principal-agente con $x_{\mathrm E}>x_{\mathrm F}$, $w(x)$, $\pi(e)$, $e^{\mathrm A}$, $e^{\mathrm B}$, $v(e)$, $U^R$, $\lambda_1$, $\lambda_2$, principal neutral y $u_P$ solo en anexos; Stiglitz-Weiss con $(1+\hat r)$. Detalle en `notacion.md` § 1, § 2, § 4 y § 14 (manda) y en `cambios.md`.

**Revisión del 3.A.18 (19/10/2026).** Diferenciación: $U=x_0^{1-\alpha}y^\alpha$ (α parte del gasto en el grupo, a confirmar), $y=[\sum_ix_i^\rho]^{1/\rho}$, $P$, $x_i=(\alpha\overline W/P)(p_i/P)^{-\sigma}$, $\mathcal L=1/\sigma\Leftrightarrow p^*=\mu c$, $q^*=(\sigma-1)\mathrm{CF}/c$, $n^*=\alpha\overline W/(\sigma\mathrm{CF})$, $n$ (variedades = empresas; $J$ en el 3.A.16), $d$ y $D$; Hotelling con empresas 1 y 2 en $a\le b$, $t$, $\tilde x$, $v$, $x_1$, $x_2$, $R_i(p_j)$; Salop con $n^*=\sqrt{t/\mathrm{CF}}$ y $n^{\mathrm o}=n^*/2$; Shaked-Sutton con θ local, $s_{\mathrm A}>s_{\mathrm B}$, $\tilde\theta$, Δs; Singh-Vives con α, β, γ locales, $q^C$, $p^C$, $p^B$; Dorfman-Steiner con $A$ y $\varepsilon_{q,A}$ locales. Fichas `dixit-stiglitz`, `hotelling`, `salop`, `shaked-sutton`, `oligopolio-diferenciado`.

**Revisión del 3.A.14 (19/10/2026).** Juegos: $N$, $s_i\in S_i$, $u_i$, $U_i=\mathbb E[u_i]$, $R_i(s_{-i})$, `eq:nash` con ≥, $\pi_i$ y $\vec\pi_i\in\Delta(S_i)$, β y $u^{\mathrm C}$, $u^{\mathrm D}$, $u^{\mathrm N}$ (gatillo, β ≥ 1/5), $t_i\in\mathcal T_i$, prior π (ν en Spence), μ(y) = Pr(A | y), $c_{\mathrm A}$, $c_{\mathrm B}$; negociación con $u_i^0$, γ, $\mathcal U$, β_1, β_2, ρ_1, ρ_2; cooperativos con $T\subseteq N$, $v(T)$, $x$, $\mathcal C(v)$, $\phi_i(v)$; subastas con $v_i$, $b(v_i)$ sin letra, $F$, $f$, $v_{(1)}$, $v_{(2)}$, $I$, $p^R$, $v_0$, ψ(v). Fichas `equilibrio-nash`, `nucleo-shapley`, `nash-negociacion`; al día `subastas`, `diseno-mecanismos`, `dilema-prisionero`.
