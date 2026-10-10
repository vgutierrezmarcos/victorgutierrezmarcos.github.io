# Revisión del tema 3.A.8 (10/10/2026)

Teoría de la demanda del consumidor (I). Axiomas sobre las preferencias, función de utilidad y función de demanda marshalliana. La teoría de la preferencia revelada. Precios hedónicos.

Este informe se ha escrito en tres partes, igual que el tema. La parte 1 cubre la Introducción y el apartado I (I.1 Preferencias y funciones de utilidad, I.2 Restricción presupuestaria y función de demanda individual, I.3 Agregación). La parte 2 cubre los apartados II (Estática comparativa: efecto renta, efecto precio propio y efecto precio cruzado) y III (Otros desarrollos: preferencia revelada, producción doméstica y precios hedónicos). La parte 3 cubre la Conclusión, la Bibliografía y los anexos. Las referencias «C», «V», «K» y «P» remiten a `_trabajo/propuestas-contenido.md`, `propuestas-datos.md`, `propuestas-coherencia.md` y `pendientes.md`.

## Resumen

- El tema se reorganiza con la estructura que propuso el tribunal (K1): I. La función de demanda (con un I.3 nuevo de agregación y efecto renta nulo); II. Estática comparativa; III. Otros desarrollos (preferencia revelada, producción doméstica y precios hedónicos, los dos últimos nuevos). Cante de 30 minutos: 3 + 10 + 7 + 7 + 3.
- Se han corregido 85 errores de teoría, fechas y atribuciones (axiomas, Kuhn-Tucker, Gorman, tablas de Slutsky, Giffen y Veblen, preferencia revelada, Griliches, formas funcionales y preferencias macro del anexo) y se han resuelto todas las marcas del Word; nada privado pasa a la fuente.
- Datos nuevos y citados con doble comprobación: consumo de los hogares en el PIB (Eurostat e INE, 2025), ley de Engel con la EPF 2025 e índices de precios con ajuste hedónico (INE, Eurostat y BLS; el del BLS, con comprobación parcial). Bibliografía completa en `3A08.bib`.
- La conclusión se reescribe con una valoración crítica con fuentes (Friedman, Simon, Kahneman y Tversky, Thaler, Sen), extensiones con remisiones y tres anexos (enfoque cardinal, formas de la utilidad y test); salen del tema Lancaster (a 3.A.18), los sistemas de demanda (a 3.A.9), la media-varianza y el Anexo 1 escaneado.
- Se han pedido 17 gráficos (`_trabajo/graficos-pedidos.json`); el PDF compila (45 páginas) y las dudas que requieren a Víctor están al final, por prioridad.

## Errores corregidos

| Dónde (original) | Decía | Dice ahora | Propuesta |
|---|---|---|---|
| Introducción, enganche (l. 41) | Cita de Marshall en cursiva que no es literal («…alcanzar un nivel máximo de bienestar») | Traducción fiel de *Principles*, libro I, cap. I, §1, citada | C3, V1 |
| Introducción, Gossen (l. 81-87) | «Las 3 leyes de Gossen»; la segunda sin ponderar por precios | Dos leyes, la segunda con $UMg_i/p_i$ iguales. La «ley de la escasez» se presenta como añadido de manuales posteriores | C5, V38 |
| Introducción (l. 89) | La Revolución Marginalista la hacen Walras y Marshall, «siguiendo a Gossen» | Jevons (1871), Menger (1871) y Walras (1874), de forma independiente; Jevons redescubre a Gossen en 1879; Marshall (1890) sistematiza | C4 |
| Introducción (l. 93) | Pareto (1896) | Pareto (1906, *Manuale*) | C4, V2 |
| Introducción (l. 95) | Hicks y Allen (1934) «introducen el concepto de preferencias» | Reformulan la teoría en términos ordinales con la RMS. Se añade Slutsky (1915) | C4, V3, K2 |
| Introducción (l. 99) | Antonelli origina la «teoría de la dualidad» | Antonelli plantea la integrabilidad. Pasa a una línea con remisión a 3.A.9 (ver Coherencia) | C4, K2 |
| Introducción (l. 101) | Samuelson (1947) | Samuelson (1938, 1948) | C4, V4 |
| Nota 3 | «Kevin Lancaster»; cita textual de Ekelund y Hébert entre comillas | «Kelvin». La cita no se ha podido comprobar (V49), así que se parafrasea sin comillas | C35, V8 |
| Nota 5 | Madre de Edgeworth de «familia de carlistas» | Hija de un exiliado catalán liberal, huido del absolutismo de Fernando VII | V9 |
| Nota 9 | URL de Debreu rota (y con un espacio); «page 50» | URL nueva de Cowles; se cita el cap. 4 sin página (la p. 50 no se ha podido comprobar) | V10, V54, C44 |
| Supuestos (l. 156-176) | Diez supuestos, algunos redundantes («racionalidad» y «utilidad ordinal» son el contenido del apartado) | Cinco supuestos | C6 |
| Tabla de axiomas (l. 232-248) | Dos «6»; continuidad (4) antes de monotonía (5) en la tabla y al revés en el texto | Una sola numeración (1-7 y 6′), la misma en la tabla, el texto y el gráfico | C7, K4, P35, P40 |
| Axiomas (l. 308) | «Otros 4 axiomas» de regularidad, y salen cinco | «Axiomas de regularidad (4 a 7)», con la convexidad estricta como 6′ | K4, C7 |
| Monotonía (l. 316) | Monotonía débil ⇒ curvas «decrecientes (no estrictamente)», con una definición ambigua | Monotonía ($x\gg y\Rightarrow x\succ y$) y monotonía estricta ($x\ge y$, $x\ne y\Rightarrow x\succ y$), como en MWG (def. 3.B.2-3.B.3) | C8 |
| Continuidad (l. 336) | «Entre dos combinaciones indiferentes… siempre puede encontrarse otra indiferente» | Conjuntos de contorno cerrados; si $x\succ y$, las cestas próximas a $x$ siguen siendo preferidas | C9 |
| Convexidad (l. 352-354, 370) | «Combinaciones lineales… *preferidas*»; «garantiza las condiciones de segundo orden» | Combinaciones *convexas* al menos tan buenas (estrictamente preferidas con 6′). Hace la utilidad cuasicóncava, con lo que las CPO son suficientes (Arrow y Enthoven, 1961) | C10 |
| Advertencia y nota 24 (l. 384-393) | «Utilidad marginal decreciente ⇒ curvas convexas»; en la nota falta «decreciente» | Ninguna de las dos implica la otra (hace falta $U_{12}\ge 0$). La UMg decreciente no es ordinal. Pasa a `notaopositor` | C11, P20 |
| Nota 17 | La no convexidad incumpliría el *primer* teorema del bienestar (y cita Wikipedia) | La convexidad es necesaria para el segundo teorema y para la existencia del equilibrio, no para el primero. Se cita MWG cap. 16 y Starr (1969) | C37, V22 |
| Nota 13 | Condorcet como problema de las preferencias individuales; Kahneman y Tversky (1984) | Condorcet afecta a la agregación por mayoría (3.A.24). Se citan Tversky y Kahneman (1981) y Kahneman y Tversky (1984) | C38, V21 |
| Función de utilidad (l. 445) | Solo «⟹» | «⟺» | C12 |
| Propiedades de U (l. 447-451) | Continua y dos veces diferenciable «por» las preferencias; «monótona y creciente»; contorno superior = curva de indiferencia | Continua por Debreu; la doble diferenciabilidad es un supuesto; «creciente»; contorno superior convexo, que hace convexas las curvas | C12 |
| Nota 22 | Transformación monótona = «incrementa el valor en todos sus puntos»; «potencia impar» | $V=f(U)$ con $f$ estrictamente creciente; cualquier potencia positiva si $U\ge0$ | C12 |
| RMS (l. 495-500) | «Teorema de Engel»; «productividades marginales»; «la RMS aumenta (se reduce en valor absoluto)» | Teorema de la función implícita; utilidades marginales; la RMS (en valor absoluto) disminuye al aumentar $x_1$ | C13, P50 |
| Elasticidad de sustitución (l. 516-518) | «Función de producción» en un contexto de utilidad | Preferencias lineales y de Leontief | C13, P50 |
| CES (l. 524-538) | σ = 0 y σ = 1 como casos exactos; pesos $s_i$, que chocan con las participaciones en el gasto | Límites σ → 0, 1, ∞; pesos $a_i$; Cobb-Douglas con $\alpha=a_1/(a_1+a_2)$. Se cita Arrow *et al.* (1961) en vez de Wikipedia | C14, K3, V28 |
| Conjunto presupuestario (l. 580-586) | «Combinación lineal»; acotado sin condición | Combinación convexa; acotado si $p\gg0$. Nota 28: compacto (Heine-Borel) | C15 |
| Caja de teoremas (l. 641-645) | Local-global con mera cuasiconcavidad; unicidad «cuasicóncava con conjunto estrictamente convexo» | Estricta cuasiconcavidad en ambos. Se añade el teorema de suficiencia de Arrow y Enthoven | C16, P22 |
| Kuhn-Tucker (l. 656-682) | Holgura complementaria mal explicada; falta $\lambda\ge0$; restricción con igualdad sin justificar; la saturación se atribuye a la «monotonía» | Condiciones completas (9)-(10), holgura explicada bien; $\lambda>0$ y saturación por insaciabilidad local | C17, K4, P50 |
| λ (l. 652, 700-706, nota 29) | Explicado tres veces | Una vez, con una nota | K6 |
| Solución interior (l. 724) | $RMS\equiv -UMg_1/UMg_2=-p_1/p_2$ (con signo, distinto de l. 497) | $RMS_{12}=U_1/U_2=p_1/p_2$, en valor absoluto en todo el tema | K3, C19 |
| Solución de esquina (l. 728) | Sin condición | $U_1/p_1=\lambda\ge U_2/p_2$, es decir, $RMS_{12}\ge p_1/p_2$ | C19 |
| Nota 32 | Existencia y unicidad «por el teorema de las funciones implícitas» | Existencia por Weierstrass y unicidad por la convexidad estricta | C20 |
| Nota 34 | «La homogeneidad se demuestra aplicando el teorema de Euler» | Se debe a que el conjunto presupuestario no cambia. Euler da la restricción en elasticidades | C20, P6 |
| Nota 36 | Determinante del hessiano de la utilidad | Determinante del hessiano orlado (Jehle y Reny, teorema 1.5) | C20 |
| Ley de Walras (l. 784) | Por la «estricta monotonía» | Por la insaciabilidad local | K4 |
| FIU (l. 810) | Cuasiconvexa «debido a la convexidad de las curvas de indiferencia» | Cuasiconvexa para cualquier utilidad continua con insaciabilidad local (MWG, prop. 3.D.3) | C21 |
| Identidad de Roy (l. 814) | «∀ k» | «∀ i» | C21, P50 |
| Demanda de mercado (l. 830-840) | Efectos renta nulos como condición *necesaria*; «trabajar con funciones CES permite la agregación» | Gorman como condición necesaria y suficiente; el efecto renta nulo es un caso particular; la CES solo agrega si todos tienen la misma | C22, K7, P41, P50 |
| Nota 38 | Integral sobre los hogares | Suma (hogares finitos) | C22 |
| Nota 26 | «Usaremos ambas notaciones (M y W̄) indistintamente» | Siempre $\overline{W}$, llamada renta, como en 3.A.9 | K3 |
| Referencia l. 708 | «[ver pág. 2]» (referencia interna de Word) | `\pageref` a la segunda ley de Gossen | K13, C43 |
| Referencia l. 423 | Remite a 3.A.10 para ordinal frente a cardinal | Se explica aquí en una línea y se mantiene la remisión | K13, C43 |

