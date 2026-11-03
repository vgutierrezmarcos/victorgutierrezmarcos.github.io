# Revisión del tema 3.A.29

**Modelización dinámica de las tomas de decisiones. Modelos de horizonte infinito y modelos de generaciones solapadas.**

Revisión autónoma del 1/11/2026 (Víctor fuera hasta el 9/11; las dudas llevan aplicada la opción recomendada o la del coordinador y se numeran A29-NN). Hecha en 2 partes: la 1 (introducción, I, II, bibliografía, gráficos pedidos y SEO) y la 2 (III, conclusión y anexos).

## 1. Resumen

- El tema pasa de 2 apartados (I micro, II macro) a **3**, uno por pieza del título: I. La modelización dinámica de las decisiones (8′30″), II. El agente representativo de vida infinita (8′), III. Generaciones solapadas y heterogeneidad (10′); introducción 2′30″ y conclusión 1′ (A29-01).
- El bloque I deja de duplicar el consumo (3.A.33), la inversión (3.A.34) y el capital humano (3.A.25): **Fisher, la q, Becker, Hall y el C-CAPM en resumen** con `\vertema`, y entra lo que el canon pide a este tema de referencia: **los 3 métodos** (Lagrange, control óptimo y programación dinámica) con la misma ecuación de Euler, la tabla de comparación y la **ecuación de Bellman** con un ejemplo resuelto.
- El bloque II deja de ser descriptivo: agente representativo con la agregación de Gorman corregida, las 3 condiciones del horizonte infinito, la consistencia temporal (Strotz, descuento hiperbólico, Kydland y Prescott), la senda de silla y Blanchard-Kahn, y el **modelo de Ramsey-Cass-Koopmans en resumen** con las ecuaciones del 3.A.43.
- Enganche nuevo («No dejes para mañana lo que puedas hacer hoy» y la pregunta de Ramsey, 1928, como hilo) y el mecanismo de equidad intergeneracional como dato de la relevancia. Funciones clave: Euler, Bellman y la ley de movimiento de Diamond.
- El bloque III desarrolla lo que el original solo describía: **Samuelson (1958)** con dinero y **Diamond (1965)** completo (ahorro, ley de movimiento `eq:diamond` como tercera función clave, estado estacionario, regla de oro, **ineficiencia dinámica** $r^*<n+g$ con el aviso de Abel *et al.*, deuda, equivalencia ricardiana, pensiones con la condición de Aaron, burbujas de Tirole, Blanchard-Yaari), 3 gráficos de datos, el cuadro horizonte infinito frente a generaciones solapadas y las limitaciones (Kirman, HANK). Conclusión con sus 5 bloques y 9 anexos (las 2 piezas comunes copiadas y adaptadas, Bellman, Robinson Crusoe, Hotelling, estática comparativa, cota cero, Diamond paso a paso y test).

## 2. Errores corregidos

