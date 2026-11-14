#!/usr/bin/env python3
"""Ordena saldos-netos.csv por el saldo operativo de 2025 (% de la RNB) para
el gráfico saldos-netos. Uso: python3 datos/saldos-ordenar.py
Autor: Víctor Gutiérrez Marcos"""
import csv, os
d = os.path.dirname(os.path.abspath(__file__))
filas = [r for r in csv.reader(open(os.path.join(d, 'saldos-netos.csv'), encoding='utf-8')) if r and not r[0].startswith('#')]
cab, datos = filas[0], [dict(zip(filas[0], r)) for r in filas[1:]]
datos.sort(key=lambda r: float(r['saldo2025_rnb']))
with open(os.path.join(d, 'saldos-netos-2025.csv'), 'w', encoding='utf-8') as f:
    f.write('# Ordenado por saldo2025_rnb a partir de saldos-netos.csv (ver su cabecera: fuente, metodología y fecha). Generado por saldos-ordenar.py.\n')
    f.write('# es = 1 para España (barra en otro color). Unidades: % de la RNB.\n')
    f.write('n,pais,codigo,saldo,saldo_ngeu,es\n')
    for i, r in enumerate(datos):
        f.write(f"{i},{r['pais']},{r['codigo']},{r['saldo2025_rnb']},{r['saldo_ngeu2025_rnb']},{1 if r['codigo']=='ES' else 0}\n")