**Parte 2 (apartados II y III)**

| Dónde (original) | Decía | Dice ahora | Propuesta |
|---|---|---|---|
| CRC (l. 860) | «La pendiente de la recta de balance se desplaza hacia arriba» | La recta de balance se desplaza en paralelo hacia fuera | C23, P50 |
| Nota 40 | Con preferencias homotéticas, la CRC es «una línea recta» | Una semirrecta que parte del origen (caso $a_h(p)=0$ de Gorman) | C23 |
| l. 928, 992, 1086 | «Hemos asumido por simplicidad que la elasticidad es constante» (tres veces) | La elasticidad es una medida local; se dice una sola vez, al empezar II | C24 |
| l. 992 | Un bien ordinario puede volverse «Veblen» a partir de cierto precio | Puede ser ordinario a unos precios y Giffen a otros | C24, C27 |
| Agregación de Engel (l. 934-944) | «No todos los bienes pueden ser inferiores (ni siquiera frontera)»; la ley de Walras se cumple «por el axioma de monotonía» | Ni todos inferiores ni todos con elasticidad nula; además, al menos uno con elasticidad-renta $\geq 1$. La ley de Walras, por la insaciabilidad local | C25, K4 |
| Agregación de Cournot (l. 1124) | Ley de Walras «por el axioma de monotonía» | Por la insaciabilidad local | K4 |
| Nota 41 | «Efecto riqueza» en el texto y remisión a la «nota al pie 26» | «Efecto renta» en el texto; la terminología de MWG (riqueza, senda de expansión de la riqueza) pasa a una nota | K3 |
| Nota 42 | Cita de Wikipedia | Marshall (1890), libro III, cap. IV | V24, P51 |
| Elasticidad-precio propio (l. 988) y nota 44 | «Bien Giffen o en su caso un bien Veblen» | Solo Giffen. El efecto Veblen va aparte: el precio entra en las preferencias, queda fuera del modelo y no se explica con Slutsky (Veblen, 1899; Leibenstein, 1950) | C27, P7 |
| Tabla de Slutsky propia y recta de elasticidades (l. 1004-1052) | «Bien Giffen o Veblen» en rojo; casillas vacías | Tabla LaTeX con cuatro casos (normal, independiente de la renta, inferior ordinario, Giffen) y otra tabla con la clasificación por elasticidades, que añade demanda elástica e inelástica | C27, P7, P35 |
| Slutsky (l. 996) | $h_i(p,\overline{U})$ usada sin definir | Definida como demanda compensada (solución de la minimización del gasto, 3.A.9) | K3, K8 |
| l. 1056 | «Cambia la pendiente de la renta presupuestaria» | «De la recta de balance» | C29 |
| Imagen 15 | Errata «gráficio» | Gráfico rehecho (`precio-consumo-demanda`) | C29, P31 |
| Imagen 16 | «…efecto de la variación en el precio de un bien sobre su precio» | «…sobre su cantidad demandada» | C29, P32 |
| Tabla de Slutsky cruzada (l. 1096-1114) | En las tres filas el efecto total podía tener cualquier signo | Sustitutivos netos con $i$ inferior ⇒ sustitutivos brutos; complementarios netos con $i$ normal ⇒ complementarios brutos; independientes netos según $i$ | C28 |
| Nota 47 | Al subir $p_1$, «el consumo del bien 2 debe aumentar» | Depende de la elasticidad del bien 1: $s_2\varepsilon_{x_2,p_1}=-s_1(1+\varepsilon_{x_1,p_1})$ | C26 |
| l. 1136 y nota 48 | «No todos los bienes pueden ser complementarios netos», como consecuencia de la agregación de Cournot | Sale de la homogeneidad de grado cero de la demanda compensada y del signo del efecto sustitución propio; pasa a II.3, tras la Slutsky cruzada | C26, K8, P50 |
| Valoración de II (l. 1138-1152) | «Se complementa… con la teoría de la dualidad»; la crítica iv remite a la demanda de características | Transición a III: cada limitación motiva un desarrollo (preferencia revelada, producción doméstica, precios hedónicos) | C30, K9 |
| Título de III.1 (l. 1160) | «Samuelson, 1947» | Samuelson (1938, 1948) en el texto | C31, V4, V5 |
| Nota 49 | La preferencia revelada es obra de Antonelli | Es de Samuelson (1938, 1948); Houthakker (1950) formula el axioma fuerte; Antonelli (1886) plantea la integrabilidad (3.A.9) | C31, V6, P42 |
| Nota 50 | Traducción imprecisa de la motivación del Nobel de Samuelson | Traducción de la motivación oficial | V11 |
| Supuestos (l. 1170) | «Consumidor representativo» | Consumidor individual (la agregación no conserva el ADPR) | C31 |
| Nota 51 | «Si cambias $p^0$ por $p^1$ y mantienes la renta constante…» | El ADPR compara dos situaciones de precios y renta cualesquiera | C31 |
| ADPR (l. 1184) | Fórmula sin $x^1\neq x^0$ | $p^0\cdot x^1\leq p^0\cdot x^0$, $x^1\neq x^0\Rightarrow p^1\cdot x^0>p^1\cdot x^1$ | C32 |
| AFPR (l. 1210-1224) | «A diferencia del ADPR, el AFPR parte de que no se pueden comparar todas las cestas» | Preferencia revelada indirecta y transitividad; el AFPR implica el ADPR | C32 |
| Implicaciones (l. 1244) | «Si se cumplen ambos axiomas…» | Teorema de Houthakker (AFPR ⇔ racionalizable); con dos bienes basta el ADPR (Rose, 1958) | C32 |
| Obtención de las curvas de indiferencia (l. 1252-1258) | Argumento confuso (una cesta $x^3$ «en la vertical» de $x^1$ indiferente a $x^0$) | La curva por $x^0$ queda acotada entre la región revelada peor y la revelada mejor, y la acotación mejora con más observaciones (Samuelson, 1948) | Revisión propia |
| Precios hedónicos (l. 1374) | «Griliches, 1971» | Court (1939), Griliches (1961; el libro de 1971 es una obra colectiva que edita) y Rosen (1974) | C33, V7 |

**Parte 3 (Conclusión, Bibliografía y anexos)**

| Dónde (original) | Decía | Dice ahora | Propuesta |
|---|---|---|---|
| Conclusión, Opinión (l. 1694-1698) | Tres párrafos sin fuente que parecen copiados (¿Zamora Bonilla?) | Valoración redactada de nuevo con fuentes comprobables: rechazo de homogeneidad y simetría (Deaton y Muellbauer, 1980), «como si» de Friedman (1953), Simon (1955), Kahneman y Tversky (1979), Thaler (1980, 1985) y Sen (1977) | C36, P4 |
| Thaler (l. 1519-1521) | «Racionalidad limitada» de Thaler: fijarse en porcentajes de rebaja | La racionalidad limitada es de Simon (1955); el ejemplo es contabilidad mental (Thaler, 1985). Pasa a una nota de la valoración | C45, V18 |
| Thaler (l. 1525-1527) | «Efecto propiedad», con una cita entrecomillada sin fuente | Efecto dotación (Thaler, 1980; Kahneman, Knetsch y Thaler, 1990), explicado por la aversión a las pérdidas, sin comillas | C45, V19 |
| Thaler (l. 1533-1537) | Dos citas sin fuente y el ejemplo del vendedor de paraguas | Sin comillas; el ejemplo es el de las palas de nieve de Kahneman, Knetsch y Thaler (1986) | V20 |
| Enfoque cardinal (l. 1557) | La intensidad de las preferencias «puede cuantificarse en unidades monetarias» | Las diferencias de utilidad tienen significado; utilidad única salvo transformaciones afines positivas | C46 |
| Enfoque cardinal (l. 1563) | La cardinalidad implica comparaciones interpersonales | Son supuestos distintos (la utilidad esperada es cardinal y no comparable entre personas) | C46 |
| Enfoque cardinal (l. 1642) | «No existen efecto renta ni efecto sustitución cruzado», sin más | Correcto, y se dice que es el caso cuasilineal de I.3 | C46 |
| Enfoque cardinal (l. 1662) | El enfoque ordinal surge «debido a estas críticas» | Pareto muestra que la medición es innecesaria; Hicks y Allen reconstruyen la teoría | C46 |
| Anexo 2 (l. 1774-1841) | Jerarquía rota; CRRA como forma de preferencias sobre varios bienes; Cobb-Douglas repetida; «con un bien indiferente, $b=0$» como cuasilineal | Taxonomía ordenada (Gorman ⊃ cuasilineales, homotéticas ⊃ homogéneas ⊃ CES; Stone-Geary; flexibles; CRRA aparte, de una sola variable). El bien neutral pasa al anexo de test | C51, P5 |
| Anexo 2, Cobb-Douglas (l. 1801) | «Curvas de indiferencia translaciones paralelas»; «curvas de Engel líneas crecientes»; «si cambia el precio… consumo menos» | Expansiones radiales; rectas desde el origen; «si sube el precio» (gasto constante en el bien) | C49 |
| Anexo 2, CES (l. 1784) | Pesos $s_i$ y constante $artheta$ | Remite a la ecuación (CES) del tema, con pesos $a_i$ (K3) | K3 |
| Anexo 2, translog (l. 1839) | Desarrollo de Taylor de la CES en σ alrededor de 1 | Aproximación de segundo orden en logaritmos de una función cualquiera (Christensen, Jorgenson y Lau, 1975); lo otro es la aproximación de Kmenta (1967) | C49 |
| Anexo 2, JR (l. 1845) | Exponentes $(1-\gamma)^i$ en lugar de $\gamma(1-\gamma)^i$; notación distinta de las imágenes; «Nir jaimovich»; no dice qué hace $\gamma$ | Forma recursiva $X_t=C_t^{\gamma}X_{t-1}^{1-\gamma}$ en LaTeX con la notación de las imágenes; «Nir Jaimovich»; $\gamma$ regula el efecto riqueza y anida KPR ($\gamma=1$) y GHH ($\gamma=0$) | C52, P8, P39, V26 |
| Anexo 2, GHH (l. 1851-1863) | Describe el artículo, pero no la propiedad de las preferencias | Sin efecto riqueza sobre las horas: $\psi N^{\theta}=w$ | C52, P9 |
| Anexo 2, KPR (l. 1865-1874) | $v(L)$ con $L$ sin aclarar (en GHH y JR, $L$ es trabajo) | $v(1-N)$, función del ocio; con ello las condiciones sobre $v$ son las de KPR; se cita el apéndice de 2002 | C52, P10, V27 |
| Nota 63 | Captura de la Wikipedia | Límite de la CES por L'Hôpital, con Arrow *et al.* (1961) | V28, P38 |
| Anexo 3, tabla de bienes y males | La celda de «Mal» decía $\partial U/\partial x>0$ | $\partial U/\partial x<0$ | C53, P35 |
| Anexo 3, tabla de curvatura | Las condiciones sobre las derivadas parciales de la RMS como si fueran necesarias | Son suficientes; decide la derivada total $d^2y/dx^2\vert_U$. Tabla con la pendiente con signo y con la RMS en valor absoluto del tema | C53, K3 |
| Axiomas, convexidad estricta (control de calidad) | `\item[6′.]`: la etiqueta se perdía en HTML y Word, que numeraban 7 y 8 | La convexidad estricta es un subpárrafo del axioma 6 que empieza por «6′.» en negrita; la diferenciabilidad es el 7 en los tres formatos. No queda ningún otro `\item[...]` | Control de calidad |
| `.bib` (control de calidad) | Notas de trabajo en `note`: Marshall (dónde está la cita), Court (dos paginaciones), Segura (ediciones), Mankiw (para qué se usaba) y Fuleky (enlaces caídos) | Fuera; Court con la paginación comprobada (99-117), Fuleky solo con la URL archivada y Marshall con «Texto en línea de la 8.ª ed. (1920)». La duda de Segura sigue en Dudas abiertas | Control de calidad |
| Gráfico 16, `funcion-hedonica-rosen` (control de calidad) | Flotaba a la página siguiente y dejaba dos tercios de página en blanco | Va tras la definición de la función hedónica, antes del modelo de Rosen, al 55 % del ancho; ya no queda hueco | Control de calidad |

