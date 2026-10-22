# Competencia por comparación (Shleifer, 1985) y mecanismo de Loeb-Magat (1979)

- **Área:** sector público · **Tema de referencia:** 3.A.20 (*yardstick* en III.1, `sec:yardstick`, con a)-e) y derivación en `anexo:yardstick`; Loeb-Magat en II.2, `sec:seleccion-adversa-regulacion`; **hecho, 22/10/2026**). Recoge el id `loeb-magat` (alias en `_inventario/alias.json`). Pasa del 3.A.17 al 3.A.20 por la P21-02 (Víctor, 21/10/2026; antes D091, 13/10/2026, lo había puesto en el 3.A.17); el 3.A.17 queda en mención, con su anexo A resumido (`pendientes-coherencia.md`, sección del 3.A.20).
- **Temas que lo usan:** 3.A.20 (desarrollo; hecho, 22/10/2026), 3.A.17 (hoy desarrollo en el anexo A, no se canta; pasa a mención con `--fase coherencia`), 3.A.12 (mención: la medición de la eficiencia con DEA y frontera estocástica como base de la regulación por comparación; hecho, 14/10/2026; remite a 3.A.17 y 3.A.20, basta el 3.A.20, opcional), 4.B.15 (resumen; hoy mención), 4.A.5/4.A.12 (aplicación prevista: distribución eléctrica, aeropuertos).
- **Manuales de referencia:** Shleifer (1985), «A theory of yardstick competition», *RAND Journal*; Loeb y Magat (1979), *Journal of Law and Economics*; Laffont y Martimort (2002); Laffont y Tirole (1993); Armstrong y Sappington (2007); Baldwin, Cave y Lodge (2012); Jamasb y Pollitt (2001); Joskow (2014).

## Presentación de referencia (3.A.20)

**Mecanismo de Loeb y Magat (1979)** (II.2, a)-c)): el regulador conoce la demanda p(q) y el valor bruto S(q) ≡ ∫₀^q p(x)dx, no el coste; transferencias sin coste social. La empresa fija el precio y recibe como subvención el excedente del consumidor que genera, S(q) − p(q)q; su beneficio pasa a ser S(q) − C(q) = ET(q) y elige p(q) = CMg(q) sin revelar el coste. Es un mecanismo de Groves (reclamante residual; \vertema{3.A.14}, ficha `clarke-groves`). Valoración: hay que conocer la demanda y la empresa se queda todo el excedente; se corrige subastando el derecho al esquema (\vertema{3.A.14}). Transición a Baron-Myerson: el problema no es la eficiencia, sino las rentas (ficha `laffont-tirole`). Sin gráfico.

**Competencia por comparación** (III.1, a)-e)):
- *a) Idea*: con varias empresas reguladas parecidas en zonas distintas (distribuidoras de electricidad o agua, hospitales), el precio de cada una se fija con los costes de las **demás**: competencia entre monopolios locales y revelación de costes. Pegatina del 3.A.20: «Las comparaciones son odiosas».
- *b) Modelo*: N empresas idénticas, coste unitario c_i que se reduce invirtiendo R(c_i), R′ < 0, demanda q(p);
$$p_i=\bar c_{-i}\equiv\frac{1}{N-1}\sum_{j\neq i}c_j,\qquad T_i=\bar R_{-i}\equiv\frac{1}{N-1}\sum_{j\neq i}R(c_j)\qquad(\texttt{eq:yardstick})$$
  la empresa maximiza (c̄_{−i} − c_i)q(c̄_{−i}) + T_i − R(c_i) ⇒ −R′(c_i) = q(c̄_{−i}); en el equilibrio simétrico (de Nash, \vertema{3.A.14}), coste eficiente, p = c* y sin rentas (anexo). Implicaciones: no gana inflando costes; incentivos de precio fijo sin las rentas de un *price cap* mal calibrado: **b = 1 sin rentas** en la escala de la potencia. Ejemplo de *Redes del Valle* con 2 vecinas: costes 20, 22, 24 → precios 23, 22, 21.
- *c) Extensiones*: empresas heterogéneas (regresión o fronteras); perturbaciones comunes que la comparación filtra.
- *d) Evidencia*: DEA y SFA (\vertema{3.A.12}, ficha `eficiencia-frontera`); Alemania: ingresos máximos de las distribuidoras eléctricas con los 2 métodos, el valor más favorable y un mínimo del 60 % (BNetzA; ARegV); Jamasb y Pollitt (2001); en España, la comparación con costes de referencia de la Circular 8/2025 de la CNMC.
- *e) Valoración*: empresas comparables (o corregir las diferencias observables); colusión para no reducir costes (Baldwin, Cave y Lodge, 2012; \vertema{3.A.19}, ficha `cartel`).

**Gráfico:** no tiene; se cuenta con las ecuaciones y el ejemplo de las 3 distribuidoras escrito a mano; su lugar en `3A20/graficos/escala-potencia.tex`.

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.20 | ¿Y si hay varias empresas reguladas parecidas? (III.1); ¿se puede regular sin conocer el coste? (Loeb-Magat, II.2) | desarrollo (hecho, 22/10/2026; III.1, 2′) | Todo lo de arriba | — |
| 3.A.17 | Regulación del monopolio natural con información asimétrica | hoy desarrollo en el anexo A (hecho, 17/10/2026); **pasa a mención** con `--fase coherencia` | 2 viñetas: Loeb-Magat (todo el EC, p = CMg, renta enorme) y competencia por comparación (Shleifer, 1985, con DEA o frontera estocástica, \vertema{3.A.12}); `\vertema{3.A.20}` | El modelo |
| 3.A.12 | Medición de la eficiencia (IV.3) | mención (hecho, 14/10/2026) | Shleifer (1985) como uso de las fronteras de eficiencia; caso alemán con las mismas palabras que el 3.A.20; remite a 3.A.17 y 3.A.20 (con la referencia en el 3.A.20 basta `\vertema{3.A.20}`, opcional) | El mecanismo |
| 4.B.15 | Empresa pública | resumen (hoy mención; D091, D139 (13/10/2026)) | Precio fijado por el coste medio de las demás empresas comparables: alternativa a la propiedad pública; remitir al 3.A.20 | El desarrollo |

## Divergencias encontradas en el temario actual
- 3.A.17 original: «Schleifer», ejemplo de generación eléctrica (es para redes de distribución) y sin modelo. **Resuelto** (17/10/2026): Shleifer (1985), redes, modelo y DEA/SFA.
- La ficha y el mapa tenían el 3.A.17 como referencia (D091) hasta la revisión del 3.A.20: **resuelto** (22/10/2026, P21-02).

Autor: Víctor Gutiérrez Marcos
