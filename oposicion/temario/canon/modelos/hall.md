# Paseo aleatorio del consumo (Hall 1978)

- **Área:** macro cerrada · **Tema de referencia:** 3.A.33 (teorías del consumo; evidencia empírica) — único tema que lo desarrolla.
- **Temas que lo usan:** 3.A.33 (desarrollo), 3.A.10 (mención)
- **Manuales de referencia:** Hall (1978); Romer (2019), cap. 8; Blanchard y Fischer (1989), cap. 6.

## Presentación de referencia
Pregunta: ¿qué implica la renta permanente con expectativas racionales para la dinámica del consumo? Supuestos: horizonte infinito (o largo), utilidad cuadrática u(C) = C − (a/2)C², tipo de interés igual a la tasa de descuento (r = ρ), expectativas racionales, sin restricciones de liquidez.

$$u'(C_t) = \mathbb{E}_t[u'(C_{t+1})]\;\Rightarrow\;\mathbb{E}_t[C_{t+1}] = C_t\;\Rightarrow\;C_{t+1} = C_t + \varepsilon_{t+1},\quad \mathbb{E}_t[\varepsilon_{t+1}] = 0$$
Resultado: el consumo sigue un paseo aleatorio; ninguna variable conocida en t ayuda a predecir ΔC_{t+1}; el consumo solo cambia por noticias sobre la renta permanente. Contrastes: exceso de sensibilidad (Flavin 1981; Campbell-Mankiw 1989, fracción λ de consumidores que consumen su renta corriente) y exceso de suavidad (Deaton). Con utilidad con prudencia (u''' > 0) aparece el ahorro precautorio (Leland, 1968; Sandmo, 1970; Kimball, 1990, coeficiente de prudencia −u'''/u''; 3.A.10, ficha `aversion-riesgo-arrow-pratt`).
Gráfico de referencia: no imprescindible.

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.33 | Ciclo vital, renta permanente y evidencia | desarrollo | Derivación, contrastes (Flavin, Campbell-Mankiw, Deaton), implicaciones de política (solo importan los cambios no anticipados y permanentes) | — |
| 3.A.10 | Incertidumbre y aversión al riesgo | mención (hecho, 19/10/2026: prudencia, I.1.2, y conclusión, con `\vertema{3.A.33}`) | Con u cuadrática (u''' = 0) no hay ahorro precautorio y el consumo de Hall sigue un paseo aleatorio sin motivo precaución; con u''' > 0 sí (Leland, Sandmo; prudencia de Kimball, 1990); DARA ⇒ prudencia | Derivación del paseo aleatorio |

## Divergencias encontradas en el temario actual
- **Error** en 3.A.33: la ecuación aparece como C_t = C_{t+1} + ε_{t+1}; la forma correcta es **C_{t+1} = C_t + ε_{t+1}** (el error de predicción se suma al consumo futuro).
- 3.A.33: tabla con Leland (1968) y Sandmo (1970) sin Kimball (1990) ni la condición u''' > 0 como necesaria y suficiente: añadirlos con la redacción del 3.A.10 (`mapa.yaml`, contradicciones del 3.A.10).
- 3.A.33 usa C_t (mayúscula) en Hall y c_t en Euler: propuesta **C_t** en todo el tema.

Autor: Víctor Gutiérrez Marcos
