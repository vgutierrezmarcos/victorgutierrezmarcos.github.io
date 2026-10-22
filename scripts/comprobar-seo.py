#!/usr/bin/env python3
"""Comprobación técnica del SEO de la web, con nota de 0 a 100 por categorías.

Revisa cada página HTML del repositorio (título, descripción, canonical, h1,
Open Graph, datos estructurados, imágenes sin alt, enlaces internos rotos,
contenido escaso, nombre del autor sin tilde), el sitemap, robots.txt y
llms.txt, y, en línea, que las direcciones clave respondan y, si hay clave
de API, los Core Web Vitals de PageSpeed Insights. Da una lista de problemas
por prioridad (Crítico, Alto, Medio, Bajo) y una nota global con los mismos
pesos que la auditoría del plugin claude-seo del 15 oct. 2026 (técnico 22 %,
contenido 23 %, página 20 %, datos estructurados 10 %, rendimiento 10 %,
buscadores con IA 10 %, imágenes 5 %).

    python3 scripts/comprobar-seo.py               # informe en texto
    python3 scripts/comprobar-seo.py --json        # el resultado en JSON
    python3 scripts/comprobar-seo.py --sin-red     # solo lo local (sin peticiones)

PageSpeed: la cuota anónima se agota enseguida; con una clave de API del
proyecto web-vgm (API PageSpeed Insights) en ~/.config/oposicion-red/pagespeed.json
({"clave": "AIza…"}) mide la portada, /oposicion/ y /app/. Guarda el resultado
en ~/.local/share/oposicion-web/seo-AAAA-MM-DD.json. Solo biblioteca estándar.
"""
import json
import os
import re
import ssl
import sys
import urllib.error
import urllib.parse
import urllib.request
from collections import Counter
from datetime import date, datetime, timezone
from html.parser import HTMLParser
from pathlib import Path

RAIZ = Path(__file__).resolve().parent.parent
SITIO = 'https://www.victorgutierrezmarcos.es'
FOTOS = Path.home() / '.local/share/oposicion-web'
CLAVE_PSI = Path.home() / '.config/oposicion-red/pagespeed.json'
# Carpetas que no son páginas del sitio (plantillas, código, copias)
EXCLUIR = ('.Rproj.user', '.git', 'app/abrir', 'app/android', 'app/web', 'app/build', 'app/ios', 'app/lib', 'app/test', 'app/tool',
           'app/para-manuel', 'app/play-store', 'blog/newsletter', 'blog/templates', 'scripts', 'backup', 'node_modules',
           'oposicion/organizacion/oculto', 'oposicion/temario/oculto')
PESOS = {'técnico': 22, 'contenido': 23, 'página': 20, 'datos estructurados': 10, 'rendimiento': 10, 'IA': 10, 'imágenes': 5}
DESCUENTO = {'Crítico': 25, 'Alto': 10, 'Medio': 4, 'Bajo': 1}
EN_LINEA = ['/', '/oposicion/', '/app/', '/oposicion/por-que-tcee.html', '/oposicion/temario/tercer-ejercicio.html',
            '/sitemap.xml', '/robots.txt', '/llms.txt']
PSI_PAGINAS = ['/', '/oposicion/', '/app/']

_CAS = Path.home() / '.config/oposicion-red/cas.pem'
if _CAS.exists() and 'SSL_CERT_FILE' not in os.environ:
    os.environ['SSL_CERT_FILE'] = str(_CAS)


# ----------------------------------------------------------------- Páginas

