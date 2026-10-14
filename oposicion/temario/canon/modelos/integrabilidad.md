# Integrabilidad de la demanda (recuperar las preferencias)

- **Área:** consumidor-producción · **Tema de referencia:** **3.A.9** (Demanda II: «Dualidad e integrabilidad de las preferencias»; revisado el 13/10/2026, III.1) — lo tiene en el título y lo desarrolla. Ficha creada a raíz de esa revisión.
- **Temas que lo usan:** 3.A.9 (desarrollo; hecho), 3.A.8 (mención: la vía de la preferencia revelada, ADPR y ADFPR, y la integrabilidad en la introducción; hecho), 3.A.12 (mención: recuperar la tecnología a partir de la función de costes; hecho).
- **Manuales de referencia:** Antonelli (1886); Hurwicz y Uzawa (1971); Mas-Colell, Whinston y Green, §3.H (prop. 3.H.1); Jehle y Reny (2011), teorema 2.6; Houthakker (1950); Kihlstrom, Mas-Colell y Sonnenschein (1976); Afriat (1967); Hausman (1981).

## Presentación de referencia
Pregunta: dado un sistema de demandas observado, ¿qué condiciones debe cumplir para proceder de maximizar una utilidad, y cómo se recupera esa utilidad?

- **Teorema**: $x(p,\overline W)$ continuamente diferenciable es la demanda de alguna utilidad creciente y cuasicóncava **si y solo si** cumple (1) la ley de Walras, $p\cdot x(p,\overline W)=\overline W$; (2) la simetría de la matriz de Slutsky construida con observables,
$$S_{ij}(p,\overline W)=\frac{\partial x_i}{\partial p_j}+x_j\frac{\partial x_i}{\partial\overline W}=S_{ji}(p,\overline W);$$
(3) la negatividad ($S$ semidefinida negativa). Son necesarias (toda demanda racional las cumple) y suficientes (lo que demuestra el teorema); los manuales añaden la homogeneidad de grado cero, también necesaria. Con dos bienes, la simetría es automática ($p^\top S=0$ y $Sp=0$): la integrabilidad solo restringe con tres bienes o más.
- **Intuición de la demostración** (por dualidad, Hurwicz y Uzawa): (i) de la demanda a la función de gasto, resolviendo $\nabla_pE(p,\overline U)=x\big(p,E(p,\overline U)\big)$ con $E(p^0,\overline U)=\overline W^0$; por el **teorema de Frobenius** (no «Rouché-Frobenius») tiene solución si y solo si las derivadas cruzadas coinciden, que es la simetría; (ii) que sea función de gasto exige concavidad, es decir, negatividad; (iii) de $E$ a $V$ invirtiendo $E(p,V)=\overline W$, y de $V$ a $U$:
$$U(x^0)=\min_{(p,\overline W)}V(p,\overline W)\quad\text{s.a.}\quad p\cdot x^0\le\overline W.$$
- **Versión sin derivadas**: preferencia revelada [3.A.8]; el ADPR da negatividad pero no simetría; el axioma fuerte (Houthakker) garantiza preferencias que racionalizan la demanda; Afriat para datos finitos.
- **Relevancia**: teórica (cierra el círculo: las preferencias inobservables no añaden nada a tres propiedades contrastables), empírica (es lo que se contrasta al estimar un AIDS, ficha `sistemas-demanda`) y normativa (recuperar $E$ y medir el bienestar exactamente, Hausman, 1981).

Gráfico de referencia: `oposicion/temario/fuentes/3A09/graficos/recuperar-utilidad.tex` (la curva de indiferencia como envolvente de las rectas de balance con las que $x^0$ es asequible).

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.9 | Integrabilidad de las preferencias | desarrollo (hecho, 13/10/2026) | Todo lo anterior (3 minutos en el cante) | La preferencia revelada en detalle (3.A.8) |
| 3.A.8 | Fundamentos y otros desarrollos | mención (hecho) | Preferencia revelada (ADPR, ADFPR, Afriat) como versión sin derivadas; la integrabilidad se estudia en 3.A.9 | El teorema |
| 3.A.12 | Dualidad de la empresa | mención (hecho, 14/10/2026: I.3.1, $V^*(q)$ y caja de anotaciones; ficha `dualidad-produccion`) | Recuperar la tecnología a partir de $C(w,q)$ (Shephard, McFadden): mismas condiciones, con $C$ cóncava en $w$ | El teorema del consumidor |

## Divergencias encontradas en el temario actual
- 3.A.9 original: «teorema de Rouché-Frobenius» (con un vídeo sobre sistemas lineales), «si y solo si» frente a «condición suficiente, pero no necesaria», Antonelli «de la Escuela de Lausana». Resuelto en la revisión.
