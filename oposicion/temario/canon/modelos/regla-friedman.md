# Regla de Friedman (1969) e inflación óptima

- **Área:** macro cerrada · **Tema de referencia:** 3.A.41 (La inflación: efectos sobre la eficiencia y el bienestar) — la inflación óptima es parte del título.
- **Temas que lo usan:** 3.A.41 (desarrollo; en revisión el 5/11/2026), 4.B.11 (resumen: la inflación como impuesto en la imposición óptima, Schmitt-Grohé y Uribe), 3.A.35 (resumen; hecho, 5/11/2026: III.1 «Demanda de dinero e inflación óptima», derivada en el MIU con `eq:regla-friedman` y en el anexo `anexo:miu`, común a la CIA y al tiempo de compra; Lucía; Bailey y Lucas con `\vertema{3.A.41}`; matices de Phelps y del 2 % en una frase; **decisión del coordinador: el 3.A.41 la desarrolla y el 3.A.35 la resume con remisión**). Relacionada con los modelos de dinero en la utilidad (ficha `miu-sidrauski`) y de pago por adelantado (ficha `cia`), con referencia en el 3.A.35. También 3.A.5 (mención; hecho, 3/11/2026: III.1.1, en nota: la regla de Friedman (1969) de la cantidad óptima de dinero **no es** la regla del k % ($\gamma_M=\overline\gamma_M$), `\vertema{3.A.41}`). También 3.A.36 (mención; hecho, 4/11/2026: II.4.2, el dinero helicóptero tiene la imagen de Friedman (1969), pero **no es la regla de Friedman**, un tipo nominal de cero, del mismo libro, `\vertema{3.A.41}`).
- **Manuales de referencia:** Friedman (1969), «The Optimum Quantity of Money»; Phelps (1973); Chari, Christiano y Kehoe (1996); Schmitt-Grohé y Uribe (2010), *Handbook of Monetary Economics*; Walsh (2017), caps. 2 y 4.

## Presentación de referencia

**Pregunta:** ¿cuál es la tasa de inflación socialmente óptima?

**Idea y ecuaciones:** el coste privado de mantener dinero es el tipo nominal i, y su coste social de producción es casi nulo. La eficiencia exige igualar ambos:

$$i=0\quad\Longrightarrow\quad 1+\pi^*=\frac{1}{1+r}\quad\Longrightarrow\quad\pi^*=-\frac{r}{1+r}\simeq-r$$

(deflación a la tasa del tipo real; forma exacta en tiempo discreto, `eq:regla-friedman` del 3.A.35; en continuo, $i=r+\pi=0$, $\pi^*=-r$). En el MIU, `eq:miu` $u_m/u_C=i_t/(1+i_t)$ (en continuo, $u_m/u_C=i$; **$u_C$ con mayúscula**, como $C_t$) muestra que $i=0$ sacia la demanda de saldos reales; en el estado estacionario, $r=\rho$ y **$1+\pi^*=1+\gamma_M=\beta$**: el dinero debe decrecer a la tasa de descuento (anexo `anexo:miu` del 3.A.35; el Word del 3.A.35 decía lo contrario, «imprimir dinero hasta que $i=0$»). Lo mismo con la restricción de pago por adelantado y con el tiempo de compra: el tipo nominal es un impuesto sobre un medio de cambio que no cuesta producir. **$\pi^*$** es aquí el óptimo (§ 0); en el señoreaje, $\pi^*=1/\alpha$ es otro óptimo (ficha `cagan`; `notacion.md` § 1, A35-15, **[decidir]**).

**Matices:** Phelps (1973): si no hay impuestos de suma fija, la inflación es un impuesto más y su tipo óptimo es positivo (Ramsey); Chari-Christiano-Kehoe: con el dinero como bien intermedio, la regla de Friedman vuelve a ser óptima. Razones para un objetivo del 2 %: sesgo de medición, ELB (margen para bajar tipos), rigidez nominal a la baja de salarios (Akerlof, Dickens y Perry 1996), costes de menú (óptimo π = 0 en la NEK).

**Gráfico de referencia:** demanda de saldos reales M/P frente a i: el triángulo bajo la demanda entre i y 0 es la pérdida de bienestar (Bailey 1956).

## Cómo se adapta en cada tema

| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.41 | Efectos de la inflación y su nivel óptimo | Desarrollo | Regla, matices, pérdida de Bailey, por qué el 2 % | — |
| 4.B.11 | Imposición óptima | Resumen | La inflación como impuesto: Phelps y Chari-Christiano-Kehoe | La pérdida de Bailey y el ELB |
| 3.A.35 | Demanda de dinero: implicaciones de política (inflación óptima) | resumen (hecho, 5/11/2026) | III.1: la idea (coste privado $i$, coste social casi nulo), la derivación en el MIU con `eq:regla-friedman` y $1+\pi^*=\beta$, la misma en la CIA y el tiempo de compra; Lucía (51 € al 3 %, 102 € al 12 %) y el área bajo la demanda (Bailey, 1956; Lucas, 2000) con `\vertema{3.A.41}`; Phelps (1973) y el 2 % (Schmitt-Grohé y Uribe, 2010) en una frase; «no es la regla del k %» | El triángulo de Bailey dibujado, Chari-Christiano-Kehoe y las razones del 2 % en extenso |
| 3.A.5 | Monetarismo (política monetaria) | mención (hecho, 3/11/2026) | Nota para distinguirla de la regla del k %: i = 0 exige una deflación igual al tipo real (Friedman, 1969) | La pérdida de Bailey |
| 3.A.36 | Instrumentos no convencionales | mención (hecho, 4/11/2026) | Para distinguir el dinero helicóptero (Friedman, 1969) de la regla de Friedman (i = 0), del mismo libro; `\vertema{3.A.41}` | La inflación óptima |

## Divergencias encontradas en el temario actual

- **3.A.41 (en revisión):** escribe $u_m/u_c=i$ (l. 483); el canon es $u_C$ (`notacion.md` § 8, fila del MIU) y la forma discreta $i/(1+i)$ que ya cita entre paréntesis. Ver `mapa.yaml`, contradicciones del 3.A.35.
- Sin ecuaciones en el inventario; 3.A.41 tiene numeración desordenada (3.2 «¿Existe una tasa óptima?» y 3.8 «Inflación óptima» duplicados): unificar.

Autor: Víctor Gutiérrez Marcos
