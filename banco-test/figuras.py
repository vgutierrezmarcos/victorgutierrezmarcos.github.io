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


def fig_310205():
    """Ricardo: producto medio, producto marginal y salario de subsistencia; sin áreas ni L*."""
    fig, ax = plt.subplots(figsize=(6.2, 4.8))
    ejes(ax, '$L$', 'grano\npor dosis', 10.6, 22)
    ax.plot([5, 5], [0, 15], color=GRIS, lw=1, ls='--')
    ax.plot([0, 10], [20, 10], color=MORADO, lw=2)
    ax.plot([0, 10], [20, 0], color=DORADO, lw=2)
    ax.plot([0, 10], [4, 4], color=VERDE, lw=2)
    ax.text(7.0, 13.7, r'$\mathrm{PMe}=20-L$', color=MORADO)
    ax.text(6.3, 8.2, r'$\mathrm{PMg}=20-2L$', color=DORADO)
    ax.text(0.3, 4.6, r'$\bar w=4$', color=VERDE)
    ax.set_xticks([5, 10])
    ax.set_yticks([4, 20])
    return fig, 560


def fig_310306():
    """Marshall: dos demandas, oferta del día (vertical) y oferta normal; solo el punto inicial."""
    fig, ax = plt.subplots(figsize=(6.2, 5.0))
    ejes(ax, '$q$', '$p$', 75, 122)
    ax.plot([30, 30], [0, 50], color=GRIS, lw=1, ls=':')
    ax.plot([0, 30], [50, 50], color=GRIS, lw=1, ls=':')
    ax.plot([0, 72], [80, 8], color=MORADO, lw=2)
    ax.plot([0, 72], [110, 38], color=MORADO, lw=2, ls='--')
    ax.plot([30, 30], [0, 112], color=VERDE, lw=2)
    ax.plot([0, 72], [20, 92], color=DORADO, lw=2)
    ax.plot(30, 50, 'o', color=TEXTO, ms=6)
    ax.annotate('A', (30, 50), xytext=(13, -5), textcoords='offset points', fontsize=13)
    ax.text(63, 21, '$D_0$', color=MORADO)
    ax.text(63, 51, '$D_1$', color=MORADO)
    ax.text(31.5, 108, 'MS (oferta del día)', color=VERDE)
    ax.text(61, 91, 'NS (oferta normal)', color=DORADO, ha='right')
    ax.set_xticks([30])
    ax.set_yticks([50])
    return fig, 560


def _phillips(un, uo, pio, pe, radios, xmax, ymax, ancho):
    """Barro y Gordon: Phillips de largo y de corto plazo, punto de felicidad y curvas de pérdida."""
    fig, ax = plt.subplots(figsize=(6.4, 6.4 * ymax / xmax + 0.5))
    ejes(ax, '$U$', r'$\pi$', xmax, ymax)
    ax.set_aspect('equal')
    t = np.linspace(0, 2 * np.pi, 400)
    for r in radios:
        ax.plot(uo + r * np.cos(t), pio + r * np.sin(t), color=GRIS, lw=1.1)
    ax.plot([un, un], [0, ymax - 0.55], color=MORADO, lw=2)
    for e, nombre in zip(pe, ('baja', 'alta')):
        u0, u1 = un - (ymax - 0.9 - e) / 2, un + e / 2
        ax.plot([u0, u1], [e - 2 * (u0 - un), 0], color=DORADO, lw=2)
        ax.text(u0, ymax - 0.75, rf'$\pi^e$ {nombre}', color=DORADO, ha='center', va='bottom')
    ax.plot(uo, pio, 'o', color=TEXTO, ms=6)
    ax.text(un + 0.15, ymax - 0.5, 'Phillips a largo plazo', color=MORADO, ha='left', va='top')
    ax.text(uo - radios[-1] * 0.72, pio + radios[-1] * 0.72, 'pérdida', color=GRIS, ha='right', va='bottom')
    ax.set_xticks([uo, un])
    ax.set_xticklabels([f'$U^*={uo}$', f'$U^n={un}$'])
    ax.set_yticks([pio])
    ax.set_yticklabels([rf'$\pi^*={pio}$'])
    return fig, ancho


def fig_310610():
    return _phillips(6, 4, 2, (1.4, 4.6), (0.9, 1.7, 2.5), 10.5, 7.6, 580)


def fig_312802():
    return _phillips(8, 5, 2, (1.2, 5.4), (1.0, 1.9, 2.7), 12.5, 8.4, 580)


def fig_311008():
    """Seguros: línea de certeza y punto sin seguro; sin recta de aseguramiento ni curvas."""
    fig, ax = plt.subplots(figsize=(5.6, 5.2))
    ejes(ax, '$x_1$', '$x_2$', 10, 10)
    ax.plot([0, 9.3], [0, 9.3], color=MORADO, lw=2)
    ax.plot([7, 7], [0, 3], color=GRIS, lw=1, ls=':')
    ax.plot([0, 7], [3, 3], color=GRIS, lw=1, ls=':')
    ax.plot(7, 3, 'o', color=TEXTO, ms=6)
    ax.annotate('A (sin seguro)', (7, 3), xytext=(8, 6), textcoords='offset points')
    ax.text(5.0, 6.0, 'línea de certeza\n$x_1=x_2$', color=MORADO, ha='right', va='center')
    ax.set_xticks([7])
    ax.set_xticklabels(['$W$'])
    ax.set_yticks([3])
    ax.set_yticklabels(['$W-L$'])
    return fig, 520


def fig_311402():
    """Árbol de la disuasión de la entrada con inversión en capacidad; sin señalar el equilibrio."""
    fig, ax = plt.subplots(figsize=(7.0, 5.2))
    ax.set_xlim(0, 104)
    ax.set_ylim(0, 100)
    ax.axis('off')

    def rama(a, b, texto, lado):
        ax.plot([a[0], b[0]], [a[1], b[1]], color=TEXTO, lw=1.4, zorder=1)
        mx, my = (a[0] + b[0]) / 2, (a[1] + b[1]) / 2
        ax.text(mx + (-1.5 if lado == 'i' else 1.5), my + 1, texto, ha='right' if lado == 'i' else 'left', va='bottom', fontsize=11.5)

    def nodo(p, quien):
        ax.plot(*p, 'o', color=MORADO if quien == 'I' else DORADO, ms=17, zorder=2)
        ax.text(p[0], p[1] - 0.3, quien, color='white', ha='center', va='center', fontsize=12, fontweight='bold', zorder=3)

    def pago(p, texto):
        ax.plot(*p, 'o', color=TEXTO, ms=4, zorder=2)
        ax.text(p[0], p[1] - 4, texto, ha='center', va='top', fontsize=12)

    raiz = (52, 93)
    for x0, nombre, lado, sufijo in ((26, 'No invertir', 'i', ''), (78, 'Invertir', 'd', '$-K$')):
        e, fin, i2 = (x0, 72), (x0 - 15, 47), (x0 + 11, 47)
        aco, luc = (x0 + 1, 20), (x0 + 21, 20)
        rama(raiz, e, nombre, lado)
        rama(e, fin, 'No entrar', 'i')
        rama(e, i2, 'Entrar', 'd')
        rama(i2, aco, 'Acomodar', 'i')
        rama(i2, luc, 'Luchar', 'd')
        nodo(e, 'E')
        nodo(i2, 'I')
        pago(fin, f'(0, 8{sufijo})')
        pago(aco, f'(2, 3{sufijo})')
        pago(luc, '(−1, 1)')
    nodo(raiz, 'I')
    ax.text(52, 3, 'Pagos: (entrante E, instalada I)', ha='center', va='bottom', color=GRIS, fontsize=11.5)
    return fig, 600


