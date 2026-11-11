#!/usr/bin/env python3
"""ver.py id [id…]: enseña enunciado, opciones y clave de esas preguntas."""
import json, sys, glob
W = '/mnt/c/Users/vgutierrez/Documents/src/victorgutierrezmarcos.github.io-revision/banco-test/'
ids = set(map(int, sys.argv[1:]))
for f in sorted(glob.glob(W + '*.json')):
    for p in json.load(open(f, encoding='utf-8'))['preguntas']:
        if p['id'] in ids:
            print(f"== {p['id']} [{p['respuesta'][0]}] {p['enunciado']}")
            for l, t in sorted(p['opciones'].items()): print(f'   {l}) {t}')
