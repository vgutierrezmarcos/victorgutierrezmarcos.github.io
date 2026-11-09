# Imposición óptima de las rentas del capital: el resultado de Chamley y Judd

- **Id:** `chamley-judd` (alias `impuesto-capital-optimo`, `chamley-1986`, `judd-1985`). Ficha nueva del 5/11/2026 (el id ya estaba en `alias.json`, `areas.json` y en la lista del 4.B.11, sin fichero).
- **Área:** sector público · **Tema de referencia:** **3.A.38** (La política fiscal: efectos sobre el crecimiento económico y el ahorro), **hecho el 5/11/2026**: II.1 `sec:horizonte-infinito`, iii) a e), con `eq:euler-tauk` como función clave. **[decidir]** (CC2 del 3.A.38): es un resultado teórico y el criterio de `CRITERIOS.md` § 6 lleva la referencia al 3.er ejercicio; el 3.A.38 es el que lo desarrolla con el modelo (la Euler con $\tau_K$, la intuición, los matices y la evidencia). *Alternativa*: el 4.B.11 (imposición óptima), que lo tiene en su inventario como desarrollo; en ese caso el 3.A.38 lo resumiría. Con cualquiera de las 2, el 4.B.11 lo cuenta completo para su examen.
- **Temas que lo usan:** 3.A.38 (desarrollo; referencia; hecho, 5/11/2026), 4.B.11 (resumen amplio, junto a Atkinson-Stiglitz; hoy desarrollo en su Word, con τ como «impuesto equivalente sobre el consumo»), 3.A.43 (mención; hecho, 31/10/2026: III.3 c), «el impuesto óptimo sobre las rentas del capital a largo plazo es nulo… `\vertema{3.A.38}`», l. 838), 4.B.12 y 4.B.10 (mención prevista: el debate renta frente a consumo y la tributación del capital; 4.B.12 lo pide en su inventario).
- **Fuentes de referencia:** Judd (1985), «Redistributive taxation in a simple perfect foresight model», *JPubE* (`Judd1985Redistributive`); Chamley (1986), «Optimal taxation of capital income in general equilibrium with infinite lives», *Econometrica* (`Chamley1986Optimal`). El inventario del 4.B.11 los fecha al revés («Chamley (1985) y Judd (1986)»): son **Judd (1985) y Chamley (1986)**. Atkeson, Chari y Kehoe (1999), *FRB Minneapolis QR* (intuición); Straub y Werning (2020), «Positive long-run capital taxation: Chamley-Judd revisited», *AER* (`StraubWerning2020Positive`); Aiyagari (1995), *JPE* (mercados incompletos; citado por su resultado conocido, A38-15); Conesa, Kitao y Krueger (2009), *AER* (36 % en el ciclo vital); Acemoglu (2009), cap. 8, y Barro y Sala-i-Martin (2004), cap. 3, para el gráfico.

## Presentación de referencia (la del 3.A.38, II.1)

**Pregunta:** ¿cuánto conviene gravar las rentas del capital a largo plazo, si los hogares miran al futuro sin límite?

**Pegatina** (3.A.38, A38-03): «no mates la gallina de los huevos de oro» (el capital es la gallina: gravar lo que rinde reduce la puesta de todos los años futuros).

**Supuestos:** los del RCK del 3.A.43 (hogares de vida infinita con CRRA θ, población a la tasa $n$, progreso técnico $g$, competencia perfecta, trabajo inelástico; $k$ y $c$ por unidad de trabajo eficiente; ficha `ramsey-cass-koopmans`), con un Estado que compra $G_t$ y puede financiarlo con suma fija, deuda o un tipo $\tau_K$ sobre las rentas del capital. Para el resultado: el Estado puede comprometerse y la economía converge a un estado estacionario.

