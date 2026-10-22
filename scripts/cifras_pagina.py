"""Agrega los datos crudos de «La oposición a TCEE en cifras» y escribe
oposicion/cifras.json, la página oposicion/cifras.html y el resumen de la
guía (lo usa cifras-oposicion.py). En la salida nunca hay nombres ni notas."""
import difflib
import json
import re
import statistics
from collections import Counter
from datetime import date
from pathlib import Path

import cifras_graficos as g

RAIZ = Path(__file__).resolve().parents[1]
PAGINA = RAIZ / 'oposicion' / 'cifras.html'
GUIA = RAIZ / 'oposicion' / 'por-que-tcee.html'
JSON = RAIZ / 'oposicion' / 'cifras.json'
PASOS = [('1-test', 'Test (1.ª parte del 1.º)'), ('1-dictamen', 'Dictamen (2.ª parte del 1.º)'), ('1', 'Primer ejercicio completo'),
         ('2-ingles', 'Inglés (2.º)'), ('2-resto', 'Segundo idioma (2.º)'), ('2', 'Segundo ejercicio completo'),
         ('3', 'Tercer ejercicio'), ('4', 'Cuarto ejercicio'), ('5', 'Quinto ejercicio')]
CORTOS = {'1': '1.º (test y dictamen)', '2': '2.º (idiomas)', '3': '3.º', '4': '4.º', '5': '5.º'}


def fmt(v, d=0):
    if v is None:
        return '—'
    return f'{v:,.{d}f}'.replace(',', ' ').replace('.', ',')


def dmy(iso):
    """'2025-12-22' → '22/12/2025'."""
    if not iso or len(iso) < 10:
        return iso or ''
    return f'{iso[8:10]}/{iso[5:7]}/{iso[:4]}'


def pct(a, b):
    return round(100 * a / b, 1) if a is not None and b else None


def anio_examen(fecha_convocatoria):
    """Año en que se hacen los exámenes: el mismo si la convocatoria sale en el
    primer semestre; el siguiente si sale en el segundo (diciembre)."""
    a, m = int(fecha_convocatoria[:4]), int(fecha_convocatoria[5:7])
    return a if m <= 6 else a + 1


def media(xs, d=1):
    xs = [x for x in xs if x is not None]
    return round(statistics.mean(xs), d) if xs else None


def parecidos(nombre, candidatos):
    """¿Aparece el nombre (normalizado, con errores de OCR) en el conjunto?
    Vale si los apellidos y el nombre están entre las palabras del candidato
    (las listas los ordenan de distinta manera) o si se parecen mucho."""
    if nombre in candidatos:
        return True
    palabras = [w for w in nombre.split() if len(w) >= 3 and w not in ('DEL', 'LAS', 'LOS', 'VON', 'VAN')]
    if len(palabras) < 2:
        return False
    compacto = nombre.replace(' ', '')
    for c in candidatos:
        pc = set(c.split())
        faltan = sum(1 for w in palabras if w not in pc)
        if faltan == 0 or (faltan == 1 and len(palabras) >= 4):
            return True
        if abs(len(c) - len(nombre)) <= 8 and difflib.SequenceMatcher(None, compacto, c.replace(' ', '')).ratio() >= 0.85:
            return True
    return False


def idioma_de(nombre, personas):
    """El segundo idioma que declaró un aspirante en la lista de admitidos: personas = [(nombre, idioma)]."""
    for n, idioma in personas:
        if n == nombre:
            return idioma
    for n, idioma in personas:
        if parecidos(nombre, [n]):
            return idioma
    return None


def n_turno(e, clave, turnos=('tl', 'disc')):
    """Aprobados de un paso en los turnos dados (None si no hay lista)."""
    d = e.get(clave)
    if not d:
        return None
    return sum(d.get(t, {}).get('n', 0) for t in turnos)


