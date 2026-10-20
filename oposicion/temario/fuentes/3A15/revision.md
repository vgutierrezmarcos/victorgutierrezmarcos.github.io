# Revisión del tema 3.A.15 — La empresa: el tamaño eficiente y sus límites. Mención especial de la economía de los costes de transacción. La Teoría de la Organización Industrial: barreras a la entrada y mercados impugnables.

Fecha: 20/10/2026. Original: el antiguo 3.A.11 de Víctor («Análisis teórico de la empresa en el marco de la teoría de la organización industrial»; Word de 28/08/2023, `Tema 3.A.11 - v.2 - 2024.docx`), que él mismo había puesto al día con el título nuevo. Integración en 2 partes: la 1 escribió el preámbulo, la introducción y los bloques I y II; la 2, el bloque III, la conclusión, los anexos A-F, `seo.json` y este informe.

Fuentes de la integración: `_trabajo/original.md`, `pendientes.md` (P1-P62), `propuestas-contenido.md` (C1-C32), `propuestas-coherencia.md` (K1-K45, estructura final, C1-C9 al canon, D1-D10), `propuestas-datos.md` (V1-V57) con `bib-datos.bib`, y `desplazado-3A19.md` (barreras, precio límite, juego de disuasión e impugnables que el 3.A.19 deja aquí). El tema de ICEX-CECO (`icex.md`) solo se usó para contrastar: **no se cita ni se copia**; los bloques del original marcados como «copiados tal cual» de otro preparador y los párrafos de Policonomics se han redactado de nuevo desde las obras originales. Criterio ante discrepancias: estructura, minutos, etiquetas y notación, de coherencia; teoría y ejemplos, de contenido; cifras, de datos; y, por encima, las 5 decisiones del coordinador (estructura A, enganche de Coase y Lenin, notación, fuentes y errores).

## Resumen

- Nueva fuente `3A15.tex` en 3 bloques **en el orden del título** (estructura A, duda A15-01 del artifact, opción recomendada): **I. La empresa: el tamaño eficiente y sus límites** (7′: I.1 enfoque tecnológico 3′; I.2 objetivo y funcionamiento: límites internos, gerencialistas y agencia 4′); **II. La economía de los costes de transacción** (9′30″: Coase 2′, Williamson 3′30″, Grossman-Hart-Moore 2′30″, otros enfoques e implicaciones 1′30″); **III. La TOI: barreras a la entrada y mercados impugnables** (10′: Harvard y Chicago 2′30″, barreras 3′30″, impugnables 2′30″, Nueva TOI 1′30″). Introducción 2′30″ y conclusión 1′ (suma 30′). Se conservan todos los títulos de 2.º y 3.er nivel del original (tabla de correspondencias de coherencia, § 3.2).
- Hilo conductor: cada bloque levanta uno de los 3 supuestos de la «caja negra» neoclásica (maximiza el beneficio → I; es una función de producción → II; la estructura de mercado es un dato → III), y la idea final responde a la pregunta del enganche (Coase en 1931-1932: si el mercado coordina, ¿por qué hay empresas, y por qué no una sola?). Funciones clave: `eq:coase`, `eq:gobierno`, `eq:precio-limite` y `eq:sostenible`.
- Corregidos los errores del original (impugnables con «rendimientos constantes» y «costes de menú», Baumol sin beneficio mínimo, Williamson «alumno de Coase», frecuencia, Grossman y Hart «1985», «la empresa crece hasta hacerse con todos los derechos residuales», Holmström en derechos de propiedad, frontera de Coase en totales, *saltwater/freshwater*, Conthe/CNMV, Olivencia, Nobel de Williamson, umbrales del HHI).
- Barreras a la entrada (casi ausentes en el original) desarrolladas con el material del 3.A.19: definiciones, tipos, precio límite formalizado, juego de disuasión en 3 etapas sobre el árbol del 3.A.14, señal, depredación, proliferación de marcas y costes de los rivales. El 3.A.15 queda como tema de referencia de los mercados impugnables (D071).
- `3A15.bib` con 173 entradas; 13 gráficos pedidos (9 nuevos y 4 reutilizados de los temas 3.A.12, 3.A.14 y 3.A.17); 2 tablas en LaTeX (supuestos frente a la lista común, taxonomía de Fudenberg y Tirole); 6 anexos (A escuela austriaca y Schumpeter; B derivaciones: Baumol, Riordan-Williamson, infrainversión, Cowling-Waterson, equilibrio impugnable; C taxonomía; D gobierno corporativo; E plataformas; F test).

## Errores corregidos

