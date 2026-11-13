#!/usr/bin/env python3
"""ciegas.py 3A01 3A02 …: imprime las preguntas de esos temas SIN la clave ni la explicación."""
import json, sys
W = '/mnt/c/Users/vgutierrez/Documents/src/victorgutierrezmarcos.github.io-revision/banco-test/'
out = []
for t in sys.argv[1:]:
    d = json.load(open(W + t + '.json', encoding='utf-8'))
    out += [{'id': p['id'], 'tema': d['tema'], 'enunciado': p['enunciado'], 'opciones': p['opciones']} for p in d['preguntas']]
print(json.dumps(out, ensure_ascii=False, indent=1))
