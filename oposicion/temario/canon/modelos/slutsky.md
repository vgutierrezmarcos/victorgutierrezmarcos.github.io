# Ecuación y matriz de Slutsky

- **Área:** consumidor-producción · **Tema de referencia:** **3.A.9** (Demanda II: dualidad; revisado el 13/10/2026) — la ecuación se deriva por dualidad (III.2) y la matriz se presenta como hessiana de la función de gasto (I.2.2); 3.A.8 (revisado) la enuncia, dibuja la descomposición y clasifica los bienes, con la derivación en su anexo `der:matriz-slutsky`.
- **Temas que lo usan:** 3.A.9 (desarrollo; hecho), 3.A.8 (resumen; hecho), 3.A.12 (resumen: demanda de factores; hecho), 3.A.25 (resumen con dotación de tiempo; hecho, 31/10/2026: anexo A `anexo:slutsky-ecuacion`), 4.B.9 (resumen: con dotación), 4.B.10 y 4.B.11 (resumen; hoy mención)
- **Manuales de referencia:** Slutsky (1915); Hicks y Allen (1934); Mas-Colell, Whinston y Green, §2.F, §3.G y §3.H; Jehle y Reny (2011), cap. 1-2; Varian, cap. 8 y 9 (con dotaciones).

## Presentación de referencia
Pregunta: ¿cómo se reparte la respuesta de la demanda a un precio entre el cambio del precio relativo y el del poder adquisitivo, y qué restricciones impone eso a la demanda?

- **Matriz** (3.A.9, I.2.2, `eq:matriz-slutsky`): por el lema de Shephard,
$$S(p,\overline U)=[S_{ij}]=D^2_pE(p,\overline U),\qquad S_{ij}=\frac{\partial h_i(p,\overline U)}{\partial p_j}=\frac{\partial^2E(p,\overline U)}{\partial p_j\,\partial p_i}$$
Simétrica (Schwarz o Young), semidefinida negativa (concavidad de $E$; $S_{ii}\le 0$, ley de la demanda compensada) y $S(p,\overline U)\,p=0$ (homogeneidad de grado cero de $h$, Euler): todo bien tiene al menos un sustitutivo neto; con dos bienes, son sustitutivos netos. Notación: **$S_{ij}$, nunca $s_{ij}$** ($s_i$ es la participación en el gasto).
- **Ecuación** (3.A.9, III.2, por dualidad): de $h_i(p,\overline U)=x_i\big(p,E(p,\overline U)\big)$, derivando y con Shephard,
$$\underbrace{\frac{\partial x_i}{\partial p_j}}_{\text{total}}=\underbrace{\frac{\partial h_i}{\partial p_j}}_{\text{sustitución}}-\underbrace{x_j\frac{\partial x_i}{\partial\overline W}}_{\text{renta}},\qquad \varepsilon_{x_i,p_j}=\varepsilon^h_{i,p_j}-s_j\,\varepsilon_{x_i,\overline W}$$
- **Matriz con observables** (integrabilidad, ficha `integrabilidad`): $S_{ij}(p,\overline W)=\partial x_i/\partial p_j+x_j\,\partial x_i/\partial\overline W$; su simetría y negatividad son el contenido contrastable de la teoría.
- **Compensación de Hicks** (utilidad constante) y **de Slutsky** (poder adquisitivo de la cesta inicial): coinciden en primer orden.
- **Clasificación** (versión compacta en 3.A.9; tablas en 3.A.8): propio (normal, inferior, Giffen; Veblen aparte, el precio entra en las preferencias) y cruzado (sustitutivos y complementarios netos, simétricos; brutos, no).
- **Pendientes de las demandas** (puente al bienestar): para un bien normal la marshalliana es más plana que la hicksiana en $(x_i,p_i)$; para uno inferior, más inclinada.
- **Con dotación** $\omega$ (oferta de trabajo, ahorro; 4.B.9): $\frac{\partial x_i}{\partial p_j}=\frac{\partial h_i}{\partial p_j}+(\omega_j-x_j)\frac{\partial x_i}{\partial\overline W}$ (efecto renta dotación).

