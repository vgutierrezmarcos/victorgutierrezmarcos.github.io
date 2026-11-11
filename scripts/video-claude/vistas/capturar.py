#!/usr/bin/env python3
"""
Capturas de las vistas interactivas del conector (mcp/worker/src/vistas/*.html) para
el vídeo de EconomIA: el test con su figura (antes y después de contestar), el
cronograma, el informe del cante y la clase (antes y después de pulsar el botón).

Monta cada vista como la sirve el conector (comun.html + la vista), la abre en un
cliente simulado (cliente.html: habla el protocolo de MCP Apps por postMessage) con
datos de ejemplo hechos con preguntas y títulos reales, y la fotografía con Edge sin
ventana a doble densidad. Deja los WebP en esta carpeta; preparar.py los copia a assets/.

    python3 scripts/video-claude/vistas/capturar.py

Autor: Víctor Gutiérrez Marcos
"""
import datetime
import functools
import http.server
import json
import os
import subprocess
import tempfile
import threading

from PIL import Image, ImageChops

AQUI = os.path.dirname(os.path.abspath(__file__))
RAIZ = os.path.dirname(os.path.dirname(os.path.dirname(AQUI)))
VISTAS = os.path.join(RAIZ, 'mcp', 'worker', 'src', 'vistas')
TEST = os.path.join(RAIZ, 'oposicion', 'temario', 'primer-ejercicio', 'test')
WEB_TEST = 'https://www.victorgutierrezmarcos.es/oposicion/temario/primer-ejercicio/test/'
EDGE = '/mnt/c/Program Files (x86)/Microsoft/Edge/Application/msedge.exe'
PUERTO = 8798
ANCHO = 640
# nombre: (vista, pasos del cliente simulado, alto de la ventana)
CAPTURAS = {
    'test-a': ('test', '', 1100), 'test-b': ('test', 'clicTexto:d)', 1300),
    'cronograma-a': ('cronograma', '', 1500), 'cronograma-b': ('cronograma', 'clicTexto:Guardar', 1500),
    'informe-a': ('informe', '', 1300), 'informe-b': ('informe', 'clicTexto:Guardar', 600),
    'clase-a': ('clase', '', 800), 'clase-b': ('clase', 'clicTexto:Pedir', 800),
}


def casos():
    """Datos de ejemplo con la forma de lo que devuelve cada herramienta del conector."""
    with open(os.path.join(TEST, 'preguntas.json'), encoding='utf-8') as f:
        d = json.load(f)
    preguntas = {p['id']: p for p in (d if isinstance(d, list) else d['preguntas'])}
    with open(os.path.join(TEST, 'explicaciones', '2021-julio-OEP2020.json'), encoding='utf-8') as f:
        explicaciones = json.load(f)['explicaciones']
    with open(os.path.join(RAIZ, 'oposicion', 'temario', 'fuentes-temas.json'), encoding='utf-8') as f:
        titulos = {k: v['titulo'] for k, v in json.load(f)['tcee'].items()}

    def pregunta(i, por_que=None):
        p = preguntas[i]
        r = {'id': i, 'cabecera': f"[{', '.join(p['temas'])} · {p['examen']}, pregunta {p['numero']}]", 'enunciado': p['enunciado'],
             'opciones': p['opciones'], 'respuesta': p['respuesta']}
        if p.get('imagenes'):
            r['figura'] = 'Lleva figura'
            r['figuras'] = [{'url': WEB_TEST + p['imagenes'][0]['src']}]
        if por_que:
            r['porQue'] = por_que
        return r

    otras = [i for i, p in preguntas.items() if p['temas'] == ['3.A.9'] and not p.get('imagenes') and i != 200][:4]
    test = {'args': {'oposicion': 'tcee', 'temas': ['3.A.9'], 'n': 5, 'modo': 'no_dominadas'},
            'res': {'temas': ['3.A.9'], 'modo': 'no_dominadas', 'preguntas': [pregunta(200, explicaciones['200']['clave'])] + [pregunta(i) for i in otras]},
            'llamadas': {}}

    temas = [f'3.A.{n}' for n in range(8, 30)]
    semanas, dia, k = [], datetime.date(2026, 11, 21), 0
    while k < len(temas):
        lunes = (dia - datetime.timedelta(days=5)).isoformat()
        if dia in (datetime.date(2026, 12, 26), datetime.date(2027, 1, 2)):
            semanas.append({'lunes': lunes, 'cante': dia.isoformat(), 'temas': [], 'descanso': True})
        else:
            semanas.append({'lunes': lunes, 'cante': dia.isoformat(), 'temas': temas[k:k + 2]})
            k += 2
        dia += datetime.timedelta(days=7)
    cronograma = {'args': {'oposicion': 'tcee', 'ejercicio': 3, 'diaCante': 6, 'semanas': semanas, 'vistaPrevia': True},
                  'res': {'guardado': False, 'vistaPrevia': True, 'oposicion': 'tcee',
                          'cronograma': {'id': 'n1', 'ejercicio': 3, 'examen': '2027-03-13', 'semanas': semanas}, 'titulos': {t: titulos[t] for t in temas}},
                  'llamadas': {'proponer_cronograma': {'guardado': True, 'id': 'n1', 'semanas': len(semanas), 'temas': len(temas)}}}

    informe = {'args': {'oposicion': 'tcee', 'canteId': 'c1', 'informe': '…', 'vistaPrevia': True},
               'res': {'guardado': False, 'vistaPrevia': True, 'oposicion': 'tcee', 'cante': {'id': 'c1', 'fecha': '2026-11-07', 'temas': ['3.A.8'], 'estado': 'hecho'},
                       'propuesta': {'valoracion': 3, 'valoraciones': {'3.A.8': 3},
                                     'comentarios': 'Buena estructura y ritmo. El signo del efecto sustitución, al revés en el minuto 7; la ecuación de Slutsky, sin derivar en la pizarra.',
                                     'criterios': {'Contenido': 3, 'Estructura': 4, 'Exposición': 4, 'Tiempo': 3},
                                     'tareas': ['Derivar Slutsky en la pizarra, paso a paso', 'Repasar el signo del efecto sustitución']}},
               'llamadas': {'guardar_informe_cante': {'guardado': True, 'diarioActualizado': True, 'deberesApuntados': 2}}}

    clase = {'args': {'oposicion': 'tcee', 'como': 'opositor', 'con': 'prep', 'dia': '2026-11-02', 'hora': '17:00', 'modalidad': 'online', 'temas': ['3.A.8', '3.A.9'], 'vistaPrevia': True},
             'res': {'vistaPrevia': True, 'pedida': False, 'como': 'opositor', 'oposicion': 'tcee', 'preparador': 'Paula', 'fecha': '2026-11-02T17:00', 'minutos': 120,
                     'modalidad': 'online', 'temas': ['3.A.8', '3.A.9'], 'titulos': {t: titulos[t] for t in ('3.A.8', '3.A.9')}},
             'llamadas': {'agendar_clase': {'pedida': True, 'fecha': '2026-11-02T17:00', 'minutos': 120, 'modalidad': 'online', 'temas': ['3.A.8', '3.A.9'], 'preparador': 'Paula'}}}
    return {'test': test, 'cronograma': cronograma, 'informe': informe, 'clase': clase}


