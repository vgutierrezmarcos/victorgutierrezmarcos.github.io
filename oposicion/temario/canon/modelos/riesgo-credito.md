# Riesgo de crédito: pérdida esperada (PD × LGD × EAD), pérdida inesperada y modelo de Merton (1974)

- **Área:** finanzas-empresa · **Tema de referencia:** **3.B.26** (gestión de riesgos en el título; **revisado el 12/11/2026, escrito desde cero**: III.3 `sec:riesgo-credito` con `eq:perdida-esperada`, la gestión del riesgo de crédito y Merton con a)-d); el capital IRB en el anexo C `anexo:var`). Ficha nueva, CC4 del 3.B.26, **[decidir]** (*alternativa*: sin ficha, repartida entre `basilea-capital` e `indicadores-bancarios`). Alias: `merton-1974`, `perdida-esperada`, `pd-lgd-ead`, `vasicek-irb`.
- **Temas que lo usan:** 3.B.26 (desarrollo; hecho, 12/11/2026), 3.B.25 (mención; hecho: l. 802, las acciones como *call* sobre los activos con `Merton1974Pricing`; el diferencial del CDS ≈ probabilidad anual de impago × (1 − tasa de recuperación), con $R$ de recuperación, l. 899), 3.B.4 (mención; hecho: las acciones de una empresa endeudada como opción, l. 634, `Merton1974Pricing`), 3.B.27 (resumen previsto: el método IRB y el capital), 4.A.19 y 1D01 (uso: dudosos, cobertura, provisiones; ficha `indicadores-bancarios`), 3.A.13 (mención: *screening*, garantías, *covenants*, Stiglitz-Weiss). Relacionadas: `black-scholes` (la fórmula), `basilea-capital`, `indicadores-bancarios`, `var-expected-shortfall`, `stiglitz-weiss`.
- **Manuales de referencia:** Merton (1974, *JF*, `Merton1974Pricing`); Merton (1977, *JBF*, `Merton1977Analytic`, la garantía de depósitos como *put*); Hull (2023, `Hull2023Risk`); Vasicek (2002, `Vasicek2002`); Gordy (2003, `Gordy2003`); BCBS (2017, `BCBS2017Basel3`); IASB (2014, NIIF 9, `IASB2014NIIF9`); Altman (1968, `Altman1968`); Reglamento (UE) 2017/2402, art. 6 (`UE2017Titulizacion`).

## Presentación de referencia (3.B.26, III.3 y anexo C)

**Pregunta:** ¿cuánto se espera perder en una cartera de préstamos, cuánto se puede perder en un año malo y cómo se gestiona?

