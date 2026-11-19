# Revisión del 3.B.36 — Tratados, orden jurídico e instituciones de la Unión Europea

Revisión completa del 14/11/2026 (entrega 1: tema y ficha de repaso; sin vídeo), en el worktree `revision-temario-2`, en paralelo con los agentes de los 3.B.34 y 3.B.35. Fuente nueva en LaTeX (`3B36.tex`) a partir del Word original (`_trabajo/original.md`, el antiguo 3.B.37 de la versión de agosto de 2023), **redactada de nuevo** y puesta al día a noviembre de 2026 con fuentes oficiales (EUR-Lex, consilium, europarl, curia, Comisión, BCE). Las dudas se resuelven con la opción recomendada y se anotan como B36-NN (14/11/2026).

## 1. Resumen

- Tema completo con los 3 bloques del original y sus títulos de segundo nivel: **I. Los tratados: de París a Lisboa** (I.1 antecedentes; I.2 origen y expansión; I.3 crisis; I.4 relanzamiento; I.5 de la Comunidad a la Unión; I.6 base actual: Lisboa, Brexit y ampliación), **II. El ordenamiento jurídico** (II.1 bases; II.2 competencias y principios; II.3 aprobación de la legislación) y **III. Las instituciones** (III.1 Comisión … III.8 otros órganos y organismos). Reparto: introducción 2′30″, I 8′, II 9′, III 9′30″, conclusión 1′. Se acorta el peso de la historia (comentario del original: «demasiado recorrido histórico») y se da más al Derecho y a las instituciones.
- 2 modelos nuevos con la estructura rígida a)-e): la **asignación de competencias** (teorema de Oates aplicado a la subsidiariedad, con un modelo propio de 2 Estados: centralizar si $e>\Delta/2$; extensiones de Alesina, Angeloni y Etro, Alesina y Spolaore, Tiebout; evidencia de Alesina, Angeloni y Schuknecht, 2005) y el **poder de voto en el Consejo** (Shapley-Shubik y Banzhaf con la doble mayoría, **calculados de forma exacta para los 27** con la población oficial de 2026; probabilidad de aprobar 13,2 %). Las teorías de la integración (Haas, Moravcsik, Hooghe y Marks), en caja gris.
- 11 gráficos y figuras propios en TikZ/pgfplots: 5 de datos (ampliaciones y tratados 1952-2026; actos legislativos, delegados y de ejecución 2010-2025; escaños por Estado y habitantes por escaño; grupos del PE; poder de voto frente a población), 2 teóricos (Oates; regla de asignación) y 4 figuras (pilares → Lisboa; procedimiento legislativo ordinario; mapa de instituciones; Europa de geometría variable), que sustituyen a las 30 imágenes del Word (capturas de Wikipedia, El Orden Mundial, Baldwin y Wyplosz, El-Agraa, Flickr del PE, logos). 5 tablas (jurisprudencia, actos jurídicos, competencias, Estados miembros, índices de poder).
- PDF: 34 páginas de tema, 2 de anexos y 3 de bibliografía (39). Ficha de repaso de 4 páginas a 9,5 pt (última, 87 %). `verificar-tema.py` (sobre `_trabajo/`, con el envoltorio que apunta allí porque con `--no-publicar` no se copian a `tercer-ejercicio/`): sin errores propios; quedan avisos de «cifra sin cita» (párrafos históricos o cuya cita va en el gráfico) y los del vídeo (entrega 3). Las «imágenes inexistentes en el HTML» son un efecto de verificar en `_trabajo/` (rutas relativas).

## 2. Errores corregidos

