#!/usr/bin/env python3
"""Índice de los apuntes de otros TCEE publicados en el repositorio de la ATCEE.

Lee las dos páginas públicas de la Asociación (la de recursos de atcee.es y el
«Repositorio de apuntes TCEE» de sites.google.com/view/apuntes-tcee, iniciado
por Luis de Fuentes), saca las promociones, los autores, sus notas y sus
enlaces (carpetas y ficheros de Google Drive, webs), lista cada carpeta de
Drive sin bajar nada y asigna a cada fichero el tema que le corresponde por su
nombre. Los materiales de otros autores no se copian nunca: solo se indexan y
se enlazan, para que la skill «EconomIA» y la web sepan qué apuntes
hay para cada tema y de quién son. Escribe:

  oposicion/temario/apuntes-otros.json                       registro público (lo lee la web)
  claude/prepara-con-claude/references/apuntes-otros.md      índice por tema para la skill
  oposicion/temario/app/skill/prepara-oposicion/references/apuntes-otros.md  la copia desplegada

Los apuntes anteriores a la promoción LXXIII (2024) siguen la numeración del
temario anterior (BOE-A-2022-8660 trajo la nueva): se marcan con
«numeracion: antigua». El bloque de publicidad que hay en la página del
repositorio no se indexa. Si una carpeta de Drive no es pública se anota el
error y se sigue; el script solo falla si no puede leer las páginas.

    python3 scripts/apuntes-otros.py                # todo (tarda unos minutos: lista cada carpeta)
    python3 scripts/apuntes-otros.py --sin-drive    # solo las páginas, sin listar carpetas (pruebas)
    python3 scripts/apuntes-otros.py --cache DIR    # guarda los listados de Drive en DIR y los reutiliza

Necesita gdown (pip install gdown) salvo con --sin-drive. Lo ejecuta cada
lunes la acción .github/workflows/apuntes-otros.yml.

Autor: Víctor Gutiérrez Marcos
"""
import argparse
import json
import os
import re
import sys
import unicodedata
import urllib.request
from datetime import date
from html.parser import HTMLParser
from pathlib import Path

RAIZ = Path(__file__).resolve().parent.parent
SALIDA_JSON = RAIZ / 'oposicion/temario/apuntes-otros.json'
SALIDA_MD = RAIZ / 'claude/prepara-con-claude/references/apuntes-otros.md'
SALIDA_MD_WEB = RAIZ / 'oposicion/temario/app/skill/prepara-oposicion/references/apuntes-otros.md'
TEMARIO = RAIZ / 'oposicion/temario/temario.json'

URL_ATCEE = 'https://atcee.es/la-oposicion-tcee/recursos_para_preparar_la_oposicion/'
URL_REPOSITORIO = 'https://sites.google.com/view/apuntes-tcee/'
URL_BOE = 'https://boe.es/boe/dias/2022/05/27/pdfs/BOE-A-2022-8660.pdf'
PRIMERA_PROMOCION_NUEVA = 2024  # LXXIII: la primera con el temario nuevo
EXTENSIONES = ('.docx', '.pdf', '.doc', '.pptx')  # además de los Docs y Presentaciones de Google
UA = ('Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 '
      '(KHTML, like Gecko) Chrome/124.0 Safari/537.36')
# Publicidad que hay en la página del repositorio y no se indexa
EXCLUIR = ('preparabot',)
# Enlaces del propio Google Sites (aviso de cookies, navegación), no del repositorio
EXCLUIR_ENLACES = ('google.com/policies', 'sites.google.com/', 'support.google.com')
LIMITE_MD = 200 * 1024
MAX_POR_AUTOR = 1  # ficheros por autor y tema en el índice (el resto, «+N en su carpeta»)

# Detrás del proxy del trabajo (intercepta TLS), su raíz junto a las del sistema.
_CAS = Path.home() / '.config/oposicion-red/cas.pem'
if _CAS.exists() and 'SSL_CERT_FILE' not in os.environ:
    os.environ['SSL_CERT_FILE'] = str(_CAS)


def avisar(texto):
    print(texto, file=sys.stderr)


def descargar(url):
    peticion = urllib.request.Request(url, headers={'User-Agent': UA, 'Accept-Language': 'es'})
    with urllib.request.urlopen(peticion, timeout=60) as r:
        return r.read().decode('utf-8', 'replace')


# ---------------------------------------------------------------------------
# Las páginas: bloques de texto con sus enlaces
# ---------------------------------------------------------------------------

