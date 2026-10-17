# Revisión del tema 3.A.16 — Análisis de mercados (I). El modelo de competencia perfecta

Fecha: 17/10/2026. Integración en tres partes: (1) preámbulo, introducción, I y II; (2) bloque III; (3) conclusión, anexos A-F, bibliografía, gráficos pedidos, `seo.json` y este informe.

Fuentes de la integración: `_trabajo/original.md`, `pendientes.md` (P1-P117), `propuestas-contenido.md` (C1-C51 y C5 bis), `propuestas-datos.md` (V1-V42) con `bib-datos.bib`, y `propuestas-coherencia.md` (K1-K30, estructura final, plan de pizarra, CN1-CN10, X1-X9, D1-D11). Criterio ante discrepancias: la estructura y la notación las decide coherencia; la teoría, contenido. Mientras Víctor no conteste las dudas D1-D11 en el artifact, se han aplicado las decisiones del coordinador (abajo, «Dudas abiertas»).

## Resumen

- Nueva fuente LaTeX `3A16.tex` (compilación de prueba: 36 páginas de tema, 8 de anexos y 3 de bibliografía; `\minutos` suma 30: 2'30" + 8'30" + 12' + 6' + 1'). Tres apartados: I (el antiguo «0» integrado en I.1 y un solo bloque de supuestos), II (existencia, unicidad, estabilidad con Walras, Marshall y la telaraña en el cuerpo; excedentes y teoremas del bienestar; estática comparativa e impuesto) y III (plazos de Marshall, corto plazo, largo plazo sin y con libre entrada, oferta de la industria con economías externas).
- Enganche nuevo: «A río revuelto, ganancia de pescadores» con el aceite de oliva 2022-2025, con datos de la Comisión Europea y del INE; la idea final lo responde.
- Corregidos más de 35 errores de teoría, fórmulas, fechas y atribuciones (demanda inversa, oferta inversa confundida con la demanda, condiciones de estabilidad, supuestos del 1TFEB, reparto del impuesto con el signo cambiado, $p^*\geq c$ en la libre entrada, Dupuit 1884, Molina 1592, etc.). Resueltas las 14 marcas amarillas (P1-P5) y las notas al opositor; los comentarios privados no se publican.
- Todas las capturas de ICEX-CECO, de Campante et al. y de otro opositor (Fabián Salazar) desaparecen: texto redactado de nuevo y 18 gráficos propios (16 pedidos en `_trabajo/graficos-pedidos.json`, 2 copiados de 3.A.21 y 3.A.12).
- Anexos: A (1TFEB en equilibrio parcial), B (geometría de los costes), C (precios máximos y mínimos), D (equilibrio parcial y general, con la relación de temas del bloque), E (telaraña: lineal, adaptativas, racionales, ciclo límite), F (test y preguntas del tribunal). `3A16.bib` con 53 entradas, todas citadas.

## Errores corregidos

| Dónde (original) | Decía | Dice ahora |
|---|---|---|
| Intro, l. 49 | Definición de Marshall en cursiva como si fuera literal («nivel máximo de bienestar») | Quitada del enganche (V6); el enganche es nuevo |
| Intro, l. 93-95 | Marshall «primer autor, junto con Walras», de una teoría del valor con oferta y demanda | Cournot (1838), Dupuit (1844) y Jenkin (1870) antes; Marshall sistematiza (V5, P114) |
| Nota 2 | «Kevin» Lancaster; cita entre comillas de Ekelund y Hébert | Kelvin Lancaster (1966) y años de Becker, Gronau y Stigler; Ekelund y Hébert parafraseado, sin comillas (V7, V18, P112) |
| Nota 3 | Se cita a sí mismo («temas 3.A.16…3.A.19») | `\vertema` de 3.A.17-3.A.19 |
| Nota 5 | Molina «en 1592» con cita literal; Azpilcueta «13 años antes» que Bodin | Molina, tratado del dinero en el t. II de *De iustitia et iure* (1597), parafraseado; 12 años (1556-1568), parafraseado (V2, V3, P110) |
| I.2, l. 194 | Consumidores $m$, empresas $i$, $J$ número de bienes | $i=1,\dots,I$ consumidores, $j=1,\dots,J$ empresas; sin $J$ de bienes (K17) |
| I.2, l. 214 y nota 10 | «[a diferencia de lo que ocurría en el tema 3.A.8]», «Recordemos del tema 3.A.8» | Reescrito sin «se estudia en el tema» (K15, P68) |
| I.2, l. 218 | Demanda «walrasiana» | Demanda marshalliana (ordinaria o walrasiana, una vez) (K17, P75) |
| I.2, l. 220 | $x_m(p)=\varphi_m'^{-1}(x_m)$ | $x_i(p)=(\phi_i')^{-1}(p)$ (P87) |
| I.2, l. 242 | $P(x)=x^{-1}(\overline{x})$ | $p^D(x)$ demanda inversa (P88, D6) |
| Nota 14 | Cuasilinealidad como condición necesaria; «las CES permiten la agregación» | Forma polar de Gorman con el mismo $b(\vect{p})$; cuasilineales y homotéticas idénticas como casos suficientes (K19, P79) |
| I.2, l. 246 | Oferta «[ver tema 3.A.11]» | `\vertema{3.A.12}` (P64, P72) |
| I.2, l. 254, notas 16-17, 22-24 | $F$ estrictamente cóncava (y luego rendimientos constantes y CMe en U en III); «rendimientos decrecientes equivalen a costes convexos»; «economías de escala compatibles: SÍ» | Coste marginal creciente en el tramo relevante; nota que separa convexidad de $C$ y deseconomías de escala ($\varepsilon_{q,\lambda}=\mathrm{CMe}/\mathrm{CMg}$); la empresa competitiva nunca produce en el tramo de economías de escala (III.3) (K13.1, P16, P89, P93) |
| I.2, l. 260-272 | Propiedades de $C$ en $\vect{w}$ sin uso; $C_i(\overline{q}_i,\vect{w})$ | Nota con remisión a 3.A.12; $C_j(\vect{w},q_j)$ y $C_j(q_j)$ (K20, P90) |
| I.2, l. 277-279, 292 | Restricción $B_i\geq -C_i(0)$; $q_i^*=q_i(\vect{w},\overline{q})$ | `\optim` con $q_j\geq 0$; la inacción, de palabra; $q_j(p)$ (P91) |
| I.2, l. 302 | Produce si $p\geq\min\mathrm{CMe}$ en general | CMe sin costes hundidos (I-II, III.2), CVMe con costes hundidos (III.1) (K13.3, P92) |
| I.2, l. 358 | $C'(q)=q^{-1}(q)=P(q)$ (oferta inversa igual a la demanda inversa) | $p^S(q)=q^{-1}(q)$, coste marginal de la industria (K13.2, P88) |
| II.1.1, l. 498 | Paréntesis sin cerrar | Corregido (P94) |
| II.1.2, l. 516-518 | «Múltiples vectores de precios»; «cantidades» por valores; «consumida» por producida; el ejemplo no es de multiplicidad de asignaciones | Un precio; asignación única sin intercambio y precio indeterminado; casos de costes constantes y de pendientes anómalas (P95) |
| II.1.3, l. 548 | Musgrave: estabilidad de un mercado = función de estabilización | Texto de K28: la estabilización es para el conjunto de la economía; aquí la pregunta es más modesta (P115) |
| II.1.3, l. 562 | «Exceso de oferta negativo» | Exceso de demanda negativo (P96) |
| II.1.3, l. 572-584 | Vectores de precios, «EGC», $k_i\geq 0$, distancia sin fórmula | Un mercado: $\dot p=f(z(p))$, $f'>0$; linealización y distancia $\tfrac12(p-p^*)^2$ (K21, P97) |
| II.1.3, l. 602-608 | $z(q)=p^D-p^S$ (z ya es el exceso de demanda); «los productores» por los compradores | $\dot q=g(p^D-p^S)$ y condición $\frac{d}{dq}(p^D-p^S)<0$; «compradores» (P98) |
| Nota 33 | Cita francesa con «demanda» | Nota acortada sin la cita; remisión a 3.A.21, que la tiene corregida (V8, P111) |
| Anexo 2 | Numeración i, ii, i, ii; «partimos de un equilibrio como $P_t$»; condición en elasticidades sin decir dónde | En el cuerpo y en el anexo E: precio inicial distinto de $p^*$; condición $q'(p^*)<\lvert x'(p^*)\rvert\Leftrightarrow\varepsilon_S<\lvert\varepsilon_D\rvert$ en el equilibrio (P109) |
| II.2.1, l. 630-632 | Walras «sostenía…» sin cita | Comprobado y matizado: lección 44, «dentro de ciertos límites», excepciones (V10, P99) |
| Nota 35 | Dupuit (1884) | Dupuit (1844) (V1, P80) |
| II.2.1, l. 660 | $P(x^*)=C'(x^*)$ | $p^D(x^*)=\mathrm{CMg}(q^*)$, $x^*=q^*$ (P76) |
| Nota 37 | Problema de Pareto con una restricción mal escrita | Anexo A, paso a paso (C43) |
| II.2.2, l. 674 | 1TFEB con «rendimientos no crecientes» | No hace falta convexidad (vale con libre entrada y costes en U) (K13.4, P100) |
| Nota 38 | «Desarrollado por Lerner y formalizado por Arrow y Debreu» | Lerner (1934) y Lange (1942); Arrow (1951) y Debreu (1951), como en el 3.A.21 (V4, con cambio de año: ver «Coherencia») |
| Nota 41 | 2TFEB «no se puede demostrar por contradicción» | Quitado; en el modelo cuasilineal el 2TFEB es inmediato (K13.5) |
| Nota 42 | «Precios de los demás productivos» | Precios de los demás bienes (C24) |
| II.3.2, l. 748-760 | $\hat p_m$, $\hat p_i$, $t_j$ | $p_c=p_v+t$ (D046) |
| II.3.2, l. 794-796 | Lógica invertida («aun cuando… y por lo tanto distorsionantes»); «precio recibido por el consumidor» | Distorsionante porque cambia el precio relativo, aunque se devuelva la recaudación; «precio del vendedor» (K13.7, P102) |
| II.3.2, l. 820-824 | $\partial p^*(t)+t/\partial t$; parte de los productores con el signo cambiado; «·100» | $dp_c/dt=\varepsilon_S/(\varepsilon_S+\lvert\varepsilon_D\rvert)$ y $-dp_v/dt=\lvert\varepsilon_D\rvert/(\varepsilon_S+\lvert\varepsilon_D\rvert)$ (P103) |
| Caja del pescado | Oferta normal «con pendiente negativa»; «equilibrio estable y eficiente»; «no concibe desempleo»; cita larga de las tijeras sin fuente | Oferta normal creciente (decreciente solo con rendimientos crecientes en la pesca, Marshall libro V, cap. V, § 4); sin «estable y eficiente»; matiz con Keynes (3.A.4); tijeras solo en la contextualización con traducción propia (K5, C29, P23) |
| Nota 20 | «La distinción corto/largo plazo tiene sentido solo en términos contables… es completamente equivalente» | Lo irrelevante son los costes hundidos; los plazos difieren en costes evitables, forma de los costes y número de empresas (P3) |
| Nota 21 | Costes en S invertida necesarios para la competencia a largo plazo | Condición suficiente, no necesaria (también $K+\psi(q)$ con coste fijo evitable) (P5) |
| III.3, l. 916 | $C(0)=0$ «porque no hay costes fijos» y luego costes con coste fijo no hundido | Supuesto dicho en cada caso (P104) |
| III.3, l. 932 | Oferta a largo plazo siempre horizontal | Según los rendimientos y las economías externas (P105) |
| III.3, l. 940-946 | $p^*\geq c$; «vaciado implica $q^*>0$»; oferta de la empresa = oferta agregada | $p^*\leq c$ para que haya solución y $p^*=c$ con $x(c)>0$; $J^*q^*=x(c)$; las 2 horizontales, pero no la misma curva (P106) |
| III.3, l. 972 y nota 47 | Frase duplicada | Una vez (P107) |
| III.3, l. 976 | Símbolos que faltan; sin intuición de la inexistencia | $\mathrm{CMg}(0)$ y nota con la intuición (P108) |
| Anexo 1 | 2TFEB atribuido a 3.A.24 | Anexo D, «Qué estudia cada tema del bloque»: 2TFEB en 3.A.22 (V27, P71) |

