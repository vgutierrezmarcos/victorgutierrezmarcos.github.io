#!/usr/bin/env python3
"""Compila los gráficos de las explicaciones del test (botón «¿Por qué?» de la app).

Cada gráfico es un TikZ standalone en
oposicion/temario/primer-ejercicio/test/explicaciones/graficos/<id>[-n].tex con los
estilos del temario revisado (tikz-tcee.tex, de la rama revision-temario):

    \\documentclass[tikz,border=6pt]{standalone}
    \\input{tikz-tcee}
    \\begin{document}
    \\begin{tikzpicture}[tcee] … \\end{tikzpicture}
    \\end{document}

Se compila con el pdflatex de MiKTeX y se convierte a WebP (fondo blanco, la
app lo muestra sobre una tarjeta clara en los dos temas). Solo se publica el
.tex y el .webp; el PDF y los auxiliares se borran.

    python3 scripts/graficos-explicaciones.py            # los que han cambiado
    python3 scripts/graficos-explicaciones.py 969 969-2  # solo esos
    python3 scripts/graficos-explicaciones.py --todos    # todos

Necesita PyMuPDF y Pillow (p. ej. el venv-ocr de ~/.local/share/oposicion-web).
TCEE_LATEX cambia la carpeta de tikz-tcee.tex.
"""
import io
import os
import re
import subprocess
import sys
from pathlib import Path

import fitz  # PyMuPDF
from PIL import Image

RAIZ = Path(__file__).resolve().parents[1]
GRAFICOS = RAIZ / 'oposicion/temario/primer-ejercicio/test/explicaciones/graficos'
LATEX = os.environ.get('TCEE_LATEX', str(RAIZ) + '-revision/oposicion/temario/latex')
PDFLATEX = os.environ.get('TCEE_PDFLATEX', '/mnt/c/Users/vgutierrez/AppData/Local/Programs/MiKTeX/miktex/bin/x64/pdflatex.exe')
PPP = 220          # nitidez en pantallas de móvil
ANCHO_MAX = 1400   # px: los gráficos grandes se reducen


def ruta_windows(p):
    return subprocess.run(['wslpath', '-w', str(p)], capture_output=True, text=True, check=True).stdout.strip()


def errores_log(log):
    if not log.exists():
        return ['(sin log)']
    lineas = log.read_text(encoding='latin-1').splitlines()
    return [l for i, l in enumerate(lineas) if l.startswith('!') or (i and lineas[i - 1].startswith('!'))][:12] or lineas[-15:]


def compilar(tex):
    """Compila un .tex a .webp. Devuelve None si va bien o el texto del error."""
    base = tex.with_suffix('')
    env = dict(os.environ)
    env['TEXINPUTS'] = ruta_windows(LATEX) + '//;'
    env['WSLENV'] = ':'.join(filter(None, [env.get('WSLENV', ''), 'TEXINPUTS']))
    try:
        r = subprocess.run([PDFLATEX, '-interaction=nonstopmode', '-halt-on-error', tex.name],
                           cwd=GRAFICOS, env=env, capture_output=True, timeout=300)
        pdf = base.with_suffix('.pdf')
        if r.returncode != 0 or not pdf.exists():
            return '\n'.join(errores_log(base.with_suffix('.log')))
        doc = fitz.open(pdf)
        pix = doc[0].get_pixmap(dpi=PPP, alpha=False)
        doc.close()
        img = Image.open(io.BytesIO(pix.tobytes('png'))).convert('RGB')
        if img.width > ANCHO_MAX:
            img = img.resize((ANCHO_MAX, round(img.height * ANCHO_MAX / img.width)), Image.LANCZOS)
        img.save(base.with_suffix('.webp'), 'WEBP', quality=88, method=6)
        return None
    finally:
        for ext in ('.aux', '.log', '.pdf'):
            f = base.with_suffix(ext)
            if f.exists() and not (ext == '.log' and not base.with_suffix('.webp').exists()):
                f.unlink()


def main():
    args = [a for a in sys.argv[1:] if not a.startswith('--')]
    todos = '--todos' in sys.argv
    GRAFICOS.mkdir(parents=True, exist_ok=True)
    texs = sorted(GRAFICOS.glob('*.tex'))
    if args:
        texs = [GRAFICOS / f'{re.sub(r"\.tex$", "", a)}.tex' for a in args]
    fallos = 0
    for tex in texs:
        webp = tex.with_suffix('.webp')
        if not args and not todos and webp.exists() and webp.stat().st_mtime >= tex.stat().st_mtime:
            continue
        error = compilar(tex)
        if error:
            fallos += 1
            print(f'ERROR {tex.name}:\n{error}\n')
        else:
            w, h = Image.open(webp).size
            print(f'ok {webp.name} ({w}×{h}, {webp.stat().st_size // 1024} KB)')
    sys.exit(1 if fallos else 0)


if __name__ == '__main__':
    main()