class Bloques(HTMLParser):
    """Trocea la página en bloques (p, h1-h6, li) con su texto y sus enlaces.

    Cada bloque es {'etiqueta', 'texto', 'enlaces': [(texto, href, texto_previo)]}:
    texto_previo es lo que había en el bloque antes del enlace («Tercer
    ejercicio: »), para saber a qué ejercicio se refiere un «Parte A».
    """
    BLOQUE = ('p', 'h1', 'h2', 'h3', 'h4', 'h5', 'h6', 'li')

    def __init__(self):
        super().__init__(convert_charrefs=True)
        self.bloques = []
        self.actual = None
        self.href = None
        self.texto_enlace = []
        self.omitir = 0

    def handle_starttag(self, tag, attrs):
        a = dict(attrs)
        if tag in ('script', 'style', 'noscript'):
            self.omitir += 1
        elif tag in self.BLOQUE:
            self._cerrar()
            self.actual = {'etiqueta': tag, 'texto': [], 'enlaces': []}
        elif tag == 'a' and a.get('href'):
            if self.actual is None:
                self.actual = {'etiqueta': 'p', 'texto': [], 'enlaces': []}
            self.href = a['href']
            self.texto_enlace = []
        elif tag == 'br' and self.actual is not None:
            self.actual['texto'].append(' ')

    def handle_endtag(self, tag):
        if tag in ('script', 'style', 'noscript'):
            self.omitir = max(0, self.omitir - 1)
        elif tag == 'a' and self.href is not None:
            texto = limpiar(''.join(self.texto_enlace))
            previo = limpiar(''.join(self.actual['texto']))
            if texto:
                self.actual['enlaces'].append((texto, self.href, previo))
            self.actual['texto'].extend(self.texto_enlace)
            self.href = None
            self.texto_enlace = []
        elif tag in self.BLOQUE:
            self._cerrar()

    def handle_data(self, datos):
        if self.omitir:
            return
        if self.href is not None:
            self.texto_enlace.append(datos)
        elif self.actual is not None:
            self.actual['texto'].append(datos)

    def _cerrar(self):
        if self.actual is not None:
            texto = limpiar(''.join(self.actual['texto']))
            if texto or self.actual['enlaces']:
                self.bloques.append({'etiqueta': self.actual['etiqueta'], 'texto': texto,
                                     'enlaces': self.actual['enlaces']})
            self.actual = None

    def close(self):
        super().close()
        self._cerrar()


def limpiar(texto):
    return re.sub(r'\s+', ' ', texto.replace('\xa0', ' ')).strip()


def bloques_de(html):
    p = Bloques()
    p.feed(html)
    p.close()
    return p.bloques


def sin_correos(texto):
    """Los correos personales se quedan en el repositorio: aquí no se republican."""
    return re.sub(r'[\w.+-]+@[\w-]+\.[\w.-]+', '(correo en el repositorio)', texto)


def romano_a_entero(r):
    valores = {'I': 1, 'V': 5, 'X': 10, 'L': 50, 'C': 100}
    total = 0
    for i, c in enumerate(r):
        v = valores[c]
        total += -v if i + 1 < len(r) and valores[r[i + 1]] > v else v
    return total


# ---------------------------------------------------------------------------
# El repositorio de apuntes (sites.google.com)
# ---------------------------------------------------------------------------

RE_PROMOCION = re.compile(r'^PROMOCI[OÓ]N\s+([IVXLC]+)\s*\(\s*(\d{4})\s*\)', re.I)
RE_AUTOR = re.compile(r'^Apuntes de\s+(.+?)\s*$', re.I)


def recurso_de(etiqueta, href):
    href = href.strip()
    m = re.search(r'drive\.google\.com/drive/(?:u/\d+/)?folders/([\w-]+)', href)
    if m:
        return {'etiqueta': etiqueta, 'tipo': 'carpeta', 'id': m.group(1),
                'url': f'https://drive.google.com/drive/folders/{m.group(1)}'}
    m = re.search(r'drive\.google\.com/(?:file/d/|open\?id=)([\w-]+)', href)
    if m:
        return {'etiqueta': etiqueta, 'tipo': 'fichero', 'id': m.group(1),
                'url': f'https://drive.google.com/file/d/{m.group(1)}/view'}
    return {'etiqueta': etiqueta, 'tipo': 'web', 'id': None, 'url': href}