| Dónde (original) | Decía | Dice ahora |
|---|---|---|
| Relevancia y nota 27 (l. 105) | Nobel de Williamson «por sus teorías sobre el papel de las empresas en la resolución de conflictos…» | Motivación oficial: «por su análisis de la gobernanza económica, en especial de los límites de la empresa» (traducción propia), enlazada con el título (V17, K9) |
| Nota 6 (Ostrom) | «Otra estructura de gobernanza… es la propiedad privada comunal» | Gobierno de los recursos de uso común por sus usuarios (nota con remisión al 3.A.23, K25) |
| Enfoque tecnológico (l. 586, 602) | Tamaño = «planta que minimice sus costes medios»; subaditividad $C(\sum q_i)<\sum C_i(q_i)$ con funciones distintas | Escala mínima eficiente $\overline{q}$, $J^*=x(\overline{c})/\overline{q}$; subaditividad con la **misma** $C(\cdot)$, como definición del monopolio natural; planta frente a empresa en la valoración (C3, K32) |
| Economías de alcance (l. 618) | $C(X,Y)<C(X,0)+C(0,Y)$ | $C(q_1,q_2)<C(q_1,0)+C(0,q_2)$ |
| Baumol (l. 858-868) | Numeración 1, 5, 6; produce «donde el ingreso marginal es cero»; tercer motivo «gestión tranquila → colusión tácita» | Maximiza el ingreso **sujeto a $B\geq\underline{B}$**; IMg = 0 solo si la restricción no es activa; si lo es, $q^B>q^M$ con $\mathrm{IMg}=\frac{\lambda}{1+\lambda}\mathrm{CMg}$; el tercer motivo se quita (la «vida tranquila» es de Hicks, 1935, y se usa en la bisagra de la ineficiencia X) (P46, C5, K23) |
| Williamson (1964) (l. 890-896) | $\max U=f(S,M,T)$ s.a. $\pi_R\geq\pi_0$ sin definir; T para la inversión discrecional | $U(S,M,I_D)$ s.a. $B(S)-M\geq\underline{B}$, con $I_D$ definido (P47, K32) |
| Marris (l. 928-932) | Maximiza crecimiento de demanda y fondos sin restricción | Con la restricción de seguridad (ratio de valoración) frente a la absorción (C5) |
| Agencia (l. 954) | «ponderación óptima entre los objetivos y los riesgos» | Dilema dar incentivos frente a repartir el riesgo, PC e IC, coste de agencia, con las palabras del 3.A.13 (K36) |
| Coase (l. 658) | El enfoque «concibe la producción como unidades que se relacionan… a través de contratos a largo plazo» | La empresa sustituye el precio por la autoridad (Coase, 1937; Robertson) (C8) |
| Coase (l. 680) | «Crecerá hasta que los costes de gestión se igualen a los costes de transacción» (totales) | Condición en el **margen**: `eq:coase`, $\mathrm{CMg}^{\mathrm{org}}(m^*)=\mathrm{CMg}^{\mathrm{tr}}(m^*)$ (K19) |
| Williamson (l. 686) | «Williamson (alumno de Coase)» | Doctorado en Carnegie (1963) con Simon, Cyert y March; nota con la biografía Nobel (P44, V18) |
| Williamson (l. 688) | «Frecuencia (+): mayores costes de transacción» | La frecuencia justifica el coste fijo de una estructura de gobierno especializada; con activos específicos y transacciones frecuentes, compensa integrar (K20) |
| Derechos de propiedad (l. 740) | Grossman y Hart «en 1985» | 1986 (*JPE* 94(4)); con Hart y Moore (1990) (P45, V20) |
| Derechos de propiedad (l. 756-758) | Derechos específicos «con información completa (material de oficina)» y residuales «(trabajo cualificado)» | Derechos específicos (los del contrato) y derechos residuales de control **sobre activos** (Hart, 1995) |
| Derechos de propiedad (l. 760) | «La empresa crecerá hasta hacerse con todos los derechos residuales» | La integración da incentivos a uno y los quita a otro: la propiedad va a quien más aporta su inversión; ese coste es un límite al tamaño (K21) |
| Holmström (l. 764) | En el bloque de derechos de propiedad, «*benchmark* sin información asimétrica» | Holmström (1979) es riesgo moral **con** información asimétrica: resumido en I.2.3 (agencia) con remisión al 3.A.13 (K22) |
| Título 1.2 | *Saltwaters* (Harvard) vs *Freshwaters* (Chicago) | «Harvard y Chicago» (la etiqueta es de un debate de macroeconomía) (K15) |
| ECR, resultado (l. 296) | Pérdida por «no operar en el mínimo de sus costes medios (ineficiencia productiva)» | Pérdida sobre todo **asignativa** (triángulo de Harberger), a la que se suma la ineficiencia X (K16) |
| Índices (l. 318-320) | $CI_x=\sum_{i=1}^n s_i$; «HH = ∑ s_i 2» | $\mathrm{CR}_m$ y $\mathrm{HHI}=\sum(100s_i)^2$; puente de Cowling-Waterson (P48, K24) |
| Nota 12 | EE. UU.: «HHI de 1.800, o cuando aumenta en más de 200» (mezcla 1982 y 2010) | Directrices de 2023 (> 1.800 y Δ > 100; o cuota > 30 % y Δ > 100), historia 1982 y 2010; UE 2004 (1.000/2.000, Δ 250/150) y borrador de 2026 (V1, V2) |
| Nueva TOI (l. 239 y 245) | Toma de Chicago «los mercados contestables» y a la vez «más cerca del ECR que de Chicago» | Formulación única de K17 en III.4 |
| Impugnables (l. 462-485) | 6 condiciones con «rendimientos constantes», «costes de menú», «la demanda se adapta instantáneamente» | 3 supuestos canónicos (misma tecnología; sin costes hundidos; retardo de reacción de la instalada) y «no hacen falta rendimientos constantes»; $p=\mathrm{CMe}$ con una empresa, $p=\mathrm{CMg}$ con 2 o más (P41, K13, K14) |
| Impugnables (l. 454, 526) | Mezcla el artículo de Baumol (1982) y el libro de Baumol, Panzar y Willig («*Industrial Structure*») | Las 2 obras con su título correcto (P42, V22) |
| Precio límite (3.A.19) | «El precio se situará por debajo de los costes medios de todas las empresas» | Basta con que el **entrante** no cubra $\overline{c}$; `eq:precio-limite` (C15) |
| Juego en 3 etapas (3.A.19) | π «beneficios unitarios» (son totales); $C_0$; «diluyendo los costes fijos» | $B^M$, $B^D$, $B^G$, CH; condición $B^D-B^G<\mathrm{CH}<B^M-B^D$ explicada (C16) |
| Tirole (l. 552) | «Otro trabajo con Laffont en 1998» | Laffont, Rey y Tirole (1998) y Laffont y Tirole (2000) (V29) |
| «Formal and Real Authoriy», Tirole y Aghion (l. 806) | Errata y orden | Aghion y Tirole (1997) (V30) |
| Gobierno corporativo (l. 982, 988) | Olivencia «1999»; «la CNMV aprobó en 2015… (Código Conthe)» | Olivencia 1998; Código Conthe = Código unificado de 2006; Código de buen gobierno de la CNMV de 2015, revisado en 2020 (V3) |
| Remisiones (P55) | Numeración antigua (3.A.9, 3.A.10, 3.A.14-3.A.17, 3.A.24, 3.A.25…) | Traducidas con `\vertema` (K30) y añadidas las que faltaban (K31) |

