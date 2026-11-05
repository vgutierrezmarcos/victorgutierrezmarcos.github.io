# Triángulo de Gordon (1977, 1982, 1997): demanda, costes e inercia

- **Área:** macro cerrada · **Tema de referencia:** 3.A.41 (La inflación: causas…) — las causas de la inflación están en el título y el 3.A.41 lo usa como hilo del bloque I (revisado el 5/11/2026: I.2 con `eq:triangulo-gordon` como función clave y el gráfico `esquema-origen-inflacion`). Ficha creada en la fase canon del 3.A.41 (CC2, **[decidir]**; *alternativa*: una sección de la ficha `phillips`, con el 3.A.28 de referencia).
- **Temas que lo usan:** 3.A.41 (desarrollo; hecho, 5/11/2026: I.2 presentación y los 3 vértices en I.2.1-I.2.3; la inflación de 2021-2026 leída con él en I.2.4), 1D01 (uso, aprobada: l. 955-966, la clasificación de los indicios del dictamen por los 3 vértices, con `Gordon2011Phillips`, el mismo gráfico y `\vertema{3.A.41}`), 3.A.28 (mención: la versión con histéresis, en la que cuenta también la variación del paro, es su `eq:phillips-histeresis`; el 3.A.41 la remite con `\vertema{3.A.28}`).
- **Manuales de referencia:** Gordon (1977), «Can the Inflation of the 1970s Be Explained?», *BPEA* (`Gordon1977Can`); Gordon (1982), «Price Inertia and Policy Ineffectiveness in the United States, 1890-1980», *JPE* (`Gordon1982Price`); Gordon (1997), «The Time-Varying NAIRU…», *JEP* (`Gordon1997Time`, donde le pone el nombre); Gordon (2011), «The History of the Phillips Curve…», *Economica* (`Gordon2011Phillips`).

## Presentación de referencia (3.A.41, I.2)

**Pregunta:** ¿de dónde viene la inflación de un año para otro y qué respuesta pide cada causa?

**Supuestos:** la curva de Phillips aumentada del 3.A.28 (`eq:phillips-aumentada`, $\pi_t=\pi^e_t-a(U_t-U^n)+\varepsilon_t$, con $a$ y $U^n$ de D060) y expectativas que miran atrás: el público espera la inflación de los $k$ periodos anteriores, cada uno con su peso.

**Ecuación** (`\funcionclave` `eq:triangulo-gordon`):

$$\pi_t=\underbrace{\sum_{i=1}^{k}a_i\,\pi_{t-i}}_{\text{inercia}}\;\underbrace{-\,a\,(U_t-U^n)}_{\text{demanda}}\;+\underbrace{\varepsilon_t}_{\text{costes}},\qquad\sum_{i=1}^{k}a_i=1$$

- **La suma empieza en $i=1$** (la inflación de hoy está a la izquierda; el Word del 3.A.41 la empezaba en $i=0$).
- **$a_i$ pesos de la inflación pasada, locales y avisados** («las $a_i$ con subíndice no son la pendiente $a$»; A41-04, **[decidir]**; *alternativa* de la coherencia: $\lambda_i$, pero λ es el multiplicador y la fracción de Campbell y Mankiw, § 1).
- **$\varepsilon_t$ perturbación de oferta o de costes**, como en el 3.A.28; en la NKPC del mismo tema la misma perturbación es $u_t$ (3.A.7), con el aviso «la misma perturbación, con la letra de cada modelo» (A41-05, CC4 c); `notacion.md` § 8).

**Los 3 vértices:** **inflación de demanda** (*demand-pull*): el paro por debajo de la tasa natural; **de costes** (*cost-push*): energía, materias primas, márgenes, tipo de cambio, con cualquier nivel de paro; **inercial** (*built-in*): expectativas, indexación y contratos. Los nombres en inglés van en cursiva y entre paréntesis; *built-in* es la **inercia**, no un componente de los costes.

**Implicaciones:** como los pesos suman 1, el triángulo es **aceleracionista**: con $U_t=U^n$ y sin perturbaciones la inflación se queda donde estaba, y solo baja si el paro supera a $U^n$; por eso desinflar cuesta (ficha `ratio-sacrificio`). Cada vértice pide una respuesta distinta (demanda: política monetaria; costes: mirar a través si es transitoria, con las expectativas ancladas; inercia: credibilidad y desindexación). Es la forma en que los bancos centrales leen los datos y la base de los «efectos directos, indirectos y de segunda ronda» de la 1D01.

**Extensiones:** con histéresis, también la variación del paro (`eq:phillips-histeresis` del 3.A.28, ficha `histeresis`); la persistencia, heredada (de las perturbaciones) o intrínseca (de las $a_i$), en la NEK (ficha `nek-3-ecuaciones`: NKPC adelantada y híbrida con $\gamma_b$, $\gamma_f$).

**Gráfico de referencia:** `oposicion/temario/fuentes/1D01/graficos/esquema-origen-inflacion.tex` (3 vértices, demanda, costes e inercia; el 3.A.41 lo copia sin cambios con el pie «Los 3 vértices son los 3 orígenes de la inflación y los 3 términos de `eq:triangulo-gordon`»).

## Cómo se adapta en cada tema

| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.41 | Causas de la inflación | desarrollo (hecho, 5/11/2026) | I.2: de dónde viene (Phillips, Samuelson-Solow, Friedman-Phelps), `eq:triangulo-gordon` como función clave, los 3 vértices como esquema del bloque I (demanda, I.2.1; costes con la NKPC, I.2.2; inercia en desarrollo con a)-e), I.2.3), la inflación de 2021-2026 a la luz del triángulo (I.2.4) y la desinflación (III.2.3) | — |
| 1D01 | Dictamen: por qué sube la inflación | uso (aprobada) | La clasificación de los indicios del cuadro por vértices (brecha y crédito; CLU, energía y tipo de cambio; expectativas e indexación), con el gráfico y `\vertema{3.A.41}`; los efectos directos, indirectos y de segunda ronda | La ecuación |
| 3.A.28 | Paro e histéresis | mención | La curva aumentada es la base; con histéresis cuenta la variación del paro (`eq:phillips-histeresis`) | El triángulo |

## Divergencias encontradas en el temario actual

- **Word del 3.A.41** (resuelto el 5/11/2026): la suma desde $i=0$ (con $\pi_t$ a los 2 lados), $\overline U$, $b$ como pendiente, $S_t$ para los factores de oferta y el error aparte: ahora `eq:triangulo-gordon` con $U^n$, $a$, $a_i$ y $\varepsilon_t$.
- **1D01** (aprobada, no se toca sin Víctor): en l. 957 escribe «suben los salarios y los CLU (inflación incorporada, *built-in*)» en el vértice de **costes**; en el triángulo, *built-in* es la **inercia** (el gráfico copiado no tiene la errata). Anotado en `pendientes-coherencia.md` («Pendiente del 3.A.41»), **[decidir]**.

Autor: Víctor Gutiérrez Marcos
