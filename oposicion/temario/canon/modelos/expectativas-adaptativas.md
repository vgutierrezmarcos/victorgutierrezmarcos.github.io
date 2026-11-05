# Expectativas adaptativas (Cagan, 1956; Friedman, 1957; Nerlove, 1958)

- **Área:** pensamiento · **Tema de referencia:** **3.A.5** (La síntesis neoclásica. El monetarismo; revisado el 3/11/2026: II.1 `sec:caracterizacion-monetarismo`, `eq:expectativas-adaptativas`) — son el método del monetarismo frente a las expectativas estáticas de la síntesis (la ficha del cambio de temario del 3.A.5 pone «método: expectativas adaptativas») y el 3.A.5 es el único tema que las presenta como hipótesis general, con sus usos, su ventaja y su límite. Ficha creada en la fase canon del 3.A.5 (CC5, **[decidir]**).
- **Temas que lo usan:** 3.A.5 (desarrollo; hecho, 3/11/2026), 3.A.1 (mención; hecho, 4/11/2026: anexo B `anexo:expectativas`, de las estáticas a las racionales, con la forma canónica $\pi^e_t=\pi^e_{t-1}+\gamma(\pi_{t-1}-\pi^e_{t-1})$, γ ∈ (0,1], y `\vertema{3.A.5}`; en el mismo tema, γ y $a$ también salen como letras locales del hiperbólico generalizado, en otro apartado), 3.A.16 (resumen; hecho, 17/10/2026: anexo E, la telaraña con adaptativas de Nerlove, condición de estabilidad más amplia), 3.A.28 (resumen; hecho, 31/10/2026: con γ = 1, $\pi^e_t=\pi_{t-1}$ da la curva aceleracionista, `eq:aceleracionista`), 3.A.33 (resumen; hecho, 31/10/2026: la renta permanente, con la observación del periodo), 3.A.35 (mención; hecho, 5/11/2026: II.1.3, Cagan forma las expectativas de modo adaptativo en continuo, $\dot\pi^e=\gamma(\pi-\pi^e)$, con γ la velocidad de ajuste; las racionales de Sargent y Wallace, 1973) y 3.A.41 (mención: la inflación esperada de Cagan en las hiperinflaciones; ficha `cagan`), 3.A.6 (resumen; hecho, 4/11/2026: I.2 a), `eq:adaptativas` con la forma canónica y γ, el ejemplo de la inflación que sube con γ = 0,5 y γ = 1 y el gráfico `expectativas`; en la caja gris, las adaptativas como extrapolativas con $a_i=\gamma(1-\gamma)^{i-1}$; `\vertema{3.A.5}`), 3.A.36 (mención; hecho, 4/11/2026: I.1.2, Friedman, 1968: con adaptativas, el paro solo se aparta de su tasa natural mientras la inflación sorprende y mantenerlo por debajo exige una inflación cada vez mayor; sin la desinflación gradual). Relacionadas: `telarana`, `phillips`, `renta-permanente`, `cagan`, `monetarismo`.
- **Manuales de referencia:** Cagan (1956), «The Monetary Dynamics of Hyperinflation»; Friedman (1957), *A Theory of the Consumption Function*, cap. 6; Nerlove (1958), «Adaptive Expectations and Cobweb Phenomena», *QJE*; Muth (1961); Romer (2019), cap. 6; Snowdon y Vane (2005), cap. 4.

## Presentación de referencia (3.A.5, II.1)

**Pregunta:** ¿cómo forman los agentes sus previsiones si aprenden de sus errores pasados?

**Forma canónica** (`eq:expectativas-adaptativas`; previsión con el **error del periodo anterior**):

$$\pi^e_t=\pi^e_{t-1}+\gamma\,\big(\pi_{t-1}-\pi^e_{t-1}\big)=\gamma\sum_{j=0}^{\infty}(1-\gamma)^j\,\pi_{t-1-j},\qquad \gamma\in(0,1]$$

con la variable que toque en cada tema (π en el 3.A.5 y el 3.A.28, $p$ en la telaraña del 3.A.16). **En palabras**: la previsión es una media de los valores pasados con pesos que decrecen geométricamente; con γ = 1 se espera el valor del periodo anterior ($\pi^e_t=\pi_{t-1}$, la aceleracionista del 3.A.28).

