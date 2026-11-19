# Revisión del 3.B.38: La política agrícola de la Unión Europea. Problemas económicos y procesos de reforma. La política pesquera común

Tema nuevo, hecho el 14/11/2026 (entrega 1: tema y ficha de repaso; sin vídeo) en el worktree `revision-temario-2`, en paralelo con los agentes del 3.B.37 y el 3.B.39. No había tema anterior en el repositorio. La base de contenido es el antiguo 3.B.39 de Víctor, del disco D: (versión de 2023 en PDF y Word de 2024, idénticos en contenido salvo formato; se comprobó párrafo a párrafo). Se ha **redactado de nuevo** y se ha puesto al día a noviembre de 2026 con fuentes oficiales: DG AGRI, DG MARE, EUR-Lex/Oficina de Publicaciones, Consejo, Parlamento Europeo, Eurostat, OCDE, FAO, CCTEP, FEGA y MAPA. Las dudas se han resuelto con la opción recomendada y se anotan como B38-NN (14/11/2026).

## 1. Resumen

- **Estructura**: 3 apartados. **I. La PAC: fundamentos y configuración inicial** (I.1 justificación, naturaleza y objetivos; I.2 configuración inicial 1957-1992). **II. Problemas económicos y procesos de reforma de la PAC** (II.1 reformas 1984-2020; II.2 la PAC 2023-2027 y su simplificación; II.3 problemas actuales y retos futuros). **III. La política pesquera común** (III.1 justificación; III.2 la PPC de 1983; III.3 reformas de 2002 y 2013; III.4 situación actual). Reparto: introducción 2′30″, I 8′, II 10′30″, III 8′, conclusión 1′. El bloque PAC del original se parte en dos (I y II) para seguir el título (B38-01).
- **4 modelos** con la estructura rígida a)-e):
  - el **sostenimiento de precios** con restituciones, con la función clave $\Delta W=-(b+d)$;
  - el **desacoplamiento**, con pérdida acoplada $\tfrac12 s^2 q'(p)$;
  - la **capitalización de las ayudas en la tierra**, con la incidencia $\Delta R/s=|\varepsilon_D|/(|\varepsilon_D|+\varepsilon_S)$ y $\Delta P_T=\Delta R/i$;
  - **Gordon-Schaefer**, con libre acceso, RMS y MRE: $E_{\mathit{MRE}}=\tfrac12E_{\mathit{LA}}<E_{\mathit{RMS}}$. Sus extensiones: descuento (Clark), TAC frente a CIT, Ostrom y poblaciones compartidas.
- **11 gráficos y figuras propios** en TikZ/pgfplots:
  - 4 teóricos: sostenimiento de precios, desacoplamiento, capitalización y Gordon-Schaefer (2 paneles);
  - 5 de datos con CSV en `datos/`: gasto de la PAC 1980-2024 por instrumento con el % del PIB (el gráfico clásico de la DG AGRI); PSE de la OCDE 1986-2025; distribución de los pagos directos por tramos (UE y España, 2023); capturas UE y España 2000-2025; $F/F_{\mathit{RMS}}$ del Atlántico NE y del Mediterráneo 2003-2024;
  - 2 figuras: la línea de tiempo de las reformas y la arquitectura verde.
  - Sustituyen a las imágenes del Word (capturas de Sahuquillo, del PE, de Baldwin y Wyplosz y de la Comisión).
- **PDF**: 31 páginas de tema, 2 de anexos y 5 de bibliografía (38 en total). **Ficha de repaso**: 4 páginas a 10,5 pt, última al 97 %.
- **`verificar-tema.py`** (con el envoltorio sobre `_trabajo/`): sin errores propios. Las «imágenes inexistentes en el HTML» salen porque se verifica en `_trabajo/` (rutas relativas), como en el 3.B.36. Quedan avisos de «cifra sin cita» en párrafos históricos (la fuente va en el párrafo o el gráfico vecinos) y los del vídeo (entrega 3).

## 2. Errores corregidos

Correcciones al tema antiguo (antiguo 3.B.39, v. 2023 y v.2 2024):

