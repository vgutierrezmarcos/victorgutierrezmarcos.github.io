#!/usr/bin/env python3
"""
Prepara los temas de otros preparadores que sirven de referencia para revisar
un tema (scripts/temario/referencias.json).

    python3 scripts/temario/indexar-referencias.py --indexar      # lista las carpetas de Drive
    python3 scripts/temario/indexar-referencias.py 3A08           # baja lo de ese tema

Todo se guarda en ~/.cache/apuntes-tcee/ (fuera de git: son materiales de
otros autores, que se contrastan y se citan pero no se copian):

  indice.json                  qué fichero de cada autor corresponde a cada tema
  <autor>/<fichero original>   los ficheros bajados
  <autor>/<tema>.md            su texto, para que lo lean los agentes

Con un código de tema, además, escribe fuentes/<tema>/_trabajo/referencias.md
con la lista de textos disponibles para ese tema.

Autor: Víctor Gutiérrez Marcos
"""
import argparse
import html
import json
import os
import re
import sys
import urllib.request

import fitz  # PyMuPDF

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from comun import Tema, PANDOC, ejecutar, ruta_windows  # noqa: E402

CACHE = os.path.expanduser(os.environ.get('TCEE_REFERENCIAS', '~/.cache/apuntes-tcee'))
CONFIG = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'referencias.json')
INDICE = os.path.join(CACHE, 'indice.json')
EXTENSIONES = ('.docx', '.pdf', '.doc')
VACIAS = set('de del la las el los y en a o u e con por para su sus al lo un una sobre'.split())


def codigo_de_ruta(ruta):
    """Código de tema (3A08) a partir de la ruta de un fichero de Drive, o None."""
    nombre = os.path.basename(ruta)
    m = re.search(r'(?<![\w.])([34])\.?\s?([AB])[._]?\s?(\d{1,2})(?!\d)', nombre)
    if m:
        return f'{m.group(1)}{m.group(2)}{int(m.group(3)):02d}'
    partes = ruta.replace('\\', '/').split('/')
    ejercicio = None
    for p in partes[:-1]:
        m = re.match(r'^\s*([34])(?:o|º|\.º|er|[AB]|\s|$)', p, re.I) or \
            re.search(r'(tercer|cuarto)', p, re.I)
        if m:
            g = m.group(1).lower()
            ejercicio = {'tercer': '3', 'cuarto': '4'}.get(g, g)
    if not ejercicio:
        return None
    for texto in (nombre, *partes[::-1][1:]):
        for patron in (r'(?<![\w])([AB])\.\s?(\d{1,2})(?!\d)', r'Tema\s*(\d{1,2})\s*\.?\s*([AB])\b',
                       r'(?<![\w.])(\d{1,2})\s?([AB])(?![\w])'):
            m = re.search(patron, texto, re.I)
            if m:
                a, b = m.groups()
                letra, num = (a, b) if a.isalpha() else (b, a)
                return f'{ejercicio}{letra.upper()}{int(num):02d}'
    return None