class Pagina(HTMLParser):
    """Lo que importa de una página: cabecera, encabezados, imágenes, enlaces y texto."""

    def __init__(self):
        super().__init__(convert_charrefs=True)
        self.title = None
        self.meta = {}
        self.canonical = None
        self.lang = None
        self.h1 = []
        self.img_sin_alt = 0
        self.imagenes = 0
        self.enlaces = []
        self.jsonld = []
        self.texto = []
        self._en = None
        self._ld = False
        self._omitir = 0
        self._svg = 0

    def handle_starttag(self, tag, attrs):
        a = dict(attrs)
        if tag == 'html':
            self.lang = a.get('lang')
        elif tag == 'svg':
            self._svg += 1
        elif tag == 'title' and not self._svg and self.title is None:
            # Solo el <title> de la cabecera: los SVG llevan los suyos
            self._en = 'title'
            self.title = ''
        elif tag == 'meta':
            n = a.get('name') or a.get('property')
            if n:
                self.meta[n.lower()] = a.get('content', '')
        elif tag == 'link' and a.get('rel', '').lower() == 'canonical':
            self.canonical = a.get('href')
        elif tag == 'h1':
            self._en = 'h1'
            self.h1.append('')
        elif tag == 'img':
            self.imagenes += 1
            if not a.get('alt', None) and a.get('alt') != '':
                self.img_sin_alt += 1
        elif tag == 'a' and a.get('href'):
            self.enlaces.append(a['href'])
        elif tag == 'script':
            if a.get('type', '').lower() == 'application/ld+json':
                self._ld = True
                self.jsonld.append('')
            self._omitir += 1
        elif tag in ('style', 'noscript', 'template'):
            self._omitir += 1

    def handle_endtag(self, tag):
        if tag == 'svg':
            self._svg = max(0, self._svg - 1)
        if tag in ('title', 'h1'):
            self._en = None
        elif tag in ('script', 'style', 'noscript', 'template'):
            self._omitir = max(0, self._omitir - 1)
            self._ld = False

    def handle_data(self, d):
        if self._en == 'title':
            self.title = (self.title or '') + d
        elif self._en == 'h1':
            self.h1[-1] += d
        if self._ld:
            self.jsonld[-1] += d
        elif not self._omitir:
            self.texto.append(d)


def paginas_del_sitio():
    for p in sorted(RAIZ.rglob('*.html')):
        rel = p.relative_to(RAIZ).as_posix()
        if any(rel == e or rel.startswith(e + '/') for e in EXCLUIR) or p.name.startswith('_'):
            continue
        yield rel, p


def url_de(rel):
    rel = re.sub(r'(^|/)index\.html$', r'\1', rel)
    return f'{SITIO}/{rel}'


def existe_local(destino):
    """Si una dirección del sitio (ruta) corresponde a un fichero del repositorio."""
    ruta = urllib.parse.unquote(destino.split('#')[0].split('?')[0])
    if not ruta or ruta == '/':
        return True
    p = RAIZ / ruta.lstrip('/')
    return p.is_file() or (p.is_dir() and (p / 'index.html').is_file())


