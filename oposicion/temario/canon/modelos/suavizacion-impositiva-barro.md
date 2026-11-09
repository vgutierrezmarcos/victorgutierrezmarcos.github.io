# Suavización impositiva (Barro, 1979)

- **Área:** macro cerrada · **Tema de referencia:** 3.A.39 (Déficit público. Financiación): teoría normativa de la deuda. **Hecho (revisado el 4/11/2026):** I.3.2 con a)-e), `\optim`, la CPO con μ, el tipo constante, el paseo aleatorio, el ejemplo de la guerra y el gráfico de referencia. La versión con ecuaciones de partida estaba en el **Word del 3.A.38** («La política fiscal óptima y la suavización impositiva», con τ como recaudación), **no en el 4.B.11** como decía antes esta ficha (el Word del 4.B.11 solo cita la equivalencia ricardiana).
- **Temas que lo usan:** 3.A.39 (desarrollo; hecho, 4/11/2026), 3.A.38 (mención en el cuerpo y resumen en el anexo C; hecho, 5/11/2026: I.2 c) en una viñeta, «la lógica de Ramsey aplicada al tiempo», con la nota del exceso de gravamen y el gráfico pequeño `exceso-gravamen`, `\vertema{3.A.39}` `\vertema{4.B.11}`; anexo C con $T_t/Y_t$, μ y $\bar\tau$, la deuda que no se amortiza y ρ_G dicho con palabras), 4.B.11 (resumen: enlace con Ramsey), 4.B.9 (resumen), 4.B.4 (mención: déficits contracíclicos y estabilizadores, sin revisar).
- **Manuales de referencia:** Barro (1979), «On the Determination of the Public Debt», *JPE* 87; Romer (2019), cap. 13; Lucas y Stokey (1983); Barro (1986, 1987) para la evidencia.
- **Decisión D089 (13/10/2026):** ¿Cuál es el tema de referencia de la suavización impositiva de Barro (1979)? 3.A.39 (financiación del déficit). La precisión de que las ecuaciones venían del 3.A.38 y no del 4.B.11 es del 4/11/2026 (C1 de la coherencia del 3.A.39).

## Presentación de referencia

**Pregunta:** si los impuestos distorsionan, ¿cómo debe repartir el Estado los impuestos en el tiempo para financiar un gasto dado y para qué sirve la deuda?

**a) Idea:** la equivalencia ricardiana falla porque los impuestos distorsionan; entonces la deuda sirve para repartirlos en el tiempo. Es la suavización del consumo de la renta permanente aplicada a los impuestos (`\vertema{3.A.33}`).

**b) Modelo. Supuestos:** los de la equivalencia ricardiana salvo uno: recaudar $T_t$ (real) cuesta una distorsión $Y_t\,f(T_t/Y_t)$ que depende del tipo medio $T_t/Y_t$, con $f(0)=0$, $f'>0$, $f''>0$ (como el exceso de gravamen de Harberger, que crece con el cuadrado del tipo, `\vertema{4.B.11}`); $r$ constante; sendas de $G_t$ e $Y_t$ conocidas. (C1 proponía añadir $f'(0)=0$; el 3.A.39 no lo pone.)

**Desarrollo** (`eq:suavizacion`, con `\optim`; la restricción es `eq:ricardiana-estado`):

$$\min_{\{T_t\}} \sum_{t=0}^{\infty}\frac{Y_t\, f(T_t/Y_t)}{(1+r)^t}\quad\text{s.a.}\quad \sum_{t=0}^{\infty}\frac{T_t}{(1+r)^t} = \sum_{t=0}^{\infty}\frac{G_t}{(1+r)^t} + (1+r)D_{-1}$$

Con el precio sombra **μ** (no λ, que en el 3.A.39 es la fracción de hogares de Campbell y Mankiw; avisado en nota; A39-09): $f'(T_t/Y_t)=\mu$ para todo $t$ ⟹ **tipo medio constante** (`eq:tipo-constante`):

$$\frac{T_t}{Y_t}=\bar\tau=\frac{\sum_tG_t/(1+r)^t+(1+r)D_{-1}}{\sum_tY_t/(1+r)^t}$$

