# Modelo de información imperfecta de Lucas (1972, 1973): islas de Phelps y curva de oferta de Lucas

- **Área:** pensamiento · **Tema de referencia:** 3.A.6 (La nueva macroeconomía clásica) — es el modelo fundacional de la NMC y combina expectativas racionales con neutralidad del dinero anticipado.
- **Temas que lo usan:** 3.A.6 (desarrollo), 3.A.37 (resumen: neutralidad del dinero anticipado; hoy desarrollo), 3.A.41 (mención; hoy desarrollo), 3.A.42 (resumen: ciclos nominales de equilibrio; hoy mención).
- **Manuales de referencia:** Lucas (1972), *JET* 4; Lucas (1973), *AER* 63; Phelps (1970); Romer (2019), cap. 6.9; Blanchard y Fischer (1989), cap. 7; Heijdra (2017), cap. 3; De Vroey (2016), cap. 9.

## Presentación de referencia

**Pregunta:** ¿por qué el dinero puede afectar a la producción si los agentes son racionales y los mercados se vacían?

**Supuestos:** productores en mercados separados («islas») que observan su precio p_i pero no el nivel general p; p_i = p + z_i, con z_i shock real (relativo) de media nula y varianza σ²_z, y p con varianza σ²_p; expectativas racionales; oferta de cada isla creciente en el precio relativo percibido, con elasticidad ε_S. Variables en logaritmos.

**Ecuaciones:** extracción de señal

$$E[z_i \mid p_i] = \omega\,(p_i - E[p]),\qquad \omega = \frac{\sigma^2_z}{\sigma^2_z + \sigma^2_p}$$

y la **curva de oferta de Lucas**, agregando islas:

$$y_t = y^n_t + \psi\,(p_t - p^e_t),\qquad \psi = \omega\,\varepsilon_S,\quad p^e_t \equiv E_{t-1}[p_t]$$

**Resultados:** solo la parte **no anticipada** de la política monetaria afecta a la producción; la pendiente ψ cae cuando sube la volatilidad nominal σ²_p (Lucas 1973: evidencia internacional, países con inflación volátil tienen curvas de oferta más verticales; Ball, Mankiw y Romer 1988 lo contrastan frente a la NEK). Base de la proposición de inefectividad (`sargent-wallace-inefectividad`).

**Gráfico de referencia:** no imprescindible; si se usa, plano (y, p) con la oferta de Lucas creciente que corta la vertical y^n en p = p^e y se desplaza con p^e.

## Cómo se adapta en cada tema

| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.6 | La NMC | Desarrollo | Supuestos, extracción de señal, curva de oferta, resultados y evidencia de Lucas (1973) | — |
| 3.A.37 | Transmisión monetaria | Resumen | Solo la parte no anticipada transmite; contraste con la NEK (rigideces) | La extracción de señal |
| 3.A.41 | Inflación | Mención | Inflación volátil → menor efecto real de la política; coste informativo de la inflación (confusión de precios relativos) | El modelo |
| 3.A.42 | Ciclos nominales y reales | Resumen | Ciclo nominal de equilibrio; por qué cayó (información sobre p disponible pronto; persistencia) | La derivación |

## Divergencias encontradas en el temario actual

- **θ** como coeficiente de extracción de señal (3.A.6, 3.A.37) choca con la CRRA θ que usan los mismos temas (RBC en 3.A.6, IS dinámica en 3.A.37): propuesta **ω** **[decidir]**.
- **β** como respuesta de la producción (3.A.6, 3.A.37, 3.A.41) choca con el factor de descuento: propuesta **ψ = ω·ε_S** **[decidir]**.
- **y_TNP** (3.A.6, 3.A.37, 3.A.41) para la producción natural: canon **y^n_t**.
- **3.A.6** escribe ω con varianzas «σ²_{p_i}» y «σ²_p» (varianza del precio de la isla y del nivel general), mientras que el resultado estándar usa la varianza del shock relativo σ²_z en el numerador: aclarar.
- **Desarrollo en tres temas** (3.A.6, 3.A.37, 3.A.41) con la misma ecuación: propuesta, desarrollo solo en 3.A.6.

Autor: Víctor Gutiérrez Marcos
