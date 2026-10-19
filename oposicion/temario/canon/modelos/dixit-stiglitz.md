# Competencia monopolística de Dixit y Stiglitz (1977), versión «lite» (Neary, 2004)

- **Área:** mercados-información-juegos · **Tema de referencia:** **3.A.18** (Diferenciación de productos: la teoría de la competencia monopolística; revisado el 19/10/2026, I.3) — lo tiene en el título y lo desarrolla con a)-e), con las derivaciones en el anexo `anexo:dixit-stiglitz` y el bienestar en `anexo:variedad-optima`. Ficha creada a raíz de esa revisión (K36, K47). Es un tema del 3.er ejercicio, como pide `CRITERIOS.md` § 6; el comercio (3.B.6) y la macro (3.A.7) lo aplican.
- **Temas que lo usan:** 3.A.18 (desarrollo; hecho, 19/10/2026), 3.B.6 (resumen: la demanda de Krugman, 1979 y 1980, y Melitz, 2003, remitiendo aquí la derivación; fichas `krugman-1979`, `melitz`, `centro-periferia`), 3.A.7 (resumen: continuo de variedades, $P_t(i)$ y el margen de la nueva economía keynesiana; Blanchard y Kiyotaki, 1987; ficha `nek-3-ecuaciones`), 3.A.11 (mención; hecho, 13/10/2026: el agregador CES con σ > 1 entre variedades, ficha `ces`), 3.A.44 (mención: variedades de bienes intermedios de Romer, 1990; ficha `romer-1990`), 3.A.32 y 3.B.19 (mención: versiones de economía abierta, Galí y Monacelli, 2005; Corsetti y Pesenti), 3.A.21 (mención opcional: modelo de equilibrio general con competencia imperfecta; `pendientes-coherencia.md`).
- **Manuales de referencia:** Dixit y Stiglitz (1977), *AER*; Neary (2004), «Monopolistic competition and international trade theory»; Tirole (1988), cap. 7; Krugman, Obstfeld y Melitz (2018), cap. 8; Gandolfo (2014), *International Trade Theory and Policy*; Foltyn (2012, rev. 2026), «Results on Dixit-Stiglitz»; Galí (2015), cap. 3; Arrow *et al.* (2011) (uno de los 20 mejores artículos de la *AER*).

## Presentación de referencia (3.A.18, I.3)

Pregunta: ¿cuánto margen cobra cada variedad, cuántas variedades produce el mercado y es eso demasiado o demasiado poco? Conclusión: margen constante 1/σ sobre el coste marginal que solo paga el coste fijo (beneficio nulo), exceso de capacidad a cambio de variedad; con CES y Cobb-Douglas, el equilibrio es el óptimo restringido.

- **a) Idea**: formalizar a Chamberlin derivando la demanda de cada variedad de un consumidor representativo con preferencia por la variedad, para poder calcular el equilibrio y compararlo con el óptimo.
- **b) Modelo.** i) Supuestos: los de Chamberlin (muchas empresas, simetría, libre entrada); cada empresa, una variedad, $i=1,\dots,n$ ($n$ variedades = empresas; nota: el 3.A.16 cuenta las empresas con $J$); 2 sectores, el diferenciado y un numerario $x_0$ de precio 1; consumidor representativo con renta $\overline W$ y
$$U(x_0,y)=x_0^{\,1-\alpha}\,y^{\alpha},\qquad y\equiv\Big[\sum_{i=1}^{n}x_i^{\rho}\Big]^{1/\rho},\qquad \rho\equiv\frac{\sigma-1}{\sigma},\quad \sigma>1,\quad 0<\alpha<1,$$
  con **α la parte de la renta que se gasta en el grupo** (convención de Neary y Foltyn; el original y la propuesta K30 la ponían al otro lado: duda 1 del 3.A.18, aplicada así provisionalmente); preferencias débilmente separables; **preferencia por la variedad** ($x_i=X/n\Rightarrow y=n^{1/(\sigma-1)}X$), mayor cuanto menor es σ; σ > 1 porque la demanda de cada variedad tiene que ser elástica (la convexidad solo exige σ > 0); costes $C(q_i)=\mathrm{CF}+c\,q_i$.
  ii) Desarrollo: consumidor en 2 etapas (reparto entre variedades con gasto $\alpha\overline W$; numerario frente al grupo, $x_0=(1-\alpha)\overline W$, $P\,y=\alpha\overline W$) → **demanda de cada variedad** (`\funcionclave` `eq:demanda-variedad`):
