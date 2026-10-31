# Externalidades del capital: aprendizaje por la práctica con desbordamientos (Arrow 1962; Romer 1986)

- **Área:** macro cerrada · **Tema de referencia:** **3.A.44** (crecimiento endógeno: rendimientos crecientes) — único tema que lo desarrolla: I.2.4 (`sec:externalidades`, 1′30″ en el cante) con a)-d); revisado el 1/11/2026. Ficha creada en la fase canon del 3.A.44 (CC2; **[decidir]**). **Id `arrow-romer-spillovers`** (ya estaba en `mapa.yaml`, `alias.json`, `areas.json` y la ficha `grossman-helpman`); alias `learning-by-doing`, `aprendizaje-por-la-practica`, `romer-1986` y **`lucas-spillovers`** (el id que el inventario dio al «modelo de Lucas» del 3.B.9, que se quita de `uzawa-lucas`).
- **Temas que lo usan:** 3.A.44 (desarrollo; hecho, 1/11/2026), 3.B.9 (resumen: su «modelo de Lucas de externalidades», que hay que renombrar), 3.A.38 (mención: Barro, 1990, leído como desbordamiento del gasto público), 3.A.43 (mención; hecho, 31/10/2026: «con externalidades del capital o del conocimiento el mercado invierte de menos», valoración del RCK)
- **Manuales de referencia:** Arrow (1962), *REStud*; Romer (1986), *JPE* (tesis de 1983, Chicago); Barro y Sala-i-Martin (2004), sec. 4.3; Sala-i-Martín (2000), cap. 3; Acemoglu (2009), cap. 11; Wright (1936). La curva de aprendizaje de la empresa, base de la regularidad, es la ficha `curva-aprendizaje` (3.A.12).

## Presentación de referencia (3.A.44, I.2.4)

**Nombre:** «Externalidades del capital: aprendizaje por la práctica (Arrow, 1962; Romer, 1986)». **No** «modelo de Lucas (1988)»: la externalidad de Lucas es la del **capital humano medio** (ficha `uzawa-lucas`). Nota al opositor: el test de junio de 2024 (pregunta 25) lo llama «modelo de Lucas de externalidades»; conviene saber los 2 nombres.

**a) Idea.** La regularidad: la curva de aprendizaje de los fuselajes (Wright, 1936; `\vertema{3.A.12}`), generalizada por Arrow (1962): el conocimiento es un subproducto de producir e invertir. El **desbordamiento**: el conocimiento es no rival y difícil de proteger, y lo que aprende una empresa pasa a las demás (Romer, 1986: la inversión de cada empresa aumenta el conocimiento de toda la economía; «quien a buen árbol se arrima, buena sombra le cobija»). Consecuencia: el rendimiento **social** del capital supera al **privado**; externalidad positiva (`\vertema{3.A.23}`).

**b) i) Supuestos.** Los de Solow (o de Ramsey) con empresas competitivas que producen con
$$Y_j=A\,K_j^{\alpha}L_j^{1-\alpha}E^{\eta},\qquad 0<\alpha<1,\ \eta\geq0\qquad(\texttt{eq:externalidad})$$
**E** conocimiento de la economía, dado para cada empresa $j$; **η** elasticidad de la producción a la externalidad (con η = 0, Cobb-Douglas; misma letra que la externalidad de Lucas, `notacion.md` § 1). Cada empresa, rendimientos constantes; la economía, crecientes si η > 0. **E = K** (Romer, 1986: capital agregado, con efecto escala) o **E = k ≡ K/L** (variante sin efecto escala, **la principal**; A44-05). En el tema, E es el conocimiento solo en esta ecuación (E es la función de gasto y el tipo de cambio, § 1).

