#!/usr/bin/env python3
"""Saca el texto que indexa el buscador de la web (lo lee indexar.mjs, que genera /pagefind/).

Registros (uno por línea en scripts/buscador/registros.jsonl, fuera de git):
  - tema:     cada apartado de cada tema en PDF (el índice del PDF da la página; los PDF sin
              índice, por bloques de 2 páginas), con su texto. De los temas revisados del 3.º
              y de la guía del dictamen, solo el título, los apartados y los conceptos (no son
              públicos: el resultado lleva a su página); su versión antigua, con el texto.
  - pagina:   las páginas HTML del sitemap (solo el contenido de <main>).
  - test:     las preguntas oficiales del test (sin su explicación, que es exclusiva).

    python3 scripts/buscador/extraer.py
    node scripts/buscador/indexar.mjs

Autor: Víctor Gutiérrez Marcos
"""
import html
import json
import os
import re
from html.parser import HTMLParser

import fitz  # PyMuPDF

RAIZ = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
WEB = 'https://www.victorgutierrezmarcos.es/'
SALIDA = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'registros.jsonl')
MAX_TEXTO = 14000          # caracteres por registro (un apartado largo se corta)
EJERCICIO = {'1': 'Primer ejercicio', '2': 'Segundo ejercicio', '3': 'Tercer ejercicio', '4': 'Cuarto ejercicio', '5': 'Quinto ejercicio'}


def limpiar(t):
    t = t.replace('­', '').replace('-\n', '')
    return re.sub(r'\s+', ' ', t).strip()


def apartados_pdf(ruta):
    """[(título del apartado, página inicial, página final)] por los marcadores de nivel 1 y 2 del PDF."""
    doc = fitz.open(ruta)
    n = len(doc)
    marcas = [(nivel, titulo.strip(), pag) for nivel, titulo, pag in doc.get_toc() if nivel <= 2 and pag >= 1]
    if not marcas:
        return doc, [(None, i, min(i + 1, n)) for i in range(1, n + 1, 2)]
    salida = []
    for k, (nivel, titulo, pag) in enumerate(marcas):
        fin = (marcas[k + 1][2] if k + 1 < len(marcas) else n + 1)
        salida.append((titulo, pag, max(pag, fin - 1 if fin > pag else pag)))
    return doc, salida


def registros_tema(ruta, codigo, titulo_tema, url, revisado):
    doc, partes = apartados_pdf(os.path.join(RAIZ, ruta))
    ej = codigo.split('.')[0] if codigo[0].isdigit() else '1'
    for apartado, ini, fin in partes:
        texto = limpiar(' '.join(doc[p - 1].get_text() for p in range(ini, fin + 1)))
        if len(texto) < 80 or (apartado or '').strip().lower() in ('bibliografía', 'referencias', 'índice'):
            continue
        yield {
            'tipo': 'tema', 'url': f'{url}#page={ini}', 'titulo': f'Tema {codigo}: {titulo_tema}' if codigo[0].isdigit() else titulo_tema,
            'codigo': codigo, 'apartado': apartado or f'Páginas {ini}-{fin}', 'pagina': ini, 'ejercicio': EJERCICIO.get(ej, ''),
            'revisado': revisado, 'pdf': url, 'texto': texto[:MAX_TEXTO],
        }


def registros_revisado(t):
    """Un tema revisado, sin su texto (Víctor, 26/11/2026: el índice es público y los temas
    revisados solo se leen con sesión): se encuentra por su título, sus apartados y los conceptos
    de su índice, y el resultado lleva a su página (que pide iniciar sesión o da la antigua)."""
    guia = t['archivo'] == '1D01'
    codigo = 'Dictamen' if guia else t['codigo']
    titulo = 'Guía para el dictamen de coyuntura económica' if guia else f"Tema {t['codigo']}: {t['titulo'].rstrip('.')}"
    pagina = WEB + t['pagina']
    comun = {'tipo': 'tema', 'titulo': titulo, 'codigo': codigo, 'ejercicio': EJERCICIO['1' if guia else t['codigo'][0]],
             'revisado': True, 'pdf': pagina, 'pagina': 1}
    yield {**comun, 'url': pagina, 'apartado': 'Conceptos del tema', 'texto': '; '.join(t.get('conceptos') or [])[:MAX_TEXTO]}
    for apartado in t.get('apartados') or []:
        yield {**comun, 'url': f"{pagina}#apartado={apartado}", 'apartado': apartado, 'texto': apartado}


