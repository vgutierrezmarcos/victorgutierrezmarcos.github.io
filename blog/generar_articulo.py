#!/usr/bin/env python3
"""
Generador de Artículos - Estilo PIIE
=====================================
Convierte archivos Markdown a HTML y PDF con formato profesional
estilo Peterson Institute for International Economics.

Uso:
    python generar_articulo.py articulo.md

El archivo Markdown debe tener un encabezado YAML con los metadatos.
"""

import sys
import os
import re
import yaml
from datetime import datetime
from pathlib import Path

# Reportlab para PDF
from reportlab.lib.pagesizes import A4
from reportlab.lib.units import cm, mm
from reportlab.lib.styles import getSampleStyleSheet, ParagraphStyle
from reportlab.lib.enums import TA_JUSTIFY, TA_CENTER, TA_LEFT, TA_RIGHT
from reportlab.lib.colors import HexColor, Color
from reportlab.platypus import (
    SimpleDocTemplate, Paragraph, Spacer, PageBreak,
    Table, TableStyle, Image, KeepTogether, KeepInFrame,
    Flowable, Frame, PageTemplate, BaseDocTemplate
)
from reportlab.platypus.doctemplate import LayoutError
from reportlab.pdfbase import pdfmetrics
from reportlab.pdfbase.ttfonts import TTFont
from reportlab.graphics.shapes import Drawing, Line, Rect

# Markdown
try:
    import markdown
except ImportError:
    os.system("pip install markdown --break-system-packages -q")
    import markdown

# Colores corporativos
COLOR_PRIMARIO = HexColor('#5F2987')
COLOR_PRIMARIO_OSCURO = HexColor('#4a1f6b')
COLOR_PRIMARIO_CLARO = HexColor('#f3eef7')
COLOR_TEXTO = HexColor('#333333')
COLOR_TEXTO_MUTED = HexColor('#555555')
COLOR_TEXTO_LIGHT = HexColor('#666666')
COLOR_DORADO = HexColor('#b8860b')
COLOR_FONDO = HexColor('#fafafa')
COLOR_BORDE = HexColor('#e0e0e0')
COLOR_BLANCO = HexColor('#ffffff')

# Dimensiones
ANCHO_PAGINA, ALTO_PAGINA = A4
MARGEN_IZQ = 2.5 * cm
MARGEN_DER = 2.5 * cm
MARGEN_SUP = 2 * cm
MARGEN_INF = 2.5 * cm


def cargar_articulo(ruta_md):
    """Carga y parsea el archivo Markdown con metadatos YAML."""
    with open(ruta_md, 'r', encoding='utf-8') as f:
        contenido = f.read()
    
    if contenido.startswith('---'):
        partes = contenido.split('---', 2)
        if len(partes) >= 3:
            metadatos = yaml.safe_load(partes[1])
            contenido_md = partes[2].strip()
        else:
            metadatos = {}
            contenido_md = contenido
    else:
        metadatos = {}
        contenido_md = contenido
    
    return metadatos, contenido_md


def md_a_html(contenido_md):
    """Convierte Markdown a HTML."""
    md = markdown.Markdown(extensions=['tables', 'fenced_code', 'footnotes', 'toc'])
    return md.convert(contenido_md)


def generar_slug(titulo):
    """Genera un slug URL-friendly."""
    slug = titulo.lower()
    reemplazos = {'á': 'a', 'é': 'e', 'í': 'i', 'ó': 'o', 'ú': 'u', 'ñ': 'n', 'ü': 'u'}
    for orig, reemplazo in reemplazos.items():
        slug = slug.replace(orig, reemplazo)
    slug = re.sub(r'[^a-z0-9]+', '-', slug)
    return slug.strip('-')


def formatear_fecha(fecha_str, formato='legible'):
    """Formatea la fecha."""
    if isinstance(fecha_str, datetime):
        fecha = fecha_str
    else:
        try:
            fecha = datetime.strptime(str(fecha_str), '%Y-%m-%d')
        except:
            fecha = datetime.now()
    
    if formato == 'legible':
        meses = ['enero', 'febrero', 'marzo', 'abril', 'mayo', 'junio',
                 'julio', 'agosto', 'septiembre', 'octubre', 'noviembre', 'diciembre']
        return f"{fecha.day} de {meses[fecha.month - 1]} de {fecha.year}"
    elif formato == 'corto':
        meses = ['Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio',
                 'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre']
        return f"{meses[fecha.month - 1]} {fecha.year}"
    return fecha.strftime('%Y-%m-%d')