$$x_i=\frac{\alpha\overline{W}}{P}\left(\frac{p_i}{P}\right)^{-\sigma},\qquad P\equiv\Big[\sum_{j=1}^{n}p_j^{\,1-\sigma}\Big]^{\frac{1}{1-\sigma}}$$
  (crece con el gasto del grupo y con $P$; baja con $p_i$; σ la hace más elástica, no la desplaza en un sentido fijo; $P=p\,n^{1/(1-\sigma)}$ con precios iguales). Con $n$ grande, $\varepsilon_{x_i,p_i}=-\sigma$ (exacta: $-\sigma+(\sigma-1)s_i$; es la $d$ de Chamberlin, y la $D$ es $x=\alpha\overline W/(pn)$). Empresa monopolista de su variedad que toma $P$ como dado: **regla del margen** (`\funcionclave` `eq:lerner-variedad`, se queda en la pizarra todo el cante):
$$\mathcal{L}\equiv\frac{p^*-c}{p^*}=\frac{1}{|\varepsilon_{x_i,p_i}|}=\frac{1}{\sigma}\ \Longleftrightarrow\ p^*=\mu\,c,\qquad \mu\equiv\frac{\sigma}{\sigma-1}>1$$
  (μ **aumenta** con la preferencia por la variedad, baja con σ). Libre entrada, $B=0$ (`eq:entrada-ds`):
$$q^*=x^*=\frac{(\sigma-1)\,\mathrm{CF}}{c},\qquad n^*=\frac{\alpha\overline{W}}{\sigma\,\mathrm{CF}}.$$
  iii) Implicaciones: precio sobre el coste marginal con beneficio nulo (el poder de mercado está en el margen, no en el beneficio); ineficiencia asignativa y economías de escala sin agotar (CMe > CMg; con c constante el CMe no tiene mínimo); el equilibrio coincide con el **óptimo restringido** (sin subvenciones); el **primer óptimo** tiene la misma escala y **más** variedades, $n^{\mathrm o}/n^*=1/[\rho(1-\alpha)+\alpha]>1$ (anexo C, derivación propia); en general, excedente no apropiable frente a robo de clientes (Spence, 1976; Mankiw y Whinston, 1986).
- **c) Extensiones** (una línea cada una, con remisión): comercio (Krugman, 1979 y 1980; Melitz, 2003; centro-periferia, 1991; 3.B.6), macro (Blanchard y Kiyotaki, 1987; con Calvo, el modelo canónico de la NEK, Galí, 2015; 3.A.7, 3.A.32, 3.B.19), crecimiento (Romer, 1990; 3.A.44).
- **d) Evidencia**: Broda y Weinstein (2006): variedades importadas por EE. UU. ×3 en 1972-2001, sesgo del índice de 1,2 puntos al año, valor de la variedad del 2,6 % del PIB.
- **e) Valoración**: soluciones cerradas y bienestar calculable; pero no dice en qué compiten las empresas, la elasticidad cruzada es la misma entre todos los pares (competencia **global**) y el margen es constante (Krugman, 1979, usa una elasticidad creciente). Puente al enfoque de direcciones (competencia **local**).

Nota (3.A.18, nota de I.3): con utilidad cuasilineal, $U=x_0+\alpha\ln y$, el gasto en el grupo es α, sin efecto renta, y los resultados se mantienen sustituyendo $\alpha\overline W$ por α; es la que da la demanda lineal de Singh y Vives (ficha `oligopolio-diferenciado`).

