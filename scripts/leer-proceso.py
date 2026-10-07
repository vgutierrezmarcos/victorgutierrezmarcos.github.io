#!/usr/bin/env python3
"""Lee las páginas del Ministerio donde se sigue cada proceso selectivo y
deja sus documentos en `oposicion/proceso.json`, que la app consulta para
avisar de las novedades (convocatoria, admitidos, calendario, convocatorias
de cada ejercicio, aprobados…).

Lo ejecuta la acción `leer-proceso.yml` cada pocas horas. A mano:

    python3 scripts/leer-proceso.py            # lee el portal y actualiza el JSON
    python3 scripts/leer-proceso.py --html tcee=pagina.html   # desde un HTML guardado

Las páginas son `…/empleo/Paginas/OEP{año}TECOS.aspx` (TCEE) y
`OEP{año}DIPLOS.aspx` (DCE): se prueban el año siguiente, el actual y los dos
anteriores, y se guardan las dos convocatorias más recientes que existan
(mientras acaba una ya puede haber salido la siguiente).

El servidor del Ministerio no envía su certificado intermedio (GEANT TLS RSA 1),
así que se añade el de `scripts/certs/`. Si una página no responde, se conserva
lo que ya había: el JSON nunca se vacía por un fallo de red.
"""
import argparse
import hashlib
import html
import json
import re
import ssl
import sys
import urllib.error
import urllib.request
from datetime import datetime, timezone
from pathlib import Path

RAIZ = Path(__file__).resolve().parent.parent
SALIDA = RAIZ / 'oposicion' / 'proceso.json'
CERT = Path(__file__).resolve().parent / 'certs' / 'geant-tls-rsa-1.pem'
PORTAL = 'https://portal.mineco.gob.es'
PAGINA = PORTAL + '/es-es/ministerio/empleo/Paginas/OEP{anio}{cuerpo}.aspx'
OPOSICIONES = {'tcee': 'TECOS', 'dce': 'DIPLOS'}
CONVOCATORIAS = 2


def contexto_tls():
    ctx = ssl.create_default_context()
    if CERT.exists():
        ctx.load_verify_locations(cafile=str(CERT))
    return ctx


def descargar(url, ctx):
    """HTML de la página, o None si no existe (404) o no responde."""
    pet = urllib.request.Request(url, headers={'User-Agent': 'Mozilla/5.0 (oposicion-tcee; +https://www.victorgutierrezmarcos.es/app/)'})
    for _ in range(2):
        try:
            with urllib.request.urlopen(pet, context=ctx, timeout=40) as r:
                return r.read().decode('utf-8', errors='replace')
        except urllib.error.HTTPError as e:
            if e.code == 404:
                return None
        except (urllib.error.URLError, TimeoutError, ssl.SSLError) as e:
            print(f'  {url}: {e}', file=sys.stderr)
    raise ConnectionError(url)


def limpio(x):
    x = html.unescape(re.sub(r'<[^>]+>', '', x))
    return re.sub(r'\s+', ' ', x.replace('​', '')).strip()


def documentos(pagina):
    """Documentos de la página, con la sección (encabezado h2) de cada uno."""
    i = pagina.find('Compartir en')
    j = pagina.find('Navegaci', i)
    cuerpo = pagina[i if i >= 0 else 0:j if j > 0 else len(pagina)]
    seccion = ''
    vistos = set()
    out = []
    for m in re.finditer(r'<(h[1-6])\b[^>]*>(.*?)</\1>|<a\b[^>]*href="([^"]+)"[^>]*>(.*?)</a>', cuerpo, re.S):
        if m.group(1):
            seccion = limpio(m.group(2))
            continue
        href, titulo = html.unescape(m.group(3)), limpio(m.group(4))
        if not seccion or not titulo or href.startswith(('mailto:', 'javascript:', '#')):
            continue
        url = PORTAL + href if href.startswith('/') else href
        if url in vistos:
            continue
        vistos.add(url)
        out.append({'id': hashlib.sha1(url.encode()).hexdigest()[:12], 'seccion': seccion, 'titulo': titulo, 'url': url})
    return out


def leer_oposicion(cuerpo, ctx, anio):
    """Las convocatorias más recientes de un cuerpo: [(año, url, html)]."""
    out = []
    for a in range(anio + 1, anio - 3, -1):
        url = PAGINA.format(anio=a, cuerpo=cuerpo)
        pagina = descargar(url, ctx)
        if pagina and '<h2' in pagina:
            out.append((str(a), url, pagina))
        if len(out) == CONVOCATORIAS:
            break
    return out


def fusionar(anterior, convocatoria, url, docs, hoy):
    """Convocatoria con la fecha en que se vio cada documento por primera vez.
    La primera vez que se lee una oposición no se sabe cuándo salió lo que ya
    había (desde = None): solo es novedad lo que aparezca después."""
    antes = {d['id']: d.get('desde') for p in anterior.get('procesos', []) if p['convocatoria'] == convocatoria for d in p['documentos']}
    if not anterior:
        hoy = None
    return {
        'convocatoria': convocatoria,
        'url': url,
        'documentos': [{**d, 'desde': antes.get(d['id'], hoy)} for d in docs],
    }


def main():
    ap = argparse.ArgumentParser(description=__doc__.split('\n')[0])
    ap.add_argument('--html', action='append', default=[], help='op=fichero.html: lee esa página en vez del portal (pruebas)')
    ap.add_argument('--salida', default=str(SALIDA))
    args = ap.parse_args()

    salida = Path(args.salida)
    anterior = json.loads(salida.read_text(encoding='utf-8')) if salida.exists() else {}
    hoy = datetime.now(timezone.utc).date().isoformat()
    locales = dict(x.split('=', 1) for x in args.html)
    ctx = contexto_tls()
    nuevo = {}
    for op, cuerpo in OPOSICIONES.items():
        previo = anterior.get(op, {})
        try:
            if locales:
                if op not in locales:
                    continue
                m = re.search(r'OEP(\d{4})', locales[op])
                paginas = [(m.group(1) if m else '0', PAGINA.format(anio=m.group(1) if m else 0, cuerpo=cuerpo), Path(locales[op]).read_text(encoding='utf-8', errors='replace'))]
            else:
                paginas = leer_oposicion(cuerpo, ctx, datetime.now().year)
        except ConnectionError as e:
            print(f'{op}: sin respuesta ({e}); se conserva lo anterior', file=sys.stderr)
            if previo:
                nuevo[op] = previo
            continue
        procesos = [fusionar(previo, a, url, documentos(p), hoy) for a, url, p in paginas]
        procesos = [p for p in procesos if p['documentos']]
        if not procesos:
            if previo:
                nuevo[op] = previo
            continue
        nuevo[op] = {'procesos': procesos}
        print(f'{op}: ' + ', '.join(f"{p['convocatoria']} ({len(p['documentos'])} documentos)" for p in procesos))

    # Solo cambia la fecha si cambia algo, para no hacer commits vacíos.
    cuerpo_nuevo = {k: v for k, v in nuevo.items()}
    cuerpo_viejo = {k: v for k, v in anterior.items() if k != 'actualizado'}
    if cuerpo_nuevo == cuerpo_viejo:
        print('Sin cambios')
        return
    salida.write_text(json.dumps({'actualizado': datetime.now(timezone.utc).isoformat(timespec='seconds'), **cuerpo_nuevo}, ensure_ascii=False, indent=1) + '\n', encoding='utf-8')
    print(f'Actualizado {salida}')


if __name__ == '__main__':
    main()
