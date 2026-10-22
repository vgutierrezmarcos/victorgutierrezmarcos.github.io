# Teoría del second best (Meade, 1955; Lipsey y Lancaster, 1956)

- **Área:** equilibrio general y bienestar · **Tema de referencia:** **3.A.22** (Bienestar I: «second-best» en el título; revisado el 21/10/2026, bloque III, «La teoría del *second best*»: III.1 idea y resultado general con a)-c), III.2 aplicaciones, III.3 *second best* con información privada y diseño de mecanismos, III.4 valoración; anexo `anexo:second-best-analitico`).
- **Temas que lo usan:** 3.A.22 (desarrollo; hecho, 21/10/2026), 4.B.9 (mención) y 4.B.11 (resumen; hoy mención; D139); 3.B.10 (mención: uniones aduaneras, Viner), 3.B.8 (mención: industria naciente, corregir en el origen; remite ya al 3.A.22), 3.B.28 (mención: instituciones de segundo óptimo de Rodrik; hoy sin remisión), 3.A.17 (mención; hecho, 17/10/2026: regulación del monopolio natural), 3.A.13 (mención; hecho, 19/10/2026: «óptimo restringido» de la teoría de los contratos, que **no** es el de Lipsey-Lancaster), 3.A.18 (mención; hecho, 19/10/2026: la variedad óptima como segundo óptimo cuando el planificador no puede subvencionar; el equilibrio de Dixit-Stiglitz coincide con el **óptimo restringido**), 3.A.15 (mención; hecho, 20/10/2026: el precio igual al coste medio del monopolio natural impugnable, segundo óptimo con presupuesto equilibrado), 3.A.23 (mención; hecho, 21/10/2026: impuesto pigouviano con poder de mercado, Buchanan, 1969, y la conclusión de las soluciones a los fallos del sector público); 3.A.20 (mención; hecho, 22/10/2026: primer, segundos y terceros óptimos con la nota del óptimo restringido, `\vertema{3.A.13}` `\vertema{3.A.22}`; monopolio contaminante, Buchanan, 1969, en la valoración de I.3).
- **Manuales de referencia:** Lipsey y Lancaster (1956), *REStud*; Meade (1955); Davis y Whinston (1965); Diamond y Mirrlees (1971); Bhagwati y Ramaswami (1963); Gandolfo (2014), *International Trade Theory and Policy* (la montaña); Mas-Colell, Whinston y Green, cap. 22 (segundo óptimo en impuestos) y 23 (mecanismos); Hart (1975); Greenwald y Stiglitz (1986).

## Presentación de referencia

**Pregunta:** si una condición de Pareto no puede cumplirse, ¿conviene cumplir las demás? Respuesta: no necesariamente. Vocabulario: **primer óptimo** (*first best*), **segundo óptimo** (*second best*), en castellano la primera vez; *second best* sin guion en el texto.

**Supuestos (notación canónica, `notacion.md` § 5):** $n$ bienes, bienestar de un consumidor representativo $U(\vec x)$ y tecnología $T(\vec x)=0$; primer óptimo $U_k/U_n=T_k/T_n$ para todo $k$. Una **restricción no trivial** impide la condición del bien 1:
$$\frac{U_1}{U_n}=\psi\,\frac{T_1}{T_n},\qquad \psi\neq1\quad(\text{con un impuesto }ad\ valorem\ t\text{ sobre el bien 1, }\psi=1+t).$$
Origen de la distorsión: institucional (impuestos, aranceles, regulación), tecnológico (costes fijos del monopolio natural), de mercado (poder de mercado, externalidad que no se corrige) o informativo.

**Resultado general:** con multiplicadores $\lambda_1$ (tecnología) y $\lambda_2$ (restricción) y $\Psi_k$ la derivada de $U_1/U_n-\psi T_1/T_n$ respecto de $x_k$,
$$\frac{U_k}{U_n}=\frac{T_k+\frac{\lambda_2}{\lambda_1}\Psi_k}{T_n+\frac{\lambda_2}{\lambda_1}\Psi_n},$$
con $\Psi_k$ dependiente de derivadas cruzadas de signo desconocido: las demás condiciones de Pareto ya no son deseables en general. Implicaciones: contar condiciones no informa; quitar una distorsión puede bajar el bienestar; añadir una puede subirlo; la política por partes no tiene garantía general.

**Extensiones:** separabilidad ($\Psi_k=\Psi_n=0$, Davis y Whinston, 1965); eficiencia en la producción con impuestos óptimos (Diamond y Mirrlees, 1971); corregir la distorsión en su origen (Bhagwati y Ramaswami, 1963).

**Aplicaciones (III.2 del 3.A.22):** uniones aduaneras (Viner, Lipsey); **monopolio contaminante**, $t^*=\mathrm{CMgE}(q^*)-p(q^*)/\lvert\varepsilon_{q,p}\rvert$ (Buchanan, 1969; Barnett, 1980); industria naciente; instituciones de Rodrik (2008) y la liberalización de capitales y la crisis asiática de 1997; Corlett-Hague, Ramsey-Boiteux, monopolio natural impugnable y variedad óptima.

**Con información privada (III.3):** **eficiencia restringida** (Hart, 1975; Greenwald y Stiglitz, 1986) y **diseño de mecanismos** con tipos $t_i$, $\mathrm{IC}_i$, $\mathrm{PC}_i$ (ficha `diseno-mecanismos`): VCG en estrategias dominantes (presupuesto no equilibrado, Green y Laffont, 1977), d'Aspremont-Gérard-Varet en bayesiano, Myerson-Satterthwaite; tabla `tab:mecanismos`.