## Marcas resueltas

| Marca | Qué se hizo |
|---|---|
| P1, Churchill y «su relevancia en la economía es vital» (amarillo) | Fuera: la frase no está documentada como cita (V41); la relevancia se reescribe con los Nobel, Simon (1991) y los márgenes crecientes |
| P2, Laffont-Tirole «copiado tal cual» y notas 20-21 | No se publica; resumido en III.4 con las obras originales y remisión a 3.A.17 y 3.A.20 |
| P3-P6, «Otras teorías…», Wernerfelt, Alchian-Demsetz, Aghion-Tirole (amarillo, «copiado») | Redactado de nuevo en II.4 desde las obras (Penrose, 1959; Wernerfelt, 1984; Alchian y Demsetz, 1972; Jensen y Meckling, 1976; Holmström y Milgrom, 1994; Aghion y Tirole, 1997); fuera el «cocinero» y «el empresario es el input» (no están en el artículo) |
| P7, lecturas pendientes de la bibliografía | Tirole (1988) y Lipczynski *et al.* (2017) citados; Church y Ware (2000) y Tremblay y Tremblay (2012) en el `.bib` pero sin citar (no consultados) |
| P8, bloque *Estructura* vacío | Escrito (K8) |
| P9-P12, notas al opositor de portada e introducción (cambio de temario, ficha oficial, orden de estudio, «hacerlo al revés», ICEX-CECO, «José Luis», Tremblay) | No se publican; la nota «hacerlo al revés» y la ficha fundamentan la estructura A |
| P13, «meter los contestables y las barreras» | Hecho: III.2 y III.3 con el material del 3.A.19 |
| P14, «Idea de estructura del apartado» e imagen 2 (esquema de otro preparador) | La imagen no se publica; el hilo («salida: barreras e impugnables») es el de III |
| P15, «no incluir a los austriacos» | Anexo A con una nota en Chicago (D3) |
| P16, «coordinar en temas…» | Nota privada fuera; coordinación en «Coherencia» |
| P17, párrafos de Policonomics | No se publican; sus ideas válidas, reescritas en III.3 |
| P18, NOIE vacía | Escrita (Bresnahan, 1982, 1989; Schmalensee, 1989; Gasmi, Laffont y Vuong, 1992) |
| P19, Tirole y nota sobre Toulouse | Aportaciones del *Scientific Background* de 2014; la nota de Toulouse no se publica |
| P20, «Coase, Williamson y Hart IMPORTANTE» | Bloque II con 9′30″ y Hart con modelo |
| P21, «no dibujar las gráficas de costes» | Gráficos de costes como apoyo (reutilizados del 3.A.12), no en la pizarra |
| P22, «producir nosotros o recurrir al mercado» | Hilo del bloque II (*make or buy*) |
| P23, «usar la ineficiencia X de bisagra» | Hecho en la valoración de los gerencialistas, con la notación $\chi$ del 3.A.12 |
| P24, cajas de anotaciones | Conservadas: Ha-Joon Chang y *The Economist* (de pago) en la introducción; cita de Coase (1937, p. 390) en II.1; Nada es Gratis y el blog de derecho mercantil en II.3 (enlaces comprobados, V46-V49) |
| P25, preguntas de otros exámenes y enlace a quia.com | Anexo F con respuesta breve y el enlace genérico al simulador |
| Imágenes 2-4 y nota 22 (Policonomics) | Sustituidas por `costes-l`, `subaditividad`, `alcance` y `stigler` |
| Imágenes 5-6 (sin fuente; título «*s*») | Rehechas como `baumol` y `williamson-gerencial` con la notación nueva |
| Nota 25 (sin fuente) | Nota conservada con `contratos-red` (esquema propio) |
| Imagen 11 (captura de pantalla de Word) | No se publica; sin sustituto (no hacía falta) |
| Notas 16-18 (encargo de las aerolíneas, Pepephone, «pocos autores…») | Fuera; sustituidas por la evidencia de la aviación y las críticas con fuente |
| Nota 33 (Enron, YouTube) | Sustituida por Healy y Palepu (2003) |
| Notas 23 y 26 (economipedia) | Fuera; tipos de costes de transacción en el texto (Coase, 1937, 1991) |
| Nota 29 («activos específicos cada vez más comunes») | Fuera (sin fuente) |
| Littlechild entre comillas (l. 406) y opinión atribuida al Informe Olivencia (l. 982) | Fuera (no localizadas); en el anexo A, el *price cap* se cita con el informe de Littlechild (1983), sin cita textual |

