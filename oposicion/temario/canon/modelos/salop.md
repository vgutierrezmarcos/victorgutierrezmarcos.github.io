# Ciudad circular de Salop (1979): entrada con diferenciación localizada

- **Área:** mercados-información-juegos · **Tema de referencia:** **3.A.18** (Diferenciación de productos; revisado el 19/10/2026, II.3.4) — el único tema que lo desarrolla, como la competencia monopolística del enfoque de direcciones. Ficha creada a raíz de esa revisión (K40, K47).
- **Temas que lo usan:** 3.A.18 (desarrollo; hecho, 19/10/2026; también en III.2, proliferación de marcas, y en el anexo `anexo:variedad-optima`), 3.A.15 (mención posible: proliferación de marcas como barrera de entrada estratégica sobre el círculo; Schmalensee, 1978), 3.A.19 (mención posible: entrada excesiva, Mankiw y Whinston, 1986).
- **Manuales de referencia:** Salop (1979), «Monopolistic Competition with Outside Goods», *Bell Journal*; Tirole (1988), cap. 7; Economides (1989); Spence (1976); Mankiw y Whinston (1986), *RAND Journal*; Belleflamme y Peitz (2015), cap. 5.

## Presentación de referencia (3.A.18, II.3.4)

Pregunta: ¿cuántas empresas entran cuando cada una compite solo con sus vecinas, y es demasiado o demasiado poco? Conclusión: margen $t/n$; con libre entrada, $n^*=\sqrt{t/\mathrm{CF}}$, el **doble** de las variedades óptimas: entrada excesiva.

- **a) Idea**: consumidores en un círculo (sin extremos ni centro: sin efectos frontera) para estudiar la entrada; con libre entrada es competencia monopolística, pero con competencia **local**: une los 2 bloques del 3.A.18 y responde la pregunta de bienestar que Dixit-Stiglitz deja abierta.
- **b) Modelo.** i) Supuestos: masa 1 uniforme en un círculo de perímetro 1; demanda unitaria; costes de transporte **lineales**, $t\,d$; coste fijo de entrada CF y coste marginal $c$; juego en 2 etapas: 1) entran $n$ empresas, **equidistantes** ($1/n$) por supuesto (Salop no modeliza la localización; Economides, 1989, la justifica con costes cuadráticos); 2) compiten en precios. ii) Desarrollo: consumidor indiferente entre $i$ y una vecina que cobra $p$, $p_i+t\tilde x=p+t(1/n-\tilde x)$, clientes a los 2 lados:
$$x_i=2\tilde{x}=\frac{1}{n}+\frac{p-p_i}{t}\ \Longrightarrow\ p^*=c+\frac{t}{n},\qquad B^*=\frac{t}{n^2}-\mathrm{CF};$$
  libre entrada (`eq:salop`):
$$n^*=\sqrt{\frac{t}{\mathrm{CF}}},\qquad p^*=c+\sqrt{t\,\mathrm{CF}}.$$
  iii) Implicaciones: precio sobre el coste marginal con beneficio nulo (como Dixit-Stiglitz); más CF → menos empresas y más margen; más $t$ → más de los 2; CF → 0 ⇒ competencia casi perfecta. Normativa: con demanda unitaria el precio es una transferencia y el planificador minimiza $n\,\mathrm{CF}+t/(4n)$:
$$n^{\mathrm{o}}=\frac{1}{2}\sqrt{\frac{t}{\mathrm{CF}}}=\frac{n^*}{2}\quad\text{(entrada excesiva)},$$
  por los 2 efectos de la entrada (Spence, 1976; Mankiw y Whinston, 1986): **excedente no apropiable** (empuja a pocas) y **robo de clientes** (*business stealing*, empuja a demasiadas); aquí domina el segundo; en Dixit-Stiglitz se compensan respecto al óptimo restringido.
- **c) Valoración**: modelo canónico de la entrada con diferenciación localizada; pero la localización simétrica es un supuesto y la demanda unitaria hace que el precio no distorsione el consumo; con entrada secuencial, la instalada puede ocupar el espacio de productos (proliferación de marcas, Schmalensee, 1978; credibilidad, Judd, 1985; 3.A.18, III.2).

**Gráfico de referencia:** `oposicion/temario/fuentes/3A18/graficos/salop.tex` (círculo de perímetro 1 con $n=6$ empresas equidistantes, arcos de $1/n$, consumidor indiferente a cada lado de $i$ y los clientes de $i$, $x_i=2\tilde x$; imprescindible).

**Notación:** $n$ número de empresas (= variedades), $x_i$, $\tilde x$, $t$, CF, $c$, $B$; $n^*$ equilibrio y $n^{\mathrm o}$ óptimo (superíndice o en redonda). Nunca $D_i$ ni $F$ (el comercio admite $F$, D103).

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.18 | Entrada con diferenciación horizontal | desarrollo (hecho, 19/10/2026) | Todo lo anterior; el margen $t/n$ se añade a la columna de márgenes bajo `eq:lerner-variedad` | — |
| 3.A.15 | Barreras de entrada estratégicas | mención (prevista) | La proliferación de marcas sobre el círculo de Salop (Schmalensee, 1978) y su credibilidad (Judd, 1985); remitir a 3.A.18 | El modelo |
| 3.A.19 | Oligopolio y entrada | mención (posible) | Entrada excesiva por el robo de clientes (Mankiw y Whinston, 1986) | El modelo |

## Divergencias encontradas en el temario actual
- 3.A.18 original: la localización «elegida», «equidistante», «exógena» y «un resultado» a la vez; captura ajena con $n_S=\frac12\sqrt{t/F}>\sqrt{t/F}=n^*$ (el signo al revés). **Resuelto** (19/10/2026): equidistancia como supuesto con nota de Economides (1989) y $n^{\mathrm o}=n^*/2$.

Autor: Víctor Gutiérrez Marcos
