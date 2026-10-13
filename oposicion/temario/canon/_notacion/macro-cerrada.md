# Notación del área macro cerrada (3.A.25-3.A.45, salvo 3.A.32)

Paso 2 del canon (13 oct. 2026). Fuentes: `_inventario/3A25…3A45.json`, `resumen-por-area.md` (comprobado contra los Word originales), fuente revisada de 3.A.8 (canon). Manuales base: Romer, *Advanced Macroeconomics* (5.ª ed., 2019); Blanchard y Fischer, *Lectures on Macroeconomics* (1989); Galí, *Monetary Policy, Inflation, and the Business Cycle* (2.ª ed., 2015); Walsh, *Monetary Theory and Policy* (4.ª ed., 2017); Sala i Martín, *Apuntes de crecimiento económico* (2000); Acemoglu (2009); Heijdra (2017); Cahuc, Carcillo y Zylberberg, *Labor Economics* (2.ª ed., 2014). Decisiones aprobadas por Víctor el 13/10/2026 (`decisiones.json`): la columna «Canon» es la notación definitiva; `notacion.md` manda si difiere por un choque entre áreas.

Convenciones generales:

- Mayúsculas para niveles agregados (Y, K, L, C, I, G, T, D, M); minúsculas para valores por trabajador o por unidad de trabajo eficiente (y, k, c) y para logaritmos en los modelos log-linealizados (y_t, p_t, m_t), diciéndolo en cada tema.
- Superíndice ⁿ para el valor «natural» (y^n, U^n, r^n); asterisco para objetivos y valores óptimos (π*, U*, τ*). Se abandona y_TNP (3.A.6, 3.A.37, 3.A.41) y Ū para el paro natural (3.A.6).
- Tasas de crecimiento: γ_X ≡ Ẋ/X (como ya hacen 3.A.44 y 3.A.45); se abandonan «g» y «m» para el progreso técnico (véase abajo).
- Tiempo discreto con subíndice t; tiempo continuo con punto (ẋ). Expectativas: E_t[x_{t+1}]; expectativas de la variable formadas en t−1: x^e_t ≡ E_{t−1}[x_t].

## Preferencias y decisiones intertemporales

| Símbolo | Significado | Alternativas en el temario (temas) | Canon | Motivo |
|---|---|---|---|---|
| θ | Coeficiente de aversión relativa al riesgo (CRRA) de u(c)=c^{1−θ}/(1−θ); 1/θ es la elasticidad de sustitución intertemporal (ESI) | θ (3.A.7, 3.A.29, 3.A.36, 3.A.37, 3.A.38, 3.A.43, 3.A.44, 3.A.6 RBC); σ (3.A.42; 3.A.37 en una versión de la IS dinámica; 3.A.8 revisado en las preferencias KPR y GHH) | **θ** | Romer, Blanchard-Fischer, Barro-Sala i Martín y Acemoglu usan θ; es lo que usa la mayoría de los temas. σ queda para la elasticidad de sustitución intratemporal (CES, 3.A.8 y 3.A.11) y para la desviación típica. Hay que poner al día 3.A.8 (CRRA: η→θ; KPR, GHH y JR: σ→θ; GHH y JR: θ→φ) |
| 1/θ | ESI | σ (3.A.29: «ESI ≡ σ = 1/θ») | **1/θ**, sin símbolo propio | Evita que σ signifique ESI en un tema y CRRA en otro |
| ρ | Tasa de descuento (preferencia temporal) | ρ (3.A.29, 3.A.33, 3.A.38, 3.A.43, 3.A.44) | **ρ** | Unánime |
| β | Factor de descuento en tiempo discreto, β ≡ 1/(1+ρ) | β (3.A.38 OLG, 3.A.42, 3.A.7, 3.A.36); 1/(1+ρ) (3.A.38 RBC) | **β ≡ 1/(1+ρ)** | Se escribe β en las ecuaciones y se define una vez su relación con ρ. Excepción: modelo cuasihiperbólico β-δ de Laibson (área pensamiento) |
| φ | Inversa de la elasticidad de Frisch de la oferta de trabajo | φ (3.A.6); θ (3.A.8, GHH) | **φ** | Galí y la literatura EGDE. Choca con φ_π, φ_x de la regla de Taylor solo de forma aparente (estos llevan subíndice) |
| χ | Peso del ocio (desutilidad del trabajo) en la utilidad | ζ (3.A.6) | **χ** | Galí/Walsh; ζ se deja libre |
| λ_t | Precio sombra (multiplicador, coestado del hamiltoniano) | λ (3.A.29, 3.A.43); λ(θ) tasa de encontrar empleo (3.A.26) | **λ_t** solo para precio sombra | Véase DMP |
| b_t | Activos netos del hogar | b_t (3.A.29, 3.A.43) | **b_t** (a_t en Romer) | Se mantiene la del temario |