| Id | Dónde (tema antiguo) | Decía | Dice ahora |
|---|---|---|---|
| E1 | 1.1.1 y contextualización | La PAC y la pesca, el «33 %» del presupuesto; «de ⅔ a 33,1 % en 2021» | 386.600 millones en el MFP 2021-2027 (casi un tercio del marco); 23 % del gasto de la UE y 0,31 % del PIB en 2024 (DG AGRI); 73 % en 1985 |
| E2 | MFP 2021-2027 | PAC 336.400 millones (FEAGA 258.600; FEADER 77.800) | Eran precios de 2018. En precios corrientes: 386.600 (FEAGA 291.100; FEADER 95.500, con 8.100 del NGEU) |
| E3 | España | «Unos 45.000 millones, segundo tras Francia» | PEPAC: 34.472 millones de gasto público 2023-2027 (31.508 de la UE). FEGA 2025: 5.719 del FEAGA (≈14 %) y ≈1.680 de parte UE del FEADER (B38-03) |
| E4 | Ronda Uruguay | La caja azul eran ayudas «que no superen el umbral de minimis del 5 %» | La caja azul son pagos ligados a programas que limitan la producción, sin límite; el *de minimis* es una exención de la caja ámbar (coherente con la tabla del 3.B.33) |
| E5 | Nota 11 | «El padre de la PAC fue Charles de Gaulle» | Se quita. La PAC se diseñó en Stresa (1958) bajo el comisario Sicco Mansholt; Francia sí fue su gran impulsora (pacto franco-alemán) |
| E6 | 1.2 | «El Plan Mansholt I (1962) crea el FEOGA» | El FEOGA lo crea el Reglamento 25/1962. El Plan Mansholt es de 1968, de estructuras, y quedó en las directivas de 1972 |
| E7 | Agrimoneda | «Desde enero de 1993 los tipos verdes se ajustaron a los centrales» | En 1993 desaparecen los montantes compensatorios con el mercado interior; los tipos verdes duran hasta el euro (1999) |
| E8 | Bibliografía | «García, E. C. & Pabsdorf, M. N. (2015)» | Cuenca García, E. y Navarro Pabsdorf, M. (2015), *Boletín Económico de ICE*, 3060 |
| E9 | 2.2 PPC | «Tasa Autorizada de Capturas» | Total admisible de capturas (TAC) |
| E10 | 2.2 PPC | Estabilidad relativa «en base a las capturas de los 6 años previos» | Clave fija basada en las capturas de 1973-1978 y en las preferencias de La Haya, no móvil |
| E11 | 2.2 PPC | «En 1983 se crea la PPC» como inicio | Las primeras normas (igualdad de acceso y OCM de la pesca) son de 1970; zona de 200 millas desde 1977; la PPC propiamente dicha, Reglamento 170/83 |
| E12 | 2.3.2 | Obligación de desembarque «del 95 % de las capturas» | Todas las capturas de especies sometidas a TAC (con exenciones *de minimis*), gradual entre 2015 y 2019 |
| E13 | 2.3.2 | «El 80 % de las poblaciones mediterráneas y el 47 % de las del Atlántico estaban sobreexplotadas (atún)» | Datos del CCTEP (2026): Atlántico NE, $F/F_{RMS}$ de 1,51 (2003) a 0,70 (2024); Mediterráneo, sobrepescadas del 83 % (2007) al 47 % (2023) |
| E14 | 2.1.2 | «48 % del Atlántico y 93 % del Mediterráneo sobreexplotadas» | Se sustituye por los datos anteriores |
| E15 | 2.2 OROP | «6 OROP atuneras y 11 no atuneras» | 5 atuneras y 13 no atuneras (DG MARE, 2026) |
| E16 | 2.4.2 Brexit | «El 25 % de las capturas de la flota europea» | El 25 % del **valor** de las capturas de la UE en aguas del Reino Unido, en 5,5 años (hasta el 30/6/2026). Acceso recíproco prorrogado hasta el 30/6/2038 (acuerdo de mayo de 2025) |
| E17 | 2.1.1 | «La UE es el cuarto productor mundial (5,8 %), tras China, Indonesia e India» | Dato antiguo sin fuente: se sustituye por los de Eurostat (3,3 millones de t en 2025; 5,9 en 2001) |
| E18 | Exterior | «Acuerdos con contrapartida comercial: Canadá hasta el CETA» | Se quita: no se ha podido comprobar. Quedan los acuerdos de reciprocidad (Noruega) y los de colaboración (SFPA) |
| E19 | 1.1.3 y 2.1.3 | La delimitación PE-Consejo del art. 43 «sigue abierta y tendrá que resolverse en la próxima reforma» | Se dice que los límites entre las 2 vías han llevado a las instituciones ante el Tribunal de Justicia; ya no es una cuestión «de la próxima reforma» |

## 3. Marcas resueltas

