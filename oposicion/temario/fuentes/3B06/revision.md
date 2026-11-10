# Revisión del 3.B.6 — Nueva teoría del comercio internacional: competencia imperfecta, rendimientos crecientes y heterogeneidad empresarial

Revisión autónoma (Víctor fuera del 31/10 al 9/11/2026). Fuente nueva en LaTeX (`3B06.tex`), escrita en 2 partes el 5/11/2026. La **parte 1** comprende la introducción y los apartados I y II; la **parte 2**, el apartado III, la conclusión y los 5 anexos. Las dudas de estructura (D1-D5) se resuelven con la opción recomendada por coherencia y se anotan abajo. Base: el Word de Víctor (21.608 palabras, PDF publicado del 10/08/2024, 45 págs.). Del original se siguió, al pie de la letra, el comentario «Quitar mi primer apartado de antecedentes y seguir el esquema propuesto tal cual».

## 1. Resumen

- **Estructura nueva**, la de la propuesta oficial «tal cual» (K1, D1):
  - I, competencia monopolística: Krugman (1979); Krugman (1980) con costes iceberg y efecto del mercado doméstico; Melitz (2003);
  - II, competencia oligopolista: dumping recíproco; competencia en precios y diferenciación;
  - III, otros desarrollos: economías externas y dinámicas con la nueva geografía económica; gravedad.
- **Antecedentes y derivaciones, a los anexos.** Los antecedentes (Kravis, Posner, Vernon, Linder y Falvey) quedan en una frase de la introducción y se desarrollan en el anexo A. Las derivaciones que no se cantan van a los anexos B (Krugman), C (Melitz), D (centro-periferia) y E (ejemplo numérico del dumping); un anexo final remite al simulador de test.
- **Minutos**: introducción 2′30″ · I 12′30″ (6′ + 2′ + 4′30″) · II 5′30″ (4′ + 1′30″) · III 8′ (7′ + 1′) · conclusión 1′30″ = 30′.
- **Reescrito o redactado de nuevo**:
  - Melitz se rehízo entero, con costes separados por mercado, el beneficio correcto, umbrales φ*_aut < φ* < φ*_x e implicaciones propias.
  - El oligopolio, vacío en el original, se ha redactado completo: dumping recíproco con funciones de reacción, condición de comercio y bienestar; Bertrand, Eaton-Kierzkowski y Shaked-Sutton.
  - Las economías externas suben del anexo al cuerpo y se añaden las dinámicas.
  - El centro-periferia queda como tema de referencia: 4 ecuaciones, 3 fuerzas en tabla, *tomahawk*, histéresis y «no agujero negro», con evidencia de Redding-Sturm y Davis-Weinstein y críticas de Neary. La gravedad queda en una viñeta, con su desarrollo en el 3.B.10.
- **Enganche nuevo**: «No vendas miel al colmenero», con los medicamentos que España vende a Alemania y le compra (2025). La idea final lo retoma. Todos los datos están al día a 2025 con fuente.
- **Ficheros**: `3B06.bib` (89 entradas), `graficos-pedidos.json` (11 gráficos de teoría; `tomahawk` es el gráfico de referencia que reutiliza el 3.B.10) y `seo.json`. Compila sin referencias ni citas indefinidas: 28 págs. de tema, 10 de anexos y 4 de bibliografía. Los gráficos los hacen los agentes tema-tikz y la construcción, el coordinador.

## 2. Errores corregidos

