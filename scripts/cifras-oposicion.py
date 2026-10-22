#!/usr/bin/env python3
"""La oposición a TCEE en cifras: lee los documentos oficiales y calcula las
estadísticas de cada convocatoria.

Fuentes:
- Páginas de cada convocatoria en el Ministerio (OEP 2018 en adelante):
  listas de admitidos y de aprobados de cada ejercicio (PDF; muchos son
  imágenes escaneadas y se leen con OCR).
- BOE (API de datos abiertos): convocatorias (plazas) y, para las
  convocatorias anteriores a 2018, las relaciones de aprobados.

Escribe oposicion/cifras.json con los datos agregados (nunca nombres) y
deja en caché los PDF y su lectura en ~/.local/share/oposicion-web/cifras/.

Uso (necesita el entorno con PyMuPDF y RapidOCR, ver README):
    ~/.local/share/oposicion-web/venv-ocr/bin/python scripts/cifras-oposicion.py [--solo-extraer] [--anio 2024]
"""
import argparse
import html
import importlib.util
import json
import os
import re
import ssl
import statistics
import sys
import unicodedata
import urllib.parse
import urllib.request
from collections import Counter, defaultdict
from pathlib import Path

RAIZ = Path(__file__).resolve().parents[1]
CACHE = Path(os.path.expanduser('~/.local/share/oposicion-web/cifras'))
SALIDA = RAIZ / 'oposicion' / 'cifras.json'
PORTAL = 'https://portal.mineco.gob.es'
PRIMER_ANIO_MINISTERIO = 2018

ctx = ssl.create_default_context(cafile=os.path.expanduser('~/.config/oposicion-red/cas.pem')) \
    if os.path.exists(os.path.expanduser('~/.config/oposicion-red/cas.pem')) else ssl.create_default_context()


def descargar(url, destino=None):
    pet = urllib.request.Request(url, headers={'User-Agent': 'Mozilla/5.0', 'Accept': 'application/json, */*'})
    with urllib.request.urlopen(pet, context=ctx, timeout=90) as r:
        b = r.read()
    if destino:
        Path(destino).write_bytes(b)
    return b


# ------------------------------------------------------- Documentos del Ministerio

def documentos_ministerio(anio):
    """Los documentos de la página OEP{anio}TECOS.aspx: [{seccion, titulo, url}]."""
    ruta = CACHE / f'pagina-{anio}.html'
    if not ruta.exists():
        descargar(f'{PORTAL}/es-es/ministerio/empleo/Paginas/OEP{anio}TECOS.aspx', ruta)
    pagina = ruta.read_text(encoding='utf-8', errors='replace')
    # Las páginas llevan los enlaces en un JSON incrustado (webpart «Secciones»)
    p = re.sub(r'\\u([0-9a-fA-F]{4})', lambda m: chr(int(m.group(1), 16)), pagina)
    out, vistos = [], set()
    for m in re.finditer(r'data-sp-webpartdata="([^"]*)"', p):
        try:
            d = json.loads(html.unescape(m.group(1)))
        except ValueError:
            continue
        for it in d.get('properties', {}).get('items', []) or []:
            sec = html.unescape(it.get('TitleSecciones', '') or '')
            for e in it.get('EnlacesSecciones', []) or []:
                u = html.unescape(e.get('url', '') or '')
                if not u:
                    continue
                url = PORTAL + u if u.startswith('/') else u
                if url in vistos:
                    continue
                vistos.add(url)
                out.append({'seccion': sec, 'titulo': html.unescape(e.get('titulo', '') or ''), 'url': url})
    if not out:  # formato nuevo: el lector del proceso ya lo entiende
        spec = importlib.util.spec_from_file_location('lp', RAIZ / 'scripts' / 'leer-proceso.py')
        lp = importlib.util.module_from_spec(spec)
        spec.loader.exec_module(lp)
        out = lp.documentos(pagina)
    return out


def nombre_cache(anio, url):
    return f'{anio}_' + re.sub(r'[^A-Za-z0-9_.-]+', '_', urllib.parse.unquote(url.split('/')[-1]))


# ------------------------------------------------------------- Lectura de PDF

_ocr = None


def ocr():
    global _ocr
    if _ocr is None:
        from rapidocr_onnxruntime import RapidOCR
        _ocr = RapidOCR()
    return _ocr


