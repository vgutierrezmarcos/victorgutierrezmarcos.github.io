#!/usr/bin/env python3
"""Los dos ZIP de «Descargar todos los materiales» (oposicion/index.html).

Víctor (26/11/2026): el ZIP descarga solo lo que tiene que descargar, bien organizado
(por ejercicio y con el título de cada tema), con PDF y Word. Los temas revisados
(exclusivos, con su propia licencia) no van en el ZIP de todos; quien ha iniciado
sesión en la web descarga el otro, que lleva además sus PDF nuevos:

    materiales-tcee.zip                 lo de licencia CC BY-NC-ND 4.0 (los temas
                                        antiguos del 3.º, el 4.º, el 5.º, el 1.º y
                                        organización)
    materiales-tcee-con-revisados.zip   lo mismo, más el PDF y la ficha de repaso de
                                        los temas revisados y de la guía del dictamen
                                        (el antiguo queda al lado como «versión anterior»)

Lee oposicion/temario/temario.json (temas, títulos y recursos) y
oposicion/temario/revisados-web.json (qué temas están revisados y dónde está cada
PDF). Solo mete ficheros del repositorio que existen: nada de HTML, JSON, imágenes,
vídeos, la skill ni las fuentes LaTeX.

    python3 scripts/materiales-zip.py                 # los dos ZIP en salida-zip/
    python3 scripts/materiales-zip.py --salida DIR
    python3 scripts/materiales-zip.py --huella        # solo la huella (para no
                                                      # resubir si nada ha cambiado)
    python3 scripts/materiales-zip.py --lista         # qué entra en cada uno

Lo usa .github/workflows/create-materials-zip.yml.

Autor: Víctor Gutiérrez Marcos
"""
import argparse
import hashlib
import json
import os
import re
import subprocess
import sys
import zipfile
from datetime import date

RAIZ = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
WEB = 'https://www.victorgutierrezmarcos.es/'
CARPETA = 'Materiales TCEE - Víctor Gutiérrez Marcos'
PUBLICO = 'materiales-tcee.zip'
REVISADOS = 'materiales-tcee-con-revisados.zip'
YA_COMPRIMIDOS = ('.pdf', '.docx', '.xlsm', '.ppsx', '.dotx')
NOMBRES_EJERCICIO = {1: '1 Primer ejercicio', 3: '3 Tercer ejercicio',
                     4: '4 Cuarto ejercicio', 5: '5 Quinto ejercicio'}


def ruta_local(url):
    """Ruta en el repositorio de una URL de la web (o None si no es de la web)."""
    if not url or not url.startswith(WEB):
        return None
    return url[len(WEB):]


def existe(ruta):
    return ruta and os.path.isfile(os.path.join(RAIZ, ruta))


def limpio(texto, largo=90):
    """Título apto para nombre de fichero en Windows, macOS y Linux."""
    texto = re.sub(r'[\\/:*?"<>|]', ' ', texto).strip()
    texto = re.sub(r'\s+', ' ', texto).rstrip('.')
    # Primera frase del título si es larga (los epígrafes van separados por puntos)
    if len(texto) > largo and '. ' in texto:
        texto = texto.split('. ')[0]
    if len(texto) > largo:
        texto = texto[:largo].rsplit(' ', 1)[0] + '…'
    return texto


def codigo_ordenable(codigo):
    """3.A.8 -> 3.A.08 (para que el explorador los ordene bien)."""
    ej, parte, num = codigo.split('.')
    return f'{ej}.{parte}.{int(num):02d}'