def generar_html(metadatos, contenido_md, ruta_salida):
    """Genera el archivo HTML estilo PIIE."""
    contenido_html = md_a_html(contenido_md)
    slug = metadatos.get('numero', generar_slug(metadatos.get('titulo', 'articulo')))
    
    fecha_legible = formatear_fecha(metadatos.get('fecha', datetime.now()), 'legible')
    fecha_corta = formatear_fecha(metadatos.get('fecha', datetime.now()), 'corto')
    
    html = f'''<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>{metadatos.get('titulo', 'Artículo')} | Víctor Gutiérrez Marcos</title>
    <meta name="description" content="{metadatos.get('subtitulo', '')}">
    <link rel="icon" href="../favicon.svg" type="image/svg+xml">
    <link rel="stylesheet" href="articulo-styles.css">
</head>
<body>

<div class="back-nav">
    <a href="index.html">← Volver al blog</a>
</div>

<article class="article-container">
    
    <!-- Cabecera institucional -->
    <header class="article-header-bar">
        <div class="site-brand">
            <svg class="site-logo" viewBox="0 0 100 100" xmlns="http://www.w3.org/2000/svg">
                <rect width="100" height="100" fill="#5F2987" rx="8"/>
                <text x="50" y="62" font-family="Georgia, serif" font-size="40" font-weight="bold" fill="white" text-anchor="middle">VG</text>
            </svg>
            <div>
                <div class="site-name">Víctor Gutiérrez Marcos</div>
                <div class="site-tagline">Análisis Económico y Comercial</div>
            </div>
        </div>
        <div class="header-contact">
            victorgutierrezmarcos.es<br>
            contacto@victorgutierrezmarcos.es
        </div>
    </header>
    
    <!-- Barra de tipo de documento -->
    <div class="article-title-bar">
        <div class="article-type">Artículo de Análisis</div>
    </div>
    
    <!-- Contenido principal con sidebar -->
    <div class="article-main">
        <div class="article-content">
            <h1 class="article-number-title">
                <span class="article-number">{metadatos.get('numero', '')}</span> {metadatos.get('titulo', '')}
            </h1>
            {'<p class="article-subtitle">' + metadatos.get('subtitulo', '') + '</p>' if metadatos.get('subtitulo') else ''}
            <p class="article-author-date">
                <span class="article-author-name">{metadatos.get('autor', 'Víctor Gutiérrez Marcos')}</span><br>
                {fecha_corta}
            </p>
            
            <div class="article-body">
                {contenido_html}
            </div>
            
            <a href="{slug}.pdf" class="download-btn" download>
                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                    <path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4"/>
                    <polyline points="7 10 12 15 17 10"/>
                    <line x1="12" y1="15" x2="12" y2="3"/>
                </svg>
                Descargar PDF
            </a>
        </div>
        
        <aside class="article-sidebar">
            <div class="author-info">
                <div class="author-name-sidebar">{metadatos.get('autor', 'Víctor Gutiérrez Marcos')}</div>
                <div class="author-bio">
                    <p>{metadatos.get('bio', 'Técnico Comercial y Economista del Estado en el Ministerio de Economía, Comercio y Empresa de España.')}</p>
                </div>
            </div>
        </aside>
    </div>
    
    <footer class="article-footer">
        <div class="footer-logo">
            <svg width="60" height="60" viewBox="0 0 100 100" xmlns="http://www.w3.org/2000/svg">
                <rect width="100" height="100" fill="#5F2987" rx="8"/>
                <text x="50" y="62" font-family="Georgia, serif" font-size="40" font-weight="bold" fill="white" text-anchor="middle">VG</text>
            </svg>
            <div class="footer-logo-text">
                Víctor Gutiérrez Marcos<br>
                <span style="font-weight: 400; font-size: 0.8rem;">Análisis Económico y Comercial</span>
            </div>
        </div>
        
        <div class="disclaimer">
            <p class="copyright">© {datetime.now().year} Víctor Gutiérrez Marcos</p>
        </div>
    </footer>
    
</article>

</body>
</html>'''
    
    with open(ruta_salida, 'w', encoding='utf-8') as f:
        f.write(html)
    
    return slug


