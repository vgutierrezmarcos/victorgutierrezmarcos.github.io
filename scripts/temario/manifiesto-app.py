#!/usr/bin/env python3
"""
Manifiesto del temario revisado para la app (rama revision-temario).

    python3 scripts/temario/manifiesto-app.py            # escribe el manifiesto
    python3 scripts/temario/manifiesto-app.py --comprobar  # solo dice si está al día

La app «Oposición TCEE» lee oposicion/temario/app/revisados.json desde
raw.githubusercontent.com (rama revision-temario) y, con sesión iniciada,
ofrece la versión revisada de cada tema que lista. La web pública no enlaza
nada de esto: es contenido exclusivo de la app.

Solo entran los temas que Víctor ha aprobado (`aprobado.tema` en
oposicion/temario/fuentes/<T>/estado.json) y, de cada uno, la ficha de repaso
solo si también está aprobada (`aprobado.repaso`).

Todo sale de lo que ya está **confirmado en git** (HEAD), no de la carpeta de
trabajo: así el manifiesto describe exactamente lo que hay en GitHub tras el
push. Por eso hay que ejecutarlo **después** del commit del tema o de la ficha
(y hacer luego su propio commit). Si algún fichero del tema tiene cambios sin
confirmar, avisa: esos cambios no entran.

Por cada tema: código, título, fecha de aprobación, versión (hash corto del
último commit que tocó sus ficheros) y, de cada fichero (pdf, docx, html,
repaso), la ruta relativa a la raíz del repositorio, su tamaño y el hash corto
de su contenido (la app lo usa para saber si la copia descargada sigue
valiendo). Además, el esquema del PDF: sus marcadores como [nivel, título,
página] (hasta el nivel 3), que la app enseña al lado del tema (hace falta
pypdf; sin él, el manifiesto sale sin esquemas y avisa). Arriba, el commit de HEAD y las bases de descarga fijadas a ese
commit: raw.githubusercontent.com para los ficheros y githack para los
gráficos y estilos del HTML (raw los sirve como text/plain y el navegador no
los usaría; jsDelivr no sirve este repositorio, da 503).

Autor: Víctor Gutiérrez Marcos
"""
import io
import json
import os
import re
import subprocess
import sys
from datetime import datetime

try:
    from pypdf import PdfReader
except ImportError:  # sin pypdf el manifiesto sale sin esquemas
    PdfReader = None

# Hasta qué nivel de marcador entra en el esquema (0 = capítulos).
NIVEL_MAX = 3

RAIZ = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
REPO = 'vgutierrezmarcos/victorgutierrezmarcos.github.io'
RAMA = 'revision-temario'
FUENTES = 'oposicion/temario/fuentes'
SALIDA = 'oposicion/temario/app/revisados.json'
EJERCICIOS = {'3': 'tercer-ejercicio', '4': 'cuarto-ejercicio'}


def git(*args, binario=False):
    r = subprocess.run(['git', '-C', RAIZ, *args], capture_output=True, check=True)
    return r.stdout if binario else r.stdout.decode('utf-8').rstrip()


def en_head(ruta):
    """(hash del contenido, tamaño) del fichero en HEAD, o None si no está."""
    try:
        linea = git('ls-tree', '-l', 'HEAD', '--', ruta)
    except subprocess.CalledProcessError:
        return None
    if not linea:
        return None
    meta = linea.split('\t')[0].split()
    return meta[2][:10], int(meta[3])


def leer_json_head(ruta):
    try:
        return json.loads(git('show', f'HEAD:{ruta}', binario=True).decode('utf-8'))
    except (subprocess.CalledProcessError, ValueError):
        return None


def titulos():
    datos = leer_json_head('oposicion/temario/temario.json') or {}
    return {t.get('codigo'): t.get('titulo', '')
            for ej in datos.get('ejercicios', [])
            for p in ej.get('partes', [])
            for t in p.get('temas', [])}


def codigo_de(archivo):
    """3A08 → 3.A.8"""
    return f'{archivo[0]}.{archivo[1]}.{int(archivo[2:])}'


def esquema_de(ruta):
    """Los marcadores del PDF en HEAD, como [nivel, título, página]; [] si no hay o no se puede."""
    if PdfReader is None:
        return []
    try:
        lector = PdfReader(io.BytesIO(git('show', f'HEAD:{ruta}', binario=True)))
    except Exception:
        return []
    salida = []

    def recorrer(elementos, nivel):
        for e in elementos:
            if isinstance(e, list):
                recorrer(e, nivel + 1)
                continue
            if nivel > NIVEL_MAX:
                continue
            try:
                pagina = lector.get_destination_page_number(e) + 1
            except Exception:
                continue
            titulo = re.sub(r'\s+', ' ', str(e.title or '')).strip()
            if titulo:
                salida.append([nivel, titulo, pagina])

    try:
        recorrer(lector.outline, 0)
    except Exception:
        return []
    return salida


