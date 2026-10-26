"""Cuenta las palabras del texto de examen (entorno «examen») de cada pregunta
y escribe secciones/palabras-pNN.tex y palabras-total.tex para la tabla del
reparto. Uso: python3 -I contar-palabras.py (antes de compilar)."""
import os
import re

AQUI = os.path.dirname(os.path.abspath(__file__))
SEC = os.path.join(AQUI, 'secciones')


def limpiar(t):
    t = re.sub(r'(?<!\\)%.*', '', t)                     # comentarios
    t = re.sub(r'\$[^$]*\$', ' X ', t)                    # fórmulas en línea: 1 palabra
    t = re.sub(r'\\\[.*?\\\]', ' ', t, flags=re.S)        # fórmulas en display
    t = re.sub(r'\\(rotulo|textit|textbf|emph|uline|autor|concepto|tiempo)\b', ' ', t)
    t = re.sub(r'\\(begin|end)\{[^}]*\}', ' ', t)
    t = re.sub(r'\\[a-zA-Z]+\*?(\[[^\]]*\])?', ' ', t)    # otras órdenes
    t = t.replace('~', ' ').replace('{', ' ').replace('}', ' ').replace('\\%', '%')
    return [w for w in t.split() if re.search(r'[0-9A-Za-zÁÉÍÓÚÜÑáéíóúüñ]', w)]


total = 0
for n in range(1, 8):
    f = os.path.join(SEC, f'p{n:02d}.tex')
    texto = open(f, encoding='utf-8').read() if os.path.exists(f) else ''
    bloques = re.findall(r'\\begin\{examen\}(.*?)\\end\{examen\}', texto, flags=re.S)
    k = sum(len(limpiar(b)) for b in bloques)
    total += k
    with open(os.path.join(SEC, f'palabras-p{n:02d}.tex'), 'w', encoding='utf-8') as g:
        g.write(f'{k:,}'.replace(',', '.') + '%')
    print(f'Pregunta {n}: {k} palabras')
with open(os.path.join(SEC, 'palabras-total.tex'), 'w', encoding='utf-8') as g:
    g.write(f'\\textbf{{{total:,}}}'.replace(',', '.') + '%')
print('Total:', total)
