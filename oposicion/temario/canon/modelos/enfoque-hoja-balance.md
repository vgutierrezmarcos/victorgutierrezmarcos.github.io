# Enfoque de la hoja de balance (enfoque de balances)

- **Área:** macro-abierta · **Tema de referencia:** 3.B.11 (Balanza de pagos: concepto, medición e interpretación) — **[decidir]** (D5 de la coherencia del 3.B.11): lo desarrolla en un apartado propio, III.3 «El enfoque de la hoja de balance», con la estructura a)-c) de un modelo, y es el tema que define la PIIN y sus 3 medidas (II.7); el 3.B.12 lo usa como parte de la sostenibilidad, que ya tiene ficha (`sostenibilidad-deuda-externa`), y el 3.B.17 lo menciona en las crisis. *Alternativas*: b) el 3.B.12 de referencia, con el 3.B.11 en resumen; c) no crear ficha y quitar el id de `mapa.yaml` (la 1D01 lo cuenta en una viñeta). Ficha nueva del 5/11/2026 (el id estaba en `mapa.yaml`, en la lista del 3.B.11, sin fichero ni entrada en `modelos:`).
- **Temas que lo usan:** 3.B.11 (desarrollo; hecho, 5/11/2026), 1D01 (uso: V.3, «enfoque de balances», l. 1305, los descalces con `Allen2002Balances`), 3.B.12 (resumen; hecho, 11/11/2026: efectos de valoración con $\mathrm{OV}_t$, pecado original, composición por moneda, plazo e instrumento en `tab:indicadores-externos`, `\vertema{3.B.11}`), 3.B.17 (resumen; hecho, 12/11/2026: II.2.2-II.2.3, los descalces en las crisis gemelas de Krugman, 1999, el pecado original con `EichengreenHausmann1999`, `EHP2003Mismatches` y `EHP2005PecadoOriginal`, el miedo a flotar y la intolerancia a la deuda, con `\vertema{3.B.11}`; fichas `krugman-hojas-balance` y `paradas-subitas`), 3.B.22 (mención: los análisis de vulnerabilidad del FMI), 3.B.29 (mención: deuda externa de los países en desarrollo, pecado original), 4.A.21 (uso: PIIN, PIIN sin instrumentos sin riesgo de impago y deuda externa de España); 3.B.15 (mención; hecho, 12/11/2026: I.2.4, el pecado original y los descalces con la depreciación que hunde los balances de los deudores en dólares, Eichengreen y Hausmann, 1999, `\vertema{3.B.11}`; la «redención» y el pecado original en manos de extranjeros)
- **Manuales de referencia:** Allen, Rosenberg, Keller, Setser y Roubini (2002), «A Balance Sheet Approach to Financial Crisis», FMI WP 02/210 (clave `Allen2002Balances`); FMI (2014), *External Debt Statistics: Guide for Compilers and Users* (`FMI2014DeudaExterna`); Eichengreen, Hausmann y Panizza (2005) (pecado original; `EHP2005PecadoOriginal`); Kaminsky y Reinhart (1999) (crisis gemelas); Lane y Milesi-Ferretti (2007) (posiciones exteriores); Obstfeld (1996) (equilibrios múltiples).

## Presentación de referencia
Estructura a)-c) del 3.B.11, III.3.

**a) Idea.** Los flujos no bastan: las crisis de los emergentes de finales de los 90 (Asia, Rusia, Brasil, Argentina) no se vieron venir mirando la cuenta corriente, sino los balances de los sectores (deudas a corto y en divisas frente a activos a largo y en moneda nacional). El enfoque mira los saldos acumulados de activos y pasivos, del país y de cada sector, y su composición, para ver cómo una debilidad de balance se convierte en una crisis.

**Pregunta:** ¿qué vulnerabilidades revela el balance de un país y de sus sectores que no ven los flujos?

**b) Modelo. i) Supuestos:** balances a precios de mercado; los activos y pasivos entre residentes se cancelan al consolidar el del país (no en el análisis por sectores).

**ii) Desarrollo (notación canónica):**
- Riqueza de la nación (`eq:riqueza`), **sin letra** (B11-15: no W, que es la riqueza del consumidor, $\overline W$):
$$\text{riqueza nacional neta}=K+\mathrm{PIIN}$$
- Su variación (`eq:variacion-riqueza`), con la inversión **neta** $I-\delta K$, la identidad `eq:identidad-bp` y $\mathrm{CC}=S-I$ (sin errores y omisiones):
$$\Delta(\text{riqueza})=(I-\delta K)+\mathrm{CF}+\mathrm{OV}=\underbrace{(S-\delta K)}_{\text{ahorro neto}}+\mathrm{CK}+\mathrm{OV}^K+\mathrm{OV}^F$$
con $\mathrm{OV}^K$ las revalorizaciones del capital y $\mathrm{OV}^F$ las otras variaciones de la posición exterior (locales). El Word sumaba la inversión **bruta** y sobrestimaba la riqueza en la depreciación: corregido.
- Dinámica de la posición (`eq:dinamica-piin`, la misma ecuación y etiqueta que la 1D01; PIIN en mayúsculas aun en % del PIB, avisado, B11-13): $\mathrm{PIIN}_t-\mathrm{PIIN}_{t-1}\approx\mathrm{CF}_t+\mathrm{OV}_t-\frac{\gamma^N_t}{1+\gamma^N_t}\mathrm{PIIN}_{t-1}$; la condición de sostenibilidad y el saldo estabilizador, en la ficha `sostenibilidad-deuda-externa` (anexo E del 3.B.11).
- Las 3 medidas de la posición (II.7 del 3.B.11), de más amplia a más estricta: **PIIN**; **PIIN excluidos los instrumentos sin riesgo de impago** (sin acciones y participaciones ni la deuda intragrupo; Eurostat y la Comisión, PDM); **deuda externa bruta** (solo pasivos exigibles: préstamos, depósitos, bonos, créditos comerciales; sin acciones, inversión directa en capital ni derivados).