def filas_de_pdf(ruta):
    """Lee un PDF y devuelve sus filas: [[celda, celda, …], …] por página,
    reconstruyendo las filas por la coordenada vertical (texto nativo o OCR).
    Se guarda en caché junto al PDF (.filas.json)."""
    cache = Path(str(ruta) + '.filas.json')
    if cache.exists():
        return json.loads(cache.read_text(encoding='utf-8'))
    import fitz
    doc = fitz.open(ruta)
    paginas = []
    for pagina in doc:
        palabras = pagina.get_text('words')  # (x0, y0, x1, y1, texto, bloque, línea, palabra)
        cajas = []
        if len(palabras) >= 20 and any(re.search(r'\d', w[4]) for w in palabras) and not escaneada(pagina):
            for x0, y0, x1, y1, t, *_ in palabras:
                cajas.append((x0, y0, x1, y1, t))
            modo = 'texto'
        else:
            pix = pagina.get_pixmap(dpi=150)
            img = pix.tobytes('png')
            resultado, _ = ocr()(img)
            for caja, texto, conf in (resultado or []):
                xs = [p[0] for p in caja]
                ys = [p[1] for p in caja]
                cajas.append((min(xs), min(ys), max(xs), max(ys), texto))
            modo = 'ocr'
        paginas.append({'modo': modo, 'filas': agrupar_filas(cajas)})
    cache.write_text(json.dumps(paginas, ensure_ascii=False), encoding='utf-8')
    return paginas


def escaneada(pagina):
    """¿La página es una imagen (escaneada) aunque lleve una capa de texto? Esas capas
    (OCR del Ministerio) traen las palabras descolocadas y es mejor leerlas de nuevo."""
    area = abs(pagina.rect)
    for b in pagina.get_text('dict').get('blocks', []):
        if b.get('type') == 1:
            r = b['bbox']
            if (r[2] - r[0]) * (r[3] - r[1]) > 0.5 * area:
                return True
    return False


def agrupar_filas(cajas):
    """Agrupa las cajas de texto en filas por su centro vertical."""
    cajas = sorted(cajas, key=lambda c: ((c[1] + c[3]) / 2, c[0]))
    filas = []
    for c in cajas:
        cy = (c[1] + c[3]) / 2
        alto = max(c[3] - c[1], 6)
        if filas and abs(filas[-1]['y'] - cy) <= alto * 0.6:
            filas[-1]['cajas'].append(c)
            n = len(filas[-1]['cajas'])
            filas[-1]['y'] = (filas[-1]['y'] * (n - 1) + cy) / n
        else:
            filas.append({'y': cy, 'cajas': [c]})
    return [[c[4] for c in sorted(f['cajas'], key=lambda c: c[0])] for f in filas]


# ------------------------------------------------------------------- Parsers

IDIOMA_RE = re.compile(r'ALEMAN|FRANCES|ITALIANO|PORTUGUES|RUSO|CHINO|ARABE|JAPONES')
IDIOMAS = {'ALEMAN': 'Alemán', 'FRANCES': 'Francés', 'ITALIANO': 'Italiano', 'PORTUGUES': 'Portugués', 'RUSO': 'Ruso', 'CHINO': 'Chino', 'ARABE': 'Árabe', 'JAPONES': 'Japonés'}
NUM = re.compile(r'^\d{1,3}[,.]\d{1,2}$')
DNI = re.compile(r'^(?:[\*"\'•t·]{1,4}\d{3,4}[\*"\'•<·]{1,4}|\d{3,4}\*{2,6}|X{3,4}\d{3,4}[A-Z]?[A-ZÁÉÍÓÚÑ-]*)$')


def numeros(fila):
    out = []
    for c in fila:
        for t in re.findall(r'(?<![\d,.])\d{1,3}[,.]\d{1,2}(?![\d,.])', c):
            out.append(float(t.replace(',', '.')))
    return out


def normaliza(s):
    s = unicodedata.normalize('NFKD', s).encode('ascii', 'ignore').decode().upper()
    return re.sub(r'[^A-Z ]+', ' ', s).strip()


def turno_de_encabezado(cab):
    """Si la fila es un encabezado de sección, el turno que abre: tl, disc, pi."""
    if len(cab) > 60 or 'APELLIDO' in cab:
        return None
    if 'PROMOCION INTERNA' in cab:
        return 'pi'
    if 'DISCAPACIDAD' in cab or 'CUPO' in cab:
        return 'disc'
    if 'TURNO LIBRE' in cab or 'ACCESO LIBRE' in cab:
        return 'tl'
    return None


