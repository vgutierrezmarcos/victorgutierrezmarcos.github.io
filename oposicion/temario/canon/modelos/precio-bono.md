# Precio y rendimiento de un bono: flujos descontados con tipos de contado y rentabilidad a vencimiento

- **Área:** finanzas-empresa · **Tema de referencia:** **3.B.24** (lo tiene en el título: «Determinación del precio y rendimiento de los bonos»; revisado el 13/11/2026, I.4-I.5) — desarrollo. Ficha creada en la pasada final (noviembre de 2026) con el borrador KC1 de `fuentes/3B24/_trabajo/propuestas-coherencia.md` (hasta entonces, alias vacío).
- **Temas que lo usan:** 3.B.24 (desarrollo; hecho, 13/11/2026), 3.B.2 (mención; hecho, 8/11/2026: la TIR del bono es su rentabilidad a vencimiento, con los 3 supuestos), 3.A.35 (mención; hecho, 5/11/2026: el precio baja cuando sube el tipo), 3.B.25 (mención; hecho, 8/11/2026: bonos con opciones; el *swap* como diferencia de 2 bonos con los tipos de contado, en continuo), 3.B.3 (mención; hecho, 8/11/2026: obligaciones y CoCos), 3.B.23 (mención; hecho, 8/11/2026: `tab:renta-fija-variable`), 4.B.26 y 4.A.20 (mención: letras, bonos y obligaciones del Tesoro).
- **Manuales de referencia:** Bodie, Kane y Marcus (2021), *Investments*, caps. 14-16; Fabozzi, *Bond Markets, Analysis and Strategies*; Hull (2022), cap. 4 (en continuo).

## Presentación de referencia (3.B.24, I.4-I.5)
**Pregunta:** ¿cuánto vale un bono y cuánto rinde?

**Ecuaciones (notación canónica):** función clave `eq:precio-contado`, $P=\sum_{t=1}^{T}\mathrm{FC}_t/(1+r_t)^t$ (cada flujo es un *strip*, un cupón cero que vale $\mathrm{VN}/(1+r_t)^t$: igualdad de arbitraje); con un solo tipo, `eq:precio-bono` (caja), $P=\sum_t\mathrm{FC}_t/(1+r_t)^t=\sum_t\mathrm{FC}_t/(1+y)^t$, que **define** $y$. Rentabilidad corriente $C/P$ (sin letra); la TIR con sus **3 supuestos**, en las palabras del 3.B.2; rentabilidad realizada; *yield-to-call* $y^{\mathrm{call}}$ (local); precio limpio + cupón corrido = sucio; *pull to par*. A la par si $c=y$, bajo la par si $c<y$, sobre la par si $c>y$.

**Notación:** $P$ precio; $\mathrm{VN}$ nominal (redonda); $c$ tasa de cupón y $C_t=c\,\mathrm{VN}$; $\mathrm{FC}_t$ ($=C_t$ si $t<T$; $C_T+\mathrm{VN}$ en $T$; D085); $y$ TIR (aviso: en macro, $y$ es el logaritmo de la producción); $r_t$ tipo de contado a $t$ años. Cupones anuales en el cuerpo; $m$ cupones por año solo en nota.

**Relación con `van-tir`:** el precio es el desembolso que hace nulo el VAN y la TIR del bono es su rentabilidad a vencimiento.

**Gráfico de referencia:** `oposicion/temario/fuentes/3B24/graficos/precio-rentabilidad.tex` (curva precio-rentabilidad convexa, **por capas**, compartida con `duracion-convexidad`: la curva, la tangente con pendiente $-D^{\mathrm{mod}}P$, el error de la tangente); de apoyo, `linea-temporal-bono.tex`, `pull-to-par.tex`, `precio-sucio.tex`, `opciones-bono.tex`.

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.B.24 | Precio y rendimiento de los bonos | desarrollo (hecho, 13/11/2026) | Todo lo anterior | — |
| 3.B.2 | Criterios de valoración | mención (hecho, 8/11/2026) | La TIR = rentabilidad a vencimiento, con sus 3 supuestos | — |
| 3.A.35 | Demanda de dinero | mención (hecho, 5/11/2026) | La relación inversa precio-tipo, sin fórmula | La fórmula |
| 3.B.25 | Derivados | mención (hecho, 8/11/2026) | En continuo ($e^{-r_tt}$); el *swap* como diferencia de 2 bonos | — |
| 3.B.3, 3.B.23 | Financiación; renta variable | mención (hecho, 8/11/2026) | Obligaciones, CoCos; renta fija frente a variable | — |

## Divergencias encontradas en el temario actual
- 3.B.24 (original): «Precio», «Cupón», «Valor facial», «YTM»; la fórmula sin el nominal (P58); «i» como tasa de cupón. **Resuelto** (13/11/2026).

Autor: Víctor Gutiérrez Marcos