def materiales():
    """Lista de (ruta en el ZIP, ruta en el repo, solo_con_revisados, revisado)."""
    temario = json.load(open(os.path.join(RAIZ, 'oposicion/temario/temario.json'), encoding='utf-8'))
    rev = json.load(open(os.path.join(RAIZ, 'oposicion/temario/revisados-web.json'), encoding='utf-8'))
    revisados = {('1D01' if t['codigo'] == 'Dictamen' else t['codigo']): t for t in rev['temas']}
    filas = []

    def anade(destino, origen, solo_revisados=False):
        if existe(origen):
            filas.append((f'{CARPETA}/{destino}', origen, solo_revisados))

    # Organización
    for r in temario.get('organizacion', []):
        origen = ruta_local(r.get('url'))
        if not origen:
            continue
        ext = os.path.splitext(origen)[1]
        anade(f'0 Organización/{limpio(r["titulo"])}{ext}', origen)
    anade('0 Organización/Estructura del temario (presentación).ppsx', 'oposicion/organizacion/estructura_temario.ppsx')

    for e in temario['ejercicios']:
        n = e['id']
        if n not in NOMBRES_EJERCICIO:
            continue
        base = NOMBRES_EJERCICIO[n]

        if n == 1:
            for r in e.get('recursos', []):
                origen = ruta_local(r.get('url'))
                if not origen or r.get('tipo') == 'app':
                    continue
                titulo = re.sub(r'\s*\((?:[^)]*MB|Word|PDF)\)', '', r['titulo'])
                sub = 'Test' if '/test/' in origen else 'Dictamen'
                anade(f'{base}/{sub}/{limpio(titulo)}{os.path.splitext(origen)[1]}', origen)
            d = revisados.get('1D01')
            if d:
                anade(f'{base}/Dictamen/Guía para el dictamen (revisada).pdf', d.get('pdf'), True)
                anade(f'{base}/Dictamen/Guía para el dictamen (resumen de repaso).pdf', d.get('repaso'), True)
            continue

        for p in e.get('partes', []):
            letra = p.get('letra') or ''
            carpeta_parte = f'{base}/{n}.{letra} {limpio(p["nombre"], 70)}' if letra else base
            if n == 5:
                origen = ruta_local(p.get('url'))
                anade(f'{carpeta_parte}.pdf', origen)
                continue
            for t in p.get('temas', []):
                codigo = t['codigo']
                if not letra:
                    letra = codigo.split('.')[1]
                    carpeta_parte = f'{base}/{n}.{letra} {limpio(p["nombre"], 70)}'
                nombre = f'{codigo_ordenable(codigo)} {limpio(t["titulo"])}'
                archivo = codigo.replace('.', '')[:2] + f'{int(codigo.split(".")[2]):02d}'
                carpeta_ej = os.path.dirname(ruta_local(t.get('url')) or f'oposicion/temario/{e["slug"]}/x')
                carpeta_ej = carpeta_ej.removesuffix('/anterior')
                r = revisados.get(codigo)
                if r:
                    # Revisado: el antiguo (si lo había) va en los dos ZIP; el nuevo, solo con sesión
                    anterior = r.get('anterior')
                    docx = f'{carpeta_ej}/{archivo}.docx'
                    anade(f'{carpeta_parte}/{nombre}.pdf', anterior)
                    anade(f'{carpeta_parte}/{nombre}.docx', docx)
                    anade(f'{carpeta_parte}/{nombre} (revisado).pdf', r.get('pdf'), True)
                    anade(f'{carpeta_parte}/{nombre} (revisado, ficha de repaso).pdf', r.get('repaso'), True)
                else:
                    if not t.get('disponible'):
                        continue
                    anade(f'{carpeta_parte}/{nombre}.pdf', ruta_local(t.get('url')))
                    anade(f'{carpeta_parte}/{nombre}.docx',
                          ruta_local(t.get('urlDocx')) or f'{carpeta_ej}/{archivo}.docx')
    # Sin repetidos (mismo destino)
    vistos, unicas = set(), []
    for f in filas:
        if f[0] not in vistos:
            vistos.add(f[0])
            unicas.append(f)
    return unicas, revisados