def filas_con_nota(paginas, maximo=None):
    """Filas que parecen un aspirante con nota: [(nombre normalizado, [notas], turno)].
    El turno sale de los encabezados de sección del documento («Turno libre»,
    «Promoción interna», «Cupo de reserva de discapacidad»); None si no hay.
    Si la lista va a dos columnas («Aspirante Nota Aspirante Nota»), cada nota es
    una persona (los nombres largos saltan de fila y pierden su nota)."""
    out = []
    dos_columnas = False
    turno = None
    for p in paginas:
        for f in p['filas']:
            cab = normaliza(' '.join(f))
            t = turno_de_encabezado(cab)
            if t:
                turno = t
                continue
            if cab.count('ASPIRANTE') >= 2 and cab.count('NOTA') >= 2 and len(f) <= 8:
                dos_columnas = True
                continue
            ns = numeros(f)
            if not ns:
                continue
            if dos_columnas:
                trozos = re.split(r'\d{1,3}[,.]\d{1,2}', ' '.join(f))
                for n, trozo in zip(ns, trozos):
                    if maximo is None or n <= maximo:
                        out.append((normaliza(re.sub(r'\S*[:/.]\S*', ' ', trozo)), [n], turno))
                continue
            if maximo is not None and ns[-1] > maximo:
                continue
            texto = ' '.join(c for c in f if not NUM.match(c.strip()) and not DNI.match(c.strip()) and not re.search(r'[:/]|\d', c))
            texto = re.sub(r'\d{1,3}[,.]\d{1,2}', ' ', texto)
            texto = re.sub(r'\b\d+\b', ' ', texto)
            nombre = normaliza(texto)
            nombre = re.sub(r'\b(?:VERIFICACION|VERIFICABLE|CODIGO|SEGURO|FOLIOS?|FECHA|FIRMADO|CONSTA|DOCUMENTO|MINISTERIAL|SEGUN|ORDEN|EUBA|ALDAPE|APTO)\b', ' ', nombre)
            nombre = re.sub(r'\s+', ' ', nombre).strip()
            if len(nombre) < 6 or len(nombre.split()) < 2:
                continue
            if re.search(r'PRIMER APELLIDO|CALIFICACION|APELLIDOS Y NOMBRE|\bNOTA|\bORDEN|TRIBUNAL|RESOLUCION|ARTICULO|\bLEY\b|DECRETO|MADRID|BOLETIN|PLAZO|RECURSO|SECRETARIA|MINISTERIO|CONVOCATORIA|PUNTOS|EJERCICIO|CORTE|PLAZAS|FIRMADO|FOLIO|CODIGO|VERIFICA', nombre):
                continue
            if len(nombre.split()) > 7:
                continue
            out.append((nombre, ns, turno))
    return out


def filas_admitidos(paginas):
    """Filas de una lista de admitidos: una por aspirante. Devuelve (n, nombres):
    n es el mayor de los recuentos de filas con DNI enmascarado y de filas con
    idioma (todo admitido declara su segundo idioma); si no hay ninguno, los nombres."""
    con_dni = con_idioma = 0
    nombres = []
    personas = []
    for p in paginas:
        for f in p['filas']:
            celdas = [c.strip() for c in f]
            if any(DNI.match(c) for c in celdas):
                con_dni += 1
            idiomas_fila = IDIOMA_RE.findall(normaliza(' '.join(celdas)))
            if idiomas_fila:
                con_idioma += 1
            texto = IDIOMA_RE.sub(' ', normaliza(' '.join(c for c in celdas if not DNI.match(c))))
            texto = re.sub(r'\b[A-Z]\b', ' ', texto).strip()
            texto = re.sub(r'\s+', ' ', texto)
            if len(celdas) >= 3 and len(texto.split()) >= 2 and not re.search(r'PRIMER APELLIDO|APELLIDO|NOMBRE|DATOS|MINISTERIO|CUERPO|LISTADO|TURNO|ADMITIDOS|RESERVA|PROMOCION|CONVOCATORIA|RESOLUCION|TRIBUNAL|NIF|DNI|FIRMADO|PRESIDENT|FECHA|SECRETARI|DIGITALMENTE', texto):
                nombres.append(texto)
                if idiomas_fila:
                    personas.append((texto, IDIOMAS[idiomas_fila[0]]))
    return (max(con_dni, con_idioma) or len(nombres)), nombres, personas


def idiomas_admitidos(paginas):
    """Idiomas de una lista de admitidos: el primero de cada fila es el segundo
    idioma elegido («Datos A»); los siguientes, los voluntarios."""
    elegidos, voluntarios = Counter(), Counter()
    for p in paginas:
        for f in p['filas']:
            encontrados = IDIOMA_RE.findall(normaliza(' '.join(f)))
            if encontrados:
                elegidos[IDIOMAS[encontrados[0]]] += 1
                for v in encontrados[1:]:
                    voluntarios[IDIOMAS[v]] += 1
    return {'elegidos': dict(elegidos), 'voluntarios': dict(voluntarios)}


# ------------------------------------------------------- Clasificación de docs