**Gráfico de referencia:** `oposicion/temario/fuentes/3A18/graficos/dixit-stiglitz.tex`, 3 paneles (σ = 2, c = 1, CF = 1): a) pocas variedades, beneficio; b) la entrada desplaza la demanda isoelástica de la variedad y su IMg con el precio fijo en μc; c) tangencia con CMe = c + CF/q (el imprescindible). Apoyo: `3A18/graficos/ces-variedad.tex` (curvas de indiferencia del agregador para σ = 1, 2, 4, ∞, a partir de `3A08/graficos/ces-curvas-indiferencia.tex`).

**Notación:** $x_i$ consumo de la variedad, $q$ producción por empresa, $y$ agregador (nunca $V$, que es la FIU), $P$ índice de precios del grupo (nunca $p_y$; coherente con $P_t(i)$ del 3.A.7 y con la macro), σ, ρ (avisado, `notacion.md` § 1), μ, $\mathcal L$, $\overline W$, α parte del gasto del grupo, CF y $c$ (el comercio admite $F$, D103), $B$, $n$. Sin lagrangiana 𝓛 (en el anexo, multiplicador λ sin nombrar la lagrangiana).

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.18 | Competencia monopolística | desarrollo (hecho, 19/10/2026) | Todo lo anterior; Chamberlin antes (ficha `chamberlin`), Salop después como su versión con direcciones (ficha `salop`) | — |
| 3.B.6 | Comercio intraindustrial (nueva teoría del comercio) | resumen | Agregador y demanda con la notación de arriba (σ, ρ, $P$, μ), con trabajo como único factor y $C(q)=w(F+cq)$ (ficha `krugman-1979`); remitir a 3.A.18 la derivación en 2 etapas y la preferencia por la variedad; Grubel-Lloyd | La derivación en 2 etapas y la discusión de σ > 1 |
| 3.A.7 | Nueva economía keynesiana | resumen | Continuo de variedades $i\in[0,1]$, $P_t\equiv[\int_0^1P_t(i)^{1-\sigma}di]^{1/(1-\sigma)}$, margen μ = σ/(σ−1); Blanchard-Kiyotaki y Calvo; remitir a 3.A.18 | El bienestar y la libre entrada |
| 3.A.11 | Elasticidad de sustitución | mención (hecho, 13/10/2026) | El agregador CES con σ > 1 entre variedades (ficha `ces`) | — |
| 3.A.44 | Crecimiento endógeno | mención | Romer (1990): variedades de bienes intermedios con la misma CES; la preferencia por la variedad se vuelve rendimientos crecientes | El modelo del consumidor |
| 3.A.32, 3.B.19 | Macro abierta, coordinación de políticas | mención | Galí y Monacelli (2005); Corsetti y Pesenti | — |
| 3.A.21 | Equilibrio general | mención opcional (`pendientes-coherencia.md`) | Ejemplo de equilibrio general con competencia imperfecta | — |

## Divergencias encontradas en el temario actual
- 3.A.18 original: demanda sin la renta, μ que dependía «negativamente» de la preferencia por la variedad, «a mayor σ, mayor preferencia por la variedad», σ > 1 «implícito en curvas convexas», 2 etapas «por homoteticidad», π para el beneficio, $p_y$ y $V$ para el agregador. **Resuelto** (19/10/2026).
- 3.B.6 (sin revisar): repite entera la demanda (CES, ρ, preferencia por la variedad, l. 472-483 del Word) en lugar de resumir y remitir; usa $F$ (admitido en comercio, D103). Su «μ depende negativamente de σ» es correcta.
- 3.A.7 (sin revisar): usa Dixit-Stiglitz con continuo de variedades, σ y $P_t(i)$ sin remitir al 3.A.18 (coherente con $P$).

Autor: Víctor Gutiérrez Marcos
