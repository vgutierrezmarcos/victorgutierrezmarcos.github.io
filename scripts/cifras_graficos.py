"""Gráficos SVG para «La oposición a TCEE en cifras» (los usa cifras-oposicion.py).

SVG en línea, sin JavaScript, con los colores del sistema de diseño de la web
(variables CSS, así que funcionan también en el tema oscuro). Cada gráfico
lleva <title> y <desc>, y se acompaña en la página de una tabla con los
mismos datos, que es lo que leen los buscadores.
"""
import html

ANCHO, ALTO = 760, 340
MARGEN = {'izq': 48, 'der': 48, 'arr': 18, 'aba': 58}
COLORES = ['var(--color-primary)', 'var(--color-accent-gold)', 'var(--color-primary-light)', 'var(--color-text-light)', 'var(--color-border-strong)']
ESTILO = 'font-family: var(--font-ui); font-size: 12px; fill: var(--color-text-muted)'


def _esc(s):
    return html.escape(str(s), quote=True)


def _fmt(v, decimales=0):
    if v is None:
        return ''
    s = f'{v:,.{decimales}f}'.replace(',', ' ').replace('.', ',')
    return s


def _escala(valores, y_max=None):
    m = max([v for v in valores if v is not None] or [1])
    if y_max:
        return y_max
    # Un máximo «redondo» por encima del dato mayor
    for paso in (1, 2, 5, 10, 20, 25, 50, 100, 200, 500, 1000, 2000):
        if m <= paso * 5:
            return paso * (int(m / paso) + 1)
    return m * 1.1


