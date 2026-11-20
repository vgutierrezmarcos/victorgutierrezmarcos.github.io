# Arancel en equilibrio parcial y general, arancel óptimo, paradojas de Metzler y Lerner y guerra arancelaria de Johnson

- **Área:** comercio · **Tema de referencia:** 3.B.7 (Política comercial (I): instrumentos y efectos) — es el efecto del arancel de país grande sobre la RRI, contenido del título. **Desde el 10/11/2026 (Víctor) el 3.B.7 desarrolla también la guerra arancelaria de Johnson en el cuerpo** (`sec:johnson`, 3 gráficos por pasos con curvas de oferta neta); el 3.B.8 la resume con su gráfico final (III.2 `sec:johnson`) y desarrolla la salida cooperativa (`sec:cooperacion`). **Alias de esta ficha** (pasada final, C1 a y c del 3.B.7 y CP6 del 3.B.8): `arancel-equilibrio-parcial`, `metzler-lerner` y `johnson-guerra-comercial` (`_inventario/alias.json`).
- **Temas que lo usan:** 3.B.7 (desarrollo; hecho, 5/11/2026: I.2 `sec:parcial` y `sec:general`, Johnson en `sec:johnson`, derivaciones en `anexo:derivaciones`), 3.B.8 (resumen; hecho, 5/11/2026: III.2 con el gráfico final de Johnson y la evidencia de Broda, Limão y Weinstein, 2008), 3.B.10 (mención: arancel común óptimo de la unión, Mundell), 3.B.41 (mención), 4.A.24 (mención); 3.A.3 (mención; hecho, 4/11/2026: las curvas de oferta recíproca de Marshall, 1879, como herramienta del arancel óptimo, `\vertema{3.B.7}`)
- **Manuales de referencia:** Johnson (1953-54), «Optimum Tariffs and Retaliation», *RES*; Krugman, Obstfeld y Melitz, cap. 9 y apéndice; Feenstra, cap. 7; Bhagwati, Panagariya y Srinivasan, *Lectures on International Trade*, cap. 17; Broda, Limão y Weinstein (2008) para la evidencia.

## Presentación de referencia
**Pregunta:** ¿puede un país grande ganar imponiendo un arancel?

**Supuestos:** país grande (influye en la RRI), competencia perfecta, sin represalias; equilibrio general con curvas de oferta neta (Meade/Haberler) o parcial con oferta de exportación extranjera con pendiente positiva.

**Equilibrio parcial (país pequeño y grande):** precio mundial $p^W$, precio interior $p^W(1+t)$; $q$, $x$, $M=x-q$ producción, consumo e importaciones; áreas $a$-$e$ (como el 3.B.10); pérdida irrecuperable `eq:pie-arancel`, $\mathrm{PIE}=b+d\approx\tfrac12t^2\lvert\varepsilon_{M,p}\rvert p^WM^0$; país grande, `eq:arancel-optimo-parcial`, $t^{\mathrm{opt}}=1/\varepsilon^*_X$ (gráficos `arancel-pequeno.tex`, `arancel-grande.tex`, `bienestar-arancel.tex`). **Equilibrio general:** país pequeño en 3 pasos (`pequeno-general-paso1`…`3`) y país grande con la CIC de A tangente a ON$_B$ (`arancel-optimo.tex`); **paradojas de Metzler y Lerner** (`metzler-lerner.tex`, derivación en el anexo). Cuarta condición del arancel óptimo con $\mathrm{RMT}^*_{XY}$, la relación marginal de transformación **a través del comercio** (pendiente de ON$_B$), que sustituye a $\mathrm{RMT}_i$.

