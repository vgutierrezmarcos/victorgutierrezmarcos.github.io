# Aritmética monetarista desagradable (Sargent y Wallace, 1981) y aritmética fiscal desagradable (King, 1995)

- **Área:** macro cerrada · **Tema de referencia:** 3.A.39 (Déficit público… dominación monetaria y dominación fiscal) — es el modelo de la dominación fiscal. **Hecho (revisado el 4/11/2026):** III.3.2 con a)-e), `eq:aritmetica`, el gráfico de referencia, el juego de la gallina y King (1995); derivación en el anexo A.
- **Temas que lo usan:** 3.A.39 (desarrollo; hecho, 4/11/2026), 3.A.6 (resumen; hecho, 4/11/2026: II.5 con los nombres **dominación monetaria** (o dominancia, una vez) y **dominación fiscal**, el mecanismo y la FTPL en una línea; anexo C con la restricción de solvencia en % del PIB y las 2 opciones, monetizar ya o endeudarse; `\vertema{3.A.39}`), 3.A.41 (resumen; hecho, 5/11/2026: I.2.1, la inflación de origen fiscal con «dominación fiscal» y el juego de la gallina, `\vertema{3.A.39}`, `\vertema{3.A.14}`; anexo E, `eq:aritmetica` sin número con $s^*$, $s^{\text{antes}}$, $s^{\text{después}}$ y $\bar t$; III.1.4, la lección de las hiperinflaciones; cita `SargentWallace1981`, no `SargentWallace1981Some`: pendiente cosmético), 3.A.36 (mención; hecho, 4/11/2026: I.1.3 c), la independencia no basta sin que alguien cierre la restricción, `SargentWallace1981Some`, con **dominación monetaria** y **dominación fiscal** en las palabras del 3.A.39, arts. 123 y 130 del TFUE, `\vertema{3.A.39}`; II.2, la base que se controla mal si hay que financiar el déficit), 1D01 (mención, aprobada: «dominancia fiscal» como riesgo, l. 618, 1428, 1698). Distinta de la proposición de inefectividad (`sargent-wallace-inefectividad`). También 3.A.40 (mención; hecho, 5/11/2026: III.1, «aritmética monetarista desagradable» —nunca «monetaria»— bajo dominación fiscal, un argumento a favor de la disciplina fiscal, `\vertema{3.A.39}`).
- **Manuales de referencia:** Sargent y Wallace (1981), *FRB Minneapolis Quarterly Review* 5(3) (clave **`SargentWallace1981Some`**); King (1995), comentario en el simposio de Jackson Hole, págs. 171-183 (clave **`King1995Commentary`**, A39-13); Sargent (1982), «The Ends of Four Big Inflations»; Walsh (2017), cap. 4; Romer (2019), cap. 11.

## Presentación de referencia

**Pregunta:** ¿puede el banco central controlar la inflación si la política fiscal no se ajusta?

**a) Idea:** con dominación fiscal, una política monetaria más dura hoy acaba en más inflación mañana, y puede que también hoy. Marco: la matriz de Leeper (ficha `ftpl`); los 2 regímenes, **dominación monetaria** (la autoridad fiscal ajusta el superávit primario a la senda de señoreaje que elige el banco central) y **dominación fiscal** (la senda de superávits es exógena y el banco central debe dar el señoreaje que falte). «Nadie puede servir a dos señores».

**b) Modelo. Supuestos:** déficit primario $g-\tau>0$ constante; $r>\gamma_Y$; la demanda de deuda tiene un límite: desde $\bar t$ la ratio no puede crecer más; demanda de dinero tipo Cagan (depende de la inflación esperada).

**Desarrollo:** 2 opciones, **monetizar ya** (más inflación hoy, la deuda deja de crecer) o **financiarse con deuda** (menos inflación hoy, la deuda crece con su bola de nieve). Con $s^*\equiv(g-\tau)+\frac{r-\gamma_Y}{1+\gamma_Y}d_0$ el señoreaje que estabiliza la deuda inicial, $s^{\text{antes}}<s^*$ hasta $\bar t$ y $s^{\text{después}}=(g-\tau)+\frac{r-\gamma_Y}{1+\gamma_Y}d_{\bar t}$ desde $\bar t$, iterando `eq:restriccion-real` (`eq:aritmetica`):

$$s^{\text{después}}-s^*=\left[\left(\frac{1+r}{1+\gamma_Y}\right)^{\bar t}-1\right]\left(s^*-s^{\text{antes}}\right)>0$$

Cada punto de señoreaje que se ahorra hoy cuesta más señoreaje mañana, y para siempre. **Es una formalización propia** (comprobada; derivación en el anexo A del 3.A.39 con $a\equiv(1+r)/(1+\gamma_Y)$; ejemplo $r=3$ %, $\gamma_Y=1$ %, $a^{20}\approx1{,}48$), **no la de Sargent y Wallace**, que usan generaciones solapadas: no se les atribuye (A39-17). La solvencia de partida es `eq:solvencia` (ficha `restriccion-gobierno`).

