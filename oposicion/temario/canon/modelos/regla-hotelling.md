# Regla de Hotelling: la gestión intertemporal de un recurso agotable (Hotelling, 1931)

- **Área:** macro cerrada (método aplicado a los recursos naturales) · **Tema de referencia:** **3.A.29** (revisado el 1/11/2026; fase canon del 3/11/2026) — es el único tema que la desarrolla: de palabra en I.2.2 c) (`sec:aplicaciones-empresa`, «recursos agotables» en el título del subapartado) y el modelo en el **anexo E** (`anexo:hotelling`), como aplicación del control óptimo a una empresa. Ficha creada en la fase canon del 3.A.29 (CC5, DK8, **[decidir]**); el id `regla-hotelling` estaba en el mapa sin ficha. **Ojo con el id:** `hotelling` es la ciudad lineal (3.A.18) y `downs-hotelling` la competencia electoral.
- **Temas que lo usan:** 3.A.29 (desarrollo; hecho, 1/11/2026), 3.B.31 (mención; hecho, 31/10/2026: la **paradoja verde**, Sinn, 2008, «el dueño de un recurso agotable lo extrae de modo que su precio neto crezca al ritmo del tipo de interés: dejarlo bajo tierra es su forma de ahorrar», con `Hotelling1931Economics`; l. 631), 3.A.43 (mención implícita; hecho, 31/10/2026: el Solow con recursos agotables de II.2, con γ_R = −b, no la cita; nada que cambiar), 4.A.5 y 4.A.6 (mención prevista: energía y política medioambiental).
- **Manuales de referencia:** Hotelling (1931), *Journal of Political Economy*; Perman, Ma, Common, Maddison y McGilvray (2011), *Natural Resource and Environmental Economics*, 4.ª ed., caps. 14-15 y apéndice 14.1; Dasgupta y Heal (1979); Perloff (2012) para la renta de escasez; Livernois (2009) para la evidencia; Sinn (2008) para la paradoja verde.

## Presentación de referencia (3.A.29, anexo E, estructura a)-b))

**a) Idea.** En un recurso que se agota, lo que se extrae hoy no se podrá extraer mañana: su gestión es genuinamente intertemporal y el recurso se trata como un **activo**. En nota: recursos flujo (no se agotan) frente a stock, renovables (con regeneración) y no renovables.

**b) Modelo.**
- *Supuestos*: un propietario competitivo de un yacimiento de tamaño $\overline S$ extrae $R_t$ y lo vende al precio $p_t$, que toma como dado, con un **coste marginal de extracción constante, $\mathrm{CMg}$**, y descuenta al tipo $r$; las reservas $S_t$ caen con la extracción. Un solo propietario (el original metía la extracción de $J$ empresas en la ecuación de estado de una sola) y coste marginal constante (no «costes crecientes con coste marginal constante»).
- *Problema* (con `\optim`):
$$\max_{\{R_t\}}\int_0^Te^{-rt}(p_t-\mathrm{CMg})R_t\,dt\quad\text{s.a.}\quad\dot S_t=-R_t,\quad S_0=\overline S,\quad S_T\geq0$$
- *Solución* con el hamiltoniano en valor corriente (anexo de control óptimo, ficha `optimizacion-dinamica`): $\mathcal H_t=(p_t-\mathrm{CMg})R_t-\lambda_tR_t$; si se extrae, $p_t-\mathrm{CMg}=\lambda_t$: **el precio neto o regalía es el precio sombra del recurso**; como 𝓗 no depende de $S_t$, $\dot\lambda_t=r\lambda_t$, y de ahí la **regla de Hotelling** (`eq:hotelling`):
$$\frac{d(p_t-\mathrm{CMg})/dt}{p_t-\mathrm{CMg}}=r.$$
  En valor presente, $\lambda^0_t=e^{-rt}\lambda_t$ es constante (nota).
