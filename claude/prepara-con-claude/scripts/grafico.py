#!/usr/bin/env python3
"""
Estética de la oposición para los gráficos de matplotlib (skill «EconomIA»).

    import sys; sys.path.insert(0, 'scripts')
    from grafico import estilo, guardar, etiqueta
    p = estilo('tcee')            # o 'dce': fuentes, paleta y fondo; devuelve los colores
    fig, ax = plt.subplots(figsize=(7, 4.2))
    ax.plot(x, y, color=p['principal'], label='Demanda')
    guardar(fig, 'grafico.png', titulo='El efecto renta domina al de sustitución', fuente='Elaboración propia')

Reglas (references/graficos-y-formulas.md): capas en orden (barras → ejes y
umbrales → líneas → puntos → etiquetas), un color por magnitud en todo el
documento, etiquetas sin fondo blanco, leyenda con el fondo del gráfico, título
con el mensaje y fuente debajo. Autor: Víctor Gutiérrez Marcos.
"""
import os
import textwrap

import matplotlib
import matplotlib.font_manager as fm
import matplotlib.pyplot as plt

AQUI = os.path.dirname(os.path.abspath(__file__))
FUENTES = os.path.join(os.path.dirname(AQUI), 'assets', 'fuentes')

PALETAS = {
    'tcee': {
        'familia': 'TeX Gyre Pagella', 'principal': '#5F2987', 'secundario': '#4A1F6B', 'acento': '#B8860B',
        'fondo': '#E2EFD9', 'fondo_claro': '#EDF5E7', 'texto': '#2A2530', 'texto_suave': '#5E5866', 'borde': '#C8D8C0',
        # Series: morado, dorado, verde, azul grisáceo, granate (contrastan entre sí y con el fondo salvia)
        'series': ['#5F2987', '#B8860B', '#2E7D32', '#4A6B8A', '#8E2B4C', '#7A7480'],
    },
    'dce': {
        'familia': 'Latin Modern Roman', 'principal': '#7A1F4B', 'secundario': '#234A6B', 'acento': '#234A6B',
        'fondo': '#F7F4EC', 'fondo_claro': '#FBF9F4', 'texto': '#2B2A28', 'texto_suave': '#57534B', 'borde': '#E0D8C8',
        'series': ['#7A1F4B', '#234A6B', '#B8860B', '#2E7D32', '#9C3A68', '#6F6B62'],
    },
}


def estilo(oposicion='tcee'):
    """Fija las fuentes, los colores y el fondo de la oposición en matplotlib y devuelve la paleta."""
    p = PALETAS['dce' if str(oposicion).lower().startswith('dce') else 'tcee']
    if os.path.isdir(FUENTES):
        for f in os.listdir(FUENTES):
            if f.endswith('.otf'):
                try:
                    fm.fontManager.addfont(os.path.join(FUENTES, f))
                except Exception:
                    pass
    matplotlib.rcParams.update({
        'font.family': 'serif', 'font.serif': [p['familia'], 'Palatino Linotype', 'DejaVu Serif'],
        'font.size': 11, 'axes.titlesize': 13, 'axes.titleweight': 'bold', 'axes.labelsize': 11,
        'figure.facecolor': p['fondo'], 'axes.facecolor': p['fondo_claro'], 'savefig.facecolor': p['fondo'],
        'axes.edgecolor': p['texto_suave'], 'axes.labelcolor': p['texto'], 'text.color': p['texto'],
        'xtick.color': p['texto_suave'], 'ytick.color': p['texto_suave'],
        'axes.spines.top': False, 'axes.spines.right': False, 'axes.grid': True, 'grid.color': p['borde'], 'grid.linewidth': 0.6,
        'axes.prop_cycle': matplotlib.cycler(color=p['series']),
        'legend.frameon': False,  # la leyenda, con el fondo del gráfico
        'lines.linewidth': 2.0, 'axes.titlelocation': 'left', 'axes.titlepad': 10,
    })
    return p