## Datos actualizados

Consulta de todas las fuentes: 20/10/2026.

| Dato | Valor anterior | Valor nuevo | Fuente | URL | Segunda comprobación |
|---|---|---|---|---|---|
| Umbrales del HHI, EE. UU. (V1) | «1.800 o aumento de 200», sin fecha | 2023: HHI > 1.800 y Δ > 100 (o cuota > 30 % y Δ > 100); 2010: 2.500 y 200; 1982: 1.800 | DOJ y FTC | https://www.justice.gov/d9/2023-12/2023%20Merger%20Guidelines.pdf | Nota 15 de las directrices de 2023; FTC, 18/2/2025 (vigencia) |
| Umbrales del HHI, UE (V2) | — | 2004: < 1.000; 1.000-2.000 con Δ < 250; > 2.000 con Δ < 150; borrador de 2026 igual | Comisión Europea | https://eur-lex.europa.eu/legal-content/EN/TXT/HTML/?uri=CELEX:52004XC0205(02) | Borrador de 30/4/2026 y calendario de la revisión |
| Gobierno corporativo (V3) | Olivencia 1999; «Código Conthe» de 2015 | Olivencia 26/2/1998; Aldama 2003; Conthe 22/5/2006; CNMV 18/2/2015, revisado en junio de 2020; nueva revisión prevista para 2027 | CNMV | https://www.cnmv.es/Portal/Legislacion/COBG/COBG.aspx | Introducciones de los códigos de 2015 y 2020; nota de prensa de 18/11/2025 |
| Art. 252 CP (V4) | Sin norma | LO 1/2015, en vigor el 1/7/2015 | BOE | https://www.boe.es/buscar/act.php?id=BOE-A-2015-3439 | Texto consolidado del CP |
| Empresas en España (V5) | — | 3.310.824 a 1/1/2025; 54,4 % sin asalariados; 2,3 % con 20 o más | INE, DIRCE | https://www.ine.es/dyngs/Prensa/DIRCE2025.htm | Eurostat y Cifras PYME (cuadran con las diferencias de definición) |
| VAB por ocupado según tamaño (V7) | — | España 2024: grandes 71.900 € frente a micro 42.800 € (1,7 veces); UE-27 2023: 2,1 veces | Eurostat, `sbs_sc_ovw` | https://ec.europa.eu/eurostat/databrowser/view/sbs_sc_ovw/default/table?lang=en | Misma serie, España 2023 (1,8 veces); sin segunda fuente independiente |
| Agencias de calificación (V9) | Sin dato | S&P, Moody's y Fitch, 92 % del mercado de la UE; HHI ≈ 3.600 | ESMA (18/12/2025) | https://www.esma.europa.eu/sites/default/files/2025-12/ESMA84-900617762-2652_CRA_Market_Share_Calculation_2025.pdf | Edición de 2024 |
| Taxis y VTC (V11) | «Ministerio de Fomento» | Sentencia del TJUE de 8/6/2023, C-50/21 (1 VTC por 30 taxis) | TJUE | https://curia.europa.eu/juris/liste.jsf?num=C-50/21 | Comentarios jurídicos de junio de 2023 |
| Márgenes (V13) | — | + 8 % desde 2000 en las economías avanzadas | FMI, *WEO* abril de 2019, cap. 2 | https://www.imf.org/en/Blogs/Articles/2019/06/06/blog-the-rise-of-powerful-companies | Resumen del capítulo (el PDF devuelve 403) |
| Google y DMA (V14) | — | Shopping, 2.424 M€ confirmada el 10/9/2024; Android, 4.125 M€ firme el 2/7/2026; 7 guardianes designados hoy y 23 servicios | TJUE y Comisión | https://curia.europa.eu/site/upload/docs/application/pdf/2026-07/cp260093en.pdf | Comunicados 135/24 y 93/26; portal de la DMA |
| Ley 15/2007 (V15) | — | «la competencia efectiva en los mercados» (preámbulo; art. 10) | BOE | https://www.boe.es/buscar/act.php?id=BOE-A-2007-12946 | Mismo texto consolidado |
| Fisher Body (V21) | — | 60 % en 1919, contrato de 10 años; resto en 1926 | Klein, Crawford y Alchian (1978); Coase (2000) | https://doi.org/10.1086/466922 | Resumen de Coase (2000) en IDEAS |
| Motivaciones Nobel (V17) | Williamson mal | 6 premios: Simon 1978, Stigler 1982 («por sus estudios fundamentales de las estructuras industriales, el funcionamiento de los mercados y las causas y los efectos de la regulación pública»), Coase 1991, Williamson 2009, Tirole 2014, Hart y Holmström 2016 (traducción propia) | nobelprize.org | https://www.nobelprize.org/prizes/economic-sciences/2009/summary/ | Notas de prensa de 1991 y 2009 |

