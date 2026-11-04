# Modelo de búsqueda y emparejamiento de Diamond, Mortensen y Pissarides (DMP)

- **Área:** macro cerrada · **Tema de referencia:** **3.A.26** (desempleo friccional, curva de Beveridge, DMP; **revisado el 31/10/2026**, bloque II `sec:dmp`, 13′30″, con II.2 `sec:dmp-modelo`, II.3 `sec:beveridge` y los anexos `anexo:dmp-derivacion` y `anexo:hosios`) — lo tiene en el título.
- **Temas que lo usan:** 3.A.26 (desarrollo; hecho, 31/10/2026), 3.A.28 (resumen; hecho, 31/10/2026: II.4 `sec:busqueda-natural`, 1′30″, con $U^n=s/[s+f(\theta^*)]$, `eq:tasa-natural-flujos`, «es el paro de equilibrio $U^*$ del modelo de búsqueda»), 3.A.7 (mención; hecho, 4/11/2026: II.2 iii, la NEK con desempleo de Blanchard y Galí, 2010, con `\vertema{3.A.26}`; ficha `nek-desempleo`), 3.A.42 (hecho, 4/11/2026, ver la tabla; mención: Blanchard y Galí, 2010; puzle de Shimer), 4.A.16 (mención aplicada, con la ficha `curva-beveridge`), 1D01 (mención: III.1, curva de Beveridge; hecho, 24/10/2026), 3.A.27 (mención; hecho, 31/10/2026: I.3, la curva salarial $w=(1-\gamma)z+\gamma(y+c\,\theta)$, `eq:curva-salarial-dmp`, con la **misma γ** (poder del trabajador) y el **mismo $z$** (valor del desempleo, $w^R=z$) que su negociación colectiva; con γ = 0, el salario de reserva; Nobel de 2010 en nota; Hall, 2005, en la conclusión).
- **Fichas que salen de aquí:** `curva-beveridge` (la ecuación 3 y su lectura), `hosios` (la eficiencia), `mccall` (la búsqueda de un solo lado, que lleva al DMP por la paradoja de Diamond), `nash-negociacion` (la solución que cierra el modelo).
- **Manuales de referencia:** Pissarides, *Equilibrium Unemployment Theory* (2.ª ed., 2000), cap. 1; Cahuc, Carcillo y Zylberberg (2014), cap. 9; Romer (2019), cap. 11; Petrongolo y Pissarides (2001), *JEL*; Shimer (2005), *AER*; Mortensen y Pissarides (1994), *RES*.
- **Decisión D008 (13/10/2026):** ¿Se reserva δ para la tasa de depreciación y se cambian sus otros usos? Sí: pendiente de la NKPC κ, tasa de separación s (DMP y Shapiro-Stiglitz) y tasa social de descuento r_s (4.B.6); δ solo depreciación (y el factor exponencial del modelo β-δ de Laibson)
- **Decisión D020 (13/10/2026):** ¿Se reserva λ para multiplicadores y precios sombra? Sí: factor de escala t (3.A.11), tasas de búsqueda f(θ) y q(θ) (DMP), persistencia de la histéresis λ_h con subíndice; se admite λ local en Laffont-Tirole (coste de los fondos públicos) y en Kahneman-Tversky
- **Decisión D023 (13/10/2026):** ¿Se reserva M para el dinero (y las importaciones) y se cambian sus otros usos? Sí: número de variedades de Romer (1990) N_t, función de emparejamiento m(U,V), renta no laboral W̄
- **Decisión D056 (13/10/2026):** ¿Se mantiene θ ≡ V/U para la tensión del mercado de trabajo aunque θ sea la CRRA? Sí, avisándolo: es la notación universal de la búsqueda (Pissarides, Cahuc) y 3.A.26 y 3.A.28 no usan la CRRA
- **3.A.26 (31/10/2026), [decidir]:** valores de Bellman $V_{\mathrm E}$, $V_{\mathrm U}$, $J_{\mathrm O}$, $J_{\mathrm V}$ (DK3/A26-03), como Shapiro-Stiglitz del 3.A.27; la curva de Beveridge en un epígrafe propio tras el modelo (DK1/A26-01); Hosios en el cuerpo con anexo y Farmer en 2 líneas (DK6/A26-06).

## Presentación de referencia (3.A.26, II)

Pregunta: ¿por qué hay paro y vacantes a la vez en equilibrio? Conclusión: porque encontrarse lleva tiempo; la curva salarial y la creación de empleo fijan la tensión, y la curva de Beveridge da el paro y las vacantes de equilibrio; ese paro es friccional y solo es eficiente con Hosios. Enganche del 3.A.26: «Cada oveja con su pareja».

