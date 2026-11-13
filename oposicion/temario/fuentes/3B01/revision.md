# Revisión del 3.B.1 — La información financiera de las empresas: estados de situación y de circulación. Métodos de análisis económico y financiero

Revisión completa (entrega 1: tema y ficha de repaso; sin vídeo) hecha el 13/11/2026 en la rama `revision-temario-2`, a partir de las fases 1 y 2 hechas el 12/11/2026 en la otra rama (`_trabajo/pendientes.md`, `propuestas-contenido.md` C1-C47, `propuestas-datos.md` V1-V38, `propuestas-coherencia.md` K1-K32, `bib-datos.bib`, copiados a `_trabajo/`). Fuente nueva en LaTeX (`3B01.tex`), redactada de nuevo sobre el Word de Víctor (`_trabajo/original.md`), con los temas de Tebar y De Fuentes solo para contrastar. Las dudas se resuelven con la opción recomendada y se anotan como B01-NN. LyX está instalado: `construir-tema.py` generó `3B01.lyx`.

## 1. Resumen

- **Estructura del original intacta en sus 2 primeros niveles**: I (I.1-I.2), II (II.1-II.5) y III (III.1-III.3); los 3 títulos amarillos duplicados (3.4-3.6) se integran en III.1-III.3; el *método* de análisis, que pide el título y faltaba, va en la apertura de III sin numerar. Reparto: introducción 2′30″, I 4′, II 10′, III 12′30″, conclusión 1′ (30′).
- **Enganche nuevo**: «El papel lo aguanta todo» + Wirecard (2020); la idea final lo retoma («el papel lo aguanta todo; el análisis, no»). El aforismo del original («no se puede gestionar lo que no se puede medir») ya es el enganche del 3.A.30 y no tiene fuente.
- **Notación del canon (D062)**: ROA = EBIT/AT; `eq:roe-roa` idéntica a la del 3.B.2, con $(1-t_{IS})$; GAO sobre el EBIT; GAF = EBIT/EBT; EBITDA, EBIT, EBT, BN y EBIAT definidos una sola vez (cascada del resultado). Ejemplo conductor numérico (AT 1.000; PN 600; deuda 400 al 5 %; ventas 1.000; CV 600; CF 300) que cuadra FM, NOF, periodos medios, ratios, ROA, ROE, `eq:roe-roa`, DuPont, GAO, GAF y GAT.
- **Contenido añadido**: método (vertical, horizontal, ratios, comparación; medidas alternativas de rendimiento; NIIF 18), equilibrios patrimoniales, NOF con su relación correcta con el FM y en días, análisis con el EFE (calidad del beneficio, FCL), deuda neta bien definida, Z de Altman, DuPont de 3 y 5 factores (modelo a-d), indicadores de mercado, consolidadas, sostenibilidad (EINF, CSRD, ómnibus), reformas del PGC hasta la Ley 7/2024 y NIIF 18.
- **Gráficos**: 12 TikZ/pgfplots nuevos (4 gráficos y 8 figuras; ninguna imagen pegada), con capas para el vídeo. Datos al día (Central de Balances, 1.er semestre de 2026). Tema: **36 págs.** (anexos 7, bibliografía 5); ficha de repaso: **4 págs.** a 10,5 pt (última, 88 %). `verificar-tema.py`: sin errores propios (los que quedan son del PDF, HTML y Word publicados antiguos, que no se han reconstruido: «[ver…» sin enlace, «Título al pie de la página 26: 3.5. Análisis de la solvencia», «anterior a la fuente»).

## 2. Errores corregidos

| Dónde (original) | Decía | Dice ahora |
|---|---|---|
| Introducción y I.2 (l. 69, 180) | IASB «creado en 1973» | El IASC se creó en 1973; el IASB lo sustituyó en 2001 (V1) |
| Nota 10 | La reforma de 2007 la motivó «el rápido proceso de privatización de grandes empresas públicas» | La motiva la adopción de las NIIF en la UE (Reglamento 1606/2002); Ley 16/2007 y RD 1514/2007 (C8) |
| Valoración (l. 290) | Valor razonable con la definición de 2007 | Definición de la NIIF 13, incorporada por el RD 1/2021, con la jerarquía de 3 niveles (V6) |
| Valoración (coste amortizado) | «reducción de calor» | «reducción de valor» (errata) |
| Cuentas anuales (l. 322) y nota 14 | Las abreviadas «se ceñirán al PGC para pymes» y «no estarán obligadas a someterse a auditoría» | El PGC de pymes es optativo; la auditoría tiene umbrales propios, más bajos (2,85/5,7 M€/50; art. 263 LSC); el ECPN y el EFE no son obligatorios para quien puede formular balance abreviado (V8) |
| Balance, efectivo | Vencimiento «inferior» a 3 meses | «No superior» a 3 meses desde la adquisición (V13) |
| PyG (l. 446-456) | «Aprovisionamientos (pago de tributos)», «Pago de materias primas»; amortización «en virtud del principio de prudencia» | Aprovisionamientos = consumo de mercaderías y materias primas; tributos en otros gastos de explotación; la amortización responde al devengo (C15, nota 18) |
| Nota 17 | «El IVA sí que sería un coste de explotación» | El IVA no es ni gasto ni ingreso, salvo el no deducible (C15) |
| EFE (l. 544) | «Se divide en 2 partes» (explotación e inversión) | 3 bloques (explotación, inversión, financiación) + efecto del tipo de cambio (C17) |
| Nota 21 | Opinión «favorable, desfavorable o denegada» | 4 opiniones: también «con salvedades» (art. 5 Ley 22/2015; V10) |
| NOF (l. 684) | $\mathrm{NOF}=\mathrm{FM}+\mathrm{PC}_{\text{no op}}$, contradictorio con la viñeta siguiente | $\mathrm{NOF}\equiv\mathrm{AC_{op}}-\mathrm{PC_{op}}$ y $\mathrm{NOF}-\mathrm{FM}=\mathrm{PC_{fin}}-\mathrm{AC_{fin}}$ (C25, K9) |
| Nota 27 | NOF = días + días − días, con «Existencias/(Ventas × 365)» y «Cobros» | Periodos medios en días (PMA sobre el coste de las ventas, PMC con el saldo de clientes) y NOF en euros; derivación en el anexo B (C25) |
| Ratio de tesorería | Fórmula rotulada «ratio de tesorería inmediata» | Prueba ácida y ratio de tesorería, con un nombre por concepto (C26, K8) |
| Solvencia (l. 758) | Ratio < 1 ⇒ «la empresa entraría en concurso» | Quiebra técnica ≠ concurso (exige insolvencia; TRLC 2020); causa de disolución si PN < capital/2 (art. 363 LSC) (V14, K22) |
| Basilea III (l. 784) | «Colchón de riesgo sistémico (1 %/+2,5 %)» | Caja gris de mención, sin colchones (ficha `basilea-capital`) (V16, K21) |
| Deuda neta/EBITDA (l. 812-842) | Deuda bruta = todo el pasivo; EBITDA = ingresos − gastos de explotación; «Net interest expense»; «3 es nivel crítico» sin fuente | Deuda financiera con coste − efectivo; EBITDA = EBIT + amortizaciones y deterioros; cobertura EBIT/gastos financieros, «> 3 holgada» como orientación (Garrido e Íñiguez) (C30, K20) |
| Márgenes (l. 864) | Un mayor margen puede deberse a un «efecto volumen» | El volumen solo mejora el margen por la dilución de los costes fijos (C33) |
| ROA (l. 868) | ROA = EBIAT/Activos totales | ROA = EBIT/AT, margen × rotación (D062) |
| GAO (l. 916) | Sobre el EBIAT; «= Margen/EBIAT» | Sobre el EBIT; GAO = MC/EBIT, con $p$, $c$, CF del canon (C36, K17) |
| ROE-ROA (l. 980) | ROE = ROA + (ROA − costes financieros)·Pasivo total/PN | `eq:roe-roa` con $V_D/V_E$, $r_D$ y $(1-t_{IS})$ (C34, K14) |
| GAF (l. 994) | «beneficio bruto (… antes de impuestos, EBIAT)»; BºExplotación/BºBruto | GAF = EBIT/EBT; el EBIAT es el EBIT después de impuestos (C37) |
| Conclusión (l. 1048) | Información país por país: «el Consejo no aprobó» | Directiva (UE) 2021/2101, aprobada por mayoría cualificada; en España, Ley 28/2022 (V17) |
| Conclusión (l. 1050) | Información no financiera «desde 2019» | Desde los ejercicios de 2017 (RDL 18/2017, Ley 11/2018); desde 2021, > 250 trabajadores (comprobado en el BOE, disposición transitoria de la Ley 11/2018) (V18) |
| Anexo 3 | SL con 3.000 €; SLNE vigente; Ley 4/1997; cooperativas 30 % | SL desde 1 € (Ley 18/2022); SLNE derogada; Ley 44/2015; cooperativas 20 % + 5 % (V25-V28) |
| Notas 9 y 22 | «En Europa valor histórico, en EE. UU. valor razonable»; «captura del cliente» sin norma | Quitado lo primero; independencia del auditor con la Ley 22/2015 y el Reglamento 537/2014 |
| Erratas (C44) | «sr pagada», «mediate», «Tatio», «von los atributos», «delo coste», «pertenecen inalteradas», «re refieren», «la ROA/ROE»… | Corregidas al redactar de nuevo |

## 3. Marcas resueltas

| Marca | Qué se hizo |
|---|---|
| Notas al opositor de cambio de temario y comentarios (P6-P8, P85) | Fuera; no se publican |
| «Esto muy brevemente, más tiempo a las cuentas anuales» (P9) | Recogido en el reparto (I = 4′; II.3 = 6′) y en la `notaopositor` del esquema |
| «Añadir disclaimer… caso español con perspectiva jurídica» (P10) | Integrado en el texto (cierre de I.2 y apertura de II) |
| «Rigor y nombres de todas las cuentas» (P11) | Partidas con los nombres del modelo normal vigente |
| «Esto es importante» (principios, P12) | Principios EDUPNI y prevalencia de la imagen fiel; cambios del PGC de 2007 |
| «Desarrollar en pizarra todas las cuentas…» (P13), «A partir de esta cuenta se menciona de palabra» (P14), «No poner todas las ratios y no en la pizarra» (P17) | A «Instrucciones para el vídeo»; en el `.tex`, solo un consejo sin pizarra en la `notaopositor` |
| «(La memoria también es importante)» (P16) | Memoria desarrollada (contenido mínimo del modelo normal) |
| Comentarios sobre el orden de III (l. 30 y 603) | Orden liquidez → solvencia → rentabilidad (el del original y del manual): duda B01-02 |
| Comentarios sobre «análisis de la estructura patrimonial» y «análisis vertical y horizontal» (l. 26-28) | Equilibrios patrimoniales (figura) y método en la apertura de III |
| Títulos amarillos 3.4-3.6 con recortes (P1-P5) | Integrados: composición del corriente (tabla), ciclo de explotación (figura), equilibrios (figura), cascada del resultado (figura) |
| Estructura vacía, relevancia y opinión vacías (P48) | Redactadas |
| Bibliografía: comentarios, «Tema ICEX-CECO», «Tema Juan Luis Cordero Tarifa» (P18, P86) | Fuera (no se citan en el tema; nombres de preparadores fuera) |
| Enlace a quia.com y «Preguntas de otros exámenes» vacío (P87, P88) | Fuera; anexo F con la caja estándar del simulador (`tema=3.B.1`) |
| Imágenes 1-6, 10, 11, 12-25 (capturas) | Rehechas: tablas LaTeX (clasificación, PyG, grupos, composición del corriente, ratios ×4, formas jurídicas) y TikZ (partes del PGC, balance, cascada, GAO…); la imagen 5 (modelo del ECPN) y la 6 (modelo del EFE) se quitan del cuerpo: es el modelo oficial, se describe en el texto |
| Fuente «Sahuquillo (3B-1)» del gráfico del GAO (P31) | Gráfico rehecho como elaboración propia |

## 4. Datos actualizados

| Dato | Antes | Ahora | Fuente | Consulta | 2.ª comprobación |
|---|---|---|---|---|---|
| Rentabilidad ordinaria del activo (R.1), CBT | Riesgos de liquidez de 2021 (COVID) | 5,7 % en el 1.er sem. de 2026 (4,7 % un año antes); 4,1 → 4,2 % sin energía; sectores en `datos/roa-sectores-cbt.csv` | BdE, nota del 24/09/2026 | 12/11/2026 | Infobae (cuadra) |
| Umbrales de abreviadas y auditoría | 4/8/50 y 11,4/22,8/250; auditoría ligada al balance abreviado | Iguales; auditoría 2,85/5,7/50 (art. 263 LSC, leído en el BOE el 13/11/2026); Directiva Delegada 2023/2775 sin transponer, proyecto caducado | BOE; Congreso | 12-13/11/2026 | PGC, tercera parte |
| Estado de información no financiera | «Desde 2019», grandes empresas | Desde 2017; desde 2021, > 250 trabajadores y EIP o > 20 M€ de activo o > 40 M€ de cifra de negocios | BOE (LSC art. 262.5 y DT de la Ley 11/2018) | 13/11/2026 | CNMV-ICAC |
| CSRD | — | Aplazada (Directiva 2025/794) y recortada (Directiva 2026/470: > 1.000 trabajadores y > 450 M€ desde 2027); España sin transponer (proyecto caducado con el RD 806/2026) | DOUE; Congreso; CNMV-ICAC | 12/11/2026 | Garrigues, Cuatrecasas |
| NIIF 18 | — | Publicada en abril de 2024; Reglamento (UE) 2026/338; desde el 1/1/2027 | IASB; DOUE | 12/11/2026 | independientes |
| Reformas del PGC | Solo 2007 | RD 1159/2010, RD 602/2016, RD 1/2021, Ley 7/2024 (DT 8.ª) | BOE consolidado | 12/11/2026 | API del BOE |
| País por país | No aprobado | Directiva 2021/2101; Ley 28/2022; > 750 M€; desde el 22/6/2024 | DOUE; BOE | 12/11/2026 | PwC |
| Wirecard (enganche) | — | Junio de 2020; 1.900 M€ no confirmados; concurso el 25/6/2020 | OCCRP (25/6/2020) | 13/11/2026 | ANSA-AFP, Reuters (según la búsqueda) |
| NIIF en jurisdicciones | — | Más de 140 | Fundación IFRS | 12/11/2026 | — (una sola fuente) |

Todos los datos que caducan están en `datos-actualizables.yaml` (8 entradas).

## 5. Contenido añadido

- **Apertura de III, el método** (C23, K3): fases, ajustes previos (Penman, 2013), técnicas (vertical, horizontal, ratios, comparación; tabla), límites, medidas alternativas de rendimiento (ESMA 2015) y NIIF 18; ejemplo conductor (tabla).
- **III.1**: composición del corriente (tabla), NOF con la relación correcta y en días, ciclo de explotación (figura), análisis con el EFE (calidad del beneficio, Sloan 1996; FCL del 3.B.4) (C24-C27, K7).
- **III.2**: equilibrios patrimoniales (figura), quiebra técnica frente a concurso y disolución, endeudamiento con $V_D/V_E$, caja de Basilea (mención), NIIF 16 en la deuda neta, Z de Altman en caja gris (C28-C31).
- **III.3**: cascada del resultado (figura, también en II.3), márgenes, ROA como `\funcionclave`, gráfico de la CBT por sectores; **riesgo económico** (punto muerto y GAO) y **apalancamiento financiero** (ROE-ROA) con la estructura rígida a)-e); gráfico ROE frente a ROA; GAF y GAT; proposición II de Modigliani-Miller; indicadores de mercado; **DuPont** de 3 y 5 factores como subapartado III.3.3 con estructura de modelo (C32-C38, K13-K18).
- **II**: distinción situación/circulación en la apertura (tabla), 5 partes del PGC (figura), fondos y flujos (figura), cascada en la PyG, consolidadas, sostenibilidad (C10-C21).
- **I**: Akerlof, soluciones privadas (Healy y Palepu, 2001), falacia del nirvana, armonización imperfecta (Ball, 2006; Leuz y Wysocki, 2016); cronología del PGC (figura); caja de reformas (C7-C9).
- **Anexos**: A, ratios (4 tablas rehechas de Garrido e Íñiguez, con los nombres del cuerpo); B, derivaciones (ROE-ROA, DuPont, NOF en días, GAO y margen de seguridad); C, los 10 criterios de valoración; D, ciclo contable; E, formas jurídicas (actualizado); F, test.