class BarraTitulo(Flowable):
    """Barra de título estilo PIIE."""
    def __init__(self, ancho, alto=1.2*cm, texto="ARTÍCULO DE ANÁLISIS"):
        Flowable.__init__(self)
        self.ancho = ancho
        self.alto = alto
        self.texto = texto
    
    def draw(self):
        self.canv.saveState()
        # Fondo morado
        self.canv.setFillColor(COLOR_PRIMARIO)
        self.canv.rect(0, 0, self.ancho, self.alto, fill=1, stroke=0)
        # Texto
        self.canv.setFillColor(COLOR_BLANCO)
        self.canv.setFont('Helvetica-Bold', 14)
        self.canv.drawString(0.5*cm, 0.4*cm, self.texto)
        self.canv.restoreState()
    
    def wrap(self, availWidth, availHeight):
        return (self.ancho, self.alto)


class LineaDorada(Flowable):
    """Línea decorativa dorada."""
    def __init__(self, ancho, grosor=2):
        Flowable.__init__(self)
        self.ancho = ancho
        self.grosor = grosor
    
    def draw(self):
        self.canv.setStrokeColor(COLOR_DORADO)
        self.canv.setLineWidth(self.grosor)
        self.canv.line(0, 0, self.ancho, 0)
    
    def wrap(self, availWidth, availHeight):
        return (self.ancho, self.grosor + 2)


def crear_estilos_pdf():
    """Crea estilos para el PDF con fuentes Sans Serif profesionales."""
    estilos = getSampleStyleSheet()
    
    # Fuente principal: Helvetica (sans-serif, limpia y profesional)
    # Helvetica es la sans-serif estándar de ReportLab, muy legible
    
    # Título del artículo
    estilos.add(ParagraphStyle(
        name='TituloPIIE',
        fontName='Helvetica',
        fontSize=22,
        leading=26,
        textColor=COLOR_PRIMARIO,
        alignment=TA_LEFT,
        spaceAfter=6,
    ))
    
    # Subtítulo
    estilos.add(ParagraphStyle(
        name='SubtituloPIIE',
        fontName='Helvetica-Oblique',
        fontSize=13,
        leading=16,
        textColor=COLOR_PRIMARIO,
        alignment=TA_LEFT,
        spaceAfter=15,
    ))
    
    # Autor y fecha
    estilos.add(ParagraphStyle(
        name='AutorFecha',
        fontName='Helvetica',
        fontSize=10,
        leading=14,
        textColor=COLOR_TEXTO,
        alignment=TA_LEFT,
        spaceAfter=25,
    ))
    
    # Cuerpo de texto - Sans Serif para mejor legibilidad
    estilos.add(ParagraphStyle(
        name='CuerpoPIIE',
        fontName='Helvetica',
        fontSize=10,
        leading=15,
        textColor=COLOR_TEXTO,
        alignment=TA_JUSTIFY,
        firstLineIndent=0,
        spaceBefore=0,
        spaceAfter=10,
    ))
    
    # Primer párrafo (igual que el cuerpo en sans-serif)
    estilos.add(ParagraphStyle(
        name='PrimerParrafo',
        fontName='Helvetica',
        fontSize=10,
        leading=15,
        textColor=COLOR_TEXTO,
        alignment=TA_JUSTIFY,
        firstLineIndent=0,
        spaceBefore=0,
        spaceAfter=10,
    ))
    
    # Sección H2
    estilos.add(ParagraphStyle(
        name='SeccionPIIE',
        fontName='Helvetica-Bold',
        fontSize=11,
        leading=14,
        textColor=COLOR_PRIMARIO,
        alignment=TA_LEFT,
        spaceBefore=18,
        spaceAfter=8,
        keepWithNext=True,
    ))
    
    # Subsección H3
    estilos.add(ParagraphStyle(
        name='SubseccionPIIE',
        fontName='Helvetica-Bold',
        fontSize=10,
        leading=13,
        textColor=COLOR_TEXTO,
        alignment=TA_LEFT,
        spaceBefore=14,
        spaceAfter=6,
        keepWithNext=True,
    ))
    
    # H4
    estilos.add(ParagraphStyle(
        name='H4PIIE',
        fontName='Helvetica-BoldOblique',
        fontSize=10,
        leading=13,
        textColor=COLOR_TEXTO_MUTED,
        alignment=TA_LEFT,
        spaceBefore=10,
        spaceAfter=5,
        keepWithNext=True,
    ))
    
    # Cita
    estilos.add(ParagraphStyle(
        name='CitaPIIE',
        fontName='Helvetica-Oblique',
        fontSize=10,
        leading=14,
        textColor=COLOR_TEXTO_MUTED,
        alignment=TA_CENTER,
        leftIndent=25,
        rightIndent=25,
        spaceBefore=12,
        spaceAfter=12,
    ))
    
    # Lista
    estilos.add(ParagraphStyle(
        name='ListaPIIE',
        fontName='Helvetica',
        fontSize=10,
        leading=14,
        textColor=COLOR_TEXTO,
        alignment=TA_JUSTIFY,
        leftIndent=18,
        spaceBefore=3,
        spaceAfter=3,
        bulletIndent=8,
    ))
    
    # Nota al pie
    estilos.add(ParagraphStyle(
        name='NotaPie',
        fontName='Helvetica',
        fontSize=8,
        leading=10,
        textColor=COLOR_TEXTO_LIGHT,
        alignment=TA_JUSTIFY,
        leftIndent=10,
        spaceBefore=2,
        spaceAfter=2,
    ))
    
    # Sidebar autor
    estilos.add(ParagraphStyle(
        name='SidebarNombre',
        fontName='Helvetica-Bold',
        fontSize=9,
        leading=12,
        textColor=COLOR_PRIMARIO,
        alignment=TA_LEFT,
        spaceAfter=8,
    ))
    
    estilos.add(ParagraphStyle(
        name='SidebarBio',
        fontName='Helvetica',
        fontSize=8,
        leading=11,
        textColor=COLOR_TEXTO_MUTED,
        alignment=TA_LEFT,
    ))
    
    return estilos


