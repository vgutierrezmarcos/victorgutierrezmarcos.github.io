# Las zonas objetivo de Krugman (1991): luna de miel y divorcio (Bertola y Caballero, 1992)

- **Área:** macro-abierta · **Tema de referencia:** **3.B.15** (revisado el 11/11/2026, control de calidad y fase canon del 12/11/2026: II.1.3 `sec:krugman` con a)-e), `eq:zona-objetivo`, `fig:zona-objetivo` y el anexo B `anexo:krugman` con la solución paso a paso). Único tema que lo desarrolla. **Ficha nueva** de la fase canon del 3.B.15, **[decidir]**: la propuesta de coherencia del tema (CC6) era dejar el id `zonas-objetivo` sin ficha; se crea porque el modelo fija notación propia que choca con el canon (los fundamentos $f$, véase abajo) y lo usará el 3.B.43 (el SME) y, de pasada, el 3.B.17 y el 3.B.21. *Alternativa*: sin ficha, con la notación en la fila de `notacion.md` § 9. Recoge el id **`zonas-objetivo`** (alias, `_inventario/alias.json`).
- **Temas que lo usan:** 3.B.15 (desarrollo; hecho, 12/11/2026). Previstos: 3.B.43 (mención: las bandas del SME, la peseta en 1989-1993, la ampliación al ±15 % de agosto de 1993; `\vertema{3.B.15}`), 3.B.17 (no lo usa: el abandono de la banda es de la segunda generación, ficha `obstfeld-segunda-generacion`), 3.B.21 (mención posible: el SME y las bandas).
- **Fuentes de referencia:** Krugman (1991), «Target Zones and Exchange Rate Dynamics», *QJE* 106(3) (`Krugman1991Target`; **no confundir** con `Krugman1991Increasing` ni `Krugman1991Geography`); Bertola y Caballero (1992), «Target Zones and Realignments», *AER* (`BertolaCaballero1992Target`); Svensson (1992), *JEP*; Eichengreen y Wyplosz (1993) (`EichengreenWyplosz1993Unstable`). Manuales: Sarno y Taylor (2002), Obstfeld y Rogoff (1996), Gandolfo. Nunca Crespo (2016) ni el tema de ICEX-CECO como fuente del gráfico.

## Presentación de referencia (3.B.15, II.1.3)

Estructura a)-e). **Pregunta:** ¿estabiliza una banda creíble el tipo de cambio más de lo que lo haría la intervención por sí sola?

**a) Idea.** Krugman (1991): sí, porque las expectativas trabajan a favor del banco central; el modelo dio a la credibilidad un papel central en el análisis de los regímenes.

**b) i) Supuestos:** el **enfoque monetario con precios flexibles y PPA** (ficha `enfoque-monetario-tc`, `\vertema{3.B.14}`), en tiempo continuo y en logaritmos, **$e_t=\ln E_t$**:
$$e_t=m_t+v_t+\alpha\,\frac{\mathbb{E}_t[\mathrm{d}e_t]}{\mathrm{d}t}\qquad(\texttt{eq:zona-objetivo})$$
con $m_t$ la oferta monetaria, **$v_t$ perturbación de la demanda de dinero** (renta y velocidad), paseo aleatorio, y **$\alpha>0$ la semielasticidad de la demanda de dinero respecto al tipo de interés** (la α de Cagan, ficha `cagan`; nunca γ); **banda $e^{\min}\le e_t\le e^{\max}$**; la autoridad solo interviene en los bordes (reduce $m_t$ en el depreciado, lo aumenta en el apreciado); banda creíble.

**b) ii) Desarrollo:** sin banda, la recta de 45°, el **tipo sombra $\tilde e=m+v$** (la tilde es «sombra», como $\tilde E$ en `notacion.md` § 9); con banda creíble, cerca del borde depreciado se espera una apreciación y la moneda se aprecia ya: **S aplanada**, menos inclinada que la de 45° y tangente a los bordes (***smooth pasting***).

**b) iii) Implicaciones:** **efecto luna de miel** (la banda estabiliza sola; el tipo pasa mucho tiempo lejos de los bordes; intervención mínima); lo que mueve hoy el tipo es lo que se espera de él mañana.

**c) Extensiones:** **banda sin credibilidad** (Bertola y Caballero, 1992): si se espera un realineamiento en el borde, la expectativa se da la vuelta, la curva es una **S invertida**, más inclinada que la de 45°, y la banda añade volatilidad: el **efecto divorcio** (nombre habitual en la literatura de preparación; no está en Krugman, 1991).

