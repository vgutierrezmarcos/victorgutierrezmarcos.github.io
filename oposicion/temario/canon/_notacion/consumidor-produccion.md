# Notación del área consumidor-producción (3.A.8-3.A.12)

Paso 2 del canon (13 oct. 2026). Fuentes: `_inventario/3A08…3A12.json`, `resumen-por-area.md` (comprobado), fuente revisada `fuentes/3A08/3A08.tex` (su notación ya es canon salvo lo que se marca). Manuales base: Mas-Colell, Whinston y Green (MWG, 1995); Varian, *Análisis microeconómico*; Jehle y Reny (2011). Decisiones aprobadas por Víctor el 13/10/2026 (`decisiones.json`): la columna «Canon» es la notación definitiva; `notacion.md` manda si difiere por un choque entre áreas.

Convenciones: minúsculas para precios y cantidades de micro ($p$, $x$, $q$, $w$, $z$); mayúsculas para funciones de valor ($U$, $V$, $E$, $C$, $B$) y para niveles agregados de macro ($Y$, $K$, $L$, $P$). Superíndices $0$ y $1$ para dos situaciones ($x^0$, $p^1$, $\overline U^0$); subíndice $i$ para bienes.

## Consumidor (certidumbre)

| Símbolo | Significado | Alternativas en el temario (temas) | Canon | Motivo |
|---|---|---|---|---|
| $x=(x_1,\dots,x_n)$ | Cesta, cantidades demandadas | $q$ en los índices de precios (3.A.9); $X,Y$ en EG (3.A.21-3.A.23) | **$x$** ($X_h,Y_h$ solo en el 2×2×2×2) | 3.A.8, MWG |
| $p$ | Vector de precios de los bienes | $P_x$ en la Cobb-Douglas (3.A.9) | **$p$** minúscula | 3.A.8; $P$ es el nivel de precios en macro |
| $\overline W$ | Renta (o riqueza) del consumidor | $W$ sin barra (3.A.10, 3.A.13), $M$ (3.A.25, 4.B.10), $V$ renta no laboral (3.A.8, Becker) | **$\overline W$**; en riesgo, **$\overline W$** riqueza inicial | 3.A.8 (canon); la barra la distingue de la FBS $W(\cdot)$ |
| $M$ | Renta no laboral | $V$ (3.A.8, ec. `becker-restricciones`) | **$M$** | $V$ es la FIU en el mismo tema; $M$ ya se usa en 3.A.25 y 4.B.10-4.B.11. Hay que poner al día 3.A.8 |
| $U(x)$, $U_i$ | Utilidad y utilidad marginal del bien $i$ | $u(x)$ (3.A.10) | **$U$** sobre cestas; **$u$** solo para la utilidad de Bernoulli (riesgo) | MWG |
| $\overline U$, $\overline U^0$, $\overline U^1$ | Nivel de utilidad dado | — | **$\overline U$** | 3.A.8, 3.A.9 |
| $x(p,\overline W)$ | Demanda **marshalliana** (SCEDM) | «walrasiana» (3.A.16; MWG) | **marshalliana**; «también llamada ordinaria o walrasiana» una sola vez (como hace 3.A.8). «Walrasiano» queda para el **conjunto presupuestario walrasiano** $B(p,\overline W)$, el equilibrio walrasiano y el ajuste walrasiano por precios | Título oficial de 3.A.8; evita confundir con la estabilidad walrasiana de 3.A.16 |
| $h(p,\overline U)$ | Demanda hicksiana (SCEDC) | — | **$h$** | Unánime |
| $V(p,\overline W)$ | Función indirecta de utilidad | $V$ como utilidad esperada (3.A.10) y renta no laboral (3.A.8) | **$V$** solo FIU | Choques dentro de 3.A.8 y 3.A.10 |
| $E(p,\overline U)$ | Función de gasto | $E$ esperanza (3.B.27, 4.A.20), $E$ educación (3.A.13) | **$E(p,\overline U)$**; esperanza **$\mathbb E[\cdot]$** | 3.A.8-3.A.9 |
| $\lambda$ | Multiplicador (utilidad marginal de la renta) | $\lambda$ factor de escala (3.A.11) | **$\lambda$** solo multiplicador; factor de escala **$t$** | MWG usa $\alpha$ o $t$ para la escala |
| $RMS_{12}=U_1/U_2$ | Relación marginal de sustitución, **positiva** | $|RMS_X^Y|_A$ en valor absoluto (3.A.22, 3.A.23) | **$RMS_{12}$**; en EG $RMS^A_{XY}$ (consumidor arriba) | 3.A.8 (canon) |
| $\sigma$ | Elasticidad de sustitución | CRRA en KPR/GHH/JR (3.A.8, anexo) y en 3.A.42 | **$\sigma$** solo elasticidad de sustitución (y desviación típica en finanzas) | Coordinado con `macro-cerrada.md` |
| $a_i$ | Pesos de la CES | $s_i$ (3.A.11) | **$a_i$** | $s_i$ es la participación en el gasto |
| $\rho=(\sigma-1)/\sigma$ | Parámetro de la CES | $\rho$ tasa de descuento (macro), prima de riesgo (3.A.10) | **$\rho$** dentro de la CES, avisando | Arrow et al. (1961); los temas no mezclan ambas |
| $s_i=p_ix_i/\overline W$ | Participación en el gasto | — | **$s_i$** | 3.A.8 |
| $\varepsilon_{x_i,p_j}$, $\varepsilon_{x_i,\overline W}$ | Elasticidades precio y renta | — | **$\varepsilon$** con dos subíndices | 3.A.8 |
| $VC$, $VE$, $\Delta EC$ | Variaciones compensatoria y equivalente, excedente | «VEC» (3.A.9) | **$VC$, $VE$, $\Delta EC$** | Ficha `vc-ve` |
| $\Theta(z;\overline U,\overline W)$, $\phi(z;B)$ | Funciones de puja y de oferta (Rosen) | $\theta(\cdot)$ y $\phi(z;\pi)$ (3.A.8) | **$\Theta(z;\overline U,\overline W)$** para la puja y **$\phi(z;B)$** para la oferta ($\theta$ es la CRRA y $B$ el beneficio) | Ficha `precios-hedonicos` |

