#!/usr/bin/env python3
"""Ordena mrr-paises.csv por los fondos recibidos en % del PIB y separa
subvenciones y préstamos (en % del PIB) para el gráfico mrr-paises.
Uso: python3 datos/mrr-ordenar.py
Autor: Víctor Gutiérrez Marcos"""
import csv, os
d = os.path.dirname(os.path.abspath(__file__))
filas = [r for r in csv.reader(open(os.path.join(d, 'mrr-paises.csv'), encoding='utf-8')) if r and not r[0].startswith('#')]
datos = [dict(zip(filas[0], r)) for r in filas[1:] if r[1] != 'UE27']
datos.sort(key=lambda r: float(r['recib_pib']))
with open(os.path.join(d, 'mrr-paises-orden.csv'), 'w', encoding='utf-8') as f:
    f.write('# Ordenado por recib_pib a partir de mrr-paises.csv (ver su cabecera: Eurostat gov_rrf_fa, fondos recibidos 2020-2025). Generado por mrr-ordenar.py.\n')
    f.write('# subv_pib y prest_pib: reparto de recib_pib en proporción a subvenciones y préstamos recibidos. es = 1 para España. Unidades: % del PIB de 2025.\n')
    f.write('n,pais,codigo,subv_pib,prest_pib,total_pib,es\n')
    for i, r in enumerate(datos):
        t, s = float(r['recib_total']), float(r['recib_subv'])
        p = float(r['recib_pib'])
        f.write(f"{i},{r['pais']},{r['codigo']},{p*s/t:.2f},{p*(t-s)/t:.2f},{p:.2f},{1 if r['codigo']=='ES' else 0}\n")
