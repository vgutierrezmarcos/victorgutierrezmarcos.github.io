# Revisión del 3.B.41 — La política comercial de la Unión Europea

Revisión completa del 14/11/2026 (entrega 1: tema y ficha de repaso; sin vídeo), en el worktree `revision-temario-2`, en paralelo con los agentes de los 3.B.40 y 3.B.42. Fuente nueva en LaTeX (`3B41.tex`) a partir del Word original (`_trabajo/original.md`, el antiguo 3.B.43, versión de 2023, que venía casi entero del tema de un preparador), **redactada de nuevo** y puesta al día a noviembre de 2026 con fuentes oficiales (Comisión Europea, Consejo, Parlamento Europeo, EUR-Lex, Eurostat, OMC) y prensa cuando no había fuente oficial. Las dudas se resuelven con la opción recomendada y se anotan como B41-NN (14/11/2026).

## 1. Resumen

- Tema completo en 3 bloques, con los títulos de primer y segundo nivel del original: **I. Las bases de la política comercial común** (I.1 Relevancia; I.2 Aproximación de teoría económica; I.3 Marco jurídico; I.4 Delimitación; I.5, nuevo, la estrategia comercial), **II. La política comercial autónoma** (II.1 arancel; II.2 defensa comercial; II.3 SPG; II.4, nuevo, instrumentos de seguridad económica y sostenibilidad) y **III. La política comercial convencional** (III.1 OMC; III.2 acuerdos preferenciales; III.3 acuerdos en negociación y pendientes; III.4 otras relaciones: EE. UU., China, Rusia y ACP). Reparto: introducción 2′30″, I 8′, II 10′, III 8′30″, conclusión 1′.
- 3 modelos con la estructura rígida a)-e): **la economía política de la sola voz** (Meunier, 2005, leído en el disco D:), **la colusión inducida por el antidumping** (Prusa, 1992, con un ejemplo numérico de Bertrand diferenciado) y **la negociación con EE. UU. con la solución de Nash** (Nash, 1950; Grossman y Helpman, 1995), que explica el acuerdo asimétrico del 15 % y el valor disuasorio del Instrumento Anticoerción. La creación y desviación de comercio se resume y se remite al 3.B.10; los aranceles óptimos y la guerra de Johnson, al 3.B.7/3.B.8; Bagwell-Staiger, al 3.B.33.
- 6 gráficos y 3 figuras en TikZ/pgfplots: 3 de datos descargados (comercio de bienes con los 16 primeros socios y situación de sus acuerdos, Eurostat 2025; arancel NMF por grupos de productos, OMC 2024; investigaciones y medidas de defensa comercial de la UE 1995-2025, OMC), 3 de modelos (sola voz, compromiso de precios, negociación de Nash) y 3 figuras (cronología 1957-2026, procedimiento de los arts. 207 y 218, escalera de preferencias). 5 tablas (nuevos instrumentos; acuerdos cerrados o en negociación; acuerdos por regiones; competencias del TFUE) y 4 anexos (acuerdos por regiones, ACC con el Reino Unido, competencias, test).
- PDF: 30 páginas de tema, 3 de anexos, 5 de bibliografía (38). Ficha de repaso de 4 páginas a 10 pt (última, 82 %). `verificar-tema.py` (envoltorio sobre `_trabajo/`): 0 errores propios; los «Imagen inexistente en el HTML» son del envoltorio (salen igual en el 3.B.36); quedan avisos de «cifra sin cita» en párrafos cuya cita está en el párrafo anterior o en el gráfico, «Kennedy» (Ronda Kennedy, no es una persona) y los del vídeo (entrega 3).
- Refrán del enganche: «Donde las dan, las toman» (no lo usa ningún otro tema; anotado en `refranes-tanda.txt`), retomado en la idea final.

## 2. Errores corregidos