def temas():
    revisados = json.load(open(os.path.join(RAIZ, 'oposicion/temario/revisados-web.json'), encoding='utf-8'))['temas']
    ya = set()
    for t in revisados:
        yield from registros_revisado(t)
        # La versión antigua (licencia CC, pública), con su texto completo
        if t.get('anterior') and os.path.exists(os.path.join(RAIZ, t['anterior'])):
            url = WEB + t['anterior']
            ya.add(url)
            nombre = 'Guía para el dictamen de coyuntura económica (versión anterior)' if t['archivo'] == '1D01' else f"{t['titulo'].rstrip('.')} (versión anterior)"
            yield from registros_tema(t['anterior'], 'Dictamen' if t['archivo'] == '1D01' else t['codigo'], nombre, url, False)
    temario = json.load(open(os.path.join(RAIZ, 'oposicion/temario/temario.json'), encoding='utf-8'))
    for ej in temario['ejercicios']:
        for parte in ej.get('partes', []):
            for t in parte.get('temas', []):
                url = t.get('url') or ''
                if not t.get('disponible') or not url.endswith('.pdf') or url in ya:
                    continue
                ruta = url.replace(WEB, '')
                if os.path.exists(os.path.join(RAIZ, ruta)):
                    yield from registros_tema(ruta, t['codigo'], t['titulo'].rstrip('.'), url, False)


class Principal(HTMLParser):
    """El texto de <main> (o de <article>), sin scripts, estilos ni navegación."""
    def __init__(self):
        super().__init__()
        self.dentro, self.fuera, self.partes = 0, 0, []

    def handle_starttag(self, tag, attrs):
        if tag in ('main', 'article'):
            self.dentro += 1
        if tag in ('script', 'style', 'nav', 'noscript', 'svg', 'button'):
            self.fuera += 1

    def handle_endtag(self, tag):
        if tag in ('main', 'article'):
            self.dentro = max(0, self.dentro - 1)
        if tag in ('script', 'style', 'nav', 'noscript', 'svg', 'button'):
            self.fuera = max(0, self.fuera - 1)

    def handle_data(self, data):
        if self.dentro and not self.fuera:
            self.partes.append(data)


def paginas():
    sitemap = open(os.path.join(RAIZ, 'sitemap.xml'), encoding='utf-8').read()
    for url in re.findall(r'<loc>([^<]+)</loc>', sitemap):
        if url.endswith('.pdf'):
            continue
        ruta = url.replace(WEB, '')
        ruta = ruta + 'index.html' if ruta.endswith('/') or not ruta else ruta
        archivo = os.path.join(RAIZ, ruta)
        if not os.path.exists(archivo):
            continue
        fuente = open(archivo, encoding='utf-8').read()
        if re.search(r'<meta name="robots" content="[^"]*noindex', fuente):
            continue
        titulo = html.unescape(re.sub(r'\s*[|·]\s*Víctor Gutiérrez Marcos\s*$', '', (re.search(r'<title>(.*?)</title>', fuente, re.S) or [None, ''])[1].strip()))
        desc = html.unescape((re.search(r'<meta name="description" content="([^"]*)"', fuente) or [None, ''])[1])
        p = Principal()
        p.feed(fuente)
        texto = limpiar(' '.join(p.partes))
        if len(texto) < 50:
            continue
        # Las páginas largas (la guía, las cifras) van en trozos de unos 6.000 caracteres:
        # mejores fragmentos y registros que Pagefind maneja bien.
        trozos, actual = [], ''
        for frase in re.split(r'(?<=[.!?])\s+', texto):
            if len(actual) + len(frase) > 6000 and actual:
                trozos.append(actual)
                actual = ''
            actual += (' ' if actual else '') + frase
        if actual:
            trozos.append(actual)
        for i, trozo in enumerate(trozos):
            yield {'tipo': 'blog' if ruta.startswith('blog/') else 'pagina', 'url': url if i == 0 else f'{url}#parte-{i + 1}', 'titulo': titulo,
                   'descripcion': desc if i == 0 else '', 'texto': trozo}


def test():
    base = os.path.join(RAIZ, 'oposicion/temario/primer-ejercicio/test')
    datos = json.load(open(os.path.join(base, 'preguntas.json'), encoding='utf-8'))
    examenes = {e['id']: e for e in datos.get('examenes', [])}
    # Sin las explicaciones: son material exclusivo (solo con sesión) y el índice es público.
    claves = {}
    for p in datos['preguntas']:
        ex = examenes.get(p.get('examen'), {})
        opciones = ' '.join(f'{k}) {v}' for k, v in (p.get('opciones') or {}).items())
        yield {
            'tipo': 'test', 'url': f'{WEB}oposicion/temario/primer-ejercicio/test/simulador.html?pregunta={p["id"]}',
            'titulo': f'Pregunta {p.get("numero", "")} del test de {ex.get("nombre", p.get("examen", ""))}',
            'codigo': (p.get('temas') or [''])[0], 'ejercicio': EJERCICIO['1'],
            'texto': limpiar(f'{p.get("enunciado", "")} {opciones} {claves.get(p["id"], "")}'),
        }


def main():
    n = {}
    with open(SALIDA, 'w', encoding='utf-8') as f:
        for fuente in (temas, paginas, test):
            for r in fuente():
                n[r['tipo']] = n.get(r['tipo'], 0) + 1
                f.write(json.dumps(r, ensure_ascii=False) + '\n')
    print(f'{sum(n.values())} registros ({", ".join(f"{v} {k}" for k, v in n.items())}) → {os.path.relpath(SALIDA, RAIZ)}')


if __name__ == '__main__':
    main()