def fig_311604():
    """Demanda y oferta decreciente (economías externas) con su corte; sin flechas de ajuste."""
    fig, ax = plt.subplots(figsize=(6.0, 4.9))
    ejes(ax, '$q$', '$p$', 10.8, 21.5)
    ax.plot([6, 6], [0, 8], color=GRIS, lw=1, ls=':')
    ax.plot([0, 6], [8, 8], color=GRIS, lw=1, ls=':')
    ax.plot([0, 10], [20, 0], color=MORADO, lw=2)
    ax.plot([0, 10], [14, 4], color=DORADO, lw=2)
    ax.plot(6, 8, 'o', color=TEXTO, ms=6)
    ax.text(1.75, 17.0, 'Demanda: $p=20-2q$', color=MORADO)
    ax.text(7.0, 7.6, 'Oferta: $p=14-q$', color=DORADO)
    ax.set_xticks([6, 10])
    ax.set_yticks([8, 14, 20])
    return fig, 540


def fig_311715():
    """Coste medio de una y de dos empresas y demanda que corta al primero en q = 8."""
    fig, ax = plt.subplots(figsize=(6.4, 5.0))
    ejes(ax, '$q$', 'precio\ny costes', 17, 25)
    q = np.linspace(1.6, 16.5, 400)
    ax.plot([8, 8], [0, 12.5], color=GRIS, lw=1, ls=':')
    ax.plot([0, 8], [12.5, 12.5], color=GRIS, lw=1, ls=':')
    ax.plot([6, 6], [0, 12], color=GRIS, lw=1, ls=':')
    ax.plot(q, q + 36 / q, color=MORADO, lw=2)
    q2 = np.linspace(3.3, 16.5, 400)
    ax.plot(q2, q2 / 2 + 72 / q2, color=DORADO, lw=2)
    ax.plot([3.2, 15.5], [17.3, 5.0], color=VERDE, lw=2)
    ax.plot([6, 8], [12, 12.5], 'o', color=TEXTO, ms=6)
    ax.annotate('mínimo: 12', (6, 12), xytext=(-4, -17), textcoords='offset points', ha='right', fontsize=11.5)
    ax.text(13.6, 19.2, r'$\mathrm{CMe}_1$', color=MORADO)
    ax.text(14.2, 10.6, r'$\mathrm{CMe}_{1+2}$', color=DORADO)
    ax.text(13.2, 4.2, 'Demanda', color=VERDE)
    ax.set_xticks([6, 8])
    ax.set_yticks([12.5])
    ax.set_yticklabels(['12,5'])
    return fig, 580


def fig_311807():
    """Diferenciación vertical: segmento de valoraciones y consumidor indiferente, sin escala."""
    fig, ax = plt.subplots(figsize=(6.6, 2.5))
    ax.set_xlim(-0.6, 10.6)
    ax.set_ylim(-2.6, 3.0)
    ax.axis('off')
    m = 4.3
    ax.plot([0, 10], [0, 0], color=TEXTO, lw=1.6)
    for x in (0, 10):
        ax.plot([x, x], [-0.3, 0.3], color=TEXTO, lw=1.6)
    ax.plot(m, 0, 'o', color=MORADO, ms=8)
    ax.text(0, -0.6, r'$\theta=0{,}5$', ha='center', va='top')
    ax.text(10, -0.6, r'$\theta=1{,}5$', ha='center', va='top')
    ax.text(m, -0.6, r'$\tilde\theta$ (consumidor indiferente)', ha='center', va='top', color=MORADO)
    for a, b, texto, color in ((0, m, 'compran la calidad\nbaja (B)', DORADO), (m, 10, 'compran la calidad alta (A)', VERDE)):
        a, b = a + 0.12, b - 0.12
        ax.plot([a, a, b, b], [0.55, 0.95, 0.95, 0.55], color=color, lw=1.4)
        ax.text((a + b) / 2, 1.2, texto, ha='center', va='bottom', color=color)
    ax.text(5, -2.5, 'Esquema sin escala: la posición de $\\tilde\\theta$ es orientativa', ha='center', va='bottom', color=GRIS, fontsize=11)
    return fig, 580


def fig_311909():
    """Empresa dominante: demanda de mercado, oferta de la franja y coste marginal; sin demanda residual."""
    fig, ax = plt.subplots(figsize=(5.8, 5.2))
    ejes(ax, 'cantidad', '$p$', 21.5, 21.5)
    ax.plot([0, 20], [20, 0], color=MORADO, lw=2)
    ax.plot([0, 20], [0, 20], color=DORADO, lw=2)
    ax.plot([0, 20], [2, 2], color=VERDE, lw=2)
    ax.text(2.1, 18.6, 'Demanda: $x(p)=20-p$', color=MORADO)
    ax.text(20.2, 12.6, 'Oferta de la\nfranja: $q_f=p$', color=DORADO, ha='right', va='top')
    ax.text(9.0, 2.6, r'$\mathrm{CMg}_L=2$', color=VERDE)
    ax.set_xticks([20])
    ax.set_yticks([2, 20])
    return fig, 540


def fig_312004():
    """Coste medio en U con su mínimo y la cantidad demandada; sin el coste medio de dos empresas."""
    fig, ax = plt.subplots(figsize=(6.2, 4.8))
    ejes(ax, '$q$', 'euros\npor unidad', 17.5, 40)
    q = np.linspace(3, 16.5, 400)
    ax.plot([10, 10], [0, 20], color=GRIS, lw=1, ls=':')
    ax.plot([0, 10], [20, 20], color=GRIS, lw=1, ls=':')
    ax.plot([12, 12], [0, 100 / 12 + 12], color=GRIS, lw=1, ls='--')
    ax.plot(q, 100 / q + q, color=MORADO, lw=2.2)
    ax.plot(10, 20, 'o', color=TEXTO, ms=6)
    ax.text(4.3, 31.5, r'$\mathrm{CMe}=\dfrac{100}{q}+q$', color=MORADO)
    ax.text(12.3, 7.5, '$q=12$\n(demanda)', color=TEXTO, ha='left', va='center')
    ax.set_xticks([10, 12])
    ax.set_yticks([20])
    return fig, 560


