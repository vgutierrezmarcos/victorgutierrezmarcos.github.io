# La ley de Say (ley de los mercados) y el debate del exceso general de oferta

- **Área:** pensamiento · **Tema de referencia:** **3.A.2** para la ley y sus debates clásicos (revisado el 4/11/2026: II.2 `sec:say`, «Jean-Baptiste Say (1767-1832)», con `eq:say`; Ricardo, II.3.3; Malthus, II.4.3; Mill, II.5.3) y **3.A.4** para la crítica de Keynes (II.1 y anexo B: la ley de Say es lo que une a los «clásicos» de la *Teoría general*; ficha `keynes-teoria-general`). Ficha creada en la fase canon del 3.A.2 (6/11/2026; CC5, D10, **opcional, [decidir]**; *alternativa*: dejar el id `ley-de-say` como alias de `modelo-clasico-neoclasico`); el id estaba en la lista del 3.A.2 en `mapa.yaml` sin ficha. Relacionadas: `modelo-clasico-neoclasico` (la ley dentro del modelo agregado de partida), `equilibrio-general-walras` (la ley de Walras, que no es la de Say), `patinkin` (la dicotomía), `keynes-teoria-general`, `malthus-poblacion`, `marx` (en sus crisis falla la ley de Say).
- **Temas que lo usan:** 3.A.2 (desarrollo; hecho, 4/11/2026); 3.A.4 (resumen; hecho, 4/11/2026: la ley de Say en la formulación de Lange, l. 430, y su ataque, l. 428; $D(L)=Z(L)$ para cualquier $L$, l. 299; la fila «Ley de Say» de `tab:supuestos`, l. 129; «la oferta crea su propia demanda (la ley de Say)», l. 31); 3.A.21 (mención; hecho, 14/10/2026: la nota de la l. 342, «no debe confundirse con la ley de Say», con Lange, 1942, y la misma frase que el 3.A.2; Mill, 1844, en el anexo, l. 906); 3.A.34 (mención; hecho, 31/10/2026: «para los clásicos la inversión no era un problema de demanda… (ley de Say)», l. 47); 3.A.3, 3.A.5 y 3.A.7 (mención; hechos: la frase común «con precios y salarios flexibles los mercados se vacían y el dinero solo determina el nivel de precios»); 3.A.42 (hecho, 4/11/2026, ver la tabla; mención: el *general glut* de 1819-1824 y el subconsumo).
- **Manuales de referencia:** Say (1803), *Traité d'économie politique*, libro I, cap. XV, «Des débouchés» (`Say1803Traite`); James Mill (1808), *Commerce Defended* (`MillJames1808Commerce`); Say (1820), *Lettres à M. Malthus* (`Say1820Lettres`); Sismondi (1819), *Nouveaux principes* (`Sismondi1819Nouveaux`); Malthus (1820), *Principles* (`Malthus1820Principles`); Ricardo (1821), cap. 21; J. S. Mill (1844), ensayo II (`Mill1844Essays`); Keynes (1936), cap. 2; **Lange (1942)**, «Say's Law: A Restatement and Criticism» (`Lange1942Say`); **Becker y Baumol (1952)**, «The Classical Monetary Theory: The Outcome of the Discussion», *Economica* (`BeckerBaumol1952Classical`); Patinkin (1965).

## Presentación de referencia (3.A.2, II.2)

**Pregunta:** ¿puede haber un exceso de oferta de todos los bienes a la vez?

