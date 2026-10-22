# Índice de desigualdad de Atkinson (1970)

- **Área:** equilibrio general y bienestar · **Tema de referencia:** doble, uno por ejercicio. **4.B.3** (4.º ejercicio; más propio de él): medición de la desigualdad y del impacto redistributivo con índices (Gini, Theil, Atkinson), fórmula, interpretación y comparación con el Gini. **3.A.24** (3.er ejercicio; **hecho, 22/10/2026**, II.4.1 `sec:atkinson` con a)-d) y `\funcionclave` `eq:atkinson`): renta equivalente igualmente distribuida, fórmula, $\epsilon$ como aversión a la desigualdad (la misma de la FBS isoelástica) y lectura como FBS implícita (de utilitarista a rawlsiana). Cada uno, completo para su examen.
- **Temas que lo usan:** 3.A.24 (desarrollo, 3.er ejercicio; hecho, 22/10/2026), 4.B.3 (desarrollo, 4.º ejercicio; hoy solo mención, sin fórmula ni $\epsilon$), 4.A.3 (mención prevista, con datos).
- **Manuales de referencia:** Atkinson (1970), «On the Measurement of Inequality», *JET*; Lambert (2001), *The Distribution and Redistribution of Income*, cap. 2-4; Cowell (2011), *Measuring Inequality*.
- **Decisión D081 (13/10/2026):** ¿Qué letra lleva la aversión a la desigualdad del índice de Atkinson? ϵ (épsilon lunada, como Atkinson 1970), distinta de ε elasticidad. **Ampliada el 22/10/2026 (3.A.24):** es la misma $\epsilon$ de la FBS isoelástica (`eq:isoelastica`).
- **Decisión D094 (13/10/2026):** ¿Cuál es el tema de referencia del índice de Atkinson? Desarrollo en los dos ejercicios: se desarrolla en 4.B.3 (más propio del 4.º) y también en 3.A.24, lo bastante para que quien estudia el 3.er ejercicio lo entienda.

## Presentación de referencia (3.A.24, II.4.1)

**Idea:** el criterio de Pareto acepta la distribución dada; medir la desigualdad sin juicios de valor no es posible: **todo índice de desigualdad lleva dentro una FBS** (Atkinson, 1970).

**Supuestos:** $I$ individuos ($i=1,\dots,I$, como en todo el bloque; nunca $N$) con rentas $y_1,\dots,y_I$ y media $\overline y$; FBS utilitarista sobre una utilidad de la renta igual para todos, creciente y cóncava; en el índice, isoelástica, con la **misma $\epsilon$** que la familia `eq:isoelastica` (ficha `funcion-bienestar-social`).

**Desarrollo:** primero Lorenz, Gini y la dominancia de Lorenz (ficha `curva-lorenz`): si las curvas se cortan, ordenar exige elegir una FBS, y el índice de Atkinson hace explícita esa elección. La **renta equivalente igualmente distribuida** $y_{EDE}$ es la que, dada a todos por igual, daría el mismo bienestar que la distribución observada:
$$A_\epsilon=1-\frac{y_{EDE}}{\overline y},\qquad y_{EDE}=\left[\frac1I\sum_{i=1}^{I}y_i^{1-\epsilon}\right]^{\frac{1}{1-\epsilon}}\quad(\epsilon\neq1)\qquad(\text{\texttt{funcionclave} \texttt{eq:atkinson}})$$
Con $\epsilon=1$, $y_{EDE}$ es la media geométrica. $\epsilon\ge0$: $\epsilon=0$ sin aversión ($A_0=0$); $\epsilon\to\infty$, rawlsiana ($y_{EDE}=\min_iy_i$).

**Ejemplo común** (3.A.24; en la pizarra, «el ejemplo 10-30»): 2 personas con 10 y 30 euros ($\overline y=20$): $\epsilon=0$, $y_{EDE}=20$, $A_0=0$; $\epsilon=1$, $y_{EDE}=\sqrt{300}\approx17{,}3$, $A_1\approx0{,}13$; $\epsilon=2$, $y_{EDE}=15$, $A_2=0{,}25$; $\epsilon\to\infty$, $y_{EDE}=10$, $A_\infty=0{,}5$.

**Implicaciones:** $A_\epsilon$ es la parte de la renta que la sociedad sacrificaría por repartir el resto por igual; cuanto mayor $\epsilon$, más pesa la cola baja. A diferencia del Gini, es **normativo**: cada $\epsilon$ es una FBS.

**Evidencia** (3.A.24): Gini de la renta disponible equivalente de España, 30,8 (ECV 2025, rentas de 2024; INE) frente a 29,2 de la UE-27 (Eurostat, ilc_di12); serie en `fuentes/3A24/_trabajo/datos/gini-espana-ue.csv`. Desigualdad en España con datos, \vertema{4.A.3}; efecto redistributivo del presupuesto, \vertema{4.B.3}.

**Valoración:** convierte el debate sobre la justicia en un número comparable y deja a la vista el juicio de valor que el Gini esconde; pero depende de $\epsilon$, que no sale de los datos, y se apoya en la utilidad de la renta.

**Gráfico de referencia:** no tiene propio; se apoya en `oposicion/temario/fuentes/3A24/graficos/lorenz.tex` (ficha `curva-lorenz`) y en `cis-formas.tex` (cada $\epsilon$, una forma de las CIS).

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 4.B.3 | Medir la redistribución | desarrollo (referencia del 4.º) | La misma fórmula `eq:atkinson` con $I$, $y_{EDE}$, $A_\epsilon$ y la misma $\epsilon$; interpretación; comparación con Gini y Theil; aplicación al antes y después de impuestos; `\vertema{3.A.24}` para la FBS isoelástica | — |
| 3.A.24 | FBS y desigualdad | desarrollo (referencia del 3.º; hecho, 22/10/2026) | a) Idea; b) Modelo con $y_{EDE}$, `eq:atkinson` y el ejemplo 10-30; c) Gini de España y la UE; d) Valoración | La aplicación al presupuesto |
| 4.A.3 | Distribución de la renta en España | mención (prevista) | Datos del INE y de Eurostat con la misma notación | La fórmula |

## Divergencias encontradas en el temario actual
- Resueltas en el 3.A.24 revisado (22/10/2026): el índice salía sin fórmula ni $\epsilon$; ahora con `eq:atkinson`. La ficha escribía $\frac1N\sum_i$: canon $\frac1I\sum_{i=1}^I$ (§ 5 de `notacion.md`; CC3 del 3.A.24).
- 4.B.3 (sin revisar): Atkinson sin fórmula ni $\epsilon$; al revisarlo, la misma $\epsilon$, $y_{EDE}$, $A_\epsilon$ con $I$ individuos y `\vertema{3.A.24}`.
