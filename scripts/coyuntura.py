#!/usr/bin/env python3
"""Cuadro de coyuntura de la economía española para el dictamen (y el 3.º/4.º).

Baja de las API públicas de Eurostat y del BCE (sin clave) los indicadores
básicos de España, con la zona del euro al lado, y escribe
oposicion/coyuntura.json, que lee la app (Organización y la guía del
dictamen). Lo ejecuta cada día la acción .github/workflows/coyuntura.yml; a
mano:

    python3 scripts/coyuntura.py            # escribe el JSON y enseña el cuadro
    python3 scripts/coyuntura.py --no-escribir

Si un indicador falla (la API cambia o no responde), se conserva el último
dato bueno del JSON anterior y se avisa; el script solo falla si fallan todos.
Solo biblioteca estándar.

Autor: Víctor Gutiérrez Marcos
"""
import json
import os
import sys
import urllib.parse
import urllib.request
from datetime import date, datetime, timedelta, timezone
from pathlib import Path

RAIZ = Path(__file__).resolve().parent.parent
SALIDA = RAIZ / 'oposicion/coyuntura.json'
EUROSTAT = 'https://ec.europa.eu/eurostat/api/dissemination/statistics/1.0/data/'
BCE = 'https://data-api.ecb.europa.eu/service/data/'
PUNTOS = 13  # serie corta: un año de meses o tres de trimestres

# Detrás del proxy del trabajo (intercepta TLS), su raíz junto a las del sistema.
_CAS = Path.home() / '.config/oposicion-red/cas.pem'
if _CAS.exists() and 'SSL_CERT_FILE' not in os.environ:
    os.environ['SSL_CERT_FILE'] = str(_CAS)

MESES = ['ene.', 'feb.', 'mar.', 'abr.', 'may.', 'jun.', 'jul.', 'ago.', 'sept.', 'oct.', 'nov.', 'dic.']

