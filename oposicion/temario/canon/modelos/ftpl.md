# Teoría fiscal del nivel de precios y regímenes de Leeper (Leeper 1991; Sims 1994; Woodford 1995; Cochrane 2023)

- **Área:** macro cerrada · **Tema de referencia:** 3.A.39 (Dominación monetaria y dominación fiscal) — es la versión moderna de la dominación fiscal. **Hecho (revisado el 4/11/2026):** III.3.1 (regímenes de Leeper, `tab:regimenes-leeper`) y III.3.3 (FTPL con a)-e) y `eq:valoracion`). Esta ficha recoge también los **regímenes de Leeper (1991)**, que son su marco y el de la aritmética monetarista (ficha `aritmetica-monetarista`).
- **Temas que lo usan:** 3.A.39 (desarrollo; hecho, 4/11/2026), 3.A.41 (resumen: determinación del nivel de precios y deflación; hoy desarrollo con críticas en su Word, l. 1000-1060, sin revisar). También 3.A.6 (mención; hecho, 4/11/2026: II.5 c), la teoría fiscal del nivel de precios lleva más lejos la aritmética monetarista, Leeper, 1991; `\vertema{3.A.39}`), 3.A.36 (mención; en revisión: la dominación fiscal en las extensiones, `\vertema{3.A.39}`), 3.A.7 (mención; hecho: el principio de Taylor, que es la política monetaria activa de Leeper). También 3.A.40 (mención; hecho, 5/11/2026: III.1, quién cierra la restricción, la dominación fiscal y la FTPL en una viñeta con `\vertema{3.A.39}`; III.2, con dominación fiscal el multiplicador es mayor, Leeper, Traum y Walker, 2017, sin cifra; III.3 e), la FTPL exige una política fiscal activa, Bianchi, Faccini y Melosi, 2023).
- **Manuales de referencia:** Leeper (1991), *JME*; Sims (1994), *Economic Theory*; Woodford (1995), *Carnegie-Rochester*; Cochrane (2023), *The Fiscal Theory of the Price Level*; Buiter (2002), *EJ*; Walsh (2017), cap. 4.

## Presentación de referencia

**Pregunta:** ¿qué determina el nivel de precios si la política fiscal no garantiza la solvencia para cualquier nivel de precios?

**Regímenes de Leeper (1991)** (3.A.39, III.3.1): una política es **activa** si persigue su objetivo sin atender a la otra y **pasiva** si se ajusta para que se cumpla la restricción. Monetaria: regla de Taylor $i_t=\rho+\phi_\pi\pi_t$, activa si $\phi_\pi>1$ (principio de Taylor, `\vertema{3.A.7}`), pasiva si $\phi_\pi<1$. Fiscal: $\tau_t-g_t=\psi_0+\psi\,d_{t-1}$, **pasiva si $\psi>(r-\gamma_Y)/(1+\gamma_Y)$** (la condición de Bohn, ficha `restriccion-gobierno`), activa si no ($\psi_0$, $\psi$ locales, avisadas). **4 casillas:** monetaria activa + fiscal pasiva = **dominación monetaria** (régimen **ricardiano**: el banco central fija la inflación y los superávits estabilizan la deuda); monetaria pasiva + fiscal activa = **dominación fiscal** (**no ricardiano**, Woodford, 1995: aritmética monetarista y FTPL); activa + activa = sin equilibrio estable, la deuda es explosiva (*juego de la gallina*, `\vertema{3.A.14}`); pasiva + pasiva = indeterminación del nivel de precios. La mayoría de los modelos monetarios suponen, sin decirlo, la dominación monetaria. «Ricardiano / no ricardiano» **no se atribuye a Sargent (1982)**.

**Supuestos de la FTPL:** deuda **nominal**; política fiscal activa (superávits que no responden a la deuda) y monetaria pasiva: la casilla de dominación fiscal.

**Ecuación de valoración de la deuda** (`eq:valoracion`, en términos reales y **sobre el PIB**, con la notación de `restriccion-gobierno`; $D_{t-1}$ e $i_{t-1}$ dados):

