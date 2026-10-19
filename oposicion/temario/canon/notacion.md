# Notación canónica del temario

Un símbolo, un significado, en todo el temario. Consolidación inicial del canon (13 oct. 2026) a partir de las doce tablas de `_notacion/<área>.md`, que conservan el detalle (alternativas encontradas tema a tema y motivos). Este fichero manda: cuando difiere de una tabla de área es porque aquí se ha resuelto un choque entre áreas.

**Estado.** Notación **definitiva**. Víctor aprobó el 13/10/2026 todas las decisiones de `decisiones.json` (las de notación, con la opción recomendada); el id `Dnnn` de cada fila indica la decisión que la fijó. Lo que no lleva id es canon desde la consolidación: o es la notación del 3.A.8 revisado o es unánime en el temario y en los manuales. Los temas que se revisen la aplican tal cual; si un tema necesita un símbolo nuevo o cambiar uno, se propone el cambio al canon (`cambios.md`), no se inventa en el tema. Los cambios que los temas ya revisados deben recoger están en `pendientes-coherencia.md`. Decisiones del 16/10/2026 (Víctor): μ confirmado como multiplicador de la minimización del coste (§ 0 y § 3) y κ como factor de homogeneidad en los precios en todo el temario (§ 0, § 2 y § 3). No queda ninguna marca abierta. Con el 3.A.16 (17/10/2026) se fija la notación de la competencia perfecta en equilibrio parcial (§ 4: $p^D(x)$ y $p^S(q)$ en todo el tema, $U_i=n_i+\phi_i(x_i)$, índices $i$ y $j$, $q^{\mathrm{CP}}$/$q^{\mathrm{LP}}$, $J^*$, $\overline{c}$ y $\overline{q}$, telaraña, $p_c$/$p_v$); las decisiones D6, D7 y D10 de esa revisión las aplicó el coordinador y están pendientes de que Víctor las confirme en el artifact de dudas. Con el 3.A.17 (17/10/2026) se fija la notación del monopolio y de sus desarrollos (§ 4: $x(p)$ y $q=x(p)\Leftrightarrow p=p(q)$, $q^M$, $p^M$, $q^c$, $p^c$, $\varepsilon_{q,p}$, $\mathcal{L}$ como `\funcionclave`, PIE, tipos $t_1<t_2$ con proporción $\pi$, $T(q)=A+p\,q$, $p_v=b$ y $p_p=b+\beta$, λ en Ramsey-Boiteux y en Laffont-Tirole, μ en Averch-Johnson; monopsonio y monopolio bilateral con $w_L(L)$, $\varepsilon_{L,w_L}$, $L^M$, $w^M$, $w^S$, $w^c$, $v(L)$, $U_S$ y γ), la regla de que **la lagrangiana no se escribe 𝓛 donde está el índice de Lerner** (§ 0) y las siglas VPMg, IPMg y GMg (§ 0; decisión D8 de esa revisión, aplicada por el coordinador y pendiente de que Víctor la confirme en el artifact de dudas). Con el 3.A.13 (19/10/2026) se fija la notación de la información asimétrica (§ 4: tipos A/B en redonda como mnemónicos de alto y bajo, ν proporción del tipo bueno, π_A > π_B, Spence con y, c_A(y), w_A, w_B, principal-agente con x_E > x_F, w(x), π(e), e^A, e^B, v(e), U^R, λ_1 y λ_2 para la PC y la IC, principal neutral en el cuerpo y u_P solo en los anexos, Stiglitz-Weiss con 𝔼[B_banco] = (1 + r̂)·Pr(repago | r̂)) y, compartida con el 3.A.10, la del seguro (§ 2: **γ** prima por euro asegurado, que sustituye a la r local, y **A** = (W̄, W̄ − L) la dotación sin seguro); las decisiones D5-D7 de esa revisión las aplicó el coordinador y están pendientes de que Víctor las confirme en el artifact de dudas. Con el 3.A.10 (19/10/2026) se fija la notación de la elección con riesgo e incertidumbre (§ 2: lotería x̃ ≡ (x_1,…,x_S; π_1,…,π_S) con los resultados delante, conjunto de loterías 𝓛, peso de la mezcla τ, U(x̃) = 𝔼[u(x̃)] como `\funcionclave`, ξ, ρ, r_A, r_R, θ con ESI = 1/θ, a de la CARA, b de la cuadrática, η_0 y η_1 de la HARA, prudencia −u‴/u″ sin símbolo en el cuerpo, F y G distribuciones, π⃗ y 𝒫 previos múltiples, V = Σ w(π_s) v(x_s − r) con β, λ y δ, y el seguro de Mossin con γ y A, que ya fijó el 3.A.13); no deja decisiones de notación abiertas.

Manuales de referencia por área: Mas-Colell, Whinston y Green (MWG); Varian; Jehle y Reny (consumidor, producción, equilibrio general); Tirole, Gibbons (mercados y juegos); Romer, Blanchard y Fischer, Galí, Walsh, Sala i Martín, Acemoglu (macro); Krugman, Obstfeld y Melitz, Obstfeld y Rogoff, Gandolfo, Sarno y Taylor (macro abierta); Feenstra, Fujita-Krugman-Venables (comercio); Brealey-Myers, Bodie-Kane-Marcus, Hull, Freixas-Rochet (finanzas); Stiglitz, Rosen, Atkinson-Stiglitz, Mueller (sector público).

Autor: Víctor Gutiérrez Marcos

## 0. Convenciones generales

- **Micro**: minúsculas para precios y cantidades (p, x, q, w, z); mayúsculas para funciones de valor (U, V, E, C) y conjuntos (B(p,W̄)). Superíndices 0 y 1 para dos situaciones (x⁰, p¹, Ū⁰); subíndice i para bienes, j para empresas. **En equilibrio parcial y general, i son los consumidores** (i = 1,…,I) y j las empresas (j = 1,…,J), como MWG: el 3.A.16 tiene un solo bien y el numerario, y el 3.A.21 indexa los bienes con k (§ 4 y § 5; 3.A.16, 17/10/2026).
- **Macro**: mayúsculas para niveles agregados (Y, K, L, C, I, G, T, D, M); minúsculas para valores por trabajador o por unidad de trabajo eficiente (y, k, c) y para logaritmos en los modelos log-linealizados (se dice en cada tema).
- Superíndice ⁿ para el valor natural (y^n, U^n, r^n); asterisco para el **extranjero** en economía abierta (i*, P*, Y*) y para objetivos y óptimos fuera de ella (π*, U*, t*). Barra para valores exógenos o fijos (W̄, Ū, L̄, Ē).
- Tasas de crecimiento: γ_X ≡ Ẋ/X (D012). Tiempo discreto con subíndice t; continuo con punto. Excepción: en el álgebra de Jones del 2×2 (Stolper-Samuelson, Rybczynski; comercio y anexo E del 3.A.21) la tasa de variación se escribe con circunflejo, x̂ ≡ dx/x, como en Jones (1965) y Feenstra; en ese apartado el circunflejo no se usa para nada más (3.A.21, 14/10/2026).
- Esperanza: **𝔼[·]** (𝔼_t[x_{t+1}]); expectativa de x_t formada en t−1: x^e_t ≡ 𝔼_{t−1}[x_t]. La E latina queda para la función de gasto y el tipo de cambio.
- Elasticidades: **ε** con dos subíndices y con su signo; |ε| en las reglas de margen (D047). ϵ (lunada) solo para la aversión a la desigualdad de Atkinson (D081). Con poder de mercado (3.A.17, 17/10/2026), ε_{q,p} = (dq/dp)(p/q) < 0 es la elasticidad de la demanda a la que se enfrenta la empresa (el monopolista vende q = x(p)), con |ε_{q,p}| en el índice de Lerner; ε_{q_k,p_k} la del grupo k (3.er grado), ε_{q_j,p_i} la cruzada (multiproducto) y ε_{L,w_L} > 0 la de la oferta de trabajo (monopsonio). En competencia perfecta, con un solo precio y la oferta y la demanda a la vez, ε_D y ε_S (§ 4; 3.A.16): es la misma curva de demanda, con la notación que pide cada tema (el 3.A.17 necesita varias elasticidades cruzadas y por grupos).
- Multiplicadores de Lagrange y precios sombra: **λ** (λ_k si hay varios) (D020). **La lagrangiana no se escribe 𝓛 donde está el índice de Lerner** (3.A.17, 17/10/2026): en los temas que escriben 𝓛 ≡ (p − CMg)/p (3.A.17, 3.A.18, 3.A.19, 3.A.20, 3.B.7, 4.B.8) se escribe el problema penalizado sin letra (EC(p⃗) + (1+λ)B(p⃗) en Ramsey-Boiteux; I − w_Kz_K − w_Lz_L − μ[I − w_Lz_L − s z_K] en Averch-Johnson) o, si hay que nombrarla, **Λ**. En los demás temas 𝓛 sigue siendo la lagrangiana (𝓛, 𝓛^P, 𝓛^D en 3.A.8, 3.A.9, 3.A.12 y 3.A.16, que no escriben el índice de Lerner con símbolo). **En el 3.A.10, 𝓛 es el conjunto de loterías** (MWG § 6.B), local: el tema no escribe lagrangianas (el seguro se resuelve sustituyendo S y los demás problemas, con la condición de primer orden directa) ni el índice de Lerner (19/10/2026). **Excepción en la teoría de la producción: λ es el factor de escala**, F(λz) = λ^k F(z), y ε_{q,λ} la elasticidad de escala (Víctor, 13/10/2026: es la notación a la que están acostumbrados los opositores y t se confunde con el tiempo, que en el mismo tema sale en A_t). Donde conviven escala y multiplicador (empresa, 3.A.12), el multiplicador de la minimización del coste es **μ** (μ* = ∂C(w⃗,q)/∂q = CMg), como el del dual del consumidor (3.A.9, μ* = ∂E/∂Ū): propuesto en la revisión del 3.A.12 (14/10/2026) en lugar del λ^C que fijaba este canon y **confirmado por Víctor el 16/10/2026**. Factor de homogeneidad en los precios: **κ > 0 en todo el temario** (Víctor, 16/10/2026), x⃗(κp⃗,κW̄) = x⃗(p⃗,W̄), h⃗(κp⃗,Ū) = h⃗(p⃗,Ū), E(κp⃗,Ū) = κE(p⃗,Ū), C(κw⃗,q) = κC(w⃗,q); **k queda solo como grado de homogeneidad** (F(λz⃗) = λ^kF(z⃗)) y nunca θ (CRRA) ni λ (escala y multiplicador). Única excepción, local: en el 3.A.21 el factor de homogeneidad es α, z⃗(αp⃗) = z⃗(p⃗), porque allí κ_k es la velocidad del tanteo en el mercado k. En el 3.A.16, κ > 0 es también la velocidad del ajuste walrasiano lineal en su único mercado, ṗ = κz(p) (el mismo papel que κ_k); allí no hay factor de homogeneidad con letra (la normalización del numerario del anexo D se dice de palabra), así que no chocan (17/10/2026). Peso de una combinación convexa en las definiciones de convexidad y cuasiconcavidad: **τ ∈ [0,1]**, τy + (1−τ)y′; el mismo τ es el **peso de la mezcla de loterías**, τx̃¹ + (1 − τ)x̃², en los axiomas de continuidad (τ ∈ [0,1]) e independencia (τ ∈ (0,1)) de la utilidad esperada (3.A.10, 19/10/2026; nunca p ni ⊕).
- **Vectores con flecha** (Víctor, 13/10/2026): x⃗, p⃗, z⃗, y⃗, w⃗, h⃗(p⃗,Ū), también la dotación ω⃗_i y el exceso de demanda z⃗(p⃗) (`\vect{x}` en LaTeX = `\vec{x}`). Sus componentes y los escalares, sin flecha (x_i, p_1, W̄, Ū). Se aplica a todos los temas, empezando por los ya revisados.
- **Marshalliana y hicksiana** (Víctor, 13/10/2026): x⃗(p⃗,W̄) es siempre la marshalliana y h⃗(p⃗,Ū) la hicksiana; nunca x^h ni x^c. Cuando se derivan, se escriben con sus argumentos para que no se mezclen: ∂x_i(p⃗,W̄)/∂p_j = ∂h_i(p⃗,Ū)/∂p_j − x_j(p⃗,W̄)·∂x_i(p⃗,W̄)/∂W̄, y la identidad h⃗(p⃗,Ū) ≡ x⃗(p⃗,E(p⃗,Ū)). En los gráficos, la marshalliana en morado y la hicksiana en verde, rotuladas x_i(·) y h_i(·).
- Siglas de magnitudes en castellano y en redonda: CMg, CMe, CVMe, CFMe, CV, CF, IMg, PMg, PMe, RMS, RMST, RMT, EC, EP, ET, EG, VC, VE, ΔEC, EfT, EfA, EfE. **También dentro de las fórmulas**: en LaTeX, `\mathrm{VC}`, `\mathrm{VE}`, `\Delta\mathrm{EC}`, `\mathrm{EG}`, `\mathrm{CMg}`, `\mathrm{PMg}_L`, `\mathrm{RMST}_{LK}`, `\mathrm{RMS}_{12}` (no $VC$ ni $CMg$ en cursiva, que se leen como productos de letras); fijado con el 3.A.9 (13/10/2026) para las del bienestar y aplicado por el 3.A.12 (14/10/2026) a las de producción y costes. Los subíndices y superíndices que son palabras o siglas, también en redonda: $\mathrm{CMe}_{\mathrm{CP}}$, $\mathrm{CMe}_{\mathrm{LP}}$, $z_i^{\mathrm{LP}}$, $C^{\mathrm{obs}}$, $Q^{\mathrm{ac}}$ (**CP** corto plazo, **LP** largo plazo). **Equilibrio general** (3.A.21, 14/10/2026): **EGC** es el equilibrio general competitivo y **MEGC** los modelos de equilibrio general computable (CGE en inglés); **nunca «EG»** para el equilibrio general, que es el exceso de gravamen. OD (curva de oferta-demanda de la caja de intercambio) en redonda: $\mathrm{OD}_A$. **Mercados de factores con poder de mercado** (3.A.17, 17/10/2026; D8 de esa revisión, provisional hasta que Víctor la confirme): $\mathrm{VPMg}_L=p\cdot\mathrm{PMg}_L$ (valor del producto marginal), $\mathrm{IPMg}_L=\mathrm{IMg}\cdot\mathrm{PMg}_L$ (ingreso del producto marginal) y $\mathrm{GMg}_L=w_L(L)+w_L'(L)\,L$ (gasto marginal del factor), con el subíndice del factor; se definen en palabras la primera vez. Si Víctor prefiere no crear siglas, se escribe $p\cdot\mathrm{PMg}_L$ e $\mathrm{IMg}\cdot\mathrm{PMg}_L$. Los temas que solo dicen «valor del producto marginal» en palabras (3.A.11, 3.A.12) no tienen que cambiar. **PIE**: pérdida irrecuperable de eficiencia en general (monopolio, monopsonio; triángulo de Harberger, 3.A.17); con un impuesto se llama **exceso de gravamen, EG** (3.A.16, 4.B.9). $\mathrm{PC}_i$, $\mathrm{IC}_i$: restricciones de participación y de compatibilidad de incentivos del tipo $i$ (autoselección, 3.A.17; 3.A.13); PC e IC sin subíndice en el principal-agente (3.A.13), también en redonda dentro de las fórmulas. «IC» también para la condición de no escaqueo de Shapiro-Stiglitz cuando se relaciona con el principal-agente (3.A.27, 3.A.7). RMSE: relación marginal de sustitución entre estados (estocástica), en redonda. SMI: salario mínimo interprofesional.
- **Multiplicador del problema dual del consumidor (minimización del gasto): μ** (Víctor, 13/10/2026: como en el tema original), con μ* = ∂E/∂Ū = 1/λ* en el óptimo común (coste marginal de la utilidad). Uso local del dual del consumidor: en el resto del canon μ es el margen y las creencias, que no salen en estos temas. En la empresa (3.A.12), el multiplicador de la minimización del coste es también **μ** (confirmado por Víctor el 16/10/2026; antes λ^C): 𝓛 = w⃗·z⃗ + μ(q − F(z⃗)), w_i/PMg_i = μ, μ* = ∂C/∂q = CMg (coste marginal de producir, el análogo del coste marginal de la utilidad). El 3.A.12 cita el margen μ de los temas de mercados solo con remisión, sin fórmulas: no conviven.

