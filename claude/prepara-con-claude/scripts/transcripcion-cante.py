#!/usr/bin/env python3
"""
Mide el cante a partir de su transcripción y prepara el anexo del informe:

    python3 transcripcion-cante.py cante_3A08_2026-11-03.txt \
        [--apartados "Introducción=00:00" "I=02:45" "II=11:10" "III=20:30" "Conclusión=28:50"] \
        [--errores errores.json] [--tramo 5] [-o anexo.md]
    python3 transcripcion-cante.py cante.txt --buscar "Paso al segundo bloque" "En conclusión"

Lee el .txt de la app (cabecera y marcas «[mm:ss]» al principio de cada
minuto) o un texto pegado sin marcas (entonces estima el tiempo a 155
palabras por minuto y lo dice). Escribe en la salida estándar un JSON con:
duración, palabras y ritmo total; los tramos de --tramo minutos con sus
palabras por minuto; y, si se dan --apartados (nombre=inicio, en orden), la
duración, las palabras y el ritmo de cada apartado (las palabras de un minuto
partido entre dos apartados se reparten en proporción al tiempo).

Con -o escribe el anexo «Transcripción» en Markdown, por tramos y con el
ritmo de cada uno. --errores es una lista JSON [{"id": "E1", "cita": "texto
literal de la transcripción"}, …]: cada cita sale en negrita seguida de
«[E1]», la llamada al error del informe (en el PDF, un enlace). Las citas que
no encuentra salen en el JSON («errores_sin_marcar»): corrige la cita
(cópiala tal cual de la transcripción) y vuelve a ejecutar.

Con --buscar, para cada frase da el minuto en que se dijo, interpolado por
palabras dentro de su marca: sirve cuando las marcas van cada varios minutos
(o no hay) y hay que situar el inicio de cada apartado para --apartados.

Solo biblioteca estándar. Autor: Víctor Gutiérrez Marcos (skill «Prepara con Claude»).
"""
import argparse
import json
import re
import sys

PPM_ESTIMADO = 155
MARCA = re.compile(r'^\[(\d{1,3}):(\d{2})\]\s*(.*)$')


def seg(texto):
    m = re.match(r'^(\d{1,3}):(\d{2})$', texto.strip())
    if not m:
        raise SystemExit(f'Tiempo no válido: «{texto}» (usa mm:ss)')
    return int(m.group(1)) * 60 + int(m.group(2))


def mmss(s):
    s = int(round(s))
    return f'{s // 60:02d}:{s % 60:02d}'


def duracion_es(s):
    s = int(round(s))
    return f'{s // 60}′{s % 60:02d}″'


def palabras(texto):
    return len(re.findall(r'\w+', texto))


def leer(ruta):
    """Cabecera (líneas antes de la primera marca), segmentos [(inicio, texto)] y duración."""
    with open(ruta, encoding='utf-8') as f:
        lineas = [l.rstrip('\n') for l in f]
    cabecera, segmentos = [], []
    for l in lineas:
        m = MARCA.match(l.strip())
        if m:
            segmentos.append([int(m.group(1)) * 60 + int(m.group(2)), m.group(3).strip()])
        elif segmentos:
            if l.strip():
                segmentos[-1][1] += ' ' + l.strip()
        else:
            cabecera.append(l)
    estimado = False
    if not segmentos:
        # Texto sin marcas: lo que no es cabecera («# …», «Fecha: …») es el cante
        cuerpo = [l for l in cabecera if l.strip() and not l.startswith('#') and not re.match(r'^\w[\w ]*:\s', l)]
        texto = ' '.join(l.strip() for l in cuerpo)
        cabecera = [l for l in cabecera if l not in cuerpo]
        trozos, actual, inicio = [], [], 0
        for p in texto.split():
            actual.append(p)
            if len(actual) >= PPM_ESTIMADO:
                trozos.append([inicio, ' '.join(actual)])
                inicio += 60
                actual = []
        if actual:
            trozos.append([inicio, ' '.join(actual)])
        segmentos, estimado = trozos, True
    # Duración: la de la cabecera («Exposición: 28:40») o el último minuto a ritmo medio
    duracion = None
    for l in cabecera:
        m = re.search(r'Exposici[oó]n:\s*(\d{1,3}:\d{2})', l)
        if m:
            duracion = seg(m.group(1))
    if duracion is None or (segmentos and duracion <= segmentos[-1][0]):
        if len(segmentos) > 1:
            previos = sum(palabras(t) for _, t in segmentos[:-1]) / max(segmentos[-1][0], 1) * 60
        else:
            previos = PPM_ESTIMADO
        duracion = segmentos[-1][0] + 60 * min(1, palabras(segmentos[-1][1]) / max(previos, 1)) if segmentos else 0
    return cabecera, segmentos, duracion, estimado


def con_fin(segmentos, duracion):
    """[(inicio, fin, texto)] con el fin de cada segmento."""
    return [(ini, segmentos[i + 1][0] if i + 1 < len(segmentos) else max(duracion, ini + 1), t)
            for i, (ini, t) in enumerate(segmentos)]


def reparto(segs, desde, hasta):
    """Palabras entre dos instantes, repartiendo cada segmento en proporción al tiempo."""
    total = 0.0
    for ini, fin, t in segs:
        solape = min(fin, hasta) - max(ini, desde)
        if solape > 0:
            total += palabras(t) * solape / (fin - ini)
    return total