def agregar(crudo, convocatorias_boe, aprobados_boe, cuerpo=None):
    """Una entrada por convocatoria (del BOE), ordenada por el año de los exámenes."""
    por_fecha = {}
    for fecha, c in sorted(convocatorias_boe.items()):
        if 'corrig' in c['titulo'].lower() or 'rectific' in c['titulo'].lower():
            continue
        por_fecha[fecha] = {'examenes': anio_examen(fecha), 'convocatoria': fecha, 'boe_convocatoria': c['id'], 'oep': c.get('oep'),
                            'plazas': {'libre': c.get('libre'), 'libre_discapacidad': c.get('libre_discapacidad'),
                                       'interna': c.get('interna'), 'interna_discapacidad': c.get('interna_discapacidad'), 'lectura_ocr': bool(c.get('ocr'))}}
    fechas = sorted(por_fecha)

    def anterior(fecha_doc, meses=20):
        """La convocatoria más reciente anterior a un documento (fecha_doc «AAAAMMDD»), hasta `meses` antes."""
        fd = f'{fecha_doc[:4]}-{fecha_doc[4:6]}-{fecha_doc[6:8]}'
        # Entre la convocatoria y el nombramiento pasan al menos seis meses (el proceso dura cerca de un año)
        cands = [f for f in fechas if f < fd and 6 <= (int(fd[:4]) - int(f[:4])) * 12 + int(fd[5:7]) - int(f[5:7]) <= meses]
        return cands[-1] if cands else None

    PRIORIDAD = {'aprobados': 0, 'promocion': 1, 'practicas': 2, 'carrera': 3}
    FUENTES = {'aprobados': 'relación de aprobados', 'practicas': 'nombramiento de funcionarios en prácticas (lectura OCR)', 'carrera': 'nombramiento de funcionarios de carrera (lectura OCR)'}
    for a in sorted(aprobados_boe, key=lambda a: (PRIORIDAD.get(a['tipo'], 9), a['fecha'])):
        if a['tipo'] not in PRIORIDAD or not a['libre']:
            continue
        f = a['convocatoria'] if a['convocatoria'] in por_fecha else anterior(a['fecha'])
        if not f:
            continue
        e = por_fecha[f]
        if 'aprobados' in e and (PRIORIDAD[e['aprobados']['tipo']] < PRIORIDAD[a['tipo']] or e['aprobados']['libre'] >= a['libre']):
            continue
        e['aprobados'] = {'libre': a['libre'], 'interna': a['interna'], 'boe': a['id'], 'publicado': a['fecha'], 'tipo': a['tipo'], 'fuente': FUENTES[a['tipo']]}
    # Promociones de la ATCEE (nombramientos de funcionarios de carrera): mejor que el OCR de los nombramientos antiguos
    for p in (cuerpo or {}).get('promociones', []):
        if not p.get('fecha') or p.get('ampliacion'):
            continue
        f = anterior(p['fecha'].replace('-', ''), meses=30)
        if not f:
            continue
        e = por_fecha[f]
        if 'aprobados' in e and e['aprobados']['tipo'] == 'aprobados':
            e.setdefault('promocion', {'nombre': p['promocion'], 'nombramientos': p['nombramientos'], 'fecha': p['fecha']})
            continue
        if 'promocion' in e and e['promocion']['fecha'] <= p['fecha']:
            continue  # ya tiene una promoción más cercana
        e['promocion'] = {'nombre': p['promocion'], 'nombramientos': p['nombramientos'], 'fecha': p['fecha']}
        interna = e.get('aprobados', {}).get('interna') or 0
        e['aprobados'] = {'libre': p['nombramientos'] - interna, 'interna': interna, 'promocion': p['promocion'], 'publicado': p['fecha'], 'tipo': 'promocion',
                          'fuente': 'promoción de la ATCEE (nombramientos de funcionarios de carrera)'}
    vistos = set()
    for f in fechas:
        while por_fecha[f]['examenes'] in vistos:
            por_fecha[f]['examenes'] += 1
        vistos.add(por_fecha[f]['examenes'])
    por_examen = {e['examenes']: e for e in por_fecha.values()}

    # Documentos del Ministerio (desde la OEP 2018): admitidos, ejercicios, idiomas, conservación de nota
    nombres_admitidos = {}
    for anio, d in sorted(crudo.items()):
        anio = int(anio)
        ae = next((e['examenes'] for e in por_examen.values() if e.get('oep') == anio), anio + 1)
        e = por_examen.setdefault(ae, {'examenes': ae})
        e['oep'] = anio
        e['pagina_ministerio'] = f'https://portal.mineco.gob.es/es-es/ministerio/empleo/Paginas/OEP{anio}TECOS.aspx'
        adm = {t: v['n'] for t, v in d['admitidos'].items()}
        if adm:
            e['admitidos'] = {'libre': adm.get('tl'), 'discapacidad': adm.get('disc'), 'interna': adm.get('pi'), 'total': sum(v for v in adm.values() if v)}
        ej = d['ejercicios']
        pasos = {}
        for clave in ('1-test', '1', '2-ingles', '2-resto', '2-total', '3', '4', '5'):
            if clave in ej:
                k = '2' if clave == '2-total' else clave
                pasos[k] = {'libre': n_turno(ej, clave), 'interna': n_turno(ej, clave, ('pi',)), 'todos': n_turno(ej, clave, ('tl', 'disc', 'pi'))}
        if '2' not in pasos and ('2-ingles' in pasos or '2-resto' in pasos):
            # Sin lista conjunta: el segundo ejercicio lo superan quienes aprueban los dos idiomas (la lista más corta)
            base = pasos.get('2-resto') or pasos.get('2-ingles')
            pasos['2'] = dict(base)
        e['ejercicios'] = pasos
        cons = d.get('conservan', {})
        if cons:
            e['conservan_nota'] = {k: {'personas': v['n'], 'los_dos_idiomas': v['ambos']} if k == '2' else {'personas': v['n']} for k, v in cons.items()}
        # Tasas de superación del turno libre (la promoción interna tiene exenciones y va aparte)
        adm_libre = (adm.get('tl') or 0) + (adm.get('disc') or 0) or None
        cons2 = cons.get('2', {}).get('ambos', 0)
        p = {k: v['libre'] for k, v in pasos.items()}
        presentados = {'1-test': adm_libre, '1-dictamen': p.get('1-test'), '1': adm_libre,
                       '2-ingles': (p['1'] - cons2) if p.get('1') else None, '2-resto': (p['1'] - cons2) if p.get('1') else None, '2': (p['1'] - cons2) if p.get('1') else None,
                       '3': p.get('2'), '4': p.get('3'), '5': p.get('4')}
        aprobados = {'1-test': p.get('1-test'), '1-dictamen': p.get('1'), '1': p.get('1'), '2-ingles': p.get('2-ingles'), '2-resto': p.get('2-resto'), '2': p.get('2'), '3': p.get('3'), '4': p.get('4'), '5': p.get('5')}
        # Si una lista trae más aprobados que presentados (lectura incompleta de la anterior), la tasa se deja en blanco
        e['tasas_libre'] = {k: {'presentados': presentados[k], 'aprobados': aprobados[k], 'superan_pct': pct(aprobados[k], presentados[k])}
                            for k, _ in PASOS if presentados.get(k) and aprobados.get(k) is not None and aprobados[k] <= presentados[k]}
        # Idiomas: elegidos por los admitidos y, cruzando nombres, cuántos de los que llegan al segundo ejercicio aprueban el segundo idioma
        if d.get('idiomas'):
            e['idiomas'] = {'elegidos': d['idiomas']['elegidos'], 'voluntarios': d['idiomas'].get('voluntarios', {})}
        personas = [tuple(x) for t in ('tl', 'disc') for x in d.get('personas', {}).get(t, [])]
        if personas and ej.get('1') and ej.get('2-resto'):
            llegan, aprueban = Counter(), Counter()
            for n in ej['1'].get('tl', {}).get('nombres', []) + ej['1'].get('disc', {}).get('nombres', []):
                i = idioma_de(n, personas)
                if i:
                    llegan[i] += 1
            for n in ej['2-resto'].get('tl', {}).get('nombres', []) + ej['2-resto'].get('disc', {}).get('nombres', []):
                i = idioma_de(n, personas)
                if i:
                    aprueban[i] += 1
            e.setdefault('idiomas', {})['segundo_idioma'] = {i: {'llegan': llegan[i], 'aprueban': min(aprueban[i], llegan[i])} for i in llegan}
        nombres_admitidos[ae] = set(d['nombres'].get('admitidos_tl', [])) | set(d['nombres'].get('admitidos_disc', []))
        finales = ej.get('fase_oposicion', ej.get('aprobados_final', {})).get('todos', {}).get('nombres', [])
        e['_nombres_finales'] = finales
    for e in por_examen.values():
        p = e.get('plazas', {})
        if p.get('lectura_ocr') and p.get('libre') and e.get('aprobados', {}).get('libre', 0) > p['libre']:
            p['libre'] = None
    for ae, e in por_examen.items():
        finales = e.pop('_nombres_finales', None)
        anteriores = [a for a in nombres_admitidos if a < ae]
        if finales and anteriores:
            previos = set().union(*(nombres_admitidos[a] for a in anteriores))
            n_rep = sum(1 for n in finales if parecidos(n, previos))
            e['repetidores'] = {'aprobados': len(finales), 'ya_admitidos_antes': n_rep, 'desde': min(anteriores)}
    return [por_examen[k] for k in sorted(por_examen)]


