# Contabilidad del crecimiento (Solow 1957) y enfoque dual (Hsieh 2002)

- **Área:** macro cerrada · **Tema de referencia:** 3.A.45 (contabilidad del crecimiento y PTF) — lo tiene en el título. **Revisado el 1/11/2026**: bloque II (9′30″), II.1 primal (a-c) y dual (a-d) como `\subsubsection`, II.2 econométrico, II.3 contabilidad del desarrollo, II.4 problemas, II.5 evidencia; anexo A paso a paso. Función clave del tema: `eq:residuo`.
- **Temas que lo usan:** 3.A.45 (desarrollo; hecho, 1/11/2026), 4.A.27 (mención), 1D01 (uso: II.4), 3.A.43 (mención; hecho, 31/10/2026: I.3 c), el residuo de Solow, 1957, pp. 316 y 320: 1909-1949, 12,5 % / 87,5 % del aumento de la producción por hora; con la tecnología del 3.A.43, **la PTF crece a $(1-\alpha)g$**, no a $g$ (A43-21); `\vertema{3.A.45}`), 3.A.44 (mención; hecho, 1/11/2026: la PTF de EE. UU. de Fernald, ≈ 2 % hasta 1973 y 0,9 % de media desde 1970, con `fig:efecto-escala`), 3.A.42 (hecho, 4/11/2026, ver la tabla; mención: el residuo de Solow como perturbación de productividad del ciclo real, Kydland y Prescott, 1982; Prescott, 1986), 3.A.11 (mención; hecho, 13/10/2026: la PTF se mide con neutralidad de Hicks, l. 968) También 3.A.6 (mención; hecho, 4/11/2026: III.1, la perturbación tecnológica medida con el residuo de Solow; correlación con el ciclo de 0,82, que pasa a −0,15 corregido por utilización, Fernald; `\vertema{3.A.45}`).
- **Manuales de referencia:** Solow (1957); Abramovitz (1956); Jorgenson y Griliches (1967); Hsieh (2002); Young (1995, 1998); Hall y Jones (1999); Caselli (2005); Barro y Sala i Martín (2004), cap. 10; Romer (2019), cap. 1; Jones (2016).

## Presentación de referencia (3.A.45, II.1)

**Pregunta:** ¿qué parte del crecimiento se debe a la acumulación de factores y cuál a la productividad total de los factores (PTF)?

**Primal (Solow, 1957).** *Supuestos*: $Y=A\,F(K,L)$ con progreso técnico **neutral de Hicks** (nota con `\vertema{3.A.11}`) y rendimientos constantes; mercados de factores competitivos (las elasticidades son las participaciones, que se observan; el producto se agota, `eq:euler-reparto`). Sin condiciones de Inada (la contabilidad no las necesita). *Desarrollo*:
$$\boxed{\gamma_A=\gamma_Y-\alpha\,\gamma_K-(1-\alpha)\,\gamma_L}\qquad(\texttt{eq:residuo},\ \text{residuo de Solow})$$
$$\gamma_{Y/L}=\gamma_A+\alpha\,\gamma_{K/L}\qquad(\texttt{eq:residuo-hora},\ \text{la forma de Solow, por hora})$$
Con más factores, $\gamma_A=\gamma_Y-\sum_i\alpha_i\gamma_{X_i}$; con datos anuales, las participaciones son la media de los 2 años, **$\bar\alpha_t=(\alpha_t+\alpha_{t-1})/2$ (índice de Törnqvist**, anexo A). Siempre $\gamma_A$, $\alpha$, $1-\alpha$ (nunca RS, $\dot A/A$, $\alpha_K$, $\alpha_L$ ni «+ ε»: es una identidad).

**Dos formas de escribir la tecnología** (caja de II.1, DK4/CC7): la contabilidad escribe $Y=A\,K^{\alpha}L^{1-\alpha}$ (Hicks); el modelo de Solow, MRW y Hall y Jones, $Y=K^{\alpha}(AL)^{1-\alpha}$ con $\gamma_A=g$. Con Cobb-Douglas son la misma tecnología: en la segunda forma la PTF es $A^{1-\alpha}$ y **crece a $(1-\alpha)g$**. La misma letra $A$ en los 2 sentidos, avisada (como Hall y Jones, 1999, y Jones, 2016).