def clasificar(seccion, titulo):
    s, t = normaliza(seccion), normaliza(titulo)
    if 'CAMBIO' in t or 'SALA' in t or ('CONVOCATORIA' in t and 'APROBAD' not in t and 'ADMITID' not in t):
        return None
    if 'ADMITID' in s or 'ADMITID' in t:
        if 'EXCLUID' in t and 'ADMITID' not in t:
            return None
        if 'ADMITID' not in t:
            return None
        turno = 'pi' if 'PROMOCION' in t or ' PI' in t else 'disc' if 'DISCAPA' in t or 'CUPO' in t else 'tl'
        return ('admitidos', turno, 'DEFINITIV' in t)
    if 'CONSERVA' in t:
        if 'SIGUIENTE' in t:
            return None  # la lista de notas que se guardan para la convocatoria siguiente
        ej = 2 if 'SEGUNDO' in s or 'SEGUNDO' in t else 3 if 'TERCER' in s or 'TERCER' in t else None
        return ('conservan', ej) if ej else None
    if 'APROBAD' not in t and 'APROBAD' not in s:
        return None
    ej = None
    for k, n in (('PRIMER', 1), ('SEGUNDO', 2), ('TERCER', 3), ('CUARTO', 4), ('QUINTO', 5)):
        if k in s or k in t:
            ej = n
    if ej is None:
        if 'FASE' in s or 'FASE' in t or 'OPOSICION' in s and 'APROBAD' in s:
            return ('fase_oposicion',)
        return ('aprobados_final',)
    parte = ''
    if ej == 1 and ('PARTE' in t or 'TEST' in t or 'CORTE' in t):
        parte = 'test'
    if ej == 2:
        parte = 'ingles' if 'INGLES' in t else 'resto' if 'RESTO' in t else 'total'
    es_pi = 'PROMOCION' in t or bool(re.search(r'\bPI\b', t))
    es_tl = 'TURNO LIBRE' in t or bool(re.search(r'\bTL\b', t))
    turno = 'todos' if es_pi == es_tl else 'pi' if es_pi else 'tl'
    return ('ejercicio', ej, parte, turno)


def leer_convocatoria_ministerio(anio, solo_extraer=False):
    docs = documentos_ministerio(anio)
    datos = {'anio': anio, 'admitidos': {}, 'ejercicios': {}, 'idiomas': {}, 'nombres': {}}
    clases = [clasificar(d['seccion'], d['titulo']) for d in docs]
    # Si hay lista definitiva de admitidos de un turno, la provisional no hace falta
    con_definitiva = {c[1] for c in clases if c and c[0] == 'admitidos' and c[2]}
    for d, clase in zip(docs, clases):
        if not clase:
            continue
        if clase[0] == 'admitidos' and not clase[2] and clase[1] in con_definitiva:
            continue
        ruta = CACHE / nombre_cache(anio, d['url'])
        if not ruta.exists():
            try:
                descargar(d['url'], ruta)
            except Exception as e:
                print(f'  {anio} no se pudo bajar {d["titulo"][:50]}: {e}')
                continue
        try:
            paginas = filas_de_pdf(ruta)
        except Exception as e:
            print(f'  {anio} PDF ilegible {ruta.name}: {e}')
            continue
        if solo_extraer:
            continue
        if clase[0] == 'conservan':
            filas = filas_con_nota(paginas, maximo=40)
            datos.setdefault('conservan', {})[str(clase[1])] = {'doc': d['titulo'], 'url': d['url'], 'n': len(filas),
                                                               'ambos': sum(1 for f in filas if len(f[1]) >= 2), 'nombres': [f[0] for f in filas]}
            continue
        if clase[0] == 'admitidos':
            _, turno, definitiva = clase
            n, nombres, personas = filas_admitidos(paginas)
            actual = datos['admitidos'].get(turno)
            # Preferimos la lista definitiva; si no, la provisional
            if actual is None or (definitiva and not actual['definitiva']):
                datos['admitidos'][turno] = {'n': n, 'definitiva': definitiva, 'doc': d['titulo'], 'url': d['url'], 'filas_nombre': len(nombres)}
                datos['nombres']['admitidos_' + turno] = nombres
                datos.setdefault('personas', {})[turno] = personas
                if turno == 'tl':
                    datos['idiomas'] = idiomas_admitidos(paginas)
        elif clase[0] == 'ejercicio':
            _, ej, parte, turno = clase
            maximo = {1: 45, 2: 40, 3: 40, 4: 40, 5: 20}[ej]
            filas = filas_con_nota(paginas, maximo=maximo)
            clave = f'{ej}{"-" + parte if parte else ""}'
            e = datos['ejercicios'].setdefault(clave, {})
            por_turno = {}
            for nombre, ns, t in filas:
                k = t or (turno if turno != 'todos' else 'tl')
                por_turno.setdefault(k, []).append(nombre)
            for k, nombres_k in por_turno.items():
                e[k] = {'n': len(nombres_k), 'doc': d['titulo'], 'url': d['url'], 'nombres': nombres_k}
            e.setdefault('tl', {'n': 0, 'doc': d['titulo'], 'url': d['url'], 'nombres': []})
        else:
            filas = filas_con_nota(paginas)
            datos['ejercicios'].setdefault(clase[0], {})['todos'] = {'n': len(filas), 'doc': d['titulo'], 'url': d['url'], 'nombres': [f[0] for f in filas]}
    return datos


# ------------------------------------------------------------------------ BOE

BOE_DIR = CACHE / 'boe'


def anuncios_boe():
    """Los anuncios del cuerpo encontrados en los sumarios (boe-rastreo): [{id, fecha, titulo}]."""
    out, vistos = [], set()
    for f in sorted(BOE_DIR.glob('anuncios*.json')):
        for a in json.loads(f.read_text(encoding='utf-8'))['anuncios']:
            if a['id'] and a['id'] not in vistos:
                vistos.add(a['id'])
                out.append(a)
    return sorted(out, key=lambda a: a['fecha'])


