# Revisión del tema 3.B.18 (12/11/2026)

*La nueva globalización económica y financiera. Determinantes y efectos de los movimientos internacionales de factores productivos: movilidad de trabajadores, inversión de cartera e inversión directa, con especial referencia a las cadenas globales de valor.*

## 1. Resumen

- Tema **sin original de Víctor**: escrito desde cero con la estructura de Miquel Tebar (B.18) como punto de partida, reordenada según DK1 a (coherencia): I nueva globalización (5′), II los 3 factores con el mismo patrón determinantes → efectos (13′), III cadenas globales de valor (8′); introducción 2′30″ y conclusión 1′30″ (30′ en total, comprobado por `verificar-tema.py` y `construir-tema.py`).
- Dos modelos desarrollados con a)-e): **MacDougall** (II.1, `fig:macdougall`, `eq:macdougall`) y **Helpman, Melitz y Yeaple** (II.4, `fig:hmy`, `eq:umbrales-hmy`); tercera función clave, el índice de participación en las CGV (`eq:participacion-cgv`).
- Se corrigen los errores de la referencia (HMY mal atribuido, Card, WIOD, Gourinchas, Wei, guerra comercial en 2018…), con todas las cifras actualizadas a 12/11/2026 y en `datos-actualizables.yaml` (22 entradas, todas literales del `.tex`).
- 10 gráficos (5 de teoría, 5 de datos), 5 tablas, 2 anexos (intertemporal y test), 131 entradas en el `.bib`. Compila: 30 páginas de tema, 1 de anexos y 8 de bibliografía, sin referencias sin definir.
- Solapamiento de 8-gramas con Tebar, Fuentes (3B_11) y Cabado (3.B.15): 0, salvo el título oficial (3 n-gramas del título). Una frase que coincidía con Cabado en III.2 se ha reescrito.

## 2. Errores corregidos

No hay original: los «errores» son los de la referencia (Tebar) que no se heredan.

| # | La referencia decía | El tema dice | Dónde |
|---|---|---|---|
| P7a | Modelo de IED horizontal de «Antràs y Yeaple (2014)» | Helpman, Melitz y Yeaple (2004), *AER*; Antràs y Yeaple (2014) es el capítulo del *Handbook* que lo repasa (se cita en la valoración) | II.4 |
| P7b | «Mayor elasticidad de sustitución, mayor *mark-up*» | No se afirma; el margen baja con σ (se remite al 3.B.6) | II.4 |
| P7c | WIOD «de Pol Antràs» | WIOD de Timmer et al. (2015); TiVA de la OCDE; FIGARO de Eurostat | III.1 |
| P7d | Card compara «ciudades del estado de Miami y de otros estados» | Miami frente a Atlanta, Houston, Los Ángeles y Tampa-San Petersburgo; +7 % de población activa, unos 125.000 cubanos (cifras del 3.A.25) | II.2 |
| P7e | «Gourinchas y Rey (1014)»: el capital va en sentido contrario | Puzle de la asignación de Gourinchas y Jeanne (2013), como el 3.B.12 | II.3 (caja) |
| P7f | Guerra comercial en 2016 | Desde 2018 (USTR, sección 301) | I.3 (parte 1) |
| P7g | El agente «maximiza la función de producción» | Maximiza la utilidad (anexo A, problema del 3.B.12) | Anexo A |
| P7h | «Wei (2018)» y «Wei (2019)» | Wei (2018), NBER WP 24330 | II.3 |
| P7i | Supuesto de trabajo homogéneo explicado como «no todos tienen las mismas habilidades» | Trabajo homogéneo en el modelo; la heterogeneidad es una relajación (II.2 b) | II.1, II.2 |
| P7j | Coste fijo de la IED = f_D + f_X | Coste fijo propio $F^{\mathrm I}$; ordenación si $F^{\mathrm I}>\tau^{\sigma-1}F^x>F^d$ (derivación en una caja) | II.4 |
| T1 | Umbral de producir por la libre entrada | No se repite; el umbral es el beneficio nulo de la empresa marginal (3.B.6) | II.4 |
| T2 | «Activos y pasivos 20 % del PIB en 2007, ahora 5 %» | Son flujos brutos: 22 % (2007) y 6 % (2024), cálculo propio con la BOP del FMI | I.1 (parte 1) |
| T3 | Diversificación de Markowitz dentro del modelo intertemporal | El intertemporal no tiene riesgo; la diversificación es otro determinante | II.3 a) |
| T4 | Las más productivas hacen *greenfield* y no fusiones | No se afirma (no es un resultado general, Nocke y Yeaple, 2007) | II.4 |
| T5 | IED vertical con Stolper-Samuelson | Feenstra y Hanson (1997): sube la prima de cualificación en los 2 países | II.4 c) |
| T6 | Migrantes 3,5 % | 3,7 % en 2024 (304 millones), ONU DESA | I.1, II.2 |
| T7 | Remesas «pueden superar el 20 % del PIB» sin decir dónde | 10 países en 2024: Tayikistán 47 %, Tonga 39 %, Nicaragua 27 % (WDI); gráfico `fig:remesas-pib` | II.2 b) |
| T8 | «Mejora de las combinaciones» | Errata: de las comunicaciones (costes de coordinación) | III.1 |
| T9 | China, India y Turquía «en manufactura avanzada» sin fuente | Con el WDR 2020 (gráfico 1.5): pasaron de manufactura limitada a avanzada entre 1990 y 2015; España entró en actividades innovadoras | III.3 |

