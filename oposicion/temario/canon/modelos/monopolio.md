# Monopolio: equilibrio, índice de Lerner y coste social

- **Área:** mercados-información-juegos · **Tema de referencia:** **3.A.17** (Análisis de mercados (II): teoría del monopolio; revisado el 17/10/2026, I.1-I.3) — lo tiene en el título y lo desarrolla con a)-e). Recoge el id `indice-lerner` (alias en `_inventario/alias.json`). Ficha creada a raíz de esa revisión.
- **Temas que lo usan:** 3.A.17 (desarrollo; hecho, 17/10/2026), 3.A.16 (mención: demanda horizontal de la empresa precio-aceptante frente a la del monopolista; Lerner nulo como vara de medir; hecho), 3.A.12 (mención: pérdida del monopolio mayor que el triángulo de Harberger por la ineficiencia X; hecho), 3.A.21 (mención: monopolio en la caja de intercambio, punto M; hecho), 3.A.18 (resumen previsto: cada empresa monopoliza su variedad, 𝓛 = 1/σ con μ = σ/(σ−1)), 3.A.19 (mención: el monopolio como extremo y el cártel), 3.A.22 y 3.A.23 (mención: poder de mercado como fallo del 1TFEB), 3.B.7 (mención: arancel y contingente con monopolio doméstico, no equivalencia), 4.B.8 (resumen previsto: incidencia de un impuesto con monopolio), 3.B.39 y 4.A.15 (mención: defensa de la competencia).
- **Manuales de referencia:** Tirole (1988), *The Theory of Industrial Organization*, cap. 1; Mas-Colell, Whinston y Green (1995), § 12.B; Varian (1992), cap. 14; Robinson (1933); Lerner (1934), «The Concept of Monopoly and the Measurement of Monopoly Power», *REStud* 1(3) (clave `Lerner1934Concept`; no el de las condiciones marginales, `Lerner1934Economic`, que usan 3.A.16 y 3.A.21); Harberger (1954), *AER*; Tullock (1967); Posner (1975), *JPE*; Leibenstein (1966); Bulow y Pfleiderer (1983); De Loecker, Eeckhout y Unger (2020), *QJE*.

## Presentación de referencia (3.A.17, I)

Pregunta: ¿cómo fija el precio y la cantidad una empresa sin competidores, qué limita su poder y cuánto le cuesta eso a la sociedad?

**Escenario base (I.1)**, del que cada desarrollo levanta un supuesto (tabla `tab:escenario-base`): agentes racionales; información completa y simétrica (no «perfecta», que es otra cosa en juegos); un único bien sin sustitutivos cercanos (si los hay, el poder se reduce, no se pierde); un oferente y muchos demandantes precio-aceptantes sin reventa; precio uniforme; barreras de entrada (estratégicas, legales, tecnológicas: subaditividad); una sola planta y factores comprados a precios dados. Poder de mercado: el monopolista elige un punto de la demanda, precio o cantidad, no los 2.

| Supuesto del escenario base | Desarrollo que lo levanta (ficha) |
|---|---|
| Precio único | Discriminación de precios (`discriminacion-precios`) |
| Información completa sobre la valoración de cada uno | Autoselección, 2.º grado (`discriminacion-precios`) |
| Costes sin ventajas de tamaño | Monopolio natural (`monopolio-natural`) |
| Un producto y una planta | Producción conjunta (`monopolio-multiproducto`) |
| Precio-aceptante en los factores | Monopsonio (`monopsonio`) |
| Demandantes sin poder | Monopolio bilateral (`monopolio-bilateral`) |

