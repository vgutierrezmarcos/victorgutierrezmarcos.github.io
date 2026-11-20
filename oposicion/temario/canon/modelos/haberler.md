# Modelo neoclásico de Haberler y curvas de oferta neta de Meade

- **Área:** comercio · **Tema de referencia:** **3.B.5** (… Determinación de la relación real de intercambio): el mapa proponía 3.B.7 por una coincidencia de palabras («comercial»), pero 3.B.5 tiene en el título la determinación de la RRI y es el que lo desarrolla; 3.B.7 lo resume para el arancel.
- **Temas que lo usan:** 3.B.5 (desarrollo; hecho, 10/11/2026: II `sec:neoclasico-rri`), 3.B.7 (resumen; hecho, 5/11/2026: II.1 `sec:general` y la guerra de Johnson en el cuerpo, `sec:johnson`; la derivación paso a paso en el anexo `anexo:oferta-neta`, con `\vertema{3.B.5}`), 3.B.8 (mención: solo en el anexo de equilibrio general, sin derivar las ON ni las CIC), 3.B.9 (uso de las curvas de oferta), 3.A.3 (mención: curvas de oferta recíproca de Marshall), 3.A.29 (mención: misma geometría que `robinson-crusoe.tex`)
- **Manuales de referencia:** Haberler (1936); Meade, *A Geometry of International Trade* (1952); Bhagwati, Panagariya y Srinivasan, caps. 2-4; Krugman, Obstfeld y Melitz, cap. 6 (modelo estándar).
- **Decisión D114 (13/10/2026):** ¿Cuál es el tema de referencia de Haberler (determinación de la RRI)? 3.B.5 (lo tiene en el título y lo desarrolla); corregir el mapa

## Presentación de referencia
**Pregunta:** ¿cómo se determina la relación real de intercambio cuando importan oferta y demanda?

**Supuestos:** 2 países (A y B), 2 bienes ($X$, $Y$), FPP cóncava (costes de oportunidad crecientes), preferencias homotéticas, competencia perfecta.

**Ecuaciones (notación canónica):** $RRI \equiv p_X/p_Y$; ventaja comparativa de A en $X$ si $(p_X/p_Y)^A_{aut} < (p_X/p_Y)^B_{aut}$; equilibrio: exportaciones netas de $X$ de A = importaciones netas de B.

**Resultado:** la RRI de equilibrio está entre los precios de autarquía; especialización incompleta; ganancias de consumo y de producción.

**Función clave** `eq:mill` (3.B.5): $p_X\,(X^A_P-X^A_C)=p_Y\,(Y^A_C-Y^A_P)$ (restricción del comercio equilibrado); orden histórico Mill (1844 y 1848) → Marshall (1879) → Meade (1952). Notación: $(p_X/p_Y)^A_{\mathrm{aut}}$ precio de autarquía; $P^A$, $C^A$ producción y consumo con comercio y $E^A_{\mathrm{aut}}$ el punto de autarquía; ON$_A$, ON$_B$ curvas de oferta neta (u oferta recíproca); CIC curvas de indiferencia comercial. Forma de la ON con `eq:oferta-neta-elasticidad`, $\hat E^A=(\varepsilon^A_M-1)\widehat{\mathrm{RRI}}$; **estabilidad** con `eq:ml-trueque`, $\lvert\varepsilon_M^A\rvert+\lvert\varepsilon_M^B\rvert>1$ (Marshall-Lerner en el trueque; la versión con el tipo de cambio real es la de la ficha `marshall-lerner`, 3.B.12).

**Presentación de referencia de la curva de oferta neta (Víctor, 10/11/2026):** se deriva desde Haberler en 4 pasos (`haberler-oferta-neta-a`, `haberler-oferta-neta-b`); Meade (CIC) queda en caja gris.

**Gráficos de referencia:** `oposicion/temario/fuentes/3B05/graficos/haberler-comercio.tex` (triángulo de comercio), `haberler-oferta-neta-a.tex` y `-b.tex` (la ON derivada de él), `ofertas-netas.tex` (equilibrio) y `meade.tex` (CIC, caja gris). Misma geometría que `fuentes/3A29/graficos/robinson-crusoe.tex`.

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.B.5 | Teoría del comercio (I): RRI | desarrollo (hecho, 10/11/2026) | Haberler, la ON derivada en 4 pasos, `eq:mill`, estabilidad con `eq:ml-trueque` y `\vertema{3.B.12}`; Meade en caja gris | — |
| 3.B.7 | Política comercial (I) | resumen (hecho, 5/11/2026) | Las ON y su desplazamiento con arancel, precio doméstico $p_X/[p_Y(1+t)]$; el arancel óptimo con la CIC tangente a ON$_B$ y la guerra de Johnson en el cuerpo; derivación en el anexo con `\vertema{3.B.5}` | El equilibrio de Haberler desde la FPP en el cuerpo |
| 3.B.8, 3.B.9 | Política estratégica; comercio y crecimiento | mención | 3.B.8: solo en el anexo de equilibrio general (las ON y las CIC son del 3.B.5); 3.B.9: crecimiento empobrecedor | La derivación |
| 3.A.3, 3.A.29 | Neoclásicos; modelización dinámica | mención | 3.A.3: las curvas de oferta recíproca de Marshall (1879); 3.A.29: la misma geometría (Robinson Crusoe) | — |

## Divergencias encontradas en el temario actual
- Referencia corregida en `mapa.yaml`: 3.B.7 → 3.B.5.
- 3.B.5 cambia de notación entre Ricardo (países 1-2, bienes a-b) y Haberler/H-O-S (A-B, $X$-$Y$): canon A-B y $X$-$Y$.
- **3.B.7 y 3.B.8 (Word)** desarrollaban la CIC «añadiéndola» al 3.B.5: resuelto al revisarlos (5/11/2026): el 3.B.7 la deriva en su anexo `anexo:oferta-neta` con `\vertema{3.B.5}` y el 3.B.8 solo la usa. Si se quiere ahorrar, el anexo del 3.B.7 podría reducirse a la remisión (no obligatorio).
- Estructura del 3.B.5 cambiada el 10/11/2026: la derivación de las ON desde Haberler es la presentación de referencia (antes II.1 Haberler y II.2 Meade).

Autor: Víctor Gutiérrez Marcos