## 1. Choques entre áreas resueltos

| Letra | Significado canónico | Otros usos que se eliminan o se acotan | Decisión |
|---|---|---|---|
| **W** | W̄: renta o riqueza exógena del consumidor (también riqueza inicial en riesgo y seguros, y renta no laboral); W(·): función de bienestar social, siempre con argumentos; W: salario nominal en macro (WS-PS); W = M + B + EB*: riqueza en Branson (local) | Salario en micro → w_L; bienestar del regulador → ET; renta no laboral M o V → W̄ | D002, D026 |
| **V** | V(p,W̄): función indirecta de utilidad; V(q): conjunto de requerimientos de factores (producción, siempre con argumento q; 3.A.11); V: vacantes (mercado de trabajo); V: velocidad del dinero; V_E, V_D: valores en finanzas (con subíndice) | Utilidad esperada → U; renta no laboral → W̄ | D002 |
| **E** | E(p,Ū): función de gasto (micro); E: tipo de cambio nominal directo (macro abierta). No conviven | Esperanza → 𝔼; educación (Spence) → y; éxito → resultado x_E (subíndice E en redonda) y su probabilidad π(e); puntos de equilibrio en gráficos (E₀, E₁: se admiten) | D013, D129 |
| **σ** | Elasticidad de sustitución (CES, Dixit-Stiglitz, NEG); desviación típica (finanzas, Lucas); σ_t dispersión en la σ-convergencia | CRRA y ESI → θ y 1/θ | D001, D034 |
| **θ** | Coeficiente de aversión relativa al riesgo (CRRA); ESI = 1/θ. Excepciones avisadas: θ ≡ V/U (búsqueda, 3.A.26, 3.A.28) y θ_ij participaciones en beneficios (dos subíndices) | η (3.A.8), σ (3.A.42, KPR/GHH), Frisch (GHH) → φ, puja de Rosen → Θ, tipos de jugador → t_i, extracción de señal de Lucas → ω, tipo impositivo (4.B.11) → t | D001, D056, D006, D104, D036 |
| **δ** | Tasa de depreciación (δ_K, δ_H si hay dos capitales). Excepción avisada: δ factor exponencial del modelo β-δ de Laibson. Locales del 3.A.10 (19/10/2026), que no tiene depreciación: δ parámetro de la función de ponderación de Tversky y Kahneman (1992), w(π) = π^δ/[π^δ + (1 − π)^δ]^{1/δ}, δ ≈ 0,61 y 0,69 (II.2; se eligió δ y no el γ de la fuente para no chocar con la prima del seguro), y δ_x lotería degenerada que da x con certeza (MWG; solo en el anexo E.4, Allais) | Pendiente de la NKPC → κ; separación → s; tasa social de descuento → r_s; TPT → ρ | D008, D105 |
| **φ** | Inversa de la elasticidad de Frisch (macro); productividad de la empresa (Melitz); φ_π, φ_x coeficientes de Taylor (con subíndice); φ(z;B) oferta de Rosen (local); φ proporción de Cambridge en el equilibrio general con dinero, M^D(p⃗) = φ p⃗·Σ_iω⃗_i (local del 3.A.21, III.3, porque allí k es el índice de los bienes; en macro, k de Cambridge, § 8) | Función de reacción → R_A(q_B); peso de los inputs (Corden) → a_ij; sensibilidad del saldo comercial → ν; desplazamiento de la inversión (4.B.6) → ϕ | D004, D016, D109 |
| **M** | Cantidad nominal de dinero (M^S, M^D); importaciones en contabilidad nacional y macro abierta (no conviven con el dinero en la misma ecuación) | Renta no laboral → W̄; variedades de Romer → N_t; emparejamientos → m(U,V); multiplicador monetario → la notación de la ficha `multiplicador-monetario` | D023, D002 |
| **B / π** | B: beneficio (B_j, B(p,w)); π: inflación (macro) y probabilidad (micro: π_s, π(e); proporción de tipos bajos en la autoselección del 3.A.17, con 1 − π los altos; en Laffont-Tirole, la probabilidad del tipo eficiente es ν, como en la fuente, local del anexo A); B(p,W̄): conjunto presupuestario (con argumentos); B, B*: bonos en Branson (local); B(G): beneficio social del gasto (4.B, local). **En el 3.A.13 (19/10/2026)** π es la probabilidad de accidente (π_A > π_B, alto y bajo riesgo; π̄ la media) y de éxito, π(e), así que la **proporción del tipo bueno es ν** (productivos en Spence, prudentes en Rothschild-Stiglitz), como la del tipo eficiente de Laffont-Tirole; el 3.A.17 conserva π para la proporción de tipos bajos de su 2.º grado (no hay probabilidades en ese apartado). En el anexo A del 3.A.13, π_A ≡ π(e^A) y π_B ≡ π(e^B) abrevian la probabilidad de éxito (no conviven con los de Rothschild-Stiglitz) | Beneficio π o Π → B; probabilidades p_s → π_s; saldo presupuestario B → b | D003, D017, D029 |
| **e** | Logaritmo del tipo de cambio nominal (e = ln E); esfuerzo e (información asimétrica) | Dotación → ω; coeficiente de efectivo → notación de `multiplicador-monetario`; tipo de cambio real → q; tipo sombra o fijo → Ẽ, Ē | D013, D045, D015 |
| **λ** | Multiplicador y precio sombra (μ el del dual del consumidor y el de la minimización del coste, § 0); λy (λ ∈ [0,1]) en la divisibilidad del conjunto de producción, que es escala; λ local en Laffont-Tirole (coste de los fondos públicos) y en Kahneman-Tversky (aversión a las pérdidas); λ_i cuota de manufacturas en la NEG (FKV); en el 3.A.16, λ es el multiplicador de la maximización del excedente total, λ* = p* (precio sombra del bien, 1TFEB en equilibrio parcial), y la escala solo aparece como nombre de ε_{q,λ} en una nota: no conviven en una ecuación (17/10/2026). **En el 3.A.17 (17/10/2026), λ es el multiplicador de B ≥ 0 en Ramsey-Boiteux (II.2.3) y el coste sombra de los fondos públicos en Laffont-Tirole (anexo A) y en la subvención del primer óptimo: es la misma idea (el valor social de un euro más de presupuesto) y da el mismo número de Ramsey λ/(1+λ) (Laffont y Tirole, 1993, cap. 3), así que conviven en el mismo tema, con una nota que lo dice**; ya no se propone μ para el multiplicador de Ramsey. **λ_1 y λ_2**, multiplicadores de la PC y de la IC del principal-agente (3.A.13, 19/10/2026; también λ_1, λ_2 en el enfoque de primer orden del anexo A) | Escala → λ en producción (D101′); peso de una combinación convexa → τ (§ 0); multiplicador de costes λ^C → μ (3.A.12; confirmado el 16/10/2026); tasa de encontrar empleo → f(θ); persistencia de la histéresis → λ_h | D020 |
| **β** | Factor de descuento β ≡ 1/(1+ρ); coeficientes de regresión (β_0, β_1, con subíndice); β_i del CAPM; β movilidad del capital en la BP; β de MRW (elasticidad del capital humano); locales del 3.A.17: β coste de capacidad en la tarifa de punta y valle (p_p = b + β, Boiteux-Steiner, ficha `tarifa-dos-partes`) y β parámetro de ineficiencia de Laffont-Tirole (C = β − e), en apartados distintos del factor de descuento de la nota del aprendizaje (II.3.1); local del 3.A.10 (19/10/2026): β ≈ 0,88 curvatura de la función de valor de la teoría de las perspectivas, v(z) = z^β y −λ(−z)^β (Tversky y Kahneman, 1992, escriben α y β: α es en el 3.A.10 la inversión en el activo con riesgo y el coeficiente de Hurwicz); el 3.A.10 no tiene descuento | Respuesta de la producción en Lucas → ψ; ponderaciones del ITC → ω_i; grado de apertura (3.B.9) → (X+M)/Y, sin símbolo | D036, D044, D107 |
| **γ** | Tasa de variación γ_X; peso de la inflación en la pérdida de Barro-Gordon; poder negociador (Nash, 3.A.27; también en el monopolio bilateral del 3.A.17, con exponente γ para el oferente, el sindicato, y 1 − γ para el comprador: (U_S − U_S^0)^γ(B − B^0)^{1−γ}); γ ∈ (0,1] coeficiente de las expectativas adaptativas de Nerlove, p^e_t = p^e_{t−1} + γ(p_{t−1} − p^e_{t−1}) (local del anexo E del 3.A.16, 17/10/2026; propuesto para 3.A.5 si escribe expectativas adaptativas); **γ prima por euro asegurado** en el seguro, x_1 = W̄ − γS, x_2 = W̄ − L + (1 − γ)S, prima justa γ = π (3.A.10 y 3.A.13, 19/10/2026; sustituye a la r local, que chocaba con el tipo de interés y con r̂ del mismo tema; no convive con otros γ en esos apartados) | Peso de las manufacturas en la NEG → μ; constante de Cagan → ζ | D012, D019, D061, D106 |
| **g** | Tasa de progreso técnico; g = G/Y en sector público | Crecimiento del PIB → γ_Y («r − g» solo como nombre del debate); tasa m del anexo de 3.A.43 → g | D010 |
| **ρ** | Tasa de descuento (preferencia temporal), también la de cada parte en la negociación de Rubinstein (ρ_S, ρ_B; γ = ρ_B/(ρ_S + ρ_B) en el límite de Binmore, Rubinstein y Wolinsky: 3.A.17, propuesta para 3.A.14 y 3.A.27); ρ = (σ−1)/σ dentro de la CES (avisado); prima de riesgo dentro de 3.A.10 (avisado) | Prima de riesgo de mercado en finanzas → λ_M o sin símbolo; persistencia AR(1) → ρ_A | — |
| **η** | Externalidad del capital (Lucas, 1988); probabilidad de Calvo de no revisar el precio; η_0, η_1 parámetros de la HARA, 1/r_A(x) = η_0 + η_1x (local del 3.A.10, con subíndice) | CRRA → θ; participación del capital en Ḣ → α_H; sensibilidad cíclica del saldo → ε | D131, D029 |
| **μ** | Margen sobre el coste marginal (σ/(σ−1) en micro y NEK); peso de las manufacturas en la NEG; creencias (juegos bayesianos); crecimiento del crédito interno (Krugman 1979, local); multiplicador del dual del consumidor (3.A.9) y de la minimización del coste (3.A.12, confirmado el 16/10/2026), locales de los temas de dualidad; constante de normalización μ ≡ Σ_l max{0, p*_l + κ_lz_l(p⃗*)} en la demostración de la existencia (local del anexo B del 3.A.21); multiplicador de la restricción de rentabilidad de Averch-Johnson, 0 < μ < 1 (anexo A del 3.A.17, ficha `averch-johnson`; el 3.A.17 no escribe el margen μ) | Tasa de cubrir vacantes → q(θ); multiplicador de costes λ^C → μ (16/10/2026) | D019, D020; 3.A.9, 3.A.12 |
| **v** | Relación capital-producto (acelerador, Harrod-Domar); v(T) función característica, v_i valoraciones, v(e) desutilidad del esfuerzo (con argumento o subíndice); v(L) desutilidad agregada del trabajo, con v'(L) = w_L(L) (sindicato del monopolio bilateral, 3.A.17; propuesta para 3.A.27). En Laffont-Tirole, la desutilidad del esfuerzo es ψ(e), como en la fuente (local del anexo A del 3.A.17, ficha `laffont-tirole`) | Sensibilidad de la inversión al tipo → b | D009 |
| **t / τ** | t: tipo impositivo en micro, imposición e IS-LM (t_L, t_K, t_c…), unitario o *ad valorem* (se dice cuál; 3.A.16: p_c = p_v + t y p_c = (1+t)p_v); τ: tipo en macro dinámica y ratio T/Y; τ > 1 coste iceberg (comercio). En el 3.A.17, además de t impuesto (anotación de I.2), t_1 < t_2 son los tipos de consumidor de la autoselección (§ 4, D104) y t la transferencia de Laffont-Tirole (anexo A): no conviven en un mismo apartado | Recaudación → T; fracción de impacientes (Diamond-Dybvig) → π | D007, D064 |
| **w / r** | w: salario (real en macro, W nominal); w_L, w_K precios de los factores en producción y equilibrio general; w y r (renta del capital) en los 2×2 de comercio e incidencia; r: tipo de interés real (i nominal); r_f, r_E, r_D… rentabilidades en finanzas | W, R para precios de factores; r como precio del capital fuera de los 2×2 → w_K; r_s tasa social de descuento; r prima del seguro → γ (3.A.10, 3.A.13). r punto de referencia de la teoría de las perspectivas, v(x_s − r) (D017; local del 3.A.10, II.2, donde r_f y r̃ son las rentabilidades del activo seguro y del activo con riesgo de I.2.2: no conviven) | D011, D026, D063 |
| **p / P** | p: precio de un bien (micro, comercio, imposición, mercados); P: nivel de precios (macro), precio del bono y prima de la put (finanzas, Hull) | P_x, P(Q), P_C/P_V → p, p(Q), p_c/p_v; P como gasto total (4.B.1) | D046, D108 |
| **q** | Producción de la empresa (micro); q de Tobin; tipo de cambio real (macro abierta); q(θ) tasa de cubrir vacantes. No conviven | ϰ → q | D015 |
| **L** | Trabajo; L pérdida en seguros (ℓ trabajo si conviven); L = V_D/V peso de la deuda (finanzas); L valor de liquidación (Diamond-Dybvig). En el monopsonio y el monopolio bilateral (3.A.17), L^M, L^c, L^* y L^S(w̲), L^D(w̲) (oferta y demanda al salario mínimo) | Índice de Lerner → 𝓛, que no convive con una lagrangiana 𝓛 (§ 0); 𝓛 conjunto de loterías (3.A.10, § 0 y § 2) | D059; 3.A.17; 3.A.10 |
| **U** | U(x): utilidad; U(x̃) = 𝔼[u(x̃)] utilidad esperada; u: utilidad de Bernoulli; U_i: utilidad marginal del bien i (3.A.8) y utilidad del individuo i en la elección social (no conviven); U_t, U^n: tasa de paro | — | D057 |
| **A** | A_t: productividad / PTF (macro); A: población activa (economía española; PTF escrita PTF si conviven); A, B: consumidores del 2×2×2×2 y países en comercio. **Seguros** (3.A.10, 3.A.13; 19/10/2026): A = (W̄, W̄ − L), punto de dotación sin seguro (en cursiva, sin subíndice). **Información asimétrica** (3.A.13): subíndices o superíndices A y B **en redonda** como mnemónicos de alto y bajo (productividad en Spence, riesgo en Rothschild-Stiglitz, esfuerzo e^A, e^B en el principal-agente); el 3.A.17 escribe t_1 < t_2 en el 2.º grado (no conviven) | — | D065; 3.A.13 (D5 de esa revisión, provisional) |
| **C** | C(w⃗,q): función de costes (micro; C(w⃗,q;z̄_K) a corto plazo, C(w⃗,q⃗) multiproducto, C^obs coste observado); C_t: consumo (macro); C: prima de la call (Hull); C(G) coste social del gasto | Coste de ajuste C(I) → Φ(I,K) | D130 |
| **κ** | Pendiente de la NKPC (macro); **factor de homogeneidad en los precios en todo el temario** (Víctor, 16/10/2026): x⃗(κp⃗,κW̄) = x⃗(p⃗,W̄), h⃗(κp⃗,Ū) = h⃗(p⃗,Ū), E(κp⃗,Ū) = κE(p⃗,Ū), C(κw⃗,q) = κC(w⃗,q) (k es solo el grado de homogeneidad); parámetro local de una función de producción (ejemplo *ultra passum* del 3.A.11); **κ_k > 0 velocidad de ajuste del tanteo en el mercado k**, ṗ_k = κ_kz_k(p⃗) (3.A.21; allí k es el índice de los bienes y, para no chocar con κ_k, el factor de homogeneidad es α, excepción local); **κ > 0 velocidad del ajuste walrasiano lineal en un mercado**, ṗ = κz(p) (3.A.16, que no escribe factor de homogeneidad). No conviven | θ o k como factor de homogeneidad → κ; k_i velocidad del tanteo → κ_k | 3.A.12 (14/10/2026); 3.A.21 (14/10/2026); Víctor (16/10/2026); 3.A.16 (17/10/2026) |
| **S** | S(p⃗,Ū) = D²_pE matriz de Slutsky; S(w⃗,q) = D²_wC matriz de sustitución de factores (3.A.12); S número de bienes del *netput* y⃗ ∈ ℝ^S (3.A.11; el 3.A.12 no le da dimensión para que no convivan); S número de estados de la naturaleza, s = 1,…,S (3.A.10, 3.A.21; por eso en el equilibrio general hay n bienes e y⃗_j ∈ ℝⁿ); 𝒮 coalición (caligráfica, 3.A.21; en juegos, T ⊆ N, § 4); S_t señoreaje; S_0, S_T subyacente (Hull) | Σ = [ς_kl] para la matriz de sustitución de C → S(w⃗,q) | 3.A.9, 3.A.12 |
| **z** | z⃗ = (z_L, z_K) factores (producción, 3.A.11-3.A.12); z(p) = x(p) − q(p) exceso de demanda de un mercado y z(p;α) con un parámetro de estática comparativa (3.A.16; nunca para p^D − p^S, que no lleva letra); z_k(p⃗) y z⃗(p⃗) excesos de demanda en el equilibrio general (3.A.21); z_j protección efectiva (comercio). No conviven: el 3.A.21 lo avisa en nota | Z_i, z_i (3.A.21 original) → z_k(p⃗) | 3.A.21 (14/10/2026); 3.A.16 (17/10/2026) |
| **Δ** | Δ = {p⃗ ∈ ℝⁿ₊ : Σ_kp_k = 1}, símplice de precios (3.A.21); delante de una magnitud, variación (ΔEC, ΔR); Δ ≡ [v(e^A) − v(e^B)]/[π(e^A) − π(e^B)] sola, local del principal-agente (3.A.13, II.2 y anexo A: premio por el éxito en utilidad que exige la IC saturada) | D (conjunto de Brouwer) → Δ | 3.A.21 (14/10/2026) |
| **α** | Participaciones y elasticidades (Cobb-Douglas: α, 1−α); semielasticidad de Cagan; locales del 3.A.10 (19/10/2026), en bloques distintos: α euros invertidos en el activo con riesgo (I.2.2, Arrow) y α ∈ [0,1] coeficiente de optimismo de Hurwicz (III.2); factor de homogeneidad en el equilibrio general, z⃗(αp⃗) = z⃗(p⃗), y parámetro genérico de la estática comparativa, z⃗(p⃗;α), también en un mercado: φ_i(x_i;α), C_j(q_j;α), z(p;α) y dp*/dα = −(∂z/∂α)/z'(p*) (3.A.16, 17/10/2026) (locales del 3.A.21: allí k es el índice y κ_k la velocidad del tanteo; es la única excepción al κ del § 0, Víctor, 16/10/2026) | — | 3.A.21 (14/10/2026) |
| **χ** | Peso de la desutilidad del trabajo (macro, con φ); sobrecoste de la ineficiencia X, C^obs = (1+χ)C (micro, 3.A.12); χ(w⃗,C̄) función de producción indirecta del dual estricto de Segura (local del anexo `anexo:segura` del 3.A.12) | — | D004; 3.A.12 |
| **Y / 𝒴 / y** | Y: producción o renta agregada; Y: segundo bien del 2×2; Y*: renta extranjera; 𝒴: conjunto de posibilidades de producción; y ∈ 𝒴: vector *netput* (micro de la producción; en macro, y es producción por trabajador; no conviven) | Y* como objetivo del Gobierno → Y^{obj} | D102, D038 |