def grafico(categorias, barras=(), lineas=(), titulo='', descripcion='', y_max=None, y2_max=None, unidad='', unidad2='', ancho=ANCHO, alto=ALTO, etiquetas=True, apiladas=False):
    """Barras agrupadas (eje izquierdo) y líneas (eje derecho si `unidad2`).

    categorias: etiquetas del eje x (años). barras/lineas: [(nombre, valores, color?)].
    Los valores None no se dibujan (dato no disponible)."""
    n = len(categorias)
    izq, der, arr, aba = MARGEN['izq'], (64 if unidad2 else MARGEN['der']), MARGEN['arr'], MARGEN['aba']
    w = ancho - izq - der
    h = alto - arr - aba
    todas_barras = [v for _, vals, *_ in barras for v in vals]
    if apiladas and barras:
        todas_barras = [sum(vals[i] or 0 for _, vals, *_ in barras) for i in range(n)]
    maximo = _escala(todas_barras or [0], y_max) if barras else None
    todas_lineas = [v for _, vals, *_ in lineas for v in vals]
    eje2 = bool(lineas) and bool(unidad2)  # eje derecho propio solo si las líneas van en otra unidad
    maximo2 = _escala(todas_lineas or [0], y2_max) if lineas else None
    if lineas and not eje2:
        maximo = _escala((todas_barras or []) + (todas_lineas or []), y_max)
        maximo2 = maximo
    paso_x = w / max(n, 1)
    out = [f'<svg class="grafico" viewBox="0 0 {ancho} {alto}" role="img" aria-labelledby="{{id}}-t {{id}}-d" preserveAspectRatio="xMidYMid meet">',
           f'<title id="{{id}}-t">{_esc(titulo)}</title><desc id="{{id}}-d">{_esc(descripcion)}</desc>',
           f'<g style="{ESTILO}">']
    # Rejilla y eje izquierdo
    ref = maximo if maximo else maximo2
    for i in range(5):
        y = arr + h - h * i / 4
        out.append(f'<line x1="{izq}" y1="{y:.1f}" x2="{izq + w}" y2="{y:.1f}" stroke="var(--color-border-light)" stroke-width="1"/>')
        out.append(f'<text x="{izq - 6}" y="{y + 4:.1f}" text-anchor="end">{_fmt(ref * i / 4)}{_esc(unidad) if i == 4 else ""}</text>')
        if eje2 and maximo2:
            out.append(f'<text x="{izq + w + 6}" y="{y + 4:.1f}" text-anchor="start" fill="var(--color-accent-gold)">{_fmt(maximo2 * i / 4)}{_esc(unidad2) if i == 4 else ""}</text>')
    # Eje x
    salto = 1 if n <= 14 else 2 if n <= 40 else 5 if n <= 70 else 10
    numericas = all(str(c).isdigit() for c in categorias)
    consecutivas = numericas and all(int(categorias[i + 1]) == int(categorias[i]) + 1 for i in range(n - 1))
    for i, c in enumerate(categorias):
        x = izq + paso_x * (i + 0.5)
        if n <= 14 or (int(c) % salto == 0 if consecutivas else i % salto == 0):
            out.append(f'<text x="{x:.1f}" y="{arr + h + 16}" text-anchor="middle">{_esc(c)}</text>')
    # Barras
    nb = len(barras)
    if nb and apiladas:
        ancho_barra = paso_x * 0.72
        base = [0.0] * n
        for j, (nombre, valores, *resto) in enumerate(barras):
            color = resto[0] if resto else COLORES[j % len(COLORES)]
            for i, v in enumerate(valores):
                if not v:
                    continue
                x = izq + paso_x * (i + 0.5) - ancho_barra / 2
                hb = h * v / maximo
                y = arr + h - h * base[i] / maximo - hb
                out.append(f'<rect x="{x:.1f}" y="{y:.1f}" width="{ancho_barra - 2:.1f}" height="{hb:.1f}" fill="{color}"><title>{_esc(nombre)} {_esc(categorias[i])}: {_fmt(v)}{_esc(unidad)}</title></rect>')
                if etiquetas and n <= 20 and hb > 12:
                    out.append(f'<text x="{x + (ancho_barra - 2) / 2:.1f}" y="{y + hb / 2 + 4:.1f}" text-anchor="middle" font-size="10.5" fill="var(--color-bg-cream)">{_fmt(v)}</text>')
                base[i] += v
    elif nb:
        ancho_grupo = paso_x * 0.72
        ancho_barra = ancho_grupo / nb
        for j, (nombre, valores, *resto) in enumerate(barras):
            color = resto[0] if resto else COLORES[j % len(COLORES)]
            for i, v in enumerate(valores):
                if v is None:
                    continue
                x = izq + paso_x * (i + 0.5) - ancho_grupo / 2 + j * ancho_barra
                hb = h * v / maximo
                out.append(f'<rect x="{x:.1f}" y="{arr + h - hb:.1f}" width="{ancho_barra - 2:.1f}" height="{hb:.1f}" fill="{color}" rx="1.5"><title>{_esc(nombre)} {_esc(categorias[i])}: {_fmt(v)}{_esc(unidad)}</title></rect>')
                if etiquetas and nb <= 2 and n <= 20:
                    out.append(f'<text x="{x + (ancho_barra - 2) / 2:.1f}" y="{arr + h - hb - 4:.1f}" text-anchor="middle" font-size="10.5">{_fmt(v)}</text>')
    # Líneas
    for j, (nombre, valores, *resto) in enumerate(lineas):
        color = resto[0] if resto else COLORES[(j + nb) % len(COLORES)]
        puntos = [(izq + paso_x * (i + 0.5), arr + h - h * v / maximo2) for i, v in enumerate(valores) if v is not None]
        if len(puntos) > 1:
            d = 'M ' + ' L '.join(f'{x:.1f} {y:.1f}' for x, y in puntos)
            out.append(f'<path d="{d}" fill="none" stroke="{color}" stroke-width="2.5" stroke-linejoin="round"/>')
        for (x, y), (i, v) in zip(puntos, [(i, v) for i, v in enumerate(valores) if v is not None]):
            out.append(f'<circle cx="{x:.1f}" cy="{y:.1f}" r="3.5" fill="{color}" stroke="var(--color-bg-cream)" stroke-width="1.5"><title>{_esc(nombre)} {_esc(categorias[i])}: {_fmt(v, 1 if isinstance(v, float) and v != int(v) else 0)}{_esc(unidad2 or unidad)}</title></circle>')
            if etiquetas and not barras and n <= 20:
                out.append(f'<text x="{x:.1f}" y="{y - 8:.1f}" text-anchor="middle" font-size="10.5">{_fmt(v, 1 if isinstance(v, float) and v != int(v) else 0)}</text>')
    # Leyenda (en dos filas si no cabe)
    lx = izq
    ly = alto - 8
    series = list(barras) + list(lineas)
    if sum(24 + 7 * len(n[0]) + 18 for n in series) > w:
        ly = alto - 22
    for j, (nombre, *_) in enumerate(series):
        es_linea = j >= nb
        color = (list(barras) + list(lineas))[j][2] if len((list(barras) + list(lineas))[j]) > 2 else COLORES[j % len(COLORES)]
        if es_linea:
            out.append(f'<line x1="{lx}" y1="{ly - 4}" x2="{lx + 18}" y2="{ly - 4}" stroke="{color}" stroke-width="2.5"/><circle cx="{lx + 9}" cy="{ly - 4}" r="3" fill="{color}"/>')
        else:
            out.append(f'<rect x="{lx}" y="{ly - 10}" width="18" height="11" fill="{color}" rx="1.5"/>')
        out.append(f'<text x="{lx + 24}" y="{ly}">{_esc(nombre)}</text>')
        lx += 24 + 7 * len(nombre) + 18
        if lx > izq + w - 120 and j < len(series) - 1:
            lx, ly = izq, ly + 14
    out.append('</g></svg>')
    return '\n'.join(out)


