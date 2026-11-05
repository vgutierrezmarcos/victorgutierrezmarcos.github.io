# Regla de Friedman (1969), coste de bienestar de la inflación (Bailey, 1956) e inflación óptima

- **Área:** macro cerrada · **Tema de referencia:** 3.A.41 (La inflación: causas y efectos sobre la eficiencia económica y el bienestar…) — los efectos sobre el bienestar y la inflación óptima son parte del título. **Hecho (revisado el 5/11/2026):** II.1.1 con el triángulo de Bailey como función clave (`eq:bailey`) y el gráfico de referencia `bailey`; II.2 «¿Existe una tasa de inflación óptima?» con la regla en a)-e) (`eq:regla-friedman`), «¿Por qué el 2 %?» y `tab:inflacion-optima`; además `tab:costes-inflacion` con todos los costes de la inflación. Desde el 5/11/2026 la ficha recoge también **el triángulo de Bailey y los costes de la inflación** (CC1 del 3.A.41; no hay ficha aparte).
- **Temas que lo usan:** 3.A.41 (desarrollo; hecho, 5/11/2026), 4.B.11 (resumen: la inflación como impuesto en la imposición óptima, Phelps y Chari-Christiano-Kehoe), 3.A.35 (resumen; hecho, 5/11/2026: III.1 «Demanda de dinero e inflación óptima», derivada en el MIU con `eq:regla-friedman` en su forma discreta exacta y en el anexo `anexo:miu`, común a la CIA y al tiempo de compra; Lucía; Bailey y Lucas con `\vertema{3.A.41}`; matices de Phelps y del 2 % en una frase; **decisión del coordinador: el 3.A.41 la desarrolla y el 3.A.35 la resume con remisión**). Relacionada con el dinero en la utilidad (ficha `miu-sidrauski`) y el pago por adelantado (ficha `cia`), con referencia en el 3.A.35. También 3.A.5 (mención; hecho, 3/11/2026: III.1.1, en nota: la regla de Friedman (1969) **no es** la regla del k % ($\gamma_M=\overline\gamma_M$), `\vertema{3.A.41}`), 3.A.36 (mención; hecho, 4/11/2026: II.4.2, el dinero helicóptero es una imagen de Friedman (1969), pero **no es la regla de Friedman**, `\vertema{3.A.41}`; I.4.1, el 4 % de Blanchard, Dell'Ariccia y Mauro), 3.A.7 (mención; hecho, 4/11/2026: l. 701, la inflación dispersa los precios relativos y la estabilidad de precios es el óptimo con precios rígidos).
- **Manuales de referencia:** Bailey (1956), «The Welfare Cost of Inflationary Finance», *JPE* (`Bailey1956Welfare`); Friedman (1969), «The Optimum Quantity of Money» (`Friedman1969Optimum`); Phelps (1973), *Swedish JE* (`Phelps1973Inflation`); Chari, Christiano y Kehoe (1996), *JME* (`ChariChristianoKehoe1996Optimality`); Lucas (2000), «Inflation and Welfare», *Econometrica* (`Lucas2000Inflation`); Schmitt-Grohé y Uribe (2010), *Handbook of Monetary Economics*, vol. 3B (`SchmittGroheUribe2010Optimal`); Woodford (2003), *Interest and Prices*; Walsh (2017), caps. 2 y 4.

## Presentación de referencia (3.A.41, II)

**Pregunta:** ¿cuánto cuesta la inflación en eficiencia y en bienestar, y cuál es la tasa óptima?

### Los costes de la inflación (II.1, `tab:costes-inflacion`)

- **Anticipada** ($\pi=\pi^e$, costes sobre todo de **eficiencia**) frente a **no anticipada** ($\pi\neq\pi^e$, de **bienestar** y distribución), con $i\simeq r+\pi^e$ (Fisher, `\vertema{3.A.3}`); la frontera es borrosa: la inflación alta es variable (Friedman, 1977).
- **Triángulo de Bailey** (`\funcionclave` `eq:bailey`): con $L(i)\equiv M^D/P$ la demanda de saldos reales (decreciente en el tipo nominal; **$L$ de liquidez, local**) y un dinero que no cuesta producir,
  $$\mathrm{PB}(i)=\int_0^{i}L(x)\,dx-i\,L(i)\;\approx\;\tfrac12\,\lvert L'(0)\rvert\,i^2$$
  **$\mathrm{PB}(i)$ pérdida de bienestar por periodo, en redonda** (CC4 b) de la coherencia proponía $w(i)$; **[decidir]**); el rectángulo $i\,L(i)$ es el impuesto inflacionario, una transferencia, no una pérdida. Crece con el **cuadrado** del tipo nominal (como el exceso de gravamen): del 2 al 4 % cuesta 3 veces más que del 0 al 2 %. Con la demanda de Cagan, $L(i)=\zeta e^{-\alpha i}$ y $\lvert L'(0)\rvert=\alpha\zeta$ (la misma α del máximo del señoreaje, ficha `cagan`). Evidencia: Lucas (2000), EE. UU. 1900-1994, del 10 al 0 % equivale a algo menos del 1 % de la renta real.
