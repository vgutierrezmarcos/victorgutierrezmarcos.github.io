# Pensiones de reparto frente a capitalización: efecto sobre el ahorro y el capital (Diamond, 1965; Aaron, 1966)

- **Id:** `reparto-vs-capitalizacion` (alias `pensiones-reparto`, `reparto-capitalizacion`, `condicion-aaron`). Ficha nueva del 5/11/2026 (el id ya estaba en `alias.json`, `areas.json` y en la lista del 4.B.24, sin fichero).
- **Área:** sector público · **Tema de referencia:** **3.A.38** (La política fiscal: efectos sobre el crecimiento económico y el ahorro), **hecho el 5/11/2026**: II.2 `sec:pensiones` con a)-e) y el anexo E `anexo:pensiones` paso a paso. **[decidir]** (CC3 del 3.A.38): ficha propia para la **teoría**; la ficha `pensiones` se queda con el **sistema** (4.B.24: prestaciones, sostenibilidad, reformas y cifras de España) y remite aquí. *Alternativa*: todo en `pensiones`, sin ficha nueva. Es coherente con el reparto fijado en la fase canon del 3.A.29 (3/11/2026): el 3.A.29 deriva el OLG y da el reparto solo como salida a la ineficiencia dinámica; el 3.A.38 desarrolla reparto frente a capitalización y su efecto sobre el ahorro y el capital; el 4.B.24 lo resume para cantarse solo y lo aplica a España.
- **Temas que lo usan:** 3.A.38 (desarrollo; referencia; hecho, 5/11/2026), 4.B.24 (resumen: lo imprescindible para cantarse solo; sin fuente), 3.A.29 (mención; hecho, 1/11/2026: III.1 c) y anexo H d), Aaron como salida a la ineficiencia dinámica, `\vertema{3.A.38}` `\vertema{4.B.24}`), 4.B.3 (mención; su Word lo desarrolla con «si $n>r_{t+1}$» 2 veces con conclusiones opuestas: pasa a mención), 3.A.35 (mención: Samuelson con dinero hace lo mismo que el reparto; ficha `olg-samuelson-diamond`).
- **Fuentes de referencia:** Diamond (1965), *AER* (`Diamond1965National`); Aaron (1966), *CJEPS* (`Aaron1966Social`); Samuelson (1958); Shell (1971) (`Shell1971Notes`); Malinvaud (1953) y Cass (1972) en nota; Feldstein (1974) (`Feldstein1974Social`) y Leimer y Lesnoy (1982) (`LeimerLesnoy1982Social`); Samwick (2000); Abel, Mankiw, Summers y Zeckhauser (1989) (`AbelEtAl1989Assessing`); Auerbach y Kotlikoff (1987), sin cifra (las del Word, 24 % y el 40 % de Conesa y Garriga para España, no comprobadas, V44); Thaler y Sunstein (2008), Pensions Act 2008 del Reino Unido y Chetty *et al.* (2014) para el empujón; Romer (2019), cap. 2B; Acemoglu (2009), cap. 9; Comisión Europea, *Ageing Report* 2024.

## Presentación de referencia (la del 3.A.38, II.2)

**Pregunta:** ¿cómo cambia cada sistema el ahorro y el capital, y cuál es mejor?

**Pegatinas** (3.A.38, A38-03): «hijo eres, padre serás; cual hiciste, tal habrás» (el reparto: lo que pagas a la generación de tus padres te lo pagará la de tus hijos) y «la avaricia rompe el saco» (la ineficiencia dinámica, **la del 3.A.29**, reutilizada por ser el mismo concepto). No usar «cuando seas padre, comerás huevos» (Samuelson, 3.A.29).

**Supuestos** (el OLG de Diamond con las letras y la versión del 3.A.29; ficha `olg-samuelson-diamond`): hogares de 2 periodos; de jóvenes ofrecen **una unidad de trabajo, de forma inelástica**, cobran $w_t$, cotizan un tipo **τ** sobre él, consumen $C^J_t$ y ahorran $S_t$; de viejos consumen $C^V_{t+1}$, su ahorro con rendimientos más la pensión **$Z_{t+1}$** (local, **[decidir]**: no $B$, bonos; no $P$, precios; no $b$, activos); población a la tasa $n$; utilidad $\ln C^J_t+\beta\ln C^V_{t+1}$. Empresas competitivas con $Y_t=K_t^{\alpha}(A_tL_t)^{1-\alpha}$, $A_{t+1}=(1+g)A_t$, **δ = 1** (periodo de unos 30 años): $1+r_t=\alpha k_t^{\alpha-1}$, $w_t=A_t(1-\alpha)k_t^{\alpha}$.

