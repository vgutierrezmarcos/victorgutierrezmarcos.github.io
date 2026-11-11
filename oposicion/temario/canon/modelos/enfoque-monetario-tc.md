# Enfoque monetario del tipo de cambio con precios flexibles (Frenkel, Mussa y Bilson)

- **Área:** macro-abierta · **Tema de referencia:** 3.B.14 (Teorías de la determinación del tipo de cambio), **revisado el 11/11/2026**: lo desarrolla en II.1.1 con a)-d), la función clave `eq:monetario`, la solución de valor presente y un gráfico propio; Dornbusch (II.1.2) vuelve a él a largo plazo. Ficha nueva del 11/11/2026 (CC5 del 3.B.14, D-4, **[decidir]**; *alternativa*: una sola ficha `enfoque-monetario` con 2 variantes, la BP con tipo fijo en el 3.B.12 y el tipo de cambio aquí). Recoge el id `enfoque-monetario-tc`, que estaba en el mapa sin fichero.
- **Ficha hermana:** `enfoque-monetario-bp` (referencia 3.B.12): **la misma demanda de dinero** ($k$, $h$ de la LM del 3.A.35); con tipo fijo se ajustan las reservas y con tipo flexible, el tipo de cambio. Cada tema dice lo simétrico y remite al otro.
- **Temas que lo usan:** 3.B.14 (desarrollo; hecho, 11/11/2026), 3.A.5 (mención; hecho, 3/11/2026), 3.A.32 (mención; hecho, 11/11/2026), 3.B.12 (contraste; hecho, 11/11/2026), 3.B.15 (mención), 3.B.19 (supuesto).
- **Fuentes de referencia:** **Frenkel (1976)** (`Frenkel1976Monetary`), **Mussa (1976)** (`Mussa1976Exchange`) y **Bilson (1978)** (`Bilson1978Monetary`): 2 artículos de 1976 más el de Bilson, nunca «Frenkel y Mussa (1976)» como uno solo; Frenkel (1981) y Mussa (1982) para las noticias (`Frenkel1981News`); Frankel (1979) (`Frankel1979Mark`); Frenkel y Johnson (1976) (`FrenkelJohnson1976Monetary`) para la variante de la BP; Krugman, Obstfeld y Melitz, cap. 16; Fisher (1911) y Hume (1752) para la identidad del gasto (nota).

## Presentación de referencia (3.B.14, II.1.1)

**Pregunta:** si el tipo de cambio es el precio relativo de 2 monedas, ¿lo determinan la oferta y la demanda relativas de dinero?

**Supuestos:** PPA absoluta continua, $e=p-p^*$; PNCI (movilidad y sustituibilidad perfectas: por Walras basta el mercado de dinero); demanda de saldos reales $(M/P)^D=Y^k\mathrm e^{-h\,i}$ con la misma forma en los 2 países; oferta de dinero y renta de pleno empleo exógenas.

**Ecuaciones (logaritmos en minúsculas salvo $i$):**
- `eq:demanda-dinero-log`: $m-p=k\,y-h\,i$, $m^*-p^*=k\,y^*-h\,i^*$ (en logaritmos, $k$ elasticidad-renta y $h$ semielasticidad al tipo de interés: avisado una vez, `\vertema{3.A.35}`).
- **Función clave** `eq:monetario`: $e=(m-m^*)-k\,(y-y^*)+h\,(i-i^*)$; con la PNCI y la PPA relativa, $i-i^*=\pi^e-\pi^{*e}$ (paridad de intereses reales).
- Como precio de un activo (`eq:valor-presente`), con expectativas racionales: $e_t=\frac{1}{1+h}\sum_{j\ge0}\big(\frac{h}{1+h}\big)^j\mathbb E_t\big[(m-m^*)_{t+j}-k(y-y^*)_{t+j}\big]$.
- Frankel (1979), `eq:frankel` (en la ficha `dornbusch`): $e=(m-m^*)-k(y-y^*)-\tfrac1\theta\big[(i-\pi^e)-(i^*-\pi^{*e})\big]+h(\pi^e-\pi^{*e})$.
- Precedente en nota: $E=(MV/Y)/(M^*V^*/Y^*)$ y en tasas $\gamma_E=(\gamma_M-\gamma_{M^*})+(\gamma_V-\gamma_{V^*})-(\gamma_Y-\gamma_{Y^*})$.