| Marca | Texto original | Qué se ha hecho |
|---|---|---|
| Nota inicial | Aviso del cambio de temario de 2023 | Desaparece (es un aviso de trabajo) |
| Comentario | «Copiado todo lo del tema de Juan Luis y de Sahuquillo. Estudiar por aquí» | No se publica; no se nombra a ningún preparador |
| [escribirlos en la pizarra] (art. 39) | Indicación de pizarra | Fuera del texto; pasa a «Instrucciones para el vídeo» |
| Enganche (cita de Monnet) | Enganche genérico de la UE | Sustituido por un enganche propio del tema (protestas de 2024, distribución de los pagos) y el refrán (B38-02) |
| 1.4-1.6 | Propuestas 2018, «otras cuestiones» (Pacto Verde, granja a la mesa, biodiversidad) e imágenes sin texto | Integrado en II.2 (PAC 2023-2027) y en II.3 (medio ambiente y clima, con la retirada del reglamento de plaguicidas) |
| 1.7 «Problemas actuales y retos futuros» | Solo un enlace al MAPA | Escrito entero (II.3): distribución, capitalización, relevo, clima, comercio y ampliación, PAC post-2027 |
| 2.3.2 «Política exterior: [no viene nada…]» | Hueco | Escrito: SFPA, OROP, INDNR y control (III.3 y III.4) |
| Conclusión | Relevancia, Extensiones, Opinión e Idea final vacías | Escrita entera, con los 5 bloques |
| Imágenes 1 (precios de la PAC, Sahuquillo) y equivalencia impuesto-subsidio | Capturas | Rehechas: gráfico `sostenimiento-precios` y anexo A (equivalencia impuesto al consumo + subvención a la producción) |
| Tabla de la Comisión (hitos), esquemas de evolución y de debilidades, gráfico de Baldwin y Wyplosz, pirámide verde, captura de Ostrom | Capturas | Rehechas: figura `reformas-pac`, gráfico `desacoplamiento`, figura `arquitectura-verde`. La tabla de rivalidad y exclusión se remite al 3.A.23 |
| Enlaces a YouTube, uv.es, euronews, elblogsalmon, Le Monde, El País | Enlaces de apoyo | Se sustituyen por fuentes oficiales (fichas del PE, DG AGRI, DG MARE). La noticia de El País sobre el fin de las cuotas lecheras no se mantiene (B38-12) |
| «¡Error! No se encuentra el origen de la referencia» | Referencia rota | Desaparece |
| Anexo 1 (competencias UE/Estados) | Tabla | No se repite: es del 3.B.36. El tema dice en el texto qué es exclusivo y qué compartido |

## 4. Datos actualizados

Todos consultados el 14/11/2026. Las fuentes completas están en `datos-actualizables.yaml` y en las cabeceras de los CSV.

| Dato | Antes | Ahora | Fuente | Segunda comprobación |
|---|---|---|---|---|
| PAC en el MFP | 336.400 (precios 2018) | 386.600 corrientes | DG AGRI, «CAP funds» | Ficha 3.2.2 del PE (abril de 2026) |
| Peso en el gasto de la UE | 33,1 % (2021) | 73 % (1985) → 23 % (2024); 0,31 % del PIB | DG AGRI, «CAP expenditure» | Suma de las categorías del CSV |
| Distribución de los pagos | 80/20 | 25 % → 84,6 % (2023) | DG AGRI, *indicative figures* (2025) | % acumulados de la p. 11 del PDF |
| PSE de la OCDE | — | 38,5 % (1986-88) → 18,2 % (2025) | API de la OCDE (PSEP) | Media 2023-25 = 17,4 %, la del capítulo UE del informe |
| Explotaciones y edad | — | 9,1 millones (2020); 8,8 (2023); <40 años 11,9 % | Eurostat | Statistics Explained |
| Simplificación | — | Reglamentos 2024/1468 y 2025/2649 | Legislative Train del PE | Página de la Comisión «farmers' concerns» |
| Post-2027 | — | 865.000 millones; 293.700 + 6.300; degresividad; estado de la negociación | DG AGRI; ST 10058/26; ST 14484/26 | EPRS (4/11/2026) |
| España | ≈45.000 | PEPAC 34.472; FEGA 2025 | Ficha de la Comisión; FEGA | FEGA 2024 |
| Capturas | 5,8 % mundial | 3,3 millones de t (2025) | Eurostat | Nota de prensa del 19/10/2026 |
| Poblaciones | 48 %/93 % | $F/F_{RMS}$ 0,70 y 0,92 | CCTEP 26-01 | COM(2026) 271 |
| FAO | — | 37,6 % no sostenibles (2023) | SOFIA 2026 | Base de datos ODS 14.4.1 |
| FEMPA | 6.108 | 6.108; España 1.120 (21 %) | Reglamento 2021/1139 | DG MARE y La Moncloa |
| Brexit | Transición hasta 2026 | Acceso hasta el 30/6/2038 | DG MARE | IP/25/3009 |