**Ecuaciones:**
- Sin pensiones: $S_t=\frac{\beta}{1+\beta}w_t$ y `eq:diamond`, $k_{t+1}=\frac{\beta(1-\alpha)}{(1+\beta)(1+n)(1+g)}k_t^{\alpha}$ (la del 3.A.29, misma etiqueta).
- **Capitalización**: $Z_{t+1}=(1+r_{t+1})\tau w_t$ ⇒ $S_t+\tau w_t=\frac{\beta}{1+\beta}w_t$: el ahorro obligatorio sustituye uno a uno al voluntario; ahorro total y capital **no cambian** (mientras τ no supere el ahorro deseado).
- **Reparto**: $Z_{t+1}=(1+n)\tau w_{t+1}$ (por cada viejo hay $1+n$ jóvenes; del presupuesto del sistema, $L_{t-1}Z_t=\tau w_tL_t$). El hogar resuelve con `\optim` y
$$S_t=\frac{\beta}{1+\beta}(1-\tau)w_t-\frac{1}{1+\beta}\,\frac{(1+n)\,\tau\,w_{t+1}}{1+r_{t+1}}\qquad(\texttt{eq:ahorro-reparto},\ \text{función clave})$$
El ahorro cae por 2 vías: la cotización reduce la renta de hoy y la pensión aumenta la de mañana; y nadie ahorra por los jóvenes.
- **Ley de movimiento** (con $K_{t+1}=L_tS_t$, $w_{t+1}/(1+r_{t+1})=(1+g)A_t(1-\alpha)k_{t+1}/\alpha$; $k_{t+1}$ a los 2 lados, despejado):
$$k_{t+1}=\frac{\beta(1-\alpha)(1-\tau)}{(1+n)(1+g)\left[1+\beta+\tau(1-\alpha)/\alpha\right]}\,k_t^{\alpha}\qquad(\texttt{eq:diamond-reparto})$$
Con τ = 0 es `eq:diamond`; el coeficiente baja con τ. Estado estacionario $k^*_{\mathrm R}$ decreciente en τ, con $(k^*_{\mathrm R}/k^*)^{1-\alpha}=(1-\tau)(1+\beta)/[1+\beta+\tau(1-\alpha)/\alpha]$.

**Implicaciones:**
- Rendimientos: capitalización $1+r$; reparto $(1+n)(1+g)$ en el estado estacionario.
- **Condición de Aaron** (función numerada): $n+g>r$ (`eq:aaron`), que es la de **ineficiencia dinámica**, $r^*<(1+n)(1+g)-1\simeq n+g$ (3.A.29, D010; nunca $r^*<n$ ni $n+\gamma$). Entonces el reparto lleva el capital hacia la regla de oro y mejora a **todas** las generaciones; **con α = 0,3 y β = 0,9 (los de `diamond.tex` del 3.A.29: $k^*=1{,}957$, $k_{\mathrm{oro}}=1{,}696$), una cotización τ ≈ 0,045 (exacto, 0,0451) lleva el estado estacionario justo a $k_{\mathrm{oro}}$** (el factor del coeficiente es $(k_{\mathrm{oro}}/k^*)^{1-\alpha}=0{,}905$).
- **Sin fallo de mercado**: la «doble infinitud» de Shell (1971) (el valor de las dotaciones puede ser infinito y el 1TFEB necesita que no lo sea, `\vertema{3.A.22}`) y «no se puede prestar a quien aún no ha nacido» (la frase del 3.A.29). Malinvaud (1953) y Cass (1972) en nota; **nunca** «criterio de Malinvaud-Cass» como $\sum p^*_j<\infty$ ni «externalidades pecuniarias».
- Economía eficiente ($r>n+g$): gana la primera generación de viejos a costa de las siguientes; volver a la capitalización exige que una generación pague 2 veces.
- **La deuda hace lo mismo**: $K_{t+1}=L_tS_t-D_t$, desplaza capital (Diamond, 1965); la equivalencia ricardiana solo con herencias altruistas (Barro, 1974).