| Id | Dónde (Word) | Decía | Dice ahora |
|---|---|---|---|
| E1 | Crisis, serpiente | Declaración de Nixon «en agosto de 1970» | Agosto de 1971 |
| E2 | Tribunal de Cuentas | «Creado en 1975 y reconocido como institución por el Tratado de Lisboa en 2009» (y en Maastricht «se convierte en la quinta institución») | Creado por el Tratado de Bruselas de 1975, funciona desde 1977 e **institución desde Maastricht** |
| E3 | Tabla de fuentes | Tratado de fusión «Bruselas, 08/04/1964» | 8 de abril de 1965 (en vigor el 1/7/1967) |
| E4 | Niza | Establece «el sistema de doble mayoría» | Niza fijó una **triple mayoría** (votos ponderados, mayoría de Estados y verificación del 62 %); la doble mayoría es de Lisboa, aplicada desde el 1/11/2014 |
| E5 | Cooperación reforzada | «Basta con 8 Estados» (como regla vigente) | 8 era Niza; desde Lisboa, al menos **9** (art. 20 TUE) |
| E6 | TJUE | Tribunal General con «competencia exclusiva sobre cuestiones prejudiciales» y un «Tribunal de la Función Pública» vigente | El Tribunal General juzga los recursos directos de particulares y, desde el 1/10/2024, las prejudiciales de 6 ámbitos técnicos; el Tribunal de la Función Pública se suprimió en 2016 |
| E7 | TJUE | Gran Sala de 13 jueces; «creado en 1958» | Gran Sala de **15**; nace con la CECA (1952); Tribunal General de 54 jueces |
| E8 | Comisión | «8 vicepresidentes, incluidos 3 ejecutivos» y Borrell como AR | Colegio Von der Leyen II (1/12/2024): 6 vicepresidentes ejecutivos; AR Kaja Kallas |
| E9 | Parlamento | 705 diputados (46 en reserva); presidenta «a 11/08/2023» | 720 (2024-2029); Metsola reelegida en julio de 2024 |
| E10 | Parlamento | Censura «por mayoría de ⅔» | ⅔ de los votos emitidos que sean mayoría de los miembros |
| E11 | Consejo Europeo | «Fue creado en 1961» (y en I «se crea en 1975») | Cumbres desde 1961, institucionalizado en 1974 (1.ª reunión, 1975), en los Tratados con el Acta Única, institución desde Lisboa; presidente Costa (no Michel) |
| E12 | Consejo, nota 45 | «El Comité Económico y Financiero es un comité dependiente del Eurogrupo» | Se quita: el CEF es un comité del Consejo (art. 134 TFUE) |
| E13 | Consejo | Mayoría cualificada con «más del 65 %» y sin la regla del 72 % | «Al menos» el 65 %; 72 % de los Estados si la propuesta no es de la Comisión o la AR |
| E14 | Presidencias | «Actual (2023-2024): España-Bélgica-Hungría» | Chipre (enero-junio de 2026), Irlanda (julio-diciembre de 2026), Lituania y Grecia (2027) |
| E15 | Tabla de actos | La decisión, «acto no legislativo» | Es legislativa si se adopta por un procedimiento legislativo (art. 289 TFUE): lo legislativo lo da el procedimiento |
| E16 | Nota 29 | La norma nacional contraria «es nula» | El juez la **inaplica** (Simmenthal); la primacía no anula |
| E17 | Tribunal de Cuentas | Informes anuales «referidos al período t−2» | Al ejercicio anterior (t−1) |
| E18 | Introducción | UEM «para 20» de los Estados | 21 desde el 1/1/2026 (Bulgaria) |
| E19 | Introducción | El proceso «tiene su origen en el Tratado de Roma en 1957» | En el Tratado de París (1951) |
| E20 | Título de I.6 | Croacia, 2014 | 1 de julio de 2013 |
| E21 | BCE | Vicepresidente De Guindos; Eurogrupo: Donohoe | Vujčić desde el 1/6/2026; Pierrakakis desde el 12/12/2025 |
| E22 | MEDE | «capacidad de préstamos de hasta 410.000 millones» | Capacidad de préstamo de 500.000 millones |
| E23 | Lisboa (nota 25) | «Solo requería referéndum en Irlanda» | Se añade que Irlanda lo rechazó en 2008 y lo aprobó en 2009 |
| E24 | Comisión | Funciones con «actos delegados por el Consejo» | Delegados (art. 290, por el legislador) frente a ejecución (art. 291, comitología, Reglamento 182/2011) |

## 3. Marcas resueltas

