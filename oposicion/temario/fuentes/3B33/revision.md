# Revisión del 3.B.33 — La OMC. Antecedentes y Organización actual. El GATT y los Acuerdos sobre el comercio de mercancías. Situación actual

Revisión completa del 14/11/2026 (entrega 1: tema y ficha de repaso; sin vídeo), en el worktree `revision-temario-2`, en paralelo con los agentes de los 3.B.30 y 3.B.32. Fuente nueva en LaTeX (`3B33.tex`) a partir del Word original (`_trabajo/original.md`, el antiguo 3.B.34 de la versión de agosto de 2023), **redactada de nuevo** y puesta al día a noviembre de 2026 con fuentes de wto.org (páginas, notas de prensa y los ficheros de datos de la propia OMC: base de datos de diferencias, estadísticas de defensa comercial, *World Tariff Profiles*). Las dudas se resuelven con la opción recomendada y se anotan como B33-NN (14/11/2026).

## 1. Resumen

- Tema completo con los 3 bloques del original y sus títulos de segundo nivel: **I. La OMC: antecedentes y organización actual** (I.1 antecedentes; I.2 organización actual), **II. El GATT y los acuerdos sobre el comercio de mercancías** (II.1 multilaterales; II.2 plurilaterales) y **III. Evolución de las negociaciones y situación actual** (III.1 y III.2). Reparto: introducción 2′30″, I 9′, II 9′30″, III 8′, conclusión 1′.
- 2 modelos nuevos con la estructura rígida a)-e): la **teoría de los acuerdos comerciales** de Bagwell y Staiger (1999) en un ejemplo lineal-cuadrático propio (arancel de Nash $t^N=\pi+\alpha$ frente al políticamente óptimo $t^{PO}=\pi$, curva de contrato, reciprocidad y NMF; el dilema del prisionero con los pagos canónicos 5/6/0/1 y el gatillo β ≥ 1/5) y la **protección administrada** de Bagwell y Staiger (1990), la economía de las salvaguardias (restricción de incentivos $\tfrac12(\alpha\theta-t^c)^2\le K$).
- 10 gráficos y figuras nuevos en TikZ/pgfplots: 4 de datos reales de la OMC (rondas del GATT; aranceles consolidados y aplicados; investigaciones de defensa comercial 1995-2025; diferencias por año 1995-2026), 3 teóricos (Bagwell-Staiger, protección administrada, fórmula suiza) y 3 figuras (acuerdos de la OMC, estructura, etapas de una diferencia) que sustituyen a las 5 imágenes del Word y a las capturas del anexo. 3 tablas (dilema arancelario, cajas agrícolas, conferencias ministeriales).
- Datos a noviembre de 2026: 166 miembros, 22 adhesiones; CM14 (Yaundé, 26-30/3/2026) y su seguimiento hasta el Consejo General de octubre; moratoria digital expirada; pesca en vigor (15/9/2025); Facilitación de Inversiones (131, veto de la India); Comercio Electrónico (66); MPIA (62, 60,4 %); 646 diferencias; DS577 aceitunas, DS611, DS630, DS593, DS639; aranceles de EE. UU. de 2025-2026 y su encaje (arts. I, II, XII, XXI, XXIV); NMF 83 → 72 %; presupuesto y atrasos de EE. UU.
- PDF: 29 páginas de tema, 2 de anexos, 5 de bibliografía (36 en total); cante de 30′. Ficha de repaso de 4 páginas a 10 pt (última, 84 %). `verificar-tema.py` (sobre los ficheros de `_trabajo/`, porque con `--no-publicar` no se copian a `tercer-ejercicio/`): sin errores propios; solo quedan avisos de «cifra sin cita» en párrafos cuya cita va en el gráfico o en el párrafo anterior, y los del vídeo (entrega 3).

## 2. Errores corregidos

