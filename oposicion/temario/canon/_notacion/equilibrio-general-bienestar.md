# Notación del área equilibrio general y bienestar (3.A.21-3.A.24)

Paso 2 del canon (13 oct. 2026). Fuentes: `_inventario/3A21…3A24.json`, `resumen-por-area.md` (comprobado), 3.A.8 revisado. Manuales base: Mas-Colell, Whinston y Green (MWG), cap. 15-23; Varian, cap. 17-23; Gandolfo; Sen (1970); Bator (1957). Decisiones aprobadas por Víctor el 13/10/2026 (`decisiones.json`): la columna «Canon» es la notación definitiva; `notacion.md` manda si difiere por un choque entre áreas.

| Símbolo | Significado | Alternativas en el temario (temas) | Canon | Motivo |
|---|---|---|---|---|
| $X$, $Y$ | Bienes (y cantidades totales) del 2×2×2×2 | $X_1,X_2$ (4.B.11); $x_h,y_h$ y $p_x$ mezclados con $X$, $p_X$ (3.A.21) | **$X,Y$**; consumo $X_A,Y_A$; precios $p_X,p_Y$ | 3.A.22-3.A.23; quita la mezcla de 3.A.21. Con $n$ bienes, $x_k$, $k=1,\dots,n$ |
| $L$, $K$; $\bar L$, $\bar K$ | Trabajo y capital; dotaciones | orden $(K,L)$ en 3.A.21 y en los supuestos de 3.A.22 | **orden $(L,K)$**: $F_X(L_X,K_X)$ | Quita la incoherencia interna de 3.A.22; coherente con $z=(z_L,z_K)$ |
| $w_L$, $w_K$ | Precios de los factores | $w,r$ (3.A.23), $W,R$ (3.A.11) | **$w_L$, $w_K$** | 3.A.21; $r$ es el tipo de interés |
| $A$, $B$ (o $i=1,\dots,I$) | Consumidores | $h$ (3.A.21), $1,\dots,I$ (3.A.24), $1,\dots,N$ (4.B.2) | **$A,B$** en el 2×2×2×2; **$i=1,\dots,I$** en general | MWG ($i$ consumidores, $j$ empresas); $N$ es el número de alternativas en Arrow |
| $\omega_i$ | Dotación inicial del consumidor $i$ | $e$, $e'$ (3.A.22, 4.B.3, 4.B.7) | **$\vec\omega_i$, $\vec\omega'$** (vector, con flecha; 3.A.21) | MWG; $e$ es esfuerzo (3.A.13) |
| $\overline W_i$ | Renta del consumidor: $p\cdot\omega_i+\sum_j\theta_{ij}B_j$ | $\overline W_h$ (3.A.21), $\overline W=w_LO_0+M$ (4.B.11) | **$\overline W_i$** | 3.A.8; participaciones $\theta_{ij}$ como MWG (dos subíndices: no se confunden con la CRRA) |
| $B_j$ | Beneficio de la empresa $j$ | $B_i$ (3.A.21) | **$B_j$** | Ver mercados |
| $z_k(p)$ | Exceso de demanda del bien $k$ | $z_i$ (3.A.21) | **$z_k(\vec p)$**; ley de Walras $\vec p\cdot\vec z(\vec p)\equiv 0$ | MWG; 3.A.21 revisado |
| $RMS^A_{XY}$ | Relación marginal de sustitución de $A$, positiva | $|RMS_X^Y|_A$ (3.A.22, 3.A.23), $RMS^A$ (4.B.2) | **$RMS^A_{XY}=\frac{\partial U_A/\partial X_A}{\partial U_A/\partial Y_A}$** | Paralela a $RMS_{12}$ de 3.A.8 (positiva, sin barras) |
| $RMST^X_{LK}$ | Relación marginal de sustitución técnica en $X$ | $|RMST_L^K|_X$ | **$RMST^X_{LK}$** | Igual |
| $RMT_{XY}$ | Relación marginal de transformación | $|RMT_X^Y|$; $RMT_G^X$ (3.A.23) | **$RMT_{XY}=\frac{CMg_X}{CMg_Y}$** | Igual |
| FPP, FPU, GFPU | Fronteras de posibilidades de producción, de utilidad y gran frontera | — | Igual | Unánime |
| $\mathcal Y$ | Conjunto de producción | $Y$ (3.A.11) | **$\mathcal Y$** | Choca con el bien $Y$ |
| $W(U_1,\dots,U_I)$ | Función de bienestar social | $W(\bullet)$ (3.A.24), $W$ (3.A.22, 4.B.2) | **$W(\cdot)$** con argumentos | Bergson-Samuelson, MWG; la renta lleva barra |
| CIS | Curvas de indiferencia social | — | Igual | 3.A.24 |
| $R_i$, $R_G$; $\succsim_i$, $\succsim_G$ | Ordenaciones individual y social | $\succeq_G$, $\alpha_i^n$ (3.A.24) | **$R_i$, $R_G$** y **$\succsim$** (el $\succcurlyeq$ de 3.A.8) | Arrow (1951); mismo glifo que 3.A.8 |
| $\epsilon$ | Aversión a la desigualdad (Atkinson) | no explícito | **$\epsilon$** | Atkinson (1970); distinto de $\varepsilon$ (elasticidad) |
| $G$ | Bien público | — | **$G$** ($G_A=G_B=G$) | Samuelson; coincide con el gasto público de macro (mismo sentido) |
| $T(X,G)=0$ | FPP con bien público | — | **$T$**, local | — |
| $CMgP$, $CMgE$, $CMgS$ | Coste marginal privado, externo, social | $DMg$ (daño marginal, Coase) | **$CMgE$** (diciendo que es el daño marginal) | 3.A.23 |
| $t^*$ | Impuesto pigouviano | — | **$t^*=CMgE(q^*)$** | — |
| $c_i$ | Cuota de coste en Clarke-Groves | — | **$c_i$** | 3.A.23 |
| $\mu$, $\lambda_k$ | Multiplicadores del programa de eficiencia | $\mu$, $\lambda_1,\lambda_2,\lambda_3$ | **$\lambda_k$** | Una sola letra para multiplicadores |