## Producción, capital y crecimiento

| Símbolo | Significado | Alternativas (temas) | Canon | Motivo |
|---|---|---|---|---|
| Y, K, L | Producción, capital, trabajo | — | **Y, K, L** | Unánime |
| A_t | Productividad / eficiencia del trabajo (Solow: F(K, AL)) y PTF en el RBC | A_t | **A_t** | Unánime |
| α | Participación (elasticidad) del capital en la Cobb-Douglas; 1−α la del trabajo | α y (1−α), α_K y α_L (3.A.45) | **α y 1−α**; α_K, α_L solo en la contabilidad del crecimiento con más de dos factores | 3.A.45 los mezcla dentro del tema |
| δ | Tasa de depreciación | δ (3.A.6, 3.A.36, 3.A.43, 4.B.1, 4.B.5, 4.B.10); δ^K, δ^H (3.A.44); δ = separación (3.A.26); δ = pendiente de la NKPC (3.A.7, 3.A.36, 3.A.37) | **δ solo depreciación** (δ_K, δ_H si hay dos capitales) | δ es depreciación en todos los manuales de crecimiento; las otras dos acepciones se cambian (abajo) |
| s | Tasa de ahorro (Solow); s_t ahorro del joven en OLG | s; s_t (3.A.38, 4.B.3) | **s** (tasa); **S_t** (ahorro en nivel) | s_t en OLG es nivel: se propone S_t |
| n | Crecimiento de la población | n | **n** | Unánime |
| γ_A (= g) | Tasa de progreso técnico exógeno | g (3.A.43 cuerpo); m (3.A.43 anexo) | **g** | Romer usa g y la regla de oro δ+n+g es la fórmula más conocida; el crecimiento del PIB es γ_Y. Se elimina m. Choque: g = gasto público por trabajador en Barro (1990) (3.A.44, 4.B.1, 4.B.5) y g = gasto/PIB en la dinámica de la deuda: tolerable porque no conviven en la misma ecuación; si se quiere evitar, gasto público en Barro (1990) = G/L sin abreviar |
| γ_X | Tasa de crecimiento de X (γ_Y, γ_k…) | γ (3.A.44, 3.A.45, 4.B.1); γ^Y (3.A.39) | **γ_X** (subíndice) | Uniforme en crecimiento y en deuda |
| k, y | Capital y producto por trabajador eficiente (o por trabajador si no hay progreso técnico) | k_t, y_t | **k, y** con la definición explícita | — |
| v | Relación capital-producto (Harrod-Domar, acelerador) | v (3.A.34 acelerador, 3.A.43 Harrod); v = sensibilidad de la inversión al tipo (IS-LM en 3.A.4, 3.A.34, 3.A.37, 3.A.38, 4.B.4) | **v solo relación capital-producto** | 3.A.34 usa v con los dos sentidos en el mismo tema. La sensibilidad de la inversión pasa a **b** (Dornbusch-Fischer-Startz), véase IS-LM en `_notacion/pensamiento.md` |
| u | (Harrod) relación trabajo-producto; (Uzawa-Lucas) fracción del capital humano en producción | z (3.A.34) y u (3.A.43) para trabajo-producto | **u** en Uzawa-Lucas; **L/Y** sin abreviar en Harrod-Domar | Evita z/u para lo mismo |
| H, h | Capital humano (nivel, por trabajador) | — | **H, h** | — |
| η | Externalidad del capital (Lucas 1988) | η también participación del capital físico en la producción de capital humano (3.A.44); η probabilidad de Calvo (3.A.7, 3.A.36, 4.B.4) | **η** externalidad en Lucas; la participación del capital en Ḣ pasa a **α_H** | Dentro de 3.A.44 hay choque; con Calvo no conviven |
| M (variedades) | Número de variedades de bienes intermedios (Romer 1990) | M (3.A.44) | **N_t** | Romer y Acemoglu usan N (o A); M es dinero en todo el bloque monetario |
| τ | Tipo impositivo (proporcional) | τ (3.A.44, 4.B.1, 4.B.5); cotización (3.A.38, 4.B.3) | **τ** tipo; en OLG con pensiones, **τ** cotización (es un tipo sobre el salario: mismo concepto) | Coherente |

