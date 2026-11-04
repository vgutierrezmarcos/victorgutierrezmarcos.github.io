# Contratos escalonados (Fischer, 1977; Taylor, 1979-1980)

- **Área:** macro cerrada · **Tema de referencia:** 3.A.37 (Política monetaria II: rigideces de precios y salarios) — el título pide las rigideces de salarios como mecanismo de transmisión; único tema que lo desarrolla.
- **Temas que lo usan:** 3.A.37 (desarrollo), 3.A.7 (resumen; hecho, 4/11/2026: I.2.1, «reglas dependientes del tiempo», contratos escalonados de salarios aplicables a los precios, en una viñeta y una nota con $w^j_t=\mathbb{E}_{t-j}[p_t]$; reglas de estado, Sheshinski y Weiss, 1977; escalonamiento y sincronización, Ball y Romer, 1989, y Ball y Cecchetti, 1988; `\vertema{3.A.37}`). Debería mencionarse en 3.A.6 (respuesta a la inefectividad, `sargent-wallace-inefectividad`).
- **Manuales de referencia:** Fischer (1977), *JPE* 85; Taylor (1979, *AER*; 1980, *JPE*); Romer (2019), cap. 7.2-7.3; Blanchard y Fischer (1989), cap. 8; Walsh (2017), cap. 6.

## Presentación de referencia

**Pregunta:** ¿por qué la política monetaria sistemática afecta a la producción aunque las expectativas sean racionales?

**Supuestos:** salarios fijados en contratos de dos periodos, la mitad de los trabajadores firma cada periodo; expectativas racionales; demanda y = m − p; variables en logaritmos.

**Ecuaciones:**

- **Fischer** (salario predeterminado, puede variar entre periodos): w^j_t = 𝔼_{t−j}[p_t] (con `\mathbb{E}`, como el 3.A.7), j = 1, 2; p_t = ½(w^1_t + w^2_t). Resultado: y_t depende de la parte de m_t no anticipada en t−2, y una regla que responde a shocks de t−1 estabiliza la producción.
- **Taylor** (salario fijo durante el contrato): x_t = ½(p_t + 𝔼_t p_{t+1}) + (a/2)(y_t + 𝔼_t y_{t+1}), p_t = ½(x_t + x_{t−1}). Resultado: persistencia de los efectos de un shock monetario más allá de la duración del contrato.

**Encaje con las reglas de tiempo y de estado (3.A.7, I.2.1):** Fischer, Taylor y Calvo son reglas dependientes del **tiempo** (revisión en fechas fijadas de antemano, o con probabilidad constante en Calvo); las dependientes del **estado** (Sheshinski y Weiss, 1977) revisan cuando la distancia al óptimo supera un umbral, con una frecuencia endógena que sube con la inflación; hay reglas **mixtas**. Lo que alarga los efectos reales es el **escalonamiento**; con empresas idénticas el único equilibrio estable sería la sincronización (Ball y Romer, 1989), y lo sostienen la heterogeneidad de las perturbaciones o esperar a ver qué precio fijan los competidores (Ball y Cecchetti, 1988).

**Resultado:** la política sistemática es efectiva; la inflación tiene inercia; base de Calvo (1983) y de la NKPC (`nek-3-ecuaciones`).

**Gráfico de referencia:** respuesta de la producción a un shock monetario con contratos de Fischer (dura dos periodos) frente a Taylor (persistencia geométrica).

## Cómo se adapta en cada tema

| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.37 | Rigideces de salarios y transmisión | Desarrollo | Los dos modelos, sus resultados y el paso a Calvo | — |
| 3.A.7 | NEK de 1.ª generación: cómo se ajustan los precios en el tiempo | resumen (hecho, 4/11/2026) | Reglas de **tiempo** (fechas fijadas de antemano: Fischer, Taylor, Calvo) y de **estado** (umbral: Sheshinski y Weiss), mixtas; Fischer y Taylor como contratos de **salarios** aplicables a los precios y respuesta a Sargent y Wallace (nota con $w^j_t=\mathbb{E}_{t-j}[p_t]$); intervalo óptimo y Phillips más inclinada con inflación alta (Ball, Mankiw y Romer, 1988); escalonamiento frente a sincronización (Ball y Romer, 1989; Ball y Cecchetti, 1988); `\vertema{3.A.37}` | Las ecuaciones de Taylor |

## Divergencias encontradas en el temario actual

- Sin ecuaciones en el inventario de ningún tema: 3.A.37 debe incluirlas.
- **Resuelto en el 3.A.7 (4/11/2026)**: Fischer y Taylor rotulados como «rigideces nominales de **precios**» (son contratos escalonados de **salarios**, aplicables a los precios, como los clasifica el 3.A.37); el contrato de Fischer escrito $W_t=\mathrm{E}_t[P_{t+1}]$ (es $w^j_t=\mathbb{E}_{t-j}[p_t]$); Fischer «1979» (es **1977**, *JPE* 85(1)); la sincronización como único equilibrio estable atribuida a Ball (1987) (es **Ball y Romer, 1989**, *RES* 56(2)); las reglas dependientes del tiempo definidas al revés («en función de la evolución de los acontecimientos»: esas son las de estado).
- **Notación, para el 3.A.37 (**[decidir]**)**: en la ecuación de Taylor de arriba el salario del contrato es $x_t$ (como Romer, 2019), pero en el canon $x_t$ es la brecha de producción (§ 8) y los 2 conviven en el 3.A.37: escribir el salario del contrato **$w^c_t$** (local). Cambia solo esta ficha y el 3.A.37 al revisarlo.

Autor: Víctor Gutiérrez Marcos
