# Notación del área macro-abierta (3.A.32, 3.B.11-3.B.19)

Paso 2 del canon (13 oct. 2026). Fuentes: `mapa.yaml`, `_inventario/resumen-por-area.md` (comprobado contra los Word originales de 3.B.12-3.B.19) e inventarios por tema. Manuales base: Krugman, Obstfeld y Melitz (*Economía internacional*); Obstfeld y Rogoff (*Foundations of International Macroeconomics*); Gandolfo (*International Finance and Open-Economy Macroeconomics*); Sarno y Taylor (*The Economics of Exchange Rates*); Blanchard (*Macroeconomía*). Decisiones aprobadas por Víctor el 13/10/2026 (`decisiones.json`): la columna «Canon» es la notación definitiva; `notacion.md` manda si difiere por un choque entre áreas.

## Tabla de símbolos

| Símbolo | Significado | Alternativas que aparecen (temas) | Canon | Motivo |
|---|---|---|---|---|
| $E$ ($E_t$) | Tipo de cambio nominal **directo** (moneda nacional por unidad de extranjera); $\uparrow E$ = depreciación | $E$ (3.B.12, 3.B.13 ap. 1, 3.B.14, 3.B.17 PPA, 3.B.19); $s_t$ en las paridades **dentro de** 3.B.13 y 3.B.14 y en 3.B.25; $e$, $\tilde e$, $\bar e$ en 3.B.17 | **$E$ en niveles en todos los temas; $\tilde E$ sombra, $\bar E$ fijo** | Es la letra que más temas usan y la de Krugman-Obstfeld; $s_t$ (Sarno-Taylor) solo aparece en las paridades y obliga a cambiar de letra a mitad de tema |
| $F_t^{t+1}$ | Tipo de cambio a plazo (*forward*) | $f_t^{t+1}$ (3.B.13, 3.B.14), $f_t$ (3.B.25) | **$F$** en niveles | Coherente con $E$ en mayúscula; $F_0$ es también la notación de Hull para el precio a plazo |
| $e_t$, $f_t$ (minúscula) | **Logaritmos** de $E_t$ y $F_t$ (Dornbusch, enfoque monetario, contraste de Fama) | $s_{t+1}-s_t$ en niveles (3.B.13); $\ln E_t$ (3.B.13 anexo) | Minúscula = logaritmo, solo donde haga falta | Convención de Obstfeld-Rogoff y Sarno-Taylor; libera la mayúscula para el nivel |
| $E^e_{t+1}$, $\gamma E^e$ | Tipo esperado y depreciación esperada | $E_t[s_{t+1}]$ (3.B.13, 3.B.14), $s^e_{t+1}$ (3.B.14), $\gamma E^e$ (3.B.13, 3.B.14) | **$E^e_{t+1}$** y $\gamma E^e \equiv (E^e_{t+1}-E_t)/E_t$ | Evita el choque entre el operador esperanza $E_t[\cdot]$ y el tipo de cambio $E_t$ (motivo por el que la literatura usa $S$/$s$). Si hace falta el operador, escribir $\mathbb{E}_t[\cdot]$ |
| $q$ | Tipo de cambio **real** $q = EP^*/P$; $\uparrow q$ = depreciación real | $\varkappa$ (3.B.12-3.B.15, 3.B.19, 4.B.4); $e$ (3.B.19, NOEM); $\chi$ (3.B.13, regresión del anexo) | **$q$** | $q$ es la de Krugman-Obstfeld y Obstfeld-Rogoff; $\varkappa$ se confunde con $\kappa$ (desutilidad del trabajo en 3.B.19) y no está en los manuales. Choque menor con $q$ de Tobin (3.A.34) y con cantidades $q_i$ de comercio: áreas que no se mezclan en el mismo tema |
| $E^{ef}$, $q^{ef}$, $\omega_i$ | Tipos efectivos nominal y real; pesos de comercio | $\sum \alpha_i E_i$ (3.B.13); $\beta_i$ (4.A.22) | Media **geométrica** con pesos $\omega_i$ | Así se calculan los índices oficiales (BCE, BdE) |
| $Y$, $Y^*$ | Renta nacional y renta **extranjera** | $Y^*$ = renta extranjera (3.B.14, 3.B.15, 3.B.19, 4.B.4); $Y^*$ = **PIB objetivo del Gobierno** (3.B.17, Obstfeld 1996) | **$Y^*$ siempre extranjera**; objetivo del Gobierno $Y^{obj}$ (o $\tilde Y$) y producción natural $Y_n$ en 3.B.17 | El asterisco marca «extranjero» en todo el bloque (i^*, P^*, Y^*); 3.B.17 lo usa para otra cosa dentro de un tema que también usa $i^*$ |
| $i$, $i^*$; $r$, $r^*$ | Tipos de interés nominales; reales | $r/i$ indistintos (3.B.12: IS con $r$; 3.B.14 borrador IS-LM-BP con $r$) | $i$ nominal, $r$ real; con precios fijos (Mundell-Fleming) se dice $i = r$ y se usa $i$ | Coherencia con macro cerrada (Fisher) |
| $m$ | Propensión marginal a **importar** | Bien en 3.B.12, 3.B.15, 3.B.19; pero 3.B.12 la llama «propensión marginal **al consumo**, $m$» | $m$ = propensión a importar; $c$ = a consumir | Error de 3.B.12 |
| $x$ | Propensión a exportar (sensibilidad de $X$ a $Y^*$) | $x$ (3.B.15, 3.B.19) | Mantener | — |
| $\nu$ | Sensibilidad del saldo comercial al tipo real | $\phi$/$\varphi$ (3.B.15, 3.B.19, 4.B.4) | **$\nu$** | $\varphi$ queda para la productividad de Melitz (comercio) y ya tiene otros dos significados en 3.B.7 y 3.B.8 |
| $\beta$ | Movilidad del capital en la BP: $\beta = 0$ **nula**, $\beta\to\infty$ **perfecta** | Igual (3.B.15, 3.B.19, 4.B.4) | Mantener | Choque tolerable con $\beta$ del CAPM y de las regresiones (áreas distintas, siempre definida) |
| $CI$, $R$, $\Delta R$ | Crédito interno; reservas (stock); variación de reservas (flujo) | $BP \equiv R$ (3.B.12, error) | $\Delta R$ para el saldo de la BP con tipo fijo | Error de 3.B.12 |
| $B$, $b$; $D$, $d$ | Deuda exterior y déficit; minúsculas en % del PIB | $D^*$ deuda (3.B.17); $B$ deuda y $D$ déficit (3.B.12) | $B$/$b$ deuda, $D$/$d$ déficit | Coherente con la dinámica de la deuda pública (sector público) |
| $\gamma_X$, $\gamma^X$ | Tasa de variación de $X$ | $\gamma E^e$, $\gamma^Y$ (3.B.12, 3.B.13, 3.B.14) | **$\gamma_X$**, con subíndice, para las tasas de variación (convención del temario) | Choca con $\gamma$ = peso de las manufacturas en la NEG (3.B.6, 3.B.9, 3.B.10, 3.B.16): ver `_notacion/comercio.md` |
| $W$, $M$, $B$, $B^*$ | Riqueza, dinero, bonos nacionales y extranjeros (Branson) | $W = M + B + EB^*$ (3.B.14) | Mantener ($F$ libre para el *forward*) | — |
| $\mu$ | (i) Crecimiento del crédito interno (Krugman 1979, Flood-Garber); (ii) tono monetario de Corsetti-Pesenti | (i) 3.B.17; (ii) 3.B.19 | Mantener ambos, definidos en cada tema | Notación de los artículos originales; temas que no se mezclan |
| $\alpha$ | Peso de la inflación en la pérdida (Obstfeld/Jeanne) y participación del capital (Krugman 1999) **dentro de 3.B.17** | 3.B.17 | Pérdida con $\alpha$; participación del capital con la notación de macro cerrada (`cobb-douglas`/`solow`) | Doble significado en el mismo tema |
| Multiplicador monetario | Coeficientes de efectivo y de reservas | $(e+1)/(e+q)$ en 3.B.17 ($e$ = coeficiente de efectivo); $m^m$ en 3.B.12 | **La del canon de macro cerrada (`multiplicador-monetario`)**; nunca $e$ ni $m$ | $e$ es tipo de cambio (y su logaritmo) y $m$ propensión a importar |

