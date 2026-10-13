# Ecuación de Slutsky

- **Área:** consumidor-producción · **Tema de referencia:** 3.A.9 (Demanda II: dualidad) — la ecuación se demuestra con la dualidad; 3.A.8 (revisado) la enuncia y la usa para clasificar bienes, con la derivación en anexo.
- **Temas que lo usan:** 3.A.9 (desarrollo), 3.A.8 (resumen), 3.A.12 (resumen: demanda de factores), 4.B.9 (resumen: con dotación), 4.B.10 y 4.B.11 (mención)
- **Manuales de referencia:** Slutsky (1915); Hicks y Allen (1934); Mas-Colell, Whinston y Green, cap. 2.F y 3.G; Varian, cap. 8 y 9 (con dotaciones).

## Presentación de referencia
Por dualidad, $h_i(p,\overline U)=x_i(p,E(p,\overline U))$; derivando:
$$\frac{\partial x_i}{\partial p_j}=\frac{\partial h_i}{\partial p_j}-x_j\frac{\partial x_i}{\partial\overline W}\qquad\Big(\varepsilon_{x_i,p_j}=\varepsilon^h_{x_i,p_j}-s_j\,\varepsilon_{x_i,\overline W}\Big)$$
Matriz de Slutsky $S=[\partial h_i/\partial p_j]$ simétrica y semidefinida negativa. Con dotación $\omega$ (oferta de trabajo, ahorro): $\frac{\partial x_i}{\partial p_j}=\frac{\partial h_i}{\partial p_j}+(\omega_j-x_j)\frac{\partial x_i}{\partial\overline W}$ (efecto renta dotación).
Gráfico de referencia: descomposición sustitución (A→B) y renta (B→C) con demandas marshalliana y hicksiana: `oposicion/temario/fuentes/3A08/graficos/efecto-sustitucion-renta.tex` (y `slutsky-propio.tex`, `slutsky-cruzado.tex`).

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.9 | Dualidad | desarrollo | Demostración, matriz, propiedades, integrabilidad | Clasificación de bienes (está en 3.A.8) |
| 3.A.8 | Estática comparativa | resumen | Enunciado, gráfico, normales/inferiores/Giffen | La demostración (anexo) |
| 3.A.12 | Demanda de factores | resumen | Efecto sustitución y efecto escala (output) ante cambio de $w_j$ | La versión del consumidor |
| 4.B.9 | Efecto renta y sustitución de los impuestos | resumen | Versión con dotación: efecto renta ordinario y efecto renta dotación (ocio, ahorro) | Demostración |
| 4.B.10, 4.B.11 | Incentivos, imposición óptima | mención | Exceso de gravamen ligado al efecto sustitución (demanda compensada) | — |

## Divergencias encontradas en el temario actual
- Sin divergencias de notación fuertes; 3.A.12 usa $w$ para precios de factores (canon) y debe llamar «efecto escala» o «efecto output» siempre igual (propuesta: efecto escala).
- 4.B.9 y 4.B.10 deben remitir a 3.A.9 (hoy no lo hacen).