## Mercado de trabajo

| Símbolo | Significado | Alternativas (temas) | Canon | Motivo |
|---|---|---|---|---|
| w | Salario real (W nominal) | w (3.A.25); w_t (3.A.29); W_t (3.A.43, salario real) | **w** real, **W** nominal | 3.A.43 usa W_t para el salario real; el RBC (3.A.6) usa W_t real. Decidido: w real en todo el temario y W nominal (como en WS-PS) |
| O, O_0 | Ocio y dotación de tiempo | O, O₀ (3.A.25, 4.B.10) | **O, O₀** | Se mantiene |
| W̄ | Renta no laboral | M (3.A.25, 4.B.10) | **W̄** | Coherente con 3.A.8 (W̄ = renta monetaria exógena); M es dinero (3.A.35-3.A.41) y emparejamientos (DMP) |
| U, U^n | Tasa de paro y tasa natural | U, U_t, Ū, U^n | **U_t, U^n** | Ū (3.A.6) se abandona |
| V | Vacantes (tasa) | V | **V** | — |
| θ | Tensión del mercado de trabajo, θ ≡ V/U | θ (3.A.26) | **θ**, avisando del choque con la CRRA | Es la notación universal de la literatura de búsqueda (Pissarides 2000, Cahuc et al.); los temas de búsqueda (3.A.26, 3.A.28) no usan la CRRA.  |
| m(U,V) | Función de emparejamiento | M = A·U^α V^{1−α} (3.A.26) | **m(U,V)** | Libera M |
| f(θ) | Tasa a la que los parados encuentran empleo, f(θ)=m/U | λ(θ) (3.A.26) | **f(θ)** | λ es precio sombra (3.A.29, 3.A.43); f es la de Shimer, Blanchard y Pissarides (θq(θ)) |
| q(θ) | Tasa a la que se cubren las vacantes, q(θ)=m/V | μ(θ) (3.A.26) | **q(θ)** | Pissarides; μ queda para el margen (mark-up) |
| s | Tasa de separación (destrucción de empleo) | δ (3.A.26) | **s** (λ en Pissarides, q en Cahuc et al.) | δ es depreciación. Decidido: **s**, como Blanchard y Shimer (en 3.A.26 no hay tasa de ahorro) |
| μ | Margen sobre costes (mark-up) | μ (3.A.7, 3.A.28) | **μ** | — |
| e(w) | Esfuerzo (salarios de eficiencia) | e | **e(w)** | — |
| γ | Poder negociador del trabajador (Nash) | γ (3.A.27) | **γ** (dentro de 3.A.27) | Pissarides usa β (choca con descuento); γ choca con tasas de crecimiento y peso de la inflación en Barro-Gordon, pero no conviven. Canon: mantener γ en 3.A.27 |

## Dinero, inflación y política monetaria

