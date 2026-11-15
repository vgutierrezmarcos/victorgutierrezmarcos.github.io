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

## 8. Instrucciones para el vídeo

- **Enganche e idea final**: «Donde las dan, las toman»; el arancel del 20 % anunciado el 2/4/2025, las contramedidas de 93.000 millones que no se aplicaron y el pacto del 15 %; y los acuerdos de 2026. Pregunta: ¿cómo defiende sus intereses una potencia comercial que vive de la apertura cuando vuelven las represalias? La idea final la responde con el modelo de la negociación: la amenaza solo pesa si es creíble y si hay alternativas.
- **Introducción y conclusión, sin pizarra** (`modo: guion`); el gráfico de los socios y la cronología, como apoyo.
- **I.2, imprescindible**: el modelo de la sola voz en la pizarra por capas (eje; statu quo y socio; Estados; llave de la unanimidad y $U$; llave de la mayoría y $M$, con la flecha del socio). La función clave `eq:meunier` recuadrada.
- **I.3**: la figura del procedimiento, como apoyo (no se dibuja); en la pizarra, solo la cadena «Comisión → Consejo → Comisión (CPC) → Consejo → PE → Consejo (+27)».
- **II.2, imprescindible**: el compromiso de precios en la pizarra por capas (ejes; $R_D$; $R_F$ y $N$; isobeneficios y lente; precio mínimo y $C$). `eq:reaccion` recuadrada. El gráfico de defensa comercial, como apoyo.
- **II.4**: la tabla de instrumentos, como apoyo; de palabra, Anticoerción y MAFC.
- **III.2**: la escalera de preferencias en la pizarra, de abajo arriba, de palabra con los ejemplos; las generaciones, en una línea de tiempo corta.
- **III.4, imprescindible**: la negociación de Nash por capas (ejes; frontera; $d$ y $N$; $d'$ y $N'$; $d''$ y $N''$). `eq:nash` recuadrada y conservada (`conservar:`) hasta la idea final, que vuelve a ella. Las 3 funciones clave se dejan en la esquina de la rejilla entre bloques.
- Nunca se dice el número de un tema en voz alta.

## Listas en las notas al pie (15/11/2026)

Ninguna nota lo necesitaba.
