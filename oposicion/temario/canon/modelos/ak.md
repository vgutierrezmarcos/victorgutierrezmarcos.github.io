# Modelo AK (Rebelo 1991)

- **Área:** macro cerrada · **Tema de referencia:** **3.A.44** (crecimiento endógeno: rendimientos crecientes) — es el único tema que lo desarrolla, con a)-e) en I.2.1 (`sec:ak`, 2′30″ en el cante) y el anexo A con hogares (`anexo:ak-barro`); revisado el 1/11/2026. Ficha creada en la fase canon del 3.A.44 (CC1 de sus propuestas de coherencia; **[decidir]**: Víctor está fuera hasta el 9/11). **Id `ak`** (ya estaba en `mapa.yaml`, `alias.json` y `areas.json`); alias `ak-rebelo` y `modelo-ak`.
- **Temas que lo usan:** 3.A.44 (desarrollo; hecho, 1/11/2026), 3.A.43 (mención; hecho, 31/10/2026: II.2 «Hacia el crecimiento endógeno», versión con ahorro exógeno $\gamma_{Y/L}=sA-(n+\delta)$), 3.A.38 (resumen; hecho, 5/11/2026: III.2 `sec:impuestos-crecimiento`, Rebelo con $\tau_K$ en `eq:rebelo`, frente al nivel de `eq:euler-tauk`; Barro, 1990, como $AK$ con gasto público, ficha `barro-1990`), 3.B.28 (mención; hecho, 3/11/2026: III.1, $\gamma_{Y/L}=sA-(n+\delta)$ con ahorro exógeno, la del 3.A.43, Rebelo, 1991, y `\vertema{3.A.44}`; paradoja de Lucas, 1990), 3.B.9 (mención: el $AK$ en economía abierta)
- **Manuales de referencia:** Rebelo (1991), *JPE*; Knight (1944); Barro y Sala-i-Martin (2004), cap. 4; Sala-i-Martín (2000), cap. 3; Acemoglu (2009), cap. 11; Romer (2019), cap. 3; Saint-Paul (1992), *REStud*; Jones (1995), *QJE*.

## Presentación de referencia (3.A.44, I.2.1 y anexo A)

**a) Idea.** ¿Qué pasa si el capital no tiene rendimientos decrecientes? El cambio más pequeño respecto a Solow: todo igual salvo la función de producción, lineal en el capital,
$$Y_t=A\,K_t,\qquad A>0\ \text{constante}\qquad(\texttt{eq:ak})$$
con **$K$ en sentido amplio** (físico, humano, conocimiento; la idea es de Knight, 1944). **$A$ no es progreso técnico**: es una constante; la economía crece solo acumulando. Nota: en $Y=AK$ el salario es nulo; con aprendizaje por la práctica ($Y_j=K_j^{\alpha}(QL_j)^{1-\alpha}$, $Q=K/L$) se obtiene un $AK$ con $A=1$ y salario positivo (ficha `arrow-romer-spillovers`).

**b) i) Supuestos.** *Lo que se mantiene*: los de Solow (`\vertema{3.A.43}`): economía cerrada sin sector público, un bien, competencia perfecta, población = empleo a la tasa n, depreciación δ. *Lo que cambia*: la función de producción, que levanta los productos marginales decrecientes y las condiciones de Inada sobre el producto marginal (`tab:supuestos-neoclasicos`); $r+\delta=A$ y el capital se lleva toda la renta. *2 versiones del ahorro*: tasa constante $s$ (lectura gráfica) y hogares de Ramsey (**versión de referencia**).

**b) ii) Desarrollo.** Variables por trabajador sin marca, $k\equiv K/L$ (sin progreso técnico exógeno, coinciden con las del 3.A.43).
- Con ahorro constante:
$$\dot k_t=s\,A\,k_t-(n+\delta)\,k_t\;\Longrightarrow\;\gamma_k=\gamma_y=s\,A-(n+\delta)\qquad(\texttt{eq:ak-solow})$$
  En el gráfico en tasas, la curva de ahorro $sA$ es horizontal, como la de depreciación $n+\delta$; la distancia es la tasa de crecimiento, la misma para cualquier $k$.
- Con hogares que optimizan, $r=A-\delta$ y la Euler `eq:euler-endogeno`:
$$\gamma_c=\gamma_k=\gamma_y=\frac{A-\delta-\rho}{\theta}\qquad(\texttt{eq:ak-ramsey})$$
  con $A-\delta>\rho$ y ρ − n > (1 − θ)γ; $c/k=A-\delta-n-\gamma$ constante desde el principio (salta a la senda equilibrada); $s=(\gamma+n+\delta)/A$ constante y endógena (anexo A); se cumple el 1TFEB (`\vertema{3.A.22}`). Pizarra: «$AK$: $r=A-\delta$».
