# Contribuciones al crecimiento del PIB

- **Área:** macro-cerrada · **Tema de referencia:** **3.A.30** («Magnitudes macroeconómicas y contabilidad nacional»).
- **Temas que lo usan:** 3.A.30 (desarrollo), 4.A.29 (uso: demanda interna y externa de España), 4.A.1 (mención: Contabilidad Nacional trimestral), 1D01 (uso: II.3, `fig:contribuciones-pib-zona-euro`, anexos A y E)
- **Manuales de referencia:** Reglamento (UE) 549/2013 (SEC 2010); INE, *Contabilidad Nacional Trimestral de España: metodología*; Eurostat, *Handbook on quarterly national accounts* (2013), cap. 6 (volúmenes encadenados); Blanchard, *Macroeconomics*, cap. 2.

## Presentación de referencia
**Pregunta:** ¿qué componentes de la demanda explican el crecimiento del PIB?

$$\gamma_{Y,t}=\underbrace{\frac{C_{t-1}}{Y_{t-1}}\gamma_{C,t}+\frac{I_{t-1}}{Y_{t-1}}\gamma_{I,t}+\frac{G_{t-1}}{Y_{t-1}}\gamma_{G,t}}_{\text{demanda interna}}+\underbrace{\frac{X_{t-1}}{Y_{t-1}}\gamma_{X,t}-\frac{M_{t-1}}{Y_{t-1}}\gamma_{M,t}}_{\text{demanda externa neta}}$$

Cada contribución = peso del componente en el periodo anterior × su crecimiento, en **puntos porcentuales** (las importaciones restan; las existencias también contribuyen). $G$ es el gasto en consumo final de las AAPP; la inversión pública está en la FBCF ($I$). Con **volúmenes encadenados** la suma no es exacta: si se publican, se usan las contribuciones del INE o de Eurostat (a precios del año anterior).

**Lectura:** demanda interna procíclica, externa neta contracíclica (ficha `hechos-estilizados-ciclo`); contribuciones positivas y parecidas de las 2, crecimiento equilibrado.

**Gráfico de referencia:** barras apiladas de las contribuciones con el crecimiento del PIB en línea, `fuentes/1D01/graficos/contribuciones-pib-zona-euro.tex`.

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.30 | Contabilidad nacional | Desarrollo | Derivación, volúmenes encadenados y no aditividad | — |
| 4.A.29 | Economía española desde la COVID-19 | Uso | Contribuciones de España por años | La fórmula |
| 1D01 | Dictamen de coyuntura | Uso | Fórmula, unidades (pp), cautelas y lectura | La derivación |

## Divergencias encontradas en el temario actual
- Original de la 1D01 (corregido): «C + I + G» con la inversión pública en G.

Autor: Víctor Gutiérrez Marcos
