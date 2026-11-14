#!/usr/bin/env python3
"""Simulación de la devolución de la deuda del NextGenerationEU que corresponde
a las subvenciones (modelo del apartado III.3 del tema 3.B.37).
Supuestos: D0 = 421.000 M€ (parte no reembolsable del NGEU a precios
corrientes tras la reducción de enero de 2026, Tribunal de Cuentas Europeo,
informe anual 2025); amortización lineal de 2028 a 2058 (T = 31 años); tipo
medio i = 3 %; RNB de la UE de 2025 = 17,6 billones (el gasto sin MRR,
176.300 M€, fue el 1,0 % de la RNB según el TCE) que crece al 3,5 % nominal.
Uso: python3 datos/deuda-ngeu.py  (escribe datos/deuda-ngeu.csv)
Autor: Víctor Gutiérrez Marcos"""
import os
D0, T, i, g, Y2025 = 421000.0, 31, 0.033, 0.035, 17.6e6
d = os.path.dirname(os.path.abspath(__file__))
A = D0 / T
with open(os.path.join(d, 'deuda-ngeu.csv'), 'w', encoding='utf-8') as f:
    f.write('# Elaboración propia (simulación) con datos del Tribunal de Cuentas Europeo, informe anual 2025 (https://www.eca.europa.eu/ECAPublications/AR-2025-AIB/AR-2025-AIB_EN.pdf).\n')
    f.write('# Supuestos: deuda de la parte de subvenciones 421.000 M€; amortización lineal 2028-2058; tipo 3,3 %; RNB UE 2025 17,6 billones con crecimiento nominal del 3,5 %. Generado por deuda-ngeu.py el 14/11/2026.\n')
    f.write('# Unidades: deuda y carga en % de la RNB de la UE; carga_meur en millones de euros corrientes.\n')
    f.write('anio,deuda_rnb,carga_rnb,carga_meur\n')
    D = D0
    for anio in range(2027, 2059):
        Y = Y2025 * (1 + g) ** (anio - 2025)
        if anio == 2027:
            f.write(f'{anio},{100*D/Y:.3f},0,0\n'); continue
        C = A + i * D
        D -= A
        f.write(f'{anio},{100*D/Y:.3f},{100*C/Y:.4f},{C:.0f}\n')