**Resultados de Solow:** EE. UU., 1909-1949, producción bruta **por hora trabajada** del sector privado no agrario: se duplicó; 1/8 (12,5 %) por el capital por hora y 7/8 (87,5 %) de residuo (pp. 316 y 320); desplazamiento ≈ 1 % anual en la 1.ª mitad y ≈ 2 % en la 2.ª. **Valoración**: abre un programa vivo; el residuo pasa a ser la perturbación del ciclo real (`\vertema{3.A.42}`); críticas: competencia perfecta; **Kaldor (1957)** (no «Friedman»): separar movimientos y desplazamientos es artificial, función de progreso técnico; «medida de nuestra ignorancia» (**Abramovitz, 1956, p. 11**); lo costoso es factor (**Jorgenson y Griliches, 1967**: EE. UU. 1945-1965, residuo del 1,6 % al 0,1 %); contabilidad no es causalidad.

**Dual (Hsieh, 2002).** *Supuesto*: $Y=c_K\,K+w\,L$ con $P=1$ y los precios observados agotan el producto (no hace falta forma funcional, tipo de progreso técnico ni stock de capital). **$c_K$ es el coste de uso del capital** (`eq:coste-uso` del 3.A.34, ficha `jorgenson`; $c_K=r+\delta$ con el precio del capital constante); nunca $r$ (en el canon, $r$ es el tipo neto).
$$\underbrace{\gamma_Y-\alpha\gamma_K-(1-\alpha)\gamma_L}_{\text{primal}}=\underbrace{\alpha\,\gamma_{c_K}+(1-\alpha)\,\gamma_w}_{\text{dual}}=\gamma_A\qquad(\texttt{eq:dual})$$
Intuición: la **frontera de precios de los factores**; subir los 2 precios a la vez exige desplazarla. Identidad: si difieren, fallan los datos. **Tigres asiáticos**: Young (1995), Singapur 0,2 % anual de PTF en 1966-1990; Krugman (1994); Hsieh (2002), dual ≈ 2 puntos más al año (Fernald y Neiman, 2011); Young (1998, NBER WP 6657), errores de cálculo y método. Pegatina «las apariencias engañan».

**Econométrico** (`eq:econometrico`): $\gamma_{Y,t}=\beta_0+\beta_1\gamma_{K,t}+\beta_2\gamma_{L,t}+u_t$, distinta de la identidad; simultaneidad (Marschak y Andrews, 1944); Hall (1988, 1990).

**Contabilidad del desarrollo** (Klenow y Rodríguez-Clare, 1997; Hall y Jones, 1999; Caselli, 2005): $Y=K^{\alpha}(A\,h\,L)^{1-\alpha}$, $h=e^{\phi(S)}$ capital humano **por trabajador** (no el $h\equiv H/(AL)$ de MRW), $\phi$ local;
$$\frac{Y}{L}=\left(\frac{K}{Y}\right)^{\frac{\alpha}{1-\alpha}}h\,A\qquad(\texttt{eq:hall-jones})$$
con $K/Y$ para atribuir a la PTF el capital que induce. Cifras: 5 más ricos / 5 más pobres, 1988: 31,7 = 1,8 × 2,2 × 8,3 (Hall y Jones, 1999, p. 92); 2023 sin petroleros ni centros financieros: 47,1 = 1,07 × 2,29 × 19,1 (A45-27); Corea/Nigeria 2023: 8,1 = 0,7 × 1,8 × 6,2; correlación de los logaritmos 0,89 (0,79 de varianza «que acompaña», no «que explica»); Caselli: éxito 0,39 en 1996, 0,30 en 2023. La estimación de MRW, en la ficha `solow-mrw`.

**Problemas** (II.4): calidad de los factores (Mincer, 1974; servicios del capital frente a riqueza, Oulton y Srinivasan, 2003; Denison), producción bruta frente a VAB (pesos de Domar), contabilidad frente a causalidad,
$$\gamma_{Y/L}=\frac{\gamma_A}{1-\alpha}+\frac{\alpha}{1-\alpha}\gamma_{K/Y}\qquad(\texttt{eq:causalidad})$$
pegatina «unos cardan la lana y otros llevan la fama».