def limpiar_html(texto):
    """Limpia HTML y convierte a formato ReportLab."""
    texto = re.sub(r'<strong>(.*?)</strong>', r'<b>\1</b>', texto)
    texto = re.sub(r'<em>(.*?)</em>', r'<i>\1</i>', texto)
    texto = re.sub(r'<code>(.*?)</code>', r'<font face="Courier">\1</font>', texto)
    texto = re.sub(r'<a[^>]*>(.*?)</a>', r'\1', texto)
    texto = re.sub(r'<[^>]+>', '', texto)
    texto = re.sub(r'\s+', ' ', texto).strip()
    return texto


def procesar_contenido_pdf(contenido_html, estilos):
    """Procesa HTML a elementos de ReportLab, manteniendo títulos con su contenido."""
    elementos = []
    es_primer_parrafo = True
    
    bloques = re.split(r'(<h[1-6][^>]*>.*?</h[1-6]>|<p[^>]*>.*?</p>|<blockquote[^>]*>.*?</blockquote>|<ul[^>]*>.*?</ul>|<ol[^>]*>.*?</ol>)', 
                       contenido_html, flags=re.DOTALL)
    
    # Procesar bloques y agrupar títulos con su contenido siguiente
    i = 0
    while i < len(bloques):
        bloque = bloques[i].strip()
        if not bloque:
            i += 1
            continue
        
        # H2 - Mantener con siguiente párrafo
        match = re.match(r'<h2[^>]*>(.*?)</h2>', bloque, re.DOTALL)
        if match:
            texto = limpiar_html(match.group(1)).upper()
            titulo_elem = Paragraph(texto, estilos['SeccionPIIE'])
            
            # Buscar siguiente elemento de contenido
            siguiente_contenido = None
            j = i + 1
            while j < len(bloques):
                sig_bloque = bloques[j].strip()
                if sig_bloque and not sig_bloque.startswith('<h'):
                    siguiente_contenido = procesar_bloque_simple(sig_bloque, estilos, True)
                    if siguiente_contenido:
                        i = j  # Saltar al bloque procesado
                    break
                elif sig_bloque.startswith('<h'):
                    break
                j += 1
            
            if siguiente_contenido:
                elementos.append(KeepTogether([titulo_elem, siguiente_contenido]))
            else:
                elementos.append(titulo_elem)
            
            es_primer_parrafo = True
            i += 1
            continue
        
        # H3 - Mantener con siguiente párrafo
        match = re.match(r'<h3[^>]*>(.*?)</h3>', bloque, re.DOTALL)
        if match:
            texto = limpiar_html(match.group(1))
            titulo_elem = Paragraph(texto, estilos['SubseccionPIIE'])
            
            # Buscar siguiente elemento de contenido
            siguiente_contenido = None
            j = i + 1
            while j < len(bloques):
                sig_bloque = bloques[j].strip()
                if sig_bloque and not sig_bloque.startswith('<h'):
                    siguiente_contenido = procesar_bloque_simple(sig_bloque, estilos, True)
                    if siguiente_contenido:
                        i = j
                    break
                elif sig_bloque.startswith('<h'):
                    break
                j += 1
            
            if siguiente_contenido:
                elementos.append(KeepTogether([titulo_elem, siguiente_contenido]))
            else:
                elementos.append(titulo_elem)
            
            es_primer_parrafo = True
            i += 1
            continue
        
        # H4 - Mantener con siguiente párrafo
        match = re.match(r'<h4[^>]*>(.*?)</h4>', bloque, re.DOTALL)
        if match:
            texto = limpiar_html(match.group(1))
            titulo_elem = Paragraph(texto, estilos['H4PIIE'])
            
            siguiente_contenido = None
            j = i + 1
            while j < len(bloques):
                sig_bloque = bloques[j].strip()
                if sig_bloque and not sig_bloque.startswith('<h'):
                    siguiente_contenido = procesar_bloque_simple(sig_bloque, estilos, True)
                    if siguiente_contenido:
                        i = j
                    break
                elif sig_bloque.startswith('<h'):
                    break
                j += 1
            
            if siguiente_contenido:
                elementos.append(KeepTogether([titulo_elem, siguiente_contenido]))
            else:
                elementos.append(titulo_elem)
            
            es_primer_parrafo = True
            i += 1
            continue
        
        # Otros bloques (párrafos, citas, listas)
        elem = procesar_bloque_simple(bloque, estilos, es_primer_parrafo)
        if elem:
            elementos.append(elem)
            if re.match(r'<p[^>]*>', bloque):
                es_primer_parrafo = False
        
        i += 1
    
    return elementos


