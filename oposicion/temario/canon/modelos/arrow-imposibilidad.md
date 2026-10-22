# Teorema de imposibilidad de Arrow (1951)

- **Área:** equilibrio general y bienestar · **Tema de referencia:** 3.A.24 (Bienestar III: elección colectiva y teorema de Arrow) — lo tiene en el título; **hecho, 22/10/2026** (I.2 `sec:teorema-arrow` con a)-b), I.3 `sec:valoracion-arrow` con la tabla `tab:axiomas-salidas` y anexo B `anexo:demostracion-arrow` con la demostración en 4 pasos).
- **Temas que lo usan:** 3.A.24 (desarrollo; hecho, 22/10/2026), 4.B.2 (resumen aplicado a la votación: enunciado, axiomas y consecuencias para las reglas de votación, sin la demostración; hoy lo desarrolla casi igual que el 3.A.24 original), 3.A.22 (mención; hecho, 21/10/2026), 3.A.23 (mención; hecho, 21/10/2026: reglas de votación con `\vertema{3.A.24}`).
- **Manuales de referencia:** Arrow (1951, 2.ª ed. 1963), *Social Choice and Individual Values*; Sen (1970), *Collective Choice and Social Welfare*; Mas-Colell, Whinston y Green, cap. 21; Mueller, *Public Choice III*; Geanakoplos (2005), «Three Brief Proofs of Arrow's Impossibility Theorem»; Morreau (2025), *SEP*, «Arrow's Theorem».
- **Decisión D121 (13/10/2026):** ¿Cómo se reparten la paradoja de Condorcet y el teorema de Arrow entre 3.A.24 y 4.B.2? Arrow en desarrollo en 3.A.24 y en resumen aplicado a la votación en 4.B.2 (la parte de Condorcet la sustituye D135: referencia doble).

## Presentación de referencia (3.A.24, I.2)

**Pregunta:** ¿existe un procedimiento razonable para pasar de las ordenaciones de los individuos a una ordenación de la sociedad?

**Idea:** Arrow no propone una función de bienestar con unos juicios de valor, sino que pide condiciones a *cualquier* regla. Solo ordenaciones (ni intensidades ni comparaciones interpersonales, como pedía Robbins) y método axiomático (como Debreu con el consumidor). Antecedentes: Borda (1781) y Condorcet (1785). **Hilo del 3.A.24:** una comunidad de 3 vecinos decide cuánto gastar en reformar el portal: poco ($x$), algo ($y$) o mucho ($z$); cada axioma se ilustra con ella.

**Supuestos:** número finito de individuos $i=1,\dots,I$; al menos 3 alternativas (estados sociales) $x$, $y$, $z$… (**[decidir]** D2 del 3.A.24: $x$, $y$, $z$ frente a $A$, $B$, $C$; aplicada $x$, $y$, $z$, pendiente de Víctor); cada individuo, una **ordenación** $R_i$ con su relación $\succsim_i$ completa, reflexiva y transitiva (\vertema{3.A.8}), $\succ_i$ estricta y $\sim_i$ indiferencia; un **perfil** es la lista de las $I$ ordenaciones. La **regla de agregación** asigna a cada perfil una ordenación social $R_G$ con su relación $\succsim_G$:
$$R_G=f(R_1,R_2,\dots,R_I)\qquad(\text{\texttt{funcionclave} \texttt{eq:regla-arrow}})$$
Nombre: «regla de agregación» (Arrow la llama *social welfare function*; se dice una vez en nota), para no confundirla con la FBS de Bergson-Samuelson (una función de las utilidades) ni con la «función de elección social» de Gibbard-Satterthwaite (elige una sola alternativa).

**Axiomas, en este orden y con estas siglas** (D7 del 3.A.24; **[decidir]** N2 del 3.A.24: T de transitividad, como esta ficha, frente a R de racionalidad, como MWG e Inman; aplicada T, pendiente de Víctor):
- **(U) Dominio universal:** la regla está definida para cualquier perfil.
- **(T) Transitividad:** $R_G$ es completa y transitiva, $x\succsim_Gy$ y $y\succsim_Gz\Rightarrow x\succsim_Gz$. (En la 2.ª edición, 1963, la transitividad va en la propia definición de $f$ y el teorema queda con 4 condiciones; nota sobre Blau, 1957.)
- **(P) Pareto débil:** $x\succ_iy\ \forall i\Rightarrow x\succ_Gy$ (Pareto fuerte, en nota: que el teorema valga con la débil lo hace más fuerte).
- **(I) Independencia de las alternativas irrelevantes (IAI):** la ordenación **social** de $x$ e $y$ depende solo de cómo ordena cada individuo $x$ e $y$: para 2 perfiles $\{R_i\}$, $\{R'_i\}$, $(x\succsim_iy\iff x\succsim'_iy)\ \forall i\Rightarrow(x\succsim_Gy\iff x\succsim'_Gy)$. Prohíbe usar información sobre otras alternativas (la distancia entre $x$ e $y$ en cada ordenación). En nota: no es la independencia de vNM (\vertema{3.A.10}) ni la de la negociación de Nash (\vertema{3.A.14}). En las fórmulas y el cuadro, «(I)» en redonda (`\textup{I}`, para no confundirla con el número de individuos $I$); en el texto, «IAI».
- **(D) No dictadura:** no hay ningún $d$ tal que, para todo perfil y todo par, $x\succ_dy\Rightarrow x\succ_Gy$ (con preferencia **estricta**).

**Teorema:** con al menos 3 alternativas y un número finito de individuos, ninguna regla de agregación cumple a la vez U, T, P, I y D; dicho al revés, toda regla que cumple U, T, P e I es una dictadura.

**Idea de la prueba en el cuerpo** (Geanakoplos, 2005), 3 pasos: 1) *extremos* (si todos ponen $y$ en un extremo, la sociedad también); 2) *votante pivote* (se sube $y$ del último al primer puesto individuo a individuo: en algún momento salta de golpe en la ordenación social); 3) *el pivote es un dictador* (con la IAI). Refrán del 3.A.24: «Donde hay patrón no manda marinero». **Demostración completa** en el anexo B del 3.A.24 (4 pasos con `\findemo` y tabla de perfiles).

