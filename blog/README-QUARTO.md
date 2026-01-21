# Blog con Quarto

Este directorio contiene el sistema de generación de artículos usando [Quarto](https://quarto.org/).

## Requisitos

1. **Quarto CLI**: Descarga e instala desde https://quarto.org/docs/get-started/
2. **R** (opcional pero recomendado): Para usar el script `render.R`
3. **LaTeX** (para PDF): Instala TinyTeX desde R con:
   ```r
   install.packages("tinytex")
   tinytex::install_tinytex()
   ```

## Estructura de archivos

```
blog/
├── _quarto.yml              # Configuración del proyecto Quarto
├── _templates/
│   ├── articulo.html        # Plantilla HTML personalizada
│   └── articulo.tex         # Plantilla LaTeX para PDF
├── articulo-styles.css      # Estilos CSS para artículos
├── blog-styles.css          # Estilos del índice del blog
├── render.R                 # Script de renderizado desde R
├── index.html               # Índice del blog
└── *.qmd                    # Artículos en formato Quarto
```

## Crear un nuevo artículo

### Opción 1: Desde R/RStudio

```r
source("render.R")
nuevo_articulo("Título del artículo")
```

Esto crea un archivo `.qmd` con la plantilla lista para editar.

### Opción 2: Manualmente

Crea un archivo `.qmd` con este encabezado YAML:

```yaml
---
title: "Título del artículo"
subtitle: "Subtítulo descriptivo"
author: "Víctor Gutiérrez Marcos"
date: "2025-01-20"
date-formatted: "Enero 2025"
slug: "mi-articulo"
categoria: "Economía"
bio: "Técnico Comercial y Economista del Estado..."
year: 2025

description: "Descripción para el índice del blog"
tags:
  - etiqueta1
  - etiqueta2

format:
  html:
    template: _templates/articulo.html
    css: articulo-styles.css
  pdf:
    template: _templates/articulo.tex
---

Contenido del artículo en Markdown...
```

## Renderizar artículos

### Desde R/RStudio

```r
source("render.R")

# Generar HTML y PDF + actualizar índice
render_articulo("mi-articulo.qmd")

# Solo HTML
render_articulo("mi-articulo.qmd", formato = "html")

# Solo PDF
render_articulo("mi-articulo.qmd", formato = "pdf")
```

### Desde terminal con Rscript

```bash
# HTML + PDF + actualizar índice
Rscript render.R mi-articulo.qmd

# Solo HTML
Rscript render.R mi-articulo.qmd html

# Solo PDF
Rscript render.R mi-articulo.qmd pdf
```

### Desde terminal con Quarto CLI directamente

```bash
# Solo HTML
quarto render mi-articulo.qmd --to html

# Solo PDF
quarto render mi-articulo.qmd --to pdf

# Ambos formatos
quarto render mi-articulo.qmd
```

**Nota**: Si usas Quarto CLI directamente, deberás actualizar el índice manualmente.

## Campos YAML importantes

| Campo | Descripción |
|-------|-------------|
| `title` | Título principal del artículo |
| `subtitle` | Subtítulo (aparece en cursiva) |
| `date` | Fecha en formato YYYY-MM-DD |
| `date-formatted` | Fecha formateada para mostrar (ej: "Enero 2025") |
| `slug` | Nombre del archivo de salida (sin extensión) |
| `categoria` | Categoría para el índice del blog |
| `description` | Resumen para el índice del blog |
| `numero` | Número de artículo (opcional, estilo PIIE) |
| `bio` | Biografía del autor para el sidebar |

## Incluir código R

Quarto permite incluir código R ejecutable:

````markdown
```{r}
# Este código se ejecutará al renderizar
library(ggplot2)
ggplot(mtcars, aes(wt, mpg)) + geom_point()
```
````

## Incluir gráficos y tablas

```markdown
![Descripción de la imagen](imagen.png)

| Columna 1 | Columna 2 |
|-----------|-----------|
| Dato 1    | Dato 2    |
```

## Personalización

- **Estilos HTML**: Edita `articulo-styles.css`
- **Plantilla HTML**: Edita `_templates/articulo.html`
- **Plantilla PDF**: Edita `_templates/articulo.tex`
- **Configuración global**: Edita `_quarto.yml`

## Solución de problemas

### Error al generar PDF

1. Asegúrate de tener LaTeX instalado:
   ```r
   tinytex::install_tinytex()
   ```

2. Si hay errores de paquetes LaTeX:
   ```r
   tinytex::tlmgr_install("nombre-paquete")
   ```

### El índice no se actualiza

El script busca el marcador `<!-- INICIO ARTÍCULOS -->` en `index.html`. Asegúrate de que existe.

### Los estilos no se aplican

Verifica que las rutas a los archivos CSS en el YAML sean correctas y que los archivos existan.
