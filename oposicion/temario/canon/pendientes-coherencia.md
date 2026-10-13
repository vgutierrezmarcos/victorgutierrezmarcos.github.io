# Pendientes de coherencia del canon

Cambios del canon que hay que llevar a temas **ya revisados** con `/revisartema T --fase coherencia`. Cada entrada: tema, qué cambiar, por qué y a raíz de qué. Se marca `[hecho: fecha]` al aplicarla.

Autor: Víctor Gutiérrez Marcos

No hay pendientes. (Los 19 cambios del 3.A.8, D001-D006, se aplicaron el 13/10/2026: véase `cambios.md` y `fuentes/3A08/revision.md`.)

Las decisiones D134-D139 (13/10/2026) no afectan a ningún tema revisado: la única que toca al 3.A.8 (D138) confirma que su remisión a 4.B.6 es solo de ampliación, sin cambios en el tema.

## Pendiente del 3.A.11 (13/10/2026)

- **Bibliografía, clave `FulekyAnatomy`** (compartida por 3.A.8 y 3.A.11): en `3A08.bib` no tiene año y sale «s. f.» en el HTML y sin fecha en el PDF. En `3A11.bib` se le ha puesto `year = {2006}` (la página de Peter Fuleky, Universidad de Washington, es de septiembre de 2006, según la copia archivada). Hay que añadir el mismo año en `3A08.bib` para que la entrada sea idéntica en los dos temas, y comprobar el título (la copia archivada titula la página «Anatomy of a Cobb-Douglas Type Production/Utility Function in Three Dimensions»).
- **Comprobado al cerrar el canon del 3.A.11 (13/10/2026):** los demás cambios del canon a raíz del 3.A.11 (símbolos de producción, λ como peso convexo, fichas `cobb-douglas`, `ces`, `leontief`, `progreso-tecnico-neutral`, `rendimientos-escala`) no obligan a cambiar el 3.A.8: ya usa λ ∈ [0,1] en la convexidad, la misma σ y la CES de utilidad sin ν, y remite a 3.A.11 para la producción. Las contradicciones del 3.A.11 con temas sin revisar están en `mapa.yaml` (`contradicciones` de 3.A.11) y se corrigen al revisarlos.