| Dónde (original) | Decía | Dice ahora |
|---|---|---|
| Krugman, supuestos (l. 436) | σ > 1 «está implícito en las curvas de indiferencia convexas» | La convexidad solo exige σ > 0; σ > 1 hace falta para que la demanda de cada variedad sea elástica (K12.1) |
| Nota 14 | «a mayor σ mayor será la preferencia por la variedad» | Al revés: la preferencia por la variedad es mayor cuanto **menor** es σ ($U=n^{1/(\sigma-1)}X$) |
| Krugman, demanda (l. 480-492) | Demanda con $W(1-\alpha)$ y un índice $p_y$ que suponen un bien homogéneo que el modelo no tiene; σ aumenta la demanda de cada variedad (amarillo) | Renta $w$ y todo el gasto en las variedades, índice $P$; σ hace la demanda más elástica, pero no la desplaza en un sentido fijo (sube la de las variedades con $p_i<P$) |
| Krugman, equilibrio (l. 522-640) | 5 condiciones enumeradas 2 veces | Una vez, en orden (precio, entrada, trabajo, apertura, bienestar) |
| Nota 18 | $w/p^*=c/\mu$ | $w/p^*=(\sigma-1)/(\sigma c)$; la nota se quita y el resultado va al texto |
| Krugman (1979) (l. 660-668) | «σ no va a ser una constante»; $x$ y $x_j$ mezclados | En 1979 no hay CES: la elasticidad de la demanda $|\varepsilon_{x,p}(x)|$ decrece con el consumo por persona; $x$ consumo, $q=Lx$ producción |
| Krugman, «efecto selección» (l. 717-841) | Llamaba «selección» a que haya menos empresas iguales | «Racionalización» en Krugman; «selección» y «reasignación» solo en Melitz (K13) |
| Relación real de intercambio (l. 745-749) | «Más variedades → más poder de mercado → RRI más alta» | Con CES el margen no depende de $n$: con países idénticos la RRI es 1; con costes de transporte, el país grande paga salarios más altos (Krugman, 1980) (K14) |
| Nota 7 | «X representa las importaciones y M representa las importaciones» | X exportaciones; un solo índice (Grubel-Lloyd, con sus 2 formas) |
| Evidencia (l. 785) | «La cifra del 25 % antes mencionada» (no mencionada) | 27 % (5 dígitos) y 44 % (3 dígitos) en 2006 (Brülhart, 2009) |
| Head y Ries (l. 847) | 10 % y 8,5 % en «las plantas estadounidenses» | Plantas **canadienses**: +10 % por los aranceles de EE. UU., compensado en una cuantía parecida por los canadienses (sin el 8,5 %) |
| Nota 5 | Falvey en competencia monopolística; Brander bajo «heterogeneidad»; «Kierzowski» | Tabla 1 corregida: Falvey en competencia perfecta-vertical, Brander en oligopolio-homogéneo, Kierzkowski |
| Melitz, costes (l. 935) | $CT=w(F^d+F^x+c_jq+\tau q_x)$ | $C^d=w(F^d+q/\varphi)$ y $C^x=w(F^x+\tau q_x/\varphi)$ |
| Melitz, beneficio (l. 966) | $\pi^*=\{[(\sigma-1)p\phi]/w\}^{\sigma-1}/\sigma^\sigma\cdot q-wF^d$ | $B^d(\varphi)=\frac{wL}{\sigma}\big(\frac{\rho\varphi P}{w}\big)^{\sigma-1}-wF^d$ |
| Melitz, apertura (l. 1000-1050) | Umbrales $\phi_A$, $\phi_B$, $\phi_C$ sin definir; mecanismo por «la reducción de precios a nivel mundial» | φ*_aut, φ*, φ*_x con la condición que los define y $\varphi^*_x=\tau(F^x/F^d)^{1/(\sigma-1)}\varphi^*$; el canal es el mercado de trabajo (Melitz, 2003, p. 1716) |
| Melitz, implicaciones (l. 1054-1074) | Copiadas de Krugman («el número de variedades… necesariamente menor») | Propias: reasignación y productividad media; el número de variedades puede subir o bajar |
| Centro-periferia, notación (l. 1196-1452) | γ peso de las manufacturas, μ margen, ζ libertad comercial, puntos $\zeta_B$, $\zeta_S$ | μ peso, margen sin letra, $\phi_\tau=\tau^{1-\sigma}$, $\phi_\tau^{\mathrm r}$ y $\phi_\tau^{\mathrm s}$ (D019, D083) |
| Centro-periferia (l. 1202, 1254, 1296, 1310) | «inmóvil entre países»; mercado de trabajo con $\bar L$; «el precio de *A*»; «por el número total de obreros» | Entre regiones; $n_i=\lambda_i\mu/(\sigma F)$; el precio de $X$; por el número de empresas |
| *Tomahawk* (l. 1440) | Discontinuas = «inestables a corto plazo» | Inestables a largo plazo; se añade la histéresis con $\phi_\tau^{\mathrm s}<\phi_\tau^{\mathrm r}$ |
| Baldwin y Forslid (l. 1458) | 2004, como «evidencia empírica» | *Economica*, **2000**; es una extensión teórica, no evidencia |
| Gravedad (l. 378) | «Estados Unidos y Canadá en 1988, de la mano del NAFTA» | El acuerdo Canadá-EE. UU. (en vigor en 1989) no es el TLCAN (1994); el efecto frontera, al 3.B.10 |
| Conclusión (l. 1496) | Ejemplo del NAFTA «en los tres países» | Los estudios citados (Trefler, Head-Ries) son del acuerdo Canadá-EE. UU. de 1989 |
| Nota 3 | Hume, *Discursos políticos*, «1952» | 1752 |
| Introducción | Hamilton (1790) | 1791 (*Report on Manufactures*) |
| Anexo 1 | Marshall (1920) | 1890 (la 8.ª edición es de 1920) |
| Erratas | «RENDIMENTOS», «testo del mundo», «Rühr», «vienes diferenciados», «escrite», «Appleyard & Feldman» | Corregidas o desaparecidas con el texto rehecho |

## 3. Marcas resueltas

| Marca | Qué era | Qué se hizo |
|---|---|---|
| P1, P2 | Linder: título en amarillo y oculto, sin texto | Redactado en el anexo A (demanda representativa, demandas solapadas, evidencia de Hallak, 2010) con gráfico `linder` |
| P3 | σ y la demanda (amarillo) | Corregido (sección 2) |
| P4 | Tercer índice de comercio intraindustrial (amarillo) | Es idéntico al de Grubel-Lloyd: se funde en uno con sus 2 formas; Balassa en nota |
| P5 | «Como sabemos… no existe un modelo único de oligopolio» (amarillo) | Redactado de nuevo con `\vertema{3.A.19}` y el supuesto que levanta el oligopolio |
| P6, P13 | Brander (1981): una frase en amarillo y 3 capturas de apuntes | II.1 completo: a)-d), `eq:reaccion-dumping`, gráfico `dumping-reciproco`; las capturas no se publican |
| P7 | «Competencia en precios (Eaton y Grossman)», vacío | II.2 «Competencia en precios y diferenciación»: Bertrand homogéneo (no hay comercio; Kreps-Scheinkman), Eaton-Kierzkowski y Shaked-Sutton; Eaton-Grossman en una línea al 3.B.8 |
| P8 | Recapitulación de la conclusión (amarillo) | Rehecha con los 3 apartados y el CUSFTA |
| P9, P10, P11 | Aviso del cambio de temario, captura de la propuesta oficial y comentario de estructura | Quitados; la estructura sigue la propuesta oficial (D1) |
| P12 | «No perder mucho tiempo» en los antecedentes | Una frase en la introducción; anexo A |
| P14, P15 | Ligar Linder y Falvey; Falvey es posterior a Krugman | En la valoración de Linder y en la idea de Falvey (anexo A) |
| P16 | Shaked y Sutton en 7 cajas de notas | Resumido en II.2 con `\vertema{3.A.18}` |
| P17 | «¿Qué permite el modelo de elasticidad decreciente que no permita el CES?» | Respondido en el texto: precios más bajos, empresas más grandes y menos empresas por país (3 fuentes de ganancia) |
| P18 | Remisión a un tema de academia para Melitz | No se publica; se usan Melitz (2003) y Melitz y Redding (2014) |
| P19, P22 | Coordinar con el 3.B.8 | Modelo base aquí, arancel en el 3.B.8 (D5) |
| P20 | Gandolfo, cap. 16 | Citado como fuente de la tabla de las 3 fuerzas y del gráfico de la dinámica |
| P21 | Coordinar el centro-periferia con 3.B.9, 3.B.10 y 3.B.16 | 3.B.6 es el tema de referencia; notación común con el 3.B.10 |
| P23-P33 | Figuras del original (Posner, Vernon, Falvey, tangencia, PP-ZZ, Melitz, *tomahawk*, dinámica, notas 23 y 30, economías externas) | Todas pedidas en TikZ (`graficos-pedidos.json`), con capas en el orden de la pizarra; las imágenes de las notas se integran en los gráficos del texto |
| P34 | Tabla de mecanismos sin título | `tab:mecanismos` |
| P35 | Tabla de las 4 preguntas sin fuente | `tab:tradicional-nueva` como elaboración propia (duda abierta) |
| P36 | Captura de la tabla 7.1 de Gandolfo | `tab:clasificacion` en LaTeX, en español y con color |
| P37 | Capturas de Appleyard y Field (Linder) | No se publican; gráfico `linder` |
| P38-P42 | Epígrafes del título | Cubiertos (sección 5) |
| P43-P46 | Remisiones | Todas con `\vertema`; 3.A.8 → 3.A.18 para σ > 1; las de páginas de Gandolfo, como `\parencite` con páginas |
| P47-P57 | Errores detectados | Sección 2 |
| P58 | Datos | Sección 4 |
| P59 | Valoraciones de opinión (gravedad, NGE) | Quitadas; valoración de la NGE con Neary (2001) y Krugman (1998) |
| P60 | Relevancia y opinión vacías | Rellenas (Trefler, 2004; Arkolakis, Costinot y Rodríguez-Clare, 2012) |
| P61, P62 | Comentarios y bibliografía de trabajo (academia, diapositivas, tema de un preparador) | No se publican; bibliografía con las obras citadas |
| P63 | Preguntas de examen vacías y enlace a quia.com | La nota vacía se quita; anexo «Preguntas de test» con los asuntos que han caído (de `preguntas.json`) y el único enlace al simulador |
| P64 | Fotos y capturas ajenas | No se publican |

