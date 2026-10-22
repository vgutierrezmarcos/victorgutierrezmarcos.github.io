# Teorema de Gibbard (1973)-Satterthwaite (1975)

- **Área:** equilibrio general y bienestar · **Tema de referencia:** 3.A.24 (desarrollos posteriores a Arrow); **hecho, 22/10/2026** (III.3 `sec:informacion`, «Problemas de información: manipulación estratégica y diseño de mecanismos», con a)-c); D3 del 3.A.24). El diseño de mecanismos y el principio de revelación tienen su referencia en el 3.A.14 (ficha `diseno-mecanismos`).
- **Temas que lo usan:** 3.A.24 (resumen; hecho, 22/10/2026), 4.B.2 (mención). Es el límite del diseño de mecanismos en estrategias dominantes; Gibbard (1973) es además uno de los autores del principio de revelación. 3.A.14 (mención; hecho, 19/10/2026: límite del diseño de mecanismos en III.2 d, con `\vertema{3.A.24}`); 3.A.22 y 3.A.23 (mención; hechos, 21/10/2026).
- **Manuales de referencia:** Gibbard (1973); Satterthwaite (1975); Moulin (1980); Reny (2001), «Arrow's Theorem and the Gibbard-Satterthwaite Theorem: A Unified Approach»; Mas-Colell, Whinston y Green, cap. 23.C.

## Presentación de referencia (3.A.24, III.3)

**Idea:** hasta aquí la regla conocía las preferencias; en la práctica cada uno las declara y puede mentir (voto útil, Borda). ¿Hay alguna regla en la que decir la verdad convenga siempre? Es el 2.º problema de información de las reglas de votación (el 1.º, sobre el bienestar, lleva a las FBS).

**Modelo:** una **función de elección social** asigna a cada perfil de preferencias **declaradas** una sola alternativa ganadora (no una ordenación: «regla de agregación» queda para Arrow, ficha `arrow-imposibilidad`). Es **no manipulable** (a prueba de estrategias) si decir la verdad es estrategia dominante para todos.

**Teorema:** con dominio universal y al menos 3 alternativas **que pueden salir elegidas** (la función es **sobreyectiva**), toda función de elección social no manipulable es dictatorial. Dicho de otro modo: toda regla de votación es una dictadura, deja alternativas que nunca pueden ganar o es manipulable. No pide IAI ni transitividad (elige, no ordena); es el análogo de Arrow para los incentivos y se demuestra con la misma idea del votante pivote (Reny, 2001).

**Salidas (restringir el dominio):**
- preferencias **unimodales**: la regla de la mediana de los picos declarados no es manipulable (Moulin, 1980); con los vecinos, al vecino 3 no le sirve declarar otro pico (ficha `votante-mediano`);
- **utilidad cuasilineal y pagos**: Clarke-Groves (decir la verdad es dominante; cada uno paga el daño que su voto causa) (\vertema{3.A.23}, \vertema{3.A.14}; ficha `clarke-groves`).

**Diseño de mecanismos:** se diseña la regla para que el interés de cada uno lleve al resultado deseado; por el **principio de revelación** (Gibbard, 1973; Dasgupta, Hammond y Maskin, 1979; Myerson, 1979) basta con buscar entre los mecanismos directos compatibles con los incentivos (\vertema{3.A.14}); Nobel de 2007 a Hurwicz, Maskin y Myerson «por haber sentado las bases de la teoría del diseño de mecanismos».

**Enunciado común para los temas que solo lo mencionan:** «con 3 o más alternativas (si cualquiera de ellas puede salir elegida) y preferencias sin restringir, toda regla de votación no manipulable es dictatorial». El inciso entre paréntesis es la sobreyectividad (`pendientes-coherencia.md`, 3.A.14, 3.A.22 y 3.A.23, opcional).

**Gráfico de referencia:** no tiene.

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.24 | Desarrollos tras Arrow: problemas de información | resumen (hecho, 22/10/2026) | a) Idea; b) función de elección social, no manipulabilidad y enunciado con la sobreyectividad; relación con Arrow; c) salidas (mediana de Moulin, Clarke-Groves) y diseño de mecanismos con el principio de revelación | La demostración |
| 4.B.2 | Reglas de votación | mención | Toda regla es manipulable: Borda, agenda; con el enunciado común y `\vertema{3.A.24}` | Enunciado formal |
| 3.A.14 | Diseño de mecanismos: límites | mención (hecho, 19/10/2026) | Con 3 o más alternativas y preferencias sin restringir, toda regla no manipulable es dictatorial; por eso VCG necesita pagos monetarios; junto a Myerson-Satterthwaite (1983). Opcional: «(si cualquiera de ellas puede salir elegida)» | La demostración |
| 3.A.22 | *Second best* con información | mención (hecho, 21/10/2026) | En III.3: con preferencias sin restringir, toda regla no dictatorial es manipulable; por eso VCG necesita dinero y cuasilinealidad; `\vertema{3.A.24}`. Opcional: el inciso de la sobreyectividad | El enunciado formal |
| 3.A.23 | Revelación de preferencias | mención (hecho, 21/10/2026) | Límite de Clarke-Groves: sin cuasilinealidad, toda regla no dictatorial es manipulable; `\vertema{3.A.24}`. Opcional: el inciso de la sobreyectividad | El enunciado formal |

## Divergencias encontradas en el temario actual
- Resueltas en el 3.A.24 revisado (22/10/2026): enunciado con los axiomas de Arrow y D'Hondt como ejemplo → función de elección social sobreyectiva con dominio universal; D'Hondt reparte escaños (nota).
- 3.A.14, 3.A.22 y 3.A.23 (revisados): enuncian sin la sobreyectividad; matiz opcional en `pendientes-coherencia.md`.
- 4.B.2 lo enuncia con «U, P y no dictadura» y su nota 23 habla de regla «inmune a la manipulación»: el teorema pide sobreyectividad (o al menos 3 resultados posibles) y no manipulabilidad, no Pareto ni IAI.
