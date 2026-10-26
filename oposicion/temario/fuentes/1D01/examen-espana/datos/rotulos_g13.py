# Escribe graficos/g13-orientacion-fiscal.tex con los rótulos de los años colocados a mano: python3 -I datos/rotulos_g13.py .
import csv, sys
base = sys.argv[1]
rows = list(csv.DictReader(l for l in open(base + '/datos/g13-orientacion-fiscal.csv', encoding='utf-8') if not l.startswith('#')))
pos = {'2008':'south','2009':'east','2010':'south','2011':'west','2012':'west','2013':'east','2014':'north','2015':'north east',
       '2016':'north','2017':'north east','2018':'west','2019':'north','2020':'north','2021':'south west','2022':'north',
       '2023':'west','2024':'west','2025':'west','2026':'north west','2027':'east'}
n = len(rows); kprev = [i for i, r in enumerate(rows) if r['anio'] >= '2026'][0]
rot = '\n'.join(f"      \\dicrotulo[font=\\tiny, anchor={pos[r['anio']]}, inner sep=1.5pt]{{({float(r['brecha']):.3f},{float(r['var_saldo_estr_prim']):.3f})}}{{{r['anio']}}}" for r in rows)
tex = f"""% Gráfico 13. Brecha de producción y variación del saldo estructural primario de las AAPP (pp del PIB potencial), 2008-2027.
% Datos: ../datos/g13-orientacion-fiscal.csv (FMI, WEO de octubre de 2026: NGAP_NPGDP y GGSB_NPGDP + intereses). Filas {kprev}-{n-1} (2026-2027): previsión, en hueco.
% Rótulos de los años colocados a mano (para que no se pisen): revisar si cambian los datos.
\\pgfplotstableread[col sep=comma,comment chars={{\\#}}]{{datos/g13-orientacion-fiscal.csv}}\\gOnce
\\begin{{tikzpicture}}[tcee]
  \\begin{{axis}}[dicgraf,
      xmin=-10, xmax=5, xtick={{-10,-8,...,4}},
      ymin=-7, ymax=5, ytick={{-6,-4,...,4}},
      xlabel={{Brecha de producción (\\% del PIB potencial)}},
      ylabel={{Variación del saldo estructural primario (pp)}},
      dicapas]
    \\capa{{1}}{{\\dicraya{{(-10,0) (5,0)}} \\dicraya{{(0,-7) (0,5)}}}}
    \\capa{{2}}{{\\addplot[on layer=dicpuntos, only marks, mark=*, mark size=1.9pt, mark options={{fill=dicfiscal, draw=dicfiscal}},
        skip coords between index={{{kprev}}}{{{n}}}] table[x=brecha, y=var_saldo_estr_prim] {{\\gOnce}};}}
    \\capa{{3}}{{\\addplot[on layer=dicpuntos, only marks, mark=*, mark size=1.9pt, mark options={{fill=white, draw=dicfiscal, line width=0.8pt}},
        skip coords between index={{0}}{{{kprev}}}] table[x=brecha, y=var_saldo_estr_prim] {{\\gOnce}};}}
    % 4: año de cada punto, colocados a mano
    \\capa{{4}}{{
{rot}
    }}
  \\end{{axis}}
\\end{{tikzpicture}}
"""
open(base + '/graficos/g13-orientacion-fiscal.tex', 'w', encoding='utf-8').write(tex)
print('ok', n, kprev)
