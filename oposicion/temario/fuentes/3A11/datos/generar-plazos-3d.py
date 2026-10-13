#!/usr/bin/env python3
"""Genera los 5 gráficos 3D de 3A11 con la misma superficie y encuadre."""
import sys, os

G = sys.argv[1]

CAB = r"""%% %(desc)s
%% Superficie genérica (no Cobb-Douglas), la misma en funcion-produccion-3d y
%% plazos-3d*: F(z_L,z_K) = 4p/(1+p), p = (z_L z_K/4)^{1,5}: creciente,
%% isocuantas convexas (z_L z_K constante) y rendimientos locales crecientes
%% y luego decrecientes. Perspectiva del gráfico de cuasiconcavidad del 3.A.8
%% (vista por defecto de pgfplots, acimut 30° y elevación 28°): origen a la
%% izquierda, q vertical, z_L a la derecha algo hacia abajo y z_K en
%% profundidad hacia arriba a la derecha.
%% Generado con el mismo esquema en los 5 ficheros: si se cambia la superficie,
%% cambiarla en todos.
%% Autor: Víctor Gutiérrez Marcos
\documentclass[tikz,border=4pt]{standalone}
\input{../../../latex/tikz-tcee}
\pgfplotsset{
  superficie/.style={surf,z buffer=sort,shader=faceted,fill opacity=0.45,draw=tceemorado!40,line width=0.15pt,
    colormap={tcee}{rgb255=(226,239,217) rgb255=(167,137,189)}},
  superficietenue/.style={surf,z buffer=sort,shader=faceted,fill opacity=0.22,draw=tceemorado!25,line width=0.15pt,
    colormap={tcee}{rgb255=(236,244,231) rgb255=(205,190,216)}},
  superficienueva/.style={surf,z buffer=sort,shader=faceted,fill opacity=0.18,draw=tceerojo!55,dashed,line width=0.25pt,
    colormap={rojo}{rgb255=(248,228,228) rgb255=(222,160,160)}},
  superficienuevatenue/.style={mesh,draw=tceegris!40,dashed,line width=0.2pt},
}
\tikzset{
  fondo/.style={fill=white,fill opacity=0.75,text opacity=1,inner sep=1.5pt},
%(estilos)s
}
\begin{document}
\begin{tikzpicture}[tcee]
  \begin{axis}[x={(1.2cm,-0.33cm)},y={(0.69cm,0.56cm)},z={(0cm,1.22cm)},axis lines=none,
      xmin=0,xmax=4,ymin=0,ymax=4,zmin=0,zmax=4.6,clip=false,
      declare function={F(\zl,\zk)=4*((\zl*\zk/4)^1.5)/(1+(\zl*\zk/4)^1.5);}]
%(cuerpo)s
  \end{axis}
\end{tikzpicture}
\end{document}
"""

FUERTE = {
    'cpplano': r'fill=tceedorado,fill opacity=0.22,draw=tceedorado,thin',
    'cpcorte': r'curva4,line width=1.5pt',
    'isosup': r'curva1,line width=1.1pt',
    'isobase': r'curva1,line width=1.1pt',
    'rayo': r'curva3,thick,dashed',
    'lpplano': r'fill=tceeverde,fill opacity=0.18,draw=none',
    'lpcorte': r'curva3,line width=1.5pt',
    'lpguia': r'guia,tceeverde',
    'mlflecha': r'flecha',
}
TENUE = {
    'cpplano': r'fill=tceegris,fill opacity=0.06,draw=tceegris!40,very thin',
    'cpcorte': r'tceegris!70,thin',
    'isosup': r'tceegris!60,thin',
    'isobase': r'tceegris!60,thin',
    'rayo': r'tceegris!60,thin,dashed',
    'lpplano': r'fill=tceegris,fill opacity=0.05,draw=none',
    'lpcorte': r'tceegris!70,thin',
    'lpguia': r'tceegris!40,very thin,dashed',
    'mlflecha': r'->,tceegris!60,thin',
}
GRUPO = {'cpplano': 'cp', 'cpcorte': 'cp', 'isosup': 'lp', 'isobase': 'lp', 'rayo': 'lp',
         'lpplano': 'lp', 'lpcorte': 'lp', 'lpguia': 'lp', 'mlflecha': 'ml'}

