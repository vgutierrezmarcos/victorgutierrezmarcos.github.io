# Divina coincidencia y su ruptura (Goodfriend y King, 1997; Rotemberg y Woodford, 1997; Blanchard y Galí, 2007)

- **Área:** pensamiento (se usa sobre todo en política monetaria) · **Tema de referencia:** **3.A.7** (La nueva economía keynesiana; revisado el 4/11/2026: II.2 iii) `sec:modelo-canonico`, con `eq:perdida` y los 2 paneles de `nek-xpi`) — es un resultado del modelo canónico, cuyo tema de referencia es el 3.A.7; el 3.A.36 lo **aplica** a la política óptima (discreción y compromiso). Ficha creada en la fase canon del 3.A.7 (C43 de contenido, **[decidir]**; alternativa: dejarla como sección de `nek-3-ecuaciones`, que la resume y remite aquí).
- **Temas que lo usan:** 3.A.7 (desarrollo; hecho, 4/11/2026), 3.A.36 (resumen + desarrollo del dilema con política óptima; hecho, 4/11/2026: I.3 iii) con la regla que sigue a $r^n_t$, la atribución fija y la lectura neowickselliana; el dilema con `eq:discrecion` y `eq:compromiso` (ficha `nek-3-ecuaciones`, sección de la política óptima); I.3 c), las 4 fuentes del dilema; I.4.2, la perturbación de oferta como $u_t$ que la rompe), 3.A.37 (mención: respuesta a perturbaciones de demanda y de costes), 3.A.42 (mención; hecho, 4/11/2026: II.2.2 iii), sin perturbaciones de costes, si el tipo sigue al natural, inflación y brecha cero a la vez; la atribución fija —Goodfriend y King, 1997; Rotemberg y Woodford, 1997; el nombre, Blanchard y Galí, 2007—; se rompe con perturbaciones de costes, salarios reales rígidos o fricciones de búsqueda, Blanchard y Galí, 2010, `\vertema{3.A.26}`), 3.A.28 (mención; hecho, 31/10/2026: III.5 `sec:nek-desempleo`, «se rompe la divina coincidencia» con Blanchard y Galí, 2010, y en las extensiones de la conclusión, `\vertema{3.A.7}`). Relacionadas: `nek-3-ecuaciones`, `taylor`, `nek-desempleo`, `barro-gordon`.
- **Manuales de referencia:** Goodfriend y King (1997), «The New Neoclassical Synthesis and the Role of Monetary Policy», *NBER Macroeconomics Annual* (`GoodfriendKing1997New`); Rotemberg y Woodford (1997), *NBER Macroeconomics Annual* (`RotembergWoodford1997Optimization`); Blanchard y Galí (**2007**), «Real Wage Rigidities and the New Keynesian Model», *JMCB* 39(s1) (`BlanchardGali2007Real`), que le ponen el nombre; Woodford (2003), *Interest and Prices*; Galí (2015), cap. 4-5; Galí (2018), *JEP* (`Gali2018State`); Clarida, Galí y Gertler (1999), *JEL* (`ClaridaGaliGertler1999Science`).

## Presentación de referencia (3.A.7, II.2 iii)

**Pregunta:** ¿hay conflicto entre estabilizar la inflación y estabilizar la actividad?

- **Objetivo del banco central** (aproximación de segundo orden del bienestar del hogar; Rotemberg y Woodford, 1997; Woodford, 2003):
  $$L=\mathbb{E}_0\sum_{t=0}^{\infty}\beta^t\big(\pi_t^2+\lambda_x\,x_t^2\big),\qquad\lambda_x=\frac{\kappa}{\sigma}\qquad\texttt{(eq:perdida)}$$
  La inflación cuesta porque dispersa los precios relativos (con Calvo, precios que no se revisan a la vez); la brecha, porque la producción natural es la **eficiente** si un subsidio corrige el margen de monopolio (A07-18). λ_x = κ/σ es la de Galí (2015, cap. 4), que la escribe κ/ε con ε la elasticidad de sustitución (A07-22).
- **Resultado**: sin perturbaciones de costes ($u_t=0$), si el banco central mueve el tipo nominal con el tipo natural,
  $$i_t=r^n_t+\phi_\pi\pi_t+\phi_x x_t,$$
  la inflación y la brecha son cero a la vez: con $x_t=0$ la NKPC da $\pi_t=0$, y a la inversa. Basta mirar la inflación. Es la variante de la regla que **sigue al tipo natural**; la regla del modelo, con la que se dibuja la DA, es $i_t=\rho+\phi_\pi\pi_t+\phi_x x_t+\varepsilon_t$ (CC2; fichas `nek-3-ecuaciones` y `taylor`). Pegatina del 3.A.7: «matar dos pájaros de un tiro».