| Dónde | Decía | Dice ahora |
|---|---|---|
| Nota 2 (introducción) | *Foundations of Economic Analysis* (1965); «importado de la física (Bohr)» | 1947 (Harvard University Press); las 2 citas en inglés son literales (pp. 5 y 262-263; se añade «One interested only in fruitful statics must study dynamics» y el guion de *comparative-statics*); Samuelson le pone el nombre «a falta de uno mejor» (p. 258) y compara el paso a la dinámica con el de la mecánica clásica a la cuántica (p. 284). Bohr se quita (V15, V16, A29-07) |
| Nota 1 (Ramsey) | «fallece de ictericia a los 26 años» (enlace a es.wikipedia) | Murió en enero de 1930, con 26 años (MacTutor); sin la causa, que es discutida (V13) |
| I.1, utilidad | ESI ≡ σ (y el recuadro con σ); θ ≥ 0; β ∈ [0,1]; u definida en ℝ^L_+ | ESI = 1/θ sin símbolo (D001); θ > 0; 0 < β < 1; u sobre $C_t$ escalar (P38) |
| I.1, recursividad | $V(c)=u(c_0)+\beta\sum u(c_1,c_2,\dots)$ | $U_0=u(C_0)+\beta U_1$ (P38) |
| Nota 14 | «si θ = 1, nivel máximo de concavidad» | La concavidad crece con θ sin límite; θ = 1 es el caso logarítmico (l'Hôpital en nota) |
| I.1, restricciones | $b_{t+1}-b_t\equiv\dot b_t$ en tiempo discreto; $w_t$ como renta del consumidor; condición terminal $b_T=0$ | Diferencia, no derivada (nota); $Y_t$ renta no financiera; $b_{T+1}\geq0$ (igualdad en el óptimo) y no-Ponzi con horizonte infinito (P38) |
| Nota 19 | «con activos redundantes no se puede obtener la restricción intertemporal» | Con activos redundantes la restricción se cumple y lo indeterminado es la cartera; con incertidumbre hacen falta mercados completos (P11) |
| I.1, Fisher | «si r > ρ el consumidor será oferente de ahorro» | El signo del crecimiento del consumo no dice si presta o pide prestado: depende de la senda de la renta |
| Nota 26 | «Mankiw y Campbell (1989)» | Campbell y Mankiw (1989), con Hall (1988) (V25) |
| Nota 29 | «tipo de descuento y de interés nulos» | El caso de consumo constante es β(1 + r) = 1, sin suponer nada nulo |
| Anexo 2 (consumo en continuo) | $\dot c_t=\frac{1}{\theta}(r_t-\rho)$ | $\dot C_t/C_t=(r-\rho)/\theta$ (faltaba dividir por el consumo); va al cuerpo, I.1.2 b) |
| I.1, capital humano | «teorema de la separación de Acemoğlu y Autor» | Teorema de separación de Fisher (1930) e Hirshleifer (1958), que Acemoglu y Autor (2011) aplican al capital humano (P40, V30) |
| I.2, Robinson | «sin mercados de capital, $s_t=0$»; RMT con $f'(k_t)$; $k_T=0$ | $b_t$; la RMT es $1+F'(K_{t+1})-\delta$ (el capital que rinde en $t+1$); sin condición terminal en el cuerpo (P40) |
| I.2, q de Tobin | $q_t=P^I_t+\varphi(I_t)$; $\dot q_t=q_t(r+\delta)-P_t\,\partial F/\partial I_t$; $P_t$, $W_t$ nominales | $q_t=1+\Phi'(I_t)$ (coste **marginal** de ajuste); la condición dinámica se deriva respecto al **estado** (el capital), $r\,q_t=B(K_t)+\dot q_t$; notación de Romer y del 3.A.34 (P36) |
| I.2, empresas | Nota 38: $p\,f'(k_t)=p_k(r+\delta)$ | $P\,F_K=P^K(r+\delta)$ con precio del capital constante (ficha `jorgenson`) |
| I.2, Hotelling | «costes crecientes con coste marginal constante»; derivada $\partial C_t(R_{j,t})/\partial$ R mal escrita; la extracción de $J$ empresas en la ecuación de estado de una sola | Coste marginal constante, $\mathrm{CMg}$; un solo propietario; el modelo corregido, en el anexo E (P42) |
| Anexo 1 → I.1.2 | «Principio del máximo… Pontryagin (1956)» | Anunciado en 1956 por Boltianski, Gamkrelidze y Pontriaguin; publicado en Pontryagin *et al.* (1962) (V40) |
| II.1 | «Acemoğlu (2007)», «(2008)» | Acemoglu (2009), una sola obra (V35) |
| II.1, agregación | «efectos renta nulos (preferencias cuasilineales)»; «independencia de las demandas»; «trabajar con CES permite la agregación»; «Gorman implica hogar representativo normativo» | Efectos renta **iguales** (forma polar de Gorman con la misma pendiente); homotéticas **idénticas** (una misma CES) o cuasilineales en el mismo bien; el normativo exige más condiciones (A29-06) |
| II.2, rasgos | «Inmunidad a la crítica de Lucas. Es su razón de ser» | Menos expuestos por estar microfundamentados, pero no inmunes; lo que responde a Lucas es la microfundamentación, no el horizonte infinito |
| II.2, aplicaciones | «modelo de Nordhaus (1992)» sin referencia | DICE, Nordhaus (1992), *Science* (clave `Nordhaus1992Optimal`, como el 3.B.31) (V36) |
| II.1-II.2 | Erratas «segur público», «óptimo de Parteo», «calidez de dicho equilibrio al lago plazo» | Corregidas al redactar de nuevo (P44) |
| Nota 6 (Strotz) | Frase en inglés entre comillas atribuida a Strotz (1956) | Es una paráfrasis de manual: va en castellano y sin comillas, con la clave de 1955 (V19, A29-03) |
| Nota 5 (Demócrito) | Cita entre comillas sin fuente; «siglo IV a. C.» | Sin comillas, como atribución («se atribuye»); siglos V-IV a. C.; historia de la idea con Frederick *et al.* (2002) (V17, A29-04) |
| Nota 21 (Euler) | «matemático de la corte de Catalina la Grande»; la ecuación «surgió» en la braquistócrona | Redacción del 3.A.33: volvió a la Academia de San Petersburgo en 1766; la ecuación nace del cálculo de variaciones que inauguró ese problema (V24) |
| Nota 32 | Tipo real de EE. UU. del 2 % en 1962-2023 (fuente: un blog) y «la Fed de Greenspan aplicó una política restrictiva para reducir las altas tasas de inflación heredadas» | Rehecha con FRED y el Tesoro (ver § 4); sin Greenspan (la desinflación es de Volcker, 1979-1987) ni el blog (V9-V11) |
| Remisiones | «[ver tema 3.A.23]» para el 1TFEB; «[ver tema 3.B.31]» para los recursos naturales como inputs | `\vertema{3.A.22}`; el 3.B.31, para el DICE (II.2) y la paradoja verde (Hotelling) (P50) |
| Extensión del dinero (cota cero) | «$(1+i_t)<1\Rightarrow i_t<1$»; «las políticas de tipos negativos tienen un fundamento teórico ya que el dinero en metálico nos deja expuestos a un problema de coordinación intertemporal» | $i_t<0$; la inflación relevante es la esperada, $\pi_{t+1}$; el razonamiento de la trampa de liquidez con Krugman (1998); pasa al anexo G (P39) |
| II.3 → III.1, rasgos | Numeración 1, 5, 6… 10 | Rasgos 1-6 (P41) |
| II.3, rasgo 9 | «Criterio de Malinvaud-Cass» como $\sum p^*_j<\infty$; «Acemoğlu (2008)»; «[ver tema 3.A.23]» | Con infinitos bienes, lo que el 1TFEB necesita es que el valor de la dotación agregada sea finito (doble infinitud de Shell, 1971); Malinvaud (1953) y Cass (1972) caracterizan la eficiencia de las sendas de capital (nota); `\vertema{3.A.22}` (P41, P50) |
| II.3, rasgo 10 | Ineficiencia dinámica si $r^*<n$ | $r^*<(1+n)(1+g)-1\simeq n+g$ (con $g=0$, $r^*<n$), con el aviso de Abel *et al.* (1989): $r<g$ en la deuda no prueba la ineficiencia (P21) |
| II.3, rasgo 10 | «es muy difícil defender que Chad tenga un problema de exceso de acumulación de capital» | Se quita |
| II.3, modelización | $L_{t+1}=L_t(1+n-v)$ con probabilidad de muerte $v$; $c^J_t$, $w^J_t$ minúsculas | Blanchard-Yaari de palabra (en Blanchard, 1985, la población es constante); $C^J_t$, $C^V_{t+1}$, $w_t$, $S_t$ (P41, K17) |
| II.4 | «el teorema de imposibilidad de Arrow… las preferencias sociales no tienen por qué ser racionales» | Ninguna regla de agregación cumple a la vez los axiomas de Arrow, como analogía con `\vertema{3.A.24}` |
| Anexo 1 → anexo B | «$y_T=Z$ → condición de transversalidad»; «$\lim\mathcal H^ce^{-\rho t}=0$» como transversalidad; solo suficiencia de Arrow; $\mathcal H^0$/$\mathcal H^c$ con μ; «Pontryagin (1956)»; «$\lim\lambda_t=0$» con horizonte infinito | Se sustituye por la pieza común del 3.A.34: condición terminal frente a transversalidad, Mangasarian y Arrow, 𝓗⁰ y 𝓗 con $\lambda^0_t$ y $\lambda_t$, $\lim\lambda^0_ty_t=0$ (P37) |
| Tabla de signos (P34 b) | Mezclaba la derivada respecto a $p_1$ con un «efecto total $dC_1/dr$» y daba el efecto renta $\leq0$ frente al texto ($>0$ ante ↑r) | Rehecha respecto a $r$ con la ecuación de Slutsky con dotación (`tab:signos-tipo`, anexo F), con nota que explica la inversión de signos con $p\equiv1/(1+r)$ |
| Conclusión | Relevancia, Extensiones y Opinión vacías; recapitulación con «…» | Los 5 bloques (P45) |
| Enlace al test | quia.com; «Preguntas de otros exámenes» vacía | Enlace único al simulador y la pregunta 7 de julio de 2021 en el anexo I (P45, P32) |

