# Ciclos endógenos no lineales: Kalecki (1933, 1935), Kaldor (1940) y Goodwin (1967); ciclos endógenos de equilibrio

- **Área:** macro cerrada · **Tema de referencia:** **3.A.42** (teorías de los ciclos) — I.4.3, párrafo «El ciclo endógeno: Kalecki, Kaldor (1940) y Goodwin (1967)», de palabra, y el anexo D `anexo:endogenos` con las ecuaciones y los gráficos `kaldor-ciclo` y `goodwin-ciclo`; revisado el 4/11/2026. Es el único tema que los cuenta como teoría del ciclo. Ficha creada en la fase canon del 3.A.42 (CC3, A42-07, **[decidir]**: *alternativa*, ninguna ficha, porque solo este tema los desarrolla y los demás los citan de pasada). Recoge los ids `kaldor-ciclo`, `goodwin`, `goodwin-ciclo`, `kaldor-1940` y `ciclo-limite` (alias). Kalecki como autor está en `postkeynesianos` (alias `kalecki`): aquí solo su ciclo.
- **Temas que lo usan:** 3.A.42 (desarrollo en el anexo D y resumen en el cuerpo; hecho, 4/11/2026), 3.A.4 (mención; hecho, 4/11/2026: Kalecki, 1933 y 1935, y Kaldor en la ficha `postkeynesianos`; no cita a Goodwin, y el anexo D del 3.A.42 le remite la tradición de ciclo, crecimiento y reparto que siguen los postkeynesianos), 3.A.1 (mención; hecho, 4/11/2026: el caos determinista de Grandmont, 1985), 3.A.3 (mención; hecho, 4/11/2026: los *sunspot equilibria* de Azariadis, 1981, y Cass y Shell, 1983, frente a las manchas solares de Jevons). Relacionadas: `multiplicador-acelerador` (la versión lineal), `postkeynesianos`, `participacion-trabajo` (el reparto), `harrod-domar`.
- **Manuales de referencia:** Kalecki (1933, 1935) (`Kalecki1933Proba`, `Kalecki1935Macrodynamic`); Kaldor (1940), «A Model of the Trade Cycle», *EJ* (`Kaldor1940Model`); Chang y Smyth (1971), *REStud* (`ChangSmyth1971Existence`); Goodwin (1967), «A Growth Cycle» (`Goodwin1967Growth`); Benhabib y Nishimura (1979, 1985); Grandmont (1985), *Econometrica*; Farmer (2010); Gandolfo (2009), *Economic Dynamics*, caps. 25-26; Lavoie (2014), cap. 5.

## Presentación de referencia (3.A.42, I.4.3 y anexo D)

**Pregunta:** ¿puede una economía oscilar sola, sin perturbaciones ni parámetros exactos?

- **Idea común**: si las relaciones no son lineales, la economía cae en un **ciclo límite**, una oscilación que se mantiene sola; se basan en la relación entre clases y en el reparto de la renta. En el cuerpo del 3.A.42, **solo de palabra** (A42-12); las ecuaciones, en el anexo D.
- **Kalecki** (1933, 1935): la inversión se decide con retraso según los beneficios, y los beneficios dependen de la inversión (`\vertema{3.A.4}`).
- **Kaldor (1940)**: $I(Y_t,K_t)$ y $S(Y_t,K_t)$ en forma de S, $I_K<0$, $S_K>0$;
$$\dot Y_t=a\,[I(Y_t,K_t)-S(Y_t,K_t)],\qquad \dot K_t=I(Y_t,K_t)-\delta K_t,$$
  con **$a>0$ la velocidad de ajuste, local del anexo** (a sola es la CARA, § 2: no conviven). Con el capital dado, 3 cortes: el central inestable y los extremos estables; la acumulación en el equilibrio alto lo funde con el central y la economía salta al bajo, y al revés. Chang y Smyth (1971), con Poincaré-Bendixson: si el equilibrio central es inestable, hay **ciclo límite**. Valoración: se mantiene solo y su amplitud no depende de las condiciones iniciales; formas *ad hoc*, sin optimización ni dinero.