No se usan V6 (peso de las pymes), V8 (Cifras PYME de agosto de 2026), V10 (concentración bancaria, sin dato) y V12 (Pepephone, Orange-MásMóvil: decisión no leída), para no alargar el cante; V16 (Sherman y Clayton) se cita con la FTC.

## Contenido añadido

- **Introducción**: los 5 bloques; enganche con la anécdota de Coase y Lenin (conferencia Nobel de 1991); bloque común con el 3.A.17 (individualismo metodológico, técnicos/costes/organizativos y de mercado) con sus 2 notas idénticas; relevancia con 6 Nobel (Simon, Stigler, Coase, Williamson, Tirole, Hart y Holmström), Simon (1991) y márgenes; contextualización con los 3 supuestos de la caja negra en el orden de los bloques y la TOI en sentido amplio; problemática; estructura; esquema y reparto del cante.
- **I**: escala mínima eficiente, costes en L (Bain, Stigler), $J^*$, subaditividad y alcance; evidencia (superviviente, DIRCE, Eurostat, Gibrat, Zipf, superestrellas frente a Philippon); valoración con Teece (1980); límites internos: dirección como factor fijo (Kaldor, Robinson, Penrose), pérdida de control (Williamson, 1967), Berle y Means; gerencialistas con a)-c); bisagra de la ineficiencia X (Leibenstein, Hicks, Stigler, 1976); agencia con a)-c), Jensen y Meckling, disciplina (Manne, Fama, Holmström, 1999), Niskanen, Enron.
- **II**: Coase con el margen y su gráfico, teléfono y telégrafo, Coase (1960) frente a Coase (1937); Williamson con racionalidad limitada y oportunismo, 3 atributos, cuasirrenta y *hold-up*, monopolio bilateral y doble marginalización (nota), estructuras de gobierno con `eq:gobierno`, Riordan-Williamson, intervención selectiva, Fisher Body con su debate (Coase, 2000; Casadesus-Masanell y Spulber, 2000; Freeland, 2000; Klein, 2000), evidencia (Monteverde y Teece, 1982; Joskow, 1987; Lafontaine y Slade, 2007); Grossman-Hart-Moore con un modelo de infrainversión (Hart, 1995, cap. 2), prisiones (Hart, Shleifer y Vishny, 1997), Baker y Hubbard (2003), Hart (2017); otros enfoques e implicaciones.
- **III**: ECR con CR_m, HHI, Cowling-Waterson, umbrales 2023/2004; Chicago (Stigler, McGee, Demsetz); barreras: Bain, Stigler, von Weizsäcker, tipos, entrada bloqueada/disuadida/acomodada; precio límite a)-c) con `eq:precio-limite` y el caso lineal en nota; compromiso de capacidad a)-d) con el árbol en 3 etapas; señal (Milgrom y Roberts), depredación (McGee, Selten, Kreps-Wilson, Areeda-Turner), proliferación (Schmalensee, Judd), costes de los rivales (Salop y Scheffman), efectos de red; impugnables a)-d) con la tabla de supuestos, `eq:sostenible`, competencia efectiva, industrias de red, aviación (Bailey y Panzar, 1981; Bailey y Baumol, 1984; Morrison y Winston, 1987) y críticas (Schwartz y Reynolds, Stiglitz, Weitzman, Shepherd, Spence, réplica de 1983); Nueva TOI, NOIE y Tirole (Fudenberg-Tirole, Hart-Tirole, Laffont-Tirole, Laffont-Rey-Tirole, Rochet-Tirole).
- **Conclusión**: recapitulación por bloques, relevancia, extensiones (con la DMA), opinión e idea final que retoma a Coase y Lenin.
- **Anexos**: A austriacos y Schumpeter (con Arrow, 1962); B derivaciones; C taxonomía de Fudenberg y Tirole; D gobierno corporativo; E plataformas; F test.