## 3. Marcas resueltas

| Marca | Texto original | Qué se hizo |
|---|---|---|
| P1 (amarillo) | «(ver Sahuquillo)» en las extensiones de Robinson Crusoe | No se ha encontrado la referencia (contenido, C11). Se resuelve con texto propio a partir de Hirshleifer (1958) y la restricción de liquidez del 3.A.33: en el cuerpo, una viñeta de extensiones (I.2.2 a); el desarrollo, en el anexo D. El nombre se quita |
| P2 (amarillo) | «Pasamos a repasar… Control Óptimo por ser el más útil en la oposición» | El tema presenta y compara los 3 métodos (I.1.2 y tabla 1); en el anexo B copiado, la frase dice ahora que la exposición compara los 3 métodos y que el anexo C desarrolla la programación dinámica |
| P3 | Notas al opositor del cambio de temario y la tabla `image1.png` | Desaparecen; la tabla solo se usó como guía (la persistencia de las series y los juegos dinámicos, en mención) |
| P4 | Notas al opositor con stringfixer.com (roto) y Wikipedia | Desaparecen; fuentes académicas (Strotz, Thaler, Loewenstein y Prelec, Laibson, Frederick *et al.*) y `\vertema{3.A.1}` |
| P5 | Nota al opositor «Sería necesario introducir costes de ajuste… copiar lo del tema 3.A.34» | Nota de trabajo: desaparece; la idea queda en I.2.1 (sin costes de ajuste el problema no es genuinamente intertemporal) y la q en resumen en I.2.2 b) |
| P6 | Notas al opositor de manuales (Cerdá, Acemoglu, Heijdra, Obstfeld y Rogoff, Perman) | Están en la caja «Para profundizar» del anexo B copiado (con la clave `Acemoglu2009`) |
| P7 | Comentario «Meter principio de correspondencia (Samuelson, importado de la física, Bohr) y estática comparativa» | Integrado en la contextualización con la cita comprobada; sin Bohr (A29-07) |
| P8 | Comentario «Está muy bien un papel doblado que hay en la carpeta» | Privado: no se publica |
| P9 | Comentario «Cantado en clase… (17/03/2023)… me quedé corto de tiempo (27′30″)… me faltó derivar algún modelo más» | Privado. Lo que pedía: el RCK en resumen (II.2) y Diamond completo (III.1) |
| P10 | Comentarios «Coordinar… 3.A.1 y 3.A.29» y «Meter función de descuento hiperbólica… detalle de calidad» | Descuento hiperbólico en resumen en II.2 b) (consistencia temporal), con la hiperbólica generalizada nombrada (Loewenstein y Prelec, 1992), el cuasihiperbólico en nota con el aviso de letras y el gráfico `descuento` |
| P11 | Comentario «Ver clase [profesor]… mercados financieros incompletos y activos redundantes» | Privado; la nota 19 se corrige |
| P12 | Comentario «Coordinar en tema 3.A.29 y tema 3.A.33» (Fisher) | Fisher en resumen (I.1.3 a) con `\vertema{3.A.33}` |
| P13 | Epígrafe vacío de C-CAPM y Hall con «Desarrollar la próxima vez…» | Euler estocástica en I.1.2 d) y mención de Hall y del C-CAPM en I.1.3 c) |
| P14 | «Coordinar en temas 3.A.29 y 3.A.34… aquí habría que resumirlo mucho más» | q en resumen, con los errores corregidos |
| P15 | «Sacado del tema de ICEX-CECO, hecho por [preparador]…» (Hotelling) | No se publica; se cita Hotelling (1931) (y Perman *et al.*, 2011, en el anexo: anexo E) |
| P16 | «Esta sección habría que copiar bien lo de ICEX-CECO (págs. 29 a 34)» | No se publica; II.2 redactado de nuevo con el canon |
| P17 | «Coordinar con el modelo del tema 3.A.38 de pensiones» (2 comentarios) | No se publican. El 3.A.29 deriva el OLG y da las pensiones como salida a la ineficiencia dinámica (condición de Aaron, anexo H d) con `\vertema{3.A.38}` `\vertema{4.B.24}`; lo que deben hacer el 3.A.38 y el 4.B.24, en `canon/pendientes-coherencia.md`, «Adelantado del 3.A.29» |
| P18 | «Está muy bien, seguir por aquí», nota del 21/07/2021 en la entrada de Acemoğlu, línea «Tema [preparador]» | No se publican. La lectura de ICEX-CECO (Rodríguez López, 2016) no se cita, por decisión del coordinador (A29-13) |
| P19 | «Coordinar este anexo en los temas 3.A.29, 3.A.34, 3.A.43, 3.A.33…» y «Ver el anexo al tema 3.A.42 antiguo de ICEX-CECO… Bellman» | No se publican. Anexos A y B = la pieza común copiada con las 5 frases adaptadas (K7) y la caja de letras; anexo C nuevo de programación dinámica (C15) |
| P46 | Cajas de anotaciones: vídeo de Fonseca y Wikipedia «Intertemporal choice» | Enlaces comprobados (funcionan); en la caja «Para saber más» tras la nota del reparto, con su entrada en la bibliografía (fecha del vídeo, 13/09/2021, comprobada en YouTube) |
| P55 | Resto de notas privadas | Ninguna se publica |

## 4. Datos actualizados

