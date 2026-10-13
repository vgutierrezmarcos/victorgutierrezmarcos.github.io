# Pendientes de coherencia del canon

Cambios del canon que hay que llevar a temas **ya revisados** con `/revisartema T --fase coherencia`. Cada entrada: tema, qué cambiar, por qué y a raíz de qué. Se marca `[hecho: fecha]` al aplicarla.

Autor: Víctor Gutiérrez Marcos

Los 19 cambios del 3.A.8 de la consolidación (D001-D006) se aplicaron el 13/10/2026 (véase `cambios.md` y `fuentes/3A08/revision.md`). Los del 3.A.11 y del 3.A.9 que tocaban al 3.A.8 (año de `FulekyAnatomy`, $S_{ij}$ en `der:matriz-slutsky`, U(x) y «complementarios netos» en `anexo:sistemas`, remisión a la hessiana del 3.A.9) se aplicaron también el 13/10/2026, junto con el peso τ de las combinaciones convexas. El multiplicador del dual del 3.A.9 queda μ (Víctor, 13/10/2026).

Las decisiones D134-D139 (13/10/2026) no afectan a ningún tema revisado: la única que toca al 3.A.8 (D138) confirma que su remisión a 4.B.6 es solo de ampliación, sin cambios en el tema.

## Pendiente del 3.A.11 (13/10/2026)

- **Comprobado al cerrar el canon del 3.A.11 (13/10/2026):** los demás cambios del canon a raíz del 3.A.11 (símbolos de producción, λ como peso convexo, fichas `cobb-douglas`, `ces`, `leontief`, `progreso-tecnico-neutral`, `rendimientos-escala`) no obligan a cambiar el 3.A.8: ya usa λ ∈ [0,1] en la convexidad, la misma σ y la CES de utilidad sin ν, y remite a 3.A.11 para la producción. Las contradicciones del 3.A.11 con temas sin revisar están en `mapa.yaml` (`contradicciones` de 3.A.11) y se corrigen al revisarlos.

## Pendiente del 3.A.9 (13/10/2026)

Cambios del canon a raíz de la revisión del 3.A.9 (`fuentes/3A09/revision.md`, «Coherencia») que afectan a temas ya revisados. Los que afectan a temas sin revisar (3.A.12, 4.A.1, 4.B.9, 4.B.11) están en `mapa.yaml` (`contradicciones` de 3.A.9).

- [hecho: 13/10/2026] **Fichas del canon corregidas** (no cambian ningún tema revisado: 3.A.8 y 3.A.9 ya están bien): `indices-precios` (signo: $L=\overline W-p^1\cdot x^0\le\mathrm{VC}$, es decir, $p^1\cdot x^0-\overline W\ge-\mathrm{VC}$, y $(p^1-p^0)\cdot x^1\le-\mathrm{VE}$; $I_L$ acota $I_K(\overline U^0)$ e $I_P$ acota $I_K(\overline U^1)$, el mismo índice solo con homotéticas); `ipc` (base 2025 desde el índice de enero de 2026, no 2021); `exceso-gravamen` ($\mathrm{EG}=-\mathrm{VE}-T$, no $VE-T$). Ver `cambios.md`.
- **Comprobado sin cambios:** el 3.A.11 ya da la estimación de Cobb y Douglas (1928) con 1/4 y 3/4, como la nota del 3.A.9; no menciona el Senado, así que no hay contradicción. El 3.A.8 ya usa $\varepsilon^h_{i,p_j}$, $RMS_{12}$ positiva y $k$ como factor de homogeneidad, y cita la metodología del IPC base 2025.
