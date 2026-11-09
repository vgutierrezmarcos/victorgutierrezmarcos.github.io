#!/usr/bin/env python3
"""
Funciones impulso-respuesta del modelo de ciclo real con gasto público (3.A.38,
figura fig:irf-rbc-gasto). Simulación propia; está en
fuentes/3A38/graficos/ y escribe ../datos/irf-rbc-gasto.csv.

Modelo: el RBC base del 3.A.42 (eq:rbc-*) con gasto público G_t que no da
utilidad ni produce, Y_t = C_t + I_t + G_t, y dos formas de financiarlo:
  (a) impuestos de suma fija (equivalencia ricardiana: da igual deuda o impuestos);
  (b) un impuesto proporcional sobre las rentas del trabajo, tau_L,t, con el
      presupuesto equilibrado cada periodo, tau_L,t w_t L_t = G_t.
Utilidad ln C - chi L^(1+phi)/(1+phi); ln G_t = (1-rho_G) ln G + rho_G ln G_{t-1} + eps^G_t.

Log-linealización (minúsculas: desviación logarítmica del estado estacionario):
    y = alpha k + (1-alpha) l                     (sin perturbación tecnológica)
    phi l + c = w + d ln(1 - tau_L),  w = y - l
    d ln(1 - tau_L) = -[tau/(1-tau)] (g - y)      (caso b; 0 en el caso a)
    c_t = E c_{t+1} - nu E (y_{t+1} - k_{t+1}),    nu = 1 - beta (1-delta)
    y = s_c c + s_i i + s_g g,  k_{t+1} = (1-delta) k_t + delta i_t
Método de Blanchard y Kahn con z = (k, g, c), como irf-rbc.py del 3.A.42.

Perturbación: un aumento del gasto del 1 % del PIB de estado estacionario en
t = 0 (g_0 = 0,01/s_g). Respuestas de Y, C, I y G en puntos del PIB de estado
estacionario (así se leen como multiplicadores), L y w en %, r en puntos
porcentuales anualizados; t = 0, ..., 40 trimestres.

Uso: python3 irf-rbc-gasto.py
Autor: Víctor Gutiérrez Marcos
"""
import os

import numpy as np

ALFA, BETA, DELTA, PHI, SG = 1 / 3, 0.99, 0.025, 1.0, 0.20
T = 40


def resolver(rho, impuesto_trabajo):
    ky = ALFA / (1 / BETA - 1 + DELTA)
    s_i = DELTA * ky
    s_c = 1 - s_i - SG
    nu = 1 - BETA * (1 - DELTA)
    kap = (SG / (1 - ALFA)) / (1 - SG / (1 - ALFA)) if impuesto_trabajo else 0.0
    den = (PHI + 1) - (1 - ALFA) * (1 + kap)
    lk, lc, lg = ALFA * (1 + kap) / den, -1 / den, -kap / den
    yk, yc, yg = ALFA + (1 - ALFA) * lk, (1 - ALFA) * lc, (1 - ALFA) * lg
    A = np.array([[1, 0, 0], [0, 1, 0], [-nu * (yk - 1), -nu * yg, 1 - nu * yc]])
    B = np.array([[(1 - DELTA) + DELTA * yk / s_i, DELTA * (yg - SG) / s_i, DELTA * (yc - s_c) / s_i],
                  [0, rho, 0],
                  [0, 0, 1]])
    M = np.linalg.solve(A, B)
    val, izq = np.linalg.eig(M.T)
    inest = [j for j in range(3) if abs(val[j]) > 1]
    assert len(inest) == 1, val
    q = np.real(izq[:, inest[0]])
    eck, ecg = -q[0] / q[2], -q[1] / q[2]
    k, g = 0.0, 0.01 / SG
    filas = []
    for t in range(T + 1):
        c = eck * k + ecg * g
        l = lk * k + lc * c + lg * g
        y = yk * k + yc * c + yg * g
        i = (y - s_c * c - SG * g) / s_i
        w = y - l
        r = (1 / BETA - 1 + DELTA) * (y - k) * 400
        filas.append([t] + [100 * v for v in (y, s_c * c, s_i * i, SG * g, l, w)] + [r])
        k = (1 - DELTA) * k + DELTA * i
        g = rho * g
    return filas


def main():
    aqui = os.path.dirname(os.path.abspath(__file__))
    destino = os.path.join(aqui, '..', 'datos', 'irf-rbc-gasto.csv')
    casos = {'sf95': resolver(0.95, False), 'sf0': resolver(0.0, False), 'tl95': resolver(0.95, True)}
    cab = ('# Modelo de ciclo real con gasto público (Baxter y King, 1993), log-linealizado y resuelto con el método de '
           'Blanchard y Kahn (script irf-rbc-gasto.py). Aumento del gasto del 1 % del PIB de estado estacionario en t = 0. '
           'Y, C, I y G en puntos del PIB de estado estacionario; L y w en %; r en puntos porcentuales anualizados. '
           'Casos: sf95 = suma fija, rho_G = 0.95; sf0 = suma fija, rho_G = 0; tl95 = impuesto sobre el trabajo con '
           'presupuesto equilibrado, rho_G = 0.95. Calibración trimestral: alfa = 1/3, beta = 0.99, delta = 0.025, '
           'phi = 1, utilidad logarítmica en el consumo, G/Y = 0.20. Cálculo propio, 05/11/2026.\n')
    nombres = ['y', 'c', 'i', 'g', 'l', 'w', 'r']
    with open(destino, 'w', encoding='utf-8', newline='\n') as f:
        f.write(cab)
        f.write('t,' + ','.join(f'{n}_{c}' for c in casos for n in nombres) + '\n')
        for t in range(T + 1):
            f.write(','.join([str(t)] + [f'{v:.4f}' for c in casos for v in casos[c][t][1:]]) + '\n')
    print('escrito', os.path.normpath(destino))


if __name__ == '__main__':
    main()