def analizar_paginas():
    problemas, resumen, titulos, descripciones = [], {}, Counter(), Counter()
    textos_sin_tilde = 0
    for rel, ruta in paginas_del_sitio():
        try:
            html = ruta.read_text(encoding='utf-8', errors='replace')
        except OSError:  # ficheros temporales de otra sesión que desaparecen
            continue
        pg = Pagina()
        pg.feed(html)
        robots = pg.meta.get('robots', '')
        noindex = 'noindex' in robots
        url = url_de(rel)
        canonical = (pg.canonical or '').rstrip()
        puente = bool(canonical) and canonical.rstrip('/') != url.rstrip('/') and not noindex
        titulo = (pg.title or '').strip()
        desc = pg.meta.get('description', '').strip()
        palabras = len(re.findall(r'\w+', ' '.join(pg.texto)))
        tipos_ld, ld_malos = [], 0
        for bloque in pg.jsonld:
            try:
                d = json.loads(bloque)
                nodos = d.get('@graph', [d]) if isinstance(d, dict) else d
                tipos_ld += [str(n.get('@type')) for n in nodos if isinstance(n, dict)]
            except (ValueError, AttributeError):
                ld_malos += 1
        rotos = []
        for h in pg.enlaces:
            if h.startswith(('#', 'mailto:', 'tel:', 'javascript:')):
                continue
            u = urllib.parse.urlparse(h)
            if u.scheme or u.netloc:
                if u.netloc.endswith('victorgutierrezmarcos.es') and not existe_local(u.path):
                    rotos.append(h)
                continue
            destino = h if h.startswith('/') else urllib.parse.urljoin('/' + rel, h)
            if not existe_local(destino):
                rotos.append(h)
        rotos = sorted(set(rotos))

        def p(nivel, cat, texto):
            problemas.append({'nivel': nivel, 'categoría': cat, 'página': rel, 'texto': texto})

        if 'Victor Gutierrez' in html:
            textos_sin_tilde += 1
            p('Bajo', 'contenido', 'Nombre del autor sin tilde («Victor Gutierrez»)')
        if rotos:
            p('Alto', 'técnico', f'{len(rotos)} enlace(s) interno(s) a ficheros que no existen: ' + ', '.join(rotos[:4]))
        if canonical and canonical.startswith(SITIO) and not existe_local(canonical[len(SITIO):]):
            p('Crítico', 'técnico', f'El canonical apunta a una dirección que no existe: {canonical}')
        if noindex:
            resumen[rel] = {'estado': 'noindex', 'título': titulo}
            continue
        if puente:
            resumen[rel] = {'estado': 'puente', 'canonical': canonical, 'título': titulo}
            continue
        # Página indexable
        if not titulo:
            p('Alto', 'página', 'Sin <title>')
        else:
            titulos[titulo] += 1
            if len(titulo) > 65:
                p('Bajo', 'página', f'Título de {len(titulo)} caracteres (Google corta hacia 60)')
        if not desc:
            p('Alto', 'página', 'Sin meta description')
        else:
            descripciones[desc] += 1
            if len(desc) > 160:
                p('Bajo', 'página', f'Descripción de {len(desc)} caracteres (se corta hacia 160)')
            elif len(desc) < 50:
                p('Bajo', 'página', f'Descripción muy corta ({len(desc)} caracteres)')
        if not canonical:
            p('Alto', 'técnico', 'Sin canonical')
        elif not canonical.startswith(SITIO + '/'):
            p('Alto', 'técnico', f'Canonical fuera del dominio con www: {canonical}')
        if len(pg.h1) != 1:
            p('Medio', 'página', f'{len(pg.h1)} encabezados h1 (debe haber uno)')
        if (pg.lang or '').lower()[:2] != 'es':
            p('Medio', 'técnico', 'Sin lang="es" en <html>')
        if 'viewport' not in pg.meta:
            p('Alto', 'técnico', 'Sin meta viewport (móvil)')
        for og in ('og:title', 'og:description', 'og:image'):
            if og not in pg.meta:
                p('Bajo', 'página', f'Falta {og}')
        if ld_malos:
            p('Alto', 'datos estructurados', f'{ld_malos} bloque(s) JSON-LD que no son JSON válido')
        if not pg.jsonld:
            p('Medio', 'datos estructurados', 'Sin datos estructurados (JSON-LD)')
        if pg.img_sin_alt:
            p('Medio', 'imágenes', f'{pg.img_sin_alt} de {pg.imagenes} imágenes sin alt')
        if palabras < 150:
            p('Medio', 'contenido', f'Contenido escaso: {palabras} palabras')
        resumen[rel] = {'estado': 'indexable', 'título': titulo, 'descripción': len(desc), 'palabras': palabras,
                        'h1': len(pg.h1), 'jsonld': tipos_ld, 'imágenes sin alt': pg.img_sin_alt, 'enlaces rotos': len(rotos)}
    for t, n in titulos.items():
        if n > 1:
            problemas.append({'nivel': 'Medio', 'categoría': 'página', 'página': '(varias)', 'texto': f'Título repetido en {n} páginas: «{t[:60]}»'})
    for d, n in descripciones.items():
        if n > 1:
            problemas.append({'nivel': 'Medio', 'categoría': 'página', 'página': '(varias)', 'texto': f'Descripción repetida en {n} páginas: «{d[:60]}…»'})
    return problemas, resumen


