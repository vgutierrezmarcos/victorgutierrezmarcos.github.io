# Subsidio estratégico a la exportación en un tercer mercado (Brander y Spencer, 1985)

- **Área:** comercio · **Tema de referencia:** 3.B.8 (Política comercial estratégica) — único desarrollo.
- **Temas que lo usan:** 3.B.8 (desarrollo; hecho, 5/11/2026: II.1 `sec:brander-spencer`, `sec:eaton-grossman`, `sec:airbus-boeing`), 3.B.6 (mención; hecho, 5/11/2026: extensiones del dumping recíproco y Bertrand), 3.B.33 (mención; hecho, 14/11/2026: Acuerdo SMC y DS316/DS353), 3.B.39 (mención; hecho, 19/11/2026: III.2.4, carrera de subvenciones entre Estados de la UE, Collie, 2000), 3.B.41 (mención), 4.A.24 (mención) 3.A.14 (mención; hecho, 19/10/2026: la política comercial estratégica como aplicación, III.1, con `\vertema{3.B.8}`), 3.A.19 (mención; hecho, 20/10/2026: relevancia y conclusión, con `\vertema{3.B.8}`; Cournot y Stackelberg tienen allí su referencia, fichas `cournot` y `stackelberg`).
- **Manuales de referencia:** Brander y Spencer (1985, *JIE*); Eaton y Grossman (1986, *QJE*); Krugman, Obstfeld y Melitz, cap. 12 (Airbus-Boeing); Feenstra, cap. 7; Helpman y Krugman (1989).
- **Decisión D016 (13/10/2026):** ¿Se reserva φ para la productividad de Melitz (y la inversa de Frisch en macro) y se cambian sus otros usos en comercio y macro abierta? Sí: función de reacción R_A(q_B), coeficiente técnico de la protección efectiva a_ij, sensibilidad del saldo comercial al tipo real ν

## Presentación de referencia
**Pregunta:** ¿puede un gobierno aumentar el bienestar nacional subvencionando a su exportadora en un oligopolio internacional?

**Supuestos:** una empresa nacional y una extranjera venden solo en un tercer mercado; Cournot; el gobierno mueve primero (compromiso creíble); sin consumo nacional del bien.

**Ecuaciones (notación canónica):**
$$\max_{q_A}\ B_A = p(q_A + q_B)\,q_A - C_A(q_A) + s_A q_A \;\Rightarrow\; \mathrm{IMg}_A - \mathrm{CMg}_A + s_A = 0$$
(función clave del 3.B.8, `eq:reaccion-subvencion`, con $R_A(q_B;s_A)$ y $W_A(s_A)=B_A-s_Aq_A$). **Resultados lineales** (anexo `anexo:lineal` del 3.B.8): $s_A^*=(a-c)/4$ (`eq:subvencion-optima`), con el que la empresa nacional produce la cantidad de líder de Stackelberg $(a-c)/2b$; subvenciones de Nash $(a-c)/5$ para cada país y dilema del prisionero entre gobiernos. **Eaton y Grossman (1986)**: con Bertrand, lo óptimo es $s_A<0$, un impuesto a la exportación (misma letra, `eq:impuesto-optimo`). **Airbus-Boeing** con la matriz de Krugman, Obstfeld y Melitz (2018, cap. 12) (`tab:airbus-boeing`). Evidencia: Baldwin y Krugman (1988), Dixit (1988), Irwin y Pavcnik (2004). Alias (CP6): `eaton-grossman` y `airbus-boeing` → esta ficha.
El subsidio desplaza $R_A(q_B)$ hacia fuera y lleva al equilibrio de Stackelberg con la empresa nacional como líder; bienestar nacional $W_A = \pi_A - s_A q_A$.

**Resultado:** subsidio óptimo positivo con Cournot; con Bertrand (Eaton-Grossman, 1986) lo óptimo es un impuesto; con represalias, dilema del prisionero entre gobiernos.

**Gráficos de referencia:** `oposicion/temario/fuentes/3B08/graficos/brander-spencer.tex` (desplazamiento de $R_A$ con la subvención hasta el punto de Stackelberg) y `eaton-grossman.tex` (Bertrand: impuesto a la exportación); `represalias-oligopolio.tex` para la carrera de subvenciones.

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.B.8 | Política comercial estratégica | desarrollo (hecho, 5/11/2026) | Cournot con $s_A^*=(a-c)/4$, Stackelberg, Nash $(a-c)/5$; Bertrand (Eaton-Grossman) con $s_A<0$; Airbus-Boeing; críticas (información, entrada, represalias); Grossman-Helpman en las extensiones con `\vertema{3.B.9}` | — |
| 3.B.41 | Política comercial común | mención | Excepción al librecambio y su poca solidez | — |
| 4.A.24 | Apoyo a la internacionalización | mención | Fallo de mercado que no justifica, por sí solo, la intervención | — |
| 3.A.19 | Oligopolio (referencia de Cournot y Stackelberg) | mención (hecho, 20/10/2026) | La política comercial estratégica como aplicación de Cournot y Stackelberg en la relevancia y en la conclusión, con `\vertema{3.B.8}`; fichas `cournot` y `stackelberg` | El modelo |
| 3.A.14 | Aplicaciones de la teoría de juegos | mención (hecho, 19/10/2026) | Una línea en las aplicaciones al comercio internacional, junto a la guerra arancelaria de Johnson (1953) como dilema del prisionero | El modelo |
| 3.B.6, 3.B.33, 3.B.39 | Nueva teoría; OMC; competencia en la UE | mención (hechos) | 3.B.6: extensión del dumping recíproco; 3.B.33: Acuerdo SMC y Airbus-Boeing en la OMC; 3.B.39: carrera de subvenciones entre Estados (ayudas de Estado; Collie, 2000) | El modelo |

## Divergencias encontradas en el temario actual
- El nombre de la ficha en el mapa («Brander-Krugman (1983) y Brander-Spencer (1985)») y 3.B.8 («en el marco del modelo de Brander y Krugman (1983)») atribuyen el duopolio Cournot de tercer mercado a Brander-Krugman: es un Cournot estándar; Brander-Krugman (1983) es el dumping recíproco. Renombrar a «Brander y Spencer (1985)».
- Función de reacción $\varphi_A(q_B)$: canon $R_A(q_B)$; $\varphi$ queda para la productividad de Melitz.
- **Resuelto** (5/11/2026): el 3.B.8 revisado atribuye bien (Brander y Spencer, 1985, tercer mercado; Brander y Krugman, 1983, dumping recíproco), usa $R_A(q_B)$, $B$, $p$ e $\mathrm{IMg}$.

Autor: Víctor Gutiérrez Marcos
