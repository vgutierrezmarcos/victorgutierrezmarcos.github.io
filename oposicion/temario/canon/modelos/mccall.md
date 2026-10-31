# Búsqueda de empleo: Stigler (1961-1962) y McCall (1970), el salario de reserva

- **Área:** macro cerrada (mercado de trabajo) · **Tema de referencia:** **3.A.26** (desempleo friccional; revisado el 31/10/2026, I.2 `sec:stigler`, I.3 `sec:mccall` y anexo `anexo:busqueda-extensiones`) — es el único tema que desarrolla la búsqueda de primera generación, como puerta de entrada al DMP («Modelos de búsqueda» es el bloque I del tema). Ficha creada en la fase canon del 3.A.26 (C3 de sus propuestas de coherencia; **[decidir]**).
- **Temas que lo usan:** 3.A.26 (desarrollo breve; hecho, 31/10/2026: 5′ con Stigler en 0′30″ y McCall en 4′; el resto, anexo A), 4.A.16 (mención: prestaciones y duración del paro en España, remitiendo aquí), 3.A.28 (mención; hecho, 31/10/2026: II.4 a), el paro de búsqueda como fundamento de la tasa natural con Phelps, 1968 y 1970, «buscar empleo lleva tiempo», sin nombrar a McCall; el modelo de flujos es el DMP). Relación de concepto (sin usar el modelo): el $w^R$ del 3.A.25 (umbral de participación) y el $w^R=z$ del 3.A.27 (negociación) son el mismo salario de reserva, sin el valor de opción de buscar (ver «Presentación», iii).
- **Manuales de referencia:** Stigler (1961), «The Economics of Information», *JPE*, y (1962), «Information in the Labor Market», *JPE*; McCall (1970), «Economics of Information and Job Search», *QJE*; Mortensen (1977), *ILRR*; Diamond (1971), *JET*; Rothschild (1973), *JPE*; Cahuc, Carcillo y Zylberberg (2014), cap. 5; Ljungqvist y Sargent (2018), cap. 6.

## Presentación de referencia (3.A.26, I.2-I.3)

Pregunta: ¿por qué un parado que optimiza rechaza ofertas de trabajo? Conclusión: porque buscar una vez más tiene un valor de opción; fija un **salario de reserva** y acepta la primera oferta que lo supera. Pegatina del 3.A.26: «Quien busca, halla».

- **Stigler (búsqueda de muestra fija)**, 0′30″: ¿cuántas ofertas mirar antes de elegir la mejor? Hasta que el beneficio marginal de una más iguale su coste marginal. Crítica que lleva a McCall: nadie busca así; se mira una oferta, se decide y, si no convence, se sigue.
- **a) Idea**: búsqueda **secuencial**; la regla óptima es un umbral, el salario de reserva $w^R$, que deja indiferente entre aceptar y seguir buscando.
- **b) Modelo**. i) Supuestos: parado **neutral al riesgo**, tiempo discreto con factor de descuento β ∈ (0,1), maximiza $\mathbb E[\sum_t\beta^tx_t]$ con $x_t=w$ empleado y $x_t=z$ parado ($z$: prestación y ocio netos de los costes de buscar, el **mismo** $z$ que el DMP y el 3.A.27); una oferta por periodo, extraída de $F(w)$ conocida e independiente entre periodos; el empleo aceptado dura para siempre. ii) Desarrollo: $V_{\mathrm E}(w)=w/(1-\beta)$ y la ecuación de Bellman (`eq:mccall-bellman`)
$$V_{\mathrm U}=z+\beta\int_0^{\infty}\max\Big\{V_{\mathrm U},\ \frac{w}{1-\beta}\Big\}\,dF(w);$$
  se acepta si y solo si $w\ge w^R$, con $w^R/(1-\beta)=V_{\mathrm U}$, y sale la **función clave** (`eq:salario-reserva`, `\funcionclave`, con las 2 llaves «coste de rechazar $w^R$» y «ganancia esperada de buscar una vez más»):