**Evidencia** (II.5): mundo 1960-2000, producción por trabajador 2,3 % = 1,0 capital (43 %) + 0,3 educación (13 %) + 0,9 PTF (39 %) (Bosworth y Collins, 2003, tabla 1); **España** (AMECO + PWT `hc`, Törnqvist): 1996-2007, 3,6 = 1,8 K + 2,0 horas + 0,4 capital humano − 0,5 PTF; PTF −0,8 (2008-2013), +0,6 (2014-2019), ≈ 0 (2020-2025); 1971-1985, 2,0 de 2,8 puntos; zona del euro 0,5; −0,5; 0,6; −0,2; EE. UU. 1,2 (1996-2007) y 0,8 (2020-2025); PTF de EE. UU. (Fernald): 2,1 % (1948-1973), 0,5 (1974-1995), 1,8 (1996-2004), 0,5 (2005-2019), 1,1 (2020-2025), 0,9 de media desde 1970 (como el 3.A.44). Desaceleración: medida (Syverson, 2017; Byrne, Fernald y Reinsdorf, 2016), Baumol, ideas más caras (Bloom et al., 2020, ficha `semiendogeno`), Gordon (2016), mala asignación en España (García-Santana et al., 2020), curva J (Brynjolfsson, Rock y Syverson, 2021). PTF frente a productividad del trabajo y Malmquist en nota (`\vertema{3.A.12}`, ficha `eficiencia-frontera`).

**Gráficos de referencia** (`oposicion/temario/fuentes/3A45/graficos/`): `contabilidad-espana.tex` (barras apiladas de España, zona del euro y EE. UU. por periodos, con la línea del PIB; de pizarra, por capas), `ptf-renta.tex` (PTF relativa y renta, 2023) y `mrw-ajuste.tex` (de apoyo). En la pizarra, `eq:residuo` recuadrada a la izquierda hasta el final y `eq:dual` debajo.

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.45 | Contabilidad del crecimiento y PTF | desarrollo (hecho, 1/11/2026) | Primal y dual, econométrico, contabilidad del desarrollo, problemas, evidencia de España, zona del euro y EE. UU. | — |
| 4.A.27 | Crecimiento de la economía española (1960-1973) | mención | Descomposición del crecimiento con fuente (su «60 % PTF, 35 % capital, 5 % trabajo» no la tiene; el 3.A.45 da 1971-1985 con AMECO + PWT) | Derivación `\vertema{3.A.45}` |
| 1D01 | Dictamen de coyuntura | Uso | $\gamma_Y=\gamma_A+\alpha\gamma_K+(1-\alpha)\gamma_L$ con α participación del capital (no $s_L$, $s_K$: s es la tasa de ahorro); PAT y su descomposición | La derivación |
| 3.A.43 | Solow | mención (hecho, 31/10/2026) | El residuo de Solow (1909-1949, 87,5 % de la producción por hora) como evidencia del modelo; la PTF crece a $(1-\alpha)g$ con su tecnología | La descomposición `\vertema{3.A.45}` |
| 3.A.44 | Crecimiento endógeno | mención (hecho, 1/11/2026) | PTF de EE. UU. de Fernald (0,9 % desde 1970) frente al esfuerzo en I+D | La descomposición |
| 3.A.42 | Ciclos reales | mención (hecho, 4/11/2026; II.1.1 y e), el residuo de Solow con Fernald y `residuo-solow`, `\vertema{3.A.45}`) | El residuo de Solow como perturbación de productividad, $Y=A_tK^{\alpha}L^{1-\alpha}$ (Hicks, coherente con esta ficha) | La contabilidad |
| 3.A.11 | Producción | mención (hecho, 13/10/2026) | La PTF se mide con neutralidad de Hicks | — |
| 3.A.6 | NMC: ciclo real | mención (hecho, 4/11/2026) | El residuo de Solow como perturbación tecnológica y su corrección por utilización (gráfico `residuo-solow`) | La contabilidad |

## Divergencias encontradas en el temario actual
- Resuelto en el 3.A.45 (1/11/2026): RS, $\dot A/A$, $\alpha_K$, $\alpha_L$ y «+ ε» → $\gamma_A$, $\alpha$, $1-\alpha$, identidad sin error; «la renta per cápita se duplicó» (producción por hora); «Friedman» (Kaldor, 1957); Abramovitz y Jorgenson-Griliches separados; dual con $r$ ($c_K$); «96,7 %» sin periodo (1945-1965); mundo 40/10/50 % sin fuente (Bosworth y Collins); Hall y Jones «el 79 % se explica».
- 4.A.27 (Word): «60/35/5 %» en 1960-1973 sin fuente.

Autor: Víctor Gutiérrez Marcos
