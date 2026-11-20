# Teoría de la valoración por arbitraje (APT; Ross, 1976) y modelos factoriales (Fama y French)

- **Área:** finanzas-empresa · **Tema de referencia:** **3.B.23** (Renta variable: análisis fundamental, técnico, cartera y CAPM; revisado el 8/11/2026, `sec:apt`, a)-d), `eq:apt` función clave) — único desarrollo; `mapa.yaml` lo listaba sin ficha. Ficha creada en la pasada final (noviembre de 2026; C59 de las propuestas de contenido del 3.B.23).
- **Temas que lo usan:** 3.B.23 (desarrollo; hecho, 8/11/2026), 3.B.2 y 3.B.3 (mención; hecho, 8/11/2026: «CAPM o APT» para el coste de los fondos propios, con `\vertema{3.B.23}`).
- **Manuales de referencia:** Ross (1976), *JET*; Roll y Ross (1980), *JF*; Chen, Roll y Ross (1986), *JB*; Fama y French (1993, 2015); Carhart (1997); Bodie, Kane y Marcus (2021), *Investments*, cap. 10.

## Presentación de referencia (3.B.23, `sec:apt`)
**Pregunta:** ¿se puede llegar a una relación lineal entre rentabilidad y riesgo sin suponer nada de las preferencias?

**Supuestos (Ross):** rendimientos generados por un modelo factorial lineal con $J$ factores; muchos activos (carteras bien diversificadas sin riesgo específico); mercados competitivos sin fricciones y con ventas en corto; inversores que prefieren más riqueza a menos; **sin oportunidades de arbitraje**. No hacen falta inversores de media-varianza, un activo sin riesgo con préstamo ilimitado ni una cartera de mercado.

**Ecuaciones (notación canónica):**
$$r_i=\mathbb{E}[r_i]+\beta_{i1}F_1+\dots+\beta_{iJ}F_J+\varepsilon_i\quad(\texttt{eq:apt-factorial}),\qquad \mathbb{E}[r_i]=r_f+\beta_{i1}\lambda_1+\dots+\beta_{iJ}\lambda_J\quad(\texttt{eq:apt})$$
$F_j$ sorpresa del factor $j$ (media nula), $\beta_{ij}$ sensibilidad, $\lambda_j$ prima del factor $j$ ($\lambda_M$ del CAPM es el caso $J=1$), $j=1,\dots,J$ (**$J$** número de factores: no $k$, tasa de descuento genérica, ni $m$, factor de descuento estocástico del C-CAPM en el mismo tema).

**Evidencia:** factores macroeconómicos (Chen, Roll y Ross, 1986: producción industrial, inflación no anticipada, prima de crédito, pendiente de la curva); Fama y French (1993) de 3 factores, `eq:fama-french` (mercado, SMB, HML), *momentum* (Carhart, 1997) y 5 factores (2015). ¿Primas por riesgo o errores del mercado?

**Valoración:** supuestos más débiles que el CAPM y varias fuentes de riesgo sistemático, pero no dice cuántos ni cuáles son los factores (el «zoo de factores»); `tab:capm-apt`.

**Gráfico de referencia:** ninguno (la tabla `tab:capm-apt`).

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.B.23 | Cartera y valoración de activos | desarrollo (hecho, 8/11/2026) | Todo lo anterior | — |
| 3.B.2, 3.B.3 | Coste de los fondos propios | mención (hecho, 8/11/2026) | «CAPM o APT» para estimar $r_E$, `\vertema{3.B.23}` | El modelo |

## Divergencias encontradas en el temario actual
- 3.B.2 y 3.B.3 (Word): el mismo párrafo del CAPM y del APT con el CAPM llamado «modelo por arbitraje». **Resuelto** (8/11/2026); sigue en el Word del 3.B.13 (bloque de eficiencia copiado del 3.B.23): al revisarlo, no repetirlo.

Autor: Víctor Gutiérrez Marcos
