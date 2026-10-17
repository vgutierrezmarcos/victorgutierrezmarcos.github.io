# Variación compensatoria y variación equivalente

- **Área:** consumidor-producción · **Tema de referencia:** **3.A.9** (Demanda II: medidas de cambio en el bienestar; revisado el 13/10/2026, III.3)
- **Temas que lo usan:** 3.A.9 (desarrollo; hecho), 4.B.9 y 4.B.11 (resumen: exceso de gravamen), 4.B.6 y 4.B.7 (mención); 3.A.16 usa el excedente del consumidor (ficha `excedentes-bienestar`; con cuasilineales VC = ΔEC = VE, con remisión a 3.A.9; hecho, 17/10/2026) y 3.A.22 los criterios de compensación.
- **Manuales de referencia:** Hicks (1939, 1941, 1943; sistematizadas en 1956); Mas-Colell, Whinston y Green, §3.I; Varian, cap. 10; Willig (1976); Hausman (1981); McKenzie (1957) y Samuelson (1974) para la métrica monetaria; Rosen y Gayer (4.B.9).

## Presentación de referencia
Pregunta: ¿cuánto dinero equivale, para el consumidor, a un cambio de precios?

Cambio de precios $p^0\to p^1$ con renta $\overline W$; $\overline U^0=V(p^0,\overline W)$, $\overline U^1=V(p^1,\overline W)$. **Métrica monetaria** $m(\bar p;p,\overline W)\equiv E\big(\bar p,V(p,\overline W)\big)$ (no μ, que en el canon es el margen); VE y VC son sus diferencias:
$$\mathrm{VE}=m(p^0;p^1,\overline W)-m(p^0;p^0,\overline W)=E(p^0,\overline U^1)-\overline W=\int_{p_1^1}^{p_1^0}h_1(p_1,\bar p_{-1},\overline U^1)\,dp_1$$
$$\mathrm{VC}=m(p^1;p^1,\overline W)-m(p^1;p^0,\overline W)=\overline W-E(p^1,\overline U^0)=\int_{p_1^1}^{p_1^0}h_1(p_1,\bar p_{-1},\overline U^0)\,dp_1$$
$$\Delta\mathrm{EC}=\int_{p_1^1}^{p_1^0}x_1(p_1,\bar p_{-1},\overline W)\,dp_1$$
- **Signo** (convención de MWG): positivas si el bienestar mejora. Si baja un precio, VC = máximo que pagaría y VE = mínimo que aceptaría por renunciar; si sube, −VC = compensación mínima que aceptaría y −VE = máximo que pagaría por evitarla. Siglas en redonda también en las fórmulas (`\mathrm{VC}`, `\Delta\mathrm{EC}`).
- VC: utilidad **inicial** y precios **finales**; VE: utilidad **final** y precios **iniciales**.
- **Ordenación** (bien normal): $\mathrm{VC}\le\Delta\mathrm{EC}\le\mathrm{VE}$; con efecto renta nulo (cuasilineal) coinciden [3.A.16]; para un inferior se invierte. Con las variaciones de cesta fija (ficha `indices-precios`): $L\le\mathrm{VC}\le\Delta\mathrm{EC}\le\mathrm{VE}\le P$ (tabla `tab:ordenacion` del anexo D de 3.A.9, con los casos inferior y Giffen).
- **Independencia del camino**: con un precio, siempre; con varios, el excedente solo si las elasticidades-renta son iguales o los efectos renta nulos.
- **Willig (1976)**: $\mathrm{VC}\approx\Delta\mathrm{EC}-\frac{\varepsilon_{x_1,\overline W}(\Delta\mathrm{EC})^2}{2\overline W}$, $\mathrm{VE}\approx\Delta\mathrm{EC}+\frac{\varepsilon_{x_1,\overline W}(\Delta\mathrm{EC})^2}{2\overline W}$; error relativo $\approx|\varepsilon_{x_1,\overline W}||\Delta\mathrm{EC}|/2\overline W$ (5 % de la renta y elasticidad uno → 2,5 %). Hausman (1981): medida exacta recuperando $E$ de la demanda estimada.
- **Cuál usar**: VE para **ordenar** varias políticas (misma referencia de precios $p^0$); VC para **diseñar compensaciones** (Kaldor-Hicks [3.A.22]).
- **Exceso de gravamen**: $\mathrm{EG}=-\mathrm{VE}-T\ge 0$ (ficha `exceso-gravamen`).

Gráfico de referencia: plano $(x_1,p_1)$, bajada de $p_1$ de un bien normal, marshalliana y hicksianas con $\overline U^0$ y $\overline U^1$; áreas VC, $\Delta\mathrm{EC}$ y VE, y en las últimas capas los rectángulos $L$ y $P$: `oposicion/temario/fuentes/3A09/graficos/bienestar-vc-ve.tex`.

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.9 | Medir cambios de bienestar | desarrollo (hecho, 13/10/2026) | Métrica monetaria, VC y VE como DAP y DAA, áreas, ordenación, independencia del camino, Willig y Hausman, cuál usar, nota del EG, variaciones de Laspeyres y Paasche, índices de coste de la vida; anexos D (ordenación) y E (Willig) | El EG en detalle (4.B.9) |
| 4.B.9 | Exceso de gravamen | resumen | VE como medida preferida (compara a los mismos precios); $\mathrm{EG}=-\mathrm{VE}-T$; Harberger $\frac12|\varepsilon^h|t^2ph$ | Las demostraciones |
| 4.B.11 | Imposición óptima | resumen | VE en el gráfico de numerario (distancia EF) | — |
| 4.B.6 | ACB | mención | VC y VE como disposición a pagar y a aceptar; excedente como aproximación (Willig) | — |
| 4.B.7 | Principios impositivos | mención | Eficiencia medida con VE | — |

## Divergencias encontradas en el temario actual
- 3.A.9 original: «VEC», Hicks (1956) y «Willing», VE para políticas «en consideración» y VC para las «implementadas»; resuelto en la revisión (ΔEC, Hicks 1939-1943, Willig, criterio de MWG §3.I).
- En los temas de 4.B el signo de VC y VE no siempre sigue esta convención: usar la de MWG y decir en cada tema si se habla de pérdida (−VE). La ficha `exceso-gravamen` escribía $EG=VE-T$ (VE como magnitud de la pérdida); corregida a $-\mathrm{VE}-T$ el 13/10/2026.
- 4.B.9: «Hicks (1956) … Willings», «Haussman» (ver `exceso-gravamen`).