| Símbolo | Significado | Alternativas (temas) | Canon | Motivo |
|---|---|---|---|---|
| M | Cantidad nominal de dinero (base monetaria en la restricción del gobierno) | M; M^S | **M** (M^S, M^D oferta y demanda) | — |
| V, k | Velocidad de circulación; k de Cambridge (k=1/V) | V, k (3.A.35) | **V, k** | Choque de k con capital por trabajador: tolerable (no conviven) |
| π_t | Inflación | π, π_t; ϑ (3.A.35 en el señoreaje) | **π_t** | Se elimina ϑ |
| π^e_t | Inflación esperada para t | π^e, π^e_t, E_t[π_{t+1}] | **π^e_t ≡ E_{t−1}[π_t]** (Phillips, Barro-Gordon, Lucas); **E_t[π_{t+1}]** (NEK) | Las dos formas son necesarias; se fija su equivalencia |
| i_t, r_t | Tipo nominal y tipo real | i, r (3.A.4 los mezcla) | **i** nominal, **r** real; r_t ≡ i_t − E_t[π_{t+1}] | — |
| r^n_t | Tipo de interés real natural (de equilibrio) | r^n_t (3.A.7, 3.A.37); r^n (3.A.36); r* (Taylor en 3.A.7, 4.B.4); ρ (3.A.36, 4.B.4) | **r^n_t** en la NEK; **r*** en la regla de Taylor original | En el modelo canónico sin shocks r^n = ρ; se dice una vez |
| x_t | Brecha de producción, x_t ≡ y_t − y^n_t (logs) | x_t (3.A.7, 3.A.36, 3.A.37, 4.B.4); ŷ_t (3.A.36 en la regla de Taylor); (y_t − y*) (3.A.7, 4.B.4) | **x_t** | Se elimina ŷ y se escribe y_t − y^n_t |
| η | Probabilidad de que una empresa no pueda revisar su precio (Calvo) | η (3.A.7, 3.A.36, 4.B.4); θ en Galí | **η** | Libera θ para la CRRA |
| κ | Pendiente de la curva de Phillips neokeynesiana (respecto a la brecha) | δ (3.A.7, 3.A.36, 3.A.37, 3.A.41) | **κ** | Galí, Clarida-Galí-Gertler, Walsh y Woodford usan κ; δ es depreciación |
| φ_π, φ_x | Coeficientes de la regla de Taylor | φ_π, φ_y (3.A.7, 3.A.36, 4.B.4); ϕ y 1 (sin coeficiente) en x_t (3.A.37, 3.A.38, 3.A.42) | **φ_π, φ_x** | Véase la ficha `taylor` |
| ν | Suavización del tipo de interés en la regla | ν (3.A.7, 3.A.37, 3.A.38, 3.A.42, 4.B.4) | **ν** (ρ_i en Galí) | Se mantiene: ρ es descuento |
| u_t, ε_t | Shock de costes en la NKPC; shock de política monetaria | e_t (NKPC), ε_t (Taylor) | **u_t** (NKPC), **ε_t** (Taylor) | e es esfuerzo; u_t como Clarida-Galí-Gertler (1999) |
| α (Phillips) | Respuesta del paro a la inflación sorpresa en Barro-Gordon, U_t = U^n − α(π_t − π^e_t) | α (3.A.6, 3.A.36, 3.A.41) | **α** (dentro de Barro-Gordon) | Se mantiene en el modelo; véase `phillips` para la forma general |
| a | Pendiente de la curva de Phillips ampliada, π_t = π^e_t − a(U_t − U^n) + ε_t | h (3.A.41); α implícita | **a** | h es la sensibilidad de la demanda de dinero al tipo en la LM |
| γ (B-G) | Peso de la inflación en la función de pérdida | γ (3.A.6, 3.A.36, 3.A.41) | **γ** | Se mantiene dentro del modelo |
| α, ζ (Cagan) | Semielasticidad de la demanda de dinero respecto a la inflación esperada; constante de escala | α, γ (3.A.35, 3.A.39, 3.A.41) | **α** semielasticidad y **ζ** constante | Cagan usa α; γ se libera (tasas de crecimiento) |
| S_t | Señoreaje real, (M_t − M_{t−1})/P_t; s_t en % del PIB | «Señoreaje»; s_t (4.B.26) | **S_t**, **s_t** | — |

## Sector público y deuda