def leer_repositorio(html):
    """Promociones → autores → recursos, en el orden de la página."""
    promociones = []
    promocion = autor = None
    for b in bloques_de(html):
        texto = b['texto']
        if any(x in texto.lower() for x in EXCLUIR) or \
                any(x in h.lower() for _, h, _ in b['enlaces'] for x in EXCLUIR):
            continue
        m = RE_PROMOCION.match(texto)
        if m:
            promocion = {'promocion': m.group(1).upper(), 'anio': int(m.group(2)), 'autores': []}
            promociones.append(promocion)
            autor = None
            continue
        if promocion is None:
            continue  # la descripción y la publicidad van antes de la primera promoción
        m = RE_AUTOR.match(texto)
        if m and not b['enlaces']:
            autor = {'nombre': m.group(1), 'nota': '',
                     'numeracion': 'actual' if promocion['anio'] >= PRIMERA_PROMOCION_NUEVA else 'antigua',
                     'recursos': []}
            promocion['autores'].append(autor)
            continue
        if autor is None:
            continue
        if b['enlaces']:
            previo_etiqueta = None
            for texto_enlace, href, previo in b['enlaces']:
                if href.startswith('#') or any(x in href for x in EXCLUIR_ENLACES):
                    continue
                etiqueta = texto_enlace
                if previo_etiqueta and etiqueta[:1].islower():
                    # «[Simulacro del primer ejercicio] con [soluciones]»
                    etiqueta = f'{previo_etiqueta}: {etiqueta}'
                elif previo.endswith(':'):
                    # «Tercer ejercicio: [Parte A]. [Parte B]»
                    etiqueta = f'{previo[:-1].strip()} · {etiqueta}'
                elif previo_etiqueta and b['texto'].split(etiqueta)[0].rstrip().endswith('.'):
                    prefijo = previo_etiqueta.split(' · ')[0]
                    if prefijo != previo_etiqueta:
                        etiqueta = f'{prefijo} · {etiqueta}'
                autor['recursos'].append(recurso_de(etiqueta, href))
                previo_etiqueta = etiqueta
        elif texto:
            autor['nota'] = (autor['nota'] + ' ' + texto).strip()
    for p in promociones:
        for a in p['autores']:
            a['nota'] = sin_correos(a['nota'])
    return promociones


# ---------------------------------------------------------------------------
# La página de recursos de la ATCEE: manuales y documentos
# ---------------------------------------------------------------------------

def leer_atcee(html):
    bloques = bloques_de(html)
    fuentes = {'atcee': URL_ATCEE, 'repositorio': URL_REPOSITORIO, 'boe_temario': URL_BOE}
    manuales = []
    en_manuales = False
    bloque_actual = None
    for b in bloques:
        texto = b['texto']
        for texto_enlace, href, _ in b['enlaces']:
            if 'orientativo' in texto_enlace.lower():
                fuentes['documento_orientativo'] = recurso_de(texto_enlace, href)['url']
            elif 'icex-ceco' in texto_enlace.lower() or 'icex-ceco.es' in href:
                fuentes['icex_ceco'] = href
        if b['etiqueta'].startswith('h'):
            en_manuales = 'manuales' in texto.lower()
            bloque_actual = None
            continue
        if not en_manuales or not texto:
            continue
        if texto == texto.upper() and len(texto) > 4 and not re.search(r'\d', texto):
            bloque_actual = {'bloque': texto.capitalize().replace(' y ', ' y '), 'manuales': []}
            bloque_actual['bloque'] = titulo_bloque(texto)
            manuales.append(bloque_actual)
        elif bloque_actual is not None:
            entrada = {'cita': texto}
            if b['enlaces']:
                entrada['url'] = b['enlaces'][0][1]
            bloque_actual['manuales'].append(entrada)
    return fuentes, manuales


def titulo_bloque(texto):
    """«ECONOMÍA DEL SECTOR PÚBLICO» → «Economía del sector público»."""
    return texto[:1].upper() + texto[1:].lower()


# ---------------------------------------------------------------------------
# Google Drive: listar carpetas y asignar temas
# ---------------------------------------------------------------------------

def codigo_de_ruta(ruta):
    """Código de tema (3A08) a partir de la ruta de un fichero de Drive, o None.

    Copiada de scripts/temario/indexar-referencias.py (rama revision-temario).
    """
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


def codigo_con_carpeta(ruta):
    """Como codigo_de_ruta, y si no sale, la parte viene de la carpeta («Parte A»)
    y el número del nombre («Tema 12», «12.», «T12»)."""
    cod = codigo_de_ruta(ruta)
    if cod:
        return cod
    partes = ruta.replace('\\', '/').split('/')
    nombre = partes[-1]
    ejercicio = letra = None
    for p in partes[:-1]:
        m = re.match(r'^\s*([34])(?:o|º|\.º|er|\s|$)', p, re.I) or re.search(r'(tercer|cuarto)', p, re.I)
        if m:
            g = m.group(1).lower()
            ejercicio = {'tercer': '3', 'cuarto': '4'}.get(g, g)
        m = re.search(r'\bParte[\s_]?([AB])\b', p, re.I) or re.match(r'^\s*([AB])\b', p, re.I)
        if m:
            letra = m.group(1).upper()
    if not (ejercicio and letra):
        return None
    m = re.search(r'(?:Tema|T)\s*\.?\s*(\d{1,2})(?!\d)', nombre, re.I) or re.match(r'^\s*(\d{1,2})(?:[.\s)-]|$)', nombre)
    if m:
        return f'{ejercicio}{letra}{int(m.group(1)):02d}'
    return None


