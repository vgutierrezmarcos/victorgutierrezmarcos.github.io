#!/usr/bin/env Rscript
# =============================================================================
# GENERADOR DE ARTÍCULOS - Estilo PIIE
# =============================================================================
# 
# Uso:
#   Rscript generar_articulo.R mi-articulo.Rmd
#
# El archivo Rmd debe tener un encabezado YAML con los metadatos necesarios.
# =============================================================================

# Cargar/instalar paquetes necesarios
cargar_paquetes <- function() {
  paquetes <- c("rmarkdown", "pagedown", "knitr", "yaml")
  
  for (pkg in paquetes) {
    if (!requireNamespace(pkg, quietly = TRUE)) {
      message(paste("Instalando", pkg, "..."))
      install.packages(pkg, repos = "https://cloud.r-project.org", quiet = TRUE)
    }
  }
  
  suppressPackageStartupMessages({
    library(rmarkdown)
    library(pagedown)
    library(knitr)
    library(yaml)
  })
}

# Función para formatear fecha en español
formatear_fecha <- function(fecha_str) {
  meses <- c("enero", "febrero", "marzo", "abril", "mayo", "junio",
             "julio", "agosto", "septiembre", "octubre", "noviembre", "diciembre")
  
  if (is.character(fecha_str)) {
    fecha <- tryCatch(
      as.Date(fecha_str),
      error = function(e) Sys.Date()
    )
  } else if (inherits(fecha_str, "Date")) {
    fecha <- fecha_str
  } else {
    fecha <- Sys.Date()
  }
  
  paste0(format(fecha, "%d"), " de ", meses[as.numeric(format(fecha, "%m"))], 
         " de ", format(fecha, "%Y"))
}

# Función para generar slug del título
generar_slug <- function(titulo) {
  slug <- tolower(titulo)
  # Reemplazar caracteres especiales
  slug <- gsub("á", "a", slug)
  slug <- gsub("é", "e", slug)
  slug <- gsub("í", "i", slug)
  slug <- gsub("ó", "o", slug)
  slug <- gsub("ú", "u", slug)
  slug <- gsub("ñ", "n", slug)
  slug <- gsub("ü", "u", slug)
  # Solo letras, números y guiones
  slug <- gsub("[^a-z0-9]+", "-", slug)
  slug <- gsub("^-|-$", "", slug)
  return(slug)
}

# Extraer metadatos del archivo Rmd
extraer_metadatos <- function(rmd_path) {
  contenido <- readLines(rmd_path, warn = FALSE)
  
  # Buscar delimitadores YAML
  yaml_inicio <- which(contenido == "---")[1]
  yaml_fin <- which(contenido == "---")[2]
  
  if (is.na(yaml_inicio) || is.na(yaml_fin)) {
    stop("El archivo Rmd debe tener un encabezado YAML válido")
  }
  
  yaml_texto <- paste(contenido[(yaml_inicio + 1):(yaml_fin - 1)], collapse = "\n")
  metadatos <- yaml::yaml.load(yaml_texto)
  
  return(metadatos)
}

# Generar HTML del artículo
generar_html <- function(rmd_path, output_dir = ".") {
  metadatos <- extraer_metadatos(rmd_path)
  
  slug <- if (!is.null(metadatos$numero)) {
    metadatos$numero
  } else {
    generar_slug(metadatos$title)
  }
  
  output_file <- file.path(output_dir, paste0(slug, ".html"))
  
  # Directorio del script para encontrar plantillas
  script_dir <- dirname(normalizePath(rmd_path))
  
  # Renderizar
  rmarkdown::render(
    input = rmd_path,
    output_file = output_file,
    output_format = rmarkdown::html_document(
      template = file.path(script_dir, "plantilla.html"),
      css = file.path(script_dir, "articulo-styles.css"),
      self_contained = TRUE,
      toc = FALSE,
      theme = NULL,
      highlight = "tango"
    ),
    quiet = TRUE
  )
  
  message(paste("✓ HTML generado:", basename(output_file)))
  return(output_file)
}

# Generar PDF del artículo usando pagedown
generar_pdf <- function(rmd_path, output_dir = ".") {
  metadatos <- extraer_metadatos(rmd_path)
  
  slug <- if (!is.null(metadatos$numero)) {
    metadatos$numero
  } else {
    generar_slug(metadatos$title)
  }
  
  # Primero generamos un HTML temporal para el PDF
  html_temp <- tempfile(fileext = ".html")
  
  script_dir <- dirname(normalizePath(rmd_path))
  
  # Renderizar HTML para PDF
  rmarkdown::render(
    input = rmd_path,
    output_file = html_temp,
    output_format = rmarkdown::html_document(
      template = file.path(script_dir, "plantilla.html"),
      css = file.path(script_dir, "articulo-styles.css"),
      self_contained = TRUE,
      toc = FALSE,
      theme = NULL
    ),
    quiet = TRUE
  )
  
  output_file <- file.path(output_dir, paste0(slug, ".pdf"))
  
  # Convertir a PDF con Chrome
  pagedown::chrome_print(
    input = html_temp,
    output = output_file,
    format = "pdf",
    verbose = 0,
    extra_args = c("--disable-gpu", "--no-sandbox")
  )
  
  # Limpiar temporal
  unlink(html_temp)
  
  message(paste("✓ PDF generado:", basename(output_file)))
  return(output_file)
}

