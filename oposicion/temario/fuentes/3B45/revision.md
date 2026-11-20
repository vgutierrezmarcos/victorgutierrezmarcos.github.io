# Revisión del 3.B.45 — La gobernanza económica de la Unión Europea y de la zona euro. El Semestre Europeo. Las reglas fiscales y el Procedimiento de Desequilibrios Macroeconómicos. El Mecanismo Europeo de Estabilidad. La respuesta común de política fiscal a partir de la covid-19

Tema hecho desde cero el 14/11/2026 (entrega 1: tema y ficha de repaso; sin vídeo), en el worktree `revision-temario-2`, en paralelo con los agentes de los 3.B.43 y 3.B.44. **No había tema anterior** en el repositorio ni tema antiguo propio con este título: la estructura sale del tema nuevo de ICEX-CECO 3B45 (2023, no se cita) y de la parte de gobernanza del antiguo 3.B.46 de Víctor (versiones de 2023 y 2024), con todo el contenido redactado de nuevo y puesto al día a noviembre de 2026 con fuentes oficiales (EUR-Lex, Consejo, Comisión/DG ECFIN, MEDE, Eurostat, AIReF). Las dudas se resuelven con la opción recomendada y se anotan como B45-NN (14/11/2026).

## 1. Resumen

- **Estructura en 3 apartados** (introducción 2′30″, I 7′30″, II 11′, III 8′, conclusión 1′): **I. Fundamentos e instituciones** (I.1 por qué necesita reglas una unión monetaria; I.2 marco jurídico e institucional; I.3 evolución de Maastricht a 2024); **II. Reglas fiscales, PDM y Semestre Europeo** (II.1 reglas fiscales: el PEC hasta 2024, regla de déficit frente a regla de gasto, el marco de 2024, la sostenibilidad de la deuda en el nuevo marco y su aplicación en 2025-2026 con España; II.2 PDM; II.3 Semestre); **III. Gestión de crisis y respuesta fiscal común** (III.1 MEDE: origen, funcionamiento, programas, el préstamo a España, la reforma y su futuro; III.2 respuesta desde la covid-19: cláusula general, SURE, NGEU como política fiscal común, REPowerEU y SAFE; III.3 ¿capacidad fiscal central?).
- **4 modelos** con la estructura rígida a)-e): **sesgo deficitario en una unión monetaria** (Beetsma y Uhlig, 1999; Chari y Kehoe, 2007; `eq:sesgo-union`), **regla de déficit frente a regla de gasto** (`eq:reglas`), **sostenibilidad de la deuda en el marco de 2024** (`eq:gasto-neto`, del ajuste del saldo primario a la senda de gasto neto, con simulación propia 2025-2041 y la salvaguardia) y **capacidad fiscal central** (versión sencilla de Farhi y Werning, 2017; `eq:capacidad`).
- **13 gráficos y figuras propios** en TikZ/pgfplots: 4 de modelos (sesgo, reglas, simulación de la deuda, capacidad fiscal), 5 de datos (saldo y deuda de España y la zona del euro 1999-2027; PDE abiertos 2002-2026; gasto neto de España recomendado y observado; asistencia financiera por país e instrumento; SURE por Estado) y 4 figuras (arquitectura institucional, cronología 1992-2026, ciclo del marco de 2024, calendario del Semestre). 1 tabla (cuadro de indicadores del PDM).
- PDF: 26 páginas de tema, 1 de anexos (las reglas del PEC antes de 2024; test) y 5 de bibliografía. Ficha de repaso: 4 páginas a 10,5 pt (última, 85 %). `verificar-tema.py` (envoltorio sobre `_trabajo/`): sin errores propios; los «imagen inexistente en el HTML» son el efecto conocido de verificar en `_trabajo/` (rutas relativas) y desaparecen al publicar; quedan avisos de «cifra sin cita» (párrafos cuyo dato se cita en el vecino, en el gráfico o que son fechas históricas) y los del vídeo (entrega 3).

## 2. Errores corregidos

No hay tema anterior de este título; se corrigen los errores del material de partida (antiguo 3.B.46 de Víctor, v. 2023 y v.2 de 2024, y tema ICEX-CECO 3B45 de 2023), que no se publica.