**d) Evidencia:** los datos del SME no se parecían a la S creíble (el tipo pasaba mucho tiempo cerca de los bordes y los diferenciales anticipaban los realineamientos; Bertola y Caballero, 1992). **España**: la peseta entró en el mecanismo de cambios en 1989; tras la salida de la libra el 16/9/1992 (`BoE1992Operation`), se devaluó varias veces en 1992-1993 y en agosto de 1993 las bandas pasaron al ±15 % (Eichengreen y Wyplosz, 1993; `\vertema{3.B.17}`, `\vertema{3.B.43}`): el divorcio de una banda que el mercado dejó de creer.

**e) Valoración:** lo que estabiliza es la credibilidad, no la banda; precios flexibles y fundamentos exógenos; no explica por qué se abandona una banda (segunda generación, `\vertema{3.B.17}`).

**Anexo B del 3.B.15 (solución):** fundamentos $f_t\equiv m_t+v_t$ (**local del anexo y del gráfico**; véase la nota de notación), $\mathrm{d}v_t=\sigma\,\mathrm{d}z_t$; $e_t=g(f_t)$ y, por Itô, $g(f)=f+\tfrac{\alpha\sigma^2}{2}g''(f)$; $g(f)=f+A(\mathrm e^{\lambda f}-\mathrm e^{-\lambda f})$ con $\lambda=\sqrt{2/(\alpha\sigma^2)}$; *smooth pasting* en los bordes de los fundamentos **$\pm\bar f$**: $g'(\bar f)=0\Rightarrow A<0$; $e^{\max}=g(\bar f)$, $e^{\min}=-g(\bar f)$. La solución está derivada en el tema y no cotejada con el artículo (duda 12 del 3.B.15).

**Nota de notación (**[decidir]**):** el canon reserva **$f$ para el logaritmo del tipo a plazo** (D013, `notacion.md` § 9) y la propuesta de coherencia del 3.B.15 (K12) pedía no usarla; el tema escribe los fundamentos $m+v$ en el cuerpo y en el eje del gráfico, pero **$f_t\equiv m_t+v_t$ y $\pm\bar f$ en el anexo B y en el pie y las guías de `fig:zona-objetivo`**. Como en el 3.B.15 no aparece el tipo a plazo, el choque es solo de canon. *Recomendado*: aceptarlo como **local y avisado** («$f$ son aquí los fundamentos, no el tipo a plazo»; el aviso falta hoy en el tema: `pendientes-coherencia.md`, «Pendiente del 3.B.15», cosmético). *Alternativa*: cambiar a otra letra (p. ej. $k_t$ o $\phi_t$; φ ya tiene varios dueños, § 1) en el anexo, el pie y el gráfico.

**Gráfico de referencia:** `oposicion/temario/fuentes/3B15/graficos/zona-objetivo.tex` (`fig:zona-objetivo`): fundamentos $m+v$ en abscisas y $e$ en ordenadas, la paridad central en el origen, escala 1:1 (la de 45° se ve a 45°); capas: ejes; la recta de 45° en `tceeazul` («sin banda: $\tilde e=m+v$»); los bordes $e^{\min}$ y $e^{\max}$ (guías gruesas, $\pm1{,}3366$); la S aplanada en `tceemorado` («banda creíble: luna de miel», $\lambda=1{,}5$, $\bar f=2$); los puntos de tangencia en $\pm\bar f$; la S invertida en `tceerojo` («sin credibilidad: divorcio», toca los bordes en $\pm0{,}80$). Fuente: «Elaboración propia a partir de \textcite{Krugman1991Target} y \textcite{BertolaCaballero1992Target}». En el cante, por partes, la S invertida al final.

## Cómo se adapta en cada tema

| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.B.15 | Regímenes cambiarios | desarrollo (referencia; hecho, 12/11/2026) | II.1.3 a)-e) con `eq:zona-objetivo`, `fig:zona-objetivo`, luna de miel y divorcio, el SME y la peseta; anexo B con la solución | — |
| 3.B.43 | El euro y el SME | mención (prevista) | Las bandas del SME (±2,25 %, ±6 %, ±15 % desde agosto de 1993) y por qué una banda creíble estabiliza sola, `\vertema{3.B.15}`; las fechas y fuentes del 3.B.16 y el 3.B.17 | El modelo |
| 3.B.21 | El SEI desde 1973 | mención (posible) | El SME como sistema de bandas | El modelo |

## Divergencias encontradas en el temario actual

- **Word del 3.B.15** (resuelto el 12/11/2026): $s_t$, $f_t$, $s_{\text{inferior}}$, $s_{\text{superior}}$, γ como semielasticidad, «parte del modelo monetario visto antes» sin remitir al 3.B.14, Imagen 9 con fuente Crespo (2016). Ahora $e_t$, $m_t+v_t$, α, $e^{\min}$, $e^{\max}$, `\vertema{3.B.14}` y fuente Krugman (1991) y Bertola y Caballero (1992). Quedan $f_t$ y $\bar f$ en el anexo y el gráfico (arriba).

Autor: Víctor Gutiérrez Marcos
