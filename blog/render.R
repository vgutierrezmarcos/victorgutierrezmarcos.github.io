#!/usr/bin/env Rscript
# =============================================================================
# RENDER QUARTO - Generador de artículos para el blog
# =============================================================================
#
# Uso desde terminal:
#   Rscript render.R mi-articulo.qmd           # Genera HTML y PDF
#   Rscript render.R mi-articulo.qmd html      # Solo HTML
#   Rscript render.R mi-articulo.qmd pdf       # Solo PDF
#   Rscript render.R mi-articulo.qmd all       # HTML + PDF + actualiza índice
#
# Uso desde R/RStudio:
#   source("render.R")
#   render_articulo("mi-articulo.qmd")
#   render_articulo("mi-articulo.qmd", formato = "html")
#   render_articulo("mi-articulo.qmd", formato = "pdf")
#   render_articulo("mi-articulo.qmd", formato = "all", actualizar_indice = TRUE)
#
# =============================================================================

# Verificar e instalar quarto si es necesario
verificar_quarto <- function() {
  # Verificar si quarto CLI está disponible
  quarto_path <- Sys.which("quarto")
  if (quarto_path == "") {
    stop("Quarto no está instalado. Visita https://quarto.org/docs/get-started/")
  }

  # Verificar paquete R quarto
  if (!requireNamespace("quarto", quietly = TRUE)) {
    message("Instalando paquete 'quarto'...")
    install.packages("quarto", repos = "https://cloud.r-project.org", quiet = TRUE)
  }

  invisible(TRUE)
}

# Verificar/instalar paquetes necesarios
verificar_paquetes <- function() {
  paquetes <- c("yaml", "quarto")

  for (pkg in paquetes) {
    if (!requireNamespace(pkg, quietly = TRUE)) {
      message(paste("Instalando", pkg, "..."))
      install.packages(pkg, repos = "https://cloud.r-project.org", quiet = TRUE)
    }
  }

  suppressPackageStartupMessages({
    library(yaml)
    library(quarto)
  })
}

# Extraer metadatos YAML del archivo .qmd
extraer_metadatos <- function(qmd_path) {
  contenido <- readLines(qmd_path, warn = FALSE, encoding = "UTF-8")

  yaml_inicio <- which(contenido == "---")[1]
  yaml_fin <- which(contenido == "---")[2]

  if (is.na(yaml_inicio) || is.na(yaml_fin)) {
    stop("El archivo .qmd debe tener un encabezado YAML válido")
  }

  yaml_texto <- paste(contenido[(yaml_inicio + 1):(yaml_fin - 1)], collapse = "\n")
  metadatos <- yaml::yaml.load(yaml_texto)

  return(metadatos)
}

# Formatear fecha en español
formatear_fecha <- function(fecha_str) {
  meses <- c("enero", "febrero", "marzo", "abril", "mayo", "junio",
             "julio", "agosto", "septiembre", "octubre", "noviembre", "diciembre")

  if (is.character(fecha_str)) {
    fecha <- tryCatch(as.Date(fecha_str), error = function(e) Sys.Date())
  } else if (inherits(fecha_str, "Date")) {
    fecha <- fecha_str
  } else {
    fecha <- Sys.Date()
  }

  paste0(format(fecha, "%d"), " de ", meses[as.numeric(format(fecha, "%m"))],
         " de ", format(fecha, "%Y"))
}