| Dónde (Word) | Decía | Dice ahora |
|---|---|---|
| Marco institucional | 164 miembros (4/8/2023) | 166 (Comoras y Timor Oriental, agosto de 2024); 22 adhesiones en curso |
| Nota 19 | Mandato de la DG «terminará el 31 de agosto de 2025» | Renovada el 29/11/2024; segundo mandato desde el 1/9/2025 |
| Financiación | «presupuesto anual de unos 175 millones de euros» | Unos 205 millones de **francos suizos** (2026), con los atrasos de EE. UU. (B33-07) |
| Exámenes de políticas | EE. UU., UE, China y Japón «cada 2 años», 16 siguientes cada 4, resto cada 6/7 | Cada 3, 5 y 7 años (frecuencias vigentes desde 2019) |
| Antidumping | Denuncia apoyada por «más del 50 % de la producción»; margen «superior al 2 %»; importaciones «más del 1 %» | Apoyo de al menos el 25 % de la producción (y más que los que se oponen); margen *de minimis* del 2 %; importaciones *de minimis* del 3 % |
| SMC | Recurribles «mayores al 5 % del producto»; no recurribles «inferiores al 5 %»; notificación de las subvenciones «cuando no están orientadas a una rama» | La presunción del 5 % y la categoría de no recurribles expiraron en 1999; se notifican las subvenciones **específicas** (las que sí van a ciertas empresas o sectores) |
| Licencias | «plazos máximos (60 días)» | Sin cifra (el plazo depende del tipo de licencia) |
| Valoración en aduana | «el valor en aduana […] es el precio en factura valorado en términos CIF» (como regla de la OMC) | Valor de transacción; el acuerdo deja elegir CIF o FOB (la UE usa CIF, EE. UU. FOB) |
| Rondas | España «se autocalifica como país en desarrollo» en 1963 | Se mantiene, como dato histórico |
| Rondas (2.ª etapa) | Ronda de Tokio 1973-1979 con «aumento de países de 45 a 102» | 62 (Kennedy) y 102 (Tokio), según la OMC |
| Ronda Uruguay | arancel medio «del 6,3 % al 3,9 %» | 6,3 → 3,8 % (OMC), recorte del 40 % de los aranceles industriales de los países desarrollados |
| Fórmula suiza (nota 10) | «no empezó a utilizarse hasta Hong Kong (2005)» | Se usó en la Ronda de Tokio (EE. UU. a = 14, CE a = 16; Baldwin, 2012); en Doha se propuso para los productos industriales |
| CM1 Singapur | ITA = «International Technology Agreement» | *Information Technology Agreement* |
| CM2 Ginebra | «Declaración sobre el comercio electrónico, que defendía la no imposición de aranceles al comercio electrónico» | Moratoria sobre las **transmisiones electrónicas** (no sobre el comercio electrónico de bienes) |
| CM11 Buenos Aires | «se acuerda una moratoria» | Se prorrogó la moratoria existente; iniciativas plurilaterales |
| CM12 | «Conclusión de un acuerdo sobre la eliminación de los subsidios a la pesca que contribuyen a la sobrepesca» y «lanzamiento formal de negociaciones plurilaterales» | El acuerdo de 2022 prohíbe las subvenciones a la pesca INDNR, a poblaciones sobreexplotadas y en alta mar no regulada; las de sobrecapacidad y sobrepesca quedaron para la «segunda ola»; las iniciativas plurilaterales venían de 2017 |
| Plurilaterales | Aeronaves «32 signatarios», ACP «48 signatarios», ITA «82 países», químicos «28», farmacéuticos «35» | Aeronaves 32 (contando a la UE y a varios Estados por separado); ACP 22 partes y 49 miembros; ATI 84 participantes; químicos y farmacéuticos sin cifra (no comprobada) |
| Agricultura (nota 37 y cajas) | — | Se añade la Medida Global de la Ayuda (−20 %) y la caja de desarrollo (art. 6.2) |
| Textiles | El ATV «ha dejado de existir» y además «solo los países que demuestren daño grave están autorizados a mantener restricciones» | Expiró el 1/1/2005 y con él las cuotas; desde entonces, reglas generales (salvaguardias) |
| MPIA (2023) | «25 miembros» y «no cuenta con […] China» | 62 miembros (60 % del comercio), **con** China; sin EE. UU. ni la India |
| OA | «consta de 7 árbitros» | 7 miembros, quórum de 3; sin quórum el 11/12/2019 y sin miembros desde el 30/11/2020 |
| Apertura mundial | Datos de 2008-2015 del Banco Mundial | Sustituidos por los datos de la OMC (NMF, aranceles, comercio 2025-2026); la historia de la apertura está en el 3.B.21 |
| Situación actual | China «viola el espíritu», «350.000 millones» de aranceles de EE. UU. (2018-2019) | Se recoge en una línea con remisión; la situación actual son los aranceles de 2025-2026 |