## 3. Marcas resueltas

No hay marcas (sin Word). Los pendientes P1-P47 de `pendientes.md`:

- **P1-P6** (epígrafes): todos cubiertos, en el orden del título (I; II.1 marco; II.2 trabajo; II.3 cartera; II.4 directa; III CGV).
- **P7**: ver § 2. **P8** (Fuentes: Mundell y Rybczynski, sustitución): II.1 c). **P9** (Cabado: CGV, Antràs y de Gortari, Antràs y Chor): III.2; el ejemplo del iPhone no se usa (se sustituye por España). **P10** conclusión: escrita. **P11** trilemas: I.3 e) (parte 1).
- **P12-P22** (gráficos y tablas): P12 `fig:macdougall`, P13 sin gráfico (anexo A de texto), P14 `fig:hmy`, P15 `fig:cgv-participacion`, P16 `fig:curva-sonrisa` (copia del 3.B.11), P17 `fig:indicadores-globalizacion`, P18 `fig:elefante` (solo 1988-2008; la actualización de 2024 en el texto), P19 `fig:contenido-importado` (copia del 3.A.31), P20 `fig:remesas-ied-aod` y `fig:remesas-pib`, P21 `tab:factores`, P22 `tab:cgv-tipos`. Además `tab:oleadas` (parte 1) y `tab:formas-organizacion`.
- **P23-P44** (coherencia): ver § 6. **P45** (ICEX-CECO) y **P46** (Cordero): siguen sin acceso; no se ha podido contrastar. **P47**: tono neutro, el voto con Autor, Dorn, Hanson y Majlesi (2020).

## 4. Datos actualizados

Consultas del 12/11/2026 (verificador de datos, V1-V21). Al ser un tema nuevo, «valor anterior» es el de la referencia (Tebar) cuando lo hay.

