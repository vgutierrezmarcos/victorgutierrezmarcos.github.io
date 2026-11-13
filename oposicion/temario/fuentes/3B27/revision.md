# Revisión del 3.B.27 — Regulación financiera bancaria y no bancaria. Fundamentos teóricos y evidencia empírica

Revisión completa del 13/11/2026 (entrega 1: tema y ficha de repaso; sin vídeo), en la rama `revision-temario-2`, con las reglas acumuladas hasta la 9.ª tanda y la revisión transversal del 13/11/2026. Fuente nueva en LaTeX (`3B27.tex`) escrita desde el Word antiguo (`Tema 3.B.27.docx`, 22.876 palabras, 46 págs., 27 tramos en amarillo, 3 en rojo, 4 notas al opositor, 19 comentarios internos). El Word decía estar «copiado del tema de Juan Luis» (preparador): **todo el texto está redactado de nuevo**, con la estructura del original. Los datos regulatorios se han comprobado en fuentes oficiales (bis.org, fsb.org, eba.europa.eu, bankingsupervision.europa.eu, srb.europa.eu, esm.europa.eu, eur-lex, boe.es, bde.es, esma.europa.eu, eiopa.europa.eu, federalreserve.gov, bankofengland.co.uk) el 13/11/2026.

## 1. Resumen

- Estructura del original mantenida (I fundamentos, II instrumentos, III evidencia) con los títulos de segundo nivel en su orden; se añade **II.3 Regulación financiera no bancaria**, que pide el título y el original no tenía (lo anotaba su propio comentario). Reparto: introducción 2′30″, I 10′, II 10′, III 6′30″, conclusión 1′.
- Enganche nuevo con refrán no usado en otro tema: **«Cada palo que aguante su vela»** (ayudas públicas a la banca frente al *bail-in* de Credit Suisse); la idea final lo retoma y responde a la pregunta del principio.
- Modelos con la estructura rígida a)-e): **Stiglitz y Weiss** (resumen con la presentación del canon y el gráfico del 3.A.13), **Diamond y Dybvig** (resumen con la notación del canon, π, R, L, c₁, c₂, y el gráfico del 3.B.26) y **Martínez-Miera y Repullo** (competencia y estabilidad, gráfico nuevo). Funciones clave en morado: `eq:stiglitz-weiss`, `eq:dd-optimo`, `eq:ratio-capital`, `eq:lcr`, `eq:nsfr`.
- Regulación al día: Basilea III final y su aplicación (BCBS, CRR3/CRD VI, FRTB en la UE desde 2027 con alivios, Reino Unido 2027, nueva propuesta de EE. UU. de 3/2026), colchones G-SIB y OEIS de España 2026, CCA del 1 %, MUS (109 entidades), FUR (> 81.000 M€), MEDE sin ratificar, EDIS bloqueado, paquete CMDI de 2026 (2026/804, 806 y 808), MiCA, DORA, AIFMD II, fondos monetarios, EMIR 3, T+1, Solvencia II revisada e IRRD, ICS de la IAIS.
- 6 gráficos (3 copiados sin cambios del canon, 3 nuevos), 4 tablas en el cuerpo y 2 en anexos; 4 anexos (Basilea I y II con un ejemplo numérico, respuesta a la covid-19 —todo lo del original—, cronología, test). PDF: 29 págs. de tema, 3 de anexos y 9 de bibliografía. Ficha de repaso: 4 págs. a 10,5 pt (última, 89 %).

## 2. Errores corregidos