**Ecuaciones (notación canónica):** $\varepsilon^*\equiv\varepsilon^B_M$ = elasticidad de la demanda de importaciones del resto del mundo, que es la de su curva de oferta neta en el sentido de Johnson; $\varepsilon^*_X=\varepsilon^*-1$ la de su oferta de exportaciones (`eq:oferta-neta-elasticidad` del 3.B.5). Función clave del 3.B.7, `eq:arancel-optimo`: $t^{\mathrm{opt}}=1/(\varepsilon^*-1)\Leftrightarrow t^{\mathrm{opt}}/(1+t^{\mathrm{opt}})=1/\varepsilon^*$, análoga a $\mathcal L=1/\lvert\varepsilon_{q,p}\rvert$ del monopolio (3.A.17). **$t^{\mathrm{opt}}$ para el arancel óptimo de país grande** (3.B.7) y el asterisco $t_A^*$, $s_A^*$ solo para los óptimos estratégicos de oligopolio (3.B.8; CP11).
$$t^{opt} = \frac{1}{\varepsilon^* - 1} \;\;(\text{elasticidad de la curva de oferta de Meade}) \quad\text{o}\quad t^{opt} = \frac{1}{\varepsilon^*_{X}} \;\;(\text{elasticidad de la oferta de exportación})$$
Decir siempre qué elasticidad se usa: las dos fórmulas son equivalentes porque $\varepsilon^*_{X} = \varepsilon^* - 1$.

**Resultado:** el arancel óptimo es positivo y decrece con la elasticidad extranjera; con represalias (Johnson), el equilibrio de Nash puede dejar a ambos peor (o, con asimetrías, a uno mejor).

**Gráficos de referencia:** `oposicion/temario/fuentes/3B07/graficos/arancel-optimo.tex` (CIC$_A$ tangente a ON$_B$) y la guerra de Johnson en 3 pasos, `johnson-paso1.tex`, `johnson-paso2.tex` y `johnson.tex` (equilibrio de Nash en aranceles, $E_N$); el 3.B.8 usa su `fuentes/3B08/graficos/johnson.tex` (solo el resultado).

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.B.7 | Instrumentos y efectos | desarrollo (hecho, 5/11/2026) | País pequeño frente a grande, parcial y general; fórmula con $\varepsilon^*$ dicha; Metzler y Lerner; la guerra de Johnson en el cuerpo en 3 pasos con curvas de oferta neta; derivación de las ON y las CIC en `anexo:oferta-neta`, con `\vertema{3.B.5}` | La cooperación (3.B.8, 3.B.33) |
| 3.B.8 | Política comercial estratégica | resumen (hecho, 5/11/2026) | III.2: $t^{\mathrm{opt}}$ en una línea, la guerra de Johnson con su gráfico final como dilema del prisionero (`\vertema{3.A.14}`), quién puede ganarla y Broda, Limão y Weinstein (2008); después, la salida cooperativa (`sec:cooperacion`) | Volver a derivar el arancel óptimo, las ON y las CIC |
| 3.B.41, 4.A.24 | Política comercial UE / España | mención | Argumento de la RRI como excepción al librecambio | — |
| 3.A.3 | Los neoclásicos | mención (hecho, 4/11/2026) | II.4: las curvas de oferta recíproca de Marshall (*The Pure Theory of Foreign Trade*, impresión privada desde 1879) y la relación real de intercambio, `\vertema{3.B.5}`, herramienta con la que después se estudia el arancel óptimo, `\vertema{3.B.7}` | El arancel óptimo |
| 3.B.10 | Integración económica | mención | Arancel común óptimo de una unión aduanera (Mundell) | — |

## Divergencias encontradas en el temario actual
- **Duplicado literal** del análisis de equilibrio general (Meade, arancel óptimo, Johnson) en 3.B.7 y en el apartado 3 de 3.B.8; 3.B.7 tiene además una nota del autor («Esto no va aquí, sería del tema 3.B.8»).
- La elasticidad se llama $\varepsilon_B$ (de la curva de oferta neta de B) en ambos temas, pero el texto la describe a veces como elasticidad de la oferta de exportación: con la fórmula $1/(\varepsilon_B - 1)$ debe ser la de la curva de oferta.
- Precios relativos como $p_A^X/p_B^X$ en un sitio y $P_X/P_Y$ en otro (3.B.7). Canon: $RRI = p_X/p_Y$.
- **Resuelto** (5/11/2026): el duplicado entre 3.B.7 y 3.B.8 se reparte como arriba y la elasticidad ε* queda definida. **3.A.14 (revisado)**: sus remisiones de las guerras arancelarias a `\vertema{3.B.7}` (l. 31, 241, 1018, 1811) quedan bien porque el 3.B.7 desarrolla ahora a Johnson; la de la cooperación en los acuerdos comerciales (l. 549) debe ir al 3.B.33 (ver `pendientes-coherencia.md`).

Autor: Víctor Gutiérrez Marcos
