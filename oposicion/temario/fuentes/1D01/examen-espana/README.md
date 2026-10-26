# Examen de ejemplo completo del dictamen: España (1D01, entregable 3)

Examen de ejemplo **completo** del dictamen de coyuntura (primer ejercicio, segunda parte): todos los bloques
de la guía en 7 preguntas (Víctor, 26/10/2026): 1 perfil cíclico con la demanda privada y el crédito; 2 trabajo y
productividad; 3 sector exterior con la competitividad precio y no precio y los aranceles; 4 inflación y política
monetaria (como en 2016 y 2023); 5 banca y estabilidad financiera; 6 cuentas públicas y deuda; 7 desequilibrios y
reformas. Redacción del tribunal y formato de 2026 salvo el número de preguntas y el tiempo (2 horas orientativas;
la portada lo explica). **Datos reales y oficiales de
España** disponibles el 26/10/2026. No se publica (de momento solo se publican las guías): vive en la rama
`revision-temario`.

## Ficheros

| Ruta | Qué es |
|---|---|
| `examen-espana.tex` / `.pdf` | El examen: instrucciones y reparto del tiempo, enunciado, 10 cuadros (1-9 y 2 bis) y 14 gráficos (10 páginas) |
| `datos/fmi.py` → `datos/fmi-weo-2026-10.csv`, `datos/fmi-articulo-iv-2026.csv` | Descarga el WEO de octubre de 2026 (API SDMX del FMI) y extrae las tablas del Artículo IV de 2026 (PDF del FMI, con PyMuPDF); el PDF se guarda en `~/.local/share/oposicion-web/fmi/` |
| `datos/descargar.py` | Descarga Eurostat, BCE y Comext, aplica las filas del FMI (`aplicar_fmi`) y escribe los CSV |
| `datos/fuentes_api.py` | Acceso a las API (sin dependencias externas; reintenta si falla la red) |
| `datos/verificar.py` → `datos/verificacion.csv` | Segunda comprobación de las cifras clave con otra fuente o cálculo |
| `datos/cuadroN.csv`, `datos/gNN-*.csv` | Datos de cada cuadro y gráfico (cabecera `#` con fuente, códigos y fecha de consulta; el número del fichero es el del cuadro o gráfico) |
| `datos/escribir_fuentes.py` → `datos/fuentes.md` | Cada serie con su código, su fuente y su último dato; `fuentes-no-encontrado.md`, lo que no hay |
| `datos/actualizaciones.txt` | Fecha de actualización de cada conjunto de datos según su API |
| `generar_cuadros.py` → `cuadros/*.tex` | Escribe los cuadros en LaTeX desde los CSV (no se editan a mano) |
| `datos/rotulos_g13.py` | Reescribe el gráfico de orientación fiscal con los rótulos de los años colocados a mano |
| `graficos/gNN-*.tex` | Gráficos en pgfplots (paleta `dic…` de `latex/tikz-tcee.tex` y colores añadidos en el preámbulo del examen) |
| `compilar.sh` | Compila con el MiKTeX de Windows y deja el PDF aquí |
| `notas-para-la-solucion.md` | Para la solución de máximos (`solucion/`): la historia de los datos por pregunta, el peso de cada una y lo que aplica de la guía |

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

## Fuentes de los cuadros (decisión de Víctor, 26/10/2026)

Opción mixta: los **cuadros anuales salen del FMI** siempre que el FMI da la fila, como en los exámenes reales y en el
simulacro de Meridia: *World Economic Outlook* de octubre de 2026 (serie 2007-2025 y previsiones 2026-2027) y, donde el
WEO no llega, previsiones de la consulta del artículo IV de 2026 (IMF Country Report 26/102, 21/05/2026) sobre la historia
de Eurostat. Las filas que el FMI no da (componentes de la inversión, ramas, ratios bancarias con la comparación europea,
TCER, cuotas, vivienda, crédito, BCE…) siguen de Eurostat, el BCE o la EIA, y la fuente de cada cuadro lo dice. Los
gráficos mensuales y trimestrales siguen con Eurostat y el BCE. Se retiraron las previsiones y los saldos ajustados de la
Comisión (AMECO): el saldo ajustado de ciclo desaparece (el FMI no lo da y el de la Comisión no casa con su brecha) y el
saldo estructural primario es el estructural del FMI más los intereses.

## Pendiente: cuándo actualizar

1. **WEO de abril de 2027** (publicación a mediados de abril de 2027): nuevas previsiones 2027-2028 y datos de 2026.
   `python fmi.py` (con PyMuPDF) descarga el WEO vigente; cambiar «octubre de 2026» por «abril de 2027» en
   `datos/descargar.py` (`aplicar_fmi`, notas de `ESTRUCTURA`), `datos/fmi.py` (cabecera), `generar_cuadros.py` (fuentes)
   y `examen-espana.tex` (fuente del gráfico 13 de orientación fiscal y frase del enunciado), y mover el año de las
   previsiones (`P` en `generar_cuadros.py`, `A1` en `descargar.py`).
2. **Artículo IV de 2027** (normalmente entre mayo y julio de 2027): cambiar `ART4_URL` en `datos/fmi.py` por el PDF
   nuevo, comprobar que las páginas y los títulos de los cuadros 1, 2b y 4 siguen igual (`descargar_art4`) y volver a
   extraer.
3. En cualquiera de los dos casos: `descargar.py`, `verificar.py` (todo en «OK»), `escribir_fuentes.py`,
   `generar_cuadros.py`, `compilar.sh`; renderizar y revisar las páginas (los rótulos de los gráficos de Beveridge y de
   orientación fiscal están colocados a mano) y repasar las cifras de `notas-para-la-solucion.md` y de la solución.
