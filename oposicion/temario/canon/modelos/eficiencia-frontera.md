# Medición de la eficiencia: Farrell, frontera estocástica y análisis envolvente de datos (DEA)

- **Área:** consumidor-producción · **Tema de referencia:** **3.A.12** (Teoría de los costes … Aplicaciones empíricas; revisado el 14/10/2026, IV.3) — es la aplicación empírica de la función de costes como frontera y la medida de la ineficiencia X. Ficha creada a raíz de esa revisión.
- **Temas que lo usan:** 3.A.12 (desarrollo; hecho); previstos (mención, al revisarlos): 3.A.20 (regulación por comparación), 3.A.17 (con `yardstick`), 3.A.45 (productividad: cambio técnico frente a cambio en la eficiencia, Malmquist), 4.B.15 (eficiencia de la empresa pública), 4.A.5 (regulación de redes eléctricas).
- **Manuales de referencia:** Farrell (1957), *JRSS A*; Aigner, Lovell y Schmidt (1977); Meeusen y van den Broeck (1977); Jondrow et al. (1982); Charnes, Cooper y Rhodes (1978); Banker, Charnes y Cooper (1984); Battese y Coelli (1995); Kumbhakar y Lovell (2000); Coelli et al. (2005), *An Introduction to Efficiency and Productivity Analysis*.

## Presentación de referencia
Pregunta: ¿minimizan costes las empresas, y cuánto se alejan de la frontera?

- **Idea**: la función de costes es una frontera (el coste mínimo); las empresas reales pueden estar por encima (ineficiencia X, ficha `ineficiencia-x`). Se mide la distancia a la frontera de las mejores prácticas observadas.
- **Farrell (1957)**: isocuanta unitaria eficiente SS′ en (z_L/q, z_K/q), empresa en P, Q en la isocuanta sobre el rayo OP, R en la isocoste tangente sobre ese rayo:
$$\mathrm{EfT}=\frac{OQ}{OP},\qquad \mathrm{EfA}=\frac{OR}{OQ},\qquad \mathrm{EfE}=\frac{OR}{OP}=\mathrm{EfT}\cdot\mathrm{EfA}$$
EfT, eficiencia técnica (reducción equiproporcional de todos los factores: la ineficiencia X); EfA, asignativa (RMST_{LK} = w_L/w_K); EfE, económica o en costes, C(w⃗,q)/C^obs = 1/(1+χ). Siglas en redonda; nunca ET, EA, EE (ET es el excedente total).
- **Frontera estocástica** (paramétrica): ln C_j^obs = ln C(w⃗_j,q_j) + v_j + u_j, v_j ~ N(0,σ_v²) ruido, u_j = ln(1+χ_j) ≥ 0 ineficiencia (seminormal o exponencial); máxima verosimilitud con una translog de costes; EfE_j = e^{−u_j} predicha del residuo (Jondrow et al., 1982); con panel, determinantes de la ineficiencia (Battese y Coelli, 1995).
- **DEA** (no paramétrica): EfT_0 = min_{e,τ⃗} e s.a. Σ_jτ_jz⃗_j ≤ e·z⃗_0, Σ_jτ_jq_j ≥ q_0, τ_j ≥ 0 (CCR, rendimientos constantes); con Σ_jτ_j = 1, rendimientos variables (BCC), y la comparación separa la ineficiencia técnica pura de la de escala; con precios, eficiencia en costes y asignativa. Letras e y τ_j locales (θ y λ_j en Coelli et al.: θ es la CRRA y λ la escala).
- **SFA frente a DEA** (`tab:sfa-dea`): econométrico frente a programación lineal; forma funcional frente a ninguna; separa ruido frente a toda desviación es ineficiencia; varios productos difícil frente a inmediato; inferencia frente a *bootstrap*; puntos débiles: supuestos de forma y distribución frente a atípicos y número de variables.
- **Extensión**: índice de Malmquist, cambio técnico (desplazamiento de la frontera) frente a cambio en la eficiencia.
- **Evidencia y usos**: banca (Berger y Humphrey, 1997: 130 estudios, DEA y SFA no ordenan igual; BCE, WP 2305, 2019: banco mediano de la zona del euro ≈ 84 % de eficiencia en costes en 2006-2017, ineficiencia persistente; ratio de eficiencia de las entidades significativas, España 42,9 % frente a 53,1 % en el 2T 2026); **regulación por comparación** (Shleifer, 1985; ficha `yardstick`): la Bundesnetzagentur usa DEA y SFA, toma el valor más favorable con un mínimo del 60 %; gasto público en educación y sanidad (Comisión Europea, DP 217, 2024); España: puertos de contenedores, ayuntamientos valencianos.
- **Valoración**: eficiencia relativa a la muestra, sensible a la definición de factores y productos y a la heterogeneidad no observada; no explica por qué una empresa es ineficiente (incentivos y organización, 3.A.15); convierte la ineficiencia X en una magnitud medible.

Gráficos de referencia (3.A.12): `oposicion/temario/fuentes/3A12/graficos/farrell.tex` (imprescindible; mismo plano que `mc.tex`), `ratio-eficiencia-bancos.tex` (pgfplots con `datos/ratio-eficiencia-bancos.csv`, apoyo). Tablas: `tab:sfa-dea`, `tab:ejemplos-sectores`.

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.12 | ¿Minimizan costes las empresas? Medición | desarrollo (hecho, 14/10/2026) | Todo lo anterior (IV.3, 2 minutos en el cante) | — |
| 3.A.20 | Regulación con información asimétrica, aplicaciones | mención (prevista) | Cómo se fija el precio o el ingreso permitido con DEA y SFA (regulación alemana) | Farrell y los métodos (remitir a 3.A.12) |
| 3.A.17 | Regulación del monopolio natural | mención (prevista) | Con `yardstick`: la comparación necesita medir la eficiencia | — |
| 3.A.45 | Productividad total de los factores | mención (prevista) | Malmquist: cambio técnico frente a acercamiento a la frontera | — |
| 4.B.15, 4.A.5 | Empresa pública; sector eléctrico | mención (prevista) | Eficiencia comparada de empresas públicas y distribuidoras | — |

## Divergencias encontradas en el temario actual
- Ningún otro tema lo trata hoy; el 3.A.12 original no tenía aplicaciones empíricas (bloque IV nuevo en la revisión del 14/10/2026).