| Dónde (Word) | Decía | Dice ahora |
|---|---|---|
| Stiglitz y Weiss, supuestos | «2 tipos de clientes: muy rentables y arriesgados / menos rentables y menos arriesgados»; «los bancos fijan tipos por criterios medios» con prima *ex post* | Igual rendimiento medio y distinto riesgo, responsabilidad limitada, 3 efectos de subir el tipo (ficha `stiglitz-weiss`, D070) |
| Stiglitz y Weiss, fórmula | E[B] = r̂ × Pr(repago)(r̂) | 𝔼[B_banco] = (1 + r̂)·Pr(repago ∣ r̂) |
| Stiglitz y Weiss, gráfico | «curva de oferta cóncava»; la QE desplaza la oferta «hacia arriba» | La oferta se dobla hacia atrás desde r̂*; más fondos la desplazan a la derecha (TLTRO, 2014) |
| Stiglitz y Weiss, implicaciones | Tirole y Holmström (2013): las empresas del S&P 500 «se sientan en 1.450 millones de dólares de efectivo» | Quitado (dato sin fuente que el canon retira); evidencia de Berger y Udell (1992) y Jiménez et al. (2012) |
| Diamond y Dybvig | Notación τ, r₁ < 1 < r₂, r₁ᵈ, r₂ᵈ; «3 tipos de agentes» | Notación del canon (π, R, L, c₁, c₂, T = 0, 1, 2), resumen con remisión al 3.B.26 (D042, D064) |
| Diamond y Dybvig, implicaciones | Grecia: «50.000 millones salieron en el primer semestre de 2015» | Solo el «corralito» como ejemplo de suspensión (la cifra canónica es «unos 40.000 M€», 3.B.26) |
| Fondo de garantía (nota 24) | Financiación «vía presupuestos (caso alemán)» | Fondos nacionales pagados por las entidades, objetivo del 0,8 % de los depósitos garantizados (DGSD) |
| Basilea III | «implementación completa prevista para 2023» | BCBS 1/1/2023 (suelo 50 % → 72,5 % en 2028); UE: CRR3 desde 1/1/2025, suelo hasta 2030, transitorios 2032 |
| Nota 37 | «Período transitorio del *output floor*: en 2013 será del 50 %» | 2023 en el BCBS; 2025 en la UE |
| Basilea III, colchón sistémico | «entre 1 % y 2,5 %» | G-SIB de 1 a 3,5 % (tramos 1; 1,5; 2; 2,5; 3,5) |
| G-SIB (notas 18 y 36) | «30 G-SIB en la lista de 2022» | 29 en la lista de 27/11/2025; Santander en el tramo del 1 % |
| MUS | «123 grupos bancarios, más del 80 % de los activos» | 109 entidades significativas (septiembre de 2026) |
| MUR | FUR «55.000 millones»; «hasta 2024, aportaciones nacionales»; *backstop* «previsto para 2024» | FUR de más de 81.000 M€ a 31/12/2025; respaldo del MEDE bloqueado (Italia rechazó la ratificación el 21/12/2023) |
| EDIS | «propuesta de 2017» | Propuesta de 2015, bloqueada (la Comisión anunció en julio de 2026 que la sustituirá) |
| Ministerios | DGSFP «dentro del Ministerio de Asuntos Económicos y Transformación Digital»; AMCESFI adscrita a ese ministerio | Ministerio de Economía, Comercio y Empresa (RD 410/2024) |
| Nota 28 | Hernández de Cos preside el Comité de Basilea «hasta la actualidad (16/01/2023)» | Quitado; preside Erik Thedéen desde el 11/6/2024 (no se nombra en el texto) |
| Barth, Caprio y Levine (2004) | «la supervisión eficaz tiene correlación positiva con la estabilidad» | Lo contrario: dar más poder al supervisor no mejora el desarrollo ni la estabilidad; funcionan la información y la vigilancia privada |
| Capital humano de las cajas | Atribuido a Fernández-Villaverde, Santos y Garicano (2013) | El resultado del capital humano es de Cuñat y Garicano (2010); el de 2013 trata de los ciclos de crédito políticos en la zona del euro |
| Imagen 10 | «modelo de Corunot estático y dinámico» | Gráfico propio: Boyd y De Nicolò (2005) frente a Martínez-Miera y Repullo (2010) |
| Delis, Hasan y Kazakis | 2012 | Review of Finance, 2014 |
| Englaimer y Stowasser; Schleifer; Lavine; Demirguç-Kunt, Feyer | Erratas | Englmaier y Stowasser (2017), Shleifer (La Porta et al., 2002), Levine, Demirgüç-Kunt y Feyen |
| Regla Volcker | «Volker» | Volcker; normas finales de 2013 |
| Remuneraciones | Tope del 100 % (CRD IV) | 100 %, o 200 % con el acuerdo de la junta |

## 3. Marcas resueltas

