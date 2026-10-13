# Función de coeficientes fijos (Leontief)

- **Área:** consumidor-producción · **Tema de referencia:** 3.A.11 (Teoría de la producción) — caso σ→0 de la CES.
- **Temas que lo usan:** 3.A.11 (resumen), 3.A.8 (resumen, como límite de la CES; sin id propio); **3.B.5 no**: allí es la *paradoja* de Leontief (1953), que es otro contenido. Canon: id propio `paradoja-leontief` (área comercio) en `alias.json`; este id queda en 3.A.11 y 3.A.8, y la tabla input-output (Leontief, 1941) va con su id (`input-output`).
- **Manuales de referencia:** Mas-Colell, Whinston y Green, cap. 5; Varian, cap. 1.
- **Decisión D087 (13/10/2026):** ¿Se separa la paradoja de Leontief de la función de coeficientes fijos? Sí: id propio `paradoja-leontief` (comercio) en `alias.json`; la tabla input-output con otro id

## Presentación de referencia
$$q=\min\left\{\frac{z_K}{a};\ \frac{z_L}{b}\right\},\qquad \sigma=0$$
Isocuantas en L con vértices sobre el rayo $z_K/z_L=a/b$; demandas condicionadas $z_K=aq$, $z_L=bq$; $C(w,q)=(a\,w_K+b\,w_L)\,q$. En utilidad (3.A.8): complementarios perfectos, $U=\min\{x_1/a;\,x_2/b\}$.
Gráfico de referencia: isocuantas en L (el mismo que el caso σ=0 de `oposicion/temario/fuentes/3A08/graficos/ces-curvas-indiferencia.tex`).

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.11 | Tecnología y σ | resumen | Forma, σ=0, límite de la CES, rendimientos constantes | — |
| 3.A.8 | Elasticidad de sustitución | mención | Complementarios perfectos; preferencias solo débilmente convexas | — |
| 3.B.5 | H-O | — | No es este modelo (paradoja de Leontief) | — |

## Divergencias encontradas en el temario actual
- Falso emparejamiento en el inventario: 3.B.5 (paradoja de Leontief).
- 3.A.11 lo presenta como caso exacto de la CES con σ=0: es un límite.
