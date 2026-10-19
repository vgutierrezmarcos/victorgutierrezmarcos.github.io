# Bertrand y Cournot con producto diferenciado (Bowley, 1924; Singh y Vives, 1984)

- **Área:** mercados-información-juegos · **Tema de referencia:** **3.A.18** (Diferenciación de productos; revisado el 19/10/2026, II.2 «Modelos sin direcciones») — el 3.A.19 manda aquí el oligopolio con producto diferenciado (su nota 13) y el título del 3.A.18 pide «otros desarrollos». Ficha creada a raíz de esa revisión (K42, K47; era opcional: se crea porque el 3.A.19 la usa).
- **Temas que lo usan:** 3.A.18 (desarrollo breve; hecho, 19/10/2026), 3.A.19 (mención: Bertrand y Cournot con producto homogéneo se desarrollan allí; con producto diferenciado, una línea y remisión; hoy repite el gráfico de Bertrand diferenciado), 3.B.8 (mención posible: Eaton y Grossman, 1986, con Bertrand, ficha `brander-spencer`). El 3.A.14 solo usa Cournot y Bertrand con producto homogéneo como ejemplos de EN con acciones continuas, con remisión al 3.A.19 (ficha `equilibrio-nash`).
- **Manuales de referencia:** Bowley (1924); Singh y Vives (1984), *RAND Journal*; Bulow, Geanakoplos y Klemperer (1985), *JPE* (sustitutos y complementos estratégicos); Belleflamme y Peitz (2015), cap. 3; Vives (1999); Gasmi, Laffont y Vuong (1992).

## Presentación de referencia (3.A.18, II.2)

Pregunta: ¿qué cambia en Bertrand y Cournot si los productos son distintos? Conclusión: la diferenciación da margen incluso compitiendo en precios; Bertrand sigue siendo más competitivo que Cournot.

- i) Supuestos: 2 empresas, $i,j=1,2$, coste marginal $c$, sin costes fijos; consumidor representativo con utilidad **cuasilineal y cuadrática**, $U=x_0+\alpha(q_1+q_2)-\frac12(\beta q_1^2+2\gamma q_1q_2+\beta q_2^2)$, $\alpha>c$, $0\le\gamma<\beta$ (α, β, γ **locales** del apartado); demandas lineales sin efecto renta (`eq:singh-vives`):
$$p_i=\alpha-\beta\,q_i-\gamma\,q_j\ \Longleftrightarrow\ q_i=\frac{\alpha(\beta-\gamma)-\beta\,p_i+\gamma\,p_j}{\beta^2-\gamma^2};$$
  γ/β ∈ [0,1) mide la sustituibilidad (0: mercados independientes; → 1: homogéneo); juego estático.
- ii) Desarrollo: **Cournot**, reacciones decrecientes (**sustitutos estratégicos**): $R_i(q_j)=\frac{\alpha-c-\gamma q_j}{2\beta}$, $q^C=\frac{\alpha-c}{2\beta+\gamma}$, $p^C=c+\frac{\beta(\alpha-c)}{2\beta+\gamma}$. **Bertrand**, reacciones crecientes (**complementos estratégicos**, Bulow *et al.*, 1985): $R_i(p_j)=\frac{\alpha(\beta-\gamma)+\beta c+\gamma p_j}{2\beta}$, $p^B=c+\frac{(\alpha-c)(\beta-\gamma)}{2\beta-\gamma}$.
- iii) Implicaciones: la diferenciación resuelve la paradoja de Bertrand ($p^B>c$ si γ < β; γ = 0: monopolio); **$p^B<p^C$** si γ > 0 (Singh y Vives, 1984); con contratos previos, elegir la cantidad es dominante (Cournot); en los 2 casos $\mathcal L_i=1/|\varepsilon_{q_i,p_i}|$.
- Evidencia: Gasmi, Laffont y Vuong (1992), Coca-Cola y Pepsi (1968-1986). Valoración: γ exógeno y simétrico; para hacer endógena la diferenciación, el enfoque de direcciones (ficha `hotelling`).

**Gráfico de referencia:** `oposicion/temario/fuentes/3A18/graficos/reaccion-diferenciado.tex` (2 paneles: cantidades, reacciones decrecientes y equilibrio de Cournot; precios, reacciones crecientes y equilibrio de Bertrand por encima de $c$; α = 10, c = 2, β = 1, γ = 0,6). El panel de precios es también el de la ciudad lineal (ficha `hotelling`).

**Notación:** $q_i$, $p_i$, $R_i(\cdot)$ (D016; nunca φ), $q^C$, $p^C$, $p^B$ (superíndices C y B en cursiva, como letras), α, β, γ locales (avisado: α no es la parte del gasto de Dixit-Stiglitz ni β el factor de descuento ni γ el poder de negociación).

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.18 | Oligopolio diferenciado sin direcciones | desarrollo breve (hecho, 19/10/2026; 2' en el cante) | Todo lo anterior | Bertrand y Cournot homogéneos (3.A.19) |
| 3.A.19 | Oligopolio | mención | Con producto diferenciado la paradoja de Bertrand desaparece y $p^B<p^C$; remitir a 3.A.18 (II.2); misma demanda si la escribe | El gráfico y la derivación |

## Divergencias encontradas en el temario actual
- 3.A.18 original: no lo tenía (comentario «¿qué pasaría en Cournot con diferenciación?», P5). **Añadido** (19/10/2026).
- 3.A.19 (sin revisar): repite el gráfico «Situación de Bertrand con producto diferenciado» y remite aquí el oligopolio diferenciado (nota 13): al revisarlo, resumir y remitir; φ para la función de reacción → $R_i$ (D016).

Autor: Víctor Gutiérrez Marcos