def fig_312106():
    """Exceso de demanda con tres equilibrios; sin flechas de ajuste."""
    fig, ax = plt.subplots(figsize=(6.2, 4.4))
    ax.set_xlim(0, 4.9)
    ax.set_ylim(-2.3, 3.5)
    ax.spines['bottom'].set_position('zero')
    p = np.linspace(0.42, 4.2, 400)
    ax.plot(p, -0.75 * (p - 1) * (p - 2.3) * (p - 3.6), color=MORADO, lw=2.2)
    ax.plot([1, 2.3, 3.6], [0, 0, 0], 'o', color=TEXTO, ms=6)
    for x, n, d in ((1, 1, (7, 7)), (2.3, 2, (7, -17)), (3.6, 3, (7, 7))):
        ax.annotate(f'$p^{n}$', (x, 0), xytext=d, textcoords='offset points', fontsize=13)
    ax.text(0.72, 2.3, '$z_X(p_X,1)$', color=MORADO)
    ax.text(4.88, -0.16, '$p_X$', ha='right', va='top')
    ax.text(0.08, 3.45, '$z_X$', ha='left', va='top')
    ax.set_xticks([])
    ax.set_yticks([0])
    return fig, 560


def fig_312309():
    """Bien público: disposiciones marginales a pagar de A y de B y coste marginal; sin la suma vertical."""
    fig, ax = plt.subplots(figsize=(6.2, 4.8))
    ejes(ax, '$G$', 'euros\npor unidad', 32, 37)
    ax.plot([0, 30], [30, 0], color=MORADO, lw=2)
    ax.plot([0, 10], [20, 0], color=DORADO, lw=2)
    ax.plot([0, 30], [26, 26], color=VERDE, lw=2)
    ax.text(15.6, 15.6, 'RMS de A: $30-G$', color=MORADO)
    ax.text(8.0, 8.2, 'RMS de B:\n$20-2G$', color=DORADO, va='center')
    ax.text(21.5, 27.0, r'$\mathrm{CMg}=26$', color=VERDE)
    ax.set_xticks([10, 30])
    ax.set_yticks([20, 26, 30])
    return fig, 560


def fig_312504():
    """Monopsonio: oferta de trabajo, gasto marginal y valor del producto marginal; sin cortes."""
    fig, ax = plt.subplots(figsize=(6.2, 5.0))
    ejes(ax, '$L$', '$w_L$', 42, 86)
    ax.plot([0, 40], [10, 50], color=MORADO, lw=2)
    ax.plot([0, 35], [10, 80], color=DORADO, lw=2)
    ax.plot([0, 40], [70, 30], color=VERDE, lw=2)
    ax.text(40.5, 53.5, 'Oferta:\n$w_L=10+L$', color=MORADO, ha='right', va='bottom')
    ax.text(27.0, 76.5, r'$\mathrm{GMg}_L$', color=DORADO, ha='right')
    ax.text(40.5, 24.5, r'$\mathrm{VPMg}_L=70-L$', color=VERDE, ha='right', va='top')
    ax.set_xticks([40])
    ax.set_yticks([10, 70])
    return fig, 560


def fig_312603():
    """Curva de Beveridge inicial y puntos anuales que suben en vertical; sin segunda curva."""
    fig, ax = plt.subplots(figsize=(5.8, 5.0))
    ejes(ax, '$U$', '$V$', 10, 10)
    u = np.linspace(1.15, 9.4, 300)
    ax.plot(u, 9 / u, color=MORADO, lw=2)
    pts = [(4.5, 2.0), (4.55, 3.1), (4.45, 4.3), (4.6, 5.5), (4.55, 6.7)]
    for a, b in zip(pts, pts[1:]):
        ax.annotate('', xy=b, xytext=a, arrowprops=dict(arrowstyle='-|>', color=DORADO, lw=1.5, shrinkA=5, shrinkB=5))
    for i, (x, y) in enumerate(pts):
        ax.plot(x, y, 'o', color=TEXTO if i == 0 else DORADO, ms=6)
        ax.annotate(f'año {i}', (x, y), xytext=(10, -4), textcoords='offset points', fontsize=11.5, color=TEXTO if i == 0 else DORADO)
    ax.text(1.75, 8.3, 'curva de Beveridge\ninicial', color=MORADO, va='center')
    ax.set_xticks([])
    ax.set_yticks([])
    return fig, 520


def fig_312703():
    """McDonald y Solow: demanda de trabajo, salario de reserva, isobeneficios e indiferencias; sin curva de contratos."""
    fig, ax = plt.subplots(figsize=(6.4, 5.2))
    ejes(ax, '$L$', '$w$', 11.6, 11.4)
    lc, n, wr = 7.0, 10.0, 3.0
    l = np.linspace(0.6, 11.2, 500)
    for ben in (3.2, 9.0, 17.0):
        w = 10 - l / 2 - ben / l
        ax.plot(l[w > 0.2], w[w > 0.2], color=DORADO, lw=1.3)
    for c in (2.2, 4.6, 7.6):
        li = np.linspace(0.6, n, 400)
        w = wr * np.exp(c / li)
        ok = w < 9.7
        ax.plot(np.append(li[ok], 11.2), np.append(w[ok], w[-1]), color=VERDE, lw=1.3)
    ax.plot([0, 11.2], [wr, wr], color=GRIS, lw=1.4, ls='--')
    ax.plot([lc, lc], [0, wr], color=GRIS, lw=1, ls=':')
    ax.plot([n, n], [0, wr * np.exp(7.6 / n)], color=GRIS, lw=1, ls=':')
    ax.plot([0, 10], [10, 0], color=MORADO, lw=2.2)
    ax.plot(lc, wr, 'o', color=TEXTO, ms=6)
    ax.annotate('C', (lc, wr), xytext=(5, 6), textcoords='offset points', fontsize=13)
    ax.text(0.9, 10.45, 'demanda de trabajo', color=MORADO)
    ax.text(8.5, 7.35, 'indiferencia\ndel sindicato', color=VERDE, ha='center', va='center')
    ax.text(2.55, 0.55, 'isobeneficios', color=DORADO)
    ax.set_xticks([lc, n])
    ax.set_xticklabels(['$L^c$', 'afiliados'])
    ax.set_yticks([wr])
    ax.set_yticklabels(['$w^R$'])
    return fig, 580


