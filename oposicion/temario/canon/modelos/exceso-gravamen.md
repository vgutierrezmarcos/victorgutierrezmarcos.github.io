# Exceso de gravamen (y triángulo de Harberger)

- **Área:** sector público · **Tema de referencia:** 4.B.9 (efecto renta y sustitución; exceso de gravamen) — lo tiene en el título («concepto y medición del exceso de gravamen»); 4.B.11 lo usa como punto de partida de la imposición óptima y hoy lo repite entero.
- **Temas que lo usan:** 4.B.9 (desarrollo), 4.B.11 (resumen; hoy desarrollo duplicado), 4.B.7 (resumen), 4.B.8 (mención), 4.B.10 (mención), 4.B.13 (mención)
- **Manuales de referencia:** Rosen y Gayer, *Public Finance*, cap. 15 (*Taxation and efficiency*); Stiglitz y Rosengard, cap. 19; Gruber, cap. 19-20; Auerbach (1985), «The theory of excess burden and optimal taxation», *Handbook of Public Economics* I; Harberger (1964), «The measurement of waste», *AER*; Dupuit (1844); Hausman (1981), *AER*. Base de bienestar: Mas-Colell, Whinston y Green, cap. 3.I (variación equivalente).
- **Decisión D047 (13/10/2026):** ¿Las elasticidades precio se escriben con su signo? Sí: ε_D < 0 con su signo y |ε_D| en las fórmulas (ε^h si es compensada); EG ≥ 0 siempre
- **Decisión D079 (13/10/2026):** ¿Cómo se reparte el exceso de gravamen entre 4.B.9 y 4.B.11? Desarrollo solo en 4.B.9; en 4.B.11 resumen de media página con remisión

## Presentación de referencia
**Pregunta:** ¿cuánto bienestar pierde la sociedad, por encima de lo recaudado, cuando un impuesto altera los precios relativos?

**Concepto.** El exceso de gravamen es la pérdida de bienestar que excede la recaudación: $\mathrm{EG}=-\mathrm{VE}-T\ge 0$, donde $\mathrm{VE}$ es la variación equivalente del impuesto (negativa, con la convención de signo de la ficha `vc-ve` y del 3.A.9: positiva si el bienestar mejora) y $T$ lo recaudado; $-\mathrm{VE}$ es lo máximo que el consumidor pagaría por evitar el impuesto. Si un tema prefiere hablar de la pérdida en valor absoluto, lo dice: $\mathrm{EG}=|\mathrm{VE}|-T$. (Corregido el 13/10/2026: antes decía $EG=VE-T$, a raíz del 3.A.9.) Nace solo del **efecto sustitución** (el de renta lo tendría igual un impuesto de suma fija que recaudara lo mismo); por eso se mide con la demanda **compensada** $h(p,\bar U)$ [ver tema 3.A.9].

**Supuestos (equilibrio parcial):** un consumidor representativo, bien gravado $x$ y numerario; oferta perfectamente elástica (coste marginal constante $p$); competencia perfecta; impuesto *ad valorem* $t$; demanda compensada aproximadamente lineal en el tramo relevante; sin distorsiones previas.

**Ecuaciones (notación canónica: $\varepsilon^h_D<0$ con su signo; en las fórmulas $\lvert\cdot\rvert$):**
$$EG=\tfrac12\,t\,p\,\lvert\Delta h\rvert,\qquad \lvert\Delta h\rvert=\lvert\varepsilon^h_D\rvert\,t\,h \;\Rightarrow\; EG=\tfrac12\,\lvert\varepsilon^h_D\rvert\,t^2\,p\,h .$$
Con oferta de pendiente positiva:
$$EG=\tfrac12\,t^2\,p\,h\,\frac{\varepsilon_S\lvert\varepsilon^h_D\rvert}{\varepsilon_S+\lvert\varepsilon^h_D\rvert}.$$
Varios bienes relacionados (sistema fiscal):
$$EG=-\tfrac12\sum_i\sum_j S_{ij}\,t_i t_j\,p_i p_j ,\qquad S_{ij}=\partial h_i/\partial p_j .$$