def procesar_bloque_simple(bloque, estilos, es_primer_parrafo):
    """Procesa un bloque individual de contenido."""
    
    # Blockquote
    match = re.match(r'<blockquote[^>]*>(.*?)</blockquote>', bloque, re.DOTALL)
    if match:
        texto = limpiar_html(match.group(1))
        texto = re.sub(r'<p[^>]*>(.*?)</p>', r'\1', texto, flags=re.DOTALL)
        return Paragraph(f"«{texto.strip()}»", estilos['CitaPIIE'])
    
    # Lista no ordenada
    match = re.match(r'<ul[^>]*>(.*?)</ul>', bloque, re.DOTALL)
    if match:
        items = re.findall(r'<li[^>]*>(.*?)</li>', match.group(1), re.DOTALL)
        lista_elementos = []
        for item in items:
            texto = limpiar_html(item)
            lista_elementos.append(Paragraph(f"• {texto}", estilos['ListaPIIE']))
        return KeepTogether(lista_elementos) if lista_elementos else None
    
    # Lista ordenada
    match = re.match(r'<ol[^>]*>(.*?)</ol>', bloque, re.DOTALL)
    if match:
        items = re.findall(r'<li[^>]*>(.*?)</li>', match.group(1), re.DOTALL)
        lista_elementos = []
        for i, item in enumerate(items, 1):
            texto = limpiar_html(item)
            lista_elementos.append(Paragraph(f"{i}. {texto}", estilos['ListaPIIE']))
        return KeepTogether(lista_elementos) if lista_elementos else None
    
    # Párrafo
    match = re.match(r'<p[^>]*>(.*?)</p>', bloque, re.DOTALL)
    if match:
        texto = match.group(1)
        texto = re.sub(r'<strong>(.*?)</strong>', r'<b>\1</b>', texto)
        texto = re.sub(r'<em>(.*?)</em>', r'<i>\1</i>', texto)
        texto = re.sub(r'<a[^>]*>(.*?)</a>', r'\1', texto)
        texto = re.sub(r'<br\s*/?>', ' ', texto)
        texto = re.sub(r'\s+', ' ', texto).strip()
        
        if texto:
            estilo = 'PrimerParrafo' if es_primer_parrafo else 'CuerpoPIIE'
            return Paragraph(texto, estilos[estilo])
    
    return None