| Marca | Texto original | Qué se hizo |
|---|---|---|
| 4 notas al opositor | Aviso del cambio de temario (2023) e imagen | Eliminadas (avisos de cambio de temario) |
| Comentarios internos (19) | «Copiado todo del tema de Juan Luis…», «coordinarlo con José Luis», ICEX-CECO, correo de José Luis, comentario de Ángel, «ver tema-esquema de José Luis», rutas `file://` | No se publican. Lo que pedían se ha hecho: extender a la regulación no bancaria (II.3), NBFI en lugar de *shadow banking* (nota 1), anexos del marco institucional (tabla y anexo C), evidencia del manual de De Haan, Oosterloo y Schoenmaker (citado) y la idea de que «más regulación no es mejor regulación» (relevancia de la introducción). Sin nombres de preparadores. |
| Amarillo: «Selección adversa sobre la salud de una determinada entidad» (problemas 1-2, Fintech, Gowex, CNMV) | Esquema sin desarrollar | Integrado en I.2.1 como 4.º frente de la información asimétrica: licencias e idoneidad, información obligatoria, Gowex (2014) |
| Amarillo: «Fallo de regulación: abanico de posiciones» (austriacos, Benston y Kaufman, extensiva, banca pública) y enlace de Economipedia (efecto cobra) | Lista sin desarrollar | Desarrollado en I.2.4; efecto cobra en nota con el enlace |
| Amarillo: «Actores: Ministerio de Finanzas… Banco central: 3 modelos» | Esquema | Integrado en I.1 (3 modelos de supervisión) y II.1 |
| Amarillo y rojo: «Esto ya está copiado en la nota 9… sectorial, funcional, integrado; Kremers et al. (2003)» | Nota de trabajo | Desarrollado en I.1 («3 modelos»), con Kremers, Schoenmaker y Wierts (2003) |
| Amarillo: capital humano de las cajas | Atribución dudosa | Resuelto: Cuñat y Garicano (2010) y Fernández-Villaverde, Garicano y Santos (2013) |
| Rojo: «transferir riesgos» | Dudoso | Correcto: integrado en negro como función del sistema financiero |
| Basilea IV «(????-????)» vacío | Hueco | Se usa el nombre oficial del BCBS, «Basilea III final (2017)» (lo que algunos llaman Basilea IV) |
| Liquidez y control interno vacíos («iv) Aumentar la liquidez», «v) Herramientas de control interno») | Huecos | LCR y NSFR desarrollados; control interno en supervisión (SREP, pruebas de resistencia) |
| Conclusión: «Relevancia» y «Opinión» vacías | Huecos | Escritas |
| Cajas de anotaciones (15) | Enlaces y lecturas | Conservados: Economipedia, Arnal (2023) y Arnal et al. (2021) en «Para saber más»; Fiordelisi et al. (2022) en III.2; nadaesgratis, Vives (Project Syndicate), CEMFI 0801 en la bibliografía. El de VoxEU (bancos centrales y cambio climático) se menciona como reto en la conclusión, sin enlace (ver duda B27-07) |

## 4. Datos actualizados

| Dato | Antes | Ahora | Fuente | Consulta | Segunda comprobación |
|---|---|---|---|---|---|
| Crisis bancarias | — | 164 sistémicas 1970-2025; 32 % del PIB perdido y 6,7 % en ayudas (mediana, renta alta) | Laeven y Valencia (2026) | 12/11/2026 (3.B.26) | Mismas cifras y clave que el 3.B.26 |
| NBFI | — | 256,8 billones de $, 51,0 %; bancos 38,0 % (2024) | FSB (16/12/2025) | 13/11/2026 | Cuadro 1-1 del informe y nota de prensa |
| G-SIB | 30 (2022) | 29 (27/11/2025); Santander tramo 1 % | FSB | 13/11/2026 | PDF de la lista P271125 |
| OEIS España 2026 | — | Santander 1,25 %, BBVA 0,75 %, CaixaBank 0,5 %, Sabadell 0,25 % | Banco de España (30/7/2025) | 13/11/2026 | — (nota de prensa única) |
| CCA España | — | 0,5 % desde 1/10/2025; 1 % desde 1/10/2026 | BOE-A-2025-19516 | 13/11/2026 | Coincide con el CSV y el 3.A.42 |
| Brecha crédito-PIB | — | +47,3 (2007T2), −55,6 (2017T4), −24,3 (2026T1) | BIS | 12/11/2026 | Serie WS_TC del BIS (cabecera del CSV) |
| MUS | 123 grupos | 109 significativas (9/2026) | BCE | 13/11/2026 | Informe anual: 112 a 1/1/2026 |
| FUR | 55.000 M€ | > 81.000 M€ (31/12/2025) | JUR | 13/11/2026 | Clave `SRB2026FUR` del 3.B.16 |
| CET1 | — | 16,00 % MUS; 13,52 % España (2026T2) | BCE (15/9/2026) | 13/11/2026 | 1D01: «14 % frente a 16 %» con el Banco de España (otro perímetro) |
| Requisitos SREP | — | ≈ 11 % CET1, 16 % total | BCE (SREP 2025) | 23/10/2026 (1D01) | Mismas palabras que la 1D01 |
| Concentración | Infografía de Expansión (2020) | CR5 41,0 % (2007) → 69,6 % (2022) → 67,4 % (2025); UE 69,33 %; IHH 1.306 | BCE, SSI | 12/11/2026 | Prensa (CR5 2023: 69,5 %) |
| Calendario regulatorio | «2023» | BCBS, UE, RU, EE. UU., FRTB, CMDI, MiCA, DORA, AIFMD II, T+1, Solvencia II | Ver bibliografía | 13/11/2026 | Fuente oficial en cada caso; T+1 por la AEVM |

