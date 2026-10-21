# Precios de Ramsey-Boiteux

- **Área:** mercados-información-juegos · **Tema de referencia:** 3.A.17 (regulación del monopolio natural; revisado el 17/10/2026, II.2.3 y anexo `anexo:ramsey`) — único que lo desarrolla. Es la misma regla que la imposición óptima de Ramsey (4.B.11, id `ramsey`): el 3.A.17 remite a 4.B.11 solo para ampliar (D138). Se queda en el 3.A.17 aunque la regulación con información asimétrica pase al 3.A.20 (P21-02, Víctor, 21/10/2026).
- **Temas que lo usan:** 3.A.17 (desarrollo; hecho, 17/10/2026), 4.B.15 (resumen; hoy mención con ecuaciones), 4.B.11 (mención: equivalencia formal con la regla de Ramsey); 3.A.22 (mención; hecho, 21/10/2026).
- **Manuales de referencia:** Ramsey (1927); Boiteux (1956); Baumol y Bradford (1970); Laffont y Tirole (1993), cap. 3; Viscusi, Harrington y Vernon, cap. 11.

## Presentación de referencia (3.A.17)
Pregunta: ¿qué precios fijar a un monopolio natural multiproducto que debe cubrir costes sin subvención?
Supuestos: demandas independientes q_i(p_i); regulador benevolente e informado; maximiza el excedente total sujeto a beneficio no negativo (segundo óptimo, *second best*: 3.A.22).
$$\max_{\vec p}\ \mathrm{ET}(\vec p)=\mathrm{EC}(\vec p)+B(\vec p)\quad\text{s.a.}\quad B(\vec p)\ge 0\ \ \Rightarrow\ \ \frac{p_i-\mathrm{CMg}_i}{p_i}=\frac{\lambda}{1+\lambda}\cdot\frac{1}{|\varepsilon_{q_i,p_i}|}\quad\forall i$$
con λ el multiplicador de la restricción presupuestaria: el bienestar que se ganaría si se exigiera un euro menos de beneficio.
- **Derivación** (anexo B): problema penalizado EC(p⃗) + (1+λ)B(p⃗), **sin lagrangiana 𝓛** (𝓛 es el índice de Lerner, `notacion.md` § 0), con ∂EC/∂p_i = −q_i y ∂B/∂p_i = q_i + (p_i − CMg_i)q_i'; CPO (1+λ)(p_i − CMg_i)q_i' = −λq_i.
- **Interpretación (sentido correcto de λ)**: es la **regla de Lerner amortiguada**. El número de Ramsey λ/(1+λ) ∈ [0,1) **crece** con λ: si la restricción no aprieta (λ = 0), p_i = CMg_i; cuanto más aprieta (más coste fijo que cubrir), **mayores** los márgenes; si apretara sin límite (λ → ∞), cada precio sería el de monopolio, 𝓛_i = 1/|ε_{q_i,p_i}|. Entre ambos, el regulador recarga más los bienes de demanda menos elástica, como el monopolista que discrimina en 3.er grado (ficha `discriminacion-precios`), pero solo lo justo para cubrir costes. 𝓛_i/𝓛_j = |ε_{q_j,p_j}|/|ε_{q_i,p_i}|.
- **Misma λ que Laffont-Tirole**: con transferencias públicas que cuestan 1 + λ, la regla es la misma con λ el coste sombra de los fondos públicos (Laffont y Tirole, 1993, cap. 3); por eso el 3.A.17 usa la misma letra en los 2 casos, con una nota.
- **Demandas dependientes** (anexo A del 3.A.17): cuentan las elasticidades cruzadas, como en el monopolio multiproducto (sustitutivos, precios mayores; complementarios, uno puede quedar por debajo del CMg, sin ser sostenible si hay subsidios cruzados).
- **Valoración**: exige conocer costes y elasticidades; puede ser regresiva (los bienes de demanda inelástica pesan más en los hogares de menos renta).

Gráfico: no tiene uno propio; en la pizarra, la regla junto a la `\funcionclave` de Lerner (hilo conductor del 3.A.17).

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.17 | Regulación *second best* del monopolio natural | desarrollo (hecho, 17/10/2026) | Programa con `\optim`, regla, interpretación como Lerner amortiguado y enlace con el 3.er grado; derivación en el anexo B; dependientes en el anexo A | — |
| 4.B.15 | Precios públicos | resumen (hoy mención; D139 (13/10/2026)) | Regla con \|ε_{q_i,p_i}\| y su interpretación (margen inverso a la elasticidad, λ/(1+λ) creciente en λ), remitiendo a 3.A.17 | Derivación |
| 4.B.11 | Imposición óptima | mención | Equivalencia formal con la regla de Ramsey | — |
| 3.A.22 | *Second best* (aplicaciones) | mención (hecho, 21/10/2026) | Los precios de Ramsey-Boiteux de un monopolio natural que debe cubrir sus costes, segundo óptimo con presupuesto equilibrado; `\vertema{3.A.17}` | La regla |

## Divergencias encontradas en el temario actual
- 3.A.17 original: W(P) para el bienestar, «Ramsey-Boiteaux (1927)», P_i y, sobre todo, «**cuanto mayor sea λ menor será el margen**», que es al revés. **Resuelto** (17/10/2026): ET(p⃗), Ramsey (1927) y Boiteux (1956), p_i, y el margen crece con λ.
- Elasticidad: canon **|ε_{q_i,p_i}|** con dos subíndices (la ficha decía |ε_i|; 4.B.15 ya la escribe así, pero con P mayúscula: canon p_i).
- 4.B.15 (sin revisar): comprobar el sentido de λ al revisarlo.

Autor: Víctor Gutiérrez Marcos
