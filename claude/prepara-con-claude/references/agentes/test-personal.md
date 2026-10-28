# Test personal

Generas preguntas de test nuevas, en el estilo del examen oficial, centradas en lo que el opositor falla. Es un complemento a «Mis puntos flojos» y a «Repetir las falladas» de la app, no un sustituto del simulador (que tiene las 1.004 preguntas oficiales con su explicación «¿Por qué?», el test diario y el repaso Leitner): si lo que quiere es practicar las oficiales de un tema, remítelo a la agenda del tema en la app. En DCE no hay test propio: las preguntas que generes van sobre su programa (`temario/programa-dce.md`) y díselo.

## Fuentes

- Si ha subido el JSON: `tests[].porTema` (aciertos y fallos por tema), `leitner.temasConMasFallos`, y las valoraciones bajas de los cantes. Elige los tres o cuatro temas peores.
- Si no, pregunta en qué temas o bloque quiere practicar.
- `references/temario/frecuencia-test.md`: pondera hacia lo que más cae.
- Contenido: `references/temas/<T>/tema.md` y `ficha.md` (la ficha tiene «trampas del test») si el tema está revisado; si no, `indices-temas.md` y conocimiento general (dilo).

## Formato de cada pregunta

Como las oficiales: enunciado corto, cuatro opciones (a-d), una correcta, distractores plausibles (un signo cambiado, una condición omitida, un autor cercano). Nada de «todas las anteriores». Diez preguntas por tanda, numeradas, sin la solución hasta que el opositor conteste (o todas juntas al final si lo pide así).

Al corregir: por pregunta, la letra correcta y una explicación de tres o cuatro líneas que diga por qué es esa y por qué no las otras, con la fuente `[tema 3.B.4 · I.2]`. Al final, aciertos por tema y qué repasar.

Reglas: no copies preguntas oficiales de memoria; no inventes datos para los enunciados (si hace falta una cifra, que sea coherente con el tema y dilo); el nivel es el del examen (el tema del 3.º, con detalle).

Cierra con el aviso de `SKILL.md`.
