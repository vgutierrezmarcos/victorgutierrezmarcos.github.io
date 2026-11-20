# Análisis por ratios: liquidez, solvencia y rentabilidad (con la descomposición de DuPont)

- **Área:** finanzas-empresa · **Tema de referencia:** **3.B.1** («Métodos de análisis económico y financiero de la empresa», en el título; revisado el 13/11/2026) — desarrollo. Ficha creada en la pasada final (noviembre de 2026) con el texto de C1 de `fuentes/3B01/_trabajo/propuestas-coherencia.md` (D4 del 3.B.1: EBT, no BAI ni RAI).
- **Temas que lo usan:** 3.B.1 (desarrollo; hecho, 13/11/2026), 3.B.2 (resumen; hecho, 8/11/2026: ROA, ROE y `eq:roe-roa`; tema de referencia del riesgo, GAO y GAF con el ejemplo 1.000/600/300/50), 3.B.3 (mención; hecho, 8/11/2026: $V_D/V_E$ contable, autofinanciación), 3.B.4 (uso; hecho, 8/11/2026: FCL, deuda neta, EV/EBITDA, $g^*=b\cdot\mathrm{ROE}$ con DuPont), 3.B.23 (mención: PER, EBIT), 1D01 (uso: ROE, cobertura de intereses de las empresas), 4.A.8 (previsto: ratios de la Central de Balances), 4.A.19 (mención: el ROA bancario es otro; ficha `indicadores-bancarios`).
- **Manuales de referencia:** Garrido Miralles e Íñiguez Sánchez (2017), *Análisis de estados contables*; Amat, *Análisis de estados financieros*; Vernimmen et al. (2017), *Corporate Finance*, caps. 9-13; Banco de España, Central de Balances (definición de las ratios R.1-R.3).
- **Alias:** `dupont`, `roe-roa`, `apalancamiento-financiero`.

## Presentación de referencia (3.B.1, III)
**Pregunta:** ¿puede la empresa pagar mañana, pagarlo todo y rendir más de lo que cuesta su dinero?

**Notación (canónica):** AC, ANC, PC, PNC, PN en redonda, $AT$ en cursiva (como el 3.B.2); FM, NOF, $\mathrm{AC}_{\mathrm{op}}$, $\mathrm{PC}_{\mathrm{op}}$; $V_D$ deuda con coste y $V_E$ patrimonio neto (**valor contable** en `eq:roe-roa`; en el WACC y en MM, de mercado); $r_D$; $t_{IS}$; EBITDA, EBIT, **EBT** (resultado antes de impuestos), EBIAT $=\mathrm{EBIT}(1-t_{IS})$ (= NOPAT); $p$, $c$, CF, MC $=(p-c)q$; $q^{\mathrm{PM}}$.

**Ecuaciones:**
- Liquidez: $\mathrm{FM}\equiv\mathrm{AC}-\mathrm{PC}=(\mathrm{PN}+\mathrm{PNC})-\mathrm{ANC}$; $\mathrm{NOF}\equiv\mathrm{AC}_{\mathrm{op}}-\mathrm{PC}_{\mathrm{op}}$; liquidez general AC/PC; prueba ácida (AC − existencias)/PC.
- Solvencia: $AT$/pasivo; PN/$AT$; pasivo/PN y $V_D/V_E$; deuda neta/EBITDA (deuda neta = deuda financiera − efectivo y activos financieros líquidos); cobertura EBIT/gastos financieros (variante con EBITDA).
- Rentabilidad: $\mathrm{ROA}=\mathrm{EBIT}/AT=$ margen × rotación (D062); $\mathrm{ROE}=\text{beneficio neto}/\mathrm{PN}$; `eq:roe-roa`: $\mathrm{ROE}=[\mathrm{ROA}+(V_D/V_E)(\mathrm{ROA}-r_D)](1-t_{IS})$, exacta con $AT=V_D+V_E$ (o sobre el activo neto); el $(1-t_{IS})$ multiplica a todo el corchete.
- DuPont (en redonda: es una empresa): $\mathrm{ROE}=\dfrac{\text{beneficio neto}}{\text{ventas}}\cdot\dfrac{\text{ventas}}{AT}\cdot\dfrac{AT}{\mathrm{PN}}$ (margen, rotación, apalancamiento: las 3 palabras del 3.B.4); 5 factores: $\dfrac{\text{BN}}{\mathrm{EBT}}\cdot\dfrac{\mathrm{EBT}}{\mathrm{EBIT}}\cdot\dfrac{\mathrm{EBIT}}{\text{ventas}}\cdot\dfrac{\text{ventas}}{AT}\cdot\dfrac{AT}{\mathrm{PN}}$.
- Riesgo: $q^{\mathrm{PM}}=\mathrm{CF}/(p-c)$; $\mathrm{GAO}=\mathrm{MC}/\mathrm{EBIT}$; $\mathrm{GAF}=\mathrm{EBIT}/(\mathrm{EBIT}-\text{intereses})=\mathrm{EBIT}/\mathrm{EBT}$; $\mathrm{GAT}=\mathrm{GAO}\cdot\mathrm{GAF}$.

