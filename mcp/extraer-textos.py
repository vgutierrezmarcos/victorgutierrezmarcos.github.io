#!/usr/bin/env python3
"""
Saca el texto de las fuentes que el Worker del conector no puede leer por sí mismo y
lo deja listo para subirlo a su KV CONTENIDO, agrupado por tema (una escritura por
tema: el plan gratuito de Cloudflare permite 1.000 escrituras al día):

  - los PDF del temario de victorgutierrezmarcos.es (oposicion/temario/…), con PyMuPDF;
  - los apuntes de otros TCEE del repositorio de la ATCEE que no son .docx ni
    Documentos de Google (PDF, .doc antiguos y .pptx): se descargan uno a uno de
    Drive, se extrae el texto y se borra el fichero.

Los .docx y Documentos de Google los lee el Worker en directo (src/drive.ts), y las
páginas de manuelcabadogarcia.es también (con el visto bueno de Manuel).

    python3 mcp/extraer-textos.py            # extrae (reanudable; necesita pymupdf y olefile)
    python3 mcp/extraer-textos.py --subir    # y sube a KV (wrangler)
    … --solo-web                                                                       # solo los PDF de la web

Los textos quedan en ~/.cache/apuntes-tcee/textos/ (fuera de git). Las descargas van
por el curl de Windows (la red del Ministerio intercepta TLS y WSL no las acepta).
Para subir hace falta CLOUDFLARE_API_TOKEN (~/.config/oposicion-red/cloudflare.token).

Autor: Víctor Gutiérrez Marcos
"""
import argparse
import json
import os
import re
import subprocess
import sys
import tempfile
import zipfile

import pymupdf

RAIZ = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
CACHE = os.path.expanduser('~/.cache/apuntes-tcee/textos')
CURL = '/mnt/c/Windows/System32/curl.exe'
TMP_WIN = r'C:\Users\vgutierrez\AppData\Local\Temp\claude-video\descarga.tmp'
TMP_WSL = '/mnt/c/Users/vgutierrez/AppData/Local/Temp/claude-video/descarga.tmp'
WEB = 'https://www.victorgutierrezmarcos.es/'
LIMITE_TEXTO = 400_000  # caracteres por fichero (un tema largo ronda los 150.000)


def codigo_con_puntos(cod):
    m = re.match(r'^(\d)\.?([A-Z])\.?0*(\d+)$', cod.strip().upper())
    return f'{m.group(1)}.{m.group(2)}.{int(m.group(3))}' if m else cod


def texto_pdf(ruta):
    with pymupdf.open(ruta) as doc:
        partes = [f'[pág. {i + 1}]\n{p.get_text().strip()}' for i, p in enumerate(doc)]
    texto = '\n\n'.join(partes)
    return texto if len(re.sub(r'\[pág\. \d+\]|\s', '', texto)) > 300 else ''


def texto_pptx(ruta):
    with zipfile.ZipFile(ruta) as z:
        nombres = sorted((n for n in z.namelist() if re.match(r'ppt/slides/slide\d+\.xml$', n)),
                         key=lambda n: int(re.search(r'(\d+)', n.split('/')[-1]).group(1)))
        return '\n\n'.join(' '.join(re.findall(r'<a:t>([^<]*)</a:t>', z.read(n).decode('utf-8', 'ignore'))) for n in nombres)


def texto_doc(ruta):
    """Word 97-2003: sin LibreOffice, el texto se saca del flujo WordDocument (CP1252 o UTF-16)."""
    import olefile
    with olefile.OleFileIO(ruta) as ole:
        datos = ole.openstream('WordDocument').read()
    candidatos = []
    for cod in ('utf-16-le', 'cp1252'):
        t = datos.decode(cod, 'ignore')
        trozos = re.findall(r'[\w\sÁÉÍÓÚÜÑáéíóúüñ.,;:()¿?¡!«»"\'%€/\-–—]{25,}', t)
        candidatos.append('\n'.join(x.strip() for x in trozos if sum(c.isalpha() for c in x) > len(x) * 0.6))
    return max(candidatos, key=len)


def descargar(fid):
    if os.path.exists(TMP_WSL):
        os.remove(TMP_WSL)
    url = f'https://drive.usercontent.google.com/download?id={fid}&export=download&confirm=t'
    r = subprocess.run([CURL, '-sL', '--ssl-no-revoke', '--max-time', '180', '-o', TMP_WIN, url],
                       capture_output=True, timeout=240, cwd='/mnt/c/Users/vgutierrez')
    return r.returncode == 0 and os.path.exists(TMP_WSL) and os.path.getsize(TMP_WSL) > 0