**Implicaciones:** toda regla razonable incumple alguna condición (mayoría por parejas: T, Condorcet; Borda: I; unanimidad: no ordena todos los pares; dictadura: D); la causa es la **pérdida de información** (ordenaciones no comparables; la IAI impide sacar información de otras alternativas). El teorema no dice que votar sea malo ni defiende la dictadura: obliga a decir qué defecto se acepta. Es una **aportación constructiva**.

**Salidas** (tabla `tab:axiomas-salidas` del 3.A.24, que es el mapa de la pizarra; 7 filas):

| Axioma | Si se renuncia a él | Ficha |
|---|---|---|
| (U) | Preferencias unimodales: votante mediano (Black, 1948) | `votante-mediano` |
| (T) | Cuasitransitividad: oligarquía con veto (Sen, 1969; Gibbard, 1969/2014; Mas-Colell y Sonnenschein, 1972); con solo aciclicidad sigue habiendo veto (Brown, 1975) | — |
| (P) | Regla nula, dictatorial o dictatorial inversa (Wilson, 1972); Pareto choca con la libertad (Sen, 1970) | `sen-liberal` |
| (I) | La intensidad cuenta: Borda, intercambio de votos; reglas manipulables | `borda`, `logrolling` |
| (D) | La dictadura cumple todo lo demás | — |
| Base informativa | FBS con comparaciones interpersonales (Bergson, Samuelson, Sen, d'Aspremont y Gevers) | `funcion-bienestar-social` |
| Preferencias conocidas | Con información privada, toda regla razonable es manipulable (Gibbard-Satterthwaite) | `gibbard-satterthwaite` |

Además, con un solo perfil (Kemp y Ng, 1976; Parks, 1976) la imposibilidad se mantiene (tabla `tab:arrow-bergson`, II.1 del 3.A.24). La mayoría simple como regla de referencia, con 2 alternativas: teorema de May (ficha `may`). Los 2 caminos del 3.A.24: **rechazar** la metodología (FBS, bloque II) o **aceptarla** y levantar un axioma (bloque III).

**Gráfico de referencia:** no tiene; lo sustituye la tabla `tab:axiomas-salidas` (versión de pizarra: la columna U, T, P, I, D a la izquierda durante todo el cante, con la salida en una palabra junto a cada axioma).

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.24 | Elección colectiva | desarrollo (hecho, 22/10/2026) | Hilo de los vecinos; supuestos, $R_G=f(R_1,\dots,R_I)$, los 5 axiomas en el orden U, T, P, I, D; teorema e idea de la prueba con el pivote; implicaciones; tabla de salidas; demostración en el anexo B | — |
| 4.B.2 | Reglas de votación | resumen (propuesto) | Enunciado con las mismas siglas y la misma tabla de salidas; la mayoría con Condorcet como caso; consecuencias para la democracia representativa; `\vertema{3.A.24}` | La exposición axiomática completa y la prueba |
| 3.A.22 | Extensiones (conclusión) | mención (hecho, 21/10/2026) | Elegir entre los óptimos exige agregar preferencias: Arrow (1951), `\vertema{3.A.24}` | El teorema |
| 3.A.23 | Fallos del sector público | mención (hecho, 21/10/2026) | Las reglas de votación tienen sus propios fallos, `\vertema{3.A.24}` | El teorema |

## Divergencias encontradas en el temario actual
- Resueltas en el 3.A.24 revisado (22/10/2026): $\succeq_G$, $\alpha_i^n$ y $\mathrm{R}_{\mathrm{G}}$ en redonda → $R_i$, $R_G$, $\succsim$ en cursiva; IAI definida sobre las preferencias individuales → sobre la ordenación **social**; «excluye la cardinalidad» → prohíbe usar información de otras alternativas; dictador con preferencia débil → estricta; «irrelevancia de las alternativas relevantes» → independencia de las alternativas irrelevantes; orden U, T, IAI, P, D → U, T, P, I, D; 12 capturas en el anexo → demostración propia.
- 4.B.2 (sin revisar): repite casi palabra por palabra el bloque de Arrow y Condorcet del 3.A.24 original; al revisarlo, resumen con las siglas y la tabla de esta ficha y `\vertema{3.A.24}` (su promesa de la demostración en los anexos del 3.A.24 se cumple: anexo B).
- Letras: el 4.B.2 escribe las alternativas $A$, $B$, $C$; canon $x$, $y$, $z$ si Víctor aprueba la D2 del 3.A.24 (pendiente).
