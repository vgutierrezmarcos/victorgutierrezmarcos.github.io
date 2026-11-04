#!/usr/bin/env python3
"""
Funciones impulso-respuesta del modelo de ciclo real canónico (3.A.6, figuras
fig:irf-rbc y fig:irf-rbc-completo). Escribe ../datos/irf-rbc.csv.

Modelo (planificador = equilibrio competitivo):
    max E0 sum beta^t [ ln C_t - chi L_t^(1+phi)/(1+phi) ]
    Y_t = A_t K_t^alpha L_t^(1-alpha),   Y_t = C_t + I_t,
    K_{t+1} = (1-delta) K_t + I_t,       ln A_t = rho_A ln A_{t-1} + eps^A_t.
chi se fija para que las horas de estado estacionario sean L = 1/3.

Log-linealización (minúsculas: desviación logarítmica del estado estacionario):
    y = a + alpha k + (1-alpha) l
    phi l = w - c,  w = y - l                       (oferta y demanda de trabajo)
    c_t = E c_{t+1} - nu E (y_{t+1} - k_{t+1}),      nu = 1 - beta (1-delta)  (Euler)
    y = s_c c + s_i i,  s_i = delta K/Y,  K/Y = alpha / (1/beta - 1 + delta)
    k_{t+1} = (1-delta) k_t + delta i_t
    r_t: desviación del rendimiento bruto del capital, R = alpha Y/K + 1 - delta,
         dR_t = (1/beta - 1 + delta)(y_t - k_t); se da en puntos porcentuales
         anualizados (x 400).
Se resuelve con el método de Blanchard y Kahn: z' = M z con z = (k, a, c); el
autovector izquierdo del autovalor inestable da la función de política del
consumo, c = eta_ck k + eta_ca a.

Shock: una desviación típica de la innovación, eps^A_0 = sigma_eps = 0,007
(Hansen y Wright, 1992, que toman los valores de Prescott, 1986), en t = 0;
2 casos, rho_A = 0,95 y rho_A = 0 (ruido blanco). Respuestas en % de
desviación del estado estacionario (r en puntos porcentuales anualizados),
t = 0, ..., 40 trimestres.

Uso: python3 irf-rbc.py   (desde cualquier carpeta)
Autor: Víctor Gutiérrez Marcos
"""
import os

import numpy as np

ALFA, BETA, DELTA, PHI, L_EE = 1 / 3, 0.99, 0.025, 1.0, 1 / 3
SIGMA = 0.007
T = 40


def resolver(rho):
    ky = ALFA / (1 / BETA - 1 + DELTA)          # K/Y trimestral
    s_i = DELTA * ky
    s_c = 1 - s_i
    nu = 1 - BETA * (1 - DELTA)
    # horas: (phi + alpha) l = a + alpha k - c  -> y = a + alpha k + (1-alpha) l
    lk, la, lc = ALFA / (PHI + ALFA), 1 / (PHI + ALFA), -1 / (PHI + ALFA)
    yk, ya, yc = ALFA + (1 - ALFA) * lk, 1 + (1 - ALFA) * la, (1 - ALFA) * lc
    # z = (k, a, c): A z' = B z
    A = np.array([[1, 0, 0],
                  [0, 1, 0],
                  [-nu * (yk - 1), -nu * ya, 1 - nu * yc]])
    B = np.array([[(1 - DELTA) + DELTA * yk / s_i, DELTA * ya / s_i, DELTA * (yc - s_c) / s_i],
                  [0, rho, 0],
                  [0, 0, 1]])
    M = np.linalg.solve(A, B)
    val, izq = np.linalg.eig(M.T)               # autovectores izquierdos de M
    inest = [j for j in range(3) if abs(val[j]) > 1]
    assert len(inest) == 1, val                 # condición de Blanchard y Kahn
    q = np.real(izq[:, inest[0]])
    eta_ck, eta_ca = -q[0] / q[2], -q[1] / q[2]
    k, a = 0.0, SIGMA
    filas = []
    for t in range(T + 1):
        c = eta_ck * k + eta_ca * a
        l = la * a + lk * k + lc * c
        y = ya * a + yk * k + yc * c
        i = (y - s_c * c) / s_i
        w = y - l
        r = (1 / BETA - 1 + DELTA) * (y - k) * 400
        filas.append([t] + [100 * v for v in (a, y, c, i, l, w)] + [r])
        k = (1 - DELTA) * k + DELTA * i
        a = rho * a
    return filas, (eta_ck, eta_ca)


def main():
    aqui = os.path.dirname(os.path.abspath(__file__))
    destino = os.path.join(aqui, '..', 'datos', 'irf-rbc.csv')
    f95, p95 = resolver(0.95)
    f0, p0 = resolver(0.0)
    cab = ('# Modelo de ciclo real canónico (Kydland y Prescott, 1982; King, Plosser y Rebelo, 1988), '
           'log-linealizado y resuelto con el método de Blanchard y Kahn (script ../graficos/irf-rbc.py). '
           'Respuesta a un shock de productividad de una desviación típica, eps^A_0 = sigma_eps = 0.007, en t = 0, '
           'en % de desviación del estado estacionario (r en puntos porcentuales anualizados del rendimiento bruto del capital). '
           'Columnas *_95: rho_A = 0.95; *_0: rho_A = 0 (ruido blanco). '
           'Calibración trimestral: alfa = 1/3 (participación del capital; Prescott 1986); beta = 0.99 (tipo real anual del 4 %; Prescott 1986); '
           'delta = 0.025 (Hansen y Wright 1992); horas de estado estacionario L = 1/3 (Hansen y Wright 1992); '
           'utilidad ln C - chi L^(1+phi)/(1+phi) con phi = 1 (elasticidad de Frisch unitaria); '
           'rho_A = 0.95 y sigma_eps = 0.007 (Hansen y Wright 1992 con los valores de Prescott 1986). '
           f'Política del consumo: c = {p95[0]:.4f} k + {p95[1]:.4f} a (rho_A = 0.95); c = {p0[0]:.4f} k + {p0[1]:.4f} a (rho_A = 0). '
           'Cálculo propio, 04/11/2026.\n')
    nombres = ['a', 'y', 'c', 'i', 'l', 'w', 'r']
    with open(destino, 'w', encoding='utf-8', newline='\n') as f:
        f.write(cab)
        f.write('t,' + ','.join(f'{n}_95' for n in nombres) + ',' + ','.join(f'{n}_0' for n in nombres) + '\n')
        for a, b in zip(f95, f0):
            f.write(','.join([str(a[0])] + [f'{v:.4f}' for v in a[1:]] + [f'{v:.4f}' for v in b[1:]]) + '\n')
    print('escrito', os.path.normpath(destino))


if __name__ == '__main__':
    main()
