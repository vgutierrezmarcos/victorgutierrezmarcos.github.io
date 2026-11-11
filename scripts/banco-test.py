#!/usr/bin/env python3
"""
Banco de preguntas de test NO oficiales de EconomIA: valida las preguntas, dice cuántas
tocan a cada tema y las publica para el conector.

Hay tres tipos de pregunta de test, por este orden de preferencia:
  1. Oficiales: las de los exámenes (oposicion/temario/primer-ejercicio/test/preguntas.json). Públicas.
  2. Del banco: las de aquí. No oficiales, pero revisadas y con explicación. Material exclusivo:
     no se sirven sin sesión (el conector las lee de su KV; la fuente vive en la rama de revisión).
  3. Generadas al vuelo por la IA del usuario: sin revisar; no pasan por aquí.

La fuente es un JSON por tema en la rama revision-temario, carpeta banco-test/ (3A08.json):

    { "tema": "3.A.8",
      "preguntas": [
        { "id": 310801,                      # E P TT NN: ejercicio, parte (A=1, B=2), tema y número. No se reutiliza nunca.
          "estado": "publicada",             # borrador | publicada | retirada (solo salen las publicadas)
          "enunciado": "…",                  # fórmulas en LaTeX entre $…$, como las oficiales
          "opciones": {"a": "…", "b": "…", "c": "…", "d": "…"},
          "respuesta": ["b"],                # una sola
          "explicacion": {"clave": "dos o tres frases", "desarrollo": "el razonamiento completo"},
          "dificultad": 2,                   # 1 fácil, 2 media, 3 difícil, calibrada con las oficiales del tema
          "apartado": "II.2 Ecuación de Slutsky",   # de dónde sale en el tema
          "creada": "2026-11-11", "revisada": "2026-11-11",
          "vigencia": "estable",             # o «revisar-AAAA-MM» si depende de un dato o una norma que cambia
          "imagenes": [{"src": "https://…", "alt": "descripción con la que se puede contestar", "ancho": 600}]   # opcional
        } ] }

Cuántas por tema: el banco guarda la proporción de los exámenes oficiales (un tema que cae mucho
tiene más preguntas; uno que casi no cae, pocas), para que un test con preguntas del banco se
parezca a un examen. `--cupos` enseña el reparto para un total (por defecto 900).

    python3 scripts/banco-test.py                 # valida y resume
    python3 scripts/banco-test.py --cupos         # cuántas tocan a cada tema y cuántas hay
    python3 scripts/banco-test.py --publicar      # valida y sube banco/preguntas.json al KV del conector

Autor: Víctor Gutiérrez Marcos
"""
import argparse
import json
import os
import re
import subprocess
import sys
import tempfile
import unicodedata
from collections import Counter
from datetime import date

RAIZ = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
ORIGEN = RAIZ + '-revision/banco-test'
OFICIALES = os.path.join(RAIZ, 'oposicion', 'temario', 'primer-ejercicio', 'test', 'preguntas.json')
WORKER = os.path.join(RAIZ, 'mcp', 'worker')
TOKEN = os.path.expanduser('~/.config/oposicion-red/cloudflare.token')
CLAVE_KV = 'banco/preguntas.json'
TOTAL = 900
MINIMO = 2  # ningún tema se queda sin preguntas
AVISO = ('Preguntas NO oficiales del banco de EconomIA (victorgutierrezmarcos.es), de Víctor Gutiérrez Marcos: material exclusivo, '
         'para la preparación personal de quien lo usa. No han salido en ningún examen.')
LETRAS = ['a', 'b', 'c', 'd']


def oficiales():
    with open(OFICIALES, encoding='utf-8') as f:
        d = json.load(f)
    return d['preguntas'] if isinstance(d, dict) else d


def cupos(total=TOTAL):
    """Preguntas del banco que tocan a cada tema: en proporción a las oficiales de ese tema (su tema principal)."""
    cuenta = Counter(p['temas'][0] for p in oficiales() if p.get('temas') and p.get('respuesta'))
    suma = sum(cuenta.values())
    return {t: max(MINIMO, round(total * n / suma)) for t, n in cuenta.items()}, cuenta


