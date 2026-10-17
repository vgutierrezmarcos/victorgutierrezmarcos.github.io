#!/usr/bin/env python3
"""Lee las páginas del Ministerio donde se sigue cada proceso selectivo y
deja sus documentos en `oposicion/proceso.json`, que la app consulta para
avisar de las novedades (convocatoria, admitidos, calendario, convocatorias
de cada ejercicio, aprobados…).

Lo ejecuta la acción `leer-proceso.yml` cada 2 minutos en horario de oficina
y cada media hora fuera de él (la lanza un disparador externo; el cron de
GitHub queda de respaldo). Con `--novedades` deja aparte los documentos
nuevos, que `enviar-push-proceso.py` manda por push a los móviles.

Para no cargar el portal del Ministerio:
- Normalmente solo se piden las páginas de las convocatorias que ya se
  conocen (las del JSON). Con `--completa` (cada media hora) se buscan
  también las de otros años, por si ha salido una convocatoria nueva.
- Si el portal responde 403 o 429 (nos frena o nos bloquea), o lleva más de
  15 minutos sin responder, se deja de leer durante una hora salvo en las
  lecturas completas, que siguen cada media hora.
- Si lleva un día entero fallando, se deja `alerta.txt` junto a
  `--novedades` para que la acción abra una incidencia (y `recuperado.txt`
  cuando vuelve a funcionar, para cerrarla).
El estado de todo esto va en la clave `lectura` del JSON (la app la ignora) y
solo cambia al empezar o acabar un fallo o una pausa, para no hacer commits
en cada lectura.

A mano:

    python3 scripts/leer-proceso.py --completa   # lee el portal y actualiza el JSON
    python3 scripts/leer-proceso.py --html tcee=pagina.html   # desde un HTML guardado

Las páginas son `…/empleo/Paginas/OEP{año}TECOS.aspx` (TCEE) y
`OEP{año}DIPLOS.aspx` (DCE): se prueban el año siguiente, el actual y los dos
anteriores, y se guardan las dos convocatorias más recientes que existan
(mientras acaba una ya puede haber salido la siguiente).

El servidor del Ministerio no envía su certificado intermedio (GEANT TLS RSA 1),
así que se añade el de `scripts/certs/`. Si una página no responde, se conserva
lo que ya había: el JSON nunca se vacía por un fallo de red.
"""
import argparse
import hashlib
import html
import json
import re
import ssl
import sys
import time
import urllib.error
import urllib.request
from datetime import datetime, timedelta, timezone
from pathlib import Path

RAIZ = Path(__file__).resolve().parent.parent
SALIDA = RAIZ / 'oposicion' / 'proceso.json'
CERT = Path(__file__).resolve().parent / 'certs' / 'geant-tls-rsa-1.pem'
PORTAL = 'https://portal.mineco.gob.es'
PAGINA = PORTAL + '/es-es/ministerio/empleo/Paginas/OEP{anio}{cuerpo}.aspx'
OPOSICIONES = {'tcee': 'TECOS', 'dce': 'DIPLOS'}
CONVOCATORIAS = 2
PAUSA = timedelta(hours=1)
FALLO_PARA_PAUSA = timedelta(minutes=15)
FALLO_PARA_ALERTA = timedelta(days=1)


class Frenado(Exception):
    """El portal responde 403 o 429: nos está frenando o bloqueando."""


def contexto_tls():
    ctx = ssl.create_default_context()
    if CERT.exists():
        ctx.load_verify_locations(cafile=str(CERT))
    return ctx


def descargar(url, ctx):
    """HTML de la página, o None si no existe (404) o no responde."""
    pet = urllib.request.Request(url, headers={'User-Agent': 'Mozilla/5.0 (oposicion-tcee; +https://www.victorgutierrezmarcos.es/app/)'})
    for intento in range(2):
        if intento:
            time.sleep(5)
        try:
            with urllib.request.urlopen(pet, context=ctx, timeout=40) as r:
                return r.read().decode('utf-8', errors='replace')
        except urllib.error.HTTPError as e:
            if e.code == 404:
                return None
            if e.code in (403, 429):
                raise Frenado(f'{url}: {e.code}')
            print(f'  {url}: {e}', file=sys.stderr)
        except (urllib.error.URLError, TimeoutError, ssl.SSLError) as e:
            print(f'  {url}: {e}', file=sys.stderr)
    raise ConnectionError(url)


def limpio(x):
    x = html.unescape(re.sub(r'<[^>]+>', '', x))
    return re.sub(r'\s+', ' ', x.replace('​', '')).strip()


