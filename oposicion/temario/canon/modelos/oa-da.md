# Modelo de oferta y demanda agregadas (OA-DA), en economía cerrada y abierta

- **Área:** macro-abierta (y macro-cerrada) · **Tema de referencia:** **3.A.32** («El modelo de oferta y demanda agregada: determinación de renta e inflación en una economía abierta…»), **revisado el 11/11/2026** (I.2 `sec:da-oa` con la DA abierta, la OA con la cuña exterior, el equilibrio y la inflación importada; II.2 `sec:medio-plazo`; III.2-III.3 con las perturbaciones y las políticas de oferta; anexo B `anexo:oa-da`). **[decidir]** (CC3 del 3.A.32, A32-04): lo tiene en el título y es el único tema que lo desarrolla en extenso y con inflación. La **versión cerrada** (la DA como lectura del IS-LM para cada $P$, `eq:da`, y la OA con $W_0$ y vertical en $Y^n$) sigue desarrollada en el **3.A.5** (I.2 c), ficha `is-lm`), que el 3.A.32 resume con `\vertema{3.A.5}`: la cerrada es el caso $\beta_K=0$ con tipo flexible de la abierta. *Alternativa*: sin ficha propia, como sección c) de `is-lm` con la fila del 3.A.32.
- **Temas que lo usan:** 3.A.32 (desarrollo; hecho, 11/11/2026), 3.A.5 (desarrollo de la versión cerrada; hecho, 3/11/2026: `eq:da` como `\funcionclave`, `fig:da-oa`, efecto Keynes y Pigou-Patinkin, neutralidad y expulsión total a largo plazo), 3.A.4 (mención; hecho, 4/11/2026: l. 616, OA creciente hasta $Y_F$ y «solo precios» después, `\vertema{3.A.32}`; $Y_F$ es su notación, compatible), 3.A.28 (mención; hecho, 31/10/2026: la OA en tasas es la curva de Phillips aumentada; la NAIRU con WS-PS), 3.A.41 (mención; hecho, 5/11/2026: inflación de costes y segunda ronda), 3.A.42 (mención; hecho, 4/11/2026: perturbaciones de oferta y de demanda), 3.B.16 (resumen: OA-DA de 2 países en una unión monetaria, Baldwin y Wyplosz; devaluación interna), 3.B.11 (mención; hecho, 5/11/2026: la devaluación interna y el ajuste de España).
- **Manuales de referencia:** Blanchard, *Macroeconomics* (8.ª ed., 2021, `Blanchard2021Macroeconomics`): DA-OA y fijación de precios con insumos; Carlin y Soskice, *Macroeconomics* (2015, `CarlinSoskice2015Macroeconomics`); Layard, Nickell y Jackman (1991, `LayardNickellJackman1991Unemployment`) para la cuña; Bruno y Sachs (1985, `BrunoSachs1985Economics`) para la estanflación; Dornbusch, Fischer y Startz, *Macroeconomía*; Baldwin y Wyplosz para la versión de 2 países (3.B.16).

## Presentación de referencia (3.A.32, I.2 y anexo B)

**Pregunta:** ¿cómo se determinan la renta y los precios (la inflación) en una economía abierta, y cómo se ajusta según el régimen cambiario?

**De Mundell-Fleming a la DA:** como en la economía cerrada (`\vertema{3.A.5}`), basta con dejar libre $P$: a cada $P$ le corresponde un equilibrio IS-LM-BP (ficha `mundell-fleming`).

**La DA abierta** (`eq:da-abierta`, ecuación, no función clave). 2 efectos de un $P$ más alto: el **efecto saldos reales o efecto Keynes** (menos $M/P$, sube $i$, cae la inversión) y el **efecto competitividad**, nuevo (menos $q=EP^*/P$, caen las exportaciones netas). Con movilidad perfecta, $i=i^*$, cada régimen se queda con uno:
$$\text{DA con tipo fijo:}\quad Y=\frac{\overline A-b\,i^*+x\,Y^*+\nu\,\overline EP^*/P}{1-c\,(1-t)+m};\qquad \text{DA con tipo flexible:}\quad Y=\frac{M/P+h\,i^*}{k}.$$
Con tipo fijo, la DA sale de la IS (se mueve con la fiscal, la demanda exterior y las devaluaciones, no con el dinero, endógeno); con flexible, de la LM (se mueve con la monetaria, no con la fiscal). Sin movilidad y con tipo flexible, la DA es la cerrada `eq:da` del 3.A.5. Pendientes en el anexo B: $\partial Y/\partial P=-\nu\overline EP^*/\{[1-c(1-t)+m]P^2\}$ (fijo) y $-M/(kP^2)$ (flexible).

