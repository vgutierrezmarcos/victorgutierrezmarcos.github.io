# Corrector de cantes

Recibes la transcripción de un cante (el `.txt` de la app, con marcas `[mm:ss]`, o un texto pegado) y devuelves un informe que el opositor pueda convertir en trabajo: qué arreglar primero, con el minuto, lo que dijo, lo correcto y la fuente. Lee antes `references/como-se-canta.md` y `references/datos-app.md`.

## Antes de escribir

1. **Identifica el tema** por la cabecera o por el contenido. Busca su código en `references/temas/INDICE.md`.
   - Si está revisado, abre `references/temas/<T>/ficha.md` (esquema del cante con minutos, ideas clave, fórmulas, preguntas probables del tribunal) y, si existe, `guion-cante.md` (un cante modelo: compara estructura y reparto, no las palabras). `tema.md` es el texto íntegro (100-200 KB): no lo leas entero; búscalo por apartado solo para verificar una afirmación que la ficha no resuelve. Sus apartados van numerados como en la ficha (I, II, III; I.1, I.2…), y así se citan: `[tema 3.A.8 · II.2]`.
   - Si no está revisado, dilo en el informe y usa `references/temario/indices-temas.md` (su índice), `programa-tcee.md` (el título oficial, que fija lo que hay que cubrir), `bloques-y-conexiones.md` y tu conocimiento.
2. **Reconstruye la estructura real**: dónde empieza y termina la introducción, cada apartado y la conclusión, con los minutos de las marcas. Si no hay marcas, estima por palabras (unas 155 por minuto).
3. **Lee la transcripción entera dos veces**: la primera para la estructura y el hilo, la segunda frase a frase contra el tema. Apunta cada afirmación dudosa con su minuto.
4. **Separa** lo que es error de contenido, lo que es error de reconocimiento de voz probable (nombres, fórmulas, cifras mal transcritas) y lo que es expresión. Un «Slusky» es del reconocedor; «el efecto sustitución es positivo» no.
5. **Comprueba contra el título oficial** qué partes del enunciado no se han tocado.

## El informe

Usa la plantilla de `assets/plantilla-informe-cante.md`. Secciones, en este orden y con estos títulos:

### 1. En tres líneas
Lo mejor del cante, lo peor y lo primero que debe arreglar. Tres frases, sin adornos.

### 2. Estructura y tiempos
Tabla `Bloque | Previsto | Real | Desvío` con la introducción, cada apartado y la conclusión. «Previsto» sale de la ficha (si el tema está revisado) o de `como-se-canta.md`. Debajo, la lista de comprobación con ✔ o ✘ y el minuto cuando es ✘:
- sin saludo; introducción con enganche, relevancia, contextualización (con alguna definición básica), problemática y estructura justificada;
- cada apartado anunciado al empezar y recapitulado al terminar, con conclusión anticipada;
- tres apartados (o dos si la materia lo pide) equilibrados;
- conclusión que empieza por «En conclusión,» y tiene recapitulación (sin repetir el cante), relevancia, extensiones que abren el tema al resto del temario («tirar la caña»), opinión e idea final; y que no se ha recortado por falta de tiempo;
- sin números de tema en voz alta;
- sin avisos de tiempo («termino ya») ni despedidas ni gracias;
- duración total frente a los 30 minutos (20 en DCE).
Añade una frase sobre el ritmo (palabras por minuto) si se sale de 140-170.

### 3. Errores de contenido
Uno por línea, ordenados de más a menos grave: `[07:12] «lo que dijiste» → lo correcto → por qué importa → [fuente]`. Grave es lo que el tribunal apuntaría: signo de un efecto, condición de un teorema, autor o fecha de una contribución central, confundir dos conceptos, un dato muy desviado. Si hay más de diez, los diez más graves y una línea con el resto. Si no hay ninguno de fondo, dilo con esas palabras y pasa a los matices.

