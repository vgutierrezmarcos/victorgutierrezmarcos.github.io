# Criterios de compensación (Kaldor, Hicks, Scitovsky, Little, Samuelson, Gorman)

- **Área:** equilibrio general y bienestar · **Tema de referencia:** **3.A.22** (Bienestar I; revisado el 21/10/2026, anexo `anexo:compensacion`, con una viñeta en I.3 `sec:valoracion-pareto`). Motivo: el contenido estaba en el Word del 3.A.22 (su bloque 2 entero) y los temas revisados (3.A.9) ya remiten aquí; con el título de 2023 los criterios salen del título y pasan a un anexo (decisión A22-01, opción a, provisional) en lugar de irse al 3.A.24, que deja un resumen. **[decidir]** (D1 del 3.A.22): si Víctor prefiere que el desarrollo sea del 3.A.24, la ficha cambia de referencia y el 3.A.9 remite a los 2.
- **Temas que lo usan:** 3.A.22 (desarrollo en anexo; hecho, 21/10/2026), 3.A.24 (resumen: la nueva economía del bienestar antes de las FBS; hoy menciona la compensación con Pareto), 3.A.9 (mención; hecho, 13/10/2026: VC, excedentes y Kaldor-Hicks, l. 1262 y 1378, con `\vertema{3.A.22}`), 4.B.6 (mención: el análisis coste-beneficio aplica Kaldor-Hicks al sumar excedentes; le falta la remisión, `mapa.yaml`).
- **Manuales de referencia:** Kaldor (1939), *EJ*; Hicks (1939), *EJ*; Scitovsky (1941), *REStud*; Little (1949, 1950), *A Critique of Welfare Economics*; Samuelson (1950), *OEP*; Gorman (1955), *REStud*; Mas-Colell, Whinston y Green, cap. 22.C; Boadway y Bruce, *Welfare Economics* (1984), cap. 4.

## Presentación de referencia

**Pregunta:** ¿se pueden comparar 2 estados sociales que el criterio de Pareto no ordena sin hacer juicios de valor interpersonales? Es la respuesta de la «nueva economía del bienestar» (London School of Economics) a la incompletitud de Pareto.

**Idea:** renunciar a la unanimidad a cambio de la **compensación potencial**: un cambio es una mejora si los que ganan *podrían* compensar a los que pierden y seguir ganando, aunque la compensación no se pague.

**Supuestos:** 2 consumidores A y B; cada estado social (una producción eficiente distinta) tiene su FPU en el espacio $(U_A,U_B)$; utilidad ordinal sin comparaciones entre personas.

**Los criterios, en este orden** (el del anexo del 3.A.22):
1. **Kaldor (1939):** desde el estado **final**, una redistribución a lo largo de la FPU del estado final deja a todos mejor que en el inicial.
2. **Hicks (1939):** desde el estado **inicial**, los perdedores no pueden sobornar a los ganadores para que renuncien al cambio y quedar todos mejor.
3. **Paradoja de Scitovsky (1941):** si las 2 FPU se cortan, Kaldor y Hicks pueden contradecirse (reversión); **doble criterio**: exigir los 2.
4. **Little (1949, 1950), criterio dual:** el doble criterio más que la distribución no empeore (distancia del rayo de cada punto a la bisectriz); puede contradecir a Pareto.
5. **Samuelson (1950):** la situación 2 es mejor si su FPU está **entera por fuera** de la del 1: transitivo pero casi nunca aplicable; compara situaciones (conjuntos), no asignaciones.
6. **Gorman (1955):** con 3 o más situaciones, el doble criterio puede ser intransitivo.

**Valoración:** la compensación potencial encierra una comparación interpersonal implícita (si no se paga, los perdedores pierden de verdad); los criterios que ordenan mucho son contradictorios o intransitivos y el que no lo es apenas ordena. **Herencia:** el análisis coste-beneficio (Kaldor-Hicks al sumar excedentes, 3.A.9 y 4.B.6) y la vertiente distributiva de las FBS (3.A.24).

**Gráficos de referencia** (espacio de utilidades, puntos numerados 1, 2, … y FPU$_1$, FPU$_2$; puntos de las otras FPU con letras griegas α, β, γ, δ, ε, ζ), uno por criterio, con 2 tablas de cumplimiento (`tab:compensacion-scitovsky`, `tab:compensacion-little`):
- `oposicion/temario/fuentes/3A22/graficos/compensacion-kaldor.tex`
- `oposicion/temario/fuentes/3A22/graficos/compensacion-hicks.tex`
- `oposicion/temario/fuentes/3A22/graficos/compensacion-scitovsky.tex`
- `oposicion/temario/fuentes/3A22/graficos/compensacion-little.tex` (2 paneles: FPU que no se cortan y que se cortan)
- `oposicion/temario/fuentes/3A22/graficos/compensacion-samuelson.tex`

## Cómo se adapta en cada tema

| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.22 | Incompletitud de Pareto | desarrollo en anexo (hecho, 21/10/2026) | En el cuerpo, una viñeta en la valoración de Pareto (I.3) con remisión al anexo; en el anexo, los 6 criterios con sus 5 gráficos y 2 tablas, y la valoración | — |
| 3.A.24 | FBS y elección colectiva | resumen | De la compensación potencial (Kaldor-Hicks, Scitovsky) a las FBS (Bergson, Samuelson): la comparación interpersonal implícita lleva a hacerla explícita; `\vertema{3.A.22}` | Los gráficos y Little, Gorman |
| 3.A.9 | Medidas del bienestar | mención (hecho, 13/10/2026) | Variación compensatoria y compensación de los perjudicados «como en el criterio de Kaldor y Hicks», con `\vertema{3.A.22}` | Los criterios |
| 4.B.6 | Evaluación de políticas, ACB | mención | El ACB suma excedentes: aplica Kaldor-Hicks (compensación potencial) con sus límites; `\vertema{3.A.22}` | Los criterios |

## Divergencias encontradas en el temario actual
- `mapa.yaml` listaba el id en el 3.A.22 sin ficha (corregido el 21/10/2026, fase canon del 3.A.22).
- `informe-repaso.md` § 7 mandaba el desarrollo al 3.A.24 (resumen): el 3.A.22 lo conserva en anexo (A22-01); el 3.A.24, cuando se revise, resume y remite.
- Word del 3.A.22: Little «tanto el punto 2 como el 6» cumplen Kaldor y Hicks (son 2, 3, 4, 5 y 6; Little se queda con 2, 4 y 5): corregido en la revisión.