- **Atribución (fija)**: el **resultado** está en Goodfriend y King (1997) y en Rotemberg y Woodford (1997); el **nombre** se lo pusieron Blanchard y Galí (**2007**). **Nunca** «hallada por Rotemberg y Woodford (2005) y bautizada por Blanchard y Galí (2005)».
- **Cuándo se rompe**: exige que la producción natural sea la eficiente (la única distorsión, la rigidez de los precios). Con otras fricciones aparece el **dilema** (Galí, 2018):
  - **perturbaciones de costes**, $u_t\neq0$: la NKPC sube, la inflación sube y la brecha cae (panel b de `nek-xpi`); lo óptimo es acomodar en parte, y con compromiso creíble se logra la misma inflación con menos recesión hoy (**ganancia del compromiso**; Clarida, Galí y Gertler, 1999; desarrollo en el 3.A.36, hecho: pegatina del 3.A.36 «entre dos males, el menor»);
  - **salarios reales rígidos**: la producción natural responde demasiado a las perturbaciones de oferta (Blanchard y Galí, 2007);
  - **fricciones de búsqueda** con salarios reales rígidos: la NEK con desempleo (Blanchard y Galí, **2010**; ficha `nek-desempleo`);
  - **salarios nominales rígidos** à la Calvo (Erceg, Henderson y Levin, 2000): 2 curvas de Phillips; estabilizar solo la inflación de precios ya no es óptimo.

**Gráfico de referencia:** `oposicion/temario/fuentes/3A07/graficos/nek-xpi.tex` (**imprescindible**, 2 paneles en el plano $(x_t,\pi_t)$ con expectativas dadas: a) perturbación de demanda, la DA se desplaza y el banco central que sigue a $r^n_t$ la devuelve a su sitio, la divina coincidencia; b) perturbación de costes, la NKPC sube: el dilema). Es el mismo gráfico de la ficha `nek-3-ecuaciones`.

## Cómo se adapta en cada tema

| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.7 | Implicaciones del modelo canónico | desarrollo (hecho, 4/11/2026) | `eq:perdida` con λ_x = κ/σ y su justificación; el resultado con la regla que sigue a $r^n_t$; la atribución; las 3 rupturas; los 2 paneles de `nek-xpi`; la pegatina | — |
| 3.A.36 | Diseño de la política monetaria | resumen del resultado + desarrollo del dilema (hecho, 4/11/2026) | La pérdida con la misma forma; el resultado con $i_t=r^n_t+\phi_\pi\pi_t+\phi_x x_t$ y la atribución fija; con $u_t$, discreción (`eq:discrecion`) frente a compromiso (`eq:compromiso`), la ganancia del compromiso y el objetivo de inflación flexible; panel b de `nek-xpi` copiado; pegatina «entre dos males, el menor» (no «matar dos pájaros de un tiro», que es del 3.A.7); `\vertema{3.A.7}` | La derivación de la pérdida |
| 3.A.37, 3.A.42 | Transmisión; ciclos nominales | mención (el 3.A.42, hecho, 4/11/2026) | Perturbaciones de demanda (sin dilema) frente a perturbaciones de costes (dilema); `\vertema{3.A.7}` | — |
| 3.A.28 | NEK con desempleo | mención (hecho, 31/10/2026) | Con búsqueda y salarios reales rígidos se rompe la divina coincidencia (Blanchard y Galí, 2010), `\vertema{3.A.7}` | — |
| 3.A.41 | Causas de la inflación (otras perturbaciones de demanda); estabilización | mención (hecho, 5/11/2026) | I.2.1: con perturbaciones de demanda (que van en $r^n_t$, sin letra) el banco central estabiliza inflación y actividad a la vez, gráfico `nek-xpi` panel a; con las de costes, el dilema (panel b); II.3, inflación y estabilización; `\vertema{3.A.7}`, `\vertema{3.A.36}` | La derivación |

## Divergencias encontradas en el temario actual

- **Resuelto en el 3.A.7 (4/11/2026)**: «hallada por Rotemberg y Woodford (2005) y bautizada por Blanchard y Galí (2005)», también en el título; «Blanchard y Galí (2005)» para el modelo con búsqueda (es 2010, otro trabajo); «Woodford (1999)» y $\lambda\hat y^2$ en la pérdida.
- **3.A.36 (Word, l. 725) y 3.A.42 (Word, l. 1478 y 1500)**: repetían «Rotemberg y Woodford (2005)» y «Blanchard y Galí (2005)» para 2 trabajos distintos: **resuelto** en los 2 (4/11/2026) con la atribución de arriba.
- **3.A.37 (sin revisar)**: menciona la divina coincidencia 3 veces (Word): con esta ficha y `\vertema{3.A.7}`.

Autor: Víctor Gutiérrez Marcos
