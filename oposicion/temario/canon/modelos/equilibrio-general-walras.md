# Equilibrio general competitivo walrasiano (modelo 2×2×2×2)

- **Área:** equilibrio general y bienestar · **Tema de referencia:** 3.A.21 (Teoría del equilibrio general) — construcción, existencia, unicidad, estabilidad. Las **condiciones de óptimo de Pareto** (FPP, FPU, GFPU) son de 3.A.22.
- **Temas que lo usan:** 3.A.21 (desarrollo), 3.A.22 (desarrollo de la eficiencia), 3.A.23 (desarrollo: **copia** del de 3.A.22, sobra con el título vigente), 3.A.3 (desarrollo histórico: Walras), 4.B.11 (resumen: versión 1×2×2×2 con ocio)
- **Manuales de referencia:** Walras (1874); Arrow y Debreu (1954); Mas-Colell, Whinston y Green, cap. 15-17; Varian, cap. 17-18; Gandolfo; Bator (1957) para la presentación gráfica 2×2×2×2.
- **Decisión D035 (13/10/2026):** ¿Cómo se escriben las relaciones marginales en el equilibrio general? RMS^A_{XY}, RMST^X_{LK} y RMT_{XY}, positivas y sin barras (paralelas a RMS_{12} de 3.A.8)

## Presentación de referencia
Economía: dos bienes $X,Y$, producidos por dos empresas con dos factores $L,K$ (dotaciones $\bar L,\bar K$) y consumidos por dos consumidores $A,B$; competencia perfecta en todos los mercados; preferencias y tecnologías neoclásicas, sin externalidades.
Empresas: $\max\ B_j=p_j F_j(L_j,K_j)-w_LL_j-w_KK_j\Rightarrow p_jPMg_L^j=w_L,\ p_jPMg_K^j=w_K$.
Consumidores: $\max U_h(X_h,Y_h)$ s.a. $p_XX_h+p_YY_h=\overline W_h$, con $\overline W_h$ = valor de sus dotaciones de factores y su parte de beneficios.
Equilibrio: excesos de demanda $z_k(p)=0$ en todos los mercados; ley de Walras $\sum_kp_kz_k(p)\equiv 0$ (un mercado redundante, precios relativos).
Condiciones de eficiencia (3.A.22): $RMST^X_{LK}=RMST^Y_{LK}=\frac{w_L}{w_K}$; $RMS^A_{XY}=RMS^B_{XY}=\frac{p_X}{p_Y}$; $RMS_{XY}=RMT_{XY}=\frac{CMg_X}{CMg_Y}$.
Gráficos de referencia: caja de Edgeworth de la producción y curva de contrato; FPP desde la curva de contrato; caja de Edgeworth del consumo inscrita en la FPP; FPU y GFPU.

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.21 | ¿Existe, es único y estable el EGC? | desarrollo | Modelo con precios, excesos de demanda, ley de Walras, existencia (Brouwer/Kakutani), unicidad (sustitutivos brutos), estabilidad | Condiciones de Pareto en detalle |
| 3.A.22 | ¿Es eficiente? | desarrollo | Tres condiciones, FPP, FPU, GFPU, 1TFEB/2TFEB | Existencia y estabilidad |
| 3.A.23 | Fallos de mercado | resumen (propuesto) | Recordar las condiciones y ver cuál rompe cada fallo | El modelo completo (sobra: remitir a 3.A.22) |
| 3.A.3 | Neoclásicos | resumen | Walras: interdependencia, contar ecuaciones e incógnitas, tâtonnement | Formalización moderna |
| 4.B.11 | Imposición óptima | resumen | Variante 1×2×2×2 con ocio: los impuestos rompen $RMS=RMT$ | 2 consumidores |

## Divergencias encontradas en el temario actual
- Orden de los factores: $F_X(K_X,L_X)$ y $F_X(L_X,K_X)$ en 3.A.22; $K,L$ en 3.A.21: canon **$(L,K)$** y $RMST_{LK}$.
- Escritura de las relaciones marginales: $|RMS_X^Y|_A$ (3.A.22, 3.A.23, en valor absoluto) frente a $RMS_{12}=U_1/U_2>0$ (3.A.8 revisado): canon $RMS^A_{XY}=\frac{\partial U_A/\partial X}{\partial U_A/\partial Y}$ (positiva, sin barras; consumidor arriba, bienes abajo); igual $RMST^X_{LK}$ y $RMT_{XY}$.
- Bienes: $X,Y$ (3.A.21-3.A.23) y $X_1,X_2$ (4.B.11); 3.A.21 mezcla $x_h,y_h$ y $p_x/p_X$: canon $X_h,Y_h$ y $p_X,p_Y$.
- Precios de factores: $w_K,w_L$ (3.A.21) frente a $w,r$ (3.A.23) y $W,R$ (3.A.11): canon $w_L,w_K$.
- 3.A.21: «la convexidad estricta del conjunto de producción implica rendimientos decrecientes» y el 1TFEB pide rendimientos no crecientes (el 1TFEB no necesita convexidad).
- 3.A.22 habla de «modelo 2×2×2» con 10 incógnitas: unificar en 2×2×2×2.