Propuestas no aplicadas o aplicadas de otra forma:
- C1 (III.1 numerado «El método» y III con 4 subapartados): no; se sigue K3 (método en la apertura sin numerar) para conservar los títulos de 2.º nivel del original (CRITERIOS §2). Duda B01-01.
- C3 (enganche Grifols con «No es oro todo lo que reluce»): no; ese refrán ya es dicho del 3.A.14. Se aplica K26 (Wirecard). Duda B01-03.
- C9 (gráfico `cronologia-pgc`): sí, como figura (infografía).
- C16-C17 (modelos completos del ECPN y del EFE): no se reproducen (son los oficiales).
- C35 (fecha «hacia 1914, Donaldson Brown»): no se da sin fuente; «a principios del siglo XX».
- C46 «RAI»: se usa EBT (K12, D4).
- C20 (información trimestral de cotizadas): no se pone (sin comprobar); solo el informe semestral.
- V12: el número de la circular contable de la CNMV para IIC no se da (sin comprobar).
- K10, K14, K21, K26 (pegatinas «Hoy no se fía; mañana, sí», «al buen pagador…», «arma de doble filo», «los números cantan», «cada cosa en su sitio»): **no** (regla de la 9.ª tanda: solo el refrán inicial).

## 6. Coherencia

- **Canon D062** aplicado (ROA = EBIT/AT; `eq:roe-roa` igual que el 3.B.2). Quedan resueltas las contradicciones que anotaban `3B02/revision.md` y `3B03/revision.md` (EBIAT en el ROA, ROE-ROA sin $(1-t_{IS})$).
- **Promesas de otros temas** cumplidas (K30): 3.B.2 (ROA margen × rotación, apalancamiento y riesgo, ejercicio anual), 3.B.4 (FCL con la misma fórmula, deuda neta, EBIAT, DuPont de 3 factores), 3.B.23 (NIIF; EBIT = resultado de explotación), 1D01 (ROA bancario distinto), 3.A.1 (abre las decisiones de la empresa).
- **Remisiones** (todas con `\vertema`, al margen de la frase): 3.A.12, 3.A.13, 3.A.23, 3.A.30 (fondos y flujos, devengo), 3.A.42 (Minsky), 3.B.2, 3.B.3, 3.B.4, 3.B.11 (corregida: balanza de pagos), 3.B.23, 3.B.26 (Altman), 3.B.27 (Basilea), 3.B.31 (sostenibilidad); 4.º ejercicio: 4.A.8, 4.A.19, 4.B.17, 4.B.18.
- **Contradicciones con otros temas** (no se tocan; para `canon/pendientes-coherencia.md`, ver `_trabajo/canon-pendiente.md`): 1D01 l. 1539 llama «rentabilidad del activo» al EBITDA sobre activos; 3.B.4 l. 765 escribe `\autor{DuPont}` y 3.B.2 l. 655 y 694 `\emph{DuPont}` (DuPont es una empresa: en redonda); el 3.B.27 (sin revisar) remite al 3.B.1 unas cualidades («transparencia») que no son las del PGC.
- **Canon** (lo aplica la fase `tema-canon`, no hecha en esta entrega: no se tocan ficheros comunes): ficha nueva `ratios-financieros` con el 3.B.1 como tema de referencia (texto en `propuestas-coherencia.md` C1, con EBT y los gráficos `balance-masas`, `cascada-resultados`, `dupont`, `gao-ventas`, `apalancamiento-financiero`), `mapa.yaml` (C2, C4) y `notacion.md` § 11 (EBT, AC, ANC, PC, PNC, PN, FM, NOF, $q^{\mathrm{PM}}$, MC, GAO, GAF, GAT, deuda neta). Anotado en `_trabajo/canon-pendiente.md`.

