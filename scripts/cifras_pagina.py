"""Agrega los datos crudos de «La oposición a TCEE en cifras» y escribe
oposicion/cifras.json, la página oposicion/cifras.html y el resumen de la
guía (lo usa cifras-oposicion.py). En la salida nunca hay nombres."""
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
EJERCICIOS = {'1-test': 'Test', '1': 'Primer ejercicio', '2': 'Segundo ejercicio (idiomas)', '3': 'Tercer ejercicio', '4': 'Cuarto ejercicio', '5': 'Quinto ejercicio'}
CORTOS = {'1': '1.º (test y dictamen)', '2': '2.º (idiomas)', '3': '3.º', '4': '4.º', '5': '5.º'}


def fmt(v, d=0):
    if v is None:
        return '—'
    return f'{v:,.{d}f}'.replace(',', ' ').replace('.', ',')


def pct(a, b):
    return round(100 * a / b, 1) if a is not None and b else None


def anio_examen(fecha_convocatoria):
    """Año en que se hacen los exámenes: el mismo si la convocatoria sale en el
    primer semestre; el siguiente si sale en el segundo (diciembre)."""
    a, m = int(fecha_convocatoria[:4]), int(fecha_convocatoria[5:7])
    return a if m <= 6 else a + 1


def media(xs, d=1):
    return round(statistics.mean(xs), d) if xs else None


def mediana(xs, d=1):
    return round(statistics.median(xs), d) if xs else None


def parecidos(nombre, candidatos, umbral=0.85):
    """¿Aparece el nombre (normalizado, con errores de OCR) en el conjunto? Vale
    si los apellidos y el nombre están entre las palabras del candidato (los
    admitidos llevan apellidos y nombre en otro orden) o si se parecen mucho."""
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
        if abs(len(c) - len(nombre)) <= 8 and difflib.SequenceMatcher(None, compacto, c.replace(' ', '')).ratio() >= umbral:
            return True
    return False