## 5. Contenido añadido

- **Teoría**: economía política de la protección (Olson; Anderson, Rausser y Swinnen), rueda de Cochrane, regla de Tinbergen como hilo de las reformas, los 4 modelos y el anexo B con las derivaciones de Gordon-Schaefer y la regla de oro de Clark.
- **PAC**: los primeros frenos (1984-1988); Blair House; la seguridad alimentaria (EFSA), en caja gris; la reforma de 2013 con la valoración del TCE (pago verde); la PAC 2023-2027 (tabla de intervenciones, arquitectura verde, condicionalidad social); las protestas y la simplificación de 2024 y 2025; el diálogo estratégico; la Visión 2025; España (PEPAC y FEGA); problemas (distribución, capitalización, relevo, clima, Ucrania, Mercosur, ampliación); la propuesta post-2027 y su negociación.
- **PPC**: los orígenes (1970, 200 millas, Noruega); el Reglamento 170/83; el periodo transitorio de España hasta 1996; la reforma de 2002 en detalle; el régimen de control de 2023; el Acuerdo de la OMC sobre subvenciones a la pesca; los SFPA (y la sentencia sobre Marruecos); la evaluación de la PPC (2026); el Pacto por los Océanos; la Visión 2040; el plan de acción marino; el Mediterráneo occidental (143 días frente a 9,7).
- **Nobel**: Tinbergen (1969), Coase (1991) y Ostrom (2009), con su nota en la primera mención.
- **Material del disco D: usado**:
  - «Temas a imprimir\11. Unión Europea\Tema 3.B.39 - v.2023.pdf» (base principal) y «Mis temas\Tema 3.B.39 - v.2 - 2024.docx» (igual en contenido; de él salen las imágenes);
  - de la carpeta «Tema 3.B.39»: «Transformaciones y desafíos de la PAC» (Cuenca y Navarro, 2015; citado) y el «Anexo al Capítulo 13 - La PAC y el medio ambiente» (Camarero, Tamarit y Anchuelo; citado como en el original).
  - Las fichas FTU 3.2.x y 3.3.x del D: son antiguas: se han usado sus versiones vigentes en europarl.europa.eu/factsheets (citadas).
  - No se ha usado la subcarpeta «Más Libros - No consultar», como pidió Víctor, ni los temas de otros preparadores.

## 6. Coherencia

- **3.B.33** (OMC): cajas ámbar, azul y verde, reducción del 36 % de los aranceles, Blair House, prohibición de las restituciones en Nairobi (2015) y subvenciones a la pesca en vigor el 15/9/2025: todo coincide. El 3.B.38 remite allí y no repite la tabla.
- **3.B.35** (Mercosur): firma el 17/1/2026, aplicación provisional desde el 1/5/2026 y dictamen del TJUE pendiente: coincide. El 3.B.38 añade la salvaguardia agrícola de marzo de 2026.
- **3.B.37** (presupuesto, en curso): planes de 865.000 millones, caja irlandesa y Consejo Europeo de 26-27/11/2026: coincide. Aquí solo van las cifras de la PAC; el MFP, con detalle, allí.
- **3.B.36**: competencias (arts. 3 y 4 TFUE) y Stresa: coincide.
- **3.A.16** (controles de precios, telaraña), **3.A.22** (2TFEB), **3.A.23** (recursos comunes, Gordon estático, Ostrom) y **4.B.8** (incidencia): se remite en vez de redesarrollar; Gordon-Schaefer va completo porque aquí es el modelo central.
- **3.B.7** (subvenciones a la exportación): coincide (con competencia perfecta, la subvención a la exportación de un país grande empeora su RRI).
- **4.º ejercicio**: \vertema{4.A.4}, \vertema{4.A.30}, \vertema{4.B.2}, \vertema{4.B.8}.
- **Canon**: propuestas en `_trabajo/canon-pendiente.md`:
  - la ficha `pac` tiene ya su tema de referencia con fuente;
  - ficha nueva `gordon-schaefer` (o ampliación de `tragedia-comunes`), con la notación local y sus avisos ($E$, $H$, $\theta$, $\gamma$).