## Marcas resueltas

| Marca | Texto original | Qué se ha hecho |
|---|---|---|
| P1 (amarillo, l. 251) | «Ver Segura páginas 29 y 30 – En general muy bien explicado aquí la axiomática» | No se ha podido consultar Segura. La axiomática se ha revisado con Mas-Colell, Whinston y Green (cap. 3), Varian (1992, cap. 7) y Debreu (1959, cap. 4). El orden final sigue el teorema de representación de Debreu (K4). Ver Dudas abiertas. |
| P2 (amarillo vacío, l. 127) | Tabla «Estructura» vacía | Estructura redactada (K2) y esquema de pizarra en una caja `esquema`. |
| P6 (texto oculto y amarillo, nota 34) | «Ver tema ICEX-CECO anotaciones a mano y meter aquí» | No se publica. Nota completada con la demostración estándar y la restricción de Euler en elasticidades. Ver Dudas abiertas. |
| P11 (nota al opositor inicial e image1) | Aviso de cambio de temario y ficha del tribunal | El aviso desaparece y la imagen no se publica. La propuesta de estructura guía el tema, y una `notaopositor` en la Introducción la resume como consejo para el cante. |
| P12 (nota al opositor, l. 696) | «Hacer el análisis suponiendo curvas convexas… comprender las implicaciones de que no lo sean» | Reescrita en `notaopositor`: tangencia no suficiente, esquinas, soluciones múltiples y demanda discontinua (C18). |
| P14, P15, P17 (comentarios de clases, grabaciones y coordinación) | «Tema cantado con Juan Luis…», «Clase Juan Carlos…», «Coordinar enganche…» | No se publican. La coordinación con 3.A.9 se aplica según K2 (ver Coherencia). |
| P16 (comentario con image2) | Lista de supuestos de la teoría neoclásica | No se publica. Los supuestos del apartado I se han reducido a cinco (C6). |
| P20 (advertencias, l. 384-393, y nota 24) | «Convexas ⇍ / ⇐ UMg decreciente» | Corregido (ver Errores) y pasado a `notaopositor`. |
| P22 (cajas de anotaciones de la parte 1) | Preguntas guía (l. 132) y caja de teoremas (l. 632-646) | La pregunta guía queda dentro de la «Problemática». La caja de teoremas se conserva en `anotaciones`, corregida (C16). |
| P23 (Imagen 1, Venn) | Formas de Word | Pedida en TikZ: `preferencias-venn`. |
| P24 (Imágenes 2-7, Segura) | Seis escaneos | Pedidas como un único gráfico por capas en el orden de los axiomas: `axiomas-curva-indiferencia`. |
| P25 (Imagen 8, cuasiconcavidad) | Escaneo 3D insertado tres veces | Pedida en TikZ (`cuasiconcavidad`), marcada como profundización. Si el 3D no es viable, que el agente TikZ lo haga en 2D. |
| P26 (Imagen 9, CES) | Escaneo | Pedida en pgfplots: `ces-curvas-indiferencia`. |
| P27 (Imagen 10) | Escaneo de MWG | Pedida en TikZ: `conjunto-presupuestario`. |
| P28, P29 (Imágenes 11 y 12) | Escaneos | Fundidas en un gráfico de dos paneles, con la esquina como capa: `solucion-interior-esquina`. |
| P35 (tabla-esquema repetida cinco veces y tabla de axiomas) | Tablas de Word | El esquema pasa a un único gráfico por capas (`esquema-ingredientes`, K5) y la tabla de axiomas, a una tabla LaTeX. |
| P40 | Numeración y orden de los axiomas | Resuelto (K4, C7-C10). |
| P41 | Falta la agregación que pide el tribunal | Nuevo I.3 (K7, C22). |
| P47 (referencias de la parte 1) | l. 423, l. 708, notas 2 y 8 | Resueltas (ver Errores y Coherencia). |
| P51 (citas a Wikipedia y rstudio-pubs de la parte 1) | Notas 17, 19 y 21 | Wikipedia sustituida por MWG, Starr (1969) y Pareto (1896). En la nota 21 se conserva el enlace de rstudio-pubs, que funciona (V58), y se quitan los dos de hawaii.edu, que están rotos (V59). |

**Parte 2 (apartados II y III)**

| Marca | Texto original | Qué se ha hecho |
|---|---|---|
| P7 (rojo, l. 1025 y 1047) | «Bien Giffen o Veblen» en la tabla de Slutsky y en la recta de elasticidades | Comprobado: el Veblen no se explica con la ecuación de Slutsky. Las tablas dicen solo «Giffen», en negro, y el Veblen va en una viñeta propia con Leibenstein (1950) (C27). |
| P13 (nota al opositor, l. 1156) | «Mencionar primero las que vienen en el título del tema por si acaso hay problemas de tiempo» | Reescrita en `notaopositor` al inicio de III. El orden sigue a K1 (el de la ficha del tribunal); la nota dice que, si falta tiempo, se acorta la producción doméstica, que no está en el título. |
| P22 (cajas de anotaciones de II) | Pregunta guía (l. 844) y enlaces de YouTube y Policonomics (l. 1029, 1033) | La pregunta guía se integra en la entrada de II. Los dos enlaces funcionan (V55, V56) y se conservan en una caja `anotaciones` con sus títulos. |
| P30 (Imágenes 13 y 14) | CRC y curva de Engel; fuente: Muñoz Camacho (2017) | Pedidas como un gráfico de dos paneles (`renta-consumo-engel`). La fuente pasa a MWG (V68). |
| P31 (Imagen 15) | CPC y demanda; errata «gráficio» | Pedida en TikZ (`precio-consumo-demanda`); fuente, Varian (2016). |
| P32 (Imagen 16) | Descomposición ES/ER; título erróneo | Pedida en TikZ con un panel inferior nuevo de demandas marshalliana e hicksiana (`efecto-sustitucion-renta`); título corregido. |
| P33 (Imágenes 17-20) | ADPR, signo del efecto sustitución, AFPR y obtención de curvas de indiferencia | 17 y 18, fundidas en `adpr-efecto-sustitucion` (el signo del efecto sustitución es una capa); 19, `afpr`; 20, `preferencia-revelada-indiferencia`. Las dos últimas, de profundización. |
| P34 (Imágenes 21 y 22) y P3 («Fuente: […]» de la Imagen 22) | Lancaster y modelo media-varianza | Salen del tema (K11): Lancaster se resume en III.2 y se remite a 3.A.18; el modelo media-varianza es de 3.A.10 y 3.B.23. Con él desaparece la fuente vacía de P3. La Imagen 23 (enfoque cardinal) es de la parte 3. |
| P35 (tablas de Slutsky y recta de elasticidades) | Tablas de Word | Tres tablas LaTeX: clasificación por elasticidades, Slutsky propia y Slutsky cruzada. |
| P42 | Preferencia revelada: faltan Afriat, Houthakker y KMS; nota 49; fecha; nota 51 | Resuelto (C31, C32; ver Errores). |
| P43 | Precios hedónicos en 110 palabras | Apartado propio III.3 (C33): Court, Griliches, Rosen, estimación en dos etapas, aplicaciones con datos oficiales (V32-V34) y limitaciones. No se afirma que el IPC del INE use métodos hedónicos (V33). |
| P44 | Producción doméstica: solo un título | Apartado propio III.2 (C34, K10): Becker, renta completa, precio sombra, Gronau, Lancaster como otra tecnología del consumo. |
| P45 (apartados vacíos de III) | «Desarrollo» de la preferencia revelada; «Implicaciones» y «Valoración» de Lancaster | El primero se completa. Los de Lancaster desaparecen con el apartado. |
| P46 | Lancaster completo, sistemas de demanda, índices | Lancaster, resumido en III.2 (→ 3.A.18); sistemas completos de demanda, fuera del cuerpo (→ 3.A.9; la línea de remisión va en la conclusión, parte 3); índices, una línea en III.1 (→ 3.A.9). Thaler y el enfoque cardinal, en la parte 3. |
| P18 (comentario «Coordinar en temas 3.A.8 y 3.A.18») | — | No se publica. Coordinación aplicada (K10). |
| P50 (errores de II y III) | l. 860, l. 1136 y nota 48, numeración de la lista de Lancaster | Corregidos los dos primeros. La lista de Lancaster sale con el apartado (el error sigue en 3.A.18: ver Coherencia). |
| P51 (nota 42) | Cita a Wikipedia | Sustituida por Marshall (1890), libro III, cap. IV (V24). |

**Parte 3 (Conclusión, Bibliografía y anexos)**