## Conflictos reales y cómo se resuelven

1. **Tipo de cambio $E$ frente a $s_t$** (incluso dentro de 3.B.13 y de 3.B.14): $E$ en niveles, $F$ a plazo, minúsculas para logaritmos y $E^e_{t+1}$ para expectativas.
2. **$Y^*$**: renta extranjera en todo el temario; en 3.B.17 el objetivo del Gobierno pasa a $Y^{obj}$.
3. **$e$** con tres significados (coeficiente de efectivo y tipo de cambio sombra/fijo en 3.B.17; tipo de cambio real en 3.B.19): $e$ solo como logaritmo de $E$.
4. **Tipo de cambio real** $\varkappa$ frente a $q$.
5. **$\varphi$/$\phi$** como sensibilidad de XN a $\varkappa$: $\nu$.
6. **Nombres**: PDI (3.B.13) frente a PNCI (3.B.14): PNCI con PDI como sinónimo.

## Choques con otras áreas
- **Comercio**: $\gamma$ (tasa de variación aquí; peso de las manufacturas en la NEG, que 3.B.16 trae a este bloque); $\varphi$ (Melitz); $q$ (cantidades por empresa en 3.B.6 y 3.B.8).
- **Macro cerrada**: IS-LM ($k$, $h$, $v$, $c$, $t$) debe ser la misma que en la LM e IS cerradas; multiplicador monetario; $q$ de Tobin.
- **Finanzas**: $F_0$/$S_0$ de derivados (3.B.25) frente a $F$/$E$ de divisas: en 3.B.25 se usa la de Hull y se avisa de la equivalencia ($S_0 \equiv E_0$).
- **Sector público**: dinámica de la deuda ($b$, $d$, $r$, $\gamma^Y$) igual que en la deuda exterior.

## Errores de contenido detectados (para la revisión de cada tema)
- 3.B.12: «propensión marginal al consumo, $m$» (es a importar); $BP\equiv R$ (es $\Delta R$); anexo copiado de 3.B.14.
- 3.B.13: $\ln(1+i) = \ln(1+i^*)\cdot\ln(\dots)$ (es suma; según el inventario: no se localiza en la extracción de texto porque está en una ecuación de imagen u OMML, comprobar en la revisión); en la PCI el margen *forward* se llama «tasa de depreciación esperada»; «el arbitraje garantiza el cumplimiento continuo de la PDI»; tipo efectivo como media aritmética.
- 3.B.14: «Implicaciones» de la paridad sin expectativa ($s_{t+1}$ en lugar de $E_t s_{t+1}$); apartado IS-LM-BP en borrador.
- 3.B.15 (copiado en 3.B.19): «movilidad **perfecta** de capital, $\beta = 0$, BP vertical» (es movilidad **nula**).
- 3.B.17: $Y^*$ objetivo; $e$ coeficiente de efectivo; $\alpha$ con dos significados.
- 3.B.19: apartado «Ilustración práctica: G-20, OCDE y otros» vacío.

Autor: Víctor Gutiérrez Marcos