## 4. Datos actualizados

Consultas del 05/11/2026 (verificador de datos, salvo el enganche, que consultó el editor).

| Dato | Antes | Ahora | Fuente | 2.ª comprobación |
|---|---|---|---|---|
| Comercio mundial (V1) | 31 billones de dólares (2022) | 34,65 billones de bienes y servicios en 2025 (+7 %); mercancías, 26,26 billones | OMC, *Perspectivas*, marzo de 2026 (`OMC2026Perspectivas`) | UNCTAD, abril de 2026: «unos 35 billones». Cuadra. No se usa «de los que» porque 26,26 + 9,56 ≠ 34,65 (son 2 medidas distintas) |
| Enganche (nuevo) | Pregunta genérica | Medicamentos (CUCI 542) España → Alemania 2.117 M€ y Alemania → España 2.504 M€ en 2025; GL 0,92 (elaboración propia, en nota) | Eurostat Comext DS-059331, API (`Eurostat2026Comext`) | 2024: 2.161 y 2.114 M€ (mismo orden). Cuadra |
| Intraindustrial mundial (V5) | 25 % y «casi el 50 %» | 27 % y 44 % (2006) | Brülhart (2009) | Versión de trabajo GEP 2008/08. Cuadra |
| Intraindustrial en Europa (V2) | «la mayor parte» | Cerca de la mitad del comercio interno de Europa occidental y Norteamérica (5 dígitos, 2006) | Brülhart (2009) | Cálculo propio con Comext (Francia 48 %, Alemania 52 %). Cuadra |
| Apertura de los países de renta alta (V3) | Sin cifra | Del 31 % al 60 % del PIB, 1970-2024 | Banco Mundial, WDI | Sin segunda fuente para el agregado (duda abierta) |
| Comercio Norte-Norte (V4) | «el grueso» | El mayor bloque, un 36 % (2024) | UNCTAD, *Key statistics 2025* | Sin segunda fuente (duda abierta) |
| GL de España (V6) | — | 0,33 (5 dígitos) y 0,44 (3 dígitos); Francia 0,48, Alemania 0,52 (2025) | Elaboración propia con Comext, **solo en nota** | 2006 reproduce a Brülhart a 5 dígitos (0,325 frente a 0,338), no del todo a 3 |
| Exportadoras de EE. UU. (V24) | — | 4 % de 5,5 millones exportan; el 10 % mayor, el 96 %; +97 % de empleo, +108 % de ventas, +11 % de VAB por trabajador, +6 % de salario | Bernard, Jensen, Redding y Schott (2007) | Lo cualitativo, en el resumen del JEP |
| España, exportadoras (V25) | — | 127.084 exportadoras, 46.229 regulares; las 1.000 primeras, el 65,2 % (tabla 2 con 10, 100, 1.000, 5.000 en 2019 y 2025) | Ministerio de Economía, informe de diciembre de 2025, tablas 12-14 | Informe de agosto de 2026 y nota de La Moncloa. Cuadra |
| España, por tamaño (V26) | — | Las de 250 o más empleados son el 1,9 % y hacen el 57 % (2024) | Eurostat TEC | Sin segunda fuente oficial (duda abierta) |
| CUSFTA (V9) | 1989 | En vigor desde el 1/1/1989 (firma, 2/1/1988) | Global Affairs Canada | USTR. Cuadra |
| Head y Ries (V10) | 10 % y 8,5 % | 10 %, compensado «en una cuantía parecida» | Head y Ries (1999), resumen | 8,5 % sin comprobar (duda abierta) |
| Trefler (V11) | 15 % y 14 % | −12 % de empleo y +15 % de productividad de la industria; +14 % de productividad de las plantas | Trefler (2004), resumen | NBER w8293. Cuadra |
| Broda y Weinstein (V12) | ×3 y 2,6 % del PIB | Sin cambios | QJE (2006) | Crossref. Cuadra |
| Baldwin y Forslid (V14), Hume (V15), Hamilton (V18), Nobel 1969 y 2008 (V19), Marshall (V21) | 2004, 1952, 1790, —, 1920 | 2000, 1752, 1791, motivaciones literales traducidas, 1890 | Crossref, davidhume.org, Founders Online, nobelprize.org | Cuadran |