## 2. Consumidor (3.A.8-3.A.10)

| Símbolo | Significado | Decisión |
|---|---|---|
| x = (x_1,…,x_n), p | Cesta y precios (vectores) | — |
| W̄ | Renta (y riqueza) del consumidor; renta no laboral | D002 |
| B(p,W̄) | Conjunto presupuestario walrasiano | — |
| ≿, ≻, ∼ | Preferencias (≿_i, ≿_G en elección social) | — |
| U(x), U_i | Utilidad y utilidad marginal del bien i | — |
| Ū, Ū⁰, Ū¹ | Nivel de utilidad dado | — |
| x(p,W̄) | Demanda marshalliana («también llamada ordinaria o walrasiana», una vez) | — |
| h(p,Ū) | Demanda hicksiana | — |
| V(p,W̄), E(p,Ū) | Función indirecta de utilidad y función de gasto | — |
| λ | Multiplicador del primal (utilidad marginal de la renta), λ* = ∂V/∂W̄ | — |
| μ | Multiplicador del dual (coste marginal de la utilidad), μ* = ∂E/∂Ū = 1/λ*; lagrangianas 𝓛^P = U(x⃗) + λ(W̄ − p⃗·x⃗) y 𝓛^D = p⃗·h⃗ + μ(Ū − U(h⃗)) | Víctor, 13/10/2026 |
| RMS_{12} = U_1/U_2 | Relación marginal de sustitución, positiva | — |
| s_i = p_ix_i/W̄ | Participación en el gasto | — |
| σ, a_i, ρ = (σ−1)/σ | Elasticidad de sustitución, pesos y parámetro de la CES | — |
| ε_{x_i,p_j}, ε_{x_i,W̄} | Elasticidades precio y renta | — |
| S_{ij} = ∂h_i/∂p_j; S(p,Ū) = [S_{ij}] = D²_pE(p,Ū) | Término y matriz de Slutsky (nunca s_{ij}, que choca con la participación s_i). Construida con observables: S_{ij}(p,W̄) = ∂x_i/∂p_j + x_j ∂x_i/∂W̄ (integrabilidad) | 3.A.9 (13/10/2026) |
| ε^h_{i,p_j} | Elasticidad-precio compensada (hicksiana): ε_{x_i,p_j} = ε^h_{i,p_j} − s_j ε_{x_i,W̄} | 3.A.8, 3.A.9 |
| κ (en x⃗(κp⃗,κW̄), h⃗(κp⃗,Ū), E(κp⃗,Ū) = κE(p⃗,Ū)) | Factor de homogeneidad en los precios, κ > 0, como en la empresa (§ 3): k queda solo como grado de homogeneidad (nunca θ, que es la CRRA, ni λ, que es la escala de la producción y el multiplicador). Antes k en el consumidor; κ en todo el temario por decisión de Víctor (16/10/2026) | 3.A.9 (13/10/2026); 3.A.12; Víctor (16/10/2026) |
| VC, VE, ΔEC | Variaciones compensatoria y equivalente, excedente; en redonda también en las fórmulas (§ 0). Convención de MWG: VC = W̄ − E(p¹,Ū⁰), VE = E(p⁰,Ū¹) − W̄, positivas si el bienestar mejora | — |
| m(p̄; p, W̄) ≡ E(p̄, V(p,W̄)) | Función de utilidad métrica monetaria (indirecta); VE y VC son sus diferencias con p̄ = p⁰ y p̄ = p¹ (μ en MWG: aquí no, μ es el margen) | 3.A.9 (13/10/2026) |
| EG = −VE − T | Exceso de gravamen (≥ 0) con la convención de signo de VE; T recaudación | 3.A.9, ficha `exceso-gravamen` |
| L ≡ W̄ − p¹·x⁰, P ≡ p⁰·x¹ − W̄ | Variaciones de Laspeyres y de Paasche (compensaciones de cesta fija): L ≤ VC y VE ≤ P. **Local** del 3.A.9 (L es trabajo y P el nivel de precios en otras áreas; no conviven) | 3.A.9 (13/10/2026) |
| I_K(p⁰,p¹;Ū) = E(p¹,Ū)/E(p⁰,Ū); I_L, I_P, I_F = √(I_L I_P), I_T | Índices de Konüs (verdadero; I_K(Ū⁰) versión VC, I_K(Ū¹) versión VE), Laspeyres, Paasche, Fisher y Törnqvist (ln I_T = Σ_i ½(s_i⁰ + s_i¹) ln(p_i¹/p_i⁰)). Ponderaciones de los índices estadísticos: ω_i (D044) | 3.A.9 (13/10/2026) |
| **Sistemas de demanda (letras locales del 3.A.9)** | LES (Stone-Geary): U(x) = Σα_i ln(x_i − γ_i), Σα_i = 1, γ_i mínimos de subsistencia. Rotterdam: s̄_i d ln x_i = b_i d ln Q + Σ_j c_{ij} d ln p_j, con b_i = p_i ∂x_i/∂W̄ y c_{ij} = p_ip_jS_{ij}/W̄ (no θ_i, π_{ij} de Theil: θ es la CRRA y π la inflación). Translog indirecta: ln V = α_0 + Σα_i ln(p_i/W̄) + ½ΣΣβ_{ij} ln(p_i/W̄) ln(p_j/W̄). AIDS: ln E = (1−Ū) ln a(p) + Ū ln b(p); s_i = α_i + Σ_jγ_{ij} ln p_j + β_i ln(W̄/P), ln P = ln a(p) (índice translog), P* índice de Stone (LA-AIDS). QUAIDS: término ϑ_i/b(p)·[ln(W̄/a(p))]², b(p) = Π p_k^{β_k}, Σϑ_i = 0 (ϑ, no λ_i de Banks-Blundell-Lewbel: λ es el multiplicador). Las letras α, β, γ son locales de cada sistema; P (índice de precios del AIDS) y P (variación de Paasche) no se mezclan en el mismo apartado | 3.A.9 (13/10/2026) |
| Θ(z;Ū,W̄), φ(z;B) | Funciones de puja y de oferta de Rosen | D006 |
| x̃ ≡ (x_1,…,x_S; π_1,…,π_S); x̃⁰, x̃¹, x̃² | Lotería (resultados delante, probabilidades detrás); varias loterías con superíndice, como las dos situaciones del 3.A.8; renta o riqueza aleatoria W̃, p̃, r̃, ỹ, B̃ con tilde (aleatoria). Nunca ỹ para la lotería genérica (original del 3.A.10). S estados s = 1,…,S; resultado x_s | 3.A.10 (19/10/2026) |
| 𝓛; τ | Conjunto de loterías simples (MWG; local del 3.A.10, § 0) y peso de la mezcla τx̃¹ + (1 − τ)x̃², τ ∈ [0,1] en la continuidad y τ ∈ (0,1) en la independencia (§ 0). Axiomas sobre 𝓛, nunca sobre ℝⁿ₊ | 3.A.10 (19/10/2026) |
| F(x), G(x); f(x) | Funciones de distribución de 2 loterías (dominancia estocástica: 1.er orden F ≤ G, 2.º orden ∫F ≤ ∫G) y densidad; U(x̃) = ∫u(x) dF(x) en el caso continuo (local del 3.A.10) | 3.A.10 (19/10/2026) |
| π_s | Probabilidad del estado s | D017 |
| V = Σ_s w(π_s) v(x_s − r); w(π), v(z), z = x_s − r; β, λ, δ | Teoría de las perspectivas: valor (`\funcionclave`; en el 3.A.10 no convive con la FIU V(p⃗,W̄)), ponderación de las probabilidades y función de valor respecto al punto de referencia r. Forma de Tversky y Kahneman (1992): v(z) = z^β si z ≥ 0 y −λ(−z)^β si z < 0, **β ≈ 0,88** (curvatura, local), **λ ≈ 2,25** (aversión a las pérdidas, local avisado en § 1); w(π) = π^δ/[π^δ + (1 − π)^δ]^{1/δ}, **δ ≈ 0,61/0,69** (local, § 1). Nunca π(p_s) para la ponderación ni α, γ para los parámetros. Otras teorías no esperadas: g (Quiggin, dependiente del rango) y h > 0 (Chew), locales | D017; 3.A.10 (19/10/2026) |
| u(·), U(x̃) = 𝔼[u(x̃)] | Utilidad de Bernoulli y utilidad esperada | — |
| r_A(x) ≡ −u″/u′, r_R(x) ≡ x r_A(x) | Aversión absoluta y relativa (Arrow-Pratt); r_R es la elasticidad de la utilidad marginal cambiada de signo. Aproximación ρ ≈ ½σ²r_A(W̄). Siglas CARA, DARA, IARA, CRRA, DRRA, IRRA, HARA. Nunca r_α, r_r | 3.A.10 (19/10/2026) |
| a; b; η_0, η_1 | Parámetro de la CARA, u = −e^{−ax}, r_A = a (en el contrato lineal del 3.A.13 se escribe directamente r_A porque a es allí el fijo del contrato: coherente); de la cuadrática, u = x − (b/2)x², x < 1/b; de la HARA, 1/r_A = η_0 + η_1x. Locales del 3.A.10. a, b también como constantes de la transformación afín a·u + b, a > 0 | 3.A.10 (19/10/2026) |
| −u‴/u″ (prudencia absoluta) | Coeficiente de prudencia de Kimball (1990), **sin símbolo en el cuerpo**; P(x) solo en el anexo E del 3.A.10 (P es Paasche y nivel de precios en otras áreas). Ahorro precautorio ⇔ u‴ > 0; DARA ⇒ prudencia | 3.A.10 (19/10/2026) |
| ψ (transformación de Pratt) | u_1 = ψ(u_2) con ψ creciente y cóncava en el teorema de Pratt (MWG prop. 6.C.2). **Propuesta de la fase canon del 3.A.10** (`pendientes-coherencia.md`): el 3.A.10 escribe hoy G, que choca con la función de distribución G de la dominancia del mismo apartado (I.1.2) | 3.A.10 (19/10/2026; pendiente) |
| θ, 1/θ | CRRA y ESI: u(x) = (x^{1−θ} − 1)/(1 − θ) (ln x si θ = 1), la misma ecuación en el 3.A.8 (C) y el 3.A.10 (x), con el −1; r_R = θ, r_A = θ/x; **ESI = 1/θ**, sin símbolo propio (nunca «σ = 1/θ») | D001; 3.A.10 (19/10/2026) |
| ξ | Equivalente cierto, u(ξ) = 𝔼[u(x̃)] (nunca EC, que es el excedente del consumidor; corregido en el contrato lineal del 3.A.13) | —; 3.A.13 (19/10/2026) |
| ρ ≡ 𝔼[x̃] − ξ | Prima de riesgo (local del 3.A.10, avisado en § 1: allí no hay descuento); prima actuarialmente justa (pérdida esperada) y prima máxima (W̄ − ξ = justa + ρ) | 3.A.10 |
| π⃗ = (π_1,…,π_S); 𝒫 | Vector de probabilidades (con flecha) y conjunto de distribuciones a priori de los previos múltiples, U(x⃗) = min_{π⃗∈𝒫} Σ_sπ_su(x_s) (Gilboa y Schmeidler, 1989; caligráfica, para no confundir con P de precios y Paasche). Actos de Savage x⃗ = (x_1,…,x_S), con flecha | 3.A.10 (19/10/2026) |
| ν (capacidad); μ, φ (ambigüedad suave) | Capacidad no aditiva de Choquet (Schmeidler, 1989) y, en Klibanoff-Marinacci-Mukerji, distribución μ sobre π⃗ y función φ de actitud ante la ambigüedad: locales de III.2 del 3.A.10 (ν es la proporción del tipo bueno en el 3.A.13 y μ el multiplicador del dual en el 3.A.8-3.A.9: no conviven) | 3.A.10 (19/10/2026) |
| α; r_f, r̃; p̃, B̃ | Activo con riesgo (Arrow): euros α invertidos, rentabilidades del activo seguro y del activo con riesgo; empresa aversa (Sandmo, 1971): precio y beneficio aleatorios, CMg(q*) < 𝔼[p̃] | 3.A.10 (19/10/2026) |
| u_s(x_s); p_s | Utilidad dependiente del estado (Karni) y precio de Arrow-Debreu del bien contingente del estado s; tangencia π_su′(x_s)/[π_{s′}u′(x_{s′})] = p_s/p_{s′}, la misma del 3.A.21 | 3.A.10, 3.A.21 |
| W̄, L, S, γ; x_1, x_2; A = (W̄, W̄ − L); RMSE | Seguros (3.A.10 y 3.A.13, misma notación y mismos ejes): riqueza inicial, pérdida, cobertura y **prima por euro asegurado γ** (antes r local); riqueza sin accidente x_1 (abscisas) y con accidente x_2 (ordenadas); lotería sin seguro (W̄, W̄ − L; 1 − π, π) y su punto **A**; recta de aseguramiento x_2 = W̄/γ − L − [(1 − γ)/γ]x_1, de pendiente −(1 − γ)/γ (nunca «−dx_2/dx_1 = −(1−r)/r»); RMSE = (1 − π)u'(x_1)/[πu'(x_2)], (1 − π)/π en la línea de certeza; prima justa γ = π, recargada γ > π, favorable γ < π; seguro completo en E (teorema de Mossin, 1968). Nunca W, P ni p para riqueza, pérdida o probabilidad | 3.A.10 y 3.A.13 (19/10/2026) |

