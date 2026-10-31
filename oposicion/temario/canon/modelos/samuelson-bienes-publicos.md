# Condición de Samuelson (1954) para la provisión óptima de bienes públicos

- **Área:** equilibrio general y bienestar · **Tema de referencia:** **3.A.23** (Bienestar II: bienes públicos; revisado el 21/10/2026, II.2: definición y clasificación con la tabla `tab:rivalidad-exclusion`, asignación competitiva frente a óptima con a)-e), y provisión pública; anexos `anexo:samuelson` y `anexo:provision-privada`). Recoge el id `bowen` (alias desde el 21/10/2026): la versión de equilibrio parcial de Bowen (1943) es una extensión de esta ficha.
- **Temas que lo usan:** 3.A.23 (desarrollo; hecho, 21/10/2026), 4.B.5 (mención: tamaño del sector público), 3.A.24 (mención; hecho, 22/10/2026: el votante mediano en general no cumple la condición; condición de Bowen $G^m=G^*\iff\mathrm{RMS}^m_{GX}(G^*)=\frac1I\sum_i\mathrm{RMS}^i_{GX}(G^*)$, con `\vertema{3.A.23}`), 4.B.7 (principio del beneficio) y 4.B.2 (Bowen) la presuponen; 3.A.14 (mención; hecho, 19/10/2026: el polizón como dilema del prisionero, `\vertema{3.A.23}`), 3.B.31 (mención; hecho, 31/10/2026: reducir emisiones es un bien público global; el daño marginal mundial es la suma vertical de los de los países, $\mathrm{DMg}(E)=\sum_i\mathrm{DMg}_i(E)$, con $E^c>E^{\mathrm N}>E^*$ y el polizón entre Estados; Hirshleifer, 1983, y Kindleberger, 1986).
- **Manuales de referencia:** Samuelson (1954), *REStat*, y (1955), *REStat* (diagrama); Bowen (1943), *QJE*; Bergstrom, Blume y Varian (1986), *JPubE*; Warr (1983); Andreoni (1990); Mas-Colell, Whinston y Green, cap. 11.C; Atkinson y Stiglitz, *Lectures on Public Economics*, lección 16; Ostrom y Ostrom (1977) para la clasificación.

## Presentación de referencia
**Clasificación** (Ostrom y Ostrom, 1977): rivalidad × exclusión → bienes privados, de club (Buchanan, 1965), recursos comunes (ficha `tragedia-comunes`) y públicos puros; no confundir con los bienes preferentes de Musgrave.

**Supuestos:** 2 consumidores $A$, $B$; un bien privado $X$ y un bien público puro $G$ (no rival, no excluible: $G_A=G_B=G$); FPP $T(X,G)=0$ con $X=X_A+X_B$ (sin $\overline X$).

**Óptimo de Pareto (problema del planificador, no del mercado):**
$$\max\ U_A(X_A,G)\quad\text{s.a.}\quad U_B(X_B,G)=\overline U_B,\quad T(X_A+X_B,G)=0$$
$$\Rightarrow\ \mathrm{RMS}^A_{GX}+\mathrm{RMS}^B_{GX}=\mathrm{RMT}_{GX}$$
(`\funcionclave` `eq:samuelson`.)
Con un bien privado se igualan las valoraciones; con uno público, se **suman**. Bien público primero en los subíndices, en unidades de bien privado; RMS positivas, sin barras, consumidor arriba.

**Equilibrio con aportaciones voluntarias:** cada uno iguala su propia $\mathrm{RMS}^i_{GX}=\mathrm{RMT}_{GX}$, y $\sum_i\mathrm{RMS}^i_{GX}=2\,\mathrm{RMT}_{GX}>\mathrm{RMT}_{GX}$ (`eq:samuelson-mercado`): **infraprovisión** y **polizón**, como dilema del prisionero (tabla `tab:polizon`: mota que cuesta 120 y cada vecino valora en 100). Refrán del tema: «Unos por otros, la casa sin barrer».