def agregar(crudo, convocatorias_boe, aprobados_boe):
    """Una entrada por convocatoria (del BOE), ordenada por el año de los exámenes."""
    por_fecha = {}
    # 1. Convocatorias del BOE: plazas
    for fecha, c in sorted(convocatorias_boe.items()):
        if not c.get('libre'):
            continue
        por_fecha[fecha] = {'examenes': anio_examen(fecha), 'convocatoria': fecha, 'boe_convocatoria': c['id'], 'oep': c.get('oep'),
                            'plazas': {'libre': c.get('libre'), 'libre_discapacidad': c.get('libre_discapacidad'),
                                       'interna': c.get('interna'), 'interna_discapacidad': c.get('interna_discapacidad'), 'lectura_ocr': bool(c.get('ocr'))}}
    fechas = sorted(por_fecha)

    def anterior(fecha_doc, meses=20):
        """La convocatoria más reciente anterior a un documento (hasta `meses` antes)."""
        cands = [f for f in fechas if f < fecha_doc and (int(fecha_doc[:4]) - int(f[:4])) * 12 + int(fecha_doc[4:6]) - int(f[5:7]) <= meses]
        return cands[-1] if cands else None

    # 2. Aprobados finales del BOE: las relaciones por su referencia a la convocatoria;
    #    los nombramientos antiguos, por la convocatoria anterior más cercana
    for a in sorted(aprobados_boe, key=lambda a: (a['tipo'] != 'aprobados', a['fecha'])):
        if a['tipo'] not in ('aprobados', 'practicas'):
            continue
        f = a['convocatoria'] if a['convocatoria'] in por_fecha else anterior(a['fecha'])
        if not f:
            continue
        e = por_fecha[f]
        if 'aprobados' in e and (e['aprobados']['fuente'].startswith('relaci') or e['aprobados']['libre'] >= a['libre']):
            continue
        e['aprobados'] = {'libre': a['libre'], 'interna': a['interna'], 'boe': a['id'], 'publicado': a['fecha'],
                          'fuente': 'relación de aprobados' if a['tipo'] == 'aprobados' else 'nombramiento de funcionarios en prácticas (lectura OCR)'}
    # Dos convocatorias con exámenes el mismo año (1991): la segunda se cuenta en el siguiente
    vistos = set()
    for f in fechas:
        while por_fecha[f]['examenes'] in vistos:
            por_fecha[f]['examenes'] += 1
        vistos.add(por_fecha[f]['examenes'])
    por_examen = {e['examenes']: e for e in por_fecha.values()}
    # 3. Documentos del Ministerio: admitidos, ejercicios, idiomas (desde 2018)
    nombres_admitidos = {}  # año de examen → conjunto de nombres (solo en memoria)
    for anio, d in sorted(crudo.items()):
        anio = int(anio)
        # La convocatoria OEP «anio» del Ministerio: la del BOE con ese oep, o la del año siguiente de exámenes
        ae = next((e['examenes'] for e in por_examen.values() if e.get('oep') == anio), anio + 1)
        e = por_examen.setdefault(ae, {'examenes': ae})
        e['oep'] = anio
        e['pagina_ministerio'] = f'https://portal.mineco.gob.es/es-es/ministerio/empleo/Paginas/OEP{anio}TECOS.aspx'
        adm = {t: v['n'] for t, v in d['admitidos'].items()}
        if adm:
            e['admitidos'] = {'libre': adm.get('tl'), 'discapacidad': adm.get('disc'), 'interna': adm.get('pi'),
                              'total': sum(v for v in adm.values() if v)}
        ej = {}
        for clave, turnos in d['ejercicios'].items():
            if clave in ('aprobados_final', 'fase_oposicion'):
                continue
            n = sum(v['n'] for v in turnos.values())
            notas = [x for v in turnos.values() for x in v['notas']]
            ej[clave] = {'aprobados': n, 'libre': turnos.get('tl', {}).get('n') or (turnos.get('todos', {}).get('n') if 'pi' not in turnos else None), 'interna': turnos.get('pi', {}).get('n')}
        if '2-total' in ej or '2-ingles' in ej or '2-resto' in ej:
            tot = ej.pop('2-total', None) or ej.get('2-resto') or ej.get('2-ingles')
            ej['2'] = tot
            ej['2-ingles'] = ej.pop('2-ingles', None)
            ej['2-resto'] = ej.pop('2-resto', None)
            ej = {k: v for k, v in ej.items() if v}
        e['ejercicios'] = ej
        if d.get('idiomas'):
            e['idiomas'] = d['idiomas']
        if 'fase_oposicion' in d['ejercicios']:
            e['aprobados_fase_oposicion_ministerio'] = d['ejercicios']['fase_oposicion']['todos']['n']
        # Nombres (solo para calcular repetidores; no salen de aquí)
        nombres_admitidos[ae] = set(d['nombres'].get('admitidos_tl', [])) | set(d['nombres'].get('admitidos_disc', []))
        finales = d['ejercicios'].get('fase_oposicion', d['ejercicios'].get('aprobados_final', {})).get('todos', {}).get('nombres', [])
        e['_nombres_finales'] = finales
    # 3b. Plazas leídas por OCR que no cuadran con los aprobados: mejor en blanco
    for e in por_examen.values():
        p = e.get('plazas', {})
        if p.get('lectura_ocr') and p.get('libre') and e.get('aprobados', {}).get('libre', 0) > p['libre']:
            p['libre'] = None
    # 4. Repetidores: aprobados que ya estaban admitidos en una convocatoria anterior (de las que tenemos listas)
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