## Consumidor (riesgo e incertidumbre, 3.A.10; seguros en 3.A.13)

| Símbolo | Significado | Alternativas (temas) | Canon | Motivo |
|---|---|---|---|---|
| $\tilde y$ | Lotería / renta aleatoria | — | **$\tilde y$** (tilde = aleatoria) | 3.A.10 |
| $\pi_s$ | Probabilidad del estado $s$ (y de accidente, $\pi$) | $p_s$ (3.A.10), $p$ (3.A.13, 4.B.10) | **$\pi_s$** | $p$ son los precios en todo el área; $\pi$ queda libre en micro si el beneficio es $B$; Varian y MWG cap. 19 |
| $u(\cdot)$ | Utilidad de Bernoulli | — | **$u$** | MWG |
| $U(\tilde y)=\mathbb E[u(\tilde y)]$ | Utilidad esperada VNM | $V(\tilde y)$ (3.A.10) | **$U$** | $V$ es la FIU |
| $r_A(\cdot)$, $r_R(\cdot)$ | Aversión absoluta y relativa de Arrow-Pratt | $r_\alpha$, $r_r$; $r_R$ en las preguntas (3.A.10) | **$r_A$, $r_R$** | MWG; quita la incoherencia interna |
| $\theta$ | Coeficiente CRRA, $u(c)=\frac{c^{1-\theta}-1}{1-\theta}$ | $\eta$ (3.A.8), $\theta$ (3.A.10 y macro), $\sigma$ (3.A.8 KPR/GHH/JR, 3.A.42) | **$\theta$** | Romer, Blanchard-Fischer, Acemoglu y la mayoría de temas (9). Coordinado con `macro-cerrada.md`. Obliga a cambiar en 3.A.8: CRRA $\eta\to\theta$, KPR/GHH/JR $\sigma\to\theta$, Frisch de GHH $\theta\to\varphi$ y la puja de Rosen $\theta\to\Theta$ |
| $1/\theta$ | Elasticidad de sustitución intertemporal | $\sigma$ (3.A.10: «σ=1/θ es la EIS») | **$1/\theta$**, sin símbolo propio | Igual que macro |
| $\xi$ | Equivalente cierto | — | **$\xi$** | 3.A.10 |
| $\rho$ | Prima de riesgo | — | **$\rho$** dentro de 3.A.10, avisando del choque con el descuento | Tolerable: 3.A.10 no usa descuento |
| $L$ | Pérdida (seguros) | $P$ en el punto inicial (3.A.10, 3.A.13) | **$L$** (y, si convive con trabajo, $\ell$) | Quita la incoherencia interna |
| $r$ | Prima por unidad asegurada | — | **$r$**, local | El tipo de interés no aparece en esos apartados |
| $S$ | Cobertura (cantidad asegurada) | — | **$S$** | 3.A.13 |
| $x_1$, $x_2$ | Riqueza en el estado sin y con accidente | — | **$x_1$, $x_2$** | Coherente con $x$ = consumo |
| $RMSE$ | Relación marginal de sustitución entre estados | — | **$RMSE$** | 3.A.13 |

