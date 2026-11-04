# Demanda de bienes de consumo duradero: coste de uso, Mankiw (1982) y la regla (S,s) (Grossman y Laroque, 1990; Bertola y Caballero, 1990; Caballero, 1993; Eberly, 1994)

- **Área:** macro cerrada · **Tema de referencia:** **3.A.33** (revisado el 31/10/2026: bloque III `sec:duraderos`, entero nuevo, con III.1 `sec:duraderos-modelo`, III.2 `sec:duraderos-ajuste`, III.3 `sec:duraderos-evidencia` y el anexo D `anexo:duraderos`) — «La demanda de bienes de consumo duradero» está en su título. Ficha creada en la fase canon del 3.A.33 (K27, DC1/A33-01, **[decidir]**).
- **Temas que lo usan:** 3.A.33 (desarrollo; hecho, 31/10/2026), 3.A.34 (mención; hecho, 31/10/2026: la compra de duraderos como inversión del hogar; la regla (S,s) de los costes fijos en III.1, la opción de esperar en III.3 c) y la conclusión, con `\vertema{3.A.33}`), 3.A.42 (hecho, 4/11/2026, ver la tabla; mención: el gasto en duraderos, mucho más volátil y procíclico que el PIB; ficha `hechos-estilizados-ciclo`), 3.A.37 (mención: el componente del consumo más sensible al tipo de interés), 3.A.8 y 3.A.9 (mención; hecho: el marco estático deja fuera los duraderos, con `\vertema{3.A.33}`), 1D01 (mención aplicada; hecho: «duraderos, mayor» volatilidad en `tab:hechos-ciclo`).
- **Manuales de referencia:** Mankiw (1982), *JME*; Bernanke (1983), *QJE*, y (1985), *JME*; Grossman y Laroque (1990), *Econometrica*; Bertola y Caballero (1990), *NBER Macro Annual*; Caballero (1993), *Econometrica*; Eberly (1994), *JPE*; Dixit y Pindyck (1994); Romer (2019), cap. 8; Attanasio y Weber (2010), *JEL*.

## Presentación de referencia (3.A.33, III)

Pregunta: ¿por qué el gasto en duraderos es tan volátil y tan sensible a la política? Conclusión anticipada: el hogar suaviza el **servicio**, no el **gasto**; la compra se comporta como una inversión: irregular, aplazable, sensible al tipo de interés y al crédito, y amplifica el ciclo.

- **III.1 Particularidades y coste de uso** (a)-e)). Stock d_t (presta servicios) frente a gasto I^d_t; d_t = (1 − δ)d_{t−1} + I^d_t; sin mercados de alquiler, hay que comprar. Problema (`eq:problema-duraderos`, con `\optim`):
$$\max_{\{C_t,\,d_t\}}\ \sum_{t=0}^{T}\beta^t u(C_t,d_t)\quad\text{s.a.}\quad b_{t+1}=(1+r)\,b_t+Y_t-C_t-p^d_tI^d_t,\quad I^d_t=d_t-(1-\delta)\,d_{t-1},\quad b_0,\ d_{-1}\ \text{dados},\ b_{T+1}\ge0$$
  2 Euler: u_C(C_t,d_t) = β(1+r)u_C(C_{t+1},d_{t+1}) y p^d_t u_C(t) = u_d(t) + β(1−δ)p^d_{t+1}u_C(t+1); **coste de uso** (`\funcionclave` `eq:coste-uso`):
$$\frac{u_d(C_t,d_t)}{u_C(C_t,d_t)}=c^d_t\equiv p^d_t-\frac{1-\delta}{1+r}\,p^d_{t+1}\simeq p^d_t\,\big(r+\delta-\pi^d_{t+1}\big)$$
  con los 3 componentes del coste de uso del capital del 3.A.34, $c_K=P^K(r+\delta-\dot P^K/P^K)$ (ficha `jorgenson`). Implicaciones: se suaviza el servicio, no el gasto; **amplificación 1/δ** (con δ = 20 % anual, un 1 % más de stock deseado es un 5 % más de gasto); pesan el tipo de interés y el crédito; la compra se aplaza. **Extensión: Mankiw (1982)** en el marco de Hall (utilidad separable u(C_t) + v(d_t), v cuadrática, p^d constante): el stock es la martingala, d_{t+1} = d_t + e_{t+1}, y el gasto
$$I^d_{t+1}-I^d_t=e_{t+1}-(1-\delta)\,e_t\qquad(\texttt{eq:mankiw})$$
  (ARMA(1,1); autocorrelación de los cambios −(1−δ)/[1+(1−δ)²] ≈ −0,5); **evidencia**: los datos no la muestran (AR(1)), otro rechazo de Hall (Mankiw, 1982; Bernanke, 1985). Valoración: faltan los costes de ajuste (venta del usado con descuento, `\vertema{3.A.13}`).
