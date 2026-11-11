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