| Dato | Valor anterior | Valor nuevo | Fuente | URL | Consulta | Segunda comprobación |
|---|---|---|---|---|---|---|
| Mecanismo de equidad intergeneracional (relevancia; nuevo) | — | 0,90 puntos en 2026 (0,75 empresa, 0,15 trabajador); 1,2 en 2029 y hasta 2050; no computa para prestaciones y nutre el Fondo de Reserva | BOE, LGSS consolidada, art. 127 bis y DT 43.ª (RDL 2/2023) | https://www.boe.es/buscar/act.php?id=BOE-A-2015-11724 | 01/11/2026 | Texto consolidado leído de nuevo por el editor el 1/11/2026 (art. 127 bis y la escala de la DT 43.ª): cuadra |
| Tipo real de EE. UU. a 10 años (nota 32) | +2 % (1962-2023, un blog) | 2,0 % (1962-2025, con el IPC); 4,2 % (1980-1999); 0,5 % (2008-2021); −0,5 % (2022-2025) | FRED (GS10, CPIAUCSL) | https://fred.stlouisfed.org/series/GS10 | 01/11/2026 | AMECO ILRV (deflactor): 2,2 %; el editor recalculó las medias con el CSV (1,95; 4,20; 0,45; −0,50) |
| TIPS a 10 años (nota 32; nuevo) | — | 2,60 % el 30/10/2026 | Tesoro de EE. UU., curva real diaria | https://home.treasury.gov/resource-center/data-chart-center/interest-rates/TextView?type=daily_treasury_real_yield_curve&field_tdr_date_value=2026 | 01/11/2026 | FRED DFII10: 2,63 % el 29/10/2026 |
| Edad de Ramsey | «a los 26 años» | 25 años al publicar (diciembre de 1928); murió con 26 (enero de 1930) | MacTutor | https://mathshistory.st-andrews.ac.uk/Extras/Ramsey_death/ | 01/11/2026 | SEP, «Frank Ramsey» |
| r − g (III.1 d; nuevo, gráfico `r-menos-g`) | — | España −0,8 puntos de media en 2000-2025; zona del euro −0,5 (2002-2025); EE. UU. −0,8 (1962-2025); +1,8 (EE. UU.) y +1,7 (España) en 1980-1999; 2025: −2,5, −0,8 y −0,7 | CE, AMECO (ILRV, OVGD), primavera de 2026 | https://ec.europa.eu/economy_finance/ameco/wq/series?fullVariable=1.1.0.0.ILRV&countries=ESP,EA12,EA20,USA | 01/11/2026 | Eurostat (`irt_lt_mcby_a` y `nama_10_gdp`) y FRED/BEA: diferencias de hasta 0,4 puntos (fase de datos, V1) |
| Criterio de Abel (III.1 d; nuevo, gráfico `criterio-abel`) | — | 2025: rentas brutas del capital 43,4 / 43,1 / 45,6 % del PIB frente a una inversión de 21,4 / 21,9 / 21,4 % (España, zona del euro, EE. UU.) | CE, AMECO (ALCD0, UITT, UVGD) | https://ec.europa.eu/economy_finance/ameco/wq/series?fullVariable=1.0.0.0.ALCD0&countries=ESP,EA20,USA | 01/11/2026 | Abel *et al.* (1989), signo del resultado: cuadra (V5) |
| Dependencia de mayores (III.1 c; nuevo, gráfico `demografia-pensiones`) | — | España 31,2 % (2025) → 54,7 % (2050, EUROPOP2025); INE (16-64): 51,8 % en 2050 | Eurostat (`demo_pjanind`, `proj_25ndbi`); INE | https://ec.europa.eu/eurostat/databrowser/view/proj_25ndbi/default/table | 01/11/2026 | INE, proyecciones 2026-2076: el nivel difiere desde 2045 por las hipótesis de migración; no se mezclan en la misma línea (V6) |
| Gasto en pensiones (III.1 c; nuevo) | — | España 13,1 % del PIB (2022) → 17,3 % (2050); zona del euro 12,6 % (2050) | CE y CPE, *2024 Ageing Report* | https://economy-finance.ec.europa.eu/publications/2024-ageing-report-economic-and-budgetary-projections-eu-member-states-2022-2070_en | 01/11/2026 | Ficha de España del mismo informe (no independiente) (V7) |

## 5. Contenido añadido

- **I.1.2 Métodos de resolución** (nuevo, C14, DK4): el mismo consumidor resuelto con Lagrange (Euler, `eq:euler`, función clave), control óptimo (hamiltoniano en valor corriente, `eq:euler-continua`) y programación dinámica (`eq:bellman`, función clave; principio de optimalidad, envolvente, ejemplo logarítmico $C_t=(1-\beta)(1+r)b_t$ comprobado), la Euler estocástica (`eq:euler-estocastica`) y la **tabla 1** de comparación (`tab:metodos`, con la fila de la Euler en salvia). Fuentes: Bellman (1952, 1957), Pontryagin *et al.* (1962), Stokey y Lucas (1989), Ljungqvist y Sargent (2018), Acemoglu (2009), Cerdá (2001).
- **I.1.1**: fundamento axiomático (Koopmans, 1960; Fishburn y Rubinstein, 1982), «genuinamente intertemporal» definido (lo usan el 3.A.38, el 3.A.42 y el 4.B.4).
- **I.1.3**: el capital humano como separación de Fisher; Hall y el C-CAPM en mención; nota 32 nueva.
- **I.2**: la empresa sin costes de ajuste no es genuinamente intertemporal (Jorgenson); Robinson Crusoe, q y Hotelling en resumen, con Modigliani y Miller (1958) en nota y la paradoja verde.
- **II.1**: la historia del agente representativo con su fuente (Hartley, 1996), los 3 sentidos, Gorman con la misma pendiente y Sonnenschein-Mantel-Debreu, Weil (1989).
- **II.2**: la dinastía de Barro (1974) y la equivalencia ricardiana; las 3 condiciones del horizonte infinito (utilidad acotada, no-Ponzi, transversalidad, con Michel, 1982); la consistencia temporal (Strotz, Thaler, Loewenstein y Prelec, Laibson, Kydland y Prescott) con el gráfico `descuento`; cómo se resuelven (planificador, estado estacionario, senda de silla, Blanchard y Kahn, 1980, impulso-respuesta y persistencia de las series); el RCK en resumen con las ecuaciones del 3.A.43 (`eq:hogar-rck`, `eq:euler-rck`, `eq:acumulacion-rck`) y la regla de oro modificada; aplicaciones con DICE, EGDE nuevokeynesianos y crecimiento endógeno.
- **III.1** (C19, K13): rasgos corregidos; Samuelson (1958) con dinero (a-c, gráfico `samuelson`, pegatina «cuando seas padre, comerás huevos»); Diamond (1965) completo (a-e) con `eq:ahorro-diamond`, `eq:diamond` (función clave), $k^*$, δ = 1 para la solución cerrada (A29-15), regla de oro discreta, ineficiencia dinámica y su plausibilidad ($\beta>\alpha/(1-2\alpha)$, comprobado), pegatina «la avaricia rompe el saco», deuda (Blanchard, 2019), equivalencia ricardiana (Barro, 1974), pensiones con Aaron (1966) y datos de envejecimiento, burbujas (Tirole, 1985), Blanchard-Yaari, Feldstein, Weil, Lapan y Enders, Auerbach y Kotlikoff; evidencia con r − g, el criterio de Abel *et al.* (1989) y Geerolf (2018); `tab:mhi-mgs` (K14 y C19 fundidas).
- **III.2** (C21, K15): Kirman (1992), Aiyagari (1994), Krusell y Smith (1998), HANK (Kaplan, Moll y Violante, 2018), Galí, López-Salido y Vallés (2007), modelos basados en agentes, IKE (Frydman y Goldberg, 2007), De Grauwe (2012), Wren-Lewis (2018).
- **Conclusión** (C23, K16) con sus 5 bloques; la idea final retoma el refrán y responde a Ramsey.
- **Anexos**: A y B (pieza común, copiadas y adaptadas); C programación dinámica (C15, nuevo); D Robinson Crusoe (C11, con la restricción de liquidez y la desinversión del anexo 3 del original); E Hotelling (C13); F estática comparativa con `tab:signos-tipo` (el original, rehecho); G cota cero (C8 y el original); H Diamond paso a paso (C22, con la utilidad general, la estabilidad, la regla de oro y las pensiones); I test (C27).

