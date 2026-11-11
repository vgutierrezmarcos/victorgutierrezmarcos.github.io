#!/usr/bin/env python3
"""
Figuras de las preguntas del banco de test (no oficiales), con la paleta del temario
(morado, dorado, verde) sobre blanco, como las figuras de las preguntas oficiales.
Acompañan al enunciado: no llevan nada que delate la respuesta.

    python3 banco-test/figuras.py        # escribe banco-test/img/<id>.webp (doble densidad)

Para añadir una: una función fig_<id>() que devuelva (figura, ancho en píxeles CSS) y la
entrada «imagenes» en la pregunta: {"src": "banco:<id>.webp", "alt": "…", "ancho": N}.

Autor: Víctor Gutiérrez Marcos
"""
import io
import os

import matplotlib
matplotlib.use('Agg')
import matplotlib.font_manager as fm
import matplotlib.pyplot as plt
import numpy as np
from PIL import Image

AQUI = os.path.dirname(os.path.abspath(__file__))
FUENTES = os.path.join(os.path.dirname(AQUI) + '/../victorgutierrezmarcos.github.io/claude/prepara-con-claude/assets/fuentes')
MORADO, DORADO, VERDE, AZUL, GRIS, TEXTO = '#5F2987', '#B8860B', '#2E7D32', '#4A6B8A', '#8A8490', '#2A2530'

if os.path.isdir(FUENTES):
    for f in os.listdir(FUENTES):
        if f.endswith('.otf'):
            fm.fontManager.addfont(os.path.join(FUENTES, f))
matplotlib.rcParams.update({
    'font.family': 'serif', 'font.serif': ['TeX Gyre Pagella', 'Palatino Linotype', 'DejaVu Serif'], 'mathtext.fontset': 'cm',
    'font.size': 12, 'figure.facecolor': 'white', 'axes.facecolor': 'white', 'savefig.facecolor': 'white',
    'axes.edgecolor': TEXTO, 'axes.labelcolor': TEXTO, 'text.color': TEXTO, 'xtick.color': TEXTO, 'ytick.color': TEXTO,
    'axes.spines.top': False, 'axes.spines.right': False, 'axes.grid': False, 'axes.linewidth': 1.1,
})


def ejes(ax, x, y, xmax, ymax):
    ax.set_xlim(0, xmax)
    ax.set_ylim(0, ymax)
    ax.set_xlabel(x, loc='right')
    ax.set_ylabel(y, loc='top', rotation=0)


def fig_310811():
    """Descomposición de Hicks: A, B y C sin coordenadas (son la respuesta)."""
    fig, ax = plt.subplots(figsize=(6.2, 5.2))
    ejes(ax, '$x_1$', '$x_2$', 135, 255)
    x = np.linspace(8, 135, 400)
    ax.plot(x, 3600 / x, color=GRIS, lw=1.2)
    ax.plot(x, 900 / x, color=GRIS, lw=1.2)
    ax.plot([0, 120], [120, 0], color=MORADO, lw=2)
    ax.plot([0, 30], [120, 0], color=DORADO, lw=2)
    ax.plot([0, 60], [240, 0], color=DORADO, lw=1.6, ls='--')
    for (px, py), n in (((60, 60), 'A'), ((30, 120), 'B'), ((15, 60), 'C')):
        ax.plot(px, py, 'o', color=TEXTO, ms=6)
        ax.annotate(n, (px, py), xytext=(7, 6), textcoords='offset points', fontsize=13)
    ax.text(121, 34, '$U_0$', color=GRIS)
    ax.text(121, 10, '$U_1$', color=GRIS)
    ax.text(96, 36, 'inicial', color=MORADO, ha='left')
    ax.text(8, 22, 'final', color=DORADO, ha='center')
    ax.text(36, 170, 'compensada', color=DORADO, ha='left')
    ax.set_xticks([30, 60, 120])
    ax.set_yticks([120, 240])
    return fig, 560