def indexar():
    import gdown
    config = json.load(open(CONFIG, encoding='utf-8'))
    indice = {'autores': {}}
    for autor in config['autores']:
        clave = autor['clave']
        entrada = {'nombre': autor['nombre'], 'temas': {}, 'sin_tema': [], 'error': None}
        try:
            if autor['tipo'] == 'drive':
                # Una carpeta (id) o varias (carpetas: {ejercicio: id}); las que no
                # son públicas se anotan y se sigue con las demás
                carpetas = autor.get('carpetas') or {'': autor['id']}
                lista, fallos = [], []
                for etiqueta, fid in carpetas.items():
                    try:
                        ficheros = gdown.download_folder(id=fid, skip_download=True, quiet=True)
                        lista += [(os.path.join(etiqueta, f.path), f.id) for f in ficheros]
                    except Exception as e:
                        fallos.append(f'{etiqueta or fid}: {type(e).__name__}')
                if fallos:
                    entrada['error'] = 'sin acceso a ' + ', '.join(fallos)
            elif autor['tipo'] == 'carpeta':
                base = os.path.expanduser(autor['ruta'])
                lista = [(os.path.relpath(os.path.join(d, f), base), None)
                         for d, _, fs in os.walk(base) for f in fs]
            else:
                entrada['error'] = autor.get('nota', 'sin origen')
                lista = []
        except Exception as e:  # carpeta privada, cuota de Drive…
            entrada['error'] = f'{type(e).__name__}: {str(e)[:200]}'
            lista = []
        entrada['todos'] = []
        for ruta, fid in lista:
            if os.path.basename(ruta).startswith('~$') or not ruta.lower().endswith(EXTENSIONES):
                continue
            entrada['todos'].append({'ruta': ruta, 'id': fid})
            cod = codigo_de_ruta(ruta)
            if cod:
                entrada['temas'].setdefault(cod, []).append({'ruta': ruta, 'id': fid})
            else:
                entrada['sin_tema'].append(ruta)
        indice['autores'][clave] = entrada
        print(f'{autor["nombre"]}: {len(entrada["temas"])} temas'
              + (f' — {entrada["error"]}' if entrada['error'] else ''))
    for web in config.get('web', []):
        try:
            with urllib.request.urlopen(web['indice'], timeout=60) as r:
                datos = json.load(r)
            temas = [{'codigo': t['codigo'], 'titulo': t['titulo'], 'url': t['url']}
                     for e in datos['ejercicios'] for p in e['partes'] for t in p['temas'] if t.get('url')]
            indice.setdefault('web', {})[web['clave']] = {'nombre': web['nombre'], 'temas': temas}
            print(f'{web["nombre"]}: {len(temas)} temas publicados')
        except Exception as e:
            print(f'{web["nombre"]}: no se pudo leer el índice ({e})')
    os.makedirs(CACHE, exist_ok=True)
    with open(INDICE, 'w', encoding='utf-8') as f:
        json.dump(indice, f, ensure_ascii=False, indent=2)


def a_texto(ruta):
    """Texto de un .docx o .pdf (Markdown para Word, texto plano para PDF)."""
    if ruta.lower().endswith('.pdf'):
        doc = fitz.open(ruta)
        return '\n\n'.join(f'<!-- página {i + 1} -->\n' + p.get_text() for i, p in enumerate(doc))
    if ruta.lower().endswith('.docx'):
        _, salida = ejecutar([PANDOC, ruta_windows(ruta), '-f', 'docx', '-t', 'markdown-smart',
                              '--wrap=none'], timeout=300)
        return re.sub(r'!\[[^\]]*\]\([^)]*\)(\{[^}]*\})?', '[imagen]', salida)
    return ''


def palabras(texto):
    return {w for w in re.findall(r'[a-záéíóúñü]{4,}', texto.lower()) if w not in VACIAS}


def html_a_texto(contenido):
    cuerpo = re.search(r'<main[^>]*>(.*)</main>', contenido, re.S)
    t = cuerpo.group(1) if cuerpo else contenido
    t = re.sub(r'<(script|style)[^>]*>.*?</\1>', '', t, flags=re.S)
    t = re.sub(r'<(h[1-6])[^>]*>', lambda m: '\n\n' + '#' * int(m.group(1)[1]) + ' ', t)
    t = re.sub(r'<(p|li|div|br|tr)[^>]*>', '\n', t)
    t = re.sub(r'<[^>]+>', '', t)
    return re.sub(r'\n{3,}', '\n\n', html.unescape(t)).strip()