def xml_boe(id_):
    ruta = BOE_DIR / f'{id_}.xml'
    if not ruta.exists():
        descargar(f'https://www.boe.es/diario_boe/xml.php?id={id_}', ruta)
    return ruta.read_text(encoding='utf-8', errors='replace')


def texto_boe(xml):
    i = xml.find('<texto>')
    if i < 0:
        m = re.search(r'<url_pdf[^>]*>([^<]+)</url_pdf>', xml)
        id_ = re.search(r'<identificador>([^<]+)', xml).group(1)
        if m:
            ruta = BOE_DIR / f'{id_}.pdf'
            if not ruta.exists():
                descargar(html.unescape(m.group(1)), ruta)
            paginas = filas_de_pdf(ruta)
            txt = ' '.join(' '.join(f) for p in paginas for f in p['filas'])
            # La página del BOE lleva varios anuncios: empezar por el número de este
            numero = id_.split('-')[-1]
            k = re.search(rf'\b{numero}\b\s+(?:ORDEN|RESOLUCI[OÓ]N|Orden|Resoluci[oó]n)', txt)
            if k:
                txt = txt[k.start():]
                sig = re.search(rf'\b{int(numero) + 1}\b\s+(?:ORDEN|RESOLUCI[OÓ]N|Orden|Resoluci[oó]n)', txt)
                if sig:
                    txt = txt[:sig.start()]
            return txt
        return ''
    cuerpo = xml[i:]
    return html.unescape(re.sub(r'\s+', ' ', re.sub(r'<[^>]+>', ' ', cuerpo)))


def filas_boe(xml):
    """Las filas (celdas) de las tablas del XML o, si es un PDF escaneado, del OCR."""
    if '<texto>' in xml:
        out = []
        for tr in re.findall(r'<tr.*?</tr>', xml, re.S):
            celdas = [html.unescape(re.sub(r'<[^>]+>', ' ', c)).strip() for c in re.findall(r'<t[dh][^>]*>(.*?)</t[dh]>', tr, re.S)]
            celdas = [re.sub(r'\s+', ' ', c) for c in celdas if c.strip()]
            if celdas:
                out.append(celdas)
        return [{'modo': 'xml', 'filas': out}]
    m = re.search(r'<url_pdf[^>]*>([^<]+)</url_pdf>', xml)
    id_ = re.search(r'<identificador>([^<]+)', xml).group(1)
    if not m:
        return []
    ruta = BOE_DIR / f'{id_}.pdf'
    if not ruta.exists():
        descargar(html.unescape(m.group(1)), ruta)
    return filas_de_pdf(ruta)


MESES_RE = 'enero|febrero|marzo|abril|mayo|junio|julio|agosto|septiembre|octubre|noviembre|diciembre'
MESES_N = {m: i + 1 for i, m in enumerate(MESES_RE.split('|'))}


def fecha_texto(s, anio=None):
    """«22 de diciembre de 2024» → '2024-12-22'. Si no hay año («Orden EHA/1190/2008,
    de 16 de abril»), se toma el de la referencia de la norma o el dado."""
    m = re.search(rf'(\d{{1,2}}) de ({MESES_RE})(?: de (\d{{4}}))?', s)
    if not m:
        return None
    a = m.group(3)
    if not a:
        anios = re.findall(r'/((?:19|20)\d{2})\b', s[:m.start()])
        a = anios[-1] if anios else anio
    return f'{a}-{MESES_N[m.group(2)]:02d}-{int(m.group(1)):02d}' if a else None


def tipo_anuncio(titulo):
    t = normaliza(titulo)
    # En un mismo BOE salen convocatorias de varios cuerpos del Ministerio: solo las de este
    if re.search(r'\b(?:CUERPO|ESCALA)S? ', t) and 'COMERCIALES Y ECONOMISTAS' not in t and 'TECNICOS COMERCIALES' not in t:
        return None
    if 'LIBRE DESIGNACION' in t or 'PUESTOS DE TRABAJO' in t or 'TRIBUNAL' in t or 'CORRECCION' in t or 'MODIFICA' in t or 'PROGRAMA' in t or 'FECHA' in t or 'ANUNCIA' in t or 'CORRIGE' in t or 'RECTIFICA' in t:
        return None
    if 'APROBAD' in t and ('RELACION' in t or 'LISTA' in t):
        return 'aprobados'
    if 'FUNCIONARIOS EN PRACTICAS' in t and 'NOMBRA' in t:
        return 'practicas'
    if 'FUNCIONARIOS DE CARRERA' in t and 'NOMBRA' in t:
        return 'carrera'
    if 'ADMITID' in t:
        return 'admitidos'
    if 'CONVOCA' in t and ('PROCESO' in t or 'PRUEBAS' in t):
        return 'convocatoria'
    return None