- **a) Idea** (II.1): búsqueda a los 2 lados del mercado; anuncio de la curva de Beveridge; Nobel de 2010.
- **b) Modelo** (II.2). i) **Supuestos**: población activa constante y **normalizada a 1** ($U$ tasa de paro, $V$ tasa de vacantes, $1-U$ empleo; gráfico `flujos-dmp.tex`); función de emparejamiento Cobb-Douglas con rendimientos constantes (`\funcionclave` `eq:emparejamiento`), $A$ eficiencia del emparejamiento y α elasticidad respecto al paro (Petrongolo y Pissarides, 2001: α entre 0,5 y 0,7), una «caja negra»; tensión θ ≡ V/U (con la nota «θ no es aquí la aversión al riesgo»); separaciones a la tasa exógena $s$; empresas: el puesto ocupado produce $y$, la vacante cuesta $c$ por unidad de tiempo, **libre entrada**; trabajadores neutrales al riesgo que descuentan a $r$; el parado obtiene $z$ (prestación y ocio); salario por **Nash generalizada** con poder γ (3.A.14).
$$m(U,V)=A\,U^{\alpha}V^{1-\alpha},\ 0<\alpha<1;\qquad f(\theta)=\frac{m}{U}=A\theta^{1-\alpha},\quad q(\theta)=\frac{m}{V}=A\theta^{-\alpha},\quad f(\theta)=\theta q(\theta)\ \ (\texttt{eq:tasas-busqueda})$$
  ii) **Desarrollo**: dinámica del paro $\dot U=s(1-U)-f(\theta)U$ (`eq:dinamica-paro`); valores de Bellman (`eq:valores-dmp`; nota: rendimiento de un activo, 3.A.29):
$$rV_{\mathrm E}=w-s(V_{\mathrm E}-V_{\mathrm U}),\quad rV_{\mathrm U}=z+f(\theta)(V_{\mathrm E}-V_{\mathrm U}),\quad rJ_{\mathrm O}=y-w-s(J_{\mathrm O}-J_{\mathrm V}),\quad rJ_{\mathrm V}=-c+q(\theta)(J_{\mathrm O}-J_{\mathrm V});$$
  negociación: excedente $S\equiv(V_{\mathrm E}-V_{\mathrm U})+(J_{\mathrm O}-J_{\mathrm V})$, $\max_w(V_{\mathrm E}-V_{\mathrm U})^{\gamma}(J_{\mathrm O}-J_{\mathrm V})^{1-\gamma}$ ⇒ $V_{\mathrm E}-V_{\mathrm U}=\gamma S$. **3 ecuaciones** (`tab:ecuaciones-dmp`):
  1. **Curva salarial** (`\funcionclave` `eq:curva-salarial-dmp`, **la misma que el 3.A.27**, con la misma γ y $z$), recta creciente en $(\theta,w)$; no depende de $r$, $s$ ni $A$:
$$w=(1-\gamma)\,z+\gamma\,(y+c\,\theta)$$
  2. **Creación de empleo** (`\funcionclave` `eq:creacion-empleo`), decreciente en $(\theta,w)$:
$$\frac{c}{q(\theta)}=\frac{y-w}{r+s}$$
  3. **Curva de Beveridge** (`\funcionclave` `eq:beveridge`), decreciente y convexa en $(U,V)$ (ficha `curva-beveridge`):
$$U=\frac{s}{s+f(\theta)}$$
  Equilibrio (`eq:theta-equilibrio`), con θ* único si $y>z$:
$$(1-\gamma)(y-z)=c\left[\frac{r+s}{q(\theta^*)}+\gamma\theta^*\right];$$
  el rayo $V=\theta^*U$ corta la curva $B_0$ en $U^*$, $V^*$: el modelo se resuelve **en cascada**. iii) **Implicaciones**: estática comparativa verificada (`tab:estatica-dmp`, abajo; `dmp-estatica.tex`); política (políticas activas = ↑A; prestación y poder negociador suben $w$ y el paro por la negociación, no porque se busque menos); **eficiencia**: θ* es la tensión **de equilibrio**, no la óptima; externalidades de congestión; Hosios γ = α (ficha `hosios`).