| Marca | Texto original | Qué se ha hecho |
|---|---|---|
| P4 (amarillo, Opinión, l. 1691) | «Ver lo que hay detrás; Meter reflexiones filosóficas…» | Valoración redactada de nuevo con fuentes comprobables (C36). No se ha encontrado la fuente de los párrafos originales: no se publican (ver Dudas). |
| P5 (amarillo, Anexo 2, l. 1774) | «Necesito revisar las relaciones entre ellas, en concreto las isoelásticas y las CES» | Taxonomía rehecha (C51): la CES es homogénea y homotética; la isoelástica (CRRA) es de una sola variable y va aparte. |
| P8, P9, P10 (rojo, Anexo 2) | Preferencias JR, GHH y KPR | Comprobadas (V26, V27) y corregidas (C52); pasan a negro, como bloque «para el test» con remisión a 3.A.29. |
| P17 (comentario del Anexo 3) | «Ver Clase Juan Carlos 1…» | No se publica. |
| P19 (comentario y línea suelta de la Bibliografía) | «Coordinado por José Luis»; «Tema Juan Luis Cordero Tarifa» | No se publican. La bibliografía es la de `3A08.bib` (`\bibliografia`, solo las obras citadas). Muñoz Camacho (2017) sale (V68). |
| P21 («No cantar», l. 1646) | Ejemplo $\ln x_1+x_2$ | Se conserva en una caja `anotaciones` del anexo del enfoque cardinal, que entero queda fuera del cante, con la explicación corregida: lo que elimina los efectos cruzados es la utilidad marginal del dinero constante, no la aditividad. |
| P34 (Imagen 23, enfoque cardinal) | Curva de demanda $p_i=u_i'(x_i)$ | Pedida en TikZ (`demanda-cardinal`) para el anexo, con el excedente como capa. |
| P35 (Anexo 3) | Tablas de Word | Dos tablas LaTeX corregidas (bienes y males; curvatura). |
| P37 (Anexo 1, escaneos en ℝ³) | Cuatro escaneos duplicados sin fuente | Se quita (C50): sin fuente identificable y sin valor para el cante. |
| P38, P39 (imágenes de fórmulas) | Capturas de Wikipedia y de las fórmulas de JR | Fórmulas en LaTeX con fuente académica. |
| P45 (vacíos de la conclusión) | Dos viñetas vacías en «Extensiones»; «Preguntas de otros exámenes» vacía | Extensiones completas con remisiones (K12). «Preguntas de otros exámenes» se quita. |
| P46 (sistemas de demanda, Thaler y cardinal) | Apartados del bloque III | Sistemas completos de demanda: una viñeta de remisión en la conclusión (→ 3.A.9), con la motivación correcta del Nobel de Deaton (V12). Thaler: en la valoración, con una nota. Enfoque cardinal: anexo A. |
| P49 (enlace del test, l. 1732) | quia.com/quiz/6562883 | Funciona (V57); se conserva en una caja `anotaciones` del anexo de test, indicando que usa la numeración anterior (A.6). Ver Dudas. |
| P51 (Anexo 2) | Enlace a Wikipedia | Se quita. |

## Datos actualizados

| Dato | Valor anterior | Valor nuevo | Fuente | URL | Consulta | Segunda comprobación |
|---|---|---|---|---|---|---|
| Gasto en consumo final de los hogares, % del PIB, España (Introducción, relevancia) | No había dato | 54,1 % en 2025 (55,2 % con las ISFLSH): 913.815 de 1.690.012 millones de euros | Eurostat, `nama_10_gdp` (actualizado el 9/10/2026) | https://ec.europa.eu/eurostat/databrowser/view/nama_10_gdp/default/table | 10/10/2026 | INE, Contabilidad Nacional Trimestral, tabla 67823 (series CNTR6548, CNTR6942 y CNTR6939). La suma de los cuatro trimestres de 2025 da exactamente las mismas cifras: 54,07 % y 55,20 %. |
| Fechas y obras de la Introducción | Pareto (1896), Samuelson (1947), Hicks y Allen «introducen las preferencias» | Pareto (1906), Samuelson (1938, 1948), Hicks y Allen (1934) reformulan en términos ordinales | Ver V2-V4 (Crossref, JSTOR) | Ver `propuestas-datos.md` | 10/10/2026 | Ver V2-V4 |
| Madre de Edgeworth (nota 5) | Familia carlista | Familia liberal exiliada | Barbé (2006) | Ver V9 | 10/10/2026 | MacTutor y Wikipedia (ninguna habla de carlistas) |
| URL de Debreu (1959) (nota 9) | URL rota | https://cowles.yale.edu/sites/default/files/2022-09/m17-all.pdf | Cowles Foundation | — | 10/10/2026 | Open Library y CiNii (V10) |

**Parte 2 (apartados II y III)**

| Dato | Valor anterior | Valor nuevo | Fuente | URL | Consulta | Segunda comprobación |
|---|---|---|---|---|---|---|
| Ley de Engel: peso de alimentos y bebidas no alcohólicas en el gasto, por quintil de gasto (II.1, texto y gráfico `epf-alimentos-quintil`) | No había dato | 2025: Q1 19,6 %, Q2 19,8 %, Q3 17,7 %, Q4 16,2 %, Q5 12,3 %; total 16,0 % | INE, EPF 2025, tabla 73828 | https://www.ine.es/jaxiT3/Tabla.htm?t=73828 | 10/10/2026 | Nota de prensa EPF 2025: 5.626 / 35.101 € = 16,03 % (V31). Serie en `_trabajo/datos/epf2025-alimentos-quintil.csv` |
| Características de la EPF (nota de II.1) | La ECPF como fuente de panel (en el apartado de sistemas de demanda, que sale) | Anual desde 2006, unos 24.000 hogares, dos años consecutivos en la muestra | INE, EPF base 2006, *Principales características*; metodología vigente | https://www.ine.es/daco/daco42/daco4213/resmeto06.pdf | 10/10/2026 | Metodología vigente de la EPF, p. 55 (V30) |
| Índice de Precios de Vivienda (III.3) | No había dato | Desde 2008, método mixto de estratificación y regresión hedónica; base 2025 | INE, IPV base 2025, *Metodología* | https://www.ine.es/daco/daco42/ipv/metodologia2025.pdf | 10/10/2026 | IPV base 2015, metodología de 2017 (V32) |
| Métodos hedónicos en el IPC (III.3) | (P43 suponía que el INE los aplica) | El IPC español usa sobre todo solapamiento, expertos e imputación; Eurostat los recomienda sobre todo en electrónica y vivienda | INE, IPC base 2025, *Metodología*, pp. 40-41; Eurostat, *HICP Methodological Manual* (2024) | https://www.ine.es/metodologia/t25/metodologia_IPC_base_2025.pdf | 10/10/2026 | Eurostat *et al.*, *Handbook on RPPIs* (2013) (V33) |
| Ajuste hedónico en el IPC de EE. UU. (III.3) | No había dato | Unas 35 categorías (ropa, electrodomésticos, teléfonos, telecomunicaciones) | BLS, *Quality Adjustment in the CPI* | https://www.bls.gov/cpi/quality-adjustment/ | 10/10/2026 | Parcial: otras páginas del BLS confirman las categorías, no el total de 35 (V34) |
| Informe Boskin (III.3) | No había dato | Sesgo del IPC de EE. UU. de unos 1,1 puntos al año, de los que unos 0,6 por calidad y productos nuevos | Boskin *et al.* (1996) | — (informe impreso) | — | No la ha comprobado el verificador de datos: viene de C33 y de la literatura estándar. Ver Dudas abiertas |
| Fechas de III | Samuelson (1947), Griliches (1971), Antonelli como autor | Samuelson (1938, 1948), Court (1939), Griliches (1961), Rosen (1974) | Crossref, JSTOR, NBER | Ver V4-V7 | 10/10/2026 | Ver V4-V7 |
| Nobel de Samuelson (nota de III.1) | Traducción imprecisa | Motivación oficial traducida | nobelprize.org | https://www.nobelprize.org/prizes/economic-sciences/1970/summary/ | 10/10/2026 | V11 |
| Nobel de Becker (nota de III.2) | Solo «Premio Nobel en 1992» | Con la motivación | nobelprize.org | https://www.nobelprize.org/prizes/economic-sciences/1992/summary/ | 10/10/2026 | V46 |

**Parte 3 (Conclusión, Bibliografía y anexos)**

No hay cifras nuevas. Se comprueban referencias: Jaimovich y Rebelo (2009), *AER* 99(4) (V26); GHH (1988), *AER* 78(3), y KPR (1988), *JME* 21(2-3), con el apéndice de 2002 (V27); Arrow *et al.* (1961) (V28); motivaciones del Nobel de Thaler (V47) y de Deaton (V12, corregida: «por su análisis del consumo, la pobreza y el bienestar»), en nobelprize.org, consultadas el 10/10/2026; Thaler (1985), Simon (1955) y Kahneman, Knetsch y Thaler (1986, 1990) por Crossref (V18-V20).

## Contenido añadido

- **Introducción**:
  - Slutsky (1915).
  - Las vías históricas de los tres desarrollos del tema: Samuelson, Houthakker y Afriat para la preferencia revelada; Becker para la producción doméstica; Court, Griliches y Rosen para los precios hedónicos (K2).
  - La frase del enfoque cardinal sin efecto renta, que remite al anexo (K2.2).
  - El peso del consumo en el PIB.
  - La problemática y la estructura (K2), el esquema de pizarra y una nota al opositor sobre la estructura del tribunal.
- **I (inicio)**: el esquema de ingredientes en un gráfico por capas (K5) y cinco supuestos (C6).
- **I.1**:
  - El teorema de representación de Debreu, enunciado.
  - Los grados de la deseabilidad con definiciones formales y la cadena de implicaciones (C8).
  - La diferenciabilidad presentada como supuesto técnico (K4).
  - La distinción entre ordinal y cardinal (C43).
  - El séptimo rasgo de las curvas de indiferencia: sin vértices, por la diferenciabilidad.
  - Las notas al opositor con lo que se canta y lo que es profundización.
  - Fuentes: MWG (1995), Debreu (1959), Varian (1992), Arrow y Enthoven (1961), Starr (1969), Arrow *et al.* (1961).
- **I.2**:
  - Teorema de suficiencia de Arrow y Enthoven en la caja de teoremas.
  - Condiciones de Kuhn-Tucker completas, con la interpretación de la holgura (C17).
  - Condición de la solución de esquina (C19).
  - Restricción de homogeneidad en elasticidades (C20).
  - Argumento de la cuasiconvexidad de la FIU (C21).
  - Fuentes: MWG, Jehle y Reny (2011), Sydsæter *et al.* (2008), Kuhn y Tucker (1951), Roy (1947).
- **I.3 (nuevo)**:
  - Suma horizontal y dependencia de la distribución de la renta.
  - Forma polar de Gorman como condición necesaria y suficiente, con curvas de Engel rectas y paralelas.
  - Homotéticas idénticas y cuasilineales; consumidor representativo; PIGL y PIGLOG de Muellbauer.
  - Ventajas y problemas del efecto renta nulo.
  - Teorema de Sonnenschein-Mantel-Debreu.
  - Una `ideaclave` y un gráfico nuevo (`engel-gorman`).
  - Fuentes: Gorman (1953, 1961), MWG cap. 4, Sonnenschein (1973), Mantel (1974), Debreu (1974), Muellbauer (1975, 1976). Las entradas de Mantel (1974) y Debreu (1974) vienen de C22 y no las comprobó el verificador de datos; así se indica en el `.bib`.