UNIDADES = {'una': 1, 'uno': 1, 'un': 1, 'dos': 2, 'tres': 3, 'cuatro': 4, 'cinco': 5, 'seis': 6, 'siete': 7, 'ocho': 8, 'nueve': 9, 'diez': 10,
            'once': 11, 'doce': 12, 'trece': 13, 'catorce': 14, 'quince': 15, 'dieciseis': 16, 'diecisiete': 17, 'dieciocho': 18, 'diecinueve': 19,
            'veinte': 20, 'veintiuna': 21, 'veintiuno': 21, 'veintidos': 22, 'veintitres': 23, 'veinticuatro': 24, 'veinticinco': 25, 'veintiseis': 26,
            'veintisiete': 27, 'veintiocho': 28, 'veintinueve': 29, 'treinta': 30, 'cuarenta': 40, 'cincuenta': 50, 'sesenta': 60, 'setenta': 70, 'ochenta': 80, 'noventa': 90}


def numeros_en_cifra(txt):
    """«treinta y dos plazas» → «32 plazas» (para las convocatorias que escriben los números en letra)."""
    def conv(m):
        partes = re.split(r'\s+y\s+', m.group(0).strip().lower())
        total = 0
        for p in partes:
            k = unicodedata.normalize('NFKD', p).encode('ascii', 'ignore').decode()
            if k not in UNIDADES:
                return m.group(0)
            total += UNIDADES[k]
        return str(total)
    palabras = '|'.join(sorted(UNIDADES, key=len, reverse=True))
    return re.sub(rf'\b((?:{palabras})(?:\s+y\s+(?:{palabras}))?)\b(?=\s+plazas?)', conv, txt, flags=re.I)


def plazas_de_convocatoria(txt, ocr=False):
    """Plazas de turno libre y promoción interna (y reservas) del texto de la convocatoria.
    En los textos leídos por OCR (a dos columnas) vale la primera cifra tras «cubrir»."""
    out = {}
    txt = numeros_en_cifra(txt)
    if ocr:
        m = re.search(r'acceso libre asciende a (\d+)', txt)
        if m:
            out['libre'] = int(m.group(1))
        m = re.search(r'promoci[oó]n interna asciende a (\d+)', txt)
        if m:
            out['interna'] = int(m.group(1))
        m = re.search(r'(?:convocan? pruebas selectivas para (?:cubrir|proveer|la provisi[oó]n de)|cubrir)[^0-9]{0,40}?(\d+) (?:plazas|vacantes)', txt)
        if m and 'libre' not in out:
            out['libre'] = int(m.group(1))
        m = re.search(r'(\d+) (?:plazas|vacantes)? ?(?:por el|para el|al) sistema de promoci[oó]n interna|promoci[oó]n interna[^.]{0,40}?(\d+) (?:plazas|vacantes)', txt)
        if m:
            out['interna'] = int(m.group(1) or m.group(2))
    # Convocatorias desde 2024: las plazas van en un cuadro («Acceso general Discapacidad Total 25 2 27»)
    m = re.search(r'Turno libre.{0,160}?Acceso general Discapacidad Total (\d+) (\d+) (\d+)', txt)
    if m:
        out['libre'], out['libre_discapacidad'] = int(m.group(3)), int(m.group(2))
    m = re.search(r'Promoci[oó]n interna.{0,160}?Acceso general Discapacidad Total (\d+) (\d+) (\d+)', txt)
    if m:
        out['interna'], out['interna_discapacidad'] = int(m.group(3)), int(m.group(2))
    patrones_libre = [] if out.get('libre') else [
        r'acceso libre asciende a (\d+) plazas',
        r'cubrir (\d+) plazas?,? (?:de|por el sistema general de) acceso libre',
        r'(\d+) plazas? por el sistema general de acceso libre',
        r'(\d+) plazas? (?:de|para el) (?:sistema general de )?acceso libre',
        r'cubrir(?:, por el sistema de oposici[oó]n,)? (\d+) (?:plazas|vacantes)',
        r'proveer(?:, por el procedimiento de oposici[oó]n,)? (\d+) (?:plazas|vacantes)',
        r'(\d+) (?:plazas|vacantes) (?:del|en el) Cuerpo Superior',
    ]
    for pat in patrones_libre:
        m = re.search(pat, txt, re.I)
        if m:
            out['libre'] = int(m.group(1))
            break
    patrones_interna = [] if out.get('interna') else [
        r'promoci[oó]n interna asciende a (\d+)',
        r'(?:otro para cubrir |y )?(\d+) (?:plazas?,? )?(?:por (?:el sistema de )?promoci[oó]n interna)',
        r'(\d+) plazas? (?:de|para la|para el sistema de) promoci[oó]n interna',
    ]
    for pat in patrones_interna:
        m = re.search(pat, txt, re.I)
        if m:
            out['interna'] = int(m.group(1))
            break
    m = re.search(r'(?:acceso libre se reservar[aá]n? (\d+)|se reservar[aá]n? (\d+) plazas? de acceso libre|(\d+) plazas? (?:reservadas?|se reservan) para (?:quienes tengan|personas con|ser cubiertas? por personas con) (?:la condici[oó]n legal de personas con )?discapacidad)', txt, re.I)
    if m and 'libre_discapacidad' not in out:
        out['libre_discapacidad'] = int(next(x for x in m.groups() if x))
    m = re.search(r'promoci[oó]n interna se reservar[aá]n? (\d+)', txt)
    if m and 'interna_discapacidad' not in out:
        out['interna_discapacidad'] = int(m.group(1))
    oeps = re.findall(r'oferta de empleo p[uú]blico[^.;]{0,80}?(?:a[nñ]o|ejercicio|para)\s+(\d{4})', txt, re.I)
    if oeps:
        out['oep'] = max(int(x) for x in oeps)
    return out


