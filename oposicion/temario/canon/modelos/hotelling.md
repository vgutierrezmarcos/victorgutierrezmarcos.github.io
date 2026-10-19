# Ciudad lineal de Hotelling (1929): competencia en precios y elección de localización

- **Área:** mercados-información-juegos · **Tema de referencia:** **3.A.18** (Diferenciación de productos; revisado el 19/10/2026, II.3.2 con localización dada y II.3.3 con localización elegida, más el anexo `anexo:hotelling`) — es el modelo base del enfoque de direcciones y el único tema que lo desarrolla. Ficha creada a raíz de esa revisión (K39, K47). No confundir con la **regla de Hotelling** de los recursos agotables (3.A.29; excepción de `_inventario/alias.json`).
- **Temas que lo usan:** 3.A.18 (desarrollo; hecho, 19/10/2026), 3.A.19 (mención: la diferenciación como salida a la paradoja de Bertrand; hoy repite el gráfico de Bertrand con producto diferenciado), 3.A.24 y 4.B.2 (mención: base espacial del modelo de Downs-Hotelling y del votante mediano, fichas `downs-hotelling` y `votante-mediano`), 3.A.14 (mención; hecho, 19/10/2026: juegos en 2 etapas que se resuelven por inducción hacia atrás, «la localización y luego el precio»), 3.B.6 (mención posible: localización y comercio).
- **Manuales de referencia:** Hotelling (1929), «Stability in Competition», *EJ*; d'Aspremont, Gabszewicz y Thisse (1979), *Econometrica*; Tirole (1988), cap. 7; Belleflamme y Peitz (2015), cap. 5; Cabral (2000).

## Presentación de referencia (3.A.18, II.3.2-II.3.3)

Pregunta: ¿cuánto margen da la diferenciación horizontal y, si las empresas eligen su producto, se parecen o se diferencian? Conclusión: margen $t$ sobre el coste marginal (salida a la paradoja de Bertrand); con precios elegidos, **diferenciación máxima** para suavizar la competencia en precios; el mercado diferencia demasiado.

**Localización dada (decisión de precios).** i) Supuestos: continuo de consumidores de masa 1 uniforme en $[0,1]$ (la posición es la variedad ideal); empresas 1 (en 0) y 2 (en 1) con el mismo coste marginal $c$; **demanda unitaria**: cada consumidor compra una unidad a la empresa que le da más $v-p_i-t\,d^2$ ($v$ valoración bruta, lo bastante alta; $t$ **coste de transporte**, pérdida por no consumir la variedad ideal; con localización dada, $t\,d$ da lo mismo); Bertrand simultáneo. ii) Desarrollo: **consumidor indiferente** $\tilde x$ (la pieza que se repite en todos los modelos espaciales y en la vertical):
$$p_1+t\,\tilde{x}^2=p_2+t\,(1-\tilde{x})^2\ \Longrightarrow\ x_1=\tilde{x}=\frac{1}{2}+\frac{p_2-p_1}{2t},\qquad x_2=1-\tilde{x}$$
(`eq:hotelling-indiferente`); funciones de reacción **crecientes** y equilibrio de Nash simétrico (`eq:hotelling-precios`):
$$R_i(p_j)=\frac{p_j+c+t}{2}\ \Longrightarrow\ p_1^*=p_2^*=c+t,\qquad x_1^*=x_2^*=\tfrac12,\qquad B_1^*=B_2^*=\tfrac{t}{2}.$$
iii) Implicaciones: **salida a la paradoja de Bertrand** (levanta el supuesto de producto homogéneo; $t\to0\Rightarrow p\to c$); el mismo resultado que Bertrand diferenciado (ficha `oligopolio-diferenciado`), con la sustituibilidad explicada por la heterogeneidad de los gustos.