| Dato | Anterior (Tebar) | Nuevo | Fuente | URL | Consulta | Segunda comprobación |
|---|---|---|---|---|---|---|
| Comercio de bienes y servicios / PIB mundial | 25 % (solo bienes) | 26 % (1970) → 57 % (2024), máx. 62 % (2022) | `BancoMundial2026Apertura` | data.worldbank.org/indicator/NE.TRD.GNFS.ZS | 12/11/2026 | OMC (GTOS 2026) y 3.B.9 |
| Exportaciones de mercancías / PIB | — | algo más de la quinta parte | `OMC2026GTOS`, `BM2026WDIMercancias` | wto.org | 12/11/2026 | 26,26/118,35 = 22,2 % |
| Flujos brutos de capital / PIB mundial | 20 % → 5 % | 21,6 % (2007) → 6,1 % (2024) | `FMI2026BOP` (cálculo propio) | api.imf.org (BOP) | 12/11/2026 | FMI, ESR 2024 (4,4 % en 2022-2023; cálculo 4,5 y 4,4) |
| IED / PIB mundial | — | 5,3 % (2007) → 1,2 % (2024) | `BM2026WDIIED` | data.worldbank.org | 12/11/2026 | BOP del FMI |
| IED mundial 2025 | — | 1,6 billones, +6 %; 20 primeros >80 %; sectores estratégicos 44 % (16 % en 2020); sin flujos de paso +4 % | `UNCTAD2026WIR` | unctad.org (WIR 2026, caps. I y III) | 12/11/2026 | Nota de prensa; Banco Mundial da 1,8 (nota al pie) |
| Migrantes | 3,5 % | 304 millones, 3,7 % (2024); 2,9 % en 1990 | `ONU2025MigrantStock` | un.org (Key facts 2024) | 12/11/2026 | OIM WMR 2026; WDI 3,73 % |
| Destinos | — | EE. UU. 52 millones, Alemania, Arabia Saudí | `ONU2025MigrantStock` | ídem | 12/11/2026 | — |
| Nacidos en el extranjero en España | — | 10,3 de 49,8 millones (1/7/2026) | `INE2026ECP2T` | ine.es/dyngs/Prensa/ECP2T26.htm | 12/11/2026 | ECP 1/1/2026 (10,0 millones) |
| Remesas a renta baja y media | — | unos 700.000 millones (2025); > IED desde 2022 | `BM2026WDIRemesas`, `FIDA2026Remesas` | data.worldbank.org | 12/11/2026 | FIDA 728.600 millones |
| Remesas / PIB | >20 % | 10 países >20 %; Tayikistán 47, Tonga 39, Nicaragua 27 | `BM2026WDIRemesas` | data.worldbank.org | 12/11/2026 | Sin segunda fuente por país (duda) |
| Contenido extranjero de las exportaciones de España | — | 26,6 % (2022) frente a 23,5 % (2010); OCDE 30,4 %; EE. UU. 8,3; China 17,0 | `OCDE2025TiVA` | sdmx.oecd.org | 12/11/2026 | 3.A.31 (A31-08) |
| Íd., FIGARO | — | 25,7 % atrás, 19,9 % delante (2024); UE 38,4 % | `Eurostat2026FIGAROcgv` | ec.europa.eu/eurostat | 05/11/2026 (3.A.31) | INE 27,7 % (nota) |
| Curva del elefante | sin cifras | +70 % centro, +65 % 1 % más rico, +5 % P80-P90 (1988-2008); actualización 2008-2018 | `LaknerMilanovic2016`, `Milanovic2024ThreeEras` | — | 12/11/2026 | Kharas y Seidel (2018); 3.B.28 |
| Arancel efectivo de EE. UU. | — | 2,4 % (2024) → 7,6 % (2025) → 6,9 % (ago. 2026) | `USAFacts2026Arancel` | usafacts.org | 05-10/11/2026 (3.B.7) | La del 3.B.7 |
| DHL | — | en máximos en 2025 | `DHL2026GCR` | stern.nyu.edu | 12/11/2026 | Sin segunda (duda) |

## 5. Contenido añadido

Todo el tema es nuevo. Por propuesta:

- **C1-C4** (introducción, I): aplicadas en la parte 1 con los cambios anotados en `_trabajo/notas-editor.md` (enganche con la cifra de España en lugar del iPhone; estructura DK1 a; rasgos en 5 bloques).
- **C5** (MacDougall): aplicada con cambios: países N y S, como el gráfico entregado (no A y B de la coherencia); función clave como igualación de salarios (`eq:macdougall`, K19) y la ganancia mundial como ecuación aparte (`eq:ganancia-mundial`); áreas A-E del gráfico explicadas en el texto; el excedente de Borjas (1995) en una caja gris; d) Evidencia (O'Rourke y Williamson) y e) Valoración con Clemens (2011).
- **C6** (determinantes de las migraciones): aplicada como II.2 a), con Sjaastad con $c_m$ y ρ (canon K3, no «CM» ni $r$), selección de Borjas-Roy, gravedad del FMI, «joroba» de Clemens. Pegatina «Nadie es profeta en su tierra». España con el texto de `datos-actualizables`. Se quita «las principales procedencias son Colombia, Venezuela y Marruecos» (no comprobado en la nota del 1/7/2026).
- **C7** (efectos): aplicada como II.2 b): relajaciones (Borjas 2003, Ottaviano y Peri, Peri y Sparber, Hunt y Gauthier-Loiselle, OCDE 2013, FMI 2020), unión monetaria (Blanchard y Katz, 1992, `\vertema{3.B.16}`), el Mariel con las palabras y cifras del 3.A.25 y el debate (Borjas 2017, Peri y Yasenov 2019, Clemens y Hunt 2019), Nobel 2021, Tabellini (2020), fuga y ganancia de cerebros, remesas con las cifras revisadas (no las de Ratha, Plaza y Kim, 2024).
- **C8** (cartera): aplicada como II.3, **sin la fórmula con pesos $w$** (decisión K3: pesos sin letra): la diversificación de palabra y una nota al pie con $\sigma^2$ y corr(·,·). Caja de puzles con el texto K16. «Sesgo nacional» (K18), no «doméstico». Pegatina «El dinero es cobarde». Añadido Gopinath et al. (2017) para la mala asignación en el sur de Europa (K15).
- **C9** (IED): aplicada como II.4 con el patrón K1 (a) Determinantes, b) Teorías, modelo HMY con a)-e), c) Efectos). Notación $F^{\mathrm I}$, $B^{\mathrm I}$, $\varphi^*_{\mathrm I}$ (coordinador), no $F^{\mathrm{IED}}$. Función clave `eq:umbrales-hmy` (K20) en lugar de `eq:umbral-ied`; la fórmula cerrada del umbral va en una caja con `\findemo`. IED «fantasma» con la cifra de la UNCTAD sin flujos de paso (no el 40 % de Damgaard et al., sin comprobar). Pegatina «Ver los toros desde la barrera».
- **C10** (CGV): repartida en III.1-III.4 (DK1 a). Sin el álgebra de la inversa (ficha `input-output`: «qué no repetir»), con la función clave del índice (K4). Pegatina «Divide y vencerás». `tab:cgv-tipos` (no `tab:cgv-grupos`) con los ejemplos del WDR en el texto. `fig:curva-sonrisa` como gráfico en el cuerpo (no en nota). La fragmentación del FMI enlaza con I.3. Reglas de la OMC y acuerdos profundos (`\vertema{3.B.33}`, `\vertema{3.B.10}`).
- **C11** (conclusión): aplicada con 1′30″ y la idea final del pañuelo «que se dobla por las costuras de los bloques» (K40).
- **C12** (anexo A): aplicado, copiando el problema `eq:problema-intertemporal` del 3.B.12; se quita la línea de $\mathrm{XN}_{t+1}$ (no hace falta) y se remite al 3.B.12.
- **C13** (cuadro resumen): aplicado como `tab:factores` con la forma K1 (columnas trabajo, cartera, IED; filas «va a donde rinde más», determinantes, efectos en destino y en origen); la fila de CGV no entra (las CGV tienen su apartado).
- **C14-C15**: § 2 y § 6. **C16**: los gráficos los ha hecho el coordinador (`graficos-pedidos.json`); `hmy-umbrales` → `hmy`. **C17** (recortes): aplicados (Obstfeld-Rogoff sin gráfico, etc.). **C18**: ficha en § 6. **C19**: entradas añadidas al `.bib` con las claves de `bib-datos` (ver `notas-editor.md`). **C20**: notación, ver § 6. **C21**: `datos-actualizables.yaml`. **C22**: § 7.
- **Rechazadas o cambiadas en la parte 2**: la fórmula de la varianza con $w$ (K3); `eq:excedente-inmigracion` numerada (va en caja, sin número); la cifra de Clemens «entre un 50 y un 150 %» (se da la de su cuadro 1, 67-147 %: comprobar); el 40 % de IED fantasma (sin comprobar); «más que la IED y la ayuda juntas» (no cuadra con el WDI: remesas 703,6 frente a IED 494,3 + AOD 251,9); el *stock* de IED de España (K26: sin dato comprobado; se remite al 4.A.23).

## 6. Coherencia

