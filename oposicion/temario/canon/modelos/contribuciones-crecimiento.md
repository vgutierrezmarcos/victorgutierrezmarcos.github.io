# Contribuciones al crecimiento del PIB

- **Área:** macro-cerrada · **Tema de referencia:** **3.A.30** («Magnitudes macroeconómicas y contabilidad nacional»), **revisado el 11/11/2026**: lo desarrolla en III.1 (`sec:volumen`: volúmenes encadenados, deflactor, `eq:contribuciones` como función clave, lectura y gráfico de España) y en el anexo `anexo:encadenados` (ejemplo de no aditividad). **Hecho**: la presentación de abajo es la del 3.A.30.
- **Temas que lo usan:** 3.A.30 (desarrollo; hecho, 11/11/2026: III.1 y anexo E), 4.A.29 (uso: demanda interna y externa de España), 4.A.1 (mención: Contabilidad Nacional trimestral), 1D01 (uso: II.3, `fig:contribuciones-pib-zona-euro`, anexos A y E), 3.A.9 (mención; hecho, 13/10/2026: «el PIB en volumen se calcula con índices de Laspeyres encadenados», l. 1343, y el deflactor de Paasche). El 3.A.42 no usa las contribuciones: la lectura procíclica es de la ficha `hechos-estilizados-ciclo`
- **Manuales de referencia:** Reglamento (UE) 549/2013 (SEC 2010; clave `SEC2010`), cap. 10; INE, *Contabilidad Nacional Trimestral de España: metodología*; Eurostat, *Handbook on quarterly national accounts* (2013, `Eurostat2013QNA`), cap. 6 (volúmenes encadenados); Blanchard, *Macroeconomics*, cap. 2.

## Presentación de referencia
**Pregunta:** ¿qué componentes de la demanda explican el crecimiento del PIB?

**Del valor al volumen** (antes de la fórmula): cada año se valora a los precios del año anterior y las tasas se encadenan, `eq:volumen-encadenado` $1+\gamma_{Y,t}=\dfrac{\vect{p}^{t-1}\cdot\vect{x}^{t}}{\vect{p}^{t-1}\cdot\vect{x}^{t-1}}$ (Laspeyres de volumen encadenado); el **deflactor implícito** $P\equiv\text{PIB nominal}/\text{PIB en volumen}\times100$, con $\gamma_P\approx\gamma^N-\gamma_Y$, es entonces un **Paasche encadenado** (la frase del 3.A.9).

`eq:contribuciones` (función clave; misma etiqueta y forma en el 3.A.30 y en la 1D01):

$$\gamma_{Y,t}=\underbrace{\frac{C_{t-1}}{Y_{t-1}}\gamma_{C,t}+\frac{I_{t-1}}{Y_{t-1}}\gamma_{I,t}+\frac{G_{t-1}}{Y_{t-1}}\gamma_{G,t}}_{\text{contribución de la demanda interna}}+\underbrace{\frac{X_{t-1}}{Y_{t-1}}\gamma_{X,t}-\frac{M_{t-1}}{Y_{t-1}}\gamma_{M,t}}_{\text{contribución de la demanda externa}}$$

Se obtiene restando a la identidad del gasto la del año anterior y dividiendo por $Y_{t-1}$.

Cada contribución = peso del componente en el periodo anterior × su crecimiento, en **puntos porcentuales** (las importaciones restan; las existencias también contribuyen). $G$ es el gasto en consumo final de las AAPP; la inversión pública está en la FBCF ($I$). Con **volúmenes encadenados**, **los pesos son las participaciones nominales del año anterior** ($X^k_{t-1}/Y_{t-1}$ a precios corrientes de $t-1$, que es lo mismo que a precios del año anterior), y con ellos **la suma es exacta**; lo que no suma son los componentes en euros encadenados, que no dan el PIB encadenado salvo en el año de referencia y el siguiente (**no aditividad**). Por eso se usan las contribuciones que publican el INE o Eurostat, y nunca se calculan con los niveles encadenados. **Ejemplo de referencia** (anexo `anexo:encadenados` del 3.A.30, `tab:encadenados`): 2 bienes, $A$ con cantidad fija y precio +20 % al año, $B$ (un ordenador) con precio a la mitad y cantidad doble; PIB nominal 100, 110, 122; crecimiento en volumen 50 % y 45,5 %; PIB encadenado 218,2 frente a 250 de la suma de los componentes; con los pesos nominales del año 1 ($B$: 50/110) la contribución de $B$ es 45,5 puntos, el crecimiento exacto; el deflactor cae un 23,8 % (Paasche, 122/160). **Ejemplo de cálculo en el cuerpo** (3.A.30): PIB 100; C 60 (+2 %), I 20 (+5 %), G 20 (+1 %), X y M 30 (+4 % y +6 %): interna $1{,}2+1{,}0+0{,}2=2{,}4$ pp, externa $1{,}2-1{,}8=-0{,}6$ pp, PIB +1,8 %.

**Lectura:** demanda interna procíclica, externa neta contracíclica porque las importaciones caen con la renta (ficha `hechos-estilizados-ciclo`, `\vertema{3.A.42}`); contribuciones positivas y parecidas de las 2, crecimiento equilibrado. **Datos de referencia (España)**: 2025, PIB +2,6 %, demanda nacional +3,4 pp, externa −0,8 pp (`INE2026CNA2025`); 3T2026, +2,7 % interanual (`INE2026avCNTR3T26`); 2009, nacional −6,6 pp y externa +2,8; 2020, restaron las 2 (`Eurostat2026nama10gdp`).

**Gráficos de referencia:** barras apiladas de las contribuciones (demanda nacional y externa) con el crecimiento del PIB en línea. Del 3.er ejercicio, el de **España**, `fuentes/3A30/graficos/contribuciones-pib-espana.tex` (CC3 del 3.A.30, **[decidir]**); para el dictamen, el de la **zona del euro**, `fuentes/1D01/graficos/contribuciones-pib-zona-euro.tex`, con los mismos estilos.

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.30 | Contabilidad nacional | Desarrollo (hecho, 11/11/2026) | Derivación, volúmenes encadenados con pesos nominales del año anterior, deflactor Paasche encadenado, no aditividad (anexo E), lectura y gráfico de España | — |
| 3.A.9 | Medidas de bienestar e índices | Mención (hecho) | Laspeyres de volumen y Paasche de precios (el deflactor) | Las contribuciones |
| 4.A.29 | Economía española desde la COVID-19 | Uso | Contribuciones de España por años | La fórmula |
| 1D01 | Dictamen de coyuntura | Uso | Fórmula, unidades (pp), cautelas y lectura | La derivación |

## Divergencias encontradas en el temario actual
- Original de la 1D01 (corregido): «C + I + G» con la inversión pública en G.
- Ficha anterior (hasta el 11/11/2026): decía que con volúmenes encadenados «la suma no es exacta»; lo exacto es la suma de las contribuciones con pesos nominales del año anterior; lo que no suma son los niveles encadenados (corregido con el 3.A.30).

Autor: Víctor Gutiérrez Marcos
