# Modelo de inventarios de la demanda de dinero (Baumol 1952, Tobin 1956), Miller-Orr (1966) y el motivo precaución de Whalen (1966)

- **Área:** macro cerrada · **Tema de referencia:** **3.A.35** (teorías de la demanda de dinero; revisado el 5/11/2026: II.1.1 «El motivo transacción», a)-e) con `\funcionclave` `eq:baumol-tobin`, el ejemplo de Lucía y Miller-Orr como extensión c); «El motivo precaución: Whalen (1966)», a)-c)) — es una teoría del motivo transacción.
- **Temas que lo usan:** 3.A.35 (desarrollo; hecho, 5/11/2026), 3.B.2 (desarrollo: gestión de tesorería; dudoso, ver Divergencias), 3.A.29 (mención; hecho, 1/11/2026: l. 38, la demanda de dinero microfundamentada «Baumol, Tobin» con `\vertema{3.A.35}`).
- **Manuales de referencia:** Baumol (1952), *QJE*; Tobin (1956), *REStat*; Miller y Orr (1966), *QJE*; Whalen (1966), *QJE*; Goldman (1974); Walsh (2017), cap. 3; Romer (2019); Brealey, Myers y Allen (tesorería); Ball (2001); Benati, Lucas, Nicolini y Weber (2021).

## Presentación de referencia

**Pregunta:** ¿cuánto dinero conviene mantener para pagar, y por qué depende del tipo de interés?

**Supuestos:** ingreso **nominal $Y$** al principio del periodo, gastado de forma uniforme; dinero que no rinde o bonos (cuenta remunerada) que rinden **$i$** en el periodo; **coste fijo $b$ por cada retirada** (en euros o en tiempo), avisado: «aquí $b$ no es la sensibilidad de la inversión al tipo del IS-LM»; $n$ retiradas iguales de $M=Y/n$; saldo en «dientes de sierra» y saldo medio $M/2$.

$$\min_M\ CT(M)=b\,\frac{Y}{M}+i\,\frac{M}{2}\quad\Longrightarrow\quad \boxed{M^*=\sqrt{\frac{2\,b\,Y}{i}},\qquad M^D=\frac{M^*}{2}=\sqrt{\frac{b\,Y}{2\,i}}}\quad(\texttt{eq:baumol-tobin})$$

**$M^D$ sin barra** (la barra es «exógeno o fijado» en el canon; D9 del 3.A.35 y CC6: esta ficha escribía $\bar M^D$). Condición de segundo orden $CT''(M)=2bY/M^3>0$.

**Resultados:**

- **Sin ilusión monetaria:** $M^D/P=\sqrt{(b/P)(Y/P)/(2i)}$.
- **Esquina:** si $Y\leq 2b/i$, todo en dinero (Tobin, 1956).
- **Elasticidades:** $1/2$ a la renta (economías de escala), $-1/2$ al tipo, $1/2$ a $b$.
- **Velocidad endógena:** $V=Y/M^D=\sqrt{2iY/b}$, sube con el tipo y con la renta.
- **Coste en el óptimo:** $CT^*=\sqrt{2biY}$, los 2 costes iguales: el **coste de suela de zapato** de la inflación.
- **Innovación financiera:** baja $b$ y la demanda (desplazamientos de la demanda, II.2).
- **Para la política:** LM con pendiente positiva y finita; con elasticidad renta < 1, la DA depende del reparto de la renta.
- **Ejemplo canónico (Lucía):** $Y=21.600$ €, $b=2$ €, $i=3$ % → $M^*\approx1.697$ €, unas 13 retiradas, saldo medio ≈ 849 €, $V\approx25$, $CT^*\approx51$ €; con $i=12$ %, $M^*\approx849$ €, saldo medio ≈ 424 €, $CT^*\approx102$ €. El 3.A.35 la reutiliza en III.1 (regla de Friedman y coste de la inflación) y en el tiempo de compra (ficha `cia`).
- **Evidencia:** elasticidad renta de M1 ≈ 0,5 en EE. UU. de posguerra (Ball, 2001); elasticidad al tipo de 0,3 a 0,6 con 38 países (Benati *et al.*, 2021).

