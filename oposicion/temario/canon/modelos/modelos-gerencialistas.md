# Modelos gerencialistas: Baumol (1959), Williamson (1964) y Marris (1964)

Alias: `marris` (el id que usaba el 3.B.4 en `mapa.yaml`; en `_inventario/alias.json`).

- **Área:** mercados-información-juegos (teoría de la empresa) · **Tema de referencia:** **3.A.15** (La empresa: el tamaño eficiente y sus límites…; revisado el 20/10/2026, I.2.2 `sec:gerencialistas`, con el anexo `anexo:baumol`) — los desarrolla con a)-c), con Baumol en la pizarra. Ficha creada a raíz de esa revisión (opcional en C5 de coherencia: se crea porque el 3.B.4 usa Marris y el crecimiento de la empresa).
- **Temas que lo usan:** 3.A.15 (desarrollo; hecho, 20/10/2026), 3.B.4 (mención o resumen: Marris y el crecimiento de la empresa; hoy lo pone dentro de la teoría de la agencia), 4.B.2 (mención posible: Niskanen, 1971, es la versión burocrática del maximizador del tamaño; ficha `niskanen`), 3.A.12 (mención; hecho, 14/10/2026: la ineficiencia X como bisagra, ficha `ineficiencia-x`).
- **Manuales de referencia:** Baumol (1958, 1959), *Business Behavior, Value and Growth*; Williamson (1964), *The Economics of Discretionary Behavior*; Marris (1963, 1964), *The Economic Theory of «Managerial» Capitalism*; Berle y Means (1932); Leibenstein (1966); Hicks (1935); Stigler (1976).

## Presentación de referencia (3.A.15, I.2.2)

Pregunta: ¿qué hace la empresa si la dirigen directivos que no son sus dueños? Conclusión: maximiza el objetivo de los directivos (ventas, gasto discrecional, crecimiento) sujeto a un **beneficio mínimo** para los accionistas; describe bien el conflicto, pero con información perfecta no explica por qué los propietarios no lo resuelven: la bisagra hacia la agencia es la ineficiencia X.

- **a) Idea**: separación entre propiedad y control (Berle y Means, 1932); beneficio mínimo $\underline B$.
- **b) Modelo. i) Supuestos**: los directivos deciden y maximizan su objetivo; los accionistas solo exigen $\underline B$; información perfecta y simétrica. **ii) Desarrollo**:
  - **Baumol** (maximización de las ventas): `\optim{\max}{q}{I(q)=p(q)\,q}{B(q)=I(q)-C(q)\geq\underline{B}}`. Si la restricción no es activa, IMg = 0; si lo es, $q^B$ con $B(q^B)=\underline B$, $q^B>q^M$ y $\mathrm{IMg}(q^B)=\frac{\lambda}{1+\lambda}\mathrm{CMg}(q^B)$ (λ multiplicador; derivación de Kuhn-Tucker en el anexo).
  - **Williamson (1964)** (utilidad de los directivos): `\optim{\max}{S,\,M}{U(S,M,I_D)}{B(S)-M\geq\underline{B}}`, con $S$ gasto en personal, $M$ emolumentos y gastos discrecionales, $I_D=B(S)-M-\underline B$ inversión discrecional; en el plano $(S,\,B-\underline B)$, curva de beneficio en campana y tangencia a la derecha del máximo: **gasta de más en personal**.
  - **Marris** (crecimiento): maximiza la tasa de crecimiento equilibrado (demanda y capital) sujeta a una **restricción de seguridad** (ratio de valoración que evite la absorción); crece más que el maximizador del valor.
  **iii) Implicaciones**: Baumol produce más, cobra menos y gasta más en publicidad; si sube un coste fijo, **reduce** la producción (el maximizador del beneficio no la cambia); Williamson recorta más personal en las recesiones; ligar la retribución al beneficio o a la cotización acerca la tangencia al máximo (curva $U'$ y $S^{**}$), con el riesgo de las opciones sobre acciones.
- **c) Valoración**: con información perfecta no hay conflicto que resolver; la bisagra es la **ineficiencia X** (Leibenstein, 1966; $C^{\mathrm{obs}}=(1+\chi)C$, 3.A.12; «la vida tranquila» de Hicks, 1935; réplica de Stigler, 1976) y el debate desemboca en la agencia (ficha `principal-agente`) y en los contratos incompletos (ficha `contratos-incompletos`).

**Gráficos de referencia:** `oposicion/temario/fuentes/3A15/graficos/baumol.tex` (I, C, B, recta $\underline B$, $q^M$, IMg = 0, $q^B$; por capas en la pizarra con el problema `\optim` arriba) y `fuentes/3A15/graficos/williamson-gerencial.tex` (plano $(S,\,B-\underline B)$, campana, tangencia y curva $U'$ con $S^{**}$; apoyo, no se canta).

**Notación** (`notacion.md` § 4): $\underline B$ (raya debajo, como el salario mínimo $\underline w$); $I(q)=p(q)q$ (ingreso total, como en los anexos del 3.A.17); $q^B$ (Baumol; no $q^S$, que es Stackelberg en el 3.A.19); $q^M$; $U(S,M,I_D)$ (no $T$, que choca con la transferencia y los periodos); λ multiplicador (en el 3.A.15 no hay índice de Lerner en ese apartado; la lagrangiana no se escribe con 𝓛: `notacion.md` § 0); χ (ineficiencia X, 3.A.12).

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.15 | Objetivos de la empresa y límites internos | desarrollo (hecho, 20/10/2026) | Todo lo anterior; Baumol en la pizarra, Williamson con gráfico sin cantar, Marris en una frase (D5 del 3.A.15) | La agencia formal (3.A.13) |
| 3.B.4 | Crecimiento de la empresa | mención o resumen | Marris con su restricción de seguridad como teoría del crecimiento, junto a Penrose y Gibrat; gerencialista, no de agencia; remitir al 3.A.15 Baumol y Williamson | Baumol y Williamson |
| 4.B.2 | Burocracia | mención (posible) | Niskanen (1971) como el maximizador del tamaño en el sector público (ficha `niskanen`) | — |

## Divergencias encontradas en el temario actual
- 3.A.15 original: Baumol con la numeración 1, 5, 6, «produce donde el ingreso marginal es cero» sin beneficio mínimo y un tercer motivo «gestión tranquila → colusión tácita»; Williamson (1964) con $\max U=f(S,M,T)$ s.a. $\pi_R\ge\pi_0$ sin definir; Marris sin restricción; imágenes sin fuente. **Resuelto** (20/10/2026).
- 3.B.4 (sin revisar): Marris dentro de la «teoría de la agencia» (es un modelo gerencialista).

Autor: Víctor Gutiérrez Marcos