def extraer_drive(f):
    """Texto de un fichero de Drive (PDF, .doc o .pptx), o '' si no se puede."""
    if not descargar(f['id']):
        return None
    with open(TMP_WSL, 'rb') as fh:
        cabeza = fh.read(8)
    try:
        if cabeza.startswith(b'%PDF'):
            return texto_pdf(TMP_WSL)
        if cabeza.startswith(b'\xd0\xcf\x11\xe0'):
            return texto_doc(TMP_WSL)
        if cabeza.startswith(b'PK'):
            return texto_pptx(TMP_WSL)
        return None  # una página HTML: no es público o Drive pide confirmación
    except Exception as e:
        print('   error al leer', f['nombre'], type(e).__name__, file=sys.stderr)
        return ''
    finally:
        if os.path.exists(TMP_WSL):
            os.remove(TMP_WSL)


def main():
    p = argparse.ArgumentParser()
    p.add_argument('--subir', action='store_true')
    p.add_argument('--solo-web', action='store_true')
    a = p.parse_args()
    os.makedirs(CACHE, exist_ok=True)
    paquetes = {}  # tema → {'web': {...}, 'atcee': {id: {...}}}

    # 1. PDF del temario de la web
    temario = json.load(open(os.path.join(RAIZ, 'oposicion/temario/temario.json'), encoding='utf-8'))
    n_web = 0
    for ej in temario['ejercicios']:
        for parte in ej.get('partes', []):
            for t in parte['temas']:
                if not t.get('url') or not t['url'].lower().endswith('.pdf'):
                    continue
                local = os.path.join(RAIZ, t['url'].replace(WEB, ''))
                if not os.path.exists(local):
                    continue
                texto = texto_pdf(local)
                paquetes.setdefault(t['codigo'], {})['web'] = {'url': t['url'], 'texto': texto[:LIMITE_TEXTO]}
                n_web += 1
    print(f'{n_web} PDF de la web leídos')

    # 2. Apuntes de la ATCEE que el Worker no lee en directo
    if not a.solo_web:
        apuntes = json.load(open(os.path.join(RAIZ, 'oposicion/temario/apuntes-otros.json'), encoding='utf-8'))
        pendientes = []
        for prom in apuntes['promociones']:
            for autor in prom.get('autores', []):
                for rec in autor.get('recursos', []):
                    for f in rec.get('ficheros') or []:
                        ext = os.path.splitext(f['nombre'])[1].lower()
                        if f.get('tema') and ext in ('.pdf', '.doc', '.pptx'):
                            pendientes.append((codigo_con_puntos(f['tema']), autor['nombre'], f))
        hechos = errores = 0
        for i, (tema, autor, f) in enumerate(pendientes, 1):
            cache = os.path.join(CACHE, f['id'] + '.txt')
            if not os.path.exists(cache):
                texto = extraer_drive(f)
                if texto is None:
                    errores += 1
                    continue
                with open(cache, 'w', encoding='utf-8') as fh:
                    fh.write(texto)
                hechos += 1
                if hechos % 25 == 0:
                    print(f'  {i}/{len(pendientes)} ({errores} sin descargar)', flush=True)
            texto = open(cache, encoding='utf-8').read()
            paquetes.setdefault(tema, {}).setdefault('atcee', {})[f['id']] = {
                'autor': autor, 'fichero': os.path.basename(f['nombre']),
                'texto': texto[:LIMITE_TEXTO] if texto else '',
                **({} if texto else {'aviso': 'sin texto: probablemente escaneado'})}
        print(f'{len(pendientes)} apuntes de la ATCEE (PDF, .doc, .pptx): {hechos} nuevos, {errores} sin descargar')

    # 3. Fichero para wrangler kv bulk put: una clave por tema
    bulk = [{'key': f'textos/{tema}', 'value': json.dumps(v, ensure_ascii=False)} for tema, v in sorted(paquetes.items())]
    salida = os.path.join(tempfile.gettempdir(), 'textos-kv.json')
    json.dump(bulk, open(salida, 'w', encoding='utf-8'), ensure_ascii=False)
    total = sum(len(b['value']) for b in bulk)
    print(f'{len(bulk)} claves, {total / 1e6:.1f} MB -> {salida}')
    if a.subir:
        token = os.environ.get('CLOUDFLARE_API_TOKEN') or open(os.path.expanduser('~/.config/oposicion-red/cloudflare.token')).read().strip()
        r = subprocess.run(['npx', 'wrangler', 'kv', 'bulk', 'put', salida, '--binding', 'CONTENIDO', '--remote'],
                           cwd=os.path.join(RAIZ, 'mcp', 'worker'), env={**os.environ, 'CLOUDFLARE_API_TOKEN': token})
        sys.exit(r.returncode)


if __name__ == '__main__':
    main()