def fig_310816():
    """Dos rectas de balance y las dos cestas elegidas."""
    fig, ax = plt.subplots(figsize=(5.6, 5.2))
    ejes(ax, '$x_1$', '$x_2$', 8, 8)
    ax.fill([0, 3.5, 0], [0, 0, 7], color=MORADO, alpha=0.10, lw=0)
    ax.fill([0, 7, 0], [0, 0, 3.5], color=DORADO, alpha=0.14, lw=0)
    ax.plot([0, 3.5], [7, 0], color=MORADO, lw=2)
    ax.plot([0, 7], [3.5, 0], color=DORADO, lw=2)
    ax.plot(3, 1, 'o', color=MORADO, ms=7)
    ax.plot(1, 3, 'o', color=DORADO, ms=7)
    ax.annotate(r'$\vec{x}^{\,0}=(3,1)$', (3, 1), xytext=(14, 2), textcoords='offset points', color=MORADO)
    ax.annotate(r'$\vec{x}^{\,1}=(1,3)$', (1, 3), xytext=(10, 14), textcoords='offset points', color=DORADO)
    ax.text(0.45, 6.6, '$RB_0$: precios $(2,1)$', color=MORADO)
    ax.text(4.6, 1.5, '$RB_1$: precios $(1,2)$', color=DORADO)
    ax.set_xticks([1, 3, 3.5, 7])
    ax.set_xticklabels(['1', '3', '3,5', '7'])
    ax.set_yticks([1, 3, 3.5, 7])
    ax.set_yticklabels(['1', '3', '3,5', '7'])
    return fig, 520


def fig_310817():
    """Compensación de Slutsky: la recta nueva pasa por la cesta inicial; las cuatro cestas de las opciones, sin colorear."""
    fig, ax = plt.subplots(figsize=(6.4, 4.8))
    ejes(ax, '$x_1$', '$x_2$', 33, 23)
    ax.plot([0, 20], [20, 0], color=MORADO, lw=2)
    ax.plot([0, 30], [15, 0], color=DORADO, lw=2)
    for (px, py), n, d in (((10, 10), 'a', (8, 6)), ((14, 8), 'b', (6, 7)), ((6, 12), 'c', (6, 7)), ((20, 5), 'd', (6, 7))):
        ax.plot(px, py, 'o', color=TEXTO, ms=6)
        ax.annotate(n + ')', (px, py), xytext=d, textcoords='offset points', fontsize=13)
    ax.text(1.0, 20.6, '$RB_0$: precios $(2,2)$, renta 40', color=MORADO)
    ax.text(17.5, 9.0, '$RB_1$: precios $(1,2)$, renta 30', color=DORADO)
    ax.set_xticks([10, 20, 30])
    ax.set_yticks([10, 15, 20])
    return fig, 580


def fig_310919():
    """Demanda x1 = 1/p1^2 entre los dos precios."""
    fig, ax = plt.subplots(figsize=(6.2, 4.6))
    ejes(ax, '$x_1$', '$p_1$', 5.2, 1.45)
    p = np.linspace(0.44, 1.4, 300)
    ax.plot(1 / p**2, p, color=MORADO, lw=2.2)
    ax.plot([0, 1], [1, 1], color=GRIS, lw=1, ls='--')
    ax.plot([0, 4], [0.5, 0.5], color=GRIS, lw=1, ls='--')
    ax.plot([1, 1], [0, 1], color=GRIS, lw=1, ls=':')
    ax.plot([4, 4], [0, 0.5], color=GRIS, lw=1, ls=':')
    ax.plot([1, 4], [1, 0.5], 'o', color=TEXTO, ms=6)
    ax.text(1.65, 0.86, '$x_1=1/p_1^{2}$', color=MORADO)
    ax.set_xticks([1, 4])
    ax.set_yticks([0.5, 1])
    ax.set_yticklabels(['0,5', '1'])
    return fig, 560


def main():
    os.makedirs(os.path.join(AQUI, 'img'), exist_ok=True)
    for nombre, f in sorted(globals().items()):
        if not nombre.startswith('fig_'):
            continue
        fig, ancho = f()
        fig.tight_layout()
        memoria = io.BytesIO()
        fig.savefig(memoria, format='png', dpi=2 * ancho / fig.get_figwidth())
        plt.close(fig)
        img = Image.open(memoria).convert('RGB')
        destino = os.path.join(AQUI, 'img', nombre[4:] + '.webp')
        img.save(destino, 'WEBP', quality=92, method=6)
        print(os.path.basename(destino), img.size, f'ancho {ancho}')


if __name__ == '__main__':
    main()
