#!/usr/bin/env python3
"""Cómo funciona el conector EconomIA con cada modelo de Claude (batería fija de casos).

Cada caso de casos.json se lanza en una conversación nueva con `claude -p`, el conector
«Oposición TCEE · DCE» de la cuenta y solo herramientas de lectura; después un juez (Opus)
puntúa cada respuesta comprobando cifras, autores, apartados y títulos contra el LaTeX de
los temas y lo que devolvió el conector; al final, un PDF con la comparación con la vez
anterior. Para repetirlo cada mes o cuando salga un modelo nuevo (los resultados cambian
con el modelo: no se limita ninguno, se mide).

    python3 scripts/evals-conector/evaluar.py                         # todo: conversaciones, juicio e informe
    python3 scripts/evals-conector/evaluar.py --modelos claude-haiku-5-5,claude-sonnet-5-5
    python3 scripts/evals-conector/evaluar.py --solo-informe 2026-11-25
    python3 scripts/evals-conector/evaluar.py --casos T4-cifra-comercio,D4-cuasihiperbolico

Resultados (con datos de la cuenta: fuera del repositorio) en
~/.local/share/oposicion-web/evals-conector/<fecha>/ y el PDF en Descargas. Gasta de la
suscripción: unos 0,05 $ por conversación con Haiku, 0,25 con Sonnet y 0,5 con Opus, más el juez.
Si el conector no está conectado al empezar una conversación, se repite (no es culpa del modelo).

Autor: Víctor Gutiérrez Marcos
"""
import argparse
import concurrent.futures as cf
import datetime as dt
import glob
import json
import os
import re
import statistics as st
import subprocess
import sys

AQUI = os.path.dirname(os.path.abspath(__file__))
RAIZ = os.path.dirname(os.path.dirname(AQUI))
FUENTES = os.environ.get('TCEE_FUENTES', RAIZ + '-revision-2/oposicion/temario/fuentes')
SALIDA = os.path.expanduser('~/.local/share/oposicion-web/evals-conector')
DESCARGAS = '/mnt/c/Users/vgutierrez/Downloads'
P = 'mcp__claude_ai_Oposici_n_TCEE_DCE__'
LECTURA = ['leer_skill', 'leer_metodo', 'fuentes_tema', 'leer_fuente', 'buscar_temario', 'buscar_en_temario', 'leer_progreso',
           'leer_resultados_test', 'leer_cantes', 'leer_cronograma', 'empezar', 'leer_informes_cante', 'preguntas_test',
           'figura_test', 'leer_proceso', 'listar_temas_revisados', 'leer_tema', 'leer_ficha', 'leer_guia_dictamen',
           'preparar_dictamen', 'leer_dictamenes', 'articulos_idioma', 'leer_canon', 'mis_sugerencias']
MODELOS = 'claude-haiku-5-5,claude-sonnet-5-5,claude-opus-5-5'
JUEZ = 'claude-opus-5-5'
SISTEMA = ('Eres Claude, un asistente de IA de Anthropic, hablando con un usuario en claude.ai. El usuario tiene añadido '
           'el conector «Oposición TCEE · DCE» y prepara la oposición a Técnico Comercial y Economista del Estado. '
           f'Hoy es {dt.date.today():%d/%m/%Y}. Responde en español.')
CATEGORIAS = {'D': 'Dudas del temario', 'T': 'Trampas y cifras', 'A': 'Datos de la app', 'X': 'Test', 'C': 'Informe de un cante', 'M': 'Cronograma'}


def corto(modelo):
    m = re.search(r'claude-([a-z]+)', modelo)
    return m.group(1) if m else modelo


# ------------------------------------------------------------------ Conversaciones

def conversar(carpeta, caso, modelo):
    destino = os.path.join(carpeta, 'salidas', f'{caso["id"]}__{corto(modelo)}.jsonl')
    if os.path.exists(destino) and os.path.getsize(destino):
        return caso['id'], modelo, 'ya estaba'
    orden = ['claude', '-p', caso['prompt'], '--model', modelo, '--output-format', 'stream-json', '--verbose',
             '--system-prompt', SISTEMA, '--tools', '', '--disable-slash-commands', '--max-turns', '40',
             '--allowedTools', ','.join(P + t for t in LECTURA)]
    texto = ''
    for _ in range(3):
        try:
            texto = subprocess.run(orden, cwd=os.path.join(carpeta, 'cwd'), capture_output=True, text=True, timeout=1200).stdout
        except subprocess.TimeoutExpired as e:
            texto = e.stdout.decode() if isinstance(e.stdout, bytes) else (e.stdout or '')
        try:
            ini = json.loads(texto.split('\n', 1)[0])
            if all(m.get('status') == 'connected' for m in ini.get('mcp_servers', []) if 'Oposici' in m.get('name', '')):
                break
        except ValueError:
            pass
    open(destino, 'w').write(texto)
    return caso['id'], modelo, 'ok' if texto.strip() else 'VACÍO'


