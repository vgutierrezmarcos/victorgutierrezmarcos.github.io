# Principio de aceleración: acelerador simple y flexible (Aftalion 1913; Clark 1917; Koyck 1954; Chenery 1952) y multiplicador-acelerador (Samuelson 1939; Hicks 1950)

- **Área:** macro cerrada · **Tema de referencia:** 3.A.34 (teorías de la inversión) — I.2 «Teorías poskeynesianas: el acelerador» (a)-d)), revisado el 31/10/2026. Ficha creada en la fase canon del 3.A.34 (C6 de sus propuestas de coherencia, **[decidir]**). Recoge el id `multiplicador-acelerador` del 3.A.42 (alias; **[decidir]**: alternativa, ficha propia con el 3.A.42 de referencia, porque allí se desarrolla la dinámica del ciclo).
- **Temas que lo usan:** 3.A.34 (desarrollo; hecho, 31/10/2026), 3.A.42 (desarrollo de la aplicación al ciclo: multiplicador-acelerador de Samuelson y Hicks), 3.A.43 (mención: la misma v de Harrod-Domar; hoy remite al 3.A.34 por el acelerador simple), 1D01 (mención; hecho: la brecha de producción y la utilización de la capacidad como determinante de la inversión, «acelerador»)
- **Manuales de referencia:** Clark (1917); Koyck (1954); Chenery (1952); Samuelson (1939); Hicks (1950); Blanchard y Fischer (1989); Dornbusch, Fischer y Startz.

## Presentación de referencia (3.A.34, I.2)

**Pregunta:** ¿a qué ritmo se ajusta el capital, y por qué la inversión es tan volátil?

**a) Idea.** Para pasar de una demanda de capital (Keynes) a una de inversión hace falta un supuesto sobre el ritmo del ajuste: el **principio de aceleración** (Clark, 1917; antecedente en Aftalion, 1913): lo que mueve la inversión es la *variación* de la producción. Funciones *ad hoc*, sin optimización.

**b) Modelo.** Supuestos: precios rígidos; coeficientes fijos (Leontief) con **relación capital-producto v** (D009) y $K^*_t=vY^e_t$; expectativas estáticas.
$$I_t=\Delta K^*_t=v\,\Delta Y_t\qquad(\texttt{eq:acelerador})$$
$v$ (de 2 a 3) > 1: efecto acelerador; la misma $v$ de Harrod-Domar (`\vertema{3.A.43}`). Implicaciones: política monetaria nada eficaz; fiscal eficaz, con multiplicador **de impacto** $\partial Y_t/\partial G_t=1/(1-c-v)$, solo con sentido si $c+v<1$; a largo plazo vuelve a $1/(1-c)$ (error del original: se daba sin más).
**Multiplicador-acelerador** (nota del 3.A.34, desarrollo en el 3.A.42): Samuelson (1939), $C_t=cY_{t-1}$, $I_t=v(C_t-C_{t-1})$ ⇒ $Y_t=c(1+v)Y_{t-1}-cvY_{t-2}+G$; $Y^*=G/(1-c)$, estable si $cv<1$, oscilante si $c(1+v)^2<4v$; Hicks (1950) con techos y suelos.

**c) Acelerador flexible.** Retardos de decisión, financiación, entrega e instalación:
$$I_t=v\sum_{j=0}^{\infty}\beta_j\,\Delta Y_{t-j},\qquad\sum_{j}\beta_j=1$$
(los pesos suman **1**, no 0 como decía el original). Pesos geométricos $\beta_j=\beta_0(1-\beta_0)^j$, $0<\beta_0\le1$ (Koyck, 1954) ⇔ **ajuste parcial** (Chenery, 1952): $K_t-K_{t-1}=\beta_0(K^*_t-K_{t-1})$, con **β₀ velocidad del ajuste** (β con subíndice = coeficientes, § 1; N2 a) del 3.A.34; nunca la *a* de la propuesta de coherencia); multiplicador de impacto $1/(1-c-\beta_0v)$.

**d) Valoración.** Coeficientes fijos, expectativas estáticas, sin tipo de interés, sin capacidad ociosa; asimetría (la inversión bruta no puede ser negativa: funciona peor a la baja); ajusta bien los datos, pero correlación no es causalidad.

**Gráfico de referencia:** `oposicion/temario/fuentes/3A34/graficos/acelerador-flexible.tex` (ajuste parcial del capital y de la inversión ante un aumento permanente de la producción, $v=2$, $\beta_0=0{,}4$; valores ilustrativos). Apoyo, no se dibuja en el cante.

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.34 | Teorías de la inversión | desarrollo (hecho, 31/10/2026) | Simple, multiplicador de impacto, flexible con Koyck y Chenery, valoración | La dinámica del ciclo (nota con `\vertema{3.A.42}`) |
| 3.A.42 | Teorías del ciclo | desarrollo (aplicación) | Multiplicador-acelerador de Samuelson (ecuación en diferencias, estabilidad y oscilación) y Hicks (techos y suelos), con la misma $v$ y `\vertema{3.A.34}` para el principio | El acelerador flexible |
| 3.A.43 | Crecimiento | mención | Harrod-Domar: la inversión que pide el crecimiento, con la misma $v$ | El acelerador flexible |
| 1D01 | Dictamen de coyuntura | mención (hecho) | Brecha de producción y utilización de la capacidad como determinantes de la inversión | El modelo |

## Divergencias encontradas en el temario actual
- 3.A.34 original: Σβ_j = 0; multiplicador $1/(1-c-v)$ sin condiciones; v también como sensibilidad al tipo. **Resuelto** (31/10/2026).
- 3.A.42 (sin revisar): comprobar que el multiplicador-acelerador usa $v$ (no otra letra) y la ecuación de Samuelson de arriba.

Autor: Víctor Gutiérrez Marcos
