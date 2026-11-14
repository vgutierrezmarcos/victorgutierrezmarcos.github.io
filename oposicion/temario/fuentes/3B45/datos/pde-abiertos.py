# Número de procedimientos de déficit excesivo (PDE) abiertos a 31 de diciembre
# de cada año, 2002-2026. Elaboración propia: año de la decisión del Consejo
# que abre cada PDE (art. 126.6) y año de la que lo cierra (art. 126.12).
# Sin los procedimientos anteriores a 2002 (segunda fase de la UEM).
P={'PT':[(2002,2004),(2005,2008),(2009,2017)],'DE':[(2003,2007),(2009,2012)],
'FR':[(2003,2007),(2009,2018),(2024,None)],'EL':[(2004,2007),(2009,2017)],
'NL':[(2004,2005),(2009,2014)],'IT':[(2005,2008),(2009,2013),(2024,None)],
'UK':[(2006,2007),(2008,2017)],'HU':[(2004,2013),(2024,None)],
'PL':[(2004,2008),(2009,2015),(2024,None)],'CZ':[(2004,2008),(2009,2014)],
'SK':[(2004,2008),(2009,2014),(2024,None)],'CY':[(2004,2006),(2010,2016)],
'MT':[(2004,2007),(2009,2012),(2013,2015),(2024,2026)],'LV':[(2009,2013)],
'LT':[(2009,2013)],'RO':[(2009,2013),(2020,None)],'IE':[(2009,2016)],
'ES':[(2009,2019)],'BE':[(2009,2014),(2024,None)],'AT':[(2009,2014),(2025,None)],
'SI':[(2009,2016)],'DK':[(2010,2014)],'BG':[(2010,2012),(2026,None)],
'FI':[(2010,2011),(2026,None)],'HR':[(2014,2017)]}
with open('pde-abiertos.csv','w') as f:
    f.write('# Procedimientos de déficit excesivo abiertos a 31 de diciembre, 2002-2026 (2026: a 14 de noviembre). Elaboración propia (pde-abiertos.py) a partir de las decisiones del Consejo de apertura y cierre de cada procedimiento, recogidas en las páginas por país de la Comisión Europea (https://economy-finance.ec.europa.eu/economic-governance-framework/stability-and-growth-pact/corrective-arm-excessive-deficit-procedure/excessive-deficit-procedures-overview_en); abiertos en noviembre de 2026: AT, BE, BG, FI, FR, HU, IT, PL, RO, SK. Consulta: 14/11/2026.\n')
    f.write('anio,abiertos,lista\n')
    for y in range(2002,2027):
        l=sorted(k for k,v in P.items() for a,b in v if a<=y and (b is None or b>y))
        f.write('%d,%d,%s\n'%(y,len(l),' '.join(l)))
print(open('pde-abiertos.csv').read())