def orden(tema):
    e, p, n = tema.split('.')
    return int(e), p, int(n)


def id_base(tema):
    """«3.A.8» → 310800: las preguntas del tema van de 310801 a 310899."""
    e, p, n = tema.split('.')
    return int(e) * 100_000 + (ord(p) - ord('A') + 1) * 10_000 + int(n) * 100


def llano(texto):
    t = unicodedata.normalize('NFKD', texto.lower())
    return re.sub(r'[^a-z0-9]+', ' ', ''.join(c for c in t if not unicodedata.combining(c))).strip()


def leer(origen):
    """(preguntas publicadas, errores, recuento por tema y estado)."""
    errores, salida, recuento = [], [], {}
    enunciados = {llano(p['enunciado']): f'oficial {p["id"]}' for p in oficiales() if p.get('enunciado')}
    vistos = set()
    if not os.path.isdir(origen):
        return [], [], {}
    for nombre in sorted(os.listdir(origen)):
        if not re.fullmatch(r'\d[A-Z]\d\d\.json', nombre):
            continue
        with open(os.path.join(origen, nombre), encoding='utf-8') as f:
            try:
                d = json.load(f)
            except json.JSONDecodeError as e:
                errores.append(f'{nombre}: JSON mal formado ({e})')
                continue
        tema = d.get('tema', '')
        if not re.fullmatch(r'\d\.[A-Z]\.\d{1,2}', tema) or nombre != f'{tema[0]}{tema[2]}{int(tema.split(".")[2]):02d}.json':
            errores.append(f'{nombre}: «tema» ({tema!r}) no casa con el nombre del fichero')
            continue
        base = id_base(tema)
        recuento[tema] = Counter()
        for p in d.get('preguntas', []):
            donde = f'{nombre} id {p.get("id")}'
            mal = []
            i = p.get('id')
            if not isinstance(i, int) or not base < i < base + 100:
                mal.append(f'el id debe ir de {base + 1} a {base + 99}')
            elif i in vistos:
                mal.append('id repetido')
            vistos.add(i)
            estado = p.get('estado')
            if estado not in ('borrador', 'publicada', 'retirada'):
                mal.append('«estado» debe ser borrador, publicada o retirada')
            recuento[tema][estado] += 1
            enunciado = p.get('enunciado') or ''
            if not 20 <= len(enunciado) <= 1500:
                mal.append('enunciado de 20 a 1500 caracteres')
            clave = llano(enunciado)
            if clave in enunciados and estado != 'retirada':
                mal.append(f'mismo enunciado que {enunciados[clave]}')
            enunciados.setdefault(clave, donde)
            op = p.get('opciones') or {}
            if sorted(op) != LETRAS or not all(isinstance(v, str) and 1 <= len(v) <= 400 for v in op.values()):
                mal.append('cuatro opciones (a, b, c y d) de 1 a 400 caracteres')
            elif len({llano(v) for v in op.values()}) < 4:
                mal.append('dos opciones iguales')
            r = p.get('respuesta')
            if not isinstance(r, list) or len(r) != 1 or r[0] not in LETRAS:
                mal.append('«respuesta» es una lista con una sola letra')
            ex = p.get('explicacion') or {}
            if not 20 <= len(ex.get('clave') or '') <= 600 or len(ex.get('desarrollo') or '') < 40:
                mal.append('explicación con «clave» (20-600 caracteres) y «desarrollo»')
            if p.get('dificultad') not in (1, 2, 3):
                mal.append('«dificultad» de 1 a 3')
            if not p.get('apartado'):
                mal.append('falta «apartado» (de dónde sale en el tema)')
            for campo in ('creada', 'revisada'):
                try:
                    date.fromisoformat(p.get(campo) or '')
                except ValueError:
                    mal.append(f'«{campo}» con formato AAAA-MM-DD')
            if not re.fullmatch(r'estable|revisar-\d{4}-\d\d', p.get('vigencia') or ''):
                mal.append('«vigencia»: estable o revisar-AAAA-MM')
            for img in p.get('imagenes') or []:
                if not str(img.get('src', '')).startswith('https://') or len(img.get('alt') or '') < 20:
                    mal.append('cada imagen lleva «src» (https) y un «alt» con el que se pueda contestar')
            if (enunciado + ''.join(op.values()) if isinstance(op, dict) else '').count('$') % 2:
                mal.append('un $ sin cerrar')
            if estado == 'publicada' and (p.get('vigencia') or '').startswith('revisar-') and p['vigencia'][8:] <= date.today().strftime('%Y-%m'):
                print(f'OJO  {donde}: tocaba revisarla en {p["vigencia"][8:]} (dato o norma que cambia)')
            if mal:
                errores.append(f'{donde}: ' + '; '.join(mal))
            elif estado == 'publicada':
                salida.append({'id': i, 'temas': [tema] + [t for t in p.get('temas', []) if t != tema], 'enunciado': enunciado, 'opciones': op, 'respuesta': r,
                               'explicacion': ex, 'dificultad': p['dificultad'], 'revisada': p['revisada'],
                               **({'imagenes': p['imagenes']} if p.get('imagenes') else {}), **({'nota': p['nota']} if p.get('nota') else {})})
    return salida, errores, recuento


