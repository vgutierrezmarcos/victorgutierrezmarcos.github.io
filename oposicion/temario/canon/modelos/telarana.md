# Modelo de la telaraña (cobweb)

- **Área:** mercados-información-juegos · **Tema de referencia:** **3.A.16** (Mercados I: «dinámicas de ajuste y estabilidad del equilibrio»; revisado el 17/10/2026) — el título pide las dinámicas de ajuste y la ficha del tribunal, «especial referencia a dinámicas de ajuste convergentes o divergentes a través del modelo de la telaraña». Lo desarrolla en el cuerpo (II.1.3 c-e, tercera dinámica tras la walrasiana y la marshalliana) y en el anexo E (lineal, adaptativas, racionales, ciclo límite). Ficha creada a raíz de esa revisión (CN4).
- **Temas que lo usan:** 3.A.16 (desarrollo; hecho, 17/10/2026), 3.A.6 (mención: Muth, 1961, parte de la telaraña para proponer las expectativas racionales; previsto, hoy no la cita), 3.A.5 (mención: expectativas adaptativas, Nerlove, 1958; previsto, hoy no la cita). Pueden citarla 3.B.38 (estabilización de precios agrarios) y 3.A.4 (desequilibrio), sin desarrollarla.
- **Manuales de referencia:** Ezekiel (1938), «The cobweb theorem», *QJE*; Kaldor (1934); Nerlove (1958); Muth (1961); Gandolfo, *Economic Dynamics*; Hommes, Sonnemans, Tuinstra y van de Velden (2007) para la evidencia experimental; Campante, Sturzenegger y Velasco (2021).

## Presentación de referencia (3.A.16, II.1.3 c)

**Pregunta:** si la producción se decide un periodo antes de conocer el precio, ¿llega el mercado al equilibrio?

**Supuestos:** tiempo discreto; la demanda depende del precio corriente, x(p_t), y la oferta del precio que los productores esperaban al decidir, q(p^e_t) (agricultura, ganadería, construcción); **expectativas ingenuas**, p^e_t = p_{t−1}; el precio vacía el mercado cada periodo, x(p_t) = q(p^e_t).

**Ecuación** (`eq:telarana`), linealizando alrededor de p*:
$$x(p_t)=q(p^e_t),\qquad p^e_t=p_{t-1}\ \Longrightarrow\ p_t-p^*\simeq-\frac{q'(p^*)}{\lvert x'(p^*)\rvert}\,(p_{t-1}-p^*)$$
El signo menos hace oscilar el precio. **Converge si q'(p*) < |x'(p*)|**, de 3 formas equivalentes: la oferta reacciona al precio menos que la demanda; en elasticidades en el equilibrio (x* = q*), **ε_S < |ε_D|**; en el plano (q,p), **la oferta es más inclinada que la demanda**. Igualdad: oscilación de amplitud constante (telaraña continua); desigualdad contraria: divergente.

**Anexo E (lineal):** x_t = a_0 − a_1p_t, q_t = b_0 + b_1p^e_t, p_t = (a_0 − b_0)/a_1 − (b_1/a_1)p^e_t, p* = (a_0 − b_0)/(a_1 + b_1).
- Ingenuas: p_t − p* = (−b_1/a_1)^t (p_0 − p*); converge si b_1 < a_1.
- **Adaptativas** (Nerlove, 1958): p^e_t = p^e_{t−1} + γ(p_{t−1} − p^e_{t−1}), 0 < γ ≤ 1; coeficiente ρ ≡ 1 − γ(1 + b_1/a_1); converge si b_1/a_1 < 2/γ − 1 (zona de estabilidad mayor; monótona si ρ ≥ 0).
- **Racionales** (Muth, 1961): con x_t = a_0 − a_1p_t + u_t, 𝔼_{t−1}[u_t] = 0, p^e_t = 𝔼_{t−1}[p_t] = p*, p_t = p* + u_t/a_1: sin ciclo ni errores sistemáticos.
- **Curvas no lineales**: ciclo límite (oferta más plana que la demanda cerca del equilibrio y más inclinada lejos).

**Autores:** formalizada hacia 1930 por Ricci, Schultz y Tinbergen; Kaldor (1934) le da nombre; Ezekiel (1938) la sistematiza.
**Evidencia:** ciclos de precios y producción agrarios, el del porcino y los ganaderos (Ezekiel, 1938); en el laboratorio, con el equilibrio inestable con expectativas ingenuas, los precios oscilan con una volatilidad persistente (Hommes et al., 2007).
**Valoración:** la estabilidad depende del mecanismo de ajuste y de las expectativas, no solo de las curvas (con curvas normales, Walras y Marshall convergen y la telaraña puede divergir); crítica de Muth: los productores no repetirían un error sistemático, origen de las expectativas racionales (3.A.6); con adaptativas el ajuste se amortigua más (3.A.5).

**Gráficos de referencia:** `oposicion/temario/fuentes/3A16/graficos/telarana.tex` (tres paneles en el plano (q,p), D y S: convergente —oferta más inclinada; **imprescindible**—, continua y divergente —apoyo—; el precio inicial es distinto de p*) y `telarana-ciclo-limite.tex` (anexo E; profundización).

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.16 | Dinámicas de ajuste y estabilidad | desarrollo (hecho, 17/10/2026) | Estructura a)-e) dentro de II.1.3: supuestos, `eq:telarana`, condición en 3 formas, gráfico, ciclos ganaderos, Muth; anexo E con las tres expectativas y el ciclo límite | — |
| 3.A.6 | Expectativas racionales | mención (prevista) | Muth (1961) parte del mercado de la telaraña: con expectativas racionales p^e_t = p* y el precio solo se desvía por la perturbación; una frase y \vertema{3.A.16} | La telaraña y su condición de convergencia |
| 3.A.5 | Monetarismo (expectativas adaptativas) | mención (prevista) | Nerlove (1958) introduce las adaptativas en la telaraña; misma forma, x^e_t = x^e_{t−1} + γ(x_{t−1} − x^e_{t−1}), con γ como en el anexo E del 3.A.16 (o, si el tema usa otra letra, avisar) | El modelo de la telaraña |

## Divergencias encontradas en el temario actual
- 3.A.16 original: telaraña en el anexo 2 con capturas en inglés, «partimos de un equilibrio como P_t» y la condición en «elasticidades relativas» sin decir dónde se evalúan; $P_t$, $Q_t$ en mayúscula. Resuelto en la revisión (17/10/2026): en el cuerpo, con $p_t$, $q_t$, $p^e_t$ y la condición en el equilibrio.
- `mapa.yaml` remitía la telaraña a 3.A.10 (que es la incertidumbre); corregido a 3.A.6 y 3.A.5 (17/10/2026).

Autor: Víctor Gutiérrez Marcos