## 3. Producción y costes (3.A.11-3.A.12)

| Símbolo | Significado | Decisión |
|---|---|---|
| z⃗ = (z_L, z_K); z̄_K | Factores (orden L, K); factor fijo a corto plazo | —; 3.A.12 |
| q, Q = Σq_j | Producción de la empresa y de la industria | — |
| F(z) | Función de producción (f intensiva en macro); F(z) ≡ max{q : (q,−z) ∈ 𝒴} | — |
| 𝒴 | Conjunto de posibilidades de producción | D102 |
| y = (y_1,…,y_S) ∈ 𝒴 ⊂ ℝ^S | Vector de producción neta (*netput*): componentes negativos, factores; positivos, productos; S bienes (no L, que es el trabajo) | 3.A.11 (13/10/2026) |
| V(q) = {z ≥ 0 : (q,−z) ∈ 𝒴} | Conjunto de requerimientos de factores (su frontera, la isocuanta) | 3.A.11 (13/10/2026) |
| T(y) ≤ 0; RMT_{12} = (∂T/∂q_1)/(∂T/∂q_2) | Función de transformación de la empresa multiproducto (frontera T(y) = 0) y su relación marginal de transformación, positiva. MWG la llama F; aquí F es la función de producción. Mismo sentido que T(X,G) = 0 en §5 | 3.A.11 (13/10/2026) |
| w = (w_L, w_K) | Precios de los factores | D011 |
| λ | Factor de escala: F(λz⃗) = λ^k F(z⃗) (antes t, D101; cambiado por Víctor el 13/10/2026). También la escala multiproducto, C(λq⃗⁰)/λ | D101′ |
| k | Grado de homogeneidad, y solo eso (nunca λ, que es la escala; el factor de homogeneidad en los precios es κ, § 0) | 3.A.11 (13/10/2026); Víctor (16/10/2026) |
| ε_{q,λ} | Elasticidad de escala (global: ε_{q,λ} = k en las homogéneas) | D101′ |
| ε_{q,λ}(z⃗) ≡ d ln F(λz⃗)/d ln λ \|_{λ=1} = Σ_i ε_{q,z_i} | Elasticidad de escala local (μ(z) en Jehle y Reny, que se cita solo en nota). En la combinación de mínimo coste, ε_{q,λ}(z⃗(w⃗,q)) = CMe/CMg = 1/ε_{C,q} **para cualquier tecnología** (Hanoch, 1975); la homoteticidad solo la extiende a toda la senda de expansión, que es un rayo | 3.A.11 (13/10/2026); 3.A.12 (14/10/2026) |
| ε_{q,z_i} = PMg_i/PMe_i | Elasticidad-producto del factor i | 3.A.11 (13/10/2026) |
| PMg_L, PMe_L; RMST_{LK} = PMg_L/PMg_K | Productividades y relación técnica, positiva | — |
| C(w⃗,q), C(q) | Función de costes, siempre con los precios delante (C(q) si w⃗ fijo; nunca C(q,w⃗) ni C_i(q_i,w⃗)) | — |
| z⃗(w⃗,q), z⃗(p,w⃗); q(p,w⃗) | Demandas condicionadas y no condicionadas de factores; oferta. Se distinguen por los **argumentos**, escritos siempre al derivar (misma regla que x⃗/h⃗, § 0); nunca h⃗ ni superíndices | —; 3.A.12 |
| B, B(p,w⃗) | Beneficio y función de beneficio: homogénea de grado uno y convexa en (p,w⃗), **no decreciente** en p (estrictamente creciente si q > 0) y **no creciente** en w⃗ (MWG prop. 5.C.1); D²B(p,w⃗) su hessiana, sin letra | D003; 3.A.12 |
| μ; μ* = ∂C(w⃗,q)/∂q = CMg | Multiplicador de la minimización del coste: 𝓛 = w⃗·z⃗ + μ(q − F(z⃗)), w_i/PMg_i = μ. Paralelo al μ del dual del consumidor (§ 2); antes λ^C. Confirmado por Víctor el 16/10/2026 | 3.A.12 (14/10/2026); Víctor (16/10/2026) |
| κ (en z⃗(κw⃗,q), C(κw⃗,q), B(κp,κw⃗)) | Factor de homogeneidad en los precios, el mismo κ del consumidor (§ 0 y § 2; k es el grado de homogeneidad de F: C(w⃗,q) = q^{1/k}c(w⃗)) | 3.A.12 (14/10/2026); Víctor (16/10/2026) |
| S(w⃗,q) = [S_{ij}] = D²_wC(w⃗,q), S_{ij} = ∂z_i(w⃗,q)/∂w_j | Matriz de sustitución de factores: simétrica, semidefinida negativa, S(w⃗,q)·w⃗ = 0⃗ (mayúscula, como la de Slutsky; nunca Σ ni ς) | 3.A.12 (14/10/2026) |
| c(w⃗) ≡ C(w⃗,1) | Coste unitario: C(w⃗,q) = q·c(w⃗) con rendimientos constantes, q^{1/k}c(w⃗) con homogéneas de grado k, φ(q)c(w⃗) con homotéticas (φ local) | 3.A.12 |
| C(w⃗,q;z̄_K) = CV(q) + CF | Coste a corto plazo (el factor fijo tras el punto y coma); coste variable y fijo; z_L(w⃗,q;z̄_K) | 3.A.12 (14/10/2026) |
| CMg, CMe, CVMe, CFMe; CMe_CP, CMe_LP | Costes marginal, medio, variable medio, fijo medio (nunca CTMe); a corto y a largo plazo (subíndices en redonda, § 0). A corto plazo: CMg = w_L/PMg_L, CVMe = w_L/PMe_L | 3.A.12 |
| ε_{C,q} = CMg/CMe; ε_{C,w_i} = s_i | Elasticidad del coste respecto a la producción (< 1: economías de escala) y respecto al precio de un factor | 3.A.12 (14/10/2026) |
| s_i = w_iz_i/C(w⃗,q) | Participación del factor i en el coste (mismo símbolo que la participación en el gasto, § 2; no conviven) | 3.A.11, 3.A.12 |
| ε_{z_i,q}, ε_{z_i,w_j}; σ_{ij} | Elasticidades de la demanda condicionada (ε_{z_i,w_j} = s_jσ_{ij}); elasticidad de sustitución de Allen-Uzawa (con dos subíndices; σ sola, la de Hicks del 3.A.11). Para la no condicionada, la derivada con sus argumentos | 3.A.11, 3.A.12 |
| Efecto sustitución + **efecto escala** | Nombres de los dos términos de la ecuación de Slutsky de los factores, ∂z_i(p,w⃗)/∂w_j = ∂z_i(w⃗,q)/∂w_j + [∂z_i(w⃗,q)/∂q]·∂q(p,w⃗)/∂w_j (nunca «efecto renta»; «efecto producción», una vez) | 3.A.12 (14/10/2026) |
| V*(q); 𝒴* | Tecnología recuperada de C (Shephard-Uzawa-McFadden) y de B (función soporte); coinciden con V(q) y 𝒴 si son convexos | 3.A.12 |
| C(Σ_jq_j) < Σ_jC(q_j); C(q_1,q_2) < C(q_1,0) + C(0,q_2) | Subaditividad (definición del monopolio natural) y economías de alcance | 3.A.12 |
| C^obs(w⃗,q) = (1+χ)C(w⃗,q), χ ≥ 0 | Coste observado con ineficiencia X (ficha `ineficiencia-x`) | 3.A.12 |
| EfT, EfA, EfE = EfT·EfA | Eficiencias técnica, asignativa y económica (en costes) de Farrell, en redonda (nunca ET, EA, EE: ET es el excedente total); EfE = C(w⃗,q)/C^obs = 1/(1+χ) | 3.A.12 (14/10/2026) |
| ln C_j^obs = ln C(w⃗_j,q_j) + v_j + u_j | Frontera estocástica de costes: v_j ruido, u_j = ln(1+χ_j) ≥ 0 ineficiencia, EfE_j = e^{−u_j}; DEA: proporción e y pesos τ_j (locales; θ en Coelli et al.) | 3.A.12 (14/10/2026) |
| Translog de costes | ln C = α_0 + α_q ln q + ½β_{qq}(ln q)² + Σα_i ln w_i + ½ΣΣβ_{ij} ln w_i ln w_j + Σβ_{iq} ln w_i ln q; s_i = α_i + Σ_jβ_{ij} ln w_j + β_{iq} ln q (letras locales, como las del 3.A.9 § 2); Leontief generalizada b_{ij} | 3.A.12 |
| Q^ac_t = Σ_{τ≤t}q_τ; c(Q^ac) = c_1(Q^ac)^{−b} | Producción acumulada y curva de aprendizaje (letras locales del 3.A.12) | 3.A.12 |
| A_t | Nivel tecnológico. Neutralidades (ficha `progreso-tecnico-neutral`): Hicks A_tF(z_K,z_L), Solow F(A_tz_K,z_L), Harrod F(z_K,A_tz_L) (orden (K, L) solo en estas tres fórmulas, como Romer y Acemoglu) | — |