# ------------------------------------------------------------------ Página

def tarjeta(n, t):
    return f'<li><span class="n">{n}</span><span class="t">{t}</span></li>'


def grafico_plazas(con_plazas, alto=g.ALTO, etiquetas=True):
    anios = [str(c['examenes']) for c in con_plazas]
    aprobados = [c.get('aprobados', {}).get('libre') for c in con_plazas]
    sin_cubrir = [max(c['plazas']['libre'] - a, 0) if a is not None else None for c, a in zip(con_plazas, aprobados)]
    en_curso = [c['plazas']['libre'] if a is None and i == len(con_plazas) - 1 else None for i, (c, a) in enumerate(zip(con_plazas, aprobados))]
    sin_dato = [c['plazas']['libre'] if a is None and i < len(con_plazas) - 1 else None for i, (c, a) in enumerate(zip(con_plazas, aprobados))]
    barras = [('Aprobados de turno libre', aprobados, 'var(--color-accent-gold)'), ('Plazas sin cubrir', sin_cubrir, 'var(--color-border-strong)')]
    if any(sin_dato):
        barras.append(('Plazas sin dato de aprobados', sin_dato, 'var(--color-border-light)'))
    barras.append(('Convocatoria en curso (plazas)', en_curso, 'var(--color-primary-pale)'))
    return g.grafico(anios, barras=barras,
                     apiladas=True, titulo='Plazas de turno libre por convocatoria: aprobados y plazas sin cubrir',
                     descripcion=f'Columnas apiladas: en cada convocatoria entre {anios[0]} y {anios[-1]}, los aprobados de turno libre y, encima, las plazas que quedaron sin cubrir; la suma es el total de plazas convocadas.',
                     alto=alto, etiquetas=etiquetas)