- **Bibliografía (`3A08.bib`)**:
  - Es la unión de `bib-datos.bib` (96 entradas, que ya recogían la bibliografía del original: Segura, MWG, Gravelle y Rees, Maté y Pérez Domínguez, Osborne y Rubinstein) y de 16 entradas nuevas. Doce vienen de C54 y no estaban en el fichero: Varian (1992), Arrow y Enthoven (1961), Mantel (1974), Debreu (1974), Leibenstein (1950), Jensen y Miller (2008), Rosen (1999), Rose (1958), Sen (1973, 1977), Ekeland, Heckman y Nesheim (2004) y Boskin *et al.* (1996). Se añaden también Sydsæter *et al.* (2008), Pérez Domínguez (2004) y las dos fuentes del dato del PIB.
  - Las claves de C54 que duplicaban obras de `bib-datos.bib` se han unificado con las de este último (por ejemplo, `MasColell1995` → `MasColellWhinstonGreen1995`, `KMS1976` → `KihlstromMasColellSonnenschein1976`). Las partes 2 y 3 deben usar las claves del `.bib`, no las de las propuestas.
  - No hay claves duplicadas. Las marcas «% SIN COMPROBAR» se conservan como comentario justo antes de cada entrada: Ekelund y Hébert, Segura, Vial y Zurita, Maté y Pérez Domínguez, Mankiw y Pérez Domínguez (2004).
  - Muñoz Camacho (2017) y el «Tema Juan Luis Cordero Tarifa» no se incluyen (V67, V68, P19). Eurostat (2018), de C54, se sustituye por la edición de 2024 del manual del IPCA.

**Parte 2 (apartados II y III)**

- **II (entrada)**: definición de estática comparativa y advertencia, una sola vez, de que la elasticidad es local (C24).
- **II.1**:
  - CRC con el caso homotético; curva de Engel con la terminología de MWG en nota (K3).
  - Ley de Engel con Engel (1857) y el dato de la EPF 2025 (V31), con su gráfico de datos; nota con las características de la EPF (V30).
  - Agregación de Engel con la consecuencia de que al menos un bien tiene elasticidad-renta $\geq 1$ (C25).
- **II.2**:
  - Demanda elástica e inelástica y relación con el gasto (sirve para la nota 47).
  - Tabla de clasificación por elasticidades.
  - Demanda hicksiana definida (K8); ecuación de Slutsky con la derivación remitida a 3.A.9; Slutsky en elasticidades ($\varepsilon_{x_i,p_j}=\varepsilon^h_{i,p_j}-s_j\varepsilon_{x_i,\overline{W}}$), que explica por qué el Giffen exige un bien con mucho peso en el gasto.
  - Evidencia sobre el Giffen: Jensen y Miller (2008) y Rosen (1999) (C27). Efecto Veblen con Veblen (1899) y Leibenstein (1950).
  - Panel nuevo con las demandas marshalliana e hicksiana en el gráfico de la descomposición.
- **II.3**:
  - Simetría de las relaciones netas y existencia de al menos un sustitutivo neto (C26, K8).
  - Tabla de Slutsky cruzada corregida (C28).
  - Resumen de las tres restricciones (homogeneidad, Engel y Cournot), con la distinción entre las que salen de la restricción presupuestaria y las que exigen maximizar (3.A.9). Cumple lo anunciado en la nota de homogeneidad de I.2.
  - `ideaclave` y valoración como transición a III (K9).
- **III.1**: supuestos corregidos; ADPR y sus tres implicaciones (homogeneidad, ley de la demanda compensada con su ecuación, Slutsky semidefinida negativa pero no simétrica); Rose (1958) y KMS (1976); AFPR de Houthakker y teorema de Houthakker; Afriat (1967) y GARP de Varian (1982); valoración con la crítica de Sen (1973) (C31, C32, K10).
- **III.2 (nuevo)**: tecnologías del consumo; modelo de Becker con las dos restricciones, la renta completa y el precio sombra con coeficientes fijos; implicaciones (salario y sustitución de tiempo por bienes, con remisión a 3.A.25), Gronau (1977) y valoración; Lancaster ($z=Bx$) como la otra tecnología del consumo, con remisión a 3.A.18 (C34, K10).
- **III.3 (nuevo)**: idea, enlace con Lancaster y con la preferencia revelada (K10); Court (con Goodman, 1998), Griliches (1961, 1971) y Rosen (1974); función hedónica y precios implícitos; modelo de Rosen (condición de tangencia, curvas de puja y de oferta, envolvente) con un gráfico nuevo; estimación en dos etapas e identificación (Ekeland, Heckman y Nesheim, 2004); aplicaciones (Boskin, Eurostat, Triplett, BLS, INE: IPC e IPV; valoración indirecta con el ejemplo del Retiro y remisión a 4.B.6; salarios hedónicos) y limitaciones (C33, V32-V34).
- **Gráficos nuevos pedidos (parte 2)**: `renta-consumo-engel`, `epf-alimentos-quintil` (datos), `precio-consumo-demanda`, `efecto-sustitucion-renta`, `adpr-efecto-sustitucion`, `afpr`, `preferencia-revelada-indiferencia` y `funcion-hedonica-rosen` (nuevo).
- **Bibliografía**: no se ha añadido ninguna entrada; todas las claves usadas ya estaban en `3A08.bib`.

**Parte 3 (Conclusión, Bibliografía y anexos)**

- **Conclusión** (C36, K12): recapitulación por bloques I-III; valoración en tres pasos (solidez lógica, estatus empírico con Deaton y Muellbauer, Friedman, Simon, Kahneman y Tversky, Thaler y Sen, y por qué sigue siendo el punto de partida); extensiones con remisiones a 3.A.9, 3.A.10, 3.A.11, 3.A.16, 3.A.18, 3.A.21, 3.A.25, 3.A.29 y 3.A.33, e idea final.
- **Anexo A, enfoque cardinal** (K11, C46): supuestos corregidos, modelo con $u_i'(x_i)=p_i$, implicaciones (caso cuasilineal), valoración y el ejemplo «no cantar». Lleva `\label{anexo:cardinal}`, que ya citaban la Introducción y la nota de λ.
- **Anexo B, formas de la utilidad** (C51, C52): taxonomía con Gorman, cuasilineales, homotéticas, CES y sus tres casos, propiedades de la Cobb-Douglas con sus demandas, Stone-Geary con el sistema lineal de gasto, formas flexibles (→ 3.A.9), CRRA y el bloque de test de KPR, GHH y JR.
- **Anexo C, test** (C53): bienes, males y neutrales; pendiente; curvatura con la derivada total, tabla de condiciones suficientes y tres ejemplos rápidos.
- **Fuentes nuevas usadas** (todas ya estaban en `3A08.bib`): Friedman (1953), Simon (1955), Kahneman y Tversky (1979), Thaler (1980, 1985), Kahneman, Knetsch y Thaler (1986, 1990), Sen (1977), Nobel 2017 (Thaler) y 2015 (Deaton), Deaton y Muellbauer (1980, AIDS), Stone (1954), Geary (1950), Christensen, Jorgenson y Lau (1975), Cobb y Douglas (1928), KPR (1988, 2002), GHH (1988) y Jaimovich y Rebelo (2009).
- **Gráfico pedido** (parte 3): `demanda-cardinal` (rehace la Imagen 23), ya hecho (gráfico 17). Total pedidos: 17.
- **No se aplica**: el anexo con Thaler que C45 dejaba como opción (basta la nota de la valoración); el Anexo 1 rehecho en 3D (C50: sin fuente).

## Coherencia

- **Estructura y minutos (K1)**: `\minutos` va solo en las secciones (3 + 10 + 7 + 7 + 3 = 30), porque `construir-tema.py` suma todos los `\minutos` y, si se pusieran también en los subapartados, contarían dos veces. El reparto de I (4 + 4 + 2 min) va en las notas al opositor, no en `\minutos`. Por eso no se aplica el `\minutos{2}` que C22 ponía en I.3.
- **Orden del bloque III**: se sigue K1 (preferencia revelada, producción doméstica y precios hedónicos, el orden de la ficha del tribunal), no el de C1 (hedónicos antes que producción doméstica). La Introducción ya anuncia ese orden.
- **Orden de los axiomas**: se sigue K4 (continuidad 4, deseabilidad 5), no C7 (deseabilidad 4, continuidad 5). Motivo: así los axiomas 1-4 son exactamente los del teorema de representación de Debreu, y la tabla, el texto y el gráfico por capas usan la misma numeración. El original seguía en las figuras el orden de Segura (monotonía antes que continuidad). Ver Dudas abiertas.
- **Notación (K3)**:
  - Renta $\overline{W}$; $n$ bienes; $U(x)$ y $U_i$ (no $u_i$ ni $UMg_i$, salvo en la ley de Gossen de la Introducción).
  - $RMS_{12}=U_1/U_2$, siempre positiva.
  - Pesos de la CES, $a_i$; demanda $x_i(p,\overline{W})$.
  - Consumidor $h$ con $x_{hi}$, $\overline{W}_h$, $V_h$, $a_h(p)$.
  - Las partes 2 y 3 deben mantenerla, y definir $h_i(p,\overline{U})$ la primera vez que la usen (II.2).
- **Ley de Walras y deseabilidad (K4)**: la ley de Walras se atribuye siempre a la insaciabilidad local y la pendiente negativa a la monotonía estricta.
- **Coordinación de la Introducción con 3.A.9 (K2)**: se quita el párrafo de Antonelli, Hurwicz y Uzawa. Queda una línea con remisión a 3.A.9, para no perder la conexión con KMS (C4, que proponía mantenerlo entero; se aplica en parte).
- **Referencias cruzadas nuevas**: 3.A.33 en la nota de bienes duraderos (K13); 3.A.22 (nota de la convexidad); 3.A.24 (Condorcet y bienestar social); 3.A.16 y 3.A.21 en I.3; 3.A.9 (renta $\overline{W}$, dualidad, integrabilidad, AIDS). Todas comprobadas en `temario.json`.
- **Etiquetas para las partes 2 y 3**: el texto usa `\ref{anexo:cardinal}` (Introducción y nota de λ). La parte 3 debe poner `\label{anexo:cardinal}` en el anexo del enfoque cardinal (hoy sale «??»). Se pueden citar desde II y III: `eq:gorman`, `eq:roy`, `eq:tangencia`, `eq:scedm`, `eq:rms`, `eq:elasticidad-sustitucion`, `fig:engel-gorman`, `tab:axiomas` y `ley:gossen2`.
- **Contradicciones con otros temas** (no se tocan): las de K «Contradicciones», puntos 1 (Introducción de 3.A.9 casi idéntica), 3 (3.A.9 repite I.2 y atribuye la ley de Walras a la «estricta monotonía»), 5 (3.A.16, nota 14: efecto renta nulo como condición necesaria) y 7 (3.A.21: enunciado de SMD). En 3.A.8 ya están como deben quedar en esos temas.

**Parte 2 (apartados II y III)**