REGISTRO = re.compile(r'\b\d{10}(?:S\d{4})?\b')


def aprobados_de_boe(xml):
    """Aprobados por turno en un anuncio del BOE: {'libre': [notas], 'interna': [notas],
    'libre_n': n, 'interna_n': n}. Con notas si el anexo las trae (relaciones de
    aprobados); si no (nombramientos), solo el recuento de filas con persona."""
    out = {'libre': [], 'interna': [], 'libre_n': 0, 'interna_n': 0}
    turno = 'libre'
    if '<texto>' in xml and '<table' not in xml:
        txt = texto_boe(xml)
        i = txt.find('ANEXO')
        cuerpo = txt[i:] if i >= 0 else txt
        dni = r'(?:\b\d{1,2}\.\d{3}\.\d{3}\b|\b\d{7,8}[A-Z]?\b)'
        nota = r'(\d{1,3}[,.]\d{1,2})'
        for m in re.finditer(rf'(Promoci[oó]n interna|Turno libre|[Aa]cceso libre|Sistema general)|{dni}(.{{0,40}}?){nota}|{nota}\s+{dni}', cuerpo):
            if m.group(1):
                turno = 'interna' if m.group(1).lower().startswith('promoci') else 'libre'
                continue
            if m.group(4):  # nota y luego DNI
                out[turno].append(float(m.group(4).replace(',', '.')))
                out[turno + '_n'] += 1
            elif 'Puntuaci' in m.group(2) or re.fullmatch(r'[\s/.:]*', m.group(2)):
                out[turno].append(float(m.group(3).replace(',', '.')))
                out[turno + '_n'] += 1
        return out
    if '<texto>' in xml:
        cuerpo = xml[xml.index('<texto>'):]
        trozos = re.findall(r'(<p[^>]*>.*?</p>|<tr.*?</tr>)', cuerpo, re.S)
        filas = []
        for t in trozos:
            if t.startswith('<p'):
                filas.append(['#P', normaliza(html.unescape(re.sub(r'<[^>]+>', ' ', t)))])
            else:
                celdas = [re.sub(r'\s+', ' ', html.unescape(re.sub(r'<[^>]+>', ' ', c))).strip() for c in re.findall(r'<t[dh][^>]*>(.*?)</t[dh]>', t, re.S)]
                filas.append([c for c in celdas if c])
    else:
        filas = [f for p in filas_boe(xml) for f in p['filas']]
    for f in filas:
        texto = normaliza(' '.join(f))
        if f and f[0] == '#P' or len(f) <= 3 and ('PROMOCION INTERNA' in texto or 'ACCESO LIBRE' in texto or 'TURNO LIBRE' in texto):
            if 'PROMOCION INTERNA' in texto:
                turno = 'interna'
            elif 'ACCESO LIBRE' in texto or 'TURNO LIBRE' in texto:
                turno = 'libre'
            if f and f[0] == '#P':
                continue
        ns = [float(c.replace(',', '.')) for c in f if NUM.match(c.strip())]
        ns = [n for n in ns if n <= 160]
        celdas_texto = [c for c in f if not NUM.match(c.strip()) and not re.fullmatch(r'[\d*.\-/]+[A-Z]?', c.strip())]
        nombre = normaliza(' '.join(celdas_texto))
        unido = ' '.join(f)
        identificador = bool(REGISTRO.search(unido) or re.search(r'\b\d{7,8}[A-Z]\b|\*{2,3}\d{3,5}\*{1,2}', unido))
        otro_cuerpo = re.search(r'\d{10}S(\d{4})', unido)
        if otro_cuerpo and otro_cuerpo.group(1) != '0601':
            continue
        es_persona = len(nombre.split()) >= 2 and (identificador or not re.search(r'APELLIDOS|NOMBRE|NOTA|ORDEN|DNI|REGISTRO|ANEXO|CUERPO|SECRETARIA|RESOLUCION|ARTICULO', nombre))
        if ns and es_persona:
            out[turno].append(max(ns))
            out[turno + '_n'] += 1
        elif es_persona and (REGISTRO.search(' '.join(f)) or re.search(r'\b\d{7,8}[A-Z]\b', ' '.join(f))):
            out[turno + '_n'] += 1
    return out


