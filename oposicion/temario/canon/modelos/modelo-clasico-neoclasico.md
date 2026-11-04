# El modelo macroeconómico neoclásico («clásico» en la *Teoría general*): trabajo, fondos prestables y teoría cuantitativa

- **Área:** pensamiento · **Tema de referencia:** **3.A.4** (revisado el 4/11/2026: I.3 «El punto de partida: el modelo neoclásico», 2′30″, con a)-c), `eq:trabajo-neoclasico`, `eq:fondos-prestables`, `eq:cuantitativa-clasica` y el gráfico nuevo `modelo-neoclasico`; detalle mercado a mercado en el anexo A, `anexo:modelos`) — **[decidir]**. Ficha creada en la fase canon del 3.A.4 (CC1); el id estaba en la lista del 3.A.4 en `mapa.yaml` sin ficha.
  - *Por qué no el 3.A.3* (la propuesta CC1 lo daba como referencia «si procede»): el 3.A.3 («Los economistas neoclásicos», sin revisar) es una historia autor a autor (Jevons, Menger, Walras, Marshall, Wicksteed, Wicksell, Clark, Fisher, Edgeworth, Pareto, Pigou; inventario `3A03.json`) y no tiene el modelo agregado: este es una **reconstrucción** posterior (Heijdra, 2017, cap. 1; Fonseca, *The Neoclassical Macromodel*, The History of Economic Thought Website), que solo se usa como *baseline* frente a Keynes, y el 3.A.4 ya la desarrolla entera con su gráfico. El 3.A.3 cuenta las **piezas** (Marshall, Wicksell y el tipo natural, Fisher y Cambridge, Pigou) y puede remitir al 3.A.4 para el modelo agregado. *Alternativa*: el 3.A.3 de referencia, si al revisarlo se le añade un apartado con el modelo (no recomendado: duplicaría el I.3 del 3.A.4 en un tema que ya va justo de tiempo).
- **Temas que lo usan:** 3.A.4 (desarrollo; hecho, 4/11/2026), 3.A.33 (resumen; hecho, 31/10/2026: el anexo de los fondos prestables con $r$ y $r^n$, gráfico `fondos-prestables`, el de referencia), 3.A.28 (resumen; hecho, 31/10/2026: el paro en el modelo neoclásico, voluntario o por salario por encima del de equilibrio, y el anexo del mercado de trabajo con `equilibrio-trabajo`), 3.A.25 (resumen; hecho, 31/10/2026: oferta y demanda de trabajo con $w^c$, $L^c$), 3.A.5 (mención; hecho, 3/11/2026: los neoclásicos en la contextualización), 3.A.3 (resumen previsto: las piezas por autor, con `\vertema{3.A.4}`), 3.A.35 (resumen previsto: la teoría cuantitativa, ficha `teoria-cuantitativa`, su referencia), 3.A.2 (mención prevista: la ley de Say de los clásicos). Relacionadas: `teoria-cuantitativa` (3.A.35), `marshall-equilibrio-parcial` (3.A.3), `demanda-trabajo` (3.A.25), `keynes-teoria-general` (su alternativa).
- **Manuales de referencia:** Heijdra (2017), *Foundations of Modern Macroeconomics*, cap. 1; Fonseca, «The Neoclassical Macromodel», The History of Economic Thought Website, s. f., consulta del 31/10/2026 (`Fonseca2026Neoclassical`); De Vroey (2016), cap. 1; Snowdon y Vane (2005), cap. 2; Fisher (1911), *The Purchasing Power of Money*; Pigou (1917), *QJE*; Wicksell (1898); Keynes (1936), cap. 1 (nota sobre «clásicos») y cap. 2.

## Presentación de referencia (3.A.4, I.3 y anexo A)

**Pregunta:** ¿qué modelo quería sustituir Keynes, y por qué en él la economía vuelve sola al pleno empleo?

- **a) Idea**: reconstrucción a partir de Marshall, Pigou, Fisher y Wicksell; de Marshall, el mercado que se vacía (el mercado de pescado, ficha `marshall-equilibrio-parcial`, gráfico `marshall-periodos` del 3.A.16, en el anexo A). Aviso de que es una reconstrucción (caja `anotaciones`).
- **b) Modelo.** *Supuestos*: economía cerrada con el capital dado; competencia perfecta en bienes, trabajo y dinero; precios, salarios y tipo de interés **flexibles**; información perfecta y decisiones en términos **reales**; el dinero solo es medio de cambio. *Desarrollo*, en el **orden causal trabajo → bienes → dinero**:
  - *Trabajo* (`\vertema{3.A.25}`):
  $$w\equiv\frac{W}{P}=\mathrm{PMg}_L(L),\quad L^S=L^S(w),\quad L^D(w^c)=L^S(w^c)\Rightarrow L^c,\quad Y_F=F(L^c)\qquad(\texttt{eq:trabajo-neoclasico})$$
  con $w^c$, $L^c$ (el equilibrio competitivo del 3.A.25; nunca $w^*$, $L^*$) e **$Y_F$ la producción de pleno empleo**; la OA es **vertical** en $Y_F$.
  - *Bienes: fondos prestables* (`\vertema{3.A.33}`):
  $$S(r)=I(r)+G-T\Rightarrow r^n\qquad(\texttt{eq:fondos-prestables})$$
  con **$r$ el tipo real** y $r^n$ el natural de Wicksell; la expresión «fondos prestables» es de Robertson y Ohlin (años 30), la idea de Marshall y Wicksell (nota).
  - *Dinero: teoría cuantitativa* (`\vertema{3.A.35}`): $MV=PY$ (Fisher, **1911**) o $M^D=kPY$ (Cambridge, Pigou, 1917), $k=1/V$:
  $$P=\frac{MV}{Y_F}=\frac{M}{k\,Y_F}\qquad(\texttt{eq:cuantitativa-clasica})$$
  la DA es una hipérbola $PY=MV$ en $(Y,P)$. En el anexo A, la ecuación de cambio con transacciones, $MV\equiv PT$, con el aviso de que esa $T$ no es la de los impuestos.
  - *Implicaciones*: ley de Say (según Lange, 1942, como el 3.A.21); **expulsión total** (más gasto público sube $r$ y desplaza el mismo gasto privado); neutralidad y **dicotomía clásica**; paro solo **friccional y voluntario** (Keynes, cap. 2, distingue además el involuntario), o por trabas (sindicatos, Hicks, 1932, `\vertema{3.A.27}`; poder de mercado, Chamberlin, 1933, `\vertema{3.A.18}`); receta: flexibilizar y *laissez-faire*.