- **Minutos**: `\minutos{7}` solo en II y III. El reparto interno (II: 2 + 3 + 2; III: 3 + 1,5 + 2,5, según la estructura final de K) va en las notas al opositor. No se aplican los `\minutos` de subapartado de C33 y C34 ni el reparto 6 + 8 de C1, que choca con K1 (7 + 7).
- **Orden de III**: preferencia revelada, producción doméstica y precios hedónicos (K1 y la ficha del tribunal), no el de C1 (hedónicos antes). La nota al opositor de III recoge el consejo de P13 sin cambiar el orden.
- **Slutsky (K8)**: en 3.A.8 la descomposición gráfica, la ecuación enunciada y la clasificación; la derivación (identidad $h_i=x_i(p,E(p,\overline{U}))$, lema de Shephard) y las propiedades de la matriz de Slutsky, en 3.A.9.
- **Notación (K3)**: $\overline{W}$, $x_i(p,\overline{W})$, $h_i(p,\overline{U})$ (definida en II.2), $s_i=p_ix_i/\overline{W}$, elasticidades $\varepsilon_{x_i,\overline{W}}$ y $\varepsilon_{x_i,p_j}$, «efecto renta» en el texto. En III.3 la utilidad es $U(z,y)$ y la función de puja usa $\overline{U}$.
- **Curvas de Engel**: en I.3 (parte 1) se decía que con efecto renta nulo las curvas de Engel son «verticales», lo que solo es cierto con la renta en el eje vertical. Como `engel-gorman` y `renta-consumo-engel` ponen la renta en el eje horizontal, se cambia a «paralelas al eje de la renta» en I.3 y en II.1.
- **Qué sale del cuerpo (K11)**: Lancaster (resumido en III.2 → 3.A.18), media-varianza (→ 3.A.10) y la nota 55 de estrategias de empresa (→ 3.A.18); los índices de precios quedan en una línea (→ 3.A.9). La línea de los sistemas de demanda (→ 3.A.9), Thaler y el enfoque cardinal son de la parte 3.
- **Referencias cruzadas nuevas**, comprobadas en `temario.json`: 3.A.9 (dualidad, Slutsky, integrabilidad, KMS, índices), 3.A.18 (Lancaster), 3.A.25 (asignación del tiempo), 4.B.6 (análisis coste-beneficio), 3.A.10 y 3.A.29 (valoración de II).
- **Etiquetas nuevas** que puede citar la parte 3: `eq:elasticidad-renta`, `eq:agregacion-engel`, `eq:elasticidad-precio`, `eq:slutsky`, `eq:elasticidad-cruzada`, `eq:slutsky-cruzada`, `eq:agregacion-cournot`, `eq:restricciones-demanda`, `eq:adpr`, `eq:ley-demanda-compensada`, `eq:renta-completa`, `eq:hedonico`; `tab:clasificacion-elasticidades`, `tab:slutsky-propio`, `tab:slutsky-cruzado`; `fig:renta-consumo-engel`, `fig:epf-alimentos-quintil`, `fig:precio-consumo-demanda`, `fig:efecto-sustitucion-renta`, `fig:adpr-efecto-sustitucion`, `fig:afpr`, `fig:preferencia-revelada-indiferencia`, `fig:funcion-hedonica-rosen`.
- **Contradicciones con otros temas** (no se tocan): K «Contradicciones», puntos 4 (3.A.9 repite las tablas de Slutsky: en 3.A.8 ya están corregidas, y la tabla cruzada de 3.A.9 debería alinearse con C28), 6 (3.A.18 tiene el mismo texto de Lancaster con la lista mal numerada) y 8 (3.A.25 trata la producción doméstica sin citar a Becker ni a Gronau; debería remitir a 3.A.8 para la renta completa).

**Parte 3 (Conclusión, Bibliografía y anexos)**

- **Minutos**: `\minutos{3}` en la Conclusión; la suma de todos los `\minutos` del `.tex` es 30 (3 + 10 + 7 + 7 + 3), y `construir-tema.py` lo confirma. Los anexos no llevan minutos.
- **Notación (K3)** en los anexos: renta $\overline{W}$; CES con pesos $a_i$ (se remite a la ecuación del tema en lugar de repetirla con $s_i$, que chocaba con las participaciones en el gasto); la RMS del anexo de test se da con signo ($m=dy/dx$) y en valor absoluto, como en el resto del tema. En las preferencias macro, $\sigma$ es el inverso de la elasticidad de sustitución intertemporal, como en 3.A.10 y 3.A.29, y $N$ las horas trabajadas (el original mezclaba $L$ como trabajo y como ocio).
- **Etiquetas nuevas**: `anexo:cardinal`, `anexo:formas`, `anexo:test`, `eq:cardinal`, `eq:demanda-cardinal`, `eq:demandas-cobb-douglas`, `eq:crra`, `eq:kpr`, `eq:ghh`, `eq:jr`, `fig:demanda-cardinal`, `tab:bienes-males`, `tab:curvatura`. No queda ninguna referencia sin resolver («??»).
- **Contradicciones con otros temas** (no se tocan): además de las de las partes 1 y 2 (K «Contradicciones», puntos 1, 3, 4, 5, 6, 7 y 8):
  - punto 2: **3.A.9, sistemas completos de demanda** tiene el mismo texto que salía de 3.A.8, con sus errores («sencillez y rigidez», «comparará», el signo de la translog, la Cobb-Douglas con $\sum\alpha_i=1$ y grado $\alpha+\beta$; las homotéticas como «translaciones paralelas»; la translog como desarrollo de la CES). Al revisar 3.A.9, corregirlos según C49;
  - punto 9: **3.A.11** usa la misma definición de elasticidad de sustitución y la misma CES (coherente); el error de «función de producción» en un contexto de utilidad ya está corregido en 3.A.8. 3.A.10 y 3.A.18 usan $\sigma$ con el mismo sentido que 3.A.8;
  - las **preferencias KPR, GHH y JR** se remiten a 3.A.29: si allí no están, conviene llevarlas cuando se revise ese tema.

## Dudas abiertas

Ordenadas por prioridad. Ninguna impide compilar ni publicar el tema; las de prioridad alta afectan a lo que se cita como dato o como fuente.

**Prioridad alta (cifras y citas que se publican sin comprobar del todo)**

1. **Informe Boskin (III.3)**: las cifras (1,1 puntos de sesgo total y unos 0,6 por calidad y productos nuevos) son las que recoge la literatura y la propuesta C33, pero el verificador de datos no las ha comprobado en el informe. Conviene confirmarlas con el original (tabla 1).
2. **BLS (III.3)**: las «unas 35 categorías» con ajuste hedónico salen de la página del BLS; otras páginas del BLS confirman las categorías, pero no el total (V34).
3. **Párrafos de opinión del original (P4)**: no se ha localizado su fuente (el estilo apunta a Jesús Zamora Bonilla). Se han sustituido por una valoración propia con fuentes. Si Víctor recuerda de dónde salían, pueden recuperarse citados.
4. **Condiciones sobre $v$ en las preferencias KPR (Anexo B)**: «creciente y cóncava si $\sigma<1$, decreciente y convexa si $\sigma>1$» se da con el ocio como argumento, como en el artículo de 1988, pero C52 las dio de memoria; conviene contrastarlas con el apéndice técnico de 2002.

**Prioridad media (fuentes de la bibliografía y del original sin comprobar)**

5. **Segura, pp. 29-30 (P1)**: no se ha podido consultar. Hay que confirmar con el ejemplar el año de la 3.ª edición (el `.bib` lleva 1986, la 1.ª, con la marca «SIN COMPROBAR»; el original decía 1993 y 1996) y si Segura pone la continuidad antes o después de la monotonía. El tema sigue a Debreu y a MWG (continuidad 4).
6. **Entradas «% SIN COMPROBAR» del `.bib`** (editorial, año o edición): Pérez Domínguez (2004), citado en el pie de `cuasiconcavidad` (si no se confirma, el pie puede quedarse en «Elaboración propia»); Vial y Zurita (2011), en dos pies; Maté y Pérez Domínguez (2007) y Mankiw (2014), que ya no se citan en el texto y no salen en la bibliografía impresa.
7. **Cita de Ekelund y Hébert (nota 3)**: sin comillas porque no se pudo comprobar (V49). Si se localiza la página, puede volver a ser cita textual.
8. **Volumen y páginas sin una segunda fuente**: Mantel (1974) y Debreu (1974) (vienen de C22, no de Crossref); Fisher (1918) (V23); Christensen, Jorgenson y Lau (1975) y Deaton y Muellbauer (1980, AIDS), que Crossref no indexa (V29).
9. **Anotaciones a mano del tema ICEX-CECO (P6)**: no están disponibles. La nota de la homogeneidad lleva la demostración estándar. ¿Había algo más?

**Prioridad baja (decisiones editoriales)**

10. **Salarios hedónicos (III.3)**: se mencionan sin cita porque no hay en el `.bib` una fuente comprobada (C33 citaba a Viscusi sin referencia). Si se quiere citar, la referencia clásica es Thaler y Rosen (1976), que habría que añadir y comprobar.
11. **Ejemplos de bienes inferiores (II.1)**: «la comida rápida o las marcas blancas» se conservan como ejemplos posibles, sin dato que lo respalde. Pueden quitarse.
12. **Enlace del test (Anexo C)**: el cuestionario de quia.com funciona, pero se titula «A06» (numeración anterior) y no se sabe quién lo mantiene (P49, V57). Decidir si se conserva.
13. **Preferencias macro (Anexo B)**: KPR, GHH y JR se dejan como bloque de test con remisión a 3.A.29, como proponían C52 y K11. Si 3.A.29 ya las cubre, pueden quitarse de aquí.
14. **Anexo 1 escaneado (P37)**: se ha quitado porque no tiene fuente identificable (¿Maté y Pérez Domínguez, 2007, o Pérez Domínguez, 2004?). Si Víctor confirma el manual y lo quiere, se puede rehacer en TikZ con su fuente.

## Cambios tras la revisión de Víctor (10 oct. 2026)

1. **Axiomas: no hacen falta los siete para tener una función de utilidad.**
   - Texto (I.1.3): nueva lista al presentar los axiomas. Los tres primeros son la racionalidad. Con la continuidad ya existe una función de utilidad continua (Debreu). La monotonía y la convexidad le dan sus propiedades (creciente, cuasicóncava) y permiten la dualidad. La convexidad estricta y la diferenciabilidad simplifican (demanda única y diferenciable).
   - Teorema de Debreu: se añade «basta con estos cuatro axiomas», con una nota: MWG (prop. 3.C.1) añade la monotonía solo para simplificar la prueba.
   - Se reescriben la introducción a los axiomas de regularidad, su nota y el cierre («con los axiomas 1 a 4 existe…; con los demás, preferencias regulares…»).
   - La tabla 1 cambia la columna «Grupo» por «Papel»: racionalidad / existencia de U / propiedades de U y dualidad / simplificación.
   - Gráfico `axiomas-curva-indiferencia`: los seis paneles se reordenan en tres columnas con una llave sobre cada una: «Existencia de U continua (Debreu)» (1-3 y 4), «Propiedades de U y dualidad» (5 y 6) y «Para simplificar la exposición» (6′ y 7). Los pies de panel dicen ahora qué aporta cada axioma a U. El pie del gráfico también se ha cambiado.
   - El gráfico `esquema-ingredientes` decía «Axiomas 1-7» → «Axiomas 1-4 (Debreu)». No queda ninguna otra frase que diga lo contrario: se han revisado la introducción, la nota al opositor y I.1-I.2.
