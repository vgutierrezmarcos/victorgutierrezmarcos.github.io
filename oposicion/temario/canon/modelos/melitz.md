# Heterogeneidad empresarial (Melitz, 2003)

- **Área:** comercio · **Tema de referencia:** 3.B.6 (… heterogeneidad empresarial) — lo tiene en el título.
- **Temas que lo usan:** 3.B.6 (desarrollo; hecho, 5/11/2026: I.3 `sec:melitz`), 3.A.18 (mención; hecho, 19/10/2026), 3.B.8 (mención: Melitz en la justificación de la promoción exterior, `\vertema{3.B.6}`), 3.B.10 (mención: solo conclusiones, selección y reasignación; Trefler, 2004, CUSFTA), 3.B.34 (mención; hecho, 18/11/2026: I.2, base de la ficha `modos-suministro-servicios`), 3.B.39, 3.B.41 (mención), 4.A.24, 4.A.25 (mención)
- **Manuales de referencia:** Melitz (2003), *Econometrica*; Helpman, Melitz y Yeaple (2004); Bernard, Jensen, Redding y Schott (2007, *JEP*); Melitz y Redding (2014, *Handbook of International Economics*); Feenstra, cap. 5.
- **Decisión D016 (13/10/2026):** ¿Se reserva φ para la productividad de Melitz (y la inversa de Frisch en macro) y se cambian sus otros usos en comercio y macro abierta? Sí: función de reacción R_A(q_B), coeficiente técnico de la protección efectiva a_ij, sensibilidad del saldo comercial al tipo real ν

## Presentación de referencia
**Pregunta:** ¿por qué solo exportan algunas empresas y qué efecto tiene la apertura sobre la productividad agregada?

**Supuestos:** Dixit-Stiglitz; las empresas extraen su productividad $\varphi$ de una distribución $G(\varphi)$ tras pagar un coste de entrada; coste fijo de producir $F^d$ y de exportar $F^x > F^d$; costes iceberg $\tau$.

**Ecuaciones (notación canónica):**
$$p(\varphi) = \frac{\sigma}{\sigma-1}\,\frac{w}{\varphi}, \qquad p_x(\varphi) = \tau\,p(\varphi), \qquad B^d(\varphi^*) = 0,\quad B^x(\varphi_x^*) = 0\ \Longrightarrow\ \varphi^*_x=\tau\Big(\frac{F^x}{F^d}\Big)^{\frac{1}{\sigma-1}}\varphi^*$$
(`eq:umbrales-melitz`, función clave del 3.B.6). Beneficios $B^d(\varphi)$ y $B^x(\varphi)$ (nunca π, D003); costes $C^d(q)=w(F^d+q/\varphi)$, $C^x(q_x)=w(F^x+\tau q_x/\varphi)$, coste de entrada $F^e$. **Umbral de autarquía** $\varphi^*_{\mathrm{aut}}$ (no $\varphi_A$, que choca con el país A): $\varphi^*_{\mathrm{aut}}<\varphi^*<\varphi^*_x$, y $B^d_{\mathrm{aut}}$. **Corte $\hat\varphi$** en que $B^d+B^x=B^d_{\mathrm{aut}}$ (Víctor, 10/11/2026): **5 grupos** de empresas: 1 no producen, 2 cierran, 3 solo venden en el interior y pierden, 4a exportan pero ganaban más en autarquía, 4b exportan y ganan. Vocabulario: «selección» y «reasignación» solo en Melitz; «efecto escala» y «racionalización» en Krugman (ficha `krugman-1979`).
**Resultado:** la apertura sube el umbral de supervivencia: salen las menos productivas, las más productivas exportan y crecen: reasignación y aumento de la productividad media.