def preparar_tema(tema):
    import gdown
    if not os.path.exists(INDICE):
        indexar()
    indice = json.load(open(INDICE, encoding='utf-8'))
    lineas = [f'# Referencias para el tema {tema.codigo}', '',
              'Temas de otros preparadores (en ~/.cache/apuntes-tcee/, fuera de git). Se usan para '
              'contrastar y completar; si se toma una idea concreta, se cita al autor. No se copian.', '']
    objetivo = palabras(tema.titulo())
    notas = {a['clave']: a.get('nota', '') for a in json.load(open(CONFIG, encoding='utf-8'))['autores']}
    for clave, autor in indice['autores'].items():
        if 'ANTERIOR' in notas.get(clave, ''):
            lineas.append(f'- *{autor["nombre"]} usa la numeración del temario anterior: {notas[clave]} '
                          'Los ficheros elegidos por el número pueden ser de otro tema.*')
        ficheros = list(autor['temas'].get(tema.archivo, []))
        # Muchos usan la numeración del temario anterior: se añade el fichero
        # cuyo nombre más se parece al título (si comparte al menos 3 palabras)
        por_titulo = sorted(autor.get('todos', []),
                            key=lambda f: -len(objetivo & palabras(os.path.basename(f['ruta']))))
        if por_titulo and len(objetivo & palabras(os.path.basename(por_titulo[0]['ruta']))) >= 3 \
                and por_titulo[0]['ruta'] not in {f['ruta'] for f in ficheros}:
            ficheros.append({**por_titulo[0], 'por_titulo': True})
        if not ficheros:
            lineas.append(f'- **{autor["nombre"]}**: no hay tema {tema.codigo}'
                          + (f' ({autor["error"]})' if autor.get('error') else '') + '.')
            continue
        carpeta = os.path.join(CACHE, clave)
        os.makedirs(carpeta, exist_ok=True)
        for f in ficheros:
            destino = os.path.join(carpeta, os.path.basename(f['ruta']))
            if not os.path.exists(destino) and f.get('id'):
                gdown.download(id=f['id'], output=destino, quiet=True)
            if not os.path.exists(destino):
                lineas.append(f'- **{autor["nombre"]}**: no se pudo bajar {f["ruta"]}.')
                continue
            md = os.path.join(carpeta, f'{tema.archivo}-{os.path.splitext(os.path.basename(destino))[0][:40]}.md')
            if not os.path.exists(md):
                with open(md, 'w', encoding='utf-8') as s:
                    s.write(a_texto(destino))
            lineas.append(f'- **{autor["nombre"]}**: `{md}` (original: {f["ruta"]}'
                          + ('; elegido por el título: comprobar que es el mismo tema' if f.get('por_titulo') else '') + ')')
    for clave, web in indice.get('web', {}).items():
        candidatos = sorted(web['temas'], key=lambda t: -len(objetivo & palabras(t['titulo'])))
        elegidos = [t for t in candidatos[:3] if len(objetivo & palabras(t['titulo'])) >= 3]
        if not elegidos:
            lineas.append(f'- **{web["nombre"]}**: ningún tema parecido.')
        carpeta = os.path.join(CACHE, clave)
        os.makedirs(carpeta, exist_ok=True)
        for t in elegidos:
            md = os.path.join(carpeta, f'{t["codigo"]}.md')
            if not os.path.exists(md):
                with urllib.request.urlopen(t['url'], timeout=60) as r:
                    texto = html_a_texto(r.read().decode('utf-8', errors='replace'))
                with open(md, 'w', encoding='utf-8') as s:
                    s.write(f'<!-- {t["url"]} -->\n\n{texto}')
            lineas.append(f'- **{web["nombre"]}**, tema DCE {t["codigo"]} «{t["titulo"][:90]}»: `{md}` ({t["url"]})')
    os.makedirs(tema.trabajo, exist_ok=True)
    with open(os.path.join(tema.trabajo, 'referencias.md'), 'w', encoding='utf-8') as f:
        f.write('\n'.join(lineas) + '\n')
    print('\n'.join(lineas))


def main():
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument('tema', nargs='?')
    ap.add_argument('--indexar', action='store_true', help='vuelve a listar las carpetas de Drive')
    args = ap.parse_args()
    if args.indexar:
        indexar()
    if args.tema:
        preparar_tema(Tema(args.tema))
    if not args.indexar and not args.tema:
        ap.print_help()


if __name__ == '__main__':
    main()