def codigo_de_fichero(ruta):
    """Código de tema de un fichero del repositorio: lo de arriba y, en el cuarto
    ejercicio, los nombres con las letras C y D del temario anterior («8D», «Copia
    de 30C»: C era la parte A y D la parte B); en el quinto, «5B_1»."""
    partes = ruta.replace('\\', '/').split('/')
    nombre = partes[-1]
    m = re.search(r'(?<![\w.])5[._]?\s?([ABC])[._]?\s?(\d{1,2})(?!\d)', nombre, re.I)
    if m:  # quinto ejercicio: «5B_1 Métodos de regresión»
        return f'5{m.group(1).upper()}{int(m.group(2)):02d}'
    m = re.search(r'(?<!\w)([345])[_-](\d{1,2})\s?([ABC])(?![a-z0-9])', nombre, re.I)
    if m:  # «4_10A-esquema_v02.doc»
        return f'{m.group(1)}{m.group(3).upper()}{int(m.group(2)):02d}'
    if any(re.search(r'quinto|^\s*5(?:o|º|\.º)?\b', p, re.I) for p in partes[:-1]):
        m = re.search(r'(?<![\w.])(\d{1,2})\s?([ABC])(?![\w])', nombre, re.I) or \
            re.search(r'(?<![\w])([ABC])\.?\s?(\d{1,2})(?!\d)', nombre, re.I)
        if m:  # «DERECHO ADMINISTRATIVO/10C»
            a, b = m.groups()
            letra, num = (a, b) if a.isalpha() else (b, a)
            return f'5{letra.upper()}{int(num):02d}'
    cod = codigo_con_carpeta(ruta)
    if cod:
        return cod
    if not any(re.search(r'cuarto|^\s*4(?:o|º|\.º)?\b', p, re.I) for p in partes[:-1]):
        return None
    m = re.search(r'(?<![\w.])(\d{1,2})\s?([CD])(?![\w])', partes[-1], re.I) or \
        re.search(r'(?<![\w])([CD])\.?\s?(\d{1,2})(?!\d)', partes[-1], re.I)
    if m:
        a, b = m.groups()
        letra, num = (a, b) if a.isalpha() else (b, a)
        return f'4{"A" if letra.upper() == "C" else "B"}{int(num):02d}'
    return None


VACIAS = set('de del la las el los y en a o u e con por para su sus al lo un una sobre e i ii iii iv v'.split())


def palabras(texto):
    texto = re.sub(r'[\u0300-\u036f]', '', unicodedata.normalize('NFD', texto.lower()))
    return {w for w in re.findall(r'[a-z0-9]{3,}', texto) if w not in VACIAS}


def tema_por_titulo(nombre, ejercicio, temas):
    """Tema cuyo título oficial más se parece al nombre del fichero («Tema 10.
    Teoría de los costes. Análisis de la dualidad» → 3A12), dentro del
    ejercicio que dice la carpeta; None si no se parece bastante."""
    base = re.sub(r'\.(docx|pdf|doc|pptx)$', '', nombre.rsplit('/', 1)[-1], flags=re.I)
    base = re.sub(r'^\s*(Tema|T)?\s*\d{1,2}\s*[.\-)]?\s*', '', base, flags=re.I)
    mias = palabras(base)
    if len(mias) < 2:
        return None
    mejor, puntos = None, 0
    for cod, _, titulo in temas:
        if cod[0] != ejercicio:
            continue
        suyas = palabras(titulo)
        comunes = len(mias & suyas)
        p = comunes / len(mias)
        if p > puntos:
            mejor, puntos = cod, p
    return mejor if puntos >= 0.6 and len(mias) >= 2 else None


def etiqueta_a_ruta(etiqueta):
    """Prefijo de ruta con el ejercicio (y la parte) que dice la etiqueta del
    enlace, para que el código salga aunque los nombres no lo lleven."""
    e = etiqueta.lower()
    tercer, cuarto = 'tercer' in e, 'cuarto' in e
    if tercer == cuarto:  # ninguno, o «Tercer y cuarto ejercicio»: no se sabe
        return ''
    ruta = 'Tercer ejercicio' if tercer else 'Cuarto ejercicio'
    m = re.search(r'parte\s+([ab])\b', e)
    if m:
        ruta += f'/Parte {m.group(1).upper()}'
    return ruta + '/'


GOOGLE_NATIVOS = ('application/vnd.google-apps.document', 'application/vnd.google-apps.presentation')