def montar(carpeta):
    with open(os.path.join(VISTAS, 'comun.html'), encoding='utf-8') as f:
        comun = f.read()
    for n in ('test', 'cronograma', 'informe', 'clase'):
        with open(os.path.join(VISTAS, n + '.html'), encoding='utf-8') as f:
            cuerpo = f.read()
        with open(os.path.join(carpeta, n + '.html'), 'w', encoding='utf-8') as f:
            f.write(f'<!doctype html>\n<html lang="es">\n<head>\n<meta charset="utf-8">\n<meta name="viewport" content="width=device-width, initial-scale=1">\n<title>{n}</title>\n{comun}</head>\n<body>\n{cuerpo}</body>\n</html>\n')
    with open(os.path.join(carpeta, 'casos.js'), 'w', encoding='utf-8') as f:
        f.write('var CASOS=' + json.dumps(casos(), ensure_ascii=False) + ';')
    with open(os.path.join(AQUI, 'cliente.html'), encoding='utf-8') as f, open(os.path.join(carpeta, 'cliente.html'), 'w', encoding='utf-8') as g:
        g.write(f.read())


def main():
    with tempfile.TemporaryDirectory() as carpeta:
        montar(carpeta)
        manejador = functools.partial(http.server.SimpleHTTPRequestHandler, directory=carpeta)
        http.server.SimpleHTTPRequestHandler.log_message = lambda *a: None
        servidor = http.server.ThreadingHTTPServer(('127.0.0.1', PUERTO), manejador)
        threading.Thread(target=servidor.serve_forever, daemon=True).start()
        perfil = subprocess.run(['wslpath', '-w', os.path.join(carpeta, 'perfil')], capture_output=True, text=True, check=True).stdout.strip()
        for nombre, (vista, pasos, alto) in CAPTURAS.items():
            png = os.path.join(carpeta, nombre + '.png')
            destino = subprocess.run(['wslpath', '-w', png], capture_output=True, text=True, check=True).stdout.strip()
            subprocess.run([EDGE, '--headless=new', '--disable-gpu', '--hide-scrollbars', '--force-device-scale-factor=2', f'--user-data-dir={perfil}',
                            f'--window-size={ANCHO},{alto}', '--virtual-time-budget=12000', f'--screenshot={destino}',
                            f'http://localhost:{PUERTO}/cliente.html?vista={vista}&pasos={pasos}'],
                           stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL, timeout=120)
            img = Image.open(png).convert('RGB')
            caja = ImageChops.difference(img, Image.new('RGB', img.size, (255, 255, 255))).getbbox()
            if not caja:
                raise SystemExit(f'La captura {nombre} ha salido en blanco')
            img = img.crop((0, 0, img.width, min(img.height, caja[3] + 24)))
            img.save(os.path.join(AQUI, nombre + '.webp'), 'WEBP', quality=94, method=6)
            print(nombre, img.size)
        servidor.shutdown()


if __name__ == '__main__':
    main()
