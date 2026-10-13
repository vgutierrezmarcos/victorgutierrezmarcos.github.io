# Modelo bisectorial de Harberger (1962): incidencia en equilibrio general

- **Área:** sector público · **Tema de referencia:** 4.B.8 (traslación e incidencia) — el título pide el «enfoque de equilibrio general» y es su modelo canónico.
- **Temas que lo usan:** 4.B.8 (desarrollo), 4.B.9 (hoy resumen duplicado; debe quedar en mención), 4.B.12/4.B.17 (mención: incidencia del IS)
- **Manuales de referencia:** Harberger (1962), «The incidence of the corporation income tax», *JPE*; Atkinson y Stiglitz, *Lectures*, lección 6; Rosen y Gayer, cap. 14; Fullerton y Metcalf (2002), «Tax incidence», *Handbook of Public Economics* IV; McLure (1975). Base de equilibrio general: [ver tema 3.A.21] y la caja de Edgeworth de producción (3.A.22).
- **Decisión D126 (13/10/2026):** ¿Se suprime el Harberger (incidencia) copiado en 4.B.9? Sí: mención de 3-4 líneas en 4.B.9 y remisión a 4.B.8

## Presentación de referencia
**Pregunta:** ¿quién soporta, en último término, un impuesto sobre un bien o sobre un factor en un sector, cuando los factores se mueven entre sectores?

**Supuestos:** economía cerrada con dos bienes ($X$ intensivo en trabajo, $Y$ intensivo en capital), dos factores ($L$, $K$) con dotaciones fijas y plena movilidad entre sectores; rendimientos constantes a escala; competencia perfecta; preferencias homotéticas idénticas (o gasto independiente de la distribución); recaudación devuelta como transferencia de suma fija; análisis de cambios marginales.

**Ecuaciones (notación canónica $w$, $r$, $p_X$, $p_Y$, $t$):** equilibrio sin impuestos
$$\lvert RMST_{L,K}\rvert_X=\frac{w}{r}=\lvert RMST_{L,K}\rvert_Y,\qquad RMS_{X,Y}=\frac{p_X}{p_Y}=RMT_{X,Y}.$$
Impuesto general sobre ambos bienes al mismo tipo: $\frac{p_X(1+t)}{p_Y(1+t)}=\frac{p_X}{p_Y}$, sin distorsión. Impuesto selectivo sobre $X$: $RMS_{X,Y}=\frac{p_X(1+t_X)}{p_Y}\neq RMT_{X,Y}$. Impuesto sobre el capital en $X$ ($t_{KX}$): $\lvert RMST\rvert_X=\frac{w}{r(1+t_{KX})}\neq\lvert RMST\rvert_Y$.

**Resultados:** (i) impuesto selectivo sobre $X$: cae la demanda de $X$, se libera sobre todo trabajo y baja $w/r$; lo soporta el factor intensivo en el sector gravado. (ii) Impuesto parcial sobre un factor ($t_{KX}$): **efecto producción** (baja $X$, cuya intensidad decide el signo) y **efecto sustitución factorial** (en $X$ se sustituye $K$ por $L$, baja $r$); con sustitución fácil, el capital de toda la economía soporta el impuesto, incluso más del 100 %. (iii) Equivalencias impositivas: impuesto sobre $L$ y $K$ en un sector ≡ impuesto sobre su producto; impuesto general sobre ambos factores ≡ impuesto general sobre la renta ≡ (consumo) en estático.

**Gráficos de referencia:** (1) caja de Edgeworth de producción con curva de contrato y FPP; (2) impuesto selectivo: movimiento sobre la FPP (0→1) y caída de $w/r$; (3) impuesto sobre $K_X$: efecto producción (0→1) y efecto sustitución factorial (1→2), punto interior a la FPP (pérdida de eficiencia en la producción); (4) tabla de equivalencias impositivas (3×3: $t_{KX}, t_{KY}, t_K$ / $t_{LX}, t_{LY}, t_L$ / $t_X, t_Y, t$). No hay `.tex` todavía.

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 4.B.8 | Incidencia en equilibrio general | Desarrollo | Todo lo anterior, más extensiones (movilidad imperfecta, economía abierta, dinámica, EGC) | — |
| 4.B.9 | Efectos de los impuestos sobre la eficiencia en la producción | Mención (3-4 líneas) | Solo la idea: un impuesto parcial sobre un factor saca a la economía de la FPP (punto interior); «[ver tema 4.B.8]» | Supuestos, ecuaciones y caja de Edgeworth (hoy copiados de 4.B.8) |
| 4.B.12 / 4.B.17 | Incidencia del IS | Mención | Harberger (1962): en economía cerrada lo soporta el capital; en economía abierta, el trabajo (Gravelle, Arulampalam et al.) | — |

## Divergencias encontradas en el temario actual
- **Duplicación:** el apartado 1.4 de 4.B.9 copia casi literal el Harberger de 4.B.8 (supuestos, ecuaciones, caja de Edgeworth). Canon: en 4.B.9 queda una mención de 3-4 líneas con remisión a 4.B.8.
- **Notación:** $W$, $R$ en el modelo unisectorial de 4.B.8 y en 4.B.9; $w$, $r$ en el Harberger de 4.B.8; $t$ ad valorem aquí frente a $t$ unitario en el parcial. Propuesta: $w$, $r$; decir si $t$ es *ad valorem*.
- 4.B.8 deja notas del autor sin resolver («¿la FPP se hace más pequeña? ¿¿??»: no, el impuesto general sobre el consumo no la mueve; uno parcial sobre un factor lleva a un punto interior) y anuncia «modelos de equilibrio general computable» y «n sectores» con el apartado vacío.
- Mismo nombre que el **triángulo de Harberger (1964)** de 4.B.9: nombrarlos siempre distinto (ver `exceso-gravamen.md`).
