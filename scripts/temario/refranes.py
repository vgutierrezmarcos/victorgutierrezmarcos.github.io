#!/usr/bin/env python3
"""Refranes de los temas: enganche de la introducción, idea final y ficha.

Saca de cada tema del 3.er ejercicio el bloque «Enganche» de la introducción,
el bloque «Idea final» de la conclusión y la línea «Enganche» de la ficha de
repaso, y los deja en oposicion/temario/canon/refranes.md para revisar que el
refrán cuadra con la historia que se cuenta y que no se repite (CRITERIOS §2,
«Refrán inicial único»).

    python3 scripts/temario/refranes.py            # escribe canon/refranes.md
    python3 scripts/temario/refranes.py --json     # además, canon/refranes.json
    python3 scripts/temario/refranes.py 3A08       # solo imprime ese tema

Autor: Víctor Gutiérrez Marcos
"""
import json
import os
import re
import sys

R = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
FUENTES = os.path.join(R, 'oposicion', 'temario', 'fuentes')
SALIDA = os.path.join(R, 'oposicion', 'temario', 'canon', 'refranes.md')


def limpiar(t):
    """LaTeX → texto legible (aproximado, solo para revisar)."""
    t = re.sub(r'(?<!\\)%[^\n]*', '', t)
    t = re.sub(r'\\(?:nocite|label|footnote)\{(?:[^{}]|\{[^{}]*\})*\}', '', t)
    t = re.sub(r'\\(?:textcite|parencite)\*?(?:\[[^\]]*\])*\{([^{}]*)\}', r'[\1]', t)
    t = re.sub(r'\\vertema\{([^{}]*)\}', r'[ver tema \1]', t)
    t = re.sub(r'\\(?:textbf|emph|concepto|autor|textit|textsc)\{((?:[^{}]|\{[^{}]*\})*)\}', r'\1', t)
    t = re.sub(r'\\(?:begin|end)\{itemize\}', '', t)
    t = t.replace('\\item', '\n-').replace('~', ' ').replace('\\,', ' ')
    t = re.sub(r'\\[a-zA-Z]+\*?', '', t)
    t = re.sub(r'[{}]', '', t)
    return '\n'.join(re.sub(r'\s+', ' ', l).strip() for l in t.split('\n') if l.strip(' -'))


def bloque(tex, rotulo, fin):
    m = re.search(r'\\item\s*\\textbf\{\\emph\{' + rotulo + r'\}\}:?(.*?)' + fin, tex, re.S)
    return m.group(1) if m else ''


def refran(texto):
    r = re.search(r'«([^»]{6,220})»', texto)
    return r.group(1).strip() if r else ''


def _raices(texto):
    """Raíces de 4 letras de las palabras de 4 o más (arrima/arrime, maestro/maestros)."""
    import unicodedata
    t = unicodedata.normalize('NFD', texto.lower())
    t = ''.join(c for c in t if unicodedata.category(c) != 'Mn')
    return {w[:4] for w in re.findall(r'[a-zñ]{4,}', t)}


def retoma(ref, texto):
    """El texto recoge el refrán si aparecen al menos el 75 % de sus raíces."""
    r = _raices(ref)
    return bool(r) and len(r & _raices(texto)) >= 0.75 * len(r)


def leer_tema(t):
    d = os.path.join(FUENTES, t)
    ruta = os.path.join(d, f'{t}.tex')
    if not os.path.exists(ruta):
        return None
    tex = re.sub(r'(?m)^[ \t]*%[^\n]*\n', '', open(ruta, encoding='utf-8').read())   # sin líneas de comentario
    eng = bloque(tex, 'Enganche', r'(?=\\item\s*\\textbf\{\\emph\{(?:Relevancia|Contexto|Objeto)|\\section)')
    fin = bloque(tex, 'Idea final', r'(?=\\end\{itemize\}\s*(?:\\end\{itemize\}|\\clearpage|\\appendix|\\section|$))')
    ficha = ''
    rf = os.path.join(d, 'repaso', f'{t}-repaso.tex')
    if os.path.exists(rf):
        m = re.search(r'\\item\s*\\textbf\{Enganche\}:?(.*?)(?=\n\\item|\n\\end)', open(rf, encoding='utf-8').read(), re.S)
        ficha = m.group(1) if m else ''
    titulo = ''
    m = re.search(r'\\tcetitulo\{((?:[^{}]|\{[^{}]*\})*)\}|\\title\{((?:[^{}]|\{[^{}]*\})*)\}', tex)
    if m:
        titulo = limpiar(m.group(1) or m.group(2))
    return {
        'tema': t, 'titulo': titulo,
        'refran': refran(eng), 'enganche': limpiar(eng),
        'idea_final': limpiar(fin), 'ficha': limpiar(ficha),
        'retoma_en_final': retoma(refran(eng), limpiar(fin)),
        'en_ficha': retoma(refran(eng), limpiar(ficha)),
    }


def main():
    args = [a for a in sys.argv[1:] if not a.startswith('--')]
    temas = sorted(x for x in os.listdir(FUENTES) if re.fullmatch(r'3[AB]\d\d', x))
    if args:
        for t in args:
            print(json.dumps(leer_tema(t.replace('.', '').upper()), ensure_ascii=False, indent=2))
        return
    filas = [f for f in (leer_tema(t) for t in temas) if f]
    vistos = {}
    for f in filas:
        vistos.setdefault(f['refran'].lower(), []).append(f['tema'])
    rep = {k: v for k, v in vistos.items() if k and len(v) > 1}
    sin = [f['tema'] for f in filas if not f['refran']]
    lin = ['# Refranes de los temas (enganche, idea final y ficha)', '',
           'Generado con `python3 scripts/temario/refranes.py`. No editar a mano.', '',
           f'- Temas: {len(filas)}; sin refrán entre «»: {len(sin)} ({", ".join(sin) or "ninguno"})',
           f'- Refranes iniciales repetidos: {len(rep)}' + (''.join(f'\n  - «{k}»: {", ".join(v)}' for k, v in rep.items())),
           f'- No retomados en la idea final (por texto): {", ".join(f["tema"] for f in filas if f["refran"] and not f["retoma_en_final"]) or "ninguno"}',
           f'- Ficha sin el refrán: {", ".join(f["tema"] for f in filas if f["refran"] and not f["en_ficha"]) or "ninguna"}', '']
    for f in filas:
        lin += [f'## {f["tema"]} · {f["titulo"]}', '', f'**Refrán**: «{f["refran"]}»', '',
                '**Enganche**:', '', f['enganche'], '', '**Idea final**:', '', f['idea_final'], '',
                f'**Ficha**: {f["ficha"] or "—"}', '']
    open(SALIDA, 'w', encoding='utf-8').write('\n'.join(lin))
    if '--json' in sys.argv:
        json.dump(filas, open(SALIDA[:-3] + '.json', 'w', encoding='utf-8'), ensure_ascii=False, indent=1)
    print('\n'.join(lin[4:9]))
    print(f'→ {os.path.relpath(SALIDA, R)}')


if __name__ == '__main__':
    main()
