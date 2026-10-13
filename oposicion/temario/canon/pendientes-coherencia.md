# Pendientes de coherencia del canon

Cambios del canon que hay que llevar a temas **ya revisados** con `/revisartema T --fase coherencia`. Cada entrada: tema, qué cambiar, por qué y a raíz de qué. Se marca `[hecho: fecha]` al aplicarla.

Autor: Víctor Gutiérrez Marcos

## 3.A.8 (condicionado a las decisiones de `decisiones.json`)

Consolidación inicial del canon (13 oct. 2026). **Ninguna entrada se aplica hasta que Víctor apruebe la decisión correspondiente**; si la rechaza, la entrada se borra.

| # | Decisión | Qué cambiar en 3.A.8 | Por qué |
|---|---|---|---|
| 1 | D001 | Anexo de formas funcionales: CRRA u(C) = (C^{1−η} − 1)/(1 − η) → θ (también «aversión relativa constante igual a η» → θ). Preferencias KPR, GHH y Jaimovich-Rebelo: exponente 1−σ → 1−θ. Quitar el aviso de que σ cambia de sentido en el anexo (deja de cambiar) | CRRA = θ en todo el temario (Romer, Blanchard-Fischer, nueve temas de macro); σ queda solo para la elasticidad de sustitución (CES) |
| 2 | D004 | GHH (ec. con ψN^{1+θ}/(1+θ)) y JR (ψN_t^θ X_t): exponente θ → φ (inversa de la elasticidad de Frisch) y peso ψ → χ; condición de oferta χN^φ = w | θ pasa a la CRRA; φ y χ son la notación de Galí/Walsh que usarán 3.A.6 y 3.A.42 |
| 3 | D002 | Becker: ec. `becker-restricciones` Σp_ix_i = w t_w + V → + W̄ y ec. `renta-completa` wT + V → wT + W̄; el texto «V la renta no laboral» → «W̄ la renta no laboral (exógena)» | V es la FIU en el mismo tema; W̄ es la renta exógena del consumidor en todo el canon |
| 4 | D003 | Rosen: función de oferta φ(z;π) → φ(z;B) y «beneficio π» → «beneficio B» | B = beneficio en todo el temario; π queda para inflación y probabilidad |
| 5 | D006 (depende de 1 y 4) | Rosen: función de puja θ(z;Ū,W̄) → Θ(z;Ū,W̄) en el texto, las ecuaciones y el gráfico de las curvas de puja | θ pasa a la CRRA |
| 6 | D005 | Donde se cite la Cobb-Douglas como función de producción o se remita a su tema de referencia, «[ver tema 3.A.11]»; 3.A.8 sigue siendo la referencia de la variante de utilidad | Tema de referencia de la Cobb-Douglas: 3.A.11 |

Comprobaciones al aplicarlas: rehacer el PDF/HTML/Word, revisar el guion del cante si nombra las letras, y repasar las capas TikZ que rotulan θ, φ o π en el gráfico de Rosen.

Sin decisión pendiente (tolerados y documentados en `notacion.md`): π_i precio sombra de Becker y τ_i tiempo de consumo de Becker (locales, avisados); N horas en el anexo macro (en macro, L; se mantiene N por ser la notación de KPR/GHH).
