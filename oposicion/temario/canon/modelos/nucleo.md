# Intercambio de Edgeworth y núcleo de una economía (Debreu y Scarf, 1963)

- **Área:** equilibrio general y bienestar · **Tema de referencia:** **3.A.21** (La teoría del equilibrio general; revisado el 14/10/2026, III.1 y III.2) — lo desarrolla con estructura a)-e) como fundamento del equilibrio walrasiano sin subastador. Ficha creada a raíz de esa revisión.
- **Temas que lo usan:** 3.A.21 (desarrollo; hecho), 3.A.14 (mención: desarrolla el núcleo como concepto de solución de un juego cooperativo con utilidad transferible, «vectores de pagos», id `nucleo-shapley`; el núcleo de una economía, con remisión a 3.A.21 — ya en sus `faltan` de `mapa.yaml`).
- **Manuales de referencia:** Edgeworth (1881); Gillies (1959); Shubik (1959); Debreu y Scarf (1963); Aumann (1964, 1975); Hildenbrand y Kirman (1988); Mas-Colell, Whinston y Green (1995), cap. 18; Gravelle y Rees (2004), cap. 12; Varian (1992), cap. 21.

## Presentación de referencia (3.A.21)
Pregunta: ¿se puede fundamentar el equilibrio walrasiano sin subastador ni precios dados, dejando que los agentes negocien?

- **Intercambio de Edgeworth** (III.1): 2 agentes, 2 bienes, dotación ω⃗ en la caja de intercambio (la misma de I.3), negociación con recontratación. Un acuerdo final cumple **racionalidad individual** (dentro de la **lente** de las curvas de indiferencia U_A⁰, U_B⁰ que pasan por ω⃗) y **eficiencia** (en la curva de contrato): el tramo **CC′**. Con 2 agentes el resultado está **indeterminado** (depende del poder negociador; 3.A.14); el equilibrio walrasiano E es uno de esos puntos, el único con precios dados y comunes. Conjetura de Edgeworth: con más agentes, el tramo se estrecha hasta E.
- **Núcleo** (III.2): economía de intercambio con I consumidores; la utilidad **no es transferible** (se intercambian bienes). Una coalición 𝒮 ⊆ {1,…,I} **bloquea** (x⃗_i) si existe (x⃗′_i)_{i∈𝒮} con Σ_{i∈𝒮}x⃗′_i = Σ_{i∈𝒮}ω⃗_i, x⃗′_i ≿_i x⃗_i para todo i ∈ 𝒮 y ≻_i para alguno. **Núcleo**: asignaciones factibles que ninguna coalición bloquea; con 2 agentes, el tramo CC′.
- **Implicaciones:** (1) todo equilibrio walrasiano está en el núcleo (basta la no saciedad local); (2) **teorema del límite** (Debreu y Scarf, 1963): con r réplicas de cada tipo y preferencias estrictamente convexas, el núcleo se encoge hasta el conjunto de equilibrios walrasianos; Aumann (1964): con un continuo de agentes, núcleo = equilibrios. La precio-aceptación pasa de supuesto a resultado. Extensión: valor de Shapley con un continuo de agentes (Aumann, 1975).
- **Valoración:** exige muchos agentes, convexidad y coaliciones sin coste; no es un proceso. Enlaza con el comportamiento estratégico (Negishi, 1961; Gabszewicz y Vial, 1972; Roberts y Postlewaite, 1976: la ganancia de manipular tiende a 0) y el monopolio en la caja (punto M sobre OD_A, ineficiente; recuadro).
- **Antecedente terminológico:** el núcleo (*core*) lo define Gillies (1959) en juegos cooperativos; Shubik (1959) lo relaciona con la curva de contrato.

Gráficos de referencia: `oposicion/temario/fuentes/3A21/graficos/caja-intercambio-nucleo.tex` (lente, tramo CC′ y su reducción hacia E al replicar; capas 9-10 de la caja maestra `caja-intercambio.tex`) y `monopolio-intercambio.tex` (recuadro).

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.21 | Fundamentos del equilibrio walrasiano sin subastador | desarrollo (hecho, 14/10/2026) | Todo lo anterior, sobre la caja de intercambio que sigue en la pizarra | El concepto de juego cooperativo con utilidad transferible y el valor de Shapley en detalle (3.A.14) |
| 3.A.14 | Juegos cooperativos | mención | Núcleo de un juego (función característica v(T), imputaciones x_i, utilidad transferible); una línea: en una economía de intercambio sin utilidad transferible, el núcleo converge al equilibrio competitivo (Debreu y Scarf, 1963), con remisión a 3.A.21 | La caja y el teorema del límite |

## Divergencias encontradas en el temario actual
- 3.A.21 original definía el núcleo en la caja de la **producción** («que las empresas actúen de forma racional») y en III.2 sobre coaliciones de consumidores: contradicción interna y error de concepto. Resuelto (14/10/2026): una sola definición, en la caja de intercambio.
- 3.A.14 (Word ajeno, sin revisar) define el núcleo como «vector de pagos» con utilidad transferible y 3.A.21 original lo mezclaba con el valor de Shapley: en 3.A.21, «asignaciones» sin utilidad transferible; en 3.A.14, pagos con utilidad transferible. Notación de coalición: T ⊆ N en juegos (`notacion.md` § 4) y 𝒮 en la economía (§ 5), porque S es el número de estados.

Autor: Víctor Gutiérrez Marcos
