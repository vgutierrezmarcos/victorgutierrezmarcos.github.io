# Índice de Precios de Consumo (IPC, IPCA e inflación subyacente)

- **Área:** economia-espanola · **Tema de referencia:** 4.A.1 (fuentes estadísticas) para la metodología; la teoría de los índices, en 3.A.9 (revisado el 13/10/2026) [ficha `indices-precios`]
- **Temas que lo usan:** 4.A.1 (desarrollo), 3.A.9 (teoría; caja del IPC, hecho), 3.A.8 (mención: ajuste por calidad con precios hedónicos; hecho), 3.A.41 (mención: sesgos e inflación), 4.A.22 (resumen: deflactores del ITC), 4.A.29 (resumen: inflación reciente), 4.A.16 (mención: indexación salarial), 3.B.22 (mención), 1D01 (uso: IV.1, IPC frente al deflactor y subyacente)
- **Manuales de referencia:** INE, *IPC base 2025. Metodología* (2026) y *Principales novedades metodológicas del IPC base 2025*; Reglamento (UE) 2016/792 (IPCA); Informe Boskin (1996)
- **Decisión D044 (13/10/2026):** ¿Qué letra llevan las ponderaciones de los índices (IPC, tipos de cambio efectivos, ITC)? ω_i (ω_{i,t−1} en el IPC; media geométrica con pesos ω_i en los tipos efectivos)

## Presentación de referencia
Mide la evolución de los precios de los bienes y servicios que consume la población residente en viviendas familiares. Mensual (con indicador adelantado), por CC. AA. y provincias.
- **Base 2025**, en vigor desde el índice de **enero de 2026** (sustituye a la base 2021); clasificación **ECOICOP versión 2** (13 grupos).
- **Laspeyres encadenado**: cada año se compara con los precios de **diciembre del año anterior** y se encadenan los eslabones; ponderaciones actualizadas cada año con la Contabilidad Nacional y la EPF (las de 2026, con datos de 2024) y por completo en cada cambio de base (ecuación en la ficha `indices-precios`, notación $\omega_{i,t-1}$).
- **Cesta 2026**: 487 artículos, 196 subclases, 13 grupos; los que más pesan, alimentos (17,4 %), restauración y alojamiento (17,0 %) y transporte (15,5 %) (INE, tabla 76156; datos comprobados en el 3.A.9).
- **IPCA** (Eurostat): armonizado, base 2025 = 100 desde 2026 (verificar al revisar 4.A.1), es el que usa el BCE (objetivo simétrico del 2 % a medio plazo).
- **Inflación subyacente**: la del INE es el índice general **sin alimentos no elaborados ni productos energéticos**; la que más sigue el BCE (Eurostat) es el **IAPC sin energía ni alimentos** (incluidos alcohol y tabaco) **[comprobar nombre vigente]**; hay además medias recortadas y medidas de exclusión variable. Al usar datos, decir cuál (C8 de la 1D01).
- **Sesgos**: sustitución (el de la teoría, ficha `indices-precios`), calidad, nuevos bienes, nuevos establecimientos; exclusión de la vivienda en propiedad (proyecto europeo OOH). Ajuste por calidad del INE: sobre todo precios de solapamiento, opinión de expertos e imputación (3.A.8).
- **Usos**: revalorización de las pensiones con la media de las tasas interanuales del IPC de los doce meses anteriores (LGSS, art. 58; 2,7 % en 2026), que es el enganche del 3.A.9.
- Otros: IPC a impuestos constantes; deflactor del consumo de la CN (Paasche encadenado).

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 4.A.1 | Fuentes estadísticas | Desarrollo | Todo lo anterior | La derivación teórica (3.A.9) |
| 3.A.9 | Índices de coste de la vida | Resumen (caja; hecho, 13/10/2026) | Laspeyres encadenado, base 2025, ponderaciones anuales, cesta, sesgo de sustitución; pensiones en el enganche | La metodología completa (remite a 4.A.1) |
| 4.A.22 | Indicadores de competitividad | Mención | IPC/IPCA como deflactor del TCER/ITC | — |
| 4.A.29 | Situación actual | Resumen | IPCA general y subyacente recientes | Metodología |
| 1D01 | Dictamen de coyuntura | Uso | Laspeyres encadenado como el 3.A.9 (más corto); subyacente del INE y del BCE; IPC frente al deflactor: si crece más, inflación importada; si menos, mejora de la RRI (el deflactor no recoge activos financieros) | La metodología y la teoría de los índices |

## Divergencias encontradas en el temario actual
- **Esta ficha** decía «base 2021»; corregida el 13/10/2026 a raíz del 3.A.9 (base 2025 desde enero de 2026). 3.A.8 y 3.A.9 revisados ya citan la metodología de la base 2025.
- 4.A.1 lo presenta a la vez como Laspeyres de base fija ($w_{i0}$) y encadenado: usar encadenado con precios de diciembre del año anterior y ponderaciones anuales.
- 4.A.1: «nueva base (2001)»: actualizar a la base 2025. Su «casi 500 artículos» encaja con la base 2025 (487).
- 4.A.1: subyacente «excluyendo los productos energéticos y los alimentos»: son los alimentos **no elaborados**.
- 4.A.1 usa $w_{i0}$ para ponderaciones (choca con $w$ salario): canon $\omega_{i,t-1}$ (ficha `indices-precios`).