# Función principal de renderizado
render_articulo <- function(qmd_path, formato = "all", actualizar_indice = TRUE) {
  verificar_quarto()
  verificar_paquetes()

  if (!file.exists(qmd_path)) {
    stop(paste("Error: No se encontró el archivo", qmd_path))
  }

  cat("\n")
  cat("=== RENDER QUARTO ===\n")
  cat("Procesando:", basename(qmd_path), "\n")
  cat(strrep("-", 40), "\n")

  # Extraer metadatos
  metadatos <- extraer_metadatos(qmd_path)

  if (is.null(metadatos$title)) {
    stop("Error: El archivo necesita un 'title' en los metadatos YAML")
  }

  # Obtener slug para nombres de archivo
  slug <- metadatos$slug
  if (is.null(slug)) {
    slug <- gsub("\\.qmd$", "", basename(qmd_path))
  }

  output_dir <- dirname(qmd_path)
  if (output_dir == ".") output_dir <- getwd()

  # Renderizar según formato solicitado
  if (formato %in% c("html", "all")) {
    cat("Generando HTML...\n")
    tryCatch({
      quarto::quarto_render(
        input = qmd_path,
        output_format = "html",
        output_file = paste0(slug, ".html")
      )
      cat("  HTML generado:", paste0(slug, ".html"), "\n")
    }, error = function(e) {
      cat("  Error generando HTML:", e$message, "\n")
    })
  }

  if (formato %in% c("pdf", "all")) {
    cat("Generando PDF...\n")
    tryCatch({
      quarto::quarto_render(
        input = qmd_path,
        output_format = "pdf",
        output_file = paste0(slug, ".pdf")
      )
      cat("  PDF generado:", paste0(slug, ".pdf"), "\n")
    }, error = function(e) {
      cat("  Error generando PDF:", e$message, "\n")
      cat("  Nota: El PDF requiere una distribución LaTeX instalada (tinytex o similar)\n")
    })
  }

  # Actualizar índice del blog
  if (actualizar_indice && formato == "all") {
    tryCatch({
      actualizar_indice_blog(metadatos, slug, output_dir)
    }, error = function(e) {
      cat("  Aviso - No se pudo actualizar el índice:", e$message, "\n")
    })
  }

  cat(strrep("-", 40), "\n")
  cat("Proceso completado\n\n")

  invisible(list(
    html = file.path(output_dir, paste0(slug, ".html")),
    pdf = file.path(output_dir, paste0(slug, ".pdf"))
  ))
}

# Actualizar el índice del blog
actualizar_indice_blog <- function(metadatos, slug, blog_dir) {
  index_path <- file.path(blog_dir, "index.html")

  if (!file.exists(index_path)) {
    message("  Aviso: No se encontró index.html")
    return(invisible(NULL))
  }

  index_content <- readLines(index_path, warn = FALSE, encoding = "UTF-8")

  # Verificar si el artículo ya existe en el índice
  if (any(grepl(paste0('href="', slug, '.html"'), index_content, fixed = TRUE))) {
    cat("  El artículo ya existe en el índice\n")
    return(invisible(NULL))
  }

  # Formatear fecha
  fecha_legible <- formatear_fecha(metadatos$date)
  fecha_iso <- if (!is.null(metadatos$date)) {
    format(as.Date(metadatos$date), "%Y-%m-%d")
  } else {
    format(Sys.Date(), "%Y-%m-%d")
  }

  categoria <- if (!is.null(metadatos$categoria)) metadatos$categoria else "General"
  descripcion <- if (!is.null(metadatos$description)) {
    metadatos$description
  } else if (!is.null(metadatos$subtitle)) {
    metadatos$subtitle
  } else {
    ""
  }

  # Crear HTML del nuevo artículo
  nuevo_articulo <- sprintf('
                    <article class="article-card">
                        <div class="article-meta">
                            <time datetime="%s">%s</time>
                            <span class="article-category">%s</span>
                        </div>
                        <h3 class="article-title">
                            <a href="%s.html">%s</a>
                        </h3>
                        <p class="article-excerpt">
                            %s
                        </p>
                        <div class="article-actions">
                            <a href="%s.html" class="read-more">Leer articulo</a>
                            <a href="%s.pdf" class="download-pdf" download>
                                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                    <path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4"/>
                                    <polyline points="7 10 12 15 17 10"/>
                                    <line x1="12" y1="15" x2="12" y2="3"/>
                                </svg>
                                PDF
                            </a>
                        </div>
                    </article>',
    fecha_iso,
    fecha_legible,
    categoria,
    slug,
    metadatos$title,
    descripcion,
    slug,
    slug
  )

  # Insertar después del marcador
  marcador_pos <- grep("<!-- INICIO ARTICULOS -->", index_content, fixed = TRUE)

  if (length(marcador_pos) == 0) {
    # Intentar con tilde
    marcador_pos <- grep("<!-- INICIO ART\u00cdCULOS -->", index_content, fixed = TRUE)
  }

  if (length(marcador_pos) > 0) {
    index_content <- c(
      index_content[1:marcador_pos],
      nuevo_articulo,
      index_content[(marcador_pos + 1):length(index_content)]
    )

    writeLines(index_content, index_path, useBytes = TRUE)
    cat("  Indice del blog actualizado\n")
  } else {
    cat("  Aviso: No se encontro el marcador en index.html\n")
  }
}

