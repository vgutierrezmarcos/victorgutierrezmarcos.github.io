# Marco input-output (tablas de origen, destino y simétrica; modelos de Leontief de cantidades y de precios)

- **Área:** macro cerrada (contabilidad nacional) · **Tema de referencia:** **3.A.31** (Análisis de las tablas «input-output»), **revisado el 11/11/2026**, con fuente: el antiguo Tema 3.A.27 de Víctor, un borrador a medias que seguía a Muñoz Cidad, redactado de nuevo, con el bloque II escrito entero. Lo tiene en el título y es el único que lo desarrolla en extenso (I descripción de las tablas; II modelos de demanda y de precios, eslabonamientos y economía aplicada; III utilidad y limitaciones; anexos A-D). El 3.A.30 lo resume y remite aquí.
- **Temas que lo usan:** 3.A.31 (desarrollo), 3.A.30 (resumen), 4.A.1 (resumen), 3.B.18 y 4.A.22 (resumen de la medición de las cadenas globales de valor), 3.B.11 (mención: comercio en valor añadido), 3.B.5 (mención: la paradoja como $\vect{a}_L^{\top}(I-A)^{-1}$), 3.B.7 (mención: $a_{ij}$ en la protección efectiva), 3.A.21 (mención: MCS y calibración de los MEGC), 3.B.28 (mención: eslabonamientos de Hirschman), 3.B.31 (mención posible: emisiones incorporadas).
- **Manuales de referencia:** Miller y Blair, *Input-Output Analysis* (3.ª ed., 2022; `MillerBlair2022`); Eurostat, *Manual of Supply, Use and Input-Output Tables* (2008; `Eurostat2008Manual`); SEC 2010, cap. 9 (`SEC2010`); Leontief (1936, 1941); Hawkins y Simon (1949); Rasmussen (1956); Chenery y Watanabe (1958).
- **Decisión D112 (13/10/2026):** tema de referencia, el 3.A.31. Confirmado por su revisión (11/11/2026).
- **Notación:** la de `notacion.md` § 0 (regla de las matrices) y § 7, «Contabilidad nacional y marco *input-output*» (CC1-CC2 del 3.A.31, **[decidir]**).

## Presentación de referencia (3.A.31)

**Pregunta:** ¿cuánto tiene que producir cada rama para atender una demanda final dada y cómo se trasladan los costes a los precios? Una sola matriz, la inversa de Leontief, responde a las 2: leída por columnas da el modelo de demanda, y por filas, el de precios.

**I. Las tablas.**
- *Tablas de origen y de destino* (SEC 2010, cap. 9; SCN 2025): productos (CPA) por ramas de actividad (UAE locales, CNAE); valoración a **precios básicos** y **de adquisición** (márgenes de comercio y transporte, impuestos netos sobre los productos); identidades oferta = demanda por producto y producción = consumos intermedios + VAB por rama.
- *Tabla simétrica* (producto × producto o rama × rama), con el supuesto de **tecnología de producto** o el de **tecnología de rama**; ramas homogéneas (unidades de producción homogénea). El INE publica la tabla producto × producto de 65 productos (la de 2022, el 19/12/2025).
- *3 bloques*: consumos intermedios $Z=[z_{ij}]$ (lo que $j$ compra a $i$), demanda final ($C$, $G$, FBC, $X$; suma $d_i$) e inputs primarios ($M_j$; $\mathrm{VAB}_j=\mathrm{RA}_j+\mathrm{EBE}_j+{}$otros impuestos netos sobre la producción).
- *Identidades*: $x_i=\sum_jz_{ij}+d_i$ (`eq:filas`), $x_j=\sum_iz_{ij}+M_j+\mathrm{VAB}_j$ (`eq:columnas`) y $\sum_j\mathrm{VAB}_j=C+G+\mathrm{FBC}+X-M$ (`eq:pib-io`), a precios básicos. El PIB a precios de mercado es el VAB a precios básicos más los impuestos netos sobre los productos.
- *Coeficientes técnicos*: $a_{ij}\equiv z_{ij}/x_j$, $A=Z\operatorname{diag}(\vect{x})^{-1}$ (`eq:coeficiente`); $m_j$, $v_j$ y $a_{Lj}$; cada columna suma 1 (`eq:suma-columna`). Son coeficientes en valor, no físicos.