## Reglas de las tandas 8.ª y 9.ª y transversal (aplicadas, 14/11/2026)

| Regla | Cómo se ha aplicado |
|---|---|
| Estructura rígida de modelo | 4 modelos con a)-e). En la capitalización no hay extensiones: a) Idea, b) Modelo, c) Evidencia, d) Valoración |
| Sin citas Harvard | Solo `\nocite` y `\textcite` de obras originales; ningún `\parencite` |
| Nunca citar a Víctor | Ninguna entrada suya; gráficos de «elaboración propia» |
| Ni «Pegatina» ni «Dicho» | No hay. Un solo refrán, el del enganche («Aunque la mona se vista de seda, mona se queda», no usado en otro tema), retomado en la idea final y en las CIT |
| Nobel con motivo oficial | Tinbergen, Coase y Ostrom, con las notas ya usadas en el temario |
| `\vertema` al 4.º ejercicio | 4.A.4, 4.A.30, 4.B.2, 4.B.8 |
| Resultados clave en morado | `eq:perdida-precios`, `eq:desacoplamiento`, `eq:capitalizacion`, `eq:gordon-schaefer` |
| Pasos con sangría | Todos los desarrollos van por pasos en sublistas |
| Cajas grises | Notación; el problema agrario hoy; la seguridad alimentaria |
| Inglés entre paréntesis | *treadmill*, *set-aside*, *slippage*, *greening*, *producer support estimate* |
| Anexo de test | Caja estándar con `tema=3.B.38` |
| Sin páginas en blanco ni desbordes | Comprobado (`verificar-tema.py`, 0 avisos de desborde) |

## 7. Dudas abiertas

Todas se han aplicado con la opción recomendada (14/11/2026); están pendientes de que Víctor las confirme.

