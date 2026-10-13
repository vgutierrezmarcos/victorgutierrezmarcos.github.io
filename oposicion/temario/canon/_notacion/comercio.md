# Notación del área de comercio (3.B.5-3.B.10)

Paso 2 del canon (13 oct. 2026). Fuentes: `mapa.yaml`, `_inventario/resumen-por-area.md` (comprobado contra los Word originales de 3.B.6-3.B.10) e inventarios por tema. Manuales base: Feenstra (*Advanced International Trade*), Krugman, Obstfeld y Melitz, Bhagwati, Panagariya y Srinivasan (*Lectures on International Trade*), Fujita, Krugman y Venables (*The Spatial Economy*) y Helpman y Krugman. Decisiones aprobadas por Víctor el 13/10/2026 (`decisiones.json`): la columna «Canon» es la notación definitiva; `notacion.md` manda si difiere por un choque entre áreas.

## Tabla de símbolos

| Símbolo | Significado | Alternativas que aparecen (temas) | Canon | Motivo |
|---|---|---|---|---|
| A, B (países); $X$, $Y$ (bienes) | Países y bienes del modelo 2×2 | 1-2 y a-b (paño, vino) en Ricardo (3.B.5, 3.A.2); A-B y $X$-$Y$ en Haberler y H-O-S (3.B.5) | **A-B y $X$-$Y$** en todo el bloque; en la NEG, regiones A y B | Un solo sistema dentro de 3.B.5 |
| $a_X^A$ | Requerimiento unitario de trabajo del bien $X$ en A | $a_i$, $b_i$ (3.B.5, 3.A.2) | $a_X^A$, $a_Y^A$ | Krugman-Obstfeld ($a_{LC}$) adaptado a A/B y $X$/$Y$ |
| $RRI = p_X/p_Y$ | Relación real de intercambio | $P_X/P_Y$ (3.B.5, 3.B.7, 3.B.9, 3.B.10); $p_A^X/p_B^X$ (3.B.7) | **$p$ minúscula** para precios de bienes; $P$ para índices de precios | Convención de micro (3.A.8: $p$) |
| $t$ | Arancel *ad valorem* | $t$ (3.B.7, 3.B.10), $t_A$ (3.B.8) | Mantener; subíndice de país si hay dos | — |
| $s_A$ | Subsidio a la exportación | 3.B.8 | Mantener | — |
| $\varepsilon^*$ | Elasticidad de la curva de oferta neta del resto del mundo (arancel óptimo $1/(\varepsilon^*-1)$) | $\varepsilon_B$ (3.B.7, 3.B.8) | $\varepsilon^*$ (o $\varepsilon_B$ si los países son A y B), **diciendo de qué curva es** | En el texto se confunde con la elasticidad de la oferta de exportación ($t = 1/\varepsilon_X$) |
| $\varepsilon_S$, $\varepsilon_D$ | Elasticidades de oferta y demanda (equilibrio parcial) | 3.B.7 | Mantener | — |
| $z_j$; $a_{ij}$ | Protección efectiva; coeficiente técnico del input $i$ en $j$ (Corden) | $z_i$ y $\varphi$ = peso de los inputs (3.B.7) | **$a_{ij}$** para el coeficiente | $\varphi$ se reserva para la productividad de Melitz |
| $R_A(q_B)$ | Función de reacción | $\varphi_A(q_B)$ (3.B.8) | **$R_A(q_B)$** | Notación de Tirole y la habitual en el área de mercados (`cournot`); $\varphi$ libre |
| $q_i^A$ | Cantidad de la empresa $i$ en el mercado A | 3.B.8 | Mantener | — |
| $\varphi$ | Productividad de la empresa (Melitz) | $\phi$ en el texto y $\varphi$ en fórmulas (3.B.6) | **$\varphi$** | Notación de Melitz (2003) |
| $\sigma$, $\rho$ | Elasticidad de sustitución entre variedades; $\rho = (\sigma-1)/\sigma$ | 3.B.6, 3.B.9, 3.B.10, 3.B.16 | Mantener | Dixit-Stiglitz; coherente con `dixit-stiglitz` y `ces` |
| $F$, $c$ | Coste fijo y marginal (en trabajo) | 3.B.6, 3.B.16 | Mantener; $F^d$, $F^x$ en Melitz | — |
| markup | $\sigma/(\sigma-1)$ | $\mu$ (3.B.6, 3.B.40) | Ver conflicto 2 | — |
| $\tau$ | Coste de transporte iceberg ($\tau > 1$) | 3.B.6, 3.B.10, 3.B.40 | Mantener | Choque con $\tau$ fracción de impacientes en Diamond-Dybvig (4.A.20): se cambia allí |
| $\phi_\tau$ | Libertad comercial $\tau^{1-\sigma}$ | $\zeta$ (3.B.6) | **$\phi_\tau$** en todo el bloque | Una sola letra en el bloque; con subíndice no se confunde con la productividad $\varphi$ de Melitz |
| $\lambda_i$ | Cuota de trabajadores manufactureros en la región $i$ | 3.B.6, 3.B.9, 3.B.10, 3.B.16, 3.B.35, 3.B.40 | Mantener | FKV |
| $\omega_i$ | Salario real en la región $i$ (NEG) | 3.B.6, 3.B.9, 3.B.10; $w$ salario nominal (3.B.5) | $w$ nominal, $\omega$ real | FKV |
| $x_i$, $q$, $n$ | Consumo de la variedad $i$; producción por empresa; número de variedades | $x_i$, $x/q$, $y_k$ (3.B.6) | $x_i$ consumo, $q$ producción, $n$ variedades | Una letra por concepto dentro de 3.B.6 |
| $\beta$ | Coeficientes de regresión (gravedad) | $\beta$ = grado de apertura (3.B.9) | $\beta$ en regresiones; el grado de apertura de 3.B.9 sin símbolo propio, escrito $(X+M)/Y$ | Evitar dos significados en el bloque |
| $\eta$ | Intensidad de la externalidad (3.B.9) | — | Mantener | — |