ZB = 2.5            # capital fijo del corto plazo
RAYO = (1.2, 0.9)   # \bar z: lambda = 1
LAMBDAS = [1, 2, 3]
A1 = 1.3


def ejes():
    return [
        r"\draw[eje] (axis cs:0,0,0) -- (axis cs:4.7,0,0) node[below right=-2pt] {$z_L$};",
        r"\draw[eje] (axis cs:0,0,0) -- (axis cs:0,5.0,0) node[above right=-2pt,fondo] {$z_K$};",
        r"\draw[eje] (axis cs:0,0,0) -- (axis cs:0,0,4.9) node[left] {$q$};",
        r"\node[left] at (axis cs:0,0,0) {$0$};",
    ]


def superficie(estilo, rotulo):
    l = [r"\addplot3[%s,domain=0:4,y domain=0:4,samples=13,samples y=13] {F(x,y)};" % estilo]
    if rotulo:
        l.append(r"\node[etiqueta,anchor=west] at (axis cs:4,4,{F(4,4)}) {%s};" % rotulo)
    return l


def corto(rotulos, flecha=False):
    l = [r"\addplot3[cpplano,domain=0:4,samples=50,samples y=0] (x,%s,{F(x,%s)}) -- (axis cs:4,%s,0) -- (axis cs:0,%s,0) -- cycle;" % (ZB, ZB, ZB, ZB)]
    l2 = [r"\addplot3[cpcorte,domain=0:4,samples=60,samples y=0] (x,%s,{F(x,%s)});" % (ZB, ZB)]
    if rotulos:
        l2 += [r"\node[etiqueta,fondo,text=tceedorado,anchor=east] at (axis cs:0,%s,0) {$\overline{z}_K$};" % ZB,
               r"\node[etiqueta,fondo,text=tceedorado,anchor=south east,align=right,xshift=-4pt] at (axis cs:1.15,%s,{F(1.15,%s)}) {%s};" % (ZB, ZB, rotulos)]
    if flecha:
        l2 += [r"\addplot3[flecha,tceedorado,domain=1.6:3.2,samples=20,samples y=0] (x,%s,{F(x,%s)+0.4});" % (ZB, ZB),
               r"\node[etiqueta,text=tceedorado,anchor=south] at (axis cs:2.4,%s,{F(2.4,%s)+0.45}) {más $z_L$};" % (ZB, ZB)]
    return l, l2


def isocuantas(rotulos):
    """Isocuantas de los niveles F(lambda \bar z): z_L z_K = c."""
    sup, base = [], []
    for i, lam in enumerate(LAMBDAS, 1):
        c = RAYO[0] * RAYO[1] * lam * lam
        q = "{F(%s,%s)}" % (RAYO[0] * lam, RAYO[1] * lam)
        x0 = round(c / 4, 4)
        sup.append(r"\addplot3[isosup,domain=%s:4,samples=50,samples y=0] (x,{%s/x},%s);" % (x0, c, q))
        base.append(r"\addplot3[isobase,domain=%s:4,samples=50,samples y=0] (x,{%s/x},0);" % (x0, c))
        if rotulos:
            base.append(r"\node[etiqueta,text=tceemorado,anchor=west] at (axis cs:4,{%s/4},0) {$q_%d$};" % (c, i))
    return sup, base


