#!/usr/bin/env python3
"""Genera los ficheros que la app necesita de la web de DCE (manuelcabadogarcia.es).

- Los títulos de los temas salen del programa oficial (anexo I de la
  convocatoria, BOE-A-2025-26896): primer, tercer y cuarto ejercicio.
- Qué temas están publicados, y su enlace, sale del «Índice de temas» de la web
  de Manuel (indice-temas.html, tercer ejercicio). Los demás quedan como «en
  preparación».

Escribe en app/para-manuel/oposicion/ (cambiar con --destino):
    temario/temario.json   ejercicios, partes y temas (mismo formato que el de TCEE)
    app-config.json        contacto y avisos de DCE
    enlaces.json           enlaces útiles (vacío de momento)
Manuel los sube a la carpeta /oposicion/ de su web. Hay que repetirlo cada vez
que publique temas nuevos (o que su construir_web.py lo haga solo).

Uso, desde la raíz del repositorio:
    python3 scripts/generar-temario-dce.py
"""
import argparse
import html
import json
import re
import urllib.request
from pathlib import Path

WEB = 'https://manuelcabadogarcia.es'
BOE = 'https://www.boe.es/diario_boe/txt.php?id=BOE-A-2025-26896'
RAIZ = Path(__file__).resolve().parent.parent

EJERCICIOS = {
    1: ('primer-ejercicio', 'Primer ejercicio', 'Economía española, economía pública, políticas comunitarias e instituciones multilaterales (escrito)'),
    3: ('tercer-ejercicio', 'Tercer ejercicio', 'Microeconomía, economía del sector público, macroeconomía y economía internacional (oral)'),
    4: ('cuarto-ejercicio', 'Cuarto ejercicio', 'Técnicas comerciales, marketing internacional y organización del Estado (escrito)'),
}


def descargar(url: str) -> str:
    peticion = urllib.request.Request(url, headers={'User-Agent': 'generar-temario-dce'})
    with urllib.request.urlopen(peticion, timeout=30) as r:
        return r.read().decode('utf-8', errors='replace')


def texto_plano(h: str) -> list[str]:
    t = re.sub(r'<script.*?</script>|<style.*?</style>', '', h, flags=re.S)
    t = html.unescape(re.sub(r'<[^>]+>', '\n', t))
    return [l.strip() for l in t.split('\n') if l.strip()]


def programa_boe() -> dict[int, list[dict]]:
    """{ejercicio: [{letra, nombre, temas: [(n, título)]}]} del anexo I."""
    lineas = texto_plano(descargar(BOE))
    inicio = next(i for i, l in enumerate(lineas) if l == 'ANEXO I')
    fin = next(i for i, l in enumerate(lineas) if l == 'ANEXO II')
    ordinales = {'Primer ejercicio': 1, 'Segundo ejercicio': 2, 'Tercer ejercicio': 3, 'Cuarto ejercicio': 4}
    programa: dict[int, list[dict]] = {}
    ejercicio = None
    for l in lineas[inicio + 1:fin]:
        if l in ordinales:
            ejercicio = ordinales[l]
            programa[ejercicio] = []
        elif m := re.match(r'Parte ([A-Z])\)\s*(.+)', l):
            programa[ejercicio].append({'letra': m.group(1), 'nombre': m.group(2).strip(), 'temas': []})
        elif m := re.match(r'Tema (\d+)\.\s*(.+)', l):
            programa[ejercicio][-1]['temas'].append((int(m.group(1)), m.group(2).strip()))
        elif ejercicio and programa[ejercicio] and programa[ejercicio][-1]['temas']:
            # Título partido en varias líneas.
            n, t = programa[ejercicio][-1]['temas'][-1]
            programa[ejercicio][-1]['temas'][-1] = (n, f'{t} {l}')
    return programa


def publicados_web() -> dict[str, str]:
    """{'3.A.1': url} de los temas que ya están en la web de Manuel."""
    indice = descargar(f'{WEB}/indice-temas.html')
    enlaces = {}
    for numero, href in re.findall(r'<span class="tema-numero">([A-Z]\d+)</span><a class="tema-titulo" href="([^"]+)"', indice):
        enlaces[f'3.{numero[0]}.{int(numero[1:])}'] = f'{WEB}/{href.lstrip("./")}'
    return enlaces


def temario() -> dict:
    programa = programa_boe()
    web = publicados_web()
    ejercicios = []
    for n, (slug, nombre, descripcion) in EJERCICIOS.items():
        partes = []
        for p in programa.get(n, []):
            temas = []
            for num, titulo in p['temas']:
                codigo = f'{n}.{p["letra"]}.{num}'
                url = web.get(codigo)
                temas.append({'codigo': codigo, 'titulo': titulo, 'disponible': url is not None, 'temarioAnterior': False, 'url': url})
            partes.append({'letra': p['letra'], 'nombre': p['nombre'], 'temas': temas})
        ejercicios.append({
            'id': n,
            'slug': slug,
            'nombre': nombre,
            'descripcion': descripcion,
            'urlPagina': f'{WEB}/temario.html' if n == 3 else '',
            'partes': partes,
            'recursos': [],
        })
    return {'version': 1, 'ejercicios': ejercicios, 'organizacion': []}


def app_config() -> dict:
    return {
        'version': 1,
        'contacto': {'linkedin': 'https://www.linkedin.com/in/manuel-cabado-garc%C3%ADa-340148145/'},
        'avisos': [],
    }


def main():
    a = argparse.ArgumentParser()
    a.add_argument('--destino', default=str(RAIZ / 'app' / 'para-manuel' / 'oposicion'))
    destino = Path(a.parse_args().destino)
    (destino / 'temario').mkdir(parents=True, exist_ok=True)
    t = temario()
    (destino / 'temario' / 'temario.json').write_text(json.dumps(t, ensure_ascii=False, indent=1), encoding='utf-8')
    (destino / 'app-config.json').write_text(json.dumps(app_config(), ensure_ascii=False, indent=1), encoding='utf-8')
    (destino / 'enlaces.json').write_text('[]\n', encoding='utf-8')
    for e in t['ejercicios']:
        print(e['nombre'], ' · '.join(f"{p['letra']}: {sum(x['disponible'] for x in p['temas'])}/{len(p['temas'])}" for p in e['partes']))
    print(f'Escrito en {destino}')


if __name__ == '__main__':
    main()
