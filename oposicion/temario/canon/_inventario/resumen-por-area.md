# Resumen por área del inventario (paso 1 de la consolidación del canon)

Generado el 13 oct. 2026 a partir de `_inventario/*.json` con `alias.json` (ids canónicos) y `areas.json`. Es la entrada para los agentes de fichas (`modelos/<id>.md`) y de notación (`notacion.md`). El tema de referencia y su motivo están en `../mapa.yaml`.

Papel: **D** desarrollo, **r** resumen, **m** mención, **p** previsto (tema sin fuente o falta en su inventario). Un modelo va al área de su tema de referencia.

Fuente de cada tema (`fuente_disponible` en `mapa.yaml`): si · parcial · renumerado (contenido en el Word de otro número del temario antiguo) · otro-titulo (Word del título antiguo) · no.


## consumidor-produccion (3.A.8-3.A.12)

Temas: 3.A.8 (si), 3.A.9 (si), 3.A.10 (si), 3.A.11 (si), 3.A.12 (parcial)


### Modelos compartidos (13)

| id | nombre | ref. | temas que lo usan | ids fusionados |
|---|---|---|---|---|
| `cobb-douglas` | Utilidad Cobb-Douglas | **3.A.8** | 3.A.6 m, 3.A.8 r, 3.A.9 r, 3.A.11 r | — |
| `lancaster` | Demanda de características de Lancaster | **3.A.8** | 3.A.8 r, 3.A.18 r | — |
| `pmu` | Problema de maximización de la utilidad (consumidor neoclásico) | **3.A.8** | 3.A.8 D, 3.A.9 r | — |
| `precios-hedonicos` | Modelo de precios hedónicos de Rosen (1974) | **3.A.8** | 3.A.8 D, 4.B.6 r | rosen-hedonicos |
| `indices-precios` | Índices de coste de vida (basados en VC y VE) y aproximaciones de Laspeyres y Paasche | **3.A.9** | 3.A.9 D, 4.A.1 r | indice-laspeyres, indice-paasche |
| `slutsky` | Ecuación y matriz de Slutsky (derivación) | **3.A.9** | 3.A.8 r, 3.A.9 D, 3.A.12 r, 4.B.9 r, 4.B.10 m, 4.B.11 m | — |
| `vc-ve` | Variación compensatoria y variación equivalente | **3.A.9** | 3.A.9 D, 4.B.6 m, 4.B.7 m, 4.B.9 r, 4.B.11 r | variacion-compensatoria, variacion-equivalente |
| `prospect-theory` | Teoría de las perspectivas (Kahneman y Tversky, 1979) | **3.A.10** | 3.A.1 r, 3.A.10 D | — |
| `ces` | Función de producción CES | **3.A.11** | 3.A.8 r, 3.A.11 D, 3.A.18 r, 3.A.44 m | — |
| `leontief` | Función de coeficientes fijos (Leontief) | **3.A.11** | 3.A.11 r, 3.B.5 r | — |
| `progreso-tecnico-neutral` | Progreso técnico neutral de Hicks, Solow y Harrod | **3.A.11** | 3.A.11 D, 3.B.9 r | progreso-tecnico-hicks |
| `ineficiencia-x` | Ineficiencia X de Leibenstein (1966) | **3.A.12** | 3.A.12 r, 3.B.39 m, 4.A.14 m, 4.A.15 m, 4.A.24 m, 4.A.25 m, 4.B.2 m, 4.B.15 m | x-eficiencia |
| `stigler-costes` | Costes de Stigler y reserva de capacidad | **3.A.12** | 3.A.12 r, 3.B.4 r | stigler-reserva-capacidad |

`*` = tema sin fuente (el inventario recoge lo que debería tratar).

Modelos de otras áreas que se usan aquí: `diamond-dybvig` (ref. 3.B.26), `hall` (ref. 3.A.33), `markowitz` (ref. 3.B.23), `monopolio-natural` (ref. 3.A.17)


### Notación

**Un concepto, varios símbolos** (entre temas del área):

- aversión al riesgo / CRRA: `η` (3.A.8); `r_α, r_r` (3.A.10); `θ` (3.A.10); `r_α` (3.A.10); `r_r (r_R en las preguntas)` (3.A.10)
- cantidades / cesta: `x` (3.A.8, 3.A.9); `q` (3.A.9); `q (frente a x en el resto)` (3.A.9); `X, Y` (3.A.11)
- precios de los bienes: `p` (3.A.8, 3.A.9); `w` (3.A.12)
- producción / renta agregada: `q, Q` (3.A.11); `q, Q̄` (3.A.12); `q` (3.A.12); `Q̄` (3.A.12)
- renta (del consumidor): `W̄` (3.A.8, 3.A.9); `W̄_h` (3.A.8); `V (choca con V de la FIU)` (3.A.8)
- utilidad: `U_i` (3.A.8); `Ū^0, Ū^1` (3.A.9); `u(x)` (3.A.10); `V(ỹ)` (3.A.10)

**Un símbolo, varios significados** (entre temas del área; se omiten los que solo cambian de redacción):

- `p`: precios de los bienes (3.A.8, 3.A.9); probabilidad (3.A.10); precio del output (3.A.12); precio output (3.A.12)
- `w`: salario (3.A.8); precios de los bienes (3.A.12); precios factores (3.A.12)
- `σ`: elasticidad de sustitución (3.A.8, 3.A.11); inverso eis en preferencias macro (3.A.8)
- `q`: cantidades / cesta (3.A.9); producción / renta agregada (3.A.12)

**Notación de los modelos compartidos que cambia de un tema a otro:**

- `ces` · pesos: `a_i` (3.A.8); `s_i (en 3.A.8 revisado: a_i)` (3.A.11)
- `diamond-dybvig` · consumo: `c` (3.A.10); `c_1, c_2` (4.A.20)

**Incoherencias internas** (dentro de cada tema):

- 3.A.8: V se usa para la FIU y para la renta no laboral en la restricción de Becker (eq:becker-restricciones).
- 3.A.8: σ es elasticidad de sustitución en el cuerpo y parámetro de curvatura (inverso de la EIS) en el anexo de preferencias macro; se avisa en el texto.
- 3.A.9: Precios: p en todo el tema pero P_x, P_y en la Cobb-Douglas; cantidades x salvo q en los índices.
- 3.A.9: La Cobb-Douglas se presenta con exponentes α y β y demandas x=αW̄/((α+β)P_x), y luego se dice que es 'lineal en logaritmos'; Stone-Geary se llama 'forma log-lineal' y luego 'diferencias de logaritmos' (confuso).
- 3.A.9: Ley de Walras atribuida a la «estricta monotonía» (debe ser insaciabilidad local, como en 3.A.8 revisado).
- 3.A.10: Pérdida: L en el texto y P en el punto inicial A=(p1,p2; W, W−P).
- 3.A.10: Aversión relativa: r_r en el texto y r_R en las preguntas de examen.
- 3.A.10: p es probabilidad y en la nota 6 se compara con 'competencia perfecta' cuando se quiere decir certidumbre.
- 3.A.10: El epígrafe atribuye a Rothschild y Stiglitz (1976) el modelo básico de demanda de seguros con información simétrica.
- 3.A.11: Output q en la definición y Q en la elasticidad de escala.
- 3.A.11: Y designa el conjunto tecnológico y uno de los bienes de la caja de Edgeworth.
- 3.A.11: La fórmula de la proporcionalidad de escala está mal escrita: dz_L/dz_L = dz_K/dz_K = dλ/dλ (debería ser dz_L/z_L = dz_K/z_K = dλ/λ).
- 3.A.11: σ=0 y σ=1 presentados como casos exactos de la CES (son límites).
- 3.A.12: Output denotado q (primal) y Q̄ (dual); factores z en general y K, L en la estática comparativa
- 3.A.12: Numeración de propiedades de la función de costes salta (1, 8, 9, 10…) por herencia de lista en el Word
- 3.A.12: El índice no incluye el apartado «Implicaciones sobre la estructura de mercado» que sí aparece en el cuerpo (3.0)

### Modelos desarrollados en varios temas o contados de forma distinta

- `cobb-douglas` (ref. 3.A.8; desarrollo en ninguno).
  - 3.A.6 [m] «Función Cobb-Douglas» (0 ec., 0 gráf.; para: tecnología del RBC)
  - 3.A.8 [r] «Utilidad Cobb-Douglas» (1 ec., 1 gráf.; para: Ejemplo de demandas con participaciones de gasto constantes)
  - 3.A.9 [r] «Utilidad Cobb-Douglas» (1 ec., 0 gráf.; para: Primera forma funcional de los sistemas de demanda)
  - 3.A.11 [r] «Función de producción Cobb-Douglas» (0 ec., 2 gráf.; para: Ejemplo de función neoclásica de buen comportamiento, σ=1)
- `indices-precios` (ref. 3.A.9; desarrollo en 3.A.9).
  - 3.A.9 [D] «Índices de coste de vida (basados en VC y VE) y aproximaciones de Lasp» (3 ec., 0 gráf.; para: Medir el bienestar con información incompleta)
  - 4.A.1 [r] «Índice de precios de Laspeyres (IPC encadenado, IPI, ICLA)» (2 ec., 0 gráf.; para: Explicar la metodología del IPC, el IPI y el ICLA y su sesgo de sobree)
