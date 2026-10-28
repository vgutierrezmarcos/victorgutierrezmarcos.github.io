# Informe de la semana

Cada semana, con el JSON exportado de la app y lo que haya de esa semana (los informes de los cantes que te adjunte, o lo que recuerdes de esta conversación o del Proyecto), dices qué ha cambiado respecto a la semana anterior y qué hacer la que viene. Es el complemento de `estadisticas.md` («¿cómo voy?» mira el conjunto; esto mira siete días frente a los siete anteriores). Lee `references/datos-app.md` §2.

**Cuándo**: «¿cómo ha ido la semana?», «hazme el informe de la semana», «resumen semanal». Si no hay JSON, pide que lo exporte (Más → Prepara con Claude → Exportar mis datos para Claude); sin él puedes hacerlo solo con los informes de los cantes, y lo dices.

**Qué lees**: `cantes[]` y `tests[]` de la semana y de la anterior (por `fecha`); `cronograma.semanas` y `hechos`; `leitner.porCaja` y `vencidas`; `racha`; `deberes`; `horario` (para estimar las horas si no las dice). Los informes de los cantes de la semana, si los adjunta: sus secciones 3 y 4 (errores y omisiones) son la materia del apartado 2.

## Formato fijo (cinco apartados, con estos títulos)

1. **La semana en tres líneas.** Qué ha hecho (cantes, tests, temas), lo mejor y lo peor. Con cifras de su JSON.
2. **Qué ha mejorado y qué se repite.** Frente a la semana anterior: valoración media de los cantes, nota del test, tiempo real de los cantes frente a los 30′ (20′ en DCE). Y el error que se repite de un cante a otro (de los informes o de los `comentarios` del diario), con su fuente `[tema · apartado]`. Si solo hay una semana de datos, dilo y no inventes tendencia.
3. **Tests por tema.** Tabla `Tema | Aciertos | Fallos | Semana anterior` con los temas tocados esta semana; los que fallan y caen mucho (`references/temario/frecuencia-test.md`) van primero. Cajas Leitner: cuántas preguntas han subido o bajado de caja si se ve; vencidas pendientes.
4. **Ritmo, racha y horas.** Temas hechos frente a previstos en el cronograma (atraso en temas); racha en días si la tiene activada; horas estimadas (del `horario` o de lo que cuente) y si bastan para el ritmo del cronograma. Semanas que quedan al examen.
5. **Las tres tareas de la semana que viene.** Concretas, ordenadas y con la herramienta: «esquema a ciegas del 3.B.4 el martes», «test de 25 preguntas de los temas 3.A.19 y 3.B.4 (Mis puntos flojos)», «cantar el 3.A.8 con el cronómetro y mandármelo». Si el cronograma tiene temas atrasados, la primera tarea es qué hacer con ellos (y si hace falta replanificar, ofrécelo: `organizador.md`).

Debajo, el bloque **Para la app** solo si hay algo que apuntar (temas que marcar como estudiados o en repaso, deberes que proponer al preparador). El informe se guarda como `.md` y se convierte en PDF como dice «Cómo termina toda entrega» de `SKILL.md`; plantilla en `assets/plantilla-informe-semanal.md`. Cierra con el aviso.

Reglas: sin comparar con nadie; una página; no repitas la lectura general de `estadisticas.md` (si la pide, ofrécela en una línea). Si una semana no tiene datos (vacaciones, enfermedad), dilo sin reproche y centra el informe en cómo retomar.
