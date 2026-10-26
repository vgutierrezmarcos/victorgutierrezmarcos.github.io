"""Acceso a las API oficiales (Eurostat, AMECO de la Comisión, BCE) para el
examen de ejemplo de España (1D01). Solo lectura; sin dependencias externas."""
import json, re, urllib.request, urllib.error, urllib.parse, csv, io, functools, html

UA = {'User-Agent': 'Mozilla/5.0 (examen-espana 1D01)'}

def _get(url, timeout=90, intentos=5):
    import time
    for k in range(intentos):
        try:
            req = urllib.request.Request(url, headers=UA)
            with urllib.request.urlopen(req, timeout=timeout) as r:
                return r.read().decode('utf-8')
        except urllib.error.HTTPError:
            raise
        except Exception:
            if k == intentos - 1:
                raise
            time.sleep(10 * (k + 1))

@functools.lru_cache(maxsize=None)
def _eurostat_raw(ds, query):
    url = f'https://ec.europa.eu/eurostat/api/dissemination/statistics/1.0/data/{ds}?format=JSON&lang=EN&{query}'
    return json.loads(_get(url))

def eurostat(ds, since=None, **filtros):
    """Devuelve ({clave_serie: {periodo: valor}}, actualizado). La clave es una tupla
    con los valores de las dimensiones que no son 'time' y tienen más de un valor."""
    q = []
    for k, v in filtros.items():
        for x in (v if isinstance(v, (list, tuple)) else [v]):
            q.append((k, x))
    if since:
        q.append(('sinceTimePeriod', str(since)))
    d = _eurostat_raw(ds, urllib.parse.urlencode(q))
    ids, size = d['id'], d['size']
    dims = [d['dimension'][i]['category']['index'] for i in ids]
    inv = [{v: k for k, v in dm.items()} for dm in dims]
    out = {}
    for flat, val in d['value'].items():
        flat = int(flat); idx = []
        for s in reversed(size):
            idx.append(flat % s); flat //= s
        idx = list(reversed(idx))
        labs = [inv[j][idx[j]] for j in range(len(ids))]
        t = labs[ids.index('time')]
        key = tuple(labs[j] for j in range(len(ids)) if ids[j] != 'time' and size[j] > 1)
        out.setdefault(key, {})[t] = val
    return out, d.get('updated')

def eurostat1(ds, since=None, **f):
    out, upd = eurostat(ds, since, **f)
    assert len(out) == 1, (ds, f, list(out)[:5])
    return list(out.values())[0], upd

@functools.lru_cache(maxsize=None)
def ameco(var, country='ESP', years=tuple(range(2005, 2028))):
    url = ('https://ec.europa.eu/economy_finance/ameco/wq/series?fullVariable=' + var +
           f'&countries={country}&years=' + ','.join(map(str, years)) +
           '&defaultCountries=0&Lastyear=0&Yearorder=ASC')
    t = _get(url)
    heads = re.findall(r'<th>(.*?)</th>', t)
    cells = re.findall(r'<td[^>]*>(.*?)</td>', t)
    label = html.unescape(cells[1]); unit = html.unescape(cells[2])
    vals = {}
    for y, c in zip(heads[3:], cells[3:]):
        try: vals[y] = float(c)
        except ValueError: pass
    return vals, label, unit

def ecb(key, start='2005-01'):
    flow, rest = key.split('.', 1)
    url = f'https://data-api.ecb.europa.eu/service/data/{flow}/{rest}?startPeriod={start}&format=csvdata'
    t = _get(url)
    rows = list(csv.DictReader(io.StringIO(t)))
    title = rows[0].get('TITLE', '') if rows else ''
    return {r['TIME_PERIOD']: float(r['OBS_VALUE']) for r in rows if r['OBS_VALUE'] not in ('', 'NaN')}, title
