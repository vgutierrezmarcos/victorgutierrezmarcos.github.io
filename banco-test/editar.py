#!/usr/bin/env python3
"""editar.py < ediciones.json : [[id, campo, viejo, nuevo], …]; campo = enunciado | a | b | c | d | clave | desarrollo | dificultad (nuevo = número, viejo se ignora)."""
import json, sys, glob
W = '/mnt/c/Users/vgutierrez/Documents/src/victorgutierrezmarcos.github.io-revision/banco-test/'
eds = json.load(sys.stdin)
for f in sorted(glob.glob(W + '*.json')):
    d = json.load(open(f, encoding='utf-8')); toca = False
    for p in d['preguntas']:
        for i, campo, viejo, nuevo in eds:
            if p['id'] != i: continue
            if campo == 'dificultad': p['dificultad'] = nuevo; toca = True; print('ok', i, campo); continue
            o, k = (p, 'enunciado') if campo == 'enunciado' else (p['opciones'], campo) if campo in 'abcd' else (p['explicacion'], campo)
            if o[k].count(viejo) != 1: print('NO APLICA', i, campo, repr(viejo[:50])); continue
            o[k] = o[k].replace(viejo, nuevo); toca = True; print('ok', i, campo)
    if toca: json.dump(d, open(f, 'w', encoding='utf-8'), ensure_ascii=False, indent=1)