el gasto «permanente» sobre la producción «permanente» ($\bar\tau$ es la misma ratio τ de `eq:restriccion-ratios`, con la barra de lo fijo). Con incertidumbre, $f'(T_t/Y_t)=\mathbb{E}_t[f'(T_{t+1}/Y_{t+1})]$: con $f$ cuadrática, **paseo aleatorio** (como Hall, `\vertema{3.A.33}`). La deuda: $D_t=(1+r)D_{t-1}+G_t-\bar\tau Y_t$. **Ejemplo de la guerra** (producción constante, un gasto $\Delta G_0$ de un periodo): $\Delta\bar\tau\,Y=\frac{r}{1+r}\Delta G_0$, el tipo sube poco y para siempre; la deuda sube $\Delta G_0/(1+r)$ y **se queda ahí: no se amortiza**, solo se pagan sus intereses (en % del PIB baja si la economía crece).

**Implicaciones:** el gasto transitorio, con deuda; el permanente, con impuestos; déficits contracíclicos y estabilizadores automáticos (las reglas deberían mirar al ciclo completo, `\vertema{4.B.4}`); Ramsey reparte los impuestos entre bienes y Barro entre periodos (`\vertema{4.B.11}`).

**c) Extensiones:** Gobierno impaciente ($\rho_G>r$; con $f(\tau)=\tau^2/2$ y 2 periodos, $\tau_0/\tau_1=(1+r)/(1+\rho_G)<1$: se endeuda de más; puente con el sesgo deficitario, ficha `sesgo-deficitario`); deuda contingente (Lucas y Stokey, 1983). **d) Evidencia:** EE. UU., la deuda sube en guerras y recesiones (Barro, 1986); Reino Unido 1701-1918 (Barro, 1987); no explica los déficits en paz y expansión desde los 70 (Romer, 2019, cap. 13). **e) Valoración:** teoría normativa: dice cuánta deuda *debería* haber.

**Gráfico de referencia:** 3 paneles en el tiempo, que se dibujan de arriba abajo: gasto con un pico de un periodo, tipo impositivo casi plano que sube un poco y para siempre, deuda que sube en el pico y **se queda** (no se amortiza). `fuentes/3A39/graficos/suavizacion-impositiva.tex`. (La ficha decía antes «deuda que sube en el pico y se amortiza después»: corregido; con producción constante solo baja en % del PIB si hay crecimiento.)

## Cómo se adapta en cada tema

| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.39 | Financiación óptima del déficit | Desarrollo (hecho, 4/11/2026) | I.3.2 a)-e): `eq:suavizacion`, CPO con μ, `eq:tipo-constante`, paseo aleatorio, ejemplo de la guerra, gráfico `suavizacion-impositiva`, Ramsey, Gobierno impaciente, Lucas-Stokey, Barro (1986, 1987) | — |
| 3.A.38 | Efectos de la política fiscal | Mención (hecho, 5/11/2026; anexo C en resumen) | El resultado en una viñeta de I.2 c): si la distorsión crece con el cuadrado del tipo, tipo medio constante $T_t/Y_t=\bar\tau$ y deuda para el gasto transitorio y el ciclo (déficits en las recesiones, superávits en las expansiones); Ramsey reparte entre bienes y Barro entre periodos; nota del exceso de gravamen (doblar el tipo cuadruplica el triángulo) con `exceso-gravamen` (`fuentes/3A38/graficos/`); anexo C con la notación del 3.A.39 | La derivación (`\vertema{3.A.39}`) |
| 4.B.11 | Imposición óptima en el tiempo | Resumen | Enlace con Ramsey (entre bienes frente a entre periodos) y Lucas-Stokey; el tipo constante con $T_t/Y_t$ | La derivación completa (remitir a 3.A.39 sin depender de él) |
| 4.B.9 | Impuestos y ahorro | Resumen | Resultado: tipo constante | La derivación |
| 4.B.4 | Política fiscal discrecional | Mención | Justificación de los déficits contracíclicos | El modelo |

## Divergencias encontradas en el temario actual

- **τ_t como recaudación en nivel** (Word del 3.A.38, 4.B.9, 4.B.11, con aviso «aquí τ es recaudación, no tipo»): canon **T_t** para la recaudación y **T_t/Y_t** (o $\bar\tau$) para el tipo medio, de modo que τ sea siempre un tipo. **3.A.39 resuelto** (4/11/2026).
- **3.A.39 resuelto** (4/11/2026): el apartado estaba vacío en el Word; se escribió con ecuaciones (fuente: Word del 3.A.38, Barro, 1979, y Romer, 2019).
- **Multiplicador:** la ficha no le daba letra; en el 3.A.39 es **μ** (§ 1, μ también es el multiplicador del dual del consumidor y del coste: aquí, el de la restricción intertemporal del Estado).

Autor: Víctor Gutiérrez Marcos