- *Implicaciones*: (1) **condición de arbitraje**: extraer y prestar el dinero frente a dejar el recurso bajo tierra; en equilibrio rinden lo mismo (es la Euler de un activo, la misma lógica que la q del 3.A.34); (2) **no hay beneficio extraordinario**: la regalía es una **renta de escasez**, el coste de oportunidad del recurso (Perloff, 2012, en nota), que el análisis estático confundiría con un beneficio; vale para cualquier empresa (los costes económicos incluyen el de oportunidad de los recursos propios); (3) **la paradoja verde**: si se esperan impuestos crecientes sobre el carbono, adelantar la extracción es racional (`\vertema{3.B.31}`).
- *Extensiones* (no están en el 3.A.29; para el tema que las necesite): con demanda $p_t=P(R_t)$, la senda de precios crecientes y el agotamiento en $T$ con el precio de reserva o tecnología *backstop*; costes de extracción que dependen de las reservas; monopolio (extrae más despacio: «el monopolista es amigo del conservacionista», Solow, 1974); exploración.
- *Evidencia*: los precios reales de los recursos no siguen la regla de forma clara (Livernois, 2009): costes decrecientes, descubrimientos, incertidumbre.

**En el cuerpo del 3.A.29** (I.2.2 c), de palabra, en una frase del cante): la condición de arbitraje del recurso bajo tierra, su precio neto crece al tipo de interés, que es la Euler de un activo; con la paradoja verde y `\vertema{3.B.31}`.

**Gráfico de referencia:** no hay (el esquema de la nota 47 del original, el árbol de los tipos de recursos, quedó como nota sin gráfico, P33). Si un tema lo necesita: precio neto $p_t-\mathrm{CMg}$ creciendo exponencialmente a $r$ y extracción $R_t$ decreciente hasta el agotamiento.

## Notación
$R_t$ extracción, $\overline S$ reservas iniciales, **$S_t$ reservas, local del anexo E con nota** (en el Diamond del mismo tema, $S_t$ es el ahorro de los jóvenes; A29-18, **[decidir]**: la letra de Perman y de Hotelling; alternativa, otra letra local), $p_t$ precio, $\mathrm{CMg}$ coste marginal en redonda (como PMg), λ_t regalía o precio sombra en valor corriente (λ⁰_t en valor presente), $r$ tipo de interés (la empresa descuenta con $r$, no con ρ). Nunca «$\partial C_t(R_{j,t})/\partial R$» ni $J$ empresas en la ecuación de estado. $R_t$ coincide con el recurso del Solow con recursos del 3.A.43 (II.2, γ_R = −b), que es el flujo usado en la producción: mismo objeto, sin choque.

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.29 | Modelización dinámica | desarrollo (hecho, 1/11/2026; tema de referencia) | Una frase en I.2.2 c); el modelo a)-b) en el anexo E con `eq:hotelling`, regalía = precio sombra, arbitraje, renta de escasez, paradoja verde | — |
| 3.B.31 | Cambio climático | mención (hecho, 31/10/2026) | La paradoja verde: el precio neto crece a $r$; impuestos crecientes adelantan la extracción | El modelo `\vertema{3.A.29}` (remisión opcional) |
| 3.A.43 | Crecimiento con recursos | mención implícita (hecho, 31/10/2026) | El recurso agotable en la producción de Solow (II.2); no cita la regla | — |
| 4.A.5 | Energía en España | mención prevista | El precio del petróleo y del gas como activos; la regla y su evidencia | El modelo |
| 4.A.6 | Política medioambiental | mención prevista | La paradoja verde y el diseño temporal de los impuestos al carbono | El modelo |

## Divergencias encontradas en el temario actual
- 3.A.29 original: «costes crecientes con coste marginal constante», la derivada $\partial C_t(R_{j,t})/\partial R$ mal escrita, la extracción de $J$ empresas en la ecuación de estado de una sola, texto tomado del tema de un preparador sin cita; remisión al 3.B.31 por «recursos naturales como inputs» (el 3.B.31 no los trata). **Resuelto** (1/11/2026): un propietario, $\mathrm{CMg}$, Hotelling (1931) y Perman *et al.* (2011) citados, el 3.B.31 para la paradoja verde.
- 3.B.31 (revisado): usa la regla en una línea, con `Hotelling1931Economics`, sin remitir al 3.A.29: correcto (se canta solo); la remisión es opcional y no se registra como pendiente.

Autor: Víctor Gutiérrez Marcos
