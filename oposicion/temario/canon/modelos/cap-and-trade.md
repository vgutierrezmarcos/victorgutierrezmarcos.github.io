# Mercado de derechos de emisión (cap and trade)

- **Área:** equilibrio general y bienestar · **Tema de referencia:** **3.A.23** (Bienestar II: externalidades; revisado el 21/10/2026, II.1.3 «Mercados de derechos de emisión (*cap and trade*)», apartado propio con a)-e) y el RCDE UE como evidencia, con datos de octubre de 2026) para la teoría; la aplicación europea (RCDE UE, MSR, RCDE 2, MAFC) es de 4.A.6 y 3.B.37.
- **Temas que lo usan:** 3.A.23 (desarrollo; hecho, 21/10/2026), 4.A.6 (resumen: RCDE UE, MSR, RCDE 2 y MAFC), 3.B.37 (mención: ingresos del RCDE como recurso propio), 3.B.31 (resumen; hecho, 31/10/2026: III.1, impuesto y tope sobre el gráfico de las emisiones óptimas, Weitzman aplicado al clima y la tabla `tab:instrumentos-clima` con las columnas de `tab:instrumentos` del 3.A.23; III.4, el RCDE con los mismos datos y claves que el 3.A.23 y el gráfico de su precio `fig:precio-rcde`; decisión P23/D2 del 3.B.31, de mención a resumen).
- **Manuales de referencia:** Dales (1968); Montgomery (1972); Weitzman (1974) («Prices vs. Quantities»); Roberts y Spence (1976) (híbridos); Baumol y Oates (1988); Perman *et al.*, *Natural Resource and Environmental Economics*.

## Presentación de referencia
**Pregunta:** ¿cómo alcanzar un nivel de emisiones dado al menor coste sin que el Estado conozca los costes de cada empresa?

**Idea (Dales, 1968):** el sector público fija el total de emisiones permitidas $\overline E$ (*cap*), lo reparte en derechos (gratis o en subasta) y deja que las empresas los compren y vendan (*trade*) a un precio $p_E$. Es la idea de Coase (crear derechos y dejar que se intercambien) en un mercado creado por el Estado; no es «el sistema de Coase».

**Modelo:** cada empresa $j$ reduce sus emisiones en $r_j$ con coste $C_j(r_j)$ creciente y convexo, y reduce hasta que su **coste marginal de reducción** iguala el precio del derecho (`eq:cap-and-trade`):
$$\mathrm{CMgR}_1(r_1)=\mathrm{CMgR}_2(r_2)=p_E,$$
la misma condición que minimiza el coste de la reducción total: se reduce donde es más barato. Montgomery (1972): el mercado alcanza ese mínimo **cualquiera que sea el reparto inicial**, que solo cambia quién paga a quién.

**Extensiones:** frente al impuesto pigouviano (precio fijo, cantidad incierta), fija la cantidad y deja incierto el precio; con incertidumbre sobre los costes, **Weitzman (1974)**: mejor la cantidad si el daño marginal es más inclinado que el coste marginal de reducción; híbridos con precio mínimo y máximo (Roberts y Spence, 1976).

**Evidencia (RCDE UE):** Directiva 2003/87/CE, desde 2005 en fases (la 4.ª, 2021-2030); tope que baja un 4,3 % anual en 2024-2027 y un 4,4 % desde 2028; emisiones de los sectores cubiertos a la mitad desde 2005; reserva de estabilidad del mercado desde 2019; RCDE 2 desde 2028 (edificios y transporte por carretera, aguas arriba); MAFC desde el 1/1/2026 contra la fuga de carbono (ficha `cbam`).

**Valoración:** alcanza el objetivo al menor coste y con certeza sobre la cantidad; precio volátil, rentas del reparto gratuito y fuga de carbono si cubre solo una parte del mundo.

**Gráfico de referencia:** costes marginales de reducción de 2 empresas ($\mathrm{CMgR}_1$, $\mathrm{CMgR}_2$) y el precio del derecho $p_E$ que los iguala. Ruta: `oposicion/temario/fuentes/3A23/graficos/cap-and-trade.tex` (apoyo; no se escribe en la pizarra).

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.23 | Instrumentos frente a externalidades | desarrollo (hecho, 21/10/2026) | Dales, `eq:cap-and-trade`, Montgomery, Weitzman e híbridos; el RCDE como evidencia (más Dales y Montgomery que Coase); fila en la tabla de los 5 mecanismos | — |
| 4.A.6 | Política climática | resumen | RCDE UE (fases, tope, MSR, RCDE 2), MAFC, con datos actualizados; `\vertema{3.A.23}` para la teoría | La derivación |
| 3.B.37 | Recursos propios | mención | Ingresos del RCDE (y del MAFC) como nuevo recurso propio | — |
| 3.B.31 | Cambio climático | resumen (hecho, 31/10/2026) | Impuesto $t^*$ frente a tope $\overline E=E^*$ sobre el gráfico de las emisiones óptimas (`fig:emisiones-optimas`), $\mathrm{CMgR}_j=p_E$; Weitzman aplicado al clima: el daño marginal de un flujo anual es casi plano (depende del stock), lo que favorece el precio (Pizer, 2002), y en contra pesan los puntos de inflexión y el presupuesto de carbono; credibilidad (Helm, Hepburn y Mash, 2003); RCDE en III.4 con los mismos datos y claves que el 3.A.23 (≈ 85 €/t en octubre de 2026, `EEX2026Subastas`; tope −4,3 %/−4,4 %, `CE2025TopeETS`; emisiones a la mitad desde 2005 y −62 % en 2030, `CE2026EmisionesETS2025`; RCDE 2 en 2028 y objetivo de 2040, `UE2026Reglamento667`), evidencia de Colmer *et al.* (2025) y gráfico de su precio; fuga de carbono y MAFC (ficha `cbam`) | La derivación de Montgomery y el gráfico de las 2 empresas |

## Divergencias encontradas en el temario actual
- El id agrupa la teoría (3.A.23) y el RCDE UE (3.B.37, id original `rcde-ue`): mantener juntos y remitir.
- **3.A.23 (original) y 3.B.37 (nota 35)** presentaban el RCDE como «aplicación (exitosa) del sistema de Coase» (en el 3.A.23, metido dentro de Coase con una imagen copiada): es el *cap and trade* de Dales (1968) y Montgomery (1972), inspirado en Coase. Resuelto en el 3.A.23 (21/10/2026; apartado propio con $\overline E$, $p_E$, $\mathrm{CMgR}_j$, en lugar de $P_0$, $R_0$); pendiente en el 3.B.37 (sin revisar), que además dice que el MAFC es «transitorio… 3 años hasta 2026» (el periodo transitorio acabó el 31/12/2025; ficha `cbam`).