- `slutsky` (ref. 3.A.9; desarrollo en 3.A.9).
  - 3.A.8 [r] «Ecuación de Slutsky (enunciado y clasificación)» (1 ec., 2 gráf.; para: Descomponer el efecto precio en sustitución y renta; clasificar bienes)
  - 3.A.9 [D] «Ecuación y matriz de Slutsky (derivación)» (1 ec., 1 gráf.; para: Descomposición formal efecto sustitución/renta y propiedades (simetría)
  - 3.A.12 [r] «Ecuación de Slutsky para la demanda de factores» (0 ec., 0 gráf.; para: descomponer el efecto de una variación del precio de un factor en efec)
  - 4.B.9 [r] «Descomposición en efecto sustitución, efecto renta ordinario y efecto » (0 ec., 0 gráf.; para: Efectos de impuestos sobre ocio y ahorro)
  - 4.B.10 [m] «Ecuación de Slutsky con dotación» (0 ec., 0 gráf.; para: Base implícita de la descomposición de efectos)
  - 4.B.11 [m] «Descomposición efecto renta/sustitución (demanda compensada frente a o» (0 ec., 0 gráf.; para: El exceso de gravamen se asocia al efecto sustitución)
- `vc-ve` (ref. 3.A.9; desarrollo en 3.A.9).
  - 3.A.9 [D] «Medidas de bienestar: excedente del consumidor, variación compensatori» (4 ec., 2 gráf.; para: Medir monetariamente cambios de bienestar ante variaciones de precios)
  - 4.B.6 [m] «Variación compensatoria» (0 ec., 0 gráf.; para: Valor del coste/beneficio para el afectado manteniendo la utilidad ini)
  - 4.B.7 [m] «Variación equivalente» (0 ec., 0 gráf.; para: Medir el exceso de gravamen)
  - 4.B.9 [r] «Variación equivalente (y compensatoria)» (0 ec., 0 gráf.; para: Método de medición del exceso de gravamen)
  - 4.B.11 [r] «Variación equivalente (Hicks)» (0 ec., 1 gráf.; para: Medir en unidades monetarias la pérdida de bienestar del impuesto)
- `ces` (ref. 3.A.11; desarrollo en 3.A.11).
  - 3.A.8 [r] «Función CES de utilidad» (2 ec., 1 gráf.; para: Ilustrar la elasticidad de sustitución y sus casos límite (Leontief, C)
  - 3.A.11 [D] «Función de producción CES» (2 ec., 0 gráf.; para: Forma funcional con σ constante y casos particulares)
  - 3.A.18 [r] «Función CES» (1 ec., 0 gráf.; para: Agregador de variedades)
  - 3.A.44 [m] «Función CES» (0 ec., 0 gráf.; para: Nota sobre Jones-Manuelli.)
- `ineficiencia-x` (ref. 3.A.12; desarrollo en ninguno).
  - 3.A.12 [r] «Ineficiencia X de Leibenstein (1966)» (0 ec., 0 gráf.; para: crítica a la minimización de costes)
  - 3.B.39 [m] «X-eficiencia (Leibenstein)» (0 ec., 0 gráf.; para: eficiencia productiva de la competencia)
  - 4.A.14 [m] «Baja productividad por atomización (implícito)» (0 ec., 0 gráf.; para: Explicar baja productividad del comercio minorista)
  - 4.A.15 [m] «Ineficiencia X (Leibenstein); «vida tranquila» de Hicks» (0 ec., 0 gráf.; para: Eficiencia productiva de la competencia)
  - 4.A.24 [m] «Ineficiencia X (Leibenstein)» (0 ec., 0 gráf.; para: mayor competencia de empresas internacionalizadas mejora la eficiencia)
  - 4.A.25 [m] «Ineficiencia X (Leibenstein)» (0 ec., 0 gráf.; para: mayor competencia de empresas internacionalizadas mejora la eficiencia)
  - 4.B.2 [m] «Ineficiencia X de Leibenstein» (0 ec., 0 gráf.; para: El burócrata no minimiza costes)
  - 4.B.15 [m] «Ineficiencia X de Leibenstein» (0 ec., 0 gráf.; para: Causa de ineficiencia relativa de la empresa pública)

**Bloques repetidos o copiados entre temas** (según las observaciones de los inventarios):

- 3.A.9: La Introducción repite casi literalmente la del Word de 3.A.8 (Antonelli como origen de la dualidad, Hicks y Allen 1934 'introducen las preferencias', Walras/Marshall siguiendo a Gossen): en 3.A.8 revisado esos errores ya están corregidos;
- 3.A.10: Autorreferencia dentro del propio tema, en un bloque de notas copiado de otro texto;

## mercados-informacion-juegos (3.A.13-3.A.20)

Temas: 3.A.13 (si), 3.A.14 (parcial), 3.A.15 (no), 3.A.16 (si), 3.A.17 (si), 3.A.18 (si), 3.A.19 (si), 3.A.20 (no)


### Modelos compartidos (15)

| id | nombre | ref. | temas que lo usan | ids fusionados |
|---|---|---|---|---|
| `stiglitz-weiss` | Racionamiento del crédito (Stiglitz y Weiss, 1981) | **3.A.13** | 3.A.7 m, 3.A.13 r, 3.B.27 D, 3.B.28 m, 4.A.20 D, 4.A.24 m, 4.A.25 m | informacion-asimetrica-credito |
| `dilema-prisionero` | Dilema del prisionero | **3.A.14** | 3.A.14 r, 3.A.23 m, 4.A.15 m | — |
| `subastas` | Subastas (primer y segundo precio, holandesa, inglesa, valores comunes; equivalencia de ingresos) | **3.A.14** | 3.A.14 D, 4.A.19 r | — |
| `competencia-perfecta-equilibrio-parcial` | Competencia perfecta en equilibrio parcial (Mas-Colell, utilidad cuasilineal) | **3.A.16** | 3.A.16 D, 4.A.15 m | competencia-perfecta-bienestar, largo-plazo-libre-entrada |
| `excedentes-bienestar` | Excedente del consumidor, del productor y total; 1TFEB y 2TFEB en equilibrio parcial | **3.A.16** | 3.A.16 D, 4.B.6 r | excedente-consumidor |
| `tatonnement` | Estabilidad walrasiana (precios) y marshalliana (cantidades) | **3.A.16** | 3.A.16 D, 3.A.21 r | estabilidad-walras-marshall |
| `averch-johnson` | Regulación de la tasa de beneficio (Averch-Johnson) | **3.A.17** | 3.A.17 r, 4.B.15 m | — |
| `laffont-tirole` | Menú de contratos de Laffont y Tirole (1986) | **3.A.17** | 3.A.17 r, 4.B.15 m | — |
| `monopolio-natural` | Monopolio natural (subaditividad y sostenibilidad, Baumol) | **3.A.17** | 3.A.12 r, 3.A.17 D, 4.A.5 p, 4.A.12 m, 4.A.15 m, 4.B.15 m | regulacion-monopolio-natural, subaditividad-monopolio-natural |
| `price-cap` | Price cap IPC−X (Littlechild, 1983) | **3.A.17** | 3.A.17 r, 4.A.12 m, 4.B.15 m | — |
| `ramsey-boiteux` | Precios de Ramsey-Boiteux | **3.A.17** | 3.A.17 D, 4.B.15 m | — |
| `tarifa-dos-partes` | Tarifa en dos partes (Coase) y tarifas pico-valle | **3.A.17** | 3.A.17 r, 4.B.15 m | — |
| `chamberlin` | Competencia monopolística de Chamberlin (1933) | **3.A.18** | 3.A.4 m, 3.A.18 D | competencia-monopolistica |
| `falvey` | Falvey: diferenciación vertical en comercio | **3.A.18** | 3.A.18 m, 3.B.6 r | — |
| `mercados-impugnables` | Mercados contestables (Baumol, 1982) | **3.A.19** | 3.A.17 m, 3.A.19 D, 4.B.15 m | mercados-contestables |

`*` = tema sin fuente (el inventario recoge lo que debería tratar).

Modelos de otras áreas que se usan aquí: `ces` (ref. 3.A.11), `downs-hotelling` (ref. 4.B.2), `incidencia-equilibrio-parcial` (ref. 4.B.8), `krugman-1979` (ref. 3.B.6), `lancaster` (ref. 3.A.8), `marshall-equilibrio-parcial` (ref. 3.A.3), `salarios-eficiencia` (ref. 3.A.27), `yardstick` (ref. 4.B.15)


### Notación

**Un concepto, varios símbolos** (entre temas del área):

- beneficio: `B_i` (3.A.16, 3.A.19); `B` (3.A.17, 3.A.19); `π` (3.A.18, 3.A.19); `π, Π` (3.A.19); `Π` (3.A.19)
- cantidades / cesta: `q_i` (3.A.16, 3.A.17); `q` (3.A.17, 3.A.18); `S` (3.A.13); `x_m` (3.A.16); `x_i` (3.A.18); `x_i / q` (3.A.18); `q_1, q_2, Q` (3.A.19); `q_1,q_2` (3.A.19)
- coste: `C_i(q̄_i, w)` (3.A.16); `C(q)` (3.A.17)
- precios de los bienes: `p` (3.A.16); `P` (3.A.17); `P_i` (3.A.17)
- utilidad: `U^R` (3.A.13); `φ_m` (3.A.16)

**Un símbolo, varios significados** (entre temas del área; se omiten los que solo cambian de redacción):

- `p`: probabilidad de accidente (seguros) (3.A.13); probabilidad de accidente (3.A.13); precio del bien (3.A.16); precios de los bienes (3.A.16)
- `W`: riqueza (3.A.13); bienestar (excedente total) en ramsey-bo (3.A.17); bienestar (3.A.17)
- `x_i`: pago asignado en el juego cooperativo (3.A.14); pagos (3.A.14); cantidades / cesta (3.A.18)
- `t`: tipo impositivo (3.A.16); coste de transporte (3.A.18); coste transporte (3.A.18)
- `w`: salario (3.A.13); precios factores (3.A.16)

**Notación de los modelos compartidos que cambia de un tema a otro:**

- `ces` · pesos: `a_i` (3.A.8); `s_i (en 3.A.8 revisado: a_i)` (3.A.11)

**Incoherencias internas** (dentro de cada tema):

- 3.A.13: Punto inicial A = (p₁, p₂; W, W − P): usa P y p₁,p₂ cuando el resto del modelo usa L y p, 1−p
- 3.A.13: La remuneración se escribe w(I) en el problema del principal y w(e) en la explicación
- 3.A.13: E se usa para educación (Spence) y para «éxito» (principal-agente); p para probabilidad de accidente y p_E para probabilidad de éxito
- 3.A.13: La RMSE se compara con −(1−p)/p y la pendiente de la recta con −(1−r)/r: correcto, pero sin explicar explícitamente r=p en el texto del gráfico
- 3.A.14: La definición de EN usa desigualdad estricta (>) en lugar de ≥
- 3.A.14: En el problema de puja aparece θ_1 donde antes era v_1, y α_2 sin definir; α también es la probabilidad del tipo
- 3.A.14: v se usa para la función característica y para las valoraciones
- 3.A.14: «Equilibrio de Bayes Perfecto en Subjuegos (EBPS)»: denominación no estándar (equilibrio bayesiano perfecto)
- 3.A.14: Racionalidad para coaliciones se escribe con ≤ en la definición y con ≥ en el ejemplo (lo correcto es ≥)
- 3.A.14: En segundo precio el pago se escribe π = v_i − b_j sin definir j (segunda puja más alta)
- 3.A.16: Llama «walrasiana» a la demanda directa, cuando el 3.A.8 usa «marshalliana»
- 3.A.16: Función de costes C_i(q̄_i, w) y luego C_i(w, q_i); el 3.A.12 usa C(w, Q̄)
- 3.A.16: Cantidad demandada x y ofrecida q para el mismo bien (aceptable, pero en P(x*)=C'(x*) se mezclan)
- 3.A.16: Índice: el apartado 3 lista corto plazo/largo plazo sin y con libre entrada, mientras la nota de estructura habla de 3.1 análisis marshalliano y 3.2 concepción actual
- 3.A.17: Beneficio como B (aquí) frente a π en 3.A.18; demanda como q^m(p) y P(q) mezcladas.
- 3.A.17: El índice incluye notas de trabajo y la propuesta de estructura dos veces (al inicio y en el apartado III).
- 3.A.18: Nota 11: 'los CMe disminuyen conforme aumenta x' cuando la variable es q.
- 3.A.18: Demanda de cada variedad x_i y producción q mezcladas; beneficio π (en 3.A.17 y 3.A.19 es B).
- 3.A.18: Título del apartado II habla de 'oligopolio con bienes diferenciados' mientras el título oficial dice 'otros desarrollos'.
- 3.A.19: Beneficio B_i en el análisis estático y π/Π en el dinámico.
- 3.A.19: Precio en mayúscula P(Q) en Cournot y minúscula p en Bertrand.

### Modelos desarrollados en varios temas o contados de forma distinta

- `stiglitz-weiss` (ref. 3.A.13; desarrollo en 3.B.27, 4.A.20).
  - 3.A.7 [m] «Racionamiento del crédito (Stiglitz-Weiss 1981)» (0 ec., 0 gráf.; para: imperfecciones del mercado de crédito)
  - 3.A.13 [r] «Racionamiento del crédito (Stiglitz y Weiss, 1981)» (0 ec., 2 gráf.; para: selección adversa y riesgo moral simultáneos en el mercado de crédito)
  - 3.B.27 [D] «Racionamiento del crédito (Stiglitz y Weiss, 1981)» (2 ec., 2 gráf.; para: selección adversa en el crédito)
  - 3.B.28 [m] «Racionamiento del crédito (Stiglitz y Weiss, 1981)» (0 ec., 0 gráf.; para: Mercado de crédito en países en desarrollo.)
  - 4.A.20 [D] «Racionamiento del crédito con información asimétrica (Stiglitz y Weiss» (2 ec., 2 gráf.; para: justificar por qué conviene reducir la dependencia de la financiación )
  - 4.A.24 [m] «Información asimétrica y racionamiento del crédito a la exportación» (0 ec., 0 gráf.; para: justificar la intervención financiera pública (fallo de mercado))
  - 4.A.25 [m] «Información asimétrica y racionamiento del crédito a la exportación» (0 ec., 0 gráf.; para: justificar la intervención financiera pública (fallo de mercado))
- `dilema-prisionero` (ref. 3.A.14; desarrollo en ninguno).
  - 3.A.14 [r] «Dilema del prisionero» (0 ec., 1 gráf.; para: ilustrar la estrategia dominante y la ineficiencia del EN)
  - 3.A.23 [m] «Dilema del prisionero en la provisión de bienes públicos» (0 ec., 0 gráf.; para: Polizón como equilibrio de Nash)
  - 4.A.15 [m] «Dilema del prisionero aplicado a programas de clemencia» (0 ec., 0 gráf.; para: Explicar la disuasión de cárteles)
- `competencia-perfecta-equilibrio-parcial` (ref. 3.A.16; desarrollo en 3.A.16).
  - 3.A.16 [D] «Competencia perfecta en equilibrio parcial (Mas-Colell, utilidad cuasi» (7 ec., 4 gráf.; para: construir oferta, demanda y equilibrio competitivo con número de empre)
  - 4.A.15 [m] «Competencia perfecta como referencia de eficiencia (primer teorema del» (0 ec., 0 gráf.; para: Justificar la liberalización y la defensa de la competencia)
- `monopolio-natural` (ref. 3.A.17; desarrollo en 3.A.17).
  - 3.A.12 [r] «Subaditividad de costes y monopolio natural» (1 ec., 2 gráf.; para: implicaciones de los costes sobre la estructura de mercado)
  - 3.A.17 [D] «Monopolio natural (subaditividad y sostenibilidad, Baumol)» (1 ec., 1 gráf.; para: Monopolio natural uni y multiproducto)
  - 4.A.5 [p] «regulacion-monopolio-natural» (0 ec., 0 gráf.; para: )
  - 4.A.12 [m] «Monopolio natural en industrias de red» (0 ec., 0 gráf.; para: Justificar la regulación del bucle local y de la red ferroviaria y su )
  - 4.A.15 [m] «Monopolio natural y subaditividad de costes» (0 ec., 0 gráf.; para: Argumento a favor de mantener monopolio en infraestructuras de red y d)
  - 4.B.15 [m] «Monopolio natural: subaditividad, sostenibilidad, economías de alcance» (3 ec., 1 gráf.; para: Principal justificación de empresas públicas en industrias red (en el )
- `mercados-impugnables` (ref. 3.A.19; desarrollo en 3.A.19).
  - 3.A.17 [m] «Mercados impugnables (Baumol, 1982)» (0 ec., 0 gráf.; para: Política de competencia)
  - 3.A.19 [D] «Mercados contestables (Baumol, 1982)» (0 ec., 0 gráf.; para: Barreras de entrada (contenido que pertenece a 3.A.15))
  - 4.B.15 [m] «Mercados contestables (Baumol)» (0 ec., 0 gráf.; para: Alternativa a la empresa pública cuando el poder de mercado es estraté)
- `incidencia-equilibrio-parcial` (ref. 4.B.8; desarrollo en 3.A.16, 4.B.8).
  - 3.A.16 [D] «Impuesto unitario en equilibrio parcial» (2 ec., 2 gráf.; para: estática comparativa normativa)
  - 4.A.11 [m] «Incidencia de una subvención con oferta inelástica» (0 ec., 0 gráf.; para: Explicar que las deducciones por compra de vivienda se trasladan a pre)
  - 4.B.8 [D] «Incidencia en equilibrio parcial competitivo (impuesto unitario sobre » (2 ec., 4 gráf.; para: Quién soporta la carga según las elasticidades)
  - 4.B.13 [m] «Traslación e incidencia según elasticidades» (0 ec., 0 gráf.; para: Quién soporta económicamente el IVA; evidencia de Benzarti et al. (asi)

**Bloques repetidos o copiados entre temas** (según las observaciones de los inventarios):

- 3.A.17: La nota 48 sobre política de competencia UE está duplicada literalmente en 3.A.19.
- 3.A.19: La nota 48 (política de competencia UE) es idéntica a la de 3.A.17.

## equilibrio-general-bienestar (3.A.21-3.A.24)

Temas: 3.A.21 (si), 3.A.22 (parcial), 3.A.23 (parcial), 3.A.24 (si)


### Modelos compartidos (15)

| id | nombre | ref. | temas que lo usan | ids fusionados |
|---|---|---|---|---|
| `egc` | Modelos de equilibrio general computable (Scarf) | **3.A.21** | 3.A.21 m, 4.B.8 m | egc-computable |
| `equilibrio-general-walras` | Equilibrio general walrasiano (2×2×2×2) | **3.A.21** | 3.A.3 D, 3.A.21 D, 3.A.22 D, 3.A.23 D, 4.B.11 r | equilibrio-general-2x2x2x2, walras-equilibrio-general |
| `second-best` | Teoría del second best (Lipsey y Lancaster, 1956; Meade, 1955) | **3.A.22** | 3.A.22 D, 4.B.9 m, 4.B.11 m | — |
| `teoremas-bienestar` | Primer y Segundo Teorema Fundamental de la Economía del Bienestar | **3.A.22** | 3.A.21 r, 3.A.22 r, 3.A.23 D, 4.A.24 m, 4.B.2 r, 4.B.3 r, 4.B.7 r | teoremas-fundamentales-bienestar |
| `cap-and-trade` | Mercado de derechos de emisión (cap and trade) | **3.A.23** | 3.A.23 r, 3.B.37 m | rcde-ue |
| `clarke-groves` | Mecanismo de Clarke-Groves | **3.A.23** | 3.A.23 D, 3.A.24 m, 4.B.7 m | — |
| `coase` | Teorema de Coase (acería y piscifactoría) | **3.A.23** | 3.A.23 D, 4.A.6 p | — |
| `pigou` | Externalidades e impuesto pigouviano | **3.A.23** | 3.A.23 D, 4.A.6 p, 4.A.13 m, 4.B.7 m, 4.B.9 m, 4.B.10 m, 4.B.11 m, 4.B.13 r | externalidad-equilibrio-parcial-pigou, externalidades, externalidades-pigou, impuestos-pigouvianos |
| `samuelson-bienes-publicos` | Condición de Samuelson para la provisión óptima de bienes públicos | **3.A.23** | 3.A.23 D, 4.B.5 m | fpp-publico-privado |
| `arrow-imposibilidad` | Teorema de imposibilidad de Arrow (1951) | **3.A.24** | 3.A.24 D, 4.B.2 D | — |
| `atkinson-indice` | Índice de Atkinson | **3.A.24** | 3.A.24 m, 4.B.3 m | — |
| `borda` | Regla de Borda y otras reglas (segunda vuelta, D'Hondt) | **3.A.24** | 3.A.24 r, 4.B.2 m | — |
| `fbs-rawlsiana` | FBS rawlsiana (maximin) | **3.A.24** | 3.A.24 D, 4.B.3 r | rawls-velo-ignorancia |
| `funcion-bienestar-social` | Función de bienestar social de Bergson (1938)-Samuelson (1947) | **3.A.24** | 3.A.22 m, 3.A.24 D, 4.B.2 r | fbs-bergson-samuelson |
| `gibbard-satterthwaite` | Teorema de Gibbard-Satterthwaite | **3.A.24** | 3.A.24 r, 4.B.2 m | — |

`*` = tema sin fuente (el inventario recoge lo que debería tratar).

Modelos de otras áreas que se usan aquí: `buchanan-tullock-mayoria-optima` (ref. 4.B.2), `dilema-prisionero` (ref. 3.A.14), `downs-hotelling` (ref. 4.B.2), `niskanen` (ref. 4.B.2), `paradoja-condorcet` (ref. 4.B.2), `patinkin` (ref. 3.A.5), `tatonnement` (ref. 3.A.16), `viner` (ref. 3.B.10), `votante-mediano` (ref. 4.B.2)


### Notación

**Un concepto, varios símbolos** (entre temas del área):

- cantidades / cesta: `X, Y` (3.A.21, 3.A.22, 3.A.23); `q, q*, q'` (3.A.23); `q` (3.A.23)
- utilidad: `U_A, U_B` (3.A.22, 3.A.23); `U_A(X_A,Y_A)` (3.A.22); `U_A(X_A,Y_A); U_B(X_B,Y_B,X_A)` (3.A.23); `U_1…U_I` (3.A.24)

**Un símbolo, varios significados** (entre temas del área; se omiten los que solo cambian de redacción):

- `X, Y`: bienes (mayuscula) en la economia; x_h,  (3.A.21); cantidades / cesta (3.A.21, 3.A.22, 3.A.23); bienes (y cantidades producidas) (3.A.22); bienes privados (apartados 1 y 2.1) (3.A.23)

**Notación de los modelos compartidos que cambia de un tema a otro:**

- `equilibrio-general-walras` · bienes: `X, Y` (3.A.21, 3.A.22, 3.A.23); `X₁, X₂` (4.B.11)
- `equilibrio-general-walras` · factores: `K, L` (3.A.21); `L, K` (3.A.22, 3.A.23, 4.B.11)
- `equilibrio-general-walras` · renta: `W̄_h` (3.A.21); `W̄ = w_L·O₀ + M` (4.B.11)
- `teoremas-bienestar` · dotacion: `e` (3.A.22); `e, e'` (4.B.3)
- `arrow-imposibilidad` · preferencias individuales: `R_i, \succ_i` (3.A.24); `R_i` (4.B.2)
- `arrow-imposibilidad` · ordenacion social: `R_G, \succeq_G` (3.A.24); `R_G` (4.B.2)
- `funcion-bienestar-social` · bienestar: `W` (3.A.22, 4.B.2); `W(•)` (3.A.24)
- `funcion-bienestar-social` · utilidades: `U_A, U_B` (3.A.22); `U_1…U_I` (3.A.24)

**Incoherencias internas** (dentro de cada tema):

- 3.A.21: Bienes X, Y en mayúscula y consumo x_h, y_h y precios p_x/p_X mezclados.
- 3.A.21: Afirma que la convexidad estricta del conjunto de producción implica rendimientos decrecientes a escala (y en 1TFEB pide rendimientos no crecientes).
- 3.A.21: Las propiedades de las demandas netas dicen 'las curvas de oferta netas no varían' (copiado de la oferta).
- 3.A.21: Numeración de listas rota en la versión convertida (1,3,4… y 7,8,9,10).
- 3.A.22: Las funciones de utilidad se declaran ordinales y a la vez con «utilidad marginal positiva pero decreciente» (propiedad cardinal).
- 3.A.22: Orden de argumentos de la función de producción: F_X(K_X,L_X) en supuestos y F_X(L_X,K_X) en el programa de optimización.
- 3.A.22: Se atribuyen a la axiomática de Debreu propiedades de la función de utilidad (ordinal, diferenciable, cuasicóncava), no axiomas de preferencias.
- 3.A.22: Se habla de modelo 2×2×2×2 y, más adelante, de «modelo 2×2×2» con 10 incógnitas.
- 3.A.22: Nota de pizarra pendiente: «[aprovechar el existente en pizarra]» en el programa de eficiencia global.
- 3.A.23: La externalidad se modeliza analíticamente en el consumo (equilibrio general) y gráficamente en la producción (equilibrio parcial), sin enlazar ambos.
- 3.A.23: Bienes públicos: el programa fija X_A+X_B=\bar X y a la vez impone la FPP T(X,G)=0 (X no debería ser fija); además el propio autor duda de si es la solución óptima o la de libre mercado.
- 3.A.23: Notación de la RMT con bien público: |RMT_X^G| en la condición de Samuelson y RMT_G^X en la solución competitiva.
- 3.A.23: Apartado 1 repite íntegro el modelo 2×2×2×2 de 3.A.22 con otra orientación (precios), lo que con el título vigente duplica contenidos.
- 3.A.24: Nota del autor: se afirma que la FBS exige utilidad cardinal y a la vez que cardinalidad no implica comparabilidad interpersonal (nota 43, «¡Cuidado!»): la exposición mezcla ambos conceptos.
- 3.A.24: Se usa I individuos y U_1…U_I en la FBS, pero en el resumen del criterio de Pareto se mantienen A y B como en 3.A.22.
- 3.A.24: Problema del planificador de la FBS vacío (bloque matemático sin contenido).
- 3.A.24: La conclusión dice que las 2 líneas son criterios de compensación y FBS, pero la estructura plantea FBS y levantamiento de axiomas como escapatorias a Arrow.
- 3.A.24: Errata «irrelevancia de las alternativas relevantes» en el resumen de los axiomas; «ley D'Hont» por D'Hondt.

### Modelos desarrollados en varios temas o contados de forma distinta

- `equilibrio-general-walras` (ref. 3.A.21; desarrollo en 3.A.3, 3.A.21, 3.A.22, 3.A.23). **Posible copia literal** (mismo nombre y mismas ecuaciones): 3.A.22, 3.A.23.
  - 3.A.3 [D] «Walras: principio equimarginal y equilibrio general» (0 ec., 0 gráf.; para: interdependencia de mercados)
  - 3.A.21 [D] «Equilibrio general competitivo walrasiano 2×2×2×2» (5 ec., 3 gráf.; para: Construcción, existencia, unicidad, estabilidad y optimalidad del EGC)
  - 3.A.22 [D] «Modelo de equilibrio general 2×2×2×2 (2 bienes, 2 empresas, 2 factores» (6 ec., 4 gráf.; para: Condiciones de óptimo de Pareto (producción, intercambio, global) y ob)
  - 3.A.23 [D] «Modelo de equilibrio general 2×2×2×2 (2 bienes, 2 empresas, 2 factores» (6 ec., 4 gráf.; para: Demostrar el 1TFEB (contenido que con el título vigente pertenece a 3.)
  - 4.B.11 [r] «Modelo de equilibrio general 1×2×2×2 (1 consumidor con ocio, 2 bienes,» (5 ec., 0 gráf.; para: Mostrar que sin impuestos se cumple el 1TFEB y que los impuestos disto)
- `teoremas-bienestar` (ref. 3.A.22; desarrollo en 3.A.23).
  - 3.A.21 [r] «Primer y segundo teoremas fundamentales del bienestar» (0 ec., 0 gráf.; para: Análisis normativo del EGC)
  - 3.A.22 [r] «Primer y Segundo Teorema Fundamental de la Economía del Bienestar» (1 ec., 1 gráf.; para: Relación entre equilibrio competitivo y óptimo de Pareto; separación e)
  - 3.A.23 [D] «Primer y Segundo Teorema Fundamental de la Economía del Bienestar» (2 ec., 1 gráf.; para: Punto de partida: cuándo el EGC es óptimo y por qué fallos de mercado )
  - 4.A.24 [m] «Segundo teorema fundamental de la economía del bienestar» (0 ec., 0 gráf.; para: compensación de perdedores de la apertura (equidad))
  - 4.B.2 [r] «Teoremas fundamentales de la economía del bienestar y óptimo de Pareto» (2 ec., 1 gráf.; para: Mostrar la incompletitud de Pareto que motiva la elección social)
  - 4.B.3 [r] «Segundo teorema fundamental del bienestar» (0 ec., 1 gráf.; para: Justificar la redistribución separando eficiencia y equidad)
  - 4.B.7 [r] «Teoremas fundamentales de la economía del bienestar» (0 ec., 2 gráf.; para: Justificar los principios de eficiencia y equidad y la separación con )
- `pigou` (ref. 3.A.23; desarrollo en 3.A.23).
  - 3.A.23 [D] «Externalidad negativa en la producción en equilibrio parcial e impuest» (1 ec., 3 gráf.; para: Ilustrar la sobreproducción y su corrección (impuesto/subvención, está)
  - 4.A.6 [p] «externalidades-pigou» (0 ec., 0 gráf.; para: )
  - 4.A.13 [m] «Externalidades negativas y bienes comunes (sobreexplotación)» (0 ec., 0 gráf.; para: Justificar la intervención pública en turismo)
  - 4.B.7 [m] «Impuesto pigouviano (acería y piscifactoría)» (0 ec., 0 gráf.; para: Impuestos que aumentan la eficiencia)
  - 4.B.9 [m] «Impuesto pigouviano» (0 ec., 0 gráf.; para: Excepción: impuesto que corrige una externalidad)
  - 4.B.10 [m] «Impuesto pigouviano» (0 ec., 0 gráf.; para: Ejemplo de efecto incentivo deseable)
  - 4.B.11 [m] «Impuesto pigouviano» (0 ec., 0 gráf.; para: Excepción: impuesto que mejora la eficiencia)
  - 4.B.13 [r] «Impuestos pigouvianos» (0 ec., 0 gráf.; para: Justificación de los impuestos especiales y de la fiscalidad verde)
- `arrow-imposibilidad` (ref. 3.A.24; desarrollo en 3.A.24, 4.B.2).
  - 3.A.24 [D] «Teorema de imposibilidad de Arrow (1951)» (3 ec., 0 gráf.; para: ¿Existe una regla de agregación de preferencias ordinales que cumpla a)
  - 4.B.2 [D] «Teorema de imposibilidad de Arrow (1951)» (3 ec., 0 gráf.; para: Mostrar que ninguna regla de votación agrega preferencias cumpliendo c)
- `funcion-bienestar-social` (ref. 3.A.24; desarrollo en 3.A.24).
  - 3.A.22 [m] «Función de bienestar social de Bergson-Samuelson y punto de felicidad» (1 ec., 1 gráf.; para: Seleccionar un óptimo de Pareto en la GFPU (incompletitud del criterio)
  - 3.A.24 [D] «Función de bienestar social de Bergson (1938)-Samuelson (1947)» (2 ec., 1 gráf.; para: Resolver la incompletitud de Pareto eligiendo un punto de la GFPU)
  - 4.B.2 [r] «Función de bienestar social de Bergson-Samuelson» (2 ec., 2 gráf.; para: Criterio adicional para elegir entre óptimos de Pareto)
- `paradoja-condorcet` (ref. 4.B.2; desarrollo en 3.A.24, 4.B.2).
  - 3.A.24 [D] «Paradoja de Condorcet y preferencias unimodales (Black)» (0 ec., 1 gráf.; para: Intransitividad de la mayoría y escapatoria levantando la universalida)
  - 4.B.2 [D] «Paradoja de Condorcet y manipulación de agenda» (1 ec., 2 gráf.; para: Intransitividad de la mayoría simple con preferencias multimodales)

**Bloques repetidos o copiados entre temas** (según las observaciones de los inventarios):

- 3.A.23: El reparto descrito es coherente salvo que, con el título vigente, la eficiencia del EGC (1TFEB) va en 3.A.22 y no hace falta repetirla en 3.A.23.
- 3.A.24: Anexo idéntico al de 3.A.23;
- 3.A.24: correcto en lo esencial, pero el 1TFEB ya no es solo «optimalidad global de Pareto» en 3.A.22 sino su epígrafe central, y 3.A.23 ya no debe repetirlo.

## pensamiento (3.A.1-3.A.7)

Temas: 3.A.1 (si), 3.A.2 (si), 3.A.3 (si), 3.A.4 (otro-titulo), 3.A.5 (otro-titulo), 3.A.6 (si), 3.A.7 (si)


### Modelos compartidos (10)

| id | nombre | ref. | temas que lo usan | ids fusionados |
|---|---|---|---|---|
| `marshall-equilibrio-parcial` | Marshall: equilibrio parcial y periodos de mercado | **3.A.3** | 3.A.3 D, 3.A.4 r, 3.A.16 r | marshall-equilibrio-temporal-normal |
| `malinvaud` | Teoría del desequilibrio (Barro-Grossman, Malinvaud) | **3.A.4** | 3.A.4 m, 3.A.5 r | desequilibrio |
| `is-lm` | Modelo IS-LM (Hicks 1937, Modigliani 1944) | **3.A.5** | 3.A.4 D, 3.A.5 m, 3.A.28 r, 3.A.37 r, 3.A.38 r, 3.A.39 r, 4.B.4 r | — |
| `patinkin` | Patinkin (1956): efecto saldos reales | **3.A.5** | 3.A.5 D, 3.A.21 r | — |
| `critica-lucas` | Crítica de Lucas (1976) | **3.A.6** | 3.A.1 m, 3.A.6 D | — |
| `egde` | Surgimiento de los modelos EGDE | **3.A.6** | 3.A.1 m, 3.A.6 r | — |
| `lucas-islas` | Modelo de información imperfecta de Lucas (1972), islas de Phelps | **3.A.6** | 3.A.6 D, 3.A.37 D, 3.A.41 D, 3.A.42 m | lucas-evidencia-1973 |
| `lucas-rapping` | Lucas y Rapping (1969): oferta de trabajo intertemporal | **3.A.6** | 3.A.6 r, 3.A.25 D, 3.A.42 m | — |
| `sargent-wallace-inefectividad` | Inefectividad de la política sistemática (Sargent y Wallace 1976) | **3.A.6** | 3.A.6 r, 3.A.37 r | — |
| `nek-3-ecuaciones` | Modelo canónico de 3 ecuaciones de la NEK (Clarida, Galí y Gertler) | **3.A.7** | 3.A.7 D, 3.A.36 D, 3.A.37 D, 3.A.38 D, 3.A.41 m, 3.A.42 D, 4.B.4 D | nek-canonico, nuevo-keynesiano |

`*` = tema sin fuente (el inventario recoge lo que debería tratar).

Modelos de otras áreas que se usan aquí: `aritmetica-monetarista` (ref. 3.A.39), `barro-gordon` (ref. 3.A.36), `chamberlin` (ref. 3.A.18), `cobb-douglas` (ref. 3.A.8), `contratos-implicitos` (ref. 3.A.27), `dmp` (ref. 3.A.26), `equilibrio-general-walras` (ref. 3.A.21), `equivalencia-ricardiana` (ref. 3.A.39), `fischer-taylor-contratos` (ref. 3.A.37), `histeresis` (ref. 3.A.28), `nairu-layard-nickell` (ref. 3.A.28), `olg-samuelson-diamond` (ref. 3.A.29), `phillips` (ref. 3.A.28), `prospect-theory` (ref. 3.A.10), `ramsey-cass-koopmans` (ref. 3.A.43), `rbc` (ref. 3.A.42), `rct` (ref. 4.B.6), `renta-permanente` (ref. 3.A.33), `ricardo` (ref. 3.B.5), `salarios-eficiencia` (ref. 3.A.27), `solow` (ref. 3.A.43), `stiglitz-weiss` (ref. 3.A.13), `taylor` (ref. 3.A.36), `teoria-cuantitativa` (ref. 3.A.35)


### Notación

**Un concepto, varios símbolos** (entre temas del área):

- factor/tasa de descuento: `β` (3.A.1, 3.A.6); `R_t` (3.A.6)
- inflación: `π` (3.A.3, 3.A.6); `π_t` (3.A.7)
- producción / renta agregada: `y_TNP` (3.A.6); `Y` (3.A.6); `x_t` (3.A.7)
- tipo de interés: `i` (3.A.3, 3.A.4); `r` (3.A.3, 3.A.4); `v` (3.A.4)

**Un símbolo, varios significados** (entre temas del área; se omiten los que solo cambian de redacción):

- `θ`: probabilidad de shock real (lucas) y, en (3.A.6); senal (3.A.6); aversión al riesgo / CRRA (3.A.6, 3.A.7); elasticidad de sustitución (3.A.7)
- `β`: factor/tasa de descuento (3.A.1); respuesta de la produccion (lucas), fact (3.A.6)
- `i`: tipo de interés (3.A.3, 3.A.4); tipo nominal (3.A.3)
- `r`: tipo de interés (3.A.3, 3.A.4); tipo real (3.A.3)

**Notación de los modelos compartidos que cambia de un tema a otro:**

- `barro-gordon` · paro: `U` (3.A.6); `U_t` (3.A.36)
- `equilibrio-general-walras` · bienes: `X, Y` (3.A.21, 3.A.22, 3.A.23); `X₁, X₂` (4.B.11)
- `equilibrio-general-walras` · factores: `K, L` (3.A.21); `L, K` (3.A.22, 3.A.23, 4.B.11)
- `equilibrio-general-walras` · renta: `W̄_h` (3.A.21); `W̄ = w_L·O₀ + M` (4.B.11)

**Incoherencias internas** (dentro de cada tema):

- 3.A.1: texto inacabado: '[seguir copiando de la página 11 ...]' en el epígrafe del empleo de las matemáticas
- 3.A.2: epígrafes 'Debates en torno a la ley de Say' y 'Economía monetaria' vacíos para Smith y Ricardo
- 3.A.3: el epígrafe I.1 dice 'Caracterización general de la Escuela Clásica' en un tema sobre neoclásicos (copiado de 3.A.2)
- 3.A.3: Edgeworth, Pareto y Pigou con epígrafes casi vacíos
- 3.A.4: el tipo de interés es r en la función de inversión e i en la demanda de dinero sin aclarar la relación
- 3.A.4: un mismo párrafo (Hicks/Chamberlin) aparece tres veces con remisión distinta (3.A.26 y 3.A.27)
- 3.A.5: epígrafe II.2 'Caracterización general de la escuela monetarista' repetido para los desequilibristas en el esquema inicial
- 3.A.6: Barro-Gordon: la condición de primer orden aparece con términos al cuadrado y la solución π=π*+(α/γ)(Ū−U*)^2; con la pérdida cuadrática la solución es lineal: π=π*+(α/γ)(U^n−U*)
- 3.A.6: RBC: las expresiones recuadradas W_t=A_t(K/L)^α y R_t=A_t(K/L)^{α−1} omiten (1−α) y α, que sí aparecen en la tabla de condiciones de equilibrio
- 3.A.6: PTF escrita A_t=A_0+e^{g t+Ã_t} (suma) y a la vez lnA_t=lnA_0+g t+Ã_t (producto); en McCallum ln(A_t)=ρ_A A_{t−1} mezcla niveles y logaritmos
- 3.A.6: θ y β cambian de significado entre el modelo de Lucas y el RBC
- 3.A.7: el epígrafe de la 2.ª generación se titula 'Caracterización general de la NEK de 1.ª generación'
- 3.A.7: la regla de Taylor del modelo canónico no lleva coeficiente en x_t, mientras que la versión original usa φ_y

### Modelos desarrollados en varios temas o contados de forma distinta

- `marshall-equilibrio-parcial` (ref. 3.A.3; desarrollo en 3.A.3).
  - 3.A.3 [D] «Marshall: equilibrio parcial y periodos de mercado» (0 ec., 0 gráf.; para: valor normal; demanda y oferta)
  - 3.A.4 [r] «Mercado de pescado de Marshall (equilibrio temporal y normal)» (0 ec., 0 gráf.; para: influencia en Keynes)
  - 3.A.16 [r] «Equilibrio temporal y normal de Marshall (mercado de pescado)» (0 ec., 1 gráf.; para: análisis de plazos y metáfora de las tijeras)
- `is-lm` (ref. 3.A.5; desarrollo en 3.A.4).
  - 3.A.4 [D] «IS-LM (Hicks 1937, Modigliani 1944)» (0 ec., 0 gráf.; para: síntesis neoclásica (pertenece a 3.A.5 con el título vigente))
  - 3.A.5 [m] «IS-LM» (0 ec., 0 gráf.; para: síntesis neoclásica: epígrafe vacío, se remite mentalmente a 3.A.4)
  - 3.A.28 [r] «IS-LM» (0 ec., 0 gráf.; para: )
  - 3.A.37 [r] «Modelo IS-LM» (2 ec., 1 gráf.; para: Transmisión keynesiana y de la síntesis.)
  - 3.A.38 [r] «IS-LM» (2 ec., 1 gráf.; para: Debate tradicional sobre la efectividad fiscal.)
  - 3.A.39 [r] «IS-LM y Blinder-Solow (1973)» (0 ec., 0 gráf.; para: Financiación del déficit por escuelas.)
  - 4.B.4 [r] «Modelo IS-LM y debate sobre la efectividad de la política fiscal (clás» (2 ec., 3 gráf.; para: Efectividad de la política fiscal según pendientes y financiación)
- `lucas-islas` (ref. 3.A.6; desarrollo en 3.A.6, 3.A.37, 3.A.41).
  - 3.A.6 [D] «Modelo de información imperfecta de Lucas (1972), islas de Phelps» (3 ec., 0 gráf.; para: curva de oferta de Lucas y neutralidad del dinero)
  - 3.A.37 [D] «Modelo de islas de Lucas (1972)» (2 ec., 0 gráf.; para: Neutralidad del dinero anticipado.)
  - 3.A.41 [D] «Islas de Lucas (1972)» (1 ec., 0 gráf.; para: )
  - 3.A.42 [m] «Ciclos nominales de Lucas (1972)» (0 ec., 0 gráf.; para: )
- `lucas-rapping` (ref. 3.A.6; desarrollo en 3.A.25).
  - 3.A.6 [r] «Lucas y Rapping (1969): oferta de trabajo intertemporal» (0 ec., 0 gráf.; para: microfundamentar el mercado de trabajo)
  - 3.A.25 [D] «Lucas y Rapping (1969)» (0 ec., 0 gráf.; para: Oferta intertemporal.)
  - 3.A.42 [m] «Oferta de trabajo intertemporal» (0 ec., 0 gráf.; para: )
- `nek-3-ecuaciones` (ref. 3.A.7; desarrollo en 3.A.7, 3.A.36, 3.A.37, 3.A.38, 3.A.42, 4.B.4).
  - 3.A.7 [D] «Modelo canónico de la NEK (IS dinámica, NKPC, regla de Taylor)» (3 ec., 0 gráf.; para: NEK de 2.ª generación)
  - 3.A.36 [D] «Modelo canónico de 3 ecuaciones de la NEK (Clarida, Galí y Gertler)» (2 ec., 0 gráf.; para: Política monetaria óptima.)
  - 3.A.37 [D] «Modelo neokeynesiano de 2.ª generación» (3 ec., 0 gráf.; para: Transmisión con rigideces nominales; divina coincidencia; ELB.)
  - 3.A.38 [D] «NEK con política fiscal» (1 ec., 0 gráf.; para: Efectos del gasto con rigideces.)
  - 3.A.41 [m] «Curva de Phillips NEK (forma adelantada)» (1 ec., 0 gráf.; para: )
  - 3.A.42 [D] «Modelo canónico NEK» (1 ec., 0 gráf.; para: Ciclos nominales.)
  - 4.B.4 [D] «Modelo neokeynesiano canónico con gasto público (Clarida-Galí-Gertler » (4 ec., 1 gráf.; para: Multiplicador del gasto con rigideces nominales y respuesta monetaria)
- `barro-gordon` (ref. 3.A.36; desarrollo en 3.A.6, 3.A.36, 3.A.41).
  - 3.A.6 [D] «Inconsistencia dinámica (Kydland-Prescott 1977, Barro-Gordon 1983)» (3 ec., 1 gráf.; para: reglas frente a discreción)
  - 3.A.36 [D] «Inconsistencia temporal (Kydland-Prescott 1977; Barro-Gordon 1983)» (2 ec., 1 gráf.; para: Reglas frente a discrecionalidad; sesgo inflacionista.)
  - 3.A.41 [D] «Kydland-Prescott / Barro-Gordon» (1 ec., 0 gráf.; para: )
  - 3.B.17 [m] «Inconsistencia dinámica (Kydland-Prescott, Barro-Gordon)» (0 ec., 0 gráf.; para: base de la segunda generación)
- `contratos-implicitos` (ref. 3.A.27; desarrollo en 3.A.7, 3.A.27).
  - 3.A.7 [D] «Contratos implícitos (Azariadis, Baily, Gordon)» (0 ec., 0 gráf.; para: rigidez salarial)
  - 3.A.27 [D] «Contratos implícitos (Azariadis, Baily, Gordon)» (0 ec., 0 gráf.; para: )
- `equilibrio-general-walras` (ref. 3.A.21; desarrollo en 3.A.3, 3.A.21, 3.A.22, 3.A.23). **Posible copia literal** (mismo nombre y mismas ecuaciones): 3.A.22, 3.A.23.
  - 3.A.3 [D] «Walras: principio equimarginal y equilibrio general» (0 ec., 0 gráf.; para: interdependencia de mercados)
  - 3.A.21 [D] «Equilibrio general competitivo walrasiano 2×2×2×2» (5 ec., 3 gráf.; para: Construcción, existencia, unicidad, estabilidad y optimalidad del EGC)
  - 3.A.22 [D] «Modelo de equilibrio general 2×2×2×2 (2 bienes, 2 empresas, 2 factores» (6 ec., 4 gráf.; para: Condiciones de óptimo de Pareto (producción, intercambio, global) y ob)
  - 3.A.23 [D] «Modelo de equilibrio general 2×2×2×2 (2 bienes, 2 empresas, 2 factores» (6 ec., 4 gráf.; para: Demostrar el 1TFEB (contenido que con el título vigente pertenece a 3.)
  - 4.B.11 [r] «Modelo de equilibrio general 1×2×2×2 (1 consumidor con ocio, 2 bienes,» (5 ec., 0 gráf.; para: Mostrar que sin impuestos se cumple el 1TFEB y que los impuestos disto)
- `equivalencia-ricardiana` (ref. 3.A.39; desarrollo en 3.A.6, 3.A.38, 3.A.39).
  - 3.A.6 [D] «Equivalencia ricardiana (Barro 1974)» (0 ec., 0 gráf.; para: efectos de la deuda pública)
  - 3.A.38 [D] «Equivalencia ricardiana» (0 ec., 0 gráf.; para: )
  - 3.A.39 [D] «Equivalencia ricardiana (Barro 1974)» (0 ec., 0 gráf.; para: )
  - 4.B.4 [r] «Equivalencia ricardiana (Ricardo, Barro 1974, Buchanan 1976)» (0 ec., 0 gráf.; para: Neutralidad de la financiación del gasto; razones del incumplimiento)
  - 4.B.10 [m] «Equivalencia ricardiana (Barro)» (0 ec., 0 gráf.; para: Anexo: impuestos percibidos como temporales o permanentes)
  - 4.B.11 [m] «Equivalencia ricardiana» (0 ec., 0 gráf.; para: Punto de partida de la suavización impositiva)
- `nairu-layard-nickell` (ref. 3.A.28; desarrollo en 3.A.7, 3.A.28).
  - 3.A.7 [D] «Modelo de NAIRU (Layard-Nickell)» (2 ec., 0 gráf.; para: modelo agregado de la NEK 1.ª generación)
  - 3.A.28 [D] «NAIRU (fijación de salarios y precios)» (0 ec., 1 gráf.; para: )
- `phillips` (ref. 3.A.28; desarrollo en 3.A.4, 3.A.28).
  - 3.A.4 [D] «Curva de Phillips (Phillips 1958, Lipsey 1960, Samuelson-Solow 1960)» (3 ec., 0 gráf.; para: síntesis neoclásica)
  - 3.A.5 [m] «Curva de Phillips aumentada con expectativas (Friedman-Phelps) y tasa » (0 ec., 0 gráf.; para: crítica por el lado de la oferta (epígrafe vacío))
  - 3.A.28 [D] «Curva de Phillips original, Lipsey, Samuelson-Solow, ampliada (Phelps-» (0 ec., 1 gráf.; para: Tasa natural de paro.)
  - 3.A.37 [r] «Curva de Phillips y ampliada con expectativas» (0 ec., 0 gráf.; para: )
  - 3.A.41 [r] «Curva de Phillips ampliada» (1 ec., 0 gráf.; para: )
- `rbc` (ref. 3.A.42; desarrollo en 3.A.6, 3.A.42).
  - 3.A.6 [D] «Ciclo real: modelo general y McCallum (1989)» (5 ec., 2 gráf.; para: consolidación: EGDE)
  - 3.A.42 [D] «Modelo RBC (McCallum, 1989)» (2 ec., 1 gráf.; para: Ciclos reales.)
  - 4.A.29 [m] «Teoría del ciclo real» (0 ec., 0 gráf.; para: Nota: no todas las fluctuaciones deben eliminarse)
- `ricardo` (ref. 3.B.5; desarrollo en 3.A.2, 3.B.5).
  - 3.A.2 [D] «Ventaja comparativa de Ricardo (ejemplo paño-vino)» (2 ec., 0 gráf.; para: comercio internacional en Ricardo)
  - 3.B.5 [D] «Ventaja absoluta (Smith) y comparativa (Ricardo-Torrens)» (2 ec., 3 gráf.; para: ¿por qué comercian los países? diferencias tecnológicas)
  - 3.B.34 [m] «Ventaja comparativa» (0 ec., 0 gráf.; para: motivación de la liberalización)
  - 3.B.39 [m] «Ventaja comparativa (Haberler)» (0 ec., 0 gráf.; para: motivación teórica)
  - 3.B.41 [m] «Ventaja comparativa» (0 ec., 0 gráf.; para: justificación)
- `salarios-eficiencia` (ref. 3.A.27; desarrollo en 3.A.7, 3.A.27).
  - 3.A.7 [D] «Salarios de eficiencia: Solow (1979) y Shapiro-Stiglitz (1984)» (1 ec., 0 gráf.; para: rigidez del salario real)
  - 3.A.13 [m] «Salarios de eficiencia» (0 ec., 0 gráf.; para: aplicación macro del riesgo moral)
  - 3.A.27 [D] «Salarios de eficiencia con información perfecta (Solow 1979)» (0 ec., 0 gráf.; para: )
- `taylor` (ref. 3.A.36; desarrollo en 3.A.7, 3.A.36).
  - 3.A.7 [D] «Regla de Taylor» (1 ec., 0 gráf.; para: cierre del modelo)
  - 3.A.36 [D] «Regla de Taylor» (1 ec., 0 gráf.; para: Regla de política monetaria.)
  - 4.B.4 [m] «Regla de Taylor y principio de Taylor» (1 ec., 0 gráf.; para: Cierre del modelo NEK)

**Bloques repetidos o copiados entre temas** (según las observaciones de los inventarios):

- 3.A.4: el mismo párrafo repetido más abajo ya remite a 3.A.27
- 3.A.6: juegos repetidos son teoría de juegos (3.A.14);

## macro-cerrada (3.A.25-3.A.45 (salvo 3.A.32))

Temas: 3.A.25 (si), 3.A.26 (si), 3.A.27 (si), 3.A.28 (si), 3.A.29 (si), 3.A.30 (si), 3.A.31 (no), 3.A.33 (si), 3.A.34 (si), 3.A.35 (si), 3.A.36 (si), 3.A.37 (si), 3.A.38 (si), 3.A.39 (si), 3.A.40 (no), 3.A.41 (si), 3.A.42 (si), 3.A.43 (si), 3.A.44 (si), 3.A.45 (si)


### Modelos compartidos (40)

| id | nombre | ref. | temas que lo usan | ids fusionados |
|---|---|---|---|---|
| `oferta-trabajo` | Oferta de trabajo neoclásica (elección consumo-ocio) | **3.A.25** | 3.A.25 D, 4.B.10 D | oferta-trabajo-neoclasica, oferta-trabajo-ocio |
| `dmp` | Modelo de Diamond, Mortensen y Pissarides | **3.A.26** | 3.A.7 m, 3.A.26 D, 3.A.28 r | — |
| `contratos-implicitos` | Contratos implícitos (Azariadis, Baily, Gordon) | **3.A.27** | 3.A.7 D, 3.A.27 D | — |
| `salarios-eficiencia` | Salarios de eficiencia con información perfecta (Solow 1979) | **3.A.27** | 3.A.7 D, 3.A.13 m, 3.A.27 D | shapiro-stiglitz, solow-1979 |
| `histeresis` | Histéresis (Blanchard y Summers 1987) | **3.A.28** | 3.A.7 r, 3.A.28 D, 4.A.16 m | — |
| `nairu-layard-nickell` | NAIRU (fijación de salarios y precios) | **3.A.28** | 3.A.7 D, 3.A.28 D | nairu |
| `phillips` | Curva de Phillips original, Lipsey, Samuelson-Solow, ampliada (Phelps-Friedman) | **3.A.28** | 3.A.4 D, 3.A.5 m, 3.A.28 D, 3.A.37 r, 3.A.41 r | phillips-aceleracionista |
| `olg-samuelson-diamond` | Generaciones solapadas (Samuelson 1958, Diamond 1965) | **3.A.29** | 3.A.6 m, 3.A.29 D, 3.A.35 r, 3.A.38 D, 4.B.3 D | generaciones-solapadas, olg |
| `input-output` | Marco input-output (tablas de origen y destino) | **3.A.30** | 3.A.30 r, 4.A.1 r | tablas-input-output |
| `fisher-intertemporal` | Elección intertemporal de Fisher (dos periodos) | **3.A.33** | 3.A.29 D, 3.A.33 D, 4.B.9 D, 4.B.10 D | ahorro-intertemporal-fisher, ciclo-vital-dos-periodos, impuestos-ahorro-dos-periodos |
| `hall` | Paseo aleatorio (Hall 1978) | **3.A.33** | 3.A.10 m, 3.A.33 D | hall-paseo-aleatorio |
| `renta-permanente` | Renta permanente (Friedman 1957) | **3.A.33** | 3.A.5 m, 3.A.33 D | — |
| `jorgenson` | Modelo neoclásico (Jorgenson, 1963) | **3.A.34** | 3.A.34 D, 4.B.10 D | coste-uso-capital-hall-jorgenson |
| `opciones-reales` | Inversión bajo incertidumbre e irreversibilidad | **3.A.34** | 3.A.34 D, 3.B.2 r | opcion-real |
| `q-tobin` | q de Tobin con costes de ajuste (Summers, Abel, Hayashi) | **3.A.34** | 3.A.29 r, 3.A.34 D, 3.A.37 r | — |
| `baumol-tobin` | Modelo de inventarios (Baumol 1952, Tobin 1956) y Miller-Orr | **3.A.35** | 3.A.35 D, 3.B.2 D | — |
| `teoria-cuantitativa` | Teoría cuantitativa (Fisher; Cambridge) | **3.A.35** | 3.A.2 m, 3.A.5 m, 3.A.35 D, 3.A.37 r, 3.A.41 r | — |
| `barro-gordon` | Inconsistencia temporal (Kydland-Prescott 1977; Barro-Gordon 1983) | **3.A.36** | 3.A.6 D, 3.A.36 D, 3.A.41 D, 3.B.17 m | — |
| `taylor` | Regla de Taylor | **3.A.36** | 3.A.7 D, 3.A.36 D, 4.B.4 m | — |
| `fischer-taylor-contratos` | Contratos escalonados (Fischer 1977, Taylor 1980) | **3.A.37** | 3.A.7 r, 3.A.37 D | taylor-fischer-contratos |
| `barro-1990` | Política fiscal y crecimiento endógeno (Barro, 1990) | **3.A.38** | 3.A.38 D, 3.A.44 D, 4.A.11 m, 4.B.1 D, 4.B.5 D | barro-1990-gasto-productivo, barro-gasto-publico |
| `aritmetica-monetarista` | Aritmética monetarista desagradable | **3.A.39** | 3.A.6 r, 3.A.39 D, 3.A.41 r | sargent-wallace |
| `equivalencia-ricardiana` | Equivalencia ricardiana (Barro 1974) | **3.A.39** | 3.A.6 D, 3.A.38 D, 3.A.39 D, 4.B.4 r, 4.B.10 m, 4.B.11 m | — |
| `ftpl` | Teoría fiscal del nivel de precios | **3.A.39** | 3.A.39 D, 3.A.41 r | — |
| `restriccion-gobierno` | Restricción presupuestaria del sector público y dinámica de la deuda | **3.A.39** | 3.A.39 D, 4.B.26 D | dinamica-deuda, restriccion-presupuestaria-gobierno, sostenibilidad-deuda |
| `suavizacion-impositiva-barro` | Suavización impositiva (Barro 1979) | **3.A.39** | 3.A.39 D, 4.B.9 r, 4.B.11 D | barro-suavizacion-impositiva, tax-smoothing |
| `estancamiento-secular` | Estancamiento secular (Hansen, Summers, Rachel-Summers 2019; debate Blanchard-Summers) | **3.A.40** | 3.A.40 p*, 4.A.11 m, 4.B.1 r, 4.B.4 r, 4.B.5 r | — |
| `cagan` | Modelo de Cagan (1956) | **3.A.41** | 3.A.35 D, 3.A.39 D, 3.A.41 D | — |
| `regla-friedman` | Regla de Friedman e inflación óptima | **3.A.41** | 3.A.41 D, 4.B.11 r | — |
| `rbc` | Modelo RBC (McCallum, 1989) | **3.A.42** | 3.A.6 D, 3.A.42 D, 4.A.29 m | ciclo-real, rbc-mccallum |
| `ramsey-cass-koopmans` | Modelo de Ramsey-Cass-Koopmans | **3.A.43** | 3.A.6 m, 3.A.29 r, 3.A.42 r, 3.A.43 D | ramsey |
| `solow` | Modelo de Solow-Swan (1956) | **3.A.43** | 3.A.6 m, 3.A.43 D, 3.B.42 m, 4.A.2 p | — |
| `solow-mrw` | Solow aumentado con capital humano (Mankiw, Romer y Weil, 1992) | **3.A.43** | 3.A.43 m, 3.A.45 D | — |
| `trampas-pobreza` | Trampas de pobreza en Solow | **3.A.43** | 3.A.43 r, 3.B.42 m | — |
| `aghion-howitt` | Modelo schumpeteriano de calidad (Aghion y Howitt) | **3.A.44** | 3.A.44 D, 3.B.42 m | — |
| `romer-1990` | Aumento del número de inputs (Romer 1990 / Grossman-Helpman 1991) | **3.A.44** | 3.A.44 D, 3.B.9 r, 3.B.34 m, 3.B.39 m, 3.B.42 m, 4.A.7 p | crecimiento-endogeno-romer, romer |
| `uzawa-lucas` | Modelo de Uzawa (1965) y Lucas (1988) de capital humano | **3.A.44** | 3.A.44 D, 3.B.9 D, 4.A.2 p, 4.A.29 m | crecimiento-endogeno-lucas, lucas-spillovers |
| `ajr-instituciones` | Colonial Origins (Acemoglu, Johnson y Robinson, 2001) | **3.A.45** | 3.A.45 D, 3.B.28 D | — |
| `contabilidad-crecimiento` | Contabilidad del crecimiento (Solow, 1957) y enfoque dual (Hsieh, 2002) | **3.A.45** | 3.A.45 D, 4.A.27 m | — |
| `convergencia-beta-sigma` | Convergencia β y σ (Barro y Sala-i-Martín) | **3.A.45** | 3.A.45 D, 3.B.40 D, 4.A.17 D | — |

`*` = tema sin fuente (el inventario recoge lo que debería tratar).

Modelos de otras áreas que se usan aquí: `ces` (ref. 3.A.11), `corsetti-pesenti` (ref. 3.B.19), `is-lm` (ref. 3.A.5), `lucas-islas` (ref. 3.A.6), `lucas-rapping` (ref. 3.A.6), `multiplicadores-fiscales` (ref. 4.B.4), `mundell-fleming` (ref. 3.B.15), `nek-3-ecuaciones` (ref. 3.A.7), `rbc-sims` (ref. 4.B.4), `sargent-wallace-inefectividad` (ref. 3.A.6), `tobin-cartera` (ref. 3.B.23)


### Notación

**Un concepto, varios símbolos** (entre temas del área):

- aversión al riesgo / CRRA: `θ` (3.A.29, 3.A.36, 3.A.38, 3.A.43); `σ` (3.A.42)
- consumo: `c_t` (3.A.29); `C_t / c_t` (3.A.33); `C_t^J, C_{t+1}^V` (3.A.38)
- depreciación: `δ` (3.A.26, 3.A.36, 3.A.43); `δ^K, δ^H` (3.A.44)
- factor/tasa de descuento: `ρ` (3.A.29, 3.A.33, 3.A.38, 3.A.43); `β` (3.A.38, 3.A.42); `1/(1+ρ)` (3.A.38); `θ, ρ` (3.A.44)
- salario: `w` (3.A.25); `w_t` (3.A.29); `W_t` (3.A.43)
- tipo impositivo: `Τ_t` (3.A.39); `T_t / τ_t` (3.A.39); `τ` (3.A.44)

**Un símbolo, varios significados** (entre temas del área; se omiten los que solo cambian de redacción):

- `δ`: tasa de separacion (choca con δ = deprec (3.A.26); separacion (3.A.26); pendiente de la curva de phillips nek (c (3.A.36); pendiente cpnk (3.A.36); depreciación (3.A.43)
- `σ`: elasticidad de sustitución (3.A.29); esi (3.A.29); varianza / riesgo (3.A.35); sustituye a 1/θ en una version alternati (3.A.37); aversión al riesgo / CRRA (3.A.42)
- `θ`: tension v/u (3.A.26); aversión al riesgo / CRRA (3.A.29, 3.A.36, 3.A.38, 3.A.43); 1/esi en la is dinamica y tambien coefic (3.A.37); extraccion de senal (3.A.37)
- `M`: renta (del consumidor) (3.A.25); numero de variedades (3.A.44)
- `τ`: cotizacion (3.A.38); tipo impositivo (3.A.44)

**Notación de los modelos compartidos que cambia de un tema a otro:**

- `fisher-intertemporal` · consumo: `c_t` (3.A.29); `C₁, C₂` (4.B.10)
- `fisher-intertemporal` · tipo de interes: `r_t` (3.A.29); `r` (4.B.9, 4.B.10)
- `barro-gordon` · paro: `U` (3.A.6); `U_t` (3.A.36)
- `restriccion-gobierno` · deuda: `D_t (d_t en % PIB)` (3.A.39); `D (d)` (4.B.26)
- `restriccion-gobierno` · impuestos: `T_t / τ_t` (3.A.39); `T (\tau)` (4.B.26)
- `suavizacion-impositiva-barro` · recaudacion: `τ_t (aquí τ es recaudación, no tipo)` (4.B.9); `τ_t (aquí es recaudación, no tipo)` (4.B.11)
- `ces` · pesos: `a_i` (3.A.8); `s_i (en 3.A.8 revisado: a_i)` (3.A.11)
- `rbc-sims` · descuento: `1/(1+ρ)` (3.A.38); `ρ` (4.B.4)

**Incoherencias internas** (dentro de cada tema):

- 3.A.25: Numeración repetida «2.2.1. Supuestos» y «2.2.1. Desarrollo».
- 3.A.25: Cuatro de seis referencias apuntan a temas que no corresponden (posible numeración antigua).
- 3.A.29: Hay un anexo de optimización dinámica que el autor quiere unificar con 3.A.33, 3.A.34 y 3.A.43 («Importante que si se cambia en alguno de los temas se cambie en todos»).
- 3.A.30: Numeración duplicada: «2.1. Cuenta de bienes y servicios (C.0)» y «2.1. Cuentas corrientes».
- 3.A.30: Nota del autor: el apartado de principios contables está «un poco caótico» y parte está copiado de 3.B.11 sin comprobar si el SEC 2010 coincide.
- 3.A.33: Consumo en mayúscula (Hall) y minúscula (Euler) en el mismo tema.
- 3.A.34: v significa sensibilidad al tipo (I = I_0 - v·r) y relación capital-producto (acelerador).
- 3.A.34: Epígrafe «3.2.» sin título.
- 3.A.34: Leontief: L_t/z aquí y L_t/u en 3.A.43.
- 3.A.35: La inflación se denota π en la demanda de Cagan y ϑ en el señoreaje.
- 3.A.35: Restricción del gobierno con i_t·D_{t-1} (3.A.39 usa i_{t-1}·D_{t-1}).
- 3.A.36: Regla de Taylor i_t = ρ + φ_π(π-π*) + φ_y ŷ aquí, frente a i_t = ν·i_{t-1} + ϕ·π_t + x_t + ε_t en 3.A.37, 3.A.38 y 3.A.42 (sin coeficiente en x_t).
- 3.A.36: Derivación de Barro-Gordon con errores algebraicos (aparecen términos al cuadrado en la condición de primer orden: «α²(π-π^e)² + γ(π-π*) = α(U-U*)²»); el mismo error está en 3.A.41.
- 3.A.37: La IS dinámica aparece con -(1/θ) y con -σ en el mismo tema.
- 3.A.37: θ significa a la vez 1/ESI (IS) y coeficiente de extracción de señal (Lucas).
- 3.A.37: Regla de Taylor sin coeficiente en x_t.
- 3.A.38: El factor de descuento es 1/(1+ρ) en el RBC y β en el OLG del mismo tema.
- 3.A.38: El autor indica que la equivalencia ricardiana «es más del tema 3.A.39 que del 3.A.38».
- 3.A.39: Intereses i_{t-1}·D_{t-1} en la restricción principal e i_t·D_{t-1} en la sección de señoreaje.
- 3.A.39: Impuestos con «Τ» griega en unas ecuaciones y «T» latina en otras.
- 3.A.41: Numeración desordenada al final: «3.4. Inflación y estabilización», «3.5. Introducción», «3.6 … 3.8. Inflación óptima» (duplica 3.2 «¿Existe una tasa óptima?»).
- 3.A.41: Misma derivación errónea de Barro-Gordon que en 3.A.36 (términos al cuadrado en la condición de primer orden).
- 3.A.41: Restricción del gobierno con i_t·D_{t-1}.
- 3.A.43: Tasa de progreso técnico: g en el cuerpo (δ+n+g) y m en el anexo (m+n).
- 3.A.43: Hay una referencia «[ver temas 3.A.10 y 3.A.11]» y su gemela «[ver temas 3.A.11 y 3.A.12]» para la misma frase.
- 3.A.43: La nota inicial dice que Harrod-Domar debería sustituirse por MRW, pero sigue como apartado 1 y MRW tiene una línea.
- 3.A.44: η se usa con dos significados: externalidad del capital (Lucas) y participación del capital en la producción de capital humano (Ḣ = B·K^η·H^{1-η}).
- 3.A.44: Barro (1990) se presenta con ahorro exógeno s (Solow) mientras AK y Uzawa-Lucas usan optimización (θ, ρ).
- 3.A.45: Las participaciones se escriben α y (1-α) en unas ecuaciones y α_K, α_L en otras.

### Modelos desarrollados en varios temas o contados de forma distinta

- `oferta-trabajo` (ref. 3.A.25; desarrollo en 3.A.25, 4.B.10).
  - 3.A.25 [D] «Elección ocio-consumo» (1 ec., 1 gráf.; para: Oferta de trabajo individual y agregada.)
  - 4.B.10 [D] «Modelo neoclásico de elección consumo-ocio con impuestos» (5 ec., 4 gráf.; para: Efecto de distintos impuestos (suma fija, proporcional sobre salario, )
- `dmp` (ref. 3.A.26; desarrollo en 3.A.26).
  - 3.A.7 [m] «Diamond-Mortensen-Pissarides» (0 ec., 0 gráf.; para: fricciones en el mercado de trabajo en la NEK)
  - 3.A.26 [D] «Modelo de Diamond, Mortensen y Pissarides» (4 ec., 2 gráf.; para: Paro friccional de equilibrio; curva de Beveridge.)
  - 3.A.28 [r] «Búsqueda y emparejamiento» (0 ec., 0 gráf.; para: )
- `contratos-implicitos` (ref. 3.A.27; desarrollo en 3.A.7, 3.A.27).
  - 3.A.7 [D] «Contratos implícitos (Azariadis, Baily, Gordon)» (0 ec., 0 gráf.; para: rigidez salarial)
  - 3.A.27 [D] «Contratos implícitos (Azariadis, Baily, Gordon)» (0 ec., 0 gráf.; para: )
- `salarios-eficiencia` (ref. 3.A.27; desarrollo en 3.A.7, 3.A.27).
  - 3.A.7 [D] «Salarios de eficiencia: Solow (1979) y Shapiro-Stiglitz (1984)» (1 ec., 0 gráf.; para: rigidez del salario real)
  - 3.A.13 [m] «Salarios de eficiencia» (0 ec., 0 gráf.; para: aplicación macro del riesgo moral)
  - 3.A.27 [D] «Salarios de eficiencia con información perfecta (Solow 1979)» (0 ec., 0 gráf.; para: )
- `histeresis` (ref. 3.A.28; desarrollo en 3.A.28).
  - 3.A.7 [r] «Histéresis (Blanchard-Summers 1987)» (0 ec., 0 gráf.; para: persistencia)
  - 3.A.28 [D] «Histéresis (Blanchard y Summers 1987)» (0 ec., 0 gráf.; para: Persistencia del desempleo.)
  - 4.A.16 [m] «Histéresis por desempleo de larga duración (Dolado)» (0 ec., 0 gráf.; para: Causa del desplazamiento de la curva de Beveridge)
- `nairu-layard-nickell` (ref. 3.A.28; desarrollo en 3.A.7, 3.A.28).
  - 3.A.7 [D] «Modelo de NAIRU (Layard-Nickell)» (2 ec., 0 gráf.; para: modelo agregado de la NEK 1.ª generación)
  - 3.A.28 [D] «NAIRU (fijación de salarios y precios)» (0 ec., 1 gráf.; para: )
- `phillips` (ref. 3.A.28; desarrollo en 3.A.4, 3.A.28).
  - 3.A.4 [D] «Curva de Phillips (Phillips 1958, Lipsey 1960, Samuelson-Solow 1960)» (3 ec., 0 gráf.; para: síntesis neoclásica)
  - 3.A.5 [m] «Curva de Phillips aumentada con expectativas (Friedman-Phelps) y tasa » (0 ec., 0 gráf.; para: crítica por el lado de la oferta (epígrafe vacío))
  - 3.A.28 [D] «Curva de Phillips original, Lipsey, Samuelson-Solow, ampliada (Phelps-» (0 ec., 1 gráf.; para: Tasa natural de paro.)
  - 3.A.37 [r] «Curva de Phillips y ampliada con expectativas» (0 ec., 0 gráf.; para: )
  - 3.A.41 [r] «Curva de Phillips ampliada» (1 ec., 0 gráf.; para: )
- `olg-samuelson-diamond` (ref. 3.A.29; desarrollo en 3.A.29, 3.A.38, 4.B.3).
  - 3.A.6 [m] «Generaciones solapadas» (0 ec., 0 gráf.; para: extensión)
  - 3.A.29 [D] «Modelo de generaciones solapadas» (1 ec., 0 gráf.; para: Contraste con horizonte infinito; ineficiencia dinámica.)
  - 3.A.35 [r] «Generaciones solapadas (Samuelson 1958)» (0 ec., 0 gráf.; para: Valor del dinero fiduciario.)
  - 3.A.38 [D] «Generaciones solapadas y pensiones (capitalización frente a reparto)» (2 ec., 0 gráf.; para: Efectos sobre el ahorro.)
  - 4.B.3 [D] «Generaciones solapadas con pensiones de capitalización y de reparto (S» (4 ec., 1 gráf.; para: Efecto de la Seguridad Social sobre el ahorro privado y comparación re)
- `fisher-intertemporal` (ref. 3.A.33; desarrollo en 3.A.29, 3.A.33, 4.B.9, 4.B.10).
  - 3.A.29 [D] «Elección intertemporal de consumo (Fisher, dos periodos)» (2 ec., 1 gráf.; para: Decisión consumo/ahorro como piedra angular del análisis dinámico.)
  - 3.A.33 [D] «Microfundamentación de Fisher (1930)» (1 ec., 0 gráf.; para: )
  - 4.B.9 [D] «Impuestos y ahorro en un modelo de dos periodos (Fisher)» (3 ec., 1 gráf.; para: Efectos de impuestos de suma fija, salariales, sobre el consumo y sobr)
  - 4.B.10 [D] «Modelo de ciclo vital de 2 periodos (Fisher) con impuestos» (2 ec., 2 gráf.; para: Efectos de impuestos de suma fija, sobre salarios, sobre el consumo y )
- `jorgenson` (ref. 3.A.34; desarrollo en 3.A.34, 4.B.10).
  - 3.A.34 [D] «Modelo neoclásico (Jorgenson, 1963)» (1 ec., 0 gráf.; para: Coste de uso del capital.)
  - 4.B.10 [D] «Coste de uso del capital con impuesto de sociedades» (4 ec., 0 gráf.; para: Efecto del IS sobre la inversión según la deducibilidad de los costes )
- `q-tobin` (ref. 3.A.34; desarrollo en 3.A.34).
  - 3.A.29 [r] «Costes de ajuste (q de Tobin), precio sombra» (0 ec., 0 gráf.; para: Ilustrar decisiones intertemporales de empresas; el autor reconoce que)
  - 3.A.34 [D] «q de Tobin con costes de ajuste (Summers, Abel, Hayashi)» (2 ec., 1 gráf.; para: )
  - 3.A.37 [r] «q de Tobin como canal» (0 ec., 0 gráf.; para: )
- `baumol-tobin` (ref. 3.A.35; desarrollo en 3.A.35, 3.B.2).
  - 3.A.35 [D] «Modelo de inventarios (Baumol 1952, Tobin 1956) y Miller-Orr» (0 ec., 0 gráf.; para: Motivo transacción.)
  - 3.B.2 [D] «Modelo de inventario de tesorería (Baumol, 1952; Tobin)» (2 ec., 1 gráf.; para: inversión óptima en tesorería)
- `teoria-cuantitativa` (ref. 3.A.35; desarrollo en 3.A.35).
  - 3.A.2 [m] «Teoría cuantitativa, currency vs banking school» (0 ec., 0 gráf.; para: economía monetaria clásica)
  - 3.A.5 [m] «Neocuantitativismo de Friedman» (0 ec., 0 gráf.; para: demanda de dinero (epígrafe vacío))
  - 3.A.35 [D] «Teoría cuantitativa (Fisher; Cambridge)» (2 ec., 0 gráf.; para: Primera explicación de la demanda de dinero.)
  - 3.A.37 [r] «Teoría cuantitativa del dinero» (0 ec., 0 gráf.; para: Transmisión clásica.)
  - 3.A.41 [r] «Modelo clásico (teoría cuantitativa)» (0 ec., 0 gráf.; para: )
- `barro-gordon` (ref. 3.A.36; desarrollo en 3.A.6, 3.A.36, 3.A.41).
  - 3.A.6 [D] «Inconsistencia dinámica (Kydland-Prescott 1977, Barro-Gordon 1983)» (3 ec., 1 gráf.; para: reglas frente a discreción)
  - 3.A.36 [D] «Inconsistencia temporal (Kydland-Prescott 1977; Barro-Gordon 1983)» (2 ec., 1 gráf.; para: Reglas frente a discrecionalidad; sesgo inflacionista.)
  - 3.A.41 [D] «Kydland-Prescott / Barro-Gordon» (1 ec., 0 gráf.; para: )
  - 3.B.17 [m] «Inconsistencia dinámica (Kydland-Prescott, Barro-Gordon)» (0 ec., 0 gráf.; para: base de la segunda generación)
- `taylor` (ref. 3.A.36; desarrollo en 3.A.7, 3.A.36).
  - 3.A.7 [D] «Regla de Taylor» (1 ec., 0 gráf.; para: cierre del modelo)
  - 3.A.36 [D] «Regla de Taylor» (1 ec., 0 gráf.; para: Regla de política monetaria.)
  - 4.B.4 [m] «Regla de Taylor y principio de Taylor» (1 ec., 0 gráf.; para: Cierre del modelo NEK)
- `barro-1990` (ref. 3.A.38; desarrollo en 3.A.38, 3.A.44, 4.B.1, 4.B.5). **Posible copia literal** (mismo nombre y mismas ecuaciones): 4.B.1, 4.B.5.
  - 3.A.38 [D] «Política fiscal y crecimiento endógeno (Barro, 1990)» (0 ec., 0 gráf.; para: )
  - 3.A.44 [D] «Modelo AK con gasto público productivo (Barro, 1990)» (4 ec., 1 gráf.; para: Impuestos y gasto productivo en el crecimiento a largo plazo.)
  - 4.A.11 [m] «Modelo de crecimiento de Barro con gasto público productivo» (0 ec., 0 gráf.; para: Justificar el efecto de oferta de la obra civil sobre el crecimiento p)
  - 4.B.1 [D] «Modelo AK con gasto público productivo (Barro, 1990)» (5 ec., 1 gráf.; para: Tamaño óptimo del gasto público que maximiza el crecimiento)
  - 4.B.5 [D] «Modelo AK con gasto público productivo (Barro, 1990)» (5 ec., 1 gráf.; para: Tamaño óptimo del sector público desde el crecimiento: tipo impositivo)
- `equivalencia-ricardiana` (ref. 3.A.39; desarrollo en 3.A.6, 3.A.38, 3.A.39).
  - 3.A.6 [D] «Equivalencia ricardiana (Barro 1974)» (0 ec., 0 gráf.; para: efectos de la deuda pública)
  - 3.A.38 [D] «Equivalencia ricardiana» (0 ec., 0 gráf.; para: )
  - 3.A.39 [D] «Equivalencia ricardiana (Barro 1974)» (0 ec., 0 gráf.; para: )
  - 4.B.4 [r] «Equivalencia ricardiana (Ricardo, Barro 1974, Buchanan 1976)» (0 ec., 0 gráf.; para: Neutralidad de la financiación del gasto; razones del incumplimiento)
  - 4.B.10 [m] «Equivalencia ricardiana (Barro)» (0 ec., 0 gráf.; para: Anexo: impuestos percibidos como temporales o permanentes)
  - 4.B.11 [m] «Equivalencia ricardiana» (0 ec., 0 gráf.; para: Punto de partida de la suavización impositiva)
- `restriccion-gobierno` (ref. 3.A.39; desarrollo en 3.A.39, 4.B.26).
  - 3.A.39 [D] «Restricción presupuestaria del sector público y dinámica de la deuda» (2 ec., 1 gráf.; para: Sostenibilidad de la deuda.)
  - 4.B.26 [D] «Restricción presupuestaria consolidada del sector público (Walsh, cap.» (5 ec., 0 gráf.; para: Fuentes de financiación del gasto: impuestos, deuda y señoreaje; víncu)
- `suavizacion-impositiva-barro` (ref. 3.A.39; desarrollo en 3.A.39, 4.B.11).
  - 3.A.39 [D] «Suavización impositiva (Barro 1979)» (0 ec., 0 gráf.; para: )
  - 4.B.9 [r] «Suavización impositiva de Barro (1979)» (2 ec., 0 gráf.; para: Tipo constante minimiza el valor presente de las distorsiones)
  - 4.B.11 [D] «Suavización impositiva (Barro 1979)» (2 ec., 0 gráf.; para: Distribución temporal óptima de los impuestos y papel de la deuda)
- `estancamiento-secular` (ref. 3.A.40; desarrollo en ninguno).
  - 4.A.11 [m] «Caída del tipo de interés real natural (Rachel y Summers 2019)» (0 ec., 0 gráf.; para: Factor de demanda en la subida de precios de vivienda pre-pandemia)
  - 4.B.1 [r] «Estancamiento secular (Hansen, Summers, Rachel-Summers 2019; debate Bl» (1 ec., 1 gráf.; para: Comodín: papel de la política fiscal con tipo de interés neutral negat)
  - 4.B.4 [r] «Estancamiento secular (Summers, Blanchard, Cochrane)» (0 ec., 0 gráf.; para: Comodín sobre la política fiscal con r<g)
  - 4.B.5 [r] «Estancamiento secular (Summers y Rachel, 2019; Blanchard; Cochrane)» (0 ec., 0 gráf.; para: Comodín: argumento para mayor gasto público con tipos reales negativos)
- `cagan` (ref. 3.A.41; desarrollo en 3.A.35, 3.A.39, 3.A.41).
  - 3.A.35 [D] «Modelo de Cagan (1956)» (2 ec., 1 gráf.; para: Dinero como unidad de cuenta; señoreaje máximo.)
  - 3.A.39 [D] «Cagan (1956), señoreaje e impuesto inflacionario» (1 ec., 0 gráf.; para: )
  - 3.A.41 [D] «Modelo de Cagan (1956)» (1 ec., 1 gráf.; para: Hiperinflación.)
- `rbc` (ref. 3.A.42; desarrollo en 3.A.6, 3.A.42).
  - 3.A.6 [D] «Ciclo real: modelo general y McCallum (1989)» (5 ec., 2 gráf.; para: consolidación: EGDE)
  - 3.A.42 [D] «Modelo RBC (McCallum, 1989)» (2 ec., 1 gráf.; para: Ciclos reales.)
  - 4.A.29 [m] «Teoría del ciclo real» (0 ec., 0 gráf.; para: Nota: no todas las fluctuaciones deben eliminarse)
- `ramsey-cass-koopmans` (ref. 3.A.43; desarrollo en 3.A.43).
  - 3.A.6 [m] «Ramsey-Cass-Koopmans» (0 ec., 0 gráf.; para: base del RBC)
  - 3.A.29 [r] «Modelo de horizonte infinito con agente representativo» (0 ec., 0 gráf.; para: Aplicaciones de equilibrio general.)
  - 3.A.42 [r] «Ramsey-Cass-Koopmans como punto de partida» (0 ec., 0 gráf.; para: )
  - 3.A.43 [D] «Modelo de Ramsey-Cass-Koopmans» (6 ec., 1 gráf.; para: Endogeneizar el ahorro; equilibrio competitivo descentralizado; regla )
- `solow` (ref. 3.A.43; desarrollo en 3.A.43).
  - 3.A.6 [m] «Solow» (0 ec., 0 gráf.; para: ley de movimiento del capital)
  - 3.A.43 [D] «Modelo de Solow-Swan (1956)» (3 ec., 3 gráf.; para: Crecimiento por acumulación de capital y progreso técnico exógeno; con)
  - 3.B.42 [m] «Solow / MRW» (0 ec., 0 gráf.; para: por qué persiste el subdesarrollo)
  - 4.A.2 [p] «solow» (0 ec., 0 gráf.; para: )
- `romer-1990` (ref. 3.A.44; desarrollo en 3.A.44).
  - 3.A.44 [D] «Aumento del número de inputs (Romer 1990 / Grossman-Helpman 1991)» (0 ec., 0 gráf.; para: Innovación como fuente de crecimiento en competencia monopolística.)
  - 3.B.9 [r] «Romer (1990) / Rivera-Batiz y Romer (1991)» (0 ec., 0 gráf.; para: escala y difusión de ideas)
  - 3.B.34 [m] «Romer (1990)» (0 ec., 0 gráf.; para: crecimiento endógeno e ideas)
  - 3.B.39 [m] «Romer (1990)» (0 ec., 0 gráf.; para: crecimiento)
  - 3.B.42 [m] «Romer» (0 ec., 0 gráf.; para: idem)
  - 4.A.7 [p] «crecimiento-endogeno-romer» (0 ec., 0 gráf.; para: )
- `uzawa-lucas` (ref. 3.A.44; desarrollo en 3.A.44, 3.B.9).
  - 3.A.44 [D] «Modelo de Uzawa (1965) y Lucas (1988) de capital humano» (3 ec., 0 gráf.; para: Crecimiento por acumulación de capital humano.)
  - 3.B.9 [D] «Modelo de «Lucas» con externalidades y apertura» (3 ec., 1 gráf.; para: comercio como canal de spillovers)
  - 4.A.2 [p] «crecimiento-endogeno-lucas» (0 ec., 0 gráf.; para: )
  - 4.A.29 [m] «Lucas (1988), crecimiento» (0 ec., 0 gráf.; para: Relevancia del crecimiento a largo plazo)
- `ajr-instituciones` (ref. 3.A.45; desarrollo en 3.A.45, 3.B.28).
  - 3.A.45 [D] «Colonial Origins (Acemoglu, Johnson y Robinson, 2001)» (0 ec., 0 gráf.; para: Papel de las instituciones.)
  - 3.B.28 [D] «Colonial Origins (Acemoglu, Johnson y Robinson, 2001)» (0 ec., 0 gráf.; para: Instituciones y desarrollo.)
- `convergencia-beta-sigma` (ref. 3.A.45; desarrollo en 3.A.45, 3.B.40, 4.A.17).
  - 3.A.45 [D] «Convergencia β y σ (Barro y Sala-i-Martín)» (2 ec., 1 gráf.; para: Evidencia sobre convergencia.)
  - 3.B.40 [D] «β- y σ-convergencia (Sala-i-Martin)» (2 ec., 1 gráf.; para: proceso de convergencia real)
  - 4.A.17 [D] «Convergencia β y σ (Sala-i-Martín 1990)» (3 ec., 3 gráf.; para: Medir la convergencia real entre CCAA desde 1955)
- `corsetti-pesenti` (ref. 3.B.19; desarrollo en 3.A.37, 3.B.19).
  - 3.A.37 [D] «Corsetti y Pesenti (2005)» (0 ec., 0 gráf.; para: Economía abierta neokeynesiana.)
  - 3.B.14 [r] «Modelo de Corsetti y Pesenti (2005), PCP frente a LCP» (0 ec., 0 gráf.; para: tipo de cambio con microfundamentos (NOEM))
  - 3.B.19 [D] «NOEM de Corsetti y Pesenti (2005)» (3 ec., 1 gráf.; para: spillovers con expectativas racionales)
- `lucas-islas` (ref. 3.A.6; desarrollo en 3.A.6, 3.A.37, 3.A.41).
  - 3.A.6 [D] «Modelo de información imperfecta de Lucas (1972), islas de Phelps» (3 ec., 0 gráf.; para: curva de oferta de Lucas y neutralidad del dinero)
  - 3.A.37 [D] «Modelo de islas de Lucas (1972)» (2 ec., 0 gráf.; para: Neutralidad del dinero anticipado.)
  - 3.A.41 [D] «Islas de Lucas (1972)» (1 ec., 0 gráf.; para: )
  - 3.A.42 [m] «Ciclos nominales de Lucas (1972)» (0 ec., 0 gráf.; para: )
- `lucas-rapping` (ref. 3.A.6; desarrollo en 3.A.25).
  - 3.A.6 [r] «Lucas y Rapping (1969): oferta de trabajo intertemporal» (0 ec., 0 gráf.; para: microfundamentar el mercado de trabajo)
  - 3.A.25 [D] «Lucas y Rapping (1969)» (0 ec., 0 gráf.; para: Oferta intertemporal.)
  - 3.A.42 [m] «Oferta de trabajo intertemporal» (0 ec., 0 gráf.; para: )
- `multiplicadores-fiscales` (ref. 4.B.4; desarrollo en 3.A.38, 4.B.4).
  - 3.A.38 [D] «Multiplicadores fiscales (impacto, acumulado, máximo)» (0 ec., 0 gráf.; para: Evidencia.)
  - 4.A.11 [m] «Multiplicador de la inversión pública (Plan E)» (0 ec., 0 gráf.; para: Papel estabilizador de la obra civil en recesiones)
  - 4.B.4 [D] «Multiplicadores fiscales: impacto, tras k periodos, acumulado y máximo» (3 ec., 0 gráf.; para: Determinantes empíricos del multiplicador)
- `mundell-fleming` (ref. 3.B.15; desarrollo en 3.A.37, 3.B.15, 3.B.19). **Posible copia literal** (mismo nombre y mismas ecuaciones): 3.B.15, 3.B.19.
  - 3.A.37 [D] «IS-LM-BP (Mundell-Fleming)» (0 ec., 1 gráf.; para: Economía abierta.)
  - 3.A.38 [r] «IS-LM-BP» (0 ec., 0 gráf.; para: )
  - 3.B.14 [m] «Modelo IS-LM-BP (Mundell-Fleming)» (2 ec., 2 gráf.; para: borrador sin terminar (marcado) sobre efectos de políticas en el tipo )
  - 3.B.15 [D] «Modelo IS-LM-BP (Mundell-Fleming)» (4 ec., 2 gráf.; para: efectividad de las políticas fiscal y monetaria con tipo fijo y flexib)
  - 3.B.19 [D] «Modelo IS-LM-BP (Mundell-Fleming)» (4 ec., 2 gráf.; para: efectos desbordamiento entre dos países (locomotora, beggar-thy-neighb)
  - 4.B.4 [r] «Modelo Mundell-Fleming (IS-LM-BP)» (3 ec., 2 gráf.; para: Efectividad de la política fiscal según régimen cambiario y movilidad )
- `nek-3-ecuaciones` (ref. 3.A.7; desarrollo en 3.A.7, 3.A.36, 3.A.37, 3.A.38, 3.A.42, 4.B.4).
  - 3.A.7 [D] «Modelo canónico de la NEK (IS dinámica, NKPC, regla de Taylor)» (3 ec., 0 gráf.; para: NEK de 2.ª generación)
  - 3.A.36 [D] «Modelo canónico de 3 ecuaciones de la NEK (Clarida, Galí y Gertler)» (2 ec., 0 gráf.; para: Política monetaria óptima.)
  - 3.A.37 [D] «Modelo neokeynesiano de 2.ª generación» (3 ec., 0 gráf.; para: Transmisión con rigideces nominales; divina coincidencia; ELB.)
  - 3.A.38 [D] «NEK con política fiscal» (1 ec., 0 gráf.; para: Efectos del gasto con rigideces.)
  - 3.A.41 [m] «Curva de Phillips NEK (forma adelantada)» (1 ec., 0 gráf.; para: )
  - 3.A.42 [D] «Modelo canónico NEK» (1 ec., 0 gráf.; para: Ciclos nominales.)
  - 4.B.4 [D] «Modelo neokeynesiano canónico con gasto público (Clarida-Galí-Gertler » (4 ec., 1 gráf.; para: Multiplicador del gasto con rigideces nominales y respuesta monetaria)
- `rbc-sims` (ref. 4.B.4; desarrollo en 3.A.38, 4.B.4).
  - 3.A.38 [D] «RBC con política fiscal (Sims, 2015)» (1 ec., 0 gráf.; para: Equivalencia ricardiana y efecto del gasto.)
  - 4.B.4 [D] «Modelo de ciclo real con gasto público (Sims 2015; Baxter-King 1993)» (5 ec., 1 gráf.; para: Efecto riqueza negativo del gasto, multiplicador positivo pero menor q)
- `tobin-cartera` (ref. 3.B.23; desarrollo en 3.A.35, 3.B.23).
  - 3.A.35 [D] «Selección de cartera (Tobin 1958)» (0 ec., 0 gráf.; para: Motivo especulación.)
  - 3.B.23 [D] «Carteras mixtas (Tobin) y CML» (3 ec., 2 gráf.; para: separación con activo libre de riesgo)

**Bloques repetidos o copiados entre temas** (según las observaciones de los inventarios):

- 3.A.30: Principios contables (residencia, partida cuádruple, devengo, valoración) duplicados casi literalmente con 3.B.11: coordinar redacción y decidir dónde se desarrollan (SEC 2010 frente a MBP6).
- 3.A.35: Cagan, señoreaje y restricción presupuestaria del gobierno copiados casi literalmente en 3.A.35, 3.A.39 y 3.A.41: elegir un tema de desarrollo (3.A.41 por la hiperinflación o 3.A.39 por la financiación) y resumir en los demás.
- 3.A.36: Modelo NEK duplicado en 3.A.7 (origen), 3.A.36, 3.A.37, 3.A.38 y 3.A.42 con notación casi igual.
- 3.A.39: Bloques copiados de 3.A.38 (efectividad de la política fiscal) y de 3.A.41 (Cagan).
- 3.A.41: Comparte con 3.A.35, 3.A.36, 3.A.37 y 3.A.39 bloques literales (Cagan, señoreaje, Barro-Gordon, Lucas, FTPL).
- 3.A.43: Párrafos (tecnología como bien público, tamaño indeterminado de la empresa, costes de ajuste) duplicados literalmente en 3.A.44.
- 3.A.44: Comparte párrafos literales con 3.A.43 (tecnología como bien público, tamaño de empresa, costes de ajuste, notas sobre preferencia por el estado).
- 3.A.44: Barro (1990) duplicado con 3.A.38;
- 3.A.44: Romer/Grossman-Helpman duplicado con 3.B.9.

## macro-abierta (3.A.32, 3.B.11-3.B.19)

Temas: 3.A.32 (no), 3.B.11 (si), 3.B.12 (si), 3.B.13 (si), 3.B.14 (si), 3.B.15 (si), 3.B.16 (si), 3.B.17 (si), 3.B.18 (no), 3.B.19 (si)


### Modelos compartidos (12)

| id | nombre | ref. | temas que lo usan | ids fusionados |
|---|---|---|---|---|
| `identidad-balanza-pagos` | Identidades de la balanza de pagos y brecha ahorro-inversión | **3.B.11** | 3.B.11 D, 4.A.1 r, 4.A.21 r, 4.A.22 r, 4.A.23 r | ahorro-inversion-cuenta-corriente |
| `enfoque-monetario-bp` | Enfoque monetario de la balanza de pagos (Johnson, 1972) | **3.B.12** | 3.B.12 D, 3.B.22 m | — |
| `flujo-especie` | Mecanismo flujo-especie (Hume, 1752) | **3.B.12** | 3.B.12 D, 3.B.20 m | — |
| `sostenibilidad-deuda-externa` | Dinámica y sostenibilidad de la deuda exterior | **3.B.12** | 3.B.12 D, 3.B.22 r | — |
| `expectativas-contango` | Expectations hypothesis, normal backwardation y contango (anexo) | **3.B.13** | 3.B.13 r, 3.B.25 r | — |
| `paridad-intereses` | Paridad cubierta de intereses | **3.B.13** | 3.B.13 D, 3.B.14 D | paridad-cubierta, paridad-descubierta |
| `tipo-cambio-real` | Tipos de cambio nominal y real, bilateral y efectivo | **3.B.13** | 3.B.13 D, 4.A.22 D | tcer |
| `branson` | Enfoque de cartera (Branson, 1976) | **3.B.14** | 3.B.12 r, 3.B.14 D | modelo-cartera-bp |
| `dornbusch` | Modelo de sobrerreacción (Dornbusch, 1976) | **3.B.14** | 3.B.14 D, 3.B.15 r | — |
| `mundell-fleming` | Modelo IS-LM-BP (Mundell-Fleming) | **3.B.15** | 3.A.37 D, 3.A.38 r, 3.B.14 m, 3.B.15 D, 3.B.19 D, 4.B.4 r | — |
| `areas-monetarias-optimas` | Áreas monetarias óptimas (Mundell, McKinnon, Kenen; Frankel-Rose) | **3.B.16** | 3.B.16 D, 3.B.40 m, 4.A.28 m, 4.A.30 m | amo-criterios, amo-mundell, integracion-monetaria, zona-monetaria-optima |
| `corsetti-pesenti` | NOEM de Corsetti y Pesenti (2005) | **3.B.19** | 3.A.37 D, 3.B.14 r, 3.B.19 D | — |

`*` = tema sin fuente (el inventario recoge lo que debería tratar).

Modelos de otras áreas que se usan aquí: `barro-gordon` (ref. 3.A.36), `centro-periferia` (ref. 3.B.6), `diamond-dybvig` (ref. 3.B.26), `emh` (ref. 3.B.23), `gravedad` (ref. 3.B.10)


### Notación

**Un concepto, varios símbolos** (entre temas del área):

- deuda pública: `b, d, γ^Y` (3.B.12); `B (b en % del PIB)` (3.B.12); `D*` (3.B.17)
- renta (del consumidor): `Y` (3.B.14, 3.B.15, 3.B.19); `Y*` (3.B.14, 3.B.15, 3.B.19)
- tipo de cambio: `E` (3.B.12, 3.B.14); `E (PPA) y e (sombra ẽ, fijo ē)` (3.B.17)
- tipo de interés: `i` (3.B.14, 3.B.15, 3.B.19); `r / i` (3.B.12); `r` (3.B.12); `r*` (3.B.12)

**Un símbolo, varios significados** (entre temas del área; se omiten los que solo cambian de redacción):

- `E`: tipo de cambio nominal directo (3.B.12, 3.B.14); tipo de cambio (3.B.12, 3.B.14); tipo de cambio nominal (en tipo efectivo (3.B.13); tipo_cambio_nominal (3.B.13)
- `μ`: crecimiento del credito interno (3.B.17); crecimiento del credito (3.B.17); oferta monetaria / dinero (3.B.19); gasto nominal (3.B.19)
- `ϰ`: tipo de cambio real (3.B.12, 3.B.13, 3.B.14, 3.B.15, 3.B.19); tipo_cambio_real (3.B.13); tipo real (3.B.14)
- `Y*`: renta (del consumidor) (3.B.14, 3.B.15, 3.B.19); producción / renta agregada (3.B.17); objetivo de pib (3.B.17)

**Notación de los modelos compartidos que cambia de un tema a otro:**

- `barro-gordon` · paro: `U` (3.A.6); `U_t` (3.A.36)
- `diamond-dybvig` · consumo: `c` (3.A.10); `c_1, c_2` (4.A.20)

**Incoherencias internas** (dentro de cada tema):

- 3.B.12: en el enfoque del multiplicador se dice «a través de la propensión marginal al consumo, m» cuando m es la propensión marginal a importar (c es la de consumo)
- 3.B.12: el multiplicador monetario se escribe m^m mientras m es la propensión a importar
- 3.B.12: BP ≡ R en el modelo monetario (debería ser ΔR, variación de reservas)
- 3.B.12: IS del multiplicador con r e inversión inducida z·Y; en 3.B.15/3.B.19 la IS usa i, sin z y con impuestos t
- 3.B.12: P^A, P^B denotan producción en el modelo intertemporal, chocando con P precios
- 3.B.13: el tipo de cambio es E en el apartado 1 y s_t en las paridades
- 3.B.13: paso erróneo «ln(1+i) = ln(1+i*) · ln(…)» (debería ser suma de logaritmos)
- 3.B.13: imágenes numeradas con «Imagen 2–.» (formato distinto)
- 3.B.14: el tipo de cambio es E en PPA y modelos de activos pero s_t en las paridades de intereses
- 3.B.14: el apartado IS-LM-BP está en borrador (marcado) con notas del autor sobre si debe ir aquí; usa r y A(r) frente a i en el resto del tema
- 3.B.15: «Si existe movilidad perfecta de capital, β = 0, la curva BP será totalmente vertical»: debería ser movilidad nula
- 3.B.15: el supuesto 5 fija movilidad perfecta pero luego se analizan los tres casos de β
- 3.B.16: γ es aquí el peso de manufacturas mientras en 3.B.12/3.B.14 γ denota tasas de variación (γE, γ^Y)
- 3.B.17: el tipo de cambio es E en la PPA y e (ẽ, ē) en el tipo sombra
- 3.B.17: Y* es el PIB deseado por el Gobierno, mientras en 3.B.15/3.B.19 Y* es la renta extranjera
- 3.B.17: el multiplicador monetario se escribe (e+1)/(e+q) con e = coeficiente de efectivo, chocando con e tipo de cambio
- 3.B.17: α es el peso de la inflación en la pérdida (Jeanne) y la participación del capital en Krugman (1999)
- 3.B.19: el apartado «Ilustración práctica: G-20, OCDE y otros» está vacío (solo encabezados)

### Modelos desarrollados en varios temas o contados de forma distinta

- `identidad-balanza-pagos` (ref. 3.B.11; desarrollo en 3.B.11). **Posible copia literal** (mismo nombre y mismas ecuaciones): 4.A.21, 4.A.22, 4.A.23.
  - 3.B.11 [D] «Identidades de la balanza de pagos y brecha ahorro-inversión» (2 ec., 1 gráf.; para: Interpretar el saldo de la cuenta corriente como diferencia entre ahor)
  - 4.A.1 [r] «Identidad contable de la balanza de pagos» (2 ec., 1 gráf.; para: Mostrar que CC+CK+EO = CF (capacidad/necesidad de financiación))
  - 4.A.21 [r] «Identidad contable de la balanza de pagos (6MBP)» (3 ec., 1 gráf.; para: definir capacidad/necesidad de financiación y su contrapartida en la c)
  - 4.A.22 [r] «Identidad contable de la balanza de pagos (6MBP)» (3 ec., 1 gráf.; para: definir capacidad/necesidad de financiación y su contrapartida en la c)
  - 4.A.23 [r] «Identidad contable de la balanza de pagos (6MBP)» (3 ec., 1 gráf.; para: definir capacidad/necesidad de financiación y su contrapartida en la c)
- `paridad-intereses` (ref. 3.B.13; desarrollo en 3.B.13, 3.B.14).
  - 3.B.13 [D] «Paridad cubierta de intereses» (2 ec., 0 gráf.; para: arbitraje temporal)
  - 3.B.14 [D] «Paridades cubierta y no cubierta de intereses» (3 ec., 0 gráf.; para: tipo de cambio por arbitraje de capitales)
- `tipo-cambio-real` (ref. 3.B.13; desarrollo en 3.B.13, 4.A.22).
  - 3.B.13 [D] «Tipos de cambio nominal y real, bilateral y efectivo» (2 ec., 0 gráf.; para: convenciones)
  - 4.A.22 [D] «Tipo de cambio efectivo real / Índice de Tendencia de Competitividad» (4 ec., 1 gráf.; para: medir la competitividad-precio ex ante de España frente a UEM, UE, OCD)
- `mundell-fleming` (ref. 3.B.15; desarrollo en 3.A.37, 3.B.15, 3.B.19). **Posible copia literal** (mismo nombre y mismas ecuaciones): 3.B.15, 3.B.19.
  - 3.A.37 [D] «IS-LM-BP (Mundell-Fleming)» (0 ec., 1 gráf.; para: Economía abierta.)
  - 3.A.38 [r] «IS-LM-BP» (0 ec., 0 gráf.; para: )
  - 3.B.14 [m] «Modelo IS-LM-BP (Mundell-Fleming)» (2 ec., 2 gráf.; para: borrador sin terminar (marcado) sobre efectos de políticas en el tipo )
  - 3.B.15 [D] «Modelo IS-LM-BP (Mundell-Fleming)» (4 ec., 2 gráf.; para: efectividad de las políticas fiscal y monetaria con tipo fijo y flexib)
  - 3.B.19 [D] «Modelo IS-LM-BP (Mundell-Fleming)» (4 ec., 2 gráf.; para: efectos desbordamiento entre dos países (locomotora, beggar-thy-neighb)
  - 4.B.4 [r] «Modelo Mundell-Fleming (IS-LM-BP)» (3 ec., 2 gráf.; para: Efectividad de la política fiscal según régimen cambiario y movilidad )
- `areas-monetarias-optimas` (ref. 3.B.16; desarrollo en 3.B.16).
  - 3.B.16 [D] «Áreas monetarias óptimas: shocks asimétricos (Mundell, 1961)» (0 ec., 1 gráf.; para: coste de renunciar al tipo de cambio)
  - 3.B.40 [m] «Áreas monetarias óptimas» (0 ec., 0 gráf.; para: convergencia como condición de la UEM)
  - 4.A.28 [m] «Zona monetaria óptima / asincronía de ciclos («one size fits all»)» (0 ec., 0 gráf.; para: política monetaria del BCE demasiado expansiva para España)
  - 4.A.30 [m] «Teoría de las áreas monetarias óptimas (implícita)» (0 ec., 0 gráf.; para: Costes de la pertenencia a la eurozona: shocks asimétricos, asincronía)
- `corsetti-pesenti` (ref. 3.B.19; desarrollo en 3.A.37, 3.B.19).
  - 3.A.37 [D] «Corsetti y Pesenti (2005)» (0 ec., 0 gráf.; para: Economía abierta neokeynesiana.)
  - 3.B.14 [r] «Modelo de Corsetti y Pesenti (2005), PCP frente a LCP» (0 ec., 0 gráf.; para: tipo de cambio con microfundamentos (NOEM))
  - 3.B.19 [D] «NOEM de Corsetti y Pesenti (2005)» (3 ec., 1 gráf.; para: spillovers con expectativas racionales)
- `centro-periferia` (ref. 3.B.6; desarrollo en 3.B.6, 3.B.9, 3.B.16, 3.B.40). **Posible copia literal** (mismo nombre y mismas ecuaciones): 3.B.6, 3.B.9, 3.B.10.
  - 3.B.6 [D] «Modelo centro-periferia de la Nueva Geografía Económica (Krugman, 1991» (7 ec., 1 gráf.; para: explicar la aglomeración con comercio y rendimientos crecientes)
  - 3.B.9 [D] «Modelo centro-periferia de la Nueva Geografía Económica (Krugman, 1991» (7 ec., 1 gráf.; para: efectos de la integración comercial sobre localización y crecimiento)
  - 3.B.10 [r] «Modelo centro-periferia de la Nueva Geografía Económica (Krugman, 1991» (7 ec., 1 gráf.; para: determinantes geográficos de la integración)
  - 3.B.16 [D] «Modelo centro-periferia (Krugman, 1991) e hipótesis de especialización» (2 ec., 1 gráf.; para: endogeneidad de los criterios de AMO)
  - 3.B.35 [r] «Modelo centro-periferia (Krugman, 1991)» (0 ec., 1 gráf.; para: efectos de la integración en la localización)
  - 3.B.40 [D] «Nueva geografía económica: centro-periferia (Krugman 1991, Fujita, Ven» (1 ec., 1 gráf.; para: justificación económica de la política regional)
  - 4.A.12 [m] «Nueva geografía económica: determinantes de primera naturaleza» (0 ec., 0 gráf.; para: Explicar la localización industrial periférica y la orografía)
  - 4.A.17 [r] «Nueva Geografía Económica (Krugman 1991; Fujita, Venables)» (0 ec., 0 gráf.; para: Explicar la divergencia en PIB total y la concentración de actividad ()

**Bloques repetidos o copiados entre temas** (según las observaciones de los inventarios):

- 3.A.32: Es el destino natural del modelo IS-LM-BP / Mundell-Fleming y de OA-DA en economía abierta, que hoy se desarrollan (duplicados) en 3.B.15 y 3.B.19 y en borrador en 3.B.14;
- 3.B.12: autorreferencia (bloque copiado de otro tema): eliminar (párrafo del anexo 1 copiado de 3.B.14)
- 3.B.15: El IS-LM-BP es idéntico (misma notación) al de 3.B.19;
- 3.B.19: IS-LM-BP idéntico al de 3.B.15.

## comercio (3.B.5-3.B.10)

Temas: 3.B.5 (si), 3.B.6 (si), 3.B.7 (si), 3.B.8 (si), 3.B.9 (si), 3.B.10 (si)


### Modelos compartidos (15)

| id | nombre | ref. | temas que lo usan | ids fusionados |
|---|---|---|---|---|
| `ricardo` | Ventaja absoluta (Smith) y comparativa (Ricardo-Torrens) | **3.B.5** | 3.A.2 D, 3.B.5 D, 3.B.34 m, 3.B.39 m, 3.B.41 m | — |
| `centro-periferia` | Modelo centro-periferia de la nueva geografía económica (Krugman, 1991) | **3.B.6** | 3.B.6 D, 3.B.9 D, 3.B.10 r, 3.B.16 D, 3.B.35 r, 3.B.40 D, 4.A.12 m, 4.A.17 r | krugman-centro-periferia, nueva-geografia-economica |
| `krugman-1979` | Competencia monopolística y comercio (Krugman 1979, 1980) | **3.B.6** | 3.A.18 m, 3.B.6 D, 3.B.34 m, 3.B.39 m, 3.B.41 m | — |
| `melitz` | Heterogeneidad empresarial (Melitz, 2003) | **3.B.6** | 3.B.6 D, 3.B.34 m, 3.B.39 m, 3.B.41 m, 4.A.24 m, 4.A.25 m | — |
| `arancel-optimo` | Arancel óptimo | **3.B.7** | 3.B.7 D, 3.B.8 r, 3.B.41 m, 4.A.24 m | — |
| `haberler` | Haberler/Meade: curvas de oferta neta e indiferencia comercial | **3.B.7** | 3.B.5 D, 3.B.7 r | — |
| `brander-krugman` | Mercados recíprocos con arancel (Brander, 1981) | **3.B.8** | 3.B.6 r, 3.B.8 D | brander-1981 |
| `brander-spencer` | Tercer mercado con Cournot: Brander-Krugman (1983) y Brander-Spencer (1985) | **3.B.8** | 3.B.8 D, 3.B.41 m, 4.A.24 m | politica-comercial-estrategica |
| `industria-naciente` | Industria naciente con economías de escala | **3.B.8** | 3.B.8 D, 3.B.41 m | — |
| `difusion-tecnologica` | Difusión tecnológica y catch-up (Barro y Sala-i-Martín) | **3.B.9** | 3.B.9 r, 4.A.17 m | barro-sala, difusion-tecnologica-catch-up |
| `grossman-helpman` | Grossman y Helpman (1990-91) | **3.B.9** | 3.B.8 m, 3.B.9 r | — |
| `prebisch-singer` | Prebisch-Singer / ISI frente a IOE | **3.B.9** | 3.B.9 r, 4.A.27 m | isi |
| `gravedad` | Modelo gravitatorio y con heterogeneidad de empresas; efecto frontera | **3.B.10** | 3.B.6 r, 3.B.10 D, 3.B.15 m, 3.B.35 m, 3.B.41 m, 4.A.22 m, 4.A.24 m, 4.A.25 m | gravitatorio, modelo-gravedad |
| `kemp-wan` | Teorema de Kemp-Wan (1976) | **3.B.10** | 3.B.10 r, 3.B.33 m | — |
| `viner` | Creación y desviación de comercio (Viner, 1950) | **3.B.10** | 3.A.22 m, 3.B.10 D, 3.B.35 m, 3.B.39 m, 3.B.41 m | union-aduanera-viner |

`*` = tema sin fuente (el inventario recoge lo que debería tratar).

Modelos de otras áreas que se usan aquí: `falvey` (ref. 3.A.18), `leontief` (ref. 3.A.11), `progreso-tecnico-neutral` (ref. 3.A.11), `romer-1990` (ref. 3.A.44), `uzawa-lucas` (ref. 3.A.44)


### Notación

**Un concepto, varios símbolos** (entre temas del área):

- cantidades / cesta: `X, Y` (3.B.5); `q_i` (3.B.8); `q_i^A` (3.B.8)
- salario: `ω_i` (3.B.6, 3.B.9, 3.B.10); `w` (3.B.5)

**Un símbolo, varios significados** (entre temas del área; se omiten los que solo cambian de redacción):

- `σ`: elasticidad de sustitución (3.B.6); elasticidad (3.B.6); elasticidad_sustitucion (3.B.6, 3.B.9, 3.B.10)

**Incoherencias internas** (dentro de cada tema):

- 3.B.5: en Ricardo los países son 1 y 2 y los bienes a/b (paño, vino); en Haberler y HOS los países son A y B y los bienes X/Y
- 3.B.5: falta la Imagen 8 en la numeración de gráficos
- 3.B.6: la variedad se llama x_i en el problema del consumidor y x/q en la oferta; luego y_k en la NEG
- 3.B.6: productividad φ en texto y ϕ en fórmulas
- 3.B.7: epígrafe «Aranceles y cuotas a la información» (errata por «a la importación»)
- 3.B.7: los precios relativos se escriben p_A^X/p_B^X en un sitio y P_X/P_Y en otro
- 3.B.8: epígrafe 3 «jOHNSON» (errata)
- 3.B.8: φ como función de reacción frente a φ peso de inputs en 3.B.7
- 3.B.9: el modelo llamado «de Lucas» es en realidad un modelo de externalidades de capital tipo Romer (1986)/Arrow, no el de capital humano de Lucas (1988)
- 3.B.9: dice que en los modelos endógenos de 1.ª generación «el progreso tecnológico es un resultado exógeno»
- 3.B.9: β se usa como apertura comercial y, en otros temas del bloque, como coeficiente de regresión (gravedad)
- 3.B.10: el epígrafe 0 («Formas de integración») está fuera de la numeración del resto

### Modelos desarrollados en varios temas o contados de forma distinta

- `ricardo` (ref. 3.B.5; desarrollo en 3.A.2, 3.B.5).
  - 3.A.2 [D] «Ventaja comparativa de Ricardo (ejemplo paño-vino)» (2 ec., 0 gráf.; para: comercio internacional en Ricardo)
  - 3.B.5 [D] «Ventaja absoluta (Smith) y comparativa (Ricardo-Torrens)» (2 ec., 3 gráf.; para: ¿por qué comercian los países? diferencias tecnológicas)
  - 3.B.34 [m] «Ventaja comparativa» (0 ec., 0 gráf.; para: motivación de la liberalización)
  - 3.B.39 [m] «Ventaja comparativa (Haberler)» (0 ec., 0 gráf.; para: motivación teórica)
  - 3.B.41 [m] «Ventaja comparativa» (0 ec., 0 gráf.; para: justificación)
- `centro-periferia` (ref. 3.B.6; desarrollo en 3.B.6, 3.B.9, 3.B.16, 3.B.40). **Posible copia literal** (mismo nombre y mismas ecuaciones): 3.B.6, 3.B.9, 3.B.10.
  - 3.B.6 [D] «Modelo centro-periferia de la Nueva Geografía Económica (Krugman, 1991» (7 ec., 1 gráf.; para: explicar la aglomeración con comercio y rendimientos crecientes)
  - 3.B.9 [D] «Modelo centro-periferia de la Nueva Geografía Económica (Krugman, 1991» (7 ec., 1 gráf.; para: efectos de la integración comercial sobre localización y crecimiento)
  - 3.B.10 [r] «Modelo centro-periferia de la Nueva Geografía Económica (Krugman, 1991» (7 ec., 1 gráf.; para: determinantes geográficos de la integración)
  - 3.B.16 [D] «Modelo centro-periferia (Krugman, 1991) e hipótesis de especialización» (2 ec., 1 gráf.; para: endogeneidad de los criterios de AMO)
  - 3.B.35 [r] «Modelo centro-periferia (Krugman, 1991)» (0 ec., 1 gráf.; para: efectos de la integración en la localización)
  - 3.B.40 [D] «Nueva geografía económica: centro-periferia (Krugman 1991, Fujita, Ven» (1 ec., 1 gráf.; para: justificación económica de la política regional)
  - 4.A.12 [m] «Nueva geografía económica: determinantes de primera naturaleza» (0 ec., 0 gráf.; para: Explicar la localización industrial periférica y la orografía)
  - 4.A.17 [r] «Nueva Geografía Económica (Krugman 1991; Fujita, Venables)» (0 ec., 0 gráf.; para: Explicar la divergencia en PIB total y la concentración de actividad ()
- `melitz` (ref. 3.B.6; desarrollo en 3.B.6).
  - 3.B.6 [D] «Heterogeneidad empresarial (Melitz, 2003)» (2 ec., 1 gráf.; para: selección y reasignación hacia empresas más productivas)
  - 3.B.34 [m] «Melitz (2003)» (0 ec., 0 gráf.; para: ganancias de productividad)
  - 3.B.39 [m] «Melitz (2003)» (0 ec., 0 gráf.; para: motivación teórica)
  - 3.B.41 [m] «Melitz (2003)» (0 ec., 0 gráf.; para: justificación)
  - 4.A.24 [m] «Heterogeneidad empresarial y selección en exportación (Melitz 2003; Be» (0 ec., 0 gráf.; para: justificar que las empresas internacionalizadas son más productivas y )
  - 4.A.25 [m] «Heterogeneidad empresarial y selección en exportación (Melitz 2003; Be» (0 ec., 0 gráf.; para: justificar que las empresas internacionalizadas son más productivas y )
- `arancel-optimo` (ref. 3.B.7; desarrollo en 3.B.7).
  - 3.B.7 [D] «Arancel óptimo» (1 ec., 1 gráf.; para: arancel que maximiza el bienestar del país grande)
  - 3.B.8 [r] «Arancel óptimo y guerra comercial (Johnson, 1953)» (1 ec., 1 gráf.; para: comportamiento estratégico en equilibrio general)
  - 3.B.41 [m] «Argumento de la RRI/arancel óptimo» (0 ec., 0 gráf.; para: excepciones al librecambio)
  - 4.A.24 [m] «Arancel óptimo de país grande» (0 ec., 0 gráf.; para: costes potenciales de la apertura / justificación de la política comer)
- `brander-spencer` (ref. 3.B.8; desarrollo en 3.B.8).
  - 3.B.8 [D] «Tercer mercado con Cournot: Brander-Krugman (1983) y Brander-Spencer (» (2 ec., 3 gráf.; para: justificación de subsidios a la exportación)
  - 3.B.41 [m] «Política comercial estratégica» (0 ec., 0 gráf.; para: excepciones)
  - 4.A.24 [m] «Política comercial estratégica (Brander-Spencer)» (0 ec., 0 gráf.; para: fallos de mercado que justifican intervención)
- `gravedad` (ref. 3.B.10; desarrollo en 3.B.10).
  - 3.B.6 [r] «Modelo gravitacional (Tinbergen, 1962)» (1 ec., 0 gráf.; para: explicar volúmenes de comercio)
  - 3.B.10 [D] «Modelo gravitatorio y con heterogeneidad de empresas; efecto frontera» (0 ec., 0 gráf.; para: medición empírica de la integración)
  - 3.B.15 [m] «Efecto de la moneda común en el comercio (Rose, 2000)» (0 ec., 0 gráf.; para: evidencia de los beneficios del tipo fijo)
  - 3.B.35 [m] «Modelo de gravedad (Tinbergen)» (0 ec., 0 gráf.; para: efecto de los acuerdos comerciales)
  - 3.B.41 [m] «Modelo de gravedad estructural (Timini y Viani 2020)» (0 ec., 0 gráf.; para: evidencia UE-Mercosur)
  - 4.A.22 [m] «Modelo de gravedad del comercio» (0 ec., 0 gráf.; para: explicar la concentración geográfica en socios grandes y próximos y el)
  - 4.A.24 [m] «Modelo de gravedad comercial» (0 ec., 0 gráf.; para: exportaciones a China y sudeste asiático por debajo de su potencial)
  - 4.A.25 [m] «Modelo de gravedad comercial» (0 ec., 0 gráf.; para: exportaciones a China y sudeste asiático por debajo de su potencial)
- `viner` (ref. 3.B.10; desarrollo en 3.B.10).
  - 3.A.22 [m] «Uniones aduaneras como caso de second best» (0 ec., 0 gráf.; para: Aplicación del second best al comercio internacional)
  - 3.B.10 [D] «Creación y desviación de comercio (Viner, 1950)» (1 ec., 2 gráf.; para: efectos estáticos de una unión aduanera)
  - 3.B.35 [m] «Creación y desviación de comercio (Viner)» (0 ec., 0 gráf.; para: justificación del regionalismo)
  - 3.B.39 [m] «Creación y desviación de comercio (Viner)» (0 ec., 0 gráf.; para: motivación teórica)
  - 3.B.41 [m] «Integración económica» (0 ec., 0 gráf.; para: second-best)
- `uzawa-lucas` (ref. 3.A.44; desarrollo en 3.A.44, 3.B.9).
  - 3.A.44 [D] «Modelo de Uzawa (1965) y Lucas (1988) de capital humano» (3 ec., 0 gráf.; para: Crecimiento por acumulación de capital humano.)
  - 3.B.9 [D] «Modelo de «Lucas» con externalidades y apertura» (3 ec., 1 gráf.; para: comercio como canal de spillovers)
  - 4.A.2 [p] «crecimiento-endogeno-lucas» (0 ec., 0 gráf.; para: )
  - 4.A.29 [m] «Lucas (1988), crecimiento» (0 ec., 0 gráf.; para: Relevancia del crecimiento a largo plazo)

**Bloques repetidos o copiados entre temas** (según las observaciones de los inventarios):

- 3.B.6: Bloque NEG (centro-periferia) copiado casi literal en 3.B.6, 3.B.9 y 3.B.10: el desarrollo debería quedar en 3.B.6 y los otros resumir.
- 3.B.7: El análisis de equilibrio general del arancel (Meade, arancel óptimo, guerra comercial de Johnson) está duplicado literal en 3.B.8 apartado 3: candidato de desarrollo 3.B.7, resumen en 3.B.8.
- 3.B.7: autorreferencia: frase copiada del bloque común de introducción/notas de 3.B.5-3.B.9;
- 3.B.7: el mismo párrafo copiado en 3.B.8 ya cita 3.A.14
- 3.B.8: autorreferencia: frase copiada del bloque común de introducción/notas de 3.B.5-3.B.9;
- 3.B.9: autorreferencia: frase copiada del bloque común de introducción/notas de 3.B.5-3.B.9;

## finanzas-empresa (3.B.1-3.B.4, 3.B.23-3.B.27)

Temas: 3.B.1 (si), 3.B.2 (si), 3.B.3 (si), 3.B.4 (si), 3.B.23 (si), 3.B.24 (si), 3.B.25 (si), 3.B.26 (no), 3.B.27 (si)


### Modelos compartidos (11)

| id | nombre | ref. | temas que lo usan | ids fusionados |
|---|---|---|---|---|
| `van-tir` | Criterios VAN y TIR | **3.B.2** | 3.B.2 D, 4.B.6 D | tir, van |
| `wacc` | Coste medio ponderado del capital | **3.B.2** | 3.B.2 D, 3.B.3 r | — |
| `modigliani-miller` | Modigliani y Miller (1958) y extensiones (impuestos, insolvencia de Kim 1978, Miller 1977) | **3.B.3** | 3.B.3 D, 4.B.10 D, 4.B.12 m | — |
| `dcf` | Valoración por descuento de flujos de caja (DCF) | **3.B.4** | 3.B.4 D, 3.B.23 r | — |
| `gordon-shapiro` | Modelo de Gordon-Shapiro (perpetuidad creciente de dividendos) | **3.B.4** | 3.B.2 r, 3.B.3 D, 3.B.4 D | gordon |
| `capm` | CAPM (Sharpe, Lintner, Mossin) | **3.B.23** | 3.B.2 r, 3.B.3 m, 3.B.23 D | — |
| `emh` | Hipótesis de mercados eficientes y behavioral finance | **3.B.23** | 3.B.13 r, 3.B.23 D | — |
| `markowitz` | Media-varianza (Markowitz, 1952) | **3.B.23** | 3.A.10 m, 3.B.23 D | markowitz-media-varianza |
| `tobin-cartera` | Carteras mixtas (Tobin) y CML | **3.B.23** | 3.A.35 D, 3.B.23 D | tobin-separacion |
| `diamond-dybvig` | Pánicos bancarios (Diamond y Dybvig, 1983) | **3.B.26** | 3.A.10 m, 3.B.17 r, 3.B.26 p*, 3.B.27 D, 4.A.20 D | — |
| `basilea-capital` | Basilea III | **3.B.27** | 3.B.1 m, 3.B.27 D | — |

`*` = tema sin fuente (el inventario recoge lo que debería tratar).

Modelos de otras áreas que se usan aquí: `baumol-tobin` (ref. 3.A.35), `expectativas-contango` (ref. 3.B.13), `opciones-reales` (ref. 3.A.34), `stigler-costes` (ref. 3.A.12), `stiglitz-weiss` (ref. 3.A.13)


### Notación

**Un concepto, varios símbolos** (entre temas del área):

- beneficio: `EBIAT` (3.B.1); `B_0` (3.B.3); `BPA` (3.B.4); `E[B]` (3.B.27)
- deuda pública: `r_E, r_D` (3.B.2, 3.B.3); `L` (3.B.2); `r_D` (3.B.2); `V_D, V_E` (3.B.3)
- factor/tasa de descuento: `k` (3.B.4); `r_t` (3.B.24)
- rendimiento/rentabilidad: `ROA` (3.B.1); `ROE` (3.B.1); `y` (3.B.3); `R_f, R_M` (3.B.23); `YTM` (3.B.24)

**Un símbolo, varios significados** (entre temas del área; se omiten los que solo cambian de redacción):

- `L`: deuda pública (3.B.2); apalancamiento (3.B.2); v_d/(v_d+v_e) (3.B.3)

**Notación de los modelos compartidos que cambia de un tema a otro:**

- `modigliani-miller` · apalancamiento: `V_D/V_E` (3.B.3); `L = V_D/(V_D+V_E)` (4.B.10)
- `capm` · tipo_libre_riesgo: `r_f` (3.B.2); `R_f` (3.B.23)
- `capm` · rendimiento_mercado: `r_M` (3.B.2); `R_M` (3.B.23)
- `diamond-dybvig` · consumo: `c` (3.A.10); `c_1, c_2` (4.A.20)

**Incoherencias internas** (dentro de cada tema):

- 3.B.1: el esquema repite «3.3 Análisis de la liquidez / 3.4 solvencia / 3.5 resultado» tras haber tratado liquidez y solvencia en 3.1-3.2 (estructura redundante)
- 3.B.1: ROA definido con EBIAT pero ROCE y ratio de cobertura con EBIT sin aclarar la diferencia
- 3.B.2: ROA = EBIT/Activos aquí frente a EBIAT/Activos en 3.B.1
- 3.B.2: crecimiento de la perpetuidad: g aquí, d en 3.B.4; coste de capital k / WACC / r usados indistintamente
- 3.B.2: la prima de riesgo se denota ρ (en 3.B.6 ρ es el parámetro de sustitución CES)
- 3.B.3: en la fórmula de P_0 con impuestos aparece r_E/(1 + t_IRPF), dudosa (lo habitual es r_E/(1 − t))
- 3.B.3: Gordon con y (rentabilidad) mientras 3.B.4 usa d para el crecimiento del dividendo
- 3.B.4: el apartado «¿Qué método utilizar?» aparece dos veces (3.1.2 y 3.1.3)
- 3.B.4: el apartado se titula «múltiplo EBITDA» pero la fórmula usa EBIT
- 3.B.23: β_i definida primero como cov(R_i,R_M)/var(R_M) y después como Cov(E[R_i],E[R_M])/Var(R_M) (incorrecta: covarianza de esperanzas)
- 3.B.23: pesos X_i (Markowitz), w (Tobin) y w_i (Sharpe)
- 3.B.23: el apartado se titula «EBIT múltiplo» y en 3.B.4 «múltiplo EBITDA»
- 3.B.23: CAPM con mayúsculas R_f, R_M aquí y minúsculas r_f, r_M en 3.B.2/3.B.3
- 3.B.24: «duración en unidades monetarias = Precio · r · Duración modificada» (sobra r: la dollar duration es Precio · D_mod)
- 3.B.24: i denota el cupón aquí mientras en el resto del bloque i es el tipo de interés
- 3.B.25: precio de ejercicio como P_ejercicio y como X; P_0 es a la vez prima de la put
- 3.B.25: el pago del futuro se escribe S_T − P_ejercicio (debería ser S_T − F_0, precio pactado)
- 3.B.25: en el ejemplo binomial se descuenta multiplicando por (1 − r_f) en vez de dividir por (1 + r_f)
- 3.B.27: título de gráfico «modelo de Corunot» (errata)
- 3.B.27: el epígrafe 3.4 «Capital humano de las cajas» no encaja con el resto de la evidencia

### Modelos desarrollados en varios temas o contados de forma distinta

- `van-tir` (ref. 3.B.2; desarrollo en 3.B.2, 4.B.6).
  - 3.B.2 [D] «Criterios VAN, TIR, TIRM y payback» (4 ec., 1 gráf.; para: cómo seleccionar proyectos de inversión)
  - 4.B.6 [D] «Valor actual neto» (1 ec., 0 gráf.; para: Regla de decisión de referencia)
- `modigliani-miller` (ref. 3.B.3; desarrollo en 3.B.3, 4.B.10).
  - 3.B.3 [D] «Modigliani y Miller (1958) y extensiones (impuestos, insolvencia de Ki» (2 ec., 2 gráf.; para: ¿existe una estructura financiera óptima?)
  - 4.B.10 [D] «Teorema de Modigliani-Miller (1958) y con impuestos (MM 1963; Miller 1» (4 ec., 3 gráf.; para: Efecto del IS y del IRPF sobre la estructura de capital (escudo fiscal)
  - 4.B.12 [m] «Modigliani-Miller» (0 ec., 0 gráf.; para: El IS rompe la irrelevancia de la estructura financiera y de la políti)
- `gordon-shapiro` (ref. 3.B.4; desarrollo en 3.B.3, 3.B.4).
  - 3.B.2 [r] «Perpetuidad y perpetuidad creciente (anexo)» (2 ec., 0 gráf.; para: valor presente de rentas)
  - 3.B.3 [D] «Tesis de relevancia de los dividendos (Gordon)» (2 ec., 0 gráf.; para: ¿afectan los dividendos al valor?)
  - 3.B.4 [D] «Valoración por dividendos (Gordon-Shapiro)» (2 ec., 0 gráf.; para: valor de la acción)
- `capm` (ref. 3.B.23; desarrollo en 3.B.23).
  - 3.B.2 [r] «CAPM para el coste de capital» (1 ec., 0 gráf.; para: estimación directa del coste de capital)
  - 3.B.3 [m] «CAPM» (1 ec., 0 gráf.; para: coste de los fondos propios)
  - 3.B.23 [D] «CAPM (Sharpe, Lintner, Mossin)» (3 ec., 1 gráf.; para: rentabilidad exigida según riesgo sistemático)
- `tobin-cartera` (ref. 3.B.23; desarrollo en 3.A.35, 3.B.23).
  - 3.A.35 [D] «Selección de cartera (Tobin 1958)» (0 ec., 0 gráf.; para: Motivo especulación.)
  - 3.B.23 [D] «Carteras mixtas (Tobin) y CML» (3 ec., 2 gráf.; para: separación con activo libre de riesgo)
- `diamond-dybvig` (ref. 3.B.26; desarrollo en 3.B.27, 4.A.20).
  - 3.A.10 [m] «Modelo de Diamond y Dybvig (1983)» (0 ec., 0 gráf.; para: Aplicación (anexo 3): bancos como seguro de liquidez y pánicos)
  - 3.B.17 [r] «Pánicos bancarios (Diamond y Dybvig, 1983)» (0 ec., 0 gráf.; para: anexo: pánico bancario en crisis gemelas)
  - 3.B.27 [D] «Diamond y Dybvig (1983)» (1 ec., 4 gráf.; para: equilibrios múltiples y pánicos bancarios)
  - 4.A.20 [D] «Pánicos bancarios (Diamond y Dybvig, 1983)» (4 ec., 4 gráf.; para: mostrar la inestabilidad inherente de los bancos como argumento a favo)
- `baumol-tobin` (ref. 3.A.35; desarrollo en 3.A.35, 3.B.2).
  - 3.A.35 [D] «Modelo de inventarios (Baumol 1952, Tobin 1956) y Miller-Orr» (0 ec., 0 gráf.; para: Motivo transacción.)
  - 3.B.2 [D] «Modelo de inventario de tesorería (Baumol, 1952; Tobin)» (2 ec., 1 gráf.; para: inversión óptima en tesorería)
- `stiglitz-weiss` (ref. 3.A.13; desarrollo en 3.B.27, 4.A.20).
  - 3.A.7 [m] «Racionamiento del crédito (Stiglitz-Weiss 1981)» (0 ec., 0 gráf.; para: imperfecciones del mercado de crédito)
  - 3.A.13 [r] «Racionamiento del crédito (Stiglitz y Weiss, 1981)» (0 ec., 2 gráf.; para: selección adversa y riesgo moral simultáneos en el mercado de crédito)
  - 3.B.27 [D] «Racionamiento del crédito (Stiglitz y Weiss, 1981)» (2 ec., 2 gráf.; para: selección adversa en el crédito)
  - 3.B.28 [m] «Racionamiento del crédito (Stiglitz y Weiss, 1981)» (0 ec., 0 gráf.; para: Mercado de crédito en países en desarrollo.)
  - 4.A.20 [D] «Racionamiento del crédito con información asimétrica (Stiglitz y Weiss» (2 ec., 2 gráf.; para: justificar por qué conviene reducir la dependencia de la financiación )
  - 4.A.24 [m] «Información asimétrica y racionamiento del crédito a la exportación» (0 ec., 0 gráf.; para: justificar la intervención financiera pública (fallo de mercado))
  - 4.A.25 [m] «Información asimétrica y racionamiento del crédito a la exportación» (0 ec., 0 gráf.; para: justificar la intervención financiera pública (fallo de mercado))

**Bloques repetidos o copiados entre temas** (según las observaciones de los inventarios):

- 3.B.2: Comparte con 3.B.3 casi literalmente el apartado de estimación del coste de capital (CAPM, WACC).
- 3.B.4: Comparte con 3.B.23 el bloque de análisis fundamental (DCF, múltiplos, PER) casi literal: decidir un desarrollo (3.B.4) y resumir en 3.B.23.
- 3.B.23: Análisis fundamental duplicado con 3.B.4.
- 3.B.25: el anexo de backwardation/contango está duplicado en 3.B.13.

## historia-organismos (3.B.20-3.B.22, 3.B.28-3.B.35)

Temas: 3.B.20 (si), 3.B.21 (si), 3.B.22 (si), 3.B.28 (si), 3.B.29 (no), 3.B.30 (no), 3.B.31 (no), 3.B.32 (no), 3.B.33 (si), 3.B.34 (si), 3.B.35 (si)


### Modelos compartidos (2)

| id | nombre | ref. | temas que lo usan | ids fusionados |
|---|---|---|---|---|
| `triffin` | Dilema de Triffin | **3.B.20** | 3.B.20 r, 3.B.21 r | — |
| `lewis` | Modelo dual de Lewis (1954) | **3.B.28** | 3.B.28 D, 4.A.27 m | lewis-dual |

`*` = tema sin fuente (el inventario recoge lo que debería tratar).

Modelos de otras áreas que se usan aquí: `ajr-instituciones` (ref. 3.A.45), `centro-periferia` (ref. 3.B.6), `enfoque-monetario-bp` (ref. 3.B.12), `flujo-especie` (ref. 3.B.12), `gravedad` (ref. 3.B.10), `kemp-wan` (ref. 3.B.10), `krugman-1979` (ref. 3.B.6), `melitz` (ref. 3.B.6), `ricardo` (ref. 3.B.5), `romer-1990` (ref. 3.A.44), `sostenibilidad-deuda-externa` (ref. 3.B.12), `stiglitz-weiss` (ref. 3.A.13), `viner` (ref. 3.B.10)


### Notación


**Incoherencias internas** (dentro de cada tema):

- 3.B.20: el subapartado «Consecuencias económicas de la Primera Guerra Mundial (1918-1829)» tiene una errata de fecha
- 3.B.34: el párrafo de motivación económica (teoría del comercio) aparece dos veces, en GATS y en TRIPS

### Modelos desarrollados en varios temas o contados de forma distinta

- `ajr-instituciones` (ref. 3.A.45; desarrollo en 3.A.45, 3.B.28).
  - 3.A.45 [D] «Colonial Origins (Acemoglu, Johnson y Robinson, 2001)» (0 ec., 0 gráf.; para: Papel de las instituciones.)
  - 3.B.28 [D] «Colonial Origins (Acemoglu, Johnson y Robinson, 2001)» (0 ec., 0 gráf.; para: Instituciones y desarrollo.)

**Bloques repetidos o copiados entre temas** (según las observaciones de los inventarios):

- 3.B.22: autorreferencia (bloque copiado de otro tema): eliminar (párrafo de los tres pilares de Bretton Woods)
- 3.B.28: El bloque AJR/instituciones está duplicado con 3.A.45 (mismos epígrafes).
- 3.B.33: autorreferencia (bloque copiado de otro tema): eliminar;
- 3.B.34: autorreferencia (bloque copiado de otro tema): eliminar

## union-europea (3.B.36-3.B.45)

Temas: 3.B.36 (si), 3.B.37 (si), 3.B.38 (no), 3.B.39 (si), 3.B.40 (si), 3.B.41 (si), 3.B.42 (si), 3.B.43 (no), 3.B.44 (no), 3.B.45 (no)


### Modelos compartidos (7)

| id | nombre | ref. | temas que lo usan | ids fusionados |
|---|---|---|---|---|
| `cbam` | Mecanismo de Ajuste en Frontera por Carbono | **3.B.37** | 3.B.37 r, 4.B.18 m | mafc |
| `next-generation-eu` | Next Generation EU y Mecanismo de Recuperación y Resiliencia | **3.B.37** | 3.B.37 D, 4.B.21 m, 4.B.26 m | mecanismo-recuperacion-resiliencia |
| `recursos-propios-ue` | Decisión de Recursos Propios (2020): RPT, IVA, RNB, plásticos y nuevos recursos | **3.B.37** | 3.B.37 D, 4.B.18 r | recursos-propios |
| `arancel-exterior-comun` | Arancel aduanero común y regímenes aduaneros | **3.B.41** | 3.B.41 D, 4.B.18 r | arancel-externo-comun |
| `mede` | Mecanismo Europeo de Estabilidad (y FEEF, MEEF) | **3.B.45** | 3.B.36 r, 3.B.37 r, 3.B.45 p*, 4.B.26 r | — |
| `pec` | PEC y PEC reforzado (Six-pack, Two-pack, Fiscal Compact), PDE, criterio de deuda (1/20) | **3.B.45** | 3.B.45 p*, 4.B.21 m, 4.B.22 m, 4.B.26 r | — |
| `semestre-europeo` | Semestre Europeo | **3.B.45** | 3.B.45 p*, 4.B.26 r | — |

`*` = tema sin fuente (el inventario recoge lo que debería tratar).

Modelos de otras áreas que se usan aquí: `aghion-howitt` (ref. 3.A.44), `arancel-optimo` (ref. 3.B.7), `areas-monetarias-optimas` (ref. 3.B.16), `brander-spencer` (ref. 3.B.8), `cap-and-trade` (ref. 3.A.23), `centro-periferia` (ref. 3.B.6), `convergencia-beta-sigma` (ref. 3.A.45), `gravedad` (ref. 3.B.10), `industria-naciente` (ref. 3.B.8), `ineficiencia-x` (ref. 3.A.12), `krugman-1979` (ref. 3.B.6), `melitz` (ref. 3.B.6), `ricardo` (ref. 3.B.5), `romer-1990` (ref. 3.A.44), `solow` (ref. 3.A.43), `trampas-pobreza` (ref. 3.A.43), `viner` (ref. 3.B.10)


### Notación


**Incoherencias internas** (dentro de cada tema):

- 3.B.36: 'Robert Schuman' aparece también como 'Robert Schumann'
- 3.B.39: 'Feldstein' escrito también 'Feldsetein'
- 3.B.40: geografía económica: se dice que el mark-up μ=σ/(σ−1) depende positivamente de σ y que σ mide la preferencia por la variedad; μ es decreciente en σ y más preferencia por la variedad equivale a σ menor
- 3.B.40: σ se usa en el mismo tema para la elasticidad de sustitución y para la dispersión de la renta
- 3.B.40: remisiones contradictorias para el modelo centro-periferia: 3.B.6 en el epígrafe y 3.B.10 en el texto
- 3.B.41: 'CARACTERZACIÓN' en el título del bloque I
- 3.B.42: epígrafes de acuerdos por regiones vacíos (duplican la lista de 3.B.41)

### Modelos desarrollados en varios temas o contados de forma distinta

- `next-generation-eu` (ref. 3.B.37; desarrollo en 3.B.37).
  - 3.B.37 [D] «Next Generation EU y Mecanismo de Recuperación y Resiliencia» (0 ec., 0 gráf.; para: actividad extrapresupuestaria)
  - 4.B.21 [m] «Fondos Next Generation EU / PRTR en los PGE» (0 ec., 0 gráf.; para: Volumen de recursos de los PGE 2023)
  - 4.B.26 [m] «NGEU / PRTR en la financiación del Tesoro» (0 ec., 0 gráf.; para: Desembolsos y préstamos del MRR)
- `mede` (ref. 3.B.45; desarrollo en ninguno).
  - 3.B.36 [r] «Mecanismo Europeo de Estabilidad» (0 ec., 0 gráf.; para: otras instituciones (desarrollo en 3.B.45))
  - 3.B.37 [r] «MEDE, MEEF, FEEF y balanza de pagos» (0 ec., 0 gráf.; para: instrumentos macroeconómicos)
  - 4.B.26 [r] «Mecanismo Europeo de Estabilidad (y FEEF, MEEF)» (0 ec., 0 gráf.; para: Mecanismo permanente de financiación; préstamo de 2012 a España para e)
- `pec` (ref. 3.B.45; desarrollo en ninguno).
  - 4.B.21 [m] «Pacto de Estabilidad y Crecimiento y cláusula general de salvaguardia» (0 ec., 0 gráf.; para: Suspensión de reglas fiscales 2020-2023 y tasas de referencia)
  - 4.B.22 [m] «PEC, Six-Pack (PEC reforzado 2011), Semestre Europeo, Fiscal Compact» (0 ec., 0 gráf.; para: Medidas de consolidación a nivel UE)
  - 4.B.26 [r] «PEC y PEC reforzado (Six-pack, Two-pack, Fiscal Compact), PDE, criteri» (0 ec., 0 gráf.; para: Consolidación a nivel UE y cumplimiento comparado)
- `centro-periferia` (ref. 3.B.6; desarrollo en 3.B.6, 3.B.9, 3.B.16, 3.B.40). **Posible copia literal** (mismo nombre y mismas ecuaciones): 3.B.6, 3.B.9, 3.B.10.
  - 3.B.6 [D] «Modelo centro-periferia de la Nueva Geografía Económica (Krugman, 1991» (7 ec., 1 gráf.; para: explicar la aglomeración con comercio y rendimientos crecientes)
  - 3.B.9 [D] «Modelo centro-periferia de la Nueva Geografía Económica (Krugman, 1991» (7 ec., 1 gráf.; para: efectos de la integración comercial sobre localización y crecimiento)
  - 3.B.10 [r] «Modelo centro-periferia de la Nueva Geografía Económica (Krugman, 1991» (7 ec., 1 gráf.; para: determinantes geográficos de la integración)
  - 3.B.16 [D] «Modelo centro-periferia (Krugman, 1991) e hipótesis de especialización» (2 ec., 1 gráf.; para: endogeneidad de los criterios de AMO)
  - 3.B.35 [r] «Modelo centro-periferia (Krugman, 1991)» (0 ec., 1 gráf.; para: efectos de la integración en la localización)
  - 3.B.40 [D] «Nueva geografía económica: centro-periferia (Krugman 1991, Fujita, Ven» (1 ec., 1 gráf.; para: justificación económica de la política regional)
  - 4.A.12 [m] «Nueva geografía económica: determinantes de primera naturaleza» (0 ec., 0 gráf.; para: Explicar la localización industrial periférica y la orografía)
  - 4.A.17 [r] «Nueva Geografía Económica (Krugman 1991; Fujita, Venables)» (0 ec., 0 gráf.; para: Explicar la divergencia en PIB total y la concentración de actividad ()
- `convergencia-beta-sigma` (ref. 3.A.45; desarrollo en 3.A.45, 3.B.40, 4.A.17).
  - 3.A.45 [D] «Convergencia β y σ (Barro y Sala-i-Martín)» (2 ec., 1 gráf.; para: Evidencia sobre convergencia.)
  - 3.B.40 [D] «β- y σ-convergencia (Sala-i-Martin)» (2 ec., 1 gráf.; para: proceso de convergencia real)
  - 4.A.17 [D] «Convergencia β y σ (Sala-i-Martín 1990)» (3 ec., 3 gráf.; para: Medir la convergencia real entre CCAA desde 1955)

**Bloques repetidos o copiados entre temas** (según las observaciones de los inventarios):

- 3.B.41: Lista de acuerdos repetida en 3.B.42.

## economia-espanola (4.A)

Temas: 4.A.1 (otro-titulo), 4.A.2 (no), 4.A.3 (no), 4.A.4 (no), 4.A.5 (no), 4.A.6 (no), 4.A.7 (no), 4.A.8 (no), 4.A.9 (no), 4.A.10 (no), 4.A.11 (otro-titulo), 4.A.12 (otro-titulo), 4.A.13 (otro-titulo), 4.A.14 (otro-titulo), 4.A.15 (otro-titulo), 4.A.16 (parcial), 4.A.17 (si), 4.A.18 (otro-titulo), 4.A.19 (otro-titulo), 4.A.20 (otro-titulo), 4.A.21 (renumerado), 4.A.22 (renumerado), 4.A.23 (renumerado), 4.A.24 (renumerado), 4.A.25 (renumerado), 4.A.26 (no), 4.A.27 (otro-titulo), 4.A.28 (otro-titulo), 4.A.29 (otro-titulo), 4.A.30 (otro-titulo)


### Modelos compartidos (2)

| id | nombre | ref. | temas que lo usan | ids fusionados |
|---|---|---|---|---|
| `doom-loop` | Círculo vicioso deuda soberana-deuda bancaria | **4.A.20** | 4.A.18 r, 4.A.20 r | — |
| `descomposicion-pib-per-capita` | Descomposición contable de la renta per cápita | **4.A.29** | 4.A.17 D, 4.A.29 D | pib-per-capita-descomposicion |

`*` = tema sin fuente (el inventario recoge lo que debería tratar).

Modelos de otras áreas que se usan aquí: `arancel-optimo` (ref. 3.B.7), `areas-monetarias-optimas` (ref. 3.B.16), `barro-1990` (ref. 3.A.38), `baumol-enfermedad-costes` (ref. 4.B.5), `brander-spencer` (ref. 3.B.8), `centro-periferia` (ref. 3.B.6), `coase` (ref. 3.A.23), `competencia-perfecta-equilibrio-parcial` (ref. 3.A.16), `contabilidad-crecimiento` (ref. 3.A.45), `convergencia-beta-sigma` (ref. 3.A.45), `curva-lorenz` (ref. 4.B.3), `diamond-dybvig` (ref. 3.B.26), `difusion-tecnologica` (ref. 3.B.9), `dilema-prisionero` (ref. 3.A.14), `efectos-no-keynesianos` (ref. 4.B.4), `estancamiento-secular` (ref. 3.A.40), `gravedad` (ref. 3.B.10), `histeresis` (ref. 3.A.28), `identidad-balanza-pagos` (ref. 3.B.11), `incidencia-equilibrio-parcial` (ref. 4.B.8), `indices-precios` (ref. 3.A.9), `ineficiencia-x` (ref. 3.A.12), `input-output` (ref. 3.A.30), `lewis` (ref. 3.B.28), `melitz` (ref. 3.B.6), `monopolio-natural` (ref. 3.A.17), `multiplicadores-fiscales` (ref. 4.B.4), `pigou` (ref. 3.A.23), `prebisch-singer` (ref. 3.B.9), `price-cap` (ref. 3.A.17), `rbc` (ref. 3.A.42), `rct` (ref. 4.B.6), `romer-1990` (ref. 3.A.44), `separacion-vertical` (ref. 4.B.15), `solow` (ref. 3.A.43), `stiglitz-weiss` (ref. 3.A.13), `subastas` (ref. 3.A.14), `teoremas-bienestar` (ref. 3.A.22), `tipo-cambio-real` (ref. 3.B.13), `uzawa-lucas` (ref. 3.A.44)


### Notación

**Un concepto, varios símbolos** (entre temas del área):

- exportaciones/importaciones: `M` (4.A.1); `IE` (4.A.13); `X` (4.A.13); `X_i, M_i` (4.A.22); `β_i` (4.A.22); `X_i` (4.A.22); `M_i` (4.A.22)
- inversión: `I_NAC` (4.A.21); `ID / IDE / IED` (4.A.23); `IC` (4.A.23)
- población (crecimiento): `POB` (4.A.17); `L` (4.A.29); `A` (4.A.29); `N` (4.A.29)
- producción / renta agregada: `X` (4.A.1); `Y` (4.A.17)
- renta (del consumidor): `y` (4.A.17); `RNDB` (4.A.21); `Y` (4.A.29)

**Un símbolo, varios significados** (entre temas del área; se omiten los que solo cambian de redacción):

- `A`: cuota de amortizacion lineal (4.A.20); cuota de amortizacion (4.A.20); población (crecimiento) (4.A.29); activos (4.A.29)
- `X`: producción / renta agregada (4.A.1); factor de eficiencia (4.A.12); exportaciones/importaciones (4.A.13)
- `L`: numero de ocupados (4.A.17); ocupados (4.A.17, 4.A.29); población (crecimiento) (4.A.29)
- `Y`: producción / renta agregada (4.A.17); renta (del consumidor) (4.A.29)

**Notación de los modelos compartidos que cambia de un tema a otro:**

- `descomposicion-pib-per-capita` · poblacion: `POB` (4.A.17); `N` (4.A.29)
- `diamond-dybvig` · consumo: `c` (3.A.10); `c_1, c_2` (4.A.20)
- `teoremas-bienestar` · dotacion: `e` (3.A.22); `e, e'` (4.B.3)

**Incoherencias internas** (dentro de cada tema):

- 4.A.1: La EPF se describe como «trimestral» en el título y «anual» en el texto.
- 4.A.1: El IPC se presenta como índice de Laspeyres de base fija (fórmula con w_{i0}) y a la vez como encadenado con ponderaciones anuales.
- 4.A.1: Se dice que la EPA, al no considerar la economía sumergida, sobreestima la tasa de paro, pero la nota matiza que no sobreestima el número de parados: conviene unificar.
- 4.A.1: Ministerios citados con nombres de distintas legislaturas (MINECO, Ministerio de Asuntos Económicos y Transformación Digital, Ministerio de Empleo y Seguridad Social, Ministerio de Fomento).
- 4.A.11: El apartado «Evolución histórica» de la política repite literalmente la «Justificación de teoría económica».
- 4.A.11: La evolución de precios (1960-2007) aparece dos veces: en el subsector de edificación y en el análisis dinámico (el propio documento lo señala).
- 4.A.11: Mezcla de cifras de años distintos (DIRCE 2017, internacionalización 2016, VAB/empleo 2022, vivienda vacía 2023).
- 4.A.11: Las medidas del RDL de alquiler 2019 descritas son las de la propuesta de 2018 no convalidada (nota interna).
- 4.A.12: Fechas de la liberalización de telecomunicaciones contradictorias: la «Ley de Telecomunicaciones de 1997» crea la CMT y la «Ley General de Telecomunicaciones de 1998» establece las reglas; en otro punto «Ley de Liberalización de las Telecomunicaciones 1997» (en realidad Ley 12/1997 y LGT 11/1998).
- 4.A.12: En transporte de viajeros se dice que domina la carretera (90 %) y luego que en pasajeros domina «la carretera y de forma similar el aéreo».
- 4.A.12: El conflicto taxi-VTC se trata como «arrendamiento de vehículos con conductor (i.e. taxis)», confundiendo VTC y taxi.
- 4.A.12: Años de referencia distintos: VAB transporte 2019, telecomunicaciones 2021, tráfico 2018.
- 4.A.13: Los datos de llegadas de pasajeros y aeropuertos usan cifras distintas que en 4.A.12 (≈200 millones vs 264 millones de pasajeros).
- 4.A.13: La política turística aparece dos veces: en «Política turística en España» y en «Otras consideraciones recientes» (PRTR), sin integrar.
- 4.A.13: El apartado «Evolución histórica» de la política está vacío, pero la evolución de la política se cuenta dentro de la perspectiva dinámica del sector.
- 4.A.14: El enganche y la contextualización son genéricos del sector servicios (texto compartido con 4.A.11-4.A.13), no de la distribución comercial.
- 4.A.14: Fechas de datos heterogéneas: DIRCE 2018, VAB por ramas 2020, VAB/empleo 2022, Kantar 2023, BBVA 2018.
- 4.A.14: «Poder de negociación de los mayoristas»: el texto describe en realidad el poder de la gran distribución (minorista concentrada) frente a productores.
- 4.A.15: Afirma que los reguladores financieros fuera de la CNMC son BdE, «el regulador de valores (CNMC)» y DGSFP: debe decir CNMV.
- 4.A.15: El Consejo de la CNMC se describe con 10 miembros (presidente, vicepresidente y 8 consejeros), pero el Anexo habla de pasar «a únicamente 9 consejeros» y de que el Gobierno selecciona a «los 9 consejeros».
- 4.A.15: La política de competencia se presenta como competencia exclusiva de la UE (art. 3 TFUE) y a la vez se hace depender la aplicación de la ANC: precisar que la exclusiva es el establecimiento de normas para el mercado interior.
- 4.A.15: Atribuye el origen de la autoridad de competencia al Tribunal de Defensa de la Competencia de 1964 (nota 12) y en el texto a la LDC de 1989.
- 4.A.16: Dos numeraciones paralelas de los problemas: los encabezados dicen «Primer…Noveno factor estructural» pero el texto los llama «2.º, 7.º, 12.º, 13.º, 14.º, 15.º problema estructural», y la tabla resumen lista otro orden.
- 4.A.16: Tasa de actividad definida como activos/(población 16-64) con 59,41 %; la tasa de actividad EPA usa población de 16 y más años (la de 16-64 ronda el 75 %).
- 4.A.16: Datos de comparación entre paréntesis rotulados «abril de 2019» mientras la EPA es trimestral.
- 4.A.16: El apartado I «no aplica» pese a que el título pide «características»; las características se describen en los factores estructurales.
- 4.A.17: En la regresión de β-convergencia dice que «la variable dependiente sea el crecimiento … y la variable dependiente sea el PIB per cápita»: la segunda es la variable independiente.
- 4.A.17: Llama «tasa de ocupación» a L/POB (ocupados/población total); en 4.A.16 y en la EPA la tasa de empleo/ocupación se refiere a la población de 16 y más años.
- 4.A.17: Datos de PIB per cápita regional mezclan 2017, 2020 y valores redondeados distintos para Madrid (32.332 € y 32.000 €) y Canarias (17.199 € y 17.000 €).
- 4.A.17: Comparación con la UE usa UE-28 (dato anterior al Brexit) junto a datos de 2020-2023.
- 4.A.17: Frase truncada: «contribuirían a la convergencia-inmovilidad del factor trabajo».
- 4.A.18: La crisis financiera internacional se sitúa en «verano de 2007» y el título habla de crisis «iniciada en 2008»: conviene fijar el criterio común con 4.A.28 y 3.B.26.
- 4.A.19: La estructura de la introducción enumera 4 apartados (interbancario, deuda anotada, renta variable…) distintos de los que luego se desarrollan (renta fija privada, derivados, divisas).
- 4.A.20: La letra r se usa con significados distintos en cada modelo (\hat r tipo del préstamo en Stiglitz-Weiss; r_1, r_2 rendimientos del activo y r^d del depósito en Diamond-Dybvig): aceptable pero conviene avisarlo.
- 4.A.20: El propio documento advierte que el apartado V (Intervención pública) se solapa con el IV («intentar coordinar este apartado con el anterior»): Ley 5/2015 y MAB/MARF aparecen dos veces.
- 4.A.20: Clasificación de mercados duplicada (II.3 y en 4A19 antiguo).
- 4.A.21: La sección 2.5 dice que el déficit de bienes pasa «desde un 9 % en 2008 a un déficit del 2 % en 2019»; el resumen previo habla de déficit récord «de casi el 10 % en 2007» y 4.A.22 (antiguo 4.A.25) da «superávit del 2,1 % en 2017». Cifras incompatibles entre temas.
- 4.A.21: La PII se describe como «variable stock» y como «suma de las cuentas financieras»; en otro punto se dice que la capacidad de financiación «aumenta la PII» y la necesidad la «reduce», cuando la PII es negativa (deudora): conviene hablar de PII neta y de posición deudora.
- 4.A.21: «Posición Inversora Internacional» y «Posición de Inversión Internacional» se usan indistintamente.
- 4.A.21: Subepígrafes vacíos: «Cuenta de capital» y «Desglose desde la óptica ahorro-inversión» en 2.5; «Relevancia» y «Opinión» de la conclusión vacíos.
- 4.A.21: Nota de autor sin limpiar al inicio («Este tema faltaría coordinarlo con los de Juan Luis…») y viñetas marcadas en amarillo ({.mark}).
- 4.A.22: Evolución de la balanza de bienes: «superávit del 2,1 % en 2017» y, en el epígrafe siguiente, «déficit de bienes del 0,7 % del PIB en 2017» (y 4.A.21 da déficit del 2 % en 2019). El saldo de bienes nunca fue superavitario en 2017.
- 4.A.22: Grado de apertura: 47,8 % en 2020 y 54,54 % en 2021 en dos rasgos distintos, sin explicar el salto; el bloque histórico (duplicado) lo sitúa en el 60 % en 2007.
- 4.A.22: Turismo: «récord de turistas en 2019 con 84 millones de euros» (son turistas, no euros); Reino Unido «~20 %» de los turistas y, en Brexit, «25 %» de 80 millones en 2018.
- 4.A.22: Rasgos de la balanza comercial repetidos (comercio intraindustrial y concentración geográfica aparecen dos veces seguidas).
- 4.A.22: Subepígrafes vacíos: «Saldo comercial» sectorial, «Número de empresas exportadoras», «Alimentación, bebidas y tabaco» en importaciones.
- 4.A.22: Mezcla de años: bienes 2022, servicios 2019, competitividad 1T2019.
- 4.A.23: El apartado «Balanza de Pagos (2022)» describe en realidad 2021 (CF del BdE con superávit del 1,3 % frente al déficit del 7,2 % de 2020; «las entradas de capital se normalizaron en 2021»), mientras 4.A.21 da para 2022 un saldo de la CF del BdE del 2,5 % y de la CF excl. BdE del −0,7 %.
- 4.A.23: IED, IDE e ID se usan indistintamente; «inversión bruta extranjera productiva emitida en 2022» para la inversión española en el exterior (debería ser inversión española emitida).
- 4.A.23: Años mezclados: flujos 2022, stocks 2020, flujos por destino 2021, Brexit con datos de 2016.
- 4.A.23: «Se debió a las sociedades no financieras (28,7 % del PIB)» en la IDE emitida: porcentaje del PIB incompatible con flujos de 8.752 M€.
- 4.A.23: Notas de autor sin limpiar («Tema corto, alargarse», «Llegar aquí pronto, lo de antes es un poco echarle cara») y bloques en amarillo ({.mark}).
- 4.A.23: El Plan de Estabilización se describe dos veces (bloque copiado de 4.A.21 y en la evolución de la IED).
- 4.A.24: COFIDES, FIEM, CESCE e ICEX se describen tres veces (órganos competentes, instrumentos de financiación, instrumentos financieros) con nota «Coordinar este apartado con lo anterior».
- 4.A.24: El bloque IV duplica la Estrategia PASE ya expuesta en III.3, con nota «Coordinar con lo del apartado anterior».
- 4.A.24: Cuota de exportaciones: ~2 % estable (I.3) vs. 2,2 % (2003) → 1,6 % (2012) → 1,8 % (2018) (III.5).
- 4.A.24: Retorno de la promoción: 1 $ → 40 $ (nota 3, Banco Mundial) vs. 1 $ → 15 $ (III.5).
- 4.A.24: La Estrategia PASE «complementa la estrategia PASE» (definición circular).
- 4.A.24: Póliza «1 millón ICEX-CESCE» (nombre dudoso; la póliza conocida es la «Póliza 100» / «Póliza Pyme»).
- 4.A.24: Peso intracomunitario de las exportaciones: 61,8 % (I.3) vs. 63 % (III.5).
- 4.A.25: El bloque IV duplica la Estrategia PASE ya expuesta en III.3.
- 4.A.25: Retorno de la promoción: 1 $ → 40 $ (nota 3) vs. 1 $ → 15 $ (III.5).
- 4.A.25: Planes Integrales de Desarrollo de Mercados «siguen vigentes los de 2015» junto a PASE 2023-2024 (dos marcos solapados).
- 4.A.25: Publicación «El Exportador» (hasta 2023) y datos de 2016-2019 conviven sin actualizar.
- 4.A.27: Crecimiento de 1959: -4 % (II.3) vs. -4,4 % (III).
- 4.A.27: Ayuda exterior al Plan: 546 M$ (II.2) vs. 554 M$ (II.2 y preguntas).
- 4.A.27: Crecimiento 1960-1975: 7 % en el texto vs. «cercana al 6 %» (Prados de la Escosura, en preguntas).
- 4.A.27: Párrafo inicial de I en inglés (Prados de la Escosura).
- 4.A.27: La liberalización de importaciones (55 %) se repite en dos apartados de II.2.
- 4.A.27: El bloque «Debilidades en la industria» incluye coeficientes de inversión obligatoria de la banca y dualidad, que no son de la industria (marcados en amarillo).
- 4.A.28: «Década maravillosa» se aplica a 2000-2008 aquí y a 1960-1973 en la introducción (y en 4.A.27).
- 4.A.28: Introducción y «pasivos del crecimiento» copiados literalmente del antiguo 4.A.27.
- 4.A.28: Rescate: «60.000 millones» (II.2) vs. «~40.000 millones» concedidos.
- 4.A.28: «Euro en 2002» como criterio de Maastricht (es la circulación de billetes; el euro nace en 1999).
- 4.A.28: Paro máximo 24,1 % en 1994 «sólo superado en la reciente crisis» y 26,1 % sin año.
- 4.A.28: Peso de las exportaciones a Reino Unido: 8 % (Brexit en 4.A.23 antiguo) vs. 6,5 % aquí.
- 4.A.28: Política de vivienda llamada «PITVI 2018-2021» (el PITVI era 2012-2024; el plan es el Plan Estatal de Vivienda 2018-2021).
- 4.A.28: Sección II se titula «hasta la crisis del Covid-19» pero el apartado es «2008-Actualidad».
- 4.A.29: En la descomposición del PIB pc, A/N se llama «tasa de actividad» en la fórmula pero «porcentaje de población en edad de trabajar (P. Activa/P. Total)» en el texto.
- 4.A.29: Tasa de actividad definida como activos/(población 16-64), distinta de la definición del INE (activos/población de 16 y más) que da el 58,97 % citado.
- 4.A.29: Epígrafe «EPA: Tercer trimestre de 2022» pero los datos son de T2 2023 (comparados con «abril 2019»).
- 4.A.29: Saldo exterior 2020: 1,2 % del PIB en un apartado y 0,8 % en otro.
- 4.A.29: Datos de convergencia de 2018 junto a 2022-2023 sin actualizar (nota: «Para actualizar a 2021 ver Juan Luis»).
- 4.A.29: Apartado «¿De dónde venimos?» vacío; conclusión con relevancia/extensiones/opinión vacías; anexo vacío.
- 4.A.30: Atribuye la reforma del art. 135 CE (sept. 2011) al Fiscal Compact, que es posterior (TECG, marzo 2012); la reforma respondió al Pacto por el Euro Plus y a la presión de los mercados/BCE.
- 4.A.30: Datos de déficit y deuda de 2018 y del Brexit de 2016-2019 sin actualizar.
- 4.A.30: Cuadro de «Estructura» de la introducción vacío; conclusión con relevancia/extensiones/opinión vacías; anexo 2 vacío; «[Política monetaria]» marcado como pendiente.

### Modelos desarrollados en varios temas o contados de forma distinta

- `descomposicion-pib-per-capita` (ref. 4.A.29; desarrollo en 4.A.17, 4.A.29).
  - 4.A.17 [D] «Descomposición del PIB per cápita en productividad aparente y tasa de » (1 ec., 0 gráf.; para: Explicar los desequilibrios regionales y los factores de la convergenc)
  - 4.A.29 [D] «Descomposición contable de la renta per cápita» (1 ec., 1 gráf.; para: Explicar qué haría falta para cerrar la brecha de convergencia real co)
- `convergencia-beta-sigma` (ref. 3.A.45; desarrollo en 3.A.45, 3.B.40, 4.A.17).
  - 3.A.45 [D] «Convergencia β y σ (Barro y Sala-i-Martín)» (2 ec., 1 gráf.; para: Evidencia sobre convergencia.)
  - 3.B.40 [D] «β- y σ-convergencia (Sala-i-Martin)» (2 ec., 1 gráf.; para: proceso de convergencia real)
  - 4.A.17 [D] «Convergencia β y σ (Sala-i-Martín 1990)» (3 ec., 3 gráf.; para: Medir la convergencia real entre CCAA desde 1955)
- `diamond-dybvig` (ref. 3.B.26; desarrollo en 3.B.27, 4.A.20).
  - 3.A.10 [m] «Modelo de Diamond y Dybvig (1983)» (0 ec., 0 gráf.; para: Aplicación (anexo 3): bancos como seguro de liquidez y pánicos)
  - 3.B.17 [r] «Pánicos bancarios (Diamond y Dybvig, 1983)» (0 ec., 0 gráf.; para: anexo: pánico bancario en crisis gemelas)
  - 3.B.27 [D] «Diamond y Dybvig (1983)» (1 ec., 4 gráf.; para: equilibrios múltiples y pánicos bancarios)
  - 4.A.20 [D] «Pánicos bancarios (Diamond y Dybvig, 1983)» (4 ec., 4 gráf.; para: mostrar la inestabilidad inherente de los bancos como argumento a favo)
- `stiglitz-weiss` (ref. 3.A.13; desarrollo en 3.B.27, 4.A.20).
  - 3.A.7 [m] «Racionamiento del crédito (Stiglitz-Weiss 1981)» (0 ec., 0 gráf.; para: imperfecciones del mercado de crédito)
  - 3.A.13 [r] «Racionamiento del crédito (Stiglitz y Weiss, 1981)» (0 ec., 2 gráf.; para: selección adversa y riesgo moral simultáneos en el mercado de crédito)
  - 3.B.27 [D] «Racionamiento del crédito (Stiglitz y Weiss, 1981)» (2 ec., 2 gráf.; para: selección adversa en el crédito)
  - 3.B.28 [m] «Racionamiento del crédito (Stiglitz y Weiss, 1981)» (0 ec., 0 gráf.; para: Mercado de crédito en países en desarrollo.)
  - 4.A.20 [D] «Racionamiento del crédito con información asimétrica (Stiglitz y Weiss» (2 ec., 2 gráf.; para: justificar por qué conviene reducir la dependencia de la financiación )
  - 4.A.24 [m] «Información asimétrica y racionamiento del crédito a la exportación» (0 ec., 0 gráf.; para: justificar la intervención financiera pública (fallo de mercado))
  - 4.A.25 [m] «Información asimétrica y racionamiento del crédito a la exportación» (0 ec., 0 gráf.; para: justificar la intervención financiera pública (fallo de mercado))
- `tipo-cambio-real` (ref. 3.B.13; desarrollo en 3.B.13, 4.A.22).
  - 3.B.13 [D] «Tipos de cambio nominal y real, bilateral y efectivo» (2 ec., 0 gráf.; para: convenciones)
  - 4.A.22 [D] «Tipo de cambio efectivo real / Índice de Tendencia de Competitividad» (4 ec., 1 gráf.; para: medir la competitividad-precio ex ante de España frente a UEM, UE, OCD)

**Bloques repetidos o copiados entre temas** (según las observaciones de los inventarios):

- 4.A.12: Financiación de infraestructuras y PITVI duplicados con 4.A.11.
- 4.A.18: Bloque «Introducción al sistema financiero español» (definición y 3 funciones, regulación vs supervisión, twin peaks vs enfoque sectorial, rasgos, modelo continental, peso de la financiación no bancaria) repetido casi literalmente en 4.A.18, 4.A.19 y 4.A.20.
- 4.A.19: Bloque «Introducción al sistema financiero español» (definición y 3 funciones, regulación vs supervisión, twin peaks vs enfoque sectorial, rasgos, modelo continental, peso de la financiación no bancaria) repetido casi literalmente en 4.A.18, 4.A.19 y 4.A.20.
- 4.A.20: Bloque «Introducción al sistema financiero español» (definición y 3 funciones, regulación vs supervisión, twin peaks vs enfoque sectorial, rasgos, modelo continental, peso de la financiación no bancaria) repetido casi literalmente en 4.A.18, 4.A.19 y 4.A.20.
- 4.A.20: Renta fija privada, AIAF, MARF y bonos verdes se repiten casi literalmente con 4A19 antiguo.
- 4.A.21: El bloque «Breve introducción a la BP» y la evolución histórica 1939-2019 están copiados casi literalmente en el antiguo 4.A.25 (nuevo 4.A.22) y el bloque de introducción también en el antiguo 4.A.26 (nuevo 4.A.23).
- 4.A.22: Contenido compartido con 4.A.21: bloques 1 y 2 copiados literalmente (deben eliminarse y remitir a 4.A.21).
- 4.A.22: Además está en el bloque histórico duplicado de 4.A.21.
- 4.A.23: Introducción a la BP duplicada con 4.A.21 y 4.A.22.
- 4.A.27: Los «pasivos del crecimiento» están duplicados literalmente en 4A28.docx.

## sector-publico (4.B)

Temas: 4.B.1 (si), 4.B.2 (si), 4.B.3 (renumerado), 4.B.4 (renumerado), 4.B.5 (renumerado), 4.B.6 (renumerado), 4.B.7 (renumerado), 4.B.8 (renumerado), 4.B.9 (renumerado), 4.B.10 (renumerado), 4.B.11 (renumerado), 4.B.12 (renumerado), 4.B.13 (renumerado), 4.B.14 (no), 4.B.15 (renumerado), 4.B.16 (no), 4.B.17 (no), 4.B.18 (otro-titulo), 4.B.19 (no), 4.B.20 (no), 4.B.21 (renumerado), 4.B.22 (renumerado), 4.B.23 (no), 4.B.24 (no), 4.B.25 (no), 4.B.26 (renumerado)


### Modelos compartidos (69)

| id | nombre | ref. | temas que lo usan | ids fusionados |
|---|---|---|---|---|
| `sec-2010` | Sistema Europeo de Cuentas 2010 (Reglamento UE 549/2013) | **4.B.1** | 4.B.1 D, 4.B.5 r, 4.B.7 r, 4.B.22 r, 4.B.23 D* | — |
| `buchanan-tullock-mayoria-optima` | Mayoría óptima de Buchanan y Tullock | **4.B.2** | 3.A.24 r, 4.B.2 D | wicksell-unanimidad |
| `captura-regulador` | Teoría de la captura del regulador (Stigler, 1971) | **4.B.2** | 4.B.2 r, 4.B.15 m | captura-stigler |
| `ciclo-politico-nordhaus` | Ciclo político-económico de Nordhaus | **4.B.2** | 4.B.2 D, 4.B.5 r, 4.B.11 m | — |
| `constitucion-fiscal` | Constitución fiscal (Hayek, Buchanan) y reglas fiscales | **4.B.2** | 4.B.2 D, 4.B.5 m | — |
| `downs-hotelling` | Modelo de competencia electoral de Downs-Hotelling | **4.B.2** | 3.A.18 m, 3.A.24 m, 4.B.2 D | downs |
| `ilusion-fiscal` | Ilusión fiscal (Buchanan) e ilusión de deuda | **4.B.2** | 4.B.2 r, 4.B.5 r | — |
| `niskanen` | Modelo de burocracia maximizadora del presupuesto de Niskanen (1971) | **4.B.2** | 3.A.23 m, 3.A.24 m, 4.B.2 D, 4.B.5 D | — |
| `paradoja-condorcet` | Paradoja de Condorcet y manipulación de agenda | **4.B.2** | 3.A.24 D, 4.B.2 D | — |
| `rent-seeking-tullock` | Búsqueda de rentas (Tullock, Krueger) | **4.B.2** | 4.B.2 r, 4.B.5 m | busqueda-rentas |
| `votante-mediano` | Preferencias unimodales de Black y teorema del votante mediano | **4.B.2** | 3.A.24 r, 4.B.2 D, 4.B.5 r | — |
| `curva-lorenz` | Curva de Lorenz antes y después de impuestos | **4.B.3** | 4.A.3 p, 4.B.3 r | lorenz |
| `reynolds-smolensky` | Índice de Reynolds-Smolensky | **4.B.3** | 4.B.3 m, 4.B.9 m | — |
| `efectos-no-keynesianos` | Efectos no keynesianos de la política fiscal (Giavazzi-Pagano, Alesina) | **4.B.4** | 4.A.28 m, 4.B.4 r, 4.B.26 m | consolidacion-no-keynesiana |
| `estabilizadores-automaticos` | Estabilizadores automáticos: elasticidad renta de la recaudación y del gasto en desempleo | **4.B.4** | 4.B.4 D, 4.B.7 D | elasticidad-recaudacion |
| `multiplicadores-fiscales` | Multiplicadores fiscales | **4.B.4** | 3.A.38 D, 4.A.11 m, 4.B.4 D | multiplicador-fiscal, multiplicador-keynesiano |
| `rbc-sims` | Modelo de ciclo real con gasto público (Sims 2015; Baxter-King 1993) | **4.B.4** | 3.A.38 D, 4.B.4 D | rbc-politica-fiscal |
| `saldo-estructural` | Descomposición del saldo: cíclico, cíclicamente ajustado y estructural (método indirecto de la Comisión Europea) | **4.B.4** | 4.B.1 m, 4.B.4 D | saldos-presupuestarios |
| `baumol-enfermedad-costes` | Enfermedad de los costes de Baumol (1967) | **4.B.5** | 4.A.17 m, 4.B.5 D | baumol-cost-disease |
| `indicadores-tamano-sector-publico` | Indicadores de tamaño: G/PIB, presión fiscal, esfuerzo fiscal (índice de Frank), carga fiscal, empleo público, déficit y deuda | **4.B.5** | 4.B.1 D, 4.B.5 D | — |
| `leviatan-brennan-buchanan` | Descentralización y gasto (Buchanan y Oates, 1980; Leviatán) | **4.B.5** | 4.B.2 r, 4.B.5 m | — |
| `tamano-optimo-sector-publico` | Tamaño óptimo: igualación CMg social = BMg social | **4.B.5** | 4.B.1 r, 4.B.5 r | tamano-optimo-cmgs-bmgs |
| `rct` | Experimentos aleatorizados (Duflo, Banerjee, Kremer) y cuasi-naturales (Card y Krueger) | **4.B.6** | 3.A.1 r, 4.A.26 p, 4.B.6 p | evaluacion-impacto |
| `impuesto-suma-fija` | Impuesto de suma fija (poll tax de Thatcher) | **4.B.7** | 4.B.7 r, 4.B.9 r | — |
| `harberger-incidencia` | Modelo bisectorial de Harberger (1962) | **4.B.8** | 4.B.8 D, 4.B.9 r | — |
| `incidencia-equilibrio-parcial` | Incidencia impositiva en equilibrio parcial | **4.B.8** | 3.A.16 D, 4.A.11 m, 4.B.8 D, 4.B.13 m | dalton-ley, incidencia-impositiva, incidencia-impuesto-parcial, incidencia-subsidio |
| `efecto-renta-sustitucion-impuesto` | Efecto renta y efecto sustitución de los impuestos en un modelo 1×2×2×2 (1 consumidor con ocio, 2 bienes, 2 empresas, 2 factores) | **4.B.9** | 4.B.9 D, 4.B.10 D | — |
| `exceso-gravamen` | Exceso de gravamen (concepto y medición en equilibrio parcial) | **4.B.9** | 4.B.7 r, 4.B.8 m, 4.B.9 D, 4.B.11 D | exceso-gravamen-sistema, exceso-gravamen-subsidio, triangulo-harberger |
| `progresividad` | Medidas de progresividad local (elasticidad de la cuota, tipo medio y marginal) | **4.B.9** | 4.B.3 r, 4.B.4 r, 4.B.7 r, 4.B.9 m, 4.B.12 r, 4.B.16 D* | progresividad-elasticidad, progresividad-local |
| `corlett-hague` | Regla de Corlett-Hague (1953) | **4.B.11** | 4.B.7 m, 4.B.9 m, 4.B.11 D, 4.B.13 r | — |
| `elasticidad-inversa` | Regla de la elasticidad inversa («regla de Pigou») | **4.B.11** | 4.B.11 D, 4.B.13 m | — |
| `ramsey` | Regla de Ramsey (imposición óptima de bienes) | **4.B.11** | 4.B.11 D, 4.B.13 m | — |
| `competencia-fiscal` | Competencia fiscal como dilema del prisionero | **4.B.12** | 4.B.12 m, 4.B.18 m | competencia-fiscal-dilema-prisionero |
| `sec-2010-impuestos` | Clasificación de impuestos en el SEC-2010 | **4.B.12** | 4.B.12 r, 4.B.13 r | — |
| `armonizacion-fiscal-ue` | Armonización de la imposición indirecta en la UE (1967/1977, Cockfield 1987, régimen transitorio 1993, tipos mínimos, IIEE 1992 y 2003) | **4.B.13** | 4.B.13 r, 4.B.18 D, 4.B.20 D* | — |
| `itf` | Impuesto sobre transacciones financieras (ITF, 0,2 %) | **4.B.13** | 4.B.13 r, 4.B.18 m | impuesto-transacciones-financieras |
| `financiacion-autonomica` | financiacion-autonomica | **4.B.14** | 4.B.14 D*, 4.B.25 D* | — |
| `musgrave-funciones` | musgrave-funciones | **4.B.14** | 4.B.1 m, 4.B.5 m, 4.B.14 D* | funciones-musgrave |
| `oates-descentralizacion` | oates-descentralizacion | **4.B.14** | 4.B.14 D*, 4.B.25 D* | — |
| `restriccion-presupuestaria-blanda` | restriccion-presupuestaria-blanda | **4.B.14** | 4.B.14 D*, 4.B.15 m | — |
| `tiebout` | tiebout | **4.B.14** | 4.B.2 m, 4.B.14 D*, 4.B.25 D* | — |
| `separacion-vertical` | Liberalización y privatización de industrias red (acceso regulado, separación vertical, club, partes recíprocas) | **4.B.15** | 4.A.12 r, 4.A.28 r, 4.B.15 D | costes-transicion-competencia, industrias-red |
| `yardstick` | Competencia por comparación (Shleifer, 1985) y mecanismo de Loeb-Magat | **4.B.15** | 3.A.17 m, 4.B.15 m | yardstick-competition |
| `impuesto-dual` | impuesto-dual | **4.B.16** | 4.B.12 r, 4.B.16 D* | — |
| `irpf` | irpf | **4.B.16** | 4.B.7 m, 4.B.10 m, 4.B.12 D, 4.B.16 D* | — |
| `impuesto-sociedades` | impuesto-sociedades | **4.B.17** | 4.B.7 m, 4.B.10 r, 4.B.12 D, 4.B.17 D* | — |
| `beps` | Erosión de bases imponibles y traslado de beneficios (BEPS, ATAD) | **4.B.18** | 4.B.12 m, 4.B.18 m | — |
| `impuesto-servicios-digitales` | Impuesto sobre Determinados Servicios Digitales (España, 2021) | **4.B.18** | 4.B.13 r, 4.B.18 r | — |
| `pilares-ocde` | Acuerdo OCDE/G-20 de dos pilares (2021): reasignación y tipo mínimo global | **4.B.18** | 4.B.17 D*, 4.B.18 m | pilar-1-2-ocde, pilar-2, tipo-minimo-global |
| `ibi` | ibi | **4.B.19** | 4.B.7 m, 4.B.12 r, 4.B.19 D* | — |
| `impuesto-patrimonio` | impuesto-patrimonio | **4.B.19** | 4.B.12 D, 4.B.19 D* | — |
| `isd` | isd | **4.B.19** | 4.B.12 r, 4.B.19 D* | — |
| `itpajd` | itpajd | **4.B.19** | 4.B.13 m, 4.B.19 D* | — |
| `impuestos-especiales` | impuestos-especiales | **4.B.20** | 4.B.13 D, 4.B.18 r, 4.B.20 D* | — |
| `iva` | Impuesto sobre el valor añadido (IVA) | **4.B.20** | 4.B.7 m, 4.B.13 D, 4.B.18 r, 4.B.20 D* | iva-calculo-adicion-sustraccion, iva-tipo-consumo-renta-producto, tipos-reducidos-iva |
| `airef` | AIReF (2013-2014) | **4.B.21** | 4.B.21 r, 4.B.22 r | — |
| `control-presupuestario` | Control interno (IGAE) y externo (Tribunal de Cuentas, Cortes, judicial) | **4.B.21** | 4.B.21 D, 4.B.22 r | — |
| `loepsf` | Reforma del art. 135 CE (2011) | **4.B.21** | 4.B.2 r, 4.B.4 m, 4.B.5 m, 4.B.21 D, 4.B.22 r, 4.B.25 D*, 4.B.26 r | constitucion-art-135 |
| `regla-gasto` | Regla de gasto nacional (art. 12 LOEPSF) | **4.B.21** | 4.B.2 m, 4.B.21 D, 4.B.22 r | — |
| `clasificaciones-presupuestarias` | Clasificación orgánica, económica (capítulos I-IX) y funcional/por programas (4 áreas, 27 políticas, 400 programas) | **4.B.22** | 4.B.5 r, 4.B.21 r, 4.B.22 D | clasificaciones-pge |
| `pge` | Presupuestos Generales del Estado consolidados 2023: grandes cifras | **4.B.22** | 4.B.21 D, 4.B.22 D | — |
| `cofog` | cofog | **4.B.23** | 4.B.5 r, 4.B.22 D, 4.B.23 D* | — |
| `efp` | efp | **4.B.23** | 4.B.1 r, 4.B.5 r, 4.B.7 r, 4.B.22 r, 4.B.23 D* | — |
| `presion-fiscal` | presion-fiscal | **4.B.23** | 4.B.7 m, 4.B.23 D* | — |
| `programa-estabilidad` | programa-estabilidad | **4.B.23** | 4.B.21 m, 4.B.22 r, 4.B.23 D*, 4.B.26 r | — |
| `ingreso-minimo-vital` | ingreso-minimo-vital | **4.B.24** | 4.B.3 r, 4.B.24 D* | — |
| `pensiones` | pensiones | **4.B.24** | 4.B.3 r, 4.B.24 D* | — |
| `fla-ffpp` | fla-ffpp | **4.B.25** | 4.B.21 m, 4.B.25 D*, 4.B.26 m | — |
| `consolidacion-fiscal-espana` | Evolución del saldo y procesos de consolidación en España (1975-2023) | **4.B.26** | 4.B.22 r, 4.B.26 D | — |

`*` = tema sin fuente (el inventario recoge lo que debería tratar).

Modelos de otras áreas que se usan aquí: `arancel-exterior-comun` (ref. 3.B.41), `arrow-imposibilidad` (ref. 3.A.24), `atkinson-indice` (ref. 3.A.24), `averch-johnson` (ref. 3.A.17), `barro-1990` (ref. 3.A.38), `borda` (ref. 3.A.24), `cbam` (ref. 3.B.37), `clarke-groves` (ref. 3.A.23), `egc` (ref. 3.A.21), `equilibrio-general-walras` (ref. 3.A.21), `equivalencia-ricardiana` (ref. 3.A.39), `estancamiento-secular` (ref. 3.A.40), `excedentes-bienestar` (ref. 3.A.16), `fbs-rawlsiana` (ref. 3.A.24), `fisher-intertemporal` (ref. 3.A.33), `funcion-bienestar-social` (ref. 3.A.24), `gibbard-satterthwaite` (ref. 3.A.24), `ineficiencia-x` (ref. 3.A.12), `is-lm` (ref. 3.A.5), `jorgenson` (ref. 3.A.34), `laffont-tirole` (ref. 3.A.17), `mede` (ref. 3.B.45), `mercados-impugnables` (ref. 3.A.19), `modigliani-miller` (ref. 3.B.3), `monopolio-natural` (ref. 3.A.17), `mundell-fleming` (ref. 3.B.15), `nek-3-ecuaciones` (ref. 3.A.7), `next-generation-eu` (ref. 3.B.37), `oferta-trabajo` (ref. 3.A.25), `olg-samuelson-diamond` (ref. 3.A.29), `pec` (ref. 3.B.45), `pigou` (ref. 3.A.23), `precios-hedonicos` (ref. 3.A.8), `price-cap` (ref. 3.A.17), `ramsey-boiteux` (ref. 3.A.17), `recursos-propios-ue` (ref. 3.B.37), `regla-friedman` (ref. 3.A.41), `restriccion-gobierno` (ref. 3.A.39), `samuelson-bienes-publicos` (ref. 3.A.23), `second-best` (ref. 3.A.22), `semestre-europeo` (ref. 3.B.45), `slutsky` (ref. 3.A.9), `suavizacion-impositiva-barro` (ref. 3.A.39), `tarifa-dos-partes` (ref. 3.A.17), `taylor` (ref. 3.A.36), `teoremas-bienestar` (ref. 3.A.22), `van-tir` (ref. 3.B.2), `vc-ve` (ref. 3.A.9)


### Notación

**Un concepto, varios símbolos** (entre temas del área):

- ahorro (tasa): `s` (4.B.1, 4.B.3); `S₁` (4.B.10)
- aversión al riesgo / CRRA: `θ` (4.B.4); `β` (4.B.10)
- beneficio: `B_t, C_t` (4.B.6); `B_t` (4.B.6); `B` (4.B.10); `π₀` (4.B.13); `π` (4.B.13); `RCB_t` (4.B.26)
- cantidades / cesta: `X₁, X₂` (4.B.9, 4.B.11); `X, Y` (4.B.8); `q` (4.B.15)
- consumo: `C, O, O₀, L` (4.B.10); `C` (4.B.10); `C₁, C₂` (4.B.10); `C_t` (4.B.12)
- coste: `C_t` (4.B.6); `C` (4.B.15)
- deuda pública: `D_t, B_t` (4.B.4); `D` (4.B.4); `V_E, V_D, r_E, r_D, WACC` (4.B.10); `V_D` (4.B.10); `r_D` (4.B.10); `D_0` (4.B.11); `G_t, T_t, D_t, M_t` (4.B.26); `D (d)` (4.B.26); `ADD` (4.B.26)
- factor/tasa de descuento: `β` (4.B.3, 4.B.4, 4.B.11); `ρ` (4.B.4); `δ` (4.B.6); `TPT` (4.B.6); `r` (4.B.8)
- gasto público: `G, g` (4.B.1); `P` (4.B.1); `G` (4.B.5); `g` (4.B.5)
- población (crecimiento): `n` (4.B.1, 4.B.3); `L` (4.B.5)
- precios de los bienes: `P` (4.B.11); `P_i` (4.B.15)
- producción / renta agregada: `OG` (4.B.4); `x_t` (4.B.4); `Y_t` (4.B.11); `Y, x_i, p_i` (4.B.13); `Y` (4.B.13)
- renta (del consumidor): `Y` (4.B.3, 4.B.4, 4.B.7); `y^D` (4.B.3); `y_M` (4.B.3); `R` (4.B.8); `M` (4.B.10); `Y_t, C_t, ΔW_t` (4.B.12); `Y_t` (4.B.12)
- salario: `w` (4.B.3, 4.B.10); `W` (4.B.8); `w, M` (4.B.10); `w_L, w_K, O, O₀, M` (4.B.11)
- tipo de interés: `r` (4.B.3, 4.B.9, 4.B.10); `n, r` (4.B.3); `i` (4.B.4)
- tipo impositivo: `τ` (4.B.1, 4.B.5, 4.B.6, 4.B.7, 4.B.8, 4.B.10); `t` (4.B.4, 4.B.8, 4.B.10); `t_K, t_L, t_X` (4.B.8); `t_X, t_{KX}` (4.B.8); `τ_{X_i}, τ_X, τ_{W̄}` (4.B.9); `z_m / τ_{z_m}^{X_i}` (4.B.9); `t_c, t_r` (4.B.9); `t_c` (4.B.9); `t_r` (4.B.9); `θ` (4.B.11); `T (\tau)` (4.B.26)
- utilidad: `U_i` (4.B.2); `β_A, β_B (también α_A, α_B en la nota)` (4.B.11); `β_n` (4.B.11)

**Un símbolo, varios significados** (entre temas del área; se omiten los que solo cambian de redacción):

- `t`: tipo (4.B.3, 4.B.9, 4.B.10, 4.B.11, 4.B.13); tipo impositivo (4.B.4, 4.B.8, 4.B.10); tipo marginal (4.B.7, 4.B.10); tipo del is (4.B.10); tipo ad valorem sobre el bien (equilibri (4.B.11); tipo ad valorem (4.B.11)
- `τ`: tipo impositivo (4.B.1, 4.B.5, 4.B.6, 4.B.7, 4.B.8, 4.B.10); tipo de cotizacion a la seguridad social (4.B.3); cotizacion (4.B.3); tipo (4.B.7); vector de instrumentos impositivos; en b (4.B.11); instrumentos (4.B.11)
- `r`: tipo real (4.B.1, 4.B.26); tipo de interés (4.B.3, 4.B.9, 4.B.10); factor/tasa de descuento (4.B.8); coste del capital (4.B.15)
- `W`: funcion de bienestar social (4.B.2); bienestar (4.B.2); salario (4.B.8); fbs (4.B.11)
- `β`: factor/tasa de descuento (4.B.3, 4.B.4, 4.B.11); movilidad del capital en la bp y factor  (4.B.4); movilidad del capital (4.B.4); aversión al riesgo / CRRA (4.B.10)
- `R`: reduccion (4.B.3); deduccion en cuota del impuesto lineal (4.B.7); deduccion fija (4.B.7); renta (del consumidor) (4.B.8)
- `P`: suma de partidas de gasto (indicador de  (4.B.1); gasto público (4.B.1); precios de los bienes (4.B.11)
- `g`: gasto per capita (4.B.1); crecimiento (4.B.1); gasto público (4.B.5)
- `s`: ahorro (tasa) (4.B.1, 4.B.3); tasa permitida (4.B.15); senoreaje (4.B.26)
- `G`: gasto (4.B.2); gasto en desempleo (4.B.4); gasto público (4.B.5)
- `Y`: renta (del consumidor) (4.B.3, 4.B.4, 4.B.7); presupuesto aprobado (4.B.5); producción / renta agregada (4.B.13)
- `B`: bonos (4.B.4); subsidio de desempleo (4.B.6); beneficio (4.B.10)
- `t_c`: tipo impositivo (4.B.9); tipo sobre el consumo (4.B.10); tipo sobre consumo (4.B.10)
- `δ`: depreciación (4.B.1, 4.B.10, 4.B.13); factor/tasa de descuento (4.B.6)
- `n`: población (crecimiento) (4.B.1, 4.B.3); consumidores (4.B.15)
- `i`: tipo de interés (4.B.4); tipo nominal (4.B.26)
- `θ`: aversión al riesgo / CRRA (4.B.4); tipo impositivo (4.B.11)
- `D`: deuda pública (4.B.4); transferencia (4.B.11)
- `L`: población (crecimiento) (4.B.5); trabajo / empleo (4.B.10)
- `C_t`: coste (4.B.6); consumo (4.B.12)
- `C`: consumo (4.B.10); coste (4.B.15)
- `Y_t`: producción / renta agregada (4.B.11); renta (del consumidor) (4.B.12)

**Notación de los modelos compartidos que cambia de un tema a otro:**

- `rbc-sims` · descuento: `1/(1+ρ)` (3.A.38); `ρ` (4.B.4)
- `harberger-incidencia` · precios de factores: `w, r (también W, R)` (4.B.8); `W, R` (4.B.9)
- `exceso-gravamen` · tipo: `τ` (4.B.7); `t` (4.B.9)
- `exceso-gravamen` · elasticidad: `ε (con signo)` (4.B.9); `ε (definida positiva)` (4.B.11)
- `arrow-imposibilidad` · preferencias individuales: `R_i, \succ_i` (3.A.24); `R_i` (4.B.2)
- `arrow-imposibilidad` · ordenacion social: `R_G, \succeq_G` (3.A.24); `R_G` (4.B.2)
- `equilibrio-general-walras` · bienes: `X, Y` (3.A.21, 3.A.22, 3.A.23); `X₁, X₂` (4.B.11)
- `equilibrio-general-walras` · factores: `K, L` (3.A.21); `L, K` (3.A.22, 3.A.23, 4.B.11)
- `equilibrio-general-walras` · renta: `W̄_h` (3.A.21); `W̄ = w_L·O₀ + M` (4.B.11)
- `fisher-intertemporal` · consumo: `c_t` (3.A.29); `C₁, C₂` (4.B.10)
- `fisher-intertemporal` · tipo de interes: `r_t` (3.A.29); `r` (4.B.9, 4.B.10)
- `funcion-bienestar-social` · bienestar: `W` (3.A.22, 4.B.2); `W(•)` (3.A.24)
- `funcion-bienestar-social` · utilidades: `U_A, U_B` (3.A.22); `U_1…U_I` (3.A.24)
- `modigliani-miller` · apalancamiento: `V_D/V_E` (3.B.3); `L = V_D/(V_D+V_E)` (4.B.10)
- `restriccion-gobierno` · deuda: `D_t (d_t en % PIB)` (3.A.39); `D (d)` (4.B.26)
- `restriccion-gobierno` · impuestos: `T_t / τ_t` (3.A.39); `T (\tau)` (4.B.26)
- `suavizacion-impositiva-barro` · recaudacion: `τ_t (aquí τ es recaudación, no tipo)` (4.B.9); `τ_t (aquí es recaudación, no tipo)` (4.B.11)
- `teoremas-bienestar` · dotacion: `e` (3.A.22); `e, e'` (4.B.3)

**Incoherencias internas** (dentro de cada tema):

- 4.B.1: Error: el «índice de Frank» se atribuye a «el economista inglés Frank Ramsey»; el índice de esfuerzo fiscal es de Henry J. Frank y no tiene relación con Ramsey (también en el PDF).
- 4.B.1: La misma letra g designa el gasto público per cápita en Barro y el crecimiento del PIB en r<g.
- 4.B.1: Saldo primario definido como «Saldo – servicio de la deuda»; debe ser saldo excluidos los intereses (saldo + intereses si el déficit es negativo).
- 4.B.1: En la cuenta de explotación se dice que los impuestos netos sobre producción son empleo de las AAPP y en la de renta primaria que son recursos: falta aclarar el doble papel.
- 4.B.1: Fórmulas de indicadores sustituidas por imágenes vacías ([]) en el Word (tamaño presupuestario, esfuerzo fiscal, óptimo BMg=CMg).
- 4.B.2: Fechas erróneas: modelo de Downs-Hotelling «(1947)» (Hotelling 1929, Downs 1957); Nordhaus «(1971)» (1975); Olson «(1992)» (1965).
- 4.B.2: Teorema de May mal enunciado en la nota 20 (la mayoría simple es la única regla anónima, neutral, decisiva y con respuesta positiva con dos alternativas).
- 4.B.2: La nota 23 sobre Gibbard-Satterthwaite habla de regla «inmune a la manipulación», contradiciendo el texto principal (toda regla con U, P y no dictadura es manipulable).
- 4.B.2: «Triángulo de hierro (término acuñado por MUSGRAVE)»: atribución dudosa; «ilusión de la deuda (NISKANEN)»: se atribuye habitualmente a Puviani/Buchanan-Wagner.
- 4.B.2: La FBS se presenta con utilidades «cardinales» y resultado «ordinal», mientras que Arrow trabaja con ordinales: conviene aclarar el contraste.
- 4.B.2: Las soluciones a la burocracia aparecen dos veces casi idénticas (2.2.3 «Soluciones» y 2.4).
- 4.B.2: El apartado de grupos de interés repite la definición y la teoría de Olson dos veces (texto y notas 29-30).
- 4.B.2: No se menciona la AIReF al tratar las autoridades fiscales independientes; zona euro descrita con el 0,5 % del Pacto Fiscal, sin el marco de gobernanza de 2024.
- 4.B.3: En el modelo de reparto aparecen dos veces «Si n > r_{t+1}» con conclusiones opuestas; la segunda debe ser n < r_{t+1}.
- 4.B.3: «Desempleo (reducción de g)» introduce g sin definirla en la fórmula; la fórmula de ahorro con reparto está truncada en el Word.
- 4.B.3: «Impuesto negativo sobre la riqueza» en lugar de «sobre la renta».
- 4.B.3: Las prestaciones no contributivas se califican de «universales» y «finalistas», en contradicción con su carácter de prueba de medios.
- 4.B.3: Sanidad: «bajo libre mercado podría haber una cantidad deseable de vacunados» (debe ser inferior a la deseable).
- 4.B.3: Las fórmulas de progresividad usan T/Y y BI indistintamente para la base.
- 4.B.3: Los programas de mínimos garantizados se presentan con tipo marginal del 100 %, pero se ilustran con el IMV, que desde 2022 incluye un complemento de incentivo al empleo.
- 4.B.4: Error de signo en el ejemplo de España 2022: con déficit −4,8 % y saldo cíclico −1 %, el saldo cíclicamente ajustado es −3,8 % (no −5,8 %) y el estructural −3,6 % (no −6 %). Además se infiere la orientación expansiva del nivel del déficit estructural, cuando el tono se mide por su variación (esfuerzo fiscal).
- 4.B.4: Curva BP: se repite «movilidad perfecta de capital» para β=+∞ y β=0; el segundo caso es movilidad nula.
- 4.B.4: La sensibilidad de la inversión al tipo de interés es v en las ecuaciones y b en el texto de keynesianos y monetaristas.
- 4.B.4: η designa a la vez la sensibilidad cíclica del saldo y el parámetro de rigidez de Calvo; β la movilidad del capital y el factor de descuento.
- 4.B.4: Restricción del gobierno con índices distintos en el RBC (G_t+r_{t-1}D_t≤T_t+D_{t+1}-D_t) y en el NEK (G_t+r_{t-1}D_{t-1}≤T_t+D_t-D_{t-1}).
- 4.B.4: El RBC dice que ninguna condición depende de «τ_t», pero el modelo solo tiene impuestos de suma fija T_t.
- 4.B.4: Con presupuesto equilibrado el texto dice que ΔY es menor que ΔG por crowding out, mientras la nota 13 da el multiplicador de Haavelmo igual a 1 (sin aclarar que difieren por la inversión endógena).
- 4.B.4: En el texto se habla de elasticidades respecto al output gap y en la conclusión de «semielasticidades» (la Comisión usa semielasticidades desde 2013).
- 4.B.4: Nota 29: «ϕ_π = ϕ_π = 0,5» (debe ser ϕ_y = ϕ_π = 0,5).
- 4.B.4: Los «efectos no keynesianos» se exponen dos veces casi idénticos (RBC y evidencia).
- 4.B.4: Fechas de los datos dispares: base de cotización máxima de 45.000 €, Programa de Estabilidad 2023-2026, controversia con datos de 2018-2020.
- 4.B.5: Llama al esfuerzo fiscal «Índice de Frank, en honor al economista inglés FRANK RAMSEY»: error, el índice es de Henry J. Frank (1959), no de Ramsey.
- 4.B.5: Presión fiscal de España «35 %» y previsión «37 % en 2022» con datos de déficit/deuda de 2022: mezcla de años.
- 4.B.5: Los burócratas votantes y Niskanen aparecen en «Teoría positiva» pero el «Gasto público como redistribuidor» se atribuye a Romer y Rosenthal (1980) describiendo en realidad Meltzer-Richard (1981).
- 4.B.5: El índice dice «Comodín: estancamiento secular» dentro del debate histórico; el mismo comodín aparece en el viejo 4.B.1 (duplicado).
- 4.B.6: La tasa de descuento se denota δ, igual que la depreciación en otros temas (y que la TPT en modelos macro).
- 4.B.6: α se usa para la proporción de inversión desplazada (Harberger), mientras que en 4.B.5 α es la elasticidad del capital en Barro.
- 4.B.6: Riesgo e incertidumbre se definen dos veces seguidas (introducción de la fase 7 y «Ajustes por riesgo»).
- 4.B.6: Habla de «9 fases típicas» con una sola fuente; la fase 5 (duración) va dentro del encabezado de tasa de descuento («Introducción»).
- 4.B.7: Define el impuesto «específico» como «no existe tipo de gravamen … cantidad monetaria fija (p. ej. impuestos de suma fija)»: confunde impuesto unitario (por unidad física) con impuesto de suma fija.
- 4.B.7: Bajo ε_{BI,Y}>1 (IRPF, IS) explica «ε_{T,Y}>1 por el mínimo exento»: mezcla elasticidad de la base y de la recaudación.
- 4.B.7: Pone «Impuesto de Sucesiones» como ejemplo de impuesto estatal, cuando está cedido a las CCAA.
- 4.B.7: Ejemplo de impuesto de ordenación: «IVA sobre el tabaco» (debería ser el impuesto especial sobre labores del tabaco).
- 4.B.7: En «Capacidad de pago – Consumo – Problemas – Eficiencia» el argumento («gravar el ahorro podría aumentar la demanda») contradice la ventaja de eficiencia citada justo antes.
- 4.B.7: Exceso de gravamen se mide con elasticidades η_s, η_d y τ, mientras que en 4.B.9 (viejo 4.B.10) se usan otras notaciones (ε, t): unificar.
- 4.B.7: Clasificación SEC: rotula «Transferencias de capital» como impuestos sobre transferencias de patrimonio e «Impuestos sobre el capital» como transferencias voluntarias (etiquetas invertidas).
- 4.B.8: Casos extremos: dice «Demanda perfectamente elástica: porcentaje del impuesto que recaerá sobre los productores: 0 %», cuando es el 100 %; el Anexo 1 lo da bien (consumidores 0 %).
- 4.B.8: Monopolio con impuesto: «al precio que recibe del consumidor habrá que añadirle el impuesto t» (debería ser deducirle), contradiciendo el apartado competitivo.
- 4.B.8: Notación de precios de factores: W, R en el modelo unisectorial y w, r en Harberger; t unitario en parcial y t ad valorem en general.
- 4.B.8: La introducción del equilibrio general anuncia «Modelo dinámico» y EGC, pero el primero se reduce a la capitalización y el segundo está vacío.
- 4.B.8: Notas del autor sin resolver: impuesto general sobre el consumo en el modelo unisectorial («¿no tendría que haber un doble efecto sobre F'k?») y en Harberger («¿la FPP se hace más pequeña? ¿¿??»).
- 4.B.8: «Ley de DALTON» se aplica también a la oferta perfectamente elástica en monopolio con razonamiento confuso.
- 4.B.9: Falta el epígrafe del título «Medidas de progresividad impositiva».
- 4.B.9: Notación de los impuestos sobre factores: en la lista «z_m i» / «z_m» y en el desarrollo «τ_{z_m}^{X_i}».
- 4.B.9: En el impuesto general sobre un factor el autor deja una nota «No entiendo, algo tiene que haber mal…» sin resolver.
- 4.B.9: Precios de factores w_L, w_K en el modelo 1×2×2×2 y W, R en el Harberger del mismo tema.
- 4.B.9: Elasticidad ε con signo (EG=−½ε t² P h) aquí, frente a η_s, η_d positivas en 4.B.7.
- 4.B.9: Atribuye la VC y la VE a «HICKS (1956) … refinados por WILLINGS» (es Hicks, 1939-1942, y Willig, 1976); escribe «HAUSSMAN» por Hausman.
- 4.B.9: Remite a «anexo A.2» para la suavización de Barro, que es el anexo 4.
- 4.B.9: τ se usa como tipo en todo el tema y como recaudación en el anexo de Barro.
- 4.B.9: El apartado 1.3 (copiado de otro tema) repite el 1.2 con otro modelo (1×2×1×1).
- 4.B.10: La restricción presupuestaria de la solución se escribe «C* + w·O* = w·O₀ + O» (dos veces): debería ser «+ M».
- 4.B.10: Con impuesto proporcional sobre salarios la RP se escribe C + w·O ≤ w(1−τ)O₀ + M: el precio del ocio del lado izquierdo debería ser también w(1−τ), como sí refleja la condición RMS = w(1−τ).
- 4.B.10: Condición de holgura complementaria escrita con «≥ 0» en el primer término y «= 0» en el segundo.
- 4.B.10: El tipo se llama τ en el modelo de trabajo y t en el resto; la proporción en el activo con riesgo se llama a_i y α, y α es también el peso del rendimiento en la utilidad.
- 4.B.10: Se dice que el ER ordinario es «positivo» y el de dotación «negativo» referidos al consumo presente, mientras en trabajo se describen sobre el ocio: cambia el signo de referencia.
- 4.B.10: Afirma que la curva de Laffer en el IRPF exige elasticidad de la oferta de trabajo al tipo mayor que 1: es impreciso (depende de la elasticidad de la base respecto a 1−t y del nivel de t).
- 4.B.10: Nota del propio texto: el punto E₃ del gráfico de salarios está mal dibujado.
- 4.B.11: Se define ε = −(Δh/h)/(ΔP/P) (positiva) y luego Δh = −ε·t·h, de modo que EG = −½·ε·P·h·t² sale negativo: el signo es incoherente (con ε positiva debería ser +½εPht²; el signo menos solo cuadra si ε es la elasticidad con su signo).
- 4.B.11: La lista inicial de las «6 reglas» del enfoque de Ramsey está corrupta: el punto 5 está vacío, el 6 contiene el texto completo de Corlett-Hague y luego aparecen 7) Diamond y 8) Corlett-Hague otra vez.
- 4.B.11: Frase rota en la variación equivalente: «la cuantificación monetaria de la recaudación … es exceso de gravamen … por lo que el resto del tramo, GF, es el exceso de gravamen».
- 4.B.11: τ significa tres cosas distintas (vector de instrumentos, recaudación en Barro, impuesto equivalente sobre el consumo en Chamley-Judd) y t es el tipo en el resto.
- 4.B.11: En la nota del análisis gráfico se usan α_A, α_B y en el texto β_A, β_B para la utilidad marginal social.
- 4.B.11: Numeración: el apartado 3 empieza en 3.2 (no hay 3.1) y la «política fiscal óptima y suavización impositiva» figura como apartado 4 en el índice pero está dentro de 3.2 en el texto.
- 4.B.11: Se dice que el impuesto lineal con transferencias es «progresivo» (lo es en tipo medio) sin precisarlo.
- 4.B.12: Renta fiscal escrita como Y_t = IC_t + GD_t: los gastos deducibles deberían restarse.
- 4.B.12: En la delimitación del IRPF se dice que es progresivo porque «se aplicará un mayor porcentaje de retención»: confunde tipo de gravamen con retenciones.
- 4.B.12: Las deducciones «por tributación conjunta» se colocan en la base liquidable diciendo «como mencionamos anteriormente», pero la tributación conjunta se trata después.
- 4.B.12: Deducción por doble imposición: «doble imposición económica (quien haya tributado en el extranjero) o legal (lo que haya tributado)» está invertido/confuso (la jurídica es el mismo contribuyente; la económica, la misma renta en contribuyentes distintos).
- 4.B.12: Anexo 2: filas mal etiquetadas («Tipo de gravamen: Analítico/Sintético» corresponde a la base imponible) y el IVA figura con sujeto pasivo «Personal».
- 4.B.12: El texto del IS dice que el tipo es «único» y proporcional pero luego enumera tipos distintos (pymes, hidrocarburos 30 %, entidades exentas).
- 4.B.12: Cifras de IRPF distintas en el texto (113.123 M€, 43 % de los tributarios) y en el anexo (110.000 M€, ~40 %).
- 4.B.13: En las características dice «No obstante, la imposición directa también tiene ciertas limitaciones» cuando trata de la indirecta (copia del tema de imposición directa).
- 4.B.13: La estructura anunciada en la introducción (impuestos especiales antes que el IVA, comparaciones al final) no coincide con el orden del desarrollo.
- 4.B.13: El IVA figura como impuesto «real» en la delimitación y como sujeto pasivo «Personal» en el Anexo 3; en el Anexo las filas están mal etiquetadas («Tipo de gravamen: Analítico/Sintético» es la base).
- 4.B.13: Implantación del IVA en la CEE fechada en 1967 en el anexo y en 1970 en la nota 19 (y la Directiva de base uniforme en 1977).
- 4.B.13: Se afirma que el régimen intracomunitario eliminó los ajustes fiscales en frontera y a la vez que la imposición en destino «crea barreras fiscales al obligar a realizar ajustes en frontera».
- 4.B.13: Frase rota en las exenciones: «en función de que el bien exento sea el correspondiente a una fase intermedia o que la exención recaiga en una fase intermedia (i.e. el bien de consumo final)».
- 4.B.13: Periodicidad del IVA descrita como «Puntual» e «Instantáneo» pese a liquidarse trimestral o mensualmente.
- 4.B.13: Peso del IVA en España: 32,76 % de los tributarios en el texto, 16 % «del total de ingresos» en comparaciones y ~30 % en el anexo, sin aclarar las bases.
- 4.B.15: (viejo 4.B.16) En Laffont-Tirole el parámetro b cambia de sentido: en el texto principal t=a+b(C−C^a) con b=0 «fixed price» y b=1 «cost plus»; en el anexo P=bF+(1−b)C con b=0 «cost plus» y b=1 «fixed price».
- 4.B.15: (viejo 4.B.16) Se escribe «Ramsey-Boiteaux»; el autor es Marcel Boiteux.
- 4.B.15: (viejo 4.B.16) Duplica el epígrafe «Nueva teoría de la regulación» (1.4 y 1.5) y numera «2.3.0» dentro de 1.3.
- 4.B.15: Restricción presupuestaria blanda se atribuye implícitamente sin citar a Kornai; en 4.B.17 se habla de «riesgo de quiebra» cuando se quiere decir que no lo afronta.
- 4.B.18: Fecha de introducción del IVA en la CEE: «Introducción del IVA (1973)» en la estructura, «hasta la introducción del IVA en 1970» y «Implantación del IVA en todos los Estados miembros (1967)» en el anexo (la primera directiva es de 1967; implantación general hacia 1970-1973).
- 4.B.18: Base jurídica: cita «artículos 93 y 94 del TUE» (numeración del antiguo TCE) y en otro lugar «artículo 113 del TFUE»; lo correcto hoy es arts. 113 y 115 TFUE.
- 4.B.18: «Modificación de la Directiva 2016 ... en 2014 se aprueba la modificación de la Directiva de Fiscalidad del Ahorro 2016»: fechas confusas (DAC2 2014; derogación de la directiva del ahorro en 2015).
- 4.B.18: Tipos de IS citados (Portugal 31,5 %, Irlanda 12,5 %, Hungría 9 %) anteriores al pilar 2 (Irlanda aplica 15 % a grandes grupos desde 2024).
- 4.B.18: Calendario de nuevos recursos propios «para 2023/2026» desactualizado.
- 4.B.21: Dice que el proceso presupuestario «consta de 4 etapas» y enumera 5 (preliminar, elaboración, aprobación, ejecución, liquidación y control); la estructura usa 0) a 4).
- 4.B.21: En ejecución, el paso vi) «Envío de la documentación presupuestaria al Congreso» repite un paso de la fase de aprobación.
- 4.B.21: El art. 136 CE se describe una vez como competencia del Tribunal de Cuentas y otra como competencias de control «al Tribunal de Cuentas y al Parlamento».
- 4.B.21: Afirma que en los ingresos «la única clasificación que vamos a estudiar es la económica» frente al título nuevo, que pide clasificaciones de ingresos y gastos (incluida la orgánica de ingresos).
- 4.B.22: La «Estructura» de la introducción enumera «Razones de la existencia de las empresas públicas / La política de privatizaciones / Comparaciones internacionales» (copiada del tema de empresa pública).
- 4.B.22: Periodización: «Incremento sustancial del gasto (1989-1995)» en un sitio y 1990-1995 en el viejo 4.B.27; «consolidación (2012-2018)» frente a «(2012-2019)» en la lista de etapas.
- 4.B.22: Regla de gasto: aquí «establecida en la normativa europea ... gasto computable» con exclusiones; en el viejo 4.B.24 (4.B.21) solo como «gasto del conjunto de las AAPP no puede superar el PIB de medio plazo».
- 4.B.22: Lista de otros entes públicos incluye el INE dos veces (OO.AA. y otros entes).
- 4.B.22: «Fiscal Compact (realmente, fue después, pero todo parte del mismo proceso)»: el Tratado de Estabilidad es de 2012 y la reforma del art. 135 de 2011.
- 4.B.26: Signo del «efecto bola de nieve»: se dice que «se volvió negativo» cuando el tipo de interés superaba el crecimiento nominal (es decir, cuando aumentaba la deuda) y «positivo» cuando el crecimiento era mayor; en la ecuación el término (i−γ)d suma a Δd, con el signo contrario.
- 4.B.26: En la restricción presupuestaria γ^Y es crecimiento real (se divide por (1+π)(1+γ)) y el término usa el tipo real r; en la descomposición del anexo el efecto bola de nieve se define con tipo nominal y crecimiento nominal.
- 4.B.26: «Regla de oro» se usa para el límite de déficit estructural del Fiscal Compact (0,5 %) mientras que en 4.B.21 el límite LOEPSF es 0,4 % y «regla de oro» designa la reforma del art. 135; ninguna coincide con la regla de oro de la inversión pública.
- 4.B.26: Periodización duplicada con el viejo 4.B.23 pero con fechas distintas (1989-1995 frente a 1990-1995).
- 4.B.26: La comparación de deuda pública post-crisis incluye párrafos sobre inflación en 2022 (gas argelino, Suiza, Italia) ajenos al tema; la lista de países más endeudados mezcla Sudán, Eritrea y Cabo Verde con OCDE.
- 4.B.26: Dos introducciones y dos conclusiones (vienen de dos temas).

### Modelos desarrollados en varios temas o contados de forma distinta

- `sec-2010` (ref. 4.B.1; desarrollo en 4.B.1, 4.B.23).
  - 4.B.1 [D] «Sistema Europeo de Cuentas 2010 (Reglamento UE 549/2013)» (3 ec., 4 gráf.; para: Delimitar el sector público (S.13 frente a S.11/S.12) y ordenar sus op)
  - 4.B.5 [r] «Sistema Europeo de Cuentas 2010 (delimitación S.13, S.11, S.12; criter» (0 ec., 0 gráf.; para: Delimitar qué es gasto público)
  - 4.B.7 [r] «Delimitación S.13 / S.11 / S.12 del SEC-2010» (0 ec., 0 gráf.; para: Qué es ingreso público)
  - 4.B.22 [r] «Delimitación SEC 2010 del sector AAPP (S.13 y subsectores) y del secto» (0 ec., 0 gráf.; para: Definir gasto público)
  - 4.B.23 [D] «sec-2010» (0 ec., 0 gráf.; para: contenido que este tema debería desarrollar (previsto, sin fuente))
- `buchanan-tullock-mayoria-optima` (ref. 4.B.2; desarrollo en 4.B.2).
  - 3.A.24 [r] «Mayoría óptima de Buchanan y Tullock; unanimidad de Wicksell» (0 ec., 1 gráf.; para: Reglas distintas de la mayoría simple)
  - 4.B.2 [D] «Mayoría óptima de Buchanan y Tullock» (1 ec., 1 gráf.; para: Determinar el porcentaje de votos que minimiza costes externos + coste)
- `ciclo-politico-nordhaus` (ref. 4.B.2; desarrollo en 4.B.2).
  - 4.B.2 [D] «Ciclo político-económico de Nordhaus» (0 ec., 1 gráf.; para: Expansión preelectoral y ajuste poselectoral con votantes miopes)
  - 4.B.5 [r] «Ciclo político-económico (Nordhaus)» (0 ec., 1 gráf.; para: Gasto ligado al calendario electoral)
  - 4.B.11 [m] «Ciclo político (Nordhaus), burocracia (Niskanen), acción colectiva (Ol» (0 ec., 0 gráf.; para: Fallos del sector público que alejan el sistema real del óptimo)
- `downs-hotelling` (ref. 4.B.2; desarrollo en 4.B.2).
  - 3.A.18 [m] «Modelo de Downs-Hotelling (votante mediano)» (0 ec., 0 gráf.; para: Aplicación política)
  - 3.A.24 [m] «Modelo de Downs-Hotelling» (0 ec., 0 gráf.; para: Convergencia de partidos al votante mediano en democracia representati)
  - 4.B.2 [D] «Modelo de competencia electoral de Downs-Hotelling» (0 ec., 1 gráf.; para: Convergencia de los programas al votante mediano en democracia represe)
- `niskanen` (ref. 4.B.2; desarrollo en 4.B.2, 4.B.5).
  - 3.A.23 [m] «Modelo de burocracia de Niskanen» (0 ec., 0 gráf.; para: Burócrata maximizador del presupuesto)
  - 3.A.24 [m] «Burocracia de Niskanen» (0 ec., 0 gráf.; para: Problemas de la democracia representativa)
  - 4.B.2 [D] «Modelo de burocracia maximizadora del presupuesto de Niskanen (1971)» (2 ec., 1 gráf.; para: Sobredimensionamiento del presupuesto por el burócrata monopolista de )
  - 4.B.5 [D] «Modelo de burocracia de Niskanen (1971)» (0 ec., 1 gráf.; para: El burócrata maximizador de presupuesto lleva a G'>G*)
- `paradoja-condorcet` (ref. 4.B.2; desarrollo en 3.A.24, 4.B.2).
  - 3.A.24 [D] «Paradoja de Condorcet y preferencias unimodales (Black)» (0 ec., 1 gráf.; para: Intransitividad de la mayoría y escapatoria levantando la universalida)
  - 4.B.2 [D] «Paradoja de Condorcet y manipulación de agenda» (1 ec., 2 gráf.; para: Intransitividad de la mayoría simple con preferencias multimodales)
- `votante-mediano` (ref. 4.B.2; desarrollo en 4.B.2).
  - 3.A.24 [r] «Teorema del votante mediano» (0 ec., 0 gráf.; para: Predicción del resultado con preferencias unimodales y unidimensionale)
  - 4.B.2 [D] «Preferencias unimodales de Black y teorema del votante mediano» (0 ec., 1 gráf.; para: Garantizar transitividad renunciando a la universalidad y predecir el )
  - 4.B.5 [r] «Votante mediano (Black; Downs-Hotelling) y gasto redistributivo (Romer» (0 ec., 0 gráf.; para: Sufragio universal y renta mediana < media impulsan el gasto redistrib)
- `efectos-no-keynesianos` (ref. 4.B.4; desarrollo en ninguno).
  - 4.A.28 [m] «Efectos no keynesianos de la consolidación fiscal» (0 ec., 0 gráf.; para: cambio de paradigma tras la crisis griega)
  - 4.B.4 [r] «Efectos no keynesianos de la política fiscal (Giavazzi-Pagano, Alesina» (0 ec., 0 gráf.; para: Consolidaciones fiscales expansivas)
  - 4.B.26 [m] «Efectos no keynesianos de la política fiscal (consolidación fiscal exp» (0 ec., 0 gráf.; para: Justificar la consolidación en recesión (expectativas, tipos de interé)
- `estabilizadores-automaticos` (ref. 4.B.4; desarrollo en 4.B.4, 4.B.7).
  - 4.B.4 [D] «Estabilizadores automáticos: elasticidad renta de la recaudación y del» (3 ec., 0 gráf.; para: Medir el componente automático del presupuesto)
  - 4.B.7 [D] «Elasticidades base-renta y recaudación-base; efecto estabilizador» (3 ec., 0 gráf.; para: Clasificar impuestos por sensibilidad y como estabilizadores automátic)
- `multiplicadores-fiscales` (ref. 4.B.4; desarrollo en 3.A.38, 4.B.4).
  - 3.A.38 [D] «Multiplicadores fiscales (impacto, acumulado, máximo)» (0 ec., 0 gráf.; para: Evidencia.)
  - 4.A.11 [m] «Multiplicador de la inversión pública (Plan E)» (0 ec., 0 gráf.; para: Papel estabilizador de la obra civil en recesiones)
  - 4.B.4 [D] «Multiplicadores fiscales: impacto, tras k periodos, acumulado y máximo» (3 ec., 0 gráf.; para: Determinantes empíricos del multiplicador)
- `rbc-sims` (ref. 4.B.4; desarrollo en 3.A.38, 4.B.4).
  - 3.A.38 [D] «RBC con política fiscal (Sims, 2015)» (1 ec., 0 gráf.; para: Equivalencia ricardiana y efecto del gasto.)
  - 4.B.4 [D] «Modelo de ciclo real con gasto público (Sims 2015; Baxter-King 1993)» (5 ec., 1 gráf.; para: Efecto riqueza negativo del gasto, multiplicador positivo pero menor q)
- `indicadores-tamano-sector-publico` (ref. 4.B.5; desarrollo en 4.B.1, 4.B.5).
  - 4.B.1 [D] «Indicadores de tamaño del sector público (gasto/PIB, presión fiscal, e» (4 ec., 2 gráf.; para: Medir la dimensión del sector público y compararla internacionalmente)
  - 4.B.5 [D] «Indicadores de tamaño: G/PIB, presión fiscal, esfuerzo fiscal (índice » (2 ec., 1 gráf.; para: Medir el tamaño del sector público y compararlo internacionalmente)
- `incidencia-equilibrio-parcial` (ref. 4.B.8; desarrollo en 3.A.16, 4.B.8).
  - 3.A.16 [D] «Impuesto unitario en equilibrio parcial» (2 ec., 2 gráf.; para: estática comparativa normativa)
  - 4.A.11 [m] «Incidencia de una subvención con oferta inelástica» (0 ec., 0 gráf.; para: Explicar que las deducciones por compra de vivienda se trasladan a pre)
  - 4.B.8 [D] «Incidencia en equilibrio parcial competitivo (impuesto unitario sobre » (2 ec., 4 gráf.; para: Quién soporta la carga según las elasticidades)
  - 4.B.13 [m] «Traslación e incidencia según elasticidades» (0 ec., 0 gráf.; para: Quién soporta económicamente el IVA; evidencia de Benzarti et al. (asi)
- `efecto-renta-sustitucion-impuesto` (ref. 4.B.9; desarrollo en 4.B.9, 4.B.10).
  - 4.B.9 [D] «Efecto renta y efecto sustitución de los impuestos en un modelo 1×2×2×» (6 ec., 0 gráf.; para: Qué impuestos rompen cada condición de eficiencia paretiana)
  - 4.B.10 [D] «Descomposición efecto sustitución / renta ordinario / renta dotación d» (1 ec., 1 gráf.; para: Explicar por qué el efecto de un impuesto sobre salarios o sobre el re)
- `exceso-gravamen` (ref. 4.B.9; desarrollo en 4.B.9, 4.B.11).
  - 4.B.7 [r] «Exceso de gravamen (método de la variación equivalente y de excedentes» (2 ec., 2 gráf.; para: Principio de eficiencia)
  - 4.B.8 [m] «Exceso de gravamen» (0 ec., 0 gráf.; para: Pérdida de bienestar en el gráfico de incidencia)
  - 4.B.9 [D] «Exceso de gravamen (concepto y medición en equilibrio parcial)» (4 ec., 2 gráf.; para: Medir el coste de eficiencia de un impuesto)
  - 4.B.11 [D] «Exceso de gravamen: variación equivalente y excedentes; equilibrio gen» (4 ec., 3 gráf.; para: Concepto y medición de la pérdida de eficiencia de los impuestos (base)
- `progresividad` (ref. 4.B.9; desarrollo en 4.B.16).
  - 4.B.3 [r] «Progresividad por la elasticidad recaudación-base; progresividad media» (4 ec., 0 gráf.; para: Indicador de redistribución por el lado de los ingresos)
  - 4.B.4 [r] «Progresividad media y marginal (elasticidad recaudación-base)» (2 ec., 0 gráf.; para: Primer componente de la elasticidad de la recaudación)
  - 4.B.7 [r] «Progresividad media y marginal (impuesto lineal con mínimo exento)» (3 ec., 0 gráf.; para: Clasificar impuestos por progresividad)
  - 4.B.9 [m] «Medidas de progresividad local (elasticidad de la cuota, tipo medio y » (0 ec., 0 gráf.; para: AUSENTE aquí (definidas en 4.B.7))
  - 4.B.12 [r] «Progresividad medida por la elasticidad de la recaudación respecto a l» (1 ec., 0 gráf.; para: Clasificar impuestos (suma fija, proporcional, progresivo, regresivo);)
  - 4.B.16 [D] «progresividad» (0 ec., 0 gráf.; para: contenido que este tema debería desarrollar (previsto, sin fuente))
- `corlett-hague` (ref. 4.B.11; desarrollo en 4.B.11).
  - 4.B.7 [m] «Regla de Corlett-Hague (tipo uniforme distorsiona ocio-consumo)» (0 ec., 0 gráf.; para: Por qué un impuesto uniforme sobre el consumo no es neutral)
  - 4.B.9 [m] «Regla de Corlett-Hague» (0 ec., 0 gráf.; para: Gravar complementarios del ocio)
  - 4.B.11 [D] «Regla de Corlett-Hague (1953)» (1 ec., 0 gráf.; para: Gravar más los bienes complementarios del ocio; cuándo es óptimo el ti)
  - 4.B.13 [r] «Regla de Corlett-Hague» (1 ec., 0 gráf.; para: Un IVA uniforme distorsiona la elección ocio-consumo)
- `armonizacion-fiscal-ue` (ref. 4.B.13; desarrollo en 4.B.18, 4.B.20).
  - 4.B.13 [r] «Armonización de la imposición indirecta en la UE (1967/1977, Cockfield» (0 ec., 0 gráf.; para: Anexo 2)
  - 4.B.18 [D] «Armonización fiscal en la UE (igualación, aproximación, diferencial)» (0 ec., 0 gráf.; para: Eje del viejo tema; en el nuevo 4.B.18 solo como contexto de fiscalida)
  - 4.B.20 [D] «armonizacion-fiscal-ue» (0 ec., 0 gráf.; para: contenido que este tema debería desarrollar (previsto, sin fuente))
- `financiacion-autonomica` (ref. 4.B.14; desarrollo en 4.B.14, 4.B.25).
  - 4.B.14 [D] «financiacion-autonomica» (0 ec., 0 gráf.; para: contenido que este tema debería desarrollar (previsto, sin fuente))
  - 4.B.25 [D] «financiacion-autonomica» (0 ec., 0 gráf.; para: contenido que este tema debería desarrollar (previsto, sin fuente))
- `musgrave-funciones` (ref. 4.B.14; desarrollo en 4.B.14).
  - 4.B.1 [m] «Funciones asignativa, redistributiva y estabilizadora (Musgrave)» (0 ec., 0 gráf.; para: Justificar la intervención pública en la introducción)
  - 4.B.5 [m] «Funciones del sector público de Musgrave (asignación, redistribución, » (0 ec., 0 gráf.; para: Introducción)
  - 4.B.14 [D] «musgrave-funciones» (0 ec., 0 gráf.; para: contenido que este tema debería desarrollar (previsto, sin fuente))
- `oates-descentralizacion` (ref. 4.B.14; desarrollo en 4.B.14, 4.B.25).
  - 4.B.14 [D] «oates-descentralizacion» (0 ec., 0 gráf.; para: contenido que este tema debería desarrollar (previsto, sin fuente))
  - 4.B.25 [D] «oates-descentralizacion» (0 ec., 0 gráf.; para: contenido que este tema debería desarrollar (previsto, sin fuente))
- `tiebout` (ref. 4.B.14; desarrollo en 4.B.14, 4.B.25).
  - 4.B.2 [m] «Votar con los pies (Tiebout)» (0 ec., 0 gráf.; para: Federalismo como límite al crecimiento del gasto)
  - 4.B.14 [D] «tiebout» (0 ec., 0 gráf.; para: contenido que este tema debería desarrollar (previsto, sin fuente))
  - 4.B.25 [D] «tiebout» (0 ec., 0 gráf.; para: contenido que este tema debería desarrollar (previsto, sin fuente))
- `separacion-vertical` (ref. 4.B.15; desarrollo en 4.B.15).
  - 4.A.12 [r] «Separación vertical infraestructura/servicio (Renfe-ADIF, AENA-ENAIRE,» (0 ec., 0 gráf.; para: Introducir competencia en servicios de red)
  - 4.A.28 [r] «Separación vertical de industrias de red y costes de transición a la c» (0 ec., 0 gráf.; para: liberalización de los 90)
  - 4.B.15 [D] «Liberalización y privatización de industrias red (acceso regulado, sep» (0 ec., 1 gráf.; para: Cómo privatizar cuando hay un componente de monopolio natural)
- `irpf` (ref. 4.B.16; desarrollo en 4.B.12, 4.B.16).
  - 4.B.7 [m] «IRPF» (0 ec., 0 gráf.; para: Ejemplo de impuesto directo, personal, subjetivo, progresivo, dual (ba)
  - 4.B.10 [m] «IRPF (tipos marginales, tributación de dividendos, plusvalías e intere» (0 ec., 0 gráf.; para: Ejemplos de efectos incentivo; Miller (1977))
  - 4.B.12 [D] «IRPF (España y comparación internacional)» (0 ec., 2 gráf.; para: Figura central del tema: características, historia, liquidación, progr)
  - 4.B.16 [D] «irpf» (0 ec., 0 gráf.; para: contenido que este tema debería desarrollar (previsto, sin fuente))
- `impuesto-sociedades` (ref. 4.B.17; desarrollo en 4.B.12, 4.B.17).
  - 4.B.7 [m] «Impuesto sobre sociedades» (0 ec., 0 gráf.; para: Ejemplo de impuesto sintético)
  - 4.B.10 [r] «Impuesto sobre sociedades (deducibilidad de intereses, escudo fiscal)» (0 ec., 0 gráf.; para: Efectos sobre estructura de capital e inversión)
  - 4.B.12 [D] «Impuesto sobre sociedades (España y comparación internacional)» (0 ec., 1 gráf.; para: Justificación, liquidación, regímenes especiales, tipos OCDE, efectos )
  - 4.B.17 [D] «impuesto-sociedades» (0 ec., 0 gráf.; para: contenido que este tema debería desarrollar (previsto, sin fuente))
- `pilares-ocde` (ref. 4.B.18; desarrollo en 4.B.17).
  - 4.B.17 [D] «pilar-2» (0 ec., 0 gráf.; para: contenido que este tema debería desarrollar (previsto, sin fuente))
  - 4.B.18 [m] «Acuerdo OCDE/G-20 de dos pilares (2021): pilar 1 reasignación de benef» (0 ec., 0 gráf.; para: Solo como antecedente del impuesto digital; debería ser núcleo del nue)
- `ibi` (ref. 4.B.19; desarrollo en 4.B.19).
  - 4.B.7 [m] «IBI» (0 ec., 0 gráf.; para: Ejemplo de impuesto real, objetivo, municipal)
  - 4.B.12 [r] «Impuesto sobre bienes inmuebles» (0 ec., 0 gráf.; para: Justificación, críticas (regresividad, valor catastral), peso municipa)
  - 4.B.19 [D] «ibi» (0 ec., 0 gráf.; para: contenido que este tema debería desarrollar (previsto, sin fuente))
- `impuesto-patrimonio` (ref. 4.B.19; desarrollo en 4.B.12, 4.B.19).
  - 4.B.12 [D] «Impuesto sobre el patrimonio» (0 ec., 0 gráf.; para: Justificación, críticas, competencia entre CCAA, comparación internaci)
  - 4.B.19 [D] «impuesto-patrimonio» (0 ec., 0 gráf.; para: contenido que este tema debería desarrollar (previsto, sin fuente))
- `impuestos-especiales` (ref. 4.B.20; desarrollo en 4.B.13, 4.B.20).
  - 4.B.13 [D] «Impuestos especiales (alcohol, tabaco, hidrocarburos, electricidad)» (1 ec., 0 gráf.; para: Justificación (Pigou, elasticidad inversa, Ramsey, equidad), ad valore)
  - 4.B.18 [r] «Impuestos especiales armonizados (directivas 1992, 2003, 2020)» (0 ec., 0 gráf.; para: Tipos mínimos y principio de destino)
  - 4.B.20 [D] «impuestos-especiales» (0 ec., 0 gráf.; para: contenido que este tema debería desarrollar (previsto, sin fuente))
- `iva` (ref. 4.B.20; desarrollo en 4.B.13, 4.B.20).
  - 4.B.7 [m] «IVA» (0 ec., 0 gráf.; para: Ejemplo de impuesto indirecto multifásico no acumulativo, ad valorem e)
  - 4.B.13 [D] «Cálculo del valor añadido e IVA por adición/sustracción, método direct» (4 ec., 1 gráf.; para: Explicar por qué la UE usa el método de sustracción indirecto (de créd)
  - 4.B.18 [r] «IVA: principio de origen frente a destino y régimen transitorio intrac» (0 ec., 0 gráf.; para: Armonización del IVA (Directivas 1967, sexta directiva 1977, régimen t)
  - 4.B.20 [D] «iva» (0 ec., 0 gráf.; para: contenido que este tema debería desarrollar (previsto, sin fuente))
- `loepsf` (ref. 4.B.21; desarrollo en 4.B.21, 4.B.25).
  - 4.B.2 [r] «Art. 135 CE y LOEPSF (estabilidad presupuestaria, regla de gasto, lími» (0 ec., 0 gráf.; para: Constitución fiscal en España)
  - 4.B.4 [m] «Art. 135 CE y LOEPSF (art. 11)» (0 ec., 0 gráf.; para: Marco normativo del déficit estructural)
  - 4.B.5 [m] «Ley Orgánica de Estabilidad Presupuestaria y Sostenibilidad Financiera» (0 ec., 0 gráf.; para: Límite legal al gasto)
  - 4.B.21 [D] «Reforma del art. 135 CE (2011)» (0 ec., 0 gráf.; para: Límites de déficit estructural y deuda, autorización por ley, priorida)
  - 4.B.22 [r] «LOEPSF y art. 135 CE» (0 ec., 0 gráf.; para: Medidas nacionales de consolidación)
  - 4.B.25 [D] «loepsf» (0 ec., 0 gráf.; para: contenido que este tema debería desarrollar (previsto, sin fuente))
  - 4.B.26 [r] «Art. 135 CE, LOEPSF y AIReF» (0 ec., 0 gráf.; para: Medidas nacionales de consolidación)
- `regla-gasto` (ref. 4.B.21; desarrollo en 4.B.21).
  - 4.B.2 [m] «Regla de gasto» (0 ec., 0 gráf.; para: Ejemplo de límite al crecimiento del gasto)
  - 4.B.21 [D] «Regla de gasto nacional (art. 12 LOEPSF)» (0 ec., 0 gráf.; para: El gasto computable no puede crecer más que el PIB de medio plazo (med)
  - 4.B.22 [r] «Regla de gasto (europea y art. 12 LOEPSF)» (0 ec., 0 gráf.; para: Control comunitario y nacional del gasto; gasto computable excluye int)
- `clasificaciones-presupuestarias` (ref. 4.B.22; desarrollo en 4.B.22).
  - 4.B.5 [r] «Clasificaciones orgánica, económica (capítulos I–IX) y por programas d» (0 ec., 2 gráf.; para: Clasificar el gasto público)
  - 4.B.21 [r] «Clasificación económica (capítulos I-IX), orgánica y funcional/por pol» (0 ec., 0 gráf.; para: Se explica con las cifras del PGE 2023)
  - 4.B.22 [D] «Clasificación orgánica, económica (capítulos I-IX) y funcional/por pro» (0 ec., 0 gráf.; para: Núcleo del título)
- `pge` (ref. 4.B.22; desarrollo en 4.B.21, 4.B.22).
  - 4.B.21 [D] «Presupuestos Generales del Estado: concepto, ámbito consolidado y cicl» (0 ec., 2 gráf.; para: Núcleo del tema)
  - 4.B.22 [D] «Presupuestos Generales del Estado consolidados 2023: grandes cifras» (0 ec., 4 gráf.; para: Grandes cifras y clasificaciones del gasto (583.543 M€ consolidados; 4)
- `cofog` (ref. 4.B.23; desarrollo en 4.B.22, 4.B.23).
  - 4.B.5 [r] «Clasificación funcional COFOG» (0 ec., 2 gráf.; para: Comparación internacional del gasto por funciones)
  - 4.B.22 [D] «Clasificación funcional COFOG (10 funciones)» (0 ec., 2 gráf.; para: Valoración del gasto por funciones y comparación con la UE (datos 2021)
  - 4.B.23 [D] «cofog» (0 ec., 0 gráf.; para: contenido que este tema debería desarrollar (previsto, sin fuente))
- `efp` (ref. 4.B.23; desarrollo en 4.B.23).
  - 4.B.1 [r] «Estadísticas de Finanzas Públicas (presentación integrada)» (0 ec., 1 gráf.; para: Presentar todas las operaciones no financieras de las AAPP en una únic)
  - 4.B.5 [r] «Estadísticas de Finanzas Públicas (presentación SEC del gasto)» (0 ec., 0 gráf.; para: Clasificación del gasto en contabilidad nacional)
  - 4.B.7 [r] «Ingresos en las EFP del SEC-2010 (impuestos sobre productos, sobre la » (0 ec., 0 gráf.; para: Clasificación de ingresos en contabilidad nacional)
  - 4.B.22 [r] «Estadísticas de Finanzas Públicas (presentación SEC de ingresos y gast» (0 ec., 0 gráf.; para: Gastos corrientes y de capital por cuentas del SEC)
  - 4.B.23 [D] «efp» (0 ec., 0 gráf.; para: contenido que este tema debería desarrollar (previsto, sin fuente))
- `programa-estabilidad` (ref. 4.B.23; desarrollo en 4.B.23).
  - 4.B.21 [m] «Programa de Estabilidad y Programa Nacional de Reformas (Semestre Euro» (0 ec., 0 gráf.; para: Fase preliminar del ciclo presupuestario)
  - 4.B.22 [r] «Programa de Estabilidad 2019-2022» (0 ec., 0 gráf.; para: Perspectivas del gasto)
  - 4.B.23 [D] «programa-estabilidad» (0 ec., 0 gráf.; para: contenido que este tema debería desarrollar (previsto, sin fuente))
  - 4.B.26 [r] «Programa de Estabilidad 2019-2022» (0 ec., 0 gráf.; para: Perspectivas del saldo)
- `fla-ffpp` (ref. 4.B.25; desarrollo en 4.B.25).
  - 4.B.21 [m] «Mecanismos extraordinarios de liquidez (FLA, pago a proveedores)» (0 ec., 0 gráf.; para: Excepción a la no corresponsabilidad financiera; condicionalidad)
  - 4.B.25 [D] «fla-ffpp» (0 ec., 0 gráf.; para: contenido que este tema debería desarrollar (previsto, sin fuente))
  - 4.B.26 [m] «FLA y Fondo para la Financiación de los Pagos a Proveedores» (0 ec., 0 gráf.; para: Ajuste déficit-deuda; salida a mercados de las CCAA)
- `arrow-imposibilidad` (ref. 3.A.24; desarrollo en 3.A.24, 4.B.2).
  - 3.A.24 [D] «Teorema de imposibilidad de Arrow (1951)» (3 ec., 0 gráf.; para: ¿Existe una regla de agregación de preferencias ordinales que cumpla a)
  - 4.B.2 [D] «Teorema de imposibilidad de Arrow (1951)» (3 ec., 0 gráf.; para: Mostrar que ninguna regla de votación agrega preferencias cumpliendo c)
- `barro-1990` (ref. 3.A.38; desarrollo en 3.A.38, 3.A.44, 4.B.1, 4.B.5). **Posible copia literal** (mismo nombre y mismas ecuaciones): 4.B.1, 4.B.5.
  - 3.A.38 [D] «Política fiscal y crecimiento endógeno (Barro, 1990)» (0 ec., 0 gráf.; para: )
  - 3.A.44 [D] «Modelo AK con gasto público productivo (Barro, 1990)» (4 ec., 1 gráf.; para: Impuestos y gasto productivo en el crecimiento a largo plazo.)
  - 4.A.11 [m] «Modelo de crecimiento de Barro con gasto público productivo» (0 ec., 0 gráf.; para: Justificar el efecto de oferta de la obra civil sobre el crecimiento p)
  - 4.B.1 [D] «Modelo AK con gasto público productivo (Barro, 1990)» (5 ec., 1 gráf.; para: Tamaño óptimo del gasto público que maximiza el crecimiento)
  - 4.B.5 [D] «Modelo AK con gasto público productivo (Barro, 1990)» (5 ec., 1 gráf.; para: Tamaño óptimo del sector público desde el crecimiento: tipo impositivo)
- `fisher-intertemporal` (ref. 3.A.33; desarrollo en 3.A.29, 3.A.33, 4.B.9, 4.B.10).
  - 3.A.29 [D] «Elección intertemporal de consumo (Fisher, dos periodos)» (2 ec., 1 gráf.; para: Decisión consumo/ahorro como piedra angular del análisis dinámico.)
  - 3.A.33 [D] «Microfundamentación de Fisher (1930)» (1 ec., 0 gráf.; para: )
  - 4.B.9 [D] «Impuestos y ahorro en un modelo de dos periodos (Fisher)» (3 ec., 1 gráf.; para: Efectos de impuestos de suma fija, salariales, sobre el consumo y sobr)
  - 4.B.10 [D] «Modelo de ciclo vital de 2 periodos (Fisher) con impuestos» (2 ec., 2 gráf.; para: Efectos de impuestos de suma fija, sobre salarios, sobre el consumo y )
- `jorgenson` (ref. 3.A.34; desarrollo en 3.A.34, 4.B.10).
  - 3.A.34 [D] «Modelo neoclásico (Jorgenson, 1963)» (1 ec., 0 gráf.; para: Coste de uso del capital.)
  - 4.B.10 [D] «Coste de uso del capital con impuesto de sociedades» (4 ec., 0 gráf.; para: Efecto del IS sobre la inversión según la deducibilidad de los costes )
- `modigliani-miller` (ref. 3.B.3; desarrollo en 3.B.3, 4.B.10).
  - 3.B.3 [D] «Modigliani y Miller (1958) y extensiones (impuestos, insolvencia de Ki» (2 ec., 2 gráf.; para: ¿existe una estructura financiera óptima?)
  - 4.B.10 [D] «Teorema de Modigliani-Miller (1958) y con impuestos (MM 1963; Miller 1» (4 ec., 3 gráf.; para: Efecto del IS y del IRPF sobre la estructura de capital (escudo fiscal)
  - 4.B.12 [m] «Modigliani-Miller» (0 ec., 0 gráf.; para: El IS rompe la irrelevancia de la estructura financiera y de la políti)
- `nek-3-ecuaciones` (ref. 3.A.7; desarrollo en 3.A.7, 3.A.36, 3.A.37, 3.A.38, 3.A.42, 4.B.4).
  - 3.A.7 [D] «Modelo canónico de la NEK (IS dinámica, NKPC, regla de Taylor)» (3 ec., 0 gráf.; para: NEK de 2.ª generación)
  - 3.A.36 [D] «Modelo canónico de 3 ecuaciones de la NEK (Clarida, Galí y Gertler)» (2 ec., 0 gráf.; para: Política monetaria óptima.)
  - 3.A.37 [D] «Modelo neokeynesiano de 2.ª generación» (3 ec., 0 gráf.; para: Transmisión con rigideces nominales; divina coincidencia; ELB.)
  - 3.A.38 [D] «NEK con política fiscal» (1 ec., 0 gráf.; para: Efectos del gasto con rigideces.)
  - 3.A.41 [m] «Curva de Phillips NEK (forma adelantada)» (1 ec., 0 gráf.; para: )
  - 3.A.42 [D] «Modelo canónico NEK» (1 ec., 0 gráf.; para: Ciclos nominales.)
  - 4.B.4 [D] «Modelo neokeynesiano canónico con gasto público (Clarida-Galí-Gertler » (4 ec., 1 gráf.; para: Multiplicador del gasto con rigideces nominales y respuesta monetaria)
- `oferta-trabajo` (ref. 3.A.25; desarrollo en 3.A.25, 4.B.10).
  - 3.A.25 [D] «Elección ocio-consumo» (1 ec., 1 gráf.; para: Oferta de trabajo individual y agregada.)
  - 4.B.10 [D] «Modelo neoclásico de elección consumo-ocio con impuestos» (5 ec., 4 gráf.; para: Efecto de distintos impuestos (suma fija, proporcional sobre salario, )
- `olg-samuelson-diamond` (ref. 3.A.29; desarrollo en 3.A.29, 3.A.38, 4.B.3).
  - 3.A.6 [m] «Generaciones solapadas» (0 ec., 0 gráf.; para: extensión)
  - 3.A.29 [D] «Modelo de generaciones solapadas» (1 ec., 0 gráf.; para: Contraste con horizonte infinito; ineficiencia dinámica.)
  - 3.A.35 [r] «Generaciones solapadas (Samuelson 1958)» (0 ec., 0 gráf.; para: Valor del dinero fiduciario.)
  - 3.A.38 [D] «Generaciones solapadas y pensiones (capitalización frente a reparto)» (2 ec., 0 gráf.; para: Efectos sobre el ahorro.)
  - 4.B.3 [D] «Generaciones solapadas con pensiones de capitalización y de reparto (S» (4 ec., 1 gráf.; para: Efecto de la Seguridad Social sobre el ahorro privado y comparación re)
- `restriccion-gobierno` (ref. 3.A.39; desarrollo en 3.A.39, 4.B.26).
  - 3.A.39 [D] «Restricción presupuestaria del sector público y dinámica de la deuda» (2 ec., 1 gráf.; para: Sostenibilidad de la deuda.)
  - 4.B.26 [D] «Restricción presupuestaria consolidada del sector público (Walsh, cap.» (5 ec., 0 gráf.; para: Fuentes de financiación del gasto: impuestos, deuda y señoreaje; víncu)
- `suavizacion-impositiva-barro` (ref. 3.A.39; desarrollo en 3.A.39, 4.B.11).
  - 3.A.39 [D] «Suavización impositiva (Barro 1979)» (0 ec., 0 gráf.; para: )
  - 4.B.9 [r] «Suavización impositiva de Barro (1979)» (2 ec., 0 gráf.; para: Tipo constante minimiza el valor presente de las distorsiones)
  - 4.B.11 [D] «Suavización impositiva (Barro 1979)» (2 ec., 0 gráf.; para: Distribución temporal óptima de los impuestos y papel de la deuda)
- `van-tir` (ref. 3.B.2; desarrollo en 3.B.2, 4.B.6).
  - 3.B.2 [D] «Criterios VAN, TIR, TIRM y payback» (4 ec., 1 gráf.; para: cómo seleccionar proyectos de inversión)
  - 4.B.6 [D] «Valor actual neto» (1 ec., 0 gráf.; para: Regla de decisión de referencia)

**Bloques repetidos o copiados entre temas** (según las observaciones de los inventarios):

- 4.B.2: Autorreferencia dentro del propio 4.B.2 (nota copiada de 3.A.24);
- 4.B.4: estancamiento-secular → 3.A.40 (duplicado literal en 4.B.1 y 4.B.4).
- 4.B.5: La delimitación S.13/S.11/S.12 está copiada casi literal en 4.B.7 (viejo 4.B.8) y 4.B.1: conviene un único desarrollo en 4.B.1.
- 4.B.7: La delimitación S.13/S.11/S.12 está copiada literal del viejo 4.B.6 (hoy 4.B.5): dejarla solo en 4.B.1.
- 4.B.8: El modelo de Harberger aparece casi idéntico en 4.B.9 (viejo 4.B.10, apartado 1.4): desarrollarlo aquí (incidencia) y en 4.B.9 solo remitir para los efectos sobre la eficiencia en la producción.
- 4.B.15: Coordinar con 4.B.1 (delimitación SEC del sector público empresarial y del S.13: copia literal de notas al pie), con 3.A.17/3.A.20 (monopolio natural y regulación, que aquí no deben desarrollarse), con 3.A.23 (fallos de mercado y del sector público) y 4.A.15 (liberalización y competencia en España).
- 4.B.22: Gran solapamiento: el apartado 2 (historia) es casi idéntico al apartado 1 del viejo 4.B.27 (4.B.26) y las secciones de LOEPSF/art.

Autor: Víctor Gutiérrez Marcos