def documentos(pagina):
    """Documentos de la página, con la sección (encabezado h2) de cada uno."""
    i = pagina.find('Compartir en')
    j = pagina.find('Navegaci', i)
    cuerpo = pagina[i if i >= 0 else 0:j if j > 0 else len(pagina)]
    seccion = ''
    vistos = set()
    out = []
    for m in re.finditer(r'<(h[1-6])\b[^>]*>(.*?)</\1>|<a\b[^>]*href="([^"]+)"[^>]*>(.*?)</a>', cuerpo, re.S):
        if m.group(1):
            seccion = limpio(m.group(2))
            continue
        href, titulo = html.unescape(m.group(3)), limpio(m.group(4))
        if not seccion or not titulo or href.startswith(('mailto:', 'javascript:', '#')):
            continue
        url = PORTAL + href if href.startswith('/') else href
        if url in vistos:
            continue
        vistos.add(url)
        out.append({'id': hashlib.sha1(url.encode()).hexdigest()[:12], 'seccion': seccion, 'titulo': titulo, 'url': url})
    return out


def leer_oposicion(cuerpo, ctx, anio):
    """Las convocatorias más recientes de un cuerpo: [(año, url, html)],
    probando el año siguiente, el actual y los dos anteriores."""
    out = []
    for a in range(anio + 1, anio - 3, -1):
        url = PAGINA.format(anio=a, cuerpo=cuerpo)
        pagina = descargar(url, ctx)
        time.sleep(1)
        if pagina and '<h2' in pagina:
            out.append((str(a), url, pagina))
        if len(out) == CONVOCATORIAS:
            break
    return out


def leer_conocidas(previo, ctx):
    """Solo las convocatorias que ya se conocen (las del JSON)."""
    out = []
    for p in previo.get('procesos', []):
        pagina = descargar(p['url'], ctx)
        time.sleep(1)
        if pagina and '<h2' in pagina:
            out.append((p['convocatoria'], p['url'], pagina))
    return out


def fecha(x):
    return datetime.fromisoformat(x) if x else None


def nuevo_estado(estado, ahora, fallo, frenado):
    """Estado de la lectura tras esta vez. Solo cambia al empezar o acabar un
    fallo o una pausa (y al avisar), así que no hace commits en cada lectura.
    Devuelve también si hay que avisar de que lleva un día fallando o de que
    se ha recuperado."""
    estado = dict(estado)
    alerta = recuperado = False
    if not fallo:
        recuperado = bool(estado.get('avisado'))
        return {}, alerta, recuperado
    desde = fecha(estado.get('fallando_desde')) or ahora
    estado['fallando_desde'] = desde.isoformat(timespec='seconds')
    pausa = fecha(estado.get('pausa_hasta'))
    if (frenado or ahora - desde >= FALLO_PARA_PAUSA) and (pausa is None or pausa <= ahora):
        estado['pausa_hasta'] = (ahora + PAUSA).isoformat(timespec='seconds')
    if ahora - desde >= FALLO_PARA_ALERTA and not estado.get('avisado'):
        estado['avisado'] = True
        alerta = True
    return estado, alerta, recuperado


def fusionar(anterior, convocatoria, url, docs, hoy):
    """Convocatoria con la fecha en que se vio cada documento por primera vez.
    La primera vez que se lee una oposición no se sabe cuándo salió lo que ya
    había (desde = None): solo es novedad lo que aparezca después."""
    antes = {d['id']: d.get('desde') for p in anterior.get('procesos', []) if p['convocatoria'] == convocatoria for d in p['documentos']}
    if not anterior:
        hoy = None
    return {
        'convocatoria': convocatoria,
        'url': url,
        'documentos': [{**d, 'desde': antes.get(d['id'], hoy)} for d in docs],
    }


def novedades(anterior, nuevo):
    """Documentos que no estaban en la lectura anterior, por oposición, con la
    página oficial de su convocatoria. La primera vez que se lee una
    oposición no hay novedades (todo lo que ya había es la base)."""
    out = {}
    for op, datos in nuevo.items():
        previo = anterior.get(op)
        if not previo:
            continue
        vistos = {d['id'] for p in previo.get('procesos', []) for d in p['documentos']}
        docs = [{**d, 'pagina': p['url']} for p in datos['procesos'] for d in p['documentos'] if d['id'] not in vistos]
        if docs:
            out[op] = docs
    return out


