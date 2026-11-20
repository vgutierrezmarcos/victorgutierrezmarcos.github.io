# Duración de Macaulay y modificada, convexidad, inmunización y brecha de duración

- **Área:** finanzas-empresa · **Tema de referencia:** **3.B.24** (lo tiene en el título; revisado el 13/11/2026, III.2) — desarrollo, con las derivaciones en el anexo A. Ficha creada en la pasada final (noviembre de 2026) con el borrador KC1 del 3.B.24.
- **Temas que lo usan:** 3.B.24 (desarrollo; hecho, 13/11/2026), 3.B.26 (resumen; hecho, 12/11/2026: la brecha de duración con $D^{\mathrm{mod}}_{\mathrm A}$ y $D^{\mathrm{mod}}_{\mathrm P}$ y Silicon Valley Bank), 3.B.25 (mención; hecho, 8/11/2026: los IRS para cerrar la diferencia de sensibilidad), 3.B.27 (mención: el riesgo de tipo de interés de la cartera bancaria, IRRBB), 1D01 (mención; hecho: la vida media de la deuda), 3.A.39 (mención posible).
- **Manuales de referencia:** Macaulay (1938); Redington (1952); Fisher y Weil (1971); Malkiel (1962); Homer y Liebowitz (1972); Bodie, Kane y Marcus (2021), cap. 16.

## Presentación de referencia (3.B.24, III.2)
**Pregunta:** ¿cuánto cambia el precio de un bono cuando cambian los tipos, y cómo se protege una cartera?

**Ecuaciones (funciones clave del 3.B.24):** `eq:macaulay` $D=\sum_{t=1}^{T}t\,w_t$, $w_t=\dfrac{\mathrm{FC}_t/(1+y)^t}{P}$ (plazo medio de los flujos ponderado por su valor actual; elasticidad del precio respecto a $1+y$ con curva plana); `eq:duracion-modificada` $D^{\mathrm{mod}}=D/(1+y)=-\frac1P\frac{dP}{dy}$; $D^{\mathrm{mon}}\equiv P\,D^{\mathrm{mod}}$ y $\mathrm{DV01}=P\,D^{\mathrm{mod}}\times0{,}0001$; `eq:convexidad` $\mathrm{Conv}=\frac1P\frac{d^2P}{dy^2}$; **`eq:precio-duracion-convexidad`** $\Delta P/P\simeq-D^{\mathrm{mod}}\Delta y+\tfrac12\mathrm{Conv}(\Delta y)^2$. Las 6 proposiciones (5 de Malkiel y 1 de Homer y Liebowitz). Inmunización (Redington, 1952: valor actual y duración iguales, convexidad del activo mayor; Fisher y Weil, 1971: duración igual al horizonte, el riesgo de precio y el de reinversión se compensan). Brecha de duración `eq:brecha-duracion` con $\Delta y$ y curva plana.

**Ejemplo canónico:** bono a 3 años, cupón del 5 %, nominal 100, $y=5$ %: $P=100$, $D=2{,}86$, $D^{\mathrm{mod}}=2{,}72$, $\mathrm{Conv}=10{,}2$; si $y$ sube al 6 %, la duración predice −2,72 % y con la convexidad −2,67 % (precio exacto 97,33).

**Notación:** $D$, $D^{\mathrm{mod}}$, $D^{\mathrm{mon}}$, DV01, $\mathrm{Conv}$ en redonda (no $C$, el cupón; ni $\mathcal C$, el núcleo del 3.A.14); $\Delta y$ (también en la brecha); $w_t$ pesos locales; $D^{\mathrm{mod}}_{\mathrm A}$, $D^{\mathrm{mod}}_{\mathrm P}$, $V$, $V_D$, $V_E$ en la brecha.

**Gráficos de referencia** (`oposicion/temario/fuentes/3B24/graficos/`): `precio-rentabilidad.tex` por capas (ficha `precio-bono`) y `balanza-duracion.tex` (la balanza de Macaulay); de apoyo, `malkiel-bonos.tex`, `convexidad-bonos.tex`, `inmunizacion-horizonte.tex`.

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.B.24 | Riesgo y rendimiento de los bonos | desarrollo (hecho, 13/11/2026) | Todo lo anterior | — |
| 3.B.26 | Gestión de riesgos | resumen (hecho, 12/11/2026) | Brecha de duración, SVB | Las proposiciones de Malkiel |
| 3.B.25 | Derivados | mención (hecho, 8/11/2026) | IRS para ajustar la duración | — |
| 3.B.27 | Regulación financiera | mención (prevista) | IRRBB | — |
| 1D01 | Dictamen | mención (hecho) | Vida media de la deuda | — |

## Divergencias encontradas en el temario actual
- `informe-repaso.md` l. 227 (la $r$ que sobraba en la duración monetaria): **resuelto** en el 3.B.24 ($D^{\mathrm{mon}}=P\,D^{\mathrm{mod}}$).
- 3.B.26 (revisado), l. 887: escribe $\Delta i$ en la brecha de duración; canon $\Delta y$ (`pendientes-coherencia.md`, cosmético; **[decidir]** D5 del 3.B.24).

Autor: Víctor Gutiérrez Marcos