def barras_horizontales(filas, titulo='', descripcion='', unidad='', ancho=ANCHO, formato=0):
    """filas: [(etiqueta, valor, valor_secundario_o_None, texto_derecha)]."""
    alto_fila = 26
    alto = 16 + alto_fila * len(filas) + 8
    izq = 110
    w = ancho - izq - 120
    maximo = _escala([f[1] for f in filas] + [f[2] or 0 for f in filas])
    out = [f'<svg class="grafico" viewBox="0 0 {ancho} {alto}" role="img" aria-labelledby="{{id}}-t {{id}}-d" preserveAspectRatio="xMidYMid meet">',
           f'<title id="{{id}}-t">{_esc(titulo)}</title><desc id="{{id}}-d">{_esc(descripcion)}</desc>', f'<g style="{ESTILO}">']
    for i, (et, v, v2, texto) in enumerate(filas):
        y = 12 + alto_fila * i
        out.append(f'<text x="{izq - 8}" y="{y + 15}" text-anchor="end" fill="var(--color-text)">{_esc(et)}</text>')
        out.append(f'<rect x="{izq}" y="{y + 3}" width="{w * v / maximo:.1f}" height="18" fill="var(--color-border-light)" rx="2"><title>{_esc(et)}: {_fmt(v, formato)}{_esc(unidad)}</title></rect>')
        if v2 is not None:
            out.append(f'<rect x="{izq}" y="{y + 3}" width="{w * v2 / maximo:.1f}" height="18" fill="var(--color-primary)" rx="2"><title>{_esc(et)}: {_fmt(v2, formato)}</title></rect>')
        out.append(f'<text x="{izq + w * max(v, v2 or 0) / maximo + 8:.1f}" y="{y + 15}">{_esc(texto)}</text>')
    out.append('</g></svg>')
    return '\n'.join(out)


def figura(id_, svg, caption, tabla_html=''):
    """Envuelve un gráfico con su pie y la tabla de datos."""
    svg = svg.replace('{id}', id_)
    return (f'<figure class="figura-cifras" id="{id_}">\n{svg}\n<figcaption>{caption}</figcaption>\n'
            + (f'<details class="datos-figura"><summary>Ver los datos</summary>{tabla_html}</details>\n' if tabla_html else '') + '</figure>')


def tabla(cabeceras, filas, pie=None):
    out = ['<div class="tabla-scroll"><table class="tabla-guia">', '<thead><tr>' + ''.join(f'<th scope="col">{_esc(c)}</th>' for c in cabeceras) + '</tr></thead>', '<tbody>']
    for f in filas:
        out.append('<tr>' + ''.join(('<th scope="row">' if i == 0 else '<td>') + (_esc(c) if c is not None else '—') + ('</th>' if i == 0 else '</td>') for i, c in enumerate(f)) + '</tr>')
    out.append('</tbody>')
    if pie:
        out.append('<tfoot><tr>' + ''.join(('<th scope="row">' if i == 0 else '<td>') + _esc(c) + ('</th>' if i == 0 else '</td>') for i, c in enumerate(pie)) + '</tr></tfoot>')
    out.append('</table></div>')
    return '\n'.join(out)
