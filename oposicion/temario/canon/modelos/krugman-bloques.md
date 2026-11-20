# Bloques comerciales y bienestar mundial (Krugman, 1991)

- **Área:** comercio · **Tema de referencia:** **3.B.35** (Procesos de integración no comunitarios; revisado el 18/11/2026: `sec:escollo` con `fig:krugman` y el desarrollo en el anexo `anexo:krugman`, función clave `eq:krugman`). Ficha creada en la pasada final del canon (noviembre de 2026) a propuesta del 3.B.35 (**[decidir]**). Cita: Krugman (1991), «Is Bilateralism Bad?», en Helpman y Razin (eds.), *International Trade and Trade Policy* (`Krugman1991Bilateralism`).
- **Temas que lo usan:** 3.B.35 (desarrollo; hecho, 18/11/2026), 3.B.10 (mención; hecho, 5/11/2026: «con unos 3 bloques el bienestar mundial es mínimo», en el peldaño o escollo), 3.B.33 (mención posible, regionalismo). Ficha paraguas: `regionalismo`.
- **Manuales de referencia:** Krugman (1991); Frankel, Stein y Wei (1995) para los bloques naturales; Bhagwati, Panagariya y Srinivasan, cap. 31.

## Presentación de referencia (3.B.35, anexo `anexo:krugman`)

**Pregunta:** ¿mejora el bienestar mundial cuando el mundo se agrupa en menos bloques y más grandes?

**Supuestos:** un continuo de provincias iguales, cada una con un bien propio; CES entre todos los bienes, $\sigma>1$ (la de `notacion.md`; el parámetro $\theta=(\sigma-1)/\sigma$ de la CES es local del anexo: en el canon θ es la CRRA); $B$ bloques iguales, $s=1/B$; cada bloque fija un arancel exterior común de Nash.

**Desarrollo (4 pasos):** la distorsión ($c_{\text{fuera}}/c_{\text{dentro}}=(1+t)^{-\sigma}$); el arancel óptimo del bloque por la inversa de la elasticidad,
$$t^N\approx\frac{1}{(\sigma-1)(1-\tilde s)}$$
(`eq:krugman`, con $\tilde s$ el peso de los bienes del bloque en el gasto de los de fuera); los 2 efectos de tener menos bloques (más comercio libre dentro, arancel exterior más alto); y el Nash simétrico resuelto numéricamente (`tab:krugman`).

**Resultado:** el bienestar mundial cae al consolidarse los bloques hasta un mínimo en **unos 3 bloques** y solo con 1 vuelve al libre comercio. Lección: el problema no es el regionalismo, sino el arancel exterior. Crítica: con bloques «naturales» (costes de transporte), los bloques regionales desvían poco (Frankel, Stein y Wei, 1995).

**Gráfico de referencia:** `oposicion/temario/fuentes/3B35/graficos/krugman-bloques.tex` (`fig:krugman`, bienestar mundial frente al número de bloques; solución numérica en `fuentes/3B35/datos/krugman-bloques.csv`, con σ = 4).

**Notación:** $B$ número de bloques, $s=1/B$, $\tilde s$, $t^N$, $\tau$ los aranceles de los demás (local del anexo; en el canon τ es el coste iceberg: no conviven).

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.B.35 | Procesos de integración | desarrollo (hecho, 18/11/2026) | Interpretación en el cuerpo con el gráfico; el modelo en el anexo | — |
| 3.B.10 | Integración económica | mención (hecho, 5/11/2026) | «Con unos 3 bloques el bienestar mundial es mínimo» | El modelo |

## Divergencias encontradas en el temario actual
- Ninguna.

Autor: Víctor Gutiérrez Marcos
