# Notación canónica del temario

Un símbolo, un significado, en todo el temario. Consolidación inicial del canon (13 oct. 2026) a partir de las doce tablas de `_notacion/<área>.md`, que conservan el detalle (alternativas encontradas tema a tema y motivos). Este fichero manda: cuando difiere de una tabla de área es porque aquí se ha resuelto un choque entre áreas.

**Estado.** Notación **definitiva**. Víctor aprobó el 13/10/2026 todas las decisiones de `decisiones.json` (las de notación, con la opción recomendada); el id `Dnnn` de cada fila indica la decisión que la fijó. Lo que no lleva id es canon desde la consolidación: o es la notación del 3.A.8 revisado o es unánime en el temario y en los manuales. Los temas que se revisen la aplican tal cual; si un tema necesita un símbolo nuevo o cambiar uno, se propone el cambio al canon (`cambios.md`), no se inventa en el tema. Los cambios que el 3.A.8 ya revisado debe recoger están en `pendientes-coherencia.md`.

Manuales de referencia por área: Mas-Colell, Whinston y Green (MWG); Varian; Jehle y Reny (consumidor, producción, equilibrio general); Tirole, Gibbons (mercados y juegos); Romer, Blanchard y Fischer, Galí, Walsh, Sala i Martín, Acemoglu (macro); Krugman, Obstfeld y Melitz, Obstfeld y Rogoff, Gandolfo, Sarno y Taylor (macro abierta); Feenstra, Fujita-Krugman-Venables (comercio); Brealey-Myers, Bodie-Kane-Marcus, Hull, Freixas-Rochet (finanzas); Stiglitz, Rosen, Atkinson-Stiglitz, Mueller (sector público).

Autor: Víctor Gutiérrez Marcos

## 0. Convenciones generales

- **Micro**: minúsculas para precios y cantidades (p, x, q, w, z); mayúsculas para funciones de valor (U, V, E, C) y conjuntos (B(p,W̄)). Superíndices 0 y 1 para dos situaciones (x⁰, p¹, Ū⁰); subíndice i para bienes, j para empresas.
- **Macro**: mayúsculas para niveles agregados (Y, K, L, C, I, G, T, D, M); minúsculas para valores por trabajador o por unidad de trabajo eficiente (y, k, c) y para logaritmos en los modelos log-linealizados (se dice en cada tema).
- Superíndice ⁿ para el valor natural (y^n, U^n, r^n); asterisco para el **extranjero** en economía abierta (i*, P*, Y*) y para objetivos y óptimos fuera de ella (π*, U*, t*). Barra para valores exógenos o fijos (W̄, Ū, L̄, Ē).
- Tasas de crecimiento: γ_X ≡ Ẋ/X (D012). Tiempo discreto con subíndice t; continuo con punto.
- Esperanza: **𝔼[·]** (𝔼_t[x_{t+1}]); expectativa de x_t formada en t−1: x^e_t ≡ 𝔼_{t−1}[x_t]. La E latina queda para la función de gasto y el tipo de cambio.
- Elasticidades: **ε** con dos subíndices y con su signo; |ε| en las reglas de margen (D047). ϵ (lunada) solo para la aversión a la desigualdad de Atkinson (D081).
- Multiplicadores de Lagrange y precios sombra: **λ** (λ_k si hay varios) (D020). **Excepción en la teoría de la producción: λ es el factor de escala**, F(λz) = λ^k F(z), y ε_{q,λ} la elasticidad de escala (Víctor, 13/10/2026: es la notación a la que están acostumbrados los opositores y t se confunde con el tiempo, que en el mismo tema sale en A_t). Donde conviven escala y multiplicador (empresa, 3.A.12), el multiplicador del problema de costes es **λ^C** (como se distingue μ en el dual del consumidor). Peso de una combinación convexa en las definiciones de convexidad y cuasiconcavidad: **τ ∈ [0,1]**, τy + (1−τ)y′.
- **Vectores con flecha** (Víctor, 13/10/2026): x⃗, p⃗, z⃗, y⃗, w⃗, h⃗(p⃗,Ū) (`\vect{x}` en LaTeX = `\vec{x}`). Sus componentes y los escalares, sin flecha (x_i, p_1, W̄, Ū). Se aplica a todos los temas, empezando por los ya revisados.
- **Marshalliana y hicksiana** (Víctor, 13/10/2026): x⃗(p⃗,W̄) es siempre la marshalliana y h⃗(p⃗,Ū) la hicksiana; nunca x^h ni x^c. Cuando se derivan, se escriben con sus argumentos para que no se mezclen: ∂x_i(p⃗,W̄)/∂p_j = ∂h_i(p⃗,Ū)/∂p_j − x_j(p⃗,W̄)·∂x_i(p⃗,W̄)/∂W̄, y la identidad h⃗(p⃗,Ū) ≡ x⃗(p⃗,E(p⃗,Ū)). En los gráficos, la marshalliana en morado y la hicksiana en verde, rotuladas x_i(·) y h_i(·).
- Siglas de magnitudes en castellano y en redonda: CMg, CMe, IMg, PMg, RMS, EC, EP, ET, EG, VC, VE, ΔEC. **También dentro de las fórmulas**: en LaTeX, `\mathrm{VC}`, `\mathrm{VE}`, `\Delta\mathrm{EC}`, `\mathrm{EG}` (no $VC$ en cursiva, que se lee como el producto V·C); fijado con el 3.A.9 (13/10/2026).
- **Multiplicador del problema dual del consumidor (minimización del gasto): μ** (Víctor, 13/10/2026: como en el tema original), con μ* = ∂E/∂Ū = 1/λ* en el óptimo común (coste marginal de la utilidad). Uso local del dual del consumidor: en el resto del canon μ es el margen y las creencias, que no salen en estos temas. En la empresa (3.A.12), si conviven escala y multiplicador de costes, este es λ^C.

