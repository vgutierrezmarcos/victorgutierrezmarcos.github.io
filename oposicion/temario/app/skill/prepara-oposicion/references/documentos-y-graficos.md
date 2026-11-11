# Gráficos, test y documentos en el chat

El opositor puede pedirte en cualquier momento un gráfico de un tema («dibújame el efecto sustitución de Slutsky», «el IS-LM con una expansión fiscal», «la evolución del paro desde 2008»), unas preguntas tipo test o un documento («hazme un resumen del 3.A.8 en PDF», «un esquema de la parte B», «la ficha de este cante»). Todo tiene que salir **con la misma estética que su temario**: los gráficos, como los de los temas revisados; los documentos, con la plantilla de los temas de su oposición (TCEE o DCE). Este fichero dice cómo, tengas la skill instalada o solo el conector. Las reglas de contenido (notación, capas, un gráfico una idea) están en `references/graficos-y-formulas.md`: léelas antes.

## 1. Prepara el entorno (una vez por conversación)

- **Con la skill instalada** (Claude Code, Claude Desktop o la skill subida a claude.ai): ya tienes `scripts/` y `assets/` en la carpeta de la skill.
- **Solo con el conector** (claude.ai en la web o el móvil): si puedes ejecutar código, descarga el kit (scripts, plantilla LaTeX, fuentes y plantillas; nada exclusivo) y úsalo desde ahí:

```python
import io, sys, urllib.request, zipfile
for url in ('https://www.victorgutierrezmarcos.es/oposicion/temario/app/skill/kit-documentos.zip',
            'https://raw.githubusercontent.com/vgutierrezmarcos/victorgutierrezmarcos.github.io/main/oposicion/temario/app/skill/kit-documentos.zip',
            'https://cdn.jsdelivr.net/gh/vgutierrezmarcos/victorgutierrezmarcos.github.io@main/oposicion/temario/app/skill/kit-documentos.zip'):
    try:
        zipfile.ZipFile(io.BytesIO(urllib.request.urlopen(url, timeout=30).read())).extractall('.')
        print('kit descargado de', url); break
    except Exception as e:
        print('no se pudo con', url, '→', e)
sys.path.insert(0, 'kit/scripts')   # from grafico import …; el PDF: python3 kit/scripts/informe-pdf.py
```

- **Si no hay red ni ejecución de código**: haz los gráficos en SVG y los documentos en HTML, como artefactos, con las plantillas de los apartados 2.3 y 4.3, y di en una línea que, para tener el PNG o el PDF con la letra exacta, el opositor puede activar en claude.ai **Ajustes → Capacidades → Ejecución de código** con acceso a la red (o añadir `victorgutierrezmarcos.es` a los dominios permitidos). No lo repitas en cada respuesta.

La oposición sale de lo que sepas del opositor (conector: `leer_progreso`; si no, pregunta una vez). Preparador de DCE y opositor a TCEE a la vez: la estética es la de la oposición del documento, no la de la persona.

## 2. Gráficos

### 2.1 De teoría: como los de los temas revisados

Los gráficos de los temas revisados se dibujan en TikZ con unos estilos fijos (`tikz-tcee.tex`). `grafico.py` los reproduce en matplotlib con los mismos nombres:

| En el temario (TikZ) | En `grafico.py` | Cómo se ve |
|---|---|---|
| `\ejes{x}{y}{largo}{alto}` | `ejes(ax, '$x$', '$y$', largo, alto)` | ejes negros con flecha, el nombre en la punta y el 0 en el origen; sin marco, rejilla ni números |
| `curva1` … `curva4` | `curva(ax, xs, ys, 1…4, '$D$')` | línea gruesa morada (1), azul (2), verde (3) o dorada (4), con su nombre al final y en su color; nunca leyenda |
| `curvanueva`, `desplazada` | `curva(…, 'nueva')`, `desplazada=True` | la curva tras el cambio, en rojo o discontinua |
| `punto` + `label` | `punto(ax, x, y, '$E_0$')` | punto negro con la etiqueta sin caja |
| `\proyeccion` / `guia` | `proyeccion(ax, x, y, '$x^*$', '$p^*$', ejes_='xy')` | guías grises discontinuas a los ejes con los valores en gris |
| `flecha` | `flecha(ax, (x0, y0), (x1, y1))` | el desplazamiento o el movimiento, en rojo |
| `area`, `area2` | `area(ax, xs, ys)`, `area(…, dorada=True)` | región pálida morada o dorada (excedentes, conjuntos, pérdidas) |
| nodos de texto | `nota(ax, x, y, 'texto\notra línea')` | comentario sin caja, junto a lo que explica |