- **c) Valoración**: coherente (cada mercado fija una variable), pero no explicaba un paro masivo y duradero ni por qué bajar los salarios no lo curaba. Recapitulación: «de $r$ a $i$: el interés deja de ser el precio del ahorro y pasa a ser el precio de la liquidez» (enlace con `keynes-teoria-general`).

**Gráficos de referencia:** `oposicion/temario/fuentes/3A04/graficos/modelo-neoclasico.tex` (2 paneles: (a) trabajo en $(L,w)$, demanda $w=8-L/2$, oferta $w=1+L$, $E=(L^c,w^c)=(14/3,17/3)$; (b) $(Y,P)$ con la OA vertical en $Y_F=7$ y 2 DA cuantitativas, $MV=30$ y $45$; **misma escala que `keynesiano-shock.tex` del 3.A.28** para comparar) y `fuentes/3A33/graficos/fondos-prestables.tex` (**el de referencia de los fondos prestables**; el 3.A.4 lo copia sin cambios).

**Tabla de referencia:** `tab:supuestos` del 3.A.4 (I.1, neoclásicos frente a Keynes) y `tab:politicas` (II.2).

## Cómo se adapta en cada tema

| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.4 | Keynes frente al modelo que critica | desarrollo (hecho, 4/11/2026) | I.3 a)-c) con los 3 mercados, implicaciones y el gráfico; el anexo A mercado a mercado | — |
| 3.A.33 | Consumo y ahorro | resumen (hecho, 31/10/2026) | Los fondos prestables con $r$ y $r^n$ (anexo), gráfico de referencia | La teoría cuantitativa |
| 3.A.28 | Paro | resumen (hecho, 31/10/2026) | El paro neoclásico (voluntario, o por un salario real por encima de $w^c$) y el mercado de trabajo en el anexo | Los fondos prestables |
| 3.A.25 | Mercado de trabajo | resumen (hecho, 31/10/2026) | Oferta y demanda de trabajo con $w^c$, $L^c$ | — |
| 3.A.5 | Síntesis | mención (hecho, 3/11/2026) | Los neoclásicos en la contextualización: mercados que se vacían y teoría cuantitativa | — |
| 3.A.3 | Los economistas neoclásicos | resumen (previsto) | Las piezas por autor (Marshall, Wicksell y $r^n$, Fisher, 1911, y Cambridge con $k$, Pigou); el modelo agregado, con `\vertema{3.A.4}` | El modelo agregado y su gráfico |
| 3.A.35 | Demanda de dinero | resumen (previsto) | La teoría cuantitativa (su tema de referencia, ficha `teoria-cuantitativa`) con $MV=PY$ y $M^D=kPY$ | Trabajo y fondos prestables |
| 3.A.2 | Los clásicos | mención (prevista) | La ley de Say; el «clásicos» de Keynes (anexo B del 3.A.4) | — |

## Divergencias encontradas en el temario actual

- **Resuelto en el 3.A.4 (4/11/2026)**: «Irving Fisher (1896)» → 1911; el nivel de precios en el cruce de la DA con «la oferta de dinero» → con la OA vertical; solo «paro friccional» → friccional y voluntario; «terminología de J. S. Mill» para los fondos prestables → Robertson y Ohlin; $w^*$, $L^*$, $Y^*$ → $w^c$, $L^c$, $Y_F$; la imagen de otro preparador (P3) rehecha como `modelo-neoclasico`.
- **Pleno empleo $Y_F$ frente a producción natural $Y^n$**: el 3.A.4 y el 3.A.28 escriben $Y_F$ (pleno empleo de Keynes y de los neoclásicos); el 3.A.5 escribe $Y^n$ en `da-oa.tex` (la natural, la de la tasa natural de paro de Friedman). Son conceptos distintos y los 2 son canon (`notacion.md` § 8); véase `pendientes-coherencia.md`, «Pendiente del 3.A.4».

Autor: Víctor Gutiérrez Marcos