- **B38-01** Estructura: el original tenía 2 bloques (PAC y PPC). El bloque de la PAC se parte en 2 apartados (I fundamentos y PAC de precios; II reformas y problemas), con los títulos de segundo nivel del original en su orden: 1.4 «nueva PAC» y 1.6 «configuración actual» se funden en II.2, y 1.5 «otras cuestiones» pasa a II.3. Opciones: (a) 3 apartados así **[aplicada]**; (b) 2 apartados como el original (PAC 18′30″, PPC 8′).
- **B38-02** Refrán del enganche (cambiado por el coordinador el 14/11/2026): el agente puso «El pez grande se come al chico», pero el 3.B.39 (hecho a la vez) usa el mismo y allí encaja mejor (competencia). Se pone «Aunque la mona se vista de seda, mona se queda»: las reformas cambian el traje de la ayuda (precios, hectáreas, desacoplamiento, pagos verdes) y la concentración sigue. Opciones: (a) así **[aplicada]**; (c) el original, «El pez grande se come al chico», cambiando el del 3.B.39; (b) «No hay que matar la gallina de los huevos de oro», que ya usan el 3.A.38 y el 3.B.3.
- **B38-03** España: la cifra de unos 47.724 millones que suele dar el MAPA para el PEPAC (incluye financiación nacional adicional) no se ha encontrado en fuente oficial accesible: el certificado de mapa.gob.es falla con descarga automática. Se usa la ficha de la Comisión: 34.472 millones de gasto público, de ellos 31.508 de la UE. Los ecorregímenes de España suman el 23 % de los pagos directos, menos del 25 %; el reglamento lo permite si el FEADER ambiental supera su mínimo. Opciones: (a) así **[aplicada]**; (b) dar también la cifra del MAPA cuando se compruebe.
- **B38-04** Coste de la entrada de Ucrania para la PAC (≈96.500 millones en 7 años): solo está en prensa (Financial Times, 2023, sobre un estudio interno del Consejo); el texto lo dice así. Opciones: (a) mantenerlo con esa atribución **[aplicada]**; (b) quitar la cifra.
- **B38-05** Estrategia de relevo generacional (COM(2025) 872, 21/10/2025; duplicar la proporción de jóvenes para 2040): comprobada solo a través del resumen de un buscador. Comprobarla en la próxima pasada.
- **B38-06** Posición del Consejo sobre el reglamento de la PAC (26/10/2026): solo a través de un buscador. El tema solo dice lo que consta en documentos oficiales leídos: la degresividad y el tope entre corchetes (ST 14484/26) y las cajas de negociación. Tras el Consejo Europeo de 26-27/11/2026 habrá que actualizar II.3.4.
- **B38-07** El protocolo pesquero con Mauritania vence el 14/11/2026 y no se ha encontrado sucesor. Actualizar el número de protocolos en vigor (11).
- **B38-08** Renta agraria frente al salario medio: el último dato oficial que se ha encontrado es de 2017 («algo menos de la mitad»), y se da con su año. Ninguna acción.
- **B38-09** Visión 2040 de la pesca (COM(2026) 701): se leyó en la copia de la Eerste Kamer, y la URL de la bibliografía es la portada de la DG MARE. Poner la URL oficial cuando se pueda.
- **B38-10** El modelo de Gordon-Schaefer se desarrolla completo aquí, aunque el canon (`tragedia-comunes`) preveía una mención. Es el modelo central de la PPC y no está en otro tema. Opciones: (a) desarrollo completo y ficha nueva en el canon **[aplicada]**; (b) mención con remisión al anexo del 3.A.23.
- **B38-11** Unos 40 párrafos con cifras van sin `\nocite` propio (aviso de `verificar-tema.py`): son hechos históricos o normativos cuya fuente se cita en el párrafo o el gráfico vecinos, o en las fichas del PE. Opciones: (a) dejarlos **[aplicada]**; (b) añadir `\nocite` párrafo a párrafo.
- **B38-12** El original citaba una noticia de El País (2018) sobre el fin de las cuotas lecheras. No se mantiene: no es fuente de datos y el tema da el fin de las cuotas con fecha. Opciones: (a) quitarla **[aplicada]**; (b) mantenerla en nota.
- **B38-13** (19/11/2026) Gráfico 6 (antes 5), distribución de los pagos: se han probado 4 formas con los mismos datos (barras pareadas, barras divergentes por tramo, curva de Lorenz y barras apiladas al 100 % con bandas). Opciones: (a) 2 paneles: barras divergentes por tramo (% de perceptores a la izquierda y % del importe a la derecha, cada uno con su eje) y curva de Lorenz con el Gini **[aplicada]**; (b) solo las barras divergentes; (c) solo la curva de Lorenz; (d) barras apiladas al 100 % (perceptores frente a importe) unidas por bandas, solo para la UE.
- **B38-14** (19/11/2026) Baldwin y Wyplosz (2020) como fuente esencial: el máximo es 5, así que entra en lugar de la ficha de objetivos de la DG AGRI (`CE2026ObjetivosPAC`), que sigue citada entre las otras referencias. Opciones: (a) así **[aplicada]**; (b) dejar fuera otra (la OCDE o una ficha del PE). También: el gráfico nuevo del reparto entre explotaciones (gráfico 2, fig. 9.5 del manual) va en las extensiones del modelo de precios; si alarga demasiado, puede quedar solo de palabra.

## 8. Instrucciones para el vídeo

- **Enganche e idea final**: «Aunque la mona se vista de seda, mona se queda»: los tractores de febrero de 2024 y el dato de que el 25 % se lleva el 85 % de los pagos. Pregunta: ¿puede una política común sostener a la vez la renta, los recursos y el bolsillo de quien paga? Idea final: sí, si paga por objetivos y no por tamaño.
- **Introducción y conclusión, sin pizarra** (`modo: guion`).
- **I**:
  - los objetivos del art. 39, como lista corta en la pizarra (eran la indicación «escribirlos en la pizarra» del original);
  - el modelo del sostenimiento de precios en la pizarra, en 2 paneles y por capas (19/11/2026, como Baldwin y Wyplosz): a) importadora: ejes, $x(p)$ y $q(p)$, $p^W$, $p^I$, áreas $a$ y $c$ (exacción), triángulos $d$ y $b$; b) exportadora: la oferta se desplaza (progreso técnico), restituciones $b+c+d$ y los mismos triángulos;
  - el reparto entre explotaciones (gráfico `reparto-explotaciones`) como apoyo;
  - función clave `eq:perdida-precios`, que se conserva hasta el final de II.1;
  - `pse-ue` como apoyo.
- **II.1**:
  - `reformas-pac` como apoyo que va avanzando;
  - `gasto-pac` como apoyo (el gráfico clásico de la Comisión);
  - el desacoplamiento: primero, de palabra sobre el panel b del sostenimiento, bajar el precio ($+b+d$) y compensar con $D=a+b+c$; después, en la pizarra, el panel izquierdo del gráfico `desacoplamiento` por capas y el derecho;
  - función clave `eq:desacoplamiento`.
