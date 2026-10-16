# Equilibrio general competitivo walrasiano (modelo 2×2×2×2)

- **Área:** equilibrio general y bienestar · **Tema de referencia:** **3.A.21** (La teoría del equilibrio general; revisado el 14/10/2026) — construcción, ley de Walras, existencia, unicidad, estabilidad, y la caja de intercambio como gráfico del EGC. Las **condiciones de óptimo de Pareto** (FPP, FPU, GFPU) y los teoremas del bienestar en detalle son de 3.A.22 (ficha `teoremas-bienestar`).
- **Temas que lo usan:** 3.A.21 (desarrollo; hecho, 14/10/2026), 3.A.11 (resumen de la parte de producción; hecho, 13/10/2026), 3.A.22 (desarrollo de la eficiencia), 3.A.23 (desarrollo: **copia** del de 3.A.22, sobra con el título vigente; pasa a recordarlo), 3.A.3 (desarrollo histórico: Walras), 4.B.11 (resumen: versión 1×2×2×2 con ocio).
- **Fusiones (14/10/2026):** recoge los ids `ley-walras`, `existencia-brouwer`, `sustitutivos-brutos` y `caja-edgeworth` del inventario del 3.A.21 (alias en `_inventario/alias.json`): son partes de esta presentación de referencia. La eficiencia en la caja va a `teoremas-bienestar`; el núcleo, a la ficha `nucleo`.
- **Manuales de referencia:** Walras (1874); Arrow y Debreu (1954); McKenzie (1954, 1959); Debreu (1959); Arrow y Hahn (1971); Mas-Colell, Whinston y Green (1995), cap. 15-17; Varian (1992), cap. 17-18 y 21; Jehle y Reny (2011), cap. 5; Bator (1957) para la presentación gráfica 2×2×2×2; Segura (1996, 3.ª ed.), cap. 7, y Gravelle y Rees (2004) para la caja de intercambio.
- **Decisión D035 (13/10/2026):** ¿Cómo se escriben las relaciones marginales en el equilibrio general? RMS^A_{XY}, RMST^X_{LK} y RMT_{XY}, positivas y sin barras (paralelas a RMS_{12} de 3.A.8); en redonda dentro de las fórmulas (`notacion.md` § 0).

## Presentación de referencia (3.A.21)
Pregunta: ¿pueden agentes que solo observan precios llegar a planes compatibles en todos los mercados a la vez? ¿Existe ese equilibrio, es único, se alcanza y es bueno?

**Supuestos (una sola lista, I.1).** Equilibrio general à la Walras (tantos mercados como mercancías, cada uno con demanda, oferta y condición de vaciado; tabla de agentes y mercados `tab:ecuaciones`); competencia perfecta (racionalidad, información perfecta, bienes homogéneos, precio-aceptación: p⃗ = (p_X, p_Y, w_L, w_K), w⃗ = (w_L, w_K)); mercados completos (sin externalidades ni bienes públicos, remisión a 3.A.23); modelo 2×2×2×2 estático (Bator, 1957):
- consumidores A, B con preferencias completas, transitivas, continuas, estrictamente monótonas y estrictamente convexas (3.A.8) → U_i(X_i, Y_i) continua, estrictamente creciente y estrictamente cuasicóncava. En nota: para la ley de Walras basta la no saciedad local y para la existencia la convexidad no estricta; la estricta hace la demanda función. **No** se supone utilidad marginal decreciente (no es ordinal). Dotaciones ω⃗_i = (L̄_i, K̄_i), Σ_iL̄_i = L̄;
- renta con participaciones en beneficios:
$$\overline W_i=w_L\overline L_i+w_K\overline K_i+\sum_j\theta_{ij}B_j,\qquad \theta_{ij}\ge 0,\ \textstyle\sum_i\theta_{ij}=1;$$
- empresas j = X, Y con F_j(L_j, K_j) continua, creciente, isocuantas convexas, sin externalidades (3.A.11). Conjunto de producción 𝒴_j no vacío, cerrado, con inacción, eliminación gratuita, sin producción sin factores y **convexo (no estrictamente)**: con la inacción, la convexidad implica rendimientos **no crecientes**, que incluyen los constantes (beneficio nulo; McKenzie, 1959, trata los decrecientes como constantes en un factor «empresarial»). Si se quiere la oferta como *función* hace falta F_j estrictamente cóncava, lo que con F_j(0⃗) = 0 **sí** implica rendimientos estrictamente decrecientes (3.A.11, I.2); las isocuantas estrictamente convexas no imponen ningún tipo de rendimientos. Los rendimientos crecientes quedan fuera (no convexidad: III.2 del 3.A.21);
- variables: exógenas preferencias, tecnologías y dotaciones; endógenos los 4 precios (3 relativos) y las cantidades. Tanteo (*tâtonnement*) de Walras como explicación de la formación de precios (Walras no habla de subastador; tanteo con *bons* tras Bertrand y Edgeworth: Walker, 1987).