- **III.2 Costes de ajuste, irreversibilidad e incertidumbre** (a)-e)). Convexos (ajuste gradual, Bernanke, 1985) frente a fijos o proporcionales: **regla (S,s)** (Grossman y Laroque, 1990): mientras d_t/d*_t esté en la banda (s, S) no se compra; al tocar un límite, ajuste de golpe; banda más ancha con más coste y más incertidumbre; el agregado depende de la distribución de los hogares (Bertola y Caballero, 1990; Caballero, 1993; Berger y Vavra, 2015: menos eficaz en las recesiones). Irreversibilidad y **valor de opción** de esperar (Bernanke, 1983; Dixit y Pindyck, 1994; `\vertema{3.A.34}`, ficha `opciones-reales`). Evidencia: Eberly (1994), banda en la compra de coches.
- **III.3 Evidencia e implicaciones**: España (INE, CNTR): 6,9 % del consumo en 2025; desviación típica de la tasa interanual 10,6 frente a 2,0 (no duraderos), 4,5 (consumo) y 3,9 (PIB), 1996-2026; −17,9 % (2009-T1), −12,6 % (2012-T4), −43,4 % (2020-T2), +68,6 % (2021-T2); Fernández-Villaverde y Krueger (2011). Política: monetaria (coste de uso y crédito, `\vertema{3.A.37}`); fiscal: los incentivos **adelantan** compras (*Cash for Clunkers*, Mian y Sufi, 2012: unos 370.000 coches en julio-agosto de 2009, compensados en 10 meses; planes franceses, Adda y Cooper, 2000; PIVE, 2012); vivienda como inversión (`\vertema{3.A.30}`) con efecto riqueza. Cierra con `tab:implicaciones` de todo el tema (ficha `hall`).

**Gráficos de referencia** (`oposicion/temario/fuentes/3A33/graficos/`): `duraderos-ss.tex` (**imprescindible**, por capas: d_t/d*_t en el tiempo con las bandas s y S, el objetivo y los saltos; debajo, el gasto esporádico) y `duraderos-datos.tex` (datos de España, en el cuerpo, no se dibuja en el cante).

**Notación:** d_t stock (local: en § 8, d_t es la ratio de deuda; no conviven), p^d_t precio relativo, I^d_t gasto, δ depreciación sin subíndice (§ 7), c^d_t coste de uso (avisado: c sola es la PMgC), π^d_{t+1} variación del precio relativo, u_C y u_d utilidades marginales, d*_t stock deseado, (s, S) bandas (locales de III.2: S es también el ahorro en nivel, que no sale en III), e_{t+1} innovación del stock y v(d_t) en Mankiw (locales del anexo D). En el bloque III, **C_t es el consumo no duradero** (nota al empezar III). La I^d_t hace visible la analogía con la I_t del 3.A.34.

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.33 | Demanda de duraderos | desarrollo (hecho, 31/10/2026) | Todo lo anterior en 7′: coste de uso recuadrado, Mankiw de palabra, (S,s) por capas, datos e implicaciones | — |
| 3.A.34 | Inversión | mención (hecho, 31/10/2026) | «Con los hogares, la compra de duraderos»: misma δ, c^d frente a c_K, la opción de esperar también la retrasa; `\vertema{3.A.33}` | El modelo |
| 3.A.42 | Ciclos | mención (hecho, 4/11/2026; I.2.2 con nota y `\vertema{3.A.33}`) | Duraderos más volátiles y procíclicos que el PIB; no duraderos, menos | El modelo |
| 3.A.37 | Transmisión monetaria | mención | Canal del coste de uso y del crédito sobre los duraderos | El modelo |
| 3.A.8, 3.A.9 | Consumidor estático | mención (hecho) | El marco estático los deja fuera, con `\vertema{3.A.33}` | — |
| 1D01 | Dictamen | mención aplicada (hecho) | Más volátiles que el consumo en `tab:hechos-ciclo` | — |

## Divergencias encontradas en el temario actual
- 3.A.33 original: duraderos solo en un anexo copiado de ICEX-CECO, con ∂u(c_t,d_t)/∂c_{t+1}, r_t y r_{t+1} mezclados, s_t y δ_d. **Resuelto** (31/10/2026): bloque III nuevo y anexo D redactado de nuevo.
- 3.A.34 (revisado, 31/10/2026): sin contradicción (usa c_K con la misma δ y r y remite al 3.A.33 en III.1, III.3 y la conclusión).

Autor: Víctor Gutiérrez Marcos
