# Función de bienestar social de Bergson (1938)-Samuelson (1947)

- **Área:** equilibrio general y bienestar · **Tema de referencia:** 3.A.24 (Funciones de bienestar social) — lo tiene en el título; **hecho, 22/10/2026** (bloque II: II.1 `sec:rechazo-metodologia`, II.2 `sec:fbs-neoutilitarista` con a)-c), II.3 `sec:valores-eticos` con utilitarismo, Rawls y la familia isoelástica, II.4 `sec:criterios-equitativos` y anexo C `anexo:bases-informativas`).
- **Temas que lo usan:** 3.A.24 (desarrollo; hecho, 22/10/2026), 3.A.22 (mención: punto de felicidad; hecho, 21/10/2026, gráfico `oposicion/temario/fuentes/3A22/graficos/fbs-gfpu.tex`), 4.B.2 (resumen), 4.B.3 y 4.B.11 (la usan para la redistribución y la disyuntiva entre equidad y eficiencia en la imposición óptima). **Recoge el id `fbs-utilitarista`** (alias; la utilitarista es una de sus formas, II.3 del 3.A.24).
- **Manuales de referencia:** Bergson (1938, 1954); Samuelson (1947, 1956, 1977); Little (1952); Sen (1970, 1977); d'Aspremont y Gevers (1977, 2002); Harsanyi (1953, 1955); Mas-Colell, Whinston y Green, cap. 22; Boadway y Bruce, *Welfare Economics*; Gaertner (2006), *A Primer in Social Choice Theory*, cap. 7.

## Presentación de referencia (3.A.24, II.2)

**Pregunta:** ¿cómo elegir entre los óptimos de Pareto de la GFPU?

**Idea:** Bergson (1938) la propone y Samuelson (1947) la completa: el bienestar de la sociedad es una función de las utilidades de sus miembros, que resume los juicios de valor:
$$W=W(U_1,U_2,\dots,U_I),\qquad U_i=U_i(\vect{x}_i),\qquad \frac{\partial W}{\partial U_i}>0\ \ \forall i\qquad(\text{\texttt{funcionclave} \texttt{eq:fbs}})$$
$W$ siempre con argumentos (D057). $\partial W/\partial U_i$ es la **utilidad marginal social** de $i$. Como la regla de Arrow, tiene *inputs* (utilidades) y *output* (un índice que ordena todos los estados). En nota: escrita sobre las cestas, $W(U_1(\vect x_1),\dots,U_I(\vect x_I))$; Samuelson (1956) da sentido normativo al consumidor representativo (\vertema{3.A.8}); no confundir las CIS con las curvas de indiferencia comunitarias de Scitovsky (1942).

**Antes, II.1 (rechazo de la metodología de Arrow):** Little (1952) y Bergson (1954): la FBS es un juicio, no un procedimiento (fase deliberativa frente a decisiva); Samuelson (1977): un solo perfil; Kemp y Ng (1976) y Parks (1976): con un solo perfil y neutralidad vuelve la imposibilidad. Tabla `tab:arrow-bergson` (objetivo común, información, juicios de valor, dominio, para quién).

**Supuestos (propiedades habituales de $W$):** individualismo o bienestarismo (no paternalismo); coherencia con Pareto (monotonía); anonimato (simetría); cuasiconcavidad (aversión a la desigualdad: CIS convexas, que **es un juicio de valor**, no una propiedad de toda FBS: la utilitarista tiene rectas); **comparabilidad** interpersonal (qué se compara depende de la forma de $W$). Las 2 primeras son las de Samuelson; las otras ya son juicios sobre el reparto. Refrán del 3.A.24: «Cada cabeza es un mundo».

**Mensurabilidad y comparabilidad no son lo mismo:** la FBS no exige utilidades cardinales, sino comparables. Ordinal (cualquier transformación creciente) o cardinal ($a_i+b_iU_i$, $b_i>0$); comparable o no (niveles, unidades o ambas). Cada combinación es una **base informativa** (Sen, 1970) — tabla `tab:bases-informativas` del 3.A.24 y anexo C:

