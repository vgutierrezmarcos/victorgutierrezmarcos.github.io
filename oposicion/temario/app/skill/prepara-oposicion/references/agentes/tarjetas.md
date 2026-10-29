# Tarjetas de repaso (Leitner)

Haces tarjetas de pregunta y respuesta de un tema para el repaso espaciado, en un fichero que la app importará (Estudiar → Repaso espaciado → Traer tarjetas; mientras esa pantalla no exista, el opositor las usa desde el fichero o pegadas en la app de tarjetas que prefiera). Formato en `references/datos-app.md` §6.

**Cuándo**: «hazme tarjetas del 3.A.8», «flashcards», «tarjetas de repaso espaciado», «preguntas y respuestas cortas para repasar».

**Qué lees**: `references/temas/<T>/ficha.md` si el tema está revisado (las tarjetas salen de la ficha: ideas clave, definiciones, fórmulas, autores y fechas, «trampas del test», preguntas probables del tribunal); si no, `references/temario/indices-temas.md` y conocimiento general, y lo dices en la primera línea. Si adjunta el JSON, mira `tests[].porTema` y `leitner.temasConMasFallos` para cargar más tarjetas en lo que falla; si adjunta el informe de un cante, una tarjeta por error de contenido.

## Cómo las haces

- **De 20 a 40 por tema** (unas 25 para un tema normal; 40 si el tema tiene muchos modelos o datos). Si pide menos, las más importantes.
- **Una idea por tarjeta**: pregunta corta y respuesta que quepa en dos líneas (una definición exacta, un signo, una condición, un autor y su año, una fórmula con el nombre de sus símbolos, un dato con fecha y fuente). Nada de «explica el modelo de…»: eso no se repasa en diez segundos.
- **Reparto**: un tercio de definiciones y conceptos, un tercio de resultados y condiciones (qué pasa si…, cuándo no se cumple…), el resto de autores, fechas, fórmulas y datos. Al menos tres «trampas»: lo que se confunde en el test (signo del efecto sustitución, Hicks frente a Slutsky, elasticidad renta frente a precio).
- **Fórmulas** en LaTeX sencillo (`$\partial x_i / \partial p_j$`), sin dólares dobles ni entornos; notación del canon (`references/canon/notacion.md`).
- Sin números de otros temas en la respuesta; si la respuesta remite a otro tema, nómbralo por contenido.
- No copies frases largas de la ficha: reformula en tus palabras y cita el apartado solo en la tabla previa, no en la tarjeta.

## Qué devuelves

1. Una línea con el tema, de dónde salen las tarjetas y cuántas son.
2. El fichero `tarjetas_<tema sin puntos>.txt` (por ejemplo `tarjetas_3A08.txt`) con el formato de `datos-app.md` §6, en un bloque de código para que se copie limpio (y como fichero adjunto si puedes crearlo).
3. **Para la app**: «Estudiar → Repaso espaciado → Traer tarjetas → pegar o abrir el fichero»; y, si ha pedido tarjetas de un tema que no tiene en repaso, sugiere marcarlo en repaso.
4. El aviso de `SKILL.md`, en una línea. No hace falta PDF.
