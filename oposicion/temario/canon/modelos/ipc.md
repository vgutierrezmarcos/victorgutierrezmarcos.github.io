# Índice de Precios de Consumo (IPC, IPCA e inflación subyacente)

- **Área:** economia-espanola · **Tema de referencia:** 4.A.1 (fuentes estadísticas) para la metodología; la teoría de los índices, en 3.A.9 [ficha `indices-precios`]
- **Temas que lo usan:** 4.A.1 (desarrollo), 3.A.9 (teoría), 3.A.41 (mención: sesgos e inflación), 4.A.22 (resumen: deflactores del ITC), 4.A.29 (resumen: inflación reciente), 4.A.16 (mención: indexación salarial), 3.B.22 (mención)
- **Manuales de referencia:** INE, metodología del IPC base 2021; Reglamento (UE) 2016/792 (IPCA); Informe Boskin (1996)

## Presentación de referencia
Mide la evolución de los precios de los bienes y servicios que consume la población residente en viviendas familiares. Mensual (con indicador adelantado), por CC. AA. y provincias. **Base 2021**; **Laspeyres encadenado** con ponderaciones actualizadas cada año (ecuación en la ficha `indices-precios`, notación $\omega_{i,t-1}$ para ponderaciones). Cesta de ≈1.000 artículos (verificar la cifra de la base vigente).
- **IPCA** (Eurostat): armonizado, base 2025=100 desde 2026 (verificar), es el que usa el BCE (objetivo simétrico del 2 % a medio plazo).
- **Inflación subyacente** (INE): índice general **sin alimentos no elaborados ni productos energéticos**.
- Sesgos: sustitución, calidad, nuevos bienes, nuevos establecimientos; exclusión de la vivienda en propiedad (proyecto europeo OOH).
- Otros: IPC a impuestos constantes; deflactor del consumo de la CN (Paasche encadenado).

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 4.A.1 | Fuentes estadísticas | Desarrollo | Todo lo anterior | La derivación teórica (3.A.9) |
| 4.A.22 | Indicadores de competitividad | Mención | IPC/IPCA como deflactor del TCER/ITC | — |
| 4.A.29 | Situación actual | Resumen | IPCA general y subyacente recientes | Metodología |

## Divergencias encontradas en el temario actual
- 4.A.1 lo presenta a la vez como Laspeyres de base fija ($w_{i0}$) y encadenado: usar encadenado con ponderaciones del año anterior.
- 4.A.1: «casi 500 artículos» y «nueva base (2001)»: actualizar a la base 2021.
- 4.A.1: subyacente «excluyendo los productos energéticos y los alimentos»: son los alimentos **no elaborados**.
- 4.A.1 usa $w_{i0}$ para ponderaciones (choca con $w$ salario): ver la ficha `indices-precios` **[decidir]**.