## 6. Coherencia

- **Estructura y minutos** (DK1 con los minutos del coordinador): I 8′30″ (I.1 6′, I.2 2′30″), II 8′ (II.1 2′, II.2 6′), III 10′ (III.1 8′, III.2 2′). Los títulos de 2.º nivel del original se conservan (I.1, I.2, II.1, II.2; III.1 y III.2 son el II.3 y el II.4 del original).
- **Notación del canon** (§ 7): $C_t$, $b_t$, $Y_t$, $U_0$, β ≡ 1/(1 + ρ), θ > 0, ESI = 1/θ sin símbolo, CRRA con el −1 (`eq:crra`, como el 3.A.8 y el 3.A.33), 𝓗 en valor corriente con $\lambda_t$, $V(b_t)$ con argumento para la función de valor (DK12), $\Phi(I_t)$, $B(K)$, $\kappa_t$ y $q_t$ como el 3.A.34, $k$ y $c$ por unidad de trabajo eficiente, $n+g+\delta$ y $k_{\mathrm{oro}}$ como el 3.A.43. El cuasihiperbólico β-δ, solo en nota con el aviso (D105).
- **Lo que prometen los temas revisados**, cumplido: 3.A.33 (descuento exponencial, Bellman, no-Ponzi y transversalidad), 3.A.34 (λ_t como precio sombra), 3.A.43 (descuento exponencial, Strotz, hiperbólico con 3.A.1; consumidor de horizonte infinito en continuo), 3.A.25 (Euler, no-Ponzi), 3.A.26 (control óptimo), 3.A.8 y 3.A.10 (CRRA, ESI = 1/θ, θ = $r_R$). Lo de Diamond, en III.1 (ver abajo).
- **Claves bibliográficas**: las de `bib-datos.bib` mandan (`Acemoglu2009`, `Samuelson1937`, `Blanchard2019Deuda`, `Hartley1996Origins`, `Nordhaus1992Optimal`), salvo Strotz: `Strotz1955Myopia` (Crossref, 1955), como el 3.A.33 y la ficha `descuento-hiperbolico`, por decisión del coordinador. **Contradicción**: el 3.A.43 usa `Strotz1956` (1956); pendiente de coherencia para unificarlo (A29-03).
- **Pieza común**: anexos A (del 3.A.33) y B (del 3.A.34) copiados con las 5 frases adaptadas de K7 (3 en A, 2 en B) y además: en A, `\eqref{eq:problema-hall}` y `\ref{fig:fisher-tipo-interes}` → `\vertema{3.A.33}`, $h_{C_1}(p,\overline U)$ en lugar de $C_1^h$, y `notaopositor` simétrica; en B, la frase de P2, el ejemplo del consumidor, la q y Hotelling en lugar de Jorgenson, la caja de letras $y_t$, $u_t$ (con las $x_t$, $z_t$ del 3.A.44) y `Acemoglu2009` en lugar de `Acemoglu2009Introduction` (como el 3.A.43 y el 3.A.44). Si se cambia algo de la pieza, hay que cambiarlo en el 3.A.33, el 3.A.34, el 3.A.43 y aquí.
- **Remisiones nuevas**: 3.A.1, 3.A.6, 3.A.7, 3.A.8, 3.A.9, 3.A.10, 3.A.14, 3.A.17, 3.A.21, 3.A.22 (en lugar del 3.A.23), 3.A.24, 3.A.25, 3.A.26, 3.A.27, 3.A.35, 3.A.36, 3.A.37, 3.A.38, 3.A.39, 3.A.40, 3.A.42, 3.A.43, 3.A.44, 3.B.5, 3.B.12, 3.B.31 (DICE y paradoja verde, no «recursos naturales como inputs») y 4.B.24. Lo que prometen el 3.A.43 (Diamond, ineficiencia dinámica, equivalencia ricardiana con OLG), el 3.A.21 (dinero en OLG) y el 3.A.33 (OLG como ciclo vital en equilibrio general) se cumple en III.1.
- **Registrado en `canon/pendientes-coherencia.md`** («Adelantado del 3.A.29»): Strotz 1956 del 3.A.43 → `Strotz1955Myopia`; $C_1^h$ del 3.A.33; las 2 escrituras del no-Ponzi; las fichas `pensiones` y `olg-samuelson-diamond`; y, para cuando se revisen, el 3.A.1, el 3.A.38, el 4.B.24, el 3.B.23, el 3.A.35 y el 3.A.42. Ningún otro tema se ha tocado.
- **Para la fase canon** (CC1-CC9 de coherencia): Parte 3 de `optimizacion-dinamica` (anexo C y `tab:metodos`), gráfico de referencia `diamond.tex` y δ = 1 en `olg-samuelson-diamond`, gráfico `descuento.tex` en `descuento-hiperbolico`, fichas nuevas `regla-hotelling` (anexo E) y `agente-representativo` (II.1 y III.2), Robinson en `fisher-intertemporal` (anexo D), $V(b_t)$ en `notacion.md` § 7.