## Marcas resueltas

| Marca | Texto original (resumido) | Qué se hizo |
|---|---|---|
| P1 (amarillo, 6 tramos, l. 176-186) | Dotaciones, planes de producción factibles, propiedad de las empresas, precio en numerario, agentes pequeños | Lo de equilibrio general, al anexo D; precio en numerario, propiedad de las empresas y precio-aceptación, integrados en I.2 i) Supuestos |
| P2 (amarillo, l. 870-876) | Corto plazo, largo plazo sin y con libre entrada | Confirmado (MWG § 10.F); apertura del III y tabla de color `tab:plazos` |
| P3 (amarillo, nota 20) | Corto/largo plazo «solo contable» | Corregido en una nota de III.1 (costes hundidos) |
| P4 (amarillo, nota 20, escaneo) | Coste económico y de oportunidad | Caja gris y tabla propia `tab:beneficio-economico` (ejemplo numérico propio) |
| P5 (amarillo, nota 21) | S invertida | Nota en III.3: suficiente, no necesaria |
| P6, P83 (nota al opositor publicada, p. 1) | Cambio de temario y ficha del tribunal | No se publica |
| P7 (nota al opositor) | Clark y Marshall, beneficios temporales | III.2 iii), como texto, con Clark (1899) y las cuasirrentas |
| P8 (nota al opositor) | Número de empresas fijo hasta la libre entrada | Frase de I.2 i) Supuestos y de la conclusión anticipada de I |
| P9, P10 (notas al opositor) | «Meterle dinamismo»; telaraña «si sobra tiempo [anexo A.1]» | Estabilidad con la estructura a)-e) y la telaraña como c) Extensiones en el cuerpo; anexo E |
| P11 (nota al opositor) | Límites de precios como comodín | `notaopositor` al final de II.3 y anexo C |
| P12-P22, P82 (comentarios) | Zapico, clases de Juan Carlos, «tarjetitas», «Estructura de Ángel», «Traducción del Mas-Colell» | No se publican; lo que pedían se resuelve en I.2 (demanda), III (plazos, economías externas) y la existencia por Bolzano |
| P23 (caja de anotaciones) | Mercado de pescado | Corregida y trasladada a la apertura del III |
| P24 (caja con enlace a superprof) | Enlace a apuntes escolares | Caja gris con el enunciado del teorema de Bolzano (Bolzano, 1817; Sydsæter et al., 2008) |
| P84 (bibliografía) | «Tema ICEX-CECO», «Tema Juan Luis Cordero Tarifa» | ICEX-CECO citado como Rodríguez Álvarez (2016) en el anexo C; Cordero fuera (no tiene tema 3.A.16 y no se usa; D9) |
| P85 (pies de figura) | Fabián Salazar (otro opositor), ICEX-CECO | Todos los gráficos son propios, «elaboración propia a partir de» MWG, Varian, Marshall, De Vroey, Ezekiel |
| P86 (quia.com) | Enlace a test | Enlace genérico al simulador en el anexo F |

