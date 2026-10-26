# Solución de máximos del examen de ejemplo de España (1D01, entregable 5)

Solución *de máximos* del examen de ejemplo completo del dictamen de coyuntura sobre España
(`../examen-espana.pdf`, 7 preguntas que recorren todos los bloques de la guía, 2 horas). Aplica toda la guía
(`../../1D01.tex`) y remite a sus apartados. **No se publica** (vive en la rama
`revision-temario`; Víctor decide cuándo).

## Cómo está hecha

- **Texto de examen** (raya morada a la izquierda, entorno `examen`): lo que escribiría un
  opositor excelente, con frase de diagnóstico, rótulos por subpregunta y cifras citadas por
  su cuadro o gráfico del cuadernillo.
- **Cuadros complementarios** (fondo gris y raya dorada, entorno `complemento`): por qué se
  dice cada cosa, qué apartado de la guía se aplica, cálculos, gráficos que el examen no
  trae, errores típicos, alternativas de redacción, qué añadir con más tiempo y qué recortar
  en el examen.
- **Pesos** (de `../notas-para-la-solucion.md`): alto en 1 (×1,25), 2, 4, 6 y 7; medio en 3; bajo en 5. La tabla 1
  da el reparto de 2 horas con la regla de la guía (12 minutos de lectura, 6 de repaso; 18, 15, 14, 15, 10, 15 y 15
  minutos por pregunta), las palabras del texto de máximos (`contar-palabras.py`) y las que serían realistas a mano
  (≈ 22 por minuto).
- **Texto de examen solo con el cuadernillo**: lo externo (normas, NAWRU, colchón anticíclico, supuestos) está en los
  cuadros «Contexto y fuentes» de cada pregunta.
- **Datos del FMI** (26/10/2026): los cuadros anuales y las previsiones del cuadernillo son ahora del FMI (WEO de octubre de 2026 y artículo IV de 2026). Cada pregunta tiene un cuadro «El diagnóstico del FMI» con el artículo IV (IMF Country Report 26/102, en `~/.local/share/oposicion-web/fmi/`) citado por página; los Selected Issues de 2026 (26/103) no se pudieron descargar (acceso denegado).
- **Maquetación**: salto de página antes de cada pregunta, sin líneas viudas ni huérfanas, un anexo de cálculos al final y ningún nombre de fichero en el PDF.
- **Cifras**: todas del cuadernillo (`../datos/*.csv`, consulta 26/10/2026). Lo externo
  (NAWRU, colchón anticíclico, requisitos del MUS, FMI) va citado con `1D01.bib`.

## Ficheros

| Ruta | Qué es |
|---|---|
| `solucion-espana.tex` / `.pdf` | Documento principal (preámbulo, cajas propias) |
| `secciones/p00-introduccion.tex` | Cómo leer la solución, retos, tabla del reparto y la lectura del cuadernillo |
| `secciones/p01.tex` … `p07.tex` | Una pregunta por fichero: enunciado, texto de examen y cuadros complementarios |
| `secciones/palabras-*.tex` | Palabras del texto de examen (las escribe `contar-palabras.py`; no se editan) |
| `calculos.py` → `calculos.txt`, `datos/s0*.csv` | Todos los cálculos que cita el texto y los datos de los gráficos propios |
| `descargar-ipca.py` → `datos/ipca-mensual-2007.csv` | IPCA mensual de España y la zona del euro desde 2007 (Eurostat) para el gráfico s07 a largo plazo |
| `graficos/s01…s09-*.tex` / `.pdf` | Gráficos propios (pgfplots, paleta `dic…` de `latex/tikz-tcee.tex` + `graficos/colores-solucion.tex`, capas `\capa{n}` para el vídeo) |
| `notas-para-el-video.md` | Bloques del vídeo de 1 h 30 min de la solución |
| `compilar.sh` | Compila gráficos y documento |

Las infografías de la guía (árbol del déficit corriente, semáforo de la banca, *policy mix*,
tipos de paro, canales de un choque externo, del dato a la recomendación); la de los umbrales se rehace en `graficos/s09` con la posición de España se toman
de `../../graficos/*.pdf` sin copiarlas.

## Cómo se compila

Desde esta carpeta (WSL), con el MiKTeX de Windows de `scripts/temario/` y
`oposicion/temario/latex` en `TEXINPUTS`:

```bash
./compilar.sh            # cálculos + gráficos + palabras + documento (pdflatex, biber, pdflatex ×2)
./compilar.sh graficos   # solo calculos.py y los gráficos
./compilar.sh texto      # solo contar-palabras.py y el documento
```

A mano, lo mismo que hace el script:

```bash
python3 -I calculos.py && python3 -I contar-palabras.py
MIK=/mnt/c/Users/vgutierrez/AppData/Local/Programs/MiKTeX/miktex/bin/x64
LAT=$(wslpath -w ../../../../latex)
(cd graficos && for f in s*.tex; do TEXINPUTS="$LAT//;" WSLENV=TEXINPUTS "$MIK/pdflatex.exe" \
  -interaction=nonstopmode -output-directory=_aux "$f"; cp "_aux/${f%.tex}.pdf" .; done)
TEXINPUTS="$LAT//;" WSLENV=TEXINPUTS "$MIK/pdflatex.exe" -output-directory=_aux solucion-espana.tex
"$MIK/biber.exe" --input-directory _aux --output-directory _aux solucion-espana
# y 2 pasadas más de pdflatex; el PDF se copia de _aux/
```

Los gráficos leen sus CSV con rutas relativas (`../datos/…`): se compilan desde
`graficos/`. El documento busca los gráficos en `graficos/` y en `../../graficos/` y la
bibliografía en `../../1D01.bib`.

## Cuando cambien los datos (previsiones de otoño, 17/11/2026)

1. Rehacer el cuadernillo (`../README.md`, «Pendiente: previsiones de otoño»).
2. `python3 descargar-ipca.py` y `./compilar.sh` (recalcula `calculos.txt` y los CSV de los gráficos).
3. Comparar `calculos.txt` con la versión anterior (`git diff`) y corregir en
   `secciones/p*.tex` las cifras que cambien: sobre todo previsiones, brecha, potencial,
   saldos estructurales y deuda (preguntas 1, 6 y 7) y la tabla de saldos de la pregunta 6.
4. Recolocar a mano los rótulos de `graficos/s01`, `s03`, `s06`, `s07`, `s08` y `s09` si se mueven los puntos.
