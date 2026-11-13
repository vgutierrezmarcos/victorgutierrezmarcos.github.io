# Riesgo de mercado: el valor en riesgo (VaR) y la pérdida esperada en la cola (*expected shortfall*, ES)

- **Área:** finanzas-empresa · **Tema de referencia:** **3.B.26** (gestión de riesgos de las instituciones financieras, en el título; **revisado el 12/11/2026, escrito desde cero**: III.2 `sec:var` con a)-e), la segunda función clave `eq:var`, el gráfico `fig:var` y el anexo C `anexo:var`). Único tema que lo desarrolla. Ficha nueva, CC3 del 3.B.26, **[decidir]** (*alternativa*: sin ficha, con el VaR como fila de `basilea-capital`). Alias: `var`, `riesgo-mercado`, `expected-shortfall`, `pruebas-resistencia`.
- **Temas que lo usan:** 3.B.26 (desarrollo; hecho, 12/11/2026), 3.B.27 (resumen previsto: el capital por riesgo de mercado, el FRTB con la ES al 97,5 % y las pruebas de resistencia de la ABE y el BCE; sin revisar), 3.B.25 (mención; hecho: las griegas como medida local de las carteras de derivados, $\Pi$ valor de la cartera, l. 1278; el 3.B.26 remite allí), 3.B.23 (mención posible: el riesgo de una cartera con $\vect w^{\top}\Sigma\vect w$, que el 3.B.26 usa en el método paramétrico). Relacionadas: `basilea-capital`, `riesgo-credito`, `capm` (varianza de la cartera).
- **Manuales de referencia:** Hull, *Risk Management and Financial Institutions* (2023, `Hull2023Risk`), caps. 12-14; Artzner, Delbaen, Eber y Heath (1999, *Mathematical Finance*, `ArtznerEtAl1999Coherent`); BCBS (1996, enmienda de riesgo de mercado, `BCBS1996MarketRisk`) y (2019, FRTB, `BCBS2019FRTB`, MAR33); Adrian y Shin (2010, *JFI*, `AdrianShin2010`); Fed (2009, SCAP, `FED2009SCAP`). Jorion (2007) no se cita (edición sin comprobar).

## Presentación de referencia (3.B.26, III.2 y anexo C)

**Pregunta:** ¿cuánto puede perder una cartera en un mal día, en una sola cifra que sirva para fijar límites y capital?

- **a) Idea**: resumir el riesgo de la cartera de negociación en una cifra que entienda el consejo.
- **b) Medida. i) Definición** (función clave `eq:var`): con $\Pi$ el valor de la cartera y $\tilde\ell\equiv-\Delta\tilde\Pi$ su pérdida en el horizonte, al nivel de confianza $\alpha$,
$$\Pr\big(\tilde\ell>\mathrm{VaR}_\alpha\big)=1-\alpha .$$
El VaR es **un cuantil**: la pérdida que solo se supera con probabilidad $1-\alpha$ (nunca «la probabilidad de la pérdida máxima», como Tebar). Lectura: un VaR a 10 días al 99 % de 5 millones dice que en 99 de cada 100 periodos no se pierde más; **no** dice cuánto se pierde en el otro.
- **ii) Cálculo, 3 métodos** (Hull, 2023): **paramétrico** (pérdida normal con media $\mu_\ell$ y desviación típica $\sigma$: $\mathrm{VaR}_\alpha=\mu_\ell+\sigma N^{-1}(\alpha)$, $N^{-1}(0{,}99)\simeq2{,}33$; $\sigma^2=\vect w^{\top}\Sigma\vect w$, `\vertema{3.B.23}`; regla de la raíz: a $h$ días, $\sqrt h$ veces el diario); **simulación histórica** (depende de la ventana); **Montecarlo** (depende del modelo).
- **iii) Implicaciones**: una cifra para toda la entidad y límites por mesa; **capital desde 1996**: VaR diario al 99 % a 10 días, multiplicado al menos por 3 (BCBS, 1996).
- **c) Extensiones**:
  - **ES**: $\mathrm{ES}_\alpha=\frac{1}{1-\alpha}\int_\alpha^1\mathrm{VaR}_u\,du\geq\mathrm{VaR}_\alpha$, que con una distribución continua es $\mathbb E[\tilde\ell\mid\tilde\ell\geq\mathrm{VaR}_\alpha]$ (la **media de la cola**; la definición con la integral es la que cuadra con el ejemplo discreto del anexo C); con la normal, $\mathrm{ES}_\alpha=\mu_\ell+\sigma N'(N^{-1}(\alpha))/(1-\alpha)$. Es **coherente** (subaditiva; Artzner et al., 1999). El FRTB sustituye el VaR al 99 % por la **ES al 97,5 %**: con la normal, casi la misma cifra (2,33σ y 2,34σ); con colas gruesas pesa más (**sin fecha de aplicación en la UE**, V25 del 3.B.26: no se da).
  - **Pruebas de resistencia** (escenario adverso pero plausible; SCAP de 2009 sobre los 19 mayores bancos; ABE y BCE en la UE; pruebas inversas).
  - **Griegas** como medida local que complementa al VaR (`\vertema{3.B.25}`).
