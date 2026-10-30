# Simulacro completo del ejercicio oral

Reproduces el examen oral de principio a fin, como lo hace la pantalla «Cantar» de la app, y añades lo que la app no hace: la corrección y el tribunal. Vale para TCEE 3.º y 4.º (dos temas, uno de cada parte) y para DCE 3.º. Lee `references/oposiciones/tcee.md` (o `dce.md`), `references/como-se-canta.md` y `references/la-app.md`.

**Cuándo**: «hazme un simulacro», «simulacro completo», «quiero hacer el examen entero». Si solo quiere preguntas, es `tribunal.md`; si manda un cante ya hecho, `corrector-cante.md`.

**Qué lees**: la oposición y el ejercicio (del JSON o preguntándolo en una línea); si adjunta `oposicion_*_para_claude.json`, `temas.estudiados` (bolsa del sorteo), `cantes[]` (para ponderar y para el cierre) y `examen.fechas`; los títulos oficiales en `references/temario/programa-tcee.md` o `programa-dce.md`.

## Pasos, por turnos (un mensaje por paso; espera la respuesta antes de seguir)

1. **Sorteo.** Dos bolas por parte (A y B del ejercicio). Bolsa: el programa entero, salvo que pida solo los estudiados (o el JSON los traiga y lo prefiera). Con JSON, pondera como la app: peso de cada tema = (6 − valoración media de sus cantes) / (1 + veces cantado), con valoración 3 si nunca lo ha valorado; sin JSON, al azar simple. Sortea de verdad (con código si puedes ejecutarlo; si no, sin mirar qué le convendría) y muestra las cuatro bolas con su código y su título oficial. Pide que elija uno de cada parte.
2. **Elección.** Anota el elegido y los descartados de cada parte. Si ha elegido un tema que el JSON da por flojo, no lo digas ahora: va en el cierre.
3. **Esquema a ciegas.** Da la hora de inicio y la de fin: 45 minutos para los dos temas en TCEE, 30 en DCE, sin material. Pide que avise al acabar y no digas nada del contenido hasta entonces (ni pistas, ni «recuerda que…»). Puede hacerlo en la app (Cantar → Esquema a ciegas) y mandarte la foto o el PDF del esquema.
4. **Exposición.** Cuando avise: 30 minutos por tema en TCEE (20 en DCE), primero el de la parte A. Pide que cante con el cronómetro de la app y «Transcribir» activado (o grabándose) y que te adjunte o pegue la transcripción (`cante_*.txt`); si no puede transcribir, que te mande el esquema y un resumen con los minutos de cada apartado, y dilo en el informe como limitación. Cuenta el tiempo real si se pasa o se corta.
5. **Corrección.** Con la transcripción (y el esquema, si lo mandó), aplica `corrector-cante.md` entero: un informe por tema, con su nota sobre 10, y un cierre común si cantó los dos. Si solo cantó uno, corrige ese y dilo. Guarda las notas: el tribunal las ajusta.
6. **Tribunal.** Sigue con `tribunal.md`: 8-10 preguntas por turnos, partiendo de lo débil del informe y de lo que dejó en la conclusión; hasta 30 minutos en TCEE, 15 en DCE.

## Cómo termina

1. **Informe del simulacro** (tras el tribunal), un solo documento con la estética del informe del cante:
   - **Cabecera**: la tabla de `assets/plantilla-informe-cante.md` con una fila por tema y una última fila `Ejercicio` con la nota del ejercicio (la media de los temas).
   - **Visión general** del examen entero y **Lo primero que arreglar**, como en el cante.
   - **Resumen**: la elección (qué eligió y si era la mejor opción a la vista del JSON, `[cantes de la app]`); el esquema (si cupo en el tiempo, qué apartado faltó); tiempos reales por tema frente a los previstos; los dos o tres errores que más le habrían costado, con su fuente.
   - **El diálogo con el tribunal · {ajuste}**: una tabla `Pregunta | Tema | Respuesta | Valoración` (la pregunta en una línea, de qué tema sale, lo que respondió en una línea y ✔ bien, ▲ incompleta o ✕ mal) y debajo, con las mismas marcas que el cante (✓ ✕ con `**E7 · grave**` y su `> **Corrección.**`, ▲), lo que defendió bien y lo que no; la numeración de los errores sigue la de los informes. Ajuste de −1,0 a +0,5 por tema: +0,5 si corrigió sus errores y razonó lo que no sabía; 0 si respondió lo esencial; negativo si repitió el error, inventó o no supo lo básico de lo que cantó.
   - **Desglose por tema**: el `Desglose de la nota` de cada cante con una fila más, `Diálogo con el tribunal`, y la nota del tema. Es orientativa: el tribunal puntúa de 0 a 20 por tema con mínimo de 10 (5 sobre 10); dilo en una línea.
   - Después, los **informes de cada tema** completos (`corrector-cante.md`), uno detrás de otro, sin repetir su visión general en el resumen.
2. **Para la app**: el cante tal como lo guarda el diario (`datos-app.md` §4), con la primera línea del simulacro: `Sorteados: 3.A.8, 3.A.11 · 3.B.4, 3.B.9 · Cantado: 3.A.8, 3.B.4 · Descartados: 3.A.11, 3.B.9`; valoración por tema y general (de la nota con el diálogo); criterios si usa la rúbrica; apartados cubiertos; comentarios de hasta 300 caracteres; tres tareas. Si hizo el esquema a ciegas, su valoración 1-5 en una línea aparte.
3. El PDF del informe como dice «Cómo termina toda entrega» de `SKILL.md`, con el anexo de la transcripción de cada tema (como en `corrector-cante.md`), y el aviso.

Reglas: no acortes los tiempos «para ir más rápido» salvo que lo pida (y entonces dilo en el informe); no le des pistas durante el esquema ni la exposición; el simulacro puede partirse en dos conversaciones (hoy el cante, mañana el tribunal) si trae el informe de la primera.
