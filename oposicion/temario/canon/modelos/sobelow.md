# Modelo Sobelow (Jones y Manuelli 1990; Kurz 1968)

- **Área:** macro cerrada · **Tema de referencia:** **3.A.44** (crecimiento endógeno: rendimientos crecientes) — único tema que lo desarrolla, breve: I.2.2 (`sec:sobelow`, 30″ en el cante) con a)-e) y la CES con σ > 1 como extensión; revisado el 1/11/2026. Ficha creada en la fase canon del 3.A.44 (CC3; **[decidir]**). Alias: `jones-manuelli`.
- **Temas que lo usan:** 3.A.44 (desarrollo breve; hecho, 1/11/2026), 3.A.43 (mención; hecho, 31/10/2026: II.2 «Hacia el crecimiento endógeno», con $f(k)=Ak+Bk^{\alpha}$ y «si $sA>n+\delta$ la economía crece sin límite»), 3.A.11 (mención; hecho, 13/10/2026: la CES con σ > 1 permite crecer sin límite, `\vertema{3.A.44}`; ficha `ces`)
- **Manuales de referencia:** Jones y Manuelli (1990), *JPE*; Kurz (1968); Sala-i-Martín (2000), cap. 3; Barro y Sala-i-Martin (2004), cap. 1 (fig. 1.14, CES) y cap. 4.

## Presentación de referencia (3.A.44, I.2.2)

**a) Idea.** ¿Se puede tener a la vez crecimiento endógeno y convergencia condicional? Basta que el producto marginal del capital caiga, como en Solow, pero sin llegar a cero, como en el $AK$. El nombre une **Solow** y **Rebelo**; la función es de Kurz (1968) y la recuperan Jones y Manuelli (1990): un modelo convexo, sin rendimientos crecientes ni externalidades, puede crecer sin límite.

**b) i) Supuestos.** Los de Solow con ahorro constante y
$$Y_t=A\,K_t+B\,K_t^{\alpha}L_t^{1-\alpha}\;\Longrightarrow\;y_t=f(k_t)=A\,k_t+B\,k_t^{\alpha},\qquad A,B>0,\ 0<\alpha<1$$
(A y B locales, como en el 3.A.43; $k\equiv K/L$). Rendimientos constantes, productos marginales positivos y decrecientes, todas las condiciones de Inada **salvo una**: $f'(k)\to A>0$ cuando $k\to\infty$ (`tab:supuestos-neoclasicos`).

**b) ii) Desarrollo.**
$$\gamma_k=s\,\frac{f(k_t)}{k_t}-(n+\delta)=s\left(A+B\,k_t^{\alpha-1}\right)-(n+\delta)\qquad(\texttt{eq:sobelow})$$
La curva de ahorro decrece con $k$ y tiende a la asíntota $sA$: si $sA>n+\delta$, crece siempre, cada vez más despacio, y a largo plazo a $sA-(n+\delta)$, como el $AK$; si $sA<n+\delta$, estado estacionario estable, como Solow.

**b) iii) Implicaciones.** Crecimiento endógeno y **convergencia condicional en tasas** a la vez (la economía con menos capital crece más deprisa, pero ninguna se para); la clave es que se incumpla la condición de Inada en el infinito (rendimientos no decrecientes: suficientes, no necesarios); la política que sube s o A sube el crecimiento a largo plazo.

**c) Extensión: CES con σ > 1** (`\vertema{3.A.11}`): con mucha sustitución, el producto medio del capital tiende a $A\,a_K^{\sigma/(\sigma-1)}$ y, si $s\,A\,a_K^{\sigma/(\sigma-1)}>n+\delta$, la economía crece sin límite (Barro y Sala-i-Martin, 2004, cap. 1, fig. 1.14). Solow (1956, p. 77) ya usa una CES y Arrow, Chenery, Minhas y Solow (1961) la generalizan.

**d) Evidencia.** Casi todas las estimaciones de σ entre capital y trabajo están por debajo de 1 (`\vertema{3.A.11}`): resta realismo a la vía CES.

**e) Valoración.** Recupera la convergencia, pero la participación del capital tiende a 1 (contra Kaldor) y el progreso técnico sigue sin explicarse. Nexo: formas de «fabricar» un $AK$ (gasto público, externalidades).

**Gráfico de referencia:** `oposicion/temario/fuentes/3A44/graficos/sobelow.tex` (2 paneles en tasas: con $sA>n+\delta$, crecimiento sostenido; con $sA<n+\delta$, estado estacionario). En el cante, una capa más del gráfico `tasas-endogeno` (curva con asíntota $sA$).

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.44 | Crecimiento endógeno sin rendimientos crecientes | desarrollo breve (hecho, 1/11/2026) | Lo de arriba, 30″ en el cante | — |
| 3.A.43 | Puente al crecimiento endógeno | mención (hecho, 31/10/2026) | $f(k)=Ak+Bk^{\alpha}$, $f'\to A$, crece si $sA>n+\delta$ | El modelo `\vertema{3.A.44}` |
| 3.A.11 | Elasticidad de sustitución | mención (hecho, 13/10/2026) | CES con σ > 1: ningún factor imprescindible; crecimiento sin límite | El modelo |

## Divergencias encontradas en el temario actual
- 3.A.44 (Word): CES con el exponente del límite invertido ($\alpha^{(\sigma-1)/\sigma}$), φ suelta, «fue inicialmente por Kurz (1968)», gráficos sin título, el Sobelow al final del bloque (cortaba el paso de Uzawa-Lucas a la 2.ª generación). **Resuelto** (1/11/2026): orden $AK$ → Sobelow → Barro → externalidades → Uzawa-Lucas (DK2).
- Test de junio de 2024: fecha el Sobelow en 1991 (es 1990) (A44-12; para Víctor).

Autor: Víctor Gutiérrez Marcos
