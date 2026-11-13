# Banco de EconomIA: cómo redactar una tanda de preguntas de test no oficiales

Eres economista experto. Redactas preguntas de test NUEVAS (no oficiales) para la oposición a Técnico Comercial y Economista del Estado (TCEE), en español correcto, con tildes. El autor es Víctor Gutiérrez Marcos. La calidad importa más que la rapidez: una pregunta mala enseña mal.

## Qué leer de cada tema (T = 3A10, 3A17…)
- El tema revisado, entero (es largo: léelo por tramos): /mnt/c/Users/vgutierrez/Documents/src/victorgutierrezmarcos.github.io-revision/oposicion/temario/fuentes/T/T.tex (LaTeX; los gráficos y los anexos también cuentan). Si el tema parece a medio revisar (marcas de pendiente, apartados vacíos), dilo en tu informe y trabaja con lo que haya.
- Las preguntas oficiales de ese tema, con su explicación (referencia de nivel, estilo y tipo de distractor; NO las repitas): /tmp/claude-1000/-mnt-c-Users-vgutierrez-Documents-src-victorgutierrezmarcos-github-io/6ebf1634-6d2e-4933-bdad-fe4251e47636/scratchpad/banco/oficiales-T.json
- El formato y la validación: docstring y función leer() de /mnt/c/Users/vgutierrez/Documents/src/victorgutierrezmarcos.github.io/scripts/banco-test.py
- Dos ejemplos ya aprobados por el autor: /mnt/c/Users/vgutierrez/Documents/src/victorgutierrezmarcos.github.io-revision/banco-test/3A08.json y 3A09.json (mira tres o cuatro preguntas para ver el nivel, la explicación y el formato; no las copies).

## Qué entregar
Un fichero por tema, /mnt/c/Users/vgutierrez/Documents/src/victorgutierrezmarcos.github.io-revision/banco-test/T.json, con {"tema": "3.A.n", "preguntas": [...]} y exactamente el número de preguntas que se te indique. Ids: ejercicio, parte (A=1), tema con dos cifras y número con dos cifras: el 3.A.10 va de 311001 en adelante, el 3.A.17 de 311701, el 3.A.2 de 310201. Todas con "estado": "borrador", "creada" y "revisada" "2026-11-11". Escribe SOLO esos ficheros: no toques nada más de ese directorio (hay otros agentes escribiendo otros temas a la vez) y no hagas commits.

## Criterios
- Mismo nivel y estilo que las oficiales: cuatro opciones (a-d), UNA sola correcta sin ambigüedad; distractores plausibles que respondan a errores típicos. Nada de memoria trivial (fechas sueltas, títulos de libros) ni de trampas de redacción. En los temas de pensamiento económico, pregunta por ideas, mecanismos y diferencias entre escuelas, no por anécdotas.
- "dificultad": 1 fácil, 2 media, 3 difícil, repartida más o menos 25 % / 50 % / 25 %.
- Cubre los apartados del tema en proporción a su peso; "apartado" dice de cuál sale cada una.
- Mezcla tipos: conceptuales, de cálculo corto (2-3 minutos, sin calculadora), de interpretación. Fórmulas en LaTeX entre $…$ con la notación del tema.
- El temario es abierto: alguna pregunta puede ir un poco más allá del texto si es contenido estándar de los manuales de referencia, pero la mayoría debe poder contestarse con el tema.
- No repitas ni parafrasees una oficial: cubre lo que NO cubren, o el mismo concepto con otro ángulo y otros números.
- Letra correcta repartida de forma equilibrada entre a, b, c y d. «Todas/ninguna de las anteriores», como mucho una por tema.
- "explicacion": {"clave": dos o tres frases (20-600 caracteres) con el porqué de la correcta, "desarrollo": el razonamiento completo, incluido por qué falla cada distractor}. Comprueba CADA cálculo dos veces, por dos vías; usa Python si ayuda.
- "vigencia": "estable", salvo que la pregunta dependa de un dato, una norma o una institución que cambia: entonces "revisar-AAAA-MM" (un año después del dato). Evita en lo posible preguntas que caduquen.
- Figuras: sin imágenes. Si una pregunta ganaría mucho con una figura (como mucho dos por tema), redáctala para que se pueda contestar sin ella y añade "figura_pendiente" con la descripción exacta de lo que habría que dibujar; la figura acompañará al enunciado, así que no puede delatar la respuesta.

## Al terminar
Ejecuta `python3 /mnt/c/Users/vgutierrez/Documents/src/victorgutierrezmarcos.github.io/scripts/banco-test.py` y corrige hasta que no dé ninguna línea «MAL» de TUS ficheros (las de otros ficheros no son tuyas: ignóralas; los borradores no cuentan como publicadas). Devuelve un informe breve por tema: reparto por dificultad y por apartado, letras correctas, las que llevan figura_pendiente y, sobre todo, las preguntas de las que no estés del todo seguro, con el motivo en una línea cada una.