## 3. Marcas resueltas

| Marca | Texto original | Qué se ha hecho |
|---|---|---|
| Nota al opositor (l. 1-7) | Aviso del cambio de temario de 2023 y tabla | Desaparece (aviso de trabajo) |
| Comentarios internos (introducción) | «Definición de ronda de desarrollo…», «Tema 3.B.10: arancel óptimo… Kemp y Wan», «90 % … artículo XXIV», enlaces de IPS y EFE, «otra posibilidad es introducción conjunta…» | No se publican; su contenido se integra: Kemp-Wan en la nota del art. XXIV, el 90 % en el art. XXIV, la disputa de China con EE. UU. en el enganche (actualizada a 2025) |
| Comentario «Coordinar en temas 3.B.33 y 3.B.34» | — | Frontera fijada: aquí solo mercancías y arquitectura; AGCS, ADPIC, ACP y nuevos plurilaterales con `\vertema{3.B.34}` |
| Comentario «Características principales, cómo se financia… lo que regula y no regula la OMC (apartado tema ICEX-CECO)» | — | Resuelto: características (funciones, miembros, decisiones, financiación, DG) y una caja gris «Lo que la OMC regula y lo que no» (inversión, competencia, normas laborales, medio ambiente, tipos de cambio, fiscalidad, contratación pública, seguridad), contrastada con el tema de ICEX-CECO del disco D: (sin citarlo) |
| Amarillo (conclusión) | «[…(Tema ICEX-CECO)]» | Resuelto con la conclusión nueva; los intereses de España (servicios, indicaciones geográficas, pesca, algodón) se recogen donde corresponde (España y la pesca en II.1.2; la UE negocia por España) |
| Apartados vacíos de la conclusión | Relevancia, Opinión | Escritos |
| Imágenes 1-5 y las del anexo 3 | Capturas de la OMC y de Wikipedia; diapositivas de un curso (slideshare) | Sustituidas por figuras y gráficos TikZ propios (acuerdos, estructura, etapas de una diferencia, fórmula suiza) y por la tabla de las cajas; el mapa de miembros y observadores de Wikipedia se quita (no es un gráfico) |
| Anexo 4 «Comparación de la estructura del Tratado de Roma y los acuerdos de la OMC» | Solo una imagen sin texto ni fuente | Se quita (no se pudo identificar la fuente; B33-08) |
| Enlace de test | quia.com | Caja estándar del simulador (`tema=3.B.33`) |
| Bibliografía del Word | Temas de ICEX-CECO, de A. Sahuquillo, de J. L. Cordero Tarifa, apuntes de USYD, wto.org | Los temas de preparadores no se citan (CRITERIOS §5); se citan las páginas de la OMC y los artículos originales |
| «Preguntas de otros exámenes» | Vacío | Se quita (la ficha tiene «Preguntas del tribunal») |

## 4. Datos actualizados

Todos consultados el 14/11/2026. Primera fuente: wto.org (páginas, notas de prensa o ficheros de datos); segunda comprobación indicada.