- **Menú y dispersión** (Mankiw, 1985; Woodford, 2003; fichas `costes-de-menu`, `nek-3-ecuaciones`), **unidad de cuenta** («las cuentas claras y el chocolate espeso») y **señal de los precios** (Lucas, 1973; Friedman, 1977), **distorsiones fiscales** (progresividad en frío; interés nominal gravado, $(1-\tau)i-\pi=(1-\tau)r-\tau\pi$, con $\tau$ el tipo del ejemplo; Feldstein, 1997, 1 % del PIB al año frente a un 5 % único de desinflar; **efecto Olivera-Tanzi**), **capital** (Mundell-Tobin, `\vertema{3.A.43}`; superneutralidad de Sidrauski, `\vertema{3.A.35}`; Stockman, 1981, con la **restricción de pago por adelantado**: ficha `miu-sidrauski`, sección «Inflación y capital», y ficha `cia`).
- **No anticipada**: redistribución de acreedores a deudores (Doepke y Schneider, 2006; Reinhart y Sbrancia, 2015, `\vertema{3.A.39}`), regresividad (BCE, 2022), incertidumbre (Friedman, 1977), competitividad en una unión monetaria (`\vertema{3.B.11}`).
- **¿Beneficios?** Solo razones para un objetivo positivo: lubricante del mercado de trabajo (Tobin, 1972; Akerlof, Dickens y Perry, 1996), señoreaje (Phelps, 1973), margen frente al límite inferior.

### La regla de Friedman (II.2.1, a)-e))

**a) Idea:** el coste privado de tener dinero es el tipo nominal $i$, y su coste social de producción es casi nulo: la eficiencia exige igualarlos, $i=0$, y el triángulo de Bailey desaparece.

**b) Modelo.** *Supuestos:* precios flexibles, un dinero que presta un servicio (en la utilidad o para comprar) y no cuesta producir, impuestos de suma fija. *Desarrollo:* en el MIU, $u_m/u_C=i$ en continuo y $u_m/u_C=i/(1+i)$ en discreto (`eq:miu` del 3.A.35, **$u_C$ con mayúscula**); lo eficiente es saciar la demanda, $u_m=0$:

$$i=0\quad\Longrightarrow\quad 1+\pi^*=\frac{1}{1+r}\quad\Longrightarrow\quad\pi^*=-\frac{r}{1+r}\simeq-r$$

**Forma canónica:** la **discreta exacta** del 3.A.35 (`eq:regla-friedman`), con su aproximación; en el estado estacionario del MIU, $1+\pi^*=1+\gamma_M=\beta$ (anexo `anexo:miu` del 3.A.35). En continuo, $i=r+\pi=0\Rightarrow\pi^*=-r$ (la que escribe el 3.A.41 en su `eq:regla-friedman`; ver «Divergencias»). Lo mismo con la restricción de pago por adelantado y el tiempo de compra. **$\pi^*$** es aquí la inflación **óptima** (§ 0); en Barro-Gordon y Taylor, el **objetivo**; en el señoreaje, la que lo maximiza ($1/\alpha$) (`notacion.md` § 1, B/π, A35-15, **[decidir]**). La nota obligada: **no es la regla del k %** ($\gamma_M=\overline\gamma_M$, Friedman, 1960, `\vertema{3.A.5}`) **ni el dinero helicóptero** (imagen del mismo libro de 1969, `\vertema{3.A.36}`). *Implicaciones:* con un tipo real del 2 al 4 %, una deflación del 2 al 4 %; ningún banco central la sigue.

**c) Extensiones, la inflación como impuesto:** sin impuestos de suma fija, $\pi^*>-r$ (Phelps, 1973; la imposición óptima, `\vertema{3.A.39}`); con el dinero como bien intermedio, la regla vuelve a ser óptima (Chari, Christiano y Kehoe, 1996); rentas que escapan al fisco (para un 2 % la renta no gravada tendría que superar el 30 %); demanda exterior de la moneda (del 2 al 10 % para EE. UU.) (Schmitt-Grohé y Uribe, 2010).

**d) Evidencia:** la ganancia de ir de una inflación baja a la regla es pequeña (Lucas, 2000); la única deflación duradera de la posguerra, Japón, no fue una elección (ficha `deflacion`).