| Id | Dónde (Word) | Decía | Dice ahora |
|---|---|---|---|
| E1 | Introducción | La política comercial autónoma regula «las relaciones comerciales entre los Estados miembros (vertiente interna)» | Las 2 vertientes miran a terceros países: la autónoma es lo que la UE decide sola; la convencional, lo que pacta |
| E2 | Relevancia | La UE es «el segundo mayor exportador (por detrás de China)» y, en otro lugar, «la primera exportadora e importadora» y «un tercio del comercio global» | Sumando bienes y servicios es el mayor exportador del mundo y el segundo importador de bienes; el «tercio» contaba el comercio dentro de la UE |
| E3 | Contextualización | «Fue en 1971 cuando el Tribunal de Justicia dictó que el comercio de mercancías es una competencia exclusiva» | 1971 es la sentencia AETR (competencias exteriores implícitas); la exclusividad de la PCC la confirmó el dictamen 1/75 (1975) |
| E4 | Arancel exterior común | Media actual «~4 % (10 % agrícolas, 3 % no agrícolas)» | 5,0 % de media simple (10,5 % agrícolas, 4,1 % no agrícolas) y 2,8 % ponderada (OMC, 2024) |
| E5 | Reducciones arancelarias | Se modifican «con el objetivo de conseguir situaciones de escasez de producción o alzas de precios» | Para responder a la escasez o a las subidas de precios |
| E6 | Regímenes aduaneros | Zonas francas «se suele aplicar a regiones apartadas (p. ej. Islas Canarias)» | Las Canarias están dentro de la unión aduanera (fuera del IVA); las zonas francas son recintos (Barcelona, Cádiz, Vigo…) |
| E7 | Antidumping | «La Comisión inicia en menos de 45 días una investigación (máximo 15 meses)… El Consejo aprueba por mayoría simple las medidas» | Definitivas en 14 meses (desde 2018); desde 2014 las adopta la Comisión con actos de ejecución y un comité de los Estados, no el Consejo |
| E8 | Antidumping | «La reclamación debe estar apoyada por productores… más de un 50 % de la producción total» | Al menos el 25 % de la producción de la Unión y más de la mitad de los productores que se pronuncian |
| E9 | Antisubvenciones | Subvenciones «no recurribles: inferiores al 5 % o horizontales» y «recurribles… mayores que el 5 %» | La categoría de no recurribles (y la presunción del 5 %) expiraron en 2000 |
| E10 | Salvaguardias | «Sólo los Estados miembros pueden pedir…» y «serán definitivas si el Consejo las aprueba» | Puede pedirlas un Estado o actuar la Comisión de oficio; las adopta la Comisión. Y la del acero ya no es una salvaguardia desde el 1/7/2026 |
| E11 | SPG | SPG estándar para renta «menos de 4.045 $» y SPG+ para renta «menor a 1.036 $»; preferencias «para ciertos alimentos»; introducido en 1972 | Los criterios son la clasificación del Banco Mundial (renta baja y media-baja) y, para el SPG+, la vulnerabilidad y los convenios; cubre productos industriales y agrícolas; la Comunidad lo aplicó desde 1971 |
| E12 | Plurilaterales | Contratación pública «48 países»; ATI «82»; TiSA «la mayor esperanza»; bienes ambientales «en negociación» | ACP: 22 partes, 49 miembros; ATI: 84; TiSA suspendido en 2016; bienes ambientales parado desde 2016 (cifras iguales que en el 3.B.33 y el 3.B.34) |
| E13 | EEE | «Como consecuencia de la adhesión de 2 países de la EFTA a la UE en 1973… se crea el EEE en 1992» | El EEE nace del mercado único: se firmó en 1992 y entró en vigor en 1994 |
| E14 | Suiza | «miembro de la EFTA (junto a Islandia, Dinamarca y Liechtenstein)» | Con Islandia, Noruega y Liechtenstein; paquete firmado el 2/3/2026 |
| E15 | Asociación Oriental | Acuerdos de asociación con «Georgia, Moldavia, Bielorrusia y Armenia» | DCFTA con Georgia, Moldavia y Ucrania; Bielorrusia no tiene acuerdo y Armenia tiene uno de asociación global sin preferencias |
| E16 | Reino Unido | «En abril de 2021 el Parlamento ratifica… (entrada en vigor definitiva). Posteriormente, el Consejo adoptó la decisión de celebración, lo que implica que el Parlamento no está plenamente ratificado» | Aplicación provisional desde el 1/1/2021; en vigor el 1/5/2021 tras la aprobación del PE y la celebración del Consejo; es solo UE |
| E17 | Japón | «exportan cada año a Japón más de 28 millones de euros en bienes y 58 millones en servicios» | Son miles de millones: 65.700 millones en bienes en 2025 |
| E18 | Mercosur | «Pendiente de ratificación… se ha votado en contra en… Brasil» | Firmado el 17/1/2026; acuerdo interino en aplicación provisional desde el 1/5/2026; Brasil y los demás socios lo han ratificado; el de asociación espera el dictamen 1/26 |
| E19 | México | «con un nuevo acuerdo en 2018» | Acuerdo de principio en 2018, cerrado en enero de 2025 y firmado el 22/5/2026 |
| E20 | China | «China ha desplazado a Estados Unidos como el mayor socio comercial de la UE en 2020» | Fue así en 2020; en 2025 EE. UU. vuelve a ser el primero (912.000 millones de comercio de bienes frente a 774.000) |
| E21 | Oceanía | «EPA con Papúa Nueva Guinea y Fiji, negocia con otros 14» | Se han adherido Samoa (2018) y las Islas Salomón (2020) |
| E22 | África | Acuerdos de partenariado con «Nigeria, Costa de Marfil, Senegal, Ghana y Burkina Faso»; «Kenia y Ruanda»; «Sudáfrica… 90 %» | Solo los AAE provisionales de Costa de Marfil y Ghana (el regional de África Occidental no lo ha firmado Nigeria); Kenia (bilateral, 2024); Sudáfrica, dentro del AAE con la SADC (2016) |
| E23 | ACP | «El marco general es el Acuerdo de Cotonú… 79 países» | Lo sustituyó el Acuerdo de Samoa (firmado en 2023, provisional desde 2024); se remite al 3.B.42 |
| E24 | Conclusión | «primer exportador e importador del mundo» | Corregido como en E2 |