def bloque_pagina(conv, hoy):
    """El HTML de la página de cifras (entre los marcadores)."""
    con_plazas = [c for c in conv if c.get('plazas', {}).get('libre')]
    con_aprobados = [c for c in conv if c.get('aprobados')]
    con_admitidos = [c for c in conv if c.get('admitidos')]
    completas = [c for c in con_plazas if c.get('aprobados') and c['aprobados'].get('fuente', '').startswith('relaci')]
    primero, ultimo = con_plazas[0]['examenes'], con_plazas[-1]['examenes']
    h = []
    h.append(f'<p class="actualizado">Por <a href="../sobre-mi.html">Víctor Gutiérrez Marcos</a>, Técnico Comercial y Economista del Estado · Actualizado el {hoy}</p>')
    h.append('<p>Todo lo que hay en esta página sale de los documentos oficiales: las convocatorias y las relaciones de aprobados publicadas en el BOE y, desde la oferta de empleo público de 2018, las listas de admitidos y de aprobados de cada ejercicio que publica el Ministerio de Economía, Comercio y Empresa. Los cálculos los hace un programa que lee esos documentos (muchos son imágenes escaneadas, así que puede haber algún error de lectura de una o dos unidades); solo se publican recuentos, medias y porcentajes, nunca datos de personas. Las series llegan hasta donde llegan los documentos: cada gráfico indica desde qué año hay datos.</p>')
    # Cifras clave
    ult = completas[-1] if completas else con_plazas[-1]
    plazas_media = media([c['plazas']['libre'] for c in con_plazas[-10:]], 1)
    cobertura = [pct(c['aprobados']['libre'], c['plazas']['libre']) for c in completas]
    ratio = [round(c['admitidos']['libre'] / c['plazas']['libre'], 1) for c in con_admitidos if c.get('plazas', {}).get('libre')]
    tarjetas = [tarjeta(fmt(ult['plazas']['libre']), f'plazas de turno libre en la última convocatoria ({ult["examenes"]})'),
                tarjeta(fmt(plazas_media, 1), f'plazas de turno libre al año de media en las últimas {len(con_plazas[-10:])} convocatorias')]
    if ratio:
        tarjetas.append(tarjeta(fmt(media(ratio), 1), f'admitidos por cada plaza de turno libre ({con_admitidos[0]["examenes"]}-{con_admitidos[-1]["examenes"]})'))
    if cobertura:
        tarjetas.append(tarjeta(f'{fmt(media(cobertura), 0)} %', f'de las plazas de turno libre se cubren de media ({completas[0]["examenes"]}-{completas[-1]["examenes"]})'))
    h.append('<ul class="cifras-clave">' + ''.join(tarjetas) + '</ul>')
    h.append('<nav class="guia-indice" aria-label="Contenido"><ul><li><a href="#plazas">Plazas y aprobados</a></li><li><a href="#admitidos">Admitidos por plaza</a></li><li><a href="#embudo">Qué ejercicio elimina más</a></li><li><a href="#idiomas">Idiomas</a></li><li><a href="#repetidores">Cuántos repiten</a></li><li><a href="#tabla">Tabla completa</a></li><li><a href="#metodo">Método y fuentes</a></li></ul></nav>')

    # 1. Plazas y aprobados (serie larga)
    anios = [str(c['examenes']) for c in con_plazas]
    h.append(f'<h2 id="plazas">Plazas convocadas y aprobados, {primero}-{ultimo}</h2>')
    h.append('<p>Plazas de turno libre de cada convocatoria (por el año en que se celebran los exámenes) y cuántas se cubrieron: los aprobados de la fase de oposición que publica el BOE. La promoción interna, reservada a funcionarios A2, va aparte.</p>')
    svg = g.grafico(anios, barras=[('Plazas de turno libre', [c['plazas']['libre'] for c in con_plazas]), ('Aprobados de turno libre', [c.get('aprobados', {}).get('libre') for c in con_plazas])],
                    titulo='Plazas convocadas y aprobados de turno libre por convocatoria', descripcion=f'Barras con las plazas de turno libre y los aprobados de cada convocatoria entre {primero} y {ultimo}.')
    tabla = g.tabla(['Exámenes', 'Convocatoria (BOE)', 'Plazas libre', 'Reserva discapacidad', 'Plazas interna', 'Aprobados libre', 'Aprobados interna', 'Cobertura libre'],
                    [[c['examenes'], c.get('convocatoria', '')[:10], c['plazas']['libre'], c['plazas'].get('libre_discapacidad'), c['plazas'].get('interna'),
                      c.get('aprobados', {}).get('libre'), c.get('aprobados', {}).get('interna'), (f"{fmt(pct(c['aprobados']['libre'], c['plazas']['libre']))} %" if c.get('aprobados') else None)] for c in con_plazas])
    h.append(g.figura('g-plazas', svg, 'Fuente: convocatorias y relaciones de aprobados en la fase de oposición publicadas en el BOE. Las convocatorias en curso aún no tienen aprobados.', tabla))
    if cobertura:
        sin_cubrir = [c for c in completas if c['aprobados']['libre'] < c['plazas']['libre']]
        h.append(f'<p>En las {len(completas)} convocatorias con relación de aprobados en el BOE ({completas[0]["examenes"]}-{completas[-1]["examenes"]}), las plazas de turno libre se cubrieron de media al {fmt(media(cobertura))} %; en {len(completas) - len(sin_cubrir)} se cubrieron todas y en {len(sin_cubrir)} quedaron plazas desiertas'
                 + (' (' + ', '.join(f'{c["examenes"]}: {c["plazas"]["libre"] - c["aprobados"]["libre"]}' for c in sin_cubrir) + ')' if sin_cubrir else '') + '. Los aprobados de las convocatorias anteriores a 1996 salen de los nombramientos de funcionarios en prácticas leídos por OCR y son aproximados.</p>')

    # 2. Admitidos
    if con_admitidos:
        a0, a1 = con_admitidos[0]['examenes'], con_admitidos[-1]['examenes']
        anios_a = [str(c['examenes']) for c in con_admitidos]
        h.append(f'<h2 id="admitidos">Cuántos se presentan: admitidos por plaza, {a0}-{a1}</h2>')
        h.append('<p>Las listas definitivas de admitidos del Ministerio existen desde la oferta de empleo público de 2018. No todos los admitidos llegan a examinarse, pero es la mejor medida de cuánta gente opta a cada plaza.</p>')
        svg = g.grafico(anios_a, barras=[('Admitidos de turno libre', [c['admitidos']['libre'] for c in con_admitidos])],
                        lineas=[('Admitidos por plaza', [round(c['admitidos']['libre'] / c['plazas']['libre'], 1) if c.get('plazas', {}).get('libre') and c['admitidos'].get('libre') else None for c in con_admitidos])],
                        unidad2='/plaza', titulo='Admitidos de turno libre y admitidos por plaza', descripcion='Barras con los admitidos de turno libre de cada convocatoria y línea con el cociente entre admitidos y plazas.')
        tabla = g.tabla(['Exámenes', 'Admitidos libre', 'Reserva discapacidad', 'Admitidos interna', 'Plazas libre', 'Admitidos por plaza', 'Aprobados libre', 'Aprobados por cada 100 admitidos'],
                        [[c['examenes'], c['admitidos'].get('libre'), c['admitidos'].get('discapacidad'), c['admitidos'].get('interna'), c.get('plazas', {}).get('libre'),
                          fmt(c['admitidos']['libre'] / c['plazas']['libre'], 1) if c.get('plazas', {}).get('libre') and c['admitidos'].get('libre') else None,
                          c.get('aprobados', {}).get('libre'), fmt(pct(c.get('aprobados', {}).get('libre'), c['admitidos'].get('libre')), 1) if c.get('aprobados') and c['admitidos'].get('libre') else None] for c in con_admitidos])
        h.append(g.figura('g-admitidos', svg, 'Fuente: listas definitivas de admitidos (turno libre) del Ministerio de Economía, Comercio y Empresa.', tabla))

    # 3. Embudo por ejercicio
    con_ej = [c for c in conv if c.get('ejercicios')]
    if con_ej:
        e0, e1 = con_ej[0]['examenes'], con_ej[-1]['examenes']
        h.append(f'<h2 id="embudo">Qué ejercicio elimina a más gente, {e0}-{e1}</h2>')
        h.append('<p>Aprobados de cada ejercicio (turno libre y promoción interna juntos) según las listas del tribunal. La bajada de un ejercicio al siguiente mezcla a quienes suspenden y a quienes no se presentan; el primer ejercicio se compara con los admitidos.</p>')
        claves = ['1', '2', '3', '4', '5']
        series = []
        for k in claves:
            series.append((CORTOS[k], [c['ejercicios'].get(k, {}).get('aprobados') for c in con_ej]))
        svg = g.grafico([str(c['examenes']) for c in con_ej], lineas=series, titulo='Aprobados de cada ejercicio por convocatoria',
                        descripcion='Líneas con el número de aprobados del primer, segundo, tercer, cuarto y quinto ejercicio en cada convocatoria.', etiquetas=False)
        filas = []
        for c in con_ej:
            adm = c.get('admitidos', {}).get('total')
            fila = [c['examenes'], adm]
            anterior = adm
            for k in claves:
                n = c['ejercicios'].get(k, {}).get('aprobados')
                fila.append(f'{fmt(n)} ({fmt(pct(n, anterior))} %)' if n is not None and anterior else (fmt(n) if n is not None else None))
                if n is not None:
                    anterior = n
            filas.append(fila)
        tabla = g.tabla(['Exámenes', 'Admitidos', 'Aprueban 1.º (% de admitidos)', 'Aprueban 2.º (% del 1.º)', 'Aprueban 3.º (% del 2.º)', 'Aprueban 4.º (% del 3.º)', 'Aprueban 5.º (% del 4.º)'], filas)
        h.append(g.figura('g-embudo', svg, 'Fuente: listas de aprobados de cada ejercicio publicadas por el tribunal en la página del Ministerio. En la convocatoria en curso faltan los ejercicios no celebrados.', tabla))
        # Porcentaje medio que pasa cada ejercicio
        medias = []
        for k in claves:
            tasas = []
            for c in con_ej:
                n = c['ejercicios'].get(k, {}).get('aprobados')
                prev = c.get('admitidos', {}).get('total') if k == '1' else c['ejercicios'].get(str(int(k) - 1), {}).get('aprobados')
                if n is not None and prev:
                    tasas.append(100 * n / prev)
            medias.append((EJERCICIOS[k], media(tasas, 0) if tasas else None, len(tasas)))
        h.append('<p>De media, ' + ', '.join(f'aprueban el {k.lower()} el {fmt(m)} % de los que llegan a él' if m is not None else '' for k, m, n in medias if m is not None) + '. ' +
                 'El primer ejercicio es, con diferencia, el que más gente deja fuera.</p>' if medias else '')

    # 5. Idiomas
    con_idiomas = [c for c in conv if c.get('idiomas', {}).get('elegidos')]
    if con_idiomas:
        total = Counter()
        for c in con_idiomas:
            total.update(c['idiomas']['elegidos'])
        suma = sum(total.values())
        i0, i1 = con_idiomas[0]['examenes'], con_idiomas[-1]['examenes']
        h.append(f'<h2 id="idiomas">Qué segundo idioma se elige, {i0}-{i1}</h2>')
        h.append('<p>Además del inglés, obligatorio, cada admitido de turno libre declara un segundo idioma. Reparto acumulado de las convocatorias con lista de admitidos:</p>')
        filas = [(k, v, None, f'{fmt(v)} ({fmt(100 * v / suma)} %)') for k, v in total.most_common()]
        svg = g.barras_horizontales(filas, titulo='Segundo idioma elegido por los admitidos', descripcion='Barras con el número de admitidos que eligen cada segundo idioma.')
        tabla = g.tabla(['Exámenes'] + [k for k, _ in total.most_common()], [[c['examenes']] + [c['idiomas']['elegidos'].get(k, 0) for k, _ in total.most_common()] for c in con_idiomas])
        h.append(g.figura('g-idiomas', svg, 'Fuente: listas definitivas de admitidos de turno libre (columna del segundo idioma).', tabla))
        vol = Counter()
        for c in con_idiomas:
            vol.update(c['idiomas'].get('voluntarios', {}))
        if vol:
            h.append('<p>Idiomas voluntarios declarados (puntúan hasta 4 puntos cada uno): ' + ', '.join(f'{k} ({v})' for k, v in vol.most_common()) + '.</p>')

    # 6. Repetidores
    con_rep = [c for c in conv if c.get('repetidores')]
    if con_rep:
        r0, r1 = con_rep[0]['examenes'], con_rep[-1]['examenes']
        h.append(f'<h2 id="repetidores">Cuántos aprobados ya se habían presentado antes, {r0}-{r1}</h2>')
        h.append(f'<p>Casi nadie aprueba a la primera. Aprobados de la fase de oposición que ya figuraban en la lista de admitidos de alguna convocatoria anterior (solo se puede comprobar desde las listas de {con_rep[0]["repetidores"]["desde"]}, así que en los primeros años el dato está por debajo del real; «admitido» no implica que llegara a examinarse):</p>')
        tabla = g.tabla(['Exámenes', 'Aprobados', 'Ya se habían presentado antes', 'Porcentaje'],
                        [[c['examenes'], c['repetidores']['aprobados'], c['repetidores']['ya_admitidos_antes'], f"{fmt(pct(c['repetidores']['ya_admitidos_antes'], c['repetidores']['aprobados']))} %"] for c in con_rep])
        h.append(tabla)

    # 7. Tabla completa
    h.append('<h2 id="tabla">Tabla completa por convocatoria</h2>')
    filas = []
    for c in conv:
        p, a, ad = c.get('plazas', {}), c.get('aprobados', {}), c.get('admitidos', {})
        filas.append([c['examenes'], c.get('oep'), c.get('convocatoria', '')[:10], p.get('libre'), p.get('interna'), ad.get('libre'), ad.get('interna'),
                      c.get('ejercicios', {}).get('1', {}).get('aprobados'), c.get('ejercicios', {}).get('2', {}).get('aprobados'), c.get('ejercicios', {}).get('3', {}).get('aprobados'),
                      c.get('ejercicios', {}).get('4', {}).get('aprobados'), c.get('ejercicios', {}).get('5', {}).get('aprobados'), a.get('libre'), a.get('interna')])
    h.append(g.tabla(['Exámenes', 'OEP', 'Convocatoria', 'Plazas libre', 'Plazas interna', 'Admitidos libre', 'Admitidos interna', 'Aprueban 1.º', '2.º', '3.º', '4.º', '5.º', 'Aprobados libre', 'Aprobados interna'], filas))
    h.append('<p class="nota-metodo">Los datos están también en <a href="cifras.json">cifras.json</a> (licencia CC BY-NC-ND 4.0, citando esta página).</p>')

    # 8. Método
    h.append('<h2 id="metodo">Método y fuentes</h2>')
    h.append('<ul>'
             '<li><strong>Plazas:</strong> la resolución de cada convocatoria en el BOE (turno libre, reserva de discapacidad y promoción interna). Las convocatorias se identifican por el año en que se celebran los exámenes: las publicadas en diciembre corresponden al año siguiente.</li>'
             '<li><strong>Aprobados:</strong> la relación de aprobados en la fase de oposición que el Ministerio publica en el BOE al terminar cada proceso, contando las filas por turno; para las convocatorias más antiguas, sin relación en el BOE con texto, el nombramiento de funcionarios en prácticas leído por OCR. No se publican puntuaciones.</li>'
             '<li><strong>Admitidos, ejercicios e idiomas:</strong> las listas definitivas de admitidos y las listas de aprobados de cada ejercicio de la página de cada convocatoria del Ministerio (desde la OEP 2018). Buena parte son imágenes escaneadas y se leen con reconocimiento óptico de caracteres; el programa cuenta las filas de cada lista, así que puede haber diferencias de una o dos personas con el documento original.</li>'
             '<li><strong>Repetidores:</strong> comparación aproximada de apellidos y nombre entre la lista de aprobados y las listas de admitidos anteriores, hecha en el ordenador que calcula las cifras. Ni los nombres ni las listas se publican: aquí solo hay recuentos.</li>'
             '<li>El programa es <a href="https://github.com/vgutierrezmarcos/victorgutierrezmarcos.github.io/blob/main/scripts/cifras-oposicion.py" target="_blank" rel="noopener">scripts/cifras-oposicion.py</a> del repositorio de la web; se vuelve a ejecutar al terminar cada convocatoria.</li>'
             '</ul>')
    h.append('<p>Si encuentras un dato que no cuadra con el documento original, <a href="../sobre-mi.html">escríbeme</a> y lo reviso.</p>')
    return '\n'.join(h)