def leeme(con_revisados, revisados, filas):
    sin_antiguo = sorted(codigo_ordenable(c) for c, t in revisados.items()
                         if c != '1D01' and not t.get('anterior'))
    hoy = date.today().strftime('%d/%m/%Y')
    texto = f"""MATERIALES PARA LA OPOSICIÓN A TÉCNICO COMERCIAL Y ECONOMISTA DEL ESTADO
Víctor Gutiérrez Marcos · https://www.victorgutierrezmarcos.es/oposicion/
Generado el {hoy}. {len(filas)} ficheros.

ORGANIZACIÓN
  0 Organización        Excel de estrategia, estructura del temario, cómo cantar un tema,
                        convocatoria y plantillas de Word
  1 Primer ejercicio    Test (exámenes oficiales y plantillas) y dictamen
  3 Tercer ejercicio    Temas de las partes A y B, en PDF y Word
  4 Cuarto ejercicio    Temas de las partes A y B, en PDF y Word
  5 Quinto ejercicio    Un PDF por parte
  (El segundo ejercicio, de idiomas, no tiene materiales propios.)

Cada tema se llama por su número y su título (3.A.08 Teoría de la demanda…),
para que el explorador los ordene bien.
"""
    if con_revisados:
        texto += """
TEMAS REVISADOS
Este ZIP es el de quien ha iniciado sesión en la web: lleva, además, los temas
revisados del tercer ejercicio y la guía del dictamen. Cada uno sale junto al tema
antiguo como «(revisado).pdf» y «(revisado, ficha de repaso).pdf». El Word de los
temas revisados está en la web y en la app, en la página de cada tema.

LICENCIA
- Temas revisados, fichas de repaso y guía del dictamen revisada: materiales
  exclusivos, solo para uso personal; no se pueden compartir ni volver a publicar.
  Condiciones: https://www.victorgutierrezmarcos.es/condiciones-materiales.html
- Todo lo demás: Creative Commons BY-NC-ND 4.0
  (https://creativecommons.org/licenses/by-nc-nd/4.0/deed.es).
"""
    else:
        texto += f"""
TEMAS REVISADOS
Los temas del tercer ejercicio revisados en 2026 (con gráficos propios, fichas de
repaso y la guía del dictamen) no van en este ZIP: se leen en la web y en la app con
tu cuenta de Google. Si inicias sesión en https://www.victorgutierrezmarcos.es/oposicion/,
el botón descarga el ZIP que también los lleva.
Aquí está la versión antigua de cada tema que la tenía. No tienen versión antigua
(solo están revisados): {', '.join(sin_antiguo) or 'ninguno'}.

LICENCIA
Creative Commons BY-NC-ND 4.0 (https://creativecommons.org/licenses/by-nc-nd/4.0/deed.es):
puedes compartirlos citando al autor, sin uso comercial y sin modificarlos.
"""
    return texto.replace('\n', '\r\n')


def blobs():
    """Huella git de cada fichero del repositorio (rápido, sin leerlos)."""
    r = subprocess.run(['git', '-C', RAIZ, 'ls-files', '-s', 'oposicion'], capture_output=True, text=True)
    out = {}
    for linea in r.stdout.splitlines():
        meta, ruta = linea.split('\t', 1)
        out[ruta] = meta.split()[1]
    return out


def huella(filas):
    b = blobs()
    h = hashlib.sha256()
    for destino, origen, solo in sorted(filas):
        h.update(f'{destino}\0{b.get(origen) or os.path.getsize(os.path.join(RAIZ, origen))}\0{solo}\n'.encode())
    h.update(open(__file__, 'rb').read())
    return h.hexdigest()[:16]


def escribir(ruta, filas, con_revisados, revisados):
    elegidas = [f for f in filas if con_revisados or not f[2]]
    with zipfile.ZipFile(ruta, 'w', zipfile.ZIP_DEFLATED, compresslevel=6) as z:
        z.writestr(f'{CARPETA}/LÉEME.txt', leeme(con_revisados, revisados, elegidas))
        for destino, origen, _ in elegidas:
            modo = zipfile.ZIP_STORED if origen.lower().endswith(YA_COMPRIMIDOS) else zipfile.ZIP_DEFLATED
            z.write(os.path.join(RAIZ, origen), destino, compress_type=modo)
    print(f'{ruta}: {len(elegidas)} ficheros, {os.path.getsize(ruta) / 1e6:.0f} MB')


def main():
    ap = argparse.ArgumentParser(description=__doc__.split('\n')[0])
    ap.add_argument('--salida', default=os.path.join(RAIZ, 'salida-zip'))
    ap.add_argument('--huella', action='store_true')
    ap.add_argument('--lista', action='store_true')
    a = ap.parse_args()
    filas, revisados = materiales()
    if a.huella:
        print(huella(filas))
        return
    if a.lista:
        for destino, origen, solo in filas:
            print(('[sesión] ' if solo else '         ') + destino.split('/', 1)[1], '<-', origen)
        print(f'{sum(1 for f in filas if not f[2])} en el público; {len(filas)} con los revisados')
        return
    os.makedirs(a.salida, exist_ok=True)
    escribir(os.path.join(a.salida, PUBLICO), filas, False, revisados)
    escribir(os.path.join(a.salida, REVISADOS), filas, True, revisados)
    with open(os.path.join(a.salida, 'huella.txt'), 'w') as f:
        f.write(huella(filas) + '\n')


if __name__ == '__main__':
    sys.exit(main())