## 3. Marcas resueltas

| Marca | Texto original | Qué se ha hecho |
|---|---|---|
| 4 notas al opositor (inicio) | Aviso del cambio de temario de 2023, «Está copiado todo lo del tema de Juan Luis…», «coordinarlo con el tema de Sahuquillo», «De momento estudiarlo por aquí» | Desaparecen (notas de trabajo). El tema se ha redactado de nuevo; no se nombra a ningún preparador |
| Enlaces sueltos de la introducción | eldiario.es (reforma del Reglamento de cumplimiento) y ec.europa.eu/trade («EU position in world trade») | Conservados en la caja «Para saber más» del anexo A, con los demás enlaces del tema anterior |
| 19 imágenes | Infografías del Consejo, diagrama de Euler de Wikipedia, gráfico de Statista del Brexit, mapa de acuerdos de 2021, cuadros de cálculo de impuestos | Sustituidas por gráficos y figuras propios con datos de 2025-2026; sus enlaces, en la caja del anexo A |
| Notas al pie 26, 36 y 37 (YouTube, Wikipedia, IISD) | Fuentes de Suiza y del CETA | Enlaces en la caja del anexo A; el contenido de las notas (halloumi chipriota, ratificaciones) en el anexo A |
| Conclusión: «Relevancia» vacía; extensiones que repetían la estrategia de 2021 | — | Reescrita con sus 5 bloques |
| Anexo 1 (división de competencias) | Tabla larga del TFUE | Se conserva como anexo C, compacta |
| Bibliografía | Tema ICEX-CECO, tema de un preparador, Camarero, Tamarit y Anchuelo (2019), web del Consejo | Los temas de preparadores no se citan; Camarero y otros se mantiene (B41-06); la web del Consejo, en la caja del anexo A |

## 4. Datos actualizados

Todos consultados el 14/11/2026; los detalles, en `datos-actualizables.yaml` (13 entradas).

| Dato | Antes | Ahora | Fuente | Segunda comprobación |
|---|---|---|---|---|
| Comercio extra-UE de bienes por socio | 2019-2021, sin cifras | 2025: 2.648/2.542 mm€; EE. UU. 555/358; China 199/574 | Eurostat, ext_lt_maineu (13/11/2026) | Saldos con China (−374,95) y EE. UU. (+196,9) = suma de los 12 meses de ext_st_eu27_2020sitc |
| Comercio de servicios por socio | — | 2025: 1.581/1.427 mm€; EE. UU. 343/522 | Eurostat, bop_its6_det | Suma de socios < total extra-UE |
| España fuera de la UE | — | 38,2 % de las exportaciones de bienes; 43,9 % de las importaciones | Eurostat, ext_lt_intratrd | 151 mm€ = 38,2 % de 394 mm€ |
| Arancel medio de la UE | ~4 % | 5,0 % (10,5 / 4,1); ponderado 2,8 % (2024) | OMC, World Tariff Profiles 2025 | 3.B.33 (5 %); el perfil TTD de la OMC da 4,3 % para 2026 (otra base) |
| Defensa comercial | — | 232 medidas en vigor (fin de 2025); 33 y 32 investigaciones (2024, 2025) | COM(2026) 475 | Serie de la OMC: 32 en 2024 y 32 en 2025 |
| Red de acuerdos | — | 44 acuerdos, 76 socios, 46,3 % (→ 53,3 %) | COM(2026) 506 | Nota de prensa de la Comisión: «45 acuerdos, 80 socios» contando el Mercosur |
| Mercosur | «pendiente de ratificación» | Firma 17/1/2026; interino 1/5/2026; dictamen 1/26 pendiente | Comisión; PE | 3.B.35 (mismas fechas) |
| EE. UU. | Aranceles de 2018 y tregua | Techo del 15 %; rebajas de la UE desde 1/7/2026; contramedidas suspendidas sin fecha | Comisión (declaración conjunta; contramedidas) | 3.B.33 (IEEPA, s. 122 y s. 301) |
| Acero | Salvaguardia | Reglamento 2026/1384: 18,3 Mt (−47 %), 50 % | Comisión (Access2Markets) | 3.B.33 (propuesta de 2025) |
| SPG | 978/2012 | Reglamento 2026/1395 (2027-2036); 8 países en SPG+ | Comisión (Access2Markets y DG Comercio) | Informe conjunto SPG 2023-2025 (prensa) |
| VE chinos | — | 7,8-35,3 % (Reg. 2024/2754); primer compromiso de precios (feb. 2026) | Comisión | COM(2026) 475 |
| MAFC, deforestación, diligencia debida | — | 2025/2083, 2025/2650, 2026/470 | Comisión; EUR-Lex | 3.A.23 y 3.B.31 (MAFC) |
| Rusia | 4.º socio (2021) | 19.º (2025); 21 paquetes (julio de 2026); gas fuera en 2027 | SEAE; EUR-Lex; Eurostat | Prensa (22.º paquete en octubre: no confirmado) |