## Producción y costes (3.A.11-3.A.12)

| Símbolo | Significado | Alternativas (temas) | Canon | Motivo |
|---|---|---|---|---|
| $z=(z_L,z_K)$ | Factores (vector) | $K,L$ en la estática comparativa (3.A.12) y en macro | **$z$** en 3.A.11-3.A.12; **$L,K$** en EG, comercio y macro | MWG; orden $(L,K)$ |
| $q$ | Producción (output) | $Q$ (3.A.11, elasticidad de escala), $\overline Q$ (3.A.12, dual) | **$q$** (y $Q=\sum_iq_i$ para la industria) | Quita incoherencias internas de 3.A.11 y 3.A.12 |
| $F(z)$, $f(z)$ | Función de producción | $\breve F$ con progreso técnico (3.A.11) | **$F$** (minúscula $f$ para la intensiva en macro) | Romer |
| $\mathcal Y$ | Conjunto de posibilidades de producción | $Y$ (3.A.11, choca con el bien $Y$) | **$\mathcal Y$** | MWG usa $Y$; la caligráfica evita el choque |
| $w=(w_L,w_K)$ | Precios de los factores | $W,R$ (3.A.11), $w,r$ (3.A.23) | **$w_L$, $w_K$** | MWG; $r$ queda para el tipo de interés y $W$ para la renta |
| $p$ | Precio del producto | — | **$p$** | 3.A.12 |
| $C(w,q)$ | Función de costes | $C(w,\overline Q)$ (3.A.12), $C_i(\bar q_i,w)$ y $C_i(w,q_i)$ (3.A.16), $C(q)$ (3.A.17) | **$C(w,q)$**; $C(q)$ cuando $w$ es fijo | MWG $c(w,q)$, Varian $c(w,y)$; precios primero, como $V(p,\overline W)$ y $E(p,\overline U)$ |
| $z(w,q)$, $z(p,w)$ | Demandas condicionadas y no condicionadas de factores | SCEDIC / SCEDINC (3.A.12) | **$z(w,q)$** (condicionada), **$z(p,w)$** (no condicionada) | MWG |
| $B$, $B(p,w)$ | Beneficio y función de beneficio | $\pi$ (3.A.18, 3.A.19) | **$B$** (ver `mercados-informacion-juegos.md`) | Mayoría de temas; $\pi$ es la inflación |
| $PMg$, $PMe$ | Productividad marginal y media | — | **$PMg_L$, $PMe_L$** | Unánime |
| $RMST_{LK}=PMg_L/PMg_K$ | Relación marginal de sustitución técnica, positiva | $RMST^K_L$ (3.A.11), $|RMST_L^K|$ (3.A.22) | **$RMST_{LK}$** (y $RMST^X_{LK}$ en EG) | Paralela a $RMS_{12}$ |
| $CMg$, $CMe$, $CVMe$, $CF$ | Costes marginal, medio, variable medio, fijo | — | Igual | Unánime |
| $A_t$ | Nivel tecnológico | — | **$A_t$** | Unánime |
| $\varepsilon_{q,t}$ | Elasticidad de escala | — | **$\varepsilon_{q,t}=\frac{dq/q}{dt/t}$** | Corrige la errata de 3.A.11 ($dz_L/dz_L$) |

## Choques con otras áreas que se mezclan
- **$W$**: renta $\overline W$ (con barra, siempre) frente a FBS $W(\cdot)$ (equilibrio general) y bienestar del regulador $W$ (3.A.17 → $ET$). 3.A.11 usa $W$ para el salario: pasa a $w_L$.
- **$\theta$**: CRRA (macro, 3.A.10) frente a puja de Rosen (3.A.8), tensión $V/U$ (3.A.26, en otra área) y tipos de jugador (3.A.14, ver mercados).
- **$\sigma$**: elasticidad de sustitución (aquí y en Dixit-Stiglitz) frente a CRRA (3.A.42) y desviación típica (finanzas).
- **$E$**: función de gasto frente a esperanza ($\mathbb E$), educación (3.A.13 → $y$) y puntos de equilibrio en gráficos (aceptable).
- **$V$**: FIU frente a utilidad esperada (→ $U$), renta no laboral (→ $M$) y valor actual (finanzas).
- **$p$**: precios frente a probabilidad (→ $\pi_s$).
- **$\lambda$**: multiplicador frente a escala (→ $t$), coste de los fondos públicos (Laffont-Tirole) y aversión a las pérdidas (Kahneman-Tversky, local).
- **$L$**: trabajo frente a pérdida (seguros), índice de Lerner y lotería (MWG).