## 7. Dudas abiertas

Todas del 13/11/2026, aplicadas con la opción recomendada.

- **B01-01** Dónde va el método de análisis (falta en el original y lo pide el título). (a) **En la apertura de III, sin numerar (1′), conservando III.1-III.3 del original** — *Aplicada: (a)*; (b) un III.1 nuevo «El método» y liquidez, solvencia y rentabilidad pasan a III.2-III.4.
- **B01-02** Orden de III. (a) **El del original: liquidez, solvencia, rentabilidad (por plazos; Garrido e Íñiguez)** — *Aplicada: (a)*; (b) rentabilidad, solvencia, liquidez (de la causa a las consecuencias, como propone un comentario del Word).
- **B01-03** Enganche. (a) **«El papel lo aguanta todo» + Wirecard (2020)** — *Aplicada: (a)*; (b) «No es oro todo lo que reluce» + Grifols (2024), más cercano, pero el refrán ya es dicho del 3.A.14.
- **B01-04** Nombres de las ratios de liquidez. (a) **«Prueba ácida» (antes «ratio de tesorería inmediata», que se dice entre paréntesis) y «ratio de tesorería»** — *Aplicada: (a)*; (b) «ratio de disponibilidad» para la de tesorería.
- **B01-05** Sigla del resultado antes de impuestos. (a) **EBT** (de la familia de EBITDA y EBIT) — *Aplicada: (a)*; (b) BAI o RAI.
- **B01-06** Ejemplo conductor numérico. (a) **Sí, una sola empresa que cuadra todas las ratios (sin proveedores, para que `eq:roe-roa` sea exacta)** — *Aplicada: (a)*; (b) solo fórmulas.
- **B01-07** Anexo de formas jurídicas. (a) **Se mantiene, actualizado y sin cantar (anexo E)** — *Aplicada: (a)*; (b) se quita (es derecho mercantil, fuera del título).
- **B01-08** Materia en `seo.json`. (a) **«Contabilidad y análisis financiero»** — *Aplicada: (a)*; (b) «Economía financiera» (la de los demás temas del bloque).
- **B01-09** Extensión: 36 págs. de tema. (a) **Se mantiene: lo no cantable va en cajas grises, notas y anexos** — *Aplicada: (a)*; (b) pasar a anexo la sostenibilidad y las reformas del PGC.
- **B01-10** Datos con una sola fuente o sin segunda comprobación propia: «más de 140 jurisdicciones» (IFRS), sectores «información y comunicaciones» y «resto» de la CBT, el caducado de los proyectos de ley (RD 806/2026, según la fase de datos). Comprobar antes de publicar; la nota de la CBT del tercer trimestre sale a finales de noviembre de 2026.
- **B01-11** «Gonzalo, Pérez y Serrano (2000)», fuente de la tabla 1 según Garrido e Íñiguez: no encontrada; se cita en el pie como texto, sin entrada en la bibliografía.