- **II.2**: `arquitectura-verde` como apoyo; la simplificación, de palabra.
- **II.3**:
  - `distribucion-pagos` como apoyo (2 paneles: barras divergentes por tramo y curva de Lorenz);
  - la capitalización en la pizarra (panel de oferta rígida y, si da tiempo, el de oferta con pendiente);
  - función clave `eq:capitalizacion`;
  - la propuesta post-2027, de palabra, con una tabla corta de apoyo (pilares → fondo único; 300.000 reservados; degresividad).
- **III**:
  - Gordon-Schaefer en la pizarra, por capas en los 2 paneles (biología: $G(X)$; rectas de captura del RMS, del libre acceso y del MRE. Economía: $pY(E)$ y $cE$; $E_{RMS}$, $E_{LA}$, $E_{MRE}$ y la renta máxima);
  - función clave `eq:gordon-schaefer`, que se conserva hasta el final;
  - `capturas-ue` y `estado-poblaciones` como apoyo.
- **Funciones clave que se conservan**: `eq:perdida-precios` (I-II.1), `eq:capitalizacion` (II.3) y `eq:gordon-schaefer` (III).
- Nunca se dice el número de un tema en voz alta.

**Reparto del cante** (nota que iba tras el esquema del tema; quitada del tema el 19/11/2026 a petición de Víctor, se conserva aquí para el vídeo):

> Reparto del cante: introducción, \tiempo{2,5}; I, \tiempo{8} (I.1, \tiempo{3}; I.2, \tiempo{5}, de ellos \tiempo{2,5} para el modelo del sostenimiento de precios); II, \tiempo{10,5} (II.1, \tiempo{4,5}, con \tiempo{1,5} para el desacoplamiento; II.2, \tiempo{2,5}; II.3, \tiempo{3,5}, con \tiempo{1,5} para la capitalización en la tierra); III, \tiempo{8} (III.1, \tiempo{3,5}, con \tiempo{2,5} para el modelo de \autor{Gordon}-\autor{Schaefer}; III.2, \tiempo{1}; III.3, \tiempo{1,5}; III.4, \tiempo{2}), y conclusión, \tiempo{1}. Los gráficos y figuras imprescindibles son el sostenimiento de precios, la evolución del gasto de la PAC, el desacoplamiento, la capitalización, la distribución de los pagos y los 2 paneles de \autor{Gordon}-\autor{Schaefer}. Lo que va en cajas grises, en notas y en los anexos es para las preguntas del tribunal.

## Listas en las notas al pie (15/11/2026)

Ninguna nota lo necesitaba.

## Comentarios de Víctor (19/11/2026)