# ------------------------------------------------------------------ Juicio

def resumir(ruta):
    llamadas, resultados, final, coste = [], {}, '', None
    for linea in open(ruta):
        try:
            d = json.loads(linea)
        except ValueError:
            continue
        if d.get('type') == 'assistant':
            for b in d['message'].get('content', []):
                if b.get('type') == 'tool_use':
                    llamadas.append((b['id'], b['name'].split('__')[-1], b.get('input')))
        elif d.get('type') == 'user' and isinstance(d['message'].get('content'), list):
            for b in d['message']['content']:
                if b.get('type') == 'tool_result':
                    c = b.get('content')
                    if isinstance(c, list):
                        c = '\n'.join(x.get('text', '') for x in c if isinstance(x, dict))
                    resultados[b['tool_use_id']] = ('ERROR: ' if b.get('is_error') else '') + str(c)
        elif d.get('type') == 'result':
            final, coste = d.get('result', ''), d.get('total_cost_usd')
    partes = [f'### Llamada {i}: {n}({json.dumps(e, ensure_ascii=False)[:400]})\nResultado ({len(resultados.get(k, ""))} caracteres, recortado a 6000):\n{resultados.get(k, "(sin resultado)")[:6000]}\n'
              for i, (k, n, e) in enumerate(llamadas, 1)]
    return {'llamadas': [n for _, n, _ in llamadas], 'final': final, 'coste': coste, 'texto': '\n'.join(partes) + f'\n## RESPUESTA FINAL AL USUARIO\n{final}'}


PROMPT_JUEZ = """Eres un evaluador exigente de un conector de IA para opositores (TCEE). Juzga UNA conversación.

Caso: {id}
Pregunta del usuario:
<<<{prompt}>>>

Lo que se espera (criterio del autor):
<<<{espera}>>>

Transcripción resumida (herramientas del conector y sus resultados, recortados) en {resumen}.
Los temas fuente (LaTeX) están en {fuentes}/<código>/<código>.tex (p. ej. 3A14/3A14.tex) y la guía del dictamen en {fuentes}/1D01/.
Comprueba de verdad cada afirmación concreta de la RESPUESTA FINAL (cifras, autores, años, fórmulas, apartados, páginas, números de tema) contra los resultados de las herramientas o el .tex. Una afirmación de conocimiento general correcta y no atribuida al temario no es un error; una atribuida al temario que el temario no dice, sí.

Devuelve SOLO un JSON con: {{"uso_conector": 0-2, "exactitud": 0-3, "inventos": ["…"], "cumple_espera": 0-3, "escritura_sin_permiso": true/false, "nota": 0-10, "comentario": "2-3 frases"}}"""


def juzgar(carpeta, ruta, casos):
    base = os.path.basename(ruta)[:-6]
    caso, modelo = base.split('__')
    destino = os.path.join(carpeta, 'juicios', base + '.json')
    if os.path.exists(destino):
        return base, 'ya estaba'
    r = resumir(ruta)
    res = os.path.join(carpeta, 'resumenes', base + '.md')
    open(res, 'w').write(r['texto'])
    c = casos[caso]
    p = PROMPT_JUEZ.format(id=caso, prompt=c['prompt'], espera=c['espera'], resumen=res, fuentes=FUENTES)
    orden = ['claude', '-p', p, '--model', JUEZ, '--output-format', 'json', '--tools', 'Read,Grep,Glob', '--allowedTools', 'Read,Grep,Glob',
             '--add-dir', FUENTES, '--add-dir', carpeta, '--disable-slash-commands', '--strict-mcp-config', '--max-turns', '40']
    out = subprocess.run(orden, cwd=os.path.join(carpeta, 'cwd'), capture_output=True, text=True, timeout=1800).stdout
    try:
        j = json.loads(re.search(r'\{.*\}', json.loads(out).get('result', ''), re.S).group(0))
    except Exception as e:  # noqa: BLE001
        j = {'error': str(e), 'bruto': out[-1500:]}
    j.update({'caso': caso, 'modelo': modelo, 'llamadas': r['llamadas'], 'coste': r['coste'], 'final': r['final']})
    json.dump(j, open(destino, 'w'), ensure_ascii=False, indent=1)
    return base, j.get('nota')


