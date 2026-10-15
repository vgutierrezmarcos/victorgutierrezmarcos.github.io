#!/usr/bin/env python3
"""Metadatos de los PDF del temario para buscadores (título, autor, asunto y palabras clave).

Google usa el título interno del PDF como título del resultado: sin esto, un
tema sale como «3.A.8» o «Portada». El título y el epígrafe se sacan del texto
del enlace en las páginas de /oposicion/, así que solo se tocan los PDF
enlazados (los temas aún no disponibles se quedan como están). Se añade una
actualización incremental al final del fichero: el contenido no cambia ni un
byte y cada PDF crece menos de 2 KB. Si el título ya es el bueno, no se toca.

Hay que pasarlo después de subir o regenerar un tema:

    pip install pypdf
    python3 scripts/metadatos-pdf.py           # escribe los que falten
    python3 scripts/metadatos-pdf.py --seco    # solo enseña los títulos
"""
import html
import io
import os
import re
import subprocess
import sys

from pypdf import PdfReader, PdfWriter
from pypdf.generic import BooleanObject, DictionaryObject, NameObject

RAIZ = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
EJERCICIO = {'1': 'primer', '2': 'segundo', '3': 'tercer', '4': 'cuarto', '5': 'quinto'}
OPO = 'oposición a Técnico Comercial y Economista del Estado (TCEE)'
CLAVES = 'oposición TCEE, Técnico Comercial y Economista del Estado, TECO, temario TCEE, oposiciones de comercio'

# PDF que no son temas: título, asunto y palabras clave a mano
FIJOS = {
    'oposicion/organizacion/como_cantar_un_tema.pdf': (
        'Cómo cantar un tema en la oposición TCEE',
        f'Consejos para preparar y cantar los temas orales de la {OPO}.',
        'cantar temas, exposición oral'),
    'oposicion/temario/primer-ejercicio/esquema_dictamen_economico.pdf': (
        'Dictamen de coyuntura TCEE: guía para elaborarlo',
        f'Guía para elaborar el dictamen de coyuntura económica del primer ejercicio de la {OPO}.',
        'dictamen económico, dictamen de coyuntura, primer ejercicio'),
    'oposicion/temario/primer-ejercicio/examenes_oficiales_dictamen.pdf': (
        'Dictámenes oficiales TCEE (2011-2026): recopilación de exámenes',
        f'Recopilación de los dictámenes de coyuntura oficiales del primer ejercicio de la {OPO}, de 2011 a 2026.',
        'dictamen de coyuntura, exámenes oficiales, primer ejercicio'),
    'oposicion/temario/primer-ejercicio/test/examenes_oficiales_test.pdf': (
        'Tests oficiales TCEE: recopilación de exámenes del primer ejercicio',
        f'Recopilación de los exámenes tipo test oficiales del primer ejercicio de la {OPO} de convocatorias anteriores.',
        'test TCEE, exámenes oficiales, preguntas test, primer ejercicio'),
    'oposicion/temario/quinto-ejercicio/parte_A.pdf': (
        'Quinto ejercicio TCEE, parte A: marketing internacional y técnicas comerciales',
        f'Temas de marketing internacional y técnicas comerciales del quinto ejercicio de la {OPO}.',
        'marketing internacional, técnicas comerciales, quinto ejercicio'),
    'oposicion/temario/quinto-ejercicio/parte_B.pdf': (
        'Quinto ejercicio TCEE, parte B: econometría',
        f'Temas de econometría del quinto ejercicio de la {OPO}.',
        'econometría, quinto ejercicio'),
}


def enlaces():
    """PDF enlazado → texto más largo de sus enlaces en las páginas de /oposicion/."""
    paginas = subprocess.check_output(['git', 'ls-files', 'oposicion/*.html', 'oposicion/**/*.html'], text=True, cwd=RAIZ).split()
    textos = {}
    for pagina in paginas:
        fuente = open(os.path.join(RAIZ, pagina), encoding='utf-8').read()
        for href, texto in re.findall(r'<a [^>]*href="([^"#?]+\.pdf)"[^>]*>(.*?)</a>', fuente, re.S):
            ruta = os.path.normpath(os.path.join(os.path.dirname(pagina), href))
            texto = html.unescape(re.sub(r'\s+', ' ', re.sub(r'<[^>]+>', '', texto))).strip()
            if ruta.startswith('oposicion/') and '/oculto/' not in ruta and os.path.exists(os.path.join(RAIZ, ruta)) \
                    and len(texto) > len(textos.get(ruta, '')):
                textos[ruta] = texto
    return textos


def metadatos(ruta, texto):
    if ruta in FIJOS:
        return FIJOS[ruta]
    texto = re.sub(r'\s*Temario anterior.*$', '', texto).strip()
    m = re.match(r'Tema (\d)\.([A-Z])\.(\d+):\s*(.+)$', texto)
    if not m:
        sys.exit(f'No sé titular {ruta} («{texto}»): añádelo a FIJOS')
    ej, parte, num, epigrafe = m.groups()
    primera = re.split(r'(?<=[a-zñáéíóú)»])\.\s', epigrafe, maxsplit=1)[0].rstrip('.')
    titulo = f'Tema {ej}.{parte}.{num} TCEE: {primera}'
    if len(titulo) > 110:
        titulo = titulo[:107].rsplit(' ', 1)[0] + '…'
    return (titulo,
            f'Tema {ej}.{parte}.{num} del {EJERCICIO[ej]} ejercicio de la {OPO}: {epigrafe}',
            f'tema {ej}.{parte}.{num}, {EJERCICIO[ej]} ejercicio')


def escribir(ruta, titulo, asunto, claves):
    lector = PdfReader(ruta)
    if (lector.metadata or {}).get('/Title') == titulo:
        return False
    escritor = PdfWriter(ruta, incremental=True)
    datos = dict(lector.metadata or {})
    datos.update({'/Title': titulo, '/Author': 'Víctor Gutiérrez Marcos', '/Subject': asunto,
                  '/Keywords': f'{claves}, {CLAVES}'})
    escritor.add_metadata(datos)
    # Que el visor muestre el título en vez del nombre del fichero
    preferencias = escritor._root_object.get('/ViewerPreferences')
    preferencias = preferencias.get_object() if preferencias is not None else DictionaryObject()
    preferencias[NameObject('/DisplayDocTitle')] = BooleanObject(True)
    escritor._root_object[NameObject('/ViewerPreferences')] = preferencias
    salida = io.BytesIO()
    escritor.write(salida)
    original = open(ruta, 'rb').read()
    nuevo = salida.getvalue()
    if not nuevo.startswith(original[:-64]):
        sys.exit(f'{ruta}: la escritura no ha sido incremental; no se guarda')
    open(ruta, 'wb').write(nuevo)
    return True


def main():
    seco = '--seco' in sys.argv
    os.chdir(RAIZ)
    cambiados = 0
    for ruta, texto in sorted(enlaces().items()):
        titulo, asunto, claves = metadatos(ruta, texto)
        if seco:
            print(f'{titulo}  [{ruta}]')
        elif escribir(ruta, titulo, asunto, claves):
            cambiados += 1
            print(f'✓ {ruta}: {titulo}')
    if not seco:
        print(f'{cambiados} PDF actualizados')


if __name__ == '__main__':
    main()
