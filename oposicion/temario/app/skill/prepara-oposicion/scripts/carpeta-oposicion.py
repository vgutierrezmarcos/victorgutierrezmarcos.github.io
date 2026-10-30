#!/usr/bin/env python3
"""
Crea en el ordenador del opositor la carpeta de la oposición, ordenada por
ejercicios, y la llena con los materiales públicos de la web (temas en PDF y
Word, organización, exámenes oficiales, guía antigua del dictamen). Los
materiales exclusivos (temas revisados, fichas, guía 1D01) no se descargan:
se consultan en la app y en esta skill.

    python3 carpeta-oposicion.py "C:/Users/yo/Documents/Oposición TCEE" [--oposicion tcee|dce] [--solo-carpetas] [--sin-word]

Estructura (los códigos de tema van en los nombres, que es lo que usan la app y la skill):

    0_organizacion/            programa, convocatoria, Excel de estrategia, exportación de la app, cronograma
    1_primer_ejercicio/1_test/           exámenes oficiales de test, plantillas, tus resultados
    1_primer_ejercicio/2_dictamen/       esquema del dictamen, exámenes oficiales; simulacros/ con tus dictámenes e informes
    2_segundo_ejercicio/       idiomas
    3_tercer_ejercicio/A/3A08/ 3A08.pdf, 3A08.docx, mis apuntes y la carpeta cantes/ (transcripciones e informes)
    3_tercer_ejercicio/B/…     4_cuarto_ejercicio/A|B/…   5_quinto_ejercicio/A|B|C/…

Solo biblioteca estándar. Con --base se puede apuntar a otra web (DCE) o a una
copia local de la web para probar.
"""
import argparse
import json
import os
import re
import sys
import urllib.request
from urllib.parse import urlparse

WEBS = {
    'tcee': 'https://www.victorgutierrezmarcos.es/',
    'dce': 'https://manuelcabadogarcia.es/',
}
EJERCICIOS = {1: '1_primer_ejercicio', 2: '2_segundo_ejercicio', 3: '3_tercer_ejercicio', 4: '4_cuarto_ejercicio', 5: '5_quinto_ejercicio'}
LEEME = """# {titulo}

Carpeta creada por la skill «EconomIA» el {fecha}. Los códigos de tema ({ejemplo}) van en los nombres de carpeta y de fichero: así la app y Claude encuentran cada cosa.

- `0_organizacion/`: programa oficial, convocatoria, Excel de estrategia, la exportación de la app para Claude (`oposicion_{op}_para_claude.json`) y el cronograma acordado (`cronograma.txt`).
- `1_primer_ejercicio/1_test/`: exámenes oficiales de test y plantillas; guarda aquí tus simulacros.
- `1_primer_ejercicio/2_dictamen/`: esquema del dictamen y exámenes oficiales; en `simulacros/`, tus dictámenes (foto o PDF) con sus informes.
- `3_tercer_ejercicio/A/3A08/` (y así cada tema): el tema de la web en PDF y Word, tus apuntes y, en `cantes/`, las transcripciones de la app y los informes de Claude (`2026-11-03.txt`, `2026-11-03-informe.pdf`).
- Los materiales exclusivos (temas revisados, fichas de repaso, guía del dictamen 1D01) no se descargan: están en la app y dentro de la skill.

Pídele a Claude, desde esta carpeta: «corrige el cante de hoy del 3A08 y guarda el informe en su carpeta», «replanifica con 0_organizacion/oposicion_{op}_para_claude.json» o «compara mis apuntes del 3A08 con la ficha del tema».
"""


def descargar(url, destino, sin_word):
    if sin_word and destino.lower().endswith('.docx'):
        return 'omitido'
    if os.path.exists(destino) and os.path.getsize(destino) > 0:
        return 'ya estaba'
    os.makedirs(os.path.dirname(destino), exist_ok=True)
    try:
        if url.startswith('file:') or os.path.exists(url):
            import shutil
            shutil.copy(url[7:] if url.startswith('file://') else url, destino)
        else:
            req = urllib.request.Request(url, headers={'User-Agent': 'prepara-oposicion (skill EconomIA)'})
            with urllib.request.urlopen(req, timeout=60) as r, open(destino, 'wb') as f:
                f.write(r.read())
        return 'descargado'
    except Exception as e:  # noqa: BLE001
        return f'ERROR {e}'


def leer_json(base, ruta):
    url = base + ruta
    if base.startswith('http'):
        req = urllib.request.Request(url, headers={'User-Agent': 'prepara-oposicion'})
        with urllib.request.urlopen(req, timeout=60) as r:
            return json.load(r)
    with open(os.path.join(base, ruta), encoding='utf-8') as f:
        return json.load(f)


def local(base, url):
    """Con una base local, convierte la URL pública en la ruta del fichero."""
    if base.startswith('http'):
        return url
    return os.path.join(base, urlparse(url).path.lstrip('/'))