def listar_carpeta(fid, cache):
    """[{nombre, id, tipo}] de una carpeta de Drive (sin bajar nada), o lanza error.

    Usa las funciones internas de gdown que leen la vista de la carpeta
    (download_folder con skip_download «baja» igualmente los Docs nativos de
    Google para saber su nombre de exportación, y con decenas de Docs no acaba).
    Si gdown cambia, cae a download_folder.
    """
    fichero_cache = cache / f'{fid}.json' if cache else None
    if fichero_cache and fichero_cache.exists():
        return json.loads(fichero_cache.read_text(encoding='utf-8'))
    import gdown  # solo hace falta con Drive
    try:
        # gdown/__init__ exporta la función download_folder con el nombre del módulo
        gdf = sys.modules['gdown.download_folder']
        sess, _ = gdf._get_session(proxy=None, use_cookies=False, user_agent=UA, cookies_file=None)
        raiz = gdf._download_and_parse_google_drive_link(sess=sess, folder_id=fid, quiet=True,
                                                        verify=True, timeout=60)
        lista = [{'nombre': ruta.replace('\\', '/'), 'id': f.id, 'tipo': f.type}
                 for f, ruta in gdf._get_directory_structure(gdrive_file=raiz, previous_path='')
                 if f is not None and not f.is_folder()]
    except (AttributeError, TypeError):  # otra versión de gdown sin esas funciones
        ficheros = gdown.download_folder(id=fid, skip_download=True, quiet=True, timeout=60)
        lista = [{'nombre': f.path.replace('\\', '/'), 'id': f.id, 'tipo': ''} for f in ficheros]
    if fichero_cache:
        cache.mkdir(parents=True, exist_ok=True)
        fichero_cache.write_text(json.dumps(lista, ensure_ascii=False, indent=1), encoding='utf-8')
    return lista


def completar_drive(promociones, cache, sin_drive, temas):
    cifras = {'carpetas': 0, 'privadas': 0, 'con_tema': 0, 'por_titulo': 0, 'sin_tema': 0}
    for p in promociones:
        for a in p['autores']:
            for r in a['recursos']:
                if r['tipo'] != 'carpeta':
                    continue
                if sin_drive:
                    r['ficheros'] = []
                    continue
                prefijo = etiqueta_a_ruta(r['etiqueta'])
                try:
                    lista = listar_carpeta(r['id'], cache)
                except Exception as e:  # carpeta privada, cuota, red…
                    r['error'] = f'{type(e).__name__}: {str(e).splitlines()[0][:160]}'
                    r['ficheros'] = []
                    cifras['privadas'] += 1
                    avisar(f'  {a["nombre"]} · {r["etiqueta"]}: {r["error"]}')
                    continue
                cifras['carpetas'] += 1
                ficheros = []
                for f in sorted(lista, key=lambda x: (x['nombre'].lower(), x['id'])):
                    base = f['nombre'].rsplit('/', 1)[-1]
                    tipo = f.get('tipo', '')
                    if base.startswith('~$'):
                        continue
                    if tipo.startswith('application/vnd.google-apps.'):
                        if tipo not in GOOGLE_NATIVOS:  # hojas de cálculo, formularios…
                            continue
                    elif not base.lower().endswith(EXTENSIONES) and (tipo or '.' in base):
                        continue  # sin tipo conocido, los nombres sin extensión se toman por Docs
                    cod = codigo_de_fichero(prefijo + f['nombre'])
                    entrada = {'nombre': f['nombre'], 'id': f['id'], 'tema': cod}
                    if not cod and prefijo:
                        cod = tema_por_titulo(f['nombre'], prefijo[0] if prefijo[0].isdigit() else
                                              {'T': '3', 'C': '4'}[prefijo[0]], temas)
                        if cod:
                            entrada.update(tema=cod, tema_por='titulo')
                            cifras['por_titulo'] += 1
                    ficheros.append(entrada)
                    cifras['con_tema' if cod else 'sin_tema'] += 1
                r['ficheros'] = ficheros
    return cifras


# ---------------------------------------------------------------------------
# Los temas del temario
# ---------------------------------------------------------------------------

def temas_del_temario():
    """[(código 3A08, «3.A.8», título)] de los ejercicios 3.º, 4.º y 5.º, en orden."""
    temario = json.loads(TEMARIO.read_text(encoding='utf-8'))
    temas = []
    for e in temario['ejercicios']:
        if str(e.get('id')) not in ('3', '4', '5'):
            continue
        for parte in e['partes']:
            for t in parte['temas']:
                m = re.fullmatch(r'([345])\.([ABC])\.(\d+)', t['codigo'])
                if m:
                    temas.append((f'{m.group(1)}{m.group(2)}{int(m.group(3)):02d}', t['codigo'], t['titulo']))
    return temas


def codigo_largo(cod):
    return f'{cod[0]}.{cod[1]}.{int(cod[2:])}'


# ---------------------------------------------------------------------------
# Salidas
# ---------------------------------------------------------------------------

def escribir_json(datos):
    texto = json.dumps(datos, ensure_ascii=False, indent=1) + '\n'
    SALIDA_JSON.write_text(texto, encoding='utf-8')