**Resultado:** más dinero relativo deprecia en la misma proporción ($\partial e/\partial m=1$); más renta relativa aprecia; **más tipo de interés relativo deprecia** (refleja inflación esperada, efecto Fisher), al revés que en los modelos keynesianos y que con precios rígidos (Dornbusch): Frankel (1979) lo reconcilia. El tipo de cambio cambia con las **noticias** sobre los fundamentos futuros.

**Evidencia:** funciona con inflaciones muy altas (hiperinflación alemana, Frenkel, 1976); entre las grandes monedas apenas (Mussa, 1984); se ajustó a los primeros años de la flotación y dejó de hacerlo a finales de los 70; fuera de la muestra no supera al paseo aleatorio (Meese y Rogoff, 1983); a varios años, algo (Mark, 1995).

**Gráfico de referencia:** **`oposicion/temario/fuentes/3B14/graficos/monetario-flexible.tex`** (de KOM, cap. 16): trayectorias de $m$, $i$, $p$ y $e$ tras una subida permanente de la **tasa de crecimiento** del dinero en $t_0$ ($i$ sube con la inflación esperada, $p$ y $e$ saltan al alza y crecen más deprisa). La trayectoria con precios flexibles ante una subida del **nivel** de $m$ está, en discontinua, en `dornbusch-trayectorias.tex`.

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.B.14 | Determinación del tipo de cambio | desarrollo (hecho, 11/11/2026) | II.1.1 a)-d) con `eq:demanda-dinero-log`, `eq:monetario`, `eq:valor-presente`, `monetario-flexible.tex`; el contraste con el de la BP en la presentación del II, `\vertema{3.B.12}` | — |
| 3.A.5 | Monetarismo | mención (hecho, 3/11/2026) | l. 704: la moneda del país que crea más dinero se deprecia, `\vertema{3.B.14}` | La ecuación |
| 3.A.32 | OA-DA abierta | mención (hecho, 11/11/2026) | l. 185: fondos frente a flujos con `FrenkelJohnson1976Monetary` (añadir `\vertema{3.B.12}`: pendiente C3 del 3.B.14) | La ecuación |
| 3.B.12 | Ajuste de la BP | contraste (hecho, 11/11/2026: II.2 c), una línea con `\vertema{3.B.14}`; la demanda de dinero en niveles, $M^D=P\,L(Y,i)$) | El enfoque monetario de la BP con tipo fijo (reservas) y su simétrico con tipo flexible en una línea, `\vertema{3.B.14}`, con la misma demanda de dinero ($k$, $h$) | `eq:monetario` y su evidencia |
| 3.B.15 | Regímenes cambiarios | mención | «un modelo monetario» citando Frenkel (1976) y Mussa (1976), no «Frenkel y Mussa, 1979» | El modelo |
| 3.B.19 | Coordinación internacional | supuesto | Corsetti-Pesenti con PCP «restablece el resultado del modelo monetario con precios flexibles» (Frenkel, 1976; Mussa, 1976), `\vertema{3.B.14}` | — |

## Divergencias encontradas en el temario actual
- **Resuelto en el 3.B.14 (11/11/2026)**: «Frenkel y Mussa (1976)» como un artículo → 3 autores; «$\ln E$» → $e$; la contradicción de la nota 47 (un $i$ más alto deprecia o aprecia) se explica con Frankel (1979); el apartado «identidad contable del gasto» (omisible) pasa a nota con Fisher (1911) y Hume (1752).
- **3.B.15** (sin revisar): «Frenkel y Mussa, 1979, del tema 3.B.14» (l. 432 del Word).

Autor: Víctor Gutiérrez Marcos