**Extensiones:** jubilación endógena (efecto ambiguo; Feldstein, 1974); modelos con muchas generaciones (Auerbach y Kotlikoff, 1987); el **empujón** al ahorro voluntario (paternalismo libertario, Thaler y Sunstein, 2008, `\vertema{3.A.1}`; afiliación automática del Reino Unido desde octubre de 2012, de las grandes empresas a las pequeñas, Pensions Act 2008; Chetty *et al.*, 2014, Dinamarca: una corona de subvención fiscal crea un céntimo de ahorro nuevo).

**Evidencia:** Feldstein (1974) y el error de programación de Leimer y Lesnoy (1982); Samwick (2000) entre países; Abel *et al.* (1989): las economías avanzadas no acumulan de más, así que el reparto no es una mejora de Pareto; el envejecimiento baja $n$ (España: dependencia 65+/20-64 del 33,3 % en 2022 al 64,5 % en 2054; gasto en pensiones del 13,1 % del PIB en 2022 a un máximo del 17,3 % hacia 2050 y 16,7 % en 2070; UE 11,4 → 12,2 → 11,8 %; *Ageing Report* 2024).

**Valoración:** deja fuera el riesgo (mercados frente a demografía y política), la jubilación endógena y la redistribución dentro de cada generación; las reformas reales combinan (cuentas nocionales en Suecia, fondos de reserva, el mecanismo de equidad intergeneracional español, `\vertema{4.B.24}`).

**Gráficos de referencia:** `oposicion/temario/fuentes/3A38/graficos/diamond-pensiones.tex` (sobre `fuentes/3A29/graficos/diamond.tex`, mismas unidades: ley de movimiento sin pensiones, $k^*$, ley con reparto que baja y nuevo estado estacionario en $k_{\mathrm{oro}}$ con τ = 0,045; imprescindible en el cante del 3.A.38, por capas) y `fuentes/3A38/graficos/olg-generaciones.tex` (esquema de las generaciones con capitalización y reparto; opcional, 15″). Para el envejecimiento, `demografia-pensiones` copiado del 3.A.29 (A38-13, A38-19: el texto da la dependencia del *Ageing Report*, 65+/20-64, y el gráfico la de Eurostat, 65+/15-64; el pie lo dice).

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.38 | Efectos de la política fiscal sobre el ahorro | **desarrollo (referencia; hecho, 5/11/2026)** | II.2 completo (6′ en el cante) y anexo E | La derivación de `eq:diamond` (`\vertema{3.A.29}`) |
| 4.B.24 | Seguridad Social y sostenibilidad de las pensiones | resumen | Capitalización neutral, reparto con $(1+n)(1+g)$, Aaron $n+g>r$, ineficiencia dinámica, transición, envejecimiento con las cifras de España; `eq:ahorro-reparto` en una línea si se quiere; `\vertema{3.A.38}` para ampliar | `eq:diamond-reparto` y su derivación |
| 3.A.29 | Generaciones solapadas | mención (hecho, 1/11/2026) | Aaron como salida a la ineficiencia dinámica | Las pensiones en detalle |
| 4.B.3 | Estado del bienestar | mención | Las pensiones como instrumento redistributivo, remitiendo al 4.B.24 | El modelo (su Word: «si $n>r_{t+1}$» 2 veces con conclusiones opuestas) |
| 3.A.35 | Demanda de dinero | mención | Samuelson con dinero hace lo mismo que el reparto | El modelo de Diamond |

## Divergencias encontradas en el temario actual
- **Resuelto en el 3.A.38 (5/11/2026):** Word sin producción ni capital (solo el hogar con $w$ dado), con $w^J_t$, $s_t$; Euler con $C^V_t$; jóvenes que «ofertan su trabajo de forma perfectamente elástica»; ineficiencia con $r^*<n$; «Acemoğlu demuestra… criterio Malinvaud-Cass… finitud de la suma de todos los precios»; «externalidades pecuniarias»; Bismarck «no consiguió su función y tuvo que dimitir en 1890» (ahora: ley de 1889, en vigor en 1891, pensión a los 70 años; su salida en 1890, por el choque con Guillermo II).
- 4.B.3 (sin revisar): «si $n>r_{t+1}$» 2 veces con conclusiones opuestas (la 2.ª, $n<r_{t+1}$) y la fórmula del ahorro truncada.

Autor: Víctor Gutiérrez Marcos