def nombre_corto(nombre, maximo=70):
    base = nombre.rsplit('/', 1)[-1]
    base = re.sub(r'\.(docx|pdf|doc|pptx)$', '', base, flags=re.I).strip(' .')
    base = re.sub(r'\s+', ' ', base)
    if len(base) > maximo:
        base = base[:maximo - 1].rstrip() + '…'
    return base.replace('[', '(').replace(']', ')').replace('|', '/')


def orden_fichero(nombre):
    """Primero el fichero que es el tema («TEMA 12A…», «3A_12…», «12A-esquema»), luego
    los que lo mencionan («Gráfico Tema 12 A») y al final anexos y bibliografía."""
    base = nombre.rsplit('/', 1)[-1].lower()
    if re.match(r'^\s*(tema\b|copia de\s*\d|\d{1,2}\s?[abcd]\b|[345][._ -]?[abc]\b|[345][._ -]?[abc][._ -]?\d|[abcd][._ -]\s?\d|t\s?\d)', base):
        return (0, base)
    if 'tema' in base:
        return (1, base)
    return (2, base)


def apellido(nombre):
    """Apellido para el índice por tema: «Marta Ramírez Rodríguez de Sepúlveda» → «Ramírez», «Luis de Fuentes» → «de Fuentes»."""
    partes = nombre.split()
    if len(partes) < 2:
        return nombre
    if partes[1].lower() in ('de', 'del', 'de la', 'la') and len(partes) > 2:
        return ' '.join(partes[1:3])
    return partes[1]


def apellidos_unicos(promociones):
    """{nombre: apellido}, con el nombre entero si dos autores comparten apellido."""
    nombres = [a['nombre'] for p in promociones for a in p['autores']]
    cortos = {nb: apellido(nb) for nb in nombres}
    repetidos = {c for c in cortos.values() if list(cortos.values()).count(c) > 1}
    return {nb: (nb if c in repetidos else c) for nb, c in cortos.items()}