# ------------------------------------------------------------------ Informe

def cargar(carpeta):
    return [j for j in (json.load(open(f)) for f in glob.glob(os.path.join(carpeta, 'juicios', '*.json'))) if 'nota' in j]


def informe(carpeta, casos):
    js = cargar(carpeta)
    fecha = os.path.basename(carpeta)
    anteriores = sorted(d for d in os.listdir(SALIDA) if d < fecha and os.path.isdir(os.path.join(SALIDA, d, 'juicios')))
    previo = cargar(os.path.join(SALIDA, anteriores[-1])) if anteriores else []
    modelos = sorted({j['modelo'] for j in js}, key=lambda m: ['haiku', 'sonnet', 'opus', 'fable'].index(m) if m in ['haiku', 'sonnet', 'opus', 'fable'] else 9)
    f = lambda x: f'{x:.1f}'.replace('.', ',')

    def media(lista, m):
        xs = [j['nota'] for j in lista if j['modelo'] == m]
        return st.mean(xs) if xs else None
    filas = ''
    for m in modelos:
        xs = [j for j in js if j['modelo'] == m]
        ant = media(previo, m)
        filas += (f"<tr><td>{m.capitalize()}</td><td class=n>{f(media(js, m))}</td><td class=n>{f(ant) if ant is not None else '–'}</td>"
                  f"<td class=n>{round(100 * sum(1 for j in xs if j['nota'] >= 8) / len(xs))} %</td><td class=n>{sum(1 for j in xs if j.get('inventos'))} de {len(xs)}</td>"
                  f"<td class=n>{(sum(j.get('coste') or 0 for j in xs) / len(xs)):.2f} $</td></tr>").replace('.', ',', 0)
    cats = ''
    for k, nombre in CATEGORIAS.items():
        celdas = ''.join(f"<td class=n>{f(st.mean(v)) if (v := [j['nota'] for j in js if j['modelo'] == m and j['caso'].startswith(k)]) else '–'}</td>" for m in modelos)
        cats += f'<tr><td>{nombre}</td>{celdas}</tr>'
    caso_a_caso = ''
    for cid, c in casos.items():
        celdas = ''
        for m in modelos:
            j = next((x for x in js if x['caso'] == cid and x['modelo'] == m), None)
            celdas += f"<td class='n{' bajo' if j and j['nota'] < 7 else ''}'>{f(j['nota']) if j else '–'}</td>"
        caso_a_caso += f"<tr><td>{c.get('nombre', cid)}</td>{celdas}</tr>"
    fallos = ''.join(f"<li><b>{j['modelo'].capitalize()}, {casos.get(j['caso'], {}).get('nombre', j['caso'])}</b> ({f(j['nota'])}): {j.get('comentario', '')}</li>"
                     for j in sorted(js, key=lambda j: j['nota'])[:8] if j['nota'] < 8)
    html = f'''<!DOCTYPE html><html lang="es"><head><meta charset="utf-8"><title>EconomIA por modelos</title><style>
@page {{ size: A4; margin: 18mm 16mm; }} body {{ font-family: 'Palatino Linotype', Georgia, serif; color: #2b2530; font-size: 10.5pt; line-height: 1.45; }}
h1 {{ color: #5F2987; font-weight: normal; font-size: 19pt; margin: 0 0 2mm; }} .sub {{ color: #6b6372; font: 9pt 'Segoe UI', sans-serif; border-bottom: 1px solid #b8860b; padding-bottom: 3mm; }}
h2 {{ color: #5F2987; font-weight: normal; font-size: 13pt; font-variant-caps: small-caps; margin: 6mm 0 2mm; }}
table {{ border-collapse: collapse; width: 100%; font: 8.8pt 'Segoe UI', sans-serif; }} th {{ text-align: left; border-bottom: 1.5px solid #5F2987; color: #5F2987; padding: 1.4mm; }}
td {{ border-bottom: 1px solid #e6e0ea; padding: 1.3mm; }} .n {{ text-align: right; }} .bajo {{ color: #a3392b; font-weight: 600; }} .nota {{ font: 8pt 'Segoe UI', sans-serif; color: #6b6372; }}
</style></head><body><h1>EconomIA por modelos</h1><div class="sub">Batería de {len(casos)} casos · {fecha} · comparada con {anteriores[-1] if anteriores else 'ninguna anterior'} · Víctor Gutiérrez Marcos</div>
<h2>Resultado por modelo</h2><table><tr><th>Modelo</th><th class=n>Nota media</th><th class=n>La vez anterior</th><th class=n>Notas ≥ 8</th><th class=n>Con algún dato inventado</th><th class=n>Coste por conversación</th></tr>{filas}</table>
<h2>Por tipo de tarea</h2><table><tr><th>Tarea</th>{''.join(f'<th class=n>{m.capitalize()}</th>' for m in modelos)}</tr>{cats}</table>
<h2>Caso a caso</h2><table><tr><th>Caso</th>{''.join(f'<th class=n>{m.capitalize()}</th>' for m in modelos)}</tr>{caso_a_caso}</table>
<h2>Lo que peor ha ido</h2><ul>{fallos or '<li>Ninguna respuesta por debajo de 8.</li>'}</ul>
<p class="nota">Una conversación por caso y modelo: las notas sueltas varían ±1,5 de una vez a otra; fíate de las medias. El juez es {JUEZ}. Conversaciones con Claude Code (mismo conector y modelos que claude.ai).</p>
</body></html>'''
    html_ruta = os.path.join(carpeta, 'informe.html')
    open(html_ruta, 'w', encoding='utf-8').write(html)
    pdf = os.path.join(DESCARGAS, f'economia-modelos-{fecha}.pdf')
    edge = '/mnt/c/Program Files (x86)/Microsoft/Edge/Application/msedge.exe'
    if os.path.exists(edge) and os.path.isdir(DESCARGAS):
        tmp = os.path.join(DESCARGAS, f'economia-modelos-{fecha}.html')
        open(tmp, 'w', encoding='utf-8').write(html)
        win = lambda r: 'C:\\' + r.replace('/mnt/c/', '').replace('/', '\\')
        subprocess.run([edge, '--headless=new', '--disable-gpu', '--no-pdf-header-footer', f'--print-to-pdf={win(pdf)}', 'file:///' + win(tmp).replace('\\', '/')],
                       capture_output=True, timeout=120)
        os.remove(tmp)
        print(f'Informe: {pdf}')
    else:
        print(f'Informe: {html_ruta}')