## 1. Choques entre áreas resueltos

| Letra | Significado canónico | Otros usos que se eliminan o se acotan | Decisión |
|---|---|---|---|
| **W** | W̄: renta o riqueza exógena del consumidor (también riqueza inicial en riesgo y seguros, y renta no laboral); W(·): función de bienestar social, siempre con argumentos; W: salario nominal en macro (WS-PS); W = M + B + EB*: riqueza en Branson (local) | Salario en micro → w_L; bienestar del regulador → ET; renta no laboral M o V → W̄ | D002, D026 |
| **V** | V(p,W̄): función indirecta de utilidad; V(q): conjunto de requerimientos de factores (producción, siempre con argumento q; 3.A.11); V: vacantes (mercado de trabajo); V: velocidad del dinero; V_E, V_D: valores en finanzas (con subíndice) | Utilidad esperada → U; renta no laboral → W̄ | D002 |
| **E** | E(p,Ū): función de gasto (micro); E: tipo de cambio nominal directo (macro abierta). No conviven | Esperanza → 𝔼; educación (Spence) → y; éxito → π(e); puntos de equilibrio en gráficos (E₀, E₁: se admiten) | D013, D129 |
| **σ** | Elasticidad de sustitución (CES, Dixit-Stiglitz, NEG); desviación típica (finanzas, Lucas); σ_t dispersión en la σ-convergencia | CRRA y ESI → θ y 1/θ | D001, D034 |
| **θ** | Coeficiente de aversión relativa al riesgo (CRRA); ESI = 1/θ. Excepciones avisadas: θ ≡ V/U (búsqueda, 3.A.26, 3.A.28) y θ_ij participaciones en beneficios (dos subíndices) | η (3.A.8), σ (3.A.42, KPR/GHH), Frisch (GHH) → φ, puja de Rosen → Θ, tipos de jugador → t_i, extracción de señal de Lucas → ω, tipo impositivo (4.B.11) → t | D001, D056, D006, D104, D036 |
| **δ** | Tasa de depreciación (δ_K, δ_H si hay dos capitales). Excepción avisada: δ factor exponencial del modelo β-δ de Laibson | Pendiente de la NKPC → κ; separación → s; tasa social de descuento → r_s; TPT → ρ | D008, D105 |
| **φ** | Inversa de la elasticidad de Frisch (macro); productividad de la empresa (Melitz); φ_π, φ_x coeficientes de Taylor (con subíndice); φ(z;B) oferta de Rosen (local) | Función de reacción → R_A(q_B); peso de los inputs (Corden) → a_ij; sensibilidad del saldo comercial → ν; desplazamiento de la inversión (4.B.6) → ϕ | D004, D016, D109 |
| **M** | Cantidad nominal de dinero (M^S, M^D); importaciones en contabilidad nacional y macro abierta (no conviven con el dinero en la misma ecuación) | Renta no laboral → W̄; variedades de Romer → N_t; emparejamientos → m(U,V); multiplicador monetario → la notación de la ficha `multiplicador-monetario` | D023, D002 |
| **B / π** | B: beneficio (B_j, B(p,w)); π: inflación (macro) y probabilidad (micro: π_s, π(e)); B(p,W̄): conjunto presupuestario (con argumentos); B, B*: bonos en Branson (local); B(G): beneficio social del gasto (4.B, local) | Beneficio π o Π → B; probabilidades p_s → π_s; saldo presupuestario B → b | D003, D017, D029 |
| **e** | Logaritmo del tipo de cambio nominal (e = ln E); esfuerzo e (información asimétrica) | Dotación → ω; coeficiente de efectivo → notación de `multiplicador-monetario`; tipo de cambio real → q; tipo sombra o fijo → Ẽ, Ē | D013, D045, D015 |
| **λ** | Multiplicador y precio sombra (μ el del dual del consumidor, § 0); λ ∈ [0,1] peso de una combinación convexa (definiciones de convexidad, local); λ local en Laffont-Tirole (coste de los fondos públicos) y en Kahneman-Tversky (aversión a las pérdidas); λ_i cuota de manufacturas en la NEG (FKV) | Escala → λ en producción (D101′); tasa de encontrar empleo → f(θ); persistencia de la histéresis → λ_h | D020 |
| **β** | Factor de descuento β ≡ 1/(1+ρ); coeficientes de regresión (β_0, β_1, con subíndice); β_i del CAPM; β movilidad del capital en la BP; β de MRW (elasticidad del capital humano) | Respuesta de la producción en Lucas → ψ; ponderaciones del ITC → ω_i; grado de apertura (3.B.9) → (X+M)/Y, sin símbolo | D036, D044, D107 |
| **γ** | Tasa de variación γ_X; peso de la inflación en la pérdida de Barro-Gordon; poder negociador (Nash, 3.A.27) | Peso de las manufacturas en la NEG → μ; constante de Cagan → ζ | D012, D019, D061, D106 |
| **g** | Tasa de progreso técnico; g = G/Y en sector público | Crecimiento del PIB → γ_Y («r − g» solo como nombre del debate); tasa m del anexo de 3.A.43 → g | D010 |
| **ρ** | Tasa de descuento (preferencia temporal); ρ = (σ−1)/σ dentro de la CES (avisado); prima de riesgo dentro de 3.A.10 (avisado) | Prima de riesgo de mercado en finanzas → λ_M o sin símbolo; persistencia AR(1) → ρ_A | — |
| **η** | Externalidad del capital (Lucas, 1988); probabilidad de Calvo de no revisar el precio | CRRA → θ; participación del capital en Ḣ → α_H; sensibilidad cíclica del saldo → ε | D131, D029 |
| **μ** | Margen sobre el coste marginal (σ/(σ−1) en micro y NEK); peso de las manufacturas en la NEG; creencias (juegos bayesianos); crecimiento del crédito interno (Krugman 1979, local) | Tasa de cubrir vacantes → q(θ) | D019, D020 |
| **v** | Relación capital-producto (acelerador, Harrod-Domar); v(T) función característica, v_i valoraciones, v(e) desutilidad del esfuerzo (con argumento o subíndice) | Sensibilidad de la inversión al tipo → b | D009 |
| **t / τ** | t: tipo impositivo en micro, imposición e IS-LM (t_L, t_K, t_c…); τ: tipo en macro dinámica y ratio T/Y; τ > 1 coste iceberg (comercio) | Recaudación → T; fracción de impacientes (Diamond-Dybvig) → π | D007, D064 |
| **w / r** | w: salario (real en macro, W nominal); w_L, w_K precios de los factores en producción y equilibrio general; w y r (renta del capital) en los 2×2 de comercio e incidencia; r: tipo de interés real (i nominal); r_f, r_E, r_D… rentabilidades en finanzas | W, R para precios de factores; r como precio del capital fuera de los 2×2 → w_K; r_s tasa social de descuento | D011, D026, D063 |
| **p / P** | p: precio de un bien (micro, comercio, imposición, mercados); P: nivel de precios (macro), precio del bono y prima de la put (finanzas, Hull) | P_x, P(Q), P_C/P_V → p, p(Q), p_c/p_v; P como gasto total (4.B.1) | D046, D108 |
| **q** | Producción de la empresa (micro); q de Tobin; tipo de cambio real (macro abierta); q(θ) tasa de cubrir vacantes. No conviven | ϰ → q | D015 |
| **L** | Trabajo; L pérdida en seguros (ℓ trabajo si conviven); L = V_D/V peso de la deuda (finanzas); L valor de liquidación (Diamond-Dybvig) | Índice de Lerner → 𝓛 | D059 |
| **U** | U(x): utilidad; U(x̃) = 𝔼[u(x̃)] utilidad esperada; u: utilidad de Bernoulli; U_i: utilidad marginal del bien i (3.A.8) y utilidad del individuo i en la elección social (no conviven); U_t, U^n: tasa de paro | — | D057 |
| **A** | A_t: productividad / PTF (macro); A: población activa (economía española; PTF escrita PTF si conviven); A, B: consumidores del 2×2×2×2 y países en comercio | — | D065 |
| **C** | C(w,q): función de costes (micro); C_t: consumo (macro); C: prima de la call (Hull); C(G) coste social del gasto | Coste de ajuste C(I) → Φ(I,K) | D130 |
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
| k (en h(kp,Ū), E(kp,Ū)) | Factor de homogeneidad en los precios (nunca θ, que es la CRRA, ni λ, que es la escala de la producción y el multiplicador) | 3.A.9 (13/10/2026) |
| VC, VE, ΔEC | Variaciones compensatoria y equivalente, excedente; en redonda también en las fórmulas (§ 0). Convención de MWG: VC = W̄ − E(p¹,Ū⁰), VE = E(p⁰,Ū¹) − W̄, positivas si el bienestar mejora | — |
| m(p̄; p, W̄) ≡ E(p̄, V(p,W̄)) | Función de utilidad métrica monetaria (indirecta); VE y VC son sus diferencias con p̄ = p⁰ y p̄ = p¹ (μ en MWG: aquí no, μ es el margen) | 3.A.9 (13/10/2026) |
| EG = −VE − T | Exceso de gravamen (≥ 0) con la convención de signo de VE; T recaudación | 3.A.9, ficha `exceso-gravamen` |
| L ≡ W̄ − p¹·x⁰, P ≡ p⁰·x¹ − W̄ | Variaciones de Laspeyres y de Paasche (compensaciones de cesta fija): L ≤ VC y VE ≤ P. **Local** del 3.A.9 (L es trabajo y P el nivel de precios en otras áreas; no conviven) | 3.A.9 (13/10/2026) |
| I_K(p⁰,p¹;Ū) = E(p¹,Ū)/E(p⁰,Ū); I_L, I_P, I_F = √(I_L I_P), I_T | Índices de Konüs (verdadero; I_K(Ū⁰) versión VC, I_K(Ū¹) versión VE), Laspeyres, Paasche, Fisher y Törnqvist (ln I_T = Σ_i ½(s_i⁰ + s_i¹) ln(p_i¹/p_i⁰)). Ponderaciones de los índices estadísticos: ω_i (D044) | 3.A.9 (13/10/2026) |
| **Sistemas de demanda (letras locales del 3.A.9)** | LES (Stone-Geary): U(x) = Σα_i ln(x_i − γ_i), Σα_i = 1, γ_i mínimos de subsistencia. Rotterdam: s̄_i d ln x_i = b_i d ln Q + Σ_j c_{ij} d ln p_j, con b_i = p_i ∂x_i/∂W̄ y c_{ij} = p_ip_jS_{ij}/W̄ (no θ_i, π_{ij} de Theil: θ es la CRRA y π la inflación). Translog indirecta: ln V = α_0 + Σα_i ln(p_i/W̄) + ½ΣΣβ_{ij} ln(p_i/W̄) ln(p_j/W̄). AIDS: ln E = (1−Ū) ln a(p) + Ū ln b(p); s_i = α_i + Σ_jγ_{ij} ln p_j + β_i ln(W̄/P), ln P = ln a(p) (índice translog), P* índice de Stone (LA-AIDS). QUAIDS: término ϑ_i/b(p)·[ln(W̄/a(p))]², b(p) = Π p_k^{β_k}, Σϑ_i = 0 (ϑ, no λ_i de Banks-Blundell-Lewbel: λ es el multiplicador). Las letras α, β, γ son locales de cada sistema; P (índice de precios del AIDS) y P (variación de Paasche) no se mezclan en el mismo apartado | 3.A.9 (13/10/2026) |
| Θ(z;Ū,W̄), φ(z;B) | Funciones de puja y de oferta de Rosen | D006 |
| x̃ (ỹ) | Lotería o renta aleatoria | — |
| π_s | Probabilidad del estado s | D017 |
| w(π_s), v(x − r) | Teoría de las perspectivas: ponderación de las probabilidades y función de valor respecto al punto de referencia r | D017 |
| u(·), U(x̃) = 𝔼[u(x̃)] | Utilidad de Bernoulli y utilidad esperada | — |
| r_A, r_R | Aversión absoluta y relativa (Arrow-Pratt) | — |
| θ, 1/θ | CRRA y ESI | D001 |
| ξ | Equivalente cierto | — |
| L, S, r (local), x_1, x_2, RMSE | Seguros: pérdida, cobertura, prima unitaria, riqueza sin y con accidente, RMS entre estados | — |