| Id | Dónde (material de partida) | Decía | Dice ahora |
|---|---|---|---|
| E1 | 3.B.46 v.2 (2024), MEDE | Capacidad de préstamo de 410.000 millones | 500.000 millones (432.000 disponibles; 68.000 reservados para el respaldo común) |
| E2 | 3.B.46 v.2, MEDE | «Organismo intergubernamental creado por el Consejo Europeo en marzo de 2011» | Decisión política de 2011; Tratado firmado el 2/2/2012, en vigor el 27/9/2012, operativo el 8/10/2012 |
| E3 | 3.B.46 v.2, MEDE | «Ha facilitado asistencia financiera a España, Chipre y Grecia» | Programas de 5 Estados: Grecia, Irlanda, Portugal (FEEF y MEEF), Chipre y España (MEDE) |
| E4 | 3.B.46 v.2, MEDE | España: «algo más de 41.000 millones sobre 100.000» | 41.333 M€ desembolsados (dic. 2012 y feb. 2013); vivos ≈7.300 M€ a finales de 2025 |
| E5 | 3.B.46 (2023), nota 45 | España entra en el PDE en 2008 y sale en 2018 | Abierto en 2009 y cerrado el 14/6/2019 |
| E6 | 3.B.46 (2023), nota 47 | La regla de gasto «no contabiliza el gasto en inversión pública» | La inversión se promediaba en 4 años; desde 2024, gasto primario neto (sin intereses, desempleo cíclico, fondos UE ni medidas de ingresos) |
| E7 | 3.B.46 (2023), nota 50 | Cuadro del PDM con deuda privada (133 %), crédito privado (14 % del PIB), vivienda real (+6 %), cuota de exportación (−6 %), TCER ±5/±11 %, pasivos financieros (+16,5 %) | Cuadro revisado desde el informe de alerta de 2025 (tabla 1), igual que la ficha del canon y la 1D01 |
| E8 | 3.B.46 v.2, conclusión | «Cláusula de escape… suspendido hasta al menos el final de 2021» | Cláusula general activada el 23/3/2020 y desactivada a finales de 2023 |
| E9 | 3.B.46 v.2 | Respaldo común del MEDE al FUR: «implementación prevista para 2024» | La reforma del Tratado (2021) no está en vigor porque Italia no la ha ratificado (nov. 2026) |
| E10 | 3.B.46 y ICEX | Semestre con programas de estabilidad y nacionales de reformas en abril | Desde 2025, planes fiscales-estructurales e informes anuales de progreso (30 de abril) |
| E11 | ICEX (2023) | Reforma de las reglas «en negociación» con el paquete de abril de 2023 | Reglamentos 2024/1263 y 2024/1264 y Directiva 2024/1265, en vigor desde el 30/4/2024, y su aplicación en 2025-2026 |
| E12 | 3.B.46 v.2 | «La UEM… 20 de ellos» | 21 Estados en el euro desde el 1/1/2026 (Bulgaria) y 21 miembros del MEDE desde el 29/6/2026 |

## 3. Marcas resueltas

No hay Word original del tema con marcas. Del material de partida:

| Marca | Texto original | Qué se ha hecho |
|---|---|---|
| Huecos del 3.B.46 v.2 («Relevancia:», «Problemática: ¿?», hitos 2.2.1-2.2.4 sin desarrollar) | — | Introducción completa; evolución en I.3 con la cronología (figura 2) |
| Imagen 4 (CEOE, «Mecanismos de la UE para el cumplimiento del PEC») e Imagen 5 (infografía del Consejo sobre el Semestre) | Capturas | Rehechas como figuras propias (ciclo del marco de 2024; calendario del Semestre), con las reglas vigentes |
| Tabla de modos de coordinación del 3.B.46 (2023) | Política única / coordinación estrecha / débil | Resumida en I.2 («Cómo se coordina») |
| Nota del ICEX sobre el caso de España en recuadros | — | España en el cuerpo, breve, con remisión al 4.º ejercicio (\vertema{4.B.23}, \vertema{4.B.26}, \vertema{4.A.29}) |