## Datos actualizados

El tema es teórico: los únicos datos son los del enganche. Consulta: 17/10/2026. La web del MAPA no se pudo abrir (certificado TLS); se usaron los datos que el MAPA comunica a la Comisión.

| Dato | Valor anterior | Valor nuevo | Fuente | URL | Segunda comprobación |
|---|---|---|---|---|---|
| Producción de aceite de oliva en España por campaña | — (enganche nuevo) | 1.491 miles de t (2021/22), 666 (2022/23), 855 (2023/24), 1.421 (2024/25) | Comisión Europea, Agri-food data portal (`CE2026AceiteProduccion`) | https://www.ec.europa.eu/agrifood/api/oliveOil/production?memberStateCodes=ES&granularity=annual | Coherente con la evolución del IPC del INE |
| Precio en origen del virgen extra (media nacional semanal) | — | 412,21 €/100 kg (semana del 3/10/2022); máximo 903,41 (15/1/2024); 352,68 (26/5/2025) | Comisión Europea, precios del aceite comunicados por el MAPA (`CE2026AceitePrecios`) | https://www.ec.europa.eu/agrifood/api/oliveOil/prices?memberStateCodes=ES | INE, IPC subclase «Aceites vegetales» (IPC291663): 162,761 (abril de 2024) → 90,19 (septiembre de 2025), −44,6 % (`INE2026IPCAceites`, https://servicios.ine.es/wstempus/js/ES/DATOS_SERIE/IPC291663?nult=60) |