Gráficos de referencia: descomposición sustitución (A→B) y renta (B→C) en los dos planos, `oposicion/temario/fuentes/3A08/graficos/efecto-sustitucion-renta.tex` (y `slutsky-propio.tex`, `slutsky-cruzado.tex`); 3.A.9 no lo repite y remite a él. Concavidad de $E$ y Shephard: `oposicion/temario/fuentes/3A09/graficos/concavidad-fg.tex`.

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.9 | Dualidad y sus aplicaciones | desarrollo (hecho, 13/10/2026) | Matriz como $D^2_pE$ con sus tres propiedades (I.2.2); derivación por dualidad, forma en elasticidades, compensación de Hicks y de Slutsky, clasificación compacta, pendientes de las demandas (III.2); matriz observable en la integrabilidad (III.1) | El gráfico de la descomposición y las tablas de clasificación (remitir a 3.A.8) |
| 3.A.8 | Estática comparativa | resumen (hecho) | Enunciado, gráfico, normales/inferiores/Giffen, tablas propio y cruzado; derivación y propiedades de la matriz en anexo | La derivación por dualidad (remitir a 3.A.9). Pendiente: $s_{ij}$ → $S_{ij}$ en `der:matriz-slutsky` |
| 3.A.12 | Demanda de factores | resumen (hecho, 14/10/2026) | Ecuación de Slutsky de los factores, $\partial z_i(p,\vec w)/\partial w_j=\partial z_i(\vec w,q)/\partial w_j+[\partial z_i(\vec w,q)/\partial q]\,\partial q(p,\vec w)/\partial w_j$ (efecto sustitución + **efecto escala**), derivando $\vec z(p,\vec w)\equiv\vec z(\vec w,q(p,\vec w))$; efecto escala propio $\leq 0$: no hay factores Giffen; matriz de sustitución $S(\vec w,q)=D^2_wC$. Una línea en el cuerpo, derivación en el anexo `anexo:estatica`; remite a 3.A.9 | La versión del consumidor |
| 3.A.25 | Oferta de trabajo | resumen (hecho, 31/10/2026) | Versión con **renta-dotación de tiempo** (`eq:slutsky-dotacion`): $\partial L(w,\overline W)/\partial w=-\partial h_O(w,\overline U)/\partial w+L\,\partial L(w,\overline W)/\partial\overline W$, derivada con la función de gasto $E(w,\overline U)$ (mínimo de $C+wO$); efecto sustitución, renta ordinario y renta dotación (el «efecto renta global», proporcional a las horas) con el gráfico por capas `efectos-salario.tex`; tabla de signos `tab:slutsky-dotacion` sin las filas de «demandante neto» de ocio ($O\le O_0$ siempre). $h_O$ con nota: la $h$ sin subíndice del tema es el capital humano (DK9, **[decidir]**). Remite a 3.A.9 y 3.A.8 | La derivación por dualidad general |
| 4.B.9 | Efecto renta y sustitución de los impuestos | resumen | Versión con dotación: efecto renta ordinario y efecto renta dotación (ocio, ahorro); el EG nace del efecto sustitución | Demostración |
| 4.B.10, 4.B.11 | Incentivos, imposición óptima | resumen (hoy mención; D139 (13/10/2026)) | La ecuación en una línea; exceso de gravamen ligado al efecto sustitución (demanda compensada, $S_{ij}$ en la fórmula de varios bienes) | — |

## Divergencias encontradas en el temario actual
- 3.A.8 (revisado), anexo `der:matriz-slutsky`: escribe $s_{ij}$ → $S_{ij}$ (anotado en `pendientes-coherencia.md`, a raíz del 3.A.9).
- 3.A.12 original: Slutsky con el primal de Segura, $h_i$, «efecto renta» y $\partial/\partial p$. Resuelto en la revisión (14/10/2026): «efecto escala» siempre, demandas condicionadas $\vec z(\vec w,q)$.
- 4.B.9 y 4.B.10 deben remitir a 3.A.9 (hoy no lo hacen); para la versión con dotación de tiempo, al 3.A.25 (anexo A).
- 3.A.25 original: tabla del anexo A.1 con filas de «demandante neto» de ocio ($O^*>O_0$, imposibles) y celdas con 2 signos, $O^h$. **Resuelto** en la revisión (31/10/2026).
- 3.A.9 original: «ecuación de Slusky», $s_{ij}$ y $\varepsilon^c_{ij}$; resuelto en la revisión.