| Base informativa | Transformaciones admitidas | Regla resultante |
|---|---|---|
| Ordinal no comparable | $\phi_i(U_i)$ creciente, distinta para cada $i$ | imposibilidad: dictadura (Arrow) |
| Cardinal no comparable | $a_i+b_iU_i$, $b_i>0$ distintos | sigue la imposibilidad (Sen) |
| Ordinal con comparabilidad de niveles | $\phi(U_i)$ común | *maximin* y *leximin* (Hammond, 1976; d'Aspremont y Gevers, 1977) |
| Cardinal con comparabilidad de unidades | $a_i+bU_i$, $b>0$ común | utilitarismo, $W=\sum_iU_i$ |
| Escala de razón con comparabilidad plena | $bU_i$, $b>0$ común | familia isoelástica |

**Desarrollo:** con 2 individuos $A$ y $B$, las **curvas de indiferencia social** (CIS) en $(U_A,U_B)$: decrecientes, no se cortan, más bienestar cuanto más lejos del origen. Su pendiente en valor absoluto es la relación marginal de sustitución social, que el 3.A.24 escribe **sin sigla** (CC6 del 3.A.24: no se añade RMSS):
$$-\left.\frac{dU_B}{dU_A}\right|_{W=\overline W}=\frac{\partial W/\partial U_A}{\partial W/\partial U_B}.$$
**Problema del planificador** (`eq:planificador-fbs`):
$$\optim{\max}{U_A,U_B}{W(U_A,U_B)}{(U_A,U_B)\in\mathrm{GFPU}}$$
La solución cumple las condiciones de Pareto (`eq:condiciones-pareto`) y la tangencia CIS-GFPU; es el **punto de felicidad** (*bliss point*, *optimum optimorum*): el máximo **global** de $W$ en la GFPU (la GFPU puede tener tramos convexos). En nota, el planificador general sobre los bienes (\vertema{3.A.22}).

**Implicaciones:** Pareto es necesario pero no suficiente (un punto ineficiente puede ser mejor que uno eficiente); solución tecnocrática, sin precios; el 1TFEB solo coincide con el punto de felicidad por casualidad y el 2TFEB lo alcanza con transferencias de suma fija, que no existen: **disyuntiva entre equidad y eficiencia** (lógica de la imposición óptima, \vertema{4.B.11}).

**Formas funcionales (II.3 del 3.A.24):**
- **utilitarista** (Bentham; Harsanyi, 1953, 1955, con el teorema de agregación): $W=\sum_iU_i$, CIS rectas de pendiente $-1$; Harsanyi es neutral respecto a la **utilidad**, no a la renta (\vertema{3.A.10}); con la misma $U$ cóncava, rentas iguales (Edgeworth, 1897); conclusión repugnante de Parfit (1984);
- **rawlsiana**: $W=\min\{U_1,\dots,U_I\}$, en L (ficha `fbs-rawlsiana`);
- **isoelástica** (`\funcionclave` `eq:isoelastica`), con el mismo $\epsilon\ge0$ de aversión a la desigualdad que el índice de Atkinson (D081):
$$W=\sum_{i=1}^{I}\frac{U_i^{1-\epsilon}}{1-\epsilon}\quad(\epsilon\neq1),\qquad W=\sum_{i=1}^{I}\ln U_i\quad(\epsilon=1)$$
pendiente de las CIS $dU_B/dU_A=-(U_B/U_A)^{\epsilon}$; $\epsilon=0$ utilitarista, $\epsilon=1$ Bernoulli-Nash (producto), $\epsilon\to\infty$ rawlsiana. «Discutir sobre la justicia distributiva es discutir el valor de $\epsilon$». Supuestos: utilidades positivas y comparables en escala de razón, anonimato.

**Después (II.4):** Atkinson (ficha `atkinson-indice`), Lorenz y Gini (`curva-lorenz`), ultimátum y dictador (`nash-negociacion`, con el 40 %/16 % de Oosterbeek *et al.*, 2004, y el 28 % de Engel, 2011) y la crítica de Sen (bienestarismo, capacidades, *welfare* frente a *well-being*, IDH). Foley (1967) en nota (\vertema{3.A.21}, \vertema{3.A.22}).

**Valoración:** resuelve la incompletitud y es el instrumento de la economía pública (imposición óptima, redistribución, evaluación); exige comparaciones interpersonales y su forma es un juicio de valor; ¿de quién son los juicios? Si son de la sociedad, vuelve Arrow.

**Gráficos de referencia:**
- `oposicion/temario/fuentes/3A22/graficos/fbs-gfpu.tex` (3.A.22): GFPU y CIS de $W=(U_AU_B)^{1/2}$, punto de felicidad $c=(5{,}39;\,4{,}89)$ en $W_3$, $d=(7{,}60;\,1{,}62)$ en $W_1$, $a$ y $b$ en $W_2$.
- **Variante del 3.A.24:** `oposicion/temario/fuentes/3A24/graficos/fbs-gfpu-tradeoff.tex` (mismas coordenadas, más la bisectriz, $e\approx(3{,}45;\,3{,}45)$ por debajo de $W_1$ y la trayectoria $d\to b\to e$ de la redistribución con impuestos distorsionantes). En el cante se dibuja por partes sobre la GFPU de I.1 (`gfpu`): CIS y $c$; $d$, $a$, $b$; bisectriz, $e$ y flechas.
- Formas de las CIS: `oposicion/temario/fuentes/3A24/graficos/cis-formas.tex` (3 paneles: rectas $\epsilon=0$, hipérbolas $\epsilon=1$, L $\epsilon\to\infty$; ficha `fbs-rawlsiana`).

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.24 | FBS | desarrollo (hecho, 22/10/2026) | II.1 rechazo de Arrow (Little, Bergson, Samuelson, Kemp-Ng, Parks; `tab:arrow-bergson`); II.2 propiedades, bases informativas, CIS, planificador con `\optim`, punto de felicidad, disyuntiva con `fbs-gfpu-tradeoff`; II.3 utilitarista, rawlsiana e isoelástica con `cis-formas`; II.4 Atkinson, experimentos y Sen | — |
| 3.A.22 | Incompletitud de Pareto | mención (hecho, 21/10/2026) | FBS en 4 viñetas con el gráfico de apoyo `fbs-gfpu`; $W(U_A,U_B)$ siempre con argumentos; Sen y Rawls en la crítica distributiva; `\vertema{3.A.24}` | Formas funcionales |
| 4.B.2 | Decisión pública | resumen | Criterio para elegir entre óptimos; utilitarista y rawlsiana con `\vertema{3.A.24}` | Bases informativas, planificador |
| 4.B.3 | Redistribución | resumen | Utilitarista, rawlsiana e isoelástica con la misma $\epsilon$ que Atkinson; `\vertema{3.A.24}` | El planificador |
| 4.B.11 | Imposición óptima | mención | La FBS como objetivo del planificador (Mirrlees); disyuntiva equidad-eficiencia | Las formas |

## Divergencias encontradas en el temario actual
- Resueltas en el 3.A.24 revisado (22/10/2026): mezcla de cardinalidad y comparabilidad interpersonal (nota 43) → recuadro «Mensurabilidad y comparabilidad» y tabla de bases informativas; problema del planificador vacío → `eq:planificador-fbs` con `\optim`; CIS «convexas» como propiedad general → juicio de valor; FBS «de Bergson-Scitovsky» en el espacio de bienes → Samuelson (1956) frente a Scitovsky (1942); Harsanyi «neutral al riesgo» → neutral respecto a la utilidad; $|\mathrm{RMS}_{\mathrm{Social}}|$ con barras → la pendiente sin sigla.
- Individuos: $A,B$ en el 2×2×2×2 y en los gráficos, $i=1,\dots,I$ en general (como MWG); el 4.B.2 escribe $1,\dots,N$: canon $I$.
- $W$ choca con $\overline W$ (renta): se mantiene $W(\cdot)$ para la FBS, siempre con argumentos o explícitamente «FBS», y $\overline W$ con barra para la renta (también $W=\overline W$ para una CIS de nivel dado).
