# Regulación de la tasa de rentabilidad y efecto Averch-Johnson (1962)

- **Área:** mercados-información-juegos · **Tema de referencia:** 3.A.20 (II.1, `sec:coste-servicio`, «Regulación de la tasa de rentabilidad: efecto Averch-Johnson», con a)-e); derivación en el anexo `anexo:aj`; **hecho, 22/10/2026**). Pasa del 3.A.17 al 3.A.20 por la P21-02 (Víctor, 21/10/2026): el título del 3.A.20 dice «desarrollos en presencia de información asimétrica» y es del 3.er ejercicio. El 3.A.17 queda en mención, con su anexo A resumido (`pendientes-coherencia.md`, sección del 3.A.20).
- **Temas que lo usan:** 3.A.20 (desarrollo; hecho, 22/10/2026), 3.A.17 (hoy desarrollo en el anexo A, no se canta; pasa a mención con `--fase coherencia` cuando Víctor apruebe el 3.A.20), 4.B.15 (resumen; hoy mención con ecuaciones); 4.A.5 y 4.A.12 (regulación sectorial) podrían citarlo.
- **Manuales de referencia:** Averch y Johnson (1962), *AER*; Baumol y Klevorick (1970), *Bell Journal*; Joskow (1974); Spann (1974) y Courville (1974) para la evidencia; Viscusi, Harrington y Vernon, *Economics of Regulation and Antitrust*, cap. 12; Train (1991).

## Presentación de referencia (3.A.20, II.1)

**Nombre:** «regulación por coste del servicio» o «de la **tasa de rentabilidad**» (nunca «tasa de beneficio» ni «de rendimiento»). Su atractivo es informativo: el regulador no conoce los costes eficientes, pero sí datos contables auditables (beneficio y capital).

**Pregunta:** ¿qué distorsión crea limitar la rentabilidad del capital del monopolista regulado? (tercer óptimo: el regulador no conoce los costes).

- **a) Idea**; **b) Modelo**:
  - *i) Supuestos*: monopolista con q = F(z_K, z_L), demanda inversa p(q), precios de los factores w_K (coste del capital) y w_L; tasa de rentabilidad permitida **s**, con w_K < s < rentabilidad sin regular (nota en el tema: s no es la cuota s_i de I.1).
  - *ii) Desarrollo*:
$$\max_{z_K,z_L}\ B=p(q)\,q-w_Kz_K-w_Lz_L\quad\text{s.a.}\quad q=F(z_K,z_L),\ \ \frac{p(q)\,q-w_Lz_L}{z_K}\le s$$
    La restricción equivale a B ≤ (s − w_K)z_K: el beneficio permitido crece con el capital. Gráficamente, en el plano (z_K, B), U invertida con máximo en z_K^* y recta (s − w_K)z_K; si z_K^* no está permitido, la empresa elige z_K′ > z_K^*. Con la restricción activa y su multiplicador 0 < μ < 1 (problema penalizado sin 𝓛, que es el índice de Lerner, `notacion.md` § 0):
$$\mathrm{RMST}_{LK}=\frac{\mathrm{PMg}_L}{\mathrm{PMg}_K}=\frac{w_L}{w_K-\frac{\mu}{1-\mu}(s-w_K)}>\frac{w_L}{w_K}\qquad(\texttt{eq:averch-johnson})$$
  - *iii) Implicaciones*: **efecto Averch-Johnson** (sobrecapitalización, como si el capital fuera más barato): ineficiencia productiva aunque el beneficio esté acotado; sin incentivos a abaratar (baja potencia: extremo b ≈ 0 de la escala de la potencia, ficha `laffont-tirole`). Ejemplo de *Redes del Valle*: con el 6,58 % sobre los activos, conviene cambiar un transformador antes que alargar su vida con mantenimiento.