- **Goodwin (1967)**, tiempo continuo, letras **locales del anexo**: $\omega_t\equiv w_tL_t/Y_t$ participación de los salarios (en el 3.A.6, ω es el coeficiente de Lucas: no conviven), $U_t$ tasa de paro y $1-U_t$ la de empleo, **v** relación capital-producto fija (D009; Goodwin la llama σ), productividad que crece a **g** y población activa a **n** (D010), los capitalistas invierten todos los beneficios sin depreciación y $\gamma_w=f(U_t)$, $f'<0$ (Phillips real):
$$\gamma_{\omega}=f(U_t)-g,\qquad \gamma_{1-U}=\frac{1-\omega_t}{v}-(n+g),$$
  equilibrio $\omega^*=1-v\,(n+g)$ y $f(U^*)=g$; **órbitas cerradas** alrededor de él, en sentido antihorario en el plano $(1-U_t,\omega_t)$ (depredador-presa de Lotka y Volterra: el empleo es la presa y la participación de los salarios el depredador). Valoración: une ciclo, crecimiento y reparto; determinista, órbitas neutras (no ciclo límite: la amplitud depende de dónde se empieza) y frágil a cambios pequeños del modelo. **No confundir con Goodwin (1951)**, el acelerador no lineal (ficha `multiplicador-acelerador`).
- **Ciclos endógenos de equilibrio** (nota del 3.A.42): Benhabib y Nishimura (1979, 1985) y Grandmont (1985), ciclos deterministas en economías competitivas con agentes que optimizan; Farmer (2010), la confianza y los *sunspot equilibria* (Azariadis, 1981; Cass y Shell, 1983) como origen del ciclo; en la conclusión, la economía de Farmer como «un barco sin ancla».
- **En `tab:teorias-ciclo`**: endógeno, real; propagación por la inversión y el reparto; persistencia por el ciclo límite o las órbitas cerradas; estabilizar: discutido.

**Gráficos de referencia:** `oposicion/temario/fuentes/3A42/graficos/kaldor-ciclo.tex` (I y S en forma de S con los 3 cortes y su desplazamiento al acumularse capital) y `goodwin-ciclo.tex` (plano $(1-U,\omega)$ con las órbitas cerradas y el sentido de giro). Apoyo: en el cante del 3.A.42 no se dibujan.

## Cómo se adapta en cada tema

| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.42 | Teorías del ciclo (tercera etapa) | resumen en el cuerpo y desarrollo en el anexo D (hecho, 4/11/2026) | Kalecki, Kaldor y Goodwin de palabra; ecuaciones, Chang y Smyth y gráficos en el anexo; los de equilibrio en nota | Kalecki como economista (`\vertema{3.A.4}`) |
| 3.A.4 | Keynes y los postkeynesianos | mención (hecho, 4/11/2026) | Kalecki (demanda efectiva, beneficios e inversión) y Kaldor en la escuela; Goodwin, si se cita, con la tradición de ciclo, crecimiento y reparto | Las ecuaciones del ciclo |
| 3.A.1 | Métodos de la ciencia económica | mención (hecho, 4/11/2026) | El caos determinista de Grandmont (1985) | — |
| 3.A.3 | Neoclásicos | mención (hecho, 4/11/2026) | Las manchas solares de Jevons no son los *sunspot equilibria* | — |

## Divergencias encontradas en el temario actual

- **Word del 3.A.42** (corregido el 4/11/2026): atribuía a Goodwin (1951) el ciclo de lucha de clases, que es Goodwin (1967); el de 1951 es el acelerador no lineal (K5). «Benhavid» por Benhabib (V33).

Autor: Víctor Gutiérrez Marcos