- **c) Evidencia** (II.4): Petrongolo y Pissarides (2001); el paro sigue a $s/(s+f)$ (Rogerson, Shimer y Wright, 2005; con los flujos de la EPA de 2025, $f$ = 26,8 % y $s$ = 2,6 % trimestrales dan un 8,8 % frente al 10,5 % observado); **puzle de Shimer** (2005): la ratio V/U es casi 20 veces más volátil que la productividad; «efecto macro» de las prestaciones (Hagedorn *et al.*, 2013).
- **d) Extensiones** (II.5): destrucción endógena (Mortensen y Pissarides, 1994); respuestas al puzle de Shimer (salarios rígidos de Hall, 2005, y Hall y Milgrom, 2008; excedente pequeño de Hagedorn y Manovskii, 2008, y Ljungqvist y Sargent, 2017; racionamiento de Michaillat, 2012); el DMP en la NEK (**Blanchard y Galí, 2010**, *AEJ: Macro*, no 2005); paro eficiente de Michaillat y Saez (2021), $\sqrt{UV}$.
- **e) Valoración** (II.6): paro friccional de equilibrio y microfundamento de la tasa natural $U^*=s/[s+f(\theta^*)]$, que en el 3.A.28 se escribe $U^n$ (el asterisco es el valor de equilibrio del modelo; en la macro la tasa natural es $U^n$: `notacion.md` § 0 y § 6, A28-11); **ni voluntario (McCall) ni involuntario** en el sentido de racionamiento: friccional y de equilibrio; límites (Shimer, caja negra, Farmer en 2 líneas con las *matchmaking firms* en nota, paro de larga duración, separaciones exógenas frente a la volatilidad de la destrucción, Davis y Haltiwanger, 1992) → puente a los costes de ajuste.
- **Anexo B** (7 pasos): reparto de Nash, $w=(1-\gamma)rV_{\mathrm U}+\gamma y$, $rV_{\mathrm U}=z+\frac{\gamma}{1-\gamma}c\theta$, curva salarial, tensión de equilibrio, estática comparativa de θ* y $w^*$ (con ↑c, $w^*$ baja), emparejamientos con ↑s (suben si α ≥ ½ y $U$ < ½).

**Estática comparativa de referencia** (`tab:estatica-dmp`; en estado estacionario $m=s(1-U)$):

| Perturbación | V | U | θ | w | m | 1/f(θ) | 1/q(θ) |
|---|---|---|---|---|---|---|---|
| *A lo largo de la curva de Beveridge* | | | | | | | |
| ↑y productividad | ↑ | ↓ | ↑ | ↑ | ↑ | ↓ | ↑ |
| ↑z valor del desempleo | ↓ | ↑ | ↓ | ↑ | ↓ | ↑ | ↓ |
| ↑γ poder negociador | ↓ | ↑ | ↓ | ↑ | ↓ | ↑ | ↓ |
| ↑c coste de la vacante | ↓ | ↑ | ↓ | ↓ | ↓ | ↑ | ↓ |
| ↑r tipo de interés | ↓ | ↑ | ↓ | ↓ | ↓ | ↑ | ↓ |
| *Desplazan la curva de Beveridge* | | | | | | | |
| ↑A eficiencia del emparejamiento | ? | ↓ | ↑ | ↑ | ↑ | ↓ | ↓ |
| ↑s tasa de separación | ? | ↑ | ↓ | ↓ | ?* | ↑ | ↓ |

\* Ambiguo en general; sube si α ≥ ½ y $U$ < ½ (anexo B). En el gráfico `dmp-estatica.tex` se dibujan ↑y (a lo largo) y ↓A (la curva se aleja de $B_0$ a $B_1$).

**Gráficos de referencia** (`oposicion/temario/fuentes/3A26/graficos/`): `dmp-equilibrio.tex` (**imprescindible**, el central del bloque: 2 paneles, $(\theta,w)$ con la curva salarial creciente y la de creación de empleo decreciente, y $(U,V)$ con la curva de Beveridge $B_0$ y el rayo $V=\theta^*U$; por capas: curva salarial → creación de empleo → $(\theta^*,w^*)$ → Beveridge → rayo → $(U^*,V^*)$), `flujos-dmp.tex` (diagrama de flujos ocupados ⇄ parados con $s(1-U)$ y $f(\theta)U$, rápido, estilo `estados-ss` del 3.A.27), `dmp-estatica.tex` (2 capas más sobre los mismos paneles) y `beveridge-lectura.tex` (estado final del panel $(U,V)$; ficha `curva-beveridge`).