- **Estructura y títulos**: los de K6, con los `\label` de K6; el esquema enlaza por orden. Corte de título en II: «Determinantes y efectos\cortetitulo de los movimientos internacionales de factores».
- **Notación** (para `canon/notacion.md`, CC4): $F^{\mathrm I}$, $B^{\mathrm I}$, $\varphi^*_{\mathrm I}$ (HMY); VAE, VAI en redonda y $X$ en cursiva (`eq:participacion-cgv`); $c_m$ coste de emigrar (local); pesos de cartera sin letra; $r$ como remuneración del capital, avisado. **Cambio respecto de K3/K19**: países N y S en MacDougall (como el gráfico entregado por el coordinador), no A y B: proponer a `tema-canon` que la ficha `macdougall` use N y S.
- **Promesas cumplidas** (tabla 3.1 de coherencia): 3.A.15 (hacer o comprar entre países, III.2 y tabla), 3.A.31 (medición y cifras, III.1 y III.4; huella de carbono, III.3), 3.B.4 (FyA, II.4 a), 3.B.5 (Mundell, II.1 c; shock de China, III.3), 3.B.6 (Vernon y HMY), 3.B.8 (promoción, II.4), 3.B.9 (CGV y crecimiento), 3.B.10 (MacDougall con trabajo; sorteo del arancel; integración profunda), 3.B.11 (curva de la sonrisa copiada con la misma atribución; definiciones MBP6; remesas), 3.B.12 (composición de los flujos y puzles), 3.B.16 (movilidad del trabajo, Blanchard y Katz), 3.B.17 (paradas súbitas), 3.B.19 (transmisión).
- **Las 5 remisiones opcionales de vuelta** (§ 7 de coherencia; no se tocan otros temas, para `canon/pendientes-coherencia.md`): 3.A.25 (l. 564, añadir `\vertema{3.B.18}` tras Borjas 2017), 3.B.11 (nota opcional sobre la IED que solo pasa por centros financieros), 3.B.12 (`tab:fuentes-financiacion`), 3.B.15 (`sec:dilema`, flujos brutos), 3.B.16 (l. 249, tras Blanchard y Katz).
- **Nobel 2021 con dos claves**: `Nobel2021` (3.A.25) y `Nobel2021CardAngristImbens` (3.A.1 y aquí); unificar en la fase canon.
- **«Frenazo súbito» en la 1D01** frente a «parada súbita» del 3.B.12, el 3.A.39 y este tema: contradicción menor; la 1D01 está aprobada y no se toca.
- **Otras**: 3.B.29 (su estructura atribuye la IED a «Antràs-Yeaple»: que cite HMY y remita aquí; remesas > IED desde 2022, mismas cifras); 3.B.21 (serie de flujos: usar la del FMI); 3.B.39 (Card «no concluyente»); 4.A.23 (UNCTAD de 2023): al revisarlos.
- **Fichas nuevas** (DK2 a, aplicada): `cadenas-globales-valor`, `macdougall`, `empresa-multinacional` con el 3.B.18 de referencia (texto en § 6 de `propuestas-coherencia.md`; ajustar a N/S, $F^{\mathrm I}$ y `eq:umbrales-hmy`). Gráfico de referencia `fig:cgv-participacion`.

## 7. Dudas abiertas

Aplicada en todas la opción recomendada:

1. **Estructura DK1 a** (I 5′, II 13′, III 8′) frente a la de contenido (I 6′, II 8′, III 12′30″): aplicada DK1 a.
2. **Fichas nuevas** `cadenas-globales-valor`, `macdougall`, `empresa-multinacional`: aplicadas las 3 (DK2 a).
3. **Anexo A del intertemporal**: se deja, breve, con el problema del 3.B.12 (C22-D3).
4. **Remesas revisadas**: se usan las del WDI (47,2; 39,4; 26,6, redondeadas a 47, 39 y 27) y no las del blog de 2024 (45/38/27). Tonga 39,4 en el CSV; el 39,2 de otra consulta queda sin confirmar. Las remesas superan a la IED solo desde 2022 (591,4 frente a 588,0 miles de millones), como en el 3.B.29.
5. **Ejemplos de las 4 posiciones del Banco Mundial**: se dan los del gráfico 1.5 del WDR 2020 (China, India y Turquía; España en actividades innovadoras), en el texto y no en la tabla.
6. **Arancel**: se usa el de derechos recaudados del 3.B.7 (2,4 → 7,6 → 6,9 %), no el 16,9/9,1 % de la Budget Lab (parte 1).
7. **IED 1,6 frente a 1,8 billones**: UNCTAD en el texto y el Banco Mundial en nota (parte 1).
8. **Cifras sin comprobar en la fuente primaria**: fragmentación «hasta el 7 % del PIB» (Aiyar et al., 2023); −12 % comercio y −20 % IED entre bloques (Gopinath et al., 2025); Clemens (2011), 67-147 % del PIB mundial (cuadro 1); Borjas (1995), excedente del 0,1 %; HMY, multinacionales un 15 % más productivas que las exportadoras; el matiz de Antràs (2020) sobre la madurez de las cadenas; la página final de Blanchard y Katz (1992).
9. **Países N y S** en MacDougall (como el gráfico) frente a A y B de la coherencia: ¿se cambia la ficha `macdougall`?
10. **French y Poterba (1991)**: «más del 90 % en EE. UU. y Japón»; el Reino Unido no se da (las fuentes discrepan).
11. **Control de calidad (12/11/2026)**: devuelto al editor con 3 correcciones. Son estas: el recuadro de `eq:macdougall` queda al pie de la página 10; la cifra de la UNCTAD de los sectores estratégicos (44 % frente al 16 % de 2020) está en el cap. III del WIR 2026, no en el cap. I que enlaza el `.bib`; y la notación de los salarios en Sjaastad. Comprobado en la fuente: los autores del informe de DHL 2026 son Steven A. Altman y Caroline R. Bastian (nota de NYU Stern), así que ese punto sale de la duda 8. Solapamiento de 8-gramas con Tebar, Fuentes (3B_11, decodificado) y Cabado: 0 fuera del título oficial.
12. **Correcciones del control de calidad (12/11/2026)**: `\needspace{8\baselineskip}` antes de «ii) Desarrollo» de MacDougall (el recuadro de `eq:macdougall` pasa a la pág. 11, con el apartado; el gráfico 4 cae en la pág. 12); la cifra de los sectores estratégicos se cita con `\parencite[cap.~III]{UNCTAD2026WIR}` y el `.bib` enlaza el informe completo (wir2026_en.pdf); los salarios de Sjaastad pasan a $w_{\mathrm N,t}$ y $w_{\mathrm S,t}$, como en MacDougall; quitado el «comprobar» de `DHL2026GCR`. No aplicado (opcional): i)-iii) de HMY como `\subparagraph`, porque HMY ya usa `\subparagraph` para a)-e) (va dentro de «b) Teorías» de II.4) y no hay un nivel más; se quedan con la sangría manual.