| Dato | Antes | Ahora | Fuente | Segunda comprobación |
|---|---|---|---|---|
| Miembros | 164 (2023) | 166 (última adhesión 30/8/2024) | `countrylib.js` de la OMC | Tracker de adhesiones (22 en curso); 3.B.21 |
| DG | mandato hasta 31/8/2025 | 2.º mandato desde 1/9/2025 | dg_e.htm | Notas de prensa del CG del 29/11/2024 |
| CM14 | prevista en Camerún | Yaundé, 26-30/3/2026, 3 decisiones; moratorias expiradas | Notas de la OMC (mc14_30mar26; gc_06may26) | USTR (30/3/2026); Third World Network |
| Seguimiento CM14 | — | CG 6/5, 26/6 (reforma: 4 líneas), 14-15/7 y 5-6/10/2026; sin acuerdo sobre el paquete | Notas de la OMC | — |
| Moratoria digital | prorrogada hasta la CM14 | Expiró el 30/3/2026; 19 miembros sin aranceles entre sí (mayo) | ecom_work_programme_e.htm; gc_06may26 | USTR |
| Acuerdo de pesca | adoptado en 2022 | En vigor 15/9/2025; 122 aceptaciones (julio de 2026) | fish_e.htm; DG en el CG de julio | Prensa (123 con la India) |
| Facilitación de Inversiones | — | 131 participantes; veto de la India en la CM14 | invfac_e.htm; mc14 | TWN |
| Comercio Electrónico | — | 66 miembros adoptan la aplicación provisional (45 aceptaciones) | mc14_28mar26_341 | jsec_09jun26 (73 apoyan el texto) |
| MPIA | 25 miembros | 62 miembros, 60,4 % del comercio | Comisión Europea, 9/9/2026 | OMC (61 en la CM14) |
| Diferencias | — | 646 (DS646, 27/7/2026); 10 en 2024, 13 en 2025, 2 en 2026 | `dispute_case_arrays_e.js` | Numeración correlativa; DG (22 en 2 años) |
| Apelaciones al vacío | — | unas 30 (27 desde el 11/12/2019; 34 con estado «under appeal») | Misma base | Varían según la fuente (B33-05) |
| DS577 | — | Represalias de 13,64 M$ al año autorizadas el 19/12/2025 | 577arb_184_e; dsb_19dec25 | Base de diferencias (ST12) |
| DS611, DS630, DS593, DS639 | — | Laudo MPIA 21/7/2025; grupo compuesto 13/10/2025; arbitraje 22.6 (19/3/2026); grupo establecido 25/9/2026 | Base de diferencias | Notas del OSD |
| Aranceles consolidados/aplicados | Banco Mundial 2019 (excedentes) | WTP 2025 (datos de 2024) | World Tariff Profiles 2025 | WTP 2026 (datos de 2025: mismas cifras salvo UE 4,9 e India 16,0; B33-06) |
| Arancel NMF mundial | — | 13,1 % (1996) → 8,9 % (2024) | Blog de datos de la OMC, 22/9/2026 | — |
| Comercio NMF | — | 83 % (2022), 74 % (mayo de 2025), 72 % (feb. de 2026) | WTP 2025; Perspectivas de marzo de 2026 | Blog de 22/9/2026 |
| Defensa comercial | — | 7.471 AD, 816 CVD, 455 SG (1995-2025); máximo en 2024 | Ficheros xlsx de la OMC | Suma por miembros |
| Rondas | — | Participantes y recortes | OMC (fact4_e, agrm2_e) | Baldwin (2012) |
| Vigilancia G-20 | — | Nuevas restricciones 14,3 % de las importaciones del G-20; acumuladas 22 % (nov. 2025) | tmg20_13nov25 | Informe de la DG de 2/12/2025 (11,1 % y 19,7 % del mundo) |
| Comercio mundial | 2015 (16,5 billones) | +4,6 % (2025), +3,9 % (2026), +4,1 % (2027) en volumen | stat_08oct26 | 3.B.21 |
| AFC | «1 billón de euros» (Peterson) | 89,6 % de compromisos aplicados; OCDE: −13 a −15 % de costes | TFA database; OCDE (2018) | — |
| Presupuesto | 175 M € | ≈205 M CHF (2026); ≈620 personas | Prensa (Reuters, mayo de 2026); secre_e | B33-07 |
| Aranceles de EE. UU. | — | IEEPA, Supremo 20/2/2026, s. 122 (24/2-24/7/2026, notificada como BP), s. 301 (24/7/2026), s. 232 | USTR; OMC (bop_05may26) | Global Trade Alert; despachos (Jones Day, King & Spalding) |

## 5. Contenido añadido