## 7. Dudas abiertas

| Id | Duda | Aplicado | Alternativa |
|---|---|---|---|
| A29-01 | 3 apartados en lugar de los 2 del original, con títulos de 1.er nivel nuevos: «La modelización dinámica de las decisiones: enfoque microeconómico» (antes «Análisis intertemporal de consumidores y empresas: enfoque microeconómico»), «El agente representativo de vida infinita» y «Generaciones solapadas y heterogeneidad» (DK1, D1) | 3 apartados con los minutos del coordinador | 2 apartados (I 8′30″, II 18′) o los títulos literales del original |
| A29-02 | Enganche: «No dejes para mañana…» con la pregunta de Ramsey como hilo (DK5), frente a «Cuando seas padre, comerás huevos» con el mecanismo de equidad intergeneracional (D3 de contenido) | DK5; el mecanismo, como dato de la relevancia; «Cuando seas padre…» pasa a pegatina de las generaciones solapadas | El enganche de contenido |
| A29-03 | Año de Strotz: 1955 (`Strotz1955Myopia`, Crossref, 3.A.33 y ficha) o 1956 (`Strotz1956`, 3.A.43 y la fase de datos) | 1955 | 1956 en todos (cambiar el 3.A.33 y la ficha) |
| A29-04 | Atribuciones del original sin fuente localizada: Hicks (definir una define la otra), Baumol (economía política), Tinbergen (2 formas de estudiar) y Demócrito | Paráfrasis sin comillas; Demócrito como «se atribuye» | Quitarlas |
| A29-05 | Principio de optimalidad de Bellman: cita literal con página (p. 83) sin comprobar | Paráfrasis sin comillas, con Bellman (1952) en nota | Cita literal si se comprueba la página |
| A29-06 | Gorman y el hogar representativo normativo (D7) | «Exige más condiciones» (Acemoglu, 2009, cap. 5) | Dejar «implica» como el original |
| A29-07 | Bohr en el principio de correspondencia | Quitado; solo lo que dice *Foundations* (pp. 258 y 284) | «El nombre coincide con el de Bohr», sin afirmar que lo importó |
| A29-08 | Letras genéricas del anexo de control óptimo (DK3, D10) | $y_t$, $u_t$ con la caja de aviso que menciona las $x_t$, $z_t$ del 3.A.44 (anexo B; el anexo C usa las mismas) | $x_t$, $z_t$ en toda la pieza |
| A29-09 | Frase de Joan Robinson (mapa a escala 1:1) en III.2 (DK7) | **No se pone**; se pregunta a Víctor en el artifact | En III.2 o en la «Opinión» de la conclusión |
| A29-10 | Gráficos de datos: series anuales o medias móviles; EUROPOP2025 o *Ageing Report* (V3, V8) | Medias móviles de 5 años; EUROPOP2025 en el panel de demografía y la cifra del INE en el texto; pensiones del *Ageing Report* en un segundo panel | Series anuales con el eje recortado |
| A29-11 | Página de Mas-Colell, Whinston y Green (p. 733) sin comprobar (V23) | Se cita por sección (20.B) | La página, si Víctor la confirma en su ejemplar |
| A29-12 | Historia del agente representativo: Hartley (1996, *JEP*, verificado en Crossref, no leído) o su libro de 1997 (propuesta de contenido) | Hartley (1996) | El libro de 1997 |
| A29-13 | Lectura de ICEX-CECO (Rodríguez López, 2016) de la bibliografía del original: CRITERIOS dice citarla como en el original; el coordinador pide quitar ICEX-CECO | No se cita | Recuperar la entrada `RodriguezLopez2016Intertemporales` de `bib-datos.bib` |
| A29-14 | Pregunta 7 del examen de julio de 2021 (`preguntas.json`, id 202, `temas: ["3.A.33"]`) (D12) | Citada en nota con remisión al anexo de test; añadir «3.A.29» a sus temas lo hace quien publique (fuera de `_trabajo/`) | Dejarla solo en el 3.A.33 |
| A29-15 | Diamond con solución cerrada: δ = 1 (Acemoglu) o δ = 0 (Romer) (D9) | δ = 1, avisando de que la ley de movimiento no depende de δ; da el criterio $\beta>\alpha/(1-2\alpha)$ | δ = 0, sin criterio sencillo |
| A29-16 | «Fisher frente a Keynes» del original (D11): no se ha encontrado de quién es | En la «Opinión» de la conclusión, como opinión propia, sin comillas ni atribución y matizada con la nueva economía keynesiana | Quitarla |
| A29-17 | «El 2TFEB sí se cumple en los MGS» del original (D6) | Quitado: no se ha podido comprobar | Mantenerlo citando a Balasko y Shell (1980), sin comprobar |
| A29-18 | Reservas del recurso con $S_t$ en Hotelling (D8), la misma letra que el ahorro de Diamond | $S_t$, como Perman y Hotelling, con nota | Otra letra local |
| A29-19 | Perloff (2012): edición y contenido de la nota 50 sin comprobar (V33) | Se mantiene la cita en la nota del anexo E (regla de mantener las fuentes del original) | Quitarla |
| A29-20 | Samuelson (1958) con dinero en el cuerpo (III.1, \tiempo{1,5}) o en un anexo (DK10) | En el cuerpo, como pidió el coordinador; las 3 figuras de MWG se sustituyen por el gráfico `samuelson` | Anexo, con una mención en el cuerpo |
| A29-21 | Anexo H (Diamond paso a paso, C22), que no estaba en la lista del coordinador | Se incluye: es la derivación que el cuerpo resume (CRITERIOS § 2) | Quitarlo |
| A29-23 | Parámetros del gráfico de Diamond: con α = 1/3 (los de la cabecera propuesta) $k_{\mathrm{oro}}$ queda a la derecha de $k^*$ y no se ve la ineficiencia | α = 0,3 y β = 0,9 ($k^*=1{,}957$, $k_{\mathrm{oro}}=1{,}696$), dicho en la fuente | Mantener α = 1/3 y quitar la capa de $k_{\mathrm{oro}}$ |
| A29-22 | El dibujo a mano de la desinversión (anexo 3 del original) se entiende solo en parte | Una viñeta de extensiones en el anexo D y una capa opcional del gráfico `robinson-crusoe` | Que Víctor lo explique |
| A29-23 | Gráfico `diamond` (control de calidad, 1/11/2026): dibujaba $k_{t+1}=1{,}6\,k_t^{1/3}$ con $k_{\mathrm{oro}}<k^*$, es decir, la ineficiencia dinámica con $\alpha=1/3$, que el texto declara imposible ($\beta>\alpha/(1-2\alpha)=1$) | Recomendada: $\alpha=0{,}3$ y $\beta=0{,}9$, que sí la cumplen ($k^*/k_{\mathrm{oro}}=1{,}15$), con los parámetros en el pie | $\alpha=1/3$ con $k_{\mathrm{oro}}$ a la derecha de $k^*$ (caso eficiente; con $\beta=0{,}8$, $k_{\mathrm{oro}}=1{,}19\,k^*$) |