## 4. Mercados, información y juegos (3.A.13-3.A.20)

| Símbolo | Significado | Decisión |
|---|---|---|
| p, p(q), p(Q) = a − bQ | Precio y demanda inversa cuando solo hay una (monopolio, oligopolio); en competencia perfecta, p^D(x) (fila siguiente) | —; 3.A.16 (17/10/2026) |
| x(p); q = x(p) ⇔ p = p(q), p'(q) < 0 | Monopolio (3.A.17): la demanda de mercado es x(p); el monopolista vende q = x(p) y trabaja con la inversa p(q). Nunca q^m(p) ni P(q) | 3.A.17 (17/10/2026) |
| q^M, p^M = p(q^M); q^c, p^c | Equilibrio del monopolio y competitivo de referencia (p(q^c) = CMg(q^c)) en los temas de poder de mercado (superíndices M y c en cursiva, como letras; no son siglas) | 3.A.17 (17/10/2026) |
| IMg(q) = p(q) + p'(q)q = p(1 − 1/\|ε_{q,p}\|); B(q) = p(q)q − C(q) | Ingreso marginal y beneficio del monopolista (`\optim{\max}{q}{B(q)=p(q)\,q-C(q)}{q\geq 0}`); I(q) = p(q)q ingreso total (local de los anexos) | 3.A.17 (17/10/2026) |
| x(p), q(p), z(p) = x(p) − q(p) | Demanda, oferta y exceso de demanda de mercado; en competencia perfecta, x(p) = Σ_ix_i(p) y q(p) = Σ_jq_j(p) | — |
| ε_D = (dx/dp)(p/x) < 0, ε_S = (dq/dp)(p/q) ≥ 0 | Elasticidades-precio de la demanda y de la oferta de mercado, con signo; \|ε_D\| en las fórmulas (reparto del impuesto, telaraña). Un solo subíndice porque solo hay un precio (§ 0: dos subíndices cuando hay varios) | D047; 3.A.16 (17/10/2026) |
| p^D(x), p^S(q) | Demanda y oferta inversas de mercado, **en todo el tema cuando conviven** (competencia perfecta), no solo en el ajuste marshalliano: p^D(x) es el precio al que se compra en total x (beneficio marginal social) y p^S(q) = q^{−1}(q) el precio al que se ofrece en total q (coste marginal de la industria). Equilibrio: p^D(x*) = p^S(q*) con x* = q*. Nunca P(x) ni C'(q) = P(q) | 3.A.21 (anexo D); 3.A.16 (17/10/2026, D6) |
| ṗ = f(z(p)), f' > 0, f(0) = 0 (lineal, ṗ = κz(p)); q̇ = g(p^D(q) − p^S(q)), g' > 0; a = dp^D/dq, b = dp^S/dq | Ajustes walrasiano (por precios; estable si z'(p*) < 0) y marshalliano (por cantidades; estable si d(p^D − p^S)/dq < 0) en un mercado; pendientes en el plano (q,p) para compararlos (Walras 1/a < 1/b, Marshall a < b). Ficha `tatonnement` | 3.A.21 (anexo D); 3.A.16 (17/10/2026) |
| p_t, q_t; p^e_t | Telaraña: precio y cantidad del periodo t y precio que esperaban los productores al decidir (convención x^e_t, § 0): ingenuas p^e_t = p_{t−1}; adaptativas p^e_t = p^e_{t−1} + γ(p_{t−1} − p^e_{t−1}); racionales p^e_t = 𝔼_{t−1}[p_t]. Lineal: x_t = a_0 − a_1p_t, q_t = b_0 + b_1p^e_t (letras locales del anexo E). Nunca P_t, Q_t. Ficha `telarana` | 3.A.16 (17/10/2026) |
| q_i, Q | Producción de la empresa i y de la industria (oligopolio) | — |
| U_i(n_i,x_i) = n_i + φ_i(x_i); n_i; W̄_i | Consumidor i del equilibrio parcial: utilidad cuasilineal (\phi), consumo de numerario n_i (precio 1; puede ser negativo, MWG 10.C), dotación de numerario W̄_i; φ_i'(x_i) = p y x_i(p) = (φ_i')^{−1}(p), demanda marshalliana sin efecto renta. El 3.A.8 escribe x_0 y U_h = x_0 + φ_h(x_1,…,x_n) en una nota con varios bienes indexados (allí i son los bienes): no conviven (D10, a confirmar por Víctor) | 3.A.16 (17/10/2026, D7, D10) |
| q_j, C_j(w⃗,q_j) = C_j(q_j), CMg_j, B_j = pq_j − C_j(q_j); q_j(p) | Empresa j en competencia perfecta (w⃗ fijo); oferta q_j(p), inversa del tramo creciente del CMg por encima del mínimo del CMe (sin costes hundidos) o del CVMe (a corto plazo). Nunca C_i(q̄_i,w⃗) ni q_j(w⃗,q̄) | 3.A.16 (17/10/2026) |
| J; J* | Número de empresas: fijo a corto plazo y a largo sin libre entrada; J* endógeno con libre entrada, J* = x(c̄)/q̄ (entero: MWG 10.F). J nunca es el número de bienes | 3.A.16 (17/10/2026) |
| q^CP(p), q^LP(p); q_j^CP, q_j^LP | Oferta de la industria (y de la empresa) a corto y largo plazo, superíndices en redonda (§ 0); Le Chatelier-Samuelson ∂q^LP/∂p ≥ ∂q^CP/∂p ≥ 0. Nunca Q(p) | 3.A.16 (17/10/2026) |
| C(q_j; q) | Coste de la empresa con economías (o deseconomías) externas: depende de la producción de la industria q (industria de costes constantes, crecientes, decrecientes) | 3.A.16 (17/10/2026) |
| B_i, Σ_t β^t B_{it} | Beneficio y beneficio intertemporal | D003 |
| c, CF | Coste marginal constante y coste fijo | D103 |
| c̄ = C(q̄)/q̄ = min CMe; q̄ (c̄_j, q̄_j) | Coste medio mínimo y escala mínima eficiente (MWG 10.F); con libre entrada y CMe en U, p* = c̄, q* = q̄ | 3.A.16 (17/10/2026) |
| 𝓛 ≡ (p − CMg)/p = 1/\|ε_{q,p}\| | Índice de Lerner y regla de la elasticidad inversa del monopolista (`\funcionclave` `eq:lerner` del 3.A.17, IMg = CMg ⇔ 𝓛 = 1/\|ε_{q,p}\|); 𝓛_k por grupos (3.er grado), 𝓛_i por bienes (multiproducto, con el término cruzado (p_j − CMg_j)q_jε_{q_j,p_i}/(p_iq_i\|ε_{q_i,p_i}\|)). Donde se escribe, la lagrangiana no lleva 𝓛 (§ 0) | D059; 3.A.17 (17/10/2026) |
| PIE ≈ ½\|ε_{q,p}\|𝓛²p^Mq^M = ½𝓛p^Mq^M | Pérdida irrecuperable de eficiencia del monopolio (triángulo de Harberger, 1954); = B/2 con demanda lineal, CMg constante y sin costes fijos. Con un impuesto, EG (fila p_c) | 3.A.17 (17/10/2026) |
| t_1 < t_2, π; t_iu(q) − T; (q_i, T_i); PC_i, IC_i | Discriminación de 2.º grado (autoselección, Maskin y Riley, 1984): tipos de consumidor (D104), proporción π de tipos bajos, valoración u(q) con u(0) = 0 (local: no es la utilidad de Bernoulli; en el 3.A.16 la cuasilineal es φ_i), pago total T, menú y restricciones; renta informativa (t_2 − t_1)u(q_1). Nunca θ_1, θ_2 ni λ para la proporción | 3.A.17 (17/10/2026) |
| T(q) = A + p q; A_i = EC_i(p); n_i | Tarifa en dos partes (Coase, 1946; Oi, 1971): cuota A, precio por unidad p; n_i número de consumidores del tipo i y n el de usuarios (A = CF/n). n_i es local: en el 3.A.16 es el numerario del consumidor i (no conviven) | 3.A.17 (17/10/2026) |
| k = 1, 2; p_k(q_k); ε_{q_k,p_k}; p^u | Discriminación de 3.er grado: grupos (índice k, porque i y j son los bienes en el multiproducto del mismo tema), demandas inversas, elasticidades y precio uniforme de referencia | 3.A.17 (17/10/2026) |
| p_v = b, p_p = b + β | Tarifas de punta y valle (Boiteux, 1949; Steiner, 1957): coste de operación b y de capacidad β por unidad (letras locales; β no es aquí el factor de descuento, § 1); punta desplazada p_p + p_v = 2b + β | 3.A.17 (17/10/2026) |
| ET(p⃗) = EC(p⃗) + B(p⃗); (p_i − CMg_i)/p_i = [λ/(1+λ)]/\|ε_{q_i,p_i}\| | Precios de Ramsey-Boiteux con demandas independientes; λ multiplicador de B ≥ 0 (§ 1), número de Ramsey λ/(1+λ) creciente en λ (λ = 0: p = CMg; λ → ∞: monopolio). Nunca W(P) | 3.A.17 (17/10/2026) |
| s_i ≤ q; Σ_i max{IMg_i(q), 0} = CMg(q) | Producción conjunta en proporciones fijas: lo que se vende de cada bien y la suma vertical de los ingresos marginales. **Propuesto**: x_i (cantidad vendida, demanda) en lugar de s_i, que es la participación (§ 2, § 3) y que choca con la tasa s de Averch-Johnson del mismo tema (`pendientes-coherencia.md`) | 3.A.17 (17/10/2026) |
| IMg(Q) = CMg_1(q_1) = CMg_2(q_2), Q = q_1 + q_2 | Monopolio multiplanta (plantas 1 y 2 con C_1(q_1), C_2(q_2)); el cártel resuelve el mismo problema (3.A.19) | 3.A.17 (17/10/2026) |
| μ = σ/(σ−1), σ > 1 | Margen y elasticidad entre variedades | — |
| EC, EP, ET | Excedentes; en regulación ET = EC + B. En competencia perfecta, EC = ∫_0^{x*}p^D(x)dx − p*x*, EP = p*q* − ∫_0^{q*}p^S(q)dq, ET = EC + EP; EP_j = B_j + CF_j | —; 3.A.16 (17/10/2026) |
| p_c = p_v + t; p_c = (1+t)p_v; T = t x*; EG = −ΔEC − ΔEP − T ≈ ½t\|Δx\| | Impuesto en competencia perfecta: precios del consumidor y del vendedor (unitario y *ad valorem*), recaudación y exceso de gravamen (triángulo de Harberger); dp_c/dt = ε_S/(ε_S + \|ε_D\|). Ficha `incidencia-equilibrio-parcial` | D046, D047; 3.A.16 (17/10/2026) |
| R_i(q_{−i}) | Función de reacción | D016 |
| s, X | Tasa de rentabilidad permitida (Averch-Johnson, s > w_K, con z_K, z_L, w_K, w_L y el multiplicador μ, § 1) y factor de eficiencia del price cap, p_{t+1} ≤ p_t(1 + IPC_t − X) | —; 3.A.17 |
| C = β − e; β̲, β̄, ν; ψ(e); t, U = t − ψ(e); Φ(e); t(C) = a − b(C − C^a) | Laffont-Tirole (anexo A del 3.A.17): coste observado, eficiencia intrínseca (baja con probabilidad ν), desutilidad del esfuerzo, transferencia con coste social 1 + λ, renta de la empresa eficiente Φ(e) = ψ(e) − ψ(e − Δβ), menú lineal con potencia b ∈ [0,1]; en la anotación de coste incrementado y precio fijo, p = bF + (1 − b)C (F cuantía fija, local). Letras de la fuente, locales del anexo | 3.A.17 (17/10/2026) |
| N; c_i, R(c_i); c̄_{−i}, R̄_{−i}; T_i | Competencia por comparación (Shleifer, 1985): empresas i, j ≠ i (como la fuente), coste unitario y gasto en reducirlo, precio y transferencia fijados por la media de las demás. Locales del anexo A del 3.A.17 | 3.A.17 (17/10/2026) |
| w_L(L), w_L' > 0; ε_{L,w_L} > 0; GMg_L, VPMg_L, IPMg_L | Monopsonio (3.A.17, III.1): oferta inversa de trabajo y su elasticidad; `\funcionclave` `eq:monopsonio`, VPMg_L = GMg_L = w_L(1 + 1/ε_{L,w_L}) ⇔ (VPMg_L − w_L)/w_L = 1/ε_{L,w_L}; con monopolio en el bien, IPMg_L. Isocostes curvas: RMST_{LK} = GMg_L/w_K. Equilibrios L^M, w^M = w_L(L^M) y L^c, w^c; salario mínimo w̲ (raya debajo) | 3.A.17 (17/10/2026) |
| U_S = wL − v(L); B = pF(L) − wL; U_S^0, B^0; w^S; w^*, L^* | Monopolio bilateral (3.A.17, III.2): renta del sindicato con desutilidad agregada v(L), v'(L) = w_L(L); beneficio; puntos de desacuerdo; salario del sindicato monopolista (Dunlop) sobre la demanda de trabajo w^D(L) = VPMg_L, con su ingreso marginal IMg_S; solución de Nash con γ (§ 1). w es el salario negociado (variable) y w_L(·) la oferta inversa | 3.A.17 (17/10/2026) |
| Colores de los gráficos de bienestar | EC morado (`area`, como la curva de demanda), EP y la transferencia hacia el vendedor o el comprador con poder en dorado (`area2`), pérdida irrecuperable en rojo al 30 % (`perdida`), búsqueda de rentas con rayado rojo (`rentas`) e ineficiencia X en verde (`areax`, curva (1+χ)CMg con `curva3`). Fijados por el 3.A.16 (`excedentes.tex`, `incidencia.tex`) y seguidos por el 3.A.17 (`bienestar-monopolio.tex`, `monopsonio.tex`, `regulacion-monopolio-natural.tex`); los temas que se revisen los reutilizan | 3.A.16, 3.A.17 (17/10/2026) |
| N, s_i ∈ S_i, u_i | Jugadores, estrategias, pagos | — |
| t_i ∈ 𝒯_i, μ | Tipos de jugador y creencias | D104 |
| T ⊆ N, v(T), x_i | Coalición, función característica, imputación | — |
| v_i, b_i | Valoración y puja | — |
| A, B (en redonda); ν, 1 − ν | Tipos alto y bajo de la información asimétrica (3.A.13) y proporción del tipo bueno (productivos en Spence, prudentes en Rothschild-Stiglitz) | 3.A.13 (19/10/2026; D5 y D6 de esa revisión, provisionales) |
| y, ŷ, ŷ*; c_A(y) < c_B(y), c_A' < c_B'; w_A > w_B, w̄ = νw_A + (1 − ν)w_B; IC_A, IC_B | Spence: educación (D129), nivel que separa y el separador más barato del criterio intuitivo (c_B(ŷ*) = w_A − w_B); coste de la educación de cada tipo (cruce único); salarios con información y salario común; restricciones de incentivos, c_A(ŷ) ≤ w_A − w_B ≤ c_B(ŷ) (`eq:spence`). Nunca E, Ê ni w^R | D129; 3.A.13 (19/10/2026) |
| π_A > π_B; π̄ = νπ_B + (1 − ν)π_A; E_A, E_B, M, N, S_B, C | Rothschild-Stiglitz: probabilidad de accidente de temerarios (alto riesgo) y prudentes (bajo), probabilidad media del agrupador; puntos del gráfico (*first best*, agrupador, descreme, separador del prudente, agrupador que rompe el separador en el anexo B), con x_1^A, x_2^A, x_1^B, x_2^B las riquezas de cada tipo. Isobeneficio nulo (1 − π_i)x_1 + π_ix_2 = W̄ − π_iL. Seguro con información simétrica en § 2 (γ, A). Nunca p_A, p_B ni λ para la proporción | 3.A.13 (19/10/2026) |
| s ∼ U[s̲, s̄], α > 1; p* = αs̲/(2 − α) | Akerlof con calidad continua (letras locales del apartado; test de 2020) | 3.A.13 (19/10/2026) |
| e, π(e), w(x), v(e), U^R | Esfuerzo, probabilidad de éxito, remuneración según el resultado, desutilidad, utilidad de reserva (en Laffont-Tirole, ψ(e), fila anterior) | D017 |
| x_E > x_F; w_E ≡ w(x_E), w_F ≡ w(x_F), w*; e^A, e^B; λ_1, λ_2; B = x − w(x) | Principal-agente (3.A.13): resultado en éxito y fracaso (E, F en redonda: no son la función de gasto), pagos, salario fijo del *first best* u(w*) = U^R + v(e^A); esfuerzos alto y bajo; multiplicadores de la PC y de la IC; beneficio del principal **neutral** (en el cuerpo). Venta del negocio w(x) = x − k, k = 𝔼[x \| e^A] − v(e^A) − U^R; Δ local (§ 1); puntos O_A, O_P, Z, V, T de la caja. Nunca w(e) con esfuerzo inobservable, R[·] ni un solo λ | 3.A.13 (19/10/2026; D7 de esa revisión, provisional) |
| u_P(·) | Utilidad de Bernoulli del principal averso: **solo en los anexos** (regla de Borch, anexo A del 3.A.13); en el cuerpo, principal neutral | 3.A.13 (19/10/2026; D7) |
| x = e + ε, ε ∼ N(0, σ²); w = a + bx; b* = 1/(1 + r_Aσ²) | Contrato lineal de Holmström-Milgrom (1987) con CARA r_A y v(e) = e²/2; a y b locales (potencia de los incentivos, como la b de Laffont-Tirole) | 3.A.13 (19/10/2026) |
| r̂, r̂*; 𝔼[B_banco] = (1 + r̂)·Pr(repago \| r̂) | Stiglitz-Weiss: tipo del préstamo, el que maximiza el rendimiento esperado del banco y ese rendimiento (nunca E[B] = r̂ × Pr). En el anexo C del 3.A.13, θ (riesgo del proyecto), R ∼ F(R; θ), G (garantía) y θ̂(r̂) son locales; el beneficio esperado del prestatario, Π(r̂, θ) en el tema, debe ser B (D003, pendiente) | —; 3.A.13 (19/10/2026) |