def bloque_pagina(conv, hoy, cuerpo=None):
    con_plazas = [c for c in conv if c.get('plazas', {}).get('libre')]
    con_admitidos = [c for c in conv if c.get('admitidos')]
    completas = [c for c in con_plazas if c.get('aprobados') and c['aprobados'].get('fuente', '').startswith('relaci')]
    primero, ultimo = con_plazas[0]['examenes'], con_plazas[-1]['examenes']
    h = []
    h.append(f'<p class="actualizado">Por <a href="../sobre-mi.html">Víctor Gutiérrez Marcos</a>, Técnico Comercial y Economista del Estado · Actualizado el {hoy}</p>')
    h.append('<p>Todo lo que hay en esta página sale de los documentos oficiales: las convocatorias y las relaciones de aprobados publicadas en el BOE y, desde la oferta de empleo público de 2018, las listas de admitidos, de aprobados de cada ejercicio y de conservación de nota que publica el Ministerio de Economía, Comercio y Empresa. Muchos de esos documentos son imágenes escaneadas, así que puede haber algún error de lectura de una o dos unidades. Solo se publican recuentos y porcentajes, nunca datos de personas ni puntuaciones. Las series llegan hasta donde llegan los documentos: cada apartado indica desde qué año hay datos.</p>')
    ult = completas[-1] if completas else con_plazas[-1]
    plazas_media = media([c['plazas']['libre'] for c in con_plazas[-10:]], 1)
    cobertura = [pct(c['aprobados']['libre'], c['plazas']['libre']) for c in completas]
    ratio = [round(c['admitidos']['libre'] / c['plazas']['libre'], 1) for c in con_admitidos if c.get('plazas', {}).get('libre') and c['admitidos'].get('libre')]
    tarjetas = [tarjeta(fmt(ult['plazas']['libre']), f'plazas de turno libre en la última convocatoria con resultado ({ult["examenes"]})'),
                tarjeta(fmt(plazas_media, 1), f'plazas de turno libre al año de media en las últimas {len(con_plazas[-10:])} convocatorias')]
    if ratio:
        tarjetas.append(tarjeta(fmt(media(ratio), 1), f'admitidos por cada plaza de turno libre ({con_admitidos[0]["examenes"]}-{con_admitidos[-1]["examenes"]})'))
    if cobertura:
        tarjetas.append(tarjeta(f'{fmt(media(cobertura), 0)} %', f'de las plazas de turno libre se cubren de media ({completas[0]["examenes"]}-{completas[-1]["examenes"]})'))
    h.append('<ul class="cifras-clave">' + ''.join(tarjetas) + '</ul>')
    h.append('<nav class="guia-indice" aria-label="Contenido"><ul><li><a href="#plazas">Plazas y aprobados</a></li><li><a href="#admitidos">Admitidos por plaza</a></li><li><a href="#suspensos">Suspensos por ejercicio</a></li><li><a href="#idiomas">Idiomas</a></li><li><a href="#repetidores">Cuántos repiten</a></li><li><a href="#cuerpo">El cuerpo desde 1930</a></li><li><a href="#tabla">Tabla completa</a></li><li><a href="#metodo">Método y fuentes</a></li></ul></nav>')

    # 1. Plazas y aprobados
    h.append(f'<h2 id="plazas">Plazas convocadas y aprobados, {primero}-{ultimo}</h2>')
    h.append('<p>Plazas de turno libre de cada convocatoria (por el año en que se celebran los exámenes), partidas entre las que se cubrieron (los aprobados de la fase de oposición que publica el BOE) y las que quedaron desiertas. La promoción interna, reservada a funcionarios A2, va aparte.</p>')
    tabla = g.tabla(['Exámenes', 'Convocatoria (BOE)', 'Plazas libre', 'Reserva discapacidad', 'Plazas interna', 'Aprobados libre', 'Sin cubrir', 'Aprobados interna', 'Cobertura libre'],
                    [[c['examenes'], dmy(c.get('convocatoria', '')[:10]), c['plazas']['libre'], c['plazas'].get('libre_discapacidad'), c['plazas'].get('interna'),
                      c.get('aprobados', {}).get('libre'), (max(c['plazas']['libre'] - c['aprobados']['libre'], 0) if c.get('aprobados') else None), c.get('aprobados', {}).get('interna'),
                      (f"{fmt(pct(c['aprobados']['libre'], c['plazas']['libre']))} %" if c.get('aprobados') else None)] for c in con_plazas])
    h.append(g.figura('g-plazas', grafico_plazas(con_plazas), 'Fuente: convocatorias y relaciones de aprobados en la fase de oposición publicadas en el BOE. Las convocatorias en curso aún no tienen aprobados.', tabla))
    if cobertura:
        sin_cubrir = [c for c in completas if c['aprobados']['libre'] < c['plazas']['libre']]
        h.append(f'<p>En las {len(completas)} convocatorias con relación de aprobados en el BOE ({completas[0]["examenes"]}-{completas[-1]["examenes"]}), las plazas de turno libre se cubrieron de media al {fmt(media(cobertura))} %; en {len(completas) - len(sin_cubrir)} se cubrieron todas y en {len(sin_cubrir)} quedaron plazas desiertas'
                 + (' (' + ', '.join(f'{c["examenes"]}: {c["plazas"]["libre"] - c["aprobados"]["libre"]}' for c in sin_cubrir) + ')' if sin_cubrir else '') + '. Los aprobados de las convocatorias anteriores a 1996 son el tamaño de cada promoción según la ATCEE (turno libre y promoción interna juntos) y, si falta, los nombramientos leídos de BOE escaneados.</p>')

    # 2. Admitidos
    if con_admitidos:
        a0, a1 = con_admitidos[0]['examenes'], con_admitidos[-1]['examenes']
        h.append(f'<h2 id="admitidos">Cuántos se presentan: admitidos por plaza, {a0}-{a1}</h2>')
        h.append('<p>Las listas definitivas de admitidos del Ministerio existen desde la oferta de empleo público de 2018. No todos los admitidos llegan a examinarse, pero es la mejor medida de cuánta gente opta a cada plaza.</p>')
        svg = g.grafico([str(c['examenes']) for c in con_admitidos], barras=[('Admitidos de turno libre', [c['admitidos']['libre'] for c in con_admitidos])],
                        lineas=[('Admitidos por plaza', [round(c['admitidos']['libre'] / c['plazas']['libre'], 1) if c.get('plazas', {}).get('libre') and c['admitidos'].get('libre') else None for c in con_admitidos])],
                        unidad2='/plaza', titulo='Admitidos de turno libre y admitidos por plaza', descripcion='Barras con los admitidos de turno libre de cada convocatoria y línea con el cociente entre admitidos y plazas.')
        tabla = g.tabla(['Exámenes', 'Admitidos libre', 'Reserva discapacidad', 'Admitidos interna', 'Plazas libre', 'Admitidos por plaza', 'Aprobados libre', 'Aprobados por cada 100 admitidos'],
                        [[c['examenes'], c['admitidos'].get('libre'), c['admitidos'].get('discapacidad'), c['admitidos'].get('interna'), c.get('plazas', {}).get('libre'),
                          fmt(c['admitidos']['libre'] / c['plazas']['libre'], 1) if c.get('plazas', {}).get('libre') and c['admitidos'].get('libre') else None,
                          c.get('aprobados', {}).get('libre'), fmt(pct(c.get('aprobados', {}).get('libre'), c['admitidos'].get('libre')), 1) if c.get('aprobados') and c['admitidos'].get('libre') else None] for c in con_admitidos])
        h.append(g.figura('g-admitidos', svg, 'Fuente: listas definitivas de admitidos (turno libre) del Ministerio de Economía, Comercio y Empresa.', tabla))

    # 3. Suspensos por ejercicio (turno libre)
    con_tasas = [c for c in conv if c.get('tasas_libre')]
    if con_tasas:
        e0, e1 = con_tasas[0]['examenes'], con_tasas[-1]['examenes']
        h.append(f'<h2 id="suspensos">Qué ejercicio elimina a más gente, {e0}-{e1}</h2>')
        h.append('<p>Porcentaje de aspirantes de turno libre que no supera cada uno de los cuatro primeros ejercicios, calculado sobre los que tenían que hacerlo: los admitidos para el primero y, para los siguientes, los aprobados del anterior menos quienes conservaban la nota de la convocatoria anterior (las listas de conservación de nota existen desde 2025). El porcentaje mezcla a quienes suspenden y a quienes no llegan a presentarse. La promoción interna no entra en este cálculo: los funcionarios A2 están exentos de parte del quinto ejercicio y, si vienen del Cuerpo de Diplomados Comerciales del Estado, del segundo y del quinto enteros.</p>')
        claves = ['1', '2', '3', '4']
        series = [(CORTOS[k], [100 - c['tasas_libre'][k]['superan_pct'] if c['tasas_libre'].get(k) else None for c in con_tasas]) for k in claves]
        svg = g.grafico([str(c['examenes']) for c in con_tasas], lineas=series, unidad=' %', y_max=100, titulo='Porcentaje que no supera cada ejercicio, por convocatoria (turno libre)',
                        descripcion='Líneas con el porcentaje de aspirantes de turno libre que no supera el primer, segundo, tercer y cuarto ejercicio en cada convocatoria.', etiquetas=False)
        filas = []
        for c in con_tasas:
            fila = [c['examenes']]
            for k in claves:
                t = c['tasas_libre'].get(k)
                fila.append(f"{fmt(t['aprobados'])} de {fmt(t['presentados'])} ({fmt(100 - t['superan_pct'])} %)" if t else None)
            filas.append(fila)
        tabla = g.tabla(['Exámenes', '1.º: aprueban de los que lo hacen (% que no)', '2.º', '3.º', '4.º'], filas)
        h.append(g.figura('g-suspensos', svg, 'Fuente: listas de admitidos, de aprobados de cada ejercicio y de conservación de nota publicadas por el tribunal en la página del Ministerio. En la convocatoria en curso faltan los ejercicios no celebrados.', tabla))
        medias = {k: media([100 - c['tasas_libre'][k]['superan_pct'] for c in con_tasas if c['tasas_libre'].get(k)], 0) for k in claves}
        peor = max((k for k in claves if medias[k] is not None), key=lambda k: medias[k])
        h.append('<p>De media no supera ' + ', '.join(f'el {CORTOS[k]} el {fmt(medias[k])} % de los que lo hacen' for k in claves if medias[k] is not None) + f'. El ejercicio que más gente deja fuera es el {CORTOS[peor]}. El quinto ejercicio (escrito) no elimina en la práctica a nadie: quien llega a él y se presenta lo supera, así que no aparece en el gráfico.</p>')
        h.append('<h3>Dentro del primer ejercicio: test y dictamen</h3>')
        h.append('<p>El primer ejercicio tiene dos partes: el test (quien no llega a la nota de corte no lee el dictamen) y el dictamen de coyuntura. Porcentaje que no supera cada parte, sobre los que tenían que hacerla:</p>')
        for ident, titulo, partes, caption in [
            ('g-primero', 'Porcentaje que no supera el test y el dictamen', [('1-test', 'Test'), ('1-dictamen', 'Dictamen')], 'Antes de 2021 el tribunal no publicaba lista aparte de la primera parte del primer ejercicio.'),
            ('g-segundo', 'Porcentaje que no supera el inglés y el segundo idioma', [('2-ingles', 'Inglés'), ('2-resto', 'Segundo idioma')], 'Algunos años el tribunal publica una sola lista del segundo ejercicio, sin separar los idiomas.')]:
            if ident == 'g-segundo':
                h.append('<h3>Dentro del segundo ejercicio: inglés y segundo idioma</h3>')
                h.append('<p>El segundo ejercicio tiene dos pruebas de idiomas, inglés y el segundo idioma elegido, y hay que aprobar las dos. Porcentaje que no supera cada prueba, sobre los que tenían que hacerla (descontando a quienes conservaban la nota de los dos idiomas):</p>')
            series = [(nombre, [100 - c['tasas_libre'][k]['superan_pct'] if c['tasas_libre'].get(k) else None for c in con_tasas]) for k, nombre in partes]
            svg = g.grafico([str(c['examenes']) for c in con_tasas], lineas=series, unidad=' %', y_max=100, titulo=titulo,
                            descripcion=f'Líneas con el porcentaje de aspirantes de turno libre que no supera {partes[0][1].lower()} y {partes[1][1].lower()} en cada convocatoria.', etiquetas=False, alto=300)
            filas = []
            for c in con_tasas:
                fila = [c['examenes']]
                for k, _ in partes:
                    t = c['tasas_libre'].get(k)
                    fila.append(f"{fmt(t['aprobados'])} de {fmt(t['presentados'])} ({fmt(100 - t['superan_pct'])} %)" if t else None)
                filas.append(fila)
            tabla = g.tabla(['Exámenes'] + [f'{nombre}: aprueban de los que lo hacen (% que no)' for _, nombre in partes], filas)
            h.append(g.figura(ident, svg, caption, tabla))

    # 4. Idiomas
    con_idiomas = [c for c in conv if c.get('idiomas', {}).get('elegidos')]
    if con_idiomas:
        total = Counter()
        for c in con_idiomas:
            total.update(c['idiomas']['elegidos'])
        suma = sum(total.values())
        i0, i1 = con_idiomas[0]['examenes'], con_idiomas[-1]['examenes']
        h.append(f'<h2 id="idiomas">El segundo idioma: cuál se elige y cuál se aprueba, {i0}-{i1}</h2>')
        h.append('<p>Además del inglés, obligatorio, cada admitido declara un segundo idioma. Reparto acumulado de las convocatorias con lista de admitidos:</p>')
        filas = [(k, v, None, f'{fmt(v)} ({fmt(100 * v / suma)} %)') for k, v in total.most_common()]
        svg = g.barras_horizontales(filas, titulo='Segundo idioma elegido por los admitidos', descripcion='Barras con el número de admitidos que eligen cada segundo idioma.')
        tabla = g.tabla(['Exámenes'] + [k for k, _ in total.most_common()], [[c['examenes']] + [c['idiomas']['elegidos'].get(k, 0) for k, _ in total.most_common()] for c in con_idiomas])
        h.append(g.figura('g-idiomas', svg, 'Fuente: listas definitivas de admitidos de turno libre (columna del segundo idioma).', tabla))
        con_si = [c for c in conv if c.get('idiomas', {}).get('segundo_idioma')]
        if con_si:
            llegan, aprueban = Counter(), Counter()
            for c in con_si:
                for i, v in c['idiomas']['segundo_idioma'].items():
                    llegan[i] += v['llegan']
                    aprueban[i] += v['aprueban']
            h.append(f'<h3>Aprobados del segundo idioma según el idioma elegido, {con_si[0]["examenes"]}-{con_si[-1]["examenes"]}</h3>')
            h.append('<p>De los aspirantes de turno libre que superan el primer ejercicio, cuántos aprueban la prueba de su segundo idioma, por idioma (sumando las convocatorias con lista de aprobados del segundo idioma; se cruzan las listas por nombre, así que es aproximado):</p>')
            orden = [i for i, _ in llegan.most_common()]
            filas = [(i, llegan[i], aprueban[i], f'{fmt(aprueban[i])} de {fmt(llegan[i])} ({fmt(pct(aprueban[i], llegan[i]))} %)') for i in orden]
            svg = g.barras_horizontales(filas, titulo='Aprobados del segundo idioma según el idioma elegido', descripcion='Para cada idioma, barra clara con los aspirantes que llegan a la prueba y barra oscura con los que la aprueban.')
            tabla = g.tabla(['Exámenes'] + [f'{i}: aprueban de los que llegan' for i in orden],
                            [[c['examenes']] + [(f"{c['idiomas']['segundo_idioma'][i]['aprueban']} de {c['idiomas']['segundo_idioma'][i]['llegan']}" if i in c['idiomas']['segundo_idioma'] else None) for i in orden] for c in con_si])
            h.append(g.figura('g-idiomas-aprobados', svg, 'Fuente: listas de aprobados del primer ejercicio y de la segunda parte del segundo ejercicio, cruzadas con la lista de admitidos. Los idiomas con pocos aspirantes dan porcentajes poco fiables.', tabla))
        vol = Counter()
        for c in con_idiomas:
            vol.update(c['idiomas'].get('voluntarios', {}))
        if vol:
            h.append('<p>Idiomas voluntarios declarados (puntúan hasta 4 puntos cada uno): ' + ', '.join(f'{k} ({v})' for k, v in vol.most_common()) + '.</p>')

    # 5. Repetidores
    con_rep = [c for c in conv if c.get('repetidores')]
    if con_rep:
        r0, r1 = con_rep[0]['examenes'], con_rep[-1]['examenes']
        h.append(f'<h2 id="repetidores">Cuántos aprobados ya se habían presentado antes, {r0}-{r1}</h2>')
        h.append(f'<p>Casi nadie aprueba a la primera. Aprobados de la fase de oposición que ya figuraban en la lista de admitidos de alguna convocatoria anterior (solo se puede comprobar desde las listas de {con_rep[0]["repetidores"]["desde"]}, así que en los primeros años el dato está por debajo del real; «admitido» no implica que llegara a examinarse):</p>')
        h.append(g.tabla(['Exámenes', 'Aprobados', 'Ya se habían presentado antes', 'Porcentaje'],
                         [[c['examenes'], c['repetidores']['aprobados'], c['repetidores']['ya_admitidos_antes'], f"{fmt(pct(c['repetidores']['ya_admitidos_antes'], c['repetidores']['aprobados']))} %"] for c in con_rep]))

    # 6. El cuerpo desde 1930 (promociones y asociados de la ATCEE)
    if cuerpo and cuerpo.get('promociones'):
        h.append(bloque_cuerpo(cuerpo))

    # 7. Tabla completa
    h.append('<h2 id="tabla">Tabla completa por convocatoria</h2>')
    filas = []
    for c in conv:
        p, a, ad, ej = c.get('plazas', {}), c.get('aprobados', {}), c.get('admitidos', {}), c.get('ejercicios', {})
        filas.append([c['examenes'], c.get('oep'), dmy(c.get('convocatoria', '')[:10]), p.get('libre'), p.get('interna'), ad.get('libre'), ad.get('interna'),
                      ej.get('1', {}).get('todos'), ej.get('2', {}).get('todos'), ej.get('3', {}).get('todos'), ej.get('4', {}).get('todos'), ej.get('5', {}).get('todos'), a.get('libre'), a.get('interna')])
    h.append(g.tabla(['Exámenes', 'OEP', 'Convocatoria', 'Plazas libre', 'Plazas interna', 'Admitidos libre', 'Admitidos interna', 'Aprueban 1.º', '2.º', '3.º', '4.º', '5.º', 'Aprobados libre', 'Aprobados interna'], filas))
    h.append('<p class="nota-metodo">Los aprobados por ejercicio de esta tabla incluyen todos los turnos. Los datos están también en <a href="cifras.json">cifras.json</a> (licencia CC BY-NC-ND 4.0, citando esta página).</p>')

    # 7. Método
    h.append('<h2 id="metodo">Método y fuentes</h2>')
    h.append('<ul>'
             '<li><strong>Plazas:</strong> la resolución de cada convocatoria en el BOE (turno libre, reserva de discapacidad y promoción interna). Las convocatorias se identifican por el año en que se celebran los exámenes: las publicadas en diciembre corresponden al año siguiente.</li>'
             '<li><strong>Aprobados:</strong> la relación de aprobados en la fase de oposición que el Ministerio publica en el BOE al terminar cada proceso, contando las filas por turno; para las convocatorias más antiguas, sin relación en el BOE con texto, el nombramiento de funcionarios en prácticas o, si falta, el de funcionarios de carrera, leídos por OCR. No se publican puntuaciones.</li>'
             '<li><strong>Admitidos, ejercicios, conservación de nota e idiomas:</strong> las listas definitivas de admitidos, las listas de aprobados de cada ejercicio y de cada parte, y las listas de aspirantes que conservan nota, de la página de cada convocatoria del Ministerio (desde la OEP 2018). Buena parte son imágenes escaneadas y se leen con reconocimiento óptico de caracteres: se cuentan las filas de cada lista, así que puede haber diferencias de una o dos personas con el documento original. Las tasas por ejercicio se calculan solo para el turno libre, porque la promoción interna tiene exenciones.</li>'
             '<li><strong>Idiomas y repetidores:</strong> cruces aproximados entre listas (aprobados con admitidos).</li>'
             '<li><strong>El cuerpo desde 1930:</strong> la relación de Técnicos Comerciales y Economistas del Estado por promociones y el listado de asociados de la Asociación de Técnicos Comerciales y Economistas del Estado, contando personas por promoción y por situación. Para las convocatorias antiguas sin relación de aprobados en el BOE, el tamaño de la promoción sustituye a la lectura por OCR de los nombramientos.</li>'
             '</ul>')
    h.append('<p>Si encuentras un dato que no cuadra con el documento original, <a href="../sobre-mi.html">escríbeme</a> y lo reviso.</p>')
    return '\n'.join(h)