**b) ii) Desarrollo.**
- Con $E=k$ e iguales: $y=A\,k^{\alpha+\eta}$ y, con ahorro constante, $\gamma_k=s\,A\,k^{\alpha+\eta-1}-(n+\delta)$. **3 casos**: α + η < 1 (Solow: estado estacionario y convergencia condicional); **α + η = 1** ($AK$: $\gamma=sA-(n+\delta)$); α + η > 1 (estado estacionario inestable, crecimiento explosivo o colapso).
- Con hogares y α + η = 1: el producto marginal privado es αA y el social A:
$$\gamma^{\mathrm E}=\frac{\alpha A-\delta-\rho}{\theta}\quad<\quad\gamma^{\mathrm P}=\frac{A-\delta-\rho}{\theta}$$
  (pizarra: «externalidades: $r=\alpha A-\delta$ (privado) $<A-\delta$ (social)»).
- Con $E=K$, η = 1 − α y población constante: $Y=A\,L^{1-\alpha}K$; la tasa de crecimiento sube con la población (**efecto escala**; anuncia el III del 3.A.44 y la ficha `semiendogeno`).

**b) iii) Implicaciones.** Rendimientos crecientes compatibles con la competencia perfecta (son externos a la empresa); **falla el 1TFEB** (`\vertema{3.A.22}`): se invierte y se crece de menos; la política sube la tasa a largo plazo: **subvenciones a la inversión** o desgravaciones del capital (corrección pigouviana) o inversión pública; efecto escala con E = K, que desaparece con E = k.

**c) Evidencia.** De Long y Summers (1991): la inversión en equipo se asocia a más crecimiento del que explica su rendimiento privado; curvas de aprendizaje documentadas en aviones, barcos, semiconductores y paneles solares (`\vertema{3.A.12}`), pero no del tamaño necesario para α + η = 1.

**d) Valoración.** A favor: rendimientos no decrecientes agregados sin abandonar la competencia; fundamento de la intervención. En contra: filo de la navaja (α + η = 1 exactamente); efecto escala con E = K que la evidencia no apoya; el progreso técnico sigue siendo un subproducto no buscado; no distingue el capital humano → Uzawa-Lucas.

**Relación con el $AK$:** la nota del $AK$ en el 3.A.44 (`nota:ak-salario`) muestra que con $Y_j=K_j^{\alpha}(QL_j)^{1-\alpha}$ y $Q=K/L$ el agregado es $Y=K$: un $AK$ con salario positivo, $r+\delta=\alpha$ privado frente a 1 social.

**Gráfico de referencia:** `oposicion/temario/fuentes/3A44/graficos/externalidades.tex` (3 paneles en tasas: α + η < 1, = 1, > 1). En el cante, las capas α + η del gráfico `tasas-endogeno`.

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.44 | Rendimientos crecientes con competencia | desarrollo (hecho, 1/11/2026) | Lo de arriba; con E = k la principal y E = K para el efecto escala | — |
| 3.B.9 | Comercio y crecimiento | resumen | Con el nombre de Arrow y Romer (no «Lucas»), la misma `eq:externalidad` con E y η, y lo que añade la apertura (el conocimiento se desborda entre países); si usa β para la externalidad de la apertura, decir que no es el factor de descuento | La derivación de los 3 casos `\vertema{3.A.44}` |
| 3.A.38 | Política fiscal y crecimiento | mención | Barro (1990) como desbordamiento: la inversión pública eleva la productividad de todas las empresas | El modelo |
| 3.A.43 | Valoración del RCK | mención (hecho, 31/10/2026) | Con externalidades del capital, el mercado invierte de menos | El modelo `\vertema{3.A.44}` |

## Divergencias encontradas en el temario actual
- 3.A.44 (Word) y 3.B.9: lo atribuían a **Lucas (1988)** («Modelo de Lucas de externalidades del capital»). En el 3.A.44, **resuelto** (1/11/2026); en el 3.B.9, pendiente (sin revisar), y el inventario le asignaba el id `uzawa-lucas` (alias `lucas-spillovers`, que pasa aquí).
- 3.A.44 (Word): «la tesis de Romer (1986)» (la tesis es de 1983; el artículo, de 1986), «si E = 0, Cobb-Douglas» (es con η = 0), ejemplo de los aviones «tras la Segunda Guerra Mundial» (la curva es de Wright, 1936), $Q=K/L$ y $E_t^{\eta}$ con E sin definir. **Resuelto**.

Autor: Víctor Gutiérrez Marcos