**Ecuación** (función clave):
$$\frac{\dot c_t}{c_t}=\frac{(1-\tau_K)\big(f'(k_t)-\delta\big)-\rho-\theta g}{\theta}\quad\Longrightarrow\quad f'(k^*)=\delta+\frac{\rho+\theta g}{1-\tau_K}\qquad(\texttt{eq:euler-tauk})$$
El impuesto grava el rendimiento neto de la depreciación. El lugar $\dot c=0$ se desplaza a la izquierda: menos capital, renta y consumo en el nuevo estado estacionario; en el momento de la subida el consumo salta hacia arriba y la economía desacumula. Un impuesto constante sobre el consumo, o sobre el trabajo con oferta inelástica, actúa como uno de suma fija.

**El resultado:** si el Estado puede comprometerse, **el impuesto óptimo sobre las rentas del capital a largo plazo es nulo**, aunque quiera redistribuir hacia los trabajadores (Judd) y tenga que financiar su gasto con impuestos distorsionantes (Chamley).

**Intuición (2 viñetas):**
1. Un $\tau_K$ constante es un impuesto sobre el consumo futuro que crece con la distancia: un euro ahorrado rinde $(1+r)^T$ sin impuesto y $[1+(1-\tau_K)r]^T$ con él; la cuña crece sin límite con $T$ (Atkeson, Chari y Kehoe, 1999). La regla de Ramsey pide no gravar mucho más unos bienes que otros parecidos, y el consumo de 2040 y el de 2041 lo son (`\vertema{4.B.11}`).
2. En el estado estacionario la oferta de capital es infinitamente elástica al rendimiento neto: por `eq:euler-tauk`, $(1-\tau_K)(f'(k^*)-\delta)=\rho+\theta g$ no depende del impuesto; todo él recae en el trabajo, vía un salario menor, y es mejor gravar el trabajo directamente.

**Implicación:** conviene gravar el capital ya instalado y comprometerse a no gravar el futuro: **inconsistencia temporal** (`\vertema{3.A.36}`).

**Extensiones:** Straub y Werning (2020): en el modelo de Judd, con elasticidad de sustitución intertemporal menor que 1, el impuesto óptimo a largo plazo es positivo y alto; en el de Chamley, los límites al impuesto pueden estar activos para siempre, y la convergencia puede tardar décadas. Con mercados incompletos y riesgos sin asegurar (Aiyagari, 1995) o con vidas finitas, positivo: en torno al **36 %** en el ciclo vital calibrado de Conesa, Kitao y Krueger (2009).

**Evidencia:** los Estados no lo siguen: tipo implícito sobre el capital en 2024, **29,5 % en España y 32,5 % en la UE** (Comisión Europea, `CE2026ITRCapital`; nueva metodología, una sola fuente), frente al 36,2 % y el 37,1 % del trabajo (`CE2026DataTaxation`).

**Gráfico de referencia:** `oposicion/temario/fuentes/3A43/graficos/rck-impuesto.tex` (copiado sin cambios en `fuentes/3A38/graficos/`; aquí `fig:rck-impuesto`, a partir de Acemoglu, 2009, fig. 8.2, y Barro y Sala-i-Martin, 2004, fig. 3.1). En el cante del 3.A.38, de palabra; `eq:euler-tauk` recuadrada en la pizarra hasta el final.

**Contraste con el crecimiento endógeno** (3.A.38, III.2, «nivel frente a tasa»): en el RCK el mismo $\tau_K$ solo baja el **nivel** del capital; en el $AK$ de Rebelo baja la **tasa** de crecimiento para siempre, `eq:rebelo` (ficha `ak`).

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.38 | Efectos de la política fiscal sobre el ahorro | **desarrollo (referencia; hecho, 5/11/2026)** | II.1 iii)-e): lo de arriba, dentro del RCK fiscal en resumen | El diagrama de fases completo del RCK (`\vertema{3.A.43}`) |
| 4.B.11 | Imposición óptima, tipo óptimo, Ramsey | resumen amplio (hoy desarrollo) | Resultado, las 2 intuiciones (la de Ramsey intertemporal en primer plano), inconsistencia temporal, Straub y Werning, vidas finitas, junto a Atkinson-Stiglitz; **$\tau_K$ para el tipo**, no τ como «impuesto equivalente sobre el consumo»; Judd (1985) y Chamley (1986) con sus años; `\vertema{3.A.38}` para ampliar | La Euler y el gráfico, si no hacen falta |
| 3.A.43 | Crecimiento exógeno: RCK | mención (hecho, 31/10/2026) | Una viñeta en III.3 c) con `\vertema{3.A.38}` | — |
| 4.B.12, 4.B.10 | Impuestos directos; imposición y oferta | mención (prevista) | El debate renta frente a consumo y el tipo sobre el capital | El modelo |

## Divergencias encontradas en el temario actual
- Inventario del 4.B.11: «Chamley (1985) y Judd (1986)», años cambiados; τ para 3 cosas (vector de instrumentos, recaudación en Barro, impuesto equivalente sobre el consumo en Chamley-Judd). Al revisarlo: $\tau_K$, $T_t$ para la recaudación (`notacion.md`).
- Word del 3.A.38: «Judd, Chamley, Jones y Stoky y Rebelo» en una lista sin modelo; **resuelto** (5/11/2026): Chamley-Judd en II.1 y Rebelo con `eq:rebelo` en III.2; Jones, Manuelli y Rossi (1993) y Stokey y Rebelo (1995), sin citar (no comprobados, A38-18).

Autor: Víctor Gutiérrez Marcos