## 5. Contenido añadido

- **Introducción**: los 3 hechos que la teoría tradicional no explicaba, con datos; «nueva» y «novísima» teoría con una sola terminología (K7); equilibrio integrado de Helpman y Krugman (1985); mapa de modelos (`tab:clasificacion`), que es también la pizarra (K34); problemática y estructura (antes vacía); esquema, reparto del cante y notación.
- **I.1**: supuestos con la lista de las estructuras de mercado (CRITERIOS §6: se levanta el del producto homogéneo); bienestar en forma cerrada $w/P$; comercio $M_A=wL_AL_B/(L_A+L_B)$ como germen de la gravedad; respuesta a P17; valoración con límites.
- **I.2**: salarios más altos del país grande (test de 2016), enlace con Linder y con la NGE.
- **I.3**: hechos estilizados (Bernard *et al.*, 2007), extensiones (Helpman-Melitz-Yeaple, Bernard-Redding-Schott, Melitz-Ottaviano, Chaney, Eaton-Kortum y Bernard-Eaton-Jensen-Kortum, este por el test de 2025), evidencia del CUSFTA y de España, valoración con Arkolakis, Costinot y Rodríguez-Clare (2012).
- **II** completo (estaba vacío): dumping recíproco con condición de comercio $\tau c<p^M$ (test de 2023) y estática comparativa (test de 2014); competencia en precios y diferenciación.
- **III**: economías externas (Marshall, botones, historia, Graham, Ethier) y **dinámicas** (aprendizaje, Arrow, 1962; Krugman, 1987), que no estaban; NGE con primera y segunda naturaleza; centro-periferia completo con evidencia y valoración nuevas; gravedad microfundada (Anderson-van Wincoop, Chaney).
- **Conclusión** con sus 5 bloques y la tabla de la teoría tradicional frente a la nueva.
- **Anexos**:
  - A: Kravis, Posner corregido, Vernon, Linder (nuevo) y Falvey con la calidad frontera $\alpha_0$, que el original no daba;
  - B: derivaciones de Krugman y tangencia;
  - C: condiciones de corte cero y libre entrada de Melitz, productividad media y nota 30 traducida;
  - D: las 4 ecuaciones de FKV, la dinámica en 3 paneles y el «no agujero negro»;
  - E: el ejemplo numérico del dumping, comprobado: el comercio mejora el bienestar si τ < 21/11. Sigue el apéndice 15.A.5 del tema DCE de Manuel Cabado, citado en el tema por su fuente primaria, Feenstra.
- **Ideas tomadas de referencias de preparadores** (no citadas en el tema, que solo cita obras):
  - Tebar: el orden de los «3 hechos» y la implicación de promoción exterior en Melitz;
  - Cabado: el ejemplo numérico del dumping y la evidencia de España, con cifras de la fuente oficial, no de Cabado;
  - Cerezal: el efecto del comercio en Shaked-Sutton, redactado de nuevo y suavizado.
- **Propuestas de contenido (C)**:
  - Aplicadas con los ajustes de coherencia: C1-C6, C8-C16, C18-C24, C25-C28, C30-C36, C38-C41.
  - C2: se aplicó el dato, pero no el refrán «juntos, pero no revueltos»; manda el de coherencia (decisión 3).
  - C7: su reparto se rechaza; manda el de coherencia.
  - C17: Falvey va al anexo A (D4) y Shaked-Sutton a II.2.
  - C29: la cita textual de Krugman (1991) queda parafraseada, sin comillas (decisión 6).
  - C37: en lugar de una viñeta, la recapitulación del III va en una `ideaclave`.
  - C42 y C43: bibliografía con las obras citadas y sin nota de preguntas de examen.
  - Rechazados por no estar comprobados: la viñeta «más empresas» del dumping, el «8,5 %», los «unos 15 años» de Davis y Weinstein y la fórmula cerrada del punto de ruptura.
- **Propuestas de datos (V)**:
  - Aplicadas: V1-V6, V8-V15 y V18-V26.
  - V7: Greenaway y Milner (1986), con el año sin comprobar en línea.
  - V16: nota del neolítico acortada y sin fecha.
  - V17 (*Homo habilis*): quitada con la nota.
  - V22 y V23: sin comillas.
  - V27: no se usa; el texto no necesita el total exportado.
- **Propuestas de coherencia (K)**:
  - Aplicadas: K1-K35.
  - K20: la «Evidencia» del dumping se omite; no hay una cifra comprobada y las letras siguen seguidas.
  - K22: la elasticidad variable va como $|\varepsilon_{x,p}(x)|$ y no como σ(x).
  - K29: la tabla va sin atribuir a Krugman.
- **Pendientes (P)**: todos resueltos (sección 3).

## 6. Coherencia

- **Notación del canon**:
  - Margen σ/(σ−1) sin letra, en todo el tema (CC1: choca con la l. 144 de `pendientes-coherencia.md`, que decía «P, μ, σ»).
  - NGE: μ, λ, ω, $U=X^{1-\mu}V^{\mu}$, $\phi_\tau$, $\phi_\tau^{\mathrm r}$, $\phi_\tau^{\mathrm s}$.
  - Melitz: φ*_aut < φ* < φ*_x, B y $F^e$.
  - Dumping: $q_A^A$, $R_A(q_B^A)$, $B_B^A$, $p^A$ y τ iceberg (no el arancel *t*).
  - Falvey: $w$, $r$ (D011); gravedad: $\tau_{ij}$ y $u_{ij}$; población $L$, como la ficha `krugman-1979`.
  - Los cambios a las fichas (CC1-CC12) están en `_trabajo/canon-pendiente.md`; esta sesión no escribe en `canon/`.