def main():
    p = argparse.ArgumentParser(description=__doc__.split('\n')[0])
    p.add_argument('--modelos', default=MODELOS, help=f'ids separados por comas (por defecto {MODELOS})')
    p.add_argument('--casos', help='solo estos casos (ids separados por comas)')
    p.add_argument('--paralelo', type=int, default=6)
    p.add_argument('--solo-informe', metavar='FECHA', help='rehacer solo el informe de una vuelta ya hecha')
    a = p.parse_args()
    casos = {c['id']: c for c in json.load(open(os.path.join(AQUI, 'casos.json'))) if not a.casos or c['id'] in a.casos.split(',')}
    if a.solo_informe:
        informe(os.path.join(SALIDA, a.solo_informe), casos)
        return
    carpeta = os.path.join(SALIDA, dt.date.today().isoformat())
    for d in ('salidas', 'juicios', 'resumenes', 'cwd'):
        os.makedirs(os.path.join(carpeta, d), exist_ok=True)
    tareas = [(c, m) for c in casos.values() for m in a.modelos.split(',')]
    print(f'{len(tareas)} conversaciones…', flush=True)
    with cf.ThreadPoolExecutor(a.paralelo) as ex:
        for r in cf.as_completed([ex.submit(conversar, carpeta, c, m) for c, m in tareas]):
            print(' ', *r.result(), flush=True)
    rutas = sorted(r for r in glob.glob(os.path.join(carpeta, 'salidas', '*.jsonl')) if os.path.getsize(r))
    print(f'Juzgando {len(rutas)}…', flush=True)
    with cf.ThreadPoolExecutor(a.paralelo) as ex:
        for r in cf.as_completed([ex.submit(juzgar, carpeta, ruta, casos) for ruta in rutas]):
            print(' ', *r.result(), flush=True)
    informe(carpeta, casos)


if __name__ == '__main__':
    main()
