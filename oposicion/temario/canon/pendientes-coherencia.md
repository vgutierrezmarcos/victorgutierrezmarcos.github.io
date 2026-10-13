# Pendientes de coherencia del canon

Cambios del canon que hay que llevar a temas **ya revisados** con `/revisartema T --fase coherencia`. Cada entrada: tema, qué cambiar, por qué y a raíz de qué. Se marca `[hecho: fecha]` al aplicarla.

Autor: Víctor Gutiérrez Marcos

## 3.A.8 (decisiones aprobadas el 13/10/2026)

A raíz de la consolidación inicial del canon (`/revisartema --canon`): Víctor aprobó D001, D002, D003, D004, D005 y D006, que cambian el 3.A.8 ya revisado. Ya no son condicionales: hay que aplicarlas todas. Líneas de `fuentes/3A08/3A08.tex` a 13/10/2026 (comprobadas en el fichero).

### `fuentes/3A08/3A08.tex`

| # | Decisión | Dónde (línea) | Antiguo → nuevo | Por qué |
|---|---|---|---|---|
| 1 | D001 | l. 1358, ec. `eq:crra` | `\dfrac{C^{1-\eta}-1}{1-\eta}` → `\dfrac{C^{1-\theta}-1}{1-\theta}`; `\eta\geq 0,\ \eta\neq 1` → `\theta\geq 0,\ \theta\neq 1`; `\eta=1` → `\theta=1` | CRRA = θ en todo el temario (Romer, Blanchard-Fischer, Barro-Sala i Martín, Acemoglu y nueve temas de macro) |
| 2 | D001 | l. 1360, texto y nota al pie | «aversión relativa al riesgo constante (igual a $\eta$)» → «(igual a $\theta$)»; «elasticidad de sustitución intertemporal es $1/\eta$» → «$1/\theta$»; en la nota, «cuando $\eta\to 1$» → «cuando $\theta\to 1$» | Ídem; la ESI es 1/θ, sin símbolo propio |
| 3 | D001 | l. 1365, ec. `eq:kpr` | `\frac{C^{1-\sigma}}{1-\sigma}` → `\frac{C^{1-\theta}}{1-\theta}`; `\sigma\neq 1` → `\theta\neq 1`; `\sigma=1` → `\theta=1` | En KPR el exponente es la CRRA; σ queda solo para la elasticidad de sustitución (CES, l. 353-373), así que deja de tener dos sentidos en el mismo tema |
| 4 | D001 | l. 1367 | «creciente y cóncava si $\sigma<1$, decreciente y convexa si $\sigma>1$» → «… si $\theta<1$ … si $\theta>1$» | Ídem |
| 5 | D001 y D004 | l. 1370, ec. `eq:ghh` | `u(C,N)=\frac{1}{1-\sigma}\left(C-\psi\,\frac{N^{1+\theta}}{1+\theta}\right)^{1-\sigma}` → `u(C,N)=\frac{1}{1-\theta}\left(C-\chi\,\frac{N^{1+\varphi}}{1+\varphi}\right)^{1-\theta}` | CRRA θ; φ = inversa de la elasticidad de Frisch y χ = peso de la desutilidad del trabajo (Galí, Walsh), la notación de 3.A.6, 3.A.42 y la ficha `rbc` |
| 6 | D004 | l. 1372 | «la condición de oferta de trabajo, $\psi N^{\theta}=w$» → «$\chi N^{\varphi}=w$»; conviene añadir «($\varphi$ es la inversa de la elasticidad de Frisch)» la primera vez | Ídem |
| 7 | D001 y D004 | l. 1375, ec. `eq:jr` | `\frac{\left(C_t-\psi N_t^{\theta}X_t\right)^{1-\sigma}-1}{1-\sigma}` → `\frac{\left(C_t-\chi N_t^{1+\varphi}X_t\right)^{1-\theta}-1}{1-\theta}` (equivale al original de Jaimovich y Rebelo con su $\theta=1+\varphi$; decirlo en una nota si se quiere) | Ídem; así φ es también aquí la inversa de Frisch y la forma anida la GHH de la l. 1370 |
| 8 | D002 | l. 1015, ec. `eq:becker-restricciones` | `\sum_i p_i x_i=w\,t_w+V` → `\sum_i p_i x_i=w\,t_w+\overline{W}` | W̄ es la renta monetaria exógena del consumidor en todo el canon; V es la función indirecta de utilidad en el mismo tema (l. 519-530) |
| 9 | D002 | l. 1017 | «$V$ la renta no laboral» → «$\overline{W}$ la renta no laboral (exógena)» | Ídem |
| 10 | D002 | l. 1019, ec. `eq:renta-completa` | `w\,T+V` → `w\,T+\overline{W}` | Ídem |
| 11 | D006 (con D001) | l. 1068 | «función de puja} $\theta(z;\overline{U},\overline{W})$» → «$\Theta(z;\overline{U},\overline{W})$» | θ es la CRRA; Θ mayúscula mantiene la letra de Rosen sin choque |
| 12 | D003 y D006 | l. 1068 | «función de oferta} $\phi(z;\pi)$» → «$\phi(z;B)$»; «obteniendo un beneficio $\pi$» → «obteniendo un beneficio $B$» | B = beneficio en todo el temario; π queda para inflación y probabilidad |
| 13 | D005 | l. 1340, nota al pie de la Cobb-Douglas | tras «que la usaron como función de producción» añadir `\vertema{3.A.11}` | Tema de referencia de la Cobb-Douglas como función de producción: 3.A.11; el 3.A.8 sigue siendo la referencia de la variante de utilidad |

