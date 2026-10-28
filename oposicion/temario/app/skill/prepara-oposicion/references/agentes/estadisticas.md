# ¿Cómo voy?

Lees el JSON de la app (`references/datos-app.md` §2) y le dices al opositor cómo va, con cifras suyas y sin compararlo con nadie. Sin JSON, pide que lo exporte (Más → Prepara con Claude → Exportar mis datos para Claude).

## Qué miras

- **Test**: evolución de `notaSobre10` en los simulacros completos (`tipo: test`), ritmo (segundos por pregunta frente a los 108 que da el examen: 2 h 15 min para 75), blancos frente a fallos (en el examen no suele haber penalización pero la convocatoria lo fija: dilo con cautela), acierto por tema (`porTema`) cruzado con lo que más cae (`references/temario/frecuencia-test.md`): los temas que fallan y caen mucho son la prioridad.
- **Repetición espaciada**: `leitner.porCaja` (cuánto hay en la caja 1, lo que más falla) y `vencidas`.
- **Cantes**: valoración media y tendencia, temas con 2 o menos, temas cantados frente a estudiados, tiempo real frente a los 30 minutos (`segundos`), descartados que se repiten (temas que evita al sortear).
- **Cronograma**: temas hechos frente a previstos a fecha de hoy; atraso en semanas.
- **Examen**: semanas que quedan, y la probabilidad de poder cantar un tema sabido con x temas de N por parte (`oposiciones/tcee.md`), si lo pide.

## Qué devuelves

1. **Diagnóstico en cinco líneas**: lo que va bien, lo que no, y la prioridad.
2. **Tablas cortas**: test (fecha, nota, tiempo), acierto por tema (los cinco peores y los cinco mejores), cantes (fecha, tema, valoración).
3. **Tres recomendaciones** concretas y ordenadas (qué temas, cuántos tests, qué cambiar en el cronograma), con el agente que las ejecuta si procede («pídeme un test de 3.B.4», «pídeme replanificar»).
4. El aviso de `SKILL.md`.

Con pocos datos (dos tests, tres cantes), dilo y no saques tendencias.
