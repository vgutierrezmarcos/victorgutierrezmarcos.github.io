# Competencia por comparación (Shleifer, 1985) y mecanismo de Loeb-Magat (1979)

- **Área:** sector público · **Tema de referencia:** 3.A.17 (anexo A; revisado el 17/10/2026, A.3), junto a Averch-Johnson, *price cap* y Laffont-Tirole: es teoría de la regulación del monopolio natural (el mapa proponía 4.B.15, donde solo se menciona y que lo resume para las empresas públicas). Recoge el id `loeb-magat` (alias en `_inventario/alias.json`). **Decidido (P21-02, Víctor, 21/10/2026):** pasar la referencia (también la de Loeb-Magat) al 3.A.20 cuando se revise y dejar el 3.A.17 en «mención», con su anexo A resumido y remisión (ficha `laffont-tirole`).
- **Decisión D091 (13/10/2026):** ¿Cuál es el tema de referencia de la competencia referencial (yardstick)? 3.A.17, junto a Averch-Johnson, price cap y Laffont-Tirole.
- **Temas que lo usan:** 3.A.17 (desarrollo en el anexo A, no se canta; hecho, 17/10/2026), 3.A.12 (mención: la medición de la eficiencia con DEA y frontera estocástica como base de la regulación por comparación; hecho, 14/10/2026), 4.B.15 (resumen; hoy mención), 3.A.20 (previsto; referencia cuando se revise, P21-02), 4.A.5/4.A.12 (aplicación prevista: distribución eléctrica, aeropuertos).
- **Manuales de referencia:** Shleifer (1985), «A theory of yardstick competition», *RAND Journal*; Loeb y Magat (1979), *Journal of Law and Economics*; Laffont y Tirole (1993); Baldwin, Cave y Lodge (2012); Jamasb y Pollitt (2001); Joskow (2014).

## Presentación de referencia (3.A.17, anexo A)
**Competencia por comparación** (a)-d)):
- *Idea*: con varias empresas reguladas parecidas en zonas distintas (distribuidoras de electricidad o agua, hospitales), el regulador fija el precio de cada una con los costes de las **demás**: crea competencia entre monopolios locales y resuelve la revelación de costes.
- *Modelo*: N empresas idénticas, coste unitario c_i que se reduce invirtiendo R(c_i), R' < 0; el regulador fija
$$p_i=\bar c_{-i}\equiv\frac{1}{N-1}\sum_{j\neq i}c_j,\qquad T_i=\bar R_{-i}\equiv\frac{1}{N-1}\sum_{j\neq i}R(c_j);$$
la empresa maximiza (c̄_{−i} − c_i)q(c̄_{−i}) + T_i − R(c_i) ⇒ −R'(c_i) = q(c̄_{−i}): invierte hasta que el último euro ahorra un euro; en el equilibrio simétrico, coste eficiente, precio igual al coste y sin rentas (letras locales; empresas i y j ≠ i como la fuente).
- *Implicaciones*: no gana nada inflando costes; incentivos de precio fijo sin las rentas de un *price cap* mal calibrado.
- *Evidencia*: exige medir la eficiencia relativa con DEA o frontera estocástica (3.A.12, ficha `eficiencia-frontera`); en Alemania, ingresos máximos de las distribuidoras eléctricas con los 2 métodos, el valor más favorable y un mínimo del 60 % (BNetzA; ARegV); Jamasb y Pollitt (2001) para la experiencia internacional.
- *Valoración*: empresas comparables (o corregir diferencias observables) y riesgo de colusión (Baldwin, Cave y Lodge, 2012).

**Mecanismo de Loeb y Magat** (1979): el monopolista fija el precio y recibe como subvención todo el excedente del consumidor que genera; su objetivo pasa a ser el excedente total y elige p = CMg sin que el regulador conozca sus costes. Inconvenientes: el regulador debe conocer la demanda y el monopolista se queda con todo el excedente; se corrige subastando el derecho al esquema.

**Evidencia de la regulación por incentivos** (Joskow, 2014): menores costes de operación; hay que vigilar la calidad y la inversión.

Gráfico: no tiene; se cuenta con las ecuaciones.

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.17 | Regulación del monopolio natural con información asimétrica | desarrollo en el anexo A (hecho, 17/10/2026); pasará a mención, con el anexo A resumido y `\vertema{3.A.20}`, cuando se revise el 3.A.20 (P21-02) | Todo lo anterior | — |
| 3.A.20 | Regulación óptima | previsto; referencia cuando se revise (P21-02) | La misma presentación y notación | — |
| 3.A.12 | Medición de la eficiencia (IV.3) | mención (hecho, 14/10/2026) | Shleifer (1985) como uso de las fronteras de eficiencia; caso alemán; remite a 3.A.17 y 3.A.20 (hecho, 14/10/2026) | El mecanismo |
| 4.B.15 | Empresa pública | resumen (hoy mención; D091, D139 (13/10/2026)) | Precio fijado por el coste medio de las demás empresas comparables: alternativa a la propiedad pública | El desarrollo |

## Divergencias encontradas en el temario actual
- 3.A.17 original: «Schleifer», ejemplo de generación eléctrica (es para redes de distribución) y sin modelo. **Resuelto** (17/10/2026): Shleifer (1985), redes, modelo y DEA/SFA. Ya lo desarrolla un tema: la divergencia «hoy nadie lo desarrolla» queda cerrada.

Autor: Víctor Gutiérrez Marcos