# Función para crear un nuevo artículo desde plantilla
nuevo_articulo <- function(titulo, slug = NULL, categoria = "General") {
  if (is.null(slug)) {
    slug <- tolower(titulo)
    slug <- gsub("[áàä]", "a", slug)
    slug <- gsub("[éèë]", "e", slug)
    slug <- gsub("[íìï]", "i", slug)
    slug <- gsub("[óòö]", "o", slug)
    slug <- gsub("[úùü]", "u", slug)
    slug <- gsub("ñ", "n", slug)
    slug <- gsub("[^a-z0-9]+", "-", slug)
    slug <- gsub("^-|-$", "", slug)
  }

  fecha <- format(Sys.Date(), "%Y-%m-%d")
  year <- format(Sys.Date(), "%Y")

  plantilla <- sprintf('---
title: "%s"
subtitle: ""
author: "Victor Gutierrez Marcos"
date: "%s"
date-formatted: "%s"
slug: "%s"
numero: ""
categoria: "%s"
bio: "Tecnico Comercial y Economista del Estado en el Ministerio de Economia, Comercio y Empresa de Espana."
year: %s

description: ""
tags:
  -

format:
  html:
    template: _templates/articulo.html
    css: articulo-styles.css
  pdf:
    template: _templates/articulo.tex
---

Escribe aqui el contenido del articulo...

## Primera seccion

Texto de la primera seccion.

## Segunda seccion

Texto de la segunda seccion.

## Conclusiones

Conclusiones del articulo.
',
    titulo,
    fecha,
    format(Sys.Date(), "%B %Y"),
    slug,
    categoria,
    year
  )

  archivo <- paste0(slug, ".qmd")
  writeLines(plantilla, archivo, useBytes = TRUE)
  cat("Nuevo articulo creado:", archivo, "\n")
  cat("Editalo y luego ejecuta: render_articulo('", archivo, "')\n", sep = "")

  invisible(archivo)
}

# Ejecutar desde línea de comandos
if (!interactive()) {
  args <- commandArgs(trailingOnly = TRUE)

  if (length(args) < 1) {
    cat("
+----------------------------------------------------------+
|           RENDER QUARTO - Blog Generator                 |
+----------------------------------------------------------+

Uso:
    Rscript render.R articulo.qmd [formato]

Formatos disponibles:
    html    Solo genera HTML
    pdf     Solo genera PDF
    all     Genera HTML + PDF + actualiza indice (por defecto)

Ejemplo:
    Rscript render.R ejemplo-comercio-exterior.qmd
    Rscript render.R mi-articulo.qmd html
    Rscript render.R mi-articulo.qmd pdf

Para crear un nuevo articulo desde R:
    source('render.R')
    nuevo_articulo('Titulo del articulo')

")
    quit(status = 0)
  }

  qmd_path <- args[1]
  formato <- if (length(args) >= 2) args[2] else "all"

  render_articulo(qmd_path, formato)
}
