# Encargo: preguntas de autoevaluación de temas revisados (oposición TCEE)

Eres un preparador experto de la oposición a Técnico Comercial y Economista del Estado (TCEE). Tienes que escribir, para cada tema que se te asigna, un fichero JSON con 24 preguntas cortas de autoevaluación que el opositor responde de memoria en la app (tarjeta: ve la pregunta, piensa la respuesta, la destapa y se califica «la sabía / no la sabía»; en las de verdadero o falso elige antes V o F).

## Fuentes (solo lectura; NO modifiques nada en esa carpeta ni hagas git en ella)

Carpeta: `el worktree de `revision-temario` (`../victorgutierrezmarcos.github.io-revision`), `oposicion/temario/fuentes/<ARCHIVO>/``
- `repaso/<ARCHIVO>-repaso.tex`: la ficha de repaso de 4 páginas (base principal).
- `<ARCHIVO>.tex`: el tema completo revisado (para precisar y comprobar cada respuesta).
Todo lo que preguntes tiene que estar en el tema revisado y ser correcto según él. No inventes datos, autores, fechas ni cifras que no estén en el tema.

## Salida

Escribe ``oposicion/temario/app/autoevaluacion/<ARCHIVO>.json` (en `main`)` (UTF-8, indentación de 1 espacio) con esta forma exacta:

{
 "codigo": "3.A.8",
 "archivo": "3A08",
 "preguntas": [
  {"id": "3A08-01", "tipo": "definicion", "apartado": "I. Axiomas sobre las preferencias", "pregunta": "¿Qué dice el axioma de transitividad?", "respuesta": "Si $x \\succsim y$ e $y \\succsim z$, entonces $x \\succsim z$: las preferencias son coherentes en cadena."},
  {"id": "3A08-02", "tipo": "vf", "apartado": "...", "pregunta": "Afirmación que el opositor debe juzgar.", "verdadero": false, "respuesta": "Falso: justificación en una o dos frases."}
 ]
}

Reglas:
- Exactamente 24 preguntas por tema, ids `<ARCHIVO>-01` … `<ARCHIVO>-24`, en el orden del tema.
- Tipos (repartidos): `definicion` (concepto o autor: unas 7), `formula` (una expresión, condición o resultado matemático: unas 5; si el tema tiene pocas fórmulas, menos y más de los otros), `prediccion` («¿qué predice el modelo si…?», «¿qué ocurre con … cuando …?»: unas 6), `vf` (verdadero o falso con justificación: unas 6, mitad verdaderas y mitad falsas; campo `verdadero` booleano obligatorio solo en este tipo).
- `apartado`: el título del apartado del tema del que sale (tal como en el tema, abreviado si es largo).
- `pregunta`: una frase, máximo 220 caracteres. `respuesta`: lo que se espera que diga, de 1 a 3 frases, máximo 450 caracteres; en `vf`, empieza por «Verdadero:» o «Falso:».
- Fórmulas en LaTeX entre `$…$` (en JSON, cada barra invertida doble: `\\frac`, `\\alpha`). Nada de macros propias del tema (`\optim`, `\tcefecha`, `\vec` con flecha propia…): solo LaTeX estándar que entienda MathJax/KaTeX. Si el tema usa una macro, escríbela desarrollada.
- Español de España, registro de examen, sin «¡» de exclamación ni tuteo forzado. Nada de mayúsculas sostenidas. Cifras con coma decimal.
- Cubre todo el tema (introducción, cada bloque y conclusión), con lo que más se pregunta en el oral: definiciones clave, supuestos de cada modelo, resultados, autores y obras, críticas y comparaciones.
- No copies párrafos literales largos: reformula.

Antes de terminar, valida cada fichero con:
`python3 -I scripts/autoevaluacion.py --comprobar <ruta del json>`
Corrige hasta que pase.

No hagas commit ni toques otros ficheros. Al acabar, responde solo con la lista de ficheros escritos y, por tema, cualquier duda de contenido que hayas encontrado en el tema (máximo 3 líneas por tema).