def fig_312906():
    """Diamond: ley de movimiento del capital y bisectriz, con el estado estacionario; sin regla de oro."""
    fig, ax = plt.subplots(figsize=(5.6, 5.2))
    ejes(ax, r'$\tilde k_t$', r'$\tilde k_{t+1}$', 1.9, 1.9)
    k = np.linspace(0, 1.8, 600)
    ax.plot([1, 1], [0, 1], color=GRIS, lw=1, ls=':')
    ax.plot([0, 1], [1, 1], color=GRIS, lw=1, ls=':')
    ax.plot([0, 1.75], [0, 1.75], color=GRIS, lw=1.4)
    ax.plot(k, k ** 0.25, color=MORADO, lw=2.2)
    ax.plot(1, 1, 'o', color=TEXTO, ms=6)
    ax.text(1.36, 1.56, r'$\tilde k_{t+1}=\tilde k_t$', color=GRIS, ha='right', va='center')
    ax.text(1.80, 1.21, 'ley de movimiento', color=MORADO, ha='right', va='bottom')
    ax.set_xticks([1])
    ax.set_xticklabels([r'$\tilde k^*$'])
    ax.set_yticks([1])
    ax.set_yticklabels([r'$\tilde k^*$'])
    return fig, 520


def _islmbp(desplazada):
    """IS-LM-BP con la BP más inclinada que la LM; sin el equilibrio final ni la LM desplazada."""
    fig, ax = plt.subplots(figsize=(6.0, 4.9))
    ejes(ax, '$Y$', '$i$', 10.8, 8.8)
    ax.plot([0.8, 9.8], [1.9, 6.4], color=DORADO, lw=2)
    ax.plot([2.7, 7.5], [0.55, 7.75], color=VERDE, lw=2)
    ax.plot([1.2, 8.8], [7.42, 0.58], color=MORADO, lw=2)
    ax.text(9.9, 6.45, 'LM', color=DORADO, va='center')
    ax.text(7.6, 7.9, 'BP', color=VERDE, va='center')
    if desplazada:
        ax.plot([3.4, 10.2], [7.42, 1.3], color=MORADO, lw=2, ls='--')
        ax.text(8.9, 0.3, 'IS', color=MORADO, va='center')
        ax.text(10.25, 1.0, "IS$'$", color=MORADO, va='center')
    else:
        ax.text(8.9, 0.45, 'IS', color=MORADO, va='center')
    ax.plot(5, 4, 'o', color=TEXTO, ms=6)
    ax.annotate('A', (5, 4), xytext=(-5, 9), textcoords='offset points', fontsize=13, ha='right')
    ax.set_xticks([])
    ax.set_yticks([])
    return fig, 540


def fig_313201():
    return _islmbp(True)


def fig_313802():
    return _islmbp(False)


def fig_314003():
    """Fondos prestables con suelo del tipo real por encima del tipo natural; sin la caída de la renta."""
    fig, ax = plt.subplots(figsize=(6.2, 4.8))
    ax.set_xlim(0, 10.8)
    ax.set_ylim(-3.3, 3.4)
    ax.spines['bottom'].set_position('zero')
    rn, suelo = -1.9, -0.75
    ax.plot([0, 5], [rn, rn], color=GRIS, lw=1, ls=':')
    ax.plot([0, 10.4], [suelo, suelo], color=DORADO, lw=1.8, ls='--')
    ax.plot([3.5, 9.9], [rn - 1.2, rn + 3.92], color=MORADO, lw=2)
    ax.plot([0.5, 6.6], [rn + 3.15, rn - 1.12], color=VERDE, lw=2)
    ax.plot(5, rn, 'o', color=TEXTO, ms=7, mfc='white', mew=1.4)
    ax.text(9.95, rn + 4.1, '$S_1(r)$', color=MORADO, ha='center', va='bottom')
    ax.text(0.45, rn + 3.35, '$I_1(r)+G-T$', color=VERDE, ha='left', va='bottom')
    ax.text(10.4, suelo - 0.15, 'suelo del tipo real', color=DORADO, ha='right', va='top')
    ax.text(10.75, 0.15, 'ahorro, inversión', ha='right', va='bottom')
    ax.text(0.15, 3.38, '$r$', ha='left', va='top')
    ax.set_xticks([])
    ax.set_yticks([rn, suelo, 0])
    ax.set_yticklabels(['$r^n_1$', r'$i^{\mathrm{ELB}}-\pi^e$', '0'])
    return fig, 560


def fig_314319():
    """Trampa de pobreza: s·f(k)/k corta tres veces a n + δ; sin flechas ni rótulos de estabilidad."""
    fig, ax = plt.subplots(figsize=(6.4, 4.6))
    ejes(ax, '$k$', '', 11.4, 9.6)
    kb, ku, ka, nd = 1.6, 4.4, 8.0, 4.2
    k = np.linspace(0.25, 10.9, 800)
    y = nd + 0.42 * (kb - k) * (k - ku) * (k - ka) / (k ** 0.8 * (1 + (k / 7.5) ** 4))
    ok = y < 9.3
    for x in (kb, ku, ka):
        ax.plot([x, x], [0, nd], color=GRIS, lw=1, ls=':')
    ax.plot([0, 10.9], [nd, nd], color=DORADO, lw=2)
    ax.plot(k[ok], y[ok], color=MORADO, lw=2.2)
    ax.plot([kb, ku, ka], [nd, nd, nd], 'o', color=TEXTO, ms=6)
    ax.text(1.35, 8.6, r'$s\,f(k)/k$', color=MORADO, ha='left')
    ax.set_xticks([kb, ku, ka])
    ax.set_xticklabels(['$k_B$', '$k_U$', '$k_A$'])
    ax.set_yticks([nd])
    ax.set_yticklabels([r'$n+\delta$'])
    return fig, 580


def fig_314325():
    """Ramsey: lugares geométricos, senda de silla y punto C bajo ella; sin trayectorias ni flechas."""
    fig, ax = plt.subplots(figsize=(6.6, 4.8))
    ejes(ax, r'$\tilde k$', r'$\tilde c$', 17.6, 5.6)
    ke, k0 = 4.5, 2.0
    loc = lambda k: k * (16 - k) / 16
    silla = lambda k: loc(ke) * (k / ke) ** 1.3
    k = np.linspace(0, 16, 400)
    ks = np.linspace(0, 6.35, 200)
    ax.plot([8, 8], [0, 4], color=GRIS, lw=1, ls=':')
    ax.plot([k0, k0], [0, silla(k0)], color=GRIS, lw=1, ls=':')
    ax.plot(k, loc(k), color=MORADO, lw=2)
    ax.plot([ke, ke], [0, 5.25], color=DORADO, lw=2)
    ax.plot(ks, silla(ks), color=VERDE, lw=2)
    ax.plot(ke, loc(ke), 'o', color=TEXTO, ms=6)
    ax.plot(k0, 0.5, 'o', color=TEXTO, ms=6)
    ax.annotate('E', (ke, loc(ke)), xytext=(7, -13), textcoords='offset points', fontsize=13)
    ax.annotate('C', (k0, 0.5), xytext=(7, -3), textcoords='offset points', fontsize=13)
    ax.text(12.6, 3.0, r'$\dot{\tilde k}=0$', color=MORADO, ha='left')
    ax.text(ke - 0.25, 5.2, r'$\dot{\tilde c}=0$', color=DORADO, ha='right', va='top')
    ax.text(6.55, 5.0, 'senda de silla', color=VERDE, ha='left', va='center')
    ax.set_xticks([k0, ke, 8, 16])
    ax.set_xticklabels([r'$\tilde k_0$', r'$\tilde k^*$', r'$\tilde k_{\mathrm{oro}}$', r'$\bar k$'])
    ax.set_yticks([])
    return fig, 600


