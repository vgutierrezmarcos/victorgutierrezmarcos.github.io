# Paridad del poder adquisitivo (PPA), absoluta y relativa

- **Área:** macro-abierta · **Tema de referencia:** 3.B.14 (Teorías de la determinación del tipo de cambio), **revisado el 11/11/2026**: es la teoría tradicional del tipo de cambio por el arbitraje de bienes y el tema la desarrolla en I.2.1 con a)-d), la evidencia y el anexo `anexo:ppa`. Ficha nueva del 11/11/2026 (CC3 del 3.B.14, D-4, **[decidir]**); recoge el id `ppa`, que estaba en el mapa sin fichero.
- **Temas que la usan:** 3.B.14 (desarrollo; hecho, 11/11/2026), 1D01 (uso; aprobada), 3.B.11 (mención; hecho, 5/11/2026), 3.B.16 (mención; hecho, 11/11/2026), 3.B.13 (mención; hecho, 8/11/2026), 3.B.12 (supuesto o mención), 3.B.15 (supuesto; hecho, 12/11/2026: en Krugman, 1991, y en la demostración del trilema con precios flexibles; sin la PPA relativa como referencia de valoración), 3.B.19 (no la usa; comprobado, 12/11/2026), 3.B.17 (supuesto; hecho, 12/11/2026), 4.A.22 (uso).
- **Manuales y fuentes de referencia:** Cassel (1918, `Cassel1918Abnormal`; 1922, págs. 138-139, `Cassel1922Money`); Azpilcueta (1556) y Grice-Hutchinson (1952) como origen salmantino; Rogoff (1996), «The Purchasing Power Parity Puzzle» (`Rogoff1996PPA`); Taylor y Taylor (2004), *JEP* (`TaylorTaylor2004PPP`); Taylor, Peel y Sarno (2001) (`TaylorPeelSarno2001Nonlinear`); Mussa (1984, 1986); Krugman, Obstfeld y Melitz, cap. 16; *The Economist*, índice Big Mac (`Economist2026BigMac`, `Economist2026BigMacDatos`).

## Presentación de referencia (3.B.14, I.2.1)

**Pregunta:** ¿se ajusta el tipo de cambio nominal para igualar el poder de compra de las monedas?

**Supuestos:** libre comercio sin barreras ni costes de transporte; competencia perfecta (sin discriminación de precios entre países); bienes homogéneos y comerciables, misma cesta en todos los países.

**Ecuaciones (notación canónica, $E$ directo, $q=EP^*/P$):**
- Ley del precio único: $P_k=E\,P^*_k$.
- PPA absoluta (`eq:ppa-absoluta`): $P=E\,P^*\ \Longleftrightarrow\ E=\dfrac{P}{P^*}\ \Longleftrightarrow\ q\equiv\dfrac{EP^*}{P}=1$.
- PPA relativa (`eq:ppa-relativa`): de $\gamma_q\simeq\gamma_E+\pi^*-\pi$ (la forma del 3.B.11) con $\gamma_q=0$, $\gamma_E=\pi-\pi^*$. La absoluta implica la relativa, no al revés.
- En logaritmos (enfoque monetario y Roll): $e=p-p^*$, $q\equiv e+p^*-p$.

**Resultado:** el tipo nominal sigue a los niveles de precios (absoluta) o a las inflaciones (relativa) y el tipo real es constante; si se cumple a largo plazo, el tipo real **revierte a la media** y la PPA es el ancla de largo plazo de los modelos monetarios.

**Evidencia (las cifras canónicas):** a corto plazo no se cumple (el nominal se mueve unas 3 veces más que los precios relativos y el real casi a la par que el nominal, Mussa, 1984; el real es mucho más volátil con flotación, Mussa, 1986); a largo plazo se cumple la relativa, pero despacio: **las desviaciones tardan de 3 a 5 años en reducirse a la mitad** (Rogoff, 1996; la misma cifra y clave en la 1D01); la **paradoja de la PPA** (Rogoff, 1996); no linealidades con banda de inacción por costes de transporte (Heckscher, 1916; Taylor, Peel y Sarno, 2001: con perturbaciones del 1 al 5 %, vida media inferior a 3 años; la horquilla «1-3 años» del Word no se pudo comprobar); se cumple mejor con inflaciones muy altas (Frenkel, 1978). Roll (1979, `Roll1979PPP`): PPA *ex ante*, tipo real como paseo aleatorio (nota al pie en el 3.B.14 y en el 3.B.13). Contrastes (regresiones, raíz unitaria, cointegración, paneles, series de 2 siglos) en el anexo A del 3.B.14.