def largo(rotulos):
    xr, yr = RAYO
    t = 4 / xr  # lambda máxima: z_L = 4
    rayo = [r"\addplot3[rayo] coordinates {(0,0,0) (4,%s,0)};" % round(yr * t, 4)]
    plano = [r"\addplot3[lpplano,domain=0:%s,samples=50,samples y=0] ({%s*x},{%s*x},{F(%s*x,%s*x)}) -- (axis cs:4,%s,0) -- (axis cs:0,0,0) -- cycle;"
             % (round(t, 4), xr, yr, xr, yr, round(yr * t, 4))]
    corte = [r"\addplot3[lpcorte,domain=0:%s,samples=60,samples y=0] ({%s*x},{%s*x},{F(%s*x,%s*x)});" % (round(t, 4), xr, yr, xr, yr)]
    puntos = []
    if rotulos:
        rayo.append(r"\node[etiqueta,text=tceeverde,anchor=south west,align=left] at (axis cs:4,%s,0) {rayo:\\ $z_K/z_L$ fijo};" % round(yr * t, 4))
        corte.append(r"\node[etiqueta,text=tceeverde,anchor=west] at (axis cs:4,%s,{F(4,%s)}) {%s};" % (round(yr * t, 4), round(yr * t, 4), rotulos))
        for lam in LAMBDAS:
            x, y = round(xr * lam, 4), round(yr * lam, 4)
            puntos.append(r"\draw[lpguia] (axis cs:%s,%s,0) -- (axis cs:%s,%s,{F(%s,%s)});" % (x, y, x, y, x, y))
            puntos.append(r"\node[punto,fill=tceeverde] at (axis cs:%s,%s,{F(%s,%s)}) {};" % (x, y, x, y))
            puntos.append(r"\node[punto,fill=tceeverde,inner sep=1pt] at (axis cs:%s,%s,0) {};" % (x, y))
            ancla = 'south east' if lam == LAMBDAS[-1] else 'north east'
            puntos.append(r"\node[etiqueta,text=tceeverde,anchor=%s,font=\scriptsize,inner sep=1pt,fill=white,fill opacity=0.75,text opacity=1] at (axis cs:%s,%s,0) {$\lambda=%d$};" % (ancla, x, y, lam))
    else:
        for lam in LAMBDAS:
            x, y = round(xr * lam, 4), round(yr * lam, 4)
            puntos.append(r"\draw[lpguia] (axis cs:%s,%s,0) -- (axis cs:%s,%s,{F(%s,%s)});" % (x, y, x, y, x, y))
    return rayo, plano, corte, puntos


FLECHAS_ML = [(1.4, 3.6), (2.4, 3.4), (3.2, 1.6)]


def muylargo(estilo, rotulo, flechas_rot):
    sup = [r"\addplot3[%s,domain=0:4,y domain=0:4,samples=13,samples y=13] {%s*F(x,y)};" % (estilo, A1)]
    if rotulo:
        sup.append(r"\node[etiqueta,text=tceerojo,anchor=west,align=left] at (axis cs:4,4,{%s*F(4,4)}) {%s};" % (A1, rotulo))
    fl = []
    for x, y in FLECHAS_ML:
        fl.append(r"\draw[mlflecha] (axis cs:%s,%s,{F(%s,%s)}) -- (axis cs:%s,%s,{%s*F(%s,%s)});" % (x, y, x, y, x, y, A1, x, y))
    if flechas_rot:
        x, y = FLECHAS_ML[0]
        fl.append(r"\node[etiqueta,text=tceerojo,anchor=south east,align=right] at (axis cs:%s,%s,{%s*F(%s,%s)}) {%s};" % (x, y, A1, x, y, flechas_rot))
    return sup, fl


def qbarra(A, color, rotulo, sobre=True):
    """Isocuanta q = 2 con la tecnología A: z_L z_K = 4 (2/A / (4 - 2/A))^{2/3}."""
    r = 2 / A
    c = round(4 * (r / (4 - r)) ** (2 / 3), 4)
    x0 = round(c / 4, 4)
    l = []
    if sobre:
        l.append(r"\addplot3[%s,domain=%s:4,samples=50,samples y=0] (x,{%s/x},2);" % (color, x0, c))
    l.append(r"\addplot3[%s,domain=%s:4,samples=50,samples y=0] (x,{%s/x},0);" % (color, x0, c))
    return l, c


def capas(lista):
    out = []
    for n, comentario, cosas in lista:
        out.append("    %% %d: %s" % (n, comentario))
        for c in cosas:
            out.append("    \\capa{%d}{%s}" % (n, c))
    return "\n".join(out)