def main():
    ap = argparse.ArgumentParser(description=__doc__.split('\n')[0])
    ap.add_argument('--html', action='append', default=[], help='op=fichero.html: lee esa página en vez del portal (pruebas)')
    ap.add_argument('--salida', default=str(SALIDA))
    ap.add_argument('--novedades', help='fichero JSON donde dejar los documentos nuevos de cada oposición (para el aviso push)')
    ap.add_argument('--completa', action='store_true', help='buscar también convocatorias de otros años (y leer aunque haya pausa)')
    args = ap.parse_args()

    salida = Path(args.salida)
    anterior = json.loads(salida.read_text(encoding='utf-8')) if salida.exists() else {}
    ahora = datetime.now(timezone.utc).replace(microsecond=0)
    hoy = ahora.date().isoformat()
    locales = dict(x.split('=', 1) for x in args.html)
    estado = anterior.get('lectura', {})
    pausa = fecha(estado.get('pausa_hasta'))
    if not locales and not args.completa and pausa and pausa > ahora:
        print(f'En pausa hasta {pausa.isoformat()} (el portal fallaba o nos frenaba): no se lee')
        if args.novedades:
            Path(args.novedades).write_text('{}\n', encoding='utf-8')
        return
    ctx = contexto_tls()
    nuevo = {}
    fallo = frenado = False
    for op, cuerpo in OPOSICIONES.items():
        previo = anterior.get(op, {})
        if frenado:
            # Si nos frena con una, no se insiste con la otra.
            if previo:
                nuevo[op] = previo
            continue
        try:
            if locales:
                if op not in locales:
                    continue
                m = re.search(r'OEP(\d{4})', locales[op])
                paginas = [(m.group(1) if m else '0', PAGINA.format(anio=m.group(1) if m else 0, cuerpo=cuerpo), Path(locales[op]).read_text(encoding='utf-8', errors='replace'))]
            elif args.completa or not previo.get('procesos'):
                paginas = leer_oposicion(cuerpo, ctx, datetime.now().year)
            else:
                paginas = leer_conocidas(previo, ctx)
        except (ConnectionError, Frenado) as e:
            fallo = True
            frenado = frenado or isinstance(e, Frenado)
            print(f'{op}: {"nos frena" if isinstance(e, Frenado) else "sin respuesta"} ({e}); se conserva lo anterior', file=sys.stderr)
            if previo:
                nuevo[op] = previo
            continue
        procesos = [fusionar(previo, a, url, documentos(p), hoy) for a, url, p in paginas]
        procesos = [p for p in procesos if p['documentos']]
        if not procesos:
            if previo:
                nuevo[op] = previo
            continue
        nuevo[op] = {'procesos': procesos}
        print(f'{op}: ' + ', '.join(f"{p['convocatoria']} ({len(p['documentos'])} documentos)" for p in procesos))

    if args.novedades:
        Path(args.novedades).write_text(json.dumps(novedades(anterior, nuevo), ensure_ascii=False, indent=1) + '\n', encoding='utf-8')

    if not locales:
        estado, alerta, recuperado = nuevo_estado(estado, ahora, fallo, frenado)
        if estado.get('pausa_hasta') and estado.get('pausa_hasta') != anterior.get('lectura', {}).get('pausa_hasta'):
            print(f"Pausa hasta {estado['pausa_hasta']}")
        if args.novedades and (alerta or recuperado):
            nombre = 'alerta.txt' if alerta else 'recuperado.txt'
            texto = (f"El lector del proceso selectivo no consigue leer el portal del Ministerio desde {estado['fallando_desde']} (UTC). "
                     'Mira los registros de la acción «Leer el proceso selectivo». Mientras tanto, la app muestra lo último que se leyó.') if alerta else 'El lector del proceso vuelve a leer el portal del Ministerio.'
            (Path(args.novedades).parent / nombre).write_text(texto + '\n', encoding='utf-8')
        if estado:
            nuevo['lectura'] = estado

    # Solo cambia la fecha si cambia algo, para no hacer commits vacíos.
    cuerpo_nuevo = {k: v for k, v in nuevo.items()}
    cuerpo_viejo = {k: v for k, v in anterior.items() if k != 'actualizado'}
    if cuerpo_nuevo == cuerpo_viejo:
        print('Sin cambios')
        return
    salida.write_text(json.dumps({'actualizado': datetime.now(timezone.utc).isoformat(timespec='seconds'), **cuerpo_nuevo}, ensure_ascii=False, indent=1) + '\n', encoding='utf-8')
    print(f'Actualizado {salida}')


if __name__ == '__main__':
    main()