## Choques con otras áreas que se mezclan
- **$W$**: FBS $W(\cdot)$ frente a renta $\overline W$ (consumidor) y bienestar del regulador (mercados → $ET$). Regla: la renta siempre con barra; la FBS siempre con argumentos.
- **$B$**: beneficio $B_j$ frente a consumidor $B$: se distinguen por subíndice ($B_X$, $U_B$); si Víctor lo prefiere, consumidores $1,2$ en el 2×2×2×2.
- **$e$** (dotación) frente a esfuerzo (3.A.13) → $\omega$.
- **$r$**: precio del capital en 3.A.23 frente a tipo de interés (macro) → $w_K$.
- **$\theta_{ij}$** (participaciones en beneficios) frente a CRRA $\theta$ → aceptable por los dos subíndices; alternativa $s_{ij}$ (pero $s_i$ es la participación en el gasto).
- **Modelo 2×2×2×2**: 3.A.23 lo copia de 3.A.22 (sobra con el título vigente) y 3.A.21 lo cuenta con otra notación; ver ficha `equilibrio-general-walras`.

## Añadido con el 3.A.21 revisado (14/10/2026)

Detalle en `notacion.md` § 5 (manda). Símbolos nuevos del tema: símplice $\Delta$; aplicación del subastador $f_k(\vec p)$; velocidad del tanteo $\kappa_k$ ($\dot p_k=\kappa_kz_k(\vec p)$; $k$ es el índice de los bienes); factor de homogeneidad $\alpha$ (local); $\vec p=(p_X,p_Y,w_L,w_K)$ y $\vec p^0,\vec p^1$ para dos vectores de precios (antes $\vec p^A,\vec p^B$, que chocaban con los consumidores); $\theta_{ij}$ y $\overline W_i=\vec p\cdot\vec\omega_i+\sum_j\theta_{ij}B_j$; curvas de oferta-demanda $\mathrm{OD}_A$, $\mathrm{OD}_B$; coalición $\mathcal S$ y réplicas $r$; bienes y precios contingentes $x_{ks}$, $p_{ks}$ (con un bien, $x_{is}$, $p_s$); dinero $\overline M_i$, $M^D$, proporción de Cambridge $\varphi$ (local); álgebra de Jones $c_j$, $a_{Lj}$, $s_{Lj}$, $\ell_{Lj}$ y $\hat x$. Siglas: EGC (competitivo) y MEGC (computables); nunca «EG», que es el exceso de gravamen.


## Añadido con el 3.A.22 y el 3.A.23 revisados (21/10/2026)

Detalle en `notacion.md` § 1 (filas λ, ψ / Ψ, T, F / P / Q, H, g, t / τ, w / r, S, E, V) y § 5 (manda). **3.A.22:** planificador del 2×2×2×2 con $\lambda_U,\lambda_X,\lambda_Y,\lambda_L,\lambda_K$ (precios sombra; antes μ negativo y $\lambda_1,\lambda_2,\lambda_3$); FPP implícita $T(X,Y)=0$, $T(\vec x)=0$, $T_j(\vec y_j)\leq0$; transferencias $T_i$ con $\sum_iT_i=0$; $V_i$, $V$, $\mathcal Y$, $r$ en la demostración del 2TFEB; curvas sociales $W_1<W_2<W_3$, $W^*$ y puntos $a$-$d$; *second best* con $U(\vec x)$, $T(\vec x)=0$, $U_k$, $T_k$, $\psi\neq1$ (antes $k$ o $1+t$), $\lambda_1$, $\lambda_2$, $\Psi_k$ (antes $Q_k$) y puntos $F$, $P$, $Q$ (antes $A$, $B$, $C$); dotación $\vec\omega$, $\vec\omega'$ (antes $e$, $e'$). **3.A.23:** $\overline p$, $q^c$ (antes $q'$), $q^*$, $\mathrm{CMgP}$, $\mathrm{CMgE}$, $\mathrm{CMgS}$; $\mathrm{BMg}(q)=\overline p-\mathrm{CMgP}(q)$ y $\mathrm{DMg}(q)\equiv\mathrm{CMgE}(q)$ (antes $P-\mathrm{CMg}$); estándar $\overline q$ (antes $Q_{\max}$; se mantiene pese al choque con la escala mínima eficiente: P21-01, opción a, Víctor, 21/10/2026); $\overline E$, $p_E$, $r_j$, $\mathrm{CMgR}_j$ (antes $P_0$, $R_0$); $\mathrm{RMS}^i_{GX}(G)$, $\mathrm{CMg}_G$ (antes $\mathrm{UMg}^i$, $D_T$); tilde para lo declarado; $p^i_G$ (antes $\widetilde{p_G^i}$); $\mathrm{FPC}_A$; $g_i$, $R_i(g_j)$, $G^{\mathrm N}$ (antes $R_1$, $G^{EN}$); $c_i$, $v_i$, $\tilde v_i$, $H_i$, $\tau_i$, $d$, $S_{-i}$; Kydland-Prescott con $a_t$, $x_t$, $X_t(\cdot)$, $S(\cdot)$; Gordon con $N$, $F(N)$, $c$.