Fechas y atribuciones (propuestas de datos): V1 Dupuit 1844; V2 Molina 1597; V3 doce años; V4 Lerner, Lange, Arrow y Debreu; V5 Cournot y Jenkin; V7 Kelvin Lancaster; V9 Bertrand (1883) y 4.ª ed. de los *Éléments* (1900); V10 Walras, lección 44; V11 Ricci, Schultz y Tinbergen (hacia 1930), Kaldor (1934), Ezekiel (1938), Muth (1961); V12 Dalton (1922) y Jenkin (1872); V13 Harberger (1964). Cita de las tijeras y del corral de Marshall comprobadas en el texto de la 8.ª ed. (libro V, cap. III, § 7, y cap. V, § 2), con traducción propia.

## Contenido añadido

- Introducción con sus 5 bloques, esquema de pizarra y reparto de minutos; enganche del aceite y problemática de K8.
- Estabilidad completa: linealización del ajuste walrasiano, condición marshalliana, casos en que difieren (tabla y gráfico del 3.A.21), telaraña en el cuerpo con su condición en 3 formas, evidencia (Ezekiel; Hommes et al., 2007), crítica de Muth; anexo E con expectativas adaptativas (Nerlove, 1958), racionales y ciclo límite.
- Bienestar: 1TFEB como maximización del excedente total con $\lambda^*=p^*$ (`\funcionclave`), anexo A paso a paso, 2TFEB inmediato con cuasilineales, principio de compensación.
- Estática comparativa: principio de correspondencia (Samuelson, 1941 y 1947); impuesto con casos extremos, *ad valorem*, ley de Dalton comprobada en la fuente y triángulo de Harberger.
- Bloque III completo (estaba casi vacío): plazos de Marshall y moderno (tabla de color), corto plazo con mínimo y óptimo de explotación, Le Châtelier-Samuelson, largo plazo sin libre entrada, libre entrada con los 4 casos de rendimientos y $J^*=x(\overline{c})/\overline{q}$ (`\funcionclave`), del corto al largo plazo, oferta de la industria con costes constantes, crecientes y decrecientes (Viner, Scitovsky), evidencia de costes en L y valoración (impugnables, monopolio natural).
- Conclusión completa (Relevancia y Opinión estaban vacías), con la crítica austriaca (Hayek, 1948; nota 51) y Schumpeter.
- Anexos C (precios máximos y mínimos) y D (equilibrio parcial y general), redactados de nuevo en lugar de capturas.
- Ideas tomadas de otros preparadores (solo aquí, no en el tema): «economías de escala externas a la empresa e internas a la industria» (Cabado, DCE 3.A.7; Cerezal) y la estructura de los casos de libre entrada (Tebar, contraste); son materia común de manual (MWG § 10.F).