def estilos(foco):
    l = []
    for k in FUERTE:
        s = FUERTE[k] if GRUPO[k] in foco else TENUE[k]
        l.append("  %s/.style={%s}," % (k, s))
    return "\n".join(l)


def escribir(nombre, desc, foco, cuerpo):
    txt = CAB % {'desc': desc, 'estilos': estilos(foco), 'cuerpo': cuerpo}
    with open(os.path.join(G, nombre + '.tex'), 'w', encoding='utf-8') as f:
        f.write(txt)


# ---------------------------------------------------------------- funcion-produccion-3d
z0 = (2.5, 1.5)
fz = "{F(%s,%s)}" % z0
cuerpo = capas([
    (1, "ejes", ejes()),
    (2, "superficie de producción", superficie('superficie', r'$q=F(z_L,z_K)$')),
    (3, r"vector de factores \vect{z}^0 en la base y sus proyecciones", [
        r"\draw[guia] (axis cs:%s,0,0) node[below] {$z_L^0$} -- (axis cs:%s,%s,0) -- (axis cs:0,%s,0) node[left,fondo] {$z_K^0$};" % (z0[0], z0[0], z0[1], z0[1]),
        r"\node[punto] at (axis cs:%s,%s,0) {};" % z0,
        r"\node[etiqueta,anchor=north west] at (axis cs:%s,%s,0) {$\vect{z}^{\,0}$};" % z0,
    ]),
    (4, r"vertical hasta la superficie, F(\vect{z}^0) y su proyección al eje q", [
        r"\draw[guia,tceemorado] (axis cs:%s,%s,0) -- (axis cs:%s,%s,%s);" % (z0[0], z0[1], z0[0], z0[1], fz),
        r"\draw[guia] (axis cs:%s,%s,%s) -- (axis cs:0,%s,%s) -- (axis cs:0,0,%s);" % (z0[0], z0[1], fz, z0[1], fz, fz),
        r"\node[punto,fill=tceemorado] at (axis cs:%s,%s,%s) {};" % (z0[0], z0[1], fz),
        r"\node[etiqueta,anchor=east] at (axis cs:0,0,%s) {$F(\vect{z}^{\,0})$};" % fz,
    ]),
    (5, "planes posibles debajo de la superficie e imposibles encima", [
        r"\node[etiqueta,text=tceegris,align=center] at (axis cs:4,2.6,1.0) {planes\\ posibles ($\mathcal{Y}$)};",
        r"\node[etiqueta,text=tceegris] at (axis cs:1.2,3.2,3.6) {imposible};",
    ]),
])
escribir('funcion-produccion-3d', 'Función de producción con 2 factores: superficie q = F(z_L,z_K), un vector de factores y su producción máxima.', set(), cuerpo)

# ---------------------------------------------------------------- partes comunes
cp_plano_r, cp_corte_r = corto(r'corto plazo:\\ $q=F(z_L,\overline{z}_K)$')
cp_plano_t, cp_corte_t = corto(None)
iso_sup_r, iso_base_r = isocuantas(True)
iso_sup_t, iso_base_t = isocuantas(False)
lp_rayo_r, lp_plano_r, lp_corte_r, lp_puntos_r = largo(r'largo plazo: $F(\lambda\vect{\overline{z}})$')
lp_rayo_t, lp_plano_t, lp_corte_t, lp_puntos_t = largo(None)

# ---------------------------------------------------------------- plazos-3d
ml_sup, ml_fl = muylargo('superficienueva', r'$A_1F(\vect{z})$\\ $A_1>A_0$', r'muy largo plazo:\\ progreso técnico')
cuerpo = capas([
    (1, "ejes", ejes()),
    (2, "superficie inicial (A_0)", superficie('superficie', r'$A_0F(\vect{z})$')),
    (3, r"corto plazo: plano z_K = \bar z_K y su corte", cp_plano_r + cp_corte_r),
    (4, "largo plazo: isocuantas (cortes horizontales) y su proyección en la base", iso_sup_r + iso_base_r),
    (5, "largo plazo: rayo, plano vertical y corte F(lambda \\bar z)", lp_rayo_r + lp_plano_r + lp_corte_r + lp_puntos_r),
    (6, "muy largo plazo: superficie desplazada (A_1) y flechas del progreso técnico", ml_sup + ml_fl),
])
escribir('plazos-3d', 'Los 3 plazos sobre la superficie de producción (a partir de Fuleky, 2006).', {'cp', 'lp', 'ml'}, cuerpo)

