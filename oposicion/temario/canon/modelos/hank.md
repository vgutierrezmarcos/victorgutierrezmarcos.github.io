# Modelos neokeynesianos con agentes heterogéneos (HANK; Kaplan, Moll y Violante, 2018)

- **Área:** macro cerrada · **Tema de referencia:** **3.A.37** (Política monetaria (II): los mecanismos de transmisión; **revisado el 5/11/2026**, II.4 `sec:heterogeneidad`, «Hogares distintos: el canal redistributivo», con a)-e)) — el artículo de referencia es «Monetary Policy According to HANK» y lo que cambia es el **canal de transmisión** (efectos indirectos frente a la sustitución intertemporal); el 3.A.33, el 3.A.29, el 3.A.36, el 3.A.40 y el 3.A.42, revisados, remiten allí. Ficha creada en la fase canon del 3.A.7; referencia **confirmada al revisar el 3.A.37** (D3 de su coherencia, A37-03, **[decidir]** para Víctor; *alternativas*: el 3.A.33, que desarrolla los hogares *hand-to-mouth* —ficha `restricciones-liquidez`—, o el 3.A.42). Recoge los ids `agentes-heterogeneos`, `tank` y `gali-lopez-salido-valles` (alias; la versión con 2 tipos de hogares).
- **Temas que lo usan:** 3.A.37 (desarrollo; hecho, 5/11/2026: II.4 con a)-e), la fila «Agentes heterogéneos (HANK)» de `tab:escuelas-transmision` en I.1 y la paradoja de la orientación en III.2), 3.A.7 (resumen; hecho, 4/11/2026: III.2, «cómo ha cambiado el modelo», con `\vertema{3.A.33}`; III.1.2, los hogares de regla de pulgar de Galí, López-Salido y Vallés, 2007; III.1.1, McKay, Nakamura y Steinsson, 2016, en la paradoja de la orientación; trampa del anexo de test), 3.A.33 (mención; hecho, 31/10/2026: II.3 y III, la política monetaria llega a los hogares *hand-to-mouth* por la renta y el empleo, `\vertema{3.A.37}`), 3.A.1 (mención; hecho, 4/11/2026: III.3.3 `sec:heterogeneidad`, del agente representativo a la distribución), 3.A.29 (mención; hecho, 1/11/2026: III, agentes heterogéneos con mercados incompletos; los HANK y la versión con 2 tipos de hogares, `\vertema{3.A.37}`), 3.A.40 (resumen; hecho, 5/11/2026: II.2.5 `sec:hank`, regla de pulgar y la **cruz keynesiana intertemporal** de Auclert, Rognlie y Straub, 2024, con `\vertema{3.A.37}`; III.2.3, la monetaria actúa por el empleo y la renta), 3.A.42 (mención; hecho, 4/11/2026: II.2.3 y caja HANK en 3 líneas). Relacionadas: `restricciones-liquidez`, `agente-representativo`, `nek-3-ecuaciones`, `limite-inferior-tipos`, `ahorro-precaucion`, `bienes-duraderos`. También 3.A.6 (mención; hecho, 4/11/2026: III.4, los HANK en la secuencia de los EGDE). También 3.A.36 (mención; hecho, 4/11/2026: I.3 c), efectos indirectos sobre la renta, `\vertema{3.A.37}`).
- **Manuales de referencia:** Kaplan, Moll y Violante (2018), *AER* 108(3) (`KaplanMollViolante2018Monetary`); Auclert (2019), *AER* (`Auclert2019Monetary`); Kaplan, Violante y Weidner (2014), *BPEA* (`KaplanViolanteWeidner2014Wealthy`: los *hand-to-mouth* ricos); Galí, López-Salido y Vallés (2007), *JEEA* (`GaliLopezSalidoValles2007`); Bilbiie (2008, *JET*; 2020, *JME*) para la versión TANK; McKay, Nakamura y Steinsson (2016), *AER* (`McKayNakamuraSteinsson2016`); Auclert, Rognlie y Straub (2024), *Econometrica* (`AuclertRognlieStraub2024`); Holm, Paul y Tischbirek (2021), *JPE*; Cloyne, Ferreira y Surico (2020), *REStud*; Aiyagari (1994) y Krusell y Smith (1998) para los mercados incompletos (3.A.29); Galí (2018), *JEP*.

## Presentación de referencia (3.A.37, II.4)