def fig_323101():
    """Clima: coste marginal de reducción, daño marginal de un país y de los cuatro; sin cortes."""
    fig, ax = plt.subplots(figsize=(5.8, 5.2))
    ejes(ax, '$E$', 'euros por\ntonelada', 108, 108)
    ax.plot([0, 100], [100, 0], color=MORADO, lw=2)
    ax.plot([0, 100], [0, 25], color=DORADO, lw=2)
    ax.plot([0, 100], [0, 100], color=VERDE, lw=2)
    ax.text(5, 101, r'$\mathrm{CMgR}=100-E$', color=MORADO, ha='left', va='center')
    ax.text(100, 29, r'$\mathrm{DMg}_i$ (un país)', color=DORADO, ha='right', va='bottom')
    ax.text(86, 104, r'$\mathrm{DMg}$ (suma de los' + '\ncuatro países)', color=VERDE, ha='right', va='top')
    ax.set_xticks([100])
    ax.set_yticks([100])
    return fig, 540


def fig_320512():
    """Curvas de oferta neta con tres equilibrios además del origen; sin flechas ni estabilidad."""
    from scipy.interpolate import CubicSpline
    fig, ax = plt.subplots(figsize=(5.8, 5.4))
    ejes(ax, '$X$', '$Y$', 8.4, 8.4)
    ax.set_aspect('equal')
    g = CubicSpline([0, 6, 12, 18, 25, 32, 38, 44, 50], [0, 4.3, 6.9, 7.6, 7.1, 6.7, 6.9, 7.7, 8.8])
    x = np.linspace(0, 50, 500)
    ta, tb = np.radians(20 + x), np.radians(70 - x)
    for grados in (32, 45, 58):
        r = float(g(grados - 20))
        t = np.radians(grados)
        ax.plot([0, 1.22 * r * np.cos(t)], [0, 1.22 * r * np.sin(t)], color=GRIS, lw=0.9, ls=':')
    ax.plot(g(x) * np.cos(ta), g(x) * np.sin(ta), color=MORADO, lw=2.2)
    ax.plot(g(x) * np.cos(tb), g(x) * np.sin(tb), color=DORADO, lw=2.2)
    for grados, n, d in ((32, 1, (9, -10)), (45, 2, (9, -9)), (58, 3, (-10, 8))):
        r = float(g(grados - 20))
        t = np.radians(grados)
        ax.plot(r * np.cos(t), r * np.sin(t), 'o', color=TEXTO, ms=6)
        ax.annotate(f'$E_{n}$', (r * np.cos(t), r * np.sin(t)), xytext=d, textcoords='offset points', fontsize=13,
                    ha='left' if d[0] > 0 else 'right', va='center')
    ax.text(2.85, 8.2, 'oferta neta de A', color=MORADO, ha='right', va='center')
    ax.text(8.35, 2.6, 'oferta neta\nde B', color=DORADO, ha='right', va='top')
    ax.set_xticks([])
    ax.set_yticks([])
    return fig, 540


def fig_320521():
    """Factores específicos: mercado de trabajo en la situación inicial; sin desplazamientos."""
    fig, ax = plt.subplots(figsize=(6.2, 4.8))
    ax.set_xlim(0, 10)
    ax.set_ylim(0, 9.6)
    ax.spines['right'].set_visible(True)
    l = np.linspace(0, 10, 400)
    vx = 1.0 + 7.6 / (1 + 0.55 * l)
    vy = 0.8 + 6.6 / (1 + 0.45 * (10 - l))
    i = int(np.argmin(np.abs(vx - vy)))
    ax.plot([0, 10], [vx[i], vx[i]], color=GRIS, lw=1, ls=':')
    ax.plot([l[i], l[i]], [0, vx[i]], color=GRIS, lw=1, ls=':')
    ax.plot(l, vx, color=MORADO, lw=2.2)
    ax.plot(l, vy, color=DORADO, lw=2.2)
    ax.plot(l[i], vx[i], 'o', color=TEXTO, ms=6)
    ax.annotate('A', (l[i], vx[i]), xytext=(0, 9), textcoords='offset points', fontsize=13, ha='center')
    ax.text(0.75, 7.75, r'$p_X\,\mathrm{PMg}_L^X$', color=MORADO, ha='left')
    ax.text(9.25, 6.75, r'$p_Y\,\mathrm{PMg}_L^Y$', color=DORADO, ha='right')
    ax.text(0.1, 9.55, '$w$', ha='left', va='top')
    ax.text(9.9, 9.55, '$w$', ha='right', va='top')
    ax.annotate('', xy=(l[i] - 0.15, 0.45), xytext=(0.15, 0.45), arrowprops=dict(arrowstyle='-|>', color=MORADO, lw=1.2))
    ax.annotate('', xy=(l[i] + 0.15, 0.45), xytext=(9.85, 0.45), arrowprops=dict(arrowstyle='-|>', color=DORADO, lw=1.2))
    ax.text(l[i] / 2, 0.6, '$L_X$', color=MORADO, ha='center', va='bottom')
    ax.text((l[i] + 10) / 2, 0.6, '$L_Y$', color=DORADO, ha='center', va='bottom')
    ax.set_xticks([0, 10])
    ax.set_xticklabels(['$O_X$', '$O_Y$'])
    ax.set_yticks([vx[i]])
    ax.set_yticklabels(['$w_0$'])
    return fig, 560


def fig_320605():
    """Krugman (1979): curvas PP y ZZ en autarquía; sin desplazamientos."""
    fig, ax = plt.subplots(figsize=(6.0, 4.8))
    ejes(ax, '$x$', '$p/w$', 9.2, 7.6)
    x = np.linspace(1.2, 8.6, 300)
    ax.plot([0, 8.6], [2, 2], color=GRIS, lw=1.2, ls='--')
    ax.plot([3, 3], [0, 4], color=GRIS, lw=1, ls=':')
    ax.plot([0, 3], [4, 4], color=GRIS, lw=1, ls=':')
    ax.plot([0.3, 8.0], [2.65, 6.5], color=MORADO, lw=2.2)
    ax.plot(x, 2 + 6 / x, color=DORADO, lw=2.2)
    ax.plot(3, 4, 'o', color=TEXTO, ms=6)
    ax.annotate('$E_0$', (3, 4), xytext=(0, 10), textcoords='offset points', fontsize=13, ha='center')
    ax.text(8.1, 6.55, 'PP', color=MORADO, va='center')
    ax.text(8.7, 2.75, 'ZZ', color=DORADO, va='center')
    ax.set_xticks([3])
    ax.set_xticklabels(['$x_0$'])
    ax.set_yticks([2, 4])
    ax.set_yticklabels(['$c$', '$(p/w)_0$'])
    return fig, 540