## 5. Equilibrio general y bienestar (3.A.21-3.A.24)

Fijado con el 3.A.21 revisado (14/10/2026), que es el tema de referencia del equilibrio general (ficha `equilibrio-general-walras`).

| Símbolo | Significado | Decisión |
|---|---|---|
| X, Y; X_i, Y_i; p_X, p_Y | Bienes del 2×2×2×2, consumos del consumidor i y precios. Con n bienes, x_k, p_k, k = 1,…,n (l segundo índice; los factores son bienes más) | —; 3.A.21 |
| L, K; L̄, K̄; F_j(L_j, K_j) | Factores y dotaciones totales, orden (L, K); función de producción de la empresa j = X, Y | — |
| A, B; i = 1,…,I; j = 1,…,J | Consumidores (A, B en el 2×2×2×2) y empresas (j = X, Y en el 2×2×2×2) | D058 |
| ω⃗_i = (L̄_i, K̄_i); ω⃗, ω⃗′ | Dotación inicial del consumidor i (vector, con flecha, § 0), con L̄_A + L̄_B = L̄; en la caja, punto de dotación ω⃗ y dotación tras redistribuir ω⃗′ (2TFEB) | D045; 3.A.21 |
| θ_ij ≥ 0, Σ_iθ_ij = 1 | Participación del consumidor i en los beneficios de la empresa j (dos subíndices: no es la CRRA) | D058 |
| W̄_i = p⃗·ω⃗_i + Σ_jθ_ijB_j(p⃗) | Renta del consumidor i; en el 2×2×2×2, W̄_i = w_LL̄_i + w_KK̄_i + Σ_jθ_ijB_j | D058; 3.A.21 |
| p⃗ = (p_X, p_Y, w_L, w_K); w⃗ = (w_L, w_K); p⃗*; p⃗⁰, p⃗¹ | Vector de todos los precios (bienes y factores), de los factores, de equilibrio y dos vectores de precios cualesquiera (§ 0; nunca p⃗^A, p⃗^B, que chocan con los consumidores) | 3.A.21 |
| q_j(p_j,w⃗), L_j(p_j,w⃗), K_j(p_j,w⃗); y⃗_j ∈ 𝒴_j ⊂ ℝⁿ; B_j(p⃗) = max p⃗·y⃗_j | Oferta y demandas de factores de la empresa j (q_X = X, q_Y = Y); plan de producción neto y función de beneficios en el modelo general | 3.A.21 |
| X_i(p⃗), Y_i(p⃗); x⃗_i(p⃗, W̄_i(p⃗)) | Demandas del consumidor (dependen solo de los precios porque la renta también) | 3.A.21 |
| z_k(p⃗); z⃗(p⃗) = Σ_ix⃗_i − Σ_iω⃗_i − Σ_jy⃗_j | Exceso de demanda del bien k y vector de excesos de demanda (en el 2×2×2×2, z_X, z_Y, z_L, z_K) | 3.A.21 |
| p⃗·z⃗(p⃗) ≡ 0 | Ley de Walras (identidad, a cualquier precio) | — |
| z_k(p⃗*) ≤ 0, p*_kz_k(p⃗*) = 0 | Equilibrio general competitivo: bienes económicos (p*_k > 0, z_k = 0) y libres (p*_k = 0, z_k ≤ 0) | 3.A.21 |
| α > 0 en z⃗(αp⃗) = z⃗(p⃗) | Factor de homogeneidad de grado 0 (local; § 1) | 3.A.21 |
| Δ; f⃗ : Δ → Δ, f_k(p⃗) | Símplice de precios y aplicación del subastador, f_k(p⃗) = max{0, p_k + κ_kz_k(p⃗)} / Σ_l max{0, p_l + κ_lz_l(p⃗)} (Brouwer) | 3.A.21 |
| κ_k > 0; ṗ_k = κ_kz_k(p⃗) | Velocidad de ajuste del mercado k y tanteo (*tâtonnement*) multimercado; distancia al equilibrio ½Σ_k(p_k − p*_k)²/κ_k o ‖p⃗(t) − p⃗*‖, sin letra (función de Liapunov) | 3.A.21 |
| p⃗*·z⃗(p⃗) > 0 | Condición de unicidad global y de estabilidad (MWG § 17.F) | 3.A.21 |
| ∂z_k(p⃗)/∂p_l > 0, l ≠ k | Sustitutivos brutos | 3.A.21 |
| RMS^A_{XY}, RMST^X_{LK}, RMT_{XY} = CMg_X/CMg_Y | Relaciones marginales, positivas, sin barras y en redonda en las fórmulas (§ 0) | D035 |
| O_A, O_B; X̄, Ȳ; O_X, O_Y | Orígenes y lados de la caja de intercambio; orígenes de la caja de la producción (3.A.11) | 3.A.11, 3.A.21 |
| OD_A, OD_B; E, E′; U_A⁰, U_A* | Curvas de oferta-demanda (en redonda); equilibrio competitivo y el alcanzado tras redistribuir; curvas de indiferencia por la dotación y por el equilibrio | 3.A.21 |
| C, C′; M | Extremos del tramo de la curva de contrato dentro de la lente (núcleo con 2 agentes); punto de monopolio en la caja | 3.A.21 |
| 𝒮 ⊆ {1,…,I}; r | Coalición (caligráfica: S es el número de estados) y número de réplicas de la economía (Debreu-Scarf) | 3.A.21 |
| x_{ks}, p_{ks}; s = 1,…,S; π_s | Bien contingente (bien k en el estado s), su precio de Arrow-Debreu; estados y probabilidades (D017). Con un solo bien físico, x_{is} (consumo de i en s) y p_s | 3.A.21 |
| M̄_i, M̄ = Σ_iM̄_i; M^D(p⃗); φ; P | Saldos monetarios iniciales, demanda de dinero, proporción de Cambridge (local, § 1) e índice de precios del equilibrio general con dinero (ficha `patinkin`) | 3.A.21 |
| c_j(w_L,w_K); a_{Lj} = ∂c_j/∂w_L, a_{Kj} | Coste unitario del bien j y requerimientos unitarios (Shephard), en el 2×2 con rendimientos constantes | 3.A.21; § 3 (c(w⃗)) |
| s_{Lj} = w_La_{Lj}/p_j; ℓ_{Lj} = a_{Lj}q_j/L̄ | Participación del trabajo en el coste del bien j y fracción del trabajo empleada en j, en el álgebra de Jones (θ_{ij} y λ_{ij} en Jones, 1965: aquí θ es la CRRA y las participaciones en beneficios y λ la escala) | 3.A.21 |
| x̂ ≡ dx/x | Tasa de variación en el álgebra de Jones (§ 0); efecto magnificación ŵ_L > p̂_X > p̂_Y > ŵ_K | 3.A.21 |
| FPP, FPU, GFPU, CIS | Fronteras y curvas de indiferencia social | — |
| EGC; MEGC | Equilibrio general competitivo; modelos de equilibrio general computable (nunca EG, § 0) | 3.A.21 |
| W(U_1,…,U_I) | Función de bienestar social | D057 |
| R_i, R_G (≿_i, ≿_G) | Ordenaciones individual y social | — |
| ϵ | Aversión a la desigualdad (Atkinson) | D081 |
| G; T(X,G) = 0 | Bien público y FPP con bien público | — |
| CMgP, CMgE, CMgS; t* = CMgE(q*) | Costes marginales privado, externo, social; impuesto pigouviano | — |
| c_i | Cuota de Clarke-Groves | — |