## 3. Producción y costes (3.A.11-3.A.12)

| Símbolo | Significado | Decisión |
|---|---|---|
| z = (z_L, z_K) | Factores (orden L, K) | — |
| q, Q = Σq_j | Producción de la empresa y de la industria | — |
| F(z) | Función de producción (f intensiva en macro); F(z) ≡ max{q : (q,−z) ∈ 𝒴} | — |
| 𝒴 | Conjunto de posibilidades de producción | D102 |
| y = (y_1,…,y_S) ∈ 𝒴 ⊂ ℝ^S | Vector de producción neta (*netput*): componentes negativos, factores; positivos, productos; S bienes (no L, que es el trabajo) | 3.A.11 (13/10/2026) |
| V(q) = {z ≥ 0 : (q,−z) ∈ 𝒴} | Conjunto de requerimientos de factores (su frontera, la isocuanta) | 3.A.11 (13/10/2026) |
| T(y) ≤ 0; RMT_{12} = (∂T/∂q_1)/(∂T/∂q_2) | Función de transformación de la empresa multiproducto (frontera T(y) = 0) y su relación marginal de transformación, positiva. MWG la llama F; aquí F es la función de producción. Mismo sentido que T(X,G) = 0 en §5 | 3.A.11 (13/10/2026) |
| w = (w_L, w_K) | Precios de los factores | D011 |
| λ | Factor de escala: F(λz⃗) = λ^k F(z⃗) (antes t, D101; cambiado por Víctor el 13/10/2026) | D101′ |
| k | Grado de homogeneidad (nunca λ, que es la escala); κ para un parámetro que chocaría con k | 3.A.11 (13/10/2026) |
| ε_{q,λ} | Elasticidad de escala (global: ε_{q,λ} = k en las homogéneas) | D101′ |
| ε_{q,λ}(z⃗) ≡ d ln F(λz⃗)/d ln λ \|_{λ=1} = Σ_i ε_{q,z_i} | Elasticidad de escala local (μ(z) en Jehle y Reny, que se cita solo en nota); = CMe/CMg a lo largo de la senda de mínimo coste | 3.A.11 (13/10/2026) |
| ε_{q,z_i} = PMg_i/PMe_i | Elasticidad-producto del factor i | 3.A.11 (13/10/2026) |
| PMg_L, PMe_L; RMST_{LK} = PMg_L/PMg_K | Productividades y relación técnica, positiva | — |
| C(w,q), C(q) | Función de costes (C(q) si w fijo) | — |
| z(w,q), z(p,w) | Demandas condicionadas y no condicionadas de factores | — |
| B, B(p,w) | Beneficio y función de beneficio | D003 |
| CMg, CMe, CVMe, CF | Costes marginal, medio, variable medio y fijo | — |
| A_t | Nivel tecnológico. Neutralidades (ficha `progreso-tecnico-neutral`): Hicks A_tF(z_K,z_L), Solow F(A_tz_K,z_L), Harrod F(z_K,A_tz_L) (orden (K, L) solo en estas tres fórmulas, como Romer y Acemoglu) | — |