- **Teoría de los acuerdos comerciales** (I.1.2), modelo a)-e) con ejemplo propio, gráfico en el espacio de los aranceles y la tabla del dilema; extensiones (compromiso de Maggi y Rodríguez-Clare, Grossman y Helpman, Antràs y Staiger) y evidencia (Broda, Limão y Weinstein; Bagwell y Staiger, 2011; Ossa, 2014; Rose, 2004, y Tomz, Goldstein y Rivers, 2007). Lo pedía el encargo y es la remisión que hace el 3.B.8 al 3.B.33.
- **Economía de las salvaguardias** (II.1.3), modelo a)-e) de Bagwell y Staiger (1990), con Rosendorff y Milner (2001) y Bown y Crowley (2013).
- **Excepciones completas**: balanza de pagos (con el uso de EE. UU. en 2026), art. XX (MAFC y clubes climáticos), art. XXI (DS512, DS544).
- **Acuerdo de Subvenciones a la Pesca** (en vigor) y los nuevos plurilaterales (IFD, Comercio Electrónico) en su frontera con el 3.B.34.
- **CM13 y CM14** y su seguimiento; **proceso de reforma** de 2026; **unilateralismo** de EE. UU. con su encaje jurídico; **diferencias** de la UE y España.
- **Caja «Lo que la OMC regula y lo que no»**, resolviendo el comentario del Word.
- Anexos: métodos de reducción arancelaria y fórmula suiza con sus propiedades y su derivada (del anexo 2 del original), y conceptos (ampliado con progresividad arancelaria, cláusula de paz y reclamaciones sin infracción).
- Material del disco D: usado: la versión propia de 2023 («Tema 3.B.34 - v.2023.pdf») y la de 2024 («Mis temas\Tema 3.B.34 - v.2 - 2024.docx», idéntica en contenido al Word de partida); de la carpeta «Tema 3.B.34»: el *Oxford Handbook on the WTO* (capítulo 1 de R. E. Baldwin, base de la teoría de los acuerdos y de los recortes por ronda, citado), «Acuerdos de agricultura en la OMC» (cajas y pilares), «Lecturas sobre la OMC a veinte años de su creación» (índice; capítulos sobre el OSD y el art. XX, de contraste) y el capítulo 3 de «Entender la OMC» de la carpeta de Bibliografía (plazos del ESD, citado en su versión web); como contraste sin citar: el tema de ICEX-CECO (3B33, numeración actual; su orientación de tiempos y el apartado de áreas no reguladas) y el 3B-34 de otro preparador (estructura).

## 6. Coherencia

- **Canon**: notación de `notacion.md` ($t$, $t^*$ con asterisco para el extranjero, RRI); el dilema del prisionero con los pagos de referencia (5, 6, 0, 1) y el gatillo β ≥ 1/5 del 3.A.14; Kemp-Wan como mención (ficha `kemp-wan`); clubes climáticos frente a la NMF (ficha `clubes-climaticos`, mención prevista ahora hecha); MAFC y art. III/XX (ficha `cbam`); cadenas globales de valor (ficha `cadenas-globales-valor`, mención prevista ahora hecha). Símbolos locales nuevos ($\pi$, $\alpha$, $\theta$, $K$, $t^{PO}$, $t^c$) y fichas propuestas en `_trabajo/canon-pendiente.md`.
- **3.B.7**: el tema remite aquí para el art. V, la valoración en aduana, la NMF, las MSF/OTC, el art. XI, el SMC y las salvaguardias; todo está en II.1. La tabla de Nairobi del 3.B.7 coincide con los plazos de aquí.
- **3.B.8**: remite al 3.B.33 para Bagwell y Staiger: ahora desarrollado (I.1.2), sin repetir la guerra de Johnson ni Airbus-Boeing (solo mención).
- **3.B.10**: art. XXIV y Kemp-Wan, con las mismas palabras (5 y 6 del art. XXIV).
- **3.B.20 y 3.B.21**: la Ronda Kennedy recorta «en torno a un 35 %» en el 3.B.20 y aquí un 36 % (Baldwin): compatibles; MPIA 62/60 % y CM14 iguales que el 3.B.21, pero aquí se corrige que la CM14 no terminó «sin resultados» (aprobó 3 decisiones menores): anotado para el 3.B.21 en `canon-pendiente.md`.
- **3.B.31**: el MAFC y el art. XX con las mismas palabras; se añade la diferencia DS639 (Rusia contra el MAFC), que el 3.B.31 no tiene: anotado.
- **3.B.34** (pendiente): frontera fijada (solo menciones de AGCS, ADPIC, ACP, IFD, Comercio Electrónico y reclamaciones sin infracción).
- **4.º ejercicio**: `\vertema{4.A.27}` (España en el GATT, 1963), `\vertema{4.A.4}` (pesca), `\vertema{4.A.24}` (internacionalización), `\vertema{4.B.18}` (fiscalidad internacional).

## Comentarios de Víctor (14/11/2026, reglas de la 9.ª tanda aplicadas)

