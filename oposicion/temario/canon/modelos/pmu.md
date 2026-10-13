# Problema de maximización de la utilidad (PMU)

- **Área:** consumidor-producción · **Tema de referencia:** 3.A.8 (Demanda I) — revisado; lo desarrolla y fija la notación.
- **Temas que lo usan:** 3.A.8 (desarrollo), 3.A.9 (resumen, como primal de la dualidad); lo reutilizan sin id propio 3.A.16 (cuasilineal), 3.A.21 (consumidor del equilibrio general), 3.A.25 (trabajo-ocio) y 3.A.29 (intertemporal).
- **Manuales de referencia:** Mas-Colell, Whinston y Green, cap. 2-3; Varian, cap. 7; Jehle y Reny (2011), cap. 1.

## Presentación de referencia
Supuestos: preferencias completas, transitivas, reflexivas, continuas, monótonas (insaciabilidad local), convexas (6′ estricta para unicidad), diferenciables; precios dados; renta $\overline W$; estática y certidumbre.
$$\max_{x}U(x)\quad\text{s.a.}\quad p\cdot x\le\overline W,\ x\ge 0$$
Kuhn-Tucker: $U_i-\lambda p_i\le 0$, $x_i(U_i-\lambda p_i)=0$. Solución interior: $\frac{U_1}{p_1}=\dots=\frac{U_n}{p_n}=\lambda$, $RMS_{12}=\frac{U_1}{U_2}=\frac{p_1}{p_2}$.
Solución: demanda marshalliana $x(p,\overline W)$ (homogénea de grado 0, ley de Walras) y FIU $V(p,\overline W)=U(x(p,\overline W))$; identidad de Roy $x_k=-\frac{\partial V/\partial p_k}{\partial V/\partial\overline W}$.
Gráficos de referencia: `oposicion/temario/fuentes/3A08/graficos/solucion-interior-esquina.tex`, `pmu-r3.tex`, `conjunto-presupuestario.tex`.

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.8 | De los axiomas a la demanda | desarrollo | Todo lo anterior | — |
| 3.A.9 | Dualidad | resumen | Enunciado del primal, FIU y sus propiedades, Roy; enlace con el PMG | Los axiomas y la solución de esquina |
| 3.A.16 | Demanda en equilibrio parcial | resumen | Variante cuasilineal $u_m=n_m+\varphi_m(x_m)$, $\varphi_m'(x_m)=p$ | Kuhn-Tucker general |
| 3.A.21 | Consumidor del EG | resumen | Renta = valor de la dotación $p\cdot\omega_h$ | — |

## Divergencias encontradas en el temario actual
- 3.A.9 atribuye la ley de Walras a la «estricta monotonía»: es la insaciabilidad local (3.A.8 revisado).
- 3.A.16 llama «walrasiana» a la demanda: canon «marshalliana» (título de 3.A.8); «walrasiana» solo como sinónimo una vez (3.A.8 ya lo hace) y para el **conjunto presupuestario walrasiano**.
- 3.A.8 usa $V$ también para la renta no laboral de Becker (incoherencia interna anotada; ya revisado: comprobar).