## 8. Instrucciones para el vídeo

- **Enganche e idea final**: «El mundo es un pañuelo». Enganche: una cuarta parte del valor de lo que exporta España es extranjero (26,6 % en 2022) y casi una quinta parte de su valor viaja en exportaciones de otros; pero solo el 3,7 % de la población vive fuera de su país (el pañuelo es pequeño para las cosas, no para las personas). Idea final: el pañuelo se dobla por las costuras de los bloques; la pregunta no es si abrirse, sino cómo repartir lo que se gana. Introducción y conclusión en modo guion, sin pizarra.
- **I** (parte 1): boceto de `fig:indicadores-globalizacion` en I.1; columna de 5 fechas y las 3 flechas de Baldwin en I.2; 5 palabras (tareas, finanzas, emergentes, desigualdad, bloques) en I.3 con la pegatina «Más vale solo que mal acompañado». Se borra al pasar al II.
- **Tabla `tab:factores`**: a la izquierda durante todo el II; columna del trabajo en II.2, de la cartera en II.3 y de la IED en II.4; la fila «va a donde rinde más» ($w$, $r$, $B$) se escribe al empezar el II (es el hilo).
- **II.1**: `fig:macdougall` imprescindible y por capas (ejes enfrentados, $\mathrm{PMg}_{L,\mathrm N}$, $\mathrm{PMg}_{L,\mathrm S}$, reparto inicial, flecha de emigrantes, equilibrio, triángulo B + C, áreas A, D y E); `eq:macdougall` en morado debajo; se mantiene durante el II.2 (los emigrantes y las áreas). Mundell y Markusen, de palabra.
- **II.2**: `eq:sjaastad` escrita; la pegatina «Nadie es profeta en su tierra» junto al diferencial de salarios; el Mariel de palabra (fechas y cifras); `fig:remesas-ied-aod` y `fig:remesas-pib` solo como apoyo en pantalla, no se dibujan.
- **II.3**: sin gráfico; «El dinero es cobarde» junto a *push*/*pull*; la caja de los puzles, de palabra.
- **II.4**: se borra MacDougall y se dibuja `fig:hmy` por capas (ejes, $B^d$ y su umbral, $B^x$ y el suyo, $B^{\mathrm I}$, corte y umbral $\varphi^*_{\mathrm I}$, 4 llaves); `eq:umbrales-hmy` en morado; «Ver los toros desde la barrera» junto a la llave de las filiales. OLI como 3 letras en columna.
- **III.1**: se borra HMY y se dibuja `fig:cgv-participacion` (3 países, flechas, rótulos hacia atrás y hacia delante, índice); `eq:participacion-cgv` en morado.
- **III.2**: «Divide y vencerás» al empezar; `tab:formas-organizacion` (2×2) bajo el esquema de los 3 países, con la casilla de la IED vertical marcada.
- **III.3**: `fig:curva-sonrisa` en boceto (recomendable); `tab:cgv-tipos` solo de apoyo.
- **III.4**: sin pizarra; `fig:contenido-importado` como apoyo en pantalla.
- **Funciones clave que se conservan**: `eq:macdougall` (II.1-II.2), `eq:umbrales-hmy` (II.4) y `eq:participacion-cgv` (III).