**Tres usos de *second best* en el temario, que no se contradicen** (3.A.13, 19/10/2026): (1) el **segundo óptimo** de Lipsey-Lancaster (3.A.22, referencia); (2) los **segundos óptimos** de la regulación del monopolio natural del 3.A.17 (p = CMe, tarifa en dos partes, punta y valle, Ramsey-Boiteux), con los **terceros óptimos** para la regulación con información asimétrica; (3) el **óptimo restringido** de la teoría de los contratos (3.A.13). Los «terceros óptimos» del 3.A.17 son, en el lenguaje del 3.A.13, óptimos restringidos por la información. **El 3.A.22 nombra los 3** (III.1 y III.3) con sus equivalencias: el óptimo restringido es «un óptimo con una restricción añadida, como el segundo óptimo, pero la restricción son los incentivos, no una distorsión dada».

**Gráficos de referencia:**
- **El segundo óptimo en la GFPU** (gráfico central): la restricción, una recta, deja fuera de alcance la zona por encima de ella; **F** punto de felicidad (primer óptimo, tangencia con $W_3$), **P** donde la restricción corta la GFPU (mejor punto de la frontera alcanzable, en $W_1$) y **Q** tangencia de la restricción con $W_2>W_1$, dentro de la GFPU y mejor: el segundo óptimo. Ruta: `oposicion/temario/fuentes/3A22/graficos/second-best-gfpu.tex`.
- **La analogía de la montaña** (Gandolfo, 2014; no de Meade): cumbre $V$, obstáculo $D$, el segundo punto más alto $A$ mejor que seguir hacia la cumbre ($B$). Ruta: `oposicion/temario/fuentes/3A22/graficos/montana-second-best.tex`.

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.22 | Óptimo y second best | desarrollo (hecho, 21/10/2026) | III.1 con a)-c), $\psi$, $\lambda_1$, $\lambda_2$, $\Psi_k$, F-P-Q y la montaña; III.2 aplicaciones; III.3 eficiencia restringida y mecanismos (`tab:mecanismos`); III.4 valoración con la frase de Joan Robinson; derivación en el anexo | — |
| 3.A.23 | Fallos de mercado y del sector público | mención (hecho, 21/10/2026) | El impuesto pigouviano con poder de mercado es menor que el daño marginal (Buchanan, 1969): caso de *second best*; en las soluciones a los fallos del sector público, acercarse a las demás condiciones no garantiza mejorar | El teorema |
| 4.B.9 | Exceso de gravamen | mención | Un impuesto nuevo puede reducir el exceso de gravamen total si hay distorsiones previas | El teorema general |
| 4.B.11 | Imposición óptima | resumen (hoy mención; D139) | Enunciado de Lipsey-Lancaster; Ramsey, Corlett-Hague y Diamond-Mirrlees como problemas de segundo óptimo | El teorema general |
| 3.B.10 | Integración económica | mención | Creación y desviación de comercio como second best | — |
| 3.B.8 | Política comercial (industria naciente) | mención | Corregir en el origen (Bhagwati-Ramaswami): el arancel es solo un segundo óptimo frente a la subvención a la industria o al crédito; `\vertema{3.A.22}` | El teorema |
| 3.B.28 | Instituciones y desarrollo | mención | Instituciones de segundo óptimo (Rodrik, 2008); `\vertema{3.A.22}` | El teorema |
| 3.A.13 | Información asimétrica | mención (hecho, 19/10/2026) | **Óptimo restringido** (PC e IC); no es el segundo óptimo de Lipsey-Lancaster, aunque comparte la idea de un óptimo con una restricción añadida (`\vertema{3.A.22}`) | El teorema |
| 3.A.17 | Regulación del monopolio natural | mención (hecho, 17/10/2026) | «Primer óptimo», «segundos óptimos» (p = CMe, tarifa en dos partes, punta y valle, Ramsey-Boiteux) y «terceros óptimos» (información asimétrica), nunca «óptimos de primer/segundo orden» | El teorema |
| 3.A.18 | Variedad óptima | mención (hecho, 19/10/2026) | «Óptimo restringido» (sin subvenciones) frente al primer óptimo; remite a 3.A.22 | El teorema de Lipsey-Lancaster |
| 3.A.15 | Impugnables | mención (hecho, 20/10/2026) | p = CMe del monopolio natural impugnable como segundo óptimo con presupuesto equilibrado, `\vertema{3.A.17} \vertema{3.A.22}` | El teorema |
| 3.A.20 | Regulación óptima | mención (hecho, 22/10/2026) | Terminología de los óptimos (nota redactada de nuevo); Lipsey-Lancaster y el monopolio contaminante (cumple la promesa del 3.A.22, l. 718) | La teoría general |

## Divergencias encontradas en el temario actual
- Resueltas en el 3.A.22 (21/10/2026): puntos A, B, C del gráfico del *second best* en el espacio $(U_A,U_B)$, donde A y B son los consumidores (→ F, P, Q); $1+t$, $\lambda$, $\lambda_D$, $Q_k$ del anexo (→ $\psi$, $\lambda_1$, $\lambda_2$, $\Psi_k$; $k$ es el grado de homogeneidad); la montaña «propuesta por Meade» (→ Gandolfo); excepción solo con utilidad aditiva y tecnologías lineales (→ basta la separabilidad).
- 3.B.28 (sin revisar): invoca a Rodrik y el *second best* sin remitir al 3.A.22.
- Falta la remisión al 3.A.22 en los temas de 4.B (4.B.9, 4.B.11).
