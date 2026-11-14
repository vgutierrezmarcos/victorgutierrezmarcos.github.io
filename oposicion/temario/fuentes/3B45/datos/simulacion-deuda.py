# Simulación ilustrativa del análisis de sostenibilidad de la deuda del marco
# fiscal de 2024 para un país parecido a España (elaboración propia).
# d_t = d_{t-1}*(1+i)/(1+g) - s_t ; s_t saldo primario (% del PIB).
# Supuestos (texto del tema, II.1.2): d_2025 = 100,5 % (Eurostat), s_2025 = 0;
# i (tipo implícito) sube de 2,4 % a 3,5 % en 2030 y se queda; g (crecimiento
# nominal) baja de 4,5 % a 3,3 % en 2030 y se queda; coste del envejecimiento:
# el saldo primario empeora 0,1 pp al año desde 2029 hasta 2041.
# Escenarios: sin ajuste; plan a 4 años (0,6 pp/año 2026-2029);
# plan a 7 años (0,35 pp/año 2026-2032). Salvaguardia: -1 pp/año desde 2025.
import csv
def ruta(n_aj, paso):
    d=100.5; s=0.0; out=[(2025,d,s)]
    for t in range(2026,2042):
        k=t-2025
        i=2.4+min(k,5)*(3.5-2.4)/5; g=4.5-min(k,5)*(4.5-3.3)/5
        if k<=n_aj: s+=paso
        env=0.1*max(0,t-2028)
        st=s-env
        d=d*(1+i/100)/(1+g/100)-st
        out.append((t,d,st))
    return out
A=ruta(0,0); B=ruta(4,0.6); C=ruta(7,0.35)
with open('simulacion-deuda.csv','w') as f:
    f.write('# Simulación propia (simulacion-deuda.py): deuda pública en % del PIB, 2025-2041, con la ecuación de la dinámica de la deuda; supuestos en la cabecera del script. Punto de partida: deuda de España en 2025, 100,5 % del PIB (Eurostat gov_10dd_edpt1, notificación de octubre de 2026). Es ilustrativa: no reproduce el análisis de la Comisión.\n')
    f.write('anio,sin_ajuste,plan4,plan7,salvaguardia,saldo_sin,saldo_plan4,saldo_plan7\n')
    for a,b,c in zip(A,B,C):
        f.write('%d,%.2f,%.2f,%.2f,%.2f,%.2f,%.2f,%.2f\n'%(a[0],a[1],b[1],c[1],100.5-(a[0]-2025),a[2],b[2],c[2]))
print(open('simulacion-deuda.csv').read())