- Tesis de Rebelo (1991): un impuesto sobre las rentas del capital $\tau_K$ da $\gamma=[(1-\tau_K)A-\delta-\rho]/\theta$: diferencias de política fiscal, diferencias persistentes de crecimiento.

**b) iii) Implicaciones** (frente a Solow, `tab:ak-solow`, 6 filas): crecimiento endógeno sin variable exógena; la política (s o ρ y θ, A, n, δ) cambia la **tasa** para siempre («quien guarda, halla»); sin dinámica de transición; **sin convergencia** ni absoluta ni condicional (`\vertema{3.A.45}`); los choques son permanentes (pérdida de nivel); **sin ineficiencia dinámica** (Saint-Paul, 1992): con hogares $r-\gamma_Y=c/k>0$; con s constante, $\gamma_Y=sA-\delta<A-\delta=r$.

**c) Extensiones.** Rebelo: basta un núcleo de bienes de capital que se produzca solo con bienes de capital; el gasto público productivo (`barro-1990`), las externalidades (`arrow-romer-spillovers`) y el capital humano (`uzawa-lucas`) son formas de llegar a un $AK$ desde supuestos más realistas; su versión asintótica es el `sobelow`.

**d) Evidencia.** Jones (1995, *QJE*): las tasas de inversión subieron en la OCDE de posguerra sin tendencia al alza del crecimiento; Easterly et al. (1993): las tasas de crecimiento son poco persistentes y las características de los países, mucho; convergencia condicional al ≈ 2 % (Barro y Sala-i-Martin, 1992).

**e) Valoración.** A favor: la forma más sencilla de crecimiento endógeno y la forma reducida de casi todos los de 1.ª generación. En contra: **filo de la navaja** (exponente exactamente 1; Solow, 1994); salario nulo y participación del capital 1 (en las variantes con trabajo tiende a 1, contra Kaldor, `\vertema{3.A.43}`); no explica el progreso técnico ni la convergencia condicional. Nexo: Sobelow.

**Gráfico de referencia:** `oposicion/temario/fuentes/3A44/graficos/tasas-endogeno.tex`: en niveles (izquierda) y en tasas frente a Solow (derecha: Solow discontinua decreciente, $sA$ horizontal, $n+\delta$ horizontal, capa de subida a $s'A$); es el gráfico por capas del cante (se le añaden Sobelow y las externalidades). Tabla `tab:ak-solow`.

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.44 | Crecimiento endógeno: rendimientos no decrecientes | desarrollo (hecho, 1/11/2026) | Lo de arriba: 2 versiones del ahorro (la de hogares, de referencia), `tab:ak-solow`, Saint-Paul, Rebelo con $\tau_K$ | — |
| 3.A.43 | Puente al crecimiento endógeno | mención (hecho, 31/10/2026) | Versión con ahorro exógeno, $\gamma_{Y/L}=sA-(n+\delta)$ (la misma que `eq:ak-solow`, con $y=Y/L$) | El modelo `\vertema{3.A.44}` |
| 3.A.38 | Política fiscal y crecimiento | resumen (hecho, 5/11/2026) | III.2: con un $AK$ (Rebelo, 1991, `\vertema{3.A.44}`), un impuesto $\tau_K$ sobre las rentas del capital (toda la renta lo es) baja la tasa para siempre, **`eq:rebelo`** $\gamma=[(1-\tau_K)A-\delta-\rho]/\theta$, la misma de arriba; «nivel frente a tasa» con `eq:euler-tauk` del RCK (II.1; ficha `chamley-judd`); Barro (1990) en III.1 | El modelo `\vertema{3.A.44}` |
| 3.B.28 | Teorías del desarrollo | mención (hecho, 3/11/2026) | III.1: el $AK$ con ahorro exógeno, $\gamma_{Y/L}=sA-(n+\delta)$, y las 2 ideas que los teóricos del desarrollo adelantaron (la convergencia no está garantizada; el equilibrio no es eficiente); la paradoja de Lucas (1990) en nota | El modelo |
| 3.B.9 | Comercio y crecimiento | mención | Efectos de la apertura sobre la tasa en un $AK$ | El modelo |

## Divergencias encontradas en el temario actual
- 3.A.44 (Word): los supuestos del $AK$ eran párrafos copiados del Solow («la tecnología es un bien público», $A_t$ como variable), ley de movimiento que mezclaba tiempo discreto y continuo, «la tasa de ahorro y siempre inferior a 1», «la fracción de renta del capital aumentará hasta 1» (en $Y=AK$ es 1 siempre). **Resuelto** (1/11/2026).
- El 3.A.43 da la versión con ahorro exógeno y el 3.A.44 las 2: dicho en las 2 fichas (contradicción del 3.A.43 sobre el 3.A.44, resuelta).
- Test de 2021 con un $AK$ con «$g_A=4\,\%$» que parece mal planteado (A44-12; para Víctor).

Autor: Víctor Gutiérrez Marcos