## 4. Datos actualizados

| Dato | Valor | Fuente | URL | Consulta | Segunda comprobación |
|---|---|---|---|---|---|
| Déficit y deuda 2025 | Zona del euro 3,0 % y 87,7 %; España 2,4 % y 100,5 %; UE 3,1 % y 81,5 % | Eurostat, notificación de octubre de 2026 | https://ec.europa.eu/eurostat/web/products-euro-indicators/w/2-21102026-ap | 14/11/2026 | gov_10dd_edpt1 (CSV del 3.A.39, consulta 4/11/2026) |
| Marco de 2024 | Adoptado 29/4/2024, en vigor 30/4/2024; salvaguardias 1/0,5 puntos y 1,5 %; cuenta de control 0,3/0,6; multas 0,05 % por semestre | EUR-Lex; Consejo; resumen OEIL del PE | https://eur-lex.europa.eu/eli/reg/2024/1263/oj | 14/11/2026 | Recomendación C/2025/643 (considerandos 20-21) |
| Sendas aprobadas | 21 el 21/1/2025; 7 años: BE, DE, ES, FR, IT, AT, RO, FI | Consejo; Comisión (IP/26/1140) | https://www.consilium.europa.eu/en/press/press-releases/2025/01/21/… | 14/11/2026 | IP/26/1140 |
| Plan de España | 2025-2028, ajuste en 7 años; gasto neto 3,7/3,5/3,2/3,0 %; deuda 96,6 % (2028), 90,6 % (2031), 76,8 % (2041) | Recomendación del Consejo C/2025/643 | https://economy-finance.ec.europa.eu/document/download/cfdec323-…MTFSP_2025_ES.pdf | 14/11/2026 | — (documento oficial único) |
| Gasto neto de España observado | 2025: 4,8 % (desviación 0,4 puntos; dentro de la cláusula); AIReF: 7,3 % (2026), 5,1 % (2027) | Consejo ST 11121/26; AIReF (4/11/2026) | https://data.consilium.europa.eu/doc/document/ST-11121-2026-INIT/en/pdf ; https://www.airef.es/es/la-airef-preve-el-incumplimiento-… | 14/11/2026 | AIReF, 14/5/2026 |
| PDE abiertos | 10: AT, BE, BG, FI, FR, HU, IT, PL, RO, SK; Malta cerrado el 12/6/2026; Bulgaria abierto el 10/7/2026 | Comisión (resumen de PDE); Consejo | https://economy-finance.ec.europa.eu/…/excessive-deficit-procedures-overview_en | 14/11/2026 | Notas de prensa del Consejo |
| Cláusula de defensa | 15 Estados (8/7/2025) + DE (10/10/2025), AT (17/2/2026), ES (12/6/2026); energía, 0,3 % | Consejo; Comisión (IP/26/1140) | https://www.consilium.europa.eu/en/press/press-releases/2026/06/12/… | 14/11/2026 | ST 11121/26 (considerando 7) |
| PDM 2026 | 7 exámenes; EL, NL, SE sin desequilibrios; IT, HU, SK con; RO excesivos; España sin desequilibrios desde 2024 | Comisión, AMR 2026 e IP/26/1140; COM(2025) 200 | https://ec.europa.eu/commission/presscorner/…/IP_26_1140_EN.pdf | 14/11/2026 | COM(2025) 956 |
| Semestre 2026 | Paquete de otoño 25/11/2025; de primavera 3/6/2026; REP adoptadas 10/7/2026 | Comisión; Consejo | https://ec.europa.eu/commission/presscorner/detail/en/ip_25_2760 | 14/11/2026 | — |
| MEDE | 21 miembros (Bulgaria, 29/6/2026); capital 714.700 / 81.700 M€; capacidad 500.000 (432.000 disponibles); Gramegna; Italia sin ratificar la reforma (oct. 2026) | MEDE (explainer de Bulgaria; presentación de marzo de 2026; entrevista de 16/10/2026) | https://www.esm.europa.eu/explainer-bulgarias-accession-esm | 14/11/2026 | Presentación a inversores de marzo de 2026 |
| Programas | Grecia 256,6; Portugal 50,3; España 41,3 (vivo 7,3); Irlanda 40,2; Chipre 6,3 miles de M€ | MEDE; Comisión | ver `datos/rescates-paises.csv` | 14/11/2026 | Notas de prensa del MEDE y de la Comisión |
| SURE | 98.400 M€ a 19 Estados; España 21.324; 31,5 millones de trabajadores; 9.000 M€ de intereses ahorrados | Comisión (página SURE; COM(2023) 291) | https://economy-finance.ec.europa.eu/eu-financial-assistance/sure_en | 14/11/2026 | 3.A.40 y 3.B.40 (mismas cifras) |
| MRR | 450.000 M€ pagados (79 %) a 1/10/2026; NGEU hasta +1,4 % del PIB en 2026 | Comisión, COM(2026) 546; Institutional Paper 269 | https://economy-finance.ec.europa.eu/system/files/2024-02/ip269_en.pdf | 14/11/2026 | 3.B.37 (mismas cifras) |
| SAFE | 150.000 M€; 19 Estados; España 1.000; primer pago a Polonia 29/5/2026; 13.500 desembolsados a 11 Estados (29/10/2026); 2.ª convocatoria 21.300 | Comisión (DG DEFIS); Consejo ST 5780/26 | https://defence-industry-space.ec.europa.eu/commission-invites-…-2026-10-29_en | 14/11/2026 | 3.B.37 (con una discrepancia: ver § 6) |
| Personas | Eurogrupo: Pierrakakis (12/12/2025); Cumbre del Euro: Costa; Consejo Fiscal Europeo: Hasekamp; AIReF: Inés Olóndriz (RD 280/2026) | Consejo; Comisión; AIReF | https://www.airef.es/en/ | 14/11/2026 | 3.B.36 (Pierrakakis) |