- **Vocabulario coordinado con el 3.B.10**: «efecto procompetitivo», «efecto escala» y «racionalización» (Krugman); «selección» y «reasignación» (Melitz). El `tomahawk` del 3.B.6 es el de referencia (fichero `graficos/tomahawk.tex`); el 3.B.10 lo reutiliza en su anexo D.
- **Remisiones**: todas con `\vertema` o `\ref`. Se añaden las que faltaban a 3.A.11, 3.A.12, 3.A.16, 3.A.17, 3.A.18, 3.A.19, 3.A.44, 3.B.5, 3.B.8, 3.B.9, 3.B.10, 3.B.18, 3.B.40 y 4.A.24 (esta, solo para ampliar). Se cumplen las promesas del 3.A.12 y el 3.A.16 (economías externas explican el comercio entre países parecidos) y la del 3.A.19 (dumping recíproco en el 3.B.6).
- **Contradicciones con otros temas** (no se tocan esos temas):
  1. 3.B.5, 3.B.8 y 3.B.9 tienen el mismo enganche que el original del 3.B.6, con la nota del neolítico.
  2. La nota de clasificación del 3.B.5 (y del 3.B.9) pone a Falvey en competencia monopolística y escribe «Kierzowski».
  3. El 3.B.8 llama «Brander y Krugman (1983)» al tercer mercado de Brander-Spencer y atribuye aranceles a Brander (1981); usa $\varphi_A$ para la función de reacción.
  4. El 3.B.9 copia el centro-periferia con ζ y Baldwin-Forslid de 2004.
  5. El 3.B.10 (en paralelo) debe resumir el centro-periferia y remitir aquí.
  6. El 3.B.40 dice que el margen crece con σ y remite el centro-periferia a la vez al 3.B.6 y al 3.B.10.
  7. El 3.A.18 cita Shaked-Sutton 1982-1983; aquí se usa el capítulo de 1984: compatibles.
- **CRITERIOS §6, supuestos de las estructuras de mercado**: I.1 dice que la competencia monopolística levanta el del producto homogéneo y II que el oligopolio levanta el del mercado atomizado, con remisión, sin repetir la tabla.

## Comentarios de Víctor (10/11/2026, 3.ª tanda)

| Comentario | Cómo se ha aplicado |
|---|---|
| Comercio internacional: nada de SEC; sectores siempre con CUCI; datos de los MCP del ministerio | El tema no usaba la SEC (comprobado). Los sectores y la medida del comercio intraindustrial van con la CUCI (y el SA a 6 para el sesgo de agregación). Datos nuevos: microdatos de exportación por empresa de la AEAT (MCP `sql_empresas`, tabla `EMP.TH_EMPRESAS`, solo agregados) y Eurostat TEC (`ext_tec02`, por la API de Eurostat, porque `sql_eurostat` solo tiene Comext). CSV en `datos/` |
| Antecedentes en el cuerpo, como nexo al principio | Nuevo apartado **I.1. Antecedentes: comercio sin ventaja comparativa estática** con todo el antiguo anexo A (Kravis, Posner, Vernon, Linder y Falvey, con sus 4 gráficos) y un nexo explícito: los neotecnológicos y Linder explican comercio sin ventaja comparativa estática y Falvey, comercio intraindustrial en competencia perfecta. Tabla nueva `tab:antecedentes` con las 4 preguntas. El anexo A desaparece (los demás anexos se renumeran). Minutos: I pasa a 14′ (antecedentes 1′30″), II a 5′ (dumping 3′30″) y III a 7′ (NGE 4′, gravedad 1′30″) (duda B06-01) |
| Gravedad con más desarrollo, como en la versión antigua | III.2 rehecho con a)-d): idea (Tinbergen, físico), analogía de Newton, ecuación multiplicativa y en logaritmos (`eq:gravedad`), las 3 «masas» y costes, fundamento (Anderson, 1979; Krugman; gravedad estructural de Anderson-van Wincoop con la fórmula; Chaney), implicaciones con las 4 preguntas, evidencia (McCallum, efecto frontera y sus 4 explicaciones del original; nota del Brexit, la antigua nota 10) y valoración. Las frases de opinión del original («más justas y sostenibles», «más protagonismo en los programas») siguen fuera (P59) |
| Implicaciones con las 4 preguntas en todos los modelos | Por qué se comercia, qué produce cada país, a qué RRI y quién gana, en este orden, en Krugman (1979), Krugman (1980, implicaciones nuevas), Melitz, dumping recíproco, Bertrand, Eaton-Kierzkowski, Shaked-Sutton, economías externas, centro-periferia, gravedad y antecedentes (tabla). El 3.B.5 no se toca aquí (canon-pendiente) |
| Krugman (1979): PP y ZZ antes de la apertura; luego el desplazamiento de ZZ; caja gris con elasticidad constante | Gráfico nuevo `krugman-ppzz-autarquia` (PP, ZZ, E0) tras explicar las 2 curvas, con los 4 pasos en el texto; después `krugman-ppzz` con ZZ′ y E1, también explicado por pasos. Caja gris «¿Y si la elasticidad de sustitución fuese constante?» con gráfico `krugman-ppzz-ces`: comprobado, con CES PP es horizontal ($p/w=c\sigma/(\sigma-1)$); la apertura no cambia ni el precio ni el tamaño de empresa ($q=(\sigma-1)F/c$) ni $n$ por país; $x$ se reduce a la mitad y solo aumenta la variedad |
| Caja gris con la antigua nota 23 (efecto procompetitivo) | Caja «El efecto procompetitivo con 2 monopolistas» tras el gráfico de la apertura, con el texto de la nota redactado de nuevo y el dibujo del original en TikZ (`monopolio-procompetitivo`: D, IMg, CMg, $Q_0$, $p_M$ y las exportaciones hasta $Q_1$); enlaza con el dumping recíproco |
| Medida del comercio intraindustrial, sobre todo qué es una industria | Evidencia de Krugman ampliada: criterios de demanda y de oferta; niveles de la CUCI (sección, división, grupo, subgrupo, partida, con el ejemplo 5-54-542 del enganche), SA 6 y NC 8/TARIC 10; sesgo de agregación (Finger, 1975) con tabla nueva `tab:gl-agregacion` (España-Francia 0,63 / 0,48 / 0,46 con CUCI 3, CUCI 5 y SA 6; datos de Comext ya calculados el 5/11); agregación geográfica (bilateral frente a multilateral); desequilibrio (Aquino, 1978); horizontal y vertical por valores unitarios (±15 %; Greenaway, Hine y Milner, 1995); comercio intraindustrial marginal (Brülhart, 1994) |
| Melitz a): gráfico de autarquía, como la imagen 7 antigua | `melitz-autarquia`: $B^d_{\mathrm{aut}}$ desde $-wF^d$, umbral, beneficio 0 de las que salen (en rojo sobre el eje) y la línea $wF^e$ con quién recupera el coste hundido, como el original; 4 pasos en el texto |
| Melitz b): 5 grupos en el gráfico 2 | `melitz-umbrales` rehecho (parámetros nuevos para que el corte quepa): 1 no producen; 2 cierran; 3 solo interior y pierden ($B^d<B^d_{\mathrm{aut}}$); 4a exportan pero ganaban más en autarquía ($\varphi^*_x\le\varphi<\hat\varphi$); 4b exportan y ganan ($\varphi\ge\hat\varphi$, con $B^d(\hat\varphi)+B^x(\hat\varphi)=B^d_{\mathrm{aut}}(\hat\varphi)$). 5 pasos del gráfico en el texto |
| Melitz c): gráfico estilizado de beneficios en autarquía y con comercio | `melitz-ganancias`: las 2 envolventes (0 para las que no producen; $wF^e$ marcado como el coste hundido que pierden), con el área de pérdida (grupos 2, 3 y 4a) y la de ganancia (4b), explicado en 3 pasos |
| Tabla 2 con gráfico de cuota acumulada 2019 y 2025 e implicaciones en Melitz; comparación europea en caja gris | `concentracion-exportadoras-espana`: % acumulado del valor exportado frente al % de empresas de mayor a menor (eje X logarítmico, duda B06-02), 2019 y 2025, con microdatos de la AEAT (reproducen la tabla 2: 15,0/39,2/66,7/87,5 en 2019). Lectura: de unas 209.000 a 127.000 exportadoras; la curva de 2025 queda por debajo (1 %: 76,7 → 68,6 %; 10 %: 98,6 → 95,7 %) porque sale la cola de exportadoras pequeñas, que hacían el 0,2 % del valor; en Melitz, una subida de $\varphi^*_x$ (más $F^x$ o incertidumbre) que reduce el margen extensivo (duda B06-03). Caja gris con `concentracion-exportadoras-ue` (Eurostat TEC 2024, 12 países: 10, 100 y 1.000 primeras): España, de las menos concentradas (1.000 primeras, 67,5 %), como Alemania y Polonia; Italia 53,3 %, Irlanda 97,8 % |
| Gráficos de varios pasos explicados poco a poco | Krugman (autarquía y apertura), CES, nota 23, Melitz (3 gráficos) y la curva de concentración llevan sus pasos numerados en el texto, en el orden de las capas del `.tex` |

