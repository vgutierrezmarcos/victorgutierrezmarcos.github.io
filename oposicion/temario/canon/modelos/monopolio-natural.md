# Monopolio natural: subaditividad y sostenibilidad

- **Área:** mercados-información-juegos · **Tema de referencia:** 3.A.17 (Monopolio; monopolio natural)
- **Temas que lo usan:** 3.A.17 (desarrollo), 3.A.12 (resumen: subaditividad y economías de alcance; hecho), 4.A.12, 4.A.15, 4.B.15 (resumen; hoy mención), 4.A.5 (previsto)
- **Manuales de referencia:** Baumol (1977), *AER*; Baumol, Panzar y Willig (1982); Sharkey (1982); Viscusi, Harrington y Vernon, cap. 11.

## Presentación de referencia
Definición (monoproducto): la función de costes es **subaditiva** en $q$: $C\big(\sum_i q_i\big)<\sum_i C(q_i)$ para todo reparto; las economías de escala bastan pero no son necesarias.
Multiproducto: la definición sigue siendo la **subaditividad** de $C(\vec q)$; las **economías de alcance** $C(q_1,q_2)<C(q_1,0)+C(0,q_2)$ son necesarias, no suficientes; condición suficiente: economías de alcance y coste incremental medio decreciente en cada producto (Baumol, Panzar y Willig, 1982). Complementariedad de costes $\partial^2C/\partial q_1\partial q_2<0$ y economías de escala multiproducto ($C(\lambda\vec q^{\,0})/\lambda$ decreciente en λ) como conceptos auxiliares (3.A.12, III.4.2).
Sostenibilidad: un monopolio natural puede no ser sostenible frente a la entrada (tramo con subaditividad pero CMe creciente).
Regulación: $p=CMg$ con subvención (first best), $p=CMe$, Ramsey-Boiteux, tarifa en dos partes, price cap, tasa de rentabilidad (fichas propias).
Gráfico de referencia: CMe en U con demanda que corta en el tramo decreciente; zona de subaditividad más allá del mínimo del CMe (CMe$_1$ frente a CMe$_{1+2}$). Versión en TikZ del 3.A.12: `oposicion/temario/fuentes/3A12/graficos/subaditividad.tex` (entre $q^0$ y $q^1$ una empresa produce más barato aunque su CMe crezca), que debe ser **el mismo** en 3.A.17; economías de alcance: `alcance.tex` (costes conjuntos frente a separados).

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.17 | Monopolio natural | desarrollo | Subaditividad, sostenibilidad, multiproducto, regulación | — |
| 3.A.12 | Costes y estructura de mercado | resumen (hecho, 14/10/2026) | Subaditividad (como definición, Baumol, 1977) y economías de alcance como propiedades de $C(\vec w,q)$, una sola vez (III.1.2-III.1.3), con el gráfico `subaditividad`; remite a 3.A.17 y 3.A.20 | Regulación y sostenibilidad |
| 4.A.12, 4.A.5 | Industrias de red | mención | Separación red/servicios; cambio técnico que acaba con el monopolio natural | Teoría |
| 4.A.15 | Competencia | mención | Justificación de la regulación | Teoría |
| 4.B.15 | Empresa pública y regulación | resumen (hoy mención; D139 (13/10/2026)) | Subaditividad, pérdidas con precio igual al CMg y el dilema regulación o propiedad pública, con un gráfico sencillo; remite a 3.A.17 | La derivación |

## Divergencias encontradas en el temario actual
- 4.B.15 escribe la condición de rendimientos crecientes $C(\lambda x_1,\lambda x_2)<\lambda C(x_1,x_2)$ con $x$ para el output: canon $q$.
- Hay que distinguir siempre subaditividad (definición) de economías de escala (condición suficiente); 4.A.15 los iguala.
- 3.A.17 (Word): «en el multiproducto el concepto clave no sería la subaditividad, sino las economías de alcance»: la definición sigue siendo la subaditividad (las economías de alcance son necesarias, no suficientes). Usa la misma captura de Policonomics que tenía el 3.A.12: sustituirla por el gráfico `subaditividad` del 3.A.12. El 3.A.12 original decía lo mismo y se corrigió (14/10/2026).