# --------------------------------------------------------- Sitemap y robots

def analizar_sitio(resumen):
    problemas = []

    def p(nivel, cat, texto, pagina='(sitio)'):
        problemas.append({'nivel': nivel, 'categoría': cat, 'página': pagina, 'texto': texto})

    sitemap = RAIZ / 'sitemap.xml'
    datos = {'sitemap': {}, 'robots': {}, 'llms': (RAIZ / 'llms.txt').is_file()}
    if not sitemap.is_file():
        p('Crítico', 'técnico', 'No hay sitemap.xml')
    else:
        xml = sitemap.read_text(encoding='utf-8')
        locs = re.findall(r'<loc>\s*(.*?)\s*</loc>', xml)
        lastmods = re.findall(r'<lastmod>\s*(\d{4}-\d{2}-\d{2})', xml)
        rotas = [l for l in locs if l.startswith(SITIO) and not existe_local(l[len(SITIO):])]
        if rotas:
            p('Alto', 'técnico', f'{len(rotas)} direcciones del sitemap no existen: ' + ', '.join(rotas[:3]))
        en_sitemap = {l.rstrip('/') for l in locs}
        faltan = [rel for rel, r in resumen.items() if r['estado'] == 'indexable' and url_de(rel).rstrip('/') not in en_sitemap]
        if faltan:
            p('Medio', 'técnico', f'{len(faltan)} páginas indexables fuera del sitemap: ' + ', '.join(faltan[:5]))
        sobran = [l for l in locs if l.endswith('.html') and l.startswith(SITIO)
                  and resumen.get(l[len(SITIO) + 1:], {}).get('estado') in ('noindex', 'puente')]
        if sobran:
            p('Medio', 'técnico', f'{len(sobran)} páginas noindex o puente dentro del sitemap: ' + ', '.join(sobran[:3]))
        datos['sitemap'] = {'direcciones': len(locs), 'pdf': sum(l.endswith('.pdf') for l in locs),
                            'último lastmod': max(lastmods, default=None), 'faltan': faltan, 'rotas': rotas}
    robots = RAIZ / 'robots.txt'
    if not robots.is_file():
        p('Alto', 'técnico', 'No hay robots.txt')
    else:
        t = robots.read_text(encoding='utf-8')
        datos['robots'] = {'sitemap': 'Sitemap:' in t, 'bloquea app': bool(re.search(r'Disallow:\s*/app/\s*$', t, re.M))}
        if 'Sitemap:' not in t:
            p('Medio', 'técnico', 'robots.txt no declara el sitemap')
        if datos['robots']['bloquea app']:
            p('Alto', 'técnico', 'robots.txt bloquea /app/ entera')
        for bot in ('GPTBot', 'ClaudeBot', 'PerplexityBot', 'Google-Extended'):
            if re.search(rf'User-agent:\s*{bot}\s*\n\s*Disallow:\s*/\s*$', t, re.M | re.I):
                p('Medio', 'IA', f'robots.txt bloquea a {bot}')
    if not datos['llms']:
        p('Bajo', 'IA', 'No hay llms.txt')
    faq = [rel for rel, r in resumen.items() if 'FAQPage' in r.get('jsonld', [])]
    datos['faq'] = faq
    if not faq:
        p('Bajo', 'IA', 'Ninguna página con FAQPage (respuestas citables por los buscadores con IA)')
    return problemas, datos


# ---------------------------------------------------------------- En línea

def _get(url, timeout=25, cabeceras=None):
    r = urllib.request.Request(url, headers={'User-Agent': 'Mozilla/5.0 (comprobar-seo)', **(cabeceras or {})})
    return urllib.request.urlopen(r, timeout=timeout)