## 8. Instrucciones para el vídeo

- **Enganche e idea final**: «El papel lo aguanta todo», Wirecard (2020); pregunta: ¿qué información elaboran las empresas y cómo se analiza? La idea final: «el papel lo aguanta todo; el análisis, no». Introducción y conclusión sin pizarra (`modo: guion`). Ningún otro refrán.
- **I**: casi de palabra; en una línea, «asimetría → fallo de mercado → regulación ↔ fallos del sector público». `cronologia-pgc` como apoyo.
- **II**: apertura con «situación (stock) | circulación (flujos)» en 2 columnas, que se quedan; `partes-pgc` como apoyo (solo las 5 cajas a mano si sobra tiempo). II.1: «RFICC» y «EDUPNI» en columna. II.2: `fondos-flujos` de 3 trazos (depósito, grifo, desagüe). II.3: **`balance-masas-paso1` imprescindible**, construido de arriba abajo, activo por liquidez y PN y pasivo por exigibilidad (nota del original: «que se vea que es una progresión»); se queda para III.1. **`cascada-resultados` imprescindible**, escalón a escalón (capas 1-5), que se queda para III.3. ECPN, EFE y memoria, de palabra («se menciona de palabra, pero la estructura»: 2 partes del ECPN, 3 bloques del EFE). II.4-II.5, de palabra.
- **III**: el ejemplo conductor (tabla `tab:ejemplo`) como apoyo fijo en una esquina, sin obligar a memorizar cifras. No se escriben todas las ratios (nota del original): una o dos por dimensión. III.1: sobre el balance ya dibujado se añade la capa 4 (`balance-masas`: el FM en rojo) y, debajo, $\mathrm{NOF}-\mathrm{FM}=\mathrm{PC_{fin}}-\mathrm{AC_{fin}}$ en una línea; `ciclo-explotacion` como apoyo. III.2: `equilibrios-patrimoniales` por capas (un panel por capa) o, más rápido, tachando y redibujando la caja del PN sobre el balance; la caja de Basilea y la Z de Altman, de palabra. III.3: sobre la cascada, las 3 flechas «a quién retribuye»; **`eq:roa` y `eq:roe-roa` como funciones clave** (se conservan hasta el final, `conservar:`); `gao-ventas` (capas: ejes y GAO = 1; asíntotas; A; B; ventas de 1.000) y **`apalancamiento-financiero`** (capas: sin deuda; deuda del ejemplo y su punto; más deuda; el corte en ROA = $r_D$) en la pizarra; **`dupont` imprescindible** (ROE, los 4 factores, el ROA desglosado, los rótulos económico/financiero), que cierra el bloque como gráfico conjunto: la pizarra queda con el árbol y las 3 funciones clave.
- **Pausas**: antes de la condición $\mathrm{ROA}>r_D$ y antes de la idea final. Nunca se dice el número de un tema en voz alta.

## Revisión transversal (13/11/2026)

- **Premios Nobel** (nota con el motivo oficial en la primera mención): Akerlof (2001, con Spence y Stiglitz), Friedman (1976), Modigliani (1985) y Miller (1990, con Markowitz y Sharpe). No sale ningún otro premiado.
- **4.º ejercicio**: 4.A.8 (Central de Balances, empresa española), 4.A.19 (ROA bancario), 4.B.17 (el resultado contable, punto de partida de la base imponible del impuesto sobre sociedades) y 4.B.18 (pilar 2 e información país por país).
- **Refranes**: solo el del enganche, «El papel lo aguanta todo», retomado en la idea final. No se han puesto las pegatinas que proponían las fases 2 (K10, K14, K21, K26) ni se conserva el aforismo del original (es el enganche del 3.A.30 y no tiene fuente). La ficha de repaso tampoco lleva otros.
