# Regulación de la tasa de rentabilidad y efecto Averch-Johnson (1962)

- **Área:** mercados-información-juegos · **Tema de referencia:** 3.A.17 (anexo A, regulación del monopolio natural; revisado el 17/10/2026, A.3 y anexo `anexo:aj`) — con la formalización que traía el 4.B.15. **[decidir]** Propuesta del 3.A.17 (D1, provisional): pasar la referencia al 3.A.20 cuando se redacte y dejar el 3.A.17 en «mención» (ficha `laffont-tirole`).
- **Temas que lo usan:** 3.A.17 (desarrollo en el anexo A, no se canta; hecho, 17/10/2026), 4.B.15 (resumen; hoy mención con ecuaciones), 3.A.20 (previsto); 4.A.5 y 4.A.12 (regulación sectorial) podrían citarlo.
- **Manuales de referencia:** Averch y Johnson (1962), *AER*; Baumol y Klevorick (1970), *Bell Journal*; Viscusi, Harrington y Vernon, *Economics of Regulation and Antitrust*, cap. 12; Train (1991).

## Presentación de referencia (3.A.17, anexo A)
Pregunta: ¿qué distorsión crea limitar la rentabilidad del capital del monopolista regulado? (tercer óptimo: el regulador no conoce los costes)
$$\max_{z_K,z_L}\ B=p(q)\,q-w_Kz_K-w_Lz_L\quad\text{s.a.}\quad q=F(z_K,z_L),\ \ \frac{p(q)\,q-w_Lz_L}{z_K}\le s,\ \ s>w_K$$
La restricción equivale a B ≤ (s − w_K)z_K: el beneficio permitido crece con el capital.
- **Gráfico**: en el plano (z_K, B), beneficio sin restricción en U invertida con máximo en z_K^*; recta (s − w_K)z_K; si z_K^* no está permitido, la empresa elige z_K′ > z_K^*: **sobrecapitaliza**.
- **Efecto Averch-Johnson**, con la restricción activa y el multiplicador μ (0 < μ < 1; `notacion.md` § 1: problema penalizado sin 𝓛, que es el índice de Lerner):
$$\mathrm{RMST}_{LK}=\frac{\mathrm{PMg}_L}{\mathrm{PMg}_K}=\frac{w_L}{w_K-\frac{\mu}{1-\mu}(s-w_K)}>\frac{w_L}{w_K}$$
como si el capital fuera más barato de lo que es; costes y precios más altos. Derivación (anexo B): I(z_K,z_L) = p(F)F, problema penalizado I − w_Kz_K − w_Lz_L − μ[I − w_Lz_L − sz_K], I_L = w_L e I_K = w_K − [μ/(1−μ)](s − w_K).
- **Ventaja**: beneficio y capital son datos contables observables. **Inconvenientes**: sobrecapitalización; regula la remuneración contable, no el beneficio económico; sin incentivos a reducir costes (salvo el desfase regulatorio entre revisiones: Baumol y Klevorick, 1970; Joskow, 1974).
- **España**: retribución de las redes de electricidad y gas con una tasa de retribución financiera sobre la base de activos regulada (CNMC, Circular 2/2019; las tasas no se publican hasta comprobarlas); tarifas de la corriente de tracción de ADIF orientadas a costes, con supervisión de la CNMC (regulación por coste del servicio).

**Gráfico de referencia:** `oposicion/temario/fuentes/3A17/graficos/averch-johnson.tex`.

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.17 | Regulación del monopolio natural | desarrollo en el anexo A (hecho, 17/10/2026) | Programa, gráfico, efecto con μ, derivación en el anexo B, ventajas e inconvenientes, comparación con *price cap* | — |
| 3.A.20 | Regulación óptima | previsto; referencia si se aprueba D1 | La misma presentación y notación, reutilizando `averch-johnson.tex` | — |
| 4.B.15 | Empresa pública frente a regulación | resumen (hoy mención; D139 (13/10/2026)) | Sobrecapitalización como coste de la regulación por rentabilidad | Programa y gráfico (remitir a 3.A.17) |

## Divergencias encontradas en el temario actual
- 3.A.17 original: r como coste del capital y como rentabilidad, a la vez. **Resuelto** (17/10/2026): w_K y s, derivación con μ.
- 4.B.15 (sin revisar): B = PF(K,L) − rK − wL con r coste del capital y s tasa permitida: en canon w_K (no r, reservado al tipo de interés), p minúscula y z_K, z_L; mantener s.

Autor: Víctor Gutiérrez Marcos
