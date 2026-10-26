"""Escribe los cuadros del cuadernillo (cuadros/cuadroN.tex) a partir de datos/cuadroN.csv.
Así ninguna cifra se copia a mano: python3 -I generar_cuadros.py (desde esta carpeta).
Redondeo: el número de decimales de la columna «dec» del CSV (por defecto, 1)."""
import csv, os

AQUI = os.path.dirname(os.path.abspath(__file__))
ANIOS = [str(a) for a in range(2007, 2028)]
PREV = {'2026', '2027'}


def leer(n):
    with open(os.path.join(AQUI, 'datos', f'cuadro{n}.csv'), encoding='utf-8') as f:
        filas = [l for l in f if not l.startswith('#')]
    return {r['id']: r for r in csv.DictReader(filas)}


def fmt(v, dec):
    if v in ('', None):
        return ''
    x = round(float(v), dec)
    if x == 0:
        x = 0.0                     # sin «-0,0»
    s = f'{abs(x):.{dec}f}'.replace('.', '{,}')
    return ('$-$' if x < 0 else '') + s


# (id, etiqueta, sangría, decimales o None = los del CSV, años que se omiten)
CUADROS = {
    1: ('Demanda agregada y actividad', 'variación anual en volumen, en \\%, salvo indicación', [
        ('pib', 'PIB', 0), ('cpriv', 'Consumo privado', 1), ('cpub', 'Consumo público', 1),
        ('fbcf', 'Formación bruta de capital fijo', 1), ('fbcf_viv', 'Viviendas', 2), ('fbcf_otc', 'Otras construcciones', 2),
        ('fbcf_maq', 'Maquinaria, bienes de equipo y armamento', 2), ('fbcf_pi', 'Productos de la propiedad intelectual', 2),
        ('x', 'Exportaciones de bienes y servicios', 1), ('m', 'Importaciones de bienes y servicios', 1),
        ('c_int', 'Demanda nacional (contribución, pp)', 0), ('c_exist', 'de la cual, variación de existencias (pp)', 1),
        ('c_ext', 'Demanda externa neta (contribución, pp)', 0),
        ('pib_pc', 'PIB por habitante', 0), ('pib_nom', 'PIB nominal (miles de millones de euros)', 0),
        ('pot', 'PIB potencial', 0), ('brecha', 'Brecha de producción (\\% del PIB potencial)', 0)],
        'Eurostat (contabilidad nacional del INE); PIB potencial, brecha de producción y previsiones: Comisión Europea (AMECO, '
        'previsiones de primavera de 2026). P: previsión.'),
    2: ('Oferta: valor añadido bruto por ramas de actividad', 'variación anual en volumen, en \\%', [
        ('vab', 'Valor añadido bruto total', 0), ('vab_a', 'Agricultura, ganadería, silvicultura y pesca', 1),
        ('vab_be', 'Industria', 1), ('vab_c', 'de la cual, manufacturas', 2), ('vab_f', 'Construcción', 1),
        ('vab_gi', 'Comercio, transporte y hostelería', 1), ('vab_j', 'Información y comunicaciones', 1),
        ('vab_mn', 'Actividades profesionales y administrativas', 1),
        ('vab_oq', 'Administración pública, educación y sanidad', 1)],
        'Eurostat (contabilidad nacional del INE).'),
    3: ('Mercado de trabajo, productividad, costes laborales y demografía', 'en \\%, salvo indicación', [
        ('emp', 'Empleo, personas (variación anual)', 0), ('horas', 'Horas trabajadas (variación anual)', 0),
        ('act', 'Tasa de actividad (15-64 años)', 0), ('templeo', 'Tasa de empleo (15-64 años)', 0),
        ('paro', 'Tasa de paro (15-74 años)', 0), ('paro_ze', 'Tasa de paro de la zona del euro', 1),
        ('paro_juv', 'Tasa de paro juvenil (15-24 años)', 1), ('paro_ld', 'Paro de larga duración (\\% de los activos)', 1),
        ('temp', 'Asalariados temporales (\\% de los asalariados)', 0),
        ('vac', 'Tasa de vacantes (\\% de los puestos de trabajo)', 0),
        ('prod_oc', 'Productividad por ocupado (variación anual)', 0), ('prod_h', 'Productividad por hora (variación anual)', 0),
        ('rem', 'Remuneración por asalariado (variación anual)', 0),
        ('clu', 'Costes laborales unitarios nominales (var. anual)', 0),
        ('clu_ze', 'Ídem, zona del euro', 1),
        ('pob', 'Población (variación anual)', 0),
        ('extr', 'Población extranjera (\\% de la población)', 0),
        ('dep', 'Tasa de dependencia de los mayores (65+ / 15-64)', 0)],
        'Eurostat (contabilidad nacional y encuesta de población activa del INE; estadística de vacantes; población a 1 de enero); '
        'previsiones: Comisión Europea (AMECO). La tasa de vacantes se da desde 2010 (salto de la serie entre 2009 y 2010).'),
    4: ('Ahorro, inversión y financiación del sector privado', 'en \\%, salvo indicación', [
        ('ahorro_hog', 'Tasa de ahorro de los hogares (\\% de la renta disponible)', 0),
        ('rdb', 'Renta disponible real por habitante (variación anual)', 1),
        ('inv_hog', 'Tasa de inversión de los hogares (\\% de la renta disponible)', 0),
        ('inv_snf', 'Tasa de inversión de las empresas no financieras (\\% del VAB)', 0),
        ('ben_snf', 'Participación de los beneficios de las empresas (\\% del VAB)', 0),
        ('fbc', 'Formación bruta de capital (\\% del PIB)', 0), ('ahorro_nac', 'Ahorro nacional bruto (\\% del PIB)', 0),
        ('flujo_cred', 'Flujo de crédito al sector privado (\\% del PIB)', 0),
        ('phog', 'Préstamos a hogares (var. interanual, diciembre)', 0),
        ('psnf', 'Préstamos a empresas no financieras (var. interanual, dic.)', 0),
        ('hip', 'Tipo de los préstamos nuevos para vivienda', 0), ('hip_ze', 'Ídem, zona del euro', 1),
        ('snf_t', 'Tipo de los préstamos nuevos a empresas no financieras', 0),
        ('dhog', 'Deuda de los hogares (\\% del PIB)', 0), ('dsnf', 'Deuda de las empresas no financieras (\\% del PIB)', 0),
        ('viv', 'Precio de la vivienda (variación anual)', 0), ('viv_r', 'Precio de la vivienda deflactado (variación anual)', 1)],
        'Eurostat (cuentas de los sectores institucionales y contabilidad nacional del INE; indicadores del procedimiento de desequilibrios '
        'macroeconómicos; índice de precios de la vivienda del INE) y Banco Central Europeo (préstamos y tipos de interés de las entidades de crédito; '
        'tipos: media anual, España salvo indicación).'),
    5: ('Precios', 'variación anual en \\%', [
        ('ipca', 'IPCA: índice general', 0), ('ipca_sub', 'IPCA sin energía ni alimentos (subyacente)', 1),
        ('ipca_nrg', 'IPCA: energía', 1), ('ipca_food', 'IPCA: alimentos, bebidas alcohólicas y tabaco', 1),
        ('ipca_ze', 'IPCA de la zona del euro: índice general', 0), ('ipca_ze_sub', 'IPCA de la zona del euro: subyacente', 1),
        ('def_pib', 'Deflactor del PIB', 0), ('def_c', 'Deflactor del consumo privado', 0),
        ('def_x', 'Deflactor de las exportaciones', 0), ('def_m', 'Deflactor de las importaciones', 0)],
        'Eurostat (IPCA y contabilidad nacional del INE); previsión del IPCA: Comisión Europea (AMECO).'),
    6: ('Competitividad precio y no precio', 'en \\%, salvo indicación', [
        ('tcer_ipc', 'Tipo de cambio efectivo real: IPC, 42 socios (2020 = 100)', 0),
        ('tcer_clu', 'Tipo de cambio efectivo real: CLU, zona del euro (2020 = 100)', 0),
        ('cuota', 'Cuota en las exportaciones mundiales de bienes y servicios', 0),
        ('cuota_g', 'Bienes', 1), ('cuota_s', 'Servicios', 1),
        ('cuota_5a', 'Variación de la cuota de exportación en 5 años', 0),
        ('htec', 'Exportaciones de alta tecnología (\\% de las exportaciones)', 0),
        ('id', 'Gasto en I+D (\\% del PIB)', 0), ('id_ue', 'Ídem, Unión Europea', 1),
        ('apert', 'Apertura: (exportaciones + importaciones) / PIB', 0)],
        'Eurostat (tipos de cambio efectivos reales; cuadro de indicadores del procedimiento de desequilibrios macroeconómicos; estadística de I+D del INE; '
        'contabilidad nacional). Un aumento del tipo de cambio efectivo real indica una apreciación real. Alta tecnología: hasta 2022.'),
    7: ('Sector exterior', 'en \\% del PIB', [
        ('cc', 'Cuenta corriente', 0), ('bie', 'Bienes', 1), ('ser', 'Servicios', 1), ('tur', 'de los cuales, viajes (turismo)', 2),
        ('rp', 'Rentas primarias', 1), ('rs', 'Rentas secundarias', 1), ('kap', 'Cuenta de capital', 0),
        ('cnf', 'Capacidad (+) o necesidad ($-$) de financiación', 0),
        ('fa', 'Cuenta financiera (+: salida neta de capital)', 0), ('fa_d', 'Inversión directa', 1),
        ('fa_p', 'Inversión de cartera', 1), ('fa_f', 'Derivados financieros', 1), ('fa_o', 'Otra inversión', 1),
        ('fa_o_bde', 'de la cual, Banco de España', 2), ('fa_r', 'Activos de reserva', 1), ('eo', 'Errores y omisiones', 0),
        ('piin', 'Posición de inversión internacional neta (PIIN)', 0),
        ('piin_nendi', 'PIIN sin instrumentos que no generan impago', 1), ('den', 'Deuda externa neta', 0)],
        'Eurostat (balanza de pagos y posición de inversión internacional del Banco de España); previsión: Comisión Europea (AMECO, contabilidad nacional).'),
    8: ('Política monetaria y sistema bancario', 'en \\%, salvo indicación', [
        ('dfr', 'Facilidad de depósito del BCE (fin de año)', 0),
        ('mro', 'Operaciones principales de financiación (fin de año)', 0),
        ('eur12', 'Euríbor a 12 meses (media anual)', 0), ('m3', 'M3 de la zona del euro (var. interanual, diciembre)', 0),
        ('eurosis', 'Activo del Eurosistema (\\% PIB zona del euro, fin de año)', 0),
        ('cet1', 'Bancos: capital ordinario de nivel 1, CET1 (\\% APR)', 0), ('cet1_ue', 'Ídem, Unión Europea', 1),
        ('solv', 'Bancos: capital total (\\% de los APR)', 0),
        ('npl', 'Bancos: préstamos dudosos (\\% de los préstamos)', 0), ('npl_ue', 'Ídem, Unión Europea', 1),
        ('roe', 'Bancos: rentabilidad de los recursos propios (ROE)', 0), ('roe_ue', 'Ídem, Unión Europea', 1),
        ('roa', 'Bancos: rentabilidad del activo (ROA)', 0), ('roa_ue', 'Ídem, Unión Europea', 1)],
        'Banco Central Europeo (tipos oficiales, Euríbor, agregados monetarios, estado financiero del Eurosistema y datos bancarios consolidados) y '
        'Eurostat (PIB de la zona del euro). APR: activos ponderados por riesgo.'),
    9: ('Cuentas públicas', 'en \\% del PIB, salvo indicación', [
        ('ing', 'Ingresos', 0), ('gas', 'Gastos', 0), ('int', 'de los cuales, intereses', 1),
        ('saldo', 'Saldo (capacidad o necesidad de financiación)', 0), ('prim', 'Saldo primario', 0),
        ('cicl', 'Saldo ajustado de ciclo (\\% del PIB potencial)', 0), ('estr', 'Saldo estructural (\\% del PIB potencial)', 0),
        ('estr_p', 'Saldo estructural primario (\\% del PIB potencial)', 0), ('deuda', 'Deuda pública', 0),
        ('impl', 'Tipo de interés implícito de la deuda (\\%)', 0), ('pibn', 'PIB nominal (variación anual en \\%)', 0),
        ('rend', 'Rendimiento de la deuda a 10 años (\\%, media anual)', 0),
        ('dif', 'Diferencial frente al bono alemán a 10 años (pb)', 0)],
        'Eurostat (cuentas de las administraciones públicas, notificación del procedimiento de déficit excesivo de octubre de 2026; tipos de interés a '
        'largo plazo); saldos ajustados y previsiones: Comisión Europea (AMECO). Tipo implícito: intereses del año entre la deuda del año anterior.'),
}
ANCHO = {4: '7.6cm', 6: '7.6cm', 7: '7.2cm', 8: '7.8cm', 9: '7.0cm'}
OMITIR = {('vac', '2007'), ('vac', '2008'), ('vac', '2009')}


