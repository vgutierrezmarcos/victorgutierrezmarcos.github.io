#!/usr/bin/env python3
"""Índices de poder de voto (Shapley-Shubik y Banzhaf) de los 27 Estados en el
Consejo de la UE con la mayoría cualificada del art. 16.4 TUE y 238.3 TFUE
(cifras de población de 2026, Decisión 2025/2427). Coalición ganadora: al
menos 15 Estados (55 %) que reúnan al menos el 65 % de la población, o al menos
24 Estados (la minoría de bloqueo exige al menos 4). Programación dinámica
sobre (número de miembros, población en miles). Uso: python3 poder-voto.py
Escribe poder-voto.csv junto a este fichero.
Autor: Víctor Gutiérrez Marcos
"""
import csv, math, os
import numpy as np

AQUI = os.path.dirname(os.path.abspath(__file__))
filas = [r for r in csv.DictReader(l for l in open(os.path.join(AQUI, 'consejo-poblacion-escanos.csv'), encoding='utf-8') if not l.startswith('#'))]
n = len(filas)
UNIDAD = 1000
pob = np.array([int(r['poblacion']) for r in filas])
w = np.rint(pob / UNIDAD).astype(int)
total = int(pob.sum())
umbral = math.ceil(0.65 * total / UNIDAD)  # en miles
P = int(w.sum())

def gana(k, p):
    return (k >= 15 and p >= umbral) or k >= 24

ss = np.zeros(n); bz = np.zeros(n)
fact = [math.factorial(i) for i in range(n + 1)]
for i in range(n):
    otros = [w[j] for j in range(n) if j != i]
    # c[k, p]: número de coaliciones de k Estados (sin i) con población p
    c = np.zeros((n, P + 1), dtype=np.float64)
    c[0, 0] = 1
    for wj in otros:
        c[1:, wj:] += c[:-1, :P + 1 - wj].copy()
    for k in range(n):
        fila = c[k]
        if not fila.any():
            continue
        p = np.arange(P + 1)
        gana_con = ((k + 1 >= 15) & (p + w[i] >= umbral)) | (k + 1 >= 24)
        gana_sin = ((k >= 15) & (p >= umbral)) | (k >= 24)
        piv = gana_con & ~gana_sin
        m = fila[piv].sum()
        bz[i] += m
        ss[i] += m * fact[k] * fact[n - k - 1] / fact[n]
bz_abs = bz / 2 ** (n - 1)
bz_norm = bz / bz.sum()
with open(os.path.join(AQUI, 'poder-voto.csv'), 'w', encoding='utf-8') as f:
    f.write('# Cálculo propio con poder-voto.py a partir de consejo-poblacion-escanos.csv (población de 2026, Decisión 2025/2427 del Consejo). Población en miles para el cálculo.\n')
    f.write('# Columnas: cuota de población (%), cuota de Estados (%), Shapley-Shubik (%), Banzhaf normalizado (%), Banzhaf absoluto (probabilidad de ser decisivo, %).\n')
    f.write('codigo,pais,poblacion,ss,bznorm,bzabs,estados\n')
    for r, pp, a, b, c_ in zip(filas, pob, ss, bz_norm, bz_abs):
        f.write(f"{r['codigo']},{r['pais']},{100*pp/total:.2f},{100*a:.2f},{100*b:.2f},{100*c_:.3f},{100/n:.2f}\n")
print('suma SS', ss.sum())
for r, pp, a, b, c_ in zip(filas, pob, ss, bz_norm, bz_abs):
    print(f"{r['codigo']} pob {100*pp/total:5.2f}  SS {100*a:5.2f}  BZn {100*b:5.2f}  BZabs {100*c_:6.3f}")