**Gráfico de referencia:** ninguno teórico. De datos, **`oposicion/temario/fuentes/3B14/graficos/big-mac.tex`** (índice Big Mac de julio de 2026 frente al dólar, sin ajustar; datos en `fuentes/3B14/datos/bigmac-2026-07.csv`, entrada `big-mac` de `datos-actualizables.yaml`): ilustración, «se dice, no se dibuja» en el cante.

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.B.14 | Determinación del tipo de cambio | desarrollo (hecho, 11/11/2026) | I.2.1 a)-d), Cassel traducido, caja y gráfico del Big Mac, evidencia; anexo A; ancla del enfoque monetario (II.1.1) y de Dornbusch a largo plazo | — |
| 1D01 | Dictamen de coyuntura | uso (aprobada) | IV.2: PPA relativa como referencia a medio plazo, la vida media de 3 a 5 años con `Rogoff1996PPA` y la convergencia (Balassa-Samuelson) | La teoría |
| 3.B.11 | Balanza de pagos | mención (hecho, 5/11/2026) | El tipo real en tasas, $\gamma_q\simeq\gamma_E+\pi^*-\pi$ (ficha `tipo-cambio-real`) | — |
| 3.B.13 | Mercado de divisas | mención (hecho, 8/11/2026) | La PPA *ex ante* de Roll (1979) en nota, l. 947, `\vertema{3.B.14}` | — |
| 3.B.16 | Integración monetaria | mención (hecho, 11/11/2026) | Diferenciales de inflación de equilibrio (con Balassa-Samuelson), `\vertema{3.B.14}` | — |
| 3.B.12 | Ajuste de la BP | supuesto (hecho, 11/11/2026) | Ley del precio único en el enfoque monetario de la BP ($P=\overline EP^*$, sin remisión: es un supuesto); $\gamma_q=0$ en la deuda en divisas «con la paridad del poder adquisitivo» (anexo D) | La evidencia |
| 3.B.15 | Regímenes cambiarios | supuesto (hecho, 12/11/2026) | La PPA en el enfoque monetario de las zonas objetivo (II.1.3) y en la `notaopositor` del trilema; el tipo real con `eq:apreciacion-real` (ficha `tipo-cambio-real`) | La evidencia |
| 3.B.17 | Crisis cambiarias | supuesto (hecho, 12/11/2026) | 1.ª generación: PPA con el nivel de precios exterior normalizado a 1, $P_t=E_t$; 2.ª: PPA relativa con inflación exterior nula, escrita $\Delta E/E=\pi$ (no $\gamma_E=\pi$, para no juntar 2 γ con el peso de la pérdida); `\vertema{3.B.14}` | — |
| 3.B.19 | Coordinación internacional | no la usa (comprobado, 12/11/2026) | El 3.B.19 revisado no nombra la PPA: Hamada usa el modelo monetario sin escribirla (ficha `enfoque-monetario-tc`) | — |
| 4.A.22 | Sector exterior de España | uso | Competitividad-precio con el tipo real (la referencia es la ficha `tipo-cambio-real`, 3.B.13); la PPA como referencia, `uso: ampliar` | La teoría |

## Divergencias encontradas en el temario actual
- **Resuelto en el 3.B.14 (11/11/2026)**: el Word escribía el tipo real $\varkappa$ (y $q_t$ o $e$ en notas) y la variación del tipo $\gamma E$: ahora $q$ y $\gamma_E$ (D012, D015); la nota de Roll (1977) era la crítica del CAPM: Roll (1979), una sola mención.
- **1D01** (aprobada, no se toca): en la tabla de fórmulas (l. 2151), la PPA relativa como $\%\Delta E\approx\pi-\pi^*$; el canon es $\gamma_E=\pi-\pi^*$ (cosmético; solo si Víctor quiere).

Autor: Víctor Gutiérrez Marcos