# ---------------------------------------------------------------- plazos-3d-corto
mlt_sup, mlt_fl = muylargo('superficienuevatenue', None, None)
contexto_corto = iso_base_t + lp_rayo_t + lp_corte_t + mlt_sup
cuerpo = capas([
    (1, "ejes", ejes()),
    (2, "superficie (y, tenues, los otros plazos)", superficie('superficie', r'$q=F(z_L,z_K)$') + contexto_corto),
    (3, r"plano z_K = \bar z_K", cp_plano_r),
    (4, r"corte de corto plazo q = F(z_L,\bar z_K) y rótulos", corto(r'$q=F(z_L,\overline{z}_K)$')[1]),
    (5, "más trabajo con el mismo capital", corto(r'', flecha=True)[1][-2:]),
])
escribir('plazos-3d-corto', 'Corto plazo: corte de la superficie de producción por el plano z_K = z_K barra.', {'cp'}, cuerpo)

# ---------------------------------------------------------------- plazos-3d-largo
contexto_largo = cp_corte_t + mlt_sup
cuerpo = capas([
    (1, "ejes", ejes()),
    (2, "superficie (y, tenues, los otros plazos)", superficie('superficie', r'$q=F(z_L,z_K)$') + contexto_largo),
    (3, "isocuantas como cortes horizontales y su proyección en la base", iso_sup_r + iso_base_r),
    (4, "rayo desde el origen y plano vertical", lp_rayo_r + lp_plano_r),
    (5, r"corte F(\lambda \bar z) y puntos lambda = 1, 2, 3", lp_corte_r + lp_puntos_r),
])
escribir('plazos-3d-largo', 'Largo plazo: isocuantas y corte de la superficie de producción a lo largo de un rayo.', {'lp'}, cuerpo)

# ---------------------------------------------------------------- plazos-3d-muy-largo
q0, c0 = qbarra(1, 'curva1,line width=1.1pt', None)
q1, c1 = qbarra(A1, 'curvanueva,line width=1.1pt', None)
ml_sup2, ml_fl2 = muylargo('superficienueva', r'$A_1F(\vect{z})$, $A_1>A_0$', r'progreso\\ técnico')
cuerpo = capas([
    (1, "ejes", ejes()),
    (2, r"superficie inicial A_0 (tenue), otros plazos tenues e isocuanta \bar q (A_0)",
     superficie('superficietenue', r'$A_0F(\vect{z})$') + cp_corte_t + lp_rayo_t + lp_corte_t + q0 + [
         r"\node[etiqueta,text=tceemorado,anchor=west] at (axis cs:4,%s,0) {$\overline{q}\,(A_0)$};" % round(c0 / 4, 4)]),
    (3, "superficie A_1 y flechas hacia arriba", ml_sup2 + ml_fl2),
    (4, r"isocuanta \bar q (A_1), más cerca del origen", q1 + [
        r"\node[etiqueta,fondo,text=tceerojo,anchor=east,xshift=-3pt] at (axis cs:4,%s,0) {$\overline{q}\,(A_1)$};" % round(c1 / 4, 4),
        r"\draw[flecha] (axis cs:2,2,0) -- (axis cs:%s,%s,0);" % (round(c1 ** 0.5, 3) + 0.05, round(c1 ** 0.5, 3) + 0.05)]),
])
escribir('plazos-3d-muy-largo', 'Muy largo plazo: el progreso técnico desplaza la superficie hacia arriba y las isocuantas hacia el origen.', {'ml'}, cuerpo)