### Control de calidad (1/11/2026): correcciones aplicadas

- Fuente del gráfico de Diamond: parámetros ilustrativos α = 0,3 y β = 0,9 ($k^*=1{,}957$, $k_{\mathrm{oro}}=1{,}696$); con α = 1/3, $k_{\mathrm{oro}}$ quedaría a la derecha de $k^*$ (A29-23, aplicada la recomendada: el gráfico pasa a α = 0,3 y β = 0,9 para que se vea la ineficiencia dinámica). El texto no citaba valores del gráfico.
- Fuente de `r-menos-g`: medias móviles de 5 años hacia atrás; zona del euro EA12 hasta 2001 y EA20 desde 2002. En el texto, «datos anuales; el gráfico, en medias de 5 años».
- Tabla 1, fila «Referencia»: con `\textcite` (Fisher, 1930; Pontryagin *et al.*, 1962; Bellman, 1957).
- Gráfico `robinson-crusoe` a 0,95 del ancho.
- Heijdra unificado en la edición de 2009 (`Heijdra2009Foundations`, la del anexo B); el anexo F no cita página, así que la de 2017 se quita del `.bib`.
- INE: se dice que su tasa de dependencia usa la población de 16 a 64 años en el denominador.
- `.bib`: Stokey, Lucas, Jr. y Prescott (1989) con el «Jr.» en su sitio; Blanchard (2019), «Olivier J.».
- `seo.json`: 18 palabras clave (fuera «hamiltoniano»).

## 8. Instrucciones para el vídeo

- **Enganche y cierre**: «No dejes para mañana lo que puedas hacer hoy» y la pregunta de Ramsey (1928), ¿cuánto de su renta debe ahorrar una nación?, que hila los 3 bloques: el hogar ahorra hasta que $r$ compensa ρ (I); con un agente de vida infinita el mercado nunca ahorra de más (II); con generaciones solapadas puede ahorrar de más (III). La idea final vuelve al refrán («conviene dejar para mañana lo que mañana valga más», que es la Euler) y responde a Ramsey: depende de cómo se modelice el tiempo; generaciones que se suceden pueden ahorrar de más, «avaricia que rompe el saco».
- **Pizarra en 3 columnas** (nota del reparto). Izquierda, todo el tema: el problema del consumidor en una línea y, **recuadradas y conservadas** (`conservar:`), la ecuación de Euler (`eq:euler`) y la de Bellman (`eq:bellman`); en III se añade la ley de movimiento de Diamond. Centro: la **tabla de los 3 métodos** se construye columna a columna mientras se cuenta cada método (la fila de la Euler, la última que se escribe, en salvia); se borra al acabar I. En II, en la misma columna, las 3 ecuaciones del RCK (hogar, `eq:euler-rck`, `eq:acumulacion-rck`) y $f'(k^*)=\rho+\delta+\theta g<f'(k_{\mathrm{oro}})=n+g+\delta$; sin diagrama de fases (remitido al 3.A.43). Derecha: reservada para III (gráfico de Diamond y cuadro de horizonte infinito frente a generaciones solapadas; «MHI / MGS» se escriben como cabecera en II.1).
- **I.2**: las 2 condiciones de la q bajo la ecuación de Euler, diciendo que es la misma lógica de arbitraje; Robinson y Hotelling de palabra.
- **Apoyo** (no se escribe): el gráfico `descuento` en II.2 (consistencia temporal), la braquistócrona si se menciona a Euler, y las definiciones de MHI y MGS.
- **Pegatinas**, en una esquina al decirlas: «cada cosa a su tiempo» (Bellman, I.1.2 c), «de tal palo, tal astilla» (dinastía, II.2 a); en III, «cuando seas padre, comerás huevos» y «la avaricia rompe el saco» (esta, a propósito, como en el 3.A.43).
- **III (columna derecha)**: el gráfico `diamond` por capas (ejes, bisectriz, ley de movimiento, $k^*$, escalera desde $k_0$ y, al hablar de la ineficiencia, $k_{\mathrm{oro}}$); `eq:diamond` recuadrada en la columna izquierda, bajo la Euler y la Bellman, y $S_t=\beta w_t/(1+\beta)$ al lado; $r^*<n+g$ escrito. En la columna central (borrado el RCK salvo $f'(k^*)=\rho+\delta+\theta g$), el cuadro `tab:mhi-mgs` con sus 2 columnas, que se llena contraponiendo cada fila, con la de la eficiencia dinámica en salvia: es el gráfico conjunto del tema (la cabecera «MHI / MGS» se escribió en II.1). Al final la pizarra queda con las 3 funciones clave, el gráfico de Diamond y el cuadro.
- **Apoyo en III**: el gráfico `samuelson` (autarquía y equilibrio monetario), los 3 gráficos de datos (`r-menos-g` con el aviso de Abel, `criterio-abel` y `demografia-pensiones`).
- **Conclusión**: empieza por «En conclusión,»; sin pizarra; sin número de temas en voz alta; la última frase es la respuesta a Ramsey.
- Introducción y conclusión, sin pizarra. No decir números de temas en voz alta.

## Estado de las propuestas

### Contenido (C1-C29)

| Propuesta | Estado |
|---|---|
| C1 (estructura) | Aplicada con la estructura y los minutos del coordinador (DK1 de coherencia): los métodos van dentro de I.1 (I.1.2), no como I.3 |
| C2 (introducción) | Aplicada salvo el enganche (A29-02): el mecanismo de equidad intergeneracional pasa a la relevancia; Frisch (1933) como primer modelo dinámico del ciclo (la afirmación de que Samuelson fecha ahí la revolución dinámica no se comprobó y se quita); la caja de anotaciones, tras la nota del reparto |
| C3 (nota de *Foundations*) | Aplicada sin Bohr (A29-07) |
| C4 (preferencias) | Aplicada; la consistencia temporal y el hiperbólico pasan a II.2 (decisión del coordinador); MWG por sección (A29-11) |
| C5 (gráfico `descuento`) | Pedido; la figura va en II.2 |
| C6 (restricciones y Fisher) | Aplicada; el problema de $T$ periodos va en I.1.2 a) |
| C7 (recorte de la estática comparativa) | Aplicada: anexo F, con la tabla de signos rehecha (`tab:signos-tipo`) y la imagen 2 descrita de palabra con remisión al gráfico del 3.A.33 |
| C8 (cota cero) | Aplicada en el anexo G (no en nota), con el razonamiento del original corregido |
| C9 (capital humano) | Aplicada |
| C10 (empresas) | Aplicada; la apertura de I, con la conclusión anticipada de K |
| C11 (Robinson) | En el cuerpo, de palabra (decisión del coordinador); el modelo y el gráfico, en el anexo D, con «iv) Extensiones» pasado a «c) Extensiones» |
| C12 (q) | Aplicada, con Tobin (1969) |
| C13 (Hotelling) | En el cuerpo, de palabra; el modelo, en el anexo E con la estructura a)-b) |
| C14 (métodos) | Aplicada en I.1.2; su párrafo e) (silla, Blanchard-Kahn, series) pasa a II.2 b) (decisión del coordinador) |
| C15 (anexo de Bellman) | Aplicada (anexo C), con la Euler estocástica y las aplicaciones |
| C16 (piezas comunes) | Aplicada (anexos A y B); la `notaopositor` de A con el texto de K7 |
| C19 (generaciones solapadas) | Aplicada con la decisión del coordinador (δ = 1, aviso de Abel, gráficos de datos); la tabla se funde con K14 en `tab:mhi-mgs`; Geerolf (2018) con la redacción del resumen leído |
| C20 (gráficos `diamond` y `samuelson`) | Pedidos (los dibujan otros agentes) |
| C21 (limitaciones) | Aplicada, con la frase de Kirman sobre qué heterogeneidad importa (sin la de Joan Robinson, A29-09) |
| C22 (Diamond paso a paso) | Aplicada (anexo H, A29-21) |
| C23 (conclusión) | Aplicada con el enganche del coordinador; la «Opinión» recoge la idea de Fisher frente a Keynes (A29-16) |
| C27 (test) | Aplicada (anexo I); RodriguezLopez2016 no se cita (A29-13) |
| C17 (agente representativo) | Aplicada (A29-06) |
| C18 (horizonte infinito) | Aplicada, con la consistencia temporal y el gráfico `descuento` |
| C24 (recortes) | Aplicados los de la parte 1 (tabla «Componentes» sustituida por la viñeta de las 4 piezas; notas 3, 31-34, 37-39, 42-46) |
| C25 (notas privadas) | Aplicada (§ 3) |
| C26 (remisiones) | Aplicada |
| C28 (nota 32) | Aplicada con cifras de FRED y el Tesoro (decisión del coordinador; contenido proponía no poner cifras) |
| C29 (notas sueltas) | Aplicada |