### Estado de cada propuesta

**Contenido (C)**: aplicadas C2-C29, C31-C36, C38-C51, con estos cambios:
- C1: rechazados los minutos (8/13/5,5) y el título del III: mandan K3 y la decisión del coordinador («Análisis de plazos: corto plazo, largo plazo y libre entrada»).
- C3: enganche del pescado sustituido por el del aceite (decisión del coordinador); el pescado pasa a la apertura del III (K5).
- C5 bis: problemática sustituida por la de K8.
- C6: Molina y Azpilcueta parafraseados sin comillas (citas no cotejadas con la edición original).
- C7: el apartado «0» va a I.1 como «qué es la competencia perfecta» (K1) y no a los supuestos de I.2.
- C8-C26: de las ~8 `\funcionclave` propuestas se dejan las 2 de K10 más la del largo plazo (`eq:largo-plazo`); el resto, ecuaciones numeradas (CRITERIOS: pocas).
- C18-C19: la telaraña del cuerpo en forma general ($q'/\lvert x'\rvert$), porque α es el parámetro de estática comparativa (K17); la lineal, al anexo E con $a_0,a_1,b_0,b_1$. Expectativas adaptativas y racionales, al anexo (K4, K7).
- C26: *ad valorem* con $t$ (canon, § 1), no con τ.
- C30: tabla de plazos con $J$ en lugar de $I$.
- C37: recortes R1-R13 aplicados (R2: anexo B como resumen con el gráfico del 3.A.12).
- C41-C47: anexos en el orden de K7 (A 1TFEB, B geometría, C controles, D parcial-general, E telaraña, F test).
- C34: sin la referencia a 3.B.8 (industria naciente), por no estar seguro de que ese tema la trate.

