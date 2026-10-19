#!/usr/bin/env python3
"""Metadatos de los PDF del temario: título, autor, asunto, palabras clave y licencia.

Google usa el título interno del PDF como título del resultado: sin esto, un
tema sale como «3.A.8» o «Portada». El título y el epígrafe se sacan del texto
del enlace en las páginas de /oposicion/, así que solo se tocan los PDF
enlazados (los temas aún no disponibles se quedan como están). Se añade una
actualización incremental al final del fichero: el contenido no cambia ni un
byte y cada PDF crece unos pocos KB. Si el título ya es el bueno, no se toca.

Además, todos los materiales propios (temas, fichas, guías y el PDF del blog;
no los exámenes oficiales ni el BOE, ver AJENOS) llevan el copyright y la
licencia CC BY-NC-ND 4.0 en los metadatos: /Copyright y /Rights en el
diccionario Info y dc:rights, xmpRights:Marked y xmpRights:WebStatement en el
XMP (donde también se pone dc:title igual que el título). El contenido visible
no cambia.

Lo pasa solo GitHub Actions (.github/workflows/metadatos-pdf.yml) al subir o
cambiar un PDF o una página de /oposicion/. A mano:

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
import xml.etree.ElementTree as ET

from pypdf import PdfReader, PdfWriter
from pypdf.generic import BooleanObject, DictionaryObject, NameObject, StreamObject

RAIZ = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
PROPIOS = set()  # se rellena en main()
EJERCICIO = {'1': 'primer', '2': 'segundo', '3': 'tercer', '4': 'cuarto', '5': 'quinto'}
OPO = 'oposición a Técnico Comercial y Economista del Estado (TCEE)'
CLAVES = 'oposición TCEE, Técnico Comercial y Economista del Estado, TECO, temario TCEE, oposiciones de comercio'

# Licencia de los materiales propios (la misma que LICENSE.md y el pie de la web)
AUTOR = 'Víctor Gutiérrez Marcos'
LICENCIA = 'CC BY-NC-ND 4.0'
LICENCIA_URL = 'https://creativecommons.org/licenses/by-nc-nd/4.0/deed.es'
LICENCIA_URL_LEGAL = 'https://creativecommons.org/licenses/by-nc-nd/4.0/'
PERMISOS = 'puedes compartirlo citando al autor, sin fines comerciales y sin modificarlo'

# PDF del repositorio que no son obra de Víctor: no llevan su licencia
AJENOS = {
    'oposicion/organizacion/OEP2025TECOS_Convocatoria_BOE.pdf',                 # BOE
    'oposicion/temario/primer-ejercicio/examenes_oficiales_dictamen.pdf',       # exámenes del Ministerio
    'oposicion/temario/primer-ejercicio/test/examenes_oficiales_test.pdf',      # exámenes del Ministerio
}

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


def propios():
    """PDF de Víctor que llevan la licencia: los de /oposicion/ y /blog/, menos AJENOS."""
    rutas = subprocess.check_output(['git', 'ls-files', 'oposicion/*.pdf', 'blog/*.pdf'], text=True, cwd=RAIZ).split()
    return [r for r in rutas if r not in AJENOS and '/oculto/' not in r]


def anio_de(info):
    """Año de creación del PDF (para el ©); vacío si no consta."""
    m = re.match(r'D:(\d{4})', str(info.get('/CreationDate') or info.get('/ModDate') or ''))
    return m.group(1) if m else ''


def derechos(anio):
    return f'© {anio + " " if anio else ""}{AUTOR} · Licencia {LICENCIA} ({LICENCIA_URL}): {PERMISOS}.'


NS = {
    'x': 'adobe:ns:meta/',
    'rdf': 'http://www.w3.org/1999/02/22-rdf-syntax-ns#',
    'dc': 'http://purl.org/dc/elements/1.1/',
    'xmpRights': 'http://ns.adobe.com/xap/1.0/rights/',
}


def _q(prefijo, nombre):
    return f'{{{NS[prefijo]}}}{nombre}'


def xmp_con_licencia(xmp, titulo, texto):
    """El paquete XMP (bytes o None) con dc:title, dc:creator, dc:rights y xmpRights.
    Conserva el resto de propiedades; si no hay XMP o no se puede leer, crea uno."""
    raiz = None
    if xmp:
        fuente = xmp.decode('utf-8', 'replace')
        for prefijo, uri in re.findall(r'xmlns:([\w.-]+)="([^"]+)"', fuente):
            try:
                ET.register_namespace(prefijo, uri)
            except ValueError:
                pass
        m = re.search(r'<x:xmpmeta.*</x:xmpmeta>', fuente, re.S)
        try:
            raiz = ET.fromstring(m.group(0)) if m else None
        except ET.ParseError:
            raiz = None
    for prefijo, uri in NS.items():
        ET.register_namespace(prefijo, uri)
    if raiz is None:
        raiz = ET.Element(_q('x', 'xmpmeta'))
        ET.SubElement(raiz, _q('rdf', 'RDF'))
    rdf = raiz.find(_q('rdf', 'RDF'))
    quitar = {_q('dc', 'rights'), _q('xmpRights', 'Marked'), _q('xmpRights', 'WebStatement')}
    if titulo:
        quitar.add(_q('dc', 'title'))
    for desc in rdf.findall(_q('rdf', 'Description')):
        for hijo in list(desc):
            if hijo.tag in quitar:
                desc.remove(hijo)
        for atributo in list(desc.attrib):
            if atributo in quitar:
                del desc.attrib[atributo]
    tiene_autor = any(d.find(_q('dc', 'creator')) is not None for d in rdf.findall(_q('rdf', 'Description')))
    nueva = ET.SubElement(rdf, _q('rdf', 'Description'), {_q('rdf', 'about'): ''})

    def alt(nombre, valor):
        li = ET.SubElement(ET.SubElement(ET.SubElement(nueva, _q('dc', nombre)), _q('rdf', 'Alt')), _q('rdf', 'li'))
        li.set('{http://www.w3.org/XML/1998/namespace}lang', 'x-default')
        li.text = valor
    if titulo:
        alt('title', titulo)
    if not tiene_autor:
        ET.SubElement(ET.SubElement(ET.SubElement(nueva, _q('dc', 'creator')), _q('rdf', 'Seq')), _q('rdf', 'li')).text = AUTOR
    alt('rights', texto)
    ET.SubElement(nueva, _q('xmpRights', 'Marked')).text = 'True'
    ET.SubElement(nueva, _q('xmpRights', 'WebStatement')).text = LICENCIA_URL_LEGAL
    cuerpo = ET.tostring(raiz, encoding='unicode')
    return ('<?xpacket begin="\ufeff" id="W5M0MpCehiHzreSzNTczkc9d"?>\n' + cuerpo + '\n'
            + (' ' * 99 + '\n') * 20 + '<?xpacket end="w"?>').encode('utf-8')


def con_licencia(info):
    return LICENCIA_URL_LEGAL in str(info.get('/Rights') or '')


def escribir(ruta, titulo=None, asunto=None, claves=None):
    """Título, asunto y palabras clave (si se dan) y la licencia (si es un PDF propio)."""
    lector = PdfReader(ruta)
    info = lector.metadata or {}
    licencia = ruta in PROPIOS
    falta_titulo = titulo is not None and info.get('/Title') != titulo
    falta_licencia = licencia and not con_licencia(info)
    if not falta_titulo and not falta_licencia:
        return False
    escritor = PdfWriter(ruta, incremental=True)
    datos = dict(info)
    if titulo is not None:
        datos.update({'/Title': titulo, '/Author': AUTOR, '/Subject': asunto,
                      '/Keywords': f'{claves}, {CLAVES}'})
    if licencia:
        texto = derechos(anio_de(info))
        datos.update({'/Copyright': texto, '/Rights': f'{LICENCIA} · {LICENCIA_URL_LEGAL}'})
        actual = lector.trailer['/Root'].get('/Metadata')
        xmp = actual.get_object().get_data() if actual is not None else None
        flujo = StreamObject()
        flujo.set_data(xmp_con_licencia(xmp, datos.get('/Title'), texto))
        flujo[NameObject('/Type')] = NameObject('/Metadata')
        flujo[NameObject('/Subtype')] = NameObject('/XML')
        escritor._root_object[NameObject('/Metadata')] = escritor._add_object(flujo)
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
    global PROPIOS
    seco = '--seco' in sys.argv
    os.chdir(RAIZ)
    PROPIOS = set(propios())
    cambiados = 0
    titulados = enlaces()
    for ruta, texto in sorted(titulados.items()):
        titulo, asunto, claves = metadatos(ruta, texto)
        if seco:
            print(f'{titulo}  [{ruta}]{"  · licencia" if ruta in PROPIOS else ""}')
        elif escribir(ruta, titulo, asunto, claves):
            cambiados += 1
            print(f'✓ {ruta}: {titulo}')
    # Los PDF propios que no están enlazados (o no tienen título fijo): solo la licencia
    for ruta in sorted(PROPIOS - set(titulados)):
        if seco:
            print(f'(sin título)  [{ruta}]  · licencia')
        elif escribir(ruta):
            cambiados += 1
            print(f'✓ {ruta}: licencia')
    if not seco:
        print(f'{cambiados} PDF actualizados')


if __name__ == '__main__':
    main()