### Estado de cada propuesta

- **Coherencia**: K1-K14 aplicadas (K11: frases de apertura y puentes; K12: conclusión; K13-K14: impugnables). K15-K17 aplicadas. K18 aplicada (las barreras van antes que los impugnables; la frase «como hemos visto» desaparece y la fragilidad remite al compromiso de capacidad). K19-K32 aplicadas, con estos cambios: en K23, la lagrangiana se escribe sin 𝓛 (es Lerner); en K24, la nota de Cowling-Waterson va al cuerpo en una línea y la derivación al anexo B. K33 aplicada como tabla completa en III.3 (no solo la fila 5), con la fila 5 «se levanta» (barreras) y «se refuerza» (impugnables). K34-K37 aplicadas. **K38 aplicada en la forma, no en los números**: el árbol se construye sobre el del 3.A.14 con $B^M$, $B^D$, $B^G$ y CH, pero con los pagos de contenido (C16): sin invertir (0, 4), (1, 1), (−1, −1); invirtiendo con CH = 2,5: (0; 1,5), (1; −1,5), (−1; −1), porque los de K38 ((0, 3), (1, 0), (−1, 1) con CH = 1) no salen de una regla explícita y la condición de C16, $B^D-B^G<\mathrm{CH}<B^M-B^D$, es la clásica del 3.A.19. K39-K45 aplicadas.
- **Contenido**: C1 aplicada con la estructura de coherencia (I con 2 subapartados: la evidencia de C7 pasa a I.1 c); los límites de C4 se reparten entre I.2.1 y las implicaciones de II.2). C2-C3 aplicadas (sin la referencia a la tabla de supuestos en I.1; la subaditividad como ecuación numerada, no como función clave). C5 con $q^B$ en lugar de $q^S$. C8 sin la página 395 (no comprobada). C9 con $a$ en lugar de $k$ (decisión 3). C10-C12 aplicadas. C13-C19 aplicadas con los títulos de 3.er nivel del original (paradigma ECR – Harvard; Chicago) y los umbrales de V1-V2 en nota. C20-C26 aplicadas (C25 como anexo E, con las cifras de V14 de 2026). C27-C32 aplicadas.
- **Datos**: V1-V5, V7, V9, V11, V13-V39, V46-V57 aplicadas o integradas en el `.bib`; V6, V8, V10, V12 no usadas (arriba); V40-V45 resueltas quitando las citas no encontradas.
- **Añadido por el editor**: `Coase1960Problem` (*JLE* 3, 1-44, doi 10.1086/466560) para la extensión de II.1. En el control de calidad: `Nobel1982Stigler` (motivación comprobada en nobelprize.org), `Littlechild1983Regulation` (sustituye a `Littlechild1981Misleading`, que no se citaba), `Kirzner1973Competition`, `CNMV2006Unificado` (Código Conthe, 22/5/2006); páginas de `BaileyBaumol1984Deregulation` completadas (111-137, comprobadas con los encabezados del texto en el repositorio de la Yale Law School); `shortauthor` para las comisiones Olivencia y Aldama y la CNMV.

## Coherencia