**II. Los modelos** (estructura a)-e) de CRITERIOS).
- *Supuestos* (modelo abierto de Leontief): homogeneidad, proporcionalidad (coeficientes fijos, la tecnología de Leontief del 3.A.11), aditividad, oferta sin restricciones y demanda final exógena.
- *Modelo de demanda*, **función clave**: $\vect{x}=A\vect{x}+\vect{d}\;\Rightarrow\;\vect{x}=(I-A)^{-1}\vect{d}$ (`eq:modelo-demanda`). $I-A$ es la **matriz de Leontief** y $(I-A)^{-1}=[r_{ij}]$, su **inversa**. Condición de **Hawkins-Simon**. Las rondas: $(I-A)^{-1}=I+A+A^2+\cdots$ (`eq:serie`). Multiplicadores de producción (sumas de las columnas) y sensibilidad (sumas de las filas); coeficientes interiores frente a totales ($A^{\mathrm d}$ para los efectos en el país); empleo, importaciones y valor añadido incorporados, con `eq:contenido` $(\vect{v}+\vect{m})^{\top}(I-A)^{-1}=\vect{1}^{\top}$; efecto inducido y multiplicadores de **tipo I y II**. Evidencia: la TIO 2022 del INE (multiplicador medio de 1,74; el 61,8 % de las importaciones son intermedias) y TiVA 2024 del INE (5,2 millones de empleos ligados a la exportación).
- *Modelo de precios*, **función clave gemela en forma fila**: $\vect{p}^{\top}=\vect{p}^{\top}A+\vect{v}^{\top}\;\Rightarrow\;\vect{p}^{\top}=\vect{v}^{\top}(I-A)^{-1}$ (`eq:modelo-precios`; A31-03, **[decidir]**; la forma columna, $\vect{p}=(I-A^{\top})^{-1}\vect{v}$, en una viñeta). Supuestos: coeficientes fijos, traslación íntegra, cantidades dadas y precios índice con base 1. Dualidad, `eq:dualidad` $\vect{p}^{\top}\vect{d}=\vect{v}^{\top}\vect{x}$. Con importaciones, $\vect{v}^{\top}+p^{\mathrm M}\vect{m}^{\top}$. Evidencia: CaixaBank Research (2023) y Arce *et al.* (2024) para la energía en 2022 (como el 3.A.41). Caja de PageRank (anécdota, no se canta).
- *Eslabonamientos*: Hirschman (crecimiento **desequilibrado**, como el 3.B.28); **Chenery y Watanabe** ($\mathrm{EA}_j$, $\mathrm{ED}_i$, tabla de 4 grupos); **Rasmussen** ($\mathrm{PD}_j$, $\mathrm{SD}_i$, `eq:rasmussen`; sectores clave, impulsores, estratégicos e independientes); Streit; Ghosh en nota.
- *Economía aplicada*: paradoja de Leontief (3.B.5); cadenas globales de valor con tablas multirregionales (WIOD, TiVA de la OCDE, FIGARO; 3.B.18, 4.A.22); medio ambiente (Leontief, 1970; huella de carbono, 3.B.31); MCS y MEGC (Pyatt y Round, 1979; 3.A.21); redes de producción (Long y Plosser; Acemoglu *et al.*; Hulten; Baqaee y Farhi; 3.A.42).

**III. Utilidad y limitaciones**: el debate del cálculo económico (Barone, Mises, Lange, Hayek; 3.A.3) y los usos de hoy; las hipótesis (homogeneidad, proporcionalidad, aditividad); los coeficientes que envejecen (método RAS, Stone, 1961); un modelo lineal y estático, con la demanda exógena; el retraso (unos 3 años: la TIO 2023 sale el 15/12/2026) y el coste.

**Ejemplo canónico de 2 ramas** (industria y servicios, millones de euros, precios básicos; `tab:ejemplo` del 3.A.31). Los temas que resuman el marco usan estos números:

| | Industria | Servicios | $C$ | $G$ | FBC | $X$ | $d_i$ | $x_i$ |
|---|---|---|---|---|---|---|---|---|
| Industria | 20 | 20 | 20 | 0 | 15 | 25 | 60 | 100 |
| Servicios | 40 | 40 | 80 | 30 | 5 | 5 | 120 | 200 |
| $M_j$ | 10 | 10 | | | | | | |
| $\mathrm{RA}_j$ | 20 | 90 | | | | | | |
| $\mathrm{EBE}_j$ | 10 | 40 | | | | | | |
| $\mathrm{VAB}_j$ | 30 | 130 | | | | | | |
| $x_j$ | 100 | 200 | | | | | | |
| $L_j$ (miles) | 10 | 40 | | | | | | |

$A=\begin{pmatrix}0{,}2&0{,}1\\0{,}4&0{,}2\end{pmatrix}$, $\det(I-A)=0{,}6$ y $(I-A)^{-1}=\begin{pmatrix}4/3&1/6\\2/3&4/3\end{pmatrix}$. El PIB es 160 por las 3 vías. Los multiplicadores de producción son 2 y 1,5 (de tipo II, si los hogares gastan el 80 % de los salarios: 3,4 y 3,1), y cada ronda es el 40 % de la anterior (el autovalor de $A$ es 0,4). $\vect{m}=(0{,}10;\,0{,}05)$, $\vect{v}=(0{,}30;\,0{,}65)$, $\vect{a}_L=(0{,}1;\,0{,}2)$; $\vect{v}^{\top}(I-A)^{-1}=(0{,}83;\,0{,}92)$, $\vect{m}^{\top}(I-A)^{-1}=(0{,}17;\,0{,}08)$ y los multiplicadores de empleo, $(0{,}27;\,0{,}28)$. $\mathrm{PD}=(1{,}14;\,0{,}86)$ y $\mathrm{SD}=(0{,}86;\,1{,}14)$: la industria es impulsora y los servicios, estratégicos. El ejemplo de 3 ramas está en el anexo B del 3.A.31.

**Gráficos de referencia** (en `fuentes/3A31/graficos/`): **`tabla-simetrica.tex`** (los 3 bloques, por capas: el bloque I en `tceeazul`, el II en `tceeverde` y el III en `tceedorado`) y, para los eslabonamientos, **`rasmussen-cuadrantes.tex`** (los 4 cuadrantes con los 2 puntos del ejemplo). De apoyo: `origen-destino.tex`, `valoracion-precios.tex`, `rondas-iterativo.tex`, `efectos-multiplicadores.tex`, `rasmussen-espana.tex` y `contenido-importado-ue.tex` (datos de FIGARO de 2024).

**Claves bibliográficas comunes**: `SEC2010`, `MillerBlair2022`, `HawkinsSimon1949`, `Leontief1936Quantitative`, `Leontief1953Domestic` (la del 3.B.5), `ArceEtAl2024What` (la del 3.A.41), `Rasmussen1956Studies`, `CheneryWatanabe1958`, `Stone1961`, `INE2025TIO2022`, `INE2026TiVA2024`, `OCDE2025TiVA` (el 3.B.11 cita la edición anterior, `OCDE2023TiVA`).

## Cómo se adapta en cada tema

| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.31 | Análisis de las tablas *input-output* | **desarrollo (hecho, 11/11/2026)** | Todo lo anterior | — |
| 3.A.30 | Contabilidad nacional | resumen (en revisión el 11/11/2026) | El lugar del marco en el SEC 2010 (las tablas de origen y destino como marco de cuadre), producción = CI + VAB y el PIB por las 3 vías; las mismas unidades (UAE locales, UPH) y la misma descomposición del VAB, con «otros impuestos netos sobre la producción»; $X$ exportaciones; `\vertema{3.A.31}` | La descripción de los 3 bloques y los modelos (su Word la repetía casi palabra por palabra, l. 1266-1340) |
| 4.A.1 | Fuentes estadísticas de la economía española | resumen | Las tablas de origen, destino y simétrica del INE como fuente estructural (la TIO, anual desde 2021, aunque el SEC solo obliga a la quinquenal; retraso de unos 3 años) y TiVA del INE; `\vertema{3.A.31}` (su Word cita «3.A.27», la numeración antigua) | Los modelos; «RX» sin definir: $\mathrm{VAB}=\mathrm{RA}+\mathrm{EBE}+{}$otros impuestos netos sobre la producción |
| 3.B.18 | Cadenas globales de valor | resumen de la medición | El contenido extranjero de las exportaciones (participación hacia atrás y hacia delante) con tablas multirregionales y `eq:contenido`; Johnson y Noguera (2012), Koopman, Wang y Wei (2014). La teoría y los determinantes son suyos | El álgebra de la inversa |
| 4.A.22 | España en las CGV | resumen de la medición | Los datos de España: FIGARO, 25,7 % (2024); INE, 27,7 % (2024); OCDE, 26,6 % (2022), con la nota de por qué difieren; 19,9 % hacia delante | El álgebra |
| 3.B.11 | Balanza de pagos | mención | La servicificación y el comercio en valor añadido (déficit bilateral de Estados Unidos con China), con `\vertema{3.A.31}`; si quiere un dato de España, el del INE (TiVA 2024: 72,3/27,7 %) | El álgebra |
| 3.B.5 | Teoría del comercio (I) | mención (hecho, 10/11/2026) | La paradoja de Leontief con la tabla de 1947, las cifras 18.184 y 13.991 y `\vertema{3.A.31}` | El modelo |
| 3.B.7 | Política comercial | mención (hecho, 5/11/2026) | $a_{ij}$ en la protección efectiva, con la tabla *input-output* y `\vertema{3.A.31}` | — |
| 3.A.21 | Aplicaciones del equilibrio general | mención (hecho, 14/10/2026) | La MCS amplía las tablas y calibra los MEGC (`\vertema{3.A.31}`) | — |
| 3.B.28 | Economía del desarrollo | mención (hecho, 3/11/2026) | Hirschman y los eslabonamientos hacia atrás (automóvil) y hacia delante (acero), crecimiento desequilibrado; **falta `\vertema{3.A.31}`**, donde se miden (pendiente de coherencia) | La medición |
| 3.B.31 | Cambio climático | mención (posible) | Emisiones incorporadas y huella de carbono del consumo frente a las de la producción, en la fuga de carbono (el 3.A.31 le remite) | — |

## Divergencias encontradas en el temario actual

- **Resuelta en el canon (11/11/2026):** la ficha anterior escribía la producción como $X_j$ y los flujos como $x_{ij}$, las matrices en negrita, «encadenamientos», «VA» y «VA = RA + EBE + impuestos netos sobre la producción» (sin «otros»), y daba el 3.A.31 «sin fuente». Ahora: $\vect{x}$ en minúscula, $z_{ij}$, matrices en cursiva, «eslabonamientos», VAB y «**otros** impuestos netos sobre la producción».
- **Errores del Word corregidos en el 3.A.31** (para que no reaparezcan en otros temas): Hirschman defendía el crecimiento **desequilibrado** (el Word decía «equilibrado»); la primera tabla de Leontief tenía 44 sectores, 41 de ellos productivos; las «*empty boxes*» son de Clapham (1922), no de Leontief; Schumpeter llamó a la obra de Walras «the Magna Carta of economic theory», sin «piedra miliar»; con la matriz total, el modelo sobrestima los efectos interiores; el PIB solo coincide con el VAB si no hay impuestos sobre los productos; fueron Stone y Meade (no Hicks y Stone) los del Gabinete de Guerra; la matriz de Leontief es $I-A$ y su inversa, $(I-A)^{-1}$ (no al revés, como Tebar).
- **3.A.30** (en revisión): repite la descripción de las 3 tablas y sus 3 bloques; tiene el mismo enganche que el Word del 3.A.31 («no se puede gestionar lo que no se puede medir», que se queda en el 3.A.30) y la misma contextualización (Keynes, Kuznets, Stone); escribe las exportaciones como $E$ en la tabla y como $X$ en el PIB.
- **4.A.1** (sin revisar): «[ver tema 3.A.27]» (numeración antigua) y «RX» sin definir.
- **3.B.11 y 3.B.28** (revisados): sin `\vertema{3.A.31}` (`pendientes-coherencia.md`, «Pendiente del 3.A.31»).
- La función de coeficientes fijos (ficha `leontief`, referencia el 3.A.11) es otro modelo: el 3.A.31 la cita como supuesto con `\vertema{3.A.11}`. La paradoja de Leontief tiene id propio (`paradoja-leontief`, referencia el 3.B.5). La ficha `cadenas-globales-valor` no se crea hasta que se revise el 3.B.18 (CC8).

Autor: Víctor Gutiérrez Marcos