Nada más del `.tex` cambia: σ de la CES (l. 353-373 y 1318-1340), W̄, p, x, U, V, E, h, λ, RMS_{12}, ρ, s_i y ε ya son canon; π_i (precio sombra de Becker, l. 1022) y τ_i (tiempo de consumo de Becker) son locales y se toleran; N (horas) en el anexo de preferencias macro se mantiene (notación de KPR y GHH). El aviso de que σ cambia de sentido, que preveía la consolidación, no existe en el `.tex` actual: no hay nada que quitar.

### Gráficos

| # | Decisión | Fichero | Antiguo → nuevo |
|---|---|---|---|
| 14 | D006 | `graficos/funcion-hedonica-rosen.tex`, l. 14 y 17 | `$\theta_1(z;U_1)$` → `$\Theta_1(z;U_1)$`; `$\theta_2(z;U_2)$` → `$\Theta_2(z;U_2)$` |
| 15 | D003 | `graficos/funcion-hedonica-rosen.tex`, l. 19 y 21 | `$\phi_1(z;\pi_1)$` → `$\phi_1(z;B_1)$`; `$\phi_2(z;\pi_2)$` → `$\phi_2(z;B_2)$` |

Después, regenerar `funcion-hedonica-rosen.pdf`, `.png` y `.svg` (y sus capas para el vídeo). Ningún otro gráfico rotula θ, η, ψ, π (beneficio) ni V (renta).

### Vídeo, guion y repaso

| # | Decisión | Fichero | Antiguo → nuevo |
|---|---|---|---|
| 16 | D002 | `video/escenas.yaml`, l. 498 (pizarra) | `formula: '\sum_i\left(p_ix_i+w\,t_i\right)=w\,T+V'` → `…=w\,T+\overline{W}'` |
| 17 | D006 | `video/escenas.yaml`, l. 525 (`di`) | «una curva de puja, theta:» → «una curva de puja, theta mayúscula:» |
| 18 | D002 | `guion-cante.md`, l. 366 | la fórmula de la pizarra `w\,T+V` → `w\,T+\overline{W}` (o regenerar el guion desde `escenas.yaml`) |
| 19 | D002 | `repaso/3A08-repaso.tex`, l. 141 | «Renta completa: $\sum_i(p_ix_i+w\,t_i)=wT+V$» → «$=wT+\overline{W}$» |

El vídeo no nombra η, σ (salvo la de la CES, que no cambia), ψ ni la CRRA: no hay que tocar más locuciones. La escena de Rosen dice «curva de oferta, fi», que se mantiene.

### Al aplicarlas

- Regenerar `3A08.lyx` desde el `.tex` (el `.lyx` es generado: `_trabajo/lyx-generado.sha1`; hoy contiene las mismas cadenas) y rehacer PDF, HTML y Word.
- Volver a montar el vídeo de las escenas de Becker y Rosen.
- Al terminar, marcar esta sección `[hecho: fecha]` y anotarlo en `cambios.md`.