def anio_examen_promocion(fecha):
    """Año de los exámenes de una promoción: el nombramiento de carrera llega al año siguiente (primer semestre) o al final del mismo año."""
    a, m = int(fecha[:4]), int(fecha[5:7])
    return a - 1 if m <= 6 else a


def bloque_cuerpo(cuerpo):
    proms = [p for p in cuerpo['promociones'] if p.get('anio')]
    aso = cuerpo.get('asociados', {})
    evo = cuerpo.get('evolucion_asociados', [])
    h = []
    primero, ultimo = proms[0]['anio'], proms[-1]['anio']
    total = sum(p['nombramientos'] for p in proms)
    h.append(f'<h2 id="cuerpo">El cuerpo desde 1930: cuántos entran cada año y cuántos están en activo</h2>')
    h.append(f'<p>La Asociación de Técnicos Comerciales y Economistas del Estado mantiene la relación de las {len(proms)} promociones del cuerpo (y de los dos cuerpos que lo precedieron) desde la primera, de {primero}: {fmt(total)} nombramientos en total. Nombramientos por año de la promoción:</p>')
    por_anio = Counter()
    for p in proms:
        por_anio[p['anio']] += p['nombramientos']
    svg = g.barras_fechas([p['fecha'] for p in proms], [f"{p['promocion']} · {dmy(p['fecha'])}" for p in proms], [('Nombramientos', [p['nombramientos'] for p in proms])],
                          titulo='Nombramientos de Técnicos Comerciales y Economistas del Estado por promoción',
                          descripcion=f'Una barra por promoción, en la fecha de su nombramiento, con el número de personas, de {primero} a {ultimo}.')
    tabla = g.tabla(['Promoción', 'Nombramiento', 'Personas'], [[p['promocion'], dmy(p['fecha']), p['nombramientos']] for p in proms])
    h.append(g.figura('g-promociones', svg, 'Fuente: «TCEE por promociones», Asociación de Técnicos Comerciales y Economistas del Estado. Cada barra es una promoción, en la fecha exacta de su nombramiento.', tabla))
    decadas = Counter()
    for a, n in por_anio.items():
        decadas[a // 10 * 10] += n
    h.append('<p>Por décadas: ' + ', '.join(f'{d}-{d + 9}: {fmt(n)}' for d, n in sorted(decadas.items())) + '.</p>')
    if aso.get('por_situacion'):
        ps = aso['por_situacion']
        h.append(f'<h3>Situación de los asociados ({dmy(aso.get("fecha", ""))})</h3>')
        h.append(f'<p>El listado de asociados de la ATCEE, que no incluye a todo el cuerpo ni está siempre al día, cuenta {fmt(aso["total"])} personas: {fmt(ps.get("activo", 0))} en activo, {fmt(ps.get("servicios_especiales", 0))} en servicios especiales, {fmt(ps.get("excedente", 0))} en excedencia y {fmt(ps.get("jubilado", 0))} jubiladas. Cada asociado se asigna a su promoción cruzando el listado con la relación de promociones de la propia ATCEE y, si no aparece en ella, por la fecha de nombramiento. Cada barra suma todas las personas de la promoción: las que están en el listado, por su situación, y en gris claro las que no figuran en él (en las primeras promociones, casi todas):</p>')
        pp = aso.get('por_promocion', {})
        con = [p for p in proms if not p.get('ampliacion')]
        for p in con:
            pp.setdefault(p['promocion'], {})
        claves = [('activo', 'En activo', 'var(--color-primary)'), ('servicios_especiales', 'Servicios especiales', 'var(--color-primary-light)'), ('excedente', 'Excedencia', 'var(--color-accent-gold)'), ('jubilado', 'Jubilación', 'var(--color-border-strong)')]
        def sin_dato(p):
            """Personas de la promoción que no están en el listado o sin situación: la barra suma el total de la promoción."""
            return max(p['nombramientos'] - sum(v for k, v in pp[p['promocion']].items() if k != 'sin_dato'), 0)
        series = [(nombre, [pp[p['promocion']].get(k) or None for p in con], color) for k, nombre, color in claves]
        series.append(('No hay dato (no asociados)', [sin_dato(p) or None for p in con], 'var(--color-border-light)'))
        svg = g.barras_fechas([p['fecha'] for p in con], [f"{p['promocion']} · {dmy(p['fecha'])}" for p in con], series, apiladas=True,
                              titulo='Promociones por situación de sus miembros', descripcion='Columnas apiladas, una por promoción en la fecha de su nombramiento: asociados en activo, en servicios especiales, en excedencia o jubilados, y personas sin dato porque no figuran en el listado de asociados; la suma es el total de la promoción.')
        tabla = g.tabla(['Promoción', 'Nombramiento', 'En activo', 'Servicios especiales', 'Excedencia', 'Jubilación', 'No hay dato', 'Personas en la promoción'],
                        [[p['promocion'], dmy(p['fecha']), pp[p['promocion']].get('activo', 0), pp[p['promocion']].get('servicios_especiales', 0), pp[p['promocion']].get('excedente', 0), pp[p['promocion']].get('jubilado', 0), sin_dato(p), p['nombramientos']] for p in con])
        h.append(g.figura('g-asociados', svg, f'Fuente: listado de asociados de la ATCEE, {dmy(aso.get("fecha", ""))}' + (f'; no aparecen {fmt(aso["sin_promocion"])} asociados que no se han podido asignar a una promoción' if aso.get('sin_promocion') else '') + '.', tabla))
    if len(evo) > 1:
        h.append('<h3>Evolución de los asociados por situación</h3>')
        svg = g.grafico([dmy(e['fecha']) for e in evo], lineas=[('En activo', [e['activo'] for e in evo]), ('Servicios especiales', [e['servicios_especiales'] for e in evo]), ('Excedencia', [e['excedente'] for e in evo]), ('Jubilación', [e['jubilado'] for e in evo])],
                        titulo='Asociados por situación en cada lectura del listado', descripcion='Líneas con los asociados en activo, en servicios especiales, en excedencia y jubilados en cada fecha en que se leyó el listado.')
        h.append(g.figura('g-evolucion-asociados', svg, 'Cada punto es una lectura del listado de asociados de la ATCEE.'))
    return '\n'.join(h)


def bloque_guia(conv):
    con_plazas = [c for c in conv if c.get('plazas', {}).get('libre')]
    completas = [c for c in con_plazas if c.get('aprobados') and c['aprobados'].get('fuente', '').startswith('relaci')]
    con_admitidos = [c for c in conv if c.get('admitidos') and c.get('plazas', {}).get('libre')]
    ult = completas[-1]
    h = ['<p>Calculadas con los documentos oficiales (convocatorias y aprobados del BOE y listas del Ministerio); el detalle, convocatoria a convocatoria y con gráficos, está en <a href="cifras.html">La oposición a TCEE en cifras</a>.</p>']
    tarjetas = [tarjeta(fmt(media([c['plazas']['libre'] for c in con_plazas[-10:]], 1), 1), f'plazas de turno libre al año de media ({con_plazas[-10]["examenes"]}-{con_plazas[-1]["examenes"]})')]
    if con_admitidos:
        tarjetas.append(tarjeta(fmt(media([c['admitidos']['libre'] / c['plazas']['libre'] for c in con_admitidos], 1), 1), f'admitidos por cada plaza de turno libre ({con_admitidos[0]["examenes"]}-{con_admitidos[-1]["examenes"]})'))
    cob = [pct(c['aprobados']['libre'], c['plazas']['libre']) for c in completas]
    tarjetas.append(tarjeta(f'{fmt(media(cob))} %', f'de las plazas de turno libre se cubren ({completas[0]["examenes"]}-{completas[-1]["examenes"]})'))
    con_t = [c for c in conv if c.get('tasas_libre', {}).get('1')]
    if con_t:
        tarjetas.append(tarjeta(f'{fmt(media([100 - c["tasas_libre"]["1"]["superan_pct"] for c in con_t]))} %', 'de los admitidos de turno libre no supera el primer ejercicio (test y dictamen)'))
    h.append('<ul class="cifras-clave">' + ''.join(tarjetas) + '</ul>')
    h.append(g.figura('g-guia-plazas', grafico_plazas(con_plazas, alto=300, etiquetas=False), f'Plazas de turno libre por año de los exámenes, {con_plazas[0]["examenes"]}-{con_plazas[-1]["examenes"]}: aprobados y plazas sin cubrir. Fuente: BOE.'))
    h.append(f'<p>En la última convocatoria con resultados ({ult["examenes"]}) aprobaron {ult["aprobados"]["libre"]} de las {ult["plazas"]["libre"]} plazas de turno libre'
             + (f' y se presentaron {fmt(ult["admitidos"]["libre"])} admitidos' if ult.get('admitidos', {}).get('libre') else '') + '. <a href="cifras.html">Ver todas las cifras</a>.</p>')
    return '\n'.join(h)


def sustituir(html, inicio, fin, nuevo):
    a = html.index(inicio) + len(inicio)
    b = html.index(fin)
    return html[:a] + '\n' + nuevo + '\n' + html[b:]


def limpiar_json(conv):
    return [{k: v for k, v in c.items() if not k.startswith('_')} for c in conv]


CUERPO = RAIZ / 'oposicion' / 'cuerpo.json'


def generar(crudo, convocatorias_boe, aprobados_boe):
    cuerpo = json.loads(CUERPO.read_text(encoding='utf-8')) if CUERPO.exists() else None
    conv = agregar(crudo, convocatorias_boe, aprobados_boe, cuerpo)
    hoy = date.today()
    meses = ['enero', 'febrero', 'marzo', 'abril', 'mayo', 'junio', 'julio', 'agosto', 'septiembre', 'octubre', 'noviembre', 'diciembre']
    hoy_texto = f'{hoy.day} de {meses[hoy.month - 1]} de {hoy.year}'
    limpio = limpiar_json(conv)
    JSON.write_text(json.dumps({'actualizado': hoy.isoformat(), 'fuente': 'BOE y Ministerio de Economía, Comercio y Empresa; cálculo propio',
                                'licencia': 'CC BY-NC-ND 4.0', 'convocatorias': limpio}, ensure_ascii=False, indent=1), encoding='utf-8')
    html = PAGINA.read_text(encoding='utf-8')
    html = sustituir(html, '<!-- cifras:inicio -->', '<!-- cifras:fin -->', bloque_pagina(limpio, hoy_texto, cuerpo))
    html = re.sub(r'"temporalCoverage": "[^"]*"', f'"temporalCoverage": "{limpio[0]["examenes"]}/{limpio[-1]["examenes"]}"', html)
    html = re.sub(r'"dateModified": "[^"]*"', f'"dateModified": "{hoy.isoformat()}"', html)
    PAGINA.write_text(html, encoding='utf-8')
    guia = GUIA.read_text(encoding='utf-8')
    if '<!-- cifras:inicio -->' in guia:
        guia = sustituir(guia, '<!-- cifras:inicio -->', '<!-- cifras:fin -->', bloque_guia(limpio))
        GUIA.write_text(guia, encoding='utf-8')
    print(f'cifras.json: {len(limpio)} convocatorias ({limpio[0]["examenes"]}-{limpio[-1]["examenes"]}); página y guía escritas.')
    return limpio
