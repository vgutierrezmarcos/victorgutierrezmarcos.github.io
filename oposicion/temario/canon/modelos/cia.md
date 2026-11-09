# Costes de transacción: restricción de pago por adelantado (Clower, 1967; Lucas, 1980) y tiempo de compra (McCallum y Goodfriend, 1987)

- **Área:** macro cerrada · **Tema de referencia:** **3.A.35** (Teorías de la demanda de dinero; revisado el 5/11/2026: II.1.1, «El dinero y los costes de transacción: el tiempo de compra y el pago por adelantado», con a)-c), `eq:cia` y la derivación del tiempo de compra en nota) — son teorías de la demanda de dinero por motivo transacción en equilibrio general. Ficha creada en la fase canon del 3.A.35 (5/11/2026, CC2, **[decidir]**; alias `cash-in-advance`, `shopping-time`).
- **Temas que lo usan:** 3.A.35 (desarrollo; hecho, 5/11/2026), 3.A.6 (mención; hecho, 4/11/2026: l. 1122, el ciclo real cumple la neutralidad incluso con una restricción de pago por adelantado, Cooley y Hansen, 1989, `\vertema{3.A.35}`), 3.A.42 (mención; hecho, 4/11/2026: l. 532 y 1015, lo mismo), 3.A.21 (mención; hecho, 14/10/2026: l. 991, la restricción de liquidez previa al gasto de Clower, «origen de los modelos de pago por anticipado»), 3.A.29 (mención; hecho, 1/11/2026: l. 510, «la restricción de liquidez por adelantado de Clower y Lucas, el tiempo de compra de McCallum»), 3.A.39 (mención; hecho, 4/11/2026: l. 696, con *cash-in-advance* la inflación grava el consumo frente al ocio y reduce el trabajo), 3.A.41 (mención; hecho, 5/11/2026: l. 409, Stockman, 1981, con «restricción de pago por adelantado», la terminología canónica: si el dinero hace falta también para invertir, la inflación baja el capital; ficha `miu-sidrauski`, «Inflación y capital»).
- **Manuales de referencia:** Clower (1967), *Western Economic Journal*; Lucas (1980), «Equilibrium in a Pure Currency Economy»; Svensson (1985), *JPE*; Lucas y Stokey (1987), *Econometrica*; Saving (1971), *JPE*; McCallum y Goodfriend (1987), en *The New Palgrave*; Cooley y Hansen (1989), *AER*; Stockman (1981); Feenstra (1986); Walsh (2017), cap. 3.

## Presentación de referencia

**Pregunta:** ¿por qué se demanda dinero para pagar, sin suponer que da utilidad por sí mismo?

**a) Idea:** el dinero ahorra tiempo al comprar (tiempo de compra) o es imprescindible para comprar (pago por adelantado). Aforismo de **Clower (1967)**, con las palabras del 3.A.21: «el dinero compra bienes y los bienes compran dinero, pero los bienes no compran bienes».

**b) Modelo** (notación canónica, `notacion.md` § 8):

- **Tiempo de compra** (*shopping time*; Saving, 1971; McCallum y Goodfriend, 1987): una unidad de tiempo entre el trabajo $L_t$ (al salario real $w_t$), el ocio **sin letra** y el tiempo de compra **$\psi(C_t,m_t)$**, con $\psi_C>0$, $\psi_m<0$ (cada vez menos); utilidad $u\big(C_t,\,1-L_t-\psi(C_t,m_t)\big)$. Condición (derivación en nota, Walsh, 2017, cap. 3):
$$-\,w_t\,\psi_m(C_t,m_t)=\frac{i_t}{1+i_t}$$
el valor del tiempo que ahorra el último euro, medido al salario, iguala su coste de oportunidad (el mismo $i_t/(1+i_t)$ que `eq:miu`).
- **Restricción de pago por adelantado** (*cash in advance*, CIA; Lucas, 1980; orden de los mercados de Svensson, 1985, en nota): utilidad $u(C_t,1-L_t)$ sin dinero y
$$C_t\leq m_t\qquad(\texttt{eq:cia})$$
Con $i>0$ se cumple con igualdad; en el estado estacionario, $m=C$ y $u_{\text{ocio}}/u_C=w/(1+i)$.

**c) Implicaciones:**

