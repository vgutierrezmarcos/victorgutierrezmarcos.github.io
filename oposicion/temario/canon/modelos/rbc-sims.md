# Modelo de ciclo real con gasto público (Baxter-King, 1993; Sims)

- **Área:** sector público · **Tema de referencia:** 4.B.4 **[decidir]** (mapa). Alternativa natural: 3.A.38 (política fiscal y crecimiento) o el tema de ciclos reales (3.A.42), dejando en 4.B.4 el resultado.
- **Temas que lo usan:** 4.B.4 (desarrollo), 3.A.38 (desarrollo)
- **Manuales de referencia:** Baxter y King (1993), «Fiscal policy in general equilibrium», *AER*; Aiyagari, Christiano y Eichenbaum (1992); Romer, cap. 5; notas de Eric Sims (Notre Dame) sobre el RBC con gasto público [comprobar la cita «Sims 2015»].

## Presentación de referencia
**Pregunta:** en un modelo neoclásico con agentes ricardianos, ¿qué efecto tiene un aumento del gasto público?

**Supuestos:** agente representativo de horizonte infinito, competencia perfecta, Cobb-Douglas, choques AR(1) de tecnología y gasto, gasto financiado con impuestos de suma fija (equivalencia ricardiana).

**Ecuaciones (notación canónica de macro: $\beta=1/(1+\rho)$, CRRA según la ficha `crra`):**
$$Y_t=C_t+I_t+G_t,\quad Y_t=A_tK_t^{\alpha}L_t^{1-\alpha},\quad C_t^{-\theta}=\beta\,E_t\!\left[C_{t+1}^{-\theta}(1+R_{t+1}-\delta)\right],\quad \zeta L_t^{\varphi}=C_t^{-\theta}W_t,$$
$$G_t+r_{t-1}D_{t-1}=T_t+(D_t-D_{t-1}).$$

**Resultado:** el gasto (financiado con suma fija) reduce la riqueza de los hogares: baja el consumo y sube la oferta de trabajo; la producción sube con multiplicador positivo pero **menor que 1**; desplaza consumo e inversión; un gasto permanente tiene más efecto sobre el trabajo que uno transitorio. Con impuestos distorsionantes, el multiplicador puede ser negativo.

**Gráfico de referencia:** funciones impulso-respuesta a un choque de gasto (Dynare). No hay `.tex` todavía.

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 4.B.4 | Presupuesto compensador | Resumen (propuesta) | Resultado: efecto riqueza y multiplicador < 1; contraste con el NEK | Ecuaciones completas |
| 3.A.38 | Política fiscal y crecimiento/ahorro | Desarrollo | Modelo completo | — |

## Divergencias encontradas en el temario actual
- Restricción del gobierno con índices distintos en el RBC ($G_t+r_{t-1}D_t\le T_t+D_{t+1}-D_t$) y en el NEK ($G_t+r_{t-1}D_{t-1}\le T_t+D_t-D_{t-1}$) del mismo 4.B.4. Propuesta: la segunda ($D_t$ = deuda al final de $t$), como 3.A.39.
- 4.B.4 dice que ninguna condición depende de «$\tau_t$», pero el modelo solo tiene impuestos de suma fija $T_t$.
- Descuento: $1/(1+\rho)$ en 3.A.38 y $\rho$ en 4.B.4; propuesta $\beta=1/(1+\rho)$.
- Los «efectos no keynesianos» se exponen dos veces casi iguales en 4.B.4 (RBC y evidencia).