- **Notación (canon)**: B (nunca π), $\underline{B}$, $I(q)=p(q)q$, $q^B$ (Baumol), $q^M$, $p^M$; $U(S,M,I_D)$; χ (ineficiencia X, como el 3.A.12); $m$, $\mathrm{CMg}^{\mathrm{org}}$, $\mathrm{CMg}^{\mathrm{tr}}$ (Coase); $a$ especificidad con $C_{\text{mercado}}(a)$, $C_{\text{híbrida}}(a)$, $C_{\text{jerarquía}}(a)$, umbrales $a_1<a_2$ y $C^*(a)$, $\Delta C(a)$, $\Delta G(a)$, $\overline{a}$, $\hat a$ ($k$ es en el canon el grado de homogeneidad); $e$, $y(e)$, $y_0(e)$, $e^*$, $e^o$, γ = ½ (GHM); $\overline{q}$, $\overline{c}$, $J^*$ (3.A.16); $p^L$, $q^L$; $B^M$, $B^D$, $B^G$, CH; $q_{\mathrm I}$, $q_{\mathrm E}$; $\mathrm{CR}_m$, $\mathrm{HHI}$ con $s_i\in[0,1]$; $\mathcal{L}$ Lerner y $|\varepsilon_{q,p}|$; θ parámetro de conducta (local, avisado en nota); demanda lineal del precio límite $p(Q)=\alpha_0-bQ$ (sin $a$). Todo lo nuevo, para `canon/cambios.md` (coherencia C7).
- **Para el canon** (`tema-canon`): C1 (`mercados-impugnables` con referencia 3.A.15 y los supuestos corregidos), C2 (`disuasion-entrada` con alias `precio-limite`; gráficos `precio-limite` y `disuasion-arbol`), C3 (`costes-transaccion`; gráfico `gobierno-williamson`), C4 (`contratos-incompletos`), C5 (`estructura-conducta-resultado`; `modelos-gerencialistas` solo si el 3.B.4 la usa), C6 (filas del 3.A.15 en las fichas existentes), C8-C9 (`mapa.yaml` e `informe-repaso.md`).
- **Promesas de temas revisados que se cumplen** con sus palabras: 3.A.11 (organización y límites), 3.A.12 (tamaño eficiente, Leibenstein → agencia y contratos incompletos), 3.A.13 (Jensen y Meckling, Grossman-Hart-Moore, Milgrom-Roberts), 3.A.14 (compromiso de capacidad sobre su árbol, señal, reputación), 3.A.16 (lista común; costes hundidos), 3.A.17 (barreras, Modigliani, impugnables con $p=\mathrm{CMe}$, integración vertical y doble marginalización, «no condenar de antemano»), 3.A.18 (proliferación de marcas).
- **Cambios opcionales a temas revisados** (para `pendientes-coherencia.md`): PC1 (3.A.13, matiz del equilibrio separador en el precio límite como señal), PC2 (3.A.11, «teoría de la empresa y de la organización industrial»), PC3 (3.A.14, citas de Spence y Dixit y remisión de la predación).
- **Contradicciones con otros temas** (no se tocan): 3.A.19 (6 condiciones erróneas de impugnabilidad, notas de las aerolíneas y Pepephone, juego en 3 etapas con π y «beneficios unitarios», precio límite sin fórmula: al revisarlo, resumir y remitir aquí); 3.B.4 (copia del bloque de costes de transacción con los mismos errores: Coase en totales, frecuencia, «contratos incompletos de Williamson», título de Penrose, Marris en agencia); 3.A.23 (índice con numeración antigua; su Coase, 1960, debe distinguirse del de 1937); 4.B.15 (resumir los impugnables con los supuestos canónicos); 3.B.39 (remitir la depredación aquí); 3.A.1 (Harvard y Simon, coherente).

## Dudas abiertas

Mientras Víctor no conteste en el artifact, se aplica la opción recomendada de cada duda.

**De coherencia (D1-D10)**:

1. **D1 (A15-01 en el artifact), estructura**: aplicada la **A** (orden del título: tamaño eficiente y límites 7′ → costes de transacción 9′30″ → TOI 10′), que invierte los bloques del original como pedía la propia nota de Víctor. Alternativas: B (orden del original: TOI → teoría de la empresa → objetivos) o C (tecnología y costes de transacción juntos; la «mención especial» sin bloque propio).
2. **D2, detalle de las barreras**: aplicado el desarrollo en el cuerpo, con el precio límite y el árbol en la pizarra (3′30″). Alternativa: precio límite formal al anexo.
3. **D3, austriacos y Schumpeter**: aplicado, al anexo A con una nota al pie en Chicago.
4. **D4, plataformas**: aplicado, una línea en III.2 (efectos de red), otra en III.4 (Rochet y Tirole), la DMA en la conclusión y el anexo E (que añade contenido). ¿Se quita el anexo E?
5. **D5, gerencialistas**: aplicado, Baumol con gráfico en la pizarra, Williamson (1964) con gráfico en el cuerpo sin cantar, Marris en una frase en el cante.
6. **D6, notación nueva**: aplicada ($p^L$, $q^L$; $B^M$, $B^D$, $B^G$, CH; $\underline{B}$; $a$ con $C_{\text{mercado}}(a)$…; $\mathrm{CR}_m$, HHI con $s_i\in[0,1]$; $q^B$).
7. **D7, enganche**: aplicada la anécdota de Coase y Lenin (decisión del coordinador); Loasby y Churchill fuera.
8. **D8, fichas nuevas**: una sola `disuasion-entrada` con `precio-limite` como alias (recomendada).
9. **D9, lista común de supuestos**: aplicada como tabla completa en III.3 (`tab:supuestos-impugnables`), con la fila 5 levantada por las barreras y reforzada por los impugnables.
10. **D10, gobierno corporativo**: aplicado, una línea en I.2.3 y el anexo D.

**De contenido**: D4 (citas de Littlechild y del Informe Olivencia retiradas): aplicado. D6 (funciones clave): 4 recuadradas (`eq:coase`, `eq:gobierno`, `eq:precio-limite`, `eq:sostenible`); la subaditividad queda como ecuación numerada. D7 (letra de la especificidad): $a$ (decisión del coordinador), con la demanda lineal escrita $\alpha_0-bQ$.