def tabla(n):
    titulo, unidad, filas, fuente = CUADROS[n]
    datos = leer(n)
    hay_prev = any(datos[i].get(a) for i, *_ in filas for a in PREV)
    anios = ANIOS if hay_prev else [a for a in ANIOS if a not in PREV]
    cols = len(anios)
    L = []
    if n in ANCHO:
        L.append('\\setlength{\\anchoetq}{%s}' % ANCHO[n])
    L.append(f'\\cuadro{{{n}}}{{{titulo}}}{{{unidad}}}')
    L.append('\\setlength{\\anchonum}{\\dimexpr(\\linewidth-\\anchoetq)/%d-2\\tabcolsep\\relax}' % cols)
    L.append('\\begin{tabular}{@{}>{\\raggedright\\arraybackslash}p{\\dimexpr\\anchoetq-\\tabcolsep\\relax}*{%d}{N}@{}}' % cols)
    L.append('\\toprule')
    cab = ' & '.join(('\\cabprev{' + a + '}') if a in PREV else ('\\textbf{' + a + '}') for a in anios)
    L.append('\\rowcolor{cabecera} & ' + cab + ' \\\\')
    L.append('\\midrule')
    for id_, etq, sang in filas:
        r = datos[id_]
        dec = int(r['dec'])
        vals = []
        for a in anios:
            v = '' if (id_, a) in OMITIR else r.get(a, '')
            c = fmt(v, dec)
            vals.append(('\\prevcel{' + c + '}') if a in PREV and c else c)
        pref = {0: '', 1: '\\hspace*{0.8em}', 2: '\\hspace*{1.6em}\\textit'}[sang]
        etiqueta = (pref + '{' + etq + '}') if sang == 2 else (pref + etq)
        if sang == 0:
            etiqueta = '\\textbf{' + etq + '}' if id_ in ('pib', 'vab', 'cc', 'cnf', 'saldo', 'deuda', 'piin', 'paro', 'ipca') else etq
        L.append(etiqueta + ' & ' + ' & '.join(vals) + ' \\\\')
    L.append('\\bottomrule')
    L.append('\\end{tabular}')
    L.append(f'\\fuentecuadro{{{fuente}}}')
    os.makedirs(os.path.join(AQUI, 'cuadros'), exist_ok=True)
    with open(os.path.join(AQUI, 'cuadros', f'cuadro{n}.tex'), 'w', encoding='utf-8') as f:
        f.write(f'% Generado por generar_cuadros.py a partir de datos/cuadro{n}.csv; no editar a mano.\n')
        f.write('\n'.join(L) + '\n')


