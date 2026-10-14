# Estabilidad del equilibrio: ajuste walrasiano (precios) y marshalliano (cantidades)

- **Área:** mercados-información-juegos · **Tema de referencia:** 3.A.16 (Mercados I: dinámicas de ajuste y estabilidad)
- **Temas que lo usan:** 3.A.16 (desarrollo, equilibrio parcial), 3.A.21 (resumen del ajuste en un mercado en el anexo D; **desarrollo del tanteo multimercado**, II.1.3; hecho, 14/10/2026); la telaraña (3.A.16) es otra dinámica, con id propio.
- **Manuales de referencia:** Walras (1874); Marshall (1890); Samuelson (1941); Arrow, Block y Hurwicz (1959); Mas-Colell, Whinston y Green, cap. 17.H; Gandolfo, *Economic Dynamics*.

## Presentación de referencia
Exceso de demanda $z(p)=x(p)-q(p)$.
- Walrasiano (precios): $\dot p=f\big(z(p)\big)$, $f'>0$, $f(0)=0$; estable si $z'(p^*)<0$, es decir, si la pendiente de la oferta es mayor que la de la demanda en el plano $(q,p)$ con ambas medidas como $dq/dp$.
- Marshalliano (cantidades): $\dot q=g\big(p^D(q)-p^S(q)\big)$, $g'>0$; estable si el precio de demanda cae por debajo del de oferta a la derecha del equilibrio, $\frac{d}{dq}(p^D-p^S)<0$.
- Ambos coinciden con oferta creciente y demanda decreciente; difieren con oferta decreciente (economías externas) o demanda creciente (Giffen): con $a=dp^D/dq<0$ y $b=dp^S/dq<0$, Walras exige $1/a<1/b$ y Marshall $a<b$, incompatibles (tabla de color `tab:estabilidad-parcial` del 3.A.21: oferta más plana, Walras inestable y Marshall estable; oferta más inclinada, al revés).
- Equilibrio general (3.A.21, II.1.3, tema de referencia de esta parte): tanteo $\dot p_k=\kappa_k\,z_k(\vec p)$, $\kappa_k>0$ (caso lineal de $f_k$; $\kappa$ porque $k$ es el índice de los bienes); distancia al equilibrio (función de Liapunov) $\tfrac12\sum_k(p_k-p^*_k)^2/\kappa_k$, o $\lVert\vec p(t)-\vec p^*\rVert$ sin letra nueva, cuya derivada es $-\vec p^*\cdot\vec z(\vec p)$: estable si $\vec p^*\cdot\vec z(\vec p)>0$ fuera del equilibrio. Globalmente estable si todos los bienes son sustitutivos brutos (Arrow, Block y Hurwicz, 1959, tras Arrow y Hurwicz, 1958); con 2 bienes, estables los cortes de $z_X(p_X,1)$ de arriba abajo (índice $+1$); contraejemplo de Scarf (1960, 3 bienes complementarios); SMD: cualquier dinámica es posible; procesos sin tanteo (Varian, cap. 21) y enlace con el desequilibrio (3.A.4).
Gráficos de referencia: oferta con pendiente negativa más y menos inclinada que la demanda, con flechas de ajuste en precios (horizontal) y en cantidades (vertical): `oposicion/temario/fuentes/3A21/graficos/estabilidad-parcial.tex` (anexo D del 3.A.21; 3.A.16 debe reutilizarlo). Multimercado: `equilibrios-multiples.tex` del 3.A.21 con las flechas del tanteo (capas 5-6).

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.16 | Estabilidad en equilibrio parcial | desarrollo | Ambos ajustes, condiciones, gráficos, telaraña aparte | — |
| 3.A.21 | Estabilidad del EGC | desarrollo del tanteo multimercado; resumen del ajuste en un mercado (hecho, 14/10/2026) | II.1.3 con a)-e): tanteo con $\kappa_k$, distancia al equilibrio, Arrow-Block-Hurwicz, Scarf, procesos sin tanteo; la comparación walrasiano/marshalliano en un mercado va al anexo D con remisión a 3.A.16 | Los casos de equilibrio parcial en el cuerpo; la nota histórica del tanteo se queda en 3.A.21 (I.1) |

## Divergencias encontradas en el temario actual
- Nombres: «estabilidad walrasiana» y «marshalliana» se refieren aquí al **ajuste**; no confundir con demanda marshalliana (3.A.8): en 3.A.16 decir «ajuste walrasiano (por precios)» y «ajuste marshalliano (por cantidades)».
- 3.A.16 escribe $dp/dt=f(D(p)-S(p))$: canon $\dot p=f(z(p))$ con $z=x-q$ (en 3.A.21 $z$ es el exceso de demanda: misma letra).
- 3.A.16 (sin revisar) tiene la misma estabilidad que el 3.A.21 original (idea, Musgrave, ajustes, imágenes 8-9, tabla, nota del tanteo; «exceso de oferta negativo» en los dos) y una imagen con fuente «Tema 3A-21» de otro opositor: al revisarlo, desarrollar allí los dos ajustes con el gráfico `estabilidad-parcial` del 3.A.21 y acortar la nota histórica del tanteo, que va completa en 3.A.21 (I.1).
- Nombre de los precios del ajuste marshalliano: $p^d,p^s$ en esta ficha hasta el 14/10/2026; canon $p^D(q)$, $p^S(q)$ (3.A.21, `notacion.md` § 4).