## Comentarios de Víctor (11/11/2026, 4.ª tanda)

| Comentario | Cómo se ha aplicado |
|---|---|
| Reglas generales del 11/11 (pizarra, títulos) | Quitadas o reescritas 2 indicaciones de pizarra o de caja («se borra», «recuadrada en la esquina», «(caja gris)»…) en el texto del tema, conservando tiempos y orden del cante; su contenido va a «Instrucciones para el vídeo». Títulos largos (PDF actual): II.1: corte tras «Competencia en cantidades:», con `\cortetitulo`. Sin `c_K` en el tema. |

## 7. Dudas abiertas

**Estructura (aplicada la opción recomendada por coherencia):**

- **D1**: estructura oficial «tal cual» (aplicada). La alternativa era Melitz como apartado II.
- **D2**: Krugman (1980) antes de Melitz, porque Melitz usa τ (aplicada). El orden literal de la propuesta oficial pone Melitz antes de las extensiones.
- **D3**: las economías dinámicas, en un párrafo con la curva de aprendizaje y Krugman (1987) (aplicada).
- **D4**: Falvey en el anexo A, con una línea en II.2 (aplicada). *Resuelta por Víctor (10/11/2026)*: Falvey y los demás antecedentes pasan al cuerpo, apartado I.1.
- **D5**: dumping recíproco base desarrollado aquí y la versión con arancel en el 3.B.8 (aplicada). Pide ajustar la ficha `brander-krugman` y `mapa.yaml` (CC2).

**Datos con una sola fuente oficial:**

- **V3**: apertura de los países de renta alta, del Banco Mundial.
- **V4**: el 36 % del comercio Norte-Norte, de la UNCTAD.
- **V26**: el reparto por tamaño de las exportadoras españolas, de Eurostat TEC.
- **V6**: el índice de Grubel-Lloyd de España es una elaboración propia con Comext, solo en nota y dicho así. A 3 dígitos no reproduce del todo el valor de Brülhart para 2006 (0,43 frente a 0,50).
- **Enganche**: dato nuevo de medicamentos (Comext, CUCI 542). Si Víctor prefiere otro producto, hay alternativas: piezas de automóvil con Portugal (GL 0,89) o con Francia (0,82).

**Citas sin comprobar:**

- La de **trigo y aviones** va sin comillas y sin atribución, como una fila de la tabla 4.
- La **tabla de las 4 preguntas** es elaboración propia; quizá esté en Krugman (1990, *Rethinking International Trade*).
- La definición de geografía económica de **Krugman (1991)** va parafraseada, citando el libro.
- El **8,5 % de Head y Ries** se quita.
- También sin comprobar:
  - Krugman (1998), que «ha tenido más éxito planteando preguntas que respondiéndolas»: sin comillas, tomado de una referencia;
  - el resultado de Shaked y Sutton (1984) al integrarse 2 países, suavizado;
  - el contenido de Eaton y Kierzkowski (1984), descrito en una frase general;
  - las ecuaciones de FKV (cap. 5) en la forma con $\phi_\tau$ (se cotejaron con la estructura de Baldwin, 1999, no con el libro);
  - el año de Greenaway y Milner (1986);
  - la página de Krugman, Obstfeld y Melitz (cap. 7) para el gráfico de las economías externas.

**Bibliografía:**