# id, grupo, nombre, unidad, fuente, frecuencia (M/Q/A), retraso típico en
# días desde el final del periodo hasta el dato, consulta y para qué sirve.
INDICADORES = [
    dict(id='pib_ia', grupo='Actividad', nombre='PIB real, variación interanual', unidad='%', fuente='Eurostat (INE)', frecuencia='Q', retraso=30,
         eurostat=('namq_10_gdp', {'unit': 'CLV_PCH_SM', 's_adj': 'SCA', 'na_item': 'B1GQ'}),
         nota='Crecimiento frente al mismo trimestre del año anterior: el dato que abre el dictamen.'),
    dict(id='pib_it', grupo='Actividad', nombre='PIB real, variación trimestral', unidad='%', fuente='Eurostat (INE)', frecuencia='Q', retraso=30,
         eurostat=('namq_10_gdp', {'unit': 'CLV_PCH_PRE', 's_adj': 'SCA', 'na_item': 'B1GQ'}),
         nota='Ritmo del último trimestre: dice si la economía acelera o frena.'),
    dict(id='ipca', grupo='Precios', nombre='Inflación (IPCA), interanual', unidad='%', fuente='Eurostat (INE)', frecuencia='M', retraso=17,
         eurostat=('prc_hicp_minr', {'unit': 'RCH_A', 'coicop18': 'TOTAL'}),
         nota='Índice armonizado, el que mira el BCE (objetivo del 2 % a medio plazo para la zona del euro).'),
    dict(id='subyacente', grupo='Precios', nombre='Inflación subyacente (sin energía ni alimentos), interanual', unidad='%', fuente='Eurostat (INE)', frecuencia='M', retraso=17,
         eurostat=('prc_hicp_minr', {'unit': 'RCH_A', 'coicop18': 'TOT_X_NRG_FOOD'}),
         nota='Sin los componentes más volátiles: la tendencia de fondo de los precios.'),
    dict(id='paro', grupo='Mercado de trabajo', nombre='Tasa de paro', unidad='% de la población activa', fuente='Eurostat (EPA)', frecuencia='M', retraso=32,
         eurostat=('une_rt_m', {'s_adj': 'SA', 'age': 'TOTAL', 'sex': 'T', 'unit': 'PC_ACT'}),
         nota='Desestacionalizada, mensual según Eurostat (la EPA del INE es trimestral).'),
    dict(id='paro_joven', grupo='Mercado de trabajo', nombre='Tasa de paro de los menores de 25 años', unidad='% de la población activa', fuente='Eurostat (EPA)', frecuencia='M', retraso=32,
         eurostat=('une_rt_m', {'s_adj': 'SA', 'age': 'Y_LT25', 'sex': 'T', 'unit': 'PC_ACT'}),
         nota='Paro juvenil: uno de los rasgos diferenciales del mercado de trabajo español.'),
    dict(id='deficit', grupo='Sector público', nombre='Saldo de las AA. PP.', unidad='% del PIB', fuente='Eurostat (PDE)', frecuencia='A', retraso=112,
         eurostat=('gov_10dd_edpt1', {'na_item': 'B9', 'sector': 'S13', 'unit': 'PC_GDP'}),
         nota='Capacidad (+) o necesidad (−) de financiación; referencia del 3 % del Pacto de Estabilidad.'),
    dict(id='deuda', grupo='Sector público', nombre='Deuda pública (PDE)', unidad='% del PIB', fuente='Eurostat (Banco de España)', frecuencia='Q', retraso=112,
         eurostat=('gov_10q_ggdebt', {'na_item': 'GD', 'sector': 'S13', 'unit': 'PC_GDP'}),
         nota='Deuda según el Protocolo de Déficit Excesivo; referencia del 60 %.'),
    dict(id='cuenta_corriente', grupo='Sector exterior', nombre='Saldo de la cuenta corriente', unidad='% del PIB', fuente='Eurostat (Banco de España)', frecuencia='Q', retraso=95,
         eurostat=('bop_gdp6_q', {'bop_item': 'CA', 'partner': 'WRL_REST', 'stk_flow': 'BAL', 'unit': 'PC_GDP', 's_adj': 'NSA'}),
         nota='Capacidad (+) o necesidad (−) de financiación frente al resto del mundo por bienes, servicios y rentas.'),
    dict(id='bono10', grupo='Financiero', nombre='Rentabilidad del bono a 10 años', unidad='%', fuente='Eurostat (criterio de convergencia)', frecuencia='M', retraso=10,
         eurostat=('irt_lt_mcby_m', {'int_rt': 'MCBY'}),
         nota='La resta con Alemania es la prima de riesgo (en el cuadro, en puntos básicos).'),
    dict(id='dfr', grupo='Financiero', nombre='Tipo de la facilidad de depósito del BCE', unidad='%', fuente='BCE', frecuencia='D', retraso=0,
         bce='FM/B.U2.EUR.4F.KR.DFR.LEV',
         nota='El tipo de referencia de la política monetaria desde 2024.'),
    dict(id='euribor', grupo='Financiero', nombre='Euríbor a 12 meses (media mensual)', unidad='%', fuente='BCE', frecuencia='M', retraso=2,
         bce='FM/M.U2.EUR.RT.MM.EURIBOR1YD_.HSTA',
         nota='Referencia de la mayoría de las hipotecas a tipo variable en España.'),
    dict(id='usd', grupo='Financiero', nombre='Tipo de cambio dólares por euro (media mensual)', unidad='USD por EUR', fuente='BCE', frecuencia='M', retraso=2,
         bce='EXR/M.USD.EUR.SP00.A',
         nota='Una subida es una apreciación del euro.'),
]


def pedir(url):
    for intento in range(3):
        try:
            with urllib.request.urlopen(urllib.request.Request(url, headers={'Accept': 'application/json', 'User-Agent': 'victorgutierrezmarcos.es coyuntura'}), timeout=60) as r:
                return json.load(r)
        except OSError:
            if intento == 2:
                raise


def eurostat(dataset, filtros, geo):
    q = [('format', 'JSON'), ('lang', 'EN'), ('lastTimePeriod', str(PUNTOS)), ('geo', geo), *filtros.items()]
    d = pedir(EUROSTAT + dataset + '?' + urllib.parse.urlencode(q))
    tiempos = sorted(d['dimension']['time']['category']['index'].items(), key=lambda kv: kv[1])
    valores = d.get('value', {})
    serie = [(t, float(valores[str(i)])) for t, i in tiempos if str(i) in valores]
    return serie, d.get('updated')


def bce(clave):
    d = pedir(f'{BCE}{clave}?lastNObservations={PUNTOS}&format=jsondata')
    obs = d['structure']['dimensions']['observation'][0]['values']
    serie = next(iter(d['dataSets'][0]['series'].values()))['observations']
    return [(obs[int(i)]['id'], float(v[0])) for i, v in sorted(serie.items(), key=lambda kv: int(kv[0])) if v and v[0] is not None]