| Regla | Cómo se ha aplicado |
|---|---|
| Estructura rígida de modelo | 2 modelos (acuerdos comerciales; salvaguardias) con a) Idea, b) Modelo (i-iii), c) Extensiones, d) Evidencia empírica, e) Valoración |
| Sin citas Harvard | Solo `\nocite` y `\textcite` de obras originales; ningún `\parencite` |
| Nunca citar a Víctor | Ninguna entrada suya; gráficos «elaboración propia» |
| Ni «Pegatina» ni «Dicho» | No hay; el único refrán es el del enganche, retomado en la idea final |
| Nobel con motivo oficial | No se nombra a ningún premio Nobel de Economía (Krugman y Stiglitz no salen; Bhagwati, Bagwell, Staiger, Grossman y Helpman no lo son) |
| `\vertema` al 4.º ejercicio | 4.A.4, 4.A.24, 4.A.27, 4.B.18 |
| Resultados clave en morado | `eq:bagwell-staiger` y `eq:incentivos` con `\funcionclave` |
| Pasos con sangría | Desarrollos por pasos en sublistas |
| Cajas grises | Notación; GATT 1947/1994; lo que la OMC regula; seguridad nacional; diferencias de la UE y España |
| Ejemplos sin nombres propios | Sí (países $A$ y $B$) |
| Sin remisiones vacías | Cada `\vertema` tras la idea completa |
| Inglés entre paréntesis la primera vez | *single undertaking*, *commitment*, *binding overhang*, *waivers*, *spaghetti bowl*, *building/stumbling blocks*, MPIA |
| Anexo de test | Caja estándar con `tema=3.B.33` |
| Sin páginas en blanco ni desbordes | Comprobado con `verificar-tema.py` sobre `_trabajo/` |

## 7. Dudas abiertas

Todas aplicadas con la opción recomendada (14/11/2026); para que Víctor las confirme.

- **B33-01** Refrán del enganche: «Hecha la ley, hecha la trampa» (no lo usa ningún otro tema), por las excepciones del GATT y el art. XXI de 2025-2026; la idea final lo matiza (el GATT pone precio y plazo a las trampas). Opciones: (a) mantenerlo **[aplicada]**; (b) «La unión hace la fuerza» (ya sale en el 3.A.11).
- **B33-02** Dónde va la teoría de los acuerdos comerciales: como I.1.2, entre la guerra arancelaria de entreguerras y los orígenes del GATT (explica por qué hace falta un acuerdo), en lugar de en II.1.1 (principios), que remite a ella. Opciones: (a) en I.1.2 **[aplicada]**; (b) en II.1.1.
- **B33-03** El modelo de Bagwell y Staiger se cuenta con un ejemplo lineal-cuadrático propio ($W=\pi t-\tfrac12t^2+\alpha(t-t^*)$) en el que la RRI depende de $t-t^*$, de modo que la reciprocidad lleva exactamente al óptimo político por la diagonal. Es una simplificación pedagógica del modelo general (que demuestra lo mismo con preferencias generales). Opciones: (a) así, avisado en el texto **[aplicada]**; (b) solo la versión general, de palabra.
- **B33-04** La economía de las salvaguardias (Bagwell y Staiger, 1990) va como subapartado propio (II.1.3) para respetar la jerarquía a)-e) (no cabe un modelo dentro de un párrafo de nivel 4); las listas de compromisos pasan a II.1.4. Opciones: (a) así **[aplicada]**; (b) llevar el modelo a un anexo.
- **B33-05** Apelaciones «al vacío»: «unas 30» (27 desde el 11/12/2019 y 34 en total con estado de apelación en la base de la OMC; las cifras publicadas varían porque algunas cuentan las apelaciones de cumplimiento). Ninguna acción.
- **B33-06** El gráfico de aranceles consolidados y aplicados usa *World Tariff Profiles 2025* (datos de 2024); la edición de 2026 (datos de 2025) salió el 29/06/2026 y no se descargó a tiempo para el gráfico (sus cifras, casi iguales, están en `datos-actualizables.yaml`). Opciones: (a) dejar 2024 y actualizar en la próxima pasada **[aplicada]**; (b) rehacer ya el CSV con 2025.
- **B33-07** Presupuesto de 2026 (204,9 M CHF) y atrasos de EE. UU.: solo de la prensa (Reuters, mayo de 2026); la página de la OMC tiene el de 2025. Opciones: (a) «unos 205 millones» y «acumula atrasos», sin cifra de deuda **[aplicada]**; (b) quitar el presupuesto.
- **B33-08** El anexo 4 del Word («Comparación de la estructura del Tratado de Roma y los acuerdos de la OMC») era solo una imagen sin fuente: se quita. Opciones: (a) quitarlo **[aplicada]**; (b) rehacerlo como tabla en el 3.B.34 o el 3.B.41.
- **B33-09** Bloqueo de la moratoria digital en la CM14: se atribuye a Brasil y Turquía «según Estados Unidos» (la OMC no nombra a nadie; Turquía dejó de bloquear en mayo). Ninguna acción.
- **B33-10** Salvaguardia del acero de la UE: se dice que llegaba al límite de 8 años en junio de 2026 y que la Comisión propuso en 2025 sustituirla por un régimen permanente de contingentes; no se ha comprobado si ese régimen ya está en vigor. Comprobarlo con el 3.B.41.
- **B33-11** Número de acuerdos del anexo 1A: «13» (12 de la Ronda Uruguay menos el ATV, más el AFC y el de pesca). La OMC sigue listando el ATV en su guía. Ninguna acción.
- **B33-12** Los intereses ofensivos y defensivos de España del original (servicios, indicaciones geográficas, compras públicas, pesca, algodón, frutas y hortalizas) no se reproducen en lista: España negocia a través de la UE y su detalle es materia del 3.B.41; se conserva la pesca. Opciones: (a) así **[aplicada]**; (b) recuperarlos en una caja gris.