## 5. Contenido añadido

- **Modelo de la sola voz** (Meunier, 2005, cap. 2, leído del disco D:): conjunto ganador, pivote y manos atadas (Schelling, con su nota de Nobel), con los 4 casos del libro como evidencia y el Mercosur como ejemplo de 2026.
- **Modelo de la colusión inducida** (Prusa, 1992) adaptado al compromiso de precios de la UE (el de los VE chinos, 2026), con ejemplo numérico propio; evidencia de Prusa (2001) y Konings, Vandenbussche y Springael (2001).
- **Modelo de la negociación con la solución de Nash** (nota de Nobel de Nash), con 3 puntos de desacuerdo y la lectura del acuerdo de 2025 y del Instrumento Anticoerción.
- **Marco jurídico al día**: dictámenes 1/75, 1/94 y 2/15, Niza y Lisboa, nueva arquitectura de 2018 (acuerdos solo UE e interinos), art. 207.4 y art. 218.11, con la figura del procedimiento.
- **Estrategia**: Europa Global, Comercio para todos, revisión de 2021, seguridad económica de 2023 y 2025, Consejo Europeo de octubre de 2026.
- **Instrumentos nuevos** (tabla): Anticoerción, Contratación Pública Internacional, subvenciones extranjeras, control de inversiones, doble uso, MAFC, deforestación, diligencia debida, trabajo forzoso; reforma aduanera y comercio electrónico.
- **Red de acuerdos** por generaciones, capítulos de desarrollo sostenible (revisión de 2022), efectos (cobertura y evidencia de gravedad), tabla de acuerdos pendientes (Mercosur, México, India, Indonesia, Australia, Suiza, ASEAN, EAU, China).
- **Material del disco D: usado**: la versión de 2023 («Temas a imprimir\11. Unión Europea\Tema 3.B.43 - v.2023.pdf») y la de 2024 («Mis temas\Tema 3.B.43 - v.2 - 2024.docx»), con el mismo contenido que el Word de partida (comparadas por párrafos: solo cambian el formato y la numeración de algunas remisiones); Meunier, *Trading Voices* (introducción y cap. 2), base del primer modelo. *Common Commercial Policy after Lisbon* solo se hojeó (no se cita). Los temas de otros preparadores no se usaron.

## 6. Coherencia

- **3.B.33**: aranceles de EE. UU. (IEEPA, s. 122 y s. 301, techo del 15 %), art. XXIV y cláusula de habilitación, plurilaterales (ACP 22/49, ATI 84), MPIA (62), DS630 y DS639 con las mismas cifras. El 3.B.33 dice que la sustitución de la salvaguardia del acero estaba «propuesta»: ya está adoptada (anotado en `_trabajo/canon-pendiente.md`).
- **3.B.34**: servicios, ADPIC y contratación pública solo se mencionan y se remiten.
- **3.B.35**: Mercosur con las mismas fechas (firma 17/1/2026; interino 1/5/2026; dictamen pendiente). El 3.B.35 dice que la UE «ha cerrado la negociación de otros (México, Indonesia)»; ya hay más (anotado).
- **3.B.36**: competencias, procedimientos y dictamen 2/15 aquí desarrollados; el 3.B.36 remite aquí.
- **3.B.39**: Código Aduanero 2026/2108 «de forma gradual desde septiembre de 2026», control de inversiones 2026/1386 «desde enero de 2028» y Autoridad Aduanera en Lille, como en el 3.B.39.
- **3.B.21**: dice «la UE ha firmado con Mercosur en diciembre de 2024» (fue el cierre de la negociación): anotado en canon-pendiente; no se toca.
- **3.B.42** (en revisión a la vez): frontera aplicada como pide el encargo: aquí el SPG como instrumento, los acuerdos comerciales y su parte comercial; allí ACP/Samoa, vecindad, ayuda al desarrollo y Global Gateway, con `\vertema{3.B.42}`. El agente del 3.B.42 había creado ya entradas `Eurostat2026Socios` y `TJUE2017Dictamen215` en su `.bib`; aquí se usan las propias, con la misma clave (conviene unificarlas al cerrar los 2 temas).
- **4.º ejercicio**: `\vertema{4.A.22}` (estructura geográfica del comercio español), `4.A.24` y `4.A.25` (internacionalización y promoción), `4.A.27` (adhesión), `4.B.14` (federalismo fiscal, en la asignación de competencias).
- **Canon**: 3 fichas de modelos nuevas propuestas en `_trabajo/canon-pendiente.md`.