def fig_320612():
    """Melitz: beneficio interior en autarquía y con comercio y beneficio de exportar; sin la suma ni zonas."""
    fig, ax = plt.subplots(figsize=(6.6, 4.9))
    ax.set_xlim(0, 13.4)
    ax.set_ylim(-5.0, 7.4)
    ax.spines['bottom'].set_position('zero')
    f, fx, ba, bd, bx = 2.0, 4.2, 1.0, 0.50, 0.42
    xm, xa = 11.8, 9.0
    ax.plot([0, xa], [-f, -f + ba * xa], color=MORADO, lw=2)
    ax.plot([0, xm], [-f, -f + bd * xm], color=DORADO, lw=2)
    ax.plot([0, xm], [-fx, -fx + bx * xm], color=VERDE, lw=2)
    cortes = (f / ba, f / bd, fx / bx)
    ax.plot(cortes, [0, 0, 0], 'o', color=TEXTO, ms=6)
    linea = dict(arrowstyle='-', color=GRIS, lw=0.8, shrinkA=1, shrinkB=4)
    ax.annotate('umbral de\nautarquía', (cortes[0], 0), xytext=(-6, 24), textcoords='offset points', ha='right', va='bottom',
                fontsize=10.5, color=MORADO, arrowprops=linea)
    ax.annotate('umbral de\nsupervivencia', (cortes[1], 0), xytext=(34, -16), textcoords='offset points', ha='center', va='top',
                fontsize=10.5, color=DORADO, arrowprops=linea)
    ax.annotate('umbral de\nexportación', (cortes[2], 0), xytext=(0, 26), textcoords='offset points', ha='center', va='bottom',
                fontsize=10.5, color=VERDE, arrowprops=linea)
    ax.text(xa + 0.15, -f + ba * xa, 'interior,\nautarquía', color=MORADO, ha='left', va='center', fontsize=11)
    ax.text(xm + 0.1, -f + bd * xm + 0.35, 'interior,\ncon comercio', color=DORADO, ha='left', va='center', fontsize=11)
    ax.text(xm + 0.1, -fx + bx * xm + 0.1, 'de exportar', color=VERDE, ha='left', va='center', fontsize=11)
    ax.text(13.35, -0.2, r'$\varphi^{\sigma-1}$', ha='right', va='top')
    ax.text(0.15, 7.35, 'beneficio', ha='left', va='top')
    ax.set_xticks([])
    ax.set_yticks([-fx, -f, 0])
    ax.set_yticklabels(['$-wF^x$', '$-wF^d$', '0'])
    return fig, 600


def fig_320702():
    """Arancel en un país grande, en el mercado de importaciones: áreas con letras, sin cifras ni escala."""
    fig, axs = plt.subplots(1, 2, figsize=(7.6, 4.4), sharey=True)
    m1, m0, pi, pw, pe = 35, 50, 65, 50, 35
    for ax, titulo in zip(axs, ('País importador', 'Resto del mundo (exportador)')):
        ejes(ax, 'importaciones', '', 92, 100)
        ax.set_title(titulo, fontsize=12.5, pad=8)
        ax.fill([0, m1, m1, 0], [pe, pe, pw, pw], color=AZUL, alpha=0.22, lw=0)
        for y, hasta in ((pi, m1), (pw, m0), (pe, m1)):
            ax.plot([0, hasta], [y, y], color=GRIS, lw=1, ls='--')
        ax.plot([m1, m1], [0, pe], color=GRIS, lw=1, ls=':')
        ax.plot([m0, m0], [0, pw], color=GRIS, lw=1, ls=':')
        ax.plot([12, 88], [88, 12], color=MORADO, lw=2)
        ax.plot([12, 88], [12, 88], color=DORADO, lw=2)
        ax.plot([m1, m1], [pe, pi], color=TEXTO, lw=1.6)
        ax.plot([m1, m1, m0], [pi, pe, pw], 'o', color=TEXTO, ms=5)
        ax.text(89, 9, '$M$', color=MORADO, va='center')
        ax.text(89, 91, '$X^*$', color=DORADO, va='center')
        ax.text(m1 / 2, (pe + pw) / 2, '$e$', ha='center', va='center', fontsize=14)
        ax.set_xticks([m1, m0])
        ax.set_xticklabels(['$M^1$', '$M^0$'])
        ax.set_yticks([pe, pw, pi])
        ax.set_yticklabels(['$p^*$', '$p^W$', '$p$'])
    axs[0].set_ylabel('precio', loc='top', rotation=0)
    axs[1].tick_params(labelleft=True)
    axs[0].fill([m1, m1, m0], [pw, pi, pw], color=DORADO, alpha=0.30, lw=0)
    axs[0].annotate('$b+d$', (m1 + 4.5, pw + 5), xytext=(m1 + 16, pi + 14), ha='left', va='center', fontsize=13,
                    arrowprops=dict(arrowstyle='-', color=TEXTO, lw=0.8, shrinkA=2, shrinkB=1))
    axs[1].fill([m1, m1, m0], [pe, pw, pw], color=DORADO, alpha=0.30, lw=0)
    axs[1].annotate('$f+h$', (m1 + 4.5, pw - 5), xytext=(m1 + 19, pe - 14), ha='left', va='center', fontsize=13,
                    arrowprops=dict(arrowstyle='-', color=TEXTO, lw=0.8, shrinkA=2, shrinkB=1))
    for ax in axs:
        ax.annotate('', xy=(9, pi), xytext=(9, pe), arrowprops=dict(arrowstyle='<|-|>', color=TEXTO, lw=1))
        ax.text(10.5, pi - 6, 'arancel', ha='left', va='center', fontsize=11)
    fig.supxlabel('Esquema sin escala', color=GRIS, fontsize=11)
    return fig, 640


def fig_320707():
    """Monopolio nacional con arancel: demanda, ingreso marginal, coste marginal y los dos precios; sin equilibrio."""
    fig, ax = plt.subplots(figsize=(6.2, 5.2))
    ejes(ax, 'cantidad', '$p$', 130, 130)
    ax.plot([0, 122], [40, 40], color=GRIS, lw=1.6)
    ax.plot([0, 122], [70, 70], color=AZUL, lw=1.6, ls='--')
    ax.plot([0, 120], [120, 0], color=MORADO, lw=2)
    ax.plot([0, 60], [120, 0], color=MORADO, lw=1.6, ls='--')
    ax.plot([0, 112], [0, 112], color=DORADO, lw=2)
    ax.text(17, 109, 'Demanda: $x=120-p$', color=MORADO, ha='left', va='center')
    ax.text(51.5, 9, r'$\mathrm{IMg}$', color=MORADO, ha='right', va='center')
    ax.text(113, 116, r'$\mathrm{CMg}=q$', color=DORADO, ha='center', va='bottom')
    ax.text(123, 43, '$p^W=40$', color=GRIS, ha='right', va='bottom')
    ax.text(123, 73, '$p^W$ + arancel = 70', color=AZUL, ha='right', va='bottom')
    ax.set_xticks([120])
    ax.set_yticks([40, 70, 120])
    return fig, 560


