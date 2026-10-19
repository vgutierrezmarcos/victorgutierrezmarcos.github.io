# Racionamiento del crédito (Stiglitz y Weiss, 1981)

- **Área:** mercados-información-juegos · **Tema de referencia:** **3.A.13** (Economía de la información; revisado el 19/10/2026, bloque III y anexo C) — desarrollo de referencia con a)-e), los 3 efectos de subir el tipo, la función del rendimiento del banco y los 2 paneles: es la aplicación canónica de selección adversa *y* riesgo moral a la vez, que es justo el título del 3.A.13 (deja de ser «comodín»). 3.B.27 y 4.A.20 pasan a resumen aplicado (regulación bancaria; financiación de pymes); 4.A.20 con lo imprescindible para cantarse sin el 3.A.13.
- **Temas que lo usan:** 3.A.13 (desarrollo; hecho, 19/10/2026), 3.B.27 (desarrollo → resumen), 4.A.20 (desarrollo → resumen), 3.A.7 (mención: base de la NEK), 3.B.26 (mención: crisis financieras), 3.B.28 (mención: microcréditos), 4.A.24, 4.A.25 (mención: avales y líneas públicas).
- **Manuales de referencia:** Stiglitz y Weiss (1981), *AER*; Freixas y Rochet (2008), *Microeconomics of Banking*, cap. 5; Mas-Colell, Whinston y Green, cap. 13; Jaffee y Russell (1976); Bester (1985), *AER*; de Meza y Webb (1987), *QJE*; Rothschild y Stiglitz (1970), *JET* (dispersión que conserva la media).
- **Decisión D070 (13/10/2026):** ¿Cuál es el tema de referencia de Stiglitz-Weiss (racionamiento del crédito)? 3.A.13, ampliándolo con supuestos, ecuaciones y los dos gráficos; 3.B.27 y 4.A.20 pasan a resumen aplicado. **Cumplido** en la revisión del 3.A.13 (19/10/2026).

## Presentación de referencia (3.A.13, III)
Pregunta: ¿por qué el mercado de crédito puede quedar en equilibrio con exceso de demanda, sin que el tipo de interés suba? Respuesta: el tipo hace 2 papeles, precio del préstamo y determinante de **quién** pide prestado y **qué** hace con el dinero.

- **Supuestos**: préstamo de cuantía fija para un proyecto; proyectos con el **mismo rendimiento medio y distinto riesgo** (uno es una dispersión que conserva la media del otro; nunca «muy rentables y arriesgados frente a menos rentables y menos arriesgados»); **responsabilidad limitada** (si fracasa, el prestatario no devuelve y pierde solo su garantía; si sale bien, devuelve 1 + r̂ por unidad); el banco no observa el riesgo (selección adversa) ni el proyecto que se elige (riesgo moral) y solo fija **r̂**; bancos neutrales que compiten por depósitos, cuya oferta crece con lo que el banco puede pagar.
- **Por qué el riesgo gusta al prestatario**: su beneficio es **convexo** en el rendimiento (se queda lo que exceda la deuda; si fracasa, pierde la garantía) y el cobro del banco es **cóncavo** (como mucho, la deuda).
- **3 efectos de subir r̂**: (1) **directo** (cobra más a los que pagan); (2) **de selección adversa** (los más seguros dejan de pedir); (3) **de incentivo** (los que quedan eligen proyectos más arriesgados). Los 2 últimos reducen la probabilidad de repago:
$$\mathbb E[B_{\mathrm{banco}}]=(1+\hat r)\cdot\Pr(\text{repago}\mid\hat r),\qquad \frac{\partial\Pr(\text{repago}\mid\hat r)}{\partial\hat r}<0$$
(`eq:stiglitz-weiss`), creciente hasta **r̂*** y decreciente después: el banco no presta por encima de r̂*.
- **Mercado**: demanda de préstamos decreciente; la oferta crece hasta r̂* y **se dobla hacia atrás** (nunca «oferta cóncava»); si a r̂* la demanda supera a la oferta, **racionamiento en equilibrio** (no transitorio): solicitantes iguales en apariencia lo reciben o no; el tipo que vaciaría el mercado no es un equilibrio.
- **Implicaciones**: ineficiencia (pymes y proyectos nuevos); colateral, historial y relaciones banca-cliente (las garantías altas pueden atraer a los más ricos y arriesgados); microcréditos con responsabilidad conjunta (Stiglitz, 1990; Ghatak, 1999; 3.B.28); **canal del crédito**: más fondos desplazan la oferta **a la derecha** (nunca «hacia arriba»), ejemplo de las TLTRO del BCE (anunciadas el 5/6/2014); avales públicos y líneas a pymes y exportadores (4.A.24), regulación bancaria (3.B.27).
- **Extensiones**: menú de tipo y garantía como autoselección (Bester, 1985), que puede eliminar el racionamiento; demasiado crédito con proyectos que difieren en la media (de Meza y Webb, 1987).
- **Evidencia**: racionamiento directo escaso (Berger y Udell, 1992), restricciones financieras mayores en las pymes; acumulación de liquidez (Holmström y Tirole, 1998; Bates, Kahle y Stulz, 2009: efectivo del 10,5 % del activo en 1980 al 23,2 % en 2006 en las industriales de EE. UU.). Nunca el «1.450 millones de dólares del S&P 500» del original.
- **Valoración**: un precio que no vacía el mercado sin que nadie quiera cambiarlo; depende de contratos de deuda con responsabilidad limitada y de un banco que solo fija el tipo. En el cante, la responsabilidad limitada es justo lo que impide «vender el negocio» del principal-agente (ficha `principal-agente`, caso 3).
- **Anexo C del 3.A.13** (formal, letras locales del anexo): proyecto de tipo θ con rendimiento R ∼ F(R; θ), garantía G; prestatario max{R − (1 + r̂), −G} (convexa), banco min{R + G, 1 + r̂} (cóncava); umbral θ̂(r̂) con dθ̂/dr̂ > 0 (selección); efecto incentivo con 2 proyectos. (El beneficio esperado del prestatario se escribe allí Π(r̂, θ): canon B, en `pendientes-coherencia.md`.)