## Reglas vigentes aplicadas (14/11/2026)

| Regla | Cómo se ha aplicado |
|---|---|
| Estructura rígida de modelo | Los 3 modelos con a) Idea, b) Modelo (i-iii), c) Extensiones, d) Evidencia empírica, e) Valoración |
| Sin citas Harvard | Solo `\nocite` y `\textcite` de obras originales |
| Nunca citar a Víctor | Ninguna entrada suya; gráficos «elaboración propia» |
| Ni «Pegatina» ni «Dicho» | Solo el refrán del enganche, integrado y retomado en la III.4.2 y en la idea final; el original no tenía refrán (abría con una cita de Monnet, que se quita: ya la usa el 3.B.36 en su contexto) |
| Nobel con motivo oficial | Schelling (2005) y Nash (1994), en su primera mención |
| `\vertema` al 4.º ejercicio | 4.A.22, 4.A.24, 4.A.25, 4.A.27, 4.B.14 |
| Resultados clave en morado | `eq:meunier`, `eq:reaccion`, `eq:nash` con `\funcionclave` |
| Pasos con sangría | Desarrollos por pasos en sublistas |
| Cajas grises | Notación; servicios por socio; grandes acuerdos; «Para saber más»; algunos detalles del tribunal |
| Ejemplos sin nombres propios | Sí |
| Inglés entre paréntesis | *trade deflection*, *win-set*, *EU-only*, *Global Europe*, *Trade for All*, *Enforcement Regulation*, *melt and pour*, *level playing field*, *de-risking* |
| Anexo de test | Caja estándar con `tema=3.B.41` |
| Sin páginas en blanco ni desbordes | 0 líneas desbordadas; páginas revisadas a ojo |

## 7. Dudas abiertas

Todas aplicadas con la opción recomendada (14/11/2026); para que Víctor las confirme.

- **B41-01** (14/11/2026) Estructura. El título solo dice «la política comercial de la UE». Opciones: (a) mantener los 3 bloques del original (bases; autónoma; convencional) y añadir I.5 (estrategia) y II.4 (instrumentos nuevos) **[aplicada]**; (b) un bloque propio de «seguridad económica».
- **B41-02** (14/11/2026) Refrán. Opciones: (a) «Donde las dan, las toman», con el pacto de 2025 y el modelo de negociación **[aplicada]**; (b) «La unión hace la fuerza» (ya lo usa el 3.A.11).
- **B41-03** (14/11/2026) Datos solo de prensa o de fuente secundaria: el recuento de ratificaciones del CETA (17/27, Euronews y Parlamento de Canadá, agosto de 2025), la aprobación del acuerdo interino con México por el Consejo en julio de 2026 y la votación del PE, el 22.º paquete de sanciones a Rusia (octubre de 2026, no se cita), los detalles del primer compromiso de precios de los VE (febrero de 2026) y el informe del SPG 2023-2025. Opciones: (a) usarlos con la cautela del texto **[aplicada]**; (b) quitarlos.
- **B41-04** (14/11/2026) El Instrumento Anticoerción: no consta que se haya activado hasta noviembre de 2026 (la búsqueda de septiembre-noviembre no fue exhaustiva). Se dice «no se ha activado nunca». Revisar al publicar.
- **B41-05** (14/11/2026) El informe anual de defensa comercial (COM(2026) 475) se cita por la copia del Parlamento rumano (cdep.ro), que es la que se leyó; la de EUR-Lex será CELEX 52026DC0475. Opciones: (a) así **[aplicada]**; (b) cambiar la URL cuando EUR-Lex la publique.
- **B41-06** (14/11/2026) Camarero, Tamarit y Anchuelo (2019), que citaba el tema anterior, no se ha podido leer (estaba en una biblioteca en línea con acceso). Opciones: (a) mantenerla en la caja «Para saber más», como en el original **[aplicada]**; (b) quitarla.
- **B41-07** (14/11/2026) Enlaces del Consejo (infografías y página de acuerdos) e IISD devuelven 403 a las peticiones automáticas, pero existen. Se conservan.
- **B41-08** (14/11/2026) El gráfico de defensa comercial usa la serie de la OMC (por fecha de notificación) y no la de la Comisión (no hay serie publicada en un solo sitio): las cifras de 2024 difieren en 1 (32 frente a 33). Se explica en la fuente del gráfico.