- **La ley de los mercados** (Say, 1803, libro I, cap. XV, en paráfrasis: sin comillas): un producto, en cuanto se termina, abre una salida a otros productos por todo su valor; los productos se compran con productos y el dinero es solo un medio de cambio. Puede sobrar producción de un bien, pero no de todos a la vez. En inglés la expone antes James Mill (1808). **«La oferta crea su propia demanda» no es de Say**: es como la resume Keynes (1936, cap. 2) para atacarla.
- **En lenguaje moderno** (Lange, 1942): el valor de los excesos de demanda de los bienes, **sin contar el dinero**, es idénticamente nulo; con $n$ bienes de precios $p_k$ y excesos de demanda $z_k(\vect p)$ (los del 3.A.21):
$$\sum_{k=1}^{n}p_k\,z_k(\vect p)\equiv 0\qquad(\texttt{eq:say})$$
  **Frase común** (3.A.2, tras `eq:say`; 3.A.21, nota de la l. 342; 3.A.4, l. 430): «No debe confundirse con la ley de Walras, que es una identidad que incluye todos los mercados, también el del dinero; y es la que Keynes critica: en una economía monetaria, un exceso de oferta de bienes puede ir acompañado de un exceso de demanda de dinero».
- **Identidad e igualdad de Say** (Becker y Baumol, 1952): la **identidad** se cumple a cualquier precio y deja al dinero sin papel; la **igualdad** solo se cumple en equilibrio y admite excesos de oferta temporales: es la de J. S. Mill (1844, ensayo II: en una crisis todos quieren vender y nadie comprar, porque todos quieren dinero).
- **El *general glut*** (1819-1824): Sismondi (1819) y Malthus (1820) sostienen que puede faltar demanda efectiva (si los capitalistas ahorran demasiado, hace falta una clase de consumidores improductivos); Say (1820), Ricardo (cap. 21: «nadie produce si no es para consumir o vender, y nadie vende si no es para comprar otra mercancía») y James Mill responden que lo ahorrado se invierte. Ganan los segundos y la ley queda en la ortodoxia hasta Keynes, que en el cap. 23 reivindica a Malthus (`\vertema{3.A.4}`, `\vertema{3.A.42}`).
- **Antecedente en Smith**: lo que se ahorra se gasta igual, pero en trabajadores productivos (libro II, cap. III).
- **Marx**: en sus 3 teorías de la crisis falla la ley de Say (con dinero se puede vender sin comprar).

**Notación:** la de `eq:say` (`notacion.md` § 8, fila de la ley de Say): $k$ índice de bienes y $z_k(\vect p)$ como en el 3.A.21 (§ 0 y § 5); sin símbolos nuevos.

**Gráfico de referencia:** ninguno. En la pizarra, como mucho, $\sum_kp_kz_k(\vect p)\equiv0$ e «identidad / igualdad».

## Cómo se adapta en cada tema

| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.2 | Los clásicos | desarrollo (hecho, 4/11/2026) | Todo lo anterior, en 1′ (II.2) y una frase por autor | La crítica de Keynes en detalle |
| 3.A.4 | Keynes | resumen (hecho, 4/11/2026) | Lange (1942) y el ataque de Keynes: el dinero como depósito de valor; $D(L)=Z(L)$ | El *general glut* |
| 3.A.21 | Equilibrio general | mención (hecho, 14/10/2026) | La nota frente a la ley de Walras, con la misma frase | — |
| 3.A.34 | Inversión | mención (hecho, 31/10/2026) | Para los clásicos la inversión no era un problema de demanda | — |
| 3.A.3, 3.A.5, 3.A.7 | Neoclásicos; síntesis; NEK | mención (hechos) | La frase común de los mercados que se vacían | — |
| 3.A.42 | Ciclos | mención (hecho, 4/11/2026; I.4.1 y anexo A, el *general glut* de 1819-1824) | El *general glut* y el subconsumo de Malthus y Sismondi, con `\vertema{3.A.2}` | La ley |

## Divergencias encontradas en el temario actual

- **3.A.2 (Word)**: Say solo en notas, sin desarrollo (añadido como II.2, A02-01); la frase de Say entre comillas (en paráfrasis: no se ha cotejado la edición francesa). **Resuelto** en la revisión (4/11/2026).
- **Fechas del *general glut***: el 3.A.2 dice 1819-1824; el Word del 3.A.42, 1819-1821 (la polémica Malthus-Ricardo). **Resuelto** el 4/11/2026: el 3.A.42 dice 1819-1824 con Sismondi (1819), Malthus (1820) y Say (1820).

Autor: Víctor Gutiérrez Marcos
