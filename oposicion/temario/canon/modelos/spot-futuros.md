# Paridad *spot-forward*: precio de un futuro o un *forward* por no arbitraje (coste de mantenimiento)

- **Área:** finanzas-empresa · **Tema de referencia:** **3.B.25** (Instrumentos y mercados de derivados; revisado el 8/11/2026, I.5 con a)-e), `eq:spot-forward` función clave) — desarrollo. Ficha creada en la pasada final (noviembre de 2026) a propuesta del 3.B.25 (§ 9, punto 1).
- **Temas que lo usan:** 3.B.25 (desarrollo; hecho, 8/11/2026), 3.B.13 y 3.B.14 (resumen: la PCI como caso, $F_0=S_0e^{(i-i^*)T}$; ficha `paridad-intereses`), 3.B.24 (mención: los tipos a plazo; ficha `ett-expectativas`).
- **Manuales de referencia:** Hull (2022), *Options, Futures and Other Derivatives*, cap. 5; Bodie, Kane y Marcus (2021), cap. 22.

## Presentación de referencia (3.B.25, I.5)
**Pregunta:** ¿cuánto vale hoy comprar a plazo?

a) **Idea:** hay 2 formas de tener el activo en $T$: comprarlo hoy y guardarlo, o comprar hoy un *forward*; sin arbitraje cuestan lo mismo. b) **Supuestos:** sin costes de transacción ni impuestos; se presta y se pide prestado a $r$; ventas en corto. **Desarrollo:** *cash and carry* y su inversa; función clave
$$F_0=S_0\,e^{rT}\qquad(\texttt{eq:spot-forward})$$
c) **Extensiones** (recuadradas sin morado): con renta conocida $F_0=(S_0-I)e^{rT}$; con rendimiento $F_0=S_0e^{(r-q)T}$; materias primas $F_0=S_0e^{(r+u-y)T}$ (`eq:coste-mantenimiento`); divisas $F_0=S_0e^{(i-i^*)T}$, la PCI `\vertema{3.B.13}` `\vertema{3.B.14}`. d) **Evidencia:** el WTI de abril de 2020 (contango extremo por el coste de almacenamiento). e) **Valoración:** la paridad no dice si $F_0$ predice $S_T$ (ficha `expectativas-contango`).

**Notación:** $F_0$ precio a plazo (un futuro no tiene precio de ejercicio), $S_0$ contado; $r$ tipo sin riesgo **continuo** (el $r_f$ de D063); locales con aviso: $I$ rentas del subyacente (no la inversión), $q$ rendimiento, $u$ coste de almacenamiento, $y$ rendimiento de conveniencia (no la TIR del bono).

**Gráfico de referencia:** ninguno propio (el de pago, `fuentes/3B25/graficos/pago-futuro.tex`). Pegatina: «lo que se gana en los columpios se pierde en los tiovivos».

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.B.25 | Valoración de futuros y *forwards* | desarrollo (hecho, 8/11/2026) | Todo lo anterior | — |
| 3.B.13, 3.B.14 | Mercado de divisas; determinación | resumen | La PCI como caso de la paridad, en continuo | Las extensiones con $I$, $q$, $u$, $y$ |
| 3.B.24 | Renta fija | mención | Tipos a plazo implícitos | — |

## Divergencias encontradas en el temario actual
- 3.B.25 (original): $F_0=(S_0-I)e^{r_F}$ sin $T$; $s_t$, $f_t$ en la PCI; la «rentabilidad $F/S_0$» de la nota 18. **Resuelto** (8/11/2026).

Autor: Víctor Gutiérrez Marcos
