#!/usr/bin/env python3
"""Informe mensual de la web y la app: dos caras de la web y dos de la app.

Dos pasos, para que las cifras las saque el script y la valoración la escriba
quien lo lee (la skill /informe-web):

    python3 scripts/informe-web.py --datos [--dias 28]
        Ejecuta estadisticas-web.py, estadisticas-app.py (con la red) y
        comprobar-seo.py, añade la evolución de las fotos anteriores y deja
        datos.json en ~/.local/share/oposicion-web/informes/AAAA-MM-DD/.
        Imprime un resumen con las cifras que hacen falta para valorar.

    python3 scripts/informe-web.py --render ~/.local/share/oposicion-web/informes/AAAA-MM-DD
        Compone informe.html (cuatro caras A4, imprimible) a partir de
        datos.json y, si existe, valoracion.json:
        {"resumen": "…", "web": {"diagnostico": "…", "prioridades": [{"nivel": "Alto", "texto": "…"}]},
         "app": {"diagnostico": "…", "prioridades": […]}, "proximo": ["…"]}

Todo son agregados: nunca nombres, correos ni uid. Los informes se guardan
fuera del repositorio (es público). Solo biblioteca estándar.
"""
import base64
import html
import json
import subprocess
import sys
from datetime import date, datetime
from pathlib import Path

RAIZ = Path(__file__).resolve().parent.parent
SCRIPTS = Path(__file__).resolve().parent
INFORMES = Path.home() / '.local/share/oposicion-web/informes'
FOTOS_WEB = Path.home() / '.local/share/oposicion-web'
FOTOS_RED = Path.home() / '.local/share/oposicion-red'
FOTOS_APP = FOTOS_RED / 'app'
MESES = ['enero', 'febrero', 'marzo', 'abril', 'mayo', 'junio', 'julio', 'agosto', 'septiembre', 'octubre', 'noviembre', 'diciembre']


# ------------------------------------------------------------------- Datos

def ejecutar(script, *args):
    p = subprocess.run([sys.executable, str(SCRIPTS / script), '--json', *args], capture_output=True, text=True, timeout=1500)
    if p.returncode:
        return {'error': p.stderr.strip()[-400:]}
    return json.loads(p.stdout)


def _leer(p):
    try:
        return json.loads(p.read_text())
    except (OSError, ValueError):
        return None


def evolucion():
    """Series de las fotos anteriores, para los gráficos de evolución."""
    web = []
    for p in sorted(FOTOS_WEB.glob('*-28d.json')):
        f = _leer(p)
        if not f:
            continue
        t = f.get('search_console', {}).get('total', {})
        g = f.get('analytics', {}).get('total', {})
        web.append({'fecha': f['fecha'], 'clics': t.get('clics'), 'impresiones': t.get('impresiones'), 'posicion': t.get('posicion'),
                    'usuarios': g.get('activeUsers'), 'sesiones': g.get('sessions')})
    red = []
    for p in sorted(FOTOS_RED.glob('????-??-??.json')):
        f = _leer(p)
        if not f:
            continue
        g = f.get('global', {})
        red.append({'fecha': f['fecha'][:10], 'cuentas': g.get('cuentas', {}).get('cuentas de Google (app y web)'),
                    'app': g.get('personas', {}).get('usan la app'), 'opositores': g.get('personas', {}).get('app: opositores'),
                    'preparadores': g.get('personas', {}).get('app: preparadores'),
                    'activas7': g.get('personas', {}).get('app: activas últimos 7 días'),
                    'tcee': f.get('tcee', {}).get('cuentas', {}).get('total'), 'dce': f.get('dce', {}).get('cuentas', {}).get('total')})
    seo = []
    for p in sorted(FOTOS_WEB.glob('seo-*.json')):
        f = _leer(p)
        if f:
            seo.append({'fecha': f['fecha'], 'nota': f['nota']})
    # Una foto por fecha (la última)
    def unicas(serie):
        d = {x['fecha']: x for x in serie}
        return [d[k] for k in sorted(d)]
    return {'web': unicas(web), 'red': unicas(red), 'seo': unicas(seo)}


