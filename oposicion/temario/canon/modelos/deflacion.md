# Deflación: buena y mala, deflación por deudas, trampa deflacionaria y reflación

- **Área:** macro cerrada · **Tema de referencia:** 3.A.41 (La inflación… Hiperinflación y deflación) — la deflación está en el título (revisado el 5/11/2026: III.2 con la idea, la evidencia de Japón y la zona del euro, los 4 canales, la trampa de Krugman, la reflación y la valoración). Ficha creada en la fase canon del 3.A.41 (**[decidir]**; *alternativa*: sin ficha, repartida entre `ciclo-financiero` y `limite-inferior-tipos`). **Reparto con otras fichas:** la **deflación por deudas de Fisher (1933)** es parte de `ciclo-financiero` (3.A.42 de referencia; el 3.A.3 la cuenta como aportación de Fisher); el **límite inferior de los tipos**, la orientación y **Eggertsson y Woodford (2003)**, de `limite-inferior-tipos` (3.A.37 de referencia, en revisión: allí el desarrollo de la trampa con la NEK; el id `eggertsson-woodford` del inventario del 3.A.41 pasa a alias de `limite-inferior-tipos`, CC3); la **reflación fiscal** (Sims, 2016), de `ftpl` (3.A.39).
- **Temas que lo usan:** 3.A.41 (desarrollo; hecho, 5/11/2026), 1D01 (uso, aprobada: l. 992, por qué preocupa la deflación de demanda, con Fisher y el límite inferior; deflación buena y mala), 3.A.42 (mención; hecho, 4/11/2026: III.2, la deflación por deudas de Fisher con la frase de la pág. 344 y «la salida es reflacionar» con `\vertema{3.A.41}`), 3.A.3 (mención; hecho, 4/11/2026: l. 666, Fisher y la deflación por deudas, con la misma frase), 3.A.40 (mención; hecho, 5/11/2026: I.2, Krugman, 1998, y Japón; la deflación evitada en 2008-2020), 3.A.37 (resumen previsto: la trampa en la NEK y Eggertsson y Woodford en desarrollo, con `\vertema{3.A.41}` para la deflación).
- **Manuales de referencia:** Fisher (1933), «The Debt-Deflation Theory of Great Depressions», *Econometrica* (`Fisher1933`); Krugman (1998), «It's Baaack», *BPEA* (`Krugman1998Baaack`); Eggertsson y Woodford (2003), *BPEA* (`EggertssonWoodford2003Zero`); Bordo y Filardo (2005), «Deflation in a Historical Perspective», BIS (`BordoFilardo2005Deflacion`); Bernanke (2002), «Deflation: Making Sure "It" Doesn't Happen Here» (`Bernanke2002Deflation`); Sims (2016), Jackson Hole (`Sims2016Fiscal`).

## Presentación de referencia (3.A.41, III.2)

**Pregunta:** ¿cuándo es mala la deflación y cómo se sale de ella?

**a) Idea:** caída **sostenida y generalizada** de los precios (una caída puntual por la energía no lo es: en 2020 la zona del euro tuvo tasas negativas de agosto a diciembre y los precios subieron un 0,3 % en el año). **Buena**, de oferta (la productividad crece y los precios bajan con la producción creciendo, el siglo XIX), frente a **mala**, de demanda (el gasto se hunde, la Gran Depresión) (Bordo y Filardo, 2005).

**b) Por qué es peligrosa la de demanda** (4 canales, en este orden): **deflación por deudas** (las deudas son nominales; «cuanto más pagan los deudores, más deben», Fisher, 1933, pág. 344, traducción propia, la misma en el 3.A.3 y el 3.A.42); **salarios rígidos a la baja** (suben los reales y el paro); **aplazamiento del gasto**; **el límite inferior de los tipos**, $i^{\mathrm{ELB}}$: con deflación esperada el tipo real $r=i-\pi^e$ **sube** justo cuando debe bajar, y la deflación y el límite se refuerzan.