def ppm(n, segundos):
    return round(n / segundos * 60) if segundos > 0 else 0


def normalizar(t):
    return re.sub(r'\s+', ' ', t).strip().lower()


def marcar(texto, errores, marcados):
    """Pone en negrita cada cita encontrada en el texto y la llamada [E1] detrás."""
    for e in errores:
        if e['id'] in marcados:
            continue
        cita = re.sub(r'\s+', ' ', e['cita']).strip().strip('«»"\'').strip()
        if not cita:
            continue
        patron = re.compile(r'\s+'.join(re.escape(p) for p in cita.split()), re.IGNORECASE)
        m = patron.search(texto)
        if m:
            texto = f'{texto[:m.start()]}**{m.group(0)}** [{e["id"]}]{texto[m.end():]}'
            marcados.add(e['id'])
    return texto


def main():
    p = argparse.ArgumentParser(description='Tiempos, ritmo y anexo de la transcripción de un cante')
    p.add_argument('transcripcion')
    p.add_argument('--apartados', nargs='*', default=[], help='nombre=mm:ss, en orden')
    p.add_argument('--errores', help='JSON [{"id": "E1", "cita": "…"}]')
    p.add_argument('--tramo', type=int, default=5, help='minutos por tramo (5)')
    p.add_argument('-o', '--salida', help='anexo en Markdown')
    p.add_argument('--buscar', nargs='*', default=[], help='frases literales: dice en qué minuto se dijo cada una')
    a = p.parse_args()

    cabecera, segmentos, duracion, estimado = leer(a.transcripcion)
    if not segmentos:
        raise SystemExit('La transcripción está vacía.')
    segs = con_fin(segmentos, duracion)
    if a.buscar:
        encontradas = {}
        for frase in a.buscar:
            patron = re.compile(r'\s+'.join(re.escape(x) for x in frase.split()), re.IGNORECASE)
            encontradas[frase] = None
            for ini, fin, t in segs:
                m = patron.search(t)
                if m:
                    encontradas[frase] = mmss(ini + (fin - ini) * palabras(t[:m.start()]) / max(palabras(t), 1))
                    break
        json.dump({'minutos': encontradas}, sys.stdout, ensure_ascii=False, indent=1)
        print()
        return
    total = sum(palabras(t) for _, t in segmentos)
    resumen = {
        'duracion': mmss(duracion), 'duracion_texto': duracion_es(duracion), 'palabras': total,
        'ppm': ppm(total, duracion), 'tiempo_estimado': estimado,
    }

    # Tramos
    paso = a.tramo * 60
    tramos = []
    inicio = 0
    while inicio < duracion:
        fin = min(inicio + paso, duracion)
        if 0 < duracion - fin < 90:  # un resto de menos de minuto y medio va con el tramo anterior
            fin = duracion
        n = reparto(segs, inicio, fin)
        tramos.append({'desde': mmss(inicio), 'hasta': mmss(fin), 'palabras': round(n), 'ppm': ppm(n, fin - inicio),
                       'texto': ' '.join(f'[{mmss(i)}] {t}' for i, _, t in segs if inicio <= i < fin)})
        inicio = fin
    resumen['tramos'] = [{k: v for k, v in t.items() if k != 'texto'} for t in tramos]

    # Apartados
    if a.apartados:
        marcas = []
        for x in a.apartados:
            if '=' not in x:
                raise SystemExit(f'Apartado sin tiempo: «{x}» (usa nombre=mm:ss)')
            nombre, t = x.rsplit('=', 1)
            marcas.append((nombre.strip(), seg(t)))
        resumen['apartados'] = []
        for i, (nombre, ini) in enumerate(marcas):
            fin = marcas[i + 1][1] if i + 1 < len(marcas) else duracion
            n = reparto(segs, ini, fin)
            resumen['apartados'].append({'apartado': nombre, 'desde': mmss(ini), 'hasta': mmss(fin),
                                         'duracion': duracion_es(fin - ini), 'segundos': int(fin - ini),
                                         'palabras': round(n), 'ppm': ppm(n, fin - ini)})

    # Anexo
    errores = json.load(open(a.errores, encoding='utf-8')) if a.errores else []
    marcados = set()
    if a.salida:
        partes = ['## Anexo. Transcripción', '']
        nota = (f'*Transcripción {"pegada, sin marcas de tiempo: los minutos son una estimación a 155 palabras por minuto" if estimado else "automática de la app: puede tener errores de reconocimiento (nombres, fórmulas, cifras)"}. '
                f'{resumen["duracion_texto"]} · {total} palabras · ritmo medio de {resumen["ppm"]} palabras por minuto'
                f'{" (lo normal, 150-160)" if 140 <= resumen["ppm"] <= 170 else ""}.'
                f'{" En negrita, los errores del informe con su número." if errores else ""}*')
        partes += [nota, '']
        for t in tramos:
            partes += [f'### {t["desde"]}–{t["hasta"]} · {t["ppm"]} palabras/min', '', marcar(t['texto'], errores, marcados), '']
        with open(a.salida, 'w', encoding='utf-8') as f:
            f.write('\n'.join(partes).rstrip() + '\n')
        resumen['anexo'] = a.salida
    if errores:
        resumen['errores_sin_marcar'] = [e['id'] for e in errores if e['id'] not in marcados]
    json.dump(resumen, sys.stdout, ensure_ascii=False, indent=1)
    print()


if __name__ == '__main__':
    main()
