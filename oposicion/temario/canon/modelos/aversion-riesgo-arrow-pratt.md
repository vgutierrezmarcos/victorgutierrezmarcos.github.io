# Aversión al riesgo: equivalente cierto, prima de riesgo y coeficientes de Arrow-Pratt (Pratt, 1964; Arrow, 1965)

- **Área:** consumidor-producción · **Tema de referencia:** **3.A.10** (Demanda III; revisado el 19/10/2026, I.1.2, I.2.2 y anexos D y E) — es donde se definen y se derivan ξ, ρ, r_A, r_R, el teorema de Pratt, las familias CARA/CRRA/HARA y la prudencia; los demás temas los usan. Ficha creada a raíz de esa revisión (K42). Recoge el id `crra` del 3.A.8 (alias).
- **Temas que lo usan:** 3.A.10 (desarrollo; hecho), 3.A.8 (resumen; hecho: forma de la CRRA, `eq:crra`, con el −1, caso particular de las HARA, ESI = 1/θ, l. 1457-1460), 3.A.29 (resumen: θ y ESI = 1/θ en la utilidad intertemporal), 3.A.33 (resumen: prudencia u‴ > 0 y ahorro precautorio; Hall con u cuadrática; id `ahorro-precaucion` para la parte macro), 3.A.35 (mención: aversión y demanda de dinero como activo, Tobin), 3.B.23 (resumen: aversión y elección de cartera, curvas de indiferencia en (σ, 𝔼)), 3.A.13 (mención; hecho: agente averso y contrato lineal con r_A constante y ξ), 3.A.27 (mención: trabajador averso en los contratos implícitos), 3.A.42-3.A.44 (mención sin fijar en el mapa: CRRA en los modelos de crecimiento y RBC; θ, D001).
- **Manuales de referencia:** Pratt (1964, *Econometrica*); Arrow (1965, *Aspects of the Theory of Risk-Bearing*); Mas-Colell, Whinston y Green (1995), § 6.C; Gollier (2001), *The Economics of Risk and Time*; Leland (1968), Sandmo (1970) y Kimball (1990) para la prudencia; Rothschild y Stiglitz (1970) y Hadar y Russell (1969) para la dominancia; Chetty (2006) y Holt y Laury (2002) para las estimaciones.

## Presentación de referencia (3.A.10, I.1.2)

Pregunta: ¿qué dice la utilidad de Bernoulli de la actitud ante el riesgo, y cómo se mide?

- **Actitud:** averso ⇔ u(𝔼[x̃]) > 𝔼[u(x̃)] para toda lotería no degenerada ⇔ u estrictamente cóncava (Jensen) ⇔ ξ < 𝔼[x̃] ⇔ ρ > 0; neutral (u lineal); amante (u convexa). u continua y creciente («amante de la riqueza»).
- **Equivalente cierto y prima de riesgo:** u(ξ) = 𝔼[u(x̃)] = ∫u dF; **ρ ≡ 𝔼[x̃] − ξ** (ρ es la prima de riesgo solo dentro del 3.A.10, avisado; en macro ρ es la tasa de descuento). Ejemplo canónico: u = √x, lotería (64, 16; ½, ½): 𝔼 = 40, ξ = 36, ρ = 4; **prima actuarialmente justa** 24 (pérdida esperada) y **prima máxima** 64 − ξ = 28 = 24 + 4.
- **Coeficientes:**
$$r_A(x)\equiv-\frac{u''(x)}{u'(x)},\qquad r_R(x)\equiv x\,r_A(x)=-\frac{x\,u''(x)}{u'(x)}$$
(`eq:aversion-absoluta`, `eq:aversion-relativa`); r_R es la elasticidad de la utilidad marginal **cambiada de signo**; invariantes a a·u + b. **Aproximación de Arrow-Pratt:** ρ ≈ ½σ²r_A(W̄) (`eq:arrow-pratt`; derivación en el anexo E; en el ejemplo, 3,6 frente a 4). **Teorema de Pratt** (4 equivalencias: r_A^1 ≥ r_A^2; u_1 transformación cóncava de u_2; ρ_1 ≥ ρ_2; aceptación de apuestas).
- **Familias** (tabla `tab:formas-aversion`): **CARA** u = −e^{−ax}, a > 0, r_A = a; **CRRA**, la misma ecuación que el 3.A.8 (`eq:crra`):
$$u(x)=\begin{cases}\dfrac{x^{1-\theta}-1}{1-\theta} & \theta\ge 0,\ \theta\ne 1\\[4pt] \ln x & \theta=1\end{cases}\qquad r_R=\theta,\quad r_A=\theta/x\ (\text{DARA}),\quad \mathrm{ESI}=1/\theta$$
(el −1 se mantiene para el límite ln x; Epstein-Zin separan aversión y ESI); **cuadrática** u = x − (b/2)x², x < 1/b (IARA, media-varianza); **HARA**: 1/r_A = η_0 + η_1x (CARA si η_1 = 0; CRRA si η_0 = 0, η_1 = 1/θ; cuadrática si η_1 = −1). Siglas CARA, DARA, IARA, CRRA, DRRA, IRRA. Evidencia: DARA; r_R ≈ 1 (Chetty, 2006).
- **Prudencia (no se canta):** ahorro precautorio ⇔ **u‴ > 0** (no la aversión): u'(W̄ − s*) = 𝔼[u'(s* + ỹ)] (Leland, 1968; Sandmo, 1970); prudencia absoluta −u‴/u″ (Kimball, 1990; **sin símbolo en el cuerpo**, P(x) solo en el anexo E); CRRA prudente ((θ + 1)/x), cuadrática sin prudencia (Hall sin motivo precaución, 3.A.33); **DARA ⇒ prudencia** (anexo E). Tabla `tab:prudencia` (cuadrática frente a CRRA, θ y no σ).
- **Dominancia estocástica** (componente objetivo F(x)): 1.er orden ⇔ F(x) ≤ G(x) ∀x (toda u no decreciente); 2.º orden con la misma media ⇔ ∫F ≤ ∫G (toda u cóncava) ⇔ G es una **dispersión que conserva la media** de F (Rothschild-Stiglitz, 1970); orden parcial. Media-varianza solo con u cuadrática o rendimientos normales (elípticos), nunca «por el teorema central del límite».
- **Aplicaciones del mismo tema:** demanda de seguros (ficha `demanda-seguros`), activo con riesgo de Arrow (α* > 0 si 𝔼[r̃] > r_f; normal con DARA; proporción constante con CRRA) y empresa aversa de Sandmo (1971) (CMg(q*) < 𝔼[p̃]).