Todos los datos que caducan están en `datos-actualizables.yaml`. Las verificaciones de la web se hicieron con 2 agentes de investigación (informes en esta sesión); lo que solo estaba en prensa no se ha usado o va en dudas.

## 5. Contenido añadido

Todo el tema es nuevo. Destacan:
- Los 4 modelos (fuentes: Beetsma y Uhlig, 1999; Chari y Kehoe, 2007; Kydland y Prescott, 1977, con su nota del Nobel; Cordes et al., 2015; Frankel y Schreger, 2013; Blanchard, Leandro y Zettelmeyer, 2021; Farhi y Werning, 2017; Asdrubali, Sørensen y Yosha, 1996). La versión de 2 regiones de Farhi y Werning es una simplificación propia (una regla de transferencias lineal), no su modelo.
- La aplicación del marco en 2025-2026 (planes, 10 PDE, cláusula de defensa con su extensión a la energía) y España (plan, gasto neto, AIReF).
- El MEDE completo (tema de referencia según el canon): origen, gobierno, capital, instrumentos, condicionalidad, programas, España, línea pandémica, reforma y futuro.
- La respuesta común desde la covid-19 como lógica de política fiscal (SURE, NGEU, REPowerEU, ReArm/SAFE) y el debate de la capacidad fiscal (Draghi, Letta, MFP 2028-2034).
- Anexo A: las reglas del PEC anteriores a 2024 (OMP, desviación significativa, 1/20, sanciones).

## 6. Coherencia

