# Proposición de inefectividad de la política sistemática (Sargent y Wallace, 1975-1976)

- **Área:** pensamiento · **Tema de referencia:** **3.A.6** (La nueva macroeconomía clásica; revisado el 4/11/2026: II.2.2 `sec:inefectividad` con a)-e), **una sola vez**, y el anexo A con la versión con inercia) — resultado central de la hipótesis de expectativas racionales.
- **Temas que lo usan:** 3.A.6 (desarrollo; hecho, 4/11/2026), 3.A.37 (resumen: transmisión del dinero anticipado frente al no anticipado). Distinta de la «aritmética monetarista desagradable» (Sargent y Wallace, 1981; `aritmetica-monetarista`). También 3.A.7 (mención; hecho, 4/11/2026: I.2.1, nota de los contratos escalonados de Fischer, 1977, y Taylor, 1980, como respuesta a la inefectividad, l. 351, `\vertema{3.A.6}`); 3.A.28 (mención; hecho, 31/10/2026: II.3, l. 376, «proposición de **ineficacia**», con `SargentWallace1975Rational`). También 3.A.36 (mención; hecho, 4/11/2026: I.1.2, «Sargent y Wallace (1975) sacan la *proposición de inefectividad*: una regla monetaria sistemática no afecta a la producción», `\vertema{3.A.6}`; II.3.2 e), con expectativas racionales un tipo fijo que no responde a la inflación deja indeterminado el nivel de precios, la otra tesis de Sargent y Wallace, 1975, que lleva al principio de Taylor).
- **Manuales de referencia:** Sargent y Wallace (1975), *JPE* 83 (`SargentWallace1975Rational`); (1976), *JME* 2 (`SargentWallace1976Rational`); Barro (1977), *AER* (`Barro1977Unanticipated`); Mishkin (1982) (`Mishkin1982Does`); Fischer (1977) y Taylor (1980); Romer (2019), cap. 6; Blanchard y Fischer (1989), cap. 11; Heijdra (2017), cap. 5.

## Presentación de referencia (3.A.6, II.2.2 y anexo A)

**Pregunta:** ¿puede una regla monetaria conocida estabilizar la producción?

**Nombre** (terminología, `notacion.md` § 14): «**proposición de inefectividad** de la política sistemática», con «(o de ineficacia)» dicho una vez, el nombre del 3.A.28 (**[decidir]**, cosmético: `pendientes-coherencia.md`). Las 2 obras juntas (1975 y 1976). No es la **superneutralidad** (neutralidad a largo plazo frente a la tasa de crecimiento del dinero): la inefectividad vale a corto plazo para la parte anticipada.

**Supuestos:** la oferta de Lucas (`lucas-islas`) con una **perturbación de oferta** $u_t$, ruido blanco: $y_t=y^n+\psi(p_t-p^e_t)+u_t$ (de oferta porque desplaza la oferta de Lucas; misma familia que la perturbación de costes de la NKPC del 3.A.7, `notacion.md` § 8); la demanda $y_t=m_t-p_t$; una regla con realimentación $m_t=\mu_0+\mu_1u_{t-1}+\varepsilon_t$, con $\varepsilon_t$ la **sorpresa monetaria** de media nula (un error de previsión como el de `eq:her`; μ_0, μ_1 locales); expectativas racionales; precios flexibles.

**Ecuaciones:** como $u_{t-1}$ se conoce en $t-1$, $\mathbb{E}_{t-1}[m_t]=\mu_0+\mu_1u_{t-1}$ y (`eq:inefectividad`, solución cerrada; derivación en el anexo A del 3.A.6)

$$y_t=y^n+\frac{\psi\,\varepsilon_t+u_t}{1+\psi},\qquad \frac{\partial y_t}{\partial\mu_1}=0,\qquad p_t=\mu_0+\mu_1u_{t-1}-y^n+\frac{\varepsilon_t-u_t}{1+\psi}$$