def fig_321215():
    """Dinámica de la deuda exterior con pendiente mayor que 1; sin flechas ni rótulos de estabilidad."""
    fig, ax = plt.subplots(figsize=(5.8, 5.4))
    ax.set_xlim(0, 10.4)
    ax.set_ylim(-2.3, 10.4)
    ax.spines['bottom'].set_position('zero')
    eq, b0 = 1.6 / 0.3, 3.0
    ax.plot([eq, eq], [0, eq], color=GRIS, lw=1, ls=':')
    ax.plot([0, 9.6], [0, 9.6], color=GRIS, lw=1.4)
    ax.plot([0, 8.9], [-1.6, -1.6 + 1.3 * 8.9], color=MORADO, lw=2.2)
    ax.plot(eq, eq, 'o', color=TEXTO, ms=6)
    ax.plot(b0, 0, 'o', color=DORADO, ms=7, clip_on=False, zorder=5)
    ax.text(7.05, 5.9, '$b_t=b_{t-1}$', color=GRIS, ha='left', va='center')
    ax.text(6.7, 10.35, r'$b_t=\dfrac{1+r^*}{1+\gamma_Y}\,b_{t-1}+d$', color=MORADO, ha='right', va='top')
    ax.text(10.35, -0.25, '$b_{t-1}$', ha='right', va='top')
    ax.text(0.15, 10.35, '$b_t$', ha='left', va='top')
    ax.set_xticks([b0, eq])
    ax.set_xticklabels(['deuda\ninicial', r'$\overline{b}$'])
    ax.set_yticks([-1.6, 0])
    ax.set_yticklabels(['$d$', '0'])
    return fig, 540


def fig_321306():
    """Triángulo de divisas con las tres cotizaciones del enunciado; sin tipo cruzado implícito ni sentido."""
    fig, ax = plt.subplots(figsize=(5.8, 4.4))
    ax.set_xlim(0, 100)
    ax.set_ylim(0, 100)
    ax.axis('off')
    eur, usd, jpy = (50, 84), (18, 18), (82, 18)
    for a, b in ((eur, usd), (usd, jpy), (eur, jpy)):
        ax.plot([a[0], b[0]], [a[1], b[1]], color=TEXTO, lw=1.6, zorder=1)
    for p, nombre, color in ((eur, 'EUR', MORADO), (usd, 'USD', VERDE), (jpy, 'JPY', DORADO)):
        ax.plot(*p, 'o', color=color, ms=44, zorder=2)
        ax.text(p[0], p[1] - 0.5, nombre, color='white', ha='center', va='center', fontsize=13, fontweight='bold', zorder=3)
    ax.text(31, 53, 'EUR/USD = 1,20', ha='right', va='center')
    ax.text(69, 53, 'EUR/JPY = 183', ha='left', va='center')
    ax.text(50, 12, 'USD/JPY = 150', ha='center', va='top')
    return fig, 520


def fig_321414():
    """Modelo de cartera: MM, BB y B*B* en el equilibrio inicial; sin ninguna operación."""
    fig, ax = plt.subplots(figsize=(5.8, 5.0))
    ejes(ax, '$i$', '$E$', 10.6, 10.4)
    ax.plot([1.2, 9.2], [1.96, 8.04], color=MORADO, lw=2)
    ax.plot([3.1, 6.9], [9.18, 0.82], color=DORADO, lw=2)
    ax.plot([0.8, 9.4], [7.1, 2.8], color=VERDE, lw=2)
    ax.plot(5, 5, 'o', color=TEXTO, ms=6)
    ax.annotate('A', (5, 5), xytext=(0, 11), textcoords='offset points', fontsize=13, ha='center')
    ax.text(9.3, 8.15, 'MM', color=MORADO, va='center')
    ax.text(7.0, 0.6, 'BB', color=DORADO, va='center')
    ax.text(9.5, 2.65, '$B^*B^*$', color=VERDE, va='center')
    ax.text(0.35, 9.55, r'($\uparrow E$: depreciación)', color=GRIS, ha='left', va='center', fontsize=11)
    ax.set_xticks([])
    ax.set_yticks([])
    return fig, 520


def fig_321506():
    """Zona objetivo: tipo de cambio sombra y dos curvas sin identificar dentro de la banda."""
    fig, ax = plt.subplots(figsize=(6.2, 5.0))
    ax.set_xlim(-3.3, 3.3)
    ax.set_ylim(-2.35, 2.35)
    for lado in ('left', 'bottom'):
        ax.spines[lado].set_position('zero')
    a = 0.15
    fb = float(np.arccosh(1 / a))
    eb = fb - a * np.sinh(fb)
    f1 = np.linspace(-fb, fb, 400)
    f2 = np.linspace(-1.5, 1.5, 2000)
    e2 = f2 + 0.08 * np.sinh(2 * f2)
    f2, e2 = f2[np.abs(e2) <= eb], e2[np.abs(e2) <= eb]
    for y in (eb, -eb):
        ax.plot([-3.1, 3.1], [y, y], color=GRIS, lw=1.2, ls='--')
    ax.plot([-2.15, 2.15], [-2.15, 2.15], color=GRIS, lw=1.6)
    ax.plot(f1, f1 - a * np.sinh(f1), color=MORADO, lw=2.2)
    ax.plot(f2, e2, color=DORADO, lw=2.2)
    ax.text(-3.1, eb + 0.07, r'$e_{\mathrm{máx}}$', color=GRIS, ha='left', va='bottom')
    ax.text(3.1, -eb - 0.07, r'$e_{\mathrm{mín}}$', color=GRIS, ha='right', va='top')
    ax.text(2.2, 2.2, 'tipo de cambio\nsombra (45°)', color=GRIS, ha='left', va='top', fontsize=11)
    ax.text(2.35, 1.35, 'curva 1', color=MORADO, ha='center', va='top')
    ax.text(0.72, 1.3, 'curva 2', color=DORADO, ha='right', va='center')
    ax.text(3.28, -0.1, '$m+v$', ha='right', va='top')
    ax.text(0.08, 2.33, '$e$', ha='left', va='top')
    ax.set_xticks([])
    ax.set_yticks([])
    return fig, 560