**Empresas (I.2.1).** max B_j = p_jF_j(L_j,K_j) − w_LL_j − w_KK_j ⇒ p_jPMg^j_L = w_L, p_jPMg^j_K = w_K;
$$\mathrm{RMST}^X_{LK}=\frac{\mathrm{PMg}^X_L}{\mathrm{PMg}^X_K}=\frac{w_L}{w_K}=\mathrm{RMST}^Y_{LK},\qquad \mathrm{RMT}_{XY}=\frac{\mathrm{CMg}_X}{\mathrm{CMg}_Y}=\frac{p_X}{p_Y}.$$
Oferta q_j(p_j,w⃗) (q_X = X) y demandas L_j(p_j,w⃗), K_j(p_j,w⃗), homogéneas de grado 0, oferta no decreciente en su precio y demandas no crecientes en el suyo (Hotelling, 3.A.12); dos etapas (C(w⃗,q) y p = CMg) en nota y anexo, con remisión a 3.A.12. La caja de la producción, la curva de contrato y la FPP **se construyen en 3.A.11**: aquí solo se añaden los precios (isocoste tangente en la curva de contrato; recta de precios tangente a la FPP). Forma de la FPP: la nota común con 3.A.11 (decrecientes: estrictamente cóncava; constantes: estrictamente cóncava si las intensidades difieren y lineal si coinciden; crecientes: puede ser convexa, 3.B.6).

**Consumidores (I.2.2).** max U_i(X_i,Y_i) s.a. p_XX_i + p_YY_i = W̄_i ⇒ RMS^A_{XY} = p_X/p_Y = RMS^B_{XY}. Demandas X_i(p⃗), Y_i(p⃗): únicas, continuas, homogéneas de grado 0, ley de Walras individual (3.A.8).

**Exceso de demanda (I.2.3).** z_X(p⃗) = X_A + X_B − q_X, z_L(p⃗) = L_X + L_Y − L̄…; en general
$$\vec z(\vec p)=\sum_i\vec x_i\big(\vec p,\overline W_i(\vec p)\big)-\sum_i\vec\omega_i-\sum_j\vec y_j(\vec p),\qquad \overline W_i(\vec p)=\vec p\cdot\vec\omega_i+\sum_j\theta_{ij}B_j(\vec p).$$
Propiedades: continua, homogénea de grado 0 (z⃗(αp⃗) = z⃗(p⃗); α y no el κ del resto del temario porque aquí κ_k es la velocidad del tanteo, excepción local confirmada el 16/10/2026), ley de Walras, acotada inferiormente y condición de frontera. Bienes económicos (p*_k > 0, z_k = 0) y libres (p*_k = 0, z_k ≤ 0; Schlesinger y Wald, 1935). Aviso en nota: aquí z es el exceso de demanda, no el vector de factores de 3.A.11.