## 4. Mercados, información y juegos (3.A.13-3.A.20)

| Símbolo | Significado | Decisión |
|---|---|---|
| p, p(q), p(Q) = a − bQ | Precio y demanda inversa | — |
| x(p), q(p), z(p) = x(p) − q(p) | Demanda, oferta y exceso de demanda | — |
| q_i, Q | Producción de la empresa i y de la industria | — |
| B_i, Σ_t β^t B_{it} | Beneficio y beneficio intertemporal | D003 |
| c, CF | Coste marginal constante y coste fijo | D103 |
| 𝓛 = (p − CMg)/p | Índice de Lerner | D059 |
| μ = σ/(σ−1), σ > 1 | Margen y elasticidad entre variedades | — |
| EC, EP, ET | Excedentes; en regulación ET = EC + B | — |
| R_i(q_{−i}) | Función de reacción | D016 |
| s, X | Tasa de rentabilidad permitida (Averch-Johnson) y factor de eficiencia del price cap | — |
| N, s_i ∈ S_i, u_i | Jugadores, estrategias, pagos | — |
| t_i ∈ 𝒯_i, μ | Tipos de jugador y creencias | D104 |
| T ⊆ N, v(T), x_i | Coalición, función característica, imputación | — |
| v_i, b_i | Valoración y puja | — |
| y | Educación (Spence) | D129 |
| e, π(e), w(x), v(e), U^R | Esfuerzo, probabilidad de éxito, remuneración según el resultado, desutilidad, utilidad de reserva | D017 |
| r̂, r̂* | Tipo del préstamo y el que maximiza el rendimiento del banco (Stiglitz-Weiss) | — |