```python
from grafico import teoria, ejes, curva, punto, proyeccion, flecha, area, nota, guardar_teoria
fig, ax = teoria('tcee')                    # 'dce': granate y azul, Latin Modern; paneles=2 para dos gráficos juntos
ejes(ax, '$Q$', '$P$', 6, 5)
curva(ax, [0.5, 5], [4.5, 0.8], 1, '$D$')
curva(ax, [0.5, 5], [0.8, 4.5], 2, '$S$')
curva(ax, [0.5, 5], [1.6, 5.3], 'nueva', "$S'$", desplazada=True)
punto(ax, 2.75, 2.65, '$E_0$'); proyeccion(ax, 2.75, 2.65, '$Q_0$', '$P_0$')
flecha(ax, (3.6, 2.2), (3.1, 2.9))
guardar_teoria(fig, 'oferta.png')          # PNG a 200 ppp, fondo blanco
```

Coordenadas sencillas (de 0 a 6 o 7), rectas o curvas suaves calculadas (`numpy`), nombres en notación del temario (`$\vec{x}^0$`, `$U(\vec{x})$`, `$IS$`, `$LM$`), los pasos de una explicación en paneles (`paneles=2` o `3`) o en gráficos sucesivos. Es lo que el opositor tendrá que dibujar en la pizarra: que se pueda copiar a mano.

### 2.2 De datos: como los del dictamen

`estilo('tcee')` (o `'dce'`) para el fondo, la letra y la paleta, y `COLORES_DATOS` para que cada concepto lleve el color de la guía del dictamen: PIB morado, consumo privado naranja, inversión verde, demanda externa azul claro, España rojo, zona del euro azul marino, inflación negro (subyacente discontinua), energía bermellón, paro teja… Capas en orden (barras → cero y umbrales → líneas → puntos → etiquetas), título con el mensaje, fuente y fecha de consulta debajo (`guardar(fig, ruta, titulo=…, fuente=…)`). Sin datos verificados, gráfico esquemático y dilo.

### 2.3 Sin ejecución de código: SVG

Un artefacto SVG con estas mismas reglas (en el chat, los gráficos de teoría siempre en fondo blanco):

```html
<svg viewBox="0 0 440 340" xmlns="http://www.w3.org/2000/svg" font-family="'TeX Gyre Pagella','Palatino Linotype',Palatino,'Book Antiqua',serif" font-size="15">
  <defs><marker id="f" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="7" markerHeight="7" orient="auto"><path d="M0,0 L10,5 L0,10 L3,5 Z" fill="black"/></marker>
        <marker id="fr" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="6" markerHeight="6" orient="auto"><path d="M0,0 L10,5 L0,10 L3,5 Z" fill="#B22222"/></marker></defs>
  <rect width="440" height="340" fill="white"/>
  <!-- ejes: origen en (40,300) -->
  <line x1="40" y1="300" x2="420" y2="300" stroke="black" stroke-width="1.6" marker-end="url(#f)"/>
  <line x1="40" y1="300" x2="40" y2="20" stroke="black" stroke-width="1.6" marker-end="url(#f)"/>
  <text x="414" y="322" font-style="italic" text-anchor="end">Q</text><text x="30" y="28" font-style="italic" text-anchor="end">P</text><text x="30" y="318" text-anchor="end">0</text>
  <!-- curvas: 1 #5F2987, 2 #1F5F99, 3 #3C7D3A, 4 #B8860B, nueva #B22222 (discontinua: stroke-dasharray="7 4") -->
  <line x1="70" y1="50" x2="360" y2="270" stroke="#5F2987" stroke-width="3" stroke-linecap="round"/><text x="366" y="272" fill="#5F2987" font-style="italic">D</text>
  <line x1="70" y1="270" x2="360" y2="50" stroke="#1F5F99" stroke-width="3" stroke-linecap="round"/><text x="366" y="50" fill="#1F5F99" font-style="italic">S</text>
  <!-- guías, punto y etiqueta -->
  <path d="M215,160 V300 M215,160 H40" stroke="#767171" stroke-width="1.1" stroke-dasharray="5 4" fill="none"/>
  <circle cx="215" cy="160" r="4.5" fill="black"/><text x="223" y="152" font-style="italic">E<tspan font-size="11" dy="4">0</tspan></text>
  <text x="215" y="320" fill="#767171" text-anchor="middle" font-style="italic">Q<tspan font-size="11" dy="4">0</tspan></text>
</svg>
```

DCE: curva 1 `#7A1F4B` y curva 2 `#234A6B`, letra `'Latin Modern Roman','CMU Serif',Georgia,serif`. Áreas: el color de la curva con `fill-opacity="0.18"`. Flechas de movimiento: `stroke="#B22222"` con `marker-end="url(#fr)"`.

## 3. Preguntas tipo test

El contenido y el formato de cada pregunta, los de `references/agentes/test-personal.md` (oficiales del banco primero; las nuevas, marcadas). En el chat:

- **Por defecto**, en texto: la tanda numerada, sin soluciones hasta que conteste; luego la corrección con la letra, el porqué y la fuente. Si una pregunta tiene gráfico, dibújalo como en el apartado 2.
- **Si quiere practicar con botones** («hazme un test interactivo», «como en la app»), un artefacto HTML de una sola página, sin bibliotecas externas: cabecera con la oposición y los temas, una pregunta por tarjeta con sus cuatro opciones (a–d), al pulsar marca acierto o fallo, enseña la explicación con su fuente y, al final, los aciertos por tema y qué repasar. Estética de la app: fondo `#E2EFD9` (DCE `#F7F4EC`), tarjetas blancas con borde `#C8D8C0`, títulos y botones en `#5F2987` (DCE `#7A1F4B`), filete `#B8860B`, letra `'TeX Gyre Pagella','Palatino Linotype',Palatino,serif` para el texto y `'Source Sans 3',system-ui,sans-serif` para los botones; acierto `#3C7D3A`, fallo `#B22222`; sin degradados ni sombras grandes.
- **Si lo quiere en PDF** (para imprimirlo o hacerlo sin pantalla): documento del apartado 4 con las preguntas y, al final, la plantilla de respuestas y las soluciones en una página aparte.

## 4. Documentos

Cualquier cosa que el opositor quiera guardar o imprimir (resumen o esquema de un tema, comparativa de modelos, ficha de un cante o de un dictamen, preguntas, cronograma, plan de repaso, apuntes de una duda) sale **con la plantilla de los temas de su oposición**: la misma cabecera y pie, apartados en banda, títulos con filete, tablas, cajas y letra que el temario.

### 4.1 Cómo

1. Escribe el contenido en Markdown: un `#` con el título, `##` para los apartados, tablas, listas, citas `>` para lo que va en caja, fórmulas en `$…$` con comandos LaTeX (`\alpha`, `\leq`, `\vec{x}`) y los gráficos como `![pie](grafico.png)` (hazlos antes con el apartado 2).
2. `python3 scripts/informe-pdf.py documento.md --oposicion tcee` (con el kit: `kit/scripts/informe-pdf.py`; DCE: `--oposicion dce`).
3. Entrega el PDF y, si puede querer retocarlo, el Markdown.

`informe-pdf.py` compone el PDF con XeLaTeX y la plantilla del temario. En el entorno de código de claude.ai normalmente no hay XeLaTeX: el script pasa solo a la vía Word (pandoc → DOCX con los estilos de la oposición y sus fuentes → PDF con LibreOffice), que conserva colores, letra, cabecera y cajas aunque con un acabado algo más sencillo; dilo en una línea. Si el opositor prefiere Word, entrégale también el `.docx`.

### 4.2 Qué lleva siempre

- El título dice qué es y de qué tema («3.A.8 · Teoría de la demanda — esquema para el cante»); los títulos de los temas, los oficiales (`references/temario/`).
- Las fuentes que hayas usado, en una línea al final de cada apartado o al final del documento (`[tema 3.A.8 · II.2]`, `[ficha 3.A.8]`, el autor de unos apuntes de la ATCEE).
- Del material exclusivo (temas revisados, fichas, guía del dictamen): resume y reorganiza para lo que pida; no lo copies entero en el documento ni lo conviertas para sacarlo (`LICENCIA.md`).
- Al final, el aviso de `SKILL.md` (la plantilla lo pone en una caja pálida).

### 4.3 Sin ejecución de código: HTML

Un artefacto HTML para imprimir («Imprimir → Guardar como PDF»), con la plantilla en CSS:

```css
:root { --tinta:#5F2987; --filete:#B8860B; --papel:#E2EFD9; --texto:#2A2530; }   /* DCE: #7A1F4B, #234A6B, #F7F4EC, #2B2A28 */
body { font: 11.5pt/1.5 'TeX Gyre Pagella','Palatino Linotype',Palatino,serif; color: var(--texto); max-width: 17cm; margin: 1.6cm auto; }
header { display:flex; justify-content:space-between; font-variant-caps: all-small-caps; color: var(--tinta); border-bottom: 0.6pt solid var(--filete); padding-bottom: 4pt; }
h1 { color: var(--tinta); font-weight: normal; font-size: 21pt; border-bottom: 1.2pt solid var(--filete); padding-bottom: 6pt; }
h2 { background: color-mix(in srgb, var(--tinta) 9%, white); color: var(--tinta); padding: 3pt 8pt; font-size: 13.5pt; font-variant-caps: all-small-caps; letter-spacing: .02em; }
h3 { color: var(--tinta); font-size: 12pt; border-bottom: 0.5pt solid var(--filete); }
table { border-collapse: collapse; width: 100%; } th { border-top: 1pt solid var(--texto); border-bottom: 0.6pt solid var(--texto); text-align: left; }
td { padding: 3pt 6pt; } tr:last-child td { border-bottom: 1pt solid var(--texto); }
blockquote { background: var(--papel); border-left: 3pt solid var(--tinta); margin: 10pt 0; padding: 6pt 10pt; }
.aviso { background: #F3EEF7; font-size: 9.5pt; padding: 8pt 10pt; margin-top: 18pt; }
@page { size: A4; margin: 1.8cm; }
```

Cabecera con la oposición a la izquierda («Oposición a Técnico Comercial y Economista del Estado» o «… Diplomado Comercial del Estado») y el tema o el tipo de documento a la derecha; fórmulas con MathML o, si no, en texto con la notación del temario.