**Extensiones:**
- **Bowen (1943), equilibrio parcial** (la versión de la pizarra): con utilidad cuasilineal, $\mathrm{RMS}^i_{GX}(G)$ es la disposición marginal a pagar; la valoración social es su **suma vertical** (con un vértice donde una curva llega a cero); $G^*$ donde $\mathrm{RMS}^A_{GX}(G^*)+\mathrm{RMS}^B_{GX}(G^*)=\mathrm{CMg}_G$. Si se declara de menos, $\widetilde{\mathrm{RMS}}{}^i_{GX}(G)$, se provee $\tilde G<G^*$ (la tilde marca lo **declarado**).
- **Provisión privada como equilibrio de Nash** (Bergstrom, Blume y Varian, 1986): aportaciones $g_i\geq0$, $G=g_A+g_B$; $\max_{g_A}U_A(\overline W_A-g_A,\,g_A+g_B)$ da $\mathrm{RMS}^A_{GX}=1$ y la reacción $g_A=R_A(g_B)$ decreciente (sustitutos estratégicos); $G^{\mathrm N}<G^*$. Concentración, neutralidad (Warr, 1983) y expulsión (*crowding out*; Andreoni, 1990, *warm glow*).
- Evidencia: aportaciones del 40-60 % en los experimentos, que caen al repetir (Ledyard, 1995).
- Valoración: la condición dice qué es eficiente, no cómo averiguarlo; el polizón tiene la otra cara de la **revelación de preferencias** (fichas `lindahl` y `clarke-groves`).

**Gráficos de referencia:**
- Equilibrio general (Samuelson, 1955): arriba, FPP y $\overline U_B$ en el plano $(G,X)$; su diferencia vertical es la **frontera de posibilidades de consumo de $A$**, $\mathrm{FPC}_A$; $A$ elige el punto $E$ de $\mathrm{FPC}_A$ tangente a $U_A^*$: $\mathrm{RMS}^A_{GX}=\mathrm{RMT}_{GX}-\mathrm{RMS}^B_{GX}$. Ruta: `oposicion/temario/fuentes/3A23/graficos/samuelson-eg.tex`.
- Equilibrio parcial (Bowen), con los precios de Lindahl en la misma figura: `oposicion/temario/fuentes/3A23/graficos/bowen.tex`.
- Provisión privada (funciones de reacción $R_A$, $R_B$ y $G^{\mathrm N}$): `oposicion/temario/fuentes/3A23/graficos/provision-privada.tex` (anexo).

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.23 | Bienes públicos | desarrollo (hecho, 21/10/2026) | Clasificación; planificador, condición, gráfico en EG; mercado e infraprovisión; polizón como dilema; Bowen; provisión de Nash; evidencia; revelación | — |
| 4.B.5 | Tamaño del sector público | mención | FPP bien público–privado y FBS: nivel óptimo de gasto | La derivación |
| 3.A.24 | Elección colectiva | mención (hecho, 22/10/2026) | La regla de mayoría (votante mediano) en general no cumple la condición de Samuelson; con $\mathrm{RMS}^i_{GX}$ y $\mathrm{RMT}_{GX}$ (no $|\mathrm{RMT}_X^G|$); `\vertema{3.A.23}` | La derivación |
| 4.B.2 | Elección pública | mención | Bowen y la votación del bien público, con remisión (Bowen se dibuja en el 3.A.23) | El gráfico |
| 3.B.31 | Bienes públicos globales (clima) | mención (hecho, 31/10/2026) | $\mathrm{DMg}(E)=\sum_i\mathrm{DMg}_i(E)$, la suma vertical de Bowen entre países; $E^{\mathrm N}$ (cada país iguala $\mathrm{CMgR}$ a su propio daño, como la provisión de Nash) frente a $E^*$; polizón entre Estados y suma de esfuerzos. Gráfico propio `fig:emisiones-optimas` (ruta `oposicion/temario/fuentes/3B31/graficos/emisiones-optimas.tex`) | La condición en EG |
| 3.A.14 | Juegos | mención (hecho, 19/10/2026) | El polizón como dilema del prisionero | La condición |

## Divergencias encontradas en el temario actual
- Resueltas en el 3.A.23 (21/10/2026): $X_A+X_B=\overline X$ a la vez que $T(X,G)=0$ (sobra $\overline X$); $|\mathrm{RMT}_X^G|$ y $\mathrm{RMT}_G^X$ (→ $\mathrm{RMS}^i_{GX}$, $\mathrm{RMT}_{GX}$); «libre» en lugar de planificador; Bowen con $\mathrm{UMg}^A$, $D_T$, $G'$ (→ $\mathrm{RMS}^i_{GX}(G)$, tilde para lo declarado, $\tilde G$); manuscrito de la provisión privada con $u_i$, $R_1$, $G^{EN}$ (→ $U_A$, $g_A$, $R_A(g_B)$, $G^{\mathrm N}$).
- 3.A.24: resuelto en su revisión (22/10/2026): $|\mathrm{RMT}_X^G|=\sum|\mathrm{RMS}_X^G|$ → $\sum_i\mathrm{RMS}^i_{GX}=\mathrm{RMT}_{GX}$.
- 4.B.2 (sin revisar): comentario sobre «la representación de Bowen del tema 3.A.23»: con el reparto, Bowen está en el 3.A.23 y allí basta mencionarlo.
