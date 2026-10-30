# Test personal

Haces un test a medida de lo que el opositor falla: primero con **preguntas oficiales** del banco del test (`references/test/`, las 1.004 preguntas de los exámenes desde 2002 con la explicación «¿Por qué?» de la web) y, si no bastan, con preguntas **nuevas** del mismo estilo, marcadas como tales. Es un complemento a «Mis puntos flojos» y a «Repetir las falladas» de la app, no un sustituto del simulador: si lo que quiere es hacer un examen entero o el test diario, remítelo a la app. En DCE no hay test propio: las preguntas que generes van sobre su programa (`temario/programa-dce.md`), todas nuevas, y díselo.

## Fuentes

- **Qué temas**: si ha subido el JSON, `tests[].porTema` (aciertos y fallos por tema), `leitner.temasConMasFallos` y las valoraciones bajas de los cantes; elige los tres o cuatro temas peores y pondera hacia lo que más cae (`references/temario/frecuencia-test.md`). Si no, pregunta en qué temas o bloque quiere practicar.
- **Qué preguntas**: `references/test/INDICE.md` dice en qué fichero de bloque está cada tema; abre solo esos ficheros y busca `### 3.B.4 ·`. No repitas las que el JSON dice que ya ha hecho bien: en `oposicion_*_datos.json`, `leitner.questions` lleva por `id` `timesCorrect` y `timesFailed` (descarta las que tienen `timesCorrect ≥ 2` y ningún fallo reciente; prioriza las falladas); en `oposicion_*_para_claude.json` no vienen los `id`, así que prioriza los exámenes más antiguos (los que menos se practican) y dilo.
- **Contenido** para las nuevas y para ampliar las explicaciones: `references/temas/<T>/ficha.md` («trampas del test») y `tema.md` si el tema está revisado; si no, `indices-temas.md` y conocimiento general (dilo).

## Formato de cada pregunta

Diez por tanda (o las que pida), numeradas, sin la solución hasta que conteste (o todas juntas al final si lo pide así). Cada una con su cabecera corta:

- Oficial: `1. [3.B.4 · marzo 2026, pregunta 12]` y debajo el enunciado y las cuatro opciones tal como están en el banco (no las retoques; si tiene figura, descríbela como hace el banco y di que está en el simulador).
- Nueva: `7. [3.B.4 · nueva]`: enunciado corto, cuatro opciones (a-d), una correcta, distractores plausibles (un signo cambiado, una condición omitida, un autor cercano). Nada de «todas las anteriores». No copies preguntas oficiales de memoria ni inventes datos (si hace falta una cifra, que sea coherente con el tema y dilo).

Reparto: todas oficiales si hay bastantes del tema sin hacer; si no, completa con nuevas y di cuántas de cada. En una tanda de un bloque entero, al menos una por tema.

En el chat, en texto; si quiere practicar con botones, en un artefacto interactivo con la estética de la app; si lo quiere imprimir, en PDF con la plantilla (`references/documentos-y-graficos.md`, apartado 3). Si una pregunta necesita un gráfico, dibújalo como los de los temas revisados (mismo fichero, apartado 2).

## Al corregir

Por pregunta: la letra correcta y el porqué en tres o cuatro líneas. En las oficiales, usa la explicación del banco (la «clave») y amplíala con la ficha si hace falta, con la fuente `[test 2026-marzo · 12]` y `[tema 3.B.4 · I.2]`; en las nuevas, por qué es esa y por qué no las otras, con la fuente del tema. Al final: aciertos por tema, qué repasar (apartado del tema) y, **Para la app**, la línea «Repetir las falladas» o «Mis puntos flojos» del simulador para seguir con las oficiales de esos temas, y los temas que convendría marcar en repaso.

El nivel es el del examen (el tema del 3.º, con detalle). Cierra con el aviso de `SKILL.md`.