| Marca | Texto original | Qué se ha hecho |
|---|---|---|
| Notas al opositor (l. 1-14) | Aviso del cambio de temario de 2023 y captura | Desaparecen (aviso de trabajo) |
| Comentarios «copiado todo lo de Juan Luis…», «Estudiar por aquí» | — | No se publican (notas de trabajo; ningún preparador se nombra) |
| Amarillo «[Copiar y pegar del Excel cuando se haga un cambio]» (Imagen 2, línea temporal) | Imagen del Excel | Sustituida por el gráfico `ampliaciones` (datos en `datos/estados-miembros.csv`), que se actualiza con el CSV; el Excel del D: tenía errores (Grecia en 1985, Ámsterdam 1997 como entrada en vigor) |
| Comentario «IMPORTANTE MENCIONAR COMITÉS DE GESTIÓN» | — | Resuelto: comitología (procedimientos consultivo y de examen, comité de apelación) en II.1.3 |
| Comentario «IMPORTANTE MENCIONAR COREPER» | — | Resuelto: Coreper I y II y puntos «A» en III.3 |
| Comentario de un preparador («demasiado recorrido histórico…») | — | Aplicado: la historia se canta en 8′ (antes, más de la mitad) y se da más peso a II y III |
| Amarillo (conclusión, «Relevancia») | Párrafo copiado de un manual | Se reescribe la conclusión entera con sus 5 bloques |
| «Opinión» vacía | — | Escrita (ampliar con pasarelas, cooperación reforzada y salvaguardias) |
| Apartados vacíos («Funciones» del BCE; CESE, CdR, Eurogrupo, SEAE) | — | Escritos (III.7 y III.8) |
| Imágenes 1-10 y de los anexos | Capturas de terceros | Rehechas como figuras y gráficos TikZ propios o como tablas (anexo A) |
| Enlaces `file:///` y de Wikipedia | — | Se quitan; las fuentes son oficiales |
| Enlace de test | quia.com | Caja estándar del simulador (`tema=3.B.36`) |
| «Preguntas de otros exámenes» | Lista | Pasan a «Preguntas del tribunal» de la ficha (como en el 3.B.33) |
| Bibliografía del Word | Temas de J. L. Cordero Tarifa y de ICEX-CECO, Camarero et al., páginas de europa.eu | Los temas de preparadores no se citan; se citan los Tratados, el *ABC del Derecho* (Borchardt), Mangas y Liñán y las fuentes oficiales; los enlaces de europa.eu se sustituyen por las páginas vigentes |

## 4. Datos actualizados

Todos consultados el 14/11/2026.

| Dato | Antes | Ahora | Fuente | Segunda comprobación |
|---|---|---|---|---|
| Población para la mayoría cualificada | — | 452.162.974; umbral 293.905.933 (2026) | Decisión 2025/2427 (DO L, 27/11/2025) | Suma de las 27 cifras del CSV |
| Escaños del PE | 705 (2019) | 720; España 61 | Decisión 2023/2061 | Suma del CSV = 720 |
| Grupos del PE | 7 grupos (2019) | PPE 188, S&D 136, PfE 84, ECR 78, Renew 77, Verdes 53, Izquierda 46, ESN 25, NI 33 (16/7/2024) | Parlamento Europeo | SIEPS (julio de 2026) para la nota de 2026 (B36-05) |
| Actos por año | — | Serie 2010-2025 | EUR-Lex (estadísticas mensuales, vía el archivo de ghxm/eurlex-legal-acts-statistics, instantánea de 1/5/2026) | Picos de fin de legislatura conocidos (2014, 2019, 2024) |
| Índices de poder | — | Cálculo propio exacto (DP en miles de habitantes) | `datos/poder-voto.py` | Suma SS = 1; órdenes de magnitud iguales a la literatura (Alemania SS ≈ 17-18 %, Bz ≈ 12 %) |
| Ucrania y Moldavia | candidatas | Bloque 1 abierto en junio de 2026; bloques 2 y 3 en octubre | Consejo (12/6 y 13/10/2026) | Euronews, Euromaidan Press |
| Montenegro | — | 21 de 33 capítulos (oct. 2026) | European Western Balkans (13/10/2026) | Consejo (13/10/2026) |
| Reforma | — | PE 22/11/2023; Comisión, «Preparar una Unión más amplia» (6/10/2026) | europarl; enlargement.ec.europa.eu | Euronews, Steptoe |
| Hungría | — | Tisza gana (abril de 2026); levanta el veto; entra en la Fiscalía Europea (julio de 2026, 25 Estados) | eucrim; Comisión | Telex, Euronews |
| Fiscalía Europea | — | Ritter desde el 1/11/2026 | EPPO | Agence Europe |
| BCE | De Guindos | Vujčić desde el 1/6/2026 | HNB | ECB, Parlamento |
| Eurogrupo | Donohoe | Pierrakakis desde el 12/12/2025 | Consilium | Prensa griega e irlandesa |
| Consejo Europeo | Michel | Costa (1/12/2024-31/5/2027) | EUCO 20/24 | consilium |
| Zona del euro | 20 | 21 (Bulgaria, 1/1/2026) | Consejo (2025) | — |

