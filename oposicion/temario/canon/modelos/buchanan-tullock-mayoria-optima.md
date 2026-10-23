# Mayoría óptima de Buchanan y Tullock (1962) y unanimidad de Wicksell

- **Área:** sector público · **Tema de referencia:** 4.B.2 (reglas de votación) — el que lo desarrolla en el 4.º, con Wicksell y la democracia representativa. El 3.A.24 lo resume con el modelo completo (i) supuestos, ii) desarrollo, iii) implicaciones), el gráfico de referencia y la evidencia (**hecho, 22/10/2026**, III.2.4 `sec:otras-reglas`, `eq:mayoria-optima` y `fig:buchanan-tullock`). Posible referencia doble como Borda o Condorcet (3.er ejercicio primero, `CRITERIOS.md` § 6): **[decidir]**, propuesta de la fase canon del 3.A.24, sin aplicar.
- **Temas que lo usan:** 4.B.2 (desarrollo), 3.A.24 (resumen; hecho, 22/10/2026), 3.A.23 (mención de Wicksell; hecho, 21/10/2026, ficha `lindahl`).
- **Manuales de referencia:** Buchanan y Tullock, *The Calculus of Consent* (1962); Wicksell (1896); Mueller, *Public Choice III*, cap. 4.

## Presentación de referencia (3.A.24, III.2.4)

**Pregunta:** ¿qué mayoría debería exigirse para aprobar una decisión colectiva?

**Unanimidad de Wicksell** (1896), con a) Idea y b) Valoración: una propuesta sale solo si nadie se opone; es la regla que exige Pareto (solo aprueba mejoras de Pareto; base de Lindahl, \vertema{3.A.23}); pero negociar es caro, da a cada uno derecho de veto y favorece el *statu quo* (una minoría, incluso de uno, bloquea: el veto del Consejo Europeo de 2023 del enganche del 3.A.24) y anima a ocultar la valoración. Nunca «tiranía de las minorías» atribuida a Baumol (3.A.22, 3.A.24: «derecho de veto», sin atribución).

**Mayoría óptima, supuestos:** el ciudadano elige la regla en una fase **constitucional**, sin saber si estará en la mayoría o en la minoría en cada votación futura, y quiere minimizar lo que le cuesta la regla. 2 costes según la mayoría exigida $M$, entre el 0 % y el 100 % de los votantes (§ 12 de `notacion.md`; siglas en redonda, `\mathrm{CE}`, `\mathrm{CD}`):
- **costes externos** $\mathrm{CE}(M)$: lo que pierde quien queda en minoría; **decrecientes**, nulos con unanimidad;
- **costes de decisión** $\mathrm{CD}(M)$: tiempo y recursos para reunir la mayoría; **crecientes**.

**Ecuación** (`eq:mayoria-optima`): $M^*=\arg\min_M\,[\mathrm{CE}(M)+\mathrm{CD}(M)]$.

**Implicaciones:** no hay una mayoría óptima para todo: más alta cuanto más graves e irreversibles son las decisiones (derechos fundamentales, reformas constitucionales), más baja para las ordinarias.

**Evidencia (3.A.24):** Constitución española (mayoría simple en las leyes ordinarias; absoluta del Congreso en las orgánicas, art. 81; 3/5 de cada Cámara en la reforma ordinaria, art. 167; 2/3, disolución y referéndum en la agravada, art. 168); en el Consejo de la UE, mayoría cualificada como regla general y unanimidad para fiscalidad, política exterior y marco financiero; **Ley de Propiedad Horizontal**, art. 17 (redacción del RDL 7/2026): unanimidad para el título constitutivo y los estatutos, 3/5 para la portería o las mejoras no exigibles, mayoría para el ascensor y la accesibilidad, un tercio para telecomunicaciones o renovables; mayorías dobles (propietarios y cuotas) y ausentes que no se oponen en 30 días a favor. Shapley-Shubik (1954) en nota: el poder de voto ponderado (ficha `nucleo-shapley`, \vertema{3.A.14}).

**Valoración:** explica por qué las democracias combinan reglas según la decisión; supone costes conocidos en la fase constitucional y deja fuera a quién decide en la práctica: democracia representativa y elección pública (anexo D del 3.A.24, \vertema{3.A.23}, \vertema{4.B.2}).

**Gráfico de referencia:** `oposicion/temario/fuentes/3A24/graficos/buchanan-tullock.tex` (3.A.24, 22/10/2026; lo reutilizará el 4.B.2). Eje horizontal $M$ de 0 a 100 %; $\mathrm{CE}(M)=9(1-M)^2$ decreciente y nulo en $M=1$; $\mathrm{CD}(M)=1+5M^3$ creciente; su suma en U con mínimo en $M^*\approx0{,}65$, **a la derecha del corte de las 2 curvas** ($M\approx0{,}55$): el óptimo está donde las pendientes se compensan ($-\mathrm{CE}'=\mathrm{CD}'$), no donde los costes se igualan, y el gráfico no debe sugerir que coinciden (Víctor, 23/10/2026). En el cante, boceto (unos 20″) o de palabra.

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 4.B.2 | Reglas de votación | desarrollo | Wicksell, modelo con el mismo gráfico `buchanan-tullock.tex` y las mismas siglas; democracia representativa; `\vertema{3.A.24}` para la elección colectiva | — |
| 3.A.24 | Elección social: otras reglas distintas de la mayoría simple | resumen (hecho, 22/10/2026) | Wicksell con a) Idea y b) Valoración; Buchanan-Tullock con i)-iii), gráfico, Constitución, UE y Ley de Propiedad Horizontal; Shapley-Shubik en nota | La elección pública (al anexo D) |
| 3.A.23 | Otras formas de revelar las preferencias | mención (hecho, 21/10/2026) | La unanimidad de Wicksell protege a cada uno pero da poder de veto (ficha `lindahl`) | El modelo |

## Divergencias encontradas en el temario actual
- Resueltas en el 3.A.24 revisado (22/10/2026): «costes de la decisión» decrecientes y «de la no-decisión (según José Luis, costes externos)» crecientes (nombres cambiados) → $\mathrm{CE}(M)$ decrecientes y $\mathrm{CD}(M)$ crecientes; el gráfico dibujado a mano, rehecho en TikZ con los nombres correctos.
- La ficha decía que no había `.tex`: lo creó el 3.A.24.