**Notación** (`notacion.md` § 6): $m(U,V)$, $A$, α, θ ≡ V/U, $f(\theta)$, $q(\theta)$ **siempre con argumento** (en el 3.A.27, $q$ sin argumento es la tasa de detección de Shapiro-Stiglitz y $q_t$ la q de Tobin), $s$, $y$, $c$, $z$, γ, $r$ (tiempo continuo; ρ en Shapiro-Stiglitz, que no convive), $V_{\mathrm E}$, $V_{\mathrm U}$, $J_{\mathrm O}$, $J_{\mathrm V}$, $S$ excedente (local), θ*, $w^*$, $U^*$, $V^*$ valores **de equilibrio**, $B_0$, $B_1$ rótulos de la curva. Nunca $M$, λ(θ), μ(θ), δ, $p$, $G$, $E$, $D$, $O$, $I$ («inocupado»).

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.26 | Paro friccional; curva de Beveridge | desarrollo (hecho, 31/10/2026) | Todo lo anterior | — |
| 3.A.28 | Tasa natural de paro y su persistencia | resumen (hecho, 31/10/2026) | II.4 (estaba vacío): supuestos ($s$, $f(\theta)$, θ ≡ V/U con el aviso de la CRRA y de que $f(\theta)$ no es la $f(U)$ de Lipsey), $\dot U=s(1-U)-f(\theta)U$ y la tasa natural como resultado de flujos $U^n=s/[s+f(\theta^*)]$; los desplazamientos de la curva de Beveridge como cambios de la tasa natural; Hosios: no tiene por qué ser óptima; Farmer con los equilibrios múltiples y la histéresis (allí, no en el 3.A.26) ; ejemplo numérico ($0{,}02/0{,}32\approx6{,}3~\%$); el $U^*$ del modelo es $U^n$, dicho una vez | La curva salarial y su derivación (`\vertema{3.A.26}`) |
| 3.A.7 | Fricciones en el mercado de trabajo en la NEK | mención (hecho, 4/11/2026) | Fuente de rigidez real en los EGDE con desempleo: **Blanchard y Galí (2010)**, *AEJ: Macroeconomics*, separado de Blanchard y Galí (2007), *JMCB*, salarios reales rígidos sin búsqueda; mercados escleróticos; ficha `nek-desempleo` | Ecuaciones del DMP |
| 3.A.42 | Ciclos reales y modelos de ciclo | mención (hecho, 4/11/2026; II.2.2 iii), las fricciones de búsqueda rompen la divina coincidencia, Blanchard y Galí, 2010, `\vertema{3.A.26}`; sin el puzle de Shimer) | El DMP en los modelos de ciclo y el puzle de Shimer; Blanchard y Galí (2010) | Ecuaciones |
| 3.A.27 | Negociación salarial en la macro | mención (hecho, 31/10/2026) | La curva salarial de Nash con la misma γ y $z$ que la negociación colectiva (ficha `sindicato-monopolista`); remisión al 3.A.26 | La creación de empleo y la Beveridge |
| 4.A.16 | Mercado de trabajo en España | mención aplicada | La curva de Beveridge española con la ficha `curva-beveridge`; flujos de la EPA ($s$ y $f$); remisión al 3.A.26 solo para ampliar | El modelo |
| 1D01 | Dictamen de coyuntura | mención (hecho, 24/10/2026) | Movimientos a lo largo = ciclo; desplazamiento hacia fuera = peor emparejamiento; en datos, tasa de vacantes frente a tasa de paro (decirlo) | El modelo |

## Divergencias encontradas en el temario actual
- 3.A.26 original: δ para la separación, λ(θ) y μ(θ), $M=AU^{\alpha}V^{\beta}$, $E$, $D$, $O$, $I$, $p$, $G$, «condición salarial» sin fórmula y dibujada convexa, θ* «óptimo», estática comparativa contradictoria (↑A «rota hacia abajo», ↑c «indeterminado», ↑r moviendo la curva salarial), axiomas de Nash en la nota 32. **Resuelto** en la revisión (31/10/2026).
- 3.A.26 revisado: en II.5, la tasa eficiente de Michaillat y Saez se escribe también $U^*=\sqrt{UV}$, mientras $U^*$ es en todo el tema el paro **de equilibrio** (`notacion.md` § 6, **[decidir]**: letra propia para el eficiente).
- 3.A.42 (**resuelto** el 4/11/2026: `BlanchardGali2010Labor` con `\vertema{3.A.26}`): citaba «Blanchard y Galí (2005)» para el modelo NEK con búsqueda: es **Blanchard y Galí (2010)** (`BlanchardGali2010Labor`). En el 3.A.7, **resuelto** al revisarlo (4/11/2026), con el de 2007 separado (ficha `nek-desempleo`).
- 3.A.28: su 2.4 «Microfundamentación de la tasa natural de paro: modelos de búsqueda» estaba vacío y repetía la crítica de Farmer. **Resuelto** (31/10/2026).
- 4.A.16 (sin revisar): copia la evidencia española antigua del 3.A.26 (ficha `curva-beveridge`).

Autor: Víctor Gutiérrez Marcos