## 5. Contenido añadido

- **Teorías de la integración** (caja gris en I.1): neofuncionalismo, intergubernamentalismo liberal y postfuncionalismo.
- **Brexit con el art. 50 explicado**; **ampliación y reforma en 2026** (criterios de Copenhague, candidatos, Ucrania y Moldavia, propuesta del PE de 2023 y comunicación de la Comisión de octubre de 2026).
- **Jurisprudencia** (tabla de 12 sentencias), **responsabilidad del Estado**, conflictos con los tribunales constitucionales (PSPP, Polonia), **valores, art. 7 y condicionalidad**.
- **Actos legislativos frente a no legislativos, delegados y de ejecución, comitología y *soft law***, con el gráfico de EUR-Lex.
- **Cuadro de competencias** completo, cláusula de flexibilidad, AETR, **tarjetas amarilla y naranja** (3 amarillas).
- **Modelo de asignación de competencias** (II.2.3) y **modelo del poder de voto** (III.3.2), con anexo del cálculo.
- **Procedimientos especiales**, presupuesto (art. 314, solo como competencia, con remisión al 3.B.37), **cooperación reforzada, PESCO y pasarelas**, Europa de geometría variable.
- **Instituciones** ampliadas (vías del TJUE, Tribunal General, BCE con 21 gobernadores, Defensor del Pueblo, Fiscalía Europea, agencias, SEAE) y la caja de los 3 «consejos».
- Anexo A (tabla de los 27, que sustituye a la imagen del anexo 1) y anexo B (cálculo de los índices).
- **Material del disco D: usado**: «Temas a imprimir\11. Unión Europea\Tema 3.B.37 - v.2023.pdf» y «Mis temas\Tema 3.B.37 - v.2 - 2024.docx» (idéntico en contenido al Word de partida, comprobado párrafo a párrafo; solo cambian remisiones); «Tema 3.B.37. UE línea del tiempo.xlsx» (base del gráfico de ampliaciones, corregido); de la carpeta «Tema 3.B.37»: *El ABC del Derecho de la UE* (Borchardt, 2017; citado) y Mangas y Liñán, *Instituciones y Derecho de la UE*, 9.ª ed. (citado; historia y principios). El tema de ICEX-CECO 3B36 está escaneado sin texto: no se usó. No se vieron los vídeos.

## 6. Coherencia

- **Canon**: ficha `instituciones-ue` (este es su tema de referencia): cargos actualizados y divergencias resueltas (Schumann, 705, Michel, Borrell, Donohoe, De Guindos). `nucleo-shapley`: misma notación ($\phi_i(v)$, $T\subseteq N$, $v(T)$) y nota Nobel de Shapley igual que en el 3.A.14. `oates-descentralizacion`: variante aplicada a la UE con remisión al 4.B.14. Propuestas en `_trabajo/canon-pendiente.md` (ficha nueva `poder-voto-consejo`).
- **3.B.30**: BEI y Calviño, iguales. **3.B.20**: remite aquí por París y Roma; coherente. **3.B.33**: España en el GATT 1963, UE con competencia exclusiva comercial (art. 3 TFUE), igual.
- **Fronteras**: presupuesto y MFP solo como competencia institucional (\vertema{3.B.37}); mercado interior, PAC, cohesión, política comercial, relaciones exteriores, UEM, unión bancaria y gobernanza, con remisión (3.B.38-3.B.45). EFTA/EEE, con remisión al 3.B.35.
- **4.º ejercicio**: \vertema{4.A.27} (adhesión de España), \vertema{4.A.30} (relaciones financieras), \vertema{4.B.14} (federalismo fiscal), \vertema{4.B.2} (reglas de votación).

## Reglas de las tandas 8.ª y 9.ª y transversal (aplicadas, 14/11/2026)

