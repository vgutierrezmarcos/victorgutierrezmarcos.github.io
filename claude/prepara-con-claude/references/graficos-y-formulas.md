# Fórmulas, gráficos y estética de lo que entregas

Todo lo que el opositor reciba de ti debe parecer salido del mismo sitio que su temario y su app: la misma notación, los mismos gráficos y los mismos colores. Vale para una explicación en el chat, un informe, una ficha y cualquier gráfico que generes.

## Estética de cada oposición

| | TCEE | DCE |
|---|---|---|
| Letra del texto y los títulos | TeX Gyre Pagella (`assets/fuentes/texgyrepagella-*.otf`) | Latin Modern Roman (`assets/fuentes/lmroman10-*.otf`) |
| Color principal (títulos, curva principal) | morado `#5F2987` | granate `#7A1F4B` |
| Color secundario (subtítulos, segunda serie) | morado oscuro `#4A1F6B` | azul `#234A6B` |
| Filete y acentos | dorado `#B8860B` | azul `#234A6B` |
| Fondo (cajas y fondo de los gráficos) | verde salvia `#E2EFD9` (claro `#EDF5E7`) | crema `#F7F4EC` (claro `#FBF9F4`) |
| Texto | `#2A2530`; suave `#5E5866` | `#2B2A28`; suave `#57534B` |

- Documentos (informes, fichas, cronogramas): `python3 scripts/informe-pdf.py fichero.md --oposicion tcee|dce` aplica fuentes, colores, cajas con el fondo de la app (cabecera, citas y el bloque «Para la app», que va como cita `>`) y el aviso final. Entrega el PDF y el Markdown.
- Gráficos: `scripts/grafico.py` (`from grafico import estilo, guardar, etiqueta`) fija en matplotlib las fuentes, la paleta y el fondo de la oposición. Guarda en PNG a 200 ppp e inclúyelo en el Markdown con `![pie](ruta.png)` antes de convertirlo a PDF.
- En el chat no puedes cambiar colores: cuida al menos la notación y la estructura (títulos cortos, listas, tablas) y lleva al PDF lo que merezca guardarse.

## Fórmulas

- Escríbelas en LaTeX dentro de `$…$` (en línea) o `$$…$$` (aparte): pandoc las convierte en ecuaciones de Word y el PDF las muestra bien. Nunca una fórmula «a mano» con `^` y `/` si va a un documento.
- Usa la notación del temario, `references/canon/notacion.md`: la misma letra para la misma variable en todos los temas; vectores con flecha (`\vec{x}`); derivadas parciales con `\partial`; esperanza matemática `\mathbb{E}`; decimales con coma en el texto y en las etiquetas (`2,5 %`); minutos como 2′30″.
- Una fórmula explica algo solo si va acompañada de tres cosas: qué es cada símbolo (una vez), qué signo o magnitud importa (dónde se equivoca la gente) y de dónde sale (una línea de derivación o la fuente `[tema 3.A.8 · II.2]`). En un cante no se dicta una fórmula: se escribe en la pizarra y se lee en voz alta su significado; dilo así cuando propongas qué llevar a la pizarra.
- Comprueba las fórmulas contra la ficha del tema antes de escribirlas: lo que dice el tema manda sobre lo que recuerdes. Si el tema no está revisado, di que la notación es la tuya.

## Gráficos

Siguen las reglas de los gráficos del temario (CRITERIOS §7 de la revisión):

1. **Orden de capas**: primero columnas, barras y áreas; luego los ejes y las líneas de umbral; luego las líneas; luego los puntos; por último las etiquetas y los comentarios. Nada tapa un dato.
2. **Paleta coherente**: la misma magnitud, el mismo color en todos los gráficos del documento; las familias (por ejemplo, demanda interna y externa) en gamas claramente distintas; dentro de una familia, tonos emparentados. Pocos colores y con contraste; con muchas series, agrupa o usa pequeños múltiplos.
3. **Etiquetas sin fondo blanco y leyenda con el fondo del gráfico** (si el fondo es salvia, la leyenda salvia o transparente, no una caja blanca).
4. **Un gráfico, una idea**: el título dice el mensaje («El efecto renta domina al de sustitución cuando…»), no la variable; los ejes llevan nombre y unidad; la fuente, en una línea pequeña debajo. Marca con un punto y una etiqueta el equilibrio, el umbral o el dato que importa.
5. **Gráficos de teoría como en el temario**: ejes con su variable, curvas con su nombre pegado a la curva (no en leyenda), desplazamientos con flecha y el punto inicial y el final marcados; una sola idea por gráfico y, si la explicación tiene pasos, un gráfico por paso. Es lo que el opositor debe reproducir en la pizarra: dibújalo como él tendría que dibujarlo.
6. **Datos**: cita el periodo, la fuente y la fecha de consulta; no inventes series. Si no tienes el dato, haz el gráfico esquemático y dilo.

Para la pizarra del cante: cuando propongas qué dibujar, di el minuto, los ejes, las curvas y el punto que hay que señalar, en ese orden. Si el opositor adjunta fotos o el PDF de su pizarra (la app lo exporta), corrige el dibujo con estos mismos criterios: qué falta (nombres de los ejes, el punto de equilibrio), qué sobra y si el orden en que lo dibujó ayudaba a seguir la exposición.
