#!/usr/bin/env python3
"""Mantiene al día la convocatoria en curso en la guía de la oposición.

Lee oposicion/proceso.json (lo escribe scripts/leer-proceso.py desde la
página de procesos selectivos del Ministerio) y escribe en
oposicion/por-que-tcee.html:

- El bloque «Convocatoria en curso» (entre los marcadores
  <!-- convocatoria:inicio --> y <!-- convocatoria:fin -->): plazas, tasa,
  plazo, estado del proceso y los últimos documentos publicados.
- Las respuestas de las preguntas frecuentes sobre plazas y tasa, en la
  página (marcadores <!-- faq-plazas --> y <!-- faq-tasa -->) y en el
  JSON-LD de FAQPage, para que digan lo mismo.
- La fecha de «Actualizado el …» y dateModified, solo si algo cambió.

Los datos que no están en proceso.json (plazas y tasas) van en
CONVOCATORIAS, una línea por convocatoria: cuando el Ministerio publique
una nueva, el script avisa y hay que añadir su línea (sale en el BOE).

Uso, desde la raíz del repositorio:
    python3 scripts/guia-convocatoria.py
Lo ejecuta también la acción leer-proceso.yml cada vez que cambia proceso.json.
"""
import json
import re
import sys
from datetime import date
from pathlib import Path

RAIZ = Path(__file__).resolve().parents[1]
PROCESO = RAIZ / 'oposicion' / 'proceso.json'
GUIA = RAIZ / 'oposicion' / 'por-que-tcee.html'

# Datos de cada convocatoria que no están en la página del Ministerio
# (clave: el año de la oferta de empleo público, como en proceso.json).
CONVOCATORIAS = {
    '2025': {
        'boe': 'BOE-A-2025-26902',
        'boe_fecha': '29 de diciembre de 2025',
        'resolucion': 'Resolución de 22 de diciembre de 2025, de la Subsecretaría',
        'libre': 27, 'libre_discapacidad': 2,
        'interna': 10, 'interna_discapacidad': 1,
        'tasa_libre': '31,10 €', 'tasa_interna': '15,55 €',
    },
}

MESES = ['enero', 'febrero', 'marzo', 'abril', 'mayo', 'junio', 'julio', 'agosto',
         'septiembre', 'octubre', 'noviembre', 'diciembre']


def fecha_larga(d):
    return f'{d.day} de {MESES[d.month - 1]} de {d.year}'


def esc(s):
    return s.replace('&', '&amp;').replace('<', '&lt;').replace('>', '&gt;').replace('"', '&quot;')


def proceso_en_curso(datos):
    """El proceso TCEE más reciente (por año de convocatoria)."""
    procesos = datos.get('tcee', {}).get('procesos', [])
    if not procesos:
        return None
    return max(procesos, key=lambda p: p['convocatoria'])


def estado(proceso):
    """Último documento publicado: (sección, título, url, fecha o None)."""
    docs = proceso.get('documentos', [])
    if not docs:
        return None
    d = docs[-1]
    return d['seccion'], d['titulo'], d['url'], (date.fromisoformat(d['desde']) if d.get('desde') else None)


def bloque_convocatoria(proceso, datos_conv):
    anio = proceso['convocatoria']
    url_oficial = proceso['url']
    partes = []
    if datos_conv:
        c = datos_conv
        total = c['libre'] + c['interna']
        partes.append(f'<h2 id="convocatoria">Convocatoria en curso: oferta de empleo público {anio}</h2>')
        partes.append(f'<p>La <a href="https://www.boe.es/diario_boe/txt.php?id={c["boe"]}" target="_blank" rel="noopener">{esc(c["resolucion"])}</a>, '
                      f'publicada en el BOE de {c["boe_fecha"]}, convoca <strong>{total} plazas</strong> del Cuerpo Superior de Técnicos Comerciales y Economistas del Estado.</p>')
        partes.append('<table class="tabla-guia">')
        partes.append('<thead><tr><th scope="col">Convocatoria ' + esc(anio) + '</th><th scope="col">Turno libre</th><th scope="col">Promoción interna</th></tr></thead>')
        partes.append('<tbody>')
        partes.append(f'<tr><th scope="row">Plazas</th><td>{c["libre"]} ({c["libre"] - c["libre_discapacidad"]} de acceso general y {c["libre_discapacidad"]} reservadas a personas con discapacidad)</td>'
                      f'<td>{c["interna"]} ({c["interna"] - c["interna_discapacidad"]} de acceso general y {c["interna_discapacidad"]} reservada a personas con discapacidad)</td></tr>')
        partes.append(f'<tr><th scope="row">Tasa de examen</th><td>{c["tasa_libre"]}</td><td>{c["tasa_interna"]}</td></tr>')
        partes.append('<tr><th scope="row">Plazo de solicitud</th><td colspan="2">Veinte días hábiles desde el día siguiente a la publicación en el BOE, por internet (Inscripción en Pruebas Selectivas)</td></tr>')
        partes.append('</tbody></table>')
    else:
        partes.append(f'<h2 id="convocatoria">Convocatoria en curso: oferta de empleo público {anio}</h2>')
        partes.append(f'<p>El Ministerio ha publicado la convocatoria de la oferta de empleo público {anio}. Las plazas, la tasa y el plazo están en la resolución del BOE enlazada desde la página oficial.</p>')
    e = estado(proceso)
    if e:
        seccion, titulo, url, fecha = e
        cuando = f' (publicado el {fecha_larga(fecha)})' if fecha else ''
        partes.append(f'<p><strong>Estado del proceso:</strong> {esc(seccion)} · <a href="{esc(url)}" target="_blank" rel="noopener">{esc(titulo)}</a>{cuando}.</p>')
    ultimos = list(reversed(proceso.get('documentos', [])[-5:]))
    if ultimos:
        partes.append('<p>Últimos documentos publicados por el Ministerio:</p>')
        partes.append('<ul>')
        for d in ultimos:
            partes.append(f'<li>{esc(d["seccion"])}: <a href="{esc(d["url"])}" target="_blank" rel="noopener">{esc(d["titulo"])}</a></li>')
        partes.append('</ul>')
    partes.append(f'<p>Todo el proceso (listas de admitidos, fechas de cada ejercicio y aprobados) se sigue en la <a href="{esc(url_oficial)}" target="_blank" rel="noopener">página oficial de la convocatoria</a>. '
                  'La <a href="../app/">app de la oposición</a> la lee cada pocos minutos y avisa en el móvil de cada documento nuevo.</p>')
    return '\n                    '.join(partes)