**Datos (V)**: aplicadas V1-V3, V5-V13, V14-V20, V22-V24, V26-V42. V4: aplicada la atribución, pero con Debreu (1951) en lugar de Debreu (1954), para casar con el 3.A.21. V21: el apellido se escribe «Le Châtelier», como en el 3.A.12 revisado (coherencia), aunque la grafía francesa es «Le Chatelier». V25: Samuelson (1941) citado; Arrow, Block y Hurwicz no hacen falta en un solo mercado (entrada quitada del `.bib`). V37: superprof sustituido por el enunciado de Bolzano con Sydsæter et al. (no por Wikipedia).

**Coherencia (K)**: aplicadas K1-K30. K2 con el título del III recomendado (D2). K7: anexo F nuevo; anexo 1 no se publica como tal, su idea útil en la `notaopositor` de I.1 (K29) y en el anexo D. K9: sin la frase de Joan Robinson (D5). K16: sin nombres de preparadores. K22: presentación de la telaraña de la ficha propuesta (CN4).

## Coherencia

- **Notación** (K17): $i$ consumidores y $j$ empresas, $U_i=n_i+\phi_i(x_i)$, $p^D(x)$ y $p^S(q)$, $C_j(\vect{w},q_j)$, $q^{\mathrm{CP}}$ y $q^{\mathrm{LP}}$, $p_c$ y $p_v$, $\varepsilon_D<0$ con $\lvert\varepsilon_D\rvert$ en las fórmulas, $\dot p=f(z(p))$, $\dot q=g(p^D-p^S)$, $p^e_t$, $\overline{c}$ y $\overline{q}$. Los cambios a las fichas (CN1-CN10) los aplica `tema-canon`.
- **Gráficos compartidos**: `estabilidad-parcial` copiado sin cambios del 3.A.21 (con su tabla `tab:estabilidad-parcial`); `geometria-costes` copiado sin cambios del 3.A.12.
- **Musgrave** (K28): casa con el `3A21.tex` (que lo mantiene en su II.1.3), con el matiz añadido.
- **Debreu**: 1951 (*The Coefficient of Resource Utilization*), como el 3.A.21, aunque propuestas-datos proponía Debreu (1954).
- **Contradicciones con otros temas (no se tocan; para `pendientes-coherencia.md`)**:
  - X1. 3.A.21: su `revision.md` dice que Musgrave se quitó, pero su `.tex` lo mantiene; el 3.A.16 sigue el `.tex`.
  - X2. 3.A.21, anexo D: «oferta con economías externas **o rendimientos crecientes**»; en competencia la oferta decreciente de la industria solo es por economías externas (el 3.A.16 lo dice así en III.3 c).
  - X3. 3.A.12, l. 443: «oferta… por encima del mínimo del coste medio» sin distinguir plazos (menor).
  - X4. 3.A.8: numerario $x_0$ y $U_h=x_0+\phi_h$ en una nota; aquí $n_i$ (D10).
  - X5. 3.A.17 (sin revisar): demanda con $q$, $P$ mayúscula y $\varepsilon_{q^D,P}$; al revisarlo, $p(q)$ y la comparación $p=\mathrm{CMg}$ frente a $\mathrm{IMg}=\mathrm{CMg}$.
  - X6. 4.B.8 (sin revisar): casos extremos de la incidencia al revés y $P_C/P_V$; debe reutilizar `incidencia.tex`.
  - X7. 3.A.22-3.A.24 (sin revisar): anexos de relación de temas que atribuyen el 2TFEB a 3.A.24.
  - X8. 3.A.3 (sin revisar): debe reutilizar `marshall-periodos.tex`.
  - X9. `mapa.yaml`: telaraña remitida a 3.A.10 (es 3.A.5/3.A.6) y modelo `telarana` sin ficha (CN4, CN8).