**Las 2 formas de calendario** (aviso que da el 3.A.5 en nota; no es una contradicción): Friedman (1957) pondera también la observación del **propio periodo**, $Y^P_t=Y^P_{t-1}+\gamma\,(Y_t-Y^P_{t-1})=\gamma\sum_{j\ge0}(1-\gamma)^jY_{t-j}$ (3.A.33, `eq:expectativas-adaptativas` de ese tema); el 3.A.16, el 3.A.28 y el 3.A.5 usan el error del periodo anterior. Es la misma regla con otro calendario.

**Notación:** **γ sin subíndice** es el peso del error (Nerlove; `notacion.md` § 1); con subíndice, $\gamma_X$ es la tasa de crecimiento de $X$ (D012): conviven en el 3.A.5 y lo dice una vez. Nunca λ (queda para Campbell y Mankiw) ni β.

**Usos** (una línea cada uno en el 3.A.5): Cagan (1956), la inflación esperada en las hiperinflaciones; Friedman (1957), la renta permanente; Nerlove (1958), los precios agrícolas de la telaraña, donde amortiguan el ciclo.

**Valoración:** *ventaja*, los agentes aprenden de sus errores (las estáticas no lo permitían); *límite*, si la variable sube año tras año se quedan siempre cortos y cometen **errores sistemáticos**; Muth (1961) y la nueva macroeconomía clásica las sustituyen por las racionales (`\vertema{3.A.6}`). Pegatina del 3.A.5: «el hombre es el único animal que tropieza dos veces en la misma piedra».

**Gráfico de referencia:** ninguno propio; se ven en el recorrido A → B → C → D de `phillips-aumentada.tex` (3.A.28, copiado en el 3.A.5) y en la telaraña amortiguada del 3.A.16.

## Cómo se adapta en cada tema

| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.5 | Síntesis y monetarismo | desarrollo (hecho, 3/11/2026) | Forma canónica, en palabras, nota del calendario, usos, ventaja y límite | — |
| 3.A.1 | Métodos y racionalidad | mención (hecho, 4/11/2026) | Anexo B: la forma canónica con $\pi^e_t$ y γ, para ordenar las hipótesis antes de la crítica conductual | La derivación y las aplicaciones |
| 3.A.16 | Dinámicas de ajuste | resumen (hecho, 17/10/2026) | $p^e_t=p^e_{t-1}+\gamma(p_{t-1}-p^e_{t-1})$ en el anexo E, con la zona de estabilidad mayor (ficha `telarana`) | La hipótesis general |
| 3.A.28 | Tasa natural y NAIRU | resumen (hecho, 31/10/2026) | Con γ = 1, la aceleracionista; las adaptativas como razón de la vertical a largo plazo | La forma general |
| 3.A.33 | Teorías del consumo | resumen (hecho, 31/10/2026) | La renta permanente con la observación del periodo (calendario de Friedman, 1957) | — |
| 3.A.35 (hecho, 5/11/2026), 3.A.41 | Demanda de dinero; inflación | mención | La inflación esperada de Cagan; con adaptativas y ajuste rápido, inestabilidad (ficha `cagan`) | La forma general |
| 3.A.6 | Nueva macroeconomía clásica | resumen (hecho, 4/11/2026; antes prevista como mención) | `eq:adaptativas` (forma canónica, γ), errores sistemáticos con una inflación que sube (gráfico `expectativas`), Muth (1961) y la telaraña (ficha `telarana`); `\vertema{3.A.5}` | Los usos de Cagan, Friedman y Nerlove |
| 3.A.36 | Política monetaria | mención (hecho, 4/11/2026) | I.1.2: Friedman (1968) con adaptativas, la aceleración; `\vertema{3.A.28}` | La fórmula (3.A.5) |

## Divergencias encontradas en el temario actual

- **Resuelto en el 3.A.5 (3/11/2026)**: el Word nombraba las adaptativas («HEA») sin escribirlas; la sigla, con su nombre la primera vez.
- **2 calendarios sin aviso** en los temas revisados (3.A.16 y 3.A.28 con el error del periodo anterior; 3.A.33 con la observación corriente): no es un error; el aviso está en la nota del 3.A.5 y en esta ficha. Si se quiere, una nota igual en el 3.A.33 (opcional; no se ha pedido en `pendientes-coherencia.md`).

Autor: Víctor Gutiérrez Marcos
