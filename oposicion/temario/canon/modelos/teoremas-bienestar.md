# Teoremas fundamentales de la economía del bienestar (1TFEB y 2TFEB)

- **Área:** equilibrio general y bienestar · **Tema de referencia:** 3.A.22 (Bienestar I: los teoremas fundamentales en el título). Hoy 3.A.23 los desarrolla más (Word del título anterior a 2023): con el título vigente ese desarrollo pertenece a 3.A.22 y 3.A.23 debe solo recordarlos.
- **Temas que lo usan:** 3.A.22 (desarrollo; hoy resumen), 3.A.23 (resumen; hoy desarrollo), 3.A.21 (resumen; hecho, 14/10/2026: enunciados sobre la caja en II.2 y anexo C), 4.B.2, 4.B.3, 4.B.7 (resumen), 4.A.24 (mención); 3.A.13, 3.A.16 (versión de equilibrio parcial), 3.A.8 y 4.A.15 los citan.
- **Manuales de referencia:** Arrow (1951); Debreu (1959); Mas-Colell, Whinston y Green, cap. 16; Varian, cap. 17-18; Stiglitz (1991) sobre sus límites con información imperfecta.
- **Decisión D045 (13/10/2026):** ¿Cómo se escribe la dotación inicial del consumidor? ω_i (y ω′), como MWG

## Presentación de referencia
**1TFEB**: si las preferencias son localmente no saciables, todo equilibrio walrasiano es óptimo de Pareto (Arrow, 1951; Debreu, 1951). Supuestos (MWG cap. 16, **versión de equilibrio general**, como el anexo C del 3.A.21; no la de equilibrio parcial con «bien numerario»): mercados completos (sin externalidades ni bienes públicos), agentes precio-aceptantes (sin poder de mercado), información perfecta, precios comunes (sin cuñas impositivas). No necesita convexidad ni ninguna condición sobre los rendimientos: esas son para que el equilibrio exista.
**2TFEB**: con preferencias y tecnologías convexas (y continuas, localmente no saciables), toda asignación óptima de Pareto puede alcanzarse como equilibrio competitivo con las transferencias de suma fija adecuadas. Separación eficiencia-equidad.
Condiciones en el 2×2×2×2: $RMS^A_{XY}=RMS^B_{XY}=\frac{p_X}{p_Y}=\frac{CMg_X}{CMg_Y}=RMT_{XY}$ y $RMST^X_{LK}=RMST^Y_{LK}=\frac{w_L}{w_K}$.
Gráfico de referencia: caja de Edgeworth (de intercambio) con dotación $\vec\omega$, equilibrio $E$ en la curva de contrato $O_AO_B$ (1TFEB); para el 2TFEB, redistribución de suma fija $\vec\omega\to\vec\omega'$ sobre la recta de precios tangente en el óptimo deseado $E'$. Ruta: `oposicion/temario/fuentes/3A21/graficos/caja-intercambio-teoremas.tex` (capas 7-8 de la caja maestra `caja-intercambio.tex`); 3.A.22 debe reutilizarlo y añadir la FPU y la GFPU.

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.22 | Teoremas fundamentales | desarrollo (propuesto) | Enunciados, supuestos (MWG), demostración del 1TFEB, gráficos | — |
| 3.A.23 | Fallos de mercado | resumen | Qué supuesto del 1TFEB rompe cada fallo | Demostración y modelo 2×2×2×2 |
| 3.A.21 | Análisis normativo del EGC | resumen (hecho, 14/10/2026) | Pareto (ordinal, incompleto) y los 2 teoremas en enunciados sobre la caja (gráfico `caja-intercambio-teoremas`); Wicksell y Feldman en paráfrasis; ventajas, críticas e historia de Pareto y supuestos del 1TFEB en el anexo C; desde el 17/10/2026, nombres completos, origen (Lerner, Lange, Arrow, Debreu) y la demostración del 1TFEB (MWG §16.C) en el anexo C, porque Víctor quiere que el 3.A.21 se entienda sin haber estudiado 3.A.22 y 3.A.23 | Condiciones de Pareto con FPU/GFPU (3.A.22) |
| 4.B.2 | Incompletitud de Pareto | resumen | GFPU desde la FPP; necesidad de elegir | — |
| 4.B.3, 4.B.7 | Redistribución, principios impositivos | resumen | 2TFEB: redistribuir con suma fija; en la práctica, impuestos distorsionantes | — |
| 4.A.24 | Apoyo a la internacionalización | mención | Compensar a los perdedores de la apertura | — |

## Divergencias encontradas en el temario actual
- Dotación: $e$, $e'$ (3.A.22, 4.B.3, 4.B.7): canon $\vec\omega$, $\vec\omega'$ (Mas-Colell; vector con flecha, `notacion.md` § 0 y § 5, 3.A.21), para no chocar con $e$ (esfuerzo, 3.A.13) ni con $E$ (equilibrio, gasto).
- 3.A.23 usa $w,r$ y $C_X(w,X)$: canon $w_L,w_K$ y $C_X(w,X)$ con $w=(w_L,w_K)$.
- Lista de supuestos distinta en cada tema (Mas-Colell en 3.A.21-3.A.22; «seis supuestos» en 3.A.23): usar la de 3.A.22.
- 3.A.22, 3.A.23 y 3.A.24 (sin revisar) atribuyen el 2TFEB a 3.A.24 en sus anexos de relación de temas: con los títulos vigentes es de 3.A.22 (`corregir -> 3.A.22` en `mapa.yaml`).
- 3.A.21 original repetía el desarrollo entero (Pareto con cinco críticas, 1TFEB con los supuestos de equilibrio parcial de MWG y pidiendo rendimientos no crecientes): resuelto (14/10/2026), resumido con remisión a 3.A.22.
- `mapa.yaml` tenía los papeles de 3.A.22 y 3.A.23 al revés que esta ficha: corregido (14/10/2026) a «3.A.22: desarrollo (hoy resumen)» y «3.A.23: resumen (hoy desarrollo)».
