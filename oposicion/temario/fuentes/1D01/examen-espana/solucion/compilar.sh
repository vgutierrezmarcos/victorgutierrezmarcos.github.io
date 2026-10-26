#!/bin/bash
# Compila la solución de máximos del examen de España (1D01): primero los
# gráficos propios (graficos/s*.tex → PDF), después solucion-espana.tex con
# pdflatex + biber + pdflatex ×2. Usa el MiKTeX de Windows, como scripts/temario/,
# con oposicion/temario/latex en TEXINPUTS. Auxiliares en _aux/.
# Uso: ./compilar.sh            (todo)
#      ./compilar.sh graficos   (solo los gráficos)
#      ./compilar.sh texto      (solo el documento)
set -e
cd "$(dirname "$0")"
MIK=/mnt/c/Users/vgutierrez/AppData/Local/Programs/MiKTeX/miktex/bin/x64
LAT=$(wslpath -w ../../../../latex)
QUE=${1:-todo}
if [ "$QUE" != texto ]; then
  python3 -I calculos.py > /dev/null
  cd graficos
  mkdir -p _aux
  for f in s*.tex; do
    TEXINPUTS="$LAT//;" WSLENV=TEXINPUTS "$MIK/pdflatex.exe" -interaction=nonstopmode -halt-on-error \
      -output-directory=_aux "$f" > /dev/null || { echo "Error en $f"; grep -A6 '^!' "_aux/${f%.tex}.log"; exit 1; }
    cp "_aux/${f%.tex}.pdf" .
  done
  cd ..
  echo "Gráficos compilados."
fi
if [ "$QUE" != graficos ]; then
  python3 -I contar-palabras.py > /dev/null
  mkdir -p _aux
  P() { TEXINPUTS="$LAT//;" WSLENV=TEXINPUTS "$MIK/pdflatex.exe" -interaction=nonstopmode -halt-on-error \
      -output-directory=_aux solucion-espana.tex > /dev/null || { grep -A8 '^!' _aux/solucion-espana.log; exit 1; }; }
  P
  "$MIK/biber.exe" --input-directory _aux --output-directory _aux solucion-espana > /dev/null || { tail -20 _aux/solucion-espana.blg; exit 1; }
  P; P
  cp _aux/solucion-espana.pdf .
  echo "Avisos de cajas desbordadas: $(grep -c 'Overfull' _aux/solucion-espana.log || true)"
  grep -E 'undefined|Citation .* undefined|multiply' _aux/solucion-espana.log | head -20 || true
fi
