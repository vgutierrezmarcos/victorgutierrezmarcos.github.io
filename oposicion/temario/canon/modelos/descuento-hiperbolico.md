# Descuento cuasihiperbólico e inconsistencia temporal (Strotz, 1955; Thaler, 1981; Laibson, 1997)

- **Área:** pensamiento (economía conductual) · **Tema de referencia:** **3.A.1** (sin revisar: «economía conductual» está en su título) — desarrollo del modelo β-δ y de las cuentas mentales. Ficha creada en la fase canon del 3.A.33 (K23, DC7/A33-07, **[decidir]**), que la usa en mención; gráfico de referencia y año de Strotz fijados en la del 3.A.29 (CC3, 3/11/2026).
- **Temas que lo usan:** 3.A.1 (desarrollo previsto), 3.A.29 (resumen; hecho, 1/11/2026: II.2 b), consistencia temporal, con el gráfico `descuento`; el exponencial es el único consistente, Strotz, 1955; evidencia de Thaler, 1981; hiperbólico generalizado de Loewenstein y Prelec, 1992; cuasihiperbólico de Laibson, 1997, en nota con el aviso de letras; Kydland y Prescott, 1977, para la política, `\vertema{3.A.36}`; remite al 3.A.1), 3.A.33 (mención; hecho, 31/10/2026: II.3 `sec:heterogeneidad`, de palabra en el cuerpo y la fórmula en nota con el aviso de letras; remite al 3.A.1), 3.B.23 (mención: hoy escribe «descuento parabólico» y remite el hiperbólico al 3.A.29), 3.A.43 (mención; hecho, 31/10/2026: solo en nota de los supuestos del RCK, Strotz, 1956, y el hiperbólico generalizado de Loewenstein y Prelec, 1992, no de Thaler; Laibson con `\vertema{3.A.1}` `\vertema{3.A.29}`), 3.B.28 (mención; hecho, 3/11/2026: fertilizantes de Duflo, Kremer y Robinson, 2011, sin fórmula).
- **Manuales de referencia:** Strotz (1955), *REStud*; Thaler (1981), *Economics Letters*; Laibson (1997), *QJE*; Frederick, Loewenstein y O'Donoghue (2002), *JEL*; Thaler (1985), *Marketing Science* (cuentas mentales).

## Presentación de referencia

Pregunta: ¿por qué los planes de ahorro no se cumplen? Idea: se descuenta mucho más entre hoy y mañana que entre 2 días del futuro lejano (Thaler, 1981): pacientes a largo plazo, impacientes a corto; las preferencias son **inconsistentes en el tiempo** (Strotz, 1955).
$$U_t=u(C_t)+\beta\sum_{s=1}^{\infty}\delta^s\,u(C_{t+s}),\qquad 0<\beta<1,\quad 0<\delta<1$$
entre hoy y mañana se descuenta con βδ y entre 2 periodos futuros con δ; con β = 1, el exponencial de Samuelson (1937). Implicaciones: infraahorro, demanda de compromisos (planes de pensiones ilíquidos); política: *nudges* (afiliación automática con libertad para salir).

**Gráfico de referencia:** `oposicion/temario/fuentes/3A29/graficos/descuento.tex` (3.A.29, `fig:descuento`, 1/11/2026; CC3): factor de descuento frente al horizonte $t$ en años, con 3 curvas y los parámetros de Angeletos *et al.* (2001): exponencial $0{,}939^t$, hiperbólica generalizada $(1+4t)^{-1/4}$ (Loewenstein y Prelec, 1992: $D(t)=(1+at)^{-\gamma/a}$, $a,\gamma>0$, locales) y cuasihiperbólica, 1 en $t=0$ y $0{,}7\cdot0{,}957^t$ después. El 3.A.1 lo reutiliza (copia) al desarrollar el modelo.

**Año de Strotz** (CC3, A29-03, **[decidir]**): **1955**, clave `Strotz1955Myopia` (Crossref; vol. 23 de la *Review of Economic Studies*, fechado en 1955-1956), como el 3.A.33, el 3.A.29 y esta ficha; el 3.A.43 usa `Strotz1956` (pendiente de coherencia). Alternativa: 1956 en todos (cambiar el 3.A.33, el 3.A.29 y la ficha).

**Notación (D105):** β-δ es el nombre del modelo y se mantiene como **excepción avisada**: aquí δ es el factor exponencial y β el sesgo por el presente; en el resto del canon β ≡ 1/(1+ρ) y δ es la depreciación. Donde conviven (3.A.33: Fisher y duraderos), la fórmula va **solo en una nota** con el aviso.

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.1 | Economía conductual | desarrollo previsto | Thaler, Strotz y Laibson con la fórmula; cuentas mentales; *nudges* | — |
| 3.A.29 | Modelización dinámica | resumen (hecho, 1/11/2026) | Consistencia temporal en II.2 b): exponencial con preferencias recursivas = principio de optimalidad (Strotz, 1955); Thaler (1981); hiperbólico generalizado y cuasihiperbólico en nota con el aviso (D105); gráfico `descuento` de apoyo; infraahorro y compromisos; inconsistencia de la política (Kydland y Prescott, 1977); remite al 3.A.1 | Las aplicaciones al consumo (3.A.33) y la teoría conductual (3.A.1) |
| 3.A.33 | Teorías del consumo | mención (hecho, 31/10/2026) | De palabra en II.3 y la fórmula en nota con el aviso de letras (D105, DC7) | La teoría |
| 3.B.23 | Renta variable | mención | El descuento de los dividendos es exponencial; el hiperbólico, en el 3.A.1 | — |
| 3.A.43 | RCK | mención en nota (hecho, 31/10/2026) | El exponencial es el único consistente (Strotz); el hiperbólico lleva a inconsistencia temporal; cita `Strotz1956` (pendiente: `Strotz1955Myopia`) | La fórmula β-δ |
| 3.B.28 | Evidencia experimental del desarrollo | mención (hecho, 3/11/2026) | Fertilizantes en el oeste de Kenia: sesgo al presente, sin fórmula; un pequeño descuento justo tras la cosecha aumenta el uso tanto como subvenciones mucho mayores (Duflo, Kremer y Robinson, 2011, `DufloKremerRobinson2011`); las políticas con el comportamiento (`\vertema{3.A.1}`) | La fórmula β-δ |

## Divergencias encontradas en el temario actual
- 3.A.33 original: «Thaler propone un factor de descuento hiperbólico» y «copiar del 3.A.12». **Resuelto** (31/10/2026): Strotz (1955), inconsistencia; Thaler (1981), evidencia; Laibson (1997), modelo.
- 3.B.23 (sin revisar): «descuento **parabólico**» → exponencial; remite el hiperbólico al 3.A.29 → 3.A.1.
- 3.A.1 (sin revisar): su Word remite al 3.A.29 el descuento hiperbólico y las preferencias inconsistentes (l. 944 y 968 de la conversión): al revés, el 3.A.1 es el tema de referencia y el 3.A.29 le remite (lo hace en II.2 b) y en la conclusión).
- 3.A.29 original: comentario «meter función de descuento hiperbólica» y fuentes de stringfixer.com y Wikipedia; Strotz con una frase en inglés entre comillas (paráfrasis de manual). **Resuelto** (1/11/2026): fuentes académicas, paráfrasis en castellano con `Strotz1955Myopia`.
- **Año de Strotz**: 1955 (3.A.33, 3.A.29, ficha) frente a 1956 (3.A.43): `pendientes-coherencia.md`, «Pendiente del 3.A.29».

Autor: Víctor Gutiérrez Marcos
