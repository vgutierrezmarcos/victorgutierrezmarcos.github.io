# Pánicos bancarios (Diamond y Dybvig, 1983)

- **Área:** finanzas-empresa · **Tema de referencia:** **3.B.26** (crisis y pánicos bancarios; sin fuente), escrito con la presentación de 4.A.20; 3.B.27 y 4.A.20 en resumen (4.A.20 con lo imprescindible para cantarse sin el 3.B.26). Mientras 3.B.26 no se escriba, el desarrollo de trabajo está en 3.B.27.
- **Temas que lo usan:** 3.B.26 (previsto, sin fuente), 3.B.27 (desarrollo → resumen), 4.A.20 (desarrollo → resumen aplicado), 3.B.17 (resumen → mención), 3.A.10 (mención; hecho, 19/10/2026: anexo C **resumido**, decisión de Víctor A10-01)
- **Manuales de referencia:** Diamond y Dybvig (1983, *JPE*); Freixas y Rochet, *Microeconomics of Banking*, cap. 7; Allen y Gale, *Understanding Financial Crises* (2007), cap. 3; Mishkin, *Economics of Money, Banking and Financial Markets*.
- **Decisión D017 (13/10/2026):** ¿Qué letra llevan las probabilidades en micro (estados de la naturaleza, accidente, éxito con esfuerzo, impacientes en Diamond-Dybvig)? π (π_s, π, π(e)), como Varian y MWG cap. 19; p queda para los precios
- **Decisión D042 (13/10/2026):** ¿Cuál es el tema de referencia de Diamond-Dybvig? 3.B.26 (crisis y pánicos bancarios), escribiéndolo con la presentación de 4.A.20; 3.B.27 y 4.A.20 en resumen
- **Decisión D064 (13/10/2026):** ¿Qué notación se usa en Diamond-Dybvig? La de Freixas-Rochet: π fracción de impacientes, R rendimiento a largo, L valor de liquidación, c_1 y c_2 consumos

## Presentación de referencia
**Pregunta:** ¿por qué los bancos, que mejoran el reparto del riesgo de liquidez, son vulnerables a pánicos?

**Supuestos:** tres periodos ($T = 0, 1, 2$); continuo de agentes idénticos ex ante con dotación 1; con probabilidad $\pi$ son impacientes (consumen en $T=1$) y con $1-\pi$ pacientes; tecnología: el activo ilíquido rinde $R > 1$ en $T=2$ y $L \le 1$ si se liquida en $T=1$; utilidad cóncava (aversión relativa al riesgo $> 1$).

**Ecuaciones (notación canónica):**
$$\max\; \pi\,u(c_1) + (1-\pi)\,u(c_2) \quad \text{s.a.}\quad \pi c_1 + \frac{(1-\pi)\,c_2}{R} = 1 \;\Rightarrow\; u'(c_1) = R\,u'(c_2),\quad 1 < c_1^* < c_2^* < R$$
El depósito ofrece $(c_1^*, c_2^*)$; si los pacientes esperan que los demás retiren, retirar es óptimo: dos equilibrios (bueno y pánico). Ordenación: $U^{pánico} < U^{autarquía} < U^{mercado} < U^{óptimo} = U^{banco,\,eq.\,bueno}$.

**Resultado:** la transformación de plazos crea equilibrios múltiples; el seguro de depósitos, la suspensión de convertibilidad o el prestamista de última instancia eliminan el equilibrio malo.

**Gráfico de referencia:** plano $(c_1, c_2)$: restricción de autarquía entre $(1, R)$ y $(L, R)$, punto de mercado $(1, R)$, tangencia del planificador y contrato bancario. Primer `.tex` con la notación canónica: `oposicion/temario/fuentes/3A10/graficos/diamond-dybvig.tex` (autarquía, mercado y óptimo; el 3.B.26 puede partir de él y añadir el pánico).

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.B.26 | Crisis y pánicos bancarios | desarrollo (si se elige) | Modelo completo, equilibrios múltiples, extensiones (Goldstein-Pauzner, Allen-Gale) | — |
| 3.B.27 | Regulación financiera | resumen | Justificación del seguro de depósitos y del prestamista de última instancia; riesgo moral resultante | El modelo completo y sus cuatro gráficos (si la referencia es 3.B.26) |
| 4.A.20 | Sistema financiero español | resumen aplicado | Inestabilidad bancaria como argumento para diversificar hacia financiación no bancaria | Derivación |
| 3.B.17 | Crisis de BP | mención | Crisis gemelas: pánico bancario + ataque (Chang-Velasco) | — |
| 3.A.10 | Elección con riesgo | mención (hecho, 19/10/2026: anexo C resumido, 1-2 páginas, «no se canta») | «Aplicación: el seguro de liquidez y los pánicos bancarios»: supuestos de Freixas-Rochet (π, R, L, c_1, c_2), autarquía y mercado (1, R), óptimo u'(c_1*) = R u'(c_2*) con 1 < c_1* < c_2* < R como reparto del riesgo de ser impaciente (la misma lógica que el seguro), contrato bancario y 2 equilibrios; garantía de depósitos (100.000 €, 0,8 %, Directiva (UE) 2026/804), Grecia 2015 y SVB 2023 en una línea; Nobel de 2022; gráfico `oposicion/temario/fuentes/3A10/graficos/diamond-dybvig.tex` (autarquía, mercado y óptimo); remite a 3.B.26 y 3.B.27 | La regulación (FGD, resolución, *bail-in*), Goldstein-Pauzner, los 4 gráficos del original |

## Divergencias encontradas en el temario actual
- **Referencia rota**: el mapa asigna 3.B.26 (sin fuente) mientras el único desarrollo completo está en 3.B.27 y otro en 4.A.20.
- **Notación**: fracción de impacientes $\tau$ en 4.A.20 (choca con $\tau$ coste iceberg y tipos impositivos); rendimientos del activo ilíquido $r_1 < 1 < r_2$ y del depósito $r_1^d, r_2^d$ en 4.A.20; consumo $c$ en 3.A.10 y $c_1, c_2$ en 4.A.20. Canon: $\pi$ (fracción de impacientes), $R$ (rendimiento a largo), $L$ (valor de liquidación), $c_1$, $c_2$ (Freixas-Rochet; Allen-Gale).
- 3.A.10 original: anexo de ≈ 3.000 palabras y 4 gráficos (más largo que el de 3.B.27), con τ, r_1, r_2, «3 tipos de agentes», FGD «vía presupuestos (caso alemán)», Grecia con 50.000 M€ y remisión a 3.B.17. **Resuelto** (19/10/2026): resumido con la notación del canon, FGD financiados por las entidades (objetivo del 0,8 %), unos 40.000 M€ en el 1S 2015 y remisiones a 3.B.26 y 3.B.27.
- 3.B.27 tiene la errata «modelo de Corunot» en un título de gráfico (es el de Cournot bancario, otro modelo).

Autor: Víctor Gutiérrez Marcos
