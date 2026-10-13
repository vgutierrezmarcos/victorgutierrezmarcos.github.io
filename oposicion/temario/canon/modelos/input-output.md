# Marco input-output (tablas de origen, destino y simétricas; modelo de Leontief)

- **Área:** macro cerrada · **Tema de referencia:** **3.A.31** (Análisis de las tablas «input-output»): lo tiene en el título; el mapa lo asignaba a 3.A.30 porque 3.A.31 no tiene fuente, pero 3.A.30 remite cuatro veces a 3.A.31 y dice que allí «no hay que explayarse».
- **Temas que lo usan:** 3.A.31 (desarrollo, previsto: sin fuente), 3.A.30 (resumen), 4.A.1 (resumen)
- **Manuales de referencia:** Eurostat, *Manual of Supply, Use and Input-Output Tables* (2008); SEC 2010, cap. 9; Miller y Blair, *Input-Output Analysis* (2.ª ed., 2009); Leontief (1936, 1941).
- **Decisión D112 (13/10/2026):** ¿Cuál es el tema de referencia de las tablas input-output? 3.A.31 (lo tiene en el título; sin fuente)

## Presentación de referencia
Pregunta: ¿cómo se relacionan las ramas productivas entre sí y cómo se propaga un cambio de la demanda final? Supuestos (modelo abierto de Leontief): n ramas; cada rama produce un único producto con coeficientes técnicos fijos a_{ij} = x_{ij}/X_j (rendimientos constantes, sin sustitución); demanda final exógena.

Identidades contables (tabla simétrica):
$$X_i = \sum_j x_{ij} + d_i,\qquad X_j = \sum_i x_{ij} + VA_j,\qquad VA = RA + EBE + (\text{impuestos netos sobre la producción})$$
$$\mathbf{X} = \mathbf{A}\mathbf{X} + \mathbf{d}\;\Rightarrow\;\mathbf{X} = (\mathbf{I}-\mathbf{A})^{-1}\mathbf{d}$$
Resultado: la inversa de Leontief da los multiplicadores (efectos directos e indirectos); condición de Hawkins-Simon para soluciones no negativas; modelo de precios dual $\mathbf{p} = \mathbf{p}\mathbf{A} + \mathbf{v}$. Usos: encadenamientos hacia atrás y hacia delante (Rasmussen), sectores clave, contenido importado, análisis de impacto.
Gráfico de referencia: esquema de las tablas de origen (productos × ramas, producción + importaciones), de destino (consumos intermedios, demanda final, VAB) y simétrica (producto × producto o rama × rama), con los tres cuadrantes.

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.31 | Análisis de las tablas IO | desarrollo (pendiente de redactar) | Tablas del SEC 2010, modelo de Leontief de cantidades y de precios, multiplicadores, encadenamientos, limitaciones | — |
| 3.A.30 | Contabilidad nacional | resumen | Lugar de las tablas IO dentro del SEC 2010 y la identidad producción = CI + VA | El modelo de Leontief [ver tema 3.A.31] |
| 4.A.1 | Fuentes estadísticas de la economía española | resumen | Tablas de origen, destino y simétrica del INE como fuente estructural; retraso en su publicación | Idem |

## Divergencias encontradas en el temario actual
- Tema de referencia: 3.A.31 (sin fuente), que lo tiene en el título; el mapa lo ponía en 3.A.30.
- 4.A.1 escribe la identidad VA = RA + EBE + RX (RX sin definir; debe ser impuestos netos sobre la producción y, si se quiere, renta mixta dentro del EBE).
- El modelo de Leontief de coeficientes fijos tiene ficha propia en el área consumidor-producción (`leontief`, función de producción): no confundir ambos usos.

Autor: Víctor Gutiérrez Marcos