$$w^R-z=\frac{\beta}{1-\beta}\int_{w^R}^{\infty}(w-w^R)\,dF(w).$$
  Lectura gráfica: el coste marginal de seguir buscando, $w^R-z$, crece con $w^R$; el beneficio marginal decrece; se cortan en $w^R$. iii) Implicaciones: probabilidad de salir del paro $1-F(w^R)$ y duración esperada $1/[1-F(w^R)]$; $w^R$ (y la duración) **sube** con $z$, con β y con la dispersión de las ofertas; **mismo concepto** que el $w^R$ del 3.A.25 más el **valor de opción** de buscar (por eso $w^R>z$); sin nuevas ofertas sería $w^R=z$, el del 3.A.27; el paro es **friccional y voluntario** (elegido). Nota: islas de Lucas y Prescott (1974) como pariente.
- **c) Extensiones** (cuerpo en una línea cada una; detalle en el anexo A): heterogeneidad; entorno no estacionario (Mortensen, 1977: $w^R$ baja con la duración); número aleatorio de ofertas; búsqueda desde el empleo (Burdett, 1978; Burdett y Mortensen, 1998); características no salariales (Blau, 1991, con letras locales $a$, $b$ en $U=w^ah^{-b}$; gráfico `blau.tex`); impaciencia (DellaVigna y Paserman, 2005); esfuerzo $a(e)$, $\psi(e)$; elegibilidad (Mortensen, 1977: efecto total de la prestación **ambiguo**); participación; $a_{\mathrm E}>a_{\mathrm U}$ en la búsqueda desde el empleo (locales del anexo A).
- **d) Valoración**: microfundamenta un paro friccional medible; su límite es tomar $F(w)$ como dada: **paradoja de Diamond** (1971) (con buscadores idénticos y coste de búsqueda positivo, todas las empresas pagan el salario de reserva común, desaparece la dispersión y el motivo para buscar; el salario es el de monopsonio) y la pregunta de **Rothschild** (1973). Solo mira a un lado del mercado: puente al DMP (ficha `dmp`).

**Gráfico de referencia:** `oposicion/temario/fuentes/3A26/graficos/mccall.tex` (**imprescindible** en el cante; 2 paneles por capas: a) coste y ganancia marginal de buscar, cruce en $w^R$; b) densidad de las ofertas, rotulada **$F'(w)$** —no $f(w)$, que es la tasa de encontrar empleo del DMP—, con la zona de aceptación a la derecha de $w^R$, de probabilidad $1-F(w^R)$). En el anexo, `blau.tex`.

**Notación:** $w^R$ (superíndice R; nunca $w_R$), $z$, β (tiempo discreto; en el DMP se descuenta con $r$, tiempo continuo), $F(w)$ distribución de las ofertas (local; $F(L)$ es la producción en III del mismo tema, con argumento distinto), $F'(w)$ su densidad, $V_{\mathrm E}(w)$ y $V_{\mathrm U}$ (como el DMP y Shapiro-Stiglitz; nunca $U$ ni $W$ para los valores).

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.26 | Desempleo friccional | desarrollo breve (hecho, 31/10/2026) | Stigler y McCall con `eq:salario-reserva` y `mccall.tex`; paradoja de Diamond como puente; extensiones en el anexo A | — |
| 4.A.16 | Mercado de trabajo en España | mención | Prestaciones, salario de reserva y duración del paro (sube con $z$; con la prestación que se agota, $w^R$ baja con la duración), con `\vertema{3.A.26}` solo para ampliar | La ecuación y el gráfico |
| 3.A.28 | Tasa natural de paro | mención (hecho, 31/10/2026) | El paro de búsqueda (Phelps, 1970; McCall) como parte friccional de la tasa natural, de palabra, con remisión | El modelo |

## Divergencias encontradas en el temario actual
- 3.A.26 original: $U$ para el valor del paro, $W=w/(1-\beta)$, $w_R$, unas 2.550 palabras en el bloque I y la elegibilidad con el signo equivocado («un aumento de la prestación disminuirá la tasa de desempleo»); Blau con α y β. **Resuelto** en la revisión (31/10/2026): $V_{\mathrm U}$, $V_{\mathrm E}(w)$, $w^R$, bloque I en 5′, Mortensen (1977) con efecto ambiguo, letras locales $a$, $b$.

Autor: Víctor Gutiérrez Marcos