**c) La trampa** (Krugman, 1998, para Japón): con el tipo natural negativo y el nominal en el límite, la única forma de bajar el tipo real es que el público espere inflación, pero un banco central con fama de duro no es creído: **tiene que comprometerse de forma creíble a ser irresponsable**. Eggertsson y Woodford (2003): lo óptimo es prometer tipos bajos durante más tiempo del necesario, como con un objetivo de nivel de precios (fichas `limite-inferior-tipos`, `objetivo-inflacion`).

**d) La salida, reflacionar** (Fisher): devolver los precios a su nivel anterior; orientación, compras de activos (`\vertema{3.A.40}`, 3.A.37), política fiscal que el público no espera pagar con impuestos (Sims, 2016; ficha `ftpl`) y, en el límite, el dinero lanzado desde un helicóptero (Bernanke, 2002). Japón desde 2013, objetivo del 2 % y compras masivas.

**e) Evidencia:** Japón, 1998-2012: IPC −3,9 % y deflactor del PIB −15,6 % acumulados (Banco Mundial); zona del euro: tasas negativas de diciembre de 2014 a marzo de 2015 (mínimo −0,6 % en enero de 2015) y varios meses de 2016, media del 0,2 % en 2015 y 2016; España, IAPC −0,2, −0,6 y −0,3 % de media en 2014-2016 (Eurostat).

**Valoración:** de ahí un objetivo de inflación positivo (el 2 %, ficha `regla-friedman` y `objetivo-inflacion`) y la preferencia por errar algo por arriba; desinflar sin caer en deflación (ficha `ratio-sacrificio`).

**Gráfico de referencia:** ninguno propio en el 3.A.41. Para la DA con codo en el límite, `fuentes/3A40/graficos/nek-limite-inferior.tex` (ficha `nek-3-ecuaciones`), hasta que el 3.A.37 fije el suyo.

## Cómo se adapta en cada tema

| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.41 | Deflación (título) | desarrollo (hecho, 5/11/2026) | III.2 a)-e) de arriba; Eggertsson y Woodford en mención con `\vertema{3.A.36}`; el límite con `\vertema{3.A.37}` | La NEK en el límite (3.A.37, 3.A.40) |
| 1D01 | Dictamen | uso (aprobada) | Por qué preocupa la deflación de demanda en un dictamen (aplazamiento, deudas de Fisher, límite inferior) | La trampa de Krugman |
| 3.A.42 | Ciclo financiero | mención (hecho) | La deflación por deudas de Fisher como antecedente del ciclo financiero; «la salida es reflacionar» con `\vertema{3.A.41}` | Japón y la zona del euro |
| 3.A.3 | Neoclásicos (Fisher) | mención (hecho) | Fisher (1933) entre sus aportaciones, con la frase de la pág. 344 | La trampa |
| 3.A.40 | Política desde 2008 | mención (hecho) | Krugman (1998) y Japón; la deflación evitada | La deflación buena y mala |
| 3.A.37 | Transmisión, límite inferior | resumen (previsto; en revisión) | La trampa en la NEK y Eggertsson y Woodford en desarrollo; la deflación, `\vertema{3.A.41}` | La deflación buena y mala, la evidencia de Japón y la zona del euro |

## Divergencias encontradas en el temario actual

- **Word del 3.A.41** (resuelto el 5/11/2026): «ZLB» y Eggertsson-Woodford con $u_t$ de demanda en la IS y $e_t$ en la NKPC (contra el canon: la demanda va en $r^n_t$ sin letra, los costes son $u_t$); ahora «límite inferior de los tipos», $i^{\mathrm{ELB}}$, y Eggertsson y Woodford en mención (A41-21).
- Sin contradicciones entre los temas revisados: la frase de Fisher, con la misma página y traducción en el 3.A.3, el 3.A.42 y el 3.A.41; la trampa de Krugman, con la misma idea en el 3.A.40 (I.2) y el 3.A.41.

Autor: Víctor Gutiérrez Marcos