def resumen_para_valorar(d):
    w, a, s = d['web'], d['app'], d['seo']
    sc, ga = w.get('search_console', {}), w.get('analytics', {})
    t, ta = sc.get('total', {}), sc.get('total_anterior', {})
    out = [f"PERIODO {d['periodo'][0]} a {d['periodo'][1]} ({d['dias']} días)",
           f"Google: clics {t.get('clics')} (antes {ta.get('clics')}), impresiones {t.get('impresiones')} (antes {ta.get('impresiones')}), "
           f"CTR {t.get('ctr')} %, posición {t.get('posicion')} (antes {ta.get('posicion')})"]
    out.append('Búsquedas: ' + '; '.join(f"{x['query']} {x['clics']}/{x['impresiones']} pos {x['posicion']}" for x in sc.get('busquedas', [])[:12]))
    out.append('Páginas (clics): ' + '; '.join(f"{x['page'].replace('https://www.victorgutierrezmarcos.es', '')} {x['clics']}/{x['impresiones']}" for x in sc.get('paginas', [])[:8]))
    out.append('DCE: ' + ('; '.join(f"{x['query']} {x['clics']}/{x['impresiones']} pos {x['posicion']}" for x in sc.get('busquedas_dce', [])[:6]) or 'ninguna búsqueda'))
    if 'error' in ga:
        out.append('Analytics: ' + ga['error'])
    else:
        g, gant = ga.get('total', {}), ga.get('total_anterior', {})
        out.append(f"Analytics: {g.get('activeUsers')} usuarios, {g.get('sessions')} sesiones, {g.get('screenPageViews')} vistas"
                   + (f" (antes {gant.get('activeUsers')} / {gant.get('sessions')})" if gant else ''))
        out.append('Canales: ' + ', '.join(f"{x['sessionDefaultChannelGroup']} {x['sessions']}" for x in ga.get('canales', [])))
        out.append('Orígenes: ' + ', '.join(f"{x['sessionSource']} {x['sessions']}" for x in ga.get('origenes', [])[:8]))
        out.append('Más vistas: ' + ', '.join(f"{x['pagePath']} {x['screenPageViews']}" for x in ga.get('paginas', [])[:8]))
    out.append(f"SEO técnico: nota {s.get('nota')} · " + ' · '.join(f"{c} {v['nota']}" for c, v in s.get('categorías', {}).items())
               + ' · problemas ' + ', '.join(f'{k} {v}' for k, v in s.get('por nivel', {}).items()))
    for p in s.get('problemas', [])[:10]:
        out.append(f"  [{p['nivel']}] {p['página']}: {p['texto']}")
    r = a.get('red', {})
    g = r.get('global', {})
    out.append(f"Red: cuentas Google {g.get('cuentas', {}).get('cuentas de Google (app y web)')} · usan la app {g.get('personas', {}).get('usan la app')} "
               f"(opositores {g.get('personas', {}).get('app: opositores')}, preparadores {g.get('personas', {}).get('app: preparadores')}) · "
               f"activas 7 d {g.get('personas', {}).get('app: activas últimos 7 días')} · 30 d {g.get('personas', {}).get('app: activas últimos 30 días')} · "
               f"nuevas 30 d {g.get('personas', {}).get('app: nuevas últimos 30 días')}")
    for op in ('tcee', 'dce'):
        c = r.get(op, {})
        out.append(f"  {op.upper()}: cuentas {c.get('cuentas', {}).get('total')} · verificados {c.get('preparadores', {}).get('verificados')} · "
                   f"con alumnos {c.get('preparadores', {}).get('con algún alumno conectado')} · alumnos conectados {c.get('red', {}).get('alumnos conectados (distintos)')} · "
                   f"clases dadas 30 d {c.get('clases', {}).get('dadas últimos 30 días')} · clases sueltas 30 d {c.get('tablón', {}).get('clases sueltas últimos 30 días', 0)} · "
                   f"tests 30 d {c.get('tests', {}).get('últimos 30 días')}")
    ev = d['evolucion']['red']
    if len(ev) > 1:
        out.append('Evolución red: ' + '; '.join(f"{x['fecha']} {x['app']} app / {x['cuentas']} cuentas" for x in ev))
    for clave in ('play', 'analytics', 'apk_github'):
        v = a.get(clave, {})
        if 'pendiente' in v:
            out.append(f'{clave}: PENDIENTE — {v["pendiente"]}')
        elif clave == 'play':
            i = v.get('informes', {})
            out.append('Play: ' + (f"pendiente — {i['pendiente']}" if 'pendiente' in i else
                       f"instalaciones {i['instalaciones (usuarios)']} (antes {i['instalaciones periodo anterior']}), desinstalaciones {i['desinstalaciones (usuarios)']}, "
                       f"activos {i['dispositivos activos']}, acumuladas {i['instalaciones acumuladas (usuarios)']}, valoración {i.get('valoración media')}"))
            out.append('Vitales: ' + '; '.join(f"{k} {'pendiente' if 'pendiente' in x else x}" for k, x in v.get('vitales', {}).items()))
        elif clave == 'analytics':
            t = v.get('total', {})
            out.append(f"Analytics app: {t.get('activeUsers')} usuarios, {t.get('sessions')} sesiones; eventos " + ', '.join(f"{x['eventName']} {x['eventCount']}" for x in v.get('eventos', [])))
        else:
            out.append(f"APK GitHub: {v.get('descargas')} descargas")
    return '\n'.join(out)


def datos(dias):
    hoy = date.today().isoformat()
    carpeta = INFORMES / hoy
    carpeta.mkdir(parents=True, exist_ok=True)
    print('Leyendo Search Console y Analytics…', file=sys.stderr)
    web = ejecutar('estadisticas-web.py', '--dias', str(dias))
    print('Leyendo la app (Play, Analytics, GitHub y la red)…', file=sys.stderr)
    app = ejecutar('estadisticas-app.py', '--dias', str(dias))
    print('Comprobando el SEO…', file=sys.stderr)
    seo = ejecutar('comprobar-seo.py')
    d = {'fecha': hoy, 'dias': dias,
         'periodo': web.get('search_console', {}).get('periodo', app.get('periodo', ['', ''])),
         'web': web, 'app': app, 'seo': seo, 'evolucion': evolucion()}
    (carpeta / 'datos.json').write_text(json.dumps(d, ensure_ascii=False, indent=1))
    print(f'Datos en {carpeta / "datos.json"}\n', file=sys.stderr)
    print(resumen_para_valorar(d))
    return carpeta


# ----------------------------------------------------------------- Gráficos

def e(s):
    return html.escape(str(s if s is not None else '—'))


def num(x, dec=0):
    if x is None or x == '':
        return '—'
    try:
        x = float(x)
    except (TypeError, ValueError):
        return e(x)
    s = f'{x:,.{dec}f}'.replace(',', ' ').replace('.', ',')
    return s


def delta(ahora, antes, pct=True, invertido=False):
    """«+12 %» o «−3» frente al periodo anterior, en una pastilla."""
    if ahora is None or antes in (None, 0, ''):
        return ''
    try:
        d = float(ahora) - float(antes)
    except (TypeError, ValueError):
        return ''
    if abs(d) < 1e-9:
        return '<span class="delta igual">=</span>'
    texto = f'{d / float(antes) * 100:+.0f} %' if pct else f'{d:+.1f}'.rstrip('0').rstrip(',')
    bien = (d < 0) if invertido else (d > 0)
    return f'<span class="delta {"sube" if bien else "baja"}">{texto.replace("-", "−")}</span>'


def barras_h(filas, ancho=330, alto_fila=20, maximo=None, color='var(--serie1)', etiq=128, corte=24):
    """Barras horizontales con etiqueta a la izquierda y valor a la derecha."""
    if not filas:
        return '<p class="vacio">Sin datos</p>'
    maximo = maximo or max((v for _, v in filas), default=1) or 1
    alto = alto_fila * len(filas) + 4
    out = [f'<svg class="grafico" viewBox="0 0 {ancho} {alto}" role="img">']
    for i, (nombre, v) in enumerate(filas):
        y = i * alto_fila + 2
        w = max(2, (ancho - etiq - 44) * (v or 0) / maximo)
        out.append(f'<text x="{etiq - 6}" y="{y + 13}" text-anchor="end" class="etq">{e(str(nombre)[:corte])}</text>'
                   f'<rect x="{etiq}" y="{y + 3}" width="{w:.1f}" height="{alto_fila - 7}" rx="2" fill="{color}"/>'
                   f'<text x="{etiq + w + 5:.1f}" y="{y + 13}" class="val">{num(v)}</text>')
    out.append('</svg>')
    return ''.join(out)