**Pregunta:** ¿qué cambia en la transmisión de la política monetaria si los hogares son distintos en riqueza y liquidez?

**a) Idea.** En el modelo canónico la subida de tipos actúa casi solo por la **sustitución intertemporal** del hogar representativo; pero la ESI estimada es baja (`\vertema{3.A.33}`) y muchos hogares **viven al día** (*hand-to-mouth*: en EE. UU., en torno a un tercio, y la mayoría con riqueza ilíquida, como la vivienda o un plan de pensiones; Kaplan, Violante y Weidner, 2014). En el 3.A.37, con la familia con hipoteca variable y sin ahorros del hilo conductor y la pegatina «donde no hay harina, todo es mohína».

**b) Modelo.**

- **Supuestos**: muchos hogares que difieren en renta, riqueza y liquidez, con perturbaciones individuales no asegurables, límite al endeudamiento y un activo líquido y otro ilíquido más rentable (Kaplan, Moll y Violante, 2018; `\vertema{3.A.29}`); el resto, como el modelo canónico.
- **Descomposición** de la respuesta del consumo a un cambio de tipos (ecuación numerada `eq:hank`, no función clave):
$$\mathrm{d}C_0=\underbrace{\sum_{t\geq0}\frac{\partial C_0}{\partial r_t}\mathrm{d}r_t}_{\text{directo}}+\underbrace{\sum_{t\geq0}\Big(\frac{\partial C_0}{\partial (wL)_t}\mathrm{d}(wL)_t+\frac{\partial C_0}{\partial T_t}\mathrm{d}T_t\Big)}_{\text{indirectos}}$$
  con $(wL)_t$ la renta del trabajo y $T_t$ los impuestos netos de transferencias (locales: `notacion.md` § 8).
- **Resultado**: con un hogar representativo casi toda la respuesta es directa; en el HANK, los efectos directos son pequeños y los **indirectos** (empleo, salarios, impuestos en equilibrio general) la mayor parte, **«en torno a 4 de cada 5 euros»** (cifra redonda canónica; la del artículo, ≈ 19 % y 81 %, sin leer en su tabla, A37-20).
- **El canal redistributivo** (Auclert, 2019), 3 canales: por la **renta** (el empleo que se pierde es sobre todo de rentas bajas, con propensión alta), por la **inflación** (efecto Fisher: una inflación menor de lo esperado pasa riqueza de los deudores en nominal a los acreedores) y por la **exposición a los tipos** (ganan quienes tienen activos que se renuevan pronto; pierden quienes tienen deudas a tipo variable).
- **Versión sencilla (TANK)**: una parte de hogares que consume su renta y el resto que optimiza; la política se amplifica si la renta de los que viven al día es más sensible al ciclo que la media (Galí, López-Salido y Vallés, 2007; Bilbiie, 2008, 2020); en la política fiscal, el consumo **sube** con el gasto (ficha `equivalencia-ricardiana`).

**Implicaciones.** La política actúa sobre todo **por la renta y el empleo**, y su fuerza depende de la propensión marginal a consumir y del reparto de la deuda (con muchas hipotecas a tipo variable, como en España, pesa más la exposición a los tipos; `\vertema{3.A.33}`); la política **fiscal importa para la monetaria** (quién paga los intereses de la deuda; `\vertema{3.A.40}`); **las promesas lejanas pesan menos** y se modera la **paradoja de la orientación** (McKay, Nakamura y Steinsson, 2016; ficha `limite-inferior-tipos`); **la política monetaria redistribuye, pero no es el instrumento para redistribuir** (trampa del test: anexo del 3.A.7 y anexo G del 3.A.37; pregunta de junio de 2023, n.º 16).

**c) Extensiones.** La **cruz keynesiana intertemporal** (Auclert, Rognlie y Straub, 2024; `\vertema{3.A.40}`).

**d) Evidencia.** Noruega con datos administrativos: los efectos indirectos crecen y acaban dominando, y los hogares más endeudados son los que más recortan (Holm, Paul y Tischbirek, 2021); Reino Unido y EE. UU.: ajustan los hipotecados y los inquilinos, apenas los propietarios sin deudas (Cloyne, Ferreira y Surico, 2020).

**e) Valoración.** A favor: encaja con los microdatos y une la monetaria, la fiscal y la distribución. En contra: difíciles de resolver; los resultados dependen de cómo se calibre la liquidez.