def bloque_guia(conv):
    """Resumen para «La oposición en cifras» de la guía: cuatro cifras y el gráfico de plazas y aprobados."""
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
    con_ej = [c for c in conv if c.get('ejercicios', {}).get('1', {}).get('aprobados') and c.get('admitidos', {}).get('total')]
    if con_ej:
        tarjetas.append(tarjeta(f'{fmt(media([pct(c["ejercicios"]["1"]["aprobados"], c["admitidos"]["total"]) for c in con_ej]))} %', 'de los admitidos superan el primer ejercicio (test y dictamen)'))
    h.append('<ul class="cifras-clave">' + ''.join(tarjetas) + '</ul>')
    anios = [str(c['examenes']) for c in con_plazas]
    svg = g.grafico(anios, barras=[('Plazas de turno libre', [c['plazas']['libre'] for c in con_plazas]), ('Aprobados de turno libre', [c.get('aprobados', {}).get('libre') for c in con_plazas])],
                    titulo='Plazas convocadas y aprobados de turno libre por convocatoria', descripcion='Barras con las plazas de turno libre y los aprobados de cada convocatoria.', alto=300, etiquetas=len(anios) <= 14)
    h.append(g.figura('g-guia-plazas', svg, f'Plazas y aprobados de turno libre por año de los exámenes, {con_plazas[0]["examenes"]}-{con_plazas[-1]["examenes"]}. Fuente: BOE.'))
    h.append(f'<p>En la última convocatoria con resultados ({ult["examenes"]}) aprobaron {ult["aprobados"]["libre"]} de las {ult["plazas"]["libre"]} plazas de turno libre'
             + (f' y se presentaron {fmt(ult["admitidos"]["libre"])} admitidos' if ult.get('admitidos', {}).get('libre') else '') + '. <a href="cifras.html">Ver todas las cifras</a>.</p>')
    return '\n'.join(h)