def descomposicion():
    with open(os.path.join(AQUI, 'datos', 'cuadro2b-descomposicion.csv'), encoding='utf-8') as f:
        filas = list(csv.reader(l for l in f if not l.startswith('#')))
    cab, filas = filas[0], filas[1:]
    etiquetas = {
        'PIB': ('\\textbf{PIB}', 0),
        'Población': ('Población', 1),
        'Población en edad de trabajar (15-64) sobre población': ('Población en edad de trabajar (15-64) sobre población', 1),
        'Tasa de ocupación (ocupados sobre población de 15-64)': ('Tasa de ocupación (ocupados sobre población de 15-64)', 1),
        'Horas trabajadas por ocupado': ('Horas trabajadas por ocupado', 1),
        'PIB por hora trabajada': ('PIB por hora trabajada', 1),
        'PIB por ocupado': ('PIB por ocupado', 0),
        'PIB por habitante': ('PIB por habitante', 0),
        'PIB por persona en edad de trabajar': ('PIB por persona en edad de trabajar', 0),
        'Horas trabajadas totales': ('Horas trabajadas totales', 0),
    }
    L = ['\\cuadro{2 bis}{Descomposición del crecimiento del PIB}{tasa media anual en \\%; las filas sangradas suman la del PIB}',
         '\\setlength{\\anchonum}{\\dimexpr(\\linewidth-\\anchoetq)/3-2\\tabcolsep\\relax}',
         '\\begin{tabular}{@{}>{\\raggedright\\arraybackslash}p{\\dimexpr\\anchoetq-\\tabcolsep\\relax}*{3}{N}@{}}', '\\toprule',
         '\\rowcolor{cabecera} & ' + ' & '.join('\\textbf{' + c + '}' for c in cab[1:]) + ' \\\\', '\\midrule']
    for r in filas:
        e, s = etiquetas[r[0]]
        L.append(('\\hspace*{0.8em}' if s else '') + e + ' & ' + ' & '.join(fmt(v, 2) for v in r[1:]) + ' \\\\')
    L += ['\\bottomrule', '\\end{tabular}',
          '\\fuentecuadro{Elaboración con datos de Eurostat (contabilidad nacional del INE: PIB en volumen, población, ocupados y '
          'horas; población de 15-64 años a 1 de enero). Diferencias logarítmicas.}']
    with open(os.path.join(AQUI, 'cuadros', 'cuadro2b.tex'), 'w', encoding='utf-8') as f:
        f.write('% Generado por generar_cuadros.py a partir de datos/cuadro2b-descomposicion.csv; no editar a mano.\n')
        f.write('\n'.join(L) + '\n')


if __name__ == '__main__':
    for n in CUADROS:
        tabla(n)
    descomposicion()
    print('cuadros escritos en', os.path.join(AQUI, 'cuadros'))
