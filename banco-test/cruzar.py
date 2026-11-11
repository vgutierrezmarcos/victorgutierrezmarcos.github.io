#!/usr/bin/env python3
"""cruzar.py "310401=a 310402=c …": compara con la clave y lista las discrepancias."""
import json, sys, glob, re
W = '/mnt/c/Users/vgutierrez/Documents/src/victorgutierrezmarcos.github.io-revision/banco-test/'
clave = {p['id']: p['respuesta'][0] for f in glob.glob(W + '*.json') for p in json.load(open(f, encoding='utf-8'))['preguntas']}
r = dict((int(a), b) for a, b in re.findall(r'(\d{6})\s*=\s*([a-d])', ' '.join(sys.argv[1:])))
mal = [(i, clave.get(i), r[i]) for i in sorted(r) if clave.get(i) != r[i]]
print(len(r), 'cruzadas;', 'discrepancias (id, clave, ciego):', mal or 'ninguna')
