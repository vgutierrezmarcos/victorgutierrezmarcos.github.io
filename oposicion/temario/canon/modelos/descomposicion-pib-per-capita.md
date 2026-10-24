# Descomposición contable del PIB per cápita (y convergencia real de España)

- **Área:** economia-espanola · **Tema de referencia:** **4.A.30** (convergencia real con la UE; el bloque del antiguo 4.A.29 se traslada allí), con la descomposición de cuatro factores; **4.A.17** la aplica a las regiones.
- **Temas que lo usan:** 4.A.17 (desarrollo, dos factores), 4.A.29 (hoy desarrollo, tres factores; sobra con el título nuevo), 4.A.30 (desarrollo previsto), 4.A.16 y 4.A.2 (mención: tasas de actividad y empleo), 3.B.40 (mención: convergencia real en la UE), 1D01 (mención: III.1, factor demográfico)
- **Manuales de referencia:** Comisión Europea y BdE (informes de convergencia real); De la Fuente; Moral, Vázquez y Pampillón, *Manual de economía española* (Funcas, 2022)
- **Decisión D034 (13/10/2026):** ¿Cómo se escribe la dispersión de la renta en la σ-convergencia si σ es también la elasticidad de sustitución? σ_t (desviación típica de ln y, como Sala i Martín), siempre con subíndice t; en 3.B.40, que mezcla ambas, se avisa
- **Decisión D048 (13/10/2026):** ¿Qué símbolo lleva la población total en la descomposición del PIB per cápita? N, con la descomposición de cuatro factores Y/N = (Y/L)(L/A)(A/P_16)(P_16/N)
- **Decisión D097 (13/10/2026):** ¿Cuál es el tema de referencia de la descomposición del PIB per cápita? 4.A.30 (convergencia real con la UE), con aplicación regional en 4.A.17

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
| 1D01 | Dictamen de coyuntura | Mención | $Y/N=(Y/L)(L/A)(A/P_{16})(P_{16}/N)$ para situar el factor demográfico y la tasa de actividad | La descomposición de España |

## Divergencias encontradas en el temario actual
- **Notación distinta**: 4.A.17 usa $Y/POB=(Y/L)(L/POB)$; el antiguo 4.A.29 (futuro 4.A.30) usa $Y/N=(Y/L)(L/A)(A/N)$. Canon: la forma de cuatro factores de arriba con $N$ para la población (no $POB$).
- 4.A.29: llama a $A/N$ «tasa de actividad» en la fórmula y «población en edad de trabajar/población total» en el texto; ninguna de las dos es la tasa de actividad de la EPA ($A/P_{16}$). Separar el factor demográfico.
- 4.A.17: llama «tasa de ocupación» a $L/POB$.
- 4.A.17 y 4.A.29 dan la tasa de actividad como activos/población de 16-64 con un valor (≈59 %) que es el de 16 y más (con 16-64 ronda el 75 %).
- **Convergencia β/σ con notación distinta**: 4.A.17 y 3.B.40 usan $\gamma_{t,t-1}^{y}=\beta_0+\beta_1\ln y_{t-1}+u_t$ y $\sigma^2_{y,t-1}>\sigma^2_{y,t}$; en 3.B.40 $\sigma$ es además la elasticidad de sustitución (NGE), y en 4.A.22 $\beta_i$ son las ponderaciones del ITC. Canon: la notación de 3.A.45 para la regresión, $\sigma_t$ (siempre con subíndice) para la dispersión de $\ln y$, $\omega_i$ para las ponderaciones del ITC; en 3.B.40, que usa también la elasticidad de sustitución $\sigma$ de la NGE, se avisa.
- 4.A.17: «la variable dependiente sea el crecimiento… y la variable dependiente sea el PIB per cápita» (la segunda es la independiente).
- Datos de 4.A.17 (2017-2020, UE-28) y 4.A.29 (2018 y 2022-2023): actualizar con la misma fecha en ambos.