La parte sistemática solo mueve los precios; solo las sorpresas mueven la producción, y sorprender no estabiliza: añade ruido. Con **inercia**, $y_t=y^n+\psi(p_t-p^e_t)+\lambda_y(y_{t-1}-y^n)+u_t$ y $m_t=\mu_0+\mu_1(y_{t-1}-y^n)+\varepsilon_t$: $y_t-y^n=\lambda_y(y_{t-1}-y^n)+(\psi\varepsilon_t+u_t)/(1+\psi)$, la regla tampoco cambia la dinámica (λ_y local, avisado: no es un multiplicador). Cita de Sargent y Wallace (1976), traducida entera en el 3.A.6: «… La autoridad no puede esperar explotar la curva de Phillips ni siquiera durante un periodo».

**Resultado y extensiones:** con **contratos** firmados antes de conocer la perturbación, la política sistemática sí estabiliza aunque las expectativas sean racionales (Fischer, 1977; Taylor, 1980; `fischer-taylor-contratos`, `\vertema{3.A.7}` `\vertema{3.A.37}`): lo que da la inefectividad no son las expectativas racionales, sino la flexibilidad de los precios. **Evidencia**: Barro (1977) a favor (solo el dinero no anticipado explica el paro); Mishkin (1982) en contra.

**Gráfico de referencia:** el de `lucas-islas` (`oposicion/temario/fuentes/3A06/graficos/oferta-lucas.tex`, capas 5-6: expansión no anticipada frente a anticipada). No tiene uno propio.

## Cómo se adapta en cada tema

| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.6 | La NMC | desarrollo (hecho, 4/11/2026) | Una sola vez (II.2.2): supuestos, `eq:inefectividad`, la cita de 1976, superneutralidad distinguida, Fischer-Taylor, Barro (1977) y Mishkin (1982); la versión con inercia en el anexo A | — |
| 3.A.37 | Transmisión monetaria | Resumen | Dinero anticipado frente a no anticipado; respuesta de Fischer-Taylor; `eq:inefectividad` en una línea con `\vertema{3.A.6}` | La derivación |
| 3.A.7 | NEK de 1.ª generación | mención (hecho, 4/11/2026) | Fischer y Taylor responden a la proposición de inefectividad: con contratos, la política sistemática es eficaz aunque las expectativas sean racionales; lo que da la neutralidad es la flexibilidad de los precios | La proposición formal |
| 3.A.28 | Paro y Phillips | mención (hecho, 31/10/2026) | La política sistemática no mueve el paro; «proposición de ineficacia» (cosmético: «de inefectividad», **[decidir]**) | La proposición formal |
| 3.A.36 | Diseño de la política monetaria | mención (hecho, 4/11/2026) | I.1.2: la proposición de inefectividad con su nombre canónico; II.3.2 e): la indeterminación del nivel de precios con el tipo fijo (Sargent y Wallace, 1975) | La solución cerrada |
| 3.A.41 | Causas de la inflación (demanda) | mención (hecho, 5/11/2026) | I.2.1: «solo la política monetaria no anticipada mueve la producción», la **proposición de inefectividad** con `SargentWallace1975Rational` (el Word decía «irrelevancia (PIP)» y «Sargent y Wallace, 1976»); el resumen en el anexo E; `\vertema{3.A.6}` | El modelo |

## Divergencias encontradas en el temario actual

- **3.A.6 (Word)**: la contaba 3 veces (II.2.2 b, II.2.4 y II.5.4) sin ecuaciones, mezclaba 1975 y 1976, la confundía con la superneutralidad y decía «cambian los supuestos tecnológicos». **Resuelto** (4/11/2026): una sola vez, con la solución cerrada y las 2 obras.
- **Terminología**: el 3.A.28 (revisado, l. 376) dice «proposición de ineficacia»; el 3.A.6, el 3.A.7 y esta ficha, «inefectividad». Cosmético, en `pendientes-coherencia.md` (Pendiente del 3.A.6).
- No confundir con la aritmética monetarista desagradable (mismo par de autores).

Autor: Víctor Gutiérrez Marcos