- **B41-09** (19/11/2026) Estructura común de las políticas de la UE. Opciones: (a) mantener los 3 bloques y encajar los elementos: I.1 relevancia; I.2 teoría; I.3 delimitación de competencias (sube por delante del marco jurídico); I.4 marco jurídico y toma de decisiones; I.5 evolución (Tratados y estrategia); II y III, la articulación; III.5 (nuevo), retos de futuro **[aplicada]**; (b) los retos en la conclusión, sin subapartado propio; (c) un bloque IV de retos (lo impide la regla de los 3 apartados).
- **B41-10** (19/11/2026) Gráfico 3 (aranceles). Opciones: (a) conservar el gráfico por grupos de productos (OMC, 2024) y añadir uno nuevo de evolución 1988-2022 (Banco Mundial, WDI: NMF y aplicado, media simple y ponderada) con la explicación de las 2 medias **[aplicada]**; (b) fundir los 2 en un solo gráfico de 2 paneles. La serie del Banco Mundial acaba en 2022; el dato de la OMC de 2024 (5,0 y 2,8 %) se da en el texto y en la fuente.
- **B41-11** (19/11/2026) Envíos de escaso valor: la consulta TARIC del 19/11/2026 muestra el derecho de 3 euros (Reglamento 2026/382) y la tasa de gestión de 2 euros con inicio el 1/11/2026, mientras el texto (II.1.3) dice que el derecho de 3 euros se paga desde el 1/7/2026. Puede ser que la medida se recodificara en noviembre. Opciones: (a) dejar el texto como está y comprobarlo en el reglamento **[aplicada]**; (b) cambiar la fecha al 1/11/2026.
- **B41-12** (19/11/2026) Colores del mapa de acuerdos (clasificación propia). Opciones: (a) EEE y Suiza; unión aduanera; asociación y vecindad (Balcanes, DCFTA y euromediterráneos); ALC de nueva generación (con el Reino Unido, el Mercosur interino, Chile, Andinos y Centroamérica); ALC de primera generación (México y Feroe); AAE con los ACP; trama verde para los cerrados o firmados pendientes (Australia, India, Indonesia y el México modernizado) y trama gris para los que se negocian **[aplicada]**; (b) los DCFTA como nueva generación; (c) separar los euromediterráneos como primera generación.

## 8. Instrucciones para el vídeo

- **Enganche e idea final**: «Donde las dan, las toman»; el arancel del 20 % anunciado el 2/4/2025, las contramedidas de 93.000 millones que no se aplicaron y el pacto del 15 %; y los acuerdos de 2026. Pregunta: ¿cómo defiende sus intereses una potencia comercial que vive de la apertura cuando vuelven las represalias? La idea final la responde con el modelo de la negociación: la amenaza solo pesa si es creíble y si hay alternativas.
- **Introducción y conclusión, sin pizarra** (`modo: guion`); el gráfico de los socios y la cronología, como apoyo.
- **Mapa de la exposición** (figura 1, caja gris): como apoyo al final de la estructura de la introducción; no se dibuja.
- **I.2**: la sola voz se cuenta de palabra (pivote, unanimidad frente a mayoría); el modelo, su gráfico y `eq:meunier` están en el anexo A (desde el 19/11/2026), para las preguntas del tribunal.
- **I.3**: el diagrama de competencias del anexo B, como apoyo.
- **I.4**: la figura del procedimiento, como apoyo (no se dibuja); en la pizarra, solo la cadena «Comisión → Consejo → Comisión (CPC) → Consejo → PE → Consejo (+27)».
- **II.1, imprescindible**: el código TARIC de la bicicleta en la pizarra, de arriba abajo (87 → 8712 → 8712 00 → 8712 00 30 → 8712 00 30 90 → código adicional), con lo que paga según el origen (China 14 + 48,5 %; Indonesia; Vietnam 0 %). El gráfico de la evolución del arancel (media simple y ponderada) como apoyo, diciendo por qué la ponderada infravalora la protección.
- **II.2**: el gráfico de defensa comercial, como apoyo; la colusión inducida (Prusa) de palabra (el modelo y su gráfico, en el anexo C).
- **II.4**: la tabla de instrumentos (ahora en caja gris), como apoyo; de palabra, Anticoerción y MAFC.
- **III.2, imprescindible**: el mapa de acuerdos como apoyo, y la red se canta por grupos (Europa, Reino Unido, América, Asia y Oceanía, ACP y Mediterráneo) con los grandes acuerdos; la escalera de preferencias en la pizarra, de abajo arriba.
- **III.4**: la negociación de Nash de palabra (punto de desacuerdo; 15 % frente a 0; valor de la amenaza); el modelo y su gráfico, en el anexo F.
- **III.5**: los 5 retos, de palabra, en una lista corta.
- Nunca se dice el número de un tema en voz alta.