def barras_dobles(categorias, a, b, nombres, ancho=330, alto=150):
    """Dos series por categoría (p. ej. TCEE y DCE), con leyenda y valores."""
    maximo = max([*(x or 0 for x in a), *(x or 0 for x in b), 1])
    n = len(categorias)
    margen_i, margen_d, base, arriba = 8, 8, alto - 22, 18
    paso = (ancho - margen_i - margen_d) / n
    w = min(28, paso * 0.32)
    alto_util = base - arriba
    out = [f'<svg class="grafico" viewBox="0 0 {ancho} {alto}" role="img">',
           f'<line x1="{margen_i}" x2="{ancho - margen_d}" y1="{base}" y2="{base}" class="eje"/>']
    for i, c in enumerate(categorias):
        cx = margen_i + paso * (i + 0.5)
        for j, (serie, color) in enumerate(((a, 'var(--serie1)'), (b, 'var(--serie2)'))):
            v = serie[i] or 0
            h = alto_util * v / maximo
            x = cx - w - 1 if j == 0 else cx + 1
            out.append(f'<rect x="{x:.1f}" y="{base - h:.1f}" width="{w:.1f}" height="{h:.1f}" rx="2" fill="{color}"/>'
                       f'<text x="{x + w / 2:.1f}" y="{base - h - 3:.1f}" text-anchor="middle" class="val">{num(v)}</text>')
        out.append(f'<text x="{cx:.1f}" y="{base + 14}" text-anchor="middle" class="etq">{e(c)}</text>')
    out.append('</svg>')
    leyenda = ''.join(f'<span><i style="background:var(--serie{i + 1})"></i>{e(n)}</span>' for i, n in enumerate(nombres))
    return f'<div class="leyenda">{leyenda}</div>' + ''.join(out)


def linea(puntos, ancho=330, alto=90, etiqueta_y=True, formato=lambda v: num(v)):
    """Línea con los puntos marcados y el último valor rotulado. puntos: [(etiqueta, valor)]."""
    puntos = [(k, v) for k, v in puntos if v is not None]
    if len(puntos) < 2:
        return '<p class="vacio">Hace falta más de una foto para ver la evolución</p>'
    vals = [v for _, v in puntos]
    lo, hi = min(vals), max(vals)
    if hi == lo:
        hi = lo + 1
    mi, md, mt, mb = 8, 48, 12, 22
    def X(i): return mi + (ancho - mi - md) * i / (len(puntos) - 1)
    def Y(v): return mt + (alto - mt - mb) * (1 - (v - lo) / (hi - lo))
    ruta = ' '.join(f'{"M" if i == 0 else "L"}{X(i):.1f},{Y(v):.1f}' for i, (_, v) in enumerate(puntos))
    out = [f'<svg class="grafico" viewBox="0 0 {ancho} {alto}" role="img">',
           f'<line x1="{mi}" x2="{ancho - md}" y1="{alto - mb}" y2="{alto - mb}" class="eje"/>',
           f'<path d="{ruta}" fill="none" stroke="var(--serie1)" stroke-width="2" stroke-linejoin="round"/>']
    for i, (k, v) in enumerate(puntos):
        out.append(f'<circle cx="{X(i):.1f}" cy="{Y(v):.1f}" r="3.5" fill="var(--serie1)" stroke="var(--superficie)" stroke-width="2"/>')
        if i in (0, len(puntos) - 1) or len(puntos) <= 6:
            out.append(f'<text x="{X(i):.1f}" y="{alto - 6}" text-anchor="{"start" if i == 0 else "end" if i == len(puntos) - 1 else "middle"}" class="etq">{e(k[5:] if len(k) == 10 else k)}</text>')
    out.append(f'<text x="{X(len(puntos) - 1) + 7:.1f}" y="{Y(vals[-1]) + 4:.1f}" class="val fuerte">{formato(vals[-1])}</text>')
    out.append('</svg>')
    return ''.join(out)


def dial(nota):
    """La nota del SEO como arco (0-100)."""
    if nota is None:
        return ''
    import math
    r, cx, cy = 44, 60, 60
    ang = math.pi * (1 - nota / 100)
    x, y = cx + r * math.cos(ang), cy - r * math.sin(ang)
    grande = 1 if nota > 50 else 0
    return (f'<svg class="dial" viewBox="0 0 120 72" role="img" aria-label="Nota {nota} de 100">'
            f'<path d="M{cx - r},{cy} A{r},{r} 0 0 1 {cx + r},{cy}" fill="none" stroke="var(--regla)" stroke-width="9" stroke-linecap="round"/>'
            f'<path d="M{cx - r},{cy} A{r},{r} 0 {grande} 1 {x:.1f},{y:.1f}" fill="none" stroke="var(--serie1)" stroke-width="9" stroke-linecap="round"/>'
            f'<text x="{cx}" y="{cy - 2}" text-anchor="middle" class="dial-num">{nota}</text>'
            f'<text x="{cx}" y="{cy + 12}" text-anchor="middle" class="etq">de 100</text></svg>')


def barras_categorias(categorias):
    filas = []
    for c, v in categorias.items():
        n = v.get('nota')
        filas.append((f"{c} ({v.get('peso')} %)", n if n is not None else 0))
    return barras_h(filas, maximo=100, alto_fila=18, etiq=150, corte=32)


# ------------------------------------------------------------------- Piezas

def kpi(titulo, valor, pie='', d=''):
    return f'<div class="kpi"><span class="kpi-t">{e(titulo)}</span><span class="kpi-v">{valor}{d}</span><span class="kpi-p">{pie}</span></div>'


def tabla(cabeceras, filas, clase='', num_desde=1):
    if not filas:
        return '<p class="vacio">Sin datos</p>'
    th = ''.join(f'<th{" class=n" if i >= num_desde else ""}>{e(c)}</th>' for i, c in enumerate(cabeceras))
    tr = ''.join('<tr>' + ''.join(f'<td{" class=n" if i >= num_desde else ""}>{c}</td>' for i, c in enumerate(f)) + '</tr>' for f in filas)
    return f'<table class="tabla {clase}"><thead><tr>{th}</tr></thead><tbody>{tr}</tbody></table>'


