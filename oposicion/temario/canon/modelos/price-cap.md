# Regulación por precio máximo IPC − X (Littlechild, 1983) y esquemas intermedios

- **Área:** mercados-información-juegos · **Tema de referencia:** 3.A.20 (II.4, `sec:price-cap`, «Regulación por incentivos: precios máximos y esquemas intermedios», con a)-e); **hecho, 22/10/2026**). Pasa del 3.A.17 al 3.A.20 por la P21-02 (Víctor, 21/10/2026); el 3.A.17 queda en mención, con su anexo A resumido (`pendientes-coherencia.md`, sección del 3.A.20). Así, la remisión del 4.A.12 al 3.A.20 es la correcta.
- **Temas que lo usan:** 3.A.20 (desarrollo; hecho, 22/10/2026), 3.A.17 (hoy desarrollo en el anexo A, no se canta; pasa a mención con `--fase coherencia` cuando Víctor apruebe el 3.A.20: una viñeta con la regla), 3.A.15 (mención; hecho, 20/10/2026: anexo A, el *price cap* de Littlechild, 1983, para la British Telecom privatizada como respuesta austriaca a la regulación que desanima la innovación), 4.A.12 (mención: Telefónica, Aena), 4.B.15 (resumen; hoy mención); 4.A.5 (energía) podría citarlo.
- **Manuales de referencia:** Littlechild (1983); Vogelsang y Finsinger (1979); Armstrong, Cowan y Vickers (1994), *Regulatory Reform*; Armstrong y Sappington (2007); Viscusi, Harrington y Vernon, cap. 12; Joskow (2014).

## Presentación de referencia (3.A.20, II.4)

- **a) Idea**: el menú de Laffont-Tirole pide mucha información; la regulación por incentivos de la práctica desliga el precio de los costes declarados. Littlechild (1983) lo propone para la privatización de British Telecom; después gas, agua, electricidad y aeropuertos. Contrato de **alta potencia**, cercano al de precio fijo (b = 1 en t(C) = a − b(C − C^a), ficha `laffont-tirole`).
- **b) Modelo**:
  - *i) Supuestos*: al principio de un **periodo regulatorio** de varios años, nivel inicial de ingresos que recupera los «costes razonables» y precio medio (o de una cesta); durante el periodo, el precio sube como mucho la inflación menos un **factor de eficiencia X** (mejora de productividad exigida a la industria, que no implica varias empresas: nota de la autopista); precio y X se revisan al terminar.
  - *ii) Desarrollo*:
$$p_{t+1}\le p_t\,(1+\mathrm{IPC}_t-X)\qquad(\texttt{\textbackslash funcionclave} \texttt{eq:price-cap})$$
    Hasta la revisión, lo que la empresa ahorra se lo queda íntegro. Con un tope sobre la media de una cesta ponderada con las cantidades del periodo anterior, la empresa se acerca sola a precios de tipo Ramsey-Boiteux (Vogelsang y Finsinger, 1979). Ejemplo de *Redes del Valle*: peaje de 40 €/MWh, IPC 2,5 %, X = 1,5 → 40,40.
  - *iii) Implicaciones*: duración óptima del periodo (más incentivos frente a menos traslado a los precios); no distorsiona la combinación de factores (frente a Averch-Johnson); extremo b = 1 de la escala de la potencia.
