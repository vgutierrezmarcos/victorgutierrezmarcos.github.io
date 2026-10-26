# Examen de ejemplo del dictamen: España (1D01, entregable 3)

Examen de ejemplo del dictamen de coyuntura (primer ejercicio, segunda parte) con el
formato de la convocatoria de 2026 (1 h 45 min, cinco cuestiones, cuadernillo de cuadros
y gráficos), con **datos reales y oficiales de España** disponibles el 26/10/2026.
No se publica (de momento solo se publican las guías): vive en la rama `revision-temario`.

## Ficheros

| Ruta | Qué es |
|---|---|
| `examen-espana.tex` / `.pdf` | El examen: instrucciones, enunciado, 8 cuadros y 12 gráficos (9 páginas) |
| `datos/descargar.py` | Descarga todo de las API oficiales (Eurostat, AMECO, BCE, Comext) y escribe los CSV |
| `datos/fuentes_api.py` | Acceso a las API (sin dependencias externas) |
| `datos/verificar.py` → `datos/verificacion.csv` | Segunda comprobación de las cifras clave con otra fuente o cálculo |
| `datos/cuadroN.csv`, `datos/gNN-*.csv` | Datos de cada cuadro y gráfico (cabecera `#` con fuente, códigos y fecha de consulta) |
| `datos/extra-deuda-privada-vivienda.csv` | Serie que no va en el cuadernillo (útil para la solución) |
| `datos/fuentes.md` | Cada serie con su código, su fuente y la fecha de consulta |
| `datos/actualizaciones.txt` | Fecha de actualización de cada conjunto de datos según su API |
| `generar_cuadros.py` → `cuadros/*.tex` | Escribe los cuadros en LaTeX desde los CSV (no se editan a mano) |
| `graficos/gNN-*.tex` | Gráficos en pgfplots (paleta `dic…` de `latex/tikz-tcee.tex` y colores añadidos en el preámbulo del examen) |
| `notas-para-la-solucion.md` | La historia de los datos por pregunta, cuadros y fórmulas de la guía que aplica cada una |

## Cómo se rehace

Desde esta carpeta (WSL):

```bash
cd datos && python3 -I descargar.py && python3 -I verificar.py && cd ..   # datos (unos minutos)
python3 -I generar_cuadros.py                                              # cuadros/*.tex
```

## Cómo se compila

MiKTeX de Windows (el mismo que usan los scripts de `scripts/temario/`), con
`oposicion/temario/latex` en `TEXINPUTS` (para `tikz-tcee.tex`); dos pasadas para
«Página X de N». Desde WSL, en esta carpeta:

```bash
MIK=/mnt/c/Users/vgutierrez/AppData/Local/Programs/MiKTeX/miktex/bin/x64
LAT=$(wslpath -w ../../../latex)
for i in 1 2; do
  TEXINPUTS="$LAT//;" WSLENV=TEXINPUTS "$MIK/pdflatex.exe" -interaction=nonstopmode -halt-on-error \
    -output-directory=_aux examen-espana.tex
done
cp _aux/examen-espana.pdf .
```

(En Windows: `set TEXINPUTS=<ruta>\oposicion\temario\latex//;` y `pdflatex examen-espana.tex` dos veces.)
Los CSV se leen con rutas relativas (`datos/…`): hay que compilar desde esta carpeta.