| Símbolo | Significado | Alternativas (temas) | Canon | Motivo |
|---|---|---|---|---|
| G_t, T_t | Gasto (sin intereses) e ingresos impositivos nominales | T_t y Τ_t (tau mayúscula griega, 3.A.39) | **G_t, T_t** (T latina) | Errata de 3.A.39 |
| D_t | Deuda pública nominal a final de t | D_t | **D_t** (B_t en Walsh) | Se mantiene la del temario |
| g_t, τ_t, d_t, s_t | Ratios sobre el PIB: gasto, ingresos, deuda, señoreaje | g, τ, d (3.A.39, 4.B.26) | **g_t, τ_t, d_t, s_t** | τ_t = T_t/Y_t es el tipo medio: mismo concepto que el tipo impositivo |
| i_{t−1} D_{t−1} | Intereses pagados en t por la deuda emitida en t−1 | i_{t−1}D_{t−1} (3.A.39, 4.B.26); i_t D_{t−1} (3.A.35, 3.A.41, 3.A.39 en el señoreaje) | **i_{t−1} D_{t−1}** | Walsh (cap. 4): la deuda emitida en t−1 paga el tipo fijado al emitirla. Véase la ficha `restriccion-gobierno` |
| τ_t (Barro 1979) | Recaudación en nivel | τ_t «aquí es recaudación, no tipo» (4.B.9, 4.B.11) | **T_t** recaudación, **T_t/Y_t** el tipo medio | Evita que τ sea un nivel |

## Consumo e inversión

| Símbolo | Significado | Alternativas (temas) | Canon | Motivo |
|---|---|---|---|---|
| C_t / c_t | Consumo agregado / por persona | C_t (Hall) y c_t (Euler) en 3.A.33; C_t^J, C_{t+1}^V (3.A.38, 4.B.3); c_t^J (3.A.29); C₁, C₂ (4.B.9, 4.B.10) | **C_t** del individuo y agregado; **c** solo por trabajador eficiente en crecimiento; en OLG **C^J_t, C^V_{t+1}**; en Fisher **C_1, C_2** | Mayúscula para el consumo del hogar en todos los modelos de consumo |
| c | Propensión marginal a consumir (keynesiana) | c (3.A.4, 3.A.5, 3.A.33) | **c** | Choque con consumo por trabajador: no conviven |
| Y^P | Renta permanente | — | **Y^P** | — |
| P^K, r+δ | Precio del capital y coste de uso | P^K | **P^K**; coste de uso **c_K = P^K(r + δ − Ṗ^K/P^K)** | — |
| q_t | q de Tobin (marginal) | q_t | **q_t** | — |
| C(I) | Coste de ajuste de la inversión | C(I) (3.A.34) | **Φ(I_t, K_t)** | C es consumo; Romer usa C(I) pero en un capítulo sin consumo |

## Choques con otras áreas que se mezclan

- **σ**: elasticidad de sustitución CES (consumidor-producción, 3.A.8, 3.A.11) y desviación típica (finanzas, 3.B.23); σ no se usa para la CRRA ni la ESI en macro (θ y 1/θ), lo que evita el choque en los temas que mezclan ambos (3.A.29, 3.A.44 con Dixit-Stiglitz).
- **θ**: CRRA (macro), tensión del mercado de trabajo (3.A.26), probabilidad de Calvo en Galí (no se usa), función de puja (3.A.8). Con macro abierta: comprobar si NOEM (3.B.19, Corsetti-Pesenti) usa θ como elasticidad entre variedades.
- **δ**: depreciación aquí; en finanzas puede ser dividendo/delta de opciones; en el área pensamiento, factor exponencial del modelo β-δ.
- **v**: sensibilidad de la inversión en IS-LM (pensamiento y macro abierta, Mundell-Fleming): pasa a **b** también en macro abierta (Mundell-Fleming).
- **M**: renta no laboral (3.A.25), variedades (3.A.44), emparejamientos (3.A.26) → todos cambian; M solo dinero (y importaciones en macro abierta y contabilidad nacional, que no conviven con el dinero en la misma ecuación).
- **ρ**: descuento; persistencia de un AR(1) se escribe **ρ_A** (con subíndice).

Autor: Víctor Gutiérrez Marcos
