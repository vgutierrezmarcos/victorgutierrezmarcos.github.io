# Descomposición contable del PIB per cápita (y convergencia real de España)

- **Área:** economia-espanola · **Tema de referencia:** **[decidir]** el mapa propone 4.A.29, pero con el título nuevo la convergencia real con la UE es de **4.A.30** («La convergencia real de España con la Unión Europea») y el bloque del antiguo 4.A.29 debe trasladarse allí. Propuesta: **4.A.30** (desarrollo con tres factores), **4.A.17** (aplicación regional)
- **Temas que lo usan:** 4.A.17 (desarrollo, dos factores), 4.A.29 (hoy desarrollo, tres factores; sobra con el título nuevo), 4.A.30 (desarrollo previsto), 4.A.16 y 4.A.2 (mención: tasas de actividad y empleo), 3.B.40 (mención: convergencia real en la UE)
- **Manuales de referencia:** Comisión Europea y BdE (informes de convergencia real); De la Fuente; Moral, Vázquez y Pampillón, *Manual de economía española* (Funcas, 2022)

## Presentación de referencia
Pregunta: ¿qué explica la brecha de renta per cápita de España (o de una región) frente a la UE (o a España)?
Notación canónica (propuesta, ver `_notacion/economia-espanola.md`): $Y$ PIB real (en PPA si se compara entre países), $N$ población total, $P_{16}$ población de 16 y más años, $A$ población activa, $L$ ocupados.
$$\frac{Y}{N}=\underbrace{\frac{Y}{L}}_{\text{PAT}}\cdot\underbrace{\frac{L}{A}}_{1-u}\cdot\underbrace{\frac{A}{P_{16}}}_{\text{tasa de actividad}}\cdot\underbrace{\frac{P_{16}}{N}}_{\text{factor demográfico}}$$
y en tasas de crecimiento $\gamma_{Y/N}=\gamma_{PAT}+\gamma_{1-u}+\gamma_{A/P_{16}}+\gamma_{P_{16}/N}$ (aproximación logarítmica). Versión de dos factores (4.A.17): $Y/N=(Y/L)\cdot(L/N)$, con $L/N$ = «ocupados por habitante» (no «tasa de ocupación», que en la EPA es $L/P_{16}$).
Resultado típico para España: brecha con la UE explicada sobre todo por el empleo (paro alto) y, desde 2008, también por la productividad (verificar con datos recientes de Eurostat).
Gráfico de referencia: barras con la contribución de cada factor a la brecha de PIB per cápita en PPA de España frente a la UE-27 (o de cada CA frente a España).

Convergencia β y σ: ficha `convergencia-beta-sigma` (área de crecimiento, tema de referencia 3.A.45); en 4.A.17 y 4.A.30 se aplica con la notación de esa ficha.

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 4.A.30 | Convergencia real España-UE | Desarrollo | Cuatro factores, datos PPA frente a UE-27 | Teoría de la convergencia |
| 4.A.17 | Convergencia entre CC. AA. | Desarrollo aplicado | Dos o cuatro factores por CA, β y σ regional | Datos frente a la UE |
| 4.A.29 | Situación actual | Nada / mención | Quitar el bloque (va a 4.A.30) | — |
| 4.A.16 | Mercado de trabajo | Mención | Definiciones EPA de las tasas | — |

## Divergencias encontradas en el temario actual
- **Notación distinta**: 4.A.17 usa $Y/POB=(Y/L)(L/POB)$; el antiguo 4.A.29 (futuro 4.A.30) usa $Y/N=(Y/L)(L/A)(A/N)$. **[decidir]** Propuesta: la forma de cuatro factores de arriba con $N$ para la población (no $POB$).
- 4.A.29: llama a $A/N$ «tasa de actividad» en la fórmula y «población en edad de trabajar/población total» en el texto; ninguna de las dos es la tasa de actividad de la EPA ($A/P_{16}$). Separar el factor demográfico.
- 4.A.17: llama «tasa de ocupación» a $L/POB$.
- 4.A.17 y 4.A.29 dan la tasa de actividad como activos/población de 16-64 con un valor (≈59 %) que es el de 16 y más (con 16-64 ronda el 75 %).
- **Convergencia β/σ con notación distinta**: 4.A.17 y 3.B.40 usan $\gamma_{t,t-1}^{y}=\beta_0+\beta_1\ln y_{t-1}+u_t$ y $\sigma^2_{y,t-1}>\sigma^2_{y,t}$; en 3.B.40 $\sigma$ es además la elasticidad de sustitución (NGE), y en 4.A.22 $\beta_i$ son las ponderaciones del ITC. **[decidir]** Propuesta: la notación de 3.A.45 para la regresión, con $\sigma_t$ solo para la dispersión (de $\ln y$) y otra letra para la elasticidad de sustitución y las ponderaciones del ITC.
- 4.A.17: «la variable dependiente sea el crecimiento… y la variable dependiente sea el PIB per cápita» (la segunda es la independiente).
- Datos de 4.A.17 (2017-2020, UE-28) y 4.A.29 (2018 y 2022-2023): actualizar con la misma fecha en ambos.