**Ley de Walras (I.2.4).** p⃗·z⃗(p⃗) ≡ Σ_kp_kz_k(p⃗) = 0 (en el 2×2×2×2, p_Xz_X + p_Yz_Y + w_Lz_L + w_Kz_K ≡ 0), con demostración sumando restricciones presupuestarias (basta la no saciedad local). Identidad, no condición de equilibrio; n − 1 mercados independientes, precios relativos, numerario (p_1 = 1) o símplice. No es la ley de Say (Lange, 1942; Becker y Baumol, 1952; remisión a 3.A.2 y 3.A.4).

**EGC (I.3).** p⃗* ≥ 0⃗ y asignación (x⃗*_i, y⃗*_j) con optimización de todos y z_k(p⃗*) ≤ 0, p*_kz_k(p⃗*) = 0; en el 2×2×2×2, RMS^A_{XY} = RMS^B_{XY} = p_X/p_Y = RMT_{XY} y RMST^X_{LK} = RMST^Y_{LK} = w_L/w_K. Subastador walrasiano (sin intercambios fuera del equilibrio). Gráfico: caja de intercambio con curvas de oferta-demanda OD_A, OD_B y equilibrio E en su corte, dentro de la lente.

**Existencia (II.1.1, a)-e)).** Contar ecuaciones no basta (Walras); Schlesinger y Wald (1935-1936); punto fijo (Arrow y Debreu, 1954; McKenzie, 1954). Basta z⃗ continua, homogénea de grado 0 y con ley de Walras. Brouwer en el símplice Δ = {p⃗ ∈ ℝⁿ₊ : Σp_k = 1} con la aplicación del subastador
$$f_k(\vec p)=\frac{\max\{0,\ p_k+\kappa_kz_k(\vec p)\}}{\sum_l\max\{0,\ p_l+\kappa_lz_l(\vec p)\}},$$
cuyo punto fijo es un EGC (demostración en el anexo B). Kakutani con correspondencias. Prueba no constructiva.

**Unicidad (II.1.2).** Existencia no implica unicidad (gráfico de z_X(p_X,1) con 3 cortes); economías regulares (Debreu, 1970) y teorema del índice (Dierker, 1972): número finito e impar. Condición p⃗*·z⃗(p⃗) > 0 (MWG § 17.F), con dos suficientes: ADPR agregado (homotéticas y dotaciones proporcionales) y **sustitutivos brutos**, ∂z_k/∂p_l > 0. **SMD** (Sonnenschein, 1972, 1973; Mantel, 1974; Debreu, 1974): cualquier z⃗ continua, homogénea de grado 0 y con ley de Walras es, **para precios estrictamente positivos**, el exceso de demanda de alguna economía.

**Estabilidad (II.1.3, a)-e)).** Tanteo multimercado ṗ_k = κ_kz_k(p⃗), κ_k > 0; distancia al equilibrio (Liapunov) ½Σ_k(p_k − p*_k)²/κ_k, cuya derivada es −p⃗*·z⃗(p⃗); sustitutivos brutos ⇒ estabilidad global (Arrow, Block y Hurwicz, 1959); contraejemplo de Scarf (1960); procesos sin tanteo y desequilibrio (3.A.4). Ficha `tatonnement`.

**Normativo (II.2, resumido).** Pareto, 1TFEB y 2TFEB en enunciados sobre la caja (ficha `teoremas-bienestar`), con remisión a 3.A.22, 3.A.23, 3.A.13 y 3.A.24.

**Extensiones (III).** Edgeworth y núcleo (ficha `nucleo`), comportamiento estratégico (Negishi, 1961; Gabszewicz y Vial, 1972; Roberts y Sonnenschein, 1977; Roberts y Postlewaite, 1976), no convexidades (Starr, 1969; fallos de coordinación, Cooper y John, 1988), dinero (ficha `patinkin`), incertidumbre (ficha `arrow-debreu-incertidumbre`), MEGC (ficha `egc`). Estática comparativa del 2×2 con rendimientos constantes (Stolper-Samuelson y Rybczynski, álgebra de Jones): anexo E, ficha `heckscher-ohlin`.

