# Contratos implícitos (Baily, 1974; Gordon, 1974; Azariadis, 1975)

- **Área:** macro cerrada · **Tema de referencia:** **3.A.27** (determinación de salarios: negociación, salarios de eficiencia y contratos implícitos; revisado el 31/10/2026, bloque III `sec:contratos-implicitos`: idea, modelo, extensiones con *insiders* y *outsiders*, valoración) — lo tiene en el título.
- **Temas que lo usan:** 3.A.27 (desarrollo; hecho, 31/10/2026), 3.A.7 (resumen: rigidez real de la NEK de 1.ª generación; hoy desarrollo con el texto antiguo del 3.A.27, incluido el error del paro involuntario), 3.A.13 (mención implícita; hecho, 19/10/2026: el caso 2 del principal-agente, principal neutral y agente averso con esfuerzo observable, es este contrato; el 3.A.27 lo dice con `\vertema{3.A.13}`; ficha `principal-agente`).
- **Manuales de referencia:** Baily (1974), *RES*; Gordon (1974), *JEL*; Azariadis (1975), *JPE*; Rosen (1985), *JEL*; Azariadis y Stiglitz (1983), *QJE*; Romer (2019), cap. 11; Cahuc, Carcillo y Zylberberg (2014), cap. 7.
- **Notación (3.A.27; [decidir] solo en lo que pide Víctor):** probabilidades **π_j** (no $p_j$: $p$ es precio, D017; no $\rho_i$: ρ es descuento), utilidad de reserva **$U^R$** (no $\overline u$; como la PC del 3.A.13), renta **$C_j$** y horas **$L_j$** por estado, $A_j$ productividad, $\overline C$ renta asegurada, $\overline w$ salario con horas fijas, λ multiplicador.

## Presentación de referencia (3.A.27, III.2)

Pregunta: ¿por qué el salario real es estable a lo largo del ciclo y el ajuste se hace por el empleo? Conclusión: el salario estable es un **seguro** eficiente entre una empresa neutral y unos trabajadores aversos al riesgo; explica la **rigidez del salario, no el paro**. Se levantan los supuestos 6 (flexibilidad del salario período a período) y, con los *insiders*, 7 (movilidad sin costes) de `tab:supuestos-trabajo` (3.A.25). Pegatina: «A las duras y a las maduras».

- **Supuestos**: productividad $A_j$ en el estado $j=1,\dots,n$ con probabilidad $\pi_j$, observable por los 2; empresa neutral al riesgo que produce $A_jF(L_j)$ y paga una renta $C_j$; trabajador con $u(C_j)-v(L_j)$, $u$ cóncava, $v$ convexa, sin mercados de seguros; contrato firmado antes de conocer el estado.
- **Programa** (`eq:contrato-implicito`, `\funcionclave` con `\optim`):
  $$\max_{\{C_j,L_j\}}\ \sum_{j=1}^{n}\pi_j\,[A_jF(L_j)-C_j]\quad\text{s.a.}\quad\sum_{j=1}^{n}\pi_j\,[u(C_j)-v(L_j)]\ \geq\ U^R$$
- **CPO**: $u'(C_j)=1/\lambda$ en todos los estados ⇒ $C_j=\overline C$ (**seguro completo**; reparto eficiente del riesgo, 3.A.10); $A_jF'(L_j)=v'(L_j)/u'(\overline C)$ (`eq:empleo-eficiente`: **empleo eficiente** en cada estado, como en un mercado al contado). Con horas fijas, $w_j=\overline w$, con una prima de riesgo implícita. Lectura con el principal-agente: caso 2 (principal neutral, agente averso, información simétrica: pago fijo; 3.A.13).
- **Implicaciones**: rigidez del salario real (con horas variables, el salario por hora $\overline C/L_j$ es incluso contracíclico); ganan los 2; **no hay paro involuntario**: el empleo de cada estado está en el contrato y es el eficiente; el salario observado deja de ser el precio que decide cuánto se trabaja (Barro, 1977).
- **Extensiones** (III.3): despidos con trabajo indivisible (Azariadis, 1975; sin indemnización, paro involuntario *a posteriori*, Rosen, 1985); información asimétrica (subempleo si la empresa es también aversa, Grossman y Hart, 1981, y Azariadis, 1983; sobreempleo si es neutral y el ocio es normal, Green y Kahn, 1983; Azariadis y Stiglitz, 1983); esfuerzo no observable (el contrato deja parte del riesgo: caso 4 del principal-agente, 3.A.13); autoexigibilidad por reputación (Bull, 1987; juego repetido, 3.A.14); ***insiders* y *outsiders*** (ficha `insiders-outsiders`).
- **Valoración**: evidencia de Beaudry y DiNardo (1991) (el salario depende del paro más bajo desde que se entró en la empresa); los ERTE de la pandemia (3.386.785 trabajadores el 30/4/2020) como seguro explícito que completa al implícito; limitaciones: sin extensiones no hay paro involuntario, estabilizan el salario real (la rigidez nominal tiene otras causas, 3.A.7), la reputación se debilita con relaciones más cortas.

**Gráfico de referencia:** **ninguno** (el bloque III del 3.A.27 va sin gráfico: se recuadra el programa con sus 2 condiciones).

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.27 | Determinación de salarios | desarrollo (hecho, 31/10/2026) | Programa con renta y horas por estado, seguro completo y empleo eficiente, lectura con el principal-agente, extensiones (con *insiders*), evidencia y valoración | — |
| 3.A.7 | Rigidez del salario real en la NEK de 1.ª generación | resumen | Idea, resultado (salario estable, empleo eficiente) e implicación: **rigidez real sin paro involuntario**; por qué la NEK lo abandona (estabiliza el salario real, no el nominal) | El programa formal: `\vertema{3.A.27}` |
| 3.A.13 | Riesgo moral | mención (hecho, 19/10/2026) | El caso 2 del principal-agente (principal neutral, agente averso, pago fijo) | El contrato implícito |

## Divergencias encontradas en el temario actual
- 3.A.27 original: «generan paro involuntario: al salario existente, los desempleados querrían trabajar pero no pueden» (es al revés), solo el salario por estado, probabilidades $\rho_i$, $\pi[X_i-w_i]$, $u(w_R)$. **Resuelto** en la revisión (31/10/2026): renta y horas por estado, π_j, $U^R$, sin paro involuntario.
- 3.A.7 (sin revisar): copia el texto antiguo con el error del paro involuntario: al revisarlo, resumen con la implicación correcta y remisión al 3.A.27 (`mapa.yaml`, contradicciones del 3.A.27).

Autor: Víctor Gutiérrez Marcos
