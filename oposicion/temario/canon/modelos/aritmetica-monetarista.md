# Aritmética monetarista desagradable (Sargent y Wallace, 1981)

- **Área:** macro cerrada · **Tema de referencia:** 3.A.39 (Déficit público… dominación monetaria y dominación fiscal) — es el modelo de la dominación fiscal.
- **Temas que lo usan:** 3.A.39 (desarrollo), 3.A.6 (resumen; hecho, 4/11/2026: II.5 con los nombres **dominación monetaria** (o dominancia, una vez) y **dominación fiscal**, el mecanismo y la FTPL en una línea; anexo C con la restricción de solvencia en % del PIB y las 2 opciones, monetizar ya o endeudarse; `\vertema{3.A.39}`), 3.A.41 (resumen: inflación de origen fiscal). Distinta de la proposición de inefectividad (`sargent-wallace-inefectividad`).
- **Manuales de referencia:** Sargent y Wallace (1981), *FRB Minneapolis Quarterly Review* 5(3); Walsh (2017), cap. 4; Romer (2019), cap. 11.

## Presentación de referencia

**Pregunta:** ¿puede el banco central controlar la inflación si la política fiscal no se ajusta?

**Supuestos:** restricción consolidada del sector público (`restriccion-gobierno`); r > γ_Y; demanda de dinero tipo Cagan; dos regímenes: **dominación monetaria** (la autoridad fiscal ajusta el superávit primario a la senda de señoreaje que elige el banco central) y **dominación fiscal** (la senda de superávits es exógena y el banco central debe proporcionar el señoreaje que falte).

**Ecuaciones:** con la solvencia

$$d_{t-1} = \sum_{k=0}^{\infty}\left(\frac{1+\gamma_Y}{1+r}\right)^{k+1}\left(\tau_{t+k} - g_{t+k} + s_{t+k}\right)$$

si (τ − g) está dado, una política monetaria más restrictiva hoy (menos s) eleva la deuda y obliga a **más** señoreaje mañana: con demanda de dinero que depende de la inflación esperada, puede subir incluso la inflación de hoy.

**Resultado:** bajo dominación fiscal, la inflación es en último término un fenómeno fiscal; la independencia del banco central necesita disciplina fiscal (reglas, PEC).

**Gráfico de referencia:** sendas temporales de inflación con política monetaria restrictiva hoy frente a laxa (inflación más baja ahora y más alta después).

## Cómo se adapta en cada tema

| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.39 | Dominación monetaria y fiscal | Desarrollo | Regímenes, mecanismo, implicaciones institucionales, enlace con la FTPL | — |
| 3.A.6 | La NMC | resumen (hecho, 4/11/2026) | Expectativas racionales aplicadas a la coordinación de políticas: dominación monetaria frente a fiscal, mecanismo de palabra, la inflación como fenómeno fiscal y la FTPL (Leeper, 1991) en una línea; la restricción $d_{t-1}=\sum_k[(1+\gamma_Y)/(1+r)]^{k+1}(\tau_{t+k}-g_{t+k}+s_{t+k})$ en el anexo C | La derivación con la demanda de dinero |
| 3.A.41 | Causas de la inflación | Resumen | Inflación fiscal; hiperinflaciones | — |

## Divergencias encontradas en el temario actual

- Sin ecuaciones en el inventario; 3.A.39 indica en nota inicial que faltaría desarrollar la dominación monetaria y fiscal. Notación de la solvencia: la de `restriccion-gobierno`.
- **3.A.6 (revisado el 4/11/2026)**: los regímenes con su nombre (el original decía «dominancia» y no los nombraba en el título); la restricción con la notación de `restriccion-gobierno` ($d$, $\tau$, $g$, $s$ sobre el PIB, $\gamma_Y$). El Word del 3.A.39 (sin revisar) la cuenta con el mismo texto: al revisarlo, desarrollo allí y el 3.A.6 podrá adelgazar su anexo C.

Autor: Víctor Gutiérrez Marcos
