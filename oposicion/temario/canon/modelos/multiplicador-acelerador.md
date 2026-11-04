# Multiplicador-acelerador: Samuelson (1939) y Hicks (1950)

- **Área:** macro cerrada · **Tema de referencia:** **3.A.42** (teorías de los ciclos) — I.4.3 «Tercera etapa: las teorías keynesianas del ciclo», párrafo «El multiplicador-acelerador: Samuelson (1939) y Hicks (1950)», con estructura a)-d) (idea, modelo con supuestos, desarrollo e implicaciones, extensiones, valoración), `eq:samuelson` como función clave y el gráfico `multiplicador-acelerador`; revisado el 4/11/2026. Es la dinámica del ciclo, no el principio de aceleración (ese es del 3.A.34, ficha `acelerador`). Ficha creada en la fase canon del 3.A.42 (CC2, A42-06, **[decidir]**: *alternativa*, alias de `acelerador`, como estaba desde la fase canon del 3.A.34). Recoge el id `multiplicador-acelerador` del inventario del 3.A.42 (antes alias de `acelerador`).
- **Temas que lo usan:** 3.A.42 (desarrollo; hecho, 4/11/2026), 3.A.34 (mención; hecho, 31/10/2026: nota de I.2 con la ecuación de Samuelson, $cv<1$ y $c(1+v)^2<4v$, «desarrollo en el 3.A.42»), 3.A.43 (mención; hecho, 31/10/2026: Harrod, 1936 y 1939, y la misma $v$; ficha `harrod-domar`), 3.A.4 (mención posible: Harrod y Hicks como keynesianos de la dinámica; hoy no lo cita). Relacionadas: `acelerador` (el principio, 3.A.34), `ciclos-endogenos` (la versión no lineal), `bernanke-gertler` (el acelerador «en clave financiera»).
- **Manuales de referencia:** Samuelson (1939), «Interactions between the Multiplier Analysis and the Principle of Acceleration», *REStat* (`Samuelson1939Interactions`); Hicks (1950), *A Contribution to the Theory of the Trade Cycle* (`Hicks1950Contribution`); Harrod (1936), *The Trade Cycle* (`Harrod1936Trade`); Metzler (1941) (`Metzler1941Nature`); Goodwin (1951) (`Goodwin1951Nonlinear`); Gandolfo (2009), *Economic Dynamics*, cap. 6; Blanchard y Fischer (1989).

## Presentación de referencia (3.A.42, I.4.3)

**Pregunta:** ¿puede la propia demanda, sin perturbaciones, generar ciclos?

**a) Idea.** Harrod (1936) junta las 2 piezas keynesianas de la dinámica: el **multiplicador** (la inversión genera demanda) y el **principio de aceleración** (la variación de la demanda genera inversión, `\vertema{3.A.34}`). Samuelson (1939), a sugerencia de Alvin Hansen, las escribe en una ecuación en diferencias: su interacción basta para generar ciclos sin perturbaciones, un ciclo endógeno de demanda.

**b) Modelo.** *Supuestos*: economía cerrada, precios fijos y capacidad ociosa; $C_t=c\,Y_{t-1}$, con **c** la PMgC, $0<c<1$; $I_t=v\,(C_t-C_{t-1})$, con **v** la relación capital-producto (la del 3.A.34 y del 3.A.43, D009); gasto autónomo constante **G**. *Desarrollo*, en $Y_t=C_t+I_t+G$:
$$Y_t=c\,(1+v)\,Y_{t-1}-c\,v\,Y_{t-2}+G\qquad(\texttt{eq:samuelson},\ \text{función clave})$$
- estado estacionario $Y^*=G/(1-c)$, el del multiplicador keynesiano (asterisco = estado estacionario, § 0);
- dinámica $Y_t=Y^*+A_1z_1^t+A_2z_2^t$, con $z_1$, $z_2$ las raíces de $z^2-c(1+v)z+cv=0$, $z_1z_2=cv$, y $A_1$, $A_2$ fijadas por las 2 rentas iniciales (**$z_1$, $z_2$, $A_1$, $A_2$ locales**);
- **oscilaciones** si las raíces son complejas, $c\,(1+v)^2<4v$; **amortiguadas** si su módulo $\sqrt{cv}<1$, es decir, $c\,v<1$;
- 4 regiones del plano $(v,c)$: convergencia sin oscilar ($v$ pequeño), oscilaciones amortiguadas, oscilaciones explosivas y divergencia sin oscilar ($v$ grande);
- **ejemplo canónico**: $c=0{,}8$, $v=1$: $cv=0{,}8<1$ y $c(1+v)^2=3{,}2<4$; la renta va a 5 veces el aumento de $G$ con oscilaciones que se apagan, de unos 13,5 periodos (periodo $2\pi/\omega$ con $\cos\omega=c(1+v)/(2\sqrt{cv})\approx0{,}894$).
- **Nota que lo reconcilia con el 3.A.34**: con el acelerador contemporáneo, $I_t=v\,\Delta Y_t$, el multiplicador de impacto es $1/(1-c-v)$ y exige $c+v<1$; con los retardos de Samuelson lo que importa es la estabilidad de la trayectoria, $cv<1$: 2 versiones del mismo principio (X4 del 3.A.42).

