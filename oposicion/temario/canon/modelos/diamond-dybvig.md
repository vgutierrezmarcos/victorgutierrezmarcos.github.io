# Pánicos bancarios (Diamond y Dybvig, 1983)

- **Área:** finanzas-empresa · **Tema de referencia:** **[decidir]**
  - **3.B.26** (Crisis financieras y pánicos bancarios) — *propuesta*: lo tiene en el título, pero **no tiene fuente**; al escribirlo, se toma como base la presentación de 4.A.20 (la más completa: cuatro gráficos y ecuaciones) y la de 3.B.27.
  - Mientras tanto, el desarrollo está en **3.B.27** (Regulación financiera), que lo usa para justificar el seguro de depósitos y el prestamista de última instancia; si se prefiere no esperar a 3.B.26, 3.B.27 puede quedar como referencia y 3.B.26 lo resume.
- **Temas que lo usan:** 3.B.26 (previsto, sin fuente), 3.B.27 (desarrollo → resumen), 4.A.20 (desarrollo → resumen aplicado), 3.B.17 (resumen → mención), 3.A.10 (mención)
- **Manuales de referencia:** Diamond y Dybvig (1983, *JPE*); Freixas y Rochet, *Microeconomics of Banking*, cap. 7; Allen y Gale, *Understanding Financial Crises* (2007), cap. 3; Mishkin, *Economics of Money, Banking and Financial Markets*.

## Presentación de referencia
**Pregunta:** ¿por qué los bancos, que mejoran el reparto del riesgo de liquidez, son vulnerables a pánicos?

**Supuestos:** tres periodos ($T = 0, 1, 2$); continuo de agentes idénticos ex ante con dotación 1; con probabilidad $\pi$ son impacientes (consumen en $T=1$) y con $1-\pi$ pacientes; tecnología: el activo ilíquido rinde $R > 1$ en $T=2$ y $L \le 1$ si se liquida en $T=1$; utilidad cóncava (aversión relativa al riesgo $> 1$).

**Ecuaciones (notación canónica):**
$$\max\; \pi\,u(c_1) + (1-\pi)\,u(c_2) \quad \text{s.a.}\quad \pi c_1 + \frac{(1-\pi)\,c_2}{R} = 1 \;\Rightarrow\; u'(c_1) = R\,u'(c_2),\quad 1 < c_1^* < c_2^* < R$$
El depósito ofrece $(c_1^*, c_2^*)$; si los pacientes esperan que los demás retiren, retirar es óptimo: dos equilibrios (bueno y pánico). Ordenación: $U^{pánico} < U^{autarquía} < U^{mercado} < U^{óptimo} = U^{banco,\,eq.\,bueno}$.

**Resultado:** la transformación de plazos crea equilibrios múltiples; el seguro de depósitos, la suspensión de convertibilidad o el prestamista de última instancia eliminan el equilibrio malo.

**Gráfico de referencia:** plano $(c_1, c_2)$: restricción de autarquía entre $(1, R)$ y $(L, R)$ [o $(1,1)$ y $(r_1,r_2)$], punto de mercado $(1, R)$, tangencia del planificador y contrato bancario. Sin `.tex` aún.

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.B.26 | Crisis y pánicos bancarios | desarrollo (si se elige) | Modelo completo, equilibrios múltiples, extensiones (Goldstein-Pauzner, Allen-Gale) | — |
| 3.B.27 | Regulación financiera | resumen | Justificación del seguro de depósitos y del prestamista de última instancia; riesgo moral resultante | El modelo completo y sus cuatro gráficos (si la referencia es 3.B.26) |
| 4.A.20 | Sistema financiero español | resumen aplicado | Inestabilidad bancaria como argumento para diversificar hacia financiación no bancaria | Derivación |
| 3.B.17 | Crisis de BP | mención | Crisis gemelas: pánico bancario + ataque (Chang-Velasco) | — |
| 3.A.10 | Incertidumbre | mención | Seguro de liquidez como aplicación de la utilidad esperada | — |

## Divergencias encontradas en el temario actual
- **Referencia rota**: el mapa asigna 3.B.26 (sin fuente) mientras el único desarrollo completo está en 3.B.27 y otro en 4.A.20.
- **Notación**: fracción de impacientes $\tau$ en 4.A.20 (choca con $\tau$ coste iceberg y tipos impositivos); rendimientos del activo ilíquido $r_1 < 1 < r_2$ y del depósito $r_1^d, r_2^d$ en 4.A.20; consumo $c$ en 3.A.10 y $c_1, c_2$ en 4.A.20. Propuesta: $\pi$, $R$, $L$, $c_1$, $c_2$ (Freixas-Rochet; Allen-Gale) **[decidir]**.
- 3.B.27 tiene la errata «modelo de Corunot» en un título de gráfico (es el de Cournot bancario, otro modelo).

Autor: Víctor Gutiérrez Marcos