**Gráficos de referencia** (`oposicion/temario/fuentes/3A10/graficos/`): `actitud-riesgo.tex` (**imprescindible**: u cóncava, 𝔼[x̃], ξ, ρ, prima justa y máxima con el ejemplo 64/16), `actitud-tres-casos.tex` (averso, neutral, amante; nota) y `dominancia.tex` (1.º y 2.º orden).

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.10 | Elección con riesgo | desarrollo (hecho, 19/10/2026) | Todo lo anterior | — |
| 3.A.8 | Formas funcionales de la utilidad | resumen (hecho) | La CRRA con la misma ecuación (θ, el −1, ln con θ = 1), caso particular de las HARA, ESI = 1/θ; remite a 3.A.10 y 3.A.29 | Los coeficientes y Pratt |
| 3.A.29 | Elección intertemporal | resumen | θ = r_R y ESI = 1/θ (un mismo parámetro para el riesgo y el tiempo; Epstein-Zin los separa); nunca «σ = 1/θ» | ξ, ρ, Pratt |
| 3.A.33 | Teorías del consumo | resumen | Prudencia u‴ > 0, ahorro precautorio (Leland, Sandmo, **Kimball**), Hall con cuadrática sin precaución, DARA ⇒ prudencia | La definición de r_A |
| 3.A.35 | Demanda de dinero | mención | El averso reparte entre dinero seguro y bonos con riesgo (Tobin, 1958; ficha `tobin-cartera`) | — |
| 3.B.23 | Elección de cartera | resumen | Aversión y curvas de indiferencia en (σ, 𝔼(r_p)); cuándo vale media-varianza | Pratt, prudencia |
| 3.A.13 | Información asimétrica | mención (hecho) | Agente averso; contrato lineal con r_A constante (CARA) y equivalente cierto ξ = a + be − (r_A/2)b²σ² − e²/2 | Las definiciones |
| 3.A.27 | Contratos implícitos | mención | Trabajador averso, empresa neutral: el salario estable es un seguro | — |

## Divergencias encontradas en el temario actual
- 3.A.10 original: r_α, r_r; «ESI ≡ σ = 1/θ»; θ «elasticidad de la utilidad marginal»; aversión como «condición necesaria» del ahorro precautorio; tabla de prudencia con σ; media-varianza por el teorema central del límite; «transformaciones lineales crecientes». **Resuelto** (19/10/2026).
- 3.A.29: escribía (como el 3.A.10 original) «σ = 1/θ» para la ESI: canon ESI = 1/θ sin símbolo propio (D001; `mapa.yaml`).
- 3.A.33: Leland (1968) y Sandmo (1970) en su tabla sin Kimball (1990) ni la condición u‴ > 0 con la redacción del 3.A.10 (`mapa.yaml`).
- 3.A.13 (revisado): escribe la CARA con r_A en el contrato lineal porque a es el fijo del contrato; es coherente (r_A = a para la CARA) y no hay que cambiarlo.
- Id `crra` del inventario (solo 3.A.8): fusionado aquí (`_inventario/alias.json`, 19/10/2026).

Autor: Víctor Gutiérrez Marcos