Gráficos de referencia (`oposicion/temario/fuentes/3A13/graficos/stiglitz-weiss.tex`, 2 paneles): (1) 𝔼[B_banco] frente a r̂, máximo en r̂*; (2) mercado de préstamos con demanda decreciente, oferta que se dobla hacia atrás desde r̂* y exceso de demanda. 3.B.27 y 4.A.20 deben reutilizarlo.

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.13 | Selección adversa y riesgo moral a la vez | desarrollo (hecho, 19/10/2026) | Modelo completo, 3 efectos, función y 2 paneles; anexo C formal | — |
| 3.B.27 | Fundamentos de la regulación financiera | resumen | Supuestos (igual media, distinto riesgo, responsabilidad limitada), los 3 efectos en una frase, la función 𝔼[B_banco] y el panel derecho; garantías, supervisión | Derivación y anexo (remitir a 3.A.13) |
| 4.A.20 | Financiación no bancaria | resumen | Lo imprescindible para cantarse sin el 3.A.13 (supuestos, función, racionamiento de las pymes) ⇒ diversificar fuentes (mercados, capital riesgo) | Derivación |
| 3.A.7 | Nueva economía keynesiana | mención | Imperfecciones del crédito como fuente de rigidez y amplificación | — |
| 3.B.26 | Crisis financieras | mención | Racionamiento y canal del crédito en las crisis | — |
| 3.B.28 | Desarrollo | mención | Microcréditos y responsabilidad conjunta como respuesta | — |
| 4.A.24, 4.A.25 | Apoyo financiero a la internacionalización | mención | Fallo de mercado que justifica CESCE, FIEM, COFIDES | — |

## Divergencias encontradas en el temario actual
- 3.B.27 y 4.A.20 escriben $E[B]=\hat r\cdot\Pr(\text{repago})(\hat r)$: el rendimiento bruto es $(1+\hat r)$; y $E$ choca con $E(p,\overline U)$ (función de gasto) y con $E$ (educación, éxito) del 3.A.13 original: canon $\mathbb E[\cdot]$.
- **3.B.27 y el 3.A.13 original** suponen «2 tipos de clientes: muy rentables y arriesgados / menos rentables y menos arriesgados» y una dinámica de «criterios medios» con prima *ex post* y «oferta cóncava»: no son los del modelo (igual media, distinto riesgo; oferta que se dobla hacia atrás). En el 3.A.13, **resuelto** (19/10/2026); en 3.B.27 y 4.A.20, al revisarlos (`mapa.yaml`, contradicciones del 3.A.13).
- 3.A.13 original: lo presentaba como «comodín» al final, con QE que desplaza la oferta «hacia arriba» y un dato de efectivo del S&P 500 sin fuente. **Resuelto** (19/10/2026).

Autor: Víctor Gutiérrez Marcos
