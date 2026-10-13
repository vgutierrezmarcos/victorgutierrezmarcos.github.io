# Índices de coste de la vida e índices de Laspeyres y Paasche

- **Área:** consumidor-producción · **Tema de referencia:** 3.A.9 (Demanda II: medidas de cambio en el bienestar) — único que lo desarrolla con la función de gasto.
- **Temas que lo usan:** 3.A.9 (desarrollo), 4.A.1 (resumen: IPC, IPI, ICLA); 3.A.8 lo menciona (preferencia revelada) y 3.A.30 (inflación) lo usa.
- **Manuales de referencia:** Mas-Colell, Whinston y Green, cap. 3.I; Deaton y Muellbauer (1980), cap. 7; Varian, cap. 8; manual del IPC del INE y de Eurostat (4.A.1).
- **Decisión D044 (13/10/2026):** ¿Qué letra llevan las ponderaciones de los índices (IPC, tipos de cambio efectivos, ITC)? ω_i (ω_{i,t−1} en el IPC; media geométrica con pesos ω_i en los tipos efectivos)

## Presentación de referencia
Pregunta: ¿cuánto hay que compensar al consumidor ante un cambio de precios, cuando solo se observan precios y cantidades?
Índice verdadero (de Konüs), con la función de gasto:
$$I_{K}=\frac{E(p^1,\overline U^0)}{E(p^0,\overline U^0)}$$
Aproximaciones observables (cantidades en canon: $x$):
$$I_L=\frac{p^1\cdot x^0}{p^0\cdot x^0}\ \ge I_K(\overline U^0),\qquad I_P=\frac{p^1\cdot x^1}{p^0\cdot x^1}\ \le I_K(\overline U^1)$$
Laspeyres sobreestima el coste de la vida (sesgo de sustitución); Paasche lo subestima. Relación con VC y VE: $p^1\cdot x^0-\overline W\ge VC$.
Gráfico de referencia: dos rectas de balance en $(x_1,x_2)$, cesta $x^0$, curva $\overline U^0$ y recta con precios $p^1$ que pasa por $x^0$ (Laspeyres) frente a la tangente a $\overline U^0$ (verdadero).

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.9 | Medidas de cambio en el bienestar | desarrollo | Índice de Konüs, cotas de Laspeyres y Paasche, relación con VC/VE | — |
| 4.A.1 | Fuentes estadísticas | resumen | IPC como Laspeyres encadenado con ponderaciones $w_{i0}$ actualizadas cada año; sesgos (sustitución, calidad, nuevos bienes); deflactor del PIB como Paasche | La derivación con la función de gasto (remitir a 3.A.9) |
| 3.A.8 | Preferencia revelada | mención | Las comparaciones con Laspeyres/Paasche se basan en el ADPR | — |

## Divergencias encontradas en el temario actual
- 3.A.9 usa $q$ para las cantidades en los índices y $x$ en el resto: usar $x$ (en 4.A.1, donde es estadística, puede mantenerse $q_{it}$ si se avisa).
- 3.A.9 escribe superíndice $t$ y $1$ para el periodo final: canon $p^0,p^1$ y $x^0,x^1$ (3.A.8).
- 4.A.1 usa $w_{i0}$ para ponderaciones: choca con $w$ = precios de factores; canon $\omega_{i0}$ ($\omega_{i,t-1}$ en el IPC encadenado).