- Páginas finales puestas a mano (Crossref solo da la inicial): Eaton y Grossman (383-406), Graham (199-227), Ethier en Econometrica (1243-1268), Isard (305-320) y Venables (341-359).
- Sin comprobar en línea: McCallum (1995) y Balassa (1966).

**Decisiones del editor (parte 1):**

1. Notación: margen sin letra; $L$ para la población; $B$ para el beneficio; umbrales de Melitz de coherencia; dumping con $q_A^A$ y τ; $|\varepsilon_{x,p}(x)|$ en Krugman (1979).
2. Vocabulario: escala y racionalización en Krugman, selección y reasignación en Melitz; Trefler y Head-Ries pasan a la evidencia de Melitz.
3. Bloques de los modelos:
   - I.1 sin «Extensiones», porque lo son I.2;
   - I.2 con títulos sin letra;
   - I.3 con el orden c) Extensiones, d) Evidencia, e) Valoración;
   - II.1 sin «Evidencia»;
   - II.2 con 3 títulos sin letra.
4. Enganche con los medicamentos España-Alemania, porque el 3.A.18 ya usa los turismos.
5. En la relevancia no se suman mercancías y servicios (no cuadran con el total de la OMC).
6. Datos de I y II, todos de propuestas-datos; Greenaway y Milner con el año de contenido.
7. Rechazados:
   - «juntos, pero no revueltos», «ojo por ojo» y la estructura con Melitz como II;
   - el gráfico `krugman-ces` en el cuerpo (va al anexo B como `krugman-tangencia`);
   - la viñeta «más empresas» del dumping y la afirmación sobre la industria farmacéutica alemana;
   - lo no comprobado de Shaked-Sutton.
8. Notas al pie conservadas (3, 4, 13, 23-26, 28-30, la 1 acortada y sin fecha, y en la parte 2 la 8 y la 31-32); quitadas las que tenían errores o duplicaban (2, 5, 7, 14-16, 18).
9. Supuestos de las estructuras de mercado, con el supuesto que se levanta, sin repetir la tabla.
10. Arkolakis, Costinot y Rodríguez-Clare en la valoración de Melitz y, en una línea, en la opinión de la conclusión.

**Control de calidad (05/11/2026), lo que no corrige el editor:**

- **HTML, fallo común de la conversión**: los `align` con varias etiquetas salen en el HTML como `\begin{aligned}` con un `\tag` en cada fila, y MathJax no los admite: se ve el código en amarillo en lugar de la fórmula. En este tema, las 4 ecuaciones del centro-periferia (7)-(10) del anexo D. Pasa también en los HTML de 3.A.5, 3.A.6, 3.A.8, 3.A.25, 3.A.36, 3.A.42, 3.A.44 y 3.B.28 (comprobado en 3.A.42). Hay que arreglarlo en el paso de pandoc a HTML (por ejemplo, convertir esos bloques en `align` de MathJax, que sí admite una etiqueta por fila) y reconstruir esos HTML.
- **HTML, licencia**: la cabecera lleva `<link rel="license">` a CC BY-NC-ND 4.0, pero el pie dice «Todos los derechos reservados · Exclusivo». Sale de la plantilla común (también en 3.A.36, 3.A.42 y 3.B.10): decidir si se cambia o se quita en los temas exclusivos.

**3.ª tanda de comentarios (10/11/2026):**

- **B06-01** Dónde van los antecedentes (10/11/2026). (a) Un apartado I.1 al principio, como nexo, con el antiguo anexo entero; (b) cada uno donde es relevante (Linder con el efecto del mercado doméstico, Falvey con Shaked-Sutton, los neotecnológicos en la introducción). **Aplicada: (a)**, la que Víctor apuntaba como nexo. El tiempo sale de II (−30″), III (−1′, aunque la gravedad sube a 1′30″) y I.1 se canta en 1′30″; el tema sigue en 30′.
- **B06-02** Eje X de la curva de concentración (10/11/2026). (a) Logarítmico, porque el 99 % del valor lo hace menos del 20 % de las empresas y en escala lineal las 2 curvas se pegan al eje; (b) lineal de 0 a 100, como pide el comentario al pie de la letra. **Aplicada: (a)**; si Víctor prefiere (b), basta quitar `xmode=log` en `graficos/concentracion-exportadoras-espana.tex`.
- **B06-03** Lectura de la caída de exportadoras de 2019 a 2025 (10/11/2026). La explicación en términos de Melitz (sube $\varphi^*_x$ y sale la cola de exportadoras pequeñas) es una interpretación; parte de la caída puede deberse a cambios de registro o a la menor exportación ocasional tras la pandemia (2019 tenía muchos operadores esporádicos). (a) Mantener la lectura con prudencia («es lo que ocurre cuando sube el umbral»); (b) quitarla y dejar solo los datos. **Aplicada: (a)**.
- **B06-04** Cifras de exportadoras (10/11/2026): el texto da 127.084 (informe de diciembre del Ministerio) y el gráfico 127.336 (microdatos, todos los NIF con valor positivo en 2025, datos provisionales a 10/11/2026). Son filtros distintos; se dicen «unas 127.000» en la lectura del gráfico. **Aplicada**: sin cambio en el texto anterior.
- **B06-05** Eurostat TEC frente a la AEAT (10/11/2026): TEC da para España en 2024 un 16,6 % de las 10 primeras y la tabla 2 un 13,9 % en 2025 (directorio estadístico frente a operadores fiscales); se avisa en la caja. Selección de 12 países: los grandes de la UE más Portugal, Países Bajos, Bélgica, Austria, Suecia, Chequia e Irlanda. **Aplicada**.
- **B06-06** Corte $\hat\varphi$ en Melitz (10/11/2026): que exista exige que $B^d+B^x$ sea más empinada que $B^d_{\mathrm{aut}}$, como en Melitz y Redding (2014); el gráfico lo cumple con los parámetros nuevos y el texto lo dice. Es notación nueva ($\hat\varphi$) que no está en el canon (canon-pendiente).
- **B06-07** Bibliografía nueva sin comprobar en línea (10/11/2026): Finger (1975), Aquino (1978), Greenaway, Hine y Milner (1995), Brülhart (1994) y Anderson (1979), con volumen, páginas y DOI de memoria; y el ±15 % del criterio de valores unitarios. Comprobar en Crossref al construir.
- **B06-08** McCallum (1995) (10/11/2026): «unas 20 veces» (el artículo da en torno a 22 para 1988); no se da cifra de Anderson y van Wincoop. Comprobar si se quiere la cifra exacta.
- **B06-09** La ficha de repaso (10/11/2026) crece: en una compilación de prueba ocupa 5 páginas a 9 pt y 4 a 8,75 pt; la construcción elegirá 8,75 pt. Si Víctor prefiere 9 pt, hay que recortar la ficha.