# Actualizar índice del blog
actualizar_indice <- function(metadatos, slug, blog_dir = ".") {
  index_path <- file.path(blog_dir, "index.html")
  
  if (!file.exists(index_path)) {
    message("⚠ No se encontró index.html. Actualiza el índice manualmente.")
    return(invisible(NULL))
  }
  
  index_content <- readLines(index_path, warn = FALSE)
  
  # Formatear fecha
  fecha_legible <- formatear_fecha(metadatos$date)
  fecha_iso <- if (!is.null(metadatos$date)) {
    format(as.Date(metadatos$date), "%Y-%m-%d")
  } else {
    format(Sys.Date(), "%Y-%m-%d")
  }
  
  categoria <- if (!is.null(metadatos$categoria)) metadatos$categoria else "General"
  
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
                            <a href="%s.html" class="read-more">Leer artículo</a>
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
    if (!is.null(metadatos$subtitle)) metadatos$subtitle else "",
    slug,
    slug
  )
  
  # Insertar después del marcador
  marcador_pos <- grep("<!-- INICIO ARTÍCULOS -->", index_content, fixed = TRUE)
  
  if (length(marcador_pos) > 0) {
    index_content <- c(
      index_content[1:marcador_pos],
      nuevo_articulo,
      index_content[(marcador_pos + 1):length(index_content)]
    )
    
    writeLines(index_content, index_path)
    message("✓ Índice del blog actualizado")
  } else {
    message("⚠ No se encontró el marcador en index.html. Actualiza manualmente.")
  }
}

# Función principal
main <- function() {
  args <- commandArgs(trailingOnly = TRUE)
  
  if (length(args) < 1) {
    cat("
╔══════════════════════════════════════════════════════════════╗
║        GENERADOR DE ARTÍCULOS - Estilo PIIE                 ║
╚══════════════════════════════════════════════════════════════╝

Uso:
    Rscript generar_articulo.R articulo.Rmd

El archivo Rmd debe tener este formato:

---
title: \"Título del artículo\"
subtitle: \"Subtítulo explicativo\"
date: \"2026-01-19\"
numero: \"26-1\"
categoria: \"Economía Española\"
author: \"Víctor Gutiérrez Marcos\"
bio: \"Descripción del autor...\"
---

Contenido del artículo en R Markdown...

")
    quit(status = 1)
  }
  
  rmd_path <- args[1]
  
  if (!file.exists(rmd_path)) {
    stop(paste("Error: No se encontró el archivo", rmd_path))
  }
  
  cat("\n")
  cat("📄 Procesando:", basename(rmd_path), "\n")
  cat(strrep("=", 50), "\n")
  
  # Cargar paquetes
  cargar_paquetes()
  
  # Extraer metadatos
  metadatos <- extraer_metadatos(rmd_path)
  
  if (is.null(metadatos$title)) {
    stop("Error: El archivo necesita un título en los metadatos YAML")
  }
  
  # Directorio de salida
  output_dir <- dirname(rmd_path)
  
  slug <- if (!is.null(metadatos$numero)) {
    metadatos$numero
  } else {
    generar_slug(metadatos$title)
  }
  
  # Generar HTML
  tryCatch({
    generar_html(rmd_path, output_dir)
  }, error = function(e) {
    message(paste("✗ Error generando HTML:", e$message))
  })
  
  # Generar PDF
  tryCatch({
    generar_pdf(rmd_path, output_dir)
  }, error = function(e) {
    message(paste("✗ Error generando PDF:", e$message))
    message("  Nota: El PDF requiere Google Chrome instalado")
  })
  
  # Actualizar índice
  tryCatch({
    actualizar_indice(metadatos, slug, output_dir)
  }, error = function(e) {
    message(paste("⚠ No se pudo actualizar el índice:", e$message))
  })
  
  cat(strrep("=", 50), "\n")
  cat("✅ Artículo publicado correctamente\n")
  cat("   →", paste0(slug, ".html"), "\n")
  cat("   →", paste0(slug, ".pdf"), "\n\n")
}

# Ejecutar
main()
