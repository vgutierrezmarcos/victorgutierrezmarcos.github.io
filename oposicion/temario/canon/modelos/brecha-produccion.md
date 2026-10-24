# Brecha de producción y PIB potencial (*output gap*)

- **Área:** macro-cerrada · **Tema de referencia:** doble, **3.A.42** (3.er ejercicio: medición del ciclo, tendencia y filtro de Hodrick-Prescott) y **4.B.4** (4.º ejercicio: PIB potencial por función de producción de la Comisión, NAWRU y saldo cíclico) — cada uno completo para su examen. Recoge el id `pib-potencial-ce` (alias).
- **Temas que lo usan:** 3.A.42 (desarrollo, previsto), 4.B.4 (desarrollo), 3.A.28 (mención: producto no aceleracionista asociado a la NAIRU), 3.A.36 (resumen: la brecha en la regla de Taylor), 3.A.7 y 3.A.37 (uso, en logaritmos: $x_t$), 4.B.21 y 4.A.29 (mención), 1D01 (uso: definición operativa, signo, variación y potencial implícito; II.2, anexos A y E)
- **Manuales de referencia:** Havik et al. (2014), *The Production Function Methodology for Calculating Potential Growth Rates and Output Gaps*, European Economy EP 535; Hodrick y Prescott (1997); Blanchard, *Macroeconomics*, caps. 9 y 22; FMI, glosario del *World Economic Outlook*; Galí (2015), cap. 3 (brecha frente al producto natural).
- **Decisión D-05 de la 1D01 (Víctor, 23/10/2026):** el PIB potencial es $Y^p$; $Y^*$ queda para el resto del mundo (§ 0).

## Presentación de referencia
**Pregunta:** ¿la economía produce por encima o por debajo de lo que puede producir sin tensiones inflacionistas?

**Definición (datos, en % del potencial):**
$$\mathrm{OG}_t\equiv\frac{Y_t-Y^p_t}{Y^p_t}\times100,\qquad \Delta\mathrm{OG}_t\approx\gamma_{Y,t}-\gamma_{Y^p,t}\ \text{(en puntos)},\qquad \gamma_{Y^p,t}\approx\gamma_{Y,t}-(\mathrm{OG}_t-\mathrm{OG}_{t-1}).$$
- **PIB potencial** ($Y^p$): el que se produce con los factores empleados con su intensidad normal y sin presiones sobre la inflación (producto no aceleracionista de la inflación, asociado a la NAIRU).
- **Dos métodos** (la diferencia útil es de método, no de institución): **función de producción** (trabajo potencial con la NAWRU, capital y PTF tendencial; Comisión, OCDE y FMI) y **filtros estadísticos** (Hodrick-Prescott: menos datos, pero el último tramo se revisa mucho).
- **Lectura:** negativa = recursos ociosos y presión a la baja sobre la inflación; positiva = sobrecalentamiento; su variación dice si la brecha «se cierra» o «se abre». Se revisa mucho en tiempo real: no conviene fechar el ciclo solo con ella.
- **En los modelos** log-linealizados (NEK, regla de Taylor) la brecha es $x_t\equiv y_t-y^n_t$ (§ 8), respecto al producto **natural** (el de precios flexibles), que no es exactamente el potencial de la Comisión; con datos, $\mathrm{OG}_t\approx100\,x_t$. En el saldo cíclico, $b^c_t=\varepsilon\cdot\mathrm{OG}_t$ (ficha `saldo-estructural`).

**Gráficos de referencia:** fases del ciclo con la brecha, `fuentes/1D01/graficos/fases-ciclo-brecha.tex`, y tendencia y brecha como distancia vertical, `fuentes/1D01/graficos/ciclo-tendencia.tex` (los dos de la guía; reutilizables en 3.A.42).

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.42 | Medición del ciclo | Desarrollo | Tendencia y ciclo, filtro HP (λ = 1600 trimestral), problemas de final de muestra; brecha como medida del ciclo | La función de producción de la Comisión (4.B.4) |
| 4.B.4 | Saldo cíclico y estructural | Desarrollo | Función de producción, NAWRU, PTF tendencial, revisiones; $b^c=\varepsilon\cdot\mathrm{OG}$ | El filtro en detalle (remitir a 3.A.42) |
| 3.A.36 | Diseño de la política monetaria | Resumen | La brecha en la regla de Taylor ($x_t$ o OG) | La estimación |
| 3.A.28 | NAIRU | Mención | Potencial = producto con paro en la NAIRU | — |
| 1D01 | Dictamen de coyuntura | Uso | Definición, signo, ΔOG, potencial implícito, cautelas; tabla de indicadores | Los métodos en detalle |

## Divergencias encontradas en el temario actual
- Ficha `saldo-estructural` (hasta el 24/10/2026) escribía $Y^*_t$ para el potencial: corregida a $Y^p_t$ (D-05).
- Original de la 1D01: «γ output gap = γ PIB observado − γ PIB potencial» (una diferencia en puntos llamada tasa de variación) y «OCDE: potencial / FMI: tendencial» (el FMI también usa el potencial): corregido en la guía revisada.
- 4.B.4 (Word, antiguo 4.B.5) remite el filtro HP a «[ver tema 3.A.41]»: es el **3.A.42** (numeración vigente).
- Notación: OG (datos, % del potencial) frente a $x_t$ (modelos, logaritmos): los dos son canon, cada uno en su contexto; decirlo cuando convivan (3.A.36, 4.B.4).

Autor: Víctor Gutiérrez Marcos
