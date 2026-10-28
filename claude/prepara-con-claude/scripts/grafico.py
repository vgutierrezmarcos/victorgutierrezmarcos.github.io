#!/usr/bin/env python3
"""
Estética de la oposición para los gráficos de matplotlib (skill «Prepara con Claude»).

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
        fig.axes[0].set_title(titulo)
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