**Modelo general (anexo A).** I consumidores, J empresas, n bienes: max U_i(x⃗_i) s.a. p⃗·x⃗_i ≤ p⃗·ω⃗_i + Σ_jθ_ijB_j(p⃗); B_j(p⃗) = max_{y⃗_j∈𝒴_j} p⃗·y⃗_j (MWG cap. 17); el 2×2×2×2 es I = 2, J = 2, n = 4.

**Gráficos de referencia** (`oposicion/temario/fuentes/3A21/graficos/`):
- `caja-produccion-precios.tex`: el gráfico `caja-edgeworth-fpp` del 3.A.11 (O_X, O_Y, A, B, C, curva de contrato, FPP) con 2 capas propias: isocoste w_L/w_K tangente en la curva de contrato y recta de precios p_X/p_Y tangente a la FPP. Imprescindible.
- `caja-intercambio.tex`: **caja de intercambio maestra**, una sola, que crece capa a capa en el vídeo (capas 1-6 en I.3: caja, O_A, O_B, X̄, Ȳ, ω⃗, U_A⁰, U_B⁰, recta de precios, OD_A, OD_B, E; 7-8 en II.2: curva de contrato, ω⃗′, E′; 9 en III.1: lente, C, C′; 10 en III.2: núcleo que se encoge). Variantes para el PDF: `caja-intercambio-equilibrio.tex`, `caja-intercambio-teoremas.tex` y `caja-intercambio-nucleo.tex`. Imprescindible.
- `brouwer.tex` (punto fijo en una dimensión), `equilibrios-multiples.tex` (z_X(p_X,1) con 3 equilibrios; flechas del tanteo en las capas 5-6), `bienes-libres.tex`.
- Anexos: `maximizacion-dos-etapas.tex`, `estabilidad-parcial.tex` (ficha `tatonnement`), `costes-unitarios.tex` y `rybczynski.tex` (ficha `heckscher-ohlin`).

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.21 | ¿Existe, es único y estable el EGC? ¿Qué pasa si se relajan sus supuestos? | desarrollo (hecho, 14/10/2026) | Todo lo anterior: caja de la producción con el gráfico de 3.A.11 más la isocoste (w_L/w_K) y la recta de precios en la FPP (p_X/p_Y); caja de intercambio con curvas de oferta-demanda como gráfico del EGC; ley de Walras escrita y demostrada; existencia, unicidad y estabilidad con estructura a)-e); tanteo multimercado | La construcción técnica de la caja y la FPP (3.A.11); el criterio de Pareto y los teoremas en detalle (3.A.22, anexo C); la estabilidad en un mercado (3.A.16, anexo D) |
| 3.A.22 | ¿Es eficiente? | desarrollo | Tres condiciones, FPP, FPU, GFPU, 1TFEB/2TFEB con la especificación de 3.A.21 (anexo A: I, J, n) y su notación | Existencia y estabilidad; la construcción con precios (3.A.21) |
| 3.A.23 | Fallos de mercado | resumen (propuesto) | Recordar las condiciones y ver cuál rompe cada fallo | El modelo completo (sobra: remitir a 3.A.21 y 3.A.22) |
| 3.A.11 | Producción de varios bienes: eficiencia técnica | resumen (hecho, 13/10/2026) | III.2: caja de Edgeworth de la producción, curva de contrato, FPP y RMT_{XY} = PMg^Y_L/PMg^X_L = CMg_X/CMg_Y, con la notación § 5 (L_X, K_X, L̄, K̄, avisada); caja de optimalidad con RMST^X_{LK} = RMST^Y_{LK} = w_L/w_K. Gráficos `fuentes/3A11/graficos/caja-edgeworth-fpp.tex` y `formacion-caja.tex` | Precios de equilibrio, consumidores, FPU (3.A.21, 3.A.22) |
| 3.A.3 | Neoclásicos | resumen | Walras: interdependencia, contar ecuaciones e incógnitas (sin probar la existencia: la primera prueba es de Wald), tâtonnement | Formalización moderna |
| 4.B.11 | Imposición óptima | resumen | Variante 1×2×2×2 con ocio: los impuestos rompen RMS = RMT | 2 consumidores |