def fin_de_periodo(periodo):
    """Último día del periodo de Eurostat/BCE ('2026-09', '2026-Q2', '2025', '2026-10-24')."""
    if len(periodo) == 10:
        return date.fromisoformat(periodo)
    if '-Q' in periodo:
        a, t = periodo.split('-Q')
        m = 3 * int(t)
        return (date(int(a) + (m == 12), 1 if m == 12 else m + 1, 1) - timedelta(days=1))
    if len(periodo) == 7:
        a, m = map(int, periodo.split('-'))
        return date(a + (m == 12), 1 if m == 12 else m + 1, 1) - timedelta(days=1)
    return date(int(periodo), 12, 31)


def etiqueta(periodo):
    if len(periodo) == 10:
        d = date.fromisoformat(periodo)
        return f'{d.day} {MESES[d.month - 1]} {d.year}'
    if '-Q' in periodo:
        a, t = periodo.split('-Q')
        return f'{t}.º trim. {a}'
    if len(periodo) == 7:
        a, m = periodo.split('-')
        return f'{MESES[int(m) - 1]} {a}'
    return periodo


def siguiente(periodo, frecuencia, retraso):
    """Fecha aproximada del siguiente dato: el final del periodo que viene más el retraso típico."""
    fin = fin_de_periodo(periodo)
    paso = {'M': 31, 'Q': 92, 'A': 366}.get(frecuencia)
    if paso is None:
        return None
    return (fin + timedelta(days=paso) + timedelta(days=retraso)).isoformat()


def indicador(i):
    zona = None
    if 'eurostat' in i:
        ds, f = i['eurostat']
        serie, _ = eurostat(ds, f, 'ES')
        geo_ref = 'DE' if i['id'] == 'bono10' else 'EA20'
        zona = None
        for g in ([geo_ref] if geo_ref == 'DE' else ['EA20', 'EA', 'EA21']):
            try:
                zona, _ = eurostat(ds, f, g)
            except Exception:
                zona = None
            if zona:
                break
    else:
        serie = bce(i['bce'])
    if not serie:
        raise ValueError('serie vacía')
    periodo, valor = serie[-1]
    anterior = serie[-2][1] if len(serie) > 1 else None
    out = {
        'id': i['id'], 'grupo': i['grupo'], 'nombre': i['nombre'], 'unidad': i['unidad'], 'fuente': i['fuente'], 'nota': i['nota'],
        'frecuencia': i['frecuencia'], 'periodo': periodo, 'etiqueta': etiqueta(periodo), 'valor': round(valor, 2),
        'anterior': None if anterior is None else round(anterior, 2),
        'serie': [[etiqueta(p), round(v, 2)] for p, v in serie],
        'siguiente': siguiente(periodo, i['frecuencia'], i['retraso']),
    }
    if zona:
        mismos = dict(zona)
        if periodo in mismos:
            out['referencia'] = {'nombre': 'Alemania' if i['id'] == 'bono10' else 'Zona del euro', 'valor': round(mismos[periodo], 2)}
            if i['id'] == 'bono10':
                out['primaRiesgo'] = round(100 * (valor - mismos[periodo]))
    return out


def main():
    anterior = {}
    if SALIDA.exists():
        try:
            anterior = {x['id']: x for x in json.loads(SALIDA.read_text(encoding='utf-8')).get('indicadores', [])}
        except Exception:
            anterior = {}
    salida, fallos = [], []
    for i in INDICADORES:
        try:
            salida.append(indicador(i))
        except Exception as e:  # noqa: BLE001 - cada indicador por su cuenta
            fallos.append(f"{i['id']}: {e}")
            if i['id'] in anterior:
                salida.append(anterior[i['id']])
    if not any(x['id'] in {i['id'] for i in INDICADORES} for x in salida) or len(fallos) == len(INDICADORES):
        print('Han fallado todos los indicadores:', *fallos, sep='\n  ', file=sys.stderr)
        sys.exit(1)
    datos = {'actualizado': datetime.now(timezone.utc).strftime('%Y-%m-%dT%H:%MZ'), 'pais': 'España', 'indicadores': salida}
    # Solo se reescribe si cambian los datos (no por la hora): así la acción no hace commits vacíos.
    if anterior and [x for x in salida] == list(anterior.values()):
        print('Sin datos nuevos.')
    elif '--no-escribir' not in sys.argv:
        SALIDA.write_text(json.dumps(datos, ensure_ascii=False, indent=1) + '\n', encoding='utf-8')
        print(f'Escrito {SALIDA.relative_to(RAIZ)}')
    for x in salida:
        ref = f"  ({x['referencia']['nombre']}: {x['referencia']['valor']})" if 'referencia' in x else ''
        print(f"  {x['nombre'][:55]:55} {x['etiqueta']:>15}  {x['valor']:>7}{ref}")
    for f in fallos:
        print('  FALLO', f, file=sys.stderr)


if __name__ == '__main__':
    main()