def agregar_cabecera_pie_pdf(canvas, doc, metadatos):
    """Cabecera y pie de página del PDF."""
    canvas.saveState()
    
    # Cabecera con línea
    canvas.setStrokeColor(COLOR_PRIMARIO)
    canvas.setLineWidth(2)
    canvas.line(MARGEN_IZQ, ALTO_PAGINA - 1.2*cm, ANCHO_PAGINA - MARGEN_DER, ALTO_PAGINA - 1.2*cm)
    
    # Pie de página
    canvas.setFont('Helvetica', 8)
    canvas.setFillColor(COLOR_TEXTO_LIGHT)
    
    # Número de página
    canvas.drawCentredString(ANCHO_PAGINA / 2, 1.5*cm, str(doc.page))
    
    # Autor
    canvas.drawString(MARGEN_IZQ, 1.5*cm, "Víctor Gutiérrez Marcos")
    
    # Número y fecha
    numero = metadatos.get('numero', '')
    fecha = formatear_fecha(metadatos.get('fecha', datetime.now()), 'corto')
    canvas.drawRightString(ANCHO_PAGINA - MARGEN_DER, 1.5*cm, f"{numero} | {fecha}")
    
    # Línea inferior
    canvas.setLineWidth(0.5)
    canvas.line(MARGEN_IZQ, 1.9*cm, ANCHO_PAGINA - MARGEN_DER, 1.9*cm)
    
    canvas.restoreState()


def generar_pdf(metadatos, contenido_md, ruta_salida):
    """Genera el PDF estilo PIIE."""
    
    doc = SimpleDocTemplate(
        str(ruta_salida),
        pagesize=A4,
        leftMargin=MARGEN_IZQ,
        rightMargin=MARGEN_DER,
        topMargin=MARGEN_SUP + 1*cm,
        bottomMargin=MARGEN_INF,
    )
    
    estilos = crear_estilos_pdf()
    elementos = []
    
    ancho_contenido = ANCHO_PAGINA - MARGEN_IZQ - MARGEN_DER
    
    # Barra de título
    elementos.append(BarraTitulo(ancho_contenido + 1*cm, texto="ARTÍCULO DE ANÁLISIS"))
    elementos.append(Spacer(1, 0.8*cm))
    
    # Número y título
    numero = metadatos.get('numero', '')
    titulo = metadatos.get('titulo', 'Sin título')
    if numero:
        titulo_completo = f"<b>{numero}</b> {titulo}"
    else:
        titulo_completo = titulo
    elementos.append(Paragraph(titulo_completo, estilos['TituloPIIE']))
    
    # Subtítulo
    if metadatos.get('subtitulo'):
        elementos.append(Paragraph(metadatos['subtitulo'], estilos['SubtituloPIIE']))
    
    # Línea dorada
    elementos.append(LineaDorada(ancho_contenido * 0.4))
    elementos.append(Spacer(1, 0.3*cm))
    
    # Autor y fecha
    autor = metadatos.get('autor', 'Víctor Gutiérrez Marcos')
    fecha = formatear_fecha(metadatos.get('fecha', datetime.now()), 'corto')
    elementos.append(Paragraph(f"<b>{autor}</b><br/>{fecha}", estilos['AutorFecha']))
    
    # Contenido
    contenido_html = md_a_html(contenido_md)
    elementos_contenido = procesar_contenido_pdf(contenido_html, estilos)
    elementos.extend(elementos_contenido)
    
    # Pie con copyright simple
    elementos.append(Spacer(1, 1*cm))
    elementos.append(LineaDorada(ancho_contenido, grosor=2))
    elementos.append(Spacer(1, 0.4*cm))
    
    copyright_text = f"© {datetime.now().year} Víctor Gutiérrez Marcos"
    
    estilos.add(ParagraphStyle(
        name='Copyright',
        fontName='Helvetica',
        fontSize=8,
        leading=10,
        textColor=COLOR_TEXTO_LIGHT,
        alignment=TA_LEFT,
    ))
    elementos.append(Paragraph(copyright_text, estilos['Copyright']))
    
    # Construir PDF
    def agregar_marco(canvas, doc):
        agregar_cabecera_pie_pdf(canvas, doc, metadatos)
    
    doc.build(elementos, onFirstPage=agregar_marco, onLaterPages=agregar_marco)