def sustituir(html, inicio, fin, nuevo):
    a = html.index(inicio) + len(inicio)
    b = html.index(fin)
    return html[:a] + '\n' + nuevo + '\n' + html[b:]


def limpiar_json(conv):
    return [{k: v for k, v in c.items() if not k.startswith('_')} for c in conv]


def generar(crudo, convocatorias_boe, aprobados_boe):
    conv = agregar(crudo, convocatorias_boe, aprobados_boe)
    hoy = date.today()
    meses = ['enero', 'febrero', 'marzo', 'abril', 'mayo', 'junio', 'julio', 'agosto', 'septiembre', 'octubre', 'noviembre', 'diciembre']
    hoy_texto = f'{hoy.day} de {meses[hoy.month - 1]} de {hoy.year}'
    limpio = limpiar_json(conv)
    JSON.write_text(json.dumps({'actualizado': hoy.isoformat(), 'fuente': 'BOE y Ministerio de Economía, Comercio y Empresa; cálculo propio (scripts/cifras-oposicion.py)',
                                'licencia': 'CC BY-NC-ND 4.0', 'convocatorias': limpio}, ensure_ascii=False, indent=1), encoding='utf-8')
    html = PAGINA.read_text(encoding='utf-8')
    html = sustituir(html, '<!-- cifras:inicio -->', '<!-- cifras:fin -->', bloque_pagina(limpio, hoy_texto))
    html = re.sub(r'"temporalCoverage": "[^"]*"', f'"temporalCoverage": "{limpio[0]["examenes"]}/{limpio[-1]["examenes"]}"', html)
    html = re.sub(r'"dateModified": "[^"]*"', f'"dateModified": "{hoy.isoformat()}"', html)
    PAGINA.write_text(html, encoding='utf-8')
    guia = GUIA.read_text(encoding='utf-8')
    if '<!-- cifras:inicio -->' in guia:
        guia = sustituir(guia, '<!-- cifras:inicio -->', '<!-- cifras:fin -->', bloque_guia(limpio))
        GUIA.write_text(guia, encoding='utf-8')
    print(f'cifras.json: {len(limpio)} convocatorias ({limpio[0]["examenes"]}-{limpio[-1]["examenes"]}); página y guía escritas.')
    return limpio