def main():
    p = argparse.ArgumentParser(description='Carpeta de la oposición con los materiales públicos de la web')
    p.add_argument('destino')
    p.add_argument('--oposicion', choices=['tcee', 'dce'], default='tcee')
    p.add_argument('--base', help='web de la que bajar (por defecto, la de la oposición) o carpeta local con la misma estructura')
    p.add_argument('--solo-carpetas', action='store_true', help='crea la estructura sin descargar nada')
    p.add_argument('--sin-word', action='store_true', help='no descarga los .docx')
    a = p.parse_args()
    base = a.base or WEBS[a.oposicion]
    if not base.startswith('http') and not base.endswith(os.sep):
        base += os.sep
    raiz = os.path.abspath(a.destino)
    os.makedirs(raiz, exist_ok=True)
    resumen = {'descargado': 0, 'ya estaba': 0, 'omitido': 0, 'errores': []}

    def baja(url, destino):
        if a.solo_carpetas or not url:
            return
        r = descargar(local(base, url), destino, a.sin_word)
        if r.startswith('ERROR'):
            resumen['errores'].append(f'{os.path.relpath(destino, raiz)}: {r}')
        else:
            resumen[r] += 1

    # Carpetas fijas
    for d in ['0_organizacion', '1_primer_ejercicio/1_test', '1_primer_ejercicio/2_dictamen/simulacros', '2_segundo_ejercicio']:
        os.makedirs(os.path.join(raiz, d), exist_ok=True)

    try:
        temario = leer_json(base, 'oposicion/temario/temario.json')
    except Exception as e:  # noqa: BLE001
        print(f'Aviso: no he podido leer el programa de la web ({e}); creo solo las carpetas de los ejercicios.')
        temario = {'ejercicios': [{'id': k, 'partes': [{'letra': l, 'temas': []} for l in ('A', 'B')]} for k in (3, 4, 5)]}
    ejemplo = '3A08'
    for e in temario.get('ejercicios', []):
        carpeta = EJERCICIOS.get(e.get('id'), f"{e.get('id')}_{e.get('slug', '')}")
        for parte in e.get('partes', []):
            letra = parte.get('letra', '')
            for t in parte.get('temas', []):
                codigo = t.get('codigo', '')  # 3.A.8
                corto = codigo.replace('.', '')  # 3A8
                m = re.match(r'(\d)([A-Z])(\d+)', corto)
                nombre = f'{m.group(1)}{m.group(2)}{int(m.group(3)):02d}' if m else corto  # 3A08
                carpeta_tema = os.path.join(raiz, carpeta, letra, nombre)
                os.makedirs(os.path.join(carpeta_tema, 'cantes') if e.get('id') in (3, 4) else carpeta_tema, exist_ok=True)
                if t.get('url'):
                    baja(t['url'], os.path.join(carpeta_tema, os.path.basename(urlparse(t['url']).path)))
                if t.get('urlDocx'):
                    baja(t['urlDocx'], os.path.join(carpeta_tema, os.path.basename(urlparse(t['urlDocx']).path)))
        # Recursos del ejercicio (exámenes oficiales, esquema del dictamen, plantillas)
        for r in e.get('recursos', []) or []:
            if r.get('tipo') in ('pdf', 'docx', 'xlsx', 'xlsm'):
                sub = '2_dictamen' if 'dictamen' in r.get('id', '') else ('1_test' if e.get('id') == 1 else '')
                destino = os.path.join(raiz, carpeta, sub, os.path.basename(urlparse(r['url']).path)) if sub else os.path.join(raiz, carpeta, os.path.basename(urlparse(r['url']).path))
                baja(r['url'], destino)
    for o in temario.get('organizacion', []) or []:
        if o.get('tipo') in ('pdf', 'docx', 'xlsx', 'xlsm', 'dotx'):
            baja(o['url'], os.path.join(raiz, '0_organizacion', os.path.basename(urlparse(o['url']).path)))

    from datetime import date
    titulo = 'Oposición a Técnico Comercial y Economista del Estado (TCEE)' if a.oposicion == 'tcee' else 'Oposición a Diplomado Comercial del Estado (DCE)'
    with open(os.path.join(raiz, 'LEEME.md'), 'w', encoding='utf-8') as f:
        f.write(LEEME.format(titulo=titulo, fecha=date.today().strftime('%d/%m/%Y'), ejemplo=ejemplo, op=a.oposicion))
    carpetas = sum(len(d) for _, d, _ in os.walk(raiz))
    print(f'Carpeta: {raiz}\n{carpetas} carpetas; descargados {resumen["descargado"]}, ya estaban {resumen["ya estaba"]}, omitidos {resumen["omitido"]}, errores {len(resumen["errores"])}')
    for e in resumen['errores'][:20]:
        print('  ' + e)
    if resumen['errores']:
        sys.exit(1)


if __name__ == '__main__':
    main()