**Datos sin verificar o con una sola fuente**:

- Página de la cita de Coase (1937): 390 según fuentes secundarias (una da 389); el original no se pudo abrir (V39).
- Bain (1949): volumen y páginas no comprobados en la revista (V27).
- VAB por ocupado por tramos: una sola serie oficial (V7).
- Márgenes del FMI: solo el resumen del capítulo (V13).
- Resultado del equilibrio separador de Milgrom y Roberts (1982): de la literatura; no se cita página.
- Robertson («islas de poder consciente»): traducción de la cita que recoge Coase (1937, p. 388), sin página en el texto.

**Otras**: la frase reservada de Joan Robinson (mapa a escala 1:1) no encaja aquí. El tema es largo (unas 15.500 palabras de fuente, con los anexos): el cante se ciñe a las notas al opositor. Compilado con `construir-tema.py 3A15` (PDF, HTML y Word) y comprobado con `verificar-tema.py`: **0 errores**, 4 avisos (2 «cifra sin cita» en las cajas de lecturas, falsos positivos por las URL, y la falta de `guion-cante.md` y `escenas.yaml`, de la fase de vídeo); 33 páginas de tema, 4 de anexos y 8 de bibliografía (45 en total), 0 cajas desbordadas.

## Instrucciones para el vídeo

- **Introducción y conclusión, sin pizarra** (`modo: guion`). Enganche: Coase, con 20 años, cruza el Atlántico en 1931 con una beca; Lenin quería una economía como una gran fábrica, los economistas occidentales decían que era imposible y, sin embargo, en Occidente había fábricas enormes. Pregunta: «Si el mercado coordina tan bien, ¿por qué existen las empresas? Y, si dentro de una empresa se planifica con éxito, ¿por qué no se organiza toda la economía como una sola?». La idea final la responde retomando a Lenin y a los profesores de Coase: los 2 cuestan; hay empresas porque los contratos no lo prevén todo, y no hay una sola porque la jerarquía también tiene costes: islas de organización en un mar de mercado.
- **Funciones clave que se conservan** (`conservar:`): `eq:coase` desde II.1 hasta la conclusión (la idea final vuelve a ella); `eq:gobierno` desde II.2 hasta el final de II; `eq:precio-limite` desde III.2 hasta el final de III.2; `eq:sostenible` desde III.3 hasta la conclusión.
- **I.1**: nada imprescindible en la pizarra; se escriben la subaditividad y las economías de alcance en una línea cada una. `costes-l`, `subaditividad` y `alcance`, como apoyo; el dato de España, como apunte.
- **I.2**: `baumol` por capas en la pizarra (I, C, B, recta $\underline{B}$, $q^M$, IMg = 0, $q^B$) con el problema `\optim` arriba; Williamson (1964) y Marris de palabra, con `williamson-gerencial` como apoyo; la fórmula de la ineficiencia X, como apoyo. Agencia de palabra, con los 3 costes de Jensen y Meckling como apunte.
- **II.1**: `coase-margen` por capas y `eq:coase` recuadrada a su lado; los 2 desplazamientos (teléfono; plataformas) como capas finales. `contratos-red`, como apoyo.
- **II.2**: `gobierno-williamson` por capas (las 3 rectas, $a_1$, $a_2$, envolvente, rótulos bajo el eje) y `eq:gobierno` recuadrada encima; es el gráfico central del tema. Fisher Body, de palabra con la cifra del 60 % como apunte.
- **II.3**: esquema a mano de la secuencia (propiedad → inversión $e$ → negociación ½ → comercio) y la condición $\tfrac12 y'+\tfrac12 y_0'=1$ frente a $y'=1$; el resto, de palabra.
- **II.4**: sin pizarra; los 5 enfoques como lista de apoyo.
- **III.1**: `ecr` como apoyo rápido (las flechas de vuelta en la última capa); el HHI en una línea a mano.
- **III.2**: pizarra en 2 columnas: a la izquierda, `precio-limite` por capas con `eq:precio-limite` recuadrada; a la derecha, `disuasion-arbol` construido **desde el árbol del 3.A.14** (primero el subárbol sin inversión, que el espectador reconoce; después la raíz y la rama con inversión; aspas y ENPS en rojo) y la desigualdad $B^D-B^G<\mathrm{CH}<B^M-B^D$ debajo. Señal, depredación y proliferación, de palabra.
- **III.3**: los 3 supuestos como apoyo (la tabla `tab:supuestos-impugnables`, si se quiere, como apoyo); `eq:sostenible` recuadrada; `impugnables` como apoyo (es el gráfico del 3.A.17). Al terminar III, la pizarra queda con `eq:coase` y `eq:sostenible`.
- **III.4**: sin pizarra; la condición de la NOIE con θ, como apoyo.
- **Pronunciación** (si hace falta): Coase, Williamson, Grossman, Holmström, Sylos-Labini, Modigliani, Weizsäcker, Panzar, Willig, Penrose, Marris.