Todas las cifras que caducan están en `datos-actualizables.yaml`.

## 5. Contenido añadido

- **II.3 Regulación no bancaria** (lo pide el título): «mismo riesgo, misma regulación», valores, seguros y pensiones, fondos, infraestructuras, titulización, criptoactivos (MiCA, norma de criptoactivos del BCBS) y DORA, con tabla `tab:no-bancaria`.
- **Política macroprudencial** como apartado propio (II.2.2): instrumentos, regla del colchón anticíclico (`eq:cca`), España y provisiones dinámicas, *leaning* frente a *cleaning*.
- **Hipótesis de representación** (Dewatripont y Tirole, 1994) como fundamento de la regulación microprudencial; **Kareken y Wallace (1978)** y la *put* de Merton (1977) para enlazar la red de seguridad con el capital; **Admati y Hellwig** y Modigliani-Miller sobre el coste del capital.
- **Resolución** al día: CMDI 2026, MREL/TLAC, Popular, Credit Suisse, respaldo del MEDE.
- **Evidencia**: *too much finance* (Arcand et al., 2015; Cecchetti y Kharroubi, 2012), Rajan y Zingales (1998), Barth, Caprio y Levine (2013), macroprudencial (Cerutti et al., 2017; Jiménez et al., 2017), banca pública con sus referencias exactas, Martínez-Miera y Repullo con estructura a)-e).
- **Nobel** (revisión transversal): 2022 (Bernanke, Diamond y Dybvig, con la contribución de cada uno en la nota), 2001 (Stiglitz), 2014 (Tirole), 1982 (Stigler), 1997 (Merton), 1974 (Hayek), 1985 (Modigliani), cada uno con el motivo oficial en la primera mención.
- **4.º ejercicio**: `\vertema{4.A.15}`, `\vertema{4.A.18}`, `\vertema{4.A.19}`, `\vertema{4.A.20}`, donde encajan (marco español, crisis de las cajas, financiación no bancaria, competencia).

## 6. Coherencia

- Stiglitz-Weiss y Diamond-Dybvig como **resumen** con la presentación de sus fichas (D042, D064, D070) y los gráficos de referencia copiados sin cambios (`fuentes/3A13/graficos/stiglitz-weiss.tex`, `fuentes/3B26/graficos/diamond-dybvig.tex`); los números del pánico (71 %, P = 0,83) iguales que el 3.B.26.
- **Brecha crédito-PIB**: el 3.B.27 es su tema de referencia; gráfico del 3.A.42 copiado con la misma serie (CSV propio con consulta del 12/11/2026); la regla de 2 y 10 puntos (BCBS, 2010) se mantiene como en la ficha.
- **Basilea**: nuevo gráfico de referencia `graficos/requisitos-capital.tex` para la ficha `basilea-capital` (hasta ahora «sin .tex»); cifras coherentes con la 1D01 (7/8,5/10,5; ≈ 11 % de CET1).
- Claves bibliográficas reutilizadas de los temas revisados (`DiamondDybvig1983Bank`, `StiglitzWeiss1981Credit`, `LaevenValencia2026`, `FSB2025NBFI`, `SRB2026FUR`, `UE2026Dir804`, `CE2015EDIS`, `BCE2025SREP`…).
- Para el canon (`_trabajo/canon-pendiente.md`): ficha `basilea-capital` con gráfico y calendario; ficha `brecha-credito-pib` (3.B.27 hecho); posible ficha `competencia-estabilidad` (Martínez-Miera y Repullo); la ficha `union-bancaria` y el 3.B.26 dicen que la reforma CMDI es «la Directiva (UE) 2026/804»: son 3 actos (2026/804 DGSD, 2026/806 BRRD, 2026/808 SRMR).

## Comentarios de Víctor (13/11/2026, 9.ª tanda)

