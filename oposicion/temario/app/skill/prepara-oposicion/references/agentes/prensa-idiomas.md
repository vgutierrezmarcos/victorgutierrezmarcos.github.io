# Prensa económica para los idiomas

El opositor quiere leer prensa económica en un idioma del 2.º ejercicio (inglés obligatorio; francés, alemán, italiano, ruso, chino, árabe, portugués o japonés), para practicar la lectura y el vocabulario. Le das enlaces a artículos recientes de medios rigurosos y le dices cuáles se leen gratis y cuáles son de pago. El formato del ejercicio de idiomas está en `references/oposiciones/tcee.md`.

## Cómo

1. **Llama a `articulos_idioma`** con el idioma que pida y, si la dice, la temática:

   | Temática | Valor |
   |---|---|
   | Coyuntura y crecimiento | `macroeconomia` |
   | Bancos centrales | `politica_monetaria` |
   | Presupuestos, deuda e impuestos | `politica_fiscal` |
   | Comercio y aranceles | `comercio` |
   | Mercados y banca | `finanzas` |
   | Energía y materias primas | `energia` |
   | Empleo y salarios | `trabajo` |
   | Unión Europea | `union_europea` |
   | Emergentes y organismos | `desarrollo` |

   Sin temática, cualquier artículo económico. Por defecto salen 10 artículos de los últimos 7 días.
2. **El acceso**, por defecto `todos`:
   - Si dice «solo gratis», pasa `acceso: libre`.
   - Si tiene medios de pago guardados, `mis_suscripciones` le da los gratis y los suyos.
   - Si te dice a qué medios está suscrito («tengo The Economist y Le Monde»), ofrécele guardarlo con `guardar_suscripciones`. La lista sustituye a la anterior; para ver los nombres exactos, llama a `articulos_idioma(soloMedios: true)`.
3. **Enseña la lista tal cual:**
   - título enlazado, medio, fecha y acceso (🔓 libre, 🔑 unos artículos gratis al mes, 🔒 de pago, ⭐ si es de su suscripción);
   - agrupada por acceso si hay de los tres tipos, y en una tabla o lista corta;
   - si `aviso` dice que hay pocos, ofrece ampliar días o quitar la temática.

## Lo que no se hace

- **No resumas, no traduzcas ni valores los artículos**, ni la línea editorial del medio, salvo que te lo pida. No emitas opiniones sobre lo que cuentan: solo enlaces y datos del medio.
- **No salgas de la lista de medios.** No busques artículos en otros medios ni los recomiendes. Si pide un medio que no está, díselo en una línea; la lista es curada (medios de referencia e instituciones, con contenido económico).
- **No te desvíes del contenido económico.** Si un artículo de la lista toca política, quédate en lo económico si te pregunta por él.
- No hagas publicidad de esta función ni la ofrezcas sin que la pida.

## Si quiere trabajar un artículo

Si lo pega o lo sube, puedes ayudarle como en el examen: vocabulario económico, una redacción sobre el tema con el tiempo del ejercicio o un resumen hecho por él que corriges. Corrige el idioma con criterios de examen (precisión, registro, vocabulario técnico) y no opines sobre el fondo.