**iii) Implicaciones:**
- Un país solo se enriquece ahorrando, recibiendo transferencias de capital o con ganancias de capital: pedir prestado no enriquece (si financia inversión, cambia deuda por capital; si financia consumo, empobrece).
- Los **descalces** (Allen *et al.*, 2002): de **estructura de capital** (deuda frente a acciones: por eso se mira la deuda externa bruta y no solo la PIIN); de **plazos** (pasivos a corto frente a pocos activos líquidos); de **monedas** (deuda en divisas sin cubrir: una depreciación empobrece y puede anular el impulso exportador; con activos en divisas y pasivos en moneda propia, como Estados Unidos, la depreciación enriquece; el **pecado original**, crisis gemelas `\vertema{3.B.17}`); de **solvencia** (balances de los sectores enlazados, contagio a través de la banca); y, con la PII por países, la **concentración** en un acreedor.
- Hace falta un margen: con expectativas que se autocumplen, un país solvente puede caer en una crisis (equilibrios múltiples; Obstfeld, 1996).

**c) Valoración:** completa la lectura de los flujos con la de los saldos y su composición; lo usan el FMI (análisis de vulnerabilidad) y la UE (PDM: PIIN −35 % del PIB). Límites: necesita datos de balance por sectores, monedas y plazos que muchos países no tienen y no dice qué nivel de deuda es demasiado.

**Resultado:** la vulnerabilidad depende de la **composición** del balance (plazos, monedas, estructura de capital, solvencia, sectores y acreedores), no solo del saldo neto.

**Gráfico de referencia:** el balance de la nación, una T con el capital $K$ y los activos exteriores en el activo y los pasivos exteriores (deuda y no deuda) y la riqueza nacional neta en el pasivo, con los descalces al margen junto a la partida a la que afectan: **`fuentes/3B11/graficos/balance-nacion.tex`** (`fig:balance-nacion`, III.3 del 3.B.11; imprescindible en la pizarra).

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.B.11 | Interpretación del saldo agregado | desarrollo (hecho, 5/11/2026) | a)-c) completo: `eq:riqueza`, `eq:variacion-riqueza`, `eq:dinamica-piin` de palabra en el cante, los descalces, `balance-nacion`; las 3 medidas en II.7 | La derivación del saldo estabilizador (anexo E, ficha `sostenibilidad-deuda-externa`) |
| 1D01 | Dictamen de coyuntura | Uso | «Enfoque de balances» (l. 1305): las crisis de los 90 y los descalces de cada sector, con `Allen2002Balances`; PIIN y deuda externa | El balance de la nación |
| 3.A.30 | Contabilidad nacional | mención (hecho, 11/11/2026; II.4, balances, con `\vertema{3.B.11}`) | Riqueza nacional neta = capital no financiero + PIIN, sin letra; `eq:balance` en palabras; la solvencia y el riesgo de los balances por sectores | Los descalces y la dinámica |
| 3.B.12 | Sostenibilidad del déficit y de la deuda exterior | resumen (hecho, 11/11/2026) | La composición de la deuda (moneda, plazo, instrumento) como complemento de la condición de estabilidad, con `\vertema{3.B.11}` | El balance de la nación y los descalces en detalle |
| 3.B.17 | Crisis de BP | resumen (hecho, 12/11/2026) | Papel de los descalces y del pecado original en las crisis: la parada súbita como detonante y las hojas de balance como amplificador; 3 conceptos que no se confunden (pecado original, intolerancia a la deuda, descalce de monedas) (fichas `krugman-hojas-balance` y `paradas-subitas`); `\vertema{3.B.11}` | La definición de la PIIN y de los descalces (aquí) |
| 3.B.22 | El FMI | mención (sin revisar) | Los análisis de vulnerabilidad del FMI (balance por sectores) | — |
| 3.B.29 | Deuda externa de los países en desarrollo | mención (sin revisar) | Pecado original y descalces de monedas | — |
| 4.A.21 | BP y PII de España | uso (sin revisar) | PIIN, PIIN sin instrumentos sin riesgo de impago y deuda externa bruta de España con su evolución; composición (Banco de España frente al resto) | La teoría del enfoque |
| 3.B.15 | Regímenes cambiarios | mención (hecho, 12/11/2026) | I.2.4: pecado original y descalces según el régimen (con flotación, la depreciación hunde los balances; con tipo fijo, defender exige subir tipos); hoy, endeudamiento en moneda local en manos de extranjeros; `\vertema{3.B.11}` | La PII |

## Terminología
«Enfoque de la hoja de balance» (título del III.3 del 3.B.11) o «enfoque de balances» (1D01): los 2 nombres valen y se dan juntos la primera vez (`notacion.md` § 14).

## Divergencias encontradas en el temario actual
- El Word del 3.B.11 sumaba la inversión bruta al capital y usaba después el ahorro bruto: sobrestimaba la riqueza en la depreciación (corregido con magnitudes netas).
- El Word del 3.B.11 decía al revés cuándo el efecto riqueza de una depreciación compensa y cuándo refuerza el de las exportaciones netas (corregido: con pasivos en divisas, compensa; con activos en divisas, refuerza).
- La 1D01 dice «enfoque de balances» y el 3.B.11 «enfoque de la hoja de balance»: mismo concepto y misma fuente; los 2 nombres son canon (sin cambiar la 1D01).

Autor: Víctor Gutiérrez Marcos