- **Los 3 parámetros** (siglas en inglés y en redonda, como el Banco de España): **PD** probabilidad de incumplimiento (a un año), **LGD** severidad (lo que se pierde si hay impago, tras las garantías; LGD = 1 − tasa de recuperación), **EAD** exposición en el momento del incumplimiento.
- **Pérdida esperada** (`eq:perdida-esperada`; ecuación numerada, no función clave: K11 del 3.B.26), en castellano **PE**:
$$\mathrm{PE}=\mathrm{PD}\times\mathrm{LGD}\times\mathrm{EAD}.$$
Ejemplo canónico: hipoteca de 200.000 € con PD del 1 % y LGD del 20 %: 400 € al año. Es un **coste**: se carga en el tipo y se cubre con **provisiones** (desde 2018, NIIF 9: pérdida esperada desde la concesión, lección de 2008).
- **Pérdida inesperada**: por encima de la esperada en un año malo; se cubre con **capital**; depende de que los impagos lleguen juntos. **IRB** de Basilea: la pérdida de un año que solo se supera con probabilidad del 0,1 %, con un factor común (Vasicek, 2002; Gordy, 2003): $K=\mathrm{LGD}\times\{N[(N^{-1}(\mathrm{PD})+\sqrt\rho\,N^{-1}(0{,}999))/\sqrt{1-\rho}]-\mathrm{PD}\}\times$ (ajuste por vencimiento), con **ρ correlación local del anexo** (en el canon ρ es la tasa de descuento) y **K capital por euro de exposición, local** (en § 11, $K$ es el precio de ejercicio). Hipotecas: ρ = 0,15, sin ajuste; con PD 1 % y LGD 20 %, $K\simeq2$ % frente a una PE del 0,2 %.
- **Gestión**: antes de prestar (*screening* con calificación y puntuación, Altman, 1968; garantías; precio acorde con el riesgo); después (seguimiento y *covenants*, `\vertema{3.A.13}`); en la cartera (diversificar, grandes exposiciones, CDS y titulización, con la retención del 5 % de la UE tras «originar para distribuir»); a posteriori (dudosos y cobertura, `\vertema{4.A.19}`).
- **Merton (1974)**, con a)-d) y la notación del 3.B.25 (Hull, D108): **a) Idea**: las acciones son una *call* sobre los activos con precio de ejercicio igual a la deuda (`\vertema{3.B.25}`). **b) Modelo**: activos $V$ con volatilidad $\sigma_V$, sin saltos; un bono cupón cero de nominal **VN** a $T$ años (**$T$ vencimiento**, con nota al pie frente a las fechas de Diamond y Dybvig); quiebra solo al vencimiento.
$$V_E=V\,N(d_1)-\mathrm{VN}\,e^{-rT}N(d_2),\quad d_1=\frac{\ln(V/\mathrm{VN})+(r+\sigma_V^2/2)T}{\sigma_V\sqrt T},\quad d_2=d_1-\sigma_V\sqrt T,$$
y $V_D=V-V_E$ (bono sin riesgo menos una *put* sobre los activos). PD neutral al riesgo $N(-d_2)$; **$d_2$ distancia al incumplimiento**. La PD sube con el apalancamiento $\mathrm{VN}/V$ y con $\sigma_V$ (no «con el tiempo» en general, como decía Tebar): con $V/\mathrm{VN}=1{,}25$, $r=0$, $T=1$, del 1,5 % ($\sigma_V=10$ %) al 15 % ($\sigma_V=20$ %). **c) Extensiones**: uso práctico (de las acciones a $V$ y $\sigma_V$); la garantía de depósitos como *put* (Merton, 1977), el coste de la red de seguridad (ficha `diamond-dybvig`). **d) Valoración**: solo quiebra al vencimiento y sin saltos: infravalora la PD a corto.
- **Reglas de notación** (K32 del 3.B.26): nunca $R$ para la tasa de recuperación donde conviva con Diamond y Dybvig (LGD); nunca $c$ para las acciones en Merton ($V_E$); $V_D/V$ entero donde esté la $L$ de liquidación.

**Gráfico de referencia:** ninguno propio (la ecuación de la PE se escribe en una línea en la pizarra). El riesgo de crédito se señala en el balance estilizado (`fuentes/3B26/graficos/balance-banco.tex`, capa 6, junto a los préstamos).

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.B.26 | Gestión de riesgos | desarrollo (hecho, 12/11/2026) | Todo lo anterior (III.3, 2′; Merton en el cuerpo, no en anexo; el IRB en el anexo C) | El IRB en detalle y los mínimos (`\vertema{3.B.27}`) |
| 3.B.25 | Derivados | mención (hecho) | Las acciones como *call* (Merton, 1974); CDS con $\mathrm{VN}(1-R)$ y $R$ tasa de recuperación (local del 3.B.25) | La PE, el IRB |
| 3.B.4 | Valoración de empresas | mención (hecho) | Las acciones de una empresa endeudada como opción | El riesgo de crédito |
| 3.B.27 | Regulación financiera | resumen (previsto) | IRB con PD, LGD, EAD y el capital por la pérdida inesperada; `\vertema{3.B.26}` | La fórmula |
| 4.A.19, 1D01 | Sector bancario español; dictamen | uso | Dudosos, cobertura, provisiones NIIF 9 (ficha `indicadores-bancarios`) | Merton |

## Divergencias encontradas en el temario actual
- **Tebar 5.3** (no se hereda): «en Merton la PD depende positivamente del tiempo» → no es general: apalancamiento y volatilidad.
- **Sigla de la pérdida esperada**: el 3.B.26 escribe **PE** (castellano, junto a PD, LGD y EAD en inglés, como el Banco de España); las propuestas decían EL. Canon: **PE**, **[decidir]** (duda 9 del 3.B.26; *alternativa*: EL y UL, como Basilea).

Autor: Víctor Gutiérrez Marcos