def guardar(fig, ruta, titulo=None, fuente=None, ppp=200):
    """Pone el título (el mensaje) y la fuente, quita el fondo blanco de las etiquetas y guarda el PNG."""
    if titulo and fig.axes:
        # Los títulos largos se parten en líneas para que nunca se corten
        ancho = fig.get_size_inches()[0]
        fig.axes[0].set_title(textwrap.fill(titulo, max(30, int(ancho * 9.5))))
    for a in fig.axes:
        for t in a.texts:
            t.set_bbox(None)  # etiquetas sin fondo blanco
    if fuente:
        fig.text(0.01, 0.005, f'Fuente: {fuente}', fontsize=8, color=matplotlib.rcParams['xtick.color'], ha='left', va='bottom')
    fig.tight_layout(rect=(0, 0.03 if fuente else 0, 1, 1))
    fig.savefig(ruta, dpi=ppp)
    return ruta


def etiqueta(ax, x, y, texto, color=None, dx=4, dy=4):
    """Etiqueta pegada a un punto, sin caja, en el color de la serie."""
    return ax.annotate(texto, (x, y), xytext=(dx, dy), textcoords='offset points', color=color or matplotlib.rcParams['text.color'], fontsize=9)



# ---------------------------------------------------------------------------
# Gráficos de teoría como los de los temas revisados (tikz-tcee.tex del temario):
# fondo blanco, ejes negros con flecha y el 0 en el origen, curvas gruesas con su
# nombre pegado al final y en su color (nunca leyenda), puntos negros, guías grises
# discontinuas a los ejes, flecha roja para los desplazamientos, áreas pálidas,
# notas sin caja y letra Pagella (Latin Modern en DCE), fórmulas en $…$.
#
#   from grafico import teoria, ejes, curva, punto, proyeccion, flecha, area, nota, guardar_teoria
#   fig, ax = teoria('tcee')                       # o teoria('dce'); paneles: teoria('tcee', paneles=2)
#   ejes(ax, '$x_1$', '$x_2$', 6.2, 4.6)
#   curva(ax, [0, 5], [2.5, 0], 1, r'$\vec{p}^0$')        # 1 morado, 2 azul, 3 verde, 4 dorado, 'nueva' rojo
#   punto(ax, 3.6, 0.7, r'$\vec{x}^0$')
#   proyeccion(ax, 3.6, 0.7, '$x_1^0$', ejes_='x')       # guía solo al eje x
#   guardar_teoria(fig, 'grafico.png')
# ---------------------------------------------------------------------------
COLORES_TEORIA = {
    'tcee': {1: '#5F2987', 2: '#1F5F99', 3: '#3C7D3A', 4: '#B8860B', 'nueva': '#B22222', 'guia': '#767171',
             'area': '#5F2987', 'area2': '#B8860B', 'familia': 'TeX Gyre Pagella'},
    'dce': {1: '#7A1F4B', 2: '#234A6B', 3: '#3C7D3A', 4: '#B8860B', 'nueva': '#B22222', 'guia': '#767171',
            'area': '#7A1F4B', 'area2': '#B8860B', 'familia': 'Latin Modern Roman'},
}

# Gráficos de datos de coyuntura (paleta «dictamen» del temario): un concepto, un color en todos.
COLORES_DATOS = {
    'pib': '#5F2987', 'consumo_privado': '#C76A1F', 'consumo_publico': '#F5C690', 'fbcf': '#2A6B3C',
    'existencias': '#B4B4B4', 'demanda_externa': '#6AA6DA', 'zona_euro': '#17406D', 'espana': '#C8382E',
    'otro': '#8A8A8A', 'otro_claro': '#B5B5B5', 'otro_mas_claro': '#DADADA', 'inflacion': '#1A1A1A',
    'energia': '#D55E00', 'alimentos': '#F2D45C', 'bienes_industriales': '#7FB2E0', 'servicios': '#1F4E89',
    'empleo': '#1B7F6B', 'horas': '#86CBB8', 'actividad': '#0F5247', 'paro': '#A23B2A', 'productividad': '#B8860B',
    'renta': '#4A5A6A', 'ahorro': '#1A1A1A', 'tipo_deposito': '#17406D', 'tipo_opf': '#4F86C6', 'tipo_fmc': '#9EC5EA',
    'prestamos_bancos': '#D9A520', 'resto_activo': '#CFCFCF', 'adelantada': '#D55E00', 'retrasada': '#6AA6DA',
    'referencia': '#767171',
    # Sector exterior y banco central de una economía emergente (dictámenes con crisis de balanza de pagos)
    'clu': '#8C2D5A', 'inversion_directa': '#2A6B3C', 'cartera': '#6AA6DA', 'otra_inversion': '#B4B4B4',
    'fmi': '#C8382E', 'reservas': '#17406D', 'titulos_publicos': '#D9A520', 'adelantos_estado': '#A23B2A',
}