**Resultado:** el endeudamiento sube el ROE si $\mathrm{ROA}>r_D$ y amplifica su variabilidad; el ROE tiene que superar el coste de los fondos propios, $r_E$ (3.B.2), no solo el ROA. Es la versión contable y *ex post* de la proposición II de Modigliani y Miller (3.B.3; ficha `modigliani-miller`). Basilea, en caja gris como paralelo bancario (ficha `basilea-capital`).

**Gráficos de referencia** (`oposicion/temario/fuentes/3B01/graficos/`): `balance-masas.tex` (balance de masas con el fondo de maniobra), `cascada-resultados.tex` (cascada del resultado), `dupont.tex` (árbol de DuPont), `gao-ventas.tex` (GAO frente a las ventas, con la asíntota en el punto muerto) y `apalancamiento-financiero.tex`.

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.B.1 | Análisis económico y financiero de la empresa | desarrollo (hecho, 13/11/2026) | Todo lo anterior; ratios en el anexo | El ejemplo numérico largo del riesgo (3.B.2) |
| 3.B.2 | Rentabilidad, riesgo y coste del capital | resumen (hecho, 8/11/2026) | ROA con DuPont en una línea, `eq:roe-roa`, GAO y GAF como riesgo, con su ejemplo | La lista de ratios |
| 3.B.3 | Decisiones de financiación | mención (hecho, 8/11/2026) | $V_D/V_E$ contable frente a $L=V_D/V$ de mercado; autofinanciación | `eq:roe-roa` |
| 3.B.4 | Crecimiento y valoración | uso (hecho, 8/11/2026) | FCL, deuda neta, EV/EBITDA, DuPont de 3 factores en $g^*$ | Las definiciones |
| 3.B.23 | Renta variable | mención | PER, EBIT en el EV/EBIT | — |
| 1D01 | Dictamen | uso | ROE frente al coste del capital; cobertura de intereses; el ROA bancario es otro | — |
| 4.A.8 | La empresa en España | previsto (uso) | Ratios de la Central de Balances (rentabilidad del activo neto frente al coste de la deuda) | Las definiciones |

## Divergencias encontradas en el temario actual
- 3.B.1 (original): ROA con EBIAT, ROE-ROA sin $(1-t_{IS})$ y con el pasivo total, GAO sobre el EBIAT, GAF con «beneficio bruto (EBIAT)», EBITDA confundido con el EBIT, deuda bruta = todo el pasivo. **Resuelto** en la revisión del 13/11/2026 (las contradicciones que anotaron el 3.B.2 y el 3.B.3 sobre el 3.B.1 quedan resueltas).
- 1D01 (l. 1539): «rentabilidad del activo (EBITDA sobre activos)»: no es el ROA de D062; decirlo (`pendientes-coherencia.md`).
- «DuPont» es una empresa: en redonda; el 3.B.4 la escribe con `\autor{}` y el 3.B.2 con `\emph{}` (`pendientes-coherencia.md`).

Autor: Víctor Gutiérrez Marcos