| Regla | Cómo se ha aplicado |
|---|---|
| Estructura rígida de modelo | 2 modelos con a) Idea, b) Modelo (i-iii), c) Extensiones, d) Evidencia empírica, e) Valoración |
| Sin citas Harvard | Solo `\nocite` y `\textcite` de obras originales; ningún `\parencite` |
| Nunca citar a Víctor | Ninguna entrada suya; gráficos «elaboración propia» |
| Ni «Pegatina» ni «Dicho» | No hay; un solo refrán, el del enganche («Del dicho al hecho hay mucho trecho», no usado en otro tema), retomado en la idea final |
| Nobel con motivo oficial | Shapley (2012), en su primera mención, con la nota del 3.A.14 |
| `\vertema` al 4.º ejercicio | 4.A.27, 4.A.30, 4.B.2, 4.B.14 |
| Resultados clave en morado | `eq:asignacion` y `eq:shapley-shubik` con `\funcionclave` |
| Pasos con sangría | Desarrollos por pasos en sublistas |
| Cajas grises | Notación; teorías de la integración; primacía y tribunales constitucionales; los 3 «consejos» |
| Ejemplos sin nombres propios | Estados 1 y 2 |
| Inglés entre paréntesis | *spillover*, *acquis*, *soft law* |
| Anexo de test | Caja estándar con `tema=3.B.36` |
| Sin páginas en blanco ni desbordes | Comprobado con `verificar-tema.py` sobre `_trabajo/` |

## 7. Dudas abiertas

Todas aplicadas con la opción recomendada (14/11/2026); para que Víctor las confirme.

- **B36-01** Refrán del enganche: «Del dicho al hecho hay mucho trecho», con la Declaración Schuman («realizaciones concretas»); «Roma no se hizo en un día» y «No se ganó Zamora en una hora» ya están en el 3.B.4 y el 3.A.45, y «A grandes males, grandes remedios» en el 3.A.36. Opciones: (a) mantenerlo **[aplicada]**; (b) «En la variedad está el gusto» (unida en la diversidad; enlaza con Oates).
- **B36-02** Estructura: se mantienen los 6 subapartados históricos del original (I.1-I.6) y los 8 institucionales (III.1-III.8), aunque son muchos títulos, porque CRITERIOS manda conservar los de segundo nivel; el debate de ampliación y reforma va como I.6.3. Opciones: (a) así **[aplicada]**; (b) agrupar I.1-I.4 en un solo subapartado.
- **B36-03** El modelo de asignación de competencias es una variante propia (BMg lineal, externalidad lineal, uniformidad) para llegar a una regla cantable, $e>\Delta/2$; el tema de referencia de Oates es el 4.B.14 (sin escribir). Opciones: (a) así, con remisión **[aplicada]**; (b) solo el teorema de Oates de palabra.
- **B36-04** Índices de poder calculados con la población en miles (redondeo): las coaliciones a menos de unos miles de habitantes del umbral pueden clasificarse mal; el efecto en los índices es despreciable (centésimas). Ninguna acción.
- **B36-05** Composición del PE por grupos: el gráfico usa la oficial de la sesión constitutiva (16/7/2024) porque la web del PE bloqueó la descarga automática de la lista actual; las cifras de julio de 2026 (PPE 184, S&D 135, PfE 85, ECR 84, Renew 78) van en nota a partir de SIEPS. Opciones: (a) así **[aplicada]**; (b) rehacer el gráfico con la lista oficial actual cuando se pueda descargar.
- **B36-06** «Probabilidad de aprobar en torno al 2 % con Niza» y la pérdida de España y Polonia con la doble mayoría: de Baldwin y Widgrén (CEPR, 2004), no recalculado. Opciones: (a) citarlo así **[aplicada]**; (b) recalcular los índices de Niza para la UE-27.
- **B36-07** Evidencia de consenso en el Consejo: se dice «la mayoría de los actos se adoptan sin votos en contra» (Hayes-Renshaw, Van Aken y Wallace, 2006) sin cifra reciente; el 80 % por mayoría cualificada es del Consejo. Ninguna acción (una cifra 2019-2024 exigiría procesar los registros de votaciones).
- **B36-08** Resultado del Consejo Europeo de octubre de 2026 sobre la comunicación «Preparar una Unión más amplia»: no comprobado; el tema solo dice lo que propuso la Comisión. Comprobar en la próxima pasada.
- **B36-09** Reforma del Tratado del MEDE: se dice que no ha entrado en vigor porque Italia no la ha ratificado (rechazo de diciembre de 2023), sin comprobar si cambió en 2026. Comprobar con el 3.B.45.
- **B36-10** Infracción contra Polonia por la sentencia de su Tribunal Constitucional (llevada al TJ en 2023): no se da el resultado por no haberlo comprobado. Ninguna acción.
- **B36-30. Tabla de competencias del cuerpo frente al diagrama del anexo** (19/11/2026). La tabla `tab:competencias` del cuerpo repite en parte el diagrama nuevo del anexo de competencias (arts. 2-6 TFUE, común a los temas de la UE). Opción recomendada (a): dejar los dos (la tabla se canta; el diagrama es de consulta). Opción (b): quitar la tabla del cuerpo y remitir al anexo. Opción (c): llevar la tabla a una caja gris.
- **B36-31. «Preferencia» o «preempción»** (19/11/2026). El diagrama de competencias dice «preferencia» (art. 2.2 TFUE y Protocolo 25); el cuerpo del 3.B.36 dice «preempción». Opción recomendada (a): «preferencia» en todo el temario, con «(*preemption*)» la primera vez. Opción (b): «preempción» en todo. Opción (c): dejarlo así.