**Equilibrio (I.2, a)-d))**. Supuestos técnicos: demanda de mercado x(p) derivable y decreciente; el monopolista vende q = x(p) y usa la inversa p(q), p'(q) < 0 (de consumidores con utilidad cuasilineal, 3.A.8 y 3.A.16); C(q) = C(w⃗,q) con w⃗ fijo, CMg > 0 (3.A.12).
$$\max_{q}\ B(q)=p(q)\,q-C(q)\quad\text{s.a. } q\ge 0\qquad(\texttt{\textbackslash optim})$$
$$p(q^M)+p'(q^M)\,q^M=\mathrm{IMg}(q^M)=\mathrm{CMg}(q^M),\qquad \mathrm{IMg}=p\Big(1-\frac{1}{|\varepsilon_{q,p}|}\Big)<p$$
`\funcionclave` (`eq:lerner`), que se queda en una esquina de la pizarra todo el cante del 3.A.17:
$$\mathrm{IMg}(q^M)=\mathrm{CMg}(q^M)\ \Longleftrightarrow\ \mathcal{L}\equiv\frac{p^M-\mathrm{CMg}(q^M)}{p^M}=\frac{1}{|\varepsilon_{q,p}|}$$
- **Tramo elástico**: con CMg > 0, |ε_{q,p}| > 1 estricto (con |ε| = 1 tampoco produce, salvo CMg nulo).
- **Condición de segundo orden**: IMg'(q^M) < CMg'(q^M), pendientes con su signo. Con CMg decreciente también puede maximizar si el CMg **corta al IMg desde abajo** (a la izquierda de q^M, IMg > CMg); si lo corta desde arriba, es un mínimo (anexo `anexo:cso`).
- **No hay curva de oferta**: la cantidad depende de la elasticidad de la demanda, no solo de su altura.
- **Viabilidad**, evaluada **en q^M** (no en el mínimo del CMe): a corto plazo p(q^M) ≥ CVMe(q^M); a largo, p(q^M) ≥ CMe(q^M), nunca con pérdidas (anexo `anexo:viabilidad`).
- **Implicaciones**: p^M > CMg, q^M < q^c (q^c donde la demanda corta al CMg); beneficios extraordinarios a largo plazo por las barreras; no produce necesariamente en el mínimo del CMe a largo plazo (gráfico `escala-monopolio`).
- **Impuestos** (anotación de I.2; anexo C): unitario t ⇒ IMg = CMg + t; con demanda lineal y c constante el precio sube t/2; con demanda isoelástica, más que t (la traslación depende de la curvatura: Bulow y Pfleiderer, 1983); *ad valorem*: (1 − t)IMg = CMg (el 3.A.17 escribe hoy τ: `pendientes-coherencia.md`); sobre el beneficio o de suma fija, neutrales.

**Eficiencia y bienestar (I.3, a)-e))**. El competitivo maximiza ET = EC + EP (1TFEB parcial, 3.A.16; en equilibrio parcial cuasilineal, Pareto y eficiencia asignativa coinciden).
- Transferencia (p^M − p^c)q^M de los consumidores al monopolista; **pérdida irrecuperable de eficiencia** (PIE) o **triángulo de Harberger** (1954):
$$\mathrm{PIE}\approx\tfrac12\,|\varepsilon_{q,p}|\,\mathcal{L}^2\,p^Mq^M=\tfrac12\,\mathcal{L}\,p^Mq^M=\tfrac12\,B$$
(exacto con demanda lineal, CMg constante y sin costes fijos: (a − c)²/8b); crece con el cuadrado del margen.
- Ineficiencia asignativa en los factores: contrata hasta IPMg_i = IMg·PMg_i = w_i < VPMg_i = p·PMg_i (explotación monopolística de Robinson), con RMST_{LK} = w_L/w_K.
- Ineficiencia productiva (escala) e **ineficiencia X** (C^obs = (1+χ)C, Hicks, 1935, p. 8: «el mejor de todos los beneficios del monopolio es una vida tranquila»; ficha `ineficiencia-x`): franja entre CMg y (1+χ)CMg hasta q^M.
- **Búsqueda de rentas** (Tullock, 1967; Posner, 1975: se disipa todo el rectángulo; ficha `rent-seeking-tullock`).
- Cotas: del triángulo de Harberger (inferior) al triángulo más la franja X y el rectángulo de rentas (superior).
- Eficiencia dinámica: Schumpeter (1942) frente al efecto reemplazo de Arrow (1962); U invertida competencia-innovación (Aghion et al., 2005; 3.A.44).
- Evidencia: Harberger, menos de «una treceava parte del 1 %» de la renta nacional (manufacturas de EE. UU., 1924-1928); Posner y Cowling y Mueller (1978), mucho más; márgenes medios de 21 % (1980) a 61 % (2016) en las cotizadas de EE. UU. (De Loecker, Eeckhout y Unger, 2020).
- Valoración: no todo monopolio debe desmantelarse (discriminación perfecta, monopolio natural, patentes); depende del origen del poder y de los fallos de la intervención (3.A.23).