| Regla | Cómo se ha aplicado |
|---|---|
| Modelos completos en el 3.er ejercicio y \vertema al 4.º | Los modelos que se desarrollan en otro tema del 3.er ejercicio (3.A.13, 3.B.26) se resumen con lo necesario para cantarse solos; remisiones a 4.A.15, 4.A.18, 4.A.19 y 4.A.20 |
| Refranes restrictivos | Solo el del enganche («Cada palo que aguante su vela»), retomado en las implicaciones de Diamond-Dybvig y en la idea final; el original no tenía refranes |
| Nobel con nota | 7 notas con el motivo oficial |
| Morado solo para lo clave; pasos con sangría; cajas grises | 5 funciones clave; dación en pago, notación y lecturas en cajas grises |
| Sin citas Harvard, sin citar a Víctor | Todo `\nocite`/`\textcite` de obras originales; el test con la caja estándar y `tema=3.B.27` |

## 7. Dudas abiertas

- **B27-01** (13/11/2026). Título del apartado I: el Word decía «Fundamentos de la teoría económica». Opciones: (a) «Fundamentos teóricos de la regulación financiera», como el título oficial; (b) el del Word. **Aplicada: (a)**.
- **B27-02** (13/11/2026). Título del apartado II: el Word decía «Aplicación práctica: instrumentos de regulación financiera bancaria y no-bancaria». Opciones: (a) «Instrumentos de regulación bancaria y no bancaria» (cabe en la banda); (b) el del Word. **Aplicada: (a)**.
- **B27-03** (13/11/2026). Apartado nuevo II.3 «Regulación financiera no bancaria» (el título lo pide y el original no lo tenía). Opciones: (a) apartado propio de 2′; (b) repartirlo dentro de II.2. **Aplicada: (a)**.
- **B27-04** (13/11/2026). Reparto I 10′ / II 10′ / III 6′30″. Opciones: (a) así, porque el título pide fundamentos y evidencia; (b) II más largo (12′) a costa de III. **Aplicada: (a)**.
- **B27-05** (13/11/2026). Llorens et al. (2020), citados en el Word sobre fusiones y rentabilidad, no se han podido identificar. Opciones: (a) quitarlos y apoyar el argumento en Vives y en el enlace de Nada es Gratis; (b) mantener la cita sin comprobar. **Aplicada: (a)**.
- **B27-06** (13/11/2026). Martínez-Miera y Repullo con estructura de modelo (a, b, c) dentro de la evidencia (III.3). Opciones: (a) así, porque es un modelo; (b) solo viñetas. **Aplicada: (a)**.
- **B27-07** (13/11/2026). El enlace de VoxEU sobre bancos centrales y cambio climático no tiene sitio en el tema (el riesgo climático solo se nombra). Opciones: (a) dejarlo fuera y mencionar el riesgo climático en la conclusión; (b) añadir una caja gris sobre el riesgo climático en la regulación. **Aplicada: (a)**.
- **B27-08** (13/11/2026). La 1D01 da para España un CET1 del 14 % (Banco de España, entidades que operan en España) y este tema el 13,5 % (BCE, entidades significativas). Opciones: (a) dejar la del BCE, comparable con la media del MUS; (b) unificar con la 1D01. **Aplicada: (a)**.
- **B27-09** (13/11/2026). El porcentaje de activos bancarios de la zona del euro que cubre el MUS (82 % u 85 % según la página del BCE) no tiene fecha. **Aplicada**: no se da la cifra.
- **B27-10** (13/11/2026). Sugerencias de usuarios: no se ha podido ejecutar `scripts/sugerencias.py` (está en la carpeta principal y no se toca en este encargo). Pendiente de comprobar al aprobar el tema.

## 8. Instrucciones para el vídeo

- Enganche: «Cada palo que aguante su vela», con las ayudas públicas (6,7 % del PIB) frente a los convertibles de Credit Suisse; la pregunta se responde en la idea final.
- Gráficos a la pizarra: el panel derecho de Stiglitz-Weiss (por capas 4-7), Diamond-Dybvig (capas 1-6, el pánico como apoyo), los requisitos de capital construidos por capas de abajo arriba (CET1, AT1, T2, P2R, colchones) y la brecha crédito-PIB como apoyo. La concentración y la U de competencia, como apoyo.
- Funciones que se conservan en la esquina: 𝔼[B_banco] durante I.2.2; u'(c₁*) = R u'(c₂*) hasta II.2 (enlaza con el capital: «cada palo que aguante su vela»); la ratio de capital y LCR/NSFR durante II.2.
- Hilo: red de seguridad → riesgo moral → capital, liquidez, supervisión y resolución → no bancos («mismo riesgo, misma regulación»).
- Tablas `tab:marco` y `tab:no-bancaria` como apoyo, nunca escritas.