- **Fronteras pactadas**: NGEU como financiación, deuda y su sostenibilidad en el \vertema{3.B.37} (aquí, la lógica de política fiscal común); el SURE como respuesta aquí y como préstamo allí; MEDE aquí en desarrollo (canon `mede`); OMT y TPI en el \vertema{3.B.43} (aquí solo la condicionalidad del MEDE como puerta de las OMT); respaldo común al FUR mencionado aquí y desarrollado en el \vertema{3.B.44}; dinámica de la deuda aplicada, no derivada (\vertema{3.A.39}, misma notación $d_t$, $i$, $\gamma^N$); fases de la política fiscal desde 2008 en el \vertema{3.A.40}; la necesidad de unión fiscal en el \vertema{3.B.16} (Kenen); la troika en el \vertema{3.B.22}; instituciones en el \vertema{3.B.36}.
- **Cifras iguales que en los temas hechos**: SURE 98.400 M€ a 19 y 21.324 a España (3.A.40, 3.B.37, 3.B.40); MEDE 500.000 y 41.333 (3.B.36, 3.B.37); deuda de España 100,5 % y de la zona del euro 87,7 % en 2025 (3.A.39, mismos CSV); salvaguardias del marco (3.A.39, 1D01); cuadro del PDM (1D01, canon `semestre-europeo`); MFP 2028-2034 (3.B.37).
- **Discrepancia con el 3.B.37** (anotada en `_trabajo/canon-pendiente.md`; no se toca el 3.B.37): dice que los primeros pagos del SAFE «llegaron en junio de 2026»; el primero fue a Polonia el 29/5/2026 (Comisión).
- **4.º ejercicio**: \vertema{4.B.4} (saldo estructural, estabilizadores), \vertema{4.B.21} (marco legal, AIReF, LOEPSF), \vertema{4.B.23} (plan fiscal de España), \vertema{4.B.26} (saldo y deuda de España), \vertema{4.A.28} (crisis y rescate de 2012), \vertema{4.A.29} (PDM de España), \vertema{4.B.14} (federalismo fiscal).
- Propuestas al canon en `_trabajo/canon-pendiente.md` (fichas `pec`, `mede`, `semestre-europeo`, `next-generation-eu`; 4 modelos nuevos).

## Reglas de las tandas 8.ª y 9.ª y transversal (aplicadas, 14/11/2026)

| Regla | Cómo se ha aplicado |
|---|---|
| Estructura rígida de modelo | 4 modelos con a) Idea, b) Modelo (i-iii), c) Extensiones, d) Evidencia empírica, e) Valoración |
| Sin citas Harvard | Solo `\nocite` y `\textcite` de obras originales |
| Nunca citar a Víctor | Ninguna entrada suya; gráficos «elaboración propia»; su tema de 2023 no se cita |
| Ni «Pegatina» ni «Dicho» | Un solo refrán, el del enganche («Ayúdate y Dios te ayudará», no usado en otro tema; anotado en `refranes-tanda.txt`), retomado en la idea final |
| Nobel con motivo oficial | Kydland y Prescott (2004), con la nota de otros temas |
| `\vertema` al 4.º ejercicio | 4.A.28, 4.A.29, 4.B.4, 4.B.14, 4.B.21, 4.B.23, 4.B.26 |
| Resultados clave en morado | `eq:sesgo-union`, `eq:reglas`, `eq:gasto-neto`, `eq:capacidad` con `\funcionclave` |
| Pasos con sangría | Desarrollos por pasos en sublistas |
| Cajas grises | Notación y siglas; test |
| Ejemplos sin nombres propios | Estados $i$, regiones A y B, «un país parecido a España» |
| Inglés entre paréntesis | *free rider*, *moral hazard*, *no bail-out*, *common backstop*, *bail-in* |
| Anexo de test | Caja estándar con `tema=3.B.45` |
| Sin páginas en blanco ni desbordes | Comprobado con `verificar-tema.py` sobre `_trabajo/` |

## 7. Dudas abiertas

Todas aplicadas con la opción recomendada (14/11/2026); para que Víctor las confirme.