_TEORIA = {'c': COLORES_TEORIA['tcee']}
GROSOR = 2.0       # «very thick» de TikZ a este tamaño
TAM = 12           # letra de las etiquetas (\small)


def teoria(oposicion='tcee', paneles=1, ancho=4.4, alto=3.4):
    """Lienzo de un gráfico de teoría (uno o varios paneles): fondo blanco, sin rejilla ni marco."""
    clave = 'dce' if str(oposicion).lower().startswith('dce') else 'tcee'
    _TEORIA['c'] = c = COLORES_TEORIA[clave]
    if os.path.isdir(FUENTES):
        for f in os.listdir(FUENTES):
            if f.endswith('.otf'):
                try:
                    fm.fontManager.addfont(os.path.join(FUENTES, f))
                except Exception:
                    pass
    matplotlib.rcParams.update({
        'font.family': 'serif', 'font.serif': [c['familia'], 'Palatino Linotype', 'Palatino', 'DejaVu Serif'],
        'mathtext.fontset': 'custom', 'mathtext.rm': c['familia'], 'mathtext.it': c['familia'] + ':italic',
        'mathtext.bf': c['familia'] + ':bold', 'font.size': TAM, 'text.color': 'black',
        'figure.facecolor': 'white', 'axes.facecolor': 'white', 'savefig.facecolor': 'white',
        'axes.grid': False, 'lines.solid_capstyle': 'round', 'lines.solid_joinstyle': 'round',
    })
    fig, axs = plt.subplots(1, paneles, figsize=(ancho * paneles, alto))
    for ax in (axs if paneles > 1 else [axs]):
        ax.set_axis_off()
    return fig, axs


def ejes(ax, x, y, largo, alto):
    """\\ejes{x}{y}{largo}{alto}: ejes negros con flecha, nombre en la punta y el 0 en el origen."""
    flechas = dict(arrowstyle='-|>,head_length=0.5,head_width=0.2', color='black', lw=1.3, shrinkA=0, shrinkB=0)
    ax.annotate('', (largo, 0), (0, 0), arrowprops=flechas)
    ax.annotate('', (0, alto), (0, 0), arrowprops=flechas)
    ax.annotate(x, (largo, 0), xytext=(-6, -8), textcoords='offset points', ha='right', va='top')
    ax.annotate(y, (0, alto), xytext=(-6, 0), textcoords='offset points', ha='right', va='center')
    ax.annotate('$0$', (0, 0), xytext=(-5, -5), textcoords='offset points', ha='right', va='top')
    ax.set_xlim(-0.06 * largo, largo * 1.04)
    ax.set_ylim(-0.08 * alto, alto * 1.03)


def curva(ax, xs, ys, n=1, nombre=None, desplazada=False, lado='arriba', grosor=None):
    """curva1…curva4 y curvanueva: línea gruesa con su nombre al final, en su color (desplazada: discontinua)."""
    color = _TEORIA['c'][n]
    ax.plot(xs, ys, color=color, lw=grosor or GROSOR, ls=(0, (5, 3)) if desplazada else '-', zorder=3)
    if nombre:
        dx, dy, ha, va = {'arriba': (3, 3, 'left', 'bottom'), 'abajo': (3, -3, 'left', 'top'),
                          'derecha': (5, 0, 'left', 'center'), 'izquierda': (-5, 0, 'right', 'center')}[lado]
        ax.annotate(nombre, (xs[-1], ys[-1]), xytext=(dx, dy), textcoords='offset points', color=color, ha=ha, va=va)
    return color