**Gráfico de referencia:** `oposicion/temario/fuentes/3A37/graficos/hank-efectos.tex` (barras de la respuesta del consumo en efectos directos e indirectos, en % del total: agente representativo ≈ 100/0 frente a HANK ≈ 1/5 y 4/5; cifras redondeadas, con el aviso de A37-20 en la cabecera; de profundización: en el cante se dice «directos ≈ 1/5, indirectos ≈ 4/5» y las 3 flechas de Auclert).

**Terminología:** «modelos neokeynesianos con agentes heterogéneos (HANK)»; «hogares *hand-to-mouth*» o «que viven al día»; «hogares de regla de pulgar» (*rule-of-thumb*) para los de Galí, López-Salido y Vallés; «efectos directos» e «indirectos»; «canal redistributivo»; «cruz keynesiana intertemporal».

## Cómo se adapta en cada tema

| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.37 | Transmisión de la política monetaria | desarrollo (hecho, 5/11/2026) | II.4 con a)-e): `eq:hank`, la descomposición con `hank-efectos`, los 3 canales de Auclert, TANK, las implicaciones (fiscal, orientación, redistribución), la cruz keynesiana intertemporal y la evidencia de Noruega, el Reino Unido y EE. UU.; fila HANK en `tab:escuelas-transmision` | El modelo canónico (`\vertema{3.A.7}`) |
| 3.A.7 | La NEK tras 2008 | resumen (hecho, 4/11/2026) | Una viñeta en III.2 (efectos indirectos, PMC, política fiscal y distribución); la regla de pulgar en la política fiscal (III.1.2); McKay, Nakamura y Steinsson en la orientación; `\vertema{3.A.33}` | El modelo |
| 3.A.33 | Teorías del consumo | mención (hecho, 31/10/2026) | Los *hand-to-mouth* como base de los HANK; la política monetaria les llega por la renta y el empleo; `\vertema{3.A.37}` | — |
| 3.A.29 | Horizonte infinito y OLG | mención (hecho, 1/11/2026) | Agentes heterogéneos con mercados incompletos (Aiyagari, Krusell y Smith) y los HANK; `\vertema{3.A.37}` | — |
| 3.A.40 | Multiplicadores fiscales | resumen (hecho, 5/11/2026) | Multiplicadores mayores con hogares que viven al día (TANK y HANK); la cruz keynesiana intertemporal; importa a quién llega el dinero; fila de `tab:multiplicador-modelos` | La transmisión monetaria (`\vertema{3.A.37}`) |
| 3.A.42 | Ciclos | mención (hecho, 4/11/2026; II.2.3 y caja HANK en 3 líneas) | Heterogeneidad y fricciones financieras en los modelos del ciclo; `\vertema{3.A.37}` | El modelo |
| 3.A.1 | Innovaciones metodológicas recientes | mención (hecho, 4/11/2026) | Microdatos y heterogeneidad: la política monetaria actúa sobre todo por efectos indirectos y la distribución importa para el agregado | El modelo |
| 3.A.6 | NMC: surgimiento de los EGDE | mención (hecho, 4/11/2026) | Último paso de la secuencia de los EGDE | El modelo |
| 3.A.36 | Política óptima: extensiones | mención (hecho, 4/11/2026) | Una viñeta: efectos indirectos sobre la renta; `\vertema{3.A.37}` | El modelo |

## Divergencias encontradas en el temario actual

- **Resuelto en el 3.A.37 (5/11/2026)**: el Word tenía el «canal redistributivo» vacío (anexo 5); se escribe II.4 entero.
- **Cifra de la descomposición** (A37-20): el 3.A.37 dice «en torno a 4 de cada 5 euros» y el gráfico lo avisa; la cifra exacta de Kaplan, Moll y Violante (2018) (≈ 19 % y 81 %) está por leer en su tabla. Si se comprueba, se puede dar en el 3.A.37 sin cambiar ningún otro tema (los demás no dan cifra).
- **3.A.42 (resuelto el 4/11/2026)**: el Word tenía un epígrafe en inglés; mención con Kaplan, Moll y Violante (2018) y `\vertema{3.A.37}`.
- **Terminología**: el 3.A.29 y el 3.A.7 escriben «modelos nuevokeynesianos con agentes heterogéneos»; el 3.A.37, «neokeynesianos»; ver `notacion.md` § 14 (**[decidir]**, cosmético).

Autor: Víctor Gutiérrez Marcos