- **B45-01** Refrán del enganche: «Ayúdate y Dios te ayudará» (no usado en otro tema; la ayuda común llega con condiciones: MEDE, MRR, reglas). Opciones: (a) mantenerlo **[aplicada]**; (b) «Quien avisa no es traidor» (el PDM), que el canon tiene pendiente para otro uso.
- **B45-02** Estructura: sin tema antiguo propio, se parte del ICEX 3B45 (I. introducción; II. Semestre con reglas y PDM; III. MEDE; IV. respuesta a la covid) reordenado en 3 apartados (fundamentos e instituciones; reglas, PDM y Semestre; crisis y respuesta común). Opciones: (a) así **[aplicada]**; (b) el orden del título (gobernanza, Semestre, reglas y PDM, MEDE, covid) en 4 bloques.
- **B45-03** El gráfico de PDE abiertos por año (`pde-abiertos`) se ha reconstruido con los años de apertura y cierre de cada procedimiento (`datos/pde-abiertos.py`); la Comisión confirma la lista actual (10 abiertos, 18 Estados con procedimientos cerrados), pero no publica una serie, y las fechas antiguas no se han comprobado una a una (hecho: 24 en 2010, 0 en 2019). Opciones: (a) usarlo **[aplicada]**; (b) comprobar cada página por país antes de publicar.
- **B45-04** España en el PDM: «excesivos en 2013» y «desequilibrios desde 2012» son de memoria; lo comprobado es que no tiene desequilibrios desde la primavera de 2024 (COM(2025) 200) y que no fue elegida para examen en 2025 ni 2026. Comprobar en las comunicaciones de primavera de 2013-2023.
- **B45-05** Italia y la cláusula de defensa: la prensa y un documento del Consejo en revisión (ST 14668/26, 11-13/11/2026) apuntan a su activación en noviembre de 2026 (serían 19 Estados); no se ha incluido. Actualizar cuando el Consejo lo publique.
- **B45-06** Rechazo italiano de la reforma del MEDE «en diciembre de 2023»: de memoria (la ausencia de ratificación a octubre de 2026 sí está en el MEDE). El registro de tratados del Consejo no se pudo abrir.
- **B45-07** Países Bajos: «cuyo plan no cumplía» sale de un documento del Instituto Delors (enero de 2026), no de una fuente oficial; tampoco se ha comprobado si presentó otro en 2026.
- **B45-08** Participación de España en el capital del MEDE: «en torno al 12 %» (de memoria: ≈11,8 % antes de Croacia y Bulgaria).
- **B45-09** Cumplimiento de las REP: la frase es cualitativa («pocas se aplican del todo o de forma sustancial; la mayoría avanzan "algo"»); no se ha encontrado la cifra oficial de la Comisión para 2025-2026.
- **B45-10** El paquete de otoño del Semestre de 2027 (informe de alerta de 2027, dictámenes de presupuestos) no está publicado a 14/11/2026 (se espera a finales de noviembre); también está pendiente la adopción por el Consejo del reglamento que adapta el Six-Pack y el Two-Pack (PE-CONS 41/26). Registrados en `datos-actualizables.yaml`.
- **B45-11** El informe de Letta: URL del Consejo no abierta en esta sesión (título comprobado en fuentes secundarias).
- **B45-12** La simulación de la deuda (`simulacion-deuda`) es propia y deliberadamente sencilla (tipo, crecimiento y envejecimiento supuestos); se compara con el plan de España, que da cifras muy parecidas. Opciones: (a) así **[aplicada]**; (b) usar solo las cifras del plan.

## 8. Instrucciones para el vídeo

- **Enganche e idea final** (refrán cambiado el 19/11/2026): «Quien bien te quiere te hará llorar» (las reglas fiscales obligan a ajustar, por el bien propio y de los socios); los hechos: MEDE a España en 2012, NGEU a cambio de reformas, 10 PDE abiertos y el aviso de la AIReF; la pregunta, «¿cómo se gobierna una moneda común sin un Tesoro común?»; idea final: hasta ahora, con el refrán (cada uno responde de sus cuentas, las reglas obligan a ajustar y la ayuda llega con condiciones), pero con 2 límites: sin cumplimiento, llanto sin disciplina, y la pandemia mostró que, ante un golpe común, la ayuda puede llegar antes y sin castigo.
- **Introducción y conclusión, sin pizarra** (`modo: guion`).
- **I.1**: en la pizarra, `sesgo-union-monetaria` por capas (ejes; beneficio marginal; coste de la unión y $b^C$; coste de cada Gobierno y $b^N$; triángulo) y la función clave `eq:sesgo-union`, que se conserva durante todo el bloque I. I.2: `arquitectura-gobernanza` como apoyo. I.3: `cronologia-gobernanza` como apoyo.
- **II.1**: `eq:reglas` y `regla-deficit-gasto` en la pizarra por capas (brecha con regla de gasto; brecha con regla de déficit; gasto procíclico); `ciclo-marco-2024` como apoyo que se va completando (6 pasos); `eq:gasto-neto` en la pizarra (se conserva hasta el final de II) y `simulacion-deuda` por capas (periodo de ajuste; salvaguardia; sin ajuste; plan a 4 años; plan a 7 años). `pde-abiertos`, `deficit-deuda` y `gasto-neto-espana` como apoyo. II.2: tabla del cuadro del PDM como apoyo. II.3: `semestre-europeo` como apoyo.
- **III.1**: `rescates-paises` como apoyo; III.2: `sure-paises` como apoyo; III.3: `eq:capacidad` y `capacidad-fiscal` en la pizarra por capas (A sin; B sin; A con; B con).
- **Funciones clave que se conservan**: `eq:sesgo-union` (I), `eq:gasto-neto` (II.1-II.3), `eq:capacidad` (III.3).
- Nunca se dice el número de un tema en voz alta.