def comprobar_en_linea():
    problemas, estado = [], {}
    for ruta in EN_LINEA:
        url = SITIO + ruta
        try:
            with _get(url) as r:
                estado[ruta] = {'código': r.status, 'final': r.geturl()}
                if r.status != 200:
                    problemas.append({'nivel': 'Alto', 'categoría': 'técnico', 'página': ruta, 'texto': f'Responde {r.status}'})
        except urllib.error.HTTPError as e:
            estado[ruta] = {'código': e.code}
            problemas.append({'nivel': 'Crítico', 'categoría': 'técnico', 'página': ruta, 'texto': f'Responde {e.code} en línea'})
        except (urllib.error.URLError, OSError, ssl.SSLError) as e:
            estado[ruta] = {'error': str(e)[:100]}
            problemas.append({'nivel': 'Alto', 'categoría': 'técnico', 'página': ruta, 'texto': f'No responde: {str(e)[:80]}'})
    # El dominio sin www tiene que llevar al de www con HTTPS (el registro A
    # sobrante del DNS lo rompía en oct. 2026)
    for url in ('https://victorgutierrezmarcos.es/', 'http://victorgutierrezmarcos.es/'):
        try:
            with _get(url) as r:
                estado[url] = {'código': r.status, 'final': r.geturl()}
                if not r.geturl().startswith(SITIO):
                    problemas.append({'nivel': 'Alto', 'categoría': 'técnico', 'página': url, 'texto': f'No redirige al dominio con www (acaba en {r.geturl()})'})
        except (urllib.error.URLError, OSError, ssl.SSLError) as e:
            estado[url] = {'error': str(e)[:100]}
            problemas.append({'nivel': 'Alto', 'categoría': 'técnico', 'página': url, 'texto': f'Falla sin www: {str(e)[:80]} (revisar el DNS del dominio raíz)'})
    return problemas, estado


def pagespeed():
    """Core Web Vitals (campo, de CrUX, si los hay) y nota de laboratorio de PageSpeed."""
    clave = None
    if CLAVE_PSI.exists():
        try:
            clave = json.loads(CLAVE_PSI.read_text()).get('clave')
        except ValueError:
            pass
    salida = {}
    for ruta in PSI_PAGINAS:
        q = {'url': SITIO + ruta, 'strategy': 'mobile', 'category': 'performance'}
        if clave:
            q['key'] = clave
        try:
            with _get('https://www.googleapis.com/pagespeedonline/v5/runPagespeed?' + urllib.parse.urlencode(q), timeout=120) as r:
                d = json.load(r)
        except urllib.error.HTTPError as e:
            msg = 'cuota anónima agotada: hace falta una clave de API' if e.code == 429 else f'{e.code}'
            salida[ruta] = {'pendiente': msg}
            if e.code == 429 and not clave:
                break
            continue
        except (urllib.error.URLError, OSError, ValueError) as e:
            salida[ruta] = {'pendiente': str(e)[:80]}
            continue
        lh = d.get('lighthouseResult', {})
        aud = lh.get('audits', {})
        campo = {k: v.get('category') for k, v in d.get('loadingExperience', {}).get('metrics', {}).items()}
        salida[ruta] = {
            'nota laboratorio': round(100 * (lh.get('categories', {}).get('performance', {}).get('score') or 0)),
            'LCP': aud.get('largest-contentful-paint', {}).get('displayValue'),
            'CLS': aud.get('cumulative-layout-shift', {}).get('displayValue'),
            'TBT': aud.get('total-blocking-time', {}).get('displayValue'),
            'campo': {'LCP': campo.get('LARGEST_CONTENTFUL_PAINT_MS'), 'INP': campo.get('INTERACTION_TO_NEXT_PAINT'),
                      'CLS': campo.get('CUMULATIVE_LAYOUT_SHIFT_SCORE')} if campo else None,
        }
    return salida


# -------------------------------------------------------------------- Nota

