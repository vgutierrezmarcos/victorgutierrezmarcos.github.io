# Diferenciación vertical: Gabszewicz y Thisse (1979) y Shaked y Sutton (1982, 1983)

- **Área:** mercados-información-juegos · **Tema de referencia:** **3.A.18** (Diferenciación de productos; revisado el 19/10/2026, III.1, con el anexo `anexo:finitud`) — el único tema del 3.er ejercicio que lo desarrolla con a)-e). Ficha creada a raíz de esa revisión (K41, K47).
- **Temas que lo usan:** 3.A.18 (desarrollo; hecho, 19/10/2026), 3.A.19 (mención: oligopolio natural de Shaked y Sutton, 1983, en su nota 15, que remite al 3.A.18), 3.B.6 (resumen: diferenciación vertical en el comercio, junto a Falvey, l. 379-385 del Word; ficha `falvey`), 3.A.17 (mención; el 3.A.18 remite allí la discriminación por calidades de Mussa y Rosen, 1978, ficha `discriminacion-precios`).
- **Manuales de referencia:** Gabszewicz y Thisse (1979), *JET*; Shaked y Sutton (1982), «Relaxing Price Competition through Product Differentiation», *REStud*; Shaked y Sutton (1983), «Natural Oligopolies», *Econometrica*; Tirole (1988), cap. 7; Sutton (1991), *Sunk Costs and Market Structure*; Mussa y Rosen (1978).

## Presentación de referencia (3.A.18, III.1)

Pregunta: cuando todos prefieren más calidad, ¿qué calidades eligen las empresas y cuántas caben en el mercado? Conclusión: **diferenciación máxima de calidades** para suavizar la competencia en precios y **propiedad de finitud**: el número de empresas está acotado aunque el mercado crezca (oligopolio natural).

- **a) Idea**: la calidad es la decisión que se toma antes que el precio; duopolio de calidades con competencia en precios (Gabszewicz y Thisse, 1979; Shaked y Sutton, 1982) y su consecuencia sobre el número de empresas (Shaked y Sutton, 1983), presentados como Tirole (cap. 7).
- **b) Modelo.** i) Supuestos: cada consumidor compra como mucho una unidad, $U=\theta\,s-p$, con $s$ calidad y θ su valoración de la calidad, uniforme en $[\underline\theta,\overline\theta]$, $\overline\theta-\underline\theta=1$ (gustos o renta); 2 empresas con el mismo coste marginal $c$, que no depende de la calidad (la calidad cuesta en I+D, coste fijo), calidades $s_{\mathrm A}>s_{\mathrm B}$ (alta y baja) en $[\underline s,\overline s]$; juego en 2 etapas por inducción hacia atrás (3.A.14): 1) calidades; 2) precios; mercado cubierto. ii) Desarrollo: consumidor indiferente $\tilde\theta=(p_{\mathrm A}-p_{\mathrm B})/(s_{\mathrm A}-s_{\mathrm B})$, $x_{\mathrm A}=\overline\theta-\tilde\theta$, $x_{\mathrm B}=\tilde\theta-\underline\theta$; con $\Delta s\equiv s_{\mathrm A}-s_{\mathrm B}$, equilibrio de Nash en precios (`eq:shaked-sutton`):
$$p_{\mathrm{A}}^*=c+\frac{2\overline{\theta}-\underline{\theta}}{3}\,\Delta s>p_{\mathrm{B}}^*=c+\frac{\overline{\theta}-2\underline{\theta}}{3}\,\Delta s,\qquad B_{\mathrm{A}}^*=\frac{(2\overline{\theta}-\underline{\theta})^2}{9}\,\Delta s>B_{\mathrm{B}}^*=\frac{(\overline{\theta}-2\underline{\theta})^2}{9}\,\Delta s,$$
  si $\overline\theta>2\underline\theta$ (si no, la calidad baja se queda sin clientes). Márgenes proporcionales a Δs (como $b-a$ en Hotelling). 1.ª etapa: los 2 beneficios crecen con Δs: $\overline s$ y $\underline s$. iii) Implicaciones: diferenciación máxima de calidades; pugna por el liderazgo (2 equilibrios; si eligen por turnos, la primera se queda la alta); **propiedad de finitud** (Shaked y Sutton, 1983): si la calidad cuesta sobre todo en costes fijos, el número de empresas con cuota está acotado aunque el mercado crezca y los costes fijos sean pequeños: **oligopolio natural**; con $2\underline\theta<\overline\theta<4\underline\theta$, **duopolio natural** (anexo E). Contraste con la horizontal (Salop: $n\to\infty$ al crecer el mercado o bajar CF).
- **c) Extensiones**: comercio intraindustrial vertical con ventaja comparativa (Falvey, 1981; 3.B.6); discriminación por calidades (Mussa y Rosen, 1978; 3.A.17).
- **d) Evidencia**: Sutton (1991): con costes hundidos endógenos (publicidad, I+D) la concentración no baja al crecer el mercado.
- **e) Valoración**: explica pocas marcas de calidades muy distintas; depende de una sola dimensión de calidad, de un coste marginal que no depende de la calidad y de la competencia en precios.

**Gráfico de referencia:** `oposicion/temario/fuentes/3A18/graficos/shaked-sutton.tex` (segmento de valoraciones $[\underline\theta,\overline\theta]=[0{,}4;\ 1{,}4]$ con $\tilde\theta$, los clientes de cada calidad y las rectas de utilidad $\theta s_{\mathrm A}-p_{\mathrm A}$ y $\theta s_{\mathrm B}-p_{\mathrm B}$; imprescindible).

**Notación:** θ ∈ [θ̲, θ̄] valoración de la calidad (**excepción local avisada**: θ es la CRRA, `notacion.md` § 1), $s_{\mathrm A}>s_{\mathrm B}$ con A y B **en redonda** (mnemónico de alto y bajo del 3.A.13; D7 del 3.A.18, alternativa $s_1<s_2$ de Tirole), $\tilde\theta$, Δs, $B_{\mathrm A}$, $B_{\mathrm B}$. $s$ es local del apartado: en el 3.A.14 $s_i$ es la estrategia y en el 3.A.17 $s$ la tasa de Averch-Johnson (no conviven).

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.18 | Diferenciación vertical | desarrollo (hecho, 19/10/2026) | Todo lo anterior | — |
| 3.A.19 | Oligopolio natural | mención | Shaked y Sutton (1983): la finitud con calidades que cuestan en costes fijos; remitir a 3.A.18 (III.1) | El modelo |
| 3.B.6 | Comercio intraindustrial vertical | resumen | Calidades con competencia imperfecta frente a Falvey (ventaja comparativa, competencia perfecta); con la notación de arriba y remisión a 3.A.18 | La derivación de los precios |
| 3.A.17 | Discriminación por calidades | mención | Mussa y Rosen (1978) como autoselección por calidades (ficha `discriminacion-precios`) | El duopolio |

## Divergencias encontradas en el temario actual
- 3.A.18 original: duopolio de calidades atribuido a Shaked y Sutton (1983), «compiten simultáneamente», intervalo «de tamaño unitario» sin $\overline\theta-\underline\theta=1$, θ_i como índice de consumidor y $s_j$. **Resuelto** (19/10/2026).
- 3.A.19 (sin revisar): su nota 15 (Shaked y Sutton, 1983, oligopolio natural) concuerda con III.1; al revisarlo, `\vertema{3.A.18}`.

Autor: Víctor Gutiérrez Marcos