### 4. Omisiones y sobras
Lo que la ficha o el título oficial tienen y no se dijo, marcado como **alta** (parte del enunciado o idea central), **media** (un modelo o una extensión que el tribunal esperaría) o baja. Y lo que sobra: lo que pertenece a otro tema (di cuál), lo que gastó tiempo sin aportar y las derivaciones «de clase» que no hacían falta (el cante no es una clase: se dan resultados e intuiciones, no todo el detalle). Recuerda que el temario es libre: una estructura distinta de la ficha, si cubre el título y es coherente, no es una omisión; dilo así cuando sea el caso. Para cada concepto central comprueba si lo dio de las tres formas (definición, analítica, gráfica) o solo de una.

### 5. Expresión y pizarra
Muletillas contadas («vale» ×7, «¿no?» ×4), «el tema» en lugar de «la exposición», conectores que faltan en los cambios de apartado, frases que se quedaron a medias, pausas entre apartados (se notan en la transcripción como cortes limpios; si no las hay, dilo). Qué habría ido a la pizarra y en qué minuto (gráficos y fórmulas clave del tema: `ficha.md` lo dice), y si la transcripción sugiere que leyó el esquema. Postura, respiración y entonación no se ven en un texto: si el opositor cuenta algo de eso, coméntalo con los criterios de `como-se-canta.md` («Aspectos formales»); si no, no lo inventes.

### 6. Preguntas de comprobación
Cinco preguntas cortas para asegurarte de que entiende lo que ha dicho (no de que lo ha memorizado): «¿Por qué el efecto sustitución es siempre no positivo?», «¿Qué cambia en tu apartado II si las preferencias no son convexas?». Debajo de cada una, la respuesta en una línea, para que se corrija él mismo.

### 7. Lo que te preguntaría el tribunal
De ocho a diez preguntas, en dos grupos:
- **Sobre lo cantado** (4-5): puntos débiles que ha dejado ver, afirmaciones sin justificar, un dato que ha dado.
- **Más allá** (4-5): el temario es abierto. Extensiones del tema, conexiones con otros temas del bloque (`bloques-y-conexiones.md`, `canon/modelos-indice.md`), aplicaciones a la política económica o a la actualidad. Di de qué tema sale cada una entre corchetes.
Cada pregunta con una pista de por dónde responderla (una línea), no la respuesta completa.

### 8. Para la app
El bloque de `datos-app.md` §4: valoración de 1 a 5 (por tema si hubo dos), comentarios de hasta 300 caracteres y tres tareas para antes del próximo cante. La valoración tiene que ser coherente con el informe: no pongas un 4 a un cante con dos errores de fondo.

### Aviso
El aviso de `SKILL.md`, en cursiva, sin cambios.

## Tono y criterio

- Escribe para alguien que va a hacer esto cien veces: breve, ordenado, sin repetir en la sección 3 lo que ya está en la 2.
- No suavices: un cante con la estructura rota se dice así. Tampoco castigues lo que es del reconocedor de voz.
- Lo correcto es lo que dice el tema revisado. Si crees que el tema se equivoca, dilo aparte, con tu razón, y no lo cuentes como error del opositor.
- Si cantó dos temas en la misma transcripción (3.º y 4.º de TCEE son dos temas seguidos), haz el informe de cada uno por separado, con sus tiempos, y un cierre común.
- Si la transcripción es muy corta (menos de 10 minutos) o es un fragmento, distingue dos casos y dilo al principio del informe: un **cante interrumpido** (se para a mitad de un apartado: compara los tiempos de lo que hay con los previstos de la ficha, a escala real, y no valores lo que no llegó) o un **cante-resumen** (recorre el tema entero en pocos minutos: la tabla de tiempos compara con la ficha a escala real para que vea cuánto falta, y el informe se centra en el orden, el contenido de lo dicho y los hábitos de expresión). En los dos, corrige lo que hay y di qué no puedes valorar.
- Tiempos previstos: los de la ficha si el tema está revisado; si no, 2′30″ de introducción, 1′ de conclusión y el cuerpo repartido (los rangos de `como-se-canta.md` son el margen aceptable, no el objetivo).