**Reparto del cante** (nota que iba tras el esquema del tema; quitada del tema el 19/11/2026 a petición de Víctor, se conserva aquí para el vídeo):

> Reparto del cante: introducción, \tiempo{2,5}; I, \tiempo{7,5} (I.1, \tiempo{3}, casi todo para el modelo del sesgo deficitario en la unión monetaria; I.2, \tiempo{2}; I.3, \tiempo{2,5}); II, \tiempo{11} (II.1, \tiempo{7,5}, con \tiempo{1,5} para el modelo de la regla de gasto y \tiempo{2} para el de la sostenibilidad de la deuda; II.2, \tiempo{2}; II.3, \tiempo{1,5}); III, \tiempo{8} (III.1, \tiempo{3}; III.2, \tiempo{2,5}; III.3, \tiempo{2,5}, con \tiempo{1,5} para el modelo de la capacidad fiscal), y conclusión, \tiempo{1}. Los gráficos y figuras imprescindibles son el del sesgo deficitario, el de la regla de déficit frente a la de gasto, el de la simulación de la deuda con el marco de 2024, la figura del ciclo del marco, el de los rescates por país y el de la capacidad fiscal. Las cifras de las tablas, las cajas grises y los anexos son para las preguntas del tribunal. La aplicación a España se estudia con detalle en el cuarto ejercicio \vertema{4.B.23} \vertema{4.B.26} \vertema{4.A.29}: aquí basta con lo esencial.

## Listas en las notas al pie (15/11/2026)

Ninguna nota lo necesitaba.

## Comentarios de Víctor (19/11/2026)

- Anexo de competencias (arts. 2 a 6 TFUE): nuevo anexo «El reparto de competencias de la Unión» (anexo:competencias) antes del de test, con la figura común `graficos/competencias-ue.tex` (carga `latex/competencias-ue-base.tex`, idéntica en los 10 temas de la UE salvo el resaltado). Resaltado en este tema: la coordinación de las políticas económicas (art. 5.1) y de empleo (art. 5.2). Remisión desde «La base en los Tratados» del marco jurídico.
- **Estructura común de las políticas de la UE**: se aplica, y el tema ya la seguía casi entera; solo se han hecho visibles 2 piezas (sin mover títulos ni contenido, minutos sin cambios, 30):
  - *1. Relevancia*: introducción.
  - *2. Justificación*: a) teoría económica, I.1 (externalidades fiscales, sesgo deficitario, riesgo moral, límites de la disciplina de mercado y el modelo del sesgo deficitario en la unión monetaria); b) delimitación de competencias, I.2 (coordinación de las políticas económicas y de empleo, art. 5 TFUE, con la remisión al anexo de competencias); c) marco jurídico, I.2 (arts. 119, 121, 122, 123-126 y 136 TFUE y Protocolo 12); d) toma de decisiones, I.2: **viñeta nueva «Cómo se decide, en resumen»** (Comisión propone y Ecofin decide por mayoría cualificada; mayoría cualificada inversa para las sanciones del euro desde 2011, con el Reglamento 1173/2011 citado, entrada nueva del `.bib`; el reglamento preventivo por procedimiento legislativo ordinario, art. 121.6, y el correctivo por unanimidad del Consejo tras consultar al Parlamento, art. 126.14, como en 2024; el MEDE, por mutuo acuerdo).
  - *3. Evolución*: I.3 (de Maastricht a la reforma de 2024).
  - *4. Articulación*: II (reglas fiscales, PDM y Semestre) y III.1-III.2 (MEDE y respuesta común a la covid).
  - *5. Retos de futuro*: III.3 (¿hacia una capacidad fiscal central?: Draghi, Letta, MFP 2028-2034) y la opinión de la conclusión.
  - **Viñeta nueva «El orden del bloque»** en la entrada del bloque I, que dice que se va de la justificación al marco jurídico, las competencias y la decisión, y a la evolución.
  - Páginas: cuerpo 26 → 26; anexos 3. Ficha sin cambios (lo nuevo es un resumen de lo que ya estaba repartido; la ficha ya recoge la mayoría cualificada inversa). `verificar-tema.py`: 0 errores, 17 avisos (los de siempre: cifras sin cita en párrafos históricos y el vídeo). `\tcefecha` a 19/11/2026.
  - Duda nueva **B45-13** (abajo).
