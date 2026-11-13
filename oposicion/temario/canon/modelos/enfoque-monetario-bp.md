# Enfoque monetario de la balanza de pagos

- **Área:** macro-abierta · **Tema de referencia:** **3.B.12** (Mecanismos de ajuste de la balanza de pagos), **revisado el 11/11/2026**: lo desarrolla en II.2 (`sec:enfoque-monetario`) con a)-d), `eq:oferta-monetaria` y la función clave `eq:enfoque-monetario`, y lo resume en la tabla `tab:mecanismos-ajuste` frente al flujo-especie y la cartera.
- **Temas que lo usan:** 3.B.12 (desarrollo; hecho, 11/11/2026), 3.B.22 (mención). También 3.A.5 (mención; hecho, 3/11/2026: III.1.3, Harry Johnson y el enfoque monetario con tipo fijo (Frenkel y Johnson, 1976), `\vertema{3.B.12}`). También 3.B.14 (contraste; hecho, 11/11/2026), 3.A.32 (mención; hecho, 11/11/2026, l. 185, falta `\vertema{3.B.12}`: pendiente C3 del 3.B.14).
- **Ficha hermana:** `enfoque-monetario-tc` (referencia el 3.B.14). **Reparto** (fase canon del 3.B.12, 11/11/2026): **con tipo fijo la incógnita es $\Delta R$ (aquí, 3.B.12); con tipo flexible, $E$ (allí, 3.B.14)**. Es la misma condición de equilibrio del mercado de dinero y la misma demanda de dinero: el 3.B.12 la escribe $M^D=P\,L(Y,i)$ en niveles (la LM del § 8, $M/P=kY-h\,i$, con $k$ y $h$ en la valoración del multiplicador); el 3.B.14 la escribe en logaritmos, $m-p=k\,y-h\,i$. Ninguno deriva el del otro: cada tema dice lo simétrico en una línea y remite (el 3.B.12 en su c) Extensiones con `\vertema{3.B.14}`; el 3.B.14 en la presentación del II con `\vertema{3.B.12}`).
- **Fuentes de referencia** (fijadas en el 3.B.12): **Johnson (1972)** (`Johnson1972Monetary`) y **Frenkel y Johnson (1976)** (`FrenkelJohnson1976Monetary`); la regla del $k$ % de **Friedman (1960)** (`Friedman1960Program`; nunca Phelps); Krugman (1979) (`Krugman1979Model`) para la crisis cuando se agotan las reservas; Polak (1957) para la programación financiera del FMI. Manuales: Gandolfo, *International Finance and Open-Economy Macroeconomics*, cap. 12 (`Gandolfo2016International`); Krugman, Obstfeld y Melitz, cap. 18.

## Presentación de referencia (3.B.12, II.2)
**Pregunta:** ¿por qué un desequilibrio de la BP con tipo fijo es un fenómeno monetario que se corrige solo?

**Idea:** con tipo fijo, un desequilibrio de la balanza de pagos es un desequilibrio del mercado de dinero y se corrige solo, a través de las reservas. Se parece al flujo-especie (tipo fijo, ajuste automático, dinero ligado a las reservas), pero lo que se ajusta son las **reservas**, no los precios, porque los precios están fijados fuera (ley del precio único).

**Supuestos:** país pequeño con tipo fijo $\overline E$; pleno empleo ($Y$ dada); ley del precio único en bienes y activos, con sustituibilidad perfecta y libre circulación de capitales ($P=\overline EP^*$, $i=i^*$); demanda de dinero estable, $M^D=P\,L(Y,i)$ (`\vertema{3.A.35}`); **multiplicador del dinero igual a 1, sin letra** (el dinero es la base; `\vertema{3.A.36}`, ficha `multiplicador-monetario`).

**Ecuaciones (notación canónica):**
$$M^S=\mathrm{CI}+R\quad(\texttt{eq:oferta-monetaria}),\qquad M^D=P\,L(Y,i),$$
$$\Delta R=\Delta M^D-\Delta\mathrm{CI}\quad(\text{función clave }\texttt{eq:enfoque-monetario})$$
$\mathrm{CI}$ y $R$ en redonda/cursiva como en el § 9; **$\Delta R$ es el saldo (flujo) y $R$ el *stock*: nunca «$\mathrm{BP}\equiv R$»**. En palabras: el saldo de la balanza de pagos es la diferencia entre lo que crece la demanda de dinero y lo que crea el banco central; la cantidad de dinero la decide el público. Nota: la BP siempre cuadra; lo que se ajusta es el saldo de las transacciones autónomas (por encima de la línea), y las reservas lo compensan (`\vertema{3.B.11}`).

**Mecanismo:** una expansión del crédito interno ($\Delta\mathrm{CI}>0$, $\Delta M^D=0$) deja al público con exceso de dinero; como los precios están dados y la producción en el pleno empleo, lo cambia por bienes y activos de fuera: déficit (corriente o financiero, sobre todo financiero) y salida de reservas hasta $\Delta R=-\Delta\mathrm{CI}$. Solo cambia la **composición** de la base monetaria.