## 8. Instrucciones para el vídeo

- **Enganche e idea final**: «Del dicho al hecho hay mucho trecho»; Declaración Schuman (realizaciones concretas); hoy 27 Estados, Ucrania y Moldavia abren capítulos. Idea final: cada tratado convirtió un dicho en un hecho jurídico; para pasar de 30, convertir en reglas lo prometido.
- **Introducción y conclusión, sin pizarra** (`modo: guion`).
- **I**: historia de palabra, rápida, con `linea-temporal` como apoyo; la figura `estructura-tratados` en la pizarra por capas (frontón, 3 pilares, base; flecha de Lisboa; TUE, TFUE, Carta, Euratom); `ampliaciones` como apoyo.
- **II.1**: la tabla de jurisprudencia y la de actos como apoyo; `actos-anuales` como apoyo.
- **II.1-II.2** (16/11/2026): la tabla de las fuentes como apoyo; sin modelo en la pizarra (el de la asignación de competencias está en el anexo A.2): la idea de la subsidiariedad, de palabra.
- **II.3**: `procedimiento-legislativo` en la pizarra por capas (una etapa por capa); los 3 pasos de los acuerdos internacionales, de palabra; `circulos-europa` como apoyo.
- **III**: `mapa-instituciones` como apoyo que se va completando; `escanos-estados` y `grupos-pe` como apoyo; en el Consejo, la regla de la doble mayoría en la pizarra y la idea de que el peso no es el poder, de palabra (el modelo y `poder-voto` están en el anexo A.3 desde el 16/11/2026).
- **Funciones clave que se conservan**: ninguna en el cuerpo desde el 16/11/2026 (`eq:asignacion` y `eq:shapley-shubik` están en los anexos).
- Nunca se dice el número de un tema en voz alta.

**Reparto del cante** (nota que iba tras el esquema del tema; quitada del tema el 19/11/2026 a petición de Víctor, se conserva aquí para el vídeo):

> Reparto del cante: introducción, \tiempo{2,5}; I, \tiempo{8} (I.1-I.4, \tiempo{3,5}; I.5, \tiempo{2}; I.6, \tiempo{2,5}); II, \tiempo{9} (II.1, \tiempo{4}; II.2, \tiempo{2,5}; II.3, \tiempo{2,5}); III, \tiempo{9,5} (III.1-III.2, \tiempo{3,5}; III.3, \tiempo{2,5}; III.4-III.8, \tiempo{3,5}), y conclusión, \tiempo{1}. La historia se canta deprisa, tratado a tratado y con lo que aportó cada uno, con la línea temporal como guía; el peso va al Derecho y a las instituciones. Es un tema institucional: los modelos de la asignación de competencias y del poder de voto van en los anexos, y en el cante basta su idea, en una frase cada uno. Las figuras imprescindibles son la línea temporal, la estructura de los tratados, la de las fuentes del Derecho, el procedimiento legislativo ordinario y el mapa de las instituciones. Lo que va en cajas grises, en notas y en los anexos es para las preguntas del tribunal.

## Coherencia con el 3.B.43 (14/11/2026)

- Lagarde: «hasta octubre de 2027» pasa a «dejará el cargo el 7 de febrero de 2027», por el anuncio del BCE del 29/10/2026 que comprobó el agente del 3.B.43.

## Listas en las notas al pie (15/11/2026)

- Nota de la iniciativa legislativa: los 3 casos en que la tienen otros (un cuarto de los Estados, el BCE, el Tribunal de Justicia), en itemize.

## Comentarios de Víctor (16/11/2026)