**Reparto del cante** (nota que iba tras el esquema del tema; quitada del tema el 19/11/2026 a petición de Víctor, se conserva aquí para el vídeo):

> Reparto del cante (al día el 19/11/2026): introducción, \tiempo{2,5}; I, \tiempo{7} (I.1, \tiempo{0,5}; I.2, \tiempo{1,5}, con la sola voz de palabra; I.3, \tiempo{1}; I.4, \tiempo{2}; I.5, \tiempo{2}); II, \tiempo{9,5} (II.1, \tiempo{2,5}, con el TARIC y las 2 medias; II.2, \tiempo{3}; II.3, \tiempo{1,5}; II.4, \tiempo{2,5}); III, \tiempo{10} (III.1, \tiempo{1}; III.2, \tiempo{5}; III.3, \tiempo{1}; III.4, \tiempo{2}; III.5, \tiempo{1}), y conclusión, \tiempo{1}. Los 3 modelos se cuentan de palabra y sus gráficos quedan en los anexos. Las figuras imprescindibles son la del procedimiento de los acuerdos y la escalera de preferencias, y los gráficos, el mapa de acuerdos y la evolución del arancel. La red de acuerdos se canta por grupos y con sus grandes acuerdos; el detalle de cada uno, en el anexo D.

## Listas en las notas al pie (15/11/2026)

Ninguna nota lo necesitaba.

## Refranes únicos (15/11/2026)

Regla de Víctor: un refrán o dicho no se repite en temas distintos.

- Quitado «la unión hace la fuerza» (poder de negociación de la UE): es el refrán inicial del 3.A.11. Ahora «la intuición de que juntos se negocia mejor». «Donde las dan, las toman» queda solo aquí (se quita como nombre del *tit for tat* en el 3.A.14 y el 3.A.19).

- Corrección (15/11/2026): Víctor aclara que lo único que no puede repetirse es el **refrán inicial** de cada tema; en el resto del cuerpo los refranes pueden repetirse. Se deshacen los cambios de la sección «Refranes únicos» de arriba: el texto vuelve a como estaba.

## Comentarios de Víctor (19/11/2026)

PDF antes: 30 páginas de tema, 3 de anexos y 5 de bibliografía (38). Después: 28 + 11 + 6 (45). Ficha de repaso: 4 páginas a 10,5 pt (última, 98 %). `verificar-tema.py`: 0 errores.