def manifiesto():
    commit = git('rev-parse', 'HEAD')
    nombres = titulos()
    carpetas = sorted(
        l.split('/')[-2] for l in git('ls-tree', '-r', '--name-only', 'HEAD', '--', FUENTES).splitlines()
        if l.endswith('/estado.json') and not l.split('/')[-2].startswith('_'))
    temas, avisos = [], []
    for archivo in carpetas:
        estado = leer_json_head(f'{FUENTES}/{archivo}/estado.json') or {}
        aprobado = estado.get('aprobado') or {}
        if not aprobado.get('tema') or archivo[0] not in EJERCICIOS:
            continue
        carpeta = f'oposicion/temario/{EJERCICIOS[archivo[0]]}'
        rutas = {
            'pdf': f'{carpeta}/{archivo}.pdf',
            'docx': f'{carpeta}/{archivo}.docx',
            'html': f'{carpeta}/{archivo}.html',
        }
        if aprobado.get('repaso'):
            rutas['repaso'] = f'{carpeta}/{archivo}-repaso.pdf'
        ficheros = {}
        for clave, ruta in rutas.items():
            info = en_head(ruta)
            if info is None:
                avisos.append(f'{archivo}: falta {ruta} en HEAD')
                continue
            sha, tamano = info
            ficheros[clave] = {'ruta': ruta, 'tamano': tamano, 'sha': sha}
        if 'html' in ficheros:
            # Los gráficos del HTML se cargan desde jsDelivr fijado al commit:
            # si cambian sin que cambie el HTML, el manifiesto debe cambiar.
            try:
                ficheros['html']['graficos'] = git('rev-parse', f'HEAD:{FUENTES}/{archivo}/graficos')[:10]
            except subprocess.CalledProcessError:
                pass
        if 'pdf' not in ficheros:
            avisos.append(f'{archivo}: sin PDF en HEAD, no entra')
            continue
        sucios = git('status', '--porcelain', '--', *[f['ruta'] for f in ficheros.values()])
        if sucios:
            avisos.append(f'{archivo}: hay cambios sin confirmar (no entran hasta que se confirmen y se regenere):\n'
                          + '\n'.join('    ' + l for l in sucios.splitlines()))
        codigo = codigo_de(archivo)
        version, fecha = git('log', '-1', '--format=%h %cs', 'HEAD', '--', *[f['ruta'] for f in ficheros.values()]).split()
        tema = {
            'codigo': codigo,
            'archivo': archivo,
            'titulo': nombres.get(codigo, ''),
            'aprobado': aprobado['tema'],
            'version': version,
            'fecha': fecha,
            **ficheros,
        }
        if 'repaso' in ficheros:
            tema['repasoAprobado'] = aprobado['repaso']
        esquema = esquema_de(ficheros['pdf']['ruta'])
        if esquema:
            tema['esquema'] = esquema
        elif PdfReader is None:
            avisos.append(f'{archivo}: sin pypdf no se saca el esquema del PDF')
        temas.append(tema)
    datos = {
        'descripcion': 'Temas revisados para la app Oposición TCEE (exclusivos de la app). '
                       'Generado por scripts/temario/manifiesto-app.py: no editar a mano.',
        'rama': RAMA,
        'commit': commit,
        'raw': f'https://raw.githubusercontent.com/{REPO}/{commit}/',
        # githack y no jsDelivr: jsDelivr devuelve 503 con este repositorio (es
        # muy grande) y el HTML llegaba a la app sin estilos ni gráficos.
        'cdn': f'https://rawcdn.githack.com/{REPO}/{commit}/',
        'temas': temas,
    }
    return datos, avisos


def sin_commit(d):
    """El manifiesto sin lo que cambia en cada commit (para comparar)."""
    return {**d, 'commit': '', 'raw': '', 'cdn': '', 'generado': '',
            'temas': d.get('temas', [])}


def main():
    comprobar = '--comprobar' in sys.argv
    datos, avisos = manifiesto()
    for a in avisos:
        print('Aviso:', a, file=sys.stderr)
    destino = os.path.join(RAIZ, SALIDA)
    anterior = None
    if os.path.exists(destino):
        with open(destino, encoding='utf-8') as f:
            anterior = json.load(f)
    al_dia = anterior is not None and sin_commit(anterior) == sin_commit({**datos, 'generado': ''})
    if comprobar:
        print('El manifiesto está al día.' if al_dia else 'El manifiesto NO está al día: ejecuta scripts/temario/manifiesto-app.py.')
        sys.exit(0 if al_dia else 1)
    if al_dia:
        print(f'Sin cambios en {SALIDA} ({len(datos["temas"])} temas).')
        return
    datos = {'generado': datetime.now().strftime('%Y-%m-%dT%H:%M'), **datos}
    os.makedirs(os.path.dirname(destino), exist_ok=True)
    with open(destino, 'w', encoding='utf-8', newline='\n') as f:
        json.dump(datos, f, ensure_ascii=False, indent=1)
        f.write('\n')
    print(f'{SALIDA}: {len(datos["temas"])} temas revisados '
          f'({", ".join(t["codigo"] for t in datos["temas"]) or "ninguno"}).')


if __name__ == '__main__':
    main()
