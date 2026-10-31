# Condición de Hosios (1990): eficiencia del equilibrio de búsqueda y emparejamiento

- **Área:** macro cerrada (mercado de trabajo) · **Tema de referencia:** **3.A.26** (revisado el 31/10/2026: resumen en el cuerpo, II.2 iii) «Eficiencia», con `\funcionclave` `eq:hosios`, y derivación en el anexo `anexo:hosios`) — es la pregunta de eficiencia del DMP, cuyo tema de referencia es este. Ficha creada en la fase canon del 3.A.26 (C4 de sus propuestas de coherencia; DK6/A26-06, **[decidir]**).
- **Temas que lo usan:** 3.A.26 (resumen en el cuerpo y desarrollo en el anexo C; hecho, 31/10/2026), 3.A.28 (mención; hecho, 31/10/2026: II.4 iii), «¿Es óptima? No tiene por qué», con $\gamma=\alpha$ escrita en el texto (sin `\funcionclave`), `Hosios1990Efficiency` y `\vertema{3.A.26}`; «natural» no quiere decir deseable; Farmer y los equilibrios múltiples, en la valoración de la NAIRU, III.3 d), como puente a la persistencia), 3.A.27 (mención opcional: la misma γ de la negociación de Nash decide si el paro de búsqueda es eficiente; hoy no la cita, y no hace falta).
- **Manuales de referencia:** Hosios (1990), «On the Efficiency of Matching and Related Models of Search and Unemployment», *Review of Economic Studies*; Pissarides (2000), cap. 8; Cahuc, Carcillo y Zylberberg (2014), cap. 9; Moen (1997), *JPE* (búsqueda dirigida); Farmer (2010), *Expectations, Employment and Prices*.

## Presentación de referencia (3.A.26, II.2 iii y anexo C)

Pregunta: ¿es eficiente el paro de equilibrio del DMP? Conclusión: en general no, por las externalidades de congestión; solo lo es si el poder negociador del trabajador iguala la elasticidad del emparejamiento respecto al paro. Pegatina del 3.A.26: «Ni tanto ni tan calvo».

- **En el cuerpo** (`\funcionclave` `eq:hosios`):
$$\gamma=\alpha$$
  con la notación de la ficha `dmp` ($m(U,V)=AU^{\alpha}V^{1-\alpha}$, γ poder negociador del trabajador en la Nash generalizada). Con γ > α, pocas vacantes y **demasiado** paro; con γ < α, demasiadas vacantes que se congestionan. Exige además que $z$ sea solo el valor del ocio (la prestación es una transferencia). Es una coincidencia de parámetros; la búsqueda dirigida a salarios anunciados la cumple sola (Moen, 1997). La tensión θ* se llama siempre **de equilibrio**, nunca «óptima».
- **Anexo C (planificador)**: maximiza la producción neta descontada
$$\max_{\{\theta_t\}}\int_0^\infty e^{-rt}\big[y(1-U_t)+zU_t-c\,\theta_tU_t\big]dt\quad\text{s.a.}\quad\dot U_t=s(1-U_t)-\theta_tq(\theta_t)U_t,\ U_0\ \text{dado},$$
  con el hamiltoniano en valor corriente y **$\lambda^U_t$, valor sombra de un parado más** (negativo); condición sobre el control $\lambda^U=-c/[(1-\alpha)q(\theta)]$; coestado en estado estacionario; resultado $(1-\alpha)(y-z)=c\,[(r+s)/q(\theta)+\alpha\theta]$, que es `eq:theta-equilibrio` con α en lugar de γ. Intuición: α mide la externalidad que la búsqueda de un parado impone a los demás parados y regala a las vacantes; γ, la parte de la renta que se lleva.
- **Valoración** (en el 3.A.26, II.6, 2 líneas): según Farmer (2010), la negociación de Nash cierra un modelo con mercados incompletos (sin *matchmaking firms*, en nota); sin ella hay equilibrios múltiples, que son materia del 3.A.28.

**Gráfico de referencia:** ninguno (en la pizarra, $\gamma=\alpha$ recuadrada a la derecha, con la pegatina). Vídeo complementario en la caja del anexo C del 3.A.26.

**Notación:** γ, α, $\lambda^U_t$ (superíndice $U$ porque el subíndice es el tiempo; los precios sombra del planificador del 3.A.22 llevan subíndice, $\lambda_U$, $\lambda_X$…, sin tiempo: no conviven), θ*, $q(\theta)$, $s$, $r$, $y$, $z$, $c$ (ficha `dmp`). Nunca μ para el multiplicador (μ es el margen).

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.26 | ¿Es eficiente el paro friccional? | resumen en el cuerpo y desarrollo en el anexo C (hecho, 31/10/2026) | γ = α recuadrada, los 2 casos, $z$ solo ocio, Moen; planificador con $\lambda^U$ en el anexo | — |
| 3.A.28 | Tasa natural de paro | mención (hecho, 31/10/2026) | La tasa natural del DMP, $U^n=s/[s+f(\theta^*)]$, no tiene por qué ser óptima: solo con $\gamma=\alpha$ (en el texto, con la misma notación); la crítica de Farmer (2010, 2013: *belief function*, equilibrios múltiples) en III.3 d), sin repetir la derivación ni las *matchmaking firms* | El planificador |
| 3.A.27 | Negociación salarial | mención (opcional) | El poder negociador γ que cierra el DMP decide si el paro es eficiente; remisión al 3.A.26 | Todo lo demás |

## Divergencias encontradas en el temario actual
- 3.A.26 original: Hosios en una nota con un vídeo; «grado de tensión óptimo, θ*» (marca roja P2); Farmer con una frase sobre la evidencia que no está en sus trabajos. **Resuelto** (31/10/2026): Hosios en el cuerpo con anexo; θ* de equilibrio; Farmer en 2 líneas.
- 3.A.28: repetía la crítica de Farmer con las mismas frases que el 3.A.26 original. **Resuelto** (31/10/2026): Hosios en II.4 y Farmer con los equilibrios múltiples en III.3 d), con las claves del 3.A.26 (`Farmer2010Expectations`, `Farmer2013Natural`).

Autor: Víctor Gutiérrez Marcos
