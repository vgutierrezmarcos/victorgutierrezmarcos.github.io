"""Escribe fuentes.md a partir de las cabeceras de los CSV (python3 -I escribir_fuentes.py)."""
import csv, glob, os
os.chdir(os.path.dirname(os.path.abspath(__file__)))
act = dict(l.rstrip('\n').split('\t') for l in open('actualizaciones.txt', encoding='utf-8') if not l.startswith('#'))
L = ['# Fuentes de los datos del examen de ejemplo de España (1D01)\n',
     'Consulta de todas las series: **26/10/2026** (salvo el Brent, copiado de la guía: 23/10/2026). Todo se descarga con `descargar.py` '
     'de las API oficiales; ninguna cifra se ha tecleado a mano. Las cifras clave se comprobaron dos veces con otra fuente o con '
     'otro cálculo (`verificar.py` → `verificacion.csv`: 14 comprobaciones, todas «OK»).\n',
     '## Accesos (API)\n',
     '- **Eurostat**, API de difusión: `https://ec.europa.eu/eurostat/api/dissemination/statistics/1.0/data/<código>?<filtros>` '
     '(navegador: `https://ec.europa.eu/eurostat/databrowser/view/<código>/default/table`). Comercio de bienes: API de Comext, '
     '`https://ec.europa.eu/eurostat/api/comext/dissemination/statistics/1.0/data/DS-045409`.',
     '- **Comisión Europea, AMECO** (previsiones de primavera de 2026, publicadas el 21/05/2026; versión de 03/06/2026; la siguiente, '
     'de otoño, el 17/11/2026): `https://ec.europa.eu/economy_finance/ameco/wq/series?fullVariable=<código>&countries=ESP`.',
     '- **Banco Central Europeo**, portal de datos: `https://data-api.ecb.europa.eu/service/data/<flujo>/<clave>`.',
     '- **EIA** (Brent, serie RBRTE), vía la guía 1D01 (`fuentes/1D01/datos/brent.csv`); comprobado con FRED (MCOILBRENTEU) el 26/10/2026.\n',
     '## Última actualización de cada conjunto de datos (según su API)\n', '| Conjunto | Actualizado |\n|---|---|']
for k, v in sorted(act.items()):
    L.append(f'| `{k}` | {v[:10] if v[:4].isdigit() else v} |')
L += ['', '## Cuadros: serie a serie\n']
for f in sorted(glob.glob('cuadro[1-9].csv')):
    head = [l[2:].strip() for l in open(f, encoding='utf-8') if l.startswith('#')]
    rows = list(csv.DictReader(l for l in open(f, encoding='utf-8') if not l.startswith('#')))
    L.append(f'### {head[0]} (`{f}`)\n')
    L += [f'- {h}' for h in head[1:]] + ['', '| id | Indicador | Fuente y código | Último dato |', '|---|---|---|---|']
    for r in rows:
        anios = [a for a in r if a[:2] == '20' and r[a]]
        hist = [a for a in anios if a <= '2025']; prev = [a for a in anios if a > '2025']
        ult = (hist[-1] + (f' (+ previsión {prev[0]}-{prev[-1]})' if prev else '')) if hist else '—'
        L.append(f"| `{r['id']}` | {r['indicador']} | {r['fuente']} | {ult} |")
    L.append('')
L.append('### Cuadro 2 bis (`cuadro2b-descomposicion.csv`)\n')
L += ['- ' + l[2:].strip() for l in open('cuadro2b-descomposicion.csv', encoding='utf-8') if l.startswith('#')]
L += ['', '## Gráficos (el número del fichero es el del gráfico)\n', '| Gráfico | CSV | Fuente, códigos y último dato |', '|---|---|---|']
for f in sorted(glob.glob('g[01]*.csv')):
    head = ' '.join(l[2:].strip() for l in open(f, encoding='utf-8') if l.startswith('#'))
    rows = list(csv.reader(l for l in open(f, encoding='utf-8') if not l.startswith('#')))
    L.append(f'| {int(f[1:3])} | `{f}` | {head} Último dato: {rows[-1][0]}. |')
L += ['', open('fuentes-no-encontrado.md', encoding='utf-8').read()]
open('fuentes.md', 'w', encoding='utf-8').write('\n'.join(L) + '\n')