$$\frac{(1+i_{t-1})\,D_{t-1}}{P_t\,Y_t}=\sum_{k=0}^{\infty}\left(\frac{1+\gamma_Y}{1+r}\right)^{k}\left(\tau_{t+k}-g_{t+k}+s_{t+k}\right)$$

Es `eq:solvencia` multiplicada por $(1+r)/(1+\gamma_Y)$, con $P_t$ a la vista (en el 3.A.39 se escribe **junto a** `eq:solvencia`: tercera lectura de la solvencia). En un régimen ricardiano la política fiscal ajusta los superávits para que se cumpla con cualquier $P_t$; en uno no ricardiano los superávits están dados y **$P_t$ se ajusta**: la ecuación deja de ser una restricción del Gobierno y pasa a ser una condición de equilibrio que fija el nivel de precios. **Mecanismo:** efecto riqueza (con precios más bajos, la deuda vale más que los impuestos con que se pagará; los hogares gastan y los precios suben), justo el que la equivalencia ricardiana anulaba. (La ficha escribía antes $\sum(T_{t+k}-G_{t+k}+S_{t+k})/\prod(1+r_{t+j})$ «en términos reales», con $T$ y $G$ nominales y $S$ real: corregido, C3 de la coherencia del 3.A.39.)

**Implicaciones:** la inflación puede ser fiscal aunque el dinero no crezca; el principio de Taylor no basta con política fiscal activa; con deuda a largo plazo, parte del ajuste lo hace el precio de los bonos y la inflación se reparte en el tiempo (Cochrane, 2023). **Extensiones:** la inflación de EE. UU. de 2021-2022 (transferencias sin superávits futuros esperados, Cochrane, 2023); en una deflación con tipos en cero, una expansión fiscal que no se va a pagar puede subir los precios (`\vertema{3.A.41}`). **Evidencia:** difícil de contrastar (los 2 regímenes cumplen la ecuación; cambia qué variable se ajusta). **Valoración:** crítica de **Buiter (2002)**: trata como condición de equilibrio lo que es una restricción presupuestaria; refuerza la conclusión de la aritmética: la estabilidad de precios exige una política fiscal pasiva.

**Gráfico de referencia:** la **matriz 2×2 de Leeper** (`tab:regimenes-leeper` del 3.A.39, tabla con colores: verde la dominación monetaria, salmón la fiscal, rojo «sin equilibrio estable», dorado «indeterminación»; filas monetaria activa/pasiva, columnas fiscal pasiva/activa; fuente Leeper, 1991; Woodford, 1995; Walsh, 2017, cap. 4). En la pizarra se dibuja rellenando primero las 2 diagonales de dominación.

## Cómo se adapta en cada tema

| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.39 | Dominación fiscal | Desarrollo (hecho, 4/11/2026) | Matriz de Leeper con las 4 casillas y las 2 reglas; FTPL a)-e) con `eq:valoracion`, mecanismo, Cochrane, Buiter | — |
| 3.A.41 | Inflación y deflación | Resumen | La FTPL como teoría alternativa de la inflación; deflación y expansión fiscal (Sims, 2016); `eq:valoracion` en una línea con `\vertema{3.A.39}` | La matriz de regímenes y la crítica de Buiter en detalle |
| 3.A.6 | NMC | Mención (hecho, 4/11/2026) | Una línea tras la aritmética monetarista (Leeper, 1991) | La teoría |
| 3.A.36 | Política monetaria | Mención (en revisión) | La dominación fiscal como límite de la independencia, `\vertema{3.A.39}` | La teoría |

## Divergencias encontradas en el temario actual

- **3.A.39 resuelto** (4/11/2026): la FTPL estaba a medio hacer y en amarillo, con «previsión perfecta ($P^e_{t+1}=P_t$)» y $\mu_t$ sin definir, y la tabla de regímenes de Walsh incompleta; «régimen ricardiano (Sargent, 1982)» → sin atribuir.
- **3.A.41** (sin revisar) copia párrafos del Word del 3.A.39 y desarrolla la FTPL con críticas: al revisarlo, resumen con `\vertema{3.A.39}`.
- Notación de la restricción: la de `restriccion-gobierno` (intereses $i_{t-1}D_{t-1}$, ratios sobre el PIB).

Autor: Víctor Gutiérrez Marcos
