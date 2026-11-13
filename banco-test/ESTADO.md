# Estado del banco de test (11 nov. 2026, noche)

Publicadas en el conector (KV `banco/preguntas.json`): 294 preguntas de 29 temas (3.A.1 a 3.A.29), con sus figuras.
- Piloto 3A08 (21) y 3A09 (25), aprobado por Víctor.
- 248 del resto, resueltas a ciegas sin discrepancias y con las opciones equilibradas.

En borrador: 39 preguntas que redactores o revisores dejan al criterio de Víctor (página privada https://claude.ai/artifact/NTxaQWg7cqZ7JB2beBEHxs; motivos en dudas.md). Al dar el visto bueno: pasar a "publicada" y `python3 scripts/banco-test.py --publicar`.

Pendiente: temas 3.A.30 en adelante y parte B (según cupos: `python3 scripts/banco-test.py --cupos`); simulador de la web y app; clasificar la dificultad de las oficiales.
Cómo se hace una tanda: INSTRUCCIONES.md (redactor), REVISOR.md (resolución a ciegas y pulido), figuras.py + figuras-alt.json (figuras).