- **1. Gráfico 5 (distribución de los pagos)**: rehecho con los mismos datos de la DG AGRI (ejercicio 2023). Se probaron barras pareadas (la versión anterior), barras divergentes, curva de Lorenz y barras apiladas al 100 %; queda en 2 paneles: a) cada tramo con su % de perceptores a la izquierda y su % del importe a la derecha, cada medida con su eje (los tramos se leen por separado y se ve el cruce: muchos perceptores y poco dinero abajo, al revés arriba); b) curva de Lorenz de la UE-27 y de España con el Gini (cota inferior: 0,75 y 0,70) y el punto «el 25 % que más cobra se lleva el 84,6 %». CSV nuevo `datos/distribucion-pagos-lorenz.csv` (elaboración propia a partir de `distribucion-pagos.csv`). Ahora es el gráfico 6 (pág. 21) porque entra uno nuevo antes. Texto: viñeta «Cómo leer el gráfico» con el Gini. Duda B38-13.
- **2. Modelos y Baldwin y Wyplosz** (6.ª ed., 2020, cap. 9, leído en el ejemplar del D:): el manual sí trae los modelos, con diagramas de oferta y demanda y letras $a$-$d$. Los 2 del tema ya seguían su lógica (el sostenimiento con restituciones es su fig. 9.10 leída al revés, con las mismas letras $b$ y $d$; la equivalencia arancel = impuesto al consumo + subvención a la producción ya estaba en el anexo A), pero faltaban piezas, que se han añadido:
  - *Sostenimiento de precios* (I.2.3): ahora en 2 fases, como el manual: años 60, la Comunidad importa y el precio se sostiene con la exacción variable (fig. 9.2: productores $+a$, consumidores $-(a+b+c+d)$, recaudación $c$); la «revolución verde» desplaza la oferta y la Comunidad pasa a exportar con restituciones (figs. 9.6 y 9.10: $+(a+b+c)$, $-(a+b)$, $-(b+c+d)$). La función clave $\Delta W=-(b+d)$ no cambia. Gráfico rehecho en 2 paneles. Implicaciones nuevas: «de fuente de ingresos a sumidero de gasto» y el sesgo a las grandes. Extensión nueva con gráfico nuevo (`reparto-explotaciones`, fig. 9.5): la explotación grande se lleva casi toda la ganancia. Evidencia: 18,5 millones de t de cereales almacenados en 1985.
  - *Desacoplamiento* (II.1.3): se rehace como la «nueva lógica» del manual: bajar el precio a $p^W$ ($+b+d$), compensar con un pago desacoplado $D=a+b+c$ (todos ganan, el bienestar sube igual) o con uno acoplado (queda $d$: los pagos de MacSharry). Se mantiene la función clave $\tfrac12 s^2q'(p)$ y el gráfico; se quita el rótulo $q'(p)$ de la oferta desplazada, que chocaba con la pendiente $q'(p)$ de la fórmula. Valoración: el pago desacoplado del todo es una subvención a la propiedad de la tierra (sec. 9.6).
  - *Capitalización* (II.3.2): ya era el planteamiento del manual (incidencia de una subvención); se cita y se añade su dato de la OCDE (unos 45 céntimos de cada euro de pago por superficie para propietarios que no cultivan; el 40 % de la tierra no la cultiva su dueño).
  - *Gordon-Schaefer*: el manual no trata la pesca; se queda como estaba.
  - Notación del canon (x(p), q(p), $p^W$, $p^I$; la exacción sin letra para no chocar con $T$, la superficie). Fuentes: «elaboración propia a partir de Baldwin y Wyplosz (2020)» en los gráficos 1, 2 y 4. Entrada nueva `BaldwinWyplosz2020Economics` en el `.bib`, esencial (duda B38-14).
- **3. Estructura común de las políticas de la UE**: el tema ya tenía casi todos los elementos; se ha reordenado por debajo de los títulos de segundo nivel (que no cambian) para que estén todos y en orden, en las 2 políticas:
  - *PAC*: 1. Relevancia (I.1.1); 2. Justificación: a) teoría económica (I.1.2, por qué agraria y por qué común), b) **delimitación de competencias** (I.1.3, nueva, con lo que estaba en el marco jurídico y la tendencia a dar margen a los Estados), c) marco jurídico (I.1.4: arts. 38-44 y derecho derivado vigente), d) **toma de decisiones** (I.1.5, nueva: art. 43, gestión compartida y el MFP); 3. Evolución (I.2 y II.1, con los modelos de precios y de desacoplamiento); 4. Articulación (II.2, la PAC 2023-2027); 5. Retos de futuro (II.3).
  - *PPC*: 1. Relevancia (III.1.1); 2. a) teoría económica (III.1.2 y el modelo de Gordon-Schaefer), b) delimitación de competencias (III.1.4, nueva), c) marco jurídico (III.1.5), d) toma de decisiones (III.1.6, nueva, con el asesoramiento del ICES y del CCTEP); 3. Evolución (III.2 y III.3); 4. Articulación (III.4, párrafo nuevo «La articulación actual: fondo, control y acción exterior», con el FEMPA, el control, los SFPA, las OROP y el Brexit) y sus resultados (estado de las poblaciones); 5. Retos de futuro (III.4, párrafo «Retos de futuro»: evaluación, Pacto por los Océanos, Visión 2040, después de 2027).
  - No se pierde contenido; los minutos no cambian (suman 30).
  - **Anexo de competencias**: añadido el fragmento `_trabajo/anexo-competencias.tex` (con `graficos/competencias-ue`, figura 3) como anexo D, antes del de test; se remite a él desde la delimitación de competencias de la PAC (I.1.3) y de la PPC (III.1.4).
- **PDF**: antes 31 páginas de tema + 2 de anexos + 5 de bibliografía (38); ahora 33 + 4 + 5 (42), con el anexo de competencias. Ficha de repaso puesta al día (sostenimiento, desacoplamiento y pie del gráfico de distribución): 4 páginas a 10,5 pt. `verificar-tema.py`: 0 errores, 17 avisos (los de siempre: cifras sin cita en párrafos históricos y el vídeo).
- Mapa de la exposición tras el esquema, en caja gris (figu:mapa-tema).