## Enlaces del original (9/11/2026)

Repaso de los enlaces del Word original (CRITERIOS § 4). Los demás enlaces del original ya estaban en el tema.

- **Restaurados**:
  - Cahal Moran (2020), «A Theory of Enormous Gravity» (Rethinking Economics; nota 8 del original): la dirección de rethinkeconomics.org da 404; el ensayo sigue en Exploring Economics. Entrada nueva `Moran2020Gravity` y cita en la nota de Isard de los modelos de gravedad (III.2).
  - Ficha del ciclo del producto de Vernon en ProvenModels (fuente del gráfico del original): en el `\fuente` del gráfico `fig:vernon`.
- **Ya conservado por otra vía**: el capítulo 16 de Gandolfo (2014) (DOI del capítulo, fuente de un gráfico): `Gandolfo2014International` lleva el DOI del libro y el tema cita el cap. 16.
- **No restaurado**: OMC, *Examen estadístico del comercio mundial 2023* (nota sobre el volumen del comercio mundial): la cifra que respaldaba se ha sustituido por la de 2025 (`OMC2026Perspectivas`). El enlace funciona; si Víctor quiere conservarlo como lectura, se añade al `.bib`.

## 8. Instrucciones para el vídeo

- *Pizarra (sacado del texto del tema el 11/11/2026)*: tabla de modelos vacía en una esquina, que se rellena con cada modelo; debajo, la regla del margen.

(Aún no hay guion ni escenas: entrega 3.)

- **Enganche e idea final**: «No vendas miel al colmenero»; España vende medicamentos a Alemania y se los compra (unos 2.100 y 2.500 millones de euros en 2025). La idea final vuelve al refrán: la miel de cada uno es distinta, producirla en grande sale más barato y la vende el mejor colmenero. Introducción y conclusión sin pizarra.
- **Gráfico conjunto por partes**:
  - Al empezar el I se dibuja en la esquina izquierda la **tabla 3 × 3 vacía**: filas, competencia perfecta, monopolística y oligopolio; columnas, homogéneo, vertical y horizontal; con H-O-S ya en su casilla.
  - Se rellena al presentar cada modelo: Krugman; «+ heterogeneidad: Melitz»; Brander-Krugman; Eaton-Kierzkowski; Shaked-Sutton; Falvey, en competencia perfecta-vertical. Se queda todo el cante y en la conclusión se señala.
  - Junto a cada casilla, su pegatina:
    - «más vale ser cabeza de ratón que cola de león» (Krugman);
    - «no todo el monte es orégano» (Melitz);
    - «pagar con la misma moneda» (dumping recíproco);
    - «a quien madruga, Dios le ayuda» (economías externas);
    - «cuantos más, mejor» (centro-periferia).
- **Funciones clave que se conservan**: `eq:precio-krugman` bajo la tabla, durante todo el cante; debajo se anota el margen de cada modelo (constante con CES, decreciente en Krugman, 1979, el mismo para cada φ en Melitz). `eq:umbrales-melitz` durante el I.3. `eq:reaccion-dumping` durante el II. `eq:dinamica-cp` durante el III.1.
- **Gráficos imprescindibles, por capas** (en `graficos-pedidos.json`):
  - `krugman-ppzz`: PP, ZZ, E0, ZZ′ y E1;
  - `melitz-umbrales`: autarquía, giro de $B^d$, $B^x$ y los 4 grupos;
  - `dumping-reciproco`: $R_A$, $R_B$, E0, $R_B'$ con τ > 1 y E1;
  - `tomahawk`: recta 1/2, ruptura, aglomeración, sostenibilidad, hoja e histéresis.
- **Gráficos de apoyo**: `economias-externas` (recomendable, 30″). Nunca a mano: `krugman-tangencia`, `centro-periferia-dinamica` y los del anexo A.
- **De palabra**: las 4 ecuaciones del centro-periferia (solo «salario real según acceso a mercados y coste de la vida»), las tablas 1, 2 y 4 salvo la pizarra de la tabla 1, y la gravedad en una línea escrita.
- **3.ª tanda (10/11/2026), gráficos por capas nuevos o cambiados**:
  - Krugman: primero `krugman-ppzz-autarquia` (ejes y $c$; PP; ZZ; $E_0$), después `krugman-ppzz` (lo mismo más ZZ′ y $E_1$); `krugman-ppzz-ces` (PP horizontal; ZZ; $E_0$; ZZ′; $E_1$) y `monopolio-procompetitivo` (D; IMg; CMg; monopolio; exportaciones) son de caja gris, no se dibujan en el cante.
  - Melitz: `melitz-autarquia` (recta; umbral; tramo en 0; $wF^e$; grupos), `melitz-umbrales` (10 capas, ahora con $\hat\varphi$ y 5 grupos) y `melitz-ganancias` (autarquía; comercio; pérdidas; ganancias; cortes y $wF^e$). El imprescindible sigue siendo `melitz-umbrales`; los otros 2, recomendables.
  - Datos: `concentracion-exportadoras-espana` (2019; 2025; puntos; rótulos) y `concentracion-exportadoras-ue` (caja gris).
  - Nuevo orden: el I empieza por los antecedentes (I.1), de palabra con la tabla de las 4 preguntas; la casilla de Falvey de la tabla de modelos se rellena al principio del I.
- **Nunca** se dice en voz alta el número de un tema.
