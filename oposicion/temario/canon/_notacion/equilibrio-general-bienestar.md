# Notación del área equilibrio general y bienestar (3.A.21-3.A.24)

Paso 2 del canon (13 oct. 2026). Fuentes: `_inventario/3A21…3A24.json`, `resumen-por-area.md` (comprobado), 3.A.8 revisado. Manuales base: Mas-Colell, Whinston y Green (MWG), cap. 15-23; Varian, cap. 17-23; Gandolfo; Sen (1970); Bator (1957). **[decidir]** = pendiente de Víctor.

| Símbolo | Significado | Alternativas en el temario (temas) | Propuesta | Motivo |
|---|---|---|---|---|
| $X$, $Y$ | Bienes (y cantidades totales) del 2×2×2×2 | $X_1,X_2$ (4.B.11); $x_h,y_h$ y $p_x$ mezclados con $X$, $p_X$ (3.A.21) | **$X,Y$**; consumo $X_A,Y_A$; precios $p_X,p_Y$ | 3.A.22-3.A.23; quita la mezcla de 3.A.21. Con $n$ bienes, $x_k$, $k=1,\dots,n$ |
| $L$, $K$; $\bar L$, $\bar K$ | Trabajo y capital; dotaciones | orden $(K,L)$ en 3.A.21 y en los supuestos de 3.A.22 | **orden $(L,K)$**: $F_X(L_X,K_X)$ | Quita la incoherencia interna de 3.A.22; coherente con $z=(z_L,z_K)$ |
| $w_L$, $w_K$ | Precios de los factores | $w,r$ (3.A.23), $W,R$ (3.A.11) | **$w_L$, $w_K$** | 3.A.21; $r$ es el tipo de interés |
| $A$, $B$ (o $i=1,\dots,I$) | Consumidores | $h$ (3.A.21), $1,\dots,I$ (3.A.24), $1,\dots,N$ (4.B.2) | **$A,B$** en el 2×2×2×2; **$i=1,\dots,I$** en general **[decidir]** | MWG ($i$ consumidores, $j$ empresas); $N$ es el número de alternativas en Arrow |
| $\omega_i$ | Dotación inicial del consumidor $i$ | $e$, $e'$ (3.A.22, 4.B.3, 4.B.7) | **$\omega$, $\omega'$** **[decidir]** | MWG; $e$ es esfuerzo (3.A.13) |
| $\overline W_i$ | Renta del consumidor: $p\cdot\omega_i+\sum_j\theta_{ij}B_j$ | $\overline W_h$ (3.A.21), $\overline W=w_LO_0+M$ (4.B.11) | **$\overline W_i$** | 3.A.8; participaciones $\theta_{ij}$ como MWG (dos subíndices: no se confunden con la CRRA) **[decidir]** |
| $B_j$ | Beneficio de la empresa $j$ | $B_i$ (3.A.21) | **$B_j$** | Ver mercados |
| $z_k(p)$ | Exceso de demanda del bien $k$ | $z_i$ (3.A.21) | **$z_k(p)$**; ley de Walras $p\cdot z(p)\equiv 0$ | MWG |
| $RMS^A_{XY}$ | Relación marginal de sustitución de $A$, positiva | $|RMS_X^Y|_A$ (3.A.22, 3.A.23), $RMS^A$ (4.B.2) | **$RMS^A_{XY}=\frac{\partial U_A/\partial X_A}{\partial U_A/\partial Y_A}$** **[decidir]** | Paralela a $RMS_{12}$ de 3.A.8 (positiva, sin barras) |
| $RMST^X_{LK}$ | Relación marginal de sustitución técnica en $X$ | $|RMST_L^K|_X$ | **$RMST^X_{LK}$** | Igual |
| $RMT_{XY}$ | Relación marginal de transformación | $|RMT_X^Y|$; $RMT_G^X$ (3.A.23) | **$RMT_{XY}=\frac{CMg_X}{CMg_Y}$** | Igual |
| FPP, FPU, GFPU | Fronteras de posibilidades de producción, de utilidad y gran frontera | — | Igual | Unánime |
| $\mathcal Y$ | Conjunto de producción | $Y$ (3.A.11) | **$\mathcal Y$** | Choca con el bien $Y$ |
| $W(U_1,\dots,U_I)$ | Función de bienestar social | $W(\bullet)$ (3.A.24), $W$ (3.A.22, 4.B.2) | **$W(\cdot)$** con argumentos | Bergson-Samuelson, MWG; la renta lleva barra |
| CIS | Curvas de indiferencia social | — | Igual | 3.A.24 |
| $R_i$, $R_G$; $\succsim_i$, $\succsim_G$ | Ordenaciones individual y social | $\succeq_G$, $\alpha_i^n$ (3.A.24) | **$R_i$, $R_G$** y **$\succsim$** (el $\succcurlyeq$ de 3.A.8) | Arrow (1951); mismo glifo que 3.A.8 |
| $\epsilon$ | Aversión a la desigualdad (Atkinson) | no explícito | **$\epsilon$** **[decidir]** | Atkinson (1970); distinto de $\varepsilon$ (elasticidad) |
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