- «El modelo del apartado II.2.3 a anexos. En este tema no se pueden meter modelos de teoría económica. Amplía el resto de contenidos de manera acorde para compensar.» → El modelo de la asignación de competencias (idea, supuestos, desarrollo, implicaciones, extensiones, evidencia y valoración, con los gráficos `oates-uniforme` y `asignacion-competencias` y la función clave $e>\Delta/2$) pasa entero al anexo A.2 («¿Qué nivel de gobierno? La asignación de competencias»). En el cuerpo queda su idea de palabra, con autores (Oates, 1972; Alesina, Angeloni y Etro, 2005), al final de II.2.2. Para compensar (y lo mismo por el poder de voto, abajo), contenido nuevo en el cuerpo: II.1.4 «El Derecho de la Unión en el ordenamiento español» (art. 93 CE, LO 10/1985, DTC 1/1992 y 1/2004, Melloni y STC 26/2014, RD 515/2013, Ley 8/1994); control judicial de la subsidiariedad y sentencia *Publicidad del tabaco* (2000) en II.2.2; II.3.3 «La celebración de acuerdos internacionales» (arts. 207 y 218, Dictamen 2/15, CETA y Dictamen 1/17, control previo y Dictamen 2/13); I.6.3 «Las respuestas a las crisis (2010-2026)» (euro, pandemia y NGEU, Ucrania, defensa y SAFE, con la cita de Monnet); otros avances del relanzamiento (Schengen 1985, paquete Delors I, Erasmus); los *Spitzenkandidaten*; la organización del Parlamento (comisiones, INTA, ponentes, Conferencia de Presidentes); Ioannina, el consenso en el Consejo y su votación pública; el peso del Consejo Europeo y la Agenda Estratégica 2024-2029; *CILFIT* y *Foto-Frost* en la cuestión prejudicial. El título de I.6 pasa a «Base actual: Lisboa, Brexit, crisis y ampliación». Cuerpo: 33 → 32 páginas (con una figura de página entera nueva); anexos: 8 páginas.
- «En el apartado I me gusta que haya una figura como la antigua imagen 2 que desarrolle toda la línea temporal de la Unión Europea. También me gustaba la imagen 1 con las banderas de los países bien ordenadas (sustituyendo los códigos ISO de la Figura 3).» → Figura nueva de página entera al principio de I, `linea-temporal` (TikZ, 1945-2026): tratados e instituciones a la izquierda (año de firma y entrada en vigor), ampliaciones con las banderas de los Estados que entran y los hitos económicos a la derecha, en rojo fracasos, crisis y Brexit. En la figura de la geometría variable (`circulos-europa`), banderas con el nombre corto debajo en lugar de los códigos ISO. Las banderas están dibujadas a mano en TikZ, simplificadas (escudos esquematizados), en `graficos/banderas.tikz`, que comparten los dos gráficos (sin descargas: las banderas de los Estados son de dominio público).
- «En el apartado 2 también me falta una tabla o una infografía que desarrolle las fuentes y jerarquía del derecho de la Unión Europea como la que había en la página 20/46 de la versión antigua.» → Tabla 2 nueva, «Las fuentes del Derecho de la Unión y su jerarquía», con la estructura de la antigua (originario con tratados constitutivos y modificativos con sus fechas; principios generales; acuerdos internacionales; derivado; convenios entre Estados al margen), y el texto de II.1.2 reescrito como lista numerada por rango, con la jurisprudencia y los convenios intergubernamentales.
- «La tabla 1 métela en una caja gris.» → La tabla de la jurisprudencia va en una caja de anotaciones (`tablacaja`) con un párrafo de presentación.
- «Los índices de poder de voto llévalos a un anexo.» → El modelo del poder de voto (con `poder-voto` y la función clave de Shapley-Shubik) pasa al anexo A.3, que absorbe el antiguo anexo del cálculo como apartado f). III.3 queda sin subapartados y en el cuerpo queda la idea de palabra («el peso no es el poder», con Shapley y Shubik, 1954, y Banzhaf, 1965, y las cifras de Alemania, España y Malta).
- Reglas generales del 16/11: el refrán inicial no cambia; las enumeraciones nuevas llevan párrafo introductorio y sublista; los modelos están ya fuera del cuerpo. Notación: la caja de notación pasa a ser de abreviaturas (la de los modelos, en sus anexos). Ficha de repaso actualizada (esquema y tiempos, sin los bloques de los modelos ni sus gráficos, con las fuentes, España, acuerdos internacionales, crisis y la idea de los 2 modelos); sigue en 4 páginas. \minutos sigue sumando 30 (II: 4 + 2,5 + 2,5; III.3: 2,5). Instrucciones del vídeo (apartado 8) actualizadas.