## Divergencias encontradas en el temario actual
- La caja de Edgeworth de la producción y la FPP estaban tres veces con texto casi idéntico (3.A.11, 3.A.21, 3.A.22: «punto I», «entre G y H», nota «no necesariamente una isoclina»). 3.A.11 la resume (13/10/2026) y 3.A.21 usa su gráfico con las capas de precios (14/10/2026); queda **3.A.22**, que debe desarrollar solo la eficiencia y remitir a los dos.
- 3.A.21 original suponía a la vez convexidad **estricta** del conjunto de producción (que, con la inacción, sí implica rendimientos estrictamente decrecientes: 3.A.11, I.2) y rendimientos no crecientes, y usaba después rendimientos constantes (McKenzie, FPP, Stolper-Samuelson): el error no era la implicación, sino la mezcla. Canon: conjunto **convexo** (no estricto), rendimientos no crecientes que incluyen los constantes; la concavidad estricta de F solo si se quiere la oferta como función. **Resuelto** en la revisión del 3.A.21 (14/10/2026).
- 3.A.21 original definía el núcleo en la caja de la producción («que las empresas actúen de forma racional»): el núcleo es de una economía de intercambio (coaliciones de consumidores). Resuelto (ficha `nucleo`).
- Orden de los factores: F_X(K_X,L_X) y F_X(L_X,K_X) en 3.A.22; K, L en 3.A.21 original: canon **(L, K)** y RMST_{LK} (3.A.21 resuelto).
- Escritura de las relaciones marginales: |RMS_X^Y|_A (3.A.22, 3.A.23, en valor absoluto) frente a RMS_{12} = U_1/U_2 > 0 (3.A.8 revisado): canon RMS^A_{XY} = (∂U_A/∂X_A)/(∂U_A/∂Y_A) (positiva, sin barras; consumidor arriba, bienes abajo); igual RMST^X_{LK} y RMT_{XY} (nunca −(CMg_X/CMg_Y)).
- Bienes: X, Y (3.A.21-3.A.23) y X_1, X_2 (4.B.11): canon X_i, Y_i y p_X, p_Y.
- Precios de factores: w_K, w_L (3.A.21 original) frente a w, r (3.A.23) y W, R (3.A.11 original): canon w_L, w_K.
- Siglas: «EGC» también para los computables y «EG» para el equilibrio general en algunos temas: canon EGC (competitivo), MEGC (computables); EG es el exceso de gravamen.
- 3.A.22 habla de «modelo 2×2×2» con 10 incógnitas y da los supuestos del 1TFEB en su versión de equilibrio parcial (MWG, «bien no numerario»): unificar en 2×2×2×2 y en la versión de equilibrio general (anexo C del 3.A.21).
- 3.A.25 (sin revisar): «se cumplen las propiedades de existencia, unicidad y estabilidad por trabajar con supuestos competitivos [ver tema 3.A.14]»: la competencia no garantiza unicidad ni estabilidad (SMD) y la remisión es a 3.A.21 (ya `corregir -> 3.A.21` en `mapa.yaml`).
- 3.A.3 (sin revisar): «Walras caracterizó las condiciones de existencia y estabilidad»: decirlo como 3.A.21 (Walras planteó el problema contando ecuaciones; la primera demostración es de Wald).

Autor: Víctor Gutiérrez Marcos