## Conflictos reales y cómo se resuelven

1. **$\varphi$ con tres significados** en el bloque: peso de inputs (3.B.7), función de reacción (3.B.8), productividad (3.B.6); y en macro abierta, sensibilidad de XN (3.B.15). Decidido: $\varphi$ solo productividad de Melitz; $a_{ij}$, $R_A(\cdot)$ y $\nu$ para los demás.
2. **Peso de las manufacturas y markup en la NEG**: hoy $\gamma$ = peso y $\mu$ = markup. Decidido: $\mu$ = peso de las manufacturas (Krugman 1991, FKV) y el markup escrito $\sigma/(\sigma-1)$, sin símbolo; así $\gamma$ queda para las tasas de variación (3.B.16 junta ambos bloques).
3. **Utilidad de la NEG**: $u = X^{\alpha}[\dots]$ con $\alpha$ mientras el gasto en manufacturas es $\gamma$: canon $U = X^{1-\mu}V^{\mu}$.
4. **Países y bienes de Ricardo** distintos de los de Haberler/H-O-S dentro de 3.B.5.

## Copias y reasignaciones (para el mapa)
- Bloque NEG copiado casi literal en 3.B.6, 3.B.9 y 3.B.10 (siete ecuaciones y el tomahawk): desarrollo en 3.B.6.
- Equilibrio general del arancel (Meade, arancel óptimo, Johnson) duplicado en 3.B.7 y 3.B.8 (apartado 3): arancel óptimo en 3.B.7 y guerra arancelaria en 3.B.8.
- `haberler`: el mapa pone referencia 3.B.7; es **3.B.5** (determinación de la RRI en el título).
- `brander-spencer`: el nombre del mapa mezcla Brander-Krugman (1983) con el tercer mercado; Brander-Krugman (1983) es el dumping recíproco (`brander-krugman`).
- 3.B.9: el «modelo de Lucas» es de externalidades del capital físico tipo Romer (1986)/Arrow (1962): reasignar en el mapa `uzawa-lucas` → `arrow-romer-spillovers` para 3.B.9.

## Choques con otras áreas
- **Macro abierta**: $\gamma$ (tasas de variación), $\varphi$ (sensibilidad de XN), $q$ (tipo de cambio real si se adopta).
- **Finanzas**: $\rho$ = prima de riesgo en 3.B.2 frente a $\rho$ parámetro CES: se cambia en finanzas.
- **Mercados**: funciones de reacción y Cournot con la notación de `cournot`; Dixit-Stiglitz con la de `dixit-stiglitz` (3.A.18).

## Errores de contenido detectados
- 3.B.7: epígrafe «Aranceles y cuotas a la información» (es «a la importación»); notas internas («Esto no va aquí, sería del tema 3.B.8»).
- 3.B.8: epígrafe «jOHNSON»; atribución del Cournot de tercer mercado a Brander-Krugman (1983).
- 3.B.9: «modelo de Lucas» (es Romer 1986); «en los modelos endógenos de 1.ª generación el progreso tecnológico es un resultado exógeno» (es un subproducto no intencionado); notas internas («Aquí copiado el modelo de Sahuquillo»).
- 3.B.10: epígrafe 0 fuera de numeración; unión monetaria citada como 3.B.17 (es 3.B.16); notas de preparación.

Autor: Víctor Gutiérrez Marcos