**Localización elegida (decisión de localización).** Costes **cuadráticos** (con lineales la demanda es discontinua —el «patio trasero» de la rival— y puede no haber equilibrio en precios; d'Aspremont *et al.*, 1979; anexo D); juego en 2 etapas por inducción hacia atrás (3.A.14): 1) localizaciones $0\le a\le b\le1$; 2) precios. 2.ª etapa: $\tilde x=\frac{a+b}{2}+\frac{p_2-p_1}{2t(b-a)}$, $p_1^*=c+\frac{t(b-a)(2+a+b)}{3}$, $p_2^*=c+\frac{t(b-a)(4-a-b)}{3}$ (márgenes proporcionales a $b-a$). 1.ª etapa, por la envolvente:
$$\frac{dB_1}{da}=(p_1^*-c)\Big[\underbrace{\frac{\partial x_1}{\partial a}}_{\text{efecto demanda }(+)}+\underbrace{\frac{\partial x_1}{\partial p_2}\,\frac{dp_2^*}{da}}_{\text{efecto estratégico }(-)}\Big]=(p_1^*-c)\,\frac{b-3a-2}{6\,(b-a)}<0.$$
Implicaciones: **principio de diferenciación máxima** ($a=0$, $b=1$, $p^*=c+t$; d'Aspremont, Gabszewicz y Thisse, 1979) frente al **principio de diferenciación mínima** de Hotelling (1929), que sale si los precios están fijos (solo actúa el efecto demanda: las 2 en el centro; pregunta habitual de test); **bienestar**: el planificador las pondría en ¼ y ¾ (coste de transporte $t/48$ frente a $t/12$): el mercado diferencia demasiado. Extensión política: Downs-Hotelling (3.A.24, 4.B.2). Valoración: sensible a los supuestos (costes lineales, demanda concentrada en el centro, ventajas de la aglomeración; Tirole, cap. 7); número de empresas fijo → Salop.

**Gráficos de referencia:** `oposicion/temario/fuentes/3A18/graficos/hotelling.tex` (segmento [0,1] con los precios totales $p_1+tx^2$ y $p_2+t(1-x)^2$ y el consumidor indiferente $\tilde x$; imprescindible) y `hotelling-localizacion.tex` (**el mismo segmento por capas**, misma escala: efectos demanda y estratégico sobre cada empresa; equilibrio en 0 y 1, óptimo en ¼ y ¾ y, con precios fijos, ½). Funciones de reacción en precios: panel derecho de `reaccion-diferenciado.tex` (ficha `oligopolio-diferenciado`). Anexo: `hotelling-lineal.tex` (demanda discontinua con costes lineales).

**Notación:** empresas 1 y 2 (genérico $i$, $j\neq i$; nunca A y B, que son alto y bajo en redonda, 3.A.13), localizaciones $a\le b$, $\tilde x$ consumidor indiferente (la tilde indica aquí una posición, no una variable aleatoria: local, `notacion.md` § 2), demandas $x_1(p_1,p_2)$, $x_2$ (nunca $D_i$, que es la demanda efectiva de Chamberlin), $t$ coste de transporte (local: en el 3.A.18 no hay impuestos), $v$ valoración bruta (local), $R_i(p_j)$ (D016), $B_i$.

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.18 | Diferenciación horizontal con direcciones | desarrollo (hecho, 19/10/2026) | Todo lo anterior, en 2 subapartados (precio; localización) y el anexo D | — |
| 3.A.19 | Oligopolio: paradoja de Bertrand y sus salidas | mención | Una línea: con producto diferenciado (Hotelling) el precio supera el coste marginal, $p=c+t$; remitir a 3.A.18 (II.2 y II.3.2) | El gráfico de reacción en precios y el modelo |
| 3.A.24, 4.B.2 | Competencia electoral | mención | El segmento ideológico es la ciudad lineal con precios fijos: solo el efecto demanda, convergencia al votante mediano (ficha `downs-hotelling`); Hotelling (1929), Downs (1957) | La competencia en precios |
| 3.A.14 | Juegos dinámicos | mención (hecho, 19/10/2026) | Juegos en 2 etapas (localización y precio) resueltos por inducción hacia atrás, con remisión | El modelo |

## Divergencias encontradas en el temario actual
- 3.A.18 original: demanda de B con localizaciones generales que no era $1-\tilde x$; «con costes **cuadráticos** puede no haber equilibrio» (es con lineales); «= 0» en un término que no se anula; empresas A y B y $D_A$, $D_B$; φ para la función de reacción. **Resuelto** (19/10/2026).
- 3.A.19 (sin revisar): su Imagen 5 («Situación de Bertrand con producto diferenciado») es la Imagen 10 del 3.A.18 original: al revisarlo, resumir en una línea y remitir a II.2 y II.3.2 del 3.A.18.
- 4.B.2 (sin revisar): «Downs-Hotelling (1947)»: Hotelling (1929), Downs (1957) (ficha `downs-hotelling`).

Autor: Víctor Gutiérrez Marcos
