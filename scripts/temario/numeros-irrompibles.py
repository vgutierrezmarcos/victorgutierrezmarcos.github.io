#!/usr/bin/env python3
"""Une con espacio irrompible (~) un número y la palabra que le sigue: «4 ganancias» → «4~ganancias».

Uso: numeros-nbsp.py [--aplicar] ficheros.tex…
No toca comentarios, fórmulas, argumentos de \\label, \\ref, citas, URL, gráficos ni entornos tikz.
No toca años (1000-2099 sin separadores) ni números pegados a otro (3.A.4, 2/3, x2)."""
import re, sys

aplicar = '--aplicar' in sys.argv
ficheros = [a for a in sys.argv[1:] if not a.startswith('--')]

ZONAS = [
    r'(?<!\\)%[^\n]*',
    r'\\begin\{(equation|align|gather|multline|tikzpicture|tabular|verbatim)\*?\}.*?\\end\{\1\*?\}',
    r'\$\$.*?\$\$', r'(?<!\\)\\\[.*?\\\]', r'(?<!\\)\$[^$\n]*\$', r'\\\(.*?\\\)',
    r'\\(?:label|ref|eqref|autoref|cref|nameref|hyperref|hypertarget|vertema|vertemacorto|\w*cite\w*|url|href'
    r'|includegraphics|grafico|graficorepaso|minutos|tiempo|esqtiempo|input|bibliography\w*)\*?(?:\[[^\]]*\])?\{[^}]*\}',
]
NUM = re.compile(r'(?<![\w.,/\\\-–+^_{])(\d+(?:[.,]\d+)*)( )(?=[a-záéíóúüñA-ZÁÉÍÓÚÑ]|\\(?:emph|textit|textbf|concepto|autor|uline|textsc)\{)')

total = 0
for f in ficheros:
    tx = open(f, encoding='utf-8').read()
    zonas = []
    for z in ZONAS:
        zonas += [(m.start(), m.end()) for m in re.finditer(z, tx, re.S)]
    zonas.sort()

    def libre(p):
        return not any(a <= p < b for a, b in zonas)
    cambios = []
    for m in NUM.finditer(tx):
        n = m.group(1)
        if re.fullmatch(r'1\d{3}|20\d{2}', n):
            continue
        if libre(m.start()):
            cambios.append(m.start(2))
    if cambios:
        total += len(cambios)
        nuevo = list(tx)
        for p in cambios:
            nuevo[p] = '~'
        if aplicar:
            open(f, 'w', encoding='utf-8').write(''.join(nuevo))
        if '--ver' in sys.argv:
            for p in cambios[:8]:
                print(f, repr(tx[max(0, p - 25):p + 20]))
    print(f'{f}: {len(cambios)}')
print('total', total)
