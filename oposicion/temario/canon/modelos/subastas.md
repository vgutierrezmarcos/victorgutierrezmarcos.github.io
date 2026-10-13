# Subastas

- **Área:** mercados-información-juegos · **Tema de referencia:** 3.A.14 (Teoría de juegos, con especial referencia a las subastas)
- **Temas que lo usan:** 3.A.14 (desarrollo), 4.A.19 (resumen: subastas de deuda del Tesoro); 3.B.37 o 4.A.6 (subastas de derechos de emisión) y 4.A.12 (espectro) podrían citarlo.
- **Manuales de referencia:** Vickrey (1961); Milgrom y Weber (1982); Krishna, *Auction Theory*; Klemperer (2004); Gibbons, cap. 3.

## Presentación de referencia
Un objeto, $n$ pujadores neutrales al riesgo, valores privados independientes $v_i\sim U[0,1]$; pujas $b_i$.
- Segundo precio (Vickrey) e inglesa: pujar $b_i=v_i$ es estrategia débilmente dominante; paga la segunda puja más alta.
- Primer precio y holandesa (estratégicamente equivalentes): equilibrio bayesiano simétrico $b_i=\frac{n-1}{n}v_i$ (con dos pujadores, $v_i/2$): $\max_{b_i}(v_i-b_i)\Pr(b_j(v_j)<b_i)$.
- **Equivalencia de ingresos** (Vickrey; Myerson, 1981): con valores privados independientes, neutralidad al riesgo y simetría, todos los formatos dan el mismo ingreso esperado.
- Valores comunes: maldición del ganador.
- Multiunidad: precio único (uniforme) frente a precio ofrecido (discriminatoria).

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.14 | Aplicación de juegos bayesianos | desarrollo | Formatos, equilibrios, equivalencia, valores comunes, multiunidad | — |
| 4.A.19 | Colocación de deuda pública | resumen | Subasta competitiva del Tesoro (precio medio ponderado, híbrida), peticiones no competitivas | Derivaciones (remitir a 3.A.14) |

## Divergencias encontradas en el temario actual
- 3.A.14 usa $\theta_1$ y $v_1$ para la misma valoración, y $\alpha_2$ sin definir (pendiente de la puja lineal del rival) mientras $\alpha$ es también probabilidad de tipo: canon $v_i$ valoración, $b_i=\beta_i v_i$ puja lineal.
- $v$ es a la vez función característica $v(S)$ y valoración: canon $v(T)$ en juegos cooperativos (o $\mathcal V$) solo si se mezclan en el mismo apartado; propuesta: función característica $v(T)$, valoración $v_i$ (los subíndices distinguen).
- Pago en segundo precio $\pi=v_i-b_j$ sin definir $j$: escribir $v_i-\max_{j\neq i}b_j$.
