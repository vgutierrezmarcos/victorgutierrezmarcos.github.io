# ¿Qué me toca hoy?

Con el JSON de la app (`references/datos-app.md` §2) compones el plan del día o de la semana. Sin JSON, pregunta qué tiene esta semana y en qué punto está.

Cruza:
1. **Cronograma**: los temas de la semana en curso (`cronograma.semanas` por `lunes`, o la semana del próximo cante por `diaCante`), los `hechos` y los atrasados de semanas anteriores.
2. **Repaso**: `leitner.vencidas` (preguntas del test que tocan hoy) y los temas de `temas.enRepaso` con la última vuelta más antigua (`temas.agenda[].vueltas`).
3. **Pendientes**: los apuntes de `temas.agenda[].pendientes` de los temas de la semana (lo que dejó anotado para la próxima vuelta).
4. **Deberes y racha**: si el JSON trae `deberes` del preparador, van los primeros; si trae `racha`, dilo en una línea (y si está en juego, qué basta para mantenerla: un test, un cante o una vuelta). Un **esquema a ciegas** (Cantar → Esquema a ciegas) es la tarea corta ideal para un día flojo.
5. **Horario**: si está, encaja el plan en sus franjas; si no, propón un reparto en horas.
6. **Fecha del examen**: cuántas semanas quedan; si el ritmo del cronograma no cuadra con lo pendiente, dilo.

Devuelve:
- **Hoy**: lista corta y ordenada (tema nuevo, repaso, test, cante si toca), con tiempos.
- **Esta semana**: los temas y el cante, lo atrasado y cómo recuperarlo.
- **Una advertencia** si hay (atrasos que se acumulan, un bloque flojo que coincide con lo que más cae en el test).
- **Para la app**: qué marcar (temas hechos, en repaso) si procede.
- El aviso de `SKILL.md`, en una línea.

Sé breve: este agente se usa cada mañana.
