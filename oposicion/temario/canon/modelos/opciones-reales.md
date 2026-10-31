# Inversión bajo incertidumbre e irreversibilidad (opciones reales; Dixit y Pindyck 1994)

- **Área:** macro cerrada · **Tema de referencia:** 3.A.34 (incertidumbre e irreversibilidad de la inversión) — lo tiene en el título.
- **Temas que lo usan:** 3.A.34 (desarrollo), 3.B.2 (resumen: valoración de proyectos), 3.A.33 (mención; hecho, 31/10/2026: III.2 c), la opción de esperar explica el aplazamiento de la compra de duraderos; Bernanke, 1983; Dixit y Pindyck, 1994; `\vertema{3.A.34}`)
- **Manuales de referencia:** Dixit y Pindyck, *Investment under Uncertainty* (1994); Bernanke (1983); Romer (2019), cap. 9.

## Presentación de referencia
Pregunta: ¿por qué la incertidumbre retrasa la inversión aunque el VAN sea positivo? Supuestos: inversión irreversible (coste hundido I), posibilidad de esperar, incertidumbre sobre el valor del proyecto V.

Ejemplo de dos periodos: el proyecto vale hoy V_0; mañana valdrá V^A (prob. p) o V^B (prob. 1−p). Invertir hoy: VAN_0 = E[V] − I. Esperar:
$$VAN_{esperar} = \frac{p\,\max(V^A - I,\,0) + (1-p)\max(V^B - I,\,0)}{1+r}$$
Se invierte hoy solo si VAN_0 ≥ VAN_{esperar}: la regla correcta es $V \ge I + \text{valor de la opción de esperar}$. En tiempo continuo, con V siguiendo un movimiento browniano geométrico de varianza σ², el umbral es $V^* = \frac{\beta_1}{\beta_1-1}\,I > I$, con β_1 > 1 decreciente en σ.
Resultado: mayor incertidumbre → mayor valor de esperar → umbral más alto y menos inversión (efecto de la incertidumbre de política económica). Implicación de política: estabilidad y credibilidad de las reglas, más que incentivos fiscales temporales.
Gráfico de referencia: valor de la opción F(V) frente a V, convexo, tangente a V − I en V*.

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.34 | Incertidumbre e irreversibilidad | desarrollo | Ejemplo de dos periodos, umbral de inversión, implicaciones de política | — |
| 3.B.2 | Valoración de inversiones en la empresa | resumen | Opciones reales (diferir, ampliar, abandonar) como complemento del VAN | La derivación macro [ver tema 3.A.34] |
| 3.A.33 | Demanda de duraderos | mención (hecho, 31/10/2026) | Compra en parte irreversible; con incertidumbre, valor de opción de esperar (principio de las malas noticias); Eberly (1994) | El ejemplo de 2 periodos |

## Divergencias encontradas en el temario actual
- El inventario no recoge ecuaciones en ningún tema; conviene que 3.A.34 incluya el ejemplo de dos periodos anterior. σ aquí es desviación típica (coherente con la propuesta de notación).
- 3.B.2 (sin revisar): «el método del VAN asume irreversibilidad»: más preciso, «supone que la inversión es **reversible** o que es **ahora o nunca**» (Dixit y Pindyck, 1994, cap. 1); su apartado de opciones reales es coherente con la ficha (agente de coherencia del 3.A.34, en curso).

Autor: Víctor Gutiérrez Marcos