def calcular_nota(problemas, psi):
    cat = {c: 100 for c in PESOS}
    for pr in problemas:
        cat[pr['categoría']] = max(0, cat[pr['categoría']] - DESCUENTO[pr['nivel']])
    notas_psi = [v['nota laboratorio'] for v in psi.values() if 'nota laboratorio' in v]
    malos = sum(1 for v in psi.values() for m, c in (v.get('campo') or {}).items() if c in ('SLOW', 'AVERAGE'))
    pesos = dict(PESOS)
    if notas_psi:
        cat['rendimiento'] = max(0, round(sum(notas_psi) / len(notas_psi)) - 8 * malos)
    else:
        cat['rendimiento'] = None
        pesos.pop('rendimiento')
    total = sum(cat[c] * w for c, w in pesos.items()) / sum(pesos.values())
    return round(total), {c: {'nota': cat[c], 'peso': PESOS[c]} for c in PESOS}


def comprobar(en_linea=True):
    problemas, resumen = analizar_paginas()
    p2, sitio = analizar_sitio(resumen)
    problemas += p2
    estado, psi = {}, {}
    if en_linea:
        p3, estado = comprobar_en_linea()
        problemas += p3
        psi = pagespeed()
    orden = {'Crítico': 0, 'Alto': 1, 'Medio': 2, 'Bajo': 3}
    problemas.sort(key=lambda x: (orden[x['nivel']], x['categoría'], x['página']))
    nota, categorias = calcular_nota(problemas, psi)
    indexables = sum(r['estado'] == 'indexable' for r in resumen.values())
    return {
        'fecha': date.today().isoformat(), 'nota': nota, 'categorías': categorias,
        'páginas': {'total': len(resumen), 'indexables': indexables,
                    'puente': sum(r['estado'] == 'puente' for r in resumen.values()),
                    'noindex': sum(r['estado'] == 'noindex' for r in resumen.values())},
        'por nivel': dict(Counter(p['nivel'] for p in problemas)),
        'problemas': problemas, 'sitio': sitio, 'en línea': estado, 'pagespeed': psi,
        'páginas detalle': resumen,
    }


def imprimir(r):
    print(f"SEO técnico — {r['fecha']} · nota {r['nota']}/100 · {r['páginas']['indexables']} páginas indexables "
          f"({r['páginas']['puente']} puente, {r['páginas']['noindex']} noindex)")
    print('  ' + ' · '.join(f"{c} {v['nota'] if v['nota'] is not None else 'sin medir'}" for c, v in r['categorías'].items()))
    print('  Problemas: ' + (', '.join(f'{k} {v}' for k, v in r['por nivel'].items()) or 'ninguno'))
    for p in r['problemas'][:40]:
        print(f"  [{p['nivel']}] {p['página']}: {p['texto']}")
    if len(r['problemas']) > 40:
        print(f'  … y {len(r["problemas"]) - 40} más')
    s = r['sitio'].get('sitemap', {})
    if s:
        print(f"\nSitemap: {s['direcciones']} direcciones ({s['pdf']} PDF), último lastmod {s['último lastmod']}")
    if r['en línea']:
        print('En línea: ' + ', '.join(f"{k} {v.get('código', v.get('error', '?'))}" for k, v in r['en línea'].items()))
    for ruta, v in r['pagespeed'].items():
        print(f"PageSpeed {ruta}: " + (f"pendiente ({v['pendiente']})" if 'pendiente' in v else
                                     f"{v['nota laboratorio']}/100 · LCP {v['LCP']} · CLS {v['CLS']} · TBT {v['TBT']} · campo {v['campo'] or 'sin datos'}"))


def main():
    r = comprobar(en_linea='--sin-red' not in sys.argv)
    FOTOS.mkdir(parents=True, exist_ok=True)
    (FOTOS / f"seo-{r['fecha']}.json").write_text(json.dumps(r, ensure_ascii=False, indent=1))
    if '--json' in sys.argv:
        print(json.dumps(r, ensure_ascii=False, indent=1))
    else:
        imprimir(r)


if __name__ == '__main__':
    main()