def leer_boe():
    """Convocatorias (plazas) y aprobados finales de cada convocatoria, según el BOE."""
    convocatorias, aprobados = {}, []
    for a in anuncios_boe():
        tipo = tipo_anuncio(a['titulo'])
        if tipo not in ('convocatoria', 'aprobados', 'practicas'):
            continue
        try:
            xml = xml_boe(a['id'])
        except Exception as e:
            print('  BOE', a['id'], 'no se pudo bajar:', str(e)[:60])
            continue
        txt = texto_boe(xml)
        if tipo == 'convocatoria':
            p = plazas_de_convocatoria(txt, ocr='<texto>' not in xml)
            if not p.get('libre'):
                m = re.search(r'(\d+) (?:vacantes|plazas)', numeros_en_cifra(a['titulo']))
                if m:
                    p['libre'] = int(m.group(1))
            fecha = fecha_texto(a['titulo'], a['id'].split('-')[2]) or a['fecha']
            p['ocr'] = '<texto>' not in xml
            if p.get('interna') and p.get('libre') and p['interna'] >= p['libre'] and p['ocr']:
                p.pop('interna')  # lectura dudosa (texto a dos columnas)
            convocatorias[fecha] = {'id': a['id'], 'fecha': fecha, 'publicado': a['fecha'], 'titulo': a['titulo'], **p}
        else:
            m = re.search(r'convocad[oa]s? (?:por|mediante) ((?:Orden|Resoluci[oó]n)[^,]{0,60},? de \d{1,2} de (?:' + MESES_RE + r')(?: de \d{4})?)', txt)
            if not m:
                m = re.search(r'(?:mediante|por) (Resoluci[oó]n de \d{1,2} de (?:' + MESES_RE + r') de \d{4}),? convoc', txt)
            if not m:
                m = re.search(r'convoc[oó] pruebas selectivas[^.]{0,200}?(Resoluci[oó]n[^.]{0,80}? de \d{1,2} de (?:' + MESES_RE + r') de \d{4})', txt)
            ref = fecha_texto(m.group(1), a['id'].split('-')[2]) if m else None
            if tipo == 'practicas':
                ref = None  # los nombramientos antiguos se leen por OCR a dos columnas: se fechan por su publicación
            notas = aprobados_de_boe(xml)
            aprobados.append({'id': a['id'], 'fecha': a['fecha'], 'tipo': tipo, 'titulo': a['titulo'], 'convocatoria': ref,
                              'libre': notas['libre_n'], 'interna': notas['interna_n'], 'notas_libre': notas['libre'], 'notas_interna': notas['interna']})
    return convocatorias, aprobados


def main():
    ap = argparse.ArgumentParser(description=__doc__.split('\n\n')[0])
    ap.add_argument('--solo-extraer', action='store_true', help='solo bajar y leer los PDF (caché)')
    ap.add_argument('--anio', type=int, action='append', help='solo estas convocatorias')
    ap.add_argument('--boe', action='store_true', help='solo leer el BOE y enseñar lo encontrado')
    ap.add_argument('--volcar', help='escribir los datos crudos (con nombres) en este fichero, fuera del repositorio')
    args = ap.parse_args()
    CACHE.mkdir(parents=True, exist_ok=True)
    if args.boe:
        conv, apr = leer_boe()
        for f, c in sorted(conv.items()):
            print('CONV', f, c.get('oep'), 'libre', c.get('libre'), 'disc', c.get('libre_discapacidad'), 'interna', c.get('interna'), '|', c['titulo'][:70])
        for a in apr:
            print('APR ', a['fecha'], a['tipo'], 'conv', a['convocatoria'], 'libre', a['libre'], 'interna', a['interna'], '|', a['titulo'][:80])
        return
    anios = args.anio or list(range(PRIMER_ANIO_MINISTERIO, 2027))
    crudo = {}
    for anio in anios:
        try:
            docs = documentos_ministerio(anio)
        except Exception as e:
            print(f'{anio}: sin página ({str(e)[:60]})')
            continue
        if not docs:
            print(f'{anio}: página sin documentos')
            continue
        print(f'{anio}: {len(docs)} documentos')
        crudo[anio] = leer_convocatoria_ministerio(anio, args.solo_extraer)
        if not args.solo_extraer:
            d = crudo[anio]
            print('   admitidos:', {k: v['n'] for k, v in d['admitidos'].items()})
            print('   ejercicios:', {k: {t: v['n'] for t, v in e.items()} for k, e in d['ejercicios'].items()})
            print('   conservan:', {k: (v['n'], v['ambos']) for k, v in d.get('conservan', {}).items()})
    if args.volcar:
        Path(args.volcar).write_text(json.dumps(crudo, ensure_ascii=False, indent=1, default=lambda o: dict(o)), encoding='utf-8')
    if args.solo_extraer:
        return
    sys.path.insert(0, str(RAIZ / 'scripts'))
    import cifras_pagina
    conv, apr = leer_boe()
    cifras_pagina.generar(crudo, conv, apr)


if __name__ == '__main__':
    main()