- **Le Châtelier**: el 3.A.12 escribe «Le Châtelier»; el `.bib` (heredado) dice «Le Chatelier», que es la grafía del autor. Conviene unificar en el canon.

## Dudas abiertas

Aplicado mientras Víctor no conteste en el artifact (decisiones del coordinador):
1. D1: el «0» dentro de I.1 (aplicado).
2. D2: título del III «Análisis de plazos: corto plazo, largo plazo y libre entrada» (aplicado).
3. D3: telaraña en II.1.3 como c) Extensiones (aplicado).
4. D4: enganche del refrán con el aceite (aplicado, con datos comprobados).
5. D5: frase de Joan Robinson **no** puesta (pendiente de Víctor).
6. D6-D7: $p^D(x)$ y $p^S(q)$; índices $i$ y $j$ (aplicados).
7. D8: crítica austriaca en la Opinión con Hayek (1948) y remisión a 3.A.3 (aplicada).
8. D9: Cordero Tarifa fuera de la bibliografía (aplicado; no tiene tema 3.A.16).
9. D10: numerario $n_i$ (aplicado).
10. D11: Musgrave con el matiz de K28 (aplicado).

Además:
- Citas sin comillas por no poder cotejarlas: Molina (1597), Azpilcueta (1556) y Ekelund y Hébert (nota 2). Si se quieren literales, hay que sacarlas de una edición publicada con página.
- Sin comprobar: páginas de Harberger (1964) y de Jenkin (1870); capítulo de Campante et al. (2021), citado sin localizador; la figura de De Vroey (fig. 1.1, p. 11) se ha comprobado en el índice de figuras, pero no la pendiente de la oferta normal en el original.
- Los 18 gráficos tienen ya su `.tex` en `graficos/` y el tema se ha construido en el worktree (36 páginas de tema, 8 de anexos y 3 de bibliografía).
- Las URL del portal agroalimentario de la Comisión Europea (`CE2026AceiteProduccion`, `CE2026AceitePrecios`) no se pudieron abrir en el control de calidad (el proxy de la red las redirige); la serie del INE sí: 162,761 (abril de 2024) y 90,19 (septiembre de 2025), −44,6 %, como dice el enganche.
- Word: la banda del título del III, partida con `\newline`, sale justificada con espacios anchos entre palabras (es del conversor, no del tema; afecta a cualquier título de primer nivel en dos líneas).
- Control de calidad: sin incidencias (17/10/2026). Corregido en esta fase: llave de $t$ fuera del gráfico `incidencia` (la cruzaba la oferta desplazada) y rótulo «vendedores» recolocado; puntos $A$, $B$ y $C$ nombrados en el texto de `corto-largo-industria` y `oferta-largo-plazo`; el impuesto (II.3.2) con bloques a) Idea y b) Modelo (i, ii, iii); condición de segundo orden de la empresa (necesaria con ≤, suficiente con <); «la primera y la tercera» condiciones dan $p=\mathrm{CMg}=\mathrm{CMe}$ en la libre entrada; «quienes no lo valoran más»; gráfico de la oferta a corto plazo más grande (0,8 del ancho).

## Instrucciones para el vídeo

- Funciones clave que se conservan en la esquina: las condiciones del equilibrio (`eq:equilibrio`) desde I.2 hasta el final y la maximización del excedente total (`eq:max-et`) desde II.2.2; en III, la del largo plazo (`eq:largo-plazo`).
- Al final quedan en la pizarra la función del equilibrio y el gráfico `corto-largo-industria`, que responden al enganche.
- Plan de pizarra por bloques: el de `propuestas-coherencia.md`, § 3.