def respuesta_plazas(proceso, c):
    if not c:
        return ('Depende de la oferta de empleo público de cada año. Como referencia, la ATCEE calcula que entre 2019 y 2024 se convocaron de media 23,5 plazas de turno libre al año. '
                'Las plazas exactas de cada convocatoria están en el BOE y en la página de procesos selectivos del Ministerio de Economía, Comercio y Empresa.')
    total = c['libre'] + c['interna']
    return (f'En la convocatoria en curso (oferta de empleo público {proceso["convocatoria"]}, BOE de {c["boe_fecha"]}) son {total}: {c["libre"]} de turno libre, '
            f'{c["libre_discapacidad"]} de ellas reservadas a personas con discapacidad, y {c["interna"]} de promoción interna. '
            'El número cambia cada año con la oferta de empleo público: entre 2019 y 2024 se convocaron de media 23,5 plazas de turno libre al año, según la ATCEE.')


def respuesta_tasa(proceso, c):
    if not c:
        return ('La tasa de derechos de examen la fija cada convocatoria en el BOE; es más baja en promoción interna y tiene exenciones y reducciones '
                '(discapacidad, demandantes de empleo, familias numerosas y víctimas del terrorismo).')
    return (f'En la convocatoria en curso (oferta de empleo público {proceso["convocatoria"]}), {c["tasa_libre"]} en turno libre y {c["tasa_interna"]} en promoción interna. '
            'Hay exenciones y reducciones para personas con discapacidad, demandantes de empleo, familias numerosas y víctimas del terrorismo. Se paga al presentar la solicitud por internet.')


def sustituir_entre(html, inicio, fin, nuevo):
    a = html.index(inicio) + len(inicio)
    b = html.index(fin)
    return html[:a] + nuevo + html[b:]


def actualizar_faq_jsonld(html, respuestas):
    """Cambia en el JSON-LD de FAQPage las respuestas de las preguntas dadas."""
    patron = re.compile(r'(<script type="application/ld\+json">\n)(\{.*?\})(\n\s*</script>)', re.S)
    m = next((m for m in patron.finditer(html) if '"@type": "FAQPage"' in m.group(2)), None)
    if not m:
        sys.exit('No encuentro el JSON-LD de FAQPage en la guía')
    faq = json.loads(m.group(2))
    for q in faq['mainEntity']:
        if q['name'] in respuestas:
            q['acceptedAnswer']['text'] = respuestas[q['name']]
    nuevo = json.dumps(faq, ensure_ascii=False, indent=4)
    return html[:m.start(2)] + nuevo + html[m.end(2):]


def main():
    datos = json.loads(PROCESO.read_text(encoding='utf-8'))
    proceso = proceso_en_curso(datos)
    if not proceso:
        sys.exit('proceso.json no tiene procesos de TCEE')
    c = CONVOCATORIAS.get(proceso['convocatoria'])
    if not c:
        print(f'AVISO: la convocatoria {proceso["convocatoria"]} no está en CONVOCATORIAS (scripts/guia-convocatoria.py): '
              'añade sus plazas y tasas del BOE para que salgan en la guía.')
    html = original = GUIA.read_text(encoding='utf-8')
    html = sustituir_entre(html, '<!-- convocatoria:inicio -->', '<!-- convocatoria:fin -->',
                           '\n                    ' + bloque_convocatoria(proceso, c) + '\n                    ')
    plazas, tasa = respuesta_plazas(proceso, c), respuesta_tasa(proceso, c)
    html = sustituir_entre(html, '<!-- faq-plazas -->', '<!-- /faq-plazas -->', esc(plazas))
    html = sustituir_entre(html, '<!-- faq-tasa -->', '<!-- /faq-tasa -->', esc(tasa))
    html = actualizar_faq_jsonld(html, {'¿Cuántas plazas tiene la convocatoria de TCEE?': plazas,
                                        '¿Cuánto cuesta presentarse a la oposición?': tasa})
    if html == original:
        print('La guía ya estaba al día.')
        return
    hoy = date.today()
    html = re.sub(r'(<p class="actualizado">.*?Actualizado el )[^<]+', lambda m: m.group(1) + fecha_larga(hoy), html, count=1)
    html = re.sub(r'"dateModified": "[^"]+"', f'"dateModified": "{hoy.isoformat()}"', html, count=1)
    GUIA.write_text(html, encoding='utf-8')
    print(f'Guía actualizada: convocatoria {proceso["convocatoria"]}, {len(proceso.get("documentos", []))} documentos.')


if __name__ == '__main__':
    main()
