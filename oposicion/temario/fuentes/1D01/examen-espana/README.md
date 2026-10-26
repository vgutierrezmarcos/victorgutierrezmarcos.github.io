# Examen de ejemplo completo del dictamen: España (1D01, entregable 3)

Examen de ejemplo **completo** del dictamen de coyuntura (primer ejercicio, segunda parte): una pregunta por
cada bloque de la guía (I perfil cíclico; II mercados de factores: trabajo y productividad, capital y crédito;
III competitividad precio y no precio; IV sector exterior; V políticas monetaria, macroprudencial y fiscal;
VI desequilibrios y recomendaciones), diez en total, con la redacción del tribunal y el formato de 2026 salvo el
número de preguntas y el tiempo (3 h 30 min orientativas; la portada lo explica). **Datos reales y oficiales de
España** disponibles el 26/10/2026. No se publica (de momento solo se publican las guías): vive en la rama
`revision-temario`.

## Ficheros

| Ruta | Qué es |
|---|---|
| `examen-espana.tex` / `.pdf` | El examen: instrucciones y reparto del tiempo, enunciado, 10 cuadros (1-9 y 2 bis) y 14 gráficos (10 páginas) |
| `datos/descargar.py` | Descarga todo de las API oficiales (Eurostat, AMECO, BCE, Comext) y escribe los CSV |
| `datos/fuentes_api.py` | Acceso a las API (sin dependencias externas; reintenta si falla la red) |
| `datos/verificar.py` → `datos/verificacion.csv` | Segunda comprobación de las cifras clave con otra fuente o cálculo |
| `datos/cuadroN.csv`, `datos/gNN-*.csv` | Datos de cada cuadro y gráfico (cabecera `#` con fuente, códigos y fecha de consulta; el número del fichero es el del cuadro o gráfico) |
| `datos/escribir_fuentes.py` → `datos/fuentes.md` | Cada serie con su código, su fuente y su último dato; `fuentes-no-encontrado.md`, lo que no hay |
| `datos/actualizaciones.txt` | Fecha de actualización de cada conjunto de datos según su API |
| `generar_cuadros.py` → `cuadros/*.tex` | Escribe los cuadros en LaTeX desde los CSV (no se editan a mano) |
| `graficos/gNN-*.tex` | Gráficos en pgfplots (paleta `dic…` de `latex/tikz-tcee.tex` y colores añadidos en el preámbulo del examen) |
| `compilar.sh` | Compila con el MiKTeX de Windows y deja el PDF aquí |
| `notas-para-la-solucion.md` | Para la solución de máximos: la historia de los datos por pregunta, el peso de cada una y lo que aplica de la guía |

## Cómo se rehace

Desde esta carpeta (WSL):

```bash
cd datos && python3 -I descargar.py && python3 -I verificar.py && python3 -I escribir_fuentes.py && cd ..
python3 -I generar_cuadros.py        # cuadros/*.tex
./compilar.sh                        # examen-espana.pdf
```

## Cómo se compila

`compilar.sh` usa el MiKTeX de Windows (el mismo que `scripts/temario/`), con `oposicion/temario/latex` en
`TEXINPUTS` (para `tikz-tcee.tex`), dos pasadas («Página X de N») y auxiliares en `_aux/`. A mano:

```bash
MIK=/mnt/c/Users/vgutierrez/AppData/Local/Programs/MiKTeX/miktex/bin/x64
LAT=$(wslpath -w ../../../latex)
for i in 1 2; do TEXINPUTS="$LAT//;" WSLENV=TEXINPUTS "$MIK/pdflatex.exe" -interaction=nonstopmode \
  -output-directory=_aux examen-espana.tex; done; cp _aux/examen-espana.pdf .
```

Los CSV se leen con rutas relativas (`datos/…`): hay que compilar desde esta carpeta.

## Pendiente: previsiones de otoño (a partir del 17/11/2026)

Víctor decidió (26/10/2026) dejar las previsiones de primavera de la Comisión (AMECO, 21/05/2026) y actualizarlas
con las de **otoño de 2026**, que AMECO publica el **17/11/2026**. Pasos:

1. Comprobar en `https://economy-finance.ec.europa.eu/economic-research-and-databases/economic-databases/ameco-database_en`
   que la versión es la de otoño. Ojo: AMECO estrena interfaz y la antigua (`/ameco/wq/series`, la que usa
   `fuentes_api.ameco`) se retira antes de esa publicación; si deja de responder, adaptar `ameco()` a la nueva API.
2. Cambiar el texto «primavera de 2026» por el de otoño en `datos/descargar.py` (función `am` y notas de
   `ESTRUCTURA`), `generar_cuadros.py` (fuentes de los cuadros), `examen-espana.tex` (fuente del gráfico 13) y
   `datos/fuentes-no-encontrado.md`.
3. Volver a descargar todo (también habrá datos nuevos de Eurostat), `verificar.py` (los controles frente a AMECO
   deben seguir en «OK»), `escribir_fuentes.py`, `generar_cuadros.py` y `compilar.sh`; renderizar y revisar las
   páginas (los rótulos de los gráficos 3 y 13 están colocados a mano: si cambian los puntos, recolocarlos).
4. Repasar las cifras de `notas-para-la-solucion.md` (previsiones, brecha, saldos estructurales, deuda) y, si ya
   existe, la solución de máximos.