def fig_321606():
    """Unión monetaria: beneficios y dos curvas de costes frente a la apertura; sin decir de qué visión es cada una."""
    fig, ax = plt.subplots(figsize=(6.2, 4.8))
    ejes(ax, 'apertura comercial con los socios (% del PIB)', '% del PIB', 10.6, 10)
    t1, t2 = 4.5 / 1.15, 7.5 / 1.15
    for t in (t1, t2):
        ax.plot([t, t], [0, 1 + 0.6 * t], color=GRIS, lw=1, ls=':')
    ax.plot([0, 10], [1, 7], color=MORADO, lw=2)
    ax.plot([0, 10], [8.5, 3.0], color=DORADO, lw=2)
    ax.plot([0, 10], [5.5, 0.0], color=DORADO, lw=2, ls='--')
    ax.plot([t1, t2], [1 + 0.6 * t1, 1 + 0.6 * t2], 'o', color=TEXTO, ms=6)
    ax.text(10.1, 7.3, 'Beneficios', color=MORADO, ha='right', va='bottom')
    ax.text(0.5, 8.6, 'Costes 1', color=DORADO, ha='left', va='bottom')
    ax.text(0.5, 5.6, 'Costes 2', color=DORADO, ha='left', va='bottom')
    ax.set_xticks([t1, t2])
    ax.set_xticklabels(['$T_1$', '$T_2$'])
    ax.set_yticks([])
    return fig, 560


def fig_322218():
    """Dos gráficos de abanico con el mismo escenario base y bandas de distinta anchura; sin rótulos de riesgo."""
    fig, axs = plt.subplots(1, 2, figsize=(7.4, 4.3), sharey=True)
    t = np.linspace(0, 5, 100)
    base = 90 + t
    r = np.sqrt(t / 5)
    for ax, nombre, (b5, a5, b25, a25) in zip(axs, ('País A', 'País B'), ((25, 35, 10, 13), (8, 9, 3.2, 3.6))):
        ax.fill_between(t, base - b5 * r, base + a5 * r, color=MORADO, alpha=0.16, lw=0, label='percentiles 5-95')
        ax.fill_between(t, base - b25 * r, base + a25 * r, color=MORADO, alpha=0.36, lw=0, label='percentiles 25-75')
        ax.plot(t, base, color=TEXTO, lw=2, label='escenario base')
        ax.set_xlim(0, 5)
        ax.set_ylim(60, 140)
        ax.set_xticks(range(6))
        ax.set_yticks(range(60, 141, 20))
        ax.set_title(nombre, fontsize=13, color=TEXTO)
        ax.set_xlabel('años')
    axs[0].set_ylabel('deuda pública (% del PIB)')
    m, e = axs[0].get_legend_handles_labels()
    fig.legend(m[::-1], e[::-1], loc='lower center', ncol=3, frameon=False, fontsize=11, handlelength=1.6, columnspacing=1.6)
    fig.tight_layout(rect=(0, 0.07, 1, 1))
    fig.tight_layout = lambda *a, **k: None
    return fig, 640


def fig_322509():
    """Árbol binomial de un periodo: la acción y los pagos de la call; sin probabilidades ni delta."""
    fig, ax = plt.subplots(figsize=(6.0, 4.4))
    ax.set_xlim(0, 10)
    ax.set_ylim(0, 10)
    ax.axis('off')
    caja = dict(boxstyle='round,pad=0.45', fc='white', lw=1.4)
    for yc, color, titulo, (n0, nu, nd) in ((7.6, MORADO, 'Acción', ('100', '130', '90')),
                                            (2.6, DORADO, 'Call ($K=108$)', ('$c=\\,?$', '22', '0'))):
        ax.text(0.1, yc, titulo, color=color, ha='left', va='center', fontsize=13)
        for dy, n in ((1.25, nu), (-1.25, nd)):
            ax.plot([4.2, 8.2], [yc, yc + dy], color=color, lw=1.8, zorder=1)
            ax.text(8.2, yc + dy, n, ha='center', va='center', fontsize=13, bbox=dict(caja, ec=color), zorder=3)
        ax.text(4.2, yc, n0, ha='center', va='center', fontsize=13, bbox=dict(caja, ec=color), zorder=3)
    ax.plot([0.1, 9.6], [5.1, 5.1], color=GRIS, lw=0.8, ls=':')
    ax.text(4.2, 0.15, 'hoy', color=GRIS, ha='center', va='bottom', fontsize=11)
    ax.text(8.2, 0.15, 'dentro de un año', color=GRIS, ha='center', va='bottom', fontsize=11)
    return fig, 520


def fig_324317():
    """Crisis autocumplida: la curva p = κ/(1 − pe) corta dos veces a la bisectriz; sin flechas de estabilidad ni respaldo."""
    fig, ax = plt.subplots(figsize=(5.6, 5.2))
    ejes(ax, '$p^e$', '$p$', 1.06, 1.06)
    kappa = 0.16
    pe = np.linspace(0, 1 - kappa, 400)
    ax.plot([0, 1], [0, 1], color=GRIS, lw=1.6)
    ax.plot(pe, kappa / (1 - pe), color=MORADO, lw=2.2)
    ax.plot([0.2, 0.8], [0.2, 0.8], 'o', color=TEXTO, ms=6)
    ax.text(0.24, 0.165, 'equilibrio 1', ha='left', va='top')
    ax.text(0.77, 0.83, 'equilibrio 2', ha='right', va='bottom')
    ax.text(0.5, 0.55, '$p=p^e$', color=GRIS, ha='right', va='bottom')
    ax.text(0.42, 0.20, r'$p=\dfrac{\kappa}{1-p^e}$', color=MORADO, ha='left', va='center')
    ax.set_xticks([0, 1])
    ax.set_yticks([1])
    ax.set_aspect('equal')
    return fig, 520


def fig_324505():
    """Perturbación de demanda y brecha con dos reglas sin identificar; sin escala ni valores."""
    fig, ax = plt.subplots(figsize=(6.2, 4.4))
    t = np.linspace(0, 10, 500)
    s = np.clip(t - 1.5, 0, None) / 1.6
    u = -3 * s * np.exp(1 - s)
    ax.set_xlim(0, 10.4)
    ax.set_ylim(-5.9, 1.3)
    ax.spines['bottom'].set_position('zero')
    ax.plot(t, u / 0.6, color=DORADO, lw=2.2)
    ax.plot(t, u, color=MORADO, lw=3.4, alpha=0.55)
    ax.plot(t, u, color=TEXTO, lw=1)
    ax.annotate('perturbación $u$', (4.6, -2.27), xytext=(3.9, -0.6), ha='left', va='center',
                arrowprops=dict(arrowstyle='-', color=TEXTO, lw=0.8, shrinkB=3))
    ax.text(3.1, -3.3, 'regla A', color=MORADO, ha='center', va='top')
    ax.text(3.1, -5.25, 'regla B', color=DORADO, ha='center', va='top')
    ax.text(10.4, 0.15, 'tiempo', ha='right', va='bottom')
    ax.set_ylabel('brecha de\nproducción', loc='top', rotation=0)
    ax.set_xticks([])
    ax.set_yticks([0])
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