- **d) Evidencia**: antes de 2007, VaR bajos con ventanas sin crisis; en la tensión, la volatilidad y el VaR subieron a la vez y todos desapalancaron y vendieron (Adrian y Shin, 2010).
- **e) Valoración**: no dice nada más allá del umbral; **no es subaditivo**; es **procíclico**; se apoya en el pasado. Por eso se usa con la ES y las pruebas de resistencia, nunca solo. Pegatina del 3.B.26: «nunca digas de esta agua no beberé».
- **Números canónicos** (anexo C del 3.B.26): cartera de 100 millones, rendimiento diario normal de media 0 y σ = 1 %: VaR diario al 99 % = 2,33 millones, a 10 días ≈ 7,4; ES diaria al 99 % ≈ 2,67. **No subaditividad**: 2 préstamos independientes de 100, PD 4 %, pérdida total: VaR al 95 % de cada uno = 0 y de la cartera = 100 ($1-0{,}96^2=0{,}0784>0{,}05$); ES al 95 %: 80 cada uno y 103,2 la cartera (< 160).

**Gráfico de referencia:** `oposicion/temario/fuentes/3B26/graficos/var.tex` (5 capas: ejes con $\Delta\tilde\Pi$, pérdidas a la izquierda; densidad normal tipificada; cola del 1 % sombreada y $-\mathrm{VaR}_{0{,}99}=-2{,}326\sigma$; $-\mathrm{ES}_{0{,}99}=-2{,}665\sigma$, media de la cola; una $t$ de Student de 4 grados con varianza 1, «colas gruesas», que deja el 1,5 % más allá del VaR). Imprescindible en el cante del 3.B.26 (III.2).

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.B.26 | Gestión de riesgos | desarrollo (hecho, 12/11/2026) | Todo lo anterior: `eq:var` (función clave), 3 métodos, capital de 1996, ES y FRTB, pruebas de resistencia, griegas, Adrian y Shin, críticas; `fig:var`; anexo C con los números | La regulación en detalle (`\vertema{3.B.27}`) |
| 3.B.27 | Regulación financiera | resumen (previsto) | El capital por riesgo de mercado (1996 → FRTB, VaR → ES), las pruebas de resistencia supervisoras y el *backtesting*; `\vertema{3.B.26}` para la medida | La definición y los métodos |
| 3.B.25 | Derivados | mención (hecho) | Las griegas como medida local del riesgo de una cartera de opciones | El VaR |

## Divergencias encontradas en el temario actual
- **Tebar 5.2** (referencia del 3.B.26, no se hereda): «el VaR nos dice la probabilidad de la pérdida máxima» → es un cuantil.
- Notación local: $\alpha$ nivel de confianza (choca con la participación del capital, que no sale en estos temas); $h$ horizonte; $\mu_\ell$; $N(\cdot)$, $N^{-1}(\cdot)$, $N'(\cdot)$ (`notacion.md` § 11).

Autor: Víctor Gutiérrez Marcos