- Refrán del enganche más popular: «Ayúdate y Dios te ayudará» pasa a «Quien bien te quiere te hará llorar» (las reglas fiscales). Se rehacen el enganche (mismos hechos y cifras) y la idea final, que vuelve al refrán y le pone sus 2 límites (el incumplimiento y la respuesta común a la pandemia); ficha, mapa de la exposición e instrucciones del vídeo al día. Sin cifras nuevas. Duda B45-14.

### Dudas (19/11/2026)

- **B45-13. Modelos en el cuerpo de un tema institucional.** CRITERIOS (14/11/2026) pide para los temas de la UE la idea de los modelos en el cuerpo y el desarrollo en anexos; el 3.B.45 conserva en el cuerpo los 4 modelos (sesgo deficitario, regla de déficit frente a regla de gasto, sostenibilidad de la deuda y capacidad fiscal), porque Víctor no lo ha pedido para este tema y no entraba en el encargo de hoy. Opciones: (a) dejarlos así hasta que Víctor lo diga **[aplicada]**; (b) llevarlos a anexos como en el 3.B.36 y el 3.B.37, dejando la idea de palabra y compensando con contenido institucional.
- Mapa de la exposición tras el esquema, en caja gris (figu:mapa-tema).
- **B45-14. Refrán del enganche.** Opciones: (a) «Quien bien te quiere te hará llorar» (las reglas fiscales) **[aplicada]**; (b) «Cuando las barbas de tu vecino veas pelar, pon las tuyas a remojar» (el contagio de la crisis de la deuda de 2010-2012: Grecia, Irlanda, Portugal y después España); (c) «Más vale tarde que nunca» (la reforma de las reglas de 2024, tras años de reglas procíclicas e incumplidas).
- Ficha rehecha con el formato nuevo (introducción y esquema en la 1.ª columna, anexo en la última); 9 pt (antes 10,5: el tema ocupa ahora más columnas; fuera el gráfico de la cronología, que repite la lista de I.3).

## Opinión (21/11/2026)

- **Antes → después**: 1 viñeta larga → 2: (1) mejor marco, credibilidad en juego (10 PDE, cláusula de defensa, incumplimientos); (2) sin capacidad fiscal permanente, la próxima crisis dependerá de una cumbre, con la frase de Monnet («ha funcionado, pero siempre a última hora»).
- **Frase célebre**: Sí, Monnet y no Goodhart (casaba mejor con la capacidad fiscal y SURE/NGEU, y el 3.B.45 no podía llevar las 2). Monnet, *Mémoires* (Fayard, 1976): «J'ai toujours pensé que l'Europe se ferait dans les crises, et qu'elle serait la somme des solutions qu'on apporterait à ces crises» (comprobada en Le Grand Continent, 9/5/2022, que reproduce el pasaje). 2.º tema con esta frase, tras el 3.B.36. Entrada `Monnet1976Memoires` copiada al `.bib`. Ficha: «Monnet: Europa se haría en las crisis».