**Resultado principal:** el $EG$ crece con el **cuadrado** del tipo (repartir la recaudación en muchas bases con tipos bajos es más eficiente) y con la elasticidad compensada; un impuesto sobre un bien de demanda compensada rígida o un impuesto de suma fija no tiene $EG$. Con bienes relacionados, gravar un sustitutivo de un bien ya gravado puede **reducir** el $EG$ (segundo óptimo [ver tema 3.A.22]).

**Gráficos de referencia:** (1) consumo-numerario: la restricción presupuestaria gira por el impuesto (A→B, de $u_0$ a $u_1$); la paralela de suma fija que alcanza $u_1$ mide la $VE$; la distancia vertical entre esta y la que pasa por B es el $EG$. (2) Mercado: demandas marshalliana $x(p)$ y compensada $h(p,u_0)$, oferta horizontal en $p$; el impuesto sube el precio a $p(1+t)$; rectángulo = recaudación; **triángulo de Harberger** bajo la compensada = $EG$; el triángulo bajo la marshalliana es la aproximación por excedentes (error proporcional al efecto renta, Willig 1976). No hay `.tex` todavía.

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 4.B.9 | Concepto y medición del EG | Desarrollo | Todo lo anterior: VE, excedentes, triángulo de Harberger, oferta con pendiente, sistema con $S_{ij}$, distorsiones previas, Hausman frente a Harberger, anexos (oferta compensada, subsidio) | — |
| 4.B.11 | Imposición óptima | Resumen (½ página) | Recordar $EG=\tfrac12\lvert\varepsilon\rvert t^2ph$ y $EGMg$ para plantear Ramsey; «[ver tema 4.B.9]» | El desarrollo con los dos gráficos, la VE y el ejemplo de coches nuevos/usados |
| 4.B.7 | Principio de eficiencia | Resumen breve | Definición y la idea «crece con $t^2$ y con la elasticidad» | Gráficos y fórmulas completas |
| 4.B.8 | Incidencia | Mención | Señalar el triángulo en el gráfico de incidencia | — |
| 4.B.10 | Efectos incentivo | Mención | El EG del impuesto sobre salarios depende de la elasticidad compensada de la oferta de trabajo (no de la no compensada) | Rehacer la medición |
| 4.B.13 | Imposición indirecta | Mención | Ramsey/elasticidad inversa como justificación de tipos | — |

## Divergencias encontradas en el temario actual
- **Duplicación (4.B.9 y 4.B.11):** el apartado 1 de 4.B.11 (viejo 4.B.12) desarrolla entero el EG (VE, excedentes, equilibrio general, mismos tres gráficos) y el triángulo de Harberger, que son el núcleo de 4.B.9. Reparto: desarrollo solo en 4.B.9; en 4.B.11, resumen de media página con remisión.
- **Signo:** 4.B.11 define $\varepsilon$ positiva y escribe $EG=-\tfrac12\varepsilon P h t^2$ (sale negativo); 4.B.9 usa $\varepsilon$ con signo. **Propuesta:** $\varepsilon^h_D$ con signo (como 3.A.8) y $\lvert\varepsilon^h_D\rvert$ en la fórmula; $EG\ge 0$ siempre.
- **Notación:** $\tau$, $\eta_s$, $\eta_d$ (4.B.7) frente a $t$, $\varepsilon$ (4.B.9, 4.B.11); $P$ mayúscula. Unificar a $t$, $p$, $\varepsilon$.
- 4.B.9 atribuye la VC/VE a «Hicks (1956) … refinados por Willings»: es Hicks (1939-1942) y **Willig (1976)**; «Haussman» → **Hausman**.
- 4.B.9 remite a «anexo A.2» para la suavización de Barro, que es el anexo 4; en ese anexo $\tau_t$ es recaudación (ver notación: $T_t$).
- El triángulo de Harberger (1964, medida del EG) y el modelo bisectorial de Harberger (1962, incidencia) se confunden por el nombre: decir siempre cuál es.