## 5. Equilibrio general y bienestar (3.A.21-3.A.24)

| Símbolo | Significado | Decisión |
|---|---|---|
| X, Y; X_A, Y_A; p_X, p_Y | Bienes del 2×2×2×2, consumos y precios (x_k con n bienes) | — |
| L, K; L̄, K̄; F_X(L_X, K_X) | Factores y dotaciones, orden (L, K) | — |
| A, B; i = 1,…,I; j empresas | Consumidores | D058 |
| ω_i | Dotación inicial | D045 |
| W̄_i = p·ω_i + Σ_jθ_ijB_j | Renta del consumidor i | D058 |
| z_k(p); p·z(p) ≡ 0 | Exceso de demanda y ley de Walras | — |
| RMS^A_{XY}, RMST^X_{LK}, RMT_{XY} | Relaciones marginales, positivas | D035 |
| FPP, FPU, GFPU, CIS | Fronteras y curvas de indiferencia social | — |
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
| w, r | Salario y renta del capital (H-O-S, Stolper-Samuelson, Falvey) | D011 |
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
| p_c, p_v; q_i | Precios del consumidor y del vendedor | D046 |
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

Área casi sin formalización (ver `_notacion/historia-organismos.md` y `_notacion/union-europea.md`): D_t y G_t en el dilema de Triffin; w_M, w̄_A, L_M en Lewis; tipos de cambio en moneda nacional por unidad extranjera. Siglas en castellano con la inglesa entre paréntesis la primera vez (MEDE (ESM), MAFC (CBAM), MRR (RRF), UMC (CMU), MUS, MUR, FUR, PDE, PDM). Terminología: «pilares» (D030), «mercados impugnables (contestables)» (D066), «regla de la elasticidad inversa» (D132), «regla de oro» (D040); «Ramsey» nunca a secas (regla de Ramsey, Ramsey-Cass-Koopmans, Ramsey-Boiteux); «Harberger» con su año (modelo de incidencia de 1962, triángulo de 1964).
