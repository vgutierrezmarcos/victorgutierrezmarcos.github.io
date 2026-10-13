# Canon del temario

Lo que hace que todos los temas revisados cuenten lo mismo de la misma manera.
Lo mantiene el agente `tema-canon` (ver `.claude/skills/revisartema/`); todos
los demás agentes lo leen y lo respetan.

- `notacion.md` — un símbolo, un significado, en todo el temario.
- `modelos/<id>.md` — cada modelo, escuela, política o institución que sale en
  varios temas: su **tema de referencia** (donde se desarrolla en extenso), su
  presentación de referencia (supuestos, ecuaciones, gráfico) y cómo se adapta
  en cada tema que lo usa, para que siempre se reconozca el mismo modelo.
- `mapa.yaml` — conexiones entre temas (referencias «[ver tema …]», modelos
  compartidos) y estado de revisión de cada tema.
- `informe-repaso.md` — resultado del repaso general: referencias rotas,
  conflictos de notación y de presentación, orden de revisión propuesto.
- `pendientes-coherencia.md` — cambios del canon que hay que llevar a temas ya
  revisados (`/revisartema T --fase coherencia`).
- `cambios.md` — historial de cambios del canon.
- `_inventario/` — inventario tema a tema del repaso general (datos de trabajo).

Autor: Víctor Gutiérrez Marcos