1. «El modelo de Meunier a anexos»: nuevo anexo A (`anexo:meunier`) con la estructura a)-e) completa, su gráfico y `eq:meunier`; en el cuerpo (I.2.3) queda la idea en 3 viñetas (las 3 variables, el Estado pivote y lo que explica) y la remisión.
2. Mapa de la exposición tras la introducción: figura 1 (`graficos/mapa-tema.tex`, con la forma del mapa del 3.B.4), en caja gris tras el esquema: la pregunta de cada bloque, el elemento de la estructura común de la UE que cubre, 2 cajas de contenido por bloque y el hilo entre bloques, del enganche a la idea final.
3. Gráfico 3 (aranceles): se conserva el gráfico por grupos de productos (ahora gráfico 2) y se añade el gráfico 3, la evolución 1988-2022 de la media simple y la ponderada del arancel NMF y del aplicado con preferencias (Banco Mundial, WDI: TM.TAX.MRCH.SM/WM.FN/AR.ZS de la UE, consultado el 19/11/2026; `datos/aranceles-evolucion.csv`). En el texto (II.1.1), qué mide cada media y por qué la ponderada infravalora la protección (lo que tiene arancel alto se importa poco; un arancel prohibitivo pesa cero), la arancelización de 1995 y la distancia creciente entre las 2. Segunda comprobación: OMC 2024 (5,0 y 2,8 %) frente a 5,2 y 2,7 % de 2022 en el Banco Mundial (B41-10).
4. «El modelo del II.2.6 a anexos con una referencia en el cuerpo»: anexo C (`anexo:prusa`) con el modelo completo, el ejemplo numérico y su gráfico; en el cuerpo, II.2.6 «Los efectos del antidumping: ¿a quién protege?», con la idea, la evidencia y la remisión. La nota del Nobel de Nash pasa a su primera mención en el cuerpo (III.4.2).
5. «La tabla 1 a una caja gris»: la tabla de los nuevos instrumentos va en `tablacaja` dentro de `anotaciones` (ahora tabla 2, porque la tabla 1 es la del TARIC); en el cuerpo quedan las 2 familias de instrumentos en viñetas.
6. TARIC: nuevo II.1.2 «La nomenclatura: del Sistema Armonizado al TARIC», con la estructura del código (2, 4, 6, 8 y 10 dígitos y códigos adicionales) en viñetas y la tabla 1 con la bicicleta de cojinetes de bolas (87 → 8712 → 8712 00 → 8712 00 30 → 8712 00 30 10/20/90 → B999). Comprobado en la consulta TARIC de la Comisión con fecha de referencia 19/11/2026: derecho de terceros países del 14 %; China, antidumping definitivo del 48,5 % (Reglamento de Ejecución 2025/2146, desde el 24/10/2025); Indonesia, SPG del 10,5 % y antidumping extendido por elusión (el motivo de la subpartida TARIC «10»); Vietnam, 0 % (ALC); envíos de escaso valor, 3 € + 2 €. La descripción del capítulo 87 y de la partida 8712 es la del árbol de la nomenclatura del TARIC.
7. Mapa de la red de acuerdos: gráfico 5 (`graficos/mapa-acuerdos.tex`), generado por `datos/mapa-acuerdos.py` con el método del 3.B.35 (Natural Earth 1:50m, proyección Equal Earth) a partir de `datos/mapa-acuerdos.csv`, con la situación de la página «Negotiations and agreements» de la Comisión consultada el 19/11/2026: 7 colores por tipo de acuerdo y 2 tramas (pendientes y en negociación); leyenda bajo el mapa. Clasificación en B41-12.
8. «El modelo de III.4.2 a anexos»: anexo F (`anexo:nash`) con el modelo completo, `eq:nash` y su gráfico; en el cuerpo, la idea (punto de desacuerdo), lo que explica (el 15 % frente a 0, el valor de la amenaza, Reino Unido 10 %) y su límite, con la remisión.
9. Red de acuerdos en vigor (III.2.2): ampliada con subtítulos (`\paragraph`): Europa (EEE, Suiza, uniones aduaneras, Balcanes y DCFTA), el Reino Unido (el ACC, como uno más; desaparece el III.2.3 aparte), América (CETA, Mercosur, México, Chile, Andinos y Centroamérica), Asia y Oceanía (Corea, Japón, Singapur, Vietnam, Nueva Zelanda) y África, Caribe, Pacífico y Mediterráneo. Cada gran acuerdo con fecha, tipo, contenido clave y efecto cuando la Comisión lo cuantifica (CETA +71 %; Nueva Zelanda, 140 M€ de derechos al año; Japón, 70.000 M€ de exportaciones de bienes). Comprobado el 19/11/2026 en las páginas de la Comisión: CETA con 18 de 27 ratificaciones (faltan 9, que se nombran; antes decía 17/27 con una fuente de prensa); Singapur con acuerdo digital en vigor desde el 1/2/2026; Corea con acuerdo digital firmado el 10/6/2026; Chile interino desde el 1/2/2025; Mercosur interino desde el 1/5/2026 (sale de III.3 y pasa aquí; en III.3 queda en la tabla). Se quita la caja «Algunos detalles que pregunta el tribunal» del anexo D, porque su contenido está ahora en el cuerpo.
10. Estructura común de las políticas de la UE: relevancia (I.1), justificación con teoría (I.2), delimitación de competencias (I.3, sube por delante del marco jurídico y recoge la antigua «Delimitación»), marco jurídico y toma de decisiones (I.4: base jurídica y objetivos, dictamen 2/15, procedimiento, OMC), evolución (I.5: el alcance de Roma a Lisboa, con la cronología, y la estrategia), articulación (II y III) y retos de futuro (III.5, nuevo: OMC, Estados Unidos, China, ratificación, sostenibilidad). La introducción (estructura) lo anuncia (B41-09).
- Anexo de competencias: `_trabajo/anexo-competencias.tex` sustituye al anexo con la tabla `tab:competencias` (misma etiqueta `anexo:competencias`, ahora anexo B, con la figura `competencias-ue`); la tabla no aportaba nada que no esté en el diagrama. Remisión desde I.3.
- Minutos: I 8 → 7; II 10 → 9,5; III 8,5 → 10 (suman 30). Reparto al día en «Instrucciones para el vídeo».
- Anexos, en el orden en que se citan: A sola voz, B competencias, C colusión inducida, D acuerdos por regiones, E Reino Unido, F negociación de Nash, G test.
- Ficha de repaso al día: esquema y minutos, los 3 modelos en una línea cada uno, simple frente a ponderada, TARIC con la bicicleta, red de acuerdos por grupos, retos, 2 preguntas nuevas del tribunal; gráficos de la evolución del arancel y del mapa en lugar de los 3 de los modelos.
- Otros: `seo.json` (TARIC y red de acuerdos), `datos-actualizables.yaml` (3 entradas nuevas y el CETA), 9 entradas nuevas en el `.bib` (Banco Mundial, TARIC, Natural Earth y 6 páginas de la Comisión).