**La OA abierta:** a corto plazo creciente (salarios nominales fijados con precios esperados, `\vertema{3.A.5}`); la economía abierta añade 2 vías: **insumos importados** (actúan como una subida del margen $\mu$, Blanchard) y **salario de consumo**: con una parte $\alpha$ del consumo importada (**α grado de apertura**, local y avisada, no la participación del capital), $P_C=P^{1-\alpha}(EP^*)^{\alpha}$ y $P_C/P=q^{\alpha}$. **En tasas**, la OA de corto plazo es la curva de Phillips aumentada $\pi_t-\pi^e_t=-a(U_t-U^n)+\varepsilon_t$ (`\vertema{3.A.28}`), con $\varepsilon_t$ la perturbación de oferta (la $u_t$ de la NKPC, con la letra de cada modelo; aviso del 3.A.41). **A medio plazo**, vertical en $Y^n$ (la de la NAIRU $U^n$; **OA$_{\mathrm{LP}}$** en los gráficos, como el 3.A.5). Con WS-PS escrito con el índice de consumo, $W/P_C^e=F(U,Z)\cdot\mathrm{PAT}^e$ y $W/P=\mathrm{PAT}/(1+\mu)$:
$$\text{NAIRU abierta (\texttt{eq:nairu-abierta}, \textbackslash funcionclave):}\quad F(U^n,Z)=\frac{1}{(1+\mu)\,q^{\alpha}}$$
la **cuña exterior** (Layard, Nickell y Jackman, 1991): si los salarios reales de consumo se resisten, una depreciación real o una energía más cara ($q\uparrow$, $\mu\uparrow$) suben la NAIRU y mueven la OA$_{\mathrm{LP}}$ a la izquierda (Bruno y Sachs, 1985). Con $\alpha=0$, la `eq:nairu` del 3.A.28. Matiz del anexo B: con $E$ fijo la OA$_{\mathrm{LP}}$ se inclina algo; el cuerpo la dibuja vertical para una cuña dada.

**Equilibrio y ajuste:** a corto plazo DA ∩ OA; a medio plazo sobre la OA$_{\mathrm{LP}}$. Con tipo flexible, el nominal hace deprisa el ajuste de precios relativos; con tipo fijo o en una unión monetaria, solo cambian los precios nacionales frente a los de fuera: la **devaluación interna** (`\vertema{3.B.11}`, `\vertema{3.B.16}`), lenta. A medio plazo con tipo fijo, $\nu\,\Delta q=-\Delta\overline G$ (la expansión fiscal acaba en apreciación real y menos exportaciones netas).

**La inflación en una economía abierta** (`\funcionclave` `eq:inflacion-abierta`):
$$\pi_t\simeq(1-\alpha)\,\pi_{H,t}+\alpha\,\big(\gamma_{E,t}+\gamma_{P^*,t}\big)$$
con **$\pi_{H,t}$ inflación de los bienes nacionales**, $\gamma_{E,t}$ depreciación nominal y **$\gamma_{P^*,t}$ inflación exterior** (no $\pi^*$, que es el objetivo; A32-08, **[decidir]**). El segundo sumando es la **inflación importada** (efecto directo); los efectos indirectos y de segunda ronda la llevan a $\pi_{H,t}$ (`\vertema{3.A.41}`). Traspaso incompleto: facturación en dólares (Gopinath, 2020); zona del euro, 0,3 % a los precios de importación y 0,04 % al IAPC por cada 1 % de depreciación (Ortega y Osbat, 2020; Comunale y Kunovac, 2017).

**Perturbaciones y políticas de oferta (III):** una perturbación de oferta adversa (energía importada) sube la OA de corto plazo, mueve a la izquierda la de largo (si los salarios reales se resisten) y baja algo la DA: estanflación; el dilema (`\vertema{3.A.36}`), «mirar a través» del efecto directo y responder a la segunda ronda; el tipo flexible amortigua las perturbaciones reales. Una política de oferta mueve las 2 OA a la derecha: más renta, precios más bajos y tipo real más depreciado; devaluación fiscal (Farhi, Gopinath e Itskhoki, 2014). Tabla resumen `tab:perturbaciones` (perturbación × régimen × respuesta, anexo D).

