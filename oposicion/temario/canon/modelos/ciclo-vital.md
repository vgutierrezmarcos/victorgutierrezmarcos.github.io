# Hipótesis del ciclo vital (Modigliani y Brumberg, 1954; Ando y Modigliani, 1963)

- **Área:** macro cerrada · **Tema de referencia:** **3.A.33** (revisado el 31/10/2026: I.2.3 `sec:ciclo-vital`) — lo tiene en el título. Ficha creada en la fase canon del 3.A.33 (K25, **[decidir]**).
- **Temas que lo usan:** 3.A.33 (desarrollo; hecho, 31/10/2026), 3.A.29 (mención: las generaciones solapadas como versión de equilibrio general del ciclo vital, ficha `olg-samuelson-diamond`), 3.A.38 (mención: pensiones de reparto y ahorro), 4.B.24 (mención aplicada: envejecimiento, pensiones y ahorro), 4.B.10 (resumen: impuestos y ahorro a lo largo de la vida), 1D01 (mención aplicada; hecho: la estructura de edades como determinante del consumo, l. 424).
- **Manuales de referencia:** Modigliani y Brumberg (1954); Ando y Modigliani (1963), *AER*; Modigliani (1986), conferencia Nobel, *AER*; Romer (2019), cap. 8; Deaton (1992), *Understanding Consumption*; Attanasio y Weber (2010), *JEL*.

## Presentación de referencia (3.A.33, I.2.3)

Pregunta: ¿cómo cambian el consumo y el ahorro con la edad, y qué determina el ahorro agregado? Conclusión: el ahorro es el instrumento para suavizar el consumo a lo largo de la vida; la tasa de ahorro agregada depende del **crecimiento** (de la población y de la productividad), no del nivel de la renta. Estructura a)-d) (idea, modelo, evidencia, valoración).

- **Supuestos:** vida de T periodos, t = 1,…,T; trabaja los R primeros con renta laboral Y^L_t en **joroba** (baja, alta, nula desde la jubilación); certidumbre, mercado de capitales perfecto, sin herencias (b_1 = b_{T+1} = 0); β(1+r) = 1 y, para simplificar, r = ρ = 0: por la Euler (`eq:euler`, ficha `fisher-intertemporal`), el consumo es **plano** (creciente solo si r > ρ o por precaución).
- **Consumo individual** (`eq:ciclo-vital-individual`):
$$C_t=\frac{1}{T-t+1}\Big[\,b_t+\sum_{s=t}^{T}Y^L_s\Big];\qquad\text{al nacer, }C=\frac{1}{T}\sum_{s=1}^{T}Y^L_s.$$
- **Ahorro y riqueza**: se endeuda al principio, ahorra en la madurez y desahorra en la jubilación; b_t negativa al principio, máxima en R y nula en T.
- **Función agregada** de Ando y Modigliani (`eq:ciclo-vital`), con estructura por edades estable:
$$C_t=\alpha_L\,Y^L_t+\alpha_b\,b_t$$
- **Implicaciones:** resuelve el enigma de Kuznets (la propensión media depende de b_t/Y_t, que cae a corto plazo y es estable a largo); ahorro y crecimiento (Modigliani, 1986); demografía: el envejecimiento reduce el ahorro y presiona las pensiones (`\vertema{4.B.24}`); las OLG son su versión de equilibrio general (`\vertema{3.A.29}`); un cambio transitorio de renta pesa más cuanto mayor es el hogar; las pensiones públicas sustituyen ahorro privado.
- **Evidencia:** explica Kuznets y la relación crecimiento-ahorro entre países; pero los mayores desahorran poco y las herencias pesan (Kotlikoff y Summers, 1981); el consumo tiene joroba y sigue a la renta en los jóvenes (Carroll y Summers, 1991; Gourinchas y Parker, 2002, que ven ahorro de colchón hasta los 40 años y ciclo vital después; ficha `ahorro-precaucion`). Valoración: restricciones de liquidez, motivo herencia y precaución, información perfecta.

**Gráfico de referencia:** `oposicion/temario/fuentes/3A33/graficos/ciclo-vital.tex` (**imprescindible**): edad en abscisas, renta laboral en joroba hasta R, consumo plano, áreas de endeudamiento, ahorro y desahorro; panel inferior con los activos b_t (negativos, máximos en R, nulos en T). En la pizarra, debajo del plano (Y, C).

**Notación:** T fin de la vida y R jubilación (locales; R como superíndice es «reserva», § 1, no conviven), Y^L_t renta laboral, b_t activos netos (§ 7; en la agregada, los de todos los hogares), α_L y α_b locales. La propensión de Ando y Modigliani no lleva c (es la PMgC keynesiana).

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.33 | Teorías del consumo | desarrollo (hecho, 31/10/2026) | Todo lo anterior en 2′ con el gráfico | — |
| 3.A.29 | Modelización dinámica | mención | Las OLG de Samuelson y Diamond son el ciclo vital de 2 periodos en equilibrio general; remite al 3.A.33 | La función agregada y la evidencia |
| 3.A.38 | Política fiscal y gasto | mención | Pensiones de reparto y ahorro privado | El modelo |
| 4.B.24 | Pensiones | mención aplicada | Envejecimiento y ahorro; resumir en 2 líneas para cantarse sin el 3.º | La derivación |
| 4.B.10 | Impuestos y ahorro | resumen | Fiscalidad del ahorro a lo largo de la vida con el mismo perfil | La agregación |
| 1D01 | Dictamen | mención aplicada (hecho) | Población dependiente → más consumo en proporción a la renta (Leff, 1969) | La teoría |

## Divergencias encontradas en el temario actual
- 3.A.33 original: «el consumo es creciente a lo largo de la vida» y gráfico con el consumo inclinado; «toda la renta actual es permanente»; Modigliani y Ando (1960), no comprobada. **Resuelto** (31/10/2026): consumo plano con β(1+r) = 1, críticas estándar, Modigliani y Brumberg (1954) y Ando y Modigliani (1963).

Autor: Víctor Gutiérrez Marcos