def lista_prioridades(items):
    if not items:
        return '<p class="vacio">Pendiente de valorar</p>'
    return '<ol class="prioridades">' + ''.join(
        f'<li><span class="nivel nivel-{e(i.get("nivel", "Medio")).lower()}">{e(i.get("nivel", "Medio"))}</span>{e(i.get("texto", ""))}</li>'
        for i in items) + '</ol>'


def parrafos(texto, clase='diagnostico'):
    if not texto:
        return f'<p class="vacio">Pendiente de valorar</p>'
    return ''.join(f'<p class="{clase}">{e(p.strip())}</p>' for p in str(texto).split('\n') if p.strip())


def _fuente(nombre):
    p = RAIZ / 'fuentes' / nombre
    if not p.is_file():
        return None
    return 'data:font/woff;base64,' + base64.b64encode(p.read_bytes()).decode()


def corta(url):
    return url.replace('https://www.victorgutierrezmarcos.es', '') or '/'


# ------------------------------------------------------------------ Render

def render(carpeta):
    carpeta = Path(carpeta)
    d = json.loads((carpeta / 'datos.json').read_text())
    v = _leer(carpeta / 'valoracion.json') or {}
    web, app, seo, ev = d['web'], d['app'], d['seo'], d['evolucion']
    sc, ga = web.get('search_console', {}), web.get('analytics', {})
    t, ta = sc.get('total', {}), sc.get('total_anterior', {})
    g, gant = ga.get('total', {}), ga.get('total_anterior', {})
    red = app.get('red', {})
    glob = red.get('global', {})
    per, cue = glob.get('personas', {}), glob.get('cuentas', {})
    tcee, dce = red.get('tcee', {}), red.get('dce', {})
    play, an, apk = app.get('play', {}), app.get('analytics', {}), app.get('apk_github', {})
    fecha = datetime.strptime(d['fecha'], '%Y-%m-%d')
    titulo_mes = f'{MESES[fecha.month - 1]} de {fecha.year}'
    periodo = f"{d['periodo'][0]} a {d['periodo'][1]}" if d['periodo'][0] else ''
    reg, neg = _fuente('pagella-regular.woff'), _fuente('pagella-bold.woff')
    fuentes_css = ''
    if reg and neg:
        fuentes_css = (f"@font-face{{font-family:'Pagella';src:url({reg}) format('woff');font-weight:400;font-display:swap}}"
                       f"@font-face{{font-family:'Pagella';src:url({neg}) format('woff');font-weight:700;font-display:swap}}")

    # --- Web, cara 1
    kpis_web = ''.join([
        kpi('Clics desde Google', num(t.get('clics')), f"antes {num(ta.get('clics'))}", delta(t.get('clics'), ta.get('clics'))),
        kpi('Impresiones', num(t.get('impresiones')), f"antes {num(ta.get('impresiones'))}", delta(t.get('impresiones'), ta.get('impresiones'))),
        kpi('CTR', f"{num(t.get('ctr'), 1)} %", f"antes {num(ta.get('ctr'), 1)} %"),
        kpi('Posición media', num(t.get('posicion'), 1), f"antes {num(ta.get('posicion'), 1)}", delta(t.get('posicion'), ta.get('posicion'), pct=False, invertido=True)),
        kpi('Usuarios (Analytics)', num(g.get('activeUsers')), f"antes {num(gant.get('activeUsers'))}" if gant else 'solo quien acepta cookies', delta(g.get('activeUsers'), gant.get('activeUsers'))),
        kpi('Sesiones', num(g.get('sessions')), f"{num(g.get('screenPageViews'))} páginas vistas", delta(g.get('sessions'), gant.get('sessions'))),
    ])
    busquedas = tabla(['Búsqueda', 'Clics', 'Impr.', 'Pos.'],
                      [[e(x['query']), num(x['clics']), num(x['impresiones']), num(x['posicion'], 1)] for x in sc.get('busquedas', [])[:12]])
    evo_web = ev.get('web', [])
    serie_clics = linea([(x['fecha'], x['clics']) for x in evo_web])
    serie_usuarios = linea([(x['fecha'], x['usuarios']) for x in evo_web])
    seo_cats = seo.get('categorías', {})
    problemas = seo.get('problemas', [])
    por_nivel = seo.get('por nivel', {})
    resumen_niveles = ' · '.join(f'{k} {v}' for k, v in por_nivel.items()) or 'ningún problema'

    # --- Web, cara 2
    paginas_clics = tabla(['Página', 'Clics', 'Impr.', 'Pos.'],
                          [[e(corta(x['page'])), num(x['clics']), num(x['impresiones']), num(x['posicion'], 1)] for x in sc.get('paginas', [])[:10]])
    paginas_vistas = tabla(['Página', 'Vistas', 'Usuarios'],
                           [[e(x['pagePath']), num(x['screenPageViews']), num(x['activeUsers'])] for x in ga.get('paginas', [])[:10]])
    canales = barras_h([(x['sessionDefaultChannelGroup'], x['sessions']) for x in ga.get('canales', [])[:7]])
    origenes = barras_h([(x['sessionSource'], x['sessions']) for x in ga.get('origenes', [])[:8]])
    dce_busq = sc.get('busquedas_dce', [])
    app_busq = sc.get('busquedas_app', [])
    temas_pedidos = ga.get('temas_pedidos', [])
    pedidos = {}
    for x in temas_pedidos:
        q = x.get('pagePathPlusQueryString', '')
        tema = q.split('tema=')[-1].split('&')[0] if 'tema=' in q else '?'
        pedidos[tema] = pedidos.get(tema, 0) + x.get('screenPageViews', 0)
    pedidos = sorted(pedidos.items(), key=lambda kv: -kv[1])[:8]
    filas_prob = [[f'<span class="nivel nivel-{p["nivel"].lower()}">{e(p["nivel"])}</span>', e(p['categoría']), e(p['página']), e(p['texto'])]
                  for p in problemas[:10]]
    psi = seo.get('pagespeed', {})
    filas_psi = []
    for ruta, x in psi.items():
        if 'pendiente' in x:
            filas_psi.append([e(ruta), f'<span class="pend">{e(x["pendiente"])}</span>', '', ''])
        else:
            campo = x.get('campo') or {}
            filas_psi.append([e(ruta), num(x['nota laboratorio']), f"{e(x['LCP'])} / {e(x['CLS'])}",
                              ' · '.join(f'{k} {e(c)}' for k, c in campo.items() if c) or 'sin datos de campo'])

    # --- App, cara 3
    ev_red = ev.get('red', [])
    ant_red = ev_red[-2] if len(ev_red) > 1 and ev_red[-1]['fecha'] == d['fecha'] else (ev_red[-1] if ev_red and ev_red[-1]['fecha'] != d['fecha'] else None)
    def dr(clave, actual):
        return delta(actual, ant_red.get(clave)) if ant_red else ''
    inf = play.get('informes', {}) if 'pendiente' not in play else {}
    inst = inf.get('instalaciones (usuarios)') if inf and 'pendiente' not in inf else None
    kpis_app = ''.join([
        kpi('Cuentas de Google', num(cue.get('cuentas de Google (app y web)')), 'app y simulador web', dr('cuentas', cue.get('cuentas de Google (app y web)'))),
        kpi('Usan la app', num(per.get('usan la app')), f"{num(per.get('solo la web (simulador)'))} solo el simulador", dr('app', per.get('usan la app'))),
        kpi('Opositores', num(per.get('app: opositores')), f"TCEE {num(per.get('app: opositores en TCEE'))} · DCE {num(per.get('app: opositores en DCE'))}", dr('opositores', per.get('app: opositores'))),
        kpi('Preparadores', num(per.get('app: preparadores')), f"TCEE {num(per.get('app: preparadores en TCEE'))} · DCE {num(per.get('app: preparadores en DCE'))}", dr('preparadores', per.get('app: preparadores'))),
        kpi('Activas 7 días', num(per.get('app: activas últimos 7 días')), f"{num(per.get('app: activas últimos 30 días'))} en 30 días", dr('activas7', per.get('app: activas últimos 7 días'))),
        kpi('Nuevas en 30 días', num(per.get('app: nuevas últimos 30 días')), f"{num(per.get('app: nuevas últimos 7 días'))} en 7 días"),
        kpi('Instalaciones Play', num(inst) if inst is not None else '<span class="pend">pendiente</span>',
            f"{num(inf.get('dispositivos activos'))} dispositivos activos" if inst is not None else 'ver «Lo que falta»',
            delta(inst, inf.get('instalaciones periodo anterior')) if inst is not None else ''),
        kpi('APK (GitHub)', num(apk.get('descargas')) if 'pendiente' not in apk else '—', f"subido el {e(apk.get('subido'))}" if 'pendiente' not in apk else e(apk.get('pendiente'))),
    ])
    def c(op, *k):
        x = op
        for kk in k:
            x = x.get(kk, {}) if isinstance(x, dict) else {}
        return x if not isinstance(x, dict) else None
    comparativa = barras_dobles(
        ['Cuentas', 'Opositores', 'Preparadores', 'Verificados', 'Activas 7 d'],
        [c(tcee, 'cuentas', 'total'), c(tcee, 'cuentas', 'opositores'), c(tcee, 'cuentas', 'preparadores'), c(tcee, 'preparadores', 'verificados'), c(tcee, 'cuentas', 'activas últimos 7 días')],
        [c(dce, 'cuentas', 'total'), c(dce, 'cuentas', 'opositores'), c(dce, 'cuentas', 'preparadores'), c(dce, 'preparadores', 'verificados'), c(dce, 'cuentas', 'activas últimos 7 días')],
        ['TCEE', 'DCE'])
    serie_app = linea([(x['fecha'], x['app']) for x in ev_red])
    if 'pendiente' in play:
        bloque_play = f'<p class="pend">{e(play["pendiente"])}</p>'
    else:
        partes = []
        if 'pendiente' in inf:
            partes.append(f'<p class="pend">{e(inf["pendiente"])}</p>')
        else:
            partes.append(linea([(x[0], x[3]) for x in inf.get('por día', [])], alto=80) if inf.get('por día') else '')
            partes.append(f'<p class="nota">Instalaciones {num(inf["instalaciones (usuarios)"])} y desinstalaciones {num(inf["desinstalaciones (usuarios)"])} en el periodo; '
                          f'{num(inf["instalaciones acumuladas (usuarios)"])} acumuladas; valoración media {num(inf.get("valoración media"), 2)}'
                          + (' · países: ' + ', '.join(f'{p} {n}' for p, n in inf['países']) if inf.get('países') else '') + '.</p>')
        vit = play.get('vitales', {})
        filas = []
        for k, x in vit.items():
            if 'pendiente' in x:
                filas.append([e(k), f'<span class="pend">{e(x["pendiente"])}</span>', ''])
            else:
                tasa = x.get('crashRate', x.get('anrRate'))
                filas.append([e('Fallos' if k == 'crashRate' else 'ANR'), f'{num(tasa, 2)} %', f"{num(x.get('distinctUsers'))} usuarios · hasta {e(x.get('hasta'))}"])
        res = play.get('reseñas', {})
        filas.append([e('Reseñas'), f'<span class="pend">{e(res["pendiente"])}</span>' if 'pendiente' in res else num(res.get('última semana')),
                      '' if 'pendiente' in res else f"media {num(res.get('media'), 1)} en la última semana"])
        partes.append(tabla(['Vitales', 'Valor', ''], filas))
        bloque_play = ''.join(partes)

    # --- App, cara 4
    def fila_op(nombre, *claves):
        return [e(nombre)] + [num(c(op, *claves)) for op in (tcee, dce)]
    tabla_ops = tabla(['', 'TCEE', 'DCE'], [
        fila_op('Cuentas', 'cuentas', 'total'),
        fila_op('Nuevas en 30 días', 'cuentas', 'nuevas últimos 30 días'),
        fila_op('Activas en 30 días', 'cuentas', 'activas últimos 30 días'),
        fila_op('Opositores', 'cuentas', 'opositores'),
        fila_op('Opositores activos 7 días', 'cuentas', 'opositores activos últimos 7 días'),
        fila_op('Preparadores', 'cuentas', 'preparadores'),
        fila_op('Preparadores verificados', 'preparadores', 'verificados'),
        fila_op('Preparadores con algún alumno', 'preparadores', 'con algún alumno conectado'),
        fila_op('Preparadores con huecos abiertos', 'preparadores', 'con huecos abiertos'),
        fila_op('Alumnos conectados', 'red', 'alumnos conectados (distintos)'),
        fila_op('Fichas de alumnos sin la app', 'red', 'fichas de alumnos sin la app'),
        fila_op('Clases creadas (total)', 'clases', 'total'),
        fila_op('Clases dadas en 30 días', 'clases', 'dadas últimos 30 días'),
        fila_op('Clases programadas 7 días', 'clases', 'programadas próximos 7 días'),
        fila_op('Clases sueltas pedidas 30 días', 'tablón', 'clases sueltas últimos 30 días'),
        fila_op('Tests hechos en 30 días', 'tests', 'últimos 30 días'),
        fila_op('Tests hechos (total)', 'tests', 'total'),
    ])
    if 'pendiente' in an:
        bloque_an = f'<p class="pend">{e(an["pendiente"])}</p>'
    else:
        ta_ = an.get('total', {})
        bloque_an = ''.join([
            f'<p class="nota">{num(ta_.get("activeUsers"))} usuarios ({num(ta_.get("newUsers"))} nuevos), {num(ta_.get("sessions"))} sesiones, '
            f'{num(ta_.get("averageSessionDuration"))} s por sesión. '
            + (f'Retención DAU/MAU {num(an["retención"].get("dauPerMau"), 2)}. ' if an.get('retención') else '')
            + (f'Usuarios sin fallos {num(an["fallos"].get("crashFreeUsersRate"), 1)} %. ' if an.get('fallos') else '') + '</p>',
            '<div class="dos">',
            '<div><h4>Pantallas más usadas</h4>' + barras_h([(x['unifiedScreenName'], x['screenPageViews']) for x in an.get('pantallas', [])[:8]]) + '</div>',
            '<div><h4>Acciones registradas</h4>' + barras_h([(x['eventName'].replace('_', ' '), x['eventCount']) for x in an.get('eventos', [])]) +
            '<h4>Versiones</h4>' + barras_h([(x['appVersion'], x['activeUsers']) for x in an.get('versiones', [])[:5]]) + '</div>',
            '</div>'])
    faltan = []
    for nombre, x in (('Google Play', play), ('Informes de Play', inf if inf else {}), ('Analytics de la app', an), ('APK en GitHub', apk)):
        if isinstance(x, dict) and 'pendiente' in x:
            faltan.append(f'<li><strong>{e(nombre)}:</strong> {e(x["pendiente"])}</li>')
    for k, x in (play.get('vitales', {}) if 'pendiente' not in play else {}).items():
        if 'pendiente' in x:
            faltan.append(f'<li><strong>{e("Fallos y ANR" if k == "crashRate" else k)}:</strong> {e(x["pendiente"])}</li>')
    for ruta, x in psi.items():
        if 'pendiente' in x:
            faltan.append(f'<li><strong>PageSpeed {e(ruta)}:</strong> {e(x["pendiente"])}</li>')
            break
    bloque_faltan = ('<ul class="faltan">' + ''.join(faltan) + '</ul>') if faltan else '<p class="nota">Todas las fuentes responden.</p>'

    vw, va = v.get('web', {}), v.get('app', {})
    proximo = v.get('proximo', [])
    doc = f'''<meta charset="utf-8">
<title>Informe web y app · {e(titulo_mes)}</title>
<meta name="claude:viewport-fit-sides" content="cover">
<link rel="preconnect" href="https://fonts.googleapis.com"><link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Source+Sans+3:ital,wght@0,400;0,600;0,700;1,400&display=swap" rel="stylesheet">
<style>
{fuentes_css}
/* Cuatro caras A4 («edición académica»: morado como tinta, salvia como papel, oro como filete) */
:root {{
  --papel: #E2EFD9; --superficie: #FFFFFF; --tinta: #5F2987; --tinta-oscura: #4A1F6B; --texto: #222222; --suave: #5E5A66;
  --regla: #D9D2E3; --oro: #B8860B; --pálido: #F1EBF6; --serie1: #7A3CA8; --serie2: #2A8C64; --serie3: #B8860B;
  --bien: #2A8C64; --mal: #B23A3A; --critico: #B23A3A; --alto: #C25A14; --medio: #B8860B; --bajo: #6B6B6B;
  --serif: 'Pagella', 'Palatino Linotype', Palatino, 'Book Antiqua', Georgia, serif;
  --sans: 'Source Sans 3', 'Segoe UI', Roboto, Helvetica, Arial, sans-serif;
}}
@media (prefers-color-scheme: dark) {{ :root:not([data-theme="light"]) {{
  --papel: #1C1420; --superficie: #26202B; --tinta: #CDB3E3; --tinta-oscura: #E4D3F2; --texto: #ECE7EF; --suave: #B5ADBC;
  --regla: #3E3546; --oro: #D9A92A; --pálido: #2F2636; --serie1: #A878D0; --serie2: #4EA882; --serie3: #C79A2E;
  --bien: #5FBF95; --mal: #E08080; --critico: #E08080; --alto: #E39A5C; --medio: #D9A92A; --bajo: #A8A8A8; color-scheme: dark; }} }}
:root[data-theme="dark"] {{
  --papel: #1C1420; --superficie: #26202B; --tinta: #CDB3E3; --tinta-oscura: #E4D3F2; --texto: #ECE7EF; --suave: #B5ADBC;
  --regla: #3E3546; --oro: #D9A92A; --pálido: #2F2636; --serie1: #A878D0; --serie2: #4EA882; --serie3: #C79A2E;
  --bien: #5FBF95; --mal: #E08080; --critico: #E08080; --alto: #E39A5C; --medio: #D9A92A; --bajo: #A8A8A8; color-scheme: dark; }}
* {{ box-sizing: border-box; }}
body {{ margin: 0; background: var(--papel); color: var(--texto); font-family: var(--sans); font-size: 10.5pt; line-height: 1.4;
  padding-block: 18px 40px; padding-left: max(16px, env(safe-area-inset-left, 0px)); padding-right: max(16px, env(safe-area-inset-right, 0px)); }}
.hoja {{ background: var(--superficie); max-width: 210mm; min-height: 297mm; margin: 0 auto 18px; padding: 12mm 13mm 11mm; position: relative;
  border: 1px solid var(--regla); break-after: page; }}
.hoja header {{ display: flex; justify-content: space-between; align-items: baseline; gap: 12px; flex-wrap: wrap; border-bottom: 2px solid var(--oro); padding-bottom: 5px; margin-bottom: 10px; }}
.hoja header h1, .hoja header h2 {{ font-family: var(--serif); color: var(--tinta); margin: 0; font-weight: 700; text-wrap: balance; }}
h1 {{ font-size: 20pt; }} h2 {{ font-size: 16pt; }}
h3 {{ font-family: var(--serif); font-size: 12pt; color: var(--tinta); margin: 10px 0 4px; font-weight: 700; font-variant-caps: all-small-caps; letter-spacing: .02em; }}
h4 {{ font-size: 9.5pt; margin: 6px 0 2px; color: var(--suave); font-weight: 600; font-variant-caps: all-small-caps; letter-spacing: .04em; }}
.sello {{ font-size: 9pt; color: var(--suave); }}
.kpis {{ display: grid; grid-template-columns: repeat(auto-fit, minmax(96px, 1fr)); gap: 8px; margin: 4px 0 8px; }}
.kpi {{ display: flex; flex-direction: column; border-top: 2px solid var(--tinta); padding-top: 4px; min-width: 0; }}
.kpi-t {{ font-size: 8pt; color: var(--suave); font-variant-caps: all-small-caps; letter-spacing: .03em; }}
.kpi-v {{ font-family: var(--serif); font-size: 19pt; color: var(--tinta); line-height: 1.1; font-variant-numeric: tabular-nums; display: flex; align-items: baseline; gap: 6px; flex-wrap: wrap; }}
.kpi-p {{ font-size: 8pt; color: var(--suave); }}
.delta {{ font-family: var(--sans); font-size: 8.5pt; font-weight: 600; padding: 0 4px; border-radius: 3px; }}
.delta.sube {{ color: var(--bien); }} .delta.baja {{ color: var(--mal); }} .delta.igual {{ color: var(--suave); }}
.dos {{ display: grid; grid-template-columns: 1fr 1fr; gap: 12px 16px; }}
.tres {{ display: grid; grid-template-columns: 1fr 1fr 1fr; gap: 12px; }}
.dos > *, .tres > * {{ min-width: 0; }}
@media (max-width: 640px) {{ .dos, .tres {{ grid-template-columns: 1fr; }} .hoja {{ min-height: 0; padding: 18px 16px; }} }}
.grafico {{ width: 100%; height: auto; display: block; font-family: var(--sans); }}
.grafico .etq {{ font-size: 9px; fill: var(--suave); }} .grafico .val {{ font-size: 9px; fill: var(--texto); font-variant-numeric: tabular-nums; }}
.grafico .fuerte {{ font-weight: 700; fill: var(--tinta); }} .grafico .eje {{ stroke: var(--regla); stroke-width: 1; }}
.dial {{ width: 120px; height: 72px; display: block; }} .dial-num {{ font-family: var(--serif); font-size: 22px; font-weight: 700; fill: var(--tinta); }}
.dial .etq {{ font-size: 8px; fill: var(--suave); }}
.leyenda {{ display: flex; gap: 12px; font-size: 8.5pt; color: var(--suave); margin: 2px 0 0; }}
.leyenda i {{ display: inline-block; width: 10px; height: 10px; border-radius: 2px; margin-right: 4px; vertical-align: -1px; }}
.tabla {{ width: 100%; border-collapse: collapse; font-size: 8.8pt; }}
.tabla th {{ text-align: left; font-weight: 600; color: var(--suave); border-bottom: 1px solid var(--tinta); padding: 2px 4px; font-variant-caps: all-small-caps; }}
.tabla td {{ padding: 2px 4px; border-bottom: 1px solid var(--regla); vertical-align: top; }}
.tabla .n {{ text-align: right; font-variant-numeric: tabular-nums; white-space: nowrap; }}
.tabla.problemas td:last-child {{ font-size: 8.3pt; }}
.nivel {{ display: inline-block; font-size: 7.5pt; font-weight: 700; font-variant-caps: all-small-caps; letter-spacing: .04em; padding: 0 5px; border-radius: 3px; border: 1px solid currentColor; margin-right: 6px; white-space: nowrap; }}
.nivel-crítico {{ color: var(--critico); }} .nivel-alto {{ color: var(--alto); }} .nivel-medio {{ color: var(--medio); }} .nivel-bajo {{ color: var(--bajo); }}
.diagnostico {{ font-size: 10.2pt; margin: 0 0 6px; max-width: 68ch; }}
.diagnostico:first-of-type::first-letter {{ font-family: var(--serif); color: var(--tinta); }}
.resumen {{ font-family: var(--serif); font-size: 11.5pt; color: var(--tinta-oscura); border-left: 3px solid var(--oro); padding-left: 10px; margin: 6px 0 10px; max-width: 70ch; }}
.prioridades {{ margin: 2px 0 0; padding-left: 18px; }} .prioridades li {{ margin-bottom: 4px; }}
.faltan {{ margin: 2px 0; padding-left: 18px; font-size: 9.3pt; }} .faltan li {{ margin-bottom: 3px; }}
.nota, .vacio {{ font-size: 9pt; color: var(--suave); margin: 3px 0; }}
.pend {{ color: var(--alto); font-size: 9pt; }}
.pie {{ position: absolute; left: 13mm; right: 13mm; bottom: 7mm; display: flex; justify-content: space-between; font-size: 8pt; color: var(--suave); border-top: 1px solid var(--regla); padding-top: 3px; }}
@media (max-width: 640px) {{ .pie {{ position: static; margin-top: 14px; }} }}
.nota-seo {{ display: flex; gap: 12px; align-items: center; }}
@media print {{ @page {{ size: A4; margin: 0; }} body {{ background: #fff; padding: 0; }} .hoja {{ border: 0; margin: 0; max-width: none; min-height: 297mm; }} }}
</style>

<section class="hoja">
  <header><h1>La web, {e(titulo_mes)}</h1><span class="sello">{e(periodo)} · Google y Analytics · informe del {e(d['fecha'])}</span></header>
  {parrafos(v.get('resumen'), 'resumen') if v.get('resumen') else ''}
  <div class="kpis">{kpis_web}</div>
  <div class="dos">
    <div>
      <h3>Diagnóstico</h3>
      {parrafos(vw.get('diagnostico'))}
      <h3>Nota técnica del SEO</h3>
      <div class="nota-seo">{dial(seo.get('nota'))}<div style="flex:1;min-width:0">{barras_categorias(seo_cats)}</div></div>
      <p class="nota">{e(seo.get('páginas', {}).get('indexables', '—'))} páginas indexables · problemas: {e(resumen_niveles)}</p>
    </div>
    <div>
      <h3>Búsquedas que traen visitas</h3>
      {busquedas}
    </div>
  </div>
  <div class="dos">
    <div><h3>Clics en Google, foto a foto</h3>{serie_clics}</div>
    <div><h3>Usuarios en Analytics, foto a foto</h3>{serie_usuarios}</div>
  </div>
  <div class="pie"><span>Víctor Gutiérrez Marcos · victorgutierrezmarcos.es</span><span>1 / 4</span></div>
</section>

<section class="hoja">
  <header><h2>La web, en detalle</h2><span class="sello">{e(periodo)}</span></header>
  <div class="dos">
    <div><h3>Páginas con más clics en Google</h3>{paginas_clics}</div>
    <div><h3>Páginas más vistas (Analytics)</h3>{paginas_vistas}</div>
  </div>
  <div class="dos">
    <div><h3>Canales (sesiones)</h3>{canales}</div>
    <div><h3>Orígenes (sesiones)</h3>{origenes}</div>
  </div>
  <div class="dos">
    <div><h3>Búsquedas de DCE y de la app</h3>
      {tabla(['Búsqueda', 'Clics', 'Impr.', 'Pos.'], [[e(x['query']), num(x['clics']), num(x['impresiones']), num(x['posicion'], 1)] for x in (dce_busq[:5] + [b for b in app_busq if b not in dce_busq][:5])])}
    </div>
    <div><h3>Temas sin PDF que se piden</h3>
      {barras_h(pedidos, alto_fila=16) if pedidos else '<p class="vacio">Ninguno en el periodo</p>'}
      <h3>Core Web Vitals (PageSpeed, móvil)</h3>
      {tabla(['Página', 'Nota', 'LCP / CLS', 'Campo'], filas_psi, num_desde=1) if filas_psi else '<p class="vacio">Sin medir</p>'}
    </div>
  </div>
  <h3>Problemas técnicos por prioridad</h3>
  {tabla(['Nivel', 'Categoría', 'Página', 'Problema'], filas_prob, 'problemas', num_desde=9) if filas_prob else '<p class="nota">Ningún problema en la comprobación técnica.</p>'}
  {('<p class="nota">… y ' + str(len(problemas) - 10) + ' más de prioridad baja, en seo-' + e(seo.get('fecha')) + '.json.</p>') if len(problemas) > 10 else ''}
  <h3>Prioridades de la web para el mes</h3>
  {lista_prioridades(vw.get('prioridades'))}
  <div class="pie"><span>Comprobación técnica: scripts/comprobar-seo.py · Search Console y Analytics: scripts/estadisticas-web.py</span><span>2 / 4</span></div>
</section>

<section class="hoja">
  <header><h1>La app, {e(titulo_mes)}</h1><span class="sello">{e(periodo)} · Firebase, Google Play y GitHub · solo recuentos, sin nombres</span></header>
  <div class="kpis">{kpis_app}</div>
  <div class="dos">
    <div>
      <h3>Diagnóstico</h3>
      {parrafos(va.get('diagnostico'))}
    </div>
    <div>
      <h3>TCEE y DCE</h3>
      {comparativa}
      <p class="nota">{num(per.get('app: en las dos oposiciones'))} personas en las dos oposiciones · {num(cue.get('cuentas de prueba'))} cuentas de prueba descontadas · {num(per.get('han entrado pero sin datos'))} entraron sin dejar datos.</p>
    </div>
  </div>
  <div class="dos">
    <div><h3>Personas que usan la app, foto a foto</h3>{serie_app}</div>
    <div><h3>Google Play</h3>{bloque_play}</div>
  </div>
  <div class="pie"><span>Red: scripts/estadisticas-red.py · Play, Analytics y GitHub: scripts/estadisticas-app.py</span><span>3 / 4</span></div>
</section>

<section class="hoja">
  <header><h2>La app, en detalle</h2><span class="sello">{e(periodo)}</span></header>
  <div class="dos">
    <div><h3>La red, por oposición</h3>{tabla_ops}</div>
    <div>
      <h3>Uso dentro de la app (Analytics)</h3>
      {bloque_an}
      <h3>Lo que falta para medir más</h3>
      {bloque_faltan}
    </div>
  </div>
  <h3>Prioridades de la app para el mes</h3>
  {lista_prioridades(va.get('prioridades'))}
  {('<h3>Para el próximo informe</h3><ul class="faltan">' + ''.join(f'<li>{e(x)}</li>' for x in proximo) + '</ul>') if proximo else ''}
  <p class="nota">Método: todas las cifras de la app son recuentos agregados de Firestore, Firebase Authentication, Google Play y Analytics de la app (esta última, solo de quien acepta enviar estadísticas desde la 1.18.0). No se consultan nombres, correos ni contenidos, y el informe no se publica ni se cede (fila «Estadísticas agregadas de la app» de la política de privacidad).</p>
  <div class="pie"><span>Informe generado con scripts/informe-web.py · guardado fuera del repositorio</span><span>4 / 4</span></div>
</section>
'''
    (carpeta / 'informe.html').write_text(doc, encoding='utf-8')
    print(carpeta / 'informe.html')


def main():
    if '--datos' in sys.argv:
        dias = int(sys.argv[sys.argv.index('--dias') + 1]) if '--dias' in sys.argv else 28
        datos(dias)
    elif '--render' in sys.argv:
        render(sys.argv[sys.argv.index('--render') + 1])
    else:
        sys.exit(__doc__)


if __name__ == '__main__':
    main()