def escribir_md(datos, temas):
    hoy = datos['generado']
    L = []
    L.append('# Apuntes de otros TCEE: el repositorio de la ATCEE')
    L.append('')
    L.append(f'<!-- Lo genera scripts/apuntes-otros.py (cada lunes, acción apuntes-otros.yml); generado el {hoy}. No se edita a mano. -->')
    L.append('')
    L.append('## Qué es')
    L.append('')
    L.append(f'La Asociación de Técnicos Comerciales y Economistas del Estado (ATCEE) mantiene un **[repositorio de apuntes]({URL_REPOSITORIO})**, '
             'iniciado por Luis de Fuentes (promoción LXXI), con los temas que varios TCEE usaron para preparar el tercer y el cuarto ejercicio y comparten gratis '
             'una vez aprobada la oposición (la tradición la empezaron Miguel Tiana y Tomás Nasarre y la impulsaron las webs de Alfonso Sahuquillo y Miguel Fabián). '
             f'La ATCEE lo enlaza desde su [página de recursos]({URL_ATCEE}), donde además recomienda como referencia principal el temario de ICEX-CECO (de pago) '
             'y publica un «documento orientativo» con las similitudes y diferencias entre el temario anterior y el actual, una estructura orientativa de cada tema y bibliografía'
             + (f' ([Drive]({datos["fuentes"]["documento_orientativo"]}))' if datos['fuentes'].get('documento_orientativo') else '') + '.')
    L.append('')
    L.append('Advertencia de la propia ATCEE: los apuntes «no son condición necesaria ni suficiente para aprobar la oposición a TCEE. '
             'Estos documentos son apuntes personales que pueden contener inexactitudes o datos desactualizados pero que, con todo, son recursos de gran utilidad para el opositor a TCEE».')
    L.append('')
    L.append('## Cómo usar este índice')
    L.append('')
    L.append('- **Son materiales de otros autores: no copies ni reproduzcas su texto**, ni lo presentes como si fuera del temario. Puedes leerlos para valorarlos, compararlos y explicar su enfoque (con el conector, la herramienta `leer_fuente`; sin él, si el opositor te los pasa o puedes abrir el enlace): resume con tus palabras y cita siempre al autor y la promoción.')
    L.append('- Sirve para **decirle al opositor qué apuntes existen para el tema que prepara**, de quién son y de qué promoción, con el enlace directo, '
             'para que los contraste él. Cuando un tema no está revisado en `references/temas/`, es la mejor pista de dónde mirar.')
    L.append(f'- **Numeración antigua.** Los apuntes anteriores a la promoción LXXIII ({PRIMERA_PROMOCION_NUEVA}) siguen el temario anterior: el número del fichero puede no '
             'coincidir con el tema actual (el antiguo 3.A.11 es el actual 3.A.15; el 3A_6 «Teoría neoclásica de la demanda» de Luis de Fuentes es el actual 3.A.8). '
             f'Con esos autores, comprueba siempre por el **título** (`references/temario/programa-tcee.md` tiene los títulos oficiales y el [BOE]({URL_BOE}) el temario nuevo). '
             'En el índice por tema van en una línea aparte.')
    L.append('- **Mandan los temas revisados de la skill** (`references/temas/`): si unos apuntes dicen otra cosa, se corrige con el tema revisado y, si la duda es seria, se le dice al opositor que lo contraste.')
    L.append('- Cita siempre al autor y a la promoción al mencionar unos apuntes («los apuntes de Cristina Roca, LXXII»).')
    L.append('- Las notas de cada autor (qué fuentes usó, hasta cuándo están actualizados, si son esquemáticos o largos) están en la tabla de autores: léelas antes de recomendar unos u otros.')
    L.append('')

    # Índice por tema
    por_tema = {}
    for p in datos['promociones']:
        for a in p['autores']:
            for r in a['recursos']:
                for f in r.get('ficheros', []):
                    if f['tema']:
                        por_tema.setdefault(f['tema'], []).append((a, p, f, r))
    L.append('## Índice por tema')
    L.append('')
    L.append('Para cada tema, por autor (apellido y promoción; la tabla de autores está más abajo), el fichero que lleva su número en el nombre; si el autor tiene varios para ese tema, '
             'el primero y «+N» (el resto está en su carpeta). «Actual»: numeración del temario vigente, o tema reconocido por el título. '
             '«Antigua»: el número es el del temario anterior y puede ser otro tema: comprobar por el título.')
    cortos = apellidos_unicos(datos['promociones'])
    L.append('')
    bloques = [('3A', 'Tercer ejercicio · Parte A: Economía general'),
               ('3B', 'Tercer ejercicio · Parte B: Economía financiera, internacional y relaciones económicas internacionales'),
               ('4A', 'Cuarto ejercicio · Parte A: Economía española'),
               ('4B', 'Cuarto ejercicio · Parte B: Economía del sector público'),
               ('5A', 'Quinto ejercicio · Parte A: Marketing internacional y técnicas comerciales'),
               ('5B', 'Quinto ejercicio · Parte B: Econometría'),
               ('5C', 'Quinto ejercicio · Parte C: Derecho administrativo y organización del Estado')]
    conocidos = {cod for cod, _, _ in temas}
    for prefijo, titulo in bloques:
        L.append(f'### {titulo}')
        L.append('')
        lista = [(cod, largo, tit) for cod, largo, tit in temas if cod.startswith(prefijo)]
        extra = sorted(c for c in por_tema if c.startswith(prefijo) and c not in conocidos)
        for cod, largo, tit in lista + [(c, codigo_largo(c), '(número fuera del temario actual)') for c in extra]:
            L.append(f'#### {largo} {nombre_corto(tit, 90)}')
            L.append('')
            entradas = por_tema.get(cod, [])
            if not entradas:
                L.append('- Sin apuntes con este número en el repositorio.')
                L.append('')
                continue
            grupos = {}  # (autor, numeración) -> ficheros, en orden
            for a, p, f, r in entradas:
                clave = 'actual' if a['numeracion'] == 'actual' or f.get('tema_por') == 'titulo' else 'antigua'
                grupos.setdefault((clave, a['nombre']), []).append((a, p, f, r))
            for numeracion, rotulo in (('actual', 'Actual'), ('antigua', 'Antigua')):
                trozos = []
                for (clave, nombre), lista in grupos.items():
                    if clave != numeracion:
                        continue
                    a, p, _, r = lista[0]
                    quien = f'{cortos[a["nombre"]]} ({p["promocion"]}'
                    quien += ', por el título)' if lista[0][2].get('tema_por') == 'titulo' else ')'
                    enlaces = []
                    # Primero el tema en sí («TEMA 13A…», «3A_13…»); después anexos y bibliografía
                    lista.sort(key=lambda x: orden_fichero(x[2]['nombre']))
                    mas = f' +{len(lista) - MAX_POR_AUTOR}' if len(lista) > MAX_POR_AUTOR else ''
                    f = lista[0][2]
                    url = f'https://drive.google.com/file/d/{f["id"]}/view'
                    if numeracion == 'actual' and not f.get('tema_por'):
                        trozos.append(f'[{quien}]({url}){mas}')
                    else:
                        trozos.append(f'{quien}: [{nombre_corto(f["nombre"], 32)}]({url}){mas}')
                if trozos:
                    L.append(f'- {rotulo}: ' + ' · '.join(trozos))
            L.append('')

    # Autores por promoción
    L.append('## Autores por promoción')
    L.append('')
    L.append('| Promoción | Autor | Numeración | Nota | Carpetas y enlaces |')
    L.append('|---|---|---|---|---|')
    for p in datos['promociones']:
        for a in p['autores']:
            enlaces = []
            for r in a['recursos']:
                e = f'[{r["etiqueta"]}]({r["url"]})'
                if r['tipo'] == 'carpeta':
                    n = len(r.get('ficheros', []))
                    e += ' (no pública)' if r.get('error') else (f' ({n} ficheros)' if n else '')
                enlaces.append(e)
            nota = a['nota'].replace('|', '/')
            if len(nota) > 400:
                nota = nota[:399].rstrip() + '…'
            L.append(f'| {p["promocion"]} ({p["anio"]}) | {a["nombre"]} | {a["numeracion"]} | {nota} | {"; ".join(enlaces)} |')
    L.append('')

    # Manuales
    L.append('## Manuales recomendados por la ATCEE')
    L.append('')
    L.append(f'Para el tercer y el cuarto ejercicio, según la [página de recursos de la ATCEE]({URL_ATCEE}).')
    L.append('')
    for b in datos['manuales']:
        L.append(f'### {b["bloque"]}')
        L.append('')
        for m in b['manuales']:
            L.append(f'- [{m["cita"]}]({m["url"]})' if m.get('url') else f'- {m["cita"]}')
        L.append('')

    # Webs
    webs = []
    for p in datos['promociones']:
        for a in p['autores']:
            for r in a['recursos']:
                if r['tipo'] == 'web' and 'victorgutierrezmarcos.es' not in r['url']:
                    webs.append((a, p, r))  # la web de esta skill no se lista a sí misma
    if webs:
        L.append('## Webs de otros TCEE')
        L.append('')
        L.append('Además de victorgutierrezmarcos.es (promoción LXXIII), la web de esta skill, el repositorio enlaza estas webs:')
        L.append('')
        for a, p, r in webs:
            L.append(f'- {a["nombre"]} ({p["promocion"]}): [{r["etiqueta"]}]({r["url"]})')
        L.append('')
    texto = '\n'.join(L)
    if len(texto.encode('utf-8')) > LIMITE_MD:
        avisar(f'AVISO: apuntes-otros.md ocupa {len(texto.encode("utf-8")) // 1024} KB, más de {LIMITE_MD // 1024} KB')
    for destino in (SALIDA_MD, SALIDA_MD_WEB):
        destino.parent.mkdir(parents=True, exist_ok=True)
        destino.write_text(texto, encoding='utf-8')
    return len(texto.encode('utf-8'))