**Gráficos de referencia:**
- **`fuentes/3A32/graficos/da-oa-abierta.tex`** (**imprescindible**): 2 paneles con tipo fijo, con los valores de `da-oa` del 3.A.5: a, expansión fiscal ($A\to B$ a corto plazo; $C$ a medio plazo en $Y^n$, con menos exportaciones netas); b, devaluación interna desde una recesión ($A\to C$, despacio).
- **`fuentes/3A32/graficos/oferta-abierta.tex`** (**imprescindible** en III): a, perturbación de oferta adversa ($A\to B$, estanflación); b, política de oferta ($B$ a corto plazo, $C$ a medio plazo).
- Versión cerrada: **`fuentes/3A05/graficos/da-oa.tex`** (3.A.5; DA decreciente, OA con $W_0$ y vertical en $Y^n$).
- Puntos $A$, $B$, $C$ y equilibrios $Y_0$, $Y_1$ (nunca $E$ ni asterisco: K11, D038).

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.32 | Renta e inflación en economía abierta; políticas; perturbaciones y políticas de oferta | desarrollo (referencia, [decidir]; hecho, 11/11/2026) | Todo lo anterior; `eq:da-abierta`, `eq:nairu-abierta` y `eq:inflacion-abierta` (las 2 últimas, funciones clave); `da-oa-abierta` y `oferta-abierta`; anexo B paso a paso | — |
| 3.A.5 | La síntesis neoclásica | desarrollo de la versión cerrada (hecho, 3/11/2026) | `eq:da` como función clave, OA con $W_0$ (local) y vertical en $Y^n$, `fig:da-oa`; efectos Keynes y Pigou-Patinkin; neutralidad del dinero y expulsión total; políticas de rentas | La versión abierta |
| 3.A.4 | Keynes y los postkeynesianos | mención (hecho, 4/11/2026) | OA creciente hasta $Y_F$ (su notación, canon § 8) y después solo precios, `\vertema{3.A.32}` | El modelo |
| 3.A.28 | Paro de equilibrio | mención (hecho, 31/10/2026) | La OA en tasas = curva de Phillips aumentada; WS-PS y `eq:nairu` (la abierta, con la cuña $q^{\alpha}$, en el 3.A.32) | La OA-DA |
| 3.A.41 | Causas de la inflación | mención (hecho, 5/11/2026) | Inflación de costes, efectos directos, indirectos y segunda ronda, 2021-2026 (ficha `triangulo-gordon`); las mismas cifras que el 3.A.32 (10,6 % en octubre de 2022) | La OA-DA abierta |
| 3.A.42 | Ciclos económicos | mención (hecho, 4/11/2026) | Perturbaciones de oferta y de demanda; Galí (1999) con las mismas palabras que el 3.A.32 | La OA-DA |
| 3.B.16 | Integración monetaria | resumen | OA-DA de 2 países en una unión monetaria (Baldwin y Wyplosz); la devaluación interna con `\vertema{3.A.32}` | La derivación de la DA abierta |
| 3.B.11 | Balanza de pagos | mención (hecho, 5/11/2026) | La devaluación interna y el ajuste de España 2008-2013 (mismas cifras: déficit corriente del 9,4 % en 2007, superávit desde 2012) | El modelo |

## Divergencias encontradas en el temario actual
- `informe-repaso.md` (§ 8, l. 324) decía «OA-DA de 3.A.37»: el 3.A.37 revisado no tiene OA-DA (tiene la DA con codo de la NEK, `nek-limite-inferior`, que es otra cosa); la OA-DA cerrada está en el 3.A.5. Corregido el 11/11/2026 (CC7 del 3.A.32).
- Notación de la producción natural: $Y_F$ (3.A.4, pleno empleo), $Y_n$ (Word del 3.B.17) frente a **$Y^n$** (3.A.5, 3.A.32; canon § 0).
- Tebar (fuente de referencia del 3.A.32) llamaba a κ «pendiente de la brecha» con $\kappa=(1-\theta)(1-\beta\theta)/\theta$; es el coeficiente del coste marginal (ficha `nek-3-ecuaciones`).

Autor: Víctor Gutiérrez Marcos