**Gráficos de referencia** (`oposicion/temario/fuentes/3A17/graficos/`): `equilibrio-monopolio.tex` (central, por capas: demanda p(q), IMg, CMg, E^M con q^M y p^M, competencia q^c y p^c; la discriminación de 1.er grado es una capa más, `primer-grado.tex`); `bienestar-monopolio.tex` (misma base: transferencia en dorado, triángulo de Harberger «PIE» en rojo al 30 %, rectángulo de Tullock-Posner rayado en rojo, (1+χ)CMg y franja X en verde; colores de `notacion.md` § 4); de apoyo, `tramo-elastico.tex`, `monopolio-corto-plazo.tex`, `escala-monopolio.tex`, `cso-monopolio.tex` y `viabilidad-monopolio.tex`.

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.17 | Teoría del monopolio | desarrollo (hecho, 17/10/2026) | Todo lo anterior; la regla de Lerner es el hilo conductor de todo el tema (por grupos, amortiguada, cruzada, en espejo) | — |
| 3.A.16 | Competencia perfecta | mención (hecho) | IMg = p con demanda horizontal frente a IMg < p; índice de Lerner nulo como referencia | El modelo |
| 3.A.12 | Costes | mención (hecho) | La pérdida del monopolio supera el triángulo de Harberger por la ineficiencia X | — |
| 3.A.21 | Equilibrio general | mención (hecho) | Monopolio en la caja de intercambio (punto M sobre OD_A, ineficiente), con remisión a 3.A.17 | La regla de Lerner |
| 3.A.18 | Competencia monopolística | resumen (previsto) | Cada empresa es monopolista de su variedad: 𝓛 = 1/σ y p = μ·c con μ = σ/(σ−1); remitir a 3.A.17; sin lagrangiana 𝓛 | La derivación de IMg = CMg |
| 3.A.19 | Oligopolio | mención (prevista) | Extremo de Cournot con una empresa; el cártel como monopolio multiplanta (ficha `monopolio-multiproducto`) | — |
| 3.B.7 | Política comercial | mención (prevista) | Arancel frente a contingente con monopolio doméstico (no equivalencia): el monopolista iguala IMg = CMg sobre la demanda residual | El modelo |
| 4.B.8 | Incidencia | resumen (previsto) | Impuesto unitario y *ad valorem* sobre el monopolista con la misma notación (IMg = CMg + t; (1 − t)IMg = CMg); traslación de t/2 (lineal) o mayor que t (isoelástica) | La teoría del monopolio |
| 3.B.39, 4.A.15 | Defensa de la competencia | mención | Índice de Lerner como medida del poder de mercado y PIE como coste | — |

## Divergencias encontradas en el temario actual
- 3.A.17 original: P mayúscula, ε_{q^D,P}, «|ε| ≥ 1», viabilidad en el mínimo del CMe, «eficiencia asignativa ≠ Pareto», Marshall (1920) como inventor de la pérdida irrecuperable, Lerner citado con el artículo equivocado en la propuesta de datos. **Resuelto** en la revisión (17/10/2026).
- 3.A.18 y 3.A.19 (sin revisar): el mismo enganche que el 3.A.17 original (Barbie y Marshall); remisiones al 3.A.17 que faltan (Lerner de cada variedad; cártel como multiplanta). Si escriben una lagrangiana, sin 𝓛 (`notacion.md` § 0).
- 4.B.8 (sin revisar): al tratar la incidencia con monopolio, usar la notación y los resultados de la anotación de I.2 del 3.A.17.

Autor: Víctor Gutiérrez Marcos