- **c) Extensiones**: desfase regulatorio (tiempo **entre** revisiones: Baumol y Klevorick, 1970; Joskow, 1974); calidad.
- **d) Evidencia**: Spann (1974) y Courville (1974) confirman la sobrecapitalización; evidencia posterior mixta (Joskow, 1974). España: tasa de retribución financiera sobre la base de activos regulada (CNMC, Circular 2/2019): **6,58 %** en la electricidad para 2026-2031 (Circular 9/2025, desde el 5,58 % de 2020-2025) y **6,46 %** en el transporte y la regasificación de gas para 2027-2032 (Circular 5/2026); tarifas de la corriente de tracción de ADIF orientadas a costes, con supervisión de la CNMC.
- **e) Valoración**: ventajas (poca información, seguridad para invertir en activos hundidos); inconvenientes (sobrecapitalización; regula la remuneración contable, no el beneficio económico; sin incentivos salvo el desfase; incentivo a exagerar costes en cada revisión). Respuesta: incentivos y enfoque TOTEX de la CNMC (Circular 8/2025) para quitar el sesgo hacia el capital.
- **Derivación** (anexo `anexo:aj` del 3.A.20, con `\findemo`): I(z_K,z_L) = p(F)F, problema penalizado I − w_Kz_K − w_Lz_L − μ[I − w_Lz_L − sz_K]; I_L = w_L e I_K = w_K − [μ/(1−μ)](s − w_K); casos límite (μ = 0 si s no aprieta; s = w_K indeterminado).

**Gráfico de referencia:** `oposicion/temario/fuentes/3A20/graficos/averch-johnson.tex` (copia del `3A17/graficos/averch-johnson.tex`, mismas capas y rótulos; `fig:averch-johnson`). Se queda en la pizarra junto a la escala de la potencia (`3A20/graficos/escala-potencia.tex`).

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.20 | ¿Qué hace el regulador que no conoce los costes y regula lo que ve (capital y beneficio contable)? | desarrollo (hecho, 22/10/2026; se canta en II.1, 2′) | Todo lo de arriba: a)-e), gráfico, `eq:averch-johnson`, derivación en el anexo, CNMC y ADIF, su lugar en la escala de la potencia | — |
| 3.A.17 | Regulación del monopolio natural | hoy desarrollo en el anexo A (hecho, 17/10/2026); **pasa a mención** con `--fase coherencia` cuando Víctor apruebe el 3.A.20 | Una viñeta: limita el beneficio sobre el capital, s > w_K; sobrecapitaliza y no reduce costes; `\vertema{3.A.20}` (texto listo en `fuentes/3A20/_trabajo/propuestas-coherencia.md`, C8). Se quitan `fig:averch-johnson` y `anexo:aj` | Programa, gráfico y derivación |
| 4.B.15 | Empresa pública frente a regulación | resumen (hoy mención; D139 (13/10/2026)) | Sobrecapitalización como coste de la regulación por rentabilidad, con la condición `eq:averch-johnson` sin derivar | Programa y gráfico (remitir a 3.A.20) |

## Divergencias encontradas en el temario actual
- 3.A.17 original: r como coste del capital y como rentabilidad, a la vez. **Resuelto** (17/10/2026): w_K y s, derivación con μ.
- `mapa.yaml` llamaba al modelo «Regulación de la tasa de beneficio»; las fichas y los temas dicen «tasa de rentabilidad». **Resuelto** (22/10/2026, fase canon del 3.A.20).
- 4.B.15 (sin revisar): B = PF(K,L) − rK − wL con r coste del capital y s tasa permitida: en canon w_K (no r, reservado al tipo de interés), p minúscula y z_K, z_L; mantener s; remitir al 3.A.20 (no al «3.A.15» antiguo).
- Las tasas de la CNMC ya están comprobadas (6,58 % y 6,46 %, 3.A.20, 22/10/2026): la ficha anterior decía que no se publicaban hasta comprobarlas.

Autor: Víctor Gutiérrez Marcos