def actualizar_indice(slug, metadatos, ruta_blog):
    """Actualiza el índice del blog."""
    ruta_index = ruta_blog / 'index.html'
    
    if not ruta_index.exists():
        print("⚠ No se encontró index.html")
        return
    
    with open(ruta_index, 'r', encoding='utf-8') as f:
        contenido = f.read()
    
    fecha_legible = formatear_fecha(metadatos.get('fecha', datetime.now()))
    fecha_iso = formatear_fecha(metadatos.get('fecha', datetime.now()), 'iso') if metadatos.get('fecha') else datetime.now().strftime('%Y-%m-%d')
    
    nuevo_articulo = f'''
                    <article class="article-card">
                        <div class="article-meta">
                            <time datetime="{fecha_iso}">{fecha_legible}</time>
                            <span class="article-category">{metadatos.get('categoria', 'General')}</span>
                        </div>
                        <h3 class="article-title">
                            <a href="{slug}.html">{metadatos.get('titulo', 'Sin título')}</a>
                        </h3>
                        <p class="article-excerpt">
                            {metadatos.get('subtitulo', '')}
                        </p>
                        <div class="article-actions">
                            <a href="{slug}.html" class="read-more">Leer artículo</a>
                            <a href="{slug}.pdf" class="download-pdf" download>PDF</a>
                        </div>
                    </article>
'''
    
    marcador = '<!-- INICIO ARTÍCULOS -->'
    if marcador in contenido:
        contenido = contenido.replace(marcador, marcador + nuevo_articulo)
        with open(ruta_index, 'w', encoding='utf-8') as f:
            f.write(contenido)
        print("✓ Índice actualizado")


def main():
    if len(sys.argv) < 2:
        print(__doc__)
        sys.exit(1)
    
    ruta_md = Path(sys.argv[1])
    
    if not ruta_md.exists():
        print(f"Error: No se encontró {ruta_md}")
        sys.exit(1)
    
    print(f"\n📄 Procesando: {ruta_md.name}")
    print("=" * 50)
    
    metadatos, contenido_md = cargar_articulo(ruta_md)
    
    if not metadatos.get('titulo'):
        print("Error: Falta el título en los metadatos YAML")
        sys.exit(1)
    
    ruta_blog = ruta_md.parent
    slug = metadatos.get('numero', generar_slug(metadatos['titulo']))
    
    # HTML
    ruta_html = ruta_blog / f"{slug}.html"
    generar_html(metadatos, contenido_md, ruta_html)
    print(f"✓ HTML: {ruta_html.name}")
    
    # PDF
    ruta_pdf = ruta_blog / f"{slug}.pdf"
    generar_pdf(metadatos, contenido_md, ruta_pdf)
    print(f"✓ PDF: {ruta_pdf.name}")
    
    # Índice
    actualizar_indice(slug, metadatos, ruta_blog)
    
    print("=" * 50)
    print("✅ Artículo publicado correctamente\n")


if __name__ == '__main__':
    main()