def main():
    ap = argparse.ArgumentParser(description=__doc__.split('\n\n')[0])
    ap.add_argument('--origen', default=ORIGEN, help='carpeta con los JSON por tema (por defecto, banco-test/ de la rama de revisión)')
    ap.add_argument('--cupos', action='store_true', help='cuántas preguntas tocan a cada tema y cuántas hay')
    ap.add_argument('--total', type=int, default=TOTAL, help='tamaño del banco para repartir los cupos')
    ap.add_argument('--publicar', action='store_true', help='sube el banco al KV del conector')
    ap.add_argument('--salida', help='escribe aquí el JSON que se publicaría')
    args = ap.parse_args()

    preguntas, errores, recuento = leer(args.origen)
    if args.cupos:
        reparto, cuenta = cupos(args.total)
        print(f'{"tema":8} {"oficiales":>9} {"cupo":>5} {"publicadas":>10} {"borrador":>8}')
        for t in sorted(reparto, key=orden):
            r = recuento.get(t, {})
            print(f'{t:8} {cuenta[t]:9} {reparto[t]:5} {r.get("publicada", 0):10} {r.get("borrador", 0):8}')
        print(f'{"total":8} {sum(cuenta.values()):9} {sum(reparto.values()):5} {len(preguntas):10}')
        return
    for e in errores:
        print('MAL ', e)
    print(f'{len(preguntas)} preguntas publicadas de {len(recuento)} temas; {len(errores)} con errores (no salen).')
    if errores and args.publicar:
        sys.exit('No se publica con errores.')
    banco = {'generado': date.today().isoformat(), 'aviso': AVISO, 'preguntas': preguntas}
    if args.salida:
        with open(args.salida, 'w', encoding='utf-8') as f:
            json.dump(banco, f, ensure_ascii=False)
    if args.publicar:
        with tempfile.NamedTemporaryFile('w', suffix='.json', delete=False, encoding='utf-8') as f:
            json.dump(banco, f, ensure_ascii=False)
        entorno = dict(os.environ)
        if 'CLOUDFLARE_API_TOKEN' not in entorno and os.path.exists(TOKEN):
            with open(TOKEN, encoding='utf-8') as t:
                entorno['CLOUDFLARE_API_TOKEN'] = t.read().strip()
        subprocess.run(['npx', 'wrangler', 'kv', 'key', 'put', CLAVE_KV, '--path', f.name, '--binding', 'CONTENIDO', '--remote'], cwd=WORKER, env=entorno, check=True)
        os.unlink(f.name)
        print(f'Publicado en el KV del conector ({CLAVE_KV}). El conector lo recoge en diez minutos como mucho.')


if __name__ == '__main__':
    main()