2. **Esquema de la página 6 del original**, rehecho en TikZ (`esquema-axiomas`, gráfico 4) e insertado tras la presentación de los axiomas, con `\fuente`. Las llaves agrupan 1-3, 1-4, 1-6 y 6′-7, como en el original. La tercera llave dice también qué propiedades da a U.
3. **Tablas de Slutsky y esquema de elasticidades.**
   - Tabla 3 (precio propio), con la disposición del original: ES, ER según la renta (normal / frontera / inferior) y ET según el precio (ordinario / Giffen). Tiene cuatro filas: normal; frontera; inferior con ER < |ES|; inferior con ER > |ES| (Giffen).
   - Tabla 4 (cruzada): 3 × 3, relación neta por bien normal, frontera o inferior y relación bruta resultante. Comprobada: las casillas «ambiguo» son la de sustitutivos netos con *i* normal y la de complementarios netos con *i* inferior; con *i* frontera, la relación bruta coincide con la neta. Lleva una nota sobre la simetría de las relaciones netas.
   - Veblen: no aparece en ninguna tabla. Se explica en la nota de la tabla 3 y en la viñeta propia que ya existía.
   - Nuevo gráfico `elasticidades-renta-precio` (gráfico 16), rehecho de la página 26 del original. Muestra los dos ejes con sus flechas («normal ⇒ ordinario», «Giffen ⇒ inferior») y la línea entre los dos ceros (inferiores ordinarios). «Giffen o Veblen» pasa a «Giffen».
4. **Derivaciones recuperadas: nuevo anexo B «Derivaciones»**, remitido desde el texto en cada caso. Comparando `original.md` con el tema:

   | Derivación | En el original | Ahora | Correcciones |
   |---|---|---|---|
   | Homogeneidad de grado cero ⇒ restricción en elasticidades (Euler) | Solo «se demuestra aplicando Euler» (nota 34) | B.1, paso a paso | El original atribuía a Euler la *demostración* de la homogeneidad; Euler solo da la restricción |
   | Agregación de Engel | Desarrollo con dos bienes (l. 934-938) | B.2 (el texto mantiene la versión compacta) | «Por el axioma de monotonía» → por la insaciabilidad local |
   | Agregación de Cournot | Desarrollo con dos bienes (l. 1120-1130), quitado en la revisión | B.3, con dos bienes y con *n* bienes, y el caso $s_2\varepsilon_{21}=-s_1(1+\varepsilon_{11})$ | Monotonía → insaciabilidad local; la nota 47 (el consumo del bien 2 «debe aumentar») ya estaba corregida |
   | Identidad de Roy | Solo el enunciado («∀ k») | B.4, con el teorema de la envolvente | ∀ k → ∀ i (ya corregido) |
   | Ecuación de Slutsky (y en elasticidades) | Solo «surge de la identidad entre demanda compensada y ordinaria» (nota 46) | B.5, desde $h_i=x_i(p,E(p,\overline{U}))$ y el lema de Shephard, y en elasticidades | — |
   | Simetría, negatividad y «al menos un sustitutivo neto» | Solo enunciados (nota 48) | B.6: matriz de Slutsky = hessiana de E (Young), concavidad de E y Euler sobre $h$ | El original lo derivaba de la agregación de Cournot; sale de la homogeneidad de $h$ (ya corregido en el texto) |
   | ADPR ⇒ ley de la demanda compensada | Solo gráfico | B.7, demostración de MWG 2.F.1 | — |
   | ADPR ⇒ homogeneidad | Esbozo (nota 52) | Se mantiene en la nota del texto | — |
   | Demandas Cobb-Douglas | Solo el resultado | B.8 | — |
   | Cobb-Douglas como límite de la CES | Captura de Wikipedia (nota 63) | B.9, L'Hôpital con pesos normalizados | — |
   | Enfoque cardinal (CPO, λ = 1) y contraejemplo cuasilineal | Sí | Siguen en el anexo A | «U′(M)» → u′(M) |
   | Pendiente de la curva de indiferencia y RMS | Sí | En el texto (ec. 3 y 4) | — |

   No había más derivaciones en el original. El Anexo 1 escaneado en ℝ³ lo sustituye ahora el gráfico de la superficie de utilidad (punto 5). La nota al opositor de II ya no dice que estas derivaciones «solo se enuncian»: remite al anexo.
5. **Función de utilidad y curvas de indiferencia, con definiciones formales y gráficos.**
   - Se definen los conjuntos $B(x^0)$ («al menos tan bueno como»), $H(x^0)$ («no mejor que») e $I(x^0)=B\cap H$. Nuevo gráfico `conjuntos-contorno` (gráfico 3): la curva de indiferencia es su frontera común.
   - Función de utilidad: interpretación (numera los conjuntos de indiferencia) y cómo se construye (diagonal, MWG 3.C.1).
   - Nuevo gráfico `superficie-utilidad` (gráfico 6): superficie $\sqrt{x_1x_2}$ en 3D cortada en U = 1, 2 y 3, proyección de los cortes y mapa de curvas de indiferencia. Las curvas de indiferencia se definen como conjuntos de nivel (ec. 2).
   - Las propiedades de las curvas se reescriben, cada una con el axioma que la da y su razonamiento: completitud y reflexividad, transitividad (con el argumento A, B, C), continuidad, monotonía (pendiente negativa y más utilidad cuanto más lejos) y convexidad. Nuevo gráfico `propiedades-curvas-indiferencia` (gráfico 8), con cuatro paneles.
   - Se actualiza la nota al opositor de I.1.
6. **Preferencias y conjunto de elección.**
   - La relación binaria se define como subconjunto de $S\times S$, con la preferencia débil como primitiva y la notación $\preccurlyeq$, $\prec$. Los cuatro casos van ahora en lista numerada, con remisión al gráfico.
   - Tras los axiomas: la indiferencia es una relación de equivalencia y la preferencia estricta, irreflexiva, asimétrica y transitiva.
   - Conjunto de elección: no vacío, cerrado (con la definición por sucesiones), acotado inferiormente ($x\geq0$; antes decía «acotado por la cesta nula»; se aclara que no está acotado superiormente) y convexo (divisibilidad). Nota: $S=\mathbb{R}^n_+$ cumple las cuatro.
7. **Partición en conjuntos de indiferencia**: la idea ya estaba. Se desarrolla en una viñeta propia tras el preorden completo: completitud (todas), reflexividad ($x^0\in I(x^0)$) y transitividad (uno solo; dos conjuntos que comparten una cesta son el mismo). Remite al panel 1-3 del gráfico 5.
8. **Test**: el enlace a quia.com se sustituye por «Preguntas tipo test: simulador de test», que enlaza a `…/primer-ejercicio/test/simulador.html`.
9. **Orden**: los anexos van antes de la bibliografía (`\bibliografia` justo antes de `\end{document}`), y hay un `\clearpage` tras la introducción. Anexos: A cardinal, B derivaciones (nuevo), C formas funcionales, D test.
10. **Citas.**
    - Ya no queda ningún `\footcite` ni `\footcites`. Cuando el autor aparece en el texto se usa `\textcite`, quitando nombre y año duplicados: «\textcite{Slutsky1915Bilancio} descompone…», «ecuación de \textcite{…}», «identidad de \textcite{Roy1947Distribution}», «forma polar de \textcite{Gorman1961Class}», «teorema de \textcite{Afriat1967Construction}». En los demás casos, y en las fuentes de datos (INE, Eurostat, BLS), se usa `\parencite`, con la puntuación detrás.
    - Los nombres de pila desaparecen del texto cuando los sustituye `\textcite`. En Edgeworth, el nombre completo pasa a la nota de «Ysidro».
    - Las notas que solo citaban se han quitado; las que aportan texto siguen como `\footnote`. Los dos `\cite` sueltos pasan a `\parencite`.
    - Comprobado en el PDF: sin citas rotas ni referencias indefinidas (log y biber sin avisos) y sin duplicados del tipo «Slutsky Slutsky».
11. **Reglas TikZ** aplicadas a los gráficos nuevos y a los existentes: código en el orden de la pizarra, capas finas y solo como instrucciones completas, nodos con nombre definidos antes de usarse. El aspecto final no cambia; la diferencia de píxeles es nula salvo dos zonas imperceptibles en `demanda-cardinal` y `precio-consumo-demanda`. Capas de los gráficos nuevos:
    - `esquema-axiomas`: 1 completitud; 2 reflexividad; 3 transitividad; 4 llave «racionalidad»; 5 línea y continuidad; 6 llave «función de utilidad continua (Debreu)»; 7 línea y monotonía; 8 convexidad; 9 llave «propiedades de U y dualidad»; 10 línea gruesa y convexidad estricta; 11 diferenciabilidad; 12 llave «para simplificar».
    - `axiomas-curva-indiferencia`: 1 llave «Existencia de U»; 2 panel 1-3; 3 panel continuidad; 4 llave «Propiedades de U y dualidad»; 5 monotonía; 6 convexidad; 7 llave «Para simplificar»; 8 convexidad estricta; 9 diferenciabilidad.
    - `conjuntos-contorno`: 1 ejes; 2 $x^0$; 3 $B(x^0)$; 4 $H(x^0)$; 5 curva $I(x^0)$ como frontera común.
    - `superficie-utilidad`: 1 ejes 3D; 2 superficie; 3-5 cortes U = 1, 2, 3 con su proyección; 6 ejes del plano; 7 mapa de curvas; 8 «más utilidad».
    - `propiedades-curvas-indiferencia`: (a) 1 ejes, 2 $x^0$ y guías, 3 «más de todo», 4 «menos de todo», 5 curva y lectura; (b) 6 ejes, 7 tres curvas, 8 rayo y A, B, C, 9 lectura; (c) 10 ejes, 11 $U_1$, 12 $U_2$ y A, 13 B y C, 14 lectura; (d) 15 ejes, 16 conjunto superior y curva, 17 $x'$ y $x''$, 18 segmento y combinación, 19 lectura.
    - `elasticidades-renta-precio`: 1 eje de la elasticidad-renta; 2 inferiores y normales; 3 primera necesidad y lujo; 4 eje de la elasticidad-precio; 5 Giffen y ordinarios; 6 línea entre los ceros; 7 normal ⇒ ordinario; 8 Giffen ⇒ inferior; 9 lectura.
    - `esquema-ingredientes`: la restricción presupuestaria (capa 3) va ahora antes que el PMU (capa 4) en el código.
    - Las capas nuevas de los otros trece gráficos están en sus `.tex`. **Ojo: `guion-cante.md` y `video/escenas.yaml` citan números de capa antiguos.**

Resultado: el PDF pasa de 45 a 54 páginas y tiene 22 gráficos. `verificar-tema.py`: 0 errores. Quedan dos avisos de «cifra sin cita» que ya estaban (la nota sobre el temario de 2023 y la remisión «III.2»), además de los de LyX y del guion.

## Vuelta a la estructura original (11 oct. 2026)

Víctor prefiere la estructura de su tema a la de la ficha del tribunal. Precisó después que se refería a los títulos de nivel 2 de los bloques I y II; el bloque III se queda como estaba, y el enfoque cardinal, Lancaster y los sistemas completos de demanda van como anexos. No se ha tocado el contenido revisado (correcciones, datos, citas, gráficos, tablas de Slutsky, derivaciones): solo se ha reorganizado y se ha recuperado lo que se había quitado.