## 6. Mercado de trabajo (3.A.25-3.A.28)

| Símbolo | Significado | Decisión |
|---|---|---|
| w, W | Salario real y nominal | D026 |
| C, O, O₀ (Ō en 4.B) | Consumo, ocio y dotación de tiempo | — |
| W̄ | Renta no laboral | D002 |
| U_t, U^n, V | Tasa de paro, tasa natural, vacantes | — |
| θ ≡ V/U | Tensión del mercado de trabajo | D056 |
| m(U,V), f(θ), q(θ) | Emparejamiento y tasas de encontrar empleo y de cubrir vacantes | D023, D020 |
| s | Tasa de separación | D008 |
| μ, e(w), γ | Margen, esfuerzo, poder negociador | D106 |
| w_L(L), ε_{L,w_L}; w̲; w^M, w^c, w^S | Oferta inversa de trabajo que afronta una empresa con poder de monopsonio, su elasticidad, salario mínimo y salarios de monopsonio, competitivo y del sindicato monopolista (3.A.17, que es la referencia de `monopsonio` y `monopolio-bilateral`; 3.A.25 y 3.A.27 los resumen con la misma notación) | 3.A.17 (17/10/2026) |
| U_S = wL − v(L), U_S^0; L^D, L^S | Renta del sindicato con desutilidad agregada del trabajo y punto de desacuerdo (3.A.17, III.2; propuesta para 3.A.27); demanda y oferta de trabajo a un salario dado | 3.A.17 (17/10/2026) |
| λ_h | Persistencia (histéresis) | D020 |

## 7. Macro cerrada: preferencias, crecimiento, consumo e inversión (3.A.29-3.A.34, 3.A.42-3.A.45)

| Símbolo | Significado | Decisión |
|---|---|---|
| θ, 1/θ | CRRA y ESI | D001 |
| ρ, β ≡ 1/(1+ρ) | Tasa de descuento y factor de descuento | — |
| φ, χ | Inversa de Frisch y peso de la desutilidad del trabajo | D004 |
| λ_t | Precio sombra (coestado) | — |
| b_t | Activos netos del hogar | — |
| Y, K, L, A_t; α, 1−α | Producción, factores, productividad; participaciones | — |
| δ | Depreciación | D008 |
| s, S_t | Tasa de ahorro y ahorro en nivel (OLG) | — |
| n, g | Crecimiento de la población y progreso técnico | D010 |
| k, y | Por trabajador eficiente (definido en cada tema) | — |
| v; L/Y | Relación capital-producto; trabajo-producto sin abreviar (Harrod-Domar) | D009 |
| H, h; u; η; α_H | Capital humano; fracción en producción (Uzawa-Lucas); externalidad; participación del capital en Ḣ | D131 |
| N_t | Número de variedades (Romer 1990) | D023 |
| β (MRW) | Elasticidad del capital humano | D107 |
| C_t; C^J_t, C^V_{t+1}; C_1, C_2 | Consumo; OLG; Fisher | — |
| c | Propensión marginal a consumir | — |
| Y^P | Renta permanente | — |
| P^K, c_K = P^K(r + δ − Ṗ^K/P^K) | Precio del capital y coste de uso | — |
| q_t, Φ(I_t, K_t) | q de Tobin y coste de ajuste | D130 |
| ρ_A, ε^A_t | Persistencia y shock de productividad (ln A_t = ρ_A ln A_{t−1} + ε^A_t) | — |

## 8. Dinero, inflación, política monetaria y fiscal (3.A.4-3.A.7, 3.A.35-3.A.41)

| Símbolo | Significado | Decisión |
|---|---|---|
| c, b, k, h, t | IS-LM: propensión a consumir, sensibilidad de la inversión, de la demanda de dinero a la renta y al tipo, tipo impositivo (I = Ī − b·i; M/P = kY − h·i) | D009, D007 |
| i, r; r_t ≡ i_t − 𝔼_t[π_{t+1}] | Tipos nominal y real | — |
| M, V, k | Dinero, velocidad, k de Cambridge | — |
| π_t, π^e_t ≡ 𝔼_{t−1}[π_t] | Inflación y expectativa | — |
| y^n_t, x_t ≡ y_t − y^n_t | Producción natural y brecha (logs) | — |
| r^n_t; r* | Tipo real natural; tipo de la regla de Taylor original | D037 |
| η, κ | Probabilidad de Calvo y pendiente de la NKPC | D008 |
| φ_π, φ_x, ν | Coeficientes y suavización de la regla de Taylor (forma canónica) | D021 |
| u_t, ε_t | Shock de costes (NKPC) y de política monetaria | — |
| a; α = 1/a | Pendiente de Phillips; respuesta del paro en Barro-Gordon | D060 |
| γ | Peso de la inflación en la pérdida (Barro-Gordon) | — |
| ω, ε_S, ψ = ω·ε_S | Extracción de señal y respuesta de la producción (Lucas) | D036 |
| β, δ (Laibson) | Descuento cuasihiperbólico | D105 |
| α, ζ | Semielasticidad y constante de Cagan | D061 |
| S_t, s_t | Señoreaje real y en % del PIB | — |
| G_t, T_t, D_t | Gasto sin intereses, ingresos, deuda a final de t | — |
| g_t, τ_t, d_t | Ratios sobre el PIB | D010 |
| i_{t−1}D_{t−1} | Intereses de la deuda emitida en t−1 | D028 |
| γ_Y, r − γ_Y | Crecimiento del PIB y diferencial tipo-crecimiento | D010 |
| τ_t | Tipo impositivo en modelos dinámicos (recaudación T_t) | D007 |

