#!/bin/bash
# Compila examen-espana.tex con el MiKTeX de Windows (dos pasadas) y copia el PDF aquí.
set -e
cd "$(dirname "$0")"
MIK=/mnt/c/Users/vgutierrez/AppData/Local/Programs/MiKTeX/miktex/bin/x64
LAT=$(wslpath -w ../../../latex)
mkdir -p _aux
for i in 1 2; do
  TEXINPUTS="$LAT//;" WSLENV=TEXINPUTS "$MIK/pdflatex.exe" -interaction=nonstopmode -halt-on-error \
    -output-directory=_aux examen-espana.tex > /dev/null || { grep -A5 '^!' _aux/examen-espana.log; exit 1; }
done
cp _aux/examen-espana.pdf .
echo "Avisos de cajas desbordadas: $(grep -c 'Overfull' _aux/examen-espana.log || true)"