### Datos (V1-V45)

V9-V11 (nota 32), V12-V15, V18-V21, V24-V27, V30, V32, V34-V36, V40, V41: aplicados en la parte 1. V16 (Bohr): quitado. V17 (Demócrito): sin comillas. V22: pie del gráfico con Angeletos *et al.* (2001). V23: por sección. V1-V2 y V4-V7 en III.1 (V3, medias móviles; V8, EUROPOP2025 en la demografía y el *Ageing Report* solo en las pensiones, A29-10), V37-V39, V42 y V45 aplicados en la parte 2. V28 (Heijdra sin página), V29 (Busch, p. 46) y V33 (Perman sin páginas; Perloff, A29-19) en los anexos. V31: la fuente del gráfico de Robinson es teórica. V43 (Escot *et al.*, Docta): el original solo la citaba en la bibliografía; no se cita en el texto y no sale. V44 (ICEX-CECO): no se cita (A29-13).

### Coherencia (K1-K18, DK1-DK13, CC1-CC9)

K1 (con los títulos del coordinador, A29-01), K2, K3, K4 (texto adaptado a los 3 títulos), K5 (enganche), K6, K8 (tabla con las filas de contenido, más completa), K9, K10, K11, K12 y K17 (notación) aplicadas; K18 (nota del reparto) aplicada con los minutos del coordinador. K7, K13, K14 (fundida con la tabla de C19), K15 y K16: aplicadas en la parte 2. DK1, DK2, DK4, DK5, DK6 (con «cuando seas padre, comerás huevos» en lugar de «hijo eres, padre serás»), DK8, DK9 y DK12 aplicadas; DK7 no (A29-09); DK3 (caja de letras), DK10 (Samuelson en el cuerpo, A29-20), DK11 (Aaron) y DK13 (la persistencia de las series en II.2 b; los juegos dinámicos en la estructura y la conclusión) aplicadas. CC1-CC9 son cambios al canon (fase canon).

### Pendientes (P1-P55)

Resueltos todos. Parte 1: P1 (cuerpo), P3-P5, P7-P16, P18, P20, P22 (anexo 2 al cuerpo), P23 (pedido), P30 (copiado), P32 (sin captura), P34 a), P35, P36, P38, P40, P43, P44, P46, P47, P48, P50-P52 (en lo que toca a I y II), P55. Parte 2: P1 (anexo D), P2, P6, P17, P19, P21, P24 (remitido al gráfico del 3.A.33), P25-P26 y P31 (gráfico `robinson-crusoe`), P27 (foto quitada), P28 (gráficos `samuelson` y `diamond`), P29 y P34 c) (`tab:hamiltonianos` de la pieza), P33 (el esquema de la nota 47 queda solo como nota, sin gráfico), P34 b) (`tab:signos-tipo`), P37, P39, P41, P42, P45, P49, P53 (coherencia con el 3.A.43 y el 3.A.44) y P54 (fichas, en la fase canon).