**Implicaciones:** (1) la BP es un fenómeno monetario y sus desequilibrios son transitorios; (2) **la política monetaria no controla la oferta monetaria**: una expansión del crédito **sí** afecta a la BP (pierde reservas por el mismo importe) pero no cambia la oferta monetaria, la renta ni los precios (el Word decía lo contrario); con tipo fijo y capital libre, la monetaria es ineficaz (trilema, `\vertema{3.B.15}`); si se insiste, crisis de BP (Krugman, 1979, `\vertema{3.B.17}`); (3) **regla de crédito** $\Delta\mathrm{CI}=\Delta M^D$, que con demanda proporcional a la renta nominal es la del $k$ % de Friedman (1960); techos de crédito del FMI (`\vertema{3.B.22}`); (4) **una devaluación solo tiene efectos transitorios**: sube $P=\overline EP^*$ y $M^D$, entran reservas ($\Delta R=\Delta M^D>0$) hasta que la oferta alcanza a la demanda.

**Valoración:** pleno empleo, ajuste automático y variables agregadas; su punto débil es la ley del precio único (los no comerciables; activos no sustitutos perfectos, que es lo que relaja la cartera, ficha `branson`).

**Gráfico de referencia:** ninguno en el 3.B.12 (se canta con la ecuación; la comparación con los demás enfoques va en `tab:mecanismos-ajuste`, fila «Monetario (Johnson)»: qué se ajusta $R$; tipo fijo, precio único, pleno empleo; $\Delta R=\Delta M^D-\Delta\mathrm{CI}$; crédito interno al ritmo de $M^D$). Si un tema lo necesita: mercado monetario con $M^S=\mathrm{CI}+R$ y $M^D$.

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.B.12 | Mecanismos de ajuste de la BP | desarrollo (hecho, 11/11/2026) | II.2 a)-d) con `eq:oferta-monetaria` y la función clave `eq:enfoque-monetario`; el contraste con el flujo-especie en la Idea; la fila de `tab:mecanismos-ajuste`; con tipo flexible, una línea con `\vertema{3.B.14}` | — |
| 3.B.22 | El FMI | mención | Enfoque monetario (Johnson, 1972) y absorción (Alexander, 1952) como fundamento del modelo de Polak y la programación financiera; techos de crédito interno | Derivación del modelo |
| 3.B.17 | Crisis de BP | supuesto (hecho, 12/11/2026) | La 1.ª generación parte de `eq:balance-bc` $M^S_t=\mathrm{CI}_t+R_t$ con el multiplicador igual a 1 sin letra y remite aquí (`\vertema{3.B.12}`); con la paridad, $\Delta R=-\Delta\mathrm{CI}$ automático (ficha `flood-garber`) | Volver a derivar $\Delta R=\Delta M^D-\Delta\mathrm{CI}$ |
| 3.A.5 | Monetarismo (economía abierta) | mención (hecho, 3/11/2026) | Con tipo de cambio fijo, un desequilibrio exterior es un exceso de oferta o de demanda de dinero que se corrige con las reservas (Frenkel y Johnson, 1976), `\vertema{3.B.12}` | $M = \mathrm{CI} + R$ y la derivación |
| 3.B.14 | Determinación del tipo de cambio | contraste (hecho, 11/11/2026) | Presentación del II: nace para la BP con tipo fijo (`FrenkelJohnson1976Monetary`): un exceso de oferta de dinero se va por la BP y se pierden reservas, `\vertema{3.B.12}`; con tipo flexible ajusta el tipo de cambio (ficha hermana `enfoque-monetario-tc`, referencia el 3.B.14) | El ajuste de las reservas |
| 3.A.32 | OA-DA abierta | mención (hecho, 11/11/2026) | l. 185: fondos frente a flujos con `FrenkelJohnson1976Monetary`; falta `\vertema{3.B.12}` (pendiente C3 del 3.B.14) | La ecuación |

## Divergencias encontradas en el temario actual
- **Resuelto en el 3.B.12 (11/11/2026):** $\mathrm{BP}\equiv R$ (*stock*) y las desigualdades con una identidad → $\Delta R$; $M^S=B^m\cdot m^m$ con $m^m=\frac{e+1}{e+q}=1$ → «multiplicador del dinero igual a 1», sin letra; $M^D=f(\overline P,\overline Y,\overline i)$ → $M^D=P\,L(Y,i)$; la implicación «la política monetaria no tiene efectos en la balanza de pagos» al revés → corregida; la regla del $k$ % atribuida a Phelps → Friedman (1960).
- **3.B.17: resuelto** (revisado el 12/11/2026): el Word escribía $M^S=M_0\cdot\frac{e+1}{e+q}=1$; ahora «multiplicador del dinero igual a 1», sin letras.

Autor: Víctor Gutiérrez Marcos