**Extensión c) — Miller y Orr (1966):** una **empresa** con cobros y pagos netos aleatorios: saldo de caja en paseo aleatorio con **varianza diaria $\sigma^2$**, $b$ coste de cada operación, $i$ tipo diario. Regla de banda: **$M^{\mathrm{inf}}$** saldo mínimo (lo fija la empresa), **$M^{\mathrm{ret}}=M^{\mathrm{inf}}+z^*$** punto de retorno y **$M^{\mathrm{sup}}=M^{\mathrm{inf}}+3z^*$** límite superior (superíndices en redonda), con
$$z^*=\left(\frac{3\,b\,\sigma^2}{4\,i}\right)^{1/3},\qquad \text{saldo medio}=M^{\mathrm{inf}}+\tfrac43 z^*;$$
elasticidad $-1/3$ al tipo y $1/3$ a $b$ y a $\sigma^2$.

**Variante precaución — Whalen (1966)** (no tiene ficha propia: solo la usa el 3.A.35): pagos netos de media nula y varianza $\sigma^2$; probabilidad de iliquidez acotada por Chebyshev, $\sigma^2/M^2$; **$b$ coste de quedarse sin liquidez** (local, otra $b$, avisada):
$$\min_M\ i\,M+b\,\frac{\sigma^2}{M^2}\ \Longrightarrow\ M^*=\left(\frac{2\,b\,\sigma^2}{i}\right)^{1/3};$$
beneficio marginal $2b\sigma^2/M^3$ decreciente frente al coste $i$; elasticidad $-1/3$ al tipo; a la renta 1/3 (más pagos) o 2/3 (pagos mayores) (nota del 3.A.35). Goldman (1974): la precaución como valor de la flexibilidad. Pegatina: «por si las moscas». La S invertida del Word era la probabilidad de iliquidez, no el beneficio marginal.

**Pegatina (Baumol-Tobin):** «en el término medio está la virtud».

**Gráficos de referencia:** `oposicion/temario/fuentes/3A35/graficos/baumol-tobin.tex` (2 paneles: a) saldo en dientes de sierra con el saldo medio $M/2$; b) coste total en U con el coste de conversión y la recta del coste de oportunidad, que gira hacia arriba si sube $i$); `fuentes/3A35/graficos/miller-orr.tex` (la banda con $M^{\mathrm{inf}}$, $M^{\mathrm{ret}}$, $M^{\mathrm{sup}}$); `fuentes/3A35/graficos/whalen.tex` (beneficio marginal decreciente frente al coste de oportunidad).

## Cómo se adapta en cada tema

| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.35 | Demanda de dinero (motivo transacción y precaución) | desarrollo (hecho, 5/11/2026) | a)-e) con `eq:baumol-tobin`, homogeneidad, esquina, velocidad endógena, suela de zapato, Lucía, evidencia; Miller-Orr como extensión; Whalen aparte (motivo precaución) | — |
| 3.B.2 | Gestión de la tesorería de la empresa | desarrollo (aplicación; dudoso) | Mismo modelo como saldo óptimo de tesorería (Baumol) y Miller-Orr con la regla de banda, con las mismas letras ($M^{\mathrm{inf}}$, $M^{\mathrm{ret}}$, $M^{\mathrm{sup}}$, $z^*$) y `\vertema{3.A.35}` | Las implicaciones macro (LM, velocidad) |
| 3.A.29 | Modelización dinámica | mención (hecho, 1/11/2026) | La demanda de dinero microfundamentada, `\vertema{3.A.35}` | El modelo |

## Divergencias encontradas en el temario actual

- **Resuelto en el 3.A.35** (5/11/2026): el Word escribía $M$ «saldos reales» con $Y$ y $b$ nominales, tomaba $M$ por la demanda, hablaba de «elasticidad elevada al tipo» y atribuía a Baumol y Tobin la flexibilización del sistema financiero; Miller-Orr con «el ingreso sigue un paseo aleatorio» y «límites arbitrarios»; Whalen con «efecto de la renta incierto».
- **3.B.2 (sin revisar):** el título vigente («La empresa y las decisiones de inversión…») no nombra la tesorería; el inventario la marcaba «dudosa». Lo decide su revisión (¿mención o desarrollo?); si la cuenta, con estas letras y `\vertema{3.A.35}`. La remisión del 3.A.35 al 3.B.2 se mantiene (su Word trae Wilson y Tobin).

Autor: Víctor Gutiérrez Marcos
