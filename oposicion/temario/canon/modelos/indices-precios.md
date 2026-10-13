# Índices de coste de la vida e índices de Laspeyres y Paasche

- **Área:** consumidor-producción · **Tema de referencia:** **3.A.9** (Demanda II: medidas de cambio en el bienestar; revisado el 13/10/2026, III.3) — único que lo desarrolla con la función de gasto.
- **Temas que lo usan:** 3.A.9 (desarrollo; hecho), 4.A.1 (resumen: IPC, IPI, ICLA); 3.A.8 lo menciona (preferencia revelada) y 3.A.30 lo usa (deflactor del PIB).
- **Manuales de referencia:** Konüs (1924/1939); Mas-Colell, Whinston y Green, §3.I; Deaton y Muellbauer (1980), cap. 7; Diewert (1976) (índices superlativos); Varian, cap. 8; manual del IPC del INE y de Eurostat (4.A.1).
- **Decisión D044 (13/10/2026):** ¿Qué letra llevan las ponderaciones de los índices (IPC, tipos de cambio efectivos, ITC)? ω_i (ω_{i,t−1} en el IPC; media geométrica con pesos ω_i en los tipos efectivos)

## Presentación de referencia
Pregunta: ¿cuánto hay que compensar al consumidor ante un cambio de precios, cuando solo se observan precios y cantidades?

- **Variaciones de cesta fija** (3.A.9, `eq:var-laspeyres-paasche`; $L$ y $P$ son letras locales):
$$L\equiv\overline W-p^1\cdot x^0=(p^0-p^1)\cdot x^0,\qquad P\equiv p^0\cdot x^1-\overline W=(p^0-p^1)\cdot x^1$$
Acotan las medidas exactas (ficha `vc-ve`), para cualquier número de precios y tipo de bien:
$$L\le\mathrm{VC}\qquad\text{y}\qquad\mathrm{VE}\le P,$$
porque $p^1\cdot x^0\ge E(p^1,\overline U^0)$ y $p^0\cdot x^1\ge E(p^0,\overline U^1)$. Dicho de otro modo, $p^1\cdot x^0-\overline W\ge-\mathrm{VC}$ y $(p^1-p^0)\cdot x^1\le-\mathrm{VE}$. Para un bien normal, $L\le\mathrm{VC}\le\Delta\mathrm{EC}\le\mathrm{VE}\le P$.
- **Índice verdadero de Konüs**, con la función de gasto:
$$I_K(p^0,p^1;\overline U)=\frac{E(p^1,\overline U)}{E(p^0,\overline U)};\qquad I_K(\overline U^0)=\frac{E(p^1,\overline U^0)}{\overline W}\ \text{(versión VC)},\quad I_K(\overline U^1)=\frac{\overline W}{E(p^0,\overline U^1)}\ \text{(versión VE)}$$
- **Aproximaciones observables**:
$$I_L=\frac{p^1\cdot x^0}{p^0\cdot x^0}\ \ge I_K(\overline U^0),\qquad I_P=\frac{p^1\cdot x^1}{p^0\cdot x^1}\ \le I_K(\overline U^1)$$
**Acotan dos índices verdaderos distintos**: solo con preferencias homotéticas $I_K$ no depende de $\overline U$ y entonces $I_P\le I_K\le I_L$. Las igualdades, solo sin posibilidad de sustitución (Leontief). Laspeyres es la aproximación de primer orden de $E(p^1,\overline U^0)$ y, por la concavidad de $E$, cota superior (no «aproximación de Taylor» a secas). La diferencia es el **sesgo de sustitución**.
- **Índices superlativos** (Diewert, 1976): Fisher $I_F=\sqrt{I_LI_P}$, exacto para una función de gasto cuadrática homogénea; Törnqvist $\ln I_T=\sum_i\tfrac12(s_i^0+s_i^1)\ln(p_i^1/p_i^0)$, exacto para una translog (puente con los sistemas de demanda).
- **Magnitud del sesgo**: Comisión Boskin (1996), 1,1 puntos al año, de ellos 0,4 de sustitución; Manser y McDonald (1988), 0,18 puntos (1959-1985); C-CPI-U (Törnqvist encadenado) 0,25-0,3 puntos por debajo del CPI-U.
- **Aplicaciones**: el IPC es un Laspeyres encadenado (ficha `ipc`); el deflactor del PIB, un Paasche encadenado (volúmenes encadenados del SEC 2010) [3.A.30].

Gráfico de referencia: plano $(x_1,x_2)$, cesta $x^0$ en $\overline U^0$, recta con precios $p^1$ que pasa por $x^0$ (Laspeyres) frente a la paralela tangente a $\overline U^0$ (Konüs): `oposicion/temario/fuentes/3A09/graficos/indice-konus-laspeyres.tex`. Las variaciones $L$ y $P$, como rectángulos, en las últimas capas de `bienestar-vc-ve.tex`.

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.9 | Medidas de cambio en el bienestar | desarrollo (hecho, 13/10/2026) | Variaciones $L$ y $P$ con sus cotas, Konüs en sus dos versiones, cotas de Laspeyres y Paasche, homotéticas, superlativos, sesgo y su magnitud; cajas del IPC (base 2025) y del deflactor | La metodología estadística (4.A.1) |
| 4.A.1 | Fuentes estadísticas | resumen | IPC como Laspeyres encadenado con ponderaciones $\omega_{i,t-1}$ actualizadas cada año; sesgos (sustitución, calidad, nuevos bienes); deflactor del PIB como Paasche encadenado | La derivación con la función de gasto (remitir a 3.A.9) |
| 3.A.30 | Contabilidad nacional | mención | Deflactor implícito del PIB como Paasche encadenado | — |
| 3.A.8 | Preferencia revelada | mención | Las comparaciones con Laspeyres y Paasche se basan en el ADPR [3.A.9] | — |

## Divergencias encontradas en el temario actual
- **Esta ficha** decía «$p^1\cdot x^0-\overline W\ge VC$» (signo cambiado con la convención de `vc-ve`) y presentaba Laspeyres y Paasche como cotas del mismo índice; corregida el 13/10/2026 a raíz del 3.A.9 (ver `cambios.md`).
- 3.A.9 original: $q$ para las cantidades, superíndice $t$, Laspeyres y Paasche como «aproximación mediante una serie de Taylor» y «no es posible calcular el índice de variación compensatoria»; resuelto en la revisión.
- 4.A.1 usa $w_{i0}$ para ponderaciones: choca con $w$ = precios de factores; canon $\omega_{i,t-1}$ (en 4.A.1, estadística, puede mantenerse $q_{it}$ para las cantidades si se avisa).
- 4.A.1 presenta el IPC a la vez como Laspeyres de base fija y encadenado (ficha `ipc`).