**e) Valoración, las rigideces nominales:** con precios rígidos cualquier inflación dispersa los precios relativos y el óptimo es **cero** (Woodford, 2003); con las 2 fricciones, entre $-r$ y 0, mucho más cerca de 0 (Schmitt-Grohé y Uribe, 2010).

### ¿Por qué el 2 %? (II.2.2)

3 razones: **sesgo de medición** (Boskin, 1996: 1,1 puntos al año, 0,6 de calidad, `\vertema{3.A.9}`; corregir el objetivo solo es óptimo si los precios rígidos son los ajustados por calidad); **límite inferior de los tipos** (antes de 2008 el riesgo era pequeño: tipo nominal óptimo medio del 4,4 % con desviación típica del 0,9 % e inflación óptima media del −0,4 %; tras 2008, la propuesta de estudiar un 4 %, Blanchard, Dell'Ariccia y Mauro, 2010); **salarios rígidos a la baja** (menos de medio punto). Pegatina: «curarse en salud». En una unión monetaria, además, evitar que los países que deben abaratarse pasen por deflación. BCE: objetivo simétrico del 2 % a medio plazo desde julio de 2021, confirmado en junio de 2025 (ficha `objetivo-inflacion`); la Fed abandonó la inflación media el 22/8/2025.

**Gráficos de referencia:** **`oposicion/temario/fuentes/3A41/graficos/bailey.tex`** (nuevo el 5/11/2026: demanda de saldos reales $L(i)$ frente a $i$, con $i_0=r+\pi$, el rectángulo del impuesto inflacionario y el triángulo sombreado de la pérdida, que desaparece con $i=0$; el 3.A.35 lo copiará si lo dibuja). Tablas: `tab:costes-inflacion` y `tab:inflacion-optima` del 3.A.41.

## Cómo se adapta en cada tema

| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.41 | Efectos de la inflación y su nivel óptimo | desarrollo (hecho, 5/11/2026) | II.1 costes con `eq:bailey` (función clave) y el gráfico `bailey`, `tab:costes-inflacion`; II.2.1 la regla con a)-e), `eq:regla-friedman` numerada (no función clave, decisión del coordinador), la nota del k % y del helicóptero; II.2.2 el 2 % y `tab:inflacion-optima`; la derivación en el MIU, `\vertema{3.A.35}` | — |
| 4.B.11 | Imposición óptima | resumen | La inflación como impuesto: Phelps y Chari-Christiano-Kehoe | La pérdida de Bailey y el límite inferior |
| 3.A.35 | Demanda de dinero: implicaciones de política (inflación óptima) | resumen (hecho, 5/11/2026) | III.1: la idea, la derivación en el MIU con `eq:regla-friedman` discreta y $1+\pi^*=\beta$, la misma en la CIA y el tiempo de compra; Lucía (51 € al 3 %, 102 € al 12 %) y el área bajo la demanda (Bailey, 1956; Lucas, 2000) con `\vertema{3.A.41}`; Phelps (1973) y el 2 % en una frase; «no es la regla del k %» | El triángulo de Bailey dibujado, Chari-Christiano-Kehoe y las razones del 2 % en extenso |
| 3.A.5 | Monetarismo | mención (hecho, 3/11/2026) | Nota para distinguirla de la regla del k % | La pérdida de Bailey |
| 3.A.36 | Instrumentos no convencionales; objetivo | mención (hecho, 4/11/2026) | El dinero helicóptero no es la regla de Friedman; el 4 % | La inflación óptima |
| 3.A.7 | NEK | mención (hecho, 4/11/2026) | Con precios rígidos, la inflación dispersa los precios relativos: estabilidad de precios | La regla |

## Divergencias encontradas en el temario actual

- **3.A.41 (revisado el 5/11/2026), pendientes cosméticos** (`pendientes-coherencia.md`, «Pendiente del 3.A.41»): escribe $u_m/u_c=i$ (l. 483; canon $u_C$); `eq:regla-friedman` en la forma continua $i=r+\pi=0\Rightarrow\pi^*=-r$ sin decir que es la continua (canon: la discreta exacta con su aproximación, o la continua con el aviso y `\vertema{3.A.35}`); $\pi^*$ con 2 sentidos (objetivo en `eq:sesgo` y el anexo E; óptimo en II.2) sin aviso. Ninguno cambia el contenido.
- **Resuelto en el 3.A.41**: la numeración desordenada del Word (3.2 y 3.8 duplicados), las 1.700 palabras en inglés copiadas de Schmitt-Grohé y Uribe, los epígrafes vacíos del bloque II; Bailey y Lucas (2000) solo en el 3.A.41 (el 3.A.35 los resume en una línea).

Autor: Víctor Gutiérrez Marcos