- *Tiempo de compra:* $m_t=L(C_t,i_t,w_t)$, creciente en el consumo y en el salario (el tiempo vale más), decreciente en el tipo. Es la $b$ de Baumol-Tobin medida en tiempo (ejemplo de Lucía). Sustituyendo la restricción de tiempo queda un MIU: **el MIU es su forma reducida** (Feenstra, 1986; ficha `miu-sidrauski`).
- *Pago por adelantado:* la demanda de dinero es el gasto, **velocidad 1** por periodo, escala el consumo: la teoría cuantitativa con fundamento (ficha `teoria-cuantitativa`).
- **La inflación grava el consumo frente al ocio**: el precio efectivo del consumo es $1+i$; más inflación, menos trabajo y producción: **no hay superneutralidad**. Cooley y Hansen (1989) lo miden en un ciclo real: el dinero sigue siendo casi neutral (`\vertema{3.A.42}`). Con **bienes de crédito** (Lucas y Stokey, 1987), la RMS entre el bien al contado y el de crédito es $1+i$: con más inflación se paga más a crédito, sube la velocidad y la demanda vuelve a depender del tipo. Si el dinero hace falta también para invertir, la inflación baja el capital (Stockman, 1981; 3.A.41).
- **Regla de Friedman:** el mismo resultado que en el MIU, $i=0$ (ficha `regla-friedman`).

**d) Valoración:** explican por qué el dinero es útil, pero $\psi$ es tan arbitraria como la utilidad del dinero, y en la CIA qué se paga con dinero lo fija el modelo, no los agentes; en la versión básica la velocidad es constante, contra los datos. Ejemplo de la defensa metodológica de Friedman (1953): el MIU, irreal y sencillo, predice lo mismo (ficha `friedman-metodologia`).

**Pegatina:** «por dinero baila el perro».

**Gráfico de referencia:** ninguno.

**Terminología** (`notacion.md` § 14): «**restricción de pago por adelantado** (*cash in advance*, CIA)», la del 3.A.6, el 3.A.35 y el 3.A.42; nunca «pago por anticipado», «restricción de liquidez por adelantado» ni el término inglés solo. «**Tiempo de compra** (*shopping time*)».

## Cómo se adapta en cada tema

| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.35 | Demanda de dinero | desarrollo (hecho, 5/11/2026) | Las 2 variantes con sus condiciones, Lucas y Stokey, Cooley y Hansen, la regla de Friedman | — |
| 3.A.21 | El dinero en el equilibrio general | mención (hecho) | El aforismo de Clower como una de las 4 vías; «restricción de pago por adelantado» (hoy «pago por anticipado», cosmético) | Las condiciones |
| 3.A.29 | Modelización dinámica | mención (hecho) | Ejemplo de agregado microfundamentado; «la restricción de pago por adelantado de Clower y Lucas, el tiempo de compra de McCallum y Goodfriend» (hoy «restricción de liquidez por adelantado» y «McCallum», cosmético) | — |
| 3.A.6, 3.A.42 | Ciclo real | mención (hecho) | Cooley y Hansen (1989): con la restricción el dinero sigue casi neutral; `\vertema{3.A.35}` | — |
| 3.A.39 | Señoreaje e impuesto inflacionario | mención (hecho) | Con la restricción, la inflación grava el consumo frente al ocio y reduce el trabajo (hoy «*cash-in-advance*» sin traducir, cosmético) | — |
| 3.A.41 | Costes de la inflación | mención (hecho, 5/11/2026) | Stockman (1981): la restricción sobre la inversión baja el capital; el coste de la inflación sin superneutralidad | Las condiciones |

## Divergencias encontradas en el temario actual

- **Terminología** en 4 temas revisados: «restricción de pago por adelantado» (3.A.6, 3.A.42, 3.A.35), «pago por anticipado» (3.A.21, l. 991), «restricción de liquidez por adelantado» (3.A.29, l. 510) y «*cash-in-advance*» (3.A.39, l. 696): entradas cosméticas en `pendientes-coherencia.md` («Pendiente del 3.A.35»).
- El Word del 3.A.35 fechaba McCallum y Goodfriend en 1985 y usaba $h_t$ y $s_t$ para el ocio y el tiempo de compra: 1987, $\psi(C_t,m_t)$ y el ocio sin letra ($h$ es la de la LM; $s_t$, el señoreaje sobre el PIB).

Autor: Víctor Gutiérrez Marcos