### Dudas (16/11/2026)

- **B36-11** Banderas: dibujadas en TikZ y simplificadas (los escudos de España, Portugal, Croacia, Eslovaquia, Eslovenia, Andorra, San Marino, Vaticano, Montenegro, Chipre y Kosovo son esquemas), con el nombre del país debajo para que se lean sin conocerlas. Opciones: (a) así **[aplicada]**; (b) solo banderas, sin nombres, como la imagen antigua; (c) banderas exactas a partir de los SVG de Wikimedia Commons (dominio público), convertidas a PDF.
- **B36-12** La figura de la línea temporal va en página propia (`[p]`, flotante) justo después de la introducción de I; la del gráfico de ampliaciones se mantiene en I.6. Opciones: (a) mantener las dos **[aplicada]**; (b) quitar el gráfico de ampliaciones, que repite parte de la línea temporal.
- **B36-13** El modelo de la asignación de competencias y el del poder de voto conservan en los anexos su estructura de a) a e) y sus funciones clave en morado. Opciones: (a) así **[aplicada]**; (b) dejarlos en versión corta (idea y resultado).
- **B36-14** Contenido nuevo no comprobado con fuente primaria en la web (de memoria verificada con la doctrina): DTC 1/1992 y 1/2004, *Melloni*/STC 26/2014, RD 515/2013, Ley 8/1994, *Publicidad del tabaco*, *CILFIT*, *Foto-Frost*, Dictámenes 1/17 y 2/13, Ioannina (Decisión 2009/857), «unas 20» comisiones del PE. Sí se comprobaron en EUR-Lex los reglamentos de NGEU (2020/2094), el Mecanismo para Ucrania (2024/792) y SAFE (2025/1106). Opciones: (a) dejarlo así **[aplicada]**; (b) añadir cita a cada sentencia y norma en la bibliografía.
- **B36-15** En la página A-2 del anexo de la asignación de competencias queda medio blanco antes del gráfico 5 (el gráfico no cabe tras la función clave). Ninguna acción por ahora (es un anexo).

## Comentarios de Víctor (19/11/2026)

- Anexo de competencias (arts. 2 a 6 TFUE): nuevo anexo «El reparto de competencias de la Unión» (anexo:competencias) antes del de test, con la figura común `graficos/competencias-ue.tex` (carga `latex/competencias-ue-base.tex`, idéntica en los 10 temas de la UE salvo el resaltado). Resaltado en este tema: ninguno (el tema estudia el reparto entero). Remisión desde «La atribución de competencias» (sec:atribucion).
- **Estructura común de las políticas de la UE** (relevancia; justificación con teoría económica, competencias, marco jurídico y toma de decisiones; evolución; articulación; retos): **no se aplica** al 3.B.36, porque no estudia una política, sino el marco en que se hacen todas (tratados, Derecho e instituciones), y su título fija los 3 bloques. No se reestructura. Cómo se reparten aquí los elementos, como referencia para los demás temas de la UE:
  - *Relevancia*: en la introducción.
  - *Justificación de teoría económica*: solo la del reparto de competencias entre niveles de gobierno (Oates; Alesina, Angeloni y Etro), de palabra al final de II.2.2 y desarrollada en el anexo A.2, y la del poder de voto (anexo A.3).
  - *Delimitación de competencias*: II.2 (arts. 2-6 TFUE y principios), con la remisión al anexo de competencias; es el tema de referencia de lo que los demás temas de la UE resumen.
  - *Marco jurídico*: todo el bloque II (fuentes, jerarquía, Derecho derivado, Derecho de la Unión en España).
  - *Toma de decisiones*: II.3 (procedimientos legislativos, acuerdos internacionales, flexibilidad) y III (cada institución, con la doble mayoría del Consejo).
  - *Evolución*: el bloque I (de París a Lisboa, Brexit, crisis).
  - *Retos de futuro*: I.6.4 (ampliación y reforma de los Tratados) y la opinión de la conclusión.
  - Sin cambios en el `.tex`, la ficha ni las páginas (cuerpo 32, anexos 9).
- Mapa de la exposición tras el esquema, en caja gris (figu:mapa-tema).
- Ficha rehecha con el formato nuevo (introducción y esquema en la 1.ª columna, anexo en la última); 9,5 pt.