*Implicaciones*: el ciclo puede nacer de la demanda y la inversión es su componente más volátil; solo hay oscilaciones regulares y permanentes en el caso límite $cv=1$ (si no, se apagan o explotan): un ciclo duradero exige perturbaciones que lo reanimen (Frisch) o límites que lo acoten (Hicks); la política fiscal cambia el nivel de la renta, pero también puede desencadenar oscilaciones.

**c) Extensiones.** **Hicks (1950)**: el caso explosivo ($cv>1$) acotado por un **techo** (la producción de pleno empleo, que crece) y un **suelo** (la inversión bruta no puede ser negativa): la economía rebota entre ambos, un ciclo acotado sin afinar los parámetros. Pegatina del 3.A.42: **«todo lo que sube baja»**. Metzler (1941), las existencias; Goodwin (1951), el acelerador no lineal (no confundir con Goodwin, 1967, ficha `ciclos-endogenos`); Duesenberry (1958) y Pasinetti (1960), con el crecimiento.

**d) Valoración.** Coeficientes fijos, sin precios ni tipos de interés ni optimización: ecuaciones *ad hoc*, expuestas a la crítica de Lucas (`\vertema{3.A.6}`); para tener ciclos, parámetros muy concretos o frenos desde fuera; ciclos demasiado regulares frente a Burns y Mitchell. La idea sobrevive: la inversión responde a la variación de las ventas, y el acelerador vuelve en clave financiera con BGG (ficha `bernanke-gertler`). Primera fila de `tab:teorias-ciclo` del 3.A.42: endógeno, de demanda, propagado por el acelerador; persistencia por la dinámica de la ecuación y por el techo y el suelo; estabilizar con la demanda.

**Gráfico de referencia:** `oposicion/temario/fuentes/3A42/graficos/multiplicador-acelerador.tex` (2 paneles: a la izquierda, el plano $(v,c)$ con la curva de estabilidad $cv=1$ y la de oscilación $c=4v/(1+v)^2$, que se tocan en $(1,1)$, y las 4 regiones rotuladas con una minitrayectoria en cada una; a la derecha, una trayectoria explosiva acotada por el techo de pleno empleo y el suelo de la inversión bruta nula). En el cante del 3.A.42 se dibuja el panel izquierdo; la ecuación `eq:samuelson` se recuadra a la derecha de la pizarra y se conserva hasta el final.

## Cómo se adapta en cada tema

| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.42 | Teorías del ciclo (tercera etapa) | desarrollo (hecho, 4/11/2026) | a)-d) completo, `eq:samuelson`, raíces, 4 regiones, ejemplo, techo y suelo de Hicks, nota del multiplicador de impacto | El principio de aceleración y el acelerador flexible (`\vertema{3.A.34}`) |
| 3.A.34 | Teorías de la inversión | mención (hecho, 31/10/2026) | En nota de I.2: la ecuación de Samuelson, $cv<1$, $c(1+v)^2<4v$ y Hicks en una línea; `\vertema{3.A.42}` | Las regiones y el ejemplo |
| 3.A.43 | Crecimiento | mención (hecho, 31/10/2026) | Harrod (1936) adapta la dinámica del acelerador a su teoría del crecimiento (1939), con la misma $v$ | El modelo |

## Divergencias encontradas en el temario actual

- Ninguna en los temas revisados: el 3.A.34 y el 3.A.42 usan la misma $v$, la misma ecuación y las mismas condiciones. El Word del 3.A.42 no tenía el modelo (solo una mención); el acelerador de Clark es de 1917, no de 1934 (corregido en el 3.A.42, C15).

Autor: Víctor Gutiérrez Marcos
