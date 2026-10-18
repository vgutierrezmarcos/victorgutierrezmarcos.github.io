#!/usr/bin/env python3
"""Novedades de la web a partir de novedades.json (la más reciente, primero):
- la lista bajo el aviso de la app en la portada (index.html), con las tres últimas;
- la lista completa de novedades.html, agrupada por meses;
- el RSS novedades.xml.
Para añadir una novedad, se pone arriba en novedades.json y se ejecuta:
    python3 scripts/novedades.py
Cada entrada: fecha (AAAA-MM-DD), seccion, texto y enlace (ruta desde la raíz).

Autor: Víctor Gutiérrez Marcos
"""
import html
import json
import os
import re
from datetime import date
from email.utils import format_datetime
from datetime import datetime, timezone

RAIZ = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
WEB = 'https://www.victorgutierrezmarcos.es'
MESES = ['enero', 'febrero', 'marzo', 'abril', 'mayo', 'junio', 'julio', 'agosto', 'septiembre', 'octubre', 'noviembre', 'diciembre']
MESES_CORTOS = ['ene.', 'feb.', 'mar.', 'abr.', 'may.', 'jun.', 'jul.', 'ago.', 'sept.', 'oct.', 'nov.', 'dic.']
EN_PORTADA = 3


def leer():
    with open(os.path.join(RAIZ, 'novedades.json'), encoding='utf-8') as f:
        datos = json.load(f)
    for d in datos:
        d['dia'] = date.fromisoformat(d['fecha'])
    return sorted(datos, key=lambda d: d['dia'], reverse=True)


def corta(d):
    return f'{d.day} {MESES_CORTOS[d.month - 1]}'


def larga(d):
    return f'{d.day} de {MESES[d.month - 1]} de {d.year}'


def item(n, prefijo=''):
    e = html.escape
    return (f'<li class="novedad"><a href="{e(prefijo + n["enlace"])}">'
            f'<time datetime="{n["fecha"]}">{corta(n["dia"])}</time>'
            f'<span class="novedad-seccion">{e(n["seccion"])}</span>'
            f'<span class="novedad-texto">{e(n["texto"])}</span></a></li>')


def sustituir(ruta, marca, contenido):
    with open(ruta, encoding='utf-8') as f:
        t = f.read()
    patron = re.compile(r'(<!-- novedades:%s:inicio -->).*?([ \t]*<!-- novedades:%s:fin -->)' % (marca, marca), re.S)
    if not patron.search(t):
        raise SystemExit(f'Falta la marca novedades:{marca} en {ruta}')
    t = patron.sub(lambda m: m.group(1) + '\n' + contenido + '\n' + m.group(2), t)
    with open(ruta, 'w', encoding='utf-8') as f:
        f.write(t)


def portada(datos):
    filas = '\n'.join('                ' + item(n) for n in datos[:EN_PORTADA])
    # Va dentro del bloque «Novedades» de la portada, debajo del aviso de la app
    # (la novedad principal).
    return f'''            <div class="novedades-franja">
                <p class="novedades-rotulo">Más novedades</p>
                <ul class="novedades-lista">
{filas}
                </ul>
                <a class="boton boton--texto novedades-todas" href="novedades.html">Todas las novedades</a>
            </div>'''


def pagina(datos):
    grupos, actual = [], None
    for n in datos:
        clave = (n['dia'].year, n['dia'].month)
        if clave != actual:
            grupos.append((clave, []))
            actual = clave
        grupos[-1][1].append(n)
    partes = []
    for (anio, mes), ns in grupos:
        filas = '\n'.join('                    ' + item(n) for n in ns)
        partes.append(f'''                <h2 class="novedades-mes">{MESES[mes - 1].capitalize()} de {anio}</h2>
                <ul class="novedades-lista novedades-lista--completa">
{filas}
                </ul>''')
    return '\n'.join(partes)


def rss(datos):
    e = html.escape
    items = []
    for n in datos[:30]:
        momento = datetime(n['dia'].year, n['dia'].month, n['dia'].day, 9, 0, tzinfo=timezone.utc)
        enlace = f'{WEB}/{n["enlace"]}'.replace('/index.html', '/')
        items.append(f'''    <item>
      <title>{e(n["seccion"])}: {e(n["texto"])}</title>
      <link>{e(enlace)}</link>
      <guid isPermaLink="false">{n["fecha"]}-{e(n["texto"])}</guid>
      <pubDate>{format_datetime(momento)}</pubDate>
      <description>{e(n["texto"])} ({larga(n["dia"])}).</description>
    </item>''')
    return f'''<?xml version="1.0" encoding="UTF-8"?>
<rss version="2.0" xmlns:atom="http://www.w3.org/2005/Atom">
  <channel>
    <title>Novedades · Víctor Gutiérrez Marcos</title>
    <link>{WEB}/novedades.html</link>
    <atom:link href="{WEB}/novedades.xml" rel="self" type="application/rss+xml"/>
    <description>Temario, test, app y blog de la oposición a Técnico Comercial y Economista del Estado: lo último que se ha añadido o actualizado.</description>
    <language>es</language>
{chr(10).join(items)}
  </channel>
</rss>
'''


def main():
    datos = leer()
    sustituir(os.path.join(RAIZ, 'index.html'), 'portada', portada(datos))
    sustituir(os.path.join(RAIZ, 'novedades.html'), 'lista', pagina(datos))
    with open(os.path.join(RAIZ, 'novedades.xml'), 'w', encoding='utf-8') as f:
        f.write(rss(datos))
    print(f'{len(datos)} novedades: portada, novedades.html y novedades.xml')


if __name__ == '__main__':
    main()