## 9. Macro abierta (3.A.32, 3.B.11-3.B.19)

| Símbolo | Significado | Decisión |
|---|---|---|
| E, Ẽ, Ē | Tipo de cambio nominal directo (↑ = depreciación), sombra, fijo | D013 |
| F_t^{t+1} | Tipo a plazo | D013 |
| e, f | Logaritmos de E y F | D013 |
| E^e_{t+1}, γE^e | Tipo esperado y depreciación esperada | D013 |
| q = EP*/P | Tipo de cambio real (↑ = depreciación real) | D015 |
| E^{ef}, q^{ef}, ω_i | Tipos efectivos (media geométrica) y pesos | D044 |
| Y, Y*; Y^{obj}, Y_n | Renta nacional y extranjera; objetivo del Gobierno y natural (3.B.17) | D038 |
| i, i*; r, r* | Tipos nominales y reales | — |
| m, x | Propensiones a importar y a exportar | — |
| ν | Sensibilidad del saldo comercial al tipo real | D016 |
| β | Movilidad del capital (0 nula, ∞ perfecta) | — |
| CI, R, ΔR | Crédito interno, reservas, variación de reservas | — |
| B, b; D, d | Deuda exterior y déficit (minúsculas en % del PIB) | — |
| CC, CK, CF, EO; CF^{BdE} | Cuentas de la BP; cuenta financiera del BdE | D039 |
| PNCI, PCI, PPA | Paridades (PDI como sinónimo) | D082 |

## 10. Comercio (3.B.5-3.B.10)

| Símbolo | Significado | Decisión |
|---|---|---|
| A, B; X, Y | Países y bienes del 2×2 (también en Ricardo) | — |
| a_X^A | Requerimiento unitario de trabajo | — |
| RRI = p_X/p_Y | Relación real de intercambio | — |
| t, s_A | Arancel ad valorem y subsidio a la exportación | — |
| ε* | Elasticidad de la oferta neta del resto del mundo (se dice de qué curva) | — |
| z_j, a_ij | Protección efectiva y coeficiente técnico | D016 |
| R_A(q_B), q_i^A | Función de reacción; cantidad de la empresa i en el mercado A | D016 |
| w, r | Salario y renta del capital (H-O-S, Stolper-Samuelson, Falvey); w_L, w_K cuando el 2×2 se cuenta como equilibrio general (anexo E del 3.A.21, avisando de w, r) | D011 |
| c_j, a_{Lj}, s_{Lj}, ℓ_{Lj}, x̂ | Álgebra de Jones del 2×2: coste unitario, requerimientos unitarios, participación del factor en el coste, fracción del factor empleada en j, tasa de variación (§ 5; ficha `heckscher-ohlin`) | 3.A.21 (14/10/2026) |
| φ; F, c (F^d, F^x) | Productividad (Melitz); costes fijo y marginal | — |
| σ, ρ | Elasticidad entre variedades y parámetro | — |
| τ; φ_τ = τ^{1−σ} | Coste iceberg; libertad comercial | D083 |
| μ; λ_i; ω_i; w | Peso de las manufacturas; cuota de trabajadores; salario real y nominal (NEG) | D019 |
| x_i, q, n | Consumo de la variedad, producción por empresa, número de variedades | — |
| β_0, β_1… | Coeficientes de regresión (gravedad) | — |

## 11. Finanzas y empresa (3.B.1-3.B.4, 3.B.23-3.B.27)

| Símbolo | Significado | Decisión |
|---|---|---|
| EBIT, EBITDA, EBIAT | Resultado de explotación, antes de amortizaciones, después de impuestos (definidos en 3.B.1) | — |
| ROA = EBIT/AT, ROE | Rentabilidades económica y financiera | D062 |
| I_0, FC_t (FCL_t), VR | Desembolso, flujos de caja, valor residual | D085 |
| k; WACC; r_E, r_D, r_A | Tasa de descuento genérica; costes de capital | — |
| V_E, V_D, V; L = V_D/V | Valores y peso de la deuda | — |
| t_IS, t_E, t_D | Tipos del IS y del IRPF de acciones y deuda | — |
| g = b·ROE | Crecimiento del dividendo y tasa de retención | D084 |
| BPA, PER, D_t | Beneficio por acción, ratio precio-beneficio, dividendo | — |
| r_f, r_M, r_i; 𝔼(r), σ, σ_ij, β_i; w_i; λ_M | Rentabilidades, momentos, beta, pesos, precio del riesgo | D063 |
| P, C_t (c), VN, y; r_t; D, D^mod | Bono: precio, cupón, nominal, TIR; tipos de contado; duraciones | — |
| S_0, S_T, F_0, K, c, p, C, P, r, T | Derivados (Hull) | D108 |
| π, R, L, c_1, c_2 | Diamond-Dybvig | D064 |
| APR | Activos ponderados por riesgo | — |

## 12. Sector público (4.B)

| Símbolo | Significado | Decisión |
|---|---|---|
| t, t_i, t_L, t_K, t_c… | Tipo impositivo (se dice si unitario o ad valorem) | D007 |
| T, T(Y); t_me, t_mg | Recaudación y función impositiva; tipos medio y marginal | — |
| Y, BI | Renta antes de impuestos y base imponible (progresividad) | D027 |
| W̄ | Renta exógena en los modelos de consumidor | D027 |
| ε_{T,BI}, ε_{BI,Y}, ε_{T,Y} | Elasticidades de la recaudación | — |
| p_c, p_v; q_i | Precios del consumidor y del vendedor (como en el 3.A.16, § 4) | D046 |
| x, h, q | Demanda marshalliana, hicksiana, oferta | — |
| ε_D, ε_S, ε^h | Elasticidades con signo | D047 |
| EG, EGMg_i, RMg_i | Exceso de gravamen y marginales | — |
| O, Ō; L = Ō − O | Ocio, dotación, trabajo | — |
| U_i, W(·) | Utilidad del individuo y FBS | D057 |
| CE(M), CD(M), M*; G*, G′ | Mayoría óptima; presupuesto eficiente y del burócrata | — |
| G, g = G/Y | Gasto público | D010 |
| D_t, d_t | Deuda pública | — |
| b, b^c, b^{ca}, b^e, b^p; OG; ε | Saldo y componentes; brecha; semielasticidad | D029 |
| i, r, γ, γ_r | Tipos y crecimiento nominal y real (deuda) | D010 |
| r_s | Tasa social de descuento | D008 |
| ϕ | Proporción de inversión privada desplazada | D109 |

## 13. Economía española (4.A)

| Símbolo | Significado | Decisión |
|---|---|---|
| Y, N, P_16, A, L, U, u = U/A | PIB, población, población de 16 y más, activos, ocupados, parados, tasa de paro | D048, D065 |
| PAT = Y/L, y = Y/N | Productividad aparente y PIB per cápita | — |
| Y/N = (Y/L)(L/A)(A/P_16)(P_16/N) | Descomposición del PIB per cápita | D048 |
| γ_X | Tasa de crecimiento | — |
| σ_t | Dispersión de ln y (σ-convergencia) | D034 |
| CF^{exc. BdE}, CF^{BdE}, PIIN | Cuenta financiera y posición de inversión internacional neta | D039 |
| X_i, M_i; GL; VCR_i; SCR_i | Comercio por producto; Grubel-Lloyd; ventaja comparativa revelada; saldo relativo | — |
| ITC, TCER, CLU | Competitividad y coste laboral unitario | — |
| ω_{i,t−1} | Ponderaciones del IPC | D044 |
| Tasa de actividad | Activos / población de 16 y más (EPA) | D049 |

## 14. Historia, organismos y Unión Europea

Área casi sin formalización (ver `_notacion/historia-organismos.md` y `_notacion/union-europea.md`): D_t y G_t en el dilema de Triffin; w_M, w̄_A, L_M en Lewis; tipos de cambio en moneda nacional por unidad extranjera. Siglas en castellano con la inglesa entre paréntesis la primera vez (MEDE (ESM), MAFC (CBAM), MRR (RRF), UMC (CMU), MUS, MUR, FUR, PDE, PDM). Terminología: «pilares» (D030), «mercados impugnables (contestables)» (D066), «regla de la elasticidad inversa» (D132), «regla de oro» (D040); «Ramsey» nunca a secas (regla de Ramsey, Ramsey-Cass-Koopmans, Ramsey-Boiteux); «Harberger» con su año (modelo de incidencia de 1962; triángulo del monopolio de 1954, 3.A.17, y de los impuestos de 1964, 3.A.16). Del 3.A.17 (17/10/2026): «primer óptimo (*first best*)», «segundo óptimo (*second best*)» y «tercer óptimo», nunca «óptimo de primer/segundo orden» (choca con las condiciones de primer y segundo orden); «discriminación intertemporal» (algunos manuales la llaman «de cuarto grado»: se dice una vez); «subsidio cruzado» solo en el sentido de Faulhaber (1975), nunca para un precio por debajo del coste marginal; la subaditividad es la **definición** del monopolio natural (también multiproducto); «explotación monopolística» y «monopsonística» (Robinson, 1933); «ingreso del producto marginal», «valor del producto marginal» y «gasto marginal». Del 3.A.13 (19/10/2026): «selección adversa» (información oculta, antes del contrato) y «riesgo moral» (acción oculta, después), con la teoría de la agencia como marco común (PC e IC); «información imperfecta» (término general), «incompleta pero simétrica» y «asimétrica»; «equilibrio separador» y «agrupador» (*pooling*; nunca «aunador», y nunca para el «solo se venden limones» de Akerlof); «señalización» (*signalling*, la parte informada) y «autoselección» (*screening*, la no informada); «descreme» (*cream skimming*); «no hay distorsión arriba»; «coste de agencia»; «venta del negocio» (contrato de franquicia); «cociente de verosimilitud»; «óptimo restringido (*second best* en la teoría de los contratos)», que no es el segundo óptimo de Lipsey-Lancaster y equivale a los «terceros óptimos» de la regulación del 3.A.17 (ficha `second-best`); «principio de revelación» (Gibbard, 1973; Dasgupta, Hammond y Maskin, 1979; Myerson, 1979; nunca «de Myerson» a secas); «racionamiento del crédito» con oferta que «se dobla hacia atrás» (nunca «cóncava»); «prima recargada» y «favorable» (no «desfavorable»). Del 3.A.10 (19/10/2026): «riesgo» (probabilidades objetivas) frente a «incertidumbre» (sin ellas; Knight, 1921); «teoría de la utilidad esperada» (TUE), «utilidad de Bernoulli» u(·) y «utilidad esperada» o «de von Neumann-Morgenstern» U(x̃); «axioma de independencia» (nunca «independencia de las alternativas irrelevantes», que es el axioma de Arrow de la elección social); la utilidad de vNM es «cardinal» (única salvo transformaciones **afines** positivas; nunca «lineales crecientes»), «cardinal que es ordinal» (Baumol, 1958); «esperanza de la utilidad y no utilidad de la esperanza»; «averso», «neutral» y «amante del riesgo»; «prima actuarialmente justa», «prima recargada» (γ > π) y «favorable» (γ < π, solo con subvención; nunca «competencia imperfecta»); «demanda de seguros» y «teorema de Mossin» (1968; nunca «modelo de Rothschild y Stiglitz» para el seguro con información simétrica); «relación marginal de sustitución estocástica, o entre estados» (RMSE); «línea de certeza»; «dispersión que conserva la media»; «prudencia» y «ahorro precautorio»; «teoría de las perspectivas» (*prospect theory* entre paréntesis una vez), «teoría acumulativa de las perspectivas», «aversión a las pérdidas», «efecto marco» (*framing effect*, nunca *framework*), «efecto certeza», «efecto consecuencia común» y «razón común», «patrón cuádruple», «pesos de decisión»; «teorías de la utilidad no esperada»; «principio de la cosa segura» (*sure-thing principle*); «aversión a la ambigüedad», «previos múltiples» (*maxmin expected utility*), «utilidad esperada de Choquet», «ambigüedad suave»; criterios de Wald (*maximin*), maximax, Laplace, Hurwicz y Savage (mínimo del pesar **máximo**, nunca de la suma de pesares).