**Estructura final y minutos** (`\minutos` suma 30; el reparto interno está en la nota al opositor de la Introducción):

| Apartado | Min | Contenido |
|---|---|---|
| Introducción | 3 | Cinco bloques; estructura, esquema de pizarra y nota al opositor reescritos con la estructura nueva |
| I. Análisis de la teoría neoclásica de la demanda del consumidor (I): fundamentos de la teoría de la elección racional | 10 | I.1 Ingredientes (5): I.1.1 Conjunto de elección, preferencias y función de utilidad (conjunto de elección, preferencias, axiomas, función de utilidad, curvas de indiferencia/RMS/CES); I.1.2 Restricción presupuestaria. I.2 Problema de maximización de la utilidad: el equilibrio (3): planteamiento y Kuhn-Tucker, solución interior, solución de esquina. I.3 Solución al problema de maximización (2): demanda individual marshalliana, FIU, curva de demanda de mercado (agregación, Gorman, efecto renta nulo, SMD) |
| II. Análisis de la teoría neoclásica de la demanda del consumidor (II): estática comparativa (análisis gráfico y de elasticidades) | 7 | II.1 Variaciones en la renta (2): análisis gráfico (CRC y Engel), elasticidades y ley de Engel, agregación de Engel. II.2 Variaciones en los precios (4): análisis gráfico (CPC y demanda), análisis de elasticidades (precio propio, Slutsky propio, precio cruzado, Slutsky cruzado), agregación de Cournot. II.3 Valoración (1) |
| III. Otros desarrollos de la teoría de la demanda | 7 | Sin cambios: preferencia revelada (3), producción doméstica (1,5), precios hedónicos (2,5) |
| Conclusión | 3 | La nota de Thaler remite al anexo G; las extensiones remiten a los anexos D y F |

Anexos (tras `\clearpage` y `\appendix`, antes de la bibliografía): A. PMU en tres dimensiones (nuevo); B. Derivaciones; C. Formas comunes de la función de utilidad; D. Estimación de sistemas completos de demanda (recuperado); E. Enfoque cardinal de Marshall; F. Demanda de características de Lancaster (recuperado); G. Psicología y economía, Thaler (recuperado); H. Test. Orden: primero lo que complementa el cuerpo en su orden (I.2, derivaciones, formas funcionales y su uso empírico) y después los otros enfoques de la demanda (cardinal, Lancaster, Thaler).

**Contenido recuperado y de dónde sale**

- *Anexo A* (`original.md`, Anexo 1, l. 1736-1752, escaneos image26 e image27): se recupera porque aporta algo distinto del gráfico de la superficie de utilidad: por qué se satura la restricción y qué significa $\lambda$ (máximo absoluto dentro del conjunto presupuestario con $\lambda=0$ frente a utilidad monótona con máximo sobre la recta de balance y $\lambda>0$). Texto redactado de nuevo y gráfico nuevo en TikZ. La fuente del escaneo sigue sin identificarse (duda 14 anterior), así que el pie dice «elaboración propia a partir de Mas-Colell *et al.* (§3.D) y Sydsæter *et al.* (cap. 3)».
- *Anexo D, sistemas completos* (l. 1388-1509 y notas 56-60): idea y cinco pasos (forma funcional, sistema completo, datos, especificación, resultados). Errores corregidos:
  - «combinación entre sencillez y rigidez» → equilibrio entre sencillez y *flexibilidad*;
  - Cobb-Douglas: se quita la lista de propiedades duplicada con el anexo C (que tenía «translaciones paralelas», «curvas de Engel líneas crecientes» y «homogénea de grado α+β» con $\sum\alpha_i=1$) y se remite a la derivación B.8;
  - sistema lineal de gasto: no es cierto que «no predetermine drásticamente los resultados»: por ser aditivo excluye inferiores y complementarios y liga las elasticidades-precio a las elasticidades-renta (Deaton, 1974); «comparará» → reparte la renta supernumeraria;
  - translog: era «desarrollo de Taylor» sin más y con un signo dudoso en $-\ln u$; ahora, aproximación de segundo orden en logaritmos (Christensen, Jorgenson y Lau, 1975), sin escribir la forma;
  - nota 59: el modelo de Rotterdam no es «una versión generalizada del sistema lineal de gasto», sino un sistema en diferencias logarítmicas (Theil, 1965; Barten, 1967); Barten contrastó con él homogeneidad y simetría (V15, C42);
  - AIDS: se añade la ecuación de participaciones y por qué es útil (restricciones lineales, agregación exacta por PIGLOG); la nota del Nobel de Deaton (nota 57) se conserva con la motivación oficial y la referencia del BICE (nota 58) se cita;
  - datos: la «Encuesta Continua de Presupuestos Familiares» se presenta como antecesora de la EPF actual (anual desde 2006, panel de dos años), con las fuentes del INE ya citadas en II.1;
  - especificación: se añade la singularidad de la matriz de covarianzas y el resultado de Barten (1969);
  - nota 60 (las empresas recurren a encuestas y experimentos) se omite por no tener fuente.
- *Anexo E, enfoque cardinal*: sigue como anexo (ya revisado); solo cambia de posición (era el A) y la nota al opositor.
- *Anexo F, Lancaster* (l. 1286-1386, Imagen 21 y nota 55): idea, supuestos, modelo, desarrollo gráfico, implicaciones, aplicaciones y valoración (estas dos estaban vacías). Errores corregidos: la lista de motivaciones con numeración rota y las tres «cuestiones» (fidelidad a la marca, nuevos productos, publicidad), que no son las de Lancaster (1966): se sustituyen por las que plantea el artículo (bienes nuevos, calidad, relaciones de sustitución), y la marca y la publicidad pasan a las implicaciones para las empresas con remisión a 3.A.18; «frontera eficiente de consumo cóncava» → frontera de un conjunto convexo; la Imagen 21 (Muñoz Camacho, 2017, fuente excluida en V67) se rehace en TikZ con fuente Lancaster (1966) y una capa nueva con la subida del precio de un bien que deja de ser eficiente (demanda discontinua). La media-varianza vuelve en una línea como aplicación, con Markowitz (1952) y remisión a 3.A.10 (en el original, $\sigma$ era a la vez varianza y desviación típica: ya no se usa). Las estrategias de segmentación, nicho y publicidad (nota 55) quedan en una viñeta.
- *Anexo G, Thaler* (l. 1515-1537): sale de la nota de la Conclusión, que ahora solo da el Nobel y remite al anexo. Se mantienen las correcciones ya hechas: la racionalidad limitada es de Simon (1955) y el ejemplo de los porcentajes es contabilidad mental (Thaler, 1985); «efecto propiedad» → efecto dotación (Thaler, 1980; Kahneman, Knetsch y Thaler, 1990), sin la cita entre comillas sin fuente; preferencias sociales con el ejemplo de las palas de nieve (Kahneman, Knetsch y Thaler, 1986) en lugar del vendedor de paraguas.
- *Bloques I y II*: vuelven los títulos originales de bloque y de nivel 2 («Ingredientes», «Problema de maximización de la utilidad: el equilibrio», «Solución al problema de maximización», «Variaciones en renta», «Variaciones en precios», «Valoración») y la división «análisis gráfico / análisis de elasticidades». Se recuperan del original: la entrada de I con la pregunta «¿qué bienes y en qué cantidades adquirirá el consumidor?» (caja de anotaciones de l. 132), el enlace «una vez analizadas las dos herramientas…» (l. 600) y una recapitulación al final de I.3. La agregación vuelve a ser la «curva de demanda de mercado» dentro de I.3, como en el original, con todo lo añadido en la revisión. Las referencias internas «apartado I.2» a la demanda marshalliana pasan a «I.3».

**Tabla 1 y gráfico 4 unificados**: la tabla «Axiomas sobre las preferencias y qué garantiza cada uno» desaparece y su columna «Qué garantiza» pasa al gráfico `esquema-axiomas`, que ahora tiene tres columnas (axioma, qué garantiza, papel) y conserva las llaves del esquema de la página 6 del original: «Racionalidad (preorden completo)» sobre 1-3; «Con 1-4 existe una función de utilidad continua (Debreu)»; «Propiedades de U y dualidad» sobre 5-6, y «Para simplificar» sobre 6′-7. Capas para el vídeo: cada axioma aparece con lo que garantiza. Título: «Axiomas sobre las preferencias: qué garantiza cada uno y cómo se agrupan según su papel». El texto remite solo al gráfico 4.

**Numeración de gráficos y tablas**

- Gráficos 1-21 del cuerpo: sin cambios de número (el 4 cambia de contenido).
- Anexos: 22 `pmu-r3` (nuevo), 23 `demanda-cardinal` (antes 22), 24 `lancaster-caracteristicas` (nuevo). Los dos nuevos están en `_trabajo/graficos-pedidos.json`.
- Tablas: desaparece la 1; la clasificación por elasticidades pasa a ser la 1, Slutsky propio la 2, Slutsky cruzado la 3 y las del anexo de test, 4 y 5.

**Ficha de repaso** (`repaso/3A08-repaso.tex`), rehecha con la estructura nueva y los cambios pedidos: (1) el esquema de ingredientes abre el bloque I; (2) los axiomas con el elemento unificado; (3) la superficie de utilidad; (4) la solución interior y de esquina; (5) sin el gráfico de Gorman; (6) con el de elasticidades renta-precio; (7) sin el de precios hedónicos. Como los gráficos anchos eran ilegibles a ancho de columna, se han hecho variantes solo para la ficha: `esquema-ingredientes-repaso` (en vertical), `esquema-axiomas-repaso` (bandas de color en lugar de llaves), `superficie-utilidad-repaso` (solo el panel 3D), `solucion-interior-esquina-repaso` y `elasticidades-renta-precio-repaso` (letra mayor, sin los rótulos que ya da la fórmula). Se mantienen la descomposición de Slutsky, la preferencia revelada y la ley de Engel con datos; sale el de la CES. Letra de 8,5 pt, dos páginas exactas y segunda página ocupada al 96 %.

**Coherencia**: el anexo D remite a 3.A.9 (sistemas de demanda en estudios empíricos, dualidad e integrabilidad) y el F a 3.A.18 (diferenciación de productos) y 3.A.10 (media-varianza). Al revisar 3.A.9 conviene que su apartado de sistemas de demanda use las mismas correcciones (Rotterdam, sistema lineal de gasto, translog) y no repita la lista de propiedades de la Cobb-Douglas; al revisar 3.A.18, que el modelo de Lancaster coincida con el del anexo F (ahí está con la lista mal numerada, punto 6 de las contradicciones).

**Dudas**: (1) fuente del Anexo 1 escaneado (sigue sin identificar); (2) ¿basta el anexo G o Víctor quiere más de Thaler?; (3) `guion-cante.md` y `video/escenas.yaml` no se han tocado: citan la estructura y las capas antiguas (el gráfico 4 tiene capas nuevas) y deben rehacerse.