**Implicaciones:** con expectativas racionales y demanda tipo Cagan, la inflación sube **ya**; «cuanto más se retrase la monetización inevitable, mayor será la inflación»; si $s^{\text{después}}$ supera el máximo de la curva de Laffer del señoreaje (ficha `cagan`), hiperinflación o impago.

**c) Extensiones:**
- **Juego de la gallina** entre las 2 autoridades (`\vertema{3.A.14}`): cede la que menos aguanta (con dominación monetaria, la fiscal).
- **Aritmética fiscal desagradable** (King, 1995): una desinflación **no creída** encarece la deuda, porque los tipos nominales llevan una inflación esperada mayor que la que llega y la deuda paga un tipo real *ex post* más alto. Con el término de la sorpresa (`eq:inflacion-sorpresa`, $s_t=0$, denominadores ≈ 1):
  $$d_t-d_{t-1}\approx(g_t-\tau_t)+\left[r-\gamma_Y+\left(\mathbb{E}_{t-1}[\pi_t]-\pi_t\right)\right]d_{t-1}$$
  Salida: deuda indexada, ganar credibilidad deprisa y ajustar la política fiscal a la vez. (Sin la cifra del ejemplo de King, 6 % → 2 %, que no se pudo comprobar con página.)
- **Irrelevancia de Wallace (1981)**: cambiar bonos por dinero no tiene efectos si no cambia la política fiscal (3.A.39, III.3.4, monetización hoy).

**d) Evidencia:** las hiperinflaciones de los 20 (Austria, Hungría, Polonia, Alemania) terminaron de golpe con un cambio de régimen fiscal y un banco central que no podía financiar al Estado (Sargent, 1982).

**e) Valoración:** la inflación puede tener origen fiscal; la independencia no basta sin disciplina fiscal (art. 123 del TFUE, reglas fiscales, `\vertema{3.B.43}`); depende de $r>\gamma_Y$ y de que el banco central no pueda comprometerse a no ceder.

**Gráfico de referencia:** sendas temporales de la inflación con política monetaria restrictiva hoy frente a laxa: más baja hasta $\bar t$ y más alta desde entonces. `fuentes/3A39/graficos/aritmetica-monetarista.tex`.

## Cómo se adapta en cada tema

| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.39 | Dominación monetaria y fiscal | Desarrollo (hecho, 4/11/2026) | III.3.2 a)-e): supuestos, las 2 opciones, `eq:aritmetica` con su derivación en el anexo A, gráfico `aritmetica-monetarista`, gallina, King (1995), Sargent (1982), art. 123 | — |
| 3.A.6 | La NMC | Resumen (hecho, 4/11/2026) | Expectativas racionales aplicadas a la coordinación de políticas: dominación monetaria frente a fiscal, mecanismo de palabra, la inflación como fenómeno fiscal y la FTPL (Leeper, 1991) en una línea; la restricción $d_{t-1}=\sum_k[(1+\gamma_Y)/(1+r)]^{k+1}(\tau_{t+k}-g_{t+k}+s_{t+k})$ en el anexo C. Con el 3.A.39 revisado, el anexo C puede adelgazar | La derivación con la demanda de dinero |
| 3.A.41 | Causas de la inflación | resumen (hecho, 5/11/2026) | Inflación fiscal; hiperinflaciones; `eq:aritmetica` en el anexo E con `\vertema{3.A.39}` | El desarrollo y el gráfico |
| 3.A.36 | Política monetaria | mención (hecho, 4/11/2026) | La independencia necesita una política fiscal que cierre la restricción | El modelo |
| 1D01 | Dictamen | Mención (aprobada) | La dominación fiscal como riesgo (dice «dominancia»: anotado, no se toca) | — |

## Divergencias encontradas en el temario actual

- **Terminología:** canon «**dominación** monetaria / fiscal» (los del título oficial del 3.A.39), con «(o dominancia)» una vez. La **1D01** (aprobada) dice «dominancia fiscal» (l. 618, 1428, 1698): anotado en `pendientes-coherencia.md`, no se toca sin Víctor.
- **Claves:** `SargentWallace1981Some` es la buena (3.A.6, 3.A.36, 3.A.39). `SargentWallace1981` es la misma obra: la cita la 1D01 (l. 1445) y está sin citar en `3A06.bib` (l. 1343). Unificar (`pendientes-coherencia.md`).
- **3.A.39 resuelto** (4/11/2026): la aritmética estaba contada 2 veces (3.3.1 y 3.3.4) y con $r_t>g_t$; ahora una sola vez, con $r>\gamma_Y$ y `eq:aritmetica`.
- **3.A.41 resuelto** (5/11/2026): resumen con `\vertema{3.A.39}` y «dominación». **Pendiente cosmético**: cita `SargentWallace1981` (l. 190 y 916); la clave canónica es `SargentWallace1981Some` (3.A.6, 3.A.36, 3.A.39, 3.A.40); en el anexo E, la ecuación sigue a la cita de Sargent y Wallace sin decir que es la formalización del 3.A.39 (ellos usan generaciones solapadas; A39-17).

Autor: Víctor Gutiérrez Marcos