def punto(ax, x, y, nombre=None, lado='arriba-derecha'):
    """\\node[punto,label=…]: punto negro con su etiqueta sin caja."""
    ax.plot([x], [y], 'o', color='black', ms=5, zorder=5)
    if nombre:
        dx = -5 if 'izquierda' in lado else 5
        dy = -5 if 'abajo' in lado else 5
        ax.annotate(nombre, (x, y), xytext=(dx, dy), textcoords='offset points',
                    ha='right' if dx < 0 else 'left', va='top' if dy < 0 else 'bottom', zorder=6)


def proyeccion(ax, x, y, etiqueta_x=None, etiqueta_y=None, ejes_='xy'):
    """\\proyeccion: guías grises discontinuas del punto a los ejes ('xy', 'x' o 'y'), con sus valores en gris."""
    g = _TEORIA['c']['guia']
    if 'x' in ejes_:
        ax.plot([x, x], [0, y], color=g, lw=0.9, ls=(0, (4, 3)), zorder=2)
    if 'y' in ejes_:
        ax.plot([0, x], [y, y], color=g, lw=0.9, ls=(0, (4, 3)), zorder=2)
    if etiqueta_x:
        ax.annotate(etiqueta_x, (x, 0), xytext=(0, -5), textcoords='offset points', ha='center', va='top', color=g)
    if etiqueta_y:
        ax.annotate(etiqueta_y, (0, y), xytext=(-5, 0), textcoords='offset points', ha='right', va='center', color=g)


def flecha(ax, desde, hasta):
    """flecha: el desplazamiento o el movimiento, en rojo."""
    ax.annotate('', hasta, desde, arrowprops=dict(arrowstyle='-|>,head_length=0.45,head_width=0.18',
                                                  color=_TEORIA['c']['nueva'], lw=1.6, shrinkA=0, shrinkB=0), zorder=4)
    # (la punta, más pequeña que la de los ejes, como Stealth de 2,2 mm)


def area(ax, xs, ys, dorada=False):
    """area / area2: región pálida (excedentes, conjuntos presupuestarios, pérdidas)."""
    c = _TEORIA['c']['area2' if dorada else 'area']
    ax.fill(xs, ys, color=c, alpha=0.22 if dorada else 0.18, lw=0, zorder=1)


def nota(ax, x, y, texto, pequena=False, centro=False):
    """Comentario dentro del gráfico, sin caja; cada línea (\\n) va aparte para que las fórmulas no se descoloquen."""
    lineas = texto.split('\n')
    tam = TAM - (1.5 if pequena else 0)
    for i, linea in enumerate(lineas):
        desplazamiento = ((len(lineas) - 1) / 2 - i) * tam * 1.35
        ax.annotate(linea, (x, y), xytext=(0, desplazamiento), textcoords='offset points',
                    ha='center' if centro else 'left', va='center', fontsize=tam)


def guardar_teoria(fig, ruta, ppp=200):
    """Guarda el gráfico de teoría en PNG (fondo blanco, sin márgenes sobrantes)."""
    fig.tight_layout()
    fig.savefig(ruta, dpi=ppp, bbox_inches='tight', pad_inches=0.08)
    return ruta

if __name__ == '__main__':
    import numpy as np
    p = estilo('tcee')
    fig, ax = plt.subplots(figsize=(7, 4.2))
    x = np.linspace(0.5, 5, 50)
    ax.plot(x, 6 / x, label='Demanda')
    ax.plot(x, 1.2 * x, label='Oferta')
    ax.plot([2.236], [2.68], 'o', color=p['acento'])
    etiqueta(ax, 2.236, 2.68, 'Equilibrio', p['acento'])
    ax.set_xlabel('Cantidad'); ax.set_ylabel('Precio'); ax.legend()
    print(guardar(fig, 'grafico-prueba.png', 'Ejemplo: el equilibrio donde se cruzan oferta y demanda', 'Elaboración propia'))