## 8. Instrucciones para el vídeo

- **Enganche e idea final**: «Hecha la ley, hecha la trampa»; aranceles de EE. UU. de 2025 y la invocación de la seguridad nacional; NMF 83 → 72 %. La idea final: el GATT puso precio y plazo a las trampas.
- **Introducción y conclusión, sin pizarra** (`modo: guion`).
- **I.1**: la guerra arancelaria de los 30 de palabra; el modelo de Bagwell y Staiger **imprescindible** en la pizarra: primero la función $W$, luego el gráfico `bagwell-staiger` por capas (ejes; $R_A$, $R_B$ y $N$; la lente de mejora; curva de contrato y $PO$; diagonal y flecha de la reciprocidad), y la función clave `eq:bagwell-staiger` recuadrada, que se conserva hasta el final del bloque II (`conservar:`). La tabla del dilema, como apoyo. Las rondas (`rondas-gatt`) por capas (barras, ejes, recortes, participantes, las 2 etapas).
- **I.2**: la figura `acuerdos-omc` (el mapa del tema) por capas, en la pizarra; la estructura y las etapas de una diferencia como apoyo.
- **II.1**: principios y excepciones de palabra; el gráfico de defensa comercial como apoyo; el modelo de las salvaguardias con `clausula-escape` por capas y la función clave `eq:incentivos`; el de aranceles consolidados, apoyo; las cajas agrícolas, apoyo.
- **III**: la tabla de conferencias como apoyo; el gráfico `diferencias-anio` en la pizarra por capas (barras, ejes, sombreado del bloqueo, rótulos).
- **Funciones clave que se conservan**: `eq:bagwell-staiger` (desde I.1) y `eq:incentivos` (desde II.1.3).
- Nunca se dice el número de un tema en voz alta.

## Coherencia con el 3.B.34 (14/11/2026)
- Exámenes de políticas comerciales cada 3 años: la OMC (página del MEPC) lista hoy a la UE, Estados Unidos, China y el **Reino Unido**, no Japón. Corregido.
- Acuerdo de Facilitación de las Inversiones en Yaundé: la OMC no nombra a quien bloqueó; se dice «por falta de consenso» y que la prensa señala a la India (tema, tabla de conferencias y ficha).
- Acuerdo sobre Comercio Electrónico: 66 miembros en Yaundé, 68 en noviembre de 2026 (tema y ficha).
- Reforma: las 4 líneas de junio de 2026 salieron de una reunión de jefes de delegación (26/6), no del Consejo General.
- Acuerdos regionales en vigor notificados: unos 390 (cifra del 3.B.35, base de la OMC a noviembre de 2026), no 380 (tema y ficha).