- **c) Extensiones**: **ingreso máximo** (*revenue cap*), con el modelo RIIO de Ofgem (RIIO-3, 2026-2031); **esquemas intermedios** (reparto de beneficios o escala móvil, menús de reparto del ahorro) con el precio lineal en el coste **p = bF + (1 − b)C** (b = 0 coste incrementado, b = 1 precio fijo, la misma b del menú); incentivos por calidad.
- **d) Evidencia**: British Telecom con RPI − 3 desde 1984 (Armstrong, Cowan y Vickers, 1994); menores costes de operación en las redes, vigilando calidad e inversión (Joskow, 2014). España: cuota de abono de Telefónica con IPC − X hasta 2012 (CNMC); **Aena y el DORA 2027-2031** (aprobado en septiembre de 2026): ingreso máximo por pasajero para 5 años, que evoluciona con un índice de costes de insumos más un componente X: parte de **10,52 €** por pasajero en 2026 y llega a **10,69 €** en 2031, con una **X = +0,33 % anual que se suma** (la CNMC había propuesto −0,59 % y Aena +3,82 %). Una X positiva no es un descuento por productividad, sino el ajuste que cuadra ingresos y costes previstos. La Ley 2/2015 de desindexación (RD 55/2017) choca con una regla IPC − X pura: los reguladores usan índices de costes propios.
- **e) Valoración**: ventajas (eficiencia productiva; traslado de mejoras *a priori* con X y *a posteriori* en cada revisión; sencillez; sin sesgo de factores); inconvenientes (mucha información para el precio inicial y X: si es alto deja rentas, si es bajo la empresa querrá renegociar; retraso de mejoras al acercarse la revisión; calidad e inversiones de larga vida; más riesgo para la empresa); si el tope se recalibra a los costes en cada revisión, equivale a regular por coste del servicio con un desfase pactado: depende del compromiso (ficha `captura-regulador`).

**Gráfico de referencia:** `oposicion/temario/fuentes/3A20/graficos/price-cap.tex` (`fig:price-cap`: el precio sigue la senda IPC − X, los costes bajan más deprisa y la diferencia es de la empresa hasta la revisión, en la que el precio se ajusta). De apoyo, no imprescindible en el cante.

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.20 | Regulación por incentivos | desarrollo (hecho, 22/10/2026; II.4, 2′) | Todo lo de arriba, con la regla en la pizarra, el DORA y el RIIO, y su lugar en la escala de la potencia | — |
| 3.A.17 | Regulación por incentivos del monopolio natural | hoy desarrollo en el anexo A (hecho, 17/10/2026); **pasa a mención** con `--fase coherencia` cuando Víctor apruebe el 3.A.20 | Una viñeta: p_{t+1} ≤ p_t(1 + IPC_t − X) (Littlechild, 1983); la empresa se queda lo que ahorra, pero hay que fijar X y vigilar la calidad; `\vertema{3.A.20}` | Incentivos, duración, casos |
| 3.A.15 | Escuela austriaca (anexo A) | mención (hecho, 20/10/2026) | Littlechild (1983) propone el *price cap* para la British Telecom | La regla |
| 4.A.12 | Regulación sectorial | mención | Aplicación concreta (Telefónica hasta 2012; Aena y el DORA con la X de +0,33 % que se suma) con la regla canónica | Teoría |
| 4.B.15 | Empresa pública y regulación | resumen (hoy mención; D139 (13/10/2026)) | La regla p_{t+1} ≤ p_t(1 + IPC_t − X) y sus incentivos frente a la regulación por rentabilidad; remitir al 3.A.20 | Teoría completa |

## Divergencias encontradas en el temario actual
- 3.A.17 original: P_{t+1} = P_0(1 + IPC − X)^t y Telefónica y AENA sin fechas. **Resuelto** (17/10/2026).
- 4.A.12 escribe ṗ ≤ IPC − X y 4.B.15 P_{t+1} = P_t(1 + IPC − X): canon p_{t+1} ≤ p_t(1 + IPC_t − X).
- La ficha anterior decía que la X del DORA 2027-2031 «no se publica hasta comprobarla»: **comprobada** en el BOE por el 3.A.20 (22/10/2026), X = +0,33 % anual que se suma (10,52 → 10,69 €). Si Víctor prefiere llamarlo «regulación de ingreso máximo» y no *price cap* (duda 5 del 3.A.20, **[decidir]**), cambia el rótulo en esta ficha y en el 4.A.12, no la cifra.

Autor: Víctor Gutiérrez Marcos