**Gráficos de referencia:** `oposicion/temario/fuentes/3B06/graficos/melitz-umbrales.tex` (beneficios frente a $\varphi^{\sigma-1}$ con los 5 grupos; parámetros $wF^x=1{,}4$, pendiente de $B^d_{\mathrm{aut}}$ 0,55, 10/11/2026), con el paso previo `melitz-autarquia.tex` y `melitz-ganancias.tex` (beneficio en autarquía y con comercio).

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.B.6 | Nueva teoría del comercio | desarrollo (hecho, 5/11/2026) | Modelo, umbrales `eq:umbrales-melitz` con $\varphi^*_{\mathrm{aut}}$ y $\hat\varphi$, los 5 grupos, evidencia (Bernard y Jensen; concentración de la exportación española, `tab:concentracion-espana`); Eaton-Kortum y Arkolakis-Costinot-Rodríguez-Clare de palabra; equilibrio en `anexo:melitz`; implicaciones con las 4 preguntas | — |
| 3.B.34, 3.B.39, 3.B.41 | OMC, política comercial UE | mención | Ganancias de productividad por selección | — |
| 4.A.24, 4.A.25 | Internacionalización de la empresa española | mención | Empresas exportadoras más productivas; Helpman-Melitz-Yeaple para IED | Ecuaciones |
| 3.A.18 | Competencia monopolística | mención (hecho, 19/10/2026) | Extensión de Dixit-Stiglitz a empresas heterogéneas, en una línea con `\vertema{3.B.6}` | El modelo |
| 3.B.29 | Fuentes de la financiación exterior | mención (hecho, 12/11/2026) | IED frente a exportar: solo las más productivas pagan el coste fijo de producir fuera (Helpman, Melitz y Yeaple, 2004; no «Antràs-Yeaple»: E15), junto al paradigma ecléctico de Dunning (1980), `\vertema{3.B.18}` | — |
| 3.B.8, 3.B.10 | Política estratégica; integración | mención | 3.B.8: justificación de la promoción exterior; 3.B.10: selección y reasignación al integrarse (Trefler, 2004) | El modelo |
| 3.B.34 | Acuerdos de la OMC distintos de mercancías (AGCS) | variante (hecho, 18/11/2026; I.2 `sec:servicios-teoria` y anexo `anexo:modelo-servicios`) | **Modos de suministro de servicios** como Helpman, Melitz y Yeaple (2004): modo 1 = exportar, $F^{\mathrm{M1}}=F^x+R^{\mathrm{M1}}$ con iceberg τ; modo 3 = filial, $F^{\mathrm{M3}}=F^{\mathrm I}+R^{\mathrm{M3}}$ ($R$ costes fijos regulatorios); función clave `eq:umbrales-servicios`, $F^{\mathrm{M3}}>\tau^{\sigma-1}F^{\mathrm{M1}}>F^d\Rightarrow\varphi^*<\varphi^*_{\mathrm{M1}}<\varphi^*_{\mathrm{M3}}$; gráfico `fuentes/3B34/graficos/servicios-modos-hmy.tex` (copia adaptada de `3B18/graficos/hmy.tex`, mismas rectas); $\Omega$ factor de demanda como en el 3.B.18. Propuesta `modos-suministro-servicios` recogida aquí como variante (pasada final) | La derivación de los umbrales (3.B.6, 3.B.18) |

## Divergencias encontradas en el temario actual
- En 3.B.6 la productividad es $\phi$ en el texto y $\varphi$ en las fórmulas, y la función de costes del inventario ($CT = w(F^d + F^x + q/\varphi + \tau q_x)$) mezcla costes fijos y variables de ambos mercados: canon $CT^d = w(F^d + q/\varphi)$ y $CT^x = w(F^x + \tau q_x/\varphi)$.
- $\varphi$ se reserva para la productividad de Melitz (y la inversa de Frisch en macro); los otros usos cambian: hoy también es función de reacción (3.B.8), peso de los inputs (3.B.7) y sensibilidad de XN (3.B.15), que pasan a $a_{ij}$, $R_A(q_B)$ y $\nu$.
- La ficha escribía $\pi^d$, $\pi^x$: canon $B^d$, $B^x$ (D003), corregido en la pasada final (CC3 del 3.B.6). El 3.B.6 revisado ya usa $B$, $\varphi^*_{\mathrm{aut}}$ y $\hat\varphi$.

Autor: Víctor Gutiérrez Marcos