def main():
    ap = argparse.ArgumentParser(description=__doc__.split('\n\n')[0])
    ap.add_argument('--sin-drive', action='store_true', help='no lista las carpetas de Drive (solo las páginas)')
    ap.add_argument('--cache', metavar='DIR', help='guarda y reutiliza los listados de Drive en DIR')
    args = ap.parse_args()
    cache = Path(args.cache).expanduser() if args.cache else None

    print('Leyendo el repositorio de apuntes y la página de la ATCEE…')
    promociones = leer_repositorio(descargar(URL_REPOSITORIO))
    fuentes, manuales = leer_atcee(descargar(URL_ATCEE))
    autores = sum(len(p['autores']) for p in promociones)
    if not promociones or autores < 5:
        sys.exit(f'ERROR: solo se han reconocido {autores} autores en {len(promociones)} promociones: ¿ha cambiado la página?')
    if not manuales:
        avisar('AVISO: no se han encontrado los manuales recomendados en la página de la ATCEE')

    print(f'{autores} autores en {len(promociones)} promociones; '
          f'{sum(1 for p in promociones for a in p["autores"] for r in a["recursos"] if r["tipo"] == "carpeta")} carpetas de Drive')
    if not args.sin_drive:
        print('Listando las carpetas de Drive…')
    temas = temas_del_temario()
    cifras = completar_drive(promociones, cache, args.sin_drive, temas)

    datos = {
        'generado': date.today().isoformat(),
        'aviso': 'Índice de apuntes de otros TCEE publicados por la ATCEE: solo nombres de fichero y enlaces, sin contenido. '
                 'Los apuntes son de sus autores y no son condición necesaria ni suficiente para aprobar.',
        'fuentes': fuentes,
        'url_fichero': 'https://drive.google.com/file/d/{id}/view',
        'primera_promocion_numeracion_actual': PRIMERA_PROMOCION_NUEVA,
        'manuales': manuales,
        'promociones': promociones,
    }
    escribir_json(datos)
    tam = escribir_md(datos, temas)
    print(f'Carpetas listadas: {cifras["carpetas"]}; no públicas: {cifras["privadas"]}; '
          f'ficheros con tema: {cifras["con_tema"]} (por el título: {cifras["por_titulo"]}); sin tema: {cifras["sin_tema"]}')
    print(f'Escritos {SALIDA_JSON.relative_to(RAIZ)}, {SALIDA_MD.relative_to(RAIZ)} y la copia desplegada ({tam // 1024} KB)')


if __name__ == '__main__':
    main()
